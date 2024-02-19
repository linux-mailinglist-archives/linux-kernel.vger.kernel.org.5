Return-Path: <linux-kernel+bounces-71621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0FF85A7E9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9701C22D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE6D39840;
	Mon, 19 Feb 2024 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c2Musslz"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193E23A1B6;
	Mon, 19 Feb 2024 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358101; cv=none; b=jMqsQ01YGHRFljX9N9cZUIPL92ENbm0u1ZtbJlknSSnx7snhi2WPxXsuukAEHXPB9iR1m6uPI8jJb00D+jtRsId+Sik0r6+Hx4ShWAqbzn67Njc7WTIVwViy1WSOVGZISvESmEWW4uuNjTAnpb4oDjEzbMYhwLmapNDWWO4l9IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358101; c=relaxed/simple;
	bh=nC6aNc13U8MY/Slx3JehF2zXFuomJ7JF1NoXY9rqw9E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=lKA6x/h1rRskyE74xkGMVwvUZisFSlmYKbA/j5i91q1yLKaoKxWsHPqJocV5fBvNxNUWXRuzRCSkDALc16Wk/E7RKhdPk7Joilwl4GmDEFHALs3nuSrsZWyxbC9ZrVeNBQkcZ9VB7UP33vx8Smbp4782Y1oZ+dE4rOOAP4enO3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c2Musslz; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8374C40004;
	Mon, 19 Feb 2024 15:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708358096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JuVnxXLKBjOZXpqRb8ZUGYryBu30CeayscqdEmLRicA=;
	b=c2MusslzRHELYgxEV8vD36ddn12pVPyko1ZZ/zs6hqIWrg1An262098RPUuU6Zt7BdqLCF
	5Z8laMNgpFdVYKME13I4EgK13u6VQR+Xyu4Nb0YVurEsKAnL3IfCSZlHNQ+en3LcE/yiNM
	IHXUkIMNu4jNrbex14/R09P/kOCjcvluN5xxyQRmTjbsfRx5zULw9SNSDb1L6TzM1FlHii
	bM0Ae80hmG3isfFQanv7M7q53LuopxX9EpRjMoPffWJSmCEzg4XQcFOSU4IA4eSn8NRldK
	S9zWCUdapYB4zuP0vgAtcwWNImh9UFb+4omk1WeF5Z1hlGuAzXoD/ykvFwgOyg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Feb 2024 16:54:55 +0100
Message-Id: <CZ96EIJ22CYS.1AMRRY388V466@bootlin.com>
Subject: Re: [PATCH 16/23] gpio: nomadik: support shared GPIO IRQs
Cc: "Linus Walleij" <linus.walleij@linaro.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Thomas Bogendoerfer"
 <tsbogend@alpha.franken.de>, <linux-gpio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mips@vger.kernel.org>,
 "Gregory CLEMENT" <gregory.clement@bootlin.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Bartosz Golaszewski" <brgl@bgdev.pl>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20240214-mbly-gpio-v1-0-f88c0ccf372b@bootlin.com>
 <20240214-mbly-gpio-v1-16-f88c0ccf372b@bootlin.com>
 <CAMRc=MdFBFFTYKHgDfOieNZJ+-x7ZZMiYty6buOp2J=eFUjt0Q@mail.gmail.com>
In-Reply-To: <CAMRc=MdFBFFTYKHgDfOieNZJ+-x7ZZMiYty6buOp2J=eFUjt0Q@mail.gmail.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Mon Feb 19, 2024 at 4:48 PM CET, Bartosz Golaszewski wrote:
> On Wed, Feb 14, 2024 at 5:24=E2=80=AFPM Th=C3=A9o Lebrun <theo.lebrun@boo=
tlin.com> wrote:
> >
> > Support a single IRQs used by multiple GPIO banks. Change the IRQ
> > handler type from a chained handler (as used by gpiolib
> > for ->parent_handler) to a threaded IRQ.
> >
> > Use a fake raw spinlock to ensure generic_handle_irq() is called in a
> > no-irq context. See Documentation/driver-api/gpio/driver.rst, "CHAINED
> > CASCADED GPIO IRQCHIPS" for additional information.
> >
>
> Any reason for not using preempt_disable()?

I did what the doc recommended:

> The generic_handle_irq() is expected to be called with IRQ disabled,
> so the IRQ core will complain if it is called from an IRQ handler which i=
s
> forced to a thread. The "fake?" raw lock can be used to work around this
> problem::
>
>   raw_spinlock_t wa_lock;
>   static irqreturn_t omap_gpio_irq_handler(int irq, void *gpiobank)
>       unsigned long wa_lock_flags;
>       raw_spin_lock_irqsave(&bank->wa_lock, wa_lock_flags);
>       generic_handle_irq(irq_find_mapping(bank->chip.irq.domain, bit));
>       raw_spin_unlock_irqrestore(&bank->wa_lock, wa_lock_flags);

If you confirm I should be using preempt_disable() that's what I'll do
in the next revision. I could even throw in a documentation patch if
the advice is outdated.

Thanks Bartosz,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

