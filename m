Return-Path: <linux-kernel+bounces-104363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0721C87CC9E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A235B21078
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E811B977;
	Fri, 15 Mar 2024 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="XNcwQFEE"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B9B18059;
	Fri, 15 Mar 2024 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710503115; cv=none; b=lPHwYVS9TGhGPlS7Eg7zW8CuHff7N+tS5QmC1qTeZbNzO6jqgQvAvZw8j4hIS6WaXrbBhlnQF1tf6UbUTAudSW19C4Zg1yFO00a7wMggmQaPiZrXaUOLoIVk3WNvM5tF7uf3/7CbEWN6MJYgWdbu5uxjQuwziLINi8YQ4fSCwqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710503115; c=relaxed/simple;
	bh=KpR75KqgEIm8e2W9qVlAk0XBZSWfYP8ZbDa/lxuss5c=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=OoJaTU6VSjNamthZ4JdpXpdxYy09iFw616TYWbYPjM6vGCVf0xj8wLqxveMnMgUXOyIyKHnDkO7sciHnRQF8l4EXjBjHc8kUeziH9n4hg2JAJ/yYkuxXVjLuCp9NR82m4hkk6hOoGtBFwSHE43RamvR5QJnKKamIVbgMzHszmAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=XNcwQFEE; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4Tx2VN2N6fz67wk;
	Fri, 15 Mar 2024 12:45:00 +0100 (CET)
Received: from [10.10.15.22] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Tx2VH4rSZz67rw;
	Fri, 15 Mar 2024 12:44:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1710503100;
	bh=SYG6FFdYcYOSTT4mRGqhy/9e4VRQFUqz1xDByJ7kXok=;
	h=Date:From:To:Cc:Subject;
	b=XNcwQFEEIhFTijrVsVQOouxFfBCb8TyIrdMEm/C5r1nU5HbvpAO8MZK2h8GGdr/as
	 +z3tQqpJZVQ4ShcOv/YQBst2fq/gaRDQ6UCU6ndzK2Am5uHgqPCy6H8s9OOlxtEImy
	 r7TJzBoj1iNxiAA2XPwihNFgb9PHyrGSF/lnYYhI=
Message-ID: <784e533e-bd89-44fa-a966-b8104309565e@gaisler.com>
Date: Fri, 15 Mar 2024 12:44:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] sparc updates for v6.9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git tags/sparc-for-6.9-tag1

for you to fetch changes up to 84b76d05828a1909e20d0f66553b876b801f98c8:

  lib/fonts: Allow Sparc console 8x16 font for sparc64 early boot text console (2024-03-08 21:29:16 +0100)

----------------------------------------------------------------
This includes the following changes related to sparc for v6.9:

- Fix missing prototype warnings in various places, including switching
  to using generic cmpdi2/ucmpdi2 and parport.h and stop selecting
  unneeded GENERIC_ISA_DMA.
- Reduce duplicate code by using shared font data, with dependency fixup
  in separate commit touching lib/fonts.
- Convert sbus drives to use remove callbacks returning void
- Fix return values of __setup handlers
- Section mismatch fix for grpci pci drivers
- Make the vio bus type constant
- Kconfig cleanups and fixes
- Typo fixes

----------------------------------------------------------------
Andreas Larsson (1):
      lib/fonts: Allow Sparc console 8x16 font for sparc64 early boot text console

Bjorn Helgaas (1):
      sparc: Fix typos

Dr. David Alan Gilbert (1):
      sparc: Use shared font data

Lukas Bulwahn (1):
      sparc: remove obsolete config ARCH_ATU

Masahiro Yamada (1):
      sparc: select FRAME_POINTER instead of redefining it

Randy Dunlap (2):
      sparc64: NMI watchdog: fix return value of __setup handler
      sparc: vDSO: fix return value of __setup handler

Ricardo B. Marliere (1):
      sparc: vio: make vio_bus_type const

Sam Ravnborg (6):
      sparc32: Use generic cmpdi2/ucmpdi2 variants
      sparc32: Fix build with trapbase
      mtd: maps: sun_uflash: Declare uflash_devinit static
      sparc32: Do not select GENERIC_ISA_DMA
      sparc32: Fix parport build with sparc32
      sparc32: Fix section mismatch in leon_pci_grpci

Uwe Kleine-König (6):
      sbus: Add prototype for bbc_envctrl_init and bbc_envctrl_cleanup to header
      sbus: bbc_i2c: Convert to platform remove callback returning void
      sbus: display7seg: Convert to platform remove callback returning void
      sbus: envctrl: Convert to platform remove callback returning void
      sbus: flash: Convert to platform remove callback returning void
      sbus: uctrl: Convert to platform remove callback returning void

 arch/sparc/Kconfig                      |  12 +-
 arch/sparc/Kconfig.debug                |   7 +-
 arch/sparc/include/asm/hypervisor.h     |   6 +-
 arch/sparc/include/asm/ldc.h            |   2 +-
 arch/sparc/include/asm/mmu_context_64.h |   4 +-
 arch/sparc/include/asm/parport.h        | 259 +---------------------
 arch/sparc/include/asm/parport_64.h     | 256 ++++++++++++++++++++++
 arch/sparc/include/asm/switch_to_64.h   |   2 +-
 arch/sparc/kernel/btext.c               | 365 +-------------------------------
 arch/sparc/kernel/irq_32.c              |   6 +-
 arch/sparc/kernel/irq_64.c              |   2 +-
 arch/sparc/kernel/kernel.h              |   8 +-
 arch/sparc/kernel/kgdb_32.c             |   4 +-
 arch/sparc/kernel/kprobes.c             |   2 +-
 arch/sparc/kernel/ldc.c                 |   2 +-
 arch/sparc/kernel/leon_pci_grpci1.c     |   2 +-
 arch/sparc/kernel/leon_pci_grpci2.c     |   4 +-
 arch/sparc/kernel/leon_smp.c            |   6 +-
 arch/sparc/kernel/nmi.c                 |   2 +-
 arch/sparc/kernel/of_device_64.c        |   2 +-
 arch/sparc/kernel/pci.c                 |   2 +-
 arch/sparc/kernel/pci_impl.h            |   4 +-
 arch/sparc/kernel/pci_schizo.c          |   4 +-
 arch/sparc/kernel/perf_event.c          |   2 +-
 arch/sparc/kernel/prom_irqtrans.c       |   2 +-
 arch/sparc/kernel/psycho_common.c       |   2 +-
 arch/sparc/kernel/setup_32.c            |   4 +-
 arch/sparc/kernel/signal_32.c           |   2 +-
 arch/sparc/kernel/signal_64.c           |   2 +-
 arch/sparc/kernel/vio.c                 |   2 +-
 arch/sparc/lib/Makefile                 |   4 +-
 arch/sparc/lib/cmpdi2.c                 |  28 ---
 arch/sparc/lib/ucmpdi2.c                |  20 --
 arch/sparc/mm/srmmu.c                   |   2 +-
 arch/sparc/mm/tsb.c                     |   2 +-
 arch/sparc/net/bpf_jit_comp_32.c        |   6 +-
 arch/sparc/vdso/vma.c                   |   7 +-
 drivers/mtd/maps/sun_uflash.c           |   2 +-
 drivers/sbus/char/bbc_i2c.c             |   9 +-
 drivers/sbus/char/bbc_i2c.h             |   3 +
 drivers/sbus/char/display7seg.c         |   6 +-
 drivers/sbus/char/envctrl.c             |   6 +-
 drivers/sbus/char/flash.c               |   6 +-
 drivers/sbus/char/uctrl.c               |   5 +-
 lib/fonts/Kconfig                       |   3 +-
 45 files changed, 344 insertions(+), 744 deletions(-)
 create mode 100644 arch/sparc/include/asm/parport_64.h
 delete mode 100644 arch/sparc/lib/cmpdi2.c
 delete mode 100644 arch/sparc/lib/ucmpdi2.c

Thanks,
Andreas

