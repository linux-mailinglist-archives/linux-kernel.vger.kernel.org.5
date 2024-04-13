Return-Path: <linux-kernel+bounces-143815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB5F8A3DC8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 18:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D5B1C20D13
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 16:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315F545020;
	Sat, 13 Apr 2024 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uopv4utC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159AB18039;
	Sat, 13 Apr 2024 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713027194; cv=none; b=MdTY3SJ66BauBSg9ovdd9aYRAnnwUN7OeZ/yUHk1FDy7+dMnkPZL5IYjcYnbWvdS5ozV1rIjdWUqANXM/JnYLKW7xvfbwUFoAp4vfnZubCN7mqbf/OU9FVbYtXm9BBfdDDNCOkoaFp8xqoeYw4qnFkIo2wvLFwhyQ7I4hfB3HZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713027194; c=relaxed/simple;
	bh=FdjodNfj7LsYMwGIT8huEhYxs1Pn6bxh85ehXKIZlcg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odTMknvmjcK7/T4OoEm83sZHWiqNrdh4GkZwi7i0kjZnbpS/PGz7RC5EL5z+lmDnbFbNCjiXi14w+KSxmlPuTbe39kUsbrrKsh5aYHQd30mRDu95tMzQqZTW1pvGXogHYSkYEKEkIiUGFIess3X3DvOyhzYJxSn1lkSnHg302H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uopv4utC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C388C113CD;
	Sat, 13 Apr 2024 16:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713027193;
	bh=FdjodNfj7LsYMwGIT8huEhYxs1Pn6bxh85ehXKIZlcg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Uopv4utCLYWQ0DWTZWc0NfcbgHLnUHxiq5bSqJLVwHjk2FY+MJ970Zk4gV0FHEvWJ
	 JOtbIinggtjRl5efYiUzUu359oZCzuorShKUWndXdMheN8kC8utV9fJmixXUmzd2pH
	 3m6IrgGAOfjvSEprdL+AUnDD26sjR241Z8ZyDcCkw5y5mW7yxzaZk+xbFP3g1voqlz
	 dRS2OPzJTQRZYmzMs9IqP1/YmBXEfZAv4LMDScJDNNjyCCbAGl4+j810kYedpODfNL
	 NXVKBFiKkJLHnAkAkbZ6f8vebdxStx+joPuK8Y4XUGE21r+cbjPu/Glmx8Idi7FZl8
	 0dbr3jZqp6qdw==
Date: Sat, 13 Apr 2024 17:52:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 u.kleine-koenig@pengutronix.de, biju.das.jz@bp.renesas.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] iio: pressure: bmp280: Various driver cleanups
Message-ID: <20240413175257.6cadbb83@jic23-huawei>
In-Reply-To: <20240407172920.264282-2-vassilisamir@gmail.com>
References: <20240407172920.264282-1-vassilisamir@gmail.com>
	<20240407172920.264282-2-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  7 Apr 2024 19:29:15 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Various driver cleanups including:
> 
Not sure how we got to a v4 with a patch title various.

If you have to list multiple changes, it should normally
be multiple patches.

White space can all be grouped, but the others should be separate.
Please break it up for v5.

I'll take a look at the actual changes even though I won't merge
a 'various' patch like this.

I may well miss things because there is simply too much in here
and some of the diffs are subtle as it can be hard to spot
if it's a name change or a functional change.

> a) change names of functions that are used by all sensors from
>    bmp280_read_raw_* to bmp_read_raw_* to make it more clear that
>    these functions are general and not tied to the BMP280 sensor.
Don't.  Convention is to naming such function after the first supported
part.  We've tried generic naming in the past and often becomes even
less clear.  Already you have bmp_x functions applying to bme devices.
Sooner or later you will have them applying to an xyz280 where none
of the letter matter.
> 


> b) modify some defines that are used only by the BME280 sensor
>    to use the naming convention BME280_* and not BMP280_*.

This is fine, but also move them so they aren't in blocks labeled
BMP280 specific registers.

> 
> c) add various error messages that were not implemented.
Also fine in a patch on their own.
> 
> d) sort headers.
Separate patch and this is probably fine.

> 
> e) fix various indentation errors which were found by checkpatch.pl.

White space fixes always belong in a patch that does nothing else.

> 
> g) Add identifier names in function definitions which were warned
>    by checkpatch.pl.
This is fine, but again not in a patch making other changes.

I want to be reading a patch whilst just looking at one type of thing.
It is much quicker to review 6 single purpose patches than 1 patch
combining all 6.


Jonathan
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/pressure/bmp280-core.c   | 244 ++++++++++++++-------------
>  drivers/iio/pressure/bmp280-i2c.c    |   2 +-
>  drivers/iio/pressure/bmp280-regmap.c |   8 +-
>  drivers/iio/pressure/bmp280-spi.c    |   8 +-
>  drivers/iio/pressure/bmp280.h        |  50 +++---
>  5 files changed, 159 insertions(+), 153 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 09f53d987c7d..1c51139cbfcf 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -52,7 +52,6 @@
>   */
>  enum { AC1, AC2, AC3, AC4, AC5, AC6, B1, B2, MB, MC, MD };
>  
> -
>  enum bmp380_odr {
>  	BMP380_ODR_200HZ,
>  	BMP380_ODR_100HZ,
> @@ -71,7 +70,7 @@ enum bmp380_odr {
>  	BMP380_ODR_0_01HZ,
>  	BMP380_ODR_0_006HZ,
>  	BMP380_ODR_0_003HZ,
> -	BMP380_ODR_0_0015HZ,
> +	BMP380_ODR_0_0015HZ

Why?  We remove the comma when the last element is clearly a terminator, not
because it happens to be the last element.  This isn't NULL, or _COUNT or similar
which must always come at the end.


>  };
>  
>  enum bmp580_odr {
> @@ -106,7 +105,7 @@ enum bmp580_odr {
>  	BMP580_ODR_1HZ,
>  	BMP580_ODR_0_5HZ,
>  	BMP580_ODR_0_25HZ,
> -	BMP580_ODR_0_125HZ,
> +	BMP580_ODR_0_125HZ

As above, I can't see a reason to change this.

>  };
>  
>  /*
> @@ -131,7 +130,7 @@ enum {
>  	BMP380_P8 = 16,
>  	BMP380_P9 = 17,
>  	BMP380_P10 = 19,
> -	BMP380_P11 = 20,
> +	BMP380_P11 = 20
and again.

>  };
>  
>  static const struct iio_chan_spec bmp280_channels[] = {
> @@ -181,11 +180,10 @@ static int bmp280_read_calib(struct bmp280_data *data)
>  	struct bmp280_calib *calib = &data->calib.bmp280;
>  	int ret;
>  
> -
>  	/* Read temperature and pressure calibration values. */
>  	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_TEMP_START,
>  			       data->bmp280_cal_buf, sizeof(data->bmp280_cal_buf));
> -	if (ret < 0) {
> +	if (ret) {
>  		dev_err(data->dev,
>  			"failed to read temperature and pressure calibration parameters\n");
>  		return ret;
> @@ -222,7 +220,7 @@ static int bme280_read_calib(struct bmp280_data *data)
>  
>  	/* Load shared calibration params with bmp280 first */
>  	ret = bmp280_read_calib(data);
> -	if  (ret < 0) {
> +	if  (ret) {
>  		dev_err(dev, "failed to read common bmp280 calibration parameters\n");
>  		return ret;
>  	}
> @@ -235,47 +233,47 @@ static int bme280_read_calib(struct bmp280_data *data)
>  	 * Humidity data is only available on BME280.
>  	 */
>  
> -	ret = regmap_read(data->regmap, BMP280_REG_COMP_H1, &tmp);
> -	if (ret < 0) {
> +	ret = regmap_read(data->regmap, BME280_REG_COMP_H1, &tmp);
> +	if (ret) {
>  		dev_err(dev, "failed to read H1 comp value\n");
>  		return ret;
>  	}
>  	calib->H1 = tmp;
>  
> -	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H2,
> +	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H2,
>  			       &data->le16, sizeof(data->le16));
> -	if (ret < 0) {
> +	if (ret) {
>  		dev_err(dev, "failed to read H2 comp value\n");
>  		return ret;
>  	}
>  	calib->H2 = sign_extend32(le16_to_cpu(data->le16), 15);
>  
> -	ret = regmap_read(data->regmap, BMP280_REG_COMP_H3, &tmp);
> -	if (ret < 0) {
> +	ret = regmap_read(data->regmap, BME280_REG_COMP_H3, &tmp);
> +	if (ret) {
>  		dev_err(dev, "failed to read H3 comp value\n");
>  		return ret;
>  	}
>  	calib->H3 = tmp;
>  
> -	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H4,
> +	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H4,
>  			       &data->be16, sizeof(data->be16));
> -	if (ret < 0) {
> +	if (ret) {
>  		dev_err(dev, "failed to read H4 comp value\n");
>  		return ret;
>  	}
>  	calib->H4 = sign_extend32(((be16_to_cpu(data->be16) >> 4) & 0xff0) |
>  				  (be16_to_cpu(data->be16) & 0xf), 11);
>  
> -	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H5,
> +	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H5,
>  			       &data->le16, sizeof(data->le16));
> -	if (ret < 0) {
> +	if (ret) {
>  		dev_err(dev, "failed to read H5 comp value\n");
>  		return ret;
>  	}
> -	calib->H5 = sign_extend32(FIELD_GET(BMP280_COMP_H5_MASK, le16_to_cpu(data->le16)), 11);
> +	calib->H5 = sign_extend32(FIELD_GET(BME280_COMP_H5_MASK, le16_to_cpu(data->le16)), 11);
>  
> -	ret = regmap_read(data->regmap, BMP280_REG_COMP_H6, &tmp);
> -	if (ret < 0) {
> +	ret = regmap_read(data->regmap, BME280_REG_COMP_H6, &tmp);
> +	if (ret) {
>  		dev_err(dev, "failed to read H6 comp value\n");
>  		return ret;
>  	}
> @@ -283,14 +281,14 @@ static int bme280_read_calib(struct bmp280_data *data)
>  
>  	return 0;
>  }
> +
>  /*
>   * Returns humidity in percent, resolution is 0.01 percent. Output value of
>   * "47445" represents 47445/1024 = 46.333 %RH.
>   *
>   * Taken from BME280 datasheet, Section 4.2.3, "Compensation formula".
>   */
> -static u32 bmp280_compensate_humidity(struct bmp280_data *data,
> -				      s32 adc_humidity)
> +static u32 bme280_compensate_humidity(struct bmp280_data *data, s32 adc_humidity)
>  {
>  	struct bmp280_calib *calib = &data->calib.bmp280;
>  	s32 var;
> @@ -305,7 +303,7 @@ static u32 bmp280_compensate_humidity(struct bmp280_data *data,
>  	var = clamp_val(var, 0, 419430400);
>  
>  	return var >> 12;
> -};
> +}
>  
>  /*
>   * Returns temperature in DegC, resolution is 0.01 DegC.  Output value of
> @@ -314,8 +312,7 @@ static u32 bmp280_compensate_humidity(struct bmp280_data *data,
>   *
>   * Taken from datasheet, Section 3.11.3, "Compensation formula".
>   */
> -static s32 bmp280_compensate_temp(struct bmp280_data *data,
> -				  s32 adc_temp)
> +static s32 bmp280_compensate_temp(struct bmp280_data *data, s32 adc_temp)
>  {
>  	struct bmp280_calib *calib = &data->calib.bmp280;
>  	s32 var1, var2;
> @@ -337,8 +334,7 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
>   *
>   * Taken from datasheet, Section 3.11.3, "Compensation formula".
>   */
> -static u32 bmp280_compensate_press(struct bmp280_data *data,
> -				   s32 adc_press)
> +static u32 bmp280_compensate_press(struct bmp280_data *data, s32 adc_press)
>  {
>  	struct bmp280_calib *calib = &data->calib.bmp280;
>  	s64 var1, var2, p;
> @@ -363,15 +359,14 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
>  	return (u32)p;
>  }
>  
> -static int bmp280_read_temp(struct bmp280_data *data,
> -			    int *val, int *val2)
> +static int bmp280_read_temp(struct bmp280_data *data, int *val, int *val2)
>  {
>  	s32 adc_temp, comp_temp;
>  	int ret;
>  
>  	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
>  			       data->buf, sizeof(data->buf));
> -	if (ret < 0) {
> +	if (ret) {
>  		dev_err(data->dev, "failed to read temperature\n");
>  		return ret;
>  	}
> @@ -396,8 +391,7 @@ static int bmp280_read_temp(struct bmp280_data *data,
>  	return 0;
>  }
>  
> -static int bmp280_read_press(struct bmp280_data *data,
> -			     int *val, int *val2)
> +static int bmp280_read_press(struct bmp280_data *data, int *val, int *val2)
>  {
>  	u32 comp_press;
>  	s32 adc_press;
> @@ -405,12 +399,12 @@ static int bmp280_read_press(struct bmp280_data *data,
>  
>  	/* Read and compensate temperature so we get a reading of t_fine. */
>  	ret = bmp280_read_temp(data, NULL, NULL);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
>  			       data->buf, sizeof(data->buf));
> -	if (ret < 0) {
> +	if (ret) {
>  		dev_err(data->dev, "failed to read pressure\n");
>  		return ret;
>  	}
> @@ -429,7 +423,7 @@ static int bmp280_read_press(struct bmp280_data *data,
>  	return IIO_VAL_FRACTIONAL;
>  }
>  
> -static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
> +static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
>  {
>  	u32 comp_humidity;
>  	s32 adc_humidity;
> @@ -437,12 +431,12 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
>  
>  	/* Read and compensate temperature so we get a reading of t_fine. */
>  	ret = bmp280_read_temp(data, NULL, NULL);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
> -	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB,
> +	ret = regmap_bulk_read(data->regmap, BME280_REG_HUMIDITY_MSB,
>  			       &data->be16, sizeof(data->be16));
> -	if (ret < 0) {
> +	if (ret) {
>  		dev_err(data->dev, "failed to read humidity\n");
>  		return ret;
>  	}
> @@ -453,16 +447,16 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
>  		dev_err(data->dev, "reading humidity skipped\n");
>  		return -EIO;
>  	}
> -	comp_humidity = bmp280_compensate_humidity(data, adc_humidity);
> +	comp_humidity = bme280_compensate_humidity(data, adc_humidity);
>  
>  	*val = comp_humidity * 1000 / 1024;
>  
>  	return IIO_VAL_INT;
>  }
>  
> -static int bmp280_read_raw(struct iio_dev *indio_dev,
> -			   struct iio_chan_spec const *chan,
> -			   int *val, int *val2, long mask)
> +static int bmp_read_raw(struct iio_dev *indio_dev,

No to this sort of change.  bmp280_ is the prefix for the driver - it doesn't
mean that it applies only to that part.  As such it is the prefix
we should use throughout the driver unless a function is specific
to a different part.  bmp is too generic and may cause namespace issues
like a clash with something in a header at somepoint in future.

> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index 5812a344ed8e..ea8eb5691428 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -1,10 +1,10 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #include <linux/bitops.h>
>  #include <linux/device.h>
> -#include <linux/iio/iio.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  
> +#include <linux/iio/iio.h>
>  
>  /* BMP580 specific registers */
>  #define BMP580_REG_CMD			0x7E
> @@ -192,8 +192,8 @@
>  #define BMP380_PRESS_SKIPPED		0x800000
>  
>  /* BMP280 specific registers */
> -#define BMP280_REG_HUMIDITY_LSB		0xFE
> -#define BMP280_REG_HUMIDITY_MSB		0xFD
> +#define BME280_REG_HUMIDITY_LSB		0xFE
> +#define BME280_REG_HUMIDITY_MSB		0xFD
They are in a block called BMP280 specific registers why 
are they prefixed with BME280?

If they don't apply to the BMP280 add a new block with
a comment to say BME280 specific registers.


>  #define BMP280_REG_TEMP_XLSB		0xFC
>  #define BMP280_REG_TEMP_LSB		0xFB
>  #define BMP280_REG_TEMP_MSB		0xFA
> @@ -207,15 +207,15 @@
>  #define BMP280_REG_CONFIG		0xF5
>  #define BMP280_REG_CTRL_MEAS		0xF4
>  #define BMP280_REG_STATUS		0xF3
> -#define BMP280_REG_CTRL_HUMIDITY	0xF2
> +#define BME280_REG_CTRL_HUMIDITY	0xF2

Jonathan


