Return-Path: <linux-kernel+bounces-103758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9166087C413
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48252283A54
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3DA76052;
	Thu, 14 Mar 2024 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3Mimyx+"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BDB6FE0B;
	Thu, 14 Mar 2024 20:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710447278; cv=none; b=n4Io89PsOLZC2r4vWHCWB+veTNdAHV8zAM+ClxQHd1h8iij5xJQjYaiV+TsLW3Zfmc+TYqNPGRWmbQBgaa0UyQG6NelT2aN7wZejaxBXCYCdVZBXVTN/do0xJW//JIyrceGpYsH/tCVX9HGwYxHg5E8ZiyEdw3WDEe1iep/l/u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710447278; c=relaxed/simple;
	bh=9AlVAxpgVU1ZZvQH4zImz5SRa+iBaVpQEvxehfbaugc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMR+J/kOyTvsWf9X/rORHBFITZ7X/uOPvWnAB9TiKzm5L8AED5wDQUl4R0/G5B9JbJFXFw6ccwmlfxESI2dBIA29J/tPKlCsoXdu58OAsDbGiDW7nNcdS1ixigtEk/iJxwlHrNgOQ33R55T9/8VCDtczqOm2aaQHmSC3ZmIuOUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3Mimyx+; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-568a3292916so1201710a12.1;
        Thu, 14 Mar 2024 13:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710447275; x=1711052075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dAVsxRpCSAmbyqn5Fk9wwRXZVBrTcp4mGzqqEGhqJG4=;
        b=V3Mimyx+RM46oO5LPImQ8CB0yIrfGZAqoQ0CQGSHwiFF6xlYixQ+Kkpnn7j3Csjtkx
         mFt5o6sOLvp+XYx4Mp+WK2kR/29QOVJ+2MqCeKfkvOeaUSmF6PIq8IAeIlvy4WTudjws
         2gF+6cupdSGPu1q6zTNEc8SEqmA7oQxtmkKvMyqMBS2ttv6OqzpVARsUOWNlN8gAzKfo
         XszO6YhRVlOrwXkHCpvU/TjoJ6asoOrOm21rwd/m3viUF+nfr0jNqTDVW8F9Q81NSBjt
         a8ROBe5DxekvcnqgkM8JPyXmDGgdtZyRfVnrQ3b9scqaC05P0n9oj/EeHudEx30g6lS1
         LAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710447275; x=1711052075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAVsxRpCSAmbyqn5Fk9wwRXZVBrTcp4mGzqqEGhqJG4=;
        b=uwxx3KzwdqfYlV/BSIuA0IKsVzkt7TLS8v/WLbT93Z9fGzGVizPL/ONhuodCKhj97Z
         x1/Jck+DNFMfkPX/YhQs9buz7GVF0W49JXzyzw+IWiPq+o0UhdUGUb8JMyJNYT0ENFRh
         J+6HJH81v9tl0EEEywJBC0J1kOCgMO6+ij5jSDkYj5maEJSLiHgSBaxFFJjTWiSs95Ki
         a6MRmwcH2FQfEuLq6+PP5NccY5dGNLB9cqzeXIfgGu2sG39afshDAtZ2vfQ1q7RnfqgM
         JODtqvEz0zIAR7PKniRoi3Q5d9j0E3/V9oua2PiSymXybp01KbEx317/lAK+5P0dWASt
         b7aw==
X-Forwarded-Encrypted: i=1; AJvYcCUvdn4Ntn58sA9d5+tbboBFVPToAI1fXfoNCWPYf01cAb1fbd/1zSqmuX+SGKomHrfK6xv53zHsdiRrhleQfrRwJitvYKyVEoYpj5MihH0YqrgdAg4KiOxWTj09oREEMt1yJ6eZ5IqH
X-Gm-Message-State: AOJu0YzjX0inBQdSzl3vHrb5Ew1HMGifEg27a928Kl6RSPzhjHZ7cWw2
	54rJUmqpzB5rhKsiAP8Mdf/rMhdCyceFHCQz0VfkpQJwEPsFY+vmnJiODXxv3D0Oig==
X-Google-Smtp-Source: AGHT+IGhQkemnkZd/TucjCUzFP/DS2v6zPKoQ11EDcmGDeN9EYpwgHeosTFfHQZwVYrpNwAyS6VGfg==
X-Received: by 2002:a05:6402:321f:b0:568:aa62:738a with SMTP id g31-20020a056402321f00b00568aa62738amr350639eda.35.1710447274300;
        Thu, 14 Mar 2024 13:14:34 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:3844:3925:f1c1:4bc5])
        by smtp.gmail.com with ESMTPSA id et4-20020a056402378400b00568a15b063csm832891edb.2.2024.03.14.13.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 13:14:33 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Thu, 14 Mar 2024 21:14:31 +0100
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, linus.walleij@linaro.org,
	phil@raspberrypi.com, 579lpy@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] iio: pressure: Add triggered buffer support for
 BMP280 driver
Message-ID: <20240314201431.GC1964894@vamoiridPC>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
 <20240313174007.1934983-7-vassilisamir@gmail.com>
 <20240314152525.51bcdcd6@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314152525.51bcdcd6@jic23-huawei>

On Thu, Mar 14, 2024 at 03:25:25PM +0000, Jonathan Cameron wrote:
> On Wed, 13 Mar 2024 18:40:07 +0100
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Add a buffer struct that will hold the values of the measurements
> > and will be pushed to userspace and a buffer_handler function to
> > read the data and push them.
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  drivers/iio/pressure/Kconfig       |  2 +
> >  drivers/iio/pressure/bmp280-core.c | 61 ++++++++++++++++++++++++++++++
> >  drivers/iio/pressure/bmp280.h      |  7 ++++
> >  3 files changed, 70 insertions(+)
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
> > index f2cf9bef522c..7c889cda396a 100644
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
> > @@ -2188,6 +2191,57 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
> >  	return 0;
> >  }
> >  
> > +static irqreturn_t bmp280_buffer_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct bmp280_data *data = iio_priv(indio_dev);
> > +	int ret, temp;
> > +
> > +	/*
> > +	 * data->buf[3] is used to transfer data from the device. Whenever a
> > +	 * pressure or a humidity reading takes place, the data written in the
> > +	 * data->buf[3] overwrites the iio_buf.temperature value. Keep the
> > +	 * temperature value and apply it after the readings.
> 
> See comment below. Given you saw this problem did you not think maybe you
> were doing something a little unusual / wrong? Should have rung alarm
> bells beyond just putting a comment here to explain you needed to work around
> the issue.
> 
> > +	 */
> > +	mutex_lock(&data->lock);
> > +
> > +	if (test_bit(BMP280_TEMP, indio_dev->active_scan_mask)) {
> > +		ret = data->chip_info->read_temp(data);
> > +		if (ret < 0)
> > +			goto done;
> > +
> > +		temp = ret;
> > +	}
> > +
> > +	if (test_bit(BMP280_PRESS, indio_dev->active_scan_mask)) {
> > +		ret = data->chip_info->read_press(data);
> > +		if (ret < 0)
> > +			goto done;
> > +
> > +		data->iio_buf.pressure = ret;
> > +		data->iio_buf.temperature = temp;
> Try running this with the tooling in tools/iio and you'll see that
> you are getting the wrong output if you have just humidity and
> temperature enabled - IIO packs channels, so disable an early
> one and everything moves down in address.
> 
> If you an this device without timestamps and only a single channel
> the buffer used will have one s32 per scan for example.
> 
> > +	}
> > +
> > +	if (test_bit(BME280_HUMID, indio_dev->active_scan_mask)) {
> > +		ret = data->chip_info->read_humid(data);
> > +		if (ret < 0)
> > +			goto done;
> > +
> > +		data->iio_buf.humidity = ret;
> > +		data->iio_buf.temperature = temp;
> > +	}
> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &data->iio_buf,
> > +					   iio_get_time_ns(indio_dev));
> > +
> > +done:
> > +	mutex_unlock(&data->lock);
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> >  static void bmp280_pm_disable(void *data)
> >  {
> >  	struct device *dev = data;
> > @@ -2329,6 +2383,13 @@ int bmp280_common_probe(struct device *dev,
> >  			return ret;
> >  	}
> >  
> > +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> > +					      iio_pollfunc_store_time,
> > +					      &bmp280_buffer_handler, NULL);
> > +	if (ret)
> > +		return dev_err_probe(data->dev, ret,
> > +				     "iio triggered buffer setup failed\n");
> > +
> >  	/* Enable runtime PM */
> >  	pm_runtime_get_noresume(dev);
> >  	pm_runtime_set_active(dev);
> > diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> > index c8cb7c417dab..b5369dd496ba 100644
> > --- a/drivers/iio/pressure/bmp280.h
> > +++ b/drivers/iio/pressure/bmp280.h
> > @@ -407,6 +407,13 @@ struct bmp280_data {
> >  	union {
> >  		/* Sensor data buffer */
> >  		u8 buf[3];
> > +		/* Data buffer to push to userspace */
> 
> Why is this in the union?  This union is to ensure cache safe buffers for
> DMAing directly into.  That's not applicable here.  Even though it may
> be safe to do this (I was reading backwards so wrote a comment here
> on you corrupting temperature before seeing the comment above)
> it is giving a misleading impression of how this struct is used.
> Pull the struct to after t_fine - It only needs to
> be 8 byte aligned and the aligned marking you have will ensure that
>  
> > +		struct {
> > +			s32 temperature;
> > +			u32 pressure;
> > +			u32 humidity;
> 
> As above, this is 3 4 byte buffers but they don't have these meanings
> unless all channels are enabled.
> 
> You could set available mask to enforce that, but don't as it makes
> limited sense for this hardware.  Just make these
> 			u32 chans[3];
> and fill them in with an index incremented for each channel that is
> enabled.
> 
> Jonathan
> 

I wanted to put it inside the union to save some space but you are right
that it is quite misleading. I was just trying in general, along with the
previous patches to avoid reading the temperature twice. Along with your
comments in the previous patch, if a user has enabled both temperature
and pressure and humidity we could save ourselves from reading the
temperature 3 times instead of 1. But in any case, your previous proposal
with a separate get_t_fine structure looks good.

Best regards,
Vasilis
> > +			s64 timestamp __aligned(8);
> > +		} iio_buf;
> >  		/* Calibration data buffers */
> >  		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
> >  		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / 2];
> 

