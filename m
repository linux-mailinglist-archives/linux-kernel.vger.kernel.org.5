Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7530752A88
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 20:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjGMSx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 14:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjGMSxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 14:53:25 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7399730C0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 11:53:13 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36DIqtvx021156;
        Thu, 13 Jul 2023 13:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689274375;
        bh=rGrWFWxY4ESF8sdW5ypK/P2FATFfx8obqzCnF/iJuPw=;
        h=From:To:CC:Subject:Date;
        b=xpVVpS07DZL96z4smDz/aUgYX5LbBu+wPKgettPpG6jrZMdt7P5b+H9Tupe2VH0wY
         SgFEqOdHpi1y8tC9lr9gvl6uMu5acYyjYRBXuTJfrmrBwG2PfinZYyuhwVLrCsIhPU
         eH/1dzGjaB2qHMFx/uzvhT0vP7WgpsZH8jDh5D5A=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36DIqtId109566
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Jul 2023 13:52:55 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jul 2023 13:52:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jul 2023 13:52:54 -0500
Received: from fllv0040.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36DIqsh6080681;
        Thu, 13 Jul 2023 13:52:54 -0500
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
Subject: [PATCH v3 1/5] ARM: Kconfig: move platform selection into its own Kconfig file
Date:   Thu, 13 Jul 2023 13:52:48 -0500
Message-ID: <20230713185252.27797-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
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

Mostly just for better organization for now. This matches what is done on
some other platforms including ARM64. This also lets us start to reduce
the number of mach- directories that only exist to store the platform
selection.

Start with "Platform selection" and ARCH_VIRT.

Signed-off-by: Andrew Davis <afd@ti.com>
---

Changes from v1/v2:
 - Rebased on latest master

 arch/arm/Kconfig           | 67 +------------------------------------
 arch/arm/Kconfig.platforms | 68 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+), 66 deletions(-)
 create mode 100644 arch/arm/Kconfig.platforms

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7a27550ff3c1f..1c49cd5c308db 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -339,72 +339,7 @@ config ARCH_MULTIPLATFORM
 	  Selecting N here allows using those options, including
 	  DEBUG_UNCOMPRESS, XIP_KERNEL and ZBOOT_ROM. If unsure, say Y.
 
-menu "Platform selection"
-	depends on MMU
-
-comment "CPU Core family selection"
-
-config ARCH_MULTI_V4
-	bool "ARMv4 based platforms (FA526, StrongARM)"
-	depends on !ARCH_MULTI_V6_V7
-	# https://github.com/llvm/llvm-project/issues/50764
-	depends on !LD_IS_LLD || LLD_VERSION >= 160000
-	select ARCH_MULTI_V4_V5
-	select CPU_FA526 if !(CPU_SA110 || CPU_SA1100)
-
-config ARCH_MULTI_V4T
-	bool "ARMv4T based platforms (ARM720T, ARM920T, ...)"
-	depends on !ARCH_MULTI_V6_V7
-	# https://github.com/llvm/llvm-project/issues/50764
-	depends on !LD_IS_LLD || LLD_VERSION >= 160000
-	select ARCH_MULTI_V4_V5
-	select CPU_ARM920T if !(CPU_ARM7TDMI || CPU_ARM720T || \
-		CPU_ARM740T || CPU_ARM9TDMI || CPU_ARM922T || \
-		CPU_ARM925T || CPU_ARM940T)
-
-config ARCH_MULTI_V5
-	bool "ARMv5 based platforms (ARM926T, XSCALE, PJ1, ...)"
-	depends on !ARCH_MULTI_V6_V7
-	select ARCH_MULTI_V4_V5
-	select CPU_ARM926T if !(CPU_ARM946E || CPU_ARM1020 || \
-		CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || \
-		CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_FEROCEON)
-
-config ARCH_MULTI_V4_V5
-	bool
-
-config ARCH_MULTI_V6
-	bool "ARMv6 based platforms (ARM11)"
-	select ARCH_MULTI_V6_V7
-	select CPU_V6K
-
-config ARCH_MULTI_V7
-	bool "ARMv7 based platforms (Cortex-A, PJ4, Scorpion, Krait)"
-	default y
-	select ARCH_MULTI_V6_V7
-	select CPU_V7
-	select HAVE_SMP
-
-config ARCH_MULTI_V6_V7
-	bool
-	select MIGHT_HAVE_CACHE_L2X0
-
-config ARCH_MULTI_CPU_AUTO
-	def_bool !(ARCH_MULTI_V4 || ARCH_MULTI_V4T || ARCH_MULTI_V6_V7)
-	select ARCH_MULTI_V5
-
-endmenu
-
-config ARCH_VIRT
-	bool "Dummy Virtual Machine"
-	depends on ARCH_MULTI_V7
-	select ARM_AMBA
-	select ARM_GIC
-	select ARM_GIC_V2M if PCI
-	select ARM_GIC_V3
-	select ARM_GIC_V3_ITS if PCI
-	select ARM_PSCI
-	select HAVE_ARM_ARCH_TIMER
+source "arch/arm/Kconfig.platforms"
 
 config ARCH_AIROHA
 	bool "Airoha SoC Support"
diff --git a/arch/arm/Kconfig.platforms b/arch/arm/Kconfig.platforms
new file mode 100644
index 0000000000000..ed1f6da11e243
--- /dev/null
+++ b/arch/arm/Kconfig.platforms
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+menu "Platform selection"
+	depends on MMU
+
+comment "CPU Core family selection"
+
+config ARCH_MULTI_V4
+	bool "ARMv4 based platforms (FA526, StrongARM)"
+	depends on !ARCH_MULTI_V6_V7
+	# https://github.com/llvm/llvm-project/issues/50764
+	depends on !LD_IS_LLD || LLD_VERSION >= 160000
+	select ARCH_MULTI_V4_V5
+	select CPU_FA526 if !(CPU_SA110 || CPU_SA1100)
+
+config ARCH_MULTI_V4T
+	bool "ARMv4T based platforms (ARM720T, ARM920T, ...)"
+	depends on !ARCH_MULTI_V6_V7
+	# https://github.com/llvm/llvm-project/issues/50764
+	depends on !LD_IS_LLD || LLD_VERSION >= 160000
+	select ARCH_MULTI_V4_V5
+	select CPU_ARM920T if !(CPU_ARM7TDMI || CPU_ARM720T || \
+		CPU_ARM740T || CPU_ARM9TDMI || CPU_ARM922T || \
+		CPU_ARM925T || CPU_ARM940T)
+
+config ARCH_MULTI_V5
+	bool "ARMv5 based platforms (ARM926T, XSCALE, PJ1, ...)"
+	depends on !ARCH_MULTI_V6_V7
+	select ARCH_MULTI_V4_V5
+	select CPU_ARM926T if !(CPU_ARM946E || CPU_ARM1020 || \
+		CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || \
+		CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_FEROCEON)
+
+config ARCH_MULTI_V4_V5
+	bool
+
+config ARCH_MULTI_V6
+	bool "ARMv6 based platforms (ARM11)"
+	select ARCH_MULTI_V6_V7
+	select CPU_V6K
+
+config ARCH_MULTI_V7
+	bool "ARMv7 based platforms (Cortex-A, PJ4, Scorpion, Krait)"
+	default y
+	select ARCH_MULTI_V6_V7
+	select CPU_V7
+	select HAVE_SMP
+
+config ARCH_MULTI_V6_V7
+	bool
+	select MIGHT_HAVE_CACHE_L2X0
+
+config ARCH_MULTI_CPU_AUTO
+	def_bool !(ARCH_MULTI_V4 || ARCH_MULTI_V4T || ARCH_MULTI_V6_V7)
+	select ARCH_MULTI_V5
+
+endmenu
+
+config ARCH_VIRT
+	bool "Dummy Virtual Machine"
+	depends on ARCH_MULTI_V7
+	select ARM_AMBA
+	select ARM_GIC
+	select ARM_GIC_V2M if PCI
+	select ARM_GIC_V3
+	select ARM_GIC_V3_ITS if PCI
+	select ARM_PSCI
+	select HAVE_ARM_ARCH_TIMER
-- 
2.39.2

