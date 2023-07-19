Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED5F759A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjGSQBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjGSQBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:01:42 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979A2E53;
        Wed, 19 Jul 2023 09:01:40 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-3487d75e4c5so23578765ab.0;
        Wed, 19 Jul 2023 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689782499; x=1692374499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9l6enltr2hidwHdXBUroo3NQQQpJxgBj0DcpGuxgSiU=;
        b=cCuff9cNHLhxYeRl+rJsBk2knc0uKJEBZRtTMl0tgvdYpDVy9p8egoAc86iMz6SN1i
         vdX/k9GZsVnxFGfxjE9TQE8s/SYBYlAhY3RU6jCjh/d6JACTwKQNeXKPc3mgURumpGFZ
         M3FFcr24OgMMCbvzxT/CBU7Pfjr4TSZMtUlDa9UkLeWnBzfnzDFhOAwzvcZscXdgl8oM
         eI9GXx5Y4dZByujrQpKEh7CFB7PCifuHuZHIH9faql8ifbROngO1ZH1CqrUocLkQmBEi
         fF9S8W4GYhFoazCbbjZtHf63j3OJpjDfNhfvtlr6+soyl1KIa078SPrXwotJqnuPLEFo
         2t7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689782499; x=1692374499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9l6enltr2hidwHdXBUroo3NQQQpJxgBj0DcpGuxgSiU=;
        b=bCXFwy+BQ0DhDrEMlOemDnz12fwIS7gqeB0gLgdmGt0HhvrX1q6CyhfVNv9Vqw34TX
         vj90Os86QCNXgzingP9YVQ3ITxVB5CyS9DWRYmingTIZhp8vxiUy1PU0xGtmu/looPMl
         1ao11/8osKTRd35v3oE5W44qD0D74hqNLNKzh/ONBTlHO5rJX9HK5I2XlpyNsXy5/Z+u
         0f4oRfnu0EyIK1YySn+1Zngy8vHZFV+V/hshiNfIO759ofOCb1KIM4X7P8SjxLPVVFh7
         1wfVBbcdXeTdZpfKGM/weP1aBteSUaqnZhH8lhUs6X6ir4S5MzjYqsg9NQph7anqI3WO
         H+3g==
X-Gm-Message-State: ABy/qLZgygzMR+BS6ZphB1MiSNfG7dWP4kI8hSscmO3PczD495N0Mw6A
        3Jn7VOV6Z7itSXShnzg7ngJWo/wa09KPSA==
X-Google-Smtp-Source: APBJJlHQNrm3Jg7FEr1c/6oOoCdimaYqB5w9/r8irBTRMZEtXPGMyseO/3EZ0boph7AF08ylTRRwUQ==
X-Received: by 2002:a92:c549:0:b0:345:d284:5c49 with SMTP id a9-20020a92c549000000b00345d2845c49mr6465012ilj.5.1689782498560;
        Wed, 19 Jul 2023 09:01:38 -0700 (PDT)
Received: from james-x399.localdomain (71-218-225-212.hlrn.qwest.net. [71.218.225.212])
        by smtp.gmail.com with ESMTPSA id x9-20020a92d309000000b00342f537e3c3sm1494293ila.2.2023.07.19.09.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 09:01:37 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: imx6qdl: Add Variscite VAR-SOM-MX6 SoM support
Date:   Wed, 19 Jul 2023 10:00:45 -0600
Message-Id: <20230719160048.2737423-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the Variscite VAR_SOM-MX6 SoM with :
- i.MX6 Quad or Dual Lite SoC
- 256 – 4096 MB DDR3
- 4-64 GB eMMC
- 128 – 1024 MB SLC NAND
- Camera Interface
- HDMI+CEC interface
- LVDS / DSI / Parallel RGB interfaces
- Ethernet RGMII interface
- On-SoM Wi-Fi/Bluetooth with WiLink wl183x SDIO Module
- SD/MMC/SDIO interface
- USB Host + USB OTG interface
- I2C interfaces
- SPI interfaces
- PCI-Express 2.0 interface
- on-SoM Audio Codec with HP/Line-In interfaces + DMIC interface
- Digital Audio interface
- S/PDIF interface

Product website : https://www.variscite.com/product/system-on-module-som/cortex-a9/var-som-mx6-cpu-freescale-imx6/

Support is handled with a SoM-centric dtsi exporting the default interfaces
along the default pinmuxing to be enabled by the board dts file.

This file is based on the one provided by Variscite on their own
kernel, but adapted for mainline.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 arch/arm/boot/dts/imx6qdl-var-som.dtsi | 547 +++++++++++++++++++++++++
 1 file changed, 547 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6qdl-var-som.dtsi

diff --git a/arch/arm/boot/dts/imx6qdl-var-som.dtsi b/arch/arm/boot/dts/imx6qdl-var-som.dtsi
new file mode 100644
index 000000000000..e93dae59624e
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-var-som.dtsi
@@ -0,0 +1,547 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Support for Variscite VAR-SOM-MX6 Module
+ *
+ * Copyright 2011 Linaro Ltd.
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright (C) 2014-2016 Variscite, Ltd.
+ * Author: Donio Ron <ron.d@variscite.com>
+ * Copyright 2022 Bootlin
+ */
+
+/dts-v1/;
+
+#include "imx6q.dtsi"
+#include <dt-bindings/clock/imx6qdl-clock.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/sound/fsl-imx-audmux.h>
+
+/ {
+	model = "Variscite i.MX6 QUAD/DUAL VAR-SOM-MX6";
+	compatible = "fsl,imx6q";
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	memory@10000000 {
+		device_type = "memory";
+		reg = <0x10000000 0x40000000>;
+	};
+
+	reg_audio: regulator-audio {
+		compatible = "regulator-fixed";
+		regulator-name = "tlv320aic3x-supply";
+		enable-active-high;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	touch_3v3_regulator: touch_3v3_regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "touch_3v3_supply";
+		regulator-always-on;
+		status = "okay";
+	};
+
+	reg_wl18xx_vmmc: regulator-wl18xx {
+		compatible = "regulator-fixed";
+		regulator-name = "vwl1807";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		gpio = <&gpio7 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		startup-delay-us = <70000>;
+	};
+
+	sound: sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "var-som-audio";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&sound_codec>;
+		simple-audio-card,frame-master = <&sound_codec>;
+		simple-audio-card,widgets = "Headphone", "Headphone Jack",
+					    "Line", "Line In", "Microphone", "Mic Jack";
+		simple-audio-card,routing = "Headphone Jack", "HPLOUT",
+					    "Headphone Jack", "HPROUT",
+					    "LINE1L", "Line In",
+					    "LINE1R", "Line In";
+
+		sound_cpu: simple-audio-card,cpu {
+			sound-dai = <&ssi2>;
+		};
+
+		sound_codec: simple-audio-card,codec {
+			sound-dai = <&tlv320aic3106>;
+			clocks = <&clks IMX6QDL_CLK_CKO>;
+		};
+	};
+
+	wlan_bt_rfkill {
+		compatible = "rfkill-gpio";
+		name = "wlan_bt_rfkill";
+		type = <2>;     /* bluetooth */
+		gpios = <&gpio6 18 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&cpu0 {
+	operating-points = <
+		/* kHz    uV */
+		1200000 1350000
+		996000  1250000
+		852000  1250000
+		792000  1175000
+		396000  1175000
+	>;
+
+	fsl,soc-operating-points = <
+		/* ARM kHz  SOC-PU uV */
+		1200000 1275000
+		996000	1250000
+		852000	1250000
+		792000	1250000
+		396000	1250000
+	>;
+};
+
+&audmux {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux>;
+	status = "okay";
+
+	ssi2 {
+		fsl,audmux-port = <1>;
+		fsl,port-config = <
+			(IMX_AUDMUX_V2_PTCR_SYN |
+			IMX_AUDMUX_V2_PTCR_TFSDIR |
+			IMX_AUDMUX_V2_PTCR_TFSEL(2) |
+			IMX_AUDMUX_V2_PTCR_TCLKDIR |
+			IMX_AUDMUX_V2_PTCR_TCSEL(2))
+			IMX_AUDMUX_V2_PDCR_RXDSEL(2)
+		>;
+	};
+
+	aud3 {
+		fsl,audmux-port = <2>;
+		fsl,port-config = <
+			IMX_AUDMUX_V2_PTCR_SYN
+			IMX_AUDMUX_V2_PDCR_RXDSEL(1)
+		>;
+	};
+};
+
+&ecspi3 {
+	fsl,spi-num-chipselects = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi3>;
+	cs-gpios = <&gpio4 24 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-mode = "rgmii";
+	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
+	fsl,magic-packet;
+	status = "okay";
+};
+
+&gpc {
+	fsl,ldo-bypass = <1>;
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	pmic@8 {
+		pinctrl-names = "default";
+		compatible = "fsl,pfuze100";
+		reg = <0x08>;
+
+		regulators {
+			sw1a_reg: sw1ab {
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw1c_reg: sw1c {
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw2_reg: sw2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3a_reg: sw3a {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3b_reg: sw3b {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw4_reg: sw4 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
+			snvs_reg: vsnvs {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vref_reg: vrefddr {
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vgen1_reg: vgen1 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+			};
+
+			vgen2_reg: vgen2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+			};
+
+			vgen3_reg: vgen3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			vgen4_reg: vgen4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			vgen5_reg: vgen5 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			vgen6_reg: vgen6 {
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+		};
+	};
+
+	tlv320aic3106: codec@1b {
+		compatible = "ti,tlv320aic3106";
+		reg = <0x1b>;
+		#sound-dai-cells = <0>;
+		DRVDD-supply = <&reg_3p3v>;
+		AVDD-supply = <&reg_3p3v>;
+		IOVDD-supply = <&reg_3p3v>;
+		DVDD-supply = <&reg_3p3v>;
+		ai3x-ocmv = <0>;
+		reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>;
+		ai3x-gpio-func = <
+			0 /* AIC3X_GPIO1_FUNC_DISABLED */
+			5 /* AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT */
+		>;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	imx6qdl-var-som-mx6 {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				/* CTW6120 IRQ */
+				MX6QDL_PAD_EIM_DA7__GPIO3_IO07		0x80000000
+				/* SDMMC2 CD/WP */
+				MX6QDL_PAD_KEY_COL4__GPIO4_IO14		0x80000000
+				MX6QDL_PAD_KEY_ROW4__GPIO4_IO15		0x80000000
+			>;
+		};
+
+		pinctrl_audmux: audmux {
+			fsl,pins = <
+				MX6QDL_PAD_CSI0_DAT7__AUD3_RXD		0x130b0
+				MX6QDL_PAD_CSI0_DAT4__AUD3_TXC		0x130b0
+				MX6QDL_PAD_CSI0_DAT5__AUD3_TXD		0x110b0
+				MX6QDL_PAD_CSI0_DAT6__AUD3_TXFS		0x130b0
+				/* Audio Clock */
+				MX6QDL_PAD_GPIO_0__CCM_CLKO1		0x130b0
+			>;
+		};
+
+		pinctrl_bt: bt {
+			fsl,pins = <
+				/* Bluetooth/wifi enable */
+				MX6QDL_PAD_SD3_DAT6__GPIO6_IO18		0x1b0b1
+				/* Wifi Slow Clock */
+				MX6QDL_PAD_ENET_RXD0__OSC32K_32K_OUT	0x000b0
+			>;
+		};
+
+		pinctrl_ecspi3: ecspi3grp {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT2__ECSPI3_MISO	0x100b1
+				MX6QDL_PAD_DISP0_DAT1__ECSPI3_MOSI	0x100b1
+				MX6QDL_PAD_DISP0_DAT0__ECSPI3_SCLK	0x100b1
+			>;
+		};
+
+		pinctrl_enet: enetgrp {
+			fsl,pins = <
+				MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x1b0b0
+				MX6QDL_PAD_ENET_MDC__ENET_MDC		0x1b0b0
+				MX6QDL_PAD_RGMII_TXC__RGMII_TXC		0x1b0b0
+				MX6QDL_PAD_RGMII_TD0__RGMII_TD0		0x1b0b0
+				MX6QDL_PAD_RGMII_TD1__RGMII_TD1		0x1b0b0
+				MX6QDL_PAD_RGMII_TD2__RGMII_TD2		0x1b0b0
+				MX6QDL_PAD_RGMII_TD3__RGMII_TD3		0x1b0b0
+				MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL	0x1b0b0
+				MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK	0x1b0b0
+				MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b0b0
+				MX6QDL_PAD_RGMII_RD0__RGMII_RD0		0x1b0b0
+				MX6QDL_PAD_RGMII_RD1__RGMII_RD1		0x1b0b0
+				MX6QDL_PAD_RGMII_RD2__RGMII_RD2		0x1b0b0
+				MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b0b0
+				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b0b0
+			>;
+		};
+
+		pinctrl_enet_irq: enetirqgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_6__ENET_IRQ	0x000b1
+			>;
+		};
+
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <
+				MX6QDL_PAD_CSI0_DAT8__I2C1_SDA	0x4001b8b1
+				MX6QDL_PAD_CSI0_DAT9__I2C1_SCL	0x4001b8b1
+			>;
+		};
+
+		pinctrl_i2c2: i2c2grp {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL3__I2C2_SCL	0x4001b8b1
+				MX6QDL_PAD_KEY_ROW3__I2C2_SDA	0x4001b8b1
+			>;
+		};
+
+		pinctrl_i2c3: i2c3grp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_5__I2C3_SCL	0x4001b8b1
+				MX6QDL_PAD_GPIO_16__I2C3_SDA	0x4001b8b1
+			>;
+		};
+
+		pinctrl_pmic: pmicgrp {
+			fsl,pins = <
+				/* PMIC INT */
+				MX6QDL_PAD_GPIO_17__GPIO7_IO12	0x80000000
+			>;
+		};
+
+		pinctrl_pwm2: pwm2grp {
+			fsl,pins = <
+				MX6QDL_PAD_DISP0_DAT9__PWM2_OUT	0x1b0b1
+			>;
+		};
+
+		pinctrl_uart1: uart1grp {
+			fsl,pins = <
+				MX6QDL_PAD_CSI0_DAT10__UART1_TX_DATA 0x1b0b1
+				MX6QDL_PAD_CSI0_DAT11__UART1_RX_DATA 0x1b0b1
+			>;
+		};
+
+		pinctrl_uart2: uart2grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD3_DAT4__UART2_RX_DATA	0x1b0b1
+				MX6QDL_PAD_SD3_DAT5__UART2_TX_DATA	0x1b0b1
+				MX6QDL_PAD_EIM_D28__UART2_CTS_B		0x1b0b1
+				MX6QDL_PAD_EIM_D29__UART2_RTS_B		0x1b0b1
+			>;
+		};
+
+		pinctrl_usdhc3: usdhc3grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD3_CMD__SD3_CMD	0x17069
+				MX6QDL_PAD_SD3_CLK__SD3_CLK	0x10069
+				MX6QDL_PAD_SD3_DAT0__SD3_DATA0	0x17069
+				MX6QDL_PAD_SD3_DAT1__SD3_DATA1	0x17069
+				MX6QDL_PAD_SD3_DAT2__SD3_DATA2	0x17069
+				MX6QDL_PAD_SD3_DAT3__SD3_DATA3	0x17069
+				/* WL_EN */
+				MX6QDL_PAD_SD3_DAT7__GPIO6_IO17 0x13059
+				/* WL_IRQ */
+				MX6QDL_PAD_SD3_RST__GPIO7_IO08  0x13059
+			>;
+		};
+
+		pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
+			fsl,pins = <
+				MX6QDL_PAD_SD3_CMD__SD3_CMD	0x170B9
+				MX6QDL_PAD_SD3_CLK__SD3_CLK	0x100B9
+				MX6QDL_PAD_SD3_DAT0__SD3_DATA0	0x170B9
+				MX6QDL_PAD_SD3_DAT1__SD3_DATA1	0x170B9
+				MX6QDL_PAD_SD3_DAT3__SD3_DATA3	0x170B9
+				MX6QDL_PAD_SD3_DAT3__SD3_DATA3	0x170B9
+				/* WL_EN */
+				MX6QDL_PAD_SD3_DAT7__GPIO6_IO17 0x130B9
+				/* WL_IRQ */
+				MX6QDL_PAD_SD3_RST__GPIO7_IO08  0x130B9
+			>;
+		};
+
+		pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
+			fsl,pins = <
+				MX6QDL_PAD_SD3_CMD__SD3_CMD	0x170F9
+				MX6QDL_PAD_SD3_CLK__SD3_CLK	0x100F9
+				MX6QDL_PAD_SD3_DAT0__SD3_DATA0	0x170F9
+				MX6QDL_PAD_SD3_DAT1__SD3_DATA1	0x170F9
+				MX6QDL_PAD_SD3_DAT2__SD3_DATA2	0x170F9
+				MX6QDL_PAD_SD3_DAT3__SD3_DATA3	0x170F9
+				/* WL_EN */
+				MX6QDL_PAD_SD3_DAT7__GPIO6_IO17 0x130F9
+				/* WL_IRQ */
+				MX6QDL_PAD_SD3_RST__GPIO7_IO08  0x130F9
+			>;
+		};
+
+		pinctrl_gpmi_nand: gpminandgrp {
+			fsl,pins = <
+				MX6QDL_PAD_NANDF_CLE__NAND_CLE		0xb0b1
+				MX6QDL_PAD_NANDF_ALE__NAND_ALE		0xb0b1
+				MX6QDL_PAD_NANDF_CS0__NAND_CE0_B	0xb0b1
+				MX6QDL_PAD_NANDF_CS1__NAND_CE1_B	0xb0b1
+				MX6QDL_PAD_NANDF_RB0__NAND_READY_B	0xb0b1
+				MX6QDL_PAD_NANDF_D0__NAND_DATA00	0xb0b1
+				MX6QDL_PAD_NANDF_D1__NAND_DATA01	0xb0b1
+				MX6QDL_PAD_NANDF_D2__NAND_DATA02	0xb0b1
+				MX6QDL_PAD_NANDF_D3__NAND_DATA03	0xb0b1
+				MX6QDL_PAD_NANDF_D4__NAND_DATA04	0xb0b1
+				MX6QDL_PAD_NANDF_D5__NAND_DATA05	0xb0b1
+				MX6QDL_PAD_NANDF_D6__NAND_DATA06	0xb0b1
+				MX6QDL_PAD_NANDF_D7__NAND_DATA07	0xb0b1
+				MX6QDL_PAD_SD4_CMD__NAND_RE_B		0xb0b1
+				MX6QDL_PAD_SD4_CLK__NAND_WE_B		0xb0b1
+				MX6QDL_PAD_NANDF_WP_B__NAND_WP_B	0xb0b1
+			>;
+		};
+	};
+};
+
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm2>;
+	status = "okay";
+};
+
+&reg_arm {
+	vin-supply = <&sw1a_reg>;
+};
+
+&reg_pu {
+	vin-supply = <&sw1c_reg>;
+};
+
+&reg_soc {
+	vin-supply = <&sw1c_reg>;
+};
+
+&snvs_poweroff {
+	status = "okay";
+};
+
+&ssi2 {
+	fsl,mode = "i2s-slave";
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2 &pinctrl_bt>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand>;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	bus-width = <4>;
+	vmmc-supply = <&reg_wl18xx_vmmc>;
+	non-removable;
+	wakeup-source;
+	keep-power-in-suspend;
+	cap-power-off-card;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	wlcore: wlcore@0 {
+		compatible = "ti,wl1835";
+		reg = <2>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <17 IRQ_TYPE_EDGE_RISING>;
+		ref-clock-frequency = <38400000>;
+	};
+};
+
+&reg_vdd1p1 {
+	vin-supply = <&vgen5_reg>;
+};
+
+&reg_vdd2p5 {
+	vin-supply = <&vgen5_reg>;
+};
-- 
2.34.1

