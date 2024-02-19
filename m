Return-Path: <linux-kernel+bounces-71657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFCB85A88D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 919091C22C0C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CC53D553;
	Mon, 19 Feb 2024 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="D7n86fEA"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEF53C482
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359456; cv=none; b=SAb+KnpGkxcfVD8+URnnsSebtHFSI23yHEPWUXShk4psGtPna02UrhL9Z42Zgvw0KT1X7uoSJVRu7tqDKxDalrt7Xsm64zJeLo1AqHe2rgFh67AY2TeLN0V378gTvjNj7mXNXCMrVKF3g9MI0Hmq3qfKvZkVyOrhKnzXwkYwfD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359456; c=relaxed/simple;
	bh=134bTW4U/2yBPsvBKV9Njbp4VULnpfYtNg0d/8VXWnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlS7xMeDGa/bxmkViDH9dKtP557cwOJ7jFTcaf6vZm5l5MSzOlXsOAFYdeUR600FnH6SEyOMSw9ita4VkC2WgLhDMXssfVuhf6EOu3R1eG7ce8nHlVC2jfi/MCCTzYvwFKIb0Q1J5hyJ+ESgiKUXPPF0fmXZPrv4f5yfSAun7Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=D7n86fEA; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e4423b64acso1415034a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708359451; x=1708964251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kx7otSCPMC2vGVuskOYxTO3G/UHr78DMGo93ZWkapNk=;
        b=D7n86fEABi7eir2Agli7r+8kVHPl9MdUS4U3cgA3zAxLq59Oy7tVK4yHOiWQaZvJrH
         VF3XodRiztJSbsbOYitfu7UMh7G2GKGsHRE3a2xfnfLrmpnxuh9mN2sRgvMIBAW2D6O9
         xZI5F73/yusts6KL5KcmOrxUfXQtCqF1GPUB+hfOALvH2Qccm66Jopt5mKeJKi1pxa/0
         gSIxODp+RfnR2+eHKBRgvXjodW4rrQDSNhdiGxPhMHUuasWvKR7ETfCocgMORLB7gV4N
         Z3hm1Lzh+yLxivxMeiYt9MUry/YVcVqzk4j0lkm2wvqiinSVLq+BWYKZaQnGgLfcIuQR
         mcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708359451; x=1708964251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kx7otSCPMC2vGVuskOYxTO3G/UHr78DMGo93ZWkapNk=;
        b=b+pJXrcwFQjXmjGqLnAcHEunXFgdAG3+hR0LBGKdvIYBgxZqI1FagwVMKTZUnCft4i
         EvHAhHBL9ksbSha8A3Qtyd031lGET/uL4paxgOWHNstQtICzpgvraoWH8Y977m6A9bC0
         sEhnBbapbP8jDBiT7kVHlF6PZc4xUK4NDs5yoXSZqEnB4KKrAH7jzCpf8WZF0G48EoCr
         n7Jriherh3cgCW6V9xOAMiq4+O1e9RGimARn3Zh7llA7FgVduZ8kgCEpXFzC4sJErG9Y
         n74EieSXgCP2mGuIZakhTdmVaoSlFTnMvesGr27FG0xihd4rG07SdV6lKh1hXXbJhp9y
         tfJA==
X-Forwarded-Encrypted: i=1; AJvYcCV6wttHEylmieKZVBb4FMuv6NE6R+MHV+yvXlNdFr5RU604Ojuz4vF1ZhW64+uF/q3GHEEzWJzv8TmsDUoHPPNthOlFvjoj/l0Q3gIs
X-Gm-Message-State: AOJu0Yxo1PyIpfFNHS7iBZ2vwtVXt+Pdo9PgHt09lC/+EMWPIIHlLJ/p
	+9hQR3qxQrDMtO7rMsbczlIdNB6LrZJ+qf4M7fkBTP6RyakUEl4dtpQ787EC59xHttY060aFMSZ
	xk3YjR/zb8JWvC/K7OxUjG8vmVEmvmG4JwOIbDw==
X-Google-Smtp-Source: AGHT+IHLc5XDQogejfKFq5lHHEBUSI8TRIOeJ3TyooCJAymEvtY43bPRYPfmxEE9KAkgeTSwA8/zKkIr9WkBBX3Fwrg=
X-Received: by 2002:a05:6870:4706:b0:21e:b50c:3e90 with SMTP id
 b6-20020a056870470600b0021eb50c3e90mr5881476oaq.37.1708359451275; Mon, 19 Feb
 2024 08:17:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
 <20240214-mbly-gpio-v1-16-f88c0ccf372b@bootlin.com> <CAMRc=MdFBFFTYKHgDfOieNZJ+-x7ZZMiYty6buOp2J=eFUjt0Q@mail.gmail.com>
 <CZ96EIJ22CYS.1AMRRY388V466@bootlin.com>
In-Reply-To: <CZ96EIJ22CYS.1AMRRY388V466@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 19 Feb 2024 17:17:20 +0100
Message-ID: <CAMRc=MeKOJLMCxr2iMSYSK0A0O2L=Mw96B1opYiPdLsqQrB0_w@mail.gmail.com>
Subject: Re: [PATCH 16/23] gpio: nomadik: support shared GPIO IRQs
To: =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 4:54=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@bootl=
in.com> wrote:
>
> Hello,
>
> On Mon Feb 19, 2024 at 4:48 PM CET, Bartosz Golaszewski wrote:
> > On Wed, Feb 14, 2024 at 5:24=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@b=
ootlin.com> wrote:
> > >
> > > Support a single IRQs used by multiple GPIO banks. Change the IRQ
> > > handler type from a chained handler (as used by gpiolib
> > > for ->parent_handler) to a threaded IRQ.
> > >
> > > Use a fake raw spinlock to ensure generic_handle_irq() is called in a
> > > no-irq context. See Documentation/driver-api/gpio/driver.rst, "CHAINE=
D
> > > CASCADED GPIO IRQCHIPS" for additional information.
> > >
> >
> > Any reason for not using preempt_disable()?
>
> I did what the doc recommended:
>
> > The generic_handle_irq() is expected to be called with IRQ disabled,
> > so the IRQ core will complain if it is called from an IRQ handler which=
 is
> > forced to a thread. The "fake?" raw lock can be used to work around thi=
s
> > problem::
> >
> >   raw_spinlock_t wa_lock;
> >   static irqreturn_t omap_gpio_irq_handler(int irq, void *gpiobank)
> >       unsigned long wa_lock_flags;
> >       raw_spin_lock_irqsave(&bank->wa_lock, wa_lock_flags);
> >       generic_handle_irq(irq_find_mapping(bank->chip.irq.domain, bit));
> >       raw_spin_unlock_irqrestore(&bank->wa_lock, wa_lock_flags);
>
> If you confirm I should be using preempt_disable() that's what I'll do
> in the next revision. I could even throw in a documentation patch if
> the advice is outdated.
>
> Thanks Bartosz,

This was added 9 years ago:

commit c307b002548590c5d8c32b964831de671ad4affe
Author: Grygorii Strashko <grygorii.strashko@ti.com>
Date:   Tue Oct 20 17:22:15 2015 +0300

    gpio: add a real time compliance notes

    Put in a compliance checklist.

    Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
    Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I'm Cc'ing Grygorii - maybe he can remember if there was any reason
for using a spinlock over preempt_disable(). But for now I'd go with
the latter.

Bart

>
> --
> Th=C3=A9o Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

