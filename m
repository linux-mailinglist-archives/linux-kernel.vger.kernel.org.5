Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198A37B4D6D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 10:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbjJBIoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 04:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbjJBIoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 04:44:09 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6252CC4;
        Mon,  2 Oct 2023 01:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1696236245; x=1727772245;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=G/1++m4AYsraMpvmWdQb3QVWnH9LMYX4JZi0HZm0D4U=;
  b=gTR6o/TkfijjXJ/3h5R6hhmhkuFG4yJqSxEIncr+qd96bzYFWNPuFjTJ
   j0gaxmqTnOwfDM2hfzOolLsoOiX/8dxtUM3Wpf6Clq5V0dri7a+GwFm+c
   Kz5Dn5hhGCVLiEEYMCyY0RXTTt94yyYVnQEAmQf/RZ4zjDzWQiSGCrRe3
   BCviuDa1nXQoIgPiKvaYwPN0qosdQ1SJ/tcHlqAB83LuX2wXRen1g1qji
   KOlIIznB2yyM90W/aUDBlhMdvowFNYJ+1GinwLY/eJtGWxL8tg9NxyfHE
   LlSXHxfDExGlKsX/gMJYxcvIqzitzLhxtvj/9B5DFipbY0lxdOZAKemKp
   w==;
X-IronPort-AV: E=Sophos;i="6.03,193,1694728800"; 
   d="scan'208";a="33241248"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 02 Oct 2023 10:43:59 +0200
Received: from [127.0.1.1] (herburgerg-w2.tq-net.de [10.122.52.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 75B10280086;
        Mon,  2 Oct 2023 10:43:59 +0200 (CEST)
From:   Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date:   Mon, 02 Oct 2023 10:43:52 +0200
Subject: [PATCH v3 3/5] arm64: dts: freescale: add initial device tree for
 TQMLS1043A/TQMLS1046A
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231002-for-ml-tqmls10xxa-v2-test-v3-3-402819b9a29b@ew.tq-group.com>
References: <20231002-for-ml-tqmls10xxa-v2-test-v3-0-402819b9a29b@ew.tq-group.com>
In-Reply-To: <20231002-for-ml-tqmls10xxa-v2-test-v3-0-402819b9a29b@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
        gregor.herburger@ew.tq-group.com
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696236239; l=14585;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=XBndJPNDOvFUkSL4lUalfGNYQT/c1ILT7zD6aTtz6BU=;
 b=+Qft8sJr6tJaxWxNPnlQYelQeiVymSINwAHngF4bj8X/blM2M4RQveD/QQcMihhoalaTnTsDC
 gXxWwJKNe/lA0uBbPvyIW8Y/pHZIrhrrLOq8be8nWKTFJvCr2B7d7LM
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the TQMLS1043A and TQMLS1046A SOM and the
MBLS10xxA baseboard. TQMLS1043A and TQMLS1046A share a common layout
and can be used on the MBLS10xxA.

Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
---
 MAINTAINERS                                        |   2 +
 arch/arm64/boot/dts/freescale/Makefile             |   2 +
 .../freescale/fsl-ls1043a-tqmls1043a-mbls10xxa.dts |  49 ++++++++
 .../boot/dts/freescale/fsl-ls1043a-tqmls1043a.dtsi |  32 +++++
 .../freescale/fsl-ls1046a-tqmls1046a-mbls10xxa.dts |  56 +++++++++
 .../boot/dts/freescale/fsl-ls1046a-tqmls1046a.dtsi |  42 +++++++
 .../dts/freescale/tqmls104xa-mbls10xxa-fman.dtsi   | 104 ++++++++++++++++
 .../boot/dts/freescale/tqmls10xxa-mbls10xxa.dtsi   | 136 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/tqmls10xxa.dtsi      |  58 +++++++++
 9 files changed, 481 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 208cfcc1aee3..47f24f58743f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21950,9 +21950,11 @@ W:	https://www.tq-group.com/en/products/tq-embedded/
 F:	arch/arm/boot/dts/imx*mba*.dts*
 F:	arch/arm/boot/dts/imx*tqma*.dts*
 F:	arch/arm/boot/dts/mba*.dtsi
+F:	arch/arm64/boot/dts/freescale/fsl-*tqml*.dts*
 F:	arch/arm64/boot/dts/freescale/imx*mba*.dts*
 F:	arch/arm64/boot/dts/freescale/imx*tqma*.dts*
 F:	arch/arm64/boot/dts/freescale/mba*.dtsi
+F:	arch/arm64/boot/dts/freescale/tqml*.dts*
 F:	drivers/gpio/gpio-tqmx86.c
 F:	drivers/mfd/tqmx86.c
 F:	drivers/watchdog/tqmx86_wdt.c
diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 0ab03a621aaa..6054527a32ea 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -15,9 +15,11 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-rdb.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-tqmls1043a-mbls10xxa.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-frwy.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-rdb.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-tqmls1046a-mbls10xxa.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-ten64.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-tqmls1043a-mbls10xxa.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-tqmls1043a-mbls10xxa.dts
new file mode 100644
index 000000000000..03748a7f657b
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-tqmls1043a-mbls10xxa.dts
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Gregor Herburger, Timo Herbrecher
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+
+#include "fsl-ls1043a-tqmls1043a.dtsi"
+#include "tqmls10xxa-mbls10xxa.dtsi"
+
+/ {
+	model = "TQ-Systems GmbH LS1043A TQMLS1043A SoM on MBLS10xxA board";
+	compatible = "tq,ls1043a-tqmls1043a-mbls10xxa", "tq,ls1043a-tqmls1043a",
+		     "fsl,ls1043a";
+
+	aliases {
+		qsgmii-s1-p1 = &qsgmii1_phy1;
+		qsgmii-s1-p2 = &qsgmii1_phy2;
+		qsgmii-s1-p3 = &qsgmii1_phy3;
+		qsgmii-s1-p4 = &qsgmii1_phy4;
+		qsgmii-s2-p1 = &qsgmii2_phy1;
+		qsgmii-s2-p2 = &qsgmii2_phy2;
+		qsgmii-s2-p3 = &qsgmii2_phy3;
+		qsgmii-s2-p4 = &qsgmii2_phy4;
+		serial0 = &duart0;
+		serial1 = &duart1;
+	};
+
+	chosen {
+		stdout-path = &duart1;
+	};
+};
+
+&esdhc {
+	cd-gpios = <&gpio3 2 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio3 3 GPIO_ACTIVE_HIGH>;
+};
+
+&usb2 {
+	status = "okay";
+};
+
+#include "fsl-ls1043-post.dtsi"
+#include "tqmls104xa-mbls10xxa-fman.dtsi"
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-tqmls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a-tqmls1043a.dtsi
new file mode 100644
index 000000000000..12d5f3938e5d
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-tqmls1043a.dtsi
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Gregor Herburger, Timo Herbrecher
+ *
+ * Device Tree Include file for LS1043A based SoM of TQ
+ */
+
+#include "fsl-ls1043a.dtsi"
+#include "tqmls10xxa.dtsi"
+
+&qspi {
+	num-cs = <2>;
+	status = "okay";
+
+	qflash0: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <62500000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a-mbls10xxa.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a-mbls10xxa.dts
new file mode 100644
index 000000000000..37834ae3deac
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a-mbls10xxa.dts
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Gregor Herburger, Timo Herbrecher
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+
+#include "fsl-ls1046a-tqmls1046a.dtsi"
+#include "tqmls10xxa-mbls10xxa.dtsi"
+
+/ {
+	model = "TQ-Systems GmbH LS1046A TQMLS1046A SoM on MBLS10xxA board";
+	compatible = "tq,ls1046a-tqmls1046a-mbls10xxa", "tq,ls1046a-tqmls1046a",
+		     "fsl,ls1046a";
+
+	aliases {
+		qsgmii-s1-p1 = &qsgmii1_phy1;
+		qsgmii-s1-p2 = &qsgmii1_phy2;
+		qsgmii-s1-p3 = &qsgmii1_phy3;
+		qsgmii-s1-p4 = &qsgmii1_phy4;
+		qsgmii-s2-p1 = &qsgmii2_phy1;
+		qsgmii-s2-p2 = &qsgmii2_phy2;
+		qsgmii-s2-p3 = &qsgmii2_phy3;
+		qsgmii-s2-p4 = &qsgmii2_phy4;
+		serial0 = &duart0;
+		serial1 = &duart1;
+	};
+
+	chosen {
+		stdout-path = &duart1;
+	};
+};
+
+&dspi {
+	status = "okay";
+};
+
+&esdhc {
+	cd-gpios = <&gpio3 2 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio3 3 GPIO_ACTIVE_HIGH>;
+};
+
+&usb2 {
+	status = "okay";
+};
+
+#include "fsl-ls1046-post.dtsi"
+#include "tqmls104xa-mbls10xxa-fman.dtsi"
+
+&enet7 {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a.dtsi
new file mode 100644
index 000000000000..4a8f8bc688f5
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a.dtsi
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Gregor Herburger, Timo Herbrecher
+ *
+ * Device Tree Include file for LS1046A based SoM of TQ
+ */
+
+#include "fsl-ls1046a.dtsi"
+#include "tqmls10xxa.dtsi"
+
+&qspi {
+	num-cs = <2>;
+	status = "okay";
+
+	qflash0: flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <62500000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+	};
+
+	qflash1: flash@1 {
+		compatible = "jedec,spi-nor";
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <62500000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/tqmls104xa-mbls10xxa-fman.dtsi b/arch/arm64/boot/dts/freescale/tqmls104xa-mbls10xxa-fman.dtsi
new file mode 100644
index 000000000000..4c38dd541143
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/tqmls104xa-mbls10xxa-fman.dtsi
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2019,2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Gregor Herburger, Timo Herbrecher
+ *
+ * Device Tree Include file for MBLS10xxA from TQ (FMAN related sections)
+ */
+
+#include <dt-bindings/net/ti-dp83867.h>
+
+&enet0 {
+	status = "disabled";
+};
+
+&enet1 {
+	status = "disabled";
+};
+
+&enet2 {
+	phy-handle = <&rgmii_phy1>;
+	phy-connection-type = "rgmii";
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&enet3 {
+	phy-handle = <&rgmii_phy2>;
+	phy-connection-type = "rgmii";
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&enet4 {
+	status = "disabled";
+};
+
+&enet5 {
+	status = "disabled";
+};
+
+&enet6 {
+	status = "disabled";
+};
+
+&mdio0 {
+	status = "okay";
+
+	qsgmii2_phy1: ethernet-phy@0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x00>;
+	};
+
+	qsgmii2_phy2: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x01>;
+	};
+
+	qsgmii2_phy3: ethernet-phy@2 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x02>;
+	};
+
+	qsgmii2_phy4: ethernet-phy@3 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x03>;
+	};
+
+	rgmii_phy2: ethernet-phy@c {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x0c>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_1_50_NS>;
+		ti,tx-internal-delay = <DP83867_RGMIIDCTL_1_50_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_8_B_NIB>;
+	};
+
+	rgmii_phy1: ethernet-phy@e {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x0e>;
+		ti,rx-internal-delay = <DP83867_RGMIIDCTL_1_50_NS>;
+		ti,tx-internal-delay = <DP83867_RGMIIDCTL_1_50_NS>;
+		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_8_B_NIB>;
+	};
+
+	qsgmii1_phy1: ethernet-phy@1c {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x1c>;
+	};
+
+	qsgmii1_phy2: ethernet-phy@1d {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x1d>;
+	};
+
+	qsgmii1_phy3: ethernet-phy@1e {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x1e>;
+	};
+
+	qsgmii1_phy4: ethernet-phy@1f {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <0x1f>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/tqmls10xxa-mbls10xxa.dtsi b/arch/arm64/boot/dts/freescale/tqmls10xxa-mbls10xxa.dtsi
new file mode 100644
index 000000000000..65b4ed28a3d4
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/tqmls10xxa-mbls10xxa.dtsi
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Gregor Herburger, Timo Herbrecher
+ *
+ * Device Tree Include file for MBLS10xxA from TQ
+ */
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		poll-interval = <100>;
+		autorepeat;
+
+		button-0 {
+			label = "button0";
+			gpios = <&gpioexp3 5 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_F1>;
+		};
+
+		button-1 {
+			label = "button1";
+			gpios = <&gpioexp3 6 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_F2>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-user {
+			gpios = <&gpioexp3 13 GPIO_ACTIVE_LOW>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_HEARTBEAT;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "V_3V3_MB";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+&duart0 {
+	status = "okay";
+};
+
+&duart1 {
+	status = "okay";
+};
+
+&esdhc {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9544";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c@0 {
+			reg = <0x0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			gpioexp1: gpio@20 {
+				compatible = "nxp,pca9555";
+				reg = <0x20>;
+				vcc-supply = <&reg_3v3>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpioexp2: gpio@21 {
+				compatible = "nxp,pca9555";
+				reg = <0x21>;
+				vcc-supply = <&reg_3v3>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpioexp3: gpio@22 {
+				compatible = "nxp,pca9555";
+				reg = <0x22>;
+				vcc-supply = <&reg_3v3>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+		};
+
+		sfp1_i2c: i2c@1 {
+			reg = <0x1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		sfp2_i2c: i2c@2 {
+			reg = <0x2>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c@3 {
+			reg = <0x3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+};
+
+&sata {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	dr_mode = "otg";
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/tqmls10xxa.dtsi b/arch/arm64/boot/dts/freescale/tqmls10xxa.dtsi
new file mode 100644
index 000000000000..138f8778afde
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/tqmls10xxa.dtsi
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Gregor Herburger, Timo Herbrecher
+ *
+ * Device Tree Include file for TQMLs10xxA SoM of TQ
+ */
+
+/ {
+	reg_vcc3v3: regulator-vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+
+	temperature-sensor@18 {
+		compatible = "nxp,se97b", "jedec,jc-42.4-temp";
+		reg = <0x18>;
+	};
+
+	eeprom@50 {
+		compatible = "nxp,se97b", "atmel,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+		vcc-supply = <&reg_vcc3v3>;
+		read-only;
+	};
+
+	rtc@51 {
+		compatible = "nxp,pcf85063a";
+		reg = <0x51>;
+	};
+
+	eeprom@57 {
+		compatible = "atmel,24c64";
+		reg = <0x57>;
+		pagesize = <32>;
+		vcc-supply = <&reg_vcc3v3>;
+	};
+};
+
+&esdhc {
+	/* eSDHC or eMMC: set by bootloader */
+	non-removable;
+	disable-wp;
+	mmc-hs200-1_8v;
+	sd-uhs-sdr104;
+	sd-uhs-sdr50;
+	sd-uhs-sdr25;
+	sd-uhs-sdr12;
+};

-- 
2.34.1

