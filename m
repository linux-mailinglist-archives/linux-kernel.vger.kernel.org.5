Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499617857AA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbjHWMLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjHWMLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:11:17 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2C910CB;
        Wed, 23 Aug 2023 05:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1692792655; x=1724328655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PwS5x9i+1a1arR3vprvYo3KfqgawHkStsyHE/GC9FUk=;
  b=ik95yLS+fa4pUuwMpO+UPU7JiwYGBMN2jIOL9A/qWKexT5VUb7G+bh58
   Vge1X0Xm/PeBPp9dWWK/8I12XZJCnDfFIJ+McpMgPluPlQVrQvr9wrsgm
   zMItBPvdCdXMs3/g1zB5PYaogKBcS3G2SAhOIVNcCMwBytclF/1+TCYtJ
   ox35WxqxdN241ZP0wP9XIm6dKaqL8bCqadILNBnHfvBVNJYuaIZQpoFSa
   WI+9o074n8sNjNG3uVsb4ffYUEjXE+1CazVvbmrT1hugiDalU7QfibxBD
   SIm+/P4+mdngcK9KrwxD9f72CtUGs0ClPtMzak8nEZZY1kTBSmoMgr/oE
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,195,1684792800"; 
   d="scan'208";a="32586564"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Aug 2023 14:10:01 +0200
Received: from herburgerg-w2.tq-net.de (herburgerg-w2.tq-net.de [10.122.52.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 7A40E280086;
        Wed, 23 Aug 2023 14:10:01 +0200 (CEST)
From:   Gregor Herburger <gregor.herburger@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: [PATCH 3/6] arm64: dts: freescale: add initial device tree for TQMLS1043A/TQMLS1046A
Date:   Wed, 23 Aug 2023 14:09:49 +0200
Message-Id: <20230823120952.317740-4-gregor.herburger@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823120952.317740-1-gregor.herburger@ew.tq-group.com>
References: <20230823120952.317740-1-gregor.herburger@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 .../fsl-ls1043a-tqmls1043a-mbls10xxa.dts      |  49 +++++++
 .../dts/freescale/fsl-ls1043a-tqmls1043a.dtsi |  32 +++++
 .../fsl-ls1046a-tqmls1046a-mbls10xxa.dts      |  56 ++++++++
 .../dts/freescale/fsl-ls1046a-tqmls1046a.dtsi |  42 ++++++
 .../freescale/tqmls104xa-mbls10xxa-fman.dtsi  | 104 ++++++++++++++
 .../dts/freescale/tqmls10xxa-mbls10xxa.dtsi   | 136 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/tqmls10xxa.dtsi |  59 ++++++++
 8 files changed, 480 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1043a-tqmls1043a-mbls10xxa.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1043a-tqmls1043a.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a-mbls10xxa.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a-tqmls1046a.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/tqmls104xa-mbls10xxa-fman.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/tqmls10xxa-mbls10xxa.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/tqmls10xxa.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index c6872b7e9471..8bb67d1e8f4d 100644
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
index 000000000000..599101d06f74
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
+		serial0 = &duart0;
+		serial1 = &duart1;
+		qsgmii-s1-p1 = &qsgmii1_phy1;
+		qsgmii-s1-p2 = &qsgmii1_phy2;
+		qsgmii-s1-p3 = &qsgmii1_phy3;
+		qsgmii-s1-p4 = &qsgmii1_phy4;
+		qsgmii-s2-p1 = &qsgmii2_phy1;
+		qsgmii-s2-p2 = &qsgmii2_phy2;
+		qsgmii-s2-p3 = &qsgmii2_phy3;
+		qsgmii-s2-p4 = &qsgmii2_phy4;
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
index 000000000000..12e1460bd3da
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
+		serial0 = &duart0;
+		serial1 = &duart1;
+		qsgmii-s1-p1 = &qsgmii1_phy1;
+		qsgmii-s1-p2 = &qsgmii1_phy2;
+		qsgmii-s1-p3 = &qsgmii1_phy3;
+		qsgmii-s1-p4 = &qsgmii1_phy4;
+		qsgmii-s2-p1 = &qsgmii2_phy1;
+		qsgmii-s2-p2 = &qsgmii2_phy2;
+		qsgmii-s2-p3 = &qsgmii2_phy3;
+		qsgmii-s2-p4 = &qsgmii2_phy4;
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
index 000000000000..f9bd529ee32f
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
+			gpioexp1: pca9555@20 {
+				compatible = "nxp,pca9555";
+				reg = <0x20>;
+				vcc-supply = <&reg_3v3>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpioexp2: pca9555@21 {
+				compatible = "nxp,pca9555";
+				reg = <0x21>;
+				vcc-supply = <&reg_3v3>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			gpioexp3: pca9555@22 {
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
index 000000000000..fd838bc930bc
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/tqmls10xxa.dtsi
@@ -0,0 +1,59 @@
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
+
-- 
2.34.1

