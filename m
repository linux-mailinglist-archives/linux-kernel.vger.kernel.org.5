Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED547F056F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 11:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjKSK1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 05:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjKSK1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 05:27:10 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A09C6;
        Sun, 19 Nov 2023 02:27:06 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJAOBJT008098;
        Sun, 19 Nov 2023 02:26:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=IeNzKPBbiUnh1v68d95ggLpWZeZNM/xWHvOPVmrKuH0=;
 b=bNWk4lZCtOWxT2M8KzTgV34zf/JjDUdtqMV4986P+6QyiLPDNV3zLQmJ1BGXuOmL0kBw
 vyvTk7iGzcRl02S+ks2Ly/fUge2WvU7XIf18XE6zQTern6pTav3D7k7Q8hqsWh9YePCB
 bTBOtH9e3TlEULE1i63OO9qr8yEaCMvJEJxjZm2fefAV+hkMQCrCQM9WpYcUdlHkxJje
 g+Ls/gvYMxicQSbqepLXDXUGEtq3u/Bx3MmYY3o91RrPtuI5YovXSNuibR3zBUbWv69N
 qzdmy6w4IS+LFgcJWA4S3JDKO3SbwakS6MZqahVSb/FnCGFftqww1Mihh9D5qMlD7asd HQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ueugusvbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 19 Nov 2023 02:26:57 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 19 Nov
 2023 02:26:55 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 19 Nov 2023 02:26:55 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
        by maili.marvell.com (Postfix) with ESMTP id 3F92C3F704F;
        Sun, 19 Nov 2023 02:26:52 -0800 (PST)
From:   Elad Nachman <enachman@marvell.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <pali@kernel.org>, <mrkiko.rs@gmail.com>,
        <chris.packham@alliedtelesis.co.nz>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <enachman@marvell.com>, <cyuval@marvell.com>
Subject: [PATCH v5 3/3] arm64: dts: cn913x: add device trees for COM Express boards
Date:   Sun, 19 Nov 2023 12:26:38 +0200
Message-ID: <20231119102638.1041978-4-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231119102638.1041978-1-enachman@marvell.com>
References: <20231119102638.1041978-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: kiplUeHGllG0Z1qEUQxTDEANKCQdQOP8
X-Proofpoint-ORIG-GUID: kiplUeHGllG0Z1qEUQxTDEANKCQdQOP8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_09,2023-11-17_01,2023-05-22_02
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
 .../marvell/ac5x-rd-carrier-with-cn9131.dts   |  25 ++++
 .../boot/dts/marvell/ac5x-rd-carrier.dtsi     |  14 +++
 .../dts/marvell/cn9130-db-comexpress.dtsi     |  96 ++++++++++++++++
 .../dts/marvell/cn9131-db-comexpress.dtsi     | 108 ++++++++++++++++++
 5 files changed, 244 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/ac5x-rd-carrier-with-cn9131.dts
 create mode 100644 arch/arm64/boot/dts/marvell/ac5x-rd-carrier.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/cn9130-db-comexpress.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/cn9131-db-comexpress.dtsi

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 79ac09b58a89..88c0f357a778 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -26,4 +26,5 @@ dtb-$(CONFIG_ARCH_MVEBU) += cn9132-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9132-db-B.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-A.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-B.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += ac5x-rd-carrier-with-cn9131.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += ac5-98dx35xx-rd.dtb
diff --git a/arch/arm64/boot/dts/marvell/ac5x-rd-carrier-with-cn9131.dts b/arch/arm64/boot/dts/marvell/ac5x-rd-carrier-with-cn9131.dts
new file mode 100644
index 000000000000..9ca8af11ac87
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/ac5x-rd-carrier-with-cn9131.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2023 Marvell International Ltd.
+ *
+ * Device tree for the AC5X RD Type 7 Com Express carrier board,
+ * Utilizing the CN913x COM Express CPU module board.
+ * This specific board only maintains a PCIe link with the CPU CPU module
+ * module, which does not require any special DTS definitions.
+ */
+
+#include "cn9131-db-comexpress.dtsi"
+#include "ac5x-rd-carrier.dtsi"
+
+/ {
+	model = "Marvell Armada AC5X RD COM EXPRESS type 7 carrier board with CN9131 CPU module";
+	compatible = "marvell,ac5x-car-with-cn9131", "marvell,rd-ac5x-carrier",
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
index 000000000000..fd45d5582233
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/ac5x-rd-carrier.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2023 Marvell International Ltd.
+ *
+ * Device tree for the AC5X RD Type 7 Com Express carrier board,
+ * This specific board only maintains a PCIe link with the CPU CPU module
+ * module, which does not require any special DTS definitions.
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

