Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B3B79B291
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376326AbjIKWTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbjIKJJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:09:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14012CCC;
        Mon, 11 Sep 2023 02:09:45 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 266D26607083;
        Mon, 11 Sep 2023 10:09:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694423383;
        bh=tu3UTPUjv35tr735wl2yCBYurA661CdLwt5vkznLbkc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k0ggXAqlt7N9lZSHIy25EHSAzRQuYfbir2EpDuXwSGp1O7tG1I4q5FvcpepY7UA5X
         ta0ZxoBxcjOusXorN+QJ4jmnLV9SIiJ8NCPJFdn9UbEkj+/owFb6XJvc04bBEqfK6x
         QyRa/yOdeH6bk2jWTLzt29a51UylD3YF8hztmRXcncsGx4NHI1vlaIGNWmI+/gMg1D
         0ZbHHcJQHLNVMqAfkfuyH5W7sRp+yUvBewDh7n5PCvSA//zHdHLqOoLk8ZqDqFzwjc
         7QOdvGRla3La8SVpUwnee6iTUyne6U7aTlA/KMIeS+2HZR7hRCc8hnxMJAeP7NmrXf
         o80pa/StkitwQ==
Message-ID: <8b9e863b-35f6-7b86-d4b7-cb01ddad0958@collabora.com>
Date:   Mon, 11 Sep 2023 11:09:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v5 2/2] arm64: dts: mediatek: add device-tree for Genio
 1200 EVK board
Content-Language: en-US
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>, Ben Lok <ben.lok@mediatek.com>
References: <20230909132819.21626-1-macpaul.lin@mediatek.com>
 <20230909132819.21626-2-macpaul.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230909132819.21626-2-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Il 09/09/23 15:28, Macpaul Lin ha scritto:
> Add basic device-tree for the Genio 1200-EVK board. This board
> is made by MediaTek and has a MT8395 SoC (MT8195 family),
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
>   arch/arm64/boot/dts/mediatek/Makefile         |   1 +
>   .../dts/mediatek/mt8395-genio-1200-evk.dts    | 901 ++++++++++++++++++
>   2 files changed, 902 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> 
> Changes for v2:
>   - correct SOC binding to "mediatek,mt8395".
>   - Fix a Linux coding style comments for optee node.
>   - Fix wifi fixed 3.3v power's node with "wifi-3v3-regulator".
>   - Fix node name of mt6360 and mt6517 to generic dts name as "pmic".
>   - Remove unecessary blank line.
>   - Reording usb node as the order of "phy" then "host".
> 
> Changes for v3:
>   - Add back bindings for "mediatek,mt8195".
>   - Fix wifi fixed 3.3v power's node with "regulator-2"
> 
> Changes for v4:
>   - Fix Makefile and dts file name with prefix "mt8395-".
>   - Re-order all nodes in mt8395-genio-1200-evk.dts by alphabetical order.
>   - Remove unused "DEBUG" node.
> 
> Changes for v5:
>   - Revise commit message for board's name.
>   - swap the order of nodes 'mt6359_vcamio_ldo_reg' and
>     'mt6359_vcn33_2_bt_ldo_reg' by alphabetical order.
>   - Reorder some gpio pins by alphabetical order.
>    - audio_default_pins, eth pins, and uart1 pins
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index c99c3372a4b5..10e640c6ae08 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -53,4 +53,5 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-cherry-tomato-r3.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-demo.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-evk.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-genio-1200-evk.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> new file mode 100644
> index 000000000000..5de2d102c577
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dts
> @@ -0,0 +1,901 @@
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
> +	compatible = "mediatek,mt8395-evk", "mediatek,mt8395",
> +		     "mediatek,mt8195";
> +


..snip..

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
> +&u3phy0 {
> +	status = "okay";
> +};
> +
> +&u3phy1 {
> +	status = "okay";
> +};
> +
> +&u3phy2 {
> +	status = "okay";
> +};
> +
> +&u3phy3 {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-0 = <&uart0_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-0 = <&uart1_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&ufsphy {
> +	status = "disabled";
> +};
> +
> +&spmi {

spmi goes before u3phy0, after spi2.

after fixing:
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> +	#address-cells = <2>;
> +	#size-cells = <0>;
> +
> +	mt6315_6: pmic@6 {
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
> +	mt6315_7: pmic@7 {
> +		compatible = "mediatek,mt6315-regulator";
> +		reg = <0x7 SPMI_USID>;
> +
> +		regulators {
> +			mt6315_7_vbuck1: vbuck1 {
> +				regulator-compatible = "vbuck1";
> +				regulator-name = "Vgpu";
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <1193750>;
> +				regulator-enable-ramp-delay = <256>;
> +				regulator-allowed-modes = <0 1 2>;
> +			};
> +		};
> +	};
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



