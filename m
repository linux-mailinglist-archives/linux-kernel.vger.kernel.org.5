Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD2B7F97BA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 03:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjK0C5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 21:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjK0C5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 21:57:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC05F111
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 18:57:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B52C433C8;
        Mon, 27 Nov 2023 02:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701053831;
        bh=1JsYrnaKOXBSSBmst8jDG0Y0RikUhacklEL+uSp9B2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=scoiiHyk96Mxd3J3gNIGvbvCMGknLnXXH/B99NhwRHMlmi9aUw76f4n++Z+TL8S5A
         thdYdwiqlUtGTNnGtzxJLBktq9rh6IFk92aoZ7p6Uq/qCWg3zGNk4Y7fkJhWti3Z8I
         h1duZuFN5wz/rbqXvCRfXnrd7HOxMnQ32ucTRifzL4M0fodc7a4M8lRJNL1jFVLoJ1
         geKiuGFQZnji647J2upsd/7RApNWWg6zH6ZX0NPiRW7qSWGNadwakeFMcBx0x4f9Em
         2ng9hRIeI20zM6CEWb3ZT8zBsI2Ovm5Y9uHirQsT0gRMHOIica9X0C3s1h+wsYBSeJ
         O1upfkedU5q/A==
Date:   Mon, 27 Nov 2023 10:57:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     devicetree@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: freescale: debix-som-a-bmb-08: Add CSI
 Power Regulators
Message-ID: <20231127025706.GT87953@dragon>
References: <20231101104614.2209986-1-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101104614.2209986-1-kieran.bingham@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 10:46:11AM +0000, Kieran Bingham wrote:
> Provide the 1.8 and 3.3 volt regulators that are utilised on the Debix
> SOM BMB-08 base board.
> 
> Facilitate this by also supplying the pin control used to enable the
> regulators on the second MIPI CSI port.
> 
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> 
> ---
> v2:
>  - Remove _SW post fixes from regulators.
> 
>  .../freescale/imx8mp-debix-som-a-bmb-08.dts   | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-debix-som-a-bmb-08.dts b/arch/arm64/boot/dts/freescale/imx8mp-debix-som-a-bmb-08.dts
> index 0b0c95432bdc..386177c66c6d 100644
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
> +		regulator-name = "CSI1_VDD1V8";
> +		gpio = <&expander0 13 GPIO_ACTIVE_HIGH>;
> +		vin-supply = <&reg_baseboard_vdd3v3>;
> +		enable-active-high;

Could you move it one line above, so that it appears right after
GPIO_ACTIVE_HIGH polarity?

Shawn

> +	};
> +
> +	reg_csi1_3v3: regulator-csi1-vdd3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-name = "CSI1_VDD3V3";
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
> +		regulator-name = "CSI2_VDD1V8";
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
> +		regulator-name = "CSI2_VDD3V3";
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
