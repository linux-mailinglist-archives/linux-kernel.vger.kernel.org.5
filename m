Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCFA7FE194
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbjK2VKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbjK2VKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:10:44 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E5510C2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:10:50 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b4f60064eso1726865e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701292248; x=1701897048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wtBnMhm6OvHI+sD8xVhry5VRmxy7IqGvQG/iVuqiaCo=;
        b=HDSIBx0grkiFIuVQEncbGx+zGKJCrBZc1Y6koKNNyU29PZoq/ayADwuI9NPlpv7cPe
         ixQJ9tTWiddnbqNTpg5+GN1djEuhlp/j0sX3MuEQHEbMOtTUnrR2ap3B2xmZBAZsg0xT
         QLNQGYFu+lkifDgL74bOr7n/EdIEhNa3jATire/01Xc72dncTDKonwFWL649Bm8b608r
         8dTpu1UTAaMURJN04q6LWHTrHkna/S2cVsTSUkLESAWEbX8Lm0MoEE7zfsMjFeyc0QIH
         ekNuLrZLdIssT8epO+zxLc7BR3EWFZt0Zqd3rmz+s9nSsiFXcWhdwlUbjcE47A3YEFWm
         Cjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701292248; x=1701897048;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtBnMhm6OvHI+sD8xVhry5VRmxy7IqGvQG/iVuqiaCo=;
        b=w6TbMuoPuY7AqAVjrCAOKZCgJMwtaHY8L2KXPsdsK58VIAjj5fazZBWyxede25wK7l
         r/aLMuj3xGNyqTjNb2H90883vwsf8Dfi6p+3QhZchtD825aMkK/9jr/eNnyJEaqo6y68
         JnHxdsQiPwnHp7wxgbfgte4qFTDGv4DikuIc/nggqAr6EEzPY4kKXQUDbrmkp/FDSVG+
         1YmuLXhbqLUZ/9ln0J2wOCKXJnDE9/ICwsaQpuUg6RWmublK60t89pk5kLt8HeOrMVyk
         mX4GtFvJ5jbWmBL5TPG1dVjYKzDqUbPAvNKOAvOM/e3wdzVFhOUOyFNh/5r5XOjM9qWP
         iXyw==
X-Gm-Message-State: AOJu0Yy3olijVY+iMTZ/t4kOdcoEH0m8gqrYhj6NPNgL/r3esgBxzitu
        m3ThocX4yiWAar1iGLj2tZO10g==
X-Google-Smtp-Source: AGHT+IFK6ZIhfZ4JuFNWETn6u9qVaS2ig7dwVdCiT9wxAV7HwOa3SUvF1+3PBWJecliU6ZqoknkANg==
X-Received: by 2002:adf:f14c:0:b0:333:145b:dbe4 with SMTP id y12-20020adff14c000000b00333145bdbe4mr2636137wro.42.1701292248595;
        Wed, 29 Nov 2023 13:10:48 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c500e00b0040b478da760sm3433383wmr.48.2023.11.29.13.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 13:10:48 -0800 (PST)
Message-ID: <622181e8-acd8-42e4-8a39-c75cd8862999@linaro.org>
Date:   Wed, 29 Nov 2023 21:10:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/15] clk: qcom: gpucc-sm6375: Unregister critical
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
 <20230717-topic-branch_aon_cleanup-v2-5-2a583460ef26@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v2-5-2a583460ef26@linaro.org>
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
>   drivers/clk/qcom/gpucc-sm6375.c | 33 +++------------------------------
>   1 file changed, 3 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gpucc-sm6375.c b/drivers/clk/qcom/gpucc-sm6375.c
> index da24276a018e..6d85936dd441 100644
> --- a/drivers/clk/qcom/gpucc-sm6375.c
> +++ b/drivers/clk/qcom/gpucc-sm6375.c
> @@ -183,20 +183,6 @@ static struct clk_rcg2 gpucc_gx_gfx3d_clk_src = {
>   	},
>   };
>   
> -static struct clk_branch gpucc_ahb_clk = {
> -	.halt_reg = 0x1078,
> -	.halt_check = BRANCH_HALT_DELAY,
> -	.clkr = {
> -		.enable_reg = 0x1078,
> -		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data){
> -			.name = "gpucc_ahb_clk",
> -			.flags = CLK_IS_CRITICAL,
> -			.ops = &clk_branch2_ops,
> -		},
> -	},
> -};
> -
>   static struct clk_branch gpucc_cx_gfx3d_clk = {
>   	.halt_reg = 0x10a4,
>   	.halt_check = BRANCH_HALT_DELAY,
> @@ -294,20 +280,6 @@ static struct clk_branch gpucc_cxo_clk = {
>   	},
>   };
>   
> -static struct clk_branch gpucc_gx_cxo_clk = {
> -	.halt_reg = 0x1060,
> -	.halt_check = BRANCH_HALT_DELAY,
> -	.clkr = {
> -		.enable_reg = 0x1060,
> -		.enable_mask = BIT(0),
> -		.hw.init = &(struct clk_init_data){
> -			.name = "gpucc_gx_cxo_clk",
> -			.flags = CLK_IS_CRITICAL,
> -			.ops = &clk_branch2_ops,
> -		},
> -	},
> -};
> -
>   static struct clk_branch gpucc_gx_gfx3d_clk = {
>   	.halt_reg = 0x1054,
>   	.halt_check = BRANCH_HALT_DELAY,
> @@ -381,7 +353,6 @@ static struct gdsc gpu_gx_gdsc = {
>   };
>   
>   static struct clk_regmap *gpucc_sm6375_clocks[] = {
> -	[GPU_CC_AHB_CLK] = &gpucc_ahb_clk.clkr,
>   	[GPU_CC_CX_GFX3D_CLK] = &gpucc_cx_gfx3d_clk.clkr,
>   	[GPU_CC_CX_GFX3D_SLV_CLK] = &gpucc_cx_gfx3d_slv_clk.clkr,
>   	[GPU_CC_CX_GMU_CLK] = &gpucc_cx_gmu_clk.clkr,
> @@ -389,7 +360,6 @@ static struct clk_regmap *gpucc_sm6375_clocks[] = {
>   	[GPU_CC_CXO_AON_CLK] = &gpucc_cxo_aon_clk.clkr,
>   	[GPU_CC_CXO_CLK] = &gpucc_cxo_clk.clkr,
>   	[GPU_CC_GMU_CLK_SRC] = &gpucc_gmu_clk_src.clkr,
> -	[GPU_CC_GX_CXO_CLK] = &gpucc_gx_cxo_clk.clkr,
>   	[GPU_CC_GX_GFX3D_CLK] = &gpucc_gx_gfx3d_clk.clkr,
>   	[GPU_CC_GX_GFX3D_CLK_SRC] = &gpucc_gx_gfx3d_clk_src.clkr,
>   	[GPU_CC_GX_GMU_CLK] = &gpucc_gx_gmu_clk.clkr,
> @@ -455,6 +425,9 @@ static int gpucc_sm6375_probe(struct platform_device *pdev)
>   	clk_lucid_pll_configure(&gpucc_pll0, regmap, &gpucc_pll0_config);
>   	clk_lucid_pll_configure(&gpucc_pll1, regmap, &gpucc_pll1_config);
>   
> +	qcom_branch_set_clk_en(regmap, 0x1078); /* GPUCC_AHB_CLK */
> +	qcom_branch_set_clk_en(regmap, 0x1060); /* GPUCC_GX_CXO_CLK */
> +
>   	ret = qcom_cc_really_probe(pdev, &gpucc_sm6375_desc, regmap);
>   	pm_runtime_put(&pdev->dev);
>   
> 

I think this makes sense for a CLK_IS_CRITICAL clock - why bother 
enumerating halt regs/semantics we never use..

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
