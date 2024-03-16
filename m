Return-Path: <linux-kernel+bounces-105153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9135F87D9C7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 11:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838511C20CF4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F309FDDA5;
	Sat, 16 Mar 2024 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eET1+29a"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0610FED9
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710585040; cv=none; b=fP/xe4xDsN6dDDlAVVWXFfPuJxQlrlpaDe6W+To1cBuzT4qQQi/e1TEKUZMpuR27QtvjyqIep0X1CpoPRgmcC90jSWFpL0FuW78KaU5uPI+pERkqOiNJYM2iRfTvnRpPs/MF2hDxjfxK0Fvl7usrCuYhFs2GLod8y0bDEnJNprI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710585040; c=relaxed/simple;
	bh=dRvAnuzmT2LfoZrWtpch9J/sKUpJfFU0S3YAXIpNT0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IN/nh+Swj2jBIRGqPP25lqLk4rE3gFkcOFIWiDJbCQTf/kG+oqUzmz/7x/1qTn3QMf3EFinraM3akODJVHE0LeZ3KeqH7KpOmvf/lvfxIInoaHWtDQLzq/4GWEInqFIN/MJM/+oa4WvM6+RsI/COjqU5/QmvPecbeTSrj+pH3A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eET1+29a; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29e0229d6b5so870508a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 03:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710585038; x=1711189838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qHo7jm9tg/OEf2MsD86YZoG4pQM/Pa9AXwRiTeQC5wY=;
        b=eET1+29az2knHspu8BwIcMclXvRjk7j4Q67Koxqg4xSjp+dmb+jb4JeSk7TwST33qm
         725sQnTisyasYQTZhse+ihHEGeGBLR7R205mH07EzuUtl0lD1kMCsdP5qHAY8U5OPFi7
         d2kGm5B40t/5aTzp8HK8ZJky3MHzhQa9wQ/+ZcgDJvePtz+uESvDobUpGc1xm9Wb3zpW
         E7wPfkfX7IlQtgqtRUFsXRR0W16ww9dGhqAN0J5Av/QBoSD05iJxLwkn78bCI1WXm6KY
         z9FPpn8TEmKw+bjR4mIPDpo6vC30DsNQe6OXeOaBXOZGrCvWYKoIxFbx/66I3cS2aQQh
         kOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710585038; x=1711189838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHo7jm9tg/OEf2MsD86YZoG4pQM/Pa9AXwRiTeQC5wY=;
        b=KRH6xwJsY2oAl+SZ/nYji/TevCRfuKp/yZjLdAg5U6sK4tBLJsy6BS0uHlkftuaS3A
         aI5W9NDTyvHad/gY7rDPR4eZx4AhMJFpjF6J3sie6P3eQxXTUAdH7OOrQFG5yxpeYxG+
         NQd1FySLDsdTsshEICL1MqeEYkyNXZzwcqzYJ1s4qJpaNrFaQ6OIjctIfhnLz8kAMKnc
         NFEpBTgIcGr8NF6Ait8k28YFn/m+n4bPcZv+pZpeiq0P+Gtm87glCnEm5G4AG+yBkPkq
         pCZ1CLR3Wdzy4vwpBQVjPws9pO4BHBC5g+QYS+sdZeoAfF6GuTi3NnSnBHBn/0Rt8wQP
         a1vg==
X-Forwarded-Encrypted: i=1; AJvYcCUSe4nAIYuVnNvihaRHPzTHxmfmDXSxrIcxSjgSmGZ8pBYRBtUdgLwnOpx1EFedvYvuP0aHxv9Z3L6w31l51Nq5BViyo//DQxWu/GLB
X-Gm-Message-State: AOJu0YwLVTa+b5fDWFWgVEsEA1RbYFTe0x1Ktuq9AdcTj/TaeAXMad1A
	TYI4UfIJJBzOtTcYHlEUJK/h829b4qmAB6RM5kJkYMO8O8jrNUPr
X-Google-Smtp-Source: AGHT+IGbuq7xbyFV4Iz8/84AHYUzDTMHwxD+a/0yZLiatS2RAw5AZIYaLNrKFh61+xYHNzRlnJpUeg==
X-Received: by 2002:a17:90a:df10:b0:29c:579d:b599 with SMTP id gp16-20020a17090adf1000b0029c579db599mr6791046pjb.9.1710585037787;
        Sat, 16 Mar 2024 03:30:37 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.240.39])
        by smtp.gmail.com with ESMTPSA id bo9-20020a17090b090900b0029bfac322aasm4365742pjb.30.2024.03.16.03.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 03:30:37 -0700 (PDT)
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
Subject: [PATCH v3 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
Date: Sat, 16 Mar 2024 18:29:52 +0800
Message-Id: <20240316102952.39233-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch optimizes lazyfreeing with PTE-mapped mTHP[1]
(Inspired by David Hildenbrand[2]). We aim to avoid unnecessary
folio splitting if the large folio is entirely within the given
range.

On an Intel I5 CPU, lazyfreeing a 1GiB VMA backed by
PTE-mapped folios of the same size results in the following
runtimes for madvise(MADV_FREE) in seconds (shorter is better):

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
This patch is rebased on Ryan's patchset[3] and follows a similar pattern to
madvise_cold_or_pageout_pte_range() for madvise_free_pte_range().

[3] https://lore.kernel.org/linux-mm/20240311150058.1122862-1-ryan.roberts@arm.com

The performance numbers are from v2. I did a quick benchmark run of v3 and
nothing significantly changed.

v2 -> v3:
 * Only skip all the PTEs for nr_pages when the number of batched PTEs matches
 nr_pages per Barry Song
 * Change folio_pte_batch() to consume an optional *any_dirty and *any_young
 function, per David Hildenbrand
 * Move the ptep_get_and_clear_full() loop into refresh_full_ptes(), per
 David Hildenbrand
 * Follow a similar pattern for madvise_free_pte_range(), per Ryan Roberts
 * https://lore.kernel.org/linux-mm/20240307061425.21013-1-ioworker0@gmail.com

v1 -> v2:
 * Update the performance numbers
 * Update the changelog, suggested by Ryan Roberts
 * Check the COW folio, suggested by Yin Fengwei
 * Check if we are mapping all subpages, suggested by Barry Song,
 David Hildenbrand, Ryan Roberts
 * https://lore.kernel.org/linux-mm/20240225123215.86503-1-ioworker0@gmail.com

 include/linux/pgtable.h |  48 ++++++++++++
 mm/internal.h           |  17 ++++-
 mm/madvise.c            | 159 +++++++++++++++++++++-------------------
 mm/memory.c             |   4 +-
 4 files changed, 149 insertions(+), 79 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 8cf1f2fe2c25..3ca9ae29e653 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -736,6 +736,54 @@ static inline void clear_not_present_full_ptes(struct mm_struct *mm,
 }
 #endif
 
+/* Flags for refresh_full_ptes(). */
+typedef int __bitwise rfp_t;
+
+/* Refresh PTEs after pte_mkold(), droping the accessed bit. */
+#define RFP_CLEAR_YOUNG		((__force rfp_t)BIT(0))
+
+/* Refresh PTEs after pte_mkclean(), droping the dirty bit. */
+#define RFP_CLEAR_DIRTY		((__force rfp_t)BIT(1))
+
+/**
+ * refresh_full_ptes - refresh present PTEs that map consecutive pages of the
+ *		same folio.
+ * @mm: Address space the pages are mapped into.
+ * @addr: Address the first page is mapped at.
+ * @ptep: Page table pointer for the first entry.
+ * @nr: Number of entries to refresh.
+ * @flags: Flags to indicate the PTE refresh semantics.
+ * @full: Whether we are clearing a full mm.
+ *
+ * Note that PTE bits in the PTE range besides the PFN can differ. For example,
+ * some PTEs might be write-protected.
+ *
+ * Context: The caller holds the page table lock.  The PTEs map consecutive
+ * pages that belong to the same folio.  The PTEs are all in the same PMD.
+ */
+static inline void refresh_full_ptes(struct mm_struct *mm, unsigned long addr,
+				     pte_t *ptep, unsigned int nr, rfp_t flags, int full)
+{
+	pte_t ptent;
+
+	for (;;) {
+		ptent = ptep_get_and_clear_full(mm, addr, ptep, full);
+
+		if (flags & RFP_CLEAR_YOUNG)
+			ptent = pte_mkold(ptent);
+
+		if (flags & RFP_CLEAR_DIRTY)
+			ptent = pte_mkclean(ptent);
+
+		set_pte_at(mm, addr, ptep, ptent);
+
+		if (--nr == 0)
+			break;
+		ptep++;
+		addr += PAGE_SIZE;
+	}
+}
+
 #ifndef __HAVE_ARCH_PTEP_CLEAR_FLUSH
 extern pte_t ptep_clear_flush(struct vm_area_struct *vma,
 			      unsigned long address,
diff --git a/mm/internal.h b/mm/internal.h
index 9256d440a080..3610f2f65f8e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -130,16 +130,20 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
  */
 static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
-		bool *any_writable)
+		bool *any_writable, bool *any_young, bool *any_dirty)
 {
 	unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
 	const pte_t *end_ptep = start_ptep + max_nr;
 	pte_t expected_pte, *ptep;
-	bool writable;
+	bool writable, young, dirty;
 	int nr;
 
 	if (any_writable)
 		*any_writable = false;
+	if (any_young)
+		*any_young = false;
+	if (any_dirty)
+		*any_dirty = false;
 
 	VM_WARN_ON_FOLIO(!pte_present(pte), folio);
 	VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);
@@ -153,6 +157,11 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 		pte = ptep_get(ptep);
 		if (any_writable)
 			writable = !!pte_write(pte);
+		if (any_young)
+			young = !!pte_young(pte);
+		if (any_dirty)
+			dirty = !!pte_dirty(pte);
+
 		pte = __pte_batch_clear_ignored(pte, flags);
 
 		if (!pte_same(pte, expected_pte))
@@ -168,6 +177,10 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 
 		if (any_writable)
 			*any_writable |= writable;
+		if (any_young)
+			*any_young |= young;
+		if (any_dirty)
+			*any_dirty |= dirty;
 
 		nr = pte_batch_hint(ptep, pte);
 		expected_pte = pte_advance_pfn(expected_pte, nr);
diff --git a/mm/madvise.c b/mm/madvise.c
index 56c7ba7bd558..f88b4d7d75cb 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -321,6 +321,38 @@ static inline bool can_do_file_pageout(struct vm_area_struct *vma)
 	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 
+static inline int madvise_folio_pte_batch(unsigned long addr, unsigned long end,
+					  struct folio *folio, pte_t *pte,
+					  bool *any_young, bool *any_dirty)
+{
+	int max_nr = (end - addr) / PAGE_SIZE;
+	const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
+
+	return folio_pte_batch(folio, addr, pte, ptep_get(pte), max_nr,
+			       fpb_flags, NULL, any_young, any_dirty);
+}
+
+static inline bool madvise_split_folio(struct mm_struct *mm, pmd_t *pmd,
+				       unsigned long addr, struct folio *folio,
+				       pte_t **pte, spinlock_t **ptl)
+{
+	int err;
+
+	if (!folio_trylock(folio))
+		return false;
+
+	folio_get(folio);
+	pte_unmap_unlock(*pte, *ptl);
+	*pte = NULL;
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
@@ -334,9 +366,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	spinlock_t *ptl;
 	struct folio *folio = NULL;
 	LIST_HEAD(folio_list);
-	bool pageout_anon_only_filter;
+	bool pageout_anon_only_filter, any_young;
 	unsigned int batch_count = 0;
 	int nr;
+	const rfp_t rfp_flags = RFP_CLEAR_YOUNG;
 
 	if (fatal_signal_pending(current))
 		return -EINTR;
@@ -456,39 +489,25 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		 * next pte in the range.
 		 */
 		if (folio_test_large(folio)) {
-			const fpb_t fpb_flags = FPB_IGNORE_DIRTY |
-						FPB_IGNORE_SOFT_DIRTY;
-			int max_nr = (end - addr) / PAGE_SIZE;
-
-			nr = folio_pte_batch(folio, addr, pte, ptent, max_nr,
-					     fpb_flags, NULL);
-
+			nr = madvise_folio_pte_batch(addr, end, folio, pte,
+						     &any_young, NULL);
+			if (folio_estimated_sharers(folio) > 1)
+				continue;
 			if (nr < folio_nr_pages(folio)) {
-				int err;
-
-				if (folio_estimated_sharers(folio) > 1)
-					continue;
 				if (pageout_anon_only_filter && !folio_test_anon(folio))
 					continue;
-				if (!folio_trylock(folio))
-					continue;
-				folio_get(folio);
 				arch_leave_lazy_mmu_mode();
-				pte_unmap_unlock(start_pte, ptl);
-				start_pte = NULL;
-				err = split_folio(folio);
-				folio_unlock(folio);
-				folio_put(folio);
-				if (err)
-					continue;
-				start_pte = pte =
-					pte_offset_map_lock(mm, pmd, addr, &ptl);
+				if (madvise_split_folio(mm, pmd, addr, folio,
+							&start_pte, &ptl))
+					nr = 0;
 				if (!start_pte)
 					break;
+				pte = start_pte;
 				arch_enter_lazy_mmu_mode();
-				nr = 0;
 				continue;
 			}
+			if (any_young)
+				ptent = pte_mkyoung(ptent);
 		}
 
 		/*
@@ -504,11 +523,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		if (pageout_anon_only_filter && !folio_test_anon(folio))
 			continue;
 
-		if (!pageout) {
-			for (; nr != 0; nr--, pte++, addr += PAGE_SIZE) {
-				if (ptep_test_and_clear_young(vma, addr, pte))
-					tlb_remove_tlb_entry(tlb, pte, addr);
-			}
+		if (!pageout && pte_young(ptent)) {
+			refresh_full_ptes(mm, addr, pte, nr, rfp_flags, tlb->fullmm);
+			tlb_remove_tlb_entries(tlb, pte, nr, addr);
 		}
 
 		/*
@@ -642,6 +659,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 	int nr_swap = 0;
 	unsigned long next;
 	int nr, max_nr;
+	bool any_young, any_dirty;
+	const rfp_t rfp_flags = RFP_CLEAR_YOUNG | RFP_CLEAR_DIRTY;
 
 	next = pmd_addr_end(addr, end);
 	if (pmd_trans_huge(*pmd))
@@ -654,7 +673,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		return 0;
 	flush_tlb_batched_pending(mm);
 	arch_enter_lazy_mmu_mode();
-	for (; addr != end; pte += nr, addr += PAGE_SIZE * nr) {
+	for (; addr < end; pte += nr, addr += PAGE_SIZE * nr) {
 		nr = 1;
 		ptent = ptep_get(pte);
 
@@ -687,57 +706,52 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
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
+			nr = madvise_folio_pte_batch(addr, end, folio, pte,
+						     &any_young, &any_dirty);
+			if (folio_estimated_sharers(folio) > 1)
+				continue;
+			if (nr < folio_nr_pages(folio)) {
+				arch_leave_lazy_mmu_mode();
+				if (madvise_split_folio(mm, pmd, addr, folio,
+							&start_pte, &ptl))
+					nr = 0;
+				if (!start_pte)
+					break;
+				pte = start_pte;
+				arch_enter_lazy_mmu_mode();
+				continue;
+			}
+			if (any_young || any_dirty)
+				ptent = pte_mkyoung(pte_mkdirty(ptent));
+		}
 
-			if (folio_estimated_sharers(folio) != 1)
-				break;
-			if (!folio_trylock(folio))
-				break;
-			folio_get(folio);
-			arch_leave_lazy_mmu_mode();
-			pte_unmap_unlock(start_pte, ptl);
-			start_pte = NULL;
-			err = split_folio(folio);
+		if (!folio_trylock(folio))
+			continue;
+		/*
+		 * If we have a large folio at this point, we know it is fully mapped
+		 * so if its mapcount is the same as its number of pages, it must be
+		 * exclusive.
+		 */
+		if (folio_mapcount(folio) != folio_nr_pages(folio)) {
 			folio_unlock(folio);
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
 			continue;
 		}
-
 		if (folio_test_swapcache(folio) || folio_test_dirty(folio)) {
-			if (!folio_trylock(folio))
-				continue;
-			/*
-			 * If folio is shared with others, we mustn't clear
-			 * the folio's dirty flag.
-			 */
-			if (folio_mapcount(folio) != 1) {
-				folio_unlock(folio);
-				continue;
-			}
-
 			if (folio_test_swapcache(folio) &&
 			    !folio_free_swap(folio)) {
 				folio_unlock(folio);
 				continue;
 			}
-
 			folio_clear_dirty(folio);
-			folio_unlock(folio);
 		}
+		folio_unlock(folio);
 
 		if (pte_young(ptent) || pte_dirty(ptent)) {
 			/*
@@ -746,13 +760,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			 * the portability, remap the pte with old|clean
 			 * after pte clearing.
 			 */
-			ptent = ptep_get_and_clear_full(mm, addr, pte,
-							tlb->fullmm);
-
-			ptent = pte_mkold(ptent);
-			ptent = pte_mkclean(ptent);
-			set_pte_at(mm, addr, pte, ptent);
-			tlb_remove_tlb_entry(tlb, pte, addr);
+			refresh_full_ptes(mm, addr, pte, nr, rfp_flags, tlb->fullmm);
+			tlb_remove_tlb_entries(tlb, pte, nr, addr);
 		}
 		folio_mark_lazyfree(folio);
 	}
diff --git a/mm/memory.c b/mm/memory.c
index 25c0ef1c7ff3..7121e5cc74d9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -989,7 +989,7 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 			flags |= FPB_IGNORE_SOFT_DIRTY;
 
 		nr = folio_pte_batch(folio, addr, src_pte, pte, max_nr, flags,
-				     &any_writable);
+				     &any_writable, NULL, NULL);
 		folio_ref_add(folio, nr);
 		if (folio_test_anon(folio)) {
 			if (unlikely(folio_try_dup_anon_rmap_ptes(folio, page,
@@ -1551,7 +1551,7 @@ static inline int zap_present_ptes(struct mmu_gather *tlb,
 	 */
 	if (unlikely(folio_test_large(folio) && max_nr != 1)) {
 		nr = folio_pte_batch(folio, addr, pte, ptent, max_nr, fpb_flags,
-				     NULL);
+				     NULL, NULL, NULL);
 
 		zap_present_folio_ptes(tlb, vma, folio, page, pte, ptent, nr,
 				       addr, details, rss, force_flush,
-- 
2.33.1


