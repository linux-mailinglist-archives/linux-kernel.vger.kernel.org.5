Return-Path: <linux-kernel+bounces-85516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D79286B6F3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0AE91C21567
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4063340858;
	Wed, 28 Feb 2024 18:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hUeXU0Dc"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CBE40845;
	Wed, 28 Feb 2024 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144125; cv=none; b=PygKRKsQZjdn+HB08SbTx08eKWZRHR9nk7pV1HcSONWQpy9J0iwnL/d39+uK9n0YGn4ka4EpBPjLZ390oikExXYTmOyd4ks4cZn8YIRG9HQXkXAxLnE9LYkWRThJtizGFiXlQHzLRewZ3rGeEhsO6z+IlnPhbrlcAX+QB/FBy9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144125; c=relaxed/simple;
	bh=3zoZeon8Er00fPoyYR7FKoG9wvQMXgKJldR2no22xGc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=Mp2a7jyUmcZH2e+5tCM5ShUC+379KmU5HUqaNRKsSrtbeihT6w9TjfnHN958nz0C6aaFPYgYgtpysD5TeyOYuHDdWvjYa+TI3Af779OU4bf/jX50J2XRYkZbseNO0PW/yilRxQKMiShaugu39HRRWwp5hkQjpS7S+ekMNNTCzvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hUeXU0Dc; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B24D0E0004;
	Wed, 28 Feb 2024 18:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709144114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AEgpRUNUfdg/AqiT2bihKk1UxwLOVFdlGxOh9RWqINU=;
	b=hUeXU0Dcz0oN5vPtmTZkmUoqledoV215cMP44ULFKJnKlxmq66q0nhu0rJ7XsFcBie/HVn
	Fgr58C1Y/wR8o18KkMvVq6aPRltmvfplwtYKt6Vc8TrBc00P2QAYWorY7wArPdmV8SsIwz
	ResjbJ/pBjntbYRRl0KHnAnZJB27Aw/phutESczR7m6ZukGea+RcuHFVYhflADsFLOYkFB
	1Ne9TyHhAEPe3bXjY1R4FFrnI8PHmZy9cVevTfN6aQUbWocIBkR8tZLYcp/IGN/Ulkvh0b
	8eJpEciQ6J00GoGUhdT4MPWhswO/WmVYHf3NHF7pOkoNHFSQ4n4DllZpx47plg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Feb 2024 19:15:12 +0100
Message-Id: <CZGX0TSYLOH4.DZHG351R9KFZ@bootlin.com>
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
Subject: Re: [PATCH v8 05/10] pinctrl: eyeq5: add platform driver
X-Mailer: aerc 0.15.2
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
 <20240227-mbly-clk-v8-5-c57fbda7664a@bootlin.com>
 <Zd4moVd_-bY6Z_kL@smile.fi.intel.com>
In-Reply-To: <Zd4moVd_-bY6Z_kL@smile.fi.intel.com>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Tue Feb 27, 2024 at 7:14 PM CET, Andy Shevchenko wrote:
> On Tue, Feb 27, 2024 at 03:55:26PM +0100, Th=C3=A9o Lebrun wrote:
> > Add the Mobileye EyeQ5 pin controller driver. It might grow to add late=
r
> > support of other platforms from Mobileye. It belongs to a syscon region
> > called OLB.
> >=20
> > Existing pins and their function live statically in the driver code
> > rather than in the devicetree, see compatible match data.
>
> ...
>
> > +config PINCTRL_EYEQ5
> > +	bool "Mobileye EyeQ5 pinctrl driver"
>
> Can't be a module?

It theory it could, I however do not see why that would be done. Pinctrl
is essential to the platform capabilities. The platform is an embedded
one and performance-oriented; boot-time is important and no user will
ever want to load pinctrl as a module.

>
> > +	depends on OF
>
> It's even not needed for this software as far as I can tell from the code=
.

Indeed looks like it. Will try that out and remove the dependency if it
works as expected.

[...]

> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/pinctrl/pinconf-generic.h>
> > +#include <linux/pinctrl/pinconf.h>
> > +#include <linux/pinctrl/pinctrl.h>
> > +#include <linux/pinctrl/pinmux.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/seq_file.h>
>
> Semi-random list of the inclusions. Please, fix it.
> While doing that, group out pinctrl/* ones as it's done in other drivers.

Here is my new list:

#include <linux/array_size.h>
#include <linux/bits.h>
#include <linux/bug.h>
#include <linux/device.h>
#include <linux/err.h>
#include <linux/errno.h>
#include <linux/io.h>
#include <linux/mod_devicetable.h>
#include <linux/platform_device.h>
#include <linux/seq_file.h>
#include <linux/slab.h>
#include <linux/types.h>

#include <linux/pinctrl/pinconf-generic.h>
#include <linux/pinctrl/pinconf.h>
#include <linux/pinctrl/pinctrl.h>
#include <linux/pinctrl/pinmux.h>

#include "core.h"
#include "pinctrl-utils.h"

[...]

> > +static bool eq5p_test_bit(const struct eq5p_pinctrl *pctrl,
> > +			  enum eq5p_bank bank, enum eq5p_regs reg, int offset)
> > +{
> > +	u32 val =3D readl(pctrl->base + eq5p_regs[bank][reg]);
>
> > +	if (WARN_ON(offset > 31))
> > +		return false;
>
> When this condition can be true?

If there is a bug in the code. Defensive programming.

There is this subtle conversion of pin numbers =3D> offset inside of a
bank. If one function forgets doing this then eq5p_test_bit() gets
called with a pin number.

In this GPIO series I fixed such a bug in a 10 year old driver:
https://lore.kernel.org/lkml/20240228-mbly-gpio-v2-5-3ba757474006@bootlin.c=
om/

The whole "if it can happen it will happen" mantra. We'll get a warning
in the logs using pinctrl-eyeq5.

>
> > +	return (val & BIT(offset)) !=3D 0;
> > +}
>
> ...
>
> > +static int eq5p_pinconf_get(struct pinctrl_dev *pctldev, unsigned int =
pin,
> > +			    unsigned long *config);
>
> Can't you avoid forward declarations?

Yes, will do so.

>
> ...
>
> > +	if (!eq5p_test_bit(pctrl, bank, EQ5P_IOCR, offset)) {
>
> What's wrong with positive conditional?

Nothing. In my mind GPIO was first, other was second. Will change.

>
>
> > +	} else {
>
> > +	}
>
> ...
>
> > +static const struct pinctrl_ops eq5p_pinctrl_ops =3D {
> > +	.get_groups_count	=3D eq5p_pinctrl_get_groups_count,
> > +	.get_group_name		=3D eq5p_pinctrl_get_group_name,
> > +	.get_group_pins		=3D eq5p_pinctrl_get_group_pins,
> > +	.pin_dbg_show		=3D eq5p_pinctrl_pin_dbg_show,
>
> > +	.dt_node_to_map		=3D pinconf_generic_dt_node_to_map_pin,
> > +	.dt_free_map		=3D pinctrl_utils_free_map,
>
> ifdef is missing for these... But the question is, isn't these a default =
when
> OF is in use?

Doesn't look like it is. In drivers/pinctrl/devicetree.c:

	static int dt_to_map_one_config(struct pinctrl *p,
					struct pinctrl_dev *hog_pctldev,
					const char *statename,
					struct device_node *np_config)
	{
		// ...

		/*
		 * Call pinctrl driver to parse device tree node, and
		 * generate mapping table entries
		 */
		ops =3D pctldev->desc->pctlops;
		if (!ops->dt_node_to_map) {
			dev_err(p->dev, "pctldev %s doesn't support DT\n",
				dev_name(pctldev->dev));
			return -ENODEV;
		}

		// ...
	}

And I see nowhere that puts a value if ->dt_node_to_map is empty.

For dt_free_map, it is an optional value. If the field is NULL nothing
is done. See dt_free_map() in the same file.

[...]

> > +	mask =3D BIT(offset);
> > +	val =3D is_gpio ? 0 : U32_MAX;
>
> I think you meant something else (semantically) than U32_MAX.
> Perhaps GENMASK(31, 0)?

To me the semantic of U32_MAX is the same. I see where you are coming
from. A better alternative however would be:

	mask =3D BIT(offset);
	val =3D is_gpio ? 0 : mask;

That way the desire is clear and the code is simpler.

>
> ...
>
> > +static int eq5p_pinconf_get(struct pinctrl_dev *pctldev, unsigned int =
pin,
> > +			    unsigned long *config)
> > +{
> > +	enum pin_config_param param =3D pinconf_to_config_param(*config);
> > +	struct eq5p_pinctrl *pctrl =3D pinctrl_dev_get_drvdata(pctldev);
> > +	unsigned int offset =3D eq5p_pin_to_offset(pin);
> > +	enum eq5p_bank bank =3D eq5p_pin_to_bank(pin);
> > +	u32 val_ds, arg =3D 0;
>
> What's arg assignment for?

No reason indeed. Will remove the assignment.

>
> > +	bool pd, pu;
> > +
> > +	pd =3D eq5p_test_bit(pctrl, bank, EQ5P_PD, offset);
> > +	pu =3D eq5p_test_bit(pctrl, bank, EQ5P_PU, offset);
> > +
> > +	switch (param) {
> > +	case PIN_CONFIG_BIAS_DISABLE:
> > +		arg =3D !(pd || pu);
> > +		break;
> > +	case PIN_CONFIG_BIAS_PULL_DOWN:
> > +		arg =3D pd;
> > +		break;
> > +	case PIN_CONFIG_BIAS_PULL_UP:
> > +		arg =3D pu;
> > +		break;
> > +	case PIN_CONFIG_DRIVE_STRENGTH:
> > +		offset *=3D 2; /* two bits per pin */
> > +		if (offset >=3D 32) {
> > +			val_ds =3D readl(pctrl->base + eq5p_regs[bank][EQ5P_DS_HIGH]);
> > +			offset -=3D 32;
> > +		} else {
> > +			val_ds =3D readl(pctrl->base + eq5p_regs[bank][EQ5P_DS_LOW]);
> > +		}
>
> I'm wondering why you can't use your helpers before multiplication?

I'm unsure what helpers you are talking about?

If the question is about why multiply before if-condition: I feel like
multiplying first allows having the if condition be "offset >=3D 32".
That explicits why we readl HIGH vs LOW regs.

[...]

>
> > +static int eq5p_pinconf_set_drive_strength(struct pinctrl_dev *pctldev=
,
> > +					   unsigned int pin, u32 arg)
> > +{
> > +	struct eq5p_pinctrl *pctrl =3D pinctrl_dev_get_drvdata(pctldev);
> > +	unsigned int offset =3D eq5p_pin_to_offset(pin);
> > +	enum eq5p_bank bank =3D eq5p_pin_to_bank(pin);
> > +	unsigned int reg;
> > +	u32 mask, val;
> > +
> > +	if (arg > 3) {
>
> Magic number.

Would 0b11 explicit why? The value is two bits wide, so 0 thru 3.

>
> > +		dev_err(pctldev->dev, "Unsupported drive strength: %u\n", arg);
> > +		return -EINVAL;
> > +	}
> > +
> > +	offset *=3D 2; /* two bits per pin */
> > +
> > +	if (offset >=3D 32) {
> > +		reg =3D EQ5P_DS_HIGH;
> > +		offset -=3D 32;
> > +	} else {
> > +		reg =3D EQ5P_DS_LOW;
> > +	}
>
> > +	mask =3D 0b11 << offset;
> > +	val =3D arg << offset;
> > +	eq5p_update_bits(pctrl, bank, reg, mask, val);
>
> Similar comments as per previous function.

So GENMASK(1, 0) rather than 0b11. Or GENMASK(offset+1, offset).

Something else?

>
> > +	return 0;
> > +}
>
> ...
>
> > +static const struct of_device_id eq5p_match[] =3D {
> > +	{ .compatible =3D "mobileye,eyeq5-pinctrl" },
> > +	{},
>
> No comma in the terminator entry.
>
> > +};
>
> No MODULE_DEVICE_TABLE()?

It is an oversight. Will be added.

Thanks for the review Andy.

Have a nice day,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


