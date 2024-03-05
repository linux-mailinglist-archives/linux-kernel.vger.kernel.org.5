Return-Path: <linux-kernel+bounces-92898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEFC8727BB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4091F28855
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5182F12A169;
	Tue,  5 Mar 2024 19:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="D+2wNlRE"
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6DB1292D4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 19:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709667556; cv=none; b=POiMZrjB7xLg6cD7DnfsOM5V51OEsw+8yaXQ5nuMFSiljKvJxIvek2HrwoVsTJ7zpyvb0SVnhyZoTI8JAWwKaeDCLYyRSHjJeBFvt3Mujp0uEyJfvzOaW8B+r+EBf0q7WLJggmGp1biWpmGOB40mb++Z1HcBCNGb/xuPPzgleTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709667556; c=relaxed/simple;
	bh=ZRCe/0J58yTVWClEPpd7JnYEX1QgEiQ9zOXg5I8wZGA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ZK74ZDLfk+y+2+rBymjOtrg2jqiVH1QLiU2CLQpWNpSptngs3tUv1PMnRibZjCrv7ZVljtxQL1O01vcvRcHhqk2LieVEDl1WiLkA7v2TfadcIgCKFeFyf0UuaO7TYDl9Zmp3xdXe5NOGjKQ9W9LJfUAiDbmqQh9294EX73wImAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=D+2wNlRE; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709667547; bh=AR+FBWrcsSxuq/q16g4TwIGEvVWNZKJ7JXfI2Q9ft4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D+2wNlRE8JXEnITEldzN3ADvWY6xHWXiJTJrfA238anzCMfKbTEdMni75Iz+pft9K
	 FamRVk9T5SQEq13jO7dYZR6upOcYbB8MKvusGd0hAVsAe8ULa4nrCd/iEB7tPFPpW2
	 NigeYRNDwEXokuPUASSF+Rh0ENoXdKM0iYRla2tI=
Received: from cyy-pc.lan ([240e:379:2267:e200:bd8:e8f9:fb59:de48])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 9B6B9246; Wed, 06 Mar 2024 03:38:54 +0800
X-QQ-mid: xmsmtpt1709667544t69kjbg21
Message-ID: <tencent_69D731862164AB318B2F48105A7BCCD11405@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8RA6sM/aK2Q9KTCp/6yBXqvscvSKaus3MhfJvyuAB1QOrfJWYf6
	 FlZnb8GRvTXI6fOSLQp3uw+ZYMPFkvLCO2NYYqmDQdrh1sIG4tU1Io+h1+4c0ohIxx50iJcraL/0
	 ZPqF8yFyQXQolf2K1TieNXOufPLj4+oT5cBg+Z0HMkXzxzDTUG9ujKdUNkXmh1ogNU1HHcTgi1gQ
	 s7HzAc5qHc1wh8e9HHWEbbcnA6m3a4RehFgSbmZxULX8KHfwrPq6PFuuG5oEb0C2HKKrORHb7ZVa
	 UdlwXQenJJBorJgPi8pgtlRAA5AZsIWeS7Kf85MfnS4avlk3TJd+xMpc0692i4X2GX15EB4IqBC+
	 CKsy+wPgwtI+adHMzbe2Y01DC8EigD/vpM8o4Bjc1w0R/esdFzFQnpmgaN5PqWnU6X1OgLzvh4Il
	 LUWy1xlkWZBOhDpqmGGDfJah34UBMopmI4hqo1m1ilGP0lyX/yXuVvSAAeTbUw2TK7ccbtk7JP2e
	 pWVZhGS4sU/CyWqgGyN4auC140cGlI//J3xjhgKNXuF3pW4HryNZMynBveKgMRqzUeh4B4uQdYxq
	 P3YZ4rXQhxX91hDdMVnUWlcsJuz8hJok+Pgt4bbxxsFxwYX7i2yMoX7Vtdc63NWkibHIlVsc4CRl
	 KtdWEshmEfTrtsA5XqLJoSA7ZT+xSaTxTCJ2n7JVDDUc4Wy7H19dVQuilPiDYpCYSnSKB7ZL5wNa
	 gWR11Cp4jqMnnRyS59crAKI0CygeTuwDoxir3jUk6DCTgae/fOE9bIMsoWln5j+8+9QruShPnZy9
	 Km+o6cMFyhqBXUweqkrOQsOl3d/MQeoNN1Ue6LXnzR2mzGgPbtGfK/Lp7KlPZW2nEvsDHdKhT5ci
	 zRIU9+bR8WRMucI3eByNO6MjePzO3sfbX8y0Qjz407peBfo7TByDPBRqiySGNGix80wpPD5nu9uh
	 WdOFNuU2KcC1BGzMA1Ml1ZFz1xeUlqnyDlDxorWf7xZg39a5rYGr/HJun2iioswuHGxCw/R7qMod
	 Ml51YZGHI5L22dKWdQA8VZH3Wuc3RF8MJmQr0dVQWCVryAfXYzAlEXksfZ73k=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
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
Subject: [PATCH v4 5/7] riscv: Kconfig.socs: Split ARCH_CANAAN and SOC_CANAAN_K210
Date: Wed,  6 Mar 2024 03:38:29 +0800
X-OQ-MSGID: <20240305193831.1084556-5-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_587730262984A011834F42D0563BC6B10405@qq.com>
References: <tencent_587730262984A011834F42D0563BC6B10405@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we have Canaan Kendryte K230 with MMU now. The use of SOC_CANAAN
is no longer only referred to K210. Split them and add _K210 suffix
to the name for old SOC_CANAAN. And allows ARCH_CANAAN to be selected
for other Canaan SoCs.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 arch/riscv/Kconfig.socs                        | 8 +++++---
 arch/riscv/Makefile                            | 2 +-
 arch/riscv/configs/nommu_k210_defconfig        | 3 ++-
 arch/riscv/configs/nommu_k210_sdcard_defconfig | 3 ++-
 drivers/clk/Kconfig                            | 4 ++--
 drivers/pinctrl/Kconfig                        | 4 ++--
 drivers/reset/Kconfig                          | 4 ++--
 drivers/soc/Makefile                           | 2 +-
 drivers/soc/canaan/Kconfig                     | 4 ++--
 9 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 623de5f8a208..5710aee456ac 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -72,11 +72,13 @@ config SOC_VIRT
 	  This enables support for QEMU Virt Machine.
 
 config ARCH_CANAAN
-	def_bool SOC_CANAAN
+	bool "Canaan Kendryte SoC"
+	help
+	  This enables support for Canaan Kendryte SoC platform hardware.
 
-config SOC_CANAAN
+config SOC_CANAAN_K210
 	bool "Canaan Kendryte K210 SoC"
-	depends on !MMU
+	depends on !MMU && ARCH_CANAAN
 	select CLINT_TIMER if RISCV_M_MODE
 	select ARCH_HAS_RESET_CONTROLLER
 	select PINCTRL
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 252d63942f34..fa6c389c3986 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -154,7 +154,7 @@ vdso-install-y			+= arch/riscv/kernel/vdso/vdso.so.dbg
 vdso-install-$(CONFIG_COMPAT)	+= arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg:../compat_vdso/compat_vdso.so
 
 ifneq ($(CONFIG_XIP_KERNEL),y)
-ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN),yy)
+ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_CANAAN_K210),yy)
 KBUILD_IMAGE := $(boot)/loader.bin
 else
 ifeq ($(CONFIG_EFI_ZBOOT),)
diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index 7e75200543f4..2552e78074a3 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -27,7 +27,8 @@ CONFIG_EXPERT=y
 CONFIG_SLUB=y
 CONFIG_SLUB_TINY=y
 # CONFIG_MMU is not set
-CONFIG_SOC_CANAAN=y
+CONFIG_ARCH_CANAAN=y
+CONFIG_SOC_CANAAN_K210=y
 CONFIG_NONPORTABLE=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
index 0ba353e9ca71..8f67fb830585 100644
--- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
+++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
@@ -19,7 +19,8 @@ CONFIG_EXPERT=y
 CONFIG_SLUB=y
 CONFIG_SLUB_TINY=y
 # CONFIG_MMU is not set
-CONFIG_SOC_CANAAN=y
+CONFIG_ARCH_CANAAN=y
+CONFIG_SOC_CANAAN_K210=y
 CONFIG_NONPORTABLE=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 50af5fc7f570..7517a0dfd15c 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -451,8 +451,8 @@ config COMMON_CLK_FIXED_MMIO
 
 config COMMON_CLK_K210
 	bool "Clock driver for the Canaan Kendryte K210 SoC"
-	depends on OF && RISCV && SOC_CANAAN
-	default SOC_CANAAN
+	depends on OF && RISCV && SOC_CANAAN_K210
+	default SOC_CANAAN_K210
 	help
 	  Support for the Canaan Kendryte K210 RISC-V SoC clocks.
 
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 8163a5983166..837b3bac8aac 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -217,13 +217,13 @@ config PINCTRL_INGENIC
 
 config PINCTRL_K210
 	bool "Pinctrl driver for the Canaan Kendryte K210 SoC"
-	depends on RISCV && SOC_CANAAN && OF
+	depends on RISCV && SOC_CANAAN_K210 && OF
 	select GENERIC_PINMUX_FUNCTIONS
 	select GENERIC_PINCONF
 	select GPIOLIB
 	select OF_GPIO
 	select REGMAP_MMIO
-	default SOC_CANAAN
+	default SOC_CANAAN_K210
 	help
 	  Add support for the Canaan Kendryte K210 RISC-V SOC Field
 	  Programmable IO Array (FPIOA) controller.
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index ccd59ddd7610..6499da7ecc3b 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -94,9 +94,9 @@ config RESET_INTEL_GW
 
 config RESET_K210
 	bool "Reset controller driver for Canaan Kendryte K210 SoC"
-	depends on (SOC_CANAAN || COMPILE_TEST) && OF
+	depends on (SOC_CANAAN_K210 || COMPILE_TEST) && OF
 	select MFD_SYSCON
-	default SOC_CANAAN
+	default SOC_CANAAN_K210
 	help
 	  Support for the Canaan Kendryte K210 RISC-V SoC reset controller.
 	  Say Y if you want to control reset signals provided by this
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index ba8f5b5460e1..fb2bd31387d0 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -7,7 +7,7 @@ obj-y				+= apple/
 obj-y				+= aspeed/
 obj-$(CONFIG_ARCH_AT91)		+= atmel/
 obj-y				+= bcm/
-obj-$(CONFIG_SOC_CANAAN)	+= canaan/
+obj-$(CONFIG_ARCH_CANAAN)	+= canaan/
 obj-$(CONFIG_ARCH_DOVE)		+= dove/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-y				+= fsl/
diff --git a/drivers/soc/canaan/Kconfig b/drivers/soc/canaan/Kconfig
index 43ced2bf8444..3121d351fea6 100644
--- a/drivers/soc/canaan/Kconfig
+++ b/drivers/soc/canaan/Kconfig
@@ -2,9 +2,9 @@
 
 config SOC_K210_SYSCTL
 	bool "Canaan Kendryte K210 SoC system controller"
-	depends on RISCV && SOC_CANAAN && OF
+	depends on RISCV && SOC_CANAAN_K210 && OF
 	depends on COMMON_CLK_K210
-	default SOC_CANAAN
+	default SOC_CANAAN_K210
 	select PM
 	select MFD_SYSCON
 	help
-- 
2.43.0


