Return-Path: <linux-kernel+bounces-90804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FC7870538
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7551C1F25DE5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA67524BA;
	Mon,  4 Mar 2024 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kpEUF+UU"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65BE495E0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565419; cv=none; b=agzHMbvH+PlVHcCaMZElNY0iBjYNyxFyxfGwy8bmFNAsuLw8jgViCtbhgp3sF8kNh6z3LxdSMz8iWuETKQc2G9gBpT6+vt2oZ/yalk2cLmKKBH5JYpP/1EZJAW9hCGArgkVmFAQcCOV5w9baE0IZi+/E0kmsczFJt8qq3eOzgEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565419; c=relaxed/simple;
	bh=svHORtdA7UleLqvpdbr4TfoSjZ5fbg9NfdoKGhGUKxE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NyCnEsi21NzihHTLlXk4wmRkl8VTTM9OezwEDITrrxlJCXUH7H/0Ez/uedZT9UIjUZdMRBd8p5obVIoLN0su2qU8nlletoU9vB/qmTo1WlsA2CsG4CSThbvBMCzU2y71+d9kZg3N/eLRwb+l4vYxO3sIdgEyZ5lm+ZqY8kjVMFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kpEUF+UU; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709565412; bh=+LJFgx05z4klHhsYVCs5zN6Ma+EsyWIs5Ylbotmy3iE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kpEUF+UUIWwbr58uZ2fAfGU5w7os5TF6h7jumjapJGHJJz9FfYNx+K8bZiy7rpTAf
	 p0uhWVb+33pkBJBpWWi02q9LQmI680u4sWLjKwAw/SRNsuxgUYmbFA1nGYPIdsyZsp
	 QgNq3hYBvd7U0XMfFHV8XyJMMsLhiwnSqxRMCa/o=
Received: from cyy-pc.lan ([240e:379:2240:e500:994d:62ab:74a6:932b])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 42726AAD; Mon, 04 Mar 2024 23:16:39 +0800
X-QQ-mid: xmsmtpt1709565410td9p26k0r
Message-ID: <tencent_1352FBDA710F572F663E44B9B19BAF453005@qq.com>
X-QQ-XMAILINFO: Np4jLj3/5V/eBOIdT8HbeL2qSNrZLllO2XB0W0dhDFDMpc6pY2lab7d8HvOscs
	 3pCGyN7d8inSpU/CIY9vXLCf7+pn93ufzKKS+aR7NHP2iPvlwp4+nQbqf7RHUujGUApuFwiKbYDQ
	 JDuAIMBfXKh+pnAS15lCbnJELVoSnGC/sieo8idk6B5s34BhSBeWkQOazPY3RmvQeT4wmOAE/Xb3
	 1IrQRivDnue/2HHRMpAl73eljf3dJ6pwx0m8b03vj+c/1gi425yRKiUiEx1sITtm8BIggTHrbOa/
	 x6V/jh0E6mDO/IyevIdANmgLmueyOZSaNfVu7IfyYAnQ9VYsFOh4EOVd3buzaQfWI9SJwnOmaF0o
	 7/fHgE4EvoF4q4QmvuJqYL++24F75pnu6TiatdiowgkbNeK1+3mMsezaKVFHciUcKQDD7Jli68NP
	 QibtXCtRILXf3roAMvWov6Op1qVqREtjYXqpf3waIziEIT3BkxGiOmF25rzek2M9/kSuX1ZiS7js
	 b0sA03t2JY3ne1v0J8nEIwRWj33UjGIZe2djZAwxRkyLAcWRcsokAKlvZXOSf1bmopE2Rf40bVZT
	 aUKKoUBCh5wvxK81X46EMEsyjaXuEDOxNExsPbVaVEwEgPx1Lqp3T1EvpCCfGdCvOuzZOd4vI2bt
	 XUjnOkTF2LVyrR8CrlxRqcopRlwo+KdtDJ0Ze1znovWzy557vttJwf/ZdIWCEABEb7GCYPuv9IdV
	 gYerEQ8TwyUVEASC/cv3LQdT4RK23ksPO83uBGKpR2K/jagTWhuSOrXWIKLWSMB0FRtuAOVQkWUw
	 NYp1zHq5nPNf4yHmiIrtXdxVEvaRztA0p76GR5H5/KKaB0VifPNCtfFYIBJaCk8COHr01KS/uJyD
	 M1W020mStp/Ba712eAiEr4TTs740Fkb3fSLt6OscR8PANyNCZxquaH+DROir5/AXu4l840YOO1W1
	 26rj+CvoTVi1JT+lR0lBqvSuST/0TYX1uD9IRlAprBvddbZ96pjlXZB6lVYxoG5zChM6m0SGGD+l
	 vO+e8QDWkwNY1fhvm7zBcHevFv/Vlq8Uq3SYp2vQnwocnzk2eTHH2ZDES1GLpnXDUBuPIomw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v2 6/7] riscv: dts: add initial canmv-k230 and k230-evb dts
Date: Mon,  4 Mar 2024 23:16:25 +0800
X-OQ-MSGID: <20240304151626.759150-6-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_64A9B4B31C2D70D5633042461AC9F80C0509@qq.com>
References: <tencent_64A9B4B31C2D70D5633042461AC9F80C0509@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial dts for CanMV-K230 and K230-EVB powered by Canaan Kendryte
K230 SoC [1].

Some key consideration:
- Only place BigCore which is 1.6GHz RV64GCBV

The existence of cache coherence between the two cores remains unknown
since they have dedicated L2 caches. And the factory SDK uses it for
other OS by default. I don't know whether the two CPUs on K230 SoC
can be used in one system. So only place BigCore here.

Meanwhile, although docs from Canaan said 1.6GHz Core with Vector is
CPU1, the csr.mhartid of this core is 0.

- Support for "zba" "zbb" "zbc" "zbs" are tested by hand

The user manual of C908 from T-Head does not document it specifically.
It just said it supports B extension V1.0-rc1. [2]

I have tested it by using this [3] which attempts to execute "add.uw",
"andn", "clmulr", "bclr" and they doesn't traps on K230. But on JH7110,
"clmulr" and "bclr" will trap.

- Support for "zicbom" is tested by hand

Have tested with some out-of-tree drivers that need DMA and they do not
come to the dts currently.

- Cache parameters are inferred from T-Head docs [2] and Canaan docs [1]

L1i: 32KB, VIPT 4-Way set-associative, 64B Cacheline
L1d: 32KB, VIPT 4-Way set-associative, 64B Cacheline
L2: 256KB, PIPT 16-way set-associative, 64B Cacheline

The numbers of cache sets are calculated from these parameters.

- MMU only supports Sv39

Since T-Head docs [2] say C908 should support Sv48. However, it will fail
during the kernel probe when running Linux on K230. I also tested it by
hand on M-Mode software, writing Sv48 to satp.mode will not trap but will
leave the csr unchanged. While writing Sv39 it will take effect. It shows
that this CPU does not support Sv48.

- Svpbmt and T-Head MAEE both supported

T-Head C908 does support both Svpbmt and T-Head MAEE for page-based memory
attributes and is controlled by csr.mxstatus. If the kernel wants to use
svpbmt, the m-mode software should set BIT(21) of csr.mxstatus to zero
before entering the s-mode kernel. Otherwise, the kernel will not boot as 0
on T-Head MAEE represent to NonCachable Memory and it will lose dirty cache
lines modification that haven't been written back to the memory.

[1] https://developer.canaan-creative.com/k230/dev/zh/00_hardware/K230_datasheet.html#chapter-1-introduction
[2] https://occ-intl-prod.oss-ap-southeast-1.aliyuncs.com/resource//1699268369347/XuanTie-C908-UserManual.pdf
[3] https://github.com/cyyself/rvb_test

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 arch/riscv/boot/dts/canaan/Makefile       |   2 +
 arch/riscv/boot/dts/canaan/canmv-k230.dts |  24 ++++
 arch/riscv/boot/dts/canaan/k230-evb.dts   |  24 ++++
 arch/riscv/boot/dts/canaan/k230.dtsi      | 140 ++++++++++++++++++++++
 4 files changed, 190 insertions(+)
 create mode 100644 arch/riscv/boot/dts/canaan/canmv-k230.dts
 create mode 100644 arch/riscv/boot/dts/canaan/k230-evb.dts
 create mode 100644 arch/riscv/boot/dts/canaan/k230.dtsi

diff --git a/arch/riscv/boot/dts/canaan/Makefile b/arch/riscv/boot/dts/canaan/Makefile
index 987d1f0c41f0..9befd088c0e5 100644
--- a/arch/riscv/boot/dts/canaan/Makefile
+++ b/arch/riscv/boot/dts/canaan/Makefile
@@ -5,3 +5,5 @@ dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_bit.dtb
 dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_dock.dtb
 dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_go.dtb
 dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maixduino.dtb
+dtb-$(CONFIG_ARCH_CANAAN) += k230-evb.dtb
+dtb-$(CONFIG_ARCH_CANAAN) += canmv-k230.dtb
diff --git a/arch/riscv/boot/dts/canaan/canmv-k230.dts b/arch/riscv/boot/dts/canaan/canmv-k230.dts
new file mode 100644
index 000000000000..740ce80ccc07
--- /dev/null
+++ b/arch/riscv/boot/dts/canaan/canmv-k230.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
+ */
+
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
index 000000000000..c3db44934aa2
--- /dev/null
+++ b/arch/riscv/boot/dts/canaan/k230-evb.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
+ */
+
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
index 000000000000..a384e2dfa277
--- /dev/null
+++ b/arch/riscv/boot/dts/canaan/k230.dtsi
@@ -0,0 +1,140 @@
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
+	apb_clk: apb-clk-clock {
+		compatible = "fixed-clock";
+		clock-frequency = <50000000>;
+		clock-output-names = "apb_clk";
+		#clock-cells = <0>;
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
+			compatible = "canaan,k230-plic" ,"thead,c900-plic";
+			reg = <0xf 0x00000000 0x0 0x04000000>;
+			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			riscv,ndev = <208>;
+		};
+
+		clint: timer@f04000000 {
+			compatible = "canaan,k230-clint", "thead,c900-clint";
+			reg = <0xf 0x04000000 0x0 0x04000000>;
+			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
+		};
+
+		uart0: serial@91400000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x91400000 0x0 0x1000>;
+			clocks = <&apb_clk>;
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
+			interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.43.0


