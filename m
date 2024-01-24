Return-Path: <linux-kernel+bounces-37359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D66F083AEBF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B0A1F24F01
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834E27E768;
	Wed, 24 Jan 2024 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FFci4IkW"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1A47E563;
	Wed, 24 Jan 2024 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115138; cv=none; b=okWI32p4hTmHrqas0Z5C5gPFyrQNMtFQTS6wWn8ESI1GEu7kD+B8Yfb6ZENpMQeopLaQuke0nrhPhsnJLwjWY3KfTUrJ3EXlhkiUiibbXODymCw4dUwYEeWMxSI9NoHh1IKGgOITtRWSyjJddwqF2TU2+lx+MmRnCJhI8UHN/As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115138; c=relaxed/simple;
	bh=xBjanQxj+WlA2NEtJC2FADqKcRyEwqeWXOxBQB5ubLg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=OS0B8MjIPBDDvU9OG9Adaz4oLT2S/cxr9vkC24kFOBAe/6B+vrwF//Vh5FSFBG27sMIeg4SzJAqUC7RCpaFugqFTlzlLaK7AM+pctI5NhzxYA/3SqKJ0jHbc3BYB3tpjShihrElh1rNYsqsQJSXI5qj8tpDgyCJPQXl60D/gyL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FFci4IkW; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3CBCD20009;
	Wed, 24 Jan 2024 16:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706115134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DKEfFNRNSTBwprTYctFaKjH1lgQHFqsNz6V6pYZfuuQ=;
	b=FFci4IkWY6kMPJKkanGCfgkRbyjlHw6Ms54sdmtakBcCG17BCzfL6K9bhUZ9ddZk8SDB7J
	ETzXhgijv9qe9m2IVC8afgT5ZVktK1DKmK7ieALpFyHql+CC/SoZUASqIkNtfbvSakC94K
	U5YFRJ66QTyHv9I4yFYJQAG3MI2myW/0jrRK86FuY8nk6Qf7j608KkpsEb+it4RKjbquzM
	Nv5te6kEqk3nSGPAhaFMbPnjacrsevOX/ameNS9TM7crB9FlemWxuXV7xuoBS99EfPx6aH
	oTasBy7AkWiCKAi5As4318ukIYkTgNCKczXQxsSSMSYO5HcBEsjJavIcztuPjQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jan 2024 17:52:13 +0100
Message-Id: <CYN3C7XGTG1T.2U3RS9E2ENWGJ@bootlin.com>
Cc: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
 <linux-mips@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, <linux-gpio@vger.kernel.org>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Gregory
 CLEMENT" <gregory.clement@bootlin.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, "Linus Walleij"
 <linus.walleij@linaro.org>, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?=
 <rafal@milecki.pl>, "Philipp Zabel" <p.zabel@pengutronix.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v3 09/17] reset: eyeq5: add platform driver
X-Mailer: aerc 0.15.2
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
 <20240123-mbly-clk-v3-9-392b010b8281@bootlin.com>
 <b9b8aa19-aa08-42ff-8b2f-dedb1e64700c@linaro.org>
In-Reply-To: <b9b8aa19-aa08-42ff-8b2f-dedb1e64700c@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Wed Jan 24, 2024 at 8:00 AM CET, Krzysztof Kozlowski wrote:
> On 23/01/2024 19:46, Th=C3=A9o Lebrun wrote:
> > Add the Mobileye EyeQ5 reset controller driver. It belongs to a syscon
> > region called OLB. It might grow to add later support of other
> > platforms from Mobileye.

[...]

> > +static int _eq5r_busy_wait(struct eq5r_private *priv, struct device *d=
ev,
> > +			   u32 domain, u32 offset, bool assert)
> > +{
> > +	unsigned int val, mask;
> > +	int i;
> > +
> > +	lockdep_assert_held(&priv->mutexes[domain]);
> > +
> > +	switch (domain) {
> > +	case 0:
> > +		for (i =3D 0; i < D0_TIMEOUT_POLL; i++) {
> > +			regmap_read(priv->olb, EQ5R_OLB_SARCR1, &val);
> > +			val =3D !(val & BIT(offset));
> > +			if (val =3D=3D assert)
> > +				return 0;
> > +			__udelay(1);
>
> What is even "__udelay"? It is the first use in drivers. Please use
> common methods, like fsleep or udelay... but actually you should rather
> use regmap_read_poll_timeout() or some variants instead of open-coding it=
.

udelay is an alias to __udelay on MIPS, which is why this didn't look
odd to me. Fixed.

[...]

> > +static void _eq5r_assert(struct eq5r_private *priv, u32 domain, u32 of=
fset)
>
> Drop leading _ and name the function in some informative way.

Fixed by turning `_eq5r_assert` into `eq5r_assert_withlock`, and co.

[...]

> > +
> > +static int eq5r_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct device_node *np =3D dev->of_node;
> > +	struct device_node *parent_np =3D of_get_parent(np);
> > +	struct eq5r_private *priv;
> > +	int ret, i;
> > +
> > +	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
>
> You leak parent.

Fixed in all three clk+reset+pinctrl drivers. They all had this issue.

>
> > +
> > +	dev_set_drvdata(dev, priv);
> > +
> > +	priv->olb =3D ERR_PTR(-ENODEV);
> > +	if (parent_np) {
> > +		priv->olb =3D syscon_node_to_regmap(parent_np);
> > +		of_node_put(parent_np);
> > +	}
> > +	if (IS_ERR(priv->olb))
>
> Also here
>
> > +		return PTR_ERR(priv->olb);
>
> This looks over-complicated. First, you cannot just
> dev_get_regmap(pdev->dev.parent)?

No dev_get_regmap() cannot be used as it doesn't pick up syscon regmaps.
I've just tried it.

However I've simplified the logic, it looks better now.

	static int eq5r_probe(struct platform_device *pdev)
	{
		struct device_node *parent_np;

		/* ... */

		parent_np =3D of_get_parent(np);
		if (!parent_np)
			return -ENODEV;

		priv->olb =3D syscon_node_to_regmap(parent_np);
		of_node_put(parent_np);
		if (IS_ERR(priv->olb))
			return PTR_ERR(priv->olb);

		/* ... */
	}

[...]

> > +static struct platform_driver eq5r_driver =3D {
> > +	.probe =3D eq5r_probe,
> > +	.driver =3D {
> > +		.name =3D "eyeq5-reset",
> > +		.of_match_table =3D eq5r_match_table,
> > +	},
> > +};
> > +
> > +static int __init eq5r_init(void)
> > +{
> > +	return platform_driver_register(&eq5r_driver);
> > +}
> > +
> > +arch_initcall(eq5r_init);
>
> This is does not look like arch code, but driver or subsys. Use regular
> module_driver. I see there is such pattern in reset but I doubt this is
> something good.

Indeed I've moved things to using the builtin_platform_driver() macro.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

