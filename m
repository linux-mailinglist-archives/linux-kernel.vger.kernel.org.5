Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306367558EC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 02:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjGQAqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 20:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGQAqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 20:46:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9D7F7;
        Sun, 16 Jul 2023 17:46:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27C8560ED8;
        Mon, 17 Jul 2023 00:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42773C433C7;
        Mon, 17 Jul 2023 00:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689554808;
        bh=Re/kfQi8I9qVN1ArjY+ZDed/+AG2Yh59+T0yVs8hjJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SKjAhhGS4R8YIpf0lgxWXXKKI40KD/x88o0Cd56jJYv3gHiV9+gKfiM6XeiZen6AH
         IBrWcm+vwcPR2g5uLTC31l/0Io9DCsNQyhtp1bFIfwL8noN7S3zFUvIebaBgR77Ucj
         TqT/1xZsDfEeZAKpNhOW1wPlqusNJM4MG5Tx+F7wYoeRBbxugJq+6YNEgPFi7k87wu
         eL69AM3MSjMBsXRK5D9c+PaMIYipLxwpZ2nHKtn6s1w7bNFbxOCuvhLeczwXve7u3o
         WhW1/Om/FI2GXbqNN5epRfqeuhg++i+H/2NZAq6VkRKja/eV27BPV+oqJ69rHGFfrG
         vGdEhKJQDRTuA==
Date:   Mon, 17 Jul 2023 08:46:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm: add imx8mm-venice-gw73xx-0x-rpidsi
 overlay for display
Message-ID: <20230717004638.GK9559@dragon>
References: <20230609225552.3594111-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609225552.3594111-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 03:55:52PM -0700, Tim Harvey wrote:
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
>  .../imx8mm-venice-gw73xx-0x-rpidsi.dtso       | 87 +++++++++++++++++++
>  2 files changed, 89 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rpidsi.dtso
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 76269da9cc62..48f03fc9af04 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -149,6 +149,7 @@ imx8mm-venice-gw72xx-0x-rs232-rts-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-ven
>  imx8mm-venice-gw72xx-0x-rs422-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rs422.dtbo
>  imx8mm-venice-gw72xx-0x-rs485-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rs485.dtbo
>  imx8mm-venice-gw73xx-0x-imx219-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice-gw73xx-0x-imx219.dtbo
> +imx8mm-venice-gw73xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice-gw73xx-0x-rpidsi.dtbo
>  imx8mm-venice-gw73xx-0x-rs232-rts-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice-gw73xx-0x-rs232-rts.dtbo
>  imx8mm-venice-gw73xx-0x-rs422-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice-gw73xx-0x-rs422.dtbo
>  imx8mm-venice-gw73xx-0x-rs485-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice-gw73xx-0x-rs485.dtbo
> @@ -158,6 +159,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x-rs232-rts.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x-rs422.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x-rs485.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-imx219.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rpidsi.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs232-rts.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs422.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs485.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rpidsi.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rpidsi.dtso
> new file mode 100644
> index 000000000000..45bf88fa7c16
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rpidsi.dtso
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2023 Gateworks Corporation
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +#include "imx8mm-pinfunc.h"
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&{/} {
> +	compatible = "gw,imx8mm-gw73xx-0x", "fsl,imx8mm";
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
> +&i2c3 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	attiny: regulator@45 {
> +		compatible = "raspberrypi,7inch-touchscreen-panel-regulator";
> +		reg = <0x45>;
> +	};
> +};
> +
> +&lcdif {
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

Have a newline between properties and child node.

Shawn

> +				bridge_in: endpoint {
> +					remote-endpoint = <&dsi_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
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
> +			dsi_out: endpoint {
> +				remote-endpoint = <&bridge_in>;
> +			};
> +		};
> +	};
> +};
> -- 
> 2.34.1
> 
