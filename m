Return-Path: <linux-kernel+bounces-75922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC7485F0AE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CECB41F23F17
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44DD6FD0;
	Thu, 22 Feb 2024 05:06:18 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ADE63AE
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708578378; cv=none; b=qoBaVJFN/04w4ZxtddSPd/1rdCZx+PhZWs/qMTK9bERKdNca+vQmiOU0jYOVHr3waOmWUnTwcQKM55zrF9MU2pEDTYAk2+rrGeEfA/2lqe/nLKmZy+1HnTzl23UpVDYfSSYcBtkgz9MZVVI5odQLaJH7wdvmRDNO3IQ4bzffOKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708578378; c=relaxed/simple;
	bh=alxK2KaxgdWsvowDAx8OiT6EkAp1UFnFvDiyNjnUzPQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAknyy8fN5kta6oxJplfW4Ty4+JeiuWkpDUk5D5HjY4U5Uqsxl+fKWPZ0a8UIqauWAYr5U3eRr3htGG7qmS5Nv1zs+5cojO0mlmKMeG+L3TUXA2vG/dUcQq4P3gXLjAPThOThQU3zwRgSzs4eKt1Boa+86Umz0VqI6PGRXVxQrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-217.elisa-laajakaista.fi [88.113.26.217])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 195bf9dd-d140-11ee-b972-005056bdfda7;
	Thu, 22 Feb 2024 07:06:13 +0200 (EET)
From: andy.shevchenko@gmail.com
Date: Thu, 22 Feb 2024 07:06:12 +0200
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v7 07/14] clk: eyeq5: add platform driver, and init
 routine at of_clk_init()
Message-ID: <ZdbWRFyq42XFdp9E@surfacebook.localdomain>
References: <20240221-mbly-clk-v7-0-31d4ce3630c3@bootlin.com>
 <20240221-mbly-clk-v7-7-31d4ce3630c3@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240221-mbly-clk-v7-7-31d4ce3630c3@bootlin.com>

Wed, Feb 21, 2024 at 07:22:15PM +0100, Théo Lebrun kirjoitti:
> Add the Mobileye EyeQ5 clock controller driver. It might grow to add
> support for other platforms from Mobileye.
> 
> It handles 10 read-only PLLs derived from the main crystal on board. It
> exposes a table-based divider clock used for OSPI. Other platform
> clocks are not configurable and therefore kept as fixed-factor
> devicetree nodes.
> 
> Two PLLs are required early on and are therefore registered at
> of_clk_init(). Those are pll-cpu for the GIC timer and pll-per for the
> UARTs.

..

> +config COMMON_CLK_EYEQ5
> +	bool "Clock driver for the Mobileye EyeQ5 platform"

> +	depends on OF

Is this functional dependency? For compilation it seems you don't need it, also see below.

> +	depends on MACH_EYEQ5 || COMPILE_TEST
> +	default MACH_EYEQ5
> +	help
> +		This driver provides the clocks found on the Mobileye EyeQ5 SoC. Its
> +		registers live in a shared register region called OLB. It provides 10
> +		read-only PLLs derived from the main crystal clock which must be constant
> +		and one divider clock based on one PLL.

Wrong indentation, have you run checkpatch?

..

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk-provider.h>
> +#include <linux/mod_devicetable.h>

> +#include <linux/of_address.h>

Misused header. Also see below.

> +#include <linux/platform_device.h>

You have semi-random list of inclusions. Please, follow the IWUY principle.

Here I see _at least_ missing
array_size.h
err.h
io.h
slab.h
types.h

 
..

> +static int eq5c_pll_parse_registers(u32 r0, u32 r1, unsigned long *mult,
> +				    unsigned long *div, unsigned long *acc)
> +{
> +	if (r0 & PCSR0_BYPASS) {
> +		*mult = 1;
> +		*div = 1;
> +		*acc = 0;
> +		return 0;
> +	}
> +
> +	if (!(r0 & PCSR0_PLL_LOCKED))
> +		return -EINVAL;
> +
> +	*mult = FIELD_GET(PCSR0_INTIN, r0);
> +	*div = FIELD_GET(PCSR0_REF_DIV, r0);
> +	if (r0 & PCSR0_FOUTPOSTDIV_EN)

> +		*div *= FIELD_GET(PCSR0_POST_DIV1, r0) *
> +			FIELD_GET(PCSR0_POST_DIV2, r0);

One line?

> +	/* Fractional mode, in 2^20 (0x100000) parts. */
> +	if (r0 & PCSR0_DSM_EN) {
> +		*div *= 0x100000;
> +		*mult = *mult * 0x100000 + FIELD_GET(PCSR1_FRAC_IN, r1);
> +	}
> +
> +	if (!*mult || !*div)
> +		return -EINVAL;
> +
> +	/* Spread spectrum. */
> +	if (!(r1 & (PCSR1_RESET | PCSR1_DIS_SSCG))) {
> +		/*
> +		 * Spread is 1/1000 parts of frequency, accuracy is half of
> +		 * that. To get accuracy, convert to ppb (parts per billion).
> +		 */
> +		u32 spread = FIELD_GET(PCSR1_SPREAD, r1);

Missing blank line.

> +		*acc = spread * 500000;
> +		if (r1 & PCSR1_DOWN_SPREAD) {
> +			/*
> +			 * Downspreading: the central frequency is half a
> +			 * spread lower.
> +			 */
> +			*mult *= 2000 - spread;
> +			*div *= 2000;
> +		}
> +	} else {
> +		*acc = 0;
> +	}
> +
> +	return 0;
> +}

Looking at this function what I would do is to replace mul/div pair by
respective struct uXX_fract, add something like

#define mult_fract(fract, ...)		\
	...

and replace those

	*mult/*div *= ...

with

	mult_fract(fract, 2000);

etc.

..

> +static int eq5c_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	void __iomem *base_plls, *base_ospi;
> +	struct clk_hw *hw;
> +	int i;

> +	if (IS_ERR(eq5c_clk_data))
> +		return PTR_ERR(eq5c_clk_data);
> +	else if (!eq5c_clk_data)
> +		return -EINVAL;

Besides unneeded 'else', why so complicated? Can't you choose one: either NULL
or error pointer for the invalid state?

> +	base_plls = devm_platform_ioremap_resource_byname(pdev, "plls");
> +	base_ospi = devm_platform_ioremap_resource_byname(pdev, "ospi");

> +	if (!base_plls || !base_ospi)
> +		return -ENODEV;

Huh?! Are they not an error pointers and never be NULL?

> +	for (i = 0; i < ARRAY_SIZE(eq5c_plls); i++) {
> +		const struct eq5c_pll *pll = &eq5c_plls[i];
> +		unsigned long mult, div, acc;
> +		u32 r0, r1;
> +		int ret;
> +
> +		r0 = readl(base_plls + pll->reg);
> +		r1 = readl(base_plls + pll->reg + sizeof(r0));
> +
> +		ret = eq5c_pll_parse_registers(r0, r1, &mult, &div, &acc);
> +		if (ret) {
> +			dev_warn(dev, "failed parsing state of %s\n", pll->name);
> +			continue;
> +		}
> +
> +		hw = clk_hw_register_fixed_factor_with_accuracy_fwname(dev, np,
> +				pll->name, "ref", 0, mult, div, acc);
> +		eq5c_clk_data->hws[pll->index] = hw;

Why do you feel the data with errorneous one (in some cases)? It's quite
unusual pattern.

> +		if (IS_ERR(hw)) {
> +			dev_err(dev, "failed registering %s: %ld\n",
> +				pll->name, PTR_ERR(hw));
> +		}

Besides unnecessity of {} can't you unify the output format by using
dev_err_probe() in all error messages in ->probe()?

> +	}
> +
> +	hw = clk_hw_register_divider_table_parent_hw(dev, EQ5C_OSPI_DIV_CLK_NAME,
> +			eq5c_clk_data->hws[EQ5C_PLL_PER], 0,
> +			base_ospi, 0, EQ5C_OSPI_DIV_WIDTH, 0,
> +			eq5c_ospi_div_table, NULL);

> +	eq5c_clk_data->hws[EQ5C_DIV_OSPI] = hw;

Same as above.

> +	if (IS_ERR(hw)) {
> +		dev_err(dev, "failed registering %s: %ld\n",
> +			EQ5C_OSPI_DIV_CLK_NAME, PTR_ERR(hw));
> +	}

Same as above.

> +	return 0;
> +}

..

> +static struct platform_driver eq5c_driver = {
> +	.probe = eq5c_probe,
> +	.driver = {
> +		.name = "clk-eyeq5",
> +		.of_match_table = eq5c_match_table,
> +	},
> +};

> +

Redundant blank line.

> +builtin_platform_driver(eq5c_driver);

..

> +	index_plls = of_property_match_string(np, "reg-names", "plls");
> +	index_ospi = of_property_match_string(np, "reg-names", "ospi");
> +	if (index_plls < 0 || index_ospi < 0) {
> +		ret = -ENODEV;

Why error codes are shadowed?

> +		goto err;
> +	}

-- 
With Best Regards,
Andy Shevchenko



