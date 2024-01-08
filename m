Return-Path: <linux-kernel+bounces-20196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D75827BB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7E71C22F73
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 23:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1867556743;
	Mon,  8 Jan 2024 23:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RrOq+KOP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AC546541;
	Mon,  8 Jan 2024 23:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BC9C433F1;
	Mon,  8 Jan 2024 23:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1704757840;
	bh=K28zXEVACTUdoUzGigktuNjco412zSwaFBRKPYSubKU=;
	h=Date:From:To:Cc:Subject:From;
	b=RrOq+KOPN/iHFqmTxqqmqiUFsE5kwW8yJBwPTq30/yNq/8TGxAwGAesQIy3MxKzCy
	 rzLu/8jeZxmRYaBZPBRJc64uOFJGb9TIYWvVwugdKIcZmPiYknDIcmKx0Da/3U9pBr
	 mkQHyH+vLGxk/eBmDEH2yPUk7W0EPWR9oaSfctJw=
Date: Mon, 8 Jan 2024 15:50:39 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] MM updates for 6.8-rc1
Message-Id: <20240108155039.fd2798712a2a93a108b710ce@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


Linus, please merge the MM updates for this -rc cycle, thanks.


Present and forthcoming build issues (not flagged by a merging error)
and their linux-next resolutions:

kvm tree, virt/kvm/guest_memfd.c
	https://lkml.kernel.org/r/20231117092833.f143fa4bbf0abfbd2e58661d@linux-fo=
undation.org

        virt/kvm/guest_memfd.c is new in the KVM tree.  The
        above email identified the changes which this file will been
        when combined with mm.git's af7628d6ec19 ("fs: convert
        error_remove_page to error_remove_folio")

        See also
        https://lkml.kernel.org/r/20231211135052.4fb016a6@canb.auug.org.au

vfs-brauner tree, fs/netfs/buffered_write.c
	https://lkml.kernel.org/r/20231222104128.395c9f7b@canb.auug.org.au



Present and forthcoming merge issues and their linux-next resolutions
include:

drm-misc tree, drivers/accel/ivpu/ivpu_job.c:
	https://lkml.kernel.org/r/20231114113654.3bd7f0ee@canb.auug.org.au

vfs-brauner tree, fs/buffer.c:
	https://lkml.kernel.org/r/20231122103119.34d23955@canb.auug.org.au

slab tree, mm/kasan/quarantine.c:
	https://lkml.kernel.org/r/20231127122902.566de6d1@canb.auug.org.au
	https://lkml.kernel.org/r/20231221173124.78c7df98@canb.auug.org.au
	https://lkml.kernel.org/r/20240102151332.48a87d86@canb.auug.org.au

slab tree, mm/slab.c:
	https://lkml.kernel.org/r/20231221173412.24b78407@canb.auug.org.au

slab tree, mm/slab_common.c:
	https://lkml.kernel.org/r/20240102153438.5b29f8c5@canb.auug.org.au

asm-generic tree, arch/mips/include/asm/traps.h:
	https://lkml.kernel.org/r/20231205090546.7dffe3aa@canb.auug.org.au

char-misc tree, drivers/android/binder_alloc.c:
	https://lkml.kernel.org/r/20231207134213.25631ae9@canb.auug.org.au

vfs-brauner tree, fs/afs/write.c:
	https://lkml.kernel.org/r/20231221105238.4d16892a@canb.auug.org.au

drm tree, drivers/accel/qaic/qaic_data.c:
	https://lkml.kernel.org/r/20240102105223.7634699d@canb.auug.org.au

slab tree, include/linux/slab.h:
	https://lkml.kernel.org/r/20240102150224.3c091932@canb.auug.org.au



The following changes since commit 1803d0c5ee1a3bbee23db2336e21add067824f02:

  mailmap: add an old address for Naoya Horiguchi (2023-12-20 13:46:20 -080=
0)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2024=
-01-08-15-31

for you to fetch changes up to 5e0a760b44417f7cadd79de2204d6247109558a0:

  mm, treewide: rename MAX_ORDER to MAX_PAGE_ORDER (2024-01-08 15:27:15 -08=
00)

----------------------------------------------------------------
Many singleton patches against the MM code.  The patch series which
are included in this merge do the following:

- Peng Zhang has done some mapletree maintainance work in the
  series

	"maple_tree: add mt_free_one() and mt_attr() helpers"
	"Some cleanups of maple tree"

- In the series "mm: use memmap_on_memory semantics for dax/kmem"
  Vishal Verma has altered the interworking between memory-hotplug
  and dax/kmem so that newly added 'device memory' can more easily
  have its memmap placed within that newly added memory.

- Matthew Wilcox continues folio-related work (including a few
  fixes) in the patch series

	"Add folio_zero_tail() and folio_fill_tail()"
	"Make folio_start_writeback return void"
	"Fix fault handler's handling of poisoned tail pages"
	"Convert aops->error_remove_page to ->error_remove_folio"
	"Finish two folio conversions"
	"More swap folio conversions"

- Kefeng Wang has also contributed folio-related work in the series

	"mm: cleanup and use more folio in page fault"

- Jim Cromie has improved the kmemleak reporting output in the
  series "tweak kmemleak report format".

- In the series "stackdepot: allow evicting stack traces" Andrey
  Konovalov to permits clients (in this case KASAN) to cause
  eviction of no longer needed stack traces.

- Charan Teja Kalla has fixed some accounting issues in the page
  allocator's atomic reserve calculations in the series "mm:
  page_alloc: fixes for high atomic reserve caluculations".

- Dmitry Rokosov has added to the samples/ dorectory some sample
  code for a userspace memcg event listener application.  See the
  series "samples: introduce cgroup events listeners".

- Some mapletree maintanance work from Liam Howlett in the series
  "maple_tree: iterator state changes".

- Nhat Pham has improved zswap's approach to writeback in the
  series "workload-specific and memory pressure-driven zswap
  writeback".

- DAMON/DAMOS feature and maintenance work from SeongJae Park in
  the series

	"mm/damon: let users feed and tame/auto-tune DAMOS"
	"selftests/damon: add Python-written DAMON functionality tests"
	"mm/damon: misc updates for 6.8"

- Yosry Ahmed has improved memcg's stats flushing in the series
  "mm: memcg: subtree stats flushing and thresholds".

- In the series "Multi-size THP for anonymous memory" Ryan Roberts
  has added a runtime opt-in feature to transparent hugepages which
  improves performance by allocating larger chunks of memory during
  anonymous page faults.

- Matthew Wilcox has also contributed some cleanup and maintenance
  work against eh buffer_head code int he series "More buffer_head
  cleanups".

- Suren Baghdasaryan has done work on Andrea Arcangeli's series
  "userfaultfd move option".  UFFDIO_MOVE permits userspace heap
  compaction algorithms to move userspace's pages around rather than
  UFFDIO_COPY'a alloc/copy/free.

- Stefan Roesch has developed a "KSM Advisor", in the series
  "mm/ksm: Add ksm advisor".  This is a governor which tunes KSM's
  scanning aggressiveness in response to userspace's current needs.

- Chengming Zhou has optimized zswap's temporary working memory
  use in the series "mm/zswap: dstmem reuse optimizations and
  cleanups".

- Matthew Wilcox has performed some maintenance work on the
  writeback code, both code and within filesystems.  The series is
  "Clean up the writeback paths".

- Andrey Konovalov has optimized KASAN's handling of alloc and
  free stack traces for secondary-level allocators, in the series
  "kasan: save mempool stack traces".

- Andrey also performed some KASAN maintenance work in the series
  "kasan: assorted clean-ups".

- David Hildenbrand has gone to town on the rmap code.  Cleanups,
  more pte batching, folio conversions and more.  See the series
  "mm/rmap: interface overhaul".

- Kinsey Ho has contributed some maintenance work on the MGLRU
  code in the series "mm/mglru: Kconfig cleanup".

- Matthew Wilcox has contributed lruvec page accounting code
  cleanups in the series "Remove some lruvec page accounting
  functions".

----------------------------------------------------------------
Alexander Gordeev (2):
      pgtable: fix s390 ptdesc field comments
      pgtable: rename ptdesc _refcount field to __page_refcount

Andrea Arcangeli (2):
      mm/rmap: support move to different root anon_vma in folio_move_anon_r=
map()
      userfaultfd: UFFDIO_MOVE uABI

Andrei Vagin (2):
      fs/proc/task_mmu: report SOFT_DIRTY bits through the PAGEMAP_SCAN ioc=
tl
      selftests/mm: check that PAGEMAP_SCAN returns correct categories

Andrew Morton (3):
      sync mm-stable with mm-hotfixes-stable to pick up depended-upon chang=
es
      lib/maple_tree.c: fix build error due to hotfix alteration
      mm/list_lru.c: remove unused list_lru_from_kmem()

Andrey Konovalov (65):
      lib/stackdepot: print disabled message only if truly disabled
      lib/stackdepot: check disabled flag when fetching
      lib/stackdepot: simplify __stack_depot_save
      lib/stackdepot: drop valid bit from handles
      lib/stackdepot: add depot_fetch_stack helper
      lib/stackdepot: use fixed-sized slots for stack records
      lib/stackdepot: fix and clean-up atomic annotations
      lib/stackdepot: rework helpers for depot_alloc_stack
      lib/stackdepot: rename next_pool_required to new_pool_required
      lib/stackdepot: store next pool pointer in new_pool
      lib/stackdepot: store free stack records in a freelist
      lib/stackdepot: use read/write lock
      lib/stackdepot: use list_head for stack record links
      kmsan: use stack_depot_save instead of __stack_depot_save
      lib/stackdepot, kasan: add flags to __stack_depot_save and rename
      lib/stackdepot: add refcount for records
      lib/stackdepot: allow users to evict stack traces
      kasan: remove atomic accesses to stack ring entries
      kasan: check object_size in kasan_complete_mode_report_info
      kasan: use stack_depot_put for tag-based modes
      slub, kasan: improve interaction of KASAN and slub_debug poisoning
      kasan: use stack_depot_put for Generic mode
      lib/stackdepot: adjust DEPOT_POOLS_CAP for KMSAN
      kasan: rename kasan_slab_free_mempool to kasan_mempool_poison_object
      kasan: move kasan_mempool_poison_object
      kasan: document kasan_mempool_poison_object
      kasan: add return value for kasan_mempool_poison_object
      kasan: introduce kasan_mempool_unpoison_object
      kasan: introduce kasan_mempool_poison_pages
      kasan: introduce kasan_mempool_unpoison_pages
      kasan: clean up __kasan_mempool_poison_object
      kasan: save free stack traces for slab mempools
      kasan: clean up and rename ____kasan_kmalloc
      kasan: introduce poison_kmalloc_large_redzone
      kasan: save alloc stack traces for mempool
      mempool: skip slub_debug poisoning when KASAN is enabled
      mempool: use new mempool KASAN hooks
      mempool: introduce mempool_use_prealloc_only
      kasan: add mempool tests
      kasan: rename pagealloc tests
      kasan: reorder tests
      kasan: rename and document kasan_(un)poison_object_data
      skbuff: use mempool KASAN hooks
      io_uring: use mempool KASAN hook
      lib/stackdepot: add printk_deferred_enter/exit guards
      kasan: handle concurrent kasan_record_aux_stack calls
      kasan: memset free track in qlink_free
      lib/stackdepot: fix comment in include/linux/stackdepot.h
      xtensa, kasan: define KASAN_SHADOW_END
      kasan/arm64: improve comments for KASAN_SHADOW_START/END
      mm, kasan: use KASAN_TAG_KERNEL instead of 0xff
      kasan: improve kasan_non_canonical_hook
      kasan: clean up kasan_requires_meta
      kasan: update kasan_poison documentation comment
      kasan: clean up is_kfence_address checks
      kasan: respect CONFIG_KASAN_VMALLOC for kasan_flag_vmalloc
      kasan: check kasan_vmalloc_enabled in vmalloc tests
      kasan: export kasan_poison as GPL
      kasan: remove SLUB checks for page_alloc fallbacks in tests
      kasan: speed up match_all_mem_tag test for SW_TAGS
      kasan: clean up kasan_cache_create
      kasan: reuse kasan_track in kasan_stack_ring_entry
      kasan: simplify saving extra info into tracks
      kasan: simplify kasan_complete_mode_report_info for tag-based modes
      kasan: stop leaking stack trace handles

Andy Shevchenko (1):
      mm: list_lru: Update kernel documentation to follow the requirements

Anshuman Khandual (1):
      Documentation/mm: drop pte_bad() descriptions from arch page table he=
lpers

Baolin Wang (2):
      mm: huge_memory: batch tlb flush when splitting a pte-mapped THP
      mm: migrate: fix getting incorrect page mapping during page migration

Barry Song (3):
      mm/page_owner: record and dump free_pid and free_tgid
      mm: compaction: avoid fast_isolate_freepages blindly choose improper =
pageblock
      mm: zsmalloc: return -ENOSPC rather than -EINVAL in zs_malloc while s=
ize is too large

Borislav Petkov (AMD) (1):
      UBSAN: use the kernel panic message markers

Brendan Jackman (1):
      mm/page_alloc: dedupe some memcg uncharging logic

Catalin Marinas (1):
      kmemleak: avoid RCU stalls when freeing metadata for per-CPU pointers

Charan Teja Kalla (4):
      mm: page_alloc: correct high atomic reserve calculations
      mm: page_alloc: enforce minimum zone size to do high atomic reserves
      mm: page_alloc: unreserve highatomic page blocks before oom
      mm/sparsemem: fix race in accessing memory_section->usage

Chen Haonan (1):
      mm: use vma_pages() for vma objects

Chengming Zhou (5):
      mm/zswap: reuse dstmem when decompress
      mm/zswap: refactor out __zswap_load()
      mm/zswap: cleanup zswap_load()
      mm/zswap: cleanup zswap_writeback_entry()
      mm/zswap: change per-cpu mutex and buffer to per-acomp_ctx

David Hildenbrand (41):
      mm/rmap: rename hugepage_add* to hugetlb_add*
      mm/rmap: introduce and use hugetlb_remove_rmap()
      mm/rmap: introduce and use hugetlb_add_file_rmap()
      mm/rmap: introduce and use hugetlb_try_dup_anon_rmap()
      mm/rmap: introduce and use hugetlb_try_share_anon_rmap()
      mm/rmap: add hugetlb sanity checks for anon rmap handling
      mm/rmap: convert folio_add_file_rmap_range() into folio_add_file_rmap=
_[pte|ptes|pmd]()
      mm/memory: page_add_file_rmap() -> folio_add_file_rmap_[pte|pmd]()
      mm/huge_memory: page_add_file_rmap() -> folio_add_file_rmap_pmd()
      mm/migrate: page_add_file_rmap() -> folio_add_file_rmap_pte()
      mm/userfaultfd: page_add_file_rmap() -> folio_add_file_rmap_pte()
      mm/rmap: remove page_add_file_rmap()
      mm/rmap: factor out adding folio mappings into __folio_add_rmap()
      mm/rmap: introduce folio_add_anon_rmap_[pte|ptes|pmd]()
      mm/huge_memory: batch rmap operations in __split_huge_pmd_locked()
      mm/huge_memory: page_add_anon_rmap() -> folio_add_anon_rmap_pmd()
      mm/migrate: page_add_anon_rmap() -> folio_add_anon_rmap_pte()
      mm/ksm: page_add_anon_rmap() -> folio_add_anon_rmap_pte()
      mm/swapfile: page_add_anon_rmap() -> folio_add_anon_rmap_pte()
      mm/memory: page_add_anon_rmap() -> folio_add_anon_rmap_pte()
      mm/rmap: remove page_add_anon_rmap()
      mm/rmap: remove RMAP_COMPOUND
      mm/rmap: introduce folio_remove_rmap_[pte|ptes|pmd]()
      kernel/events/uprobes: page_remove_rmap() -> folio_remove_rmap_pte()
      mm/huge_memory: page_remove_rmap() -> folio_remove_rmap_pmd()
      mm/khugepaged: page_remove_rmap() -> folio_remove_rmap_pte()
      mm/ksm: page_remove_rmap() -> folio_remove_rmap_pte()
      mm/memory: page_remove_rmap() -> folio_remove_rmap_pte()
      mm/migrate_device: page_remove_rmap() -> folio_remove_rmap_pte()
      mm/rmap: page_remove_rmap() -> folio_remove_rmap_pte()
      Documentation: stop referring to page_remove_rmap()
      mm/rmap: remove page_remove_rmap()
      mm/rmap: convert page_dup_file_rmap() to folio_dup_file_rmap_[pte|pte=
s|pmd]()
      mm/rmap: introduce folio_try_dup_anon_rmap_[pte|ptes|pmd]()
      mm/huge_memory: page_try_dup_anon_rmap() -> folio_try_dup_anon_rmap_p=
md()
      mm/memory: page_try_dup_anon_rmap() -> folio_try_dup_anon_rmap_pte()
      mm/rmap: remove page_try_dup_anon_rmap()
      mm: convert page_try_share_anon_rmap() to folio_try_share_anon_rmap_[=
pte|pmd]()
      mm/rmap: rename COMPOUND_MAPPED to ENTIRELY_MAPPED
      mm: remove one last reference to page_add_*_rmap()
      mm/rmap: silence VM_WARN_ON_FOLIO() in __folio_rmap_sanity_checks()

Dmitry Rokosov (3):
      samples: introduce new samples subdir for cgroup
      samples/cgroup: introduce memcg memory.events listener
      mm: memcg: add reminder comment for the memcg v2 events

Dmytro Maluka (1):
      mm/thp: add CONFIG_TRANSPARENT_HUGEPAGE_NEVER option

Domenico Cerasuolo (3):
      zswap: make shrinking memcg-aware
      mm: memcg: add per-memcg zswap writeback stat
      selftests: cgroup: update per-memcg zswap writeback selftest

Fabio De Francesco (1):
      mm/util: use kmap_local_page() in memcmp_pages()

Fabio M. De Francesco (7):
      mm/ksm: use kmap_local_page() in calc_checksum()
      mm/memory: use kmap_local_page() in __wp_page_copy_user()
      mm/mempool: replace kmap_atomic() with kmap_local_page()
      mm/page_poison: replace kmap_atomic() with kmap_local_page()
      mm/zswap: replace kmap_atomic() with kmap_local_page()
      mm/swapfile: replace kmap_atomic() with kmap_local_page()
      mm/memory: replace kmap() with kmap_local_page()

Fangrui Song (1):
      mm: remove VM_EXEC requirement for THP eligibility

Jiapeng Chong (2):
      maple_tree: remove unused function
      maple_tree: fix warning comparing pointer to 0

Jim Cromie (2):
      kmemleak: drop (age <increasing>) from leak record
      kmemleak: add checksum to backtrace report

Juntong Deng (2):
      kasan: improve free meta storage in Generic KASAN
      kasan: record and report more information

Kefeng Wang (7):
      mm: ksm: use more folio api in ksm_might_need_to_copy()
      mm: memory: use a folio in validate_page_before_insert()
      mm: memory: rename page_copy_prealloc() to folio_prealloc()
      mm: memory: use a folio in do_cow_fault()
      mm: memory: use folio_prealloc() in wp_page_copy()
      mm: huge_memory: use more folio api in __split_huge_page_tail()
      mm: remove unnecessary ia64 code and comment

Kevin Hao (2):
      mm: ksm: remove unnecessary try_to_freeze()
      mm/khugepaged: remove redundant try_to_freeze()

Kinsey Ho (5):
      mm/mglru: add CONFIG_ARCH_HAS_HW_PTE_YOUNG
      mm/mglru: add CONFIG_LRU_GEN_WALKS_MMU
      mm/mglru: remove CONFIG_MEMCG
      mm/mglru: add dummy pmd_dirty()
      mm/mglru: remove CONFIG_TRANSPARENT_HUGEPAGE

Kirill A. Shutemov (2):
      mm, treewide: introduce NR_PAGE_ORDERS
      mm, treewide: rename MAX_ORDER to MAX_PAGE_ORDER

Levi Yun (1):
      maple_tree: change return type of mas_split_final_node as void.

Li Zhijian (2):
      mm/vmstat: move pgdemote_* to per-node stats
      mm/vmstat: move pgdemote_* out of CONFIG_NUMA_BALANCING

Li zeming (2):
      mm: filemap: remove unnecessary iitialization of ret
      mm: cma: remove unnecessary initialization of ret

Liam Ni (1):
      NUMA: optimize detection of memory with no node id assigned by firmwa=
re

Liam R. Howlett (12):
      maple_tree: remove unnecessary default labels from switch statements
      maple_tree: make mas_erase() more robust
      maple_tree: move debug check to __mas_set_range()
      maple_tree: add end of node tracking to the maple state
      maple_tree: use cached node end in mas_next()
      maple_tree: use cached node end in mas_destroy()
      maple_tree: clean up inlines for some functions
      maple_tree: separate ma_state node from status
      maple_tree: remove mas_searchable()
      maple_tree: use maple state end for write operations
      maple_tree: don't find node end in mtree_lookup_walk()
      maple_tree: mtree_range_walk() clean up

Lukas Bulwahn (1):
      mmap: remove the IA64-specific vma expansion implementation

Matthew Wilcox (Oracle) (70):
      mm: add folio_zero_tail() and use it in ext4
      mm: add folio_fill_tail() and use it in iomap
      gfs2: convert stuffed_readpage() to stuffed_read_folio()
      mm: remove test_set_page_writeback()
      afs: do not test the return value of folio_start_writeback()
      smb: do not test the return value of folio_start_writeback()
      mm: return void from folio_start_writeback() and related functions
      mm: make mapping_evict_folio() the preferred way to evict clean folios
      mm: convert __do_fault() to use a folio
      mm: use mapping_evict_folio() in truncate_error_page()
      mm: convert soft_offline_in_use_page() to use a folio
      mm: convert isolate_page() to mf_isolate_folio()
      mm: remove invalidate_inode_page()
      gfp: include __GFP_NOWARN in GFP_NOWAIT
      memory-failure: use a folio in me_pagecache_clean()
      memory-failure: use a folio in me_pagecache_dirty()
      memory-failure: convert delete_from_lru_cache() to take a folio
      memory-failure: use a folio in me_huge_page()
      memory-failure: convert truncate_error_page to truncate_error_folio
      fs: convert error_remove_page to error_remove_folio
      buffer: return bool from grow_dev_folio()
      buffer: calculate block number inside folio_init_buffers()
      buffer: fix grow_buffers() for block size > PAGE_SIZE
      buffer: cast block to loff_t before shifting it
      buffer: fix various functions for block size > PAGE_SIZE
      buffer: handle large folios in __block_write_begin_int()
      buffer: fix more functions for block size > PAGE_SIZE
      mm: convert ksm_might_need_to_copy() to work on folios
      mm: remove PageAnonExclusive assertions in unuse_pte()
      mm: convert unuse_pte() to use a folio throughout
      mm: remove some calls to page_add_new_anon_rmap()
      mm: remove stale example from comment
      mm: remove references to page_add_new_anon_rmap in comments
      mm: convert migrate_vma_insert_page() to use a folio
      mm: convert collapse_huge_page() to use a folio
      mm: remove page_add_new_anon_rmap and lru_cache_add_inactive_or_unevi=
ctable
      mm: return the folio from __read_swap_cache_async()
      mm: pass a folio to __swap_writepage()
      mm: pass a folio to swap_writepage_fs()
      mm: pass a folio to swap_writepage_bdev_sync()
      mm: pass a folio to swap_writepage_bdev_async()
      mm: pass a folio to swap_readpage_fs()
      mm: pass a folio to swap_readpage_bdev_sync()
      mm: pass a folio to swap_readpage_bdev_async()
      mm: convert swap_page_sector() to swap_folio_sector()
      mm: convert swap_readpage() to swap_read_folio()
      mm: remove page_swap_info()
      mm: return a folio from read_swap_cache_async()
      mm: convert swap_cluster_readahead and swap_vma_readahead to return a=
 folio
      fs: remove clean_page_buffers()
      fs: convert clean_buffers() to take a folio
      fs: reduce stack usage in __mpage_writepage
      fs: reduce stack usage in do_mpage_readpage
      adfs: remove writepage implementation
      bfs: remove writepage implementation
      hfs: really remove hfs_writepage
      hfsplus: really remove hfsplus_writepage
      minix: remove writepage implementation
      ocfs2: remove writepage implementation
      sysv: remove writepage implementation
      ufs: remove writepage implementation
      fs: convert block_write_full_page to block_write_full_folio
      fs: remove the bh_end_io argument from __block_write_full_folio
      buffer: fix unintended successful return
      mm: remove inc/dec lruvec page state functions
      slub: use alloc_pages_node() in alloc_slab_page()
      slub: use folio APIs in free_large_kmalloc()
      slub: use a folio in __kmalloc_large_node
      mm/khugepaged: use a folio more in collapse_file()
      mm/memcontrol: remove __mod_lruvec_page_state()

Minjie Du (1):
      mm/filemap: increase usage of folio_next_index() helper

Muchun Song (6):
      mm: pagewalk: assert write mmap lock only for walking the user page t=
ables
      mm: hugetlb_vmemmap: use walk_page_range_novma() to simplify the code
      mm: hugetlb_vmemmap: move PageVmemmapSelfHosted() check to split_vmem=
map_huge_pmd()
      mm: hugetlb_vmemmap: convert page to folio
      mm: hugetlb_vmemmap: add check of CONFIG_MEMORY_HOTPLUG back
      mm: hugetlb_vmemmap: move mmap lock to vmemmap_remap_range()

Muhammad Usama Anjum (5):
      mm/selftests: hugepage-mremap: conform test to TAP format output
      selftests/mm: gup_test: conform test to TAP format output
      selftests: mm: hugepage-mmap: conform to TAP format output
      selftests/mm: conform test to TAP format output
      selftests/mm: skip test if application doesn't has root privileges

Nhat Pham (4):
      list_lru: allow explicit memcg and NUMA node selection
      memcontrol: implement mem_cgroup_tryget_online()
      zswap: shrink zswap pool based on memory pressure
      zswap: memcontrol: implement zswap writeback disabling

Nico Pache (1):
      selftests/mm: dont run ksm_functional_tests twice

Paul Heidekr=FCger (1):
      kasan: default to inline instrumentation

Peng Zhang (16):
      maple_tree: add mt_free_one() and mt_attr() helpers
      maple_tree: introduce {mtree,mas}_lock_nested()
      maple_tree: introduce interfaces __mt_dup() and mtree_dup()
      radix tree test suite: align kmem_cache_alloc_bulk() with kernel beha=
vior.
      maple_tree: add test for mtree_dup()
      maple_tree: update the documentation of maple tree
      maple_tree: skip other tests when BENCH is enabled
      maple_tree: update check_forking() and bench_forking()
      maple_tree: preserve the tree attributes when destroying maple tree
      fork: use __mt_dup() to duplicate maple tree in dup_mmap()
      maple_tree: move the check forward to avoid static check warning
      maple_tree: avoid ascending when mas->min is also the parent's minimum
      maple_tree: remove an unused parameter for ma_meta_end()
      maple_tree: delete one of the two identical checks
      maple_tree: simplify mas_leaf_set_meta()
      maple_tree: avoid checking other gaps after getting the largest gap

Peter Xu (2):
      fs/Kconfig: make hugetlbfs a menuconfig
      mm/gup: fix follow_devmap_p[mu]d() on page=3D=3DNULL handling

Randy Dunlap (2):
      maple_tree: fix typos/spellos etc
      gfp: gfp_types.h: fix typos & punctuation

Ryan Roberts (12):
      mm/readahead: do not allow order-1 folio
      mm: allow deferred splitting of arbitrary anon large folios
      mm: non-pmd-mappable, large folios for folio_add_new_anon_rmap()
      mm: thp: introduce multi-size THP sysfs interface
      mm: thp: support allocation of anonymous multi-size THP
      selftests/mm/kugepaged: restore thp settings at exit
      selftests/mm: factor out thp settings management
      selftests/mm: support multi-size THP interface in thp_settings
      selftests/mm/khugepaged: enlighten for multi-size THP
      selftests/mm/cow: generalize do_run_with_thp() helper
      selftests/mm/cow: add tests for anonymous multi-size THP
      selftests/mm: log run_vmtests.sh results in TAP format

SeongJae Park (21):
      mm/damon/core-test: test damon_split_region_at()'s access rate copying
      mm/damon/core: implement goal-oriented feedback-driven quota auto-tun=
ing
      mm/damon/sysfs-schemes: implement files for scheme quota goals setup
      mm/damon/sysfs-schemes: commit damos quota goals user input to DAMOS
      mm/damon/sysfs-schemes: implement a command for scheme quota goals on=
ly commit
      mm/damon/core-test: add a unit test for the feedback loop algorithm
      selftests/damon: test quota goals directory
      Docs/mm/damon/design: document DAMOS quota auto tuning
      Docs/ABI/damon: document DAMOS quota goals
      Docs/admin-guide/mm/damon/usage: document for quota goals
      selftests/damon: implement a python module for test-purpose DAMON sys=
fs controls
      selftests/damon/_damon_sysfs: implement kdamonds start function
      selftests/damon/_damon_sysfs: implement updat_schemes_tried_bytes com=
mand
      selftests/damon: add a test for update_schemes_tried_regions sysfs co=
mmand
      selftests/damon: add a test for update_schemes_tried_regions hang bug
      mm/damon: update email of SeongJae
      mm/damon/core-test: test max_nr_accesses overflow caused divide-by-ze=
ro
      Docs/mm/damon/design: place execution model and data structures at th=
e beginning
      Docs/admin-guide/mm/damon/usage: update context directory section lab=
el
      Docs/admin-guide/mm/damon/usage: add links to sysfs files hierarchy
      Docs/admin-guide/mm/damon/usage: use a list for 'state' sysfs file in=
put commands

Serge Semin (2):
      mm/mm_init.c: extend init unavailable range doc info
      mm/mm_init.c: append newline to the unavailable ranges log-message

Sergey Senozhatsky (3):
      zram: split memory-tracking and ac-time tracking
      zram: tweak writeback config help
      zram: use kmap_local_page()

Shakeel Butt (1):
      mm: ratelimit stat flush from workingset shrinker

Stefan Roesch (4):
      mm/ksm: add ksm advisor
      mm/ksm: add sysfs knobs for advisor
      mm/ksm: add tracepoint for ksm advisor
      mm/ksm: document ksm advisor and its sysfs knobs

Steven Rostedt (Google) (1):
      mm/rmap: fix misplaced parenthesis of a likely()

Sumanth Korikkar (1):
      mm: use vmem_altmap code without CONFIG_ZONE_DEVICE

Suren Baghdasaryan (5):
      selftests/mm: call uffd_test_ctx_clear at the end of the test
      selftests/mm: add uffd_test_case_ops to allow test case-specific oper=
ations
      selftests/mm: add UFFDIO_MOVE ioctl test
      userfaultfd: fix move_pages_pte() splitting folio under RCU read lock
      selftests/mm: add separate UFFDIO_MOVE test for PMD splitting

Tanzir Hasan (1):
      mm/damon/vaddr: change asm-generic/mman-common.h to linux/mman.h

Vishal Verma (3):
      mm/memory_hotplug: replace an open-coded kmemdup() in add_memory_reso=
urce()
      mm/memory_hotplug: split memmap_on_memory requests across memblocks
      dax/kmem: allow kmem to add memory with memmap_on_memory

Yajun Deng (1):
      mm: page_alloc: simplify __free_pages_ok()

Yong Wang (1):
      mm, oom:dump_tasks add rss detailed information printing

York Jasper Niebuhr (1):
      mm: fix process_vm_rw page counts

Yosry Ahmed (5):
      mm: memcg: change flush_next_time to flush_last_time
      mm: memcg: move vmstats structs definition above flushing code
      mm: memcg: make stats flushing threshold per-memcg
      mm: workingset: move the stats flush into workingset_test_recent()
      mm: memcg: restore subtree stats flushing

 Documentation/ABI/testing/sysfs-kernel-mm-damon    |   33 +-
 Documentation/admin-guide/blockdev/zram.rst        |    2 +-
 Documentation/admin-guide/cgroup-v2.rst            |   15 +
 Documentation/admin-guide/kdump/vmcoreinfo.rst     |    8 +-
 Documentation/admin-guide/kernel-parameters.txt    |   24 +-
 Documentation/admin-guide/mm/damon/usage.rst       |  147 ++-
 Documentation/admin-guide/mm/ksm.rst               |   55 +
 Documentation/admin-guide/mm/pagemap.rst           |    1 +
 Documentation/admin-guide/mm/transhuge.rst         |   97 +-
 Documentation/admin-guide/mm/userfaultfd.rst       |    3 +
 Documentation/admin-guide/mm/zswap.rst             |   20 +
 Documentation/core-api/maple_tree.rst              |    4 +
 Documentation/filesystems/locking.rst              |    4 +-
 Documentation/filesystems/proc.rst                 |    6 +-
 Documentation/filesystems/vfs.rst                  |    6 +-
 Documentation/mm/arch_pgtable_helpers.rst          |    2 -
 Documentation/mm/damon/design.rst                  |   37 +-
 Documentation/mm/transhuge.rst                     |    4 +-
 Documentation/mm/unevictable-lru.rst               |    4 +-
 Documentation/networking/packet_mmap.rst           |   14 +-
 MAINTAINERS                                        |    1 +
 arch/Kconfig                                       |    8 +
 arch/arm/Kconfig                                   |    2 +-
 arch/arm64/Kconfig                                 |   21 +-
 arch/arm64/include/asm/kasan.h                     |   22 +-
 arch/arm64/include/asm/memory.h                    |   38 +-
 arch/arm64/include/asm/sparsemem.h                 |    2 +-
 arch/arm64/kvm/hyp/include/nvhe/gfp.h              |    2 +-
 arch/arm64/kvm/hyp/nvhe/page_alloc.c               |    3 +-
 arch/arm64/mm/hugetlbpage.c                        |    2 +-
 arch/arm64/mm/kasan_init.c                         |    5 +
 arch/loongarch/include/asm/pgtable.h               |    1 +
 arch/loongarch/kernel/numa.c                       |   28 +-
 arch/m68k/Kconfig.cpu                              |    2 +-
 arch/mips/include/asm/pgtable.h                    |    1 +
 arch/nios2/Kconfig                                 |    2 +-
 arch/powerpc/Kconfig                               |    2 +-
 arch/powerpc/mm/book3s64/iommu_api.c               |    2 +-
 arch/powerpc/mm/hugetlbpage.c                      |    2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |    2 +-
 arch/riscv/include/asm/pgtable.h                   |    1 +
 arch/s390/include/asm/pgtable.h                    |    1 +
 arch/sh/mm/Kconfig                                 |    2 +-
 arch/sparc/Kconfig                                 |    2 +-
 arch/sparc/include/asm/pgtable_64.h                |    1 +
 arch/sparc/kernel/pci_sun4v.c                      |    2 +-
 arch/sparc/kernel/traps_64.c                       |    2 +-
 arch/sparc/mm/tsb.c                                |    4 +-
 arch/um/kernel/um_arch.c                           |    4 +-
 arch/x86/Kconfig                                   |    1 +
 arch/x86/include/asm/pgtable.h                     |    7 +-
 arch/x86/mm/numa.c                                 |   34 +-
 arch/xtensa/Kconfig                                |    2 +-
 arch/xtensa/include/asm/kasan.h                    |    2 +
 block/fops.c                                       |   23 +-
 drivers/accel/qaic/qaic_data.c                     |    2 +-
 drivers/android/binder_alloc.c                     |    7 +-
 drivers/base/regmap/regmap-debugfs.c               |    8 +-
 drivers/block/floppy.c                             |    2 +-
 drivers/block/zram/Kconfig                         |   15 +-
 drivers/block/zram/zram_drv.c                      |   57 +-
 drivers/block/zram/zram_drv.h                      |    2 +-
 drivers/crypto/ccp/sev-dev.c                       |    2 +-
 drivers/crypto/hisilicon/sgl.c                     |    6 +-
 drivers/dax/bus.c                                  |    3 +
 drivers/dax/bus.h                                  |    1 +
 drivers/dax/cxl.c                                  |    1 +
 drivers/dax/dax-private.h                          |    1 +
 drivers/dax/hmem/hmem.c                            |    1 +
 drivers/dax/kmem.c                                 |    8 +-
 drivers/dax/pmem.c                                 |    1 +
 drivers/gpu/drm/i915/gem/i915_gem_internal.c       |    2 +-
 drivers/gpu/drm/i915/gem/selftests/huge_pages.c    |    2 +-
 drivers/gpu/drm/ttm/tests/ttm_device_test.c        |    2 +-
 drivers/gpu/drm/ttm/tests/ttm_pool_test.c          |    8 +-
 drivers/gpu/drm/ttm/ttm_pool.c                     |   22 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h        |    2 +-
 drivers/iommu/dma-iommu.c                          |    2 +-
 drivers/irqchip/irq-gic-v3-its.c                   |    4 +-
 drivers/md/dm-bufio.c                              |    2 +-
 drivers/md/dm-crypt.c                              |    2 +-
 drivers/md/dm-flakey.c                             |    2 +-
 drivers/misc/genwqe/card_dev.c                     |    2 +-
 drivers/misc/genwqe/card_utils.c                   |    4 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |    2 +-
 drivers/net/ethernet/ibm/ibmvnic.h                 |    4 +-
 drivers/video/fbdev/hyperv_fb.c                    |    6 +-
 drivers/video/fbdev/vermilion/vermilion.c          |    2 +-
 drivers/virtio/virtio_balloon.c                    |    2 +-
 drivers/virtio/virtio_mem.c                        |    8 +-
 fs/Kconfig                                         |   22 +-
 fs/adfs/inode.c                                    |   11 +-
 fs/afs/write.c                                     |    8 +-
 fs/bcachefs/fs.c                                   |    2 +-
 fs/bfs/file.c                                      |    9 +-
 fs/btrfs/inode.c                                   |    2 +-
 fs/buffer.c                                        |  175 ++--
 fs/ceph/addr.c                                     |    4 +-
 fs/dcache.c                                        |    8 +-
 fs/ext2/inode.c                                    |    2 +-
 fs/ext4/inline.c                                   |    3 +-
 fs/ext4/inode.c                                    |    6 +-
 fs/ext4/page-io.c                                  |    2 +-
 fs/f2fs/compress.c                                 |    2 +-
 fs/f2fs/inode.c                                    |    2 +-
 fs/gfs2/aops.c                                     |   47 +-
 fs/gfs2/quota.c                                    |    6 +-
 fs/hfs/inode.c                                     |    8 +-
 fs/hfsplus/inode.c                                 |    8 +-
 fs/hugetlbfs/inode.c                               |    6 +-
 fs/inode.c                                         |    4 +-
 fs/iomap/buffered-io.c                             |   14 +-
 fs/minix/inode.c                                   |    9 +-
 fs/mpage.c                                         |   62 +-
 fs/nfs/file.c                                      |    2 +-
 fs/nfs/nfs42xattr.c                                |    8 +-
 fs/nfsd/filecache.c                                |    4 +-
 fs/ntfs/aops.c                                     |   10 +-
 fs/ocfs2/alloc.c                                   |    2 +-
 fs/ocfs2/aops.c                                    |   17 +-
 fs/ocfs2/file.c                                    |    2 +-
 fs/ocfs2/ocfs2_trace.h                             |    2 -
 fs/proc/task_mmu.c                                 |   20 +-
 fs/ramfs/file-nommu.c                              |    2 +-
 fs/smb/client/file.c                               |    6 +-
 fs/sysv/itree.c                                    |    9 +-
 fs/ufs/inode.c                                     |   11 +-
 fs/userfaultfd.c                                   |   72 ++
 fs/xfs/xfs_aops.c                                  |    2 +-
 fs/xfs/xfs_buf.c                                   |    6 +-
 fs/xfs/xfs_dquot.c                                 |    2 +-
 fs/xfs/xfs_qm.c                                    |    2 +-
 fs/zonefs/file.c                                   |    2 +-
 include/drm/ttm/ttm_pool.h                         |    2 +-
 include/linux/buffer_head.h                        |    9 +-
 include/linux/cpuhotplug.h                         |    1 -
 include/linux/damon.h                              |   22 +-
 include/linux/fs.h                                 |    2 +-
 include/linux/gfp_types.h                          |   17 +-
 include/linux/highmem.h                            |   76 ++
 include/linux/huge_mm.h                            |  184 +++-
 include/linux/hugetlb.h                            |    2 +-
 include/linux/kasan.h                              |  162 ++-
 include/linux/ksm.h                                |   10 +-
 include/linux/list_lru.h                           |   88 +-
 include/linux/maple_tree.h                         |  349 ++++---
 include/linux/memblock.h                           |    1 +
 include/linux/memcontrol.h                         |   37 +-
 include/linux/mempool.h                            |    1 +
 include/linux/memremap.h                           |   12 -
 include/linux/mm.h                                 |   50 +-
 include/linux/mm_types.h                           |   27 +-
 include/linux/mmzone.h                             |   66 +-
 include/linux/page-flags.h                         |    9 +-
 include/linux/pageblock-flags.h                    |    4 +-
 include/linux/pgtable.h                            |    9 +-
 include/linux/rmap.h                               |  411 ++++++--
 include/linux/slab.h                               |    4 +-
 include/linux/stackdepot.h                         |   61 +-
 include/linux/swap.h                               |    8 +-
 include/linux/userfaultfd_k.h                      |   11 +
 include/linux/vm_event_item.h                      |    4 +-
 include/linux/vmstat.h                             |   60 +-
 include/linux/zswap.h                              |   32 +-
 include/trace/events/ksm.h                         |   33 +
 include/uapi/linux/fs.h                            |    1 +
 include/uapi/linux/userfaultfd.h                   |   29 +-
 io_uring/alloc_cache.h                             |    5 +-
 kernel/crash_core.c                                |    2 +-
 kernel/dma/pool.c                                  |    6 +-
 kernel/dma/swiotlb.c                               |    4 +-
 kernel/events/ring_buffer.c                        |   10 +-
 kernel/events/uprobes.c                            |    4 +-
 kernel/fork.c                                      |   42 +-
 lib/Kconfig                                        |   10 +
 lib/Kconfig.kasan                                  |   23 +-
 lib/maple_tree.c                                   | 1088 +++++++++++++---=
----
 lib/stackdepot.c                                   |  461 ++++++---
 lib/test_maple_tree.c                              |  331 +++---
 lib/test_meminit.c                                 |    2 +-
 lib/ubsan.c                                        |    7 +-
 mm/Kconfig                                         |   32 +-
 mm/cma.c                                           |    2 +-
 mm/compaction.c                                    |    9 +-
 mm/damon/core-test.h                               |   60 +-
 mm/damon/core.c                                    |   70 +-
 mm/damon/dbgfs-test.h                              |    2 +-
 mm/damon/dbgfs.c                                   |    2 +-
 mm/damon/modules-common.c                          |    2 +-
 mm/damon/sysfs-common.h                            |    3 +
 mm/damon/sysfs-schemes.c                           |  272 ++++-
 mm/damon/sysfs.c                                   |   27 +
 mm/damon/vaddr-test.h                              |    2 +-
 mm/damon/vaddr.c                                   |    4 +-
 mm/debug_page_alloc.c                              |    2 +-
 mm/debug_vm_pgtable.c                              |    4 +-
 mm/filemap.c                                       |   14 +-
 mm/folio-compat.c                                  |   20 +-
 mm/gup.c                                           |    4 +-
 mm/huge_memory.c                                   |  456 ++++++--
 mm/hugetlb.c                                       |   25 +-
 mm/hugetlb_vmemmap.c                               |  276 ++---
 mm/internal.h                                      |   41 +-
 mm/kasan/common.c                                  |  280 +++--
 mm/kasan/generic.c                                 |  175 +++-
 mm/kasan/hw_tags.c                                 |    8 +
 mm/kasan/kasan.h                                   |   93 +-
 mm/kasan/kasan_test.c                              |  877 +++++++++++-----
 mm/kasan/quarantine.c                              |   14 +-
 mm/kasan/report.c                                  |   46 +-
 mm/kasan/report_generic.c                          |    6 +-
 mm/kasan/report_tags.c                             |   27 +-
 mm/kasan/shadow.c                                  |   18 +-
 mm/kasan/tags.c                                    |   24 +-
 mm/khugepaged.c                                    |   73 +-
 mm/kmemleak.c                                      |  186 ++--
 mm/kmsan/core.c                                    |    7 +-
 mm/kmsan/init.c                                    |    8 +-
 mm/ksm.c                                           |  388 ++++++-
 mm/list_lru.c                                      |   79 +-
 mm/madvise.c                                       |   22 +-
 mm/memblock.c                                      |   41 +-
 mm/memcontrol.c                                    |  319 +++---
 mm/memory-failure.c                                |  119 ++-
 mm/memory.c                                        |  292 ++++--
 mm/memory_hotplug.c                                |  219 ++--
 mm/mempool.c                                       |   75 +-
 mm/memremap.c                                      |   32 +-
 mm/migrate.c                                       |   39 +-
 mm/migrate_device.c                                |   64 +-
 mm/mm_init.c                                       |   71 +-
 mm/mmap.c                                          |   46 +-
 mm/mmu_gather.c                                    |    2 +-
 mm/mmzone.c                                        |    1 +
 mm/oom_kill.c                                      |    7 +-
 mm/page-writeback.c                                |   54 +-
 mm/page_alloc.c                                    |   84 +-
 mm/page_io.c                                       |   84 +-
 mm/page_isolation.c                                |   17 +-
 mm/page_owner.c                                    |   16 +-
 mm/page_poison.c                                   |    8 +-
 mm/page_reporting.c                                |    6 +-
 mm/page_vma_mapped.c                               |    3 +-
 mm/pagewalk.c                                      |   29 +-
 mm/process_vm_access.c                             |   15 +-
 mm/readahead.c                                     |   14 +-
 mm/rmap.c                                          |  499 +++++----
 mm/shmem.c                                         |   17 +-
 mm/show_mem.c                                      |    8 +-
 mm/shuffle.h                                       |    2 +-
 mm/slab.c                                          |   12 +-
 mm/slab_common.c                                   |   14 +-
 mm/slub.c                                          |   55 +-
 mm/sparse.c                                        |   17 +-
 mm/swap.h                                          |   28 +-
 mm/swap_state.c                                    |  121 ++-
 mm/swapfile.c                                      |  105 +-
 mm/truncate.c                                      |   51 +-
 mm/userfaultfd.c                                   |  627 ++++++++++-
 mm/util.c                                          |    8 +-
 mm/vmscan.c                                        |  280 ++---
 mm/vmstat.c                                        |   21 +-
 mm/workingset.c                                    |   46 +-
 mm/zsmalloc.c                                      |    5 +-
 mm/zswap.c                                         |  746 +++++++++-----
 net/core/skbuff.c                                  |   10 +-
 net/smc/smc_ib.c                                   |    2 +-
 samples/Kconfig                                    |    6 +
 samples/Makefile                                   |    1 +
 samples/cgroup/Makefile                            |    5 +
 {tools =3D> samples}/cgroup/cgroup_event_listener.c  |    0
 samples/cgroup/memcg_event_listener.c              |  330 ++++++
 security/integrity/ima/ima_crypto.c                |    2 +-
 tools/cgroup/Makefile                              |   11 -
 tools/include/linux/rwsem.h                        |    4 +
 tools/include/linux/spinlock.h                     |    1 +
 tools/include/uapi/linux/fs.h                      |    1 +
 tools/perf/Documentation/perf-intel-pt.txt         |    2 +-
 tools/testing/memblock/linux/mmzone.h              |    6 +-
 tools/testing/radix-tree/linux.c                   |   45 +-
 tools/testing/radix-tree/linux/maple_tree.h        |    2 +-
 tools/testing/radix-tree/maple.c                   |  396 ++++++-
 tools/testing/selftests/cgroup/test_zswap.c        |   74 +-
 tools/testing/selftests/damon/Makefile             |    3 +
 tools/testing/selftests/damon/_damon_sysfs.py      |  322 ++++++
 tools/testing/selftests/damon/access_memory.c      |   41 +
 tools/testing/selftests/damon/sysfs.sh             |   27 +
 .../sysfs_update_schemes_tried_regions_hang.py     |   33 +
 ..._update_schemes_tried_regions_wss_estimation.py |   55 +
 tools/testing/selftests/mm/Makefile                |    4 +-
 tools/testing/selftests/mm/compaction_test.c       |   91 +-
 tools/testing/selftests/mm/cow.c                   |  183 +++-
 tools/testing/selftests/mm/gup_test.c              |   65 +-
 tools/testing/selftests/mm/hugepage-mmap.c         |   23 +-
 tools/testing/selftests/mm/hugepage-mremap.c       |   87 +-
 tools/testing/selftests/mm/khugepaged.c            |  410 ++------
 tools/testing/selftests/mm/run_vmtests.sh          |   55 +-
 tools/testing/selftests/mm/thp_settings.c          |  349 +++++++
 tools/testing/selftests/mm/thp_settings.h          |   80 ++
 tools/testing/selftests/mm/thuge-gen.c             |    3 +-
 tools/testing/selftests/mm/uffd-common.c           |   39 +-
 tools/testing/selftests/mm/uffd-common.h           |    9 +
 tools/testing/selftests/mm/uffd-stress.c           |    5 +-
 tools/testing/selftests/mm/uffd-unit-tests.c       |  209 ++++
 tools/testing/selftests/mm/vm_util.c               |   80 +-
 305 files changed, 11329 insertions(+), 5032 deletions(-)
 create mode 100644 samples/cgroup/Makefile
 rename {tools =3D> samples}/cgroup/cgroup_event_listener.c (100%)
 create mode 100644 samples/cgroup/memcg_event_listener.c
 delete mode 100644 tools/cgroup/Makefile
 create mode 100644 tools/testing/selftests/damon/_damon_sysfs.py
 create mode 100644 tools/testing/selftests/damon/access_memory.c
 create mode 100644 tools/testing/selftests/damon/sysfs_update_schemes_trie=
d_regions_hang.py
 create mode 100644 tools/testing/selftests/damon/sysfs_update_schemes_trie=
d_regions_wss_estimation.py
 create mode 100644 tools/testing/selftests/mm/thp_settings.c
 create mode 100644 tools/testing/selftests/mm/thp_settings.h


