Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1743788E48
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjHYSL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjHYSLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:11:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2365A1BF1;
        Fri, 25 Aug 2023 11:11:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE21661353;
        Fri, 25 Aug 2023 18:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA76EC433C8;
        Fri, 25 Aug 2023 18:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1692987069;
        bh=CqRDmZ8FlXZOuBuhi4oqiIATxpNhdyBrCLj19NbET88=;
        h=Date:From:To:Cc:Subject:From;
        b=IkM01cKVxfP75Na8tXz1BAs/FMSDqyDWtXf2qrqa91rmvUuEevLumcPPL8ut0rOJ6
         wjcfLgVDq1U0gOtlGxjFfZjv9/1SWCkt+/+eDqSCEr+LOvgKAswG/OXDAksc0nrSJ+
         AA2puOQdZkxbsklCCRPQGyJIIByS77lTlAhUEoKE=
Date:   Fri, 25 Aug 2023 11:11:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.5
Message-Id: <20230825111108.898f1600c365d22f74e52c70@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge this batch of hotfixes, thanks.


The following changes since commit 5f1fc67f2cb8d3035d3acd273b48b97835af8afd:

  mm/damon/core: initialize damo_filter->list from damos_new_filter() (2023-08-04 13:03:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-08-25-11-07

for you to fetch changes up to e5548f85b4527c4c803b7eae7887c10bf8f90c97:

  shmem: fix smaps BUG sleeping while atomic (2023-08-24 14:59:47 -0700)

----------------------------------------------------------------
18 hotfixes.  13 are cc:stable and the remainder pertain to post-6.4 issues
or aren't considered suitable for a -stable backport.

----------------------------------------------------------------
Alexandre Ghiti (1):
      mm: add a call to flush_cache_vmap() in vmap_pfn()

Andre Przywara (2):
      selftests: cachestat: test for cachestat availability
      selftests: cachestat: catch failing fsync test on tmpfs

Arnd Bergmann (1):
      radix tree: remove unused variable

Ayush Jain (1):
      selftests/mm: FOLL_LONGTERM need to be updated to 0x100

David Hildenbrand (3):
      mm/gup: reintroduce FOLL_NUMA as FOLL_HONOR_NUMA_FAULT
      smaps: use vm_normal_page_pmd() instead of follow_trans_huge_pmd()
      mm/gup: handle cont-PTE hugetlb pages correctly in gup_must_unshare() via GUP-fast

Hugh Dickins (1):
      shmem: fix smaps BUG sleeping while atomic

Liam R. Howlett (1):
      maple_tree: disable mas_wr_append() when other readers are possible

Lucas Karpinski (1):
      selftests: cgroup: fix test_kmem_basic less than error

Miaohe Lin (1):
      mm: memory-failure: fix unexpected return value in soft_offline_page()

Ryusuke Konishi (1):
      nilfs2: fix general protection fault in nilfs_lookup_dirty_data_buffers()

Suren Baghdasaryan (1):
      mm: enable page walking API to lock vmas during the walk

T.J. Mercier (1):
      mm: multi-gen LRU: don't spin during memcg release

Yin Fengwei (3):
      madvise:madvise_cold_or_pageout_pte_range(): don't use mapcount() against large folio for sharing check
      madvise:madvise_free_huge_pmd(): don't use mapcount() against large folio for sharing check
      madvise:madvise_free_pte_range(): don't use mapcount() against large folio for sharing check

 arch/powerpc/mm/book3s64/subpage_prot.c            |  1 +
 arch/riscv/mm/pageattr.c                           |  1 +
 arch/s390/mm/gmap.c                                |  5 ++
 fs/nilfs2/segment.c                                |  5 ++
 fs/proc/task_mmu.c                                 |  8 ++-
 include/linux/huge_mm.h                            |  3 -
 include/linux/mm.h                                 | 21 ++++--
 include/linux/mm_types.h                           |  9 +++
 include/linux/pagewalk.h                           | 11 +++
 lib/maple_tree.c                                   |  7 ++
 lib/radix-tree.c                                   |  1 -
 mm/damon/vaddr.c                                   |  2 +
 mm/gup.c                                           | 30 ++++++--
 mm/hmm.c                                           |  1 +
 mm/huge_memory.c                                   |  5 +-
 mm/internal.h                                      | 17 +++++
 mm/ksm.c                                           | 25 ++++---
 mm/madvise.c                                       |  9 ++-
 mm/memcontrol.c                                    |  2 +
 mm/memory-failure.c                                | 12 ++--
 mm/mempolicy.c                                     | 22 +++---
 mm/migrate_device.c                                |  1 +
 mm/mincore.c                                       |  1 +
 mm/mlock.c                                         |  1 +
 mm/mprotect.c                                      |  1 +
 mm/pagewalk.c                                      | 36 +++++++++-
 mm/shmem.c                                         |  6 +-
 mm/vmalloc.c                                       |  4 ++
 mm/vmscan.c                                        | 14 ++--
 tools/testing/selftests/cachestat/test_cachestat.c | 80 ++++++++++++++++++----
 tools/testing/selftests/cgroup/test_kmem.c         |  4 +-
 tools/testing/selftests/mm/hmm-tests.c             |  7 +-
 32 files changed, 279 insertions(+), 73 deletions(-)

