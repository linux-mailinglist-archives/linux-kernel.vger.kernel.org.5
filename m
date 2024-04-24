Return-Path: <linux-kernel+bounces-156362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2F28B01C9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FF521C22744
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DC7157480;
	Wed, 24 Apr 2024 06:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PiY8173w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E09A182AE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940261; cv=none; b=RO6TdYcGlTjFqFwE+EaxMc8K3d+K27bv+uKiCk/Z2B+mTTZNb1yPo6ZibnDYAAMVNiGk5ufoBZCt5+E+7+KfP8Y6Qs1ppXWKIkQCb+QmvAPu2VzULXc0egK/BQIe9pfPIP1EM/SqmytlCMr19Ac6pUcfsOI7sTdweKkLzmt2JMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940261; c=relaxed/simple;
	bh=USIiH+WCOin8AaRM3HyS9rsb7dMz9eGkGM+QMZdj2T8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UoIb7In3+CZeYz3qeG3F2erxZxyBQKdlsagXPRS/5NMFh3zokEaCUpkFNlLW1NhZcnT1tknNJ11r+4RoApZlf9gxsCAOqrunbMdU8jD4ez9kuF8RtHAbTZeA7CMuucWtKxTLmwHi5soyJN4qRDFqikORbiwlL6heAfLMaeqFNc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PiY8173w; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713940259; x=1745476259;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=USIiH+WCOin8AaRM3HyS9rsb7dMz9eGkGM+QMZdj2T8=;
  b=PiY8173wQZlU8/S0sVxMZrzIfMgh5SqN0GFFrgR66KQHtGxFElIdX7On
   tQjmDO6FRz7cRKLzemy0b9MsTjl+a4ByA084VoxkQ6f4HCqUto1aRJ64K
   313+CIRK/c/IdFXxvz5vVttx9A1Sr2nk5b6Wuqbzx0stjMkOHv0uOi9gT
   grJ5u3swVrUXLRGz2TU8YuPZY/mD/0oLeU2nGNs24JczVb7MHWSMTrF9G
   BSs09zmI5q8o0/94618oNZvdCUef/hJ8BHmQx483GBIz1qXT6ZLV6lpik
   A06Lih4rDgJmcfzIyc1GyvV+ungv6jkH0LfpReOtH3uOqhRp959MX/ZGU
   A==;
X-CSE-ConnectionGUID: eqtFTjomTJC9xlpZ2syUTQ==
X-CSE-MsgGUID: 4siyMN9xQSmj0mn0M5QDZA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="27067853"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="27067853"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 23:30:58 -0700
X-CSE-ConnectionGUID: zmYgMUzTR9e0Fgun8F19+A==
X-CSE-MsgGUID: C1E3fsLkSh+nxy6LZhpbTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="29413610"
Received: from unknown (HELO yhuang6-mobl2.sh.intel.com) ([10.238.6.133])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 23:30:54 -0700
From: Huang Ying <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Hugh Dickins <hughd@google.com>,
	Alistair Popple <apopple@nvidia.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Minchan Kim <minchan@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yang Shi <shy828301@gmail.com>,
	Yu Zhao <yuzhao@google.com>,
	Kairui Song <kasong@tencent.com>,
	Barry Song <v-songbaohua@oppo.com>,
	Chris Li <chrisl@kernel.org>,
	Yosry Ahmed <yosryahmed@google.com>
Subject: [PATCH] mm,swap: cleanup VMA based swap readahead window calculation
Date: Wed, 24 Apr 2024 14:30:42 +0800
Message-Id: <20240424063042.665018-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When VMA based swap readahead is introduced in commit
ec560175c0b6 ("mm, swap: VMA based swap readahead"), "struct
vma_swap_readahead" is defined to describe the readahead window.
Because we wanted to save the PTE entries in the struct at that time.
But after commit 4f8fcf4ced0b ("mm/swap: swap_vma_readahead() do the
pte_offset_map()"), we no longer save PTE entries in the struct.  The
size of the struct becomes so small, that it's better to use the
fields of the struct directly.  This can simplify the code to improve
the code readability.  The line number of source code reduces too.

No functionality change is expected in this patch.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: Barry Song <v-songbaohua@oppo.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>
---
 mm/swap_state.c | 86 ++++++++++++++++++-------------------------------
 1 file changed, 32 insertions(+), 54 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index bfc7e8c58a6d..19874e7bab70 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -42,6 +42,8 @@ struct address_space *swapper_spaces[MAX_SWAPFILES] __read_mostly;
 static unsigned int nr_swapper_spaces[MAX_SWAPFILES] __read_mostly;
 static bool enable_vma_readahead __read_mostly = true;
 
+#define SWAP_RA_ORDER_CEILING	5
+
 #define SWAP_RA_WIN_SHIFT	(PAGE_SHIFT / 2)
 #define SWAP_RA_HITS_MASK	((1UL << SWAP_RA_WIN_SHIFT) - 1)
 #define SWAP_RA_HITS_MAX	SWAP_RA_HITS_MASK
@@ -738,62 +740,42 @@ void exit_swap_address_space(unsigned int type)
 	swapper_spaces[type] = NULL;
 }
 
-#define SWAP_RA_ORDER_CEILING	5
-
-struct vma_swap_readahead {
-	unsigned short win;
-	unsigned short offset;
-	unsigned short nr_pte;
-};
-
-static void swap_ra_info(struct vm_fault *vmf,
-			 struct vma_swap_readahead *ra_info)
+static int swap_vma_ra_win(struct vm_fault *vmf, unsigned long *start,
+			   unsigned long *end)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long ra_val;
-	unsigned long faddr, pfn, fpfn, lpfn, rpfn;
-	unsigned long start, end;
+	unsigned long faddr, prev_faddr, left, right;
 	unsigned int max_win, hits, prev_win, win;
 
-	max_win = 1 << min_t(unsigned int, READ_ONCE(page_cluster),
-			     SWAP_RA_ORDER_CEILING);
-	if (max_win == 1) {
-		ra_info->win = 1;
-		return;
-	}
+	max_win = 1 << min(READ_ONCE(page_cluster), SWAP_RA_ORDER_CEILING);
+	if (max_win == 1)
+		return 1;
 
 	faddr = vmf->address;
-	fpfn = PFN_DOWN(faddr);
 	ra_val = GET_SWAP_RA_VAL(vma);
-	pfn = PFN_DOWN(SWAP_RA_ADDR(ra_val));
+	prev_faddr = SWAP_RA_ADDR(ra_val);
 	prev_win = SWAP_RA_WIN(ra_val);
 	hits = SWAP_RA_HITS(ra_val);
-	ra_info->win = win = __swapin_nr_pages(pfn, fpfn, hits,
-					       max_win, prev_win);
-	atomic_long_set(&vma->swap_readahead_info,
-			SWAP_RA_VAL(faddr, win, 0));
+	win = __swapin_nr_pages(PFN_DOWN(prev_faddr), PFN_DOWN(faddr), hits,
+				max_win, prev_win);
+	atomic_long_set(&vma->swap_readahead_info, SWAP_RA_VAL(faddr, win, 0));
 	if (win == 1)
-		return;
+		return 1;
 
-	if (fpfn == pfn + 1) {
-		lpfn = fpfn;
-		rpfn = fpfn + win;
-	} else if (pfn == fpfn + 1) {
-		lpfn = fpfn - win + 1;
-		rpfn = fpfn + 1;
-	} else {
-		unsigned int left = (win - 1) / 2;
+	if (faddr == prev_faddr + PAGE_SIZE)
+		left = faddr;
+	else if (prev_faddr == faddr + PAGE_SIZE)
+		left = faddr - (win << PAGE_SHIFT) + PAGE_SIZE;
+	else
+		left = faddr - (((win - 1) / 2) << PAGE_SHIFT);
+	right = left + (win << PAGE_SHIFT);
+	if ((long)left < 0)
+		left = 0;
+	*start = max3(left, vma->vm_start, faddr & PMD_MASK);
+	*end = min3(right, vma->vm_end, (faddr & PMD_MASK) + PMD_SIZE);
 
-		lpfn = fpfn - left;
-		rpfn = fpfn + win - left;
-	}
-	start = max3(lpfn, PFN_DOWN(vma->vm_start),
-		     PFN_DOWN(faddr & PMD_MASK));
-	end = min3(rpfn, PFN_DOWN(vma->vm_end),
-		   PFN_DOWN((faddr & PMD_MASK) + PMD_SIZE));
-
-	ra_info->nr_pte = end - start;
-	ra_info->offset = fpfn - start;
+	return win;
 }
 
 /**
@@ -819,24 +801,20 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 	struct swap_iocb *splug = NULL;
 	struct folio *folio;
 	pte_t *pte = NULL, pentry;
-	unsigned long addr;
+	int win;
+	unsigned long start, end, addr;
 	swp_entry_t entry;
 	pgoff_t ilx;
-	unsigned int i;
 	bool page_allocated;
-	struct vma_swap_readahead ra_info = {
-		.win = 1,
-	};
 
-	swap_ra_info(vmf, &ra_info);
-	if (ra_info.win == 1)
+	win = swap_vma_ra_win(vmf, &start, &end);
+	if (win == 1)
 		goto skip;
 
-	addr = vmf->address - (ra_info.offset * PAGE_SIZE);
-	ilx = targ_ilx - ra_info.offset;
+	ilx = targ_ilx - PFN_DOWN(vmf->address - start);
 
 	blk_start_plug(&plug);
-	for (i = 0; i < ra_info.nr_pte; i++, ilx++, addr += PAGE_SIZE) {
+	for (addr = start; addr < end; ilx++, addr += PAGE_SIZE) {
 		if (!pte++) {
 			pte = pte_offset_map(vmf->pmd, addr);
 			if (!pte)
@@ -856,7 +834,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 			continue;
 		if (page_allocated) {
 			swap_read_folio(folio, false, &splug);
-			if (i != ra_info.offset) {
+			if (addr != vmf->address) {
 				folio_set_readahead(folio);
 				count_vm_event(SWAP_RA);
 			}
-- 
2.39.2


