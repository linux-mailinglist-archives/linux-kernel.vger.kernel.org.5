Return-Path: <linux-kernel+bounces-25452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB1082D073
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 13:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF191C20C87
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 12:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3AD2107;
	Sun, 14 Jan 2024 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="jGPNlib4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nvhjS/Pt"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DD11FC4;
	Sun, 14 Jan 2024 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id BA97E5C011D;
	Sun, 14 Jan 2024 07:01:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 14 Jan 2024 07:01:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1705233703; x=1705320103; bh=NIDbSUe/VY05zfXFsXVGd3fhpNJG2RNs
	cv6cFSHMoho=; b=jGPNlib4CeHRkKxY6UHm3Je0FfiN1AtkHkrQcQBV8WBazxoJ
	nsMk5vU/F51GtpuVeVf9zrOva6q4P8j2jbxhjGAT/25x8Ir9tTQCiA3U8/Ha4SEZ
	FxwTz1CjF1NQkPVNedgJAVQR1GZ/yD0FN54/46QLkn/Yow/zSHIuEWg/XgDG3o8C
	X3VuXraLJk1jR67Waq1oOuvc8SWDZPCwo/8uao8cAYTlqcalbVErNtPq06E0eQIb
	V8ZDf11V2jTj0zijnEij3JYDd4PgvJBPCIZvkyPxmkU3o+Y3214btzXvClhjRbPo
	t/bdhWUlF4d2eQb7KDaWD8Bw5dMIrVk9U5SZqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1705233703; x=
	1705320103; bh=NIDbSUe/VY05zfXFsXVGd3fhpNJG2RNscv6cFSHMoho=; b=n
	vhjS/PtADMUsRRXwPCikeIxyyoyB2sCN5Vb9Fb3ui2DWMiD2b6IsHJWsS3BrbJO5
	JpaMoyPbHRL6trNLaMNynCwZQyGM5SvC4RdL+DMkSYmRj4XosrrpTb966miZmLVw
	sdRMx40weL++U0skRyqrD6t4e7jBKNaiMDgydKDyAQ6JizYVxQ+Vp7YAmU44eSfV
	G7Kv3sY08tI0AlsH6CWNCu2RBWQTOLSVs8ICmY0pUKKsnEWoGsSdv9Za42HuQD6N
	EHr3LaxYLj90DSkB7+6o5vL6IlpXnplKoPG3Df999NVZ+3fjwa1qOUvzCTy3dPpR
	9wvqj2mwrXr1+qFtUUFUg==
X-ME-Sender: <xms:Js2jZaL-xdhyI18DqcDzRp0odyXo3URQ0X91fS7BWnWSLBKcDVrJCg>
    <xme:Js2jZSITYbAo1ZYY_Fi_w1cEMcm_90sJQImeoimVDpckUnqk71TZFR1moLlv2SE0v
    ef9gWBh3w>
X-ME-Received: <xmr:Js2jZasJPmclZxV75V7YwEGvGyy1RRi4vAohJABBjVHW0NNbtAzbBmVMB1FBdRh6p4isGQGo04YHKG17tha8v7AFVehBFvtp-htwkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeiledgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhm
    ucfnuhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueegfefgveeuiedtheffgfefveejkeetiefhhfdvjeevlefhueekudeuleeghfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhimh
    esfhgvrghthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:Js2jZfYroSoLORR9qWaklWemgWodY4NLcockbzQsqrFEoAd6WCx8Kg>
    <xmx:Js2jZRaAKgted1xLzhJwwwS_JWurG9nBvOMAsGFueYTB6WrQfmy0-Q>
    <xmx:Js2jZbDpWpl8tBF2Shr-jg_eMduayvrhI_m0K1WqW8A3HdttUU-U0Q>
    <xmx:J82jZaLTx1-8Ge7hYUsYCoBIDZ84ves9f1syL4Lh6JW5dalguy4vRA>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Jan 2024 07:01:36 -0500 (EST)
Message-ID: <5774eb3f-dfdc-4e4d-985e-3ec4b69ad206@feathertop.org>
Date: Sun, 14 Jan 2024 23:01:32 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add Hardkernel ODROID-M1S board
Content-Language: en-US
To: KyuHyuk Lee <lee@kyuhyuk.kr>, Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Tianling Shen <cnsztl@gmail.com>, Chris Morgan <macromorgan@hotmail.com>,
 Ondrej Jirman <megi@xff.cz>, Andy Yan <andyshrk@163.com>,
 Jagan Teki <jagan@edgeble.ai>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 David Heidelberg <david@ixit.cz>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240112135004.28907-1-lee@kyuhyuk.kr>
From: Tim Lunn <tim@feathertop.org>
In-Reply-To: <20240112135004.28907-1-lee@kyuhyuk.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Lee,

On 1/13/24 00:50, KyuHyuk Lee wrote:
> This patch is to add a device tree for new board Hardkernel ODROID-M1S
> based on Rockchip RK3566, includes basic peripherals uart/eMMC/uSD/i2c
>
> Signed-off-by: KyuHyuk Lee <lee@kyuhyuk.kr>
> ---
>   arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>   .../boot/dts/rockchip/rk3566-odroid-m1s.dts   | 388 ++++++++++++++++++
>   2 files changed, 389 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-odroid-m1s.dts
>
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index a7b30e11beaf..0cc7360a6120 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -76,6 +76,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-anbernic-rg353ps.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-anbernic-rg353v.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-anbernic-rg353vs.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-anbernic-rg503.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-odroid-m1s.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.1.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-pinenote-v1.2.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-powkiddy-rgb30.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-odroid-m1s.dts b/arch/arm64/boot/dts/rockchip/rk3566-odroid-m1s.dts
> new file mode 100644
> index 000000000000..c6c4f573535f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-odroid-m1s.dts
> @@ -0,0 +1,388 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2024 KyuHyuk Lee <lee@kyuhyuk.kr>
> + *
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include "rk3566.dtsi"
> +
> +/ {
> +	model = "Hardkernel ODROID-M1S";
> +	compatible = "rockchip,rk3566-odroid-m1s", "rockchip,rk3566";
> +
> +	aliases {
> +		i2c0 = &i2c3;
> +		i2c3 = &i2c0;
> +		spi0 = &spi1;
> +		spi1 = &spi0;
> +		mmc0 = &sdmmc0;
> +		mmc1 = &sdhci;
> +		serial0 = &uart6;
> +		serial1 = &uart0;
> +		serial6 = &uart1;
> +	};
I suppose these mismatched aliases are here to keep compatibility with 
the Odroid M1? However thats going to be super confusing to anyone 
following the actual Odroid M1S connector pinout (even the pin card that 
came with my Odroid M1S doesnt show these mappings, but the actual real 
ports)?
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led_power: led-0 {
> +			gpios = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
> +			function = LED_FUNCTION_POWER;
> +			color = <LED_COLOR_ID_RED>;
> +			linux,default-trigger = "default-on";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&led_power_pin>;
> +		};
> +		led_work: led-1 {
> +			gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_HIGH>;
> +			function = LED_FUNCTION_HEARTBEAT;
> +			color = <LED_COLOR_ID_BLUE>;
> +			linux,default-trigger = "heartbeat";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&led_work_pin>;
> +		};
> +	};
> +
> +	vcc_sys: vcc-sys-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +
> +	vcc3v3_sys: vcc3v3-sys-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc5v0_sys: vcc5v0-sys-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&vcc_sys>;
> +	};
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu1 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu2 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu3 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	vdd_cpu: regulator@1c {
> +		compatible = "tcs,tcs452x";
This compatible seems to be from the Rockchip kernel, for mainline it 
should be  "tcs,tcs4525"?
> +		reg = <0x1c>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_cpu";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <712500>;
> +		regulator-max-microvolt = <1390000>;
> +		regulator-init-microvolt = <900000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc5v0_sys>;
I had checked schematics for this and they seem to show that this is
vin-supply = <&vcc3v3_sys>?
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +
> +	rk809: pmic@20 {
> +		compatible = "rockchip,rk809";
> +		reg = <0x20>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +		#clock-cells = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_int_l>;
> +		rockchip,system-power-controller;
> +		vcc1-supply = <&vcc3v3_sys>;
> +		vcc2-supply = <&vcc3v3_sys>;
> +		vcc3-supply = <&vcc3v3_sys>;
> +		vcc4-supply = <&vcc3v3_sys>;
> +		vcc5-supply = <&vcc3v3_sys>;
> +		vcc6-supply = <&vcc3v3_sys>;
> +		vcc7-supply = <&vcc3v3_sys>;
> +		vcc8-supply = <&vcc3v3_sys>;
> +		vcc9-supply = <&vcc3v3_sys>;
> +		wakeup-source;
> +
> +		regulators {
> +			vdd_logic: DCDC_REG1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-init-microvolt = <900000>;
> +				regulator-ramp-delay = <6001>;
> +				regulator-initial-mode = <0x2>;
> +				regulator-name = "vdd_logic";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_gpu: DCDC_REG2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-init-microvolt = <900000>;
> +				regulator-ramp-delay = <6001>;
> +				regulator-initial-mode = <0x2>;
> +				regulator-name = "vdd_gpu";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_ddr: DCDC_REG3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-initial-mode = <0x2>;
> +				regulator-name = "vcc_ddr";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vdd_npu: DCDC_REG4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-init-microvolt = <900000>;
> +				regulator-ramp-delay = <6001>;
> +				regulator-initial-mode = <0x2>;
> +				regulator-name = "vdd_npu";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda0v9_image: LDO_REG1 {
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-name = "vdda0v9_image";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda_0v9: LDO_REG2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-name = "vdda_0v9";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdda0v9_pmu: LDO_REG3 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-name = "vdda0v9_pmu";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <900000>;
> +				};
> +			};
> +
> +			vccio_acodec: LDO_REG4 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-name = "vccio_acodec";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vccio_sd: LDO_REG5 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vccio_sd";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc3v3_pmu: LDO_REG6 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-name = "vcc3v3_pmu";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <3300000>;
> +				};
> +			};
> +
> +			vcca_1v8: LDO_REG7 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcca_1v8";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcca1v8_ddr: LDO_REG8 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcca1v8_pmu";
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-microvolt = <1800000>;
> +				};
> +			};
> +
> +			vcca1v8_image: LDO_REG9 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcca1v8_image";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v8: DCDC_REG5 {
Maybe its just me, but seems odd that DCDC_REG5 is out of order with the 
other DCDC regulators above.
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-name = "vcc_1v8";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_3v3: SWITCH_REG1 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-name = "vcc_3v3";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc3v3_sd: SWITCH_REG2 {
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-name = "vcc3v3_sd";
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&pinctrl {
> +	leds {
> +		led_power_pin: led-power-pin {
> +			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +		led_work_pin: led-work-pin {
> +			rockchip,pins = <0 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
> +		};
> +	};
> +
> +	pmic {
> +		pmic_int_l: pmic-int-l {
> +			rockchip,pins =
> +				<0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +};
> +
> +&pmu_io_domains {
> +	pmuio2-supply = <&vcc3v3_pmu>;
> +	vccio1-supply = <&vccio_acodec>;
> +	vccio3-supply = <&vccio_sd>;
> +	vccio4-supply = <&vcc_3v3>;
> +	vccio5-supply = <&vcc_3v3>;
> +	vccio6-supply = <&vcc_3v3>;
> +	vccio7-supply = <&vcc_3v3>;
> +	status = "okay";
> +};
Did you miss pmuio1 and vccio2 here? the latter of which is the eMMC domain.

Are you planning to add additional patches for usb, gmac etc? I had been 
working through cleaning up these device tree files with a view to 
submitting them soon also.

Regards
    Tim

