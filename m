Return-Path: <linux-kernel+bounces-101029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB91687A0E2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08FED1C20B81
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3543B67D;
	Wed, 13 Mar 2024 01:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AmhtsckY"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000942F2B;
	Wed, 13 Mar 2024 01:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293916; cv=none; b=AVkgRKiE3z1JXyh9FtwCH6Jtank2o/jePQ3rC+jp26j5lkByCu2m5fq3Nx2N8rC/K7SuILATVFNKQS7pIG4cLQVPR8N1RgNjFmW3G2CH6GPgHI7dKMI12M1XJqVKGOQM++a8ERNWL5RxTtgGScxnsZIKFXeSA90QOZUnFjQEaRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293916; c=relaxed/simple;
	bh=elyAwsBMhBT+fZx4cbo81a/ihT1pgtXSmCdhSQhxU5c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NVW1JQdWSMVPlFZm3c6AM7ZghgkNnheUY18UjrYZNz4Vw/GT+lLo6jW1UBmrLmL1C7jWwEbpsWKroPlfLUUOHgej39naN5x8l9CekF2ZLILx/QxN+JwRLrdyRQgb0yd9Ni6n6OOmNzt5jiih3Kq8yP6z0Bf9Pp3jBTvCLF1l9uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AmhtsckY; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=hq6ZayF5HIGEfSfJFdnv7uS9zlR+5nppIUmOOmY8mBU=; b=AmhtsckYWdqbEX3JDk+Uhn6jSo
	EDz3UVDpRqqOAb/HPGcogJ823lqtFj+dXCt35FiRIFCCrE26YRijxNLAKovcxGhd6CGEYgjtcYy/8
	X0PJnH8ogOwXxYNboJF/t6JEcBRooA2rqUWUwZWEmnrgKiwztK8wKRTT+z2LGC4AlOXkYYjVKsjSa
	z4wNc20F6ICca4+Kgcnm9MYW1R1kf1GME94F0IWQ8ngdk3OHKJqsJS1N+Ix2H5y60q1W9+GBg2Wpc
	Sr5z3trRCOJKrUplxUhopaz80sYGgIuSEiFYqHyw8NQgGjEMHuCWutRHjdMUtuTgUN8NxiI76GTKd
	7bnNP2yA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkDZg-00000008SCx-3iG3;
	Wed, 13 Mar 2024 01:38:32 +0000
Date: Tue, 12 Mar 2024 18:38:32 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-modules@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Kees Cook <keescook@chromium.org>, mcgrof@kernel.org
Subject: [GIT PULL] Modules changes for v6.9-rc1
Message-ID: <ZfEDmCMBe2b6Eyky@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.9-rc1

for you to fetch changes up to d1909c0221739356f31c721de4743e7d219a56cc:

  module: Don't ignore errors from set_memory_XX() (2024-02-16 11:30:43 -0800)

----------------------------------------------------------------
Modules changes for v6.9-rc1

Christophe Leroy did most of the work on this release, first with a few
cleanups on CONFIG_STRICT_KERNEL_RWX and ending with error handling for
when set_memory_XX() can fail. This is part of a larger effort to clean
up all these callers which can fail, modules is just part of it.

This has been sitting on linux-next for about a month without issues.

----------------------------------------------------------------
Christophe Leroy (6):
      module: Use set_memory_rox()
      module: Change module_enable_{nx/x/ro}() to more explicit names
      init: Declare rodata_enabled and mark_rodata_ro() at all time
      modules: Remove #ifdef CONFIG_STRICT_MODULE_RWX around rodata_enabled
      powerpc: Simplify strict_kernel_rwx_enabled()
      module: Don't ignore errors from set_memory_XX()

Randy Dunlap (1):
      lib/test_kmod: fix kernel-doc warnings

 arch/powerpc/include/asm/mmu.h |  9 +-----
 include/linux/init.h           |  4 ---
 init/main.c                    | 21 +++++---------
 kernel/module/internal.h       |  6 ++--
 kernel/module/main.c           | 20 +++++++++++---
 kernel/module/strict_rwx.c     | 63 +++++++++++++++++++++++++++---------------
 lib/test_kmod.c                |  6 +++-
 7 files changed, 73 insertions(+), 56 deletions(-)

