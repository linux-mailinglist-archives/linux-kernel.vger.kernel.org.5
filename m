Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136887F938D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 16:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjKZPsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 10:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjKZPrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 10:47:24 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3F81BF4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:47:01 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54b532b261bso496769a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701013619; x=1701618419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57RS1TjNb/HqQje9zcsenifzEIw3YsAQboR6CT03G7Q=;
        b=TfsoGZurUYcJK9n7LG/vdgxQcSEBa5gBvua0grM+k0vDMiRjaNeK498yc84FQUIpwd
         srE5ptNStb0qpgtiK3nvI5G2xakiIu+9yk0NWbM7iHceZeMaK3XJB//OKj2WE5rWynTG
         yQ8knmk0eckAQokk0gR7M7wMhHDtLmHi+ttLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701013619; x=1701618419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57RS1TjNb/HqQje9zcsenifzEIw3YsAQboR6CT03G7Q=;
        b=kydUlZAn4gjO8agsUHgXLQcqUa0P+8c83M0H9/BXZV4eZexj3DsErTHrpl0if+mH8b
         FE0Z06ODiFAhQ7ZeWA6f1R54CBkveSaDFDBIih79xk6puhatT51E/ADrQXWHelfSD+Fy
         b6L3iJYIRylbuPpCWuhjOFLEhI1rULidmEgKMdePE229AQn+CLjOHdQ68nCK4InXMBqP
         Q1ofpEgH9zLJl3Zvo125xA/tofg3oi7lSSY8aynHjR03JdJR4bdQ17ZaXO6D43zfgfo6
         hvlRj2YT54NJjXo5gXvESUV/NDCCDdZWR2e70ShmiP3E2GNCDsUF6qPro/eD8IpT1imf
         0MIg==
X-Gm-Message-State: AOJu0YxPuioxolB6ffK9FL/vAowVxAxKooH5+xQB1CDiADOV+OrwqPam
        Wr/Xc69uNLlV/0JQiJ71r5H22LGQq6FSnW9Iyh37Dg==
X-Google-Smtp-Source: AGHT+IFFAkWEHslPxVDi3PxTU7rV1hntw34+Ha2b28xcIGv01rVUUu1t4D3z24GzasVBPbxW+RZUpg==
X-Received: by 2002:a17:906:3751:b0:9dc:2215:1593 with SMTP id e17-20020a170906375100b009dc22151593mr6258179ejc.25.1701013619211;
        Sun, 26 Nov 2023 07:46:59 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-244-100-54.retail.telecomitalia.it. [95.244.100.54])
        by smtp.gmail.com with ESMTPSA id h24-20020a170906591800b009fdc684a79esm4656158ejq.124.2023.11.26.07.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 07:46:58 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 11/11] arm64: dts: imx8mn-bsh-smm-s2/pro: add display setup
Date:   Sun, 26 Nov 2023 16:45:03 +0100
Message-ID: <20231126154605.15767-12-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231126154605.15767-1-dario.binacchi@amarulasolutions.com>
References: <20231126154605.15767-1-dario.binacchi@amarulasolutions.com>
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
index 000000000000..08f173b15495
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
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_bl>;
+};
+
+&lcdif {
+	status = "okay";
+	assigned-clocks = <&clk IMX8MN_VIDEO_PLL1>;
+	assigned-clock-rates = <594000000>;
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
+	status = "okay";
+	samsung,esc-clock-frequency = <20000000>;
+	samsung,pll-clock-frequency = <12000000>;
+
+	panel@0 {
+		compatible = "sharp,ls068b3sx02", "synaptics,r63353";
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
+
+	/* This is for both PWM and voltage regulators for display */
+	pinctrl_bl: pwm1grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_GPIO1_IO01_PWM1_OUT	0x16
+		>;
+	};
+
+	pinctrl_panel: panelgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SAI3_RXC_GPIO4_IO29	0x16	/* panel reset */
+		>;
+	};
+
+	pinctrl_dvdd: dvddgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_GPIO1_IO07_GPIO1_IO7	0x16	/* VDD 3V3_VO3 */
+		>;
+	};
+
+	pinctrl_avdd: avddgrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_GPIO1_IO05_GPIO1_IO5	0x16	/* VDD 3V3_VO2 */
+		>;
+	};
+};
-- 
2.42.0

