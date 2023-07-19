Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDD275915E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjGSJRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjGSJRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:17:32 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BD2121
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:17:30 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e48e1f6d1so9071327a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689758248; x=1692350248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vbFAUTqn4J/1uXGDz1Y+p40GpYX5buZBByhfIvb+XTw=;
        b=pWC6FgUMIYeP779sWAqgtzO3nU1XJ6nhP75SPD12kn5z7GaOdQUHJSr1oj+fpvsMzu
         1olNjVI5wRWrn45bUPuYJyc5Bco8Iwi76p6mGXk8gdDHJ8p+VfH0Y9Ob/M/hmJowz1Gc
         J+pNlH0r5n+VARIHACKHBpFtJ+fkdhK77/Ra2Fb2lW0F96NuMi3yPmIb8SIxEbJT+vJ4
         NbT2hiKo+epWuNBHDFljYudEOU8wGGY0fV8Na+/YoGH0+S92GxieXHMoNGOhVnIdlO7o
         mBmS3hhhglibp+4T6hBrbrEi0hI9yP9Rr6ZhyVA0T7CkDbC5e5ZxaRjLFEr2TUPH/EFx
         M6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689758248; x=1692350248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbFAUTqn4J/1uXGDz1Y+p40GpYX5buZBByhfIvb+XTw=;
        b=fbPt+dbF0HY5IrK1vEcoREc2BJnbVj9HJLPtIOW4Tz2pchKoJBlT8hj2uHlZR7S0Bk
         gIPqh1oBQ/UE4qyj+imew57pEiTmjY6IWLFug1+ysXIzgEE9L7NP+s9DWl3MTvWZWYeO
         0Kvsq8CSQR0+6dTcYa+p2dRRZDaM5sweJUjdC4L/gmNMi71Sq2s/dxaVizSp3OJ2Z0Vm
         jmPYdIeuLaZ/7EtBiKwTBbn35b/2aJGg4vOF3l+gsIoBanN8HtLM9OJg0SGs2P78nByV
         2FIxtPDB3d8Bs3oz25XH0bLdSB8lTF5PG0FmX/b2It/QnTlj5UtwawwGao/Ob4k1u9Cd
         Jxvw==
X-Gm-Message-State: ABy/qLZl7o/1n8uFZuvu9oWyF/6pFDPpbpWpm4lGmRrP09EGLt2DH8ci
        MYJf2PiAhj2s1gmLezvGASSk+w==
X-Google-Smtp-Source: APBJJlEa4+3uhs2sYS9ftR+O+4gIJ5VpENZ++c6LZlxKhiuUtFmEJV/gmWJNZ1CJFLaGAPqoWDTMng==
X-Received: by 2002:aa7:d384:0:b0:51b:ec86:b49a with SMTP id x4-20020aa7d384000000b0051bec86b49amr2063330edq.7.1689758248587;
        Wed, 19 Jul 2023 02:17:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id k26-20020a056402049a00b0051e186a6fb0sm2422099edv.33.2023.07.19.02.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 02:17:28 -0700 (PDT)
Message-ID: <3c291f6a-7e9a-b863-9c34-c486647edbf7@linaro.org>
Date:   Wed, 19 Jul 2023 11:17:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/7] ARM: dts: exynos: k3g: Add notification LED support
Content-Language: en-US
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230716220644.22158-1-markuss.broks@gmail.com>
 <20230716220644.22158-7-markuss.broks@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230716220644.22158-7-markuss.broks@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 00:05, Markuss Broks wrote:
> This device has a Texas Instruments LP5562 LED controller
> which controls the LEDs which are used as notification lights.
> It has three colors which can be combined, supports pulse mode
> and other various features.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  arch/arm/boot/dts/exynos5422-samsung-k3g.dts | 47 ++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
> index b3576a745054..813dbf0438de 100644
> --- a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
> +++ b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
> @@ -10,6 +10,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/leds/common.h>
>  #include "exynos5800.dtsi"
>  #include "exynos5422-cpus.dtsi"
>  
> @@ -131,6 +132,52 @@ touchkey@20 {
>  		};
>  	};
>  
> +	i2c-led {
> +		compatible = "i2c-gpio";
> +
> +		sda-gpios = <&gpy3 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		scl-gpios = <&gpy3 7 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +		i2c-gpio,delay-us = <2>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		lp5562@30 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Most likely this is led-controller



Best regards,
Krzysztof

