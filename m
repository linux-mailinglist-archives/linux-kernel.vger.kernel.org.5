Return-Path: <linux-kernel+bounces-109248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D84D8816C5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C39282395
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D84E6A34D;
	Wed, 20 Mar 2024 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aphH19uY"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20B91E516;
	Wed, 20 Mar 2024 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710956769; cv=none; b=U8CK14ZwtOq5EE/z/NVfyUECtkiNYYYon6PD+l1KY9q+kM7VmD4obLu58CfBqBV03EisKAOdoKWXfyQW8IkA5JeQBVZkuSjus2yWTARW1hbATQO0ZcpsCn/CYCExjhAqvpJMoyKycFEgv3yrJIJc9iMtZkR37gD2YjtMlHSaN0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710956769; c=relaxed/simple;
	bh=8HRE26fyQkRW9iVsv2sZNw1cR4nxIwXWDyfSWyN29CM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEmupqSJi3JPKg5xXxoN1vTQPFg/ECjbBnz34ofHpMw0UViUnwADwMnB+WDv8Wxq+K82/JHq/shPpvm1Rqtw2CrP7ICatAdU1KAaGkFWdd/ZASKSQParx/LvJguNWdgyxmfl7NrGij54Qz22FK2fyaLC7sI8iUjzR+h46LyQG/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aphH19uY; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-568a19fcc4eso24885a12.1;
        Wed, 20 Mar 2024 10:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710956766; x=1711561566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uLnwr6kAaqCFFqFTCtq0OEf90m0PhQT0u6ZhzLE2J7k=;
        b=aphH19uYVzUKncumnV0y7KEvzLO5xSsOuEoWHRWE2bYJRGyn7wCzBi0bwF22Df+FQX
         yT+0yui1eHe5qqZVtZKPmZASp7L6dK83sgVfoYsgHvi5277BV14TAWEwHIAQzac3WMmu
         kaYsznvygMjiFZmtYqFiP01AfVggc4pIp7BbV5/uAlIdGkPBFQ9F/c9YANT67HDTt/j+
         j5coMa5Zc14TzFnIhnlgnNKlaUnR9ETFGk7lTuW23Xr60p3j5pAeUYb3b7EbEd/TMcTt
         nZGVirVCkl0rYGykcFgiskZCnd40QDyRKPxA4N5dKpM5nQzc3d9v8NBHjfgQ/vAZ1Hyv
         AB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710956766; x=1711561566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLnwr6kAaqCFFqFTCtq0OEf90m0PhQT0u6ZhzLE2J7k=;
        b=LrmnxtrHyXPMaI/wLKfCEzhO08EID8sIR/nKmxJtXhaaVK5jEOEhFFGIALQ35HTbO2
         H7J5gIwu2+NTCD+DZR8tcLhtKWLu651g7NDGDaWDh6IIr6XIJnim5mqRmceCV6xp++cw
         SqIz+laKuTPIl1t8ij1e5VRzcRt3SajxiuqK+/+WLBOIkNqlOQ7T+AyO25wn+v56JgE2
         nHPQOvTo8Bdu5ZtRqFCcXWUldmh6+uwen6jvvMGB21Wfatn6UgAPPQ/gpcu9cS4qiFsA
         DmqXBAcbO+rceqWRqtTukEsB0qr7sugUxpKkemwXMZ3bXQkgfKsOca5HN4osUBgm6d9W
         Ox1g==
X-Forwarded-Encrypted: i=1; AJvYcCWKQv099jrDpOtrVrqtIEVJHzOXG7n4qFZhWe09HVk6a3mM/MDlOKIK1CIzrm3xkncaBU3+5jA352zntq5pvcqyE02V0Na+t2a0RJjmdHcgBsxxBqN/l+t3+U4z/woSyf1LX0q5RmJ0
X-Gm-Message-State: AOJu0Yx5sN6VmJ83khK8hp1FMSFfvdLcE+yR3qBwl0gxZXRMWQAB/WRR
	XyXCtg05eDHPKo4Cz3V9Zj5cg5xNxa7tIEvNGEyjJj1echVZLjZX
X-Google-Smtp-Source: AGHT+IFYcZuy7aRBYUVRY7RS9GAmgp66Vfk8Ldu1sqzBaKrP34rebcloHPSiHYKKsMFF2/SjpSDH5A==
X-Received: by 2002:a05:6402:159b:b0:566:be15:9a88 with SMTP id ij27-20020a056402159b00b00566be159a88mr10909593edb.20.1710956765887;
        Wed, 20 Mar 2024 10:46:05 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:9be1:7bef:ff5c:57fc])
        by smtp.gmail.com with ESMTPSA id z1-20020aa7cf81000000b0056835320f76sm7211240edx.8.2024.03.20.10.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 10:46:05 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 20 Mar 2024 18:46:02 +0100
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, ang.iglesiasg@gmail.com, mazziesaccount@gmail.com,
	ak@it-klinger.de, petre.rodan@subdimension.ro, phil@raspberrypi.com,
	579lpy@gmail.com, linus.walleij@linaro.org,
	semen.protsenko@linaro.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] iio: pressure: Add triggered buffer support for
 BMP280 driver
Message-ID: <20240320174602.GA36450@vamoiridPC>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
 <20240319002925.2121016-7-vassilisamir@gmail.com>
 <ZfrFc9GF0_Jix5YT@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfrFc9GF0_Jix5YT@smile.fi.intel.com>

On Wed, Mar 20, 2024 at 01:16:03PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 19, 2024 at 01:29:25AM +0100, Vasileios Amoiridis wrote:
> > BMP2xx, BMP3xx, and BMP5xx use consecutive buffers for their
> > temperature, pressure and humidity readings. This facilitates
> > the use of burst reads in order to acquire data much faster
> > and in a different way from the one used in oneshot captures.
> > 
> > BMP085 and BMP180 use a completely different measurement
> > process that is well defined and is used in their buffer_handler().
> 
> ...
> 
> >  	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
> > -			       data->buf, sizeof(data->buf));
> > +			       data->buf, BMP280_NUM_TEMP_BYTES);
> 
> >  	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
> > -			       data->buf, sizeof(data->buf));
> > +			       data->buf, BMP280_NUM_PRESS_BYTES);
> 
> >  	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB,
> > -			       &data->be16, sizeof(data->be16));
> > +			       &data->be16, BME280_NUM_HUMIDITY_BYTES);
> 
> > -	adc_humidity = be16_to_cpu(data->be16);
> > +	adc_humidity = get_unaligned_be16(&data->be16);
> 
> >  	ret = regmap_bulk_read(data->regmap, BMP380_REG_TEMP_XLSB,
> > -			       data->buf, sizeof(data->buf));
> > +			       data->buf, BMP280_NUM_TEMP_BYTES);
> 
> >  	ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB,
> > -			       data->buf, sizeof(data->buf));
> > +			       data->buf, BMP280_NUM_PRESS_BYTES);
> 
> >  	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB, data->buf,
> > -			       sizeof(data->buf));
> > +			       BMP280_NUM_TEMP_BYTES);
> 
> >  	ret = regmap_bulk_read(data->regmap, BMP580_REG_PRESS_XLSB, data->buf,
> > -			       sizeof(data->buf));
> > +			       BMP280_NUM_PRESS_BYTES);
> 
> These smell to me as candidates to a separate patch with more explanation why.
> (Yes, with the definitions you introduced.) But I leave it to Jonathan to
> decide if we need to split.
> 
> ...
> 
> The below are applicable to the bmp280_buffer_handler(),
> bmp380_buffer_handler() implementations as well.
> 
> ...
> 
> > +	/* Burst read data registers */
> > +	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB,
> > +			       data->buf, 6);
> 
> Magic size.
> 

Hi Andy,

Thank you again for your feedback. When I was writing it, it was 
looking as a magic number to me as well but then I though that 
since I put the comment above it could be obvious. Now that I see 
it again, I think it was not a good idea and maybe some type of 
definition like

	#define BMP280_BURST_READ_NUM_BYTES 6
	#define BME280_BURST_READ_NUM_BYTES 8

could look better and be more intuitive.

> ...
> 
> > +	/* Temperature calculations */
> > +	memcpy(&chan_value, &data->buf[3], 3);
> 
> _le24() + sign_extend32()?
> 

In the next line from your comment the _le24 or _be24 takes place.
If the sign_extend32() is needed here, shouldn't it also be used
in all the oneshot captures as well?

> ...
> 
> > +	/* Pressure calculations */
> > +	memcpy(&chan_value, &data->buf[0], 3);
> 
> _le24() + sign_extend32()?
> 
> ...
> 
> >  	/*
> > -	 * Maximum number of consecutive bytes read for a temperature or
> > -	 * pressure measurement is 3.
> > +	 * Maximum number of a burst read for temperature, pressure, humidity
> > +	 * is 8 bytes.
> >  	 */
> > -	if (val_size > 3)
> > +	if (val_size > 8)
> 
> sizeof() / new definition for the buf[] size?
> 

In a previous commit that I was fixing this SPI driver, Jonathan had mentioned
that there is no need for a specific definition since it will only be used
here so that's why I kept it as is.

Cheers,
Vasilis
> >  		return -EINVAL;
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

