Return-Path: <linux-kernel+bounces-144419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2545A8A4631
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 01:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD3B1F214E8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 23:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36084137761;
	Sun, 14 Apr 2024 23:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hf57xM7j"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2971E504;
	Sun, 14 Apr 2024 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713138082; cv=none; b=Et6CHkHb4tHOo6X5FKYstHRDwR3rXRJDiorE/7fQx1Gkutgg/7dx9rGFp1IB5YBtnhrvo6/ASLNikH6ybhKAG3rr8tvxdb31BOgM+SN7zZoJiaeNhM05DG/NhW2EAP/Fb8+ojT/Q/GcjwciYijRAdvEGtvMngABEerRyHJoJcPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713138082; c=relaxed/simple;
	bh=ZZy2FiSX/H6SqW4Rod7Azv5HByKa14BTEwY8EQqCcWU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8mBacsGdJxIdU3PBhLlLaSj+Fo9teIdYqgI6Lk9TNis+RkU7x1PSC4r2QmeoMZEe1s6vfjHYLDrVx42GIKQ+DBG22f5Adg3ORRGXVwP3h5RuPlO7ttgTkQr6df+qMAYCFwe5dTG8cQcrCi0jiC3lp+0aRmocn+RyxW7BgAplJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hf57xM7j; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a526fca6c6aso14057766b.0;
        Sun, 14 Apr 2024 16:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713138078; x=1713742878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RUUV6FmHCmgqELPrvWglywjDbIZmc2CJB97Mr3iuqNA=;
        b=hf57xM7jUGXo3dBCt8vRaf0FzygYRpRyK1Jpgdn9estKNk+hQ7zECJZ6FG+g9LGwT6
         MkWrOhkQFLjXC94WmZvgvt1GhhMUWD4jZ0pSP2b1MJ6fVe/AC2DCSbeqCDrwZMmHBdYu
         FFyBrTb3QLsZvXllWqkzM8r37xhhQd0WGL7zgsFaDo6txENUtWI0ngHv4Sp5VqMs5U03
         OnGenS9HVMTbDsbGSUNCMSIvkl6RWhlw905Pjc7ejA6Btfzmh22BSVJH+zJfrlB4zjHs
         p7Ys0+JXwNd66pOrdd78+x21LhBbpcWttlG3DQ1c7hHErgXtBn5Ip1REWu1wnOZxinjb
         ziCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713138078; x=1713742878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUUV6FmHCmgqELPrvWglywjDbIZmc2CJB97Mr3iuqNA=;
        b=awnhktOhGz01eSlJ6Uw83Q5l84cDTyR/ICDg/iEpksHO1bphUIrR7gmnJnpo1M00JG
         a4k0RHVNnWE2aBLdep/wxp2MeIm41JNK1rtf9CAeoH30xKZZw5VtByyC3c4SoAGKiK0c
         xmT/N97CAdZqvNfXXBXjVlEyVFXIFQAiBCgYmA8LYlscs8zBSKm9T7Vb7NhsQZ5q1l8/
         N/1sjdHkbnMdvDgqAgRQAQdZk8xNDmHrWzzVTBQSV5GURWxVA+glKatbQvkdeAF5voLl
         rhAxjBRwN7LScCR/wG+LyyqJUpjiYJV1qU55HRD5Hg2isfDbpS1i3l6WqoMpHuaUzazj
         D2xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGubGbhA3aqzkd11/hHkogwIjM2PEXq3w7zPDfzMzoxqeNE/jrBVBdLj9veQI6WpQ98x6Hm4FfRVrRPOr+Xnuksp6S/tnOY2oHI+iltIPyqXkISlKei8Lw4C0tHaCmyjg2V78S+SXF
X-Gm-Message-State: AOJu0YwVaaY0KP7wAyehEbRdYVTnc7R/8D6emZmsikBPn1wELjYt0hqv
	7/WyPXaPn+F7F2/uHTUekSbzD6ZTslZKKEONeF2JaNm8BvIhpBx4lKkhYkY3l1Y=
X-Google-Smtp-Source: AGHT+IGoiX+exxvd5UVE4g9Jqe8NLcsVBNyOY2FCFMPmvlR3nhSNK//qaqOVTKbsE6GtAmZywn8jNA==
X-Received: by 2002:a17:906:13db:b0:a4e:6957:de25 with SMTP id g27-20020a17090613db00b00a4e6957de25mr5516527ejc.57.1713138077861;
        Sun, 14 Apr 2024 16:41:17 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:702f:9107:7672:fa9d])
        by smtp.gmail.com with ESMTPSA id nb17-20020a1709071c9100b00a4e6582edf8sm4686060ejc.102.2024.04.14.16.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 16:41:17 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Mon, 15 Apr 2024 01:41:14 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	andriy.shevchenko@linux.intel.com, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	u.kleine-koenig@pengutronix.de, biju.das.jz@bp.renesas.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] iio: pressure: bmp280: Various driver cleanups
Message-ID: <20240414234114.GA33095@vamoiridPC>
References: <20240407172920.264282-1-vassilisamir@gmail.com>
 <20240407172920.264282-2-vassilisamir@gmail.com>
 <20240413175257.6cadbb83@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240413175257.6cadbb83@jic23-huawei>

On Sat, Apr 13, 2024 at 05:52:57PM +0100, Jonathan Cameron wrote:
> On Sun,  7 Apr 2024 19:29:15 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Various driver cleanups including:
> > 
> Not sure how we got to a v4 with a patch title various.
> 
> If you have to list multiple changes, it should normally
> be multiple patches.
> 
> White space can all be grouped, but the others should be separate.
> Please break it up for v5.
> 
> I'll take a look at the actual changes even though I won't merge
> a 'various' patch like this.
> 
> I may well miss things because there is simply too much in here
> and some of the diffs are subtle as it can be hard to spot
> if it's a name change or a functional change.
> 
> > a) change names of functions that are used by all sensors from
> >    bmp280_read_raw_* to bmp_read_raw_* to make it more clear that
> >    these functions are general and not tied to the BMP280 sensor.
> Don't.  Convention is to naming such function after the first supported
> part.  We've tried generic naming in the past and often becomes even
> less clear.  Already you have bmp_x functions applying to bme devices.
> Sooner or later you will have them applying to an xyz280 where none
> of the letter matter.
> > 
> 
> 
> > b) modify some defines that are used only by the BME280 sensor
> >    to use the naming convention BME280_* and not BMP280_*.
> 
> This is fine, but also move them so they aren't in blocks labeled
> BMP280 specific registers.
> 
> > 
> > c) add various error messages that were not implemented.
> Also fine in a patch on their own.
> > 

While reflecting a bit on that, I would like to ask the following:

In case of regmap_{bulk/}_{read/write/update}() functions, they always
return 0 on success and negative errno in error cases. This driver is
a bit incosistent with many cases checking for returned errors with
the following 2 forms:

a) if (ret) {
	...
   }

b) if (ret < 0) {
	...
   }

Which one is prefered in general?

Cheers,
Vasilis
> > d) sort headers.
> Separate patch and this is probably fine.
> 
> > 
> > e) fix various indentation errors which were found by checkpatch.pl.
> 
> White space fixes always belong in a patch that does nothing else.
> 
> > 
> > g) Add identifier names in function definitions which were warned
> >    by checkpatch.pl.
> This is fine, but again not in a patch making other changes.
> 
> I want to be reading a patch whilst just looking at one type of thing.
> It is much quicker to review 6 single purpose patches than 1 patch
> combining all 6.
> 
> 
> Jonathan
> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  drivers/iio/pressure/bmp280-core.c   | 244 ++++++++++++++-------------
> >  drivers/iio/pressure/bmp280-i2c.c    |   2 +-
> >  drivers/iio/pressure/bmp280-regmap.c |   8 +-
> >  drivers/iio/pressure/bmp280-spi.c    |   8 +-
> >  drivers/iio/pressure/bmp280.h        |  50 +++---
> >  5 files changed, 159 insertions(+), 153 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > index 09f53d987c7d..1c51139cbfcf 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -52,7 +52,6 @@
> >   */
> >  enum { AC1, AC2, AC3, AC4, AC5, AC6, B1, B2, MB, MC, MD };
> >  
> > -
> >  enum bmp380_odr {
> >  	BMP380_ODR_200HZ,
> >  	BMP380_ODR_100HZ,
> > @@ -71,7 +70,7 @@ enum bmp380_odr {
> >  	BMP380_ODR_0_01HZ,
> >  	BMP380_ODR_0_006HZ,
> >  	BMP380_ODR_0_003HZ,
> > -	BMP380_ODR_0_0015HZ,
> > +	BMP380_ODR_0_0015HZ
> 
> Why?  We remove the comma when the last element is clearly a terminator, not
> because it happens to be the last element.  This isn't NULL, or _COUNT or similar
> which must always come at the end.
> 
> 
> >  };
> >  
> >  enum bmp580_odr {
> > @@ -106,7 +105,7 @@ enum bmp580_odr {
> >  	BMP580_ODR_1HZ,
> >  	BMP580_ODR_0_5HZ,
> >  	BMP580_ODR_0_25HZ,
> > -	BMP580_ODR_0_125HZ,
> > +	BMP580_ODR_0_125HZ
> 
> As above, I can't see a reason to change this.
> 
> >  };
> >  
> >  /*
> > @@ -131,7 +130,7 @@ enum {
> >  	BMP380_P8 = 16,
> >  	BMP380_P9 = 17,
> >  	BMP380_P10 = 19,
> > -	BMP380_P11 = 20,
> > +	BMP380_P11 = 20
> and again.
> 
> >  };
> >  
> >  static const struct iio_chan_spec bmp280_channels[] = {
> > @@ -181,11 +180,10 @@ static int bmp280_read_calib(struct bmp280_data *data)
> >  	struct bmp280_calib *calib = &data->calib.bmp280;
> >  	int ret;
> >  
> > -
> >  	/* Read temperature and pressure calibration values. */
> >  	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_TEMP_START,
> >  			       data->bmp280_cal_buf, sizeof(data->bmp280_cal_buf));
> > -	if (ret < 0) {
> > +	if (ret) {
> >  		dev_err(data->dev,
> >  			"failed to read temperature and pressure calibration parameters\n");
> >  		return ret;
> > @@ -222,7 +220,7 @@ static int bme280_read_calib(struct bmp280_data *data)
> >  
> >  	/* Load shared calibration params with bmp280 first */
> >  	ret = bmp280_read_calib(data);
> > -	if  (ret < 0) {
> > +	if  (ret) {
> >  		dev_err(dev, "failed to read common bmp280 calibration parameters\n");
> >  		return ret;
> >  	}
> > @@ -235,47 +233,47 @@ static int bme280_read_calib(struct bmp280_data *data)
> >  	 * Humidity data is only available on BME280.
> >  	 */
> >  
> > -	ret = regmap_read(data->regmap, BMP280_REG_COMP_H1, &tmp);
> > -	if (ret < 0) {
> > +	ret = regmap_read(data->regmap, BME280_REG_COMP_H1, &tmp);
> > +	if (ret) {
> >  		dev_err(dev, "failed to read H1 comp value\n");
> >  		return ret;
> >  	}
> >  	calib->H1 = tmp;
> >  
> > -	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H2,
> > +	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H2,
> >  			       &data->le16, sizeof(data->le16));
> > -	if (ret < 0) {
> > +	if (ret) {
> >  		dev_err(dev, "failed to read H2 comp value\n");
> >  		return ret;
> >  	}
> >  	calib->H2 = sign_extend32(le16_to_cpu(data->le16), 15);
> >  
> > -	ret = regmap_read(data->regmap, BMP280_REG_COMP_H3, &tmp);
> > -	if (ret < 0) {
> > +	ret = regmap_read(data->regmap, BME280_REG_COMP_H3, &tmp);
> > +	if (ret) {
> >  		dev_err(dev, "failed to read H3 comp value\n");
> >  		return ret;
> >  	}
> >  	calib->H3 = tmp;
> >  
> > -	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H4,
> > +	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H4,
> >  			       &data->be16, sizeof(data->be16));
> > -	if (ret < 0) {
> > +	if (ret) {
> >  		dev_err(dev, "failed to read H4 comp value\n");
> >  		return ret;
> >  	}
> >  	calib->H4 = sign_extend32(((be16_to_cpu(data->be16) >> 4) & 0xff0) |
> >  				  (be16_to_cpu(data->be16) & 0xf), 11);
> >  
> > -	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_H5,
> > +	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H5,
> >  			       &data->le16, sizeof(data->le16));
> > -	if (ret < 0) {
> > +	if (ret) {
> >  		dev_err(dev, "failed to read H5 comp value\n");
> >  		return ret;
> >  	}
> > -	calib->H5 = sign_extend32(FIELD_GET(BMP280_COMP_H5_MASK, le16_to_cpu(data->le16)), 11);
> > +	calib->H5 = sign_extend32(FIELD_GET(BME280_COMP_H5_MASK, le16_to_cpu(data->le16)), 11);
> >  
> > -	ret = regmap_read(data->regmap, BMP280_REG_COMP_H6, &tmp);
> > -	if (ret < 0) {
> > +	ret = regmap_read(data->regmap, BME280_REG_COMP_H6, &tmp);
> > +	if (ret) {
> >  		dev_err(dev, "failed to read H6 comp value\n");
> >  		return ret;
> >  	}
> > @@ -283,14 +281,14 @@ static int bme280_read_calib(struct bmp280_data *data)
> >  
> >  	return 0;
> >  }
> > +
> >  /*
> >   * Returns humidity in percent, resolution is 0.01 percent. Output value of
> >   * "47445" represents 47445/1024 = 46.333 %RH.
> >   *
> >   * Taken from BME280 datasheet, Section 4.2.3, "Compensation formula".
> >   */
> > -static u32 bmp280_compensate_humidity(struct bmp280_data *data,
> > -				      s32 adc_humidity)
> > +static u32 bme280_compensate_humidity(struct bmp280_data *data, s32 adc_humidity)
> >  {
> >  	struct bmp280_calib *calib = &data->calib.bmp280;
> >  	s32 var;
> > @@ -305,7 +303,7 @@ static u32 bmp280_compensate_humidity(struct bmp280_data *data,
> >  	var = clamp_val(var, 0, 419430400);
> >  
> >  	return var >> 12;
> > -};
> > +}
> >  
> >  /*
> >   * Returns temperature in DegC, resolution is 0.01 DegC.  Output value of
> > @@ -314,8 +312,7 @@ static u32 bmp280_compensate_humidity(struct bmp280_data *data,
> >   *
> >   * Taken from datasheet, Section 3.11.3, "Compensation formula".
> >   */
> > -static s32 bmp280_compensate_temp(struct bmp280_data *data,
> > -				  s32 adc_temp)
> > +static s32 bmp280_compensate_temp(struct bmp280_data *data, s32 adc_temp)
> >  {
> >  	struct bmp280_calib *calib = &data->calib.bmp280;
> >  	s32 var1, var2;
> > @@ -337,8 +334,7 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
> >   *
> >   * Taken from datasheet, Section 3.11.3, "Compensation formula".
> >   */
> > -static u32 bmp280_compensate_press(struct bmp280_data *data,
> > -				   s32 adc_press)
> > +static u32 bmp280_compensate_press(struct bmp280_data *data, s32 adc_press)
> >  {
> >  	struct bmp280_calib *calib = &data->calib.bmp280;
> >  	s64 var1, var2, p;
> > @@ -363,15 +359,14 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
> >  	return (u32)p;
> >  }
> >  
> > -static int bmp280_read_temp(struct bmp280_data *data,
> > -			    int *val, int *val2)
> > +static int bmp280_read_temp(struct bmp280_data *data, int *val, int *val2)
> >  {
> >  	s32 adc_temp, comp_temp;
> >  	int ret;
> >  
> >  	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
> >  			       data->buf, sizeof(data->buf));
> > -	if (ret < 0) {
> > +	if (ret) {
> >  		dev_err(data->dev, "failed to read temperature\n");
> >  		return ret;
> >  	}
> > @@ -396,8 +391,7 @@ static int bmp280_read_temp(struct bmp280_data *data,
> >  	return 0;
> >  }
> >  
> > -static int bmp280_read_press(struct bmp280_data *data,
> > -			     int *val, int *val2)
> > +static int bmp280_read_press(struct bmp280_data *data, int *val, int *val2)
> >  {
> >  	u32 comp_press;
> >  	s32 adc_press;
> > @@ -405,12 +399,12 @@ static int bmp280_read_press(struct bmp280_data *data,
> >  
> >  	/* Read and compensate temperature so we get a reading of t_fine. */
> >  	ret = bmp280_read_temp(data, NULL, NULL);
> > -	if (ret < 0)
> > +	if (ret)
> >  		return ret;
> >  
> >  	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
> >  			       data->buf, sizeof(data->buf));
> > -	if (ret < 0) {
> > +	if (ret) {
> >  		dev_err(data->dev, "failed to read pressure\n");
> >  		return ret;
> >  	}
> > @@ -429,7 +423,7 @@ static int bmp280_read_press(struct bmp280_data *data,
> >  	return IIO_VAL_FRACTIONAL;
> >  }
> >  
> > -static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
> > +static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
> >  {
> >  	u32 comp_humidity;
> >  	s32 adc_humidity;
> > @@ -437,12 +431,12 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
> >  
> >  	/* Read and compensate temperature so we get a reading of t_fine. */
> >  	ret = bmp280_read_temp(data, NULL, NULL);
> > -	if (ret < 0)
> > +	if (ret)
> >  		return ret;
> >  
> > -	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB,
> > +	ret = regmap_bulk_read(data->regmap, BME280_REG_HUMIDITY_MSB,
> >  			       &data->be16, sizeof(data->be16));
> > -	if (ret < 0) {
> > +	if (ret) {
> >  		dev_err(data->dev, "failed to read humidity\n");
> >  		return ret;
> >  	}
> > @@ -453,16 +447,16 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
> >  		dev_err(data->dev, "reading humidity skipped\n");
> >  		return -EIO;
> >  	}
> > -	comp_humidity = bmp280_compensate_humidity(data, adc_humidity);
> > +	comp_humidity = bme280_compensate_humidity(data, adc_humidity);
> >  
> >  	*val = comp_humidity * 1000 / 1024;
> >  
> >  	return IIO_VAL_INT;
> >  }
> >  
> > -static int bmp280_read_raw(struct iio_dev *indio_dev,
> > -			   struct iio_chan_spec const *chan,
> > -			   int *val, int *val2, long mask)
> > +static int bmp_read_raw(struct iio_dev *indio_dev,
> 
> No to this sort of change.  bmp280_ is the prefix for the driver - it doesn't
> mean that it applies only to that part.  As such it is the prefix
> we should use throughout the driver unless a function is specific
> to a different part.  bmp is too generic and may cause namespace issues
> like a clash with something in a header at somepoint in future.
> 
> > diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> > index 5812a344ed8e..ea8eb5691428 100644
> > --- a/drivers/iio/pressure/bmp280.h
> > +++ b/drivers/iio/pressure/bmp280.h
> > @@ -1,10 +1,10 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> >  #include <linux/bitops.h>
> >  #include <linux/device.h>
> > -#include <linux/iio/iio.h>
> >  #include <linux/regmap.h>
> >  #include <linux/regulator/consumer.h>
> >  
> > +#include <linux/iio/iio.h>
> >  
> >  /* BMP580 specific registers */
> >  #define BMP580_REG_CMD			0x7E
> > @@ -192,8 +192,8 @@
> >  #define BMP380_PRESS_SKIPPED		0x800000
> >  
> >  /* BMP280 specific registers */
> > -#define BMP280_REG_HUMIDITY_LSB		0xFE
> > -#define BMP280_REG_HUMIDITY_MSB		0xFD
> > +#define BME280_REG_HUMIDITY_LSB		0xFE
> > +#define BME280_REG_HUMIDITY_MSB		0xFD
> They are in a block called BMP280 specific registers why 
> are they prefixed with BME280?
> 
> If they don't apply to the BMP280 add a new block with
> a comment to say BME280 specific registers.
> 
> 
> >  #define BMP280_REG_TEMP_XLSB		0xFC
> >  #define BMP280_REG_TEMP_LSB		0xFB
> >  #define BMP280_REG_TEMP_MSB		0xFA
> > @@ -207,15 +207,15 @@
> >  #define BMP280_REG_CONFIG		0xF5
> >  #define BMP280_REG_CTRL_MEAS		0xF4
> >  #define BMP280_REG_STATUS		0xF3
> > -#define BMP280_REG_CTRL_HUMIDITY	0xF2
> > +#define BME280_REG_CTRL_HUMIDITY	0xF2
> 
> Jonathan
> 

