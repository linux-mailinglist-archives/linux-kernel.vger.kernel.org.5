Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE6C7A878C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbjITOuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbjITOuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:50:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E1CA9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:50:31 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-986d8332f50so962905966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695221430; x=1695826230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L560O8LznDfcCbsVL+apZ5JDZeve8iwxi3CV96KHKHQ=;
        b=kz6HMrIjbzLdH5awxzkNFjadA3Hn7M5eqHrzhLBQZOBjxz3cpxwn3tg8HrZabsMs9y
         Os9N0eM/nbGwctSFVtJdBAfreJY6m5Tn0a0R5Lqczsa2pRq1wDMD0gR5+kzEDjSUqvpw
         6KqbASBZVK0c7ffKSo1iHUwYX3OfZhyukV9+P1ODsa9DrSFLjzAqARH9HsAABj3iYHD+
         Chptq0JgkNyqugqysNW3KWIa2S+LA/jb9EkN0iV1/6g9G5I5mI6YIt90vJVnnjv4jaRH
         2dpItjv4djiYXP8FWzBWe6acEPWuVgy8fhunf+s9gSFwjfsw9qiiOiAkNVoVkafIGOTd
         NHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695221430; x=1695826230;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L560O8LznDfcCbsVL+apZ5JDZeve8iwxi3CV96KHKHQ=;
        b=qubPPO8u2zUyxvlwnAANE7XfzAgsCBhxk+r740qdGescZmwGR9u7bO6wm4LG+Zlr0Y
         WJOaE6pA4ia8ZKBhZJ/K8siss2XafyiRloRzOYnB9M3rR5aX6mxCj3rzROooe2uuB+E1
         +EbKCOaWzCX5mV2avaTvngVvSDhj3ogUlyOf7zUY9F8pfUpNJYBhFbtIBDoan7H8BShF
         UqZ6rnycGkx00oydqjZcqaQNR7L+/vUypjY7CRVCa+UJ0Hm6zt62JUBDTGx6c5vnwsWj
         NbUA7b+rgVBlTdJqdhO+OeC3yQztFC/BY0WZ+LrqrgtoszRHg+E3tdxrbwZj8rdM+vR6
         qneg==
X-Gm-Message-State: AOJu0YwQWQurs76QNtLpMUlAC6LluAZKh6hBYep0+2sRfLulRaCtmlos
        kUpnXh1mR2D6T0c2pXQ8VogV2Q==
X-Google-Smtp-Source: AGHT+IHkYUHnyR9qTzuxYR22Orl/gY1yeo4VTHbqKE1Wd9pSDzfoOcW2996OUoupHvMa+XuMC45/5A==
X-Received: by 2002:a17:907:75c8:b0:9a5:cc73:a2a6 with SMTP id jl8-20020a17090775c800b009a5cc73a2a6mr2154478ejc.14.1695221429997;
        Wed, 20 Sep 2023 07:50:29 -0700 (PDT)
Received: from [172.20.86.172] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id bq14-20020a170906d0ce00b0099ddc81903asm9511064ejb.221.2023.09.20.07.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 07:50:29 -0700 (PDT)
Message-ID: <b45a5263-c6dd-f446-babe-1da287dbf74f@linaro.org>
Date:   Wed, 20 Sep 2023 16:50:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/3] arm64: dts: qcom: msm8916-longcheer-l8150: Add
 battery and charger
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230916-pm8916-dtsi-bms-lbc-v1-0-7db0b42f9fb1@trvn.ru>
 <20230916-pm8916-dtsi-bms-lbc-v1-3-7db0b42f9fb1@trvn.ru>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230916-pm8916-dtsi-bms-lbc-v1-3-7db0b42f9fb1@trvn.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/16/23 15:57, Nikita Travkin wrote:
> Longcheer L8150 doesn't have any dedicated fuel-gauge or charger,
> instead making use of the pmic hardware blocks for those purposes.
> 
> Add pm8916 bms and charger, as well as the battery cell description
> that those devices rely on.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>   .../boot/dts/qcom/msm8916-longcheer-l8150.dts      | 43 +++++++++++++++++++---
>   1 file changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
> index 3892ad4f639a..95dddf3b3880 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
> @@ -33,6 +33,25 @@ wcnss_mem: wcnss@8b600000 {
>   		};
>   	};
>   
> +	battery: battery {
> +		compatible = "simple-battery";
> +		voltage-min-design-microvolt = <3400000>;
> +		voltage-max-design-microvolt = <4350000>;
> +		energy-full-design-microwatt-hours = <9500000>;
> +		charge-full-design-microamp-hours = <2500000>;
> +
> +		ocv-capacity-celsius = <25>;
> +		ocv-capacity-table-0 = <4330000 100>, <4265000 95>,
> +			<4208000 90>, <4153000 85>, <4100000 80>, <4049000 75>,
> +			<4001000 70>, <3962000 65>, <3919000 60>, <3872000 55>,
> +			<3839000 50>, <3817000 45>, <3798000 40>, <3783000 35>,
> +			<3767000 30>, <3747000 25>, <3729000 20>, <3709000 16>,
> +			<3688000 13>, <3681000 11>, <3680000 10>, <3679000 9>,
> +			<3677000 8>, <3674000 7>, <3666000 6>, <3641000 5>,
> +			<3597000 4>, <3537000 3>, <3457000 2>, <3336000 1>,
> +			<3000000 0>;
> +	};
> +
>   	gpio-keys {
>   		compatible = "gpio-keys";
>   
> @@ -220,6 +239,22 @@ &blsp_uart2 {
>   	status = "okay";
>   };
>   
> +&pm8916_bms {
> +	status = "okay";
status last

Konrad
