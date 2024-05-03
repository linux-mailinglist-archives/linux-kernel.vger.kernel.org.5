Return-Path: <linux-kernel+bounces-167636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE578BAC54
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C48F1F22E09
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617CB15357B;
	Fri,  3 May 2024 12:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O8RGkI62"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B7C15356B
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714739018; cv=none; b=NAEcRsIp7dCU9pHTW1RdU8bRzdNw0nHHf7F1GBaghPSgNECGOUf3tUx0Ar6dqJEdkTA5pvJibuWKeKUYIjJd5BDvQiHwfO3bDtOQLuTq3xfaCE6OIdq5DULq1V9LlnivWN4EhnFMg6W87MSy1CZRdsHaLKO+rmBGeIn4V7Zuf9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714739018; c=relaxed/simple;
	bh=XnTyRZK+0+16Hj85LmaCYYlyBc+AHv0F4elnf8Pm8Gs=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=BBZlpDtbPKQy6+aWEc2AO/nxddk5IUNHgN1QP98BernmS6tTcp9sxPSkcIjqHnq5UbZnZyQsUfqWIrVxX10C0JAZb1Jw3ATq5wSicTXBVpM+VVQtrWDmYMkBic+IoAMoFYodxCYjRZypb3zeP+ScCJ6Mu2e+YR9DliFjWZI11xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=O8RGkI62; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41b79450f78so53728445e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 05:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714739014; x=1715343814; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=OQddftf+WiRjNm1XyheDfP5NY6m0q6E/fReItmrWHOk=;
        b=O8RGkI625mipoXanhYhZ2QlqrwHAP5Lw5hiEN/PmQ8DB6LqJWOjqPkAy2DqEODvcTY
         71zjulAndtHpKZL+fYoE6orXef+s9eml5zUxV2DbStx9WALm4ULBYjdMNJQbHTUvkjKy
         ztVWDOsfOqMwOW900FKhxXlWlA2CPFsHWm/5+u1ZWeqOy+IXfKgjQ3Z2ov2LPO05mUB+
         SEUB156CcWQoPmfh4tyxxlAAANXXYI2cCgBLpUGifFuwiVxwb486ImY+ubofLb0fb5wl
         HAMn9B6n8x69VR17V5tfDGtjWcrtMFsHnyJWyueKBaQNlJuSh2dULyzT0rE7FmBawgnN
         4Y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714739014; x=1715343814;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQddftf+WiRjNm1XyheDfP5NY6m0q6E/fReItmrWHOk=;
        b=a9gDQ51qKWkwpsQEsLJBw3EtfkHBNOX6d7g/8BxJSYZrgr95wgPEMgg2czPf/qlX+7
         llj45KjhonSqXX7Fh40Wp1Rrkio80ox74rrIvWvsLe2A9wEgMNNNixMjp+TZBwZ/xOSk
         vvutdCMdHJZv8v6rI4Q1dsMaF5Km62Qqu6QvuyuYg7p9LRSUctDWU55177ugGxjEDRMW
         n4dCbaDo3+xHQd2KPiR7aiMurPjeasIXBWbC16CDAAbBIhIzcA/3UhV5ebTvB0K8B7jJ
         P6BHR0LVeC0dDNqpjG7UwiJAbOtl/hlfkObsmSLDZWYW6UEv4vJVcnhFoOehv6MPnvmD
         h3Sg==
X-Forwarded-Encrypted: i=1; AJvYcCXc4yBSnaNWOhPT+YrWBNu4ecmWzSBbl3DvQ7s6NjFpI36ZwHOu5/VZKflRq3cfUCk1ahQzYgemayFlxLCG4kV23YqJgTCQbmjZ0Zcj
X-Gm-Message-State: AOJu0YwRcLPE4oXVxx28E8ldOuUkyVp0r2iIm1ZX7p4M6p6X2rMpcxhq
	j/Jl8N7iesfaGzh0OBNUH7xx3tvOb6G7r7+I+VQJDIZVueSltPNQEYGO7I72M20=
X-Google-Smtp-Source: AGHT+IGt/a/YZaZxqrmw+XwdJsv21tISbhmIaDrKZBNLlE29d7ldni6Rk3ROlaPAnb6V5edhUM47SA==
X-Received: by 2002:a05:600c:3511:b0:418:a985:3ca with SMTP id h17-20020a05600c351100b00418a98503camr2389911wmq.31.1714739014168;
        Fri, 03 May 2024 05:23:34 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:1b85:e590:355b:9957])
        by smtp.gmail.com with ESMTPSA id w20-20020a05600c475400b0041befc2652csm9271285wmo.31.2024.05.03.05.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 05:23:33 -0700 (PDT)
References: <20240424050928.1997820-1-xianwei.zhao@amlogic.com>
 <20240424050928.1997820-5-xianwei.zhao@amlogic.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Neil Armstrong
 <neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, Michael
 Turquette <mturquette@baylibre.com>, Stephen  Boyd <sboyd@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Chuan Liu <chuan.liu@amlogic.com>
Subject: Re: [PATCH v7 4/5] clk: meson: c3: add support for the C3 SoC PLL
 clock
Date: Fri, 03 May 2024 14:21:50 +0200
In-reply-to: <20240424050928.1997820-5-xianwei.zhao@amlogic.com>
Message-ID: <1jcyq33wze.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Wed 24 Apr 2024 at 13:09, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:

> Add the C3 PLL clock controller driver for the Amlogic C3 SoC family.
>
> Co-developed-by: Chuan Liu <chuan.liu@amlogic.com>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  drivers/clk/meson/Kconfig  |  14 +
>  drivers/clk/meson/Makefile |   1 +
>  drivers/clk/meson/c3-pll.c | 747 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 762 insertions(+)
>  create mode 100644 drivers/clk/meson/c3-pll.c
>
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index 29ffd14d267b..9f975a980581 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -128,6 +128,20 @@ config COMMON_CLK_A1_PERIPHERALS
>  	  device, A1 SoC Family. Say Y if you want A1 Peripherals clock
>  	  controller to work.
>  
> +config COMMON_CLK_C3_PLL
> +	tristate "Amlogic C3 PLL clock controller"
> +	depends on ARM64
> +	depends on ARM_SCMI_PROTOCOL
> +	depends on COMMON_CLK_SCMI

Same here. imply not depends.
And you it should really imply COMMON_CLK_SCMI only.

COMMON_CLK_SCMI already depends on ARM_SCMI_PROTOCOL, as it should.

> +	default y
> +	select COMMON_CLK_MESON_REGMAP
> +	select COMMON_CLK_MESON_PLL
> +	select COMMON_CLK_MESON_CLKC_UTILS
> +	help
> +	  Support for the PLL clock controller on Amlogic C302X and C308L devices,
> +	  AKA C3. Say Y if you want the board to work, because PLLs are the parent
> +	  of most peripherals.
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
> index 000000000000..c84fce1232bd
> --- /dev/null
> +++ b/drivers/clk/meson/c3-pll.c
> @@ -0,0 +1,747 @@
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
> +#include "clk-regmap.h"
> +#include "clk-pll.h"
> +#include "meson-clkc-utils.h"
> +#include <dt-bindings/clock/amlogic,c3-pll-clkc.h>
> +
> +#define ANACTRL_FIXPLL_CTRL4			0x50
> +#define ANACTRL_GP0PLL_CTRL0			0x80
> +#define ANACTRL_GP0PLL_CTRL1			0x84
> +#define ANACTRL_GP0PLL_CTRL2			0x88
> +#define ANACTRL_GP0PLL_CTRL3			0x8c
> +#define ANACTRL_GP0PLL_CTRL4			0x90
> +#define ANACTRL_GP0PLL_CTRL5			0x94
> +#define ANACTRL_GP0PLL_CTRL6			0x98
> +#define ANACTRL_HIFIPLL_CTRL0			0x100
> +#define ANACTRL_HIFIPLL_CTRL1			0x104
> +#define ANACTRL_HIFIPLL_CTRL2			0x108
> +#define ANACTRL_HIFIPLL_CTRL3			0x10c
> +#define ANACTRL_HIFIPLL_CTRL4			0x110
> +#define ANACTRL_HIFIPLL_CTRL5			0x114
> +#define ANACTRL_HIFIPLL_CTRL6			0x118
> +#define ANACTRL_MPLL_CTRL0			0x180
> +#define ANACTRL_MPLL_CTRL1			0x184
> +#define ANACTRL_MPLL_CTRL2			0x188
> +#define ANACTRL_MPLL_CTRL3			0x18c
> +#define ANACTRL_MPLL_CTRL4			0x190
> +
> +static struct clk_regmap fclk_50m_en = {
> +	.data = &(struct clk_regmap_gate_data) {
> +		.offset = ANACTRL_FIXPLL_CTRL4,
> +		.bit_idx = 0,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "fclk_50m_en",
> +		.ops = &clk_regmap_gate_ro_ops,
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "fix"
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
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "fix"
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
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "fix"
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
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "fix"
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
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "fix"
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
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "fix"
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
> +		.parent_data = &(const struct clk_parent_data) {
> +			.fw_name = "fix"
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
> +			.shift   = 16,
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
> +			.fw_name = "mclk",
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
> +	{ .fw_name = "mclk" },
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
> +	&fclk_50m_en,
> +	&fclk_div2,
> +	&fclk_div2p5,
> +	&fclk_div3,
> +	&fclk_div4,
> +	&fclk_div5,
> +	&fclk_div7,
> +	&gp0_pll_dco,
> +	&gp0_pll,
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
> +	.max_register   = ANACTRL_MPLL_CTRL4,
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


-- 
Jerome

