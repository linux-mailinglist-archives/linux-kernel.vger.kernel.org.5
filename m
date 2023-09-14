Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBC67A0120
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbjINKDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237811AbjINKDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:03:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054D41BE3;
        Thu, 14 Sep 2023 03:02:58 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E240F66072FF;
        Thu, 14 Sep 2023 11:02:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694685776;
        bh=Ofj0RITyOx8ZemGDYGZjfNqU2kB288ZA4IwwfPxWoW4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LlfisKNy4IW4w2gbgc72JiUbiqjpQI6jiBF09Ep7tAvU06ch0Z0DvZbjk0+O1VyB/
         FHaoPo9Bx7K1XXhV7UlU5+D7Fc9dAlixH6T/3pBqbPYf6HCepkTvBvh45CBwcnIbt+
         4EenuCpJaFbNU1rOCtd489fvzA8LAQQwC1RYIo3qCW0g5OTdGLLeS0nxooxvIfg6eu
         LqA/Z6OS8yNkdX0q9VZHBoPhP/5BZt6/BZSLtx3xf+aI8L5BePE33X/kqGHE2HPXkU
         UlD7mZHEQZkW1TLu6IbEGi24sd4gVxOKg9NiG5iVUnr7bXLPFMw9k422fJavX3qUd+
         vERLVVAD8xBiQ==
Message-ID: <8596fd5e-035b-b7be-3588-c07f27d1f38f@collabora.com>
Date:   Thu, 14 Sep 2023 12:02:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 2/2] arm64: dts: mediatek: add device-tree for Genio
 700 EVK board
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
        Macpaul Lin <macpaul@gmail.com>,
        Chris-QJ Chen <chris-qj.chen@mediatek.com>
References: <20230914061833.32288-1-macpaul.lin@mediatek.com>
 <20230914061833.32288-2-macpaul.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230914061833.32288-2-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/09/23 08:18, Macpaul Lin ha scritto:
> Add basic device-tree for the Genio 700 EVK board. The
> Genio 700 EVK is based on MediaTek MT8390 SoC.
> MT8390 hardware register maps are identical to MT8188.
> 
> The Genio 700 EVK has following features:
> 
> - MT8390 SoC
> - MT6365 PMIC
> - MT6319 Buck IC
> - 12V DC Jack
> - 2x4GB LPDDR4X
> - 64GB eMMC 5.1
> - 64Mb SPI NOR
> - M.2 Key A-E slot with PCIe Gen2 and USB 2.0
> - 2x DSI LCM ports
> - 2x touch sensor ports
> - 2x MIPI-CSI, as camera daughter board slots
> - USB 2 micro USB connector
> - USB 3 with 1 to 2 hub:
>    - M.2 Key B slot
>    - Type-C connector, with DisplayPort over Type-C
> - HDMI 2.0 TX port with Type A HDMI connector
> - eDP port
> - Gigabit Ethernet with RJ45 connector
> - SD card slot
> - Earphone Jack
> - Analog Microphone
> - 2x Digital Microphone
> - 3x UART with serial-to-usb converters and micro USB connectors
> 
> Signed-off-by: Chris-QJ Chen <chris-qj.chen@mediatek.com>
> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile         |   1 +
>   .../dts/mediatek/mt8390-genio-700-evk.dts     | 880 ++++++++++++++++++
>   2 files changed, 881 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
> 
> dependencies for v1:
>   - This patch should be applied after the following patch set
>    - mt8365-gneio-350-evk's dts change (v4)
>     - https://lore.kernel.org/linux-arm-kernel/20230912092444.31635-1-macpaul.lin@mediatek.com/T/
>    - mt8395-genio-1200-evk's dts basic support (v6)
>     - https://lore.kernel.org/lkml/20230911115717.26184-1-macpaul.lin@mediatek.com/T/
>    - mt8188 platform's basic support
>     - https://lore.kernel.org/lkml/a4e1a80ebd19896410f50b0297e05dce06fb47cc.camel@mediatek.com/T/
> 
> changes for v2:
>   - Fix gpio defines '0' to 'GPIO_ACTIVE_HIGH'.
>   - Drop duplicate name: 'default' for I2C4.
>   - Update dependencies
>    - mt8365-gneio-350-evk's dts change (v5)
>     - https://lore.kernel.org/lkml/20230913032226.4092-1-macpaul.lin@mediatek.com/
>    - mt8395-genio-1200-evk's dts basic support (v7)
>     - https://lore.kernel.org/linux-arm-kernel/20230913032057.3197-1-macpaul.lin@mediatek.com/T/
>    - mt8188 platform's basic support (v4)
>     - https://lore.kernel.org/lkml/a4e1a80ebd19896410f50b0297e05dce06fb47cc.camel@mediatek.com/T/
> 
> changes for v3:
>   - No change.
>   - Update dependencies
>    - mt8365-gneio-350-evk's dts change (v5)
>     - https://lore.kernel.org/lkml/20230913032226.4092-1-macpaul.lin@mediatek.com/
>    - mt8395-genio-1200-evk's dts basic support (v8)
>     - https://lore.kernel.org/lkml/20230914055145.16801-1-macpaul.lin@mediatek.com/T/
>    - mt8188 platform's basic support (v4)
>     - https://lore.kernel.org/lkml/a4e1a80ebd19896410f50b0297e05dce06fb47cc.camel@mediatek.com/T/
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 22f362bbbdac..3262849c0f6b 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -54,5 +54,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-cherry-tomato-r3.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-demo.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8365-genio-350-evk.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8390-genio-700-evk.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8395-genio-1200-evk.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
> new file mode 100644
> index 000000000000..ed6bbf0c15cc
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
> @@ -0,0 +1,880 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2023 MediaTek Inc.
> + * Author: Chris Chen <chris-qj.chen@mediatek.com>
> + *	   Pablo Sun <pablo.sun@mediatek.com>
> + *	   Macpaul Lin <macpaul.lin@mediatek.com>
> + */
> +/dts-v1/;
> +
> +#include "mt8188.dtsi"
> +#include "mt6359.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h>
> +#include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
> +#include <dt-bindings/spmi/spmi.h>
> +#include <dt-bindings/usb/pd.h>
> +
> +/ {
> +	model = "MediaTek Genio-700 EVK";
> +	compatible = "mediatek,mt8390-evk", "mediatek,mt8390",
> +		     "mediatek,mt8188";
> +

..snip..

> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pins>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	touchscreen@5d {
> +		compatible = "goodix,gt9271";
> +		reg = <0x5d>;
> +		interrupt-parent = <&pio>;
> +		interrupts = <6 IRQ_TYPE_EDGE_RISING>;

interrupts-extended = <&pio 7 IRQ_TYPE_EDGE_RISING>;

after which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


