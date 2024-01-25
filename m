Return-Path: <linux-kernel+bounces-38372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0CF83BE73
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2971D295E93
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC18E1CD05;
	Thu, 25 Jan 2024 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Ws7BK2nw"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E1E1CA82;
	Thu, 25 Jan 2024 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177723; cv=none; b=pqdifFyt1HDFSiwmxU8lvUxj8nol6iuFuze1NXNahCYE6IvKIcsHc6cl2CW//0kNY+2rcrA1OQCqp97VF0SzZWhuIB85J9Umvc7TlWImyQSeUMd1kLEMR7gP07lrYIR237IODiGfYEH4p+NPdKd0nSkt6nyW2E1zd57zOdfkkZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177723; c=relaxed/simple;
	bh=2YKlwuxt5pFQQByEYsCtj6hgzRCM6NAYTRVsp3Lkt00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QZNXnGaRXYGDtq74r33pkcnpFjm/SCsMXlvDg50iodWBLhNhHS3UOdxltEaAzudnmrRhEYcFje+fE42MAlVYH5GikFfLG138gPrTqSnHILq8bq0P7y14k7nHjGhcjjoSopjuZ0GW2LkYgSI9GQfKBFzYt7BU9SihWl8gj4oHQbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Ws7BK2nw; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id B216D212DD;
	Thu, 25 Jan 2024 11:15:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1706177712;
	bh=UtmBHmTXg6wIwBgiC3auLqWmDBFs+FPmlvjNDXy0OrU=; h=From:To:Subject;
	b=Ws7BK2nw6+T7ORYo+EyPFpZW2i4zs5Klr/gyZb0jxug4YeMsnwLjDAnk1ESyFPHDY
	 DobbMtnB/o+zTn79rcyjw571wrgdXGMVkI89F8l4mkqZY0H/lUVjnOMYSZ66A5U2Ob
	 d3cDR0cSanUE5y1kAngZayXrduKlJsHeRNvdGM9lOfney/lEukmm9OSYrR1tbhEGpx
	 fJlUQ77J6HTVvNKeZvLRSeOBjAATZoPK8C8VX8nSILNJ4yd14FM0Z42Cv3Q6t9FXnQ
	 Xk/yZf0cA5UpF+DaDxROm+i30HshWeeoTrljVpiPRD8Wbc8faqrm9LeuJlgcA5wBgu
	 RbkoRBbxMxcJw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 2/2] arm64: dts: freescale: imx8qm: add apalis eval v1.2 carrier board
Date: Thu, 25 Jan 2024 11:14:57 +0100
Message-Id: <20240125101457.9873-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240125101457.9873-1-francesco@dolcini.it>
References: <20240125101457.9873-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joao Paulo Goncalves <joao.goncalves@toradex.com>

Add support for the new version, v1.2, of Apalis Evaluation Board.
Because only imx8-apalis-eval.dtsi was available and used as the only
board configuration for board version v1.0 and v1.1, it was changed to
be the common hardware configurations for all versions v1.0,
v1.1 and v1.2. Also, two .dtsi board files were added to have the
differences by board. The .dts were organized by SoM and board version.

Board versions v1.0 and v1.1 are compatible with each other and should
use imx8qm-apalis-eval.dts file or imx8qm-apalis-v1.1-eval.dts file
depending on SoM version. Now for v1.2, organized by SoM version too, the
files are imx8qm-apalis-eval-v1.2.dts and imx8qm-apalis-v1.1-eval-v1.2.dts.

Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 .../dts/freescale/imx8-apalis-eval-v1.1.dtsi  |  26 ++++
 .../dts/freescale/imx8-apalis-eval-v1.2.dtsi  | 124 ++++++++++++++++++
 .../boot/dts/freescale/imx8-apalis-eval.dtsi  |  22 ----
 .../dts/freescale/imx8qm-apalis-eval-v1.2.dts |  16 +++
 .../boot/dts/freescale/imx8qm-apalis-eval.dts |   2 +-
 .../imx8qm-apalis-v1.1-eval-v1.2.dts          |  26 ++++
 .../dts/freescale/imx8qm-apalis-v1.1-eval.dts |   2 +-
 8 files changed, 196 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-apalis-eval-v1.1.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-apalis-eval-v1.2.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-apalis-eval-v1.2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-eval-v1.2.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 2e027675d7bb..91f3371982b5 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -188,8 +188,10 @@ imx8mq-tqma8mq-mba8mx-lvds-tm070jvhg33-dtbs += imx8mq-tqma8mq-mba8mx.dtb imx8mq-
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-tqma8mq-mba8mx-lvds-tm070jvhg33.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8qm-apalis-eval.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8qm-apalis-eval-v1.2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qm-apalis-ixora-v1.1.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qm-apalis-v1.1-eval.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8qm-apalis-v1.1-eval-v1.2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qm-apalis-v1.1-ixora-v1.1.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qm-apalis-v1.1-ixora-v1.2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qm-mek.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-eval-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-eval-v1.1.dtsi
new file mode 100644
index 000000000000..0f77f78f4d96
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-eval-v1.1.dtsi
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2024 Toradex
+ */
+
+#include "imx8-apalis-eval.dtsi"
+
+/* Apalis CAN1 */
+&flexcan1 {
+	status = "okay";
+};
+
+/* Apalis CAN2 */
+&flexcan2 {
+	status = "okay";
+};
+
+/* Apalis MMC1 */
+&usdhc2 {
+	status = "okay";
+};
+
+/* Apalis SD1 */
+&usdhc3 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-eval-v1.2.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-eval-v1.2.dtsi
new file mode 100644
index 000000000000..f5c6a0164f36
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-eval-v1.2.dtsi
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2024 Toradex
+ */
+
+#include "imx8-apalis-eval.dtsi"
+
+/ {
+	reg_3v3_mmc: regulator-3v3-mmc {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_enable_3v3_mmc>;
+		enable-active-high;
+		gpio = <&lsio_gpio5 19 GPIO_ACTIVE_HIGH>;
+		off-on-delay-us = <100000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "3.3V_MMC";
+		startup-delay-us = <10000>;
+	};
+
+	reg_3v3_sd: regulator-3v3-sd {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_enable_3v3_sd>;
+		enable-active-high;
+		gpio = <&lsio_gpio5 20 GPIO_ACTIVE_HIGH>;
+		off-on-delay-us = <100000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "3.3V_SD";
+		startup-delay-us = <10000>;
+	};
+
+	reg_can1: regulator-can1 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_enable_can1_power>;
+		enable-active-high;
+		gpio = <&lsio_gpio5 22 GPIO_ACTIVE_HIGH>;
+		regulator-name = "5V_SW_CAN1";
+		startup-delay-us = <10000>;
+	};
+
+	reg_can2: regulator-can2 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_enable_can2_power>;
+		enable-active-high;
+		gpio = <&lsio_gpio5 21 GPIO_ACTIVE_HIGH>;
+		regulator-name = "5V_SW_CAN2";
+		startup-delay-us = <10000>;
+	};
+};
+
+/* Apalis CAN1 */
+&flexcan1 {
+	xceiver-supply = <&reg_can1>;
+	status = "okay";
+};
+
+/* Apalis CAN2 */
+&flexcan2 {
+	xceiver-supply = <&reg_can2>;
+	status = "okay";
+};
+
+/* Apalis I2C1 */
+&i2c2 {
+	status = "okay";
+
+	/* Power/Current Measurement Sensor */
+	hwmon@40 {
+		compatible = "ti,ina219";
+		reg = <0x40>;
+		shunt-resistor = <5000>;
+	};
+
+	temperature-sensor@4f {
+		compatible = "ti,tmp75c";
+		reg = <0x4f>;
+	};
+
+	eeprom@57 {
+		compatible = "st,24c02", "atmel,24c02";
+		reg = <0x57>;
+	};
+};
+
+/* Apalis MMC1 */
+&usdhc2 {
+	pinctrl-0 = <&pinctrl_usdhc2_4bit>, <&pinctrl_mmc1_cd>;
+	pinctrl-1 = <&pinctrl_usdhc2_4bit_100mhz>, <&pinctrl_mmc1_cd>;
+	pinctrl-2 = <&pinctrl_usdhc2_4bit_200mhz>, <&pinctrl_mmc1_cd>;
+	pinctrl-3 = <&pinctrl_usdhc2_4bit_sleep>, <&pinctrl_mmc1_cd_sleep>;
+	bus-width = <4>;
+	vmmc-supply = <&reg_3v3_mmc>;
+	status = "okay";
+};
+
+/* Apalis SD1 */
+&usdhc3 {
+	vmmc-supply = <&reg_3v3_sd>;
+	status = "okay";
+};
+
+&iomuxc {
+
+	pinctrl_enable_3v3_mmc: enable3v3mmcgrp {
+		fsl,pins = <IMX8QM_USDHC1_DATA4_LSIO_GPIO5_IO19	0x00000021>; /* MXM3_148 */
+	};
+
+	pinctrl_enable_3v3_sd: enable3v3sdgrp {
+		fsl,pins = <IMX8QM_USDHC1_DATA5_LSIO_GPIO5_IO20	0x00000021>; /* MXM3_152 */
+	};
+
+	pinctrl_enable_can1_power: enablecan1powergrp {
+		fsl,pins = <IMX8QM_USDHC1_DATA7_LSIO_GPIO5_IO22	0x00000021>; /* MXM3_158 */
+	};
+
+	pinctrl_enable_can2_power: enablecan2powergrp {
+		fsl,pins = <IMX8QM_USDHC1_DATA6_LSIO_GPIO5_IO21	0x00000021>; /* MXM3_156 */
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
index 685d4294f4f1..deecb96a1596 100644
--- a/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
@@ -35,18 +35,6 @@ &fec1 {
 	status = "okay";
 };
 
-/* Apalis CAN1 */
-&flexcan1 {
-	status = "okay";
-};
-
-/* Apalis CAN2 */
-&flexcan2 {
-	status = "okay";
-};
-
-/* TODO: GPU */
-
 /* Apalis I2C1 */
 &i2c2 {
 	status = "okay";
@@ -132,13 +120,3 @@ &usbotg1 {
 };
 
 /* TODO: Apalis USBH4 SuperSpeed */
-
-/* Apalis MMC1 */
-&usdhc2 {
-	status = "okay";
-};
-
-/* Apalis SD1 */
-&usdhc3 {
-	status = "okay";
-};
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-apalis-eval-v1.2.dts b/arch/arm64/boot/dts/freescale/imx8qm-apalis-eval-v1.2.dts
new file mode 100644
index 000000000000..8466a8204ed0
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-apalis-eval-v1.2.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2024 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx8qm-apalis.dtsi"
+#include "imx8-apalis-eval-v1.2.dtsi"
+
+/ {
+	model = "Toradex Apalis iMX8QM/QP on Apalis Evaluation Board V1.2";
+	compatible = "toradex,apalis-imx8-eval-v1.2",
+		     "toradex,apalis-imx8",
+		     "fsl,imx8qm";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-apalis-eval.dts b/arch/arm64/boot/dts/freescale/imx8qm-apalis-eval.dts
index 5ab0921eb599..b0ebf6d05450 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-apalis-eval.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-apalis-eval.dts
@@ -6,7 +6,7 @@
 /dts-v1/;
 
 #include "imx8qm-apalis.dtsi"
-#include "imx8-apalis-eval.dtsi"
+#include "imx8-apalis-eval-v1.1.dtsi"
 
 / {
 	model = "Toradex Apalis iMX8QM/QP on Apalis Evaluation Board";
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-eval-v1.2.dts b/arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-eval-v1.2.dts
new file mode 100644
index 000000000000..92c0ae0c0337
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-eval-v1.2.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2024 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx8qm-apalis-v1.1.dtsi"
+#include "imx8-apalis-eval-v1.2.dtsi"
+
+/ {
+	model = "Toradex Apalis iMX8QM V1.1 on Apalis Evaluation Board V1.2";
+	compatible = "toradex,apalis-imx8-v1.1-eval-v1.2",
+		     "toradex,apalis-imx8-v1.1",
+		     "fsl,imx8qm";
+};
+
+/* Apalis MMC1 */
+&usdhc2 {
+	/delete-property/ no-1-8-v;
+};
+
+/* Apalis SD1 */
+&usdhc3 {
+	/delete-property/ no-1-8-v;
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-eval.dts b/arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-eval.dts
index c8ff75831556..c998e542f93c 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-eval.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-eval.dts
@@ -6,7 +6,7 @@
 /dts-v1/;
 
 #include "imx8qm-apalis-v1.1.dtsi"
-#include "imx8-apalis-eval.dtsi"
+#include "imx8-apalis-eval-v1.1.dtsi"
 
 / {
 	model = "Toradex Apalis iMX8QM V1.1 on Apalis Evaluation Board";
-- 
2.39.2


