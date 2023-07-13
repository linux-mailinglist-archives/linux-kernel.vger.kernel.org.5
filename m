Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B452D752A8A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 20:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjGMSxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 14:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjGMSxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 14:53:31 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AE530D1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 11:53:14 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36DIqubs095232;
        Thu, 13 Jul 2023 13:52:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689274376;
        bh=a8YJpepi6aBx5QhHUuFkaUxvbbDrnYOVQz/FkRHQ9+w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jMXukJ35pf472q6m+avph4pWPuKPDKlpFt94af8V7j1wTTzL2VD6mMSiCgXSS2j9n
         u5FmHeT2IVW1/1H/46H/FUUIggJQ6q2ooJMX5fUek/m4ZdR1BTfllGG1Yu85uEY5Wz
         1n+729MnfGm04w0eXnx8+hNruoo6wsJ+Wg0EyM0Q=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36DIquej050148
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Jul 2023 13:52:56 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jul 2023 13:52:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jul 2023 13:52:56 -0500
Received: from fllv0040.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36DIqsh9080681;
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
Subject: [PATCH v3 4/5] ARM: mach-uniphier: Move Socionext UniPhier support into Kconfig.platforms
Date:   Thu, 13 Jul 2023 13:52:51 -0500
Message-ID: <20230713185252.27797-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230713185252.27797-1-afd@ti.com>
References: <20230713185252.27797-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

 MAINTAINERS                    |  1 -
 arch/arm/Kconfig               |  2 --
 arch/arm/Kconfig.platforms     | 15 +++++++++++++++
 arch/arm/mach-uniphier/Kconfig | 15 ---------------
 4 files changed, 15 insertions(+), 18 deletions(-)
 delete mode 100644 arch/arm/mach-uniphier/Kconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index 3be1bdfe8ecc7..186b73fe6bc73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2906,7 +2906,6 @@ F:	Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
 F:	Documentation/devicetree/bindings/soc/socionext/socionext,uniphier*.yaml
 F:	arch/arm/boot/dts/socionext/uniphier*
 F:	arch/arm/include/asm/hardware/cache-uniphier.h
-F:	arch/arm/mach-uniphier/
 F:	arch/arm/mm/cache-uniphier.c
 F:	arch/arm64/boot/dts/socionext/uniphier*
 F:	drivers/bus/uniphier-system-bus.c
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4b6fe2d1b809e..df93b29a5da1a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -465,8 +465,6 @@ source "arch/arm/mach-sunxi/Kconfig"
 
 source "arch/arm/mach-tegra/Kconfig"
 
-source "arch/arm/mach-uniphier/Kconfig"
-
 source "arch/arm/mach-ux500/Kconfig"
 
 source "arch/arm/mach-versatile/Kconfig"
diff --git a/arch/arm/Kconfig.platforms b/arch/arm/Kconfig.platforms
index 80f5b040e6ef4..0e6d7172bf61e 100644
--- a/arch/arm/Kconfig.platforms
+++ b/arch/arm/Kconfig.platforms
@@ -83,3 +83,18 @@ config ARCH_RDA
 	select RDA_TIMER
 	help
 	  This enables support for the RDA Micro 8810PL SoC family.
+
+config ARCH_UNIPHIER
+	bool "Socionext UniPhier SoCs"
+	depends on ARCH_MULTI_V7
+	select ARCH_HAS_RESET_CONTROLLER
+	select ARM_AMBA
+	select ARM_GLOBAL_TIMER
+	select ARM_GIC
+	select HAVE_ARM_SCU
+	select HAVE_ARM_TWD if SMP
+	select PINCTRL
+	select RESET_CONTROLLER
+	help
+	  Support for UniPhier SoC family developed by Socionext Inc.
+	  (formerly, System LSI Business Division of Panasonic Corporation)
diff --git a/arch/arm/mach-uniphier/Kconfig b/arch/arm/mach-uniphier/Kconfig
deleted file mode 100644
index e661d26266751..0000000000000
--- a/arch/arm/mach-uniphier/Kconfig
+++ /dev/null
@@ -1,15 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-config ARCH_UNIPHIER
-	bool "Socionext UniPhier SoCs"
-	depends on ARCH_MULTI_V7
-	select ARCH_HAS_RESET_CONTROLLER
-	select ARM_AMBA
-	select ARM_GLOBAL_TIMER
-	select ARM_GIC
-	select HAVE_ARM_SCU
-	select HAVE_ARM_TWD if SMP
-	select PINCTRL
-	select RESET_CONTROLLER
-	help
-	  Support for UniPhier SoC family developed by Socionext Inc.
-	  (formerly, System LSI Business Division of Panasonic Corporation)
-- 
2.39.2

