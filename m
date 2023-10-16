Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013F17CA3E8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjJPJTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjJPJTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:19:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B23395;
        Mon, 16 Oct 2023 02:19:09 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 81F1A66072B4;
        Mon, 16 Oct 2023 10:19:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697447948;
        bh=a8ExAXFUZCdl3Gw3edqROo1Z8ae4VIqKoHtveZ3JlFw=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=ASObbna9fdXUS8XDC1p55qKLAgQf/E1C1z32U37Rpf6/MPFGR2O+mWjyeVxV0bLXl
         YCYjvmBFzv4tm378ZN3z+475yxtEUy8cxP7e0sMrh2EG7y78dye2uirDGSaX2yFL73
         zlNdAUR0ZO8mm8398aWLVkYfJ0jxPqd14NJl7lOeED8J+2+Q3ABbj/bYo3fF9uODYh
         UMQxjctZeMlFLVTyWmmR8YEihw2Cm4O9KzhmvKnAIex3CUgxxFeJDx7YoRPSEcfkVE
         8apFWUI4HjY0EkRN6cv5WQv2jhChK8B0csZ2K6g7gob6ER6M5s1kqESarjI0b95j3Z
         MJzVdlMwsUefg==
Message-ID: <07d89d63-0390-ae48-e4dd-9f6822f4d430@collabora.com>
Date:   Mon, 16 Oct 2023 11:19:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 6/9] arm64: dts: mediatek: Add MT8186 Krabby platform
 based Tentacruel / Tentacool
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231012230237.2676469-1-wenst@chromium.org>
 <20231012230237.2676469-7-wenst@chromium.org>
Content-Language: en-US
In-Reply-To: <20231012230237.2676469-7-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/10/23 01:02, Chen-Yu Tsai ha scritto:
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

Hello Chen-Yu,

Thanks for the patch! However, there are a few things to improve...

the general shape of this looks mostly fine, but there's some comment, check below.

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

pinctrl nodes at the beginning? Noupe. :-)

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

pins-pwrdn-rst

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

You don't need to delete the touchscreen node if you're disabling i2c1 entirely.
Besides, I'd rather see TS disabled by default, then enabled on a per-board-basis
as I think that this clarifies that "board X" has touchscreen, but "board Y" does
not, because it's "enabled" only on "board X".

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

All of them do have a WoWLAN event pin, but not all of them have got a pen
insertion pin... okay.

So, you should either set status = "disabled" to both and then enable them
in each board dts file, or you should merge them and delete the pen insertion
node wherever not present.

Using /delete-node/ is not wrong, of course, but I don't really like seeing
that... it's probably just boiling down to a personal preference, so, unless
you have strong opinions against that, I'd like to see the first suggestion
applied (status = disabled on all, enable on a per-board basis).


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

The adsp is default disabled, you don't need to set it to "fail", as this is
designed to work, not to fail, and this can be fixed.

When things cannot be "really" fixed, then I agree on setting status = "fail",
but again, this is not the case.

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

A "touchpad" is not an input device, it is a product name... so, this
is a "trackpad" instead :-)

> +		compatible = "elan,ekth3000";

Though, this compatible name is getting overridden in multiple cases, even if
the majority of the properties are effectively the same, as in, the interrupts
are the same, i2c addr is the same, power supplies are the same, pinctrl....
...what I would do here (even though it's a bit strange to see somehow) is...

trackpad: trackpad@15 {
	/* Compatible string is be filled in board specific dts files */
	reg = <0x15>;
	interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
	pinctrl-names = "default";
	pinctrl-0 = <&trackpad_pin>;
	vcc-supply = <&pp3300_s3>;
	wakeup-source;
}


In tentacruel-sku262144.dts:

&trackpad {
	compatible = "hid-over-i2c";
	hid-descr-addr = <0x0001>;
};


In tentacool-sku327683.dts:

&trackpad {
	compatible = "elan,ekth3000";
};


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

pinctrl-names, pinctrl-0 here

> +		no-laneswap;

The driver has this property, that's true, but I can't find that in the bindings.
Also, are you sure that we really need this?

Checking the it6505 driver, the lane swap could also be set/unset with
EXTCON_PROP_USB_TYPEC_POLARITY, check it6505_get_extcon_property()...

...but if we really need that property here, the bindings must have it.

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

I would move realtek,jd-src...

> +		AVDD-supply = <&mt6366_vio18_reg>;
> +		DBVDD-supply = <&mt6366_vio18_reg>;
> +		LDO1-IN-supply = <&mt6366_vio18_reg>;
> +		MICVDD-supply = <&pp3300_z2>;

...here... but I don't really have strong opinions about that.

> +		#sound-dai-cells = <1>;
> +	};
> +};
> +

..snip..

> +
> +	aud_clk_mosi_off: aud-clk-mosi-off-pins {
> +		pins-cmd-dat {

I'd say that those are pins-clk-sync instead.

> +			pinmux = <PINMUX_GPIO166__FUNC_GPIO166>,
> +				 <PINMUX_GPIO167__FUNC_GPIO167>;
> +			input-enable;
> +			bias-pull-down;
> +		};
> +	};
> +
> +	aud_clk_mosi_on: aud-clk-mosi-on-pins {
> +		pins-cmd-dat {

same

> +			pinmux = <PINMUX_GPIO166__FUNC_AUD_CLK_MOSI>,
> +				 <PINMUX_GPIO167__FUNC_AUD_SYNC_MOSI>;
> +		};
> +	};
> +
> +	aud_clk_miso_off: aud-clk-miso-off-pins {
> +		pins-cmd-dat {

and here, and for all pins referencing "FUNC_AUD_CLK" and "FUNC_AUD_SYNC".

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

pins-dat or pins-bus

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

pins-sdata

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

pins-clk-sdata

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

Those are bit and word clock pins: pins-clk

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

pins-sdata

> +			pinmux = <PINMUX_GPIO4__FUNC_I2S3_DO>;
> +			drive-strength = <4>;
> +		};
> +	};
> +
> +	aud_gpio_tdm_off: aud-gpio-tdm-off-pins { };
> +
> +	aud_gpio_tdm_on: aud-gpio-tdm-on-pins { };
> +
> +	aud_gpio_pcm_off: aud-gpio-pcm-off-pins {
> +		pins-cmd-dat {
> +			pinmux = <PINMUX_GPIO115__FUNC_GPIO115>,
> +				 <PINMUX_GPIO116__FUNC_GPIO116>,
> +				 <PINMUX_GPIO117__FUNC_GPIO117>,
> +				 <PINMUX_GPIO118__FUNC_GPIO118>;
> +			output-low;
> +		};
> +	};
> +
> +	aud_gpio_pcm_on: aud-gpio-pcm-on-pins {
> +		pins-cmd-dat {

pins-clk-dat

> +			pinmux = <PINMUX_GPIO115__FUNC_PCM_CLK>,
> +				 <PINMUX_GPIO116__FUNC_PCM_SYNC>,
> +				 <PINMUX_GPIO117__FUNC_PCM_DI>,
> +				 <PINMUX_GPIO118__FUNC_PCM_DO>;
> +		};
> +	};
> +
> +	aud_gpio_dmic_sec: aud-gpio-dmic-sec-pins {
> +		pins {
> +			pinmux = <PINMUX_GPIO23__FUNC_GPIO23>;
> +			output-low;
> +		};
> +	};
> +
> +	bt_pins_reset: bt-reset-pins {
> +		pins-bt-reset {
> +			pinmux = <PINMUX_GPIO155__FUNC_GPIO155>;
> +			output-high;
> +		};
> +	};
> +

..snip..

> +
> +	ec_ap_int: cros-ec-int-pins {
> +		pins1 {

pins-ec-ap-int-odl

> +			pinmux = <PINMUX_GPIO13__FUNC_GPIO13>;
> +			input-enable;
> +		};
> +	};
> +
> +	edp_panel_fixed_pins: edp-panel-fixed-pins {
> +		pins1 {

pins-vreg-en

> +			pinmux = <PINMUX_GPIO153__FUNC_GPIO153>;
> +			output-high;
> +		};
> +	};
> +
> +	en_pp1800_dpbrdg: en-pp1800-dpbrdg-pins {
> +		pins {

pins-vreg-en....

> +			pinmux = <PINMUX_GPIO39__FUNC_GPIO39>;
> +			output-low;
> +		};
> +	};
> +
> +	gsc_ap_int_odl: gsc-ap-int-odl-pins {

cr50_int: cr50-irq-default-pins {
	pins-gsc-ap-int-odl {
		...
	}
}

> +		pins1 {
> +			pinmux = <PINMUX_GPIO15__FUNC_GPIO15>;
> +			input-enable;
> +		};
> +	};
> +

..snip..

> +
> +	mmc1_pins_eint: mmc1-eint-pins {
> +		pins_dat1 {

pins-dat1

> +			pinmux = <PINMUX_GPIO87__FUNC_GPIO87>;
> +			input-enable;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
> +		};
> +	};
> +
> +	nor_pins_default: nor-default-pins {
> +		pins0 {

pins-clk-dat

> +			pinmux = <PINMUX_GPIO63__FUNC_SPINOR_IO0>,
> +				 <PINMUX_GPIO61__FUNC_SPINOR_CK>,
> +				 <PINMUX_GPIO64__FUNC_SPINOR_IO1>;
> +			drive-strength = <6>;
> +			bias-pull-down;
> +		};
> +
> +		pins1 {

pins-cs-dat

> +			pinmux = <PINMUX_GPIO62__FUNC_SPINOR_CS>,
> +				 <PINMUX_GPIO65__FUNC_SPINOR_IO2>,
> +				 <PINMUX_GPIO66__FUNC_SPINOR_IO3>;
> +			drive-strength = <6>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	pen_eject: pen-eject-pins {
> +		pins {
> +			pinmux = <PINMUX_GPIO18__FUNC_GPIO18>;
> +			input-enable;
> +			/* External pull-up. */
> +			bias-disable;
> +		};
> +	};
> +
> +	pwm0_pin: pwm0-default-pins {

pins-disp-pwm

> +		pins {
> +			pinmux = <PINMUX_GPIO97__FUNC_DISP_PWM>;
> +			output-high;
> +		};
> +	};
> +
> +	rt1019p_pins_default: rt1019p-default-pins {
> +		pins {

pins-sdb

> +			pinmux = <PINMUX_GPIO150__FUNC_GPIO150>;
> +			output-low;
> +		};
> +	};
> +
> +	scp_pins: scp-default-pins {
> +		pins-scp-uart {
> +			pinmux = <PINMUX_GPIO48__FUNC_TP_URXD2_AO>,
> +				 <PINMUX_GPIO49__FUNC_TP_UTXD2_AO>;
> +		};
> +	};
> +
> +	spi1_pins: spi1-pins {
> +		pins-spi {
> +			pinmux = <PINMUX_GPIO40__FUNC_SPI1_CLK_A>,
> +				 <PINMUX_GPIO41__FUNC_SPI1_CSB_A>,
> +				 <PINMUX_GPIO42__FUNC_SPI1_MO_A>,
> +				 <PINMUX_GPIO43__FUNC_SPI1_MI_A>;

Shouldn't MISO be pull-down?!

clk, mo, csb: bias-disable
mi: bias-pull-down

> +			bias-disable;
> +			input-enable;
> +		};
> +	};
> +
> +	spi2_pins: spi2-pins {
> +		pins-spi {
> +			pinmux = <PINMUX_GPIO44__FUNC_SPI2_CLK_A>,
> +				 <PINMUX_GPIO45__FUNC_GPIO45>,
> +				 <PINMUX_GPIO46__FUNC_SPI2_MO_A>,
> +				 <PINMUX_GPIO47__FUNC_SPI2_MI_A>;

Same question here.

P.S.: if yes, pins-cs-mosi-clk, pins-miso; if not, pins-bus.

> +			bias-disable;
> +			input-enable;
> +		};
> +	};
> +
> +	spmi_pins: spmi-pins {
> +		pins-spmi {

pins-bus

> +			pinmux = <PINMUX_GPIO183__FUNC_SPMI_SCL>,
> +				 <PINMUX_GPIO184__FUNC_SPMI_SDA>;
> +		};
> +	};
> +
> +	touchscreen_pins: touchscreen-pins {
> +		pins-irq {
> +			pinmux = <PINMUX_GPIO12__FUNC_GPIO12>;
> +			input-enable;
> +			bias-pull-up;
> +		};
> +
> +		pins-reset {
> +			pinmux = <PINMUX_GPIO60__FUNC_GPIO60>;
> +			output-high;
> +		};
> +
> +		pins-report-sw {
> +			pinmux = <PINMUX_GPIO37__FUNC_GPIO37>;
> +			output-low;
> +		};
> +	};
> +
> +	trackpad_pin: trackpad-default-pins {
> +		pins-int-n {
> +			pinmux = <PINMUX_GPIO11__FUNC_GPIO11>;
> +			input-enable;
> +			bias-disable; /* pulled externally */
> +		};
> +	};
> +
> +	wifi_enable_pin: wifi-enable-pins {
> +		pins-wifi-enable {
> +			pinmux = <PINMUX_GPIO54__FUNC_GPIO54>;
> +		};
> +	};
> +
> +	wifi_wakeup_pin: wifi-wakeup-pins {
> +		pins-wifi-wakeup {
> +			pinmux = <PINMUX_GPIO7__FUNC_GPIO7>;
> +			input-enable;
> +		};
> +	};
> +};
> +
> +&pwm0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm0_pin>;
> +	status = "okay";
> +};
> +
> +&pwrap {
> +	pmic {
> +		compatible = "mediatek,mt6366", "mediatek,mt6358";
> +		interrupt-controller;
> +		interrupts-extended = <&pio 201 IRQ_TYPE_LEVEL_HIGH>;
> +		#interrupt-cells = <2>;
> +
> +		mt6366codec: codec {
> +			compatible = "mediatek,mt6366-sound", "mediatek,mt6358-sound";
> +			Avdd-supply = <&mt6366_vaud28_reg>;
> +			mediatek,dmic-mode = <1>; /* one-wire */
> +		};
> +
> +		mt6366_regulators: regulators {
> +			compatible = "mediatek,mt6366-regulator", "mediatek,mt6358-regulator";
> +			vsys-ldo1-supply = <&pp4200_z2>;
> +			vsys-ldo2-supply = <&pp4200_z2>;
> +			vsys-ldo3-supply = <&pp4200_z2>;
> +			vsys-vcore-supply = <&pp4200_z2>;
> +			vsys-vdram1-supply = <&pp4200_z2>;
> +			vsys-vgpu-supply = <&pp4200_z2>;
> +			vsys-vmodem-supply = <&pp4200_z2>;
> +			vsys-vpa-supply = <&pp4200_z2>;
> +			vsys-vproc11-supply = <&pp4200_z2>;
> +			vsys-vproc12-supply = <&pp4200_z2>;
> +			vsys-vs1-supply = <&pp4200_z2>;
> +			vsys-vs2-supply = <&pp4200_z2>;
> +			vs1-ldo1-supply = <&mt6366_vs1_reg>;
> +			vs2-ldo1-supply = <&mt6366_vdram1_reg>;
> +			vs2-ldo2-supply = <&mt6366_vs2_reg>;
> +			vs2-ldo3-supply = <&mt6366_vs2_reg>;
> +
> +			vcore {
> +				regulator-name = "pp0750_dvdd_core";
> +				regulator-min-microvolt = <550000>;
> +				regulator-max-microvolt = <800000>;
> +				regulator-ramp-delay = <6250>;
> +				regulator-enable-ramp-delay = <200>;
> +				regulator-allowed-modes = <0 1>;
> +				regulator-always-on;
> +			};
> +
> +			mt6366_vdram1_reg: vdram1 {
> +				regulator-name = "pp1125_emi_vdd2";
> +				regulator-min-microvolt = <1125000>;
> +				regulator-max-microvolt = <1125000>;
> +				regulator-ramp-delay = <12500>;
> +				regulator-enable-ramp-delay = <0>;
> +				regulator-allowed-modes = <0 1>;
> +				regulator-always-on;
> +			};
> +
> +			mt6366_vgpu_reg: vgpu {
> +				regulator-name = "ppvar_dvdd_gpu";

Can we please rename this to "ppvar_dvdd_vgpu"?
The regulator coupler driver parses "vgpu"... :-)

> +				regulator-min-microvolt = <600000>;
> +				regulator-max-microvolt = <950000>;
> +				regulator-ramp-delay = <6250>;
> +				regulator-enable-ramp-delay = <200>;
> +				regulator-allowed-modes = <0 1>;

Couple this regulator with VSRAM, max spread 100000.

> +			};
> +

..snip..

> +
> +			mt6366_vsram_gpu_reg: vsram-gpu {
> +				regulator-name = "pp0900_dvdd_sram_gpu";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <1050000>;
> +				regulator-ramp-delay = <6250>;
> +				regulator-enable-ramp-delay = <240>;

Couple with VGPU, same max spread.

> +			};
> +
> +			mt6366_vsram_others_reg: vsram-others {
> +				regulator-name = "pp0900_dvdd_sram_core";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-ramp-delay = <6250>;
> +				regulator-enable-ramp-delay = <240>;
> +				regulator-always-on;
> +			};
> +
> +			mt6366_vsram_proc11_reg: vsram-proc11 {
> +				regulator-name = "pp0900_dvdd_sram_bc";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <1120000>;
> +				regulator-ramp-delay = <6250>;
> +				regulator-enable-ramp-delay = <240>;
> +				regulator-always-on;
> +			};
> +
> +			mt6366_vsram_proc12_reg: vsram-proc12 {
> +				regulator-name = "pp0900_dvdd_sram_lc";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <1120000>;
> +				regulator-ramp-delay = <6250>;
> +				regulator-enable-ramp-delay = <240>;
> +				regulator-always-on;
> +			};
> +
> +			vusb {
> +				regulator-name = "pp3070_vusb";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3070000>;
> +				regulator-enable-ramp-delay = <270>;
> +				regulator-always-on;
> +			};
> +
> +			vxo22 {
> +				regulator-name = "pp2240_vxo22";
> +				regulator-min-microvolt = <2200000>;
> +				regulator-max-microvolt = <2240000>;
> +				regulator-enable-ramp-delay = <120>;
> +				/* Feeds DCXO internally */
> +				regulator-always-on;
> +			};
> +		};
> +
> +		rtc {
> +			compatible = "mediatek,mt6366-rtc", "mediatek,mt6358-rtc";
> +		};
> +	};
> +};
> +
> +&scp {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&scp_pins>;
> +	firmware-name = "mediatek/mt8186/scp.img";
> +	memory-region = <&scp_mem>;
> +	status = "okay";
> +
> +	cros-ec-rpmsg {
> +		compatible = "google,cros-ec-rpmsg";
> +		mediatek,rpmsg-name = "cros-ec-rpmsg";
> +	};
> +};
> +
> +&spi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi1_pins>;
> +	mediatek,pad-select = <0>;
> +	status = "okay";
> +
> +	cros_ec: ec@0 {
> +		compatible = "google,cros-ec-spi";
> +		reg = <0>;
> +		spi-max-frequency = <1000000>;
> +		interrupt-parent = <&pio>;
> +		interrupts = <13 IRQ_TYPE_LEVEL_LOW>;

interrupts-extended please

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ec_ap_int>;
> +
> +		i2c_tunnel: i2c-tunnel {
> +			compatible = "google,cros-ec-i2c-tunnel";
> +			google,remote-bus = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		typec {
> +			compatible = "google,cros-ec-typec";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			usb_c0: connector@0 {
> +				compatible = "usb-c-connector";
> +				reg = <0>;
> +				label = "left";
> +				power-role = "dual";
> +				data-role = "host";
> +				try-power-role = "source";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@1 {
> +						reg = <1>;
> +
> +						typec_port0: endpoint { };
> +					};
> +				};
> +			};
> +
> +			usb_c1: connector@1 {
> +				compatible = "usb-c-connector";
> +				reg = <1>;
> +				label = "right";
> +				power-role = "dual";
> +				data-role = "host";
> +				try-power-role = "source";
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					port@1 {
> +						reg = <1>;
> +
> +						typec_port1: endpoint { };
> +					};
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&spi2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi2_pins>;
> +	cs-gpios = <&pio 45 GPIO_ACTIVE_LOW>;
> +	mediatek,pad-select = <0>;
> +	status = "okay";
> +
> +	cr50: cr50@0 {

Do we really need a phandle on cr50?

Also, I'd say tpm@0 instead.

> +		compatible = "google,cr50";
> +		reg = <0>;
> +		spi-max-frequency = <1000000>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gsc_ap_int_odl>;
> +		interrupt-parent = <&pio>;
> +		interrupts = <15 IRQ_TYPE_EDGE_RISING>;
> +	};
> +};
> +

Cheers!
Angelo
