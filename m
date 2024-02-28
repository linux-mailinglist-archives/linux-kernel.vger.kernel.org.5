Return-Path: <linux-kernel+bounces-85408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1029686B582
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400031C243F9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B743FBA9;
	Wed, 28 Feb 2024 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iBfKunRp"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC503FB82;
	Wed, 28 Feb 2024 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709139899; cv=none; b=r766KZ5BvMw0Fw37YWGorgkMVQwmxV0v/QlmLlKJe+x90G0U4oy0az4QrjaujazVQo5TABshzR7g+5IRxV3N18rE19sLlimwkCeAADFC1jnRMfz79BS2BHCWIfGJSvCXcNUU6pIqyB/oFbBVzYSRkXSXBmauwa9Wy9F6BcwAJBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709139899; c=relaxed/simple;
	bh=44x5yDcOLSCbcSbnsWN3XwhRRPVfXIBZAjD6hjXZx+U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=UDhH1LQlk0yc+EX4FJ1WHmf3toxiWmR43m1kuec9Np3yEoIzcaHy3KM5Cymzjhg45WWDZPNKERi6h8l9jgidM7CsslWrHTuMv8GjBfIzGuQ7U88wdjH4oHAEQlsAczM/ahXxa70gCJCmPzOWkJAnql/n0mcAR9O2abFEIlgol08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iBfKunRp; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 89A0BC0008;
	Wed, 28 Feb 2024 17:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709139888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vCBAaabth7lAvvtJBPFWrOiPFUdycHNsNEJADPl3zuo=;
	b=iBfKunRpv70S9wYQ7RV+vXOCFrhSr/wioOineNSxRoS8gzIJ7dP9cBopMwVt8SikHz4pmx
	lnIvETzRCKqMbdO+bzwtUwjeaNz/cLX86KFW0GWzf/AXxKk0vNC3Y70ThSU7WnDc/JqhpK
	rCMvQ8bJ+rjxe0V1WdPbKDZtSdGubAc+cSD4P16wSf+x/AO4ZC89zCX4f02MYOuA0YPAbQ
	V3Lfw9vpxx4dV1bcNNd8MlwuwWnNnhrqJ8lbRKACwcD67WtzfyrFWVUextxAhObLvDjkn4
	RaDLe0Z2o4OdJs+zXK0fAjps8rOUWppPw8BfJds4sYHHGiZ2BeU99k6pMXiiuQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Feb 2024 18:04:47 +0100
Message-Id: <CZGVIWR4H4DE.3M5H3H99X0QPT@bootlin.com>
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
Subject: Re: [PATCH v8 04/10] reset: eyeq5: add platform driver
X-Mailer: aerc 0.15.2
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
 <20240227-mbly-clk-v8-4-c57fbda7664a@bootlin.com>
 <Zd4bbCsY54XEnvJM@smile.fi.intel.com>
In-Reply-To: <Zd4bbCsY54XEnvJM@smile.fi.intel.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

I won't be answering to straight forward comments.

On Tue Feb 27, 2024 at 6:27 PM CET, Andy Shevchenko wrote:
> On Tue, Feb 27, 2024 at 03:55:25PM +0100, Th=C3=A9o Lebrun wrote:
> > Add the Mobileye EyeQ5 reset controller driver. It belongs to a syscon
> > region called OLB. It might grow to add later support of other
> > platforms from Mobileye.
>
> ...
>
> The inclusion block is a semi-random. Please, follow IWYU principle.
>
> + array_size.h
> + bits.h
> + bug.h
> + container_of.h
>
> > +#include <linux/cleanup.h>
> > +#include <linux/delay.h>
>
> + device.h
> + err.h
> + io.h
> + lockdep.h
>
> + mod_devicetable.h
>
> > +#include <linux/mutex.h>
>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_device.h>
>
> Are all of them in use?
>
> > +#include <linux/platform_device.h>
> > +#include <linux/reset-controller.h>
>
> + types.h

I'm adding yours + errno.h + init.h (for THIS_MODULE) + slab.h (for GFP
flags). I'm removing unused of_address.h and of_device.h.

delay.h will be removed and iopoll.h will be added based on changes
following your comments.

[...]

> > +static int eq5r_deassert(struct reset_controller_dev *rcdev, unsigned =
long id)
> > +{
> > +	struct eq5r_private *priv =3D rcdev_to_priv(rcdev);
> > +	u32 offset =3D id & GENMASK(7, 0);
> > +	u32 domain =3D id >> 8;
>
> Perhaps
>
> 	u32 offset =3D (id & GENMASK(7, 0)) >> 0;
> 	u32 domain =3D (id & GENMASK(31, 8)) >> 8;
>
> for better understanding the split?

Do the additional zero-bit-shift and GENMASK() help understanding? My
brain needs time to parse them to then notice they do nothing and
simplify the code in my head, back to the original version.

I personally like the simplest version (the original one). But otherwise
FIELD_GET() with two globally-defined masks could be a solution as
well. I still prefer the original version better. Less symbols, less
complexity.

[...]

> > +	struct eq5r_private *priv;
> > +	int ret, i;
>
> Why is i signed?

No reason, will switch to unsigned int.

>
> > +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->base_d0 =3D devm_platform_ioremap_resource_byname(pdev, "d0");
> > +	if (IS_ERR(priv->base_d0))
> > +		return PTR_ERR(priv->base_d0);
> > +
> > +	priv->base_d1 =3D devm_platform_ioremap_resource_byname(pdev, "d1");
> > +	if (IS_ERR(priv->base_d1))
> > +		return PTR_ERR(priv->base_d1);
> > +
> > +	priv->base_d2 =3D devm_platform_ioremap_resource_byname(pdev, "d2");
> > +	if (IS_ERR(priv->base_d2))
> > +		return PTR_ERR(priv->base_d2);
> > +
> > +	for (i =3D 0; i < EQ5R_DOMAIN_COUNT; i++)
> > +		mutex_init(&priv->mutexes[i]);
> > +
> > +	priv->rcdev.ops =3D &eq5r_ops;
> > +	priv->rcdev.owner =3D THIS_MODULE;
> > +	priv->rcdev.dev =3D dev;
>
> > +	priv->rcdev.of_node =3D np;
>
> It's better to use device_set_node().

I don't see how device_set_node() can help? It works on struct device
pointers. Here priv->rcdev is a reset_controller_dev struct. There are
no users of device_set_node() in drivers/reset/.

>
> > +	priv->rcdev.of_reset_n_cells =3D 2;
> > +	priv->rcdev.of_xlate =3D eq5r_of_xlate;
> > +
> > +	priv->rcdev.nr_resets =3D 0;
> > +	for (i =3D 0; i < EQ5R_DOMAIN_COUNT; i++)
>
> > +		priv->rcdev.nr_resets +=3D __builtin_popcount(eq5r_valid_masks[i]);
>
> Please, use corresponding hweightXX() API.

Noted. I did not find this keyword even though I searched quite a bit
for it. "popcount" sounds more logical to me. :-)

Thanks for the review Andy!

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


