Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C5C75C3BF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjGUJx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjGUJwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:52:37 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B8E35A1;
        Fri, 21 Jul 2023 02:51:29 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7836272f36eso73862539f.1;
        Fri, 21 Jul 2023 02:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689933053; x=1690537853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqPKyRxxLZpbVIt61pk9388209SXq1s0OBIPPoyEkns=;
        b=Nz2lxT6hO1YFJj+19PBnbpOwzLpuI0sxZzWikpqk8FAmzorLxHKuypP3JumdBDhRzG
         1/jUzakJ0W8HdUG+6ho+jQdbQMRmM/s1f05L6hDOE6qUaQNMgUb2/IsGhc229QkVdxC0
         qSDa2dMO+mN2WbBWgDkuf/96ktA+qrn3r/YFssfgXhZWBgAKw+CPKYGA+yJbA9fTJ/IQ
         K7m6xpyb2w//4OI1XNOg3zRd9uv0s7Baj5U2gEHLU+Vi33iNHPrQkVWqOibxzles+bE1
         rXxQq+Jq0qFr0V+grAmmL5/s8Ih6rUZr33RAmIi3njT+3vP/DPkqCaJYocTiFKRZrXl3
         1M2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689933053; x=1690537853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqPKyRxxLZpbVIt61pk9388209SXq1s0OBIPPoyEkns=;
        b=NNiDXLZj4Ob1mT7qVaoiKgBfLGUxs0cmgohKS6AA9tlhjClug4i4Ef0vxQhzDIUcRQ
         T54NJ4tx8p9Y6jbO86iaVpSA6cMxZLnJMlMIfGiT9pC6qUTUi+WNOnGdfrS/1bs2GJyk
         f1VlITGY+nwJR1/cuf6u8O+wRnR5CoIEVSFgAoIXbzDIvtP3lnGZUs28C/GJJ7G+sXsm
         wKH9PqOyf2VVv+Cj+jFKkOVlrW39gfCWqlQLYzTD9fWIh2eMsk38llzzChsANAS3eUBd
         9EFHq9AYWYQ98huwKag8pYGfJppNcOSXqujXYhEO6d79AuKT2pLonoPX+9/ng3ezlBTY
         vt9Q==
X-Gm-Message-State: ABy/qLbd5aOyHFFKdC/eXKEUxJhX3LB1M/mqs/EECpE/y2PbVm0kvVV5
        7FTPTj4VsdbKIkZko/KNCRs4sDoJWPjuWg==
X-Google-Smtp-Source: APBJJlEQVSDFHJkqXNInZaeOyMfjsxQ5N82VgDXea04DQEkTXLg38oSRYDh7sKcsnfBp+IeiSRaRpQ==
X-Received: by 2002:a05:6e02:92c:b0:345:baef:842b with SMTP id o12-20020a056e02092c00b00345baef842bmr1285720ilt.25.1689933052727;
        Fri, 21 Jul 2023 02:50:52 -0700 (PDT)
Received: from james-x399.localdomain (71-218-225-212.hlrn.qwest.net. [71.218.225.212])
        by smtp.gmail.com with ESMTPSA id t8-20020a056e02010800b00348ac48e127sm787066ilm.33.2023.07.21.02.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 02:50:52 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 4/4] ARM: dts: imx6q: Add Variscite MX6 Custom board support
Date:   Fri, 21 Jul 2023 03:50:00 -0600
Message-Id: <20230721095003.3681484-4-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721095003.3681484-1-james.hilliard1@gmail.com>
References: <20230721095003.3681484-1-james.hilliard1@gmail.com>
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
 arch/arm/boot/dts/nxp/imx/Makefile            |   1 +
 .../dts/nxp/imx/imx6q-var-mx6customboard.dts  | 280 ++++++++++++++++++
 2 files changed, 281 insertions(+)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts

diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
index 3629e343d322..258ec0e5b712 100644
--- a/arch/arm/boot/dts/nxp/imx/Makefile
+++ b/arch/arm/boot/dts/nxp/imx/Makefile
@@ -244,6 +244,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-udoo.dtb \
 	imx6q-utilite-pro.dtb \
 	imx6q-var-dt6customboard.dtb \
+	imx6q-var-mx6customboard.dtb \
 	imx6q-vicut1.dtb \
 	imx6q-wandboard.dtb \
 	imx6q-wandboard-revb1.dtb \
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts b/arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts
new file mode 100644
index 000000000000..3ca3662fd0d3
--- /dev/null
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-var-mx6customboard.dts
@@ -0,0 +1,280 @@
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
+	compatible = "variscite,mx6customboard", "variscite,var-som-imx6q", "fsl,imx6q";
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
+		power-supply = <&reg_3p3v>;
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
+			MX6QDL_PAD_DI0_PIN4__IPU1_DI0_PIN04		0x10
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
+	pinctrl_camera: cameragrp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT12__IPU1_CSI0_DATA12		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT13__IPU1_CSI0_DATA13		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT14__IPU1_CSI0_DATA14		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT15__IPU1_CSI0_DATA15		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT16__IPU1_CSI0_DATA16		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT17__IPU1_CSI0_DATA17		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT18__IPU1_CSI0_DATA18		0x1b0b0
+			MX6QDL_PAD_CSI0_DAT19__IPU1_CSI0_DATA19		0x1b0b0
+			MX6QDL_PAD_CSI0_DATA_EN__IPU1_CSI0_DATA_EN	0x1b0b0
+			MX6QDL_PAD_CSI0_PIXCLK__IPU1_CSI0_PIXCLK	0x1b0b0
+			MX6QDL_PAD_CSI0_MCLK__IPU1_CSI0_HSYNC		0x1b0b0
+			MX6QDL_PAD_CSI0_VSYNC__IPU1_CSI0_VSYNC		0x1b0b0
+		>;
+	};
+
+	pinctrl_flexcan1: flexcan1grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_7__FLEXCAN1_TX		0x1b0b0
+			MX6QDL_PAD_GPIO_8__FLEXCAN1_RX		0x1b0b0
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
+
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
+
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

