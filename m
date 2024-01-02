Return-Path: <linux-kernel+bounces-14686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D0A8220AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C87C281690
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFE6171B6;
	Tue,  2 Jan 2024 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhLgzUK5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAF5168DD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 17:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d43df785c2so21399785ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 09:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704218060; x=1704822860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Plx2aGPJbBehNqIW4p1L+Cff2qlR20r6A012vbacRHU=;
        b=hhLgzUK5N8rK40R24rPF0X3w4oIb+1Sk+wiRsDI2sJRpZ5Yn5/Mj8E/8x5WrVDBAYX
         PIokK0Eu0TfIUZiImYkD59cp0fxx5UPvwzxaA1BGkL/0i9uQ9qYWh4/mlL4AP8XIZ4d1
         4vNAETOQuO1Gk8X3Eyzf1Z2CXs2BCpQ4mbfKHUK5aynVLziY4xKEa2fuq6gtl3R5j1K2
         L2skehtg0qqvtx2AoRkHsQ+JTGzwuFNiKgo4ux6PDEUruK7cRTDPL+1pzN3EneGh+cbc
         DFVOcOe0ubqQoWI3iqCs30s9/kOAgrGLkuLY7J9js9bBj6NpWJBZeWYU7g0pXak6wXTX
         O+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704218060; x=1704822860;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Plx2aGPJbBehNqIW4p1L+Cff2qlR20r6A012vbacRHU=;
        b=DL7mJTHUO3hjxhPtsYH6XJyOqNhK3xz7yHlAB/rpq17tr213DCAFOcD3xtKiQb12FA
         I7GkJeNUweA/XsScx1bI1cdyiXCHjeTFc1Ee3GQ1Svycpwpxo4Vx/yDWQpCFejuBOnLa
         QY+ontag6U+Mf88VR53uM2AirExjzDqI+RmrlFzvaRvqWNXHqA0GOXrfXgPiMDl6qCtC
         pgHYRlv0SyByM8gHfZY7HCWG/3ePsHHiMeZmL8nk2Pqw3ieX2jz+drvjYN5hI8oTnAtR
         CG7X1LvnV2VOs4BtnsBK3Z3TAnMLLMgOAkQSW+iKSP/wMeibEhqJnQYnxV50r9ZzY25q
         JN8w==
X-Gm-Message-State: AOJu0Yx69j7pSImom8TkkvySoqT0f9EGD5/RPjBrqB+2Vtu+FGNtxs7R
	wwOY1cuH7l/wFErZ3X41MEU=
X-Google-Smtp-Source: AGHT+IGr1fEmKCpFGmKewU8/hVrmqMb8AM0dTCE+QEyY4/Rq+9azV/ZjBTyHv60Nu5X7VVBSfSChoA==
X-Received: by 2002:a17:903:110d:b0:1d4:cc31:71e with SMTP id n13-20020a170903110d00b001d4cc31071emr483019plh.67.1704218060519;
        Tue, 02 Jan 2024 09:54:20 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.41.9])
        by smtp.gmail.com with ESMTPSA id be10-20020a170902aa0a00b001d3c3d486bfsm22151969plb.163.2024.01.02.09.54.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Jan 2024 09:54:19 -0800 (PST)
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
Subject: [PATCH v2 8/9] mm/swap: introduce a helper for swapin without vmfault
Date: Wed,  3 Jan 2024 01:53:37 +0800
Message-ID: <20240102175338.62012-9-ryncsn@gmail.com>
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

There are two places where swapin is not caused by direct anon page fault:
- shmem swapin, invoked indirectly through shmem mapping
- swapoff

They used to construct a pseudo vmfault struct for swapin function.
Shmem has dropped the pseudo vmfault recently in commit ddc1a5cbc05d
("mempolicy: alloc_pages_mpol() for NUMA policy without vma"). Swapoff
path is still using one.

Introduce a helper for them both, this help save stack usage for swapoff
path, and help apply a unified swapin cache and readahead policy check.

Due to missing vmfault info, the caller have to pass in mempolicy
explicitly, make it different from swapin_entry and name it
swapin_entry_mpol.

This commit convert swapoff to use this helper, follow-up commits will
convert shmem to use it too.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap.h       |  9 +++++++++
 mm/swap_state.c | 40 ++++++++++++++++++++++++++++++++--------
 mm/swapfile.c   | 15 ++++++---------
 3 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index 9180411afcfe..8f790a67b948 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -73,6 +73,9 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 		struct mempolicy *mpol, pgoff_t ilx);
 struct folio *swapin_entry(swp_entry_t entry, gfp_t flag,
 			    struct vm_fault *vmf, enum swap_cache_result *result);
+struct folio *swapin_entry_mpol(swp_entry_t entry, gfp_t gfp_mask,
+				struct mempolicy *mpol, pgoff_t ilx,
+				enum swap_cache_result *result);
 
 static inline unsigned int folio_swap_flags(struct folio *folio)
 {
@@ -109,6 +112,12 @@ static inline struct folio *swapin_entry(swp_entry_t swp, gfp_t gfp_mask,
 	return NULL;
 }
 
+static inline struct page *swapin_entry_mpol(swp_entry_t entry, gfp_t gfp_mask,
+		struct mempolicy *mpol, pgoff_t ilx, enum swap_cache_result *result)
+{
+	return NULL;
+}
+
 static inline int swap_writepage(struct page *p, struct writeback_control *wbc)
 {
 	return 0;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 21badd4f0fc7..3edf4b63158d 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -880,14 +880,13 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
  * in.
  */
 static struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
-				  struct vm_fault *vmf, void *shadow)
+				   struct mempolicy *mpol, pgoff_t ilx,
+				   void *shadow)
 {
-	struct vm_area_struct *vma = vmf->vma;
 	struct folio *folio;
 
-	/* skip swapcache */
-	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
-				vma, vmf->address, false);
+	folio = (struct folio *)alloc_pages_mpol(gfp_mask, 0,
+			mpol, ilx, numa_node_id());
 	if (folio) {
 		if (mem_cgroup_swapin_charge_folio(folio, NULL,
 						   GFP_KERNEL, entry)) {
@@ -943,18 +942,18 @@ struct folio *swapin_entry(swp_entry_t entry, gfp_t gfp_mask,
 		goto done;
 	}
 
+	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
 	if (swap_use_no_readahead(swp_swap_info(entry), entry)) {
-		folio = swapin_direct(entry, gfp_mask, vmf, shadow);
+		folio = swapin_direct(entry, gfp_mask, mpol, ilx, shadow);
 		cache_result = SWAP_CACHE_BYPASS;
 	} else {
-		mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
 		if (swap_use_vma_readahead())
 			folio = swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf);
 		else
 			folio = swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
-		mpol_cond_put(mpol);
 		cache_result = SWAP_CACHE_MISS;
 	}
+	mpol_cond_put(mpol);
 done:
 	if (result)
 		*result = cache_result;
@@ -962,6 +961,31 @@ struct folio *swapin_entry(swp_entry_t entry, gfp_t gfp_mask,
 	return folio;
 }
 
+struct folio *swapin_entry_mpol(swp_entry_t entry, gfp_t gfp_mask,
+				struct mempolicy *mpol, pgoff_t ilx,
+				enum swap_cache_result *result)
+{
+	enum swap_cache_result cache_result;
+	void *shadow = NULL;
+	struct folio *folio;
+
+	folio = swap_cache_get_folio(entry, NULL, 0, &shadow);
+	if (folio) {
+		cache_result = SWAP_CACHE_HIT;
+	} else if (swap_use_no_readahead(swp_swap_info(entry), entry)) {
+		folio = swapin_direct(entry, gfp_mask, mpol, ilx, shadow);
+		cache_result = SWAP_CACHE_BYPASS;
+	} else {
+		folio = swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
+		cache_result = SWAP_CACHE_MISS;
+	}
+
+	if (result)
+		*result = cache_result;
+
+	return folio;
+}
+
 #ifdef CONFIG_SYSFS
 static ssize_t vma_ra_enabled_show(struct kobject *kobj,
 				     struct kobj_attribute *attr, char *buf)
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5aa44de11edc..2f77bf143af8 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1840,18 +1840,13 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 	do {
 		struct folio *folio;
 		unsigned long offset;
+		struct mempolicy *mpol;
 		unsigned char swp_count;
 		swp_entry_t entry;
+		pgoff_t ilx;
 		int ret;
 		pte_t ptent;
 
-		struct vm_fault vmf = {
-			.vma = vma,
-			.address = addr,
-			.real_address = addr,
-			.pmd = pmd,
-		};
-
 		if (!pte++) {
 			pte = pte_offset_map(pmd, addr);
 			if (!pte)
@@ -1871,8 +1866,10 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		pte_unmap(pte);
 		pte = NULL;
 
-		folio = swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
-				     &vmf, NULL);
+		mpol = get_vma_policy(vma, addr, 0, &ilx);
+		folio = swapin_entry_mpol(entry, GFP_HIGHUSER_MOVABLE,
+					  mpol, ilx, NULL);
+		mpol_cond_put(mpol);
 		if (!folio) {
 			/*
 			 * The entry could have been freed, and will not
-- 
2.43.0


