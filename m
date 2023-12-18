Return-Path: <linux-kernel+bounces-3976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DD2817646
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233DF28211A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736DD5BFA5;
	Mon, 18 Dec 2023 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="C23X7TCH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6808E5A879;
	Mon, 18 Dec 2023 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIFBUkw013429;
	Mon, 18 Dec 2023 07:44:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=V8rR2X2my8KIIy23Pc5Kc5UxGoAEIEth2JwXF9wSVxw=; b=C23
	X7TCH9OZs3TiAAYQ1zCEQIi5uyaEh+2jJhjnyXPXGIQaa875uVkXknZ1vfMndF4Q
	t/Al9aAEF/qBCK264wolYQ3nLTFI0GyI8OeBJ8yOq4/OQ3MeOcIPZgHyLH0NzSRs
	IFYMB8UhcM55ckV7CJSBFAGXvKQr6q0UFs0GdALzvQQ3M/BFFfBPBaIob91gNaMA
	rU1YFkVMrfDRdCdHtR7vA/CeABbDThZVMwjEafmz904c5Cyn1m/HzwU2VYlxX3kG
	pQ3phIm3O05BjbMlwC32WInPxduWBnP8ZNr4AWE6bp0hSrMjDFfvO1kT+mKyluXS
	rV2KBXc/najsdiN2Pew==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3v2rg5843a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 07:44:53 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 18 Dec
 2023 07:44:52 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 18 Dec 2023 07:44:52 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id B27EA3F7052;
	Mon, 18 Dec 2023 07:44:48 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <pali@kernel.org>,
        <mrkiko.rs@gmail.com>, <chris.packham@alliedtelesis.co.nz>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC: <enachman@marvell.com>, <cyuval@marvell.com>
Subject: [PATCH 2/2] arm64: dts: a7k: add COM Express boards
Date: Mon, 18 Dec 2023 17:44:31 +0200
Message-ID: <20231218154431.3789032-3-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218154431.3789032-1-enachman@marvell.com>
References: <20231218154431.3789032-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JA6ktURcs9vV34LEXfhXNrb2AmQjLRq3
X-Proofpoint-GUID: JA6ktURcs9vV34LEXfhXNrb2AmQjLRq3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Add support for Armada 7020 Express Type 7 CPU module board by Marvell.
Define this COM Express CPU module as dtsi and provide a dtsi file for
the carrier board (Marvell DB-98CX85x0 COM Express type 7 carrier board).

Since memory is soldered on CPU module, memory node is on CPU module
dtsi file.

This Carrier board only utilizes the PCIe link, hence no special device
or driver support is provided by this dtsi file.
Devise a dts file for the combined com express carrier and CPU module.

The Aramda 7020 CPU COM Express board offers the following features:

1.  Armada 7020 CPU, with dual ARM A72 cores
2.  DDR4 memory, 8GB, on board soldered
3.  1Gbit Out of Band Ethernet via RGMII to PHY and RJ45 connector,
    all are present on A7K CPU module (none on the carrier)
4.  Optional 10G KR Ethernet going via the COM Express type 7 connector
5.  On-board 8 Gbit, 8-bit bus width NAND flash
6.  On-board 512 Mbit SPI flash
7.  PCIe Root Complex, 4 lanes PCIe gen3 connectivity, going via the
    COM Express type 7 connector
8.  m.2 SATA connector
9.  Micro-SD card connector
10. USB 2.0 via COM Express type 7 connector
11. Two i2c interfaces - one to the CPU module, and one to the
    carrier board via the COM Express type 7 connector
12. UART (mini USB connector by virtue of FT2232D UART to USB
    converter, connected to the Armada 7020 UART0)

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 arch/arm64/boot/dts/marvell/Makefile          |   1 +
 .../dts/marvell/armada-7020-comexpress.dtsi   | 161 ++++++++++++++++++
 arch/arm64/boot/dts/marvell/armada-70x0.dtsi  |   7 +
 .../boot/dts/marvell/armada-ap806-dual.dtsi   |   4 +-
 .../dts/marvell/db-falcon-carrier-a7k.dts     |  27 +++
 .../boot/dts/marvell/db-falcon-carrier.dtsi   |  22 +++
 6 files changed, 220 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-7020-comexpress.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/db-falcon-carrier-a7k.dts
 create mode 100644 arch/arm64/boot/dts/marvell/db-falcon-carrier.dtsi

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 79ac09b58a89..e3394a1ff009 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-v7-emmc.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-gl-mv1000.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-turris-mox.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-uDPU.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += db-falcon-carrier-a7k.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-7040-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-7040-mochabin.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-clearfog-gt-8k.dtb
diff --git a/arch/arm64/boot/dts/marvell/armada-7020-comexpress.dtsi b/arch/arm64/boot/dts/marvell/armada-7020-comexpress.dtsi
new file mode 100644
index 000000000000..dd91bfa9f880
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-7020-comexpress.dtsi
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2023 Marvell Technology Group Ltd.
+ *
+ * Device Tree file for Marvell Armada 7020 Com Express CPU module board.
+ */
+
+#include "armada-7020.dtsi"
+
+/ {
+	model = "Marvell Armada-7020 COMEXPRESS board setup";
+	compatible = "marvell,armada7020-cpu-module", "marvell,armada7020",
+			"marvell,armada-ap806-dual", "marvell,armada-ap806";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x2 0x00000000>;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	aliases {
+		ethernet0 = &cp0_eth0;
+		ethernet1 = &cp0_eth1;
+	};
+};
+
+&ap_clk {
+	status = "okay";
+};
+
+&gic {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&cp0_mdio {
+	status = "okay";
+
+	phy0: ethernet-phy@10 {
+		reg = <0x10>;
+	};
+};
+
+&cp0_ethernet {
+	status = "okay";
+};
+
+&cp0_eth0 {
+	status = "okay";
+	phy-mode = "10gbase-kr";
+	managed = "in-band-status";
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cp0_comphy4 0>;
+};
+
+&cp0_eth1 {
+	status = "okay";
+	phy = <&phy0>;
+	phy-mode = "rgmii-id";
+};
+
+&cp0_usb3_0 {
+	status = "okay";
+};
+
+&cp0_usb3_1 {
+	status = "okay";
+};
+
+&cp0_clk {
+	status = "okay";
+};
+
+&cp0_i2c0 {
+	status = "okay";
+	clock-frequency = <100000>;
+};
+
+&cp0_nand_controller {
+	status = "okay";
+
+	nand@0 {
+		reg = <0>;
+		label = "main-storage";
+		nand-rb = <0>;
+		nand-ecc-mode = "hw";
+		nand-on-flash-bbt;
+		nand-ecc-strength = <8>;
+		nand-ecc-step-size = <512>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "U-Boot";
+				reg = <0 0x400000>;
+			};
+			partition@200000 {
+				label = "Linux";
+				reg = <0x400000 0x100000>;
+			};
+			partition@1000000 {
+				label = "Filesystem";
+				reg = <0x500000 0x1e00000>;
+			};
+		};
+	};
+};
+
+&cp0_pcie0 {
+	status = "okay";
+	num-lanes = <4>;
+	num-viewport = <8>;
+
+	ranges = <0x81000000 0x0 0xfa000000 0x0 0xfa000000 0x0 0x00010000
+		  0x82000000 0x0 0x00000000 0x0 0xc0000000 0x0 0x30000000>;
+
+	/* Generic PHY, providing serdes lanes */
+	phys = <&cp0_comphy0 0
+		&cp0_comphy1 0
+		&cp0_comphy2 0
+		&cp0_comphy3 0>;
+};
+
+&cp0_sata0 {
+	/* CPM Lane 0 - U29 */
+	status = "okay";
+
+	sata-port@1 {
+		status = "okay";
+		/* Generic PHY, providing serdes lanes */
+		phys = <&cp0_comphy5 1>;
+	};
+};
+
+&cp0_sdhci0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhci_pins>;
+	status = "okay";
+	bus-width = <4>;
+	no-1-8-v;
+	broken-cd;
+};
+
diff --git a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
index 293403a1a333..8c18b410944a 100644
--- a/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-70x0.dtsi
@@ -47,6 +47,13 @@ &cp0_syscon0 {
 	cp0_pinctrl: pinctrl {
 		compatible = "marvell,armada-7k-pinctrl";
 
+
+		sdhci_pins: sdhci-pins {
+			marvell,pins = "mpp56", "mpp57", "mpp58",
+				       "mpp59", "mpp60", "mpp61", "mpp62";
+			marvell,function = "sdio";
+		};
+
 		nand_pins: nand-pins {
 			marvell,pins =
 			"mpp15", "mpp16", "mpp17", "mpp18",
diff --git a/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
index 3ed6fba1f438..c57abd4efb11 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
@@ -57,7 +57,7 @@ l2: l2-cache {
 	};
 
 	thermal-zones {
-		/delete-node/ ap-thermal-cpu2;
-		/delete-node/ ap-thermal-cpu3;
+		/delete-node/ ap-cpu2-thermal;
+		/delete-node/ ap-cpu3-thermal;
 	};
 };
diff --git a/arch/arm64/boot/dts/marvell/db-falcon-carrier-a7k.dts b/arch/arm64/boot/dts/marvell/db-falcon-carrier-a7k.dts
new file mode 100644
index 000000000000..5d1ae7b35b62
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/db-falcon-carrier-a7k.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2023 Marvell International Ltd.
+ *
+ * Device tree for the Falcon DB Type 7 Com Express carrier board,
+ * Utilizing the Armada 7020 COM Express CPU module board.
+ * This specific carrier board (DB-98CX8540/80)
+ * only maintains a PCIe link with the CPU module,
+ * which does not require any special DTS definitions.
+ *
+ * There is no Linux CPU booting in this mode on the carrier, only on the
+ * Armada 7020 COM Express CPU module.
+ * What runs the Linux is the Armada 7020 on the COM Express CPU module,
+ * And it accesses the switch end-point on the Falcon DB portion of the carrier
+ * via PCIe.
+ */
+
+#include "armada-7020-comexpress.dtsi"
+#include "db-falcon-carrier.dtsi"
+
+/ {
+	model = "Marvell Falcon DB COM EXPRESS type 7 carrier board with Armada 7020 CPU module";
+	compatible = "marvell,armada7020-falcon-carrier", "marvell,db-falcon-carrier",
+			"marvell,armada7020-cpu-module", "marvell,armada7020",
+			"marvell,armada-ap806-dual", "marvell,armada-ap806";
+
+};
diff --git a/arch/arm64/boot/dts/marvell/db-falcon-carrier.dtsi b/arch/arm64/boot/dts/marvell/db-falcon-carrier.dtsi
new file mode 100644
index 000000000000..c85ad1547ec5
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/db-falcon-carrier.dtsi
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2023 Marvell International Ltd.
+ *
+ * Device tree for the Falcon DB Type 7 Com Express carrier board,
+ * This (DB-98CX8540/80) specific carrier board only maintains
+ * a PCIe link with the COM Express CPU module, which does not
+ * require any special DTS definitions.
+ *
+ * The board contains the 98CX8540/80 Switch, which connects by
+ * PCIe to the COM Express CPU module.
+ * This CPU module can be any standard COM Express CPU module with
+ * PCIe support.
+ *
+ * There is no Linux CPU booting in this mode on the carrier,
+ * only on the COM Express CPU module.
+ */
+
+/ {
+	model = "Marvell Armada Falcon DB COM EXPRESS type 7 carrier board";
+	compatible = "marvell,db-falcon-carrier";
+};
-- 
2.25.1


