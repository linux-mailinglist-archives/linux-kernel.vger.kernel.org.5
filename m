Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8671F8099E4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573041AbjLHCyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbjLHCxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:53:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327101BF6;
        Thu,  7 Dec 2023 18:53:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC98C433CA;
        Fri,  8 Dec 2023 02:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1702004022;
        bh=zlhh6P8Mx1zQnoxef6SBwM9ERT2cHE9T+a5LrdiDy0s=;
        h=Date:From:To:Cc:Subject:From;
        b=UGbKTtPpCj+yAL9sSSDPshkLiG2NhR9HOtITnJf+VRNAzRASnBJyw1eofaAl+1W4q
         UV5piPNJkbpEtRuDCDbRsixcU6XOwq2eMXvAI87BeSmLu+8Z71B/ob405sqoLFfKi4
         p3ZJZMPBG3oSHfvZtlUjJasgVrifKQNoQBFSiv/U=
Date:   Thu, 7 Dec 2023 18:53:41 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.7-rc5
Message-Id: <20231207185341.570f240a4f51d820c08c9e0b@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge this batch of hotfixes, thanks.


The following changes since commit 5b7ad877e4d81f8904ce83982b1ba5c6e83deccb:

  Merge tag 'afs-fixes-20231124' of git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs (2023-11-24 10:40:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-12-07-18-47

for you to fetch changes up to b2f557a21bc8fffdcd65794eda8a854e024999f3:

  mm/madvise: add cond_resched() in madvise_cold_or_pageout_pte_range() (2023-12-06 16:12:50 -0800)

----------------------------------------------------------------
31 hotfixes.  10 of these address pre-6.6 issues and are marked cc:stable.
The remainder address post-6.6 issues or aren't considered serious enough
to justify backporting.

----------------------------------------------------------------
Andrew Morton (2):
      MAINTAINERS: add Andrew Morton for lib/*
      mm/memory.c:zap_pte_range() print bad swap entry

Andy Shevchenko (1):
      units: add missing header

Bagas Sanjaya (1):
      MAINTAINERS: drop Antti Palosaari

Baoquan He (2):
      drivers/base/cpu: crash data showing should depends on KEXEC_CORE
      kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP

Chester Lin (1):
      .mailmap: add a new address mapping for Chester Lin

Florian Fainelli (1):
      scripts/gdb: fix lx-device-list-bus and lx-device-list-class

Heiko Carstens (1):
      checkstack: fix printed address

Hugh Dickins (1):
      mm: fix oops when filemap_map_pmd() without prealloc_pte

Jiexun Wang (1):
      mm/madvise: add cond_resched() in madvise_cold_or_pageout_pte_range()

Kuan-Ying Lee (1):
      scripts/gdb/tasks: fix lx-ps command error

Liu Shixin (2):
      Revert "mm/kmemleak: move the initialisation of object to __link_object"
      mm/kmemleak: move set_track_prepare() outside raw_spinlocks

Lizhi Xu (1):
      squashfs: squashfs_read_data need to check if the length is 0

Mike Kravetz (1):
      hugetlb: fix null-ptr-deref in hugetlb_vma_lock_write

Ming Lei (1):
      lib/group_cpus.c: avoid acquiring cpu hotplug lock in group_cpus_evenly

Nico Pache (1):
      selftests/mm: prevent duplicate runs caused by TEST_GEN_PROGS

Peter Xu (4):
      mm/pagemap: fix ioctl(PAGEMAP_SCAN) on vma check
      mm/pagemap: fix wr-protect even if PM_SCAN_WP_MATCHING not set
      mm/selftests: fix pagemap_ioctl memory map test
      mm/Kconfig: make userfaultfd a menuconfig

Roman Gushchin (1):
      mm: kmem: properly initialize local objcg variable in current_obj_cgroup()

Ryusuke Konishi (2):
      nilfs2: fix missing error check for sb_set_blocksize call
      nilfs2: prevent WARNING in nilfs_sufile_set_segment_usage()

SeongJae Park (2):
      mm/damon/core: copy nr_accesses when splitting region
      mm/damon/sysfs-schemes: add timeout for update_schemes_tried_regions

Sidhartha Kumar (1):
      mm/hugetlb: have CONFIG_HUGETLB_PAGE select CONFIG_XARRAY_MULTI

Su Hui (1):
      highmem: fix a memory copy problem in memcpy_from_folio

Sumanth Korikkar (2):
      mm/memory_hotplug: add missing mem_hotplug_lock
      mm/memory_hotplug: fix error handling in add_memory_resource()

 .mailmap                                   |   1 +
 CREDITS                                    |   8 ++
 MAINTAINERS                                | 186 +++++++----------------------
 arch/arm/include/asm/kexec.h               |   4 -
 arch/arm/kernel/Makefile                   |   2 +-
 drivers/base/cpu.c                         |   6 +-
 drivers/base/memory.c                      |  18 ++-
 fs/Kconfig                                 |   1 +
 fs/nilfs2/sufile.c                         |  42 +++++--
 fs/nilfs2/the_nilfs.c                      |   6 +-
 fs/proc/task_mmu.c                         |  26 +++-
 fs/squashfs/block.c                        |   2 +-
 include/linux/highmem.h                    |   2 +-
 include/linux/hugetlb.h                    |   5 +-
 include/linux/units.h                      |   1 +
 kernel/Kconfig.kexec                       |   1 -
 lib/group_cpus.c                           |  22 +++-
 mm/Kconfig                                 |  16 +--
 mm/damon/core.c                            |   1 +
 mm/damon/sysfs-schemes.c                   |  49 +++++++-
 mm/filemap.c                               |   2 +-
 mm/hugetlb.c                               |   7 ++
 mm/kmemleak.c                              |  40 ++++---
 mm/madvise.c                               |  11 ++
 mm/memcontrol.c                            |   2 +-
 mm/memory.c                                |   1 +
 mm/memory_hotplug.c                        |  15 ++-
 scripts/checkstack.pl                      |   8 +-
 scripts/gdb/linux/device.py                |  16 +--
 scripts/gdb/linux/tasks.py                 |  18 ++-
 tools/testing/selftests/mm/Makefile        |   4 +-
 tools/testing/selftests/mm/pagemap_ioctl.c |   9 +-
 32 files changed, 282 insertions(+), 250 deletions(-)

