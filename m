Return-Path: <linux-kernel+bounces-118123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C50A88B55B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 00:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04938B48068
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA25E84A3E;
	Mon, 25 Mar 2024 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iy3HWiU4"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1675B76C68
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711406025; cv=none; b=iMfkBfQJhDlWi92Icvqe5UOBhVOR+W7HIE/yk0mhfbSP5SGlK0C4YpzxDGh2e3MhZ/fi2i627Wo1NbaoGgbuFd6tp/W2HWTg598kb0P8HEwDoKhAG6KVE/aHiaJy5HBOsw60kefluJzR3OZmmZIV5KX3/1GWzX0q0dMmGgsEDsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711406025; c=relaxed/simple;
	bh=5doG0I4O79bhHZe6ovaO/RH1HdZ3bLY0+cmxlMVxMuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LwAD9duvV1QcDnOQuWji98JUWdCDwqE/qTWW3LakFUS/RMPg2ZYIKbAuJo6eKspzdwYmOjtsw4LGYlvm5XPbGX/PljXZ93HiltLC+WyDtPqaXFb9/OW922Jq1T/nN+BWBAYxLD66x9uT8xUabNAwqSc6TmUr4H+Fr+VpwOvdRfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iy3HWiU4; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d3907ff128so3627601a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711406023; x=1712010823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wuUkLEO8wS3NnK8pO29sbwl4okjZZVm7bwiudBCZKQ=;
        b=Iy3HWiU43r2HGm/vK/lXHBwol1h40nGt3g/lPPD46I+PdkED+Inv8m75++XI0XBl5R
         BsH2oBrFQyMSTNKAHgRRAuHMyrwbVdJ7sZ8ENTXb+gA4JYJXp+lChIWrfzn8iYPFKHHs
         0fYHg2yyKGdVLrcGc9oRS5dMQh4uOYZJa+S1HG9E8YFgPpm4H5FnG6BVVNyQfccmtbeQ
         vxUJf6OHcwxYqXjtwdSXLUr/HoDEMJs/RqZDEvkXDR5BGbbSFHnWFh4P9Tbpasfj77DQ
         RUKaPoi/vjW7C/TYStEW+6ac38CmE2w23j/rjWoHpii4AdU6pepLQaY6FD3NV3kLErSn
         whYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711406023; x=1712010823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wuUkLEO8wS3NnK8pO29sbwl4okjZZVm7bwiudBCZKQ=;
        b=KVbgatBV3WQJL+1HFDqCpApsCR1AvU/xt5mZeZutcHGu2eezSymu+FKf10OMq8154B
         SrpqhDKV3FISF9394uLDIh90uuTTXI3/3fVDosCwQKj53EgzTWjbD1L0pxyfT69E7wMy
         tYbbHUfcaAqFjKw3rlWBXJOlTTMUPNkOZml/8vbxx7Tk2Tj6IZeBjcx3SrB2dYJJCaze
         1/secLxYZXegJcVibW4K9QRa52L2YP4q3flFaJYx2Gy/qKshJrync3TSHel2V6gOGdia
         DYlPaXfD0e5J4+DGfbRWx4bm/bqWFkvqdA7h70pYVFxWL3OT5bjNCvE9ECiqLWJryYNs
         QS7A==
X-Gm-Message-State: AOJu0YxgioqZeOLZWfpMuTYBpBPbiGyRhZy5eDy/e8V0lzW0gtwwjrdN
	PuW6mT5ZKUmUJTfeMQpVBbov/SMokjZUyFB5Jbf+3s1uZcqyTf47
X-Google-Smtp-Source: AGHT+IFl6KFavtRUNTSrxnwpqS8RSMDEAwpK70R/1RBLnR40J5C5dnwH9mZD8fjRJHapYDc5t8I8Zw==
X-Received: by 2002:a05:6a21:3942:b0:1a3:cd06:20cf with SMTP id ac2-20020a056a21394200b001a3cd0620cfmr4148137pzc.16.1711406023376;
        Mon, 25 Mar 2024 15:33:43 -0700 (PDT)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id sx16-20020a17090b2cd000b002a053cdd4e5sm4356173pjb.9.2024.03.25.15.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 15:33:43 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 1/5] hugetlb: Convert hugetlb_fault() to use struct vm_fault
Date: Mon, 25 Mar 2024 15:33:35 -0700
Message-ID: <20240325223339.169350-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325223339.169350-1-vishal.moola@gmail.com>
References: <20240325223339.169350-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that hugetlb_fault() has a vm_fault available for fault tracking, use
it throughout. This cleans up the code by removing 2 variables, and
prepares hugetlb_fault() to take in a struct vm_fault argument.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/hugetlb.c | 84 +++++++++++++++++++++++++---------------------------
 1 file changed, 41 insertions(+), 43 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 688017ca0cc2..81e8ade53b64 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6330,8 +6330,6 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx)
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags)
 {
-	pte_t *ptep, entry;
-	spinlock_t *ptl;
 	vm_fault_t ret;
 	u32 hash;
 	struct folio *folio = NULL;
@@ -6339,13 +6337,13 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct hstate *h = hstate_vma(vma);
 	struct address_space *mapping;
 	int need_wait_lock = 0;
-	unsigned long haddr = address & huge_page_mask(h);
 	struct vm_fault vmf = {
 		.vma = vma,
-		.address = haddr,
+		.address = address & huge_page_mask(h),
 		.real_address = address,
 		.flags = flags,
-		.pgoff = vma_hugecache_offset(h, vma, haddr),
+		.pgoff = vma_hugecache_offset(h, vma,
+				address & huge_page_mask(h)),
 		/* TODO: Track hugetlb faults using vm_fault */
 
 		/*
@@ -6365,22 +6363,22 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	/*
 	 * Acquire vma lock before calling huge_pte_alloc and hold
-	 * until finished with ptep.  This prevents huge_pmd_unshare from
-	 * being called elsewhere and making the ptep no longer valid.
+	 * until finished with vmf.pte.  This prevents huge_pmd_unshare from
+	 * being called elsewhere and making the vmf.pte no longer valid.
 	 */
 	hugetlb_vma_lock_read(vma);
-	ptep = huge_pte_alloc(mm, vma, haddr, huge_page_size(h));
-	if (!ptep) {
+	vmf.pte = huge_pte_alloc(mm, vma, vmf.address, huge_page_size(h));
+	if (!vmf.pte) {
 		hugetlb_vma_unlock_read(vma);
 		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		return VM_FAULT_OOM;
 	}
 
-	entry = huge_ptep_get(ptep);
-	if (huge_pte_none_mostly(entry)) {
-		if (is_pte_marker(entry)) {
+	vmf.orig_pte = huge_ptep_get(vmf.pte);
+	if (huge_pte_none_mostly(vmf.orig_pte)) {
+		if (is_pte_marker(vmf.orig_pte)) {
 			pte_marker marker =
-				pte_marker_get(pte_to_swp_entry(entry));
+				pte_marker_get(pte_to_swp_entry(vmf.orig_pte));
 
 			if (marker & PTE_MARKER_POISONED) {
 				ret = VM_FAULT_HWPOISON_LARGE;
@@ -6395,20 +6393,20 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * mutex internally, which make us return immediately.
 		 */
 		return hugetlb_no_page(mm, vma, mapping, vmf.pgoff, address,
-					ptep, entry, flags, &vmf);
+					vmf.pte, vmf.orig_pte, flags, &vmf);
 	}
 
 	ret = 0;
 
 	/*
-	 * entry could be a migration/hwpoison entry at this point, so this
-	 * check prevents the kernel from going below assuming that we have
-	 * an active hugepage in pagecache. This goto expects the 2nd page
-	 * fault, and is_hugetlb_entry_(migration|hwpoisoned) check will
-	 * properly handle it.
+	 * vmf.orig_pte could be a migration/hwpoison vmf.orig_pte at this
+	 * point, so this check prevents the kernel from going below assuming
+	 * that we have an active hugepage in pagecache. This goto expects
+	 * the 2nd page fault, and is_hugetlb_entry_(migration|hwpoisoned)
+	 * check will properly handle it.
 	 */
-	if (!pte_present(entry)) {
-		if (unlikely(is_hugetlb_entry_migration(entry))) {
+	if (!pte_present(vmf.orig_pte)) {
+		if (unlikely(is_hugetlb_entry_migration(vmf.orig_pte))) {
 			/*
 			 * Release the hugetlb fault lock now, but retain
 			 * the vma lock, because it is needed to guard the
@@ -6417,9 +6415,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			 * be released there.
 			 */
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-			migration_entry_wait_huge(vma, ptep);
+			migration_entry_wait_huge(vma, vmf.pte);
 			return 0;
-		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
+		} else if (unlikely(is_hugetlb_entry_hwpoisoned(vmf.orig_pte)))
 			ret = VM_FAULT_HWPOISON_LARGE |
 			    VM_FAULT_SET_HINDEX(hstate_index(h));
 		goto out_mutex;
@@ -6433,13 +6431,13 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * determine if a reservation has been consumed.
 	 */
 	if ((flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) &&
-	    !(vma->vm_flags & VM_MAYSHARE) && !huge_pte_write(entry)) {
-		if (vma_needs_reservation(h, vma, haddr) < 0) {
+	    !(vma->vm_flags & VM_MAYSHARE) && !huge_pte_write(vmf.orig_pte)) {
+		if (vma_needs_reservation(h, vma, vmf.address) < 0) {
 			ret = VM_FAULT_OOM;
 			goto out_mutex;
 		}
 		/* Just decrements count, does not deallocate */
-		vma_end_reservation(h, vma, haddr);
+		vma_end_reservation(h, vma, vmf.address);
 
 		pagecache_folio = filemap_lock_hugetlb_folio(h, mapping,
 							     vmf.pgoff);
@@ -6447,17 +6445,17 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			pagecache_folio = NULL;
 	}
 
-	ptl = huge_pte_lock(h, mm, ptep);
+	vmf.ptl = huge_pte_lock(h, mm, vmf.pte);
 
 	/* Check for a racing update before calling hugetlb_wp() */
-	if (unlikely(!pte_same(entry, huge_ptep_get(ptep))))
+	if (unlikely(!pte_same(vmf.orig_pte, huge_ptep_get(vmf.pte))))
 		goto out_ptl;
 
 	/* Handle userfault-wp first, before trying to lock more pages */
-	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(ptep)) &&
-	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
+	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(vmf.pte)) &&
+	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(vmf.orig_pte)) {
 		if (!userfaultfd_wp_async(vma)) {
-			spin_unlock(ptl);
+			spin_unlock(vmf.ptl);
 			if (pagecache_folio) {
 				folio_unlock(pagecache_folio);
 				folio_put(pagecache_folio);
@@ -6467,18 +6465,18 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			return handle_userfault(&vmf, VM_UFFD_WP);
 		}
 
-		entry = huge_pte_clear_uffd_wp(entry);
-		set_huge_pte_at(mm, haddr, ptep, entry,
+		vmf.orig_pte = huge_pte_clear_uffd_wp(vmf.orig_pte);
+		set_huge_pte_at(mm, vmf.address, vmf.pte, vmf.orig_pte,
 				huge_page_size(hstate_vma(vma)));
 		/* Fallthrough to CoW */
 	}
 
 	/*
-	 * hugetlb_wp() requires page locks of pte_page(entry) and
+	 * hugetlb_wp() requires page locks of pte_page(vmf.orig_pte) and
 	 * pagecache_folio, so here we need take the former one
 	 * when folio != pagecache_folio or !pagecache_folio.
 	 */
-	folio = page_folio(pte_page(entry));
+	folio = page_folio(pte_page(vmf.orig_pte));
 	if (folio != pagecache_folio)
 		if (!folio_trylock(folio)) {
 			need_wait_lock = 1;
@@ -6488,24 +6486,24 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	folio_get(folio);
 
 	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
-		if (!huge_pte_write(entry)) {
-			ret = hugetlb_wp(mm, vma, address, ptep, flags,
-					 pagecache_folio, ptl, &vmf);
+		if (!huge_pte_write(vmf.orig_pte)) {
+			ret = hugetlb_wp(mm, vma, address, vmf.pte, flags,
+					 pagecache_folio, vmf.ptl, &vmf);
 			goto out_put_page;
 		} else if (likely(flags & FAULT_FLAG_WRITE)) {
-			entry = huge_pte_mkdirty(entry);
+			vmf.orig_pte = huge_pte_mkdirty(vmf.orig_pte);
 		}
 	}
-	entry = pte_mkyoung(entry);
-	if (huge_ptep_set_access_flags(vma, haddr, ptep, entry,
+	vmf.orig_pte = pte_mkyoung(vmf.orig_pte);
+	if (huge_ptep_set_access_flags(vma, vmf.address, vmf.pte, vmf.orig_pte,
 						flags & FAULT_FLAG_WRITE))
-		update_mmu_cache(vma, haddr, ptep);
+		update_mmu_cache(vma, vmf.address, vmf.pte);
 out_put_page:
 	if (folio != pagecache_folio)
 		folio_unlock(folio);
 	folio_put(folio);
 out_ptl:
-	spin_unlock(ptl);
+	spin_unlock(vmf.ptl);
 
 	if (pagecache_folio) {
 		folio_unlock(pagecache_folio);
-- 
2.43.0


