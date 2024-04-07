Return-Path: <linux-kernel+bounces-134555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C006489B2F6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 18:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D7D1C21ABD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 16:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227873C08E;
	Sun,  7 Apr 2024 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="APeRX0oc"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07923A1DC;
	Sun,  7 Apr 2024 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507410; cv=none; b=NQU4FGzt7ngoXFSZMNE7my1kxW9FusB0lKiROO7jWYheVHc68BawC5kBNIXC9p2v3NYWgaNaKwL4SV9uG+x4w+0mQof9oy6OS7hICYMbNvCThTiijofyps82VdA6+2bkSoXW3F+LBn2pzl89phbbOky9qYSmsH4rr/zvWFjlxBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507410; c=relaxed/simple;
	bh=f3mU3cICNErngAPyS0rdVGpMaQ8XuQsLhnP6/Bls6CU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=MuRxWbEIsWHWzg6snYO3kWtkQ0OaViKzjghhCOmh4pkESRNpcbA9l0EawsqfpWvZUxmf74Tpm9Re5lxQ7Mmipd8h6RMAHWPkhtyPbdsqNRAN+BqvqadQOn4R+zX2opuPVyzQRws7oXUYK2NJQL+1ULEHmwgmIn0JvZzbrj2MprU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=APeRX0oc; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712507397; bh=9oqU6VEHh8jBFFwTptwV+5ypJiPWZBgEpxz6YMVsWGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=APeRX0ocVK5OKPkEeDiQW27zEm8KoxNn2JHn24BdaNfcw/sCQkt2hWraSMY+EPqoL
	 2eLMYEUp6wrmcKy3v+9rPz4Myv1GB5pEYUDTwPwuep0jqQKkdSdHHK3MoWZrirgryX
	 Xfdv1EUSf5v09xmi2AQXIY2gqpSaP5zFCRqz2AB8=
Received: from cyy-pc.lan ([240e:379:225a:6d00:f878:7a6f:5832:7f4d])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 726A94B5; Mon, 08 Apr 2024 00:28:38 +0800
X-QQ-mid: xmsmtpt1712507327tzxo7ocpm
Message-ID: <tencent_D1180541B4B31C0371DB634A42681A5BF809@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtun29cR78Yyv4qKeKgUldiApZFksafPHE59o3rRAcKCgVuJNhMT
	 Y1WvtwG0arXjKPDDJLcuEGAgmcMS3CSl2PtkZmri7JPOwMHa2zNG488WqU+mWrPQLj0o9GUokXR1
	 99c9ShYToal33+AEDEZeid3zV7h9enmR8ncJP+a33dIyraTxw+Az3+FucC4AGL9bpwkW72iTJYxV
	 lctJiEuXmUBwY/XQ5ytPenkoqFWk/KP7m3pYuPp137aZypxulRLbAcpYW+AKCOOJpsG9OCUZPrw1
	 mgqiWyplp5vBPLnqo4Z7mOhf17oslO+JyXUZvdKJoIiSFYEyYUgYprOpFGOf/X3p+hSIj6pUXBTj
	 QZZnjVM1ycDlb2cOqr4BjcZEPXhPQlxJogML1/XePjo6k2CyjXrMSkwLoeFpjeenOEAHTu5ed8Q5
	 evRoI3NeB5WHKINnDCl7FALQKYmT5eM1sUXjrAVYj+sla77kz15YPSgKxJCNCZk+nkqtC923cfIi
	 9Rx+uaLOaNtvlYhTkK4z6i/C6Qwm5h7eXGffuym88LX5EUzo4VYrq0Ay8en4xSfYvlLQ9ye9VH6P
	 N9pRRlQbzl5vdr27v9VahhJ51R9GJjIjmopjYysE/BzZBslFgaYQ3pc9UeD6IclnAxvqGqdnbfE2
	 4B3p7sQdhmojHBOuOaLSWNvpz2wUhrfQJwfgRsIW+gLhK54XUVxm4w5UkCr0wXTk+efT8aIWwW6U
	 MVEDpWnFdNexmklnLR7OCQUY7j3Dv9rLvMfjzCerZzI0xWnz7efpdXRfVNqF1ivHtgR48sWXxCDv
	 D8L3Fq3YpUDdmJzPy/iT++FikIpcsCU8+qZMKHDP65gvJWaF/eIH1bm1c3GXUb89dCr0gfv+XQ+4
	 fyOllUZBGyXFN6igjdTEPfK0kS9/37ttLVP1lYpzhvnnPug8K/SfY6vMU9rnCQ8lCR/1U2QVJ3+N
	 HJVi80FkCI6pCQ2hH8yzYJ+2Gt1PoPiMiZHUESJRhJoSZfjqYfKQkZixZ1SanKwQIlqsW9J70t0V
	 M4+3oJ0ME0YPeItKxhv29sEJBtXm7vTTT8SkeKFh0073jEaa8+s1ulWDhqphQY3KcPunJUeIYbrb
	 o4lf6S
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH RESEND v8 5/6] riscv: dts: add initial canmv-k230 and k230-evb dts
Date: Mon,  8 Apr 2024 00:28:34 +0800
X-OQ-MSGID: <20240407162835.3199788-5-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com>
References: <tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com>
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

- Support for "zicboz" is tested by hand

Have tested with my own bare mental M-Mode program [5] which tries to use
zicboz to clear a 64B aligned block and got output[6] shows it supports
zicboz.

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
[5] https://github.com/cyyself/simple-sw-workbench/commit/32657d807d64217323a80cb04ce114671e51ed60
[6] https://gist.github.com/cyyself/aa98b07b8c77bb1d53b5a4c5e67a37cf

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 arch/riscv/boot/dts/canaan/Makefile       |   2 +
 arch/riscv/boot/dts/canaan/k230-canmv.dts |  24 ++++
 arch/riscv/boot/dts/canaan/k230-evb.dts   |  24 ++++
 arch/riscv/boot/dts/canaan/k230.dtsi      | 142 ++++++++++++++++++++++
 4 files changed, 192 insertions(+)
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
index 000000000000..95c1a3d8fb11
--- /dev/null
+++ b/arch/riscv/boot/dts/canaan/k230.dtsi
@@ -0,0 +1,142 @@
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
+			riscv,isa = "rv64imafdcv_zba_zbb_zbc_zbs_zicbom_zicbop_zicboz_svpbmt";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zba", "zbb",
+					       "zbc", "zbs", "zicbom", "zicbop", "zicboz",
+					       "zicntr", "zicsr", "zifencei", "zihpm", "svpbmt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
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


