Return-Path: <linux-kernel+bounces-89754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D1486F51F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27D62848D9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E39F9CD;
	Sun,  3 Mar 2024 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="l92IMr9K"
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110B4BE5A;
	Sun,  3 Mar 2024 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709472516; cv=none; b=FN/gEMAl3LHEBkK72O5pqAEB6L5gtJCaewNn6JOBTzDDJ1orExdPUUEU1IQ1EbnDPTAYxSKW5QSt3yyhsXb/3171ls5WDpF6qvMXqQqltO4aQ3Kb9PlLrGQlF/mG3wSh21vvsYTCHsdO3q9yIHSEbMqRQlKe2b6e55b5bNIOFgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709472516; c=relaxed/simple;
	bh=ywMAQYy1Lj92T7MrvzZam3/gVyiAlWDq+9vtz/i6++A=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=nF/TO61+DBSEuNOUERWjvLkQr/X0eiaiVXJxiGjT/WUw2lU9Xo4rbCsVeJtHbZnuP0RKiyqvsxuOHqE8t3C+QCp8zNQqlxUC9HQ9zyIkwsFdQdH+86CdIYzMRNZhMYrvqAabWtWBIzquTtROIZEEK/5fCUrDMfaz3eJw3izc0NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=l92IMr9K; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709472511; bh=TBdsuTarEOgP2iXPqjFPqtEDRQrV+xui5NBTiDgNNlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l92IMr9KxsdfbFIjT69N9MlxHcGLFLyeL3JOv54nvhZwcXlu2KeG8FZUhXrX1HOey
	 D9DybndmaoQMDIH3hDxm5HwswzuYIKxjltKN2ILCqLTeZELbDA/hMaMNVdrCjSeFLa
	 j7+781nNyh7pZHfJPUod+KzuzZWndkjbZYg8VokU=
Received: from cyy-pc.lan ([240e:379:2240:e500:994d:62ab:74a6:932b])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 6C4A707D; Sun, 03 Mar 2024 21:27:04 +0800
X-QQ-mid: xmsmtpt1709472432t9ux25w8h
Message-ID: <tencent_1DB2D1914F4E30569BC4B103B724A6214405@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5AY2AcTHr/yywu+HVr484dMzV3DnaX53Oq/XVe3wKXZdO/hvaAD
	 f3g7WcLnoyBWyGrtOQ5hFvzaHj5R6m48jKK6QY11t/rIfsJ3nnElpIlBkpRVTbd6EbVdvHrK5i5l
	 mI3nmN0ffSvaiofllKa1DextsKzuTIk70A38zCuCwFiHyVKI7zKlBUD3Kr/7Y6uFUf8pvqa0gjB+
	 pv2Vp8y1Bx30oujtNImkILExrS55GbjevFFc7zsRT5siqmNqGpNOpmfGu0Ae+QhKrMCtSzyjVQNi
	 7wWRRcqgPjPZuNThX/1juoWbiEKQdM5Y+gstmktdAJV4dnNliuQvt9/HKy51lntbFDK2biBzdhXQ
	 MC+2icDwveUFbn9MgJo6EJUKTuEpv2xdf9Ltk6lu37/FTLAuoxTukgr8dD0DNpOvPNZnUwDgeYN2
	 mC7FR/wyXO+De7GLZtUg/RblIpfgXmimrEDibIn57djP/4jKoH5dr7tyg9uf7zLVnhgRrGxtSEdw
	 kXScJJmg+4zJz4/fOK873n71eDNggReLRwRhUYlNbSlZwdonVvpUujPqn0XdYLckoFcbTn0wFsAJ
	 e+/sk+SGGhk0scR7yCgRbZuKIOEVofmGlPOQ///hmB5ZgJjx6AD+3+3eW6PNLZGgVXwkV2xul6wD
	 3fS6wK2gpj5896x2NHOaNa1k9JkLbfew/5h6Tlp6IGVRsATWqruClOyW75m3fVYcj+j/qIhO4Bgu
	 CdKSDFKyxg8jvXS41nMY5/5bJ7BPbXwOlP9kD1b3fLvbiLKInjfzYf2liNa0F+qhbTBMyngxtJAI
	 FcryfF/I6iUZuxsYP6AVDM5RNEkbuGJZcgvlzJJRh9cLEXP9logyS6uzXR4rZb8/W9GcZJ9ZS/K8
	 SmqMKBblDXK5Mv50qHtFzy/imBWIG63rZgfOVLf+G39aPLeFHh4IB7GkPNuWV2LTMgRTCVLzHhsG
	 jBxsTJrTNlmVWM9weRmAa/eoSnBNNEujIxoy6bOQDLwkMbAOzgk/LJ2ci+N284WNF9keNPUNq/0o
	 PsZwZrHmK/ekfC1A6/jY7qJXDmwrpbRDPFYU58XA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH 4/5] riscv: dts: add initial canmv-k230 and k230-evb dts
Date: Sun,  3 Mar 2024 21:26:26 +0800
X-OQ-MSGID: <20240303132627.553698-4-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_E15F8FE0B6769E6338AE690C7F4844A31706@qq.com>
References: <tencent_E15F8FE0B6769E6338AE690C7F4844A31706@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial dts for CanMV-K230 and K230-EVB powered by Canaan Kendryte
K230 SoC [1].

Some key considerations:
- Only enable BigCore which is 1.6GHz RV64GCBV

Since is there cache coherence between two cores remains a mystery since
they have a dedicated L2 Cache. And the factory SDK uses it for other OS
by default.

Meanwhile, although docs from Canaan said 1.6GHz Core with Vector is
CPU1, the csr.mhartid of this core is 0.

- Support for "zba" "zbb" "zbc" "zbs" are tested by hand

The user manual of C908 from T-Head does not document it specifically.
It just said it supports B extension V1.0-rc1. [2]

- Support for "zicbom" is tested by hand

Have tested with some out-of-tree drivers that need DMA and they do not
come to the dts currently.

- Cache parameters are inferred from T-Head docs [2] and Cannan docs [1]

L1i: 32KB, VIPT 4-Way set-associative, 64B Cacheline
L1d: 32KB, VIPT 4-Way set-associative, 64B Cacheline
L2: 256KB, PIPI 16-way set-associative, 64B Cacheline

The numbers of cache sets are calculated from these parameters.

- MMU only supports Sv39

Since T-Head docs [2] says C908 should support sv48. However, it will fail
during the kernel probe. I also tested it by hand on M-Mode software,
writing sv48 to satp.mode will not trap but will leave the csr unchanged.

[1] https://developer.canaan-creative.com/k230/dev/zh/00_hardware/K230_datasheet.html#chapter-1-introduction
[2] https://occ-intl-prod.oss-ap-southeast-1.aliyuncs.com/resource//1699268369347/XuanTie-C908-UserManual.pdf

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 arch/riscv/boot/dts/canaan/Makefile       |   2 +
 arch/riscv/boot/dts/canaan/canmv-k230.dts |  23 ++++
 arch/riscv/boot/dts/canaan/k230-evb.dts   |  23 ++++
 arch/riscv/boot/dts/canaan/k230.dtsi      | 146 ++++++++++++++++++++++
 4 files changed, 194 insertions(+)
 create mode 100644 arch/riscv/boot/dts/canaan/canmv-k230.dts
 create mode 100644 arch/riscv/boot/dts/canaan/k230-evb.dts
 create mode 100644 arch/riscv/boot/dts/canaan/k230.dtsi

diff --git a/arch/riscv/boot/dts/canaan/Makefile b/arch/riscv/boot/dts/canaan/Makefile
index 987d1f0c41f0..b4a0ec668f9a 100644
--- a/arch/riscv/boot/dts/canaan/Makefile
+++ b/arch/riscv/boot/dts/canaan/Makefile
@@ -5,3 +5,5 @@ dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_bit.dtb
 dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_dock.dtb
 dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_go.dtb
 dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maixduino.dtb
+dtb-$(CONFIG_ARCH_CANAAN) += k230-evb.dtb
+dtb-$(CONFIG_ARCH_CANAAN) += canmv-k230.dtb
\ No newline at end of file
diff --git a/arch/riscv/boot/dts/canaan/canmv-k230.dts b/arch/riscv/boot/dts/canaan/canmv-k230.dts
new file mode 100644
index 000000000000..09777616d30e
--- /dev/null
+++ b/arch/riscv/boot/dts/canaan/canmv-k230.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
+ */
+#include "k230.dtsi"
+
+/ {
+	model = "Canaan CanMV-K230";
+	compatible = "canaan,canmv-k230", "canaan,kendryte-k230";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	ddr: memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x1fdff000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/canaan/k230-evb.dts b/arch/riscv/boot/dts/canaan/k230-evb.dts
new file mode 100644
index 000000000000..dfdf8b3e99eb
--- /dev/null
+++ b/arch/riscv/boot/dts/canaan/k230-evb.dts
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
+ */
+#include "k230.dtsi"
+
+/ {
+	model = "Kendryte K230 EVB";
+	compatible = "canaan,k230-usip-lp3-evb", "canaan,kendryte-k230";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	ddr: memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x1fdff000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/canaan/k230.dtsi b/arch/riscv/boot/dts/canaan/k230.dtsi
new file mode 100644
index 000000000000..4317bda38142
--- /dev/null
+++ b/arch/riscv/boot/dts/canaan/k230.dtsi
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/dts-v1/;
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	compatible = "canaan,kendryte-k230";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		timebase-frequency = <27000000>;
+
+		cpu@0 {
+			compatible = "thead,c908", "riscv";
+			device_type = "cpu";
+			reg = <0>;
+			riscv,isa = "rv64imafdcv_zba_zbb_zbc_zbs_zicbom_svpbmt";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zba", "zbb",
+					       "zbc", "zbs", "zicbom", "zicntr", "zicsr",
+					       "zifencei", "zihpm", "svpbmt";
+			riscv,cbom-block-size = <64>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <128>;
+			d-cache-size = <32768>;
+			i-cache-block-size = <64>;
+			i-cache-sets = <128>;
+			i-cache-size = <32768>;
+			next-level-cache = <&l2_cache>;
+			mmu-type = "riscv,sv39";
+
+			cpu0_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		l2_cache: l2-cache {
+			compatible = "cache";
+			cache-block-size = <64>;
+			cache-level = <2>;
+			cache-size = <262144>;
+			cache-sets = <256>;
+			cache-unified;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&plic>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dma-noncoherent;
+		ranges;
+
+		plic: interrupt-controller@f00000000 {
+			compatible = "thead,c900-plic";
+			reg = <0xf 0x00000000 0x0 0x04000000>;
+			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
+			interrupt-controller;
+			reg-names = "control";
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			riscv,ndev = <208>;
+		};
+
+		clint: timer@f04000000 {
+			compatible = "thead,c900-clint";
+			reg = <0xf 0x04000000 0x0 0x04000000>;
+			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
+		};
+
+		apb_clk: apb-clk-clock {
+			compatible = "fixed-clock";
+			clock-frequency = <50000000>;
+			clock-output-names = "apb_clk";
+			#clock-cells = <0>;
+		};
+
+		uart0: serial@91400000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x91400000 0x0 0x1000>;
+			clocks = <&apb_clk>;
+			clock-names = "baudclk";
+			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		uart1: serial@91401000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x91401000 0x0 0x1000>;
+			clocks = <&apb_clk>;
+			clock-names = "baudclk";
+			interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		uart2: serial@91402000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x91402000 0x0 0x1000>;
+			clocks = <&apb_clk>;
+			clock-names = "baudclk";
+			interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		uart3: serial@91403000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x91403000 0x0 0x1000>;
+			clocks = <&apb_clk>;
+			clock-names = "baudclk";
+			interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		uart4: serial@91404000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x91404000 0x0 0x1000>;
+			clocks = <&apb_clk>;
+			clock-names = "baudclk";
+			interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.43.0


