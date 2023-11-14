Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8267EAE2C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 11:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjKNKjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 05:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjKNKji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 05:39:38 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A957183
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 02:39:32 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32fe1a29010so3174542f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 02:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699958371; x=1700563171; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=XQsaOBOBvlAnBiaiK0C7fLFVweqJdxNEI9sTPKkmHeE=;
        b=u9uLSuYIELSGDNEzK2TRHmR5o9ACSSESMgyxUsqTveyX+hwxFBOPZp1slgEEeBR/yi
         oaOX8Y4QCshATlJGcU5vuJZolX2bjm/Ma+7qu5iPHAv9P/eLZn0K4QfHA3kTN2s8Dg60
         nRQENSX07cxObJQJjdv0dIENkrOCTpbSUa/8hk5sLeOtcL2Tp1nAEbNlg9MpReSuw5Vk
         QHZJnOxSdXMRJkWhsBqLf/WXdiYHyKF926+zQk/3woDNPqtx1ltJaCPCFiLjxRTpFoq3
         AX1UlKm9ThsLcshcle236QUmT1W5Ow4Jy9vRPJRzotj9XXN0kmWLC2cnakh1JNwe+nRd
         gIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699958371; x=1700563171;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQsaOBOBvlAnBiaiK0C7fLFVweqJdxNEI9sTPKkmHeE=;
        b=je6KZHfQoPtwUyrAwK11nmewAP7lCMY8vMFrJEgTMoxaBenjqKpJk+7onfVuykC3Xw
         C5Q90VWclbIg7Izxv/lkHlWM9zlbW3NxwMCTwbBR7cpwvOhxjNOuMP4II26wZRXJqcyX
         8FRquPVVYsWKb9JwyGz8d99F5KJRQUEorimnxD+M/sotJGCT20YkMzGcJ5/fFD7Eieos
         79L+dDS+E+00vlBGowXr6/f4LHmFpSQw8obOgZcsoDEiZj3JM4nrKg+TslWjVMgwU7Qr
         wT4jBcSl2V3KEZltSMFDIFQ4vB+tJwgn6kvVBGjDil64ytUh5F6UDsIAyLQViE6hSmaY
         QSTg==
X-Gm-Message-State: AOJu0Yw0OHnjGXaGxpxc9vAO3C5XhETxg+xWgS1S7sq4PgX5zIqnNzVR
        LpY4tY8IhgRf1344D3h8jLDdHQ==
X-Google-Smtp-Source: AGHT+IE6i+XUjMzDZha+x9uy2ONVSJDhZHFc1B7Cj3qMOEUv5qoLdNiiaSwmPkFCAAH0bwKipxoq8w==
X-Received: by 2002:adf:b34e:0:b0:32f:7d21:fd7b with SMTP id k14-20020adfb34e000000b0032f7d21fd7bmr5677014wrd.39.1699958370853;
        Tue, 14 Nov 2023 02:39:30 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:8fe7:3223:c57b:4b01])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d58c9000000b0032d9caeab0fsm7507258wrf.77.2023.11.14.02.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 02:39:30 -0800 (PST)
References: <20231106085554.3237511-1-xianwei.zhao@amlogic.com>
 <20231106085554.3237511-4-xianwei.zhao@amlogic.com>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chuan Liu <chuan.liu@amlogic.com>
Subject: Re: [PATCH V6 3/4] clk: meson: c3: add support for the C3 SoC PLL
 clock
Date:   Tue, 14 Nov 2023 11:25:40 +0100
In-reply-to: <20231106085554.3237511-4-xianwei.zhao@amlogic.com>
Message-ID: <1jttpobov2.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 06 Nov 2023 at 16:55, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:

> Add the C3 PLL clock controller driver for the Amlogic C3 SoC family.
>
> Co-developed-by: Chuan Liu <chuan.liu@amlogic.com>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>

Just a few things to address

> ---
>  drivers/clk/meson/Kconfig  |  13 +
>  drivers/clk/meson/Makefile |   1 +
>  drivers/clk/meson/c3-pll.c | 895 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 909 insertions(+)
>  create mode 100644 drivers/clk/meson/c3-pll.c
>
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index c5303e4c1604..eab796f3d25b 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -128,6 +128,19 @@ config COMMON_CLK_A1_PERIPHERALS
>  	  device, A1 SoC Family. Say Y if you want A1 Peripherals clock
>  	  controller to work.
>  
> +config COMMON_CLK_C3_PLL
> +	tristate "Amlogic C3 PLL clock controller"
> +	depends on ARM64
> +	default y
> +	select COMMON_CLK_MESON_REGMAP
> +	select COMMON_CLK_MESON_PLL
> +	select COMMON_CLK_MESON_CLKC_UTILS
> +	help
> +	  Support for the PLL clock controller on Amlogic C302X and C308L devices,
> +	  AKA c3. Amlogic C302X and C308L devices include AW402 and the others.
> +	  Say Y if you want the board to work, because PLLs are the parent of most
> +	  peripherals.
> +
>  config COMMON_CLK_G12A
>  	tristate "G12 and SM1 SoC clock controllers support"
>  	depends on ARM64
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 9ee4b954c896..4420af628b31 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>  obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>  obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
> +obj-$(CONFIG_COMMON_CLK_C3_PLL) += c3-pll.o
>  obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
> diff --git a/drivers/clk/meson/c3-pll.c b/drivers/clk/meson/c3-pll.c
> new file mode 100644
> index 000000000000..b663666e3755
> --- /dev/null
> +++ b/drivers/clk/meson/c3-pll.c
> @@ -0,0 +1,895 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Amlogic C3 PLL Controller Driver
> + *
> + * Copyright (c) 2023 Amlogic, inc.
> + * Author: Chuan Liu <chuan.liu@amlogic.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>

What do you need that for ? you are not the using the clock consumer api.

> +#include "clk-regmap.h"
> +#include "clk-pll.h"
> +#include "meson-clkc-utils.h"
> +#include <dt-bindings/clock/amlogic,c3-pll-clkc.h>
> +
> +#define ANACTRL_FIXPLL_CTRL0			0x40
> +#define ANACTRL_FIXPLL_CTRL4			0x50
> +#define ANACTRL_GP0PLL_CTRL0			0x80
> +#define ANACTRL_GP0PLL_CTRL1			0x84
> +#define ANACTRL_GP0PLL_CTRL2			0x88
> +#define ANACTRL_GP0PLL_CTRL3			0x8c
> +#define ANACTRL_GP0PLL_CTRL4			0x90
> +#define ANACTRL_GP0PLL_CTRL5			0x94
> +#define ANACTRL_GP0PLL_CTRL6			0x98
> +#define ANACTRL_GP0PLL_STS			0x9c
> +#define ANACTRL_GP1PLL_CTRL0			0xc0
> +#define ANACTRL_GP1PLL_CTRL1			0xc4
> +#define ANACTRL_GP1PLL_CTRL2			0xc8
> +#define ANACTRL_GP1PLL_CTRL3			0xcc
> +#define ANACTRL_GP1PLL_CTRL4			0xd0
> +#define ANACTRL_GP1PLL_CTRL5			0xd4
> +#define ANACTRL_GP1PLL_CTRL6			0xd8
> +#define ANACTRL_GP1PLL_STS			0xdc
> +#define ANACTRL_HIFIPLL_CTRL0			0x100
> +#define ANACTRL_HIFIPLL_CTRL1			0x104
> +#define ANACTRL_HIFIPLL_CTRL2			0x108
> +#define ANACTRL_HIFIPLL_CTRL3			0x10c
> +#define ANACTRL_HIFIPLL_CTRL4			0x110
> +#define ANACTRL_HIFIPLL_CTRL5			0x114
> +#define ANACTRL_HIFIPLL_CTRL6			0x118
> +#define ANACTRL_HIFIPLL_STS			0x11c
> +#define ANACTRL_MPLL_CTRL0			0x180
> +#define ANACTRL_MPLL_CTRL1			0x184
> +#define ANACTRL_MPLL_CTRL2			0x188
> +#define ANACTRL_MPLL_CTRL3			0x18c
> +#define ANACTRL_MPLL_CTRL4			0x190
> +#define ANACTRL_MPLL_STS			0x1a4
> +
> +/*
> + * These clock are a fixed value (fixed_pll is 2GHz) that is initialized by ROMcode.

"This clock has a fixed rate" ?

Just wondering, is it really the ROMcode doing this ?

I'm sure the ROMcode must do some init but from the information
that has surfaced recently on IRC for the GXBB and GXL, it
looks like the final fixed PLL init is done by the bl2. Is it different
on the C3 family ?

> + * The chip was changed fixed pll for security reasons. Fixed PLL registers are not writable
> + * in the kernel phase. Write of fixed PLL-related register will cause the system to crash.
> + * Meanwhile, these clock won't ever change at runtime.
> + * For the above reasons, we can only use ro_ops for fixed PLL related clocks.
> + */
> +static struct clk_regmap fixed_pll_dco = {
> +	.data = &(struct meson_clk_pll_data) {
> +		.en = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.m = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
> +			.shift   = 0,
> +			.width   = 8,
> +		},
> +		.n = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
> +			.shift   = 16,
> +			.width   = 5,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.rst = {
> +			.reg_off = ANACTRL_FIXPLL_CTRL0,
> +			.shift   = 29,
> +			.width   = 1,
> +		},
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fixed_pll_dco",
> +		.ops = &meson_clk_pll_ro_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "top",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap fixed_pll = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = ANACTRL_FIXPLL_CTRL0,
> +		.shift = 12,
> +		.width = 3,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fixed_pll",
> +		.ops = &clk_regmap_divider_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fixed_pll_dco.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap fclk_50m_en = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ANACTRL_FIXPLL_CTRL4,
> +		.bit_idx = 0,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_50m_en",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fixed_pll.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor fclk_50m = {
> +	.mult = 1,
> +	.div = 40,
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_50m",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fclk_50m_en.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor fclk_div2_div = {
> +	.mult = 1,
> +	.div = 2,
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_div2_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fixed_pll.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap fclk_div2 = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ANACTRL_FIXPLL_CTRL4,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_div2",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fclk_div2_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor fclk_div2p5_div = {
> +	.mult = 2,
> +	.div = 5,
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_div2p5_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fixed_pll.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap fclk_div2p5 = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ANACTRL_FIXPLL_CTRL4,
> +		.bit_idx = 4,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_div2p5",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fclk_div2p5_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor fclk_div3_div = {
> +	.mult = 1,
> +	.div = 3,
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_div3_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fixed_pll.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap fclk_div3 = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ANACTRL_FIXPLL_CTRL4,
> +		.bit_idx = 20,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_div3",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fclk_div3_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor fclk_div4_div = {
> +	.mult = 1,
> +	.div = 4,
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_div4_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fixed_pll.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap fclk_div4 = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ANACTRL_FIXPLL_CTRL4,
> +		.bit_idx = 21,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_div4",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fclk_div4_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor fclk_div5_div = {
> +	.mult = 1,
> +	.div = 5,
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_div5_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fixed_pll.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap fclk_div5 = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ANACTRL_FIXPLL_CTRL4,
> +		.bit_idx = 22,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_div5",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fclk_div5_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor fclk_div7_div = {
> +	.mult = 1,
> +	.div = 7,
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_div7_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fixed_pll.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap fclk_div7 = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ANACTRL_FIXPLL_CTRL4,
> +		.bit_idx = 23,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_div7",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fclk_div7_div.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static const struct reg_sequence c3_gp0_init_regs[] = {
> +	{ .reg = ANACTRL_GP0PLL_CTRL2,	.def = 0x0 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL3,	.def = 0x48681c00 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL4,  .def = 0x88770290 },
> +	{ .reg = ANACTRL_GP0PLL_CTRL5,  .def = 0x3927200a },
> +	{ .reg = ANACTRL_GP0PLL_CTRL6,	.def = 0x56540000 },
> +};
> +
> +static const struct pll_mult_range c3_gp0_pll_mult_range = {
> +	.min = 125,
> +	.max = 250,
> +};
> +
> +static struct clk_regmap gp0_pll_dco = {
> +	.data = &(struct meson_clk_pll_data) {
> +		.en = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.m = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 0,
> +			.width   = 9,
> +		},
> +		.frac = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL1,
> +			.shift   = 0,
> +			.width   = 19,
> +		},
> +		.n = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 10,
> +			.width   = 5,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.rst = {
> +			.reg_off = ANACTRL_GP0PLL_CTRL0,
> +			.shift   = 29,
> +			.width   = 1,
> +		},
> +		.range = &c3_gp0_pll_mult_range,
> +		.init_regs = c3_gp0_init_regs,
> +		.init_count = ARRAY_SIZE(c3_gp0_init_regs),
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "gp0_pll_dco",
> +		.ops = &meson_clk_pll_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "top",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +/* The maximum frequency divider supports is 32, not 128(2^7) */
> +static const struct clk_div_table c3_gp0_pll_od_table[] = {
> +	{ 0,  1 },
> +	{ 1,  2 },
> +	{ 2,  4 },
> +	{ 3,  8 },
> +	{ 4, 16 },
> +	{ 5, 32 },
> +	{ /* sentinel */ }
> +};
> +
> +static struct clk_regmap gp0_pll = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = ANACTRL_GP0PLL_CTRL0,
> +		.shift = 16,
> +		.width = 3,
> +		.table = c3_gp0_pll_od_table,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "gp0_pll",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&gp0_pll_dco.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +/*
> + * The register corresponding to gp1_pll has permission restrictions,
> + * The corresponding register is read-only in the kernel.
> + * For the above reasons, we can only use ro_ops for gp1_pll related clocks.
> + */
> +static struct clk_regmap gp1_pll_dco = {
> +	.data = &(struct meson_clk_pll_data) {
> +		.en = {
> +			.reg_off = ANACTRL_GP1PLL_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.m = {
> +			.reg_off = ANACTRL_GP1PLL_CTRL0,
> +			.shift   = 0,
> +			.width   = 9,
> +		},
> +		.frac = {
> +			.reg_off = ANACTRL_GP1PLL_CTRL1,
> +			.shift   = 0,
> +			.width   = 19,
> +		},
> +		.n = {
> +			.reg_off = ANACTRL_GP1PLL_CTRL0,
> +			.shift   = 10,
> +			.width   = 5,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_GP1PLL_CTRL0,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.rst = {
> +			.reg_off = ANACTRL_GP1PLL_CTRL0,
> +			.shift   = 29,
> +			.width   = 1,
> +		},
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "gp1_pll_dco",
> +		.ops = &meson_clk_pll_ro_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "top",
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_GET_RATE_NOCACHE,
> +	},
> +};
> +
> +static struct clk_regmap gp1_pll = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = ANACTRL_GP1PLL_CTRL0,
> +		.shift = 16,
> +		.width = 3,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "gp1_pll",
> +		.ops = &clk_regmap_divider_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&gp1_pll_dco.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_GET_RATE_NOCACHE,
> +	},
> +};
> +
> +static const struct reg_sequence c3_hifi_init_regs[] = {
> +	{ .reg = ANACTRL_HIFIPLL_CTRL2,	.def = 0x0 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL3,	.def = 0x6a285c00 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL4, .def = 0x65771290 },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL5, .def = 0x3927200a },
> +	{ .reg = ANACTRL_HIFIPLL_CTRL6,	.def = 0x56540000 },
> +};
> +
> +static struct clk_regmap hifi_pll_dco = {
> +	.data = &(struct meson_clk_pll_data) {
> +		.en = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.m = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 0,
> +			.width   = 8,
> +		},
> +		.frac = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL1,
> +			.shift   = 0,
> +			.width   = 19,
> +		},
> +		.n = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 10,
> +			.width   = 5,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.rst = {
> +			.reg_off = ANACTRL_HIFIPLL_CTRL0,
> +			.shift   = 29,
> +			.width   = 1,
> +		},
> +		.range = &c3_gp0_pll_mult_range,
> +		.init_regs = c3_hifi_init_regs,
> +		.init_count = ARRAY_SIZE(c3_hifi_init_regs),
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "hifi_pll_dco",
> +		.ops = &meson_clk_pll_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "top",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap hifi_pll = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = ANACTRL_HIFIPLL_CTRL0,
> +		.shift = 16,
> +		.width = 2,
> +		.flags = CLK_DIVIDER_POWER_OF_TWO,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "hifi_pll",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&hifi_pll_dco.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct reg_sequence c3_mclk_init_regs[] = {
> +	{ .reg = ANACTRL_MPLL_CTRL1,	.def = 0x1420500f },
> +	{ .reg = ANACTRL_MPLL_CTRL2,	.def = 0x00023041 },
> +	{ .reg = ANACTRL_MPLL_CTRL3,	.def = 0x18180000 },
> +	{ .reg = ANACTRL_MPLL_CTRL2,	.def = 0x00023001 }
> +};
> +
> +static const struct pll_mult_range c3_mclk_pll_mult_range = {
> +	.min = 67,
> +	.max = 133,
> +};
> +
> +static struct clk_regmap mclk_pll_dco = {
> +	.data = &(struct meson_clk_pll_data) {
> +		.en = {
> +			.reg_off = ANACTRL_MPLL_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.m = {
> +			.reg_off = ANACTRL_MPLL_CTRL0,
> +			.shift   = 0,
> +			.width   = 8,
> +		},
> +		.n = {
> +			.reg_off = ANACTRL_MPLL_CTRL0,
> +			.shift   = 10,
> +			.width   = 5,
> +		},
> +		.l = {
> +			.reg_off = ANACTRL_MPLL_CTRL0,
> +			.shift   = 31,
> +			.width   = 1,
> +		},
> +		.rst = {
> +			.reg_off = ANACTRL_MPLL_CTRL0,
> +			.shift   = 29,
> +			.width   = 1,
> +		},
> +		.range = &c3_mclk_pll_mult_range,
> +		.init_regs = c3_mclk_init_regs,
> +		.init_count = ARRAY_SIZE(c3_mclk_init_regs),
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mclk_pll_dco",
> +		.ops = &meson_clk_pll_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "mpll",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static const struct clk_div_table c3_mpll_od_table[] = {
> +	{ 0,  1 },
> +	{ 1,  2 },
> +	{ 2,  4 },
> +	{ 3,  8 },
> +	{ 4, 16 },
> +	{ /* sentinel */ }
> +};
> +
> +static struct clk_regmap mclk_pll_od = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = ANACTRL_MPLL_CTRL0,
> +		.shift = 12,
> +		.width = 3,
> +		.table = c3_mpll_od_table,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mclk_pll_od",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&mclk_pll_dco.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +/* both value 0 and 1 gives divide the input rate by one */
> +static struct clk_regmap mclk_pll = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = ANACTRL_MPLL_CTRL4,
> +		.shift = 16,
> +		.width = 5,
> +		.flags = CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ALLOW_ZERO,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mclk_pll",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&mclk_pll_od.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data mclk_parent[] = {
> +	{ .hw = &mclk_pll.hw },
> +	{ .fw_name = "mpll" },
> +	{ .hw = &fclk_50m.hw }
> +};
> +
> +static struct clk_regmap mclk0_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = ANACTRL_MPLL_CTRL4,
> +		.mask = 0x3,
> +		.shift = 4,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mclk0_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = mclk_parent,
> +		.num_parents = ARRAY_SIZE(mclk_parent),
> +	},
> +};
> +
> +static struct clk_regmap mclk0_div_en = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ANACTRL_MPLL_CTRL4,
> +		.bit_idx = 1,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mclk0_div_en",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&mclk0_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap mclk0_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = ANACTRL_MPLL_CTRL4,
> +		.shift = 2,
> +		.width = 1,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mclk0_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&mclk0_div_en.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap mclk0 = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ANACTRL_MPLL_CTRL4,
> +		.bit_idx = 0,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mclk0",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&mclk0_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap mclk1_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = ANACTRL_MPLL_CTRL4,
> +		.mask = 0x3,
> +		.shift = 12,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mclk1_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = mclk_parent,
> +		.num_parents = ARRAY_SIZE(mclk_parent),
> +	},
> +};
> +
> +static struct clk_regmap mclk1_div_en = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ANACTRL_MPLL_CTRL4,
> +		.bit_idx = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mclk1_div_en",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&mclk1_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap mclk1_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = ANACTRL_MPLL_CTRL4,
> +		.shift = 10,
> +		.width = 1,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mclk1_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&mclk1_div_en.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap mclk1 = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ANACTRL_MPLL_CTRL4,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mclk1",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&mclk1_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_hw *c3_pll_hw_clks[] = {
> +	[CLKID_FIXED_PLL_DCO]	= &fixed_pll_dco.hw,
> +	[CLKID_FIXED_PLL]	= &fixed_pll.hw,
> +	[CLKID_FCLK_50M_EN]	= &fclk_50m_en.hw,
> +	[CLKID_FCLK_50M]	= &fclk_50m.hw,
> +	[CLKID_FCLK_DIV2_DIV]	= &fclk_div2_div.hw,
> +	[CLKID_FCLK_DIV2]	= &fclk_div2.hw,
> +	[CLKID_FCLK_DIV2P5_DIV]	= &fclk_div2p5_div.hw,
> +	[CLKID_FCLK_DIV2P5]	= &fclk_div2p5.hw,
> +	[CLKID_FCLK_DIV3_DIV]	= &fclk_div3_div.hw,
> +	[CLKID_FCLK_DIV3]	= &fclk_div3.hw,
> +	[CLKID_FCLK_DIV4_DIV]	= &fclk_div4_div.hw,
> +	[CLKID_FCLK_DIV4]	= &fclk_div4.hw,
> +	[CLKID_FCLK_DIV5_DIV]	= &fclk_div5_div.hw,
> +	[CLKID_FCLK_DIV5]	= &fclk_div5.hw,
> +	[CLKID_FCLK_DIV7_DIV]	= &fclk_div7_div.hw,
> +	[CLKID_FCLK_DIV7]	= &fclk_div7.hw,
> +	[CLKID_GP0_PLL_DCO]	= &gp0_pll_dco.hw,
> +	[CLKID_GP0_PLL]		= &gp0_pll.hw,
> +	[CLKID_GP1_PLL_DCO]	= &gp1_pll_dco.hw,
> +	[CLKID_GP1_PLL]		= &gp1_pll.hw,
> +	[CLKID_HIFI_PLL_DCO]	= &hifi_pll_dco.hw,
> +	[CLKID_HIFI_PLL]	= &hifi_pll.hw,
> +	[CLKID_MCLK_PLL_DCO]	= &mclk_pll_dco.hw,
> +	[CLKID_MCLK_PLL_OD]	= &mclk_pll_od.hw,
> +	[CLKID_MCLK_PLL]	= &mclk_pll.hw,
> +	[CLKID_MCLK0_SEL]	= &mclk0_sel.hw,
> +	[CLKID_MCLK0_SEL_EN]	= &mclk0_div_en.hw,
> +	[CLKID_MCLK0_DIV]	= &mclk0_div.hw,
> +	[CLKID_MCLK0]		= &mclk0.hw,
> +	[CLKID_MCLK1_SEL]	= &mclk1_sel.hw,
> +	[CLKID_MCLK1_SEL_EN]	= &mclk1_div_en.hw,
> +	[CLKID_MCLK1_DIV]	= &mclk1_div.hw,
> +	[CLKID_MCLK1]		= &mclk1.hw
> +};
> +
> +/* Convenience table to populate regmap in .probe */
> +static struct clk_regmap *const c3_pll_clk_regmaps[] = {
> +	&fixed_pll_dco,
> +	&fixed_pll,
> +	&fclk_50m_en,
> +	&fclk_div2,
> +	&fclk_div2p5,
> +	&fclk_div3,
> +	&fclk_div4,
> +	&fclk_div5,
> +	&fclk_div7,
> +	&gp0_pll_dco,
> +	&gp0_pll,
> +	&gp1_pll_dco,
> +	&gp1_pll,
> +	&hifi_pll_dco,
> +	&hifi_pll,
> +	&mclk_pll_dco,
> +	&mclk_pll_od,
> +	&mclk_pll,
> +	&mclk0_sel,
> +	&mclk0_div_en,
> +	&mclk0_div,
> +	&mclk0,
> +	&mclk1_sel,
> +	&mclk1_div_en,
> +	&mclk1_div,
> +	&mclk1,
> +};
> +
> +static struct regmap_config clkc_regmap_config = {
> +	.reg_bits       = 32,
> +	.val_bits       = 32,
> +	.reg_stride     = 4,
> +};
> +
> +static struct meson_clk_hw_data c3_pll_clks = {
> +	.hws = c3_pll_hw_clks,
> +	.num = ARRAY_SIZE(c3_pll_hw_clks),
> +};
> +
> +static int aml_c3_pll_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct regmap *regmap;
> +	void __iomem *base;
> +	int clkid, ret, i;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	regmap = devm_regmap_init_mmio(dev, base, &clkc_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	/* Populate regmap for the regmap backed clocks */
> +	for (i = 0; i < ARRAY_SIZE(c3_pll_clk_regmaps); i++)
> +		c3_pll_clk_regmaps[i]->map = regmap;
> +
> +	for (clkid = 0; clkid < c3_pll_clks.num; clkid++) {
> +		/* array might be sparse */
> +		if (!c3_pll_clks.hws[clkid])
> +			continue;
> +
> +		ret = devm_clk_hw_register(dev, c3_pll_clks.hws[clkid]);
> +		if (ret) {
> +			dev_err(dev, "Clock registration failed\n");
> +			return ret;
> +		}
> +	}
> +
> +	return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get,
> +					   &c3_pll_clks);
> +}
> +
> +static const struct of_device_id c3_pll_clkc_match_table[] = {
> +	{
> +		.compatible = "amlogic,c3-pll-clkc",
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, c3_pll_clkc_match_table);
> +
> +static struct platform_driver c3_pll_driver = {
> +	.probe		= aml_c3_pll_probe,
> +	.driver		= {
> +		.name	= "c3-pll-clkc",
> +		.of_match_table = c3_pll_clkc_match_table,
> +	},
> +};
> +
> +module_platform_driver(c3_pll_driver);
> +MODULE_AUTHOR("Chuan Liu <chuan.liu@amlogic.com>");
> +MODULE_LICENSE("GPL");

