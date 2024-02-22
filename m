Return-Path: <linux-kernel+bounces-76731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3DC85FBAC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8333A1C22CD7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF103149013;
	Thu, 22 Feb 2024 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jAb52KRx"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA943FE5D;
	Thu, 22 Feb 2024 14:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708613814; cv=none; b=aANCJWez/FCzbaIYay7Di0gEKjw7Gb8IMFSyc1jlNHf48IbKorIfW7S5MTvWLh0p+wo/NUbyMohOUOfnp42j9zIMCTBHva2DFxbJmLcqtod7uX4FXxCTP5ZNU9sJswe44GztNu2Z93u+RkaKmhFHy/FYS/qZkUm+tEpHMcmXMTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708613814; c=relaxed/simple;
	bh=XneGK6Exzo1Jm3YnV48RaFOJrXT2jpkfZgNEdT9xses=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=YUiYap37qQ82A2lDbtY3+R3yZf/IHm1+SankoPQcwbAG3JIL/ld3MG6SdHVarnEvW2xSGiQU23seCOH+tpLv+VenE40ri2KzoHjay/DDzfUZCuATiO92LDYTMfxNErbKOHa34IMOw/rLtK1nYOWJRu+yXgmRNGaIOL7f6b8Z1aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jAb52KRx; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DC8491C0008;
	Thu, 22 Feb 2024 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708613808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRBXK6n4FJ5HDMqegXF0krUuUtLSALSJ5mz8c29U9UM=;
	b=jAb52KRx0FnHsbbjkDUsePmch2p6F1jGraLhFlv2FD6Ig1OCUkD6TkYnkVC3Oc9fybkLVH
	9wfrDXdWTbFRbBNwQ4k48zjoaDvhY4xGh59VHlzLoml3h3xSZxdSQlGP0gDTfzEqUBo8GK
	SrmYpF08oTjIoIw8tIBM92qXaSgDTyYGmVbo18EdfXVks5z9NGiYX5hYfYd69ECjDP0ZRb
	5EpdSAAN6SpB4epviZOlyx3aFRqYH70G7lUgQfYVwE+j0MQyNWc33IfqXJGv1seH+2pnS2
	483rOxDlw3IkMQbVFHWOLGOrc3Q2cuy5hERJz3VMtOXHxy8NVH5jSEXX2cuqwQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 22 Feb 2024 15:56:47 +0100
Message-Id: <CZBP1N5MVGE0.1WZ8ZWXXYT9WK@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v7 07/14] clk: eyeq5: add platform driver, and init
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
To: <andy.shevchenko@gmail.com>
X-Mailer: aerc 0.15.2
References: <20240221-mbly-clk-v7-0-31d4ce3630c3@bootlin.com>
 <20240221-mbly-clk-v7-7-31d4ce3630c3@bootlin.com>
 <ZdbWRFyq42XFdp9E@surfacebook.localdomain>
In-Reply-To: <ZdbWRFyq42XFdp9E@surfacebook.localdomain>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Thu Feb 22, 2024 at 6:06 AM CET,  wrote:
> Wed, Feb 21, 2024 at 07:22:15PM +0100, Th=C3=A9o Lebrun kirjoitti:
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
>
> ...
>
> > +config COMMON_CLK_EYEQ5
> > +	bool "Clock driver for the Mobileye EyeQ5 platform"
>
> > +	depends on OF
>
> Is this functional dependency? For compilation it seems you don't need
> it, also see below.

Indeed it is a functional dependency. See of_iomap() or
of_property_match_string() usage for example. If CONFIG_OF=3Dn both build
fine but have no behavior. In the case of such a driver having a
polyfill that does nothing is not helpful, it'd be more useful to have
the build fail.

> > +	depends on MACH_EYEQ5 || COMPILE_TEST
> > +	default MACH_EYEQ5
> > +	help
> > +		This driver provides the clocks found on the Mobileye EyeQ5 SoC. Its
> > +		registers live in a shared register region called OLB. It provides 1=
0
> > +		read-only PLLs derived from the main crystal clock which must be con=
stant
> > +		and one divider clock based on one PLL.
>
> Wrong indentation, have you run checkpatch?

`./scripts/checkpatch.pl --strict` on this commit does not complain
about this help block indentation. I'll fix it anyway.

>
> ...
>
> > +#include <linux/bitfield.h>
> > +#include <linux/bits.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/mod_devicetable.h>
>
> > +#include <linux/of_address.h>
>
> Misused header. Also see below.

It provides of_iomap() and isn't indirectly included by anything else.
Removing this include leads to a build error.

>
> > +#include <linux/platform_device.h>
>
> You have semi-random list of inclusions. Please, follow the IWUY principl=
e.
>
> Here I see _at least_ missing
> array_size.h
> err.h
> io.h
> slab.h
> types.h

Here is the list I land on. I've read the file from top to bottom
checking out each symbol.

#include <linux/array_size.h>
#include <linux/bitfield.h>
#include <linux/bits.h>
#include <linux/clk-provider.h>
#include <linux/device.h>
#include <linux/err.h>
#include <linux/init.h>
#include <linux/io.h>
#include <linux/module.h>
#include <linux/of.h>
#include <linux/of_address.h>
#include <linux/platform_device.h>
#include <linux/printk.h>
#include <linux/slab.h>
#include <linux/types.h>
#include <dt-bindings/clock/mobileye,eyeq5-clk.h>

>
> =20
> ...
>
> > +static int eq5c_pll_parse_registers(u32 r0, u32 r1, unsigned long *mul=
t,
> > +				    unsigned long *div, unsigned long *acc)
> > +{
> > +	if (r0 & PCSR0_BYPASS) {
> > +		*mult =3D 1;
> > +		*div =3D 1;
> > +		*acc =3D 0;
> > +		return 0;
> > +	}
> > +
> > +	if (!(r0 & PCSR0_PLL_LOCKED))
> > +		return -EINVAL;
> > +
> > +	*mult =3D FIELD_GET(PCSR0_INTIN, r0);
> > +	*div =3D FIELD_GET(PCSR0_REF_DIV, r0);
> > +	if (r0 & PCSR0_FOUTPOSTDIV_EN)
>
> > +		*div *=3D FIELD_GET(PCSR0_POST_DIV1, r0) *
> > +			FIELD_GET(PCSR0_POST_DIV2, r0);
>
> One line?
>
> > +	/* Fractional mode, in 2^20 (0x100000) parts. */
> > +	if (r0 & PCSR0_DSM_EN) {
> > +		*div *=3D 0x100000;
> > +		*mult =3D *mult * 0x100000 + FIELD_GET(PCSR1_FRAC_IN, r1);
> > +	}
> > +
> > +	if (!*mult || !*div)
> > +		return -EINVAL;
> > +
> > +	/* Spread spectrum. */
> > +	if (!(r1 & (PCSR1_RESET | PCSR1_DIS_SSCG))) {
> > +		/*
> > +		 * Spread is 1/1000 parts of frequency, accuracy is half of
> > +		 * that. To get accuracy, convert to ppb (parts per billion).
> > +		 */
> > +		u32 spread =3D FIELD_GET(PCSR1_SPREAD, r1);
>
> Missing blank line.
>
> > +		*acc =3D spread * 500000;
> > +		if (r1 & PCSR1_DOWN_SPREAD) {
> > +			/*
> > +			 * Downspreading: the central frequency is half a
> > +			 * spread lower.
> > +			 */
> > +			*mult *=3D 2000 - spread;
> > +			*div *=3D 2000;
> > +		}
> > +	} else {
> > +		*acc =3D 0;
> > +	}
> > +
> > +	return 0;
> > +}
>
> Looking at this function what I would do is to replace mul/div pair by
> respective struct uXX_fract, add something like
>
> #define mult_fract(fract, ...)		\
> 	...
>
> and replace those
>
> 	*mult/*div *=3D ...
>
> with
>
> 	mult_fract(fract, 2000);
>
> etc.

I'm not sure I see the logic (?). We multiply div and mult by the same
constant once, in the fractional mode if-statement. Would it clarify
the code to add a new type?

Let's try it out, the code would become:

struct eq5c_fract { unsigned long mult, div; };

static void mult_fract(struct eq5c_fract *fract, unsigned long c)
{
	fract->mul *=3D c;
	fract->div *=3D c;
}

static int eq5c_pll_parse_registers(u32 r0, u32 r1,
				    struct eq5c_fract *fract,
				    unsigned long *acc)
{
	if (r0 & PCSR0_BYPASS) {
		fract->mult =3D 1;
		fract->div =3D 1;
		*acc =3D 0;
		return 0;
	}

	if (!(r0 & PCSR0_PLL_LOCKED))
		return -EINVAL;

	fract->mult =3D FIELD_GET(PCSR0_INTIN, r0);
	fract->div =3D FIELD_GET(PCSR0_REF_DIV, r0);
	if (r0 & PCSR0_FOUTPOSTDIV_EN)
		fract->div *=3D FIELD_GET(PCSR0_POST_DIV1, r0) * FIELD_GET(PCSR0_POST_DIV=
2, r0);

	/* Fractional mode, in 2^20 (0x100000) parts. */
	if (r0 & PCSR0_DSM_EN) {
		mult_fract(fract, 0x100000);
		fract->mult +=3D FIELD_GET(PCSR1_FRAC_IN, r1);
	}

	if (!fract->mult || !fract->div)
		return -EINVAL;

	/* Spread spectrum. */
	if (!(r1 & (PCSR1_RESET | PCSR1_DIS_SSCG))) {
		/*
		 * Spread is 1/1000 parts of frequency, accuracy is half of
		 * that. To get accuracy, convert to ppb (parts per billion).
		 */
		u32 spread =3D FIELD_GET(PCSR1_SPREAD, r1);
		*acc =3D spread * 500000;
		if (r1 & PCSR1_DOWN_SPREAD) {
			/*
			 * Downspreading: the central frequency is half a
			 * spread lower.
			 */
			fract->mult *=3D 2000 - spread;
			fract->div *=3D 2000;
		}
	} else {
		*acc =3D 0;
	}

	return 0;
}

As-is, I'm not convinced. Maybe some other helpers would help? Still
unsure: it would add indirection. If we did a lot of this fract
manipulation (or if helpers existed globally) I'd understand but here
we are talking about a 50 lines function.

>
> ...
>
> > +static int eq5c_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct device_node *np =3D dev->of_node;
> > +	void __iomem *base_plls, *base_ospi;
> > +	struct clk_hw *hw;
> > +	int i;
>
> > +	if (IS_ERR(eq5c_clk_data))
> > +		return PTR_ERR(eq5c_clk_data);
> > +	else if (!eq5c_clk_data)
> > +		return -EINVAL;
>
> Besides unneeded 'else', why so complicated? Can't you choose one: either=
 NULL
> or error pointer for the invalid state?

IS_ERR(eq5c_clk_data) is in the case of an error in eq5c_init()
execution. It allows eq5c_init() to pick the error int to return from
probe. eq5c_clk_data =3D=3D NULL is in the case of eq5c_init() not being
called, ie if arch doesn't call of_clk_init().

>
> > +	base_plls =3D devm_platform_ioremap_resource_byname(pdev, "plls");
> > +	base_ospi =3D devm_platform_ioremap_resource_byname(pdev, "ospi");
>
> > +	if (!base_plls || !base_ospi)
> > +		return -ENODEV;
>
> Huh?! Are they not an error pointers and never be NULL?

They are indeed error pointers; I'll be fixing that.

>
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
> > +			continue;
> > +		}
> > +
> > +		hw =3D clk_hw_register_fixed_factor_with_accuracy_fwname(dev, np,
> > +				pll->name, "ref", 0, mult, div, acc);
> > +		eq5c_clk_data->hws[pll->index] =3D hw;
>
> Why do you feel the data with errorneous one (in some cases)? It's quite
> unusual pattern.

Actually many clk drivers put ERR_PTR(...) when a clock is not
present/available/whatever. See:

	$ git grep 'hws\[.*ERR_PTR' drivers/clk/

Options from my POV are:

 - Put the error as-is.
 - Shadow the error with ENOENT or ENODEV.
 - Put NULL.

I picked option 1. Would option 3 be better?

I start eq5c_init() by marking all clocks as EPROBE_DEFER. So we must
overwrite a value to all clks once we tried creating them. I thought
putting the clk_hw_register_*() error would make sense.

That makes me notice that if eq5c_pll_parse_registers() fails I don't
put a value in the clk hw and leave the EPROBE_DEFER. I'll fix that.

>
> > +		if (IS_ERR(hw)) {
> > +			dev_err(dev, "failed registering %s: %ld\n",
> > +				pll->name, PTR_ERR(hw));
> > +		}
>
> Besides unnecessity of {} can't you unify the output format by using
> dev_err_probe() in all error messages in ->probe()?

Sure, will remove {} and use dev_err_probe().

>
> > +	}
> > +
> > +	hw =3D clk_hw_register_divider_table_parent_hw(dev, EQ5C_OSPI_DIV_CLK=
_NAME,
> > +			eq5c_clk_data->hws[EQ5C_PLL_PER], 0,
> > +			base_ospi, 0, EQ5C_OSPI_DIV_WIDTH, 0,
> > +			eq5c_ospi_div_table, NULL);
>
> > +	eq5c_clk_data->hws[EQ5C_DIV_OSPI] =3D hw;
>
> Same as above.
>
> > +	if (IS_ERR(hw)) {
> > +		dev_err(dev, "failed registering %s: %ld\n",
> > +			EQ5C_OSPI_DIV_CLK_NAME, PTR_ERR(hw));
> > +	}
>
> Same as above.
>
> > +	return 0;
> > +}
>
> ...
>
> > +static struct platform_driver eq5c_driver =3D {
> > +	.probe =3D eq5c_probe,
> > +	.driver =3D {
> > +		.name =3D "clk-eyeq5",
> > +		.of_match_table =3D eq5c_match_table,
> > +	},
> > +};
>
> > +
>
> Redundant blank line.
>
> > +builtin_platform_driver(eq5c_driver);
>
> ...
>
> > +	index_plls =3D of_property_match_string(np, "reg-names", "plls");
> > +	index_ospi =3D of_property_match_string(np, "reg-names", "ospi");
> > +	if (index_plls < 0 || index_ospi < 0) {
> > +		ret =3D -ENODEV;
>
> Why error codes are shadowed?

Good question, I'll fix that.

Thanks for your review! I've seen all remarks but not answered them all.

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

