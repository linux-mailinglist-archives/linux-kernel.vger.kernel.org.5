Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2ACB7A3445
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 10:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjIQIXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 04:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjIQIWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 04:22:50 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1932412F
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 01:22:43 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bf8b9c5ca0so56712661fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 01:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694938961; x=1695543761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UKJQdmUO+2e6eXt5x8oNFwJaRXFDIfNhfyn01aL90+s=;
        b=wzKHXfxyb1OFlP/hAPZLw7pZtRHhgf3FYt3aHEgWdtHlt1yD+tiB+bfuoZa18F/ReX
         lmUEg978Wjr+V9N2tC5GiJbRAe8t3CMDoAHxxa8ULKVV0NcceIgyAz3C5N55Z/AUePOm
         fu7S0flpa2Ll+2OGTVKS6lxqrYLeJZbmA2Dvi5nzOytTjKaA1bwP+WyAne8RqW5yvjJG
         wJq1oRz8RTUF+Zd6EtTvy+7wFR/ByO3RofPuthAEay0hIVaOG3QpY2bBuhrHAq+FEzdm
         EnO/wtisqItT/a23L9KBUztbLawHzOJVKTyXQyrIC4AC2+9NJe8DDAqDhsLy+4nHwqrI
         VFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694938961; x=1695543761;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKJQdmUO+2e6eXt5x8oNFwJaRXFDIfNhfyn01aL90+s=;
        b=XwATizwhiqEGOjz/k0Uy4+JZyNzdqnan9yEf6qfgVR6sDhCT0+Oqsy0CHo8ntn/cPM
         hHnobVh0Dax8Zq/eR4WlmQ1qHAzmemje1LMofiNEPC83KSFnRXrPF86q+JzIywS8Wqee
         WN5fFR6BKL3qW8eP48F/wMn7QXPh4El/ALv8rpTf8TJHDuEyg0pyPzrN+sn+duecTlWg
         ZHUJRaQhSMxIo4MGwLiDDgQb416sfN+hGfVQjUQd56s7XkVRbCFrO0drfjna2OrSHDUn
         nA+rE/nHYHT/q0O+CNK9bITAh1ugmRfMGx6tCxUVEimt6LiHvuzU/9gJefkbv3dRmXKI
         cMXQ==
X-Gm-Message-State: AOJu0YwQ619J0cSW8fyEPuqnGpwEZcrwk4ur0TAGEdfdePi7bjaB8pA1
        xyO7wSAbR05Zb/RfcaYyl7Xn3g==
X-Google-Smtp-Source: AGHT+IHhKmI2AHVuwE1u4od36FAcoAVoqNik+gwDo4HPAZycohFbezmVf25FmXnTpiN7CXkAeqnU3A==
X-Received: by 2002:a05:651c:1a27:b0:2bf:f5c9:2dce with SMTP id by39-20020a05651c1a2700b002bff5c92dcemr2603321ljb.30.1694938961251;
        Sun, 17 Sep 2023 01:22:41 -0700 (PDT)
Received: from [192.168.1.77] (150-140-187-31.ftth.glasoperator.nl. [31.187.140.150])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906595500b00992f2befcbcsm4667110ejr.180.2023.09.17.01.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 01:22:40 -0700 (PDT)
Message-ID: <6166b695-25af-54b0-9d30-36c75189b0c5@linaro.org>
Date:   Sun, 17 Sep 2023 10:22:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1 1/1] ARM: dts: hpe: BUG: Correct GXP register ranges
Content-Language: en-US
To:     charles.kearney@hpe.com, verdun@hpe.com, nick.hawkins@hpe.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230915165436.3118284-1-charles.kearney@hpe.com>
 <20230915165436.3118284-2-charles.kearney@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915165436.3118284-2-charles.kearney@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 18:54, charles.kearney@hpe.com wrote:
> From: Charles Kearney <charles.kearney@hpe.com>
> 
> Bug fix to correct memory ranges on GXP to include host registers. This
> corrects a issue where the host interrupt controller is not available.

Then you miss Fixes tag. Maybe also Cc-stable tag.

> 
> Signed-off-by: Charles Kearney <charles.kearney@hpe.com>
> ---
>  arch/arm/boot/dts/hpe/hpe-gxp.dtsi | 39 +++++++++++++++---------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/hpe/hpe-gxp.dtsi b/arch/arm/boot/dts/hpe/hpe-gxp.dtsi
> index cf735b3c4f35..18230a4754a6 100644
> --- a/arch/arm/boot/dts/hpe/hpe-gxp.dtsi
> +++ b/arch/arm/boot/dts/hpe/hpe-gxp.dtsi
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Device Tree file for HPE GXP
> + * Device Tree for HPE

How is this related to bug?

>   */
>  
>  /dts-v1/;
> @@ -52,73 +52,74 @@ L2: cache-controller@b0040000 {
>  			cache-level = <2>;
>  		};
>  
> -		ahb@c0000000 {
> +		ahb@80000000 {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -			ranges = <0x0 0xc0000000 0x30000000>;
>  			dma-ranges;
> +			ranges = <0x0 0x80000000 0x20000000>,
> +			<0x40000000 0xc0000000 0x3fff0000>;

Missing proper alignment.


Best regards,
Krzysztof

