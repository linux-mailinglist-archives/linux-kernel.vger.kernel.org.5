Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567E5812CF2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443636AbjLNKbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443599AbjLNKbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:31:38 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8F8AF;
        Thu, 14 Dec 2023 02:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702549903;
        bh=hAEE7gN/tX8xVA6dmhtKspxa0JnRlGiTqZPWAS3zgDY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uqycB/5RIGAkwL3i+H8xhqNcU3DDhsjo6RCTvOyBuZVcSYxuk9BdrepCKV7XxrJVR
         1wA2DrKCxY6hMxHSX4LpIp6XF2uypcIY7d7hlP6ItfpgMibAP4OlSTagHMfvUnXrob
         fORXnpWP1gDU+5SI+xtxjfxb9uDUZzzdwPCy+oF54gBSnAPI9/X8vyduw14+E2An/B
         iozcd6fInEgMZl5HLQ1IOQ52Y16TIk84nX1+I1aHqJ4AHbe+s6OlV+Z+PNNNVG0AFs
         pbFuzogNkQkk7Oba4znaBYFPB9+U2Nk+WmEjEOZiA39HF9+JG6zLbfJxxhk4LGpcPD
         SPT4wYIgA4IOA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4E065378000B;
        Thu, 14 Dec 2023 10:31:42 +0000 (UTC)
Message-ID: <13c8ccbc-0eef-43f5-ae37-29ec64d1606b@collabora.com>
Date:   Thu, 14 Dec 2023 11:31:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] arm64: dts: mediatek: Add MT8186 Krabby platform
 based Tentacruel / Tentacool
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Conor Dooley <conor.dooley@microchip.com>
References: <20231213150435.4134390-1-wenst@chromium.org>
 <20231213150435.4134390-7-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231213150435.4134390-7-wenst@chromium.org>
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

Il 13/12/23 16:04, Chen-Yu Tsai ha scritto:
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
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes since v3:
> - Reorder some properties to conform better to the newly proposed DT
>    style guidelines
> - Drop unused labels
> - Rename bt-sco node name to bt-sco-codec
> - Drop i2s*-share properties from afe node
> - Drop aud_gpio_tdm_{on,off} pinctrl nodes
> - Replace interrupts with interrupts-extended in tpm node
> - Enable adsp device
> 
> Changes since v2:
> - Picked up Conor's ack
> - Rename touchpad to trackpad
> - Drop pinctrl properties from trackpad in tentacruel/tentacool second
>    source trackpad
> 
> Changes since v1:
> - Reorder SKU numbers in descending order.
> - Fixed pinconfig node names
> - Moved pinctrl-* properties after interrupts-*
> - Switched to interrupts-extended for external components
> - Marked ADSP as explicitly disabled, with a comment explaining that it
>    stalls the system
> - Renamed "touchpad" to "trackpad"
> - Dropped bogus "no-laneswap" property from it6505 node
> - Moved "realtek,jd-src" property to after all the regulator supplies
> - Switched to macros for MT6366 regulator "regulator-allowed-modes"
> - Renamed "vgpu" regulator name to allow coupling, with a comment
>    containing the name used in the design
> - Renamed "cr50" node name to "tpm"
> - Moved trackpad_pins reference up to i2c2; workaround for second source
>    component resource sharing.
> - Fix copyright year
> - Fixed touchscreen supply name
> ---
>   arch/arm64/boot/dts/mediatek/Makefile         |    4 +
>   .../dts/mediatek/mt8186-corsola-krabby.dtsi   |  129 ++
>   .../mt8186-corsola-tentacool-sku327681.dts    |   57 +
>   .../mt8186-corsola-tentacool-sku327683.dts    |   24 +
>   .../mt8186-corsola-tentacruel-sku262144.dts   |   44 +
>   .../mt8186-corsola-tentacruel-sku262148.dts   |   26 +
>   .../boot/dts/mediatek/mt8186-corsola.dtsi     | 1707 +++++++++++++++++
>   7 files changed, 1991 insertions(+)
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

..snip..

> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dts
> new file mode 100644
> index 000000000000..447b57b12b41
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262148.dts
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2023 Google LLC
> + */
> +
> +#include "mt8186-corsola-tentacruel-sku262144.dts"
> +
> +/ {
> +	compatible = "google,tentacruel-sku262151", "google,tentacruel-sku262150",
> +		     "google,tentacruel-sku262149", "google,tentacruel-sku262148",
> +		     "google,tentacruel", "mediatek,mt8186";
> +};
> +
> +/* This variant replaces only the trackpad controller. */
> +&i2c2 {
> +	/delete-node/ trackpad@15;
> +
> +	trackpad@15 {
> +		compatible = "hid-over-i2c";
> +		reg = <0x15>;
> +		interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
> +		hid-descr-addr = <0x0001>;
> +		vdd-supply = <&pp3300_s3>;
> +		wakeup-source;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> new file mode 100644
> index 000000000000..adbeb0c765d3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
> @@ -0,0 +1,1707 @@
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
> +#include <dt-bindings/regulator/mediatek,mt6397-regulator.h>
> +

..snip..

> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	/*
> +	 * Trackpad pin put here to work around second source components
> +	 * sharing the pinmux in steelix designs.
> +	 */
> +	pinctrl-0 = <&i2c2_pins>, <&trackpad_pin>;
> +	clock-frequency = <400000>;
> +	i2c-scl-internal-delay-ns = <10000>;
> +	status = "okay";
> +
> +	trackpad@15 {
> +		compatible = "elan,ekth3000";

You forgot to change this one.

Remove compatible from this node and stop using /delete-node/ in device specific
devicetrees.

> +		reg = <0x15>;
> +		interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
> +		vcc-supply = <&pp3300_s3>;
> +		wakeup-source;
> +	};
> +};


corsola.dtsi (here):

&i2c2 {
	pinctrl-names = "default";
	/*
	 * Trackpad pin put here to work around second source components
	 * sharing the pinmux in steelix designs.
	 */
	pinctrl-0 = <&i2c2_pins>, <&trackpad_pin>;
	clock-frequency = <400000>;
	i2c-scl-internal-delay-ns = <10000>;
	status = "okay";

	trackpad_i2c2_15: trackpad@15 {
		/*
		 * Those are common properties for i2c2 trackpad on Corsola boards.
		 * The compatible string is declared in device specific devicetrees
		 */
		reg = <0x15>;
		interrupts-extended = <&pio 11 IRQ_TYPE_LEVEL_LOW>;
		vcc-supply = <&pp3300_s3>;
		wakeup-source;
		status = "disabled";
	};
};

corsola-some-device.dts:

&trackpad_i2c2_15 {
	compatible = "hid-over-i2c";
	hid-descr-addr = <0x0001>;
	status = "okay";
};

corsola-some-other-device.dts:

&trackpad_i2c2_15 {
	compatible = "elan,ekth3000";
	status = "okay";
};

....everything else looks good.

Cheers,
Angelo
