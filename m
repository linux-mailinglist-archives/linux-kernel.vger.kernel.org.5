Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCAC75C3ED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjGUKBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjGUKBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:01:10 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C669C1999
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 03:01:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so3773927a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 03:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689933667; x=1690538467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qYP+SCMIfwatBAscaRxTLvzZrfuI7oZZEpmIKaCinoE=;
        b=YmZCXLeFrNJAAd6nx5xDMsncZ9XWsL/JOkO/94wS6iTAuVTXtpMC509HGNJiWh8Vmj
         O/ykb4iNw2W7tQBxetghumvnLyNUVrZ68/20vdz2jJxOPQGke2oUcFoaJriXR2xsFJFC
         c/ILWc5UMhG+JLZQzkXCLJveo5P95TpwakKajN/NuhPtL2xT/cY4zqF0N9O9/UYhg2rM
         nhc7VijqnIkpf1+8Ws1HrAMmC9yphsmZVVxenQfracwQ7wXEVQY47kUsUEk++UdDfZIl
         sqoLlEoRrYS1oUnc/lB2zOEtN9XZDxU7v0ixhwyKzkxdiBAFnTpnKpF3r77qQQrmV+Tp
         01vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689933667; x=1690538467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qYP+SCMIfwatBAscaRxTLvzZrfuI7oZZEpmIKaCinoE=;
        b=ceMFQtDJ9UuusaPjNLLgfhywLi5x8UJlu+NAZZ/tAAThqSW9Hlp39GV0JdPGK5WTMN
         gTh+IuSrZ88vCoq/8chswM2ezuquCpQVuC1axPOKUMRfnlqb+4j+b9ztL5ERTRY/peLH
         7RTZ4b/t9UDCGFHD2sn3JBeIu60+eExWqov77mCLJ59TPiSGaDixcBgt8EGLi3peeXd3
         q68AWvyKzeInkxQc/pkeRRnJpg6pCVrXbvXx5CJwp8qLgbMwhQPYoT1sS23/z+UBiE8H
         uvfv6QOR4p7nEFus8ITjPWPDqReY3jE6apXHtf25SU9pBvFmhfmGigzMRZCfAUc/QhL6
         2nJw==
X-Gm-Message-State: ABy/qLY+Xn+6jV0GeOCYahdhcKYkxeTkfY8MNhKb6qLaa7ME+wm8CeOY
        MrW/qip8gjO3xzW8zsIvYiSteg==
X-Google-Smtp-Source: APBJJlFTxdZ38ZNMzA/9cEl2jOIMV45BxKWymfdM5KYfEe5aWsomElgqtBPbiCyo8fQ2jlrH7CX6TQ==
X-Received: by 2002:a05:6402:35c5:b0:521:ef0f:8ef9 with SMTP id z5-20020a05640235c500b00521ef0f8ef9mr688960edc.19.1689933667207;
        Fri, 21 Jul 2023 03:01:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w25-20020aa7dcd9000000b0051e2a6cef4fsm1893129edu.36.2023.07.21.03.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 03:01:06 -0700 (PDT)
Message-ID: <11bcace7-1d9f-c62c-fad4-950a6c79f0a7@linaro.org>
Date:   Fri, 21 Jul 2023 12:01:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 2/4] ARM: dts: imx6qdl: Add Variscite VAR-SOM-MX6 SoM
 support
Content-Language: en-US
To:     James Hilliard <james.hilliard1@gmail.com>,
        devicetree@vger.kernel.org
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230721095003.3681484-1-james.hilliard1@gmail.com>
 <20230721095003.3681484-2-james.hilliard1@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721095003.3681484-2-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2023 11:49, James Hilliard wrote:
> This patch adds support for the Variscite VAR_SOM-MX6 SoM with :
> - i.MX6 Quad or Dual Lite SoC
> - 256 – 4096 MB DDR3
> - 4-64 GB eMMC
> - 128 – 1024 MB SLC NAND
> - Camera Interface
> - HDMI+CEC interface
> - LVDS / DSI / Parallel RGB interfaces
> - Ethernet RGMII interface
> - On-SoM Wi-Fi/Bluetooth with WiLink wl183x SDIO Module
> - SD/MMC/SDIO interface
> - USB Host + USB OTG interface
> - I2C interfaces
> - SPI interfaces
> - PCI-Express 2.0 interface
> - on-SoM Audio Codec with HP/Line-In interfaces + DMIC interface
> - Digital Audio interface
> - S/PDIF interface
> 
> Product website : https://www.variscite.com/product/system-on-module-som/cortex-a9/var-som-mx6-cpu-freescale-imx6/
> 
> Support is handled with a SoM-centric dtsi exporting the default interfaces
> along the default pinmuxing to be enabled by the board dts file.
> 
> This file is based on the one provided by Variscite on their own
> kernel, but adapted for mainline.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  .../arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi | 550 ++++++++++++++++++
>  1 file changed, 550 insertions(+)
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi
> 
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi
> new file mode 100644
> index 000000000000..aa1f37e17f62
> --- /dev/null
> +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-var-som.dtsi
> @@ -0,0 +1,550 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Support for Variscite VAR-SOM-MX6 Module
> + *
> + * Copyright 2011 Linaro Ltd.
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + * Copyright (C) 2014-2016 Variscite, Ltd.
> + * Author: Donio Ron <ron.d@variscite.com>
> + * Copyright 2022 Bootlin
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6q.dtsi"
> +#include <dt-bindings/clock/imx6qdl-clock.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/sound/fsl-imx-audmux.h>
> +
> +/ {
> +	model = "Variscite VAR-SOM-MX6 module";
> +	compatible = "variscite,var-som-imx6q", "fsl,imx6q";
> +
> +	chosen {
> +		stdout-path = &uart1;
> +	};
> +
> +	memory@10000000 {
> +		device_type = "memory";
> +		reg = <0x10000000 0x40000000>;
> +	};
> +
> +	reg_audio: regulator-audio {
> +		compatible = "regulator-fixed";
> +		regulator-name = "tlv320aic3x-supply";

This node looks fake. There is nothing fixed here.

> +	};
> +
> +	reg_3p3v: regulator-3p3v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3P3V";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	touch_3v3_regulator: touch_3v3_regulator {

No underscores in node names. You did receive such comment before, right?

Also, you mix prefix/suffix. Keep one style.

> +		compatible = "regulator-fixed";
> +		regulator-name = "touch_3v3_supply";
> +		regulator-always-on;
> +		status = "okay";

Why?

> +	};
> +
> +	reg_wl18xx_vmmc: regulator-wl18xx {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vwl1807";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		gpio = <&gpio7 8 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		startup-delay-us = <70000>;
> +	};
> +
> +	sound: sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "var-som-audio";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,bitclock-master = <&sound_codec>;
> +		simple-audio-card,frame-master = <&sound_codec>;
> +		simple-audio-card,widgets = "Headphone", "Headphone Jack",
> +					    "Line", "Line In", "Microphone", "Mic Jack";
> +		simple-audio-card,routing = "Headphone Jack", "HPLOUT",
> +					    "Headphone Jack", "HPROUT",
> +					    "LINE1L", "Line In",
> +					    "LINE1R", "Line In";
> +
> +		sound_cpu: simple-audio-card,cpu {
> +			sound-dai = <&ssi2>;
> +		};
> +
> +		sound_codec: simple-audio-card,codec {
> +			sound-dai = <&tlv320aic3106>;
> +			clocks = <&clks IMX6QDL_CLK_CKO>;
> +		};
> +	};
> +
> +	rfkill {
> +		compatible = "rfkill-gpio";
> +		name = "rfkill";
> +		radio-type = "bluetooth";
> +		shutdown-gpios = <&gpio6 18 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +&cpu0 {
> +	operating-points = <
> +		/* kHz    uV */
> +		1200000 1350000
> +		996000  1250000
> +		852000  1250000
> +		792000  1175000
> +		396000  1175000
> +	>;
> +
> +	fsl,soc-operating-points = <
> +		/* ARM kHz  SOC-PU uV */
> +		1200000 1275000
> +		996000	1250000
> +		852000	1250000
> +		792000	1250000
> +		396000	1250000
> +	>;
> +};
> +
> +&audmux {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_audmux>;
> +	status = "okay";
> +
> +	mux-ssi2 {
> +		fsl,audmux-port = <1>;
> +		fsl,port-config = <
> +			(IMX_AUDMUX_V2_PTCR_SYN |
> +			IMX_AUDMUX_V2_PTCR_TFSDIR |
> +			IMX_AUDMUX_V2_PTCR_TFSEL(2) |
> +			IMX_AUDMUX_V2_PTCR_TCLKDIR |
> +			IMX_AUDMUX_V2_PTCR_TCSEL(2))
> +			IMX_AUDMUX_V2_PDCR_RXDSEL(2)
> +		>;
> +	};
> +
> +	mux-aud3 {
> +		fsl,audmux-port = <2>;
> +		fsl,port-config = <
> +			IMX_AUDMUX_V2_PTCR_SYN
> +			IMX_AUDMUX_V2_PDCR_RXDSEL(1)
> +		>;
> +	};
> +};
> +
> +&ecspi3 {
> +	fsl,spi-num-chipselects = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi3>;
> +	cs-gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet>;
> +	phy-mode = "rgmii";
> +	phy-handle = <&rgmii_phy>;
> +	status = "okay";
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		rgmii_phy: ethernet-phy@7 {
> +			reg = <7>;
> +			reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
> +			reset-assert-us = <10000>;
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	pmic@8 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		compatible = "fsl,pfuze100";
> +		reg = <0x08>;
> +
> +		regulators {
> +			sw1a_reg: sw1ab {
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <1875000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <6250>;
> +			};
> +
> +			sw1c_reg: sw1c {
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <1875000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <6250>;
> +			};
> +
> +			sw2_reg: sw2 {
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			sw3a_reg: sw3a {
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3950000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			sw3b_reg: sw3b {
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3950000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			sw4_reg: sw4 {
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3950000>;
> +			};
> +
> +			snvs_reg: vsnvs {
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vref_reg: vrefddr {
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			vgen1_reg: vgen1 {
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1550000>;
> +			};
> +
> +			vgen2_reg: vgen2 {
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1550000>;
> +			};
> +
> +			vgen3_reg: vgen3 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			vgen4_reg: vgen4 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			vgen5_reg: vgen5 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			vgen6_reg: vgen6 {
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +		};
> +	};
> +
> +	tlv320aic3106: codec@1b {
> +		compatible = "ti,tlv320aic3106";
> +		reg = <0x1b>;
> +		#sound-dai-cells = <0>;
> +		DRVDD-supply = <&reg_3p3v>;
> +		AVDD-supply = <&reg_3p3v>;
> +		IOVDD-supply = <&reg_3p3v>;
> +		DVDD-supply = <&reg_3p3v>;
> +		ai3x-ocmv = <0>;
> +		reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>;
> +		ai3x-gpio-func = <
> +			0 /* AIC3X_GPIO1_FUNC_DISABLED */
> +			5 /* AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT */
> +		>;
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	pinctrl_hog: hoggrp {
> +		fsl,pins = <
> +			/* CTW6120 IRQ */
> +			MX6QDL_PAD_EIM_DA7__GPIO3_IO07		0xb0b1
> +			/* SDMMC2 CD/WP */
> +			MX6QDL_PAD_KEY_COL4__GPIO4_IO14		0x1b0b0
> +			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_audmux: audmux {
> +		fsl,pins = <
> +			MX6QDL_PAD_CSI0_DAT7__AUD3_RXD		0x130b0
> +			MX6QDL_PAD_CSI0_DAT4__AUD3_TXC		0x130b0
> +			MX6QDL_PAD_CSI0_DAT5__AUD3_TXD		0x110b0
> +			MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS		0x130b0
> +			/* Audio Clock */
> +			MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0
> +		>;
> +	};
> +
> +	pinctrl_bt: bt {
> +		fsl,pins = <
> +			/* Bluetooth/wifi enable */
> +			MX6QDL_PAD_SD3_DAT6__GPIO6_IO18		0x1b0b1
> +			/* Wifi Slow Clock */
> +			MX6QDL_PAD_ENET_RXD0__OSC32K_32K_OUT	0x000b0
> +		>;
> +	};
> +
> +	pinctrl_ecspi3: ecspi3grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_DISP0_DAT2__ECSPI3_MISO	0x100b1
> +			MX6QDL_PAD_DISP0_DAT1__ECSPI3_MOSI	0x100b1
> +			MX6QDL_PAD_DISP0_DAT0__ECSPI3_SCLK	0x100b1
> +		>;
> +	};
> +
> +	pinctrl_enet: enetgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
> +			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
> +			MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x1b0b0
> +			MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b0b0
> +			MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b0b0
> +			MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b0b0
> +			MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b0b0
> +			MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b0b0
> +			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
> +			MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b0b0
> +			MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b0b0
> +			MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x1b0b0
> +			MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b0b0
> +			MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b0b0
> +			MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_enet_irq: enetirqgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_6__ENET_IRQ	0x000b1
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA	0x4001b8b1
> +			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL	0x4001b8b1
> +		>;
> +	};
> +
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_KEY_COL3__I2C2_SCL	0x4001b8b1
> +			MX6QDL_PAD_KEY_ROW3__I2C2_SDA	0x4001b8b1
> +		>;
> +	};
> +
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_5__I2C3_SCL	0x4001b8b1
> +			MX6QDL_PAD_GPIO_16__I2C3_SDA	0x4001b8b1
> +		>;
> +	};
> +
> +	pinctrl_pmic: pmicgrp {
> +		fsl,pins = <
> +			/* PMIC INT */
> +			MX6QDL_PAD_GPIO_17__GPIO7_IO12	0x1b0b0
> +		>;
> +	};
> +
> +	pinctrl_pwm2: pwm2grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_DISP0_DAT9__PWM2_OUT	0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA 0x1b0b1
> +			MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA 0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD3_DAT4__UART2_RX_DATA	0x1b0b1
> +			MX6QDL_PAD_SD3_DAT5__UART2_TX_DATA	0x1b0b1
> +			MX6QDL_PAD_EIM_D28__UART2_CTS_B		0x1b0b1
> +			MX6QDL_PAD_EIM_D29__UART2_RTS_B		0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD3_CMD__SD3_CMD	0x17069
> +			MX6QDL_PAD_SD3_CLK__SD3_CLK	0x10069
> +			MX6QDL_PAD_SD3_DAT0__SD3_DATA0	0x17069
> +			MX6QDL_PAD_SD3_DAT1__SD3_DATA1	0x17069
> +			MX6QDL_PAD_SD3_DAT2__SD3_DATA2	0x17069
> +			MX6QDL_PAD_SD3_DAT3__SD3_DATA3	0x17069
> +			/* WL_EN */
> +			MX6QDL_PAD_SD3_DAT7__GPIO6_IO17 0x13059
> +			/* WL_IRQ */
> +			MX6QDL_PAD_SD3_RST__GPIO7_IO08  0x13059
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_100mhz: usdhc3grp100mhz {

Still wrong name. They should end with grp.

Best regards,
Krzysztof

