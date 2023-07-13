Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E94752A89
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 20:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjGMSxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 14:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjGMSxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 14:53:31 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B55A30E6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 11:53:14 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36DIquc2095228;
        Thu, 13 Jul 2023 13:52:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689274376;
        bh=jGJfMKqnnZ58gkhvxk/iaKzdfZowXJO0WnuKDVateK8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=toQDY2TJpGL7OvdUEyN1CSmVfjNMCaep/XG7cCDb12BYszN5Ygo1lCOchHvzPZgfv
         D/sTKCZeiJRODpRQGlc/qEnd8s3krV9hkSZ4Jg/01pBI4zmCXJ+2LzZT8NKiJ85HH4
         CDupTewO3Glxz0QFIqZXgXkhqL2DPrMzoM5DXfMA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36DIquoG109583
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Jul 2023 13:52:56 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jul 2023 13:52:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jul 2023 13:52:55 -0500
Received: from fllv0040.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36DIqsh8080681;
        Thu, 13 Jul 2023 13:52:55 -0500
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
Subject: [PATCH v3 3/5] ARM: mach-rda: Move RDA Micro support into Kconfig.platforms
Date:   Thu, 13 Jul 2023 13:52:50 -0500
Message-ID: <20230713185252.27797-3-afd@ti.com>
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

 arch/arm/Kconfig           | 2 --
 arch/arm/Kconfig.platforms | 8 ++++++++
 arch/arm/mach-rda/Kconfig  | 8 --------
 3 files changed, 8 insertions(+), 10 deletions(-)
 delete mode 100644 arch/arm/mach-rda/Kconfig

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 375ef11c497be..4b6fe2d1b809e 100644
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

