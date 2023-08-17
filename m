Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32C477F68E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350880AbjHQMlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350950AbjHQMlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:41:13 -0400
Received: from pegase1.c-s.fr (unknown [90.115.179.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146BD2D57
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 05:41:11 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RRPkZ5mf0zB0Dj;
        Thu, 17 Aug 2023 14:41:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BrqFF1onq0FT; Thu, 17 Aug 2023 14:41:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RRPkZ545czB0Dh;
        Thu, 17 Aug 2023 14:41:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AAB078B76C;
        Thu, 17 Aug 2023 14:41:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Eq6yuMxd45fu; Thu, 17 Aug 2023 14:41:10 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.19.54.59])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6D9318B763;
        Thu, 17 Aug 2023 14:41:10 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 37HCf5ex341833
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 14:41:06 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 37HCewk9341785;
        Thu, 17 Aug 2023 14:40:58 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] powerpc/4xx: Remove WatchdogHandler() to fix no previous prototype error
Date:   Thu, 17 Aug 2023 14:40:49 +0200
Message-ID: <38fe1078eb403eef74dc8f29387636fd7ecdf43c.1692276041.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692276048; l=1640; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=5kK2Dl0k8Xw2FyK341U1RAupnW9TvgkTjcKiODL2xsI=; b=by8p5DxFQyHNeEjouMXOq7FuvXamAsmx5k0MG2yPYGtIgBauSwMPvAc9B+lzGHw0/DGy79EST oFbDiJcZew4A9E2rb6DnJiKLbMSzHBV4AMWKcHQh2zw7wKK/cN7hma7
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_FAIL,SPF_HELO_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building ppc40x_defconfig throws the following error:

  CC      arch/powerpc/kernel/traps.o
arch/powerpc/kernel/traps.c:2232:29: warning: no previous prototype for 'WatchdogHandler' [-Wmissing-prototypes]
 2232 | void __attribute__ ((weak)) WatchdogHandler(struct pt_regs *regs)
      |                             ^~~~~~~~~~~~~~~

This function was imported by commit 14cf11af6cf6 ("powerpc: Merge
enough to start building in arch/powerpc.") as a weak function but
never defined and/or called outside traps.c

As it has only one caller fold it inside its caller and remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/traps.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index f5ce282dc4b8..eeff136b83d9 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -2225,21 +2225,10 @@ void __noreturn unrecoverable_exception(struct pt_regs *regs)
 }
 
 #if defined(CONFIG_BOOKE_WDT) || defined(CONFIG_40x)
-/*
- * Default handler for a Watchdog exception,
- * spins until a reboot occurs
- */
-void __attribute__ ((weak)) WatchdogHandler(struct pt_regs *regs)
-{
-	/* Generic WatchdogHandler, implement your own */
-	mtspr(SPRN_TCR, mfspr(SPRN_TCR)&(~TCR_WIE));
-	return;
-}
-
 DEFINE_INTERRUPT_HANDLER_NMI(WatchdogException)
 {
 	printk (KERN_EMERG "PowerPC Book-E Watchdog Exception\n");
-	WatchdogHandler(regs);
+	mtspr(SPRN_TCR, mfspr(SPRN_TCR) & ~TCR_WIE);
 	return 0;
 }
 #endif
-- 
2.41.0

