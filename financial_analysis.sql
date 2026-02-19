-- Create and Use the Database
CREATE DATABASE BankLoan;
USE BankLoan;

-- View Data
SELECT * FROM bankloan.loan;
    
-- =========================================================
-- A. Basic KPIs (Key Performance Indicators)
-- =========================================================

-- 1. Total Loan Applications
SELECT 
    COUNT(DISTINCT id) AS Total_Applications
FROM bankloan.loan;
    
-- 2. Total Funded Amount
SELECT 
    SUM(loan_amount) AS Total_Funded_Amount
FROM bankloan.loan;
    
-- 3. Average Interest Rate
SELECT 
    ROUND(AVG(interest), 2) AS Average_Interest_Rate
FROM bankloan.loan;

-- =========================================================
-- B. Risk Analysis & Portfolio Health
-- =========================================================

-- 4. Good vs. Bad Loans Count
SELECT 
    loan_condition,
    COUNT(*) AS Total_Loans
FROM bankloan.loan
GROUP BY loan_condition;

-- 5. Good vs Bad Percentage Breakdown
SELECT 
    loan_condition,
    COUNT(*) AS Total_Loans,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM bankloan.loan), 2) AS Portfolio_Percentage
FROM bankloan.loan
GROUP BY loan_condition;

-- 6. Total Loan Amount by Condition
SELECT 
    loan_condition,
    SUM(loan_amount) AS Total_Amount_Funded
FROM bankloan.loan
GROUP BY loan_condition;

-- 7. Home Ownership Portfolio Distribution
SELECT 
    home_ownership,
    COUNT(*) AS Total_Applicants,
    SUM(loan_amount) AS Total_Amount,
    ROUND(SUM(loan_amount) * 100.0 / (SELECT SUM(loan_amount) FROM bankloan.loan), 2) AS Percentage_of_Portfolio
FROM bankloan.loan
GROUP BY home_ownership;

-- =========================================================
-- C. Detailed Financial Grid & Segmentation
-- =========================================================

-- 8. Loan Status Grid (Financial Overview)
SELECT 
    loan_condition,
    SUM(loan_amount) AS Total_Funded,
    SUM(total_pymnt) AS Total_Payments_Received,
    SUM(total_rec_prncp) AS Principle_Received,
    SUM(loan_amount) - SUM(total_pymnt) AS Balance_Remaining,
    ROUND(AVG(interest), 2) AS Avg_Interest_Rate
FROM bankloan.loan
GROUP BY loan_condition;

-- 9. Regional Analysis (Highest to Lowest Loan Demand)
SELECT 
    region,
    SUM(loan_amount) AS Total_Loan_Volume
FROM bankloan.loan
GROUP BY region
ORDER BY Total_Loan_Volume DESC;

-- 10. Term Analysis (Interest Rate Comparison)
SELECT
    term,
    ROUND(AVG(interest), 2) AS Avg_Interest_Rate
FROM bankloan.loan
GROUP BY term;