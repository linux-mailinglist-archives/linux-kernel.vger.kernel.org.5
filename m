Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235DA758B90
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 04:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjGSCw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 22:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGSCw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 22:52:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50719E5;
        Tue, 18 Jul 2023 19:52:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2D14616A6;
        Wed, 19 Jul 2023 02:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62023C433C8;
        Wed, 19 Jul 2023 02:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689735145;
        bh=mtzhvgEfLr7ZdYnN/L85Cx+kjqP7iGN2FwlwDnMLq8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fWP67ZuG873v0q249nvWRNRMOLTn/KSA2w8FXVlnT6poZDSFTCDHr75WH0bLTcDNT
         +AYHF1OjSthcKNzPBsZmwWDxPVBApdSxIkBeXiIVDCSo0Stm3s6EAvebh3BL55n00y
         khJSrocGT8lgQHV9Ep3jz7XPm3PHHA901W8bF9Xusdlcb0rrOMaLcWwKlVxAfYL6BX
         BXh43IXWHbIgqkVOu9+VboLSTtEWAdhvKQ19gi/wC2hyc8t8QtxaadBhGiYxwYrtzz
         xEMnYO35R2FXqdwSCycE1SPvAeiYOfTgKrUP5HF1Ak2gCb97GlAiPcFzuv1SxFpFXh
         ng0qhOfVVKqAQ==
Date:   Wed, 19 Jul 2023 10:52:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mp: add imx8mp-venice-gw74xx-rpidsi
 overlay for display
Message-ID: <20230719025213.GW9559@dragon>
References: <20230711221440.2127784-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711221440.2127784-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 03:14:40PM -0700, Tim Harvey wrote:
> Add support for the following Raspberry Pi displays:
>  - DFROBOT DRF0678 7in 800x480 TFT DSI capacitive touch
>  - DFROBOT DRF0550 5in 800x480 TFT DSI capacitive touch
> 
> Both have the following hardware:
>  - FocalTech FT5406 10pt touch controller (with no interrupt)
>  - Powertip PH800480T013-IDF02 compatible panel
>  - Toshiba TC358762 compatible DSI to DBI bridge
>  - ATTINY based regulator used for backlight controller and panel enable
> 
> Support is added via a device-tree overlay. The touch controller is not
> yet supported as polling mode is needed.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |  2 +
>  .../imx8mp-venice-gw74xx-rpidsi.dtso          | 86 +++++++++++++++++++
>  2 files changed, 88 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-rpidsi.dtso
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 454b07ed09fc..60a69e114442 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -156,6 +156,7 @@ imx8mm-venice-gw73xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice
>  imx8mm-venice-gw73xx-0x-rs232-rts-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice-gw73xx-0x-rs232-rts.dtbo
>  imx8mm-venice-gw73xx-0x-rs422-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice-gw73xx-0x-rs422.dtbo
>  imx8mm-venice-gw73xx-0x-rs485-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice-gw73xx-0x-rs485.dtbo
> +imx8mp-venice-gw74xx-rpidsi-dtbs	:= imx8mp-venice-gw74xx.dtb imx8mp-venice-gw74xx-rpidsi.dtbo
>  
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x-imx219.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x-rpidsi.dtb
> @@ -167,6 +168,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rpidsi.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs232-rts.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs422.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs485.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw74xx-rpidsi.dtb
>  
>  dtb-$(CONFIG_ARCH_S32) += s32g274a-evb.dtb
>  dtb-$(CONFIG_ARCH_S32) += s32g274a-rdb2.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-rpidsi.dtso b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-rpidsi.dtso
> new file mode 100644
> index 000000000000..eec635ead119
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-rpidsi.dtso
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2023 Gateworks Corporation
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&{/} {
> +	compatible = "gateworks,imx8mp-gw74xx", "fsl,imx8mp";
> +
> +	panel {
> +		compatible = "powertip,ph800480t013-idf02";
> +		power-supply = <&attiny>;
> +		backlight = <&attiny>;
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&bridge_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c4 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	attiny: regulator@45 {
> +		compatible = "raspberrypi,7inch-touchscreen-panel-regulator";
> +		reg = <0x45>;
> +	};
> +};
> +
> +&lcdif1 {
> +	status = "okay";
> +};
> +
> +&mipi_dsi {
> +	samsung,burst-clock-frequency = <891000000>;
> +	samsung,esc-clock-frequency = <54000000>;
> +	samsung,pll-clock-frequency = <27000000>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	bridge@0 {
> +		compatible = "toshiba,tc358762";
> +		reg = <0>;
> +		vddc-supply = <&attiny>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;

Missing newline.

Shawn

> +				bridge_in: endpoint {
> +					remote-endpoint = <&dsi_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +
> +				bridge_out: endpoint {
> +					remote-endpoint = <&panel_in>;
> +				};
> +			};
> +		};
> +	};
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@1 {
> +			reg = <1>;
> +
> +			dsi_out: endpoint {
> +				data-lanes = <1 2>;
> +				remote-endpoint = <&bridge_in>;
> +			};
> +		};
> +	};
> +};
> -- 
> 2.25.1
> 
