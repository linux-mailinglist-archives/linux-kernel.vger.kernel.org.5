Return-Path: <linux-kernel+bounces-140227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DF58A0E67
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5CCE285E63
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71E91465A2;
	Thu, 11 Apr 2024 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NLOM82Oz"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD84B145B3E;
	Thu, 11 Apr 2024 10:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830455; cv=none; b=JzywzzFk/xRDjXQa92JdZY7bJOXgLJHGc4APjY4O/TZTOQr31+aTA3gznOKBaEm/rJSMP1UX/nbdlTfS6KEuwy0eg6q+/VOBsyCKj7GCufjNDprwjN1XAhbbrJwQ3/dm1LAwUu/F90C6ELFvIuxlQBRAFivLSGAzDPcVq8jJH3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830455; c=relaxed/simple;
	bh=mIiR5+e+l2jTYUs6ji27JbnMDzbTv+h4m4icjPb7REY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=swtyWE8qJORBcKNz3wipb4C0reU0/MxxzbdvOLv79rf+PZhs4NSrEjjuOlwwYc2EWdEwVO5dWFV+mZt+uh6zl1tY2ltS52SeZpuTITVgxwM06IdCVlHmbjBVwa7hiwBePG4rK3Xdkp6L8pzuyovXRb9LgcuHkLWLtCRgT7XjMmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NLOM82Oz; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D6D140006;
	Thu, 11 Apr 2024 10:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712830450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r29/kIGqcmoe5Q56OOEiHGJ3bdPBa/zexDs6zdvg0A8=;
	b=NLOM82OzTNpduyfXeECKXTy2l1KeB4TlDQ3Cyx24Vyacump5ak8yIbKinNuIb137lHQs4C
	s8qgGg3sScr3pz2epgdEt93tfcxUPdLOxg3GVW5ZgwvHqJ9CUCHiU33iLHqLACS8O+8GX3
	97l7j4wjuwG/H+KoawgSxAiaWFMGHQJibLoU49OYXC6jqzzTl49mdniTDW9wS7pwraP6xU
	tP3wB4PKD0O3FFCVEMAQhBeTm3AjvF/VPkjO0pIijAesZhzTdvWwW/pJ+2ch2aB4HEzuw9
	bABWQ1g+oHku3AnMKjjnLVB6bEFHzEk6I3thJ5a+G7YHc1IMY5OzLxQsi5WTrQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Apr 2024 12:14:09 +0200
Message-Id: <D0H7PXOXYNXI.2QM4E0O02FK34@bootlin.com>
Cc: <linux-mips@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Stephen Boyd" <sboyd@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Linus Walleij"
 <linus.walleij@linaro.org>, "Michael Turquette" <mturquette@baylibre.com>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Rob Herring" <robh@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH 04/11] clk: divider: Introduce CLK_DIVIDER_EVEN_INTEGERS
 flag
X-Mailer: aerc 0.15.2
References: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com>
 <20240410-mbly-olb-v1-4-335e496d7be3@bootlin.com>
 <4ce9f3cea1ecd3777cf3e291cc865210.sboyd@kernel.org>
In-Reply-To: <4ce9f3cea1ecd3777cf3e291cc865210.sboyd@kernel.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu Apr 11, 2024 at 5:06 AM CEST, Stephen Boyd wrote:
> Quoting Th=C3=A9o Lebrun (2024-04-10 10:12:33)
> > index 4a537260f655..cb348e502e41 100644
> > --- a/include/linux/clk-provider.h
> > +++ b/include/linux/clk-provider.h
> > @@ -675,13 +675,15 @@ struct clk_div_table {
> >   * CLK_DIVIDER_BIG_ENDIAN - By default little endian register accesses=
 are used
> >   *     for the divider register.  Setting this flag makes the register=
 accesses
> >   *     big endian.
> > + * CLK_DIVIDER_EVEN_INTEGERS - clock divisor is 2, 4, 6, 8, 10, etc.
> > + *     Formula is 2 * (value read from hardware + 1).
> >   */
> >  struct clk_divider {
> >         struct clk_hw   hw;
> >         void __iomem    *reg;
> >         u8              shift;
> >         u8              width;
> > -       u8              flags;
> > +       u16             flags;
>
> This can stay u8

It is unclear to me why it can stay u8? __clk_hw_register_divider() puts
clk_divider_flags into flags field of struct clk_divider.
BIT(8) overflows u8.

>
> >         const struct clk_div_table      *table;
> >         spinlock_t      *lock;
> >  };
>
> We should add a kunit test.

Will look into how this works and try something for next revision. I
guess you are talking about adding clk_divider tests, not only tests
for this flag? I cannot find any existing kunit tests for clk_divider.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


