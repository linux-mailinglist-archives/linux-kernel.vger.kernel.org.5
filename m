Return-Path: <linux-kernel+bounces-41628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB7683F597
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 14:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A939B1C210DB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 13:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A5823761;
	Sun, 28 Jan 2024 13:28:51 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB64522EE8;
	Sun, 28 Jan 2024 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706448530; cv=none; b=dbg0ARYmaorXmyJieOnmiC0Ptt7YHIhQvUn3ISjbQt11O2RndQrgZZyljDlaQ00QYd+E+JIob+wi2LPP4PGTuBGoaQeREWtUQGFPp4/11jsJKKuhyUjUNsw6gxFjPBuLnGGFxTFhtGF9QvyUa8zRAJCqsI5OAFCxwpxo28CRnNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706448530; c=relaxed/simple;
	bh=xOmYMZ5MtseVU76edISPYkHc5kt/+yu5YKMYOBQHCJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NXg/vZbfkmSvW8bvUiMJOkuuEBuIPiCMftii1alJLzio5aEBbRTctoxJYo8HpGNoT2mZ9gsT68s8WKkQa6Gm+3itlBmyP2/Hc390lTGb+sHYypChDlzIkSw5tHj68ZHnEdZPgKtG8ijUrD7QaLWlnaM+smLBZzg6n2pZ5c0LgBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rU5DA-0001qH-00; Sun, 28 Jan 2024 14:28:36 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id A5CCCC0135; Sun, 28 Jan 2024 14:28:29 +0100 (CET)
Date: Sun, 28 Jan 2024 14:28:29 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: torvalds@linux-foundation.org
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS fixes for v6.8
Message-ID: <ZbZWfaAxU0MyPU9i@alpha.franken.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.8_1

for you to fetch changes up to 59be5c35850171e307ca5d3d703ee9ff4096b948:

  mips: Call lose_fpu(0) before initializing fcr31 in mips_set_personality_nan (2024-01-27 11:08:04 +0100)

----------------------------------------------------------------
- fix for boot issue on single core Lantiq Danube devices
- fix for boot issue on Loongson64 platforms
- fix for improper FPU setup
- fix missing prototypes issues

----------------------------------------------------------------
Aleksander Jan Bajkowski (1):
      MIPS: lantiq: register smp_ops on non-smp platforms

Florian Fainelli (3):
      MIPS: Cobalt: Fix missing prototypes
      MIPS: Alchemy: Fix missing prototypes
      MIPS: BCM63XX: Fix missing prototypes

Huang Pei (3):
      MIPS: reserve exception vector space ONLY ONCE
      MIPS: loongson64: set nid for reserved memblock region
      MIPS: loongson64: set nid for reserved memblock region

Thomas Bogendoerfer (5):
      MIPS: sgi-ip27: Fix missing prototypes
      MIPS: fw arc: Fix missing prototypes
      MIPS: sgi-ip30: Fix missing prototypes
      MIPS: sgi-ip32: Fix missing prototypes
      Revert "MIPS: loongson64: set nid for reserved memblock region"

Xi Ruoyao (1):
      mips: Call lose_fpu(0) before initializing fcr31 in mips_set_personality_nan

 arch/mips/alchemy/common/prom.c            |   1 +
 arch/mips/alchemy/common/setup.c           |   4 +-
 arch/mips/bcm63xx/boards/board_bcm963xx.c  |   2 +-
 arch/mips/bcm63xx/dev-rng.c                |   2 +-
 arch/mips/bcm63xx/dev-uart.c               |   1 +
 arch/mips/bcm63xx/dev-wdt.c                |   2 +-
 arch/mips/bcm63xx/irq.c                    |   2 +-
 arch/mips/bcm63xx/setup.c                  |   2 +-
 arch/mips/bcm63xx/timer.c                  |   2 +-
 arch/mips/cobalt/setup.c                   |   3 -
 arch/mips/fw/arc/memory.c                  |   2 +-
 arch/mips/include/asm/mach-au1x00/au1000.h |   3 +
 arch/mips/include/asm/mach-cobalt/cobalt.h |   3 +
 arch/mips/kernel/elf.c                     |   6 +
 arch/mips/kernel/traps.c                   |   8 +-
 arch/mips/lantiq/prom.c                    |   7 +-
 arch/mips/loongson64/init.c                |   3 +
 arch/mips/loongson64/numa.c                |   2 +
 arch/mips/sgi-ip27/Makefile                |   2 +-
 arch/mips/sgi-ip27/ip27-berr.c             |   4 +-
 arch/mips/sgi-ip27/ip27-common.h           |   2 +
 arch/mips/sgi-ip27/ip27-hubio.c            | 185 -----------------------------
 arch/mips/sgi-ip27/ip27-irq.c              |   2 +
 arch/mips/sgi-ip27/ip27-memory.c           |   1 +
 arch/mips/sgi-ip27/ip27-nmi.c              |  25 ++--
 arch/mips/sgi-ip30/ip30-console.c          |   1 +
 arch/mips/sgi-ip30/ip30-setup.c            |   1 +
 arch/mips/sgi-ip32/crime.c                 |   6 +-
 arch/mips/sgi-ip32/ip32-berr.c             |   2 +
 arch/mips/sgi-ip32/ip32-common.h           |  15 +++
 arch/mips/sgi-ip32/ip32-irq.c              |   6 +-
 arch/mips/sgi-ip32/ip32-memory.c           |   1 +
 arch/mips/sgi-ip32/ip32-reset.c            |   2 +
 arch/mips/sgi-ip32/ip32-setup.c            |   3 +-
 34 files changed, 83 insertions(+), 230 deletions(-)
 delete mode 100644 arch/mips/sgi-ip27/ip27-hubio.c
 create mode 100644 arch/mips/sgi-ip32/ip32-common.h

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

