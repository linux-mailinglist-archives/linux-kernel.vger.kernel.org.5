Return-Path: <linux-kernel+bounces-14679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC4A8220A3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049C21C226FD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C830115ACC;
	Tue,  2 Jan 2024 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bs8e7giB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA691156F2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 17:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3ed1ca402so74374295ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 09:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704218039; x=1704822839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=leW6kIEfUqfY3XAn3Ki1C0WiRu5w1qcwcxw36bp08sM=;
        b=Bs8e7giBNFdIlK96P/kY8T+cQiDyWdvX4fKTHaGdmsv47LTdkbimnxN3oWiEjYHuUb
         LA9QgtEFD5f4Gng/cmSPbU3JE8QcHwGriH/tPKFwVGPVndBU09pOKNmnjrK6TcsqQPeh
         u4PiSoZaGfA/gSAZ/ggTplvWzIrnh1dvw2IVyQWsXKmXw6gKoPh9l4VumEDeRhQ9cAD8
         1BbedW+Wod1IkoRI1cMZrc60wqmcYOxMUx8TwW93eeHunEk/G2mJVEAq4YH2KAMas9qH
         g6XqevoEpkr017dwjD2sN80aAUmXNKylaXWMxBecKEBp7QKRLtiomak+1cHK/h+7OH9x
         nW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704218039; x=1704822839;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=leW6kIEfUqfY3XAn3Ki1C0WiRu5w1qcwcxw36bp08sM=;
        b=PiaRkpV3iCRw+IzV+KMXmpKHXwG1MnA/JvcmY8cfeWLWkAaKHZNn8mvh6Ll2K5FC6I
         7hh2CI5SibhxrLF8752vtK8+iyDpvzmwi2p+Ak2QLmRfHyZLn6gFxOpnOLKKHTpty7tL
         5ETaKiyVE6gdeEBwOkxE7CFgFoEBBXRqO5ekTkHIamN3feXrTFu1cqH99WxkCbdqlT3t
         eAaHPG6y+seT7R67YvbZxeVWywqHcE/rzfgIoKBMN8KBZ8kMaB1aU3fIyzO2RSwFOmz9
         N+mivCB28gbzY40WlNfPtHlfxFJN6I0C6mUL+fckZ37uUYx8sKkg9xPbCOi4uNT3J+g8
         iKzw==
X-Gm-Message-State: AOJu0YylTc3SSjIs2xsqHMA40ocFLM9S1eMbt8AqW1QAuJflplR0Y4J6
	v2zohy6y9R+cJq0cC9YPHhM=
X-Google-Smtp-Source: AGHT+IHbiz8m7h29JKdOV+VIY3InvdMjldzD40RepmLTENYklXxpKThd4lbQBZ1H/dFstp+Ax17T1A==
X-Received: by 2002:a17:902:a585:b0:1d0:6ffe:a28 with SMTP id az5-20020a170902a58500b001d06ffe0a28mr17151404plb.134.1704218039237;
        Tue, 02 Jan 2024 09:53:59 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.41.9])
        by smtp.gmail.com with ESMTPSA id be10-20020a170902aa0a00b001d3c3d486bfsm22151969plb.163.2024.01.02.09.53.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Jan 2024 09:53:58 -0800 (PST)
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
Subject: [PATCH v2 2/9] mm/swap: move no readahead swapin code to a stand-alone helper
Date: Wed,  3 Jan 2024 01:53:31 +0800
Message-ID: <20240102175338.62012-3-ryncsn@gmail.com>
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

No feature change, simply move the routine to a standalone function to
be re-used later. The error path handling is copied from the "out_page"
label, to make the code change minimized for easier reviewing.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c     | 32 ++++----------------------------
 mm/swap.h       |  8 ++++++++
 mm/swap_state.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 28 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index a0a50d3754f0..0165c8cad489 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3803,7 +3803,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	swp_entry_t entry;
 	pte_t pte;
 	vm_fault_t ret = 0;
-	void *shadow = NULL;
 
 	if (!pte_unmap_same(vmf))
 		goto out;
@@ -3867,33 +3866,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!folio) {
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
 		    __swap_count(entry) == 1) {
-			/* skip swapcache */
-			folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
-						vma, vmf->address, false);
-			page = &folio->page;
-			if (folio) {
-				__folio_set_locked(folio);
-				__folio_set_swapbacked(folio);
-
-				if (mem_cgroup_swapin_charge_folio(folio,
-							vma->vm_mm, GFP_KERNEL,
-							entry)) {
-					ret = VM_FAULT_OOM;
-					goto out_page;
-				}
-				mem_cgroup_swapin_uncharge_swap(entry);
-
-				shadow = get_shadow_from_swap_cache(entry);
-				if (shadow)
-					workingset_refault(folio, shadow);
-
-				folio_add_lru(folio);
-
-				/* To provide entry to swap_read_folio() */
-				folio->swap = entry;
-				swap_read_folio(folio, true, NULL);
-				folio->private = NULL;
-			}
+			/* skip swapcache and readahead */
+			folio = swapin_direct(entry, GFP_HIGHUSER_MOVABLE, vmf);
+			if (folio)
+				page = &folio->page;
 		} else {
 			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
 						vmf);
diff --git a/mm/swap.h b/mm/swap.h
index 758c46ca671e..83eab7b67e77 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -56,6 +56,8 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 		struct mempolicy *mpol, pgoff_t ilx);
 struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
 			      struct vm_fault *vmf);
+struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
+			    struct vm_fault *vmf);
 
 static inline unsigned int folio_swap_flags(struct folio *folio)
 {
@@ -86,6 +88,12 @@ static inline struct folio *swap_cluster_readahead(swp_entry_t entry,
 	return NULL;
 }
 
+struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
+			struct vm_fault *vmf)
+{
+	return NULL;
+}
+
 static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
 			struct vm_fault *vmf)
 {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index e671266ad772..24cb93ed5081 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -861,6 +861,53 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 	return folio;
 }
 
+/**
+ * swapin_direct - swap in folios skipping swap cache and readahead
+ * @entry: swap entry of this memory
+ * @gfp_mask: memory allocation flags
+ * @vmf: fault information
+ *
+ * Returns the struct folio for entry and addr after the swap entry is read
+ * in.
+ */
+struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
+			    struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct folio *folio;
+	void *shadow = NULL;
+
+	/* skip swapcache */
+	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
+				vma, vmf->address, false);
+	if (folio) {
+		__folio_set_locked(folio);
+		__folio_set_swapbacked(folio);
+
+		if (mem_cgroup_swapin_charge_folio(folio,
+					vma->vm_mm, GFP_KERNEL,
+					entry)) {
+			folio_unlock(folio);
+			folio_put(folio);
+			return NULL;
+		}
+		mem_cgroup_swapin_uncharge_swap(entry);
+
+		shadow = get_shadow_from_swap_cache(entry);
+		if (shadow)
+			workingset_refault(folio, shadow);
+
+		folio_add_lru(folio);
+
+		/* To provide entry to swap_read_folio() */
+		folio->swap = entry;
+		swap_read_folio(folio, true, NULL);
+		folio->private = NULL;
+	}
+
+	return folio;
+}
+
 /**
  * swapin_readahead - swap in pages in hope we need them soon
  * @entry: swap entry of this memory
-- 
2.43.0


