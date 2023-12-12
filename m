Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9135580E72B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346225AbjLLJRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbjLLJQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:16:58 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19EBD2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:17:02 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5e1a2253045so8807357b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702372622; x=1702977422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p38ZcnMoGySoA9RmMEhaNrnZZBwNT7TlIqnl8C0Lsh4=;
        b=cLHbrcnTccbzLpgPFtaMkhk8CDo/sdm0AY57ytdW5qVS+9wKPREjSYF/lO7GGtd/QQ
         C3RRLuaaqVKIVQPGzRggNvWHJd0kDQV8GZZlODhpr26LhWdiqRbM2vXgBtgb5lHENC56
         1w6+yEAYfy/lXo9Br2XO9MnYqJ1UOPAU0RPOBaZaBZjLY4Xk3aA8rSH4J3StikVdVTqE
         Dg2TQpNkfdMev4GGOEfw7vSuzAOaZRG3v0nLDKeiZ4M+KrbslZJhs0x7RL9sYivpFQD4
         4mbKjLMnGtWZDIqLxMqbIgC1eicDHEC+8Vfsc2+TkajwK6jgetQZg9Y1hNA3jyYnZXds
         rmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702372622; x=1702977422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p38ZcnMoGySoA9RmMEhaNrnZZBwNT7TlIqnl8C0Lsh4=;
        b=NMJBt0JH+ID1Y1Qarm2kJQzJG+I6/PJaYLI85ovPlSkAofjrr/k7tvBFLT676oxvMt
         wziLBEgc5Ml5NofWE3znyOpU6v7khjAP3bnaH9psFFjGvh2CFqR+6PS5GrgsMpFBZTst
         xEBX4F4xe7p51d6LiIC8MrU7QfeBm2h0v6r3VN5t3yY2u6CdIvFJPcMrL78j2S2Ar0mO
         6xr8i2FDEFNaWalbUL0MI09KzNG2rXff98WzEbRmOFTRbYxPU9D9fUg2WE02B6i0xB+c
         O0BndT8uCWUHeHnPEsdVyO4UYsCpbVYhusiOVxBs5Zvf9kr7wmmCRkH/zsqJ0tXtziiT
         xIIA==
X-Gm-Message-State: AOJu0YzW4goRwb9TibKbLLFsUZhxyUtSIL7brtYWaHz7iQ/cuY7D4nDC
        lkJF0jhCt3pdv40OdAPOejk7WXlNYnVkyVkvajaR7Q==
X-Google-Smtp-Source: AGHT+IGfK6M82t1BPlvqg9TxCM/9qRj45o0tTiIJ27mtS0gYiaU1mn1aQ6NyYyJKbJ+DgcTtvVTbDhuMjYDaazDF4Ss=
X-Received: by 2002:a0d:e905:0:b0:5d7:1941:ac7 with SMTP id
 s5-20020a0de905000000b005d719410ac7mr4662948ywe.98.1702372621940; Tue, 12 Dec
 2023 01:17:01 -0800 (PST)
MIME-Version: 1.0
References: <20231212-x1e80100-clock-controllers-v1-0-0de1af44dcb3@linaro.org> <20231212-x1e80100-clock-controllers-v1-10-0de1af44dcb3@linaro.org>
In-Reply-To: <20231212-x1e80100-clock-controllers-v1-10-0de1af44dcb3@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 12 Dec 2023 11:16:50 +0200
Message-ID: <CAA8EJpriXaymPkbkr_8Z76SDqZFrNAUOH_ggtpxSE2VA=0gcqA@mail.gmail.com>
Subject: Re: [PATCH 10/10] clk: qcom: Add camcc clock driver for x1e80100
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 at 00:46, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> From: Rajendra Nayak <quic_rjendra@quicinc.com>
>
> Add the camcc clock driver for x1e80100
>
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/clk/qcom/Kconfig          |    8 +
>  drivers/clk/qcom/Makefile         |    1 +
>  drivers/clk/qcom/camcc-x1e80100.c | 2489 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 2498 insertions(+)
>
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 0633728c870c..4580edbd13ea 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -20,6 +20,14 @@ menuconfig COMMON_CLK_QCOM
>
>  if COMMON_CLK_QCOM
>
> +config CLK_X1E80100_CAMCC
> +       tristate "X1E80100 Camera Clock Controller"
> +       depends on ARM64 || COMPILE_TEST
> +       select CLK_X1E80100_GCC
> +       help
> +         Support for the camera clock controller on X1E80100 devices.
> +         Say Y if you want to support camera devices and camera functionality.
> +
>  config CLK_X1E80100_DISPCC
>         tristate "X1E80100 Display Clock Controller"
>         depends on ARM64 || COMPILE_TEST
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 750b084553c6..1da65ca78e24 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -21,6 +21,7 @@ clk-qcom-$(CONFIG_QCOM_GDSC) += gdsc.o
>  obj-$(CONFIG_APQ_GCC_8084) += gcc-apq8084.o
>  obj-$(CONFIG_APQ_MMCC_8084) += mmcc-apq8084.o
>  obj-$(CONFIG_CLK_GFM_LPASS_SM8250) += lpass-gfm-sm8250.o
> +obj-$(CONFIG_CLK_X1E80100_CAMCC) += camcc-x1e80100.o
>  obj-$(CONFIG_CLK_X1E80100_DISPCC) += dispcc-x1e80100.o
>  obj-$(CONFIG_CLK_X1E80100_GCC) += gcc-x1e80100.o
>  obj-$(CONFIG_CLK_X1E80100_GPUCC) += gpucc-x1e80100.o
> diff --git a/drivers/clk/qcom/camcc-x1e80100.c b/drivers/clk/qcom/camcc-x1e80100.c
> new file mode 100644
> index 000000000000..50dc578692a1
> --- /dev/null
> +++ b/drivers/clk/qcom/camcc-x1e80100.c
> @@ -0,0 +1,2489 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,x1e80100-camcc.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "common.h"
> +#include "gdsc.h"
> +#include "reset.h"
> +
> +enum {
> +       DT_BI_TCXO,
> +       DT_BI_TCXO_AO,
> +       DT_SLEEP_CLK,
> +};
> +
> +enum {
> +       P_BI_TCXO,
> +       P_CAM_CC_PLL0_OUT_EVEN,
> +       P_CAM_CC_PLL0_OUT_MAIN,
> +       P_CAM_CC_PLL0_OUT_ODD,
> +       P_CAM_CC_PLL1_OUT_EVEN,
> +       P_CAM_CC_PLL2_OUT_EVEN,
> +       P_CAM_CC_PLL2_OUT_MAIN,
> +       P_CAM_CC_PLL3_OUT_EVEN,
> +       P_CAM_CC_PLL4_OUT_EVEN,
> +       P_CAM_CC_PLL6_OUT_EVEN,
> +       P_CAM_CC_PLL8_OUT_EVEN,
> +       P_SLEEP_CLK,
> +};
> +
> +static const struct pll_vco lucid_ole_vco[] = {
> +       { 249600000, 2300000000, 0 },
> +};
> +
> +static const struct pll_vco rivian_ole_vco[] = {
> +       { 777000000, 1285000000, 0 },
> +};
> +
> +static const struct alpha_pll_config cam_cc_pll0_config = {
> +       .l = 0x3E,

Lowercase hex, please.
Other than that LGTM.

> +       .alpha = 0x8000,
> +       .config_ctl_val = 0x20485699,
> +       .config_ctl_hi_val = 0x00182261,
> +       .config_ctl_hi1_val = 0x82AA299C,
> +       .test_ctl_val = 0x00000000,
> +       .test_ctl_hi_val = 0x00000003,
> +       .test_ctl_hi1_val = 0x00009000,
> +       .test_ctl_hi2_val = 0x00000034,
> +       .user_ctl_val = 0x00008400,
> +       .user_ctl_hi_val = 0x00000005,
> +};



-- 
With best wishes
Dmitry
