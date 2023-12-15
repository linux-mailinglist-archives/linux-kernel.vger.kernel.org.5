Return-Path: <linux-kernel+bounces-965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7A18148A6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A620F2862C4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B092D052;
	Fri, 15 Dec 2023 12:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeqDRdKf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715FD2EB19;
	Fri, 15 Dec 2023 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50bf2d9b3fdso745422e87.3;
        Fri, 15 Dec 2023 04:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702645074; x=1703249874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SxQUqw1Lm+f1JkkxgaJEJfwFFhEdNqCTWcPVADcjmLY=;
        b=GeqDRdKfctVkl2pPCH28Y7H+yPFUNckY2DpBWboPL6YOFSnQT4xxsZOr0U06oNhXwe
         sW2N2LpGgCEHMBYwB8vGefYbMql6UjQjzaZg1Tx2m97PPcYNNXBkGkXCTJHNSS/YnS71
         n8rMpk8tsEfX9YFIIgp5TIvhhxLRlWllgyCWqm8SYMAJORal8/8vDn5tpD8KtkJ5qd8r
         oC2GrIvSFGGRX8ypLlFPNEJzTrKIvB9nhIkbkRdJUYv4IWxKVM+aYWjdzbX4p1UcDr3K
         hatJKIwSNKUsYsGrDiWwuFPZtVbzWFg3KrlmV2jyekady2BnV5gHfDA43pD4SXxWHFEx
         CmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702645074; x=1703249874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxQUqw1Lm+f1JkkxgaJEJfwFFhEdNqCTWcPVADcjmLY=;
        b=MWtr9Tg5QRTdm3Hixq0UATqHRGlD0J5RCQPMUKB3y5Ip9YhV5o3oWye7f0bbObCMIS
         e1f3zIPZDZjvu1zZPrLbJh2YD+8SLcuxGNY6N8CPoJVTjztBvLULE5SvdDNqORzamPIQ
         fPJHDqRZcgDDnIYqXG+xYAsXixi3R44TlYuoAHYOHGruvf8asUbiBcsDdEPojL0jUW8z
         QWi4RmMYetpOIgEzkXUXFrsLI0MA62qPrxMfMjZL9Wx+m0HvKErMLA9rKgiLxAv4b2/j
         rKQ2Gs1DZNceHqDIXChr7awDJQYcxScdvMqXBysZ2z053ZLzeLN9uHEkuyUE1OVCk2SV
         BCpw==
X-Gm-Message-State: AOJu0YwOXYUxHF3+41VP/FZgn/8x2XvspMBtxZ32z+P3HEWwiyWwIad1
	qpBA91NDg01lk62U5wmhQgA=
X-Google-Smtp-Source: AGHT+IHeJ8e1gIyJ1b3bEecLwUOd0jndfwhm3VO8l5uoZxTcjSLZOVhzDmxEVk/yoM7dgzhJRAFidw==
X-Received: by 2002:ac2:5497:0:b0:50b:f006:3f92 with SMTP id t23-20020ac25497000000b0050bf0063f92mr5227019lfk.134.1702645074149;
        Fri, 15 Dec 2023 04:57:54 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id w22-20020ac254b6000000b0050bf273a895sm2129201lfk.240.2023.12.15.04.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 04:57:53 -0800 (PST)
Date: Fri, 15 Dec 2023 15:57:51 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, xiongxin <xiongxin@kylinos.cn>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Luo Jiaxing <luojiaxing@huawei.com>, Marc Zyngier <maz@kernel.org>, 
	Bartosz Golaszewski <bgolaszewski@baylibre.com>, Serge Semin <Sergey.Semin@baikalelectronics.ru>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v1] gpio: dwapb: mask/unmask IRQ when disable/enable it
Message-ID: <osesb4frbdajs5cdfzwcbdpap44r6gry4tcy57xoms2nabo7eg@phehazlr6cm5>
References: <1606728979-44259-1-git-send-email-luojiaxing@huawei.com>
 <CACRpkdYHAecm3ygaze80SsXzNMYSA9p+p6JY4BKO2D+vArb-WA@mail.gmail.com>
 <87fs03opju.ffs@tglx>
 <cbgdeksaulqu65nbnz7l4wpuwensllkdlyi5babhpngclze4df@zxetbohgpfvg>
 <87a5qbohtp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5qbohtp.ffs@tglx>

On Fri, Dec 15, 2023 at 11:56:02AM +0100, Thomas Gleixner wrote:
> On Fri, Dec 15 2023 at 13:24, Serge Semin wrote:
> > On Fri, Dec 15, 2023 at 09:09:09AM +0100, Thomas Gleixner wrote:
> >> On Sat, Dec 05 2020 at 22:58, Linus Walleij wrote:
> >> > Sorry for top posting but I need the help of the irqchip maintainer
> >> > Marc Z to hash this out.
> >> >
> >> > The mask/unmask/disable/enable semantics is something that
> >> > you need to work with every day to understand right.
> >> 
> >> The patch is correct.
> >> 
> >> The irq_enable() callback is required to be a superset of
> >> irq_unmask(). I.e. the core code expects it to do:
> >> 
> >>   1) Some preparatory work to enable the interrupt line
> >> 
> >>   2) Unmask the interrupt, which is why the masked state is cleared
> >>      by the core after invoking the irq_enable() callback.
> >> 
> >> #2 is pretty obvious because if an interrupt chip does not implement the
> >> irq_enable() callback the core defaults to irq_unmask()
> >> 
> >> Correspondingly the core expects from the irq_disable() callback:
> >> 
> >>    1) To mask the interrupt
> >> 
> >>    2) To do some extra work to disable the interrupt line
> >> 
> >> Same reasoning as above vs. #1 as the core fallback is to invoke the
> >> irq_unmask() callback when the irq_disable() callback is not
> >> implemented.
> >
> > Just curious. Wouldn't that be more correct/portable for the core to
> > call both callbacks when it's required and if both are provided? So
> > the supersetness requirement would be no longer applied to the
> > IRQ enable/disable callbacks implementation thus avoiding the code
> > duplications in the low-level drivers.
> 
> We could do that, but there are chips which require atomicity of the
> operations (#1/#2). Not sure whether it safes much.

I see. Thanks for the answer. Right, seeing there are only three GPIO
drivers have such problem:
drivers/gpio/gpio-ml-ioh.c
drivers/gpio/gpio-dwapb.c
drivers/gpio/gpio-hisi.c
it's better to leave the semantics as is. It just isn't worth it to
risk breaking so many platforms due to several drivers.

Regarding this patch implementation. It can be optimized a bit:
diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index 4a4f61bf6c58..15943f67758c 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -282,13 +282,15 @@ static void dwapb_irq_enable(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct dwapb_gpio *gpio = to_dwapb_gpio(gc);
+	u32 mask = BIT(irqd_to_hwirq(d));
 	unsigned long flags;
 	u32 val;
 
 	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
-	val = dwapb_read(gpio, GPIO_INTEN);
-	val |= BIT(irqd_to_hwirq(d));
+	val = dwapb_read(gpio, GPIO_INTEN) | mask;
 	dwapb_write(gpio, GPIO_INTEN, val);
+	val = dwapb_read(gpio, GPIO_INTMASK) & ~mask;
+	dwapb_write(gpio, GPIO_INTMASK, val);
 	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }
 
@@ -296,12 +298,14 @@ static void dwapb_irq_disable(struct irq_data *d)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct dwapb_gpio *gpio = to_dwapb_gpio(gc);
+	u32 mask = BIT(irqd_to_hwirq(d));
 	unsigned long flags;
 	u32 val;
 
 	raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
-	val = dwapb_read(gpio, GPIO_INTEN);
-	val &= ~BIT(irqd_to_hwirq(d));
+	val = dwapb_read(gpio, GPIO_INTMASK) | mask;
+	dwapb_write(gpio, GPIO_INTMASK, val);
+	val = dwapb_read(gpio, GPIO_INTEN) & ~mask;
 	dwapb_write(gpio, GPIO_INTEN, val);
 	raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
 }

Seeing Luo' email bounces back, Xiang (sorry if I spell your name
incorrectly), could you please test the patch above out whether it
fixes your problem, and then resubmit it?  Please don't forget to add
a Fixes tag. I guess the problem has been here since the driver
birthday:
Fixes: 7779b3455697 ("gpio: add a driver for the Synopsys DesignWare APB GPIO block")

-Serge(y)


> 
> Thanks,
> 
>         tglx

