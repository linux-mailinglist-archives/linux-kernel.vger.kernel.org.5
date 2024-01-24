Return-Path: <linux-kernel+bounces-37398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B7083AF46
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D40DB2AABF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251588614F;
	Wed, 24 Jan 2024 17:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AcIO+K5R"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534138613F;
	Wed, 24 Jan 2024 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116042; cv=none; b=dEj7gEjCQoTgEqnJRaQ0cc8KXwTSmcG8lt5ZeT0QbLBMONZrlRFmoYDOQ/aj5B8nmav7wad8SEOdjd/RocVEnnBPCTjhwX31JNTI1xCl91e+nTKUcQ0MI/n/xh2KxkTll3+an12Y9jEiYHyecvnOfXZ3q8kWhSA31cszuqksF9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116042; c=relaxed/simple;
	bh=c8yF4wyc2/rkn0lYHNP83rjuVaVQ/RH3Twbk6RXnVCo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=mXIPSziVrPDxhGbrzXE8tUss0YtghO6SEsIQ3d29RsXVGzZ1vy+nzCDPBCbbplDi6gdw4vfn4F0qX+ONIgB8DeHQr0/ciyuDfBJut/9kO8/BYxVQSkkL87rAw4sdKNR8W0Cr2NhKUy/WBXLcrGyyjyblpccUEdPpUJ5pylYd9U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AcIO+K5R; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7D04EE0003;
	Wed, 24 Jan 2024 17:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706116037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tx3tMpR9wEzeVD9kc/vqww4Pc1leNPZvKNnalpl6wCU=;
	b=AcIO+K5RtjHU1dItj/+utbjuyqr7he0h1WETXg4cuCf7aj3PH8Jy3DZiieBf+q8GdGB4aQ
	EqKviHewZ9z9vD2VT2ZhO+gFSbxbeHhio6twmU3g+ZIHeBSui/H5E5d/cFZBg6KF4aqeJt
	cxx8dKVYQx3gsZqDAoZxT5XeZk5voUKoupXlrdbZFw32Mc5LhXsBHxxdBWPpamlKb3I0GD
	zwDtyeuT3SDZuSKUPP3WLg/xbeq8gRX/HKWnrisWi8rLdsxEwF0WRC2MpBtHCMbhVw5zVa
	IIni7vK6zdzcFY+HSvXSTXTyWeCmXJYLWIe9q/FjJYRqDCgtXDzii+Me9ikp9Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jan 2024 18:07:16 +0100
Message-Id: <CYN3NQUTY1IG.165R86NIAZ46I@bootlin.com>
Subject: Re: [PATCH v3 09/17] reset: eyeq5: add platform driver
Cc: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>,
 <linux-mips@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, <linux-gpio@vger.kernel.org>
To: "Philipp Zabel" <p.zabel@pengutronix.de>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring"
 <robh+dt@kernel.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, "Linus Walleij"
 <linus.walleij@linaro.org>, =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?=
 <rafal@milecki.pl>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
 <20240123-mbly-clk-v3-9-392b010b8281@bootlin.com>
 <82bde47d48ec2962d69d9e4edde6d6d96fcbbd65.camel@pengutronix.de>
In-Reply-To: <82bde47d48ec2962d69d9e4edde6d6d96fcbbd65.camel@pengutronix.de>
X-GND-Sasl: theo.lebrun@bootlin.com

Hi,

On Wed Jan 24, 2024 at 11:54 AM CET, Philipp Zabel wrote:
> On Di, 2024-01-23 at 19:46 +0100, Th=C3=A9o Lebrun wrote:
> [...]
> > diff --git a/drivers/reset/reset-eyeq5.c b/drivers/reset/reset-eyeq5.c
> > new file mode 100644
> > index 000000000000..2217e42e140b
> > --- /dev/null
> > +++ b/drivers/reset/reset-eyeq5.c
> > @@ -0,0 +1,383 @@
> [...]
>
> > +static int eq5r_assert(struct reset_controller_dev *rcdev, unsigned lo=
ng id)
> > +{
> > +	struct eq5r_private *priv =3D dev_get_drvdata(rcdev->dev);
>
> rcdev is contained in priv, you can just use container_of instead of
> chasing pointers around.

That's right. Fixed with this local macro:

#define rcdev_to_priv(rcdev) container_of(rcdev, struct eq5r_private, rcdev=
)

> > +	u32 offset =3D id & GENMASK(7, 0);
> > +	u32 domain =3D id >> 8;
> > +	int ret;
> > +
> > +	if (WARN_ON(domain >=3D EQ5R_DOMAIN_COUNT))
> > +		return -EINVAL;
>
> Reset controls with domain >=3D EQ5R_DOMAIN_COUNT are already weeded out
> during request by of_xlate, so this check is not necessary.

It was some defensive programming. I've removed this precautionary
condition from the places it appeared.

>
> > +	dev_dbg(rcdev->dev, "%u-%u: assert request\n", domain, offset);
> > +
> > +	mutex_lock(&priv->mutexes[domain]);
> > +	_eq5r_assert(priv, domain, offset);
> > +	ret =3D _eq5r_busy_wait(priv, rcdev->dev, domain, offset, true);
> > +	mutex_unlock(&priv->mutexes[domain]);
> > +
> > +	return ret;
>
> Consider using guard(mutex)(&priv->mutexes[domain]) from
> linux/cleanup.h to automatically unlock on return.

Done. I had never used that __cleanup attr feature. It simplifies
returns.

>
> [...]
> > +static int eq5r_reset(struct reset_controller_dev *rcdev, unsigned lon=
g id)
>
> Is this used by anything? If unused, I'd prefer this not to be
> implemented. If it is used, is no delay required between assert and
> deassert by any consumer?

Not really, it follows what is done in the downstream vendor kernel.
I've had a quick look in this kernel and I don't see any consumer of
the API. For the moment I'll remove it.

>
> > +{
> > +	struct device *dev =3D rcdev->dev;
> > +	struct eq5r_private *priv =3D dev_get_drvdata(dev);
> > +	u32 offset =3D id & GENMASK(7, 0);
> > +	u32 domain =3D id >> 8;
> > +	int ret;
> > +
> > +	if (WARN_ON(domain >=3D EQ5R_DOMAIN_COUNT))
> > +		return -EINVAL;
> > +
> > +	dev_dbg(dev, "%u-%u: reset request\n", domain, offset);
> > +
> > +	mutex_lock(&priv->mutexes[domain]);
> > +
> > +	_eq5r_assert(priv, domain, offset);
> > +	ret =3D _eq5r_busy_wait(priv, dev, domain, offset, true);
> > +	if (ret) /* don't let an error disappear silently */
> > +		dev_warn(dev, "%u-%u: reset assert failed: %d\n",
> > +			 domain, offset, ret);
>
> Why not return the error though?

The goal was to still run through the deassert even if the assert
returned an error. Goal was to address potential edge case of assert
returning an error but still taking place, in which case we want to try
to deassert to put the peripheral in a de-asserted state (as before the
call).

Not a concern anymore as the function is being removed.

>
> > +	_eq5r_deassert(priv, domain, offset);
> > +	ret =3D _eq5r_busy_wait(priv, dev, domain, offset, false);
> > +
> > +	mutex_unlock(&priv->mutexes[domain]);
> > +
> > +	return ret;
> > +}
> [...]
> > +static int eq5r_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct device_node *np =3D dev->of_node;
> > +	struct device_node *parent_np =3D of_get_parent(np);
> > +	struct eq5r_private *priv;
> > +	int ret, i;
> > +
> > +	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
>
> Using devm_kzalloc() avoids leaking this on error return or driver
> unbind.

Done, thanks.

>
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	dev_set_drvdata(dev, priv);
> > +
> > +	priv->olb =3D ERR_PTR(-ENODEV);
> > +	if (parent_np) {
> > +		priv->olb =3D syscon_node_to_regmap(parent_np);
> > +		of_node_put(parent_np);
> > +	}
> > +	if (IS_ERR(priv->olb))
> > +		return PTR_ERR(priv->olb);
> > +
> > +	for (i =3D 0; i < EQ5R_DOMAIN_COUNT; i++)
> > +		mutex_init(&priv->mutexes[i]);
> > +
> > +	priv->rcdev.ops =3D &eq5r_ops;
> > +	priv->rcdev.owner =3D THIS_MODULE;
> > +	priv->rcdev.dev =3D dev;
> > +	priv->rcdev.of_node =3D np;
> > +	priv->rcdev.of_reset_n_cells =3D 2;
> > +	priv->rcdev.of_xlate =3D eq5r_of_xlate;
> > +
> > +	priv->rcdev.nr_resets =3D 0;
> > +	for (i =3D 0; i < EQ5R_DOMAIN_COUNT; i++)
> > +		priv->rcdev.nr_resets +=3D __builtin_popcount(eq5r_valid_masks[i]);
> > +
> > +	ret =3D reset_controller_register(&priv->rcdev);
>
> Similarly, use devm_reset_controller_register() or disable driver
> unbind with suppress_bind_attrs.

Switched to the devres version, thanks.


Thanks Philipp,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

