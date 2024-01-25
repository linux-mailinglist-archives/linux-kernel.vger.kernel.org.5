Return-Path: <linux-kernel+bounces-38546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1CD83C15A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04631C2308F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951BE37709;
	Thu, 25 Jan 2024 11:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l+pMp/Zc"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40CE33CDB;
	Thu, 25 Jan 2024 11:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706183609; cv=none; b=XGdjenFL3lHG/aB62SrTofcanv7ay2PsXlCRIXLtHykIYQTywqjktD7HfMSkgjr905ldAP+O2MKhPYQeWp0tBpUaXrnyQWTlbH7Ioj5kk9NysZhdA4RFeNkA6LScvePOHHqsXZLZ1vONBlgyiMxxKMOaDTzPF2r3j/CtD/Rdclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706183609; c=relaxed/simple;
	bh=k9VgRYeNrPHdfOrpwqwrz/D5of6TTpkE5y+OALsVfuw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=hwoqII6Byzyqq0gPvr1IqmIEpCkZbrmXWtCA+AhgQQDFE2008TJaVtXkaGNiLVAemTtlVtEgVN29w85etjy19B0wunFoUF6psawCJ9thGIsV+Mk8v7Jm2jn5/0PeqzWd/21oXfsu+RzsMDXiudI+Rd8UvoX8EJlzIC5l9hPlPhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l+pMp/Zc; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 44BE81C0005;
	Thu, 25 Jan 2024 11:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706183605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abQCJSKdwJXP9+/KbyZE7cBdmY2HQ+LTAyHc/830rpk=;
	b=l+pMp/ZcEhB5G6Y86pGNxFWhkEksfB4aM2fqWyzqe8NEFX3qNkqSCsRe867m4DYlWmLb+Q
	gz6Lz11UZmVNxhaFXhk0Ia+SLDi6ZdMzuetZ+QeZ7Vlp9YnWOUvv0E+k2ksOUQaZte2ITY
	G7aUsDmDos4LPodEUXlSHd7/ttBgLZD24W2Hu3NPtOy6kDU1tI7+USe4hjLN1obejuUyvT
	RHf0lb/N2prh8ELgiZdtqo5v05cpyunqXW/2eYaML8nY5Vs5l9REklaP7zOFJYaAnt6If+
	S6NXTOj/Xkk33WMpYHGGqZplLX+a7pSTpvJT2sh75hwMy2Lt5SxM9ADokCGqkQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jan 2024 12:53:24 +0100
Message-Id: <CYNRLZ2XTOGY.3ANWB33IDCN2W@bootlin.com>
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
Subject: Re: [PATCH v3 08/17] clk: eyeq5: add platform driver
X-Mailer: aerc 0.15.2
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
 <20240123-mbly-clk-v3-8-392b010b8281@bootlin.com>
 <127fd51b-cd64-4e00-99d6-7be9b79f2dcc@linaro.org>
 <CYN33YJ10HYS.2YDXB158LFZPL@bootlin.com>
 <001993b9-ea0c-49c3-a4e5-4cea10c54082@linaro.org>
In-Reply-To: <001993b9-ea0c-49c3-a4e5-4cea10c54082@linaro.org>
X-GND-Sasl: theo.lebrun@bootlin.com

Hi,

On Thu Jan 25, 2024 at 8:46 AM CET, Krzysztof Kozlowski wrote:
> On 24/01/2024 17:41, Th=C3=A9o Lebrun wrote:
> > Hello,
> >=20
> > On Wed Jan 24, 2024 at 8:05 AM CET, Krzysztof Kozlowski wrote:
> >> On 23/01/2024 19:46, Th=C3=A9o Lebrun wrote:
> >>> Add the Mobileye EyeQ5 clock controller driver. It might grow to add
> >>> support for other platforms from Mobileye.
> >>>
> >>> It handles 10 read-only PLLs derived from the main crystal on board. =
It
> >>> exposes a table-based divider clock used for OSPI. Other platform
> >>> clocks are not configurable and therefore kept as fixed-factor
> >>> devicetree nodes.
> >>>
> >>> Two PLLs are required early on and are therefore registered at
> >>> of_clk_init(). Those are pll-cpu for the GIC timer and pll-per for th=
e
> >>> UARTs.
> >>>
> >>
> >>
> >>> +#define OLB_PCSR1_RESET				BIT(0)
> >>> +#define OLB_PCSR1_SSGC_DIV			GENMASK(4, 1)
> >>> +/* Spread amplitude (% =3D 0.1 * SPREAD[4:0]) */
> >>> +#define OLB_PCSR1_SPREAD			GENMASK(9, 5)
> >>> +#define OLB_PCSR1_DIS_SSCG			BIT(10)
> >>> +/* Down-spread or center-spread */
> >>> +#define OLB_PCSR1_DOWN_SPREAD			BIT(11)
> >>> +#define OLB_PCSR1_FRAC_IN			GENMASK(31, 12)
> >>> +
> >>> +static struct clk_hw_onecell_data *eq5c_clk_data;
> >>> +static struct regmap *eq5c_olb;
> >>
> >> Drop these two. No file-scope regmaps for drivers. Use private contain=
er
> >> structures.
> >=20
> > I wouldn't know how to handle the two steps then. Two clocks and the cl=
k
> > provider are registered at of_clk_init() using CLK_OF_DECLARE_DRIVER().
>
> Right, if some clocks have to be early, CLK_OF_DECLARE_DRIVER needs
> static ones. But your commit subject says it is a platform driver and
> all other pieces of this code is rather incompatible with this approach.

That is my bad on the commit subject. What do you refer to by "all other
pieces of this code is rather incompatible with this approach"?

I've tried to minimise the use of static variables. Therefore as soon as
the probe is started, we switch to the usual way of using a private
struct that contains our info.

>
> Do not use CLK_OF_DECLARE_DRIVER for cases where you have dependencies
> because it forces you to manually order initcalls, which is exactly what
> we do not want.

What should I be using? I got confirmation from Stephen that this
mixture of CLK_OF_DECLARE_DRIVER() + platform driver is what I should
be using as review in my V1.

https://lore.kernel.org/lkml/fa32e6fae168e10d42051b89197855e9.sboyd@kernel.=
org/

>
>
> > The rest is at platform device probe. Without a static, there are no
> > way to pass the struct clk_hw_onecell_data from one to the other.
> >=20
> > I've looked at all clock drivers that do CLK_OF_DECLARE_DRIVER() and
> > register a platform driver.
>
> Even though the code is correct, using arguments "other did it" will not
> work. You want to say that you implement legacy, poor code because you
> saw legacy, poor code?

Yes I see what you mean. It's just that this is not the sort of things
that are documented. And learning The Right Way(TM) when you don't know
it can only be done by looking at existing stuff. I'm being exhaustive
to avoid basing my approach on one old-school driver that is using the
wrong approach.

> >> ...
> >>
> >>> +static void __init eq5c_init(struct device_node *np)
> >>> +{
> >>> +	struct device_node *parent_np =3D of_get_parent(np);
> >>> +	int i, ret;
> >>> +
> >>> +	eq5c_clk_data =3D kzalloc(struct_size(eq5c_clk_data, hws, EQ5C_NB_C=
LKS),
> >>> +				GFP_KERNEL);
> >>> +	if (!eq5c_clk_data) {
> >>> +		ret =3D -ENOMEM;
> >>> +		goto err;
> >>> +	}
> >>> +
> >>> +	eq5c_clk_data->num =3D EQ5C_NB_CLKS;
> >>> +
> >>> +	/*
> >>> +	 * Mark all clocks as deferred. We register some now and others at
> >>> +	 * platform device probe.
> >>> +	 */
> >>> +	for (i =3D 0; i < EQ5C_NB_CLKS; i++)
> >>> +		eq5c_clk_data->hws[i] =3D ERR_PTR(-EPROBE_DEFER);
> >>> +
> >>> +	/*
> >>> +	 * Currently, if OLB is not available, we log an error, fail init t=
hen
> >>
> >> How it could be not available? Only with broken initcall ordering. Fix
> >> your initcall ordering and then simplify all this weird code.
> >=20
> > of_syscon_register() and regmap_init_mmio() lists many reasons for
> > it to not be available. Am I missing something?
>
> Yes, initcall ordering.

You said the regmap can only not be available with broken initcall
ordering. I say that is not the only reason.

About initcall, I've removed those that used initcall in the three
drivers I'm using except this clk one that requires two clocks at
of_clk_init().

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

