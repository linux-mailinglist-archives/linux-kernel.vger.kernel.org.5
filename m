Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEF37A1D62
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbjIOLZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbjIOLZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:25:02 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B801B0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:24:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401d10e3e54so21744875e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694777095; x=1695381895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gFNlM3sm9Ceqs9hdL9w4nzExbwDQwcXHrGj5mJ6Ls3Q=;
        b=lIgTSNBNQPdkrZvyOtrSolZGcTCnmy/NZNdzUpCuKwzU3n3ik8ab28nougEFRBBpsh
         xP5UtFP/FnntnNKuDdnnctGrO2/RTwGsH6m/bx/xqCaBuGXzL2SXKfvowOxzE9oClbAp
         grEeiVIBS0DRlJOicu88jW6v2o1ViyH96tcqFFyLqGB2P6AWKc1gK6mzZYfPw0+fbmkN
         CgUweOwlEIw9hiYlDdUjIhwJaO+uo5qSI4HQs0XLtasLMckdhqxEWZiKmfjBHy4NkBuy
         Tk2TCUs6k9XCasr2mRR8LsJWc3v0DeTc3a/FSzv09WAtIvncyf/yxH0vcyCFJ5N/Oj93
         DoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694777095; x=1695381895;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gFNlM3sm9Ceqs9hdL9w4nzExbwDQwcXHrGj5mJ6Ls3Q=;
        b=JwC2yKF1zwcWyfWmAVX+0YgePd19AQEiEhS+ZB4x8jltI+/2pc3Zedufog+hREixIo
         J1NJGNO7Cjy7bin8CldlvztkR0Aq/09KpaKUxlvO0PXbzSOyrX/u1iWGoCbKRXqk+WaQ
         Lxat00Ww6qegQMHrtpYf5zSMYVz2dBCYCiHBfDZGk5Xtx6A0a4ZEHaWO5tUizSZ+7BtR
         aWqliqn28qlwNBr1/tOwXWzOOVdp35x25DtYLIOI13hZZTaKLv9eoGSq7PbpZXfgLLCs
         NOV2iwK1qChyfV1vKsCiYl7XySoEjpQaK6ZBPwDzNH7vOQOMB+axhJFOANcLY/U1/geE
         UgfQ==
X-Gm-Message-State: AOJu0YyN8bGG/8ugLhF5pY1NWRziIFo5hHB4X+savM4djGLkvtzjgGUo
        jwYlgB7sGN9Y4/DCcoOyIU/aplJ5B0MiRdVXmy8=
X-Google-Smtp-Source: AGHT+IEf6WeL52jnQQ1+MYaZgOfT8hieasvQCrs9Rbs5A49yq5aTxUtst9ngawLorznka78ivHN6MA==
X-Received: by 2002:a05:600c:c5:b0:3fe:d852:7ff9 with SMTP id u5-20020a05600c00c500b003fed8527ff9mr1235045wmm.5.1694777095305;
        Fri, 15 Sep 2023 04:24:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c230700b003fefcbe7fa8sm4399498wmo.28.2023.09.15.04.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 04:24:54 -0700 (PDT)
Message-ID: <a1922840-75dc-ad19-d001-9718d73891a2@linaro.org>
Date:   Fri, 15 Sep 2023 13:24:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 34/42] ARM: dts: add Cirrus EP93XX SoC .dtsi
Content-Language: en-US
To:     nikita.shubin@maquefel.me, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
 <20230915-ep93xx-v4-34-a1d779dcec10@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915-ep93xx-v4-34-a1d779dcec10@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 10:11, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Add support for Cirrus Logic EP93XX SoC's family.
> 
> Co-developed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  arch/arm/boot/dts/cirrus/ep93xx.dtsi | 454 +++++++++++++++++++++++++++++++++++
>  1 file changed, 454 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/cirrus/ep93xx.dtsi b/arch/arm/boot/dts/cirrus/ep93xx.dtsi
> new file mode 100644
> index 000000000000..11ca6d6a190d
> --- /dev/null
> +++ b/arch/arm/boot/dts/cirrus/ep93xx.dtsi
> @@ -0,0 +1,454 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree file for Cirrus Logic systems EP93XX SoC
> + */
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/clock/cirrus,ep9301-clk.h>
> +/ {
> +	soc: soc {
> +		compatible = "simple-bus";
> +		ranges;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		syscon: syscon@80930000 {
> +			compatible = "cirrus,ep9301-syscon",
> +						 "syscon", "simple-mfd";

Odd indentation. Please align with opening "

> +			reg = <0x80930000 0x1000>;
> +
> +			eclk: clock-controller {
> +				compatible = "cirrus,ep9301-clk";
> +				#clock-cells = <1>;
> +				clocks = <&xtali>;
> +			};
> +
> +			pinctrl: pinctrl {
> +				compatible = "cirrus,ep9301-pinctrl";
> +
> +				spi_default_pins: pins-spi {
> +					function = "spi";
> +					groups = "ssp";

Please include one such entry in your bindings example, so it will be
validated. It would also help you in review - you would not get a
comment that pinctrl node is not used :/

> +				};
> +
> +				ac97_default_pins: pins-ac97 {
> +					function = "ac97";
> +					groups = "ac97";
> +				};
> +
> +				i2s_on_ssp_pins: pins-i2sonssp {
> +					function = "i2s";
> +					groups = "i2s_on_ssp";
> +				};
> +
> +				i2s_on_ac97_pins: pins-i2sonac97 {
> +					function = "i2s";
> +					groups = "i2s_on_ac97";
> +				};
> +
> +				gpio1_default_pins: pins-gpio1 {
> +					function = "gpio";
> +					groups = "gpio1agrp";
> +				};
> +
> +				pwm1_default_pins: pins-pwm1 {
> +					function = "pwm";
> +					groups = "pwm1";
> +				};
> +
> +				gpio2_default_pins: pins-gpio2 {
> +					function = "gpio";
> +					groups = "gpio2agrp";
> +				};
> +
> +				gpio3_default_pins: pins-gpio3 {
> +					function = "gpio";
> +					groups = "gpio3agrp";
> +				};
> +
> +				keypad_default_pins: pins-keypad {
> +					function = "keypad";
> +					groups = "keypadgrp";
> +				};
> +
> +				gpio4_default_pins: pins-gpio4 {
> +					function = "gpio";
> +					groups = "gpio4agrp";
> +				};
> +
> +				gpio6_default_pins: pins-gpio6 {
> +					function = "gpio";
> +					groups = "gpio6agrp";
> +				};
> +
> +				gpio7_default_pins: pins-gpio7 {
> +					function = "gpio";
> +					groups = "gpio7agrp";
> +				};
> +
> +				ide_default_pins: pins-ide {
> +					function = "pata";
> +					groups = "idegrp";
> +				};
> +
> +				lcd_on_dram0_pins: pins-rasteronsdram0 {
> +					function = "lcd";
> +					groups = "rasteronsdram0grp";
> +				};
> +
> +				lcd_on_dram3_pins: pins-rasteronsdram3 {
> +					function = "lcd";
> +					groups = "rasteronsdram3grp";
> +				};
> +			};
> +
> +			reboot {
> +				compatible = "cirrus,ep9301-reboot";
> +			};
> +		};
> +
> +		adc: adc@80900000 {
> +			compatible = "cirrus,ep9301-adc";
> +			reg = <0x80900000 0x28>;
> +			clocks = <&eclk EP93XX_CLK_ADC>;
> +			interrupt-parent = <&vic0>;
> +			interrupts = <30>;
> +			status = "disabled";
> +		};
> +
> +		/*
> +		 * The EP93XX expansion bus is a set of up to 7 each up to 16MB
> +		 * windows in the 256MB space from 0x50000000 to 0x5fffffff.
> +		 * But since we don't require to setup it in any way, we can
> +		 * represent it as a simple-bus.
> +		 */
> +		ebi: bus@80080000 {
> +			compatible = "simple-bus";
> +			reg = <0x80080000 0x20>;
> +			native-endian;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +		};
> +
> +		dma0: dma-controller@80000000 {
> +			compatible = "cirrus,ep9301-dma-m2p";
> +			reg = <0x80000000 0x0040>,
> +			      <0x80000040 0x0040>,
> +			      <0x80000080 0x0040>,
> +			      <0x800000c0 0x0040>,
> +			      <0x80000240 0x0040>,
> +			      <0x80000200 0x0040>,
> +			      <0x800002c0 0x0040>,
> +			      <0x80000280 0x0040>,
> +			      <0x80000340 0x0040>,
> +			      <0x80000300 0x0040>;
> +			clocks = <&eclk EP93XX_CLK_M2P0>,
> +				 <&eclk EP93XX_CLK_M2P1>,
> +				 <&eclk EP93XX_CLK_M2P2>,
> +				 <&eclk EP93XX_CLK_M2P3>,
> +				 <&eclk EP93XX_CLK_M2P4>,
> +				 <&eclk EP93XX_CLK_M2P5>,
> +				 <&eclk EP93XX_CLK_M2P6>,
> +				 <&eclk EP93XX_CLK_M2P7>,
> +				 <&eclk EP93XX_CLK_M2P8>,
> +				 <&eclk EP93XX_CLK_M2P9>;
> +			clock-names = "m2p0", "m2p1",
> +				      "m2p2", "m2p3",
> +				      "m2p4", "m2p5",
> +				      "m2p6", "m2p7",
> +				      "m2p8", "m2p9";
> +			interrupt-parent = <&vic0>;
> +			interrupts = <7>, <8>, <9>, <10>, <11>,
> +				<12>, <13>, <14>, <15>, <16>;
> +			#dma-cells = <1>;
> +		};
> +
> +		dma1: dma-controller@80000100 {
> +			compatible = "cirrus,ep9301-dma-m2m";
> +			reg = <0x80000100 0x0040>,
> +			      <0x80000140 0x0040>;
> +			clocks = <&eclk EP93XX_CLK_M2M0>,
> +				 <&eclk EP93XX_CLK_M2M1>;
> +			clock-names = "m2m0", "m2m1";
> +			interrupt-parent = <&vic0>;
> +			interrupts = <17>, <18>;
> +			#dma-cells = <1>;
> +		};
> +
> +		eth0: ethernet@80010000 {
> +			compatible = "cirrus,ep9301-eth";
> +			reg = <0x80010000 0x10000>;
> +			interrupt-parent = <&vic1>;
> +			interrupts = <7>;
> +			mdio0: mdio {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +
> +		gpio0: gpio@80840000 {
> +			compatible = "cirrus,ep9301-gpio";
> +			reg = <0x80840000 0x04>,
> +			      <0x80840010 0x04>,
> +			      <0x80840090 0x1c>;
> +			reg-names = "data", "dir", "intr";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			interrupt-parent = <&vic1>;
> +			interrupts = <27>;
> +		};
> +
> +		gpio1: gpio@80840004 {
> +			compatible = "cirrus,ep9301-gpio";
> +			reg = <0x80840004 0x04>,
> +			      <0x80840014 0x04>,
> +			      <0x808400ac 0x1c>;
> +			reg-names = "data", "dir", "intr";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			interrupt-parent = <&vic1>;
> +			interrupts = <27>;
> +		};
> +
> +		gpio2: gpio@80840008 {
> +			compatible = "cirrus,ep9301-gpio";
> +			reg = <0x80840008 0x04>,
> +			      <0x80840018 0x04>;
> +			reg-names = "data", "dir";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&gpio2_default_pins>;
> +			status = "disabled";

Why this node is disabled? Any dependencies/resources missing? Similar
questions to other gpio nodes.



Best regards,
Krzysztof

