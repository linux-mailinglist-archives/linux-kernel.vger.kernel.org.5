Return-Path: <linux-kernel+bounces-85926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB5A86BCE1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45F8B2886AA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E352D602;
	Thu, 29 Feb 2024 00:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RC5/IaQu"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7BE2D046
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167115; cv=none; b=sAOmoTu8MJ/2WMHC2XEYBvCvbcvpEyF27U/6uy9uoUZx+Jq6hQxzOJSyHJ5O/MlbsglhPPZnCiM83UZAN3dY8ggf4hYfJ0ZyAm3VljgVqCR719wBGjKe+WQ4k4hAMCV7G7zTQpnwEDsPfGYKEWCC6eBqwUl2VbjQmJ2EW/h0zrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167115; c=relaxed/simple;
	bh=/Yg0m5FhDLeTCyY/71+4EpOmP5M47bIj1XRXEAIbbXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gGwKcxiX7a8Y9nkvFeF8kz5cyRg0iaxHq6SaiDTLruSV+/aZbNgcgWe4laqbF0skPtj8w9IlfDckQMp71cSNSQP7hWcJ7Jd2oI4/rnLnM7fYZ2hOA1JDQtblsEa47m9bCqTn8tbuftM9q3WG92HhK29DdaUA2//ZGIBQvXDul5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RC5/IaQu; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso262290b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709167113; x=1709771913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRxwZRNCH2mhvj5BH6CtV9uA6BSo86eped93k9fcnb8=;
        b=RC5/IaQuW23ia1cE2c8h28GAnfB+T1uzERPHFGkxti7atnU6ZRqhfRJERMgpq/2+XT
         DHUZqmzHnqxtxZxlvMUcPjZ31xU6w8Ma+pha8QqBSCwKdY/Qq7J2exgpqx/qUynweney
         JNddkWAWiVnoEl9D24OqG+j1x5GthkmdCKbj1BiEV81QIq8kXWNpUQHHEc8JItRopQg/
         0igwcdB18mJ5FO/a4N0SzK4YX+w+UX+uTQm1i72Acxwr29Mwtq1YhTN9Y5/i/SzkS9sk
         v1ZaSS/H5SQEP4RpcRoePBzppFf2UyfMNz/CSE5jAB5f6LBiNgqhRzFdk+6T9Xj/oGBF
         mHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709167113; x=1709771913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRxwZRNCH2mhvj5BH6CtV9uA6BSo86eped93k9fcnb8=;
        b=m/EiJ7Q1PbYb2E9ITPRc2uRJ0KCar6lCAVAIzZNEvwreA9DpuKf+c9KGEN3Z6ls5aa
         xk+zyngr0yhLBe5gbxpWjpTKY3EV9cl8m3XRicHaDDeSgFUzC9Ja00E/oJW0AGcHU56x
         waZEKJ1UdNliLsmdQgdc7/RVRWLmu6zSgelX+zFYKN159WbSkTsd/Ea2n00vgJJx6gjB
         5t9XMGuSLQIhQWVYvUoy76euQrdQkzZnXmTEFTm9kxYcDyfNY2FhW9cvWKujBO0B7ajP
         FwtM+QAa+1n65ErznViADOpK7dAl2CTeTTO2tw87yr8e598A+bRy10/zFsV1EzJstK3F
         bhtg==
X-Forwarded-Encrypted: i=1; AJvYcCVkCO+Xo3D0g1Bx9jhG6ESGbTTbSgNjQOO3Fgldle//u5GYLjS4KwX9qsr2MiEldwJq9lhtlqxf9n7yZhYCGjF5r33MgkbU3Zep7QGz
X-Gm-Message-State: AOJu0Yznk+Dn+wGXblHvH3KJ/Xw0ChqWVnQfuyxQYLPOTKEr7pNmIXzX
	u1zf1OTTsNJu6d0AFms7cTJ7ehxzBgG6WWjNbmIZ4HDCHE5HCsQEr/v4dfB1BGggmA==
X-Google-Smtp-Source: AGHT+IFYesE9qHktmHaNdgA0gjlt042dxAyTHhmUPcBc/Iu8UblxtJZ6KbK4wn0XfTJXg38vPbuHew==
X-Received: by 2002:a05:6a20:3252:b0:19f:f059:c190 with SMTP id hm18-20020a056a20325200b0019ff059c190mr905440pzc.24.1709167112788;
        Wed, 28 Feb 2024 16:38:32 -0800 (PST)
Received: from localhost.localdomain ([2407:7000:8942:5500:5158:ed66:78b3:7fda])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b001d9641003cfsm62647pll.142.2024.02.28.16.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:38:32 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	chrisl@kernel.org
Cc: 21cnbao@gmail.com,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	shy828301@gmail.com,
	steven.price@arm.com,
	surenb@google.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yuzhao@google.com,
	kasong@tencent.com,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	hannes@cmpxchg.org,
	linux-arm-kernel@lists.infradead.org,
	Barry Song <v-songbaohua@oppo.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Peter Collingbourne <pcc@google.com>,
	Peter Xu <peterx@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH RFC v2 1/5] arm64: mm: swap: support THP_SWAP on hardware with MTE
Date: Thu, 29 Feb 2024 13:37:49 +1300
Message-Id: <20240229003753.134193-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229003753.134193-1-21cnbao@gmail.com>
References: <20240229003753.134193-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Commit d0637c505f8a1 ("arm64: enable THP_SWAP for arm64") brings up
THP_SWAP on ARM64, but it doesn't enable THP_SWP on hardware with
MTE as the MTE code works with the assumption tags save/restore is
always handling a folio with only one page.

The limitation should be removed as more and more ARM64 SoCs have
this feature. Co-existence of MTE and THP_SWAP becomes more and
more important.

This patch makes MTE tags saving support large folios, then we don't
need to split large folios into base pages for swapping out on ARM64
SoCs with MTE any more.

arch_prepare_to_swap() should take folio rather than page as parameter
because we support THP swap-out as a whole. It saves tags for all
pages in a large folio.

As now we are restoring tags based-on folio, in arch_swap_restore(),
we may increase some extra loops and early-exitings while refaulting
a large folio which is still in swapcache in do_swap_page(). In case
a large folio has nr pages, do_swap_page() will only set the PTE of
the particular page which is causing the page fault.
Thus do_swap_page() runs nr times, and each time, arch_swap_restore()
will loop nr times for those subpages in the folio. So right now the
algorithmic complexity becomes O(nr^2).

Once we support mapping large folios in do_swap_page(), extra loops
and early-exitings will decrease while not being completely removed
as a large folio might get partially tagged in corner cases such as,
1. a large folio in swapcache can be partially unmapped, thus, MTE
tags for the unmapped pages will be invalidated;
2. users might use mprotect() to set MTEs on a part of a large folio.

arch_thp_swp_supported() is dropped since ARM64 MTE was the only one
who needed it.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Steven Price <steven.price@arm.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Acked-by: Chris Li <chrisl@kernel.org>
---
 arch/arm64/include/asm/pgtable.h | 19 ++------------
 arch/arm64/mm/mteswap.c          | 43 ++++++++++++++++++++++++++++++++
 include/linux/huge_mm.h          | 12 ---------
 include/linux/pgtable.h          |  2 +-
 mm/page_io.c                     |  2 +-
 mm/swap_slots.c                  |  2 +-
 6 files changed, 48 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 401087e8a43d..7a54750770b8 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -45,12 +45,6 @@
 	__flush_tlb_range(vma, addr, end, PUD_SIZE, false, 1)
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-static inline bool arch_thp_swp_supported(void)
-{
-	return !system_supports_mte();
-}
-#define arch_thp_swp_supported arch_thp_swp_supported
-
 /*
  * Outside of a few very special situations (e.g. hibernation), we always
  * use broadcast TLB invalidation instructions, therefore a spurious page
@@ -1095,12 +1089,7 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 #ifdef CONFIG_ARM64_MTE
 
 #define __HAVE_ARCH_PREPARE_TO_SWAP
-static inline int arch_prepare_to_swap(struct page *page)
-{
-	if (system_supports_mte())
-		return mte_save_tags(page);
-	return 0;
-}
+extern int arch_prepare_to_swap(struct folio *folio);
 
 #define __HAVE_ARCH_SWAP_INVALIDATE
 static inline void arch_swap_invalidate_page(int type, pgoff_t offset)
@@ -1116,11 +1105,7 @@ static inline void arch_swap_invalidate_area(int type)
 }
 
 #define __HAVE_ARCH_SWAP_RESTORE
-static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
-{
-	if (system_supports_mte())
-		mte_restore_tags(entry, &folio->page);
-}
+extern void arch_swap_restore(swp_entry_t entry, struct folio *folio);
 
 #endif /* CONFIG_ARM64_MTE */
 
diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
index a31833e3ddc5..295836fef620 100644
--- a/arch/arm64/mm/mteswap.c
+++ b/arch/arm64/mm/mteswap.c
@@ -68,6 +68,13 @@ void mte_invalidate_tags(int type, pgoff_t offset)
 	mte_free_tag_storage(tags);
 }
 
+static inline void __mte_invalidate_tags(struct page *page)
+{
+	swp_entry_t entry = page_swap_entry(page);
+
+	mte_invalidate_tags(swp_type(entry), swp_offset(entry));
+}
+
 void mte_invalidate_tags_area(int type)
 {
 	swp_entry_t entry = swp_entry(type, 0);
@@ -83,3 +90,39 @@ void mte_invalidate_tags_area(int type)
 	}
 	xa_unlock(&mte_pages);
 }
+
+int arch_prepare_to_swap(struct folio *folio)
+{
+	long i, nr;
+	int err;
+
+	if (!system_supports_mte())
+		return 0;
+
+	nr = folio_nr_pages(folio);
+
+	for (i = 0; i < nr; i++) {
+		err = mte_save_tags(folio_page(folio, i));
+		if (err)
+			goto out;
+	}
+	return 0;
+
+out:
+	while (i--)
+		__mte_invalidate_tags(folio_page(folio, i));
+	return err;
+}
+
+void arch_swap_restore(swp_entry_t entry, struct folio *folio)
+{
+	if (system_supports_mte()) {
+		long i, nr = folio_nr_pages(folio);
+
+		entry.val -= swp_offset(entry) & (nr - 1);
+		for (i = 0; i < nr; i++) {
+			mte_restore_tags(entry, folio_page(folio, i));
+			entry.val++;
+		}
+	}
+}
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index de0c89105076..e04b93c43965 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -535,16 +535,4 @@ static inline int split_folio_to_order(struct folio *folio, int new_order)
 #define split_folio_to_list(f, l) split_folio_to_list_to_order(f, l, 0)
 #define split_folio(f) split_folio_to_order(f, 0)
 
-/*
- * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP due to
- * limitations in the implementation like arm64 MTE can override this to
- * false
- */
-#ifndef arch_thp_swp_supported
-static inline bool arch_thp_swp_supported(void)
-{
-	return true;
-}
-#endif
-
 #endif /* _LINUX_HUGE_MM_H */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index a36cf4e124b0..ec7efce0f3f0 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1052,7 +1052,7 @@ static inline int arch_unmap_one(struct mm_struct *mm,
  * prototypes must be defined in the arch-specific asm/pgtable.h file.
  */
 #ifndef __HAVE_ARCH_PREPARE_TO_SWAP
-static inline int arch_prepare_to_swap(struct page *page)
+static inline int arch_prepare_to_swap(struct folio *folio)
 {
 	return 0;
 }
diff --git a/mm/page_io.c b/mm/page_io.c
index ae2b49055e43..a9a7c236aecc 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -189,7 +189,7 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 	 * Arch code may have to preserve more data than just the page
 	 * contents, e.g. memory tags.
 	 */
-	ret = arch_prepare_to_swap(&folio->page);
+	ret = arch_prepare_to_swap(folio);
 	if (ret) {
 		folio_mark_dirty(folio);
 		folio_unlock(folio);
diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 90973ce7881d..53abeaf1371d 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -310,7 +310,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
 	entry.val = 0;
 
 	if (folio_test_large(folio)) {
-		if (IS_ENABLED(CONFIG_THP_SWAP) && arch_thp_swp_supported())
+		if (IS_ENABLED(CONFIG_THP_SWAP))
 			get_swap_pages(1, &entry, folio_nr_pages(folio));
 		goto out;
 	}
-- 
2.34.1


