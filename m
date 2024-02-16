Return-Path: <linux-kernel+bounces-68507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C6B857B63
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 318DEB213E9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD53B59B62;
	Fri, 16 Feb 2024 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orxKIWYP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B9F5C901;
	Fri, 16 Feb 2024 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082326; cv=none; b=Mexbe18rsjKiJlQtd7j/oO6JPVPxPEhO9MBPjs6smyOBtt8rpH14UsOzNMkx8gjJLsY6pHn5mq9vJKRWTlu29gOUdKcW5jpa+gXrYtKBb2uSmZPEIR6w2eMXrw7dzi0enSeBtmArNavfzKfcwWjEEo3prRY/2+hx3NZ/veXVS3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082326; c=relaxed/simple;
	bh=S1EkBA52eWhaCecQGNHtZp9xi5qzrdx3y2uZlJXx0L4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9MfyeOVGo5sHhxC0Rqs85fC95qo9aoyF7EZS+IQPjvAjpEtWweIYlFurTP2qGIaSmlHWx1RwQVY0dIFfcLXvoCoGB2CJeumBVgLXWYwl9rBdHyziAa+/PalgFYXF5HrZ4fzFZWCYhsQ3Juoe/qxbBn/SVxNOMPBrd/PQR9qPcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orxKIWYP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E20CC433C7;
	Fri, 16 Feb 2024 11:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708082326;
	bh=S1EkBA52eWhaCecQGNHtZp9xi5qzrdx3y2uZlJXx0L4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=orxKIWYP6UjpVOwSkbQiwr3P3yVygztXW3iYoqxagKICMU/E5/BgwSs0K1fkri3c8
	 pQsVtkNrlkU8XDxks5+LX4of4hAX0fOxzInTofeZOOpdsLHZd5kdFgl0EkpEZAKQ94
	 ds3GObj+h43xzhR527WpNmrPJGya9oAE5ca5GNNx+5L2neKkg3IX7WGq4d8jWC/YKs
	 8m7CHsTFjXPzKtye4A+U0OhqzpRDDuWvictq5jrl84c3jF+Rp9re5btlDW89U4a6J1
	 Ucfsf+R1upYuQJCmlGTog5bd/Wx6Xgoo2UrJsL+CoYuiq0IXUmps+yjEK/eujEl7MC
	 SF5u87xE+3eug==
Date: Fri, 16 Feb 2024 11:18:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, ang.iglesiasg@gmail.com,
 andriy.shevchenko@linux.intel.com, 579lpy@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: pressure: Add SPI support for BMP38x and
 BMP390
Message-ID: <20240216111834.73287ab0@jic23-huawei>
In-Reply-To: <20240215164332.506736-1-vassilisamir@gmail.com>
References: <20240215164332.506736-1-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 17:43:32 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> According to the datasheet of BMP38x and BMP390 devices, in SPI
> operation, the first byte that returns after a read operation is
> garbage and it needs to be dropped and return the rest of the
> bytes.

Make it clear in the patch title that this is a fix and add a fixes tag.

> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/pressure/bmp280-spi.c | 47 ++++++++++++++++++++++++++++++-
>  drivers/iio/pressure/bmp280.h     |  2 ++
>  2 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
> index 433d6fac83c4..c4b4a5d67f94 100644
> --- a/drivers/iio/pressure/bmp280-spi.c
> +++ b/drivers/iio/pressure/bmp280-spi.c
> @@ -35,6 +35,32 @@ static int bmp280_regmap_spi_read(void *context, const void *reg,
>  	return spi_write_then_read(spi, reg, reg_size, val, val_size);
>  }
>  
> +static int bmp380_regmap_spi_read(void *context, const void *reg,
> +				  size_t reg_size, void *val, size_t val_size)
> +{
> +	struct spi_device *spi = to_spi_device(context);
> +	u8 ret[BMP380_SPI_MAX_REG_COUNT_READ + 1];

Given you rely on val_size < 3 you should check for that explcitly rather than
potentially overflowing the buffer.
ret is not a good naming choice for this variable as it's commonly used for
integer return values.  Call it read_buf or something like that.

> +	ssize_t status;
> +	u8 buf;
> +
> +	memcpy(&buf, reg, reg_size);
> +	buf |= 0x80;

Can you use regmap_bus read_flag_mask for this?  Seems to apply to 
all devices supported. + that's common for spi regmaps


Mind you I note the bmp280_regmap_spi_write() is masking the bit out which seems
backwards  - all the registers are defined with the bit set for that part
but not the 380.  Ah well - not part of this fix even if it's odd.


> +
> +	/*
> +	 * According to the BMP380, BMP388, BMP390 datasheets, for a basic
> +	 * read operation, after the write is done, 2 bytes are received and
> +	 * the first one has to be dropped. The 2nd one is the requested
> +	 * value.
> +	 */
> +	status = spi_write_then_read(spi, &buf, 1, ret, val_size + 1);
> +	if (status)
> +		return status;
> +
> +	memcpy(val, ret + 1, val_size);
> +
> +	return 0;
> +}
> +
>  static struct regmap_bus bmp280_regmap_bus = {
>  	.write = bmp280_regmap_spi_write,
>  	.read = bmp280_regmap_spi_read,
> @@ -42,10 +68,18 @@ static struct regmap_bus bmp280_regmap_bus = {
>  	.val_format_endian_default = REGMAP_ENDIAN_BIG,
>  };
>  
> +static struct regmap_bus bmp380_regmap_bus = {
> +	.write = bmp280_regmap_spi_write,
> +	.read = bmp380_regmap_spi_read,
> +	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
> +	.val_format_endian_default = REGMAP_ENDIAN_BIG,
> +};
> +
>  static int bmp280_spi_probe(struct spi_device *spi)
>  {
>  	const struct spi_device_id *id = spi_get_device_id(spi);
>  	const struct bmp280_chip_info *chip_info;
> +	struct regmap_bus *bmp_regmap_bus;
>  	struct regmap *regmap;
>  	int ret;
>  
> @@ -58,8 +92,19 @@ static int bmp280_spi_probe(struct spi_device *spi)
>  
>  	chip_info = spi_get_device_match_data(spi);
>  
> +	switch (chip_info->chip_id[0]) {
> +	case BMP380_CHIP_ID:
> +	case BMP390_CHIP_ID:
> +		bmp_regmap_bus = &bmp380_regmap_bus;
> +		break;
> +	default:
> +		bmp_regmap_bus = &bmp280_regmap_bus;
> +		break;
> +	}
> +
> +
>  	regmap = devm_regmap_init(&spi->dev,
> -				  &bmp280_regmap_bus,
> +				  bmp_regmap_bus,
>  				  &spi->dev,
>  				  chip_info->regmap_config);
>  	if (IS_ERR(regmap)) {
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index 4012387d7956..ca482b7e4295 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -191,6 +191,8 @@
>  #define BMP380_TEMP_SKIPPED		0x800000
>  #define BMP380_PRESS_SKIPPED		0x800000
>  
> +#define BMP380_SPI_MAX_REG_COUNT_READ   3
This doesn't seem useful as only used in one place.
> +
>  /* BMP280 specific registers */
>  #define BMP280_REG_HUMIDITY_LSB		0xFE
>  #define BMP280_REG_HUMIDITY_MSB		0xFD


