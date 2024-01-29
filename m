Return-Path: <linux-kernel+bounces-42282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C286E83FEFC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3592827D2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EF24E1DF;
	Mon, 29 Jan 2024 07:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="buEMxP6W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE664E1CE;
	Mon, 29 Jan 2024 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706513284; cv=none; b=rIsUtIKMJT9ow2EqPBCN9NqGTSzK2yPVsETFudYX26T+CxoOsRIM1E41LjEVRY4sy76Aqmz0mIerhvr51l4v4aI8RGHfMHpYKNWQJmXOS+m5VsC5lGfyS3VWQnPTwiE/fLXwzn0bPFvoURNr6332NXvPWUz9txOFaoooRRiF2oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706513284; c=relaxed/simple;
	bh=Z2oS6BBjVYPhT+NnSiP9NynFvHR/xA4KdnP+bGoWRRo=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=eN4dgTlaNsEm75iTGOnYt/OseIVBcUZUU4NoNljcVDbA6HSQeM+r7hzrLjAOyE+PS2YiIYqabsQYeEQiDjGRsQSU8v9c/F1SdQDQevOeGKNYNa2ccTXBua0HhENIzj3a9F0lSSKIWTkT/9tY5OGMxrUp2XHxTK2ZkQH4fhuuxo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=buEMxP6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A52AC433F1;
	Mon, 29 Jan 2024 07:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1706513283;
	bh=Z2oS6BBjVYPhT+NnSiP9NynFvHR/xA4KdnP+bGoWRRo=;
	h=Date:From:To:Cc:Subject:From;
	b=buEMxP6W6BhKvQwuvcK1MGGd7DTo1kyWkYH3sgMXDlQ1xajRLF4LKqMmWWEbqyUXK
	 2hrE3EcfINuB3hMibYIxS+4N2z+RUIhjBoL/5cv9ceHj+HGj02qHsV9m6l3Y9IVEEi
	 laBZXuskqnU57nRLZNpc4aiten2giUAeofokKVIU=
Date: Sun, 28 Jan 2024 23:27:59 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 mm-commits@vger.kernel.org
Subject: [GIT PULL]  hotfixes for 6.8-rc3
Message-Id: <20240128232759.7535e6774bec152556fb9730@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus, please merge this batch of MM and non-MM hotfixes, thanks.


The following changes since commit f0b7a0d1d46625db5b0e631c05ae96d78eda6c70:

  Merge branch 'master' into mm-hotfixes-stable (2024-01-22 19:23:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-01-28-23-21

for you to fetch changes up to 96204e15310c218fd9355bdcacd02fed1d18070e:

  mm: thp_get_unmapped_area must honour topdown preference (2024-01-26 01:23:44 -0800)

----------------------------------------------------------------
22 hotfixes.  11 are cc:stable and the remainder address post-6.7 issues
or aren't considered appropriate for backporting.

----------------------------------------------------------------
Audra Mitchell (1):
      selftests/mm: Update va_high_addr_switch.sh to check CPU for la57 flag

David Hildenbrand (3):
      uprobes: use pagesize-aligned virtual address when replacing pages
      mm/huge_memory: fix folio_set_dirty() vs. folio_mark_dirty()
      mm/memory: fix folio_set_dirty() vs. folio_mark_dirty() in zap_pte_range()

Jan Kara (1):
      readahead: avoid multiple marked readahead pages

Johannes Weiner (1):
      mm: memcontrol: don't throttle dying tasks on memory.high

Lokesh Gidra (1):
      userfaultfd: fix mmap_changing checking in mfill_atomic_hugetlb

Marco Elver (3):
      mm, kmsan: fix infinite recursion due to RCU critical section
      stackdepot: add stats counters exported via debugfs
      stackdepot: make fast paths lock-less again

Muhammad Usama Anjum (2):
      selftests/mm: mremap_test: fix build warning
      selftests/mm: switch to bash from sh

Nico Pache (1):
      selftests: mm: fix map_hugetlb failure on 64K page size systems

Petr Vorel (1):
      MAINTAINERS: add man-pages git trees

Ryan Roberts (2):
      selftests/mm: ksm_tests should only MADV_HUGEPAGE valid memory
      mm: thp_get_unmapped_area must honour topdown preference

Samuel Holland (1):
      scs: add CONFIG_MMU dependency for vfree_atomic()

Sidhartha Kumar (1):
      fs/hugetlbfs/inode.c: mm/memory-failure.c: fix hugetlbfs hwpoison handling

Yang Shi (2):
      mm: mmap: map MAP_STACK to VM_NOHUGEPAGE
      mm: huge_memory: don't force huge page alignment on 32 bit

Yosry Ahmed (1):
      MAINTAINERS: supplement of zswap maintainers update

Zach O'Keefe (1):
      mm/writeback: fix possible divide-by-zero in wb_dirty_limits(), again

 CREDITS                                            |  13 +
 MAINTAINERS                                        |  11 +-
 arch/Kconfig                                       |   1 +
 arch/x86/include/asm/kmsan.h                       |  17 +-
 fs/hugetlbfs/inode.c                               |   2 +-
 include/linux/mman.h                               |   1 +
 include/linux/mmzone.h                             |   6 +-
 kernel/events/uprobes.c                            |   2 +-
 lib/stackdepot.c                                   | 373 +++++++++++++++------
 mm/huge_memory.c                                   |  18 +-
 mm/memcontrol.c                                    |  29 +-
 mm/memory-failure.c                                |   2 +-
 mm/memory.c                                        |   2 +-
 mm/mmap.c                                          |   6 +-
 mm/page-writeback.c                                |   2 +-
 mm/readahead.c                                     |   4 +-
 mm/userfaultfd.c                                   |  15 +-
 .../selftests/mm/charge_reserved_hugetlb.sh        |   2 +-
 tools/testing/selftests/mm/ksm_tests.c             |   2 +-
 tools/testing/selftests/mm/map_hugetlb.c           |   7 +
 tools/testing/selftests/mm/mremap_test.c           |  27 +-
 tools/testing/selftests/mm/va_high_addr_switch.sh  |   6 +
 tools/testing/selftests/mm/write_hugetlb_memory.sh |   2 +-
 23 files changed, 394 insertions(+), 156 deletions(-)


