Return-Path: <linux-kernel+bounces-143440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5784B8A3914
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 02:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7683A1C2106E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 00:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D7D803;
	Sat, 13 Apr 2024 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mc4auDzj"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C1D367
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 00:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712967773; cv=none; b=YRnwGoqqLJhbfoEDODuUXA76ZtQaJ/faAy6Jn8YrOEGxY+8hNzKeG+PrtcbxG03Mmlxo6CAi5/qMu5Wlz4PaEEtrsv9043MjU6D0D3lzT9E1QyY8IRqQDV6RV6bNbBj0jZ2Pdx4JIpe2YwNgKyNLnjgJdJiYKM3gcdVmPaZt7wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712967773; c=relaxed/simple;
	bh=X+BMzP/JEIVv8+qx17+SDOwK/gsohYlAHC0TGXAFhrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PES+VOzfs0iewKM6dbyyoH/IbB0lyqCQTdMkGlqWV3fpXE+iW+6yYcPMtCqFdR+/7tdTSwar3jtRKAEgVYsI1MtG6MeVKV8xFK49sGvdLegRN+o6fM14o1Hr5LKhAPexEnsJDBwx9dOttGiaHkqh02ker8meMZ7R43yCnELOBo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mc4auDzj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e51398cc4eso14110775ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 17:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712967771; x=1713572571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zt6lwHTMYCzcNfAGQy6bgUM4No4uIrkQbOTa/d2i2E=;
        b=Mc4auDzjQnHuFt8MJJEEKjBW3m7LU0TEWS2YpjDIW9wxR9eLxyvpc/ws76TAdkSCE+
         fVUg9dgtFxJNwN9poKH1fB212yGHIbyd3ObhX2JkwcuhnEgPjHebyllaLj67pmNx+QVU
         6TG4c1dbgga/Np/gSm3zsohvIp2IPsg1xD3Wk3iMLHhbRed9qbGOD1mrYWEBXsSyaT1j
         h0MzzVhklbZ9/LIypt3SSx04fYw0fFnZBqUw2irxAz8Ym6QRViM+7YJk+QLXJqioGl51
         w26n+Hx1ukK+LBbFl1Auuf2i6DlbOcob+vUnTk89YPMD/kU2InvCaeVCgL2/mDUp3C92
         8ZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712967771; x=1713572571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zt6lwHTMYCzcNfAGQy6bgUM4No4uIrkQbOTa/d2i2E=;
        b=PYiYLKDiyZckSdTe8KvUcUzcWMnbQXYvr6v86RtTIsDOLxA1UA1BnWinn8hLcMjhxa
         lJVSJP1zXfmovvEJleDPcr/lj4czN8ex17hVHuarg9uvb/8Yq2J3bknTg89VWxV68uS1
         kXHfNt2HufiALJGVlTZwGPq1bh5hJ0UD9uj7OhaWE6TW1D3n/jjUKbd6E/Gh3nouXZEX
         UBkVGtbnvCmPuxx2xAs/23Wgif2Z0bD4vFNp+c6AkU4DEUoI7D8MHs/i0sTI8V993Vm1
         cYrLDkPLq3J38VonKTV1L3xzmvrTwAFnCHey79yctVmifqRtS11WqLcePCSrL5zTkKJC
         y32Q==
X-Forwarded-Encrypted: i=1; AJvYcCXiCOAwu62DTxnzPL8oJq35tgi143zXSIZQ14gA3TJXGFVXtF1BJuWBwIKh/MzlrCgNSy98OuKL26kvK09Nz0cn2Nr63VOaKUZwCdhK
X-Gm-Message-State: AOJu0YzYPOPS//rp2y7hTxpnW/tWrgyiqmvjBh4yGdSFbpSj79pfQ1NT
	+166GYFs1FAQamtV81n4sb/kGt3xmgSHugxg08Q8oEUYpXd6bUCU
X-Google-Smtp-Source: AGHT+IFg30nvDhllS3qmuOikRSwPK+gGsIS1czM9V9iuO3CFJO8liJj3qyF+PsnpKvILk+7K+Pl3Qw==
X-Received: by 2002:a17:902:ea0e:b0:1e4:19e3:56cb with SMTP id s14-20020a170902ea0e00b001e419e356cbmr5302017plg.12.1712967770862;
        Fri, 12 Apr 2024 17:22:50 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.217])
        by smtp.gmail.com with ESMTPSA id a17-20020a170902ee9100b001e2a4ac7bf9sm3569618pld.111.2024.04.12.17.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 17:22:50 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: zokeefe@google.com,
	ryan.roberts@arm.com,
	21cnbao@gmail.com,
	shy828301@gmail.com,
	david@redhat.com,
	mhocko@suse.com,
	fengwei.yin@intel.com,
	xiehuan09@gmail.com,
	wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v6 1/2] mm/madvise: optimize lazyfreeing with mTHP in madvise_free
Date: Sat, 13 Apr 2024 08:22:18 +0800
Message-Id: <20240413002219.71246-2-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240413002219.71246-1-ioworker0@gmail.com>
References: <20240413002219.71246-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch optimizes lazyfreeing with PTE-mapped mTHP[1]
(Inspired by David Hildenbrand[2]). We aim to avoid unnecessary folio
splitting if the large folio is fully mapped within the target range.

If a large folio is locked or shared, or if we fail to split it, we just
leave it in place and advance to the next PTE in the range. But note that
the behavior is changed; previously, any failure of this sort would cause
the entire operation to give up. As large folios become more common,
sticking to the old way could result in wasted opportunities.

On an Intel I5 CPU, lazyfreeing a 1GiB VMA backed by PTE-mapped folios of
the same size results in the following runtimes for madvise(MADV_FREE) in
seconds (shorter is better):

Folio Size |   Old    |   New    | Change
------------------------------------------
      4KiB | 0.590251 | 0.590259 |    0%
     16KiB | 2.990447 | 0.185655 |  -94%
     32KiB | 2.547831 | 0.104870 |  -95%
     64KiB | 2.457796 | 0.052812 |  -97%
    128KiB | 2.281034 | 0.032777 |  -99%
    256KiB | 2.230387 | 0.017496 |  -99%
    512KiB | 2.189106 | 0.010781 |  -99%
   1024KiB | 2.183949 | 0.007753 |  -99%
   2048KiB | 0.002799 | 0.002804 |    0%

[1] https://lkml.kernel.org/r/20231207161211.2374093-5-ryan.roberts@arm.com
[2] https://lore.kernel.org/linux-mm/20240214204435.167852-1-david@redhat.com

Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 include/linux/mm_types.h |   9 +++
 include/linux/pgtable.h  |  42 +++++++++++
 mm/internal.h            |  12 +++-
 mm/madvise.c             | 147 ++++++++++++++++++++++-----------------
 mm/memory.c              |   4 +-
 5 files changed, 147 insertions(+), 67 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index c432add95913..3c224e25f473 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1367,6 +1367,15 @@ enum fault_flag {
 
 typedef unsigned int __bitwise zap_flags_t;
 
+/* Flags for clear_young_dirty_ptes(). */
+typedef int __bitwise cydp_t;
+
+/* make PTEs after pte_mkold() */
+#define CYDP_CLEAR_YOUNG		((__force cydp_t)BIT(0))
+
+/* make PTEs after pte_mkclean() */
+#define CYDP_CLEAR_DIRTY		((__force cydp_t)BIT(1))
+
 /*
  * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with each
  * other. Here is what they mean, and how to use them:
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e2f45e22a6d1..d7958243f099 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -489,6 +489,48 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 }
 #endif
 
+#ifndef clear_young_dirty_ptes
+/**
+ * clear_young_dirty_ptes - Mark PTEs that map consecutive pages of the
+ *		same folio as old/clean.
+ * @mm: Address space the pages are mapped into.
+ * @addr: Address the first page is mapped at.
+ * @ptep: Page table pointer for the first entry.
+ * @nr: Number of entries to mark old/clean.
+ * @flags: Flags to modify the PTE batch semantics.
+ *
+ * May be overridden by the architecture; otherwise, implemented by
+ * get_and_clear/modify/set for each pte in the range.
+ *
+ * Note that PTE bits in the PTE range besides the PFN can differ. For example,
+ * some PTEs might be write-protected.
+ *
+ * Context: The caller holds the page table lock.  The PTEs map consecutive
+ * pages that belong to the same folio.  The PTEs are all in the same PMD.
+ */
+static inline void clear_young_dirty_ptes(struct mm_struct *mm,
+					  unsigned long addr, pte_t *ptep,
+					  unsigned int nr, cydp_t flags)
+{
+	pte_t pte;
+
+	for (;;) {
+		pte = ptep_get_and_clear(mm, addr, ptep);
+
+		if (flags | CYDP_CLEAR_YOUNG)
+			pte = pte_mkold(pte);
+		if (flags | CYDP_CLEAR_DIRTY)
+			pte = pte_mkclean(pte);
+
+		set_pte_at(mm, addr, ptep, pte);
+		if (--nr == 0)
+			break;
+		ptep++;
+		addr += PAGE_SIZE;
+	}
+}
+#endif
+
 static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep)
 {
diff --git a/mm/internal.h b/mm/internal.h
index 3c0f3e3f9d99..ab8fcdeaf6eb 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -134,6 +134,8 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
  *		  first one is writable.
  * @any_young: Optional pointer to indicate whether any entry except the
  *		  first one is young.
+ * @any_dirty: Optional pointer to indicate whether any entry except the
+ *		  first one is dirty.
  *
  * Detect a PTE batch: consecutive (present) PTEs that map consecutive
  * pages of the same large folio.
@@ -149,18 +151,20 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
  */
 static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
-		bool *any_writable, bool *any_young)
+		bool *any_writable, bool *any_young, bool *any_dirty)
 {
 	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
 	const pte_t *end_ptep = start_ptep + max_nr;
 	pte_t expected_pte, *ptep;
-	bool writable, young;
+	bool writable, young, dirty;
 	int nr;
 
 	if (any_writable)
 		*any_writable = false;
 	if (any_young)
 		*any_young = false;
+	if (any_dirty)
+		*any_dirty = false;
 
 	VM_WARN_ON_FOLIO(!pte_present(pte), folio);
 	VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);
@@ -176,6 +180,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 			writable = !!pte_write(pte);
 		if (any_young)
 			young = !!pte_young(pte);
+		if (any_dirty)
+			dirty = !!pte_dirty(pte);
 		pte = __pte_batch_clear_ignored(pte, flags);
 
 		if (!pte_same(pte, expected_pte))
@@ -193,6 +199,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 			*any_writable |= writable;
 		if (any_young)
 			*any_young |= young;
+		if (any_dirty)
+			*any_dirty |= dirty;
 
 		nr = pte_batch_hint(ptep, pte);
 		expected_pte = pte_advance_pfn(expected_pte, nr);
diff --git a/mm/madvise.c b/mm/madvise.c
index d34ca6983227..b4103e2df346 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -321,6 +321,39 @@ static inline bool can_do_file_pageout(struct vm_area_struct *vma)
 	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 
+static inline int madvise_folio_pte_batch(unsigned long addr, unsigned long end,
+					  struct folio *folio, pte_t *ptep,
+					  pte_t pte, bool *any_young,
+					  bool *any_dirty)
+{
+	int max_nr = (end - addr) / PAGE_SIZE;
+	const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
+
+	return folio_pte_batch(folio, addr, ptep, pte, max_nr, fpb_flags, NULL,
+			       any_young, any_dirty);
+}
+
+static inline bool madvise_pte_split_folio(struct mm_struct *mm, pmd_t *pmd,
+					   unsigned long addr,
+					   struct folio *folio, pte_t **pte,
+					   spinlock_t **ptl)
+{
+	int err;
+
+	if (!folio_trylock(folio))
+		return false;
+
+	folio_get(folio);
+	pte_unmap_unlock(*pte, *ptl);
+	err = split_folio(folio);
+	folio_unlock(folio);
+	folio_put(folio);
+
+	*pte = pte_offset_map_lock(mm, pmd, addr, ptl);
+
+	return err == 0;
+}
+
 static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 				unsigned long addr, unsigned long end,
 				struct mm_walk *walk)
@@ -456,41 +489,30 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		 * next pte in the range.
 		 */
 		if (folio_test_large(folio)) {
-			const fpb_t fpb_flags = FPB_IGNORE_DIRTY |
-						FPB_IGNORE_SOFT_DIRTY;
-			int max_nr = (end - addr) / PAGE_SIZE;
 			bool any_young;
 
-			nr = folio_pte_batch(folio, addr, pte, ptent, max_nr,
-					     fpb_flags, NULL, &any_young);
-			if (any_young)
-				ptent = pte_mkyoung(ptent);
+			nr = madvise_folio_pte_batch(addr, end, folio, pte,
+						     ptent, &any_young, NULL);
 
 			if (nr < folio_nr_pages(folio)) {
-				int err;
-
 				if (folio_likely_mapped_shared(folio))
 					continue;
 				if (pageout_anon_only_filter && !folio_test_anon(folio))
 					continue;
-				if (!folio_trylock(folio))
-					continue;
-				folio_get(folio);
+
 				arch_leave_lazy_mmu_mode();
-				pte_unmap_unlock(start_pte, ptl);
-				start_pte = NULL;
-				err = split_folio(folio);
-				folio_unlock(folio);
-				folio_put(folio);
-				start_pte = pte =
-					pte_offset_map_lock(mm, pmd, addr, &ptl);
+				if (madvise_pte_split_folio(mm, pmd, addr,
+							    folio, &start_pte, &ptl))
+					nr = 0;
 				if (!start_pte)
 					break;
+				pte = start_pte;
 				arch_enter_lazy_mmu_mode();
-				if (!err)
-					nr = 0;
 				continue;
 			}
+
+			if (any_young)
+				ptent = pte_mkyoung(ptent);
 		}
 
 		/*
@@ -507,7 +529,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			continue;
 
 		if (!pageout && pte_young(ptent)) {
-			mkold_ptes(vma, addr, pte, nr);
+			clear_young_dirty_ptes(mm, addr, pte, nr,
+					       CYDP_CLEAR_YOUNG);
 			tlb_remove_tlb_entries(tlb, pte, nr, addr);
 		}
 
@@ -687,44 +710,51 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			continue;
 
 		/*
-		 * If pmd isn't transhuge but the folio is large and
-		 * is owned by only this process, split it and
-		 * deactivate all pages.
+		 * If we encounter a large folio, only split it if it is not
+		 * fully mapped within the range we are operating on. Otherwise
+		 * leave it as is so that it can be marked as lazyfree. If we
+		 * fail to split a folio, leave it in place and advance to the
+		 * next pte in the range.
 		 */
 		if (folio_test_large(folio)) {
-			int err;
+			bool any_young, any_dirty;
 
-			if (folio_likely_mapped_shared(folio))
-				break;
-			if (!folio_trylock(folio))
-				break;
-			folio_get(folio);
-			arch_leave_lazy_mmu_mode();
-			pte_unmap_unlock(start_pte, ptl);
-			start_pte = NULL;
-			err = split_folio(folio);
-			folio_unlock(folio);
-			folio_put(folio);
-			if (err)
-				break;
-			start_pte = pte =
-				pte_offset_map_lock(mm, pmd, addr, &ptl);
-			if (!start_pte)
-				break;
-			arch_enter_lazy_mmu_mode();
-			pte--;
-			addr -= PAGE_SIZE;
-			continue;
+			nr = madvise_folio_pte_batch(addr, end, folio, pte,
+						     ptent, &any_young, &any_dirty);
+
+			if (nr < folio_nr_pages(folio)) {
+				if (folio_likely_mapped_shared(folio))
+					continue;
+
+				arch_leave_lazy_mmu_mode();
+				if (madvise_pte_split_folio(mm, pmd, addr,
+							    folio, &start_pte, &ptl))
+					nr = 0;
+				if (!start_pte)
+					break;
+				pte = start_pte;
+				arch_enter_lazy_mmu_mode();
+				continue;
+			}
+
+			if (any_young)
+				ptent = pte_mkyoung(ptent);
+			if (any_dirty)
+				ptent = pte_mkdirty(ptent);
 		}
 
+		if (folio_mapcount(folio) != folio_nr_pages(folio))
+			continue;
+
 		if (folio_test_swapcache(folio) || folio_test_dirty(folio)) {
 			if (!folio_trylock(folio))
 				continue;
 			/*
-			 * If folio is shared with others, we mustn't clear
-			 * the folio's dirty flag.
+			 * If we have a large folio at this point, we know it is
+			 * fully mapped so if its mapcount is the same as its
+			 * number of pages, it must be exclusive.
 			 */
-			if (folio_mapcount(folio) != 1) {
+			if (folio_mapcount(folio) != folio_nr_pages(folio)) {
 				folio_unlock(folio);
 				continue;
 			}
@@ -740,19 +770,10 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		}
 
 		if (pte_young(ptent) || pte_dirty(ptent)) {
-			/*
-			 * Some of architecture(ex, PPC) don't update TLB
-			 * with set_pte_at and tlb_remove_tlb_entry so for
-			 * the portability, remap the pte with old|clean
-			 * after pte clearing.
-			 */
-			ptent = ptep_get_and_clear_full(mm, addr, pte,
-							tlb->fullmm);
-
-			ptent = pte_mkold(ptent);
-			ptent = pte_mkclean(ptent);
-			set_pte_at(mm, addr, pte, ptent);
-			tlb_remove_tlb_entry(tlb, pte, addr);
+			clear_young_dirty_ptes(mm, addr, pte, nr,
+					       CYDP_CLEAR_YOUNG |
+						       CYDP_CLEAR_DIRTY);
+			tlb_remove_tlb_entries(tlb, pte, nr, addr);
 		}
 		folio_mark_lazyfree(folio);
 	}
diff --git a/mm/memory.c b/mm/memory.c
index 76157b32faa8..b6fa5146b260 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -989,7 +989,7 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 			flags |= FPB_IGNORE_SOFT_DIRTY;
 
 		nr = folio_pte_batch(folio, addr, src_pte, pte, max_nr, flags,
-				     &any_writable, NULL);
+				     &any_writable, NULL, NULL);
 		folio_ref_add(folio, nr);
 		if (folio_test_anon(folio)) {
 			if (unlikely(folio_try_dup_anon_rmap_ptes(folio, page,
@@ -1558,7 +1558,7 @@ static inline int zap_present_ptes(struct mmu_gather *tlb,
 	 */
 	if (unlikely(folio_test_large(folio) && max_nr != 1)) {
 		nr = folio_pte_batch(folio, addr, pte, ptent, max_nr, fpb_flags,
-				     NULL, NULL);
+				     NULL, NULL, NULL);
 
 		zap_present_folio_ptes(tlb, vma, folio, page, pte, ptent, nr,
 				       addr, details, rss, force_flush,
-- 
2.33.1


