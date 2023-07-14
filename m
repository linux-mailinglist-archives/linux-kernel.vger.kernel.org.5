Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA1D75311F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbjGNF1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbjGNF1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:27:03 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C414A2683
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:27:01 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-991da766865so201788866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689312420; x=1691904420;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ft6IvjrZTPyPOF9DZulMSyZSaY4hCN4HAaLDF28wpRo=;
        b=NRPm25RPoQ/OzSKh7eLutSSHgHv3MBss9UqNwO9Y2uqOz4AlqOTgkEMvnssEgrJO8Z
         re/kDNrGgq3jIfURePWQQeRsXGuKUTKjZi18EseHW+cL+DN1B9Ms5Z9jO2jTgxZRBkWJ
         pXgL6EJpkcvaxC2YuNio3Y5G1djM6cvbHZDSm8A+xItfU46RXpqJ76T6/VPXbf1VovkN
         oZR+Rb7DRfBjLAuoFVfuISNK9aGRmuubwg7HPKyAbZjDpxuNbNYBjOOIB0UXBZ4n9IfA
         Lt5p7ni7sr8WXj0nvTHbrl8tTLmKK+qVat5F5sjD5fiu6YWxF/zgO4t0gFdouFWCfLxy
         dL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689312420; x=1691904420;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ft6IvjrZTPyPOF9DZulMSyZSaY4hCN4HAaLDF28wpRo=;
        b=eGSkb2aVy41zUBc0+0hvHfT1gNkbFm0kN0hYzbsEwf6bEcwa7V5S55d1uyR1sbQNtD
         AnGdcywjtltCAq7P2/DiqhEOYl322PzWAAJju4W9ASEBCkOSyi0vUZ8TdiCJ8aUnRqiw
         EmfP90KpP0s4H7naGi3aT5FGOaytO98OeDr6JSKY24dGLtynbSY9pCHNMkV8vXAo0yzE
         HY4NirhmkXyfBTzbN2Eo+d2J5P1/Dqr5xBbLcxSs15M5txphofby5FqMu33BS4kLKYXW
         x3VXfevgKfCr9c8C1SIyaI07+nAyMVsJM8eHCp+rtW+5ZTgze1EYpwAbOHhhvkku3NsV
         lyKg==
X-Gm-Message-State: ABy/qLZEyTMYEyzp/y7aLAD/nUC3H4SlQvOhm6nu5ThcjbkBlxMCWFZr
        ishtRQsZdo76z2sKYwxXt/VE5A==
X-Google-Smtp-Source: APBJJlEUp21s8VCMsojlIgbJv65jiwdNFkcOhUxHu5FPF7wxKX5riA03gHOpIdbFQg+VuLv8LDepQA==
X-Received: by 2002:a17:906:1050:b0:991:f913:a479 with SMTP id j16-20020a170906105000b00991f913a479mr3377345ejj.2.1689312420297;
        Thu, 13 Jul 2023 22:27:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id gz19-20020a170906f2d300b00992e94bcfabsm4809659ejb.167.2023.07.13.22.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 22:26:59 -0700 (PDT)
Message-ID: <3bc9c34a-ba55-61c5-87ea-80b369841873@linaro.org>
Date:   Fri, 14 Jul 2023 07:26:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm64: dts: exynos: add pwm node for exynosautov9-sadk
Content-Language: en-US
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chanho Park <chanho61.park@samsung.com>
References: <CGME20230714052025epcas2p46d5485a277c9f21ace14300dd9d7b4d8@epcas2p4.samsung.com>
 <20230714051521.22720-1-jaewon02.kim@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230714051521.22720-1-jaewon02.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2023 07:15, Jaewon Kim wrote:
> Add pwm node to support fan on exynosautov9-sadk board.
> PWM channel 3 of ExynosAutov9 is connected to fan for SoC cooling
> in SADK board.
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts | 6 ++++++
>  arch/arm64/boot/dts/exynos/exynosautov9.dtsi     | 9 +++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
> index 898c2fc345ed..e717bb1cad81 100644
> --- a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
> +++ b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
> @@ -50,6 +50,12 @@
>  	};
>  };
>  
> +&pwm {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm_tout3>;
> +	status = "okay";
> +};
> +
>  &serial_0 {
>  	pinctrl-0 = <&uart0_bus_dual>;
>  	status = "okay";
> diff --git a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
> index d3c5cdeff47f..e8860b03fe89 100644
> --- a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
> @@ -1560,6 +1560,15 @@
>  			samsung,syscon-phandle = <&pmu_system_controller>;
>  			samsung,cluster-index = <1>;
>  		};
> +
> +		pwm: pwm@103f0000 {
> +			compatible = "samsung,exynos4210-pwm";

Thanks for the patch. I think we should change existing practice for
Samsung SoC and start adding dedicated specific compatible for such
blocks. It's the same practice we follow in other SoCs. It's also
recommendation I give to other platforms.

Therefore this should be "samsung,exynosautov9-pwm",
"samsung,exynos4210-pwm". Feel free to update other DTS as well.

> +			reg = <0x103f0000 0x100>;
> +			samsung,pwm-outputs = <0>, <1>, <2>, <3>;
> +			#pwm-cells = <3>;
> +			clocks = <&xtcxo>;

This does not look like correct clock. Are you sure XTCXO goes to PWM?



Best regards,
Krzysztof

