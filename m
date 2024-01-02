Return-Path: <linux-kernel+bounces-14685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E3F8220AB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452601C226E9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C79D168CF;
	Tue,  2 Jan 2024 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3/c1RD+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EFC168BF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 17:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d3eb299e2eso44778135ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 09:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704218057; x=1704822857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wKrEvGkZ8GQyBX+qIUqWP+XNbS2tofN+iPdO+E071Zk=;
        b=i3/c1RD+DChkvymDRkcUCFyrARZtmNDvfOcYKJL10LqpYvuf376ck7zDsWlNkLnm7S
         pA5GVWZJ5aXyBg2OT9zLKAtGYDlg0sdetUdK9MJtvhJJA0VuWHuuBd+eyvV+OEzOkhcr
         gbwgOSXo3UYHchzrSQYG7Bgw37yDI0o413JFoH6C3n03CVP/CV/qcfzItHHNmgmpxIUD
         +fBeYxcY4KYXU4IZTsSf0Y+JgJLFEUpSAuJoUm/uM1MfomHj5BqC4bM55LECvYqv7/4E
         Yd6B0Nk1wpS3W22now8OquYvrZwT3ERSrF1ZlRkdBW/flqCv2nUp19kUNoDjpJn9i8fQ
         Oegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704218057; x=1704822857;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wKrEvGkZ8GQyBX+qIUqWP+XNbS2tofN+iPdO+E071Zk=;
        b=vHvXkZ0cGFdrKNdhXcPYRqGkwghIGk30VBmlMi1S1s1KK5hogEGyb2s/2moioaveo6
         T8e5IKIFGWx4uOLp9T0WBkosv/lUi3lDgy3pRuzu5L8lEhTvBdxImBTuooMYEALJ6tyi
         ZyIxDeuJ2+opFAGywBmadIUeyRXLt+aNqmvgmlyai5oI5UFgg7VeHNh55BS7lltyF6Na
         uDyhwgH5y+mTG8CH91+267Izfs36+tcVRzUGS/+FszueotzrGzpYn+DUlKeya143A249
         KoP/f3LGsYkCp81RlRw62UHqmEmLtATQECgvG+mjG5DLeWk8ICtVCLr0yYK74mKyAe1v
         T2Bg==
X-Gm-Message-State: AOJu0YwoA2gleZKhCd5axNMYXDEu1N3Y0CEkAkiDZ2a6dqxDJ1HqKcRP
	oo+75Txaz8w2/RYZ183QjlI=
X-Google-Smtp-Source: AGHT+IEdREnUFQzLQLXziwcbdTCFJIEnWtbesYR/Yi2j7ybSJZObtayDa/HB7ljxXyH3M9oPbUbcVA==
X-Received: by 2002:a17:902:e88e:b0:1d4:cdcf:97e8 with SMTP id w14-20020a170902e88e00b001d4cdcf97e8mr238233plg.126.1704218056928;
        Tue, 02 Jan 2024 09:54:16 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.41.9])
        by smtp.gmail.com with ESMTPSA id be10-20020a170902aa0a00b001d3c3d486bfsm22151969plb.163.2024.01.02.09.54.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Jan 2024 09:54:16 -0800 (PST)
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
Subject: [PATCH v2 7/9] mm/swap: avoid a duplicated swap cache lookup for SWP_SYNCHRONOUS_IO
Date: Wed,  3 Jan 2024 01:53:36 +0800
Message-ID: <20240102175338.62012-8-ryncsn@gmail.com>
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

When a xa_value is returned by the cache lookup, keep it to be used
later for workingset refault check instead of doing the looking up again
in swapin_no_readahead.

This does have a side effect of making swapoff also triggers workingset
check, but should be fine since swapoff does affect the workload in many
ways already.

After this commit, swappin is about 4% faster for ZRAM, micro benchmark
result which use madvise to swap out 10G zero-filled data to ZRAM then
read them in:

Before: 11143285 us
After:  10692644 us (+4.1%)

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/shmem.c      |  2 +-
 mm/swap.h       |  3 ++-
 mm/swap_state.c | 24 +++++++++++++-----------
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 928aa2304932..9da9f7a0e620 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1872,7 +1872,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	}
 
 	/* Look it up and read it in.. */
-	folio = swap_cache_get_folio(swap, NULL, 0);
+	folio = swap_cache_get_folio(swap, NULL, 0, NULL);
 	if (!folio) {
 		/* Or update major stats only when swapin succeeds?? */
 		if (fault_type) {
diff --git a/mm/swap.h b/mm/swap.h
index 1f4cdb324bf0..9180411afcfe 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -58,7 +58,8 @@ void delete_from_swap_cache(struct folio *folio);
 void clear_shadow_from_swap_cache(int type, unsigned long begin,
 				  unsigned long end);
 struct folio *swap_cache_get_folio(swp_entry_t entry,
-		struct vm_area_struct *vma, unsigned long addr);
+		struct vm_area_struct *vma, unsigned long addr,
+		void **shadowp);
 struct folio *filemap_get_incore_folio(struct address_space *mapping,
 		pgoff_t index);
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index f6f1e6f5d782..21badd4f0fc7 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -335,12 +335,18 @@ static inline bool swap_use_vma_readahead(void)
  * Caller must lock the swap device or hold a reference to keep it valid.
  */
 struct folio *swap_cache_get_folio(swp_entry_t entry,
-		struct vm_area_struct *vma, unsigned long addr)
+		struct vm_area_struct *vma, unsigned long addr, void **shadowp)
 {
 	struct folio *folio;
 
-	folio = filemap_get_folio(swap_address_space(entry), swp_offset(entry));
-	if (!IS_ERR(folio)) {
+	folio = filemap_get_entry(swap_address_space(entry), swp_offset(entry));
+	if (xa_is_value(folio)) {
+		if (shadowp)
+			*shadowp = folio;
+		return NULL;
+	}
+
+	if (folio) {
 		bool vma_ra = swap_use_vma_readahead();
 		bool readahead;
 
@@ -370,8 +376,6 @@ struct folio *swap_cache_get_folio(swp_entry_t entry,
 			if (!vma || !vma_ra)
 				atomic_inc(&swapin_readahead_hits);
 		}
-	} else {
-		folio = NULL;
 	}
 
 	return folio;
@@ -876,11 +880,10 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
  * in.
  */
 static struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
-				  struct vm_fault *vmf)
+				  struct vm_fault *vmf, void *shadow)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct folio *folio;
-	void *shadow = NULL;
 
 	/* skip swapcache */
 	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
@@ -897,7 +900,6 @@ static struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
 
 		mem_cgroup_swapin_uncharge_swap(entry);
 
-		shadow = get_shadow_from_swap_cache(entry);
 		if (shadow)
 			workingset_refault(folio, shadow);
 
@@ -931,17 +933,18 @@ struct folio *swapin_entry(swp_entry_t entry, gfp_t gfp_mask,
 {
 	enum swap_cache_result cache_result;
 	struct mempolicy *mpol;
+	void *shadow = NULL;
 	struct folio *folio;
 	pgoff_t ilx;
 
-	folio = swap_cache_get_folio(entry, vmf->vma, vmf->address);
+	folio = swap_cache_get_folio(entry, vmf->vma, vmf->address, &shadow);
 	if (folio) {
 		cache_result = SWAP_CACHE_HIT;
 		goto done;
 	}
 
 	if (swap_use_no_readahead(swp_swap_info(entry), entry)) {
-		folio = swapin_direct(entry, gfp_mask, vmf);
+		folio = swapin_direct(entry, gfp_mask, vmf, shadow);
 		cache_result = SWAP_CACHE_BYPASS;
 	} else {
 		mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
@@ -952,7 +955,6 @@ struct folio *swapin_entry(swp_entry_t entry, gfp_t gfp_mask,
 		mpol_cond_put(mpol);
 		cache_result = SWAP_CACHE_MISS;
 	}
-
 done:
 	if (result)
 		*result = cache_result;
-- 
2.43.0


