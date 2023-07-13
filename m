Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5A9752A86
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 20:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjGMSxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 14:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjGMSxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 14:53:22 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE132D7D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 11:53:12 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36DIqvvp021174;
        Thu, 13 Jul 2023 13:52:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689274377;
        bh=PNIHPvWhnt80ZYRMyXr53ZSClDYFIhceN99jnzNnQKg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CeESNChvpNCLiiUO7eyomMtmBYCAocsyCxVQC2Wlt+39+3PHmVQR9a5bAOnkFu8cS
         cwEhq4b3tsIvhba15+nwuPGk0Gw0W8ANSic/LX2KWJA3TrEji97OalwNitdBPS0gzw
         dSQNQ8LXFg0mjHDcifbwbLCua0TXzXBL/YIqmQp4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36DIqv9L109608
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Jul 2023 13:52:57 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jul 2023 13:52:57 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jul 2023 13:52:56 -0500
Received: from fllv0040.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36DIqshA080681;
        Thu, 13 Jul 2023 13:52:56 -0500
From:   Andrew Davis <afd@ti.com>
To:     Russell King <linux@armlinux.org.uk>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v3 5/5] ARM: mach-moxart: Move MOXA ART support into Kconfig.platforms
Date:   Thu, 13 Jul 2023 13:52:52 -0500
Message-ID: <20230713185252.27797-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230713185252.27797-1-afd@ti.com>
References: <20230713185252.27797-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the need for a dedicated Kconfig and empty mach directory.

Signed-off-by: Andrew Davis <afd@ti.com>
---

Changes from v1/v2:
 - Rebased on latest master

 arch/arm/Kconfig              |  2 --
 arch/arm/Kconfig.platforms    | 28 ++++++++++++++++++++++++++++
 arch/arm/Makefile             |  1 -
 arch/arm/mach-moxart/Kconfig  | 28 ----------------------------
 arch/arm/mach-moxart/Makefile |  4 ----
 arch/arm/mach-moxart/moxart.c |  6 ------
 6 files changed, 28 insertions(+), 41 deletions(-)
 delete mode 100644 arch/arm/mach-moxart/Kconfig
 delete mode 100644 arch/arm/mach-moxart/Makefile
 delete mode 100644 arch/arm/mach-moxart/moxart.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index df93b29a5da1a..688d832959a54 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -411,8 +411,6 @@ source "arch/arm/mach-milbeaut/Kconfig"
 
 source "arch/arm/mach-mmp/Kconfig"
 
-source "arch/arm/mach-moxart/Kconfig"
-
 source "arch/arm/mach-mstar/Kconfig"
 
 source "arch/arm/mach-mv78xx0/Kconfig"
diff --git a/arch/arm/Kconfig.platforms b/arch/arm/Kconfig.platforms
index 0e6d7172bf61e..4b5fad18ca8b0 100644
--- a/arch/arm/Kconfig.platforms
+++ b/arch/arm/Kconfig.platforms
@@ -76,6 +76,34 @@ config MACH_ASM9260
 	help
 	  Support for Alphascale ASM9260 based platform.
 
+menuconfig ARCH_MOXART
+	bool "MOXA ART SoC"
+	depends on ARCH_MULTI_V4
+	depends on CPU_LITTLE_ENDIAN
+	select CPU_FA526
+	select ARM_DMA_MEM_BUFFERABLE
+	select FARADAY_FTINTC010
+	select FTTMR010_TIMER
+	select GPIOLIB
+	select PHYLIB if NETDEVICES
+	help
+	  Say Y here if you want to run your kernel on hardware with a
+	  MOXA ART SoC.
+	  The MOXA ART SoC is based on a Faraday FA526 ARMv4 32-bit
+	  192 MHz CPU with MMU and 16KB/8KB D/I-cache (UC-7112-LX).
+	  Used on models UC-7101, UC-7112/UC-7110, IA240/IA241, IA3341.
+
+if ARCH_MOXART
+
+config MACH_UC7112LX
+	bool "MOXA UC-7112-LX"
+	depends on ARCH_MOXART
+	help
+	  Say Y here if you intend to run this kernel on a MOXA
+	  UC-7112-LX embedded computer.
+
+endif
+
 config ARCH_RDA
 	bool "RDA Micro SoCs"
 	depends on ARCH_MULTI_V7
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 547e5856eaa0d..32e99aa282bf9 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -192,7 +192,6 @@ machine-$(CONFIG_ARCH_LPC18XX)		+= lpc18xx
 machine-$(CONFIG_ARCH_LPC32XX)		+= lpc32xx
 machine-$(CONFIG_ARCH_MESON)		+= meson
 machine-$(CONFIG_ARCH_MMP)		+= mmp
-machine-$(CONFIG_ARCH_MOXART)		+= moxart
 machine-$(CONFIG_ARCH_MV78XX0)		+= mv78xx0
 machine-$(CONFIG_ARCH_MVEBU)		+= mvebu
 machine-$(CONFIG_ARCH_MXC)		+= imx
diff --git a/arch/arm/mach-moxart/Kconfig b/arch/arm/mach-moxart/Kconfig
deleted file mode 100644
index 909c6573ba8b1..0000000000000
--- a/arch/arm/mach-moxart/Kconfig
+++ /dev/null
@@ -1,28 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-menuconfig ARCH_MOXART
-	bool "MOXA ART SoC"
-	depends on ARCH_MULTI_V4
-	depends on CPU_LITTLE_ENDIAN
-	select CPU_FA526
-	select ARM_DMA_MEM_BUFFERABLE
-	select FARADAY_FTINTC010
-	select FTTMR010_TIMER
-	select GPIOLIB
-	select PHYLIB if NETDEVICES
-	help
-	  Say Y here if you want to run your kernel on hardware with a
-	  MOXA ART SoC.
-	  The MOXA ART SoC is based on a Faraday FA526 ARMv4 32-bit
-	  192 MHz CPU with MMU and 16KB/8KB D/I-cache (UC-7112-LX).
-	  Used on models UC-7101, UC-7112/UC-7110, IA240/IA241, IA3341.
-
-if ARCH_MOXART
-
-config MACH_UC7112LX
-	bool "MOXA UC-7112-LX"
-	depends on ARCH_MOXART
-	help
-	  Say Y here if you intend to run this kernel on a MOXA
-	  UC-7112-LX embedded computer.
-
-endif
diff --git a/arch/arm/mach-moxart/Makefile b/arch/arm/mach-moxart/Makefile
deleted file mode 100644
index ded3e38fb98d3..0000000000000
--- a/arch/arm/mach-moxart/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-# Object file lists.
-
-obj-$(CONFIG_MACH_UC7112LX)	+= moxart.o
diff --git a/arch/arm/mach-moxart/moxart.c b/arch/arm/mach-moxart/moxart.c
deleted file mode 100644
index f1f58c0c0fa1c..0000000000000
--- a/arch/arm/mach-moxart/moxart.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * arch/arm/mach-moxart/moxart.c
- *
- * (C) Copyright 2013, Jonas Jensen <jonas.jensen@gmail.com>
- */
-- 
2.39.2

