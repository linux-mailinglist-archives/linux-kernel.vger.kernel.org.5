Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B648036B0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbjLDOaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345200AbjLDO3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:29:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25EB2111;
        Mon,  4 Dec 2023 06:27:51 -0800 (PST)
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B6C3B66071CC;
        Mon,  4 Dec 2023 14:27:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701700070;
        bh=yz/dDq9bb9uDrSpBnMtfAmIY+Qv4H+1o8lt6y7f7J0Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fajpySWzBgYqiq9bn24wRR1xU6EMDrzr8p+S6Nt4IcMA2nKXNCqEF+C0lSj0+qTlW
         Z9nZZkSBtSpUmNKBMdb99rrxcUovFjhboVUwfMWibOvC2hc0BCDNcQx5bnfY+3UD8Z
         b8SfUBYk6PqBeEdQ7B/nCgHQCrlMRcjoj7rN5ShuJBbLI1pBXhx3P6ViylFf/wmqv6
         dJ8lczPUs+D9YMeeLMHXX6kKXTWUFTYOyVMQwk58j1+CVEs7RPnlXlYdyJUmSvmlBs
         bWjp3QPTRVq48KIW5Va/2GVXoaI7KXdJhbRBWe6IKZPIKYAaeeuqVVRirHQAAuAa4i
         6a1qynlCmUjPw==
Message-ID: <7bed2f95-6fa6-4387-900b-82906eca3941@collabora.com>
Date:   Mon, 4 Dec 2023 15:27:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] arm64: dts: mediatek: Introduce MT8186 Steelix
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
References: <20231204084012.2281292-1-wenst@chromium.org>
 <20231204084012.2281292-8-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231204084012.2281292-8-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/12/23 09:40, Chen-Yu Tsai ha scritto:
> The MT8186 Steelix, also known as the Lenovo 300e Yoga Chromebook Gen 4,
> is a convertible device based on a common design of the same name. The
> device comes in different variants. Of them, whether a world facing
> camera is integrated is the only differentiating factor between the
> two device trees added. The different SKU IDs describe this alone.
> 
> The other device difference is the touchpad component used. This is
> simply handled by having both possible components described in the
> device tree, and letting the implementation figure out which one is
> actually available. The system bootloader / firmware does not
> differentiate this in that they share the same SKU IDs.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes since v2:
> - Picked up Conor's ack
> 
> Changes since v1:
> - Removed trackpad_pins reference (moved to i2c2 in corsola dtsi)
> - Fixed copyright year
> - Renamed touchpad to trackpad
> 
>   arch/arm64/boot/dts/mediatek/Makefile         |   2 +
>   .../mt8186-corsola-steelix-sku131072.dts      |  18 ++
>   .../mt8186-corsola-steelix-sku131073.dts      |  18 ++
>   .../dts/mediatek/mt8186-corsola-steelix.dtsi  | 195 ++++++++++++++++++
>   4 files changed, 233 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix-sku131072.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix-sku131073.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 442af61b1305..7bd9471b89f9 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -43,6 +43,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku32.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-steelix-sku131072.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-steelix-sku131073.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacool-sku327681.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacool-sku327683.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacruel-sku262144.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix-sku131072.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix-sku131072.dts
> new file mode 100644
> index 000000000000..eae17bca8585
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix-sku131072.dts
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2022 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8186-corsola-steelix.dtsi"
> +
> +/ {
> +	model = "Google Steelix board";
> +	compatible = "google,steelix-sku131072", "google,steelix",
> +		     "mediatek,mt8186";
> +	chassis-type = "convertible";
> +};
> +
> +&mt6366codec {
> +	mediatek,dmic-mode = <0>; /* two-wire */
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix-sku131073.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix-sku131073.dts
> new file mode 100644
> index 000000000000..a55375b95d0d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix-sku131073.dts
> @@ -0,0 +1,18 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2022 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8186-corsola-steelix.dtsi"
> +
> +/ {
> +	model = "Google Steelix board";
> +	compatible = "google,steelix-sku131073", "google,steelix",
> +		     "mediatek,mt8186";
> +	chassis-type = "convertible";
> +};
> +
> +&mt6366codec {
> +	mediatek,dmic-mode = <1>; /* one-wire */
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix.dtsi
> new file mode 100644
> index 000000000000..47262bc499ad
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-steelix.dtsi
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2022 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8186-corsola.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +
> +/{
> +	pp1000_edpbrdg: regulator-pp1000-edpbrdg {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp1000_edpbrdg";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&en_pp1000_edpbrdg>;
> +		enable-active-high;
> +		regulator-boot-on;
> +		gpio = <&pio 29 GPIO_ACTIVE_HIGH>;
> +		vin-supply = <&pp3300_z2>;
> +	};
> +
> +	pp1800_edpbrdg_dx: regulator-pp1800-edpbrdg-dx {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp1800_edpbrdg_dx";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&en_pp1800_edpbrdg>;
> +		enable-active-high;
> +		regulator-boot-on;
> +		gpio = <&pio 30 GPIO_ACTIVE_HIGH>;
> +		vin-supply = <&mt6366_vio18_reg>;
> +	};
> +
> +	pp3300_edp_dx: regulator-pp3300-edp-dx {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp3300_edp_dx";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&en_pp3300_edpbrdg>;
> +		enable-active-high;
> +		regulator-boot-on;
> +		gpio = <&pio 31 GPIO_ACTIVE_HIGH>;
> +		vin-supply = <&pp3300_z2>;
> +	};
> +};
> +
> +&dsi_out {
> +	remote-endpoint = <&anx7625_in>;
> +};
> +
> +&i2c0 {
> +	clock-frequency = <400000>;
> +
> +	anx_bridge: anx7625@58 {
> +		compatible = "analogix,anx7625";
> +		reg = <0x58>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&anx7625_pins>;
> +		enable-gpios = <&pio 96 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&pio 98 GPIO_ACTIVE_HIGH>;
> +		vdd10-supply = <&pp1000_edpbrdg>;
> +		vdd18-supply = <&pp1800_edpbrdg_dx>;
> +		vdd33-supply = <&pp3300_edp_dx>;
> +		analogix,lane0-swing = /bits/ 8 <0x70 0x30>;
> +		analogix,lane1-swing = /bits/ 8 <0x70 0x30>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				anx7625_in: endpoint {
> +					remote-endpoint = <&dsi_out>;
> +					data-lanes = <0 1 2 3>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +
> +				anx7625_out: endpoint {
> +					remote-endpoint = <&panel_in>;
> +				};
> +			};
> +		};
> +
> +		aux-bus {
> +			panel: panel {
> +				compatible = "edp-panel";
> +				power-supply = <&pp3300_disp_x>;
> +				backlight = <&backlight_lcd0>;
> +
> +				port {
> +					panel_in: endpoint {
> +						remote-endpoint = <&anx7625_out>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	touchscreen: touchscreen@5d {
> +		compatible = "goodix,gt7375p";
> +		reg = <0x5d>;
> +		interrupts-extended = <&pio 12 IRQ_TYPE_EDGE_FALLING>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&touchscreen_pins>;
> +		reset-gpios = <&pio 60 GPIO_ACTIVE_LOW>;
> +		vdd-supply = <&pp3300_s3>;
> +		goodix,no-reset-during-suspend;
> +	};
> +};
> +
> +&i2c2 {
> +	i2c-scl-internal-delay-ns = <22000>;
> +
> +	/* second source component */
> +	trackpad@2c {
> +		compatible = "hid-over-i2c";
> +		reg = <0x2c>;
> +		hid-descr-addr = <0x20>;
> +		interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
> +		vdd-supply = <&pp3300_s3>;
> +		wakeup-source;
> +	};
> +};
> +
> +&keyboard_controller {
> +	function-row-physmap = <
> +		MATRIX_KEY(0x00, 0x02, 0)	/* T1 */
> +		MATRIX_KEY(0x03, 0x02, 0)	/* T2 */
> +		MATRIX_KEY(0x02, 0x02, 0)	/* T3 */
> +		MATRIX_KEY(0x01, 0x02, 0)	/* T4 */
> +		MATRIX_KEY(0x03, 0x04, 0)	/* T5 */
> +		MATRIX_KEY(0x02, 0x04, 0)	/* T6 */
> +		MATRIX_KEY(0x01, 0x04, 0)	/* T7 */
> +		MATRIX_KEY(0x02, 0x09, 0)	/* T8 */
> +		MATRIX_KEY(0x01, 0x09, 0)	/* T9 */
> +		MATRIX_KEY(0x00, 0x04, 0)	/* T10 */
> +	>;
> +
> +	linux,keymap = <
> +		MATRIX_KEY(0x00, 0x02, KEY_BACK)
> +		MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
> +		MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
> +		MATRIX_KEY(0x01, 0x02, KEY_SCALE)
> +		MATRIX_KEY(0x03, 0x04, KEY_BRIGHTNESSDOWN)
> +		MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSUP)
> +		MATRIX_KEY(0x01, 0x04, KEY_MICMUTE)
> +		MATRIX_KEY(0x02, 0x09, KEY_MUTE)
> +		MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
> +		MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
> +		CROS_STD_MAIN_KEYMAP
> +	>;
> +};
> +
> +&pio {
> +	anx7625_pins: anx7625-pins {
> +		pins1 {

en-rst-pins

> +			pinmux = <PINMUX_GPIO96__FUNC_GPIO96>,
> +				 <PINMUX_GPIO98__FUNC_GPIO98>;
> +			output-low;
> +		};
> +
> +		pins2 {

GPIO9 is not referenced anywhere, what is it for?

> +			pinmux = <PINMUX_GPIO9__FUNC_GPIO9>;
> +			input-enable;
> +			bias-disable;
> +		};
> +	};
> +
> +	en_pp1000_edpbrdg: pp1000-edpbrdg-en-pins {

pp1000-edpbrdg-pins {
	en-pins {

"Same" for the other two vreg en pins.

Cheers,
Angelo
