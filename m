Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFA3786E14
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbjHXLgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241166AbjHXLgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:36:33 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F3E1FD8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:36:02 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-26f9521de4cso1726172a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692876961; x=1693481761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F6ppMC27jC5/97XtY+LPAAYgejWVCICqeBOmzOSX+qU=;
        b=G8oi7VDU+awttb/a+wbj78hIbEJrYiR9A6DeUMd0Szx4K7SbLf8qmbab1BRYQnkIrw
         h5dSFPjlex2na3H7LK2wdst9HuoEs1B5mlSZmwdC4tZlW4TLfKh7ifnjqm7ufdIq7sPV
         WcRYbH6f01SmF9REQ3y08VzIFQOCK5Nc0o+sIq1Agzs4VeeR7+3bN9ipTTJ2Muc0HIi8
         uwa5MBU28XllhSV+BgL0xUH4Sc3AEP+xnIOmam8k4HTIJY78eGFcHVEGYGjrQeWz6KJh
         FpSFY6WeK8qy7SO1CFATaxy+9Q0DxIwC+c6/fC/Jioy9YNiLl4dU27r0t303nPJmr+gE
         qK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692876961; x=1693481761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F6ppMC27jC5/97XtY+LPAAYgejWVCICqeBOmzOSX+qU=;
        b=Q8LlzMOIFXbfx2phZtn8ZMi7IMW6l+jdP1YB6Hc8wXJK0Hx6L3cWi+YInY6JfvJYtG
         mxqAQcKaUWumpkc+ZikYbD5sgvhdF6iTDgItNpws0yBRnxHArtdVx1xsicI8UwKBVD+X
         ZhxdXNpCi+jbKjvnLFOvvdLlEXtm/ZS56p0b6pb941PjfAdfGpVRpbZEIAPRZGKtF7fy
         MDmh5gwCkBnFH9zKsldCyPB4bfDzkbdnccsdXrfeqCSY1NBGM0b+rF4wHiP5jeoQqLTU
         aDyfbQegZnCyHKfbLwwwFsoaq8YQFE6OE8dMw+gHXhZKUjpD3xMHRUdCNfjDCYqty+en
         QAUA==
X-Gm-Message-State: AOJu0YwQyeQXlLltYYqxx/n+l8pjLSMawDK8UDSK79sSj421nW30F85y
        jeaMB2JtMV8Y45iMLFIUfWo=
X-Google-Smtp-Source: AGHT+IG1cFdB08iSSOiFfXjVuG0FBeFvKxOsSN8w3zTAmFSnn81tC1eCmxKYJVj3zhhTNFPCmuCJ6A==
X-Received: by 2002:a17:90b:1911:b0:26d:2b42:cdae with SMTP id mp17-20020a17090b191100b0026d2b42cdaemr11146587pjb.3.1692876961196;
        Thu, 24 Aug 2023 04:36:01 -0700 (PDT)
Received: from VERNHAO-MC1.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id m6-20020a17090a34c600b00263b4b1255esm1479189pjf.51.2023.08.24.04.35.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Aug 2023 04:36:00 -0700 (PDT)
From:   Xin Hao <haoxing990@gmail.com>
X-Google-Original-From: Xin Hao <haoxing990gmail.com>
To:     yuzhao@google.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, haoxing990@gmail.com,
        Vern Hao <vernhao@tencent.com>
Subject: [PATCH] mm: multi-gen LRU: Optimize some duplicate codes
Date:   Thu, 24 Aug 2023 19:35:38 +0800
Message-ID: <20230824113538.5160-1-user@VERNHAO-MC1>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vern Hao <vernhao@tencent.com>

In lru_gen_look_around() and walk_pte_range(), there are too many
similarities between them, so there add a common function
lru_gen_folio_status_check() to simplify these part of duplicate codes.

Signed-off-by: Vern Hao <vernhao@tencent.com>
---
 mm/vmscan.c | 125 ++++++++++++++++++++++++----------------------------
 1 file changed, 57 insertions(+), 68 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6f13394b112e..2b5d61eeb039 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4000,6 +4000,52 @@ static bool suitable_to_scan(int total, int young)
 	return young * n >= total;
 }
 
+static bool lru_gen_folio_status_check(pte_t *pte, struct vm_area_struct *vma,
+				       struct pglist_data *pgdat,
+				       unsigned long addr, int new_gen, int *old_count,
+				       struct lru_gen_mm_walk *walk, struct mem_cgroup *memcg)
+{
+	struct folio *folio;
+	int old_gen;
+	unsigned long pfn;
+	pte_t ptent = ptep_get(pte);
+
+	pfn = get_pte_pfn(ptent, vma, addr);
+	if (pfn == -1)
+		return false;
+
+	if (!pte_young(ptent)) {
+		(*old_count)++;
+		return false;
+	}
+
+	folio = get_pfn_folio(pfn, memcg, pgdat, !walk || walk->can_swap);
+	if (!folio)
+		return false;
+
+	if (!ptep_test_and_clear_young(vma, addr, pte))
+		VM_WARN_ON_ONCE(true);
+
+	if (pte_dirty(ptent) && !folio_test_dirty(folio) &&
+	    !(folio_test_anon(folio) && folio_test_swapbacked(folio) &&
+	      !folio_test_swapcache(folio)))
+		folio_mark_dirty(folio);
+
+	if (walk) {
+		old_gen = folio_update_gen(folio, new_gen);
+		if (old_gen >= 0 && old_gen != new_gen)
+			update_batch_size(walk, folio, old_gen, new_gen);
+		return true;
+	} else {
+		old_gen = folio_lru_gen(folio);
+		if (old_gen < 0)
+			folio_set_referenced(folio);
+		else if (old_gen != new_gen)
+			folio_activate(folio);
+	}
+	return false;
+}
+
 static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 			   struct mm_walk *args)
 {
@@ -4012,7 +4058,8 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 	struct lru_gen_mm_walk *walk = args->private;
 	struct mem_cgroup *memcg = lruvec_memcg(walk->lruvec);
 	struct pglist_data *pgdat = lruvec_pgdat(walk->lruvec);
-	int old_gen, new_gen = lru_gen_from_seq(walk->max_seq);
+	int new_gen = lru_gen_from_seq(walk->max_seq);
+	int old_count = 0;
 
 	pte = pte_offset_map_nolock(args->mm, pmd, start & PMD_MASK, &ptl);
 	if (!pte)
@@ -4025,41 +4072,15 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 	arch_enter_lazy_mmu_mode();
 restart:
 	for (i = pte_index(start), addr = start; addr != end; i++, addr += PAGE_SIZE) {
-		unsigned long pfn;
-		struct folio *folio;
-		pte_t ptent = ptep_get(pte + i);
-
 		total++;
-		walk->mm_stats[MM_LEAF_TOTAL]++;
-
-		pfn = get_pte_pfn(ptent, args->vma, addr);
-		if (pfn == -1)
-			continue;
-
-		if (!pte_young(ptent)) {
-			walk->mm_stats[MM_LEAF_OLD]++;
-			continue;
-		}
-
-		folio = get_pfn_folio(pfn, memcg, pgdat, walk->can_swap);
-		if (!folio)
+		if (!lru_gen_folio_status_check(pte + i, args->vma, pgdat,
+						addr, new_gen, &old_count, walk, memcg))
 			continue;
-
-		if (!ptep_test_and_clear_young(args->vma, addr, pte + i))
-			VM_WARN_ON_ONCE(true);
-
 		young++;
-		walk->mm_stats[MM_LEAF_YOUNG]++;
-
-		if (pte_dirty(ptent) && !folio_test_dirty(folio) &&
-		    !(folio_test_anon(folio) && folio_test_swapbacked(folio) &&
-		      !folio_test_swapcache(folio)))
-			folio_mark_dirty(folio);
-
-		old_gen = folio_update_gen(folio, new_gen);
-		if (old_gen >= 0 && old_gen != new_gen)
-			update_batch_size(walk, folio, old_gen, new_gen);
 	}
+	walk->mm_stats[MM_LEAF_TOTAL] += total;
+	walk->mm_stats[MM_LEAF_YOUNG] += young;
+	walk->mm_stats[MM_LEAF_OLD] += old_count;
 
 	if (i < PTRS_PER_PTE && get_next_vma(PMD_MASK, PAGE_SIZE, args, &start, &end))
 		goto restart;
@@ -4662,7 +4683,8 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	struct pglist_data *pgdat = folio_pgdat(folio);
 	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
 	DEFINE_MAX_SEQ(lruvec);
-	int old_gen, new_gen = lru_gen_from_seq(max_seq);
+	int new_gen = lru_gen_from_seq(max_seq);
+	int old_count = 0;
 
 	lockdep_assert_held(pvmw->ptl);
 	VM_WARN_ON_ONCE_FOLIO(folio_test_lru(folio), folio);
@@ -4696,43 +4718,10 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	pte -= (addr - start) / PAGE_SIZE;
 
 	for (i = 0, addr = start; addr != end; i++, addr += PAGE_SIZE) {
-		unsigned long pfn;
-		pte_t ptent = ptep_get(pte + i);
-
-		pfn = get_pte_pfn(ptent, pvmw->vma, addr);
-		if (pfn == -1)
-			continue;
-
-		if (!pte_young(ptent))
+		if (!lru_gen_folio_status_check(pte + i, pvmw->vma, pgdat,
+						addr, new_gen, &old_count, walk, memcg))
 			continue;
-
-		folio = get_pfn_folio(pfn, memcg, pgdat, can_swap);
-		if (!folio)
-			continue;
-
-		if (!ptep_test_and_clear_young(pvmw->vma, addr, pte + i))
-			VM_WARN_ON_ONCE(true);
-
 		young++;
-
-		if (pte_dirty(ptent) && !folio_test_dirty(folio) &&
-		    !(folio_test_anon(folio) && folio_test_swapbacked(folio) &&
-		      !folio_test_swapcache(folio)))
-			folio_mark_dirty(folio);
-
-		if (walk) {
-			old_gen = folio_update_gen(folio, new_gen);
-			if (old_gen >= 0 && old_gen != new_gen)
-				update_batch_size(walk, folio, old_gen, new_gen);
-
-			continue;
-		}
-
-		old_gen = folio_lru_gen(folio);
-		if (old_gen < 0)
-			folio_set_referenced(folio);
-		else if (old_gen != new_gen)
-			folio_activate(folio);
 	}
 
 	arch_leave_lazy_mmu_mode();
-- 
2.41.0

