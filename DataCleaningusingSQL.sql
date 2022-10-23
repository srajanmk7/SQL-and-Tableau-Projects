Select * from Datacleaning..NashvilleHousing

--------------------------------------------------------------------------------------

--Correct formatting of the Sales Date format
select SaleDate, CONVERT(date,SaleDate) as Sales_date
from Datacleaning..NashvilleHousing --Current Format

Alter Table Datacleaning..NashvilleHousing  
Add SaleDateCorrected Date;

Update Datacleaning..NashvilleHousing
SET SaleDateCorrected = CONVERT(DATE,SaleDate)

select SaleDateCorrected
from
Datacleaning..NashvilleHousing --Corrected format

--------------------------------------------------------------------------------------

--Address is not in the correct format, let's place it into indiviual columns

select PropertyAddress
from 
Datacleaning..NashvilleHousing --Checking the format

select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)) as Address
from Datacleaning..NashvilleHousing

select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1) as Address
from Datacleaning..NashvilleHousing --Getting rid of commas

select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress) -1) as Address
from Datacleaning..NashvilleHousing 

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 ,
LEN(PropertyAddress)) as City
From Datacleaning..NashvilleHousing 

ALTER TABLE Datacleaning..NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update Datacleaning..NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress,
1, CHARINDEX(',', PropertyAddress) -1 )

select * from Datacleaning..NashvilleHousing;

ALTER TABLE Datacleaning..NashvilleHousing
Add Where_City varchar(255); --Adding new column

Update Datacleaning..NashvilleHousing
SET Where_City = SUBSTRING(PropertyAddress,
CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))

Select OwnerAddress
From Datacleaning..NashvilleHousing 

Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
From Datacleaning..NashvilleHousing

Select 
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
From Datacleaning..NashvilleHousing

Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From Datacleaning..NashvilleHousing

ALTER TABLE Datacleaning..NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update Datacleaning..NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)

ALTER TABLE Datacleaning..NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update Datacleaning..NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)

ALTER TABLE Datacleaning..NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update Datacleaning..NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

Select * From Datacleaning..NashvilleHousing 

--------------------------------------------------------------------------------------

-- In the 'Sold as vacant' column, let's change 'Y' to Yes and 'N' to no

select SoldAsVacant from Datacleaning..NashvilleHousing where SoldAsVacant = 'N'

Select Distinct(SoldAsVacant), Count(SoldAsVacant) as total_Count
From Datacleaning..NashvilleHousing
Group by SoldAsVacant
order by 2

Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From Datacleaning..NashvilleHousing

Update Datacleaning..NashvilleHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END

--------------------------------------------------------------------------------------

-- Delete Unused Columns

Select *
From Datacleaning..NashvilleHousing


ALTER TABLE Datacleaning..NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate


Select *
From Datacleaning..NashvilleHousing
--------------------------------------------------------------------------------------
