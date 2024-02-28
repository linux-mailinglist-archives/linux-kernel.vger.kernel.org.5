Return-Path: <linux-kernel+bounces-84273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8DB86A474
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED5F1C2356C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14077EB;
	Wed, 28 Feb 2024 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOk+GioF"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5551363;
	Wed, 28 Feb 2024 00:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709080168; cv=none; b=PToBUyIbI/Ha/NvRiRMhKMBybC/incANTbb6n9y6SapHRNfmYLpPtyhe+weiSbbYMr95lSXyBLvLJmp3TcEyqxQ+okMekBdoqAlI+YMV9J/0n8aqdl8C90zhwXyr/9LRvqIs5n1m1NDhHYztQTajmvrHCD9IDiNXuFQ/XN4FtQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709080168; c=relaxed/simple;
	bh=6TISGXqP8reGXr3MP49CKge30gPUg3uo3jKiNzABcnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6z1G3fGCGTkxhihSLSOUKYqH/29I0i8cLM897TmN8vHEm244o6m4o6Yr22pjtMWzMvV/EVWEOFPj0YsS+EW55qZXFlbYPdxkqKUcMPbZ80P+08ZfpLkOCpf6Ebe88rELLhUPmmdFsM2dFwwTmjm0VDd36OtXqdkEeIShfJpPAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOk+GioF; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e554f64971so285203b3a.1;
        Tue, 27 Feb 2024 16:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709080166; x=1709684966; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qxQxvMZWjt9T0hO0TPYQxcU22VwhY9xRByh1fp2nWAE=;
        b=gOk+GioFOTcaJVyTWjdTlXGUgPsyOOfGGwqVflsjyVZqOMbVRG2l8Q3LKmerfYVAT4
         sOoMHs7hO6zsYxKDdAZPm+UaATqm/crpBsB+oNRP9N/KAhg8JUdM11ke0t9BxTMinJyd
         tWY1gvIKuJQjYlJbSNNn4SdG8pAGnKGX91o3W+JHMzMX55KBGFq3CMW+xqkUIB6gx84I
         m0iqlEEx3ugFqWUcUZ1th0fBWy7qfQK9S1PbnZRCqG6Jsmw3Ts3nBfnQZZWbWloEWp9i
         cjLcAPFpLOLax6N8pOxNODYiP9NQFnz8W+O7+R09vv0KVzDrz5zh0RXF5dlZ8VyrM62E
         x29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709080166; x=1709684966;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxQxvMZWjt9T0hO0TPYQxcU22VwhY9xRByh1fp2nWAE=;
        b=ZTl4ZInYouMpy3nCOFRz1rFEL7xbGRsShddmwFTscWP3JUwKmB48I0wjbLVKgvHo8m
         d7kiShH3LpbdG8gjnguewdZ9DlYJtYsevgjEjfuJztclo2jmb5qMviLzrVNlClm2BR8q
         O94ZZqOxiiNpUgvMXALauPlFaYHCrRcz/TULJhU9TDeSn3hyNvTeJB3bfCtwLe1aWGjs
         NScapg1O5IrOGgiBzqtglukFerONz/JaXVs40YjdKGTYeCSpPwqPd0Mm4YZX1eFgNH+v
         mhDV1gSbqa8D2y+RLHO63VEfa8hK2qlJddF95j/6V1Wzz0jH8SJtwPhxh8vr9s2bxxnT
         xGyA==
X-Forwarded-Encrypted: i=1; AJvYcCWw4YURD/X9K2actYJFdCBgZF/UrTjlcwE2JqPNBrn83HsjFDDbPDd1vNd4uLwKYm+i5RTMcV+af9fQzOG7V1vyQ7LfcnEnPBuPzjrkRDaSDLLxY1w/MgXxAMsR561kDVG6fPprU726hw==
X-Gm-Message-State: AOJu0YxW/VgAh0Ht/Tw3lXwc0xq5JLswdOHkx7iYwxH+mlXrDwY5+mxF
	sB8msCh8t3w0PX9RXuNEwJxAGRB7cft7bGZsqinozZYAiyaWVb9d
X-Google-Smtp-Source: AGHT+IGsaI/hTnIc84B+CHWH5pz28PtLiaYEQT3ECTmQROcmN0DLV//Va8cWULmnCx2NbxMGVXfNEw==
X-Received: by 2002:a05:6a00:84a:b0:6e5:5425:e285 with SMTP id q10-20020a056a00084a00b006e55425e285mr1424566pfk.13.1709080166056;
        Tue, 27 Feb 2024 16:29:26 -0800 (PST)
Received: from rigel ([220.235.35.85])
        by smtp.gmail.com with ESMTPSA id x14-20020aa784ce000000b006e0416c42c3sm6540491pfn.198.2024.02.27.16.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 16:29:25 -0800 (PST)
Date: Wed, 28 Feb 2024 08:29:19 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Saravana Kannan <saravanak@google.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 0/2] gpio-cdev: Release IRQ used by gpio-cdev on gpio
 chip removal
Message-ID: <20240228002919.GA4381@rigel>
References: <20240227113426.253232-1-herve.codina@bootlin.com>
 <CAMRc=MeSMTnPUYGyJir4fc=6=Gnw_MVP9wfEKMQ6Ck33FYCrRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeSMTnPUYGyJir4fc=6=Gnw_MVP9wfEKMQ6Ck33FYCrRA@mail.gmail.com>

On Tue, Feb 27, 2024 at 08:31:33PM +0100, Bartosz Golaszewski wrote:
> On Tue, Feb 27, 2024 at 12:34 PM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > Hi,
> >
> > When a gpio chip device is removed while some related gpio are used by
> > the user-space (gpiomon for instance), the following warning can appear:
> >   remove_proc_entry: removing non-empty directory 'irq/233', leaking at least 'gpiomon'
> >   WARNING: CPU: 2 PID: 72 at fs/proc/generic.c:717 remove_proc_entry+0x190/0x19c
> >   ...
> >   Call trace:
> >     remove_proc_entry+0x190/0x19c
> >     unregister_irq_proc+0xd0/0x104
> >     free_desc+0x4c/0xc4
> >     irq_free_descs+0x6c/0x90
> >     irq_dispose_mapping+0x104/0x14c
> >     gpiochip_irqchip_remove+0xcc/0x1a4
> >     gpiochip_remove+0x48/0x100
> >   ...
> >
> > Indeed, even if the gpio removal is notified to the gpio-cdev, the
> > IRQ used is not released when it should be.
> >
> > This series calls the gpio removal notifier sooner in the removal
> > process in order to give a chance to a notifier function to release
> > the IRQ before releasing the IRQ mapping and adds the needed
> > operations to release the IRQ in the gpio cdev notifier function.
> >
> > Compared to the previous iteration:
> >   https://lore.kernel.org/linux-kernel/20240220111019.133697-1-herve.codina@bootlin.com/
> > this v2 series set gdev->chip to NULL before calling gcdev_unregister().
> >
> > Also, this v2 series was rebased on top of for-next branch of the GPIO
> > tree.
> >
> > Best regards,
> > Hervé Codina
> >
> > Changes v1 -> v2:
> >   - Patch 1
> >     Set gdev->chip to NULL before calling gcdev_unregister()
> >
> >   - Patch 2
> >     No changes
> >
> > Herve Codina (2):
> >   gpiolib: call gcdev_unregister() sooner in the removal operations
> >   gpiolib: cdev: release IRQs when the gpio chip device is removed
> >
> >  drivers/gpio/gpiolib-cdev.c | 33 ++++++++++++++++++++++-----------
> >  drivers/gpio/gpiolib.c      |  6 +++++-
> >  2 files changed, 27 insertions(+), 12 deletions(-)
> >
> > --
> > 2.43.0
> >
>
> Sorry but this is just papering over the real issue. I'd say NAK for
> now as I'd really prefer to get to the root of the problem and fix it
> for all GPIO interrupt users.
>
> Kent, Linus: what do you think?
>

Agreed - a broader solution makes sense to me.

Cheers,
Kent.

