Return-Path: <linux-kernel+bounces-86840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DAB86CB83
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31121C21582
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CEB1361C2;
	Thu, 29 Feb 2024 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o+A9e/Np"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5572A1361B5;
	Thu, 29 Feb 2024 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216827; cv=none; b=NckAFNnAIqxx2Kw9TwXxg4MzTpFAKsFumkE0SRY0kU00Q12Tq0euQcIQdUs7Ww6BOm42jgHYbA1eeDHIyqfhB0o+3k8n5qcWJqzZDQKhiDQD2byK+zVhStJ61ytoCHPpLd84fnXdTyPLn3K/Ql4LoZ0ecYQpsMV9+wOSC0l6OmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216827; c=relaxed/simple;
	bh=sNvC0eOCgXlJieYs9eVk854YNI9DoGHKHOnTmERF/cQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=Dh7YRh/+YoAT6yZenrurkPYd4Fz0D2IrXhv6W+SWN/xI4RrxAGUpiecpsADUxQLJtq7fcnYl2f281IxhP86FHWVnknPjtKITqwT8OEZ/HibvBrRyspwLmer686MlxL69wieyfZQdokde8X1jVQbmUOwBPymFGfJu8N2mkj2B6Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o+A9e/Np; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BEC2040003;
	Thu, 29 Feb 2024 14:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709216822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2XC8WVbFw8gyrsduV0a8Mx8kJRDW3cgBWOx4bpt+o3I=;
	b=o+A9e/NpQa8U2GS1i1QZ1RNp86ogtneZMMENFbJQE34yHohdcbMzRX5MdkLejch7msmONu
	ckWC8Ux8AQ+M/VmP6+BP8pzZ4bEjfnhpicWmpJ4Zo1yhDU6eWaBvYlJP3yECa/oBTP4a+w
	3ci/BYCbBJgO6319C90XQzpx48LNJYibDbYa6aK0nZchfj+0oBFU6eq9Ug1bih7n15ADUU
	zZxKVM76dnEie16weoCcE9saF/RMgjSBmq0maKhBXzVHPYEPka4aJOyLTB6+Qr1EsZpBp+
	CK6/hLtQcx2YNyp0rst6pavL9VU3YIFSwk134HTS42+2pieZzft1adjF28+e1Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Feb 2024 15:27:01 +0100
Message-Id: <CZHMSNWMH4KJ.2J6ZMWKMSZYH2@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v8 03/10] clk: eyeq5: add platform driver, and init
 routine at of_clk_init()
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
X-Mailer: aerc 0.15.2
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
 <20240227-mbly-clk-v8-3-c57fbda7664a@bootlin.com>
 <Zd4X3NnBoEl0wu2H@smile.fi.intel.com>
 <CZGSB2O8P572.28HK6WFT43N6S@bootlin.com>
 <ZeBnX2upNRN0xXH4@smile.fi.intel.com>
In-Reply-To: <ZeBnX2upNRN0xXH4@smile.fi.intel.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Wed, Feb 28, 2024 at 03:33:29PM +0100, Th=C3=A9o Lebrun wrote:
> On Tue Feb 27, 2024 at 6:11 PM CET, Andy Shevchenko wrote:
> > On Tue, Feb 27, 2024 at 03:55:24PM +0100, Th=C3=A9o Lebrun wrote:

[...]

> > > > +	u32		reg;	/* next 8 bytes are r0 and r1 */
> > >
> > > Not sure this comments gives any clarification to a mere reader of th=
e code.
> > > Perhaps you want to name this as reg64 (at least it will show that yo=
u have
> > > 8 bytes, but I have no clue what is the semantic relationship between=
 r0 and
> > > r1, it's quite cryptic to me). Or maybe it should be reg_0_1?
> >=20
> > Clocks are defined by two 32-bit registers. We only store the first
> > register offset because they always follow each other.
>
> > I like the reg64 name and will remove the comment. This straight forwar=
d
> > code is found in the rest of the code, I don't think it is anything
> > hard to understand (ie does not need a comment):
> >=20
> > 	u32 r0 =3D readl(base_plls + pll->reg);
> > 	u32 r1 =3D readl(base_plls + pll->reg + sizeof(r0));
>
> Btw, why readq()/writeq() (with probably the inclusion of io-64-nonatomic=
-lo-hi.h)
> can be used in this case? It will be much better overall and be aligned w=
ith
> reg64 name.

The doc talks in terms of 32-bit registers. I do not see a reason to
work in 64-bit. If we get a 64-bit value that we need to split we need
to think about the endianness of our platform, which makes things more
complex than just reading both values independently.

> [...]
>
> > > I didn't get. If eq5c_init() was finished successfully, why do you ne=
ed to
> > > seems repeat what it already done? What did I miss?
> >=20
> > The key here is that eq5c_init() iterates on eq5c_early_plls[] while
> > eq5c_probe() iterates on eq5c_plls[]. I've tried to hint at this in the
> > commit message:
> >=20
> > > Two PLLs are required early on and are therefore registered at
> > > of_clk_init(). Those are pll-cpu for the GIC timer and pll-per for th=
e
> > > UARTs.
> >=20
> > Doing everything in eq5c_init() is not clean because we expect all new
> > clock provider drivers to be standard platform drivers. Doing
> > everything from a platform driver probe doesn't work because some
> > clocks are required earlier than platform bus init. We therefore do a
> > mix.
>
> Am I missing something or these two pieces are using the same IO resource=
s?
> This looks like a lot of code duplication without clear benefit. Perhaps
> you can have a helper?

There are two subtle differences that make creating a helper difficult:

 - Logging, pr_*() vs dev_*(). Second option is preferred but only
   available once a device is created.

 - Behavior on error: we stop the world for early clocks but keep going
   for normal clocks.

[...]

> > > > +		eq5c_clk_data->hws[pll->index] =3D hw;
> > > > +		if (IS_ERR(hw))
> > >
> > > > +			dev_err_probe(dev, PTR_ERR(hw), "failed registering %s\n",
> > > > +				      pll->name);
> > >
> > > Missed return statement?
> >=20
> > No, we still try to register all clocks even if one failed. I guess we
> > can call this being optimistic.
>
> But how critical these clocks are? I believe we should panic it we have n=
o
> critical calls be available. Otherwise, why '_err_'? Shouldn't be dev_war=
n()?

Indeed printing should be dev_warn(), I missed that.

Thanks Andy,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


