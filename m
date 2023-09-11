Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D4D79BBF7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240092AbjIKU4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238928AbjIKOHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:07:48 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BD4E4D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:07:44 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BE7AxZ002267;
        Mon, 11 Sep 2023 09:07:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694441230;
        bh=w7+ia7X/+iugDgNnkB5KcxjZQImNaRaUzCZV7Hgd2RM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uo46n6TcToEW/c0gCESX7jCw8mTLjw3ROWrzP2Rs18aI9J+sWmVSOTDr7cN8KWe73
         cUTDg/014pYcIXHEha1cl6SYRRgO4O0/w/RRU3XNSwkKBC9gpbSA86cBQg8RSdGui5
         LbpYBaadSBC15XlqLYJ/eymElTDQCaxNNADqtnQQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BE79qo059468
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 09:07:10 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 09:07:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 09:07:08 -0500
Received: from fllv0039.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BE765f120291;
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
Subject: [PATCH v2 3/8] ARM: mach-rda: Move RDA Micro support into Kconfig.platforms
Date:   Mon, 11 Sep 2023 09:07:00 -0500
Message-ID: <20230911140705.59297-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230911140705.59297-1-afd@ti.com>
References: <20230911140705.59297-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 75cb085a7dae5..9b694aaaf4469 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -437,8 +437,6 @@ source "arch/arm/mach-pxa/Kconfig"
 
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

