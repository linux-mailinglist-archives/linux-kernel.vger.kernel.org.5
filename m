Return-Path: <linux-kernel+bounces-86939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB90186CD48
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC251C20F6C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8C714A0B4;
	Thu, 29 Feb 2024 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QeIIUBAa"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3201386A8;
	Thu, 29 Feb 2024 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221231; cv=none; b=eCLh0OfLfj9viFdoTxnXzFoc9adSE5srEFGm39m41Wu2CAh6IMunYzbdzrPmtZann+3DEvNtLeKHtEbmN0nKOwQ73yeQmHc8W+a7xAEgHJuJNl/aXDhlke6kqT08aCvAo2N/pErOTW8R3PPxfz2nhB27u29D04qw51gJ5YKw0ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221231; c=relaxed/simple;
	bh=EQgi8iVu9dfnXAmMpusat8htExrZVaTthXCEiPyqLdI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=d6tMZ5LtrJWzf6Y/3tLWPnbgD5QwfekmxjFrjKi7wNR4XubK2I+VUJPSU9YNzOy0rGx9JJgC3geM3gLvH4unrqkPKvGbLNNLYjbg4ICbRmW1SFJfWbgMNtjn230gwe2ko6FnrZPYtWmWk6j0Y1RHQrkTrfkpa40DnHtkhJ4AiQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QeIIUBAa; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E760C20003;
	Thu, 29 Feb 2024 15:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709221227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W8FxsAfQ33hyqTns+srsWzHvnSlEh7ZrIKcX6SabEuA=;
	b=QeIIUBAaEvMRAu5pXh6QOnWBHX6hApC5jX3qN0VHBOXTd+hBaqj+KFPq+j8uypG+tkBPbk
	Yhvq1N4APKtCaRk4MJXD4rRvjPHN0aiFwywDUhtbd7m/mPt9Jgizp0GQsONILG95XW4BH6
	ixak7rreYNcNp6JHCRJX4FBTr/8CNOoKouVtbQCGyrGsWESS2bIemMWHVxnIg62sc8VaKv
	5MhzH4I64yl4vVfrbYt/9EPYj+7wopGDdQYMtU62VJTcmXbVJ7t5Kr//nA31ZpA6QVc7NH
	783hMoIupZLDioaztrSkZYrBwbbcdoEGlqcVluDO9oeo3UWR7XdE89zm5IroRA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Feb 2024 16:40:25 +0100
Message-Id: <CZHOCV35A23S.14HL07U73EH6X@bootlin.com>
Cc: "Gregory CLEMENT" <gregory.clement@bootlin.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, "Linus Walleij"
 <linus.walleij@linaro.org>, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?=
 <rafal@milecki.pl>, "Philipp Zabel" <p.zabel@pengutronix.de>, "Vladimir
 Kondratiev" <vladimir.kondratiev@mobileye.com>,
 <linux-mips@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, <linux-gpio@vger.kernel.org>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v8 03/10] clk: eyeq5: add platform driver, and init
 routine at of_clk_init()
X-Mailer: aerc 0.15.2
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
 <20240227-mbly-clk-v8-3-c57fbda7664a@bootlin.com>
 <Zd4X3NnBoEl0wu2H@smile.fi.intel.com>
 <CZGSB2O8P572.28HK6WFT43N6S@bootlin.com>
 <ZeBnX2upNRN0xXH4@smile.fi.intel.com>
 <CZHMSNWMH4KJ.2J6ZMWKMSZYH2@bootlin.com>
 <ZeCbvgWY6x1o17Kq@smile.fi.intel.com>
In-Reply-To: <ZeCbvgWY6x1o17Kq@smile.fi.intel.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu Feb 29, 2024 at 3:59 PM CET, Andy Shevchenko wrote:
> On Thu, Feb 29, 2024 at 03:27:01PM +0100, Th=C3=A9o Lebrun wrote:
> > On Wed, Feb 28, 2024 at 03:33:29PM +0100, Th=C3=A9o Lebrun wrote:
> > > On Tue Feb 27, 2024 at 6:11 PM CET, Andy Shevchenko wrote:
> > > > On Tue, Feb 27, 2024 at 03:55:24PM +0100, Th=C3=A9o Lebrun wrote:
>
> [...]
>
> > > > > > +	u32		reg;	/* next 8 bytes are r0 and r1 */
> > > > >
> > > > > Not sure this comments gives any clarification to a mere reader o=
f the code.
> > > > > Perhaps you want to name this as reg64 (at least it will show tha=
t you have
> > > > > 8 bytes, but I have no clue what is the semantic relationship bet=
ween r0 and
> > > > > r1, it's quite cryptic to me). Or maybe it should be reg_0_1?
> > > >=20
> > > > Clocks are defined by two 32-bit registers. We only store the first
> > > > register offset because they always follow each other.
> > >
> > > > I like the reg64 name and will remove the comment. This straight fo=
rward
> > > > code is found in the rest of the code, I don't think it is anything
> > > > hard to understand (ie does not need a comment):
> > > >=20
> > > > 	u32 r0 =3D readl(base_plls + pll->reg);
> > > > 	u32 r1 =3D readl(base_plls + pll->reg + sizeof(r0));
> > >
> > > Btw, why readq()/writeq() (with probably the inclusion of io-64-nonat=
omic-lo-hi.h)
> > > can be used in this case? It will be much better overall and be align=
ed with
> > > reg64 name.
> >=20
> > The doc talks in terms of 32-bit registers. I do not see a reason to
> > work in 64-bit. If we get a 64-bit value that we need to split we need
> > to think about the endianness of our platform, which makes things more
> > complex than just reading both values independently.
>
> 1) Would be nice to test on the real HW to confirm it doesn't accept 64-b=
it IO.

Just tested, it works. No error on the memory bus. And checked assembly
generated was a single 64-bit instructions.

It might not work on other hardware revisions though. I can't remember
if memory bus is changing across them.

> 2) Still I see a benefit from using lo_hi_readq() and friends directly.

So it is:

	u32 r0 =3D readl(base_plls + pll->reg64);
	u32 r1 =3D readl(base_plls + pll->reg64 + sizeof(r0));

vs:

	u64 r =3D lo_hi_readq(base_plls + pll->regs64);
	u32 r0 =3D r;
	u32 r1 =3D r >> 32;

One is straight forward, the other uses an obscure helper that code
readers must understand and follows that with bit manipulation.

>
> [...]
>
> > > > > I didn't get. If eq5c_init() was finished successfully, why do yo=
u need to
> > > > > seems repeat what it already done? What did I miss?
> > > >=20
> > > > The key here is that eq5c_init() iterates on eq5c_early_plls[] whil=
e
> > > > eq5c_probe() iterates on eq5c_plls[]. I've tried to hint at this in=
 the
> > > > commit message:
> > > >=20
> > > > > Two PLLs are required early on and are therefore registered at
> > > > > of_clk_init(). Those are pll-cpu for the GIC timer and pll-per fo=
r the
> > > > > UARTs.
> > > >=20
> > > > Doing everything in eq5c_init() is not clean because we expect all =
new
> > > > clock provider drivers to be standard platform drivers. Doing
> > > > everything from a platform driver probe doesn't work because some
> > > > clocks are required earlier than platform bus init. We therefore do=
 a
> > > > mix.
> > >
> > > Am I missing something or these two pieces are using the same IO reso=
urces?
> > > This looks like a lot of code duplication without clear benefit. Perh=
aps
> > > you can have a helper?
> >=20
> > There are two subtle differences that make creating a helper difficult:
> >=20
> >  - Logging, pr_*() vs dev_*(). Second option is preferred but only
> >    available once a device is created.
>
> Some code uses (yeah, arguable that it's better, but depends on how much
> the real deduplication takes)
>
> 	if (dev)
> 		dev_*(...);
> 	else
> 		pr_*(...);
>
> >  - Behavior on error: we stop the world for early clocks but keep going
> >    for normal clocks.
>
> ...(..., bool skip_errors)
> {
> 	...
> }
>
> (with the same caveat)?

I started trying it out, but the combination of both flags means dealing
with errors would look like:

	ret =3D foo();
	if (ret) {
		if (!skip_errors) {
			if (dev)
				dev_err(dev, "...");
			else
				pr_err("...");
			return ret;
		}
		if (dev)
			dev_warn(dev, "...");
		else
			pr_warn("...");
	}

There are two errors to handle, that makes a mess out of the code.
Having a little bit of repetition but straight forward code is nicer in
my opinion. At least we tried!

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


