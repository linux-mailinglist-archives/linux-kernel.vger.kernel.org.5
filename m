Return-Path: <linux-kernel+bounces-12049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B773681EF62
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89CA1C2190D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FA546B9F;
	Wed, 27 Dec 2023 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LAZDqFIo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E70346537
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbdb759e73bso3008747276.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 06:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703686349; x=1704291149; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u5ETftbMUjWlEUP4x6SdTstUpWGRICTXI383f0d5fPw=;
        b=LAZDqFIoTgTEuXy/M4jSzffsUz8RmT48XWB9OoqXbxgz7a5RCtqILJf/j1CtYVBXRI
         38ktq+h0mhUtf7yeyjH1gZUXv72yaDjAtxGh2P/mzf6E/8PkvzfmSh6RH+OKwKo7RhDi
         O5mLo7yxrD1GFpRtVV+pD8CWJ4TsGlKHMIFyOxH4xZMUKCG4NQHJCR+IdV/m0pi6tDqI
         /nnEZcULu/I45NoFvD8oOexvZlVIH9lMLhdGxX7Nup5mZVbc9Cr0n49DhIfghu/AhrE6
         Cu0GUcKu/8lOscN6XjYXU5RsPmmoiJ1mRfUAI6exYzsC9VM9SJiFEbbeXuzxwM+Fyj8s
         ff3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703686349; x=1704291149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u5ETftbMUjWlEUP4x6SdTstUpWGRICTXI383f0d5fPw=;
        b=UM8an1nPGLz/Ue+ufEGY1P149qqj1r0x0jPJYBtsQOlmYy6uKai5iqo93qWvYGffLj
         ukbrRr95Kl3/gQmWJjXLzlmm78V9t7mVMMQl5W8O07SwiTyKJurF2oVFwjDonlYGZq+e
         VuUMnfhKw7E+TMNW2OyXYO3zmbpnun5HUHtz1zHaXylb13H8PTnTgBpchLYrGVkzyxB+
         WEPqZJdIs8oFNhBr1WHivDx/JLFToNoHJj+zB4MV/MFem24B+Jg2fg+sFK1S+33yBWJT
         uTDjRDIIbnZqCvDh2wyFwUEqDYAP+rRhefcK36HCu4w+XDwIv3JS7ui4lj+mOR+4eZwp
         LWng==
X-Gm-Message-State: AOJu0YyKoFb3V26sdiIFbtkVTPEmJZz6Ky058eV3x651K318nNm4sVJc
	JbQxVb4pUIsbud6WY1FAq5IA6+2ot7WNcbM3IsRZ
X-Google-Smtp-Source: AGHT+IG4TVQVz9pYKoW6/4jbetbXyoxv4tRc+NncI08vkMWiESYUyELwwxGLPz9ege//RBvBnaW8Z8MFC5w5kw==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a25:8392:0:b0:dbc:d008:4221 with SMTP id
 t18-20020a258392000000b00dbcd0084221mr148641ybk.13.1703686349634; Wed, 27 Dec
 2023 06:12:29 -0800 (PST)
Date: Wed, 27 Dec 2023 14:12:05 +0000
In-Reply-To: <20231227141205.2200125-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231227141205.2200125-1-kinseyho@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231227141205.2200125-6-kinseyho@google.com>
Subject: [PATCH mm-unstable v4 5/5] mm/mglru: remove CONFIG_TRANSPARENT_HUGEPAGE
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Donet Tom <donettom@linux.vnet.ibm.com>, 
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

Improve code readability by removing CONFIG_TRANSPARENT_HUGEPAGE,
since the compiler should be able to automatically optimize out the
code that promotes THPs during page table walks.

No functional changes.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
Co-developed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Tested-by: Donet Tom <donettom@linux.vnet.ibm.com>
Acked-by: Yu Zhao <yuzhao@google.com>
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


