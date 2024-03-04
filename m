Return-Path: <linux-kernel+bounces-91277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC441870C2D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA701F24FBF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29387C0BA;
	Mon,  4 Mar 2024 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="iN0Dpp8f"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37D91119B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709586403; cv=none; b=UftzNWuFfVgeYMd/q0Y34aaaptf+1O7qibbEDd7gha4c18xn9SnMYAOOATzIim7p5JE2lmzAHjl77dSlLNBitRQB0pBLYCbIBz1KxRICD/s4EBQStcrWedrNJLPQ9eh5VxcP4Emj5s8GMbd3MreYTsJ9sbw12izWcuAAdTHqU/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709586403; c=relaxed/simple;
	bh=fcw4yTyEGAZNdW2emHkFKDJWKK6Esf3ajLbYpjSFdws=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=G7paNk1WXhdnA8nSl6MjLUt0+eOD0w1zB1BtlF6EQGtUF+gzfnIbttviF0cjn/WIP4FofzyclqKmO6+C2Q4vmq+glkTtAlsZ//1Ojqv8KXNWiYeK5N+jjDm90QRPgjGfjf8qTzx628b0ydvPVDybC1W81kEDqVKl9NtR7zHcMeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=iN0Dpp8f; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709586396; bh=3+o+qOqa4ECeqhCHfZg9SR6TJ5m+x/B/e8JCKSuZTr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iN0Dpp8fj2ztE1fRS7lsN0I40B2tCRv7RD9ckhp1zkHFdVJQv66VzNmV+43NQ9v6e
	 UMTCoMk/LSHolb7HZsjnOsmos1y06COMxEvomq1efGvmkBEnglYObYvQTSMUE+3ViQ
	 MXgXJxHoV1cKYdaVaQRlRkADBD8nZfPpzk4CzhwM=
Received: from cyy-pc.lan ([240e:379:2240:e500:994d:62ab:74a6:932b])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 1953A8D2; Tue, 05 Mar 2024 05:06:21 +0800
X-QQ-mid: xmsmtpt1709586394tcc08wvnd
Message-ID: <tencent_1B7642BA1B77F81E0423B41B1DD770E36209@qq.com>
X-QQ-XMAILINFO: MzW6DGxp6pWnA2r0BbVJjtnvDiRzWvDMa8xNr4qQkt9cweZY2Zf8MdSMSyzpdc
	 N4ObxZauyWSKSstGJhwQywRiAhO4MLG63kQNTVqRpbgU6iY9hB9FYL9IwRo230gxW8Di9mQppirK
	 Au0osW1xhmkaqsAIcN50phQRe/Q+hgC+7p10xezENvJKynhGjn19HC1Hg+hObjrqeaLG7Toe4wkH
	 TqZINBL7Rldqy404Io+kz+IhDedFz9ZUEbwogZuLYLH7Nev+XSdMybafdZWM4MTmOKHLAxPJL75p
	 pue0WZeFgMh8LD+GCyBhrBjJsnaSg2qU8dMjR8hqQoeKCq80azdp3nynHelB80NEzm+Pvznd5rJJ
	 H+Jdebc/tcRwEl9JCj1ycRh0dO8OV+otb1yWe11buGs/2g8By0FbguK+0AEMeKZoCJ9kCDS0B3i3
	 8lOqaH0aVmklhtJFHQ3WvBsbmnvB7P+eu0hSqYYxXfV2PcCnWVV3Kd9wybp3u3s79t2OjeRgk0n2
	 Jgeo2LY+gSKscLGozQohTqH3rxWx7VBtzjkSnQw6WAayRH8saehhpS9oqXepuUPpQ2JK8RCZ+aLQ
	 GYN3FlFnlwOfY+6YXcr3kfkUx3Jia/vjzGo7hPL+t2TIi5Oc9iJzsA5so3nYmrVuRIBzSVI5lbPb
	 kIHz/TWHUohhV5mjW4gJEKVycxYDEFvZ1MKq5aiv/WQgE6ry1ZlE9TotTfzaVATK9tYglwnine38
	 XtMtqoLsYWfEQvtIfQyuU0bejdbRnmWORruSRIJESu071SWkdDJTCs3QfD2ouIj3ywr+5jhBoJOp
	 hNERS5x2Vot5TNnvk99VXzcX1IEVH48iy7zLWMRJJRvUtbVe2hYwKj9gxnwj21/B9F9AZOuz9vxs
	 5Lfd9z2Bf/IKM7zKyw1GA+UDEDQ/yaJRKAncpNhmwAtSDiIgFAiWdaUCo8uX9ikb49kifhLwwClz
	 o+R1YhrTgIdpTi00N1qpGO4vdFqTEQUEkiIhYnqGJHtpMzdkFIBKn9O3eZt/v45PXmVsr/NK/G/W
	 vU1lTlZTlnIZDDeWqixJIX6flA0hWPD6iLJsCb96xFE/WV03JcV9lr8bkMe4SMaCWMXmq+pg==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
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
Subject: [PATCH v3 6/7] riscv: dts: add initial canmv-k230 and k230-evb dts
Date: Tue,  5 Mar 2024 05:06:00 +0800
X-OQ-MSGID: <20240304210601.777883-6-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com>
References: <tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com>
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

Have tested with some out-of-tree drivers from [4] that need DMA and they
do not come to the dts currently.

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
[4] https://github.com/cyyself/linux/tree/k230-mainline

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 arch/riscv/boot/dts/canaan/Makefile       |   2 +
 arch/riscv/boot/dts/canaan/k230-canmv.dts |  24 ++++
 arch/riscv/boot/dts/canaan/k230-evb.dts   |  24 ++++
 arch/riscv/boot/dts/canaan/k230.dtsi      | 140 ++++++++++++++++++++++
 4 files changed, 190 insertions(+)
 create mode 100644 arch/riscv/boot/dts/canaan/k230-canmv.dts
 create mode 100644 arch/riscv/boot/dts/canaan/k230-evb.dts
 create mode 100644 arch/riscv/boot/dts/canaan/k230.dtsi

diff --git a/arch/riscv/boot/dts/canaan/Makefile b/arch/riscv/boot/dts/canaan/Makefile
index 987d1f0c41f0..7d54ea5c6f3d 100644
--- a/arch/riscv/boot/dts/canaan/Makefile
+++ b/arch/riscv/boot/dts/canaan/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_CANAAN) += canaan_kd233.dtb
 dtb-$(CONFIG_ARCH_CANAAN) += k210_generic.dtb
+dtb-$(CONFIG_ARCH_CANAAN) += k230-canmv.dtb
+dtb-$(CONFIG_ARCH_CANAAN) += k230-evb.dtb
 dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_bit.dtb
 dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_dock.dtb
 dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_go.dtb
diff --git a/arch/riscv/boot/dts/canaan/k230-canmv.dts b/arch/riscv/boot/dts/canaan/k230-canmv.dts
new file mode 100644
index 000000000000..3ab5c8de11a8
--- /dev/null
+++ b/arch/riscv/boot/dts/canaan/k230-canmv.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
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
index 000000000000..42720113c566
--- /dev/null
+++ b/arch/riscv/boot/dts/canaan/k230-evb.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
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
index 000000000000..0bcff67b78a8
--- /dev/null
+++ b/arch/riscv/boot/dts/canaan/k230.dtsi
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
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


