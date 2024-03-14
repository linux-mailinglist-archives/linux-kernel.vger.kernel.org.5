Return-Path: <linux-kernel+bounces-103760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F33E487C41C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 692B4B20EDB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE483762C1;
	Thu, 14 Mar 2024 20:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZgnzhjI"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EEF762D6;
	Thu, 14 Mar 2024 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710447448; cv=none; b=kJUhTh0kfR6oMS6eqdjcWbG+E2WOeBfcanB2O6UCoXogJ8m1nPrLFIm8/aICeP2a1KIrVyFenNt63BzwnpGPP/A9ZLg6Jn58WG3lFhHh3rAS+7qbQBN3GJEG/0Oc1COJeveVnFRDCGGjhuAFwXcmUiWFpnxwE9vEqGItIazN+bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710447448; c=relaxed/simple;
	bh=oOAciFN3IjrXwyfoHlJ9VKAhZBF0yKi2rLAIDTxL58Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqUDOlqL/jzKwLxh9vvqWSju668xUbCh8Jn2ipsw2z1p2MJ94o5ZmsRdKdE0PqUgjVhWy9JxK/XGYJS51RCpnWCcFzVhBi5Z4o2aO3uPQmAsivJtAPs91JwEDrhIHKQZ9zZ9UO2o619BNasgSECvrhy7pY26WpMJ3fQSg91aINs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZgnzhjI; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513cfd48224so1697264e87.2;
        Thu, 14 Mar 2024 13:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710447441; x=1711052241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WScc3493+71uc4zQshj39+CRqkWav60PlPiDu6utj1k=;
        b=ZZgnzhjIbRofvpBkzwihWQ5rAbWn+Ppg3HIN2fTbTI9xooXyUFfd1AiotujjHuBeAf
         jY5TWfkiWDBJtYbWB76VQ3lyuEBL/ECZ4CZolpSJWJaCibRokrLytmaG8D+3+KIpH70A
         JcNJIwph3LBczsbuHqO5iXvl3pMpsg0tJ2SSo22r1zfZ6ZNHRozm2mpPxdhwWqCjI2ub
         AQknj9cofmC9Bz0gfEKuoES3aC0V+IOIyrfWLtTzupSdsTib+Vv9jyTm8dqKVdRsQYig
         /acYx7mwYkU+UE171Yq4JFdpDjF8MRGBV9JrF59wBkkqsebnxQNmKz8/TPAHQZkqxLbj
         NOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710447441; x=1711052241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WScc3493+71uc4zQshj39+CRqkWav60PlPiDu6utj1k=;
        b=GBQy5yNe9g4EwvrKHVWdm6RcJ1+p+6AwbHJ3P6chcDZcF02xENvGfbM3CVvRMtgPQx
         NHJHSmSj1cb5Ddg9wGD0g3tKxtM5DAb56/+Uwr6lFOJoF2OHGQ49Fw+EdQ88sg7R4CI6
         tjJu/xUDXuTmm6z6qG1OcrqB+OAsKkRwrLdJtzVpkAR+v0E50H72lw6OK+84BM/YxBU0
         dO1OzfzlxvTsdm5Ys3b22tS1TVfs7wVDaDeF9F7SsziT0QpalRTT/5NbOzAHDgvY5YEw
         PkZXQsg7+k5yFv6lEsfZJvHPXi64bl6Qq9gCUv/HDmcawHLnjRl6JmTG3NsNn/u2r7/m
         uqhA==
X-Forwarded-Encrypted: i=1; AJvYcCX3d5DEC4NFnN2Vhn/l6U+I99nW5jC7vSRtifeHXWOI4sbs7TiZ9i82OCLYhwgYVPoNk5cN2ljbQ58a9mRe/tVOjqKk1kuT5fyyUSaCrN7NpuvmoRG9UZWFFWpYFlAl4XLWBxvipA9r
X-Gm-Message-State: AOJu0Ywr96utHH7mQ84goDYZgKJu6FFYt0hj6D+elLYf2W9jpxxuVXJK
	7vzd1tJEjnDUyua32kb4kgLPVbuF0kZYotOddko4FgwgvglZdTWQ
X-Google-Smtp-Source: AGHT+IHcSrFMbHPK4/WuinqRzK+JEa1bDU+oLv+kqvwZ2qBqdE29194Pbgg+7cMeMR96mcUM1qKqkQ==
X-Received: by 2002:a05:6512:3284:b0:513:c2e3:226e with SMTP id p4-20020a056512328400b00513c2e3226emr1042966lfe.8.1710447441188;
        Thu, 14 Mar 2024 13:17:21 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:3844:3925:f1c1:4bc5])
        by smtp.gmail.com with ESMTPSA id d10-20020a170907272a00b00a44ef54b6b6sm1008822ejl.58.2024.03.14.13.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 13:17:20 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Thu, 14 Mar 2024 21:17:18 +0100
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, linus.walleij@linaro.org,
	phil@raspberrypi.com, 579lpy@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iio: pressure: Simplify and make more clear
 temperature readings
Message-ID: <20240314201718.GD1964894@vamoiridPC>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
 <20240313174007.1934983-5-vassilisamir@gmail.com>
 <20240314150959.585367b5@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314150959.585367b5@jic23-huawei>

On Thu, Mar 14, 2024 at 03:09:59PM +0000, Jonathan Cameron wrote:
> On Wed, 13 Mar 2024 18:40:05 +0100
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > The read_press/read_humid functions need the updated t_fine value
> > in order to calculate the current pressure/humidity. Temperature
> > reads should be removed from the read_press/read_humid functions
> > and should be placed in the oneshot captures before the pressure
> > and humidity reads. This makes the code more intuitive.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> To me this makes the use of these calls less obvious than they were
> previously.  The calls are made close to where t_fine is used and
> don't have to go via the indirection of chip_info.
> 
> So I disagree. I think this change makes the code a lot less
> clear.
> 

This was mainly driven by the fact that I wanted to avoid reading
the temperature 3 times in case temp, press and humid are enabled
and there are consecutive buffer readings. But thank you for the
proposal I really appreciate it!

Best regards,
Vasilis

> The only improvement I can readily see would be to move the
> temperature read into the compensation functions themselves, possibly
> removing t_fine from data and having a function that reads everything
> relevant to computing it directly but doesn't do the maths to get
> a temperature reading.  That can be reused in bmp280_compensate_temp()
> 
> Something along lines of.
> 
> static s32 bmp280_calc_tfine(struct bmp280_calib *calib, s32 adc_temp) 
> {
> 	s32 var1, var2;
> 
> 	var1 = (((adc_temp >> 3) - ((s32)calib->T1 << 1)) *
> 		((s32)calib->T2)) >> 11;
> 	var2 = (((((adc_temp >> 4) - ((s32)calib->T1)) *
> 		  ((adc_temp >> 4) - ((s32)calib->T1))) >> 12) *
> 		((s32)calib->T3)) >> 14;
> 	return var1 + var2;
> }
> 
> static int bmp280_read_temp_raw(struct bmp280_data *data,
> 			    	s32 *raw)
> {
> 	s32 adc_temp;
> 	int ret;
> 
> 	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
> 			       data->buf, sizeof(data->buf));
> 	if (ret < 0) {
> 		dev_err(data->dev, "failed to read temperature\n");
> 		return ret;
> 	}
> 
> 	adc_temp = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(data->buf));
> 	if (adc_temp == BMP280_TEMP_SKIPPED) {
> 		/* reading was skipped */
> 		dev_err(data->dev, "reading temperature skipped\n");
> 		return -EIO;
> 	}
> 	*raw = adc_temp;
> 
> 	return 0;
> }
> static int bmp280_get_t_fine(.., s32 *t_fine)
> {
> 	s32 adc_temp, comp_temp;
> 	s32 t_fine;
> 	int ret;
> 
> 	ret = bmp280_read_temp_raw(data, &adc_temp;
> 	if (ret)
> 		return ret;
> 
> 	*t_fine = bmp280_calc_tfine(&data->calib.bmp280, adc_temp);
> 	return 0;
> }
> 
> static int bmp280_read_temp(struct bmp280_data *data, s32 *temp)
> {
> 	int ret;
> 	s32 t_fine;
> 
> 	ret = bmp280_get_t_fine(data, &t_fine);
> 	if (ret)
> 		return ret;
> 
> 	*temp = (t_fine * 5 + 128) / 256;
> //division rather than shift as then it's obvious what the 128 is there for
> 	return 0;
> }
> 
> Now you have a nice function to get you t_fine which is all you want in some
> of these paths.  Call it directly where it is needed instead of as
> a side effect of a temperature read.
> 
> 
> 
> > ---
> >  drivers/iio/pressure/bmp280-core.c | 38 ++++++++++++++----------------
> >  1 file changed, 18 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > index 6d7734f867bc..377e90d9e5a2 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -404,11 +404,6 @@ static u32 bmp280_read_press(struct bmp280_data *data)
> >  	s32 adc_press;
> >  	int ret;
> >  
> > -	/* Read and compensate temperature so we get a reading of t_fine. */
> > -	ret = bmp280_read_temp(data);
> > -	if (ret < 0)
> > -		return ret;
> > -
> >  	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
> >  			       data->buf, sizeof(data->buf));
> >  	if (ret < 0) {
> > @@ -433,11 +428,6 @@ static u32 bmp280_read_humid(struct bmp280_data *data)
> >  	s32 adc_humidity;
> >  	int ret;
> >  
> > -	/* Read and compensate temperature so we get a reading of t_fine. */
> > -	ret = bmp280_read_temp(data);
> > -	if (ret < 0)
> > -		return ret;
> > -
> >  	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB,
> >  			       &data->be16, sizeof(data->be16));
> >  	if (ret < 0) {
> > @@ -470,12 +460,21 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
> >  	case IIO_CHAN_INFO_PROCESSED:
> >  		switch (chan->type) {
> >  		case IIO_HUMIDITYRELATIVE:
> > +			/* Read temperature to update the t_fine value */
> > +			data->chip_info->read_temp(data);
> >  			ret = data->chip_info->read_humid(data);
> >  			*val = data->chip_info->humid_coeffs[0] * ret;
> >  			*val2 = data->chip_info->humid_coeffs[1];
> >  			ret = IIO_VAL_FRACTIONAL;
> >  			break;
> >  		case IIO_PRESSURE:
> > +			/*
> > +			 * Read temperature to update the t_fine value.
> > +			 * BMP5xx devices do this in hardware, so skip it.
> > +			 */
> > +			if (strcmp(indio_dev->name, "bmp580"))
> > +				data->chip_info->read_temp(data);
> > +
> >  			ret = data->chip_info->read_press(data);
> >  			*val = data->chip_info->press_coeffs[0] * ret;
> >  			*val2 = data->chip_info->press_coeffs[1];
> > @@ -500,10 +499,19 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
> >  	case IIO_CHAN_INFO_RAW:
> >  		switch (chan->type) {
> >  		case IIO_HUMIDITYRELATIVE:
> > +			/* Read temperature to update the t_fine value */
> > +			data->chip_info->read_temp(data);
> >  			*val = data->chip_info->read_humid(data);
> >  			ret = IIO_VAL_INT;
> >  			break;
> >  		case IIO_PRESSURE:
> > +			/*
> > +			 * Read temperature to update the t_fine value.
> > +			 * BMP5xx devices do this in hardware, so skip it.
> > +			 */
> > +			if (strcmp(indio_dev->name, "bmp580"))
> > +				data->chip_info->read_temp(data);
> > +
> >  			*val = data->chip_info->read_press(data);
> >  			ret = IIO_VAL_INT;
> >  			break;
> > @@ -1092,11 +1100,6 @@ static u32 bmp380_read_press(struct bmp280_data *data)
> >  	s32 adc_press;
> >  	int ret;
> >  
> > -	/* Read and compensate for temperature so we get a reading of t_fine */
> > -	ret = bmp380_read_temp(data);
> > -	if (ret)
> > -		return ret;
> > -
> >  	ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB,
> >  			       data->buf, sizeof(data->buf));
> >  	if (ret) {
> > @@ -2009,11 +2012,6 @@ static u32 bmp180_read_press(struct bmp280_data *data)
> >  	s32 adc_press;
> >  	int ret;
> >  
> > -	/* Read and compensate temperature so we get a reading of t_fine. */
> > -	ret = bmp180_read_temp(data);
> > -	if (ret)
> > -		return ret;
> > -
> >  	ret = bmp180_read_adc_press(data, &adc_press);
> >  	if (ret)
> >  		return ret;
> 

