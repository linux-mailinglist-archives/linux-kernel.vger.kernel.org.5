Return-Path: <linux-kernel+bounces-142170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CCA8A286A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C488C1C23E53
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CE55027B;
	Fri, 12 Apr 2024 07:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBoPVn5u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A335026B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907828; cv=none; b=qxQw4RNZXgqPHJGf8TaFUi3pdyDVsxXa7C1AthKKJLiF8pr107ay58LkMFK6kOTQlcyHmAiTgizpqEeRiGx3J7m3UwfjVbmxkgMvVoNEl3mQKF6Wc18KsNqFlyjj/Mmo5H8G/DobFznIK+DcKvGLFC93Th+fJh09jOpRzbXQHkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907828; c=relaxed/simple;
	bh=Lp7pujWU1SN5Yqh9R8ylDr89ozBe25tKE3JyBV77E7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tG7qfo6E/R69/hcxRol/iSo4l24NlYmkBczlADKesQCouiYq4UE/8UUzO636sifl/IB9wYVmFFMZv80T1F67Y7/xVV2k01vlDwHK735fYnYQ2h+8ddWA76uYuDBUMFhwIY3fizWHef1UkLS9rzWX6yETRJr/q276kqnpIUK0KkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBoPVn5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9366C113CC;
	Fri, 12 Apr 2024 07:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712907827;
	bh=Lp7pujWU1SN5Yqh9R8ylDr89ozBe25tKE3JyBV77E7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tBoPVn5u4UF6/IrlxJ5DcGxNC8SdCBB8SE4n6Jh2ipU7Spya/vvL6MDt1n4e9buG4
	 pinExls7ZCDSDUY6Ol6xrKgltUIT7ysgdnv7vdAzaMUzPRkLBeaWdFn5oLb7oVvBCB
	 +3J9dsgBu/Q5MnzryrIBDCbxlPxHS5oUSmsgriViQ1WGwgqAFdStwfBvLbbq8iQrtS
	 TxOOkdMD11Ujoah2noeLjpSWaKhrQ9k2Vt2rqLfIyQnx2cu8WEYRZdeFKDkyDKIlbu
	 9hxbGrTF2y7L4UQ1NDMjeFZMqb/YoEn1jb7AwuYcNNmWqeyx/dNlkbG+iq25PoFktG
	 WV57slUx61h6g==
Date: Fri, 12 Apr 2024 08:43:44 +0100
From: Lee Jones <lee@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: linux-kernel@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH mfd v1 1/2] mfd: rsmu: support I2C SMBus access
Message-ID: <20240412074344.GQ2399047@google.com>
References: <LV3P220MB12022B2F96505825BDDE6A2AA0052@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <LV3P220MB12022B2F96505825BDDE6A2AA0052@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>

On Thu, 11 Apr 2024, Min Li wrote:

> From: Min Li <min.li.xe@renesas.com>
> 
> 8a3400x device implements its own reg_read and reg_write,
> which only supports I2C bus access. This patch adds support
> for SMBus access.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
> send the patch series as --thread suggested by Lee

These are still not connected.

>  drivers/mfd/rsmu_i2c.c | 107 +++++++++++++++++++++++++++++++++++------
>  drivers/mfd/rsmu_spi.c |   8 +--
>  2 files changed, 97 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mfd/rsmu_i2c.c b/drivers/mfd/rsmu_i2c.c
> index 5711e512b..cba64f107 100644
> --- a/drivers/mfd/rsmu_i2c.c
> +++ b/drivers/mfd/rsmu_i2c.c
> @@ -32,6 +32,8 @@
>  #define	RSMU_SABRE_PAGE_ADDR		0x7F
>  #define	RSMU_SABRE_PAGE_WINDOW		128
>  
> +typedef int (*rsmu_rw_device)(struct rsmu_ddata *rsmu, u8 reg, u8 *buf, u8 bytes);
> +
>  static const struct regmap_range_cfg rsmu_sabre_range_cfg[] = {
>  	{
>  		.range_min = 0,
> @@ -54,7 +56,28 @@ static bool rsmu_sabre_volatile_reg(struct device *dev, unsigned int reg)
>  	}
>  }
>  
> -static int rsmu_read_device(struct rsmu_ddata *rsmu, u8 reg, u8 *buf, u16 bytes)
> +static int rsmu_smbus_i2c_write_device(struct rsmu_ddata *rsmu, u8 reg, u8 *buf, u8 bytes)
> +{
> +	struct i2c_client *client = to_i2c_client(rsmu->dev);
> +
> +	return i2c_smbus_write_i2c_block_data(client, reg, bytes, buf);
> +}
> +
> +static int rsmu_smbus_i2c_read_device(struct rsmu_ddata *rsmu, u8 reg, u8 *buf, u8 bytes)
> +{
> +	struct i2c_client *client = to_i2c_client(rsmu->dev);
> +	int ret;
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, reg, bytes, buf);
> +	if (ret == bytes)
> +		return 0;
> +	else if (ret < 0)
> +		return ret;
> +	else
> +		return -EIO;
> +}
> +
> +static int rsmu_i2c_read_device(struct rsmu_ddata *rsmu, u8 reg, u8 *buf, u8 bytes)
>  {
>  	struct i2c_client *client = to_i2c_client(rsmu->dev);
>  	struct i2c_msg msg[2];
> @@ -84,10 +107,11 @@ static int rsmu_read_device(struct rsmu_ddata *rsmu, u8 reg, u8 *buf, u16 bytes)
>  	return 0;
>  }
>  
> -static int rsmu_write_device(struct rsmu_ddata *rsmu, u8 reg, u8 *buf, u16 bytes)
> +static int rsmu_i2c_write_device(struct rsmu_ddata *rsmu, u8 reg, u8 *buf, u8 bytes)
>  {
>  	struct i2c_client *client = to_i2c_client(rsmu->dev);
> -	u8 msg[RSMU_MAX_WRITE_COUNT + 1]; /* 1 Byte added for the device register */
> +	/* we add 1 byte for device register */
> +	u8 msg[RSMU_MAX_WRITE_COUNT + 1];
>  	int cnt;
>  
>  	if (bytes > RSMU_MAX_WRITE_COUNT)
> @@ -107,7 +131,8 @@ static int rsmu_write_device(struct rsmu_ddata *rsmu, u8 reg, u8 *buf, u16 bytes
>  	return 0;
>  }
>  
> -static int rsmu_write_page_register(struct rsmu_ddata *rsmu, u32 reg)
> +static int rsmu_write_page_register(struct rsmu_ddata *rsmu, u32 reg,
> +				    rsmu_rw_device rsmu_write_device)
>  {
>  	u32 page = reg & RSMU_CM_PAGE_MASK;
>  	u8 buf[4];
> @@ -136,35 +161,35 @@ static int rsmu_write_page_register(struct rsmu_ddata *rsmu, u32 reg)
>  	return err;
>  }
>  
> -static int rsmu_reg_read(void *context, unsigned int reg, unsigned int *val)
> +static int rsmu_i2c_reg_read(void *context, unsigned int reg, unsigned int *val)
>  {
>  	struct rsmu_ddata *rsmu = i2c_get_clientdata((struct i2c_client *)context);
>  	u8 addr = (u8)(reg & RSMU_CM_ADDRESS_MASK);
>  	int err;
>  
> -	err = rsmu_write_page_register(rsmu, reg);
> +	err = rsmu_write_page_register(rsmu, reg, rsmu_i2c_write_device);
>  	if (err)
>  		return err;
>  
> -	err = rsmu_read_device(rsmu, addr, (u8 *)val, 1);
> +	err = rsmu_i2c_read_device(rsmu, addr, (u8 *)val, 1);
>  	if (err)
>  		dev_err(rsmu->dev, "Failed to read offset address 0x%x\n", addr);
>  
>  	return err;
>  }
>  
> -static int rsmu_reg_write(void *context, unsigned int reg, unsigned int val)
> +static int rsmu_i2c_reg_write(void *context, unsigned int reg, unsigned int val)
>  {
>  	struct rsmu_ddata *rsmu = i2c_get_clientdata((struct i2c_client *)context);
>  	u8 addr = (u8)(reg & RSMU_CM_ADDRESS_MASK);
>  	u8 data = (u8)val;
>  	int err;
>  
> -	err = rsmu_write_page_register(rsmu, reg);
> +	err = rsmu_write_page_register(rsmu, reg, rsmu_i2c_write_device);
>  	if (err)
>  		return err;
>  
> -	err = rsmu_write_device(rsmu, addr, &data, 1);
> +	err = rsmu_i2c_write_device(rsmu, addr, &data, 1);
>  	if (err)
>  		dev_err(rsmu->dev,
>  			"Failed to write offset address 0x%x\n", addr);
> @@ -172,12 +197,57 @@ static int rsmu_reg_write(void *context, unsigned int reg, unsigned int val)
>  	return err;
>  }
>  
> -static const struct regmap_config rsmu_cm_regmap_config = {
> +static int rsmu_smbus_i2c_reg_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct rsmu_ddata *rsmu = i2c_get_clientdata((struct i2c_client *)context);
> +	u8 addr = (u8)(reg & RSMU_CM_ADDRESS_MASK);
> +	int err;
> +
> +	err = rsmu_write_page_register(rsmu, reg, rsmu_smbus_i2c_write_device);
> +	if (err)
> +		return err;
> +
> +	err = rsmu_smbus_i2c_read_device(rsmu, addr, (u8 *)val, 1);
> +	if (err)
> +		dev_err(rsmu->dev, "Failed to read offset address 0x%x\n", addr);
> +
> +	return err;
> +}
> +
> +static int rsmu_smbus_i2c_reg_write(void *context, unsigned int reg, unsigned int val)
> +{
> +	struct rsmu_ddata *rsmu = i2c_get_clientdata((struct i2c_client *)context);
> +	u8 addr = (u8)(reg & RSMU_CM_ADDRESS_MASK);
> +	u8 data = (u8)val;
> +	int err;
> +
> +	err = rsmu_write_page_register(rsmu, reg, rsmu_smbus_i2c_write_device);
> +	if (err)
> +		return err;
> +
> +	err = rsmu_smbus_i2c_write_device(rsmu, addr, &data, 1);
> +	if (err)
> +		dev_err(rsmu->dev,
> +			"Failed to write offset address 0x%x\n", addr);
> +
> +	return err;
> +}
> +
> +static const struct regmap_config rsmu_i2c_cm_regmap_config = {
>  	.reg_bits = 32,
>  	.val_bits = 8,
>  	.max_register = 0x20120000,
> -	.reg_read = rsmu_reg_read,
> -	.reg_write = rsmu_reg_write,
> +	.reg_read = rsmu_i2c_reg_read,
> +	.reg_write = rsmu_i2c_reg_write,
> +	.cache_type = REGCACHE_NONE,
> +};
> +
> +static const struct regmap_config rsmu_smbus_i2c_cm_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 8,
> +	.max_register = 0x20120000,
> +	.reg_read = rsmu_smbus_i2c_reg_read,
> +	.reg_write = rsmu_smbus_i2c_reg_write,
>  	.cache_type = REGCACHE_NONE,
>  };
>  
> @@ -219,7 +289,15 @@ static int rsmu_i2c_probe(struct i2c_client *client)
>  
>  	switch (rsmu->type) {
>  	case RSMU_CM:
> -		cfg = &rsmu_cm_regmap_config;
> +		if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> +			cfg = &rsmu_i2c_cm_regmap_config;
> +		} else if (i2c_check_functionality(client->adapter,
> +						   I2C_FUNC_SMBUS_I2C_BLOCK)) {
> +			cfg = &rsmu_smbus_i2c_cm_regmap_config;
> +		} else {
> +			dev_err(rsmu->dev, "Unsupported i2c adapter\n");
> +			return -ENOTSUPP;
> +		}
>  		break;
>  	case RSMU_SABRE:
>  		cfg = &rsmu_sabre_regmap_config;
> @@ -236,6 +314,7 @@ static int rsmu_i2c_probe(struct i2c_client *client)
>  		rsmu->regmap = devm_regmap_init(&client->dev, NULL, client, cfg);
>  	else
>  		rsmu->regmap = devm_regmap_init_i2c(client, cfg);
> +
>  	if (IS_ERR(rsmu->regmap)) {
>  		ret = PTR_ERR(rsmu->regmap);
>  		dev_err(rsmu->dev, "Failed to allocate register map: %d\n", ret);
> diff --git a/drivers/mfd/rsmu_spi.c b/drivers/mfd/rsmu_spi.c
> index ca0a1202c..39d9be1e1 100644
> --- a/drivers/mfd/rsmu_spi.c
> +++ b/drivers/mfd/rsmu_spi.c
> @@ -106,10 +106,10 @@ static int rsmu_write_page_register(struct rsmu_ddata *rsmu, u32 reg)
>  			return 0;
>  		page_reg = RSMU_CM_PAGE_ADDR;
>  		page = reg & RSMU_PAGE_MASK;
> -		buf[0] = (u8)(page & 0xff);
> -		buf[1] = (u8)((page >> 8) & 0xff);
> -		buf[2] = (u8)((page >> 16) & 0xff);
> -		buf[3] = (u8)((page >> 24) & 0xff);
> +		buf[0] = (u8)(page & 0xFF);
> +		buf[1] = (u8)((page >> 8) & 0xFF);
> +		buf[2] = (u8)((page >> 16) & 0xFF);
> +		buf[3] = (u8)((page >> 24) & 0xFF);
>  		bytes = 4;
>  		break;
>  	case RSMU_SABRE:
> -- 
> 2.39.2
> 

-- 
Lee Jones [李琼斯]

