Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F65799AC3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 22:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245227AbjIIUSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 16:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239931AbjIIUSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 16:18:04 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9ACBE73
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 13:17:45 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id DF3C4320090E;
        Sat,  9 Sep 2023 16:17:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 09 Sep 2023 16:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694290664; x=
        1694377064; bh=a7RQskjaETnUB7Hp/T92jpvvET5ms5jF4Eb+hZaDEyI=; b=J
        8U6+zD6CiKtlWqKDAskkYFhuDtgIckiPB/7lksw946WKmDxpWUgYdbbEDm0RclGl
        vDY74H5Yr4DdxccX57XaVRToiLWYDmlTbO0luKq3/cIrsBDx9pxmD+O04EwVAJXy
        Z21t93Ly8W6i0Ahhc5B5/eFQ7QBQT3UpVbqQK0MNoer5pr3h4xjtVgL60X6P4i1H
        ivUx277V8FX//1JY4wlhJ2ZwxJLn1p4QtQQP8W7r9gDllhtb0BH9vrjQ8IHf9k7B
        RZYPilLZGpkEPRe42T2nppigHi+ANLbEsRK64ycR8vSZGjBdFJ9mIfhFOWLTATBk
        aUBt2R3LPMlA1XLxVcrZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1694290664; x=
        1694377064; bh=a7RQskjaETnUB7Hp/T92jpvvET5ms5jF4Eb+hZaDEyI=; b=b
        M27lb4EWA9BmB3m23H9K7njzrwz1bmIeiC5n4OWhUv2bwrE3fqlPBd/kAKAq3I9T
        e5xwcraAUx0Gc+NwOYzt8ojKyH3/XxxiNv1oVipM8loatwq/R2656NXKOYmYKmNi
        O21F3BqBHB2BTq1h+mMfnaq1iypcjKCMUukjOpNMPVr32ts1eBC4LMBohZWu+Oj7
        XIThvzOMEr/coKW8CccbNQsAKKcGQYFdbNpx0mDpETtmLShxDxs8IRZt1mJDC6tC
        FWSYgAAhfceLtWGniOn7cqvbhIGsHYCwX7xj3I/kK4U/xdM8i/oeAhkk4N5YvzQH
        ckFKYFs9xZRm+KPQViSKw==
X-ME-Sender: <xms:6NL8ZAP-jn16aiPBShXHouXc0o5eLOeBQpe7up0vPIPUt19c1_3_Cg>
    <xme:6NL8ZG_10vruJCmqg4pXKL97lJdyKGTi3ur04iDSCjy5bJ1CFUt3DDcO-ajZoraFj
    l76N9lSInB_gTFw_Q>
X-ME-Received: <xmr:6NL8ZHSSCNCNDI19FcSWtyFkuX6aqs1cIGcCGhusFWb3K6He9BKXRWXtR6cfjJ8LcvoF0Lg74YrliipKlmIsbMotzFY55iBr7MdK3YVSWGtCYcl-of_84-j2cJ2RphzQmDtagQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehledgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:6NL8ZIv_DSdrPavGVuaB-fhnhim8VgJmDXaKwpvURvQ1ZUJ3aibLLQ>
    <xmx:6NL8ZId09I71zAQ0gDnEg_lCCQPoa6KPGuQXbwhX5__P0ZD7RqYjqg>
    <xmx:6NL8ZM2DIX5_1ekz2WkxlTCOmIpkHmMjRutizgag7fRiuJ7xZ5bqtQ>
    <xmx:6NL8ZH63BAoctxgNuQkkhWo7ZpT2xDyPwbLM9bYgm4m3ScvQi2551A>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Sep 2023 16:17:43 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 7/7] riscv: mm: Combine the SMP and non-SMP TLB flushing code
Date:   Sat,  9 Sep 2023 15:16:35 -0500
Message-ID: <20230909201727.10909-8-samuel@sholland.org>
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

This allows non-SMP configurations to take advantage of improvements
to the code in tlbflush.c, such as support for huge pages and flushing
multiple-page ranges.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/riscv/include/asm/tlbflush.h | 31 ++++++++-----------------------
 arch/riscv/mm/Makefile            |  5 +----
 arch/riscv/mm/tlbflush.c          |  7 ++++++-
 3 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index ba27cf68b170..a947ae3afd28 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -33,13 +33,12 @@ static inline void local_flush_tlb_page_asid(unsigned long addr,
 {
 	ALT_SFENCE_VMA_ADDR_ASID(addr, asid);
 }
-#else /* CONFIG_MMU */
-#define local_flush_tlb_all()			do { } while (0)
-#define local_flush_tlb_page(addr)		do { } while (0)
-#endif /* CONFIG_MMU */
 
-#if defined(CONFIG_SMP) && defined(CONFIG_MMU)
+#ifdef CONFIG_SMP
 void flush_tlb_all(void);
+#else
+#define flush_tlb_all() local_flush_tlb_all()
+#endif
 void flush_tlb_mm(struct mm_struct *mm);
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
@@ -49,24 +48,10 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end);
 #endif
-#else /* CONFIG_SMP && CONFIG_MMU */
-
-#define flush_tlb_all() local_flush_tlb_all()
-#define flush_tlb_page(vma, addr) local_flush_tlb_page(addr)
-
-static inline void flush_tlb_mm(struct mm_struct *mm)
-{
-	unsigned long asid = cntx2asid(atomic_long_read(&mm->context.id));
-
-	local_flush_tlb_all_asid(asid);
-}
-
-static inline void flush_tlb_range(struct vm_area_struct *vma,
-		unsigned long start, unsigned long end)
-{
-	flush_tlb_mm(vma->vm_mm);
-}
-#endif /* !CONFIG_SMP || !CONFIG_MMU */
+#else /* CONFIG_MMU */
+#define local_flush_tlb_all()			do { } while (0)
+#define local_flush_tlb_page(addr)		do { } while (0)
+#endif /* CONFIG_MMU */
 
 /* Flush a range of kernel pages */
 static inline void flush_tlb_kernel_range(unsigned long start,
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 9c454f90fd3d..64f901674e35 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -13,15 +13,12 @@ endif
 KCOV_INSTRUMENT_init.o := n
 
 obj-y += init.o
-obj-$(CONFIG_MMU) += extable.o fault.o pageattr.o
+obj-$(CONFIG_MMU) += extable.o fault.o pageattr.o tlbflush.o
 obj-y += cacheflush.o
 obj-y += context.o
 obj-y += pgtable.o
 obj-y += pmem.o
 
-ifeq ($(CONFIG_MMU),y)
-obj-$(CONFIG_SMP) += tlbflush.o
-endif
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
 obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
 obj-$(CONFIG_KASAN)   += kasan_init.o
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 56c2d40681a2..587b3bb084b2 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -15,6 +15,7 @@ static inline void local_flush_tlb_range_asid(unsigned long start,
 		local_flush_tlb_all_asid(asid);
 }
 
+#ifdef CONFIG_SMP
 static void __ipi_flush_tlb_all(void *info)
 {
 	local_flush_tlb_all();
@@ -41,12 +42,12 @@ static void __ipi_flush_tlb_range_asid(void *info)
 
 	local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid);
 }
+#endif
 
 static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 			      unsigned long size, unsigned long stride)
 {
 	unsigned long asid = cntx2asid(atomic_long_read(&mm->context.id));
-	struct flush_tlb_range_data ftd;
 	struct cpumask *cmask = mm_cpumask(mm);
 	unsigned int cpuid;
 
@@ -54,9 +55,12 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 		return;
 
 	cpuid = get_cpu();
+#ifdef CONFIG_SMP
 	/* check if the tlbflush needs to be sent to other CPUs */
 	if (cpumask_any_but(cmask, cpuid) < nr_cpu_ids) {
 		if (riscv_use_ipi_for_rfence()) {
+			struct flush_tlb_range_data ftd;
+
 			ftd.asid = asid;
 			ftd.start = start;
 			ftd.size = size;
@@ -68,6 +72,7 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 			sbi_remote_sfence_vma_asid(cmask,
 						   start, size, asid);
 	} else
+#endif
 		local_flush_tlb_range_asid(start, size, stride, asid);
 	put_cpu();
 }
-- 
2.41.0

