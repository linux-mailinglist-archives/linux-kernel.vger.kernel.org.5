Return-Path: <linux-kernel+bounces-60526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F2C850619
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 20:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696991C23EDF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 19:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7775F569;
	Sat, 10 Feb 2024 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mTYKgMGh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FFD47F4B;
	Sat, 10 Feb 2024 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707592807; cv=none; b=sPdj5EW6ln1dRQGIx42wLaIiku6Odhx3chw49/CIg8l770AtYEyvGdXE7wc6J1Cxiz+SVEd+wdAswHYuLID2oJXI58Fz3Vdr5rbUB/ejWO6HmoMCjaX0Cf270pbf4QXpiBpcVMUO1mYVntZ8O2vJuBMT+G2EAKLjCaUy8KD9CPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707592807; c=relaxed/simple;
	bh=Al1Z3XjT/ynok7TtIZl2sBGeHH7P1DKbNwiY2Cdkj38=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=NXqKz4cdBgyltxF4XxJStnuoqevYysDjMplErfC1rEzPx4/6N2W76sdC9iXHLX+m6t3bsREo+GbKiD6vCCX0fnQpQbmv+4mLdz54nrSUDeTKgZjRvuROi8KyXaXa8CO8mnQwDVc2vAaMTC1T6fa9pCwHXS6tHYksRlbQ3nz2iSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mTYKgMGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5543C43390;
	Sat, 10 Feb 2024 19:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1707592806;
	bh=Al1Z3XjT/ynok7TtIZl2sBGeHH7P1DKbNwiY2Cdkj38=;
	h=Date:From:To:Cc:Subject:From;
	b=mTYKgMGhzYC0UXw5LvoSIHQ/ghZNeO1puJSMEjT+gM/BP7FQE9a9BpqraY7lY+3og
	 8ywWabody6pVlBOi/zipJEQG/X/Bj0WC5LHhaig1eFK/oyqdll8t8zdigZ2BxQRcf8
	 Uzhxb6wv34ZchR1fRAuJ2ywQLd8mQc+/jLlsFcBc=
Date: Sat, 10 Feb 2024 11:20:06 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.8-rc4
Message-Id: <20240210112006.05781090736edc6e02de7e19@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus, please merge this batch of MM and non-MM fixes, thanks.


The following changes since commit c8bdef1560d976340e421d5e188f94789e4cfa28:

  Merge branch 'master' into mm-hotfixes-stable (2024-02-04 14:09:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-02-10-11-16

for you to fetch changes up to 5bc09b397cbf1221f8a8aacb1152650c9195b02b:

  nilfs2: fix potential bug in end_buffer_async_write (2024-02-07 21:20:37 -0800)

----------------------------------------------------------------
21 hotfixes.  12 are cc:stable and the remainder pertain to post-6.7
issues or aren't considered to be needed in earlier kernel versions.

----------------------------------------------------------------
Chengming Zhou (1):
      mm/zswap: don't return LRU_SKIP if we have dropped lru lock

Johannes Weiner (1):
      mm: zswap: fix objcg use-after-free in entry destruction

John Moon (1):
      mailmap: switch email address for John Moon

Leo Yan (1):
      MAINTAINERS: Leo Yan has moved

Miaohe Lin (1):
      mm/memory-failure: fix crash in split_huge_page_to_list from soft_offline_page

Muhammad Usama Anjum (1):
      selftests: core: include linux/close_range.h for CLOSE_RANGE_* macros

Oleg Nesterov (5):
      getrusage: move thread_group_cputime_adjusted() outside of lock_task_sighand()
      getrusage: use sig->stats_lock rather than lock_task_sighand()
      fs/proc: do_task_stat: move thread_group_cputime_adjusted() outside of lock_task_sighand()
      fs/proc: do_task_stat: use sig->stats_lock to gather the threads/children stats
      exit: wait_task_zombie: kill the no longer necessary spin_lock_irq(siglock)

Oscar Salvador (1):
      fs,hugetlb: fix NULL pointer dereference in hugetlbs_fill_super

Prakash Sangappa (1):
      mm: hugetlb pages should not be reserved by shmat() if SHM_NORESERVE

Ryan Roberts (1):
      mm/userfaultfd: UFFDIO_MOVE implementation should use ptep_get()

Ryusuke Konishi (3):
      nilfs2: fix data corruption in dsync block recovery for small block sizes
      nilfs2: fix hang in nilfs_lookup_dirty_data_buffers()
      nilfs2: fix potential bug in end_buffer_async_write

SeongJae Park (1):
      mm/damon/sysfs-schemes: fix wrong DAMOS tried regions update timeout setup

Sergey Senozhatsky (1):
      mm/madvise: don't forget to leave lazy MMU mode in madvise_cold_or_pageout_pte_range()

Suren Baghdasaryan (1):
      arch/arm/mm: fix major fault accounting when retrying under per-VMA lock

Yosry Ahmed (1):
      mm: memcg: optimize parent iteration in memcg_rstat_updated()

 .mailmap                                        |  2 +
 MAINTAINERS                                     |  2 +-
 arch/arm/mm/fault.c                             |  2 +
 fs/hugetlbfs/inode.c                            | 19 +++++--
 fs/nilfs2/file.c                                |  8 ++-
 fs/nilfs2/recovery.c                            |  7 +--
 fs/nilfs2/segment.c                             |  8 +--
 fs/proc/array.c                                 | 66 ++++++++++++++-----------
 kernel/exit.c                                   | 10 ++--
 kernel/sys.c                                    | 50 ++++++++++++-------
 mm/damon/sysfs-schemes.c                        |  2 +-
 mm/madvise.c                                    |  1 +
 mm/memcontrol.c                                 | 56 +++++++++++++--------
 mm/memory-failure.c                             |  3 ++
 mm/userfaultfd.c                                | 14 +++---
 mm/zswap.c                                      | 12 ++---
 tools/testing/selftests/core/close_range_test.c |  1 +
 17 files changed, 162 insertions(+), 101 deletions(-)


