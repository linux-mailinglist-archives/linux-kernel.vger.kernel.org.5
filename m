Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C2C7D5178
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbjJXNVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbjJXNUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:20:52 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FA9133;
        Tue, 24 Oct 2023 06:20:40 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39O2Kgrw022528;
        Tue, 24 Oct 2023 06:19:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=2KyaPHQd7BOL7uJ0uTy9CvGRJygapKREQ5ztn/tDaa4=;
 b=fSbpsJk+MJ1fnKDS+h4VjMr8G4Qovv8RDhy96gvrc6qxlVoiKjOpVv2WnnevcPLScYRo
 6mIz/TPzuj4c5NNf4fKdtJgM7S1LxCpy+i+hnBjaeJoMAEkb+H6zii6Ur/vigrtiM3nz
 2n1oNWAQjFTB3KUIzhitbvaAertRGqwZnbYPjRJd30ZqMb9XwZoR6xiD41knpvrAIBv+
 beLAMUTEFbQrP26gKKFfrtLattADm8lTBX+U84QuOY+5ProMFtnE5CGrc0zksjL0TgEF
 Fs57nOyL7z2AZQVQB2+6l0yh0FWsxeQ81nskPHrvQmGBS3jyJiFk3EEIn9Hl/dlv5zW2 nw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3tx523taq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 24 Oct 2023 06:19:58 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 24 Oct
 2023 06:19:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 24 Oct 2023 06:19:57 -0700
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
        by maili.marvell.com (Postfix) with ESMTP id 55F193F7069;
        Tue, 24 Oct 2023 06:19:54 -0700 (PDT)
From:   Elad Nachman <enachman@marvell.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>,
        <gregory.clement@bootlin.com>, <sebastian.hesselbarth@gmail.com>,
        <pali@kernel.org>, <mrkiko.rs@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <enachman@marvell.com>
Subject: [PATCH] arm64: dts: cn913x: add device trees for COM Express boards
Date:   Tue, 24 Oct 2023 16:19:35 +0300
Message-ID: <20231024131935.2567969-1-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: WKF1SpKmuX1iZYZ7yCIh_MGG95_m1j3p
X-Proofpoint-ORIG-GUID: WKF1SpKmuX1iZYZ7yCIh_MGG95_m1j3p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_13,2023-10-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for CN9130 and CN9131 COM Express Type 7 CPU module boards
by Marvell.
These boards differ from the existing CN913x DB boards by the type
of ethernet connection (RGMII), the type of voltage regulators
(not i2c expander based) and the USB phy (not UTMI based).
CN9131 COM Express board is basically CN9130 COM Express board
with an additional CP115 I/O co-processor, which in this case
provides an additional USB host controller on the board.

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 arch/arm64/boot/dts/marvell/Makefile          |   2 +
 .../boot/dts/marvell/cn9130-db-comexpress.dts | 100 ++++++++++++++++
 .../boot/dts/marvell/cn9131-db-comexpress.dts | 112 ++++++++++++++++++
 3 files changed, 214 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/cn9130-db-comexpress.dts
 create mode 100644 arch/arm64/boot/dts/marvell/cn9131-db-comexpress.dts

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 79ac09b58a89..7708658d6ceb 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -26,4 +26,6 @@ dtb-$(CONFIG_ARCH_MVEBU) += cn9132-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9132-db-B.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-A.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-B.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += cn9130-db-comexpress.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += cn9131-db-comexpress.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += ac5-98dx35xx-rd.dtb
diff --git a/arch/arm64/boot/dts/marvell/cn9130-db-comexpress.dts b/arch/arm64/boot/dts/marvell/cn9130-db-comexpress.dts
new file mode 100644
index 000000000000..ed33076a34f5
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9130-db-comexpress.dts
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2023 Marvell International Ltd.
+ *
+ * Device tree for the CN9130-DB Com Express board.
+ */
+
+#include "cn9130-db.dtsi"
+
+/ {
+	model = "Marvell Armada CN9130-DB COM EXPRESS type 7 board";
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
+		marvell,reg-init = <3 16 0 0x1a4a>;
+		reg = <0>;
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
diff --git a/arch/arm64/boot/dts/marvell/cn9131-db-comexpress.dts b/arch/arm64/boot/dts/marvell/cn9131-db-comexpress.dts
new file mode 100644
index 000000000000..26d0bcacd405
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9131-db-comexpress.dts
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2023 Marvell International Ltd.
+ *
+ * Device tree for the CN9131-DB Com Express board.
+ */
+
+#include "cn9131-db.dtsi"
+
+/ {
+	model = "Marvell Armada CN9131-DB COM EXPRESS type 7 board";
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
+		marvell,reg-init = <3 16 0 0x1a4a>;
+		reg = <0>;
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

