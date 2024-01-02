Return-Path: <linux-kernel+bounces-14687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093D48220AD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6BB32815FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5114171D4;
	Tue,  2 Jan 2024 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSF6x50r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC93171BF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3e2972f65so23606835ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 09:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704218064; x=1704822864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sYlN8vSKv83J8k3KTy0zWmAC8wYuURkZt3/TH4YiDKw=;
        b=hSF6x50rWYkNjIKgbpg55GQuU89JYijV3c15EOyXX+TEpgqd61P+OgclIbgfg4V/WL
         fSdri9N9pAs/IVYKaSISENPNBdNm/z2UnDCtgvN1mOcwbxCBaAswrPZaI2+QlGpoo78R
         YzRuos0hC9fAFjJRtIp+J9JdoWae6JODji943kt2U/oWHDKumsM+dz68rAje9NW4rJcn
         wpoY8QqmabWUemUmqGReu7SChM6egszE3U7YMLxI6/WGZ2QQVFzYYDdOdqISGy4G0h6i
         EbJAlO6aC+ELFeKCdN4Sh2ZVySm3sr1ylmACdII/PUBVJOd1yueuralUEVmvRFlQ5Mu6
         PwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704218064; x=1704822864;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sYlN8vSKv83J8k3KTy0zWmAC8wYuURkZt3/TH4YiDKw=;
        b=wiWIw2tAcwen2GLBPbMeaqdFa5lvH2D3XyO6JIOMaQhDmNWgKbJCc7daBdjqB1Ccah
         0V+4Pow6cKU/ZCwEgVKLR5WqA/Vwvc+eKd2YoPPM0Z6nRvi72ctmIFS8L4iBQKSNM0kL
         j01bmOxBMaNHLcE3O1NdmAnECF5y5jBr/kLHi1fyEiLfQiLna5hkXstGWavnrNFjchgU
         zaRdlJoHt91uq1tAbA0HiXLvrrH9EFO+uE4X9z7QiVwLiLhtodsMIvFjMw/C4jwql1sB
         aFYVzUssQO7d1tAdJ96SEg/oe8YDABOF99Bvns+odkF2pTIhe3hylRmUoZGDslmDaulV
         PBPA==
X-Gm-Message-State: AOJu0YypICnCFkmgoX89nnxwaPMpQdHHRMfW7AWEh+thhpFMYQLxkJWf
	XBnB2XjHkorGbi/E9jViObgB325okUKkTplt
X-Google-Smtp-Source: AGHT+IEl/2qWBPW9Z5FVh74mUbrKLR970e9KepR/VbDcVwyuR9p3xpCkYWqKFuuUY+RAsB8Q97us6w==
X-Received: by 2002:a17:902:ea06:b0:1d4:2066:68c with SMTP id s6-20020a170902ea0600b001d42066068cmr8090026plg.130.1704218064019;
        Tue, 02 Jan 2024 09:54:24 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.41.9])
        by smtp.gmail.com with ESMTPSA id be10-20020a170902aa0a00b001d3c3d486bfsm22151969plb.163.2024.01.02.09.54.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Jan 2024 09:54:23 -0800 (PST)
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
Subject: [PATCH v2 9/9] mm/swap, shmem: use new swapin helper to skip readahead conditionally
Date: Wed,  3 Jan 2024 01:53:38 +0800
Message-ID: <20240102175338.62012-10-ryncsn@gmail.com>
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

Currently, shmem uses cluster readahead for all swap backends. Cluster
readahead is not a good solution for ramdisk based device (ZRAM) at all.

After switching to the new helper, most benchmarks showed a good result:

- Single file sequence read:
  perf stat --repeat 20 dd if=/tmpfs/test of=/dev/null bs=1M count=8192
  (/tmpfs/test is a zero filled file, using brd as swap, 4G memcg limit)
  Before: 22.248 +- 0.549
  After:  22.021 +- 0.684 (-1.1%)

- Random read stress test:
  fio -name=tmpfs --numjobs=16 --directory=/tmpfs \
  --size=256m --ioengine=mmap --rw=randread --random_distribution=random \
  --time_based --ramp_time=1m --runtime=5m --group_reporting
  (using brd as swap, 2G memcg limit)

  Before: 1818MiB/s
  After:  1888MiB/s (+3.85%)

- Zipf biased random read stress test:
  fio -name=tmpfs --numjobs=16 --directory=/tmpfs \
  --size=256m --ioengine=mmap --rw=randread --random_distribution=zipf:1.2 \
  --time_based --ramp_time=1m --runtime=5m --group_reporting
  (using brd as swap, 2G memcg limit)

  Before: 31.1GiB/s
  After:  32.3GiB/s (+3.86%)

So cluster readahead doesn't help much even for single sequence read,
and for random stress test, the performance is better without it.

Considering both memory and swap device will get more fragmented
slowly, and commonly used ZRAM consumes much more CPU than plain
ramdisk, false readahead could occur more frequently and waste
more CPU. Direct SWAP is cheaper, so use the new helper and skip
read ahead for SWP_SYNCHRONOUS_IO device.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/shmem.c      | 67 +++++++++++++++++++++++++------------------------
 mm/swap.h       |  9 -------
 mm/swap_state.c | 11 ++++++--
 3 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 9da9f7a0e620..3c0729fe934d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1564,20 +1564,6 @@ static inline struct mempolicy *shmem_get_sbmpol(struct shmem_sb_info *sbinfo)
 static struct mempolicy *shmem_get_pgoff_policy(struct shmem_inode_info *info,
 			pgoff_t index, unsigned int order, pgoff_t *ilx);
 
-static struct folio *shmem_swapin_cluster(swp_entry_t swap, gfp_t gfp,
-			struct shmem_inode_info *info, pgoff_t index)
-{
-	struct mempolicy *mpol;
-	pgoff_t ilx;
-	struct folio *folio;
-
-	mpol = shmem_get_pgoff_policy(info, index, 0, &ilx);
-	folio = swap_cluster_readahead(swap, gfp, mpol, ilx);
-	mpol_cond_put(mpol);
-
-	return folio;
-}
-
 /*
  * Make sure huge_gfp is always more limited than limit_gfp.
  * Some of the flags set permissions, while others set limitations.
@@ -1851,9 +1837,12 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
+	enum swap_cache_result cache_result;
 	struct swap_info_struct *si;
 	struct folio *folio = NULL;
+	struct mempolicy *mpol;
 	swp_entry_t swap;
+	pgoff_t ilx;
 	int error;
 
 	VM_BUG_ON(!*foliop || !xa_is_value(*foliop));
@@ -1871,36 +1860,40 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			return -EINVAL;
 	}
 
-	/* Look it up and read it in.. */
-	folio = swap_cache_get_folio(swap, NULL, 0, NULL);
+	mpol = shmem_get_pgoff_policy(info, index, 0, &ilx);
+	folio = swapin_entry_mpol(swap, gfp, mpol, ilx, &cache_result);
+	mpol_cond_put(mpol);
+
 	if (!folio) {
-		/* Or update major stats only when swapin succeeds?? */
+		error = -ENOMEM;
+		goto failed;
+	}
+	if (cache_result != SWAP_CACHE_HIT) {
 		if (fault_type) {
 			*fault_type |= VM_FAULT_MAJOR;
 			count_vm_event(PGMAJFAULT);
 			count_memcg_event_mm(fault_mm, PGMAJFAULT);
 		}
-		/* Here we actually start the io */
-		folio = shmem_swapin_cluster(swap, gfp, info, index);
-		if (!folio) {
-			error = -ENOMEM;
-			goto failed;
-		}
 	}
 
 	/* We have to do this with folio locked to prevent races */
 	folio_lock(folio);
-	if (!folio_test_swapcache(folio) ||
-	    folio->swap.val != swap.val ||
-	    !shmem_confirm_swap(mapping, index, swap)) {
+	if (cache_result != SWAP_CACHE_BYPASS) {
+		/* With cache bypass, folio is new allocated, sync, and not in cache */
+		if (!folio_test_swapcache(folio) || folio->swap.val != swap.val) {
+			error = -EEXIST;
+			goto unlock;
+		}
+		if (!folio_test_uptodate(folio)) {
+			error = -EIO;
+			goto failed;
+		}
+		folio_wait_writeback(folio);
+	}
+	if (!shmem_confirm_swap(mapping, index, swap)) {
 		error = -EEXIST;
 		goto unlock;
 	}
-	if (!folio_test_uptodate(folio)) {
-		error = -EIO;
-		goto failed;
-	}
-	folio_wait_writeback(folio);
 
 	/*
 	 * Some architectures may have to restore extra metadata to the
@@ -1908,12 +1901,19 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	 */
 	arch_swap_restore(swap, folio);
 
-	if (shmem_should_replace_folio(folio, gfp)) {
+	/* With cache bypass, folio is new allocated and always respect gfp flags */
+	if (cache_result != SWAP_CACHE_BYPASS && shmem_should_replace_folio(folio, gfp)) {
 		error = shmem_replace_folio(&folio, gfp, info, index);
 		if (error)
 			goto failed;
 	}
 
+	/*
+	 * The expected value checking below should be enough to ensure
+	 * only one up-to-date swapin success. swap_free() is called after
+	 * this, so the entry can't be reused. As long as the mapping still
+	 * has the old entry value, it's never swapped in or modified.
+	 */
 	error = shmem_add_to_page_cache(folio, mapping, index,
 					swp_to_radix_entry(swap), gfp);
 	if (error)
@@ -1924,7 +1924,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	if (sgp == SGP_WRITE)
 		folio_mark_accessed(folio);
 
-	delete_from_swap_cache(folio);
+	if (cache_result != SWAP_CACHE_BYPASS)
+		delete_from_swap_cache(folio);
 	folio_mark_dirty(folio);
 	swap_free(swap);
 	put_swap_device(si);
diff --git a/mm/swap.h b/mm/swap.h
index 8f790a67b948..20f4048c971c 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -57,9 +57,6 @@ void __delete_from_swap_cache(struct folio *folio,
 void delete_from_swap_cache(struct folio *folio);
 void clear_shadow_from_swap_cache(int type, unsigned long begin,
 				  unsigned long end);
-struct folio *swap_cache_get_folio(swp_entry_t entry,
-		struct vm_area_struct *vma, unsigned long addr,
-		void **shadowp);
 struct folio *filemap_get_incore_folio(struct address_space *mapping,
 		pgoff_t index);
 
@@ -123,12 +120,6 @@ static inline int swap_writepage(struct page *p, struct writeback_control *wbc)
 	return 0;
 }
 
-static inline struct folio *swap_cache_get_folio(swp_entry_t entry,
-		struct vm_area_struct *vma, unsigned long addr)
-{
-	return NULL;
-}
-
 static inline
 struct folio *filemap_get_incore_folio(struct address_space *mapping,
 		pgoff_t index)
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 3edf4b63158d..10eec68475dd 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -318,7 +318,14 @@ void free_pages_and_swap_cache(struct encoded_page **pages, int nr)
 
 static inline bool swap_use_no_readahead(struct swap_info_struct *si, swp_entry_t entry)
 {
-	return data_race(si->flags & SWP_SYNCHRONOUS_IO) && __swap_count(entry) == 1;
+	int count;
+
+	if (!data_race(si->flags & SWP_SYNCHRONOUS_IO))
+		return false;
+
+	count = __swap_count(entry);
+
+	return (count == 1 || count == SWAP_MAP_SHMEM);
 }
 
 static inline bool swap_use_vma_readahead(void)
@@ -334,7 +341,7 @@ static inline bool swap_use_vma_readahead(void)
  *
  * Caller must lock the swap device or hold a reference to keep it valid.
  */
-struct folio *swap_cache_get_folio(swp_entry_t entry,
+static struct folio *swap_cache_get_folio(swp_entry_t entry,
 		struct vm_area_struct *vma, unsigned long addr, void **shadowp)
 {
 	struct folio *folio;
-- 
2.43.0


