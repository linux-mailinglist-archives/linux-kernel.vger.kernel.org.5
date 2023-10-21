Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58FD7D1D6D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjJUOSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJUOSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:18:17 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3562197
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:18:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1quCnj-0006rj-Nw; Sat, 21 Oct 2023 16:18:03 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1quCni-003GvF-Oo; Sat, 21 Oct 2023 16:18:02 +0200
Received: from mfe by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1quCni-00FcNW-ME; Sat, 21 Oct 2023 16:18:02 +0200
Date:   Sat, 21 Oct 2023 16:18:02 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: freescale: debix-som-a-bmb-08: Add CSI Power
 Regulators
Message-ID: <20231021141802.7k6irkkgycp4hek7@pengutronix.de>
References: <20231021005250.3498664-1-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021005250.3498664-1-kieran.bingham@ideasonboard.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

thanks for your patch.

On 23-10-21, Kieran Bingham wrote:
> Provide the 1.8 and 3.3 volt regulators that are utilised on the Debix
> SOM BMB-08 base board.
> 
> Facilitate this by also supplying the pin control used to enable the
> regulators on the second MIPI CSI port.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> ---
>  .../freescale/imx8mp-debix-som-a-bmb-08.dts   | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-debix-som-a-bmb-08.dts b/arch/arm64/boot/dts/freescale/imx8mp-debix-som-a-bmb-08.dts
> index 0b0c95432bdc..e058402f1f2e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-debix-som-a-bmb-08.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-debix-som-a-bmb-08.dts
> @@ -63,6 +63,50 @@ regulator-som-vdd3v3 {
>  		regulator-always-on;
>  	};
>  
> +	reg_csi1_1v8: regulator-csi1-vdd1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-name = "CSI1_VDD1V8_SW";

Can we drop the _SW suffix here and below? I like to align the names
with the schematic power-rail names to make it easier to grep.

With that fixed feel free to add my:

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

> +		gpio = <&expander0 13 GPIO_ACTIVE_HIGH>;
> +		vin-supply = <&reg_baseboard_vdd3v3>;
> +		enable-active-high;
> +	};
> +
> +	reg_csi1_3v3: regulator-csi1-vdd3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-name = "CSI1_VDD3V3_SW";
> +		gpio = <&expander0 14 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		vin-supply = <&reg_vdd5v0>;
> +	};
> +
> +	reg_csi2_1v8: regulator-csi2-vdd1v8 {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_csi2_1v8>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-name = "CSI2_VDD1V8_SW";
> +		gpio = <&gpio3 21 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		vin-supply = <&reg_baseboard_vdd3v3>;
> +	};
> +
> +	reg_csi2_3v3: regulator-csi2-vdd3v3 {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_csi2_3v3>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-name = "CSI2_VDD3V3_SW";
> +		gpio = <&gpio4 25 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		vin-supply = <&reg_vdd5v0>;
> +	};
> +
>  	regulator-vbus-usb20 {
>  		compatible = "regulator-fixed";
>  		regulator-min-microvolt = <5000000>;
> @@ -413,6 +457,18 @@ MX8MP_IOMUXC_GPIO1_IO03__GPIO1_IO03		0x41
>  		>;
>  	};
>  
> +	pinctrl_reg_csi2_1v8: regcsi21v8grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI5_RXD0__GPIO3_IO21		0x19
> +		>;
> +	};
> +
> +	pinctrl_reg_csi2_3v3: regcsi23v3grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI2_TXC__GPIO4_IO25		0x19
> +		>;
> +	};
> +
>  	pinctrl_uart2: uart2grp {
>  		fsl,pins = <
>  			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX		0x14f
> -- 
> 2.34.1
> 
> 
