Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97C47EB08C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjKNNGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjKNNG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:06:29 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C906B196
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:06:15 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40838915cecso45373775e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699967174; x=1700571974; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=0RyRbQYftVOLedsRMTp1pht5q41J695GTgvrn1LOvNM=;
        b=hcTw8ZtdwCswtKMj9mNLubH5GSf7bGVxgPMinXuSVA23E/CA8oRblzXoxONtsJDvVv
         BOhev828DoYazITa37xYbT0nuOuzWNLF9Vx04Q4TZpFNLAHdc2koQr742zatqEsPa6bw
         e0Cph1prtjFeTOBiYji0KTsHTHy6mB3mw7KmkblZaC59kki5GTmUscj092GKfa55+Mz9
         VWUQhdCv3VxaQhBTqwMlUChbDmrf+lGit/LpBMBwDyW92fyCzzINbimLV66LdQ8YmAVf
         r2LTNCDUacqTB63I6B7qGWXfdxLDcG7unC87F9jc07JP8EPZ+/eCFxmDF41NHTl02EXc
         iCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699967174; x=1700571974;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RyRbQYftVOLedsRMTp1pht5q41J695GTgvrn1LOvNM=;
        b=Y4ZFxPvc2u0YY0vyizoFpOTYcrJiL1ZYIKke5csSQZKQbUXeFAYeRSCh4wNJ0eGY3s
         aTIaCpTJDMwxwXFISJ86qt8Xn2sdZyCcuKOFy5SDYaF6qY0WoLakRX3Tx/yWC6hJK/rU
         H4IKsYnvUGJkC8KOB6I85yTeHMK/oZVKgDlAZxiRnJsuRpoM8w3GKjNVTzuO4/cjy03U
         sPI4SXl3Ho/d/2f1yR7or5ot0qdbSUU+8nE0OEp0WpMoKOq5MIn4VovJQrdAzpeS/4lR
         P6rPjBTypCwhrCdGjuTR2mijH7m84brmTZZX0EcMWIbKRniU+sOkkInLIpqSUnJpcTPi
         chIQ==
X-Gm-Message-State: AOJu0YyMCErgrCl9PaHT0TRkIHtpUSBNIQwFi6aWrABnrrE1dtSGY+2E
        D+mFd291LhUHQKMywf360pLCwg==
X-Google-Smtp-Source: AGHT+IGQhoWkCh8qGdXbqygwHaz669OKnriwFr1hUGKC1etB4YDaI4Yi2dZhe6YOSDEQL7o/GQWjVQ==
X-Received: by 2002:a05:600c:4587:b0:409:7900:f3d0 with SMTP id r7-20020a05600c458700b004097900f3d0mr8112107wmo.34.1699967173583;
        Tue, 14 Nov 2023 05:06:13 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:8fe7:3223:c57b:4b01])
        by smtp.gmail.com with ESMTPSA id z22-20020a1c4c16000000b00403b63e87f2sm11301919wmf.32.2023.11.14.05.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 05:06:12 -0800 (PST)
References: <20231106085554.3237511-1-xianwei.zhao@amlogic.com>
 <20231106085554.3237511-5-xianwei.zhao@amlogic.com>
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
Subject: Re: [PATCH V6 4/4] clk: meson: c3: add c3 clock peripherals
 controller driver
Date:   Tue, 14 Nov 2023 11:39:53 +0100
In-reply-to: <20231106085554.3237511-5-xianwei.zhao@amlogic.com>
Message-ID: <1jpm0cbi2j.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 06 Nov 2023 at 16:55, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:

> Add the C3 peripherals clock controller driver in the C3 SoC family.
>
> Co-developed-by: Chuan Liu <chuan.liu@amlogic.com>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  drivers/clk/meson/Kconfig          |   13 +
>  drivers/clk/meson/Makefile         |    1 +
>  drivers/clk/meson/c3-peripherals.c | 2745 ++++++++++++++++++++++++++++
>  3 files changed, 2759 insertions(+)
>  create mode 100644 drivers/clk/meson/c3-peripherals.c
>
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index eab796f3d25b..f3ad3030a6b9 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -141,6 +141,19 @@ config COMMON_CLK_C3_PLL
>  	  Say Y if you want the board to work, because PLLs are the parent of most
>  	  peripherals.
>  
> +config COMMON_CLK_C3_PERIPHERALS
> +	tristate "Amlogic C3 peripherals clock controller"
> +	depends on ARM64
> +	default y
> +	select COMMON_CLK_MESON_REGMAP
> +	select COMMON_CLK_MESON_DUALDIV
> +	select COMMON_CLK_MESON_CLKC_UTILS
> +	help
> +	  Support for the Peripherals clock controller on Amlogic C302X and
> +	  C308L devices, AKA c3. Amlogic C302X and C308L devices include
> +	  AW402 and others. Say Y if you want the peripherals clock to

What is the AW402 ? if it is a board, then this is not the place to
mention it.

> +	  work.
> +
>  config COMMON_CLK_G12A
>  	tristate "G12 and SM1 SoC clock controllers support"
>  	depends on ARM64
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 4420af628b31..20ad9482c892 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>  obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>  obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
>  obj-$(CONFIG_COMMON_CLK_C3_PLL) += c3-pll.o
> +obj-$(CONFIG_COMMON_CLK_C3_PERIPHERALS) += c3-peripherals.o
>  obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
> diff --git a/drivers/clk/meson/c3-peripherals.c b/drivers/clk/meson/c3-peripherals.c
> new file mode 100644
> index 000000000000..ea0f71d4deb0
> --- /dev/null
> +++ b/drivers/clk/meson/c3-peripherals.c
> @@ -0,0 +1,2745 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Amlogic C3 Peripherals Clock Controller Driver
> + *
> + * Copyright (c) 2023 Amlogic, inc.
> + * Author: Chuan Liu <chuan.liu@amlogic.com>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>

Same

> +#include "clk-regmap.h"
> +#include "clk-dualdiv.h"
> +#include "meson-clkc-utils.h"
> +#include <dt-bindings/clock/amlogic,c3-peripherals-clkc.h>
> +
> +#define OSCIN_CTRL				0x4
> +#define RTC_BY_OSCIN_CTRL0			0x8
> +#define RTC_BY_OSCIN_CTRL1			0xc
> +#define RTC_CTRL				0x10
> +#define SYS_CLK_CTRL0				0x40
> +#define SYS_CLK_EN0_REG0			0x44
> +#define SYS_CLK_EN0_REG1			0x48
> +#define SYS_CLK_EN0_REG2			0x4c
> +#define AXI_CLK_CTRL0				0x6c
> +#define CLK12_24_CTRL				0xa8
> +#define AXI_CLK_EN0				0xac
> +#define VDIN_MEAS_CLK_CTRL			0xf8
> +#define VAPB_CLK_CTRL				0xfc
> +#define MIPIDSI_PHY_CLK_CTRL			0x104
> +#define GE2D_CLK_CTRL				0x10c
> +#define ISP0_CLK_CTRL				0x110
> +#define DEWARPA_CLK_CTRL			0x114
> +#define VOUTENC_CLK_CTRL			0x118
> +#define VDEC_CLK_CTRL				0x140
> +#define VDEC3_CLK_CTRL				0x148
> +#define TS_CLK_CTRL				0x158
> +#define ETH_CLK_CTRL				0x164
> +#define NAND_CLK_CTRL				0x168
> +#define SD_EMMC_CLK_CTRL			0x16c
> +#define SPICC_CLK_CTRL				0x174
> +#define GEN_CLK_CTRL				0x178
> +#define SAR_CLK_CTRL0				0x17c
> +#define PWM_CLK_AB_CTRL				0x180
> +#define PWM_CLK_CD_CTRL				0x184
> +#define PWM_CLK_EF_CTRL				0x188
> +#define PWM_CLK_GH_CTRL				0x18c
> +#define PWM_CLK_IJ_CTRL				0x190
> +#define PWM_CLK_KL_CTRL				0x194
> +#define PWM_CLK_MN_CTRL				0x198
> +#define VC9000E_CLK_CTRL			0x19c
> +#define SPIFC_CLK_CTRL				0x1a0
> +#define NNA_CLK_CTRL				0x220
> +
> +static struct clk_regmap pll_src = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = OSCIN_CTRL,
> +		.bit_idx = 4,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "pll_src",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "xtal_24m",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap mclk_pll_src = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = OSCIN_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mclk_pll_in",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "xtal_24m",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +/*
> + * These clocks can't be closed, the system will crash or

Nitpick: "closed" is not really applicable to clocks. stopped ? gated ?

> + * not work good for some peripherals if close,
> + * so use read-only ops.

If writeable and critical to the system, then maybe CLK_IS_CRITICAL is
more pertinent than ro ops.

> + */
> +static struct clk_regmap ddr_pll_src = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = OSCIN_CTRL,
> +		.bit_idx = 1,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "ddr_pll_src",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "xtal_24m",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap ddr_phy_src = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = OSCIN_CTRL,
> +		.bit_idx = 2,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "ddr_phy_src",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "xtal_24m",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap usb_pll_src = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = OSCIN_CTRL,
> +		.bit_idx = 6,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "usb_pll_src",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "xtal_24m",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap mipi_isp_vout_src = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = OSCIN_CTRL,
> +		.bit_idx = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mipi_isp_vout_src",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "xtal_24m",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap usb_ctrl_src = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = OSCIN_CTRL,
> +		.bit_idx = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "usb_ctrl_src",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "xtal_24m",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap eth_pll_src = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = OSCIN_CTRL,
> +		.bit_idx = 10,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "eth_pll_src",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "xtal_24m",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static const struct clk_parent_data cts_osc_src_parent_data[] = {
> +	{ .fw_name = "xtal_32k" },
> +	{ .fw_name = "xtal_24m" }
> +};
> +
> +static struct clk_regmap cts_osc_src = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = OSCIN_CTRL,
> +		.mask = 0x1,
> +		.shift = 31,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "cts_osc_src",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = cts_osc_src_parent_data,
> +		.num_parents = ARRAY_SIZE(cts_osc_src_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap rtc_xtal_clkin = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = RTC_BY_OSCIN_CTRL0,
> +		.bit_idx = 31,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "rtc_xtal_clkin",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.hw = &cts_osc_src.hw,
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static const struct meson_clk_dualdiv_param rtc_32k_div_table[] = {
> +	{ 733, 732, 8, 11, 1 },
> +	{ /* sentinel */ }
> +};
> +
> +static struct clk_regmap rtc_32k_div = {
> +	.data = &(struct meson_clk_dualdiv_data) {
> +		.n1 = {
> +			.reg_off = RTC_BY_OSCIN_CTRL0,
> +			.shift   = 0,
> +			.width   = 12,
> +		},
> +		.n2 = {
> +			.reg_off = RTC_BY_OSCIN_CTRL0,
> +			.shift   = 12,
> +			.width   = 12,
> +		},
> +		.m1 = {
> +			.reg_off = RTC_BY_OSCIN_CTRL1,
> +			.shift   = 0,
> +			.width   = 12,
> +		},
> +		.m2 = {
> +			.reg_off = RTC_BY_OSCIN_CTRL1,
> +			.shift   = 12,
> +			.width   = 12,
> +		},
> +		.dual = {
> +			.reg_off = RTC_BY_OSCIN_CTRL0,
> +			.shift   = 28,
> +			.width   = 1,
> +		},
> +		.table = rtc_32k_div_table,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "rtc_32k_div",
> +		.ops = &meson_clk_dualdiv_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&rtc_xtal_clkin.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static const struct clk_parent_data rtc_32k_mux_parent_data[] = {
> +	{ .hw = &rtc_32k_div.hw },
> +	{ .hw = &rtc_xtal_clkin.hw }
> +};
> +
> +static struct clk_regmap rtc_32k_mux = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = RTC_BY_OSCIN_CTRL1,
> +		.mask = 0x1,
> +		.shift = 24,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "rtc_32k_mux",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = rtc_32k_mux_parent_data,
> +		.num_parents = ARRAY_SIZE(rtc_32k_mux_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap rtc_32k = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = RTC_BY_OSCIN_CTRL0,
> +		.bit_idx = 30,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "rtc_32k",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&rtc_32k_mux.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +/*
> + * Index 2 clock is pad input clock, here we had not used.

Isn't this "fw_name" "pad" ?

Not using it (in your case) is not a good reason.
If you have another to skip this clock, please update your comment
Otherwise, please add it.

> + * Index 3 is grounded.
> + */
> +static const struct clk_parent_data rtc_clk_mux_parent_data[] = {
> +	{ .hw = &cts_osc_src.hw },
> +	{ .hw = &rtc_32k.hw }
> +};
> +
> +static struct clk_regmap rtc_clk = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = RTC_CTRL,
> +		.mask = 0x3,
> +		.shift = 0,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "rtc_clk",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = rtc_clk_mux_parent_data,
> +		.num_parents = ARRAY_SIZE(rtc_clk_mux_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +/*
> + * Channel 5(axi_clk_frcpu) is an external axi_cpu clock that is not handled
> + * right now. The corresponding registers are not placed in PLL or peripherals
> + * and are not readable or writable by the kernel, only accessed through
> + * SMC to SCP.
> + * Channel 6 is not connected.
> + */
> +static u32 sys_axi_parent_table[] = { 0, 1, 2, 3, 4, 7 };
> +
> +static const struct clk_parent_data sys_axi_parent_data[] = {
> +	{ .hw = &cts_osc_src.hw },
> +	{ .fw_name = "gp1" },
> +	{ .fw_name = "fdiv3" },
> +	{ .fw_name = "fdiv4" },
> +	{ .fw_name = "fdiv5" },
> +	{ .hw = &rtc_clk.hw }
> +};
> +
> +/*
> + * These clocks are initialized by ROM code.

ROMcode or bl2 ? ... now that I have asked for the fixed PLL, I wonder about
the rest.

> + * The chip was changed SYS_CLK for security reason. SYS_CLK registers are
> + * not writable in the kernel phase. Writing of SYS related register will cause
> + * the system to crash. Meanwhile, these clocks won't be changed at runtime.
> + * For the above reasons, we can only use ro_ops for SYS related clocks.
> + */
> +static struct clk_regmap sys_a_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = SYS_CLK_CTRL0,
> +		.mask = 0x7,
> +		.shift = 10,
> +		.table = sys_axi_parent_table,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sys_a_sel",
> +		.ops = &clk_regmap_mux_ro_ops,
> +		.parent_data = sys_axi_parent_data,
> +		.num_parents = ARRAY_SIZE(sys_axi_parent_data),
> +		.flags = CLK_GET_RATE_NOCACHE,
> +	},
> +};
> +
> +static struct clk_regmap sys_a_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = SYS_CLK_CTRL0,
> +		.shift = 0,
> +		.width = 10,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sys_a_div",
> +		.ops = &clk_regmap_divider_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&sys_a_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_GET_RATE_NOCACHE,
> +	},
> +};
> +
> +static struct clk_regmap sys_a = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = SYS_CLK_CTRL0,
> +		.bit_idx = 13,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sys_a",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&sys_a_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_GET_RATE_NOCACHE,
> +	},
> +};
> +
> +static struct clk_regmap sys_b_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = SYS_CLK_CTRL0,
> +		.mask = 0x7,
> +		.shift = 26,
> +		.table = sys_axi_parent_table,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sys_b_sel",
> +		.ops = &clk_regmap_mux_ro_ops,
> +		.parent_data = sys_axi_parent_data,
> +		.num_parents = ARRAY_SIZE(sys_axi_parent_data),
> +		.flags = CLK_GET_RATE_NOCACHE,
> +	},
> +};
> +
> +static struct clk_regmap sys_b_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = SYS_CLK_CTRL0,
> +		.shift = 16,
> +		.width = 10,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sys_b_div",
> +		.ops = &clk_regmap_divider_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&sys_b_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_GET_RATE_NOCACHE,
> +	},
> +};
> +
> +static struct clk_regmap sys_b = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = SYS_CLK_CTRL0,
> +		.bit_idx = 29,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sys_b",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&sys_b_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_GET_RATE_NOCACHE,
> +	},
> +};
> +
> +static const struct clk_parent_data sys_clk_parent_data[] = {
> +	{ .hw = &sys_a.hw },
> +	{ .hw = &sys_b.hw }
> +};
> +
> +static struct clk_regmap sys_clk = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = SYS_CLK_CTRL0,
> +		.mask = 0x1,
> +		.shift = 15,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sys_clk",
> +		.ops = &clk_regmap_mux_ro_ops,
> +		.parent_data = sys_clk_parent_data,
> +		.num_parents = ARRAY_SIZE(sys_clk_parent_data),
> +		.flags = CLK_GET_RATE_NOCACHE,
> +	},
> +};
> +
> +/*
> + * In the system, high-speed modules such as DDR, SRAM, ROM, CAPU and
> + * other key modules communicate through AXI_BUS and the clock is
> + * provided by the axi_clk. While the axi_clock is source of several
> + * peripheral gates, and that all should in theory be described and
> + * properly handled, it is not the case at the moment.
> + * The system will crash if the axi_clock is turned off, so the
> + * clock is critical, at least for now.
> + */

This comment feels a bit weird here.
It's better to place it just before the clock that is critical.

> +static struct clk_regmap axi_a_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = AXI_CLK_CTRL0,
> +		.mask = 0x7,
> +		.shift = 10,
> +		.table = sys_axi_parent_table,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "axi_a_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = sys_axi_parent_data,
> +		.num_parents = ARRAY_SIZE(sys_axi_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap axi_a_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = AXI_CLK_CTRL0,
> +		.shift = 0,
> +		.width = 10,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "axi_a_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&axi_a_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap axi_a = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = AXI_CLK_CTRL0,
> +		.bit_idx = 13,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "axi_a",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&axi_a_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap axi_b_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = AXI_CLK_CTRL0,
> +		.mask = 0x7,
> +		.shift = 26,
> +		.table = sys_axi_parent_table,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "axi_b_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = sys_axi_parent_data,
> +		.num_parents = ARRAY_SIZE(sys_axi_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap axi_b_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = AXI_CLK_CTRL0,
> +		.shift = 16,
> +		.width = 10,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "axi_b_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&axi_b_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap axi_b = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = AXI_CLK_CTRL0,
> +		.bit_idx = 29,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "axi_b",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&axi_b_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};


... here 

> +
> +static const struct clk_parent_data axi_clk_parent_data[] = {
> +	{ .hw = &axi_a.hw },
> +	{ .hw = &axi_b.hw }
> +};
> +
> +static struct clk_regmap axi_clk = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = AXI_CLK_CTRL0,
> +		.mask = 0x1,
> +		.shift = 15,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "axi_clk",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = axi_clk_parent_data,
> +		.num_parents = ARRAY_SIZE(axi_clk_parent_data),
> +		.flags = CLK_IS_CRITICAL,
> +	},
> +};
> +
> +#define AML_CLK_GATE_SYS_CLK(_name, _reg, _bit)\
> +	MESON_PCLK(_name, _reg, _bit, &sys_clk.hw)
> +#define AML_CLK_GATE_AXI_CLK(_name, _reg, _bit)\
> +	MESON_PCLK(_name, _reg, _bit, &axi_clk.hw)
> +
> +static AML_CLK_GATE_SYS_CLK(sys_reset_ctrl,	SYS_CLK_EN0_REG0,	1);
> +static AML_CLK_GATE_SYS_CLK(sys_pwr_ctrl,	SYS_CLK_EN0_REG0,	3);
> +static AML_CLK_GATE_SYS_CLK(sys_pad_ctrl,	SYS_CLK_EN0_REG0,	4);
> +static AML_CLK_GATE_SYS_CLK(sys_ctrl,		SYS_CLK_EN0_REG0,	5);
> +static AML_CLK_GATE_SYS_CLK(sys_ts_pll,		SYS_CLK_EN0_REG0,	6);
> +static AML_CLK_GATE_SYS_CLK(sys_dev_arb,	SYS_CLK_EN0_REG0,	7);
> +static AML_CLK_GATE_SYS_CLK(sys_mmc_pclk,	SYS_CLK_EN0_REG0,	8);
> +static AML_CLK_GATE_SYS_CLK(sys_capu,		SYS_CLK_EN0_REG0,	9);
> +static AML_CLK_GATE_SYS_CLK(sys_cpu_ctrl,	SYS_CLK_EN0_REG0,	11);
> +static AML_CLK_GATE_SYS_CLK(sys_jtag_ctrl,	SYS_CLK_EN0_REG0,	12);
> +static AML_CLK_GATE_SYS_CLK(sys_ir_ctrl,	SYS_CLK_EN0_REG0,	13);
> +static AML_CLK_GATE_SYS_CLK(sys_irq_ctrl,	SYS_CLK_EN0_REG0,	14);
> +static AML_CLK_GATE_SYS_CLK(sys_msr_clk,	SYS_CLK_EN0_REG0,	15);
> +static AML_CLK_GATE_SYS_CLK(sys_rom,		SYS_CLK_EN0_REG0,	16);
> +static AML_CLK_GATE_SYS_CLK(sys_uart_f,		SYS_CLK_EN0_REG0,	17);
> +static AML_CLK_GATE_SYS_CLK(sys_cpu_apb,	SYS_CLK_EN0_REG0,	18);
> +static AML_CLK_GATE_SYS_CLK(sys_rsa,		SYS_CLK_EN0_REG0,	19);
> +static AML_CLK_GATE_SYS_CLK(sys_sar_adc,	SYS_CLK_EN0_REG0,	20);
> +static AML_CLK_GATE_SYS_CLK(sys_startup,	SYS_CLK_EN0_REG0,	21);
> +static AML_CLK_GATE_SYS_CLK(sys_secure,		SYS_CLK_EN0_REG0,	22);
> +static AML_CLK_GATE_SYS_CLK(sys_spifc,		SYS_CLK_EN0_REG0,	23);
> +static AML_CLK_GATE_SYS_CLK(sys_nna,		SYS_CLK_EN0_REG0,	25);
> +static AML_CLK_GATE_SYS_CLK(sys_eth_mac,	SYS_CLK_EN0_REG0,	26);
> +static AML_CLK_GATE_SYS_CLK(sys_gic,		SYS_CLK_EN0_REG0,	27);
> +static AML_CLK_GATE_SYS_CLK(sys_rama,		SYS_CLK_EN0_REG0,	28);
> +static AML_CLK_GATE_SYS_CLK(sys_big_nic,	SYS_CLK_EN0_REG0,	29);
> +static AML_CLK_GATE_SYS_CLK(sys_ramb,		SYS_CLK_EN0_REG0,	30);
> +static AML_CLK_GATE_SYS_CLK(sys_audio_pclk,	SYS_CLK_EN0_REG0,	31);
> +static AML_CLK_GATE_SYS_CLK(sys_pwm_kl,		SYS_CLK_EN0_REG1,	0);
> +static AML_CLK_GATE_SYS_CLK(sys_pwm_ij,		SYS_CLK_EN0_REG1,	1);
> +static AML_CLK_GATE_SYS_CLK(sys_usb,		SYS_CLK_EN0_REG1,	2);
> +static AML_CLK_GATE_SYS_CLK(sys_sd_emmc_a,	SYS_CLK_EN0_REG1,	3);
> +static AML_CLK_GATE_SYS_CLK(sys_sd_emmc_c,	SYS_CLK_EN0_REG1,	4);
> +static AML_CLK_GATE_SYS_CLK(sys_pwm_ab,		SYS_CLK_EN0_REG1,	5);
> +static AML_CLK_GATE_SYS_CLK(sys_pwm_cd,		SYS_CLK_EN0_REG1,	6);
> +static AML_CLK_GATE_SYS_CLK(sys_pwm_ef,		SYS_CLK_EN0_REG1,	7);
> +static AML_CLK_GATE_SYS_CLK(sys_pwm_gh,		SYS_CLK_EN0_REG1,	8);
> +static AML_CLK_GATE_SYS_CLK(sys_spicc_1,	SYS_CLK_EN0_REG1,	9);
> +static AML_CLK_GATE_SYS_CLK(sys_spicc_0,	SYS_CLK_EN0_REG1,	10);
> +static AML_CLK_GATE_SYS_CLK(sys_uart_a,		SYS_CLK_EN0_REG1,	11);
> +static AML_CLK_GATE_SYS_CLK(sys_uart_b,		SYS_CLK_EN0_REG1,	12);
> +static AML_CLK_GATE_SYS_CLK(sys_uart_c,		SYS_CLK_EN0_REG1,	13);
> +static AML_CLK_GATE_SYS_CLK(sys_uart_d,		SYS_CLK_EN0_REG1,	14);
> +static AML_CLK_GATE_SYS_CLK(sys_uart_e,		SYS_CLK_EN0_REG1,	15);
> +static AML_CLK_GATE_SYS_CLK(sys_i2c_m_a,	SYS_CLK_EN0_REG1,	16);
> +static AML_CLK_GATE_SYS_CLK(sys_i2c_m_b,	SYS_CLK_EN0_REG1,	17);
> +static AML_CLK_GATE_SYS_CLK(sys_i2c_m_c,	SYS_CLK_EN0_REG1,	18);
> +static AML_CLK_GATE_SYS_CLK(sys_i2c_m_d,	SYS_CLK_EN0_REG1,	19);
> +static AML_CLK_GATE_SYS_CLK(sys_i2c_s_a,	SYS_CLK_EN0_REG1,	20);
> +static AML_CLK_GATE_SYS_CLK(sys_rtc,		SYS_CLK_EN0_REG1,	21);
> +static AML_CLK_GATE_SYS_CLK(sys_ge2d,		SYS_CLK_EN0_REG1,	22);
> +static AML_CLK_GATE_SYS_CLK(sys_isp,		SYS_CLK_EN0_REG1,	23);
> +static AML_CLK_GATE_SYS_CLK(sys_gpv_isp_nic,	SYS_CLK_EN0_REG1,	24);
> +static AML_CLK_GATE_SYS_CLK(sys_gpv_cve_nic,	SYS_CLK_EN0_REG1,	25);
> +static AML_CLK_GATE_SYS_CLK(sys_mipi_dsi_host,	SYS_CLK_EN0_REG1,	26);
> +static AML_CLK_GATE_SYS_CLK(sys_mipi_dsi_phy,	SYS_CLK_EN0_REG1,	27);
> +static AML_CLK_GATE_SYS_CLK(sys_eth_phy,	SYS_CLK_EN0_REG1,	28);
> +static AML_CLK_GATE_SYS_CLK(sys_acodec,		SYS_CLK_EN0_REG1,	29);
> +static AML_CLK_GATE_SYS_CLK(sys_dwap,		SYS_CLK_EN0_REG1,	30);
> +static AML_CLK_GATE_SYS_CLK(sys_dos,		SYS_CLK_EN0_REG1,	31);
> +static AML_CLK_GATE_SYS_CLK(sys_cve,		SYS_CLK_EN0_REG2,	0);
> +static AML_CLK_GATE_SYS_CLK(sys_vout,		SYS_CLK_EN0_REG2,	1);
> +static AML_CLK_GATE_SYS_CLK(sys_vc9000e,	SYS_CLK_EN0_REG2,	2);
> +static AML_CLK_GATE_SYS_CLK(sys_pwm_mn,		SYS_CLK_EN0_REG2,	3);
> +static AML_CLK_GATE_SYS_CLK(sys_sd_emmc_b,	SYS_CLK_EN0_REG2,	4);
> +
> +static AML_CLK_GATE_AXI_CLK(axi_sys_nic,	AXI_CLK_EN0,	2);
> +static AML_CLK_GATE_AXI_CLK(axi_isp_nic,	AXI_CLK_EN0,	3);
> +static AML_CLK_GATE_AXI_CLK(axi_cve_nic,	AXI_CLK_EN0,	4);
> +static AML_CLK_GATE_AXI_CLK(axi_ramb,		AXI_CLK_EN0,	5);
> +static AML_CLK_GATE_AXI_CLK(axi_rama,		AXI_CLK_EN0,	6);
> +static AML_CLK_GATE_AXI_CLK(axi_cpu_dmc,	AXI_CLK_EN0,	7);
> +static AML_CLK_GATE_AXI_CLK(axi_nic,		AXI_CLK_EN0,	8);
> +static AML_CLK_GATE_AXI_CLK(axi_dma,		AXI_CLK_EN0,	9);
> +static AML_CLK_GATE_AXI_CLK(axi_mux_nic,	AXI_CLK_EN0,	10);
> +static AML_CLK_GATE_AXI_CLK(axi_capu,		AXI_CLK_EN0,	11);
> +static AML_CLK_GATE_AXI_CLK(axi_cve,		AXI_CLK_EN0,	12);
> +static AML_CLK_GATE_AXI_CLK(axi_dev1_dmc,	AXI_CLK_EN0,	13);
> +static AML_CLK_GATE_AXI_CLK(axi_dev0_dmc,	AXI_CLK_EN0,	14);
> +static AML_CLK_GATE_AXI_CLK(axi_dsp_dmc,	AXI_CLK_EN0,	15);
> +
> +/*
> + * clk_12_24m model
> + *
> + *          |------|     |-----| clk_12m_24m |-----|
> + * xtal---->| gate |---->| div |------------>| pad |
> + *          |------|     |-----|             |-----|
> + */
> +static struct clk_regmap clk_12_24m_in = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLK12_24_CTRL,
> +		.bit_idx = 11,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "clk_12_24m_in",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "xtal_24m",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap clk_12_24m = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLK12_24_CTRL,
> +		.shift = 10,
> +		.width = 1,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "clk_12_24m",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&clk_12_24m_in.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +/* Fix me: set value 0 will div by 2 like value 1 */
> +static struct clk_regmap fclk_25m_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = CLK12_24_CTRL,
> +		.shift = 0,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_25m_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "fix",
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap fclk_25m = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = CLK12_24_CTRL,
> +		.bit_idx = 12,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_25m",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&fclk_25m_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +/*
> + * Channel 2(sys_pll_div16), 17(sys_cpu_clk_div16) registers have
> + * permission restrictions. These registers are not readable or writable
> + * by the kernel, only accessed through SMC to SCP. This is not
> + * available at the moment.
> + * Channel 3(ddr_dpll_pt_clk) is manged by the DDR module; channel 12(cts_msr_clk)
                                      ^ managed ?

> + * is manged by clock measures module. Their hardware are out of clock tree.
> + * Channel 4 8 9 10 11 13 14 15 16 18 are not connected.
> + */
> +static u32 gen_parent_table[] = { 0, 1, 5, 6, 7, 19, 20, 21, 22, 23, 24};
> +
> +static const struct clk_parent_data gen_parent_data[] = {
> +	{ .hw = &cts_osc_src.hw },
> +	{ .hw = &rtc_clk.hw },
> +	{ .fw_name = "gp0" },
> +	{ .fw_name = "gp1" },
> +	{ .fw_name = "hifi" },
> +	{ .fw_name = "fdiv2" },
> +	{ .fw_name = "fdiv2p5" },
> +	{ .fw_name = "fdiv3" },
> +	{ .fw_name = "fdiv4" },
> +	{ .fw_name = "fdiv5" },
> +	{ .fw_name = "fdiv7" }
> +};
> +
> +static struct clk_regmap gen_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = GEN_CLK_CTRL,
> +		.mask = 0x1f,
> +		.shift = 12,
> +		.table = gen_parent_table,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "gen_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = gen_parent_data,
> +		.num_parents = ARRAY_SIZE(gen_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap gen_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = GEN_CLK_CTRL,
> +		.shift = 0,
> +		.width = 11,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "gen_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&gen_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap gen = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = GEN_CLK_CTRL,
> +		.bit_idx = 11,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "gen",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&gen_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data saradc_parent_data[] = {
> +	{ .hw = &cts_osc_src.hw },
> +	{ .hw = &sys_clk.hw }
> +};
> +
> +static struct clk_regmap saradc_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = SAR_CLK_CTRL0,
> +		.mask = 0x1,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "saradc_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = saradc_parent_data,
> +		.num_parents = ARRAY_SIZE(saradc_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap saradc_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = SAR_CLK_CTRL0,
> +		.shift = 0,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "saradc_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&saradc_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap saradc = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = SAR_CLK_CTRL0,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "saradc",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&saradc_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data pwm_parent_data[] = {
> +	{ .hw = &cts_osc_src.hw },
> +	{ .fw_name = "gp1" },
> +	{ .fw_name = "fdiv4" },
> +	{ .fw_name = "fdiv3" }
> +};
> +
> +#define AML_PWM_CLK_MUX(_name, _reg, _shift) {			\
> +	.data = &(struct clk_regmap_mux_data) {			\
> +		.offset = _reg,					\
> +		.mask = 0x3,					\
> +		.shift = _shift,				\
> +	},							\
> +	.hw.init = &(struct clk_init_data) {			\
> +		.name = #_name "_sel",				\
> +		.ops = &clk_regmap_mux_ops,			\
> +		.parent_data = pwm_parent_data,			\
> +		.num_parents = ARRAY_SIZE(pwm_parent_data),	\
> +	},							\
> +}
> +
> +#define AML_PWM_CLK_DIV(_name, _reg, _shift) {			\
> +	.data = &(struct clk_regmap_div_data) {			\
> +		.offset = _reg,					\
> +		.shift = _shift,				\
> +		.width = 8,					\
> +	},							\
> +	.hw.init = &(struct clk_init_data) {			\
> +		.name = #_name "_div",				\
> +		.ops = &clk_regmap_divider_ops,			\
> +		.parent_names = (const char *[]) { #_name "_sel" },\
> +		.num_parents = 1,				\
> +		.flags = CLK_SET_RATE_PARENT,			\
> +	},							\
> +}
> +
> +#define AML_PWM_CLK_GATE(_name, _reg, _bit) {			\
> +	.data = &(struct clk_regmap_gate_data) {		\
> +		.offset = _reg,					\
> +		.bit_idx = _bit,				\
> +	},							\
> +	.hw.init = &(struct clk_init_data) {			\
> +		.name = #_name,					\
> +		.ops = &clk_regmap_gate_ops,			\
> +		.parent_names = (const char *[]) { #_name "_div" },\
> +		.num_parents = 1,				\
> +		.flags = CLK_SET_RATE_PARENT,			\
> +	},							\
> +}
> +
> +static struct clk_regmap pwm_a_sel =
> +	AML_PWM_CLK_MUX(pwm_a, PWM_CLK_AB_CTRL, 9);
> +static struct clk_regmap pwm_a_div =
> +	AML_PWM_CLK_DIV(pwm_a, PWM_CLK_AB_CTRL, 0);
> +static struct clk_regmap pwm_a =
> +	AML_PWM_CLK_GATE(pwm_a, PWM_CLK_AB_CTRL, 8);
> +
> +static struct clk_regmap pwm_b_sel =
> +	AML_PWM_CLK_MUX(pwm_b, PWM_CLK_AB_CTRL, 25);
> +static struct clk_regmap pwm_b_div =
> +	AML_PWM_CLK_DIV(pwm_b, PWM_CLK_AB_CTRL, 16);
> +static struct clk_regmap pwm_b =
> +	AML_PWM_CLK_GATE(pwm_b, PWM_CLK_AB_CTRL, 24);
> +
> +static struct clk_regmap pwm_c_sel =
> +	AML_PWM_CLK_MUX(pwm_c, PWM_CLK_CD_CTRL, 9);
> +static struct clk_regmap pwm_c_div =
> +	AML_PWM_CLK_DIV(pwm_c, PWM_CLK_CD_CTRL, 0);
> +static struct clk_regmap pwm_c =
> +	AML_PWM_CLK_GATE(pwm_c, PWM_CLK_CD_CTRL, 8);
> +
> +static struct clk_regmap pwm_d_sel =
> +	AML_PWM_CLK_MUX(pwm_d, PWM_CLK_CD_CTRL, 25);
> +static struct clk_regmap pwm_d_div =
> +	AML_PWM_CLK_DIV(pwm_d, PWM_CLK_CD_CTRL, 16);
> +static struct clk_regmap pwm_d =
> +	AML_PWM_CLK_GATE(pwm_d, PWM_CLK_CD_CTRL, 24);
> +
> +static struct clk_regmap pwm_e_sel =
> +	AML_PWM_CLK_MUX(pwm_e, PWM_CLK_EF_CTRL, 9);
> +static struct clk_regmap pwm_e_div =
> +	AML_PWM_CLK_DIV(pwm_e, PWM_CLK_EF_CTRL, 0);
> +static struct clk_regmap pwm_e =
> +	AML_PWM_CLK_GATE(pwm_e, PWM_CLK_EF_CTRL, 8);
> +
> +static struct clk_regmap pwm_f_sel =
> +	AML_PWM_CLK_MUX(pwm_f, PWM_CLK_EF_CTRL, 25);
> +static struct clk_regmap pwm_f_div =
> +	AML_PWM_CLK_DIV(pwm_f, PWM_CLK_EF_CTRL, 16);
> +static struct clk_regmap pwm_f =
> +	AML_PWM_CLK_GATE(pwm_f, PWM_CLK_EF_CTRL, 24);
> +
> +static struct clk_regmap pwm_g_sel =
> +	AML_PWM_CLK_MUX(pwm_g, PWM_CLK_GH_CTRL, 9);
> +static struct clk_regmap pwm_g_div =
> +	AML_PWM_CLK_DIV(pwm_g, PWM_CLK_GH_CTRL, 0);
> +static struct clk_regmap pwm_g =
> +	AML_PWM_CLK_GATE(pwm_g, PWM_CLK_GH_CTRL, 8);
> +
> +static struct clk_regmap pwm_h_sel =
> +	AML_PWM_CLK_MUX(pwm_h, PWM_CLK_GH_CTRL, 25);
> +static struct clk_regmap pwm_h_div =
> +	AML_PWM_CLK_DIV(pwm_h, PWM_CLK_GH_CTRL, 16);
> +static struct clk_regmap pwm_h =
> +	AML_PWM_CLK_GATE(pwm_h, PWM_CLK_GH_CTRL, 24);
> +
> +static struct clk_regmap pwm_i_sel =
> +	AML_PWM_CLK_MUX(pwm_i, PWM_CLK_IJ_CTRL, 9);
> +static struct clk_regmap pwm_i_div =
> +	AML_PWM_CLK_DIV(pwm_i, PWM_CLK_IJ_CTRL, 0);
> +static struct clk_regmap pwm_i =
> +	AML_PWM_CLK_GATE(pwm_i, PWM_CLK_IJ_CTRL, 8);
> +
> +static struct clk_regmap pwm_j_sel =
> +	AML_PWM_CLK_MUX(pwm_j, PWM_CLK_IJ_CTRL, 25);
> +static struct clk_regmap pwm_j_div =
> +	AML_PWM_CLK_DIV(pwm_j, PWM_CLK_IJ_CTRL, 16);
> +static struct clk_regmap pwm_j =
> +	AML_PWM_CLK_GATE(pwm_j, PWM_CLK_IJ_CTRL, 24);
> +
> +static struct clk_regmap pwm_k_sel =
> +	AML_PWM_CLK_MUX(pwm_k, PWM_CLK_KL_CTRL, 9);
> +static struct clk_regmap pwm_k_div =
> +	AML_PWM_CLK_DIV(pwm_k, PWM_CLK_KL_CTRL, 0);
> +static struct clk_regmap pwm_k =
> +	AML_PWM_CLK_GATE(pwm_k, PWM_CLK_KL_CTRL, 8);
> +
> +static struct clk_regmap pwm_l_sel =
> +	AML_PWM_CLK_MUX(pwm_l, PWM_CLK_KL_CTRL, 25);
> +static struct clk_regmap pwm_l_div =
> +	AML_PWM_CLK_DIV(pwm_l, PWM_CLK_KL_CTRL, 16);
> +static struct clk_regmap pwm_l =
> +	AML_PWM_CLK_GATE(pwm_l, PWM_CLK_KL_CTRL, 24);
> +
> +static struct clk_regmap pwm_m_sel =
> +	AML_PWM_CLK_MUX(pwm_m, PWM_CLK_MN_CTRL, 9);
> +static struct clk_regmap pwm_m_div =
> +	AML_PWM_CLK_DIV(pwm_m, PWM_CLK_MN_CTRL, 0);
> +static struct clk_regmap pwm_m =
> +	AML_PWM_CLK_GATE(pwm_m, PWM_CLK_MN_CTRL, 8);
> +
> +static struct clk_regmap pwm_n_sel =
> +	AML_PWM_CLK_MUX(pwm_n, PWM_CLK_MN_CTRL, 25);
> +static struct clk_regmap pwm_n_div =
> +	AML_PWM_CLK_DIV(pwm_n, PWM_CLK_MN_CTRL, 16);
> +static struct clk_regmap pwm_n =
> +	AML_PWM_CLK_GATE(pwm_n, PWM_CLK_MN_CTRL, 24);
> +
> +static const struct clk_parent_data spicc_parent_data[] = {
> +	{ .hw = &cts_osc_src.hw },
> +	{ .hw = &sys_clk.hw },
> +	{ .fw_name = "fdiv4" },
> +	{ .fw_name = "fdiv3" },
> +	{ .fw_name = "fdiv2" },
> +	{ .fw_name = "fdiv5" },
> +	{ .fw_name = "fdiv7" }
> +};
> +
> +static struct clk_regmap spicc_a_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = SPICC_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "spicc_a_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = spicc_parent_data,
> +		.num_parents = ARRAY_SIZE(spicc_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap spicc_a_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = SPICC_CLK_CTRL,
> +		.shift = 0,
> +		.width = 6,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "spicc_a_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&spicc_a_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap spicc_a = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = SPICC_CLK_CTRL,
> +		.bit_idx = 6,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "spicc_a",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&spicc_a_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap spicc_b_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = SPICC_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 23,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "spicc_b_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = spicc_parent_data,
> +		.num_parents = ARRAY_SIZE(spicc_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap spicc_b_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = SPICC_CLK_CTRL,
> +		.shift = 16,
> +		.width = 6,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "spicc_b_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&spicc_b_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap spicc_b = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = SPICC_CLK_CTRL,
> +		.bit_idx = 22,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "spicc_b",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&spicc_b_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data spifc_parent_data[] = {
> +	{ .fw_name = "gp0" },
> +	{ .fw_name = "fdiv2" },
> +	{ .fw_name = "fdiv3" },
> +	{ .fw_name = "fdiv2p5" },
> +	{ .fw_name = "hifi" },
> +	{ .fw_name = "fdiv4" },
> +	{ .fw_name = "fdiv5" },
> +	{ .fw_name = "fdiv7" }
> +};
> +
> +static struct clk_regmap spifc_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = SPIFC_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "spifc_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = spifc_parent_data,
> +		.num_parents = ARRAY_SIZE(spifc_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap spifc_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = SPIFC_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "spifc_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&spifc_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap spifc = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = SPIFC_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "spifc",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&spifc_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data emmc_parent_data[] = {
> +	{ .hw = &cts_osc_src.hw },
> +	{ .fw_name = "fdiv2" },
> +	{ .fw_name = "fdiv3" },
> +	{ .fw_name = "hifi" },
> +	{ .fw_name = "fdiv2p5" },
> +	{ .fw_name = "fdiv4" },
> +	{ .fw_name = "gp1" },
> +	{ .fw_name = "gp0" }
> +};
> +
> +static struct clk_regmap sd_emmc_a_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = SD_EMMC_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_a_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = emmc_parent_data,
> +		.num_parents = ARRAY_SIZE(emmc_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap sd_emmc_a_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = SD_EMMC_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_a_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&sd_emmc_a_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap sd_emmc_a = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = SD_EMMC_CLK_CTRL,
> +		.bit_idx = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_a",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&sd_emmc_a_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap sd_emmc_b_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = SD_EMMC_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 25,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_b_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = emmc_parent_data,
> +		.num_parents = ARRAY_SIZE(emmc_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap sd_emmc_b_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = SD_EMMC_CLK_CTRL,
> +		.shift = 16,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_b_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&sd_emmc_b_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap sd_emmc_b = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = SD_EMMC_CLK_CTRL,
> +		.bit_idx = 23,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_b",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&sd_emmc_b_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap sd_emmc_c_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = NAND_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_c_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = emmc_parent_data,
> +		.num_parents = ARRAY_SIZE(emmc_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap sd_emmc_c_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = NAND_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_c_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&sd_emmc_c_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap sd_emmc_c = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = NAND_CLK_CTRL,
> +		.bit_idx = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "sd_emmc_c",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&sd_emmc_c_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap ts_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = TS_CLK_CTRL,
> +		.shift = 0,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "ts_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.hw = &cts_osc_src.hw,
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap ts = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = TS_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "ts",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&ts_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data eth_parent = {
> +	.fw_name = "fdiv2",
> +};
> +
> +static struct clk_fixed_factor eth_125m_div = {
> +	.mult = 1,
> +	.div = 8,
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "eth_125m_div",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_data = &eth_parent,
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap eth_125m = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ETH_CLK_CTRL,
> +		.bit_idx = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "eth_125m",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&eth_125m_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap eth_rmii_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = ETH_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "eth_rmii_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_data = &eth_parent,
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_regmap eth_rmii = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ETH_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "eth_rmii",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&eth_rmii_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data mipi_dsi_meas_parent_data[] = {
> +	{ .hw = &cts_osc_src.hw },
> +	{ .fw_name = "fdiv4" },
> +	{ .fw_name = "fdiv3" },
> +	{ .fw_name = "fdiv5" },
> +	{ .fw_name = "gp1" },
> +	{ .fw_name = "gp0" },
> +	{ .fw_name = "fdiv2" },
> +	{ .fw_name = "fdiv7" }
> +};
> +
> +static struct clk_regmap mipi_dsi_meas_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = VDIN_MEAS_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 21,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mipi_dsi_meas_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = mipi_dsi_meas_parent_data,
> +		.num_parents = ARRAY_SIZE(mipi_dsi_meas_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap mipi_dsi_meas_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = VDIN_MEAS_CLK_CTRL,
> +		.shift = 12,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mipi_dsi_meas_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&mipi_dsi_meas_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap mipi_dsi_meas = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = VDIN_MEAS_CLK_CTRL,
> +		.bit_idx = 20,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "mipi_dsi_meas",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&mipi_dsi_meas_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data dsi_phy_parent_data[] = {
> +	{ .fw_name = "gp1" },
> +	{ .fw_name = "gp0" },
> +	{ .fw_name = "hifi" },
> +	{ .fw_name = "fdiv3" },
> +	{ .fw_name = "fdiv2" },
> +	{ .fw_name = "fdiv2p5" },
> +	{ .fw_name = "fdiv4" },
> +	{ .fw_name = "fdiv7" }
> +};
> +
> +static struct clk_regmap dsi_phy_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = MIPIDSI_PHY_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 12,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "dsi_phy_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = dsi_phy_parent_data,
> +		.num_parents = ARRAY_SIZE(dsi_phy_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap dsi_phy_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = MIPIDSI_PHY_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "dsi_phy_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&dsi_phy_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap dsi_phy = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = MIPIDSI_PHY_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "dsi_phy",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&dsi_phy_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data vout_parent_data[] = {
> +	{ .fw_name = "gp1" },
> +	{ .fw_name = "fdiv3" },
> +	{ .fw_name = "fdiv4" },
> +	{ .fw_name = "fdiv5" },
> +	{ .fw_name = "gp0" },
> +	{ .fw_name = "hifi" },
> +	{ .fw_name = "fdiv2p5" },
> +	{ .fw_name = "fdiv7" }
> +};
> +
> +static struct clk_regmap vout_mclk_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = VOUTENC_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vout_mclk_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = vout_parent_data,
> +		.num_parents = ARRAY_SIZE(vout_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap vout_mclk_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = VOUTENC_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vout_mclk_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&vout_mclk_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap vout_mclk = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = MIPIDSI_PHY_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vout_mclk",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&vout_mclk_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap vout_enc_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = VOUTENC_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 25,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vout_enc_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = vout_parent_data,
> +		.num_parents = ARRAY_SIZE(vout_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap vout_enc_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = VOUTENC_CLK_CTRL,
> +		.shift = 16,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vout_enc_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&vout_enc_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap vout_enc = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = VOUTENC_CLK_CTRL,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vout_enc",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&vout_enc_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data hcodec_pre_parent_data[] = {
> +	{ .fw_name = "fdiv2p5" },
> +	{ .fw_name = "fdiv3" },
> +	{ .fw_name = "fdiv4" },
> +	{ .fw_name = "fdiv5" },
> +	{ .fw_name = "fdiv7" },
> +	{ .fw_name = "hifi" },
> +	{ .fw_name = "gp0" },
> +	{ .hw = &cts_osc_src.hw }
> +};
> +
> +static struct clk_regmap hcodec_0_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = VDEC_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "hcodec_0_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = hcodec_pre_parent_data,
> +		.num_parents = ARRAY_SIZE(hcodec_pre_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap hcodec_0_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = VDEC_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "hcodec_0_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&hcodec_0_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap hcodec_0 = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = VDEC_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "hcodec_0",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&hcodec_0_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap hcodec_1_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = VDEC3_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "hcodec_1_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = hcodec_pre_parent_data,
> +		.num_parents = ARRAY_SIZE(hcodec_pre_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap hcodec_1_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = VDEC3_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "hcodec_1_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&hcodec_1_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap hcodec_1 = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = VDEC3_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "hcodec_1",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&hcodec_1_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data hcodec_parent_data[] = {
> +	{ .hw = &hcodec_0.hw },
> +	{ .hw = &hcodec_1.hw }
> +};
> +
> +static struct clk_regmap hcodec = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = VDEC3_CLK_CTRL,
> +		.mask = 0x1,
> +		.shift = 15,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "hcodec",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = hcodec_parent_data,
> +		.num_parents = ARRAY_SIZE(hcodec_parent_data),
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data vc9000e_parent_data[] = {
> +	{ .hw = &cts_osc_src.hw },
> +	{ .fw_name = "fdiv4" },
> +	{ .fw_name = "fdiv3" },
> +	{ .fw_name = "fdiv5" },
> +	{ .fw_name = "fdiv7" },
> +	{ .fw_name = "fdiv2p5" },
> +	{ .fw_name = "hifi" },
> +	{ .fw_name = "gp0" }
> +};
> +
> +static struct clk_regmap vc9000e_aclk_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = VC9000E_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vc9000e_aclk_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = vc9000e_parent_data,
> +		.num_parents = ARRAY_SIZE(vc9000e_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap vc9000e_aclk_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = VC9000E_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vc9000e_aclk_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&vc9000e_aclk_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap vc9000e_aclk = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = VC9000E_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vc9000e_aclk",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&vc9000e_aclk_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap vc9000e_core_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = VC9000E_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 25,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vc9000e_core_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = vc9000e_parent_data,
> +		.num_parents = ARRAY_SIZE(vc9000e_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap vc9000e_core_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = VC9000E_CLK_CTRL,
> +		.shift = 16,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vc9000e_core_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&vc9000e_core_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap vc9000e_core = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = VC9000E_CLK_CTRL,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vc9000e_core",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&vc9000e_core_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data csi_phy_parent_data[] = {
> +	{ .fw_name = "fdiv2p5" },
> +	{ .fw_name = "fdiv3" },
> +	{ .fw_name = "fdiv4" },
> +	{ .fw_name = "fdiv5" },
> +	{ .fw_name = "gp0" },
> +	{ .fw_name = "hifi" },
> +	{ .fw_name = "gp1" },
> +	{ .hw = &cts_osc_src.hw }
> +};
> +
> +static struct clk_regmap csi_phy0_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = ISP0_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 25,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "csi_phy0_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = csi_phy_parent_data,
> +		.num_parents = ARRAY_SIZE(csi_phy_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap csi_phy0_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = ISP0_CLK_CTRL,
> +		.shift = 16,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "csi_phy0_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&csi_phy0_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap csi_phy0 = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ISP0_CLK_CTRL,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "csi_phy0",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&csi_phy0_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data dewarpa_parent_data[] = {
> +	{ .fw_name = "fdiv2p5" },
> +	{ .fw_name = "fdiv3" },
> +	{ .fw_name = "fdiv4" },
> +	{ .fw_name = "fdiv5" },
> +	{ .fw_name = "gp0" },
> +	{ .fw_name = "hifi" },
> +	{ .fw_name = "gp1" },
> +	{ .fw_name = "fdiv7" }
> +};
> +
> +static struct clk_regmap dewarpa_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = DEWARPA_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "dewarpa_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = dewarpa_parent_data,
> +		.num_parents = ARRAY_SIZE(dewarpa_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap dewarpa_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = DEWARPA_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "dewarpa_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&dewarpa_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap dewarpa = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = DEWARPA_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "dewarpa",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&dewarpa_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data isp_parent_data[] = {
> +	{ .fw_name = "fdiv2p5" },
> +	{ .fw_name = "fdiv3" },
> +	{ .fw_name = "fdiv4" },
> +	{ .fw_name = "fdiv5" },
> +	{ .fw_name = "gp0" },
> +	{ .fw_name = "hifi" },
> +	{ .fw_name = "gp1" },
> +	{ .hw = &cts_osc_src.hw }
> +};
> +
> +static struct clk_regmap isp0_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = ISP0_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "isp0_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = isp_parent_data,
> +		.num_parents = ARRAY_SIZE(isp_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap isp0_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = ISP0_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "isp0_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&isp0_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap isp0 = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ISP0_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "isp0",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&isp0_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data nna_core_parent_data[] = {
> +	{ .hw = &cts_osc_src.hw },
> +	{ .fw_name = "fdiv2p5" },
> +	{ .fw_name = "fdiv4" },
> +	{ .fw_name = "fdiv3" },
> +	{ .fw_name = "fdiv5" },
> +	{ .fw_name = "fdiv2" },
> +	{ .fw_name = "gp1" },
> +	{ .fw_name = "hifi" }
> +};
> +
> +static struct clk_regmap nna_core_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = NNA_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "nna_core_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = nna_core_parent_data,
> +		.num_parents = ARRAY_SIZE(nna_core_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap nna_core_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = NNA_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "nna_core_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&nna_core_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap nna_core = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = NNA_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "nna_core",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&nna_core_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data ge2d_parent_data[] = {
> +	{ .hw = &cts_osc_src.hw },
> +	{ .fw_name = "fdiv2p5" },
> +	{ .fw_name = "fdiv3" },
> +	{ .fw_name = "fdiv4" },
> +	{ .fw_name = "hifi" },
> +	{ .fw_name = "fdiv5" },
> +	{ .fw_name = "gp0" },
> +	{ .hw = &rtc_clk.hw }
> +};
> +
> +static struct clk_regmap ge2d_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = GE2D_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "ge2d_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = ge2d_parent_data,
> +		.num_parents = ARRAY_SIZE(ge2d_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap ge2d_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = GE2D_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "ge2d_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&ge2d_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap ge2d = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = GE2D_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "ge2d",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&ge2d_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static const struct clk_parent_data vapb_parent_data[] = {
> +	{ .fw_name = "fdiv2p5" },
> +	{ .fw_name = "fdiv3" },
> +	{ .fw_name = "fdiv4" },
> +	{ .fw_name = "fdiv5" },
> +	{ .fw_name = "gp0" },
> +	{ .fw_name = "hifi" },
> +	{ .fw_name = "gp1" },
> +	{ .hw = &cts_osc_src.hw }
> +};
> +
> +static struct clk_regmap vapb_sel = {
> +	.data = &(struct clk_regmap_mux_data) {
> +		.offset = VAPB_CLK_CTRL,
> +		.mask = 0x7,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vapb_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = vapb_parent_data,
> +		.num_parents = ARRAY_SIZE(vapb_parent_data),
> +	},
> +};
> +
> +static struct clk_regmap vapb_div = {
> +	.data = &(struct clk_regmap_div_data) {
> +		.offset = VAPB_CLK_CTRL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vapb_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&vapb_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap vapb = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = VAPB_CLK_CTRL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vapb",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&vapb_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_hw *c3_periphs_hw_clks[] = {
> +	[CLKID_PLL_SRC]			= &pll_src.hw,
> +	[CLKID_MCLK_PLL_SRC]		= &mclk_pll_src.hw,
> +	[CLKID_DDR_PLL_SRC]		= &ddr_pll_src.hw,
> +	[CLKID_DDR_PHY_SRC]		= &ddr_phy_src.hw,
> +	[CLKID_USB_PLL_SRC]		= &usb_pll_src.hw,
> +	[CLKID_MIPI_ISP_VOUT_SRC]	= &mipi_isp_vout_src.hw,
> +	[CLKID_USB_CTRL_SRC]		= &usb_ctrl_src.hw,
> +	[CLKID_ETH_PLL_SRC]		= &eth_pll_src.hw,
> +	[CLKID_CTS_OSC_SRC]		= &cts_osc_src.hw,
> +	[CLKID_RTC_XTAL_CLKIN]		= &rtc_xtal_clkin.hw,
> +	[CLKID_RTC_32K_DIV]		= &rtc_32k_div.hw,
> +	[CLKID_RTC_32K_MUX]		= &rtc_32k_mux.hw,
> +	[CLKID_RTC_32K]			= &rtc_32k.hw,
> +	[CLKID_RTC_CLK]			= &rtc_clk.hw,
> +	[CLKID_SYS_A_SEL]		= &sys_a_sel.hw,
> +	[CLKID_SYS_A_DIV]		= &sys_a_div.hw,
> +	[CLKID_SYS_A]			= &sys_a.hw,
> +	[CLKID_SYS_B_SEL]		= &sys_b_sel.hw,
> +	[CLKID_SYS_B_DIV]		= &sys_b_div.hw,
> +	[CLKID_SYS_B]			= &sys_b.hw,
> +	[CLKID_SYS_CLK]			= &sys_clk.hw,
> +	[CLKID_AXI_A_SEL]		= &axi_a_sel.hw,
> +	[CLKID_AXI_A_DIV]		= &axi_a_div.hw,
> +	[CLKID_AXI_A]			= &axi_a.hw,
> +	[CLKID_AXI_B_SEL]		= &axi_b_sel.hw,
> +	[CLKID_AXI_B_DIV]		= &axi_b_div.hw,
> +	[CLKID_AXI_B]			= &axi_b.hw,
> +	[CLKID_AXI_CLK]			= &axi_clk.hw,
> +	[CLKID_SYS_RESET_CTRL]		= &sys_reset_ctrl.hw,
> +	[CLKID_SYS_PAD_CTRL]		= &sys_pwr_ctrl.hw,
> +	[CLKID_SYS_CTRL]		= &sys_ctrl.hw,
> +	[CLKID_SYS_TS_PLL]		= &sys_ts_pll.hw,
> +	[CLKID_SYS_DEV_ARB]		= &sys_dev_arb.hw,
> +	[CLKID_SYS_MMC_PCLK]		= &sys_mmc_pclk.hw,
> +	[CLKID_SYS_CAPU]		= &sys_capu.hw,
> +	[CLKID_SYS_CPU_CTRL]		= &sys_cpu_ctrl.hw,
> +	[CLKID_SYS_JTAG_CTRL]		= &sys_jtag_ctrl.hw,
> +	[CLKID_SYS_IR_CTRL]		= &sys_ir_ctrl.hw,
> +	[CLKID_SYS_IRQ_CTRL]		= &sys_irq_ctrl.hw,
> +	[CLKID_SYS_MSR_CLK]		= &sys_msr_clk.hw,
> +	[CLKID_SYS_ROM]			= &sys_rom.hw,
> +	[CLKID_SYS_UART_F]		= &sys_uart_f.hw,
> +	[CLKID_SYS_CPU_ARB]		= &sys_cpu_apb.hw,
> +	[CLKID_SYS_RSA]			= &sys_rsa.hw,
> +	[CLKID_SYS_SAR_ADC]		= &sys_sar_adc.hw,
> +	[CLKID_SYS_STARTUP]		= &sys_startup.hw,
> +	[CLKID_SYS_SECURE]		= &sys_secure.hw,
> +	[CLKID_SYS_SPIFC]		= &sys_spifc.hw,
> +	[CLKID_SYS_NNA]			= &sys_nna.hw,
> +	[CLKID_SYS_ETH_MAC]		= &sys_eth_mac.hw,
> +	[CLKID_SYS_GIC]			= &sys_gic.hw,
> +	[CLKID_SYS_RAMA]		= &sys_rama.hw,
> +	[CLKID_SYS_BIG_NIC]		= &sys_big_nic.hw,
> +	[CLKID_SYS_RAMB]		= &sys_ramb.hw,
> +	[CLKID_SYS_AUDIO_PCLK]		= &sys_audio_pclk.hw,
> +	[CLKID_SYS_PWM_KL]		= &sys_pwm_kl.hw,
> +	[CLKID_SYS_PWM_IJ]		= &sys_pwm_ij.hw,
> +	[CLKID_SYS_USB]			= &sys_usb.hw,
> +	[CLKID_SYS_SD_EMMC_A]		= &sys_sd_emmc_a.hw,
> +	[CLKID_SYS_SD_EMMC_C]		= &sys_sd_emmc_c.hw,
> +	[CLKID_SYS_PWM_AB]		= &sys_pwm_ab.hw,
> +	[CLKID_SYS_PWM_CD]		= &sys_pwm_cd.hw,
> +	[CLKID_SYS_PWM_EF]		= &sys_pwm_ef.hw,
> +	[CLKID_SYS_PWM_GH]		= &sys_pwm_gh.hw,
> +	[CLKID_SYS_SPICC_1]		= &sys_spicc_1.hw,
> +	[CLKID_SYS_SPICC_0]		= &sys_spicc_0.hw,
> +	[CLKID_SYS_UART_A]		= &sys_uart_a.hw,
> +	[CLKID_SYS_UART_B]		= &sys_uart_b.hw,
> +	[CLKID_SYS_UART_C]		= &sys_uart_c.hw,
> +	[CLKID_SYS_UART_D]		= &sys_uart_d.hw,
> +	[CLKID_SYS_UART_E]		= &sys_uart_e.hw,
> +	[CLKID_SYS_I2C_M_A]		= &sys_i2c_m_a.hw,
> +	[CLKID_SYS_I2C_M_B]		= &sys_i2c_m_b.hw,
> +	[CLKID_SYS_I2C_M_C]		= &sys_i2c_m_c.hw,
> +	[CLKID_SYS_I2C_M_D]		= &sys_i2c_m_d.hw,
> +	[CLKID_SYS_I2S_S_A]		= &sys_i2c_s_a.hw,
> +	[CLKID_SYS_RTC]			= &sys_rtc.hw,
> +	[CLKID_SYS_GE2D]		= &sys_ge2d.hw,
> +	[CLKID_SYS_ISP]			= &sys_isp.hw,
> +	[CLKID_SYS_GPV_ISP_NIC]		= &sys_gpv_isp_nic.hw,
> +	[CLKID_SYS_GPV_CVE_NIC]		= &sys_gpv_cve_nic.hw,
> +	[CLKID_SYS_MIPI_DSI_HOST]	= &sys_mipi_dsi_host.hw,
> +	[CLKID_SYS_MIPI_DSI_PHY]	= &sys_mipi_dsi_phy.hw,
> +	[CLKID_SYS_ETH_PHY]		= &sys_eth_phy.hw,
> +	[CLKID_SYS_ACODEC]		= &sys_acodec.hw,
> +	[CLKID_SYS_DWAP]		= &sys_dwap.hw,
> +	[CLKID_SYS_DOS]			= &sys_dos.hw,
> +	[CLKID_SYS_CVE]			= &sys_cve.hw,
> +	[CLKID_SYS_VOUT]		= &sys_vout.hw,
> +	[CLKID_SYS_VC9000E]		= &sys_vc9000e.hw,
> +	[CLKID_SYS_PWM_MN]		= &sys_pwm_mn.hw,
> +	[CLKID_SYS_SD_EMMC_B]		= &sys_sd_emmc_b.hw,
> +	[CLKID_AXI_SYS_NIC]		= &axi_sys_nic.hw,
> +	[CLKID_AXI_ISP_NIC]		= &axi_isp_nic.hw,
> +	[CLKID_AXI_CVE_NIC]		= &axi_cve_nic.hw,
> +	[CLKID_AXI_RAMB]		= &axi_ramb.hw,
> +	[CLKID_AXI_RAMA]		= &axi_rama.hw,
> +	[CLKID_AXI_CPU_DMC]		= &axi_cpu_dmc.hw,
> +	[CLKID_AXI_NIC]			= &axi_nic.hw,
> +	[CLKID_AXI_DMA]			= &axi_dma.hw,
> +	[CLKID_AXI_MUX_NIC]		= &axi_mux_nic.hw,
> +	[CLKID_AXI_CAPU]		= &axi_capu.hw,
> +	[CLKID_AXI_CVE]			= &axi_cve.hw,
> +	[CLKID_AXI_DEV1_DMC]		= &axi_dev1_dmc.hw,
> +	[CLKID_AXI_DEV0_DMC]		= &axi_dev0_dmc.hw,
> +	[CLKID_AXI_DSP_DMC]		= &axi_dsp_dmc.hw,
> +	[CLKID_12_24M_IN]		= &clk_12_24m_in.hw,
> +	[CLKID_12M_24M]			= &clk_12_24m.hw,
> +	[CLKID_FCLK_25M_DIV]		= &fclk_25m_div.hw,
> +	[CLKID_FCLK_25M]		= &fclk_25m.hw,
> +	[CLKID_GEN_SEL]			= &gen_sel.hw,
> +	[CLKID_GEN_DIV]			= &gen_div.hw,
> +	[CLKID_GEN]			= &gen.hw,
> +	[CLKID_SARADC_SEL]		= &saradc_sel.hw,
> +	[CLKID_SARADC_DIV]		= &saradc_div.hw,
> +	[CLKID_SARADC]			= &saradc.hw,
> +	[CLKID_PWM_A_SEL]		= &pwm_a_sel.hw,
> +	[CLKID_PWM_A_DIV]		= &pwm_a_div.hw,
> +	[CLKID_PWM_A]			= &pwm_a.hw,
> +	[CLKID_PWM_B_SEL]		= &pwm_b_sel.hw,
> +	[CLKID_PWM_B_DIV]		= &pwm_b_div.hw,
> +	[CLKID_PWM_B]			= &pwm_b.hw,
> +	[CLKID_PWM_C_SEL]		= &pwm_c_sel.hw,
> +	[CLKID_PWM_C_DIV]		= &pwm_c_div.hw,
> +	[CLKID_PWM_C]			= &pwm_c.hw,
> +	[CLKID_PWM_D_SEL]		= &pwm_d_sel.hw,
> +	[CLKID_PWM_D_DIV]		= &pwm_d_div.hw,
> +	[CLKID_PWM_D]			= &pwm_d.hw,
> +	[CLKID_PWM_E_SEL]		= &pwm_e_sel.hw,
> +	[CLKID_PWM_E_DIV]		= &pwm_e_div.hw,
> +	[CLKID_PWM_E]			= &pwm_e.hw,
> +	[CLKID_PWM_F_SEL]		= &pwm_f_sel.hw,
> +	[CLKID_PWM_F_DIV]		= &pwm_f_div.hw,
> +	[CLKID_PWM_F]			= &pwm_f.hw,
> +	[CLKID_PWM_G_SEL]		= &pwm_g_sel.hw,
> +	[CLKID_PWM_G_DIV]		= &pwm_g_div.hw,
> +	[CLKID_PWM_G]			= &pwm_g.hw,
> +	[CLKID_PWM_H_SEL]		= &pwm_h_sel.hw,
> +	[CLKID_PWM_H_DIV]		= &pwm_h_div.hw,
> +	[CLKID_PWM_H]			= &pwm_h.hw,
> +	[CLKID_PWM_I_SEL]		= &pwm_i_sel.hw,
> +	[CLKID_PWM_I_DIV]		= &pwm_i_div.hw,
> +	[CLKID_PWM_I]			= &pwm_i.hw,
> +	[CLKID_PWM_J_SEL]		= &pwm_j_sel.hw,
> +	[CLKID_PWM_J_DIV]		= &pwm_j_div.hw,
> +	[CLKID_PWM_J]			= &pwm_j.hw,
> +	[CLKID_PWM_K_SEL]		= &pwm_k_sel.hw,
> +	[CLKID_PWM_K_DIV]		= &pwm_k_div.hw,
> +	[CLKID_PWM_K]			= &pwm_k.hw,
> +	[CLKID_PWM_L_SEL]		= &pwm_l_sel.hw,
> +	[CLKID_PWM_L_DIV]		= &pwm_l_div.hw,
> +	[CLKID_PWM_L]			= &pwm_l.hw,
> +	[CLKID_PWM_M_SEL]		= &pwm_m_sel.hw,
> +	[CLKID_PWM_M_DIV]		= &pwm_m_div.hw,
> +	[CLKID_PWM_M]			= &pwm_m.hw,
> +	[CLKID_PWM_N_SEL]		= &pwm_n_sel.hw,
> +	[CLKID_PWM_N_DIV]		= &pwm_n_div.hw,
> +	[CLKID_PWM_N]			= &pwm_n.hw,
> +	[CLKID_SPICC_A_SEL]		= &spicc_a_sel.hw,
> +	[CLKID_SPICC_A_DIV]		= &spicc_a_div.hw,
> +	[CLKID_SPICC_A]			= &spicc_a.hw,
> +	[CLKID_SPICC_B_SEL]		= &spicc_b_sel.hw,
> +	[CLKID_SPICC_B_DIV]		= &spicc_b_div.hw,
> +	[CLKID_SPICC_B]			= &spicc_b.hw,
> +	[CLKID_SPIFC_SEL]		= &spifc_sel.hw,
> +	[CLKID_SPIFC_DIV]		= &spifc_div.hw,
> +	[CLKID_SPIFC]			= &spifc.hw,
> +	[CLKID_SD_EMMC_A_SEL]		= &sd_emmc_a_sel.hw,
> +	[CLKID_SD_EMMC_A_DIV]		= &sd_emmc_a_div.hw,
> +	[CLKID_SD_EMMC_A]		= &sd_emmc_a.hw,
> +	[CLKID_SD_EMMC_B_SEL]		= &sd_emmc_b_sel.hw,
> +	[CLKID_SD_EMMC_B_DIV]		= &sd_emmc_b_div.hw,
> +	[CLKID_SD_EMMC_B]		= &sd_emmc_b.hw,
> +	[CLKID_SD_EMMC_C_SEL]		= &sd_emmc_c_sel.hw,
> +	[CLKID_SD_EMMC_C_DIV]		= &sd_emmc_c_div.hw,
> +	[CLKID_SD_EMMC_C]		= &sd_emmc_c.hw,
> +	[CLKID_TS_DIV]			= &ts_div.hw,
> +	[CLKID_TS]			= &ts.hw,
> +	[CLKID_ETH_125M_DIV]		= &eth_125m_div.hw,
> +	[CLKID_ETH_125M]		= &eth_125m.hw,
> +	[CLKID_ETH_RMII_DIV]		= &eth_rmii_div.hw,
> +	[CLKID_ETH_RMII]		= &eth_rmii.hw,
> +	[CLKID_MIPI_DSI_MEAS_SEL]	= &mipi_dsi_meas_sel.hw,
> +	[CLKID_MIPI_DSI_MEAS_DIV]	= &mipi_dsi_meas_div.hw,
> +	[CLKID_MIPI_DSI_MEAS]		= &mipi_dsi_meas.hw,
> +	[CLKID_DSI_PHY_SEL]		= &dsi_phy_sel.hw,
> +	[CLKID_DSI_PHY_DIV]		= &dsi_phy_div.hw,
> +	[CLKID_DSI_PHY]			= &dsi_phy.hw,
> +	[CLKID_VOUT_MCLK_SEL]		= &vout_mclk_sel.hw,
> +	[CLKID_VOUT_MCLK_DIV]		= &vout_mclk_div.hw,
> +	[CLKID_VOUT_MCLK]		= &vout_mclk.hw,
> +	[CLKID_VOUT_ENC_SEL]		= &vout_enc_sel.hw,
> +	[CLKID_VOUT_ENC_DIV]		= &vout_enc_div.hw,
> +	[CLKID_VOUT_ENC]		= &vout_enc.hw,
> +	[CLKID_HCODEC_0_SEL]		= &hcodec_0_sel.hw,
> +	[CLKID_HCODEC_0_DIV]		= &hcodec_0_div.hw,
> +	[CLKID_HCODEC_0]		= &hcodec_0.hw,
> +	[CLKID_HCODEC_1_SEL]		= &hcodec_1_sel.hw,
> +	[CLKID_HCODEC_1_DIV]		= &hcodec_1_div.hw,
> +	[CLKID_HCODEC_1]		= &hcodec_1.hw,
> +	[CLKID_HCODEC]			= &hcodec.hw,
> +	[CLKID_VC9000E_ACLK_SEL]	= &vc9000e_aclk_sel.hw,
> +	[CLKID_VC9000E_ACLK_DIV]	= &vc9000e_aclk_div.hw,
> +	[CLKID_VC9000E_ACLK]		= &vc9000e_aclk.hw,
> +	[CLKID_VC9000E_CORE_SEL]	= &vc9000e_core_sel.hw,
> +	[CLKID_VC9000E_CORE_DIV]	= &vc9000e_core_div.hw,
> +	[CLKID_VC9000E_CORE]		= &vc9000e_core.hw,
> +	[CLKID_CSI_PHY0_SEL]		= &csi_phy0_sel.hw,
> +	[CLKID_CSI_PHY0_DIV]		= &csi_phy0_div.hw,
> +	[CLKID_CSI_PHY0]		= &csi_phy0.hw,
> +	[CLKID_DEWARPA_SEL]		= &dewarpa_sel.hw,
> +	[CLKID_DEWARPA_DIV]		= &dewarpa_div.hw,
> +	[CLKID_DEWARPA]			= &dewarpa.hw,
> +	[CLKID_ISP0_SEL]		= &isp0_sel.hw,
> +	[CLKID_ISP0_DIV]		= &isp0_div.hw,
> +	[CLKID_ISP0]			= &isp0.hw,
> +	[CLKID_NNA_CORE_SEL]		= &nna_core_sel.hw,
> +	[CLKID_NNA_CORE_DIV]		= &nna_core_div.hw,
> +	[CLKID_NNA_CORE]		= &nna_core.hw,
> +	[CLKID_GE2D_SEL]		= &ge2d_sel.hw,
> +	[CLKID_GE2D_DIV]		= &ge2d_div.hw,
> +	[CLKID_GE2D]			= &ge2d.hw,
> +	[CLKID_VAPB_SEL]		= &vapb_sel.hw,
> +	[CLKID_VAPB_DIV]		= &vapb_div.hw,
> +	[CLKID_VAPB]			= &vapb.hw,
> +};
> +
> +/* Convenience table to populate regmap in .probe */
> +static struct clk_regmap *const c3_periphs_clk_regmaps[] = {
> +	&pll_src,
> +	&mclk_pll_src,
> +	&ddr_pll_src,
> +	&ddr_phy_src,
> +	&usb_pll_src,
> +	&mipi_isp_vout_src,
> +	&usb_ctrl_src,
> +	&eth_pll_src,
> +	&cts_osc_src,
> +	&rtc_xtal_clkin,
> +	&rtc_32k_div,
> +	&rtc_32k_mux,
> +	&rtc_32k,
> +	&rtc_clk,
> +	&sys_a_sel,
> +	&sys_a_div,
> +	&sys_a,
> +	&sys_b_sel,
> +	&sys_b_div,
> +	&sys_b,
> +	&sys_clk,
> +	&axi_a_sel,
> +	&axi_a_div,
> +	&axi_a,
> +	&axi_b_sel,
> +	&axi_b_div,
> +	&axi_b,
> +	&axi_clk,
> +	&sys_reset_ctrl,
> +	&sys_pwr_ctrl,
> +	&sys_pad_ctrl,
> +	&sys_ctrl,
> +	&sys_ts_pll,
> +	&sys_dev_arb,
> +	&sys_mmc_pclk,
> +	&sys_capu,
> +	&sys_cpu_ctrl,
> +	&sys_jtag_ctrl,
> +	&sys_ir_ctrl,
> +	&sys_irq_ctrl,
> +	&sys_msr_clk,
> +	&sys_rom,
> +	&sys_uart_f,
> +	&sys_cpu_apb,
> +	&sys_rsa,
> +	&sys_sar_adc,
> +	&sys_startup,
> +	&sys_secure,
> +	&sys_spifc,
> +	&sys_nna,
> +	&sys_eth_mac,
> +	&sys_gic,
> +	&sys_rama,
> +	&sys_big_nic,
> +	&sys_ramb,
> +	&sys_audio_pclk,
> +	&sys_pwm_kl,
> +	&sys_pwm_ij,
> +	&sys_usb,
> +	&sys_sd_emmc_a,
> +	&sys_sd_emmc_c,
> +	&sys_pwm_ab,
> +	&sys_pwm_cd,
> +	&sys_pwm_ef,
> +	&sys_pwm_gh,
> +	&sys_spicc_1,
> +	&sys_spicc_0,
> +	&sys_uart_a,
> +	&sys_uart_b,
> +	&sys_uart_c,
> +	&sys_uart_d,
> +	&sys_uart_e,
> +	&sys_i2c_m_a,
> +	&sys_i2c_m_b,
> +	&sys_i2c_m_c,
> +	&sys_i2c_m_d,
> +	&sys_i2c_s_a,
> +	&sys_rtc,
> +	&sys_ge2d,
> +	&sys_isp,
> +	&sys_gpv_isp_nic,
> +	&sys_gpv_cve_nic,
> +	&sys_mipi_dsi_host,
> +	&sys_mipi_dsi_phy,
> +	&sys_eth_phy,
> +	&sys_acodec,
> +	&sys_dwap,
> +	&sys_dos,
> +	&sys_cve,
> +	&sys_vout,
> +	&sys_vc9000e,
> +	&sys_pwm_mn,
> +	&sys_sd_emmc_b,
> +	&axi_sys_nic,
> +	&axi_isp_nic,
> +	&axi_cve_nic,
> +	&axi_ramb,
> +	&axi_rama,
> +	&axi_cpu_dmc,
> +	&axi_nic,
> +	&axi_dma,
> +	&axi_mux_nic,
> +	&axi_capu,
> +	&axi_cve,
> +	&axi_dev1_dmc,
> +	&axi_dev0_dmc,
> +	&axi_dsp_dmc,
> +	&clk_12_24m_in,
> +	&clk_12_24m,
> +	&fclk_25m_div,
> +	&fclk_25m,
> +	&gen_sel,
> +	&gen_div,
> +	&gen,
> +	&saradc_sel,
> +	&saradc_div,
> +	&saradc,
> +	&pwm_a_sel,
> +	&pwm_a_div,
> +	&pwm_a,
> +	&pwm_b_sel,
> +	&pwm_b_div,
> +	&pwm_b,
> +	&pwm_c_sel,
> +	&pwm_c_div,
> +	&pwm_c,
> +	&pwm_d_sel,
> +	&pwm_d_div,
> +	&pwm_d,
> +	&pwm_e_sel,
> +	&pwm_e_div,
> +	&pwm_e,
> +	&pwm_f_sel,
> +	&pwm_f_div,
> +	&pwm_f,
> +	&pwm_g_sel,
> +	&pwm_g_div,
> +	&pwm_g,
> +	&pwm_h_sel,
> +	&pwm_h_div,
> +	&pwm_h,
> +	&pwm_i_sel,
> +	&pwm_i_div,
> +	&pwm_i,
> +	&pwm_j_sel,
> +	&pwm_j_div,
> +	&pwm_j,
> +	&pwm_k_sel,
> +	&pwm_k_div,
> +	&pwm_k,
> +	&pwm_l_sel,
> +	&pwm_l_div,
> +	&pwm_l,
> +	&pwm_m_sel,
> +	&pwm_m_div,
> +	&pwm_m,
> +	&pwm_n_sel,
> +	&pwm_n_div,
> +	&pwm_n,
> +	&spicc_a_sel,
> +	&spicc_a_div,
> +	&spicc_a,
> +	&spicc_b_sel,
> +	&spicc_b_div,
> +	&spicc_b,
> +	&spifc_sel,
> +	&spifc_div,
> +	&spifc,
> +	&sd_emmc_a_sel,
> +	&sd_emmc_a_div,
> +	&sd_emmc_a,
> +	&sd_emmc_b_sel,
> +	&sd_emmc_b_div,
> +	&sd_emmc_b,
> +	&sd_emmc_c_sel,
> +	&sd_emmc_c_div,
> +	&sd_emmc_c,
> +	&ts_div,
> +	&ts,
> +	&eth_125m,
> +	&eth_rmii_div,
> +	&eth_rmii,
> +	&mipi_dsi_meas_sel,
> +	&mipi_dsi_meas_div,
> +	&mipi_dsi_meas,
> +	&dsi_phy_sel,
> +	&dsi_phy_div,
> +	&dsi_phy,
> +	&vout_mclk_sel,
> +	&vout_mclk_div,
> +	&vout_mclk,
> +	&vout_enc_sel,
> +	&vout_enc_div,
> +	&vout_enc,
> +	&hcodec_0_sel,
> +	&hcodec_0_div,
> +	&hcodec_0,
> +	&hcodec_1_sel,
> +	&hcodec_1_div,
> +	&hcodec_1,
> +	&hcodec,
> +	&vc9000e_aclk_sel,
> +	&vc9000e_aclk_div,
> +	&vc9000e_aclk,
> +	&vc9000e_core_sel,
> +	&vc9000e_core_div,
> +	&vc9000e_core,
> +	&csi_phy0_sel,
> +	&csi_phy0_div,
> +	&csi_phy0,
> +	&dewarpa_sel,
> +	&dewarpa_div,
> +	&dewarpa,
> +	&isp0_sel,
> +	&isp0_div,
> +	&isp0,
> +	&nna_core_sel,
> +	&nna_core_div,
> +	&nna_core,
> +	&ge2d_sel,
> +	&ge2d_div,
> +	&ge2d,
> +	&vapb_sel,
> +	&vapb_div,
> +	&vapb,
> +};
> +
> +static struct regmap_config clkc_regmap_config = {
> +	.reg_bits       = 32,
> +	.val_bits       = 32,
> +	.reg_stride     = 4,
> +};
> +
> +static struct meson_clk_hw_data c3_periphs_clks = {
> +	.hws = c3_periphs_hw_clks,
> +	.num = ARRAY_SIZE(c3_periphs_hw_clks),
> +};
> +
> +static int aml_c3_peripherals_probe(struct platform_device *pdev)
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
> +	for (i = 0; i < ARRAY_SIZE(c3_periphs_clk_regmaps); i++)
> +		c3_periphs_clk_regmaps[i]->map = regmap;
> +
> +	for (clkid = 0; clkid < c3_periphs_clks.num; clkid++) {
> +		/* array might be sparse */
> +		if (!c3_periphs_clks.hws[clkid])
> +			continue;
> +
> +		ret = devm_clk_hw_register(dev, c3_periphs_clks.hws[clkid]);
> +		if (ret) {
> +			dev_err(dev, "Clock registration failed\n");
> +			return ret;
> +		}
> +	}
> +
> +	return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get,
> +					   &c3_periphs_clks);
> +}
> +
> +static const struct of_device_id c3_peripherals_clkc_match_table[] = {
> +	{
> +		.compatible = "amlogic,c3-peripherals-clkc",
> +	},
> +	{ /* sentinel */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, c3_peripherals_clkc_match_table);
> +
> +static struct platform_driver c3_peripherals_driver = {
> +	.probe		= aml_c3_peripherals_probe,
> +	.driver		= {
> +		.name	= "c3-peripherals-clkc",
> +		.of_match_table = c3_peripherals_clkc_match_table,
> +	},
> +};
> +
> +module_platform_driver(c3_peripherals_driver);
> +MODULE_AUTHOR("Chuan Liu <chuan.liu@amlogic.com>");
> +MODULE_LICENSE("GPL");

