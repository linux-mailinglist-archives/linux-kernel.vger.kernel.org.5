Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2C47B486D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 17:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbjJAPjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 11:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbjJAPjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 11:39:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA12C9;
        Sun,  1 Oct 2023 08:39:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA38BC433C7;
        Sun,  1 Oct 2023 15:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696174778;
        bh=/oq0SDIUrQGm9VKxJZQaOIyN7U+l+PKbKKYbnVkn6G0=;
        h=Date:From:To:Cc:Subject:From;
        b=TxKd+OCvWpl3b/DrMZxgbVeWKpYw7VN2qdPwi056EPRIY4+T4Krr92J3QipiMwGt4
         Io8yUWrfygaJH9v2FddMVkzMxD3s7jlbZ/mmw35R+X8gr7Dk5UVvSJs3WMI6iEmcxO
         uULKDBBPDbe8CE+VF0BebOUd/ZB71ntHzd3UI3go=
Date:   Sun, 1 Oct 2023 08:39:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.6-rc4
Message-Id: <20231001083937.5f401972d99dc3168e6d4218@linux-foundation.org>
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


Linus, please merge this batch of MM and non-MM hotfixes, thanks.



The following changes since commit fe4419801617514765974f3e796269bc512ad146:

  proc: nommu: fix empty /proc/<pid>/maps (2023-09-19 13:21:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-10-01-08-34

for you to fetch changes up to e2a8f20dd8e9df695f736e51cd9115ae55be92d1:

  Crash: add lock to serialize crash hotplug handling (2023-09-29 17:20:48 -0700)

----------------------------------------------------------------
Fourteen hotfixes, eleven of which are cc:stable.  The remainder pertain
to issues which were introduced after 6.5.

----------------------------------------------------------------
Baoquan He (1):
      Crash: add lock to serialize crash hotplug handling

Domenico Cerasuolo (1):
      mm: zswap: fix potential memory corruption on duplicate store

Greg Ungerer (1):
      fs: binfmt_elf_efpic: fix personality for ELF-FDPIC

Jinjie Ruan (1):
      mm/damon/vaddr-test: fix memory leak in damon_do_test_apply_three_regions()

Juntong Deng (1):
      selftests/mm: fix awk usage in charge_reserved_hugetlb.sh and hugetlb_reparenting_test.sh that may cause error

Liam R. Howlett (2):
      maple_tree: add mas_is_active() to detect in-tree walks
      maple_tree: add MAS_UNDERFLOW and MAS_OVERFLOW states

Matthew Wilcox (Oracle) (2):
      mm: report success more often from filemap_map_folio_range()
      mm: abstract moving to the next PFN

Michal Hocko (1):
      mm, memcg: reconsider kmem.limit_in_bytes deprecation

Pan Bian (1):
      nilfs2: fix potential use after free in nilfs_gccache_submit_read_data()

Ryan Roberts (2):
      mm: hugetlb: add huge page size param to set_huge_pte_at()
      arm64: hugetlb: fix set_huge_pte_at() to work with all swap entries

Yang Shi (1):
      mm: mempolicy: keep VMA walk if both MPOL_MF_STRICT and MPOL_MF_MOVE are specified

 Documentation/admin-guide/cgroup-v1/memory.rst     |   7 +
 arch/arm64/include/asm/hugetlb.h                   |   2 +-
 arch/arm64/mm/hugetlbpage.c                        |  23 +--
 arch/parisc/include/asm/hugetlb.h                  |   2 +-
 arch/parisc/mm/hugetlbpage.c                       |   2 +-
 arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h   |   3 +-
 arch/powerpc/mm/book3s64/hugetlbpage.c             |   5 +-
 arch/powerpc/mm/book3s64/radix_hugetlbpage.c       |   3 +-
 arch/powerpc/mm/nohash/8xx.c                       |   3 +-
 arch/powerpc/mm/pgtable.c                          |   3 +-
 arch/riscv/include/asm/hugetlb.h                   |   3 +-
 arch/riscv/mm/hugetlbpage.c                        |   3 +-
 arch/s390/include/asm/hugetlb.h                    |   6 +-
 arch/s390/mm/hugetlbpage.c                         |   8 +-
 arch/sparc/include/asm/hugetlb.h                   |   6 +-
 arch/sparc/mm/hugetlbpage.c                        |   8 +-
 arch/x86/include/asm/pgtable.h                     |   8 +
 fs/binfmt_elf_fdpic.c                              |   5 +-
 fs/nilfs2/gcinode.c                                |   6 +-
 include/asm-generic/hugetlb.h                      |   2 +-
 include/linux/hugetlb.h                            |   6 +-
 include/linux/maple_tree.h                         |  11 +
 include/linux/pgtable.h                            |  10 +-
 kernel/crash_core.c                                |  17 ++
 lib/maple_tree.c                                   | 221 +++++++++++++++------
 lib/test_maple_tree.c                              |  87 ++++++--
 mm/damon/vaddr-test.h                              |   2 +
 mm/damon/vaddr.c                                   |   3 +-
 mm/filemap.c                                       |   4 +-
 mm/hugetlb.c                                       |  43 ++--
 mm/memcontrol.c                                    |  13 ++
 mm/mempolicy.c                                     |  39 ++--
 mm/migrate.c                                       |   7 +-
 mm/rmap.c                                          |  23 ++-
 mm/vmalloc.c                                       |   2 +-
 mm/zswap.c                                         |  20 ++
 .../selftests/mm/charge_reserved_hugetlb.sh        |   4 +-
 .../selftests/mm/hugetlb_reparenting_test.sh       |   4 +-
 38 files changed, 455 insertions(+), 169 deletions(-)

