Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5369809D33
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573276AbjLHHeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573264AbjLHHeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:34:22 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA541733
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:34:27 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6ce26a03d9eso1357030b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 23:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702020867; x=1702625667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tD0rhHN+5JgdtIfgP4eoVn3jyNgfaDxDB4LEfmpaOaM=;
        b=lxK4pvatjPIPyGS8K+wOREafGk5CXfaUuZ0hb/jKsr1JBGPrlXiMDddglyJGWgOKE6
         nNM5xk+/CAZTZ0N9g6tMLbcx/bHzJpS4tty7iB7t0Pd/Nn1mYnN6KCAkCTSNXNgfbUDR
         yJGDKXjLBL7tkM3PL+mDrrS1iV91GOCqG9ISx1jjMxl9fHnWX4rpnNchc7yWR/1puILg
         n815dGdCvwWhXHZPC17r4RLCf6CaeKLLkYqnzwNRg1iHZHKeeXpbAuLjWcsMkANCIuht
         x35M4BXmBy8Upg1kF8bxsoRPEXw2vp0WZY/Ld2LSbJS2TupPx0xipGwiMJrLH7H52X4o
         7Mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702020867; x=1702625667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tD0rhHN+5JgdtIfgP4eoVn3jyNgfaDxDB4LEfmpaOaM=;
        b=f+w0t20XRAcQ4uPZHpL9p4ey/pJlljLXNA41xJnQG3NqAkRWf3sTkcdDIDOwDHNwpt
         a2y8mSZ69wEiUjR44c1xzgir0Q51iCaQLmFKTneNUAANFHQ3R0IMpLzSwPAJsv02Fo2t
         x3ojkjY3+0VcyU33CxpYheYwdKkHJ4+eYpPeb0CdwyvqvHqm1CnlhhhYIFWq3t8ExetZ
         JkZps5yVEYm03AF+/rKb44/5A05PRmXc0DOhZGYNYannLhH9qwB67e+dhJMbWVvS3DJ9
         bGlh4mPL57aoHlP4XYiNf4I5NRnNmvQFxcfeNkwfU9TyXw4JZhaaVP2D6gSB5CLIFThW
         Jm0g==
X-Gm-Message-State: AOJu0Yz7IsQufG8cW0w0Jerp6k3c2DwfN4INtlN/3UI4LAyon0IwYx2C
        NkMKrLaXvEA1h2pkKTXmg7U=
X-Google-Smtp-Source: AGHT+IHrKqoU8/xdIdRB33s3O0RLVvcp1BCPbz1U7JJ62kJ2qFj1zYqZy+RJCInfQfI/l33Ush6yRQ==
X-Received: by 2002:a05:6a21:6d8e:b0:18f:97c:9275 with SMTP id wl14-20020a056a216d8e00b0018f097c9275mr3832446pzb.90.1702020867120;
        Thu, 07 Dec 2023 23:34:27 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:4cbb:6c3c:f43b:1e8e])
        by smtp.gmail.com with ESMTPSA id d7-20020a17090b004700b00286d8a6d249sm1122893pjt.39.2023.12.07.23.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 23:34:26 -0800 (PST)
From:   Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <v-songbaohua@oppo.com>
To:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        david@redhat.com, linux-mm@kvack.org, ryan.roberts@arm.com,
        steven.price@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     mhocko@suse.com, shy828301@gmail.com, v-songbaohua@oppo.com,
        wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org,
        ying.huang@intel.com, yuzhao@google.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: mm: support THP_SWAP on hardware with MTE
Date:   Fri,  8 Dec 2023 20:34:01 +1300
Message-Id: <20231208073401.70153-1-v-songbaohua@oppo.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Meanwhile, arch_swap_restore() now moves to use page parameter rather
than folio because swap-in, refault and MTE tags are working at the
granularity of base pages rather than folio:
1. a large folio in swapcache can be partially unmapped, thus, MTE
tags for the unmapped pages will be invalidated;
2. users might use mprotect() to set MTEs on a part of a large folio.

Thus, it won't be easy to manage MTE tags at the granularity of folios
since we do have some cases in which a part of pages in a large folios
have valid tags, while the other part of pages haven't. Furthermore,
trying to restore MTE tags for a whole folio can lead to many loops and
early exiting even if the large folio in swapcache are still entirely
mapped since do_swap_page() only sets PTE and frees swap for the base
page where PF is happening.

But we still have a chance to restore tags for a whole large folio
once we support swap-in large folio. So this job is deferred till we
can do refault and swap-in as a large folio.

arch_thp_swp_supported() is dropped since ARM64 MTE was the only one
who needed it.

Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 -v1:
   collected reviewed-by from Steven;
   refine commit log;
 -rfc v3:
   https://lore.kernel.org/linux-mm/20231114014313.67232-1-v-songbaohua@oppo.com/
 -rfc v2:
   https://lore.kernel.org/lkml/20231104093423.170054-1-v-songbaohua@oppo.com/
 -rfc v1:
   https://lore.kernel.org/lkml/20231102223643.7733-1-v-songbaohua@oppo.com/

 arch/arm64/include/asm/pgtable.h | 21 ++++---------------
 arch/arm64/mm/mteswap.c          | 35 ++++++++++++++++++++++++++++++++
 include/linux/huge_mm.h          | 12 -----------
 include/linux/pgtable.h          |  4 ++--
 mm/memory.c                      |  2 +-
 mm/page_io.c                     |  2 +-
 mm/shmem.c                       |  2 +-
 mm/swap_slots.c                  |  2 +-
 mm/swapfile.c                    |  2 +-
 9 files changed, 46 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b19a8aee684c..c3eef11c1a9e 100644
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
@@ -1036,12 +1030,8 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 #ifdef CONFIG_ARM64_MTE
 
 #define __HAVE_ARCH_PREPARE_TO_SWAP
-static inline int arch_prepare_to_swap(struct page *page)
-{
-	if (system_supports_mte())
-		return mte_save_tags(page);
-	return 0;
-}
+#define arch_prepare_to_swap arch_prepare_to_swap
+extern int arch_prepare_to_swap(struct folio *folio);
 
 #define __HAVE_ARCH_SWAP_INVALIDATE
 static inline void arch_swap_invalidate_page(int type, pgoff_t offset)
@@ -1057,11 +1047,8 @@ static inline void arch_swap_invalidate_area(int type)
 }
 
 #define __HAVE_ARCH_SWAP_RESTORE
-static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
-{
-	if (system_supports_mte())
-		mte_restore_tags(entry, &folio->page);
-}
+#define arch_swap_restore arch_swap_restore
+extern void arch_swap_restore(swp_entry_t entry, struct page *page);
 
 #endif /* CONFIG_ARM64_MTE */
 
diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
index a31833e3ddc5..d0ebed4e002f 100644
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
@@ -83,3 +90,31 @@ void mte_invalidate_tags_area(int type)
 	}
 	xa_unlock(&mte_pages);
 }
+
+int arch_prepare_to_swap(struct folio *folio)
+{
+	int err;
+	long i;
+
+	if (system_supports_mte()) {
+		long nr = folio_nr_pages(folio);
+
+		for (i = 0; i < nr; i++) {
+			err = mte_save_tags(folio_page(folio, i));
+			if (err)
+				goto out;
+		}
+	}
+	return 0;
+
+out:
+	while (i--)
+		__mte_invalidate_tags(folio_page(folio, i));
+	return err;
+}
+
+void arch_swap_restore(swp_entry_t entry, struct page *page)
+{
+	if (system_supports_mte())
+		mte_restore_tags(entry, page);
+}
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index fa0350b0812a..f83fb8d5241e 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -400,16 +400,4 @@ static inline int split_folio(struct folio *folio)
 	return split_folio_to_list(folio, NULL);
 }
 
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
index af7639c3b0a3..87e3140a55ca 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -897,7 +897,7 @@ static inline int arch_unmap_one(struct mm_struct *mm,
  * prototypes must be defined in the arch-specific asm/pgtable.h file.
  */
 #ifndef __HAVE_ARCH_PREPARE_TO_SWAP
-static inline int arch_prepare_to_swap(struct page *page)
+static inline int arch_prepare_to_swap(struct folio *folio)
 {
 	return 0;
 }
@@ -914,7 +914,7 @@ static inline void arch_swap_invalidate_area(int type)
 #endif
 
 #ifndef __HAVE_ARCH_SWAP_RESTORE
-static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
+static inline void arch_swap_restore(swp_entry_t entry, struct page *page)
 {
 }
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index 1f18ed4a5497..fad238dd38e7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4022,7 +4022,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	 * when reading from swap. This metadata may be indexed by swap entry
 	 * so this must be called before swap_free().
 	 */
-	arch_swap_restore(entry, folio);
+	arch_swap_restore(entry, page);
 
 	/*
 	 * Remove the swap entry and conditionally try to free up the swapcache.
diff --git a/mm/page_io.c b/mm/page_io.c
index cb559ae324c6..0fd832474c1d 100644
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
diff --git a/mm/shmem.c b/mm/shmem.c
index 91e2620148b2..7d32e50da121 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1892,7 +1892,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	 * Some architectures may have to restore extra metadata to the
 	 * folio after reading from swap.
 	 */
-	arch_swap_restore(swap, folio);
+	arch_swap_restore(swap, &folio->page);
 
 	if (shmem_should_replace_folio(folio, gfp)) {
 		error = shmem_replace_folio(&folio, gfp, info, index);
diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 0bec1f705f8e..2325adbb1f19 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -307,7 +307,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
 	entry.val = 0;
 
 	if (folio_test_large(folio)) {
-		if (IS_ENABLED(CONFIG_THP_SWAP) && arch_thp_swp_supported())
+		if (IS_ENABLED(CONFIG_THP_SWAP))
 			get_swap_pages(1, &entry, folio_nr_pages(folio));
 		goto out;
 	}
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4bc70f459164..6450e0279e35 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1784,7 +1784,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	 * when reading from swap. This metadata may be indexed by swap entry
 	 * so this must be called before swap_free().
 	 */
-	arch_swap_restore(entry, page_folio(page));
+	arch_swap_restore(entry, page);
 
 	/* See do_swap_page() */
 	BUG_ON(!PageAnon(page) && PageMappedToDisk(page));
-- 
2.34.1

