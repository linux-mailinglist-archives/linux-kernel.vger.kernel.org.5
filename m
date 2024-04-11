Return-Path: <linux-kernel+bounces-139701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C2B8A06A6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C9428ABA7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848D213BAD0;
	Thu, 11 Apr 2024 03:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meqGWsy9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC49A23BF;
	Thu, 11 Apr 2024 03:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712805771; cv=none; b=ue2S+QKUAtZytM52amLa3MArE3+raRlEoUrWCRVbauzrN5bF1gP2ZLnGCC9m7OKPFi+26lAPTzwGzolwLIElAvWVQjN/MiI+9MM0KPl4zdFqH2a0AnK8hkkR5cqN9Zpl/HECZ9y6apn0G3sdbmfA2f6b5SELDe0cnE1zLKO1dYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712805771; c=relaxed/simple;
	bh=GMqiV+SXR1oC4uYNR6Q6pAnMKIg8CJPNq9ETMqOEbDw=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Lp8KLAvZNgJJ2pkU8ZoJ9xGfmmV4dzutlK3TZcBEiCjlx8baCKlh1byxHNdOweQp3eO3BC9l8B9gB/wzuiC6+KBZXPNO6ZwJ8stQz6SI948/8aHfnUPsREHLXK3xc5I3YqdvI7mhXeCSzWLOBCf7MEOs9xbJ6C/E6T+4TH9GjIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meqGWsy9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E89C433C7;
	Thu, 11 Apr 2024 03:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712805770;
	bh=GMqiV+SXR1oC4uYNR6Q6pAnMKIg8CJPNq9ETMqOEbDw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=meqGWsy9HQcwrvwIj1fOfW13gn2/gr2JsKolDhvvWHwLHx40xou6ndP0uoMOZLp1m
	 g4XM+UdYNm8yjcazo2l3rkJQzZi3LsFkEYTZ6i0FQSH+z4XNuNzGnvO4zo+f4nb/pw
	 USyDFlq7iCFfmCV0OGsNq5j3OGmAhXhcTr25O6M2uRf/B5sZjqunXFAe6Ojaae+fbL
	 2rWXEw/tjbVg59+wEY2EKwH5e7HcFvfo54yaEpDWDT1Vf6bKn6LnCP28lvOb0x3TW2
	 mbMOVWrtLlQDcED48Lgm4x89z/7moOcM8Y3DJ1+JvawV4Lpn4L9+F8tmkyP4C98a11
	 EcwU92KQhvLlg==
Message-ID: <daa732cb31d947c308513b535930c729.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240410-mbly-olb-v1-5-335e496d7be3@bootlin.com>
References: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com> <20240410-mbly-olb-v1-5-335e496d7be3@bootlin.com>
Subject: Re: [PATCH 05/11] clk: eyeq: add driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Date: Wed, 10 Apr 2024 20:22:48 -0700
User-Agent: alot/0.10

Quoting Th=C3=A9o Lebrun (2024-04-10 10:12:34)
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 50af5fc7f570..1eb6e70977a3 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -218,6 +218,17 @@ config COMMON_CLK_EN7523
>           This driver provides the fixed clocks and gates present on Airo=
ha
>           ARM silicon.
> =20
> +config COMMON_CLK_EYEQ
> +       bool "Clock driver for the Mobileye EyeQ platform"
> +       depends on OF || COMPILE_TEST

The OF build dependency looks useless as we have the MACH_ dependency
below.

> +       depends on MACH_EYEQ5 || MACH_EYEQ6H || COMPILE_TEST
> +       default MACH_EYEQ5 || MACH_EYEQ6H
> +       help
> +         This driver provides clocks found on Mobileye EyeQ5, EyeQ6L and=
 Eye6H
> +         SoCs. Controllers live in shared register regions called OLB. D=
river
> +         provides read-only PLLs, derived from the main crystal clock (w=
hich
> +         must be constant). It also exposes some divider clocks.
> +
>  config COMMON_CLK_FSL_FLEXSPI
>         tristate "Clock driver for FlexSPI on Layerscape SoCs"
>         depends on ARCH_LAYERSCAPE || COMPILE_TEST
> diff --git a/drivers/clk/clk-eyeq.c b/drivers/clk/clk-eyeq.c
> new file mode 100644
> index 000000000000..bb2535010ae6
> --- /dev/null
> +++ b/drivers/clk/clk-eyeq.c
> @@ -0,0 +1,644 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PLL clock driver for the Mobileye EyeQ5, EyeQ6L and EyeQ6H platforms.
> + *
> + * This controller handles read-only PLLs, all derived from the same main
> + * crystal clock. It also exposes divider clocks, those are children to =
PLLs.
> + * Parent clock is expected to be constant. This driver's registers live=
 in
> + * a shared region called OLB. Some PLLs are initialised early by of_clk=
_init().

Is OLB a different DT node? It sounds like maybe this is trying to jam a
driver into DT when the OLB node should be a #clock-cells node.

> + *
> + * We use eqc_ as prefix, as-in "EyeQ Clock", but way shorter.
> + *
> + * Copyright (C) 2024 Mobileye Vision Technologies Ltd.
> + */
> +
> +#define pr_fmt(fmt) "clk-eyeq: " fmt
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/overflow.h>
> +#include <linux/platform_device.h>
> +#include <linux/printk.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +#include <dt-bindings/clock/mobileye,eyeq5-clk.h>
> +
> +#define EQC_MAX_DIV_COUNT              4
> +
> +/* In frac mode, it enables fractional noise canceling DAC. Else, no fun=
ction. */
> +#define PCSR0_DAC_EN                   BIT(0)
> +/* Fractional or integer mode */
> +#define PCSR0_DSM_EN                   BIT(1)
> +#define PCSR0_PLL_EN                   BIT(2)
> +/* All clocks output held at 0 */
> +#define PCSR0_FOUTPOSTDIV_EN           BIT(3)
> +#define PCSR0_POST_DIV1                        GENMASK(6, 4)
> +#define PCSR0_POST_DIV2                        GENMASK(9, 7)
> +#define PCSR0_REF_DIV                  GENMASK(15, 10)
> +#define PCSR0_INTIN                    GENMASK(27, 16)
> +#define PCSR0_BYPASS                   BIT(28)
> +/* Bits 30..29 are reserved */
> +#define PCSR0_PLL_LOCKED               BIT(31)
> +
> +#define PCSR1_RESET                    BIT(0)
> +#define PCSR1_SSGC_DIV                 GENMASK(4, 1)
> +/* Spread amplitude (% =3D 0.1 * SPREAD[4:0]) */
> +#define PCSR1_SPREAD                   GENMASK(9, 5)
> +#define PCSR1_DIS_SSCG                 BIT(10)
> +/* Down-spread or center-spread */
> +#define PCSR1_DOWN_SPREAD              BIT(11)
> +#define PCSR1_FRAC_IN                  GENMASK(31, 12)
> +
> +/*
> + * Driver might register clock provider from eqc_init() if PLLs are requ=
ired
> + * early (before platform bus is ready). Store struct eqc_priv inside li=
nked
> + * list to pass clock provider from eqc_init() to eqc_probe() and regist=
er
> + * remaining clocks from platform device probe.
> + *
> + * Clock provider is NOT created by eqc_init() if no early clock is requ=
ired.
> + * Store as linked list because EyeQ6H has multiple clock controller ins=
tances.
> + * Matching is done based on devicetree node pointer.
> + */
> +static DEFINE_SPINLOCK(eqc_list_slock);
> +static LIST_HEAD(eqc_list);
> +
> +struct eqc_pll {
> +       unsigned int    index;
> +       const char      *name;
> +       u32             reg64;
> +};
> +
> +/*
> + * Divider clock. Divider is 2*(v+1), with v the register value.
> + * Min divider is 2, max is 2*(2^width).
> + */
> +struct eqc_div {
> +       unsigned int    index;
> +       const char      *name;
> +       unsigned int    parent;
> +       const char      *resource_name;
> +       u8              shift;
> +       u8              width;
> +};
> +
> +struct eqc_match_data {
> +       unsigned int            early_pll_count;
> +       const struct eqc_pll    *early_plls;
> +
> +       unsigned int            pll_count;
> +       const struct eqc_pll    *plls;
> +
> +       unsigned int            div_count;
> +       const struct eqc_div    *divs;
> +};
> +
> +struct eqc_priv {
> +       struct clk_hw_onecell_data      *cells;
> +       const struct eqc_match_data     *data;
> +       void __iomem                    *base_plls;
> +       struct device_node              *np;
> +       struct list_head                list;
> +};
> +
> +static int eqc_pll_parse_registers(u32 r0, u32 r1, unsigned long *mult,
> +                                  unsigned long *div, unsigned long *acc)
> +{
> +       if (r0 & PCSR0_BYPASS) {
> +               *mult =3D 1;
> +               *div =3D 1;
> +               *acc =3D 0;
> +               return 0;
> +       }
> +
> +       if (!(r0 & PCSR0_PLL_LOCKED))
> +               return -EINVAL;
> +
> +       *mult =3D FIELD_GET(PCSR0_INTIN, r0);
> +       *div =3D FIELD_GET(PCSR0_REF_DIV, r0);
> +       if (r0 & PCSR0_FOUTPOSTDIV_EN)
> +               *div *=3D FIELD_GET(PCSR0_POST_DIV1, r0) * FIELD_GET(PCSR=
0_POST_DIV2, r0);
> +
> +       /* Fractional mode, in 2^20 (0x100000) parts. */
> +       if (r0 & PCSR0_DSM_EN) {
> +               *div *=3D 0x100000;
> +               *mult =3D *mult * 0x100000 + FIELD_GET(PCSR1_FRAC_IN, r1);
> +       }
> +
> +       if (!*mult || !*div)
> +               return -EINVAL;
> +
> +       /* Spread spectrum. */
> +       if (!(r1 & (PCSR1_RESET | PCSR1_DIS_SSCG))) {
> +               /*
> +                * Spread is 1/1000 parts of frequency, accuracy is half =
of
> +                * that. To get accuracy, convert to ppb (parts per billi=
on).
> +                */
> +               u32 spread =3D FIELD_GET(PCSR1_SPREAD, r1);
> +
> +               *acc =3D spread * 500000;
> +               if (r1 & PCSR1_DOWN_SPREAD) {
> +                       /*
> +                        * Downspreading: the central frequency is half a
> +                        * spread lower.
> +                        */
> +                       *mult *=3D 2000 - spread;
> +                       *div *=3D 2000;
> +               }
> +       } else {
> +               *acc =3D 0;
> +       }
> +
> +       return 0;
> +}
> +
> +static unsigned int eqc_compute_clock_count(const struct eqc_match_data =
*data)
> +{
> +       unsigned int i, nb_clks =3D 0;
> +
> +       for (i =3D 0; i < data->early_pll_count; i++)
> +               if (data->early_plls[i].index >=3D nb_clks)
> +                       nb_clks =3D data->early_plls[i].index + 1;
> +       for (i =3D 0; i < data->pll_count; i++)
> +               if (data->plls[i].index >=3D nb_clks)
> +                       nb_clks =3D data->plls[i].index + 1;
> +       for (i =3D 0; i < data->div_count; i++)
> +               if (data->divs[i].index >=3D nb_clks)
> +                       nb_clks =3D data->divs[i].index + 1;
> +
> +       /* We expect the biggest clock index to be 1 below the clock coun=
t. */
> +       WARN_ON(nb_clks !=3D data->early_pll_count + data->pll_count + da=
ta->div_count);
> +
> +       return nb_clks;
> +}
> +
> +static int eqc_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       void __iomem *div_resources[EQC_MAX_DIV_COUNT];
> +       struct device_node *np =3D dev->of_node;
> +       const struct eqc_match_data *data;
> +       struct eqc_priv *priv =3D NULL;
> +       struct clk_hw *hw;
> +       unsigned int i;
> +
> +       data =3D device_get_match_data(dev);
> +       if (!data)
> +               return -ENODEV;
> +
> +       if (data->early_pll_count) {
> +               /* Device got inited early. Retrieve clock provider from =
list. */
> +               struct eqc_priv *entry;
> +
> +               spin_lock(&eqc_list_slock);
> +               list_for_each_entry(entry, &eqc_list, list) {
> +                       if (entry->np =3D=3D np) {
> +                               priv =3D entry;
> +                               break;
> +                       }
> +               }
> +               spin_unlock(&eqc_list_slock);
> +
> +               if (!priv)
> +                       return -ENODEV;

This can be a sub-function.

> +       } else {
> +               /* Device did NOT get init early. Do it now. */
> +               unsigned int nb_clks;
> +
> +               priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +               if (!priv)
> +                       return -ENOMEM;
> +
> +               priv->np =3D np;
> +               priv->data =3D data;
> +
> +               nb_clks =3D eqc_compute_clock_count(data);
> +               priv->cells =3D devm_kzalloc(dev, struct_size(priv->cells=
, hws, nb_clks),
> +                                          GFP_KERNEL);
> +               if (!priv->cells)
> +                       return -ENOMEM;
> +
> +               priv->cells->num =3D nb_clks;
> +
> +               /*
> +                * We expect named resources if divider clocks are presen=
t.
> +                * Else, we only expect one resource.
> +                */
> +               if (data->div_count)
> +                       priv->base_plls =3D devm_platform_ioremap_resourc=
e_byname(pdev, "plls");
> +               else
> +                       priv->base_plls =3D devm_platform_ioremap_resourc=
e(pdev, 0);
> +               if (IS_ERR(priv->base_plls))
> +                       return PTR_ERR(priv->base_plls);
> +       }
> +
> +       for (i =3D 0; i < data->pll_count; i++) {
> +               const struct eqc_pll *pll =3D &data->plls[i];
> +               unsigned long mult, div, acc;
> +               u32 r0, r1;
> +               u64 val;
> +               int ret;

All variables should be declared at the start of the function. Once it
becomes "too heavy" you can split it up into smaller functions, that
again have all variables declared at the start of the function.

> +
> +               val =3D readq(priv->base_plls + pll->reg64);
> +               r0 =3D val;
> +               r1 =3D val >> 32;
> +
> +               ret =3D eqc_pll_parse_registers(r0, r1, &mult, &div, &acc=
);
> +               if (ret) {
> +                       dev_warn(dev, "failed parsing state of %s\n", pll=
->name);
> +                       priv->cells->hws[pll->index] =3D ERR_PTR(ret);
> +                       continue;
> +               }
> +
> +               hw =3D clk_hw_register_fixed_factor_with_accuracy_fwname(=
dev,
> +                               dev->of_node, pll->name, "ref", 0, mult, =
div, acc);
> +               priv->cells->hws[pll->index] =3D hw;
> +               if (IS_ERR(hw))
> +                       dev_warn(dev, "failed registering %s: %pe\n", pll=
->name, hw);
> +       }
> +
> +       BUG_ON(ARRAY_SIZE(div_resources) < data->div_count);

Can this be a static assert instead on the arrays these are based on?
Put some static_assert() near the match data macros.

> +
> +       for (i =3D 0; i < data->div_count; i++) {
> +               const struct eqc_div *div =3D &data->divs[i];
> +               void __iomem *base =3D NULL;
> +               struct clk_hw *parent;
> +               unsigned int j;
> +
> +               /*
> +                * Multiple divider clocks can request the same resource.=
 Store
> +                * resource pointers during probe(). For each divider clo=
ck,
> +                * check if previous clocks referenced the same resource =
name.
> +                *
> +                * See EQ6HC_SOUTH_DIV_OSPI_REF and EQ6HC_SOUTH_DIV_OSPI_=
SYS.
> +                */
> +               for (j =3D 0; j < i; j++) {
> +                       if (strcmp(data->divs[j].resource_name, div->reso=
urce_name) =3D=3D 0) {
> +                               base =3D div_resources[j];
> +                               break;
> +                       }
> +               }
> +
> +               /* Resource is first encountered. */
> +               if (!base) {
> +                       base =3D devm_platform_ioremap_resource_byname(pd=
ev, div->resource_name);
> +                       if (IS_ERR(base)) {
> +                               dev_warn(dev, "failed to iomap resource f=
or %s\n", div->name);
> +                               priv->cells->hws[div->index] =3D base;
> +                               continue;
> +                       }
> +               }

I don't get this code at all. The driver should simply map the
resources because it knows that there's an io resource. I'll look at the
binding which is probably wrong and causing the driver to be written
this way.

> +
> +               div_resources[i] =3D base;
> +
> +               parent =3D priv->cells->hws[div->parent];
> +               hw =3D clk_hw_register_divider_table_parent_hw(dev, div->=
name,
> +                               parent, 0, base, div->shift, div->width,
> +                               CLK_DIVIDER_EVEN_INTEGERS, NULL, NULL);
> +               priv->cells->hws[div->index] =3D hw;
> +               if (IS_ERR(hw))
> +                       dev_warn(dev, "failed registering %s: %pe\n",
> +                                div->name, hw);
> +       }
> +
> +       /* Clock provider has not been registered by eqc_init(). Do it no=
w. */
> +       if (data->early_pll_count =3D=3D 0) {
> +               /* When providing a single clock, require no cell. */
> +               if (priv->cells->num =3D=3D 1)
> +                       return devm_of_clk_add_hw_provider(dev, of_clk_hw=
_simple_get,
> +                                                          priv->cells->h=
ws);
> +               else
> +                       return devm_of_clk_add_hw_provider(dev, of_clk_hw=
_onecell_get,
> +                                                          priv->cells);
> +       }
> +
> +       return 0;
> +}
> +
> +/* Required early for GIC timer (pll-cpu) and UARTs (pll-per). */
> +static const struct eqc_pll eqc_eyeq5_early_plls[] =3D {
> +       { .index =3D EQ5C_PLL_CPU, .name =3D "pll-cpu",  .reg64 =3D 0x00,=
 },
> +       { .index =3D EQ5C_PLL_PER, .name =3D "pll-per",  .reg64 =3D 0x30,=
 },
> +};
> +
> +static const struct eqc_pll eqc_eyeq5_plls[] =3D {
> +       { .index =3D EQ5C_PLL_VMP,  .name =3D "pll-vmp",  .reg64 =3D 0x08=
, },
> +       { .index =3D EQ5C_PLL_PMA,  .name =3D "pll-pma",  .reg64 =3D 0x10=
, },
> +       { .index =3D EQ5C_PLL_VDI,  .name =3D "pll-vdi",  .reg64 =3D 0x18=
, },
> +       { .index =3D EQ5C_PLL_DDR0, .name =3D "pll-ddr0", .reg64 =3D 0x20=
, },
> +       { .index =3D EQ5C_PLL_PCI,  .name =3D "pll-pci",  .reg64 =3D 0x28=
, },
> +       { .index =3D EQ5C_PLL_PMAC, .name =3D "pll-pmac", .reg64 =3D 0x38=
, },
> +       { .index =3D EQ5C_PLL_MPC,  .name =3D "pll-mpc",  .reg64 =3D 0x40=
, },
> +       { .index =3D EQ5C_PLL_DDR1, .name =3D "pll-ddr1", .reg64 =3D 0x48=
, },
> +};
> +
> +static const struct eqc_div eqc_eyeq5_divs[] =3D {
> +       {
> +               .index =3D EQ5C_DIV_OSPI,
> +               .name =3D "div-ospi",
> +               .parent =3D EQ5C_PLL_PER,
> +               .resource_name =3D "ospi",
> +               .shift =3D 0,
> +               .width =3D 4,
> +       },
> +};
> +
> +static const struct eqc_match_data eqc_eyeq5_match_data =3D {
> +       .early_pll_count        =3D ARRAY_SIZE(eqc_eyeq5_early_plls),
> +       .early_plls             =3D eqc_eyeq5_early_plls,
> +
> +       .pll_count      =3D ARRAY_SIZE(eqc_eyeq5_plls),
> +       .plls           =3D eqc_eyeq5_plls,
> +
> +       .div_count      =3D ARRAY_SIZE(eqc_eyeq5_divs),
> +       .divs           =3D eqc_eyeq5_divs,
> +};
> +
> +static const struct eqc_pll eqc_eyeq6l_plls[] =3D {
> +       { .index =3D EQ6LC_PLL_DDR, .name =3D "pll-ddr", .reg64 =3D 0x2C =
},
> +       { .index =3D EQ6LC_PLL_CPU, .name =3D "pll-cpu", .reg64 =3D 0x34 =
}, /* also acc */
> +       { .index =3D EQ6LC_PLL_PER, .name =3D "pll-per", .reg64 =3D 0x3C =
},
> +       { .index =3D EQ6LC_PLL_VDI, .name =3D "pll-vdi", .reg64 =3D 0x44 =
},
> +};
> +
> +static const struct eqc_match_data eqc_eyeq6l_match_data =3D {
> +       .pll_count      =3D ARRAY_SIZE(eqc_eyeq6l_plls),
> +       .plls           =3D eqc_eyeq6l_plls,
> +};
> +
> +/* Required early for GIC timer. */
> +static const struct eqc_pll eqc_eyeq6h_central_early_plls[] =3D {
> +       { .index =3D 0, .name =3D "pll-cpu", .reg64 =3D 0x00 },
> +};
> +
> +static const struct eqc_match_data eqc_eyeq6h_central_match_data =3D {
> +       .early_pll_count        =3D ARRAY_SIZE(eqc_eyeq6h_central_early_p=
lls),
> +       .early_plls             =3D eqc_eyeq6h_central_early_plls,
> +};
> +
> +/* Required early for UART. */
> +static const struct eqc_pll eqc_eyeq6h_west_early_plls[] =3D {
> +       { .index =3D 0, .name =3D "pll-west", .reg64 =3D 0x00 },
> +};
> +
> +static const struct eqc_match_data eqc_eyeq6h_west_match_data =3D {
> +       .early_pll_count        =3D ARRAY_SIZE(eqc_eyeq6h_west_early_plls=
),
> +       .early_plls             =3D eqc_eyeq6h_west_early_plls,
> +};
> +
> +static const struct eqc_pll eqc_eyeq6h_east_plls[] =3D {
> +       { .index =3D 0, .name =3D "pll-east", .reg64 =3D 0x00 },
> +};
> +
> +static const struct eqc_match_data eqc_eyeq6h_east_match_data =3D {
> +       .pll_count      =3D ARRAY_SIZE(eqc_eyeq6h_east_plls),
> +       .plls           =3D eqc_eyeq6h_east_plls,
> +};
> +
> +static const struct eqc_pll eqc_eyeq6h_south_plls[] =3D {
> +       { .index =3D EQ6HC_SOUTH_PLL_VDI,  .name =3D "pll-vdi",  .reg64 =
=3D 0x00 },
> +       { .index =3D EQ6HC_SOUTH_PLL_PCIE, .name =3D "pll-pcie", .reg64 =
=3D 0x08 },
> +       { .index =3D EQ6HC_SOUTH_PLL_PER,  .name =3D "pll-per",  .reg64 =
=3D 0x10 },
> +       { .index =3D EQ6HC_SOUTH_PLL_ISP,  .name =3D "pll-isp",  .reg64 =
=3D 0x18 },
> +};
> +
> +static const struct eqc_div eqc_eyeq6h_south_divs[] =3D {
> +       {
> +               .index =3D EQ6HC_SOUTH_DIV_EMMC,
> +               .name =3D "div-emmc",
> +               .parent =3D EQ6HC_SOUTH_PLL_PER,
> +               .resource_name =3D "emmc",
> +               .shift =3D 4,
> +               .width =3D 4,
> +       },
> +       {
> +               .index =3D EQ6HC_SOUTH_DIV_OSPI_REF,
> +               .name =3D "div-ospi-ref",
> +               .parent =3D EQ6HC_SOUTH_PLL_PER,
> +               .resource_name =3D "ospi",
> +               .shift =3D 4,
> +               .width =3D 4,
> +       },
> +       {
> +               .index =3D EQ6HC_SOUTH_DIV_OSPI_SYS,
> +               .name =3D "div-ospi-sys",
> +               .parent =3D EQ6HC_SOUTH_PLL_PER,
> +               .resource_name =3D "ospi",
> +               .shift =3D 8,
> +               .width =3D 1,
> +       },
> +       {
> +               .index =3D EQ6HC_SOUTH_DIV_TSU,
> +               .name =3D "div-tsu",
> +               .parent =3D EQ6HC_SOUTH_PLL_PCIE,
> +               .resource_name =3D "tsu",
> +               .shift =3D 4,
> +               .width =3D 8,
> +       },
> +};
> +
> +static const struct eqc_match_data eqc_eyeq6h_south_match_data =3D {
> +       .pll_count      =3D ARRAY_SIZE(eqc_eyeq6h_south_plls),
> +       .plls           =3D eqc_eyeq6h_south_plls,
> +
> +       .div_count      =3D ARRAY_SIZE(eqc_eyeq6h_south_divs),
> +       .divs           =3D eqc_eyeq6h_south_divs,
> +};
> +
> +static const struct eqc_pll eqc_eyeq6h_ddr0_plls[] =3D {
> +       { .index =3D 0, .name =3D "pll-ddr0", .reg64 =3D 0x00 },
> +};
> +
> +static const struct eqc_match_data eqc_eyeq6h_ddr0_match_data =3D {
> +       .pll_count      =3D ARRAY_SIZE(eqc_eyeq6h_ddr0_plls),
> +       .plls           =3D eqc_eyeq6h_ddr0_plls,
> +};
> +
> +static const struct eqc_pll eqc_eyeq6h_ddr1_plls[] =3D {
> +       { .index =3D 0, .name =3D "pll-ddr1", .reg64 =3D 0x00 },
> +};
> +
> +static const struct eqc_match_data eqc_eyeq6h_ddr1_match_data =3D {
> +       .pll_count      =3D ARRAY_SIZE(eqc_eyeq6h_ddr1_plls),
> +       .plls           =3D eqc_eyeq6h_ddr1_plls,
> +};
> +
> +static const struct eqc_pll eqc_eyeq6h_acc_plls[] =3D {
> +       { .index =3D EQ6HC_ACC_PLL_XNN, .name =3D "pll-xnn", .reg64 =3D 0=
x00 },
> +       { .index =3D EQ6HC_ACC_PLL_VMP, .name =3D "pll-vmp", .reg64 =3D 0=
x10 },
> +       { .index =3D EQ6HC_ACC_PLL_PMA, .name =3D "pll-pma", .reg64 =3D 0=
x1C },
> +       { .index =3D EQ6HC_ACC_PLL_MPC, .name =3D "pll-mpc", .reg64 =3D 0=
x28 },
> +       { .index =3D EQ6HC_ACC_PLL_NOC, .name =3D "pll-noc", .reg64 =3D 0=
x30 },
> +};
> +
> +static const struct eqc_match_data eqc_eyeq6h_acc_match_data =3D {
> +       .pll_count      =3D ARRAY_SIZE(eqc_eyeq6h_acc_plls),
> +       .plls           =3D eqc_eyeq6h_acc_plls,
> +};
> +
> +static const struct of_device_id eqc_match_table[] =3D {
> +       { .compatible =3D "mobileye,eyeq5-clk", .data =3D &eqc_eyeq5_matc=
h_data },
> +       { .compatible =3D "mobileye,eyeq6l-clk", .data =3D &eqc_eyeq6l_ma=
tch_data },
> +       { .compatible =3D "mobileye,eyeq6h-central-clk", .data =3D &eqc_e=
yeq6h_central_match_data },
> +       { .compatible =3D "mobileye,eyeq6h-west-clk", .data =3D &eqc_eyeq=
6h_west_match_data },
> +       { .compatible =3D "mobileye,eyeq6h-east-clk", .data =3D &eqc_eyeq=
6h_east_match_data },
> +       { .compatible =3D "mobileye,eyeq6h-south-clk", .data =3D &eqc_eye=
q6h_south_match_data },
> +       { .compatible =3D "mobileye,eyeq6h-ddr0-clk", .data =3D &eqc_eyeq=
6h_ddr0_match_data },
> +       { .compatible =3D "mobileye,eyeq6h-ddr1-clk", .data =3D &eqc_eyeq=
6h_ddr1_match_data },
> +       { .compatible =3D "mobileye,eyeq6h-acc-clk", .data =3D &eqc_eyeq6=
h_acc_match_data },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, eqc_match_table);
> +
> +static struct platform_driver eqc_driver =3D {
> +       .probe =3D eqc_probe,
> +       .driver =3D {
> +               .name =3D "clk-eyeq",
> +               .of_match_table =3D eqc_match_table,
> +       },
> +};
> +builtin_platform_driver(eqc_driver);
> +
> +static void __init eqc_init(struct device_node *np)
> +{
> +       const struct eqc_match_data *data;
> +       unsigned int nb_clks =3D 0;
> +       struct eqc_priv *priv;
> +       unsigned int i;
> +       int ret;
> +
> +       data =3D of_match_node(eqc_match_table, np)->data;
> +
> +       /* No reason to early init this clock provider. Do it at probe. */
> +       if (data->early_pll_count =3D=3D 0)

You can have a different match table for this function then.

> +               return;
> +
> +       priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> +       if (!priv) {
> +               ret =3D -ENOMEM;
> +               goto err;
> +       }
> +
> +       priv->np =3D np;
> +       priv->data =3D data;
> +
> +       nb_clks =3D eqc_compute_clock_count(data);
> +       priv->cells =3D kzalloc(struct_size(priv->cells, hws, nb_clks), G=
FP_KERNEL);
> +       if (!priv->cells) {
> +               ret =3D -ENOMEM;
> +               goto err;
> +       }
> +
> +       priv->cells->num =3D nb_clks;
> +
> +       /*
> +        * Mark non-early clocks as deferred; they'll be registered at pl=
atform
> +        * device probe.
> +        */
> +       for (i =3D 0; i < data->pll_count; i++)
> +               priv->cells->hws[data->plls[i].index] =3D ERR_PTR(-EPROBE=
_DEFER);
> +       for (i =3D 0; i < data->div_count; i++)
> +               priv->cells->hws[data->divs[i].index] =3D ERR_PTR(-EPROBE=
_DEFER);
> +
> +       /*
> +        * We expect named resources if divider clocks are present.
> +        * Else, we only expect one resource.
> +        */

Please avoid named resources. They give the false sense of hope that the
binding can re-order the reg property when that can't be done. Instead,
just index and know which index to use in the driver.

