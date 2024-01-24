Return-Path: <linux-kernel+bounces-37344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5179D83AE8C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E5D1F255C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64BF7E58A;
	Wed, 24 Jan 2024 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lS8FFpRi"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E97B7E574;
	Wed, 24 Jan 2024 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114497; cv=none; b=Yc5QHySiFQIBkT2ybpg4EL0Q9B8PeYNmThF/iEXmm7WbC99fqg2T3LcP8uutLKQCW1BjTQMh7r6kHt3Zn7up8/Ua3s8FX8RrHYEqgniHrIe+Oqz+DlqU58mvRFCh6+XXy7nqepUzyPXXVmw1+Fyy6IGniMwpQbqAdfVXKkBIGhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114497; c=relaxed/simple;
	bh=anBY5LZpeci3/wwVJvSlL4EaTE/KIEe/eqaQRWD5f5c=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=DsY7J8eHVh9KKCLjeNf/oXuh5rRJ5x+Fgjhc/N7IwZRjem4nyraCLvLJ2hgTaZW0+xULLMeBNLWz52axo0hwda1wuAxf8Bvo0ibjlyUPYWYEy3JaOmzqZuc/6lC9KGtqZToCW+aDh8QqgVUURy4kt/J1U7sav4SNA/7Ccb5hZnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lS8FFpRi; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 053401BF207;
	Wed, 24 Jan 2024 16:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706114486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2sbgQDOdjhJguWPGsjuBJKz9cflIxIP+NbSXK5IhSsQ=;
	b=lS8FFpRiRKmzHycbzO96gb3T87gkVQPpEpapke6XAvErYEXv3tWmRzVyAPKxO+xfIp6IWn
	N+3nKmQ/NHgunx8Bs7GEDc6QdiKEu61yZ7t6+OWTai6Oxz5ACh231AorLWlxOSMmBzwd18
	4gMWqq9VV4yxP4TtPoEIxM9nZgN/FJuOe+Jg5CpGXID6qVm6sDmDVsHNIOenfhO33gpcOp
	PgeQhbLu/MvXHLhg3FJoe+t/X2da1tH/LeCpQdlIiIL9iuXQnkiejCRHiU1OG4m4+Lt+qH
	8ahkb/x/hnOtVc9sQvklPUVSwD1+yEGGDPrhxTcsqsOhe00g7LJVbpNfkNUhCA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Jan 2024 17:41:25 +0100
Message-Id: <CYN33YJ10HYS.2YDXB158LFZPL@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v3 08/17] clk: eyeq5: add platform driver
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
X-Mailer: aerc 0.15.2
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
 <20240123-mbly-clk-v3-8-392b010b8281@bootlin.com>
 <127fd51b-cd64-4e00-99d6-7be9b79f2dcc@linaro.org>
In-Reply-To: <127fd51b-cd64-4e00-99d6-7be9b79f2dcc@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Wed Jan 24, 2024 at 8:05 AM CET, Krzysztof Kozlowski wrote:
> On 23/01/2024 19:46, Th=C3=A9o Lebrun wrote:
> > Add the Mobileye EyeQ5 clock controller driver. It might grow to add
> > support for other platforms from Mobileye.
> >=20
> > It handles 10 read-only PLLs derived from the main crystal on board. It
> > exposes a table-based divider clock used for OSPI. Other platform
> > clocks are not configurable and therefore kept as fixed-factor
> > devicetree nodes.
> >=20
> > Two PLLs are required early on and are therefore registered at
> > of_clk_init(). Those are pll-cpu for the GIC timer and pll-per for the
> > UARTs.
> >=20
>
>
> > +#define OLB_PCSR1_RESET				BIT(0)
> > +#define OLB_PCSR1_SSGC_DIV			GENMASK(4, 1)
> > +/* Spread amplitude (% =3D 0.1 * SPREAD[4:0]) */
> > +#define OLB_PCSR1_SPREAD			GENMASK(9, 5)
> > +#define OLB_PCSR1_DIS_SSCG			BIT(10)
> > +/* Down-spread or center-spread */
> > +#define OLB_PCSR1_DOWN_SPREAD			BIT(11)
> > +#define OLB_PCSR1_FRAC_IN			GENMASK(31, 12)
> > +
> > +static struct clk_hw_onecell_data *eq5c_clk_data;
> > +static struct regmap *eq5c_olb;
>
> Drop these two. No file-scope regmaps for drivers. Use private container
> structures.

I wouldn't know how to handle the two steps then. Two clocks and the clk
provider are registered at of_clk_init() using CLK_OF_DECLARE_DRIVER().
The rest is at platform device probe. Without a static, there are no
way to pass the struct clk_hw_onecell_data from one to the other.

I've looked at all clock drivers that do CLK_OF_DECLARE_DRIVER() and
register a platform driver.

 - The following use a static variable:
   drivers/clk/axis/clk-artpec6.c
   drivers/clk/clk-aspeed.c
   drivers/clk/clk-ast2600.c
   drivers/clk/clk-eyeq5.c
   drivers/clk/clk-gemini.c
   drivers/clk/clk-milbeaut.c
   drivers/clk/mediatek/clk-mt2701.c
   drivers/clk/mediatek/clk-mt6797.c
   drivers/clk/mediatek/clk-mt8173-infracfg.c
   drivers/clk/nxp/clk-lpc18xx-creg.c
   drivers/clk/ralink/clk-mt7621.c
   drivers/clk/ralink/clk-mtmips.c
   drivers/clk/sunxi/clk-mod0.c
   drivers/clk/axis/clk-artpec6.c

 - Those two declare different clock providers at init and probe:
   drivers/clk/ralink/clk-mt7621.c
   drivers/clk/sunxi/clk-mod0.c

 - It doesn't register new clocks at probe (only resets) so no need to
   share variables.
   drivers/clk/ralink/clk-mtmips.c

>
> ...
>
> > +static void __init eq5c_init(struct device_node *np)
> > +{
> > +	struct device_node *parent_np =3D of_get_parent(np);
> > +	int i, ret;
> > +
> > +	eq5c_clk_data =3D kzalloc(struct_size(eq5c_clk_data, hws, EQ5C_NB_CLK=
S),
> > +				GFP_KERNEL);
> > +	if (!eq5c_clk_data) {
> > +		ret =3D -ENOMEM;
> > +		goto err;
> > +	}
> > +
> > +	eq5c_clk_data->num =3D EQ5C_NB_CLKS;
> > +
> > +	/*
> > +	 * Mark all clocks as deferred. We register some now and others at
> > +	 * platform device probe.
> > +	 */
> > +	for (i =3D 0; i < EQ5C_NB_CLKS; i++)
> > +		eq5c_clk_data->hws[i] =3D ERR_PTR(-EPROBE_DEFER);
> > +
> > +	/*
> > +	 * Currently, if OLB is not available, we log an error, fail init the=
n
>
> How it could be not available? Only with broken initcall ordering. Fix
> your initcall ordering and then simplify all this weird code.

of_syscon_register() and regmap_init_mmio() lists many reasons for
it to not be available. Am I missing something?

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

