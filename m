Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3754789514
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 11:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjHZJWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 05:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjHZJWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 05:22:23 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56C9173F
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 02:22:20 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52a4737a08fso2240860a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 02:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693041739; x=1693646539;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ujQSKV2q1WTc1rtA/ac/WYkEvifC5+suFNij4ldFKKQ=;
        b=eQNFBrypsepUIV9QHa2uj5K66l1sj6M5lxJhecDY3b1kJz7luFf3FVjMq8k4/KRfKQ
         2SRhJHfYNHvlCkLVzFpDgOL6G4XxwOorTuNu96GZYTVWE4sstM89kP/0mEDNyp4PYCIR
         uB5qpFO67aWUyf+1A1K/zIk2Q48To9HJPxbegXUJWJazC3erskq1Q6aohH6i23rzbghu
         1nAZLYJ3S/lQEBSDtXKMNuvBfv/TmYvZLHeTfhyohVQaqjVIqHOolZFhy5THTan9ME+c
         xs+LAsJBozJIQprkay6GqXlrElW9/UzsZjtG6Dm3jnp9MwR41WwHaazAZSSA9j7rAtfv
         n6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693041739; x=1693646539;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ujQSKV2q1WTc1rtA/ac/WYkEvifC5+suFNij4ldFKKQ=;
        b=CTZh16PFpINRtwZUu4Adl7GqIWOL7qGcDIQPqi+pPO3mqB8ak+8c+yK8ZpmFmiYaew
         jkaapN/uFgLM7HAntlAdS8ONpyimCMWw2IppJzNSIn+lLSWrZ8y7r/r+GLQcf6ylKaPs
         yAEBM07rx8BxNPtu/IzgpNlitBegxSw6lCnC2Por8Jl4MKm+Tkm7QNDQuD/OKrOwCAJm
         KkQXOienf8nyLK7A1uWCYjAMYYlARMArbGUYij85nk4/6UUpQkjgAtl48rw8VYpBz/Kq
         UAq2l0obSaX76wH3ukUu7Uau8clO85lBAIRaSFg18tkCspJgpevh5f/amSPPf19ykAqf
         OpHg==
X-Gm-Message-State: AOJu0Yz4ynUOe7Tsm5Lg/3+MSDlutT8rcXlBaL6Uaob6v656j60waKhQ
        c/j0eMVzth2uOW7UiVCLwUYSdA==
X-Google-Smtp-Source: AGHT+IEaSCxBOdkRZUukHKRgvjUCj61hoQM5BErksYdtKO/OWio+dLUoa3lHiOPhM6/l6+4Hz8fjvw==
X-Received: by 2002:aa7:ccc9:0:b0:525:7cd4:34da with SMTP id y9-20020aa7ccc9000000b005257cd434damr14932807edt.40.1693041739354;
        Sat, 26 Aug 2023 02:22:19 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id d2-20020a056402078200b005232ea6a330sm1921486edy.2.2023.08.26.02.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 02:22:18 -0700 (PDT)
Message-ID: <a9d52cd9-845e-ff88-3c26-858cb6604e43@linaro.org>
Date:   Sat, 26 Aug 2023 11:22:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/3] clk: qcom: Add SM6115 LPASSCC
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230825-topic-6115_lpasscc-v1-0-d4857be298e3@linaro.org>
 <20230825-topic-6115_lpasscc-v1-3-d4857be298e3@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230825-topic-6115_lpasscc-v1-3-d4857be298e3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2023 20:13, Konrad Dybcio wrote:
> SM6115 (and its derivatives or similar SoCs) have a LPASS clock
> controller block which provides audio-related resets.
> 
> Add the required code to support them.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/clk/qcom/Kconfig          |  9 +++++
>  drivers/clk/qcom/Makefile         |  1 +
>  drivers/clk/qcom/lpasscc-sm6115.c | 84 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 94 insertions(+)
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index bd9bfb11b328..df9cf112e4b6 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -1001,6 +1001,15 @@ config SM_GPUCC_8550
>  	  Say Y if you want to support graphics controller devices and
>  	  functionality such as 3D graphics.
>  
> +config SM_LPASSCC_6115
> +	tristate "SM6115 Low Power Audio Subsystem (LPASS) Clock Controller"
> +	depends on ARM64 || COMPILE_TEST
> +	select SM_GCC_6115
> +	help
> +	  Support for the LPASS clock controller on SM6115 devices.
> +	  Say Y if you want to toggle LPASS-adjacent resets within
> +	  this clock controller to reset the LPASS subsystem.
> +
>  config SM_TCSRCC_8550
>  	tristate "SM8550 TCSR Clock Controller"
>  	depends on ARM64 || COMPILE_TEST
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 4790c8cca426..61e3c72fe954 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -128,6 +128,7 @@ obj-$(CONFIG_SM_GPUCC_8250) += gpucc-sm8250.o
>  obj-$(CONFIG_SM_GPUCC_8350) += gpucc-sm8350.o
>  obj-$(CONFIG_SM_GPUCC_8450) += gpucc-sm8450.o
>  obj-$(CONFIG_SM_GPUCC_8550) += gpucc-sm8550.o
> +obj-$(CONFIG_SM_LPASSCC_6115) += lpasscc-sm6115.o
>  obj-$(CONFIG_SM_TCSRCC_8550) += tcsrcc-sm8550.o
>  obj-$(CONFIG_SM_VIDEOCC_8150) += videocc-sm8150.o
>  obj-$(CONFIG_SM_VIDEOCC_8250) += videocc-sm8250.o
> diff --git a/drivers/clk/qcom/lpasscc-sm6115.c b/drivers/clk/qcom/lpasscc-sm6115.c
> new file mode 100644
> index 000000000000..6aa19e16c53b
> --- /dev/null
> +++ b/drivers/clk/qcom/lpasscc-sm6115.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022, 2023 Linaro Limited
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,sm6115-lpasscc.h>
> +
> +#include "common.h"
> +#include "reset.h"
> +
> +static const struct qcom_reset_map lpass_audiocc_sm6115_resets[] = {
> +	[LPASS_AUDIO_SWR_RX_CGCR] =  { .reg = 0x98, .bit = 1, .udelay = 500 },
> +};
> +
> +static struct regmap_config lpass_audiocc_sm6115_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.name = "lpass-audio-csr",
> +	.max_register = 0x1000,
> +};
> +
> +static const struct qcom_cc_desc lpass_audiocc_sm6115_reset_desc = {
> +	.config = &lpass_audiocc_sm6115_regmap_config,
> +	.resets = lpass_audiocc_sm6115_resets,
> +	.num_resets = ARRAY_SIZE(lpass_audiocc_sm6115_resets),
> +};
> +
> +static const struct qcom_reset_map lpasscc_sm6115_resets[] = {
> +	[LPASS_SWR_TX_CONFIG_CGCR] = { .reg = 0x100, .bit = 1, .udelay = 500 },
> +};
> +
> +static struct regmap_config lpasscc_sm6115_regmap_config = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.name = "lpass-tcsr",
> +	.max_register = 0x1000,
> +};
> +
> +static const struct qcom_cc_desc lpasscc_sm6115_reset_desc = {
> +	.config = &lpasscc_sm6115_regmap_config,
> +	.resets = lpasscc_sm6115_resets,
> +	.num_resets = ARRAY_SIZE(lpasscc_sm6115_resets),
> +};
> +
> +static const struct of_device_id lpasscc_sm6115_match_table[] = {
> +	{
> +		.compatible = "qcom,sm6115-lpassaudiocc",
> +		.data = &lpass_audiocc_sm6115_reset_desc,
> +	}, {
> +		.compatible = "qcom,sm6115-lpasscc",
> +		.data = &lpasscc_sm6115_reset_desc,
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, lpasscc_sm6115_match_table);

Everything here is almost the same as sc8280xp one, so this should be
added to sc8280xp. You cut some boilerplate and additional driver.

Best regards,
Krzysztof

