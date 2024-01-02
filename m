Return-Path: <linux-kernel+bounces-14683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B17D8220A9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C358E282E31
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FAF16414;
	Tue,  2 Jan 2024 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1IUZ15P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BA116400
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d4a980fdedso18617695ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 09:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704218050; x=1704822850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nlZ0fg6NatnLjyD4rpGx2P4cih5u8+SQurmVS5ry9aQ=;
        b=d1IUZ15PrvfH4sIZWM9dh5/ZjjJBNUeQsauTWJAQM5A+DYZJd5s5VqrNTVY22eHj69
         OHXcyuCRhAyOyohsdngiCNsS669xt19+3lR/4yDdTaDZ0JZFnzKqEDXY7xROrA1+hg3l
         Httm3BHwRdTYwjDo2vOC0XJP7FMi+eofHeip5z0tV4iqZmYoU/ZlA/ocm/btUBGxzh6s
         mz03Ru6FdAF+KhcKMU/ODQJ62D/Zu8PJfYByMssaFtWVjGLa/DmKTpLO0O6fvFF40Bga
         /a9RSwC5cytBGxYrDeK5sCWygfcytMB4LbF2SUeA+1IESGhBTKQDpoEPqtlmuA5Ho6A6
         GnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704218050; x=1704822850;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nlZ0fg6NatnLjyD4rpGx2P4cih5u8+SQurmVS5ry9aQ=;
        b=HhOKJf+gcUFiEshMcN+bH4l0624PtueaDGgI2QOfUAhXAgpI1himqOVFRIeC5RysH2
         jDq6mednBOsBbdSxSNzOYnK59iWYqYeGv+wP03lb0vaEKjEWN8oQ0xIbAi/nurntyl1j
         MCrfvwu6nOB068pc/nLVHIiH7zliO6g2mQaHzaFd6DESdy3pcoJVkU1VddcO2mCxv5Cp
         F9RFTpMqiMigw2E5AjkyFjRG1Zlm81uVztP+LvQf3UwPa0R9CfSC5vG33zlpkNNp8muK
         EpxUQdOxiEmsPyr8+/uoYGBQf6hojRwBwJU3QPQ5foz8NmE7s9j9ynsJTpdXFIGCbBgb
         FoUQ==
X-Gm-Message-State: AOJu0Yx64XzP/IY4EvtWiouXHb0uqBji4dOmom4qUtDpuTjNfTP5Ec79
	ekO6I8w5sZooJCHAGwAoI2kRvH7cy0jtdaUN
X-Google-Smtp-Source: AGHT+IHg3EaXPsfJ3BsQyYM+9C4NVV8c46gR3f+IfIC1eTcpnGbk9EIEm5Ji/30WqG1cQYmyBx9asQ==
X-Received: by 2002:a17:903:41d1:b0:1d4:3b72:b294 with SMTP id u17-20020a17090341d100b001d43b72b294mr20703980ple.88.1704218049886;
        Tue, 02 Jan 2024 09:54:09 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.41.9])
        by smtp.gmail.com with ESMTPSA id be10-20020a170902aa0a00b001d3c3d486bfsm22151969plb.163.2024.01.02.09.54.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Jan 2024 09:54:09 -0800 (PST)
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
Subject: [PATCH v2 5/9] mm/swap: introduce swapin_entry for unified readahead policy
Date: Wed,  3 Jan 2024 01:53:34 +0800
Message-ID: <20240102175338.62012-6-ryncsn@gmail.com>
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

Introduce swapin_entry which merges swapin_readahead and swapin_direct
making it the main entry for swapin pages, and use a unified swapin
policy.

This commit makes swapoff make use of this new helper and now swapping
off a 10G ZRAM (lzo-rle) is faster since readahead is skipped.

Before:
time swapoff /dev/zram0
real    0m12.337s
user    0m0.001s
sys     0m12.329s

After:
time swapoff /dev/zram0
real    0m9.728s
user    0m0.001s
sys     0m9.719s

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c     | 21 +++++++--------------
 mm/swap.h       | 16 ++++------------
 mm/swap_state.c | 49 +++++++++++++++++++++++++++++++++----------------
 mm/swapfile.c   |  7 ++-----
 4 files changed, 46 insertions(+), 47 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 0165c8cad489..b56254a875f8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3801,6 +3801,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	rmap_t rmap_flags = RMAP_NONE;
 	bool exclusive = false;
 	swp_entry_t entry;
+	bool swapcached;
 	pte_t pte;
 	vm_fault_t ret = 0;
 
@@ -3864,21 +3865,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	swapcache = folio;
 
 	if (!folio) {
-		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
-		    __swap_count(entry) == 1) {
-			/* skip swapcache and readahead */
-			folio = swapin_direct(entry, GFP_HIGHUSER_MOVABLE, vmf);
-			if (folio)
-				page = &folio->page;
+		folio = swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
+				     vmf, &swapcached);
+		if (folio) {
+			page = folio_file_page(folio, swp_offset(entry));
+			if (swapcached)
+				swapcache = folio;
 		} else {
-			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
-						vmf);
-			if (page)
-				folio = page_folio(page);
-			swapcache = folio;
-		}
-
-		if (!folio) {
 			/*
 			 * Back out if somebody else faulted in this pte
 			 * while we released the pte lock.
diff --git a/mm/swap.h b/mm/swap.h
index 83eab7b67e77..502a2801f817 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -54,10 +54,8 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_flags,
 		bool skip_if_exists);
 struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 		struct mempolicy *mpol, pgoff_t ilx);
-struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
-			      struct vm_fault *vmf);
-struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
-			    struct vm_fault *vmf);
+struct folio *swapin_entry(swp_entry_t entry, gfp_t flag,
+			    struct vm_fault *vmf, bool *swapcached);
 
 static inline unsigned int folio_swap_flags(struct folio *folio)
 {
@@ -88,14 +86,8 @@ static inline struct folio *swap_cluster_readahead(swp_entry_t entry,
 	return NULL;
 }
 
-struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
-			struct vm_fault *vmf)
-{
-	return NULL;
-}
-
-static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
-			struct vm_fault *vmf)
+static inline struct folio *swapin_entry(swp_entry_t swp, gfp_t gfp_mask,
+			struct vm_fault *vmf, bool *swapcached)
 {
 	return NULL;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index d39c5369da21..66ff187aa5d3 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -316,6 +316,11 @@ void free_pages_and_swap_cache(struct encoded_page **pages, int nr)
 	release_pages(pages, nr);
 }
 
+static inline bool swap_use_no_readahead(struct swap_info_struct *si, swp_entry_t entry)
+{
+	return data_race(si->flags & SWP_SYNCHRONOUS_IO) && __swap_count(entry) == 1;
+}
+
 static inline bool swap_use_vma_readahead(void)
 {
 	return READ_ONCE(enable_vma_readahead) && !atomic_read(&nr_rotate_swap);
@@ -870,8 +875,8 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
  * Returns the struct folio for entry and addr after the swap entry is read
  * in.
  */
-struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
-			    struct vm_fault *vmf)
+static struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
+				  struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *folio;
@@ -908,33 +913,45 @@ struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
 }
 
 /**
- * swapin_readahead - swap in pages in hope we need them soon
+ * swapin_entry - swap in a page from swap entry
  * @entry: swap entry of this memory
  * @gfp_mask: memory allocation flags
  * @vmf: fault information
+ * @swapcached: pointer to a bool used as indicator if the
+ *              page is swapped in through swapcache.
  *
  * Returns the struct page for entry and addr, after queueing swapin.
  *
- * It's a main entry function for swap readahead. By the configuration,
+ * It's a main entry function for swap in. By the configuration,
  * it will read ahead blocks by cluster-based(ie, physical disk based)
- * or vma-based(ie, virtual address based on faulty address) readahead.
+ * or vma-based(ie, virtual address based on faulty address) readahead,
+ * or skip the readahead (ie, ramdisk based swap device).
  */
-struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
-				struct vm_fault *vmf)
+struct folio *swapin_entry(swp_entry_t entry, gfp_t gfp_mask,
+			   struct vm_fault *vmf, bool *swapcached)
 {
 	struct mempolicy *mpol;
-	pgoff_t ilx;
 	struct folio *folio;
+	pgoff_t ilx;
+	bool cached;
 
-	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
-	folio = swap_use_vma_readahead() ?
-		swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf) :
-		swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
-	mpol_cond_put(mpol);
+	if (swap_use_no_readahead(swp_swap_info(entry), entry)) {
+		folio = swapin_direct(entry, gfp_mask, vmf);
+		cached = false;
+	} else {
+		mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
+		if (swap_use_vma_readahead())
+			folio = swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf);
+		else
+			folio = swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
+		mpol_cond_put(mpol);
+		cached = true;
+	}
 
-	if (!folio)
-		return NULL;
-	return folio_file_page(folio, swp_offset(entry));
+	if (swapcached)
+		*swapcached = cached;
+
+	return folio;
 }
 
 #ifdef CONFIG_SYSFS
diff --git a/mm/swapfile.c b/mm/swapfile.c
index f7271504aa0a..ce4e6c10dce7 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1866,7 +1866,6 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 
 		folio = swap_cache_get_folio(entry, vma, addr);
 		if (!folio) {
-			struct page *page;
 			struct vm_fault vmf = {
 				.vma = vma,
 				.address = addr,
@@ -1874,10 +1873,8 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				.pmd = pmd,
 			};
 
-			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
-						&vmf);
-			if (page)
-				folio = page_folio(page);
+			folio = swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
+					    &vmf, NULL);
 		}
 		if (!folio) {
 			/*
-- 
2.43.0


