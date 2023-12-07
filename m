Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB7A808AAC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443290AbjLGOdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbjLGOdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:33:15 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2DDB9;
        Thu,  7 Dec 2023 06:33:19 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B76M5Dv017039;
        Thu, 7 Dec 2023 06:33:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=a7nYuK/yV0tdN8rBsNllqrwwqV8uA9tLmy4ZoMvonqM=;
 b=TGiVkfBpk6uGbvhmPm11KUF4FsjWdCIrLph0hzNKKt6WvtfX7CYsvFHu01titZz41BGf
 jhvNPo0T90kdRS/Noh08Dpin9ckuIw05MEssXxptVMq9pqIPnGEN5/kv8qkAx8M4exG7
 /RVclZvlU9N/Sulq9c6hO+QwoAMzUhpCgZ0OGKR+MGTmkMUInHgFoFTyo7ST6yogbavn
 WM9ClGDkiGRmL7K1kmrNXpzEm/2kdzjmJkQ2sERKOgWCj0npHYw9AVvUo3YBzmyI8QWd
 xx3uDoiH6DM1kX9aGdvXUaFwk90BMRXcsYBlzHWUeeQW7aJeXdcqPoA9JkPgNCY/8N9U tw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3uu8qe9jh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 06:33:10 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 7 Dec
 2023 06:33:08 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 7 Dec 2023 06:33:08 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
        by maili.marvell.com (Postfix) with ESMTP id 47A623F706A;
        Thu,  7 Dec 2023 06:33:05 -0800 (PST)
From:   Elad Nachman <enachman@marvell.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <pali@kernel.org>, <mrkiko.rs@gmail.com>,
        <chris.packham@alliedtelesis.co.nz>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <enachman@marvell.com>, <cyuval@marvell.com>
Subject: [PATCH v7 3/3] arm64: dts: cn913x: add device trees for COM Express boards
Date:   Thu, 7 Dec 2023 16:32:48 +0200
Message-ID: <20231207143248.2439926-4-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207143248.2439926-1-enachman@marvell.com>
References: <20231207143248.2439926-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: RWw2evvYYfXZG9CM_StU3p05iI0gMmQp
X-Proofpoint-ORIG-GUID: RWw2evvYYfXZG9CM_StU3p05iI0gMmQp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_12,2023-12-07_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elad Nachman <enachman@marvell.com>

Add support for CN9130 and CN9131 COM Express Type 7 CPU
module boards by Marvell.
Define these COM Express CPU modules as dtsi and
provide a dtsi file for a carrier board (Marvell AC5X RD
COM Express type 7 carrier board).
This Carrier board only utilizes the PCIe link, hence no
special device / driver support is provided by this dtsi file.
Finally, provide a dts file for the com express carrier and
CPU module combination.

These COM Express boards differ from the existing CN913x DB
boards by the type of ethernet connection (RGMII),
the type of voltage regulators (not i2c expander based)
and the USB phy (not UTMI based).
Note - PHY + RGMII connector is OOB on CPU module.
CN9131 COM Express board is basically CN9130 COM Express board
with an additional CP115 I/O co-processor, which in this case
provides an additional USB host controller on the board.

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 arch/arm64/boot/dts/marvell/Makefile          |   1 +
 .../dts/marvell/ac5x-rd-carrier-cn9131.dts    |  44 +++++++
 .../boot/dts/marvell/ac5x-rd-carrier.dtsi     |  34 ++++++
 .../dts/marvell/cn9130-db-comexpress.dtsi     |  96 ++++++++++++++++
 .../dts/marvell/cn9131-db-comexpress.dtsi     | 108 ++++++++++++++++++
 5 files changed, 283 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dts
 create mode 100644 arch/arm64/boot/dts/marvell/ac5x-rd-carrier.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/cn9130-db-comexpress.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/cn9131-db-comexpress.dtsi

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 79ac09b58a89..99b8cb3c49e1 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -26,4 +26,5 @@ dtb-$(CONFIG_ARCH_MVEBU) += cn9132-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9132-db-B.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-A.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-B.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += ac5x-rd-carrier-cn9131.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += ac5-98dx35xx-rd.dtb
diff --git a/arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dts b/arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dts
new file mode 100644
index 000000000000..2a0b07000089
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/ac5x-rd-carrier-cn9131.dts
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2023 Marvell International Ltd.
+ *
+ * Device tree for the AC5X RD Type 7 Com Express carrier board,
+ * Utilizing the CN913x COM Express CPU module board.
+ * This specific carrier board in this mode of operation (external)
+ * only maintains a PCIe link with the CPU module,
+ * which does not require any special DTS definitions.
+ *
+ * AC5X RD works here in external mode (switch selectable at the back of the
+ * board), and connect via an external cable a kit
+ * which would allow it to use an external CN9131 CPU COM Express module,
+ * mounted on top of an interposer kit.
+ *
+ * So in this case, once the switch is set to external mode as explained above,
+ * the AC5X RD becomes part of the carrier solution.
+ *
+ * When the board boots in the external CPU mode, the internal CPU is disabled,
+ * and only the switch portion of the SOC acts as a PCIe end-point, Hence there
+ * is no need to describe this internal (disabled CPU) in the device tree.
+ *
+ * There is no CPU booting in this mode on the carrier, only on the
+ * CN9131 COM Express CPU module.
+ * What runs the Linux is the CN9131 on the COM Express CPU module,
+ * And it accesses the switch end-point on the AC5X RD portion of the carrier
+ * via PCIe.
+ */
+
+#include "cn9131-db-comexpress.dtsi"
+#include "ac5x-rd-carrier.dtsi"
+
+/ {
+	model = "Marvell Armada AC5X RD COM EXPRESS type 7 carrier board with CN9131 CPU module";
+	compatible = "marvell,cn9131-ac5x-carrier", "marvell,rd-ac5x-carrier",
+			"marvell,cn9131-cpu-module", "marvell,cn9131",
+			"marvell,armada-ap807-quad", "marvell,armada-ap807";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x2 0x00000000>;
+	};
+
+};
diff --git a/arch/arm64/boot/dts/marvell/ac5x-rd-carrier.dtsi b/arch/arm64/boot/dts/marvell/ac5x-rd-carrier.dtsi
new file mode 100644
index 000000000000..f98629abb58b
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/ac5x-rd-carrier.dtsi
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2023 Marvell International Ltd.
+ *
+ * Device tree for the AC5X RD Type 7 Com Express carrier board,
+ * This specific board in external mode (see below) only maintains
+ * a PCIe link with the COM Express CPU module, which does not
+ * require any special DTS definitions.
+ *
+ * AC5X RD can either work as you would expect, as a complete standalone
+ * box using the internal CPU, or you can move the switch on the back of
+ * the box to "external" mode, and connect via an external cable a kit
+ * which would allow it to use an external CPU COM Express module,
+ * mounted on top of an interposer kit.
+ *
+ * So in this case, once the switch is set to external mode as explained above,
+ * the AC5X RD becomes part of the carrier solution.
+ * This is a development/reference solution, not a full commercial solution,
+ * hence it was designed with the flexibility to be configured in different
+ * modes of operation.
+ *
+ * When the board boots in the external CPU mode, the internal CPU is disabled,
+ * and only the switch portion of the SOC acts as a PCIe end-point, Hence there
+ * is no need to describe this internal (disabled CPU) in the device tree.
+ *
+ * There is no CPU booting in this mode on the carrier,
+ * only on the COM Express CPU module.
+ */
+
+/ {
+	model = "Marvell Armada AC5X RD COM EXPRESS type 7 carrier board";
+	compatible = "marvell,rd-ac5x-carrier";
+
+};
diff --git a/arch/arm64/boot/dts/marvell/cn9130-db-comexpress.dtsi b/arch/arm64/boot/dts/marvell/cn9130-db-comexpress.dtsi
new file mode 100644
index 000000000000..028496ebc473
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9130-db-comexpress.dtsi
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2023 Marvell International Ltd.
+ *
+ * Device tree for the CN9130-DB Com Express CPU module board.
+ */
+
+#include "cn9130-db.dtsi"
+
+/ {
+	model = "Marvell Armada CN9130-DB COM EXPRESS type 7 CPU module board";
+	compatible = "marvell,cn9130-cpu-module", "marvell,cn9130",
+		     "marvell,armada-ap807-quad", "marvell,armada-ap807";
+
+};
+
+&ap0_reg_sd_vccq {
+	regulator-max-microvolt = <1800000>;
+	states = <1800000 0x1 1800000 0x0>;
+	/delete-property/ gpios;
+};
+
+&cp0_reg_usb3_vbus0 {
+	/delete-property/ gpio;
+};
+
+&cp0_reg_usb3_vbus1 {
+	/delete-property/ gpio;
+};
+
+&cp0_reg_sd_vcc {
+	status = "disabled";
+};
+
+&cp0_reg_sd_vccq {
+	status = "disabled";
+};
+
+&cp0_sdhci0 {
+	status = "disabled";
+};
+
+&cp0_eth0 {
+	status = "disabled";
+};
+
+&cp0_eth1 {
+	status = "okay";
+	phy = <&phy0>;
+	phy-mode = "rgmii-id";
+};
+
+&cp0_eth2 {
+	status = "disabled";
+};
+
+&cp0_mdio {
+	status = "okay";
+	pinctrl-0 = <&cp0_ge_mdio_pins>;
+	phy0: ethernet-phy@0 {
+		status = "okay";
+	};
+};
+
+&cp0_syscon0 {
+	cp0_pinctrl: pinctrl {
+		compatible = "marvell,cp115-standalone-pinctrl";
+
+		cp0_ge_mdio_pins: ge-mdio-pins {
+			marvell,pins = "mpp40", "mpp41";
+			marvell,function = "ge";
+		};
+	};
+};
+
+&cp0_sdhci0 {
+	status = "disabled";
+};
+
+&cp0_spi1 {
+	status = "okay";
+};
+
+&cp0_usb3_0 {
+	status = "okay";
+	usb-phy = <&cp0_usb3_0_phy0>;
+	phy-names = "usb";
+	/delete-property/ phys;
+};
+
+&cp0_usb3_1 {
+	status = "okay";
+	usb-phy = <&cp0_usb3_0_phy1>;
+	phy-names = "usb";
+	/delete-property/ phys;
+};
diff --git a/arch/arm64/boot/dts/marvell/cn9131-db-comexpress.dtsi b/arch/arm64/boot/dts/marvell/cn9131-db-comexpress.dtsi
new file mode 100644
index 000000000000..6f3914bcfd01
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9131-db-comexpress.dtsi
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2023 Marvell International Ltd.
+ *
+ * Device tree for the CN9131-DB Com Express CPU module board.
+ */
+
+#include "cn9131-db.dtsi"
+
+/ {
+	model = "Marvell Armada CN9131-DB COM EXPRESS type 7 CPU module board";
+	compatible = "marvell,cn9131-cpu-module", "marvell,cn9131", "marvell,cn9130",
+		     "marvell,armada-ap807-quad", "marvell,armada-ap807";
+
+};
+
+&ap0_reg_sd_vccq {
+	regulator-max-microvolt = <1800000>;
+	states = <1800000 0x1 1800000 0x0>;
+	/delete-property/ gpios;
+};
+
+&cp0_reg_usb3_vbus0 {
+	/delete-property/ gpio;
+};
+
+&cp0_reg_usb3_vbus1 {
+	/delete-property/ gpio;
+};
+
+&cp1_reg_usb3_vbus0 {
+	/delete-property/ gpio;
+};
+
+&cp0_reg_sd_vcc {
+	status = "disabled";
+};
+
+&cp0_reg_sd_vccq {
+	status = "disabled";
+};
+
+&cp0_sdhci0 {
+	status = "disabled";
+};
+
+&cp0_eth0 {
+	status = "disabled";
+};
+
+&cp0_eth1 {
+	status = "okay";
+	phy = <&phy0>;
+	phy-mode = "rgmii-id";
+};
+
+&cp0_eth2 {
+	status = "disabled";
+};
+
+&cp0_mdio {
+	status = "okay";
+	pinctrl-0 = <&cp0_ge_mdio_pins>;
+	phy0: ethernet-phy@0 {
+		status = "okay";
+	};
+};
+
+&cp0_syscon0 {
+	cp0_pinctrl: pinctrl {
+		compatible = "marvell,cp115-standalone-pinctrl";
+
+		cp0_ge_mdio_pins: ge-mdio-pins {
+			marvell,pins = "mpp40", "mpp41";
+			marvell,function = "ge";
+		};
+	};
+};
+
+&cp0_sdhci0 {
+	status = "disabled";
+};
+
+&cp0_spi1 {
+	status = "okay";
+};
+
+&cp0_usb3_0 {
+	status = "okay";
+	usb-phy = <&cp0_usb3_0_phy0>;
+	phy-names = "usb";
+	/delete-property/ phys;
+};
+
+&cp0_usb3_1 {
+	status = "okay";
+	usb-phy = <&cp0_usb3_0_phy1>;
+	phy-names = "usb";
+	/delete-property/ phys;
+};
+
+&cp1_usb3_1 {
+	status = "okay";
+	usb-phy = <&cp1_usb3_0_phy0>;
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cp1_comphy3 1>;
+	phy-names = "usb";
+};
-- 
2.25.1

