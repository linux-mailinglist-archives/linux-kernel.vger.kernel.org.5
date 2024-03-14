Return-Path: <linux-kernel+bounces-102736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2A787B6B0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991A61F24F30
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF078BEC;
	Thu, 14 Mar 2024 03:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TkpWvgzh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265B7611A;
	Thu, 14 Mar 2024 03:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710385534; cv=none; b=rjy9kkZpPpDJPSZ3pbrgBS1Z6AXvJQvpz48+YVzV38Gfkb8pehBTkKk00fOkBK5JL0ggiUDEd1ZliCaSqBFnHUD6DE1shV4/IPv31I6nRMUPCPPSPzorxDa9w6uzOwqc6ZbPO0AMo+2TX404pddUn7WJGnKWhdCnY84zaLAKxN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710385534; c=relaxed/simple;
	bh=NWCZZE1yQpFC69KJ1ANJc6hefrKzLiV1xyloWduM0Js=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=FOUSHywER/3vBvlXyAw8wFP1Ww93laNkx98Nfdnf8sXhv0cHqeVymwqx0iJ7OGYLaIU6OW7fKrKK+YmoVAQ/fPF0Ik1dNGOlQMMLYMOSCiLoTsDPsdPmYm7UAjM5i54Ju2x4ZfF7SYhWP4GfvC14Uj24gmtbbggMkXXQ/0kLN8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TkpWvgzh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3F1C433C7;
	Thu, 14 Mar 2024 03:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1710385533;
	bh=NWCZZE1yQpFC69KJ1ANJc6hefrKzLiV1xyloWduM0Js=;
	h=Date:From:To:Cc:Subject:From;
	b=TkpWvgzhnAt9cmRZywOk7cMRNF7UWKffB0mK1exIQasB6VG1o1RhwTGdOJ5tufxXS
	 dhgOIi28AjmVK4YFIsYuZbVzvy7P5YvdKHdIi7jQNepWYB/dO9giNq3EujgOg6ILUk
	 G/s6sxgMAK71oy8apCr8f27fj4HjxPf/BAIt/Ryg=
Date: Wed, 13 Mar 2024 20:05:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] MM updates for 6.9-rc1
Message-Id: <20240313200532.34e4cff216acd3db8def4637@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


Linus, please merge the MM updates for this development cycle, thanks.

Current conflicts and their linux-next resolutions are:

include/linux/sched.h. vs block tree:
https://lkml.kernel.org/r/20240214112519.153c8480@canb.auug.org.au

init/main.c. vs vfs-brauner tree:
https://lkml.kernel.org/r/20240221103200.165d8cd5@canb.auug.org.au

mm/vmalloc.c, vs bpf-next tree:
https://lkml.kernel.org/r/20240307123619.159f1c4c@canb.auug.org.au


Upcoming conflicts include:

Documentation/process/changes.rst, vs rust tree:
https://lkml.kernel.org/r/20240129133352.25a3ee19@canb.auug.org.au
https://lkml.kernel.org/r/20240301153347.3b909702@canb.auug.org.au

arch/riscv/include/asm/ftrace.h, vs risc-v-fixes tree:
https://lkml.kernel.org/r/20240226092711.7985af2e@canb.auug.org.au

arch/powerpc/mm/pgtable_32.c, vs powerpc tree:
https://lkml.kernel.org/r/20240229101721.58569685@canb.auug.org.au

Thanks.


The following changes since commit 720da1e593b85a550593b415bf1d79a053133451:

  mm/debug_vm_pgtable: fix BUG_ON with pud advanced test (2024-02-23 17:27:=
13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2024=
-03-13-20-04

for you to fetch changes up to 270700dd06ca41a4779c19eb46608f076bb7d40e:

  mm/zswap: remove the memcpy if acomp is not sleepable (2024-03-13 12:12:2=
1 -0700)

----------------------------------------------------------------
- Sumanth Korikkar has taught s390 to allocate hotplug-time page frames
  from hotplugged memory rather than only from main memory.  Series
  "implement "memmap on memory" feature on s390".

- More folio conversions from Matthew Wilcox in the series

	"Convert memcontrol charge moving to use folios"
	"mm: convert mm counter to take a folio"

- Chengming Zhou has optimized zswap's rbtree locking, providing
  significant reductions in system time and modest but measurable
  reductions in overall runtimes.  The series is "mm/zswap: optimize the
  scalability of zswap rb-tree".

- Chengming Zhou has also provided the series "mm/zswap: optimize zswap
  lru list" which provides measurable runtime benefits in some
  swap-intensive situations.

- And Chengming Zhou further optimizes zswap in the series "mm/zswap:
  optimize for dynamic zswap_pools".  Measured improvements are modest.

- zswap cleanups and simplifications from Yosry Ahmed in the series "mm:
  zswap: simplify zswap_swapoff()".

- In the series "Add DAX ABI for memmap_on_memory", Vishal Verma has
  contributed several DAX cleanups as well as adding a sysfs tunable to
  control the memmap_on_memory setting when the dax device is hotplugged
  as system memory.

- Johannes Weiner has added the large series "mm: zswap: cleanups",
  which does that.

- More DAMON work from SeongJae Park in the series

	"mm/damon: make DAMON debugfs interface deprecation unignorable"
	"selftests/damon: add more tests for core functionalities and corner cases"
	"Docs/mm/damon: misc readability improvements"
	"mm/damon: let DAMOS feeds and tame/auto-tune itself"

- In the series "mm/mempolicy: weighted interleave mempolicy and sysfs
  extension" Rakie Kim has developed a new mempolicy interleaving policy
  wherein we allocate memory across nodes in a weighted fashion rather
  than uniformly.  This is beneficial in heterogeneous memory environments
  appearing with CXL.

- Christophe Leroy has contributed some cleanup and consolidation work
  against the ARM pagetable dumping code in the series "mm: ptdump:
  Refactor CONFIG_DEBUG_WX and check_wx_pages debugfs attribute".

- Luis Chamberlain has added some additional xarray selftesting in the
  series "test_xarray: advanced API multi-index tests".

- Muhammad Usama Anjum has reworked the selftest code to make its
  human-readable output conform to the TAP ("Test Anything Protocol")
  format.  Amongst other things, this opens up the use of third-party
  tools to parse and process out selftesting results.

- Ryan Roberts has added fork()-time PTE batching of THP ptes in the
  series "mm/memory: optimize fork() with PTE-mapped THP".  Mainly
  targeted at arm64, this significantly speeds up fork() when the process
  has a large number of pte-mapped folios.

- David Hildenbrand also gets in on the THP pte batching game in his
  series "mm/memory: optimize unmap/zap with PTE-mapped THP".  It
  implements batching during munmap() and other pte teardown situations.
  The microbenchmark improvements are nice.

- And in the series "Transparent Contiguous PTEs for User Mappings" Ryan
  Roberts further utilizes arm's pte's contiguous bit ("contpte
  mappings").  Kernel build times on arm64 improved nicely.  Ryan's series
  "Address some contpte nits" provides some followup work.

- In the series "mm/hugetlb: Restore the reservation" Breno Leitao has
  fixed an obscure hugetlb race which was causing unnecessary page faults.
  He has also added a reproducer under the selftest code.

- In the series "selftests/mm: Output cleanups for the compaction test",
  Mark Brown did what the title claims.

- Kinsey Ho has added the series "mm/mglru: code cleanup and refactoring".

- Even more zswap material from Nhat Pham.  The series "fix and extend
  zswap kselftests" does as claimed.

- In the series "Introduce cpu_dcache_is_aliasing() to fix DAX
  regression" Mathieu Desnoyers has cleaned up and fixed rather a mess in
  our handling of DAX on archiecctures which have virtually aliasing data
  caches.  The arm architecture is the main beneficiary.

- Lokesh Gidra's series "per-vma locks in userfaultfd" provides dramatic
  improvements in worst-case mmap_lock hold times during certain
  userfaultfd operations.

- Some page_owner enhancements and maintenance work from Oscar Salvador
  in his series

	"page_owner: print stacks and their outstanding allocations"
	"page_owner: Fixup and cleanup"

- Uladzislau Rezki has contributed some vmalloc scalability improvements
  in his series "Mitigate a vmap lock contention".  It realizes a 12x
  improvement for a certain microbenchmark.

- Some kexec/crash cleanup work from Baoquan He in the series "Split
  crash out from kexec and clean up related config items".

- Some zsmalloc maintenance work from Chengming Zhou in the series

	"mm/zsmalloc: fix and optimize objects/page migration"
	"mm/zsmalloc: some cleanup for get/set_zspage_mapping()"

- Zi Yan has taught the MM to perform compaction on folios larger than
  order=3D0.  This a step along the path to implementaton of the merging of
  large anonymous folios.  The series is named "Enable >0 order folio
  memory compaction".

- Christoph Hellwig has done quite a lot of cleanup work in the
  pagecache writeback code in his series "convert write_cache_pages() to
  an iterator".

- Some modest hugetlb cleanups and speedups in Vishal Moola's series
  "Handle hugetlb faults under the VMA lock".

- Zi Yan has changed the page splitting code so we can split huge pages
  into sizes other than order-0 to better utilize large folios.  The
  series is named "Split a folio to any lower order folios".

- David Hildenbrand has contributed the series "mm: remove
  total_mapcount()", a cleanup.

- Matthew Wilcox has sought to improve the performance of bulk memory
  freeing in his series "Rearrange batched folio freeing".

- Gang Li's series "hugetlb: parallelize hugetlb page init on boot"
  provides large improvements in bootup times on large machines which are
  configured to use large numbers of hugetlb pages.

- Matthew Wilcox's series "PageFlags cleanups" does that.

- Qi Zheng's series "minor fixes and supplement for ptdesc" does that
  also.  S390 is affected.

- Cleanups to our pagemap utility functions from Peter Xu in his series
  "mm/treewide: Replace pXd_large() with pXd_leaf()".

- Nico Pache has fixed a few things with our hugepage selftests in his
  series "selftests/mm: Improve Hugepage Test Handling in MM Selftests".

- Also, of course, many singleton patches to many things.  Please see
  the individual changelogs for details.

----------------------------------------------------------------
Alexander Potapenko (1):
      mm: kmsan: remove runtime checks from kmsan_unpoison_memory()

Andrew Morton (1):
      merge mm-hotfixes-stable into mm-nonmm-stable to pick up stackdepot c=
hanges

Anshuman Khandual (5):
      mm/cma: don't treat bad input arguments for cma_alloc() as its failure
      mm/cma: drop CONFIG_CMA_DEBUG
      mm/cma: make MAX_CMA_AREAS =3D CONFIG_CMA_AREAS
      mm/cma: add sysfs file 'release_pages_success'
      mm/hugetlb: move page order check inside hugetlb_cma_reserve()

Arnd Bergmann (1):
      kasan/test: avoid gcc warning for intentional overflow

Baolin Wang (3):
      mm: compaction: update the cc->nr_migratepages when allocating or fre=
eing the freepages
      mm: hugetlb: improve the handling of hugetlb allocation failure for f=
reed or in-use hugetlb
      mm: compaction: limit the suitable target page order to be less than =
cc->order

Baoquan He (16):
      mm/vmalloc: remove vmap_area_list
      kexec: split crashkernel reservation code out from crash_core.c
      crash: split vmcoreinfo exporting code out from crash_core.c
      crash: remove dependency of FA_DUMP on CRASH_DUMP
      crash: split crash dumping code out from kexec_core.c
      crash: clean up kdump related config items
      x86, crash: wrap crash dumping code into crash related ifdefs
      arm64, crash: wrap crash dumping code into crash related ifdefs
      ppc, crash: enforce KEXEC and KEXEC_FILE to select CRASH_DUMP
      s390, crash: wrap crash dumping code into crash related ifdefs
      sh, crash: wrap crash dumping code into crash related ifdefs
      mips, crash: wrap crash dumping code into crash related ifdefs
      riscv, crash: wrap crash dumping code into crash related ifdefs
      arm, crash: wrap crash dumping code into crash related ifdefs
      loongarch, crash: wrap crash dumping code into crash related ifdefs
      arch, crash: move arch_crash_save_vmcoreinfo() out to file vmcore_inf=
o.c

Barry Song (10):
      zram: do not allocate physically contiguous strm buffers
      mm: zswap: increase reject_compress_poor but not reject_compress_fail=
 if compression returns ENOSPC
      mm/swapfile:__swap_duplicate: drop redundant WRITE_ONCE on swap_map f=
or err cases
      madvise:madvise_cold_or_pageout_pte_range(): allow split while folio_=
estimated_sharers =3D 0
      Docs/mm/damon/design: remove the details for pageout as paddr doesn't=
 use MADV_PAGEOUT
      mm: madvise: pageout: ignore references rather than clearing young
      mm: make folio_pte_batch available outside of mm/memory.c
      mm: prohibit the last subpage from reusing the entire large folio
      crypto: introduce: acomp_is_async to expose if comp drivers might sle=
ep
      mm/zswap: remove the memcpy if acomp is not sleepable

Breno Leitao (4):
      selftests/mm: new test that steals pages
      selftests/mm: run_vmtests.sh: add hugetlb test category
      mm/hugetlb: restore the reservation if needed
      selftests/mm: run_vmtests.sh: add hugetlb_madv_vs_map

Byungchul Park (2):
      sched/numa, mm: do not try to migrate memory to memoryless nodes
      mm, vmscan: retry kswapd's priority loop with cache_trim_mode off on =
failure

Carlos Galo (1):
      mm: update mark_victim tracepoints fields

Changbin Du (1):
      modules: wait do_free_init correctly

Chengming Zhou (22):
      mm/zswap: make sure each swapfile always have zswap rb-tree
      mm/zswap: split zswap rb-tree
      mm/zswap: fix race between lru writeback and swapoff
      mm/list_lru: remove list_lru_putback()
      mm/zswap: add more comments in shrink_memcg_cb()
      mm/zswap: invalidate zswap entry when swap entry free
      mm/zswap: stop lru list shrinking when encounter warm region
      mm/zswap: remove duplicate_entry debug value
      mm/zswap: only support zswap_exclusive_loads_enabled
      mm/zswap: zswap entry doesn't need refcount anymore
      mm/zswap: optimize and cleanup the invalidation of duplicate entry
      mm/zsmalloc: fix migrate_write_lock() when !CONFIG_COMPACTION
      mm/zsmalloc: remove migrate_write_lock_nested()
      mm/zsmalloc: remove unused zspage->isolated
      mm/zsmalloc: remove set_zspage_mapping()
      mm/zsmalloc: remove_zspage() don't need fullness parameter
      mm/zsmalloc: remove get_zspage_mapping()
      MAINTAINERS: add Chengming Zhou as a zswap reviewer
      mm/zswap: global lru and shrinker shared by all zswap_pools
      mm/zswap: change zswap_pool kref to percpu_ref
      mm/zsmalloc: don't need to reserve LSB in handle
      mm/zswap: global lru and shrinker shared by all zswap_pools fix

Christoph Hellwig (6):
      writeback: don't call mapping_set_error on AOP_WRITEPAGE_ACTIVATE
      writeback: fix done_index when hitting the wbc->nr_to_write
      writeback: also update wbc->nr_to_write on writeback failure
      writeback: only update ->writeback_index for range_cyclic writeback
      writeback: rework the loop termination condition in write_cache_pages
      writeback: add a writeback iterator

Christophe JAILLET (1):
      mm: reduce dependencies on <linux/kernel.h>

Christophe Leroy (5):
      arm: ptdump: rename CONFIG_DEBUG_WX to CONFIG_ARM_DEBUG_WX
      arm64, powerpc, riscv, s390, x86: ptdump: refactor CONFIG_DEBUG_WX
      powerpc,s390: ptdump: define ptdump_check_wx() regardless of CONFIG_D=
EBUG_WX
      mm: ptdump: have ptdump_check_wx() return bool
      mm: ptdump: add check_wx_pages debugfs attribute

Dan Carpenter (1):
      lib/stackdepot: off by one in depot_fetch_stack()

Daniel Gomez (1):
      XArray: add cmpxchg order test

David Hildenbrand (26):
      arm/pgtable: define PFN_PTE_SHIFT
      nios2/pgtable: define PFN_PTE_SHIFT
      powerpc/pgtable: define PFN_PTE_SHIFT
      riscv/pgtable: define PFN_PTE_SHIFT
      s390/pgtable: define PFN_PTE_SHIFT
      sparc/pgtable: define PFN_PTE_SHIFT
      mm/pgtable: make pte_next_pfn() independent of set_ptes()
      arm/mm: use pte_next_pfn() in set_ptes()
      powerpc/mm: use pte_next_pfn() in set_ptes()
      mm/memory: factor out copying the actual PTE in copy_present_pte()
      mm/memory: pass PTE to copy_present_pte()
      mm/memory: optimize fork() with PTE-mapped THP
      mm/memory: ignore dirty/accessed/soft-dirty bits in folio_pte_batch()
      mm/memory: ignore writable bit in folio_pte_batch()
      mm/memory: factor out zapping of present pte into zap_present_pte()
      mm/memory: handle !page case in zap_present_pte() separately
      mm/memory: further separate anon and pagecache folio handling in zap_=
present_pte()
      mm/memory: factor out zapping folio pte into zap_present_folio_pte()
      mm/mmu_gather: pass "delay_rmap" instead of encoded page to __tlb_rem=
ove_page_size()
      mm/mmu_gather: define ENCODED_PAGE_FLAG_DELAY_RMAP
      mm/mmu_gather: add tlb_remove_tlb_entries()
      mm/mmu_gather: add __tlb_remove_folio_pages()
      mm/mmu_gather: improve cond_resched() handling with large folios and =
expensive page freeing
      mm/memory: optimize unmap/zap with PTE-mapped THP
      mm/memfd: refactor memfd_tag_pins() and memfd_wait_for_pins()
      mm: remove total_mapcount()

Gang Li (7):
      hugetlb: code clean for hugetlb_hstate_alloc_pages
      hugetlb: split hugetlb_hstate_alloc_pages
      hugetlb: pass *next_nid_to_alloc directly to for_each_node_mask_to_al=
loc
      padata: downgrade padata_do_multithreaded to serial execution for non=
-SMP
      hugetlb: have CONFIG_HUGETLBFS select CONFIG_PADATA
      hugetlb: parallelize 2M hugetlb allocation and initialization
      hugetlb: parallelize 1G hugetlb initialization

Gang Li Subject: padata: dispatch works on (1):
      Author: Gang Li padata: dispatch works on

Greg Thelen (1):
      selftests/memfd: delete unused declarations

Gregory Price (3):
      mm/mempolicy: refactor a read-once mechanism into a function for re-u=
se
      mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE for weighted interle=
aving
      mm/mempolicy: protect task interleave functions with tsk->mems_allowe=
d_seq

Haifeng Xu (2):
      mm: list_lru: disable memcg_aware when cgroup.memory is set to "nokme=
m"
      mm: list_lru: remove unused macro list_lru_init_key()

Hao Ge (4):
      mm/vmscan: change the type of file from int to bool
      mm/vmscan: make too_many_isolated return bool
      mm/page_alloc: make bad_range() return bool
      mm/page_alloc: make check_new_page() return bool

Hongbo Li (1):
      mm/filemap: avoid type conversion

Huang Shijie (1):
      crash_core: export vmemmap when CONFIG_SPARSEMEM_VMEMMAP is enabled

Huang Ying (1):
      mm and cache_info: remove unnecessary CPU cache info update

Hui Zhu (1):
      fs/proc/task_mmu.c: add_to_pagemap: remove useless parameter addr

JP Kobryn (1):
      selftests/mm/ksm_functional: prevent unmapping undefined address

James Houghton (1):
      mm: add an explicit smp_wmb() to UFFDIO_CONTINUE

Jan Kara (1):
      shmem: properly report quota mount options

Javier Carrasco (1):
      selftests: damon: add access_memory to .gitignore

Johannes Weiner (20):
      mm: zswap: rename zswap_free_entry to zswap_entry_free
      mm: zswap: inline and remove zswap_entry_find_get()
      mm: zswap: move zswap_invalidate_entry() to related functions
      mm: zswap: warn when referencing a dead entry
      mm: zswap: clean up zswap_entry_put()
      mm: zswap: rename __zswap_load() to zswap_decompress()
      mm: zswap: break out zwap_compress()
      mm: zswap: further cleanup zswap_store()
      mm: zswap: simplify zswap_invalidate()
      mm: zswap: function ordering: pool alloc & free
      mm: zswap: function ordering: pool refcounting
      mm: zswap: function ordering: zswap_pools
      mm: zswap: function ordering: pool params
      mm: zswap: function ordering: public lru api
      mm: zswap: function ordering: move entry sections out of LRU section
      mm: zswap: function ordering: move entry section out of tree section
      mm: zswap: function ordering: compress & decompress functions
      mm: zswap: function ordering: per-cpu compression infra
      mm: zswap: function ordering: writeback
      mm: zswap: function ordering: shrink_memcg_cb

John Groves (1):
      memremap.h: correct an error in a comment

John Hubbard (1):
      mm/memory.c: do_numa_page(): remove a redundant page table read

Juntong Deng (1):
      kasan: increase the number of bits to shift when recording extra time=
stamps

Kalesh Singh (1):
      mm/cma: fix placement of trace_cma_alloc_start/finish

Kefeng Wang (13):
      mm: memory: use nth_page() in clear/copy_subpage()
      s390: use pfn_swap_entry_folio() in ptep_zap_swap_entry()
      mm: use pfn_swap_entry_folio() in __split_huge_pmd_locked()
      mm: use pfn_swap_entry_to_folio() in zap_huge_pmd()
      mm: use pfn_swap_entry_folio() in copy_nonpresent_pte()
      mm: convert to should_zap_page() to should_zap_folio()
      mm: convert mm_counter() to take a folio
      mm: convert mm_counter_file() to take a folio
      mm: memory: move mem_cgroup_charge() into alloc_anon_folio()
      mm: compaction: refactor compact_node()
      mm: compaction: early termination in compact_nodes()
      zram: zcomp: remove zcomp_set_max_streams() declaration
      mm: memory: fix shift-out-of-bounds in fault_around_bytes_set

Kinsey Ho (5):
      mm/mglru: drop unused parameter
      mm/mglru: improve should_run_aging()
      mm/mglru: improve reset_mm_stats()
      mm/mglru: improve struct lru_gen_mm_walk
      mm/mglru: improve swappiness handling

Kuan-Ying Lee (1):
      scripts/gdb/vmalloc: fix vmallocinfo error

Lance Yang (2):
      mm/khugepaged: bypassing unnecessary scans with MMF_DISABLE_THP check
      mm/khugepaged: keep mm in mm_slot without MMF_DISABLE_THP check

Levi Yun (1):
      kswapd: replace try_to_freeze() with kthread_freezable_should_stop()

Li Zhijian (1):
      mm/demotion: print demotion targets

Lokesh Gidra (5):
      userfaultfd: fix return error if mmap_changing is non-zero in MOVE io=
ctl
      userfaultfd: move userfaultfd_ctx struct to header file
      userfaultfd: protect mmap_changing with rw_sem in userfaulfd_ctx
      mm: add vma_assert_locked() for !CONFIG_PER_VMA_LOCK
      userfaultfd: use per-vma locks in userfaultfd operations

Luis Chamberlain (1):
      test_xarray: add tests for advanced multi-index use

Lukas Bulwahn (2):
      maple_tree: avoid duplicate variable init in mast_spanning_rebalance()
      mempolicy: clean up minor dead code in queue_pages_test_walk()

Mark Brown (2):
      selftests/mm: log skipped compaction test as a skip
      selftests/mm: log a consistent test name for check_compaction

Mark-PK Tsai (1):
      zram: use copy_page for full page copy

Martin Kaiser (3):
      lib/test_vmalloc.c: fix typo in function name
      lib/test_vmalloc.c: drop empty exit function
      lib/test_vmalloc.c: use unsigned long constant

Mathieu Desnoyers (10):
      nvdimm/pmem: fix leak on dax_add_host() failure
      dax: add empty static inline for CONFIG_DAX=3Dn
      dax: alloc_dax() return ERR_PTR(-EOPNOTSUPP) for CONFIG_DAX=3Dn
      nvdimm/pmem: Treat alloc_dax() -EOPNOTSUPP failure as non-fatal
      dm: treat alloc_dax() -EOPNOTSUPP failure as non-fatal
      dcssblk: handle alloc_dax() -EOPNOTSUPP failure
      virtio: treat alloc_dax() -EOPNOTSUPP failure as non-fatal
      dax: check for data cache aliasing at runtime
      Introduce cpu_dcache_is_aliasing() across all architectures
      dax: fix incorrect list of data cache aliasing architectures

Matthew Cassell (1):
      mm/util.c: add byte count to __vm_enough_memory failure warning

Matthew Wilcox (Oracle) (48):
      memcg: convert mem_cgroup_move_charge_pte_range() to use a folio
      memcg: return the folio in union mc_target
      memcg: use a folio in get_mctgt_type
      memcg: use a folio in get_mctgt_type_thp
      mm: add pfn_swap_entry_folio()
      proc: use pfn_swap_entry_folio where obvious
      mprotect: use pfn_swap_entry_folio
      highmem: add kernel-doc for memcpy_*_folio()
      rmap: replace two calls to compound_order with folio_order
      writeback: remove a duplicate prototype for tag_pages_for_writeback
      writeback: factor folio_prepare_writeback() out of write_cache_pages()
      writeback: factor writeback_get_batch() out of write_cache_pages()
      writeback: simplify the loops in write_cache_pages()
      pagevec: add ability to iterate a queue
      writeback: use the folio_batch queue iterator
      writeback: move the folio_prepare_writeback loop out of write_cache_p=
ages()
      writeback: remove a use of write_cache_pages() from do_writepages()
      mm: support order-1 folios in the page cache
      mm: make folios_put() the basis of release_pages()
      mm: convert free_unref_page_list() to use folios
      mm: add free_unref_folios()
      mm: use folios_put() in __folio_batch_release()
      memcg: add mem_cgroup_uncharge_folios()
      mm: remove use of folio list from folios_put()
      mm: use free_unref_folios() in put_pages_list()
      mm: use __page_cache_release() in folios_put()
      mm: handle large folios in free_unref_folios()
      mm: allow non-hugetlb large folios to be batch processed
      mm: free folios in a batch in shrink_folio_list()
      mm: free folios directly in move_folios_to_lru()
      memcg: remove mem_cgroup_uncharge_list()
      mm: remove free_unref_page_list()
      mm: remove lru_to_page()
      mm: convert free_pages_and_swap_cache() to use folios_put()
      mm: use a folio in __collapse_huge_page_copy_succeeded()
      mm: convert free_swap_cache() to take a folio
      mm: use folio more widely in __split_huge_page
      mm: separate out FOLIO_FLAGS from PAGEFLAGS
      mm: remove PageWaiters, PageSetWaiters and PageClearWaiters
      mm: remove PageYoung and PageIdle definitions
      mm: add __dump_folio()
      mm: make dump_page() take a const argument
      mm: constify testing page/folio flags
      mm: constify more page/folio tests
      mm: remove cast from page_to_nid()
      mm/mempolicy: use a folio in do_mbind()
      mm: remove folio from deferred split list before uncharging it
      mm: fix list corruption in put_pages_list

Mike Rapoport (IBM) (1):
      MAINTAINERS: update mm and memcg entries

Muhammad Usama Anjum (11):
      selftests/mm: map_fixed_noreplace: conform test to TAP format output
      selftests/mm: map_hugetlb: conform test to TAP format output
      selftests/mm: map_populate: conform test to TAP format output
      selftests/mm: mlock-random-test: conform test to TAP format output
      selftests/mm: mlock2-tests: conform test to TAP format output
      selftests/mm: mrelease_test: conform test to TAP format output
      selftests/mm: mremap_dontunmap: conform test to TAP format output
      selftests/mm: split_huge_page_test: conform test to TAP format output
      selftests/mm: thuge-gen: conform to TAP format output
      selftests/mm: transhuge-stress: conform to TAP format output
      selftests/mm: virtual_address_range: conform to TAP format output

Nhat Pham (3):
      selftests: zswap: add zswap selftest file to zswap maintainer entry
      selftests: fix the zswap invasive shrink test
      selftests: add zswapin and no zswap tests

Nico Pache (4):
      selftests: mm: perform some system cleanup before using hugepages
      selftests/mm: dont fail testsuite due to a lack of hugepages
      selftests/mm: skip uffd hugetlb tests with insufficient hugepages
      selftests/mm: skip the hugetlb-madvise tests on unmet hugepage requir=
ements

Oscar Salvador (9):
      lib/stackdepot: fix first entry having a 0-handle
      lib/stackdepot: move stack_record struct definition into the header
      mm,page_owner: maintain own list of stack_records structs
      mm,page_owner: implement the tracking of the stacks count
      mm,page_owner: display all stacks and their count
      mm,page_owner: filter out stacks by a threshold
      mm,page_owner: update Documentation regarding page_owner_stacks
      mm,page_owner: check for null stack_record before bumping its refcount
      mm,page_owner: drop unnecessary check

Pankaj Raghav (1):
      readahead: use ilog2 instead of a while loop in page_cache_ra_order()

Paul Gofman (1):
      mm/migrate: preserve exact soft-dirty state

Paul Heidekr=FCger (2):
      kasan: add atomic tests
      kasan: fix a2 allocation and remove explicit cast in atomic tests

Peter Xu (11):
      mm/powerpc: define pXd_large() with pXd_leaf()
      mm/powerpc: replace pXd_is_leaf() with pXd_leaf()
      mm/x86: replace p4d_large() with p4d_leaf()
      mm/x86: replace pgd_large() with pgd_leaf()
      mm/x86: drop two unnecessary pud_leaf() definitions
      mm/kasan: use pXd_leaf() in shadow_mapped()
      mm/treewide: replace pmd_large() with pmd_leaf()
      mm/treewide: replace pud_large() with pud_leaf()
      mm/treewide: drop pXd_large()
      mm/treewide: align up pXd_leaf() retval across archs
      mm: recover pud_leaf() definitions in nopmd case

Qi Zheng (3):
      mm: pgtable: correct the wrong comment about ptdesc->__page_flags
      mm: pgtable: add missing pt_index to struct ptdesc
      s390: supplement for ptdesc conversion

Qiang Zhang (1):
      memtest: use {READ,WRITE}_ONCE in memory scanning

Rakie Kim (1):
      mm/mempolicy: implement the sysfs-based weighted_interleave interface

Ricardo B. Marliere (1):
      memory tier: make memory_tier_subsys const

Richard Chang (1):
      mm: add alloc_contig_migrate_range allocation statistics

Ronald Monthero (1):
      mm/zswap: improve with alloc_workqueue() call

Ryan Roberts (23):
      tools/mm: add thpmaps script to dump THP usage info
      arm64/mm: make set_ptes() robust when OAs cross 48-bit boundary
      mm: clarify the spec for set_ptes()
      mm: thp: batch-collapse PMD with set_ptes()
      mm: introduce pte_advance_pfn() and use for pte_next_pfn()
      arm64/mm: convert pte_next_pfn() to pte_advance_pfn()
      x86/mm: convert pte_next_pfn() to pte_advance_pfn()
      mm: tidy up pte_next_pfn() definition
      arm64/mm: convert READ_ONCE(*ptep) to ptep_get(ptep)
      arm64/mm: convert set_pte_at() to set_ptes(..., 1)
      arm64/mm: convert ptep_clear() to ptep_get_and_clear()
      arm64/mm: new ptep layer to manage contig bit
      arm64/mm: dplit __flush_tlb_range() to elide trailing DSB
      arm64/mm: wire up PTE_CONT for user mappings
      arm64/mm: implement new wrprotect_ptes() batch API
      arm64/mm: implement new [get_and_]clear_full_ptes() batch APIs
      mm: add pte_batch_hint() to reduce scanning in folio_pte_batch()
      arm64/mm: implement pte_batch_hint()
      arm64/mm: __always_inline to improve fork() perf
      arm64/mm: automatically fold contpte mappings
      arm64/mm: export contpte symbols only to GPL users
      arm64/mm: improve comment in contpte_ptep_get_lockless()
      mm: swap: fix race between free_swap_and_cache() and swapoff()

SeongJae Park (43):
      Docs/admin-guide/mm/damon/usage: use sysfs interface for tracepoints =
example
      mm/damon: rename CONFIG_DAMON_DBGFS to DAMON_DBGFS_DEPRECATED
      mm/damon/dbgfs: implement deprecation notice file
      mm/damon/dbgfs: make debugfs interface deprecation message a macro
      Docs/admin-guide/mm/damon/usage: document 'DEPRECATED' file of DAMON =
debugfs interface
      selftets/damon: prepare for monitor_on file renaming
      mm/damon/dbgfs: rename monitor_on file to monitor_on_DEPRECATED
      Docs/admin-guide/mm/damon/usage: update for monitor_on renaming
      Docs/translations/damon/usage: update for monitor_on renaming
      mm/damon/sysfs: handle 'state' file inputs for every sampling interva=
l if possible
      selftests/damon/_damon_sysfs: support DAMOS quota
      selftests/damon/_damon_sysfs: support DAMOS stats
      selftests/damon/_damon_sysfs: support DAMOS apply interval
      selftests/damon: add a test for DAMOS quota
      selftests/damon: add a test for DAMOS apply intervals
      selftests/damon: add a test for a race between target_ids_read() and =
dbgfs_before_terminate()
      selftests/damon: add a test for the pid leak of dbgfs_target_ids_writ=
e()
      selftests/damon/_chk_dependency: get debugfs mount point from /proc/m=
ounts
      Docs/mm/damon/maintainer-profile: fix reference links for mm-[un]stab=
le tree
      Docs/mm/damon: move the list of DAMOS actions to design doc
      Docs/mm/damon: move DAMON operation sets list from the usage to the d=
esign document
      Docs/mm/damon: move monitoring target regions setup detail from the u=
sage to the design document
      Docs/admin-guide/mm/damon/usage: fix wrong quotas diabling condition
      mm/damon/core: set damos_quota->esz as public field and document
      mm/damon/sysfs-schemes: implement quota effective_bytes file
      mm/damon/sysfs: implement a kdamond command for updating schemes' eff=
ective quotas
      Docs/ABI/damon: document effective_bytes sysfs file
      Docs/admin-guide/mm/damon/usage: document effective_bytes file
      mm/damon: move comments and fields for damos-quota-prioritization to =
the end
      mm/damon/core: split out quota goal related fields to a struct
      mm/damon/core: add multiple goals per damos_quota and helpers for tho=
se
      mm/damon/sysfs: use only quota->goals
      mm/damon/core: remove ->goal field of damos_quota
      mm/damon/core: let goal specified with only target and current values
      mm/damon/core: support multiple metrics for quota goal
      mm/damon/core: implement PSI metric DAMOS quota goal
      mm/damon/sysfs-schemes: support PSI-based quota auto-tune
      Docs/mm/damon/design: document quota goal self-tuning
      Docs/ABI/damon: document quota goal metric file
      Docs/admin-guide/mm/damon/usage: document quota goal metric file
      mm/damon/reclaim: implement user-feedback driven quota auto-tuning
      mm/damon/reclaim: implement memory PSI-driven quota self-tuning
      Docs/admin-guide/mm/damon/reclaim: document auto-tuning parameters

Shakeel Butt (1):
      mm: writeback: ratelimit stat flush from mem_cgroup_wb_stats

Sidhartha Kumar (1):
      maple_tree: fix comment describing mas_node_count_gfp()

Sumanth Korikkar (5):
      mm/memory_hotplug: introduce MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE no=
tifiers
      s390/mm: allocate vmemmap pages from self-contained memory range
      s390/sclp: remove unhandled memory notifier type
      s390/mm: implement MEM_PREPARE_ONLINE/MEM_FINISH_OFFLINE notifiers
      s390: enable MHP_MEMMAP_ON_MEMORY

Suren Baghdasaryan (2):
      userfaultfd: handle zeropage moves by UFFDIO_MOVE
      mm: enumerate all gfp flags

T.J. Mercier (2):
      mm: memcg: don't periodically flush stats when memcg is disabled
      mm: memcg: use larger batches for proactive reclaim

Thorsten Blum (1):
      mm: page_alloc: use div64_ul() instead of do_div()

Tiezhu Yang (2):
      kasan: docs: update descriptions about test file and module
      kasan: rename test_kasan_module_init to kasan_test_module_init

Uladzislau Rezki (Sony) (13):
      mm: vmalloc: add va_alloc() helper
      mm: vmalloc: rename adjust_va_to_fit_type() function
      mm: vmalloc: move vmap_init_free_space() down in vmalloc.c
      mm: vmalloc: remove global vmap_area_root rb-tree
      mm: vmalloc: remove global purge_vmap_area_root rb-tree
      mm: vmalloc: offload free_vmap_area_lock lock
      mm: vmalloc: add a scan area of VA only once
      mm: vmalloc: support multiple nodes in vread_iter
      mm: vmalloc: support multiple nodes in vmallocinfo
      mm: vmalloc: set nr_nodes based on CPUs in a system
      mm: vmalloc: add a shrinker to drain vmap pools
      mm: vmalloc: improve description of vmap node layer
      mm: vmalloc: refactor vmalloc_dump_obj() function

Vincenzo Mezzela (1):
      selftest: damon: fix minor typos in test logs

Vishal Moola (Oracle) (5):
      mm/memory: change vmf_anon_prepare() to be non-static
      hugetlb: move vm_fault declaration to the top of hugetlb_fault()
      hugetlb: pass struct vm_fault through to hugetlb_handle_userfault()
      hugetlb: use vmf_anon_prepare() instead of anon_vma_prepare()
      hugetlb: allow faults to be handled under the VMA lock

Vishal Verma (5):
      dax/bus.c: replace driver-core lock usage by a local rwsem
      dax/bus.c: replace several sprintf() with sysfs_emit()
      Documentatiion/ABI: add ABI documentation for sys-bus-dax
      mm/memory_hotplug: export mhp_supports_memmap_on_memory()
      dax: add a sysfs knob to control memmap_on_memory behavior

Vlastimil Babka (1):
      mm: document memalloc_noreclaim_save() and memalloc_pin_save()

Yajun Deng (4):
      mm/mmap: simplify vma link and unlink
      mm/mmap: introduce vma_set_range()
      mm/mmap: use SZ_{8K, 128K} helper macro
      mm/mmap: pass vma to vma_merge()

Yang Shi (1):
      mm: mmap: no need to call khugepaged_enter_vma() for stack

Yosry Ahmed (7):
      mm: swap: enforce updating inuse_pages at the end of swap_range_free()
      mm: zswap: remove unnecessary trees cleanups in zswap_swapoff()
      mm: zswap: remove unused tree argument in zswap_entry_put()
      x86/mm: delete unused cpu argument to leave_mm()
      x86/mm: clarify "prev" usage in switch_mm_irqs_off()
      x86/mm: further clarify switch_mm_irqs_off() documentation
      x86/mm: always pass NULL as the first argument of switch_mm_irqs_off()

ZhangPeng (1):
      filemap: avoid unnecessary major faults in filemap_fault()

Zhongkun He (1):
      mm/z3fold: fix the comment for __encode_handle()

Zi Yan (13):
      mm/page_alloc: remove unused fpi_flags in free_pages_prepare()
      mm/compaction: enable compacting >0 order folios.
      mm/compaction: add support for >0 order folio memory compaction.
      mm/compaction: optimize >0 order folio compaction with free page spli=
t.
      mm/huge_memory: only split PMD mapping when necessary in unmap_folio()
      mm/memcg: use order instead of nr in split_page_memcg()
      mm/page_owner: use order instead of nr in split_page_owner()
      mm: memcg: make memcg huge page split support any order split
      mm: page_owner: add support for splitting to any order in split page_=
owner
      mm: thp: split huge page to any lower order pages
      mm: huge_memory: enable debugfs to split huge pages to any order
      mm/huge_memory: check new folio order when split a folio
      mm/huge_memory: skip invalid debugfs new_order input for folio split

 Documentation/ABI/testing/sysfs-bus-dax            |  153 ++
 Documentation/ABI/testing/sysfs-kernel-mm-cma      |    6 +
 Documentation/ABI/testing/sysfs-kernel-mm-damon    |   16 +-
 .../ABI/testing/sysfs-kernel-mm-mempolicy          |    4 +
 .../sysfs-kernel-mm-mempolicy-weighted-interleave  |   25 +
 Documentation/admin-guide/kdump/vmcoreinfo.rst     |    8 +-
 Documentation/admin-guide/mm/damon/reclaim.rst     |   27 +
 Documentation/admin-guide/mm/damon/usage.rst       |  158 +-
 .../admin-guide/mm/numa_memory_policy.rst          |    9 +
 Documentation/dev-tools/kasan.rst                  |   20 +-
 Documentation/mm/damon/design.rst                  |   70 +-
 Documentation/mm/damon/maintainer-profile.rst      |    8 +-
 Documentation/mm/page_owner.rst                    |   45 +
 .../zh_CN/admin-guide/mm/damon/usage.rst           |   20 +-
 .../translations/zh_CN/dev-tools/kasan.rst         |   20 +-
 .../zh_TW/admin-guide/mm/damon/usage.rst           |   20 +-
 .../translations/zh_TW/dev-tools/kasan.rst         |   20 +-
 MAINTAINERS                                        |   12 +
 arch/arc/Kconfig                                   |    1 +
 arch/arc/include/asm/cachetype.h                   |    9 +
 arch/arm/Kconfig                                   |    1 +
 arch/arm/Kconfig.debug                             |    2 +-
 arch/arm/configs/aspeed_g4_defconfig               |    2 +-
 arch/arm/configs/aspeed_g5_defconfig               |    2 +-
 arch/arm/include/asm/cachetype.h                   |    2 +
 arch/arm/include/asm/pgtable-2level.h              |    1 -
 arch/arm/include/asm/pgtable-3level.h              |    1 -
 arch/arm/include/asm/pgtable.h                     |    2 +
 arch/arm/include/asm/ptdump.h                      |    6 +-
 arch/arm/kernel/Makefile                           |    1 +
 arch/arm/kernel/machine_kexec.c                    |    7 -
 arch/arm/kernel/setup.c                            |    4 +-
 arch/arm/kernel/vmcore_info.c                      |   10 +
 arch/arm/mm/dump.c                                 |    4 +-
 arch/arm/mm/init.c                                 |    2 +-
 arch/arm/mm/mmu.c                                  |    2 +-
 arch/arm64/Kconfig                                 |   11 +-
 .../include/asm/{crash_core.h =3D> crash_reserve.h}  |    4 +-
 arch/arm64/include/asm/kexec.h                     |    2 +-
 arch/arm64/include/asm/pgtable.h                   |  431 +++-
 arch/arm64/include/asm/ptdump.h                    |    7 -
 arch/arm64/include/asm/tlbflush.h                  |   13 +-
 arch/arm64/kernel/Makefile                         |    2 +-
 arch/arm64/kernel/efi.c                            |    4 +-
 arch/arm64/kernel/machine_kexec.c                  |    2 +-
 arch/arm64/kernel/machine_kexec_file.c             |   10 +-
 arch/arm64/kernel/mte.c                            |    2 +-
 arch/arm64/kernel/{crash_core.c =3D> vmcore_info.c}  |    3 +-
 arch/arm64/kvm/guest.c                             |    2 +-
 arch/arm64/mm/Makefile                             |    1 +
 arch/arm64/mm/contpte.c                            |  408 ++++
 arch/arm64/mm/fault.c                              |   12 +-
 arch/arm64/mm/fixmap.c                             |    4 +-
 arch/arm64/mm/hugetlbpage.c                        |   47 +-
 arch/arm64/mm/init.c                               |    2 +-
 arch/arm64/mm/kasan_init.c                         |    6 +-
 arch/arm64/mm/mmu.c                                |   18 +-
 arch/arm64/mm/pageattr.c                           |    6 +-
 arch/arm64/mm/ptdump.c                             |   11 +-
 arch/arm64/mm/trans_pgd.c                          |    6 +-
 arch/csky/Kconfig                                  |    1 +
 arch/csky/include/asm/cachetype.h                  |    9 +
 arch/loongarch/kernel/setup.c                      |    2 +-
 arch/loongarch/kvm/mmu.c                           |    2 +-
 arch/m68k/Kconfig                                  |    1 +
 arch/m68k/include/asm/cachetype.h                  |    9 +
 arch/mips/Kconfig                                  |    1 +
 arch/mips/include/asm/cachetype.h                  |    9 +
 arch/mips/kernel/setup.c                           |   17 +-
 arch/nios2/Kconfig                                 |    1 +
 arch/nios2/include/asm/cachetype.h                 |   10 +
 arch/nios2/include/asm/pgtable.h                   |    2 +
 arch/parisc/Kconfig                                |    1 +
 arch/parisc/include/asm/cachetype.h                |    9 +
 arch/powerpc/Kconfig                               |    7 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h       |   26 +-
 arch/powerpc/include/asm/pgtable.h                 |   30 +-
 arch/powerpc/include/asm/tlb.h                     |    2 +
 arch/powerpc/kernel/setup-common.c                 |    2 +-
 arch/powerpc/kexec/Makefile                        |    1 +
 arch/powerpc/kexec/core.c                          |   28 -
 arch/powerpc/kexec/vmcore_info.c                   |   32 +
 arch/powerpc/kvm/book3s_64_mmu_radix.c             |   12 +-
 arch/powerpc/mm/book3s64/pgtable.c                 |    4 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c           |   16 +-
 arch/powerpc/mm/hugetlbpage.c                      |    6 +-
 arch/powerpc/mm/mmu_decl.h                         |    6 -
 arch/powerpc/mm/nohash/kaslr_booke.c               |    4 +-
 arch/powerpc/mm/pgtable.c                          |   11 +-
 arch/powerpc/mm/pgtable_32.c                       |    4 -
 arch/powerpc/mm/pgtable_64.c                       |   11 +-
 arch/powerpc/mm/ptdump/ptdump.c                    |   21 +-
 arch/powerpc/platforms/powernv/opal-core.c         |    2 +-
 arch/powerpc/xmon/xmon.c                           |    6 +-
 arch/riscv/Kconfig                                 |    2 +-
 .../include/asm/{crash_core.h =3D> crash_reserve.h}  |    4 +-
 arch/riscv/include/asm/pgtable-64.h                |    2 +-
 arch/riscv/include/asm/pgtable.h                   |    4 +-
 arch/riscv/include/asm/ptdump.h                    |   22 -
 arch/riscv/kernel/Makefile                         |    2 +-
 arch/riscv/kernel/elf_kexec.c                      |    9 +-
 arch/riscv/kernel/{crash_core.c =3D> vmcore_info.c}  |    3 +-
 arch/riscv/mm/init.c                               |    5 +-
 arch/riscv/mm/ptdump.c                             |   12 +-
 arch/s390/Kconfig                                  |    1 +
 arch/s390/boot/vmem.c                              |    4 +-
 arch/s390/include/asm/pgalloc.h                    |    4 +-
 arch/s390/include/asm/pgtable.h                    |   22 +-
 arch/s390/include/asm/ptdump.h                     |   14 -
 arch/s390/include/asm/tlb.h                        |   30 +-
 arch/s390/kernel/Makefile                          |    1 +
 arch/s390/kernel/kexec_elf.c                       |    2 +
 arch/s390/kernel/kexec_image.c                     |    2 +
 arch/s390/kernel/machine_kexec.c                   |   15 -
 arch/s390/kernel/machine_kexec_file.c              |   10 +
 arch/s390/kernel/vmcore_info.c                     |   21 +
 arch/s390/mm/dump_pagetables.c                     |   21 +-
 arch/s390/mm/gmap.c                                |   52 +-
 arch/s390/mm/hugetlbpage.c                         |    6 +-
 arch/s390/mm/init.c                                |    5 -
 arch/s390/mm/pageattr.c                            |    4 +-
 arch/s390/mm/pgalloc.c                             |    8 +-
 arch/s390/mm/pgtable.c                             |   12 +-
 arch/s390/mm/vmem.c                                |   74 +-
 arch/sh/Kconfig                                    |    1 +
 arch/sh/include/asm/cachetype.h                    |    9 +
 arch/sh/kernel/Makefile                            |    1 +
 arch/sh/kernel/machine_kexec.c                     |   14 +-
 arch/sh/kernel/setup.c                             |    2 +-
 arch/sh/kernel/vmcore_info.c                       |   15 +
 arch/sparc/Kconfig                                 |    1 +
 arch/sparc/include/asm/cachetype.h                 |   14 +
 arch/sparc/include/asm/pgtable_64.h                |   10 +-
 arch/sparc/mm/init_64.c                            |    6 +-
 arch/x86/Kconfig                                   |    2 +-
 arch/x86/boot/compressed/ident_map_64.c            |    2 +-
 .../include/asm/{crash_core.h =3D> crash_reserve.h}  |    6 +-
 arch/x86/include/asm/mmu.h                         |    2 +-
 arch/x86/include/asm/pgtable.h                     |   37 +-
 arch/x86/kernel/Makefile                           |    6 +-
 arch/x86/kernel/alternative.c                      |    2 +-
 arch/x86/kernel/cpu/mshyperv.c                     |   10 +-
 arch/x86/kernel/kexec-bzimage64.c                  |    4 +
 arch/x86/kernel/kvm.c                              |    4 +-
 arch/x86/kernel/machine_kexec_64.c                 |    3 +
 arch/x86/kernel/reboot.c                           |    4 +-
 arch/x86/kernel/setup.c                            |    2 +-
 arch/x86/kernel/smp.c                              |    2 +-
 .../kernel/{crash_core_32.c =3D> vmcore_info_32.c}   |    2 +-
 .../kernel/{crash_core_64.c =3D> vmcore_info_64.c}   |    2 +-
 arch/x86/kvm/mmu/mmu.c                             |    6 +-
 arch/x86/mm/dump_pagetables.c                      |   24 +-
 arch/x86/mm/fault.c                                |   16 +-
 arch/x86/mm/ident_map.c                            |    2 +-
 arch/x86/mm/init_32.c                              |    4 +-
 arch/x86/mm/init_64.c                              |   16 +-
 arch/x86/mm/kasan_init_64.c                        |    4 +-
 arch/x86/mm/mem_encrypt_identity.c                 |    6 +-
 arch/x86/mm/pat/set_memory.c                       |   14 +-
 arch/x86/mm/pgtable.c                              |    4 +-
 arch/x86/mm/pti.c                                  |   10 +-
 arch/x86/mm/tlb.c                                  |   39 +-
 arch/x86/power/hibernate.c                         |    6 +-
 arch/x86/xen/enlighten_hvm.c                       |    4 +
 arch/x86/xen/mmu_pv.c                              |   14 +-
 arch/xtensa/Kconfig                                |    1 +
 arch/xtensa/include/asm/cachetype.h                |   10 +
 drivers/base/cacheinfo.c                           |   50 +-
 drivers/base/cpu.c                                 |    6 +-
 drivers/base/memory.c                              |   23 +-
 drivers/block/zram/zcomp.c                         |    5 +-
 drivers/block/zram/zcomp.h                         |    1 -
 drivers/block/zram/zram_drv.c                      |    2 +-
 drivers/cpuidle/cpuidle.c                          |    2 +-
 drivers/dax/bus.c                                  |  293 ++-
 drivers/dax/super.c                                |   14 +
 drivers/firmware/qemu_fw_cfg.c                     |   14 +-
 drivers/md/dm.c                                    |   17 +-
 drivers/misc/sgi-gru/grufault.c                    |    2 +-
 drivers/nvdimm/pmem.c                              |   23 +-
 drivers/of/kexec.c                                 |    2 +
 drivers/s390/block/dcssblk.c                       |   11 +-
 drivers/s390/char/sclp_cmd.c                       |   44 +-
 fs/Kconfig                                         |    2 +-
 fs/fuse/virtio_fs.c                                |   15 +-
 fs/proc/Kconfig                                    |    2 +-
 fs/proc/kcore.c                                    |    2 +-
 fs/proc/task_mmu.c                                 |   17 +-
 fs/userfaultfd.c                                   |   86 +-
 include/asm-generic/tlb.h                          |   44 +-
 include/crypto/acompress.h                         |    6 +
 include/linux/buildid.h                            |    2 +-
 include/linux/cacheinfo.h                          |    6 +
 include/linux/cma.h                                |    6 +-
 include/linux/crash_core.h                         |  152 +-
 include/linux/crash_reserve.h                      |   48 +
 include/linux/damon.h                              |   89 +-
 include/linux/dax.h                                |   17 +-
 include/linux/efi.h                                |    5 +
 include/linux/gfp.h                                |    2 +-
 include/linux/gfp_types.h                          |   90 +-
 include/linux/highmem.h                            |   14 +
 include/linux/huge_mm.h                            |   21 +-
 include/linux/hugetlb.h                            |    2 +-
 include/linux/kexec.h                              |   47 +-
 include/linux/list_lru.h                           |   20 +-
 include/linux/memcontrol.h                         |   31 +-
 include/linux/memory.h                             |    9 +
 include/linux/memory_hotplug.h                     |   24 +-
 include/linux/memremap.h                           |    3 +-
 include/linux/mm.h                                 |   56 +-
 include/linux/mm_types.h                           |   42 +-
 include/linux/mmdebug.h                            |    2 +-
 include/linux/mmu_context.h                        |    2 +-
 include/linux/mmzone.h                             |    9 +-
 include/linux/moduleloader.h                       |    8 +
 include/linux/padata.h                             |   14 +-
 include/linux/page-flags.h                         |  153 +-
 include/linux/page_counter.h                       |    2 +-
 include/linux/page_owner.h                         |   14 +-
 include/linux/pagevec.h                            |   18 +
 include/linux/pgtable.h                            |  143 +-
 include/linux/ptdump.h                             |   10 +
 include/linux/sched.h                              |   10 +-
 include/linux/sched/mm.h                           |   55 +-
 include/linux/stackdepot.h                         |   58 +
 include/linux/swap.h                               |    8 +-
 include/linux/swapops.h                            |   13 +
 include/linux/userfaultfd_k.h                      |   75 +-
 include/linux/vmalloc.h                            |    1 -
 include/linux/vmcore_info.h                        |   81 +
 include/linux/writeback.h                          |   12 +-
 include/linux/zswap.h                              |   11 +-
 include/trace/events/compaction.h                  |    6 +-
 include/trace/events/kmem.h                        |   38 +
 include/trace/events/oom.h                         |   36 +-
 include/uapi/linux/mempolicy.h                     |    1 +
 init/initramfs.c                                   |    2 +-
 init/main.c                                        |    7 +-
 kernel/Kconfig.kexec                               |   12 +-
 kernel/Makefile                                    |    5 +-
 kernel/crash_core.c                                |  764 ++------
 kernel/crash_reserve.c                             |  464 +++++
 kernel/dma/contiguous.c                            |    6 -
 kernel/{crash_dump.c =3D> elfcorehdr.c}              |    0
 kernel/events/uprobes.c                            |    2 +-
 kernel/kallsyms_selftest.c                         |    1 -
 kernel/kexec.c                                     |   11 +-
 kernel/kexec_core.c                                |  250 +--
 kernel/kexec_file.c                                |   15 +-
 kernel/kexec_internal.h                            |    2 +
 kernel/ksysfs.c                                    |   10 +-
 kernel/module/main.c                               |    9 +-
 kernel/padata.c                                    |   14 +-
 kernel/printk/printk.c                             |    4 +-
 kernel/sched/fair.c                                |    6 +
 kernel/vmcore_info.c                               |  233 +++
 lib/buildid.c                                      |    2 +-
 lib/maple_tree.c                                   |    6 +-
 lib/stackdepot.c                                   |   65 +-
 lib/test_vmalloc.c                                 |   11 +-
 lib/test_xarray.c                                  |  230 +++
 mm/Kconfig                                         |   37 +-
 mm/cma.c                                           |   28 +-
 mm/cma.h                                           |    5 +
 mm/cma_sysfs.c                                     |   15 +
 mm/compaction.c                                    |  355 ++--
 mm/damon/Kconfig                                   |    7 +-
 mm/damon/core.c                                    |  120 +-
 mm/damon/dbgfs.c                                   |   26 +-
 mm/damon/paddr.c                                   |    2 +-
 mm/damon/reclaim.c                                 |   53 +
 mm/damon/sysfs-common.h                            |    8 +-
 mm/damon/sysfs-schemes.c                           |  146 +-
 mm/damon/sysfs.c                                   |   54 +-
 mm/debug.c                                         |  130 +-
 mm/filemap.c                                       |   52 +-
 mm/huge_memory.c                                   |  387 ++--
 mm/hugetlb.c                                       |  414 ++--
 mm/internal.h                                      |  119 +-
 mm/kasan/common.c                                  |    2 +-
 mm/kasan/kasan_test.c                              |   82 +-
 mm/kasan/kasan_test_module.c                       |    4 +-
 mm/kasan/report.c                                  |    2 +-
 mm/kasan/shadow.c                                  |   11 +-
 mm/khugepaged.c                                    |   50 +-
 mm/kmsan/hooks.c                                   |   36 +-
 mm/list_lru.c                                      |   20 +-
 mm/madvise.c                                       |   10 +-
 mm/memcontrol.c                                    |  123 +-
 mm/memfd.c                                         |   47 +-
 mm/memory-tiers.c                                  |   26 +-
 mm/memory.c                                        |  399 ++--
 mm/memory_hotplug.c                                |   34 +-
 mm/mempolicy.c                                     |  507 ++++-
 mm/memtest.c                                       |    4 +-
 mm/migrate.c                                       |    7 +-
 mm/mlock.c                                         |    3 +-
 mm/mm_init.c                                       |    1 +
 mm/mmap.c                                          |  110 +-
 mm/mmu_gather.c                                    |  111 +-
 mm/mprotect.c                                      |    4 +-
 mm/nommu.c                                         |    2 -
 mm/oom_kill.c                                      |    6 +-
 mm/page-writeback.c                                |  390 ++--
 mm/page_alloc.c                                    |  187 +-
 mm/page_isolation.c                                |    2 +-
 mm/page_owner.c                                    |  210 +-
 mm/ptdump.c                                        |   22 +
 mm/readahead.c                                     |    9 +-
 mm/rmap.c                                          |   14 +-
 mm/shmem.c                                         |   18 +
 mm/sparse.c                                        |    3 +-
 mm/swap.c                                          |  197 +-
 mm/swap_slots.c                                    |    3 +
 mm/swap_state.c                                    |   32 +-
 mm/swapfile.c                                      |   45 +-
 mm/userfaultfd.c                                   |  493 +++--
 mm/util.c                                          |    6 +-
 mm/vmalloc.c                                       | 1076 +++++++---
 mm/vmscan.c                                        |  256 +--
 mm/z3fold.c                                        |    5 +-
 mm/zsmalloc.c                                      |  123 +-
 mm/zswap.c                                         | 2050 ++++++++++------=
----
 scripts/gdb/linux/vmalloc.py                       |   56 +-
 tools/mm/Makefile                                  |    9 +-
 tools/mm/thpmaps                                   |  675 +++++++
 tools/testing/selftests/cgroup/test_zswap.c        |  122 +-
 tools/testing/selftests/damon/.gitignore           |    3 +
 tools/testing/selftests/damon/Makefile             |    5 +
 tools/testing/selftests/damon/_chk_dependency.sh   |   20 +-
 tools/testing/selftests/damon/_damon_sysfs.py      |   77 +-
 tools/testing/selftests/damon/_debugfs_common.sh   |    7 +
 .../selftests/damon/damos_apply_interval.py        |   67 +
 tools/testing/selftests/damon/damos_quota.py       |   67 +
 .../selftests/damon/debugfs_empty_targets.sh       |   12 +-
 .../selftests/damon/debugfs_target_ids_pid_leak.c  |   68 +
 .../selftests/damon/debugfs_target_ids_pid_leak.sh |   22 +
 ...debugfs_target_ids_read_before_terminate_race.c |   80 +
 ...ebugfs_target_ids_read_before_terminate_race.sh |   14 +
 .../sysfs_update_schemes_tried_regions_hang.py     |    2 +-
 ..._update_schemes_tried_regions_wss_estimation.py |    2 +-
 tools/testing/selftests/memfd/memfd_test.c         |   10 -
 tools/testing/selftests/mm/.gitignore              |    1 +
 tools/testing/selftests/mm/Makefile                |    1 +
 tools/testing/selftests/mm/compaction_test.c       |   37 +-
 tools/testing/selftests/mm/hugetlb-madvise.c       |    3 +-
 tools/testing/selftests/mm/hugetlb_madv_vs_map.c   |  124 ++
 tools/testing/selftests/mm/ksm_functional_tests.c  |    4 +-
 tools/testing/selftests/mm/map_fixed_noreplace.c   |   96 +-
 tools/testing/selftests/mm/map_hugetlb.c           |   42 +-
 tools/testing/selftests/mm/map_populate.c          |   37 +-
 tools/testing/selftests/mm/mlock-random-test.c     |  136 +-
 tools/testing/selftests/mm/mlock2-tests.c          |  282 ++-
 tools/testing/selftests/mm/mlock2.h                |   11 +-
 tools/testing/selftests/mm/mrelease_test.c         |   80 +-
 tools/testing/selftests/mm/mremap_dontunmap.c      |   32 +-
 tools/testing/selftests/mm/run_vmtests.sh          |   35 +-
 tools/testing/selftests/mm/split_huge_page_test.c  |  323 ++-
 tools/testing/selftests/mm/thuge-gen.c             |  147 +-
 tools/testing/selftests/mm/transhuge-stress.c      |   36 +-
 tools/testing/selftests/mm/uffd-stress.c           |    6 +
 tools/testing/selftests/mm/virtual_address_range.c |   44 +-
 tools/testing/selftests/mm/vm_util.c               |    6 +-
 364 files changed, 12415 insertions(+), 6101 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dax
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mempolicy
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-wei=
ghted-interleave
 create mode 100644 arch/arc/include/asm/cachetype.h
 create mode 100644 arch/arm/kernel/vmcore_info.c
 rename arch/arm64/include/asm/{crash_core.h =3D> crash_reserve.h} (81%)
 rename arch/arm64/kernel/{crash_core.c =3D> vmcore_info.c} (92%)
 create mode 100644 arch/arm64/mm/contpte.c
 create mode 100644 arch/csky/include/asm/cachetype.h
 create mode 100644 arch/m68k/include/asm/cachetype.h
 create mode 100644 arch/mips/include/asm/cachetype.h
 create mode 100644 arch/nios2/include/asm/cachetype.h
 create mode 100644 arch/parisc/include/asm/cachetype.h
 create mode 100644 arch/powerpc/kexec/vmcore_info.c
 rename arch/riscv/include/asm/{crash_core.h =3D> crash_reserve.h} (78%)
 delete mode 100644 arch/riscv/include/asm/ptdump.h
 rename arch/riscv/kernel/{crash_core.c =3D> vmcore_info.c} (88%)
 delete mode 100644 arch/s390/include/asm/ptdump.h
 create mode 100644 arch/s390/kernel/vmcore_info.c
 create mode 100644 arch/sh/include/asm/cachetype.h
 create mode 100644 arch/sh/kernel/vmcore_info.c
 create mode 100644 arch/sparc/include/asm/cachetype.h
 rename arch/x86/include/asm/{crash_core.h =3D> crash_reserve.h} (92%)
 rename arch/x86/kernel/{crash_core_32.c =3D> vmcore_info_32.c} (90%)
 rename arch/x86/kernel/{crash_core_64.c =3D> vmcore_info_64.c} (94%)
 create mode 100644 arch/xtensa/include/asm/cachetype.h
 create mode 100644 include/linux/crash_reserve.h
 create mode 100644 include/linux/vmcore_info.h
 create mode 100644 kernel/crash_reserve.c
 rename kernel/{crash_dump.c =3D> elfcorehdr.c} (100%)
 create mode 100644 kernel/vmcore_info.c
 create mode 100644 tools/mm/thpmaps
 create mode 100644 tools/testing/selftests/damon/damos_apply_interval.py
 create mode 100644 tools/testing/selftests/damon/damos_quota.py
 create mode 100644 tools/testing/selftests/damon/debugfs_target_ids_pid_le=
ak.c
 create mode 100644 tools/testing/selftests/damon/debugfs_target_ids_pid_le=
ak.sh
 create mode 100644 tools/testing/selftests/damon/debugfs_target_ids_read_b=
efore_terminate_race.c
 create mode 100644 tools/testing/selftests/damon/debugfs_target_ids_read_b=
efore_terminate_race.sh
 create mode 100644 tools/testing/selftests/mm/hugetlb_madv_vs_map.c


