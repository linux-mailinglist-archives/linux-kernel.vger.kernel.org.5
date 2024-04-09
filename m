Return-Path: <linux-kernel+bounces-136468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBAA89D45E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26D51C228CA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F1912D75C;
	Tue,  9 Apr 2024 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUsNWrnH"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEEF12880F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651240; cv=none; b=CTUNhhs0bp0uNTvcgB0pk4122J0IJBbtZ/RQdVjg1doe8RFr+80XxhOTQzzZte+zGmNo/N5+Uv/pyLyPMUX7AwIqVXL1+CjetZWDXYlQJv+pGEAy+Do3UQAxFeZU+AmquJMI05XR+jpGwwE073MZJN8C5++MAUrItYnR3tPCOq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651240; c=relaxed/simple;
	bh=itUkWLRcyPpOMmWElcAjrAh9Q4g+IKjYc56ZFGUD5Bw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bw0EPSGLsIXhMZQV+bg4Q84S7dtqUduHjS3b/InEb5qjmjaEznPkQTGajO/kxdyZGWVInP9+Jz0riI0UacesXoPdFtNvIO7Sj0hxvsfXAJ2+R+PUBfXxtLdf8eHSemN4NfgpvD9lNyW5CaH9A88cZEu4oynawEwaw1/sti6UuZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUsNWrnH; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5aa1b7a37b5so1725091eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712651237; x=1713256037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRaJtzo5cg/VrfJljXw5TEaEgpb4vopERkweBTeE6OA=;
        b=CUsNWrnHx/Gh7NkMXM3Jt3H4B1Ckegy5CJA0YLlpI0CneWWQpRg8i+Q3gFkIVs2HLm
         5n1WLukCzUSiNAGWbb4I9eCS9Aj9gvjOGUEoOWcjpmatQM8bFnQT7EaAuRAuiZ3EQgOd
         mMOdntJ4KGa2LhG45NNtbYW8fkl94d+LVDRZrTKVCDViKzyiapTxAQmVOw7pqPnynhPw
         0PsxcsKFrWVUpAVCgeYeQPhwoCyxXTcvG0SvMvp83w5qnVRfkPZ0BqK6hrz3MFZ4Sb7R
         DvhIPB5WgMrw3VFkt8noULy1JzSuMon026hSrDf5BnhriN+Zp3fPD1njS0plCg8apJHA
         156w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712651237; x=1713256037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRaJtzo5cg/VrfJljXw5TEaEgpb4vopERkweBTeE6OA=;
        b=G5A0kHAkgyo1LETZE/rEw9ADSOr4rmKpWz7wMZago+cWSiguDj8zpUD4drSNxK/vB+
         33YWD7arZ7DfPJzx8irfomO3X6dTHs801AkiZw1qaiAt1WKLkH1r/YhlwZTWjSdV1a5r
         jfJtbqeEAfcNr2D1lPs1kuWIv6mP8rNFZRIkjvfHyKqsBSyaYOopMp0RFQ5tYRB1mKIC
         shSgiQlY5Hhy7Lg2svZBFuU4nHs0QqvqcggklTjCYlkf+4HX6RDRfBuxmCakSnjcj56I
         qRLBJ3y93L/wTcrl1EYRT8PJYymg5zAUVKPcd7nXmqs11XqHpzeOYgZ2eL4SINMP+2RC
         Dg/A==
X-Forwarded-Encrypted: i=1; AJvYcCVyup4Kb3+OV0oFp/mIIn8/pjnpvm92tDgKbtIkutOj6smXyDUZvcTGzmn5ILO6Ix7n0oRbMm6HaPWt4noamVSDa2csckdtf99tuT55
X-Gm-Message-State: AOJu0Yz7J1lNIS67orYcbFo3RPmjWaLPnyMfvI/0ndFTpXHniJjDC242
	nW0A9rgRXtddtWv+WiPMyzI+1aW9CBZK1UzRbcN3pXY5jr0S+9j3
X-Google-Smtp-Source: AGHT+IFvN5ohj5Cxouk2/0fAxnzfDvT6AqBlF178427aMryNUnuyIkM8ZO3KggJQq1sFBYMpf6zx2g==
X-Received: by 2002:a05:6358:d59b:b0:186:45c:d6de with SMTP id ms27-20020a056358d59b00b00186045cd6demr6322611rwb.26.1712651237158;
        Tue, 09 Apr 2024 01:27:17 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id r16-20020a632050000000b005f05c88c149sm7594238pgm.71.2024.04.09.01.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 01:27:16 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kasong@tencent.com,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	ziy@nvidia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] mm: swap: entirely map large folios found in swapcache
Date: Tue,  9 Apr 2024 20:26:30 +1200
Message-Id: <20240409082631.187483-5-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409082631.187483-1-21cnbao@gmail.com>
References: <20240409082631.187483-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuanhua Han <hanchuanhua@oppo.com>

When a large folio is found in the swapcache, the current implementation
requires calling do_swap_page() nr_pages times, resulting in nr_pages
page faults. This patch opts to map the entire large folio at once to
minimize page faults. Additionally, redundant checks and early exits
for ARM64 MTE restoring are removed.

Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/memory.c | 64 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 12 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index c4a52e8d740a..9818dc1893c8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3947,6 +3947,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	pte_t pte;
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
+	int nr_pages = 1;
+	unsigned long start_address = vmf->address;
+	pte_t *start_pte = vmf->pte;
+	bool any_swap_shared = false;
 
 	if (!pte_unmap_same(vmf))
 		goto out;
@@ -4137,6 +4141,35 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 */
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
+
+	/* We hit large folios in swapcache */
+	if (start_pte && folio_test_large(folio) && folio_test_swapcache(folio)) {
+		int nr = folio_nr_pages(folio);
+		int idx = folio_page_idx(folio, page);
+		unsigned long folio_start = vmf->address - idx * PAGE_SIZE;
+		unsigned long folio_end = folio_start + nr * PAGE_SIZE;
+		pte_t *folio_ptep;
+		pte_t folio_pte;
+
+		if (unlikely(folio_start < max(vmf->address & PMD_MASK, vma->vm_start)))
+			goto check_pte;
+		if (unlikely(folio_end > pmd_addr_end(vmf->address, vma->vm_end)))
+			goto check_pte;
+
+		folio_ptep = vmf->pte - idx;
+		folio_pte = ptep_get(folio_ptep);
+		if (!is_swap_pte(folio_pte) || non_swap_entry(pte_to_swp_entry(folio_pte)) ||
+		    swap_pte_batch(folio_ptep, nr, folio_pte, &any_swap_shared) != nr)
+			goto check_pte;
+
+		start_address = folio_start;
+		start_pte = folio_ptep;
+		nr_pages = nr;
+		entry = folio->swap;
+		page = &folio->page;
+	}
+
+check_pte:
 	if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
 		goto out_nomap;
 
@@ -4190,6 +4223,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			 */
 			exclusive = false;
 		}
+
+		/* Reuse the whole large folio iff all entries are exclusive */
+		if (nr_pages > 1 && any_swap_shared)
+			exclusive = false;
 	}
 
 	/*
@@ -4204,12 +4241,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 * We're already holding a reference on the page but haven't mapped it
 	 * yet.
 	 */
-	swap_free(entry);
+	swap_free_nr(entry, nr_pages);
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
@@ -4219,33 +4258,34 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 * exclusivity.
 	 */
 	if (!folio_test_ksm(folio) &&
-	    (exclusive || folio_ref_count(folio) == 1)) {
+	    (exclusive || (folio_ref_count(folio) == nr_pages &&
+			   folio_nr_pages(folio) == nr_pages))) {
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
 		pte = pte_mkuffd_wp(pte);
-	vmf->orig_pte = pte;
 
 	/* ksm created a completely new copy */
 	if (unlikely(folio != swapcache && swapcache)) {
-		folio_add_new_anon_rmap(folio, vma, vmf->address);
+		folio_add_new_anon_rmap(folio, vma, start_address);
 		folio_add_lru_vma(folio, vma);
 	} else {
-		folio_add_anon_rmap_pte(folio, page, vma, vmf->address,
-					rmap_flags);
+		folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, start_address,
+					 rmap_flags);
 	}
 
 	VM_BUG_ON(!folio_test_anon(folio) ||
 			(pte_write(pte) && !PageAnonExclusive(page)));
-	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
-	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
+	set_ptes(vma->vm_mm, start_address, start_pte, pte, nr_pages);
+	vmf->orig_pte = ptep_get(vmf->pte);
+	arch_do_swap_page(vma->vm_mm, vma, start_address, pte, pte);
 
 	folio_unlock(folio);
 	if (folio != swapcache && swapcache) {
@@ -4269,7 +4309,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	}
 
 	/* No need to invalidate - it was non-present before */
-	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
+	update_mmu_cache_range(vmf, vma, start_address, start_pte, nr_pages);
 unlock:
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-- 
2.34.1


