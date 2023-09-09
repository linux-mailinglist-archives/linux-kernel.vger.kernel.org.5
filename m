Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F40799AC0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 22:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245171AbjIIUR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 16:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237086AbjIIURz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 16:17:55 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F00CE7
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 13:17:43 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id A23CD3200805;
        Sat,  9 Sep 2023 16:17:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 09 Sep 2023 16:17:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694290662; x=
        1694377062; bh=vYgeei/BDcJ6bUB2DAGppW0ND32ofla8o2DCj1NxYPE=; b=K
        u0dd0RZHMaDqMns7iRitHO88BySItmXc1V/+Vb/OkmR3KGcO1DvaRAtq3OLHETze
        naLsbxraep105inN1mW8i3aVWoN2CHwYKGEBnzeDVwtB/CY825a4Z6xplHeKufSB
        j5nFyWllPSvSBWdcnnya2PQa8PQnYYZV8XJ5rJi+x/EQ026aTvbwXVV8VdsVpeGh
        K6pNLRO3moFbl1eU9gKfEAOCfyD/8MKFiMMKp6OiMj6Z78ZchXerkP5VT2pQbY1v
        Kah1XXspL8hkSGENcggXYwqoYZTnzsPBZM5B7wK0UGfXDstVHgvLEPFUuxcvWJ4X
        I7OZP8RqM2VGeFapjE9CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1694290662; x=
        1694377062; bh=vYgeei/BDcJ6bUB2DAGppW0ND32ofla8o2DCj1NxYPE=; b=J
        6plQnuSCnXtX5IBcgF5KYZGLQQG5MhLcW0wynftAZ0np5C/3SOw1d4GtGQhHZoeA
        RUCoGTMdxPBabmUAs8z9fzJypFl0W39j4LSRzE/kj+YtSJ+y2/NJxCWOMlC+OiBh
        E06QkMy8GJfKVsumpoaI812sFBrDYMDbN7JgsvEuVRLEJ8/imdo2h3gHSfEr1mtS
        U5OdXOVeblb2nv0zlpwDBRQC818RhI7+SAipU2efh9earF6Cmks7jZbChNmnwBYD
        Vd/3hzPGOd+tI1EvQdpIoT/1VmuvUeJxT7/xF3v23ep25CoStRL7VhCvoOIJo699
        CEAt1LarUDmRPpTBESL8w==
X-ME-Sender: <xms:5tL8ZCxRHNq-vzK9N_uG8qqhbp1rBBZJvMQ9p4a7aAHLq3NtnewxUg>
    <xme:5tL8ZOQzgpOWVkKdWgPPv6_cgUihWvwV0e4kJV3IgmdiyW0KJM_agwaPSvToF64mD
    BKKgu6Gzmjz4Bhqnw>
X-ME-Received: <xmr:5tL8ZEVIn04lOL8iEg7t_6-Bpd7rcM1EVp87tIIXdWdNEfB7mEw9ZCI9xIQrxqsnwjd_Vb-hOeWYdBkUxugRx_7CmdETWSKc1f38xGy0tjLYkUNXxf_DsCaJFXJl1xiuAhsZFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehledgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:5tL8ZIgvP082q9SgyvhZDbZ69buLo0piSwbSNT3_7U8OsZV6xK8lvg>
    <xmx:5tL8ZEAxP4Bj3bU5vGdQ1eX2D8JNvBrwsjCMkx_b0-N6o3oStnzTuA>
    <xmx:5tL8ZJIUDslnDG-sxfX_w_w2fCw2f6hdrGqre1Oxj6FtmZCr892DhQ>
    <xmx:5tL8ZH9UTzbv1bS2mhrE2nMYvChZb-rj8vYZoG893ysjlGWDVmt9Dw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Sep 2023 16:17:41 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 6/7] riscv: mm: Always flush a single MM context by ASID
Date:   Sat,  9 Sep 2023 15:16:34 -0500
Message-ID: <20230909201727.10909-7-samuel@sholland.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230909201727.10909-1-samuel@sholland.org>
References: <20230909201727.10909-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if ASIDs are not supported, using the single-ASID variant of the
sfence.vma instruction preserves TLB entries for global (kernel) pages.
So it is always most efficient to use the single-ASID code path.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/riscv/include/asm/mmu_context.h |  2 -
 arch/riscv/include/asm/tlbflush.h    | 11 +++--
 arch/riscv/mm/context.c              |  3 +-
 arch/riscv/mm/tlbflush.c             | 68 ++++++----------------------
 4 files changed, 24 insertions(+), 60 deletions(-)

diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
index 7030837adc1a..b0659413a080 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -33,8 +33,6 @@ static inline int init_new_context(struct task_struct *tsk,
 	return 0;
 }
 
-DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
-
 #include <asm-generic/mmu_context.h>
 
 #endif /* _ASM_RISCV_MMU_CONTEXT_H */
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index e55831edfc19..ba27cf68b170 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -54,13 +54,18 @@ void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 #define flush_tlb_all() local_flush_tlb_all()
 #define flush_tlb_page(vma, addr) local_flush_tlb_page(addr)
 
+static inline void flush_tlb_mm(struct mm_struct *mm)
+{
+	unsigned long asid = cntx2asid(atomic_long_read(&mm->context.id));
+
+	local_flush_tlb_all_asid(asid);
+}
+
 static inline void flush_tlb_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end)
 {
-	local_flush_tlb_all();
+	flush_tlb_mm(vma->vm_mm);
 }
-
-#define flush_tlb_mm(mm) flush_tlb_all()
 #endif /* !CONFIG_SMP || !CONFIG_MMU */
 
 /* Flush a range of kernel pages */
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 3ca9b653df7d..20057085ab8a 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -18,8 +18,7 @@
 
 #ifdef CONFIG_MMU
 
-DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
-
+static DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
 static unsigned long num_asids;
 
 static atomic_long_t current_version;
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 54c3e70ccd81..56c2d40681a2 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -6,15 +6,6 @@
 #include <asm/sbi.h>
 #include <asm/mmu_context.h>
 
-static inline void local_flush_tlb_range(unsigned long start,
-		unsigned long size, unsigned long stride)
-{
-	if (size <= stride)
-		local_flush_tlb_page(start);
-	else
-		local_flush_tlb_all();
-}
-
 static inline void local_flush_tlb_range_asid(unsigned long start,
 		unsigned long size, unsigned long stride, unsigned long asid)
 {
@@ -51,62 +42,33 @@ static void __ipi_flush_tlb_range_asid(void *info)
 	local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid);
 }
 
-static void __ipi_flush_tlb_range(void *info)
-{
-	struct flush_tlb_range_data *d = info;
-
-	local_flush_tlb_range(d->start, d->size, d->stride);
-}
-
 static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 			      unsigned long size, unsigned long stride)
 {
+	unsigned long asid = cntx2asid(atomic_long_read(&mm->context.id));
 	struct flush_tlb_range_data ftd;
 	struct cpumask *cmask = mm_cpumask(mm);
 	unsigned int cpuid;
-	bool broadcast;
 
 	if (cpumask_empty(cmask))
 		return;
 
 	cpuid = get_cpu();
 	/* check if the tlbflush needs to be sent to other CPUs */
-	broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
-	if (static_branch_unlikely(&use_asid_allocator)) {
-		unsigned long asid = cntx2asid(atomic_long_read(&mm->context.id));
-
-		if (broadcast) {
-			if (riscv_use_ipi_for_rfence()) {
-				ftd.asid = asid;
-				ftd.start = start;
-				ftd.size = size;
-				ftd.stride = stride;
-				on_each_cpu_mask(cmask,
-						 __ipi_flush_tlb_range_asid,
-						 &ftd, 1);
-			} else
-				sbi_remote_sfence_vma_asid(cmask,
-							   start, size, asid);
-		} else {
-			local_flush_tlb_range_asid(start, size, stride, asid);
-		}
-	} else {
-		if (broadcast) {
-			if (riscv_use_ipi_for_rfence()) {
-				ftd.asid = 0;
-				ftd.start = start;
-				ftd.size = size;
-				ftd.stride = stride;
-				on_each_cpu_mask(cmask,
-						 __ipi_flush_tlb_range,
-						 &ftd, 1);
-			} else
-				sbi_remote_sfence_vma(cmask, start, size);
-		} else {
-			local_flush_tlb_range(start, size, stride);
-		}
-	}
-
+	if (cpumask_any_but(cmask, cpuid) < nr_cpu_ids) {
+		if (riscv_use_ipi_for_rfence()) {
+			ftd.asid = asid;
+			ftd.start = start;
+			ftd.size = size;
+			ftd.stride = stride;
+			on_each_cpu_mask(cmask,
+					 __ipi_flush_tlb_range_asid,
+					 &ftd, 1);
+		} else
+			sbi_remote_sfence_vma_asid(cmask,
+						   start, size, asid);
+	} else
+		local_flush_tlb_range_asid(start, size, stride, asid);
 	put_cpu();
 }
 
-- 
2.41.0

