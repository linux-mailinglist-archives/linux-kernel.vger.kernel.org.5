Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65387A1CFE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbjIOLAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbjIOLAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:00:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86F3268F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:00:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81873bf443so2092988276.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694775604; x=1695380404; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QO31JQTgjdCfbGBtgkfgkDIiB/3zYgVmpQ8kZJD1h+Y=;
        b=rnLhAKjLuhA4vg/nVySYKRO6L9b0ld7QHjnHHV6pyD4+JlR7b9/V9L5EaAg2xBThI6
         GtgyvL5XlRdgnRTEe4GW5npsY8nQ+dyAil8lYbxZu3ngjzvyEFRTtyKQ7dPdl+Db5gc0
         PuAqWNkruacXAJB8Dycg8oYIecGc9jnfoX7Psrgoq1gO/WNgMRhSEppj668vER1lN/xS
         s6o4W+ftGzwYabSAbrg5S6u1VRNaUrTmYilNwsPrV0Vti8NZto88GvUZjKcKWoyj9TjX
         8CZLhDZC+iqED6I5UaYd96YHiSYPyxSolQ+UBvM1fV//kc0NX13RNlzk40Zt8xn3q1U4
         9ROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694775604; x=1695380404;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QO31JQTgjdCfbGBtgkfgkDIiB/3zYgVmpQ8kZJD1h+Y=;
        b=Kk3ovv2qElBo9VgoPt6y72TZfPp7outfMcE0Qw4GzqwtTNBMc1Wd9yXw3+o1JhMIUj
         1Qcjdb2aNjMRjxjGcw7tgxbJ4N4lm4enMDNQTAkVyKXAxKPqCZ8hOmij29G1Rz23sbqH
         R86y3P/PfP1Ni+FsGGpWKwuViinf5w7AMFuohuNHFbVjEtT00G4F46Y6iYkmym6m2EJ0
         LwXtS+oJUmWuU9FboRKAzk1lcETYY+zXcJBtUmZtjto3ExalTwbRhpQIOBOmjrqK5LJq
         InDw3J2YCyFBNAwXskxriCk3g2d/0tBGnfXhJ9DCgDvrIyX3/Tsb1GHwHP3wWSh+xN3S
         XMRA==
X-Gm-Message-State: AOJu0YysE6iCvawjjAlL58s4tYSEDyIP/mh7S94s5FZ3cAcbRVwFJl9w
        rcGIPexuNqk36Vamoa8/l7bkVa76oi69eUwfIA==
X-Google-Smtp-Source: AGHT+IHEmylFdcJCHDvLHo7IywUVvUbkVuBMx1sd6LW13fQHTajbqMCrs6QknCEIuXA+dbFf620Y1iDB5FTTmGzUFQ==
X-Received: from mr-cloudtop2.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:2a6])
 (user=matteorizzo job=sendgmr) by 2002:a05:6902:144d:b0:d81:503e:2824 with
 SMTP id a13-20020a056902144d00b00d81503e2824mr26306ybv.10.1694775603871; Fri,
 15 Sep 2023 04:00:03 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:59:29 +0000
In-Reply-To: <20230915105933.495735-1-matteorizzo@google.com>
Mime-Version: 1.0
References: <20230915105933.495735-1-matteorizzo@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915105933.495735-11-matteorizzo@google.com>
Subject: [RFC PATCH 10/14] x86: Create virtual memory region for SLUB
From:   Matteo Rizzo <matteorizzo@google.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net, luto@kernel.org,
        peterz@infradead.org
Cc:     jannh@google.com, matteorizzo@google.com, evn@google.com,
        poprdi@google.com, jordyzomer@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

SLAB_VIRTUAL reserves 512 GiB of virtual memory and uses them for both
struct slab and the actual slab memory. The pointers returned by
kmem_cache_alloc will point to this range of memory.

Signed-off-by: Jann Horn <jannh@google.com>
Co-developed-by: Matteo Rizzo <matteorizzo@google.com>
Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
---
 Documentation/arch/x86/x86_64/mm.rst    |  4 ++--
 arch/x86/include/asm/pgtable_64_types.h | 16 ++++++++++++++++
 arch/x86/mm/init_64.c                   | 19 +++++++++++++++----
 arch/x86/mm/kaslr.c                     |  9 +++++++++
 arch/x86/mm/mm_internal.h               |  4 ++++
 mm/slub.c                               |  4 ++++
 security/Kconfig.hardening              |  2 ++
 7 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/Documentation/arch/x86/x86_64/mm.rst b/Documentation/arch/x86/x86_64/mm.rst
index 35e5e18c83d0..121179537175 100644
--- a/Documentation/arch/x86/x86_64/mm.rst
+++ b/Documentation/arch/x86/x86_64/mm.rst
@@ -57,7 +57,7 @@ Complete virtual memory map with 4-level page tables
    fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole
                     |            |                  |         | vaddr_end for KASLR
    fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping
-   fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | ... unused hole
+   fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | SLUB virtual memory
    ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks
    ffffff8000000000 | -512    GB | ffffffeeffffffff |  444 GB | ... unused hole
    ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space
@@ -116,7 +116,7 @@ Complete virtual memory map with 5-level page tables
    fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole
                     |            |                  |         | vaddr_end for KASLR
    fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping
-   fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | ... unused hole
+   fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | SLUB virtual memory
    ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks
    ffffff8000000000 | -512    GB | ffffffeeffffffff |  444 GB | ... unused hole
    ffffffef00000000 |  -68    GB | fffffffeffffffff |   64 GB | EFI region mapping space
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 38b54b992f32..e1a91eb084c4 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -6,6 +6,7 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
+#include <linux/align.h>
 #include <asm/kaslr.h>
 
 /*
@@ -199,6 +200,21 @@ extern unsigned int ptrs_per_p4d;
 #define ESPFIX_PGD_ENTRY	_AC(-2, UL)
 #define ESPFIX_BASE_ADDR	(ESPFIX_PGD_ENTRY << P4D_SHIFT)
 
+#ifdef CONFIG_SLAB_VIRTUAL
+#define SLAB_PGD_ENTRY		_AC(-3, UL)
+#define SLAB_BASE_ADDR		(SLAB_PGD_ENTRY << P4D_SHIFT)
+#define SLAB_END_ADDR		(SLAB_BASE_ADDR + P4D_SIZE)
+
+/*
+ * We need to define this here because we need it to compute SLAB_META_SIZE
+ * and including slab.h causes a dependency cycle.
+ */
+#define STRUCT_SLAB_SIZE (32 * sizeof(void *))
+#define SLAB_VPAGES ((SLAB_END_ADDR - SLAB_BASE_ADDR) / PAGE_SIZE)
+#define SLAB_META_SIZE ALIGN(SLAB_VPAGES * STRUCT_SLAB_SIZE, PAGE_SIZE)
+#define SLAB_DATA_BASE_ADDR (SLAB_BASE_ADDR + SLAB_META_SIZE)
+#endif /* CONFIG_SLAB_VIRTUAL */
+
 #define CPU_ENTRY_AREA_PGD	_AC(-4, UL)
 #define CPU_ENTRY_AREA_BASE	(CPU_ENTRY_AREA_PGD << P4D_SHIFT)
 
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index a190aae8ceaf..d716ddfd9880 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1279,16 +1279,19 @@ static void __init register_page_bootmem_info(void)
 }
 
 /*
- * Pre-allocates page-table pages for the vmalloc area in the kernel page-table.
+ * Pre-allocates page-table pages for the vmalloc and SLUB areas in the kernel
+ * page-table.
  * Only the level which needs to be synchronized between all page-tables is
  * allocated because the synchronization can be expensive.
  */
-static void __init preallocate_vmalloc_pages(void)
+static void __init preallocate_top_level_entries_range(unsigned long start,
+						       unsigned long end)
 {
 	unsigned long addr;
 	const char *lvl;
 
-	for (addr = VMALLOC_START; addr <= VMEMORY_END; addr = ALIGN(addr + 1, PGDIR_SIZE)) {
+
+	for (addr = start; addr <= end; addr = ALIGN(addr + 1, PGDIR_SIZE)) {
 		pgd_t *pgd = pgd_offset_k(addr);
 		p4d_t *p4d;
 		pud_t *pud;
@@ -1328,6 +1331,14 @@ static void __init preallocate_vmalloc_pages(void)
 	panic("Failed to pre-allocate %s pages for vmalloc area\n", lvl);
 }
 
+static void __init preallocate_top_level_entries(void)
+{
+	preallocate_top_level_entries_range(VMALLOC_START, VMEMORY_END);
+#ifdef CONFIG_SLAB_VIRTUAL
+	preallocate_top_level_entries_range(SLAB_BASE_ADDR, SLAB_END_ADDR - 1);
+#endif
+}
+
 void __init mem_init(void)
 {
 	pci_iommu_alloc();
@@ -1351,7 +1362,7 @@ void __init mem_init(void)
 	if (get_gate_vma(&init_mm))
 		kclist_add(&kcore_vsyscall, (void *)VSYSCALL_ADDR, PAGE_SIZE, KCORE_USER);
 
-	preallocate_vmalloc_pages();
+	preallocate_top_level_entries();
 }
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 37db264866b6..7b297d372a8c 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -136,6 +136,15 @@ void __init kernel_randomize_memory(void)
 		vaddr = round_up(vaddr + 1, PUD_SIZE);
 		remain_entropy -= entropy;
 	}
+
+#ifdef CONFIG_SLAB_VIRTUAL
+	/*
+	 * slub_addr_base is initialized separately from the
+	 * kaslr_memory_regions because it comes after CPU_ENTRY_AREA_BASE.
+	 */
+	prandom_bytes_state(&rand_state, &rand, sizeof(rand));
+	slub_addr_base += (rand & ((1UL << 36) - PAGE_SIZE));
+#endif
 }
 
 void __meminit init_trampoline_kaslr(void)
diff --git a/arch/x86/mm/mm_internal.h b/arch/x86/mm/mm_internal.h
index 3f37b5c80bb3..fafb79b7e019 100644
--- a/arch/x86/mm/mm_internal.h
+++ b/arch/x86/mm/mm_internal.h
@@ -25,4 +25,8 @@ void update_cache_mode_entry(unsigned entry, enum page_cache_mode cache);
 
 extern unsigned long tlb_single_page_flush_ceiling;
 
+#ifdef CONFIG_SLAB_VIRTUAL
+extern unsigned long slub_addr_base;
+#endif
+
 #endif	/* __X86_MM_INTERNAL_H */
diff --git a/mm/slub.c b/mm/slub.c
index 4f77e5d4fe6c..a731fdc79bff 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -166,6 +166,10 @@
  * 			the fast path and disables lockless freelists.
  */
 
+#ifdef CONFIG_SLAB_VIRTUAL
+unsigned long slub_addr_base = SLAB_DATA_BASE_ADDR;
+#endif /* CONFIG_SLAB_VIRTUAL */
+
 /*
  * We could simply use migrate_disable()/enable() but as long as it's a
  * function call even on !PREEMPT_RT, use inline preempt_disable() there.
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 9f4e6e38aa76..f4a0af424149 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -357,6 +357,8 @@ config GCC_PLUGIN_RANDSTRUCT
 
 config SLAB_VIRTUAL
 	bool "Allocate slab objects from virtual memory"
+	# For virtual memory region allocation
+	depends on X86_64
 	depends on SLUB && !SLUB_TINY
 	# If KFENCE support is desired, it could be implemented on top of our
 	# virtual memory allocation facilities
-- 
2.42.0.459.ge4e396fd5e-goog

