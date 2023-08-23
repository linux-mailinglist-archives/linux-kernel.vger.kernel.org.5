Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAB87857AF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbjHWMLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbjHWMLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:11:32 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A06E68;
        Wed, 23 Aug 2023 05:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1692792671; x=1724328671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bzzo03dbLePAXbT9+ZbblYFWMe1Mr/M/EjOkOd2CYpM=;
  b=IfSiHZBgFPgF1YEor/0KaFo6MPsQg1E/EyaLj3Ps22U5Mq893lRPV75r
   JviPr+ccUhtKLt6FPvWntN9rOu3xDeGM0Z9gvSC8kiuLRv24RYPiG5Ez9
   g7Fuh1+W8V1asgxk92BmzsOhTvPi0krfQI0Od+c3YxP95WXTcu+5A0ncz
   9r3s8CfBBoqAFjGkRqZmM+9UErMvbxdpxA96jJcOBTA1x/T1vZ6dXoiPu
   ifVXKaK1OT3x6QKLiYKeMyJ0Yl4BmFxmU05N5vSgjQf1mSc/PLa0xTY7h
   D63BYFUThEzBX8Z6frTG5ruIEPOV4YA5h6mHEQpfMAMdi7MAgk13ptDKg
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,195,1684792800"; 
   d="scan'208";a="32586566"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Aug 2023 14:10:01 +0200
Received: from herburgerg-w2.tq-net.de (herburgerg-w2.tq-net.de [10.122.52.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 98C97280075;
        Wed, 23 Aug 2023 14:10:01 +0200 (CEST)
From:   Gregor Herburger <gregor.herburger@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: [PATCH 5/6] arm64: dts: freescale: add initial device tree for TQMLS1088A
Date:   Wed, 23 Aug 2023 14:09:51 +0200
Message-Id: <20230823120952.317740-6-gregor.herburger@ew.tq-group.com>
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

This adds support for TQMLS1088A SOM on MBLS10xxA baseboard.

Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../fsl-ls1088a-tqmls1088a-mbls10xxa.dts      |  64 ++++++++
 .../dts/freescale/fsl-ls1088a-tqmls1088a.dtsi |  43 ++++++
 .../freescale/tqmls1088a-mbls10xxa-mc.dtsi    | 146 ++++++++++++++++++
 4 files changed, 254 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/tqmls1088a-mbls10xxa-mc.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 8bb67d1e8f4d..b632b17a8391 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -23,6 +23,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-tqmls1046a-mbls10xxa.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-ten64.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-tqmls1088a-mbls10xxa.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2081a-rdb.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dts
new file mode 100644
index 000000000000..e567918f6afc
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a-mbls10xxa.dts
@@ -0,0 +1,64 @@
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
+#include "fsl-ls1088a-tqmls1088a.dtsi"
+#include "tqmls10xxa-mbls10xxa.dtsi"
+
+/ {
+	model = "TQ-Systems GmbH LS1088A TQMLS1088A SoM on MBLS10xxA board";
+	compatible = "tq,ls1088a-tqmls1088a-mbls10xxa", "tq,ls1088a-tqmls1088a",
+		     "fsl,ls1088a";
+
+	aliases {
+		dpmac1 = &dpmac1;
+		dpmac2 = &dpmac2;
+		dpmac3 = &dpmac3;
+		dpmac4 = &dpmac4;
+		dpmac5 = &dpmac5;
+		dpmac6 = &dpmac6;
+		dpmac7 = &dpmac7;
+		dpmac8 = &dpmac8;
+		dpmac9 = &dpmac9;
+		dpmac10 = &dpmac10;
+		qsgmii-s1-p1 = &qsgmii1_phy1;
+		qsgmii-s1-p2 = &qsgmii1_phy2;
+		qsgmii-s1-p3 = &qsgmii1_phy3;
+		qsgmii-s1-p4 = &qsgmii1_phy4;
+		qsgmii-s2-p1 = &qsgmii2_phy1;
+		qsgmii-s2-p2 = &qsgmii2_phy2;
+		qsgmii-s2-p3 = &qsgmii2_phy3;
+		qsgmii-s2-p4 = &qsgmii2_phy4;
+		rgmii-s1 = &rgmii_phy1;
+		rgmii-s2 = &rgmii_phy2;
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
+	cd-gpios = <&gpio3 12 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
+};
+
+&sfp1_i2c {
+	status = "okay";
+};
+
+&sfp2_i2c {
+	status = "okay";
+};
+
+#include "tqmls1088a-mbls10xxa-mc.dtsi"
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a.dtsi
new file mode 100644
index 000000000000..40da8d4807de
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-tqmls1088a.dtsi
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Gregor Herburger, Timo Herbrecher
+ *
+ * Device Tree Include file for LS1088A based SoM of TQ
+ */
+
+#include "fsl-ls1088a.dtsi"
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
+
diff --git a/arch/arm64/boot/dts/freescale/tqmls1088a-mbls10xxa-mc.dtsi b/arch/arm64/boot/dts/freescale/tqmls1088a-mbls10xxa-mc.dtsi
new file mode 100644
index 000000000000..2471bb109e8e
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/tqmls1088a-mbls10xxa-mc.dtsi
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Copyright (c) 2018-2023 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Gregor Herburger, Timo Herbrecher
+ *
+ * Device Tree Include file for MBLS10xxA from TQ (MC related sections)
+ */
+
+#include <dt-bindings/net/ti-dp83867.h>
+
+/ {
+	sfp1: sfp1 {
+		compatible = "sff,sfp";
+		i2c-bus = <&sfp1_i2c>;
+		mod-def0-gpios = <&gpioexp2 2 GPIO_ACTIVE_LOW>;
+		los-gpios = <&gpioexp2 3 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&gpioexp2 0 GPIO_ACTIVE_HIGH>;
+		tx-disable-gpios = <&gpioexp2 1 GPIO_ACTIVE_HIGH>;
+	};
+
+	sfp2: sfp2 {
+		compatible = "sff,sfp";
+		i2c-bus = <&sfp2_i2c>;
+		mod-def0-gpios = <&gpioexp2 10 GPIO_ACTIVE_LOW>;
+		los-gpios = <&gpioexp2 11 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpios = <&gpioexp2 8 GPIO_ACTIVE_HIGH>;
+		tx-disable-gpios = <&gpioexp2 9 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&dpmac1 {
+	pcs-handle = <&pcs1>;
+};
+
+&dpmac2 {
+	pcs-handle = <&pcs2>;
+};
+
+&dpmac3 {
+	pcs-handle = <&pcs3_0>;
+};
+
+&dpmac4 {
+	pcs-handle = <&pcs3_1>;
+};
+
+&dpmac5 {
+	pcs-handle = <&pcs3_2>;
+};
+
+&dpmac6 {
+	pcs-handle = <&pcs3_3>;
+};
+
+&dpmac7 {
+	pcs-handle = <&pcs7_0>;
+};
+
+&dpmac8 {
+	pcs-handle = <&pcs7_1>;
+};
+
+&dpmac9 {
+	pcs-handle = <&pcs7_2>;
+};
+
+&dpmac10 {
+	pcs-handle = <&pcs7_3>;
+};
+
+&emdio1 {
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
+
+&pcs_mdio1 {
+	status = "okay";
+};
+
+&pcs_mdio2 {
+	status = "okay";
+};
+
+&pcs_mdio3 {
+	status = "okay";
+};
+
+&pcs_mdio7 {
+	status = "okay";
+};
-- 
2.34.1

