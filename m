Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DE577973B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 20:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbjHKSpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 14:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbjHKSo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:44:57 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D1330E7;
        Fri, 11 Aug 2023 11:44:55 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37BIimaL063445;
        Fri, 11 Aug 2023 13:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691779488;
        bh=9cuS+ef67G0j2MK7hEdJO1F2Eawm/bFHqVwBl8tegvk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hx0ikM4osVl94e3XM45hxui/m+NUFqL2pG0ZyyxHS7ATnmRm4oaNbtCQkSr9TeuIw
         AJM6bpxNtbXob5AhVX5xlG1lZiyHmIWgXwe+zHPK3PVe4N+FnLc+K6Y7NcPt/JVBpm
         N4ma6q6ZLil65tHny2ctltIz50lFmqBtSkkoVZ9U=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37BIimL0013514
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Aug 2023 13:44:48 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Aug 2023 13:44:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Aug 2023 13:44:48 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37BIicWs018168;
        Fri, 11 Aug 2023 13:44:45 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <afd@ti.com>
Subject: [PATCH v2 2/3] arm64: dts: ti: Introduce AM62P5 family of SoCs
Date:   Sat, 12 Aug 2023 00:14:31 +0530
Message-ID: <20230811184432.732215-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811184432.732215-1-vigneshr@ti.com>
References: <20230811184432.732215-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan Brattlof <bb@ti.com>

The AM62Px is an extension of the existing Sitara AM62x low-cost family
of application processors built for Automotive and Linux Application
development. Scalable Arm Cortex-A53 performance and embedded features,
such as: multi high-definition display support, 3D-graphics
acceleration, 4K video acceleration, and extensive peripherals make the
AM62Px well-suited for a broad range of automation and industrial
application, including automotive digital instrumentation, automotive
displays, industrial HMI, and more.

Some highlights of AM62P SoC are:
* Quad-Cortex-A53s (running up to 1.4GHz) in a single cluster.
  Dual/Single core variants are provided in the same package to allow HW
  compatible designs.
* One Device manager Cortext-R5F for system power and resource
  management, and one Cortex-R5F for Functional Safety or
  general-purpose usage.
* One 3D GPU up to 50 GLFOPS
* H.264/H.265 Video Encode/Decode.
* Display support: 3x display support over OLDI/LVDS (1x OLDI-DL, 1x or
  2x OLDI-SL), DSI, or DPI. Up to 3840x1080@60fps resolution
* Integrated Giga-bit Ethernet switch supporting up to a total of two
  external ports (TSN capable).
* 9xUARTs, 5xSPI, 6xI2C, 2xUSB2, 3xCAN-FD, 3xMMC and SD, GPMC for
  NAND/FPGA connection, OSPI memory controller, 3xMcASP for audio,
  1xCSI-RX-4L for Camera, eCAP/eQEP, ePWM, among other peripherals.
* Dedicated Centralized Hardware Security Module with support for secure
  boot, debug security and crypto acceleration and trusted execution
  environment.
* One 32-bit DDR Subsystem that supports LPDDR4, DDR4 memory types.
* Multiple low power modes support, ex: Deep sleep, Standby, MCU-only,
  enabling battery powered system design.

For those interested, more details about this SoC can be found in the
Technical Reference Manual here:

    https://www.ti.com/lit/pdf/spruj83

Signed-off-by: Bryan Brattlof <bb@ti.com>
Acked-by: Andrew Davis <afd@ti.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi   | 136 ++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi    |  15 +++
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi |  32 +++++
 arch/arm64/boot/dts/ti/k3-am62p.dtsi        | 122 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi       | 107 +++++++++++++++
 arch/arm64/boot/dts/ti/k3-pinctrl.h         |   3 +
 6 files changed, 415 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5.dtsi

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
new file mode 100644
index 000000000000..c24ff905437f
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree file for the AM62P main domain peripherals
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+&cbass_main {
+	oc_sram: sram@70000000 {
+		compatible = "mmio-sram";
+		reg = <0x00 0x70000000 0x00 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00 0x00 0x70000000 0x10000>;
+	};
+
+	gic500: interrupt-controller@1800000 {
+		compatible = "arm,gic-v3";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x00 0x01800000 0x00 0x10000>,	/* GICD */
+		      <0x00 0x01880000 0x00 0xc0000>,	/* GICR */
+		      <0x01 0x00000000 0x00 0x2000>,    /* GICC */
+		      <0x01 0x00010000 0x00 0x1000>,    /* GICH */
+		      <0x01 0x00020000 0x00 0x2000>;    /* GICV */
+		/*
+		 * vcpumntirq:
+		 * virtual CPU interface maintenance interrupt
+		 */
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+		gic_its: msi-controller@1820000 {
+			compatible = "arm,gic-v3-its";
+			reg = <0x00 0x01820000 0x00 0x10000>;
+			socionext,synquacer-pre-its = <0x1000000 0x400000>;
+			msi-controller;
+			#msi-cells = <1>;
+		};
+	};
+
+	dmss: bus@48000000 {
+		bootph-all;
+		compatible = "simple-mfd";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dma-ranges;
+		ranges = <0x00 0x48000000 0x00 0x48000000 0x00 0x06400000>;
+
+		ti,sci-dev-id = <25>;
+
+		secure_proxy_main: mailbox@4d000000 {
+			bootph-all;
+			compatible = "ti,am654-secure-proxy";
+			#mbox-cells = <1>;
+			reg-names = "target_data", "rt", "scfg";
+			reg = <0x00 0x4d000000 0x00 0x80000>,
+			      <0x00 0x4a600000 0x00 0x80000>,
+			      <0x00 0x4a400000 0x00 0x80000>;
+			interrupt-names = "rx_012";
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	dmsc: system-controller@44043000 {
+		bootph-all;
+		compatible = "ti,k2g-sci";
+		ti,host-id = <12>;
+		mbox-names = "rx", "tx";
+		mboxes = <&secure_proxy_main 12>,
+			 <&secure_proxy_main 13>;
+		reg-names = "debug_messages";
+		reg = <0x00 0x44043000 0x00 0xfe0>;
+
+		k3_pds: power-controller {
+			bootph-all;
+			compatible = "ti,sci-pm-domain";
+			#power-domain-cells = <2>;
+		};
+
+		k3_clks: clock-controller {
+			bootph-all;
+			compatible = "ti,k2g-sci-clk";
+			#clock-cells = <2>;
+		};
+
+		k3_reset: reset-controller {
+			bootph-all;
+			compatible = "ti,sci-reset";
+			#reset-cells = <2>;
+		};
+	};
+
+	main_pmx0: pinctrl@f4000 {
+		bootph-all;
+		compatible = "pinctrl-single";
+		reg = <0x00 0xf4000 0x00 0x2ac>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	main_timer0: timer@2400000 {
+		bootph-all;
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2400000 0x00 0x400>;
+		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 36 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 36 2>;
+		assigned-clock-parents = <&k3_clks 36 3>;
+		power-domains = <&k3_pds 36 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_uart0: serial@2800000 {
+		compatible = "ti,am64-uart", "ti,am654-uart";
+		reg = <0x00 0x02800000 0x00 0x100>;
+		interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 146 0>;
+		clock-names = "fclk";
+		status = "disabled";
+	};
+
+	main_uart1: serial@2810000 {
+		compatible = "ti,am64-uart", "ti,am654-uart";
+		reg = <0x00 0x02810000 0x00 0x100>;
+		interrupts = <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 152 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 152 0>;
+		clock-names = "fclk";
+		status = "disabled";
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
new file mode 100644
index 000000000000..27ca1c9c6d13
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree file for the AM62P MCU domain peripherals
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+&cbass_mcu {
+	mcu_pmx0: pinctrl@4084000 {
+		compatible = "pinctrl-single";
+		reg = <0x00 0x04084000 0x00 0x88>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
new file mode 100644
index 000000000000..aaf4b793b58e
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree file for the AM62P wakeup domain peripherals
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+&cbass_wakeup {
+	wkup_conf: bus@43000000 {
+		bootph-all;
+		compatible = "simple-bus";
+		reg = <0x00 0x43000000 0x00 0x20000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00 0x00 0x43000000 0x20000>;
+
+		chipid: chipid@14 {
+			bootph-all;
+			compatible = "ti,am654-chipid";
+			reg = <0x14 0x4>;
+		};
+	};
+
+	wkup_uart0: serial@2b300000 {
+		compatible = "ti,am64-uart", "ti,am654-uart";
+		reg = <0x00 0x2b300000 0x00 0x100>;
+		interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 114 0>;
+		clock-names = "fclk";
+		status = "disabled";
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
new file mode 100644
index 000000000000..294ab73ec98b
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for AM62P SoC Family
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+#include "k3-pinctrl.h"
+
+/ {
+	model = "Texas Instruments K3 AM62P5 SoC";
+	compatible = "ti,am62p5";
+	interrupt-parent = <&gic500>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+
+		psci: psci {
+			compatible = "arm,psci-1.0";
+			method = "smc";
+		};
+	};
+
+	a53_timer0: timer-cl0-cpu0 {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* cntpsirq */
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* cntpnsirq */
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* cntvirq */
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* cnthpirq */
+	};
+
+	pmu: pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	cbass_main: bus@f0000 {
+		bootph-all;
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		ranges = <0x00 0x000f0000 0x00 0x000f0000 0x00 0x00030000>, /* Main MMRs */
+			 <0x00 0x00420000 0x00 0x00420000 0x00 0x00001000>, /* ESM0 */
+			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00001100>, /* GPIO */
+			 <0x00 0x00703000 0x00 0x00703000 0x00 0x00000200>, /* USB0 debug trace */
+			 <0x00 0x0070c000 0x00 0x0070c000 0x00 0x00000200>, /* USB1 debug trace */
+			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* Timesync router */
+			 <0x00 0x01000000 0x00 0x01000000 0x00 0x01b28400>, /* First peripheral window */
+			 <0x00 0x08000000 0x00 0x08000000 0x00 0x00200000>, /* Main CPSW */
+			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x01d20000>, /* Second peripheral window */
+			 <0x00 0x0fd00000 0x00 0x0fd00000 0x00 0x00020000>, /* GPU */
+			 <0x00 0x20000000 0x00 0x20000000 0x00 0x0a008000>, /* Third peripheral window */
+			 <0x00 0x30040000 0x00 0x30040000 0x00 0x00080000>, /* PRUSS-M */
+			 <0x00 0x30101000 0x00 0x30101000 0x00 0x00010100>, /* CSI window */
+			 <0x00 0x30200000 0x00 0x30200000 0x00 0x00010000>, /* DSS */
+			 <0x00 0x30210000 0x00 0x30210000 0x00 0x00010000>, /* VPU */
+			 <0x00 0x31000000 0x00 0x31000000 0x00 0x00050000>, /* USB0 DWC3 Core window */
+			 <0x00 0x31100000 0x00 0x31100000 0x00 0x00050000>, /* USB1 DWC3 Core window */
+			 <0x00 0x40900000 0x00 0x40900000 0x00 0x00030000>, /* SA3UL */
+			 <0x00 0x43600000 0x00 0x43600000 0x00 0x00010000>, /* SA3 sproxy data */
+			 <0x00 0x44043000 0x00 0x44043000 0x00 0x00000fe0>, /* TI SCI DEBUG */
+			 <0x00 0x44860000 0x00 0x44860000 0x00 0x00040000>, /* SA3 sproxy config */
+			 <0x00 0x48000000 0x00 0x48000000 0x00 0x06400000>, /* DMSS */
+			 <0x00 0x60000000 0x00 0x60000000 0x00 0x08000000>, /* FSS0 DAT1 */
+			 <0x00 0x70000000 0x00 0x70000000 0x00 0x00010000>, /* OCSRAM */
+			 <0x01 0x00000000 0x01 0x00000000 0x00 0x00310000>, /* A53 PERIPHBASE */
+			 <0x05 0x00000000 0x05 0x00000000 0x01 0x00000000>, /* FSS0 DAT3 */
+
+			 /* MCU Domain Range */
+			 <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>,
+			 <0x00 0x79000000 0x00 0x79000000 0x00 0x00008000>,
+			 <0x00 0x79020000 0x00 0x79020000 0x00 0x00008000>,
+			 <0x00 0x79100000 0x00 0x79100000 0x00 0x00040000>,
+			 <0x00 0x79140000 0x00 0x79140000 0x00 0x00040000>,
+
+			 /* Wakeup Domain Range */
+			 <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>,
+			 <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>,
+			 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>,
+			 <0x00 0x78000000 0x00 0x78000000 0x00 0x00008000>,
+			 <0x00 0x78100000 0x00 0x78100000 0x00 0x00008000>;
+
+		cbass_mcu: bus@4000000 {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x00 0x04000000 0x00 0x04000000 0x00 0x01ff1400>, /* Peripheral window */
+				 <0x00 0x79000000 0x00 0x79000000 0x00 0x00008000>, /* MCU R5 ATCM */
+				 <0x00 0x79020000 0x00 0x79020000 0x00 0x00008000>, /* MCU R5 BTCM */
+				 <0x00 0x79100000 0x00 0x79100000 0x00 0x00040000>, /* MCU IRAM0 */
+				 <0x00 0x79140000 0x00 0x79140000 0x00 0x00040000>; /* MCU IRAM1 */
+		};
+
+		cbass_wakeup: bus@b00000 {
+			bootph-all;
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x00 0x00b00000 0x00 0x00b00000 0x00 0x00002400>, /* VTM */
+				 <0x00 0x2b000000 0x00 0x2b000000 0x00 0x00300400>, /* Peripheral Window */
+				 <0x00 0x43000000 0x00 0x43000000 0x00 0x00020000>, /* WKUP CTRL MMR */
+				 <0x00 0x78000000 0x00 0x78000000 0x00 0x00008000>, /* DM R5 ATCM*/
+				 <0x00 0x78100000 0x00 0x78100000 0x00 0x00008000>; /* DM R5 BTCM*/
+		};
+	};
+};
+
+/* Now include peripherals for each bus segment */
+#include "k3-am62p-main.dtsi"
+#include "k3-am62p-mcu.dtsi"
+#include "k3-am62p-wakeup.dtsi"
diff --git a/arch/arm64/boot/dts/ti/k3-am62p5.dtsi b/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
new file mode 100644
index 000000000000..50147bb63e03
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree file for the AM62P5 SoC family (quad core)
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ * TRM: https://www.ti.com/lit/pdf/spruj83
+ */
+
+/dts-v1/;
+
+#include "k3-am62p.dtsi"
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0: cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+
+				core1 {
+					cpu = <&cpu1>;
+				};
+
+				core2 {
+					cpu = <&cpu2>;
+				};
+
+				core3 {
+					cpu = <&cpu3>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			compatible = "arm,cortex-a53";
+			reg = <0x000>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			clocks = <&k3_clks 135 0>;
+		};
+
+		cpu1: cpu@1 {
+			compatible = "arm,cortex-a53";
+			reg = <0x001>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			clocks = <&k3_clks 136 0>;
+		};
+
+		cpu2: cpu@2 {
+			compatible = "arm,cortex-a53";
+			reg = <0x002>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			clocks = <&k3_clks 137 0>;
+		};
+
+		cpu3: cpu@3 {
+			compatible = "arm,cortex-a53";
+			reg = <0x003>;
+			device_type = "cpu";
+			enable-method = "psci";
+			i-cache-size = <0x8000>;
+			i-cache-line-size = <64>;
+			i-cache-sets = <256>;
+			d-cache-size = <0x8000>;
+			d-cache-line-size = <64>;
+			d-cache-sets = <128>;
+			next-level-cache = <&l2_0>;
+			clocks = <&k3_clks 138 0>;
+		};
+	};
+
+	l2_0: l2-cache0 {
+		compatible = "cache";
+		cache-unified;
+		cache-level = <2>;
+		cache-size = <0x80000>;
+		cache-line-size = <64>;
+		cache-sets = <512>;
+	};
+};
diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
index 6004e0967ec5..2a4e0e084d69 100644
--- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
+++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
@@ -41,6 +41,9 @@
 #define AM62AX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
 #define AM62AX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
 
+#define AM62PX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
+#define AM62PX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
+
 #define AM62X_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
 #define AM62X_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
 
-- 
2.41.0

