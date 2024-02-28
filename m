Return-Path: <linux-kernel+bounces-84715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D1986AAA1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C718A28389D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FBA2D634;
	Wed, 28 Feb 2024 09:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="AU9xdpZF"
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A142D05B;
	Wed, 28 Feb 2024 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110814; cv=none; b=VI9toq4Dq1az3uLlUAi38emx7Y4UMsEwJecmjexRWSO4wGKL8Z1eTBsXZBKMdBxATXOFe+V1LBhUdj2YFTEBiqORxBlYhmn5ypeSKSrfhKixoCAZ+3stANGFP9VPhxZg9ijaLD+uM6Su58v09UrdlHAW8ZzixOLq/E8qWy1dyko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110814; c=relaxed/simple;
	bh=NC4eJqy+tWfGOlFYPyPnq1rTK8KHis1P8cHnzIvCX2g=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=I1BuVHZC0FtIUllRaY70FiqmEH20vLznm5QTpSsOOHLkA2ykkiRPi071V4VwT7hoj9O/4nC5zAzJXdkb/4u1zvZ+I4Bs1LMSwQ7TvusT32ZKpP1uOCvBSUTOXVATTHUYrJkOg8a345Jt5vfym2Adbjw1czE2Kk2JzgNdN2PK+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=AU9xdpZF; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709110500; bh=OJERieRX8TNnv9pPvsXYVZQyy3A2qdrTGojUlwVAUuY=;
	h=From:To:Cc:Subject:Date;
	b=AU9xdpZFuk/EWLDKSuBQTXt6Y3LUwI1ZT2JhB/ou9vDuLBBx+FP40mePzsbsVvKSo
	 Iw7hf/T8OR8FYac8bnQwSj9fOfOJBPsyBXxqtZ1NGqXdRG1SUqRDQCO8B57tSa9leo
	 knSIyjYtuZEoA9yHgl9zJ9uRyxyu/3N30fnGEynA=
Received: from cyy-pc.lan ([240e:379:2240:e500:994d:62ab:74a6:932b])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id D8722820; Wed, 28 Feb 2024 16:54:07 +0800
X-QQ-mid: xmsmtpt1709110447t2alhx9za
Message-ID: <tencent_88FEE0A2C5E0852436A2F1A1087E6803380A@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5+DdQxOt7EblMGQYPjfWa7qBxdA9axrezMMfQnz09MBeCkgeptN
	 juxzBBrmwXkR+fTdxjyixdPFQ7e2+HvZENJn2O5o48CSwHT9PpAJMgzJLa2XcJFQWrSXvgMBrDLr
	 qPkyzwbGhowYlM5MYTw0V0wIYBgvL/KtFlIrdJ2UNfoKEujhrv37N8TXxvRgPfF8UUqz69WAsnjR
	 ykQY9yAQ02kbyPDeYfYNupxd1G4X0U2Ov3ZTovTaGqDzhJuUsjyt+wWLTfA+P0e37PZc4Xl4hK7m
	 z2YtSpJ/YJHyArBYr2/25l5o9dfZW6TS3L7SrrlOCY75R/8PkkiVy25JYUqw7Hk18zzqGPYlcQDk
	 ARf5mjWKer5ALTTQbQWYALlHMLEji6psiVYzDY72Ra/dX4RHq3ZAyfuOmPoqeWumW3mWGmDIamsf
	 +lsltrC5vw/5kqgFCtvtfBfnbd0YWxLkqf0ppnEDx60TZ0igo9qpKatwv0UB+npfOnAO0tHXVZOx
	 N+6E7OwGimKXM/mjPjqUsg3bp+Kjkr7ppqoMWPWOvHtnpl8i8C5S7Ckp+BIfmCDNIvvi4p2Fgutd
	 hGql7p0D4BQXU13YsHCZa3fu2sl/dAJ6WIgK+dfYuYKRijIOC5Yba+UNpsx/kbFR0nLbAC08g+Ps
	 6b2DjOYuZboFLBlhh4FXGOfqgYZIr2/vKUgo/M8SSlgISLa6kW7sxgK7naMUTrhVTdcEEd0Dg5Be
	 NrgAQZdCDvf2bdufRB3e0c41nLKTdZbZCzbbkBK8OuwC0fqbCbOxdHtRqyX7DGRz8uu9wMdackNp
	 QjeGVcFLF8TWP5zT6ZCknr15oSNJPzEPUKvP0VgZHHq4KI6nXXrVCQJgjC3ebx85Vhc41uvwnGYe
	 nvlu0FOB2y39G1f/PREijNSVlLD7eV9h56JoG0+J6Q8k6IaawX/5vcVd4+38+GTcRnXjmTPQ/sYk
	 1hzed3cA3DcRPZAv8C3E8jD6MLJ9xF9CbwBHCsEupVice/uOadSay41srGnvETYnUaq6M6QF//U4
	 9hXQ0C6Q==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3] riscv: dts: Move BUILTIN_DTB_SOURCE to common Kconfig
Date: Wed, 28 Feb 2024 16:52:54 +0800
X-OQ-MSGID: <20240228085255.201092-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BUILTIN_DTB_SOURCE was only configured for K210 before. Since
SOC_BUILTIN_DTB_DECLARE was removed at commit d5805af9fe9f ("riscv: Fix
builtin DTB handling") from patch [1], the kernel cannot choose one of the
dtbs from then on and always take the first one dtb to use. Then, another
commit 0ddd7eaffa64 ("riscv: Fix BUILTIN_DTB for sifive and microchip soc")
from patch [2] supports BUILTIN_DTB_SOURCE for other SoCs. However, this
feature will only work if the Kconfig we use links the dtb we expected in
the first place as mentioned in the thread [3]. Thus, a config
BUILTIN_DTB_SOURCE is needed for all SoCs to choose one dtb to use.

For some considerations, this patch also removes default y if XIP_KERNEL
for BUILTIN_DTB, as this requires setting a proper dtb to use on the
BUILTIN_DTB_SOURCE, else the kernel with XIP but does not set
BUILTIN_DTB_SOURCE or unselect BUILTIN_DTB will not boot.

Also, this patch removes the default dtb string for k210 from Kconfig to
nommu_k210_defconfig and nommu_k210_sdcard_defconfig to avoid complex
Kconfig settings for other SoCs in the future.

[1] https://lore.kernel.org/linux-riscv/20201208073355.40828-5-damien.lemoal@wdc.com/
[2] https://lore.kernel.org/linux-riscv/20210604120639.1447869-1-alex@ghiti.fr/
[3] https://lore.kernel.org/linux-riscv/CAK7LNATt_56mO2Le4v4EnPnAfd3gC8S_Sm5-GCsfa=qXy=8Lrg@mail.gmail.com/

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes since v2:
- some fixes on format and grammar
- v2: https://lore.kernel.org/linux-riscv/tencent_61DFA8E0B13696A3256E538C4BC856633406@qq.com/

Changes since v1:
- remove default y for BULTIN_DTB in any cases
- remove default DTB_SOURCE for k210 and moved to its defconfig file
- remove building dtb object file for other SoCs
- reword help message to say N if unsure for BUILTIN_DTB_SOURCE
- reword commit message
- v1: https://lore.kernel.org/linux-riscv/tencent_AB625442CC1BCFF86E04D7B5891C43719109@qq.com/

---
 arch/riscv/Kconfig                            | 14 +++++++-
 arch/riscv/Kconfig.socs                       | 32 -------------------
 arch/riscv/boot/dts/Makefile                  |  2 +-
 arch/riscv/boot/dts/canaan/Makefile           |  2 --
 arch/riscv/boot/dts/microchip/Makefile        |  1 -
 arch/riscv/boot/dts/sifive/Makefile           |  1 -
 arch/riscv/configs/nommu_k210_defconfig       |  2 ++
 .../riscv/configs/nommu_k210_sdcard_defconfig |  2 ++
 8 files changed, 18 insertions(+), 38 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 85c899d0133a..3d6d93d71257 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -1000,7 +1000,19 @@ config RISCV_ISA_FALLBACK
 config BUILTIN_DTB
 	bool "Built-in device tree"
 	depends on OF && NONPORTABLE
-	default y if XIP_KERNEL
+	help
+	  Build a device tree into the Linux image.
+	  This option should be selected if no bootloader is being used.
+	  If unsure, say N.
+
+
+config BUILTIN_DTB_SOURCE
+	string "Built-in device tree source"
+	depends on BUILTIN_DTB
+	help
+	  DTS file path (without suffix, relative to arch/riscv/boot/dts)
+	  for the DTS file that will be used to produce the DTB linked into the
+	  kernel.
 
 endmenu # "Boot options"
 
diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index e08e91c49abe..623de5f8a208 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -84,36 +84,4 @@ config SOC_CANAAN
 	help
 	  This enables support for Canaan Kendryte K210 SoC platform hardware.
 
-if ARCH_CANAAN
-
-config ARCH_CANAAN_K210_DTB_BUILTIN
-	def_bool SOC_CANAAN_K210_DTB_BUILTIN
-
-config SOC_CANAAN_K210_DTB_BUILTIN
-	bool "Builtin device tree for the Canaan Kendryte K210"
-	depends on ARCH_CANAAN
-	default y
-	select OF
-	select BUILTIN_DTB
-	help
-	  Build a device tree for the Kendryte K210 into the Linux image.
-	  This option should be selected if no bootloader is being used.
-	  If unsure, say Y.
-
-config ARCH_CANAAN_K210_DTB_SOURCE
-	string
-	default SOC_CANAAN_K210_DTB_SOURCE
-
-config SOC_CANAAN_K210_DTB_SOURCE
-	string "Source file for the Canaan Kendryte K210 builtin DTB"
-	depends on ARCH_CANAAN
-	depends on ARCH_CANAAN_K210_DTB_BUILTIN
-	default "k210_generic"
-	help
-	  Base name (without suffix, relative to arch/riscv/boot/dts/canaan)
-	  for the DTS file that will be used to produce the DTB linked into the
-	  kernel.
-
-endif # ARCH_CANAAN
-
 endmenu # "SoC selection"
diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index 72030fd727af..fdae05bbf556 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -8,4 +8,4 @@ subdir-y += sophgo
 subdir-y += starfive
 subdir-y += thead
 
-obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix /, $(subdir-y))
+obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix .dtb.o, $(CONFIG_BUILTIN_DTB_SOURCE))
diff --git a/arch/riscv/boot/dts/canaan/Makefile b/arch/riscv/boot/dts/canaan/Makefile
index 520623264c87..987d1f0c41f0 100644
--- a/arch/riscv/boot/dts/canaan/Makefile
+++ b/arch/riscv/boot/dts/canaan/Makefile
@@ -5,5 +5,3 @@ dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_bit.dtb
 dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_dock.dtb
 dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maix_go.dtb
 dtb-$(CONFIG_ARCH_CANAAN) += sipeed_maixduino.dtb
-
-obj-$(CONFIG_ARCH_CANAAN_K210_DTB_BUILTIN) += $(addsuffix .dtb.o, $(CONFIG_ARCH_CANAAN_K210_DTB_SOURCE))
diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
index 45adc4926e79..e177815bf1a2 100644
--- a/arch/riscv/boot/dts/microchip/Makefile
+++ b/arch/riscv/boot/dts/microchip/Makefile
@@ -4,4 +4,3 @@ dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-m100pfsevp.dtb
 dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-polarberry.dtb
 dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-sev-kit.dtb
 dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-tysom-m.dtb
-obj-$(CONFIG_BUILTIN_DTB) += $(addsuffix .o, $(dtb-y))
diff --git a/arch/riscv/boot/dts/sifive/Makefile b/arch/riscv/boot/dts/sifive/Makefile
index 6a5fbd4ed96a..495bf760a909 100644
--- a/arch/riscv/boot/dts/sifive/Makefile
+++ b/arch/riscv/boot/dts/sifive/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_SIFIVE) += hifive-unleashed-a00.dtb \
 			     hifive-unmatched-a00.dtb
-obj-$(CONFIG_BUILTIN_DTB) += $(addsuffix .o, $(dtb-y))
diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index 146c46d0525b..7e75200543f4 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -33,6 +33,8 @@ CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_CMDLINE="earlycon console=ttySIF0"
 CONFIG_CMDLINE_FORCE=y
+CONFIG_BUILTIN_DTB=y
+CONFIG_BUILTIN_DTB_SOURCE="canaan/k210_generic"
 # CONFIG_SECCOMP is not set
 # CONFIG_STACKPROTECTOR is not set
 # CONFIG_GCC_PLUGINS is not set
diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
index 95d8d1808f19..0ba353e9ca71 100644
--- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
+++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
@@ -25,6 +25,8 @@ CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_CMDLINE="earlycon console=ttySIF0 root=/dev/mmcblk0p1 rootwait ro"
 CONFIG_CMDLINE_FORCE=y
+CONFIG_BUILTIN_DTB=y
+CONFIG_BUILTIN_DTB_SOURCE="canaan/k210_generic"
 # CONFIG_SECCOMP is not set
 # CONFIG_STACKPROTECTOR is not set
 # CONFIG_GCC_PLUGINS is not set
-- 
2.43.0


