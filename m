Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28ADB78DD6D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243846AbjH3SuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245244AbjH3OzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:55:04 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646E1198
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:55:01 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:6c13:6b1b:7366:87c0])
        by xavier.telenet-ops.be with bizsmtp
        id fquz2A00S3874jb01quz9o; Wed, 30 Aug 2023 16:54:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qbMal-0023mn-F9;
        Wed, 30 Aug 2023 16:54:59 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qbMax-005Lhk-9x;
        Wed, 30 Aug 2023 16:54:59 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ARM: Kconfig: Spelling s/Cortex A-/Cortex-A/
Date:   Wed, 30 Aug 2023 16:54:58 +0200
Message-Id: <b29d870e7190aadebb18de7e40d8306c28568156.1693407232.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a misspelling of "Cortex-A9", to make it easier to find which errata
are applicable to Cortex-A9 CPU cores.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7a27550ff3c1f817..029b40f8a39e380d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -818,7 +818,7 @@ config ARM_ERRATA_764319
 	bool "ARM errata: Read to DBGPRSR and DBGOSLSR may generate Undefined instruction"
 	depends on CPU_V7
 	help
-	  This option enables the workaround for the 764319 Cortex A-9 erratum.
+	  This option enables the workaround for the 764319 Cortex-A9 erratum.
 	  CP14 read accesses to the DBGPRSR and DBGOSLSR registers generate an
 	  unexpected Undefined Instruction exception when the DBGSWENABLE
 	  external pin is set to 0, even when the CP14 accesses are performed
-- 
2.34.1

