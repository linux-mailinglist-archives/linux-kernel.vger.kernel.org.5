Return-Path: <linux-kernel+bounces-50476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4FD847998
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFB64285B7B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF10215E5C5;
	Fri,  2 Feb 2024 19:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVRXBMyR"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C1E5A4C2;
	Fri,  2 Feb 2024 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706901817; cv=none; b=dGtR64I+dhYGKeJKb6cfmzlpWpcQARPYnfoTpmi8NIoeEF14Fg0cnvcBGaCYRxuZJOhMlm9pmRMB6V3pcvEC4FSGKXPhVgg2lkf0N567VnCEAm2K5K5omTVC9uF+z1qx8M1XrBIkDcL3jELWnrQ/oXkohc40gb3QX+QksOQ+03o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706901817; c=relaxed/simple;
	bh=S3MaPMOXDa4+e1cpiJeiJbySrhFJC1lc7gKR4d8V+8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIGuYYhI8sKE3/3hkQaso6XVAaQMRVSy+chiSOA71lmt8beS9Tame1ZXhT4qtYJQlX8eswv+A54bvVfek/EYI01Oa+OLqMI7IJAPqEoJ5cXOyCbCkQZT4NH4AwT6AkUT4yjNBrHpR2tAd6q52XmnQmCdvJJ/YI6xG/J4BolhsZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVRXBMyR; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so222337266b.1;
        Fri, 02 Feb 2024 11:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706901814; x=1707506614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=izs8l7kyWJ3Hvvu35DwQqBwFXYQSHquPAv2Y4TTIhWI=;
        b=GVRXBMyRfB5pxf7n5w4mCRwG8QHq8SYfxR08SjtPJYAoRUQjVzou/7OAaIWezMtxCU
         qDv4URl/+Bx3JhKMA2AqmvBnPO4cFXHBao7nMogDKufJwdRyJkqUT+mVSxPpNMB7O/wP
         /qew8ln79/dwICB6DkmKdd7C3VXiuG9suirpyaDm4lDx/bQIVhUDAGIiBAHDc1UaPnjc
         OlKaRiwku3H8Tuy1yKOdPPLO3zVEYwc4ObVjQd+ja5oI6Q9V3ogEoAqQY5+xFtjNy5YY
         NiO24O8IOBI/xma7qbtsnhW+M2kT6na3ewVy85zgkOtppLmLiXm5C3kbQavEDOuRK0Ok
         fsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706901814; x=1707506614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izs8l7kyWJ3Hvvu35DwQqBwFXYQSHquPAv2Y4TTIhWI=;
        b=gc3dHnI42vho9lfXjKcjAQW/qkEEpFv53J0J+taMEF/U4gXFt9HLAl9HNh/I+zq7XD
         KZMG0POeqBs7GKVUrQLWWW8/JdMiPj1cMHlW1aLVm9HU/jmcWApIwEHBQvVu4yG1hBte
         zYCfHFPft4DXHOjNit+fBn2bxo0ENjYRXR6Ap4s4qMSdLLuoIFP+ZpzUzUtDuYqWoLV7
         pHEHnavt5OlbEY9RGUoF09SBzyTDnzefXuDBm5naU+8OiElgjpk+2BLXzDOho/n61pXc
         dFcofMTVLtbdJbP70aCbKUKABPh3F9mVhSb6ec9alqWrG+dzGjww7QcmNEFdYkwOx8Gb
         aviA==
X-Gm-Message-State: AOJu0Yx9HJmzIJpGTZOl/A+EMJ7WV86ggaD+XpITRoMFaw4PgadtfU8i
	EmI95d2JSP+ycgJ9CyRl/WTr0P6ErTo+G2e/LsfW0claKcMChrNd
X-Google-Smtp-Source: AGHT+IFVsEsYcXxM9nZP0Ig9KYpNTyk/btVKfMLQ/vV4CvXETCy9qQTpJMzeol4ysl+TBRO5oX3gYw==
X-Received: by 2002:a17:906:3093:b0:a36:dfa5:69c with SMTP id 19-20020a170906309300b00a36dfa5069cmr2332310ejv.14.1706901814108;
        Fri, 02 Feb 2024 11:23:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWcQIleUmzagk3MM3dXQ7foXv5CU6GWw4QLfrAlMH2YEguKWU800J0SVjQqR48CINe0XrU1DFLagD7Es9y5ZstIsZsGsOOf22v1qKOhdpa/Xout6nV2Rc65yMYNFy8NiX1G090LAmnehoVjUfn/gvkUjsSwnuVdgOe4bqT4qRAWP3FYzcGuiGIdMapZd+yh/9Mx4o9uTBlijfM58bfspSrwLh7rQwLhhHquTSxJNiMjmASOW2cppGNxji3uEW8DlWAbHzl/GZuD2zr1C4f+sxzIMNB1wCsNx/UPz19T6hZFLKYWEQUwxBVQwWKICBGTABauLtoAWuBfQ9xbUYiXIY4uM+TNNZw/PadX5EcTMl/a584NkNFiIRzpCuZ6yv0=
Received: from cjw-notebook (2a02-8388-0502-f480-6c32-186a-368b-d6a9.cable.dynamic.v6.surfer.at. [2a02:8388:502:f480:6c32:186a:368b:d6a9])
        by smtp.gmail.com with ESMTPSA id rf14-20020a1709076a0e00b00a371c568978sm649584ejc.150.2024.02.02.11.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 11:23:33 -0800 (PST)
Date: Fri, 2 Feb 2024 20:23:30 +0100
From: Christoph Winklhofer <cj.winklhofer@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 3/3] w1: add UART w1 bus driver
Message-ID: <Zb1BMswaaZTXzaFJ@cjw-notebook>
References: <20240126-w1-uart-v5-0-1d82bfdc2ae9@gmail.com>
 <20240126-w1-uart-v5-3-1d82bfdc2ae9@gmail.com>
 <092a9986-5ebb-483d-9911-37a93d7cb2dd@kernel.org>
 <ZbtIPo--1hfzNmho@cjw-notebook>
 <94075be0-b91c-4147-86b1-582b124e71a0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94075be0-b91c-4147-86b1-582b124e71a0@linaro.org>

On Thu, Feb 01, 2024 at 10:35:32AM +0100, Krzysztof Kozlowski wrote:
> On 01/02/2024 08:29, Christoph Winklhofer wrote:
> >>> +
> >>> +static void w1_uart_remove(struct serdev_device *serdev)
> >>> +{
> >>> +	struct w1_uart_device *w1dev = serdev_device_get_drvdata(serdev);
> >>> +
> >>> +	mutex_lock(&w1dev->mutex);
> >>> +
> >>> +	w1_remove_master_device(&w1dev->bus);
> >>> +
> >>> +	mutex_unlock(&w1dev->mutex);
> >>
> >> This is still suspicious. You do not have serdev_device_close and you
> >> want to protect from concurrent access but it looks insufficient.
> >>
> >> This code assumes that:
> >>
> >> w1_uart_remove()
> >>   <-- here concurrent read/write might start
> >>   mutex_lock()
> >>   w1_remove_master_device()
> >>   mutex_unlock()
> >>   <-- now w1_uart_serdev_tx_rx() or w1_uart_serdev_receive_buf() can be
> >> executed, but device is removed. So what's the point of the mutex here?
> >>
> >> What exactly is protected by the mutex? So far it looks like only some
> >> contents of w1dev, but it does not matter, because it that memory is
> >> still valid at this point.
> >>
> >> After describing what is protected we can think whether it is really
> >> protected...
> >>
> >>
> >>>
> >>
> >> Best regards,
> >> Krzysztof
> >>
> > 
> > Yes, it is still suspicious, sorry..
> > 
> > After w1_uart_remove, serdev is closed and w1dev is released. Therefore
> > the w1-callback (w1_uart_serdev_tx_rx) must be finished before returning
> 
> I did not even go to end of w1_uart_remove(). In my code above, that
> thread is still in w1_uart_remove(), just after unlocking mutex.
> 

Ok, I looked more closely at the underlying w1-code and think it is
sufficient to only call w1_remove_master_device() in w1_uart_remove.
This function waits until all slaves have finished their work, so
w1_uart_serdev_tx_rx finished too. The lock is not required.

Hence, I will use the mutex only to protected concurrent access of
serdev and w1-callbacks (for rx_byte and rx_err).

> > from w1_uart_remove. That was the intention with the lock and trylock.
> 
> Then it does not look really protected. To be honest, w1-gpio and other
> drivers also might have a race here. You can test it by adding long
> sleeps in read/write paths and then trying to unbind device. Maybe this
> should be fixed everywhere, but this mutex here brings more questions.
> 

I added a delay, unbind takes longer but works without problems when its
done during a temperature read.

IMO also the other drivers should be fine. From w1_int.c: The w1_master
is ref-counted and released when it is unused (2). In w1_slave_detach
(1), the slaves decrement this count, perform specific clean up (in
remove_slave) and remove sysfs entries.

w1_int.c:

void __w1_remove_master_device(struct w1_master *dev)
..
	list_for_each_entry_safe(sl, sln, &dev->slist, w1_slave_entry) {
		mutex_unlock(&dev->list_mutex);
		w1_slave_detach(sl); 		(1)
..
	while (atomic_read(&dev->refcnt)) { 	(2)
..	
	}
..
	w1_free_dev(dev);

For example w1_therm waits in remove_slave until its w1-operations are
done. The other slave-drivers (e.g. w1_ds2405.c) use w1-operations in
their sysfs-callback and I suppose that sysfs-removal waits until the
sysfs-read is finished.

Kind regards,
Christoph

