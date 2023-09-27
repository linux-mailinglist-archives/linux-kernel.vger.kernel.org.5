Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A3D7B0DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 23:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjI0VUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 17:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjI0VUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:20:00 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3FFD6;
        Wed, 27 Sep 2023 14:19:57 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3FE515C2905;
        Wed, 27 Sep 2023 17:19:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 27 Sep 2023 17:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1695849597; x=1695935997; bh=z/h4fES0SS47bjZAkAyklErYzVJ4ozg9Y5J
        Is7GVL5U=; b=olotVyJ+N7j8cdoju2RGI6pXjslf5vkG3tkjrRwDWQdEVWxgA9u
        DIViJNOO1nHBt8EWwnyJdl3EloQ0cyReiISrV8SkwvMG433+0U4sc1Aap7JO5zG3
        LLO8GjHnqRnP2fzvO9gV6gxRv/SF41CjvTjzGJeztI6bLTW28Un2aR3XPsr85Dw5
        QhDztDl31p8tyr2m6DLWO0RsCXukliTboKWG4HAMxNvCS2BKDMoYWZTbFMqeZt8g
        KuJfdbRlGC9C21+v1remCgiiaWQIf4ZcHJo9CoOXhG4+THzMNWtbc1SUgPINKyM5
        GVtnN2bQZizNwpPuMe59/lhc73z27jTguCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695849597; x=1695935997; bh=z/h4fES0SS47bjZAkAyklErYzVJ4ozg9Y5J
        Is7GVL5U=; b=QCo/QAdKZyiuQa2zuGTta3TV7bCKJugAv9+Qgaf9gRsmtdr/NBO
        79sZJ6rs23M+0+LKjGA/oS8ERy+Ef0okO7LhwgdUoXWe4+IdhErcuq7sqztITNYZ
        RqX2MpK99SK5+EuyN+9mEuBEsYWIThUiW3OoeQ0pkDyjcYRA5MDBnEIGVlj8+ZCA
        6m+o2CidOKhgSQHGf10kKUmyYpQ6DcMfg852TY4psRfRgNIOpdjMkR9YdzxTPqcS
        FU4+Gq+jAoOBjMIeinbjTVXeotJEz+iZh13PlOETBZzKuLI7Qilm+7VsnUtCPgGZ
        Ll7mwy/QulX5NknRf7DexNBWvUFMg4r9gwQ==
X-ME-Sender: <xms:fJwUZUutVoPFPUUW-plZ5D_Saqx7ABLCyIuSqtPfKN7hwlzu38IL5g>
    <xme:fJwUZRdHs950H13w4IzFrrWRzoGtIUu_kCkuY0qreDTtUMk-Sh1f4ppG5BqWs-1U0
    me4h-TspPoY9OvfqA>
X-ME-Received: <xmr:fJwUZfxGyFZZ3nmdmqafvvqnri83xoVxPfb31p9M7rXLc79SEaFUrmpl6JDaXl4NpXqVapHdrXcBqtuX4EW9yHS7OpsVBLbqQtqNKwenFJwCE0_NsmFdn3vSSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdeggdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnheptefgveeigfetjefgudduvdejgfelkefgtdehiefgtedugeejueeu
    teelveetteeknecuffhomhgrihhnpeguthhsihdrhihouhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:fJwUZXMNQCD0WgZSpi2aySxTB3-e3d6vp1fYtUaYdLWfdLEs9xxIsg>
    <xmx:fJwUZU_QoqO-6vRvi6GWuyfnuyfc8BiTfFuV5EJgc0X32P8NZXPIrQ>
    <xmx:fJwUZfVHNP9GMDRRRWVq5BoJusGVJEqKJ89esk7J3dNxxXfzK1TMzg>
    <xmx:fZwUZYTmRnuitVKRcA-yklCvObH3WIfk7yniuStNqmMYSGgS5ankVA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 17:19:56 -0400 (EDT)
Message-ID: <9730f21c-fd8e-9583-98c7-e5d923269f79@sholland.org>
Date:   Wed, 27 Sep 2023 16:19:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/2] ARM: dts: sun7i: Add Iteaduino Plus A20
Content-Language: en-US
To:     Julian Ribbeck <julian.ribbeck@gmx.de>
Cc:     conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@linaro.org
References: <e0e71b0c-086d-ce54-f4d3-6f594d8e5da6@linaro.org>
 <20230617205624.1178427-1-julian.ribbeck@gmx.de>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20230617205624.1178427-1-julian.ribbeck@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julian,

Next time please CC everyone reported by scripts/get_maintainer.pl on
this file, so we are aware of your patch.

On 6/17/23 15:55, Julian Ribbeck wrote:
> Iteaduino Plus A20 is very similar to Iteaduino Plus A10. In fact it
> shares the same breakout board and the Itead Core A20 on top of it, is
> only adapted to support the dual-core A20.
> 
> This commits enables the following hardware:
> 
> * HDMI Video output
> * USB
> * SATA (untested due to lack of hardware I could attach)
> * Ethernet
> * MMC storage
> * UART
> * USB OTG (untested, because I don't own an USB OTG cable/device)
> 
> Signed-off-by: Julian Ribbeck <julian.ribbeck@gmx.de>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../dts/sun7i-a20-itead-iteaduino-plus.dts    | 114 ++++++++++++++++++
>  2 files changed, 115 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-itead-iteaduino-plus.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 59829fc90315..3b6e284e4472 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1334,6 +1334,7 @@ dtb-$(CONFIG_MACH_SUN7I) += \
>  	sun7i-a20-haoyu-marsboard.dtb \
>  	sun7i-a20-hummingbird.dtb \
>  	sun7i-a20-itead-ibox.dtb \
> +	sun7i-a20-itead-iteaduino-plus.dtb \
>  	sun7i-a20-i12-tvbox.dtb \
>  	sun7i-a20-icnova-swac.dtb \
>  	sun7i-a20-lamobo-r1.dtb \
> diff --git a/arch/arm/boot/dts/sun7i-a20-itead-iteaduino-plus.dts b/arch/arm/boot/dts/sun7i-a20-itead-iteaduino-plus.dts
> new file mode 100644

ARM devicetrees were moved into subdirectories, so this patch will need
to be rebased.

> index 000000000000..204c5f2c81c7
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-itead-iteaduino-plus.dts
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +
> +/dts-v1/;
> +#include "sun7i-a20.dtsi"
> +#include "sunxi-itead-core-common.dtsi"
> +#include "axp209.dtsi"

axp209.dtsi is already included by sunxi-itead-core-common.dtsi. You
don't need to include it again here.

> +
> +/ {
> +	model = "Itead Iteaduino Plus A20";
> +	compatible = "itead,iteaduino-plus-a20", "allwinner,sun7i-a20";
> +
> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +};
> +
> +&ac_power_supply {
> +	status = "okay";
> +};
> +
> +&ahci {
> +	target-supply = <&reg_ahci_5v>;
> +	status = "okay";
> +};
> +
> +&axp209 {
> +	interrupt-parent = <&nmi_intc>;
> +	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +};
> +
> +&battery_power_supply {
> +	status = "okay";
> +};
> +
> +&codec {
> +	stauts = "okay";
> +};
> +
> +&de {
> +	status = "okay";
> +};
> +
> +&emac {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emac_pa_pins>;
> +	phy-handle = <&phy1>;
> +	status = "okay";
> +};
> +
> +&emac_sram {
> +	status = "okay";
> +};
> +
> +&hdmi {
> +	status = "okay";
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};
> +
> +&mdio {
> +	status = "okay";
> +
> +	phy1: ethernet-phy@1 {
> +		reg = <1>;
> +	};
> +};
> +
> +&mmc0 {
> +	vmmc-supply = <&reg_vcc3v3>;
> +	bus-width = <4>;
> +	cd-gpios = <&pio 7 1 GPIO_ACTIVE_LOW>; /* PH1 */
> +	status = "okay";
> +};
> +
> +
> +&otg_sram {
> +	status = "okay";
> +};
> +
> +&reg_ahci_5v {
> +	status = "okay";
> +};
> +
> +

Extra blank line here and above otg_sram.

> +&reg_usb0_vbus {
> +	status = "okay";
> +};
> +
> +&usb_otg {
> +	status = "okay";
> +	dr_mode = "otg";

The mini-USB port is always powered, and the ID pin isn't hooked up in a
usable way, so this should be "host".

> +};
> +
> +&usb_power_supply {
> +	status = "okay";
> +};

The board's power supply is only connected to the ACIN pins of the
AXP209, not the USBVBUS pin (which is pulled to 3.3V for some reason).
So usb_power_supply should not be enabled or used below.

> +
> +&usbphy {
> +	usb0_id_det-gpios = <&pio 7 4 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PH4 */

The ID pin is connected to N_VBUSEN on the PMIC, not this GPIO. Per the
schematic, this GPIO is not connected to anything.

> +	usb0_vbus_det-gpios = <&pio 7 5 (GPIO_ACTIVE_HIGH | GPIO_PULL_UP)>; /* PH5 */

Per the schematic, this GPIO is not connected to anything.

> +	usb0_vbus_power-supply = <&usb_power_supply>;

As explained above, please remove this property.

Regards,
Samuel

> +	usb0_vbus-supply = <&reg_usb0_vbus>;
> +};
> --
> 2.41.0
> 

