Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11ED75A220
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjGSWmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjGSWmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:42:08 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6314FB3;
        Wed, 19 Jul 2023 15:42:07 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3465bd756afso1390925ab.3;
        Wed, 19 Jul 2023 15:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689806526; x=1692398526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qo/vDkgU4eqkEbuiMzOxbCtbO7IQBvdeAFwU01TCdAA=;
        b=ofJp0x0aFOLdBcvWI32Vohq0kswnm8jjJxyC/6jy2pbUkn0z4mdgY2i5fNFJiqrnz1
         QmiwPKb+Q2kYY9BWWGXo8CgOM5ttpMzM2mSiBKwAL8BoFbcZf1vlgrQ5bLMtPZc7s5PX
         0KbGVT+i+hdqreciMCtoUsZsqVF6dSWKES9GchW6xZ0YU1tUvxpffAtU/JrAqPPGIUFg
         ONhoz6QCW+Wa0wfMaa/EqyKn07TJnmZbEnx1lnB+I6ohJsinHYXWcGVjEBfy0JMR6DiK
         H6EVaxr0GcMcBFtIvTxH2jd2d8YsI/fbskAF4mYiLvHaPpX+pyQJBn8h+Q/+OjrKequK
         uymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689806526; x=1692398526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qo/vDkgU4eqkEbuiMzOxbCtbO7IQBvdeAFwU01TCdAA=;
        b=V7vnu5WgCHbjXU4u2Deq0a6ovgOLvL07VTp1wELOl1nM/vCWlQAQMZMgi4muxNSiyv
         TJYeLobFVq+DhxvmEwNihXufgxzXCv9S3xc+9BGXCIWKEMfldPi5GFs041bKikmEYrNA
         tKLf8BYSbB++jYS7KAsY5rttAAf0q4a7SNLu8ERgzy178DB3I+QeDR3FrvffCZizfjOG
         dAUQaIZ9J1dESp09BzZhlUQ0IIWhDYZlwe4j+y/RJF/oMmA02klt6qmLwezlinvGdQQg
         4vHuGVNx5uhTFvINVHSQ4LqlPu9sKqXN0TfOpn2OFpNyq6ghlyMwdFxbKgXCrhiiuZsF
         JjbA==
X-Gm-Message-State: ABy/qLY09XMwVFqVnY8IdY318hOt7QqlGhtTU1+Bxlz/+GNtri6puH1p
        tYDhgmIN1JsGsvX6t+CSvZ7lXlhtw7daBg==
X-Google-Smtp-Source: APBJJlGKEu/s7Xr8M6RtcaIw6qU3BbIku1UGFSyZU+SIQPZnJAT10qnFPj3ygbxf+dTMnJyhV8VP7w==
X-Received: by 2002:a05:6e02:164c:b0:345:c1cb:864d with SMTP id v12-20020a056e02164c00b00345c1cb864dmr4626505ilu.23.1689806526170;
        Wed, 19 Jul 2023 15:42:06 -0700 (PDT)
Received: from james-x399.localdomain (71-218-225-212.hlrn.qwest.net. [71.218.225.212])
        by smtp.gmail.com with ESMTPSA id e23-20020a02a517000000b0042bb03d3a2esm1548316jam.96.2023.07.19.15.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 15:42:05 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] ARM: dts: imx6q: Add Variscite MX6 Custom board support
Date:   Wed, 19 Jul 2023 16:41:38 -0600
Message-Id: <20230719224141.3716815-2-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719224141.3716815-1-james.hilliard1@gmail.com>
References: <20230719224141.3716815-1-james.hilliard1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the Variscite MX6 SoM Carrier Board.

This Carrier-Board has the following :
- LVDS interface for the VLCD-CAP-GLD-LVDS 7" LCD 800 x 480 touch display
- HDMI Connector
- USB Host + USB OTG Connector
- 10/100/1000 Mbps Ethernet
- miniPCI-Express slot
- SD Card connector
- Audio Headphone/Line In jack connectors
- S-ATA
- On-board DMIC
- RS485 Header
- CAN bus header
- SPI header
- Camera Interfaces header
- OnBoard RTC with Coin Backup battery socket
- RS232 Debug Header (IDC10)
- RS232 DTE

Product Page : https://www.variscite.com/product/single-board-computers/var-mx6customboard

The dts file based on the ones provided by Variscite on their own
kernel, but adapted for mainline.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../arm/boot/dts/imx6q-var-mx6customboard.dts | 279 ++++++++++++++++++
 3 files changed, 281 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-var-mx6customboard.dts

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 15d411084065..0f583852de8a 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -298,6 +298,7 @@ properties:
               - udoo,imx6q-udoo           # Udoo i.MX6 Quad Board
               - uniwest,imx6q-evi         # Uniwest Evi
               - variscite,dt6customboard
+              - variscite,mx6customboard
               - wand,imx6q-wandboard      # Wandboard i.MX6 Quad Board
               - ysoft,imx6q-yapp4-crux    # i.MX6 Quad Y Soft IOTA Crux board
               - ysoft,imx6q-yapp4-pegasus # i.MX6 Quad Y Soft IOTA Pegasus board
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 59829fc90315..9cfc3d3e91ea 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -665,6 +665,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-udoo.dtb \
 	imx6q-utilite-pro.dtb \
 	imx6q-var-dt6customboard.dtb \
+	imx6q-var-mx6customboard.dtb \
 	imx6q-vicut1.dtb \
 	imx6q-wandboard.dtb \
 	imx6q-wandboard-revb1.dtb \
diff --git a/arch/arm/boot/dts/imx6q-var-mx6customboard.dts b/arch/arm/boot/dts/imx6q-var-mx6customboard.dts
new file mode 100644
index 000000000000..66047dff11ec
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-var-mx6customboard.dts
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Support for Variscite MX6 Carrier-board
+ *
+ * Copyright 2016 Variscite, Ltd. All Rights Reserved
+ * Copyright 2022 Bootlin
+ */
+
+/dts-v1/;
+
+#include "imx6qdl-var-som.dtsi"
+#include <dt-bindings/pwm/pwm.h>
+
+/ {
+	model = "Variscite i.MX6 QUAD/DUAL VAR-SOM-MX6 Custom Board";
+	compatible = "variscite,mx6customboard", "fsl,imx6q";
+
+	reg_usb_otg_vbus: regulator-usb-otg-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_usb_h1_vbus: regulator-usb-h1-vbud {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_h1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	reg_audio: regulator-audio {
+		compatible = "regulator-fixed";
+		regulator-name = "tlv320aic3x-supply";
+		enable-active-high;
+	};
+
+	panel0: lvds-panel0 {
+		compatible =  "panel-lvds";
+		backlight = <&backlight_lvds>;
+		width-mm = <152>;
+		height-mm = <91>;
+		label = "etm070001adh6";
+		data-mapping = "jeida-18";
+
+		panel-timing {
+			clock-frequency = <32000000>;
+			hactive = <800>;
+			vactive = <480>;
+			hback-porch = <39>;
+			hfront-porch = <39>;
+			vback-porch = <29>;
+			vfront-porch = <13>;
+			hsync-len = <47>;
+			vsync-len = <2>;
+		};
+
+		port {
+			panel_in_lvds0: endpoint {
+				remote-endpoint = <&lvds0_out>;
+			};
+		};
+	};
+
+	panel1: lvds-panel1 {
+		compatible =  "panel-lvds";
+		width-mm = <152>;
+		height-mm = <91>;
+		data-mapping = "jeida-18";
+
+		panel-timing {
+			clock-frequency = <38251000>;
+			hactive = <800>;
+			vactive = <600>;
+			hback-porch = <112>;
+			hfront-porch = <32>;
+			vback-porch = <3>;
+			vfront-porch = <17>;
+			hsync-len = <80>;
+			vsync-len = <4>;
+		};
+
+		port {
+			panel_in_lvds1: endpoint {
+				remote-endpoint = <&lvds1_out>;
+			};
+		};
+	};
+
+	backlight_lvds: backlight-lvds {
+		compatible = "pwm-backlight";
+		pwms = <&pwm2 0 50000 0>;
+		brightness-levels = <0 4 8 16 32 64 128 248>;
+		default-brightness-level = <7>;
+		power-supply = <&reg_pu>;
+	};
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	touchscreen@24 {
+		compatible = "cypress,tt21000";
+		reg = <0x24>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+		vdd-supply = <&touch_3v3_regulator>;
+		touchscreen-size-x = <880>;
+		touchscreen-size-y = <1280>;
+	};
+
+	touchscreen@38 {
+		compatible = "edt,edt-ft5306";
+		reg = <0x38>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+		touchscreen-size-x = <1800>;
+		touchscreen-size-y = <1000>;
+	};
+};
+
+&iomuxc {
+	pinctrl_ipu1: ipu1grp {
+		fsl,pins = <
+			MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK	0x10
+			MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15		0x10
+			MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02		0x10
+			MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03		0x10
+			MX6QDL_PAD_DI0_PIN4__IPU1_DI0_PIN04		0x80000000
+			MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00	0x10
+			MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01	0x10
+			MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02	0x10
+			MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03	0x10
+			MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04	0x10
+			MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05	0x10
+			MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06	0x10
+			MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07	0x10
+			MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08	0x10
+			MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09	0x10
+			MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10	0x10
+			MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11	0x10
+			MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12	0x10
+			MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13	0x10
+			MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14	0x10
+			MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15	0x10
+			MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16	0x10
+			MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17	0x10
+			MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18	0x10
+			MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19	0x10
+			MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20	0x10
+			MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21	0x10
+			MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22	0x10
+			MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23	0x10
+		>;
+	};
+
+	pinctrl_ipu1: ipu1grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT12__IPU1_CSI0_DATA12		0x80000000
+			MX6QDL_PAD_CSI0_DAT13__IPU1_CSI0_DATA13		0x80000000
+			MX6QDL_PAD_CSI0_DAT14__IPU1_CSI0_DATA14		0x80000000
+			MX6QDL_PAD_CSI0_DAT15__IPU1_CSI0_DATA15		0x80000000
+			MX6QDL_PAD_CSI0_DAT16__IPU1_CSI0_DATA16		0x80000000
+			MX6QDL_PAD_CSI0_DAT17__IPU1_CSI0_DATA17		0x80000000
+			MX6QDL_PAD_CSI0_DAT18__IPU1_CSI0_DATA18		0x80000000
+			MX6QDL_PAD_CSI0_DAT19__IPU1_CSI0_DATA19		0x80000000
+			MX6QDL_PAD_CSI0_DATA_EN__IPU1_CSI0_DATA_EN	0x80000000
+			MX6QDL_PAD_CSI0_PIXCLK__IPU1_CSI0_PIXCLK	0x80000000
+			MX6QDL_PAD_CSI0_MCLK__IPU1_CSI0_HSYNC		0x80000000
+			MX6QDL_PAD_CSI0_VSYNC__IPU1_CSI0_VSYNC		0x80000000
+		>;
+	};
+
+	pinctrl_usbotg_var: usbotggrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x17059
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD1_CMD__SD1_CMD		0x17071
+			MX6QDL_PAD_SD1_CLK__SD1_CLK		0x10071
+			MX6QDL_PAD_SD1_DAT0__SD1_DATA0		0x17071
+			MX6QDL_PAD_SD1_DAT1__SD1_DATA1		0x17071
+			MX6QDL_PAD_SD1_DAT2__SD1_DATA2		0x17071
+			MX6QDL_PAD_SD1_DAT3__SD1_DATA3		0x17071
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD2_CMD__SD2_CMD		0x17059
+			MX6QDL_PAD_SD2_CLK__SD2_CLK		0x10059
+			MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x17059
+			MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
+			MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
+			MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x17059
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_7__FLEXCAN1_TX		0x80000000
+			MX6QDL_PAD_GPIO_8__FLEXCAN1_RX		0x80000000
+		>;
+	};
+};
+
+&usbh1 {
+	vbus-supply = <&reg_usb_h1_vbus>;
+	status = "okay";
+};
+
+&ldb {
+	status = "okay";
+
+	lvds-channel@0 {
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <24>;
+		status = "okay";
+		port@4 {
+			reg = <4>;
+
+			lvds0_out: endpoint {
+				remote-endpoint = <&panel_in_lvds0>;
+			};
+		};
+	};
+
+	lvds-channel@1 {
+		fsl,data-mapping = "spwg";
+		fsl,data-width = <24>;
+		status = "okay";
+		port@4 {
+			reg = <4>;
+
+			lvds1_out: endpoint {
+				remote-endpoint = <&panel_in_lvds1>;
+			};
+		};
+	};
+};
+
+&usbotg {
+	vbus-supply = <&reg_usb_otg_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg_var>;
+	disable-over-current;
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usbphy1 {
+	fsl,tx-d-cal = <0x5>;
+};
+
+&usbphy2 {
+	fsl,tx-d-cal = <0x5>;
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	non-removable;
+	keep-power-in-suspend;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	cd-gpios = <&gpio4 14 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio4 15 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
-- 
2.34.1

