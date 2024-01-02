Return-Path: <linux-kernel+bounces-14684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 798128220AA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9068D1C22682
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5763C168B2;
	Tue,  2 Jan 2024 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxubI01Y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D6A16439
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d3f8af8297so33802465ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 09:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704218053; x=1704822853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WQ0rvcDFd1GF49xQGBwNPnCf4JL45lf63n9SBHxFbwk=;
        b=HxubI01YHxZeLZXmBGUJPUWLPXNnjeznxPdl/qi6OcXRdcoLKNJaVjW54Z8+WHm9zo
         7abgLdYleMTvbXgGy9o8v0RHu54toPPNMDVOoZH7h8Qi/oed3qyBqyHihxgB4I9cLGfl
         7sHyHFbN5A16fGjZYuo2wee7ZlvWTaFb7TMMfsTAenwpd+d4o4kcdjFz0JNln0YSNp7/
         lVvkunFAX/w/fQA2rRVYf5rY0MP4aZWT8CdBZg669B9flf5McUOHhw0BiJ61/+/s62UY
         2O/kUT58BQ8n2hksDjA91CRNcpqHXqQDqLRWGop+Y1DUKoQmN6CnrcKuPXBsyM/5ZOlo
         tZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704218053; x=1704822853;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WQ0rvcDFd1GF49xQGBwNPnCf4JL45lf63n9SBHxFbwk=;
        b=wtA6G/oEH/L/+alczYr++A3+eD9WbxQlcbhNGgWLx2YWOh88um9F93CRRuKIm6FUn4
         quyZqXEb49e2VE6mTNTcf2W0Pk2+VC/9fJ6qRzgfsiYdBWoDMcO6sySJs/XKxZQOKLPF
         BtkhrS6pobxe7axuXDwr5dhMSDcjmR1d8EBjTlGMUUcm4am8B7uMm6uK4uIawuDZGabr
         DGAIsYlQuSierplmb0XT7WW1sA9IFhi2QVREttjofYOw+RPcy9maFMI6atGXfSxxwFqB
         CSob0VTlO5SuWAEIoFHwj/5MVYQOyLsTc4a2NqEFLQWuk0bpnze9HHYOL5Sd307BU3OD
         bEYQ==
X-Gm-Message-State: AOJu0YyKPhTRQRCkjKOciyG7c0j4NiTbR/L5PyeRJ3yG52ldItVNk/Nl
	GcYabRHmrEOL6q19CFERkSE=
X-Google-Smtp-Source: AGHT+IEqRxzrscJ5aDzXjoCzOKW/mGxYYasxFtxeT189T8sXpnySEuTBNSzOKUPECfaBTd/IXyLMhw==
X-Received: by 2002:a17:903:2352:b0:1d4:c1b3:c6c with SMTP id c18-20020a170903235200b001d4c1b30c6cmr1260292plh.51.1704218053424;
        Tue, 02 Jan 2024 09:54:13 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.41.9])
        by smtp.gmail.com with ESMTPSA id be10-20020a170902aa0a00b001d3c3d486bfsm22151969plb.163.2024.01.02.09.54.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Jan 2024 09:54:12 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	David Hildenbrand <david@redhat.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 6/9] mm/swap: handle swapcache lookup in swapin_entry
Date: Wed,  3 Jan 2024 01:53:35 +0800
Message-ID: <20240102175338.62012-7-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102175338.62012-1-ryncsn@gmail.com>
References: <20240102175338.62012-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Since all callers of swapin_entry need to check the swap cache first, we
can merge this common routine into swapin_entry, so it can be shared and
optimized later.

Also introduce a enum to better represent possible swap cache usage, and
add some comments about it, make the usage of swap cache easier to
understand.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c     | 45 ++++++++++++++++++++-------------------------
 mm/swap.h       | 20 ++++++++++++++++++--
 mm/swap_state.c | 22 ++++++++++++++--------
 mm/swapfile.c   | 21 +++++++++------------
 4 files changed, 61 insertions(+), 47 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b56254a875f8..ab6e76c95632 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3795,13 +3795,13 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 vm_fault_t do_swap_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
-	struct folio *swapcache, *folio = NULL;
+	struct folio *swapcache = NULL, *folio;
+	enum swap_cache_result cache_result;
 	struct page *page;
 	struct swap_info_struct *si = NULL;
 	rmap_t rmap_flags = RMAP_NONE;
 	bool exclusive = false;
 	swp_entry_t entry;
-	bool swapcached;
 	pte_t pte;
 	vm_fault_t ret = 0;
 
@@ -3859,31 +3859,26 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (unlikely(!si))
 		goto out;
 
-	folio = swap_cache_get_folio(entry, vma, vmf->address);
-	if (folio)
+	folio = swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
+			     vmf, &cache_result);
+	if (folio) {
 		page = folio_file_page(folio, swp_offset(entry));
-	swapcache = folio;
-
-	if (!folio) {
-		folio = swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
-				     vmf, &swapcached);
-		if (folio) {
-			page = folio_file_page(folio, swp_offset(entry));
-			if (swapcached)
-				swapcache = folio;
-		} else {
-			/*
-			 * Back out if somebody else faulted in this pte
-			 * while we released the pte lock.
-			 */
-			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
-					vmf->address, &vmf->ptl);
-			if (likely(vmf->pte &&
-				   pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
-				ret = VM_FAULT_OOM;
-			goto unlock;
-		}
+		if (cache_result != SWAP_CACHE_BYPASS)
+			swapcache = folio;
+	} else {
+		/*
+		 * Back out if somebody else faulted in this pte
+		 * while we released the pte lock.
+		 */
+		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
+				vmf->address, &vmf->ptl);
+		if (likely(vmf->pte &&
+			   pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
+			ret = VM_FAULT_OOM;
+		goto unlock;
+	}
 
+	if (cache_result != SWAP_CACHE_HIT) {
 		/* Had to read the page from swap area: Major fault */
 		ret = VM_FAULT_MAJOR;
 		count_vm_event(PGMAJFAULT);
diff --git a/mm/swap.h b/mm/swap.h
index 502a2801f817..1f4cdb324bf0 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -4,6 +4,22 @@
 
 struct mempolicy;
 
+/*
+ * Caller of swapin_entry may need to know the cache lookup result:
+ *
+ * SWAP_CACHE_HIT: cache hit, cached folio is retured.
+ * SWAP_CACHE_MISS: cache miss, folio is allocated, read from swap device
+ *                  and adde to swap cache, but still may return a cached
+ *                  folio if raced (check __read_swap_cache_async).
+ * SWAP_CACHE_BYPASS: cache miss, folio is new allocated and read
+ *                    from swap device bypassing the cache.
+ */
+enum swap_cache_result {
+	SWAP_CACHE_HIT,
+	SWAP_CACHE_MISS,
+	SWAP_CACHE_BYPASS,
+};
+
 #ifdef CONFIG_SWAP
 #include <linux/blk_types.h> /* for bio_end_io_t */
 
@@ -55,7 +71,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_flags,
 struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 		struct mempolicy *mpol, pgoff_t ilx);
 struct folio *swapin_entry(swp_entry_t entry, gfp_t flag,
-			    struct vm_fault *vmf, bool *swapcached);
+			    struct vm_fault *vmf, enum swap_cache_result *result);
 
 static inline unsigned int folio_swap_flags(struct folio *folio)
 {
@@ -87,7 +103,7 @@ static inline struct folio *swap_cluster_readahead(swp_entry_t entry,
 }
 
 static inline struct folio *swapin_entry(swp_entry_t swp, gfp_t gfp_mask,
-			struct vm_fault *vmf, bool *swapcached)
+			struct vm_fault *vmf, enum swap_cache_result *result)
 {
 	return NULL;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 66ff187aa5d3..f6f1e6f5d782 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -917,8 +917,7 @@ static struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
  * @entry: swap entry of this memory
  * @gfp_mask: memory allocation flags
  * @vmf: fault information
- * @swapcached: pointer to a bool used as indicator if the
- *              page is swapped in through swapcache.
+ * @result: a return value to indicate swap cache usage.
  *
  * Returns the struct page for entry and addr, after queueing swapin.
  *
@@ -928,16 +927,22 @@ static struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
  * or skip the readahead (ie, ramdisk based swap device).
  */
 struct folio *swapin_entry(swp_entry_t entry, gfp_t gfp_mask,
-			   struct vm_fault *vmf, bool *swapcached)
+			   struct vm_fault *vmf, enum swap_cache_result *result)
 {
+	enum swap_cache_result cache_result;
 	struct mempolicy *mpol;
 	struct folio *folio;
 	pgoff_t ilx;
-	bool cached;
+
+	folio = swap_cache_get_folio(entry, vmf->vma, vmf->address);
+	if (folio) {
+		cache_result = SWAP_CACHE_HIT;
+		goto done;
+	}
 
 	if (swap_use_no_readahead(swp_swap_info(entry), entry)) {
 		folio = swapin_direct(entry, gfp_mask, vmf);
-		cached = false;
+		cache_result = SWAP_CACHE_BYPASS;
 	} else {
 		mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
 		if (swap_use_vma_readahead())
@@ -945,11 +950,12 @@ struct folio *swapin_entry(swp_entry_t entry, gfp_t gfp_mask,
 		else
 			folio = swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
 		mpol_cond_put(mpol);
-		cached = true;
+		cache_result = SWAP_CACHE_MISS;
 	}
 
-	if (swapcached)
-		*swapcached = cached;
+done:
+	if (result)
+		*result = cache_result;
 
 	return folio;
 }
diff --git a/mm/swapfile.c b/mm/swapfile.c
index ce4e6c10dce7..5aa44de11edc 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1845,6 +1845,13 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		int ret;
 		pte_t ptent;
 
+		struct vm_fault vmf = {
+			.vma = vma,
+			.address = addr,
+			.real_address = addr,
+			.pmd = pmd,
+		};
+
 		if (!pte++) {
 			pte = pte_offset_map(pmd, addr);
 			if (!pte)
@@ -1864,18 +1871,8 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		pte_unmap(pte);
 		pte = NULL;
 
-		folio = swap_cache_get_folio(entry, vma, addr);
-		if (!folio) {
-			struct vm_fault vmf = {
-				.vma = vma,
-				.address = addr,
-				.real_address = addr,
-				.pmd = pmd,
-			};
-
-			folio = swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
-					    &vmf, NULL);
-		}
+		folio = swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
+				     &vmf, NULL);
 		if (!folio) {
 			/*
 			 * The entry could have been freed, and will not
-- 
2.43.0


