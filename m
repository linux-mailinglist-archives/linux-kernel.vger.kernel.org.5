Return-Path: <linux-kernel+bounces-69154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9368185852E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ABDD28249F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA25137C2A;
	Fri, 16 Feb 2024 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fu5FK1Ck"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBE91353E4;
	Fri, 16 Feb 2024 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708108080; cv=none; b=TMCEsLxnpWf7GUIDp/zGEKThKLtQYQygT03TI4qlYHyTTSF3wUgDPy+2rGvPHWapyiMAJiXK6VD72fnRDWSpgNRrfOzMrZb/48gCq9pp8izMmM+aCgLONLMqjTWjU2IFOqDuhCWTcGKTWxKyb4lN65q9C+061b9Tur/xs1ETNlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708108080; c=relaxed/simple;
	bh=BRIBjoB+Per5zjwurWE+Ubdwoj4Ua04+TTDqYVsl930=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RL2QnQoe2W/hDYhN3i6OSTAv3vxmzl4F58zunPFy5Yz31GKdLtkF78pQQV5oe8T47a+TYESZypwpLD7TYiHr6CIZ8ijLmMoUPK4vJ6lBBxJ8PUZWsc7mIyPvVWkyEWZr06HfYI4RPkpQ5KmoBvRdNE0SIEvwnW6g59P456ZP6Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fu5FK1Ck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AA9C43390;
	Fri, 16 Feb 2024 18:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708108080;
	bh=BRIBjoB+Per5zjwurWE+Ubdwoj4Ua04+TTDqYVsl930=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fu5FK1Ck5yQj1r5OjzV2tkEij3Hbpv5ohZrgwekPr474HOrFCh9Pxs78uTROz7BPS
	 19XKkKWaWYNPTAh2j3Xhoj2xqQYcW0ZaHv6OHn28j2Yf+M8r9Ys6wWOWfv3I2mTwm0
	 X2n+nTvJQaNWiQuS94mFYZylZrHtzszq2dnA7dMk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.7.5
Date: Fri, 16 Feb 2024 19:27:49 +0100
Message-ID: <2024021649-spiral-uncharted-03b9@gregkh>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <2024021648-sprout-fanning-0ab4@gregkh>
References: <2024021648-sprout-fanning-0ab4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 73a208d9d4c4..0f5bb9ddc98f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 7
-SUBLEVEL = 4
+SUBLEVEL = 5
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/arch/arc/include/asm/cacheflush.h b/arch/arc/include/asm/cacheflush.h
index 563af3e75f01..329c94cd45d8 100644
--- a/arch/arc/include/asm/cacheflush.h
+++ b/arch/arc/include/asm/cacheflush.h
@@ -40,6 +40,7 @@ void dma_cache_wback(phys_addr_t start, unsigned long sz);
 
 /* TBD: optimize this */
 #define flush_cache_vmap(start, end)		flush_cache_all()
+#define flush_cache_vmap_early(start, end)	do { } while (0)
 #define flush_cache_vunmap(start, end)		flush_cache_all()
 
 #define flush_cache_dup_mm(mm)			/* called on fork (VIVT only) */
diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index f6181f69577f..1075534b0a2e 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -340,6 +340,8 @@ static inline void flush_cache_vmap(unsigned long start, unsigned long end)
 		dsb(ishst);
 }
 
+#define flush_cache_vmap_early(start, end)	do { } while (0)
+
 static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
 {
 	if (!cache_is_vipt_nonaliasing())
diff --git a/arch/csky/abiv1/inc/abi/cacheflush.h b/arch/csky/abiv1/inc/abi/cacheflush.h
index 908d8b0bc4fd..d011a81575d2 100644
--- a/arch/csky/abiv1/inc/abi/cacheflush.h
+++ b/arch/csky/abiv1/inc/abi/cacheflush.h
@@ -43,6 +43,7 @@ static inline void flush_anon_page(struct vm_area_struct *vma,
  */
 extern void flush_cache_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 #define flush_cache_vmap(start, end)		cache_wbinv_all()
+#define flush_cache_vmap_early(start, end)	do { } while (0)
 #define flush_cache_vunmap(start, end)		cache_wbinv_all()
 
 #define flush_icache_range(start, end)		cache_wbinv_range(start, end)
diff --git a/arch/csky/abiv2/inc/abi/cacheflush.h b/arch/csky/abiv2/inc/abi/cacheflush.h
index 40be16907267..6513ac5d2578 100644
--- a/arch/csky/abiv2/inc/abi/cacheflush.h
+++ b/arch/csky/abiv2/inc/abi/cacheflush.h
@@ -41,6 +41,7 @@ void flush_icache_mm_range(struct mm_struct *mm,
 void flush_icache_deferred(struct mm_struct *mm);
 
 #define flush_cache_vmap(start, end)		do { } while (0)
+#define flush_cache_vmap_early(start, end)	do { } while (0)
 #define flush_cache_vunmap(start, end)		do { } while (0)
 
 #define copy_to_user_page(vma, page, vaddr, dst, src, len) \
diff --git a/arch/m68k/include/asm/cacheflush_mm.h b/arch/m68k/include/asm/cacheflush_mm.h
index ed12358c4783..9a71b0148461 100644
--- a/arch/m68k/include/asm/cacheflush_mm.h
+++ b/arch/m68k/include/asm/cacheflush_mm.h
@@ -191,6 +191,7 @@ extern void cache_push_v(unsigned long vaddr, int len);
 #define flush_cache_all() __flush_cache_all()
 
 #define flush_cache_vmap(start, end)		flush_cache_all()
+#define flush_cache_vmap_early(start, end)	do { } while (0)
 #define flush_cache_vunmap(start, end)		flush_cache_all()
 
 static inline void flush_cache_mm(struct mm_struct *mm)
diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
index f36c2519ed97..1f14132b3fc9 100644
--- a/arch/mips/include/asm/cacheflush.h
+++ b/arch/mips/include/asm/cacheflush.h
@@ -97,6 +97,8 @@ static inline void flush_cache_vmap(unsigned long start, unsigned long end)
 		__flush_cache_vmap();
 }
 
+#define flush_cache_vmap_early(start, end)     do { } while (0)
+
 extern void (*__flush_cache_vunmap)(void);
 
 static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
diff --git a/arch/nios2/include/asm/cacheflush.h b/arch/nios2/include/asm/cacheflush.h
index 348cea097792..81484a776b33 100644
--- a/arch/nios2/include/asm/cacheflush.h
+++ b/arch/nios2/include/asm/cacheflush.h
@@ -38,6 +38,7 @@ void flush_icache_pages(struct vm_area_struct *vma, struct page *page,
 #define flush_icache_pages flush_icache_pages
 
 #define flush_cache_vmap(start, end)		flush_dcache_range(start, end)
+#define flush_cache_vmap_early(start, end)	do { } while (0)
 #define flush_cache_vunmap(start, end)		flush_dcache_range(start, end)
 
 extern void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
diff --git a/arch/parisc/include/asm/cacheflush.h b/arch/parisc/include/asm/cacheflush.h
index b4006f2a9705..ba4c05bc24d6 100644
--- a/arch/parisc/include/asm/cacheflush.h
+++ b/arch/parisc/include/asm/cacheflush.h
@@ -41,6 +41,7 @@ void flush_kernel_vmap_range(void *vaddr, int size);
 void invalidate_kernel_vmap_range(void *vaddr, int size);
 
 #define flush_cache_vmap(start, end)		flush_cache_all()
+#define flush_cache_vmap_early(start, end)	do { } while (0)
 #define flush_cache_vunmap(start, end)		flush_cache_all()
 
 void flush_dcache_folio(struct folio *folio);
diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
index 3cb53c4df27c..a129dac4521d 100644
--- a/arch/riscv/include/asm/cacheflush.h
+++ b/arch/riscv/include/asm/cacheflush.h
@@ -37,7 +37,8 @@ static inline void flush_dcache_page(struct page *page)
 	flush_icache_mm(vma->vm_mm, 0)
 
 #ifdef CONFIG_64BIT
-#define flush_cache_vmap(start, end)	flush_tlb_kernel_range(start, end)
+#define flush_cache_vmap(start, end)		flush_tlb_kernel_range(start, end)
+#define flush_cache_vmap_early(start, end)	local_flush_tlb_kernel_range(start, end)
 #endif
 
 #ifndef CONFIG_SMP
diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
index 4c5b0e929890..20f9c3ba2341 100644
--- a/arch/riscv/include/asm/hugetlb.h
+++ b/arch/riscv/include/asm/hugetlb.h
@@ -11,6 +11,9 @@ static inline void arch_clear_hugepage_flags(struct page *page)
 }
 #define arch_clear_hugepage_flags arch_clear_hugepage_flags
 
+bool arch_hugetlb_migration_supported(struct hstate *h);
+#define arch_hugetlb_migration_supported arch_hugetlb_migration_supported
+
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
 #define __HAVE_ARCH_HUGE_PTE_CLEAR
 void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
diff --git a/arch/riscv/include/asm/stacktrace.h b/arch/riscv/include/asm/stacktrace.h
index f7e8ef2418b9..b1495a7e06ce 100644
--- a/arch/riscv/include/asm/stacktrace.h
+++ b/arch/riscv/include/asm/stacktrace.h
@@ -21,4 +21,9 @@ static inline bool on_thread_stack(void)
 	return !(((unsigned long)(current->stack) ^ current_stack_pointer) & ~(THREAD_SIZE - 1));
 }
 
+
+#ifdef CONFIG_VMAP_STACK
+DECLARE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack);
+#endif /* CONFIG_VMAP_STACK */
+
 #endif /* _ASM_RISCV_STACKTRACE_H */
diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
index 1eb5682b2af6..50b63b5c15bd 100644
--- a/arch/riscv/include/asm/tlb.h
+++ b/arch/riscv/include/asm/tlb.h
@@ -16,7 +16,7 @@ static void tlb_flush(struct mmu_gather *tlb);
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
 #ifdef CONFIG_MMU
-	if (tlb->fullmm || tlb->need_flush_all)
+	if (tlb->fullmm || tlb->need_flush_all || tlb->freed_tables)
 		flush_tlb_mm(tlb->mm);
 	else
 		flush_tlb_mm_range(tlb->mm, tlb->start, tlb->end,
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 8f3418c5f172..51664ae4852e 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -41,6 +41,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end);
 void flush_tlb_kernel_range(unsigned long start, unsigned long end);
+void local_flush_tlb_kernel_range(unsigned long start, unsigned long end);
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
@@ -66,6 +67,7 @@ static inline void flush_tlb_kernel_range(unsigned long start,
 
 #define flush_tlb_mm(mm) flush_tlb_all()
 #define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
+#define local_flush_tlb_kernel_range(start, end) flush_tlb_all()
 #endif /* !CONFIG_SMP || !CONFIG_MMU */
 
 #endif /* _ASM_RISCV_TLBFLUSH_H */
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index b52f0210481f..e7b69281875b 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -125,6 +125,26 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 	return pte;
 }
 
+unsigned long hugetlb_mask_last_page(struct hstate *h)
+{
+	unsigned long hp_size = huge_page_size(h);
+
+	switch (hp_size) {
+#ifndef __PAGETABLE_PMD_FOLDED
+	case PUD_SIZE:
+		return P4D_SIZE - PUD_SIZE;
+#endif
+	case PMD_SIZE:
+		return PUD_SIZE - PMD_SIZE;
+	case napot_cont_size(NAPOT_CONT64KB_ORDER):
+		return PMD_SIZE - napot_cont_size(NAPOT_CONT64KB_ORDER);
+	default:
+		break;
+	}
+
+	return 0UL;
+}
+
 static pte_t get_clear_contig(struct mm_struct *mm,
 			      unsigned long addr,
 			      pte_t *ptep,
@@ -177,13 +197,36 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 	return entry;
 }
 
+static void clear_flush(struct mm_struct *mm,
+			unsigned long addr,
+			pte_t *ptep,
+			unsigned long pgsize,
+			unsigned long ncontig)
+{
+	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
+	unsigned long i, saddr = addr;
+
+	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
+		ptep_get_and_clear(mm, addr, ptep);
+
+	flush_tlb_range(&vma, saddr, addr);
+}
+
+/*
+ * When dealing with NAPOT mappings, the privileged specification indicates that
+ * "if an update needs to be made, the OS generally should first mark all of the
+ * PTEs invalid, then issue SFENCE.VMA instruction(s) covering all 4 KiB regions
+ * within the range, [...] then update the PTE(s), as described in Section
+ * 4.2.1.". That's the equivalent of the Break-Before-Make approach used by
+ * arm64.
+ */
 void set_huge_pte_at(struct mm_struct *mm,
 		     unsigned long addr,
 		     pte_t *ptep,
 		     pte_t pte,
 		     unsigned long sz)
 {
-	unsigned long hugepage_shift;
+	unsigned long hugepage_shift, pgsize;
 	int i, pte_num;
 
 	if (sz >= PGDIR_SIZE)
@@ -198,7 +241,22 @@ void set_huge_pte_at(struct mm_struct *mm,
 		hugepage_shift = PAGE_SHIFT;
 
 	pte_num = sz >> hugepage_shift;
-	for (i = 0; i < pte_num; i++, ptep++, addr += (1 << hugepage_shift))
+	pgsize = 1 << hugepage_shift;
+
+	if (!pte_present(pte)) {
+		for (i = 0; i < pte_num; i++, ptep++, addr += pgsize)
+			set_ptes(mm, addr, ptep, pte, 1);
+		return;
+	}
+
+	if (!pte_napot(pte)) {
+		set_ptes(mm, addr, ptep, pte, 1);
+		return;
+	}
+
+	clear_flush(mm, addr, ptep, pgsize, pte_num);
+
+	for (i = 0; i < pte_num; i++, ptep++, addr += pgsize)
 		set_pte_at(mm, addr, ptep, pte);
 }
 
@@ -306,7 +364,7 @@ void huge_pte_clear(struct mm_struct *mm,
 		pte_clear(mm, addr, ptep);
 }
 
-static __init bool is_napot_size(unsigned long size)
+static bool is_napot_size(unsigned long size)
 {
 	unsigned long order;
 
@@ -334,7 +392,7 @@ arch_initcall(napot_hugetlbpages_init);
 
 #else
 
-static __init bool is_napot_size(unsigned long size)
+static bool is_napot_size(unsigned long size)
 {
 	return false;
 }
@@ -351,7 +409,7 @@ int pmd_huge(pmd_t pmd)
 	return pmd_leaf(pmd);
 }
 
-bool __init arch_hugetlb_valid_size(unsigned long size)
+static bool __hugetlb_valid_size(unsigned long size)
 {
 	if (size == HPAGE_SIZE)
 		return true;
@@ -363,6 +421,16 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
 		return false;
 }
 
+bool __init arch_hugetlb_valid_size(unsigned long size)
+{
+	return __hugetlb_valid_size(size);
+}
+
+bool arch_hugetlb_migration_supported(struct hstate *h)
+{
+	return __hugetlb_valid_size(huge_page_size(h));
+}
+
 #ifdef CONFIG_CONTIG_ALLOC
 static __init int gigantic_pages_init(void)
 {
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index ad77ed410d4d..ee224fe18d18 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1385,6 +1385,10 @@ void __init misc_mem_init(void)
 	early_memtest(min_low_pfn << PAGE_SHIFT, max_low_pfn << PAGE_SHIFT);
 	arch_numa_init();
 	sparse_init();
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	/* The entire VMEMMAP region has been populated. Flush TLB for this region */
+	local_flush_tlb_kernel_range(VMEMMAP_START, VMEMMAP_END);
+#endif
 	zone_sizes_init();
 	arch_reserve_crashkernel();
 	memblock_dump_all();
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index e6659d7368b3..1f90721d22e9 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -66,6 +66,12 @@ static inline void local_flush_tlb_range_asid(unsigned long start,
 		local_flush_tlb_range_threshold_asid(start, size, stride, asid);
 }
 
+/* Flush a range of kernel pages without broadcasting */
+void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
+{
+	local_flush_tlb_range_asid(start, end - start, PAGE_SIZE, FLUSH_TLB_NO_ASID);
+}
+
 static void __ipi_flush_tlb_all(void *info)
 {
 	local_flush_tlb_all();
diff --git a/arch/sh/include/asm/cacheflush.h b/arch/sh/include/asm/cacheflush.h
index 878b6b551bd2..51112f54552b 100644
--- a/arch/sh/include/asm/cacheflush.h
+++ b/arch/sh/include/asm/cacheflush.h
@@ -90,6 +90,7 @@ extern void copy_from_user_page(struct vm_area_struct *vma,
 	unsigned long len);
 
 #define flush_cache_vmap(start, end)		local_flush_cache_all(NULL)
+#define flush_cache_vmap_early(start, end)	do { } while (0)
 #define flush_cache_vunmap(start, end)		local_flush_cache_all(NULL)
 
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
diff --git a/arch/sparc/include/asm/cacheflush_32.h b/arch/sparc/include/asm/cacheflush_32.h
index f3b7270bf71b..9fee0ccfccb8 100644
--- a/arch/sparc/include/asm/cacheflush_32.h
+++ b/arch/sparc/include/asm/cacheflush_32.h
@@ -48,6 +48,7 @@ static inline void flush_dcache_page(struct page *page)
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 
 #define flush_cache_vmap(start, end)		flush_cache_all()
+#define flush_cache_vmap_early(start, end)	do { } while (0)
 #define flush_cache_vunmap(start, end)		flush_cache_all()
 
 /* When a context switch happens we must flush all user windows so that
diff --git a/arch/sparc/include/asm/cacheflush_64.h b/arch/sparc/include/asm/cacheflush_64.h
index 0e879004efff..2b1261b77ecd 100644
--- a/arch/sparc/include/asm/cacheflush_64.h
+++ b/arch/sparc/include/asm/cacheflush_64.h
@@ -75,6 +75,7 @@ void flush_ptrace_access(struct vm_area_struct *, struct page *,
 #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
 
 #define flush_cache_vmap(start, end)		do { } while (0)
+#define flush_cache_vmap_early(start, end)	do { } while (0)
 #define flush_cache_vunmap(start, end)		do { } while (0)
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index b2771710ed98..a1bbedd989e4 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -106,8 +106,7 @@ extra_header_fields:
 	.word	0				# MinorSubsystemVersion
 	.long	0				# Win32VersionValue
 
-	.long	setup_size + ZO__end + pecompat_vsize
-						# SizeOfImage
+	.long	setup_size + ZO__end		# SizeOfImage
 
 	.long	salign				# SizeOfHeaders
 	.long	0				# CheckSum
@@ -143,7 +142,7 @@ section_table:
 	.ascii	".setup"
 	.byte	0
 	.byte	0
-	.long	setup_size - salign 		# VirtualSize
+	.long	pecompat_fstart - salign 	# VirtualSize
 	.long	salign				# VirtualAddress
 	.long	pecompat_fstart - salign	# SizeOfRawData
 	.long	salign				# PointerToRawData
@@ -156,8 +155,8 @@ section_table:
 #ifdef CONFIG_EFI_MIXED
 	.asciz	".compat"
 
-	.long	8				# VirtualSize
-	.long	setup_size + ZO__end		# VirtualAddress
+	.long	pecompat_fsize			# VirtualSize
+	.long	pecompat_fstart			# VirtualAddress
 	.long	pecompat_fsize			# SizeOfRawData
 	.long	pecompat_fstart			# PointerToRawData
 
@@ -172,17 +171,16 @@ section_table:
 	 * modes this image supports.
 	 */
 	.pushsection ".pecompat", "a", @progbits
-	.balign	falign
-	.set	pecompat_vsize, salign
+	.balign	salign
 	.globl	pecompat_fstart
 pecompat_fstart:
 	.byte	0x1				# Version
 	.byte	8				# Size
 	.word	IMAGE_FILE_MACHINE_I386		# PE machine type
 	.long	setup_size + ZO_efi32_pe_entry	# Entrypoint
+	.byte	0x0				# Sentinel
 	.popsection
 #else
-	.set	pecompat_vsize, 0
 	.set	pecompat_fstart, setup_size
 #endif
 	.ascii	".text"
diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 83bb7efad8ae..3a2d1360abb0 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -24,6 +24,9 @@ SECTIONS
 	.text		: { *(.text .text.*) }
 	.text32		: { *(.text32) }
 
+	.pecompat	: { *(.pecompat) }
+	PROVIDE(pecompat_fsize = setup_size - pecompat_fstart);
+
 	. = ALIGN(16);
 	.rodata		: { *(.rodata*) }
 
@@ -36,9 +39,6 @@ SECTIONS
 	. = ALIGN(16);
 	.data		: { *(.data*) }
 
-	.pecompat	: { *(.pecompat) }
-	PROVIDE(pecompat_fsize = setup_size - pecompat_fstart);
-
 	.signature	: {
 		setup_sig = .;
 		LONG(0x5a5aaa55)
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 20ef350a60fb..10d5ed8b5990 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -163,23 +163,23 @@ SYM_CODE_END(__get_user_8_handle_exception)
 #endif
 
 /* get_user */
-	_ASM_EXTABLE(1b, __get_user_handle_exception)
-	_ASM_EXTABLE(2b, __get_user_handle_exception)
-	_ASM_EXTABLE(3b, __get_user_handle_exception)
+	_ASM_EXTABLE_UA(1b, __get_user_handle_exception)
+	_ASM_EXTABLE_UA(2b, __get_user_handle_exception)
+	_ASM_EXTABLE_UA(3b, __get_user_handle_exception)
 #ifdef CONFIG_X86_64
-	_ASM_EXTABLE(4b, __get_user_handle_exception)
+	_ASM_EXTABLE_UA(4b, __get_user_handle_exception)
 #else
-	_ASM_EXTABLE(4b, __get_user_8_handle_exception)
-	_ASM_EXTABLE(5b, __get_user_8_handle_exception)
+	_ASM_EXTABLE_UA(4b, __get_user_8_handle_exception)
+	_ASM_EXTABLE_UA(5b, __get_user_8_handle_exception)
 #endif
 
 /* __get_user */
-	_ASM_EXTABLE(6b, __get_user_handle_exception)
-	_ASM_EXTABLE(7b, __get_user_handle_exception)
-	_ASM_EXTABLE(8b, __get_user_handle_exception)
+	_ASM_EXTABLE_UA(6b, __get_user_handle_exception)
+	_ASM_EXTABLE_UA(7b, __get_user_handle_exception)
+	_ASM_EXTABLE_UA(8b, __get_user_handle_exception)
 #ifdef CONFIG_X86_64
-	_ASM_EXTABLE(9b, __get_user_handle_exception)
+	_ASM_EXTABLE_UA(9b, __get_user_handle_exception)
 #else
-	_ASM_EXTABLE(9b, __get_user_8_handle_exception)
-	_ASM_EXTABLE(10b, __get_user_8_handle_exception)
+	_ASM_EXTABLE_UA(9b, __get_user_8_handle_exception)
+	_ASM_EXTABLE_UA(10b, __get_user_8_handle_exception)
 #endif
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 2877f5934177..975c9c18263d 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -133,15 +133,15 @@ SYM_CODE_START_LOCAL(__put_user_handle_exception)
 	RET
 SYM_CODE_END(__put_user_handle_exception)
 
-	_ASM_EXTABLE(1b, __put_user_handle_exception)
-	_ASM_EXTABLE(2b, __put_user_handle_exception)
-	_ASM_EXTABLE(3b, __put_user_handle_exception)
-	_ASM_EXTABLE(4b, __put_user_handle_exception)
-	_ASM_EXTABLE(5b, __put_user_handle_exception)
-	_ASM_EXTABLE(6b, __put_user_handle_exception)
-	_ASM_EXTABLE(7b, __put_user_handle_exception)
-	_ASM_EXTABLE(9b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(1b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(2b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(3b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(4b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(5b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(6b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(7b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(9b, __put_user_handle_exception)
 #ifdef CONFIG_X86_32
-	_ASM_EXTABLE(8b, __put_user_handle_exception)
-	_ASM_EXTABLE(10b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(8b, __put_user_handle_exception)
+	_ASM_EXTABLE_UA(10b, __put_user_handle_exception)
 #endif
diff --git a/arch/xtensa/include/asm/cacheflush.h b/arch/xtensa/include/asm/cacheflush.h
index 785a00ce83c1..38bcecb0e457 100644
--- a/arch/xtensa/include/asm/cacheflush.h
+++ b/arch/xtensa/include/asm/cacheflush.h
@@ -116,8 +116,9 @@ void flush_cache_page(struct vm_area_struct*,
 #define flush_cache_mm(mm)		flush_cache_all()
 #define flush_cache_dup_mm(mm)		flush_cache_mm(mm)
 
-#define flush_cache_vmap(start,end)	flush_cache_all()
-#define flush_cache_vunmap(start,end)	flush_cache_all()
+#define flush_cache_vmap(start,end)		flush_cache_all()
+#define flush_cache_vmap_early(start,end)	do { } while (0)
+#define flush_cache_vunmap(start,end)		flush_cache_all()
 
 void flush_dcache_folio(struct folio *folio);
 #define flush_dcache_folio flush_dcache_folio
@@ -140,6 +141,7 @@ void local_flush_cache_page(struct vm_area_struct *vma,
 #define flush_cache_dup_mm(mm)				do { } while (0)
 
 #define flush_cache_vmap(start,end)			do { } while (0)
+#define flush_cache_vmap_early(start,end)		do { } while (0)
 #define flush_cache_vunmap(start,end)			do { } while (0)
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 089fcb9cfce3..7ee8d85c2c68 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1353,6 +1353,13 @@ static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
 
 	lockdep_assert_held(&iocg->waitq.lock);
 
+	/*
+	 * If the delay is set by another CPU, we may be in the past. No need to
+	 * change anything if so. This avoids decay calculation underflow.
+	 */
+	if (time_before64(now->now, iocg->delay_at))
+		return false;
+
 	/* calculate the current delay in effect - 1/2 every second */
 	tdelta = now->now - iocg->delay_at;
 	if (iocg->delay)
diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index e327a0229dc1..e7f713cd70d3 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -2930,6 +2930,8 @@ open_card_ubr0(struct idt77252_dev *card)
 	vc->scq = alloc_scq(card, vc->class);
 	if (!vc->scq) {
 		printk("%s: can't get SCQ.\n", card->name);
+		kfree(card->vcs[0]);
+		card->vcs[0] = NULL;
 		return -ENOMEM;
 	}
 
diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
index 7958ac33e36c..5a8061a307cd 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
@@ -38,15 +38,17 @@ static int dpaa2_qdma_alloc_chan_resources(struct dma_chan *chan)
 	if (!dpaa2_chan->fd_pool)
 		goto err;
 
-	dpaa2_chan->fl_pool = dma_pool_create("fl_pool", dev,
-					      sizeof(struct dpaa2_fl_entry),
-					      sizeof(struct dpaa2_fl_entry), 0);
+	dpaa2_chan->fl_pool =
+		dma_pool_create("fl_pool", dev,
+				 sizeof(struct dpaa2_fl_entry) * 3,
+				 sizeof(struct dpaa2_fl_entry), 0);
+
 	if (!dpaa2_chan->fl_pool)
 		goto err_fd;
 
 	dpaa2_chan->sdd_pool =
 		dma_pool_create("sdd_pool", dev,
-				sizeof(struct dpaa2_qdma_sd_d),
+				sizeof(struct dpaa2_qdma_sd_d) * 2,
 				sizeof(struct dpaa2_qdma_sd_d), 0);
 	if (!dpaa2_chan->sdd_pool)
 		goto err_fl;
diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 47cb28468049..3a5595a1d442 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -514,11 +514,11 @@ static struct fsl_qdma_queue
 			queue_temp = queue_head + i + (j * queue_num);
 
 			queue_temp->cq =
-			dma_alloc_coherent(&pdev->dev,
-					   sizeof(struct fsl_qdma_format) *
-					   queue_size[i],
-					   &queue_temp->bus_addr,
-					   GFP_KERNEL);
+			dmam_alloc_coherent(&pdev->dev,
+					    sizeof(struct fsl_qdma_format) *
+					    queue_size[i],
+					    &queue_temp->bus_addr,
+					    GFP_KERNEL);
 			if (!queue_temp->cq)
 				return NULL;
 			queue_temp->block_base = fsl_qdma->block_base +
@@ -563,11 +563,11 @@ static struct fsl_qdma_queue
 	/*
 	 * Buffer for queue command
 	 */
-	status_head->cq = dma_alloc_coherent(&pdev->dev,
-					     sizeof(struct fsl_qdma_format) *
-					     status_size,
-					     &status_head->bus_addr,
-					     GFP_KERNEL);
+	status_head->cq = dmam_alloc_coherent(&pdev->dev,
+					      sizeof(struct fsl_qdma_format) *
+					      status_size,
+					      &status_head->bus_addr,
+					      GFP_KERNEL);
 	if (!status_head->cq) {
 		devm_kfree(&pdev->dev, status_head);
 		return NULL;
@@ -1268,8 +1268,6 @@ static void fsl_qdma_cleanup_vchan(struct dma_device *dmadev)
 
 static void fsl_qdma_remove(struct platform_device *pdev)
 {
-	int i;
-	struct fsl_qdma_queue *status;
 	struct device_node *np = pdev->dev.of_node;
 	struct fsl_qdma_engine *fsl_qdma = platform_get_drvdata(pdev);
 
@@ -1277,12 +1275,6 @@ static void fsl_qdma_remove(struct platform_device *pdev)
 	fsl_qdma_cleanup_vchan(&fsl_qdma->dma_dev);
 	of_dma_controller_free(np);
 	dma_async_device_unregister(&fsl_qdma->dma_dev);
-
-	for (i = 0; i < fsl_qdma->block_number; i++) {
-		status = fsl_qdma->status[i];
-		dma_free_coherent(&pdev->dev, sizeof(struct fsl_qdma_format) *
-				status->n_cq, status->cq, status->bus_addr);
-	}
 }
 
 static const struct of_device_id fsl_qdma_dt_ids[] = {
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 30fd2f386f36..037f1408e798 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3968,6 +3968,7 @@ static void udma_desc_pre_callback(struct virt_dma_chan *vc,
 {
 	struct udma_chan *uc = to_udma_chan(&vc->chan);
 	struct udma_desc *d;
+	u8 status;
 
 	if (!vd)
 		return;
@@ -3977,12 +3978,12 @@ static void udma_desc_pre_callback(struct virt_dma_chan *vc,
 	if (d->metadata_size)
 		udma_fetch_epib(uc, d);
 
-	/* Provide residue information for the client */
 	if (result) {
 		void *desc_vaddr = udma_curr_cppi5_desc_vaddr(d, d->desc_idx);
 
 		if (cppi5_desc_get_type(desc_vaddr) ==
 		    CPPI5_INFO0_DESC_TYPE_VAL_HOST) {
+			/* Provide residue information for the client */
 			result->residue = d->residue -
 					  cppi5_hdesc_get_pktlen(desc_vaddr);
 			if (result->residue)
@@ -3991,7 +3992,12 @@ static void udma_desc_pre_callback(struct virt_dma_chan *vc,
 				result->result = DMA_TRANS_NOERROR;
 		} else {
 			result->residue = 0;
-			result->result = DMA_TRANS_NOERROR;
+			/* Propagate TR Response errors to the client */
+			status = d->hwdesc[0].tr_resp_base->status;
+			if (status)
+				result->result = DMA_TRANS_ABORTED;
+			else
+				result->result = DMA_TRANS_NOERROR;
 		}
 	}
 }
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 212687c30d79..c04b82ea40f2 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -956,7 +956,8 @@ efi_status_t efi_get_random_bytes(unsigned long size, u8 *out);
 
 efi_status_t efi_random_alloc(unsigned long size, unsigned long align,
 			      unsigned long *addr, unsigned long random_seed,
-			      int memory_type, unsigned long alloc_limit);
+			      int memory_type, unsigned long alloc_min,
+			      unsigned long alloc_max);
 
 efi_status_t efi_random_get_seed(void);
 
diff --git a/drivers/firmware/efi/libstub/kaslr.c b/drivers/firmware/efi/libstub/kaslr.c
index 62d63f7a2645..1a9808012abd 100644
--- a/drivers/firmware/efi/libstub/kaslr.c
+++ b/drivers/firmware/efi/libstub/kaslr.c
@@ -119,7 +119,7 @@ efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
 		 */
 		status = efi_random_alloc(*reserve_size, min_kimg_align,
 					  reserve_addr, phys_seed,
-					  EFI_LOADER_CODE, EFI_ALLOC_LIMIT);
+					  EFI_LOADER_CODE, 0, EFI_ALLOC_LIMIT);
 		if (status != EFI_SUCCESS)
 			efi_warn("efi_random_alloc() failed: 0x%lx\n", status);
 	} else {
diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index 674a064b8f7a..4e96a855fdf4 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -17,7 +17,7 @@
 static unsigned long get_entry_num_slots(efi_memory_desc_t *md,
 					 unsigned long size,
 					 unsigned long align_shift,
-					 u64 alloc_limit)
+					 u64 alloc_min, u64 alloc_max)
 {
 	unsigned long align = 1UL << align_shift;
 	u64 first_slot, last_slot, region_end;
@@ -30,11 +30,11 @@ static unsigned long get_entry_num_slots(efi_memory_desc_t *md,
 		return 0;
 
 	region_end = min(md->phys_addr + md->num_pages * EFI_PAGE_SIZE - 1,
-			 alloc_limit);
+			 alloc_max);
 	if (region_end < size)
 		return 0;
 
-	first_slot = round_up(md->phys_addr, align);
+	first_slot = round_up(max(md->phys_addr, alloc_min), align);
 	last_slot = round_down(region_end - size + 1, align);
 
 	if (first_slot > last_slot)
@@ -56,7 +56,8 @@ efi_status_t efi_random_alloc(unsigned long size,
 			      unsigned long *addr,
 			      unsigned long random_seed,
 			      int memory_type,
-			      unsigned long alloc_limit)
+			      unsigned long alloc_min,
+			      unsigned long alloc_max)
 {
 	unsigned long total_slots = 0, target_slot;
 	unsigned long total_mirrored_slots = 0;
@@ -78,7 +79,8 @@ efi_status_t efi_random_alloc(unsigned long size,
 		efi_memory_desc_t *md = (void *)map->map + map_offset;
 		unsigned long slots;
 
-		slots = get_entry_num_slots(md, size, ilog2(align), alloc_limit);
+		slots = get_entry_num_slots(md, size, ilog2(align), alloc_min,
+					    alloc_max);
 		MD_NUM_SLOTS(md) = slots;
 		total_slots += slots;
 		if (md->attribute & EFI_MEMORY_MORE_RELIABLE)
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 0d510c9a06a4..99429bc4b0c7 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -223,8 +223,8 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
 	}
 }
 
-void efi_adjust_memory_range_protection(unsigned long start,
-					unsigned long size)
+efi_status_t efi_adjust_memory_range_protection(unsigned long start,
+						unsigned long size)
 {
 	efi_status_t status;
 	efi_gcd_memory_space_desc_t desc;
@@ -236,13 +236,17 @@ void efi_adjust_memory_range_protection(unsigned long start,
 	rounded_end = roundup(start + size, EFI_PAGE_SIZE);
 
 	if (memattr != NULL) {
-		efi_call_proto(memattr, clear_memory_attributes, rounded_start,
-			       rounded_end - rounded_start, EFI_MEMORY_XP);
-		return;
+		status = efi_call_proto(memattr, clear_memory_attributes,
+					rounded_start,
+					rounded_end - rounded_start,
+					EFI_MEMORY_XP);
+		if (status != EFI_SUCCESS)
+			efi_warn("Failed to clear EFI_MEMORY_XP attribute\n");
+		return status;
 	}
 
 	if (efi_dxe_table == NULL)
-		return;
+		return EFI_SUCCESS;
 
 	/*
 	 * Don't modify memory region attributes, they are
@@ -255,7 +259,7 @@ void efi_adjust_memory_range_protection(unsigned long start,
 		status = efi_dxe_call(get_memory_space_descriptor, start, &desc);
 
 		if (status != EFI_SUCCESS)
-			return;
+			break;
 
 		next = desc.base_address + desc.length;
 
@@ -280,8 +284,10 @@ void efi_adjust_memory_range_protection(unsigned long start,
 				 unprotect_start,
 				 unprotect_start + unprotect_size,
 				 status);
+			break;
 		}
 	}
+	return EFI_SUCCESS;
 }
 
 static void setup_unaccepted_memory(void)
@@ -793,6 +799,7 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 
 	status = efi_random_alloc(alloc_size, CONFIG_PHYSICAL_ALIGN, &addr,
 				  seed[0], EFI_LOADER_CODE,
+				  LOAD_PHYSICAL_ADDR,
 				  EFI_X86_KERNEL_ALLOC_LIMIT);
 	if (status != EFI_SUCCESS)
 		return status;
@@ -805,9 +812,7 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 
 	*kernel_entry = addr + entry;
 
-	efi_adjust_memory_range_protection(addr, kernel_total_size);
-
-	return EFI_SUCCESS;
+	return efi_adjust_memory_range_protection(addr, kernel_total_size);
 }
 
 static void __noreturn enter_kernel(unsigned long kernel_addr,
diff --git a/drivers/firmware/efi/libstub/x86-stub.h b/drivers/firmware/efi/libstub/x86-stub.h
index 37c5a36b9d8c..1c20e99a6494 100644
--- a/drivers/firmware/efi/libstub/x86-stub.h
+++ b/drivers/firmware/efi/libstub/x86-stub.h
@@ -5,8 +5,8 @@
 extern void trampoline_32bit_src(void *, bool);
 extern const u16 trampoline_ljmp_imm_offset;
 
-void efi_adjust_memory_range_protection(unsigned long start,
-					unsigned long size);
+efi_status_t efi_adjust_memory_range_protection(unsigned long start,
+						unsigned long size);
 
 #ifdef CONFIG_X86_64
 efi_status_t efi_setup_5level_paging(void);
diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
index bdb17eac0cb4..1ceace956758 100644
--- a/drivers/firmware/efi/libstub/zboot.c
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -119,7 +119,7 @@ efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
 		}
 
 		status = efi_random_alloc(alloc_size, min_kimg_align, &image_base,
-					  seed, EFI_LOADER_CODE, EFI_ALLOC_LIMIT);
+					  seed, EFI_LOADER_CODE, 0, EFI_ALLOC_LIMIT);
 		if (status != EFI_SUCCESS) {
 			efi_err("Failed to allocate memory\n");
 			goto free_cmdline;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9257c9af3fee..5fe1df95dc38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4051,23 +4051,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 				}
 			}
 		} else {
-			switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
-			case IP_VERSION(13, 0, 0):
-			case IP_VERSION(13, 0, 7):
-			case IP_VERSION(13, 0, 10):
-				r = psp_gpu_reset(adev);
-				break;
-			default:
-				tmp = amdgpu_reset_method;
-				/* It should do a default reset when loading or reloading the driver,
-				 * regardless of the module parameter reset_method.
-				 */
-				amdgpu_reset_method = AMD_RESET_METHOD_NONE;
-				r = amdgpu_asic_reset(adev);
-				amdgpu_reset_method = tmp;
-				break;
-			}
-
+			tmp = amdgpu_reset_method;
+			/* It should do a default reset when loading or reloading the driver,
+			 * regardless of the module parameter reset_method.
+			 */
+			amdgpu_reset_method = AMD_RESET_METHOD_NONE;
+			r = amdgpu_asic_reset(adev);
+			amdgpu_reset_method = tmp;
 			if (r) {
 				dev_err(adev->dev, "asic reset on init failed\n");
 				goto failed;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index f3b75f283aa2..ce04caf35d80 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -999,7 +999,7 @@ static struct stream_encoder *dcn301_stream_encoder_create(enum engine_id eng_id
 	vpg = dcn301_vpg_create(ctx, vpg_inst);
 	afmt = dcn301_afmt_create(ctx, afmt_inst);
 
-	if (!enc1 || !vpg || !afmt) {
+	if (!enc1 || !vpg || !afmt || eng_id >= ARRAY_SIZE(stream_enc_regs)) {
 		kfree(enc1);
 		kfree(vpg);
 		kfree(afmt);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 8e88dcaf88f5..5c7f380a84f9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -206,28 +206,32 @@ void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
 void dcn21_set_pipe(struct pipe_ctx *pipe_ctx)
 {
 	struct abm *abm = pipe_ctx->stream_res.abm;
-	uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
+	struct timing_generator *tg = pipe_ctx->stream_res.tg;
 	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
 	struct dmcu *dmcu = pipe_ctx->stream->ctx->dc->res_pool->dmcu;
+	uint32_t otg_inst;
+
+	if (!abm && !tg && !panel_cntl)
+		return;
+
+	otg_inst = tg->inst;
 
 	if (dmcu) {
 		dce110_set_pipe(pipe_ctx);
 		return;
 	}
 
-	if (abm && panel_cntl) {
-		if (abm->funcs && abm->funcs->set_pipe_ex) {
-			abm->funcs->set_pipe_ex(abm,
+	if (abm->funcs && abm->funcs->set_pipe_ex) {
+		abm->funcs->set_pipe_ex(abm,
 					otg_inst,
 					SET_ABM_PIPE_NORMAL,
 					panel_cntl->inst,
 					panel_cntl->pwrseq_inst);
-		} else {
-				dmub_abm_set_pipe(abm, otg_inst,
-						SET_ABM_PIPE_NORMAL,
-						panel_cntl->inst,
-						panel_cntl->pwrseq_inst);
-		}
+	} else {
+		dmub_abm_set_pipe(abm, otg_inst,
+				  SET_ABM_PIPE_NORMAL,
+				  panel_cntl->inst,
+				  panel_cntl->pwrseq_inst);
 	}
 }
 
@@ -237,34 +241,35 @@ bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
 {
 	struct dc_context *dc = pipe_ctx->stream->ctx;
 	struct abm *abm = pipe_ctx->stream_res.abm;
+	struct timing_generator *tg = pipe_ctx->stream_res.tg;
 	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
+	uint32_t otg_inst;
+
+	if (!abm && !tg && !panel_cntl)
+		return false;
+
+	otg_inst = tg->inst;
 
 	if (dc->dc->res_pool->dmcu) {
 		dce110_set_backlight_level(pipe_ctx, backlight_pwm_u16_16, frame_ramp);
 		return true;
 	}
 
-	if (abm != NULL) {
-		uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
-
-		if (abm && panel_cntl) {
-			if (abm->funcs && abm->funcs->set_pipe_ex) {
-				abm->funcs->set_pipe_ex(abm,
-						otg_inst,
-						SET_ABM_PIPE_NORMAL,
-						panel_cntl->inst,
-						panel_cntl->pwrseq_inst);
-			} else {
-					dmub_abm_set_pipe(abm,
-							otg_inst,
-							SET_ABM_PIPE_NORMAL,
-							panel_cntl->inst,
-							panel_cntl->pwrseq_inst);
-			}
-		}
+	if (abm->funcs && abm->funcs->set_pipe_ex) {
+		abm->funcs->set_pipe_ex(abm,
+					otg_inst,
+					SET_ABM_PIPE_NORMAL,
+					panel_cntl->inst,
+					panel_cntl->pwrseq_inst);
+	} else {
+		dmub_abm_set_pipe(abm,
+				  otg_inst,
+				  SET_ABM_PIPE_NORMAL,
+				  panel_cntl->inst,
+				  panel_cntl->pwrseq_inst);
 	}
 
-	if (abm && abm->funcs && abm->funcs->set_backlight_level_pwm)
+	if (abm->funcs && abm->funcs->set_backlight_level_pwm)
 		abm->funcs->set_backlight_level_pwm(abm, backlight_pwm_u16_16,
 			frame_ramp, 0, panel_cntl->inst);
 	else
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index cd252e2b584c..60dce148b2d7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -734,7 +734,7 @@ static int smu_early_init(void *handle)
 	smu->adev = adev;
 	smu->pm_enabled = !!amdgpu_dpm;
 	smu->is_apu = false;
-	smu->smu_baco.state = SMU_BACO_STATE_NONE;
+	smu->smu_baco.state = SMU_BACO_STATE_EXIT;
 	smu->smu_baco.platform_support = false;
 	smu->user_dpm_profile.fan_mode = -1;
 
@@ -1746,31 +1746,10 @@ static int smu_smc_hw_cleanup(struct smu_context *smu)
 	return 0;
 }
 
-static int smu_reset_mp1_state(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	int ret = 0;
-
-	if ((!adev->in_runpm) && (!adev->in_suspend) &&
-		(!amdgpu_in_reset(adev)))
-		switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
-		case IP_VERSION(13, 0, 0):
-		case IP_VERSION(13, 0, 7):
-		case IP_VERSION(13, 0, 10):
-			ret = smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
-			break;
-		default:
-			break;
-		}
-
-	return ret;
-}
-
 static int smu_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	int ret;
 
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
@@ -1788,15 +1767,7 @@ static int smu_hw_fini(void *handle)
 
 	adev->pm.dpm_enabled = false;
 
-	ret = smu_smc_hw_cleanup(smu);
-	if (ret)
-		return ret;
-
-	ret = smu_reset_mp1_state(smu);
-	if (ret)
-		return ret;
-
-	return 0;
+	return smu_smc_hw_cleanup(smu);
 }
 
 static void smu_late_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index f8b2e6cc2568..e8329d157bfe 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -419,7 +419,6 @@ enum smu_reset_mode {
 enum smu_baco_state {
 	SMU_BACO_STATE_ENTER = 0,
 	SMU_BACO_STATE_EXIT,
-	SMU_BACO_STATE_NONE,
 };
 
 struct smu_baco_context {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 2a76064d909f..5625a6e5702a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2773,13 +2773,7 @@ static int smu_v13_0_0_set_mp1_state(struct smu_context *smu,
 
 	switch (mp1_state) {
 	case PP_MP1_STATE_UNLOAD:
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-											  SMU_MSG_PrepareMp1ForUnload,
-											  0x55, NULL);
-
-		if (!ret && smu->smu_baco.state == SMU_BACO_STATE_EXIT)
-			ret = smu_v13_0_disable_pmfw_state(smu);
-
+		ret = smu_cmn_set_mp1_state(smu, mp1_state);
 		break;
 	default:
 		/* Ignore others */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index d380a53e8f77..bc5891c3f648 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2500,13 +2500,7 @@ static int smu_v13_0_7_set_mp1_state(struct smu_context *smu,
 
 	switch (mp1_state) {
 	case PP_MP1_STATE_UNLOAD:
-		ret = smu_cmn_send_smc_msg_with_param(smu,
-											  SMU_MSG_PrepareMp1ForUnload,
-											  0x55, NULL);
-
-		if (!ret && smu->smu_baco.state == SMU_BACO_STATE_EXIT)
-			ret = smu_v13_0_disable_pmfw_state(smu);
-
+		ret = smu_cmn_set_mp1_state(smu, mp1_state);
 		break;
 	default:
 		/* Ignore others */
diff --git a/drivers/gpu/drm/i915/gvt/handlers.c b/drivers/gpu/drm/i915/gvt/handlers.c
index a9f7fa9b90bd..d30f8814d9b1 100644
--- a/drivers/gpu/drm/i915/gvt/handlers.c
+++ b/drivers/gpu/drm/i915/gvt/handlers.c
@@ -2850,8 +2850,7 @@ static int handle_mmio(struct intel_gvt_mmio_table_iter *iter, u32 offset,
 	for (i = start; i < end; i += 4) {
 		p = intel_gvt_find_mmio_info(gvt, i);
 		if (p) {
-			WARN(1, "dup mmio definition offset %x\n",
-				info->offset);
+			WARN(1, "dup mmio definition offset %x\n", i);
 
 			/* We return -EEXIST here to make GVT-g load fail.
 			 * So duplicated MMIO can be found as soon as
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index b9f0093389a8..cf0d44b6e7a3 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2075,7 +2075,7 @@ void dpu_encoder_helper_phys_cleanup(struct dpu_encoder_phys *phys_enc)
 	}
 
 	/* reset the merge 3D HW block */
-	if (phys_enc->hw_pp->merge_3d) {
+	if (phys_enc->hw_pp && phys_enc->hw_pp->merge_3d) {
 		phys_enc->hw_pp->merge_3d->ops.setup_3d_mode(phys_enc->hw_pp->merge_3d,
 				BLEND_3D_NONE);
 		if (phys_enc->hw_ctl->ops.update_pending_flush_merge_3d)
@@ -2097,7 +2097,7 @@ void dpu_encoder_helper_phys_cleanup(struct dpu_encoder_phys *phys_enc)
 	if (phys_enc->hw_wb)
 		intf_cfg.wb = phys_enc->hw_wb->idx;
 
-	if (phys_enc->hw_pp->merge_3d)
+	if (phys_enc->hw_pp && phys_enc->hw_pp->merge_3d)
 		intf_cfg.merge_3d = phys_enc->hw_pp->merge_3d->idx;
 
 	if (ctl->ops.reset_intf_cfg)
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 77a8d9366ed7..fb588fde298a 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -135,11 +135,6 @@ static void dp_ctrl_config_ctrl(struct dp_ctrl_private *ctrl)
 	tbd = dp_link_get_test_bits_depth(ctrl->link,
 			ctrl->panel->dp_mode.bpp);
 
-	if (tbd == DP_TEST_BIT_DEPTH_UNKNOWN) {
-		pr_debug("BIT_DEPTH not set. Configure default\n");
-		tbd = DP_TEST_BIT_DEPTH_8;
-	}
-
 	config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
 
 	/* Num of Lanes */
diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
index 98427d45e9a7..49dfac1fd1ef 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.c
+++ b/drivers/gpu/drm/msm/dp/dp_link.c
@@ -7,6 +7,7 @@
 
 #include <drm/drm_print.h>
 
+#include "dp_reg.h"
 #include "dp_link.h"
 #include "dp_panel.h"
 
@@ -1082,7 +1083,7 @@ int dp_link_process_request(struct dp_link *dp_link)
 
 int dp_link_get_colorimetry_config(struct dp_link *dp_link)
 {
-	u32 cc;
+	u32 cc = DP_MISC0_COLORIMERY_CFG_LEGACY_RGB;
 	struct dp_link_private *link;
 
 	if (!dp_link) {
@@ -1096,10 +1097,11 @@ int dp_link_get_colorimetry_config(struct dp_link *dp_link)
 	 * Unless a video pattern CTS test is ongoing, use RGB_VESA
 	 * Only RGB_VESA and RGB_CEA supported for now
 	 */
-	if (dp_link_is_video_pattern_requested(link))
-		cc = link->dp_link.test_video.test_dyn_range;
-	else
-		cc = DP_TEST_DYNAMIC_RANGE_VESA;
+	if (dp_link_is_video_pattern_requested(link)) {
+		if (link->dp_link.test_video.test_dyn_range &
+					DP_TEST_DYNAMIC_RANGE_CEA)
+			cc = DP_MISC0_COLORIMERY_CFG_CEA_RGB;
+	}
 
 	return cc;
 }
@@ -1179,6 +1181,9 @@ void dp_link_reset_phy_params_vx_px(struct dp_link *dp_link)
 u32 dp_link_get_test_bits_depth(struct dp_link *dp_link, u32 bpp)
 {
 	u32 tbd;
+	struct dp_link_private *link;
+
+	link = container_of(dp_link, struct dp_link_private, dp_link);
 
 	/*
 	 * Few simplistic rules and assumptions made here:
@@ -1196,12 +1201,13 @@ u32 dp_link_get_test_bits_depth(struct dp_link *dp_link, u32 bpp)
 		tbd = DP_TEST_BIT_DEPTH_10;
 		break;
 	default:
-		tbd = DP_TEST_BIT_DEPTH_UNKNOWN;
+		drm_dbg_dp(link->drm_dev, "bpp=%d not supported, use bpc=8\n",
+			   bpp);
+		tbd = DP_TEST_BIT_DEPTH_8;
 		break;
 	}
 
-	if (tbd != DP_TEST_BIT_DEPTH_UNKNOWN)
-		tbd = (tbd >> DP_TEST_BIT_DEPTH_SHIFT);
+	tbd = (tbd >> DP_TEST_BIT_DEPTH_SHIFT);
 
 	return tbd;
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
index ea85a691e72b..78785ed4b40c 100644
--- a/drivers/gpu/drm/msm/dp/dp_reg.h
+++ b/drivers/gpu/drm/msm/dp/dp_reg.h
@@ -143,6 +143,9 @@
 #define DP_MISC0_COLORIMETRY_CFG_SHIFT		(0x00000001)
 #define DP_MISC0_TEST_BITS_DEPTH_SHIFT		(0x00000005)
 
+#define DP_MISC0_COLORIMERY_CFG_LEGACY_RGB	(0)
+#define DP_MISC0_COLORIMERY_CFG_CEA_RGB		(0x04)
+
 #define REG_DP_VALID_BOUNDARY			(0x00000030)
 #define REG_DP_VALID_BOUNDARY_2			(0x00000034)
 
diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
index 997df4b40509..b2ae2176f11f 100644
--- a/drivers/hwmon/aspeed-pwm-tacho.c
+++ b/drivers/hwmon/aspeed-pwm-tacho.c
@@ -193,6 +193,8 @@ struct aspeed_pwm_tacho_data {
 	u8 fan_tach_ch_source[16];
 	struct aspeed_cooling_device *cdev[8];
 	const struct attribute_group *groups[3];
+	/* protects access to shared ASPEED_PTCR_RESULT */
+	struct mutex tach_lock;
 };
 
 enum type { TYPEM, TYPEN, TYPEO };
@@ -527,6 +529,8 @@ static int aspeed_get_fan_tach_ch_rpm(struct aspeed_pwm_tacho_data *priv,
 	u8 fan_tach_ch_source, type, mode, both;
 	int ret;
 
+	mutex_lock(&priv->tach_lock);
+
 	regmap_write(priv->regmap, ASPEED_PTCR_TRIGGER, 0);
 	regmap_write(priv->regmap, ASPEED_PTCR_TRIGGER, 0x1 << fan_tach_ch);
 
@@ -544,6 +548,8 @@ static int aspeed_get_fan_tach_ch_rpm(struct aspeed_pwm_tacho_data *priv,
 		ASPEED_RPM_STATUS_SLEEP_USEC,
 		usec);
 
+	mutex_unlock(&priv->tach_lock);
+
 	/* return -ETIMEDOUT if we didn't get an answer. */
 	if (ret)
 		return ret;
@@ -903,6 +909,7 @@ static int aspeed_pwm_tacho_probe(struct platform_device *pdev)
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
+	mutex_init(&priv->tach_lock);
 	priv->regmap = devm_regmap_init(dev, NULL, (__force void *)regs,
 			&aspeed_pwm_tacho_regmap_config);
 	if (IS_ERR(priv->regmap))
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index ba82d1e79c13..95f4c0b00b2d 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -419,7 +419,7 @@ static ssize_t show_temp(struct device *dev,
 }
 
 static int create_core_attrs(struct temp_data *tdata, struct device *dev,
-			     int attr_no)
+			     int index)
 {
 	int i;
 	static ssize_t (*const rd_ptr[TOTAL_ATTRS]) (struct device *dev,
@@ -431,13 +431,20 @@ static int create_core_attrs(struct temp_data *tdata, struct device *dev,
 	};
 
 	for (i = 0; i < tdata->attr_size; i++) {
+		/*
+		 * We map the attr number to core id of the CPU
+		 * The attr number is always core id + 2
+		 * The Pkgtemp will always show up as temp1_*, if available
+		 */
+		int attr_no = tdata->is_pkg_data ? 1 : tdata->cpu_core_id + 2;
+
 		snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH,
 			 "temp%d_%s", attr_no, suffixes[i]);
 		sysfs_attr_init(&tdata->sd_attrs[i].dev_attr.attr);
 		tdata->sd_attrs[i].dev_attr.attr.name = tdata->attr_name[i];
 		tdata->sd_attrs[i].dev_attr.attr.mode = 0444;
 		tdata->sd_attrs[i].dev_attr.show = rd_ptr[i];
-		tdata->sd_attrs[i].index = attr_no;
+		tdata->sd_attrs[i].index = index;
 		tdata->attrs[i] = &tdata->sd_attrs[i].dev_attr.attr;
 	}
 	tdata->attr_group.attrs = tdata->attrs;
@@ -495,30 +502,25 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 	struct platform_data *pdata = platform_get_drvdata(pdev);
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	u32 eax, edx;
-	int err, index, attr_no;
+	int err, index;
 
 	if (!housekeeping_cpu(cpu, HK_TYPE_MISC))
 		return 0;
 
 	/*
-	 * Find attr number for sysfs:
-	 * We map the attr number to core id of the CPU
-	 * The attr number is always core id + 2
-	 * The Pkgtemp will always show up as temp1_*, if available
+	 * Get the index of tdata in pdata->core_data[]
+	 * tdata for package: pdata->core_data[1]
+	 * tdata for core: pdata->core_data[2] .. pdata->core_data[NUM_REAL_CORES + 1]
 	 */
 	if (pkg_flag) {
-		attr_no = PKG_SYSFS_ATTR_NO;
+		index = PKG_SYSFS_ATTR_NO;
 	} else {
-		index = ida_alloc(&pdata->ida, GFP_KERNEL);
+		index = ida_alloc_max(&pdata->ida, NUM_REAL_CORES - 1, GFP_KERNEL);
 		if (index < 0)
 			return index;
-		pdata->cpu_map[index] = topology_core_id(cpu);
-		attr_no = index + BASE_SYSFS_ATTR_NO;
-	}
 
-	if (attr_no > MAX_CORE_DATA - 1) {
-		err = -ERANGE;
-		goto ida_free;
+		pdata->cpu_map[index] = topology_core_id(cpu);
+		index += BASE_SYSFS_ATTR_NO;
 	}
 
 	tdata = init_temp_data(cpu, pkg_flag);
@@ -544,20 +546,20 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 		if (get_ttarget(tdata, &pdev->dev) >= 0)
 			tdata->attr_size++;
 
-	pdata->core_data[attr_no] = tdata;
+	pdata->core_data[index] = tdata;
 
 	/* Create sysfs interfaces */
-	err = create_core_attrs(tdata, pdata->hwmon_dev, attr_no);
+	err = create_core_attrs(tdata, pdata->hwmon_dev, index);
 	if (err)
 		goto exit_free;
 
 	return 0;
 exit_free:
-	pdata->core_data[attr_no] = NULL;
+	pdata->core_data[index] = NULL;
 	kfree(tdata);
 ida_free:
 	if (!pkg_flag)
-		ida_free(&pdata->ida, index);
+		ida_free(&pdata->ida, index - BASE_SYSFS_ATTR_NO);
 	return err;
 }
 
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 13ef6284223d..c229bd6b3f7f 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -811,7 +811,6 @@ static int atkbd_probe(struct atkbd *atkbd)
 {
 	struct ps2dev *ps2dev = &atkbd->ps2dev;
 	unsigned char param[2];
-	bool skip_getid;
 
 /*
  * Some systems, where the bit-twiddling when testing the io-lines of the
@@ -825,6 +824,11 @@ static int atkbd_probe(struct atkbd *atkbd)
 				 "keyboard reset failed on %s\n",
 				 ps2dev->serio->phys);
 
+	if (atkbd_skip_getid(atkbd)) {
+		atkbd->id = 0xab83;
+		return 0;
+	}
+
 /*
  * Then we check the keyboard ID. We should get 0xab83 under normal conditions.
  * Some keyboards report different values, but the first byte is always 0xab or
@@ -833,18 +837,17 @@ static int atkbd_probe(struct atkbd *atkbd)
  */
 
 	param[0] = param[1] = 0xa5;	/* initialize with invalid values */
-	skip_getid = atkbd_skip_getid(atkbd);
-	if (skip_getid || ps2_command(ps2dev, param, ATKBD_CMD_GETID)) {
+	if (ps2_command(ps2dev, param, ATKBD_CMD_GETID)) {
 
 /*
- * If the get ID command was skipped or failed, we check if we can at least set
+ * If the get ID command failed, we check if we can at least set
  * the LEDs on the keyboard. This should work on every keyboard out there.
  * It also turns the LEDs off, which we want anyway.
  */
 		param[0] = 0;
 		if (ps2_command(ps2dev, param, ATKBD_CMD_SETLEDS))
 			return -1;
-		atkbd->id = skip_getid ? 0xab83 : 0xabba;
+		atkbd->id = 0xabba;
 		return 0;
 	}
 
diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index b585b1dab870..cd45a65e17f2 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -1208,6 +1208,12 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
 					SERIO_QUIRK_NOPNP)
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NS5x_7xPU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOAUX)
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
index abd4832e4ed2..5acb3e16b567 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
@@ -993,7 +993,7 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
 	return 0;
 
 err_exit_hwts_rx:
-	aq_ring_free(&aq_ptp->hwts_rx);
+	aq_ring_hwts_rx_free(&aq_ptp->hwts_rx);
 err_exit_ptp_rx:
 	aq_ring_free(&aq_ptp->ptp_rx);
 err_exit_ptp_tx:
@@ -1011,7 +1011,7 @@ void aq_ptp_ring_free(struct aq_nic_s *aq_nic)
 
 	aq_ring_free(&aq_ptp->ptp_tx);
 	aq_ring_free(&aq_ptp->ptp_rx);
-	aq_ring_free(&aq_ptp->hwts_rx);
+	aq_ring_hwts_rx_free(&aq_ptp->hwts_rx);
 
 	aq_ptp_skb_ring_release(&aq_ptp->skb_ring);
 }
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index cda8597b4e14..f7433abd6591 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -919,6 +919,19 @@ void aq_ring_free(struct aq_ring_s *self)
 	}
 }
 
+void aq_ring_hwts_rx_free(struct aq_ring_s *self)
+{
+	if (!self)
+		return;
+
+	if (self->dx_ring) {
+		dma_free_coherent(aq_nic_get_dev(self->aq_nic),
+				  self->size * self->dx_size + AQ_CFG_RXDS_DEF,
+				  self->dx_ring, self->dx_ring_pa);
+		self->dx_ring = NULL;
+	}
+}
+
 unsigned int aq_ring_fill_stats_data(struct aq_ring_s *self, u64 *data)
 {
 	unsigned int count;
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
index 52847310740a..d627ace850ff 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
@@ -210,6 +210,7 @@ int aq_ring_rx_fill(struct aq_ring_s *self);
 int aq_ring_hwts_rx_alloc(struct aq_ring_s *self,
 			  struct aq_nic_s *aq_nic, unsigned int idx,
 			  unsigned int size, unsigned int dx_size);
+void aq_ring_hwts_rx_free(struct aq_ring_s *self);
 void aq_ring_hwts_rx_clean(struct aq_ring_s *self, struct aq_nic_s *aq_nic);
 
 unsigned int aq_ring_fill_stats_data(struct aq_ring_s *self, u64 *data);
diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index 9aeff2b37a61..64eadd320798 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -719,17 +719,25 @@ static void tsnep_xdp_xmit_flush(struct tsnep_tx *tx)
 
 static bool tsnep_xdp_xmit_back(struct tsnep_adapter *adapter,
 				struct xdp_buff *xdp,
-				struct netdev_queue *tx_nq, struct tsnep_tx *tx)
+				struct netdev_queue *tx_nq, struct tsnep_tx *tx,
+				bool zc)
 {
 	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
 	bool xmit;
+	u32 type;
 
 	if (unlikely(!xdpf))
 		return false;
 
+	/* no page pool for zero copy */
+	if (zc)
+		type = TSNEP_TX_TYPE_XDP_NDO;
+	else
+		type = TSNEP_TX_TYPE_XDP_TX;
+
 	__netif_tx_lock(tx_nq, smp_processor_id());
 
-	xmit = tsnep_xdp_xmit_frame_ring(xdpf, tx, TSNEP_TX_TYPE_XDP_TX);
+	xmit = tsnep_xdp_xmit_frame_ring(xdpf, tx, type);
 
 	/* Avoid transmit queue timeout since we share it with the slow path */
 	if (xmit)
@@ -1273,7 +1281,7 @@ static bool tsnep_xdp_run_prog(struct tsnep_rx *rx, struct bpf_prog *prog,
 	case XDP_PASS:
 		return false;
 	case XDP_TX:
-		if (!tsnep_xdp_xmit_back(rx->adapter, xdp, tx_nq, tx))
+		if (!tsnep_xdp_xmit_back(rx->adapter, xdp, tx_nq, tx, false))
 			goto out_failure;
 		*status |= TSNEP_XDP_TX;
 		return true;
@@ -1323,7 +1331,7 @@ static bool tsnep_xdp_run_prog_zc(struct tsnep_rx *rx, struct bpf_prog *prog,
 	case XDP_PASS:
 		return false;
 	case XDP_TX:
-		if (!tsnep_xdp_xmit_back(rx->adapter, xdp, tx_nq, tx))
+		if (!tsnep_xdp_xmit_back(rx->adapter, xdp, tx_nq, tx, true))
 			goto out_failure;
 		*status |= TSNEP_XDP_TX;
 		return true;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 7ca6941ea0b9..02d0b707aea5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -951,8 +951,11 @@ int otx2_sq_init(struct otx2_nic *pfvf, u16 qidx, u16 sqb_aura)
 	if (pfvf->ptp && qidx < pfvf->hw.tx_queues) {
 		err = qmem_alloc(pfvf->dev, &sq->timestamps, qset->sqe_cnt,
 				 sizeof(*sq->timestamps));
-		if (err)
+		if (err) {
+			kfree(sq->sg);
+			sq->sg = NULL;
 			return err;
+		}
 	}
 
 	sq->head = 0;
@@ -968,7 +971,14 @@ int otx2_sq_init(struct otx2_nic *pfvf, u16 qidx, u16 sqb_aura)
 	sq->stats.bytes = 0;
 	sq->stats.pkts = 0;
 
-	return pfvf->hw_ops->sq_aq_init(pfvf, qidx, sqb_aura);
+	err = pfvf->hw_ops->sq_aq_init(pfvf, qidx, sqb_aura);
+	if (err) {
+		kfree(sq->sg);
+		sq->sg = NULL;
+		return err;
+	}
+
+	return 0;
 
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index e3f650e88f82..588e44d57f29 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -216,6 +216,7 @@ struct stmmac_safety_stats {
 	unsigned long mac_errors[32];
 	unsigned long mtl_errors[32];
 	unsigned long dma_errors[32];
+	unsigned long dma_dpp_errors[32];
 };
 
 /* Number of fields in Safety Stats */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index a4e8b498dea9..17394847476f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -319,6 +319,8 @@
 #define XGMAC_RXCEIE			BIT(4)
 #define XGMAC_TXCEIE			BIT(0)
 #define XGMAC_MTL_ECC_INT_STATUS	0x000010cc
+#define XGMAC_MTL_DPP_CONTROL		0x000010e0
+#define XGMAC_DPP_DISABLE		BIT(0)
 #define XGMAC_MTL_TXQ_OPMODE(x)		(0x00001100 + (0x80 * (x)))
 #define XGMAC_TQS			GENMASK(25, 16)
 #define XGMAC_TQS_SHIFT			16
@@ -401,6 +403,7 @@
 #define XGMAC_DCEIE			BIT(1)
 #define XGMAC_TCEIE			BIT(0)
 #define XGMAC_DMA_ECC_INT_STATUS	0x0000306c
+#define XGMAC_DMA_DPP_INT_STATUS	0x00003074
 #define XGMAC_DMA_CH_CONTROL(x)		(0x00003100 + (0x80 * (x)))
 #define XGMAC_SPH			BIT(24)
 #define XGMAC_PBLx8			BIT(16)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index a74e71db79f9..b5509f244ecd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -830,6 +830,44 @@ static const struct dwxgmac3_error_desc dwxgmac3_dma_errors[32]= {
 	{ false, "UNKNOWN", "Unknown Error" }, /* 31 */
 };
 
+#define DPP_RX_ERR "Read Rx Descriptor Parity checker Error"
+#define DPP_TX_ERR "Read Tx Descriptor Parity checker Error"
+
+static const struct dwxgmac3_error_desc dwxgmac3_dma_dpp_errors[32] = {
+	{ true, "TDPES0", DPP_TX_ERR },
+	{ true, "TDPES1", DPP_TX_ERR },
+	{ true, "TDPES2", DPP_TX_ERR },
+	{ true, "TDPES3", DPP_TX_ERR },
+	{ true, "TDPES4", DPP_TX_ERR },
+	{ true, "TDPES5", DPP_TX_ERR },
+	{ true, "TDPES6", DPP_TX_ERR },
+	{ true, "TDPES7", DPP_TX_ERR },
+	{ true, "TDPES8", DPP_TX_ERR },
+	{ true, "TDPES9", DPP_TX_ERR },
+	{ true, "TDPES10", DPP_TX_ERR },
+	{ true, "TDPES11", DPP_TX_ERR },
+	{ true, "TDPES12", DPP_TX_ERR },
+	{ true, "TDPES13", DPP_TX_ERR },
+	{ true, "TDPES14", DPP_TX_ERR },
+	{ true, "TDPES15", DPP_TX_ERR },
+	{ true, "RDPES0", DPP_RX_ERR },
+	{ true, "RDPES1", DPP_RX_ERR },
+	{ true, "RDPES2", DPP_RX_ERR },
+	{ true, "RDPES3", DPP_RX_ERR },
+	{ true, "RDPES4", DPP_RX_ERR },
+	{ true, "RDPES5", DPP_RX_ERR },
+	{ true, "RDPES6", DPP_RX_ERR },
+	{ true, "RDPES7", DPP_RX_ERR },
+	{ true, "RDPES8", DPP_RX_ERR },
+	{ true, "RDPES9", DPP_RX_ERR },
+	{ true, "RDPES10", DPP_RX_ERR },
+	{ true, "RDPES11", DPP_RX_ERR },
+	{ true, "RDPES12", DPP_RX_ERR },
+	{ true, "RDPES13", DPP_RX_ERR },
+	{ true, "RDPES14", DPP_RX_ERR },
+	{ true, "RDPES15", DPP_RX_ERR },
+};
+
 static void dwxgmac3_handle_dma_err(struct net_device *ndev,
 				    void __iomem *ioaddr, bool correctable,
 				    struct stmmac_safety_stats *stats)
@@ -841,6 +879,13 @@ static void dwxgmac3_handle_dma_err(struct net_device *ndev,
 
 	dwxgmac3_log_error(ndev, value, correctable, "DMA",
 			   dwxgmac3_dma_errors, STAT_OFF(dma_errors), stats);
+
+	value = readl(ioaddr + XGMAC_DMA_DPP_INT_STATUS);
+	writel(value, ioaddr + XGMAC_DMA_DPP_INT_STATUS);
+
+	dwxgmac3_log_error(ndev, value, false, "DMA_DPP",
+			   dwxgmac3_dma_dpp_errors,
+			   STAT_OFF(dma_dpp_errors), stats);
 }
 
 static int
@@ -881,6 +926,12 @@ dwxgmac3_safety_feat_config(void __iomem *ioaddr, unsigned int asp,
 	value |= XGMAC_TMOUTEN; /* FSM Timeout Feature */
 	writel(value, ioaddr + XGMAC_MAC_FSM_CONTROL);
 
+	/* 5. Enable Data Path Parity Protection */
+	value = readl(ioaddr + XGMAC_MTL_DPP_CONTROL);
+	/* already enabled by default, explicit enable it again */
+	value &= ~XGMAC_DPP_DISABLE;
+	writel(value, ioaddr + XGMAC_MTL_DPP_CONTROL);
+
 	return 0;
 }
 
@@ -914,7 +965,11 @@ static int dwxgmac3_safety_feat_irq_status(struct net_device *ndev,
 		ret |= !corr;
 	}
 
-	err = dma & (XGMAC_DEUIS | XGMAC_DECIS);
+	/* DMA_DPP_Interrupt_Status is indicated by MCSIS bit in
+	 * DMA_Safety_Interrupt_Status, so we handle DMA Data Path
+	 * Parity Errors here
+	 */
+	err = dma & (XGMAC_DEUIS | XGMAC_DECIS | XGMAC_MCSIS);
 	corr = dma & XGMAC_DECIS;
 	if (err) {
 		dwxgmac3_handle_dma_err(ndev, ioaddr, corr, stats);
@@ -930,6 +985,7 @@ static const struct dwxgmac3_error {
 	{ dwxgmac3_mac_errors },
 	{ dwxgmac3_mtl_errors },
 	{ dwxgmac3_dma_errors },
+	{ dwxgmac3_dma_dpp_errors },
 };
 
 static int dwxgmac3_safety_feat_dump(struct stmmac_safety_stats *stats,
diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index b4d3b9cde8bd..92a7a36b93ac 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -835,14 +835,14 @@ static void nsim_dev_trap_report_work(struct work_struct *work)
 				      trap_report_dw.work);
 	nsim_dev = nsim_trap_data->nsim_dev;
 
-	/* For each running port and enabled packet trap, generate a UDP
-	 * packet with a random 5-tuple and report it.
-	 */
 	if (!devl_trylock(priv_to_devlink(nsim_dev))) {
-		schedule_delayed_work(&nsim_dev->trap_data->trap_report_dw, 0);
+		schedule_delayed_work(&nsim_dev->trap_data->trap_report_dw, 1);
 		return;
 	}
 
+	/* For each running port and enabled packet trap, generate a UDP
+	 * packet with a random 5-tuple and report it.
+	 */
 	list_for_each_entry(nsim_dev_port, &nsim_dev->port_list, list) {
 		if (!netif_running(nsim_dev_port->ns->netdev))
 			continue;
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index fbaaa8c102a1..e94a4b08fd63 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -460,6 +460,10 @@ ppp_async_ioctl(struct ppp_channel *chan, unsigned int cmd, unsigned long arg)
 	case PPPIOCSMRU:
 		if (get_user(val, p))
 			break;
+		if (val > U16_MAX) {
+			err = -EINVAL;
+			break;
+		}
 		if (val < PPP_MRU)
 			val = PPP_MRU;
 		ap->mru = val;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 667462369a32..44cea18dd20e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -3779,8 +3779,10 @@ static int brcmf_internal_escan_add_info(struct cfg80211_scan_request *req,
 		if (req->channels[i] == chan)
 			break;
 	}
-	if (i == req->n_channels)
-		req->channels[req->n_channels++] = chan;
+	if (i == req->n_channels) {
+		req->n_channels++;
+		req->channels[i] = chan;
+	}
 
 	for (i = 0; i < req->n_ssids; i++) {
 		if (req->ssids[i].ssid_len == ssid_len &&
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
index 7b18e098b125..8248c3beb18d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/debug.h
@@ -531,7 +531,7 @@ enum iwl_fw_dbg_config_cmd_type {
 }; /* LDBG_CFG_CMD_TYPE_API_E_VER_1 */
 
 /* this token disables debug asserts in the firmware */
-#define IWL_FW_DBG_CONFIG_TOKEN 0x00011301
+#define IWL_FW_DBG_CONFIG_TOKEN 0x00010001
 
 /**
  * struct iwl_fw_dbg_config_cmd - configure FW debug
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index a64600f0ed9f..586334eee056 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1586,7 +1586,8 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 	 */
 	if (vif->type == NL80211_IFTYPE_AP ||
 	    vif->type == NL80211_IFTYPE_ADHOC) {
-		iwl_mvm_vif_dbgfs_add_link(mvm, vif);
+		if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
+			iwl_mvm_vif_dbgfs_add_link(mvm, vif);
 		ret = 0;
 		goto out;
 	}
@@ -1626,7 +1627,8 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 			iwl_mvm_chandef_get_primary_80(&vif->bss_conf.chandef);
 	}
 
-	iwl_mvm_vif_dbgfs_add_link(mvm, vif);
+	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
+		iwl_mvm_vif_dbgfs_add_link(mvm, vif);
 
 	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) &&
 	    vif->type == NL80211_IFTYPE_STATION && !vif->p2p &&
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 61170173f917..893b69fc841b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -81,7 +81,8 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 		ieee80211_hw_set(mvm->hw, RX_INCLUDES_FCS);
 	}
 
-	iwl_mvm_vif_dbgfs_add_link(mvm, vif);
+	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
+		iwl_mvm_vif_dbgfs_add_link(mvm, vif);
 
 	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) &&
 	    vif->type == NL80211_IFTYPE_STATION && !vif->p2p &&
@@ -437,6 +438,9 @@ __iwl_mvm_mld_unassign_vif_chanctx(struct iwl_mvm *mvm,
 		mvmvif->ap_ibss_active = false;
 	}
 
+	iwl_mvm_link_changed(mvm, vif, link_conf,
+			     LINK_CONTEXT_MODIFY_ACTIVE, false);
+
 	if (iwl_mvm_is_esr_supported(mvm->fwrt.trans) && n_active > 1) {
 		int ret = iwl_mvm_esr_mode_inactive(mvm, vif);
 
@@ -448,9 +452,6 @@ __iwl_mvm_mld_unassign_vif_chanctx(struct iwl_mvm *mvm,
 	if (vif->type == NL80211_IFTYPE_MONITOR)
 		iwl_mvm_mld_rm_snif_sta(mvm, vif);
 
-	iwl_mvm_link_changed(mvm, vif, link_conf,
-			     LINK_CONTEXT_MODIFY_ACTIVE, false);
-
 	if (switching_chanctx)
 		return;
 	mvmvif->link[link_id]->phy_ctxt = NULL;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 60f14019f981..86149275ccb8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4107,6 +4107,7 @@ static bool nvme_ctrl_pp_status(struct nvme_ctrl *ctrl)
 static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
 {
 	struct nvme_fw_slot_info_log *log;
+	u8 next_fw_slot, cur_fw_slot;
 
 	log = kmalloc(sizeof(*log), GFP_KERNEL);
 	if (!log)
@@ -4118,13 +4119,15 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
 		goto out_free_log;
 	}
 
-	if (log->afi & 0x70 || !(log->afi & 0x7)) {
+	cur_fw_slot = log->afi & 0x7;
+	next_fw_slot = (log->afi & 0x70) >> 4;
+	if (!cur_fw_slot || (next_fw_slot && (cur_fw_slot != next_fw_slot))) {
 		dev_info(ctrl->device,
 			 "Firmware is activated after next Controller Level Reset\n");
 		goto out_free_log;
 	}
 
-	memcpy(ctrl->subsys->firmware_rev, &log->frs[(log->afi & 0x7) - 1],
+	memcpy(ctrl->subsys->firmware_rev, &log->frs[cur_fw_slot - 1],
 		sizeof(ctrl->subsys->firmware_rev));
 
 out_free_log:
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 9c2137dae429..826b5016a101 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -386,21 +386,8 @@ void pci_bus_add_devices(const struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pci_bus_add_devices);
 
-/** pci_walk_bus - walk devices on/under bus, calling callback.
- *  @top      bus whose devices should be walked
- *  @cb       callback to be called for each device found
- *  @userdata arbitrary pointer to be passed to callback.
- *
- *  Walk the given bus, including any bridged devices
- *  on buses under this bus.  Call the provided callback
- *  on each device found.
- *
- *  We check the return of @cb each time. If it returns anything
- *  other than 0, we break out.
- *
- */
-void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
-		  void *userdata)
+static void __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
+			   void *userdata, bool locked)
 {
 	struct pci_dev *dev;
 	struct pci_bus *bus;
@@ -408,7 +395,8 @@ void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 	int retval;
 
 	bus = top;
-	down_read(&pci_bus_sem);
+	if (!locked)
+		down_read(&pci_bus_sem);
 	next = top->devices.next;
 	for (;;) {
 		if (next == &bus->devices) {
@@ -431,10 +419,37 @@ void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 		if (retval)
 			break;
 	}
-	up_read(&pci_bus_sem);
+	if (!locked)
+		up_read(&pci_bus_sem);
+}
+
+/**
+ *  pci_walk_bus - walk devices on/under bus, calling callback.
+ *  @top: bus whose devices should be walked
+ *  @cb: callback to be called for each device found
+ *  @userdata: arbitrary pointer to be passed to callback
+ *
+ *  Walk the given bus, including any bridged devices
+ *  on buses under this bus.  Call the provided callback
+ *  on each device found.
+ *
+ *  We check the return of @cb each time. If it returns anything
+ *  other than 0, we break out.
+ */
+void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *), void *userdata)
+{
+	__pci_walk_bus(top, cb, userdata, false);
 }
 EXPORT_SYMBOL_GPL(pci_walk_bus);
 
+void pci_walk_bus_locked(struct pci_bus *top, int (*cb)(struct pci_dev *, void *), void *userdata)
+{
+	lockdep_assert_held(&pci_bus_sem);
+
+	__pci_walk_bus(top, cb, userdata, true);
+}
+EXPORT_SYMBOL_GPL(pci_walk_bus_locked);
+
 struct pci_bus *pci_bus_get(struct pci_bus *bus)
 {
 	if (bus)
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 11c80555d975..cbc3f0881770 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -972,7 +972,7 @@ static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
 	 * Downstream devices need to be in D0 state before enabling PCI PM
 	 * substates.
 	 */
-	pci_set_power_state(pdev, PCI_D0);
+	pci_set_power_state_locked(pdev, PCI_D0);
 	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
 
 	return 0;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index bdbf8a94b4d0..b2000b14faa0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1291,6 +1291,7 @@ int pci_power_up(struct pci_dev *dev)
 /**
  * pci_set_full_power_state - Put a PCI device into D0 and update its state
  * @dev: PCI device to power up
+ * @locked: whether pci_bus_sem is held
  *
  * Call pci_power_up() to put @dev into D0, read from its PCI_PM_CTRL register
  * to confirm the state change, restore its BARs if they might be lost and
@@ -1300,7 +1301,7 @@ int pci_power_up(struct pci_dev *dev)
  * to D0, it is more efficient to use pci_power_up() directly instead of this
  * function.
  */
-static int pci_set_full_power_state(struct pci_dev *dev)
+static int pci_set_full_power_state(struct pci_dev *dev, bool locked)
 {
 	u16 pmcsr;
 	int ret;
@@ -1336,7 +1337,7 @@ static int pci_set_full_power_state(struct pci_dev *dev)
 	}
 
 	if (dev->bus->self)
-		pcie_aspm_pm_state_change(dev->bus->self);
+		pcie_aspm_pm_state_change(dev->bus->self, locked);
 
 	return 0;
 }
@@ -1365,10 +1366,22 @@ void pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state)
 		pci_walk_bus(bus, __pci_dev_set_current_state, &state);
 }
 
+static void __pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state, bool locked)
+{
+	if (!bus)
+		return;
+
+	if (locked)
+		pci_walk_bus_locked(bus, __pci_dev_set_current_state, &state);
+	else
+		pci_walk_bus(bus, __pci_dev_set_current_state, &state);
+}
+
 /**
  * pci_set_low_power_state - Put a PCI device into a low-power state.
  * @dev: PCI device to handle.
  * @state: PCI power state (D1, D2, D3hot) to put the device into.
+ * @locked: whether pci_bus_sem is held
  *
  * Use the device's PCI_PM_CTRL register to put it into a low-power state.
  *
@@ -1379,7 +1392,7 @@ void pci_bus_set_current_state(struct pci_bus *bus, pci_power_t state)
  * 0 if device already is in the requested state.
  * 0 if device's power state has been successfully changed.
  */
-static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state)
+static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool locked)
 {
 	u16 pmcsr;
 
@@ -1433,29 +1446,12 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state)
 				     pci_power_name(state));
 
 	if (dev->bus->self)
-		pcie_aspm_pm_state_change(dev->bus->self);
+		pcie_aspm_pm_state_change(dev->bus->self, locked);
 
 	return 0;
 }
 
-/**
- * pci_set_power_state - Set the power state of a PCI device
- * @dev: PCI device to handle.
- * @state: PCI power state (D0, D1, D2, D3hot) to put the device into.
- *
- * Transition a device to a new power state, using the platform firmware and/or
- * the device's PCI PM registers.
- *
- * RETURN VALUE:
- * -EINVAL if the requested state is invalid.
- * -EIO if device does not support PCI PM or its PM capabilities register has a
- * wrong version, or device doesn't support the requested state.
- * 0 if the transition is to D1 or D2 but D1 and D2 are not supported.
- * 0 if device already is in the requested state.
- * 0 if the transition is to D3 but D3 is not supported.
- * 0 if device's power state has been successfully changed.
- */
-int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
+static int __pci_set_power_state(struct pci_dev *dev, pci_power_t state, bool locked)
 {
 	int error;
 
@@ -1479,7 +1475,7 @@ int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 		return 0;
 
 	if (state == PCI_D0)
-		return pci_set_full_power_state(dev);
+		return pci_set_full_power_state(dev, locked);
 
 	/*
 	 * This device is quirked not to be put into D3, so don't put it in
@@ -1493,16 +1489,16 @@ int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 		 * To put the device in D3cold, put it into D3hot in the native
 		 * way, then put it into D3cold using platform ops.
 		 */
-		error = pci_set_low_power_state(dev, PCI_D3hot);
+		error = pci_set_low_power_state(dev, PCI_D3hot, locked);
 
 		if (pci_platform_power_transition(dev, PCI_D3cold))
 			return error;
 
 		/* Powering off a bridge may power off the whole hierarchy */
 		if (dev->current_state == PCI_D3cold)
-			pci_bus_set_current_state(dev->subordinate, PCI_D3cold);
+			__pci_bus_set_current_state(dev->subordinate, PCI_D3cold, locked);
 	} else {
-		error = pci_set_low_power_state(dev, state);
+		error = pci_set_low_power_state(dev, state, locked);
 
 		if (pci_platform_power_transition(dev, state))
 			return error;
@@ -1510,8 +1506,38 @@ int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 
 	return 0;
 }
+
+/**
+ * pci_set_power_state - Set the power state of a PCI device
+ * @dev: PCI device to handle.
+ * @state: PCI power state (D0, D1, D2, D3hot) to put the device into.
+ *
+ * Transition a device to a new power state, using the platform firmware and/or
+ * the device's PCI PM registers.
+ *
+ * RETURN VALUE:
+ * -EINVAL if the requested state is invalid.
+ * -EIO if device does not support PCI PM or its PM capabilities register has a
+ * wrong version, or device doesn't support the requested state.
+ * 0 if the transition is to D1 or D2 but D1 and D2 are not supported.
+ * 0 if device already is in the requested state.
+ * 0 if the transition is to D3 but D3 is not supported.
+ * 0 if device's power state has been successfully changed.
+ */
+int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
+{
+	return __pci_set_power_state(dev, state, false);
+}
 EXPORT_SYMBOL(pci_set_power_state);
 
+int pci_set_power_state_locked(struct pci_dev *dev, pci_power_t state)
+{
+	lockdep_assert_held(&pci_bus_sem);
+
+	return __pci_set_power_state(dev, state, true);
+}
+EXPORT_SYMBOL(pci_set_power_state_locked);
+
 #define PCI_EXP_SAVE_REGS	7
 
 static struct pci_cap_saved_state *_pci_find_saved_cap(struct pci_dev *pci_dev,
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c6283ba78197..24ae29f0d36d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -569,12 +569,12 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt);
 #ifdef CONFIG_PCIEASPM
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
-void pcie_aspm_pm_state_change(struct pci_dev *pdev);
+void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
-static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
+static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
 #endif
 
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 060f4b3c8698..eb2c77d522cb 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1008,8 +1008,11 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 	up_read(&pci_bus_sem);
 }
 
-/* @pdev: the root port or switch downstream port */
-void pcie_aspm_pm_state_change(struct pci_dev *pdev)
+/*
+ * @pdev: the root port or switch downstream port
+ * @locked: whether pci_bus_sem is held
+ */
+void pcie_aspm_pm_state_change(struct pci_dev *pdev, bool locked)
 {
 	struct pcie_link_state *link = pdev->link_state;
 
@@ -1019,12 +1022,14 @@ void pcie_aspm_pm_state_change(struct pci_dev *pdev)
 	 * Devices changed PM state, we should recheck if latency
 	 * meets all functions' requirement
 	 */
-	down_read(&pci_bus_sem);
+	if (!locked)
+		down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
 	pcie_update_aspm_capable(link->root);
 	pcie_config_aspm_path(link);
 	mutex_unlock(&aspm_lock);
-	up_read(&pci_bus_sem);
+	if (!locked)
+		up_read(&pci_bus_sem);
 }
 
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index 02f156298e77..a3719719e2e0 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -1276,6 +1276,14 @@ static const char * const qmp_phy_vreg_l[] = {
 	"vdda-phy", "vdda-pll",
 };
 
+static const struct qmp_usb_offsets qmp_usb_offsets_ipq8074 = {
+	.serdes		= 0,
+	.pcs		= 0x800,
+	.pcs_misc	= 0x600,
+	.tx		= 0x200,
+	.rx		= 0x400,
+};
+
 static const struct qmp_usb_offsets qmp_usb_offsets_ipq9574 = {
 	.serdes		= 0,
 	.pcs		= 0x800,
@@ -1317,10 +1325,28 @@ static const struct qmp_usb_offsets qmp_usb_offsets_v5 = {
 	.rx		= 0x1000,
 };
 
+static const struct qmp_phy_cfg ipq6018_usb3phy_cfg = {
+	.lanes			= 1,
+
+	.offsets		= &qmp_usb_offsets_ipq8074,
+
+	.serdes_tbl		= ipq9574_usb3_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(ipq9574_usb3_serdes_tbl),
+	.tx_tbl			= msm8996_usb3_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(msm8996_usb3_tx_tbl),
+	.rx_tbl			= ipq8074_usb3_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(ipq8074_usb3_rx_tbl),
+	.pcs_tbl		= ipq8074_usb3_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(ipq8074_usb3_pcs_tbl),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= qmp_v3_usb3phy_regs_layout,
+};
+
 static const struct qmp_phy_cfg ipq8074_usb3phy_cfg = {
 	.lanes			= 1,
 
-	.offsets		= &qmp_usb_offsets_v3,
+	.offsets		= &qmp_usb_offsets_ipq8074,
 
 	.serdes_tbl		= ipq8074_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(ipq8074_usb3_serdes_tbl),
@@ -2225,7 +2251,7 @@ static int qmp_usb_probe(struct platform_device *pdev)
 static const struct of_device_id qmp_usb_of_match_table[] = {
 	{
 		.compatible = "qcom,ipq6018-qmp-usb3-phy",
-		.data = &ipq8074_usb3phy_cfg,
+		.data = &ipq6018_usb3phy_cfg,
 	}, {
 		.compatible = "qcom,ipq8074-qmp-usb3-phy",
 		.data = &ipq8074_usb3phy_cfg,
diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index e53eace7c91e..6387c0d34c55 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -673,8 +673,6 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 	channel->irq = platform_get_irq_optional(pdev, 0);
 	channel->dr_mode = rcar_gen3_get_dr_mode(dev->of_node);
 	if (channel->dr_mode != USB_DR_MODE_UNKNOWN) {
-		int ret;
-
 		channel->is_otg_channel = true;
 		channel->uses_otg_pins = !of_property_read_bool(dev->of_node,
 							"renesas,no-otg-pins");
@@ -738,8 +736,6 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 		ret = PTR_ERR(provider);
 		goto error;
 	} else if (channel->is_otg_channel) {
-		int ret;
-
 		ret = device_create_file(dev, &dev_attr_role);
 		if (ret < 0)
 			goto error;
diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index dd2913ac0fa2..78e19b128962 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -117,7 +117,7 @@ static int omap_usb_set_vbus(struct usb_otg *otg, bool enabled)
 {
 	struct omap_usb *phy = phy_to_omapusb(otg->usb_phy);
 
-	if (!phy->comparator)
+	if (!phy->comparator || !phy->comparator->set_vbus)
 		return -ENODEV;
 
 	return phy->comparator->set_vbus(phy->comparator, enabled);
@@ -127,7 +127,7 @@ static int omap_usb_start_srp(struct usb_otg *otg)
 {
 	struct omap_usb *phy = phy_to_omapusb(otg->usb_phy);
 
-	if (!phy->comparator)
+	if (!phy->comparator || !phy->comparator->start_srp)
 		return -ENODEV;
 
 	return phy->comparator->start_srp(phy->comparator);
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 3328b175a832..43eff1107038 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -282,11 +282,12 @@ static void scsi_eh_inc_host_failed(struct rcu_head *head)
 {
 	struct scsi_cmnd *scmd = container_of(head, typeof(*scmd), rcu);
 	struct Scsi_Host *shost = scmd->device->host;
+	unsigned int busy = scsi_host_busy(shost);
 	unsigned long flags;
 
 	spin_lock_irqsave(shost->host_lock, flags);
 	shost->host_failed++;
-	scsi_eh_wakeup(shost, scsi_host_busy(shost));
+	scsi_eh_wakeup(shost, busy);
 	spin_unlock_irqrestore(shost->host_lock, flags);
 }
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 1fb80eae9a63..df5ac03d5d6c 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -278,9 +278,11 @@ static void scsi_dec_host_busy(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
 	rcu_read_lock();
 	__clear_bit(SCMD_STATE_INFLIGHT, &cmd->state);
 	if (unlikely(scsi_host_in_recovery(shost))) {
+		unsigned int busy = scsi_host_busy(shost);
+
 		spin_lock_irqsave(shost->host_lock, flags);
 		if (shost->host_failed || shost->host_eh_scheduled)
-			scsi_eh_wakeup(shost, scsi_host_busy(shost));
+			scsi_eh_wakeup(shost, busy);
 		spin_unlock_irqrestore(shost->host_lock, flags);
 	}
 	rcu_read_unlock();
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 6604845c397c..39564e17f3b0 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -51,6 +51,8 @@
 #define PCI_DEVICE_ID_INTEL_MTLP		0x7ec1
 #define PCI_DEVICE_ID_INTEL_MTLS		0x7f6f
 #define PCI_DEVICE_ID_INTEL_MTL			0x7e7e
+#define PCI_DEVICE_ID_INTEL_ARLH		0x7ec1
+#define PCI_DEVICE_ID_INTEL_ARLH_PCH		0x777e
 #define PCI_DEVICE_ID_INTEL_TGL			0x9a15
 #define PCI_DEVICE_ID_AMD_MR			0x163a
 
@@ -421,6 +423,8 @@ static const struct pci_device_id dwc3_pci_id_table[] = {
 	{ PCI_DEVICE_DATA(INTEL, MTLP, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, MTL, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, MTLS, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, ARLH, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, ARLH_PCH, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, TGL, &dwc3_pci_intel_swnode) },
 
 	{ PCI_DEVICE_DATA(AMD, NL_USB, &dwc3_pci_amd_swnode) },
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 61f57fe5bb78..43230915323c 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -61,7 +61,7 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)
 
 int dwc3_host_init(struct dwc3 *dwc)
 {
-	struct property_entry	props[4];
+	struct property_entry	props[5];
 	struct platform_device	*xhci;
 	int			ret, irq;
 	int			prop_idx = 0;
@@ -89,6 +89,8 @@ int dwc3_host_init(struct dwc3 *dwc)
 
 	memset(props, 0, sizeof(struct property_entry) * ARRAY_SIZE(props));
 
+	props[prop_idx++] = PROPERTY_ENTRY_BOOL("xhci-sg-trb-cache-size-quirk");
+
 	if (dwc->usb3_lpm_capable)
 		props[prop_idx++] = PROPERTY_ENTRY_BOOL("usb3-lpm-capable");
 
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index f0853c4478f5..d68e9abcdc69 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -250,6 +250,9 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 		if (device_property_read_bool(tmpdev, "quirk-broken-port-ped"))
 			xhci->quirks |= XHCI_BROKEN_PORT_PED;
 
+		if (device_property_read_bool(tmpdev, "xhci-sg-trb-cache-size-quirk"))
+			xhci->quirks |= XHCI_SG_TRB_CACHE_SIZE_QUIRK;
+
 		device_property_read_u32(tmpdev, "imod-interval-ns",
 					 &xhci->imod_interval);
 	}
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index f3b5e6345858..9673354d70d5 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2375,6 +2375,9 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 	/* handle completion code */
 	switch (trb_comp_code) {
 	case COMP_SUCCESS:
+		/* Don't overwrite status if TD had an error, see xHCI 4.9.1 */
+		if (td->error_mid_td)
+			break;
 		if (remaining) {
 			frame->status = short_framestatus;
 			if (xhci->quirks & XHCI_TRUST_TX_LENGTH)
@@ -2390,9 +2393,13 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 	case COMP_BANDWIDTH_OVERRUN_ERROR:
 		frame->status = -ECOMM;
 		break;
-	case COMP_ISOCH_BUFFER_OVERRUN:
 	case COMP_BABBLE_DETECTED_ERROR:
+		sum_trbs_for_length = true;
+		fallthrough;
+	case COMP_ISOCH_BUFFER_OVERRUN:
 		frame->status = -EOVERFLOW;
+		if (ep_trb != td->last_trb)
+			td->error_mid_td = true;
 		break;
 	case COMP_INCOMPATIBLE_DEVICE_ERROR:
 	case COMP_STALL_ERROR:
@@ -2400,8 +2407,9 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		break;
 	case COMP_USB_TRANSACTION_ERROR:
 		frame->status = -EPROTO;
+		sum_trbs_for_length = true;
 		if (ep_trb != td->last_trb)
-			return 0;
+			td->error_mid_td = true;
 		break;
 	case COMP_STOPPED:
 		sum_trbs_for_length = true;
@@ -2421,6 +2429,9 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 		break;
 	}
 
+	if (td->urb_length_set)
+		goto finish_td;
+
 	if (sum_trbs_for_length)
 		frame->actual_length = sum_trb_lengths(xhci, ep->ring, ep_trb) +
 			ep_trb_len - remaining;
@@ -2429,6 +2440,14 @@ static int process_isoc_td(struct xhci_hcd *xhci, struct xhci_virt_ep *ep,
 
 	td->urb->actual_length += frame->actual_length;
 
+finish_td:
+	/* Don't give back TD yet if we encountered an error mid TD */
+	if (td->error_mid_td && ep_trb != td->last_trb) {
+		xhci_dbg(xhci, "Error mid isoc TD, wait for final completion event\n");
+		td->urb_length_set = true;
+		return 0;
+	}
+
 	return finish_td(xhci, ep, ep_ring, td, trb_comp_code);
 }
 
@@ -2807,17 +2826,51 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		}
 
 		if (!ep_seg) {
-			if (!ep->skip ||
-			    !usb_endpoint_xfer_isoc(&td->urb->ep->desc)) {
-				/* Some host controllers give a spurious
-				 * successful event after a short transfer.
-				 * Ignore it.
-				 */
-				if ((xhci->quirks & XHCI_SPURIOUS_SUCCESS) &&
-						ep_ring->last_td_was_short) {
-					ep_ring->last_td_was_short = false;
-					goto cleanup;
+
+			if (ep->skip && usb_endpoint_xfer_isoc(&td->urb->ep->desc)) {
+				skip_isoc_td(xhci, td, ep, status);
+				goto cleanup;
+			}
+
+			/*
+			 * Some hosts give a spurious success event after a short
+			 * transfer. Ignore it.
+			 */
+			if ((xhci->quirks & XHCI_SPURIOUS_SUCCESS) &&
+			    ep_ring->last_td_was_short) {
+				ep_ring->last_td_was_short = false;
+				goto cleanup;
+			}
+
+			/*
+			 * xhci 4.10.2 states isoc endpoints should continue
+			 * processing the next TD if there was an error mid TD.
+			 * So host like NEC don't generate an event for the last
+			 * isoc TRB even if the IOC flag is set.
+			 * xhci 4.9.1 states that if there are errors in mult-TRB
+			 * TDs xHC should generate an error for that TRB, and if xHC
+			 * proceeds to the next TD it should genete an event for
+			 * any TRB with IOC flag on the way. Other host follow this.
+			 * So this event might be for the next TD.
+			 */
+			if (td->error_mid_td &&
+			    !list_is_last(&td->td_list, &ep_ring->td_list)) {
+				struct xhci_td *td_next = list_next_entry(td, td_list);
+
+				ep_seg = trb_in_td(xhci, td_next->start_seg, td_next->first_trb,
+						   td_next->last_trb, ep_trb_dma, false);
+				if (ep_seg) {
+					/* give back previous TD, start handling new */
+					xhci_dbg(xhci, "Missing TD completion event after mid TD error\n");
+					ep_ring->dequeue = td->last_trb;
+					ep_ring->deq_seg = td->last_trb_seg;
+					inc_deq(xhci, ep_ring);
+					xhci_td_cleanup(xhci, td, ep_ring, td->status);
+					td = td_next;
 				}
+			}
+
+			if (!ep_seg) {
 				/* HC is busted, give up! */
 				xhci_err(xhci,
 					"ERROR Transfer event TRB DMA ptr not "
@@ -2829,9 +2882,6 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 					  ep_trb_dma, true);
 				return -ESHUTDOWN;
 			}
-
-			skip_isoc_td(xhci, td, ep, status);
-			goto cleanup;
 		}
 		if (trb_comp_code == COMP_SHORT_PACKET)
 			ep_ring->last_td_was_short = true;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 3ea5c092bba7..6f53a950d9c0 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1547,6 +1547,7 @@ struct xhci_td {
 	struct xhci_segment	*bounce_seg;
 	/* actual_length of the URB has already been set */
 	bool			urb_length_set;
+	bool			error_mid_td;
 	unsigned int		num_trbs;
 };
 
diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 1e61fe043171..923e0ed85444 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -146,6 +146,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x10C4, 0x85F8) }, /* Virtenio Preon32 */
 	{ USB_DEVICE(0x10C4, 0x8664) }, /* AC-Services CAN-IF */
 	{ USB_DEVICE(0x10C4, 0x8665) }, /* AC-Services OBD-IF */
+	{ USB_DEVICE(0x10C4, 0x87ED) }, /* IMST USB-Stick for Smart Meter */
 	{ USB_DEVICE(0x10C4, 0x8856) },	/* CEL EM357 ZigBee USB Stick - LR */
 	{ USB_DEVICE(0x10C4, 0x8857) },	/* CEL EM357 ZigBee USB Stick */
 	{ USB_DEVICE(0x10C4, 0x88A4) }, /* MMB Networks ZigBee USB Device */
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 72390dbf0769..2ae124c49d44 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2269,6 +2269,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0111, 0xff) },			/* Fibocom FM160 (MBIM mode) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a0, 0xff) },			/* Fibocom NL668-AM/NL652-EU (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a2, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a3, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a4, 0xff),			/* Fibocom FM101-GL (laptop MBIM) */
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2df3, 0x9d03, 0xff) },			/* LongSung M5710 */
diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index b1e844bf31f8..703a9c563557 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -184,6 +184,8 @@ static const struct usb_device_id id_table[] = {
 	{DEVICE_SWI(0x413c, 0x81d0)},   /* Dell Wireless 5819 */
 	{DEVICE_SWI(0x413c, 0x81d1)},   /* Dell Wireless 5818 */
 	{DEVICE_SWI(0x413c, 0x81d2)},   /* Dell Wireless 5818 */
+	{DEVICE_SWI(0x413c, 0x8217)},	/* Dell Wireless DW5826e */
+	{DEVICE_SWI(0x413c, 0x8218)},	/* Dell Wireless DW5826e QDL */
 
 	/* Huawei devices */
 	{DEVICE_HWI(0x03f0, 0x581d)},	/* HP lt4112 LTE/HSPA+ Gobi 4G Modem (Huawei me906e) */
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index bfb6f9481e87..a1487bc670f1 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4862,8 +4862,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case PORT_RESET:
 		tcpm_reset_port(port);
-		tcpm_set_cc(port, tcpm_default_state(port) == SNK_UNATTACHED ?
-			    TYPEC_CC_RD : tcpm_rp_cc(port));
+		tcpm_set_cc(port, TYPEC_CC_OPEN);
 		tcpm_set_state(port, PORT_RESET_WAIT_OFF,
 			       PD_T_ERROR_RECOVERY);
 		break;
diff --git a/fs/bcachefs/clock.c b/fs/bcachefs/clock.c
index f41889093a2c..363644451106 100644
--- a/fs/bcachefs/clock.c
+++ b/fs/bcachefs/clock.c
@@ -109,7 +109,7 @@ void bch2_kthread_io_clock_wait(struct io_clock *clock,
 	if (cpu_timeout != MAX_SCHEDULE_TIMEOUT)
 		mod_timer(&wait.cpu_timer, cpu_timeout + jiffies);
 
-	while (1) {
+	do {
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (kthread && kthread_should_stop())
 			break;
@@ -119,7 +119,7 @@ void bch2_kthread_io_clock_wait(struct io_clock *clock,
 
 		schedule();
 		try_to_freeze();
-	}
+	} while (0);
 
 	__set_current_state(TASK_RUNNING);
 	del_timer_sync(&wait.cpu_timer);
diff --git a/fs/bcachefs/fs-io.c b/fs/bcachefs/fs-io.c
index b0e8144ec550..fffa1743dfd2 100644
--- a/fs/bcachefs/fs-io.c
+++ b/fs/bcachefs/fs-io.c
@@ -79,7 +79,7 @@ void bch2_inode_flush_nocow_writes_async(struct bch_fs *c,
 			continue;
 
 		bio = container_of(bio_alloc_bioset(ca->disk_sb.bdev, 0,
-						    REQ_OP_FLUSH,
+						    REQ_OP_WRITE|REQ_PREFLUSH,
 						    GFP_KERNEL,
 						    &c->nocow_flush_bioset),
 				   struct nocow_flush, bio);
diff --git a/fs/bcachefs/fs-ioctl.c b/fs/bcachefs/fs-ioctl.c
index 14d5cc6f90d7..dbc87747eaaf 100644
--- a/fs/bcachefs/fs-ioctl.c
+++ b/fs/bcachefs/fs-ioctl.c
@@ -345,11 +345,12 @@ static long __bch2_ioctl_subvolume_create(struct bch_fs *c, struct file *filp,
 	if (arg.flags & BCH_SUBVOL_SNAPSHOT_RO)
 		create_flags |= BCH_CREATE_SNAPSHOT_RO;
 
-	/* why do we need this lock? */
-	down_read(&c->vfs_sb->s_umount);
-
-	if (arg.flags & BCH_SUBVOL_SNAPSHOT_CREATE)
+	if (arg.flags & BCH_SUBVOL_SNAPSHOT_CREATE) {
+		/* sync_inodes_sb enforce s_umount is locked */
+		down_read(&c->vfs_sb->s_umount);
 		sync_inodes_sb(c->vfs_sb);
+		up_read(&c->vfs_sb->s_umount);
+	}
 retry:
 	if (arg.src_ptr) {
 		error = user_path_at(arg.dirfd,
@@ -433,8 +434,6 @@ static long __bch2_ioctl_subvolume_create(struct bch_fs *c, struct file *filp,
 		goto retry;
 	}
 err1:
-	up_read(&c->vfs_sb->s_umount);
-
 	return error;
 }
 
@@ -451,33 +450,36 @@ static long bch2_ioctl_subvolume_create(struct bch_fs *c, struct file *filp,
 static long bch2_ioctl_subvolume_destroy(struct bch_fs *c, struct file *filp,
 				struct bch_ioctl_subvolume arg)
 {
+	const char __user *name = (void __user *)(unsigned long)arg.dst_ptr;
 	struct path path;
 	struct inode *dir;
+	struct dentry *victim;
 	int ret = 0;
 
 	if (arg.flags)
 		return -EINVAL;
 
-	ret = user_path_at(arg.dirfd,
-			(const char __user *)(unsigned long)arg.dst_ptr,
-			LOOKUP_FOLLOW, &path);
-	if (ret)
-		return ret;
+	victim = user_path_locked_at(arg.dirfd, name, &path);
+	if (IS_ERR(victim))
+		return PTR_ERR(victim);
 
-	if (path.dentry->d_sb->s_fs_info != c) {
+	dir = d_inode(path.dentry);
+	if (victim->d_sb->s_fs_info != c) {
 		ret = -EXDEV;
 		goto err;
 	}
-
-	dir = path.dentry->d_parent->d_inode;
-
-	ret = __bch2_unlink(dir, path.dentry, true);
-	if (ret)
+	if (!d_is_positive(victim)) {
+		ret = -ENOENT;
 		goto err;
-
-	fsnotify_rmdir(dir, path.dentry);
-	d_delete(path.dentry);
+	}
+	ret = __bch2_unlink(dir, victim, true);
+	if (!ret) {
+		fsnotify_rmdir(dir, victim);
+		d_delete(victim);
+	}
 err:
+	inode_unlock(dir);
+	dput(victim);
 	path_put(&path);
 	return ret;
 }
diff --git a/fs/bcachefs/journal_io.c b/fs/bcachefs/journal_io.c
index 3eb6c3f62a81..6ab756a48535 100644
--- a/fs/bcachefs/journal_io.c
+++ b/fs/bcachefs/journal_io.c
@@ -1948,7 +1948,8 @@ CLOSURE_CALLBACK(bch2_journal_write)
 			percpu_ref_get(&ca->io_ref);
 
 			bio = ca->journal.bio;
-			bio_reset(bio, ca->disk_sb.bdev, REQ_OP_FLUSH);
+			bio_reset(bio, ca->disk_sb.bdev,
+				  REQ_OP_WRITE|REQ_PREFLUSH);
 			bio->bi_end_io		= journal_write_endio;
 			bio->bi_private		= ca;
 			closure_bio_submit(bio, cl);
diff --git a/fs/bcachefs/move.c b/fs/bcachefs/move.c
index 54830ee0ed88..f3dac4511af1 100644
--- a/fs/bcachefs/move.c
+++ b/fs/bcachefs/move.c
@@ -152,7 +152,7 @@ void bch2_move_ctxt_wait_for_io(struct moving_context *ctxt)
 		atomic_read(&ctxt->write_sectors) != sectors_pending);
 }
 
-static void bch2_moving_ctxt_flush_all(struct moving_context *ctxt)
+void bch2_moving_ctxt_flush_all(struct moving_context *ctxt)
 {
 	move_ctxt_wait_event(ctxt, list_empty(&ctxt->reads));
 	bch2_trans_unlock_long(ctxt->trans);
diff --git a/fs/bcachefs/move.h b/fs/bcachefs/move.h
index 0906aa2d1de2..c5a7aed2e1ae 100644
--- a/fs/bcachefs/move.h
+++ b/fs/bcachefs/move.h
@@ -81,6 +81,7 @@ void bch2_moving_ctxt_init(struct moving_context *, struct bch_fs *,
 			   struct write_point_specifier, bool);
 struct moving_io *bch2_moving_ctxt_next_pending_write(struct moving_context *);
 void bch2_moving_ctxt_do_pending_writes(struct moving_context *);
+void bch2_moving_ctxt_flush_all(struct moving_context *);
 void bch2_move_ctxt_wait_for_io(struct moving_context *);
 int bch2_move_ratelimit(struct moving_context *);
 
diff --git a/fs/bcachefs/rebalance.c b/fs/bcachefs/rebalance.c
index 3319190b8d9c..dd6fed258100 100644
--- a/fs/bcachefs/rebalance.c
+++ b/fs/bcachefs/rebalance.c
@@ -317,8 +317,16 @@ static int do_rebalance(struct moving_context *ctxt)
 			     BTREE_ID_rebalance_work, POS_MIN,
 			     BTREE_ITER_ALL_SNAPSHOTS);
 
-	while (!bch2_move_ratelimit(ctxt) &&
-	       !kthread_wait_freezable(r->enabled)) {
+	while (!bch2_move_ratelimit(ctxt)) {
+		if (!r->enabled) {
+			bch2_moving_ctxt_flush_all(ctxt);
+			kthread_wait_freezable(r->enabled ||
+					       kthread_should_stop());
+		}
+
+		if (kthread_should_stop())
+			break;
+
 		bch2_trans_begin(trans);
 
 		ret = bkey_err(k = next_rebalance_entry(trans, &rebalance_work_iter));
@@ -348,6 +356,7 @@ static int do_rebalance(struct moving_context *ctxt)
 	    !kthread_should_stop() &&
 	    !atomic64_read(&r->work_stats.sectors_seen) &&
 	    !atomic64_read(&r->scan_stats.sectors_seen)) {
+		bch2_moving_ctxt_flush_all(ctxt);
 		bch2_trans_unlock_long(trans);
 		rebalance_wait(c);
 	}
diff --git a/fs/bcachefs/replicas.c b/fs/bcachefs/replicas.c
index 2008fe8bf706..1c4a8f5c92c6 100644
--- a/fs/bcachefs/replicas.c
+++ b/fs/bcachefs/replicas.c
@@ -9,6 +9,12 @@
 static int bch2_cpu_replicas_to_sb_replicas(struct bch_fs *,
 					    struct bch_replicas_cpu *);
 
+/* Some (buggy!) compilers don't allow memcmp to be passed as a pointer */
+static int bch2_memcmp(const void *l, const void *r, size_t size)
+{
+	return memcmp(l, r, size);
+}
+
 /* Replicas tracking - in memory: */
 
 static void verify_replicas_entry(struct bch_replicas_entry *e)
@@ -33,7 +39,7 @@ void bch2_replicas_entry_sort(struct bch_replicas_entry *e)
 
 static void bch2_cpu_replicas_sort(struct bch_replicas_cpu *r)
 {
-	eytzinger0_sort(r->entries, r->nr, r->entry_size, memcmp, NULL);
+	eytzinger0_sort(r->entries, r->nr, r->entry_size, bch2_memcmp, NULL);
 }
 
 static void bch2_replicas_entry_v0_to_text(struct printbuf *out,
@@ -833,7 +839,7 @@ static int bch2_cpu_replicas_validate(struct bch_replicas_cpu *cpu_r,
 	sort_cmp_size(cpu_r->entries,
 		      cpu_r->nr,
 		      cpu_r->entry_size,
-		      memcmp, NULL);
+		      bch2_memcmp, NULL);
 
 	for (i = 0; i < cpu_r->nr; i++) {
 		struct bch_replicas_entry *e =
diff --git a/fs/bcachefs/snapshot.c b/fs/bcachefs/snapshot.c
index 5dac038f0851..bf5d6f4e9abc 100644
--- a/fs/bcachefs/snapshot.c
+++ b/fs/bcachefs/snapshot.c
@@ -1709,5 +1709,5 @@ int bch2_snapshots_read(struct bch_fs *c)
 
 void bch2_fs_snapshots_exit(struct bch_fs *c)
 {
-	kfree(rcu_dereference_protected(c->snapshots, true));
+	kvfree(rcu_dereference_protected(c->snapshots, true));
 }
diff --git a/fs/bcachefs/util.c b/fs/bcachefs/util.c
index 84b142fcc3df..3b7c349f2665 100644
--- a/fs/bcachefs/util.c
+++ b/fs/bcachefs/util.c
@@ -362,14 +362,15 @@ static inline void bch2_time_stats_update_one(struct bch2_time_stats *stats,
 		bch2_quantiles_update(&stats->quantiles, duration);
 	}
 
-	if (time_after64(end, stats->last_event)) {
+	if (stats->last_event && time_after64(end, stats->last_event)) {
 		freq = end - stats->last_event;
 		mean_and_variance_update(&stats->freq_stats, freq);
 		mean_and_variance_weighted_update(&stats->freq_stats_weighted, freq);
 		stats->max_freq = max(stats->max_freq, freq);
 		stats->min_freq = min(stats->min_freq, freq);
-		stats->last_event = end;
 	}
+
+	stats->last_event = end;
 }
 
 static noinline void bch2_time_stats_clear_buffer(struct bch2_time_stats *stats,
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 0679240f06db..7d41c3e03476 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -78,6 +78,8 @@ struct inode *ceph_new_inode(struct inode *dir, struct dentry *dentry,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
+	inode->i_blkbits = CEPH_FSCRYPT_BLOCK_SHIFT;
+
 	if (!S_ISLNK(*mode)) {
 		err = ceph_pre_init_acls(dir, mode, as_ctx);
 		if (err < 0)
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 8408318e1d32..3c5786841c6c 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1233,6 +1233,24 @@ void ext4_mb_generate_buddy(struct super_block *sb,
 	atomic64_add(period, &sbi->s_mb_generation_time);
 }
 
+static void mb_regenerate_buddy(struct ext4_buddy *e4b)
+{
+	int count;
+	int order = 1;
+	void *buddy;
+
+	while ((buddy = mb_find_buddy(e4b, order++, &count)))
+		mb_set_bits(buddy, 0, count);
+
+	e4b->bd_info->bb_fragments = 0;
+	memset(e4b->bd_info->bb_counters, 0,
+		sizeof(*e4b->bd_info->bb_counters) *
+		(e4b->bd_sb->s_blocksize_bits + 2));
+
+	ext4_mb_generate_buddy(e4b->bd_sb, e4b->bd_buddy,
+		e4b->bd_bitmap, e4b->bd_group, e4b->bd_info);
+}
+
 /* The buddy information is attached the buddy cache inode
  * for convenience. The information regarding each group
  * is loaded via ext4_mb_load_buddy. The information involve
@@ -1921,6 +1939,8 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 			ext4_mark_group_bitmap_corrupted(
 				sb, e4b->bd_group,
 				EXT4_GROUP_INFO_BBITMAP_CORRUPT);
+		} else {
+			mb_regenerate_buddy(e4b);
 		}
 		goto done;
 	}
diff --git a/fs/namei.c b/fs/namei.c
index 29bafbdb44ca..c981dec3c582 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2573,13 +2573,13 @@ static int filename_parentat(int dfd, struct filename *name,
 }
 
 /* does lookup, returns the object with parent locked */
-static struct dentry *__kern_path_locked(struct filename *name, struct path *path)
+static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct path *path)
 {
 	struct dentry *d;
 	struct qstr last;
 	int type, error;
 
-	error = filename_parentat(AT_FDCWD, name, 0, path, &last, &type);
+	error = filename_parentat(dfd, name, 0, path, &last, &type);
 	if (error)
 		return ERR_PTR(error);
 	if (unlikely(type != LAST_NORM)) {
@@ -2598,12 +2598,22 @@ static struct dentry *__kern_path_locked(struct filename *name, struct path *pat
 struct dentry *kern_path_locked(const char *name, struct path *path)
 {
 	struct filename *filename = getname_kernel(name);
-	struct dentry *res = __kern_path_locked(filename, path);
+	struct dentry *res = __kern_path_locked(AT_FDCWD, filename, path);
 
 	putname(filename);
 	return res;
 }
 
+struct dentry *user_path_locked_at(int dfd, const char __user *name, struct path *path)
+{
+	struct filename *filename = getname(name);
+	struct dentry *res = __kern_path_locked(dfd, filename, path);
+
+	putname(filename);
+	return res;
+}
+EXPORT_SYMBOL(user_path_locked_at);
+
 int kern_path(const char *name, unsigned int flags, struct path *path)
 {
 	struct filename *filename = getname_kernel(name);
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index f6706143d14b..a46d30b84bf3 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -473,7 +473,7 @@ bool al_delete_le(struct ntfs_inode *ni, enum ATTR_TYPE type, CLST vcn,
 int al_update(struct ntfs_inode *ni, int sync);
 static inline size_t al_aligned(size_t size)
 {
-	return (size + 1023) & ~(size_t)1023;
+	return size_add(size, 1023) & ~(size_t)1023;
 }
 
 /* Globals from bitfunc.c */
diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
index a16e175731eb..a1b973456471 100644
--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -269,6 +269,8 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
 					 &iface->sockaddr,
 					 rc);
 				kref_put(&iface->refcount, release_iface);
+				/* failure to add chan should increase weight */
+				iface->weight_fulfilled++;
 				continue;
 			}
 
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index f5006aa97f5b..5d9c87d2e1e0 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -410,7 +410,7 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 		rc = SMB3_request_interfaces(xid, tcon, false);
 		free_xid(xid);
 
-		if (rc == -EOPNOTSUPP) {
+		if (rc == -EOPNOTSUPP && ses->chan_count > 1) {
 			/*
 			 * some servers like Azure SMB server do not advertise
 			 * that multichannel has been disabled with server
diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
index 84ec53ccc450..7ee8a179d103 100644
--- a/include/asm-generic/cacheflush.h
+++ b/include/asm-generic/cacheflush.h
@@ -91,6 +91,12 @@ static inline void flush_cache_vmap(unsigned long start, unsigned long end)
 }
 #endif
 
+#ifndef flush_cache_vmap_early
+static inline void flush_cache_vmap_early(unsigned long start, unsigned long end)
+{
+}
+#endif
+
 #ifndef flush_cache_vunmap
 static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
 {
diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 2eaaabbe98cb..1717cc57cdac 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -283,7 +283,7 @@ struct ceph_msg {
 	struct kref kref;
 	bool more_to_follow;
 	bool needs_out_seq;
-	bool sparse_read;
+	u64 sparse_read_total;
 	int front_alloc_len;
 
 	struct ceph_msgpool *pool;
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 3df70d6131c8..752dbde4cec1 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -953,7 +953,8 @@ static inline int dmaengine_slave_config(struct dma_chan *chan,
 
 static inline bool is_slave_direction(enum dma_transfer_direction direction)
 {
-	return (direction == DMA_MEM_TO_DEV) || (direction == DMA_DEV_TO_MEM);
+	return (direction == DMA_MEM_TO_DEV) || (direction == DMA_DEV_TO_MEM) ||
+	       (direction == DMA_DEV_TO_DEV);
 }
 
 static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index f2044d5a652b..254d4a898179 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -197,6 +197,7 @@ enum  hrtimer_base_type {
  * @max_hang_time:	Maximum time spent in hrtimer_interrupt
  * @softirq_expiry_lock: Lock which is taken while softirq based hrtimer are
  *			 expired
+ * @online:		CPU is online from an hrtimers point of view
  * @timer_waiters:	A hrtimer_cancel() invocation waits for the timer
  *			callback to finish.
  * @expires_next:	absolute time of the next event, is required for remote
@@ -219,7 +220,8 @@ struct hrtimer_cpu_base {
 	unsigned int			hres_active		: 1,
 					in_hrtirq		: 1,
 					hang_detected		: 1,
-					softirq_activated       : 1;
+					softirq_activated       : 1,
+					online			: 1;
 #ifdef CONFIG_HIGH_RES_TIMERS
 	unsigned int			nr_events;
 	unsigned short			nr_retries;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 3100371b5e32..74e0cc14ebf8 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -66,6 +66,7 @@ extern struct dentry *kern_path_create(int, const char *, struct path *, unsigne
 extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
 extern void done_path_create(struct path *, struct dentry *);
 extern struct dentry *kern_path_locked(const char *, struct path *);
+extern struct dentry *user_path_locked_at(int , const char __user *, struct path *);
 int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
 			   struct path *parent, struct qstr *last, int *type,
 			   const struct path *root);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index bc80960fad7c..675937a5bd7c 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1417,6 +1417,7 @@ int pci_load_and_free_saved_state(struct pci_dev *dev,
 				  struct pci_saved_state **state);
 int pci_platform_power_transition(struct pci_dev *dev, pci_power_t state);
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
+int pci_set_power_state_locked(struct pci_dev *dev, pci_power_t state);
 pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state);
 bool pci_pme_capable(struct pci_dev *dev, pci_power_t state);
 void pci_pme_active(struct pci_dev *dev, bool enable);
@@ -1620,6 +1621,8 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max,
 
 void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
 		  void *userdata);
+void pci_walk_bus_locked(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
+			 void *userdata);
 int pci_cfg_space_size(struct pci_dev *dev);
 unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 void pci_setup_bridge(struct pci_bus *bus);
@@ -2019,6 +2022,8 @@ static inline int pci_save_state(struct pci_dev *dev) { return 0; }
 static inline void pci_restore_state(struct pci_dev *dev) { }
 static inline int pci_set_power_state(struct pci_dev *dev, pci_power_t state)
 { return 0; }
+static inline int pci_set_power_state_locked(struct pci_dev *dev, pci_power_t state)
+{ return 0; }
 static inline int pci_wake_from_d3(struct pci_dev *dev, bool enable)
 { return 0; }
 static inline pci_power_t pci_choose_state(struct pci_dev *dev,
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4ecfb06c413d..8f2c48761833 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2865,6 +2865,8 @@ struct cfg80211_bss_ies {
  *	own the beacon_ies, but they're just pointers to the ones from the
  *	@hidden_beacon_bss struct)
  * @proberesp_ies: the information elements from the last Probe Response frame
+ * @proberesp_ecsa_stuck: ECSA element is stuck in the Probe Response frame,
+ *	cannot rely on it having valid data
  * @hidden_beacon_bss: in case this BSS struct represents a probe response from
  *	a BSS that hides the SSID in its beacon, this points to the BSS struct
  *	that holds the beacon data. @beacon_ies is still valid, of course, and
@@ -2900,6 +2902,8 @@ struct cfg80211_bss {
 	u8 chains;
 	s8 chain_signal[IEEE80211_MAX_CHAINS];
 
+	u8 proberesp_ecsa_stuck:1;
+
 	u8 bssid_index;
 	u8 max_bssid_indicator;
 
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 4e8ecabc5f25..62013d018411 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -798,10 +798,16 @@ static inline struct nft_set_elem_expr *nft_set_ext_expr(const struct nft_set_ex
 	return nft_set_ext(ext, NFT_SET_EXT_EXPRESSIONS);
 }
 
-static inline bool nft_set_elem_expired(const struct nft_set_ext *ext)
+static inline bool __nft_set_elem_expired(const struct nft_set_ext *ext,
+					  u64 tstamp)
 {
 	return nft_set_ext_exists(ext, NFT_SET_EXT_EXPIRATION) &&
-	       time_is_before_eq_jiffies64(*nft_set_ext_expiration(ext));
+	       time_after_eq64(tstamp, *nft_set_ext_expiration(ext));
+}
+
+static inline bool nft_set_elem_expired(const struct nft_set_ext *ext)
+{
+	return __nft_set_elem_expired(ext, get_jiffies_64());
 }
 
 static inline struct nft_set_ext *nft_set_elem_ext(const struct nft_set *set,
@@ -1750,6 +1756,7 @@ struct nftables_pernet {
 	struct list_head	notify_list;
 	struct mutex		commit_mutex;
 	u64			table_handle;
+	u64			tstamp;
 	unsigned int		base_seq;
 	unsigned int		gc_seq;
 	u8			validate_state;
@@ -1762,6 +1769,11 @@ static inline struct nftables_pernet *nft_pernet(const struct net *net)
 	return net_generic(net, nf_tables_net_id);
 }
 
+static inline u64 nft_net_tstamp(const struct net *net)
+{
+	return nft_pernet(net)->tstamp;
+}
+
 #define __NFT_REDUCE_READONLY	1UL
 #define NFT_REDUCE_READONLY	(void *)__NFT_REDUCE_READONLY
 
diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 4c1ef7b3705c..87b8de9b6c1c 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -128,6 +128,7 @@
 	EM(rxrpc_skb_eaten_by_unshare_nomem,	"ETN unshar-nm") \
 	EM(rxrpc_skb_get_conn_secured,		"GET conn-secd") \
 	EM(rxrpc_skb_get_conn_work,		"GET conn-work") \
+	EM(rxrpc_skb_get_last_nack,		"GET last-nack") \
 	EM(rxrpc_skb_get_local_work,		"GET locl-work") \
 	EM(rxrpc_skb_get_reject_work,		"GET rej-work ") \
 	EM(rxrpc_skb_get_to_recvmsg,		"GET to-recv  ") \
@@ -141,6 +142,7 @@
 	EM(rxrpc_skb_put_error_report,		"PUT error-rep") \
 	EM(rxrpc_skb_put_input,			"PUT input    ") \
 	EM(rxrpc_skb_put_jumbo_subpacket,	"PUT jumbo-sub") \
+	EM(rxrpc_skb_put_last_nack,		"PUT last-nack") \
 	EM(rxrpc_skb_put_purge,			"PUT purge    ") \
 	EM(rxrpc_skb_put_rotate,		"PUT rotate   ") \
 	EM(rxrpc_skb_put_unknown,		"PUT unknown  ") \
@@ -1552,7 +1554,7 @@ TRACE_EVENT(rxrpc_congest,
 		    memcpy(&__entry->sum, summary, sizeof(__entry->sum));
 			   ),
 
-	    TP_printk("c=%08x r=%08x %s q=%08x %s cw=%u ss=%u nA=%u,%u+%u r=%u b=%u u=%u d=%u l=%x%s%s%s",
+	    TP_printk("c=%08x r=%08x %s q=%08x %s cw=%u ss=%u nA=%u,%u+%u,%u b=%u u=%u d=%u l=%x%s%s%s",
 		      __entry->call,
 		      __entry->ack_serial,
 		      __print_symbolic(__entry->sum.ack_reason, rxrpc_ack_names),
@@ -1560,9 +1562,9 @@ TRACE_EVENT(rxrpc_congest,
 		      __print_symbolic(__entry->sum.mode, rxrpc_congest_modes),
 		      __entry->sum.cwnd,
 		      __entry->sum.ssthresh,
-		      __entry->sum.nr_acks, __entry->sum.saw_nacks,
+		      __entry->sum.nr_acks, __entry->sum.nr_retained_nacks,
 		      __entry->sum.nr_new_acks,
-		      __entry->sum.nr_rot_new_acks,
+		      __entry->sum.nr_new_nacks,
 		      __entry->top - __entry->hard_ack,
 		      __entry->sum.cumulative_acks,
 		      __entry->sum.dup_acks,
diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index ca30232b7bc8..117c6a9b845b 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -285,9 +285,11 @@ enum nft_rule_attributes {
 /**
  * enum nft_rule_compat_flags - nf_tables rule compat flags
  *
+ * @NFT_RULE_COMPAT_F_UNUSED: unused
  * @NFT_RULE_COMPAT_F_INV: invert the check result
  */
 enum nft_rule_compat_flags {
+	NFT_RULE_COMPAT_F_UNUSED = (1 << 0),
 	NFT_RULE_COMPAT_F_INV	= (1 << 1),
 	NFT_RULE_COMPAT_F_MASK	= NFT_RULE_COMPAT_F_INV,
 };
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index ed84f2737b3a..c9992cd7f138 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -30,6 +30,13 @@ enum {
 	IOU_OK			= 0,
 	IOU_ISSUE_SKIP_COMPLETE	= -EIOCBQUEUED,
 
+	/*
+	 * Requeue the task_work to restart operations on this request. The
+	 * actual value isn't important, should just be not an otherwise
+	 * valid error code, yet less than -MAX_ERRNO and valid internally.
+	 */
+	IOU_REQUEUE		= -3072,
+
 	/*
 	 * Intended only when both IO_URING_F_MULTISHOT is passed
 	 * to indicate to the poll runner that multishot should be
diff --git a/io_uring/net.c b/io_uring/net.c
index 75d494dad7e2..43bc9a5f96f9 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -60,6 +60,7 @@ struct io_sr_msg {
 	unsigned			len;
 	unsigned			done_io;
 	unsigned			msg_flags;
+	unsigned			nr_multishot_loops;
 	u16				flags;
 	/* initialised and used only by !msg send variants */
 	u16				addr_len;
@@ -70,6 +71,13 @@ struct io_sr_msg {
 	struct io_kiocb 		*notif;
 };
 
+/*
+ * Number of times we'll try and do receives if there's more data. If we
+ * exceed this limit, then add us to the back of the queue and retry from
+ * there. This helps fairness between flooding clients.
+ */
+#define MULTISHOT_MAX_RETRY	32
+
 static inline bool io_check_multishot(struct io_kiocb *req,
 				      unsigned int issue_flags)
 {
@@ -611,6 +619,7 @@ int io_recvmsg_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		sr->msg_flags |= MSG_CMSG_COMPAT;
 #endif
 	sr->done_io = 0;
+	sr->nr_multishot_loops = 0;
 	return 0;
 }
 
@@ -645,23 +654,35 @@ static inline bool io_recv_finish(struct io_kiocb *req, int *ret,
 		return true;
 	}
 
-	if (!mshot_finished) {
-		if (io_fill_cqe_req_aux(req, issue_flags & IO_URING_F_COMPLETE_DEFER,
-					*ret, cflags | IORING_CQE_F_MORE)) {
-			io_recv_prep_retry(req);
-			/* Known not-empty or unknown state, retry */
-			if (cflags & IORING_CQE_F_SOCK_NONEMPTY ||
-			    msg->msg_inq == -1)
+	if (mshot_finished)
+		goto finish;
+
+	/*
+	 * Fill CQE for this receive and see if we should keep trying to
+	 * receive from this socket.
+	 */
+	if (io_fill_cqe_req_aux(req, issue_flags & IO_URING_F_COMPLETE_DEFER,
+				*ret, cflags | IORING_CQE_F_MORE)) {
+		struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
+		int mshot_retry_ret = IOU_ISSUE_SKIP_COMPLETE;
+
+		io_recv_prep_retry(req);
+		/* Known not-empty or unknown state, retry */
+		if (cflags & IORING_CQE_F_SOCK_NONEMPTY || msg->msg_inq == -1) {
+			if (sr->nr_multishot_loops++ < MULTISHOT_MAX_RETRY)
 				return false;
-			if (issue_flags & IO_URING_F_MULTISHOT)
-				*ret = IOU_ISSUE_SKIP_COMPLETE;
-			else
-				*ret = -EAGAIN;
-			return true;
+			/* mshot retries exceeded, force a requeue */
+			sr->nr_multishot_loops = 0;
+			mshot_retry_ret = IOU_REQUEUE;
 		}
-		/* Otherwise stop multishot but use the current result. */
+		if (issue_flags & IO_URING_F_MULTISHOT)
+			*ret = mshot_retry_ret;
+		else
+			*ret = -EAGAIN;
+		return true;
 	}
-
+	/* Otherwise stop multishot but use the current result. */
+finish:
 	io_req_set_res(req, *ret, cflags);
 
 	if (issue_flags & IO_URING_F_MULTISHOT)
@@ -902,6 +923,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 		if (!buf)
 			return -ENOBUFS;
 		sr->buf = buf;
+		sr->len = len;
 	}
 
 	ret = import_ubuf(ITER_DEST, sr->buf, len, &msg.msg_iter);
diff --git a/io_uring/poll.c b/io_uring/poll.c
index d59b74a99d4e..7513afc7b702 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -226,8 +226,29 @@ enum {
 	IOU_POLL_NO_ACTION = 1,
 	IOU_POLL_REMOVE_POLL_USE_RES = 2,
 	IOU_POLL_REISSUE = 3,
+	IOU_POLL_REQUEUE = 4,
 };
 
+static void __io_poll_execute(struct io_kiocb *req, int mask)
+{
+	unsigned flags = 0;
+
+	io_req_set_res(req, mask, 0);
+	req->io_task_work.func = io_poll_task_func;
+
+	trace_io_uring_task_add(req, mask);
+
+	if (!(req->flags & REQ_F_POLL_NO_LAZY))
+		flags = IOU_F_TWQ_LAZY_WAKE;
+	__io_req_task_work_add(req, flags);
+}
+
+static inline void io_poll_execute(struct io_kiocb *req, int res)
+{
+	if (io_poll_get_ownership(req))
+		__io_poll_execute(req, res);
+}
+
 /*
  * All poll tw should go through this. Checks for poll events, manages
  * references, does rewait, etc.
@@ -309,6 +330,8 @@ static int io_poll_check_events(struct io_kiocb *req, struct io_tw_state *ts)
 			int ret = io_poll_issue(req, ts);
 			if (ret == IOU_STOP_MULTISHOT)
 				return IOU_POLL_REMOVE_POLL_USE_RES;
+			else if (ret == IOU_REQUEUE)
+				return IOU_POLL_REQUEUE;
 			if (ret < 0)
 				return ret;
 		}
@@ -331,8 +354,12 @@ void io_poll_task_func(struct io_kiocb *req, struct io_tw_state *ts)
 	int ret;
 
 	ret = io_poll_check_events(req, ts);
-	if (ret == IOU_POLL_NO_ACTION)
+	if (ret == IOU_POLL_NO_ACTION) {
+		return;
+	} else if (ret == IOU_POLL_REQUEUE) {
+		__io_poll_execute(req, 0);
 		return;
+	}
 	io_poll_remove_entries(req);
 	io_poll_tw_hash_eject(req, ts);
 
@@ -364,26 +391,6 @@ void io_poll_task_func(struct io_kiocb *req, struct io_tw_state *ts)
 	}
 }
 
-static void __io_poll_execute(struct io_kiocb *req, int mask)
-{
-	unsigned flags = 0;
-
-	io_req_set_res(req, mask, 0);
-	req->io_task_work.func = io_poll_task_func;
-
-	trace_io_uring_task_add(req, mask);
-
-	if (!(req->flags & REQ_F_POLL_NO_LAZY))
-		flags = IOU_F_TWQ_LAZY_WAKE;
-	__io_req_task_work_add(req, flags);
-}
-
-static inline void io_poll_execute(struct io_kiocb *req, int res)
-{
-	if (io_poll_get_ownership(req))
-		__io_poll_execute(req, res);
-}
-
 static void io_poll_cancel_req(struct io_kiocb *req)
 {
 	io_poll_mark_cancelled(req);
diff --git a/io_uring/poll.h b/io_uring/poll.h
index ff4d5d753387..1dacae9e816c 100644
--- a/io_uring/poll.h
+++ b/io_uring/poll.h
@@ -24,6 +24,15 @@ struct async_poll {
 	struct io_poll		*double_poll;
 };
 
+/*
+ * Must only be called inside issue_flags & IO_URING_F_MULTISHOT, or
+ * potentially other cases where we already "own" this poll request.
+ */
+static inline void io_poll_multishot_retry(struct io_kiocb *req)
+{
+	atomic_inc(&req->poll_refs);
+}
+
 int io_poll_add_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_poll_add(struct io_kiocb *req, unsigned int issue_flags);
 
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 743732fba7a4..9394bf83e835 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -18,6 +18,7 @@
 #include "opdef.h"
 #include "kbuf.h"
 #include "rsrc.h"
+#include "poll.h"
 #include "rw.h"
 
 struct io_rw {
@@ -956,8 +957,15 @@ int io_read_mshot(struct io_kiocb *req, unsigned int issue_flags)
 		if (io_fill_cqe_req_aux(req,
 					issue_flags & IO_URING_F_COMPLETE_DEFER,
 					ret, cflags | IORING_CQE_F_MORE)) {
-			if (issue_flags & IO_URING_F_MULTISHOT)
+			if (issue_flags & IO_URING_F_MULTISHOT) {
+				/*
+				 * Force retry, as we might have more data to
+				 * be read and otherwise it won't get retried
+				 * until (if ever) another poll is triggered.
+				 */
+				io_poll_multishot_retry(req);
 				return IOU_ISSUE_SKIP_COMPLETE;
+			}
 			return -EAGAIN;
 		}
 	}
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 760793998cdd..edb0f821dcea 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1085,6 +1085,7 @@ static int enqueue_hrtimer(struct hrtimer *timer,
 			   enum hrtimer_mode mode)
 {
 	debug_activate(timer, mode);
+	WARN_ON_ONCE(!base->cpu_base->online);
 
 	base->cpu_base->active_bases |= 1 << base->index;
 
@@ -2183,6 +2184,7 @@ int hrtimers_prepare_cpu(unsigned int cpu)
 	cpu_base->softirq_next_timer = NULL;
 	cpu_base->expires_next = KTIME_MAX;
 	cpu_base->softirq_expires_next = KTIME_MAX;
+	cpu_base->online = 1;
 	hrtimer_cpu_base_init_expiry_lock(cpu_base);
 	return 0;
 }
@@ -2250,6 +2252,7 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
 	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
 
 	raw_spin_unlock(&new_base->lock);
+	old_base->online = 0;
 	raw_spin_unlock(&old_base->lock);
 
 	return 0;
diff --git a/mm/percpu.c b/mm/percpu.c
index 7b97d31df767..4e11fc1e6def 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3333,13 +3333,7 @@ int __init pcpu_page_first_chunk(size_t reserved_size, pcpu_fc_cpu_to_node_fn_t
 		if (rc < 0)
 			panic("failed to map percpu area, err=%d\n", rc);
 
-		/*
-		 * FIXME: Archs with virtual cache should flush local
-		 * cache for the linear mapping here - something
-		 * equivalent to flush_cache_vmap() on the local cpu.
-		 * flush_cache_vmap() can't be used as most supporting
-		 * data structures are not set up yet.
-		 */
+		flush_cache_vmap_early(unit_addr, unit_addr + ai->unit_size);
 
 		/* copy static data */
 		memcpy((void *)unit_addr, __per_cpu_load, ai->static_size);
diff --git a/net/ceph/messenger_v1.c b/net/ceph/messenger_v1.c
index f9a50d7f0d20..0cb61c76b9b8 100644
--- a/net/ceph/messenger_v1.c
+++ b/net/ceph/messenger_v1.c
@@ -160,8 +160,9 @@ static size_t sizeof_footer(struct ceph_connection *con)
 static void prepare_message_data(struct ceph_msg *msg, u32 data_len)
 {
 	/* Initialize data cursor if it's not a sparse read */
-	if (!msg->sparse_read)
-		ceph_msg_data_cursor_init(&msg->cursor, msg, data_len);
+	u64 len = msg->sparse_read_total ? : data_len;
+
+	ceph_msg_data_cursor_init(&msg->cursor, msg, len);
 }
 
 /*
@@ -991,7 +992,7 @@ static inline int read_partial_message_section(struct ceph_connection *con,
 	return read_partial_message_chunk(con, section, sec_len, crc);
 }
 
-static int read_sparse_msg_extent(struct ceph_connection *con, u32 *crc)
+static int read_partial_sparse_msg_extent(struct ceph_connection *con, u32 *crc)
 {
 	struct ceph_msg_data_cursor *cursor = &con->in_msg->cursor;
 	bool do_bounce = ceph_test_opt(from_msgr(con->msgr), RXBOUNCE);
@@ -1026,7 +1027,7 @@ static int read_sparse_msg_extent(struct ceph_connection *con, u32 *crc)
 	return 1;
 }
 
-static int read_sparse_msg_data(struct ceph_connection *con)
+static int read_partial_sparse_msg_data(struct ceph_connection *con)
 {
 	struct ceph_msg_data_cursor *cursor = &con->in_msg->cursor;
 	bool do_datacrc = !ceph_test_opt(from_msgr(con->msgr), NOCRC);
@@ -1036,31 +1037,31 @@ static int read_sparse_msg_data(struct ceph_connection *con)
 	if (do_datacrc)
 		crc = con->in_data_crc;
 
-	do {
+	while (cursor->total_resid) {
 		if (con->v1.in_sr_kvec.iov_base)
 			ret = read_partial_message_chunk(con,
 							 &con->v1.in_sr_kvec,
 							 con->v1.in_sr_len,
 							 &crc);
 		else if (cursor->sr_resid > 0)
-			ret = read_sparse_msg_extent(con, &crc);
-
-		if (ret <= 0) {
-			if (do_datacrc)
-				con->in_data_crc = crc;
-			return ret;
-		}
+			ret = read_partial_sparse_msg_extent(con, &crc);
+		if (ret <= 0)
+			break;
 
 		memset(&con->v1.in_sr_kvec, 0, sizeof(con->v1.in_sr_kvec));
 		ret = con->ops->sparse_read(con, cursor,
 				(char **)&con->v1.in_sr_kvec.iov_base);
+		if (ret <= 0) {
+			ret = ret ? ret : 1;  /* must return > 0 to indicate success */
+			break;
+		}
 		con->v1.in_sr_len = ret;
-	} while (ret > 0);
+	}
 
 	if (do_datacrc)
 		con->in_data_crc = crc;
 
-	return ret < 0 ? ret : 1;  /* must return > 0 to indicate success */
+	return ret;
 }
 
 static int read_partial_msg_data(struct ceph_connection *con)
@@ -1253,8 +1254,8 @@ static int read_partial_message(struct ceph_connection *con)
 		if (!m->num_data_items)
 			return -EIO;
 
-		if (m->sparse_read)
-			ret = read_sparse_msg_data(con);
+		if (m->sparse_read_total)
+			ret = read_partial_sparse_msg_data(con);
 		else if (ceph_test_opt(from_msgr(con->msgr), RXBOUNCE))
 			ret = read_partial_msg_data_bounce(con);
 		else
diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index f8ec60e1aba3..a0ca5414b333 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -1128,7 +1128,7 @@ static int decrypt_tail(struct ceph_connection *con)
 	struct sg_table enc_sgt = {};
 	struct sg_table sgt = {};
 	struct page **pages = NULL;
-	bool sparse = con->in_msg->sparse_read;
+	bool sparse = !!con->in_msg->sparse_read_total;
 	int dpos = 0;
 	int tail_len;
 	int ret;
@@ -2060,7 +2060,7 @@ static int prepare_read_tail_plain(struct ceph_connection *con)
 	}
 
 	if (data_len(msg)) {
-		if (msg->sparse_read)
+		if (msg->sparse_read_total)
 			con->v2.in_state = IN_S_PREPARE_SPARSE_DATA;
 		else
 			con->v2.in_state = IN_S_PREPARE_READ_DATA;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index d3a759e052c8..8d9760397b88 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -5510,7 +5510,7 @@ static struct ceph_msg *get_reply(struct ceph_connection *con,
 	}
 
 	m = ceph_msg_get(req->r_reply);
-	m->sparse_read = (bool)srlen;
+	m->sparse_read_total = srlen;
 
 	dout("get_reply tid %lld %p\n", tid, m);
 
@@ -5777,11 +5777,8 @@ static int prep_next_sparse_read(struct ceph_connection *con,
 	}
 
 	if (o->o_sparse_op_idx < 0) {
-		u64 srlen = sparse_data_requested(req);
-
-		dout("%s: [%d] starting new sparse read req. srlen=0x%llx\n",
-		     __func__, o->o_osd, srlen);
-		ceph_msg_data_cursor_init(cursor, con->in_msg, srlen);
+		dout("%s: [%d] starting new sparse read req\n",
+		     __func__, o->o_osd);
 	} else {
 		u64 end;
 
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 103d46fa0eeb..a8b625abe242 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -751,7 +751,7 @@ size_t memcpy_to_iter_csum(void *iter_to, size_t progress,
 			   size_t len, void *from, void *priv2)
 {
 	__wsum *csum = priv2;
-	__wsum next = csum_partial_copy_nocheck(from, iter_to, len);
+	__wsum next = csum_partial_copy_nocheck(from + progress, iter_to, len);
 
 	*csum = csum_block_add(*csum, next, progress);
 	return 0;
diff --git a/net/devlink/core.c b/net/devlink/core.c
index 6984877e9f10..cbf8560c9375 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -46,7 +46,7 @@ struct devlink_rel {
 		u32 obj_index;
 		devlink_rel_notify_cb_t *notify_cb;
 		devlink_rel_cleanup_cb_t *cleanup_cb;
-		struct work_struct notify_work;
+		struct delayed_work notify_work;
 	} nested_in;
 };
 
@@ -70,7 +70,7 @@ static void __devlink_rel_put(struct devlink_rel *rel)
 static void devlink_rel_nested_in_notify_work(struct work_struct *work)
 {
 	struct devlink_rel *rel = container_of(work, struct devlink_rel,
-					       nested_in.notify_work);
+					       nested_in.notify_work.work);
 	struct devlink *devlink;
 
 	devlink = devlinks_xa_get(rel->nested_in.devlink_index);
@@ -96,13 +96,13 @@ static void devlink_rel_nested_in_notify_work(struct work_struct *work)
 	return;
 
 reschedule_work:
-	schedule_work(&rel->nested_in.notify_work);
+	schedule_delayed_work(&rel->nested_in.notify_work, 1);
 }
 
 static void devlink_rel_nested_in_notify_work_schedule(struct devlink_rel *rel)
 {
 	__devlink_rel_get(rel);
-	schedule_work(&rel->nested_in.notify_work);
+	schedule_delayed_work(&rel->nested_in.notify_work, 0);
 }
 
 static struct devlink_rel *devlink_rel_alloc(void)
@@ -123,8 +123,8 @@ static struct devlink_rel *devlink_rel_alloc(void)
 	}
 
 	refcount_set(&rel->refcount, 1);
-	INIT_WORK(&rel->nested_in.notify_work,
-		  &devlink_rel_nested_in_notify_work);
+	INIT_DELAYED_WORK(&rel->nested_in.notify_work,
+			  &devlink_rel_nested_in_notify_work);
 	return rel;
 }
 
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 1c58bd72e124..e59962f34caa 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1628,10 +1628,12 @@ EXPORT_SYMBOL(inet_current_timestamp);
 
 int inet_recv_error(struct sock *sk, struct msghdr *msg, int len, int *addr_len)
 {
-	if (sk->sk_family == AF_INET)
+	unsigned int family = READ_ONCE(sk->sk_family);
+
+	if (family == AF_INET)
 		return ip_recv_error(sk, msg, len, addr_len);
 #if IS_ENABLED(CONFIG_IPV6)
-	if (sk->sk_family == AF_INET6)
+	if (family == AF_INET6)
 		return pingv6_ops.ipv6_recv_error(sk, msg, len, addr_len);
 #endif
 	return -EINVAL;
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 586b1b3e35b8..80ccd6661aa3 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -332,7 +332,7 @@ static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
 	};
 	skb_reset_network_header(skb);
 
-	csum = csum_partial(icmp6h, len, 0);
+	csum = skb_checksum(skb, skb_transport_offset(skb), len, 0);
 	icmp6h->icmp6_cksum = csum_ipv6_magic(&nip6h->saddr, &nip6h->daddr, len,
 					      IPPROTO_ICMPV6, csum);
 
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index eb1d3ef84353..bfb06dea43c2 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2015  Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -987,7 +987,8 @@ static int
 ieee80211_set_unsol_bcast_probe_resp(struct ieee80211_sub_if_data *sdata,
 				     struct cfg80211_unsol_bcast_probe_resp *params,
 				     struct ieee80211_link_data *link,
-				     struct ieee80211_bss_conf *link_conf)
+				     struct ieee80211_bss_conf *link_conf,
+				     u64 *changed)
 {
 	struct unsol_bcast_probe_resp_data *new, *old = NULL;
 
@@ -1011,7 +1012,8 @@ ieee80211_set_unsol_bcast_probe_resp(struct ieee80211_sub_if_data *sdata,
 		RCU_INIT_POINTER(link->u.ap.unsol_bcast_probe_resp, NULL);
 	}
 
-	return BSS_CHANGED_UNSOL_BCAST_PROBE_RESP;
+	*changed |= BSS_CHANGED_UNSOL_BCAST_PROBE_RESP;
+	return 0;
 }
 
 static int ieee80211_set_ftm_responder_params(
@@ -1450,10 +1452,9 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 
 	err = ieee80211_set_unsol_bcast_probe_resp(sdata,
 						   &params->unsol_bcast_probe_resp,
-						   link, link_conf);
+						   link, link_conf, &changed);
 	if (err < 0)
 		goto error;
-	changed |= err;
 
 	err = drv_start_ap(sdata->local, sdata, link_conf);
 	if (err) {
@@ -1525,10 +1526,9 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 
 	err = ieee80211_set_unsol_bcast_probe_resp(sdata,
 						   &params->unsol_bcast_probe_resp,
-						   link, link_conf);
+						   link, link_conf, &changed);
 	if (err < 0)
 		return err;
-	changed |= err;
 
 	if (beacon->he_bss_color_valid &&
 	    beacon->he_bss_color.enabled != link_conf->he_bss_color.enabled) {
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index dcdaab19efbd..5a03bf1de6bb 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7288,6 +7288,75 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 	return err;
 }
 
+static bool ieee80211_mgd_csa_present(struct ieee80211_sub_if_data *sdata,
+				      const struct cfg80211_bss_ies *ies,
+				      u8 cur_channel, bool ignore_ecsa)
+{
+	const struct element *csa_elem, *ecsa_elem;
+	struct ieee80211_channel_sw_ie *csa = NULL;
+	struct ieee80211_ext_chansw_ie *ecsa = NULL;
+
+	if (!ies)
+		return false;
+
+	csa_elem = cfg80211_find_elem(WLAN_EID_CHANNEL_SWITCH,
+				      ies->data, ies->len);
+	if (csa_elem && csa_elem->datalen == sizeof(*csa))
+		csa = (void *)csa_elem->data;
+
+	ecsa_elem = cfg80211_find_elem(WLAN_EID_EXT_CHANSWITCH_ANN,
+				       ies->data, ies->len);
+	if (ecsa_elem && ecsa_elem->datalen == sizeof(*ecsa))
+		ecsa = (void *)ecsa_elem->data;
+
+	if (csa && csa->count == 0)
+		csa = NULL;
+	if (csa && !csa->mode && csa->new_ch_num == cur_channel)
+		csa = NULL;
+
+	if (ecsa && ecsa->count == 0)
+		ecsa = NULL;
+	if (ecsa && !ecsa->mode && ecsa->new_ch_num == cur_channel)
+		ecsa = NULL;
+
+	if (ignore_ecsa && ecsa) {
+		sdata_info(sdata,
+			   "Ignoring ECSA in probe response - was considered stuck!\n");
+		return csa;
+	}
+
+	return csa || ecsa;
+}
+
+static bool ieee80211_mgd_csa_in_process(struct ieee80211_sub_if_data *sdata,
+					 struct cfg80211_bss *bss)
+{
+	u8 cur_channel;
+	bool ret;
+
+	cur_channel = ieee80211_frequency_to_channel(bss->channel->center_freq);
+
+	rcu_read_lock();
+	if (ieee80211_mgd_csa_present(sdata,
+				      rcu_dereference(bss->beacon_ies),
+				      cur_channel, false)) {
+		ret = true;
+		goto out;
+	}
+
+	if (ieee80211_mgd_csa_present(sdata,
+				      rcu_dereference(bss->proberesp_ies),
+				      cur_channel, bss->proberesp_ecsa_stuck)) {
+		ret = true;
+		goto out;
+	}
+
+	ret = false;
+out:
+	rcu_read_unlock();
+	return ret;
+}
+
 /* config hooks */
 int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 		       struct cfg80211_auth_request *req)
@@ -7296,7 +7365,6 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_mgd_auth_data *auth_data;
 	struct ieee80211_link_data *link;
-	const struct element *csa_elem, *ecsa_elem;
 	u16 auth_alg;
 	int err;
 	bool cont_auth;
@@ -7339,21 +7407,10 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	if (ifmgd->assoc_data)
 		return -EBUSY;
 
-	rcu_read_lock();
-	csa_elem = ieee80211_bss_get_elem(req->bss, WLAN_EID_CHANNEL_SWITCH);
-	ecsa_elem = ieee80211_bss_get_elem(req->bss,
-					   WLAN_EID_EXT_CHANSWITCH_ANN);
-	if ((csa_elem &&
-	     csa_elem->datalen == sizeof(struct ieee80211_channel_sw_ie) &&
-	     ((struct ieee80211_channel_sw_ie *)csa_elem->data)->count != 0) ||
-	    (ecsa_elem &&
-	     ecsa_elem->datalen == sizeof(struct ieee80211_ext_chansw_ie) &&
-	     ((struct ieee80211_ext_chansw_ie *)ecsa_elem->data)->count != 0)) {
-		rcu_read_unlock();
+	if (ieee80211_mgd_csa_in_process(sdata, req->bss)) {
 		sdata_info(sdata, "AP is in CSA process, reject auth\n");
 		return -EINVAL;
 	}
-	rcu_read_unlock();
 
 	auth_data = kzalloc(sizeof(*auth_data) + req->auth_data_len +
 			    req->ie_len, GFP_KERNEL);
@@ -7662,7 +7719,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_mgd_assoc_data *assoc_data;
-	const struct element *ssid_elem, *csa_elem, *ecsa_elem;
+	const struct element *ssid_elem;
 	struct ieee80211_vif_cfg *vif_cfg = &sdata->vif.cfg;
 	ieee80211_conn_flags_t conn_flags = 0;
 	struct ieee80211_link_data *link;
@@ -7685,23 +7742,15 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 
 	cbss = req->link_id < 0 ? req->bss : req->links[req->link_id].bss;
 
-	rcu_read_lock();
-	ssid_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_SSID);
-	if (!ssid_elem || ssid_elem->datalen > sizeof(assoc_data->ssid)) {
-		rcu_read_unlock();
+	if (ieee80211_mgd_csa_in_process(sdata, cbss)) {
+		sdata_info(sdata, "AP is in CSA process, reject assoc\n");
 		kfree(assoc_data);
 		return -EINVAL;
 	}
 
-	csa_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_CHANNEL_SWITCH);
-	ecsa_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_EXT_CHANSWITCH_ANN);
-	if ((csa_elem &&
-	     csa_elem->datalen == sizeof(struct ieee80211_channel_sw_ie) &&
-	     ((struct ieee80211_channel_sw_ie *)csa_elem->data)->count != 0) ||
-	    (ecsa_elem &&
-	     ecsa_elem->datalen == sizeof(struct ieee80211_ext_chansw_ie) &&
-	     ((struct ieee80211_ext_chansw_ie *)ecsa_elem->data)->count != 0)) {
-		sdata_info(sdata, "AP is in CSA process, reject assoc\n");
+	rcu_read_lock();
+	ssid_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_SSID);
+	if (!ssid_elem || ssid_elem->datalen > sizeof(assoc_data->ssid)) {
 		rcu_read_unlock();
 		kfree(assoc_data);
 		return -EINVAL;
@@ -7976,8 +8025,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 
 		rcu_read_lock();
 		beacon_ies = rcu_dereference(req->bss->beacon_ies);
-
-		if (beacon_ies) {
+		if (!beacon_ies) {
 			/*
 			 * Wait up to one beacon interval ...
 			 * should this be more if we miss one?
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index ed4fdf655343..a94feb6b579b 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3100,10 +3100,11 @@ void ieee80211_check_fast_xmit(struct sta_info *sta)
 			/* DA SA BSSID */
 			build.da_offs = offsetof(struct ieee80211_hdr, addr1);
 			build.sa_offs = offsetof(struct ieee80211_hdr, addr2);
+			rcu_read_lock();
 			link = rcu_dereference(sdata->link[tdls_link_id]);
-			if (WARN_ON_ONCE(!link))
-				break;
-			memcpy(hdr->addr3, link->u.mgd.bssid, ETH_ALEN);
+			if (!WARN_ON_ONCE(!link))
+				memcpy(hdr->addr3, link->u.mgd.bssid, ETH_ALEN);
+			rcu_read_unlock();
 			build.hdr_len = 24;
 			break;
 		}
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 0e07f110a539..04c5aa4debc7 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -9744,6 +9744,7 @@ struct nft_trans_gc *nft_trans_gc_catchall_async(struct nft_trans_gc *gc,
 struct nft_trans_gc *nft_trans_gc_catchall_sync(struct nft_trans_gc *gc)
 {
 	struct nft_set_elem_catchall *catchall, *next;
+	u64 tstamp = nft_net_tstamp(gc->net);
 	const struct nft_set *set = gc->set;
 	struct nft_elem_priv *elem_priv;
 	struct nft_set_ext *ext;
@@ -9753,7 +9754,7 @@ struct nft_trans_gc *nft_trans_gc_catchall_sync(struct nft_trans_gc *gc)
 	list_for_each_entry_safe(catchall, next, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
 
-		if (!nft_set_elem_expired(ext))
+		if (!__nft_set_elem_expired(ext, tstamp))
 			continue;
 
 		gc = nft_trans_gc_queue_sync(gc, GFP_KERNEL);
@@ -10539,6 +10540,7 @@ static bool nf_tables_valid_genid(struct net *net, u32 genid)
 	bool genid_ok;
 
 	mutex_lock(&nft_net->commit_mutex);
+	nft_net->tstamp = get_jiffies_64();
 
 	genid_ok = genid == 0 || nft_net->base_seq == genid;
 	if (!genid_ok)
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 171d1f52d3dd..5cf38fc0a366 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -232,18 +232,25 @@ static void nfqnl_reinject(struct nf_queue_entry *entry, unsigned int verdict)
 	if (verdict == NF_ACCEPT ||
 	    verdict == NF_REPEAT ||
 	    verdict == NF_STOP) {
+		unsigned int ct_verdict = verdict;
+
 		rcu_read_lock();
 		ct_hook = rcu_dereference(nf_ct_hook);
 		if (ct_hook)
-			verdict = ct_hook->update(entry->state.net, entry->skb);
+			ct_verdict = ct_hook->update(entry->state.net, entry->skb);
 		rcu_read_unlock();
 
-		switch (verdict & NF_VERDICT_MASK) {
+		switch (ct_verdict & NF_VERDICT_MASK) {
+		case NF_ACCEPT:
+			/* follow userspace verdict, could be REPEAT */
+			break;
 		case NF_STOLEN:
 			nf_queue_entry_free(entry);
 			return;
+		default:
+			verdict = ct_verdict & NF_VERDICT_MASK;
+			break;
 		}
-
 	}
 	nf_reinject(entry, verdict);
 }
diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index f0eeda97bfcd..1f9474fefe84 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -135,7 +135,7 @@ static void nft_target_eval_bridge(const struct nft_expr *expr,
 
 static const struct nla_policy nft_target_policy[NFTA_TARGET_MAX + 1] = {
 	[NFTA_TARGET_NAME]	= { .type = NLA_NUL_STRING },
-	[NFTA_TARGET_REV]	= { .type = NLA_U32 },
+	[NFTA_TARGET_REV]	= NLA_POLICY_MAX(NLA_BE32, 255),
 	[NFTA_TARGET_INFO]	= { .type = NLA_BINARY },
 };
 
@@ -200,6 +200,7 @@ static const struct nla_policy nft_rule_compat_policy[NFTA_RULE_COMPAT_MAX + 1]
 static int nft_parse_compat(const struct nlattr *attr, u16 *proto, bool *inv)
 {
 	struct nlattr *tb[NFTA_RULE_COMPAT_MAX+1];
+	u32 l4proto;
 	u32 flags;
 	int err;
 
@@ -212,12 +213,18 @@ static int nft_parse_compat(const struct nlattr *attr, u16 *proto, bool *inv)
 		return -EINVAL;
 
 	flags = ntohl(nla_get_be32(tb[NFTA_RULE_COMPAT_FLAGS]));
-	if (flags & ~NFT_RULE_COMPAT_F_MASK)
+	if (flags & NFT_RULE_COMPAT_F_UNUSED ||
+	    flags & ~NFT_RULE_COMPAT_F_MASK)
 		return -EINVAL;
 	if (flags & NFT_RULE_COMPAT_F_INV)
 		*inv = true;
 
-	*proto = ntohl(nla_get_be32(tb[NFTA_RULE_COMPAT_PROTO]));
+	l4proto = ntohl(nla_get_be32(tb[NFTA_RULE_COMPAT_PROTO]));
+	if (l4proto > U16_MAX)
+		return -EINVAL;
+
+	*proto = l4proto;
+
 	return 0;
 }
 
@@ -419,7 +426,7 @@ static void nft_match_eval(const struct nft_expr *expr,
 
 static const struct nla_policy nft_match_policy[NFTA_MATCH_MAX + 1] = {
 	[NFTA_MATCH_NAME]	= { .type = NLA_NUL_STRING },
-	[NFTA_MATCH_REV]	= { .type = NLA_U32 },
+	[NFTA_MATCH_REV]	= NLA_POLICY_MAX(NLA_BE32, 255),
 	[NFTA_MATCH_INFO]	= { .type = NLA_BINARY },
 };
 
@@ -724,7 +731,7 @@ static int nfnl_compat_get_rcu(struct sk_buff *skb,
 static const struct nla_policy nfnl_compat_policy_get[NFTA_COMPAT_MAX+1] = {
 	[NFTA_COMPAT_NAME]	= { .type = NLA_NUL_STRING,
 				    .len = NFT_COMPAT_NAME_MAX-1 },
-	[NFTA_COMPAT_REV]	= { .type = NLA_U32 },
+	[NFTA_COMPAT_REV]	= NLA_POLICY_MAX(NLA_BE32, 255),
 	[NFTA_COMPAT_TYPE]	= { .type = NLA_U32 },
 };
 
diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index aac98a3c966e..bfd3e5a14dab 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -476,6 +476,9 @@ static int nft_ct_get_init(const struct nft_ctx *ctx,
 		break;
 #endif
 	case NFT_CT_ID:
+		if (tb[NFTA_CT_DIRECTION])
+			return -EINVAL;
+
 		len = sizeof(u32);
 		break;
 	default:
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index 6c2061bfdae6..6968a3b34236 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -36,6 +36,7 @@ struct nft_rhash_cmp_arg {
 	const struct nft_set		*set;
 	const u32			*key;
 	u8				genmask;
+	u64				tstamp;
 };
 
 static inline u32 nft_rhash_key(const void *data, u32 len, u32 seed)
@@ -62,7 +63,7 @@ static inline int nft_rhash_cmp(struct rhashtable_compare_arg *arg,
 		return 1;
 	if (nft_set_elem_is_dead(&he->ext))
 		return 1;
-	if (nft_set_elem_expired(&he->ext))
+	if (__nft_set_elem_expired(&he->ext, x->tstamp))
 		return 1;
 	if (!nft_set_elem_active(&he->ext, x->genmask))
 		return 1;
@@ -87,6 +88,7 @@ bool nft_rhash_lookup(const struct net *net, const struct nft_set *set,
 		.genmask = nft_genmask_cur(net),
 		.set	 = set,
 		.key	 = key,
+		.tstamp  = get_jiffies_64(),
 	};
 
 	he = rhashtable_lookup(&priv->ht, &arg, nft_rhash_params);
@@ -106,6 +108,7 @@ nft_rhash_get(const struct net *net, const struct nft_set *set,
 		.genmask = nft_genmask_cur(net),
 		.set	 = set,
 		.key	 = elem->key.val.data,
+		.tstamp  = get_jiffies_64(),
 	};
 
 	he = rhashtable_lookup(&priv->ht, &arg, nft_rhash_params);
@@ -131,6 +134,7 @@ static bool nft_rhash_update(struct nft_set *set, const u32 *key,
 		.genmask = NFT_GENMASK_ANY,
 		.set	 = set,
 		.key	 = key,
+		.tstamp  = get_jiffies_64(),
 	};
 
 	he = rhashtable_lookup(&priv->ht, &arg, nft_rhash_params);
@@ -175,6 +179,7 @@ static int nft_rhash_insert(const struct net *net, const struct nft_set *set,
 		.genmask = nft_genmask_next(net),
 		.set	 = set,
 		.key	 = elem->key.val.data,
+		.tstamp	 = nft_net_tstamp(net),
 	};
 	struct nft_rhash_elem *prev;
 
@@ -216,6 +221,7 @@ nft_rhash_deactivate(const struct net *net, const struct nft_set *set,
 		.genmask = nft_genmask_next(net),
 		.set	 = set,
 		.key	 = elem->key.val.data,
+		.tstamp	 = nft_net_tstamp(net),
 	};
 
 	rcu_read_lock();
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 7252fcdae349..3089c4ca8fff 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -342,9 +342,6 @@
 #include "nft_set_pipapo_avx2.h"
 #include "nft_set_pipapo.h"
 
-/* Current working bitmap index, toggled between field matches */
-static DEFINE_PER_CPU(bool, nft_pipapo_scratch_index);
-
 /**
  * pipapo_refill() - For each set bit, set bits from selected mapping table item
  * @map:	Bitmap to be scanned for set bits
@@ -412,6 +409,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 		       const u32 *key, const struct nft_set_ext **ext)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
+	struct nft_pipapo_scratch *scratch;
 	unsigned long *res_map, *fill_map;
 	u8 genmask = nft_genmask_cur(net);
 	const u8 *rp = (const u8 *)key;
@@ -422,15 +420,17 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 
 	local_bh_disable();
 
-	map_index = raw_cpu_read(nft_pipapo_scratch_index);
-
 	m = rcu_dereference(priv->match);
 
 	if (unlikely(!m || !*raw_cpu_ptr(m->scratch)))
 		goto out;
 
-	res_map  = *raw_cpu_ptr(m->scratch) + (map_index ? m->bsize_max : 0);
-	fill_map = *raw_cpu_ptr(m->scratch) + (map_index ? 0 : m->bsize_max);
+	scratch = *raw_cpu_ptr(m->scratch);
+
+	map_index = scratch->map_index;
+
+	res_map  = scratch->map + (map_index ? m->bsize_max : 0);
+	fill_map = scratch->map + (map_index ? 0 : m->bsize_max);
 
 	memset(res_map, 0xff, m->bsize_max * sizeof(*res_map));
 
@@ -460,7 +460,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 		b = pipapo_refill(res_map, f->bsize, f->rules, fill_map, f->mt,
 				  last);
 		if (b < 0) {
-			raw_cpu_write(nft_pipapo_scratch_index, map_index);
+			scratch->map_index = map_index;
 			local_bh_enable();
 
 			return false;
@@ -477,7 +477,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 			 * current inactive bitmap is clean and can be reused as
 			 * *next* bitmap (not initial) for the next packet.
 			 */
-			raw_cpu_write(nft_pipapo_scratch_index, map_index);
+			scratch->map_index = map_index;
 			local_bh_enable();
 
 			return true;
@@ -504,6 +504,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
  * @set:	nftables API set representation
  * @data:	Key data to be matched against existing elements
  * @genmask:	If set, check that element is active in given genmask
+ * @tstamp:	timestamp to check for expired elements
  *
  * This is essentially the same as the lookup function, except that it matches
  * key data against the uncommitted copy and doesn't use preallocated maps for
@@ -513,7 +514,8 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
  */
 static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 					  const struct nft_set *set,
-					  const u8 *data, u8 genmask)
+					  const u8 *data, u8 genmask,
+					  u64 tstamp)
 {
 	struct nft_pipapo_elem *ret = ERR_PTR(-ENOENT);
 	struct nft_pipapo *priv = nft_set_priv(set);
@@ -566,7 +568,7 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 			goto out;
 
 		if (last) {
-			if (nft_set_elem_expired(&f->mt[b].e->ext))
+			if (__nft_set_elem_expired(&f->mt[b].e->ext, tstamp))
 				goto next_match;
 			if ((genmask &&
 			     !nft_set_elem_active(&f->mt[b].e->ext, genmask)))
@@ -603,10 +605,10 @@ static struct nft_elem_priv *
 nft_pipapo_get(const struct net *net, const struct nft_set *set,
 	       const struct nft_set_elem *elem, unsigned int flags)
 {
-	static struct nft_pipapo_elem *e;
+	struct nft_pipapo_elem *e;
 
 	e = pipapo_get(net, set, (const u8 *)elem->key.val.data,
-		       nft_genmask_cur(net));
+		       nft_genmask_cur(net), get_jiffies_64());
 	if (IS_ERR(e))
 		return ERR_CAST(e);
 
@@ -1108,6 +1110,25 @@ static void pipapo_map(struct nft_pipapo_match *m,
 		f->mt[map[i].to + j].e = e;
 }
 
+/**
+ * pipapo_free_scratch() - Free per-CPU map at original (not aligned) address
+ * @m:		Matching data
+ * @cpu:	CPU number
+ */
+static void pipapo_free_scratch(const struct nft_pipapo_match *m, unsigned int cpu)
+{
+	struct nft_pipapo_scratch *s;
+	void *mem;
+
+	s = *per_cpu_ptr(m->scratch, cpu);
+	if (!s)
+		return;
+
+	mem = s;
+	mem -= s->align_off;
+	kfree(mem);
+}
+
 /**
  * pipapo_realloc_scratch() - Reallocate scratch maps for partial match results
  * @clone:	Copy of matching data with pending insertions and deletions
@@ -1121,12 +1142,13 @@ static int pipapo_realloc_scratch(struct nft_pipapo_match *clone,
 	int i;
 
 	for_each_possible_cpu(i) {
-		unsigned long *scratch;
+		struct nft_pipapo_scratch *scratch;
 #ifdef NFT_PIPAPO_ALIGN
-		unsigned long *scratch_aligned;
+		void *scratch_aligned;
+		u32 align_off;
 #endif
-
-		scratch = kzalloc_node(bsize_max * sizeof(*scratch) * 2 +
+		scratch = kzalloc_node(struct_size(scratch, map,
+						   bsize_max * 2) +
 				       NFT_PIPAPO_ALIGN_HEADROOM,
 				       GFP_KERNEL, cpu_to_node(i));
 		if (!scratch) {
@@ -1140,14 +1162,25 @@ static int pipapo_realloc_scratch(struct nft_pipapo_match *clone,
 			return -ENOMEM;
 		}
 
-		kfree(*per_cpu_ptr(clone->scratch, i));
-
-		*per_cpu_ptr(clone->scratch, i) = scratch;
+		pipapo_free_scratch(clone, i);
 
 #ifdef NFT_PIPAPO_ALIGN
-		scratch_aligned = NFT_PIPAPO_LT_ALIGN(scratch);
-		*per_cpu_ptr(clone->scratch_aligned, i) = scratch_aligned;
+		/* Align &scratch->map (not the struct itself): the extra
+		 * %NFT_PIPAPO_ALIGN_HEADROOM bytes passed to kzalloc_node()
+		 * above guarantee we can waste up to those bytes in order
+		 * to align the map field regardless of its offset within
+		 * the struct.
+		 */
+		BUILD_BUG_ON(offsetof(struct nft_pipapo_scratch, map) > NFT_PIPAPO_ALIGN_HEADROOM);
+
+		scratch_aligned = NFT_PIPAPO_LT_ALIGN(&scratch->map);
+		scratch_aligned -= offsetof(struct nft_pipapo_scratch, map);
+		align_off = scratch_aligned - (void *)scratch;
+
+		scratch = scratch_aligned;
+		scratch->align_off = align_off;
 #endif
+		*per_cpu_ptr(clone->scratch, i) = scratch;
 	}
 
 	return 0;
@@ -1173,6 +1206,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	struct nft_pipapo_match *m = priv->clone;
 	u8 genmask = nft_genmask_next(net);
 	struct nft_pipapo_elem *e, *dup;
+	u64 tstamp = nft_net_tstamp(net);
 	struct nft_pipapo_field *f;
 	const u8 *start_p, *end_p;
 	int i, bsize_max, err = 0;
@@ -1182,7 +1216,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	else
 		end = start;
 
-	dup = pipapo_get(net, set, start, genmask);
+	dup = pipapo_get(net, set, start, genmask, tstamp);
 	if (!IS_ERR(dup)) {
 		/* Check if we already have the same exact entry */
 		const struct nft_data *dup_key, *dup_end;
@@ -1204,7 +1238,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 
 	if (PTR_ERR(dup) == -ENOENT) {
 		/* Look for partially overlapping entries */
-		dup = pipapo_get(net, set, end, nft_genmask_next(net));
+		dup = pipapo_get(net, set, end, nft_genmask_next(net), tstamp);
 	}
 
 	if (PTR_ERR(dup) != -ENOENT) {
@@ -1301,11 +1335,6 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 	if (!new->scratch)
 		goto out_scratch;
 
-#ifdef NFT_PIPAPO_ALIGN
-	new->scratch_aligned = alloc_percpu(*new->scratch_aligned);
-	if (!new->scratch_aligned)
-		goto out_scratch;
-#endif
 	for_each_possible_cpu(i)
 		*per_cpu_ptr(new->scratch, i) = NULL;
 
@@ -1357,10 +1386,7 @@ static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old)
 	}
 out_scratch_realloc:
 	for_each_possible_cpu(i)
-		kfree(*per_cpu_ptr(new->scratch, i));
-#ifdef NFT_PIPAPO_ALIGN
-	free_percpu(new->scratch_aligned);
-#endif
+		pipapo_free_scratch(new, i);
 out_scratch:
 	free_percpu(new->scratch);
 	kfree(new);
@@ -1560,6 +1586,7 @@ static void pipapo_gc(struct nft_set *set, struct nft_pipapo_match *m)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
 	struct net *net = read_pnet(&set->net);
+	u64 tstamp = nft_net_tstamp(net);
 	int rules_f0, first_rule = 0;
 	struct nft_pipapo_elem *e;
 	struct nft_trans_gc *gc;
@@ -1594,7 +1621,7 @@ static void pipapo_gc(struct nft_set *set, struct nft_pipapo_match *m)
 		/* synchronous gc never fails, there is no need to set on
 		 * NFT_SET_ELEM_DEAD_BIT.
 		 */
-		if (nft_set_elem_expired(&e->ext)) {
+		if (__nft_set_elem_expired(&e->ext, tstamp)) {
 			priv->dirty = true;
 
 			gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
@@ -1640,13 +1667,9 @@ static void pipapo_free_match(struct nft_pipapo_match *m)
 	int i;
 
 	for_each_possible_cpu(i)
-		kfree(*per_cpu_ptr(m->scratch, i));
+		pipapo_free_scratch(m, i);
 
-#ifdef NFT_PIPAPO_ALIGN
-	free_percpu(m->scratch_aligned);
-#endif
 	free_percpu(m->scratch);
-
 	pipapo_free_fields(m);
 
 	kfree(m);
@@ -1769,7 +1792,7 @@ static void *pipapo_deactivate(const struct net *net, const struct nft_set *set,
 {
 	struct nft_pipapo_elem *e;
 
-	e = pipapo_get(net, set, data, nft_genmask_next(net));
+	e = pipapo_get(net, set, data, nft_genmask_next(net), nft_net_tstamp(net));
 	if (IS_ERR(e))
 		return NULL;
 
@@ -2132,7 +2155,7 @@ static int nft_pipapo_init(const struct nft_set *set,
 	m->field_count = field_count;
 	m->bsize_max = 0;
 
-	m->scratch = alloc_percpu(unsigned long *);
+	m->scratch = alloc_percpu(struct nft_pipapo_scratch *);
 	if (!m->scratch) {
 		err = -ENOMEM;
 		goto out_scratch;
@@ -2140,16 +2163,6 @@ static int nft_pipapo_init(const struct nft_set *set,
 	for_each_possible_cpu(i)
 		*per_cpu_ptr(m->scratch, i) = NULL;
 
-#ifdef NFT_PIPAPO_ALIGN
-	m->scratch_aligned = alloc_percpu(unsigned long *);
-	if (!m->scratch_aligned) {
-		err = -ENOMEM;
-		goto out_free;
-	}
-	for_each_possible_cpu(i)
-		*per_cpu_ptr(m->scratch_aligned, i) = NULL;
-#endif
-
 	rcu_head_init(&m->rcu);
 
 	nft_pipapo_for_each_field(f, i, m) {
@@ -2180,9 +2193,6 @@ static int nft_pipapo_init(const struct nft_set *set,
 	return 0;
 
 out_free:
-#ifdef NFT_PIPAPO_ALIGN
-	free_percpu(m->scratch_aligned);
-#endif
 	free_percpu(m->scratch);
 out_scratch:
 	kfree(m);
@@ -2236,11 +2246,8 @@ static void nft_pipapo_destroy(const struct nft_ctx *ctx,
 
 		nft_set_pipapo_match_destroy(ctx, set, m);
 
-#ifdef NFT_PIPAPO_ALIGN
-		free_percpu(m->scratch_aligned);
-#endif
 		for_each_possible_cpu(cpu)
-			kfree(*per_cpu_ptr(m->scratch, cpu));
+			pipapo_free_scratch(m, cpu);
 		free_percpu(m->scratch);
 		pipapo_free_fields(m);
 		kfree(m);
@@ -2253,11 +2260,8 @@ static void nft_pipapo_destroy(const struct nft_ctx *ctx,
 		if (priv->dirty)
 			nft_set_pipapo_match_destroy(ctx, set, m);
 
-#ifdef NFT_PIPAPO_ALIGN
-		free_percpu(priv->clone->scratch_aligned);
-#endif
 		for_each_possible_cpu(cpu)
-			kfree(*per_cpu_ptr(priv->clone->scratch, cpu));
+			pipapo_free_scratch(priv->clone, cpu);
 		free_percpu(priv->clone->scratch);
 
 		pipapo_free_fields(priv->clone);
diff --git a/net/netfilter/nft_set_pipapo.h b/net/netfilter/nft_set_pipapo.h
index 1040223da5fa..f59a0cd81105 100644
--- a/net/netfilter/nft_set_pipapo.h
+++ b/net/netfilter/nft_set_pipapo.h
@@ -130,21 +130,29 @@ struct nft_pipapo_field {
 	union nft_pipapo_map_bucket *mt;
 };
 
+/**
+ * struct nft_pipapo_scratch - percpu data used for lookup and matching
+ * @map_index:	Current working bitmap index, toggled between field matches
+ * @align_off:	Offset to get the originally allocated address
+ * @map:	store partial matching results during lookup
+ */
+struct nft_pipapo_scratch {
+	u8 map_index;
+	u32 align_off;
+	unsigned long map[];
+};
+
 /**
  * struct nft_pipapo_match - Data used for lookup and matching
  * @field_count		Amount of fields in set
  * @scratch:		Preallocated per-CPU maps for partial matching results
- * @scratch_aligned:	Version of @scratch aligned to NFT_PIPAPO_ALIGN bytes
  * @bsize_max:		Maximum lookup table bucket size of all fields, in longs
  * @rcu			Matching data is swapped on commits
  * @f:			Fields, with lookup and mapping tables
  */
 struct nft_pipapo_match {
 	int field_count;
-#ifdef NFT_PIPAPO_ALIGN
-	unsigned long * __percpu *scratch_aligned;
-#endif
-	unsigned long * __percpu *scratch;
+	struct nft_pipapo_scratch * __percpu *scratch;
 	size_t bsize_max;
 	struct rcu_head rcu;
 	struct nft_pipapo_field f[] __counted_by(field_count);
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index 52e0d026d30a..90e275bb3e5d 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -71,9 +71,6 @@
 #define NFT_PIPAPO_AVX2_ZERO(reg)					\
 	asm volatile("vpxor %ymm" #reg ", %ymm" #reg ", %ymm" #reg)
 
-/* Current working bitmap index, toggled between field matches */
-static DEFINE_PER_CPU(bool, nft_pipapo_avx2_scratch_index);
-
 /**
  * nft_pipapo_avx2_prepare() - Prepare before main algorithm body
  *
@@ -1120,11 +1117,12 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 			    const u32 *key, const struct nft_set_ext **ext)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
-	unsigned long *res, *fill, *scratch;
+	struct nft_pipapo_scratch *scratch;
 	u8 genmask = nft_genmask_cur(net);
 	const u8 *rp = (const u8 *)key;
 	struct nft_pipapo_match *m;
 	struct nft_pipapo_field *f;
+	unsigned long *res, *fill;
 	bool map_index;
 	int i, ret = 0;
 
@@ -1141,15 +1139,16 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 	 */
 	kernel_fpu_begin_mask(0);
 
-	scratch = *raw_cpu_ptr(m->scratch_aligned);
+	scratch = *raw_cpu_ptr(m->scratch);
 	if (unlikely(!scratch)) {
 		kernel_fpu_end();
 		return false;
 	}
-	map_index = raw_cpu_read(nft_pipapo_avx2_scratch_index);
 
-	res  = scratch + (map_index ? m->bsize_max : 0);
-	fill = scratch + (map_index ? 0 : m->bsize_max);
+	map_index = scratch->map_index;
+
+	res  = scratch->map + (map_index ? m->bsize_max : 0);
+	fill = scratch->map + (map_index ? 0 : m->bsize_max);
 
 	/* Starting map doesn't need to be set for this implementation */
 
@@ -1221,7 +1220,7 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 
 out:
 	if (i % 2)
-		raw_cpu_write(nft_pipapo_avx2_scratch_index, !map_index);
+		scratch->map_index = !map_index;
 	kernel_fpu_end();
 
 	return ret >= 0;
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index baa3fea4fe65..9944fe479e53 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -234,7 +234,7 @@ static void nft_rbtree_gc_elem_remove(struct net *net, struct nft_set *set,
 
 static const struct nft_rbtree_elem *
 nft_rbtree_gc_elem(const struct nft_set *__set, struct nft_rbtree *priv,
-		   struct nft_rbtree_elem *rbe, u8 genmask)
+		   struct nft_rbtree_elem *rbe)
 {
 	struct nft_set *set = (struct nft_set *)__set;
 	struct rb_node *prev = rb_prev(&rbe->node);
@@ -253,7 +253,7 @@ nft_rbtree_gc_elem(const struct nft_set *__set, struct nft_rbtree *priv,
 	while (prev) {
 		rbe_prev = rb_entry(prev, struct nft_rbtree_elem, node);
 		if (nft_rbtree_interval_end(rbe_prev) &&
-		    nft_set_elem_active(&rbe_prev->ext, genmask))
+		    nft_set_elem_active(&rbe_prev->ext, NFT_GENMASK_ANY))
 			break;
 
 		prev = rb_prev(prev);
@@ -313,6 +313,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 	struct nft_rbtree *priv = nft_set_priv(set);
 	u8 cur_genmask = nft_genmask_cur(net);
 	u8 genmask = nft_genmask_next(net);
+	u64 tstamp = nft_net_tstamp(net);
 	int d;
 
 	/* Descend the tree to search for an existing element greater than the
@@ -360,11 +361,11 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 		/* perform garbage collection to avoid bogus overlap reports
 		 * but skip new elements in this transaction.
 		 */
-		if (nft_set_elem_expired(&rbe->ext) &&
+		if (__nft_set_elem_expired(&rbe->ext, tstamp) &&
 		    nft_set_elem_active(&rbe->ext, cur_genmask)) {
 			const struct nft_rbtree_elem *removed_end;
 
-			removed_end = nft_rbtree_gc_elem(set, priv, rbe, genmask);
+			removed_end = nft_rbtree_gc_elem(set, priv, rbe);
 			if (IS_ERR(removed_end))
 				return PTR_ERR(removed_end);
 
@@ -551,6 +552,7 @@ nft_rbtree_deactivate(const struct net *net, const struct nft_set *set,
 	const struct nft_rbtree *priv = nft_set_priv(set);
 	const struct rb_node *parent = priv->root.rb_node;
 	u8 genmask = nft_genmask_next(net);
+	u64 tstamp = nft_net_tstamp(net);
 	int d;
 
 	while (parent != NULL) {
@@ -571,7 +573,7 @@ nft_rbtree_deactivate(const struct net *net, const struct nft_set *set,
 				   nft_rbtree_interval_end(this)) {
 				parent = parent->rb_right;
 				continue;
-			} else if (nft_set_elem_expired(&rbe->ext)) {
+			} else if (__nft_set_elem_expired(&rbe->ext, tstamp)) {
 				break;
 			} else if (!nft_set_elem_active(&rbe->ext, genmask)) {
 				parent = parent->rb_left;
@@ -624,9 +626,10 @@ static void nft_rbtree_gc(struct nft_set *set)
 {
 	struct nft_rbtree *priv = nft_set_priv(set);
 	struct nft_rbtree_elem *rbe, *rbe_end = NULL;
+	struct net *net = read_pnet(&set->net);
+	u64 tstamp = nft_net_tstamp(net);
 	struct rb_node *node, *next;
 	struct nft_trans_gc *gc;
-	struct net *net;
 
 	set  = nft_set_container_of(priv);
 	net  = read_pnet(&set->net);
@@ -648,7 +651,7 @@ static void nft_rbtree_gc(struct nft_set *set)
 			rbe_end = rbe;
 			continue;
 		}
-		if (!nft_set_elem_expired(&rbe->ext))
+		if (!__nft_set_elem_expired(&rbe->ext, tstamp))
 			continue;
 
 		gc = nft_trans_gc_queue_sync(gc, GFP_KERNEL);
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 5d5b19f20d1e..027414dafe7f 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -198,11 +198,19 @@ struct rxrpc_host_header {
  */
 struct rxrpc_skb_priv {
 	struct rxrpc_connection *conn;	/* Connection referred to (poke packet) */
-	u16		offset;		/* Offset of data */
-	u16		len;		/* Length of data */
-	u8		flags;
+	union {
+		struct {
+			u16		offset;		/* Offset of data */
+			u16		len;		/* Length of data */
+			u8		flags;
 #define RXRPC_RX_VERIFIED	0x01
-
+		};
+		struct {
+			rxrpc_seq_t	first_ack;	/* First packet in acks table */
+			u8		nr_acks;	/* Number of acks+nacks */
+			u8		nr_nacks;	/* Number of nacks */
+		};
+	};
 	struct rxrpc_host_header hdr;	/* RxRPC packet header from this packet */
 };
 
@@ -507,7 +515,7 @@ struct rxrpc_connection {
 	enum rxrpc_call_completion completion;	/* Completion condition */
 	s32			abort_code;	/* Abort code of connection abort */
 	int			debug_id;	/* debug ID for printks */
-	atomic_t		serial;		/* packet serial number counter */
+	rxrpc_serial_t		tx_serial;	/* Outgoing packet serial number counter */
 	unsigned int		hi_serial;	/* highest serial number received */
 	u32			service_id;	/* Service ID, possibly upgraded */
 	u32			security_level;	/* Security level selected */
@@ -689,11 +697,11 @@ struct rxrpc_call {
 	u8			cong_dup_acks;	/* Count of ACKs showing missing packets */
 	u8			cong_cumul_acks; /* Cumulative ACK count */
 	ktime_t			cong_tstamp;	/* Last time cwnd was changed */
+	struct sk_buff		*cong_last_nack; /* Last ACK with nacks received */
 
 	/* Receive-phase ACK management (ACKs we send). */
 	u8			ackr_reason;	/* reason to ACK */
 	u16			ackr_sack_base;	/* Starting slot in SACK table ring */
-	rxrpc_serial_t		ackr_serial;	/* serial of packet being ACK'd */
 	rxrpc_seq_t		ackr_window;	/* Base of SACK window */
 	rxrpc_seq_t		ackr_wtop;	/* Base of SACK window */
 	unsigned int		ackr_nr_unacked; /* Number of unacked packets */
@@ -727,7 +735,8 @@ struct rxrpc_call {
 struct rxrpc_ack_summary {
 	u16			nr_acks;		/* Number of ACKs in packet */
 	u16			nr_new_acks;		/* Number of new ACKs in packet */
-	u16			nr_rot_new_acks;	/* Number of rotated new ACKs */
+	u16			nr_new_nacks;		/* Number of new nacks in packet */
+	u16			nr_retained_nacks;	/* Number of nacks retained between ACKs */
 	u8			ack_reason;
 	bool			saw_nacks;		/* Saw NACKs in packet */
 	bool			new_low_nack;		/* T if new low NACK found */
@@ -819,6 +828,20 @@ static inline bool rxrpc_sending_to_client(const struct rxrpc_txbuf *txb)
 
 #include <trace/events/rxrpc.h>
 
+/*
+ * Allocate the next serial number on a connection.  0 must be skipped.
+ */
+static inline rxrpc_serial_t rxrpc_get_next_serial(struct rxrpc_connection *conn)
+{
+	rxrpc_serial_t serial;
+
+	serial = conn->tx_serial;
+	if (serial == 0)
+		serial = 1;
+	conn->tx_serial = serial + 1;
+	return serial;
+}
+
 /*
  * af_rxrpc.c
  */
diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index e363f21a2014..0f78544d043b 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -43,8 +43,6 @@ void rxrpc_propose_delay_ACK(struct rxrpc_call *call, rxrpc_serial_t serial,
 	unsigned long expiry = rxrpc_soft_ack_delay;
 	unsigned long now = jiffies, ack_at;
 
-	call->ackr_serial = serial;
-
 	if (rxrpc_soft_ack_delay < expiry)
 		expiry = rxrpc_soft_ack_delay;
 	if (call->peer->srtt_us != 0)
@@ -114,6 +112,7 @@ static void rxrpc_congestion_timeout(struct rxrpc_call *call)
 void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 {
 	struct rxrpc_ackpacket *ack = NULL;
+	struct rxrpc_skb_priv *sp;
 	struct rxrpc_txbuf *txb;
 	unsigned long resend_at;
 	rxrpc_seq_t transmitted = READ_ONCE(call->tx_transmitted);
@@ -141,14 +140,15 @@ void rxrpc_resend(struct rxrpc_call *call, struct sk_buff *ack_skb)
 	 * explicitly NAK'd packets.
 	 */
 	if (ack_skb) {
+		sp = rxrpc_skb(ack_skb);
 		ack = (void *)ack_skb->data + sizeof(struct rxrpc_wire_header);
 
-		for (i = 0; i < ack->nAcks; i++) {
+		for (i = 0; i < sp->nr_acks; i++) {
 			rxrpc_seq_t seq;
 
 			if (ack->acks[i] & 1)
 				continue;
-			seq = ntohl(ack->firstPacket) + i;
+			seq = sp->first_ack + i;
 			if (after(txb->seq, transmitted))
 				break;
 			if (after(txb->seq, seq))
@@ -373,7 +373,6 @@ static void rxrpc_send_initial_ping(struct rxrpc_call *call)
 bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 {
 	unsigned long now, next, t;
-	rxrpc_serial_t ackr_serial;
 	bool resend = false, expired = false;
 	s32 abort_code;
 
@@ -423,8 +422,7 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 	if (time_after_eq(now, t)) {
 		trace_rxrpc_timer(call, rxrpc_timer_exp_ack, now);
 		cmpxchg(&call->delay_ack_at, t, now + MAX_JIFFY_OFFSET);
-		ackr_serial = xchg(&call->ackr_serial, 0);
-		rxrpc_send_ACK(call, RXRPC_ACK_DELAY, ackr_serial,
+		rxrpc_send_ACK(call, RXRPC_ACK_DELAY, 0,
 			       rxrpc_propose_ack_ping_for_lost_ack);
 	}
 
diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 0943e54370ba..9fc9a6c3f685 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -686,6 +686,7 @@ static void rxrpc_destroy_call(struct work_struct *work)
 
 	del_timer_sync(&call->timer);
 
+	rxrpc_free_skb(call->cong_last_nack, rxrpc_skb_put_last_nack);
 	rxrpc_cleanup_ring(call);
 	while ((txb = list_first_entry_or_null(&call->tx_sendmsg,
 					       struct rxrpc_txbuf, call_link))) {
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 95f4bc206b3d..1f251d758cb9 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -95,6 +95,14 @@ void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 
 	_enter("%d", conn->debug_id);
 
+	if (sp && sp->hdr.type == RXRPC_PACKET_TYPE_ACK) {
+		if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header),
+				  &pkt.ack, sizeof(pkt.ack)) < 0)
+			return;
+		if (pkt.ack.reason == RXRPC_ACK_PING_RESPONSE)
+			return;
+	}
+
 	chan = &conn->channels[channel];
 
 	/* If the last call got moved on whilst we were waiting to run, just
@@ -117,7 +125,7 @@ void rxrpc_conn_retransmit_call(struct rxrpc_connection *conn,
 	iov[2].iov_base	= &ack_info;
 	iov[2].iov_len	= sizeof(ack_info);
 
-	serial = atomic_inc_return(&conn->serial);
+	serial = rxrpc_get_next_serial(conn);
 
 	pkt.whdr.epoch		= htonl(conn->proto.epoch);
 	pkt.whdr.cid		= htonl(conn->proto.cid | channel);
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 92495e73b869..9691de00ade7 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -45,11 +45,9 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 	}
 
 	cumulative_acks += summary->nr_new_acks;
-	cumulative_acks += summary->nr_rot_new_acks;
 	if (cumulative_acks > 255)
 		cumulative_acks = 255;
 
-	summary->mode = call->cong_mode;
 	summary->cwnd = call->cong_cwnd;
 	summary->ssthresh = call->cong_ssthresh;
 	summary->cumulative_acks = cumulative_acks;
@@ -151,6 +149,7 @@ static void rxrpc_congestion_management(struct rxrpc_call *call,
 		cwnd = RXRPC_TX_MAX_WINDOW;
 	call->cong_cwnd = cwnd;
 	call->cong_cumul_acks = cumulative_acks;
+	summary->mode = call->cong_mode;
 	trace_rxrpc_congest(call, summary, acked_serial, change);
 	if (resend)
 		rxrpc_resend(call, skb);
@@ -213,7 +212,6 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 	list_for_each_entry_rcu(txb, &call->tx_buffer, call_link, false) {
 		if (before_eq(txb->seq, call->acks_hard_ack))
 			continue;
-		summary->nr_rot_new_acks++;
 		if (test_bit(RXRPC_TXBUF_LAST, &txb->flags)) {
 			set_bit(RXRPC_CALL_TX_LAST, &call->flags);
 			rot_last = true;
@@ -254,6 +252,11 @@ static void rxrpc_end_tx_phase(struct rxrpc_call *call, bool reply_begun,
 {
 	ASSERT(test_bit(RXRPC_CALL_TX_LAST, &call->flags));
 
+	if (unlikely(call->cong_last_nack)) {
+		rxrpc_free_skb(call->cong_last_nack, rxrpc_skb_put_last_nack);
+		call->cong_last_nack = NULL;
+	}
+
 	switch (__rxrpc_call_state(call)) {
 	case RXRPC_CALL_CLIENT_SEND_REQUEST:
 	case RXRPC_CALL_CLIENT_AWAIT_REPLY:
@@ -702,6 +705,43 @@ static void rxrpc_input_ackinfo(struct rxrpc_call *call, struct sk_buff *skb,
 		wake_up(&call->waitq);
 }
 
+/*
+ * Determine how many nacks from the previous ACK have now been satisfied.
+ */
+static rxrpc_seq_t rxrpc_input_check_prev_ack(struct rxrpc_call *call,
+					      struct rxrpc_ack_summary *summary,
+					      rxrpc_seq_t seq)
+{
+	struct sk_buff *skb = call->cong_last_nack;
+	struct rxrpc_ackpacket ack;
+	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+	unsigned int i, new_acks = 0, retained_nacks = 0;
+	rxrpc_seq_t old_seq = sp->first_ack;
+	u8 *acks = skb->data + sizeof(struct rxrpc_wire_header) + sizeof(ack);
+
+	if (after_eq(seq, old_seq + sp->nr_acks)) {
+		summary->nr_new_acks += sp->nr_nacks;
+		summary->nr_new_acks += seq - (old_seq + sp->nr_acks);
+		summary->nr_retained_nacks = 0;
+	} else if (seq == old_seq) {
+		summary->nr_retained_nacks = sp->nr_nacks;
+	} else {
+		for (i = 0; i < sp->nr_acks; i++) {
+			if (acks[i] == RXRPC_ACK_TYPE_NACK) {
+				if (before(old_seq + i, seq))
+					new_acks++;
+				else
+					retained_nacks++;
+			}
+		}
+
+		summary->nr_new_acks += new_acks;
+		summary->nr_retained_nacks = retained_nacks;
+	}
+
+	return old_seq + sp->nr_acks;
+}
+
 /*
  * Process individual soft ACKs.
  *
@@ -711,25 +751,51 @@ static void rxrpc_input_ackinfo(struct rxrpc_call *call, struct sk_buff *skb,
  * the timer on the basis that the peer might just not have processed them at
  * the time the ACK was sent.
  */
-static void rxrpc_input_soft_acks(struct rxrpc_call *call, u8 *acks,
-				  rxrpc_seq_t seq, int nr_acks,
-				  struct rxrpc_ack_summary *summary)
+static void rxrpc_input_soft_acks(struct rxrpc_call *call,
+				  struct rxrpc_ack_summary *summary,
+				  struct sk_buff *skb,
+				  rxrpc_seq_t seq,
+				  rxrpc_seq_t since)
 {
-	unsigned int i;
+	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+	unsigned int i, old_nacks = 0;
+	rxrpc_seq_t lowest_nak = seq + sp->nr_acks;
+	u8 *acks = skb->data + sizeof(struct rxrpc_wire_header) + sizeof(struct rxrpc_ackpacket);
 
-	for (i = 0; i < nr_acks; i++) {
+	for (i = 0; i < sp->nr_acks; i++) {
 		if (acks[i] == RXRPC_ACK_TYPE_ACK) {
 			summary->nr_acks++;
-			summary->nr_new_acks++;
+			if (after_eq(seq, since))
+				summary->nr_new_acks++;
 		} else {
-			if (!summary->saw_nacks &&
-			    call->acks_lowest_nak != seq + i) {
-				call->acks_lowest_nak = seq + i;
-				summary->new_low_nack = true;
-			}
 			summary->saw_nacks = true;
+			if (before(seq, since)) {
+				/* Overlap with previous ACK */
+				old_nacks++;
+			} else {
+				summary->nr_new_nacks++;
+				sp->nr_nacks++;
+			}
+
+			if (before(seq, lowest_nak))
+				lowest_nak = seq;
 		}
+		seq++;
+	}
+
+	if (lowest_nak != call->acks_lowest_nak) {
+		call->acks_lowest_nak = lowest_nak;
+		summary->new_low_nack = true;
 	}
+
+	/* We *can* have more nacks than we did - the peer is permitted to drop
+	 * packets it has soft-acked and re-request them.  Further, it is
+	 * possible for the nack distribution to change whilst the number of
+	 * nacks stays the same or goes down.
+	 */
+	if (old_nacks < summary->nr_retained_nacks)
+		summary->nr_new_acks += summary->nr_retained_nacks - old_nacks;
+	summary->nr_retained_nacks = old_nacks;
 }
 
 /*
@@ -773,7 +839,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct rxrpc_ackinfo info;
 	rxrpc_serial_t ack_serial, acked_serial;
-	rxrpc_seq_t first_soft_ack, hard_ack, prev_pkt;
+	rxrpc_seq_t first_soft_ack, hard_ack, prev_pkt, since;
 	int nr_acks, offset, ioffset;
 
 	_enter("");
@@ -789,6 +855,8 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	prev_pkt = ntohl(ack.previousPacket);
 	hard_ack = first_soft_ack - 1;
 	nr_acks = ack.nAcks;
+	sp->first_ack = first_soft_ack;
+	sp->nr_acks = nr_acks;
 	summary.ack_reason = (ack.reason < RXRPC_ACK__INVALID ?
 			      ack.reason : RXRPC_ACK__INVALID);
 
@@ -858,6 +926,16 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	if (nr_acks > 0)
 		skb_condense(skb);
 
+	if (call->cong_last_nack) {
+		since = rxrpc_input_check_prev_ack(call, &summary, first_soft_ack);
+		rxrpc_free_skb(call->cong_last_nack, rxrpc_skb_put_last_nack);
+		call->cong_last_nack = NULL;
+	} else {
+		summary.nr_new_acks = first_soft_ack - call->acks_first_seq;
+		call->acks_lowest_nak = first_soft_ack + nr_acks;
+		since = first_soft_ack;
+	}
+
 	call->acks_latest_ts = skb->tstamp;
 	call->acks_first_seq = first_soft_ack;
 	call->acks_prev_seq = prev_pkt;
@@ -866,7 +944,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	case RXRPC_ACK_PING:
 		break;
 	default:
-		if (after(acked_serial, call->acks_highest_serial))
+		if (acked_serial && after(acked_serial, call->acks_highest_serial))
 			call->acks_highest_serial = acked_serial;
 		break;
 	}
@@ -905,8 +983,9 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 	if (nr_acks > 0) {
 		if (offset > (int)skb->len - nr_acks)
 			return rxrpc_proto_abort(call, 0, rxrpc_eproto_ackr_short_sack);
-		rxrpc_input_soft_acks(call, skb->data + offset, first_soft_ack,
-				      nr_acks, &summary);
+		rxrpc_input_soft_acks(call, &summary, skb, first_soft_ack, since);
+		rxrpc_get_skb(skb, rxrpc_skb_get_last_nack);
+		call->cong_last_nack = skb;
 	}
 
 	if (test_bit(RXRPC_CALL_TX_LAST, &call->flags) &&
diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index a0906145e829..4a292f860ae3 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -216,7 +216,7 @@ int rxrpc_send_ack_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	iov[0].iov_len	= sizeof(txb->wire) + sizeof(txb->ack) + n;
 	len = iov[0].iov_len;
 
-	serial = atomic_inc_return(&conn->serial);
+	serial = rxrpc_get_next_serial(conn);
 	txb->wire.serial = htonl(serial);
 	trace_rxrpc_tx_ack(call->debug_id, serial,
 			   ntohl(txb->ack.firstPacket),
@@ -302,7 +302,7 @@ int rxrpc_send_abort_packet(struct rxrpc_call *call)
 	iov[0].iov_base	= &pkt;
 	iov[0].iov_len	= sizeof(pkt);
 
-	serial = atomic_inc_return(&conn->serial);
+	serial = rxrpc_get_next_serial(conn);
 	pkt.whdr.serial = htonl(serial);
 
 	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 1, sizeof(pkt));
@@ -334,7 +334,7 @@ int rxrpc_send_data_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 	_enter("%x,{%d}", txb->seq, txb->len);
 
 	/* Each transmission of a Tx packet needs a new serial number */
-	serial = atomic_inc_return(&conn->serial);
+	serial = rxrpc_get_next_serial(conn);
 	txb->wire.serial = htonl(serial);
 
 	if (test_bit(RXRPC_CONN_PROBING_FOR_UPGRADE, &conn->flags) &&
@@ -558,7 +558,7 @@ void rxrpc_send_conn_abort(struct rxrpc_connection *conn)
 
 	len = iov[0].iov_len + iov[1].iov_len;
 
-	serial = atomic_inc_return(&conn->serial);
+	serial = rxrpc_get_next_serial(conn);
 	whdr.serial = htonl(serial);
 
 	iov_iter_kvec(&msg.msg_iter, WRITE, iov, 2, len);
diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index 682636d3b060..208312c244f6 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -181,7 +181,7 @@ static int rxrpc_connection_seq_show(struct seq_file *seq, void *v)
 		   atomic_read(&conn->active),
 		   state,
 		   key_serial(conn->key),
-		   atomic_read(&conn->serial),
+		   conn->tx_serial,
 		   conn->hi_serial,
 		   conn->channels[0].call_id,
 		   conn->channels[1].call_id,
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index b52dedcebce0..6b32d61d4cdc 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -664,7 +664,7 @@ static int rxkad_issue_challenge(struct rxrpc_connection *conn)
 
 	len = iov[0].iov_len + iov[1].iov_len;
 
-	serial = atomic_inc_return(&conn->serial);
+	serial = rxrpc_get_next_serial(conn);
 	whdr.serial = htonl(serial);
 
 	ret = kernel_sendmsg(conn->local->socket, &msg, iov, 2, len);
@@ -721,7 +721,7 @@ static int rxkad_send_response(struct rxrpc_connection *conn,
 
 	len = iov[0].iov_len + iov[1].iov_len + iov[2].iov_len;
 
-	serial = atomic_inc_return(&conn->serial);
+	serial = rxrpc_get_next_serial(conn);
 	whdr.serial = htonl(serial);
 
 	rxrpc_local_dont_fragment(conn->local, false);
diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 2cde375477e3..878415c43527 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -1086,6 +1086,12 @@ int tipc_nl_bearer_add(struct sk_buff *skb, struct genl_info *info)
 
 #ifdef CONFIG_TIPC_MEDIA_UDP
 	if (attrs[TIPC_NLA_BEARER_UDP_OPTS]) {
+		if (b->media->type_id != TIPC_MEDIA_TYPE_UDP) {
+			rtnl_unlock();
+			NL_SET_ERR_MSG(info->extack, "UDP option is unsupported");
+			return -EINVAL;
+		}
+
 		err = tipc_udp_nl_bearer_add(b,
 					     attrs[TIPC_NLA_BEARER_UDP_OPTS]);
 		if (err) {
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 2405f0f9af31..8f63f0b4bf01 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -314,6 +314,17 @@ void unix_gc(void)
 	/* Here we are. Hitlist is filled. Die. */
 	__skb_queue_purge(&hitlist);
 
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+	list_for_each_entry_safe(u, next, &gc_candidates, link) {
+		struct sk_buff *skb = u->oob_skb;
+
+		if (skb) {
+			u->oob_skb = NULL;
+			kfree_skb(skb);
+		}
+	}
+#endif
+
 	spin_lock(&unix_gc_lock);
 
 	/* There could be io_uring registered files, just push them back to
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index b9da6f5152cb..3f49f5c69916 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1725,6 +1725,61 @@ static void cfg80211_update_hidden_bsses(struct cfg80211_internal_bss *known,
 	}
 }
 
+static void cfg80211_check_stuck_ecsa(struct cfg80211_registered_device *rdev,
+				      struct cfg80211_internal_bss *known,
+				      const struct cfg80211_bss_ies *old)
+{
+	const struct ieee80211_ext_chansw_ie *ecsa;
+	const struct element *elem_new, *elem_old;
+	const struct cfg80211_bss_ies *new, *bcn;
+
+	if (known->pub.proberesp_ecsa_stuck)
+		return;
+
+	new = rcu_dereference_protected(known->pub.proberesp_ies,
+					lockdep_is_held(&rdev->bss_lock));
+	if (WARN_ON(!new))
+		return;
+
+	if (new->tsf - old->tsf < USEC_PER_SEC)
+		return;
+
+	elem_old = cfg80211_find_elem(WLAN_EID_EXT_CHANSWITCH_ANN,
+				      old->data, old->len);
+	if (!elem_old)
+		return;
+
+	elem_new = cfg80211_find_elem(WLAN_EID_EXT_CHANSWITCH_ANN,
+				      new->data, new->len);
+	if (!elem_new)
+		return;
+
+	bcn = rcu_dereference_protected(known->pub.beacon_ies,
+					lockdep_is_held(&rdev->bss_lock));
+	if (bcn &&
+	    cfg80211_find_elem(WLAN_EID_EXT_CHANSWITCH_ANN,
+			       bcn->data, bcn->len))
+		return;
+
+	if (elem_new->datalen != elem_old->datalen)
+		return;
+	if (elem_new->datalen < sizeof(struct ieee80211_ext_chansw_ie))
+		return;
+	if (memcmp(elem_new->data, elem_old->data, elem_new->datalen))
+		return;
+
+	ecsa = (void *)elem_new->data;
+
+	if (!ecsa->mode)
+		return;
+
+	if (ecsa->new_ch_num !=
+	    ieee80211_frequency_to_channel(known->pub.channel->center_freq))
+		return;
+
+	known->pub.proberesp_ecsa_stuck = 1;
+}
+
 static bool
 cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 			  struct cfg80211_internal_bss *known,
@@ -1744,9 +1799,13 @@ cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 		/* Override possible earlier Beacon frame IEs */
 		rcu_assign_pointer(known->pub.ies,
 				   new->pub.proberesp_ies);
-		if (old)
+		if (old) {
+			cfg80211_check_stuck_ecsa(rdev, known, old);
 			kfree_rcu((struct cfg80211_bss_ies *)old, rcu_head);
-	} else if (rcu_access_pointer(new->pub.beacon_ies)) {
+		}
+	}
+
+	if (rcu_access_pointer(new->pub.beacon_ies)) {
 		const struct cfg80211_bss_ies *old;
 
 		if (known->pub.hidden_beacon_bss &&
diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index dea6d367b9e8..3bc4b2e41650 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -3,7 +3,7 @@
 // This file is provided under a dual BSD/GPLv2 license. When using or
 // redistributing this file, you may do so under either license.
 //
-// Copyright(c) 2021, 2023 Advanced Micro Devices, Inc.
+// Copyright(c) 2021 Advanced Micro Devices, Inc.
 //
 // Authors: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
 //
@@ -47,19 +47,6 @@ static const struct config_entry config_table[] = {
 			{}
 		},
 	},
-	{
-		.flags = FLAG_AMD_LEGACY,
-		.device = ACP_PCI_DEV_ID,
-		.dmi_table = (const struct dmi_system_id []) {
-			{
-				.matches = {
-					DMI_MATCH(DMI_SYS_VENDOR, "Valve"),
-					DMI_MATCH(DMI_PRODUCT_NAME, "Jupiter"),
-				},
-			},
-			{}
-		},
-	},
 	{
 		.flags = FLAG_AMD_SOF,
 		.device = ACP_PCI_DEV_ID,
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 07cc6a201579..09712e61c606 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2031,10 +2031,14 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x0499, 0x1509, /* Steinberg UR22 */
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
+	DEVICE_FLG(0x0499, 0x3108, /* Yamaha YIT-W12TX */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x04d8, 0xfeea, /* Benchmark DAC1 Pre */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x04e8, 0xa051, /* Samsung USBC Headset (AKG) */
 		   QUIRK_FLAG_SKIP_CLOCK_SELECTOR | QUIRK_FLAG_CTL_MSG_DELAY_5M),
+	DEVICE_FLG(0x0525, 0xa4ad, /* Hamedal C20 usb camero */
+		   QUIRK_FLAG_IFACE_SKIP_CLOSE),
 	DEVICE_FLG(0x054c, 0x0b8c, /* Sony WALKMAN NW-A45 DAC */
 		   QUIRK_FLAG_SET_IFACE_FIRST),
 	DEVICE_FLG(0x0556, 0x0014, /* Phoenix Audio TMX320VC */
@@ -2073,14 +2077,22 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x0763, 0x2031, /* M-Audio Fast Track C600 */
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
+	DEVICE_FLG(0x07fd, 0x000b, /* MOTU M Series 2nd hardware revision */
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x08bb, 0x2702, /* LineX FM Transmitter */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x0951, 0x16ad, /* Kingston HyperX */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0b0e, 0x0349, /* Jabra 550a */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
+	DEVICE_FLG(0x0ecb, 0x205c, /* JBL Quantum610 Wireless */
+		   QUIRK_FLAG_FIXED_RATE),
+	DEVICE_FLG(0x0ecb, 0x2069, /* JBL Quantum810 Wireless */
+		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x0fd9, 0x0008, /* Hauppauge HVR-950Q */
 		   QUIRK_FLAG_SHARE_MEDIA_DEVICE | QUIRK_FLAG_ALIGN_TRANSFER),
+	DEVICE_FLG(0x1224, 0x2a25, /* Jieli Technology USB PHY 2.0 */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x1395, 0x740a, /* Sennheiser DECT */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x1397, 0x0507, /* Behringer UMC202HD */
@@ -2113,6 +2125,10 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_ITF_USB_DSD_DAC | QUIRK_FLAG_CTL_MSG_DELAY),
 	DEVICE_FLG(0x1901, 0x0191, /* GE B850V3 CP2114 audio interface */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x19f7, 0x0035, /* RODE NT-USB+ */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x1bcf, 0x2283, /* NexiGo N930AF FHD Webcam */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x2040, 0x7200, /* Hauppauge HVR-950Q */
 		   QUIRK_FLAG_SHARE_MEDIA_DEVICE | QUIRK_FLAG_ALIGN_TRANSFER),
 	DEVICE_FLG(0x2040, 0x7201, /* Hauppauge HVR-950Q-MXL */
@@ -2155,6 +2171,12 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x2912, 0x30c8, /* Audioengine D1 */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x2b53, 0x0023, /* Fiero SC-01 (firmware v1.0.0 @ 48 kHz) */
+		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
+	DEVICE_FLG(0x2b53, 0x0024, /* Fiero SC-01 (firmware v1.0.0 @ 96 kHz) */
+		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
+	DEVICE_FLG(0x2b53, 0x0031, /* Fiero SC-01 (firmware v1.1.0) */
+		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x30be, 0x0101, /* Schiit Hel */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x413c, 0xa506, /* Dell AE515 sound bar */
@@ -2163,22 +2185,6 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_ALIGN_TRANSFER),
 	DEVICE_FLG(0x534d, 0x2109, /* MacroSilicon MS2109 */
 		   QUIRK_FLAG_ALIGN_TRANSFER),
-	DEVICE_FLG(0x1224, 0x2a25, /* Jieli Technology USB PHY 2.0 */
-		   QUIRK_FLAG_GET_SAMPLE_RATE),
-	DEVICE_FLG(0x2b53, 0x0023, /* Fiero SC-01 (firmware v1.0.0 @ 48 kHz) */
-		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
-	DEVICE_FLG(0x2b53, 0x0024, /* Fiero SC-01 (firmware v1.0.0 @ 96 kHz) */
-		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
-	DEVICE_FLG(0x2b53, 0x0031, /* Fiero SC-01 (firmware v1.1.0) */
-		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
-	DEVICE_FLG(0x0525, 0xa4ad, /* Hamedal C20 usb camero */
-		   QUIRK_FLAG_IFACE_SKIP_CLOSE),
-	DEVICE_FLG(0x0ecb, 0x205c, /* JBL Quantum610 Wireless */
-		   QUIRK_FLAG_FIXED_RATE),
-	DEVICE_FLG(0x0ecb, 0x2069, /* JBL Quantum810 Wireless */
-		   QUIRK_FLAG_FIXED_RATE),
-	DEVICE_FLG(0x1bcf, 0x2283, /* NexiGo N930AF FHD Webcam */
-		   QUIRK_FLAG_GET_SAMPLE_RATE),
 
 	/* Vendor matches */
 	VENDOR_FLG(0x045e, /* MS Lifecam */
diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/script.sh
new file mode 100755
index 000000000000..2973adab445d
--- /dev/null
+++ b/tools/perf/tests/shell/script.sh
@@ -0,0 +1,73 @@
+#!/bin/sh
+# perf script tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+temp_dir=$(mktemp -d /tmp/perf-test-script.XXXXXXXXXX)
+
+perfdatafile="${temp_dir}/perf.data"
+db_test="${temp_dir}/db_test.py"
+
+err=0
+
+cleanup()
+{
+	trap - EXIT TERM INT
+	sane=$(echo "${temp_dir}" | cut -b 1-21)
+	if [ "${sane}" = "/tmp/perf-test-script" ] ; then
+		echo "--- Cleaning up ---"
+		rm -f "${temp_dir}/"*
+		rmdir "${temp_dir}"
+	fi
+}
+
+trap_cleanup()
+{
+	cleanup
+	exit 1
+}
+
+trap trap_cleanup EXIT TERM INT
+
+
+test_db()
+{
+	echo "DB test"
+
+	# Check if python script is supported
+	libpython=$(perf version --build-options | grep python | grep -cv OFF)
+	if [ "${libpython}" != "1" ] ; then
+		echo "SKIP: python scripting is not supported"
+		err=2
+		return
+	fi
+
+	cat << "_end_of_file_" > "${db_test}"
+perf_db_export_mode = True
+perf_db_export_calls = False
+perf_db_export_callchains = True
+
+def sample_table(*args):
+    print(f'sample_table({args})')
+
+def call_path_table(*args):
+    print(f'call_path_table({args}')
+_end_of_file_
+	case $(uname -m)
+	in s390x)
+		cmd_flags="--call-graph dwarf -e cpu-clock";;
+	*)
+		cmd_flags="-g";;
+	esac
+
+	perf record $cmd_flags -o "${perfdatafile}" true
+	perf script -i "${perfdatafile}" -s "${db_test}"
+	echo "DB test [Success]"
+}
+
+test_db
+
+cleanup
+
+exit $err
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e36da58522ef..b0ed14a6da9d 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -103,7 +103,14 @@ struct evlist *evlist__new_default(void)
 	err = parse_event(evlist, can_profile_kernel ? "cycles:P" : "cycles:Pu");
 	if (err) {
 		evlist__delete(evlist);
-		evlist = NULL;
+		return NULL;
+	}
+
+	if (evlist->core.nr_entries > 1) {
+		struct evsel *evsel;
+
+		evlist__for_each_entry(evlist, evsel)
+			evsel__set_sample_id(evsel, /*can_sample_identifier=*/false);
 	}
 
 	return evlist;
diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index 534576f06df1..c59e4adb905d 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -12,6 +12,7 @@
 #include <syscall.h>
 #include <unistd.h>
 #include <sys/resource.h>
+#include <linux/close_range.h>
 
 #include "../kselftest_harness.h"
 #include "../clone3/clone3_selftests.h"
diff --git a/tools/testing/selftests/net/big_tcp.sh b/tools/testing/selftests/net/big_tcp.sh
index cde9a91c4797..2db9d15cd45f 100755
--- a/tools/testing/selftests/net/big_tcp.sh
+++ b/tools/testing/selftests/net/big_tcp.sh
@@ -122,7 +122,9 @@ do_netperf() {
 	local netns=$1
 
 	[ "$NF" = "6" ] && serip=$SERVER_IP6
-	ip net exec $netns netperf -$NF -t TCP_STREAM -H $serip 2>&1 >/dev/null
+
+	# use large write to be sure to generate big tcp packets
+	ip net exec $netns netperf -$NF -t TCP_STREAM -l 1 -H $serip -- -m 262144 2>&1 >/dev/null
 }
 
 do_test() {
diff --git a/tools/testing/selftests/net/cmsg_ipv6.sh b/tools/testing/selftests/net/cmsg_ipv6.sh
index 330d0b1ceced..c921750ca118 100755
--- a/tools/testing/selftests/net/cmsg_ipv6.sh
+++ b/tools/testing/selftests/net/cmsg_ipv6.sh
@@ -91,7 +91,7 @@ for ovr in setsock cmsg both diff; do
 	check_result $? 0 "TCLASS $prot $ovr - pass"
 
 	while [ -d /proc/$BG ]; do
-	    $NSEXE ./cmsg_sender -6 -p u $TGT6 1234
+	    $NSEXE ./cmsg_sender -6 -p $p $m $((TOS2)) $TGT6 1234
 	done
 
 	tcpdump -r $TMPF -v 2>&1 | grep "class $TOS2" >> /dev/null
@@ -128,7 +128,7 @@ for ovr in setsock cmsg both diff; do
 	check_result $? 0 "HOPLIMIT $prot $ovr - pass"
 
 	while [ -d /proc/$BG ]; do
-	    $NSEXE ./cmsg_sender -6 -p u $TGT6 1234
+	    $NSEXE ./cmsg_sender -6 -p $p $m $LIM $TGT6 1234
 	done
 
 	tcpdump -r $TMPF -v 2>&1 | grep "hlim $LIM[^0-9]" >> /dev/null
diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 4a5f031be232..d65fdd407d73 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 #
 # Check that route PMTU values match expectations, and that initial device MTU
@@ -198,8 +198,8 @@
 # - pmtu_ipv6_route_change
 #	Same as above but with IPv6
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
+source lib.sh
+source net_helper.sh
 
 PAUSE_ON_FAIL=no
 VERBOSE=0
@@ -268,16 +268,6 @@ tests="
 	pmtu_ipv4_route_change		ipv4: PMTU exception w/route replace	1
 	pmtu_ipv6_route_change		ipv6: PMTU exception w/route replace	1"
 
-NS_A="ns-A"
-NS_B="ns-B"
-NS_C="ns-C"
-NS_R1="ns-R1"
-NS_R2="ns-R2"
-ns_a="ip netns exec ${NS_A}"
-ns_b="ip netns exec ${NS_B}"
-ns_c="ip netns exec ${NS_C}"
-ns_r1="ip netns exec ${NS_R1}"
-ns_r2="ip netns exec ${NS_R2}"
 # Addressing and routing for tests with routers: four network segments, with
 # index SEGMENT between 1 and 4, a common prefix (PREFIX4 or PREFIX6) and an
 # identifier ID, which is 1 for hosts (A and B), 2 for routers (R1 and R2).
@@ -543,13 +533,17 @@ setup_ip6ip6() {
 }
 
 setup_namespaces() {
+	setup_ns NS_A NS_B NS_C NS_R1 NS_R2
 	for n in ${NS_A} ${NS_B} ${NS_C} ${NS_R1} ${NS_R2}; do
-		ip netns add ${n} || return 1
-
 		# Disable DAD, so that we don't have to wait to use the
 		# configured IPv6 addresses
 		ip netns exec ${n} sysctl -q net/ipv6/conf/default/accept_dad=0
 	done
+	ns_a="ip netns exec ${NS_A}"
+	ns_b="ip netns exec ${NS_B}"
+	ns_c="ip netns exec ${NS_C}"
+	ns_r1="ip netns exec ${NS_R1}"
+	ns_r2="ip netns exec ${NS_R2}"
 }
 
 setup_veth() {
@@ -839,7 +833,7 @@ setup_bridge() {
 	run_cmd ${ns_a} ip link set br0 up
 
 	run_cmd ${ns_c} ip link add veth_C-A type veth peer name veth_A-C
-	run_cmd ${ns_c} ip link set veth_A-C netns ns-A
+	run_cmd ${ns_c} ip link set veth_A-C netns ${NS_A}
 
 	run_cmd ${ns_a} ip link set veth_A-C up
 	run_cmd ${ns_c} ip link set veth_C-A up
@@ -944,9 +938,7 @@ cleanup() {
 	done
 	socat_pids=
 
-	for n in ${NS_A} ${NS_B} ${NS_C} ${NS_R1} ${NS_R2}; do
-		ip netns del ${n} 2> /dev/null
-	done
+	cleanup_all_ns
 
 	ip link del veth_A-C			2>/dev/null
 	ip link del veth_A-R1			2>/dev/null
@@ -1345,13 +1337,15 @@ test_pmtu_ipvX_over_bridged_vxlanY_or_geneveY_exception() {
 			TCPDST="TCP:[${dst}]:50000"
 		fi
 		${ns_b} socat -T 3 -u -6 TCP-LISTEN:50000 STDOUT > $tmpoutfile &
+		local socat_pid=$!
 
-		sleep 1
+		wait_local_port_listen ${NS_B} 50000 tcp
 
 		dd if=/dev/zero status=none bs=1M count=1 | ${target} socat -T 3 -u STDIN $TCPDST,connect-timeout=3
 
 		size=$(du -sb $tmpoutfile)
 		size=${size%%/tmp/*}
+		wait ${socat_pid}
 
 		[ $size -ne 1048576 ] && err "File size $size mismatches exepcted value in locally bridged vxlan test" && return 1
 	done
@@ -1963,6 +1957,13 @@ check_command() {
 	return 0
 }
 
+check_running() {
+	pid=${1}
+	cmd=${2}
+
+	[ "$(cat /proc/${pid}/cmdline 2>/dev/null | tr -d '\0')" = "{cmd}" ]
+}
+
 test_cleanup_vxlanX_exception() {
 	outer="${1}"
 	encap="vxlan"
@@ -1993,11 +1994,12 @@ test_cleanup_vxlanX_exception() {
 
 	${ns_a} ip link del dev veth_A-R1 &
 	iplink_pid=$!
-	sleep 1
-	if [ "$(cat /proc/${iplink_pid}/cmdline 2>/dev/null | tr -d '\0')" = "iplinkdeldevveth_A-R1" ]; then
-		err "  can't delete veth device in a timely manner, PMTU dst likely leaked"
-		return 1
-	fi
+	for i in $(seq 1 20); do
+		check_running ${iplink_pid} "iplinkdeldevveth_A-R1" || return 0
+		sleep 0.1
+	done
+	err "  can't delete veth device in a timely manner, PMTU dst likely leaked"
+	return 1
 }
 
 test_cleanup_ipv6_exception() {
diff --git a/tools/testing/selftests/net/udpgro_fwd.sh b/tools/testing/selftests/net/udpgro_fwd.sh
index d6b9c759043c..9cd5e885e91f 100755
--- a/tools/testing/selftests/net/udpgro_fwd.sh
+++ b/tools/testing/selftests/net/udpgro_fwd.sh
@@ -39,6 +39,10 @@ create_ns() {
 	for ns in $NS_SRC $NS_DST; do
 		ip netns add $ns
 		ip -n $ns link set dev lo up
+
+		# disable route solicitations to decrease 'noise' traffic
+		ip netns exec $ns sysctl -qw net.ipv6.conf.default.router_solicitations=0
+		ip netns exec $ns sysctl -qw net.ipv6.conf.all.router_solicitations=0
 	done
 
 	ip link add name veth$SRC type veth peer name veth$DST
@@ -80,6 +84,12 @@ create_vxlan_pair() {
 		create_vxlan_endpoint $BASE$ns veth$ns $BM_NET_V6$((3 - $ns)) vxlan6$ns 6
 		ip -n $BASE$ns addr add dev vxlan6$ns $OL_NET_V6$ns/24 nodad
 	done
+
+	# preload neighbur cache, do avoid some noisy traffic
+	local addr_dst=$(ip -j -n $BASE$DST link show dev vxlan6$DST  |jq -r '.[]["address"]')
+	local addr_src=$(ip -j -n $BASE$SRC link show dev vxlan6$SRC  |jq -r '.[]["address"]')
+	ip -n $BASE$DST neigh add dev vxlan6$DST lladdr $addr_src $OL_NET_V6$SRC
+	ip -n $BASE$SRC neigh add dev vxlan6$SRC lladdr $addr_dst $OL_NET_V6$DST
 }
 
 is_ipv6() {
@@ -119,7 +129,7 @@ run_test() {
 	# not enable GRO
 	ip netns exec $NS_DST $ipt -A INPUT -p udp --dport 4789
 	ip netns exec $NS_DST $ipt -A INPUT -p udp --dport 8000
-	ip netns exec $NS_DST ./udpgso_bench_rx -C 1000 -R 10 -n 10 -l 1300 $rx_args &
+	ip netns exec $NS_DST ./udpgso_bench_rx -C 2000 -R 100 -n 10 -l 1300 $rx_args &
 	local spid=$!
 	wait_local_port_listen "$NS_DST" 8000 udp
 	ip netns exec $NS_SRC ./udpgso_bench_tx $family -M 1 -s 13000 -S 1300 -D $dst
@@ -168,7 +178,7 @@ run_bench() {
 	# bind the sender and the receiver to different CPUs to try
 	# get reproducible results
 	ip netns exec $NS_DST bash -c "echo 2 > /sys/class/net/veth$DST/queues/rx-0/rps_cpus"
-	ip netns exec $NS_DST taskset 0x2 ./udpgso_bench_rx -C 1000 -R 10  &
+	ip netns exec $NS_DST taskset 0x2 ./udpgso_bench_rx -C 2000 -R 100  &
 	local spid=$!
 	wait_local_port_listen "$NS_DST" 8000 udp
 	ip netns exec $NS_SRC taskset 0x1 ./udpgso_bench_tx $family -l 3 -S 1300 -D $dst
diff --git a/tools/testing/selftests/net/udpgso_bench_rx.c b/tools/testing/selftests/net/udpgso_bench_rx.c
index f35a924d4a30..1cbadd267c96 100644
--- a/tools/testing/selftests/net/udpgso_bench_rx.c
+++ b/tools/testing/selftests/net/udpgso_bench_rx.c
@@ -375,7 +375,7 @@ static void do_recv(void)
 			do_flush_udp(fd);
 
 		tnow = gettimeofday_ms();
-		if (tnow > treport) {
+		if (!cfg_expected_pkt_nr && tnow > treport) {
 			if (packets)
 				fprintf(stderr,
 					"%s rx: %6lu MB/s %8lu calls/s\n",
diff --git a/tools/testing/selftests/net/unicast_extensions.sh b/tools/testing/selftests/net/unicast_extensions.sh
index 2d10ccac898a..f52aa5f7da52 100755
--- a/tools/testing/selftests/net/unicast_extensions.sh
+++ b/tools/testing/selftests/net/unicast_extensions.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 #
 # By Seth Schoen (c) 2021, for the IPv4 Unicast Extensions Project
@@ -28,8 +28,7 @@
 # These tests provide an easy way to flip the expected result of any
 # of these behaviors for testing kernel patches that change them.
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
+source lib.sh
 
 # nettest can be run from PATH or from same directory as this selftest
 if ! which nettest >/dev/null; then
@@ -61,20 +60,20 @@ _do_segmenttest(){
 	# foo --- bar
 	# Arguments: ip_a ip_b prefix_length test_description
 	#
-	# Caller must set up foo-ns and bar-ns namespaces
+	# Caller must set up $foo_ns and $bar_ns namespaces
 	# containing linked veth devices foo and bar,
 	# respectively.
 
-	ip -n foo-ns address add $1/$3 dev foo || return 1
-	ip -n foo-ns link set foo up || return 1
-	ip -n bar-ns address add $2/$3 dev bar || return 1
-	ip -n bar-ns link set bar up || return 1
+	ip -n $foo_ns address add $1/$3 dev foo || return 1
+	ip -n $foo_ns link set foo up || return 1
+	ip -n $bar_ns address add $2/$3 dev bar || return 1
+	ip -n $bar_ns link set bar up || return 1
 
-	ip netns exec foo-ns timeout 2 ping -c 1 $2 || return 1
-	ip netns exec bar-ns timeout 2 ping -c 1 $1 || return 1
+	ip netns exec $foo_ns timeout 2 ping -c 1 $2 || return 1
+	ip netns exec $bar_ns timeout 2 ping -c 1 $1 || return 1
 
-	nettest -B -N bar-ns -O foo-ns -r $1 || return 1
-	nettest -B -N foo-ns -O bar-ns -r $2 || return 1
+	nettest -B -N $bar_ns -O $foo_ns -r $1 || return 1
+	nettest -B -N $foo_ns -O $bar_ns -r $2 || return 1
 
 	return 0
 }
@@ -88,31 +87,31 @@ _do_route_test(){
 	# Arguments: foo_ip foo1_ip bar1_ip bar_ip prefix_len test_description
 	# Displays test result and returns success or failure.
 
-	# Caller must set up foo-ns, bar-ns, and router-ns
+	# Caller must set up $foo_ns, $bar_ns, and $router_ns
 	# containing linked veth devices foo-foo1, bar1-bar
-	# (foo in foo-ns, foo1 and bar1 in router-ns, and
-	# bar in bar-ns).
-
-	ip -n foo-ns address add $1/$5 dev foo || return 1
-	ip -n foo-ns link set foo up || return 1
-	ip -n foo-ns route add default via $2 || return 1
-	ip -n bar-ns address add $4/$5 dev bar || return 1
-	ip -n bar-ns link set bar up || return 1
-	ip -n bar-ns route add default via $3 || return 1
-	ip -n router-ns address add $2/$5 dev foo1 || return 1
-	ip -n router-ns link set foo1 up || return 1
-	ip -n router-ns address add $3/$5 dev bar1 || return 1
-	ip -n router-ns link set bar1 up || return 1
-
-	echo 1 | ip netns exec router-ns tee /proc/sys/net/ipv4/ip_forward
-
-	ip netns exec foo-ns timeout 2 ping -c 1 $2 || return 1
-	ip netns exec foo-ns timeout 2 ping -c 1 $4 || return 1
-	ip netns exec bar-ns timeout 2 ping -c 1 $3 || return 1
-	ip netns exec bar-ns timeout 2 ping -c 1 $1 || return 1
-
-	nettest -B -N bar-ns -O foo-ns -r $1 || return 1
-	nettest -B -N foo-ns -O bar-ns -r $4 || return 1
+	# (foo in $foo_ns, foo1 and bar1 in $router_ns, and
+	# bar in $bar_ns).
+
+	ip -n $foo_ns address add $1/$5 dev foo || return 1
+	ip -n $foo_ns link set foo up || return 1
+	ip -n $foo_ns route add default via $2 || return 1
+	ip -n $bar_ns address add $4/$5 dev bar || return 1
+	ip -n $bar_ns link set bar up || return 1
+	ip -n $bar_ns route add default via $3 || return 1
+	ip -n $router_ns address add $2/$5 dev foo1 || return 1
+	ip -n $router_ns link set foo1 up || return 1
+	ip -n $router_ns address add $3/$5 dev bar1 || return 1
+	ip -n $router_ns link set bar1 up || return 1
+
+	echo 1 | ip netns exec $router_ns tee /proc/sys/net/ipv4/ip_forward
+
+	ip netns exec $foo_ns timeout 2 ping -c 1 $2 || return 1
+	ip netns exec $foo_ns timeout 2 ping -c 1 $4 || return 1
+	ip netns exec $bar_ns timeout 2 ping -c 1 $3 || return 1
+	ip netns exec $bar_ns timeout 2 ping -c 1 $1 || return 1
+
+	nettest -B -N $bar_ns -O $foo_ns -r $1 || return 1
+	nettest -B -N $foo_ns -O $bar_ns -r $4 || return 1
 
 	return 0
 }
@@ -121,17 +120,15 @@ segmenttest(){
 	# Sets up veth link and tries to connect over it.
 	# Arguments: ip_a ip_b prefix_len test_description
 	hide_output
-	ip netns add foo-ns
-	ip netns add bar-ns
-	ip link add foo netns foo-ns type veth peer name bar netns bar-ns
+	setup_ns foo_ns bar_ns
+	ip link add foo netns $foo_ns type veth peer name bar netns $bar_ns
 
 	test_result=0
 	_do_segmenttest "$@" || test_result=1
 
-	ip netns pids foo-ns | xargs -r kill -9
-	ip netns pids bar-ns | xargs -r kill -9
-	ip netns del foo-ns
-	ip netns del bar-ns
+	ip netns pids $foo_ns | xargs -r kill -9
+	ip netns pids $bar_ns | xargs -r kill -9
+	cleanup_ns $foo_ns $bar_ns
 	show_output
 
 	# inverted tests will expect failure instead of success
@@ -147,21 +144,17 @@ route_test(){
 	# Returns success or failure.
 
 	hide_output
-	ip netns add foo-ns
-	ip netns add bar-ns
-	ip netns add router-ns
-	ip link add foo netns foo-ns type veth peer name foo1 netns router-ns
-	ip link add bar netns bar-ns type veth peer name bar1 netns router-ns
+	setup_ns foo_ns bar_ns router_ns
+	ip link add foo netns $foo_ns type veth peer name foo1 netns $router_ns
+	ip link add bar netns $bar_ns type veth peer name bar1 netns $router_ns
 
 	test_result=0
 	_do_route_test "$@" || test_result=1
 
-	ip netns pids foo-ns | xargs -r kill -9
-	ip netns pids bar-ns | xargs -r kill -9
-	ip netns pids router-ns | xargs -r kill -9
-	ip netns del foo-ns
-	ip netns del bar-ns
-	ip netns del router-ns
+	ip netns pids $foo_ns | xargs -r kill -9
+	ip netns pids $bar_ns | xargs -r kill -9
+	ip netns pids $router_ns | xargs -r kill -9
+	cleanup_ns $foo_ns $bar_ns $router_ns
 
 	show_output
 

