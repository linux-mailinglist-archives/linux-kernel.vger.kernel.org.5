Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C567BB407
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 11:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjJFJLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 05:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjJFJLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 05:11:41 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD870AC
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 02:11:39 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso343205666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 02:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696583498; x=1697188298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gPZAjel/7BEY3RhAgCPVg4ze/Urh/MvLCiSwVXSV0HU=;
        b=Xel9Ad1L2qTFegpOhl08ceyHywdd+rZw6HCn64t0Jcpig2I9ATAtlq7eYlWjuDCPZe
         GDM/YJ9Q4Vhu1dikirMYNiuJhvoCmPdF2AFHaugsDY/Kps5UAeb7Zltu8o7ePn+SoQ2E
         CtfswQ/3z9sR8jKHsCdhzpZGMYOp/II4PFPCicp5wZbIsom34TOZreM+UGPkvENpt6p4
         BRGzZgULlpJseALxK3JgW+0ClZ+LXbKr8Vto+Q69qhA6McGlU7oUCXVjX+CYGPUeyjkH
         Jz/rRrrMR1v/B+asVloiN1CJC5XE3cBQ3z7VJW/HyVfTVACXyHpAjgz3qjxtPhcCqC3O
         K7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696583498; x=1697188298;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPZAjel/7BEY3RhAgCPVg4ze/Urh/MvLCiSwVXSV0HU=;
        b=YWh3S3dfCzN6J/yDZ8Gb1x4R5jc4H/P0dR1tc7aeHowKFOrUQ4pUIZX9+OZhRQYYL0
         oapNo2nUwKDnuvVPR0E17a2du0YMxXuyzBWid9aTEfrAIxePKuOKzFkAaS4wemCzIAzS
         pnjAtloJB8JKejKPJ5QRtqzQK7fBfUBE/2Yhu4p7thWz2p3cGMhCerCbhsLnfMn/n3g1
         2jggrk0kpFjTvdZ3Dls+/UyQqBrGXGVBY405hKrXJBFfs3FwgSd2iUyL0Jc0ydZpRm7n
         VdCAxTUS8t2Vq5DtSughtTtZ9FDVNslzlwHEBCmrG6sIV6CtZIQhERfg7QK79kUF1CQ0
         gxXg==
X-Gm-Message-State: AOJu0YxhfENEjJt95Vw86VW6cHuU3ZkSl2qPSJhTELQzvnoZBidqJzmJ
        Q9Rnac7NU276rQNS1fA0mRruqw==
X-Google-Smtp-Source: AGHT+IHqzxCTQW4dbnB+MpVwIaaz+tcSa18UGqOEYvZ3kAj3sqBG9BQ87e4hq6GOmFlmpnLPwJAtnA==
X-Received: by 2002:a17:907:788a:b0:9b2:717a:c0ec with SMTP id ku10-20020a170907788a00b009b2717ac0ecmr7054791ejc.69.1696583498149;
        Fri, 06 Oct 2023 02:11:38 -0700 (PDT)
Received: from [192.168.1.197] (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id t27-20020a1709063e5b00b00997e00e78e6sm2552344eji.112.2023.10.06.02.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 02:11:37 -0700 (PDT)
Message-ID: <5dbbbfd7-d4ea-4aa2-b1f5-7207e2767069@linaro.org>
Date:   Fri, 6 Oct 2023 11:11:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: exynos: set USI mode in board dts
To:     Tudor Ambarus <tudor.ambarus@linaro.org>, robh+dt@kernel.org,
        conor+dt@kernel.org, alim.akhtar@samsung.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        semen.protsenko@linaro.org, peter.griffin@linaro.org
References: <20231006090258.278369-1-tudor.ambarus@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231006090258.278369-1-tudor.ambarus@linaro.org>
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

On 06/10/2023 11:02, Tudor Ambarus wrote:
> The Universal Serial Interface (USI) provides selectable serial protocol
> (UART, SPI, I2C). Only one function can be used at a time. The SoC
> provides flexibility for boards to choose the protocol desired. Instead
> of selecting the USI protocol mode in the SoC dtsi file, select the mode
> in the board dts file as the USI IP can work in either of the 3 modes,
> but the board uses just one. Where the USI node was not enabled in the
> board dts file, just remove the samsung,mode specified in dtsi.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  .../boot/dts/exynos/exynos850-e850-96.dts     |  2 ++
>  arch/arm64/boot/dts/exynos/exynos850.dtsi     |  8 ------
>  .../boot/dts/exynos/exynosautov9-sadk.dts     |  2 ++
>  arch/arm64/boot/dts/exynos/exynosautov9.dtsi  | 25 -------------------
>  4 files changed, 4 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
> index 6ed38912507f..615c1d6647ea 100644
> --- a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
> @@ -15,6 +15,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/leds/common.h>
> +#include <dt-bindings/soc/samsung,exynos-usi.h>
>  
>  / {
>  	model = "WinLink E850-96 board";
> @@ -187,6 +188,7 @@ &serial_0 {
>  };
>  
>  &usi_uart {
> +	samsung,mode = <USI_V2_UART>;
>  	samsung,clkreq-on; /* needed for UART mode */
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/exynos/exynos850.dtsi b/arch/arm64/boot/dts/exynos/exynos850.dtsi
> index aa077008b3be..db35ee742a27 100644
> --- a/arch/arm64/boot/dts/exynos/exynos850.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos850.dtsi
> @@ -12,7 +12,6 @@
>  
>  #include <dt-bindings/clock/exynos850.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> -#include <dt-bindings/soc/samsung,exynos-usi.h>
>  
>  / {
>  	/* Also known under engineering name Exynos3830 */
> @@ -574,7 +573,6 @@ usi_uart: usi@138200c0 {
>  			compatible = "samsung,exynos850-usi";
>  			reg = <0x138200c0 0x20>;
>  			samsung,sysreg = <&sysreg_peri 0x1010>;
> -			samsung,mode = <USI_V2_UART>;

This would have sense if the node was complete - had something else than
UART. However node has only UART currently, so mode is reasonable here.
I understand that choice of mode is DTS dependent, but now it looks like
the board could actually choose it which is no true. Board DTS canno
select something different than UART.

This should be also fixed with bringing missing USI children.

It makes sense though for usi_cmgp1 and others which have more children.

>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> @@ -600,7 +598,6 @@ usi_hsi2c_0: usi@138a00c0 {
>  			compatible = "samsung,exynos850-usi";
>  			reg = <0x138a00c0 0x20>;
>  			samsung,sysreg = <&sysreg_peri 0x1020>;
> -			samsung,mode = <USI_V2_I2C>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> @@ -628,7 +625,6 @@ usi_hsi2c_1: usi@138b00c0 {
>  			compatible = "samsung,exynos850-usi";
>  			reg = <0x138b00c0 0x20>;
>  			samsung,sysreg = <&sysreg_peri 0x1030>;
> -			samsung,mode = <USI_V2_I2C>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> @@ -656,7 +652,6 @@ usi_hsi2c_2: usi@138c00c0 {
>  			compatible = "samsung,exynos850-usi";
>  			reg = <0x138c00c0 0x20>;
>  			samsung,sysreg = <&sysreg_peri 0x1040>;
> -			samsung,mode = <USI_V2_I2C>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> @@ -684,7 +679,6 @@ usi_spi_0: usi@139400c0 {
>  			compatible = "samsung,exynos850-usi";
>  			reg = <0x139400c0 0x20>;
>  			samsung,sysreg = <&sysreg_peri 0x1050>;
> -			samsung,mode = <USI_V2_SPI>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> @@ -698,7 +692,6 @@ usi_cmgp0: usi@11d000c0 {
>  			compatible = "samsung,exynos850-usi";
>  			reg = <0x11d000c0 0x20>;
>  			samsung,sysreg = <&sysreg_cmgp 0x2000>;
> -			samsung,mode = <USI_V2_I2C>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> @@ -738,7 +731,6 @@ usi_cmgp1: usi@11d200c0 {
>  			compatible = "samsung,exynos850-usi";
>  			reg = <0x11d200c0 0x20>;
>  			samsung,sysreg = <&sysreg_cmgp 0x2010>;
> -			samsung,mode = <USI_V2_I2C>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> diff --git a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
> index bc1815f6ada2..91d302703366 100644
> --- a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
> +++ b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
> @@ -9,6 +9,7 @@
>  /dts-v1/;
>  #include "exynosautov9.dtsi"
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/soc/samsung,exynos-usi.h>
>  
>  / {
>  	model = "Samsung ExynosAuto v9 SADK board";
> @@ -79,6 +80,7 @@ &ufs_1 {
>  };
>  
>  &usi_0 {
> +	samsung,mode = <USI_V2_UART>;
>  	samsung,clkreq-on; /* needed for UART mode */
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
> index b228cd7e351e..92f4b738834a 100644
> --- a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
> @@ -9,7 +9,6 @@
>  #include <dt-bindings/clock/samsung,exynosautov9.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/soc/samsung,boot-mode.h>
> -#include <dt-bindings/soc/samsung,exynos-usi.h>
>  
>  / {
>  	compatible = "samsung,exynosautov9";
> @@ -392,7 +391,6 @@ usi_0: usi@103000c0 {
>  				     "samsung,exynos850-usi";
>  			reg = <0x103000c0 0x20>;
>  			samsung,sysreg = <&syscon_peric0 0x1000>;
> -			samsung,mode = <USI_V2_UART>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges;
> @@ -454,7 +452,6 @@ usi_i2c_0: usi@103100c0 {

Here as well. This node has only I2C, so mode is reasonable.


Best regards,
Krzysztof

