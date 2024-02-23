Return-Path: <linux-kernel+bounces-79075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 875CE861D44
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36461C22907
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C964D14690B;
	Fri, 23 Feb 2024 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="z1w5sW/k"
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D971448DD;
	Fri, 23 Feb 2024 20:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708718729; cv=none; b=JHr32UCL4PUR761k2oiq7M2jicXM2Tyxeup+fe1aPgD85JVkcusk0k1DngQrCGgCZCJ3wrXIIBHPH+x/TZr0rw1QprbWyi5LYaFmnqwum1vU/hj1oVMR+zcEe2LsreliZ0IoL6MT1/GtpH8GwL9q8CU6VJm3NAxRXsmRFXa7CPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708718729; c=relaxed/simple;
	bh=Mm1874xOaWGSX/4lpmuBBHcJ9Oz40abiBvB//puhxjw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=HtBKoaW9hd47Tfnp7Xhm/SLsCzknRsC2R9uj6/sI4pjhXCULUyuKelTnqSaRTrhCd5ul4ZTrLw0TUr7/kD+szEIk93+jWSqvvjVYoEgr1McrFnbfKojnMbfmbhE/D6cnk1OskRItr/guKCusVbSSM/rqQS1aB2zdPTJBSoOaK38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=z1w5sW/k; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708718712; bh=1x7RR20iHdqrvSarT+8ncAOxhf4eqeuhxqiRBpiCA+w=;
	h=From:To:Cc:Subject:Date;
	b=z1w5sW/k0cV4pR8kjfvoyfFR/qaaSYbULeaFsR/6snTgA5hYaC1zRdb5W1MygNW1m
	 SvphXU84+OE4M5xNeTHwqENjm6uOYnDtbCYs1w0VqWemGcM3tbsOMGKBUVHryjtVe7
	 Vtiuu56BCpN2Kfax+0o33lL2pl1+bQSB1LS8DdKE=
Received: from cyy-pc.lan ([240e:379:2240:ef00:159c:db93:bdcd:c9c6])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 148048B8; Sat, 24 Feb 2024 04:05:08 +0800
X-QQ-mid: xmsmtpt1708718708tfrs0kqnv
Message-ID: <tencent_61DFA8E0B13696A3256E538C4BC856633406@qq.com>
X-QQ-XMAILINFO: Nwl7PuG5jlSkpv89wmEjCCtsC2OI9S3j37EaXZFkIpXBasYE7HNrgBOu9WtZaG
	 tYrEaeQknSR1lJWms5YwCE6f1OyKMc9X79D0h2XGqhGizSGo2wvGm2HWuFz3sGHQv/XaOcG7AZEI
	 VOVTrzIKV8Eb0rsgWLdPRsKZFUYEHbFj9EdRY+TBjDqOf3kFs+o7xX/EHSuAGVLLNsQbx/DnmFOv
	 7RDlNFGpnCKL7VeFRsZjT6EEvHlG1CzA0PsUPILmaodUL1Ry6GEhcwfqnM5AijDhC86ou+FQzBgV
	 F/jBzZnaKsPFFc3Jb9MY1kW/RNWoXxgW1QdXhcmOLvxdiUmfOykf0gfchl6Wqga+DZyNZTTjmaKv
	 LSld6nLYchA36bH2S44KyF/kAbPJbmLG0x0ts3ood5Rys/uvi+m7LyOu7BvDLD9GuLhpFXnhO92S
	 LnXYiFcqiUVJp+Rk/dGmDC5zzZCGuUxjPRR3uzjsYwWgDuV7/ZdcRREkE/Z6HIKyWCnPwnUxn9aA
	 5Pz2NjXhypJEqfr5mcrVzkPPE7aCwNDlpv/Z6pg6K8JA9JI5LF7pGqXT5NHW/9/WItcYqPuDX5Hc
	 CpMFNBKSN3IkpJzV5KFW/03zYNbbjGCCB5qavjebAwOltjzaeyzKDa0ypkeX25mKo97B6e3nPnFY
	 LBwhVWbIMwtu2LbL4LuH2XpJPWRuuprV4G37lPe3KuUADsLlYz341K11v6V5qtTH+MPdgvZixsW2
	 4L3HUpr+BnA2V519a4AToLH5ydIMIYPpXvzGVUnI6Pb1TUsQ/9/xz1EVEvpALJ8nwm62JW+arM2U
	 p0vjadDILB5+2kApH9665HWZRmjUi4yfiknT/xv9VeSqah+80+XrXHjmz28vJZ/o0PLE6zLRugAy
	 5iSJCpM5j6CJ13hU9qQMkFNDChvRVABE20Cz43hMq+fUNc1Cw76B2M7cKiob3ub66jhJH4U+oGZW
	 OZyi2LMJILgdLrlazJBOaTn0JWWXbPAg4PyrSyu37+qPwyHsJw7PUHTAYk7k4V1K5I4bR4Y85DNz
	 9znAExBQ==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v2] riscv: dts: Move BUILTIN_DTB_SOURCE to common Kconfig
Date: Sat, 24 Feb 2024 04:05:07 +0800
X-OQ-MSGID: <20240223200507.3702579-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BUILTIN_DTB_SOURCE is only configured for K210 before. Since
SOC_BUILTIN_DTB_DECLARE is removed at commit d5805af9fe9f ("riscv: Fix
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

Changes since v1:
- remove default y for BULTIN_DTB in any cases
- remove default DTB_SOURCE for k210 and moved to its defconfig file
- remove building dtb object file for other SoCs
- reword help message to say N if unsure for BUILTIN_DTB_SOURCE
- reword commit message
- v1: https://lore.kernel.org/linux-riscv/tencent_AB625442CC1BCFF86E04D7B5891C43719109@qq.com/

[1] https://lore.kernel.org/linux-riscv/20201208073355.40828-5-damien.lemoal@wdc.com/
[2] https://lore.kernel.org/linux-riscv/20210604120639.1447869-1-alex@ghiti.fr/
[3] https://lore.kernel.org/linux-riscv/CAK7LNATt_56mO2Le4v4EnPnAfd3gC8S_Sm5-GCsfa=qXy=8Lrg@mail.gmail.com/

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
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


