Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F18791ECB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 23:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239179AbjIDVD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 17:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbjIDVD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 17:03:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B32AB8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 14:03:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 045A0B80FA7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 21:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3ACC433C7;
        Mon,  4 Sep 2023 21:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693861401;
        bh=358MV0N9rkXvUiLXfxaHjaiq4p3G/26YbE6LdV/L59M=;
        h=Date:To:Cc:From:Subject:From;
        b=vHlpx6O95BpR/rC2eok8qgyUOLc0qm/XEsAq4ACCEd3KRF3uqsoeJbHpeudpV7omN
         LFATE1cWOXJh9IUElgspviLe84h7cwRDs/Cfa/hnjnBmmj/x3EA1H5bAu/e1QQ9RrN
         2JejTYRLbBPuspM7vmiq0mWwAEDiMhY+BWx4UyLYCbxA9LupzdmjvxtpXF0eGGZFoX
         LyYonhSmUDUsos/TnT/3LX4MX98TpQmfy8rOoOM2Tp8Urr8pAyRdKrW8PRSZAWnuYJ
         NVsEtd7wShMO+GdDqMm852cIAFrFqJjloDERajdD5OjCK2a1ENuL0w7QYjn68nifgR
         T5PEeAZiJ4TMA==
Message-ID: <e6a52dbf-231e-2f23-78a6-54a8e62c3f27@kernel.org>
Date:   Mon, 4 Sep 2023 14:03:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
From:   Vineet Gupta <vgupta@kernel.org>
Subject: [GIT PULL] ARC updates for v6.6-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Some ARC updates for the current cycle.
There could be a minor merge conflict in arch/arc/Kconfig.

Thx,
-Vineet
----------------->
The following changes since commit 2ccdd1b13c591d306f0401d98dedc4bdcd02b421:

   Linux 6.5-rc6 (2023-08-13 11:29:55 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ 
tags/arc-6.6-rc1

for you to fetch changes up to c40cad3b0aa47d6d0995637178fb6607ac3d45c1:

   ARC: boot log: fix warning (2023-08-23 22:36:19 -0700)

----------------------------------------------------------------
ARC updates for v6.6

  -Wmissing-prototype warning fixes

  - Missing compiler barrier in relaxed atomics

  - some uaccess simplification, declutter

  - Removal of massive glocal struct cpuinfo_arc from bootlog code

  - __switch_to consolidation (removal of inline asm variant)

  - use GP to cache task pointer (vs. r25)

  - Miscll rework of entry code

----------------------------------------------------------------
Pavel Kozlov (1):
       ARC: atomics: Add compiler barrier to atomic operations...

Rob Herring (1):
       arc: Explicitly include correct DT includes

Vineet Gupta (22):
       ARC: -Wmissing-prototype warning fixes
       ARC: uaccess: remove arc specific out-of-line handles for -Os
       ARC: uaccess: use optimized generic 
__strnlen_user/__strncpy_from_user
       ARC: uaccess: elide unaliged handling if hardware supports
       ARCv2: memset: don't prefetch for len == 0 which happens a alot
       ARC: boot log: eliminate struct cpuinfo_arc #1: mm
       ARC: boot log: eliminate struct cpuinfo_arc #2: cache
       ARC: boot log: eliminate struct cpuinfo_arc #3: don't export
       ARC: boot log: eliminate struct cpuinfo_arc #4: boot log per ISA
       ARC: entry: use gp to cache task pointer (vs. r25)
       ARC: kernel stack: INIT_THREAD need not setup @init_stack in @ksp
       ARC: __switch_to: asm with dwarf ops (vs. inline asm)
       ARC: __switch_to: move ksp to thread_info from thread_struct
       ARC: entry: rework (non-functional)
       ARC: entry: ARcompact EV_ProtV to use r10 directly
       ARC: entry: EV_MachineCheck dont re-read ECR
       ARC: entry: Add more common chores to EXCEPTION_PROLOGUE
       ARC: entry: replace 8 byte OR with 4 byte BSET
       ARC: entry: replace 8 byte ADD.ne with 4 byte ADD2.ne
       ARCv2: entry: rearrange pt_regs slightly
       ARC: pt_regs: create seperate type for ecr
       ARC: boot log: fix warning

  arch/arc/Kconfig                      |   8 +-
  arch/arc/Makefile                     |   6 +-
  arch/arc/include/asm/arcregs.h        |  99 +++---
  arch/arc/include/asm/atomic-llsc.h    |   6 +-
  arch/arc/include/asm/atomic64-arcv2.h |   6 +-
  arch/arc/include/asm/current.h        |   2 +-
  arch/arc/include/asm/dwarf.h          |  32 +-
  arch/arc/include/asm/entry-arcv2.h    |  66 ++--
  arch/arc/include/asm/entry-compact.h  |  50 ++-
  arch/arc/include/asm/entry.h          | 128 +++-----
  arch/arc/include/asm/irq.h            |   1 +
  arch/arc/include/asm/mmu.h            |   2 +
  arch/arc/include/asm/processor.h      |   7 +-
  arch/arc/include/asm/ptrace.h         |  65 ++--
  arch/arc/include/asm/setup.h          |   8 +-
  arch/arc/include/asm/smp.h            |   2 +
  arch/arc/include/asm/thread_info.h    |  10 +-
  arch/arc/include/asm/uaccess.h        |  21 +-
  arch/arc/kernel/Makefile              |   9 +-
  arch/arc/kernel/asm-offsets.c         |  14 +-
  arch/arc/kernel/ctx_sw.c              | 112 -------
  arch/arc/kernel/ctx_sw_asm.S          |  76 ++---
  arch/arc/kernel/devtree.c             |   1 +
  arch/arc/kernel/entry-arcv2.S         |  15 -
  arch/arc/kernel/entry-compact.S       |  19 +-
  arch/arc/kernel/entry.S               |  70 ++---
  arch/arc/kernel/intc-arcv2.c          |   2 +-
  arch/arc/kernel/kgdb.c                |   2 +-
  arch/arc/kernel/mcip.c                |   2 -
  arch/arc/kernel/process.c             |  17 +-
  arch/arc/kernel/ptrace.c              |   8 +-
  arch/arc/kernel/setup.c               | 563 
++++++++++++++++------------------
  arch/arc/kernel/signal.c              |   1 +
  arch/arc/kernel/smp.c                 |   7 +-
  arch/arc/kernel/stacktrace.c          |   1 +
  arch/arc/kernel/traps.c               |   5 +-
  arch/arc/kernel/troubleshoot.c        |  13 +-
  arch/arc/lib/memset-archs.S           |   3 +-
  arch/arc/mm/cache.c                   | 179 ++++-------
  arch/arc/mm/extable.c                 |  11 -
  arch/arc/mm/fault.c                   |   7 +-
  arch/arc/mm/init.c                    |   1 +
  arch/arc/mm/tlb.c                     |  99 +++---
  arch/arc/plat-axs10x/axs10x.c         |   1 -
  44 files changed, 724 insertions(+), 1033 deletions(-)
  delete mode 100644 arch/arc/kernel/ctx_sw.c

