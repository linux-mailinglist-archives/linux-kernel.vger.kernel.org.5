Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B4C79BC27
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245124AbjIKVIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238925AbjIKOHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:07:48 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F89CF0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:07:41 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BE79lK043293;
        Mon, 11 Sep 2023 09:07:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694441229;
        bh=iA9yKi+APtWivtTkx66DLbgr/iF49mFhHWMtgLcKisM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FuFpR0A3pZ4ZKqxxe7TlqTnw/yzXkNVDXslR6muEgGKp9ImqGUQMNeYdMqt43SxE9
         yJVlLGGJW4svpuhy7XUlRnPgC3qwIZmwjyxHiER5ICD0p0V2KLh92oqdZuyVSdJ+aD
         0drcfJojmMMDfhpsr9YB/v0tR6jFvxuBWvdu/xWk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BE79e8059464
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 09:07:09 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 09:07:09 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 09:07:09 -0500
Received: from fllv0039.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BE765g120291;
        Mon, 11 Sep 2023 09:07:08 -0500
From:   Andrew Davis <afd@ti.com>
To:     Russell King <linux@armlinux.org.uk>,
        Baruch Siach <baruch@tkos.co.il>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2 4/8] ARM: mach-uniphier: Move Socionext UniPhier support into Kconfig.platforms
Date:   Mon, 11 Sep 2023 09:07:01 -0500
Message-ID: <20230911140705.59297-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230911140705.59297-1-afd@ti.com>
References: <20230911140705.59297-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the need for a dedicated Kconfig and empty mach directory.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 MAINTAINERS                    |  1 -
 arch/arm/Kconfig               |  2 --
 arch/arm/Kconfig.platforms     | 15 +++++++++++++++
 arch/arm/mach-uniphier/Kconfig | 15 ---------------
 4 files changed, 15 insertions(+), 18 deletions(-)
 delete mode 100644 arch/arm/mach-uniphier/Kconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index 90f13281d2970..bece2a6dff399 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2915,7 +2915,6 @@ F:	Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
 F:	Documentation/devicetree/bindings/soc/socionext/socionext,uniphier*.yaml
 F:	arch/arm/boot/dts/socionext/uniphier*
 F:	arch/arm/include/asm/hardware/cache-uniphier.h
-F:	arch/arm/mach-uniphier/
 F:	arch/arm/mm/cache-uniphier.c
 F:	arch/arm64/boot/dts/socionext/uniphier*
 F:	drivers/bus/uniphier-system-bus.c
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9b694aaaf4469..daffe585eae5f 100644
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

