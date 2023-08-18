Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF024780601
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 08:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358078AbjHRGwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 02:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbjHRGwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 02:52:14 -0400
Received: from pegase1.c-s.fr (unknown [90.115.179.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0DFE6B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 23:52:08 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RRsxL46p5z9wtt;
        Fri, 18 Aug 2023 08:52:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LiPPU3P2aRpV; Fri, 18 Aug 2023 08:52:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RRsxL3V5Fz9wtQ;
        Fri, 18 Aug 2023 08:52:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 742028B76C;
        Fri, 18 Aug 2023 08:52:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 1P4BEjFwJOeQ; Fri, 18 Aug 2023 08:52:06 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (PO17626.IDSI0.si.c-s.fr [172.19.54.29])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2CEB18B763;
        Fri, 18 Aug 2023 08:52:06 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 37I6q2Em021734
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 08:52:02 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 37I6ptDc021716;
        Fri, 18 Aug 2023 08:51:55 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/512x: Make mpc512x_select_reset_compat() static
Date:   Fri, 18 Aug 2023 08:51:48 +0200
Message-ID: <36a19e13025dbf17e92e832dd24150642b0e9bad.1692341499.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692341507; l=2561; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=69gjT6dGiiA87yrcdfW2QUGSmZ7Vx8PquMwccpsJf3w=; b=3OxJFkXpXWamil9nkMCXX3NaGZf7chUYKaCAsC8/6F7LhH/3CP5+7yQ30QX7TQ+M5TN22V76m 1T/2n44SmIwCe4quiTcnmbJ70AT6qci89CzQQyx2C9N+Kmnh9Bn+Ukt
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_FAIL,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mpc512x_select_reset_compat() is only used in the file it
is defined.

Make it static.

Move mpc512x_restart_init() after mpc512x_select_reset_compat().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Move mpc512x_restart_init() after mpc512x_select_reset_compat().
---
 arch/powerpc/platforms/512x/mpc512x.h        |  1 -
 arch/powerpc/platforms/512x/mpc512x_shared.c | 30 ++++++++++----------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platforms/512x/mpc512x.h
index 2f3c60e373e1..d2cb06e3a436 100644
--- a/arch/powerpc/platforms/512x/mpc512x.h
+++ b/arch/powerpc/platforms/512x/mpc512x.h
@@ -13,7 +13,6 @@ extern void __init mpc512x_init(void);
 extern void __init mpc512x_setup_arch(void);
 extern int __init mpc5121_clk_init(void);
 const char *__init mpc512x_select_psc_compat(void);
-const char *__init mpc512x_select_reset_compat(void);
 extern void __noreturn mpc512x_restart(char *cmd);
 
 #endif				/* __MPC512X_H__ */
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index 5ac0ead2540f..8f75e9574c27 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -29,20 +29,6 @@
 
 static struct mpc512x_reset_module __iomem *reset_module_base;
 
-static void __init mpc512x_restart_init(void)
-{
-	struct device_node *np;
-	const char *reset_compat;
-
-	reset_compat = mpc512x_select_reset_compat();
-	np = of_find_compatible_node(NULL, NULL, reset_compat);
-	if (!np)
-		return;
-
-	reset_module_base = of_iomap(np, 0);
-	of_node_put(np);
-}
-
 void __noreturn mpc512x_restart(char *cmd)
 {
 	if (reset_module_base) {
@@ -363,7 +349,7 @@ const char *__init mpc512x_select_psc_compat(void)
 	return NULL;
 }
 
-const char *__init mpc512x_select_reset_compat(void)
+static const char *__init mpc512x_select_reset_compat(void)
 {
 	if (of_machine_is_compatible("fsl,mpc5121"))
 		return "fsl,mpc5121-reset";
@@ -455,6 +441,20 @@ static void __init mpc512x_psc_fifo_init(void)
 	}
 }
 
+static void __init mpc512x_restart_init(void)
+{
+	struct device_node *np;
+	const char *reset_compat;
+
+	reset_compat = mpc512x_select_reset_compat();
+	np = of_find_compatible_node(NULL, NULL, reset_compat);
+	if (!np)
+		return;
+
+	reset_module_base = of_iomap(np, 0);
+	of_node_put(np);
+}
+
 void __init mpc512x_init_early(void)
 {
 	mpc512x_restart_init();
-- 
2.41.0

