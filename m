Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5337DE7B6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjKAVy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 17:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKAVyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 17:54:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5064E110;
        Wed,  1 Nov 2023 14:54:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF55EC433C8;
        Wed,  1 Nov 2023 21:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1698875687;
        bh=37XAombslURPzCzZd42NAeGl+NoUZtHQ3m0ORP+TagQ=;
        h=Date:From:To:Cc:Subject:From;
        b=rfB9uYLNPm2bQSYekXIQ18TEWZK9IXLXqzv6V8YzOFny8Y6gr+kDv5BuBN//M0MX0
         pPN+wwHKMgtRKtbQxPzZi4Xb6x1q0W4VoZzgvJVeCLmBbWGd+twO6CDsC+YxmqjKmB
         IZRsOgsP3tGmTe7BDh0784AXgzH92YZkeTlv+6IQ=
Date:   Wed, 1 Nov 2023 14:54:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] MM updates for 6.7-rc1
Message-Id: <20231101145447.60320c9044e7db4dba2d93e3@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge the MM updates for this cycle.

Current or upcoming conflicts or build/runtime issues of which I am
aware, and their linux-next resolutions are:

vs bcachefs tree
	https://lkml.kernel.org/r/20230913093553.4290421e@canb.auug.org.au
	I shall send Stephen's conversion patch in reply to this email.

drivers/scsi/qla2xxx/qla_dfs.c: vs scsi-mkp tree
	https://lkml.kernel.org/r/20230906103905.0752736e@canb.auug.org.au

fs/btrfs/super.c: vs btrfs tree
	https://lkml.kernel.org/r/20230915091421.58207f2c@canb.auug.org.au

arch/ia64/kernel/setup.c: vs asm-generic tree
	https://lkml.kernel.org/r/20230918101027.7506b71e@canb.auug.org.au
	(this one is easy!)

mm/shmem.c: vs vfs-brauner tree
	https://lkml.kernel.org/r/20230921091352.01306900@canb.auug.org.au

fs/btrfs/super.c: vs btrfs tree
	https://lkml.kernel.org/r/20230926101717.0237a18a@canb.auug.org.au

fs/xfs/xfs_buf.c: vs vfs-brauner
	https://lkml.kernel.org/r/20230928102504.5c751249@canb.auug.org.au

arch/arm64/include/asm/tlb.h: vs arm64 tree
	https://lkml.kernel.org/r/20231024095234.1118e7dd@canb.auug.org.au

drivers/gpu/drm/msm/msm_drv.c: vs drm tree
	https://lkml.kernel.org/r/20231024115206.4ce24d96@canb.auug.org.au

fs/bcachefs/btree_cache.c
fs/bcachefs/btree_key_cache.c vs bcachefs tree
	https://lkml.kernel.org/r/20231101095002.737cedb8@canb.auug.org.au


Thanks.


The following changes since commit 099d7439ce03d0e7bc8f0c3d7878b562f3a48d3d:

  maple_tree: add GFP_KERNEL to allocations in mas_expected_entries() (2023-10-18 12:12:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2023-11-01-14-33

for you to fetch changes up to 9732336006764e2ee61225387e3c70eae9139035:

  mm/damon/sysfs: update monitoring target regions for online input commit (2023-11-01 12:38:35 -0700)

----------------------------------------------------------------
Many singleton patches against the MM code.  The patch series which are
included in this merge do the following:

- Kemeng Shi has contributed some compation maintenance work in the
  series "Fixes and cleanups to compaction".

- Joel Fernandes has a patchset ("Optimize mremap during mutual
  alignment within PMD") which fixes an obscure issue with mremap()'s
  pagetable handling during a subsequent exec(), based upon an
  implementation which Linus suggested.

- More DAMON/DAMOS maintenance and feature work from SeongJae Park i the
  following patch series:

	mm/damon: misc fixups for documents, comments and its tracepoint
	mm/damon: add a tracepoint for damos apply target regions
	mm/damon: provide pseudo-moving sum based access rate
	mm/damon: implement DAMOS apply intervals
	mm/damon/core-test: Fix memory leaks in core-test
	mm/damon/sysfs-schemes: Do DAMOS tried regions update for only one apply interval

- In the series "Do not try to access unaccepted memory" Adrian Hunter
  provides some fixups for the recently-added "unaccepted memory' feature.
  To increase the feature's checking coverage.  "Plug a few gaps where
  RAM is exposed without checking if it is unaccepted memory".

- In the series "cleanups for lockless slab shrink" Qi Zheng has done
  some maintenance work which is preparation for the lockless slab
  shrinking code.

- Qi Zheng has redone the earlier (and reverted) attempt to make slab
  shrinking lockless in the series "use refcount+RCU method to implement
  lockless slab shrink".

- David Hildenbrand contributes some maintenance work for the rmap code
  in the series "Anon rmap cleanups".

- Kefeng Wang does more folio conversions and some maintenance work in
  the migration code.  Series "mm: migrate: more folio conversion and
  unification".

- Matthew Wilcox has fixed an issue in the buffer_head code which was
  causing long stalls under some heavy memory/IO loads.  Some cleanups
  were added on the way.  Series "Add and use bdev_getblk()".

- In the series "Use nth_page() in place of direct struct page
  manipulation" Zi Yan has fixed a potential issue with the direct
  manipulation of hugetlb page frames.

- In the series "mm: hugetlb: Skip initialization of gigantic tail
  struct pages if freed by HVO" has improved our handling of gigantic
  pages in the hugetlb vmmemmep optimizaton code.  This provides
  significant boot time improvements when significant amounts of gigantic
  pages are in use.

- Matthew Wilcox has sent the series "Small hugetlb cleanups" - code
  rationalization and folio conversions in the hugetlb code.

- Yin Fengwei has improved mlock()'s handling of large folios in the
  series "support large folio for mlock"

- In the series "Expose swapcache stat for memcg v1" Liu Shixin has
  added statistics for memcg v1 users which are available (and useful)
  under memcg v2.

- Florent Revest has enhanced the MDWE (Memory-Deny-Write-Executable)
  prctl so that userspace may direct the kernel to not automatically
  propagate the denial to child processes.  The series is named "MDWE
  without inheritance".

- Kefeng Wang has provided the series "mm: convert numa balancing
  functions to use a folio" which does what it says.

- In the series "mm/ksm: add fork-exec support for prctl" Stefan Roesch
  makes is possible for a process to propagate KSM treatment across
  exec().

- Huang Ying has enhanced memory tiering's calculation of memory
  distances.  This is used to permit the dax/kmem driver to use "high
  bandwidth memory" in addition to Optane Data Center Persistent Memory
  Modules (DCPMM).  The series is named "memory tiering: calculate
  abstract distance based on ACPI HMAT"

- In the series "Smart scanning mode for KSM" Stefan Roesch has
  optimized KSM by teaching it to retain and use some historical
  information from previous scans.

- Yosry Ahmed has fixed some inconsistencies in memcg statistics in the
  series "mm: memcg: fix tracking of pending stats updates values".

- In the series "Implement IOCTL to get and optionally clear info about
  PTEs" Peter Xu has added an ioctl to /proc/<pid>/pagemap which permits
  us to atomically read-then-clear page softdirty state.  This is mainly
  used by CRIU.

- Hugh Dickins contributed the series "shmem,tmpfs: general maintenance"
  - a bunch of relatively minor maintenance tweaks to this code.

- Matthew Wilcox has increased the use of the VMA lock over file-backed
  page faults in the series "Handle more faults under the VMA lock".  Some
  rationalizations of the fault path became possible as a result.

- In the series "mm/rmap: convert page_move_anon_rmap() to
  folio_move_anon_rmap()" David Hildenbrand has implemented some cleanups
  and folio conversions.

- In the series "various improvements to the GUP interface" Lorenzo
  Stoakes has simplified and improved the GUP interface with an eye to
  providing groundwork for future improvements.

- Andrey Konovalov has sent along the series "kasan: assorted fixes and
  improvements" which does those things.

- Some page allocator maintenance work from Kemeng Shi in the series
  "Two minor cleanups to break_down_buddy_pages".

- In thes series "New selftest for mm" Breno Leitao has developed
  another MM self test which tickles a race we had between madvise() and
  page faults.

- In the series "Add folio_end_read" Matthew Wilcox provides cleanups
  and an optimization to the core pagecache code.

- Nhat Pham has added memcg accounting for hugetlb memory in the series
  "hugetlb memcg accounting".

- Cleanups and rationalizations to the pagemap code from Lorenzo
  Stoakes, in the series "Abstract vma_merge() and split_vma()".

- Audra Mitchell has fixed issues in the procfs page_owner code's new
  timestamping feature which was causing some misbehaviours.  In the
  series "Fix page_owner's use of free timestamps".

- Lorenzo Stoakes has fixed the handling of new mappings of sealed files
  in the series "permit write-sealed memfd read-only shared mappings".

- Mike Kravetz has optimized the hugetlb vmemmap optimization in the
  series "Batch hugetlb vmemmap modification operations".

- Some buffer_head folio conversions and cleanups from Matthew Wilcox in
  the series "Finish the create_empty_buffers() transition".

- As a page allocator performance optimization Huang Ying has added
  automatic tuning to the allocator's per-cpu-pages feature, in the series
  "mm: PCP high auto-tuning".

- Roman Gushchin has contributed the patchset "mm: improve performance
  of accounted kernel memory allocations" which improves their performance
  by ~30% as measured by a micro-benchmark.

- folio conversions from Kefeng Wang in the series "mm: convert page
  cpupid functions to folios".

- Some kmemleak fixups in Liu Shixin's series "Some bugfix about
  kmemleak".

- Qi Zheng has improved our handling of memoryless nodes by keeping them
  off the allocation fallback list.  This is done in the series "handle
  memoryless nodes more appropriately".

- khugepaged conversions from Vishal Moola in the series "Some
  khugepaged folio conversions".

----------------------------------------------------------------
Adrian Hunter (2):
      efi/unaccepted: do not let /proc/vmcore try to access unaccepted memory
      proc/kcore: do not try to access unaccepted memory

Aleksa Sarai (1):
      memfd: drop warning for missing exec-related flags

Alexander Potapenko (4):
      kmsan: simplify kmsan_internal_memmove_metadata()
      kmsan: prevent optimizations in memcpy tests
      kmsan: merge test_memcpy_aligned_to_unaligned{,2}() together
      kmsan: introduce test_memcpy_initialized_gap()

Andrew Morton (1):
      Merge mm-hotfixes-stable into mm-stable to pick up depended-upon changes.

Andrey Konovalov (6):
      arm64, kasan: update comment in kasan_init
      kasan: unify printk prefixes
      kasan: use unchecked __memset internally
      kasan: fix and update KUNIT_EXPECT_KASAN_FAIL comment
      Documentation: *san: drop "the" from article titles
      Documentation: ubsan: drop "the" from article title

Angus Chen (1):
      mm/vmscan: print err before panic

Anthony Yznaga (2):
      mm/mremap: fix unaccount of memory on vma_merge() failure
      mm: fix unaccount of memory on vma_link() failure

Audra Mitchell (5):
      mm/page_owner: remove free_ts from page_owner output
      tools/mm: remove references to free_ts from page_owner_sort
      tools/mm: filter out timestamps for correct collation
      tools/mm: fix the default case for page_owner_sort
      tools/mm: update the usage output to be more organized

Baolin Wang (2):
      mm: add statistics for PUD level pagetable
      mm: migrate: record the mlocked page status to remove unnecessary lru drain

Baoquan He (1):
      mm/vmalloc: fix the unchecked dereference warning in vread_iter()

Breno Leitao (2):
      selftests/mm: export get_free_hugepages()
      selftests/mm: add a new test for madv and hugetlb

David Hildenbrand (9):
      mm/rmap: drop stale comment in page_add_anon_rmap and hugepage_add_anon_rmap()
      mm/rmap: move SetPageAnonExclusive out of __page_set_anon_rmap()
      mm/rmap: move folio_test_anon() check out of __folio_set_anon()
      mm/rmap: warn on new PTE-mapped folios in page_add_anon_rmap()
      mm/rmap: simplify PageAnonExclusive sanity checks when adding anon rmap
      mm/rmap: pass folio to hugepage_add_anon_rmap()
      mm/rmap: move SetPageAnonExclusive() out of page_move_anon_rmap()
      mm/rmap: convert page_move_anon_rmap() to folio_move_anon_rmap()
      memory: move exclusivity detection in do_wp_page() into wp_can_reuse_anon_folio()

Ding Xiang (1):
      selftests/mm: gup_longterm: fix a resource leak

Florent Revest (6):
      kselftest: vm: fix tabs/spaces inconsistency in the mdwe test
      kselftest: vm: fix mdwe's mmap_FIXED test case
      kselftest: vm: check errnos in mdwe_test
      mm: make PR_MDWE_REFUSE_EXEC_GAIN an unsigned long
      mm: add a NO_INHERIT flag to the PR_SET_MDWE prctl
      kselftest: vm: add tests for no-inherit memory-deny-write-execute

Frank van der Linden (1):
      mm, hugetlb: remove HUGETLB_CGROUP_MIN_ORDER

Gregory Price (1):
      mm/migrate: remove unused mm argument from do_move_pages_to_node

Huan Yang (1):
      mm/damon/core: remove unnecessary si_meminfo invoke.

Huang Ying (14):
      memory tiering: add abstract distance calculation algorithms management
      acpi, hmat: refactor hmat_register_target_initiators()
      acpi, hmat: calculate abstract distance with HMAT
      dax, kmem: calculate abstract distance with general interface
      mm: fix draining remote pageset
      mm, pcp: avoid to drain PCP when process exit
      cacheinfo: calculate size of per-CPU data cache slice
      mm, pcp: reduce lock contention for draining high-order pages
      mm: restrict the pcp batch scale factor to avoid too long latency
      mm, page_alloc: scale the number of pages that are batch allocated
      mm: add framework for PCP high auto-tuning
      mm: tune PCP high automatically
      mm, pcp: decrease PCP high if free pages < high watermark
      mm, pcp: reduce detecting time of consecutive high order page freeing

Hugh Dickins (23):
      shmem: shrink shmem_inode_info: dir_offsets in a union
      shmem: remove vma arg from shmem_get_folio_gfp()
      shmem: factor shmem_falloc_wait() out of shmem_fault()
      shmem: trivial tidyups, removing extra blank lines, etc
      shmem: shmem_acct_blocks() and shmem_inode_acct_blocks()
      shmem: move memcg charge out of shmem_add_to_page_cache()
      shmem: _add_to_page_cache() before shmem_inode_acct_blocks()
      shmem,percpu_counter: add _limited_add(fbc, limit, amount)
      percpu_counter: extend _limited_add() to negative amounts
      ext4: add __GFP_NOWARN to GFP_NOWAIT in readahead
      mm: mlock: avoid folio_within_range() on KSM pages
      hugetlbfs: drop shared NUMA mempolicy pretence
      kernfs: drop shared NUMA mempolicy hooks
      mempolicy: fix migrate_pages(2) syscall return nr_failed
      mempolicy trivia: delete those ancient pr_debug()s
      mempolicy trivia: slightly more consistent naming
      mempolicy trivia: use pgoff_t in shared mempolicy tree
      mempolicy: mpol_shared_policy_init() without pseudo-vma
      mempolicy: remove confusing MPOL_MF_LAZY dead code
      mm: add page_rmappable_folio() wrapper
      mempolicy: alloc_pages_mpol() for NUMA policy without vma
      mempolicy: mmap_lock is not needed while migrating folios
      mempolicy: migration attempt to match interleave nodes

Hyesoo Yu (1):
      mm: page_alloc: check the order of compound page even when the order is zero

Jaewon Kim (1):
      mm: multi-gen LRU: reuse some legacy trace events

Jann Horn (1):
      mm: document mmu_notifier_invalidate_range_start_nonblock()

Jianguo Bao (1):
      mm/writeback: update filemap_dirty_folio() comment

Jinjie Ruan (2):
      mm/damon/core-test: fix memory leak in damon_new_region()
      mm/damon/core-test: fix memory leak in damon_new_ctx()

Joao Martins (2):
      hugetlb: batch PMD split for bulk vmemmap dedup
      hugetlb: batch TLB flushes when freeing vmemmap

Joel Fernandes (1):
      selftests: mm: add a test for moving from an offset from start of mapping

Joel Fernandes (Google) (6):
      mm/mremap: optimize the start addresses in move_page_tables()
      mm/mremap: allow moves within the same VMA for stack moves
      selftests: mm: fix failure case when new remap region was not found
      selftests: mm: add a test for mutually aligned moves > PMD size
      selftests: mm: add a test for remapping to area immediately after existing mapping
      selftests: mm: add a test for remapping within a range

Kairui Song (2):
      mm/oom_killer: simplify OOM killer info dump helper
      mm/swap: avoid a xa load for swapout path

Kees Cook (1):
      mm/memcg: annotate struct mem_cgroup_threshold_ary with __counted_by

Kefeng Wang (33):
      mm: migrate: remove PageTransHuge check in numamigrate_isolate_page()
      mm: migrate: remove THP mapcount check in numamigrate_isolate_page()
      mm: migrate: convert numamigrate_isolate_page() to numamigrate_isolate_folio()
      mm: migrate: convert migrate_misplaced_page() to migrate_misplaced_folio()
      mm: migrate: use __folio_test_movable()
      mm: migrate: use a folio in add_page_for_migration()
      mm: migrate: remove PageHead() check for HugeTLB in add_page_for_migration()
      mm: migrate: remove isolated variable in add_page_for_migration()
      mm: memory: add vm_normal_folio_pmd()
      mm: huge_memory: use a folio in do_huge_pmd_numa_page()
      mm: memory: use a folio in do_numa_page()
      mm: memory: make numa_migrate_prep() to take a folio
      mm: mempolicy: make mpol_misplaced() to take a folio
      sched/numa, mm: make numa migrate functions to take a folio
      mm_types: add virtual and _last_cpupid into struct folio
      mm: add folio_last_cpupid()
      mm: memory: use folio_last_cpupid() in do_numa_page()
      mm: huge_memory: use folio_last_cpupid() in do_huge_pmd_numa_page()
      mm: huge_memory: use folio_last_cpupid() in __split_huge_page_tail()
      mm: remove page_cpupid_last()
      mm: add folio_xchg_access_time()
      sched/fair: use folio_xchg_access_time() in numa_hint_fault_latency()
      mm: mprotect: use a folio in change_pte_range()
      mm: huge_memory: use a folio in change_huge_pmd()
      mm: remove xchg_page_access_time()
      mm: add folio_xchg_last_cpupid()
      sched/fair: use folio_xchg_last_cpupid() in should_numa_migrate_memory()
      mm: migrate: use folio_xchg_last_cpupid() in folio_migrate_flags()
      mm: huge_memory: use folio_xchg_last_cpupid() in __split_huge_page_tail()
      mm: make finish_mkwrite_fault() static
      mm: convert wp_page_reuse() and finish_mkwrite_fault() to take a folio
      mm: use folio_xchg_last_cpupid() in wp_page_reuse()
      mm: remove page_cpupid_xchg_last()

Kemeng Shi (8):
      mm/compaction: use correct list in move_freelist_{head}/{tail}
      mm/compaction: call list_is_{first}/{last} more intuitively in move_freelist_{head}/{tail}
      mm/compaction: correctly return failure with bogus compound_order in strict mode
      mm/compaction: remove repeat compact_blockskip_flush check in reset_isolation_suitable
      mm/compaction: improve comment of is_via_compact_memory
      mm/compaction: factor out code to test if we should run compaction for target order
      mm/page_alloc: remove unnecessary check in break_down_buddy_pages
      mm/page_alloc: remove unnecessary next_page in break_down_buddy_pages

Li Zhijian (1):
      acpi,mm: fix typo sibiling -> sibling

Liam R. Howlett (2):
      radix tree test suite: fix allocation calculation in kmem_cache_alloc_bulk()
      mmap: add clarifying comment to vma_merge() code

Liu Shixin (10):
      memcg: expose swapcache stat for memcg v1
      memcg: remove unused do_memsw_account in memcg1_stat_format
      bootmem: use kmemleak_free_part_phys in put_page_bootmem
      bootmem: use kmemleak_free_part_phys in free_bootmem_page
      mm/kmemleak: fix print format of pointer in pr_debug()
      mm: kmemleak: split __create_object into two functions
      mm: kmemleak: use mem_pool_free() to free object
      mm: kmemleak: add __find_and_remove_object()
      mm/kmemleak: fix partially freeing unknown object warning
      mm/kmemleak: move the initialisation of object to __link_object

Lorenzo Stoakes (15):
      mm: refactor si_mem_available()
      mm/filemap: clarify filemap_fault() comments for not uptodate case
      mm: make __access_remote_vm() static
      mm/gup: explicitly define and check internal GUP flags, disallow FOLL_TOUCH
      mm/gup: make failure to pin an error if FOLL_NOWAIT not specified
      mm/gup: adapt get_user_page_vma_remote() to never return NULL
      mm/mprotect: allow unfaulted VMAs to be unaccounted on mprotect()
      mm: move vma_policy() and anon_vma_name() decls to mm_types.h
      mm: abstract the vma_merge()/split_vma() pattern for mprotect() et al.
      mm: make vma_merge() and split_vma() internal
      mm: abstract merge for new VMAs into vma_merge_new_vma()
      mm: abstract VMA merge and extend into vma_merge_extend() helper
      mm: drop the assumption that VM_SHARED always implies writable
      mm: update memfd seal write check to include F_SEAL_WRITE
      mm: perform the mapping_map_writable() check after call_mmap()

Lucy Mielke (1):
      mm: add printf attribute to shrinker_debugfs_name_alloc

Mark-PK Tsai (1):
      zsmalloc: use copy_page for full page copy

Mateusz Guzik (1):
      mm: remove remnants of SPLIT_RSS_COUNTING

Matthew Wilcox (Oracle) (63):
      mm: convert DAX lock/unlock page to lock/unlock folio
      buffer: pass GFP flags to folio_alloc_buffers()
      buffer: hoist GFP flags from grow_dev_page() to __getblk_gfp()
      ext4: use bdev_getblk() to avoid memory reclaim in readahead path
      buffer: use bdev_getblk() to avoid memory reclaim in readahead path
      buffer: convert getblk_unmovable() and __getblk() to use bdev_getblk()
      buffer: convert sb_getblk() to call __getblk()
      ext4: call bdev_getblk() from sb_getblk_gfp()
      buffer: remove __getblk_gfp()
      hugetlb: use a folio in free_hpage_workfn()
      hugetlb: remove a few calls to page_folio()
      hugetlb: convert remove_pool_huge_page() to remove_pool_hugetlb_folio()
      mm: make lock_folio_maybe_drop_mmap() VMA lock aware
      mm: call wp_page_copy() under the VMA lock
      mm: handle shared faults under the VMA lock
      mm: handle COW faults under the VMA lock
      mm: handle read faults under the VMA lock
      mm: handle write faults to RO pages under the VMA lock
      iomap: hold state_lock over call to ifs_set_range_uptodate()
      iomap: protect read_bytes_pending with the state_lock
      mm: add folio_end_read()
      ext4: use folio_end_read()
      buffer: use folio_end_read()
      iomap: use folio_end_read()
      bitops: add xor_unlock_is_negative_byte()
      alpha: implement xor_unlock_is_negative_byte
      m68k: implement xor_unlock_is_negative_byte
      mips: implement xor_unlock_is_negative_byte
      powerpc: implement arch_xor_unlock_is_negative_byte on 32-bit
      riscv: implement xor_unlock_is_negative_byte
      s390: implement arch_xor_unlock_is_negative_byte
      mm: delete checks for xor_unlock_is_negative_byte()
      mm: add folio_xor_flags_has_waiters()
      mm: make __end_folio_writeback() return void
      mm: use folio_xor_flags_has_waiters() in folio_end_writeback()
      filemap: remove use of wait bookmarks
      sched: remove wait bookmarks
      buffer: make folio_create_empty_buffers() return a buffer_head
      mpage: convert map_buffer_to_folio() to folio_create_empty_buffers()
      ext4: convert to folio_create_empty_buffers
      buffer: add get_nth_bh()
      gfs2: convert inode unstuffing to use a folio
      gfs2: convert gfs2_getbuf() to folios
      gfs2: convert gfs2_getjdatabuf to use a folio
      gfs2: convert gfs2_write_buf_to_page() to use a folio
      nilfs2: convert nilfs_mdt_freeze_buffer to use a folio
      nilfs2: convert nilfs_grab_buffer() to use a folio
      nilfs2: convert nilfs_copy_page() to nilfs_copy_folio()
      nilfs2: convert nilfs_mdt_forget_block() to use a folio
      nilfs2: convert nilfs_mdt_get_frozen_buffer to use a folio
      nilfs2: remove nilfs_page_get_nth_block
      nilfs2: convert nilfs_lookup_dirty_data_buffers to use folio_create_empty_buffers
      ntfs: convert ntfs_read_block() to use a folio
      ntfs: convert ntfs_writepage to use a folio
      ntfs: convert ntfs_prepare_pages_for_non_resident_write() to folios
      ntfs3: convert ntfs_zero_range() to use a folio
      ocfs2: convert ocfs2_map_page_blocks to use a folio
      reiserfs: convert writepage to use a folio
      ufs: add ufs_get_locked_folio and ufs_put_locked_folio
      ufs: use ufs_get_locked_folio() in ufs_alloc_lastblock()
      ufs: convert ufs_change_blocknr() to use folios
      ufs: remove ufs_get_locked_page()
      buffer: remove folio_create_empty_buffers()

Mike Kravetz (8):
      hugetlb: set hugetlb page flag before optimizing vmemmap
      hugetlb: check for hugetlb folio before vmemmap_restore
      hugetlb: optimize update_and_free_pages_bulk to avoid lock cycles
      hugetlb: restructure pool allocations
      hugetlb: perform vmemmap optimization on a list of pages
      hugetlb: perform vmemmap restoration on a list of pages
      hugetlb: batch freeing of vmemmap pages
      hugetlb: batch TLB flushes when restoring vmemmap

Minjie Du (1):
      mm/filemap: increase usage of folio_next_index() helper

Muhammad Muzammil (1):
      mm: fix multiple typos in multiple files

Muhammad Usama Anjum (5):
      fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs
      fs/proc/task_mmu: add fast paths to get/clear PAGE_IS_WRITTEN flag
      tools headers UAPI: update linux/fs.h with the kernel sources
      mm/pagemap: add documentation of PAGEMAP_SCAN IOCTL
      selftests: mm: add pagemap ioctl tests

Nhat Pham (7):
      zswap: change zswap's default allocator to zsmalloc
      memcontrol: add helpers for hugetlb memcg accounting
      memcontrol: only transfer the memcg data for migration
      hugetlb: memcg: account hugetlb-backed memory in memory controller
      selftests: add a selftest to verify hugetlb usage in memcg
      zswap: export compression failure stats
      selftests: add a sanity check for zswap

Pankaj Raghav (1):
      filemap: call filemap_get_folios_tag() from filemap_get_folios()

Pedro Falcato (1):
      mm: kmsan: panic on failure to allocate early boot metadata

Peter Xu (1):
      userfaultfd: UFFD_FEATURE_WP_ASYNC

Qi Zheng (51):
      mm: move some shrinker-related function declarations to mm/internal.h
      mm: vmscan: move shrinker-related code into a separate file
      mm: shrinker: remove redundant shrinker_rwsem in debugfs operations
      drm/ttm: introduce pool_shrink_rwsem
      mm: shrinker: add infrastructure for dynamically allocating shrinker
      kvm: mmu: dynamically allocate the x86-mmu shrinker
      binder: dynamically allocate the android-binder shrinker
      drm/ttm: dynamically allocate the drm-ttm_pool shrinker
      xenbus/backend: dynamically allocate the xen-backend shrinker
      erofs: dynamically allocate the erofs-shrinker
      f2fs: dynamically allocate the f2fs-shrinker
      gfs2: dynamically allocate the gfs2-glock shrinker
      gfs2: dynamically allocate the gfs2-qd shrinker
      NFSv4.2: dynamically allocate the nfs-xattr shrinkers
      nfs: dynamically allocate the nfs-acl shrinker
      nfsd: dynamically allocate the nfsd-filecache shrinker
      quota: dynamically allocate the dquota-cache shrinker
      ubifs: dynamically allocate the ubifs-slab shrinker
      rcu: dynamically allocate the rcu-lazy shrinker
      rcu: dynamically allocate the rcu-kfree shrinker
      mm: thp: dynamically allocate the thp-related shrinkers
      sunrpc: dynamically allocate the sunrpc_cred shrinker
      mm: workingset: dynamically allocate the mm-shadow shrinker
      drm/i915: dynamically allocate the i915_gem_mm shrinker
      drm/msm: dynamically allocate the drm-msm_gem shrinker
      drm/panfrost: dynamically allocate the drm-panfrost shrinker
      dm: dynamically allocate the dm-bufio shrinker
      dm zoned: dynamically allocate the dm-zoned-meta shrinker
      md/raid5: dynamically allocate the md-raid5 shrinker
      bcache: dynamically allocate the md-bcache shrinker
      vmw_balloon: dynamically allocate the vmw-balloon shrinker
      virtio_balloon: dynamically allocate the virtio-balloon shrinker
      mbcache: dynamically allocate the mbcache shrinker
      ext4: dynamically allocate the ext4-es shrinker
      jbd2,ext4: dynamically allocate the jbd2-journal shrinker
      nfsd: dynamically allocate the nfsd-client shrinker
      nfsd: dynamically allocate the nfsd-reply shrinker
      xfs: dynamically allocate the xfs-buf shrinker
      xfs: dynamically allocate the xfs-inodegc shrinker
      xfs: dynamically allocate the xfs-qm shrinker
      zsmalloc: dynamically allocate the mm-zspool shrinker
      fs: super: dynamically allocate the s_shrink
      mm: shrinker: remove old APIs
      mm: shrinker: add a secondary array for shrinker_info::{map, nr_deferred}
      mm: shrinker: rename {prealloc|unregister}_memcg_shrinker() to shrinker_memcg_{alloc|remove}()
      mm: shrinker: make global slab shrink lockless
      mm: shrinker: make memcg slab shrink lockless
      mm: shrinker: hold write lock to reparent shrinker nr_deferred
      mm: shrinker: convert shrinker_rwsem to mutex
      mm: page_alloc: skip memoryless nodes entirely
      mm: memory_hotplug: drop memoryless node from fallback lists

Roman Gushchin (6):
      mm: kmem: optimize get_obj_cgroup_from_current()
      mm: kmem: add direct objcg pointer to task_struct
      mm: kmem: make memcg keep a reference to the original objcg
      mm: kmem: scoped objcg protection
      percpu: scoped objcg protection
      mm: kmem: reimplement get_obj_cgroup_from_current()

SeongJae Park (42):
      Docs/admin-guide/mm/damon/usage: fixup missed :ref: keyword
      Docs/admin-guide/mm/damon/usage: place debugfs usage at the bottom
      Docs/admin-guide/mm/damon/usage: move debugfs intro to the bottom of the section
      Docs/mm/damon/design: explicitly introduce ``nr_accesses``
      Docs/admin-guide/mm/damon/usage: explain the format of damon_aggregate tracepoint
      Docs/mm/damon/design: add a section for kdamond and DAMON context
      Docs/admin-guide/mm/damon/usage: link design doc for details of kdamond and context
      mm/damon/core: fix a comment about damon_set_attrs() call timings
      mm/damon/core: add more comments for nr_accesses
      mm/damon/core: remove duplicated comment for watermarks-based deactivation
      mm/damon/core: remove 'struct target *' parameter from damon_aggregated tracepoint
      mm/damon/core: add a tracepoint for damos apply target regions
      Docs/admin-guide/mm/damon/usage: document damos_before_apply tracepoint
      mm/damon/core: use number of passed access sampling as a timer
      mm/damon/core: define and use a dedicated function for region access rate update
      mm/damon/vaddr: call damon_update_region_access_rate() always
      mm/damon/core: implement a pseudo-moving sum function
      mm/damon/core-test: add a unit test for damon_moving_sum()
      mm/damon/core: introduce nr_accesses_bp
      mm/damon/core: use pseudo-moving sum for nr_accesses_bp
      mm/damon/core: skip updating nr_accesses_bp for each aggregation interval
      mm/damon/core: mark damon_moving_sum() as a static function
      mm/damon/core: make DAMOS uses nr_accesses_bp instead of nr_accesses
      mm/damon/sysfs-schemes: use nr_accesses_bp as the source of tried_regions/<N>/nr_accesses
      mm/damon/core: use nr_accesses_bp as a source of damos_before_apply tracepoint
      mm/damon/core: implement scheme-specific apply interval
      Docs/mm/damon/design: document DAMOS apply intervals
      mm/damon/sysfs-schemes: support DAMOS apply interval
      selftests/damon/sysfs: test DAMOS apply intervals
      Docs/admin-guide/mm/damon/usage: update for DAMOS apply intervals
      Docs/ABI/damon: update for DAMOS apply intervals
      mm/damon/sysfs-schemes: do not update tried regions more than one DAMON snapshot
      mm/damon/sysfs: avoid empty scheme tried regions for large apply interval
      Docs/admin-guide/mm/damon/usage: update for tried regions update time interval
      mm/damon: implement a function for max nr_accesses safe calculation
      mm/damon/core: avoid divide-by-zero during monitoring results update
      mm/damon/ops-common: avoid divide-by-zero during region hotness calculation
      mm/damon/lru_sort: avoid divide-by-zero in hot threshold calculation
      mm/damon/core: avoid divide-by-zero from pseudo-moving window length calculation
      mm/damon/sysfs-test: add a unit test for damon_sysfs_set_targets()
      mm/damon/sysfs: remove requested targets when online-commit inputs
      mm/damon/sysfs: update monitoring target regions for online input commit

Sidhartha Kumar (2):
      mm/filemap: remove hugetlb special casing in filemap.c
      mm/hugetlb: replace page_ref_freeze() with folio_ref_freeze() in hugetlb_folio_init_vmemmap()

Stefan Roesch (6):
      mm/ksm: support fork/exec for prctl
      mm/ksm: test case for prctl fork/exec workflow
      mm/ksm: add "smart" page scanning mode
      mm/ksm: add pages_skipped metric
      mm/ksm: document smart scan mode
      mm/ksm: document pages_skipped sysfs knob

Tiezhu Yang (1):
      selftests/clone3: Fix broken test under !CONFIG_TIME_NS

Tom Yang (1):
      Documentation: maple_tree: fix word spelling error

Uros Bizjak (1):
      mm/vmstat: use this_cpu_try_cmpxchg in mod_{zone,node}_state

Usama Arif (5):
      mm: hugetlb_vmemmap: use nid of the head page to reallocate it
      memblock: pass memblock_type to memblock_setclr_flag
      memblock: introduce MEMBLOCK_RSRV_NOINIT flag
      mm: hugetlb: skip initialization of gigantic tail struct pages if freed by HVO
      hugetlb_vmemmap: use folio argument for hugetlb_vmemmap_* functions

Vegard Nossum (1):
      mm: hugetlb_vmemmap: fix reference to nonexistent file

Vern Hao (1):
      mm/vmscan: use folio_migratetype() instead of get_pageblock_migratetype()

Vishal Moola (Oracle) (5):
      mm/khugepaged: convert __collapse_huge_page_isolate() to use folios
      mm/khugepaged: convert hpage_collapse_scan_pmd() to use folios
      mm/khugepaged: convert is_refcount_suitable() to use folios
      mm/khugepaged: convert alloc_charge_hpage() to use folios
      mm/khugepaged: convert collapse_pte_mapped_thp() to use folios

Vlastimil Babka (2):
      trace-vmscan-postprocess: sync with tracepoints updates
      mm, vmscan: remove ISOLATE_UNMAPPED

Xin Hao (1):
      mm: memcg: add THP swap out info for anonymous reclaim

Xiu Jianfeng (1):
      mm: remove duplicated vma->vm_flags check when expanding stack

Xueshi Hu (1):
      mm/hugetlb: fix nodes huge page allocation when there are surplus pages

Yajun Deng (1):
      mm/mm_init.c: remove redundant pr_info when node is memoryless

Yin Fengwei (3):
      mm: add functions folio_in_range() and folio_within_vma()
      mm: handle large folio when large folio in VM_LOCKED VMA range
      mm: mlock: update mlock_pte_range to handle large folio

Ying Sun (1):
      mm/shmem: remove dead code can not be satisfied by "(CONFIG_SHMEM)&&(!(CONFIG_SHMEM))"

Yosry Ahmed (2):
      mm: memcg: refactor page state unit helpers
      mm: memcg: normalize the value passed into memcg_rstat_updated()

Yuan Can (2):
      mm: hugetlb_vmemmap: fix hugetlb page number decrease failed on movable nodes
      mm: hugetlb_vmemmap: allow alloc vmemmap pages fallback to other nodes

Zach O'Keefe (1):
      mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"

Zi Yan (7):
      mm/cma: use nth_page() in place of direct struct page manipulation
      mm/hugetlb: use nth_page() in place of direct struct page manipulation
      mm/memory_hotplug: use pfn math in place of direct struct page manipulation
      fs: use nth_page() in place of direct struct page manipulation
      mips: use nth_page() in place of direct struct page manipulation
      mm/migrate: correct nr_failed in migrate_pages_sync()
      mm/migrate: add nr_split to trace_mm_migrate_pages stats.

liujinlong (1):
      mm: vmscan: modify an easily misunderstood function name

liwenyu (1):
      delayacct: add memory reclaim delay in get_page_from_freelist

 Documentation/ABI/testing/sysfs-kernel-mm-damon    |    7 +
 Documentation/admin-guide/cgroup-v1/memory.rst     |    1 +
 Documentation/admin-guide/cgroup-v2.rst            |   38 +
 Documentation/admin-guide/mm/damon/usage.rst       |  124 +-
 Documentation/admin-guide/mm/ksm.rst               |   11 +
 Documentation/admin-guide/mm/pagemap.rst           |   89 ++
 Documentation/admin-guide/mm/userfaultfd.rst       |   35 +
 Documentation/core-api/maple_tree.rst              |    2 +-
 Documentation/dev-tools/kasan.rst                  |    7 +-
 Documentation/dev-tools/kcsan.rst                  |    4 +-
 Documentation/dev-tools/kmsan.rst                  |    6 +-
 Documentation/dev-tools/ubsan.rst                  |    6 +-
 Documentation/mm/damon/design.rst                  |   26 +-
 .../trace/postprocess/trace-vmscan-postprocess.pl  |   42 +-
 MAINTAINERS                                        |    2 +
 arch/alpha/include/asm/bitops.h                    |   20 +
 arch/arm64/include/asm/tlb.h                       |    5 +-
 arch/arm64/kernel/mte.c                            |    4 +-
 arch/arm64/mm/kasan_init.c                         |    6 +-
 arch/loongarch/include/asm/pgalloc.h               |    1 +
 arch/m68k/include/asm/bitops.h                     |   21 +
 arch/mips/include/asm/bitops.h                     |   25 +-
 arch/mips/include/asm/pgalloc.h                    |    1 +
 arch/mips/lib/bitops.c                             |   14 +
 arch/mips/mm/cache.c                               |    2 +-
 arch/powerpc/include/asm/bitops.h                  |   21 +-
 arch/riscv/include/asm/bitops.h                    |   12 +
 arch/s390/include/asm/bitops.h                     |   10 +
 arch/x86/include/asm/bitops.h                      |   11 +-
 arch/x86/kvm/mmu/mmu.c                             |   18 +-
 arch/x86/mm/pgtable.c                              |    3 +
 drivers/acpi/acpi_pad.c                            |    2 +-
 drivers/acpi/numa/hmat.c                           |  146 +-
 drivers/android/binder_alloc.c                     |   30 +-
 drivers/base/cacheinfo.c                           |   51 +-
 drivers/dax/kmem.c                                 |   62 +-
 drivers/firmware/efi/unaccepted_memory.c           |   20 +
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c       |   29 +-
 drivers/gpu/drm/i915/i915_drv.h                    |    2 +-
 drivers/gpu/drm/msm/msm_drv.c                      |    4 +-
 drivers/gpu/drm/msm/msm_drv.h                      |    4 +-
 drivers/gpu/drm/msm/msm_gem_shrinker.c             |   33 +-
 drivers/gpu/drm/panfrost/panfrost_device.h         |    2 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c            |    6 +-
 drivers/gpu/drm/panfrost/panfrost_gem.h            |    2 +-
 drivers/gpu/drm/panfrost/panfrost_gem_shrinker.c   |   29 +-
 drivers/gpu/drm/ttm/ttm_pool.c                     |   40 +-
 drivers/md/bcache/bcache.h                         |    2 +-
 drivers/md/bcache/btree.c                          |   27 +-
 drivers/md/bcache/sysfs.c                          |    3 +-
 drivers/md/dm-bufio.c                              |   28 +-
 drivers/md/dm-cache-metadata.c                     |    2 +-
 drivers/md/dm-zoned-metadata.c                     |   28 +-
 drivers/md/raid5.c                                 |   26 +-
 drivers/md/raid5.h                                 |    2 +-
 drivers/misc/vmw_balloon.c                         |   38 +-
 drivers/virtio/virtio_balloon.c                    |   24 +-
 drivers/xen/xenbus/xenbus_probe_backend.c          |   17 +-
 fs/btrfs/super.c                                   |    2 +-
 fs/buffer.c                                        |  125 +-
 fs/dax.c                                           |   24 +-
 fs/erofs/utils.c                                   |   19 +-
 fs/exec.c                                          |    4 +-
 fs/ext4/ext4.h                                     |    2 +-
 fs/ext4/extents_status.c                           |   23 +-
 fs/ext4/inode.c                                    |   14 +-
 fs/ext4/move_extent.c                              |   11 +-
 fs/ext4/readpage.c                                 |   14 +-
 fs/ext4/super.c                                    |   13 +-
 fs/f2fs/super.c                                    |   31 +-
 fs/gfs2/aops.c                                     |    2 +-
 fs/gfs2/bmap.c                                     |   48 +-
 fs/gfs2/glock.c                                    |   19 +-
 fs/gfs2/main.c                                     |    6 +-
 fs/gfs2/meta_io.c                                  |   61 +-
 fs/gfs2/quota.c                                    |   62 +-
 fs/gfs2/quota.h                                    |    3 +-
 fs/hugetlbfs/inode.c                               |   84 +-
 fs/iomap/buffered-io.c                             |   57 +-
 fs/jbd2/journal.c                                  |   29 +-
 fs/kernfs/file.c                                   |   49 -
 fs/kernfs/mount.c                                  |    2 +-
 fs/mbcache.c                                       |   22 +-
 fs/mpage.c                                         |    3 +-
 fs/nfs/nfs42xattr.c                                |   87 +-
 fs/nfs/super.c                                     |   21 +-
 fs/nfsd/filecache.c                                |   23 +-
 fs/nfsd/netns.h                                    |    4 +-
 fs/nfsd/nfs4state.c                                |   19 +-
 fs/nfsd/nfscache.c                                 |   31 +-
 fs/nilfs2/mdt.c                                    |   66 +-
 fs/nilfs2/page.c                                   |   76 +-
 fs/nilfs2/page.h                                   |   11 -
 fs/nilfs2/segment.c                                |    7 +-
 fs/ntfs/aops.c                                     |  255 ++-
 fs/ntfs/file.c                                     |   89 +-
 fs/ntfs3/file.c                                    |   31 +-
 fs/ocfs2/aops.c                                    |   19 +-
 fs/proc/kcore.c                                    |    3 +-
 fs/proc/root.c                                     |    2 +-
 fs/proc/task_mmu.c                                 |  733 ++++++++-
 fs/quota/dquot.c                                   |   17 +-
 fs/reiserfs/inode.c                                |   80 +-
 fs/super.c                                         |   35 +-
 fs/ubifs/super.c                                   |   21 +-
 fs/ufs/balloc.c                                    |   20 +-
 fs/ufs/inode.c                                     |   25 +-
 fs/ufs/util.c                                      |   34 +-
 fs/ufs/util.h                                      |   10 +-
 fs/userfaultfd.c                                   |   96 +-
 fs/xfs/xfs_buf.c                                   |   24 +-
 fs/xfs/xfs_buf.h                                   |    2 +-
 fs/xfs/xfs_icache.c                                |   26 +-
 fs/xfs/xfs_mount.c                                 |    4 +-
 fs/xfs/xfs_mount.h                                 |    2 +-
 fs/xfs/xfs_qm.c                                    |   27 +-
 fs/xfs/xfs_qm.h                                    |    2 +-
 include/asm-generic/bitops/instrumented-lock.h     |   28 +-
 include/asm-generic/bitops/lock.h                  |   20 +-
 include/asm-generic/pgalloc.h                      |    7 +-
 include/linux/bootmem_info.h                       |    2 +-
 include/linux/buffer_head.h                        |   81 +-
 include/linux/cacheinfo.h                          |    1 +
 include/linux/cgroup-defs.h                        |    5 +
 include/linux/damon.h                              |   74 +-
 include/linux/dax.h                                |   10 +-
 include/linux/fs.h                                 |    6 +-
 include/linux/gfp.h                                |   12 +-
 include/linux/hugetlb.h                            |   25 +-
 include/linux/hugetlb_cgroup.h                     |   11 -
 include/linux/jbd2.h                               |    2 +-
 include/linux/memblock.h                           |    9 +
 include/linux/memcontrol.h                         |   93 +-
 include/linux/memory-tiers.h                       |   41 +-
 include/linux/mempolicy.h                          |   58 +-
 include/linux/migrate.h                            |    4 +-
 include/linux/mm.h                                 |  176 ++-
 include/linux/mm_inline.h                          |   20 +-
 include/linux/mm_types.h                           |   49 +-
 include/linux/mmu_notifier.h                       |    9 +-
 include/linux/mmzone.h                             |   29 +-
 include/linux/page-flags.h                         |   19 +
 include/linux/pagemap.h                            |   33 +-
 include/linux/percpu_counter.h                     |   30 +
 include/linux/rmap.h                               |    4 +-
 include/linux/sched.h                              |    4 +
 include/linux/sched/coredump.h                     |   19 +-
 include/linux/sched/mm.h                           |    4 +
 include/linux/sched/numa_balancing.h               |    6 +-
 include/linux/shmem_fs.h                           |   16 +-
 include/linux/shrinker.h                           |   87 +-
 include/linux/userfaultfd_k.h                      |   28 +-
 include/linux/wait.h                               |    9 +-
 include/trace/events/damon.h                       |   45 +-
 include/trace/events/migrate.h                     |   24 +-
 include/trace/events/vmscan.h                      |    8 +-
 include/uapi/linux/fs.h                            |   59 +
 include/uapi/linux/mempolicy.h                     |    2 +-
 include/uapi/linux/prctl.h                         |    3 +-
 include/uapi/linux/userfaultfd.h                   |    9 +-
 ipc/shm.c                                          |   21 +-
 kernel/cgroup/cgroup.c                             |   15 +-
 kernel/events/uprobes.c                            |    4 +-
 kernel/exit.c                                      |    4 -
 kernel/fork.c                                      |    8 +-
 kernel/kcsan/kcsan_test.c                          |    9 +-
 kernel/kcsan/selftest.c                            |    9 +-
 kernel/kthread.c                                   |    1 -
 kernel/ptrace.c                                    |    2 +-
 kernel/rcu/tree.c                                  |   21 +-
 kernel/rcu/tree_nocb.h                             |   19 +-
 kernel/sched/fair.c                                |   12 +-
 kernel/sched/wait.c                                |   60 +-
 kernel/sys.c                                       |   32 +-
 lib/percpu_counter.c                               |   79 +
 mm/Kconfig                                         |   12 +
 mm/Makefile                                        |    4 +-
 mm/bootmem_info.c                                  |    2 +-
 mm/cma.c                                           |    2 +-
 mm/compaction.c                                    |   91 +-
 mm/damon/Kconfig                                   |   12 +
 mm/damon/core-test.h                               |   29 +-
 mm/damon/core.c                                    |  295 +++-
 mm/damon/dbgfs.c                                   |    3 +-
 mm/damon/lru_sort.c                                |    6 +-
 mm/damon/ops-common.c                              |    5 +-
 mm/damon/paddr.c                                   |   11 +-
 mm/damon/reclaim.c                                 |    2 +
 mm/damon/sysfs-common.h                            |    2 +
 mm/damon/sysfs-schemes.c                           |  133 +-
 mm/damon/sysfs-test.h                              |   86 +
 mm/damon/sysfs.c                                   |  123 +-
 mm/damon/vaddr.c                                   |   22 +-
 mm/debug_vm_pgtable.c                              |    4 +-
 mm/filemap.c                                       |  215 +--
 mm/gup.c                                           |   16 +-
 mm/huge_memory.c                                   |  134 +-
 mm/hugetlb.c                                       |  625 ++++++--
 mm/hugetlb_cgroup.c                                |   20 +-
 mm/hugetlb_vmemmap.c                               |  301 +++-
 mm/hugetlb_vmemmap.h                               |   31 +-
 mm/internal.h                                      |  147 +-
 mm/kasan/kasan_test.c                              |   19 +-
 mm/kasan/kasan_test_module.c                       |    2 +-
 mm/kasan/quarantine.c                              |    4 +-
 mm/kasan/report.c                                  |    4 +-
 mm/kasan/report_generic.c                          |    6 +-
 mm/kasan/shadow.c                                  |    2 +-
 mm/khugepaged.c                                    |  137 +-
 mm/kmemleak.c                                      |  144 +-
 mm/kmsan/core.c                                    |  127 +-
 mm/kmsan/kmsan_test.c                              |  109 +-
 mm/kmsan/shadow.c                                  |    9 +-
 mm/ksm.c                                           |  116 ++
 mm/madvise.c                                       |   33 +-
 mm/memblock.c                                      |   49 +-
 mm/memcontrol.c                                    |  401 ++++-
 mm/memfd.c                                         |    6 -
 mm/memory-failure.c                                |   29 +-
 mm/memory-tiers.c                                  |  175 ++-
 mm/memory.c                                        |  302 ++--
 mm/memory_hotplug.c                                |    8 +-
 mm/mempolicy.c                                     | 1026 ++++++------
 mm/migrate.c                                       |  225 +--
 mm/mlock.c                                         |   95 +-
 mm/mm_init.c                                       |    4 +-
 mm/mmap.c                                          |  149 +-
 mm/mmzone.c                                        |    6 +-
 mm/mprotect.c                                      |   58 +-
 mm/mremap.c                                        |  107 +-
 mm/nommu.c                                         |    8 +-
 mm/oom_kill.c                                      |   16 +-
 mm/page-writeback.c                                |   37 +-
 mm/page_alloc.c                                    |  343 +++-
 mm/page_io.c                                       |    8 +-
 mm/page_owner.c                                    |    4 +-
 mm/percpu.c                                        |    8 +-
 mm/rmap.c                                          |  164 +-
 mm/shmem.c                                         |  588 +++----
 mm/show_mem.c                                      |   11 +-
 mm/shrinker.c                                      |  809 ++++++++++
 mm/shrinker_debug.c                                |   35 +-
 mm/slab.h                                          |   15 +-
 mm/swap.h                                          |    9 +-
 mm/swap_state.c                                    |   92 +-
 mm/util.c                                          |    1 +
 mm/vmalloc.c                                       |    2 +-
 mm/vmscan.c                                        |  734 +--------
 mm/vmstat.c                                        |   30 +-
 mm/workingset.c                                    |   29 +-
 mm/zsmalloc.c                                      |   29 +-
 mm/zswap.c                                         |   15 +-
 net/sunrpc/auth.c                                  |   20 +-
 tools/include/uapi/linux/fs.h                      |   59 +
 tools/include/uapi/linux/prctl.h                   |    3 +-
 tools/mm/page_owner_sort.c                         |  217 ++-
 tools/testing/radix-tree/linux.c                   |    4 +-
 tools/testing/selftests/cgroup/.gitignore          |    1 +
 tools/testing/selftests/cgroup/Makefile            |    2 +
 .../testing/selftests/cgroup/test_hugetlb_memcg.c  |  234 +++
 tools/testing/selftests/cgroup/test_zswap.c        |   48 +
 tools/testing/selftests/clone3/clone3.c            |    7 +-
 tools/testing/selftests/damon/sysfs.sh             |    1 +
 tools/testing/selftests/mm/.gitignore              |    2 +
 tools/testing/selftests/mm/Makefile                |    4 +-
 tools/testing/selftests/mm/config                  |    1 +
 tools/testing/selftests/mm/gup_longterm.c          |    3 +-
 tools/testing/selftests/mm/hugetlb-madvise.c       |   19 -
 .../selftests/mm/hugetlb_fault_after_madv.c        |   73 +
 tools/testing/selftests/mm/ksm_functional_tests.c  |   66 +-
 tools/testing/selftests/mm/mdwe_test.c             |  137 +-
 tools/testing/selftests/mm/mremap_test.c           |  301 +++-
 tools/testing/selftests/mm/pagemap_ioctl.c         | 1660 ++++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh          |    8 +
 tools/testing/selftests/mm/vm_util.c               |   19 +
 tools/testing/selftests/mm/vm_util.h               |    1 +
 276 files changed, 11648 insertions(+), 5255 deletions(-)
 create mode 100644 mm/damon/sysfs-test.h
 create mode 100644 mm/shrinker.c
 create mode 100644 tools/testing/selftests/cgroup/test_hugetlb_memcg.c
 create mode 100644 tools/testing/selftests/mm/hugetlb_fault_after_madv.c
 create mode 100644 tools/testing/selftests/mm/pagemap_ioctl.c

