Return-Path: <linux-kernel+bounces-121831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802C088EE4C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39397295D0B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF6714F9D1;
	Wed, 27 Mar 2024 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RsQHvkGK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0AD14D458;
	Wed, 27 Mar 2024 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711564336; cv=none; b=ECl0Cdr5FI+h655ZsZP4ko6fwGqojJ8dYDwMr62ZvbeTxTmAmgI/7rSRv6RpntqbHfI9DAXo38xXiziZiUIKsNWF0tLcN/XdomjHdCfzOxjQJDNNLsdmtx1feXriG6xAXTf1R5G4nJZZUe+gXVqVaH7KLt4KdOQRWXYtemvK4pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711564336; c=relaxed/simple;
	bh=grX1DH7yM9NWRvLZabboI42gsdIFaYdeSY/rPjWV1VI=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=bJGkZkMEy0ntw4Fe4FVLV5k9uJEKhHO4D+nlt5TTTo697OCbt3lDVWOc0BXy6zLcahqpp3ReVLZCVkClWGvIjp7nDNySdSqt3PQ5wimMVEoXSPUGtnzFJfl8AlTUt+cQT4KxhD6JiNNDozFjZUKFJOCClT3HiraQ07p2KfRUrkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RsQHvkGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53853C433F1;
	Wed, 27 Mar 2024 18:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711564335;
	bh=grX1DH7yM9NWRvLZabboI42gsdIFaYdeSY/rPjWV1VI=;
	h=Date:From:To:Cc:Subject:From;
	b=RsQHvkGKO1KiHSe/lopBY7UVNdobL371dIYPIiy1OWLmwVwBM6gCVniGyGcPf0nvI
	 9h5jtY2QwUYUYM/hN5N0vGpTRcjAj1WLGcfXyhuSUIbANRWBXwvS4hs7YxwbUW+upj
	 OlxYsKLB81rzzC8xN5W3g52D9NW1LcgWPOvYoZjo=
Date: Wed, 27 Mar 2024 11:32:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.9-rc2
Message-Id: <20240327113214.f0200bec5624169a86371797@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus, please merge this batch of hotfixes, thanks.

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-03-27-11-25

for you to fetch changes up to 32fbe5246582af4f611ccccee33fd6e559087252:

  crash: use macro to add crashk_res into iomem early for specific arch (2024-03-26 11:14:12 -0700)

----------------------------------------------------------------
21 hotfixes.  11 are cc:stable and the remainder address post-6.8 issues
or aren't considered suitable for backporting.

zswap figures prominently in the post-6.8 issues - folloup against the
large amount of changes we have just made to that code.

Apart from that, all over the map.

----------------------------------------------------------------
Baoquan He (1):
      crash: use macro to add crashk_res into iomem early for specific arch

Barry Song (1):
      mm: zswap: fix kernel BUG in sg_init_one

Carlos Maiolino (1):
      tmpfs: fix race on handling dquot rbtree

Cong Liu (1):
      tools/Makefile: remove cgroup target

Edward Liaw (2):
      selftests/mm: sigbus-wp test requires UFFD_FEATURE_WP_HUGETLBFS_SHMEM
      selftests/mm: fix ARM related issue with fork after pthread_create

Johannes Weiner (3):
      mm: cachestat: fix two shmem bugs
      mm: zswap: fix writeback shinker GFP_NOIO/GFP_NOFS recursion
      mm: zswap: fix data loss on SWP_SYNCHRONOUS_IO devices

John Sperbeck (1):
      init: open /initrd.image with O_LARGEFILE

Kuan-Wei Chiu (1):
      MAINTAINERS: remove incorrect M: tag for dm-devel@lists.linux.dev

Leonard Crestez (1):
      mailmap: update entry for Leonard Crestez

Lokesh Gidra (1):
      userfaultfd: fix deadlock warning when locking src and dst VMAs

Matthew Wilcox (Oracle) (1):
      mm: increase folio batch size

Muhammad Usama Anjum (1):
      selftests: mm: restore settings from only parent process

Nathan Chancellor (1):
      hexagon: vmlinux.lds.S: handle attributes section

Oscar Salvador (1):
      mm,page_owner: fix recursion

Peter Xu (1):
      mm/memory: fix missing pte marker for !page on pte zaps

Vitaly Chikunov (1):
      selftests/mm: Fix build with _FORTIFY_SOURCE

Zev Weiss (2):
      prctl: generalize PR_SET_MDWE support check to be per-arch
      ARM: prctl: reject PR_SET_MDWE on pre-ARMv6

 .mailmap                                          |  3 +-
 MAINTAINERS                                       |  1 -
 arch/arm/include/asm/mman.h                       | 14 +++++++
 arch/hexagon/kernel/vmlinux.lds.S                 |  1 +
 arch/parisc/include/asm/mman.h                    | 14 +++++++
 arch/x86/include/asm/crash_reserve.h              |  2 +
 include/linux/mman.h                              |  8 ++++
 include/linux/pagevec.h                           |  4 +-
 init/initramfs.c                                  |  2 +-
 kernel/crash_reserve.c                            |  7 ++++
 kernel/sys.c                                      |  7 +++-
 mm/filemap.c                                      | 16 ++++++++
 mm/memory.c                                       |  4 +-
 mm/page_owner.c                                   | 33 ++++++++++++-----
 mm/shmem_quota.c                                  | 10 +++--
 mm/userfaultfd.c                                  |  3 +-
 mm/zswap.c                                        | 45 ++++++++++++++++++++---
 tools/Makefile                                    | 13 +++----
 tools/testing/selftests/mm/gup_test.c             |  2 +-
 tools/testing/selftests/mm/protection_keys.c      |  6 ++-
 tools/testing/selftests/mm/soft-dirty.c           |  2 +-
 tools/testing/selftests/mm/split_huge_page_test.c |  2 +-
 tools/testing/selftests/mm/uffd-common.c          |  3 ++
 tools/testing/selftests/mm/uffd-common.h          |  2 +
 tools/testing/selftests/mm/uffd-unit-tests.c      | 13 ++++++-
 25 files changed, 177 insertions(+), 40 deletions(-)
 create mode 100644 arch/arm/include/asm/mman.h
 create mode 100644 arch/parisc/include/asm/mman.h


