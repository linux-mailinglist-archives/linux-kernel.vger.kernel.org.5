Return-Path: <linux-kernel+bounces-1197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E56A814B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6FE1C237D2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B001036AF3;
	Fri, 15 Dec 2023 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fyOrI+jF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D145539FD5;
	Fri, 15 Dec 2023 15:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41176C433C7;
	Fri, 15 Dec 2023 15:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1702653365;
	bh=EfTyLi3GnxThzOpoGpPm9B/IL1186AUJ8lO3cfsOnEs=;
	h=Date:From:To:Cc:Subject:From;
	b=fyOrI+jFtCm8Si8oCHa9W0O8JWCi/njd1/bNEjqBluNUYV/12dwFlf6t6WcLC2yVa
	 +owKpATub/G0QIYm67VEfU2qmwITh88A6vaY/4fMZN5ZBDieouml1AqE0xUc2e1JnD
	 yF5hYSrRl9JzyhBVwN0lOksKmlPPWfKVNCvf9DKM=
Date: Fri, 15 Dec 2023 07:16:04 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.7-rc6
Message-Id: <20231215071604.946a433bbc05a6409faf5a33@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus, please merge this batch of MM, kexec and selftests hotfixes, thanks.


The following changes since commit 0c92218f4e7d4b4a7245d32bea042fa6f9cc39d7:

  Merge branch 'master' into mm-hotfixes-stable (2023-12-06 17:03:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-12-15-07-11

for you to fetch changes up to 4376807bf2d5371c3e00080c972be568c3f8a7d1:

  mm/mglru: reclaim offlined memcgs harder (2023-12-12 17:20:20 -0800)

----------------------------------------------------------------
17 hotfixes.  8 are cc:stable and the other 9 pertain to post-6.6 issues.

----------------------------------------------------------------
Baoquan He (6):
      riscv: fix VMALLOC_START definition
      loongarch, kexec: change dependency of object files
      m68k, kexec: fix the incorrect ifdeffery and build dependency of CONFIG_KEXEC
      mips, kexec: fix the incorrect ifdeffery and dependency of CONFIG_KEXEC
      sh, kexec: fix the incorrect ifdeffery and dependency of CONFIG_KEXEC
      x86, kexec: fix the wrong ifdeffery CONFIG_KEXEC

David Hildenbrand (1):
      selftests/mm: cow: print ksft header before printing anything else

David Stevens (1):
      mm/shmem: fix race in shmem_undo_range w/THP

Ignat Korchagin (1):
      kexec: drop dependency on ARCH_SUPPORTS_KEXEC from CRASH_DUMP

John Hubbard (1):
      Revert "selftests: error out if kernel header files are not yet built"

Kefeng Wang (1):
      mm: fix VMA heap bounds checking

SeongJae Park (1):
      mm/damon/core: make damon_start() waits until kdamond_fn() starts

Yu Zhao (4):
      mm/mglru: fix underprotected page cache
      mm/mglru: try to stop at high watermarks
      mm/mglru: respect min_ttl_ms with memcgs
      mm/mglru: reclaim offlined memcgs harder

Yuntao Wang (1):
      crash_core: fix the check for whether crashkernel is from high memory

 arch/loongarch/kernel/Makefile   |  2 +-
 arch/m68k/include/asm/kexec.h    |  4 +-
 arch/m68k/kernel/Makefile        |  2 +-
 arch/mips/cavium-octeon/smp.c    |  4 +-
 arch/mips/include/asm/kexec.h    |  2 +-
 arch/mips/include/asm/smp-ops.h  |  2 +-
 arch/mips/include/asm/smp.h      |  2 +-
 arch/mips/kernel/Makefile        |  2 +-
 arch/mips/kernel/smp-bmips.c     |  4 +-
 arch/mips/kernel/smp-cps.c       | 10 ++---
 arch/mips/loongson64/reset.c     |  4 +-
 arch/mips/loongson64/smp.c       |  2 +-
 arch/riscv/Kconfig               |  4 +-
 arch/riscv/include/asm/pgtable.h |  2 +-
 arch/riscv/kernel/crash_core.c   |  4 +-
 arch/sh/include/asm/kexec.h      |  4 +-
 arch/sh/kernel/Makefile          |  2 +-
 arch/sh/kernel/reboot.c          |  4 +-
 arch/sh/kernel/setup.c           |  2 +-
 arch/x86/boot/compressed/acpi.c  |  2 +-
 include/linux/damon.h            |  2 +
 include/linux/mm.h               |  8 ++--
 include/linux/mm_inline.h        | 23 ++++++----
 include/linux/mmzone.h           | 34 ++++++++-------
 kernel/Kconfig.kexec             |  1 -
 kernel/crash_core.c              | 10 ++---
 mm/damon/core.c                  |  6 +++
 mm/shmem.c                       | 19 ++++++++-
 mm/vmscan.c                      | 92 ++++++++++++++++++++++++++--------------
 mm/workingset.c                  |  6 +--
 tools/testing/selftests/Makefile | 21 +--------
 tools/testing/selftests/lib.mk   | 40 ++---------------
 tools/testing/selftests/mm/cow.c |  3 +-
 33 files changed, 171 insertions(+), 158 deletions(-)


