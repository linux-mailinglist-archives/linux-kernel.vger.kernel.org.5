Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFFD801D24
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 14:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjLBNm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 08:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBNmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 08:42:54 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6507114;
        Sat,  2 Dec 2023 05:42:57 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54bfd4546fbso3630992a12.1;
        Sat, 02 Dec 2023 05:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701524576; x=1702129376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9P5o2b99GlglKxbzObO1HUWWxAKs7zSH8OwwiEeoE7E=;
        b=AFskSbDAHkTMVd8K6sDy9wMMKGXSIglL5knI1Y/m0DuK5k0difJyaHK3bD2O0UrM6A
         wnK2SKpyv6faPEgIVs/vFVEE3lFHdeggAq3BTuiytznJqBXoTlhLN/cox5jyZe81pgna
         1AHz9ZrJygbAo52hbsjoTvPwhK8E7ckYmJ+Fyz3vsWGjtxUon+vg3WT9DNXUAGBUfRb2
         uEqy9SQDdxiUrSZ5VExh6EsyD9iEL6eRGdINb9pbS+WQPEL4UVtXFFgvYAgA8Jr6U6J6
         HtLQOYwF6NkFKA+Zi6RRk7bQgmarMUBQildZRXFYy9xxzOQBLNysq2wfLJh3TJhuJJ40
         MX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701524576; x=1702129376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9P5o2b99GlglKxbzObO1HUWWxAKs7zSH8OwwiEeoE7E=;
        b=DIwxYJqlnKtQwSHfVWRYa9JyrapM3GLt4rnp5PeAifSJCN7YnhIhRsq5V2Z67KVCam
         B+Exk5CAH4v8XH7PaBlC3VjhXhhay03Sgje+IHugLLVmc8SPum4XFH3BqrcukpRSATOJ
         f2fLyzFqK5dASyvdd3YoHSiTH7NeX4cbuFl4wkof0vj0MhRDX1IdnFMF3MxFYXzO6DOH
         E1qjmr7xQOOSTfJOVEvtxR7CYPaxuEiYp6aZFicJ/tKezAKN6Ygn38MVbBLzCF7ToyNX
         ulPPpeJR8ZZ8L0/rjtpYM+YXwukKwPeCFy2rXT4RRfr2OqN1uBqdXUB8dbkMr6oW49XU
         NQ3A==
X-Gm-Message-State: AOJu0YxqjcKWTp4MwQHg1ZYKhjyN6a1MjO7X+gX/9QI8RYpAGZqjzyxY
        4AIeWbr0UNfo3LetAnYUMOZs990WjsH4Rw==
X-Google-Smtp-Source: AGHT+IEGn9kTQ05vQvO3dfpp3YJbOj2g8vU0vk2nAxhNVe+6uYea1OXml27oHl+5roPaJ95JlF+k3A==
X-Received: by 2002:a50:c349:0:b0:54c:9c9f:ad0b with SMTP id q9-20020a50c349000000b0054c9c9fad0bmr124983edb.1.1701524575821;
        Sat, 02 Dec 2023 05:42:55 -0800 (PST)
Received: from yjn-Lenovo-V14-G2-ITL.fritz.box (p200300e12f0eab007132e54fba4f5c6b.dip0.t-ipconnect.de. [2003:e1:2f0e:ab00:7132:e54f:ba4f:5c6b])
        by smtp.gmail.com with ESMTPSA id a20-20020a509b54000000b0054c4fdb42e5sm1811114edj.74.2023.12.02.05.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 05:42:55 -0800 (PST)
From:   York Jasper Niebuhr <yjnworkstation@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, rppt@kernel.org,
        linux-security-module@vger.kernel.org,
        York Jasper Niebuhr <yjnworkstation@gmail.com>
Subject: [PATCH] mm: init_mlocked_on_free
Date:   Sat,  2 Dec 2023 14:42:18 +0100
Message-Id: <20231202134218.151074-1-yjnworkstation@gmail.com>
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

Adds the "PG_ofinit" page flag to specify if a page should be zeroed on
free.

Implements the "init_mlocked_on_free" boot option. When this boot option
is set, any mlock'ed pages are zeroed on munmap, exit or exec. If the
pages are munlock'ed beforehand, no initialization will take place. This
boot option is meant to combat the performance hit of "init_on_free" as
reported in commit 6471384af2a6 ("mm: security: introduce
init_on_alloc=1 and init_on_free=1 boot options"). With
"init_mlocked_on_free", only relevant data will be freed while
everything else is left untouched by the kernel.

Optimally, userspace programs will clear any key material or other
confidential memory before exit and munlock the according memory
regions. If a program crashes, however, userspace key managers will not
be able to zero this data. If this happens, the memory will not be
explicitly munlock'ed before exit either, so the kernel will zero the
data and prevent data leaks. If the program finishes properly, no pages
will be initialized again, as they were already munlock'ed.

In general, leaving memory mlock'ed until unmap, exit or exec can be used
to specify exactly what memory should be initialized on free.

CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON can be set to enable
"init_mlocked_on_free" by default.

Signed-off-by: York Jasper Niebuhr <yjnworkstation@gmail.com>

---
 .../admin-guide/kernel-parameters.txt         |  6 +++
 arch/s390/kernel/uv.c                         |  2 +-
 fs/exec.c                                     |  2 +-
 include/linux/mm.h                            |  9 +++-
 include/linux/page-flags.h                    |  3 ++
 include/linux/swap.h                          |  2 +-
 include/trace/events/mmflags.h                |  3 +-
 mm/compaction.c                               |  2 +-
 mm/fadvise.c                                  |  2 +-
 mm/gup.c                                      |  4 +-
 mm/internal.h                                 |  8 +--
 mm/khugepaged.c                               |  6 +--
 mm/madvise.c                                  | 10 ++--
 mm/memfd.c                                    |  2 +-
 mm/memory.c                                   |  6 +--
 mm/migrate.c                                  |  4 +-
 mm/migrate_device.c                           |  2 +-
 mm/mlock.c                                    | 52 ++++++++++++-------
 mm/mm_init.c                                  | 43 ++++++++++++---
 mm/mmap.c                                     |  4 +-
 mm/page_alloc.c                               |  3 +-
 mm/rmap.c                                     |  4 +-
 mm/swap.c                                     | 12 ++---
 mm/swap_state.c                               |  6 +--
 mm/vmscan.c                                   |  8 +--
 mm/zswap.c                                    |  2 +-
 security/Kconfig.hardening                    | 14 +++++
 27 files changed, 148 insertions(+), 73 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2f3b732a0914..8ca99cea7489 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2096,6 +2096,12 @@
 			Format: 0 | 1
 			Default set by CONFIG_INIT_ON_FREE_DEFAULT_ON.
 
+	init_mlocked_on_free=	[MM] Fill freed userspace pages with zeroes if
+				they were mlock'ed and not explicitly munlock'ed
+				afterwards.
+				Format: 0 | 1
+				Default set by CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON
+
 	init_pkru=	[X86] Specify the default memory protection keys rights
 			register contents for all processes.  0x55555554 by
 			default (disallow access to all but pkey 0).  Can
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index fc07bc39e698..1c5c3cbd395b 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -344,7 +344,7 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
 		 * on the local CPU so that hopefully the refcount will
 		 * reach the expected safe value.
 		 */
-		lru_add_drain();
+		lru_add_drain(0);
 		local_drain = true;
 		/* And now we try again immediately after draining */
 		goto again;
diff --git a/fs/exec.c b/fs/exec.c
index ee43597cb453..c29bd0df4000 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -716,7 +716,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 				       vma, new_start, length, false, true))
 		return -ENOMEM;
 
-	lru_add_drain();
+	lru_add_drain(0);
 	tlb_gather_mmu(&tlb, mm);
 	next = vma_next(&vmi);
 	if (new_end > old_start) {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a422cc123a2d..518099969a9b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3702,7 +3702,14 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
 static inline bool want_init_on_free(void)
 {
 	return static_branch_maybe(CONFIG_INIT_ON_FREE_DEFAULT_ON,
-				   &init_on_free);
+				&init_on_free);
+}
+
+DECLARE_STATIC_KEY_MAYBE(CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON, init_mlocked_on_free);
+static inline bool want_init_mlocked_on_free(void)
+{
+	return static_branch_maybe(CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON,
+				&init_mlocked_on_free);
 }
 
 extern bool _debug_pagealloc_enabled_early;
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 735cddc13d20..89bf2875f0f2 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -119,6 +119,7 @@ enum pageflags {
 	PG_reclaim,		/* To be reclaimed asap */
 	PG_swapbacked,		/* Page is backed by RAM/swap */
 	PG_unevictable,		/* Page is "unevictable"  */
+	PG_ofinit,		/* Page should be initialized on free */
 #ifdef CONFIG_MMU
 	PG_mlocked,		/* Page is vma mlocked */
 #endif
@@ -562,6 +563,8 @@ PAGEFLAG_FALSE(Mlocked, mlocked) __CLEARPAGEFLAG_NOOP(Mlocked, mlocked)
 	TESTSCFLAG_FALSE(Mlocked, mlocked)
 #endif
 
+PAGEFLAG(Ofinit, ofinit, PF_NO_TAIL)
+
 #ifdef CONFIG_ARCH_USES_PG_UNCACHED
 PAGEFLAG(Uncached, uncached, PF_NO_COMPOUND)
 #else
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 3ba146ae7cf5..e1f374ec0dda 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -389,7 +389,7 @@ static inline void lru_cache_enable(void)
 }
 
 extern void lru_cache_disable(void);
-extern void lru_add_drain(void);
+extern void lru_add_drain(int cofinit);
 extern void lru_add_drain_cpu(int cpu);
 extern void lru_add_drain_cpu_zone(struct zone *zone);
 extern void lru_add_drain_all(void);
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index d801409b33cf..e04264210c66 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -118,7 +118,8 @@
 	DEF_PAGEFLAG_NAME(mappedtodisk),				\
 	DEF_PAGEFLAG_NAME(reclaim),					\
 	DEF_PAGEFLAG_NAME(swapbacked),					\
-	DEF_PAGEFLAG_NAME(unevictable)					\
+	DEF_PAGEFLAG_NAME(unevictable),					\
+	DEF_PAGEFLAG_NAME(ofinit)					\
 IF_HAVE_PG_MLOCK(mlocked)						\
 IF_HAVE_PG_UNCACHED(uncached)						\
 IF_HAVE_PG_HWPOISON(hwpoison)						\
diff --git a/mm/compaction.c b/mm/compaction.c
index e2d0c604ae42..092f21a74340 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2503,7 +2503,7 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	trace_mm_compaction_begin(cc, start_pfn, end_pfn, sync);
 
 	/* lru_add_drain_all could be expensive with involving other CPUs */
-	lru_add_drain();
+	lru_add_drain(0);
 
 	while ((ret = compact_finished(cc)) == COMPACT_CONTINUE) {
 		int err;
diff --git a/mm/fadvise.c b/mm/fadvise.c
index 6c39d42f16dc..021bd7ebcef0 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -153,7 +153,7 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 			 * second cache tree walk below by flushing
 			 * them out right away.
 			 */
-			lru_add_drain();
+			lru_add_drain(0);
 
 			mapping_try_invalidate(mapping, start_index, end_index,
 					&nr_failed);
diff --git a/mm/gup.c b/mm/gup.c
index 231711efa390..dda0d3354c58 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1676,7 +1676,7 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 	 */
 	ret = __get_user_pages(mm, start, nr_pages, gup_flags,
 			       NULL, locked ? locked : &local_locked);
-	lru_add_drain();
+	lru_add_drain(0);
 	return ret;
 }
 
@@ -1734,7 +1734,7 @@ long faultin_vma_page_range(struct vm_area_struct *vma, unsigned long start,
 
 	ret = __get_user_pages(mm, start, nr_pages, gup_flags,
 			       NULL, locked);
-	lru_add_drain();
+	lru_add_drain(0);
 	return ret;
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index 8450562744cf..e3e8974a9da9 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -670,7 +670,7 @@ static inline void mlock_vma_folio(struct folio *folio,
 		mlock_folio(folio);
 }
 
-void munlock_folio(struct folio *folio);
+void munlock_folio(struct folio *folio, int cofinit);
 static inline void munlock_vma_folio(struct folio *folio,
 					struct vm_area_struct *vma)
 {
@@ -684,12 +684,12 @@ static inline void munlock_vma_folio(struct folio *folio,
 	 * if it's wrong.
 	 */
 	if (unlikely(vma->vm_flags & VM_LOCKED))
-		munlock_folio(folio);
+		munlock_folio(folio, 0);
 }
 
 void mlock_new_folio(struct folio *folio);
 bool need_mlock_drain(int cpu);
-void mlock_drain_local(void);
+void mlock_drain_local(int cofinit);
 void mlock_drain_remote(int cpu);
 
 extern pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
@@ -777,7 +777,7 @@ static inline struct file *maybe_unlock_mmap_for_io(struct vm_fault *vmf,
 static inline void unmap_mapping_folio(struct folio *folio) { }
 static inline void mlock_new_folio(struct folio *folio) { }
 static inline bool need_mlock_drain(int cpu) { return false; }
-static inline void mlock_drain_local(void) { }
+static inline void mlock_drain_local(int cofinit) { }
 static inline void mlock_drain_remote(int cpu) { }
 static inline void vunmap_range_noflush(unsigned long start, unsigned long end)
 {
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 0da6937572cf..c9ff7778a4cc 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1048,7 +1048,7 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 
 	/* Drain LRU cache to remove extra pin on the swapped in pages */
 	if (swapped_in)
-		lru_add_drain();
+		lru_add_drain(0);
 
 	result = SCAN_SUCCEED;
 out:
@@ -1863,7 +1863,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 					goto xa_unlocked;
 				}
 				/* drain lru cache to help isolate_lru_page() */
-				lru_add_drain();
+				lru_add_drain(0);
 				page = folio_file_page(folio, index);
 			} else if (trylock_page(page)) {
 				get_page(page);
@@ -1879,7 +1879,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 							  file, index,
 							  end - index);
 				/* drain lru cache to help isolate_lru_page() */
-				lru_add_drain();
+				lru_add_drain(0);
 				page = find_lock_page(mapping, index);
 				if (unlikely(page == NULL)) {
 					result = SCAN_FAIL;
diff --git a/mm/madvise.c b/mm/madvise.c
index 6214a1ab5654..78dc28208e77 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -270,13 +270,13 @@ static long madvise_willneed(struct vm_area_struct *vma,
 #ifdef CONFIG_SWAP
 	if (!file) {
 		walk_page_range(vma->vm_mm, start, end, &swapin_walk_ops, vma);
-		lru_add_drain(); /* Push any new pages onto the LRU now */
+		lru_add_drain(0); /* Push any new pages onto the LRU now */
 		return 0;
 	}
 
 	if (shmem_mapping(file->f_mapping)) {
 		shmem_swapin_range(vma, start, end, file->f_mapping);
-		lru_add_drain(); /* Push any new pages onto the LRU now */
+		lru_add_drain(0); /* Push any new pages onto the LRU now */
 		return 0;
 	}
 #else
@@ -564,7 +564,7 @@ static long madvise_cold(struct vm_area_struct *vma,
 	if (!can_madv_lru_vma(vma))
 		return -EINVAL;
 
-	lru_add_drain();
+	lru_add_drain(0);
 	tlb_gather_mmu(&tlb, mm);
 	madvise_cold_page_range(&tlb, vma, start_addr, end_addr);
 	tlb_finish_mmu(&tlb);
@@ -607,7 +607,7 @@ static long madvise_pageout(struct vm_area_struct *vma,
 				(vma->vm_flags & VM_MAYSHARE)))
 		return 0;
 
-	lru_add_drain();
+	lru_add_drain(0);
 	tlb_gather_mmu(&tlb, mm);
 	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr);
 	tlb_finish_mmu(&tlb);
@@ -775,7 +775,7 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
 				range.start, range.end);
 
-	lru_add_drain();
+	lru_add_drain(0);
 	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
 
diff --git a/mm/memfd.c b/mm/memfd.c
index d3a1ba4208c9..8827567f61c5 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -35,7 +35,7 @@ static void memfd_tag_pins(struct xa_state *xas)
 	int latency = 0;
 	int cache_count;
 
-	lru_add_drain();
+	lru_add_drain(0);
 
 	xas_lock_irq(xas);
 	xas_for_each(xas, page, ULONG_MAX) {
diff --git a/mm/memory.c b/mm/memory.c
index a8ff3489211b..bc9cdf619256 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1769,7 +1769,7 @@ void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
 	struct mmu_notifier_range range;
 	struct mmu_gather tlb;
 
-	lru_add_drain();
+	lru_add_drain(0);
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
 				address, end);
 	hugetlb_zap_begin(vma, &range.start, &range.end);
@@ -3382,7 +3382,7 @@ static bool wp_can_reuse_anon_folio(struct folio *folio,
 		 * We cannot easily detect+handle references from
 		 * remote LRU caches or references to LRU folios.
 		 */
-		lru_add_drain();
+		lru_add_drain(0);
 	if (folio_ref_count(folio) > 1 + folio_test_swapcache(folio))
 		return false;
 	if (!folio_trylock(folio))
@@ -3960,7 +3960,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		 */
 		if ((vmf->flags & FAULT_FLAG_WRITE) && folio == swapcache &&
 		    !folio_test_ksm(folio) && !folio_test_lru(folio))
-			lru_add_drain();
+			lru_add_drain(0);
 	}
 
 	folio_throttle_swaprate(folio, GFP_KERNEL);
diff --git a/mm/migrate.c b/mm/migrate.c
index d9d2b9432e81..05740838e1c1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -266,7 +266,7 @@ static bool remove_migration_pte(struct folio *folio,
 			set_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
 		}
 		if (vma->vm_flags & VM_LOCKED)
-			mlock_drain_local();
+			mlock_drain_local(0);
 
 		trace_remove_migration_pte(pvmw.address, pte_val(pte),
 					   compound_order(new));
@@ -1299,7 +1299,7 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 	 */
 	folio_add_lru(dst);
 	if (old_page_state & PAGE_WAS_MLOCKED)
-		lru_add_drain();
+		lru_add_drain(0);
 
 	if (old_page_state & PAGE_WAS_MAPPED)
 		remove_migration_ptes(src, dst, false);
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 8ac1f79f754a..b5d875e31536 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -362,7 +362,7 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
 	bool allow_drain = true;
 	unsigned long unmapped = 0;
 
-	lru_add_drain();
+	lru_add_drain(0);
 
 	for (i = 0; i < npages; i++) {
 		struct page *page = migrate_pfn_to_page(src_pfns[i]);
diff --git a/mm/mlock.c b/mm/mlock.c
index 086546ac5766..59e0ab3aadb7 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -119,7 +119,7 @@ static struct lruvec *__mlock_new_folio(struct folio *folio, struct lruvec *lruv
 	return lruvec;
 }
 
-static struct lruvec *__munlock_folio(struct folio *folio, struct lruvec *lruvec)
+static struct lruvec *__munlock_folio(struct folio *folio, struct lruvec *lruvec, int cofinit)
 {
 	int nr_pages = folio_nr_pages(folio);
 	bool isolated = false;
@@ -146,6 +146,9 @@ static struct lruvec *__munlock_folio(struct folio *folio, struct lruvec *lruvec
 			__count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
 		else
 			__count_vm_events(UNEVICTABLE_PGSTRANDED, nr_pages);
+
+		if (cofinit)
+			folio_clear_ofinit(folio);
 	}
 
 	/* folio_evictable() has to be checked *after* clearing Mlocked */
@@ -183,7 +186,7 @@ static inline struct folio *mlock_new(struct folio *folio)
  * better (munlocking a full folio batch does not need to drain mlocking folio
  * batches first).
  */
-static void mlock_folio_batch(struct folio_batch *fbatch)
+static void mlock_folio_batch(struct folio_batch *fbatch, int cofinit)
 {
 	struct lruvec *lruvec = NULL;
 	unsigned long mlock;
@@ -201,7 +204,7 @@ static void mlock_folio_batch(struct folio_batch *fbatch)
 		else if (mlock & NEW_FOLIO)
 			lruvec = __mlock_new_folio(folio, lruvec);
 		else
-			lruvec = __munlock_folio(folio, lruvec);
+			lruvec = __munlock_folio(folio, lruvec, cofinit);
 	}
 
 	if (lruvec)
@@ -210,14 +213,14 @@ static void mlock_folio_batch(struct folio_batch *fbatch)
 	folio_batch_reinit(fbatch);
 }
 
-void mlock_drain_local(void)
+void mlock_drain_local(int cofinit)
 {
 	struct folio_batch *fbatch;
 
 	local_lock(&mlock_fbatch.lock);
 	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
 	if (folio_batch_count(fbatch))
-		mlock_folio_batch(fbatch);
+		mlock_folio_batch(fbatch, cofinit);
 	local_unlock(&mlock_fbatch.lock);
 }
 
@@ -228,7 +231,7 @@ void mlock_drain_remote(int cpu)
 	WARN_ON_ONCE(cpu_online(cpu));
 	fbatch = &per_cpu(mlock_fbatch.fbatch, cpu);
 	if (folio_batch_count(fbatch))
-		mlock_folio_batch(fbatch);
+		mlock_folio_batch(fbatch, 0);
 }
 
 bool need_mlock_drain(int cpu)
@@ -252,12 +255,15 @@ void mlock_folio(struct folio *folio)
 
 		zone_stat_mod_folio(folio, NR_MLOCK, nr_pages);
 		__count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
+
+		if (want_init_mlocked_on_free())
+			folio_set_ofinit(folio);
 	}
 
 	folio_get(folio);
 	if (!folio_batch_add(fbatch, mlock_lru(folio)) ||
 	    folio_test_large(folio) || lru_cache_disabled())
-		mlock_folio_batch(fbatch);
+		mlock_folio_batch(fbatch, 0);
 	local_unlock(&mlock_fbatch.lock);
 }
 
@@ -274,13 +280,16 @@ void mlock_new_folio(struct folio *folio)
 	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
 	folio_set_mlocked(folio);
 
+	if (want_init_mlocked_on_free())
+		folio_set_ofinit(folio);
+
 	zone_stat_mod_folio(folio, NR_MLOCK, nr_pages);
 	__count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
 
 	folio_get(folio);
 	if (!folio_batch_add(fbatch, mlock_new(folio)) ||
 	    folio_test_large(folio) || lru_cache_disabled())
-		mlock_folio_batch(fbatch);
+		mlock_folio_batch(fbatch, 0);
 	local_unlock(&mlock_fbatch.lock);
 }
 
@@ -288,7 +297,7 @@ void mlock_new_folio(struct folio *folio)
  * munlock_folio - munlock a folio
  * @folio: folio to be munlocked, either normal or a THP head.
  */
-void munlock_folio(struct folio *folio)
+void munlock_folio(struct folio *folio, int cofinit)
 {
 	struct folio_batch *fbatch;
 
@@ -301,7 +310,7 @@ void munlock_folio(struct folio *folio)
 	folio_get(folio);
 	if (!folio_batch_add(fbatch, folio) ||
 	    folio_test_large(folio) || lru_cache_disabled())
-		mlock_folio_batch(fbatch);
+		mlock_folio_batch(fbatch, cofinit);
 	local_unlock(&mlock_fbatch.lock);
 }
 
@@ -372,6 +381,8 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 	struct folio *folio;
 	unsigned int step = 1;
 	unsigned long start = addr;
+	int *cofinit_ptr = (int *)walk->private;
+	int cofinit = cofinit_ptr ? *cofinit_ptr : 0;
 
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
@@ -383,7 +394,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_folio(folio);
 		else
-			munlock_folio(folio);
+			munlock_folio(folio, cofinit);
 		goto out;
 	}
 
@@ -408,7 +419,7 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_folio(folio);
 		else
-			munlock_folio(folio);
+			munlock_folio(folio, cofinit);
 
 next_entry:
 		pte += step - 1;
@@ -433,7 +444,8 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
  * called for munlock() and munlockall(), to clear VM_LOCKED from @vma.
  */
 static void mlock_vma_pages_range(struct vm_area_struct *vma,
-	unsigned long start, unsigned long end, vm_flags_t newflags)
+	unsigned long start, unsigned long end, vm_flags_t newflags,
+	int cofinit)
 {
 	static const struct mm_walk_ops mlock_walk_ops = {
 		.pmd_entry = mlock_pte_range,
@@ -456,9 +468,9 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
 	vma_start_write(vma);
 	vm_flags_reset_once(vma, newflags);
 
-	lru_add_drain();
-	walk_page_range(vma->vm_mm, start, end, &mlock_walk_ops, NULL);
-	lru_add_drain();
+	lru_add_drain(cofinit);
+	walk_page_range(vma->vm_mm, start, end, &mlock_walk_ops, &cofinit);
+	lru_add_drain(cofinit);
 
 	if (newflags & VM_IO) {
 		newflags &= ~VM_IO;
@@ -477,7 +489,7 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
  */
 static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       struct vm_area_struct **prev, unsigned long start,
-	       unsigned long end, vm_flags_t newflags)
+	       unsigned long end, vm_flags_t newflags, int cofinit)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	int nr_pages;
@@ -516,7 +528,7 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		vma_start_write(vma);
 		vm_flags_reset(vma, newflags);
 	} else {
-		mlock_vma_pages_range(vma, start, end, newflags);
+		mlock_vma_pages_range(vma, start, end, newflags, cofinit);
 	}
 out:
 	*prev = vma;
@@ -560,7 +572,7 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
 		tmp = vma->vm_end;
 		if (tmp > end)
 			tmp = end;
-		error = mlock_fixup(&vmi, vma, &prev, nstart, tmp, newflags);
+		error = mlock_fixup(&vmi, vma, &prev, nstart, tmp, newflags, 1);
 		if (error)
 			return error;
 		tmp = vma_iter_end(&vmi);
@@ -744,7 +756,7 @@ static int apply_mlockall_flags(int flags)
 
 		/* Ignore errors */
 		mlock_fixup(&vmi, vma, &prev, vma->vm_start, vma->vm_end,
-			    newflags);
+			    newflags, 1);
 		cond_resched();
 	}
 out:
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 077bfe393b5e..1dbdb1c8c7c1 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2589,6 +2589,9 @@ EXPORT_SYMBOL(init_on_alloc);
 DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_FREE_DEFAULT_ON, init_on_free);
 EXPORT_SYMBOL(init_on_free);
 
+DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON, init_mlocked_on_free);
+EXPORT_SYMBOL(init_mlocked_on_free);
+
 static bool _init_on_alloc_enabled_early __read_mostly
 				= IS_ENABLED(CONFIG_INIT_ON_ALLOC_DEFAULT_ON);
 static int __init early_init_on_alloc(char *buf)
@@ -2606,6 +2609,15 @@ static int __init early_init_on_free(char *buf)
 }
 early_param("init_on_free", early_init_on_free);
 
+static bool _init_mlocked_on_free_enabled_early __read_mostly
+				= IS_ENABLED(CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON);
+
+static int __init early_init_mlocked_on_free(char *buf)
+{
+	return kstrtobool(buf, &_init_mlocked_on_free_enabled_early);
+}
+early_param("init_mlocked_on_free", early_init_mlocked_on_free);
+
 DEFINE_STATIC_KEY_MAYBE(CONFIG_DEBUG_VM, check_pages_enabled);
 
 /*
@@ -2633,12 +2645,21 @@ static void __init mem_debugging_and_hardening_init(void)
 	}
 #endif
 
-	if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early) &&
+	if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early
+				|| _init_mlocked_on_free_enabled_early) &&
 	    page_poisoning_requested) {
 		pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
-			"will take precedence over init_on_alloc and init_on_free\n");
+			"will take precedence over init_on_alloc, init_on_free "
+			"and init_mlocked_on_free\n");
 		_init_on_alloc_enabled_early = false;
 		_init_on_free_enabled_early = false;
+		_init_mlocked_on_free_enabled_early = false;
+	}
+
+	if (_init_mlocked_on_free_enabled_early && _init_on_free_enabled_early) {
+		pr_info("mem auto-init: init_on_free is on, "
+			"will take precedence over init_mlocked_on_free\n");
+		_init_mlocked_on_free_enabled_early = false;
 	}
 
 	if (_init_on_alloc_enabled_early) {
@@ -2655,9 +2676,18 @@ static void __init mem_debugging_and_hardening_init(void)
 		static_branch_disable(&init_on_free);
 	}
 
+	if (_init_mlocked_on_free_enabled_early) {
+		want_check_pages = true;
+		static_branch_enable(&init_mlocked_on_free);
+	} else {
+		static_branch_disable(&init_mlocked_on_free);
+	}
+
 	if (IS_ENABLED(CONFIG_KMSAN) &&
-	    (_init_on_alloc_enabled_early || _init_on_free_enabled_early))
-		pr_info("mem auto-init: please make sure init_on_alloc and init_on_free are disabled when running KMSAN\n");
+	    (_init_on_alloc_enabled_early || _init_on_free_enabled_early
+	     || _init_mlocked_on_free_enabled_early))
+		pr_info("mem auto-init: please make sure init_on_alloc, init_on_free and "
+				"init_mlocked_on_free are disabled when running KMSAN\n");
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 	if (debug_pagealloc_enabled()) {
@@ -2696,9 +2726,10 @@ static void __init report_meminit(void)
 	else
 		stack = "off";
 
-	pr_info("mem auto-init: stack:%s, heap alloc:%s, heap free:%s\n",
+	pr_info("mem auto-init: stack:%s, heap alloc:%s, heap free:%s, mlocked free:%s\n",
 		stack, want_init_on_alloc(GFP_KERNEL) ? "on" : "off",
-		want_init_on_free() ? "on" : "off");
+		want_init_on_free() ? "on" : "off",
+		want_init_mlocked_on_free() ? "on" : "off");
 	if (want_init_on_free())
 		pr_info("mem auto-init: clearing system memory may take some time...\n");
 }
diff --git a/mm/mmap.c b/mm/mmap.c
index e8470b6b678c..b91d8428b84d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2295,7 +2295,7 @@ static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
 	struct mmu_gather tlb;
 	unsigned long mt_start = mas->index;
 
-	lru_add_drain();
+	lru_add_drain(0);
 	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
 	unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
@@ -3266,7 +3266,7 @@ void exit_mmap(struct mm_struct *mm)
 		goto destroy;
 	}
 
-	lru_add_drain();
+	lru_add_drain(0);
 	flush_cache_mm(mm);
 	tlb_gather_mmu_fullmm(&tlb, mm);
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7a8dac0c1c74..9ba1d88d39e4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -17,6 +17,7 @@
 
 #include <linux/stddef.h>
 #include <linux/mm.h>
+#include <linux/page-flags.h>
 #include <linux/highmem.h>
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
@@ -1078,7 +1079,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 {
 	int bad = 0;
 	bool skip_kasan_poison = should_skip_kasan_poison(page, fpi_flags);
-	bool init = want_init_on_free();
+	bool init = want_init_on_free() || PageOfinit(page);
 	bool compound = PageCompound(page);
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
diff --git a/mm/rmap.c b/mm/rmap.c
index de9426ad0f1b..8b5716521c12 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1836,7 +1836,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 discard:
 		page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
 		if (vma->vm_flags & VM_LOCKED)
-			mlock_drain_local();
+			mlock_drain_local(0);
 		folio_put(folio);
 	}
 
@@ -2189,7 +2189,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 
 		page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
 		if (vma->vm_flags & VM_LOCKED)
-			mlock_drain_local();
+			mlock_drain_local(0);
 		folio_put(folio);
 	}
 
diff --git a/mm/swap.c b/mm/swap.c
index cd8f0150ba3a..dc4ac347c8ac 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -746,12 +746,12 @@ void folio_mark_lazyfree(struct folio *folio)
 	}
 }
 
-void lru_add_drain(void)
+void lru_add_drain(int cofinit)
 {
 	local_lock(&cpu_fbatches.lock);
 	lru_add_drain_cpu(smp_processor_id());
 	local_unlock(&cpu_fbatches.lock);
-	mlock_drain_local();
+	mlock_drain_local(cofinit);
 }
 
 /*
@@ -766,7 +766,7 @@ static void lru_add_and_bh_lrus_drain(void)
 	lru_add_drain_cpu(smp_processor_id());
 	local_unlock(&cpu_fbatches.lock);
 	invalidate_bh_lrus_cpu();
-	mlock_drain_local();
+	mlock_drain_local(0);
 }
 
 void lru_add_drain_cpu_zone(struct zone *zone)
@@ -775,7 +775,7 @@ void lru_add_drain_cpu_zone(struct zone *zone)
 	lru_add_drain_cpu(smp_processor_id());
 	drain_local_pages(zone);
 	local_unlock(&cpu_fbatches.lock);
-	mlock_drain_local();
+	mlock_drain_local(0);
 }
 
 #ifdef CONFIG_SMP
@@ -907,7 +907,7 @@ void lru_add_drain_all(void)
 #else
 void lru_add_drain_all(void)
 {
-	lru_add_drain();
+	lru_add_drain(0);
 }
 #endif /* CONFIG_SMP */
 
@@ -1056,7 +1056,7 @@ EXPORT_SYMBOL(release_pages);
 void __folio_batch_release(struct folio_batch *fbatch)
 {
 	if (!fbatch->percpu_pvec_drained) {
-		lru_add_drain();
+		lru_add_drain(0);
 		fbatch->percpu_pvec_drained = true;
 	}
 	release_pages(fbatch->folios, folio_batch_count(fbatch));
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 85d9e5806a6a..8be769e49745 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -310,7 +310,7 @@ void free_page_and_swap_cache(struct page *page)
  */
 void free_pages_and_swap_cache(struct encoded_page **pages, int nr)
 {
-	lru_add_drain();
+	lru_add_drain(0);
 	for (int i = 0; i < nr; i++)
 		free_swap_cache(encoded_page_ptr(pages[i]));
 	release_pages(pages, nr);
@@ -668,7 +668,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	}
 	blk_finish_plug(&plug);
 	swap_read_unplug(splug);
-	lru_add_drain();	/* Push any new pages onto the LRU now */
+	lru_add_drain(0);	/* Push any new pages onto the LRU now */
 skip:
 	/* The page was likely read above, so no need for plugging here */
 	page = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
@@ -843,7 +843,7 @@ static struct page *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 		pte_unmap(pte);
 	blk_finish_plug(&plug);
 	swap_read_unplug(splug);
-	lru_add_drain();
+	lru_add_drain(0);
 skip:
 	/* The page was likely read above, so no need for plugging here */
 	page = __read_swap_cache_async(targ_entry, gfp_mask, mpol, targ_ilx,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 96abaa5a973e..5a432fcad354 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1919,7 +1919,7 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 			return SWAP_CLUSTER_MAX;
 	}
 
-	lru_add_drain();
+	lru_add_drain(0);
 
 	spin_lock_irq(&lruvec->lru_lock);
 
@@ -2028,7 +2028,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	int file = is_file_lru(lru);
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
-	lru_add_drain();
+	lru_add_drain(0);
 
 	spin_lock_irq(&lruvec->lru_lock);
 
@@ -4836,7 +4836,7 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 	VM_WARN_ON_ONCE(root_reclaim(sc));
 	VM_WARN_ON_ONCE(!sc->may_writepage || !sc->may_unmap);
 
-	lru_add_drain();
+	lru_add_drain(0);
 
 	blk_start_plug(&plug);
 
@@ -4904,7 +4904,7 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
 	if (!sc->may_writepage || !sc->may_unmap)
 		goto done;
 
-	lru_add_drain();
+	lru_add_drain(0);
 
 	blk_start_plug(&plug);
 
diff --git a/mm/zswap.c b/mm/zswap.c
index 030cc137138f..05a12bce0c5c 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1146,7 +1146,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 
 	if (!PageLRU(page)) {
 		/* drain lru cache to help folio_rotate_reclaimable() */
-		lru_add_drain();
+		lru_add_drain(0);
 	}
 
 	/* start writeback */
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 2cff851ebfd7..eacc491fa5bb 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -255,6 +255,20 @@ config INIT_ON_FREE_DEFAULT_ON
 	  touching "cold" memory areas. Most cases see 3-5% impact. Some
 	  synthetic workloads have measured as high as 8%.
 
+config INIT_MLOCKED_ON_FREE_DEFAULT_ON
+	bool "Enable mlocked memory zeroing on free"
+	depends on !KMSAN
+	help
+	  This config has the effect of setting "init_mlocked_on_free=1"
+	  on the kernel command line. This can be disabled with
+	  "init_mlocked_on_free=0". When "init_mlocked_on_free" is enabled,
+	  all mlocked process memory will be zeroed when freed. This
+	  restriction to mlocked memory improves performance over
+	  "init_on_free" but can still be used to protect confidential
+	  data like key material from content exposures to other processes,
+	  as well as live forensics and cold boot attacks. Any non-mlocked
+	  memory will not be cleared before it is reassigned.
+
 config CC_HAS_ZERO_CALL_USED_REGS
 	def_bool $(cc-option,-fzero-call-used-regs=used-gpr)
 	# https://github.com/ClangBuiltLinux/linux/issues/1766

base-commit: 4e87148f80d198ba5febcbcc969c6b9471099a09
-- 
2.34.1

