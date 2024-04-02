Return-Path: <linux-kernel+bounces-128485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D73E895B73
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 310AE1C242C8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F258175A1;
	Tue,  2 Apr 2024 18:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mnmg71r+"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910D615AACF;
	Tue,  2 Apr 2024 18:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712081335; cv=none; b=LLS+nOIgN83ySDONDlQF8h1BHdSFun2sdeM3MWmPfobJHVG0+3d9jZ+JKReVv9YtkpjDWLIhXqJZwLKvPvOsOwbtoKji07xyWanHOWaOwRJ76sjCEIVipHnXbO5hWkp1JHirK1sJfKTyR1+AWc/txObnyls72/0UpcetRPpcOOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712081335; c=relaxed/simple;
	bh=mpfle+oLlzCVqgUvZSl/05K6cGddu5Eh6pDJ6GGfrVI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LB7nhr1bJUv9oA67qFkOyuHEksC5Ar3E2s2jUkmk+QOnEepo4zhi0lvNdWfa52Fq5pkvSf6hQoWVdG9MeD8lAv2UZ+GnMDyC6DIAEb/cUjSyTedX/WzKIlEHqBhm9KHlSbioOCI8l6PYjwfKiOFuk3Z1ga+8lbuGaYERqcPxU/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mnmg71r+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56b8e4f38a2so6685707a12.3;
        Tue, 02 Apr 2024 11:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712081332; x=1712686132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yPajt0wkfrUmDNCK/4HztgYN3+2Q0FGGIKzk5aPDc4c=;
        b=Mnmg71r+jG7wU8EpdFakQ4InXWYAh0AcEx8tX2/QNDNfDtKV7MmfjNhEOoaN6pAKV3
         JrxOWpXV4T7wK4J/s5A+wdxTni5cC3DdzvChXdGVAM//6sUQ5x2Vt+MTD+rYKEI9Gl0s
         rWWiHqheirV4yawrFNB2nDoJzcRgS++dswwAZumztawaIz6Kv3cbRLZNsMx0jZaORvjN
         N10MMNSZZhv5OREpiVStxNm8uldTcqLXgjxVKzc/S1LXwQHp7iC6DehQuvj78WMlc5pN
         +NSWfuX2fWbQYAGyddZufhK1/8BtVVVg7xTyeCnRpc1F4hNWE8/kIfHAR4GDSkwteZUw
         ZicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712081332; x=1712686132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPajt0wkfrUmDNCK/4HztgYN3+2Q0FGGIKzk5aPDc4c=;
        b=ZsUttA70worE5Ar2oMda9xidgwTMHKOWgm/mOW849qsfkvZy/UCK/qhJq00Iggd6SI
         0+mkWJvFyuc/S6scs0Imq78pQ2k/7CA3u5lgXc1rJVJfjG8yvbrAWUPBCaNdGz+ZW4YO
         bq89PqAWMOxvym68rosvrtQ/3Cn7I8MydgGpPi5fLWpbVFCooeL2UtInPcTU9QyIUZMZ
         Q/Ue9I0yMJQk7IegbkyqKtHMfpNApB0snS079hlSc4qu4cQ4/wbGJs+i041v+7IVWz0I
         YTTGw0dUr55qiAkGj2sGajI/ShAKFS8AjERWWInsAi59V4hChupP2IdAtI+Dhhh01WbD
         Ft3A==
X-Forwarded-Encrypted: i=1; AJvYcCWZgfUIjTUBa+Y+uK9J+hx2a9gwLUf5ok+nSjpKyJCSqMwcW/nyVMHbcUVXjeMkZH1AiYAXr2r4FM1HFWlPe7oGPEje7G0JS0RRCd+rlU129gLQqwIAzOQQeUG5eyjiuzjuO7IU/Qpp
X-Gm-Message-State: AOJu0YwHCH+fC7XlsSlP4RWJKJDd+1zRj4afZropDC7Gq5rwIfeK0K1r
	d2fYr7lgbp7qdUCUUrm5FGtze6mKFgiiIZlPeDkJVDkusUBC9QBG
X-Google-Smtp-Source: AGHT+IF7elTuRqdSa3UdzutvqEMGB6VUwK+kTj5XSqeSlFf7EJeQWdnD60z+Lb8tXbO/K7RNxFvEjg==
X-Received: by 2002:a50:9359:0:b0:568:9936:b2e with SMTP id n25-20020a509359000000b0056899360b2emr417423eda.24.1712081331608;
        Tue, 02 Apr 2024 11:08:51 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:7185:ec3b:3142:ff0a])
        by smtp.gmail.com with ESMTPSA id u17-20020aa7db91000000b0056c06d5dce1sm7078714edt.81.2024.04.02.11.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 11:08:50 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Tue, 2 Apr 2024 20:08:49 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] iio: pressure: Add triggered buffer support for
 BMP280 driver
Message-ID: <20240402180849.GB18068@vamoiridPC>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
 <20240319002925.2121016-7-vassilisamir@gmail.com>
 <20240324121418.570857a9@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324121418.570857a9@jic23-huawei>

On Sun, Mar 24, 2024 at 12:14:18PM +0000, Jonathan Cameron wrote:
> On Tue, 19 Mar 2024 01:29:25 +0100
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > BMP2xx, BMP3xx, and BMP5xx use consecutive buffers for their
> > temperature, pressure and humidity readings. This facilitates
> > the use of burst reads in order to acquire data much faster
> > and in a different way from the one used in oneshot captures.
> > 
> > BMP085 and BMP180 use a completely different measurement
> > process that is well defined and is used in their buffer_handler().
> > 
> > Suggested-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> 
> Various comments inline,
> 
> Thanks,
> Jonathan
> 
> > ---
> >  drivers/iio/pressure/Kconfig       |   2 +
> >  drivers/iio/pressure/bmp280-core.c | 231 +++++++++++++++++++++++++++--
> >  drivers/iio/pressure/bmp280-spi.c  |   8 +-
> >  drivers/iio/pressure/bmp280.h      |  14 +-
> >  4 files changed, 241 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> > index 79adfd059c3a..5145b94b4679 100644
> > --- a/drivers/iio/pressure/Kconfig
> > +++ b/drivers/iio/pressure/Kconfig
> > @@ -31,6 +31,8 @@ config BMP280
> >  	select REGMAP
> >  	select BMP280_I2C if (I2C)
> >  	select BMP280_SPI if (SPI_MASTER)
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> >  	help
> >  	  Say yes here to build support for Bosch Sensortec BMP180, BMP280, BMP380
> >  	  and BMP580 pressure and temperature sensors. Also supports the BME280 with
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > index ddfcd23f29a0..ffcd17807cf5 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -40,7 +40,10 @@
> >  #include <linux/regmap.h>
> >  #include <linux/regulator/consumer.h>
> >  
> > +#include <linux/iio/buffer.h>
> >  #include <linux/iio/iio.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>
> >  
> >  #include <asm/unaligned.h>
> >  
> > @@ -454,7 +457,7 @@ static int bmp280_read_temp(struct bmp280_data *data, s32 *comp_temp)
> >  	int ret;
> >  
> >  	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
> > -			       data->buf, sizeof(data->buf));
> > +			       data->buf, BMP280_NUM_TEMP_BYTES);
> >  	if (ret < 0) {
> >  		dev_err(data->dev, "failed to read temperature\n");
> >  		return ret;
> > @@ -484,7 +487,7 @@ static int bmp280_read_press(struct bmp280_data *data, u32 *comp_press)
> >  		return ret;
> >  
> >  	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
> > -			       data->buf, sizeof(data->buf));
> > +			       data->buf, BMP280_NUM_PRESS_BYTES);
> >  	if (ret < 0) {
> >  		dev_err(data->dev, "failed to read pressure\n");
> >  		return ret;
> > @@ -513,13 +516,13 @@ static int bmp280_read_humid(struct bmp280_data *data, u32 *comp_humidity)
> >  		return ret;
> >  
> >  	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB,
> > -			       &data->be16, sizeof(data->be16));
> > +			       &data->be16, BME280_NUM_HUMIDITY_BYTES);
> >  	if (ret < 0) {
> >  		dev_err(data->dev, "failed to read humidity\n");
> >  		return ret;
> >  	}
> >  
> > -	adc_humidity = be16_to_cpu(data->be16);
> > +	adc_humidity = get_unaligned_be16(&data->be16);
> 
> If it's a be16, how did it become unaligned?
> 
> >  	if (adc_humidity == BMP280_HUMIDITY_SKIPPED) {
> >  		/* reading was skipped */
> >  		dev_err(data->dev, "reading humidity skipped\n");
> > @@ -931,6 +934,73 @@ static int bmp280_chip_config(struct bmp280_data *data)
> >  	return ret;
> >  }
> >  
> > +static irqreturn_t bmp280_buffer_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct bmp280_data *data = iio_priv(indio_dev);
> > +	s32 adc_temp, adc_press, adc_humidity;
> > +	u8 size_of_burst_read;
> > +	int ret, chan_value;
> > +
> > +	guard(mutex)(&data->lock);
> > +
> > +	if (test_bit(BME280_HUMID, indio_dev->active_scan_mask))
> 
> This confuses me a little. Is it allowing reuse of this function for
> multiple devices or aiming to optimise the read in the case of
> the humidity channel being disabled (in which case I don't think
> it works because you aren't providing that combination in avail_scan_masks.)
> 
> Add a comment to explain.
> 

Hi Jonathan,

It is aimed to reuse the function both for BMP280 and BME280 so that's why is
there, it's not in case humidity channel is disabled. I can add a comment it
is definitely not obvious. Thanks for pointing this out.

By applying the changes that you pointed out + by implementing the changes
that you proposed in a previous patch to split the t_fine calculation this
patch will become much cleaner, thanks a lot!

Cheers,
Vasilis
> > +		size_of_burst_read = 8;
> > +	else
> > +		size_of_burst_read = 6;
> > +
> > +	/* Burst read data registers */
> > +	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
> > +			       data->buf, 8);
> > +	if (ret) {
> > +		dev_err(data->dev, "failed to read sensor data\n");
> > +		return ret;
> > +	}
> > +
> > +	/* Temperature calculations */
> > +	memcpy(&chan_value, &data->buf[3], 3);
> > +
> > +	adc_temp = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&chan_value));
> > +	if (adc_temp == BMP280_TEMP_SKIPPED) {
> > +		/* reading was skipped */
> Similar comments on this to below (I read backwards as normally code makes
> more sense that way :)
> > +		dev_err(data->dev, "reading temperature skipped\n");
> > +		return -EIO;
> > +	}
> > +	data->iio_buf.sensor_data[0] = bmp280_compensate_temp(data, adc_temp);
> > +
> > +	/* Pressure calculations */
> > +	memcpy(&chan_value, &data->buf[0], 3);
> > +
> > +	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&chan_value));
> > +	if (adc_press == BMP280_PRESS_SKIPPED) {
> > +		/* reading was skipped */
> > +		dev_err(data->dev, "reading pressure skipped\n");
> > +		return -EIO;
> > +	}
> > +	data->iio_buf.sensor_data[1] = bmp280_compensate_press(data, adc_press);
> > +
> > +	/* Humidity calculations */
> > +	if (test_bit(BME280_HUMID, indio_dev->active_scan_mask)) {
> > +		memcpy(&chan_value, &data->buf[6], 2);
> > +
> > +		adc_humidity = get_unaligned_be16(&chan_value);
> > +		if (adc_humidity == BMP280_HUMIDITY_SKIPPED) {
> > +			/* reading was skipped */
> > +			dev_err(data->dev, "reading humidity skipped\n");
> > +			return -EIO;
> > +		}
> > +	data->iio_buf.sensor_data[2] = bmp280_compensate_humidity(data, adc_humidity);
> Alignment of code looks wrong.
> 
> > +	}
> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &data->iio_buf,
> > +					   iio_get_time_ns(indio_dev));
> > +
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> 
> > +static irqreturn_t bmp380_buffer_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct bmp280_data *data = iio_priv(indio_dev);
> > +	s32 adc_temp, adc_press;
> > +	int ret, chan_value;
> > +
> > +	guard(mutex)(&data->lock);
> > +
> > +	/* Burst read data registers */
> > +	ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB,
> > +			       data->buf, 6);
> > +	if (ret) {
> > +		dev_err(data->dev, "failed to read sensor data\n");
> > +		return ret;
> > +	}
> > +
> > +	/* Temperature calculations */
> > +	memcpy(&chan_value, &data->buf[3], 3);
> > +
> > +	adc_temp = get_unaligned_le24(&chan_value);
> 
> Same comments as below.
> 
> > +	if (adc_temp == BMP380_TEMP_SKIPPED) {
> > +		/* reading was skipped */
> > +		dev_err(data->dev, "reading temperature skipped\n");
> > +		return -EIO;
> > +	}
> > +	data->iio_buf.sensor_data[0] = bmp380_compensate_temp(data, adc_temp);
> > +
> > +	/* Pressure calculations */
> > +	memcpy(&chan_value, &data->buf[0], 3);
> > +
> > +	adc_press = get_unaligned_le24(&chan_value);
> > +	if (adc_press == BMP380_PRESS_SKIPPED) {
> > +		/* reading was skipped */
> > +		dev_err(data->dev, "reading pressure skipped\n");
> > +		return -EIO;
> > +	}
> > +	data->iio_buf.sensor_data[1] = bmp380_compensate_press(data, adc_press);
> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &data->iio_buf,
> > +					   iio_get_time_ns(indio_dev));
> > +
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> 
> > +static irqreturn_t bmp580_buffer_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct bmp280_data *data = iio_priv(indio_dev);
> > +	s32 adc_temp, adc_press;
> > +	int ret, chan_value;
> > +
> > +	guard(mutex)(&data->lock);
> > +
> > +	/* Burst read data registers */
> > +	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB,
> > +			       data->buf, 6);
> > +	if (ret) {
> > +		dev_err(data->dev, "failed to read sensor data\n");
> > +		return ret;
> > +	}
> > +
> > +	/* Temperature calculations */
> > +	memcpy(&chan_value, &data->buf[3], 3);
> > +
> > +	adc_temp = get_unaligned_le24(&chan_value);
> 
> As in other thread branch, get it directly from &data->buf[3]
> rather than bouncing it via another buffer.
> 
> > +	if (adc_temp == BMP580_TEMP_SKIPPED) {
> > +		/* reading was skipped */
> > +		dev_err(data->dev, "reading temperature skipped\n");
> > +		return -EIO;
> -EIO isn't irqreturn_t 
> 
> There isn't a good way to return errors from interrupt handlers,
> so just return IRQ_HANDLED after printing the error message.
> 
> > +	}
> > +	data->iio_buf.sensor_data[0] = adc_temp;
> > +
> > +	/* Pressure calculations */
> > +	memcpy(&chan_value, &data->buf[0], 3);
> > +
> > +	adc_press = get_unaligned_le24(&chan_value);
> As above, get it directly.
> 
> > +	if (adc_press == BMP580_PRESS_SKIPPED) {
> > +		/* reading was skipped */
> > +		dev_err(data->dev, "reading pressure skipped\n");
> > +		return -EIO;
> return IRQ_HANDLED;
> 
> > +	}
> > +	data->iio_buf.sensor_data[1] =  adc_press;
> Extra space.
> 
> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &data->iio_buf,
> > +					   iio_get_time_ns(indio_dev));
> > +
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> >  static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
> >  static const u8 bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
> >  static const int bmp580_temp_coeffs[] = { 1000, 16 };
> > @@ -1903,6 +2075,8 @@ const struct bmp280_chip_info bmp580_chip_info = {
> >  	.read_temp = bmp580_read_temp,
> >  	.read_press = bmp580_read_press,
> >  	.preinit = bmp580_preinit,
> > +
> > +	.buffer_handler = bmp580_buffer_handler
> >  };
> >  EXPORT_SYMBOL_NS(bmp580_chip_info, IIO_BMP280);
> >  
> > @@ -2054,7 +2228,7 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
> >  		return ret;
> >  
> >  	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB,
> > -			       data->buf, sizeof(data->buf));
> > +			       data->buf, BMP280_NUM_PRESS_BYTES);
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -2122,6 +2296,35 @@ static int bmp180_chip_config(struct bmp280_data *data)
> >  	return 0;
> >  }
> >  
> > +static irqreturn_t bmp180_buffer_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct bmp280_data *data = iio_priv(indio_dev);
> > +	int ret, chan_value;
> > +
> > +	guard(mutex)(&data->lock);
> > +
> > +	ret = data->chip_info->read_temp(data, &chan_value);
> > +	if (ret)
> > +		return ret;
> > +
> > +	data->iio_buf.sensor_data[0] = chan_value;
> > +
> > +	ret = data->chip_info->read_press(data, &chan_value);
> 
> Given my earlier suggestion to stop hiding t_fine in the
> structure, these callbacks will need to bring it all the way out
> here (from the temperature read) and pass it back into the
> pressure read.
> 
> That will have the pleasing side effect of making it obvious why
> we aren't handling subsets of channels (as they aren't
> independent)
> 
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	data->iio_buf.sensor_data[1] = chan_value;
> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &data->iio_buf,
> > +					   iio_get_time_ns(indio_dev));
> > +
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> 
> > diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
> > index a444d4b2978b..dc297583cac1 100644
> > --- a/drivers/iio/pressure/bmp280-spi.c
> > +++ b/drivers/iio/pressure/bmp280-spi.c
> > @@ -40,14 +40,14 @@ static int bmp380_regmap_spi_read(void *context, const void *reg,
> >  				  size_t reg_size, void *val, size_t val_size)
> >  {
> >  	struct spi_device *spi = to_spi_device(context);
> > -	u8 rx_buf[4];
> > +	u8 rx_buf[9];
> >  	ssize_t status;
> >  
> >  	/*
> > -	 * Maximum number of consecutive bytes read for a temperature or
> > -	 * pressure measurement is 3.
> > +	 * Maximum number of a burst read for temperature, pressure, humidity
> > +	 * is 8 bytes.
> 
> Once this 8 is expressed as the sum of the 3 types, you can drop the comment
> as it will add nothing useful.
> 
> >  	 */
> > -	if (val_size > 3)
> > +	if (val_size > 8)
> >  		return -EINVAL;
> >  
> >  	/*
> > diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> > index 8cc3eed70c18..32155567faf6 100644
> > --- a/drivers/iio/pressure/bmp280.h
> > +++ b/drivers/iio/pressure/bmp280.h
> > @@ -301,6 +301,10 @@
> >  #define BMP280_PRESS_SKIPPED		0x80000
> >  #define BMP280_HUMIDITY_SKIPPED		0x8000
> >  
> > +#define BMP280_NUM_TEMP_BYTES		3
> > +#define BMP280_NUM_PRESS_BYTES		3
> > +#define BME280_NUM_HUMIDITY_BYTES	2
> > +
> >  /* Core exported structs */
> >  
> >  static const char *const bmp280_supply_names[] = {
> > @@ -400,13 +404,19 @@ struct bmp280_data {
> >  	 */
> >  	s32 t_fine;
> >  
> > +	/* Data to push to userspace */
> > +	struct {
> > +		s32 sensor_data[3];
> 
> This doesn't work (as explanation of data) for all cases.
>  If you only have 2 channels, the packing needs to be.
> 
> 		s32 sensor_data[2];
> //no padding
> 		s64 timestamp __aligned(8);
> > +		s64 timestamp __aligned(8);
> > +	} iio_buf;
> > +
> So using a structure for this definition isn't a bug as such as the core
> doesn't care that you provide a bigger buffer than needed, but it is misleading.
> Use something along lines of
> 
> 	/* Up to 3 channels and aligned s64 timestamp */
> 	s32 sensor_data[6] __aligned(8);
> 
> or use a union of two structures to cover the two layouts making
> sure to write and read from the correct one in each callback.
> 
> >  	/*
> >  	 * DMA (thus cache coherency maintenance) may require the
> >  	 * transfer buffers to live in their own cache lines.
> >  	 */
> >  	union {
> >  		/* Sensor data buffer */
> > -		u8 buf[3];
> > +		u8 buf[8];
> As in previous discussion - build this up as a sum of what can go in it.
> Maybe via a define for BMP280_BURST_READ_MAX 
> 

