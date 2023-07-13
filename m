Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43364752A87
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 20:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjGMSx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 14:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjGMSxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 14:53:24 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894012D78
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 11:53:12 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36DIqt1W021161;
        Thu, 13 Jul 2023 13:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689274375;
        bh=1QYQAJtttXLm98therDCtjKtg1SKgyV01mQYwZtwYbE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=snJ2Zb5rJXatsPQIhdJGbgh1EUvSOci4dkCf55kLWUnRghIwfFQfaXVcNS2xbImkJ
         PW7XDWTEc1HD97gSfZQN7TtSVsUy/j+mZHWe+BPTGe/K/kDHoXxJDNABWSDw1eiPI5
         1XSUmpK4QwmzRVacLkFEBVi1p4a9AlYrX1tMnx70=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36DIqtH1109575
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Jul 2023 13:52:55 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jul 2023 13:52:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jul 2023 13:52:55 -0500
Received: from fllv0040.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36DIqsh7080681;
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
Subject: [PATCH v3 2/5] ARM: mach-asm9260: Move ASM9260 support into Kconfig.platforms
Date:   Thu, 13 Jul 2023 13:52:49 -0500
Message-ID: <20230713185252.27797-2-afd@ti.com>
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

This removes the need for a dedicated Kconfig and mach directory.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
---

Changes from v1/v2:
 - Rebased on latest master

 arch/arm/Kconfig              | 2 --
 arch/arm/Kconfig.platforms    | 9 +++++++++
 arch/arm/mach-asm9260/Kconfig | 9 ---------
 3 files changed, 9 insertions(+), 11 deletions(-)
 delete mode 100644 arch/arm/mach-asm9260/Kconfig

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1c49cd5c308db..375ef11c497be 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -363,8 +363,6 @@ source "arch/arm/mach-alpine/Kconfig"
 
 source "arch/arm/mach-artpec/Kconfig"
 
-source "arch/arm/mach-asm9260/Kconfig"
-
 source "arch/arm/mach-aspeed/Kconfig"
 
 source "arch/arm/mach-at91/Kconfig"
diff --git a/arch/arm/Kconfig.platforms b/arch/arm/Kconfig.platforms
index ed1f6da11e243..b80a5b49d276d 100644
--- a/arch/arm/Kconfig.platforms
+++ b/arch/arm/Kconfig.platforms
@@ -66,3 +66,12 @@ config ARCH_VIRT
 	select ARM_GIC_V3_ITS if PCI
 	select ARM_PSCI
 	select HAVE_ARM_ARCH_TIMER
+
+config MACH_ASM9260
+	bool "Alphascale ASM9260"
+	depends on ARCH_MULTI_V5
+	depends on CPU_LITTLE_ENDIAN
+	select CPU_ARM926T
+	select ASM9260_TIMER
+	help
+	  Support for Alphascale ASM9260 based platform.
diff --git a/arch/arm/mach-asm9260/Kconfig b/arch/arm/mach-asm9260/Kconfig
deleted file mode 100644
index 74e0f61c74c88..0000000000000
--- a/arch/arm/mach-asm9260/Kconfig
+++ /dev/null
@@ -1,9 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-config MACH_ASM9260
-	bool "Alphascale ASM9260"
-	depends on ARCH_MULTI_V5
-	depends on CPU_LITTLE_ENDIAN
-	select CPU_ARM926T
-	select ASM9260_TIMER
-	help
-	  Support for Alphascale ASM9260 based platform.
-- 
2.39.2

