Return-Path: <linux-kernel+bounces-37363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA3283AECF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7191E1C23399
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F727E591;
	Wed, 24 Jan 2024 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hSIIgUbs"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95957C091;
	Wed, 24 Jan 2024 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115348; cv=none; b=Mb8gvMW6eNT5XJ2WHLL8srwxtq/NBHkelzaZP2e2HA+SqAxDia529Yr+PAPB6r/ZJoXTajdEsmHnRQxvk5ZmKviurhm7hvEfafrv2x5Uww7vXL6+iQmxgfgEU3KXsbU/tFqkg6BTyPT+bd2/YVkvewMbyY7IkpX32wcoHzR04fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115348; c=relaxed/simple;
	bh=sdFTfFKW8h0DBCShL4Wg258lalzBpt8xcI9a2WlYGjQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=VyKpxvHE6i7hgkd+Rv72Nt1nBF8tQ6GPkg2XqX+JCB70mNNKnSJI/Qb48UK46/LDlWmmPJ1EmdbBKGWEolY1we2S+v2NYasGrLtxVknmITLTntl/ms5qHqoUXZMo6SAUZsOYwaMKyPRdMub28h0ImPuDCgMuz5u0b5UMMIWy3pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hSIIgUbs; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A6BBBFF802;
	Wed, 24 Jan 2024 16:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706115343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6orTMhqnjIBCLiMK6R3AGy6f2k6WP4HmdhdKcEwlqFY=;
	b=hSIIgUbs5S7sJrCPc8xS7eH4YoDi50qZY5nJYyJZDWWJcGX1JMOIqT2T3vJwt4TPsx88/b
	GqlnpU+DydfKfoyRTedUO4fdOp5gEaLxeJrUaCNBeMe8ZM00aE6dO1Z21mBNLRp3knexg1
	ETm8rgRTrZCAgFtgh5yAbCD6u9fy/r9KgB9pK5LIzr8UwLCWZXJ5mrCqGPNgxobgzCSUnb
	r8dE3EUwdjhU7UIXZm/MBZE/HpseB+y3bQdcFcBBmrQ/q+rnJPIY+wN7b9fO+QlbJk/zSn
	Oy3h84uDHK4/PgAFBzDd8az5FPL2Irx27N+BWayeL0vN8c8l4tyzcdZH+hE16g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jan 2024 17:55:42 +0100
Message-Id: <CYN3EW3ROWDF.2EXS5GSV1K8PH@bootlin.com>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Gregory
 CLEMENT" <gregory.clement@bootlin.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, "Linus Walleij"
 <linus.walleij@linaro.org>, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?=
 <rafal@milecki.pl>, "Philipp Zabel" <p.zabel@pengutronix.de>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v3 10/17] pinctrl: eyeq5: add platform driver
Cc: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
 <linux-mips@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, <linux-gpio@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
 <20240123-mbly-clk-v3-10-392b010b8281@bootlin.com>
 <5e06d14a-baa7-4e18-a731-6621e623565f@linaro.org>
In-Reply-To: <5e06d14a-baa7-4e18-a731-6621e623565f@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Wed Jan 24, 2024 at 8:03 AM CET, Krzysztof Kozlowski wrote:
> On 23/01/2024 19:46, Th=C3=A9o Lebrun wrote:
> > Add the Mobileye EyeQ5 pin controller driver. It might grow to add late=
r
> > support of other platforms from Mobileye. It belongs to a syscon region
> > called OLB.
> >=20
> > Existing pins and their function live statically in the driver code
> > rather than in the devicetree, see compatible match data.
> >=20
>
> ...
>
> > +static int eq5p_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct device_node *np =3D dev->of_node;
> > +	struct device_node *parent_np =3D of_get_parent(np);
> > +	const struct eq5p_match *match =3D of_device_get_match_data(dev);
> > +	struct pinctrl_dev *pctldev;
> > +	struct eq5p_pinctrl *pctrl;
> > +	int ret;
> > +
> > +	pctrl =3D devm_kzalloc(dev, sizeof(*pctrl), GFP_KERNEL);
> > +	if (!pctrl)
> > +		return -ENOMEM;
> > +
> > +	pctrl->olb =3D ERR_PTR(-ENODEV);
> > +	if (parent_np)
> > +		pctrl->olb =3D syscon_node_to_regmap(parent_np);
> > +	if (IS_ERR(pctrl->olb))
> > +		pctrl->olb =3D syscon_regmap_lookup_by_phandle(np, "mobileye,olb");
> > +	if (IS_ERR(pctrl->olb))
> > +		return PTR_ERR(pctrl->olb);
>
> No, we talked about this, you got comments on this. There is no
> mobileye,olb. You cannot have undocumented properties.

Clearly and I fully agree. It's a versioning issue on my side. It's
been fixed (again, oops).

>
> > +
> > +	pctrl->regs =3D match->regs;
> > +	pctrl->funcs =3D match->funcs;
> > +	pctrl->nfuncs =3D match->nfuncs;
> > +
> > +	pctrl->desc.name =3D dev_name(dev);
> > +	pctrl->desc.pins =3D match->pins;
> > +	pctrl->desc.npins =3D match->npins;
> > +	pctrl->desc.pctlops =3D &eq5p_pinctrl_ops;
> > +	pctrl->desc.pmxops =3D &eq5p_pinmux_ops;
> > +	pctrl->desc.confops =3D &eq5p_pinconf_ops;
> > +	pctrl->desc.owner =3D THIS_MODULE;
> > +
> > +	ret =3D devm_pinctrl_register_and_init(dev, &pctrl->desc, pctrl, &pct=
ldev);
> > +	if (ret) {
> > +		dev_err(dev, "Failed registering pinctrl device: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D pinctrl_enable(pctldev);
> > +	if (ret) {
> > +		dev_err(dev, "Failed enabling pinctrl device: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	dev_info(dev, "probed\n");
>
> I am pretty sure you got comments for these. Drop such debugs from all
> of your code. Current and future.

Same thing, it must have been lost in the same fixup patch as the
previous mistake.

[...]

> > +static struct platform_driver eq5p_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "eyeq5-pinctrl",
> > +		.of_match_table =3D eq5p_match,
> > +	},
> > +	.probe =3D eq5p_probe,
> > +};
> > +
> > +static int __init eq5p_init(void)
> > +{
> > +	return platform_driver_register(&eq5p_driver);
> > +}
> > +core_initcall(eq5p_init);
>
> No, pins are not a core_initcall. This could be arch_initcall, but
> considering you depend on the parent this must be module driver.
>
> Even from this dependency point of view your initcalls are totally wrong
> and will lead to issues.

Same as reset: moved to using the builtin_platform_driver() macro. No
need for it to be module as it cannot be one.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

