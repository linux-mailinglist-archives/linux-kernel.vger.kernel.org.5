Return-Path: <linux-kernel+bounces-73861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 401E985CCB3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89472829E5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7343AECC;
	Wed, 21 Feb 2024 00:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYzCKhXR"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30704382;
	Wed, 21 Feb 2024 00:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708475163; cv=none; b=nQxWa3FGj0OZmdZDo717QbN8aCuzR2KHcBqlSrghyDpVQw7P1N4wTqT8OOnU0/EYUlL2ZOw6egIKfVVqT/e2ZQD7Gjra4vy1eSZsrl2OcmU4EI9EIdA9nFFMKtjn4csWIcWa8++RnmbS2gdSjlOwfvAUOzdEkieOPOoM11L69Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708475163; c=relaxed/simple;
	bh=F+cjb9eDPhMefUAJADZqjITfJlMlVKqzvSiisog2x30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5toJC3OQb3S/m3T2hwM8dteGltUZ/GC3xEPgykQQ4pgErKp4NASUUAaCoJrmrXGXIZ2RQI36iDJIR+vYHPiPKMxAvSB6FgKQB5G4HJNx3wSNAnNscaa0dHoZjjV2SN2qI/XzBP0ctTtNpcb/3W/y3VGe7FFhfPz2Q5nI0gtpko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYzCKhXR; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so4985673a12.0;
        Tue, 20 Feb 2024 16:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708475161; x=1709079961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zVXe5zTlKP4MQkzjeIKRSzNf6XFFbe0v6NlgmPohvbM=;
        b=ZYzCKhXReWp4QyRRxgY5Dcvabs21q1HL6znlVclQjut6eAZl/T2aghZhdzlQhiPlG+
         AIdD5+y5AA3sqxLhhgpLZZPN3eoYPAI9KYvFhm2/xdakH40RO1j7rBaVyOIlMnJ/twct
         vfY6lxY4L361i+lKCrSVeKwZTKX9CpeHWObp/mShEdaQKdLWeDgwSbvVfuuYYT8+Iy82
         CQytoHsTwM2Bre34HsXK54U+K2qD48n1g3hgwJHummner/oQ/is/HvKvh0bEOE/Nv/Oj
         aND/qHukMdzFwH6w3JFcrfc/WkRi3iiYWBuHVVmpjI4XcTimuNJMdKZC16YccTtFXjQH
         kMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708475161; x=1709079961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVXe5zTlKP4MQkzjeIKRSzNf6XFFbe0v6NlgmPohvbM=;
        b=H9MSy7dzv02lqtVlgQuUPFfiUEE20JR1sSD1I8pHUrXgzcKrkZelOW/LDY1Dqg1coZ
         b4GcX9vP3iNljXIY/SMYco6kmtIKHPeC833Sfmo3Jp8vLcBhL0hXi/IUF/9Qrg+pxpcu
         NV9xbe/cqb6GLuKpSTYQcvssCnxgN+Ss83QzdIlWNAsdTO2Do+AGb70o4/tPkQ/rIYvK
         jULAlVl4FByRwM7NnjxuRYPRRZH+ss63TI8tqTmAQy0+u0l632nzthEHfNtUcP+oFudE
         8inMNab47F+RYvzZ7JebstUnj4Oa/SXu2B79CshXFHCZ94F3CBJwl173MM3jju8guu44
         Y7aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfWf+Sr99+geRLApn1/UXN76meQsdsyAdLUePKpGAH2w9MiOsW77LqES21T0+fpjll1Scao3AVg4tLg6wpaBXE3BDmnaQtVlqDmYxZahMbAt3RMRmmd8BZ0N6Unmdx5ncJt7iyP5rPDg==
X-Gm-Message-State: AOJu0YxDlUFUsHvXcmWYx2wHGbDiTrawlEtK5i3tFFQkDmEJdJH1j7pf
	7/dOi6yo9Wu6rPCVdWLyVqPIrl0ULKjrpD0CaZQqPNv7bfydQTJJ
X-Google-Smtp-Source: AGHT+IEFakPUgG2qsfVii+SAk74Yq/6AvZJrIAjd018jJ+S//XuZGAawHNGtuAE16QK2UtyxxUlj+Q==
X-Received: by 2002:a17:90a:bf83:b0:299:2240:43d with SMTP id d3-20020a17090abf8300b002992240043dmr11076599pjs.30.1708475161223;
        Tue, 20 Feb 2024 16:26:01 -0800 (PST)
Received: from rigel ([220.235.35.85])
        by smtp.gmail.com with ESMTPSA id ok5-20020a17090b1d4500b0029658c7bd53sm290462pjb.5.2024.02.20.16.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 16:26:00 -0800 (PST)
Date: Wed, 21 Feb 2024 08:25:55 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] gpiolib: cdev: release IRQs when the gpio chip
 device is removed
Message-ID: <20240221002555.GA3311@rigel>
References: <20240220111019.133697-1-herve.codina@bootlin.com>
 <20240220111019.133697-3-herve.codina@bootlin.com>
 <20240220142959.GA244726@rigel>
 <20240220192657.3dd9480c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220192657.3dd9480c@bootlin.com>

On Tue, Feb 20, 2024 at 07:26:57PM +0100, Herve Codina wrote:
> Hi Kent,
>
> On Tue, 20 Feb 2024 22:29:59 +0800
> Kent Gibson <warthog618@gmail.com> wrote:
>

..

>
> I can call gcdev_unregister() right after gdev->chip = NULL.
> The needed things is to have free_irq() (from the gcdev_unregister()) called
> before calling gpiochip_irqchip_remove().
>
> And so, why not:
> --- 8< ---
> 	...
>         gpiochip_free_hogs(gc);
>         /* Numb the device, cancelling all outstanding operations */
>         gdev->chip = NULL;
> 	gcdev_unregister(gdev);
>         gpiochip_irqchip_remove(gc);
>         acpi_gpiochip_remove(gc);
>         of_gpiochip_remove(gc);
>         gpiochip_remove_pin_ranges(gc);
> 	...
> --- 8< ---
>

Exactly - why not.  Though adding some comments to the code as to why
that ordering is required, as per the numbing, would be helpful for
maintainability.

> >
> > There is also a race here with linereq_set_config().  That can be prevented
> > by holding the lr->config_mutex - assuming the notifier is not being called
> > from atomic context.
>
> I missed that one and indeed, I probably can take the mutex. With the mutex
> holded, no more race condition with linereq_set_config() and so the IRQ cannot
> be re-requested.
>
> >
> > You also have a race with the line being freed that could pull the
> > lr out from under you, so a use after free problem.
>
> I probably missed something but I don't see this use after free.
> Can you give me some details/pointers ?
>

What is to prevent userspace releasing the request and freeing the
linereq while you use it?  The use after free is anywhere that is
possible.

AIUI, from the userspace side that is prevented by the file handle not
being closed, and so linereq_release() not being called, while ioctls
are in flight.  But as you are calling in from the kernel side there is
nothing in place to prevent userspace freeing the linereq while you are
using it.

>
> > I'd rather live with the warning :(.
> > Fixing that requires rethinking the lifecycle management for the
> > linereq/lineevent.
>
> Well, currently the warning is a big one with a dump_stack included.
> It will be interesting to have it fixed.
>
> The need to fix it is to have free_irq() called before
> gpiochip_irqchip_remove();
>
> Is there really no way to have this correct sequence without rethinking all
> the lifecycle management ?
>

Not that I am aware of.  You need to protect against the linereq
being freed while you are using it, which is by definition is lifecycle
management.  Though it isn't necessarily __all__ the lifecycle management.

> Also, after the warning related to the IRQ, the following one is present:
> --- 8< ---
> [ 9593.527961] gpio gpiochip9: REMOVING GPIOCHIP WITH GPIOS STILL REQUESTED
> [ 9593.535602] ------------[ cut here ]------------
> [ 9593.540244] WARNING: CPU: 0 PID: 309 at drivers/gpio/gpiolib.c:2352 gpiod_free.part.0+0x20/0x48
> ...
> [ 9593.725016] Call trace:
> [ 9593.727468]  gpiod_free.part.0+0x20/0x48
> [ 9593.731404]  gpiod_free+0x14/0x24
> [ 9593.734728]  lineevent_free+0x40/0x74
> [ 9593.738402]  lineevent_release+0x14/0x24
> [ 9593.742335]  __fput+0x70/0x2bc
> [ 9593.745403]  __fput_sync+0x50/0x5c
> [ 9593.748817]  __arm64_sys_close+0x38/0x7c
> [ 9593.752751]  invoke_syscall+0x48/0x114
> ...
> [ 9593.815299] ---[ end trace 0000000000000000 ]---
> [ 9593.820616] hotplug-manager dock-hotplug-manager: remove overlay 0 (ovcs id 1)
> gpiomon: error waiting for events: No such device
> #
> --- 8< ---
>

My understanding is that we now handle that case - that is what
the gdev->device_notifier chain is for, and gpiolib and gpiolib-cdev now
perform a controlled cleanupi - so that warning is obsolete and should be
removed from gpiochip_remove().

IIRC, previously you would've gotten a panic shortly after that warning.
Now you get gpiomon noticing that the device has been removed.

Btw, where I mention linereq here, the same applies to lineevent and
linehandle - the uAPI v1 equivalents of linereq.

Cheers,
Kent.

