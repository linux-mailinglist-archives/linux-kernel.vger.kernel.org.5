Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE797FE19D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbjK2VOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjK2VOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:14:47 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22026D7F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:14:53 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b472f98b1so1568735e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701292491; x=1701897291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yrXYY2lU23zuZlfwWGvLQFyDFXfNY5T1gubM0hMOkP0=;
        b=kV/3nZrtIXim7T8H+5rv62fUMv1rQTPhLBD/3Isc8acCcwl7tAN/IbGSfQpCRaeIG9
         wMvhIYte02MMdFwstAlCzwAzKRIUtl7BqxUfJrhcBdQveNP2/JxEyBWhtAsZ/rM+ZlCi
         bPfcO6nNYbTr1V+KhLgkj9UbUkThs/14Ei3TqPmcpzfAiBpW9RUahGujFpobOCX3+Rzb
         JKbbJMA/Dmj1IGa5A797D9frd+gF0KRjEuqatl2pyHxjhExftdi+PfaSxVYFrHXVzlZi
         A+IDuIMPTZXFLckSH9SLQ5v0HosJGspOsXoZKHtybLmxPPxX/7Qn5EU9WfrkASSecPo/
         jw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701292491; x=1701897291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrXYY2lU23zuZlfwWGvLQFyDFXfNY5T1gubM0hMOkP0=;
        b=i4QncDoVaoskkU7D9YbhBbt4rPaKcPJncYlFbI9NTCyxrMD1JnMTKpNioc6Fk4mDLU
         DiZeeZK6g5TyqVCzgtWYdNvwPfDgJcMZK4CZ0LKReSL0tItLTlPajLEFiXynK7leihLU
         aGB7rx4pO3zUfabz6/+IRdFUorMs56+B+URRMTite1k+ojinfkkX5VcfIY+E+6rmfKQ4
         UPgrFWad9qVnN/FwjuAJPVgfrSXFasU7AXRzzOFTunwdf9uqk7HwHhVLSDUPRJ+x1zXR
         P2eAjzdxjDcOhrYDl1pdsi+GZghCRmMnrIgyj0WPreqYYhTlCtKbbKHffrQWAbuDUA0d
         8eiw==
X-Gm-Message-State: AOJu0YzTYCGUf3yggzZ6RUoOlflVEbkqOJkCRMJVsVneYHAjaGmReHTT
        Hxh0goFitu/YmqHicXkZgyIKWg==
X-Google-Smtp-Source: AGHT+IGRcnRu1N1xTnN+KnuhwyPQ2zbQ1cfBs1AkuMyRKBLa9fu/rxRRKx3hyrPecuiaTRdyzUKC0g==
X-Received: by 2002:a05:600c:474d:b0:405:3885:490a with SMTP id w13-20020a05600c474d00b004053885490amr15194120wmo.0.1701292491583;
        Wed, 29 Nov 2023 13:14:51 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c198d00b003feea62440bsm3374880wmq.43.2023.11.29.13.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 13:14:51 -0800 (PST)
Message-ID: <8318363a-7122-45f4-a42f-3f01b33457eb@linaro.org>
Date:   Wed, 29 Nov 2023 21:14:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/15] clk: qcom: gpucc-sm6115: Unregister critical
 clocks
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230717-topic-branch_aon_cleanup-v2-0-2a583460ef26@linaro.org>
 <20230717-topic-branch_aon_cleanup-v2-6-2a583460ef26@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v2-6-2a583460ef26@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2023 18:59, Konrad Dybcio wrote:
> Some clocks need to be always-on, but we don't really do anything
> with them, other than calling enable() once and telling Linux they're
> enabled.
> 
> Unregister them to save a couple of bytes and, perhaps more
> importantly, allow for runtime suspend of the clock controller device,
> as CLK_IS_CRITICAL prevents the latter.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/clk/qcom/gpucc-sm6115.c | 33 +++------------------------------
>   1 file changed, 3 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gpucc-sm6115.c b/drivers/clk/qcom/gpucc-sm6115.c
> index fb71c21c9a89..93a50431aef8 100644
> --- a/drivers/clk/qcom/gpucc-sm6115.c
> +++ b/drivers/clk/qcom/gpucc-sm6115.c
> @@ -234,20 +234,6 @@ static struct clk_rcg2 gpu_cc_gx_gfx3d_clk_src = {
>   	},
>   };
>   
> -static struct clk_branch gpu_cc_ahb_clk = {
> -	.halt_reg = 0x1078,
> -	.halt_check = BRANCH_HALT_DELAY,
> -	.clkr = {
> -		.enable_reg = 0x1078,
> -		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data){
> -			.name = "gpu_cc_ahb_clk",
> -			.flags = CLK_IS_CRITICAL,
> -			.ops = &clk_branch2_ops,
> -		},
> -	},
> -};
> -
>   static struct clk_branch gpu_cc_crc_ahb_clk = {
>   	.halt_reg = 0x107c,
>   	.halt_check = BRANCH_HALT_DELAY,
> @@ -336,20 +322,6 @@ static struct clk_branch gpu_cc_cxo_clk = {
>   	},
>   };
>   
> -static struct clk_branch gpu_cc_gx_cxo_clk = {
> -	.halt_reg = 0x1060,
> -	.halt_check = BRANCH_HALT_DELAY,
> -	.clkr = {
> -		.enable_reg = 0x1060,
> -		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data){
> -			.name = "gpu_cc_gx_cxo_clk",
> -			.flags = CLK_IS_CRITICAL,
> -			.ops = &clk_branch2_ops,
> -		},
> -	},
> -};
> -
>   static struct clk_branch gpu_cc_gx_gfx3d_clk = {
>   	.halt_reg = 0x1054,
>   	.halt_check = BRANCH_HALT_SKIP,
> @@ -418,7 +390,6 @@ static struct gdsc gpu_gx_gdsc = {
>   };
>   
>   static struct clk_regmap *gpu_cc_sm6115_clocks[] = {
> -	[GPU_CC_AHB_CLK] = &gpu_cc_ahb_clk.clkr,
>   	[GPU_CC_CRC_AHB_CLK] = &gpu_cc_crc_ahb_clk.clkr,
>   	[GPU_CC_CX_GFX3D_CLK] = &gpu_cc_cx_gfx3d_clk.clkr,
>   	[GPU_CC_CX_GMU_CLK] = &gpu_cc_cx_gmu_clk.clkr,
> @@ -426,7 +397,6 @@ static struct clk_regmap *gpu_cc_sm6115_clocks[] = {
>   	[GPU_CC_CXO_AON_CLK] = &gpu_cc_cxo_aon_clk.clkr,
>   	[GPU_CC_CXO_CLK] = &gpu_cc_cxo_clk.clkr,
>   	[GPU_CC_GMU_CLK_SRC] = &gpu_cc_gmu_clk_src.clkr,
> -	[GPU_CC_GX_CXO_CLK] = &gpu_cc_gx_cxo_clk.clkr,

OTOH.

Seems a pity to remove these clocks - generally for the series I mean - 
from the debug view in /sys/kernel/debug/clk_summary.

In the ideal case we have pm runtime functional without dropping these 
clocks from the view in /sys/kernel/debug/clk_summary.

Certainly I've found that interface useful when launching a real 
product. It might be confusing to _not_ see the always-on clocks 
enumerated there.

---
bod
