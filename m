Return-Path: <linux-kernel+bounces-104816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C0087D41D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE2DCB250F6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322D0535B6;
	Fri, 15 Mar 2024 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehhxCNXO"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703AF50261;
	Fri, 15 Mar 2024 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528686; cv=none; b=DNndCWibEB31/CXZCi+4ANvTnFSDDDoGI/n7GvZID94L885GnrJiTQB/EEiXrK2WGqjEivXthgB/HssDrMBFjH86vmh7or65VlwKn4xPdoxxth3b+8rnmxPEaXS8PLQD6Rhyg6ASdkikgHvSs1k4HykTMBKwlcCUpdvHgZhjMOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528686; c=relaxed/simple;
	bh=16ql2HcY7iDcpglYmBvrsnrtWDpPdD0pISldjm33j3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imXIGIQGWf/RQvPzv2QLds0h/nO8KbzdgQBIqfFxCVVNigj1vtq/iOgdX8KZEB4afvAZWXQt51BmmdE2dl6A0oJpYFMq3563WFvA7jipxkWP3Qu1kQ/GDdcWGxNHX2OCtSt1li/hQTvtiCdKezCKhrIMs2Q+rVq7fq53srsUUi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehhxCNXO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1de0f92e649so16366425ad.0;
        Fri, 15 Mar 2024 11:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710528683; x=1711133483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qQtwelcSgwGFeTnZLVof0pwhxwav0Nmdkno2Inz3sLw=;
        b=ehhxCNXO21oQQ+adJSqL8uvxy5Mte2FDEoazFtFrGiWy7AP4L89C3JpIPgFt8r3Q67
         ApZxKDxitQKOVbg4L+ZTIgpNv6f+eliyWlBNfI3FdnXV2bDcFmbEdURGTK2FazKuHEWx
         AuGm5dpS8UqIuMTck3FmQ/UYURX6gO3m2Naq20jxD8jjUuUh5TvAqhRDd5RVei+3kfD6
         nJ7jsHFy4dR4c22eWr1e5TZe9tAZMmsXmW9E1e8KNJXypVpMcJYbjP4hm+24cRW/p1UQ
         aUXo5rc6ROjSLYfV+mzmQx/Afk64+cN7EuVbdsjWBO2jPZDdtd16w21an3whSlBXqEmQ
         DGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710528683; x=1711133483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQtwelcSgwGFeTnZLVof0pwhxwav0Nmdkno2Inz3sLw=;
        b=sjVB5+novTOTNAMOWLQ3qYMtcfcwk+WD/p9MlFQ9tHLTcwhP2sCMUu72skE+rj0Tsb
         t/ESvL2GvcXM2C4IR3x/TvfEZvFtGD1cZYQqdurKqeWU1nDhaE9C/3SliEtcq7KDBDs9
         qg4h0NZCR4T5cO+d2ZONHm9O25nnfTMUNjxIUL70Y1DmjbqwoA2j6D1L/YyqPubc3fjX
         4tQeGjw0YQIWSFf/lvOaMDiFAphW0F0i92JrRhcpKzXmqfwafKTqc1qws1dSrg+6iWIK
         Fp9n7PShCdm8sbYMNl85rDEdQQffdGTaKx9PQTGdBBep4+p6FVfhvQeeLktKVIPuiNI5
         P1zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmIUEa6/cPVqIZaSjcXRXQXPZZRv6XhSXoHGngCxbIrr3PFzhjz9HXunzuWZbMhwjT277fnupmwOMqP6LWGO1Orasu5C79stTgLPq14VWmYlo6036TBZ1lHkEbIaxkh7maxTfvSKfy9CR15JIIuWGSigPerv8GT3rn7PknSnHozo0ssSt8
X-Gm-Message-State: AOJu0YyYKnlzfE1pV6YzIW+Pzny2U2mdJule5l3slN+5tLggVPi0Ds03
	bBNHL0t17b30cF3YgZaMOcLQFNjU/3l4EHU0yC38LmDDV2tCmK70
X-Google-Smtp-Source: AGHT+IF2HQskcpCyIR3dSZHfWz5hEStmH0IR/3eWOj+Efeu9g7w0OAdVU5R7xHfBDlK1SDx09ySDHA==
X-Received: by 2002:a17:903:11c3:b0:1dd:7d6a:d6c8 with SMTP id q3-20020a17090311c300b001dd7d6ad6c8mr6727294plh.14.1710528682446;
        Fri, 15 Mar 2024 11:51:22 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:c446:74f0:5cd2:d078])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e80200b001defbc29a05sm820862plg.40.2024.03.15.11.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 11:51:21 -0700 (PDT)
Date: Fri, 15 Mar 2024 11:51:19 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Stefan Eichenberger <eichest@gmail.com>
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
Message-ID: <ZfSYp6aV6bRhlPUJ@google.com>
References: <20240209105012.22470-1-eichest@gmail.com>
 <20240209105012.22470-3-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209105012.22470-3-eichest@gmail.com>

Hi Stefan,

On Fri, Feb 09, 2024 at 11:50:12AM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> Add a new device tree property to indicate that the device should be
> powered off in suspend mode. We have a shared regulator that powers the
> display, a USB hub and some other peripherals. The maXTouch controller
> doesn't normally disable the regulator in suspend mode, so our extra
> peripherals stay powered on. This is not desirable as it consumes more
> power. With this patch we add the option to disable the regulator in
> suspend mode for the maXTouch and accept the longer initialisation time.
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 72 ++++++++++++++++++------
>  1 file changed, 55 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 542a31448c8f..2d5655385702 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -317,6 +317,7 @@ struct mxt_data {
>  	struct gpio_desc *reset_gpio;
>  	struct gpio_desc *wake_gpio;
>  	bool use_retrigen_workaround;
> +	bool poweroff_sleep;
>  
>  	/* Cached parameters from object table */
>  	u16 T5_address;
> @@ -2799,15 +2800,18 @@ static int mxt_configure_objects(struct mxt_data *data,
>  			dev_warn(dev, "Error %d updating config\n", error);
>  	}
>  
> -	if (data->multitouch) {
> -		error = mxt_initialize_input_device(data);
> -		if (error)
> -			return error;
> -	} else {
> -		dev_warn(dev, "No touch object detected\n");
> -	}
> +	/* If input device is not already registered */
> +	if (!data->input_dev) {
> +		if (data->multitouch) {
> +			error = mxt_initialize_input_device(data);
> +			if (error)
> +				return error;
> +		} else {
> +			dev_warn(dev, "No touch object detected\n");
> +		}
>  
> -	mxt_debug_init(data);
> +		mxt_debug_init(data);
> +	}
>  
>  	return 0;
>  }
> @@ -3325,6 +3329,8 @@ static int mxt_probe(struct i2c_client *client)
>  		msleep(MXT_RESET_INVALID_CHG);
>  	}
>  
> +	data->poweroff_sleep = device_property_read_bool(&client->dev,
> +							 "atmel,poweroff-sleep");
>  	/*
>  	 * Controllers like mXT1386 have a dedicated WAKE line that could be
>  	 * connected to a GPIO or to I2C SCL pin, or permanently asserted low.
> @@ -3387,12 +3393,21 @@ static int mxt_suspend(struct device *dev)
>  	if (!input_dev)
>  		return 0;
>  
> -	mutex_lock(&input_dev->mutex);
> +	if (!device_may_wakeup(dev) && data->poweroff_sleep) {
> +		if (data->reset_gpio)
> +			gpiod_set_value(data->reset_gpio, 1);
>  
> -	if (input_device_enabled(input_dev))
> -		mxt_stop(data);
> +		regulator_bulk_disable(ARRAY_SIZE(data->regulators),
> +				data->regulators);
> +		data->T44_address = 0;
> +	} else {
> +		mutex_lock(&input_dev->mutex);
> +
> +		if (input_device_enabled(input_dev))
> +			mxt_stop(data);
>  
> -	mutex_unlock(&input_dev->mutex);
> +		mutex_unlock(&input_dev->mutex);
> +	}

This all should go into mxt_stop(), so that if device is closed, or
inhibited, you power it down as well (if you can).

>  
>  	disable_irq(data->irq);
>  
> @@ -3408,14 +3423,37 @@ static int mxt_resume(struct device *dev)
>  	if (!input_dev)
>  		return 0;
>  
> -	enable_irq(data->irq);
> +	if (!device_may_wakeup(dev) && data->poweroff_sleep) {
> +		int ret;
>  
> -	mutex_lock(&input_dev->mutex);
> +		ret = regulator_bulk_enable(ARRAY_SIZE(data->regulators),
> +				data->regulators);
> +		if (ret) {
> +			dev_err(dev, "failed to enable regulators: %d\n",
> +					ret);
> +			return ret;
> +		}
> +		msleep(MXT_BACKUP_TIME);
>  
> -	if (input_device_enabled(input_dev))
> -		mxt_start(data);
> +		if (data->reset_gpio) {
> +			/* Wait a while and then de-assert the RESET GPIO line */
> +			msleep(MXT_RESET_GPIO_TIME);
> +			gpiod_set_value(data->reset_gpio, 0);
> +			msleep(MXT_RESET_INVALID_CHG);
> +		}
>  
> -	mutex_unlock(&input_dev->mutex);
> +		/* This also enables the irq again */
> +		mxt_initialize(data);

And this needs to go into mxt_start(). Also, we should make sure that
once resume operation completes the device is fully operational. That
means you should not request the firmware asynchronously in
mxt_initialize() in case you are in the resume path. I think you should
also unwind mxt_initialize() and mxt_configure_objects() to make it
clear what is the part of initial initialization and what is part of
re-initializing during resume. The configuration that is exposed to
userspace (resolution, number of objects, other properties) should stay
the same, the configuration of the chip itself (power mode, etc) should
be restored.

Thanks.

-- 
Dmitry

