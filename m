Return-Path: <linux-kernel+bounces-6079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78757819458
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3BE0B24499
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BD43D0CD;
	Tue, 19 Dec 2023 23:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kD6L+0p3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5483D0B6;
	Tue, 19 Dec 2023 23:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93FCC433C8;
	Tue, 19 Dec 2023 23:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703027382;
	bh=vPBEyzu3ir/LB9mTWUqnMazmFgaSH3W28tAD9x4Zj3U=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=kD6L+0p3k6CCHVj660asppTerD2mV7Y/qHdl+hx0jjqZOb1uyg9OpIHVwPNx2eIef
	 QVssNqIDpcUJkLNDLmZkzNODxsbZyimXqv0tBYXpMewckHmKBm4MwB/8kI07/6iYoW
	 UoB07avkSn7ZBs3E1Wv5+mXYGO10Ga5FvWeOefjVQuST4MVPpOePQMrgpACBB/gHYH
	 ft3TrswuADzcjC+WxvGZdmium3FZXviL21GoAR5m+tsotmApZwTKBiDDyIdW+h0ZAw
	 Gw/IaNuzPslMijP9zWryj7aCwmcXyQBirfAYDNYWPfJuEvRRYLDyAmAuiIOf30XqOF
	 VrPGh4EQLgGvw==
Message-ID: <a8f740c7a8c1222d4a42bad588c75e87.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231218-mbly-clk-v1-3-44ce54108f06@bootlin.com>
References: <20231218-mbly-clk-v1-0-44ce54108f06@bootlin.com> <20231218-mbly-clk-v1-3-44ce54108f06@bootlin.com>
Subject: Re: [PATCH 3/5] clk: eyeq5: add controller
From: Stephen Boyd <sboyd@kernel.org>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
To: Conor Dooley <conor+dt@kernel.org>, Gregory CLEMENT <gregory.clement@bootlin.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Date: Tue, 19 Dec 2023 15:09:39 -0800
User-Agent: alot/0.10

Quoting Th=C3=A9o Lebrun (2023-12-18 09:14:18)
> Add the Mobileye EyeQ5 clock controller driver. See the header comment
> for more information on how it works.

"See the header" is like saying "Read the code" which is pretty obvious.
Remove this sentence and tell us why only the PLLs are supported at the
moment or something like that.

> This driver is specific to this
> platform; it might grow to add later support of other platforms from
> Mobileye.
>=20
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> ---
>  MAINTAINERS             |   1 +
>  drivers/clk/Kconfig     |  11 +++
>  drivers/clk/Makefile    |   1 +
>  drivers/clk/clk-eyeq5.c | 211 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 224 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7f04fa760a4d..c75c7de1d507 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14557,6 +14557,7 @@ F:      Documentation/devicetree/bindings/mips/mo=
bileye.yaml
>  F:     arch/mips/boot/dts/mobileye/
>  F:     arch/mips/configs/generic/board-eyeq5.config
>  F:     arch/mips/generic/board-epm5.its.S
> +F:     drivers/clk/clk-eyeq5.c
>  F:     include/dt-bindings/clock/mobileye,eyeq5-clk.h
>  F:     include/dt-bindings/soc/mobileye,eyeq5.h
> =20
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index c30d0d396f7a..84fe0a89b8df 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -218,6 +218,17 @@ config COMMON_CLK_EN7523
>           This driver provides the fixed clocks and gates present on Airo=
ha
>           ARM silicon.
> =20
> +config COMMON_CLK_EYEQ5
> +       bool "Clock driver for the Mobileye EyeQ5 platform"
> +       depends on OF
> +       depends on SOC_EYEQ5 || COMPILE_TEST
> +       default SOC_EYEQ5
> +       help
> +               This drivers provides the fixed clocks found on the Mobil=
eye EyeQ5

s/drivers/driver/

> +               SoC. Its registers live in a shared register region calle=
d OLB.
> +               It provides 10 read-only PLLs derived from the main cryst=
al clock which
> +               must be constant.
> +
>  config COMMON_CLK_FSL_FLEXSPI
>         tristate "Clock driver for FlexSPI on Layerscape SoCs"
>         depends on ARCH_LAYERSCAPE || COMPILE_TEST
> diff --git a/drivers/clk/clk-eyeq5.c b/drivers/clk/clk-eyeq5.c
> new file mode 100644
> index 000000000000..74bcb8cec5c1
> --- /dev/null
> +++ b/drivers/clk/clk-eyeq5.c
> @@ -0,0 +1,211 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PLL clock driver for the Mobileye EyeQ5 platform.
> + *
> + * This controller handles 10 read-only PLLs, all derived from the same =
main
> + * crystal clock. The parent clock is expected to be constant. This driv=
er is
> + * custom to this platform, its registers live in a shared region called=
 OLB.
> + *
> + * We use eq5c_ as prefix, as-in "EyeQ5 Clock", but way shorter.
> + *
> + * Copyright (C) 2023 Mobileye Vision Technologies Ltd.
> + */
> +#include <linux/bits.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clk.h>

Please drop this include.

> +#include <linux/mfd/syscon.h>
> +#include <linux/of_device.h>

Should be mod_devicetable.h or nothing at all.

> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/mobileye,eyeq5-clk.h>
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) "%s: " fmt, __func__

Don't we get this already with dynamic debug?

> +
> +/*
> + * PLL control & status registers, n=3D0..1
> + * 0x02c..0x078
> + */
> +#define OLB_PCSR_CPU(n)                                (0x02C + (n) * 4)=
 /* CPU */
> +#define OLB_PCSR_VMP(n)                                (0x034 + (n) * 4)=
 /* VMP */
> +#define OLB_PCSR_PMA(n)                                (0x03C + (n) * 4)=
 /* PMA */
> +#define OLB_PCSR_VDI(n)                                (0x044 + (n) * 4)=
 /* VDI */
> +#define OLB_PCSR_DDR0(n)                       (0x04C + (n) * 4) /* DDR0=
 */
> +#define OLB_PCSR_PCI(n)                                (0x054 + (n) * 4)=
 /* PCI */
> +#define OLB_PCSR_PER(n)                                (0x05C + (n) * 4)=
 /* PER */
> +#define OLB_PCSR_PMAC(n)                       (0x064 + (n) * 4) /* PMAC=
 */
> +#define OLB_PCSR_MPC(n)                                (0x06c + (n) * 4)=
 /* MPC */
> +#define OLB_PCSR_DDR1(n)                       (0x074 + (n) * 4) /* DDR1=
 */
> +
> +/* In frac mode, it enables fractional noise canceling DAC. Else, no fun=
ction. */
> +#define OLB_PCSR0_DAC_EN                       BIT(0)
> +/* Fractional or integer mode */
> +#define OLB_PCSR0_DSM_EN                       BIT(1)
> +#define OLB_PCSR0_PLL_EN                       BIT(2)
> +/* All clocks output held at 0 */
> +#define OLB_PCSR0_FOUTPOSTDIV_EN               BIT(3)
> +#define OLB_PCSR0_POST_DIV1                    GENMASK(6, 4)
> +#define OLB_PCSR0_POST_DIV2                    GENMASK(9, 7)
> +#define OLB_PCSR0_REF_DIV                      GENMASK(15, 10)
> +#define OLB_PCSR0_INTIN                                GENMASK(27, 16)
> +#define OLB_PCSR0_BYPASS                       BIT(28)
> +/* Bits 30..29 are reserved */
> +#define OLB_PCSR0_PLL_LOCKED                   BIT(31)
> +
> +#define OLB_PCSR1_RESET                                BIT(0)
> +#define OLB_PCSR1_SSGC_DIV                     GENMASK(4, 1)
> +/* Spread amplitude (% =3D 0.1 * SPREAD[4:0]) */
> +#define OLB_PCSR1_SPREAD                       GENMASK(9, 5)
> +#define OLB_PCSR1_DIS_SSCG                     BIT(10)
> +/* Down-spread or center-spread */
> +#define OLB_PCSR1_DOWN_SPREAD                  BIT(11)
> +#define OLB_PCSR1_FRAC_IN                      GENMASK(31, 12)
> +
> +static const struct eq5c_pll {
> +       const char *name;
> +       u32 reg;
> +} eq5c_plls[] =3D {
> +       [EQ5C_PLL_CPU] =3D  { .name =3D "pll-cpu",  .reg =3D OLB_PCSR_CPU=
(0),  },
> +       [EQ5C_PLL_VMP] =3D  { .name =3D "pll-vmp",  .reg =3D OLB_PCSR_VMP=
(0),  },
> +       [EQ5C_PLL_PMA] =3D  { .name =3D "pll-pma",  .reg =3D OLB_PCSR_PMA=
(0),  },
> +       [EQ5C_PLL_VDI] =3D  { .name =3D "pll-vdi",  .reg =3D OLB_PCSR_VDI=
(0),  },
> +       [EQ5C_PLL_DDR0] =3D { .name =3D "pll-ddr0", .reg =3D OLB_PCSR_DDR=
0(0), },
> +       [EQ5C_PLL_PCI] =3D  { .name =3D "pll-pci",  .reg =3D OLB_PCSR_PCI=
(0),  },
> +       [EQ5C_PLL_PER] =3D  { .name =3D "pll-per",  .reg =3D OLB_PCSR_PER=
(0),  },
> +       [EQ5C_PLL_PMAC] =3D { .name =3D "pll-pmac", .reg =3D OLB_PCSR_PMA=
C(0), },
> +       [EQ5C_PLL_MPC] =3D  { .name =3D "pll-mpc",  .reg =3D OLB_PCSR_MPC=
(0),  },
> +       [EQ5C_PLL_DDR1] =3D { .name =3D "pll-ddr1", .reg =3D OLB_PCSR_DDR=
1(0), },
> +};
> +
> +static int eq5c_pll_parse_registers(u32 r0, u32 r1, unsigned long *mult,
> +                                   unsigned long *div, unsigned long *ac=
c)
> +{
> +       if (!mult || !div || !acc)
> +               return -EINVAL;

Is this condition ever true? Please remove.

> +
> +       if (r0 & OLB_PCSR0_BYPASS) {
> +               *mult =3D 1;
> +               *div =3D 1;
> +               *acc =3D 0;
> +               return 0;
> +       }
> +
> +       if (!(r0 & OLB_PCSR0_PLL_LOCKED))
> +               return -EINVAL;
> +
> +       *mult =3D FIELD_GET(OLB_PCSR0_INTIN, r0);
> +       *div =3D FIELD_GET(OLB_PCSR0_REF_DIV, r0);
> +       if (r0 & OLB_PCSR0_FOUTPOSTDIV_EN)
> +               *div *=3D FIELD_GET(OLB_PCSR0_POST_DIV1, r0) *
> +                       FIELD_GET(OLB_PCSR0_POST_DIV2, r0);
> +
> +       /* Fractional mode, in 2^20 (0x100000) parts. */
> +       if (r0 & OLB_PCSR0_DSM_EN) {
> +               *div *=3D 0x100000;
> +               *mult =3D *mult * 0x100000 + FIELD_GET(OLB_PCSR1_FRAC_IN,=
 r1);
> +       }
> +
> +       if (!*mult || !*div)
> +               return -EINVAL;
> +
> +       /* Spread spectrum. */
> +       if (!(r1 & (OLB_PCSR1_RESET | OLB_PCSR1_DIS_SSCG))) {
> +               /*
> +                * Spread is 1/1000 parts of frequency, accuracy is half =
of
> +                * that. To get accuracy, convert to ppb (parts per billi=
on).
> +                */
> +               u32 spread =3D FIELD_GET(OLB_PCSR1_SPREAD, r1);
> +               *acc =3D spread * 500000;
> +               if (r1 & OLB_PCSR1_DOWN_SPREAD) {
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
> +static void eq5c_init(struct device_node *np)
> +{
> +       struct device_node *parent_np =3D of_get_parent(np);
> +       struct clk_hw_onecell_data *data;
> +       unsigned long parent_clk_rate;
> +       struct clk_hw *parent_clk_hw;
> +       struct clk *parent_clk;
> +       struct regmap *olb;
> +       int i;
> +
> +       data =3D kzalloc(struct_size(data, hws, ARRAY_SIZE(eq5c_plls)), G=
FP_KERNEL);
> +       if (!data)
> +               return;
> +
> +       data->num =3D ARRAY_SIZE(eq5c_plls);
> +
> +       /*
> +        * TODO: currently, if OLB is not available, we log an error and =
early
> +        * return. We might want to change this behavior and assume all c=
locks
> +        * are in bypass mode; that is what is being done in the vendor d=
river.
> +        *
> +        * It is still unclear if there are valid situations where the OLB
> +        * region would be inaccessible.
> +        */
> +       olb =3D ERR_PTR(-ENODEV);
> +       if (parent_np)
> +               olb =3D syscon_node_to_regmap(parent_np);
> +       if (IS_ERR(olb))
> +               olb =3D syscon_regmap_lookup_by_phandle(np, "mobileye,olb=
");
> +       if (IS_ERR(olb)) {
> +               pr_err("failed getting regmap: %ld\n", PTR_ERR(olb));
> +               return;
> +       }
> +
> +       parent_clk =3D of_clk_get_by_name(np, "ref");
> +       if (IS_ERR_OR_NULL(parent_clk)) {
> +               pr_err("no parent clock found\n");
> +               return;
> +       }
> +       parent_clk_hw =3D __clk_get_hw(parent_clk);
> +       parent_clk_rate =3D clk_get_rate(parent_clk);
> +       clk_put(parent_clk);

No. Don't get the parent clk in a clk provider. Tell the clk framework
which clk is the parent with clk_parent_data.

> +
> +       for (i =3D 0; i < ARRAY_SIZE(eq5c_plls); i++) {
> +               const struct eq5c_pll *pll =3D &eq5c_plls[i];
> +               unsigned long mult, div, acc;
> +               u32 r0, r1;
> +               int ret;
> +
> +               regmap_read(olb, pll->reg, &r0);
> +               regmap_read(olb, pll->reg + sizeof(r0), &r1);
> +
> +               ret =3D eq5c_pll_parse_registers(r0, r1, &mult, &div, &ac=
c);
> +               if (ret) {
> +                       pr_warn("failed parsing state of %s\n", pll->name=
);
> +                       continue;
> +               }
> +
> +               /* We use fixed_rate and not fixed_factor because the lat=
ter
> +                * does not allow reporting accuracy. The alternative is =
to
> +                * create a custom clk implementation but that adds too m=
any
> +                * lines to the kernel for not much benefit; our parent c=
lock
> +                * rate won't change anyway.

This comment complains about the lack of something. Add what you need
please and get rid of this comment.

> +                */
> +               data->hws[i] =3D clk_hw_register_fixed_rate_with_accuracy=
_parent_hw(
> +                               NULL, pll->name, parent_clk_hw, 0,
> +                               parent_clk_rate * mult / div, acc);
> +               if (IS_ERR_OR_NULL(data->hws[i])) {

NULL is not an error.

> +                       pr_err("failed registering %s: %ld\n",
> +                              pll->name, PTR_ERR(data->hws[i]));
> +                       data->hws[i] =3D ERR_PTR(-ENOENT);
> +               }
> +       }
> +
> +       of_clk_add_hw_provider(np, of_clk_hw_onecell_get, data);
> +}
> +
> +CLK_OF_DECLARE_DRIVER(eq5c, "mobileye,eyeq5-clk", eq5c_init);

Please use a platform driver.

