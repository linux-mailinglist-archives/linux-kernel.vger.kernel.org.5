Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D907D7DFF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjJZIDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjJZIDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:03:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11033B8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:03:13 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 577C5660732A;
        Thu, 26 Oct 2023 09:03:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698307391;
        bh=Fef1hJcTSlQGakVzORPVPnqgvkpRbVwgbom99kx0qPg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NPyWBOIhlwpM5HsEwVY0+sZFCDYnVMiPjyyFrTPzdbZTTomuxzFPWJeDFB8UIY3un
         73ZrPdp2gJlVKtCsj9aNqVe+V+B4V7QweJuNjvnpV63I6sftQeFDGrNz/w1jhIk1eO
         c4SH04h7SDCJBa7C8GTyUETNxcblLNo4tUNXd0Yh9K+LRXq0x6AfTF8j/ZbK8W4c2r
         D08KUAm8AN5rgtaErjHHMH6LM6QZP9AHVbO2G2VdASPf8+/LDa4hHTaz/iKe3eXeyz
         Xu+eqiWZlZC5tMxgK4yofLDPGrssSeNKnTGNuTOdX1Z8sThBefFdoapjS4BL7bxegn
         i889ScG4tR3Dw==
Message-ID: <831e792e-683b-4305-a451-16bb6736280a@collabora.com>
Date:   Thu, 26 Oct 2023 10:03:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: dts: mt7986: add overlay for SATA power
 socket on BPI-R3
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Golle <daniel@makrotopia.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Eric Woudstra <ericwouds@gmail.com>
References: <20231025170832.78727-1-linux@fw-web.de>
 <20231025170832.78727-6-linux@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231025170832.78727-6-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/10/23 19:08, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Bananapi R3 has a Power socket entended for using external SATA drives.
> This Socket is off by default but can be switched with gpio 8.
> 
> Add an overlay to activate it.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v2:
> - rebase on the patch "add dtbs with applied overlays for bpi-r3"
> - add sata-overlay to the full dtbs
> ---
>   arch/arm64/boot/dts/mediatek/Makefile         | 13 +++++--
>   .../mt7986a-bananapi-bpi-r3-sata.dtso         | 39 +++++++++++++++++++
>   2 files changed, 48 insertions(+), 4 deletions(-)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sata.dtso
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 24eeba0703ce..c3b236a47513 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -13,26 +13,31 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc.dtbo
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nand.dtbo
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nor.dtbo
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sata.dtbo
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd.dtbo

The devicetree overlays make no sense without a base devicetree, right? :-)

dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-nor.dtbo <-- makes no sense!

Check how it's done in freescale (nxp) and renesas... and there's also one instance
of overlays in qualcomm.

In short:
  - Remove all of the dtb-$(CONFIG_ARCH_MEDIATEK) += blah.dtbo
  - xxxx-dtbs:= blah.dtb blah-overlay.dtbo, dtb-$(CONFIG_ARCH_MEDIATEK) += xxxx.dtb
    is correct.

>   mt7986a-bananapi-bpi-r3-emmc-nand-dtbs := \
>   	mt7986a-bananapi-bpi-r3.dtb \
>   	mt7986a-bananapi-bpi-r3-emmc.dtbo \
> -	mt7986a-bananapi-bpi-r3-nand.dtbo
> +	mt7986a-bananapi-bpi-r3-nand.dtbo \
> +	mt7986a-bananapi-bpi-r3-sata.dtbo
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc-nand.dtb
>   mt7986a-bananapi-bpi-r3-emmc-nor-dtbs := \
>   	mt7986a-bananapi-bpi-r3.dtb \
>   	mt7986a-bananapi-bpi-r3-emmc.dtbo \
> -	mt7986a-bananapi-bpi-r3-nor.dtbo
> +	mt7986a-bananapi-bpi-r3-nor.dtbo \
> +	mt7986a-bananapi-bpi-r3-sata.dtbo
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-emmc-nor.dtb
>   mt7986a-bananapi-bpi-r3-sd-nand-dtbs := \
>   	mt7986a-bananapi-bpi-r3.dtb \
>   	mt7986a-bananapi-bpi-r3-sd.dtbo \
> -	mt7986a-bananapi-bpi-r3-nand.dtbo
> +	mt7986a-bananapi-bpi-r3-nand.dtbo \
> +	mt7986a-bananapi-bpi-r3-sata.dtbo
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd-nand.dtb
>   mt7986a-bananapi-bpi-r3-sd-nor-dtbs := \
>   	mt7986a-bananapi-bpi-r3.dtb \
>   	mt7986a-bananapi-bpi-r3-sd.dtbo \
> -	mt7986a-bananapi-bpi-r3-nor.dtbo
> +	mt7986a-bananapi-bpi-r3-nor.dtbo \
> +	mt7986a-bananapi-bpi-r3-sata.dtbo
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-bananapi-bpi-r3-sd-nor.dtb
>   
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt7986a-rfb.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sata.dtso b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sata.dtso
> new file mode 100644
> index 000000000000..6ab06813412a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-sata.dtso
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2021 MediaTek Inc.
> + * Author: Frank Wunderlich <frank-w@public-files.de>
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	compatible = "bananapi,bpi-r3", "mediatek,mt7986a";
> +
> +	fragment@0 {
> +		target-path = "/";
> +		__overlay__ {

This could be easier, I think.

&{/} {

	reg_sata12v: regulator-sata12v {
		....
	};

	something_else: something-else { ... };
};

Regards,
Angelo

> +			reg_sata12v: regulator-sata12v {
> +				compatible = "regulator-fixed";
> +				regulator-name = "sata12v";
> +				regulator-min-microvolt = <12000000>;
> +				regulator-max-microvolt = <12000000>;
> +				gpio = <&pio 8 GPIO_ACTIVE_HIGH>;
> +				enable-active-high;
> +				regulator-always-on;
> +			};
> +
> +			reg_sata5v: regulator-sata5v {
> +				compatible = "regulator-fixed";
> +				regulator-name = "sata5v";
> +				regulator-min-microvolt = <5000000>;
> +				regulator-max-microvolt = <5000000>;
> +				regulator-always-on;
> +				vin-supply = <&reg_sata12v>;
> +			};
> +		};
> +	};
> +};
> +

