Return-Path: <linux-kernel+bounces-147430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A798A73F2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06A4AB219D7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DE5137917;
	Tue, 16 Apr 2024 18:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fOkn/iN4"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87C21C06
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293779; cv=none; b=KlVSlIiVy2DeGLFy2i0JSqxPrRM73K2bGR4HdGvAIFFKyOcnjPVtdwUuNMYADS+X12ckqU9413vjhvkKSZbIWhiKuwANQL7JiznxERajd9/9ZASI0kz7Uu0DrqPy/7sgORYW1XWiwi5Pf6dseSWtQDDPAlMHG+c0denebjbuejs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293779; c=relaxed/simple;
	bh=gcTRf65a+ftJnH8+Aa+F0CBgeHDfFdCEJgFqbkaBRy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvLnDi3r2oYXScJ20qnSFlGbTkNZQxtgB7Nh0rGLw7ONZVgan6wla6W8+ke/1SGrQEWQJVZcJI8Zu2BvR/1mVpY0qV9/BreJW9YOygHitWqwPJtL7vJd9bZezjbHLAPtaCoHR0sqirsk8h4HpKZFsDRH+dJD4iXBfRyex1AvIEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fOkn/iN4; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso4799314276.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713293776; x=1713898576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m3jRsJcFFlAEIpn9uxJ8q/UOrjJ8uD5kt4UN94jZCSY=;
        b=fOkn/iN4jMbcWz9Mo2oBsXlRkpo2SkLqXMYzNDa0UZVWn/SeX/ypoJi5BdsfHjPk2p
         wBusiqYME80vnVBoeaIk3CfYI2Gs/ky1K8p78LxhtMZeMqFx3NGJa1oKXqExPmiclapR
         BLNBkPZ/G/1r2t+X3wmWHhYn+GBlOU4j6weDf07h5k/CIrRTFkNXwxH9CCeSiX5oxim3
         LGp2PmH4ElcyqrMaHC1fgxwnNaPjxnEbowsaBVLMAKUQR44/mRIWNFiYuRj6BAKib3NF
         k3JnZ54cxM1EHi9qwRyT32M5z1t0G2C+HPpsJuV3NlguV6l0jqMh2lesEgp1jy21OiQg
         EDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293776; x=1713898576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3jRsJcFFlAEIpn9uxJ8q/UOrjJ8uD5kt4UN94jZCSY=;
        b=Un/OoR9mbqawciuk8U2sIXHzeNszrkPpWvlWK9B9ZXKNaPXm8eQEbxcuc3F9bnl8dJ
         KuDYCdTfO2+IyZMwYd3TcfMGdOGNMsimpG1lbM2VO/wqQWrej598n9Zjt3fRD+RwmqFz
         NBnFFDfH/MS6AyET6X74od4DY1XONI1gcwmpb5y6l3t4nOi0VTegM/WdRNH/t9imC5C4
         euuG48ta3rBdosY8dLtb9FDcE2aobGfHHDk39VPo8cjoSjV7t9wSksBtYmDdP0lj23lo
         qT+WAxIl7ixPXDyd1eQr9MiDX/Mw8l/B3AgwEKm6czwDHRyON90kKxSTFZF4Kd3olYl7
         7d3g==
X-Forwarded-Encrypted: i=1; AJvYcCWmDbvTNFfmX//OWL+EwLRbovyRXn9pQVuBx2ugGGm45gJn0CXEOtnbvcpvrt1BH28j/ZmvAS0ydP30lbH8zr/zc/AIwE534j7KbszL
X-Gm-Message-State: AOJu0YxlSK1KYUYPiLsgbfhl68DSMOcOIuZiKaJ3hTnsGaptA6S7+JfV
	CzwuKs9hUy7ct9EpuWZNbpp37ViPgUVMt9w+pJsgGAZ5d1KivA/TfEqFCGFbxYPNwJRwT/96smp
	v01ux5nKczzJecGue7oH21AQLDdyAveHUBuuehw==
X-Google-Smtp-Source: AGHT+IFxPCU3aUsqiq75v8UkxRyLa6/K+D4YbVrUrwZxzduOFhICd6UrgSRPeNifliYxS3rzszb0p2HGn9HqqJ1UIJI=
X-Received: by 2002:a25:6890:0:b0:ddd:7459:c970 with SMTP id
 d138-20020a256890000000b00ddd7459c970mr11800947ybc.63.1713293775884; Tue, 16
 Apr 2024 11:56:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416182005.75422-1-quic_ajipan@quicinc.com> <20240416182005.75422-4-quic_ajipan@quicinc.com>
In-Reply-To: <20240416182005.75422-4-quic_ajipan@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 16 Apr 2024 21:56:05 +0300
Message-ID: <CAA8EJprnMVSoOt7XtwcVXjFGzkPhompcfz3Zw4Hoxhk5-g5W0g@mail.gmail.com>
Subject: Re: [PATCH V2 3/8] clk: qcom: Add DISPCC driver support for SM4450
To: Ajit Pandey <quic_ajipan@quicinc.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Apr 2024 at 21:22, Ajit Pandey <quic_ajipan@quicinc.com> wrote:
>
> Add Display Clock Controller (DISPCC) support for SM4450 platform.
>
> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
> ---
>  drivers/clk/qcom/Kconfig         |  10 +
>  drivers/clk/qcom/Makefile        |   1 +
>  drivers/clk/qcom/dispcc-sm4450.c | 781 +++++++++++++++++++++++++++++++
>  3 files changed, 792 insertions(+)
>  create mode 100644 drivers/clk/qcom/dispcc-sm4450.c
>
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 8ab08e7b5b6c..9fce64ced353 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -826,6 +826,16 @@ config SM_CAMCC_8550
>           Support for the camera clock controller on SM8550 devices.
>           Say Y if you want to support camera devices and camera functionality.
>
> +config SM_DISPCC_4450
> +       tristate "SM4450 Display Clock Controller"
> +       depends on ARM64 || COMPILE_TEST
> +       depends on SM_GCC_4450
> +       help
> +         Support for the display clock controller on Qualcomm Technologies, Inc
> +         SM4450 devices.
> +         Say Y if you want to support display devices and functionality such as
> +         splash screen
> +
>  config SM_DISPCC_6115
>         tristate "SM6115 Display Clock Controller"
>         depends on ARM64 || COMPILE_TEST
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index dec5b6db6860..68d1c5192c86 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -109,6 +109,7 @@ obj-$(CONFIG_SM_CAMCC_6350) += camcc-sm6350.o
>  obj-$(CONFIG_SM_CAMCC_8250) += camcc-sm8250.o
>  obj-$(CONFIG_SM_CAMCC_8450) += camcc-sm8450.o
>  obj-$(CONFIG_SM_CAMCC_8550) += camcc-sm8550.o
> +obj-$(CONFIG_SM_DISPCC_4450) += dispcc-sm4450.o
>  obj-$(CONFIG_SM_DISPCC_6115) += dispcc-sm6115.o
>  obj-$(CONFIG_SM_DISPCC_6125) += dispcc-sm6125.o
>  obj-$(CONFIG_SM_DISPCC_6350) += dispcc-sm6350.o
> diff --git a/drivers/clk/qcom/dispcc-sm4450.c b/drivers/clk/qcom/dispcc-sm4450.c
> new file mode 100644
> index 000000000000..7668b4bafae5
> --- /dev/null
> +++ b/drivers/clk/qcom/dispcc-sm4450.c
> @@ -0,0 +1,781 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +#include <linux/platform_device.h>
> +
> +#include <dt-bindings/clock/qcom,sm4450-dispcc.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-pll.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "clk-regmap-divider.h"
> +#include "common.h"
> +#include "gdsc.h"
> +#include "reset.h"
> +
> +enum {
> +       DT_BI_TCXO,
> +       DT_BI_TCXO_AO,
> +       DT_AHB_CLK,
> +       DT_SLEEP_CLK,
> +
> +       DT_DSI0_PHY_PLL_OUT_BYTECLK,
> +       DT_DSI0_PHY_PLL_OUT_DSICLK,
> +};
> +
> +enum {
> +       P_BI_TCXO,
> +       P_DISP_CC_PLL0_OUT_MAIN,
> +       P_DISP_CC_PLL1_OUT_EVEN,
> +       P_DISP_CC_PLL1_OUT_MAIN,
> +       P_DSI0_PHY_PLL_OUT_BYTECLK,
> +       P_DSI0_PHY_PLL_OUT_DSICLK,
> +       P_SLEEP_CLK,
> +};
> +
> +static const struct pll_vco lucid_evo_vco[] = {
> +       { 249600000, 2020000000, 0 },
> +};
> +
> +/* 600.0 MHz Configuration */
> +static const struct alpha_pll_config disp_cc_pll0_config = {
> +       .l = 0x1f,
> +       .alpha = 0x4000,
> +       .config_ctl_val = 0x20485699,
> +       .config_ctl_hi_val = 0x00182261,
> +       .config_ctl_hi1_val = 0x32aa299c,
> +       .user_ctl_val = 0x00000000,
> +       .user_ctl_hi_val = 0x00000805,
> +};
> +
> +static struct clk_alpha_pll disp_cc_pll0 = {
> +       .offset = 0x0,
> +       .vco_table = lucid_evo_vco,
> +       .num_vco = ARRAY_SIZE(lucid_evo_vco),
> +       .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
> +       .clkr = {
> +               .hw.init = &(const struct clk_init_data) {
> +                       .name = "disp_cc_pll0",
> +                       .parent_data = &(const struct clk_parent_data) {
> +                               .index = DT_BI_TCXO,
> +                       },
> +                       .num_parents = 1,
> +                       .ops = &clk_alpha_pll_lucid_evo_ops,
> +               },
> +       },
> +};
> +
> +/* 600.0 MHz Configuration */
> +static const struct alpha_pll_config disp_cc_pll1_config = {

Can disp_cc_pll0_config be used here?

> +       .l = 0x1f,
> +       .alpha = 0x4000,
> +       .config_ctl_val = 0x20485699,
> +       .config_ctl_hi_val = 0x00182261,
> +       .config_ctl_hi1_val = 0x32aa299c,
> +       .user_ctl_val = 0x00000000,
> +       .user_ctl_hi_val = 0x00000805,
> +};

With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

