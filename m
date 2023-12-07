Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B2D808A5A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443297AbjLGOVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443202AbjLGOU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:20:59 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D702B172D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:17:57 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1ca24776c3so421086466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 06:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701958660; x=1702563460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDRPnKJoLc1GtAiBypAVTx3BYAZsoeFq7nosJJNba1U=;
        b=OWVdCebD/p18Sd/Tp2wK3WgVJNIfz1UJFwfoGgW7M0L3/LPqPD0EMPAYPaZxCHEiH2
         JHVaEObB2Sl1eofaWVQTO4FCPhAHqZOUvwCcaVSQIT0N/G+suyhlCUxiS9hasJEh9CET
         mxrsYtDOADRAWKN/WbdDui6yuWw4UW61E1/x8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701958660; x=1702563460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDRPnKJoLc1GtAiBypAVTx3BYAZsoeFq7nosJJNba1U=;
        b=V/8J6XfeHGHrphxhtuFuCt/mE4m0d8hgbGn4mQ0JKBUyI8HLQF+tBG0AdvWejs5Dex
         g07UXe+NDNkUz9XxGmaF85rJdbsRuHSGispVjzA/BXDykG8gkmxawlFdJikZxrftlekH
         yG2NbOfgXjV0CECAA8riz+ctzUV4SN0lOVd0tKbfDcsSZui1TsWLPcRxiIobA2cv0fqU
         1PiySt+p/9WPMV8VT5oMhOzZYAa8fLQSZqqU/6xiiH1b7v+2EkAwU8nkS70U8yO8SBs2
         AeS2fdoHsE3gYdXkXFW4vn/a1t5tpObbgCnB6lxf8r09D4uMW17Vu/6HXe4Arg6Cb/vW
         I0ig==
X-Gm-Message-State: AOJu0Yy1l9jvzpp44x3RrPAIboyIS7ETE4741UUEXUQzg2KSDHc4kufO
        GLosOlBJh9hZu/VSU/UmQAQFWwCD+zlPKaebcYTqwg==
X-Google-Smtp-Source: AGHT+IHXPvn6IvoGp2sVl4wkLbXJW425CzuDHmOPxPKav++5GtwF/E6tPuNYsgNO3z6V9+SGZIVv6g==
X-Received: by 2002:a17:906:185:b0:a1d:d900:271b with SMTP id 5-20020a170906018500b00a1dd900271bmr2514800ejb.2.1701958660547;
        Thu, 07 Dec 2023 06:17:40 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:9bf:959c:3c66:46c2])
        by smtp.gmail.com with ESMTPSA id f24-20020a170906c09800b00a1e814b7155sm885421ejz.62.2023.12.07.06.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:17:40 -0800 (PST)
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
Subject: [PATCH v5 10/10] arm64: dts: imx8mn-bsh-smm-s2/pro: add display setup
Date:   Thu,  7 Dec 2023 15:16:39 +0100
Message-ID: <20231207141723.108004-11-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231207141723.108004-1-dario.binacchi@amarulasolutions.com>
References: <20231207141723.108004-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

(no changes since v3)

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
index 000000000000..f0a924cbe548
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
2.43.0

