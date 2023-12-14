Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FB9812A43
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbjLNIZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbjLNIZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:25:12 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663CBCF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:25:17 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54cb4fa667bso10835338a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1702542315; x=1703147115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9aQAquZ5xS5RyqBzg0IY2qUUlWniNS/41pwDJpEejQ=;
        b=NFqUpxjKCxOsZo+iE+xAxX9NY7ONSBStE2fQdOaxytfmborWT/dYel5xc1TNh7co9l
         K+dsMlTA+cGnceOQWY0+zR8gHlGiQXoCwQsmd3Ovgojk6lTJSac2izwjBfv7/D5Pouk2
         4lIFiPXmpJ7Anr7Ba5D81Zko6gDmUlUvWeG+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702542315; x=1703147115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9aQAquZ5xS5RyqBzg0IY2qUUlWniNS/41pwDJpEejQ=;
        b=AbyBhD28o6SHhBZeScX3oGTvjAs6gmFxiHSrG8pfLrlSApCe24L3q8QKFWV0E96ywJ
         BZOab/I69XPk4rRg0CCxQ0osyirLzGF5SOYdD5pnOchGoISFZQB/1HT28egkUiBqCSP/
         KPWdrMDluhr/A5FOhU0jkMYa3FJJRN8593KUEng1CYFpi8hnv37IcHYRSxbILk2oda9I
         1O34/YdLHpnX/KFswZtw+gnLZj5URrffAYjHgqLqev1Li+sqOC5FJXVmUqToCgNNYLcu
         EyoSrI1fEfDuqU9xsBI1jJWCh+O1bdlt8aHpjGotuxiXA2m0wbUi92rFHri/Wkj36BLA
         iQfg==
X-Gm-Message-State: AOJu0YyMDP2AA+TzC61euE4IEj3NLhgejXrMqL/rzHO24rakQ1z5xPXx
        BOOTqaLt+yatG4YgkxuEYBOfvUmlXRSdGrk/4q4Fow==
X-Google-Smtp-Source: AGHT+IGXmb2qWB6+qNi8bEZzQAr8bB7d/GG7MzQ1wC+nf012IA2Tojo2jjKmrxUTmAMjbBuurmiIBQ==
X-Received: by 2002:a17:906:154:b0:a22:fb34:dab5 with SMTP id 20-20020a170906015400b00a22fb34dab5mr995470ejh.67.1702542315601;
        Thu, 14 Dec 2023 00:25:15 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-182-13-188.retail.telecomitalia.it. [80.182.13.188])
        by smtp.gmail.com with ESMTPSA id hw18-20020a170907a0d200b00a1cbe52300csm9026226ejc.56.2023.12.14.00.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 00:25:15 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 3/3] arm64: dts: imx8mn-bsh-smm-s2/pro: add display setup
Date:   Thu, 14 Dec 2023 09:24:06 +0100
Message-ID: <20231214082457.18737-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214082457.18737-1-dario.binacchi@amarulasolutions.com>
References: <20231214082457.18737-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Trimarchi <michael@amarulasolutions.com>

Add the display and nodes required for its operation.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v8:
- Move the 'status' property to the end of the list of nodes:
  - pwm1
  - lcdif
  - mipi_dsi
- Add a newline between properties and child node (mipi_dsi_out).
- Sort the iomuxc node alphabetically
- Rename pwm1grp to blgrp

Changes in v7:
- Drop [3/4] dt-bindings: display: panel: Add synaptics r63353 panel controller
  because applied.

Changes in v6:
- Drop patches:
  - [06/10] drm/panel: Add Synaptics R63353 panel driver
  - [07/10] dt-bindings: display: panel: Add Ilitek ili9805 panel controller
  - [08/10] drm/panel: Add Ilitek ILI9805 panel driver
  - [09/10] drm/panel: ilitek-ili9805: add support for Tianma TM041XDHG01 panel
  Because applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)
  Drop patches:
  - [01/10] drm/bridge: Fix bridge disable logic
  - [02/10] drm/bridge: Fix a use case in the bridge disable logic
  Because they are wrong

Changes in v3:
- Replace "synaptics,r63353" compatible with "syna,r63353", as
  required by vendor-prefixes.yaml.
- Squash patch [09/11] dt-bindings: ili9805: add compatible string for Tianma TM041XDHG01
  into [07/11] dt-bindings: display: panel: Add Ilitek ili9805 panel controller.

Changes in v2:
- Adjust the mipi_dsi node based on the latest patches merged into
  the mainline in the dtsi files it includes.
- Added to the series the following patches:
  - 0001 drm/bridge: Fix bridge disable logic
  - 0002 drm/bridge: Fix a use case in the bridge disable logic
  - 0003 samsung-dsim: enter display mode in the enable() callback
  - 0004 drm: bridge: samsung-dsim: complete the CLKLANE_STOP setting

 .../freescale/imx8mn-bsh-smm-s2-common.dtsi   |   1 +
 .../freescale/imx8mn-bsh-smm-s2-display.dtsi  | 121 ++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-display.dtsi

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi
index 22a754d438f1..bbb07c650da9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include "imx8mn.dtsi"
+#include "imx8mn-bsh-smm-s2-display.dtsi"
 
 / {
 	chosen {
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-display.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-display.dtsi
new file mode 100644
index 000000000000..7675583a6b67
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-display.dtsi
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2021 BSH
+ */
+
+/ {
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 700000 0>;	/* 700000 ns = 1337Hz */
+		brightness-levels = <0 100>;
+		num-interpolated-steps = <100>;
+		default-brightness-level = <50>;
+		status = "okay";
+	};
+
+	reg_3v3_dvdd: regulator-3v3-O3 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_dvdd>;
+		regulator-name = "3v3-dvdd-supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 7 GPIO_ACTIVE_LOW>;
+	};
+
+	reg_v3v3_avdd: regulator-3v3-O2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_avdd>;
+		regulator-name = "3v3-avdd-supply";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 5 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_bl>;
+	status = "okay";
+};
+
+&lcdif {
+	assigned-clocks = <&clk IMX8MN_VIDEO_PLL1>;
+	assigned-clock-rates = <594000000>;
+	status = "okay";
+};
+
+&pgc_dispmix {
+	assigned-clocks = <&clk IMX8MN_CLK_DISP_AXI>, <&clk IMX8MN_CLK_DISP_APB>;
+	assigned-clock-parents = <&clk IMX8MN_SYS_PLL2_1000M>, <&clk IMX8MN_SYS_PLL1_800M>;
+	assigned-clock-rates = <500000000>, <200000000>;
+};
+
+&mipi_dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	samsung,esc-clock-frequency = <20000000>;
+	samsung,pll-clock-frequency = <12000000>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "sharp,ls068b3sx02", "syna,r63353";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_panel>;
+		reg = <0>;
+
+		backlight = <&backlight>;
+		dvdd-supply = <&reg_3v3_dvdd>;
+		avdd-supply = <&reg_v3v3_avdd>;
+		reset-gpios = <&gpio4 29 GPIO_ACTIVE_HIGH>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&mipi_dsi_out>;
+			};
+		};
+
+	};
+
+	ports {
+		port@1 {
+			reg = <1>;
+
+			mipi_dsi_out: endpoint {
+				remote-endpoint = <&panel_in>;
+			};
+		};
+	};
+};
+
+&gpu {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_avdd: avddgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_GPIO1_IO05_GPIO1_IO5	0x16	/* VDD 3V3_VO2 */
+		>;
+	};
+
+	/* This is for both PWM and voltage regulators for display */
+	pinctrl_bl: blgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_GPIO1_IO01_PWM1_OUT	0x16
+		>;
+	};
+
+	pinctrl_dvdd: dvddgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_GPIO1_IO07_GPIO1_IO7	0x16	/* VDD 3V3_VO3 */
+		>;
+	};
+
+	pinctrl_panel: panelgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SAI3_RXC_GPIO4_IO29	0x16	/* panel reset */
+		>;
+	};
+};
-- 
2.43.0

