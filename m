Return-Path: <linux-kernel+bounces-139735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BC48A06FC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FB84B234FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6C713BC18;
	Thu, 11 Apr 2024 04:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+i3IQIX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D797813B787;
	Thu, 11 Apr 2024 04:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712808691; cv=none; b=YxhM8n4n8qa24TcRBwCZJ+rUlYFcv3QGGCmdtRzfGXd0VMjL8URKzOlKFy7PbauPUmY48f5RKZdxQgbN8QX3BQXJ3qAspHAPvYDo0rRHUV+mKc1VxiwfMu6m2QEreLQ++9ahTGNr8IJCqvOqR0JFAaxOLvgVBHr4EUa+OgG4VN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712808691; c=relaxed/simple;
	bh=awR8P7j8pIQt+f+mTDWDqr3dy0CO4ry1klDrOY2ehYA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=F0hfIkrB2o1t/IJT0GwpTaD6opLOBAhCi7KDMVriqJMWMFr0SHk4evSUsbOIPIRg/GuFYaqpDRy83LuyLSHNUIhtLJ2dmj01tVZqsTJmRSdY6oMtXyYbKmwUxyWzSuZ+nqmAPjF9nFn0VEzY4DvsiZXccQk1dkMfogBZO5wTYVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+i3IQIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B46C433F1;
	Thu, 11 Apr 2024 04:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712808690;
	bh=awR8P7j8pIQt+f+mTDWDqr3dy0CO4ry1klDrOY2ehYA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=n+i3IQIX6r9nJrtn7HcrRjlZu9ks+MZ5kLyN8QoXkwSdiMM4IyRGZXMrpyVhPFsDa
	 UeATvFIWYSILMpYaCrUWWDcjmbG0VMHqdcbGSeu0k09a0+NTu6Q2gevl0KW9fuYfR1
	 lWIOMyE0jpRUR6TQVzxuRDCNy6aCp4QGvfXMo6v0/Tckt3xmIJI4zEVbxsicJYIvn7
	 vcVwZHGEkkS5+AjzBNS2UEwnAvPwbLj5u8gQ8KhpNhnUwta6rGp8ft5jYUQ5yfmmQI
	 Jg9b8d72EFX5owazf7xiYFOCLEpIeeusaZgu6KVrjroz2gXpAfKXOg5zAODZ48JkZo
	 UxEfl4VH3JVRg==
Message-ID: <433e01f22ce5472aeb28cf0182d951bd.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <816122e9f22ddd9927e81e627be7f4683ba5c9e8.1711692169.git.unicorn_wang@outlook.com>
References: <cover.1711692169.git.unicorn_wang@outlook.com> <816122e9f22ddd9927e81e627be7f4683ba5c9e8.1711692169.git.unicorn_wang@outlook.com>
Subject: Re: [PATCH v13 4/5] clk: sophgo: Add SG2042 clock driver
From: Stephen Boyd <sboyd@kernel.org>
Cc: Chen Wang <unicorn_wang@outlook.com>
To: Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org, devicetree@vger.kernel.org, guoren@kernel.org, haijiao.liu@sophgo.com, inochiama@outlook.com, jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com, richardcochran@gmail.com, robh+dt@kernel.org, samuel.holland@sifive.com, xiaoguang.xing@sophgo.com
Date: Wed, 10 Apr 2024 21:11:26 -0700
User-Agent: alot/0.10

Quoting Chen Wang (2024-03-28 23:21:40)
> From: Chen Wang <unicorn_wang@outlook.com>
>=20
> Add a driver for the SOPHGO SG2042 clocks.
>=20
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  drivers/clk/Kconfig                    |    1 +
>  drivers/clk/Makefile                   |    1 +
>  drivers/clk/sophgo/Kconfig             |    7 +
>  drivers/clk/sophgo/Makefile            |    2 +
>  drivers/clk/sophgo/clk-sophgo-sg2042.c | 1410 ++++++++++++++++++++++++
>  drivers/clk/sophgo/clk-sophgo-sg2042.h |  216 ++++

Inline the contents of this file into the driver C file.

> diff --git a/drivers/clk/sophgo/clk-sophgo-sg2042.c b/drivers/clk/sophgo/=
clk-sophgo-sg2042.c
> new file mode 100644
> index 000000000000..7b468e7299ae
> --- /dev/null
> +++ b/drivers/clk/sophgo/clk-sophgo-sg2042.c
> @@ -0,0 +1,1410 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Sophgo SG2042 Clock Generator Driver
> + *
> + * Copyright (C) 2024 Sophgo Technology Inc. All rights reserved.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/iopoll.h>
> +#include <linux/platform_device.h>

Need include for BIT macro, io.h for readl/writel, do_div() header,
ARRAY_SIZE, etc. please check.

> +
> +/*
> + * The clock of SG2042 is composed of three parts.
> + * The registers of these three parts of the clock are scattered in three
> + * different memory address spaces:
> + * - pll clocks
> + * - gate clocks for RP subsystem
> + * - div/mux, and gate clocks working for other subsystem than RP subsys=
tem
> + */
> +#include <dt-bindings/clock/sophgo,sg2042-pll.h>
> +#include <dt-bindings/clock/sophgo,sg2042-rpgate.h>
> +#include <dt-bindings/clock/sophgo,sg2042-clkgen.h>
> +
> +#include "clk-sophgo-sg2042.h"
> +
> +#define KHZ 1000UL
> +#define MHZ (KHZ * KHZ)
> +
> +#define REFDIV_MIN 1
> +#define REFDIV_MAX 63
> +#define FBDIV_MIN 16
> +#define FBDIV_MAX 320
> +
> +#define PLL_FREF_SG2042 (25 * MHZ)
> +
> +#define PLL_FOUTPOSTDIV_MIN (16 * MHZ)
> +#define PLL_FOUTPOSTDIV_MAX (3200 * MHZ)
> +
> +#define PLL_FOUTVCO_MIN (800 * MHZ)
> +#define PLL_FOUTVCO_MAX (3200 * MHZ)
> +
> +struct sg2042_pll_ctrl {
> +       unsigned long freq;
> +       unsigned int fbdiv;
> +       unsigned int postdiv1;
> +       unsigned int postdiv2;
> +       unsigned int refdiv;
> +};
> +
> +#define PLLCTRL_FBDIV_SHIFT    16
> +#define PLLCTRL_FBDIV_MASK     (GENMASK(27, 16) >> PLLCTRL_FBDIV_SHIFT)
> +#define PLLCTRL_POSTDIV2_SHIFT 12
> +#define PLLCTRL_POSTDIV2_MASK  (GENMASK(14, 12) >> PLLCTRL_POSTDIV2_SHIF=
T)
> +#define PLLCTRL_POSTDIV1_SHIFT 8
> +#define PLLCTRL_POSTDIV1_MASK  (GENMASK(10, 8) >> PLLCTRL_POSTDIV1_SHIFT)
> +#define PLLCTRL_REFDIV_SHIFT   0
> +#define PLLCTRL_REFDIV_MASK    (GENMASK(5, 0) >> PLLCTRL_REFDIV_SHIFT)
> +
> +static inline u32 sg2042_pll_ctrl_encode(struct sg2042_pll_ctrl *ctrl)
> +{
> +       return ((ctrl->fbdiv & PLLCTRL_FBDIV_MASK) << PLLCTRL_FBDIV_SHIFT=
) |
> +              ((ctrl->postdiv2 & PLLCTRL_POSTDIV2_MASK) << PLLCTRL_POSTD=
IV2_SHIFT) |
> +              ((ctrl->postdiv1 & PLLCTRL_POSTDIV1_MASK) << PLLCTRL_POSTD=
IV1_SHIFT) |
> +              ((ctrl->refdiv & PLLCTRL_REFDIV_MASK) << PLLCTRL_REFDIV_SH=
IFT);
> +}
> +
> +static inline void sg2042_pll_ctrl_decode(unsigned int reg_value,
> +                                         struct sg2042_pll_ctrl *ctrl)
> +{
> +       ctrl->fbdiv =3D (reg_value >> PLLCTRL_FBDIV_SHIFT) & PLLCTRL_FBDI=
V_MASK;
> +       ctrl->refdiv =3D (reg_value >> PLLCTRL_REFDIV_SHIFT) & PLLCTRL_RE=
FDIV_MASK;
> +       ctrl->postdiv1 =3D (reg_value >> PLLCTRL_POSTDIV1_SHIFT) & PLLCTR=
L_POSTDIV1_MASK;
> +       ctrl->postdiv2 =3D (reg_value >> PLLCTRL_POSTDIV2_SHIFT) & PLLCTR=
L_POSTDIV2_MASK;
> +}
> +
> +static inline int sg2042_pll_enable(struct sg2042_pll_clock *pll, bool e=
n)
> +{
> +       unsigned int value =3D 0;

Don't need to initialize value? Also, type should be u32.

> +
> +       if (en) {
> +               /* wait pll lock */
> +               if (readl_poll_timeout_atomic(pll->base + pll->offset_sta=
tus,
> +                                             value,
> +                                             ((value >> pll->shift_statu=
s_lock) & 0x1),
> +                                             0,
> +                                             100000))
> +                       pr_warn("%s not locked\n", pll->hw.init->name);
> +
> +               /* wait pll updating */
> +               if (readl_poll_timeout_atomic(pll->base + pll->offset_sta=
tus,
> +                                             value,
> +                                             !((value >> pll->shift_stat=
us_updating) & 0x1),
> +                                             0,
> +                                             100000))
> +                       pr_warn("%s still updating\n", pll->hw.init->name=
);
> +
> +               /* enable pll */
> +               value =3D readl(pll->base + pll->offset_enable);
> +               writel(value | (1 << pll->shift_enable), pll->base + pll-=
>offset_enable);
> +       } else {
> +               /* disable pll */
> +               value =3D readl(pll->base + pll->offset_enable);
> +               writel(value & (~(1 << pll->shift_enable)), pll->base + p=
ll->offset_enable);
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * @reg_value: current register value
> + * @parent_rate: parent frequency
> + *
> + * This function is used to calculate below "rate" in equation
> + * rate =3D (parent_rate/REFDIV) x FBDIV/POSTDIV1/POSTDIV2
> + *      =3D (parent_rate x FBDIV) / (REFDIV x POSTDIV1 x POSTDIV2)
> + */
> +static unsigned long sg2042_pll_recalc_rate(unsigned int reg_value,
> +                                           unsigned long parent_rate)
> +{
> +       struct sg2042_pll_ctrl ctrl_table;
> +       u64 rate, numerator, denominator;
> +
> +       sg2042_pll_ctrl_decode(reg_value, &ctrl_table);
> +
> +       numerator =3D parent_rate * ctrl_table.fbdiv;
> +       denominator =3D ctrl_table.refdiv * ctrl_table.postdiv1 * ctrl_ta=
ble.postdiv2;
> +       do_div(numerator, denominator);
> +       rate =3D numerator;
> +
> +       return rate;

return numerator

> +}
> +
> +/*
> + * Based on input rate/prate/fbdiv/refdiv, look up the postdiv1_2 table
> + * to get the closest postdiiv combination.
> + * postdiv1_2 contains all the possible combination lists of POSTDIV1 an=
d POSTDIV2
> + * for example:
> + * postdiv1_2[0] =3D {2, 4, 8}, where div1 =3D 2, div2 =3D 4 , div1 * di=
v2 =3D 8
> + *
> + * See TRM:
> + * FOUTPOSTDIV =3D FREF * FBDIV / REFDIV / (POSTDIV1 * POSTDIV2)
> + * So we get following formula to get POSTDIV1 and POSTDIV2:
> + * POSTDIV =3D (prate/REFDIV) x FBDIV/rate
> + * above POSTDIV =3D POSTDIV1*POSTDIV2
> + *
> + * @rate: FOUTPOSTDIV
> + * @prate: parent rate, i.e. FREF
> + * @fbdiv: FBDIV
> + * @refdiv: REFDIV
> + * @postdiv1: POSTDIV1, output
> + * @postdiv2: POSTDIV2, output
> + */
> +static int sg2042_pll_get_postdiv_1_2(unsigned long rate,
> +                                     unsigned long prate,
> +                                     unsigned int fbdiv,
> +                                     unsigned int refdiv,
> +                                     unsigned int *postdiv1,
> +                                     unsigned int *postdiv2)
> +{
> +       int index;
> +       u64 tmp0;
> +
> +       /* POSTDIV_RESULT_INDEX point to 3rd element in the array postdiv=
1_2 */
> +       #define POSTDIV_RESULT_INDEX    2
> +
> +       static int postdiv1_2[][3] =3D {

const

> +               {2, 4,  8}, {3, 3,  9}, {2, 5, 10}, {2, 6, 12},
> +               {2, 7, 14}, {3, 5, 15}, {4, 4, 16}, {3, 6, 18},
> +               {4, 5, 20}, {3, 7, 21}, {4, 6, 24}, {5, 5, 25},
> +               {4, 7, 28}, {5, 6, 30}, {5, 7, 35}, {6, 6, 36},
> +               {6, 7, 42}, {7, 7, 49}
> +       };
> +
> +       /* prate/REFDIV and result save to tmp0 */
> +       tmp0 =3D prate;
> +       do_div(tmp0, refdiv);
> +
> +       /* ((prate/REFDIV) x FBDIV) and result save to tmp0 */
> +       tmp0 *=3D fbdiv;
> +
> +       /* ((prate/REFDIV) x FBDIV)/rate and result save to tmp0 */
> +       do_div(tmp0, rate);
> +
> +       /* tmp0 is POSTDIV1*POSTDIV2, now we calculate div1 and div2 valu=
e */
> +       if (tmp0 <=3D 7) {
> +               /* (div1 * div2) <=3D 7, no need to use array search */
> +               *postdiv1 =3D tmp0;
> +               *postdiv2 =3D 1;
> +               return 0;
> +       }
> +
> +       /* (div1 * div2) > 7, use array search */
> +       for (index =3D 0; index < ARRAY_SIZE(postdiv1_2); index++) {
> +               if (tmp0 > postdiv1_2[index][POSTDIV_RESULT_INDEX]) {
> +                       continue;
> +               } else {
> +                       /* found it */
> +                       *postdiv1 =3D postdiv1_2[index][1];
> +                       *postdiv2 =3D postdiv1_2[index][0];
> +                       return 0;
> +               }
> +       }
> +       pr_warn("%s can not find in postdiv array!\n", __func__);
> +       return -EINVAL;
> +}
> +
> +/*
> + * Based on the given FOUTPISTDIV and the input FREF to calculate
> + * the REFDIV/FBDIV/PSTDIV1/POSTDIV2 combination for pllctrl register.
> + * @req_rate: expected output clock rate, i.e. FOUTPISTDIV
> + * @parent_rate: input parent clock rate, i.e. FREF
> + * @best: output to hold calculated combination of REFDIV/FBDIV/PSTDIV1/=
POSTDIV2
> + */
> +static int sg2042_get_pll_ctl_setting(struct sg2042_pll_ctrl *best,
> +                                     unsigned long req_rate,
> +                                     unsigned long parent_rate)
> +{
> +       int ret;
> +       unsigned int fbdiv, refdiv, postdiv1, postdiv2;
> +       unsigned long foutpostdiv;
> +       u64 tmp;
> +       u64 foutvco;
> +
> +       if (parent_rate !=3D PLL_FREF_SG2042) {
> +               pr_err("INVALID FREF: %ld\n", parent_rate);
> +               return -EINVAL;
> +       }
> +
> +       if (req_rate < PLL_FOUTPOSTDIV_MIN || req_rate > PLL_FOUTPOSTDIV_=
MAX) {
> +               pr_alert("INVALID FOUTPOSTDIV: %ld\n", req_rate);
> +               return -EINVAL;
> +       }
> +
> +       memset(best, 0, sizeof(struct sg2042_pll_ctrl));
> +
> +       for (refdiv =3D REFDIV_MIN; refdiv < REFDIV_MAX + 1; refdiv++) {
> +               /* required by hardware: FREF/REFDIV must > 10 */
> +               tmp =3D parent_rate;
> +               do_div(tmp, refdiv);
> +               if (tmp <=3D 10)
> +                       continue;
> +
> +               for (fbdiv =3D FBDIV_MIN; fbdiv < FBDIV_MAX + 1; fbdiv++)=
 {
> +                       /*
> +                        * FOUTVCO =3D FREF*FBDIV/REFDIV validation
> +                        * required by hardware, FOUTVCO must [800MHz, 32=
00MHz]
> +                        */
> +                       foutvco =3D parent_rate * fbdiv;
> +                       do_div(foutvco, refdiv);
> +                       if (foutvco < PLL_FOUTVCO_MIN || foutvco > PLL_FO=
UTVCO_MAX)
> +                               continue;
> +
> +                       ret =3D sg2042_pll_get_postdiv_1_2(req_rate, pare=
nt_rate,
> +                                                        fbdiv, refdiv,
> +                                                        &postdiv1, &post=
div2);
> +                       if (ret)
> +                               continue;
> +
> +                       /*
> +                        * FOUTPOSTDIV =3D FREF*FBDIV/REFDIV/(POSTDIV1*PO=
STDIV2)
> +                        *             =3D FOUTVCO/(POSTDIV1*POSTDIV2)
> +                        */
> +                       tmp =3D foutvco;
> +                       do_div(tmp, (postdiv1 * postdiv2));
> +                       foutpostdiv =3D (unsigned long)tmp;
> +                       /* Iterative to approach the expected value */
> +                       if (abs_diff(foutpostdiv, req_rate) < abs_diff(be=
st->freq, req_rate)) {
> +                               best->freq =3D foutpostdiv;
> +                               best->refdiv =3D refdiv;
> +                               best->fbdiv =3D fbdiv;
> +                               best->postdiv1 =3D postdiv1;
> +                               best->postdiv2 =3D postdiv2;
> +                               if (foutpostdiv =3D=3D req_rate)
> +                                       return 0;
> +                       }
> +                       continue;
> +               }
> +       }
> +
> +       if (best->freq =3D=3D 0)
> +               return -EINVAL;
> +       else
> +               return 0;
> +}
> +
> +/*
> + * @hw: ccf use to hook get sg2042_pll_clock
> + * @parent_rate: parent rate
> + *
> + * The is function will be called through clk_get_rate
> + * and return current rate after decoding reg value
> + */
> +static unsigned long sg2042_clk_pll_recalc_rate(struct clk_hw *hw,
> +                                               unsigned long parent_rate)
> +{
> +       unsigned int value;
> +       unsigned long rate;
> +       struct sg2042_pll_clock *pll =3D to_sg2042_pll_clk(hw);
> +
> +       value =3D readl(pll->base + pll->offset_ctrl);
> +       rate =3D sg2042_pll_recalc_rate(value, parent_rate);
> +
> +       pr_debug("--> %s: pll_recalc_rate: val =3D %ld\n",
> +                clk_hw_get_name(hw), rate);
> +       return rate;
> +}
> +
> +static long sg2042_clk_pll_round_rate(struct clk_hw *hw,
> +                                     unsigned long req_rate,
> +                                     unsigned long *prate)
> +{
> +       unsigned int value;
> +       struct sg2042_pll_ctrl pctrl_table;
> +       long proper_rate;
> +       int ret;
> +
> +       ret =3D sg2042_get_pll_ctl_setting(&pctrl_table, req_rate, *prate=
);
> +       if (ret) {
> +               proper_rate =3D 0;
> +               goto out;
> +       }
> +
> +       value =3D sg2042_pll_ctrl_encode(&pctrl_table);
> +       proper_rate =3D (long)sg2042_pll_recalc_rate(value, *prate);
> +
> +out:
> +       pr_debug("--> %s: pll_round_rate: val =3D %ld\n",
> +                clk_hw_get_name(hw), proper_rate);
> +       return proper_rate;
> +}
> +
> +static int sg2042_clk_pll_determine_rate(struct clk_hw *hw,
> +                                        struct clk_rate_request *req)
> +{
> +       req->rate =3D sg2042_clk_pll_round_rate(hw, min(req->rate, req->m=
ax_rate),
> +                                             &req->best_parent_rate);
> +       pr_debug("--> %s: pll_determine_rate: val =3D %ld\n",
> +                clk_hw_get_name(hw), req->rate);
> +       return 0;
> +}
> +
> +static int sg2042_clk_pll_set_rate(struct clk_hw *hw,
> +                                  unsigned long rate,
> +                                  unsigned long parent_rate)
> +{
> +       unsigned long flags;
> +       unsigned int value;
> +       int ret =3D 0;
> +       struct sg2042_pll_ctrl pctrl_table;
> +       struct sg2042_pll_clock *pll =3D to_sg2042_pll_clk(hw);
> +
> +       spin_lock_irqsave(pll->lock, flags);
> +       if (sg2042_pll_enable(pll, 0)) {
> +               pr_warn("Can't disable pll(%s), status error\n", pll->hw.=
init->name);
> +               goto out;
> +       }
> +       ret =3D sg2042_get_pll_ctl_setting(&pctrl_table, rate, parent_rat=
e);
> +       if (ret) {
> +               pr_warn("%s: Can't find a proper pll setting\n", pll->hw.=
init->name);
> +               goto out2;
> +       }
> +
> +       value =3D sg2042_pll_ctrl_encode(&pctrl_table);
> +
> +       /* write the value to top register */
> +       writel(value, pll->base + pll->offset_ctrl);
> +
> +out2:
> +       sg2042_pll_enable(pll, 1);
> +out:
> +       spin_unlock_irqrestore(pll->lock, flags);
> +
> +       pr_debug("--> %s: pll_set_rate: val =3D 0x%x\n",
> +                clk_hw_get_name(hw), value);
> +       return ret;
> +}
> +
> +static const struct clk_ops sg2042_clk_pll_ops =3D {
> +       .recalc_rate =3D sg2042_clk_pll_recalc_rate,
> +       .round_rate =3D sg2042_clk_pll_round_rate,
> +       .determine_rate =3D sg2042_clk_pll_determine_rate,
> +       .set_rate =3D sg2042_clk_pll_set_rate,
> +};
> +
> +static const struct clk_ops sg2042_clk_pll_ro_ops =3D {
> +       .recalc_rate =3D sg2042_clk_pll_recalc_rate,
> +       .round_rate =3D sg2042_clk_pll_round_rate,
> +};
> +
> +static unsigned long sg2042_clk_divider_recalc_rate(struct clk_hw *hw,
> +                                                   unsigned long parent_=
rate)
> +{
> +       struct sg2042_divider_clock *divider =3D to_sg2042_clk_divider(hw=
);
> +       unsigned int val;
> +       unsigned long ret_rate;
> +
> +       if (!(readl(divider->reg) & BIT(3))) {

What is bit 3? Please make a define.

> +               val =3D (int)(divider->initval);
> +       } else {
> +               val =3D readl(divider->reg) >> divider->shift;
> +               val &=3D clk_div_mask(divider->width);
> +       }
> +
> +       ret_rate =3D divider_recalc_rate(hw, parent_rate, val, NULL,
> +                                      divider->div_flags, divider->width=
);
> +
> +       pr_debug("--> %s: divider_recalc_rate: ret_rate =3D %ld\n",
> +                clk_hw_get_name(hw), ret_rate);
> +       return ret_rate;
> +}
> +
> +static long sg2042_clk_divider_round_rate(struct clk_hw *hw,
> +                                         unsigned long rate,
> +                                         unsigned long *prate)
> +{
> +       int bestdiv;
> +       unsigned long ret_rate;
> +       struct sg2042_divider_clock *divider =3D to_sg2042_clk_divider(hw=
);
> +
> +       /* if read only, just return current value */
> +       if (divider->div_flags & CLK_DIVIDER_READ_ONLY) {
> +               if (!(readl(divider->reg) & BIT(3))) {
> +                       bestdiv =3D (int)(divider->initval);
> +               } else {
> +                       bestdiv =3D readl(divider->reg) >> divider->shift;
> +                       bestdiv &=3D clk_div_mask(divider->width);
> +               }
> +               ret_rate =3D DIV_ROUND_UP_ULL((u64)*prate, bestdiv);
> +       } else {
> +               ret_rate =3D divider_round_rate(hw, rate, prate, NULL,
> +                                             divider->width, divider->di=
v_flags);
> +       }
> +
> +       pr_debug("--> %s: divider_round_rate: val =3D %ld\n",
> +                clk_hw_get_name(hw), ret_rate);
> +       return ret_rate;
> +}
> +
> +static int sg2042_clk_divider_set_rate(struct clk_hw *hw,
> +                                      unsigned long rate,
> +                                      unsigned long parent_rate)
> +{
> +       unsigned int value;
> +       unsigned int val, val2;
> +       unsigned long flags =3D 0;
> +       struct sg2042_divider_clock *divider =3D to_sg2042_clk_divider(hw=
);
> +
> +       value =3D divider_get_val(rate, parent_rate, NULL,
> +                               divider->width, divider->div_flags);
> +
> +       if (divider->lock)
> +               spin_lock_irqsave(divider->lock, flags);
> +       else
> +               __acquire(divider->lock);
> +
> +       /*
> +        * The sequence of clock frequency modification is:
> +        * Assert to reset divider.
> +        * Modify the value of Clock Divide Factor (and High Wide if need=
ed).
> +        * De-assert to restore divided clock with new frequency.
> +        */
> +       val =3D readl(divider->reg);
> +
> +       /* assert */
> +       val &=3D ~0x1;
> +       writel(val, divider->reg);
> +
> +       if (divider->div_flags & CLK_DIVIDER_HIWORD_MASK) {
> +               val =3D clk_div_mask(divider->width) << (divider->shift +=
 16);
> +       } else {
> +               val =3D readl(divider->reg);
> +               val &=3D ~(clk_div_mask(divider->width) << divider->shift=
);
> +       }
> +       val |=3D value << divider->shift;
> +       val |=3D 1 << 3;

Make a define for bit 3 and bit 0 please.

> +       writel(val, divider->reg);
> +       val2 =3D val;
> +
> +       /* de-assert */
> +       val |=3D 1;
> +       writel(val, divider->reg);
> +
> +       if (divider->lock)
> +               spin_unlock_irqrestore(divider->lock, flags);
> +       else
> +               __release(divider->lock);
> +
> +       pr_debug("--> %s: divider_set_rate: register val =3D 0x%x\n",
> +                clk_hw_get_name(hw), val2);
> +       return 0;
> +}
> +
> +static const struct clk_ops sg2042_clk_divider_ops =3D {
> +       .recalc_rate =3D sg2042_clk_divider_recalc_rate,
> +       .round_rate =3D sg2042_clk_divider_round_rate,
> +       .set_rate =3D sg2042_clk_divider_set_rate,
> +};
> +
> +static const struct clk_ops sg2042_clk_divider_ro_ops =3D {
> +       .recalc_rate =3D sg2042_clk_divider_recalc_rate,
> +       .round_rate =3D sg2042_clk_divider_round_rate,
> +};
> +
> +#define SG2042_PLL(_id, _name, _parent_name, _r_stat, _r_enable, _r_ctrl=
, _shift) \
> +       {                                                               \
> +               .hw.init =3D CLK_HW_INIT(                                =
 \
> +                               _name,                                  \
> +                               _parent_name,                           \
> +                               &sg2042_clk_pll_ops,                    \
> +                               CLK_GET_RATE_NOCACHE | CLK_GET_ACCURACY_N=
OCACHE),\
> +               .id =3D _id,                                             =
 \
> +               .offset_ctrl =3D _r_ctrl,                                =
 \
> +               .offset_status =3D _r_stat,                              =
 \
> +               .offset_enable =3D _r_enable,                            =
 \
> +               .shift_status_lock =3D 8 + (_shift),                     =
 \
> +               .shift_status_updating =3D _shift,                       =
 \
> +               .shift_enable =3D _shift,                                =
 \
> +       }
> +
> +#define SG2042_PLL_RO(_id, _name, _parent_name, _r_stat, _r_enable, _r_c=
trl, _shift) \
> +       {                                                               \
> +               .hw.init =3D CLK_HW_INIT(                                =
 \
> +                               _name,                                  \
> +                               _parent_name,                           \
> +                               &sg2042_clk_pll_ro_ops,                 \
> +                               CLK_GET_RATE_NOCACHE | CLK_GET_ACCURACY_N=
OCACHE),\
> +               .id =3D _id,                                             =
 \
> +               .offset_ctrl =3D _r_ctrl,                                =
 \
> +               .offset_status =3D _r_stat,                              =
 \
> +               .offset_enable =3D _r_enable,                            =
 \
> +               .shift_status_lock =3D 8 + (_shift),                     =
 \
> +               .shift_status_updating =3D _shift,                       =
 \
> +               .shift_enable =3D _shift,                                =
 \
> +       }
> +
> +static struct sg2042_pll_clock sg2042_pll_clks[] =3D {
> +       SG2042_PLL(MPLL_CLK, "mpll_clock", "cgi_main",
> +                  R_PLL_STAT, R_PLL_CLKEN_CONTROL, R_MPLL_CONTROL, 0),
> +       SG2042_PLL_RO(FPLL_CLK, "fpll_clock", "cgi_main",
> +                     R_PLL_STAT, R_PLL_CLKEN_CONTROL, R_FPLL_CONTROL, 3),
> +       SG2042_PLL_RO(DPLL0_CLK, "dpll0_clock", "cgi_dpll0",
> +                     R_PLL_STAT, R_PLL_CLKEN_CONTROL, R_DPLL0_CONTROL, 4=
),
> +       SG2042_PLL_RO(DPLL1_CLK, "dpll1_clock", "cgi_dpll1",
> +                     R_PLL_STAT, R_PLL_CLKEN_CONTROL, R_DPLL1_CONTROL, 5=
),
> +};
> +
> +#define SG2042_DIV(_id, _name, _parent_name,                           \
> +                 _r_ctrl, _shift, _width,                              \
> +                 _div_flag, _initval) {                                \
> +               .hw.init =3D CLK_HW_INIT(                                =
 \
> +                               _name,                                  \
> +                               _parent_name,                           \
> +                               &sg2042_clk_divider_ops,                \
> +                               0),                                     \
> +               .id =3D _id,                                             =
 \
> +               .offset_ctrl =3D _r_ctrl,                                =
 \
> +               .shift =3D _shift,                                       =
 \
> +               .width =3D _width,                                       =
 \
> +               .div_flags =3D _div_flag,                                =
 \
> +               .initval =3D _initval,                                   =
 \
> +       }
> +
> +#define SG2042_DIV_RO(_id, _name, _parent_name,                         =
       \
> +                 _r_ctrl, _shift, _width,                              \
> +                 _div_flag, _initval) {                                \
> +               .hw.init =3D CLK_HW_INIT(                                =
 \
> +                               _name,                                  \
> +                               _parent_name,                           \
> +                               &sg2042_clk_divider_ro_ops,             \
> +                               0),                                     \
> +               .id =3D _id,                                             =
 \
> +               .offset_ctrl =3D _r_ctrl,                                =
 \
> +               .shift =3D _shift,                                       =
 \
> +               .width =3D _width,                                       =
 \
> +               .div_flags =3D (_div_flag) | CLK_DIVIDER_READ_ONLY,      =
 \
> +               .initval =3D _initval,                                   =
 \
> +       }
> +
> +/*
> + * DIV items in the array are sorted according to the clock-tree diagram,
> + * from top to bottom, from upstream to downstream. Read TRM for details.
> + */
> +#define DEF_DIVFLAG (CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO)
> +static struct sg2042_divider_clock sg2042_div_clks[] =3D {
> +       SG2042_DIV_RO(DIV_CLK_DPLL0_DDR01_0,
> +                     "clk_div_ddr01_0", "clk_gate_ddr01_div0",
> +                     R_CLKDIVREG27, 16, 5, DEF_DIVFLAG, 1),
> +       SG2042_DIV_RO(DIV_CLK_FPLL_DDR01_1,
> +                     "clk_div_ddr01_1", "clk_gate_ddr01_div1",
> +                     R_CLKDIVREG28, 16, 5, DEF_DIVFLAG, 1),
> +
> +       SG2042_DIV_RO(DIV_CLK_DPLL1_DDR23_0,
> +                     "clk_div_ddr23_0", "clk_gate_ddr23_div0",
> +                     R_CLKDIVREG29, 16, 5, DEF_DIVFLAG, 1),
> +       SG2042_DIV_RO(DIV_CLK_FPLL_DDR23_1,
> +                     "clk_div_ddr23_1", "clk_gate_ddr23_div1",
> +                     R_CLKDIVREG30, 16, 5, DEF_DIVFLAG, 1),
> +
> +       SG2042_DIV(DIV_CLK_MPLL_RP_CPU_NORMAL_0,
> +                  "clk_div_rp_cpu_normal_0", "clk_gate_rp_cpu_normal_div=
0",
> +                  R_CLKDIVREG0, 16, 5, DEF_DIVFLAG, 1),
> +       SG2042_DIV(DIV_CLK_FPLL_RP_CPU_NORMAL_1,
> +                  "clk_div_rp_cpu_normal_1", "clk_gate_rp_cpu_normal_div=
1",
> +                  R_CLKDIVREG1, 16, 5, DEF_DIVFLAG, 1),
> +
> +       SG2042_DIV(DIV_CLK_MPLL_AXI_DDR_0,
> +                  "clk_div_axi_ddr_0", "clk_gate_axi_ddr_div0",
> +                  R_CLKDIVREG25, 16, 5, DEF_DIVFLAG, 2),
> +       SG2042_DIV(DIV_CLK_FPLL_AXI_DDR_1,
> +                  "clk_div_axi_ddr_1", "clk_gate_axi_ddr_div1",
> +                  R_CLKDIVREG26, 16, 5, DEF_DIVFLAG, 1),
> +
> +       SG2042_DIV(DIV_CLK_FPLL_TOP_RP_CMN_DIV2,
> +                  "clk_div_top_rp_cmn_div2", "clk_mux_rp_cpu_normal",
> +                  R_CLKDIVREG3, 16, 16, DEF_DIVFLAG, 2),
> +
> +       SG2042_DIV(DIV_CLK_FPLL_50M_A53, "clk_div_50m_a53", "fpll_clock",
> +                  R_CLKDIVREG2, 16, 8, DEF_DIVFLAG, 20),
> +       /* downstream of div_50m_a53 */
> +       SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER1, "clk_div_timer1", "clk_div_50=
m_a53",
> +                  R_CLKDIVREG6, 16, 16, DEF_DIVFLAG, 1),
> +       SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER2, "clk_div_timer2", "clk_div_50=
m_a53",
> +                  R_CLKDIVREG7, 16, 16, DEF_DIVFLAG, 1),
> +       SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER3, "clk_div_timer3", "clk_div_50=
m_a53",
> +                  R_CLKDIVREG8, 16, 16, DEF_DIVFLAG, 1),
> +       SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER4, "clk_div_timer4", "clk_div_50=
m_a53",
> +                  R_CLKDIVREG9, 16, 16, DEF_DIVFLAG, 1),
> +       SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER5, "clk_div_timer5", "clk_div_50=
m_a53",
> +                  R_CLKDIVREG10, 16, 16, DEF_DIVFLAG, 1),
> +       SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER6, "clk_div_timer6", "clk_div_50=
m_a53",
> +                  R_CLKDIVREG11, 16, 16, DEF_DIVFLAG, 1),
> +       SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER7, "clk_div_timer7", "clk_div_50=
m_a53",
> +                  R_CLKDIVREG12, 16, 16, DEF_DIVFLAG, 1),
> +       SG2042_DIV(DIV_CLK_FPLL_DIV_TIMER8, "clk_div_timer8", "clk_div_50=
m_a53",
> +                  R_CLKDIVREG13, 16, 16, DEF_DIVFLAG, 1),
> +
> +       /*
> +        * Set clk_div_uart_500m as RO, because the width of CLKDIVREG4 i=
s too
> +        * narrow for us to produce 115200. Use UART internal divider dir=
ectly.
> +        */
> +       SG2042_DIV_RO(DIV_CLK_FPLL_UART_500M, "clk_div_uart_500m", "fpll_=
clock",
> +                     R_CLKDIVREG4, 16, 7, DEF_DIVFLAG, 2),
> +       SG2042_DIV(DIV_CLK_FPLL_AHB_LPC, "clk_div_ahb_lpc", "fpll_clock",
> +                  R_CLKDIVREG5, 16, 16, DEF_DIVFLAG, 5),
> +       SG2042_DIV(DIV_CLK_FPLL_EFUSE, "clk_div_efuse", "fpll_clock",
> +                  R_CLKDIVREG14, 16, 7, DEF_DIVFLAG, 40),
> +       SG2042_DIV(DIV_CLK_FPLL_TX_ETH0, "clk_div_tx_eth0", "fpll_clock",
> +                  R_CLKDIVREG16, 16, 11, DEF_DIVFLAG, 8),
> +       SG2042_DIV(DIV_CLK_FPLL_PTP_REF_I_ETH0,
> +                  "clk_div_ptp_ref_i_eth0", "fpll_clock",
> +                  R_CLKDIVREG17, 16, 8, DEF_DIVFLAG, 20),
> +       SG2042_DIV(DIV_CLK_FPLL_REF_ETH0, "clk_div_ref_eth0", "fpll_clock=
",
> +                  R_CLKDIVREG18, 16, 8, DEF_DIVFLAG, 40),
> +       SG2042_DIV(DIV_CLK_FPLL_EMMC, "clk_div_emmc", "fpll_clock",
> +                  R_CLKDIVREG19, 16, 5, DEF_DIVFLAG, 10),
> +       SG2042_DIV(DIV_CLK_FPLL_SD, "clk_div_sd", "fpll_clock",
> +                  R_CLKDIVREG21, 16, 5, DEF_DIVFLAG, 10),
> +
> +       SG2042_DIV(DIV_CLK_FPLL_TOP_AXI0, "clk_div_top_axi0", "fpll_clock=
",
> +                  R_CLKDIVREG23, 16, 5, DEF_DIVFLAG, 10),
> +       /* downstream of div_top_axi0 */
> +       SG2042_DIV(DIV_CLK_FPLL_100K_EMMC, "clk_div_100k_emmc", "clk_div_=
top_axi0",
> +                  R_CLKDIVREG20, 16, 16, DEF_DIVFLAG, 1000),
> +       SG2042_DIV(DIV_CLK_FPLL_100K_SD, "clk_div_100k_sd", "clk_div_top_=
axi0",
> +                  R_CLKDIVREG22, 16, 16, DEF_DIVFLAG, 1000),
> +       SG2042_DIV(DIV_CLK_FPLL_GPIO_DB, "clk_div_gpio_db", "clk_div_top_=
axi0",
> +                  R_CLKDIVREG15, 16, 16, DEF_DIVFLAG, 1000),
> +
> +       SG2042_DIV(DIV_CLK_FPLL_TOP_AXI_HSPERI,
> +                  "clk_div_top_axi_hsperi", "fpll_clock",
> +                  R_CLKDIVREG24, 16, 5, DEF_DIVFLAG, 4),
> +};
> +
> +#define SG2042_GATE(_id, _name, _parent_name, _flags,  \
> +                   _r_enable, _bit_idx) {              \
> +               .hw.init =3D CLK_HW_INIT(                 \
> +                               _name,                  \
> +                               _parent_name,           \
> +                               NULL,                   \
> +                               _flags),                \
> +               .id =3D _id,                              \
> +               .offset_enable =3D _r_enable,             \
> +               .bit_idx =3D _bit_idx,                    \
> +       }
> +
> +/*
> + * GATE items in the array are sorted according to the clock-tree diagra=
m,
> + * from top to bottom, from upstream to downstream. Read TRM for details.
> + */
> +
> +/* Gate clocks which control registers are defined in CLOCK. */
> +static const struct sg2042_gate_clock sg2042_gate_clks[] =3D {
> +       SG2042_GATE(GATE_CLK_DDR01_DIV0, "clk_gate_ddr01_div0", "dpll0_cl=
ock",
> +                   CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +                   R_CLKDIVREG27, 4),
> +       SG2042_GATE(GATE_CLK_DDR01_DIV1, "clk_gate_ddr01_div1", "fpll_clo=
ck",
> +                   CLK_IS_CRITICAL,
> +                   R_CLKDIVREG28, 4),
> +
> +       SG2042_GATE(GATE_CLK_DDR23_DIV0, "clk_gate_ddr23_div0", "dpll1_cl=
ock",
> +                   CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +                   R_CLKDIVREG29, 4),
> +       SG2042_GATE(GATE_CLK_DDR23_DIV1, "clk_gate_ddr23_div1", "fpll_clo=
ck",
> +                   CLK_IS_CRITICAL,
> +                   R_CLKDIVREG30, 4),
> +
> +       SG2042_GATE(GATE_CLK_RP_CPU_NORMAL_DIV0, "clk_gate_rp_cpu_normal_=
div0", "mpll_clock",
> +                   CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> +                   R_CLKDIVREG0, 4),
> +       SG2042_GATE(GATE_CLK_RP_CPU_NORMAL_DIV1,
> +                   "clk_gate_rp_cpu_normal_div1", "fpll_clock",
> +                   CLK_IS_CRITICAL,
> +                   R_CLKDIVREG1, 4),
> +
> +       SG2042_GATE(GATE_CLK_AXI_DDR_DIV0, "clk_gate_axi_ddr_div0", "mpll=
_clock",
> +                   CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> +                   R_CLKDIVREG25, 4),
> +       SG2042_GATE(GATE_CLK_AXI_DDR_DIV1, "clk_gate_axi_ddr_div1", "fpll=
_clock",
> +                   CLK_IS_CRITICAL,
> +                   R_CLKDIVREG26, 4),
> +
> +       /* upon are gate clocks as input source for the muxes */
> +
> +       SG2042_GATE(GATE_CLK_DDR01, "clk_gate_ddr01", "clk_mux_ddr01",
> +                   CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> +                   R_CLKENREG1, 14),
> +
> +       SG2042_GATE(GATE_CLK_DDR23, "clk_gate_ddr23", "clk_mux_ddr23",
> +                   CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> +                   R_CLKENREG1, 15),
> +
> +       SG2042_GATE(GATE_CLK_RP_CPU_NORMAL,
> +                   "clk_gate_rp_cpu_normal", "clk_mux_rp_cpu_normal",
> +                   CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> +                   R_CLKENREG0, 0),
> +
> +       SG2042_GATE(GATE_CLK_AXI_DDR, "clk_gate_axi_ddr", "clk_mux_axi_dd=
r",
> +                   CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> +                   R_CLKENREG1, 13),
> +
> +       /* upon are gate clocks directly downstream of muxes */
> +
> +       /* downstream of clk_div_top_rp_cmn_div2 */
> +       SG2042_GATE(GATE_CLK_TOP_RP_CMN_DIV2,
> +                   "clk_gate_top_rp_cmn_div2", "clk_div_top_rp_cmn_div2",
> +                   CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, R_CLKENREG0,=
 2),
> +       SG2042_GATE(GATE_CLK_HSDMA, "clk_gate_hsdma", "clk_gate_top_rp_cm=
n_div2",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG1, 10),
> +
> +       /*
> +        * downstream of clk_gate_rp_cpu_normal
> +        *
> +        * FIXME: there should be one 1/2 DIV between clk_gate_rp_cpu_nor=
mal
> +        * and clk_gate_axi_pcie0/clk_gate_axi_pcie1.
> +        * But the 1/2 DIV is fixed and no configurable register exported=
, so
> +        * when reading from these two clocks, the rate value are still t=
he
> +        * same as that of clk_gate_rp_cpu_normal, it's not correct.
> +        * This just affects the value read.
> +        */
> +       SG2042_GATE(GATE_CLK_AXI_PCIE0,
> +                   "clk_gate_axi_pcie0", "clk_gate_rp_cpu_normal",
> +                   CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, R_CLKENREG1,=
 8),
> +       SG2042_GATE(GATE_CLK_AXI_PCIE1,
> +                   "clk_gate_axi_pcie1", "clk_gate_rp_cpu_normal",
> +                   CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, R_CLKENREG1,=
 9),
> +
> +       /* downstream of div_50m_a53 */
> +       SG2042_GATE(GATE_CLK_A53_50M, "clk_gate_a53_50m", "clk_div_50m_a5=
3",
> +                   CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, R_CLKENREG0,=
 1),
> +       SG2042_GATE(GATE_CLK_TIMER1, "clk_gate_timer1", "clk_div_timer1",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG0, 12),
> +       SG2042_GATE(GATE_CLK_TIMER2, "clk_gate_timer2", "clk_div_timer2",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG0, 13),
> +       SG2042_GATE(GATE_CLK_TIMER3, "clk_gate_timer3", "clk_div_timer3",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG0, 14),
> +       SG2042_GATE(GATE_CLK_TIMER4, "clk_gate_timer4", "clk_div_timer4",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG0, 15),
> +       SG2042_GATE(GATE_CLK_TIMER5, "clk_gate_timer5", "clk_div_timer5",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG0, 16),
> +       SG2042_GATE(GATE_CLK_TIMER6, "clk_gate_timer6", "clk_div_timer6",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG0, 17),
> +       SG2042_GATE(GATE_CLK_TIMER7, "clk_gate_timer7", "clk_div_timer7",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG0, 18),
> +       SG2042_GATE(GATE_CLK_TIMER8, "clk_gate_timer8", "clk_div_timer8",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG0, 19),
> +
> +       /* gate clocks downstream from div clocks one-to-one */
> +       SG2042_GATE(GATE_CLK_UART_500M, "clk_gate_uart_500m", "clk_div_ua=
rt_500m",
> +                   CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, R_CLKENREG0,=
 4),
> +       SG2042_GATE(GATE_CLK_AHB_LPC, "clk_gate_ahb_lpc", "clk_div_ahb_lp=
c",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG0, 7),
> +       SG2042_GATE(GATE_CLK_EFUSE, "clk_gate_efuse", "clk_div_efuse",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG0, 20),
> +       SG2042_GATE(GATE_CLK_TX_ETH0, "clk_gate_tx_eth0", "clk_div_tx_eth=
0",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG0, 30),
> +       SG2042_GATE(GATE_CLK_PTP_REF_I_ETH0,
> +                   "clk_gate_ptp_ref_i_eth0", "clk_div_ptp_ref_i_eth0",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG1, 0),
> +       SG2042_GATE(GATE_CLK_REF_ETH0, "clk_gate_ref_eth0", "clk_div_ref_=
eth0",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG1, 1),
> +       SG2042_GATE(GATE_CLK_EMMC_100M, "clk_gate_emmc", "clk_div_emmc",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG1, 3),
> +       SG2042_GATE(GATE_CLK_SD_100M, "clk_gate_sd", "clk_div_sd",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG1, 6),
> +
> +       /* downstream of clk_div_top_axi0 */
> +       SG2042_GATE(GATE_CLK_AHB_ROM, "clk_gate_ahb_rom", "clk_div_top_ax=
i0",
> +                   0, R_CLKENREG0, 8),
> +       SG2042_GATE(GATE_CLK_AHB_SF, "clk_gate_ahb_sf", "clk_div_top_axi0=
",
> +                   0, R_CLKENREG0, 9),
> +       SG2042_GATE(GATE_CLK_AXI_SRAM, "clk_gate_axi_sram", "clk_div_top_=
axi0",
> +                   CLK_IGNORE_UNUSED, R_CLKENREG0, 10),
> +       SG2042_GATE(GATE_CLK_APB_TIMER, "clk_gate_apb_timer", "clk_div_to=
p_axi0",
> +                   CLK_IGNORE_UNUSED, R_CLKENREG0, 11),
> +       SG2042_GATE(GATE_CLK_APB_EFUSE, "clk_gate_apb_efuse", "clk_div_to=
p_axi0",
> +                   0, R_CLKENREG0, 21),
> +       SG2042_GATE(GATE_CLK_APB_GPIO, "clk_gate_apb_gpio", "clk_div_top_=
axi0",
> +                   0, R_CLKENREG0, 22),
> +       SG2042_GATE(GATE_CLK_APB_GPIO_INTR,
> +                   "clk_gate_apb_gpio_intr", "clk_div_top_axi0",
> +                   CLK_IS_CRITICAL, R_CLKENREG0, 23),
> +       SG2042_GATE(GATE_CLK_APB_I2C, "clk_gate_apb_i2c", "clk_div_top_ax=
i0",
> +                   0, R_CLKENREG0, 26),
> +       SG2042_GATE(GATE_CLK_APB_WDT, "clk_gate_apb_wdt", "clk_div_top_ax=
i0",
> +                   0, R_CLKENREG0, 27),
> +       SG2042_GATE(GATE_CLK_APB_PWM, "clk_gate_apb_pwm", "clk_div_top_ax=
i0",
> +                   0, R_CLKENREG0, 28),
> +       SG2042_GATE(GATE_CLK_APB_RTC, "clk_gate_apb_rtc", "clk_div_top_ax=
i0",
> +                   0, R_CLKENREG0, 29),
> +       SG2042_GATE(GATE_CLK_TOP_AXI0, "clk_gate_top_axi0", "clk_div_top_=
axi0",
> +                   CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> +                   R_CLKENREG1, 11),
> +       /* downstream of DIV clocks which are sourced from clk_div_top_ax=
i0 */
> +       SG2042_GATE(GATE_CLK_GPIO_DB, "clk_gate_gpio_db", "clk_div_gpio_d=
b",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG0, 24),
> +       SG2042_GATE(GATE_CLK_100K_EMMC, "clk_gate_100k_emmc", "clk_div_10=
0k_emmc",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG1, 4),
> +       SG2042_GATE(GATE_CLK_100K_SD, "clk_gate_100k_sd", "clk_div_100k_s=
d",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG1, 7),
> +
> +       /* downstream of clk_div_top_axi_hsperi */
> +       SG2042_GATE(GATE_CLK_SYSDMA_AXI,
> +                   "clk_gate_sysdma_axi", "clk_div_top_axi_hsperi",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG0, 3),
> +       SG2042_GATE(GATE_CLK_APB_UART,
> +                   "clk_gate_apb_uart", "clk_div_top_axi_hsperi",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG0, 5),
> +       SG2042_GATE(GATE_CLK_AXI_DBG_I2C,
> +                   "clk_gate_axi_dbg_i2c", "clk_div_top_axi_hsperi",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG0, 6),
> +       SG2042_GATE(GATE_CLK_APB_SPI,
> +                   "clk_gate_apb_spi", "clk_div_top_axi_hsperi",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG0, 25),
> +       SG2042_GATE(GATE_CLK_AXI_ETH0,
> +                   "clk_gate_axi_eth0", "clk_div_top_axi_hsperi",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG0, 31),
> +       SG2042_GATE(GATE_CLK_AXI_EMMC,
> +                   "clk_gate_axi_emmc", "clk_div_top_axi_hsperi",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG1, 2),
> +       SG2042_GATE(GATE_CLK_AXI_SD,
> +                   "clk_gate_axi_sd", "clk_div_top_axi_hsperi",
> +                   CLK_SET_RATE_PARENT, R_CLKENREG1, 5),
> +       SG2042_GATE(GATE_CLK_TOP_AXI_HSPERI,
> +                   "clk_gate_top_axi_hsperi", "clk_div_top_axi_hsperi",
> +                   CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> +                   R_CLKENREG1, 12),
> +};
> +
> +/*
> + * Gate clocks for RP subsystem (including the MP subsystem), which cont=
rol
> + * registers are defined in SYS_CTRL.
> + */
> +static const struct sg2042_gate_clock sg2042_gate_rp[] =3D {
> +       /* downstream of clk_gate_rp_cpu_normal about rxu */
> +       SG2042_GATE(GATE_CLK_RXU0, "clk_gate_rxu0", "clk_gate_rp_cpu_norm=
al",
> +                   0, R_RP_RXU_CLK_ENABLE, 0),
> +       SG2042_GATE(GATE_CLK_RXU1, "clk_gate_rxu1", "clk_gate_rp_cpu_norm=
al",
> +                   0, R_RP_RXU_CLK_ENABLE, 1),
> +       SG2042_GATE(GATE_CLK_RXU2, "clk_gate_rxu2", "clk_gate_rp_cpu_norm=
al",
> +                   0, R_RP_RXU_CLK_ENABLE, 2),
> +       SG2042_GATE(GATE_CLK_RXU3, "clk_gate_rxu3", "clk_gate_rp_cpu_norm=
al",
> +                   0, R_RP_RXU_CLK_ENABLE, 3),
> +       SG2042_GATE(GATE_CLK_RXU4, "clk_gate_rxu4", "clk_gate_rp_cpu_norm=
al",
> +                   0, R_RP_RXU_CLK_ENABLE, 4),
> +       SG2042_GATE(GATE_CLK_RXU5, "clk_gate_rxu5", "clk_gate_rp_cpu_norm=
al",
> +                   0, R_RP_RXU_CLK_ENABLE, 5),
> +       SG2042_GATE(GATE_CLK_RXU6, "clk_gate_rxu6", "clk_gate_rp_cpu_norm=
al",
> +                   0, R_RP_RXU_CLK_ENABLE, 6),
> +       SG2042_GATE(GATE_CLK_RXU7, "clk_gate_rxu7", "clk_gate_rp_cpu_norm=
al",
> +                   0, R_RP_RXU_CLK_ENABLE, 7),
> +       SG2042_GATE(GATE_CLK_RXU8, "clk_gate_rxu8", "clk_gate_rp_cpu_norm=
al",
> +                   0, R_RP_RXU_CLK_ENABLE, 8),
> +       SG2042_GATE(GATE_CLK_RXU9, "clk_gate_rxu9", "clk_gate_rp_cpu_norm=
al",
> +                   0, R_RP_RXU_CLK_ENABLE, 9),
> +       SG2042_GATE(GATE_CLK_RXU10, "clk_gate_rxu10", "clk_gate_rp_cpu_no=
rmal",
> +                   0, R_RP_RXU_CLK_ENABLE, 10),
> +       SG2042_GATE(GATE_CLK_RXU11, "clk_gate_rxu11", "clk_gate_rp_cpu_no=
rmal",
> +                   0, R_RP_RXU_CLK_ENABLE, 11),
> +       SG2042_GATE(GATE_CLK_RXU12, "clk_gate_rxu12", "clk_gate_rp_cpu_no=
rmal",
> +                   0, R_RP_RXU_CLK_ENABLE, 12),
> +       SG2042_GATE(GATE_CLK_RXU13, "clk_gate_rxu13", "clk_gate_rp_cpu_no=
rmal",
> +                   0, R_RP_RXU_CLK_ENABLE, 13),
> +       SG2042_GATE(GATE_CLK_RXU14, "clk_gate_rxu14", "clk_gate_rp_cpu_no=
rmal",
> +                   0, R_RP_RXU_CLK_ENABLE, 14),
> +       SG2042_GATE(GATE_CLK_RXU15, "clk_gate_rxu15", "clk_gate_rp_cpu_no=
rmal",
> +                   0, R_RP_RXU_CLK_ENABLE, 15),
> +       SG2042_GATE(GATE_CLK_RXU16, "clk_gate_rxu16", "clk_gate_rp_cpu_no=
rmal",
> +                   0, R_RP_RXU_CLK_ENABLE, 16),
> +       SG2042_GATE(GATE_CLK_RXU17, "clk_gate_rxu17", "clk_gate_rp_cpu_no=
rmal",
> +                   0, R_RP_RXU_CLK_ENABLE, 17),
> +       SG2042_GATE(GATE_CLK_RXU18, "clk_gate_rxu18", "clk_gate_rp_cpu_no=
rmal",
> +                   0, R_RP_RXU_CLK_ENABLE, 18),
> +       SG2042_GATE(GATE_CLK_RXU19, "clk_gate_rxu19", "clk_gate_rp_cpu_no=
rmal",
> +                   0, R_RP_RXU_CLK_ENABLE, 19),
> +       SG2042_GATE(GATE_CLK_RXU20, "clk_gate_rxu20", "clk_gate_rp_cpu_no=
rmal",
> +                   0, R_RP_RXU_CLK_ENABLE, 20),
> +       SG2042_GATE(GATE_CLK_RXU21, "clk_gate_rxu21", "clk_gate_rp_cpu_no=
rmal",
> +                   0, R_RP_RXU_CLK_ENABLE, 21),
> +       SG2042_GATE(GATE_CLK_RXU22, "clk_gate_rxu22", "clk_gate_rp_cpu_no=
rmal",
> +                   0, R_RP_RXU_CLK_ENABLE, 22),
> +       SG2042_GATE(GATE_CLK_RXU23, "clk_gate_rxu23", "clk_gate_rp_cpu_no=
rmal",
> +                   0, R_RP_RXU_CLK_ENABLE, 23),
> +       SG2042_GATE(GATE_CLK_RXU24, "clk_gate_rxu24", "clk_gate_rp_cpu_no=
rmal",
> +                   0, R_RP_RXU_CLK_ENABLE, 24),
> +       SG2042_GATE(GATE_CLK_RXU25, "clk_gate_rxu25", "clk_gate_rp_cpu_no=
rmal",
> +                   0, R_RP_RXU_CLK_ENABLE, 25),
> +       SG2042_GATE(GATE_CLK_RXU26, "clk_gate_rxu26", "clk_gate_rp_cpu_no=
rmal",
> +                   0, R_RP_RXU_CLK_ENABLE, 26),
> +       SG2042_GATE(GATE_CLK_RXU27, "clk_gate_rxu27", "clk_gate_rp_cpu_no=
rmal",
> +                   0, R_RP_RXU_CLK_ENABLE, 27),
> +       SG2042_GATE(GATE_CLK_RXU28, "clk_gate_rxu28", "clk_gate_rp_cpu_no=
rmal",
> +                   0, R_RP_RXU_CLK_ENABLE, 28),
> +       SG2042_GATE(GATE_CLK_RXU29, "clk_gate_rxu29", "clk_gate_rp_cpu_no=
rmal",
> +                   0, R_RP_RXU_CLK_ENABLE, 29),
> +       SG2042_GATE(GATE_CLK_RXU30, "clk_gate_rxu30", "clk_gate_rp_cpu_no=
rmal",
> +                   0, R_RP_RXU_CLK_ENABLE, 30),
> +       SG2042_GATE(GATE_CLK_RXU31, "clk_gate_rxu31", "clk_gate_rp_cpu_no=
rmal",
> +                   0, R_RP_RXU_CLK_ENABLE, 31),
> +
> +       /* downstream of clk_gate_rp_cpu_normal about mp */
> +       SG2042_GATE(GATE_CLK_MP0, "clk_gate_mp0", "clk_gate_rp_cpu_normal=
",
> +                   CLK_IS_CRITICAL, R_MP0_CONTROL_REG, 0),
> +       SG2042_GATE(GATE_CLK_MP1, "clk_gate_mp1", "clk_gate_rp_cpu_normal=
",
> +                   CLK_IS_CRITICAL, R_MP1_CONTROL_REG, 0),
> +       SG2042_GATE(GATE_CLK_MP2, "clk_gate_mp2", "clk_gate_rp_cpu_normal=
",
> +                   CLK_IS_CRITICAL, R_MP2_CONTROL_REG, 0),
> +       SG2042_GATE(GATE_CLK_MP3, "clk_gate_mp3", "clk_gate_rp_cpu_normal=
",
> +                   CLK_IS_CRITICAL, R_MP3_CONTROL_REG, 0),
> +       SG2042_GATE(GATE_CLK_MP4, "clk_gate_mp4", "clk_gate_rp_cpu_normal=
",
> +                   CLK_IS_CRITICAL, R_MP4_CONTROL_REG, 0),
> +       SG2042_GATE(GATE_CLK_MP5, "clk_gate_mp5", "clk_gate_rp_cpu_normal=
",
> +                   CLK_IS_CRITICAL, R_MP5_CONTROL_REG, 0),
> +       SG2042_GATE(GATE_CLK_MP6, "clk_gate_mp6", "clk_gate_rp_cpu_normal=
",
> +                   CLK_IS_CRITICAL, R_MP6_CONTROL_REG, 0),
> +       SG2042_GATE(GATE_CLK_MP7, "clk_gate_mp7", "clk_gate_rp_cpu_normal=
",
> +                   CLK_IS_CRITICAL, R_MP7_CONTROL_REG, 0),
> +       SG2042_GATE(GATE_CLK_MP8, "clk_gate_mp8", "clk_gate_rp_cpu_normal=
",
> +                   CLK_IS_CRITICAL, R_MP8_CONTROL_REG, 0),
> +       SG2042_GATE(GATE_CLK_MP9, "clk_gate_mp9", "clk_gate_rp_cpu_normal=
",
> +                   CLK_IS_CRITICAL, R_MP9_CONTROL_REG, 0),
> +       SG2042_GATE(GATE_CLK_MP10, "clk_gate_mp10", "clk_gate_rp_cpu_norm=
al",
> +                   CLK_IS_CRITICAL, R_MP10_CONTROL_REG, 0),
> +       SG2042_GATE(GATE_CLK_MP11, "clk_gate_mp11", "clk_gate_rp_cpu_norm=
al",
> +                   CLK_IS_CRITICAL, R_MP11_CONTROL_REG, 0),
> +       SG2042_GATE(GATE_CLK_MP12, "clk_gate_mp12", "clk_gate_rp_cpu_norm=
al",
> +                   CLK_IS_CRITICAL, R_MP12_CONTROL_REG, 0),
> +       SG2042_GATE(GATE_CLK_MP13, "clk_gate_mp13", "clk_gate_rp_cpu_norm=
al",
> +                   CLK_IS_CRITICAL, R_MP13_CONTROL_REG, 0),
> +       SG2042_GATE(GATE_CLK_MP14, "clk_gate_mp14", "clk_gate_rp_cpu_norm=
al",
> +                   CLK_IS_CRITICAL, R_MP14_CONTROL_REG, 0),
> +       SG2042_GATE(GATE_CLK_MP15, "clk_gate_mp15", "clk_gate_rp_cpu_norm=
al",
> +                   CLK_IS_CRITICAL, R_MP15_CONTROL_REG, 0),
> +};
> +
> +#define SG2042_MUX(_id, _name, _parent_names, _flags, _r_select, _shift,=
 _width) { \
> +               .hw.init =3D CLK_HW_INIT_PARENTS(                 \
> +                               _name,                          \
> +                               _parent_names,                  \
> +                               NULL,                           \
> +                               _flags),                        \
> +               .id =3D _id,                                      \
> +               .offset_select =3D _r_select,                     \
> +               .shift =3D _shift,                                \
> +               .width =3D _width,                                \
> +       }
> +
> +/*
> + * Note: regarding names for mux clock, "0/1" or "div0/div1" means the
> + * first/second parent input source, not the register value.
> + * For example:
> + * "clk_div_ddr01_0" is the name of Clock divider 0 control of DDR01, and
> + * "clk_gate_ddr01_div0" is the gate clock in front of the "clk_div_ddr0=
1_0",
> + * they are both controlled by register CLKDIVREG27;
> + * "clk_div_ddr01_1" is the name of Clock divider 1 control of DDR01, and
> + * "clk_gate_ddr01_div1" is the gate clock in front of the "clk_div_ddr0=
1_1",
> + * they are both controlled by register CLKDIVREG28;
> + * While for register value of mux selection, use Clock Select for DDR01=
=E2=80=99s clock
> + * as example, see CLKSELREG0, bit[2].
> + * 1: Select in_dpll0_clk as clock source, correspondng to the parent in=
put
> + *    source from "clk_div_ddr01_0".
> + * 0: Select in_fpll_clk as clock source, corresponding to the parent in=
put
> + *    source from "clk_div_ddr01_1".
> + * So we need a table to define the array of register values correspondi=
ng to
> + * the parent index and tell CCF about this when registering mux clock.
> + */
> +static const u32 sg2042_mux_table[] =3D {1, 0};
> +
> +static const char *const clk_mux_ddr01_p[] =3D {
> +                       "clk_div_ddr01_0", "clk_div_ddr01_1"};
> +static const char *const clk_mux_ddr23_p[] =3D {
> +                       "clk_div_ddr23_0", "clk_div_ddr23_1"};
> +static const char *const clk_mux_rp_cpu_normal_p[] =3D {
> +                       "clk_div_rp_cpu_normal_0", "clk_div_rp_cpu_normal=
_1"};
> +static const char *const clk_mux_axi_ddr_p[] =3D {
> +                       "clk_div_axi_ddr_0", "clk_div_axi_ddr_1"};
> +
> +static struct sg2042_mux_clock sg2042_mux_clks[] =3D {
> +       SG2042_MUX(MUX_CLK_DDR01, "clk_mux_ddr01", clk_mux_ddr01_p,

Please use struct clk_parent_data or struct clk_hw directly instead of
string names.

> +                  CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT | CLK_M=
UX_READ_ONLY,
> +                  R_CLKSELREG0, 2, 1),
> +       SG2042_MUX(MUX_CLK_DDR23, "clk_mux_ddr23", clk_mux_ddr23_p,
> +                  CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT | CLK_M=
UX_READ_ONLY,
> +                  R_CLKSELREG0, 3, 1),
> +       SG2042_MUX(MUX_CLK_RP_CPU_NORMAL, "clk_mux_rp_cpu_normal", clk_mu=
x_rp_cpu_normal_p,
> +                  CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
> +                  R_CLKSELREG0, 0, 1),
> +       SG2042_MUX(MUX_CLK_AXI_DDR, "clk_mux_axi_ddr", clk_mux_axi_ddr_p,
> +                  CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
> +                  R_CLKSELREG0, 1, 1),
> +};
> +
> +static DEFINE_SPINLOCK(sg2042_clk_lock);
> +
> +static int sg2042_clk_register_plls(struct sg2042_clk_data *clk_data,
> +                                   struct sg2042_pll_clock pll_clks[],
> +                                   int num_pll_clks)
> +{
> +       struct clk_hw *hw;
> +       struct sg2042_pll_clock *pll;
> +       int i, ret =3D 0;
> +
> +       for (i =3D 0; i < num_pll_clks; i++) {
> +               pll =3D &pll_clks[i];
> +               /* assign these for ops usage during registration */
> +               pll->base =3D clk_data->iobase;
> +               pll->lock =3D &sg2042_clk_lock;
> +
> +               hw =3D &pll->hw;
> +               ret =3D clk_hw_register(NULL, hw);

Use devm_clk_hw_register() and pass a device.

> +               if (ret) {
> +                       pr_err("failed to register clock %s\n", pll->hw.i=
nit->name);
> +                       break;
> +               }
> +
> +               clk_data->onecell_data.hws[pll->id] =3D hw;
> +       }
> +
> +       /* leave unregister to outside if failed */
> +       return ret;
> +}
> +
> +static int sg2042_clk_register_divs(struct sg2042_clk_data *clk_data,
> +                                   struct sg2042_divider_clock div_clks[=
],
> +                                   int num_div_clks)
> +{
> +       struct clk_hw *hw;
> +       struct sg2042_divider_clock *div;
> +       int i, ret =3D 0;
> +
> +       for (i =3D 0; i < num_div_clks; i++) {
> +               div =3D &div_clks[i];
> +
> +               if (div->div_flags & CLK_DIVIDER_HIWORD_MASK) {
> +                       if (div->width + div->shift > 16) {
> +                               pr_warn("divider value exceeds LOWORD fie=
ld\n");
> +                               ret =3D -EINVAL;
> +                               break;
> +                       }
> +               }
> +
> +               div->reg =3D clk_data->iobase + div->offset_ctrl;
> +               div->lock =3D &sg2042_clk_lock;
> +
> +               hw =3D &div->hw;
> +               ret =3D clk_hw_register(NULL, hw);
> +               if (ret) {
> +                       pr_err("failed to register clock %s\n", div->hw.i=
nit->name);
> +                       break;
> +               }
> +
> +               clk_data->onecell_data.hws[div->id] =3D hw;
> +       }
> +
> +       /* leave unregister to outside if failed */
> +       return ret;
> +}
> +
> +static int sg2042_clk_register_gates(struct sg2042_clk_data *clk_data,
> +                                    const struct sg2042_gate_clock gate_=
clks[],
> +                                    int num_gate_clks)
> +{
> +       struct clk_hw *hw;
> +       const struct sg2042_gate_clock *gate;
> +       int i, ret =3D 0;
> +
> +       for (i =3D 0; i < num_gate_clks; i++) {
> +               gate =3D &gate_clks[i];
> +               hw =3D clk_hw_register_gate(NULL,
> +                                         gate->hw.init->name,
> +                                         gate->hw.init->parent_names[0],
> +                                         gate->hw.init->flags,
> +                                         clk_data->iobase + gate->offset=
_enable,
> +                                         gate->bit_idx,
> +                                         0,
> +                                         &sg2042_clk_lock);
> +               if (IS_ERR(hw)) {
> +                       pr_err("failed to register clock %s\n", gate->hw.=
init->name);
> +                       ret =3D PTR_ERR(hw);
> +                       break;
> +               }
> +
> +               clk_data->onecell_data.hws[gate->id] =3D hw;
> +       }
> +
> +       /* leave unregister to outside if failed */
> +       return ret;
> +}
> +
> +static int sg2042_mux_notifier_cb(struct notifier_block *nb,
> +                                 unsigned long event,
> +                                 void *data)
> +{
> +       int ret =3D 0;
> +       struct clk_notifier_data *ndata =3D data;
> +       struct clk_hw *hw =3D __clk_get_hw(ndata->clk);
> +       const struct clk_ops *ops =3D &clk_mux_ops;
> +       struct sg2042_mux_clock *mux =3D to_sg2042_mux_nb(nb);
> +
> +       /* To switch to fpll before changing rate and restore after that =
*/
> +       if (event =3D=3D PRE_RATE_CHANGE) {
> +               mux->original_index =3D ops->get_parent(hw);
> +
> +               /*
> +                * "1" is the array index of the second parent input sour=
ce of
> +                * mux. For SG2042, it's fpll for all mux clocks.
> +                * "0" is the array index of the frist parent input sourc=
e of
> +                * mux, For SG2042, it's mpll.
> +                * FIXME, any good idea to avoid magic number?
> +                */
> +               if (mux->original_index =3D=3D 0)
> +                       ret =3D ops->set_parent(hw, 1);
> +       } else if (event =3D=3D POST_RATE_CHANGE) {
> +               ret =3D ops->set_parent(hw, mux->original_index);
> +       }
> +
> +       return notifier_from_errno(ret);
> +}
> +
> +static int sg2042_clk_register_muxs(struct sg2042_clk_data *clk_data,
> +                                   struct sg2042_mux_clock mux_clks[],
> +                                   int num_mux_clks)
> +{
> +       struct clk_hw *hw;
> +       struct sg2042_mux_clock *mux;
> +       int i, ret =3D 0;
> +
> +       for (i =3D 0; i < num_mux_clks; i++) {
> +               mux =3D &mux_clks[i];
> +
> +               hw =3D clk_hw_register_mux_table(NULL,

Pass a device and use devm.

> +                                              mux->hw.init->name,
> +                                              mux->hw.init->parent_names,
> +                                              mux->hw.init->num_parents,
> +                                              mux->hw.init->flags,
> +                                              clk_data->iobase + mux->of=
fset_select,
> +                                              mux->shift,
> +                                              BIT(mux->width) - 1,
> +                                              0,
> +                                              sg2042_mux_table,
> +                                              &sg2042_clk_lock);
> +               if (IS_ERR(hw)) {
> +                       pr_err("failed to register clock %s\n", mux->hw.i=
nit->name);
> +                       ret =3D PTR_ERR(hw);
> +                       break;
> +               }
> +
> +               clk_data->onecell_data.hws[mux->id] =3D hw;
> +
> +               /*
> +                * FIXME: Theoretically, we should set parent for the
> +                * mux, but seems hardware has done this for us with
> +                * default value, so we don't set parent again here.
> +                */
> +
> +               if (!(mux->hw.init->flags & CLK_MUX_READ_ONLY)) {
> +                       mux->clk_nb.notifier_call =3D sg2042_mux_notifier=
_cb;
> +                       ret =3D clk_notifier_register(hw->clk, &mux->clk_=
nb);
> +                       if (ret) {
> +                               pr_err("failed to register clock notifier=
 for %s\n",
> +                                      mux->hw.init->name);
> +                               goto error_cleanup;
> +                       }
> +               }
> +       }
> +
> +       return 0;
> +
> +error_cleanup:
> +       /* unregister notifier and release the memory allocated */
> +       for (i =3D 0; i < num_mux_clks; i++) {
> +               mux =3D &mux_clks[i];
> +
> +               hw =3D clk_data->onecell_data.hws[mux->id];
> +
> +               if (hw)
> +                       clk_notifier_unregister(hw->clk, &mux->clk_nb);
> +       }
> +
> +       /* leave clk unregister to outside if failed */
> +       return ret;
> +}
> +
> +static int sg2042_init_clkdata(struct platform_device *pdev,
> +                              int num_clks,
> +                              struct sg2042_clk_data **pp_clk_data)
> +{
> +       struct sg2042_clk_data *clk_data =3D NULL;
> +
> +       clk_data =3D devm_kzalloc(&pdev->dev,
> +                               struct_size(clk_data, onecell_data.hws, n=
um_clks),
> +                               GFP_KERNEL);
> +       if (!clk_data)
> +               return -ENOMEM;
> +
> +       clk_data->iobase =3D devm_of_iomap(&pdev->dev, pdev->dev.of_node,=
 0, NULL);

Why can't we use devm_platform_ioremap_resource()?

> +       if (WARN_ON(IS_ERR(clk_data->iobase)))
> +               return PTR_ERR(clk_data->iobase);
> +
> +       clk_data->onecell_data.num =3D num_clks;
> +
> +       *pp_clk_data =3D clk_data;
> +
> +       return 0;
> +}
> +
> +static int sg2042_clkgen_probe(struct platform_device *pdev)
> +{
> +       struct sg2042_clk_data *clk_data =3D NULL;
> +       int i, ret =3D 0;
> +       int num_clks =3D 0;
> +
> +       num_clks =3D ARRAY_SIZE(sg2042_div_clks) +
> +                  ARRAY_SIZE(sg2042_gate_clks) +
> +                  ARRAY_SIZE(sg2042_mux_clks);
> +       if (num_clks =3D=3D 0) {
> +               ret =3D -EINVAL;
> +               goto error_out;
> +       }
> +
> +       ret =3D sg2042_init_clkdata(pdev, num_clks, &clk_data);
> +       if (ret < 0)
> +               goto error_out;
> +
> +       ret =3D sg2042_clk_register_divs(clk_data, sg2042_div_clks,
> +                                      ARRAY_SIZE(sg2042_div_clks));
> +       if (ret)
> +               goto cleanup;
> +
> +       ret =3D sg2042_clk_register_gates(clk_data, sg2042_gate_clks,
> +                                       ARRAY_SIZE(sg2042_gate_clks));
> +       if (ret)
> +               goto cleanup;
> +
> +       ret =3D sg2042_clk_register_muxs(clk_data, sg2042_mux_clks,
> +                                      ARRAY_SIZE(sg2042_mux_clks));
> +       if (ret)
> +               goto cleanup;
> +
> +       return devm_of_clk_add_hw_provider(&pdev->dev,
> +                                          of_clk_hw_onecell_get,
> +                                          &clk_data->onecell_data);
> +
> +cleanup:
> +       for (i =3D 0; i < num_clks; i++) {
> +               if (clk_data->onecell_data.hws[i])
> +                       clk_hw_unregister(clk_data->onecell_data.hws[i]);
> +       }
> +
> +error_out:
> +       pr_err("%s failed error number %d\n", __func__, ret);
> +       return ret;
> +}
> +
> +static int sg2042_rpgate_probe(struct platform_device *pdev)
> +{
> +       struct sg2042_clk_data *clk_data =3D NULL;
> +       int i, ret =3D 0;
> +       int num_clks =3D 0;
> +
> +       num_clks =3D ARRAY_SIZE(sg2042_gate_rp);
> +       if (num_clks =3D=3D 0) {
> +               ret =3D -EINVAL;
> +               goto error_out;
> +       }
> +
> +       ret =3D sg2042_init_clkdata(pdev, num_clks, &clk_data);
> +       if (ret < 0)
> +               goto error_out;
> +
> +       ret =3D sg2042_clk_register_gates(clk_data, sg2042_gate_rp,
> +                                       ARRAY_SIZE(sg2042_gate_rp));
> +       if (ret)
> +               goto cleanup;
> +
> +       return devm_of_clk_add_hw_provider(&pdev->dev,
> +                                          of_clk_hw_onecell_get,
> +                                          &clk_data->onecell_data);
> +
> +cleanup:
> +       for (i =3D 0; i < num_clks; i++) {
> +               if (clk_data->onecell_data.hws[i])
> +                       clk_hw_unregister(clk_data->onecell_data.hws[i]);
> +       }
> +
> +error_out:
> +       pr_err("%s failed error number %d\n", __func__, ret);
> +       return ret;
> +}
> +
> +static int sg2042_pll_probe(struct platform_device *pdev)
> +{
> +       struct sg2042_clk_data *clk_data =3D NULL;
> +       int i, ret =3D 0;
> +       int num_clks =3D 0;
> +
> +       num_clks =3D ARRAY_SIZE(sg2042_pll_clks);
> +       if (num_clks =3D=3D 0) {
> +               ret =3D -EINVAL;
> +               goto error_out;
> +       }

This is dead code, please remove.

> +
> +       ret =3D sg2042_init_clkdata(pdev, num_clks, &clk_data);
> +       if (ret < 0)
> +               goto error_out;
> +
> +       ret =3D sg2042_clk_register_plls(clk_data, sg2042_pll_clks,
> +                                      ARRAY_SIZE(sg2042_pll_clks));
> +       if (ret)
> +               goto cleanup;
> +
> +       return devm_of_clk_add_hw_provider(&pdev->dev,
> +                                          of_clk_hw_onecell_get,
> +                                          &clk_data->onecell_data);
> +
> +cleanup:
> +       for (i =3D 0; i < num_clks; i++) {
> +               if (clk_data->onecell_data.hws[i])
> +                       clk_hw_unregister(clk_data->onecell_data.hws[i]);
> +       }
> +
> +error_out:
> +       pr_err("%s failed error number %d\n", __func__, ret);
> +       return ret;
> +}
> +
> +static const struct of_device_id sg2042_clkgen_match[] =3D {
> +       { .compatible =3D "sophgo,sg2042-clkgen" },
> +       { /* sentinel */ }
> +};
> +
> +static struct platform_driver sg2042_clkgen_driver =3D {
> +       .probe =3D sg2042_clkgen_probe,
> +       .driver =3D {
> +               .name =3D "clk-sophgo-sg2042-clkgen",
> +               .of_match_table =3D sg2042_clkgen_match,
> +               .suppress_bind_attrs =3D true,
> +       },
> +};
> +builtin_platform_driver(sg2042_clkgen_driver);
> +
> +static const struct of_device_id sg2042_rpgate_match[] =3D {
> +       { .compatible =3D "sophgo,sg2042-rpgate" },
> +       { /* sentinel */ }
> +};
> +
> +static struct platform_driver sg2042_rpgate_driver =3D {
> +       .probe =3D sg2042_rpgate_probe,
> +       .driver =3D {
> +               .name =3D "clk-sophgo-sg2042-rpgate",
> +               .of_match_table =3D sg2042_rpgate_match,
> +               .suppress_bind_attrs =3D true,
> +       },
> +};
> +builtin_platform_driver(sg2042_rpgate_driver);
> +
> +static const struct of_device_id sg2042_pll_match[] =3D {
> +       { .compatible =3D "sophgo,sg2042-pll" },
> +       { /* sentinel */ }
> +};
> +
> +static struct platform_driver sg2042_pll_driver =3D {
> +       .probe =3D sg2042_pll_probe,
> +       .driver =3D {
> +               .name =3D "clk-sophgo-sg2042-pll",
> +               .of_match_table =3D sg2042_pll_match,
> +               .suppress_bind_attrs =3D true,
> +       },
> +};
> +builtin_platform_driver(sg2042_pll_driver);
> diff --git a/drivers/clk/sophgo/clk-sophgo-sg2042.h b/drivers/clk/sophgo/=
clk-sophgo-sg2042.h
> new file mode 100644
> index 000000000000..407fec6f3f02
> --- /dev/null
> +++ b/drivers/clk/sophgo/clk-sophgo-sg2042.h
> @@ -0,0 +1,216 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __CLK_SOPHGO_SG2042_H
> +#define __CLK_SOPHGO_SG2042_H
> +
> +/* Registers defined in SYS_CTRL */
> +#define R_PLL_BEGIN            0xC0
> +#define R_PLL_STAT             (0xC0 - R_PLL_BEGIN)
> +#define R_PLL_CLKEN_CONTROL    (0xC4 - R_PLL_BEGIN)
> +#define R_MPLL_CONTROL         (0xE8 - R_PLL_BEGIN)
> +#define R_FPLL_CONTROL         (0xF4 - R_PLL_BEGIN)
> +#define R_DPLL0_CONTROL                (0xF8 - R_PLL_BEGIN)
> +#define R_DPLL1_CONTROL                (0xFC - R_PLL_BEGIN)
> +
> +#define R_SYSGATE_BEGIN                0x0368
> +#define R_RP_RXU_CLK_ENABLE    (0x0368 - R_SYSGATE_BEGIN)
> +#define R_MP0_STATUS_REG       (0x0380 - R_SYSGATE_BEGIN)
> +#define R_MP0_CONTROL_REG      (0x0384 - R_SYSGATE_BEGIN)
> +#define R_MP1_STATUS_REG       (0x0388 - R_SYSGATE_BEGIN)
> +#define R_MP1_CONTROL_REG      (0x038C - R_SYSGATE_BEGIN)
> +#define R_MP2_STATUS_REG       (0x0390 - R_SYSGATE_BEGIN)
> +#define R_MP2_CONTROL_REG      (0x0394 - R_SYSGATE_BEGIN)
> +#define R_MP3_STATUS_REG       (0x0398 - R_SYSGATE_BEGIN)
> +#define R_MP3_CONTROL_REG      (0x039C - R_SYSGATE_BEGIN)
> +#define R_MP4_STATUS_REG       (0x03A0 - R_SYSGATE_BEGIN)
> +#define R_MP4_CONTROL_REG      (0x03A4 - R_SYSGATE_BEGIN)
> +#define R_MP5_STATUS_REG       (0x03A8 - R_SYSGATE_BEGIN)
> +#define R_MP5_CONTROL_REG      (0x03AC - R_SYSGATE_BEGIN)
> +#define R_MP6_STATUS_REG       (0x03B0 - R_SYSGATE_BEGIN)
> +#define R_MP6_CONTROL_REG      (0x03B4 - R_SYSGATE_BEGIN)
> +#define R_MP7_STATUS_REG       (0x03B8 - R_SYSGATE_BEGIN)
> +#define R_MP7_CONTROL_REG      (0x03BC - R_SYSGATE_BEGIN)
> +#define R_MP8_STATUS_REG       (0x03C0 - R_SYSGATE_BEGIN)
> +#define R_MP8_CONTROL_REG      (0x03C4 - R_SYSGATE_BEGIN)
> +#define R_MP9_STATUS_REG       (0x03C8 - R_SYSGATE_BEGIN)
> +#define R_MP9_CONTROL_REG      (0x03CC - R_SYSGATE_BEGIN)
> +#define R_MP10_STATUS_REG      (0x03D0 - R_SYSGATE_BEGIN)
> +#define R_MP10_CONTROL_REG     (0x03D4 - R_SYSGATE_BEGIN)
> +#define R_MP11_STATUS_REG      (0x03D8 - R_SYSGATE_BEGIN)
> +#define R_MP11_CONTROL_REG     (0x03DC - R_SYSGATE_BEGIN)
> +#define R_MP12_STATUS_REG      (0x03E0 - R_SYSGATE_BEGIN)
> +#define R_MP12_CONTROL_REG     (0x03E4 - R_SYSGATE_BEGIN)
> +#define R_MP13_STATUS_REG      (0x03E8 - R_SYSGATE_BEGIN)
> +#define R_MP13_CONTROL_REG     (0x03EC - R_SYSGATE_BEGIN)
> +#define R_MP14_STATUS_REG      (0x03F0 - R_SYSGATE_BEGIN)
> +#define R_MP14_CONTROL_REG     (0x03F4 - R_SYSGATE_BEGIN)
> +#define R_MP15_STATUS_REG      (0x03F8 - R_SYSGATE_BEGIN)
> +#define R_MP15_CONTROL_REG     (0x03FC - R_SYSGATE_BEGIN)
> +
> +/* Registers defined in CLOCK */
> +#define R_CLKENREG0            0x00
> +#define R_CLKENREG1            0x04
> +#define R_CLKSELREG0           0x20
> +#define R_CLKDIVREG0           0x40
> +#define R_CLKDIVREG1           0x44
> +#define R_CLKDIVREG2           0x48
> +#define R_CLKDIVREG3           0x4C
> +#define R_CLKDIVREG4           0x50
> +#define R_CLKDIVREG5           0x54
> +#define R_CLKDIVREG6           0x58
> +#define R_CLKDIVREG7           0x5C
> +#define R_CLKDIVREG8           0x60
> +#define R_CLKDIVREG9           0x64
> +#define R_CLKDIVREG10          0x68
> +#define R_CLKDIVREG11          0x6C
> +#define R_CLKDIVREG12          0x70
> +#define R_CLKDIVREG13          0x74
> +#define R_CLKDIVREG14          0x78
> +#define R_CLKDIVREG15          0x7C
> +#define R_CLKDIVREG16          0x80
> +#define R_CLKDIVREG17          0x84
> +#define R_CLKDIVREG18          0x88
> +#define R_CLKDIVREG19          0x8C
> +#define R_CLKDIVREG20          0x90
> +#define R_CLKDIVREG21          0x94
> +#define R_CLKDIVREG22          0x98
> +#define R_CLKDIVREG23          0x9C
> +#define R_CLKDIVREG24          0xA0
> +#define R_CLKDIVREG25          0xA4
> +#define R_CLKDIVREG26          0xA8
> +#define R_CLKDIVREG27          0xAC
> +#define R_CLKDIVREG28          0xB0
> +#define R_CLKDIVREG29          0xB4
> +#define R_CLKDIVREG30          0xB8
> +
> +/*
> + * Common data of clock-controller
> + * Note: this structure will be used both by clkgen & sysclk.
> + * @iobase: base address of clock-controller
> + * @onecell_data: used for adding providers.
> + */
> +struct sg2042_clk_data {
> +       void __iomem *iobase;
> +       struct clk_hw_onecell_data onecell_data;
> +};
> +
> +/*
> + * PLL clock
> + * @hw:                                clk_hw for initialization
> + * @id:                                used to map clk_onecell_data
> + * @base:                      used for readl/writel.
> + *                             **NOTE**: PLL registers are all in SYS_CT=
RL!
> + * @lock:                      spinlock to protect register access, modi=
fication
> + *                             of frequency can only be served one at th=
e time.
> + * @offset_status:             offset of pll status registers
> + * @offset_enable:             offset of pll enable registers
> + * @offset_ctrl:               offset of pll control registers
> + * @shift_status_lock:         shift of XXX_LOCK in pll status register
> + * @shift_status_updating:     shift of UPDATING_XXX in pll status regis=
ter
> + * @shift_enable:              shift of XXX_CLK_EN in pll enable register
> + */
> +struct sg2042_pll_clock {
> +       struct clk_hw hw;
> +
> +       unsigned int id;
> +       void __iomem *base;
> +       /* protect register access */
> +       spinlock_t *lock;
> +
> +       u32 offset_status;
> +       u32 offset_enable;
> +       u32 offset_ctrl;
> +       u8 shift_status_lock;
> +       u8 shift_status_updating;
> +       u8 shift_enable;
> +};
> +
> +#define to_sg2042_pll_clk(_hw) container_of(_hw, struct sg2042_pll_clock=
, hw)
> +
> +/*
> + * Divider clock
> + * @hw:                        clk_hw for initialization
> + * @id:                        used to map clk_onecell_data
> + * @reg:               used for readl/writel.
> + *                     **NOTE**: DIV registers are ALL in CLOCK!
> + * @lock:              spinlock to protect register access, modification=
 of
> + *                     frequency can only be served one at the time
> + * @offset_ctrl:       offset of divider control registers
> + * @shift:             shift of "Clock Divider Factor" in divider contro=
l register
> + * @width:             width of "Clock Divider Factor" in divider contro=
l register
> + * @div_flags:         private flags for this clock, not for framework-s=
pecific
> + * @initval:           In the divider control register, we can configure=
 whether
> + *                     to use the value of "Clock Divider Factor" or jus=
t use
> + *                     the initial value pre-configured by IC. BIT[3] co=
ntrols
> + *                     this and by default (value is 0), means initial v=
alue
> + *                     is used.
> + *                     **NOTE** that we cannot read the initial value (d=
efault
> + *                     value when poweron) and default value of "Clock D=
ivider
> + *                     Factor" is zero, which I think is a hardware desi=
gn flaw
> + *                     and should be sync-ed with the initial value. So =
in
> + *                     software we have to add a configuration item (ini=
tval)
> + *                     to manually configure this value and use it when =
BIT[3]
> + *                     is zero.

Do you use the init clk_op for this?

> + */
> +struct sg2042_divider_clock {
> +       struct clk_hw hw;
> +
> +       unsigned int id;
> +
> +       void __iomem *reg;
> +       /* protect register access */
> +       spinlock_t *lock;
> +
> +       unsigned long offset_ctrl;
> +       u8 shift;
> +       u8 width;
> +       u8 div_flags;
> +       u32 initval;
> +};
> +
> +#define to_sg2042_clk_divider(_hw)     \
> +       container_of(_hw, struct sg2042_divider_clock, hw)
> +
> +/*
> + * Gate clock
> + * @hw:                        clk_hw for initialization
> + * @id:                        used to map clk_onecell_data
> + * @offset_enable:     offset of gate enable registers
> + * @bit_idx:           which bit in the register controls gating of this=
 clock
> + */
> +struct sg2042_gate_clock {
> +       struct clk_hw hw;
> +
> +       unsigned int id;
> +
> +       unsigned long offset_enable;

Usually we use a u32 or a shorter size so that the member width is
unchanged on different CPU architecture.

> +       u8 bit_idx;
> +};
> +
> +/*
> + * Mux clock

Please use kernel doc. See https://docs.kernel.org/doc-guide/kernel-doc.html

> + * @hw:                        clk_hw for initialization
> + * @id:                        used to map clk_onecell_data
> + * @offset_select:     offset of mux selection registers
> + *                     **NOTE**: MUX registers are ALL in CLOCK!
> + * @shift:             shift of "Clock Select" in mux selection register

Is "Clock select" actually @offset_select?

> + * @width:             width of "Clock Select" in mux selection register
> + * @clk_nb:            used for notification
> + * @original_index:    set by notifier callback
> + */
> +struct sg2042_mux_clock {
> +       struct clk_hw hw;
> +
> +       unsigned int id;
> +
> +       unsigned long offset_select;
> +       u8 shift;
> +       u8 width;
> +
> +       struct notifier_block clk_nb;
> +       u8 original_index;
> +};
> +

