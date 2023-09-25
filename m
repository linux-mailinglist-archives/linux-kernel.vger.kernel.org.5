Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4024E7AD3C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbjIYIvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjIYIvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:51:40 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FD2DF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:51:32 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5044dd5b561so4073024e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695631891; x=1696236691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I76aapIgIVc4qPta64xuBqsqk0Sj1BIrc3XVjBiRxTE=;
        b=GUsbRxK0GI2qWy9OwCgmghPEDcVq6K1wQq6T6tZVRVqSuB6QpuEyvQbiVpmcaHy8ct
         DWMY0s6LmSJzb58DaqAj80YK2yBnuE5nEcAvor9d0lWJrp+0FEy64INYh6Og2v5K0cBQ
         USF7j8f8FQtHMMUIru5QGLI4yVxcPaqAYr4ZP28kGJKNOWJJyG0c7JjoTiX3b0ZsEEVQ
         2RnHxT+C35RnVrovtgAdu3WcoAXm1Z1Nc4qg7LrY0vO8F5kf1KrxtYgHMPcCppU1B+Se
         mbvSSQEyLa8Tl2RWmIVXGkkhFP9mem83j+v2R+Ifkg7wDMjYFmQ9pdmuLnefcT/hDsOz
         kO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695631891; x=1696236691;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I76aapIgIVc4qPta64xuBqsqk0Sj1BIrc3XVjBiRxTE=;
        b=gRXe7i6zRsKE968aPmCiDkBeK5ZQKmw5tboUFeQ5r70VvpUWjiakEA7uQx/38Snwmu
         xrXfcxetNzULdjNTetZn7+NSIwjmAu2RmYXbnI4bwrYmze9pgF/UxHmCDVJ5pDgsRrCJ
         Pcv5mNBXOgBaN3/tOhhpW9s5tWXcJUilsKugq1I4mt56B0iEZu4KniPnuZl3mlNekKbK
         zbkAUJk1pzQlvu7QwaO6H6wg4iFDAx5FNauWUK8H7zELBChvWpRgBrvuyQvw3X9wo9Z0
         R15SiwyHm0D5l6WqvJqLJPdgKJy191cQJlxDvWnRXrfDoqyIa9MSyBQNRF+Wb+qQOlkb
         uM0Q==
X-Gm-Message-State: AOJu0Yx7FQcuuU4CHicZWvv/Kr59uo5X0zRmq0IZS3uW68qEgvvth3TD
        OTNsrCARxk7VxSQ4hQoBy0Ohag==
X-Google-Smtp-Source: AGHT+IHh0oKfVPyzhpGT3Ziiot7eAhVSnmmFfexkrn/80gAwc67Wx0fZ14VRfctlOLgzAbaHj7Kxmg==
X-Received: by 2002:a05:6512:214d:b0:503:3913:c2c9 with SMTP id s13-20020a056512214d00b005033913c2c9mr4484268lfr.40.1695631890372;
        Mon, 25 Sep 2023 01:51:30 -0700 (PDT)
Received: from [192.168.101.165] (178235177023.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.23])
        by smtp.gmail.com with ESMTPSA id v4-20020a056402174400b0053424352ab3sm663625edx.19.2023.09.25.01.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 01:51:30 -0700 (PDT)
Message-ID: <2678d8a5-4101-4fc3-9f9d-cbe616eee131@linaro.org>
Date:   Mon, 25 Sep 2023 10:51:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] clk: qcom: camcc-sc8280xp: Add sc8280xp CAMCC
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        andersson@kernel.org, agross@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230923150045.1068556-1-bryan.odonoghue@linaro.org>
 <20230923150045.1068556-4-bryan.odonoghue@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230923150045.1068556-4-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.09.2023 17:00, Bryan O'Donoghue wrote:
> Add the sc8280xp CAMCC driver which follows the sdm845 CAMCC lineage
> with additional CCI and IFE blocks and more granular clock parentage.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/clk/qcom/Kconfig          |    9 +
>  drivers/clk/qcom/Makefile         |    1 +
>  drivers/clk/qcom/camcc-sc8280xp.c | 3051 +++++++++++++++++++++++++++++
>  3 files changed, 3061 insertions(+)
>  create mode 100644 drivers/clk/qcom/camcc-sc8280xp.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 4b72e98eaa70..5ce6d888aba0 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -426,6 +426,15 @@ config SC_CAMCC_7280
>  	  Say Y if you want to support camera devices and functionality such as
>  	  capturing pictures.
>  
> +config SC_CAMCC_8280XP
> +	tristate "SC8280XP Camera Clock Controller"
> +	select SC_GCC_8280XP
> +	help
> +	  Support for the camera clock controller on Qualcomm Technologies, Inc
> +	  SC8280XP devices.
> +	  Say Y if you want to support camera devices and functionality such as
> +	  capturing pictures.
> +
>  config SC_DISPCC_7180
>  	tristate "SC7180 Display Clock Controller"
>  	depends on ARM64 || COMPILE_TEST
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index a301b08dba05..8f66cefa9e57 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -68,6 +68,7 @@ obj-$(CONFIG_QCS_TURING_404) += turingcc-qcs404.o
>  obj-$(CONFIG_QDU_GCC_1000) += gcc-qdu1000.o
>  obj-$(CONFIG_SC_CAMCC_7180) += camcc-sc7180.o
>  obj-$(CONFIG_SC_CAMCC_7280) += camcc-sc7280.o
> +obj-$(CONFIG_SC_CAMCC_8280XP) += camcc-sc8280xp.o
>  obj-$(CONFIG_SC_DISPCC_7180) += dispcc-sc7180.o
>  obj-$(CONFIG_SC_DISPCC_7280) += dispcc-sc7280.o
>  obj-$(CONFIG_SC_DISPCC_8280XP) += dispcc-sc8280xp.o
> diff --git a/drivers/clk/qcom/camcc-sc8280xp.c b/drivers/clk/qcom/camcc-sc8280xp.c
> new file mode 100644
> index 000000000000..fbb3fa39862c
> --- /dev/null
> +++ b/drivers/clk/qcom/camcc-sc8280xp.c
> @@ -0,0 +1,3051 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023, Linaro Ltd.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/pm_clock.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/pm_runtime.h>
> +
> +#include <dt-bindings/clock/qcom,camcc-sc8280xp.h>
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
> +	DT_BI_TCXO,
> +	DT_BI_TCXO_AO,
> +	DT_SLEEP_CLK,
> +};
This enum here is so that

[...]

> +static struct clk_alpha_pll cam_cc_pll0 = {
> +	.offset = 0x0,
> +	.vco_table = lucid_vco,
> +	.num_vco = ARRAY_SIZE(lucid_vco),
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> +	.clkr = {
> +		.hw.init = &(struct clk_init_data){
> +			.name = "cam_cc_pll0",
> +			.parent_data = &(const struct clk_parent_data){
> +				.fw_name = "bi_tcxo", .name = "bi_tcxo",
you can use .index = <some enum member> here


[...]

> +
> +static const struct clk_parent_data cam_cc_parent_data_0[] = {
> +	{ .fw_name = "bi_tcxo", .name = "bi_tcxo" },
also in these arrays

[...]

> +static struct gdsc bps_gdsc = {
> +	.gdscr = 0x7004,
> +	.pd = {
> +		.name = "bps_gdsc",
> +	},
> +	.flags = HW_CTRL | RETAIN_FF_ENABLE,
HW_CTRL means "hardware controlled mode is always on", not
"hardware controlled mode is available". Is that what you want?

Also, does this clock controller not take GCC_CAMERA_AHB_CLK as
input?

Konrad
