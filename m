Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11802759A5F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjGSQBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjGSQBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:01:44 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8598D113;
        Wed, 19 Jul 2023 09:01:42 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-345a76c3a2eso32449175ab.2;
        Wed, 19 Jul 2023 09:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689782501; x=1692374501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imyGtKPK1qBZyAAZmgCxRLenzEgq5c/cTQv8FoyykhQ=;
        b=cw5HprOLSJfRB/OBMwnp61N8XPzjbh0GtXIWX+r4GXsGa6E8kMjcZauLxo/spv4MC9
         K34dU4guFgyM1tAGQrZpOwPczQJbsVoPJuaxPLwCVco3RK/NJ9qRcFMsA8OP1vtYx679
         sE9xko/bQSKYt6f4Yl9uEVSUqbNmL5nejbAh8dCYq0ltvBuqcebRxD3DJLcc434Jh80M
         rot7Hw8RgTGf+9DlVdc70QC9fs8jG0aovhE0hjtyK1LqgTQjdP/axUaiy/agZnscouLA
         RKW0OODc/8lrResFZzqnV4JqAnWNqDEPUL6gU8T3V5l0Z+KOskf6wawpi8WUEZWReGiZ
         xv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689782501; x=1692374501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imyGtKPK1qBZyAAZmgCxRLenzEgq5c/cTQv8FoyykhQ=;
        b=SwTChc83EE//wsc3F8kxMDt4pdkvMp6C0jeHDnEMxKHBNV2IHL/Q3NCiLjpaVsDvLp
         4J0DtOdBoX0pZKjU5wcfd/HbdNVBMNJqhbYF7vbjwlldyNXkw42JEKx7adOjEaNsovxH
         3rvsBfm/zaJutf6eenqq/pXZdsW+JqTo34VP4Lk5vCvysjZeikAc7ey+60kXNW4ScBkT
         pZFR8yX1MMQimFpOl7Un4gL6JbOv35sEf90jxATyMU6G/HWmxkHJ2gEulvnwatW75OTS
         blM95jy22MuJ0E799igQSo58aJolUUqORsw4ZaYFZIizZ/GqdMVrh4sMY/Mk2UyIJ+4m
         uTQA==
X-Gm-Message-State: ABy/qLbRKCaGJmXuK+GEsbuKu8uzWuoOslsiKNHDTeA3TV9OrgIRB6+7
        c3064OVpF0N4y+/UoGHN/KK0eZ1sNIiXPA==
X-Google-Smtp-Source: APBJJlE8Gp3GTAyp/vFrf5b0ioQh0SnmxLyt94ipRoDdrVtUaoJn38iu6I1Nbc1NO66p6zdbwnxOEA==
X-Received: by 2002:a05:6e02:216f:b0:345:e1be:1567 with SMTP id s15-20020a056e02216f00b00345e1be1567mr6401299ilv.25.1689782501379;
        Wed, 19 Jul 2023 09:01:41 -0700 (PDT)
Received: from james-x399.localdomain (71-218-225-212.hlrn.qwest.net. [71.218.225.212])
        by smtp.gmail.com with ESMTPSA id x9-20020a92d309000000b00342f537e3c3sm1494293ila.2.2023.07.19.09.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 09:01:40 -0700 (PDT)
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
Subject: [PATCH 2/2] ARM: dts: imx6q: Add Variscite MX6 Custom board support
Date:   Wed, 19 Jul 2023 10:00:46 -0600
Message-Id: <20230719160048.2737423-2-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230719160048.2737423-1-james.hilliard1@gmail.com>
References: <20230719160048.2737423-1-james.hilliard1@gmail.com>
MIME-Version: 1.0
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
 arch/arm/boot/dts/Makefile                    |   1 +
 .../arm/boot/dts/imx6q-var-mx6customboard.dts | 291 ++++++++++++++++++
 2 files changed, 292 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-var-mx6customboard.dts

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
index 000000000000..47e39a6dc611
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-var-mx6customboard.dts
@@ -0,0 +1,291 @@
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
+	model = "Variscite MX6 Custom Board";
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
+				clock-frequency = <32000000>;
+				hactive = <800>;
+				vactive = <480>;
+				hback-porch = <39>;
+				hfront-porch = <39>;
+				vback-porch = <29>;
+				vfront-porch = <13>;
+				hsync-len = <47>;
+				vsync-len = <2>;
+			};
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
+				clock-frequency = <38251000>;
+				hactive = <800>;
+				vactive = <600>;
+				hback-porch = <112>;
+				hfront-porch = <32>;
+				vback-porch = <3>;
+				vfront-porch = <17>;
+				hsync-len = <80>;
+				vsync-len = <4>;
+			};
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
+		status = "okay";
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
+		touchscreen-size-x = <880>;
+		touchscreen-size-y = <1280>;
+	};
+
+	touchscreen@38 {
+		compatible = "edt,edt-ft5x06";
+		reg = <0x38>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+		touchscreen-size-x = <1800>;
+		touchscreen-size-y = <1000>;
+	};
+};
+
+&iomuxc {
+	imx6qdl-var-som-mx6 {
+
+		pinctrl_ipu1: ipu1grp {
+			fsl,pins = <
+				MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK	0x10
+				MX6QDL_PAD_DI0_PIN15__IPU1_DI0_PIN15		0x10
+				MX6QDL_PAD_DI0_PIN2__IPU1_DI0_PIN02		0x10
+				MX6QDL_PAD_DI0_PIN3__IPU1_DI0_PIN03		0x10
+				MX6QDL_PAD_DI0_PIN4__IPU1_DI0_PIN04		0x80000000
+				MX6QDL_PAD_DISP0_DAT0__IPU1_DISP0_DATA00	0x10
+				MX6QDL_PAD_DISP0_DAT1__IPU1_DISP0_DATA01	0x10
+				MX6QDL_PAD_DISP0_DAT2__IPU1_DISP0_DATA02	0x10
+				MX6QDL_PAD_DISP0_DAT3__IPU1_DISP0_DATA03	0x10
+				MX6QDL_PAD_DISP0_DAT4__IPU1_DISP0_DATA04	0x10
+				MX6QDL_PAD_DISP0_DAT5__IPU1_DISP0_DATA05	0x10
+				MX6QDL_PAD_DISP0_DAT6__IPU1_DISP0_DATA06	0x10
+				MX6QDL_PAD_DISP0_DAT7__IPU1_DISP0_DATA07	0x10
+				MX6QDL_PAD_DISP0_DAT8__IPU1_DISP0_DATA08	0x10
+				MX6QDL_PAD_DISP0_DAT9__IPU1_DISP0_DATA09	0x10
+				MX6QDL_PAD_DISP0_DAT10__IPU1_DISP0_DATA10	0x10
+				MX6QDL_PAD_DISP0_DAT11__IPU1_DISP0_DATA11	0x10
+				MX6QDL_PAD_DISP0_DAT12__IPU1_DISP0_DATA12	0x10
+				MX6QDL_PAD_DISP0_DAT13__IPU1_DISP0_DATA13	0x10
+				MX6QDL_PAD_DISP0_DAT14__IPU1_DISP0_DATA14	0x10
+				MX6QDL_PAD_DISP0_DAT15__IPU1_DISP0_DATA15	0x10
+				MX6QDL_PAD_DISP0_DAT16__IPU1_DISP0_DATA16	0x10
+				MX6QDL_PAD_DISP0_DAT17__IPU1_DISP0_DATA17	0x10
+				MX6QDL_PAD_DISP0_DAT18__IPU1_DISP0_DATA18	0x10
+				MX6QDL_PAD_DISP0_DAT19__IPU1_DISP0_DATA19	0x10
+				MX6QDL_PAD_DISP0_DAT20__IPU1_DISP0_DATA20	0x10
+				MX6QDL_PAD_DISP0_DAT21__IPU1_DISP0_DATA21	0x10
+				MX6QDL_PAD_DISP0_DAT22__IPU1_DISP0_DATA22	0x10
+				MX6QDL_PAD_DISP0_DAT23__IPU1_DISP0_DATA23	0x10
+			>;
+		};
+
+		pinctrl_ipu1: ipu1grp {
+			fsl,pins = <
+				MX6QDL_PAD_CSI0_DAT12__IPU1_CSI0_DATA12		0x80000000
+				MX6QDL_PAD_CSI0_DAT13__IPU1_CSI0_DATA13		0x80000000
+				MX6QDL_PAD_CSI0_DAT14__IPU1_CSI0_DATA14		0x80000000
+				MX6QDL_PAD_CSI0_DAT15__IPU1_CSI0_DATA15		0x80000000
+				MX6QDL_PAD_CSI0_DAT16__IPU1_CSI0_DATA16		0x80000000
+				MX6QDL_PAD_CSI0_DAT17__IPU1_CSI0_DATA17		0x80000000
+				MX6QDL_PAD_CSI0_DAT18__IPU1_CSI0_DATA18		0x80000000
+				MX6QDL_PAD_CSI0_DAT19__IPU1_CSI0_DATA19		0x80000000
+				MX6QDL_PAD_CSI0_DATA_EN__IPU1_CSI0_DATA_EN	0x80000000
+				MX6QDL_PAD_CSI0_PIXCLK__IPU1_CSI0_PIXCLK	0x80000000
+				MX6QDL_PAD_CSI0_MCLK__IPU1_CSI0_HSYNC		0x80000000
+				MX6QDL_PAD_CSI0_VSYNC__IPU1_CSI0_VSYNC		0x80000000
+			>;
+		};
+
+		pinctrl_usbotg_var: usbotggrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x17059
+			>;
+		};
+
+		pinctrl_usdhc1: usdhc1grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD1_CMD__SD1_CMD		0x17071
+				MX6QDL_PAD_SD1_CLK__SD1_CLK		0x10071
+				MX6QDL_PAD_SD1_DAT0__SD1_DATA0		0x17071
+				MX6QDL_PAD_SD1_DAT1__SD1_DATA1		0x17071
+				MX6QDL_PAD_SD1_DAT2__SD1_DATA2		0x17071
+				MX6QDL_PAD_SD1_DAT3__SD1_DATA3		0x17071
+			>;
+		};
+
+		pinctrl_usdhc2: usdhc2grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD2_CMD__SD2_CMD		0x17059
+				MX6QDL_PAD_SD2_CLK__SD2_CLK		0x10059
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0		0x17059
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1		0x17059
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2		0x17059
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3		0x17059
+			>;
+		};
+
+		pinctrl_flexcan1: flexcan1grp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_7__FLEXCAN1_TX		0x80000000
+				MX6QDL_PAD_GPIO_8__FLEXCAN1_RX		0x80000000
+			>;
+		};
+	};
+};
+
+&mipi_csi {
+	status = "okay";
+	ipu_id = <0>;
+	csi_id = <1>;
+	v_channel = <0>;
+	lanes = <2>;
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
+		primary;
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
+		primary;
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
+	tx-d-cal = <0x5>;
+};
+
+&usbphy2 {
+	tx-d-cal = <0x5>;
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	non-removable;
+	keep-power-in-suspend;
+	enable-sdio-wakeup;
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

