Return-Path: <linux-kernel+bounces-103459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA27987BFA0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8078E28596F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C38B7174A;
	Thu, 14 Mar 2024 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BInPB5u0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AC2DDD9;
	Thu, 14 Mar 2024 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710429015; cv=none; b=Q/BAcO3EniwNAzmtG3wq5eDB2dbElApQdOPTTlI8gclLG60vOdMmxBTUjyqAYRfHY90x/5LvqbMWArc3Qka3G7LZMA83Mv5hE3zdpyi7nB+ItcN0OcgaAxqKmby3mzzP3fr8jBrww2oB/hyr/apkU3Gawd2RmdGoqp06yh21/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710429015; c=relaxed/simple;
	bh=GFkZJWB9Ya9MH81kTy8tv+kqzJ5IRFkWv+lbxOaNeP0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eff16N+hiQrg8K6NmKDUxLodwGUySiLWoeKD51pjWUWE9XK74a87sY9HEr1wKcxGZ7+qIOxcmbdO8cZ6RaHLHyJvGsLuTZCK8ukLF+JVfOU/0RqVvy+7tqwIzi+ZHBCPCDDu3j8dXTK5jSxG08rRYZQJ8ki4H8vtwSkf+JepJHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BInPB5u0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410DBC433C7;
	Thu, 14 Mar 2024 15:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710429015;
	bh=GFkZJWB9Ya9MH81kTy8tv+kqzJ5IRFkWv+lbxOaNeP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BInPB5u0KRxHSzzuHXV9AYJG649a6SgDCUiadtq5iZjFNeNkONh0acf5QvryLzEmQ
	 nkopOwsubpUXu4/gov6AR+ht5InbRxMc+iptjiOq6i9kcPSkwr6OxshscCZ2pYPHF/
	 qqhc5NoLlM/AZxrLeKr7U3tdMS8c3Eq+Z+6SZwzYr77LiXBow32ntUTfoYDy8Q1Jdc
	 bHSPyybYQL+uD0g+L9LJtVKthVyeyIg7kBkSB01LukZ3ZI29xNs4A/3l2ZHT3x8dyT
	 nTb07ZAi5J/3eSbYyeuLHXikpaJYE2jpkfn8d3m4hYbmfZpIBidcBXCNwtdtEwzgHg
	 pVh7iAP49h7QA==
Date: Thu, 14 Mar 2024 15:09:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, linus.walleij@linaro.org,
 phil@raspberrypi.com, 579lpy@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iio: pressure: Simplify and make more clear
 temperature readings
Message-ID: <20240314150959.585367b5@jic23-huawei>
In-Reply-To: <20240313174007.1934983-5-vassilisamir@gmail.com>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
	<20240313174007.1934983-5-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 18:40:05 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> The read_press/read_humid functions need the updated t_fine value
> in order to calculate the current pressure/humidity. Temperature
> reads should be removed from the read_press/read_humid functions
> and should be placed in the oneshot captures before the pressure
> and humidity reads. This makes the code more intuitive.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>

To me this makes the use of these calls less obvious than they were
previously.  The calls are made close to where t_fine is used and
don't have to go via the indirection of chip_info.

So I disagree. I think this change makes the code a lot less
clear.

The only improvement I can readily see would be to move the
temperature read into the compensation functions themselves, possibly
removing t_fine from data and having a function that reads everything
relevant to computing it directly but doesn't do the maths to get
a temperature reading.  That can be reused in bmp280_compensate_temp()

Something along lines of.

static s32 bmp280_calc_tfine(struct bmp280_calib *calib, s32 adc_temp) 
{
	s32 var1, var2;

	var1 = (((adc_temp >> 3) - ((s32)calib->T1 << 1)) *
		((s32)calib->T2)) >> 11;
	var2 = (((((adc_temp >> 4) - ((s32)calib->T1)) *
		  ((adc_temp >> 4) - ((s32)calib->T1))) >> 12) *
		((s32)calib->T3)) >> 14;
	return var1 + var2;
}

static int bmp280_read_temp_raw(struct bmp280_data *data,
			    	s32 *raw)
{
	s32 adc_temp;
	int ret;

	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
			       data->buf, sizeof(data->buf));
	if (ret < 0) {
		dev_err(data->dev, "failed to read temperature\n");
		return ret;
	}

	adc_temp = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(data->buf));
	if (adc_temp == BMP280_TEMP_SKIPPED) {
		/* reading was skipped */
		dev_err(data->dev, "reading temperature skipped\n");
		return -EIO;
	}
	*raw = adc_temp;

	return 0;
}
static int bmp280_get_t_fine(.., s32 *t_fine)
{
	s32 adc_temp, comp_temp;
	s32 t_fine;
	int ret;

	ret = bmp280_read_temp_raw(data, &adc_temp;
	if (ret)
		return ret;

	*t_fine = bmp280_calc_tfine(&data->calib.bmp280, adc_temp);
	return 0;
}

static int bmp280_read_temp(struct bmp280_data *data, s32 *temp)
{
	int ret;
	s32 t_fine;

	ret = bmp280_get_t_fine(data, &t_fine);
	if (ret)
		return ret;

	*temp = (t_fine * 5 + 128) / 256;
//division rather than shift as then it's obvious what the 128 is there for
	return 0;
}

Now you have a nice function to get you t_fine which is all you want in some
of these paths.  Call it directly where it is needed instead of as
a side effect of a temperature read.



> ---
>  drivers/iio/pressure/bmp280-core.c | 38 ++++++++++++++----------------
>  1 file changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 6d7734f867bc..377e90d9e5a2 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -404,11 +404,6 @@ static u32 bmp280_read_press(struct bmp280_data *data)
>  	s32 adc_press;
>  	int ret;
>  
> -	/* Read and compensate temperature so we get a reading of t_fine. */
> -	ret = bmp280_read_temp(data);
> -	if (ret < 0)
> -		return ret;
> -
>  	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
>  			       data->buf, sizeof(data->buf));
>  	if (ret < 0) {
> @@ -433,11 +428,6 @@ static u32 bmp280_read_humid(struct bmp280_data *data)
>  	s32 adc_humidity;
>  	int ret;
>  
> -	/* Read and compensate temperature so we get a reading of t_fine. */
> -	ret = bmp280_read_temp(data);
> -	if (ret < 0)
> -		return ret;
> -
>  	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB,
>  			       &data->be16, sizeof(data->be16));
>  	if (ret < 0) {
> @@ -470,12 +460,21 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_PROCESSED:
>  		switch (chan->type) {
>  		case IIO_HUMIDITYRELATIVE:
> +			/* Read temperature to update the t_fine value */
> +			data->chip_info->read_temp(data);
>  			ret = data->chip_info->read_humid(data);
>  			*val = data->chip_info->humid_coeffs[0] * ret;
>  			*val2 = data->chip_info->humid_coeffs[1];
>  			ret = IIO_VAL_FRACTIONAL;
>  			break;
>  		case IIO_PRESSURE:
> +			/*
> +			 * Read temperature to update the t_fine value.
> +			 * BMP5xx devices do this in hardware, so skip it.
> +			 */
> +			if (strcmp(indio_dev->name, "bmp580"))
> +				data->chip_info->read_temp(data);
> +
>  			ret = data->chip_info->read_press(data);
>  			*val = data->chip_info->press_coeffs[0] * ret;
>  			*val2 = data->chip_info->press_coeffs[1];
> @@ -500,10 +499,19 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_RAW:
>  		switch (chan->type) {
>  		case IIO_HUMIDITYRELATIVE:
> +			/* Read temperature to update the t_fine value */
> +			data->chip_info->read_temp(data);
>  			*val = data->chip_info->read_humid(data);
>  			ret = IIO_VAL_INT;
>  			break;
>  		case IIO_PRESSURE:
> +			/*
> +			 * Read temperature to update the t_fine value.
> +			 * BMP5xx devices do this in hardware, so skip it.
> +			 */
> +			if (strcmp(indio_dev->name, "bmp580"))
> +				data->chip_info->read_temp(data);
> +
>  			*val = data->chip_info->read_press(data);
>  			ret = IIO_VAL_INT;
>  			break;
> @@ -1092,11 +1100,6 @@ static u32 bmp380_read_press(struct bmp280_data *data)
>  	s32 adc_press;
>  	int ret;
>  
> -	/* Read and compensate for temperature so we get a reading of t_fine */
> -	ret = bmp380_read_temp(data);
> -	if (ret)
> -		return ret;
> -
>  	ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB,
>  			       data->buf, sizeof(data->buf));
>  	if (ret) {
> @@ -2009,11 +2012,6 @@ static u32 bmp180_read_press(struct bmp280_data *data)
>  	s32 adc_press;
>  	int ret;
>  
> -	/* Read and compensate temperature so we get a reading of t_fine. */
> -	ret = bmp180_read_temp(data);
> -	if (ret)
> -		return ret;
> -
>  	ret = bmp180_read_adc_press(data, &adc_press);
>  	if (ret)
>  		return ret;


