Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D5D7914D4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 11:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243473AbjIDJhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 05:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjIDJhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 05:37:13 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F56ABF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 02:37:09 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9a65f9147ccso46117866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 02:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693820228; x=1694425028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TNgV3nJkCCtLxtR3FL/73lq5wJhtx2QLthTqjSeHDQ0=;
        b=UfL7Ejz1S4TwkiL0/6cuHyZe+8k+383LMHAWPKJmzZsQ0S6yLJEUnUXmMkhjbGWKQS
         N1Djh5JUI/UcAaTc7jY7QRkchXS2mL1etja0zrIC8GlLFRJb8LgpiRCBC6XBKk4HKs8g
         MdNd9eaIA2D+oBTHqvw8x0UcZLHUAA2x1wcPPHeEfwoaGXhB/P+wAoLo3SwPF297DPxf
         kOn+Ta5MMDJm6fOAO/Ghl5XssqbXQ8TV8dOBunYFz7Drc0IzzDKXv9UAWe3K0W+TgjcA
         Ubp+5rVU9eleh1KEBKWCUmDa3rjlPch3vSw64WtFUqlC8kn96RVddgnYf5y5DiznFbYR
         y8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693820228; x=1694425028;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNgV3nJkCCtLxtR3FL/73lq5wJhtx2QLthTqjSeHDQ0=;
        b=Dh9q8tfk96Dsa7mpZLRHJelR16hfOAQpMyiasmFbv5LafDIu2ejcF0Gb+ip0EQkrNz
         54j1bFFQCw6E/XwOPOzB5WmwKLcNStzoy0X1+B1efgHP/FXwu19VJ3HOHICKjW1guWKQ
         3QnAqZvh2PrO65o7Q0iRqaAGZABWHVCFjDPt2BnjkGH8ZXeN/6ifTFNAO1DimzbrqUm3
         x3u5i5cUwVm1F6U1uKE1IrjUnoM0IeRGltLjH0kRirO7LmzVxKcEQ/hXrF9Fyoivcn4i
         v2ot+Ut+4iVeeUMF4W5TUWk8bn9N0ZIPtwzpiABXUCGCe+Ceaq8seDrdjpDm0dUH3PVM
         S2iQ==
X-Gm-Message-State: AOJu0YwBuSLK5e9aPTR24d93f3LsTmkMxT6/VMgQshhny2HJrlskYjJm
        KSZ0hml5fXFDXYCPznky03K9lOZnnsaErbd6q1I=
X-Google-Smtp-Source: AGHT+IHDXruCEc17q5tzXZ6vJ34UQmaiOTd3tE7jQAcfzk8dE8WA4iafLY3XIOt9zeJAY3g8AnrcXg==
X-Received: by 2002:a17:906:9bc3:b0:9a4:6437:3256 with SMTP id de3-20020a1709069bc300b009a464373256mr6549706ejc.39.1693820227850;
        Mon, 04 Sep 2023 02:37:07 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id g3-20020a170906594300b0099cf44adf2csm5811167ejr.46.2023.09.04.02.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 02:37:07 -0700 (PDT)
Message-ID: <e5030f7d-707b-19ac-2e5a-26b0fb08afd9@linaro.org>
Date:   Mon, 4 Sep 2023 11:37:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: add device-tree for Genio 1200
 EVK board
Content-Language: en-US
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Ben Lok <ben.lok@mediatek.com>
References: <20230904092043.5157-1-macpaul.lin@mediatek.com>
 <20230904092043.5157-2-macpaul.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230904092043.5157-2-macpaul.lin@mediatek.com>
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

On 04/09/2023 11:20, Macpaul Lin wrote:
> Add basic device-tree for the Genio 1200 EVK board. The
> Demo board is made by MediaTek and has a MT8395 SoC (MT8195 family),
> associated with the MT6359 and MT6360 PMICs, and
> the MT7921 connectivity chip.
> 
> The IOs available on that board are:
> * 1 USB Type-C connector with DP aux mode support
> * 2 USB Type-A connector with a USB hub
> * 1 micro-USB port for gadget or OTG support
> * 1 full size HDMI RX and 1 full size HDMI TX connector
> * 1 micro SD slot
> * 40 pins header
> * SPI interface header
> * 1 M.2 slot
> * 1 audio jack
> * 1 micro-USB port for serial debug
> * 2 connectors for DSI displays, 1 of the DSI panel is installed
> * 3 connectors for CSI cameras
> * 1 connector for a eDP panel
> * 1 MMC storage
> * 1 Touch Panel (installed DSI display)
> * 1 M.2 slot for 5G dongle
> 
> This commit adds basic support in order to be able to boot.
> 
> Signed-off-by: Ben Lok <ben.lok@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile         |   1 +
>  .../boot/dts/mediatek/genio-1200-evk.dts      | 931 ++++++++++++++++++
>  2 files changed, 932 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/genio-1200-evk.dts
> 
> Notes for v1:
>  - This dts patch has been checked with 'make dtbs_check W=1', however, some
>    warnings are caused by mt8195.dtsi, should be fixed by separate patches. 
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index c99c3372a4b5..5bf29581f08b 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_MEDIATEK) += genio-1200-evk.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6779-evb.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/genio-1200-evk.dts
> new file mode 100644
> index 000000000000..696ad535ac8f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/genio-1200-evk.dts
> @@ -0,0 +1,931 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2023 MediaTek Inc.
> + * Author: Ben Lok <ben.lok@mediatek.com>
> + *	   Macpaul Lin <macpaul.lin@mediatek.com>
> + */
> +/dts-v1/;
> +
> +#include "mt8195.dtsi"
> +#include "mt6359.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pinctrl/mt8195-pinfunc.h>
> +#include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
> +#include <dt-bindings/spmi/spmi.h>
> +#include <dt-bindings/usb/pd.h>
> +
> +/ {
> +	model = "MediaTek Genio 1200 EVK-P1V2-EMMC";
> +	compatible = "mediatek,mt8395-evk", "mediatek,mt8195";

In the binding patch you said mt8395 is a SoC, so you miss here its
compatible.

> +
> +	aliases {
> +		serial0 = &uart0;
> +		ethernet0 = &eth;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:921600n8";
> +	};
> +
> +	firmware {
> +		optee {
> +			compatible = "linaro,optee-tz";
> +			method = "smc";
> +		};
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0x2 0x00000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		/* 12 MiB reserved for OP-TEE (BL32)

Use Linux coding style comments.


> +	can_clk: can-clk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <20000000>;
> +		clock-output-names = "can-clk";
> +	};
> +
> +	wifi_pwr_fixed_3v3: wifi-pwr-fixed-3v3 {

And this is not a regulator? All other nodes are called regulator-X

> +		compatible = "regulator-fixed";
> +		regulator-name = "wifi_pwr_fixed_3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&pio 135 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +};

....

> +
> +&i2c6 {
> +	clock-frequency = <400000>;
> +	pinctrl-0 = <&i2c6_pins>;
> +	pinctrl-names = "default";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	mt6360: mt6360@34 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		compatible = "mediatek,mt6360";
> +		reg = <0x34>;
> +		interrupts = <128 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-names = "IRQB";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		pinctrl-0 = <&mt6360_pins>;
> +
> +		charger {
> +			compatible = "mediatek,mt6360-chg";
> +			richtek,vinovp-microvolt = <14500000>;
> +
> +			otg_vbus_regulator: usb-otg-vbus-regulator {
> +				regulator-name = "usb-otg-vbus";
> +				regulator-min-microvolt = <4425000>;
> +				regulator-max-microvolt = <5825000>;
> +			};
> +		};
> +
> +		regulator {
> +			compatible = "mediatek,mt6360-regulator";
> +			LDO_VIN3-supply = <&mt6360_buck2>;
> +
> +			mt6360_buck1: buck1 {
> +				regulator-name = "emi_vdd2";
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP
> +							   MT6360_OPMODE_ULP>;
> +				regulator-always-on;
> +			};
> +
> +			mt6360_buck2: buck2 {
> +				regulator-name = "emi_vddq";
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP
> +							   MT6360_OPMODE_ULP>;
> +				regulator-always-on;
> +			};
> +
> +			mt6360_ldo1: ldo1 {
> +				regulator-name = "tp1_p3v0";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP>;
> +				regulator-always-on;
> +			};
> +
> +			mt6360_ldo2: ldo2 {
> +				regulator-name = "panel1_p1v8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP>;
> +			};
> +
> +			mt6360_ldo3: ldo3 {
> +				regulator-name = "vmc_pmu";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <3600000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP>;
> +			};
> +
> +			mt6360_ldo5: ldo5 {
> +				regulator-name = "vmch_pmu";
> +				regulator-min-microvolt = <2700000>;
> +				regulator-max-microvolt = <3600000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP>;
> +			};
> +
> +			/* This is a measure point, which name is mt6360_ldo1 on schematic */
> +			mt6360_ldo6: ldo6 {
> +				regulator-name = "mt6360_ldo1";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <2100000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP>;
> +			};
> +
> +			mt6360_ldo7: ldo7 {
> +				regulator-name = "emi_vmddr_en";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <2100000>;
> +				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
> +							   MT6360_OPMODE_LP>;
> +				regulator-always-on;
> +			};
> +		};
> +

Stray blank line

> +	};
> +};
> +
> +&spi1 {
> +	pinctrl-0 = <&spi1_pins>;
> +	pinctrl-names = "default";
> +	mediatek,pad-select = <0>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +	cs-gpios = <&pio 64 GPIO_ACTIVE_LOW>;
> +
> +	can0: can@0 {
> +		compatible = "microchip,mcp2518fd";
> +		reg = <0>;
> +		clocks = <&can_clk>;
> +		spi-max-frequency = <20000000>;
> +		interrupts-extended = <&pio 16 IRQ_TYPE_LEVEL_LOW>;
> +		vdd-supply = <&mt6359_vcn33_2_bt_ldo_reg>;
> +		xceiver-supply = <&mt6359_vcn33_2_bt_ldo_reg>;
> +	};
> +};
> +
> +&spi2 {
> +	pinctrl-0 = <&spi2_pins>;
> +	pinctrl-names = "default";
> +	mediatek,pad-select = <0>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +};
> +
> +&xhci0 {
> +	status = "okay";
> +};
> +
> +&xhci1 {
> +	vusb33-supply = <&mt6359_vusb_ldo_reg>;
> +	status = "okay";
> +};
> +
> +&xhci2 {
> +	vusb33-supply = <&mt6359_vusb_ldo_reg>;
> +	status = "okay";
> +};
> +
> +&xhci3 {
> +	vusb33-supply = <&mt6359_vusb_ldo_reg>;
> +	status = "okay";
> +};
> +
> +&u3port0 {
> +	status = "okay";
> +};
> +

You have quite surprising ordering of these overrides...

...

> +
> +&spmi {
> +	#address-cells = <2>;
> +	#size-cells = <0>;
> +
> +	mt6315_6: mt6315@6 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		compatible = "mediatek,mt6315-regulator";
> +		reg = <0x6 SPMI_USID>;
> +
> +		regulators {
> +			mt6315_6_vbuck1: vbuck1 {
> +				regulator-compatible = "vbuck1";
> +				regulator-name = "Vbcpu";
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <1193750>;
> +				regulator-enable-ramp-delay = <256>;
> +				regulator-allowed-modes = <0 1 2>;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +
> +	mt6315_7: mt6315@7 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +		compatible = "mediatek,mt6315-regulator";
> +		reg = <0x7 SPMI_USID>;
> +
> +		regulators {



Best regards,
Krzysztof

