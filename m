Return-Path: <linux-kernel+bounces-132640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D572F899799
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054FF1C20DB5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F216C146003;
	Fri,  5 Apr 2024 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpsKcGwN"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B9312E75;
	Fri,  5 Apr 2024 08:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712304961; cv=none; b=Dt08WR8IZVxGEk5YWdoxUzi1jqEYUqN52ITYEmmbFAnSSRMfR3RSIpxXs67Uq91lQyfTaJlZkrleTM1s59qzp1OMHDlAyfAvK0vY9X3ISJ2r6tEWYDBV/dWJyjbvrIOxB/a6vBpBZjJeWJ7VRuqGOzRMursZaXWAIerWOmUqHTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712304961; c=relaxed/simple;
	bh=FeJ4F3KjI2QKT6igtyOnb7vRqUsgJRaxxf6bqUdDm7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j19lsfhiP7C2s5a/CihFF/cWD98hH7kYU3S/9l67NCW++6IDBEFi1P+72ll8nGOEo53kgm145xhO+prIhbZRFC/bpuuMnALmxl/hX3nMguvRJFOqxKEXR3ipWw4rtljW403+THOS/ihtRb0wT+ShA4a/WEm1CS3+IE9V8zYSKXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpsKcGwN; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4162fe73594so2542835e9.2;
        Fri, 05 Apr 2024 01:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712304958; x=1712909758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l0EQOfaQpw4diSaNUla+Yt9ZI58t4pKoAeHS1ES6kHY=;
        b=QpsKcGwNrnVYfVvpb/yOwC1OiRWqk2wq9DVQ2Ds147KG6l32wlT5oDlodQBtjwpyHG
         VgLvfULaFu+/Nsskflvt93cKCHWNj2HzzDS39pfWPYFXxHi03LNmjoktCT9cXAtDqdTr
         bjWz2UmOMv8fam3m6V4UTo9OkWOAjEhzWTyP8DxofZzc9BPMxMWIU1ryciMJnAO53DDm
         X6MWJa0F4Cs+YsJIjDHRHWES8MwldifP5RxHt/nwkLZMDJGydNJ4fsJD+O7oKg9w+Ml8
         Vfoy9em1/kOlmh8Qre6y3KyWfzVaeHyenGVMhORWRjPsjqnz1UoxMKwZBdLaeZi4mxNC
         8X1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712304958; x=1712909758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0EQOfaQpw4diSaNUla+Yt9ZI58t4pKoAeHS1ES6kHY=;
        b=ONPSVZpVn9xiyUe1h3ZH2arcNuZGBJrxzUGA4sqiA/nvaCYA+Y/euaSrYxN1jUU9+Z
         mBZJiaSiPuXm9DxfI+WOUzGPUxk4DXkklCPUBGPqICr/gDxSmjYQBcnHvvBhuc4/PEh2
         3t7VmfLZx4emjaMc8WTSHc3v5PtUc6nfnZex40E5C6rwNFvjdGt4YonBpvJoLoVZNhZx
         Ey0MDRNfGGVfedoYwsca4ACObQvguvnv1hnsTB/YBSAHjE5QfM2sT+NGiuTCRVIf86ul
         rRv27rDnIPGeuSVaya06wiHzxivX8HIYy/X39mo4/bkz2fbF4eQYmapPORRQBXYrr7eE
         pLDA==
X-Forwarded-Encrypted: i=1; AJvYcCXqwFSYU2zj1wJ/+Qx0W85wjBFDzUeqt63gwAqXC7EWEkjzP2wZSHkGmJsP8Mlu1X6hOXSlGIUAgKvA/nEfPg+YZosFdER0n+3avoEOTQ7KSpSyy6+rSsKPTCmQZBPMfj2YcyHfF4LCJKFP3vI+nc4ZbBZjeDw4+yRkNH/Uo74mcVflPYaw
X-Gm-Message-State: AOJu0Yxaf4Ow8HzhCOQ6gYbvpqUtUNupHZd85Wwf9jldWQ1rFoNTss/d
	mvGeO2Z70kkOGUu4RRP6NI62On0xOgXSD74RmBYI1esQkPuQGzAnYzpcvXFQr6w=
X-Google-Smtp-Source: AGHT+IFJF07eybUNJc74Q+2ul5zRE6d3CbQ2mzRAhDZAWzlZk3TA66G2QcsHDG0GgoZ4BiX6wiGX1Q==
X-Received: by 2002:a05:600c:5112:b0:413:28ba:1b17 with SMTP id o18-20020a05600c511200b0041328ba1b17mr619272wms.6.1712304957561;
        Fri, 05 Apr 2024 01:15:57 -0700 (PDT)
Received: from eichest-laptop ([2a02:168:af72:0:727e:ef62:9d19:ed24])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b004162061c704sm5377133wma.29.2024.04.05.01.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 01:15:56 -0700 (PDT)
Date: Fri, 5 Apr 2024 10:15:55 +0200
From: Stefan Eichenberger <eichest@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: nick@shmanahar.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, linus.walleij@linaro.org,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	francesco.dolcini@toradex.com,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH RESEND v3 2/2] Input: atmel_mxt_ts - support poweroff in
 suspend
Message-ID: <Zg+zO+5MIMYNo3AH@eichest-laptop>
References: <20240209105012.22470-1-eichest@gmail.com>
 <20240209105012.22470-3-eichest@gmail.com>
 <ZfSYp6aV6bRhlPUJ@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfSYp6aV6bRhlPUJ@google.com>

Hi Dmitry,

Thanks for the feedback, I had a first look at the changes and I'm not
sure if we would break some use cases. Therfore, here some questions.

On Fri, Mar 15, 2024 at 11:51:19AM -0700, Dmitry Torokhov wrote:
> > diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> > index 542a31448c8f..2d5655385702 100644
> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > @@ -317,6 +317,7 @@ struct mxt_data {
> >  	struct gpio_desc *reset_gpio;
> >  	struct gpio_desc *wake_gpio;
> >  	bool use_retrigen_workaround;
> > +	bool poweroff_sleep;
> >  
> >  	/* Cached parameters from object table */
> >  	u16 T5_address;
> > @@ -2799,15 +2800,18 @@ static int mxt_configure_objects(struct mxt_data *data,
> >  			dev_warn(dev, "Error %d updating config\n", error);
> >  	}
> >  
> > -	if (data->multitouch) {
> > -		error = mxt_initialize_input_device(data);
> > -		if (error)
> > -			return error;
> > -	} else {
> > -		dev_warn(dev, "No touch object detected\n");
> > -	}
> > +	/* If input device is not already registered */
> > +	if (!data->input_dev) {
> > +		if (data->multitouch) {
> > +			error = mxt_initialize_input_device(data);
> > +			if (error)
> > +				return error;
> > +		} else {
> > +			dev_warn(dev, "No touch object detected\n");
> > +		}
> >  
> > -	mxt_debug_init(data);
> > +		mxt_debug_init(data);
> > +	}
> >  
> >  	return 0;
> >  }
> > @@ -3325,6 +3329,8 @@ static int mxt_probe(struct i2c_client *client)
> >  		msleep(MXT_RESET_INVALID_CHG);
> >  	}
> >  
> > +	data->poweroff_sleep = device_property_read_bool(&client->dev,
> > +							 "atmel,poweroff-sleep");
> >  	/*
> >  	 * Controllers like mXT1386 have a dedicated WAKE line that could be
> >  	 * connected to a GPIO or to I2C SCL pin, or permanently asserted low.
> > @@ -3387,12 +3393,21 @@ static int mxt_suspend(struct device *dev)
> >  	if (!input_dev)
> >  		return 0;
> >  
> > -	mutex_lock(&input_dev->mutex);
> > +	if (!device_may_wakeup(dev) && data->poweroff_sleep) {
> > +		if (data->reset_gpio)
> > +			gpiod_set_value(data->reset_gpio, 1);
> >  
> > -	if (input_device_enabled(input_dev))
> > -		mxt_stop(data);
> > +		regulator_bulk_disable(ARRAY_SIZE(data->regulators),
> > +				data->regulators);
> > +		data->T44_address = 0;
> > +	} else {
> > +		mutex_lock(&input_dev->mutex);
> > +
> > +		if (input_device_enabled(input_dev))
> > +			mxt_stop(data);
> >  
> > -	mutex_unlock(&input_dev->mutex);
> > +		mutex_unlock(&input_dev->mutex);
> > +	}
> 
> This all should go into mxt_stop(), so that if device is closed, or
> inhibited, you power it down as well (if you can).

We would then have to power it up during probe to see if the device is
threre, read the configuration and power it down again afterwards until
the device is opened. If the device is in bootloader mode we would most
likely have to keep the power on all the time and never turn it off,
right?

> 
> >  
> >  	disable_irq(data->irq);
> >  
> > @@ -3408,14 +3423,37 @@ static int mxt_resume(struct device *dev)
> >  	if (!input_dev)
> >  		return 0;
> >  
> > -	enable_irq(data->irq);
> > +	if (!device_may_wakeup(dev) && data->poweroff_sleep) {
> > +		int ret;
> >  
> > -	mutex_lock(&input_dev->mutex);
> > +		ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
> > +				data->regulators);
> > +		if (ret) {
> > +			dev_err(dev, "failed to enable regulators: %d\n",
> > +					ret);
> > +			return ret;
> > +		}
> > +		msleep(MXT_BACKUP_TIME);
> >  
> > -	if (input_device_enabled(input_dev))
> > -		mxt_start(data);
> > +		if (data->reset_gpio) {
> > +			/* Wait a while and then de-assert the RESET GPIO line */
> > +			msleep(MXT_RESET_GPIO_TIME);
> > +			gpiod_set_value(data->reset_gpio, 0);
> > +			msleep(MXT_RESET_INVALID_CHG);
> > +		}
> >  
> > -	mutex_unlock(&input_dev->mutex);
> > +		/* This also enables the irq again */
> > +		mxt_initialize(data);
> 
> And this needs to go into mxt_start(). Also, we should make sure that
> once resume operation completes the device is fully operational. That
> means you should not request the firmware asynchronously in
> mxt_initialize() in case you are in the resume path. I think you should
> also unwind mxt_initialize() and mxt_configure_objects() to make it
> clear what is the part of initial initialization and what is part of
> re-initializing during resume. The configuration that is exposed to
> userspace (resolution, number of objects, other properties) should stay
> the same, the configuration of the chip itself (power mode, etc) should
> be restored.

Here we would most likely have to load the firmware (configuration)
synchronously all the time if the poweroff_sleep flag is set. Ths makes
sure that the device is ready when we open the device. Would this delay
be acceptable when opening the input device? Normally the configuration
is not that big and should load quite fast. 

Regards,
Stefan

