Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233047D5911
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344011AbjJXQqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344008AbjJXQqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:46:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2407010C6;
        Tue, 24 Oct 2023 09:46:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559DBC433C7;
        Tue, 24 Oct 2023 16:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1698165969;
        bh=UObGybaBZBWnIDCC2DGtll8X02tSiqsFuoXsbcNWfJM=;
        h=Date:From:To:Cc:Subject:From;
        b=WJ5KBwUFG2NNlr5wpLrhPgSa1dLMrywLrtp0zocalZW2UmDKicFg4skGwyYp0PcXw
         GsASwIYMdDZupbOtkFIC5UfLz0N5+fbXcEEZ7PpWBCOEQj5y1NPevVsZoTp07CT4yH
         IdMQPm8LuAYLoXi0DYlYNeLS5Ob9ixsDXhE2XU00=
Date:   Tue, 24 Oct 2023 09:46:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.6
Message-Id: <20231024094608.f2dc0ca5ed2619d411a31df5@linux-foundation.org>
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

The following changes since commit 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa:

  Linux 6.6-rc4 (2023-10-01 14:15:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-10-24-09-40

for you to fetch changes up to 099d7439ce03d0e7bc8f0c3d7878b562f3a48d3d:

  maple_tree: add GFP_KERNEL to allocations in mas_expected_entries() (2023-10-18 12:12:41 -0700)

----------------------------------------------------------------
20 hotfixes.  12 are cc:stable and the remainder address post-6.5 issues
or aren't considered necessary for earlier kernel versions.

----------------------------------------------------------------
Alexandre Ghiti (2):
      riscv: handle VM_FAULT_[HWPOISON|HWPOISON_LARGE] faults instead of panicking
      riscv: fix set_huge_pte_at() for NAPOT mappings when a swap entry is set

Arnd Bergmann (1):
      kasan: disable kasan_non_canonical_hook() for HW tags

Bartosz Golaszewski (1):
      mailmap: map Bartosz's old address to the current one

Gregory Price (1):
      mm/migrate: fix do_pages_move for compat pointers

Haibo Li (1):
      kasan: print the original fault addr when access invalid shadow

Johannes Weiner (1):
      mm: zswap: fix pool refcount bug around shrink_worker()

Kemeng Shi (1):
      mm/page_alloc: correct start page when guard page debug is enabled

Liam R. Howlett (4):
      mm/mempolicy: fix set_mempolicy_home_node() previous VMA pointer
      mmap: fix vma_iterator in error path of vma_merge()
      mmap: fix error paths with dup_anon_vma()
      maple_tree: add GFP_KERNEL to allocations in mas_expected_entries()

Oleksij Rempel (1):
      mailmap: correct email aliasing for Oleksij Rempel

Ondrej Jirman (1):
      MAINTAINERS: Ondrej has moved

Rik van Riel (3):
      hugetlbfs: clear resv_map pointer if mmap fails
      hugetlbfs: extend hugetlb_vma_lock to private VMAs
      hugetlbfs: close race between MADV_DONTNEED and page fault

Samasth Norway Ananda (1):
      selftests/mm: include mman header to access MREMAP_DONTUNMAP identifier

Sebastian Ott (1):
      mm: fix vm_brk_flags() to not bail out while holding lock

SeongJae Park (1):
      mm/damon/sysfs: check DAMOS regions update progress from before_terminate()

 .mailmap                                      |  6 +-
 MAINTAINERS                                   |  2 +-
 arch/riscv/mm/fault.c                         |  2 +-
 arch/riscv/mm/hugetlbpage.c                   | 19 +++++--
 include/linux/hugetlb.h                       | 41 +++++++++++++-
 include/linux/kasan.h                         |  6 +-
 lib/maple_tree.c                              |  2 +-
 lib/test_maple_tree.c                         | 35 ++++++++----
 mm/damon/sysfs.c                              |  7 ++-
 mm/hugetlb.c                                  | 82 ++++++++++++++++++++-------
 mm/kasan/report.c                             |  2 +-
 mm/memory.c                                   | 13 +++--
 mm/mempolicy.c                                |  4 +-
 mm/migrate.c                                  | 14 ++++-
 mm/mmap.c                                     | 46 ++++++++++-----
 mm/page_alloc.c                               |  2 +-
 mm/zswap.c                                    |  4 +-
 tools/include/linux/rwsem.h                   | 40 +++++++++++++
 tools/testing/selftests/mm/mremap_dontunmap.c |  1 +
 19 files changed, 255 insertions(+), 73 deletions(-)
 create mode 100644 tools/include/linux/rwsem.h

