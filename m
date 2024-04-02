Return-Path: <linux-kernel+bounces-128467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1538895B34
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4899D1F214BF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6B215AAC4;
	Tue,  2 Apr 2024 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJ/8CXmS"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333C8175A1;
	Tue,  2 Apr 2024 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080560; cv=none; b=i4Ju+pnlDcnjYBdEKDZXklaiNk8Xvl022aodn3x+iuxkaVbWWXUo/Z1fE1ILEgpEJMtPKE6VjznqRpy84EChomh+8InzcfMlroBBLiuCi/qdgpqpeHJhCfBO5mLxHXEy1GBTLPVv6I8iLt6u4PMgA57+q1WM6+u85LNZeIR1MiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080560; c=relaxed/simple;
	bh=yOGoZzDVnt0nYlnAF5DCYxsxQAnObPAdb8IOZXwlZPE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAsCrQwPjK0E12Sr5jRpS4n47HUYxwCMLyBiuRdr1sp2ItN7DPejvAlpkpjhjjHJn/wPVZemqCbbYMPyRkI7IxwGohUlMA0ZIU1FT4eyL7y//EnFzQt0Qr5ELuaqqNSFdQLTwjQ2y3oyu85PFWq/ElNTLohUvYzKSdviVDpt2HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJ/8CXmS; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a44665605f3so620073366b.2;
        Tue, 02 Apr 2024 10:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712080556; x=1712685356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dhLz/IMY71FcINUE/EC2tQpXmjklSbEPq5ccNcSzJuY=;
        b=XJ/8CXmS1OR64Ucmp1QHb+mleQZgiqEl+WP3yH7sO0YOLdlavFyet7XCeYi3SQJ8Lo
         MzfKGfL3KgFfioJ7u0oIfhwf963OpVf7e1pYyhAeD389051nN7fNKYCCVMHa0Ol8sdck
         r9pLxqefHILQEytyMuZ4UUxFrz2W8586QyNQ3uzFSPN0D++axUdo6PV3XqL5o5fTtSd6
         AX32FRNc56Xqa5aB1pYyv+wUiMQLIE2yyAI/gK425QZqHDs6biRsDq5IopZnHdk/xdW8
         6LESmo4j+60u/Og/bC60lMp+t0wz9Y4aAPsVxOj+YlCCtr7LNF/ynOKj7bKIJ3ES7kb1
         gjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712080556; x=1712685356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhLz/IMY71FcINUE/EC2tQpXmjklSbEPq5ccNcSzJuY=;
        b=X2b1lEdUaVnSZUuI6V68UVMkznTM3P87BSmN7/FZP/+Kyh/k5VK/Yh4GPIJEQBP//a
         eww2p+NOTDi08+xtgog8KEFpe3tevFUDw9qo2oQ9XHmjYmN3VHfipX7+FgUqQ42QHoUK
         6wDK81o16qOEkGcgclVfQf72kAsmOA8c60/TZnamHhWNkB7/0amiTHfjswYmxvC6yaEp
         MN02FK/erLyy5Y4KjD0HU3K05HKK0+lwT/Kj6ZncpmSV4Jq8egldcMAkRCy+6HAULOao
         TqbiFj1IrhnJdr4mq2siFM9rM87Xgo9OF/03w7nwgOdBzvOyZwDrwWihv7zU0zW4CKG4
         N7LQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4/7uZIIRYPDZpuL6N2YBt9hNKLWUpEtNy5y+1oXb3MWOEwAJIovjawUIIlOd+8caXlNA0wIonQqFdmf4yfdj46UpApHatj0nKGMoKYT752nn0hldo+a6kmtE0z8Y5Mz4oVLM988ZS
X-Gm-Message-State: AOJu0YypuvV7g9ADV9GPucgLRqAdeQJwAXGok9CvTVvsrR4L93SqgJpf
	UqdsZr/gRQii5fOOx9XuyCKqs82Q0uaMwlj3THc4uAaHcsp+/3yv
X-Google-Smtp-Source: AGHT+IHsobIEUN/qEnUFP/28ygQqQo76SwOOAw/Byofc+SZV7U6G7Ca1TRY+EDySVZ6a5H4hMKEmaQ==
X-Received: by 2002:a17:907:7daa:b0:a4e:2d7d:3fab with SMTP id oz42-20020a1709077daa00b00a4e2d7d3fabmr9745428ejc.10.1712080556169;
        Tue, 02 Apr 2024 10:55:56 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:7185:ec3b:3142:ff0a])
        by smtp.gmail.com with ESMTPSA id bn8-20020a170907268800b00a4e6582edf8sm3107016ejc.102.2024.04.02.10.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 10:55:55 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Tue, 2 Apr 2024 19:55:53 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iio: pressure: Generalize
 read_{temp/press/humid}() functions
Message-ID: <20240402175553.GA18068@vamoiridPC>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
 <20240319002925.2121016-4-vassilisamir@gmail.com>
 <20240324113616.02f9f391@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324113616.02f9f391@jic23-huawei>

On Sun, Mar 24, 2024 at 11:36:16AM +0000, Jonathan Cameron wrote:
> On Tue, 19 Mar 2024 01:29:22 +0100
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Add the coefficients for the IIO standard units and the return
> > IIO value inside the chip_info structure.
> > 
> > Remove the calculations with the coefficients for the IIO unit
> > compatibility from inside the read_{temp/press/humid}() functions
> > and move it to the general read_raw() function.
> > 
> > Execute the calculations with the coefficients inside the read_raw()
> > oneshot capture function.
> > 
> > In this way, all the data for the calculation of the value are
> > located in the chip_info structure of the respective sensor.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> Hi,
> 
> Perhaps it's later in the series, but I still don't much like the hidden nature
> of t_fine. I'd much rather that was explicitly 'returned' by the function
> - by that I mean read_temp takes an s32 *t_fine and provides that if the pointer
> isn't NULL.
> 
> Then drop the cached value in bmp280_data which I think just serves to make
> this code less readable than it could be.
> 
> Then bmp280_compensate_pressure() can take a struct bmp280_calib, s32 adc_press and
> s32 t_fine so it just has the data it needs.
> Something similar for bmp280_compenstate_temp()
> 
> Obviously this is cleaning up stuff that's been there a long time, but
> given you are generalizing these functions this seems like the time to
> make these other changes.
> 
> As it stands, I don't think this code works as t_fine isn't updated
> everywhere it needs to be and that is hidden away by it being updated
> as a side effect of other calls.
> 
> Jonathan
> 

Hi Jonathan,

I am replying a bit late but I was off for quite some days.

In general the t_fine variable is calculated inside the bmpxxx_compensate_temp().
The t_fine variable is a function of the various varX variables and the adc_temp.
So by reading a new temp value from
the sensor and calculating its compensated value, the new t_fine variable is
calculated. So the combination of reading temp from sensor + compensating the
temp value = updated t_fine as a result of the compensated temperature. I agree that
this has a hidden nature. I can solve it by disintegrating the read()+compensate()
functions as follows:

bmpxxx_read_temp_adc(struct bmp280_data *data, s32 *adc_temp)
{
	/* reads adc temperature from the sensor */
}

bmpxxx_calc_t_fine(struct bmp280_calib *calib, s32 *adc_temp)
{
	/* calculate t_fine from adc_temp */
}

bmpxxx_get/update_t_fine(struct bmp280_data *data, ...)
{
	u32 adc_temp;
	s32 t_fine;

	bmpxxx_read_temp_adc(adc_temp); //get adc_temp
	if (ret)
		return ret;

	*t_fine = bmpxxx_calc_t_fine(&data->bmp280_calib.bmpxxx_calib, adc_temp);
}

bmpxxx_read_temp(struct bmp280_data *data, s32 *comp_temp)
{
	int ret;
	s32 t_fine;

	ret = bmpxxx_get/update_t_fine(&data, &t_fine);
	if (ret)
		return ret;

	*comp_temp = /* rest of the calculations to compensate temperature */

	return 0
}

Another question is, should this be applied to the pressure/humidity readings as 
well? Maybe, read_{humidity/press}_adc() functions could be introduced just to
have consistency with the temperature readings. Currently the adc_{humid/press}()
reading is done inside the read_{humid/press}() functions which already
incorporates the compensate_{humid/press}() functions.
 
> 
> > ---
> >  drivers/iio/pressure/bmp280-core.c | 189 +++++++++++++++--------------
> >  drivers/iio/pressure/bmp280.h      |  13 +-
> >  2 files changed, 106 insertions(+), 96 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > index f7a13ff6f26c..6d6173c4b744 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -363,10 +363,9 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
> >  	return (u32)p;
> >  }
> >  
> > -static int bmp280_read_temp(struct bmp280_data *data,
> > -			    int *val, int *val2)
> > +static int bmp280_read_temp(struct bmp280_data *data, s32 *comp_temp)
> >  {
> > -	s32 adc_temp, comp_temp;
> > +	s32 adc_temp;
> >  	int ret;
> >  
> >  	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
> > @@ -382,29 +381,20 @@ static int bmp280_read_temp(struct bmp280_data *data,
> >  		dev_err(data->dev, "reading temperature skipped\n");
> >  		return -EIO;
> >  	}
> > -	comp_temp = bmp280_compensate_temp(data, adc_temp);
> >  
> > -	/*
> > -	 * val might be NULL if we're called by the read_press routine,
> > -	 * who only cares about the carry over t_fine value.
> > -	 */
> > -	if (val) {
> > -		*val = comp_temp * 10;
> > -		return IIO_VAL_INT;
> > -	}
> > +	if (comp_temp)
> > +		*comp_temp = bmp280_compensate_temp(data, adc_temp);
> 
> As below, I don't think this is updating t_fine.
> Another reason to make that update very obvious rather than burried
> in this function call.
> 
> >  
> >  	return 0;
> >  }
> >  
> > -static int bmp280_read_press(struct bmp280_data *data,
> > -			     int *val, int *val2)
> > +static int bmp280_read_press(struct bmp280_data *data, u32 *comp_press)
> >  {
> > -	u32 comp_press;
> >  	s32 adc_press;
> >  	int ret;
> >  
> >  	/* Read and compensate temperature so we get a reading of t_fine. */
> > -	ret = bmp280_read_temp(data, NULL, NULL);
> > +	ret = bmp280_read_temp(data, NULL);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > @@ -421,22 +411,19 @@ static int bmp280_read_press(struct bmp280_data *data,
> >  		dev_err(data->dev, "reading pressure skipped\n");
> >  		return -EIO;
> >  	}
> > -	comp_press = bmp280_compensate_press(data, adc_press);
> >  
> > -	*val = comp_press;
> > -	*val2 = 256000;
> > +	*comp_press = bmp280_compensate_press(data, adc_press);
> >  
> > -	return IIO_VAL_FRACTIONAL;
> > +	return 0;
> >  }
> >  
> > -static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
> > +static int bmp280_read_humid(struct bmp280_data *data, u32 *comp_humidity)
> >  {
> > -	u32 comp_humidity;
> >  	s32 adc_humidity;
> >  	int ret;
> >  
> >  	/* Read and compensate temperature so we get a reading of t_fine. */
> > -	ret = bmp280_read_temp(data, NULL, NULL);
> > +	ret = bmp280_read_temp(data, NULL);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > @@ -453,11 +440,10 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
> >  		dev_err(data->dev, "reading humidity skipped\n");
> >  		return -EIO;
> >  	}
> > -	comp_humidity = bmp280_compensate_humidity(data, adc_humidity);
> >  
> > -	*val = comp_humidity * 1000 / 1024;
> > +	*comp_humidity = bmp280_compensate_humidity(data, adc_humidity);
> >  
> > -	return IIO_VAL_INT;
> > +	return 0;
> >  }
> >  
> >  static int bmp280_read_raw_guarded(struct iio_dev *indio_dev,
> > @@ -465,6 +451,8 @@ static int bmp280_read_raw_guarded(struct iio_dev *indio_dev,
> >  				   int *val, int *val2, long mask)
> >  {
> >  	struct bmp280_data *data = iio_priv(indio_dev);
> > +	int chan_value;
> > +	int ret;
> >  
> >  	guard(mutex)(&data->lock);
> >  
> > @@ -472,11 +460,29 @@ static int bmp280_read_raw_guarded(struct iio_dev *indio_dev,
> >  	case IIO_CHAN_INFO_PROCESSED:
> >  		switch (chan->type) {
> >  		case IIO_HUMIDITYRELATIVE:
> > -			return data->chip_info->read_humid(data, val, val2);
> > +			ret = data->chip_info->read_humid(data, &chan_value);
> > +			if (ret)
> > +				return ret;
> > +
> > +			*val = data->chip_info->humid_coeffs[0] * chan_value;
> > +			*val2 = data->chip_info->humid_coeffs[1];
> > +			return data->chip_info->humid_coeffs_type;
> >  		case IIO_PRESSURE:
> > -			return data->chip_info->read_press(data, val, val2);
> > +			ret = data->chip_info->read_press(data, &chan_value);
> > +			if (ret)
> > +				return ret;
> > +
> > +			*val = data->chip_info->press_coeffs[0] * chan_value;
> > +			*val2 = data->chip_info->press_coeffs[1];
> > +			return data->chip_info->press_coeffs_type;
> >  		case IIO_TEMP:
> > -			return data->chip_info->read_temp(data, val, val2);
> > +			ret = data->chip_info->read_temp(data, &chan_value);
> > +			if (ret)
> > +				return ret;
> > +
> > +			*val = data->chip_info->temp_coeffs[0] * chan_value;
> > +			*val2 = data->chip_info->temp_coeffs[1];
> > +			return data->chip_info->temp_coeffs_type;
> >  		default:
> >  			return -EINVAL;
> >  		}
> > @@ -787,6 +793,8 @@ static int bmp280_chip_config(struct bmp280_data *data)
> >  
> >  static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
> >  static const u8 bmp280_chip_ids[] = { BMP280_CHIP_ID };
> > +static const int bmp280_temp_coeffs[] = { 10, 1 };
> > +static const int bmp280_press_coeffs[] = { 1, 256000 };
> >  
> >  const struct bmp280_chip_info bmp280_chip_info = {
> >  	.id_reg = BMP280_REG_ID,
> > @@ -815,6 +823,11 @@ const struct bmp280_chip_info bmp280_chip_info = {
> >  	.num_oversampling_press_avail = ARRAY_SIZE(bmp280_oversampling_avail),
> >  	.oversampling_press_default = BMP280_OSRS_PRESS_16X - 1,
> >  
> > +	.temp_coeffs = bmp280_temp_coeffs,
> > +	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
> > +	.press_coeffs = bmp280_press_coeffs,
> > +	.press_coeffs_type = IIO_VAL_FRACTIONAL,
> > +
> >  	.chip_config = bmp280_chip_config,
> >  	.read_temp = bmp280_read_temp,
> >  	.read_press = bmp280_read_press,
> > @@ -841,6 +854,7 @@ static int bme280_chip_config(struct bmp280_data *data)
> >  }
> >  
> >  static const u8 bme280_chip_ids[] = { BME280_CHIP_ID };
> > +static const int bme280_humid_coeffs[] = { 1000, 1024 };
> >  
> >  const struct bmp280_chip_info bme280_chip_info = {
> >  	.id_reg = BMP280_REG_ID,
> > @@ -863,6 +877,14 @@ const struct bmp280_chip_info bme280_chip_info = {
> >  	.num_oversampling_humid_avail = ARRAY_SIZE(bmp280_oversampling_avail),
> >  	.oversampling_humid_default = BMP280_OSRS_HUMIDITY_16X - 1,
> >  
> > +	.temp_coeffs = bmp280_temp_coeffs,
> > +	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
> > +	.press_coeffs = bmp280_press_coeffs,
> > +	.press_coeffs_type = IIO_VAL_FRACTIONAL,
> > +	.humid_coeffs = bme280_humid_coeffs,
> > +	.humid_coeffs_type = IIO_VAL_FRACTIONAL,
> > +
> > +
> One blank line is almost always enough.
> 
> >  	.chip_config = bme280_chip_config,
> >  	.read_temp = bmp280_read_temp,
> >  	.read_press = bmp280_read_press,
> > @@ -988,9 +1010,8 @@ static u32 bmp380_compensate_press(struct bmp280_data *data, u32 adc_press)
> >  	return comp_press;
> >  }
> >  
> > -static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
> > +static int bmp380_read_temp(struct bmp280_data *data, s32 *comp_temp)
> >  {
> > -	s32 comp_temp;
> >  	u32 adc_temp;
> >  	int ret;
> >  
> > @@ -1006,29 +1027,20 @@ static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
> >  		dev_err(data->dev, "reading temperature skipped\n");
> >  		return -EIO;
> >  	}
> > -	comp_temp = bmp380_compensate_temp(data, adc_temp);
> >  
> > -	/*
> > -	 * Val might be NULL if we're called by the read_press routine,
> > -	 * who only cares about the carry over t_fine value.
> > -	 */
> > -	if (val) {
> > -		/* IIO reports temperatures in milli Celsius */
> > -		*val = comp_temp * 10;
> > -		return IIO_VAL_INT;
> > -	}
> > +	if (comp_temp)
> > +		*comp_temp = bmp380_compensate_temp(data, adc_temp);
> >  
> 
> I'm confused. If comp_temp is not provided then t_fine isn't updated
> so this function isn't doing anything?
> 
> >  	return 0;
> >  }
> >  
> > -static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
> > +static int bmp380_read_press(struct bmp280_data *data, u32 *comp_press)
> >  {
> > -	s32 comp_press;
> >  	u32 adc_press;
> >  	int ret;
> >  
> >  	/* Read and compensate for temperature so we get a reading of t_fine */
> 
> As above, I don't think it does. 
> 
> > -	ret = bmp380_read_temp(data, NULL, NULL);
> > +	ret = bmp380_read_temp(data, NULL);
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -1044,13 +1056,10 @@ static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
> >  		dev_err(data->dev, "reading pressure skipped\n");
> >  		return -EIO;
> >  	}
> > -	comp_press = bmp380_compensate_press(data, adc_press);
> >  
> > -	*val = comp_press;
> > -	/* Compensated pressure is in cPa (centipascals) */
> > -	*val2 = 100000;
> > +	*comp_press = bmp380_compensate_press(data, adc_press);
> >  
> > -	return IIO_VAL_FRACTIONAL;
> > +	return 0;
> >  }
> >  
> 
> J

