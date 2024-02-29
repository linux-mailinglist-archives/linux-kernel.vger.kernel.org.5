Return-Path: <linux-kernel+bounces-86902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 360F986CC93
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBAB285377
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0510E141995;
	Thu, 29 Feb 2024 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cT3W4J8M"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56AA137777;
	Thu, 29 Feb 2024 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709219602; cv=none; b=WiSk8R9yprj2GPffL1TfdKiiK29ByNobR4lJPaVcSmuWZyrXyvjwR4Ayd81vg+GZOdNyffsgAqj9VhgzKlHGd4ZgfSu8RBuOH5QyrzZAKLwXXVqumomG8AO2NKDr0HALQGfb2IcyMybZztNu54tYuiam9+e90IQPdYZlIUeq974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709219602; c=relaxed/simple;
	bh=yP3KNDy1IIwwOw9qTXZ4+tF0LwRs4bi1+9Aw/uR91UI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=mWECYDNIXoVkX+zPL9Cs2SztG9Dbwo8+LbzQa15FCCg+B8FlXfBRzrFlfdaNSGOiYsV3s6kjU3YN9sRuMuFuXma7IkfzxHFzIDh5G648UZNX3iMHsIl+bIH0vx6KpJoNC6bd89t8xHBUd59ccDhMSsqddV9o3nJekdfmvJLHzLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cT3W4J8M; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CE619C000A;
	Thu, 29 Feb 2024 15:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709219597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FoBURWTIPimd8MPiI97xIR1vDaJAFlKxrIgOrhBjJ5o=;
	b=cT3W4J8MH2FTCDpQk8Jknvmkycp7Lz47lhBdQRqIR1pHI1x1vScGnxyeAmRrPCdW/R2tO1
	sCW1d4CLbEY9RYqwR5jUDUYk7vv0uCDdPeUy3o7T217qTpv+ED12P8wj+jQCxJ+1Ta/k07
	fnRoTfSqN2OtbqC55fOb8DigGkPRUFPzIOXtI8vAVxGVnM4rJX7IavPB8uhgFCJBmf25Qj
	dEQx7l/mKiTwFMK56D7imKS7OxfvIXf4S0OIWsE2z6I5klm4BlzJTuq3PO/pyrKaX1VBBh
	Kd5SjX2Hpcm3t0L9EsUCy5vUYrI69C3ruFO+SdlM6mJbDbEwIeHzIduE+wYMmA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Feb 2024 16:13:15 +0100
Message-Id: <CZHNS29NK9RR.13G019Y9ZY6IO@bootlin.com>
Subject: Re: [PATCH v8 05/10] pinctrl: eyeq5: add platform driver
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
 <20240227-mbly-clk-v8-5-c57fbda7664a@bootlin.com>
 <Zd4moVd_-bY6Z_kL@smile.fi.intel.com>
 <CZGX0TSYLOH4.DZHG351R9KFZ@bootlin.com>
 <ZeBsAbPRr5IPkVZj@smile.fi.intel.com>
In-Reply-To: <ZeBsAbPRr5IPkVZj@smile.fi.intel.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu Feb 29, 2024 at 12:35 PM CET, Andy Shevchenko wrote:
> On Wed, Feb 28, 2024 at 07:15:12PM +0100, Th=C3=A9o Lebrun wrote:
> > On Tue Feb 27, 2024 at 7:14 PM CET, Andy Shevchenko wrote:
> > > On Tue, Feb 27, 2024 at 03:55:26PM +0100, Th=C3=A9o Lebrun wrote:
>
> ...
>
> > > > +	bool "Mobileye EyeQ5 pinctrl driver"
> > >
> > > Can't be a module?
> >=20
> > It theory it could, I however do not see why that would be done. Pinctr=
l
> > is essential to the platform capabilities. The platform is an embedded
> > one and performance-oriented; boot-time is important and no user will
> > ever want to load pinctrl as a module.
>
> I can argue. The modularization can give a better granularity in the exac=
tly
> embedded world when the memory resource (flash/RAM) is limited or fragmen=
ted
> (for one or another reason). Having less weighty kernel at boot makes it =
smaller
> to fit, for example, faster read only memory block which is not so uncomm=
on.

I can argue back. :-) Granularity brought from modules is useful either
in (1) resource constrained boot context or (2) for peripherals which
some people might want to do without. We are not in case 1 nor case 2.

> The rule of thumb is to make modules if, otherwise, it's not so critical =
for
> the boot process (and even for some cases we still may have it done as a =
module
> with help of deferred probe mechanism).

I'd call SoC pin control a critical resource for the boot process.

I also like the simplicity of builtin better for such a resource.
 - If we tristate pinctrl-eyeq5 and there is a bug, there is a bug (in a
   context that we have no reason to support).
 - If we do not allow it and there is a bug, there is no bug.
   Plus, it makes one less choice for people configuring the kernel.

[...]

> > > > +	if (WARN_ON(offset > 31))
> > > > +		return false;
> > >
> > > When this condition can be true?
> >=20
> > If there is a bug in the code. Defensive programming.
> >=20
> > There is this subtle conversion of pin numbers =3D> offset inside of a
> > bank. If one function forgets doing this then eq5p_test_bit() gets
> > called with a pin number.
> >=20
> > In this GPIO series I fixed such a bug in a 10 year old driver:
> > https://lore.kernel.org/lkml/20240228-mbly-gpio-v2-5-3ba757474006@bootl=
in.com/
> >=20
> > The whole "if it can happen it will happen" mantra. We'll get a warning
> > in the logs using pinctrl-eyeq5.
>
> My point here that we have mechanisms to avoid such issues, for example i=
n GPIO
> we have valid_mask field and GPIO library takes care to avoid such condit=
ions
> from happening. Please, double check that you really need these in your d=
river.
> I prefer to avoid them until it's proven that they are real cases.

Whatever the subsystem does to protect us (like only calling callbacks
with valid IDs), it will not protect us from bugs inside the driver's
callbacks.

I do no see a reason to avoid such code. I do not trust myself to write
perfect code. Its aim is to protect ourselves from our own mistakes. If
such an issue occurs, understanding that this is what happened would be
really hard (especially if it occurs on someone else's boards).

> ...
>
> > > > +static const struct pinctrl_ops eq5p_pinctrl_ops =3D {
> > > > +	.get_groups_count	=3D eq5p_pinctrl_get_groups_count,
> > > > +	.get_group_name		=3D eq5p_pinctrl_get_group_name,
> > > > +	.get_group_pins		=3D eq5p_pinctrl_get_group_pins,
> > > > +	.pin_dbg_show		=3D eq5p_pinctrl_pin_dbg_show,
> > >
> > > > +	.dt_node_to_map		=3D pinconf_generic_dt_node_to_map_pin,
> > > > +	.dt_free_map		=3D pinctrl_utils_free_map,
> > >
> > > ifdef is missing for these... But the question is, isn't these a defa=
ult when
> > > OF is in use?
> >=20
> > Doesn't look like it is. In drivers/pinctrl/devicetree.c:
> >=20
> > 	static int dt_to_map_one_config(struct pinctrl *p,
> > 					struct pinctrl_dev *hog_pctldev,
> > 					const char *statename,
> > 					struct device_node *np_config)
> > 	{
> > 		// ...
> >=20
> > 		/*
> > 		 * Call pinctrl driver to parse device tree node, and
> > 		 * generate mapping table entries
> > 		 */
> > 		ops =3D pctldev->desc->pctlops;
> > 		if (!ops->dt_node_to_map) {
> > 			dev_err(p->dev, "pctldev %s doesn't support DT\n",
> > 				dev_name(pctldev->dev));
> > 			return -ENODEV;
> > 		}
> >=20
> > 		// ...
> > 	}
> >=20
> > And I see nowhere that puts a value if ->dt_node_to_map is empty.
> >=20
> > For dt_free_map, it is an optional value. If the field is NULL nothing
> > is done. See dt_free_map() in the same file.
>
> If we drop OF dependency, these fields might not be present in the struct=
ure
> (by definition). Compilation won't succeed. Am I mistaken?

struct pinctrl_ops has both ->dt_node_to_map and ->dt_free_map fields in
any case. See include/linux/pinctrl/pinctrl.h which declares the
struct. The function pointers we put are also under no conditional
compilation.

[...]

> > > > +	case PIN_CONFIG_DRIVE_STRENGTH:
> > > > +		offset *=3D 2; /* two bits per pin */
> > > > +		if (offset >=3D 32) {
> > > > +			val_ds =3D readl(pctrl->base + eq5p_regs[bank][EQ5P_DS_HIGH]);
> > > > +			offset -=3D 32;
> > > > +		} else {
> > > > +			val_ds =3D readl(pctrl->base + eq5p_regs[bank][EQ5P_DS_LOW]);
> > > > +		}
> > >
> > > I'm wondering why you can't use your helpers before multiplication?
> >=20
> > I'm unsure what helpers you are talking about?
>
> Which give you the MMIO addresses.

Again sorry, but I don't get the question. I see no helper function that
returns an MMIO address in eq5p_pinconf_get(). Two helpers exist to
deal with memory accesses: eq5p_test_bit() and eq5p_update_bits().
Neither are called in this function nor could they be used.

> > If the question is about why multiply before if-condition: I feel like
> > multiplying first allows having the if condition be "offset >=3D 32".
> > That explicits why we readl HIGH vs LOW regs.
>
> [...]
>
> > > > +	if (arg > 3) {
> > >
> > > Magic number.
> >=20
> > Would 0b11 explicit why? The value is two bits wide, so 0 thru 3.
>
> No, the
>
> #define FOO_SELF_EXPLAING	GENMASK(1, 0) // or 3 or 0b11
>
> will.

Will do!

Thanks Andy,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


