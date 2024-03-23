Return-Path: <linux-kernel+bounces-112327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74842887870
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0240B1F22610
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C92040BE1;
	Sat, 23 Mar 2024 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="P1HC++jI"
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3613EA95;
	Sat, 23 Mar 2024 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711195996; cv=none; b=j6pPDgy+oHgLErue8igdyqhq2kaCeMEpMoBjmMzJj/cnbiRuNOkEjlR15t4epHwmsiSp0FU0oV5L5R22BMqgak1huE6l2u9JNeSusWebllW/F6Iqv2x/6YJ9yzQ559kh01mlIA3LmPDqxQuYgqD/WTnSFK8Ks8BWrAmzIyyNLgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711195996; c=relaxed/simple;
	bh=jMvml7cSSh1oBJOYzokoFExEMbrHcEaaUWSMN+hvnP0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=EsZO1XCsKUXlUEBTSOi7K1Ypzu5VvBBifWADFVB//NPx+uJZuL8KZ9xmcEt4k+N9HqEy7So2umdZXzx/S81SJ4/EG0ZyMMNLcqyk/92D/e23n4uBw2VbGCjXbsGyAwqrt2nfy+n9ZG14AvHPnRS7p32UJNJMTtNUjVWSfjqRdJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=P1HC++jI; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711195984; bh=1WxNJHWHxezSU1ExyMx2JrY3ERVm20llQGz6KhWotb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P1HC++jIxCAIAwbSbb7mN5mniDE2ne1gCsHdJ53p9VNM+ooTPJMBM4d2O8n0aVAIe
	 t+00jB3DF5ZHGofDTmPSsZ7FqiUlP4Xj0juAmUFaPab6hZKidOMf9l9vf30SA6Bg0J
	 r/BdRdP8LO47lRTvfRzHeifTHiuU1lzFj4b5i9o0=
Received: from cyy-pc.lan ([240e:379:225d:8e00:b91:b2e7:7c69:8554])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 32594C7F; Sat, 23 Mar 2024 20:12:37 +0800
X-QQ-mid: xmsmtpt1711195981toie5rdd8
Message-ID: <tencent_DF5D7CD182AFDA188E0FB80E314A21038D08@qq.com>
X-QQ-XMAILINFO: MAcVqULX7QQ1nEWPxCClLu0fXQC41zMmp969VU9VtA8a9di3wrTyrOvEvPLezd
	 GZZPzU2VvFS5MW5ctKLUCz3db1X+oQVAS8578YNZ1wQLoml3fTAqGCGhaT1uOvvtSs1UUNpk53Gp
	 kKaS8J+NWp/szXLWHf+lrWCk2pnJPSXvlhTjJC+ddTE38DB7TAr61AK/D0pgPIAvgozcPLRKd5B5
	 YZLlaTQNN6+Mey9e4I0lsG7u8r03drNM3bkGEQvf8Che40PEkNbXNdI1hSm3DgRdqbpUpxgyGwlZ
	 FyHVHqBLHYrtT7+1wof7jccL2m3+ES3CL8j+Upg+3aks0adVwYxm0CQdlVymlLM6z13l2RoZ8BAV
	 KDoOhrEtNvI8hb7nm9vpg1ANJb+mEFCmK/yw1E4lMr+rGbFHqlNlbsl/t0Dh+x2d7rAE3FMnpnAL
	 bL8d4+7FYD2QnihkYUyhOV8Bn4143418NxuRHqb6MJQzjyh87LD1eg31upcuDHUUxaK+UXMqwrq+
	 qLXQ2KN7uUxAJEU9ajtY0Z4nyMd1Fio6ZV48InvfDNQBmaqxmVGOLZ3Q4Ew1M383P/CrHH6OhyRe
	 WYwB9LMr9GXZijg2+tdE8PD8qW6ugT/LEUOsEsWdiNWHKhzKjgeIDg1jo9wJg2LF8DuTZ+viuue4
	 yhe7Pn5onlvh8dxx9jlphXgS7UCkfUblrrdvRI9ohk1Kh8xmJkbhZJa15KCmnuu7s2iLxDh2TU1C
	 ENFO6N4j5knEQw3NstpjW9lOqsfAmABzwBZtBx28j7gYv2uk7pBeKNiZKgAIhm73zIF9eXcyVZUG
	 8ENeD0oF3lts8jI2AlQKyOS3vHTVx5oIc12lw5pDgLCZQbKZ3EaH9E4Gp9jSWYYwPM9EQtRPs3vA
	 zJQULKLgyftcPTqqzWb+/KY0eel2iO2OKgzG9U2A6P8MqQKzZc7R6qDfFqXDcbPSggZf4wZJxm1g
	 lEPVpxpyTT7sIZga0XM1a7LFIkFIdXb+c0OGt6L9NwdI7Fz61UaS1W2pfZdjbfcjym3OV8GNF6EV
	 GByEXh3mirRJwV/aN7q2IZXJZfGh8=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-gpio@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v6 10/11] riscv: dts: add initial canmv-k230 and k230-evb dts
Date: Sat, 23 Mar 2024 20:12:22 +0800
X-OQ-MSGID: <20240323121223.1729328-10-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_F76EB8D731C521C18D5D7C4F8229DAA58E08@qq.com>
References: <tencent_F76EB8D731C521C18D5D7C4F8229DAA58E08@qq.com>
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
CPU1, the CSR.MHARTID of this core is 0.

- Support for "zba" "zbb" "zbc" "zbs" are tested by hand

The user manual of C908 from T-Head does not document it specifically.
It just said it supports B extension V1.0. [2]

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

The T-Head docs [2] say the C908 core can be configured to support Sv48 and
Sv39 or only Sv39. On K230, I tried to write "riscv,sv48" on mmu-type in
dts and boot the mainline kernel. However, it failed during the kernel
probe and fell back to Sv39. I also tested it on M-Mode software, writing
Sv48 to satp.mode will not trap but will leave the CSR unchanged. While
writing Sv39, it will take effect. It shows that this CPU does not support
Sv48.

- Svpbmt and T-Head MAEE both supported

T-Head C908 does support both Svpbmt and T-Head MAEE for page-based memory
attributes and is controlled by BIT(21) on CSR.MXSTATUS. The Svpbmt is used
here for mainline kernel support for K230. If the kernel wants to use
Svpbmt, the M-Mode software should unset BIT(21) of CSR.MXSTATUS before
entering the S-Mode kernel. Otherwise, the kernel will not boot, as 0 on
T-Head MAEE is NonCachable Memory. Once the kernel switches from bare metal
to Sv39, It will lose dirty cache line modifications that haven't been
written back to the memory.

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
index 000000000000..9565915cead6
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
+		reg = <0x0 0x0 0x0 0x20000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/canaan/k230-evb.dts b/arch/riscv/boot/dts/canaan/k230-evb.dts
new file mode 100644
index 000000000000..f898b8e62368
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
+		reg = <0x0 0x0 0x0 0x20000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/canaan/k230.dtsi b/arch/riscv/boot/dts/canaan/k230.dtsi
new file mode 100644
index 000000000000..7da49498945e
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
+			reg = <0xf 0x04000000 0x0 0x00010000>;
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


