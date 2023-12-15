Return-Path: <linux-kernel+bounces-748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A331E81457E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B91228573C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98368199C2;
	Fri, 15 Dec 2023 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1Wwsq2E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC221A705;
	Fri, 15 Dec 2023 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e0daa57b3so438044e87.3;
        Fri, 15 Dec 2023 02:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702635868; x=1703240668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=om+MewwPAHUnWXsD47rww5lBVph+7rgw3eM2axHBh94=;
        b=F1Wwsq2EI8iVcSBNzML20oTGhnIouEIE5x+d9ert8+ykuttu0m8j1NGbfPi61GMonD
         8d9alQtv2e83BstDtUDa26K5DHV+3V8XYjxO6sXsj2F9P/iIFXBrBGXrwXNvjdKSCNOW
         VKAF0R9AM6XM8R3v4wsj9whlFTvygVEYDNM1HgAxVk6bS7dX4fghXjET5qu7XF52XBkt
         YzVxIu7+7OTSj5LPp0xVZ9VRf8ojotK2x0d5erdPuNMiasAV0jW2bhm0EijHfiFYWgAZ
         GY318PXhCDucbkBeoomz2b4RJzF7da/0kaDoOLyuPSQwnMw4z2Yujn3MtZynBUqek5wY
         3IUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702635868; x=1703240668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=om+MewwPAHUnWXsD47rww5lBVph+7rgw3eM2axHBh94=;
        b=TGm+a4TAf0sz1THGbacJV+pd/Q8hBDl0obcb12GtNZts/XUljVNIG16PGCZKMcXfF8
         JOSoD6HV7DRYP4sojWFJdTbECxG1fzCiLScCRttHTlUNBuX13jkwJmQQrVLEjunBaZTD
         st/NjrGKuEnKqIzFNjAhZYn6ddtJ/yFER2kiEgbszajJ6dTY6sf2rkQFEsp+8GKK64wp
         +E3UILu4IH/jVjLYwt0u+wrnRFT9ImQ3MHzBaYS5tB0Z0qkhIRhwQLmEmEVAeBGgB/A2
         x0bM+M3URmym65WCJFexFZEFM0/83A3c2DdhBPXNuhmVNQmu3NASaWMsYZweiLLHe564
         v6jQ==
X-Gm-Message-State: AOJu0Yye41lMG+FWDUiCj4lWAiSz0tvBWd6flgns99Pb0/SYeO/l1elY
	fI4nwRa7rNA1Ap48c9azHtk=
X-Google-Smtp-Source: AGHT+IEOdvJN/VuO9m1h+Q3nljd5HGuL3wtHlFPdlXZpWzlGvT175UcvVwO228kowyALDGTNRD84/w==
X-Received: by 2002:ac2:4ec1:0:b0:50b:fe11:b2ca with SMTP id p1-20020ac24ec1000000b0050bfe11b2camr3396267lfr.42.1702635868008;
        Fri, 15 Dec 2023 02:24:28 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id f20-20020ac251b4000000b0050c0c850bc4sm2036732lfk.7.2023.12.15.02.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 02:24:27 -0800 (PST)
Date: Fri, 15 Dec 2023 13:24:24 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Luo Jiaxing <luojiaxing@huawei.com>, Marc Zyngier <maz@kernel.org>, 
	Bartosz Golaszewski <bgolaszewski@baylibre.com>, Serge Semin <Sergey.Semin@baikalelectronics.ru>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v1] gpio: dwapb: mask/unmask IRQ when disable/enable it
Message-ID: <cbgdeksaulqu65nbnz7l4wpuwensllkdlyi5babhpngclze4df@zxetbohgpfvg>
References: <1606728979-44259-1-git-send-email-luojiaxing@huawei.com>
 <CACRpkdYHAecm3ygaze80SsXzNMYSA9p+p6JY4BKO2D+vArb-WA@mail.gmail.com>
 <87fs03opju.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fs03opju.ffs@tglx>

Hi Thomas

On Fri, Dec 15, 2023 at 09:09:09AM +0100, Thomas Gleixner wrote:
> On Sat, Dec 05 2020 at 22:58, Linus Walleij wrote:
> > Sorry for top posting but I need the help of the irqchip maintainer
> > Marc Z to hash this out.
> >
> > The mask/unmask/disable/enable semantics is something that
> > you need to work with every day to understand right.
> 
> The patch is correct.
> 
> The irq_enable() callback is required to be a superset of
> irq_unmask(). I.e. the core code expects it to do:
> 
>   1) Some preparatory work to enable the interrupt line
> 
>   2) Unmask the interrupt, which is why the masked state is cleared
>      by the core after invoking the irq_enable() callback.
> 
> #2 is pretty obvious because if an interrupt chip does not implement the
> irq_enable() callback the core defaults to irq_unmask()
> 
> Correspondingly the core expects from the irq_disable() callback:
> 
>    1) To mask the interrupt
> 
>    2) To do some extra work to disable the interrupt line
> 
> Same reasoning as above vs. #1 as the core fallback is to invoke the
> irq_unmask() callback when the irq_disable() callback is not
> implemented.

Just curious. Wouldn't that be more correct/portable for the core to
call both callbacks when it's required and if both are provided? So
the supersetness requirement would be no longer applied to the
IRQ enable/disable callbacks implementation thus avoiding the code
duplications in the low-level drivers.

-Serge(y)

> 
> Thanks,
> 
>         tglx
> 

