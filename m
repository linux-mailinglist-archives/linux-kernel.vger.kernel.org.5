Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6884F7E9F04
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjKMOow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjKMOon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:44:43 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A0C1711
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:44:39 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ADEi3h8019397;
        Mon, 13 Nov 2023 08:44:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699886643;
        bh=W2gD0fxTZBz0SdP6+dLyeXNWTwo/KNUYEabAiDwun08=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fb64ZCHOPkA4HVr/7Q37geyN+6be4mGPOkjs4sprh0IcRTkhVjFekuXbYhvfA1vVB
         SwSvHTnraBgvz2jXADD7UIMknfeQeB/XjNoCHDLzmJXxFcHDGRKfbgIOuLJQZj9y3s
         Wliz5z2kuqhnwaGbY3wFWCIVA0H5XwF/Z+13fjJU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ADEi3ol020150
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Nov 2023 08:44:03 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Nov 2023 08:44:03 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Nov 2023 08:44:03 -0600
Received: from fllv0040.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ADEi0tv065232;
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
Subject: [PATCH v3 3/9] ARM: mach-rda: Move RDA Micro support into Kconfig.platforms
Date:   Mon, 13 Nov 2023 08:43:53 -0600
Message-ID: <20231113144359.174140-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231113144359.174140-1-afd@ti.com>
References: <20231113144359.174140-1-afd@ti.com>
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
 arch/arm/Kconfig           | 2 --
 arch/arm/Kconfig.platforms | 8 ++++++++
 arch/arm/mach-rda/Kconfig  | 8 --------
 3 files changed, 8 insertions(+), 10 deletions(-)
 delete mode 100644 arch/arm/mach-rda/Kconfig

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b31489f05ba86..e1aeaf25d7aab 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -438,8 +438,6 @@ source "arch/arm/mach-pxa/Kconfig"
 
 source "arch/arm/mach-qcom/Kconfig"
 
-source "arch/arm/mach-rda/Kconfig"
-
 source "arch/arm/mach-realtek/Kconfig"
 
 source "arch/arm/mach-rpc/Kconfig"
diff --git a/arch/arm/Kconfig.platforms b/arch/arm/Kconfig.platforms
index b80a5b49d276d..80f5b040e6ef4 100644
--- a/arch/arm/Kconfig.platforms
+++ b/arch/arm/Kconfig.platforms
@@ -75,3 +75,11 @@ config MACH_ASM9260
 	select ASM9260_TIMER
 	help
 	  Support for Alphascale ASM9260 based platform.
+
+config ARCH_RDA
+	bool "RDA Micro SoCs"
+	depends on ARCH_MULTI_V7
+	select RDA_INTC
+	select RDA_TIMER
+	help
+	  This enables support for the RDA Micro 8810PL SoC family.
diff --git a/arch/arm/mach-rda/Kconfig b/arch/arm/mach-rda/Kconfig
deleted file mode 100644
index 4d2e4e046cb35..0000000000000
--- a/arch/arm/mach-rda/Kconfig
+++ /dev/null
@@ -1,8 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-menuconfig ARCH_RDA
-	bool "RDA Micro SoCs"
-	depends on ARCH_MULTI_V7
-	select RDA_INTC
-	select RDA_TIMER
-	help
-	  This enables support for the RDA Micro 8810PL SoC family.
-- 
2.39.2

