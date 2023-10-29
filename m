Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB967DAD8F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 18:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjJ2Rsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 13:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjJ2Rst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 13:48:49 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA041B4;
        Sun, 29 Oct 2023 10:48:45 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39TFWGmu023287;
        Sun, 29 Oct 2023 10:48:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=f3JyiWng6fSbAHQw7gWFm4sMrK5jRbikgVfdTNmBfOs=;
 b=fCYAeptVNvARpU0RBlzJKJqf9Z6qaH1Fhu0yipitL2+hRIdlxX/i9MvpEZpPBHfzoakf
 RtuTLGFWpjMS8mcPYFbnUHAw9lRdAyDn26uupFZmtreNSFpEyapi0v2G4pVSlORfVIWA
 1rubOe4QonTg1TtTPor7llYZ6itmPHASpkWYnNsHzLBnjfOYcFETpzqHtuWvGOkZo3Xs
 z+vnDck2+g83PSXtoRbbcpEr95jlnbsVFN3BhUvnhTGH/AA4zGaWcLoImOCC5aAl7aRx
 /z7wSvsWX4DEpW+qOld75gva0ZS4nFpg8diyhFTEuZ5b+S/UhetZpyW23lSPZt9Nt9Uo YQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3u0ynqbqm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 29 Oct 2023 10:48:35 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 29 Oct
 2023 10:48:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 29 Oct 2023 10:48:34 -0700
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
        by maili.marvell.com (Postfix) with ESMTP id A8EF43F70A0;
        Sun, 29 Oct 2023 10:48:30 -0700 (PDT)
From:   Elad Nachman <enachman@marvell.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <pali@kernel.org>, <mrkiko.rs@gmail.com>,
        <chris.packham@alliedtelesis.co.nz>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <enachman@marvell.com>, <cyuval@marvell.com>
Subject: [PATCH v4 3/3] arm64: dts: cn913x: add device trees for COM Express boards
Date:   Sun, 29 Oct 2023 19:48:14 +0200
Message-ID: <20231029174814.559583-4-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231029174814.559583-1-enachman@marvell.com>
References: <20231029174814.559583-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VVkDGiGjzkRIDcMOl4KsinWrNWFnd54F
X-Proofpoint-GUID: VVkDGiGjzkRIDcMOl4KsinWrNWFnd54F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-29_06,2023-10-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
 .../marvell/ac5x-rd-carrier-with-cn9131.dts   |  20 ++++
 .../boot/dts/marvell/ac5x-rd-carrier.dtsi     |  15 +++
 .../dts/marvell/cn9130-db-comexpress.dtsi     | 101 ++++++++++++++++
 .../dts/marvell/cn9131-db-comexpress.dtsi     | 113 ++++++++++++++++++
 5 files changed, 250 insertions(+)
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
index 000000000000..9ca2725184e2
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/ac5x-rd-carrier-with-cn9131.dts
@@ -0,0 +1,20 @@
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
+	compatible = "marvell,rd-ac5x-carrier-with-cn9131", "marvell,rd-ac5x-carrier",
+		     "marvell,cn9131", "marvell,cn9130",
+		     "marvell,armada-ap807-quad", "marvell,armada-ap807";
+
+};
diff --git a/arch/arm64/boot/dts/marvell/ac5x-rd-carrier.dtsi b/arch/arm64/boot/dts/marvell/ac5x-rd-carrier.dtsi
new file mode 100644
index 000000000000..6d976d268deb
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/ac5x-rd-carrier.dtsi
@@ -0,0 +1,15 @@
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
+	compatible = "marvell,rd-ac5x-carrier", "marvell,cn9131", "marvell,cn9130",
+		     "marvell,armada-ap807-quad", "marvell,armada-ap807";
+
+};
diff --git a/arch/arm64/boot/dts/marvell/cn9130-db-comexpress.dtsi b/arch/arm64/boot/dts/marvell/cn9130-db-comexpress.dtsi
new file mode 100644
index 000000000000..1180066a3cf2
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9130-db-comexpress.dtsi
@@ -0,0 +1,101 @@
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
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x2 0x00000000>;
+	};
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
index 000000000000..0d2d2a119253
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9131-db-comexpress.dtsi
@@ -0,0 +1,113 @@
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
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x2 0x00000000>;
+	};
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

