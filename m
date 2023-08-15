Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82BF77D1F8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 20:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239188AbjHOShg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 14:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239160AbjHOSg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 14:36:59 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4824510D8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 11:36:58 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4RQKk04wSLz9sdR;
        Tue, 15 Aug 2023 20:36:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lnEPxfjuCVQ0; Tue, 15 Aug 2023 20:36:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4RQKk03vcdz9sdQ;
        Tue, 15 Aug 2023 20:36:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 82CB38B76C;
        Tue, 15 Aug 2023 20:36:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4tgKdROCRcLb; Tue, 15 Aug 2023 20:36:56 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.233.223])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 505408B763;
        Tue, 15 Aug 2023 20:36:56 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 37FIakoU133313
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 20:36:46 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 37FIaktO133304;
        Tue, 15 Aug 2023 20:36:46 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michal Simek <monstr@monstr.eu>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] microblaze: Remove zalloc_maybe_bootmem()
Date:   Tue, 15 Aug 2023 20:36:27 +0200
Message-ID: <bfb1601cac24d7ef8e741c83f9301e4a5a87a0b5.1692124505.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692124586; l=1541; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=nY4Jl+US5Rsly3AwDkSiNto1Vzq4wFwjUuGe4NrB1vA=; b=gk3E0oWoI9aVnO//MKppzfgJwaGnHOhVGazs0KALjoKr7yko21btVks8zTdQG25f4s626/MNF CEFBupqEq+NACzzdtgqOrRNvRGeWA2PJNEurybP3m4J+OQwnw3kqSA7
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Last user of zalloc_maybe_bootmem() was removed by
commit 4308e3c9e1ea ("microblaze/PCI: Remove unused allocation & free
of PCI host bridge structure")

Remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/microblaze/include/asm/setup.h |  2 --
 arch/microblaze/mm/init.c           | 16 ----------------
 2 files changed, 18 deletions(-)

diff --git a/arch/microblaze/include/asm/setup.h b/arch/microblaze/include/asm/setup.h
index 3657f5e78a3d..bf2600f75959 100644
--- a/arch/microblaze/include/asm/setup.h
+++ b/arch/microblaze/include/asm/setup.h
@@ -25,7 +25,5 @@ void machine_shutdown(void);
 void machine_halt(void);
 void machine_power_off(void);
 
-extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
-
 # endif /* __ASSEMBLY__ */
 #endif /* _ASM_MICROBLAZE_SETUP_H */
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 353fabdfcbc5..3827dc76edd8 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -270,22 +270,6 @@ asmlinkage void __init mmu_init(void)
 	memblock_dump_all();
 }
 
-void * __ref zalloc_maybe_bootmem(size_t size, gfp_t mask)
-{
-	void *p;
-
-	if (mem_init_done) {
-		p = kzalloc(size, mask);
-	} else {
-		p = memblock_alloc(size, SMP_CACHE_BYTES);
-		if (!p)
-			panic("%s: Failed to allocate %zu bytes\n",
-			      __func__, size);
-	}
-
-	return p;
-}
-
 static const pgprot_t protection_map[16] = {
 	[VM_NONE]					= PAGE_NONE,
 	[VM_READ]					= PAGE_READONLY_X,
-- 
2.41.0

