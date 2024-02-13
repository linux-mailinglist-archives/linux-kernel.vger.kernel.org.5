Return-Path: <linux-kernel+bounces-63031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 074B9852989
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F811F22CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8609317556;
	Tue, 13 Feb 2024 07:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZE5Fb00n"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012D4171AF;
	Tue, 13 Feb 2024 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707807759; cv=none; b=QFhpZScfAL3iI9hV6tBtIgARSbJ8x+zLzBIbmt9g+BUyuhAVmN4I7h1BGjPk46mcHmE6Py22tLac//n1ZfaFBgAWI3TqMnKAEBfM3R7bsSHUgLUNrtvFXDEYsJSP9bzK9bKNV9rqmDuJF+lqBjEKBgqjJzni0fXUCcDy2b6fERg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707807759; c=relaxed/simple;
	bh=lZeK2gRHpuUy0pQK9B/76rraAeuXtQdDGPNtMRsJMF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmHL3yz+AEOsMIlWJNw29HXZ1f+hEnOeBmH1ASj0PTlJ8TZUFdFwxA4JoMjPxgQEjkjDmlSWcXY5HtuoWsk22C7c1ZSKw901pVtWYtPNX84hd7kIY6MBp/scWXAuUd37ZiHbjGmpCPs0kMjFocKHTU/4TaIDmwTEd00h9Bg0Bh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZE5Fb00n; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55fc7f63639so5059041a12.1;
        Mon, 12 Feb 2024 23:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707807756; x=1708412556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z+udwVZEdtua1lL/X4tovmfNwH/O3Old1O5MzEt/irs=;
        b=ZE5Fb00nnHxD8PsR03/c5TrpVaOllm/UVBNFOXos5T6J4Fm1oaakHk9VFXXq2yUPam
         TN4UwaX8zrwt93uusJV6Ph/utyvbahLraaC1obwg6DGENxrSdsK01SFRjWNNYKVA4sMU
         lH7acMOOeqRnfleqOr5/5x/ZA9VOTXpVKoUMZfCgHn2aDqwXEpHmgnTppBG2EcAFtyJc
         nitsKgy6aDEKnsvM7mfIQ7IQ2fQyDXRTdf731Pz9/3mFLWfo6xI8vtBSrB0P/J3JQq6s
         P7y2Wj8O9LWQxe5bpFS6A4GE7pEgN0LlcwST6m7LKNIfLb2HXov9/L1b6iGTS6zHKRr+
         9dDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707807756; x=1708412556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+udwVZEdtua1lL/X4tovmfNwH/O3Old1O5MzEt/irs=;
        b=PRSu5uZzGtN7iVOSiZa/rtAKaLEq1K+qSBISX0TfG6aSixGrGhUeDgglPcMUkue1IS
         K3y9jQsm3zrsAR1wdhCnKseiyG97xSwdtWZI3R0OrafO7isSWbgnaTVu6MKlkGk7f8co
         /SnduQ2FN1E3Mb/1fKZCeZoF1go4iXftIQ1LPEKv2bGpI+JbaPT2pAQRHnkaWUhc/vMO
         efgrxyni+5z8m8iP8wqTJ114d1yRGLbDJ8Ftkz7iIw+eUX9mX9NYDFkoj5+NagT+Un4d
         l2cIsSGv+aDFvJUcTlu/lpBYzyfTxtHEaiXdAf0mNcYKzZOIExii9Jo8Q+s/51mLBmUu
         0SkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEf9jKn4pImKcz5iAsE2lW6pPWCGbjHnA9FralO0q520Q3mIBN8fMC7QPxudzbSzSaJa9Uy1sIcF43OIPljb/fNc7w3gNYJBC4+Xg70g8FUcQTvdxK4HiluOWQ57CuHKzxIfHMDXW+z2gLC3bXpM2fdyJO980y/h/h2BNYLo0vT1sr5n71V2LsREW+Wq1QgmCgAR0t1I6DalAjSCmQiDpWRQ==
X-Gm-Message-State: AOJu0YypugRqdUOH8G+dHICo2jiFAwvY0liWg/KZXgD6WcpyGXM6ZwWQ
	r7yi8qv96/DSpj3VqigHog4meusPCktsnKt2poJJsOetzBFmjX3w
X-Google-Smtp-Source: AGHT+IH32n/VabfZRui3/N1kTk9igIxKOYGMUC2zi3BJn1fDEZGUSEd0VTQEtIvUszYxkgShIm+Mvw==
X-Received: by 2002:a05:6402:2c2:b0:561:d3d4:242d with SMTP id b2-20020a05640202c200b00561d3d4242dmr2187954edx.38.1707807756060;
        Mon, 12 Feb 2024 23:02:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVUfht4Z1J2zaP0zNNC/mk7MaOFF4NJRIq6XBG/hkGxTMG/VqdYWnKEjzcFoEjuOTY1sxXW8La/POimFkUCplPmF1sCypg9DPPRX417dFmMr37YYUyMgX1UiIYR9RPij1flWIQcbV/PLuTaE4es/5AX88SMDOdGU2u0Piz2880i/ji4Snkh4QSqVN5Q7qDns7aOHevOG119hzutDzEbqk2hDfba219tNOU2rL9YhMYh4JhwY7M1wFCMK/fX0GojQdXHP9I86qSYwZt4EnzaoEWWox2YI6YKUhJnluTPjMG3SD3EN67NJVUcUy5Zz4Z025XwqVdiMV6M8w==
Received: from cjw-notebook (2a02-8388-0502-f480-6c32-186a-368b-d6a9.cable.dynamic.v6.surfer.at. [2a02:8388:502:f480:6c32:186a:368b:d6a9])
        by smtp.gmail.com with ESMTPSA id a23-20020a05640233d700b0055ff708dee3sm3409005edc.11.2024.02.12.23.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 23:02:35 -0800 (PST)
Date: Tue, 13 Feb 2024 08:02:32 +0100
From: Christoph Winklhofer <cj.winklhofer@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 3/3] w1: add UART w1 bus driver
Message-ID: <ZcsUCHu42ILfKSBs@cjw-notebook>
References: <20240209-w1-uart-v6-0-3e753c149196@gmail.com>
 <20240209-w1-uart-v6-3-3e753c149196@gmail.com>
 <466d7be4-6ca1-4eb2-a59b-a3f0a846a2df@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <466d7be4-6ca1-4eb2-a59b-a3f0a846a2df@linaro.org>

On Mon, Feb 12, 2024 at 04:30:00PM +0100, Krzysztof Kozlowski wrote:
> On 09/02/2024 07:22, Christoph Winklhofer via B4 Relay wrote:
> > From: Christoph Winklhofer <cj.winklhofer@gmail.com>
> > 
> > Add a UART 1-Wire bus driver. The driver utilizes the UART interface via
> > the Serial Device Bus to create the 1-Wire timing patterns. The driver
> > was tested on a "Raspberry Pi 3B" with a DS18B20 and on a "Variscite
> > DART-6UL" with a DS18S20 temperature sensor.
> > 
> > The 1-Wire timing pattern and the corresponding UART baud-rate with the
> > interpretation of the transferred bytes are described in the document:
> 
> 
> > +/*
> > + * struct w1_uart_config - configuration for 1-Wire operation
> > + *
> > + * @baudrate: baud-rate returned from serdev
> > + * @delay_us: delay to complete a 1-Wire cycle (in us)
> > + * @tx_byte: byte to generate 1-Wire timing pattern
> > + */
> > +struct w1_uart_config {
> > +	unsigned int baudrate;
> > +	unsigned int delay_us;
> > +	u8 tx_byte;
> > +};
> > +
> > +/*
> > + * struct w1_uart_config - w1-uart device data
> 
> That's neither correct (device, not config) nor proper kerneldoc nor
> useful. Your comment repeats struct name. If you want to make it
> kerneldoc, go ahead, but then make it a full kerneldoc.
> 

Yes, sorry - will use the correct name.

> And obviously compile with W=1.
> 

You mean the padding error of mutex, I get it with W=3 and will fix it
by moving mutex up.

> > + *
> > + * @serdev: serial device
> > + * @bus: w1-bus master
> > + * @cfg_reset: config for 1-Wire reset
> > + * @cfg_touch_0: config for 1-Wire write-0 cycle
> > + * @cfg_touch_1: config for 1-Wire write-1 and read cycle
> > + * @rx_byte_received: completion for serdev receive
> > + * @rx_err: indicates an error in serdev-receive
> > + * @rx_byte: result byte from serdev-receive
> > + * @mutex: mutex to protected rx_err and rx_byte from concurrent access
> > + *         in w1-callbacks and serdev-receive.
> > + */
> > +struct w1_uart_device {
> > +	struct serdev_device *serdev;
> > +	struct w1_bus_master bus;
> > +
> > +	struct w1_uart_config cfg_reset;
> > +	struct w1_uart_config cfg_touch_0;
> > +	struct w1_uart_config cfg_touch_1;
> > +
> > +	struct completion rx_byte_received;
> > +	int rx_err;
> > +	u8 rx_byte;
> > +
> 
> How did you solve my comment and checkpatch warning from previous version:
> 
> CHECK: struct mutex definition without comment
> 

Thanks, I missed the option --strict in checkpatch.pl and dit not get
this warning. Will add a comment.

> > +	struct mutex mutex;
> > +};
> > +
> > +/*
> > + * struct w1_uart_limits - limits for 1-Wire operations
> > + *
> > + * @baudrate: Requested baud-rate to create 1-Wire timing pattern
> > + * @bit_min_us: minimum time for a bit (in us)
> > + * @bit_max_us: maximum time for a bit (in us)
> > + * @sample_us: timespan to sample 1-Wire response
> > + * @cycle_us: duration of the 1-Wire cycle
> > + */
> > +struct w1_uart_limits {
> > +	unsigned int baudrate;
> > +	unsigned int bit_min_us;
> > +	unsigned int bit_max_us;
> > +	unsigned int sample_us;
> > +	unsigned int cycle_us;
> 
> ...
> 
> > +/*
> > + * Configuration for write-1 and read cycle (touch bit 1)
> > + * - bit_min_us is 5us, add margin and use 6us
> > + * - limits for sample time 5us-15us, use 15us
> > + */
> > +static int w1_uart_set_config_touch_1(struct w1_uart_device *w1dev)
> > +{
> > +	struct serdev_device *serdev = w1dev->serdev;
> > +	struct device_node *np = serdev->dev.of_node;
> > +
> > +	struct w1_uart_limits limits = { .baudrate = 115200,
> > +					 .bit_min_us = 6,
> > +					 .bit_max_us = 15,
> > +					 .sample_us = 15,
> > +					 .cycle_us = 70 };
> > +
> > +	of_property_read_u32(np, "write-1-bps", &limits.baudrate);
> > +
> > +	return w1_uart_set_config(serdev, &limits, &w1dev->cfg_touch_1);
> > +}
> > +
> > +/*
> > + * Configure and open the serial device
> > + */
> > +static int w1_uart_serdev_open(struct w1_uart_device *w1dev)
> > +{
> > +	struct serdev_device *serdev = w1dev->serdev;
> > +	struct device *dev = &serdev->dev;
> > +	int ret;
> > +
> > +	/* serdev is automatically closed on unbind or driver remove */
> 
> Drop comment, that's obvious. That's what devm* functions are for.
> 
> 

Ok.

> > +	ret = devm_serdev_device_open(dev, serdev);
> 
> 
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
> > +	if (ret < 0) {
> > +		dev_err(dev, "set parity failed\n");
> > +		return ret;
> > +	}
> 
> 
> Best regards,
> Krzysztof
> 

Thanks!
Christoph

