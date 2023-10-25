Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892607D71D1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbjJYQkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjJYQkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:40:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2B9133
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 09:40:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40907b82ab9so6642465e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 09:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698252023; x=1698856823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oh0wxlYlNb/Bs84+L5etIP6IBSlclExpEoyh+BvUVk8=;
        b=yHcZo6H9PGKI0URyXx0sKSJq85npSrymHdDzlfGG9+sCVt93cmD9ZnwAnt9jKfxfIO
         OM3kOLTpTBlGQmUxb4Q2kTYfN8WImloIDtstLxGpiF5Vuku9pGrX5LwEbmoABvPxj/tb
         DnCgk808KCiNWBdXn0K8IoHZb9EUGS2yEf/ZX/mBEBDnuLvuEAYGQ009ZJ5K+wuQJZDc
         myMzOQ0SGGjUKllLI3DebNyCqeEYfpeT6eFmRL3pHprI+gtDtjeqk/EdMILuRa6Ij5GH
         IpvSX7kJapaiyyBM5jfbwe0dTdD1Bh6LXI5hTShYMHSy3d0rsaPh2nat87mCRJxXj2mr
         ZOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698252023; x=1698856823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oh0wxlYlNb/Bs84+L5etIP6IBSlclExpEoyh+BvUVk8=;
        b=tiaL81hTFd1/khVKLrS7EQmSWAY/kj3YhW34qlmiDFDbqghqBIou9SFW/GkVrtINXP
         1kBZwAXQkey6omJ+CxVHXtEF/Kwd5iExRvhLlOuBlxx9yFDhIKtLyT9XrcoM6Xyk4mUy
         eisqbDpq1Mvz303B1w3y9WtpN1/lDfQ9/Y2TgNbRijhgx5dnxmS39RqECBMY7fruD9dd
         qy18PBaNVAo/r2mxh9qIiJVxLQYfB865yRjk/dGME6OGkuozQU+oQO9KKnVy488/ZQUh
         5GG8Au0jRKiCa1uSksXQfyWBua28OkucInNrjgfWJepGYf+c0qJSnnR+w51kZYs+tsfl
         251g==
X-Gm-Message-State: AOJu0YxfdfuTbkmtWChlEwxi7ja65iY2qM9TO+GThLJmTh9Z675Mnx7+
        PjlOf151q+6uywoao+NuGlLr0Q==
X-Google-Smtp-Source: AGHT+IEga89kjVIWfjWTzEtt8/lIAMohMqeYKiPr4BPIwpTo0cL6ziArjX7DNHaPjkFrZbcclJUwLw==
X-Received: by 2002:a5d:64ac:0:b0:313:f75b:c552 with SMTP id m12-20020a5d64ac000000b00313f75bc552mr233186wrp.15.1698252022532;
        Wed, 25 Oct 2023 09:40:22 -0700 (PDT)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id f7-20020adff587000000b0031fb91f23e9sm12395617wro.43.2023.10.25.09.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 09:40:22 -0700 (PDT)
Message-ID: <483c4de3-951c-4ba4-89fb-36fcd44fa99f@linaro.org>
Date:   Wed, 25 Oct 2023 17:40:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] clk: qcom: Add Global Clock controller (GCC) driver
 for SC8380XP
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     agross@kernel.org, conor+dt@kernel.org, quic_tdas@quicinc.com,
        quic_rjendra@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        abel.vesa@linaro.org, quic_tsoni@quicinc.com
References: <20231025133320.4720-1-quic_sibis@quicinc.com>
 <20231025133320.4720-3-quic_sibis@quicinc.com>
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231025133320.4720-3-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2023 14:33, Sibi Sankar wrote:
> From: Rajendra Nayak <quic_rjendra@quicinc.com>
> 
> Add support for the global clock controller found on SC8380XP
> based devices.
> 
> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
>   drivers/clk/qcom/Kconfig        |   10 +
>   drivers/clk/qcom/Makefile       |    1 +
>   drivers/clk/qcom/gcc-sc8380xp.c | 6812 +++++++++++++++++++++++++++++++
>   3 files changed, 6823 insertions(+)
>   create mode 100644 drivers/clk/qcom/gcc-sc8380xp.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index ad1acd9b7426..013b3a1ad551 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -515,6 +515,16 @@ config SC_GCC_8280XP
>   	  Say Y if you want to use peripheral devices such as UART, SPI,
>   	  I2C, USB, UFS, SDCC, etc.
>   
> +config SC_GCC_8380XP
> +	tristate "SC8380XP Global Clock Controller"
> +	select QCOM_GDSC
> +	depends on COMMON_CLK_QCOM
> +	help
> +	  Support for the global clock controller on Qualcomm Technologies, Inc
> +	  SC8380XP devices.
> +	  Say Y if you want to use peripheral devices such as UART, SPI, I2C,
> +	  USB, UFS, SD/eMMC, PCIe, etc.
> +
>   config SC_GPUCC_7180
>   	tristate "SC7180 Graphics Clock Controller"
>   	depends on ARM64 || COMPILE_TEST
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 17edd73f9839..11b1f79e15c5 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -77,6 +77,7 @@ obj-$(CONFIG_SC_GCC_7180) += gcc-sc7180.o
>   obj-$(CONFIG_SC_GCC_7280) += gcc-sc7280.o
>   obj-$(CONFIG_SC_GCC_8180X) += gcc-sc8180x.o
>   obj-$(CONFIG_SC_GCC_8280XP) += gcc-sc8280xp.o
> +obj-$(CONFIG_SC_GCC_8380XP) += gcc-sc8380xp.o
>   obj-$(CONFIG_SC_GPUCC_7180) += gpucc-sc7180.o
>   obj-$(CONFIG_SC_GPUCC_7280) += gpucc-sc7280.o
>   obj-$(CONFIG_SC_GPUCC_8280XP) += gpucc-sc8280xp.o
> diff --git a/drivers/clk/qcom/gcc-sc8380xp.c b/drivers/clk/qcom/gcc-sc8380xp.c
> new file mode 100644
> index 000000000000..48c50f9421c8
> --- /dev/null
> +++ b/drivers/clk/qcom/gcc-sc8380xp.c
> @@ -0,0 +1,6812 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,sc8380xp-gcc.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "clk-regmap-divider.h"
> +#include "clk-regmap-mux.h"
> +#include "clk-regmap-phy-mux.h"
> +#include "gdsc.h"
> +#include "reset.h"
> +
> +enum {
> +	DT_BI_TCXO,
> +	DT_SLEEP_CLK,
> +	DT_PCIE_3_PIPE,
> +	DT_PCIE_4_PIPE,
> +	DT_PCIE_5_PIPE,
> +	DT_PCIE_6A_PIPE,
> +	DT_PCIE_6B_PIPE,
> +	DT_USB3_PHY_0_WRAPPER_GCC_USB30_PIPE,
> +	DT_USB3_PHY_1_WRAPPER_GCC_USB30_PIPE,
> +	DT_USB3_PHY_2_WRAPPER_GCC_USB30_PIPE,
> +};
> +
> +enum {
> +	P_BI_TCXO,
> +	P_GCC_GPLL0_OUT_EVEN,
> +	P_GCC_GPLL0_OUT_MAIN,
> +	P_GCC_GPLL4_OUT_MAIN,
> +	P_GCC_GPLL7_OUT_MAIN,
> +	P_GCC_GPLL8_OUT_MAIN,
> +	P_GCC_GPLL9_OUT_MAIN,
> +	P_SLEEP_CLK,
> +	P_USB3_PHY_0_WRAPPER_GCC_USB30_PIPE_CLK,
> +	P_USB3_PHY_1_WRAPPER_GCC_USB30_PIPE_CLK,
> +	P_USB3_PHY_2_WRAPPER_GCC_USB30_PIPE_CLK,
> +};
> +
> +static struct clk_alpha_pll gcc_gpll0 = {
> +	.offset = 0x0,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
> +	.clkr = {
> +		.enable_reg = 0x52030,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gcc_gpll0",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.index = DT_BI_TCXO,
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_fixed_lucid_ole_ops,
> +		},
> +	},
> +};
> +
> +static const struct clk_div_table post_div_table_gcc_gpll0_out_even[] = {
> +	{ 0x1, 2 },
> +	{ }
> +};
> +
> +static struct clk_alpha_pll_postdiv gcc_gpll0_out_even = {
> +	.offset = 0x0,
> +	.post_div_shift = 10,
> +	.post_div_table = post_div_table_gcc_gpll0_out_even,
> +	.num_post_div = ARRAY_SIZE(post_div_table_gcc_gpll0_out_even),
> +	.width = 4,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_gpll0_out_even",
> +		.parent_hws = (const struct clk_hw*[]) {
> +			&gcc_gpll0.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.ops = &clk_alpha_pll_postdiv_lucid_ole_ops,
> +	},
> +};
> +
> +static struct clk_alpha_pll gcc_gpll4 = {
> +	.offset = 0x4000,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
> +	.clkr = {
> +		.enable_reg = 0x52030,
> +		.enable_mask = BIT(4),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gcc_gpll4",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.index = DT_BI_TCXO,
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_fixed_lucid_ole_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_alpha_pll gcc_gpll7 = {
> +	.offset = 0x7000,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
> +	.clkr = {
> +		.enable_reg = 0x52030,
> +		.enable_mask = BIT(7),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gcc_gpll7",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.index = DT_BI_TCXO,
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_fixed_lucid_ole_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_alpha_pll gcc_gpll8 = {
> +	.offset = 0x8000,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
> +	.clkr = {
> +		.enable_reg = 0x52030,
> +		.enable_mask = BIT(8),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gcc_gpll8",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.index = DT_BI_TCXO,
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_fixed_lucid_ole_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_alpha_pll gcc_gpll9 = {
> +	.offset = 0x9000,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_OLE],
> +	.clkr = {
> +		.enable_reg = 0x52030,
> +		.enable_mask = BIT(9),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gcc_gpll9",
> +			.parent_data = &(const struct clk_parent_data) {
> +				.index = DT_BI_TCXO,
> +			},
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_fixed_lucid_ole_ops,
> +		},
> +	},
> +};
> +
> +static const struct parent_map gcc_parent_map_0[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GCC_GPLL0_OUT_MAIN, 1 },
> +	{ P_GCC_GPLL0_OUT_EVEN, 6 },
> +};
> +
> +static const struct clk_parent_data gcc_parent_data_0[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .hw = &gcc_gpll0.clkr.hw },
> +	{ .hw = &gcc_gpll0_out_even.clkr.hw },
> +};
> +
> +static const struct parent_map gcc_parent_map_1[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_SLEEP_CLK, 5 },
> +};
> +
> +static const struct clk_parent_data gcc_parent_data_1[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .index = DT_SLEEP_CLK },
> +};
> +
> +static const struct parent_map gcc_parent_map_2[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GCC_GPLL0_OUT_MAIN, 1 },
> +	{ P_SLEEP_CLK, 5 },
> +	{ P_GCC_GPLL0_OUT_EVEN, 6 },
> +};
> +
> +static const struct clk_parent_data gcc_parent_data_2[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .hw = &gcc_gpll0.clkr.hw },
> +	{ .index = DT_SLEEP_CLK },
> +	{ .hw = &gcc_gpll0_out_even.clkr.hw },
> +};
> +
> +static const struct parent_map gcc_parent_map_3[] = {
> +	{ P_BI_TCXO, 0 },
> +};
> +
> +static const struct clk_parent_data gcc_parent_data_3[] = {
> +	{ .index = DT_BI_TCXO },
> +};
> +
> +static const struct parent_map gcc_parent_map_4[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GCC_GPLL0_OUT_MAIN, 1 },
> +	{ P_GCC_GPLL8_OUT_MAIN, 2 },
> +	{ P_GCC_GPLL0_OUT_EVEN, 6 },
> +};
> +
> +static const struct clk_parent_data gcc_parent_data_4[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .hw = &gcc_gpll0.clkr.hw },
> +	{ .hw = &gcc_gpll8.clkr.hw },
> +	{ .hw = &gcc_gpll0_out_even.clkr.hw },
> +};
> +
> +static const struct parent_map gcc_parent_map_5[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GCC_GPLL0_OUT_MAIN, 1 },
> +	{ P_GCC_GPLL7_OUT_MAIN, 2 },
> +	{ P_SLEEP_CLK, 5 },
> +};
> +
> +static const struct clk_parent_data gcc_parent_data_5[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .hw = &gcc_gpll0.clkr.hw },
> +	{ .hw = &gcc_gpll7.clkr.hw },
> +	{ .index = DT_SLEEP_CLK },
> +};
> +
> +static const struct parent_map gcc_parent_map_6[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GCC_GPLL0_OUT_MAIN, 1 },
> +	{ P_GCC_GPLL7_OUT_MAIN, 2 },
> +};
> +
> +static const struct clk_parent_data gcc_parent_data_6[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .hw = &gcc_gpll0.clkr.hw },
> +	{ .hw = &gcc_gpll7.clkr.hw },
> +};
> +
> +static const struct parent_map gcc_parent_map_7[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GCC_GPLL0_OUT_MAIN, 1 },
> +	{ P_GCC_GPLL4_OUT_MAIN, 5 },
> +	{ P_GCC_GPLL0_OUT_EVEN, 6 },
> +};
> +
> +static const struct clk_parent_data gcc_parent_data_7[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .hw = &gcc_gpll0.clkr.hw },
> +	{ .hw = &gcc_gpll4.clkr.hw },
> +	{ .hw = &gcc_gpll0_out_even.clkr.hw },
> +};
> +
> +static const struct parent_map gcc_parent_map_8[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GCC_GPLL0_OUT_MAIN, 1 },
> +	{ P_GCC_GPLL7_OUT_MAIN, 2 },
> +	{ P_GCC_GPLL0_OUT_EVEN, 6 },
> +};
> +
> +static const struct clk_parent_data gcc_parent_data_8[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .hw = &gcc_gpll0.clkr.hw },
> +	{ .hw = &gcc_gpll7.clkr.hw },
> +	{ .hw = &gcc_gpll0_out_even.clkr.hw },
> +};
> +
> +static const struct parent_map gcc_parent_map_9[] = {
> +	{ P_BI_TCXO, 0 },
> +	{ P_GCC_GPLL0_OUT_MAIN, 1 },
> +	{ P_GCC_GPLL9_OUT_MAIN, 2 },
> +	{ P_GCC_GPLL4_OUT_MAIN, 5 },
> +	{ P_GCC_GPLL0_OUT_EVEN, 6 },
> +};
> +
> +static const struct clk_parent_data gcc_parent_data_10[] = {
> +	{ .index = DT_USB3_PHY_0_WRAPPER_GCC_USB30_PIPE },
> +	{ .index = DT_BI_TCXO },
> +};
> +
> +static const struct parent_map gcc_parent_map_10[] = {
> +	{ P_USB3_PHY_0_WRAPPER_GCC_USB30_PIPE_CLK, 0 },
> +	{ P_BI_TCXO, 2 },
> +};
> +
> +static const struct clk_parent_data gcc_parent_data_11[] = {
> +	{ .index = DT_USB3_PHY_1_WRAPPER_GCC_USB30_PIPE },
> +	{ .index = DT_BI_TCXO },
> +};
> +
> +static const struct parent_map gcc_parent_map_11[] = {
> +	{ P_USB3_PHY_1_WRAPPER_GCC_USB30_PIPE_CLK, 0 },
> +	{ P_BI_TCXO, 2 },
> +};
> +
> +static const struct clk_parent_data gcc_parent_data_12[] = {
> +	{ .index = DT_USB3_PHY_2_WRAPPER_GCC_USB30_PIPE },
> +	{ .index = DT_BI_TCXO },
> +};
> +
> +static const struct parent_map gcc_parent_map_12[] = {
> +	{ P_USB3_PHY_2_WRAPPER_GCC_USB30_PIPE_CLK, 0 },
> +	{ P_BI_TCXO, 2 },
> +};
> +
> +static const struct clk_parent_data gcc_parent_data_9[] = {
> +	{ .index = DT_BI_TCXO },
> +	{ .hw = &gcc_gpll0.clkr.hw },
> +	{ .hw = &gcc_gpll9.clkr.hw },
> +	{ .hw = &gcc_gpll4.clkr.hw },
> +	{ .hw = &gcc_gpll0_out_even.clkr.hw },
> +};
> +
> +static const struct freq_tbl ftbl_gcc_gp1_clk_src[] = {
> +	F(50000000, P_GCC_GPLL0_OUT_EVEN, 6, 0, 0),
> +	F(100000000, P_GCC_GPLL0_OUT_MAIN, 6, 0, 0),
> +	F(200000000, P_GCC_GPLL0_OUT_MAIN, 3, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_gp1_clk_src = {
> +	.cmd_rcgr = 0x64004,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_2,
> +	.freq_tbl = ftbl_gcc_gp1_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_gp1_clk_src",
> +		.parent_data = gcc_parent_data_2,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 gcc_gp2_clk_src = {
> +	.cmd_rcgr = 0x65004,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_2,
> +	.freq_tbl = ftbl_gcc_gp1_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_gp2_clk_src",
> +		.parent_data = gcc_parent_data_2,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 gcc_gp3_clk_src = {
> +	.cmd_rcgr = 0x66004,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_2,
> +	.freq_tbl = ftbl_gcc_gp1_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_gp3_clk_src",
> +		.parent_data = gcc_parent_data_2,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_pcie_0_aux_clk_src[] = {
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_pcie_0_aux_clk_src = {
> +	.cmd_rcgr = 0xa0180,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_1,
> +	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_pcie_0_aux_clk_src",
> +		.parent_data = gcc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_pcie_0_phy_rchng_clk_src[] = {
> +	F(100000000, P_GCC_GPLL0_OUT_EVEN, 3, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_pcie_0_phy_rchng_clk_src = {
> +	.cmd_rcgr = 0xa0054,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_pcie_0_phy_rchng_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_pcie_0_phy_rchng_clk_src",
> +		.parent_data = gcc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 gcc_pcie_1_aux_clk_src = {
> +	.cmd_rcgr = 0x2c180,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_1,
> +	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_pcie_1_aux_clk_src",
> +		.parent_data = gcc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 gcc_pcie_1_phy_rchng_clk_src = {
> +	.cmd_rcgr = 0x2c054,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_pcie_0_phy_rchng_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_pcie_1_phy_rchng_clk_src",
> +		.parent_data = gcc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 gcc_pcie_2_aux_clk_src = {
> +	.cmd_rcgr = 0x13180,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_1,
> +	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_pcie_2_aux_clk_src",
> +		.parent_data = gcc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 gcc_pcie_2_phy_rchng_clk_src = {
> +	.cmd_rcgr = 0x13054,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_pcie_0_phy_rchng_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_pcie_2_phy_rchng_clk_src",
> +		.parent_data = gcc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 gcc_pcie_3_aux_clk_src = {
> +	.cmd_rcgr = 0x5808c,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_1,
> +	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_pcie_3_aux_clk_src",
> +		.parent_data = gcc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 gcc_pcie_3_phy_rchng_clk_src = {
> +	.cmd_rcgr = 0x58070,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_pcie_0_phy_rchng_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_pcie_3_phy_rchng_clk_src",
> +		.parent_data = gcc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 gcc_pcie_4_aux_clk_src = {
> +	.cmd_rcgr = 0x6b080,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_1,
> +	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_pcie_4_aux_clk_src",
> +		.parent_data = gcc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 gcc_pcie_4_phy_rchng_clk_src = {
> +	.cmd_rcgr = 0x6b064,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_pcie_0_phy_rchng_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_pcie_4_phy_rchng_clk_src",
> +		.parent_data = gcc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 gcc_pcie_5_aux_clk_src = {
> +	.cmd_rcgr = 0x2f080,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_1,
> +	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_pcie_5_aux_clk_src",
> +		.parent_data = gcc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 gcc_pcie_5_phy_rchng_clk_src = {
> +	.cmd_rcgr = 0x2f064,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_pcie_0_phy_rchng_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_pcie_5_phy_rchng_clk_src",
> +		.parent_data = gcc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 gcc_pcie_6a_aux_clk_src = {
> +	.cmd_rcgr = 0x3108c,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_1,
> +	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_pcie_6a_aux_clk_src",
> +		.parent_data = gcc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 gcc_pcie_6a_phy_rchng_clk_src = {
> +	.cmd_rcgr = 0x31070,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_pcie_0_phy_rchng_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_pcie_6a_phy_rchng_clk_src",
> +		.parent_data = gcc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 gcc_pcie_6b_aux_clk_src = {
> +	.cmd_rcgr = 0x8d08c,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_1,
> +	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_pcie_6b_aux_clk_src",
> +		.parent_data = gcc_parent_data_1,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 gcc_pcie_6b_phy_rchng_clk_src = {
> +	.cmd_rcgr = 0x8d070,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_pcie_0_phy_rchng_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_pcie_6b_phy_rchng_clk_src",
> +		.parent_data = gcc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 gcc_pcie_rscc_xo_clk_src = {
> +	.cmd_rcgr = 0xa400c,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_3,
> +	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_pcie_rscc_xo_clk_src",
> +		.parent_data = gcc_parent_data_3,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_pdm2_clk_src[] = {
> +	F(60000000, P_GCC_GPLL0_OUT_MAIN, 10, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_pdm2_clk_src = {
> +	.cmd_rcgr = 0x33010,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_pdm2_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_pdm2_clk_src",
> +		.parent_data = gcc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,

Again difference to sc8280xp - should this be clk_rcg2_shared_ops to park ?

> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
> +	F(7372800, P_GCC_GPLL0_OUT_EVEN, 1, 384, 15625),
> +	F(14745600, P_GCC_GPLL0_OUT_EVEN, 1, 768, 15625),
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	F(29491200, P_GCC_GPLL0_OUT_EVEN, 1, 1536, 15625),
> +	F(32000000, P_GCC_GPLL0_OUT_EVEN, 1, 8, 75),
> +	F(48000000, P_GCC_GPLL0_OUT_EVEN, 1, 4, 25),
> +	F(64000000, P_GCC_GPLL0_OUT_EVEN, 1, 16, 75),
> +	F(75000000, P_GCC_GPLL0_OUT_EVEN, 4, 0, 0),
> +	F(80000000, P_GCC_GPLL0_OUT_EVEN, 1, 4, 15),
> +	F(96000000, P_GCC_GPLL0_OUT_EVEN, 1, 8, 25),
> +	F(120000000, P_GCC_GPLL0_OUT_MAIN, 5, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap0_s0_clk_src_init = {
> +	.name = "gcc_qupv3_wrap0_s0_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.ops = &clk_rcg2_ops,

Shared on sc8280xp - should be shared on sc8380xp ? Same comment for all 
of the qupv3 .ops.

> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap0_s0_clk_src = {
> +	.cmd_rcgr = 0x42010,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap0_s0_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap0_s1_clk_src_init = {
> +	.name = "gcc_qupv3_wrap0_s1_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap0_s1_clk_src = {
> +	.cmd_rcgr = 0x42148,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap0_s1_clk_src_init,
> +};
> +
> +static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s2_clk_src[] = {
> +	F(7372800, P_GCC_GPLL0_OUT_EVEN, 1, 384, 15625),
> +	F(14745600, P_GCC_GPLL0_OUT_EVEN, 1, 768, 15625),
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	F(29491200, P_GCC_GPLL0_OUT_EVEN, 1, 1536, 15625),
> +	F(32000000, P_GCC_GPLL0_OUT_EVEN, 1, 8, 75),
> +	F(48000000, P_GCC_GPLL0_OUT_EVEN, 1, 4, 25),
> +	F(64000000, P_GCC_GPLL0_OUT_EVEN, 1, 16, 75),
> +	F(80000000, P_GCC_GPLL0_OUT_EVEN, 1, 4, 15),
> +	F(96000000, P_GCC_GPLL0_OUT_EVEN, 1, 8, 25),
> +	F(150000000, P_GCC_GPLL0_OUT_EVEN, 2, 0, 0),
> +	F(200000000, P_GCC_GPLL0_OUT_MAIN, 3, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap0_s2_clk_src_init = {
> +	.name = "gcc_qupv3_wrap0_s2_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap0_s2_clk_src = {
> +	.cmd_rcgr = 0x42288,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s2_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap0_s2_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap0_s3_clk_src_init = {
> +	.name = "gcc_qupv3_wrap0_s3_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap0_s3_clk_src = {
> +	.cmd_rcgr = 0x423c8,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s2_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap0_s3_clk_src_init,
> +};
> +
> +static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s4_clk_src[] = {
> +	F(7372800, P_GCC_GPLL0_OUT_EVEN, 1, 384, 15625),
> +	F(14745600, P_GCC_GPLL0_OUT_EVEN, 1, 768, 15625),
> +	F(19200000, P_BI_TCXO, 1, 0, 0),
> +	F(29491200, P_GCC_GPLL0_OUT_EVEN, 1, 1536, 15625),
> +	F(32000000, P_GCC_GPLL0_OUT_EVEN, 1, 8, 75),
> +	F(48000000, P_GCC_GPLL0_OUT_EVEN, 1, 4, 25),
> +	F(64000000, P_GCC_GPLL0_OUT_EVEN, 1, 16, 75),
> +	F(75000000, P_GCC_GPLL0_OUT_EVEN, 4, 0, 0),
> +	F(80000000, P_GCC_GPLL0_OUT_EVEN, 1, 4, 15),
> +	F(96000000, P_GCC_GPLL0_OUT_EVEN, 1, 8, 25),
> +	F(100000000, P_GCC_GPLL0_OUT_MAIN, 6, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap0_s4_clk_src_init = {
> +	.name = "gcc_qupv3_wrap0_s4_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap0_s4_clk_src = {
> +	.cmd_rcgr = 0x42500,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s4_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap0_s4_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap0_s5_clk_src_init = {
> +	.name = "gcc_qupv3_wrap0_s5_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap0_s5_clk_src = {
> +	.cmd_rcgr = 0x42638,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s4_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap0_s5_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap0_s6_clk_src_init = {
> +	.name = "gcc_qupv3_wrap0_s6_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap0_s6_clk_src = {
> +	.cmd_rcgr = 0x42770,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s4_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap0_s6_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap0_s7_clk_src_init = {
> +	.name = "gcc_qupv3_wrap0_s7_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap0_s7_clk_src = {
> +	.cmd_rcgr = 0x428a8,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s4_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap0_s7_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap1_s0_clk_src_init = {
> +	.name = "gcc_qupv3_wrap1_s0_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap1_s0_clk_src = {
> +	.cmd_rcgr = 0x18010,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap1_s0_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap1_s1_clk_src_init = {
> +	.name = "gcc_qupv3_wrap1_s1_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap1_s1_clk_src = {
> +	.cmd_rcgr = 0x18148,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap1_s1_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap1_s2_clk_src_init = {
> +	.name = "gcc_qupv3_wrap1_s2_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap1_s2_clk_src = {
> +	.cmd_rcgr = 0x18288,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s2_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap1_s2_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap1_s3_clk_src_init = {
> +	.name = "gcc_qupv3_wrap1_s3_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap1_s3_clk_src = {
> +	.cmd_rcgr = 0x183c8,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s2_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap1_s3_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap1_s4_clk_src_init = {
> +	.name = "gcc_qupv3_wrap1_s4_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap1_s4_clk_src = {
> +	.cmd_rcgr = 0x18500,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s4_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap1_s4_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap1_s5_clk_src_init = {
> +	.name = "gcc_qupv3_wrap1_s5_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap1_s5_clk_src = {
> +	.cmd_rcgr = 0x18638,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s4_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap1_s5_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap1_s6_clk_src_init = {
> +	.name = "gcc_qupv3_wrap1_s6_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap1_s6_clk_src = {
> +	.cmd_rcgr = 0x18770,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s4_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap1_s6_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap1_s7_clk_src_init = {
> +	.name = "gcc_qupv3_wrap1_s7_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap1_s7_clk_src = {
> +	.cmd_rcgr = 0x188a8,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s4_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap1_s7_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap2_s0_clk_src_init = {
> +	.name = "gcc_qupv3_wrap2_s0_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap2_s0_clk_src = {
> +	.cmd_rcgr = 0x1e010,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap2_s0_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap2_s1_clk_src_init = {
> +	.name = "gcc_qupv3_wrap2_s1_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap2_s1_clk_src = {
> +	.cmd_rcgr = 0x1e148,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s0_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap2_s1_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap2_s2_clk_src_init = {
> +	.name = "gcc_qupv3_wrap2_s2_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap2_s2_clk_src = {
> +	.cmd_rcgr = 0x1e288,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s2_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap2_s2_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap2_s3_clk_src_init = {
> +	.name = "gcc_qupv3_wrap2_s3_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap2_s3_clk_src = {
> +	.cmd_rcgr = 0x1e3c8,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s2_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap2_s3_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap2_s4_clk_src_init = {
> +	.name = "gcc_qupv3_wrap2_s4_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap2_s4_clk_src = {
> +	.cmd_rcgr = 0x1e500,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s4_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap2_s4_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap2_s5_clk_src_init = {
> +	.name = "gcc_qupv3_wrap2_s5_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap2_s5_clk_src = {
> +	.cmd_rcgr = 0x1e638,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s4_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap2_s5_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap2_s6_clk_src_init = {
> +	.name = "gcc_qupv3_wrap2_s6_clk_src",
> +	.parent_data = gcc_parent_data_8,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_8),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap2_s6_clk_src = {
> +	.cmd_rcgr = 0x1e770,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_8,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s4_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap2_s6_clk_src_init,
> +};
> +
> +static struct clk_init_data gcc_qupv3_wrap2_s7_clk_src_init = {
> +	.name = "gcc_qupv3_wrap2_s7_clk_src",
> +	.parent_data = gcc_parent_data_0,
> +	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +	.flags = CLK_SET_RATE_PARENT,
> +	.ops = &clk_rcg2_ops,
> +};
> +
> +static struct clk_rcg2 gcc_qupv3_wrap2_s7_clk_src = {
> +	.cmd_rcgr = 0x1e8a8,
> +	.mnd_width = 16,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_qupv3_wrap0_s4_clk_src,
> +	.clkr.hw.init = &gcc_qupv3_wrap2_s7_clk_src_init,
> +};
> +
> +static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
> +	F(400000, P_BI_TCXO, 12, 1, 4),
> +	F(25000000, P_GCC_GPLL0_OUT_EVEN, 12, 0, 0),
> +	F(50000000, P_GCC_GPLL0_OUT_EVEN, 6, 0, 0),
> +	F(100000000, P_GCC_GPLL0_OUT_EVEN, 3, 0, 0),
> +	F(202000000, P_GCC_GPLL9_OUT_MAIN, 4, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
> +	.cmd_rcgr = 0x14018,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_9,
> +	.freq_tbl = ftbl_gcc_sdcc2_apps_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_sdcc2_apps_clk_src",
> +		.parent_data = gcc_parent_data_9,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_9),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_floor_ops,

diff sc8280xp..sc8380xp

Here you've used floor instead of shared ops, why is that ?

> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_sdcc4_apps_clk_src[] = {
> +	F(400000, P_BI_TCXO, 12, 1, 4),
> +	F(25000000, P_GCC_GPLL0_OUT_EVEN, 12, 0, 0),
> +	F(75000000, P_GCC_GPLL0_OUT_EVEN, 4, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_sdcc4_apps_clk_src = {
> +	.cmd_rcgr = 0x16018,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_sdcc4_apps_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_sdcc4_apps_clk_src",
> +		.parent_data = gcc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_floor_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_ufs_phy_axi_clk_src[] = {
> +	F(25000000, P_GCC_GPLL0_OUT_EVEN, 12, 0, 0),
> +	F(75000000, P_GCC_GPLL0_OUT_EVEN, 4, 0, 0),
> +	F(150000000, P_GCC_GPLL0_OUT_MAIN, 4, 0, 0),
> +	F(300000000, P_GCC_GPLL0_OUT_MAIN, 2, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_ufs_phy_axi_clk_src = {
> +	.cmd_rcgr = 0x77030,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_ufs_phy_axi_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_ufs_phy_axi_clk_src",
> +		.parent_data = gcc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_shared_ops,

This looks correct since you want to persist this clock in suspend 
presumably.

> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_ufs_phy_ice_core_clk_src[] = {
> +	F(100000000, P_GCC_GPLL0_OUT_EVEN, 3, 0, 0),
> +	F(201500000, P_GCC_GPLL4_OUT_MAIN, 4, 0, 0),
> +	F(403000000, P_GCC_GPLL4_OUT_MAIN, 2, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_ufs_phy_ice_core_clk_src = {
> +	.cmd_rcgr = 0x77080,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_7,
> +	.freq_tbl = ftbl_gcc_ufs_phy_ice_core_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_ufs_phy_ice_core_clk_src",
> +		.parent_data = gcc_parent_data_7,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_7),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 gcc_ufs_phy_phy_aux_clk_src = {
> +	.cmd_rcgr = 0x770b4,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_3,
> +	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_ufs_phy_phy_aux_clk_src",
> +		.parent_data = gcc_parent_data_3,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,

but then why not ufs_phy_ice_core and ufs_phy_phy_aux_clk

> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_ufs_phy_unipro_core_clk_src[] = {
> +	F(75000000, P_GCC_GPLL0_OUT_EVEN, 4, 0, 0),
> +	F(150000000, P_GCC_GPLL0_OUT_MAIN, 4, 0, 0),
> +	F(300000000, P_GCC_GPLL0_OUT_MAIN, 2, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_ufs_phy_unipro_core_clk_src = {
> +	.cmd_rcgr = 0x77098,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_ufs_phy_unipro_core_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_ufs_phy_unipro_core_clk_src",
> +		.parent_data = gcc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_shared_ops,

but back to the parked clock here.

Shoudln't all of the UFS related clocks park in suspend ?

> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_usb20_master_clk_src[] = {
> +	F(60000000, P_GCC_GPLL0_OUT_MAIN, 10, 0, 0),
> +	F(120000000, P_GCC_GPLL0_OUT_MAIN, 5, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_usb20_master_clk_src = {
> +	.cmd_rcgr = 0x2902c,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_usb20_master_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_usb20_master_clk_src",
> +		.parent_data = gcc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 gcc_usb20_mock_utmi_clk_src = {
> +	.cmd_rcgr = 0x29158,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_usb20_mock_utmi_clk_src",
> +		.parent_data = gcc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static const struct freq_tbl ftbl_gcc_usb30_mp_master_clk_src[] = {
> +	F(66666667, P_GCC_GPLL0_OUT_EVEN, 4.5, 0, 0),
> +	F(133333333, P_GCC_GPLL0_OUT_MAIN, 4.5, 0, 0),
> +	F(200000000, P_GCC_GPLL0_OUT_MAIN, 3, 0, 0),
> +	F(240000000, P_GCC_GPLL0_OUT_MAIN, 2.5, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 gcc_usb30_mp_master_clk_src = {
> +	.cmd_rcgr = 0x1702c,
> +	.mnd_width = 8,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_usb30_mp_master_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_usb30_mp_master_clk_src",
> +		.parent_data = gcc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_shared_ops,
> +	},
> +};
> +
> +static struct clk_rcg2 gcc_usb30_mp_mock_utmi_clk_src = {
> +	.cmd_rcgr = 0x17158,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_usb30_mp_mock_utmi_clk_src",
> +		.parent_data = gcc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +		.flags = CLK_SET_RATE_PARENT,
> +		.ops = &clk_rcg2_ops,

This is another discontinuinty with sc8280xp.

Could you have a look through the sc8280xp gcc and do an aduit for 
clk_rcg2_shared_ops as against sc8380xp ?

---
bod
