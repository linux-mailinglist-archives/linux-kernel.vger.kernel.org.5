Return-Path: <linux-kernel+bounces-6345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A7B81977A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2694D1C25049
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D09156F2;
	Wed, 20 Dec 2023 04:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VQARkHFT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A1413ACF
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbccc6dfa6cso453550276.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703044870; x=1703649670; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mFAbLGESrfkdyY7V53iLSJc53insEPkBL2A8CkUV1gg=;
        b=VQARkHFTbBsbnkb47yfQjmXLWmQuIZYPhGXzKpMpuNzEvbD6Kpuxd56H0XRbjNxJti
         l2EEL5qoe8YV0cyWWy3jo3gBQMtSsMJ/ykltKHbomgHRdZOA6o+pEL4NlgPJw0gDmu8r
         3RtzYavOLYVLGfaimgxmrjOcpQaxuLZdi37O09ct1p1bEjHziu/juSBwoZRc8KDZCNie
         n44iAVPmIxhQzm76F4uWDrTL0MRnTgQaPhM/pFkWwxAlcCi+MZ39Lx7CzrDvPfaspHRC
         gbppTldhOfjG7sK/dwKgPIdBomB4ZUuMaogXszFzqNrlkYqblp9SDbLXTwGEmxT0zebo
         k5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044870; x=1703649670;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFAbLGESrfkdyY7V53iLSJc53insEPkBL2A8CkUV1gg=;
        b=h0ugH6aaFnkIe52fYQ5FwS1hSBG3FLV+PKlgd1pbEK569tqBVf4vvEb7a/QAm9NJxM
         Fl1FtLjqpYVnpXflMSGZKfbiQDAqdDWRrI+kLbeiIYCfsn681RqOeXeFGeSOB9L6zn1w
         ymKi4CQddpTYcSulpmptL6NeGpdjzHOibx7kTZkL7dZk6R37cHCtlFIe06O5WJN6e8/+
         UiYTFUNEXEv9dc6TakqZfIsTh0JS5ByPEYS8lGa050gQlnURu/tB/nltr3P3YUrbaKjF
         svUAZ3Y2Xkko19bIu/klcpqoBIKwIky4AXXBmsargOPfpMFwvFYMG8ga4wb/ERjQX6FF
         28cQ==
X-Gm-Message-State: AOJu0YzJKGyuxmqbK9Z0s+EygTWZ8fUgYSLqVV3Slf1kbmZt8pHtdNUn
	nsuvamcs0zdHknn4JVOL/ZEJZHoZ9+7NhO4COFJc
X-Google-Smtp-Source: AGHT+IGaDC//lyvGNfxrOfl71GqjAJnN0O1AMKxPax7egJ+VFiYrP0YYjLjybkdI1yYMwENCU3j735v6kB+jYg==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a05:6902:27c5:b0:dbc:c5f8:ae16 with SMTP
 id ec5-20020a05690227c500b00dbcc5f8ae16mr806580ybb.5.1703044870249; Tue, 19
 Dec 2023 20:01:10 -0800 (PST)
Date: Wed, 20 Dec 2023 04:00:37 +0000
In-Reply-To: <20231220040037.883811-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231220040037.883811-1-kinseyho@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220040037.883811-5-kinseyho@google.com>
Subject: [PATCH mm-unstable v1 4/4] mm/mglru: remove CONFIG_TRANSPARENT_HUGEPAGE
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, yuzhao@google.com, 
	Kinsey Ho <kinseyho@google.com>, Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Improve code readability by removing CONFIG_TRANSPARENT_HUGEPAGE,
since the compiler should be able to automatically optimize out the
code that promotes THPs during page table walks.

No functional changes.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
Co-developed-by: Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
---
 mm/vmscan.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 351a0b5043c0..ceba905e5630 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3273,7 +3273,6 @@ static unsigned long get_pte_pfn(pte_t pte, struct vm_area_struct *vma, unsigned
 	return pfn;
 }
 
-#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
 static unsigned long get_pmd_pfn(pmd_t pmd, struct vm_area_struct *vma, unsigned long addr)
 {
 	unsigned long pfn = pmd_pfn(pmd);
@@ -3291,7 +3290,6 @@ static unsigned long get_pmd_pfn(pmd_t pmd, struct vm_area_struct *vma, unsigned
 
 	return pfn;
 }
-#endif
 
 static struct folio *get_pfn_folio(unsigned long pfn, struct mem_cgroup *memcg,
 				   struct pglist_data *pgdat, bool can_swap)
@@ -3394,7 +3392,6 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 	return suitable_to_scan(total, young);
 }
 
-#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
 static void walk_pmd_range_locked(pud_t *pud, unsigned long addr, struct vm_area_struct *vma,
 				  struct mm_walk *args, unsigned long *bitmap, unsigned long *first)
 {
@@ -3472,12 +3469,6 @@ static void walk_pmd_range_locked(pud_t *pud, unsigned long addr, struct vm_area
 done:
 	*first = -1;
 }
-#else
-static void walk_pmd_range_locked(pud_t *pud, unsigned long addr, struct vm_area_struct *vma,
-				  struct mm_walk *args, unsigned long *bitmap, unsigned long *first)
-{
-}
-#endif
 
 static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 			   struct mm_walk *args)
@@ -3513,7 +3504,6 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 			continue;
 		}
 
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 		if (pmd_trans_huge(val)) {
 			unsigned long pfn = pmd_pfn(val);
 			struct pglist_data *pgdat = lruvec_pgdat(walk->lruvec);
@@ -3532,7 +3522,7 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 			walk_pmd_range_locked(pud, addr, vma, args, bitmap, &first);
 			continue;
 		}
-#endif
+
 		walk->mm_stats[MM_NONLEAF_TOTAL]++;
 
 		if (should_clear_pmd_young()) {
-- 
2.43.0.472.g3155946c3a-goog


