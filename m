Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA8277F1C7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348709AbjHQIFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348711AbjHQIFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:05:33 -0400
Received: from pegase1.c-s.fr (unknown [90.115.179.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223412D57
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:05:30 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RRHcS51t9z9xQq;
        Thu, 17 Aug 2023 10:05:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id G-cH3T4T3rv1; Thu, 17 Aug 2023 10:05:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RRHcS4Kvqz9xQc;
        Thu, 17 Aug 2023 10:05:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 914F78B76C;
        Thu, 17 Aug 2023 10:05:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id C2PnzQQknLiB; Thu, 17 Aug 2023 10:05:28 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.19.54.59])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 550188B763;
        Thu, 17 Aug 2023 10:05:28 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 37H85GZ9271335
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 10:05:16 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 37H85EMc271331;
        Thu, 17 Aug 2023 10:05:14 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/82xx: Remove pq2_init_pci
Date:   Thu, 17 Aug 2023 10:05:08 +0200
Message-ID: <8b2db7c3c2c346aa8aa49507415c360d441e5bf5.1692259498.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692259507; l=1700; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=AaDr0jv+loyQtjp3CyPPkfHPU8hfHOxpOGbN1tdeesA=; b=GXlWDzPtl0zFrvrowKm15dEmwc3CdcVJmf3bV2ZxJM+Q5M65/rCvU5+6dGT8IBbVjXUKCwZ97 HMzbxPIrW0bALRNjCH6HCDewXqEN42poylis7ImWqTmKFfBAzHxuWvk
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

Commit 859b21a008eb ("powerpc: drop PowerQUICC II Family ADS platform
support") removed last user of pq2_init_pci.

Remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/82xx/pq2.c | 46 -------------------------------
 1 file changed, 46 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/pq2.c b/arch/powerpc/platforms/82xx/pq2.c
index 3b5cb39a564c..391d72a2e09d 100644
--- a/arch/powerpc/platforms/82xx/pq2.c
+++ b/arch/powerpc/platforms/82xx/pq2.c
@@ -32,49 +32,3 @@ void __noreturn pq2_restart(char *cmd)
 	panic("Restart failed\n");
 }
 NOKPROBE_SYMBOL(pq2_restart)
-
-#ifdef CONFIG_PCI
-static int pq2_pci_exclude_device(struct pci_controller *hose,
-                                  u_char bus, u8 devfn)
-{
-	if (bus == 0 && PCI_SLOT(devfn) == 0)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	else
-		return PCIBIOS_SUCCESSFUL;
-}
-
-static void __init pq2_pci_add_bridge(struct device_node *np)
-{
-	struct pci_controller *hose;
-	struct resource r;
-
-	if (of_address_to_resource(np, 0, &r) || r.end - r.start < 0x10b)
-		goto err;
-
-	pci_add_flags(PCI_REASSIGN_ALL_BUS);
-
-	hose = pcibios_alloc_controller(np);
-	if (!hose)
-		return;
-
-	hose->dn = np;
-
-	setup_indirect_pci(hose, r.start + 0x100, r.start + 0x104, 0);
-	pci_process_bridge_OF_ranges(hose, np, 1);
-
-	return;
-
-err:
-	printk(KERN_ERR "No valid PCI reg property in device tree\n");
-}
-
-void __init pq2_init_pci(void)
-{
-	struct device_node *np;
-
-	ppc_md.pci_exclude_device = pq2_pci_exclude_device;
-
-	for_each_compatible_node(np, NULL, "fsl,pq2-pci")
-		pq2_pci_add_bridge(np);
-}
-#endif
-- 
2.41.0

