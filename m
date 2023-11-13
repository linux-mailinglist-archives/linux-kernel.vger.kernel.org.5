Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4DE7E9F02
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjKMOoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjKMOon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:44:43 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5431724
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:44:40 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ADEi2fP129619;
        Mon, 13 Nov 2023 08:44:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699886642;
        bh=VIPf4+jBI0NfFKoZRIv6YI/78X0LhixEVLWaz3GvouQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OLeTOSs2S4TM92QxtrX8RpCGYJ9Dgj433Nvs4OvzsBu2C0qTDcIyCYy3IG3xy2l6S
         o0qm93pRGpy+Th5ZMsaq/2DVmCWT8YEfmL0bgpuOHb+cBv4VPjZxujtSzXTb+0DOpH
         mjjRyP+PmZJe3tn0TFq8Dm8zWR5dVxeyB/6khpeU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ADEi2wr094048
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Nov 2023 08:44:02 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Nov 2023 08:44:02 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Nov 2023 08:44:02 -0600
Received: from fllv0040.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ADEi0tu065232;
        Mon, 13 Nov 2023 08:44:02 -0600
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
Subject: [PATCH v3 2/9] ARM: mach-asm9260: Move ASM9260 support into Kconfig.platforms
Date:   Mon, 13 Nov 2023 08:43:52 -0600
Message-ID: <20231113144359.174140-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231113144359.174140-1-afd@ti.com>
References: <20231113144359.174140-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the need for a dedicated Kconfig and mach directory.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/Kconfig              | 2 --
 arch/arm/Kconfig.platforms    | 9 +++++++++
 arch/arm/mach-asm9260/Kconfig | 9 ---------
 3 files changed, 9 insertions(+), 11 deletions(-)
 delete mode 100644 arch/arm/mach-asm9260/Kconfig

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c39e3db466897..b31489f05ba86 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -364,8 +364,6 @@ source "arch/arm/mach-alpine/Kconfig"
 
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

