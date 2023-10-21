Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41ED7D1D64
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjJUOI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJUOI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:08:26 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A4C1A8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:08:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1quCe3-0005gd-Ey; Sat, 21 Oct 2023 16:08:03 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1quCe2-003GVr-E8; Sat, 21 Oct 2023 16:08:02 +0200
Received: from mfe by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1quCe2-00FcKc-BI; Sat, 21 Oct 2023 16:08:02 +0200
Date:   Sat, 21 Oct 2023 16:08:02 +0200
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
Subject: Re: [PATCH] arm64: dts: freescale: debix-som: Add heartbeat LED
Message-ID: <20231021140802.4nyyaxclcrqv5n7b@pengutronix.de>
References: <20231021005100.3490929-1-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021005100.3490929-1-kieran.bingham@ideasonboard.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On 23-10-21, Kieran Bingham wrote:
> Map the 'RUN' LED present on the Debix-SOM as a heartbeat.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> ---
>  .../dts/freescale/imx8mp-debix-som-a.dtsi     | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-debix-som-a.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-debix-som-a.dtsi
> index bc312aa1bfc8..c9a81486da48 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-debix-som-a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-debix-som-a.dtsi
> @@ -20,6 +20,19 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
>  		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
>  		enable-active-high;
>  	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_led>;
> +
> +		status {

according the bindings-doc, this should be:

		'led-status' or 'led-0'

> +			label = "yellow:status";

label is deprecated, instead function and color should be used.

With that fixed feel to add my:

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

> +			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
> +			default-state = "on";
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
>  };
>  
>  &A53_0 {
> @@ -203,6 +216,12 @@ &wdog1 {
>  };
>  
>  &iomuxc {
> +	pinctrl_gpio_led: gpioledgrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16		0x19
> +		>;
> +	};
> +
>  	pinctrl_i2c1: i2c1grp {
>  		fsl,pins = <
>  			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL			0x400001c2
> -- 
> 2.34.1
> 
> 
