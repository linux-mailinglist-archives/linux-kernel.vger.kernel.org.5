Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F227BBA84
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjJFOlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjJFOlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:41:24 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1B2CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:41:21 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5e53:403c:300c:38ca])
        by michel.telenet-ops.be with bizsmtp
        id uehJ2A0030nPCdM06ehJJG; Fri, 06 Oct 2023 16:41:18 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qom10-005X4W-1p;
        Fri, 06 Oct 2023 16:41:18 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qom10-006v2P-02;
        Fri, 06 Oct 2023 16:41:18 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/5] m68k: sun3: Fix indentation by 5 or 7 spaces
Date:   Fri,  6 Oct 2023 16:41:11 +0200
Message-Id: <167216dfe9795056b7a69415695772887aca6d80.1696602993.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696602993.git.geert@linux-m68k.org>
References: <cover.1696602993.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indentation should use TABs, not spaces.
Fix whitespace in reindented code while at it.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/include/asm/sun3_pgalloc.h | 10 ++--
 arch/m68k/include/asm/tlbflush.h     | 72 ++++++++++++++--------------
 arch/m68k/sun3/mmu_emu.c             | 40 ++++++++--------
 3 files changed, 60 insertions(+), 62 deletions(-)

diff --git a/arch/m68k/include/asm/sun3_pgalloc.h b/arch/m68k/include/asm/sun3_pgalloc.h
index ff48573db2c04c74..4a137eecb6fe44bd 100644
--- a/arch/m68k/include/asm/sun3_pgalloc.h
+++ b/arch/m68k/include/asm/sun3_pgalloc.h
@@ -41,12 +41,12 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, pgtable_t page
 
 static inline pgd_t * pgd_alloc(struct mm_struct *mm)
 {
-     pgd_t *new_pgd;
+	pgd_t *new_pgd;
 
-     new_pgd = (pgd_t *)get_zeroed_page(GFP_KERNEL);
-     memcpy(new_pgd, swapper_pg_dir, PAGE_SIZE);
-     memset(new_pgd, 0, (PAGE_OFFSET >> PGDIR_SHIFT));
-     return new_pgd;
+	new_pgd = (pgd_t *)get_zeroed_page(GFP_KERNEL);
+	memcpy(new_pgd, swapper_pg_dir, PAGE_SIZE);
+	memset(new_pgd, 0, (PAGE_OFFSET >> PGDIR_SHIFT));
+	return new_pgd;
 }
 
 #endif /* SUN3_PGALLOC_H */
diff --git a/arch/m68k/include/asm/tlbflush.h b/arch/m68k/include/asm/tlbflush.h
index 3ab329a03c76c8d8..6d42e2906887931b 100644
--- a/arch/m68k/include/asm/tlbflush.h
+++ b/arch/m68k/include/asm/tlbflush.h
@@ -112,53 +112,51 @@ extern unsigned char pmeg_ctx[SUN3_PMEGS_NUM];
    sun?) */
 static inline void flush_tlb_all(void)
 {
-       unsigned long addr;
-       unsigned char ctx, oldctx;
-
-       oldctx = sun3_get_context();
-       for(addr = 0x00000000; addr < TASK_SIZE; addr += SUN3_PMEG_SIZE) {
-	       for(ctx = 0; ctx < 8; ctx++) {
-		       sun3_put_context(ctx);
-		       sun3_put_segmap(addr, SUN3_INVALID_PMEG);
-	       }
-       }
-
-       sun3_put_context(oldctx);
-       /* erase all of the userspace pmeg maps, we've clobbered them
-	  all anyway */
-       for(addr = 0; addr < SUN3_INVALID_PMEG; addr++) {
-	       if(pmeg_alloc[addr] == 1) {
-		       pmeg_alloc[addr] = 0;
-		       pmeg_ctx[addr] = 0;
-		       pmeg_vaddr[addr] = 0;
-	       }
-       }
+	unsigned long addr;
+	unsigned char ctx, oldctx;
 
+	oldctx = sun3_get_context();
+	for (addr = 0x00000000; addr < TASK_SIZE; addr += SUN3_PMEG_SIZE) {
+		for (ctx = 0; ctx < 8; ctx++) {
+			sun3_put_context(ctx);
+			sun3_put_segmap(addr, SUN3_INVALID_PMEG);
+		}
+	}
+
+	sun3_put_context(oldctx);
+	/* erase all of the userspace pmeg maps, we've clobbered them
+	   all anyway */
+	for (addr = 0; addr < SUN3_INVALID_PMEG; addr++) {
+		if (pmeg_alloc[addr] == 1) {
+			pmeg_alloc[addr] = 0;
+			pmeg_ctx[addr] = 0;
+			pmeg_vaddr[addr] = 0;
+		}
+	}
 }
 
 /* Clear user TLB entries within the context named in mm */
 static inline void flush_tlb_mm (struct mm_struct *mm)
 {
-     unsigned char oldctx;
-     unsigned char seg;
-     unsigned long i;
-
-     oldctx = sun3_get_context();
-     sun3_put_context(mm->context);
+	unsigned char oldctx;
+	unsigned char seg;
+	unsigned long i;
 
-     for(i = 0; i < TASK_SIZE; i += SUN3_PMEG_SIZE) {
-	     seg = sun3_get_segmap(i);
-	     if(seg == SUN3_INVALID_PMEG)
-		     continue;
+	oldctx = sun3_get_context();
+	sun3_put_context(mm->context);
 
-	     sun3_put_segmap(i, SUN3_INVALID_PMEG);
-	     pmeg_alloc[seg] = 0;
-	     pmeg_ctx[seg] = 0;
-	     pmeg_vaddr[seg] = 0;
-     }
+	for (i = 0; i < TASK_SIZE; i += SUN3_PMEG_SIZE) {
+		seg = sun3_get_segmap(i);
+		if (seg == SUN3_INVALID_PMEG)
+			continue;
 
-     sun3_put_context(oldctx);
+		sun3_put_segmap(i, SUN3_INVALID_PMEG);
+		pmeg_alloc[seg] = 0;
+		pmeg_ctx[seg] = 0;
+		pmeg_vaddr[seg] = 0;
+	}
 
+	sun3_put_context(oldctx);
 }
 
 /* Flush a single TLB page. In this case, we're limited to flushing a
diff --git a/arch/m68k/sun3/mmu_emu.c b/arch/m68k/sun3/mmu_emu.c
index e5a92da43d1978df..119bd32efcfbc9d0 100644
--- a/arch/m68k/sun3/mmu_emu.c
+++ b/arch/m68k/sun3/mmu_emu.c
@@ -207,32 +207,32 @@ void __init mmu_emu_init(unsigned long bootmem_end)
    context for when they're cleared */
 void clear_context(unsigned long context)
 {
-     unsigned char oldctx;
-     unsigned long i;
+	unsigned char oldctx;
+	unsigned long i;
 
-     if(context) {
-	     if(!ctx_alloc[context])
-		     panic("%s: context not allocated\n", __func__);
+	if (context) {
+		if (!ctx_alloc[context])
+			panic("%s: context not allocated\n", __func__);
 
-	     ctx_alloc[context]->context = SUN3_INVALID_CONTEXT;
-	     ctx_alloc[context] = (struct mm_struct *)0;
-	     ctx_avail++;
-     }
+		ctx_alloc[context]->context = SUN3_INVALID_CONTEXT;
+		ctx_alloc[context] = (struct mm_struct *)0;
+		ctx_avail++;
+	}
 
-     oldctx = sun3_get_context();
+	oldctx = sun3_get_context();
 
-     sun3_put_context(context);
+	sun3_put_context(context);
 
-     for(i = 0; i < SUN3_INVALID_PMEG; i++) {
-	     if((pmeg_ctx[i] == context) && (pmeg_alloc[i] == 1)) {
-		     sun3_put_segmap(pmeg_vaddr[i], SUN3_INVALID_PMEG);
-		     pmeg_ctx[i] = 0;
-		     pmeg_alloc[i] = 0;
-		     pmeg_vaddr[i] = 0;
-	     }
-     }
+	for (i = 0; i < SUN3_INVALID_PMEG; i++) {
+		if ((pmeg_ctx[i] == context) && (pmeg_alloc[i] == 1)) {
+			sun3_put_segmap(pmeg_vaddr[i], SUN3_INVALID_PMEG);
+			pmeg_ctx[i] = 0;
+			pmeg_alloc[i] = 0;
+			pmeg_vaddr[i] = 0;
+		}
+	}
 
-     sun3_put_context(oldctx);
+	sun3_put_context(oldctx);
 }
 
 /* gets an empty context.  if full, kills the next context listed to
-- 
2.34.1

