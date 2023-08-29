Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C8678BC69
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 03:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbjH2BnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 21:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234899AbjH2Bm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 21:42:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A311FBD;
        Mon, 28 Aug 2023 18:42:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C28B60919;
        Tue, 29 Aug 2023 01:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417C6C433C7;
        Tue, 29 Aug 2023 01:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1693273372;
        bh=ySDtmFK2AXh5NdWAFMXh5B38y71iqbeuVOnUIdpcz3Q=;
        h=Date:From:To:Cc:Subject:From;
        b=tgzMhVLEfzzgWUWMqY9X/fkpayBxUKsLmElhNwTZlkxxg17X7KjTcLwXOsZcqeysZ
         QhNIbOUccEvlEXILz6oscAixW+Gj3QC3E4eholdKM6HH7UxZ6RhBLq0XqGK2Yw4NAa
         UuN7gJ+nV4mMCLNifSnrP5M6HGCuA9D+Z/bxJ2Ck=
Date:   Mon, 28 Aug 2023 18:42:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] MM updates for 6.6-rc1
Message-Id: <20230828184251.bfbc164280503903eacf498c@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge the MM updates for this cycle,

I'm seeing one conflict at present, in arch/parisc/mm/ioremap.c.=20
Stephen resolved this by simply taking the mm.git version
(https://lkml.kernel.org/r/20230815100440.7e535779@canb.auug.org.au).


Forthcoming build issues (not flagged by a merging error):

tip tree, arch/powerpc/include/asm/book3s/64/pgtable.h:
https://lkml.kernel.org/r/20230815152951.4516ec0a@canb.auug.org.au


There are rather a lot of forthcoming merging issues, mainly trivial
stuff because some patches in here do a lot of Kconfig alteration.=20
These include:


parisc-hd tree, arch/parisc/kernel/smp.c:
https://lkml.kernel.org/r/20230628102248.742b79e1@canb.auug.org.au

cgroup tree, tools/testing/selftests/cgroup/.gitignore,
tools/testing/selftests/cgroup/Makefile:
https://lkml.kernel.org/r/20230711110734.7009339b@canb.auug.org.au

vfs-brauner tree, include/linux/shmem_fs.h:
https://lkml.kernel.org/r/20230714100205.35b99670@canb.auug.org.au

vfs-brauner tree, mm/shmem.c:
https://lkml.kernel.org/r/20230714102453.4399f059@canb.auug.org.au

s390 tree, arch/s390/Kconfig:
https://lkml.kernel.org/r/20230725094013.2dfb0168@canb.auug.org.au and
https://lkml.kernel.org/r/20230731093724.1c75858d@canb.auug.org.au

csky tree, arch/csky/abiv2/cacheflush.c:
https://lkml.kernel.org/r/20230815104604.54f65293@canb.auug.org.au

hid tree, .mailmap:
https://lkml.kernel.org/r/20230815115325.0d20b960@canb.auug.org.au

tip tree, arch/s390/Kconfig:
https://lkml.kernel.org/r/20230815141929.0c162def@canb.auug.org.au

arc-current tree, arch/arc/Kconfig:
https://lkml.kernel.org/r/20230822082841.7948474d@canb.auug.org.au and
https://lkml.kernel.org/r/20230822082841.7948474d@canb.auug.org.au

powerpc tree, arch/powerpc/Kconfig:
https://lkml.kernel.org/r/20230822101615.046f0c32@canb.auug.org.au and
https://lkml.kernel.org/r/20230822101615.046f0c32@canb.auug.org.au

nolibc tree, tools/include/nolibc/stdio.h:
https://lkml.kernel.org/r/20230817133053.76d9f850@canb.auug.org.au

openrisc tree, arch/openrisc/mm/ioremap.c:
https://lkml.kernel.org/r/20230825094405.22d29abf@canb.auug.org.au



Thanks.



The following changes since commit e5548f85b4527c4c803b7eae7887c10bf8f90c97:

  shmem: fix smaps BUG sleeping while atomic (2023-08-24 14:59:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2023=
-08-28-18-26

for you to fetch changes up to 52ae298e3e5c9be5bb95e1c6d9199e5210f2a156:

  maple_tree: shrink struct maple_tree (2023-08-24 16:20:32 -0700)

----------------------------------------------------------------
- Some swap cleanups from Ma Wupeng ("fix WARN_ON in add_to_avail_list")

- Peter Xu has a series (mm/gup: Unify hugetlb, speed up thp") which
  reduces the special-case code for handling hugetlb pages in GUP.  It
  also speeds up GUP handling of transparent hugepages.

- Peng Zhang provides some maple tree speedups ("Optimize the fast path
  of mas_store()").

- Sergey Senozhatsky has improved te performance of zsmalloc during
  compaction (zsmalloc: small compaction improvements").

- Domenico Cerasuolo has developed additional selftest code for zswap
  ("selftests: cgroup: add zswap test program").

- xu xin has doe some work on KSM's handling of zero pages.  These
  changes are mainly to enable the user to better understand the
  effectiveness of KSM's treatment of zero pages ("ksm: support tracking
  KSM-placed zero-pages").

- Jeff Xu has fixes the behaviour of memfd's
  MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED sysctl ("mm/memfd: fix sysctl
  MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED").

- David Howells has fixed an fscache optimization ("mm, netfs, fscache:
  Stop read optimisation when folio removed from pagecache").

- Axel Rasmussen has given userfaultfd the ability to simulate memory
  poisoning ("add UFFDIO_POISON to simulate memory poisoning with UFFD").

- Miaohe Lin has contributed some routine maintenance work on the
  memory-failure code ("mm: memory-failure: remove unneeded PageHuge()
  check").

- Peng Zhang has contributed some maintenance work on the maple tree
  code ("Improve the validation for maple tree and some cleanup").

- Hugh Dickins has optimized the collapsing of shmem or file pages into
  THPs ("mm: free retracted page table by RCU").

- Jiaqi Yan has a patch series which permits us to use the healthy
  subpages within a hardware poisoned huge page for general purposes
  ("Improve hugetlbfs read on HWPOISON hugepages").

- Kemeng Shi has done some maintenance work on the pagetable-check code
  ("Remove unused parameters in page_table_check").

- More folioification work from Matthew Wilcox ("More filesystem folio
  conversions for 6.6"), ("Followup folio conversions for zswap").  And
  from ZhangPeng ("Convert several functions in page_io.c to use a
  folio").

- page_ext cleanups from Kemeng Shi ("minor cleanups for page_ext").

- Baoquan He has converted some architectures to use the GENERIC_IOREMAP
  ioremap()/iounmap() code ("mm: ioremap: Convert architectures to take
  GENERIC_IOREMAP way").

- Anshuman Khandual has optimized arm64 tlb shootdown ("arm64: support
  batched/deferred tlb shootdown during page reclamation/migration").

- Better maple tree lockdep checking from Liam Howlett ("More strict
  maple tree lockdep").  Liam also developed some efficiency improvements
  ("Reduce preallocations for maple tree").

- Cleanup and optimization to the secondary IOMMU TLB invalidation, from
  Alistair Popple ("Invalidate secondary IOMMU TLB on permission
  upgrade").

- Ryan Roberts fixes some arm64 MM selftest issues ("selftests/mm fixes
  for arm64").

- Kemeng Shi provides some maintenance work on the compaction code ("Two
  minor cleanups for compaction").

- Some reduction in mmap_lock pressure from Matthew Wilcox ("Handle most
  file-backed faults under the VMA lock").

- Aneesh Kumar contributes code to use the vmemmap optimization for DAX
  on ppc64, under some circumstances ("Add support for DAX vmemmap
  optimization for ppc64").

- page-ext cleanups from Kemeng Shi ("add page_ext_data to get client
  data in page_ext"), ("minor cleanups to page_ext header").

- Some zswap cleanups from Johannes Weiner ("mm: zswap: three
  cleanups").

- kmsan cleanups from ZhangPeng ("minor cleanups for kmsan").

- VMA handling cleanups from Kefeng Wang ("mm: convert to
  vma_is_initial_heap/stack()").

- DAMON feature work from SeongJae Park ("mm/damon/sysfs-schemes:
  implement DAMOS tried total bytes file"), ("Extend DAMOS filters for
  address ranges and DAMON monitoring targets").

- Compaction work from Kemeng Shi ("Fixes and cleanups to compaction").

- Liam Howlett has improved the maple tree node replacement code
  ("maple_tree: Change replacement strategy").

- ZhangPeng has a general code cleanup - use the K() macro more widely
  ("cleanup with helper macro K()").

- Aneesh Kumar brings memmap-on-memory to ppc64 ("Add support for memmap
  on memory feature on ppc64").

- pagealloc cleanups from Kemeng Shi ("Two minor cleanups for pcp list
  in page_alloc"), ("Two minor cleanups for get pageblock migratetype").

- Vishal Moola introduces a memory descriptor for page table tracking,
  "struct ptdesc" ("Split ptdesc from struct page").

- memfd selftest maintenance work from Aleksa Sarai ("memfd: cleanups
  for vm.memfd_noexec").

- MM include file rationalization from Hugh Dickins ("arch: include
  asm/cacheflush.h in asm/hugetlb.h").

- THP debug output fixes from Hugh Dickins ("mm,thp: fix sloppy text
  output").

- kmemleak improvements from Xiaolei Wang ("mm/kmemleak: use
  object_cache instead of kmemleak_initialized").

- More folio-related cleanups from Matthew Wilcox ("Remove _folio_dtor
  and _folio_order").

- A VMA locking scalability improvement from Suren Baghdasaryan
  ("Per-VMA lock support for swap and userfaults").

- pagetable handling cleanups from Matthew Wilcox ("New page table range
  API").

- A batch of swap/thp cleanups from David Hildenbrand ("mm/swap: stop
  using page->private on tail pages for THP_SWAP + cleanups").

- Cleanups and speedups to the hugetlb fault handling from Matthew
  Wilcox ("Change calling convention for ->huge_fault").

- Matthew Wilcox has also done some maintenance work on the MM subsystem
  documentation ("Improve mm documentation").

----------------------------------------------------------------
Aleksa Sarai (5):
      selftests: memfd: error out test process when child test fails
      memfd: do not -EACCES old memfd_create() users with vm.memfd_noexec=
=3D2
      memfd: improve userspace warnings for missing exec-related flags
      memfd: replace ratcheting feature from vm.memfd_noexec with hierarchy
      selftests: improve vm.memfd_noexec sysctl tests

Alistair Popple (5):
      arm64/smmu: use TLBI ASID when invalidating entire range
      mmu_notifiers: fixup comment in mmu_interval_read_begin()
      mmu_notifiers: call invalidate_range() when invalidating TLBs
      mmu_notifiers: don't invalidate secondary TLBs as part of mmu_notifie=
r_invalidate_range_end()
      mmu_notifiers: rename invalidate_range notifier

Andrew Donnellan (1):
      lib/test_meminit: allocate pages up to order MAX_ORDER

Andrew Morton (3):
      mm-make-pte_marker_swapin_error-more-general-fix
      merge mm-hotfixes-stable into mm-stable to pick up depended-upon chan=
ges
      merge mm-hotfixes-stable into mm-stable to pick up depended-upon chan=
ges

Andrew Yang (1):
      fs: drop_caches: draining pages before dropping caches

Aneesh Kumar K.V (19):
      mm/hugepage pud: allow arch-specific helper function to check huge pa=
ge pud support
      mm: change pudp_huge_get_and_clear_full take vm_area_struct as arg
      mm/vmemmap: improve vmemmap_can_optimize and allow architectures to o=
verride
      mm/vmemmap: allow architectures to override how vmemmap optimization =
works
      mm: add pud_same similar to __HAVE_ARCH_P4D_SAME
      mm/huge pud: use transparent huge pud helpers only with CONFIG_TRANSP=
ARENT_HUGEPAGE
      mm/vmemmap optimization: split hugetlb and devdax vmemmap optimization
      powerpc/mm/trace: convert trace event to trace event class
      powerpc/book3s64/mm: enable transparent pud hugepage
      powerpc/book3s64/vmemmap: switch radix to use a different vmemmap han=
dling function
      powerpc/book3s64/radix: add support for vmemmap optimization for radix
      powerpc/book3s64/radix: remove mmu_vmemmap_psize
      powerpc/book3s64/radix: add debug message to give more details of vme=
mmap allocation
      mm/memory_hotplug: simplify ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE kconfig
      mm/memory_hotplug: allow memmap on memory hotplug request to fallback
      mm/memory_hotplug: allow architecture to override memmap on memory su=
pport check
      mm/memory_hotplug: support memmap_on_memory when memmap is not aligne=
d to pageblocks
      powerpc/book3s64/memhotplug: enable memmap on memory for radix
      mm/memory_hotplug: embed vmem_altmap details in memory block

Anh Tuan Phan (1):
      selftests/mm: fix WARNING comparing pointer to 0

Anshuman Khandual (1):
      mm/tlbbatch: introduce arch_tlbbatch_should_defer()

Arnd Bergmann (1):
      kernel/iomem.c: remove __weak ioremap_cache helper

Axel Rasmussen (8):
      mm: make PTE_MARKER_SWAPIN_ERROR more general
      mm: userfaultfd: check for start + len overflow in validate_range
      mm: userfaultfd: extract file size check out into a helper
      mm: userfaultfd: add new UFFDIO_POISON ioctl
      mm: userfaultfd: support UFFDIO_POISON for hugetlbfs
      mm: userfaultfd: document and enable new UFFDIO_POISON feature
      selftests/mm: refactor uffd_poll_thread to allow custom fault handlers
      selftests/mm: add uffd unit test for UFFDIO_POISON

Ayush Jain (1):
      selftests: mm: add KSM_MERGE_TIME tests

Baolin Wang (2):
      mm: compaction: use the correct type of list for free pages
      mm: compaction: skip the memory hole rapidly when isolating free pages

Baoquan He (16):
      asm-generic/iomap.h: remove ARCH_HAS_IOREMAP_xx macros
      hexagon: mm: convert to GENERIC_IOREMAP
      openrisc: mm: remove unneeded early ioremap code
      mm: ioremap: allow ARCH to have its own ioremap method definition
      mm/ioremap: add slab availability checking in ioremap_prot
      arc: mm: convert to GENERIC_IOREMAP
      ia64: mm: convert to GENERIC_IOREMAP
      openrisc: mm: convert to GENERIC_IOREMAP
      s390: mm: convert to GENERIC_IOREMAP
      sh: add <asm-generic/io.h> including
      sh: mm: convert to GENERIC_IOREMAP
      xtensa: mm: convert to GENERIC_IOREMAP
      parisc: mm: convert to GENERIC_IOREMAP
      mm: move is_ioremap_addr() into new header file
      arm64 : mm: add wrapper function ioremap_prot()
      mm: ioremap: remove unneeded ioremap_allowed and iounmap_allowed

Barry Song (2):
      mm/tlbbatch: rename and extend some functions
      arm64: support batched/deferred tlb shootdown during page reclamation=
/migration

Bean Huo (2):
      fs/buffer: clean up block_commit_write
      fs: convert block_commit_write to return void

Charan Teja Kalla (2):
      mm: madvise: fix uneven accounting of psi
      Multi-gen LRU: skip CMA pages when they are not eligible

Christophe Leroy (3):
      mm/ioremap: define generic_ioremap_prot() and generic_iounmap()
      mm/ioremap: consider IOREMAP space in generic ioremap
      powerpc: mm: convert to GENERIC_IOREMAP

David Hildenbrand (9):
      mm/memory_hotplug: document the signal_pending() check in offline_pag=
es()
      kvm: explicitly set FOLL_HONOR_NUMA_FAULT in hva_to_pfn_slow()
      mm/gup: don't implicitly set FOLL_HONOR_NUMA_FAULT
      pgtable: improve pte_protnone() comment
      selftest/mm: ksm_functional_tests: test in mmap_and_merge_range() if =
anything got merged
      selftest/mm: ksm_functional_tests: Add PROT_NONE test
      mm/swap: stop using page->private on tail pages for THP_SWAP
      mm/swap: inline folio_set_swap_entry() and folio_swap_entry()
      mm/huge_memory: work on folio->swap instead of page->private when spl=
itting folio

David Howells (2):
      mm: merge folio_has_private()/filemap_release_folio() call pairs
      mm, netfs, fscache: stop read optimisation when folio removed from pa=
gecache

Domenico Cerasuolo (3):
      selftests: cgroup: add test_zswap program
      selftests: cgroup: add test_zswap with no kmem bypass test
      selftests: cgroup: add zswap-memcg unwanted writeback test

Efly Young (1):
      mm:vmscan: fix inaccurate reclaim during proactive reclaim

Greg Kroah-Hartman (1):
      mm: no need to export mm_kobj

Haibo Li (1):
      mm/filemap.c: fix update prev_pos after one read request done

Haifeng Xu (2):
      mm/mm_init.c: mark check_for_memory() as __init
      mm/mm_init.c: drop node_start_pfn from adjust_zone_range_for_zone_mov=
able()

Helge Deller (1):
      nios2: fix flush_dcache_page() for usage from irq context

Hugh Dickins (21):
      mm: userfaultfd: add new UFFDIO_POISON ioctl: fix
      mm/pgtable: add rcu_read_lock() and rcu_read_unlock()s
      mm/pgtable: add PAE safety to __pte_offset_map()
      arm: adjust_pte() use pte_offset_map_nolock()
      powerpc: assert_pte_locked() use pte_offset_map_nolock()
      powerpc: add pte_free_defer() for pgtables sharing page
      sparc: add pte_free_defer() for pte_t *pgtable_t
      s390: add pte_free_defer() for pgtables sharing page
      mm/pgtable: add pte_free_defer() for pgtable as page
      mm/khugepaged: retract_page_tables() without mmap or vma lock
      mm/khugepaged: collapse_pte_mapped_thp() with mmap_read_lock()
      mm/khugepaged: delete khugepaged_collapse_pte_mapped_thps()
      mm: delete mmap_write_trylock() and vma_try_start_write()
      mm/pgtable: notes on pte_offset_map[_lock]()
      arm: include asm/cacheflush.h in asm/hugetlb.h
      arm64: include asm/cacheflush.h in asm/hugetlb.h
      riscv: include asm/cacheflush.h in asm/hugetlb.h
      mm,thp: no space after colon in Mem-Info fields
      mm,thp: fix nodeN/meminfo output alignment
      mm,thp: fix smaps THPeligible output alignment
      mm/khugepaged: fix collapse_pte_mapped_thp() versus uffd

Jann Horn (2):
      mm: don't drop VMA locks in mm_drop_all_locks()
      mm: userfaultfd: remove stale comment about core dump locking

Jeff Xu (2):
      mm/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
      selftests/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED

Jiaqi Yan (4):
      mm/hwpoison: delete all entries before traversal in __folio_free_raw_=
hwp
      mm/hwpoison: check if a raw page in a hugetlb folio is raw HWPOISON
      hugetlbfs: improve read HWPOISON hugepage
      selftests/mm: add tests for HWPOISON hugetlbfs read

Jinliang Zheng (1):
      writeback: remove redundant checks for root memcg

Johannes Weiner (4):
      mm: kill frontswap
      mm: zswap: use zswap_invalidate_entry() for duplicates
      mm: zswap: tighten up entry invalidation
      mm: zswap: kill zswap_get_swap_cache_page()

Kalesh Singh (3):
      Multi-gen LRU: fix per-zone reclaim
      Multi-gen LRU: avoid race in inc_min_seq()
      Multi-gen LRU: fix can_swap in lru_gen_look_around()

Kefeng Wang (10):
      mm: remove arguments of show_mem()
      mm: make show_free_areas() static
      mm: factor out VMA stack and heap checks
      drm/amdkfd: use vma_is_initial_stack() and vma_is_initial_heap()
      selinux: use vma_is_initial_stack() and vma_is_initial_heap()
      perf/core: use vma_is_initial_stack() and vma_is_initial_heap()
      mm: hugetlb: use flush_hugetlb_tlb_range() in move_hugetlb_page_table=
s()
      arm64: hugetlb: enable __HAVE_ARCH_FLUSH_HUGETLB_TLB_RANGE
      mm: memtest: convert to memtest_report_meminfo()
      pagemap: remove wait_on_page_locked_killable()

Kemeng Shi (37):
      mm: correct stale comment of function check_pte
      mm/page_table_check: remove unused parameters in page_table_check_cle=
ar()
      mm/page_table_check: remove unused parameters in page_table_check_set=
()
      mm/page_table_check: remove unused parameter in [__]page_table_check_=
pte_clear
      mm/page_table_check: remove unused parameter in [__]page_table_check_=
pmd_clear
      mm/page_table_check: remove unused parameter in [__]page_table_check_=
pud_clear
      mm/page_table_check: remove unused parameter in [__]page_table_check_=
pte_set
      mm/page_table_check: remove unused parameter in [__]page_table_check_=
pmd_set
      mm/page_table_check: remove unused parameter in [__]page_table_check_=
pud_set
      mm/page_ext: remove unused return value of offline_page_ext
      mm/page_ext: remove rollback for untouched mem_section in online_page=
_ext
      mm/page_ext: move functions around for minor cleanups to page_ext
      mm/rmap: correct stale comment of rmap_walk_anon and rmap_walk_file
      mm/compaction: correct comment of candidate pfn in fast_isolate_freep=
ages
      mm/compaction: avoid unneeded pageblock_end_pfn when no_set_skip_hint=
 is set
      mm/page_ext: add common function to get client data from page_ext
      mm/page_ext: use page_ext_data helper in page_table_check
      mm/page_ext: use page_ext_data helper in page_owner
      mm/page_poison: remove unused page_ext.h from page_poison
      mm/vmstat: remove unused page_ext.h from vmstat
      mm/page_ext: move page_ext_operations definition under CONFIG_PAGE_EX=
TENSION
      mm/compaction: set compact_cached_free_pfn correctly in update_pagebl=
ock_skip
      mm/compaction: merge end_pfn boundary check in isolate_freepages_range
      mm/compaction: remove unnecessary cursor page in isolate_freepages_bl=
ock
      mm/compaction: remove unnecessary "else continue" at end of loop in i=
solate_freepages_block
      mm/compaction: correct last_migrated_pfn update in compact_zone
      mm/compaction: skip page block marked skip in isolate_migratepages_bl=
ock
      mm/compaction: correct comment of fast_find_migrateblock in isolate_m=
igratepages
      mm/compaction: correct comment of cached migrate pfn update
      mm/compaction: correct comment to complete migration failure
      mm/compaction: remove unnecessary return for void function
      mm/compaction: only set skip flag if cc->no_set_skip_hint is false
      mm/page_alloc: remove track of active PCP lists range in bulk free
      mm/page_alloc: remove unnecessary parameter batch of nr_pcp_free
      mm/compaction: remove unused parameter pgdata of fragmentation_score_=
wmark
      mm/page_alloc: remove unnecessary inner __get_pfnblock_flags_mask
      mm/page_alloc: use get_pfnblock_migratetype to avoid extra page_to_pfn

Levi Yun (1):
      damon: use pmdp_get instead of drectly dereferencing pmd

Liam R. Howlett (26):
      mm/mmap: clean up validate_mm() calls
      maple_tree: relax lockdep checks for on-stack trees
      mm/mmap: change detached vma locking scheme
      maple_tree: Be more strict about locking
      maple_tree: add benchmarking for mas_for_each
      maple_tree: add benchmarking for mas_prev()
      mm: change do_vmi_align_munmap() tracking of VMAs to remove
      mm: remove prev check from do_vmi_align_munmap()
      maple_tree: introduce __mas_set_range()
      mm: remove re-walk from mmap_region()
      maple_tree: re-introduce entry to mas_preallocate() arguments
      maple_tree: adjust node allocation on mas_rebalance()
      mm: use vma_iter_clear_gfp() in nommu
      mm: set up vma iterator for vma_iter_prealloc() calls
      maple_tree: move mas_wr_end_piv() below mas_wr_extend_null()
      maple_tree: update mas_preallocate() testing
      maple_tree: refine mas_preallocate() node calculations
      maple_tree: reduce resets during store setup
      mm/mmap: change vma iteration order in do_vmi_align_munmap()
      maple_tree: add hex output to maple_arange64 dump
      maple_tree: reorder replacement of nodes to avoid live lock
      maple_tree: introduce mas_put_in_tree()
      maple_tree: introduce mas_tree_parent() definition
      maple_tree: change mas_adopt_children() parent usage
      maple_tree: replace data before marking dead in split and spanning st=
ore
      maple_tree: clean up mas_wr_append()

Lu Jialin (1):
      memcg: remove duplication detection for mem_cgroup_uncharge_swap

Lucas Karpinski (1):
      selftests: cgroup: fix test_kmem_memcg_deletion kernel mem check

Ma Wupeng (3):
      swap: cleanup duplicated WARN_ON in add_to_avail_list
      swap: stop add to avail list if swap is full
      mm: disable kernelcore=3Dmirror when no mirror memory

Mateusz Guzik (2):
      mm: move dummy_vm_ops out of a header
      maple_tree: shrink struct maple_tree

Matthew Wilcox (3):
      mm: improve the comment in isolate_migratepages_block()
      mm/memory.c: fix mismerge
      mm/swap: use dedicated entry for swap in folio

Matthew Wilcox (Oracle) (80):
      rmap: pass the folio to __page_check_anon_rmap()
      highmem: add memcpy_to_folio() and memcpy_from_folio()
      affs: convert affs_symlink_read_folio() to use the folio
      affs: convert data read and write to use folios
      migrate: use folio_set_bh() instead of set_bh_page()
      ntfs3: convert ntfs_get_block_vbo() to use a folio
      jbd2: use a folio in jbd2_journal_write_metadata_buffer()
      buffer: remove set_bh_page()
      mm: remove CONFIG_PER_VMA_LOCK ifdefs
      mm: allow per-VMA locks on file-backed VMAs
      mm: move FAULT_FLAG_VMA_LOCK check from handle_mm_fault()
      mm: handle PUD faults under the VMA lock
      mm: handle some PMD faults under the VMA lock
      mm: move FAULT_FLAG_VMA_LOCK check down in handle_pte_fault()
      mm: move FAULT_FLAG_VMA_LOCK check down from do_fault()
      mm: run the fault-around code under the VMA lock
      mm: handle swap and NUMA PTE faults under the VMA lock
      mm: handle faults that merely update the accessed bit under the VMA l=
ock
      zswap: make zswap_store() take a folio
      memcg: convert get_obj_cgroup_from_page to get_obj_cgroup_from_folio
      swap: remove some calls to compound_head() in swap_readpage()
      zswap: make zswap_load() take a folio
      mm: allow fault_dirty_shared_page() to be called under the VMA lock
      io_uring: stop calling free_compound_page()
      mm: call free_huge_page() directly
      mm: convert free_huge_page() to free_huge_folio()
      mm: convert free_transhuge_folio() to folio_undo_large_rmappable()
      mm: convert prep_transhuge_page() to folio_prep_large_rmappable()
      mm: remove free_compound_page() and the compound_page_dtors array
      mm: remove HUGETLB_PAGE_DTOR
      mm: add large_rmappable page flag
      mm: rearrange page flags
      mm: free up a word in the first tail page
      mm: remove folio_test_transhuge()
      mm: add tail private fields to struct folio
      mm: convert split_huge_pages_pid() to use a folio
      minmax: add in_range() macro
      mm: convert page_table_check_pte_set() to page_table_check_ptes_set()
      mm: add generic flush_icache_pages() and documentation
      mm: add folio_flush_mapping()
      mm: remove ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
      mm: add default definition of set_ptes()
      alpha: implement the new page table range API
      arc: implement the new page table range API
      arm: implement the new page table range API
      arm64: implement the new page table range API
      csky: implement the new page table range API
      hexagon: implement the new page table range API
      ia64: implement the new page table range API
      loongarch: implement the new page table range API
      m68k: implement the new page table range API
      microblaze: implement the new page table range API
      mips: implement the new page table range API
      nios2: implement the new page table range API
      openrisc: implement the new page table range API
      parisc: implement the new page table range API
      powerpc: implement the new page table range API
      riscv: implement the new page table range API
      s390: implement the new page table range API
      sh: implement the new page table range API
      sparc32: implement the new page table range API
      sparc64: implement the new page table range API
      um: implement the new page table range API
      x86: implement the new page table range API
      xtensa: implement the new page table range API
      mm: remove page_mapping_file()
      mm: rationalise flush_icache_pages() and flush_icache_page()
      mm: tidy up set_ptes definition
      mm: use flush_icache_pages() in do_set_pmd()
      mm: call update_mmu_cache_range() in more page fault handling paths
      mm: remove checks for pte_index
      mm: move PMD_ORDER to pgtable.h
      mm: allow ->huge_fault() to be called without the mmap_lock held
      mm: remove enum page_entry_size
      mm: fix kernel-doc warning from tlb_flush_rmaps()
      mm: fix get_mctgt_type() kernel-doc
      mm: fix clean_record_shared_mapping_range kernel-doc
      mm: add orphaned kernel-doc to the rst files.
      hugetlb: add documentation for vma_kernel_pagesize()
      secretmem: convert page_is_secretmem() to folio_is_secretmem()

Miaohe Lin (31):
      mm/mm_init.c: update obsolete comment in get_pfn_range_for_nid()
      mm: memory-failure: remove unneeded page state check in shake_page()
      memory tier: use helper function destroy_memory_type()
      mm: memory-failure: remove unneeded 'inline' annotation
      mm/mm_init.c: remove obsolete macro HASH_SMALL
      mm: page_alloc: avoid false page outside zone error info
      memory tier: rename destroy_memory_type() to put_memory_type()
      mm: remove obsolete comment above struct per_cpu_pages
      mm/memcg: minor cleanup for MEM_CGROUP_ID_MAX
      mm: memory-failure: remove unneeded PageHuge() check
      mm: memory-failure: ensure moving HWPoison flag to the raw error pages
      mm: memory-failure: don't account hwpoison_filter() filtered pages
      mm: memory-failure: use local variable huge to check hugetlb page
      mm: memory-failure: remove unneeded header files
      mm: memory-failure: minor cleanup for comments and codestyle
      mm: memory-failure: fetch compound head after extra page refcnt is he=
ld
      mm: memory-failure: fix race window when trying to get hugetlb folio
      mm/huge_memory: use RMAP_NONE when calling page_add_anon_rmap()
      mm/memcg: fix obsolete comment above MEM_CGROUP_MAX_RECLAIM_LOOPS
      mm/memcg: minor cleanup for mc_handle_present_pte()
      memory tier: use helper macro __ATTR_RW()
      mm: fix obsolete function name above debug_pagealloc_enabled_static()
      mm/mprotect: fix obsolete function name in change_pte_range()
      mm/memcg: fix obsolete function name in mem_cgroup_protection()
      mm/page_alloc: avoid unneeded alike_pages calculation
      mm/memcg: update obsolete comment above parent_mem_cgroup()
      mm/page_alloc: remove unneeded variable base
      mm/memcg: fix wrong function name above obj_cgroup_charge_zswap()
      mm: memory-failure: use helper macro llist_for_each_entry_safe()
      mm/mm_init: use helper macro BITS_PER_LONG and BITS_PER_BYTE
      mm: memory-failure: fix potential page refcnt leak in memory_failure()

Michal Hocko (1):
      memcg: drop kmem.limit_in_bytes

Mika Penttil=E4 (1):
      mm/migrate_device: try to handle swapcache pages

Mike Kravetz (1):
      hugetlb: clear flags in tail pages that will be freed individually

Mike Rapoport (IBM) (2):
      maple_tree: mtree_insert*: fix typo in kernel-doc description
      maple_tree: mtree_insert: fix typo in kernel-doc description of GFP f=
lags

Minchan Kim (1):
      zsmalloc: remove zs_compact_control

Muchun Song (1):
      mm: hugetlb_vmemmap: fix a race between vmemmap pmd split

Peng Zhang (12):
      maple_tree: add test for mas_wr_modify() fast path
      maple_tree: add test for expanding range in RCU mode
      maple_tree: optimize mas_wr_append(), also improve duplicating VMAs
      maple_tree: add a fast path case in mas_wr_slot_store()
      maple_tree: don't use MAPLE_ARANGE64_META_MAX to indicate no gap
      maple_tree: make mas_validate_gaps() to check metadata
      maple_tree: fix mas_validate_child_slot() to check last missed slot
      maple_tree: make mas_validate_limits() check root node and node limit
      maple_tree: update mt_validate()
      maple_tree: replace mas_logical_pivot() with mas_safe_pivot()
      maple_tree: drop mas_first_entry()
      mm: kfence: allocate kfence_metadata at runtime

Peter Collingbourne (2):
      mm: call arch_swap_restore() from unuse_pte()
      arm64: mte: simplify swap tag restoration logic

Peter Xu (8):
      mm/hugetlb: handle FOLL_DUMP well in follow_page_mask()
      mm/hugetlb: prepare hugetlb_follow_page_mask() for FOLL_PIN
      mm/hugetlb: add page_mask for hugetlb_follow_page_mask()
      mm/gup: cleanup next_page handling
      mm/gup: accelerate thp gup even for "pages !=3D NULL"
      mm/gup: retire follow_hugetlb_page()
      selftests/mm: add -a to run_vmtests.sh
      selftests/mm: add gup test matrix in run_vmtests.sh

Pintu Kumar (1):
      mm: cma: print cma name as well in cma_alloc debug

Qi Zheng (1):
      arm64: mm: use ptep_clear() instead of pte_clear() in clear_flush()

Randy Dunlap (1):
      HWPOISON: offline support: fix spelling in Documentation/ABI/

Rong Tao (1):
      selftests/mm: fix uffd-stress help information

Ruan Jinjie (1):
      mm/z3fold: use helper function put_z3fold_locked() and put_z3fold_loc=
ked_list()

Ryan Roberts (8):
      selftests: line buffer test program's stdout
      selftests/mm: skip soft-dirty tests on arm64
      selftests/mm: enable mrelease_test for arm64
      selftests/mm: fix thuge-gen test bugs
      selftests/mm: va_high_addr_switch should skip unsupported arm64 confi=
gs
      selftests/mm: make migration test robust to failure
      selftests/mm: optionally pass duration to transhuge-stress
      selftests/mm: run all tests from run_vmtests.sh

Sebastian Andrzej Siewior (1):
      mm/page_alloc: use write_seqlock_irqsave() instead write_seqlock() + =
local_irq_save().

SeongJae Park (19):
      mm/damon/core-test: add a test for damos_new_filter()
      mm/damon/sysfs-schemes: implement DAMOS tried total bytes file
      mm/damon/sysfs: implement a command for updating only schemes tried t=
otal bytes
      selftests/damon/sysfs: test tried_regions/total_bytes file
      Docs/ABI/damon: update for tried_regions/total_bytes
      Docs/admin-guide/mm/damon/usage: update for tried_regions/total_bytes
      mm/damon/core: introduce address range type damos filter
      mm/damon/sysfs-schemes: support address range type DAMOS filter
      mm/damon/core-test: add a unit test for __damos_filter_out()
      selftests/damon/sysfs: test address range damos filter
      Docs/mm/damon/design: update for address range filters
      Docs/ABI/damon: update for address range DAMOS filter
      Docs/admin-guide/mm/damon/usage: update for address range type DAMOS =
filter
      mm/damon/core: implement target type damos filter
      mm/damon/sysfs-schemes: support target damos filter
      selftests/damon/sysfs: test damon_target filter
      Docs/mm/damon/design: update for DAMON monitoring target type DAMOS f=
ilter
      Docs/ABI/damon: update for DAMON monitoring target type DAMOS filter
      Docs/admin-guide/mm/damon/usage: update for DAMON monitoring target t=
ype DAMOS filter

Sergey Senozhatsky (3):
      zsmalloc: do not scan for allocated objects in empty zspage
      zsmalloc: move migration destination zspage inuse check
      zsmalloc: remove obj_tagged()

Sidhartha Kumar (7):
      mm: increase usage of folio_next_index() helper
      mm/memory: convert do_page_mkwrite() to use folios
      mm/memory: convert wp_page_shared() to use folios
      mm/memory: convert do_shared_fault() to folios
      mm/memory: convert do_read_fault() to use folios
      mm/memory: pass folio into do_page_mkwrite()
      mm/hugetlb: get rid of page_hstate()

Stefan Roesch (1):
      mm/ksm: add pages scanned metric

Suren Baghdasaryan (11):
      mm: for !CONFIG_PER_VMA_LOCK equate write lock assertion for vma and =
mmap
      mm: replace mmap with vma write lock assertions when operating on a v=
ma
      mm: lock vma explicitly before doing vm_flags_reset and vm_flags_rese=
t_once
      mm: always lock new vma before inserting into vma tree
      mm: move vma locking out of vma_prepare and dup_anon_vma
      swap: remove remnants of polling from read_swap_cache_async
      mm: add missing VM_FAULT_RESULT_TRACE name for VM_FAULT_COMPLETED
      mm: drop per-VMA lock when returning VM_FAULT_RETRY or VM_FAULT_COMPL=
ETED
      mm: change folio_lock_or_retry to use vm_fault directly
      mm: handle swap page faults under per-VMA lock
      mm: handle userfaults under VMA lock

Thomas Gleixner (1):
      maple_tree: fix a few documentation issues

Thomas Wei=DFschuh (1):
      mm: make MEMFD_CREATE into a selectable config option

Vishal Moola (Oracle) (31):
      mm: add PAGE_TYPE_OP folio functions
      pgtable: create struct ptdesc
      mm: add utility functions for ptdesc
      mm: convert pmd_pgtable_page() callers to use pmd_ptdesc()
      mm: convert ptlock_alloc() to use ptdescs
      mm: convert ptlock_ptr() to use ptdescs
      mm: convert pmd_ptlock_init() to use ptdescs
      mm: convert ptlock_init() to use ptdescs
      mm: convert pmd_ptlock_free() to use ptdescs
      mm: convert ptlock_free() to use ptdescs
      mm: create ptdesc equivalents for pgtable_{pte,pmd}_page_{ctor,dtor}
      powerpc: convert various functions to use ptdescs
      x86: convert various functions to use ptdescs
      s390: convert various pgalloc functions to use ptdescs
      mm: remove page table members from struct page
      pgalloc: convert various functions to use ptdescs
      arm: convert various functions to use ptdescs
      arm64: convert various functions to use ptdescs
      csky: convert __pte_free_tlb() to use ptdescs
      hexagon: convert __pte_free_tlb() to use ptdescs
      loongarch: convert various functions to use ptdescs
      m68k: convert various functions to use ptdescs
      mips: convert various functions to use ptdescs
      nios2: convert __pte_free_tlb() to use ptdescs
      openrisc: convert __pte_free_tlb() to use ptdescs
      riscv: convert alloc_{pmd, pte}_late() to use ptdescs
      sh: convert pte_free_tlb() to use ptdescs
      sparc64: convert various functions to use ptdescs
      sparc: convert pgtable_pte_page_{ctor, dtor}() to ptdesc equivalents
      um: convert {pmd, pte}_free_tlb() to use ptdescs
      mm: remove pgtable_{pmd, pte}_page_{ctor, dtor}() wrappers

Xiaolei Wang (2):
      mm/kmemleak: use object_cache instead of kmemleak_initialized to chec=
k in set_track_prepare()
      Rename kmemleak_initialized to kmemleak_late_initialized

Xiu Jianfeng (3):
      mm: zswap: update comment for struct zswap_entry
      mm/z3fold: remove obsolete comment for struct z3fold_pool
      writeback: remove unused delaration of bdi_async_bio_wq

Xueshi Hu (1):
      mm: remove clear_page_idle()

Yang Li (2):
      mm: fix some kernel-doc comments
      mm/memory.c: fix some kernel-doc comments

Yicong Yang (2):
      mm/tlbbatch: introduce arch_flush_tlb_batched_pending()
      arm64: tlbflush: add some comments for TLB batched flushing

Yin Fengwei (4):
      filemap: add filemap_map_folio_range()
      rmap: add folio_add_file_rmap_range()
      mm: convert do_set_pte() to set_pte_range()
      filemap: batch PTE mappings

Yosry Ahmed (2):
      mm: zswap: multiple zpools support
      mm: memcg: use rstat for non-hierarchical stats

Yu Ma (1):
      mm/mmap: move vma operations to mm_struct out of the critical section=
 of file mapping lock

ZhangPeng (24):
      mm: use a folio in fault_dirty_shared_page()
      mm: remove page_rmapping()
      mm/page_io: remove unneeded ClearPageUptodate()
      mm/page_io: remove unneeded SetPageError()
      mm/page_io: introduce bio_first_folio_all()
      mm/page_io: use a folio in __end_swap_bio_write()
      mm/page_io: use a folio in __end_swap_bio_read()
      mm/page_io: use a folio in sio_read_complete()
      mm/page_io: use a folio in swap_writepage_bdev_sync()
      mm/page_io: use a folio in swap_writepage_bdev_async()
      mm/page_io: convert count_swpout_vm_event() to take in a folio
      mm/page_io: convert bio_associate_blkg_from_page() to take in a folio
      mm: kmsan: use helper function page_size()
      mm: kmsan: use helper macro offset_in_page()
      mm: kmsan: use helper macros PAGE_ALIGN and PAGE_ALIGN_DOWN
      mm: remove redundant K() macro definition
      mm/swapfile.c: use helper macro K()
      mm/swap_state.c: use helper macro K()
      mm/shmem.c: use helper macro K()
      mm/nommu.c: use helper macro K()
      mm/mmap.c: use helper macro K()
      mm/hugetlb.c: use helper macro K()
      mm: page_alloc: remove unused parameter from reserve_highatomic_pageb=
lock()
      mm/secretmem: use a folio in secretmem_fault()

Zhu, Lipeng (1):
      fs/address_space: add alignment padding for i_map and i_mmap_rwsem to=
 mitigate a false sharing.

liuq (2):
      mm/page_alloc: fix min_free_kbytes calculation regarding ZONE_MOVABLE
      mm/sparse: remove redundant judgments from macro for_each_present_sec=
tion_nr

xu xin (5):
      ksm: support unsharing KSM-placed zero pages
      ksm: count all zero pages placed by KSM
      ksm: add ksm zero pages for each process
      ksm: consider KSM-placed zeropages when calculating KSM profit
      selftest: add a testcase of ksm zero pages

 Documentation/ABI/testing/sysfs-kernel-mm-damon    |   40 +-
 .../ABI/testing/sysfs-memory-page-offline          |    4 +-
 Documentation/admin-guide/cgroup-v1/memory.rst     |    2 -
 Documentation/admin-guide/kdump/vmcoreinfo.rst     |   14 +-
 Documentation/admin-guide/mm/damon/usage.rst       |   76 +-
 Documentation/admin-guide/mm/ksm.rst               |   27 +-
 Documentation/admin-guide/mm/memory-hotplug.rst    |   14 +-
 Documentation/admin-guide/mm/userfaultfd.rst       |   15 +
 Documentation/admin-guide/mm/zswap.rst             |   14 +-
 Documentation/block/biovecs.rst                    |    1 +
 Documentation/core-api/cachetlb.rst                |   55 +-
 Documentation/core-api/mm-api.rst                  |   25 +
 Documentation/features/vm/TLB/arch-support.txt     |    2 +-
 Documentation/filesystems/locking.rst              |   38 +-
 Documentation/filesystems/porting.rst              |   11 +
 Documentation/mm/damon/design.rst                  |   24 +-
 Documentation/mm/frontswap.rst                     |  264 -----
 Documentation/mm/highmem.rst                       |    1 +
 Documentation/mm/hugetlbfs_reserv.rst              |   14 +-
 Documentation/mm/index.rst                         |    1 -
 Documentation/mm/split_page_table_lock.rst         |   12 +-
 Documentation/mm/vmemmap_dedup.rst                 |    1 +
 Documentation/mm/zsmalloc.rst                      |    5 +
 Documentation/powerpc/index.rst                    |    1 +
 Documentation/powerpc/vmemmap_dedup.rst            |  101 ++
 Documentation/translations/zh_CN/mm/frontswap.rst  |  196 ----
 .../translations/zh_CN/mm/hugetlbfs_reserv.rst     |    4 +-
 Documentation/translations/zh_CN/mm/index.rst      |    1 -
 .../zh_CN/mm/split_page_table_lock.rst             |   14 +-
 MAINTAINERS                                        |    8 -
 arch/alpha/include/asm/cacheflush.h                |   13 +-
 arch/alpha/include/asm/pgtable.h                   |   10 +-
 arch/arc/Kconfig                                   |    1 +
 arch/arc/include/asm/cacheflush.h                  |   14 +-
 arch/arc/include/asm/io.h                          |    7 +-
 arch/arc/include/asm/pgtable-bits-arcv2.h          |   12 +-
 arch/arc/include/asm/pgtable-levels.h              |    1 +
 arch/arc/mm/cache.c                                |   61 +-
 arch/arc/mm/ioremap.c                              |   49 +-
 arch/arc/mm/tlb.c                                  |   18 +-
 arch/arm/include/asm/cacheflush.h                  |   29 +-
 arch/arm/include/asm/hugetlb.h                     |    1 +
 arch/arm/include/asm/pgtable.h                     |    5 +-
 arch/arm/include/asm/tlb.h                         |   12 +-
 arch/arm/include/asm/tlbflush.h                    |   14 +-
 arch/arm/mm/copypage-v4mc.c                        |    5 +-
 arch/arm/mm/copypage-v6.c                          |    5 +-
 arch/arm/mm/copypage-xscale.c                      |    5 +-
 arch/arm/mm/dma-mapping.c                          |   28 +-
 arch/arm/mm/fault-armv.c                           |   19 +-
 arch/arm/mm/flush.c                                |   99 +-
 arch/arm/mm/mm.h                                   |    2 +-
 arch/arm/mm/mmu.c                                  |   21 +-
 arch/arm/mm/nommu.c                                |    6 +
 arch/arm/mm/pageattr.c                             |    6 +-
 arch/arm64/Kconfig                                 |    5 +-
 arch/arm64/include/asm/cacheflush.h                |    4 +-
 arch/arm64/include/asm/hugetlb.h                   |   16 +
 arch/arm64/include/asm/io.h                        |    3 +-
 arch/arm64/include/asm/mte.h                       |    4 +-
 arch/arm64/include/asm/pgtable.h                   |   48 +-
 arch/arm64/include/asm/tlb.h                       |   14 +-
 arch/arm64/include/asm/tlbbatch.h                  |   12 +
 arch/arm64/include/asm/tlbflush.h                  |   64 +-
 arch/arm64/kernel/mte.c                            |   37 +-
 arch/arm64/mm/fault.c                              |    5 +-
 arch/arm64/mm/flush.c                              |   36 +-
 arch/arm64/mm/hugetlbpage.c                        |    2 +-
 arch/arm64/mm/ioremap.c                            |   10 +-
 arch/arm64/mm/mmu.c                                |    7 +-
 arch/arm64/mm/mteswap.c                            |    5 +-
 arch/csky/abiv1/cacheflush.c                       |   32 +-
 arch/csky/abiv1/inc/abi/cacheflush.h               |    3 +-
 arch/csky/abiv2/cacheflush.c                       |   32 +-
 arch/csky/abiv2/inc/abi/cacheflush.h               |   11 +-
 arch/csky/include/asm/pgalloc.h                    |    4 +-
 arch/csky/include/asm/pgtable.h                    |    8 +-
 arch/hexagon/Kconfig                               |    1 +
 arch/hexagon/include/asm/cacheflush.h              |   10 +-
 arch/hexagon/include/asm/io.h                      |   11 +-
 arch/hexagon/include/asm/pgalloc.h                 |    8 +-
 arch/hexagon/include/asm/pgtable.h                 |    9 +-
 arch/hexagon/kernel/hexagon_ksyms.c                |    2 -
 arch/hexagon/mm/Makefile                           |    2 +-
 arch/hexagon/mm/ioremap.c                          |   44 -
 arch/ia64/Kconfig                                  |    1 +
 arch/ia64/hp/common/sba_iommu.c                    |   30 +-
 arch/ia64/include/asm/cacheflush.h                 |   14 +-
 arch/ia64/include/asm/io.h                         |   13 +-
 arch/ia64/include/asm/pgtable.h                    |    4 +-
 arch/ia64/mm/init.c                                |   32 +-
 arch/ia64/mm/ioremap.c                             |   41 +-
 arch/loongarch/Kconfig                             |    2 +-
 arch/loongarch/include/asm/cacheflush.h            |    1 -
 arch/loongarch/include/asm/io.h                    |    2 -
 arch/loongarch/include/asm/pgalloc.h               |   27 +-
 arch/loongarch/include/asm/pgtable-bits.h          |    4 +-
 arch/loongarch/include/asm/pgtable.h               |   33 +-
 arch/loongarch/mm/pgtable.c                        |    9 +-
 arch/loongarch/mm/tlb.c                            |    2 +-
 arch/m68k/include/asm/cacheflush_mm.h              |   26 +-
 arch/m68k/include/asm/io_mm.h                      |    2 -
 arch/m68k/include/asm/kmap.h                       |    2 -
 arch/m68k/include/asm/mcf_pgalloc.h                |   47 +-
 arch/m68k/include/asm/mcf_pgtable.h                |    1 +
 arch/m68k/include/asm/motorola_pgtable.h           |    1 +
 arch/m68k/include/asm/pgtable_mm.h                 |   10 +-
 arch/m68k/include/asm/sun3_pgalloc.h               |    8 +-
 arch/m68k/include/asm/sun3_pgtable.h               |    1 +
 arch/m68k/mm/motorola.c                            |    6 +-
 arch/microblaze/include/asm/cacheflush.h           |    8 +
 arch/microblaze/include/asm/pgtable.h              |   15 +-
 arch/microblaze/include/asm/tlbflush.h             |    4 +-
 arch/mips/bcm47xx/prom.c                           |    2 +-
 arch/mips/include/asm/cacheflush.h                 |   32 +-
 arch/mips/include/asm/io.h                         |    5 +-
 arch/mips/include/asm/pgalloc.h                    |   32 +-
 arch/mips/include/asm/pgtable-32.h                 |   10 +-
 arch/mips/include/asm/pgtable-64.h                 |    6 +-
 arch/mips/include/asm/pgtable-bits.h               |    6 +-
 arch/mips/include/asm/pgtable.h                    |   63 +-
 arch/mips/mm/c-r4k.c                               |    5 +-
 arch/mips/mm/cache.c                               |   56 +-
 arch/mips/mm/init.c                                |   21 +-
 arch/mips/mm/pgtable-32.c                          |    2 +-
 arch/mips/mm/pgtable-64.c                          |    2 +-
 arch/mips/mm/pgtable.c                             |    8 +-
 arch/mips/mm/tlbex.c                               |    2 +-
 arch/nios2/include/asm/cacheflush.h                |   10 +-
 arch/nios2/include/asm/pgalloc.h                   |    8 +-
 arch/nios2/include/asm/pgtable.h                   |   28 +-
 arch/nios2/mm/cacheflush.c                         |   84 +-
 arch/openrisc/Kconfig                              |    1 +
 arch/openrisc/include/asm/cacheflush.h             |    8 +-
 arch/openrisc/include/asm/io.h                     |   11 +-
 arch/openrisc/include/asm/pgalloc.h                |    8 +-
 arch/openrisc/include/asm/pgtable.h                |   15 +-
 arch/openrisc/mm/cache.c                           |   12 +-
 arch/openrisc/mm/ioremap.c                         |   82 --
 arch/parisc/Kconfig                                |    1 +
 arch/parisc/include/asm/cacheflush.h               |   14 +-
 arch/parisc/include/asm/io.h                       |   15 +-
 arch/parisc/include/asm/pgtable.h                  |   37 +-
 arch/parisc/kernel/cache.c                         |  107 +-
 arch/parisc/mm/ioremap.c                           |   62 +-
 arch/powerpc/Kconfig                               |    3 +
 arch/powerpc/include/asm/book3s/32/pgtable.h       |    5 -
 arch/powerpc/include/asm/book3s/64/hash.h          |    9 +
 arch/powerpc/include/asm/book3s/64/pgtable.h       |  161 ++-
 arch/powerpc/include/asm/book3s/64/radix.h         |   49 +
 .../powerpc/include/asm/book3s/64/tlbflush-radix.h |    2 +
 arch/powerpc/include/asm/book3s/64/tlbflush.h      |    9 +
 arch/powerpc/include/asm/book3s/pgtable.h          |   11 +-
 arch/powerpc/include/asm/cacheflush.h              |   14 +-
 arch/powerpc/include/asm/io.h                      |   17 +-
 arch/powerpc/include/asm/kvm_ppc.h                 |   10 +-
 arch/powerpc/include/asm/nohash/pgtable.h          |   16 +-
 arch/powerpc/include/asm/pgalloc.h                 |    4 +
 arch/powerpc/include/asm/pgtable.h                 |   39 +-
 arch/powerpc/kvm/book3s_hv_uvmem.c                 |    1 +
 arch/powerpc/mm/book3s64/hash_pgtable.c            |    2 +-
 arch/powerpc/mm/book3s64/hash_utils.c              |   11 +-
 arch/powerpc/mm/book3s64/mmu_context.c             |   10 +-
 arch/powerpc/mm/book3s64/pgtable.c                 |  110 +-
 arch/powerpc/mm/book3s64/radix_hugetlbpage.c       |    1 +
 arch/powerpc/mm/book3s64/radix_pgtable.c           |  574 +++++++++-
 arch/powerpc/mm/book3s64/radix_tlb.c               |   11 +
 arch/powerpc/mm/cacheflush.c                       |   41 +-
 arch/powerpc/mm/fault.c                            |    7 +-
 arch/powerpc/mm/init_64.c                          |   37 +-
 arch/powerpc/mm/ioremap.c                          |   26 +-
 arch/powerpc/mm/ioremap_32.c                       |   19 +-
 arch/powerpc/mm/ioremap_64.c                       |   12 +-
 arch/powerpc/mm/nohash/e500_hugetlbpage.c          |    3 +-
 arch/powerpc/mm/pgtable-frag.c                     |   73 +-
 arch/powerpc/mm/pgtable.c                          |   61 +-
 arch/powerpc/platforms/Kconfig.cputype             |    1 +
 arch/powerpc/platforms/pseries/hotplug-memory.c    |    2 +-
 arch/powerpc/xmon/xmon.c                           |    2 +-
 arch/riscv/Kconfig                                 |    2 +-
 arch/riscv/include/asm/cacheflush.h                |   19 +-
 arch/riscv/include/asm/hugetlb.h                   |    1 +
 arch/riscv/include/asm/pgalloc.h                   |    8 +-
 arch/riscv/include/asm/pgtable.h                   |   47 +-
 arch/riscv/mm/cacheflush.c                         |   13 +-
 arch/riscv/mm/fault.c                              |    7 +-
 arch/riscv/mm/init.c                               |   16 +-
 arch/s390/Kconfig                                  |    3 +-
 arch/s390/include/asm/io.h                         |   21 +-
 arch/s390/include/asm/pgalloc.h                    |    8 +-
 arch/s390/include/asm/pgtable.h                    |   33 +-
 arch/s390/include/asm/tlb.h                        |    4 +-
 arch/s390/mm/fault.c                               |    5 +-
 arch/s390/mm/pgalloc.c                             |  176 ++--
 arch/s390/pci/pci.c                                |   57 +-
 arch/sh/Kconfig                                    |    1 +
 arch/sh/include/asm/cacheflush.h                   |   21 +-
 arch/sh/include/asm/io.h                           |   89 +-
 arch/sh/include/asm/io_noioport.h                  |    7 -
 arch/sh/include/asm/pgalloc.h                      |    9 +-
 arch/sh/include/asm/pgtable.h                      |    7 +-
 arch/sh/include/asm/pgtable_32.h                   |    5 +-
 arch/sh/mm/cache-j2.c                              |    4 +-
 arch/sh/mm/cache-sh4.c                             |   26 +-
 arch/sh/mm/cache-sh7705.c                          |   26 +-
 arch/sh/mm/cache.c                                 |   52 +-
 arch/sh/mm/ioremap.c                               |   65 +-
 arch/sh/mm/kmap.c                                  |    3 +-
 arch/sparc/include/asm/cacheflush_32.h             |   10 +-
 arch/sparc/include/asm/cacheflush_64.h             |   19 +-
 arch/sparc/include/asm/pgalloc_64.h                |    4 +
 arch/sparc/include/asm/pgtable_32.h                |    8 +-
 arch/sparc/include/asm/pgtable_64.h                |   29 +-
 arch/sparc/kernel/setup_32.c                       |    2 +-
 arch/sparc/kernel/smp_64.c                         |   56 +-
 arch/sparc/mm/init_32.c                            |   13 +-
 arch/sparc/mm/init_64.c                            |  111 +-
 arch/sparc/mm/srmmu.c                              |    5 +-
 arch/sparc/mm/tlb.c                                |    5 +-
 arch/um/include/asm/pgalloc.h                      |   18 +-
 arch/um/include/asm/pgtable.h                      |    7 +-
 arch/x86/Kconfig                                   |    7 +-
 arch/x86/include/asm/io.h                          |    5 -
 arch/x86/include/asm/pgtable.h                     |   28 +-
 arch/x86/include/asm/tlbflush.h                    |   24 +-
 arch/x86/mm/fault.c                                |    7 +-
 arch/x86/mm/pgtable.c                              |   47 +-
 arch/x86/mm/tlb.c                                  |    2 +
 arch/x86/xen/mmu_pv.c                              |    2 +-
 arch/xtensa/Kconfig                                |    1 +
 arch/xtensa/include/asm/cacheflush.h               |   11 +-
 arch/xtensa/include/asm/io.h                       |   32 +-
 arch/xtensa/include/asm/pgtable.h                  |   18 +-
 arch/xtensa/mm/cache.c                             |   83 +-
 arch/xtensa/mm/ioremap.c                           |   58 +-
 drivers/acpi/acpi_memhotplug.c                     |    3 +-
 drivers/base/memory.c                              |   27 +-
 drivers/base/node.c                                |    4 +-
 drivers/dax/device.c                               |   22 +-
 drivers/dax/kmem.c                                 |    4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |    5 +-
 drivers/gpu/drm/arm/display/include/malidp_utils.h |    2 +-
 .../drm/arm/display/komeda/komeda_pipeline_state.c |   24 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |    6 -
 drivers/iommu/amd/iommu_v2.c                       |   10 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |   29 +-
 drivers/iommu/intel/svm.c                          |    8 +-
 drivers/misc/ocxl/link.c                           |    8 +-
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c    |   18 +-
 drivers/net/ethernet/sfc/io.h                      |    2 +-
 drivers/net/ethernet/sfc/siena/io.h                |    2 +-
 drivers/nvdimm/pfn_devs.c                          |    2 +-
 drivers/tty/sysrq.c                                |    2 +-
 drivers/tty/vt/keyboard.c                          |    2 +-
 drivers/virt/acrn/ioreq.c                          |    4 +-
 fs/9p/cache.c                                      |    2 +
 fs/Kconfig                                         |    7 +-
 fs/affs/file.c                                     |   77 +-
 fs/affs/symlink.c                                  |   12 +-
 fs/afs/internal.h                                  |    2 +
 fs/btrfs/misc.h                                    |    2 -
 fs/buffer.c                                        |   36 +-
 fs/cachefiles/namei.c                              |    2 +
 fs/ceph/cache.c                                    |    2 +
 fs/dax.c                                           |   33 +-
 fs/drop_caches.c                                   |    2 +
 fs/erofs/data.c                                    |    6 +-
 fs/exec.c                                          |    1 +
 fs/ext2/balloc.c                                   |    2 -
 fs/ext2/file.c                                     |    2 +-
 fs/ext4/ext4.h                                     |    2 -
 fs/ext4/file.c                                     |   11 +-
 fs/ext4/inode.c                                    |    4 +-
 fs/ext4/move_extent.c                              |   19 +-
 fs/fuse/dax.c                                      |   20 +-
 fs/hugetlbfs/inode.c                               |   57 +-
 fs/jbd2/journal.c                                  |   35 +-
 fs/nfs/fscache.c                                   |    3 +
 fs/ntfs3/inode.c                                   |   10 +-
 fs/ocfs2/file.c                                    |    7 +-
 fs/proc/base.c                                     |    1 +
 fs/proc/meminfo.c                                  |   13 +-
 fs/proc/task_mmu.c                                 |   26 +-
 fs/proc/task_nommu.c                               |   15 +-
 fs/smb/client/fscache.c                            |    2 +
 fs/splice.c                                        |    3 +-
 fs/udf/file.c                                      |    6 +-
 fs/ufs/util.h                                      |    6 -
 fs/userfaultfd.c                                   |  140 ++-
 fs/xfs/xfs_file.c                                  |   24 +-
 fs/xfs/xfs_trace.h                                 |   20 +-
 include/asm-generic/cacheflush.h                   |    7 -
 include/asm-generic/io.h                           |   31 +-
 include/asm-generic/iomap.h                        |    6 +-
 include/asm-generic/pgalloc.h                      |   88 +-
 include/asm-generic/tlb.h                          |   12 +-
 include/linux/backing-dev.h                        |    1 -
 include/linux/bio.h                                |    5 +
 include/linux/buffer_head.h                        |    4 +-
 include/linux/cacheflush.h                         |   13 +-
 include/linux/damon.h                              |   28 +-
 include/linux/dax.h                                |    4 +-
 include/linux/frontswap.h                          |   91 --
 include/linux/fs.h                                 |    2 +-
 include/linux/highmem.h                            |   44 +
 include/linux/huge_mm.h                            |    6 +-
 include/linux/hugetlb.h                            |   38 +-
 include/linux/ioremap.h                            |   30 +
 include/linux/kfence.h                             |   11 +-
 include/linux/ksm.h                                |   20 +
 include/linux/maple_tree.h                         |   46 +-
 include/linux/memblock.h                           |   14 +-
 include/linux/memcontrol.h                         |   18 +-
 include/linux/memory-tiers.h                       |    4 +-
 include/linux/memory.h                             |    8 +-
 include/linux/memory_hotplug.h                     |    3 +-
 include/linux/minmax.h                             |   27 +
 include/linux/mm.h                                 |  365 ++++---
 include/linux/mm_inline.h                          |   21 +
 include/linux/mm_types.h                           |  135 ++-
 include/linux/mm_types_task.h                      |    4 +-
 include/linux/mmap_lock.h                          |   18 +-
 include/linux/mmu_notifier.h                       |  104 +-
 include/linux/mmzone.h                             |    1 -
 include/linux/net_mm.h                             |   17 -
 include/linux/page-flags.h                         |   90 +-
 include/linux/page_ext.h                           |    9 +-
 include/linux/page_idle.h                          |    5 -
 include/linux/page_table_check.h                   |   71 +-
 include/linux/pagemap.h                            |   60 +-
 include/linux/pgtable.h                            |  123 ++-
 include/linux/pid_namespace.h                      |   39 +-
 include/linux/rmap.h                               |    2 +
 include/linux/secretmem.h                          |   15 +-
 include/linux/swap.h                               |   21 +-
 include/linux/swapfile.h                           |    5 -
 include/linux/swapops.h                            |   15 +-
 include/linux/userfaultfd_k.h                      |    4 +
 include/linux/zswap.h                              |   37 +
 include/net/tcp.h                                  |    1 -
 include/trace/events/thp.h                         |   33 +-
 include/uapi/linux/userfaultfd.h                   |   25 +-
 init/initramfs.c                                   |    2 +-
 io_uring/io_uring.c                                |    6 +-
 io_uring/kbuf.c                                    |    6 +-
 kernel/crash_core.c                                |    4 +-
 kernel/events/core.c                               |   33 +-
 kernel/events/uprobes.c                            |    2 +-
 kernel/futex/core.c                                |    3 +-
 kernel/iomem.c                                     |   13 +-
 kernel/panic.c                                     |    2 +-
 kernel/pid.c                                       |    3 +
 kernel/pid_namespace.c                             |    6 +-
 kernel/pid_sysctl.h                                |   28 +-
 lib/logic_pio.c                                    |    3 -
 lib/maple_tree.c                                   | 1108 +++++++++-------=
----
 lib/test_maple_tree.c                              |  141 +++
 lib/test_meminit.c                                 |    2 +-
 mm/Kconfig                                         |   15 +-
 mm/Makefile                                        |    1 -
 mm/backing-dev.c                                   |    6 +-
 mm/cma.c                                           |    4 +-
 mm/compaction.c                                    |  105 +-
 mm/damon/core-test.h                               |   74 ++
 mm/damon/core.c                                    |   62 ++
 mm/damon/ops-common.c                              |    2 +-
 mm/damon/paddr.c                                   |    2 +-
 mm/damon/sysfs-common.h                            |    2 +-
 mm/damon/sysfs-schemes.c                           |  107 +-
 mm/damon/sysfs.c                                   |   26 +-
 mm/damon/vaddr.c                                   |   23 +-
 mm/debug_vm_pgtable.c                              |   18 +-
 mm/filemap.c                                       |  177 ++--
 mm/frontswap.c                                     |  283 -----
 mm/gup.c                                           |   92 +-
 mm/huge_memory.c                                   |  127 +--
 mm/hugetlb.c                                       |  461 +++-----
 mm/hugetlb_vmemmap.c                               |   34 +-
 mm/init-mm.c                                       |    2 +
 mm/internal.h                                      |   61 +-
 mm/ioremap.c                                       |   41 +-
 mm/kfence/core.c                                   |  123 ++-
 mm/kfence/kfence.h                                 |    5 +-
 mm/khugepaged.c                                    |  498 ++++-----
 mm/kmemleak.c                                      |   15 +-
 mm/kmsan/hooks.c                                   |    4 +-
 mm/kmsan/shadow.c                                  |    8 +-
 mm/ksm.c                                           |   44 +-
 mm/madvise.c                                       |   15 +-
 mm/mapping_dirty_helpers.c                         |   11 +-
 mm/memblock.c                                      |    5 +
 mm/memcontrol.c                                    |  136 ++-
 mm/memfd.c                                         |   58 +-
 mm/memory-failure.c                                |  133 ++-
 mm/memory-tiers.c                                  |   19 +-
 mm/memory.c                                        |  341 +++---
 mm/memory_hotplug.c                                |  192 +++-
 mm/mempolicy.c                                     |   15 +-
 mm/memtest.c                                       |   22 +-
 mm/migrate.c                                       |    5 +-
 mm/migrate_device.c                                |   30 +-
 mm/mlock.c                                         |    3 +-
 mm/mm_init.c                                       |   37 +-
 mm/mmap.c                                          |  255 ++---
 mm/mmu_gather.c                                    |    1 +
 mm/mmu_notifier.c                                  |   50 +-
 mm/mprotect.c                                      |    7 +-
 mm/mremap.c                                        |    2 +-
 mm/nommu.c                                         |   55 +-
 mm/oom_kill.c                                      |    3 -
 mm/page_alloc.c                                    |  150 +--
 mm/page_ext.c                                      |  101 +-
 mm/page_io.c                                       |   80 +-
 mm/page_isolation.c                                |    8 +-
 mm/page_owner.c                                    |    2 +-
 mm/page_poison.c                                   |    1 -
 mm/page_table_check.c                              |   62 +-
 mm/page_vma_mapped.c                               |   12 +-
 mm/pgtable-generic.c                               |   97 +-
 mm/rmap.c                                          |  145 ++-
 mm/secretmem.c                                     |   14 +-
 mm/shmem.c                                         |   15 +-
 mm/show_mem.c                                      |   10 +-
 mm/sparse-vmemmap.c                                |    3 +
 mm/sparse.c                                        |    3 +-
 mm/swap.h                                          |    1 -
 mm/swap_state.c                                    |   23 +-
 mm/swapfile.c                                      |   69 +-
 mm/truncate.c                                      |    8 +-
 mm/userfaultfd.c                                   |   87 +-
 mm/util.c                                          |   10 +-
 mm/vmscan.c                                        |   44 +-
 mm/vmstat.c                                        |    1 -
 mm/workingset.c                                    |    1 +
 mm/z3fold.c                                        |   27 +-
 mm/zsmalloc.c                                      |   79 +-
 mm/zswap.c                                         |  393 ++++---
 net/ipv4/tcp.c                                     |   11 +-
 net/netfilter/nf_nat_core.c                        |    6 +-
 net/tipc/core.h                                    |    2 +-
 net/tipc/link.c                                    |   10 +-
 security/selinux/hooks.c                           |    7 +-
 tools/include/nolibc/stdio.h                       |   24 +
 tools/testing/radix-tree/maple.c                   |  134 ++-
 .../selftests/bpf/progs/get_branch_snapshot.c      |    4 +-
 tools/testing/selftests/cgroup/.gitignore          |    1 +
 tools/testing/selftests/cgroup/Makefile            |    2 +
 tools/testing/selftests/cgroup/test_kmem.c         |   21 +-
 tools/testing/selftests/cgroup/test_zswap.c        |  286 +++++
 tools/testing/selftests/damon/sysfs.sh             |    6 +
 tools/testing/selftests/kselftest.h                |    9 +
 tools/testing/selftests/kselftest/runner.sh        |    7 +-
 tools/testing/selftests/memfd/memfd_test.c         |  329 ++++--
 tools/testing/selftests/mm/.gitignore              |    1 +
 tools/testing/selftests/mm/Makefile                |   81 +-
 tools/testing/selftests/mm/hugetlb-read-hwpoison.c |  322 ++++++
 tools/testing/selftests/mm/ksm_functional_tests.c  |  200 +++-
 tools/testing/selftests/mm/madv_populate.c         |   26 +-
 tools/testing/selftests/mm/map_populate.c          |    2 +-
 tools/testing/selftests/mm/migration.c             |   12 +-
 tools/testing/selftests/mm/mrelease_test.c         |    1 +
 tools/testing/selftests/mm/run_vmtests.sh          |   80 +-
 tools/testing/selftests/mm/settings                |    2 +-
 tools/testing/selftests/mm/thuge-gen.c             |    4 +-
 tools/testing/selftests/mm/transhuge-stress.c      |   12 +-
 tools/testing/selftests/mm/uffd-common.c           |    5 +-
 tools/testing/selftests/mm/uffd-common.h           |    3 +
 tools/testing/selftests/mm/uffd-stress.c           |   32 +-
 tools/testing/selftests/mm/uffd-unit-tests.c       |  117 +++
 tools/testing/selftests/mm/va_high_addr_switch.c   |    2 +-
 tools/testing/selftests/proc/proc-empty-vm.c       |    4 +-
 virt/kvm/kvm_main.c                                |   13 +-
 472 files changed, 9581 insertions(+), 7077 deletions(-)
 delete mode 100644 Documentation/mm/frontswap.rst
 create mode 100644 Documentation/powerpc/vmemmap_dedup.rst
 delete mode 100644 Documentation/translations/zh_CN/mm/frontswap.rst
 create mode 100644 arch/arm64/include/asm/tlbbatch.h
 delete mode 100644 arch/hexagon/mm/ioremap.c
 delete mode 100644 include/linux/frontswap.h
 create mode 100644 include/linux/ioremap.h
 delete mode 100644 include/linux/net_mm.h
 create mode 100644 include/linux/zswap.h
 delete mode 100644 mm/frontswap.c
 create mode 100644 tools/testing/selftests/cgroup/test_zswap.c
 create mode 100644 tools/testing/selftests/mm/hugetlb-read-hwpoison.c

