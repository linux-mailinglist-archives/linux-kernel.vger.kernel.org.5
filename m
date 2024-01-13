Return-Path: <linux-kernel+bounces-25147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D213382C885
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 753BDB213B0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0141D18C29;
	Sat, 13 Jan 2024 00:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Kvevvtbx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D7018623;
	Sat, 13 Jan 2024 00:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5398CC433F1;
	Sat, 13 Jan 2024 00:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1705107558;
	bh=z3Og+V8n6COrYudtY52XOD7nWNIbpJKDhDbAlTUNWM0=;
	h=Date:From:To:Cc:Subject:From;
	b=KvevvtbxZlx4eMzWtOpPAAwp4sq75/VKqpzFDQEJwyWxrZD+R6O5CfQQVmL2xV4Hn
	 uNBcmbbO9JVaB1blZeC3pvTGc3693GSbMMuy48etkl24qAJppzGRQItODfbv04LcDy
	 naTLvGU4fkfateD/WFlLhTNSZLkJeKl52U76ai6U=
Date: Fri, 12 Jan 2024 16:59:17 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.8-rc1
Message-Id: <20240112165917.67505f1509909230808c06e3@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus, please merge this batch of hotfixes.  Which, for once, are not
mostly MM-related.  Thanks.


The following changes since commit ab27740f76654ed58dd32ac0ba0031c18a6dea3b:

  Merge tag 'linux_kselftest-next-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest (2024-01-09 17:28:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-01-12-16-52

for you to fetch changes up to 5d4747a6cc8e78ce74742d557fc9b7697fcacc95:

  userfaultfd: avoid huge_zero_page in UFFDIO_MOVE (2024-01-12 15:20:49 -0800)

----------------------------------------------------------------
17 hotfixes.  10 address post-6.7 issues and the other 7 are cc:stable.

----------------------------------------------------------------
Andrew Morton (1):
      kernel/crash_core.c: make __crash_hotplug_lock static

Andrey Konovalov (1):
      kasan: avoid resetting aux_lock

Carlos Llamas (1):
      scripts/decode_stacktrace.sh: optionally use LLVM utilities

Donet Tom (1):
      selftests: mm: hugepage-vmemmap fails on 64K page size systems

Huacai Chen (1):
      kdump: defer the insertion of crashkernel resources

James Gowans (1):
      kexec: do syscore_shutdown() in kernel_kexec

Johannes Weiner (1):
      mm: zswap: switch maintainers to recently active developers and reviewers

Ma Wupeng (1):
      efi: disable mirror feature during crashkernel

Manivannan Sadhasivam (1):
      mailmap: update entry for Manivannan Sadhasivam

Muhammad Usama Anjum (1):
      fs/proc/task_mmu: move mmu notification mechanism inside mm lock

Nathan Chancellor (1):
      lib/Kconfig.debug: disable CONFIG_DEBUG_INFO_BTF for Hexagon

Petr Vorel (1):
      MAINTAINERS: update LTP maintainers

Qi Zheng (1):
      MAINTAINERS: add entry for shrinker

Randy Dunlap (1):
      mailmap: add old address mappings for Randy

Sumanth Korikkar (1):
      mm/memory_hotplug: fix memmap_on_memory sysfs value retrieval

Suren Baghdasaryan (1):
      userfaultfd: avoid huge_zero_page in UFFDIO_MOVE

Tanzir Hasan (1):
      mailmap: switch email for Tanzir Hasan

 .mailmap                                      |  5 ++++-
 MAINTAINERS                                   | 28 +++++++++++++++++++-------
 fs/proc/task_mmu.c                            | 24 ++++++++++++----------
 kernel/crash_core.c                           | 16 ++++++++++++---
 kernel/kexec_core.c                           |  1 +
 lib/Kconfig.debug                             |  2 ++
 mm/kasan/generic.c                            | 10 +++++++--
 mm/memory_hotplug.c                           |  8 +++++---
 mm/mm_init.c                                  |  6 ++++++
 mm/userfaultfd.c                              |  6 ++++++
 scripts/decode_stacktrace.sh                  | 19 ++++++++++++++++--
 tools/testing/selftests/mm/hugepage-vmemmap.c | 29 +++++++++++++++++----------
 12 files changed, 114 insertions(+), 40 deletions(-)


