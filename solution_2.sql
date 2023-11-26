USE interview_prep;

-- Import thr necessary Tables --

-- Check the Imported Tables --

SELECT *
FROM customers_table;

SELECT *
FROM orders_table;

SELECT *
FROM products_table;

-- Solution --

SELECT *
FROM customers_table c
JOIN orders_table o
	USING (customer_id)
JOIN products_table p
USING (product_id);

CREATE TABLE total_1 (

SELECT c.customer_id, p.product_id, p.product_name, COUNT(*) AS 'total'
FROM customers_table c
JOIN orders_table o
	USING (customer_id)
JOIN products_table p
USING (product_id)
GROUP BY 1,2,3
ORDER BY 1,4 DESC
);


SELECT *
FROM total_1;

CREATE TABLE final
(
SELECT customer_id, product_id, product_name,
	   DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY total DESC) AS 'rnk'
FROM total_1
);

SELECT customer_id, product_id, product_name
FROM final
WHERE rnk = 1;
