Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9D57F973D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 02:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjK0BhD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 26 Nov 2023 20:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjK0Bgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 20:36:47 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0699A19A8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 17:36:43 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id B105724E2C0;
        Mon, 27 Nov 2023 09:36:42 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 27 Nov
 2023 09:36:43 +0800
Received: from jsia-virtual-machine.localdomain (202.188.176.82) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Mon, 27 Nov 2023 09:36:38 +0800
From:   Sia Jee Heng <jeeheng.sia@starfivetech.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <conor@kernel.org>, <kernel@esmil.dk>,
        <robh+dt@kernel.org>, <emil.renner.berthing@canonical.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <jeeheng.sia@starfivetech.com>, <leyfoon.tan@starfivetech.com>
Subject: [PATCH 7/7] riscv: dts: starfive: Add initial StarFive JH8100 device tree
Date:   Mon, 27 Nov 2023 09:36:02 +0800
Message-ID: <20231127013602.253835-8-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127013602.253835-1-jeeheng.sia@starfivetech.com>
References: <20231127013602.253835-1-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial device tree for the StarFive JH8100 RISC-V SoC

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/Makefile       |   1 +
 arch/riscv/boot/dts/starfive/jh8100-evb.dts |  42 +++
 arch/riscv/boot/dts/starfive/jh8100.dtsi    | 365 ++++++++++++++++++++
 3 files changed, 408 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh8100-evb.dts
 create mode 100644 arch/riscv/boot/dts/starfive/jh8100.dtsi

diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
index 0141504c0f5c..fbb0dc619102 100644
--- a/arch/riscv/boot/dts/starfive/Makefile
+++ b/arch/riscv/boot/dts/starfive/Makefile
@@ -10,3 +10,4 @@ dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-starfive-visionfive-v1.dtb
 
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.3b.dtb
+dtb-$(CONFIG_ARCH_STARFIVE) += jh8100-evb.dtb
diff --git a/arch/riscv/boot/dts/starfive/jh8100-evb.dts b/arch/riscv/boot/dts/starfive/jh8100-evb.dts
new file mode 100644
index 000000000000..67c4964a8773
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh8100-evb.dts
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (c) 2021-2023 StarFive Technology Co., Ltd.
+ */
+
+#include "jh8100.dtsi"
+
+/ {
+	model = "StarFive JH8100 EVB";
+	compatible = "starfive,jh8100-evb", "starfive,jh8100";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	cpus {
+		timebase-frequency = <4000000>;
+
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0x2 0x00000000>; /* 8GB */
+	};
+
+	soc {
+		clk_uart: clk_uart {
+			compatible = "fixed-clock"; /* Initial clock handler for UART */
+			#clock-cells = <0>;
+			clock-frequency = <24000000>;
+		};
+	};
+};
+
+&uart0 {
+	status = "okay";
+	clocks = <&clk_uart>, <&clk_uart>;
+};
diff --git a/arch/riscv/boot/dts/starfive/jh8100.dtsi b/arch/riscv/boot/dts/starfive/jh8100.dtsi
new file mode 100644
index 000000000000..1b338d4cb985
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh8100.dtsi
@@ -0,0 +1,365 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (c) 2021-2023 StarFive Technology Co., Ltd.
+ */
+
+/dts-v1/;
+
+/ {
+	compatible = "starfive,jh8100";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			compatible = "starfive,dubhe-80", "riscv";
+			capacity-dmips-mhz = <768>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <512>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <48>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <512>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <48>;
+			mmu-type = "riscv,sv48";
+			next-level-cache = <&l2c0>;
+			reg = <0x0>;
+			riscv,isa = "rv64imafdch";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "h", "zicntr",
+					       "zicsr", "zifencei", "zihintpause", "zihpm",
+					       "zba", "zbb", "zbs", "sscofpmf";
+			tlb-split;
+
+			cpu0_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu1: cpu@1 {
+			compatible = "starfive,dubhe-80", "riscv";
+			capacity-dmips-mhz = <768>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <512>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <48>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <512>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <48>;
+			mmu-type = "riscv,sv48";
+			next-level-cache = <&l2c1>;
+			reg = <0x1>;
+			riscv,isa = "rv64imafdch";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "h", "zicntr",
+					       "zicsr", "zifencei", "zihintpause", "zihpm",
+					       "zba", "zbb", "zbs", "sscofpmf";
+			tlb-split;
+
+			cpu1_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu2: cpu@2 {
+			compatible = "starfive,dubhe-90", "riscv";
+			capacity-dmips-mhz = <1024>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <1024>;
+			d-cache-size = <65536>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <48>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <1024>;
+			i-cache-size = <65536>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <48>;
+			mmu-type = "riscv,sv48";
+			next-level-cache = <&l2c2>;
+			reg = <0x2>;
+			riscv,isa = "rv64imafdch";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "h", "zicntr",
+					       "zicsr", "zifencei", "zihintpause", "zihpm",
+					       "zba", "zbb", "zbs", "sscofpmf";
+			tlb-split;
+
+			cpu2_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu3: cpu@3 {
+			compatible = "starfive,dubhe-90", "riscv";
+			capacity-dmips-mhz = <1024>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <1024>;
+			d-cache-size = <65536>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <48>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <1024>;
+			i-cache-size = <65536>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <48>;
+			mmu-type = "riscv,sv48";
+			next-level-cache = <&l2c2>;
+			reg = <0x3>;
+			riscv,isa = "rv64imafdch";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "h", "zicntr",
+					       "zicsr", "zifencei", "zihintpause", "zihpm",
+					       "zba", "zbb", "zbs", "sscofpmf";
+			tlb-split;
+
+			cpu3_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu4: cpu@4 {
+			compatible = "starfive,dubhe-90", "riscv";
+			capacity-dmips-mhz = <1024>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <1024>;
+			d-cache-size = <65536>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <48>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <1024>;
+			i-cache-size = <65536>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <48>;
+			mmu-type = "riscv,sv48";
+			next-level-cache = <&l2c2>;
+			reg = <0x4>;
+			riscv,isa = "rv64imafdch";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "h", "zicntr",
+					       "zicsr", "zifencei", "zihintpause", "zihpm",
+					       "zba", "zbb", "zbs", "sscofpmf";
+			tlb-split;
+
+			cpu4_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu5: cpu@5 {
+			compatible = "starfive,dubhe-90", "riscv";
+			capacity-dmips-mhz = <1024>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <1024>;
+			d-cache-size = <65536>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <48>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <1024>;
+			i-cache-size = <65536>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <48>;
+			mmu-type = "riscv,sv48";
+			next-level-cache = <&l2c2>;
+			reg = <0x5>;
+			riscv,isa = "rv64imafdch";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "h", "zicntr",
+					       "zicsr", "zifencei", "zihintpause", "zihpm",
+					       "zba", "zbb", "zbs", "sscofpmf";
+			tlb-split;
+
+			cpu5_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu1>;
+				};
+			};
+
+			cluster2 {
+				core0 {
+					cpu = <&cpu2>;
+				};
+
+				core1 {
+					cpu = <&cpu3>;
+				};
+
+				core2 {
+					cpu = <&cpu4>;
+				};
+
+				core3 {
+					cpu = <&cpu5>;
+				};
+			};
+		};
+
+		l2c0: cache-controller-0 {
+			compatible = "cache";
+			cache-block-size = <64>;
+			cache-level = <2>;
+			cache-sets = <512>;
+			cache-size = <0x40000>;
+			cache-unified;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l2c1: cache-controller-1 {
+			compatible = "cache";
+			cache-block-size = <64>;
+			cache-level = <2>;
+			cache-sets = <512>;
+			cache-size = <0x40000>;
+			cache-unified;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l2c2: cache-controller-2{
+			compatible = "cache";
+			cache-block-size = <64>;
+			cache-level = <2>;
+			cache-sets = <4096>;
+			cache-size = <0x200000>;
+			cache-unified;
+			next-level-cache = <&l3_cache>;
+		};
+
+		l3_cache: cache-controller-3 {
+			compatible = "cache";
+			cache-block-size = <64>;
+			cache-level = <3>;
+			cache-sets = <8192>;
+			cache-size = <0x400000>;
+			cache-unified;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&plic>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		clint: clint@2000000 {
+			compatible = "starfive,jh8100-clint", "sifive,clint0";
+			reg = <0x0 0x2000000 0x0 0x10000>;
+			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
+					      <&cpu1_intc 3>, <&cpu1_intc 7>,
+					      <&cpu2_intc 3>, <&cpu2_intc 7>,
+					      <&cpu3_intc 3>, <&cpu3_intc 7>,
+					      <&cpu4_intc 3>, <&cpu4_intc 7>,
+					      <&cpu5_intc 3>, <&cpu5_intc 7>;
+		};
+
+		plic: interrupt-controller@c000000 {
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			compatible = "starfive,jh8100-plic", "sifive,plic-1.0.0";
+			reg = <0x0 0x0c000000 0x0 0x4000000>;
+			riscv,ndev = <200>;
+			interrupt-controller;
+			interrupts-extended = <&cpu0_intc 11>, <&cpu1_intc 11>,
+					      <&cpu0_intc 9>, <&cpu1_intc 9>,
+					      <&cpu2_intc 11>, <&cpu3_intc 11>,
+					      <&cpu4_intc 11>, <&cpu5_intc 11>,
+					      <&cpu2_intc 9>, <&cpu3_intc 9>,
+					      <&cpu4_intc 9>, <&cpu5_intc 9>;
+		};
+
+		uart0: serial@12160000 {
+			compatible = "starfive,jh8100-uart";
+			reg = <0x0 0x12160000 0x0 0x10000>;
+			clock-names = "uart_clk", "pclk";
+			interrupts = <67>;
+			status = "disabled";
+		};
+
+		uart1: serial@12170000  {
+			compatible = "starfive,jh8100-uart";
+			reg = <0x0 0x12170000 0x0 0x10000>;
+			clock-names = "uart_clk", "pclk";
+			interrupts = <68>;
+			status = "disabled";
+		};
+
+		uart2: serial@12180000  {
+			compatible = "starfive,jh8100-uart";
+			reg = <0x0 0x12180000 0x0 0x10000>;
+			clock-names = "uart_clk", "pclk";
+			interrupts = <69>;
+			status = "disabled";
+		};
+
+		uart3: serial@12190000  {
+			compatible = "starfive,jh8100-uart";
+			reg = <0x0 0x12190000 0x0 0x10000>;
+			clock-names = "uart_clk", "pclk";
+			interrupts = <70>;
+			status = "disabled";
+		};
+
+		uart4: serial@121a0000  {
+			compatible = "starfive,jh8100-uart";
+			reg = <0x0 0x121a0000 0x0 0x10000>;
+			clock-names = "uart_clk", "pclk";
+			interrupts = <71>;
+			status = "disabled";
+		};
+
+		uart5: serial@127d0000  {
+			compatible = "starfive,jh8100-uart";
+			reg = <0x0 0x127d0000 0x0 0x10000>;
+			clock-names = "uart_clk", "pclk";
+			interrupts = <72>;
+			status = "disabled";
+		};
+
+		uart6: serial@127e0000  {
+			compatible = "starfive,jh8100-uart";
+			reg = <0x0 0x127e0000 0x0 0x10000>;
+			clock-names = "uart_clk", "pclk";
+			interrupts = <73>;
+			status = "disabled";
+		};
+
+	};
+};
-- 
2.34.1

