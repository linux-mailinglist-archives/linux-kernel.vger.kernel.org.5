Return-Path: <linux-kernel+bounces-127959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C69A28953AD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD72286365
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB45684FB1;
	Tue,  2 Apr 2024 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4U4tRA/"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2918584A54
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061648; cv=none; b=rjVF4QKKmlfIHdiXICzXEFtMkLP2Ah7RHzg65PfeyTQsPfovQSaHjFN1Cffcv7ezyjiwtAQwOSYJ6fA6l5VjR5wZVIuxzor88su3KPCFsUr3vfAYN+EqEZCChjLYPTc5bYUkbSIRlLlVCMknzlHU0alYa6yAXdz8CHsnPCp+Lhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061648; c=relaxed/simple;
	bh=ZGinFaCuqhZbi0H8DS3qxVj0lb27SPgy/Z2HCGWxRzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p9eLAvy5/+H4WCcDl04IwmzkrnmD1sTkpkK3nb/w+MBb+8F64cpCiOdBi0TPTlc8e+SWE1I2ke1tFgoXeSNDnMsJh0eMwAlrdQuKFpT9VildXU01q1YW/FB1t9j61Zk//dS9Emb/JuiC8JPrn1EnF0XkuvaItROUISf5CubbqJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4U4tRA/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6eaf7c97738so2123281b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712061646; x=1712666446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3p6YicSBdwB37EqXf1IHFz+OfIaM1uGZTtHlNvY/Hk=;
        b=V4U4tRA/wPmroNFO50oY42WiyfZxzdZFdDgUF9IGPLktSfgTzMNoU0xTFP6asvjake
         irVdbOwH9zEZchlkvqgFhf1j4OT1lpJNCafC2Q/SvQ5boS382+/r6PN3aHOSuzg75sJZ
         W/cwTxZsbMTTR4kcvem+yhxGzHDefHy5L3wPbInpAysjHrUXOrMMuUBvrKehNYmicMyM
         GaXUCBqGmhVMFw4eKRjzV14JQ9o7V3ZNdSHb6t/46BLGb55D5HFdalFAYqNxyGf9Njr9
         5U9IsxInOO0QEVYMaoCg2lWdbkgHdHLd8hEfkZ6nkG4kW7e4y+kyQxpCB1Hyg6ltSHbM
         fghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712061646; x=1712666446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3p6YicSBdwB37EqXf1IHFz+OfIaM1uGZTtHlNvY/Hk=;
        b=nuG4JB/aiyMMd3+EH7nyPh02qbVUfLwl2EXra/l01ARSndRzGncdEOZI8uqnXqDkAK
         aem3bjSXCJcUM39189ikb1TI1e00TT7Uc8SmcJvWqJvq1LMo81r+1x2m93lakjRuVOpe
         6FUYcUIIt5WuXdR37dHjTEG22eFvzFE4sHnjYeRryc9Tb3Q0LSrMeBd+YHwGKVs8Bc61
         iLwl7H3QWIJvZtrqEfkb+hX+IK8dfWWUgbeUvjR7mylMIkRA/bMbrqvVZjsRV8YDp21j
         Jr5KZFcebbKMxbX4TihPk83g01GQzABLs39v5W1wuw1OD3AzyjT6PAuENu7e+wkTPHtJ
         diBw==
X-Forwarded-Encrypted: i=1; AJvYcCWnH0+Dd8hg77ACjcamjPo32RBl6DSrtJ0B1BjY4bHzY6teO2z+xpmZ/qEKCmWudFrUjd3G2Drj2wxMLXfYA7uPEPsF8znQHPxGO4bX
X-Gm-Message-State: AOJu0YxrOf39Zv0fB5DAypMkfQfAiuGzX89lsKpYhxQk3vTzn9IrFDsE
	ynBWg7fk3IesfXlsVk8WBsK+uYQJm1IaSQYtE4fU4Xwt1XyZdiK8l6xqsfoBfpc=
X-Google-Smtp-Source: AGHT+IGrQhKk3TJHCABKTaThz6dyl9Nv19RBANJzr9O8ZMHrEMbPmTH7ZMkiyUS2NotsW9ICpBk9TA==
X-Received: by 2002:a05:6a21:394c:b0:1a6:fe92:ed5b with SMTP id ac12-20020a056a21394c00b001a6fe92ed5bmr9896532pzc.23.1712061646331;
        Tue, 02 Apr 2024 05:40:46 -0700 (PDT)
Received: from LancedeMBP.lan ([112.10.225.9])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b006e664031f10sm9708232pfn.51.2024.04.02.05.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:40:46 -0700 (PDT)
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
Subject: [PATCH v4 2/2] mm/madvise: optimize lazyfreeing with mTHP in madvise_free
Date: Tue,  2 Apr 2024 20:40:29 +0800
Message-Id: <20240402124029.47846-3-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240402124029.47846-1-ioworker0@gmail.com>
References: <20240402124029.47846-1-ioworker0@gmail.com>
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
 mm/internal.h |  12 ++++-
 mm/madvise.c  | 147 ++++++++++++++++++++++++++------------------------
 mm/memory.c   |   4 +-
 3 files changed, 88 insertions(+), 75 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 3df06a152ff0..cdc6e2162b30 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -132,6 +132,8 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
  *		  first one is writable.
  * @any_young: Optional pointer to indicate whether any entry except the
  *		  first one is young.
+ * @any_dirty: Optional pointer to indicate whether any entry except the
+ *		  first one is dirty.
  *
  * Detect a PTE batch: consecutive (present) PTEs that map consecutive
  * pages of the same large folio.
@@ -147,18 +149,20 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
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
@@ -174,6 +178,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 			writable = !!pte_write(pte);
 		if (any_young)
 			young = !!pte_young(pte);
+		if (any_dirty)
+			dirty = !!pte_dirty(pte);
 		pte = __pte_batch_clear_ignored(pte, flags);
 
 		if (!pte_same(pte, expected_pte))
@@ -191,6 +197,8 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 			*any_writable |= writable;
 		if (any_young)
 			*any_young |= young;
+		if (any_dirty)
+			*any_dirty |= dirty;
 
 		nr = pte_batch_hint(ptep, pte);
 		expected_pte = pte_advance_pfn(expected_pte, nr);
diff --git a/mm/madvise.c b/mm/madvise.c
index bd00b83e7c50..8197effd9f14 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -321,6 +321,38 @@ static inline bool can_do_file_pageout(struct vm_area_struct *vma)
 	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 
+static inline int madvise_folio_pte_batch(unsigned long addr, unsigned long end,
+					  struct folio *folio, pte_t *pte,
+					  bool *any_writable, bool *any_young, bool *any_dirty)
+{
+	int max_nr = (end - addr) / PAGE_SIZE;
+	const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
+
+	return folio_pte_batch(folio, addr, pte, ptep_get(pte), max_nr,
+			       fpb_flags, any_writable, any_young, any_dirty);
+}
+
+static inline bool madvise_pte_split_folio(struct mm_struct *mm, pmd_t *pmd,
+					   unsigned long addr, struct folio *folio, pte_t **pte,
+					   spinlock_t **ptl)
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
@@ -456,40 +488,26 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		 * next pte in the range.
 		 */
 		if (folio_test_large(folio)) {
-			const fpb_t fpb_flags = FPB_IGNORE_DIRTY |
-						FPB_IGNORE_SOFT_DIRTY;
-			int max_nr = (end - addr) / PAGE_SIZE;
 			bool any_young;
-
-			nr = folio_pte_batch(folio, addr, pte, ptent, max_nr,
-					     fpb_flags, NULL, &any_young);
+			nr = madvise_folio_pte_batch(addr, end, folio, pte,
+						     NULL, &any_young, NULL);
 			if (any_young)
 				ptent = pte_mkyoung(ptent);
 
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
-				if (err)
-					continue;
-				start_pte = pte =
-					pte_offset_map_lock(mm, pmd, addr, &ptl);
+				if (madvise_pte_split_folio(mm, pmd, addr,
+							    folio, &start_pte, &ptl))
+					nr = 0;
 				if (!start_pte)
 					break;
+				pte = start_pte;
 				arch_enter_lazy_mmu_mode();
-				nr = 0;
 				continue;
 			}
 		}
@@ -688,72 +706,59 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
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
+			nr = madvise_folio_pte_batch(addr, end, folio, pte,
+						     NULL, &any_young, &any_dirty);
+			if (any_young || any_dirty)
+				ptent = pte_mkdirty(pte_mkyoung(ptent));
 
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
-		}
+			if (nr < folio_nr_pages(folio)) {
+				if (folio_likely_mapped_shared(folio))
+					continue;
 
-		if (folio_test_swapcache(folio) || folio_test_dirty(folio)) {
-			if (!folio_trylock(folio))
-				continue;
-			/*
-			 * If folio is shared with others, we mustn't clear
-			 * the folio's dirty flag.
-			 */
-			if (folio_mapcount(folio) != 1) {
-				folio_unlock(folio);
+				arch_leave_lazy_mmu_mode();
+				if (madvise_pte_split_folio(mm, pmd, addr,
+							    folio, &start_pte, &ptl))
+					nr = 0;
+				if (!start_pte)
+					break;
+				pte = start_pte;
+				arch_enter_lazy_mmu_mode();
 				continue;
 			}
+		}
 
+		if (!folio_trylock(folio))
+			continue;
+		/*
+		 * If we have a large folio at this point, we know it is fully mapped
+		 * so if its mapcount is the same as its number of pages, it must be
+		 * exclusive.
+		 */
+		if (folio_mapcount(folio) != folio_nr_pages(folio)) {
+			folio_unlock(folio);
+			continue;
+		}
+		if (folio_test_swapcache(folio) || folio_test_dirty(folio)) {
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
+			mkold_clean_ptes(vma, addr, pte, nr, tlb->fullmm);
+			tlb_remove_tlb_entries(tlb, pte, nr, addr);
 		}
 		folio_mark_lazyfree(folio);
 	}
diff --git a/mm/memory.c b/mm/memory.c
index 912cd738ec03..24769ecb59e5 100644
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
@@ -1559,7 +1559,7 @@ static inline int zap_present_ptes(struct mmu_gather *tlb,
 	 */
 	if (unlikely(folio_test_large(folio) && max_nr != 1)) {
 		nr = folio_pte_batch(folio, addr, pte, ptent, max_nr, fpb_flags,
-				     NULL, NULL);
+				     NULL, NULL, NULL);
 
 		zap_present_folio_ptes(tlb, vma, folio, page, pte, ptent, nr,
 				       addr, details, rss, force_flush,
-- 
2.33.1


