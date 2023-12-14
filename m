Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115A1812524
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjLNCRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLNCRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:17:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D49EBD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:17:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B12DC433C7;
        Thu, 14 Dec 2023 02:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702520260;
        bh=RR9Mj0aVnA/eW7GuuUubuStZFpU0qgBFK0cuRAVhtT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UQd0f7b1xYdCRUpe1EXA20dabRv5gz5PEXB1g3O4jwKmhux7+xgzXlxFG2Hy27cTN
         RVwZH3l6sTynCBDOVtpdhWBykbDlTjK19Ili4qt2Hn5Aq7Ts61aRLOKNmzxqeIa8lz
         sjEtkjgkUh3zB0eokO2QZI78cmsus1mVTczbPRHUuxT5QeIpDnAOxcHd+Kq5MukDb2
         +W2SVa1T2AxEyz4D3NjujeTAoU+EcEaLx3H81GbAckuCMyuPdUcUtJ5KVoOftCTSMI
         GtZbjBAG9K9GznckzisWhDTpVfGUG2MOHpqLJCR/RXri2rnLd0fCjm7Yf2yIknlIEt
         M8ath7j2TslbA==
Date:   Thu, 14 Dec 2023 10:17:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com, Conor Dooley <conor+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 10/10] arm64: dts: imx8mn-bsh-smm-s2/pro: add display
 setup
Message-ID: <20231214021734.GX270430@dragon>
References: <20231207141723.108004-1-dario.binacchi@amarulasolutions.com>
 <20231207141723.108004-11-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207141723.108004-11-dario.binacchi@amarulasolutions.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 03:16:39PM +0100, Dario Binacchi wrote:
> From: Michael Trimarchi <michael@amarulasolutions.com>
> 
> Add the display and nodes required for its operation.
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
> (no changes since v3)
> 
> Changes in v3:
> - Replace "synaptics,r63353" compatible with "syna,r63353", as
>   required by vendor-prefixes.yaml.
> - Squash patch [09/11] dt-bindings: ili9805: add compatible string for Tianma TM041XDHG01
>   into [07/11] dt-bindings: display: panel: Add Ilitek ili9805 panel controller.
> 
> Changes in v2:
> - Adjust the mipi_dsi node based on the latest patches merged into
>   the mainline in the dtsi files it includes.
> - Added to the series the following patches:
>   - 0001 drm/bridge: Fix bridge disable logic
>   - 0002 drm/bridge: Fix a use case in the bridge disable logic
>   - 0003 samsung-dsim: enter display mode in the enable() callback
>   - 0004 drm: bridge: samsung-dsim: complete the CLKLANE_STOP setting
> 
>  .../freescale/imx8mn-bsh-smm-s2-common.dtsi   |   1 +
>  .../freescale/imx8mn-bsh-smm-s2-display.dtsi  | 121 ++++++++++++++++++
>  2 files changed, 122 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-display.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi
> index 22a754d438f1..bbb07c650da9 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi
> @@ -7,6 +7,7 @@
>  /dts-v1/;
>  
>  #include "imx8mn.dtsi"
> +#include "imx8mn-bsh-smm-s2-display.dtsi"
>  
>  / {
>  	chosen {
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-display.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-display.dtsi
> new file mode 100644
> index 000000000000..f0a924cbe548
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-display.dtsi
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2021 BSH
> + */
> +
> +/ {
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm1 0 700000 0>;	/* 700000 ns = 1337Hz */
> +		brightness-levels = <0 100>;
> +		num-interpolated-steps = <100>;
> +		default-brightness-level = <50>;
> +		status = "okay";
> +	};
> +
> +	reg_3v3_dvdd: regulator-3v3-O3 {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_dvdd>;
> +		regulator-name = "3v3-dvdd-supply";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio1 7 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	reg_v3v3_avdd: regulator-3v3-O2 {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_avdd>;
> +		regulator-name = "3v3-avdd-supply";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio1 5 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&pwm1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_bl>;

We usually end property list with 'status'.

> +};
> +
> +&lcdif {
> +	status = "okay";

Ditto

> +	assigned-clocks = <&clk IMX8MN_VIDEO_PLL1>;
> +	assigned-clock-rates = <594000000>;
> +};
> +
> +&pgc_dispmix {
> +	assigned-clocks = <&clk IMX8MN_CLK_DISP_AXI>, <&clk IMX8MN_CLK_DISP_APB>;
> +	assigned-clock-parents = <&clk IMX8MN_SYS_PLL2_1000M>, <&clk IMX8MN_SYS_PLL1_800M>;
> +	assigned-clock-rates = <500000000>, <200000000>;
> +};
> +
> +&mipi_dsi {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";

Ditto

> +	samsung,esc-clock-frequency = <20000000>;
> +	samsung,pll-clock-frequency = <12000000>;
> +
> +	panel@0 {
> +		compatible = "sharp,ls068b3sx02", "syna,r63353";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_panel>;
> +		reg = <0>;
> +
> +		backlight = <&backlight>;
> +		dvdd-supply = <&reg_3v3_dvdd>;
> +		avdd-supply = <&reg_v3v3_avdd>;
> +		reset-gpios = <&gpio4 29 GPIO_ACTIVE_HIGH>;
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&mipi_dsi_out>;
> +			};
> +		};
> +
> +	};
> +
> +	ports {
> +		port@1 {
> +			reg = <1>;

Have a newline between properties and child node.

> +			mipi_dsi_out: endpoint {
> +				remote-endpoint = <&panel_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&gpu {
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +
> +	/* This is for both PWM and voltage regulators for display */
> +	pinctrl_bl: pwm1grp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_GPIO1_IO01_PWM1_OUT	0x16
> +		>;
> +	};
> +
> +	pinctrl_panel: panelgrp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_SAI3_RXC_GPIO4_IO29	0x16	/* panel reset */
> +		>;
> +	};
> +
> +	pinctrl_dvdd: dvddgrp {
> +		fsl,pins = <
> +			MX8MN_IOMUXC_GPIO1_IO07_GPIO1_IO7	0x16	/* VDD 3V3_VO3 */
> +		>;
> +	};
> +
> +	pinctrl_avdd: avddgrp {

Can we sort the pinctrl node alphabetically?

Shawn

> +		fsl,pins = <
> +			MX8MN_IOMUXC_GPIO1_IO05_GPIO1_IO5	0x16	/* VDD 3V3_VO2 */
> +		>;
> +	};
> +};
> -- 
> 2.43.0
> 
