Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC097E5179
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjKHH6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjKHH6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:58:36 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB882170A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 23:58:33 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c72e275d96so23379031fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 23:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699430312; x=1700035112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8To552w1iOkDCGDyDXCq580Qte0/9NeRCnN/SLW1af8=;
        b=bY/9RLnpUZr04n2VDvgU+d1C731fByJSka7bGe4KyumA0NTWzn/VMr4PzpXVioM70h
         hESNBysl4UeMTNdEu/HSg1hKi7heOHMZ9ygmUZbI4fSgolqZwG4AnEGw90db02b2HMzB
         23E9+c+S0yMb9PHP0uKwrqMEPoWY0C0q2iYJgc7fpASOHmuNCSRfeuaZKVQSsEmbIHBv
         4BDGnANReVxVTNli9RApAqjJy0JrlXjGWwMkEwKkNJsa5gF/xpjLcfarRxfuScCAGFRx
         L83pcCKcKo1lz3GPCjyIi07xKMJ9O0jo2izjueQO/TyBYR9RKEurN73fM0fcGGcyLIe8
         iRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699430312; x=1700035112;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8To552w1iOkDCGDyDXCq580Qte0/9NeRCnN/SLW1af8=;
        b=Nuq3DExk6ihH+oBh4DGKWm1hS1GxP74ovihjxEnrFzRaURJymeAy8DUOxa2ITu2PKW
         uoyxj+trkB6OaADken2nxpK/s+W0tyvWXvQpI7tE1aNipn6zImkSU4raPEl1mhZkMU0y
         A0+dwxbnWYGIzRb3sWCLsrtLfVLaQ25tDTlfGii7kZRtxpdqkyIuM/q+OLxfHS2dbzit
         JBHtXErSAwlnZYeHn/3gLMYVc77xjpNuz2QrDUTFGXk6hXIRIRrujZLp5bj57mxe9irn
         m98ezN8cqE6Ok6CH5ihqNbfMg7ohBfiaBHG1zmdPiGNgG3CxgfJRBwLTof4hu9OIWQ0v
         UwiQ==
X-Gm-Message-State: AOJu0YyMiLRMvPtRBAdIxG2ZsRMDG+uFqX8KeCe/cZHcfqWRgJWTc+/x
        LwMX1F6twJ1iEiR0F0leCWwVMA==
X-Google-Smtp-Source: AGHT+IHxbLX2lr6v79HYyFKuNVD9GDwxkrWDUtzdOuOzRJIHWb5woLRyh0DxMBE03QuXwl+6uzzfFQ==
X-Received: by 2002:a2e:2c15:0:b0:2c6:f51f:c96d with SMTP id s21-20020a2e2c15000000b002c6f51fc96dmr949079ljs.13.1699430311938;
        Tue, 07 Nov 2023 23:58:31 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id f16-20020a7bc8d0000000b0040684abb623sm17647507wml.24.2023.11.07.23.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 23:58:31 -0800 (PST)
Message-ID: <684670c3-d749-43fd-8ae7-89b26843aec8@linaro.org>
Date:   Wed, 8 Nov 2023 08:58:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] arm64: dts: exynos: add initial support for
 exynosautov920 SoC
Content-Language: en-US
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org
References: <20231031094852.118677-1-jaewon02.kim@samsung.com>
 <CGME20231031095021epcas2p352c4ace8652d7bf1f74a9b32ab61a913@epcas2p3.samsung.com>
 <20231031094852.118677-10-jaewon02.kim@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231031094852.118677-10-jaewon02.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2023 10:47, Jaewon Kim wrote:
> Samsung ExynosAutov920 is ARMv8-based automotive-oriented SoC.
> It has AE(Automotive Enhanced) IPs for safety.
>  * Cortex-A78AE 10-cores
>  * GIC-600AE
> 
> This is minimal support for ExynosAutov920 SoC.
>  * Enumerate all pinctrl nodes
>  * Enable Chip-Id
>  * Serial0 for console
>  * PWM
> 
> Since the clock driver is not yet implemented, it is supported as
> fixed-clock.
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>  .../dts/exynos/exynosautov920-pinctrl.dtsi    | 1266 +++++++++++++++++
>  .../arm64/boot/dts/exynos/exynosautov920.dtsi |  318 +++++
>  2 files changed, 1584 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920-pinctrl.dtsi
>  create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920.dtsi
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynosautov920-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynosautov920-pinctrl.dtsi
> new file mode 100644
> index 000000000000..63b958b96c48
> --- /dev/null
> +++ b/arch/arm64/boot/dts/exynos/exynosautov920-pinctrl.dtsi
> @@ -0,0 +1,1266 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Samsung's ExynosAutov920 SoC pin-mux and pin-config device tree source
> + *
> + * Copyright (c) 2023 Samsung Electronics Co., Ltd.
> + *
> + * Samsung's ExynosAutov920 SoC pin-mux and pin-config options are listed as
> + * device tree nodes in this file.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +#include "exynos-pinctrl.h"
> +
> +&pinctrl_alive {
> +	gpa0: gpa0-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	gpa1: gpa1-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	gpq0: gpq0-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +};
> +
> +&pinctrl_aud {
> +	gpb0: gpb0-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gpb1: gpb1-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gpb2: gpb2-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gpb3: gpb3-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gpb4: gpb4-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gpb5: gpb5-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gpb6: gpb6-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +};
> +
> +&pinctrl_hsi0 {
> +	gph0: gph0-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gph1: gph1-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +};
> +
> +&pinctrl_hsi1 {
> +	gph8: gph8-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +};
> +
> +&pinctrl_hsi2 {
> +	gph3: gph3-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gph4: gph4-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gph5: gph5-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gph6: gph6-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +};
> +
> +&pinctrl_hsi2ufs {
> +	gph2: gph2-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	ufs_rst_n: ufs-rst-n-pins {
> +		samsung,pins = "gph2-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-con-pdn = <EXYNOS_PIN_PULL_DOWN>;
> +	};
> +
> +	ufs_refclk_out: ufs-refclk-out-pins {
> +		samsung,pins = "gph2-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-con-pdn = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	ufs_rst_n_1: ufs-rst-n-1-pins {
> +		samsung,pins = "gph2-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-con-pdn = <EXYNOS_PIN_PULL_DOWN>;
> +	};
> +
> +	ufs_refclk_out_1: ufs-refclk-out-1-pins {
> +		samsung,pins = "gph2-2";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-con-pdn = <EXYNOS_PIN_PULL_DOWN>;
> +	};
> +};
> +
> +&pinctrl_peric0 {
> +	gpp0: gpp0-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gpp1: gpp1-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gpp2: gpp2-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gpp3: gpp3-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gpp4: gpp4-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gpg0: gpg0-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gpg2: gpg2-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gpg3: gpg3-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gpg4: gpg4-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gpg5: gpg5-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	/* UART PERIC0_USI00 */
> +	uart0_bus: uart0-bus-pins {
> +		samsung,pins = "gpp0-0", "gpp0-1", "gpp0-2", "gpp0-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	uart0_bus_dual: uart0-bus-dual-pins {
> +		samsung,pins = "gpp0-0", "gpp0-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* UART PERIC0_USI01 */
> +	uart1_bus: uart1-bus-pins {
> +		samsung,pins = "gpp0-4", "gpp0-5", "gpp0-6", "gpp0-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	uart1_bus_dual: uart1-bus-dual-pins {
> +		samsung,pins = "gpp0-4", "gpp0-5";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* UART PERIC0_USI02 */
> +	uart2_bus: uart2-bus-pins {
> +		samsung,pins = "gpp1-0", "gpp1-1", "gpp1-2", "gpp1-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	uart2_bus_dual: uart2-bus-dual-pins {
> +		samsung,pins = "gpp1-0", "gpp1-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* UART PERIC0_USI03 */
> +	uart3_bus: uart3-bus-pins {
> +		samsung,pins = "gpp1-4", "gpp1-5", "gpp1-6", "gpp1-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	uart3_bus_dual: uart3-bus-dual-pins {
> +		samsung,pins = "gpp1-4", "gpp1-5";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* UART PERIC0_USI04 */
> +	uart4_bus: uart4-bus-pins {
> +		samsung,pins = "gpp2-0", "gpp2-1", "gpp2-2", "gpp2-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	uart4_bus_dual: uart4-bus-dual-pins {
> +		samsung,pins = "gpp2-0", "gpp2-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* UART PERIC0_USI05 */
> +	uart5_bus: uart5-bus-pins {
> +		samsung,pins = "gpp2-4", "gpp2-5", "gpp2-6", "gpp2-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	uart5_bus_dual: uart5-bus-dual-pins {
> +		samsung,pins = "gpp2-4", "gpp2-5";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* UART PERIC0_USI06 */
> +	uart6_bus: uart6-bus-pins {
> +		samsung,pins = "gpp3-0", "gpp3-1", "gpp3-2", "gpp3-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	uart6_bus_dual: uart6-bus-dual-pins {
> +		samsung,pins = "gpp3-0", "gpp3-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* UART PERIC0_USI07 */
> +	uart7_bus: uart7-bus-pins {
> +		samsung,pins = "gpp3-4", "gpp3-5", "gpp3-6", "gpp3-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	uart7_bus_dual: uart7-bus-dual-pins {
> +		samsung,pins = "gpp3-4", "gpp3-5";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* UART PERIC0_USI08 */
> +	uart8_bus: uart8-bus-pins {
> +		samsung,pins = "gpp4-0", "gpp4-1", "gpp4-2", "gpp4-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	uart8_bus_dual: uart8-bus-dual-pins {
> +		samsung,pins = "gpp4-0", "gpp4-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC0 USI00  */
> +	hsi2c0_bus: hsi2c0-bus-pins {
> +		samsung,pins = "gpp0-0", "gpp0-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC0 USI00_I2C */
> +	hsi2c1_bus: hsi2c1-bus-pins {
> +		samsung,pins = "gpp0-2", "gpp0-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC0 USI01 */
> +	hsi2c2_bus: hsi2c2-bus-pins {
> +		samsung,pins = "gpp0-4", "gpp0-5";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC0 USI01_I2C */
> +	hsi2c3_bus: hsi2c3-bus-pins {
> +		samsung,pins = "gpp0-6", "gpp0-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC0 USI02 */
> +	hsi2c4_bus: hsi2c4-bus-pins {
> +		samsung,pins = "gpp1-0", "gpp1-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC0 USI02_I2C */
> +	hsi2c5_bus: hsi2c5-bus-pins {
> +		samsung,pins = "gpp1-2", "gpp1-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC0 USI03 */
> +	hsi2c6_bus: hsi2c6-bus-pins {
> +		samsung,pins = "gpp1-4", "gpp1-5";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC0 USI03_I2C */
> +	hsi2c7_bus: hsi2c7-bus-pins {
> +		samsung,pins = "gpp1-6", "gpp1-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC0 USI04 */
> +	hsi2c8_bus: hsi2c8-bus-pins {
> +		samsung,pins = "gpp2-0", "gpp2-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC0 USI04_I2C */
> +	hsi2c9_bus: hsi2c9-bus-pins {
> +		samsung,pins = "gpp2-2", "gpp2-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC0 USI05 */
> +	hsi2c10_bus: hsi2c10-bus-pins {
> +		samsung,pins = "gpp2-4", "gpp2-5";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC0 USI05_I2C */
> +	hsi2c11_bus: hsi2c11-bus-pins {
> +		samsung,pins = "gpp2-6", "gpp2-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC0 USI06 */
> +	hsi2c12_bus: hsi2c12-bus-pins {
> +		samsung,pins = "gpp3-0", "gpp3-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC0 USI06_I2C */
> +	hsi2c13_bus: hsi2c13-bus-pins {
> +		samsung,pins = "gpp3-2", "gpp3-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC0 USI07 */
> +	hsi2c14_bus: hsi2c14-bus-pins {
> +		samsung,pins = "gpp3-4", "gpp3-5";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC0 USI07_I2C */
> +	hsi2c15_bus: hsi2c15-bus-pins {
> +		samsung,pins = "gpp3-6", "gpp3-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC0 USI08 */
> +	hsi2c16_bus: hsi2c16-bus-pins {
> +		samsung,pins = "gpp4-0", "gpp4-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC0 USI08_I2C */
> +	hsi2c17_bus: hsi2c17-bus-pins {
> +		samsung,pins = "gpp4-2", "gpp4-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* SPI PERIC0 USI00 */
> +	spi0_bus: spi0-bus-pins {
> +		samsung,pins = "gpp0-0", "gpp0-1", "gpp0-2";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi0_cs: spi0-cs-pins {
> +		samsung,pins = "gpp0-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi0_cs_func: spi0-cs-func-pins {
> +		samsung,pins = "gpp0-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* SPI PERIC0 USI01 */
> +	spi1_bus: spi1-bus-pins {
> +		samsung,pins = "gpp0-4", "gpp0-5", "gpp0-6";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi1_cs: spi1-cs-pins {
> +		samsung,pins = "gpp0-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi1_cs_func: spi1-cs-func-pins {
> +		samsung,pins = "gpp0-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* SPI PERIC0 USI02 */
> +	spi2_bus: spi2-bus-pins {
> +		samsung,pins = "gpp1-0", "gpp1-1", "gpp1-2";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi2_cs: spi2-cs-pins {
> +		samsung,pins = "gpp1-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi2_cs_func: spi2-cs-func-pins {
> +		samsung,pins = "gpp1-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* SPI PERIC0 USI03 */
> +	spi3_bus: spi3-bus-pins {
> +		samsung,pins = "gpp1-4", "gpp1-5", "gpp1-6";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi3_cs: spi3-cs-pins {
> +		samsung,pins = "gpp1-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi3_cs_func: spi3-cs-func-pins {
> +		samsung,pins = "gpp1-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* SPI PERIC0 USI04 */
> +	spi4_bus: spi4-bus-pins {
> +		samsung,pins = "gpp2-0", "gpp2-1", "gpp2-2";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi4_cs: spi4-cs-pins {
> +		samsung,pins = "gpp2-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi4_cs_func: spi4-cs-func-pins {
> +		samsung,pins = "gpp2-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* SPI PERIC0 USI05 */
> +	spi5_bus: spi5-bus-pins {
> +		samsung,pins = "gpp2-4", "gpp2-5", "gpp2-6";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi5_cs: spi5-cs-pins {
> +		samsung,pins = "gpp2-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi5_cs_func: spi5-cs-func-pins {
> +		samsung,pins = "gpp2-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* SPI PERIC0 USI06 */
> +	spi6_bus: spi6-bus-pins {
> +		samsung,pins = "gpp3-0", "gpp3-1", "gpp3-2";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi6_cs: spi6-cs-pins {
> +		samsung,pins = "gpp3-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi6_cs_func: spi6-cs-func-pins {
> +		samsung,pins = "gpp3-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* SPI PERIC0 USI07 */
> +	spi7_bus: spi7-bus-pins {
> +		samsung,pins = "gpp3-4", "gpp3-5", "gpp3-6";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi7_cs: spi7-cs-pins {
> +		samsung,pins = "gpp3-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi7_cs_func: spi7-cs-func-pins {
> +		samsung,pins = "gpp3-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* SPI PERIC0 USI08 */
> +	spi8_bus: spi8-bus-pins {
> +		samsung,pins = "gpp4-0", "gpp4-1", "gpp4-2";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi8_cs: spi8-cs-pins {
> +		samsung,pins = "gpp4-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi8_cs_func: spi8-cs-func-pins {
> +		samsung,pins = "gpp4-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I3C PERIC0 */
> +	i3c0_bus: i3c0-bus-pins {
> +		samsung,pins = "gpp2-6", "gpp2-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	i3c1_bus: i3c1-bus-pins {
> +		samsung,pins = "gpp3-2", "gpp3-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	i3c2_bus: i3c2-bus-pins {
> +		samsung,pins = "gpp3-6", "gpp3-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	i3c3_bus: i3c3-bus-pins {
> +		samsung,pins = "gpp4-2", "gpp4-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* PWM PERIC0 */
> +	pwm_tout0: pwm-tout0-pins {
> +		samsung,pins = "gpg0-0";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	pwm_tout1: pwm-tout1-pins {
> +		samsung,pins = "gpg0-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	pwm_tout2: pwm-tout2-pins {
> +		samsung,pins = "gpg0-2";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	pwm_tout3: pwm-tout3-pins {
> +		samsung,pins = "gpg0-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +};
> +
> +&pinctrl_peric1 {
> +	gpp5: gpp5-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gpp6: gpp6-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gpp7: gpp7-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gpp8: gpp8-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gpp9: gpp9-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gpp10: gpp10-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gpp11: gpp11-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gpp12: gpp12-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	gpg1: gpg1-gpio-bank {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	/* UART PERIC1 USI09 */
> +	uart9_bus: uart9-bus-pins {
> +		samsung,pins = "gpp5-0", "gpp5-1", "gpp5-2", "gpp5-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	uart9_bus_dual: uart9-bus-dual-pins {
> +		samsung,pins = "gpp5-0", "gpp5-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* UART PERIC1 USI10 */
> +	uart10_bus: uart10-bus-pins {
> +		samsung,pins = "gpp5-4", "gpp5-5", "gpp5-6", "gpp5-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	uart10_bus_dual: uart10-bus-dual-pins {
> +		samsung,pins = "gpp5-4", "gpp5-5";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* UART PERIC1 USI11 */
> +	uart11_bus: uart11-bus-pins {
> +		samsung,pins = "gpp10-0", "gpp10-1", "gpp10-2", "gpp10-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	uart11_bus_dual: uart11-bus-dual-pins {
> +		samsung,pins = "gpp10-0", "gpp10-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* UART PERIC1_USI12 */
> +	uart12_bus: uart12-bus-pins {
> +		samsung,pins = "gpp7-0", "gpp7-1", "gpp7-2", "gpp7-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	uart12_bus_dual: uart12-bus-dual-pins {
> +		samsung,pins = "gpp7-0", "gpp7-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* UART PERIC1_USI13 */
> +	uart13_bus: uart13-bus-pins {
> +		samsung,pins = "gpp7-4", "gpp7-5", "gpp7-6", "gpp7-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	uart13_bus_dual: uart13-bus-dual-pins {
> +		samsung,pins = "gpp7-4", "gpp7-5";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* UART PERIC1 USI14 */
> +	uart14_bus: uart14-bus-pins {
> +		samsung,pins = "gpp8-0", "gpp8-1", "gpp8-2", "gpp8-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	uart14_bus_dual: uart14-bus-dual-pins {
> +		samsung,pins = "gpp8-0", "gpp8-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* UART PERIC1 USI15 */
> +	uart15_bus: uart15-bus-pins {
> +		samsung,pins = "gpp11-0", "gpp11-1", "gpp11-2", "gpp11-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	uart15_bus_dual: uart15-bus-dual-pins {
> +		samsung,pins = "gpp11-0", "gpp11-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* UART PERIC1 USI16 */
> +	uart16_bus: uart16-bus-pins {
> +		samsung,pins = "gpp9-0", "gpp9-1", "gpp9-2", "gpp9-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	uart16_bus_dual: uart16-bus-dual-pins {
> +		samsung,pins = "gpp9-0", "gpp9-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* UART PERIC1 USI17 */
> +	uart17_bus: uart17-bus-pins {
> +		samsung,pins = "gpp12-0", "gpp12-1", "gpp12-2", "gpp12-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	uart17_bus_dual: uart17-bus-dual-pins {
> +		samsung,pins = "gpp12-0", "gpp12-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC1 USI09 */
> +	hsi2c18_bus: hsi2c18-bus-pins {
> +		samsung,pins = "gpp5-0", "gpp5-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC1 USI09_I2C */
> +	hsi2c19_bus: hsi2c19-bus-pins {
> +		samsung,pins = "gpp5-2", "gpp5-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC1 USI10 */
> +	hsi2c20_bus: hsi2c20-bus-pins {
> +		samsung,pins = "gpp5-4", "gpp5-5";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC1 USI10_I2C */
> +	hsi2c21_bus: hsi2c21-bus-pins {
> +		samsung,pins = "gpp5-6", "gpp5-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC1 USI11 */
> +	hsi2c22_bus: hsi2c22-bus-pins {
> +		samsung,pins = "gpp10-0", "gpp10-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC1 USI11_I2C */
> +	hsi2c23_bus: hsi2c23-bus-pins {
> +		samsung,pins = "gpp10-2", "gpp10-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC1 USI12 */
> +	hsi2c24_bus: hsi2c24-bus-pins {
> +		samsung,pins = "gpp7-0", "gpp7-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC1 USI12_I2C */
> +	hsi2c25_bus: hsi2c25-bus-pins {
> +		samsung,pins = "gpp7-2", "gpp7-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC1 USI13 */
> +	hsi2c26_bus: hsi2c26-bus-pins {
> +		samsung,pins = "gpp7-4", "gpp7-5";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC1 USI13_I2C */
> +	hsi2c27_bus: hsi2c27-bus-pins {
> +		samsung,pins = "gpp7-6", "gpp7-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC1 USI14 */
> +	hsi2c28_bus: hsi2c28-bus-pins {
> +		samsung,pins = "gpp8-0", "gpp8-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC1 USI14_I2C */
> +	hsi2c29_bus: hsi2c29-bus-pins {
> +		samsung,pins = "gpp8-2", "gpp8-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC1 USI15 */
> +	hsi2c30_bus: hsi2c30-bus-pins {
> +		samsung,pins = "gpp11-0", "gpp11-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC1 USI15_I2C */
> +	hsi2c31_bus: hsi2c31-bus-pins {
> +		samsung,pins = "gpp11-2", "gpp11-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC1 USI16 */
> +	hsi2c32_bus: hsi2c32-bus-pins {
> +		samsung,pins = "gpp9-0", "gpp9-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC1 USI16_I2C */
> +	hsi2c33_bus: hsi2c33-bus-pins {
> +		samsung,pins = "gpp9-2", "gpp9-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC1 USI17 */
> +	hsi2c34_bus: hsi2c34-bus-pins {
> +		samsung,pins = "gpp12-0", "gpp12-1";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I2C PERIC1 USI17_I2C */
> +	hsi2c35_bus: hsi2c35-bus-pins {
> +		samsung,pins = "gpp12-2", "gpp12-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* SPI PERIC1 USI09 */
> +	spi9_bus: spi9-bus-pins {
> +		samsung,pins = "gpp5-0", "gpp5-1", "gpp5-2";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi9_cs: spi9-cs-pins {
> +		samsung,pins = "gpp5-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi9_cs_func: spi9-cs-func-pins {
> +		samsung,pins = "gpp5-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* SPI PERIC1 USI10 */
> +	spi10_bus: spi10-bus-pins {
> +		samsung,pins = "gpp5-4", "gpp5-5", "gpp5-6";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi10_cs: spi10-cs-pins {
> +		samsung,pins = "gpp5-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi10_cs_func: spi10-cs-func-pins {
> +		samsung,pins = "gpp5-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* SPI PERIC1 USI11 */
> +	spi11_bus: spi11-bus-pins {
> +		samsung,pins = "gpp10-0", "gpp10-1", "gpp10-2";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi11_cs: spi11-cs-pins {
> +		samsung,pins = "gpp10-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi11_cs_func: spi11-cs-func-pins {
> +		samsung,pins = "gpp10-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* SPI PERIC1 USI12 */
> +	spi12_bus: spi12-bus-pins {
> +		samsung,pins = "gpp7-0", "gpp7-1", "gpp7-2";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi12_cs: spi12-cs-pins {
> +		samsung,pins = "gpp7-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi12_cs_func: spi12-cs-func-pins {
> +		samsung,pins = "gpp7-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* SPI PERIC1 USI13 */
> +	spi13_bus: spi13-bus-pins {
> +		samsung,pins = "gpp7-4", "gpp7-5", "gpp7-6";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi13_cs: spi13-cs-pins {
> +		samsung,pins = "gpp7-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi13_cs_func: spi13-cs-func-pins {
> +		samsung,pins = "gpp7-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* SPI PERIC1 USI14 */
> +	spi14_bus: spi14-bus-pins {
> +		samsung,pins = "gpp8-0", "gpp8-1", "gpp8-2";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi14_cs: spi14-cs-pins {
> +		samsung,pins = "gpp8-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi14_cs_func: spi14-cs-func-pins {
> +		samsung,pins = "gpp8-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* SPI PERIC1 USI15 */
> +	spi15_bus: spi15-bus-pins {
> +		samsung,pins = "gpp11-0", "gpp11-1", "gpp11-2";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi15_cs: spi15-cs-pins {
> +		samsung,pins = "gpp11-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi15_cs_func: spi15-cs-func-pins {
> +		samsung,pins = "gpp11-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* SPI PERIC1 USI16 */
> +	spi16_bus: spi16-bus-pins {
> +		samsung,pins = "gpp9-0", "gpp9-1", "gpp9-2";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi16_cs: spi16-cs-pins {
> +		samsung,pins = "gpp9-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi16_cs_func: spi16-cs-func-pins {
> +		samsung,pins = "gpp9-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* SPI PERIC1 USI17 */
> +	spi17_bus: spi17-bus-pins {
> +		samsung,pins = "gpp12-0", "gpp12-1", "gpp12-2";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi17_cs: spi17-cs-pins {
> +		samsung,pins = "gpp12-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	spi17_cs_func: spi17-cs-func-pins {
> +		samsung,pins = "gpp12-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	/* I3C PERIC1 */
> +	i3c4_bus: i3c4-bus-pins {
> +		samsung,pins = "gpp7-2", "gpp7-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	i3c5_bus: i3c5-bus-pins {
> +		samsung,pins = "gpp7-6", "gpp7-7";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	i3c6_bus: i3c6-bus-pins {
> +		samsung,pins = "gpp8-2", "gpp8-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +
> +	i3c7_bus: i3c7-bus-pins {
> +		samsung,pins = "gpp11-2", "gpp11-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/exynos/exynosautov920.dtsi b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
> new file mode 100644
> index 000000000000..ec704fec323f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/exynos/exynosautov920.dtsi
> @@ -0,0 +1,318 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Samsung's ExynosAutov920 SoC device tree source
> + *
> + * Copyright (c) 2023 Samsung Electronics Co., Ltd.
> + *
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/soc/samsung,exynos-usi.h>
> +
> +/ {
> +	compatible = "samsung,exynosautov920";
> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +
> +	interrupt-parent = <&gic>;
> +
> +	aliases {
> +		pinctrl0 = &pinctrl_alive;
> +		pinctrl1 = &pinctrl_aud;
> +		pinctrl2 = &pinctrl_hsi0;
> +		pinctrl3 = &pinctrl_hsi1;
> +		pinctrl4 = &pinctrl_hsi2;
> +		pinctrl5 = &pinctrl_hsi2ufs;
> +		pinctrl6 = &pinctrl_peric0;
> +		pinctrl7 = &pinctrl_peric1;
> +	};
> +
> +	arm-pmu {
> +		compatible = "arm,cortex-a78-pmu";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	chosen: chosen {
> +		bootargs = "console=ttySAC0,115200n8 loglevel=3 printk.devkmsg=on log_buf_len=512K";

Drop bootargs. Instead use stdout path for console.

> +		linux,initrd-start = <0x85000000>;
> +		linux,initrd-end =   <0x8AFFFFFF>;

Lowercase hex please.

> +	};
> +
> +	cpus: cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +				core2 {
> +					cpu = <&cpu2>;
> +				};
> +				core3 {
> +					cpu = <&cpu3>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +				core2 {
> +					cpu = <&cpu2>;
> +				};
> +				core3 {
> +					cpu = <&cpu3>;
> +				};
> +			};
> +
> +			cluster2 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +			};
> +		};
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu1: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x0 0x100>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu2: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x0 0x200>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu3: cpu@300 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x0 0x300>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu4: cpu@10000 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x0 0x10000>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu5: cpu@10100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x0 0x10100>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu6: cpu@10200 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x0 0x10200>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu7: cpu@10300 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x0 0x10300>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu8: cpu@20000 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x0 0x20000>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu9: cpu@20100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78ae";
> +			reg = <0x0 0x20100>;
> +			enable-method = "psci";
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	timer {

Please keep the nodes sorted alphabetically, so this goes after "soc". I
know that not every Exynos files follows this convention, but let's try
to keep it for new ones.

> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 12 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	fixed-rate-clocks {

Drop the node and keep the clocks in top-level only.

> +		xtcxo: clock {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-output-names = "oscclk";
> +		};
> +
> +		/*
> +		 * Keep the stub clock for serial driver, until proper clock

Prefix with: FIXME:

> +		 * driver is implemented.
> +		 */
> +		usi_clock: usi-clock {

Node name: clock-usi

> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <200000000>;
> +			clock-output-names = "usi";
> +		};
> +	};
> +
> +	soc: soc@0 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x0 0x0 0x20000000>;
> +
> +		chipid@10000000 {
> +			compatible = "samsung,exynos850-chipid";

Let's add everywhere specific compatibles. I'll fix existing sources.

> +			reg = <0x10000000 0x24>;
> +		};
> +
> +		gic: interrupt-controller@10400000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			#address-cells = <0>;
> +			interrupt-controller;
> +			reg = <0x10400000 0x10000>,
> +			      <0x10460000 0x140000>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		pinctrl_alive: pinctrl@11850000 {
> +			compatible = "samsung,exynosautov920-pinctrl";
> +			reg = <0x11850000 0x10000>;
> +
> +			wakeup-interrupt-controller {
> +				compatible = "samsung,exynosautov920-wakeup-eint";
> +			};
> +		};
> +
> +		pinctrl_aud: pinctrl@1a460000 {
> +			compatible = "samsung,exynosautov920-pinctrl";
> +			reg = <0x1a460000 0x10000>;
> +		};
> +
> +		pinctrl_hsi0: pinctrl@16040000 {
> +			compatible = "samsung,exynosautov920-pinctrl";
> +			reg = <0x16040000 0x10000>;
> +			interrupts = <GIC_SPI 442 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		pinctrl_hsi1: pinctrl@16450000 {
> +			compatible = "samsung,exynosautov920-pinctrl";
> +			reg = <0x16450000 0x10000>;
> +			interrupts = <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		pinctrl_hsi2: pinctrl@16c10000 {
> +			compatible = "samsung,exynosautov920-pinctrl";
> +			reg = <0x16c10000 0x10000>;
> +			interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		pinctrl_hsi2ufs: pinctrl@16d20000 {
> +			compatible = "samsung,exynosautov920-pinctrl";
> +			reg = <0x16d20000 0x10000>;
> +			interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		pinctrl_peric0: pinctrl@10830000 {
> +			compatible = "samsung,exynosautov920-pinctrl";
> +			reg = <0x10830000 0x10000>;
> +			interrupts = <GIC_SPI 753 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		pinctrl_peric1: pinctrl@10c30000 {
> +			compatible = "samsung,exynosautov920-pinctrl";
> +			reg = <0x10c30000 0x10000>;
> +			interrupts = <GIC_SPI 781 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		pmu_system_controller: system-controller@11860000 {
> +			compatible = "samsung,exynos7-pmu", "syscon";

Specific compatible (with these fallbacks), please.

> +			reg = <0x11860000 0x10000>;
> +		};
> +
> +		pwm: pwm@109b0000 {
> +			compatible = "samsung,exynosautov920-pwm",
> +				     "samsung,exynos4210-pwm";
> +			reg = <0x109b0000 0x100>;
> +			samsung,pwm-outputs = <0>, <1>, <2>, <3>;
> +			#pwm-cells = <3>;
> +			clocks = <&xtcxo>;
> +			clock-names = "timers";
> +			status = "disabled";
> +		};
> +
> +		syscon_peric0: syscon@102820000 {
> +			compatible = "samsung,exynosautov920-peric0-sysreg",
> +				     "samsung,exynosautov920-sysreg", "syscon";

Drop "samsung,exynosautov920-sysreg"

> +			reg = <0x10820000 0x2000>;
> +		};
> +
> +		syscon_peric1: syscon@10c21000 {
> +			compatible = "samsung,exynosautov920-peric1-sysreg",
> +				     "samsung,exynosautov920-sysreg", "syscon";

Ditto

> +			reg = <0x10c21000 0x2000>;
> +		};
> +
> +		usi_0: usi@108800c0 {
> +			compatible = "samsung,exynosautov920-usi",
> +				     "samsung,exynos850-usi";
> +			reg = <0x108800c0 0x20>;
> +			samsung,sysreg = <&syscon_peric0 0x1000>;
> +			samsung,mode = <USI_V2_UART>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			clocks = <&usi_clock>, <&usi_clock>;
> +			clock-names = "pclk", "ipclk";
> +			status = "disabled";
> +


Best regards,
Krzysztof

