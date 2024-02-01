Return-Path: <linux-kernel+bounces-47731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 556558451E8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3319D1F25191
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 07:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD5C1586F9;
	Thu,  1 Feb 2024 07:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpEGprZN"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB683FE0;
	Thu,  1 Feb 2024 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772550; cv=none; b=XmFMEU9r76f1QsSKcKen1A6AkmLGar4mdjW/OgFUoS68gCPedH2IUQ8ufRNmMm5i+lqGqPv2lQOwfJAPRObPsmPhlZE8AcwwafRc9HIzUlfbwv5yEkOk4fRArpFeWtBxMamEnedIciaN7fn0gilBUwRHxTYdXYCuF2gSWsHRzOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772550; c=relaxed/simple;
	bh=W9cY8OGwEt3hGv4G3S7kAMP8lNKUny1RsNcjpYlLSPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2eA8l4O1ltOL7dabRaa6NthAiO3gcSejLBIvqDed7WfEqqeQZeeu9UgfYISjCe7S2UT3W7tIKq+HisSHq0JUo7923PPmUPDPF9+aQxHXYXQnFYS09/GTbM1PMsGTapBM+9+vqUXoL5SoGi9w9jJtl58ursXwGiMrW11azYBo/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpEGprZN; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so816328a12.2;
        Wed, 31 Jan 2024 23:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706772546; x=1707377346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tLaWFDZsEpQvtDVfJc1CSfkCtVX7RFRHGCgQXJS8kTo=;
        b=PpEGprZNa7kLMRoTxiaXKzvSfx1cr+8iGxBqoBciCwF87ppcHYY0AeNQClDMcTVFpp
         ffIjCdiNRq0G8Gq8qWlIL1tCA8fH4kmLLYdxT/jubm0nAVNq9Gs2JwL6zOlOy6MWsywO
         uqpXcRAvOV+tUeAYKcB8fqJ0At2eyxMHhdM0XJyBI6ysChCMv6da/qVrjYanLv61xK4N
         KF3NNmvCIAK4/JqaqTYU2pIGedsGal94qO8GugnPuEO1KQjEbcG70r8G8H5fIFR8YKfV
         Vn3XoFyNQUIUgU8GIf/smCPlN6JW+Fx0QYz+J9UyY00C1JP/RP4CvD6nccm2zy2SgOQ9
         i48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706772546; x=1707377346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLaWFDZsEpQvtDVfJc1CSfkCtVX7RFRHGCgQXJS8kTo=;
        b=nbGMGbTWSNkhXp0iN8GwniTw7ldeYLA9675vhqJJ6Fx269Ey/VIN1psccMbtvo6q0c
         P4IJZNhn7NtAuCnwWoqPQ+YzvRuJFH341pzThgitAkk/0N3AhBiNTESf7fWcyPHjbH7A
         w2aPulC8Gv0WBnFa2kPhY4g2hLvFlnQqpwsFwhTLzsh5gRZYjtOgooKQEbS7lr5l9TX3
         RG+4BrtzzlDyaM4v/O5BaoYrVqjajivdycsUZ/RDCttJ4faghGahUX7OUYBr4DRW3Gn1
         /Y1w4sG6m6db43+pLQb9AGl84xKcmpGf/a7wS1K19yUFLr0zb8Jix0ra9X30yTDf13/7
         dCag==
X-Gm-Message-State: AOJu0Yy5uc2SOJR+SUBWhIv+gzTudZkbpWwIWa3hUNk4lnstySA+MTLs
	O9+tTkrN4dXG3BjcQDpB7Rb5lvodh5ek6L2EpALFPXjfvsxg77E1
X-Google-Smtp-Source: AGHT+IGwQpb4PCK+youy5XxDB/EkwZ45dOdqpu0j2LuSNrhRo2TWRg6TVokCOx3woyIY3O8OPuLFcg==
X-Received: by 2002:a17:906:84c:b0:a34:dbdc:929b with SMTP id f12-20020a170906084c00b00a34dbdc929bmr2975089ejd.0.1706772545831;
        Wed, 31 Jan 2024 23:29:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVtjpCLKpRbEbtNtbs2cus9oL/fxd+RE1c5xSNX3Bs38BG4NYTR6vsNO/JR3HfUrwLeqjEL775RLVjRAIe8Xuq+9Bylc09NH8IWYQFRFks2u16CZIbpEabI8NDm2ronXc9xWiBZTDZcTOgaP1b4JjNLnRDRqUbINgIXuzMomOIgzKpPWhnF/M15SyUJ5W3hO/pk9pW25aXTPe/6OkUIkgMql7ULhHsgKrGq4s2ZgrnHidpMooUcB8Ljv4MxU4ISRcXfvwgEg+x5VTyQC7sDNj/oT2m9TheqdHNPoQ+aroHxGpdlMEvSasFkkDVKdqxVy0DYPekABiWgDe5zffbhKjAZqcKJbu+n2TsahK8Hd/yAcN3DAViKefOB375avU0=
Received: from cjw-notebook (2a02-8388-0502-f480-6c32-186a-368b-d6a9.cable.dynamic.v6.surfer.at. [2a02:8388:502:f480:6c32:186a:368b:d6a9])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906349600b00a367bdce1fcsm1243432ejb.64.2024.01.31.23.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 23:29:05 -0800 (PST)
Date: Thu, 1 Feb 2024 08:29:02 +0100
From: Christoph Winklhofer <cj.winklhofer@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 3/3] w1: add UART w1 bus driver
Message-ID: <ZbtIPo--1hfzNmho@cjw-notebook>
References: <20240126-w1-uart-v5-0-1d82bfdc2ae9@gmail.com>
 <20240126-w1-uart-v5-3-1d82bfdc2ae9@gmail.com>
 <092a9986-5ebb-483d-9911-37a93d7cb2dd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <092a9986-5ebb-483d-9911-37a93d7cb2dd@kernel.org>

On Wed, Jan 31, 2024 at 02:12:34PM +0100, Krzysztof Kozlowski wrote:
> On 26/01/2024 16:42, Christoph Winklhofer via B4 Relay wrote:
> > From: Christoph Winklhofer <cj.winklhofer@gmail.com>
> > 
> > Add a UART 1-Wire bus driver. The driver utilizes the UART interface via
> > the Serial Device Bus to create the 1-Wire timing patterns. The driver
> > was tested on a "Raspberry Pi 3B" with a DS18B20 and on a "Variscite
> > DART-6UL" with a DS18S20 temperature sensor.
> > 
> 
> ...
> 
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
> Missing documentation of mutex scope. What does it protect?
> 

The mutex should protect concurrent access to rx_err and rx_byte. It
would be not be required in the good case: a write is initiated solely
by the w1-callbacks in 'w1_uart_serdev_tx_rx' and a completion is used
to wait for the result of serdev-receive.

However, in case the UART is not configured as a loop, a serdev-receive
may occur when w1_uart_serdev_tx_rx evaluates rx_err and rx_byte in
w1_uart_serdev_tx_rx, so it is protected - however, I will try to find
a better way to detect such an error.

In addition, the w1-callbacks should also return during a 'remove' (with
the mutex_try_lock) - see comment on that below.

> > +	struct mutex mutex;
> > +};
> > +
> 
> ...
> 
> > +/*
> > + * Send one byte (tx_byte) and read one byte (rx_byte) via serdev.
> > + */
> > +static int w1_uart_serdev_tx_rx(struct w1_uart_device *w1dev,
> > +				const struct w1_uart_config *w1cfg, u8 *rx_byte)
> > +{
> > +	struct serdev_device *serdev = w1dev->serdev;
> > +	int ret;
> > +
> > +	serdev_device_write_flush(serdev);
> > +	serdev_device_set_baudrate(serdev, w1cfg->baudrate);
> > +
> > +	/* write and immediately read one byte */
> > +	reinit_completion(&w1dev->rx_byte_received);
> > +	ret = serdev_device_write_buf(serdev, &w1cfg->tx_byte, 1);
> > +	if (ret != 1)
> > +		return -EIO;
> > +	ret = wait_for_completion_interruptible_timeout(
> > +		&w1dev->rx_byte_received, W1_UART_TIMEOUT);
> > +	if (ret <= 0)
> > +		return -EIO;
> > +
> > +	/* locking could fail during driver remove or when serdev is
> 
> It's not netdev, so:
> /*
>  *
> 

Ok.

> > +	 * unexpectedly in the receive callback.
> > +	 */
> > +	if (!mutex_trylock(&w1dev->mutex))
> > +		return -EIO;
> > +
> > +	ret = w1dev->rx_err;
> > +	if (ret == 0)
> > +		*rx_byte = w1dev->rx_byte;
> > +
> > +	if (w1cfg->delay_us > 0)
> > +		fsleep(w1cfg->delay_us);
> > +
> > +	mutex_unlock(&w1dev->mutex);
> > +
> > +	return ret;
> > +}
> > +
> > +static ssize_t w1_uart_serdev_receive_buf(struct serdev_device *serdev,
> > +					  const u8 *buf, size_t count)
> > +{
> > +	struct w1_uart_device *w1dev = serdev_device_get_drvdata(serdev);
> > +
> > +	mutex_lock(&w1dev->mutex);
> > +
> > +	/* sent a single byte and receive one single byte */
> > +	if (count == 1) {
> > +		w1dev->rx_byte = buf[0];
> > +		w1dev->rx_err = 0;
> > +	} else {
> > +		w1dev->rx_err = -EIO;
> > +	}
> > +
> > +	mutex_unlock(&w1dev->mutex);
> > +	complete(&w1dev->rx_byte_received);
> > +
> > +	return count;
> > +}
> > +
> > +static const struct serdev_device_ops w1_uart_serdev_ops = {
> > +	.receive_buf = w1_uart_serdev_receive_buf,
> > +	.write_wakeup = serdev_device_write_wakeup,
> > +};
> > +
> > +/*
> > + * 1-wire reset and presence detect: A present slave will manipulate
> > + * the received byte by pulling the 1-Wire low.
> > + */
> > +static u8 w1_uart_reset_bus(void *data)
> > +{
> > +	struct w1_uart_device *w1dev = data;
> > +	const struct w1_uart_config *w1cfg = &w1dev->cfg_reset;
> > +	int ret;
> > +	u8 val;
> > +
> > +	ret = w1_uart_serdev_tx_rx(w1dev, w1cfg, &val);
> > +	if (ret < 0)
> > +		return -1;
> > +
> > +	/* Device present (0) or no device (1) */
> > +	return val != w1cfg->tx_byte ? 0 : 1;
> > +}
> > +
> > +/*
> > + * 1-Wire read and write cycle: Only the read-0 manipulates the
> > + * received byte, all others left the line untouched.
> > + */
> > +static u8 w1_uart_touch_bit(void *data, u8 bit)
> > +{
> > +	struct w1_uart_device *w1dev = data;
> > +	const struct w1_uart_config *w1cfg = bit ? &w1dev->cfg_touch_1 :
> > +						   &w1dev->cfg_touch_0;
> > +	int ret;
> > +	u8 val;
> > +
> > +	ret = w1_uart_serdev_tx_rx(w1dev, w1cfg, &val);
> > +
> > +	/* return inactive bus state on error */
> > +	if (ret < 0)
> > +		return 1;
> > +
> > +	return val == w1cfg->tx_byte ? 1 : 0;
> > +}
> > +
> > +static int w1_uart_probe(struct serdev_device *serdev)
> > +{
> > +	struct device *dev = &serdev->dev;
> > +	struct w1_uart_device *w1dev;
> > +	int ret;
> > +
> > +	w1dev = devm_kzalloc(dev, sizeof(*w1dev), GFP_KERNEL);
> > +	if (!w1dev)
> > +		return -ENOMEM;
> > +	w1dev->bus.data = w1dev;
> > +	w1dev->bus.reset_bus = w1_uart_reset_bus;
> > +	w1dev->bus.touch_bit = w1_uart_touch_bit;
> > +	w1dev->serdev = serdev;
> > +
> > +	init_completion(&w1dev->rx_byte_received);
> > +	mutex_init(&w1dev->mutex);
> > +
> > +	ret = w1_uart_serdev_open(w1dev);
> > +	if (ret < 0)
> > +		return ret;
> > +	serdev_device_set_drvdata(serdev, w1dev);
> > +	serdev_device_set_client_ops(serdev, &w1_uart_serdev_ops);
> > +
> > +	return w1_add_master_device(&w1dev->bus);
> > +}
> > +
> > +static void w1_uart_remove(struct serdev_device *serdev)
> > +{
> > +	struct w1_uart_device *w1dev = serdev_device_get_drvdata(serdev);
> > +
> > +	mutex_lock(&w1dev->mutex);
> > +
> > +	w1_remove_master_device(&w1dev->bus);
> > +
> > +	mutex_unlock(&w1dev->mutex);
> 
> This is still suspicious. You do not have serdev_device_close and you
> want to protect from concurrent access but it looks insufficient.
> 
> This code assumes that:
> 
> w1_uart_remove()
>   <-- here concurrent read/write might start
>   mutex_lock()
>   w1_remove_master_device()
>   mutex_unlock()
>   <-- now w1_uart_serdev_tx_rx() or w1_uart_serdev_receive_buf() can be
> executed, but device is removed. So what's the point of the mutex here?
> 
> What exactly is protected by the mutex? So far it looks like only some
> contents of w1dev, but it does not matter, because it that memory is
> still valid at this point.
> 
> After describing what is protected we can think whether it is really
> protected...
> 
> 
> > 
> 
> Best regards,
> Krzysztof
> 

Yes, it is still suspicious, sorry..

After w1_uart_remove, serdev is closed and w1dev is released. Therefore
the w1-callback (w1_uart_serdev_tx_rx) must be finished before returning
from w1_uart_remove. That was the intention with the lock and trylock.

I thought that after w1_remove_master_device, the w1-callback
(w1_uart_serdev_tx_rx) is finished which is not the case. I will check
the working of w1_remove_master_device, probably it requires a lock to
a mutex from w1-bus.

Many thanks for your review and pointing the things out!

Kind regards,
Christoph

