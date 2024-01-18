Return-Path: <linux-kernel+bounces-30039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAE6831837
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C89CEB25168
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0215F2555C;
	Thu, 18 Jan 2024 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzIVV/Kt"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7778323768
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576327; cv=none; b=NCit6Lz5yq5QTDrwldvo8uZifsQa3pfpA4ZI+qQYMvGOyX3Kb36GgukSrZIGfSiJCgSyMOMs4U/SJKm0gYpm9sUnYwruOkQDtxQp/RIkauEJgJvX2nR+3Yw8/d914bh112gEfhpjH9D+DdoDGGpstQl+dUi+qq/93WS7vHZUEp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576327; c=relaxed/simple;
	bh=3iSuabJMCFOhjj90fjjIfmTTve7X6yPyjG4bw6oRZqE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=DyqlM3oXGMBFDMyEukKUPR3ypN/dKgBfgeTVLUOindaygf4dLrvFlixcn78kHNtAUrxSgp+SJETO/zZYwD3feVl9t8HisfUnRYy3Hk9QYRtNKIt1EwIRNbwAnBUd5B9a25NGWDI1GWJeKynbEvvI4uxVieVdmpfogdD9bDLgGng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzIVV/Kt; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-595d24ad466so6600513eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705576324; x=1706181124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxtV65B3xdBW2CsjvzUu/C8QzJUJxjQlgzUH6d2NXwk=;
        b=YzIVV/Ktr9rxO0oV++6pS+GCPLBOwHYC5hjFRWOon2FTHfP/34/4p/aoQ5i2HzG1Jp
         6BHn5vD4xPqhTXJ1p25zK3hC69uCChayIUsFa+Hzc3F5NWtnLO5mDgr54KyjXPwhD2pm
         YUtEw3yRgK/kJlRz216vXUzCqiDXlxsHsubz33RWRJCMsI3juo85WYP0Pp+b/bca4m4/
         nBuuLlMnjvBhLjH67a+VQlWFDoqi1zzuFpqozMwHgw33eq9RpIkc31EKmd3dLKt+Yzib
         16bfBx3+z2NmOCxtluJkDyHonGHW4H+5lvQQ/7CQWIRS/zPWu2vk3dNq3jESCisYUT5Z
         bvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705576324; x=1706181124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxtV65B3xdBW2CsjvzUu/C8QzJUJxjQlgzUH6d2NXwk=;
        b=tFcRvPp7AT0g4kiDo8z8u0rhm27VK0Mw2eA8ToyfLGBRmbg6NbwMjFskDLffmbqnZ0
         qGdHMvwIDg/9tBlpqMa3l16wCmUCowRxYPxBthlPQ0jafCSXXJXrqPmeKsLB7D2x3lD3
         T/6jumMk0iI9YczvNR55tkeC/084FGL600q48hcMDYr4jbqFYGNnPwusXCbK+fXIOEpO
         s/wSaLiY9j9UlZ5GnIaNFbm2LosrlnhW/mIWA1A1CLHqSCb5wviZBgzvDxLvGWIawzNZ
         iBKSdh9g8v09whjutdhFx9Eoz217p278zOSwYIJfhZ4TpBju2u2NmApdAgIq8Hz77BWB
         Nawg==
X-Gm-Message-State: AOJu0YzuqTMmDq88SWsrm9umerkfbHoxU+7O1X9ICap4Kx3+HyY1xnbh
	EcKp91AoHLIM5exXWQr94IeyZBLpAoaEI88IYTCAM3HAE6/uIZNA9QN8JDo2
X-Google-Smtp-Source: AGHT+IEeSGuh99kBzDsDR/89TCeSTS2RWEiKEOvRPUVCzJfTDywJ9YQlQRSPdbA+rjeC2MmjCJPSvw==
X-Received: by 2002:a05:6359:ba7:b0:175:5c8c:3ab with SMTP id gf39-20020a0563590ba700b001755c8c03abmr609446rwb.65.1705576324307;
        Thu, 18 Jan 2024 03:12:04 -0800 (PST)
Received: from barry-desktop.. (143.122.224.49.dyn.cust.vf.net.nz. [49.224.122.143])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a0021d300b006d9be753ac7sm3039107pfj.108.2024.01.18.03.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 03:12:03 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: ryan.roberts@arm.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	shy828301@gmail.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yuzhao@google.com,
	surenb@google.com,
	steven.price@arm.com,
	Chuanhua Han <hanchuanhua@oppo.com>,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH RFC 4/6] mm: support large folios swapin as a whole
Date: Fri, 19 Jan 2024 00:10:34 +1300
Message-Id: <20240118111036.72641-5-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118111036.72641-1-21cnbao@gmail.com>
References: <20231025144546.577640-1-ryan.roberts@arm.com>
 <20240118111036.72641-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuanhua Han <hanchuanhua@oppo.com>

On an embedded system like Android, more than half of anon memory is actually
in swap devices such as zRAM. For example, while an app is switched to back-
ground, its most memory might be swapped-out.

Now we have mTHP features, unfortunately, if we don't support large folios
swap-in, once those large folios are swapped-out, we immediately lose the
performance gain we can get through large folios and hardware optimization
such as CONT-PTE.

This patch brings up mTHP swap-in support. Right now, we limit mTHP swap-in
to those contiguous swaps which were likely swapped out from mTHP as a whole.

On the other hand, the current implementation only covers the SWAP_SYCHRONOUS
case. It doesn't support swapin_readahead as large folios yet.

Right now, we are re-faulting large folios which are still in swapcache as a
whole, this can effectively decrease extra loops and early-exitings which we
have increased in arch_swap_restore() while supporting MTE restore for folios
rather than page.

Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/memory.c | 108 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 94 insertions(+), 14 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index f61a48929ba7..928b3f542932 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -107,6 +107,8 @@ EXPORT_SYMBOL(mem_map);
 static vm_fault_t do_fault(struct vm_fault *vmf);
 static vm_fault_t do_anonymous_page(struct vm_fault *vmf);
 static bool vmf_pte_changed(struct vm_fault *vmf);
+static struct folio *alloc_anon_folio(struct vm_fault *vmf,
+				      bool (*pte_range_check)(pte_t *, int));
 
 /*
  * Return true if the original pte was a uffd-wp pte marker (so the pte was
@@ -3784,6 +3786,34 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 	return VM_FAULT_SIGBUS;
 }
 
+static bool pte_range_swap(pte_t *pte, int nr_pages)
+{
+	int i;
+	swp_entry_t entry;
+	unsigned type;
+	pgoff_t start_offset;
+
+	entry = pte_to_swp_entry(ptep_get_lockless(pte));
+	if (non_swap_entry(entry))
+		return false;
+	start_offset = swp_offset(entry);
+	if (start_offset % nr_pages)
+		return false;
+
+	type = swp_type(entry);
+	for (i = 1; i < nr_pages; i++) {
+		entry = pte_to_swp_entry(ptep_get_lockless(pte + i));
+		if (non_swap_entry(entry))
+			return false;
+		if (swp_offset(entry) != start_offset + i)
+			return false;
+		if (swp_type(entry) != type)
+			return false;
+	}
+
+	return true;
+}
+
 /*
  * We enter with non-exclusive mmap_lock (to exclude vma changes,
  * but allow concurrent faults), and pte mapped but not yet locked.
@@ -3804,6 +3834,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	pte_t pte;
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
+	int nr_pages = 1;
+	unsigned long start_address;
+	pte_t *start_pte;
 
 	if (!pte_unmap_same(vmf))
 		goto out;
@@ -3868,13 +3901,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
 		    __swap_count(entry) == 1) {
 			/* skip swapcache */
-			folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
-						vma, vmf->address, false);
+			folio = alloc_anon_folio(vmf, pte_range_swap);
 			page = &folio->page;
 			if (folio) {
 				__folio_set_locked(folio);
 				__folio_set_swapbacked(folio);
 
+				if (folio_test_large(folio)) {
+					unsigned long start_offset;
+
+					nr_pages = folio_nr_pages(folio);
+					start_offset = swp_offset(entry) & ~(nr_pages - 1);
+					entry = swp_entry(swp_type(entry), start_offset);
+				}
+
 				if (mem_cgroup_swapin_charge_folio(folio,
 							vma->vm_mm, GFP_KERNEL,
 							entry)) {
@@ -3980,6 +4020,39 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 */
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
+
+	start_address = vmf->address;
+	start_pte = vmf->pte;
+	if (folio_test_large(folio)) {
+		unsigned long nr = folio_nr_pages(folio);
+		unsigned long addr = ALIGN_DOWN(vmf->address, nr * PAGE_SIZE);
+		pte_t *pte_t = vmf->pte - (vmf->address - addr) / PAGE_SIZE;
+
+		/*
+		 * case 1: we are allocating large_folio, try to map it as a whole
+		 * iff the swap entries are still entirely mapped;
+		 * case 2: we hit a large folio in swapcache, and all swap entries
+		 * are still entirely mapped, try to map a large folio as a whole.
+		 * otherwise, map only the faulting page within the large folio
+		 * which is swapcache
+		 */
+		if (pte_range_swap(pte_t, nr)) {
+			start_address = addr;
+			start_pte = pte_t;
+			if (unlikely(folio == swapcache)) {
+				/*
+				 * the below has been done before swap_read_folio()
+				 * for case 1
+				 */
+				nr_pages = nr;
+				entry = pte_to_swp_entry(ptep_get(start_pte));
+				page = &folio->page;
+			}
+		} else if (nr_pages > 1) { /* ptes have changed for case 1 */
+			goto out_nomap;
+		}
+	}
+
 	if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
 		goto out_nomap;
 
@@ -4047,12 +4120,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 * We're already holding a reference on the page but haven't mapped it
 	 * yet.
 	 */
-	swap_free(entry);
+	swap_nr_free(entry, nr_pages);
 	if (should_try_to_free_swap(folio, vma, vmf->flags))
 		folio_free_swap(folio);
 
-	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
-	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
+	folio_ref_add(folio, nr_pages - 1);
+	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
+	add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
+
 	pte = mk_pte(page, vma->vm_page_prot);
 
 	/*
@@ -4062,14 +4137,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 * exclusivity.
 	 */
 	if (!folio_test_ksm(folio) &&
-	    (exclusive || folio_ref_count(folio) == 1)) {
+	    (exclusive || folio_ref_count(folio) == nr_pages)) {
 		if (vmf->flags & FAULT_FLAG_WRITE) {
 			pte = maybe_mkwrite(pte_mkdirty(pte), vma);
 			vmf->flags &= ~FAULT_FLAG_WRITE;
 		}
 		rmap_flags |= RMAP_EXCLUSIVE;
 	}
-	flush_icache_page(vma, page);
+	flush_icache_pages(vma, page, nr_pages);
 	if (pte_swp_soft_dirty(vmf->orig_pte))
 		pte = pte_mksoft_dirty(pte);
 	if (pte_swp_uffd_wp(vmf->orig_pte))
@@ -4081,14 +4156,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_add_new_anon_rmap(folio, vma, vmf->address);
 		folio_add_lru_vma(folio, vma);
 	} else {
-		folio_add_anon_rmap_pte(folio, page, vma, vmf->address,
+		folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, start_address,
 					rmap_flags);
 	}
 
 	VM_BUG_ON(!folio_test_anon(folio) ||
 			(pte_write(pte) && !PageAnonExclusive(page)));
-	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
-	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
+	set_ptes(vma->vm_mm, start_address, start_pte, pte, nr_pages);
+
+	arch_do_swap_page(vma->vm_mm, vma, start_address, pte, vmf->orig_pte);
 
 	folio_unlock(folio);
 	if (folio != swapcache && swapcache) {
@@ -4105,6 +4181,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 
 	if (vmf->flags & FAULT_FLAG_WRITE) {
+		if (folio_test_large(folio) && nr_pages > 1)
+			vmf->orig_pte = ptep_get(vmf->pte);
+
 		ret |= do_wp_page(vmf);
 		if (ret & VM_FAULT_ERROR)
 			ret &= VM_FAULT_ERROR;
@@ -4112,7 +4191,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 
 	/* No need to invalidate - it was non-present before */
-	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
+	update_mmu_cache_range(vmf, vma, start_address, start_pte, nr_pages);
 unlock:
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
@@ -4148,7 +4227,8 @@ static bool pte_range_none(pte_t *pte, int nr_pages)
 	return true;
 }
 
-static struct folio *alloc_anon_folio(struct vm_fault *vmf)
+static struct folio *alloc_anon_folio(struct vm_fault *vmf,
+				      bool (*pte_range_check)(pte_t *, int))
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	struct vm_area_struct *vma = vmf->vma;
@@ -4190,7 +4270,7 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 	order = highest_order(orders);
 	while (orders) {
 		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
-		if (pte_range_none(pte + pte_index(addr), 1 << order))
+		if (pte_range_check(pte + pte_index(addr), 1 << order))
 			break;
 		order = next_order(&orders, order);
 	}
@@ -4269,7 +4349,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (unlikely(anon_vma_prepare(vma)))
 		goto oom;
 	/* Returns NULL on OOM or ERR_PTR(-EAGAIN) if we must retry the fault */
-	folio = alloc_anon_folio(vmf);
+	folio = alloc_anon_folio(vmf, pte_range_none);
 	if (IS_ERR(folio))
 		return 0;
 	if (!folio)
-- 
2.34.1


