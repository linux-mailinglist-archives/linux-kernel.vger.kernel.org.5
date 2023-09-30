Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7A77B423D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbjI3Qjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbjI3Qjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:39:43 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD7DDD
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 09:39:39 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c135cf2459so224936111fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 09:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696091978; x=1696696778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YsYBBmmijjJDdkK90sdg+zbm+nxIwxTrAlWHp+1fd+Y=;
        b=tKfzMxouj0rTv7eFFPkSoAy5jZG53xL9Di7sLREnIWQ359Kd/4SbaHXTuw825QOVLL
         xAn1JpUdC9yhcC3RpUNp76QafwEC5qfrRC42TDECWViN/VbEK8480KaDNdC51yWUPn05
         CTxO8kGSN96lmcF4Syu0KYkYmtKccTTGIkqpyQxNZrZVog6cNE1L+sNR0jDEHk/i2NvB
         s5+tLbx6dxBWhG/uM3UHEO8Sh4qiIkfrwg3CCgv4dGPn+AvUCM7wVDmK1a9gEWkeczVz
         L65xGTZfw9X3synDM8oUM8gBgLfaKLqbimDry9Oe3v19H6A7bUYocPb9cG/M+hMhgA5o
         7ZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696091978; x=1696696778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YsYBBmmijjJDdkK90sdg+zbm+nxIwxTrAlWHp+1fd+Y=;
        b=kcYBaeunzUUC6h6Q1mLm9EfCwllCwY4qzYcOxmDbk98f37WAs8S70VMDFjk7T8ZEey
         8Jlye1HdN0w9d1eW6wCpi37PZ0zy/O5s15MZXndwnvRmfxh0Ou/QOf2FgnPKH1yFnchV
         m/fdCOcbK5KbxZ3t8hn/wSKAFNwCSO3zFv9TOcAof5L39dvweNCFlpGBJGujPV0+hMt0
         Ytf+/ZLFfwx6eFGxAIzoI9i58sw0aFF9IMaEyoRie19Sde8xD2ZMsEe0O/azpplatLbY
         UCMDRgADmGy8bGiDOHZbWbntS+i2Tfwb0FM1tMVGJdwdeGlv8BsQB7TpeoUbRlBL3coI
         /3Kw==
X-Gm-Message-State: AOJu0YxjRSQjZlm78i6TwdLMicPhKOxV5+CwYsF9oM/H60u7Mcg1goPf
        Cn/sVT0SPqPJ/OuYnvuW982+1Q==
X-Google-Smtp-Source: AGHT+IFr3dQkMdLil9aL+fiLH6DJaCxg6l8S9ad5Yn5oom2bZvCmuy/LmStKXHHz+8npOZLwHjMfzA==
X-Received: by 2002:a05:6512:3e20:b0:503:28cb:c073 with SMTP id i32-20020a0565123e2000b0050328cbc073mr7954114lfv.58.1696091977744;
        Sat, 30 Sep 2023 09:39:37 -0700 (PDT)
Received: from ?IPV6:2a00:f41:906b:9c4e:a878:12c9:4d61:a6f2? ([2a00:f41:906b:9c4e:a878:12c9:4d61:a6f2])
        by smtp.gmail.com with ESMTPSA id c19-20020a197613000000b005033948f108sm3895415lff.272.2023.09.30.09.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Sep 2023 09:39:37 -0700 (PDT)
Message-ID: <ba0399d3-c3a5-0458-3668-e734fafe2f1a@linaro.org>
Date:   Sat, 30 Sep 2023 18:39:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/5] clk: qcom: camcc-sc8280xp: Add sc8280xp CAMCC
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        andersson@kernel.org, agross@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230930134114.1816590-1-bryan.odonoghue@linaro.org>
 <20230930134114.1816590-5-bryan.odonoghue@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230930134114.1816590-5-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/23 15:41, Bryan O'Donoghue wrote:
> Add the sc8280xp CAMCC driver which follows the sdm845 CAMCC lineage
> with additional CCI and IFE blocks and more granular clock parentage.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
[...]

> +static struct clk_branch camcc_gdsc_clk = {
> +	.halt_reg = 0xc1e4,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0xc1e4,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "camcc_gdsc_clk",
> +			.parent_hws = (const struct clk_hw*[]){
> +				&camcc_xo_clk_src.clkr.hw,
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_IS_CRITICAL | CLK_SET_RATE_PARENT,
"meh"

Is this clock only necessary for the GDSC to turn on?

I wanted to say "just chuck it into gdsc.cxcs", but upon actually 
reading the code, I realized that just doing so doesn't event turn the 
referenced clocks on.. That's.. a realization.. I think I'll be able to 
solve a couple bugs with this knowledge..



[...]

> +	ret = qcom_cc_really_probe(pdev, &camcc_sc8280xp_desc, regmap);
This conflicts with [1]

> +	if (ret)
> +		goto err_put_rpm;

[...]

> +
> +static int __init camcc_sc8280xp_init(void)
> +{
> +	return platform_driver_register(&camcc_sc8280xp_driver);
> +}
> +subsys_initcall(camcc_sc8280xp_init);
  module_platform_driver, please

Konrad

[1] 
https://lore.kernel.org/linux-arm-msm/20230923112105.18102-4-quic_luoj@quicinc.com/
