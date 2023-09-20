Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701C97A87F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbjITPMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbjITPMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:12:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2904CA3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:11:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6604C433C7;
        Wed, 20 Sep 2023 15:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695222714;
        bh=jZOqEkgbj4xsFQDh1dvki+AbIMCEjpMDT+A0MtfAqG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bo60hrba+Dgc/bZu5VKh0wTZlG6QUp8CVTehRe66ZMiwLMEo6E4kiReUaBCyyap0V
         hhNE8FdKKBZhFP/xJuUBZOz9K465V3Z2aLnuhW9mQiorAKcOnwF07FCqAOxyRur4cU
         aJ9DcgDTmw+KxkEoIO9O8aEoaKrj+fc7YhgIliO1RFB5XM/Z5bXm5irY/wcEvX2Vw2
         EL8CJvqtDtXPG+/qX4od+h+Wv1ZczEOJe1MuRQ/iYXBFFna/IYd8aNl0ogN0JeWRQT
         3yEAAKSCvyBqMMjliaIRcFIBEFWINxNorYsBR1lbOIWGvxIoPWWYjD0SNbofuTUlxs
         4WVt1PiUkT4bQ==
Date:   Wed, 20 Sep 2023 17:11:45 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 3/3] ARM: dts: imx6q: Add Variscite MX6 Custom board
 support
Message-ID: <20230920151144.GF11740@T480>
References: <20230811072009.55400-1-james.hilliard1@gmail.com>
 <20230811072009.55400-3-james.hilliard1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811072009.55400-3-james.hilliard1@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 01:20:06AM -0600, James Hilliard wrote:
> This patch adds support for the Variscite MX6 SoM Carrier Board.
> 
> This Carrier-Board has the following :
> - LVDS interface for the VLCD-CAP-GLD-LVDS 7" LCD 800 x 480 touch display
> - HDMI Connector
> - USB Host + USB OTG Connector
> - 10/100/1000 Mbps Ethernet
> - miniPCI-Express slot
> - SD Card connector
> - Audio Headphone/Line In jack connectors
> - S-ATA
> - On-board DMIC
> - RS485 Header
> - CAN bus header
> - SPI header
> - Camera Interfaces header
> - OnBoard RTC with Coin Backup battery socket
> - RS232 Debug Header (IDC10)
> - RS232 DTE
> 
> Product Page : https://www.variscite.com/product/single-board-computers/var-mx6customboard
> 
> The dts file based on the ones provided by Variscite on their own
> kernel, but adapted for mainline.
> 
> Cc: Pierluigi Passaro <pierluigi.p@variscite.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  arch/arm/boot/dts/nxp/imx/Makefile            |   1 +
>  .../dts/nxp/imx/imx6q-var-mx6customboard.dts  | 231 ++++++++++++++++++
>  2 files changed, 232 insertions(+)
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts
> 
> diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
> index 3629e343d322..258ec0e5b712 100644
> --- a/arch/arm/boot/dts/nxp/imx/Makefile
> +++ b/arch/arm/boot/dts/nxp/imx/Makefile
> @@ -244,6 +244,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6q-udoo.dtb \
>  	imx6q-utilite-pro.dtb \
>  	imx6q-var-dt6customboard.dtb \
> +	imx6q-var-mx6customboard.dtb \
>  	imx6q-vicut1.dtb \
>  	imx6q-wandboard.dtb \
>  	imx6q-wandboard-revb1.dtb \
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts b/arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts
> new file mode 100644
> index 000000000000..e5552efc505b
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts
> @@ -0,0 +1,231 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Support for Variscite MX6 Carrier-board
> + *
> + * Copyright 2016 Variscite, Ltd. All Rights Reserved
> + * Copyright 2022 Bootlin
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6qdl-var-som.dtsi"
> +#include <dt-bindings/pwm/pwm.h>
> +
> +/ {
> +	model = "Variscite i.MX6 QUAD/DUAL VAR-SOM-MX6 Custom Board";
> +	compatible = "variscite,mx6customboard", "variscite,var-som-imx6q", "fsl,imx6q";
> +
> +	panel0: lvds-panel0 {
> +		compatible =  "panel-lvds";
> +		backlight = <&backlight_lvds>;
> +		width-mm = <152>;
> +		height-mm = <91>;
> +		label = "etm070001adh6";
> +		data-mapping = "jeida-18";
> +
> +		panel-timing {
> +			clock-frequency = <32000000>;
> +			hactive = <800>;
> +			vactive = <480>;
> +			hback-porch = <39>;
> +			hfront-porch = <39>;
> +			vback-porch = <29>;
> +			vfront-porch = <13>;
> +			hsync-len = <47>;
> +			vsync-len = <2>;
> +		};
> +
> +		port {
> +			panel_in_lvds0: endpoint {
> +				remote-endpoint = <&lvds0_out>;
> +			};
> +		};
> +	};
> +
> +	panel1: lvds-panel1 {
> +		compatible =  "panel-lvds";
> +		width-mm = <152>;
> +		height-mm = <91>;
> +		data-mapping = "jeida-18";
> +
> +		panel-timing {
> +			clock-frequency = <38251000>;
> +			hactive = <800>;
> +			vactive = <600>;
> +			hback-porch = <112>;
> +			hfront-porch = <32>;
> +			vback-porch = <3>;
> +			vfront-porch = <17>;
> +			hsync-len = <80>;
> +			vsync-len = <4>;
> +		};
> +
> +		port {
> +			panel_in_lvds1: endpoint {
> +				remote-endpoint = <&lvds1_out>;
> +			};
> +		};
> +	};
> +
> +	backlight_lvds: backlight-lvds {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm2 0 50000 0>;
> +		brightness-levels = <0 4 8 16 32 64 128 248>;
> +		default-brightness-level = <7>;
> +		power-supply = <&reg_3p3v>;
> +	};
> +};
> +
> +&i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +
> +	touchscreen@24 {
> +		compatible = "cypress,tt21000";
> +		reg = <0x24>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> +		reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> +		vdd-supply = <&reg_3p3v>;
> +		touchscreen-size-x = <880>;
> +		touchscreen-size-y = <1280>;
> +	};
> +
> +	touchscreen@38 {
> +		compatible = "edt,edt-ft5306";
> +		reg = <0x38>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> +		touchscreen-size-x = <1800>;
> +		touchscreen-size-y = <1000>;
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl_ipu1: ipu1grp {

Try to keep pinctrl nodes sort alphabetically.

Shawn

> +		fsl,pins = <
> +			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK	0x10
> +			MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15		0x10
> +			MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02		0x10
> +			MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03		0x10
> +			MX6QDL_PAD_DI0_PIN4__IPU1_DI0_PIN04		0x10
> +			MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00	0x10
> +			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01	0x10
> +			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02	0x10
> +			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03	0x10
> +			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04	0x10
> +			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05	0x10
> +			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06	0x10
> +			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07	0x10
> +			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08	0x10
> +			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09	0x10
> +			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10	0x10
> +			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11	0x10
> +			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12	0x10
> +			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13	0x10
> +			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14	0x10
> +			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15	0x10
> +			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16	0x10
> +			MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17	0x10
> +			MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18	0x10
> +			MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19	0x10
> +			MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20	0x10
> +			MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21	0x10
> +			MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22	0x10
> +			MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23	0x10
> +		>;
> +	};
> +
> +	pinctrl_camera: cameragrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_CSI0_DAT12__IPU1_CSI0_DATA12		0x1b0b0
> +			MX6QDL_PAD_CSI0_DAT13__IPU1_CSI0_DATA13		0x1b0b0
> +			MX6QDL_PAD_CSI0_DAT14__IPU1_CSI0_DATA14		0x1b0b0
> +			MX6QDL_PAD_CSI0_DAT15__IPU1_CSI0_DATA15		0x1b0b0
> +			MX6QDL_PAD_CSI0_DAT16__IPU1_CSI0_DATA16		0x1b0b0
> +			MX6QDL_PAD_CSI0_DAT17__IPU1_CSI0_DATA17		0x1b0b0
> +			MX6QDL_PAD_CSI0_DAT18__IPU1_CSI0_DATA18		0x1b0b0
> +			MX6QDL_PAD_CSI0_DAT19__IPU1_CSI0_DATA19		0x1b0b0
> +			MX6QDL_PAD_CSI0_DATA_EN__IPU1_CSI0_DATA_EN	0x1b0b0
> +			MX6QDL_PAD_CSI0_PIXCLK__IPU1_CSI0_PIXCLK	0x1b0b0
> +			MX6QDL_PAD_CSI0_MCLK__IPU1_CSI0_HSYNC		0x1b0b0
> +			MX6QDL_PAD_CSI0_VSYNC__IPU1_CSI0_VSYNC		0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_flexcan1: flexcan1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_7__FLEXCAN1_TX		0x1b0b0
> +			MX6QDL_PAD_GPIO_8__FLEXCAN1_RX		0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_usbotg_var: usbotggrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x17059
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD1_CMD__SD1_CMD		0x17071
> +			MX6QDL_PAD_SD1_CLK__SD1_CLK		0x10071
> +			MX6QDL_PAD_SD1_DAT0__SD1_DATA0		0x17071
> +			MX6QDL_PAD_SD1_DAT1__SD1_DATA1		0x17071
> +			MX6QDL_PAD_SD1_DAT2__SD1_DATA2		0x17071
> +			MX6QDL_PAD_SD1_DAT3__SD1_DATA3		0x17071
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD2_CMD__SD2_CMD		0x17059
> +			MX6QDL_PAD_SD2_CLK__SD2_CLK		0x10059
> +			MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x17059
> +			MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
> +			MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
> +			MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x17059
> +		>;
> +	};
> +};
> +
> +&ldb {
> +	status = "okay";
> +
> +	lvds-channel@0 {
> +		fsl,data-mapping = "spwg";
> +		fsl,data-width = <24>;
> +		status = "okay";
> +
> +		port@4 {
> +			reg = <4>;
> +
> +			lvds0_out: endpoint {
> +				remote-endpoint = <&panel_in_lvds0>;
> +			};
> +		};
> +	};
> +
> +	lvds-channel@1 {
> +		fsl,data-mapping = "spwg";
> +		fsl,data-width = <24>;
> +		status = "okay";
> +
> +		port@4 {
> +			reg = <4>;
> +
> +			lvds1_out: endpoint {
> +				remote-endpoint = <&panel_in_lvds1>;
> +			};
> +		};
> +	};
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	cd-gpios = <&gpio4 14 GPIO_ACTIVE_LOW>;
> +	wp-gpios = <&gpio4 15 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +};
> -- 
> 2.34.1
> 
