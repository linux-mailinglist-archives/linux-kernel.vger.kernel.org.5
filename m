Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB8477F805
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351588AbjHQNpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351598AbjHQNoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:44:55 -0400
Received: from pegase1.c-s.fr (unknown [90.115.179.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAB52710
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:44:47 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RRR7x5bZRzB0Sh;
        Thu, 17 Aug 2023 15:44:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FousFlCk6thr; Thu, 17 Aug 2023 15:44:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RRR7x4yfgzB0Sg;
        Thu, 17 Aug 2023 15:44:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A6B2A8B76C;
        Thu, 17 Aug 2023 15:44:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5gO1jEp3d6SR; Thu, 17 Aug 2023 15:44:45 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.19.54.59])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5A0208B763;
        Thu, 17 Aug 2023 15:44:45 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 37HDibVq433875
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 15:44:37 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 37HDiYBe433828;
        Thu, 17 Aug 2023 15:44:34 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] powerpc/4xx: Remove pika_dtm_[un]register_shutdown() to fix no previous prototype
Date:   Thu, 17 Aug 2023 15:44:26 +0200
Message-ID: <830923f0e0375a14609204246d302c7476a8f948.1692279855.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692279865; l=3351; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=Sbyk6OxfIJ6WJXDgRx9nz8WultA2O/aRcm7QwUEwtak=; b=AnI1p6Zia0OY67ubHT1k6Hs9VRBTsgbCT6Z1jctBs/hWRBywlgggbXxivSa3Ma2NRElgHXEOS Nm8/Ew30YKEAfTsThHJKP+az1JBdpHihIVsa1w6Py1rLfnyaQMaruqv
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,T_SPF_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ppc4xx_defconfig with W=1 results in:

  CC      arch/powerpc/platforms/44x/warp.o
arch/powerpc/platforms/44x/warp.c:369:5: error: no previous prototype for 'pika_dtm_register_shutdown' [-Werror=missing-prototypes]
  369 | int pika_dtm_register_shutdown(void (*func)(void *arg), void *arg)
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
arch/powerpc/platforms/44x/warp.c:374:5: error: no previous prototype for 'pika_dtm_unregister_shutdown' [-Werror=missing-prototypes]
  374 | int pika_dtm_unregister_shutdown(void (*func)(void *arg), void *arg)
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

The functions were added by commit 4ebef31fa6e0 ("[POWERPC] PIKA Warp:
Update platform code to support Rev B boards")

Those functions are not used localy and allthough their symbols are
exported they are not declared in any header file so they can't be used.

Remove them, then remove the associated list as it will now remain empty
hence becomes useless.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/44x/warp.c | 55 -------------------------------
 1 file changed, 55 deletions(-)

diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
index bfeb9bdc3258..bf0188dcb918 100644
--- a/arch/powerpc/platforms/44x/warp.c
+++ b/arch/powerpc/platforms/44x/warp.c
@@ -83,45 +83,8 @@ static int __init warp_post_info(void)
 
 #ifdef CONFIG_SENSORS_AD7414
 
-static LIST_HEAD(dtm_shutdown_list);
 static void __iomem *dtm_fpga;
 
-struct dtm_shutdown {
-	struct list_head list;
-	void (*func)(void *arg);
-	void *arg;
-};
-
-int pika_dtm_register_shutdown(void (*func)(void *arg), void *arg)
-{
-	struct dtm_shutdown *shutdown;
-
-	shutdown = kmalloc(sizeof(struct dtm_shutdown), GFP_KERNEL);
-	if (shutdown == NULL)
-		return -ENOMEM;
-
-	shutdown->func = func;
-	shutdown->arg = arg;
-
-	list_add(&shutdown->list, &dtm_shutdown_list);
-
-	return 0;
-}
-
-int pika_dtm_unregister_shutdown(void (*func)(void *arg), void *arg)
-{
-	struct dtm_shutdown *shutdown;
-
-	list_for_each_entry(shutdown, &dtm_shutdown_list, list)
-		if (shutdown->func == func && shutdown->arg == arg) {
-			list_del(&shutdown->list);
-			kfree(shutdown);
-			return 0;
-		}
-
-	return -EINVAL;
-}
-
 #define WARP_GREEN_LED	0
 #define WARP_RED_LED	1
 
@@ -153,17 +116,12 @@ static struct platform_device warp_gpio_leds = {
 
 static irqreturn_t temp_isr(int irq, void *context)
 {
-	struct dtm_shutdown *shutdown;
 	int value = 1;
 
 	local_irq_disable();
 
 	gpiod_set_value(warp_gpio_led_pins[WARP_GREEN_LED].gpiod, 0);
 
-	/* Run through the shutdown list. */
-	list_for_each_entry(shutdown, &dtm_shutdown_list, list)
-		shutdown->func(shutdown->arg);
-
 	printk(KERN_EMERG "\n\nCritical Temperature Shutdown\n\n");
 
 	while (1) {
@@ -366,19 +324,6 @@ machine_late_initcall(warp, pika_dtm_start);
 
 #else /* !CONFIG_SENSORS_AD7414 */
 
-int pika_dtm_register_shutdown(void (*func)(void *arg), void *arg)
-{
-	return 0;
-}
-
-int pika_dtm_unregister_shutdown(void (*func)(void *arg), void *arg)
-{
-	return 0;
-}
-
 machine_late_initcall(warp, warp_post_info);
 
 #endif
-
-EXPORT_SYMBOL(pika_dtm_register_shutdown);
-EXPORT_SYMBOL(pika_dtm_unregister_shutdown);
-- 
2.41.0

