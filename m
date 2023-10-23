Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0134E7D2D94
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjJWJFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjJWJFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:05:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF31A9;
        Mon, 23 Oct 2023 02:05:10 -0700 (PDT)
Received: from [100.94.55.57] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C0D536605638;
        Mon, 23 Oct 2023 10:05:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698051909;
        bh=K1gajUG5nCLZWafYty7WKQiuGF8tybFkXEIGrUugcEI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Dl+4B7PmTGTYTE1DtvS6rM+lpuakBby3T38D0y3Uf/b9s7nBgxq88rSdmApydsauT
         icKFMaAbthePZEn/xvUDOvehiWu6/HGsOnynRvCezcPdh3giiMYe4NUgmB3vhUM2Is
         hw6jXS9mdiYqhaRJGfIRaHmrmaJL1VXey6zja6KOMW8f3rO5ZxQo6cu9h56SQ/DupR
         wGlWkE+Up2RhVtx2aBmTlHEg+C2NPTUwAIwwaf09EzxKf03k9RVhWqHtw+RpbVOrEg
         kBHzdW0hNxxb+eQXqEwetKJeh8hw/8WdqKGnWPAsYBRt5QXjtyiPR1N/+3eDyFztnR
         R7YZM0pjinxug==
Message-ID: <60beb523-292b-4c77-9030-1bfdfd73c140@collabora.com>
Date:   Mon, 23 Oct 2023 12:05:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] arm64: dts: mediatek: Add MT8186 Krabby platform
 based Tentacruel / Tentacool
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231012230237.2676469-1-wenst@chromium.org>
 <20231012230237.2676469-7-wenst@chromium.org>
From:   Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20231012230237.2676469-7-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/23 02:02, Chen-Yu Tsai wrote:
> Tentacruel and Tentacool are MT8186 based Chromebooks based on the
> Krabby design.
> 
> Tentacruel, also known as the ASUS Chromebook CM14 Flip CM1402F, is a
> convertible device with touchscreen and stylus.
> 
> Tentacool, also known as the ASUS Chromebook CM14 CM1402C, is a laptop
> device. It does not have a touchscreen or stylus.
> 
> The two devices both have two variants. The difference is a second
> source touchpad controller that shares the same address as the original,
> but is incompatible.
> 
> The extra SKU IDs for the Tentacruel devices map to different sensor
> components attached to the Embedded Controller. These are not visible
> to the main processor.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile         |    4 +
>   .../dts/mediatek/mt8186-corsola-krabby.dtsi   |  130 ++
>   .../mt8186-corsola-tentacool-sku327681.dts    |   49 +
>   .../mt8186-corsola-tentacool-sku327683.dts    |   26 +
>   .../mt8186-corsola-tentacruel-sku262144.dts   |   44 +
>   .../mt8186-corsola-tentacruel-sku262148.dts   |   28 +
>   .../boot/dts/mediatek/mt8186-corsola.dtsi     | 1704 +++++++++++++++++
>   7 files changed, 1985 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327681.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327683.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index e6e7592a3645..442af61b1305 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -43,6 +43,10 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-kodama-sku32.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacool-sku327681.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacool-sku327683.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacruel-sku262144.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-corsola-tentacruel-sku262148.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8186-evb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r1.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-asurada-hayato-r5-sku2.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi
> new file mode 100644
> index 000000000000..0586c24f1e12
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2023 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8186-corsola.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	aliases {
> +		i2c4 = &i2c4;
> +	};
> +};
> +
> +&dsi_out {
> +	remote-endpoint = <&ps8640_in>;
> +};
> +
> +&i2c0 {
> +	clock-frequency = <400000>;
> +
> +	ps8640: edp-bridge@8 {
> +		compatible = "parade,ps8640";
> +		reg = <0x8>;
> +		powerdown-gpios = <&pio 96 GPIO_ACTIVE_LOW>;
> +		reset-gpios = <&pio 98 GPIO_ACTIVE_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ps8640_pins>;
> +		vdd12-supply = <&mt6366_vrf12_reg>;
> +		vdd33-supply = <&mt6366_vcn33_reg>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				ps8640_in: endpoint {
> +					remote-endpoint = <&dsi_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +
> +				ps8640_out: endpoint {
> +					remote-endpoint = <&panel_in>;
> +				};
> +			};
> +		};
> +
> +		aux-bus {
> +			panel {
> +				compatible = "edp-panel";
> +				power-supply = <&pp3300_disp_x>;
> +				backlight = <&backlight_lcd0>;
> +
> +				port {
> +					panel_in: endpoint {
> +						remote-endpoint = <&ps8640_out>;
> +					};
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	i2c-scl-internal-delay-ns = <10000>;
> +
> +	touchscreen: touchscreen@10 {
> +		compatible = "hid-over-i2c";
> +		reg = <0x10>;
> +		interrupts-extended = <&pio 12 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&touchscreen_pins>;
> +		post-power-on-delay-ms = <10>;
> +		hid-descr-addr = <0x0001>;
> +		vdd-supply = <&pp3300_s3>;
> +	};
> +};
> +
> +&i2c4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c4_pins>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	proximity@28 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sar_sensor_pins>;
> +		compatible = "semtech,sx9324";
> +		reg = <0x28>;
> +		interrupt-parent = <&pio>;
> +		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
> +		vdd-supply = <&mt6366_vio18_reg>;
> +		svdd-supply = <&mt6366_vio18_reg>;
> +		#io-channel-cells = <1>;
> +	};
> +};
> +
> +&pio {
> +	i2c4_pins: i2c4-pins {
> +		pins-bus {
> +			pinmux = <PINMUX_GPIO136__FUNC_SDA4>,
> +				 <PINMUX_GPIO135__FUNC_SCL4>;
> +			bias-disable;
> +			drive-strength = <4>;
> +			input-enable;
> +		};
> +	};
> +
> +	ps8640_pins: ps8640-pins {
> +		pins {
> +			pinmux = <PINMUX_GPIO96__FUNC_GPIO96>,
> +				 <PINMUX_GPIO98__FUNC_GPIO98>;
> +			output-low;
> +		};
> +	};
> +
> +	sar_sensor_pins: sar-sensor-pins {
> +		pin-irq {
> +			pinmux = <PINMUX_GPIO5__FUNC_GPIO5>;
> +			input-enable;
> +			bias-pull-up;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327681.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327681.dts
> new file mode 100644
> index 000000000000..8dfc24afabea
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327681.dts
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2023 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8186-corsola-krabby.dtsi"
> +
> +/ {
> +	model = "Google Tentacool board";
> +	compatible = "google,tentacruel-sku327681", "google,tentacruel", "mediatek,mt8186";
> +	chassis-type = "laptop";
> +};
> +
> +/delete-node/ &gpio_keys;
> +/delete-node/ &touchscreen;
> +
> +&i2c1 {
> +	status = "disabled";
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
> +		MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
> +		MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
> +		MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
> +		MATRIX_KEY(0x02, 0x09, KEY_MUTE)
> +		MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
> +		MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
> +		CROS_STD_MAIN_KEYMAP
> +	>;
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327683.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327683.dts
> new file mode 100644
> index 000000000000..9b10336ede06
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacool-sku327683.dts
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2023 Google LLC
> + */
> +
> +#include "mt8186-corsola-tentacool-sku327681.dts"
> +
> +/ {
> +	compatible = "google,tentacruel-sku327683", "google,tentacruel", "mediatek,mt8186";
> +};
> +
> +/* This variant replaces only the touchpad controller. */
> +&i2c2 {
> +	/delete-node/ touchpad@15;
> +
> +	touchpad@15 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&trackpad_pin>;
> +		compatible = "hid-over-i2c";
> +		reg = <0x15>;
> +		interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
> +		hid-descr-addr = <0x0001>;
> +		vcc-supply = <&pp3300_s3>;
> +		wakeup-source;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts
> new file mode 100644
> index 000000000000..26e9f19758cb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2022 Google LLC
> + */
> +
> +/dts-v1/;
> +#include "mt8186-corsola-krabby.dtsi"
> +
> +/ {
> +	model = "Google Tentacruel board";
> +	compatible = "google,tentacruel-sku262144", "google,tentacruel-sku262145",
> +		     "google,tentacruel-sku262146", "google,tentacruel-sku262147",
> +		     "google,tentacruel", "mediatek,mt8186";
> +	chassis-type = "convertible";
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
> +		MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
> +		MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
> +		MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
> +		MATRIX_KEY(0x02, 0x09, KEY_MUTE)
> +		MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
> +		MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
> +		CROS_STD_MAIN_KEYMAP
> +	>;
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dts
> new file mode 100644
> index 000000000000..59d4d21fc7d3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dts
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2022 Google LLC
> + */
> +
> +#include "mt8186-corsola-tentacruel-sku262144.dts"
> +
> +/ {
> +	compatible = "google,tentacruel-sku262144", "google,tentacruel-sku262145",
> +		     "google,tentacruel-sku262146", "google,tentacruel-sku262147",
> +		     "google,tentacruel", "mediatek,mt8186";
> +};
> +
> +/* This variant replaces only the touchpad controller. */
> +&i2c2 {
> +	/delete-node/ touchpad@15;
> +
> +	touchpad@15 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&trackpad_pin>;
> +		compatible = "hid-over-i2c";
> +		reg = <0x15>;
> +		interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
> +		hid-descr-addr = <0x0001>;
> +		vcc-supply = <&pp3300_s3>;
> +		wakeup-source;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> new file mode 100644
> index 000000000000..42ebab1bafeb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> @@ -0,0 +1,1704 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2022 MediaTek Inc.
> + */
> +/dts-v1/;
> +#include "mt8186.dtsi"
> +#include <dt-bindings/pinctrl/mt8186-pinfunc.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/input/gpio-keys.h>
> +
> +/ {
> +	aliases {
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
> +		i2c3 = &i2c3;
> +		i2c5 = &i2c5;
> +		mmc0 = &mmc0;
> +		mmc1 = &mmc1;
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		/* The size should be filled in by the bootloader. */
> +		reg = <0 0x40000000 0 0>;
> +	};
> +
> +	backlight_lcd0: backlight-lcd0 {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm0 0 500000>;
> +		power-supply = <&ppvar_sys>;
> +		enable-gpios = <&pio 152 0>;
> +		brightness-levels = <0 1023>;
> +		num-interpolated-steps = <1023>;
> +		default-brightness-level = <576>;
> +	};
> +
> +	btsco: bt-sco {
> +		compatible = "linux,bt-sco";
> +		#sound-dai-cells = <0>;
> +	};
> +
> +	dmic_codec: dmic-codec {
> +		compatible = "dmic-codec";
> +		num-channels = <2>;
> +		wakeup-delay-ms = <50>;
> +		#sound-dai-cells = <0>;
> +	};
> +
> +	gpio_keys: gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pen_eject>;
> +
> +		pen_insert: pen-insert-switch {
> +			label = "Pen Insert";
> +			/* Insert = low, eject = high */
> +			gpios = <&pio 18 GPIO_ACTIVE_LOW>;
> +			linux,code = <SW_PEN_INSERTED>;
> +			linux,input-type = <EV_SW>;
> +			wakeup-event-action = <EV_ACT_DEASSERTED>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	pp1800_dpbrdg_dx: regulator-pp1800-dpbrdg-dx {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&en_pp1800_dpbrdg>;
> +		regulator-name = "pp1800_dpbrdg_dx";
> +		enable-active-high;
> +		gpio = <&pio 39 GPIO_ACTIVE_HIGH>;
> +		vin-supply = <&mt6366_vio18_reg>;
> +	};
> +
> +	pp3300_disp_x: regulator-pp3300-disp-x {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp3300_disp_x";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&edp_panel_fixed_pins>;
> +		enable-active-high;
> +		regulator-boot-on;
> +		gpio = <&pio 153 GPIO_ACTIVE_HIGH>;
> +		vin-supply = <&pp3300_z2>;
> +	};
> +
> +	/* system wide LDO 3.3V power rail */
> +	pp3300_z5: regulator-pp3300-ldo-z5 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp3300_ldo_z5";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&ppvar_sys>;
> +	};
> +
> +	/* separately switched 3.3V power rail */
> +	pp3300_s3: regulator-pp3300-s3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp3300_s3";
> +		/* automatically sequenced by PMIC EXT_PMIC_EN2 */
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&pp3300_z2>;
> +	};
> +
> +	/* system wide 3.3V power rail */
> +	pp3300_z2: regulator-pp3300-z2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp3300_z2";
> +		/* EN pin tied to pp4200_z2, which is controlled by EC */
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&ppvar_sys>;
> +	};
> +
> +	/* system wide 4.2V power rail */
> +	pp4200_z2: regulator-pp4200-z2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp4200_z2";
> +		/* controlled by EC */
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <4200000>;
> +		regulator-max-microvolt = <4200000>;
> +		vin-supply = <&ppvar_sys>;
> +	};
> +
> +	/* system wide switching 5.0V power rail */
> +	pp5000_z2: regulator-pp5000-z2 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp5000_z2";
> +		/* controlled by EC */
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&ppvar_sys>;
> +	};
> +
> +	/* system wide semi-regulated power rail from battery or USB */
> +	ppvar_sys: regulator-ppvar-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "ppvar_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		adsp_dma_mem: memory@61000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x61000000 0 0x100000>;
> +			no-map;
> +		};
> +
> +		adsp_mem: memory@60000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x60000000 0 0xA00000>;
> +			no-map;
> +		};
> +
> +		scp_mem: memory@50000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0 0x50000000 0 0x10a0000>;
> +			no-map;
> +		};
> +	};
> +
> +	sound: sound {
> +		compatible = "mediatek,mt8186-mt6366-rt1019-rt5682s-sound";
> +		pinctrl-names = "aud_clk_mosi_off",
> +				"aud_clk_mosi_on",
> +				"aud_clk_miso_off",
> +				"aud_clk_miso_on",
> +				"aud_dat_miso_off",
> +				"aud_dat_miso_on",
> +				"aud_dat_mosi_off",
> +				"aud_dat_mosi_on",
> +				"aud_gpio_i2s0_off",
> +				"aud_gpio_i2s0_on",
> +				"aud_gpio_i2s1_off",
> +				"aud_gpio_i2s1_on",
> +				"aud_gpio_i2s2_off",
> +				"aud_gpio_i2s2_on",
> +				"aud_gpio_i2s3_off",
> +				"aud_gpio_i2s3_on",
> +				"aud_gpio_tdm_off",
> +				"aud_gpio_tdm_on",
> +				"aud_gpio_pcm_off",
> +				"aud_gpio_pcm_on",
> +				"aud_gpio_dmic_sec";
> +		pinctrl-0 = <&aud_clk_mosi_off>;
> +		pinctrl-1 = <&aud_clk_mosi_on>;
> +		pinctrl-2 = <&aud_clk_miso_off>;
> +		pinctrl-3 = <&aud_clk_miso_on>;
> +		pinctrl-4 = <&aud_dat_miso_off>;
> +		pinctrl-5 = <&aud_dat_miso_on>;
> +		pinctrl-6 = <&aud_dat_mosi_off>;
> +		pinctrl-7 = <&aud_dat_mosi_on>;
> +		pinctrl-8 = <&aud_gpio_i2s0_off>;
> +		pinctrl-9 = <&aud_gpio_i2s0_on>;
> +		pinctrl-10 = <&aud_gpio_i2s1_off>;
> +		pinctrl-11 = <&aud_gpio_i2s1_on>;
> +		pinctrl-12 = <&aud_gpio_i2s2_off>;
> +		pinctrl-13 = <&aud_gpio_i2s2_on>;
> +		pinctrl-14 = <&aud_gpio_i2s3_off>;
> +		pinctrl-15 = <&aud_gpio_i2s3_on>;
> +		pinctrl-16 = <&aud_gpio_tdm_off>;
> +		pinctrl-17 = <&aud_gpio_tdm_on>;
> +		pinctrl-18 = <&aud_gpio_pcm_off>;
> +		pinctrl-19 = <&aud_gpio_pcm_on>;
> +		pinctrl-20 = <&aud_gpio_dmic_sec>;
> +		mediatek,adsp = <&adsp>;
> +		mediatek,platform = <&afe>;
> +
> +		playback-codecs {
> +			sound-dai = <&it6505dptx>, <&rt1019p>;
> +		};
> +
> +		headset-codec {
> +			sound-dai = <&rt5682s 0>;
> +		};
> +	};
> +
> +	rt1019p: speaker-codec {
> +		compatible = "realtek,rt1019p";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&rt1019p_pins_default>;
> +		sdb-gpios = <&pio 150 GPIO_ACTIVE_HIGH>;
> +		#sound-dai-cells = <0>;
> +	};
> +
> +	usb_p1_vbus: regulator-usb-p1-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vbus1";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +		gpio = <&pio 148 GPIO_ACTIVE_HIGH>;
> +		vin-supply = <&pp5000_z2>;
> +	};
> +
> +	wifi_pwrseq: wifi-pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_enable_pin>;
> +		post-power-on-delay-ms = <50>;
> +		reset-gpios = <&pio 54 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	wifi_wakeup: wifi-wakeup {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wifi_wakeup_pin>;
> +
> +		wowlan-event {
> +			label = "Wake on WiFi";
> +			gpios = <&pio 7 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_WAKEUP>;
> +			wakeup-source;
> +		};
> +	};
> +};
> +
> +&adsp {
> +	memory-region = <&adsp_dma_mem>, <&adsp_mem>;
> +	status = "fail"; /* causes stall */
> +};
> +
> +&afe {
> +	i2s0-share = "I2S1";
> +	i2s3-share = "I2S2";
> +	status = "okay";
> +};
> +
> +&cci {
> +	proc-supply = <&mt6366_vproc12_reg>;
> +};
> +
> +&cpu0 {
> +	proc-supply = <&mt6366_vproc12_reg>;
> +};
> +
> +&cpu1 {
> +	proc-supply = <&mt6366_vproc12_reg>;
> +};
> +
> +&cpu2 {
> +	proc-supply = <&mt6366_vproc12_reg>;
> +};
> +
> +&cpu3 {
> +	proc-supply = <&mt6366_vproc12_reg>;
> +};
> +
> +&cpu4 {
> +	proc-supply = <&mt6366_vproc12_reg>;
> +};
> +
> +&cpu5 {
> +	proc-supply = <&mt6366_vproc12_reg>;
> +};
> +
> +&cpu6 {
> +	proc-supply = <&mt6366_vproc11_reg>;
> +};
> +
> +&cpu7 {
> +	proc-supply = <&mt6366_vproc11_reg>;
> +};
> +
> +&dpi {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&dpi_pins_default>;
> +	pinctrl-1 = <&dpi_pins_sleep>;
> +	status = "okay";
> +};
> +
> +&dpi_out {
> +	remote-endpoint = <&it6505_in>;
> +};
> +
> +&dsi0 {
> +	status = "okay";
> +};
> +
> +&gic {
> +	mediatek,broken-save-restore-fw;
> +};
> +
> +&gpu {
> +	mali-supply = <&mt6366_vgpu_reg>;
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pins>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
> +	clock-frequency = <400000>;
> +	i2c-scl-internal-delay-ns = <8000>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins>;
> +	clock-frequency = <400000>;
> +	i2c-scl-internal-delay-ns = <10000>;
> +	status = "okay";
> +
> +	touchpad@15 {
> +		compatible = "elan,ekth3000";
> +		reg = <0x15>;
> +		interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&trackpad_pin>;
> +		vcc-supply = <&pp3300_s3>;
> +		wakeup-source;
> +	};
> +};
> +
> +&i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c3_pins>;
> +	clock-frequency = <100000>;
> +	status = "okay";
> +
> +	it6505dptx: dp-bridge@5c {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&it6505_pins>;
> +		compatible = "ite,it6505";
> +		reg = <0x5c>;
> +		interrupts-extended = <&pio 8 IRQ_TYPE_LEVEL_LOW>;
> +		ovdd-supply = <&mt6366_vsim2_reg>;
> +		pwr18-supply = <&pp1800_dpbrdg_dx>;
> +		reset-gpios = <&pio 177 GPIO_ACTIVE_HIGH>;
> +		no-laneswap;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		#sound-dai-cells = <0>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +
> +				it6505_in: endpoint {
> +					link-frequencies = /bits/ 64 <150000000>;
> +					remote-endpoint = <&dpi_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c5_pins>;
> +	status = "okay";
> +
> +	rt5682s: codec@1a {
> +		compatible = "realtek,rt5682s";
> +		reg = <0x1a>;
> +		interrupts-extended = <&pio 17 IRQ_TYPE_EDGE_BOTH>;
> +		realtek,jd-src = <1>;
> +		AVDD-supply = <&mt6366_vio18_reg>;
> +		DBVDD-supply = <&mt6366_vio18_reg>;
> +		LDO1-IN-supply = <&mt6366_vio18_reg>;
> +		MICVDD-supply = <&pp3300_z2>;
> +		#sound-dai-cells = <1>;
> +	};
> +};
> +
> +&mfg0 {
> +	domain-supply = <&mt6366_vsram_gpu_reg>;
> +};
> +
> +&mfg1 {
> +	domain-supply = <&mt6366_vgpu_reg>;
> +};
> +
> +&mipi_tx0 {
> +	status = "okay";
> +};
> +
> +&mmc0 {
> +	pinctrl-names = "default", "state_uhs";
> +	pinctrl-0 = <&mmc0_pins_default>;
> +	pinctrl-1 = <&mmc0_pins_uhs>;
> +	bus-width = <8>;
> +	max-frequency = <200000000>;
> +	non-removable;
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
> +	supports-cqe;
> +	no-sd;
> +	no-sdio;
> +	cap-mmc-hw-reset;
> +	hs400-ds-delay = <0x11814>;
> +	mediatek,hs400-ds-dly3 = <0x14>;
> +	vmmc-supply = <&mt6366_vemc_reg>;
> +	vqmmc-supply = <&mt6366_vio18_reg>;
> +	status = "okay";
> +};
> +
> +&mmc1 {
> +	pinctrl-names = "default", "state_uhs", "state_eint";
> +	pinctrl-0 = <&mmc1_pins_default>;
> +	pinctrl-1 = <&mmc1_pins_uhs>;
> +	pinctrl-2 = <&mmc1_pins_eint>;
> +	/delete-property/ interrupts;
> +	interrupt-names = "msdc", "sdio_wakeup";
> +	interrupts-extended = <&gic GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH 0>,
> +			      <&pio 87 IRQ_TYPE_LEVEL_LOW>;
> +	bus-width = <4>;
> +	max-frequency = <200000000>;
> +	cap-sd-highspeed;
> +	sd-uhs-sdr104;
> +	sd-uhs-sdr50;
> +	keep-power-in-suspend;
> +	wakeup-source;
> +	cap-sdio-irq;
> +	no-mmc;
> +	no-sd;
> +	non-removable;
> +	vmmc-supply = <&pp3300_s3>;
> +	vqmmc-supply = <&mt6366_vio18_reg>;
> +	mmc-pwrseq = <&wifi_pwrseq>;
> +	status = "okay";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	bluetooth@2 {
> +		compatible = "mediatek,mt7921s-bluetooth";
> +		reg = <2>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_pins_reset>;
> +		reset-gpios = <&pio 155 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&nor_flash {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&nor_pins_default>;
> +	assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D7_D4>;
> +	status = "okay";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <39000000>;
> +	};
> +};
> +
> +&pio {
> +	/* 185 lines */
> +	gpio-line-names = "TP",
> +			  "TP",
> +			  "TP",
> +			  "I2S0_HP_DI",
> +			  "I2S3_DP_SPKR_DO",
> +			  "SAR_INT_ODL",
> +			  "BT_WAKE_AP_ODL",
> +			  "WIFI_INT_ODL",
> +			  "DPBRDG_INT_ODL",
> +			  "EDPBRDG_INT_ODL",
> +			  "EC_AP_HPD_OD",
> +			  "TCHPAD_INT_ODL",
> +			  "TCHSCR_INT_1V8_ODL",
> +			  "EC_AP_INT_ODL",
> +			  "EC_IN_RW_ODL",
> +			  "GSC_AP_INT_ODL",
> +			  /* AP_FLASH_WP_L is crossystem ABI. Rev1 schematics call it AP_WP_ODL. */
> +			  "AP_FLASH_WP_L",
> +			  "HP_INT_ODL",
> +			  "PEN_EJECT_OD",
> +			  "WCAM_PWDN_L",
> +			  "WCAM_RST_L",
> +			  "UCAM_SEN_EN",
> +			  "UCAM_RST_L",
> +			  "LTE_RESET_L",
> +			  "LTE_SAR_DETECT_L",
> +			  "I2S2_DP_SPK_MCK",
> +			  "I2S2_DP_SPKR_BCK",
> +			  "I2S2_DP_SPKR_LRCK",
> +			  "I2S2_DP_SPKR_DI (TP)",
> +			  "EN_PP1000_EDPBRDG",
> +			  "EN_PP1800_EDPBRDG",
> +			  "EN_PP3300_EDPBRDG",
> +			  "UART_GSC_TX_AP_RX",
> +			  "UART_AP_TX_GSC_RX",
> +			  "UART_DBGCON_TX_ADSP_RX",
> +			  "UART_ADSP_TX_DBGCON_RX",
> +			  "EN_PP1000_DPBRDG",
> +			  "TCHSCR_REPORT_DISABLE",
> +			  "EN_PP3300_DPBRDG",
> +			  "EN_PP1800_DPBRDG",
> +			  "SPI_AP_CLK_EC",
> +			  "SPI_AP_CS_EC_L",
> +			  "SPI_AP_DO_EC_DI",
> +			  "SPI_AP_DI_EC_DO",
> +			  "SPI_AP_CLK_GSC",
> +			  "SPI_AP_CS_GSC_L",
> +			  "SPI_AP_DO_GSC_DI",
> +			  "SPI_AP_DI_GSC_DO",
> +			  "UART_DBGCON_TX_SCP_RX",
> +			  "UART_SCP_TX_DBGCON_RX",
> +			  "EN_PP1200_CAM_X",
> +			  "EN_PP2800A_VCM_X",
> +			  "EN_PP2800A_UCAM_X",
> +			  "EN_PP2800A_WCAM_X",
> +			  "WLAN_MODULE_RST_L",
> +			  "EN_PP1200_UCAM_X",
> +			  "I2S1_HP_DO",
> +			  "I2S1_HP_BCK",
> +			  "I2S1_HP_LRCK",
> +			  "I2S1_HP_MCK",
> +			  "TCHSCR_RST_1V8_L",
> +			  "SPI_AP_CLK_ROM",
> +			  "SPI_AP_CS_ROM_L",
> +			  "SPI_AP_DO_ROM_DI",
> +			  "SPI_AP_DI_ROM_DO",
> +			  "NC",
> +			  "NC",
> +			  "EMMC_STRB",
> +			  "EMMC_CLK",
> +			  "EMMC_CMD",
> +			  "EMMC_RST_L",
> +			  "EMMC_DATA0",
> +			  "EMMC_DATA1",
> +			  "EMMC_DATA2",
> +			  "EMMC_DATA3",
> +			  "EMMC_DATA4",
> +			  "EMMC_DATA5",
> +			  "EMMC_DATA6",
> +			  "EMMC_DATA7",
> +			  "AP_KPCOL0",
> +			  "NC",
> +			  "NC",
> +			  "NC",
> +			  "TP",
> +			  "SDIO_CLK",
> +			  "SDIO_CMD",
> +			  "SDIO_DATA0",
> +			  "SDIO_DATA1",
> +			  "SDIO_DATA2",
> +			  "SDIO_DATA3",
> +			  "NC",
> +			  "NC",
> +			  "NC",
> +			  "NC",
> +			  "NC",
> +			  "NC",
> +			  "EDPBRDG_PWREN",
> +			  "BL_PWM_1V8",
> +			  "EDPBRDG_RST_L",
> +			  "MIPI_DPI_CLK",
> +			  "MIPI_DPI_VSYNC",
> +			  "MIPI_DPI_HSYNC",
> +			  "MIPI_DPI_DE",
> +			  "MIPI_DPI_D0",
> +			  "MIPI_DPI_D1",
> +			  "MIPI_DPI_D2",
> +			  "MIPI_DPI_D3",
> +			  "MIPI_DPI_D4",
> +			  "MIPI_DPI_D5",
> +			  "MIPI_DPI_D6",
> +			  "MIPI_DPI_DA7",
> +			  "MIPI_DPI_D8",
> +			  "MIPI_DPI_D9",
> +			  "MIPI_DPI_D10",
> +			  "MIPI_DPI_D11",
> +			  "PCM_BT_CLK",
> +			  "PCM_BT_SYNC",
> +			  "PCM_BT_DI",
> +			  "PCM_BT_DO",
> +			  "JTAG_TMS_TP",
> +			  "JTAG_TCK_TP",
> +			  "JTAG_TDI_TP",
> +			  "JTAG_TDO_TP",
> +			  "JTAG_TRSTN_TP",
> +			  "CLK_24M_WCAM",
> +			  "CLK_24M_UCAM",
> +			  "UCAM_DET_ODL",
> +			  "AP_I2C_EDPBRDG_SCL_1V8",
> +			  "AP_I2C_EDPBRDG_SDA_1V8",
> +			  "AP_I2C_TCHSCR_SCL_1V8",
> +			  "AP_I2C_TCHSCR_SDA_1V8",
> +			  "AP_I2C_TCHPAD_SCL_1V8",
> +			  "AP_I2C_TCHPAD_SDA_1V8",
> +			  "AP_I2C_DPBRDG_SCL_1V8",
> +			  "AP_I2C_DPBRDG_SDA_1V8",
> +			  "AP_I2C_WLAN_SCL_1V8",
> +			  "AP_I2C_WLAN_SDA_1V8",
> +			  "AP_I2C_AUD_SCL_1V8",
> +			  "AP_I2C_AUD_SDA_1V8",
> +			  "AP_I2C_TPM_SCL_1V8",
> +			  "AP_I2C_UCAM_SDA_1V8",
> +			  "AP_I2C_UCAM_SCL_1V8",
> +			  "AP_I2C_UCAM_SDA_1V8",
> +			  "AP_I2C_WCAM_SCL_1V8",
> +			  "AP_I2C_WCAM_SDA_1V8",
> +			  "SCP_I2C_SENSOR_SCL_1V8",
> +			  "SCP_I2C_SENSOR_SDA_1V8",
> +			  "AP_EC_WARM_RST_REQ",
> +			  "AP_XHCI_INIT_DONE",
> +			  "USB3_HUB_RST_L",
> +			  "EN_SPKR",
> +			  "BEEP_ON",
> +			  "AP_EDP_BKLTEN",
> +			  "EN_PP3300_DISP_X",
> +			  "EN_PP3300_SDBRDG_X",
> +			  "BT_KILL_1V8_L",
> +			  "WIFI_KILL_1V8_L",
> +			  "PWRAP_SPI0_CSN",
> +			  "PWRAP_SPI0_CK",
> +			  "PWRAP_SPI0_MO",
> +			  "PWRAP_SPI0_MI",
> +			  "SRCLKENA0",
> +			  "SRCLKENA1",
> +			  "SCP_VREQ_VAO",
> +			  "AP_RTC_CLK32K",
> +			  "AP_PMIC_WDTRST_L",
> +			  "AUD_CLK_MOSI",
> +			  "AUD_SYNC_MOSI",
> +			  "AUD_DAT_MOSI0",
> +			  "AUD_DAT_MOSI1",
> +			  "AUD_CLK_MISO",
> +			  "AUD_SYNC_MISO",
> +			  "AUD_DAT_MISO0",
> +			  "AUD_DAT_MISO1",
> +			  "NC",
> +			  "NC",
> +			  "DPBRDG_PWREN",
> +			  "DPBRDG_RST_L",
> +			  "LTE_W_DISABLE_L",
> +			  "LTE_SAR_DETECT_L",
> +			  "EN_PP3300_LTE_X",
> +			  "LTE_PWR_OFF_L",
> +			  "LTE_RESET_L",
> +			  "TP",
> +			  "TP";
> +
> +	aud_clk_mosi_off: aud-clk-mosi-off-pins {
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO166__FUNC_GPIO166>,
> +				 <PINMUX_GPIO167__FUNC_GPIO167>;
> +			input-enable;
> +			bias-pull-down;
> +		};
> +	};
> +
> +	aud_clk_mosi_on: aud-clk-mosi-on-pins {
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO166__FUNC_AUD_CLK_MOSI>,
> +				 <PINMUX_GPIO167__FUNC_AUD_SYNC_MOSI>;
> +		};
> +	};
> +
> +	aud_clk_miso_off: aud-clk-miso-off-pins {
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO170__FUNC_GPIO170>,
> +				 <PINMUX_GPIO171__FUNC_GPIO171>;
> +			input-enable;
> +			bias-pull-down;
> +		};
> +	};
> +
> +	aud_clk_miso_on: aud-clk-miso-on-pins {
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO170__FUNC_AUD_CLK_MISO>,
> +				 <PINMUX_GPIO171__FUNC_AUD_SYNC_MISO>;
> +		};
> +	};
> +
> +	aud_dat_mosi_off: aud-dat-mosi-off-pins {
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO168__FUNC_GPIO168>,
> +				 <PINMUX_GPIO169__FUNC_GPIO169>;
> +			input-enable;
> +			bias-pull-down;
> +		};
> +	};
> +
> +	aud_dat_mosi_on: aud-dat-mosi-on-pins {
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO168__FUNC_AUD_DAT_MOSI0>,
> +				 <PINMUX_GPIO169__FUNC_AUD_DAT_MOSI1>;
> +		};
> +	};
> +
> +	aud_dat_miso_off: aud-dat-miso-off-pins {
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO172__FUNC_GPIO172>,
> +				 <PINMUX_GPIO173__FUNC_GPIO173>;
> +			input-enable;
> +			bias-pull-down;
> +		};
> +	};
> +
> +	aud_dat_miso_on: aud-dat-miso-on-pins {
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO172__FUNC_AUD_DAT_MISO0>,
> +				 <PINMUX_GPIO173__FUNC_AUD_DAT_MISO1>;
> +			input-schmitt-enable;
> +			bias-disable;
> +		};
> +	};
> +
> +	aud_gpio_i2s0_off: aud-gpio-i2s0-off-pins {
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO3__FUNC_GPIO3>;
> +		};
> +	};
> +
> +	aud_gpio_i2s0_on: aud-gpio-i2s0-on-pins {
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO3__FUNC_I2S0_DI>;
> +		};
> +	};
> +
> +	aud_gpio_i2s1_off: aud-gpio-i2s-off-pins {
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO56__FUNC_GPIO56>,
> +				 <PINMUX_GPIO57__FUNC_GPIO57>,
> +				 <PINMUX_GPIO58__FUNC_GPIO58>,
> +				 <PINMUX_GPIO59__FUNC_GPIO59>;
> +			output-low;
> +		};
> +	};
> +
> +	aud_gpio_i2s1_on: aud-gpio-i2s1-on-pins {
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO56__FUNC_I2S1_DO>,
> +				 <PINMUX_GPIO57__FUNC_I2S1_BCK>,
> +				 <PINMUX_GPIO58__FUNC_I2S1_LRCK>,
> +				 <PINMUX_GPIO59__FUNC_I2S1_MCK>;
> +		};
> +	};
> +
> +	aud_gpio_i2s2_off: aud-gpio-i2s2-off-pins {
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO26__FUNC_GPIO26>,
> +				 <PINMUX_GPIO27__FUNC_GPIO27>;
> +			output-low;
> +		};
> +	};
> +
> +	aud_gpio_i2s2_on: aud-gpio-i2s2-on-pins {
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO26__FUNC_I2S2_BCK>,
> +				 <PINMUX_GPIO27__FUNC_I2S2_LRCK>;
> +			drive-strength = <4>;
> +		};
> +	};
> +
> +	aud_gpio_i2s3_off: aud-gpio-i2s3-off-pins {
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO4__FUNC_GPIO4>;
> +			output-low;
> +		};
> +	};
> +
> +	aud_gpio_i2s3_on: aud-gpio-i2s3-on-pins {
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO4__FUNC_I2S3_DO>;
> +			drive-strength = <4>;
> +		};
> +	};
> +
> +	aud_gpio_tdm_off: aud-gpio-tdm-off-pins { };
> +
> +	aud_gpio_tdm_on: aud-gpio-tdm-on-pins { };

Hi Chen-Yu,

These two aud_gpio_tdm empty entries cause this message to be printed:

[   12.949519] mt8186_mt6366_rt1019_rt5682s sound: there is not valid 
maps for state aud_gpio_tdm_off
[   12.959025] mt8186_mt6366_rt1019_rt5682s sound: there is not valid 
maps for state aud_gpio_tdm_on


Eugen

[...]
