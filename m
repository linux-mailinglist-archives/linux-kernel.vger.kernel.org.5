Return-Path: <linux-kernel+bounces-29882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 829268314B2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B40287DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EF92E85A;
	Thu, 18 Jan 2024 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Px51Q4dV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B06320B1A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566180; cv=none; b=uhUMc3QY2vNjzkF3I0PJjIXwfpQu/wFcnVyyX/SupI9UdyCIXOE05eOe7+/ikbHBPkjym+Pb+LQakxYvxTkT6eCSiEultnDThWC7mOnbG17mlLlSmoQ5FtWEO2WXamvy0yORwQsOLYOJUULJlN/RFD4YfHCijR0cIjqx6m7ytqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566180; c=relaxed/simple;
	bh=QCg9rJSnTImn9F6nxF3iBpK7rQvuc5LelxMpA31x41E=;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To; b=gv5vkcgj3p4ibtg1UhC5sCf1OTbtx+B4kBG14PBg9dTmt6j+51Q4wxzApx6XbxHtGnKwkCj/M8dtBqtGnZ4g69eFI5azW8TYZDBZtkeX5YSgJ3gSBmWSiq4bu3zLIzL0kV4x5+MIGqE4slBOVSdPxiYBD2dVLbrRmt9iH1He78U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Px51Q4dV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49A91C4E686;
	Thu, 18 Jan 2024 08:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705566180;
	bh=QCg9rJSnTImn9F6nxF3iBpK7rQvuc5LelxMpA31x41E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Px51Q4dVXrDAKzPkdDHPjuxFStZFFczEp9pvnj4qc6G2V0G0RLSWp03PYF4jrWRRc
	 efw15gnUoOX9Kwh5QBMPAL03dYvjpaxCsMv1p1uXRHqT27PoFiclCxOINYkooaacrc
	 oaQb0B2s1FNFakoIs/+FGZHPeAeXaGbUL8I1BUstNEUEZ5tpj+DglSDmZt01Mk7a90
	 iIpU09O7t5fFRWpQBOYdUegifQdcEOWITCElYGHXlRqy4JzJ2a7PydFcP7vHAo9u2C
	 PyVKEbDdVZnj+9Yl7/XhUPUmFxEpnD++wjIsC7IaUSkNv9eNpO6x5CEbA23d4CmHGt
	 2MJDys3UYjZPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366F2C47DB7;
	Thu, 18 Jan 2024 08:23:00 +0000 (UTC)
From:
 Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Thu, 18 Jan 2024 11:21:16 +0300
Subject: [PATCH v7 33/39] ARM: ep93xx: DT for the Cirrus ep93xx SoC
 platforms
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240118-ep93xx-v7-33-d953846ae771@maquefel.me>
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
In-Reply-To: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me>
To: Russell King <linux@armlinux.org.uk>, 
 Hartley Sweeten <hsweeten@visionengravers.com>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Arnd Bergmann <arnd@arndb.de>, Andrew Davis <afd@ti.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Nicolas Saenz Julienne <nsaenz@kernel.org>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Nikita Shubin <nikita.shubin@maquefel.me>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Guo Ren <guoren@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705566176; l=3110;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=O6GrIsD1SB+/F4S38OtUNM1CjdG8NlCZCMIgktV/0gY=; =?utf-8?q?b=3Dpac46QFAeO+P?=
 =?utf-8?q?WBDYmcatl8FNmJeHZMewACZJP/rCirhdhUKDMLcg09Ap1qcqmycNU5yWCotL393W?=
 /TdF2/pgBsFWqLCOQ8SywWor1QIpJeBOoqKfvT+jBQr2AURmYYq/
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received:
 by B4 Relay for nikita.shubin@maquefel.me/20230718 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: <nikita.shubin@maquefel.me>

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add compulsory device tree support to the Cirrus ep93xx ARMv4 platform.

- select PINCTRL_EP93xx
- select COMMON_CLK_EP93XX, as clock driver moved out of platform code
- select ARCH_HAS_RESET_CONTROLLER

Select ARM_ATAG_DTB_COMPAT to update device tree with information
about memory passed from bootloader.

We have to leave all MACH options as they are used for board checking
before decomp, to turn off watchdog and ethernet DMA.

Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 arch/arm/Makefile             |  1 -
 arch/arm/mach-ep93xx/Kconfig  | 20 ++++++++++----------
 arch/arm/mach-ep93xx/Makefile | 11 -----------
 3 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 473280d5adce..68a08835feed 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -178,7 +178,6 @@ machine-$(CONFIG_ARCH_CLPS711X)		+= clps711x
 machine-$(CONFIG_ARCH_DAVINCI)		+= davinci
 machine-$(CONFIG_ARCH_DIGICOLOR)	+= digicolor
 machine-$(CONFIG_ARCH_DOVE)		+= dove
-machine-$(CONFIG_ARCH_EP93XX)		+= ep93xx
 machine-$(CONFIG_ARCH_EXYNOS)		+= exynos
 machine-$(CONFIG_ARCH_FOOTBRIDGE)	+= footbridge
 machine-$(CONFIG_ARCH_GEMINI)		+= gemini
diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
index 703f3d232a60..812b71dcf60e 100644
--- a/arch/arm/mach-ep93xx/Kconfig
+++ b/arch/arm/mach-ep93xx/Kconfig
@@ -3,27 +3,27 @@ menuconfig ARCH_EP93XX
 	bool "EP93xx-based"
 	depends on ATAGS
 	depends on ARCH_MULTI_V4T
+	# CONFIG_ARCH_MULTI_V7 is not set
 	depends on CPU_LITTLE_ENDIAN
+	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_SPARSEMEM_ENABLE
 	select ARM_AMBA
 	select ARM_VIC
+	select ARM_APPENDED_DTB # Old Redboot bootloaders deployed
+	select ARM_ATAG_DTB_COMPAT # we need this to update dt memory node
+	select COMMON_CLK_EP93XX
+	select EP93XX_TIMER
 	select CLKSRC_MMIO
 	select CPU_ARM920T
 	select GPIOLIB
+	select PINCTRL
+	select PINCTRL_EP93XX
 	help
 	  This enables support for the Cirrus EP93xx series of CPUs.
 
 if ARCH_EP93XX
 
-menu "Cirrus EP93xx Implementation Options"
-
-config EP93XX_SOC_COMMON
-	bool
-	default y
-	select SOC_BUS
-	select LEDS_GPIO_REGISTER
-
-comment "EP93xx Platforms"
+# menu "EP93xx Platforms"
 
 config MACH_BK3
 	bool "Support Liebherr BK3.1"
@@ -103,6 +103,6 @@ config MACH_VISION_EP9307
 	  Say 'Y' here if you want your kernel to support the
 	  Vision Engraving Systems EP9307 SoM.
 
-endmenu
+# endmenu
 
 endif
diff --git a/arch/arm/mach-ep93xx/Makefile b/arch/arm/mach-ep93xx/Makefile
deleted file mode 100644
index 62e37403df14..000000000000
--- a/arch/arm/mach-ep93xx/Makefile
+++ /dev/null
@@ -1,11 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Makefile for the linux kernel.
-#
-obj-y			:= core.o clock.o timer-ep93xx.o
-
-obj-$(CONFIG_EP93XX_DMA)	+= dma.o
-
-obj-$(CONFIG_MACH_EDB93XX)	+= edb93xx.o
-obj-$(CONFIG_MACH_TS72XX)	+= ts72xx.o
-obj-$(CONFIG_MACH_VISION_EP9307)+= vision_ep9307.o

-- 
2.41.0


