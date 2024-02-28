Return-Path: <linux-kernel+bounces-85188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B6A86B1E1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA161C21EA5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2724415A48C;
	Wed, 28 Feb 2024 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YW6uOGSU"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1036541C73;
	Wed, 28 Feb 2024 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130816; cv=none; b=j9v+zo4oHId3M1KdrF6A387NvFxQ1+xMTD7Zin8SnqkfkJswAQnH9H05+P8CjXx4Z11wHwOrNFGE5dqpaTzQBXaVPFEOxVh8TdkCztiTEvJqakwDCKHdBSvn2KTtHOyzs2F0D7INihyvPdi57fbCeRl6lhGJzQwZ9uPyYWwLxsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130816; c=relaxed/simple;
	bh=3n4fi759qVcMVZIBXanIzcd3LPAMSrE+rjz7bDx5usk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=I3qWieCpm6IjB8C9G/GQGA19GrT2vUYkwQJXS8/pvZ3JlP9jlhltbcym27gxrNE3Y3D97WxE5Zh8YtLY+1/u/yeQBGCTRxDxmlNbwLN5bIuILVEg5yzUkbk66phAUlmpxe3vF34nn4zUMM5EzNGJeXgwlwCsukuSvYMwXL3cwKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YW6uOGSU; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2EEAE20008;
	Wed, 28 Feb 2024 14:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709130811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CAx8vqRjJzrfEqvGHv264mRlGamSXmd2OpD0S+iTVkA=;
	b=YW6uOGSUJ/WMHYroEPBz/BnDwja0vw0CKSiiObivJWrrLOO4qTL6STPcmui1zL1Muk3AaR
	mghUhvhyD08WZd1SL/Sz/MrRvqEU4F5He2a/TfcOJKon72lflOkC0P8XJujzGlgDqS4yaC
	AtrSRUXeoXjhc5JjH740Xc5DjkBrLMFinWAeOhMFWismJnLX1bkiW8TAFWaOXYh5s4eOS5
	JmFSlEso/7tsP3V6NI9BeBeIBEc61ACkTffdf1Zthz87sp+G9JBn3YM+svNDdSAdJv0Lnm
	gzDjhAfXEoeKFyGf2CBt4aHvaz67/4lDNth+ea5M5rxTZPRFqa12+LsfvTS9Tw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Feb 2024 15:33:29 +0100
Message-Id: <CZGSB2O8P572.28HK6WFT43N6S@bootlin.com>
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
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
 <20240227-mbly-clk-v8-3-c57fbda7664a@bootlin.com>
 <Zd4X3NnBoEl0wu2H@smile.fi.intel.com>
In-Reply-To: <Zd4X3NnBoEl0wu2H@smile.fi.intel.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Andy,

Thanks for the review! I'll be skipping straight forward comments.

On Tue Feb 27, 2024 at 6:11 PM CET, Andy Shevchenko wrote:
> On Tue, Feb 27, 2024 at 03:55:24PM +0100, Th=C3=A9o Lebrun wrote:
> > Add the Mobileye EyeQ5 clock controller driver. It might grow to add
> > support for other platforms from Mobileye.

[...]

> > +config COMMON_CLK_EYEQ5
> > +	bool "Clock driver for the Mobileye EyeQ5 platform"
>
> > +	depends on OF
>
> Since it's a functional dependency, why not allow compile test without OF=
 being
> enabled?

I'd do this then:

	depends on OF || COMPILE_TEST

Which is better than removing the depend line. I wouldn't want the
kernel to build fine with OF=3Dn even though we need it. OK for you?

>
> > +	depends on MACH_EYEQ5 || COMPILE_TEST
> > +	default MACH_EYEQ5
> > +	help
> > +	  This driver provides the clocks found on the Mobileye EyeQ5 SoC. It=
s
> > +	  registers live in a shared register region called OLB. It provides =
10
> > +	  read-only PLLs derived from the main crystal clock which must be co=
nstant
> > +	  and one divider clock based on one PLL.

[...]

> > +struct eq5c_pll {
> > +	int		index;
>
> Index can be negative? Any comment about this case?

No it cannot. I did not care much because structs of this type are only
defined in the following static const table, using constants from
dt-bindings header.

I'll change to unsigned int.

>
> > +	const char	*name;
> > +	u32		reg;	/* next 8 bytes are r0 and r1 */
>
> Not sure this comments gives any clarification to a mere reader of the co=
de.
> Perhaps you want to name this as reg64 (at least it will show that you ha=
ve
> 8 bytes, but I have no clue what is the semantic relationship between r0 =
and
> r1, it's quite cryptic to me). Or maybe it should be reg_0_1?

Clocks are defined by two 32-bit registers. We only store the first
register offset because they always follow each other.

I like the reg64 name and will remove the comment. This straight forward
code is found in the rest of the code, I don't think it is anything
hard to understand (ie does not need a comment):

	u32 r0 =3D readl(base_plls + pll->reg);
	u32 r1 =3D readl(base_plls + pll->reg + sizeof(r0));

[...]

> > +		return -EINVAL;
>
> I didn't get. If eq5c_init() was finished successfully, why do you need t=
o
> seems repeat what it already done? What did I miss?

The key here is that eq5c_init() iterates on eq5c_early_plls[] while
eq5c_probe() iterates on eq5c_plls[]. I've tried to hint at this in the
commit message:

> Two PLLs are required early on and are therefore registered at
> of_clk_init(). Those are pll-cpu for the GIC timer and pll-per for the
> UARTs.

Doing everything in eq5c_init() is not clean because we expect all new
clock provider drivers to be standard platform drivers. Doing
everything from a platform driver probe doesn't work because some
clocks are required earlier than platform bus init. We therefore do a
mix.

This has been approved by Stephen Boyd in this email:
https://lore.kernel.org/lkml/fa32e6fae168e10d42051b89197855e9.sboyd@kernel.=
org/

[...]

> > +	base_plls =3D devm_platform_ioremap_resource_byname(pdev, "plls");
> > +	if (IS_ERR(base_plls))
> > +		return PTR_ERR(base_plls);
> > +
> > +	base_ospi =3D devm_platform_ioremap_resource_byname(pdev, "ospi");
> > +	if (IS_ERR(base_ospi))
> > +		return PTR_ERR(base_ospi);
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(eq5c_plls); i++) {
> > +		const struct eq5c_pll *pll =3D &eq5c_plls[i];
> > +		unsigned long mult, div, acc;
> > +		u32 r0, r1;
> > +		int ret;
> > +
> > +		r0 =3D readl(base_plls + pll->reg);
> > +		r1 =3D readl(base_plls + pll->reg + sizeof(r0));
> > +
> > +		ret =3D eq5c_pll_parse_registers(r0, r1, &mult, &div, &acc);
> > +		if (ret) {
> > +			dev_warn(dev, "failed parsing state of %s\n", pll->name);
> > +			eq5c_clk_data->hws[pll->index] =3D ERR_PTR(ret);
> > +			continue;
> > +		}
> > +
> > +		hw =3D clk_hw_register_fixed_factor_with_accuracy_fwname(dev, np,
> > +				pll->name, "ref", 0, mult, div, acc);
> > +		eq5c_clk_data->hws[pll->index] =3D hw;
> > +		if (IS_ERR(hw))
>
> > +			dev_err_probe(dev, PTR_ERR(hw), "failed registering %s\n",
> > +				      pll->name);
>
> Missed return statement?

No, we still try to register all clocks even if one failed. I guess we
can call this being optimistic.

[...]

> > +static void __init eq5c_init(struct device_node *np)
> > +{
> > +	void __iomem *base_plls, *base_ospi;
> > +	int index_plls, index_ospi;
> > +	int i, ret;
>
> Why is i signed?

No reason, will be changed to unsigned int.

[...]

> > +		hw =3D clk_hw_register_fixed_factor_with_accuracy_fwname(NULL,
> > +				np, pll->name, "ref", 0, mult, div, acc);
> > +		eq5c_clk_data->hws[pll->index] =3D hw;
> > +		if (IS_ERR(hw))
> > +			pr_err("failed registering %s: %ld\n",
>
> %pe ?
>
> > +			       pll->name, PTR_ERR(hw));
>
> Is the error not critical? Is it fine? How is it supposed to work at such
> circumstances?

It is a critical error, the system will stop working in a few
milliseconds. :-) This is different from probe and it should indeed
return the error.

Thanks for the review Andy.

Have a nice day,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

