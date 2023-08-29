Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C3278C4E2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbjH2NHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbjH2NG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:06:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EBB184;
        Tue, 29 Aug 2023 06:06:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E839E60C89;
        Tue, 29 Aug 2023 13:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04861C433C7;
        Tue, 29 Aug 2023 13:06:50 +0000 (UTC)
Date:   Tue, 29 Aug 2023 15:06:47 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for v6.6-rc1
Message-ID: <ZO3tZ204Tro+83MC@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the parisc architecture fixes and enhancements for kernel 6.6-rc1.

PA-RISC now has a native eBPF JIT compiler for 32- and 64-bit
kernels, the LED driver was rewritten to use the Linux LED framework
and most of the parisc bootup code was switched to use *_initcall()
functions.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit 706a741595047797872e669b3101429ab8d378ef:

  Linux 6.5-rc7 (2023-08-20 15:02:52 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.6-rc1

for you to fetch changes up to 77e0ddf097d6d4ceaf898e088b133b99e0a97fa0:

  parisc: ccio-dma: Create private runway procfs root entry (2023-08-28 18:00:27 +0200)

----------------------------------------------------------------
parisc architecture fixes and enhancements for kernel v6.6-rc1:

* add eBPF JIT compiler for 32- and 64-bit kernel
* LCD/LED driver rewrite to utilize Linux LED subsystem
* switch to generic mmap top-down layout and brk randomization
* kernel startup cleanup by loading most drivers via arch_initcall()

----------------------------------------------------------------
Helge Deller (31):
      parisc: lasi: Register LASI power-off feature as sys_off_handler
      parisc: Drop the pa7300lc LPMC handler
      parisc: traps: Drop cpu_lpmc function pointer
      parisc: Use page table locks only if DEBUG_KERNEL is enabled
      parisc: Fix /proc/cpuinfo output for lscpu
      parisc: Use generic mmap top-down layout and brk randomization
      parisc: Add 32-bit eBPF JIT compiler
      parisc: Add 64-bit eBPF JIT compiler
      parisc: Add eBPF JIT compiler glue code and Makefile
      parisc: Fix comment on Elf64 function descriptor
      parisc: Wire up eBPF JIT compiler
      parisc: unaligned: Simplify 32-bit assembly in emulate_std()
      parisc: Avoid ioremap() for same addresss in iosapic_register()
      parisc: led: Reduce CPU overhead for disk & lan LED computation
      parisc: Makefile: Adjust order in which drivers should be loaded
      parisc: dino: Convert dino PCI bus driver to use arch_initcall()
      parisc: hppb: Convert HP PB bus driver to use arch_initcall()
      parisc: eisa: Convert HP EISA bus driver to use arch_initcall()
      parisc: ccio: Convert CCIO driver to use arch_initcall()
      parisc: gsc: Convert GSC bus driver to use arch_initcall()
      parisc: lba: Convert LBA PCI bus driver to use arch_initcall()
      parisc: led: Move register_led_regions() to late_initcall()
      parisc: sba_iommu: Convert SBA IOMMU driver to use arch_initcall()
      parisc: iosapic: Convert I/O Sapic driver to use arch_initcall()
      parisc: wax: Initialize wax driver via arch_initcall()
      parisc: asp: Initialize asp driver via arch_initcall()
      parisc: lasi: Initialize LASI driver via arch_initcall()
      parisc: led: Fix LAN receive and transmit LEDs
      parisc: led: Rewrite LED/LCD driver to utilizize Linux LED subsystem
      parisc: chassis: Do not overwrite string on LCD display
      parisc: ccio-dma: Create private runway procfs root entry

 arch/parisc/Kbuild                  |    2 +-
 arch/parisc/Kconfig                 |   19 +
 arch/parisc/Kconfig.debug           |    2 +-
 arch/parisc/include/asm/elf.h       |    3 +-
 arch/parisc/include/asm/led.h       |   16 +-
 arch/parisc/include/asm/machdep.h   |   17 -
 arch/parisc/include/asm/processor.h |    8 -
 arch/parisc/include/asm/ropes.h     |    2 +-
 arch/parisc/include/asm/runway.h    |    3 -
 arch/parisc/kernel/Makefile         |    2 +-
 arch/parisc/kernel/pa7300lc.c       |   51 --
 arch/parisc/kernel/pdc_chassis.c    |    6 +
 arch/parisc/kernel/process.c        |   20 -
 arch/parisc/kernel/processor.c      |   13 +-
 arch/parisc/kernel/setup.c          |   49 --
 arch/parisc/kernel/sys_parisc.c     |   54 +-
 arch/parisc/kernel/traps.c          |    5 +-
 arch/parisc/kernel/unaligned.c      |   25 +-
 arch/parisc/net/Makefile            |    9 +
 arch/parisc/net/bpf_jit.h           |  479 +++++++++++
 arch/parisc/net/bpf_jit_comp32.c    | 1615 +++++++++++++++++++++++++++++++++++
 arch/parisc/net/bpf_jit_comp64.c    | 1209 ++++++++++++++++++++++++++
 arch/parisc/net/bpf_jit_core.c      |  201 +++++
 drivers/parisc/Kconfig              |    3 +-
 drivers/parisc/Makefile             |   16 +-
 drivers/parisc/asp.c                |   11 +-
 drivers/parisc/ccio-dma.c           |   25 +-
 drivers/parisc/dino.c               |    6 +-
 drivers/parisc/eisa.c               |    5 +-
 drivers/parisc/gsc.c                |   15 -
 drivers/parisc/hppb.c               |    7 +-
 drivers/parisc/iosapic.c            |   12 +-
 drivers/parisc/lasi.c               |   37 +-
 drivers/parisc/lba_pci.c            |    8 +-
 drivers/parisc/led.c                |  901 ++++++++-----------
 drivers/parisc/sba_iommu.c          |    7 +-
 drivers/parisc/wax.c                |   12 +-
 mm/util.c                           |    5 +-
 38 files changed, 3997 insertions(+), 883 deletions(-)
 delete mode 100644 arch/parisc/include/asm/machdep.h
 delete mode 100644 arch/parisc/kernel/pa7300lc.c
 create mode 100644 arch/parisc/net/Makefile
 create mode 100644 arch/parisc/net/bpf_jit.h
 create mode 100644 arch/parisc/net/bpf_jit_comp32.c
 create mode 100644 arch/parisc/net/bpf_jit_comp64.c
 create mode 100644 arch/parisc/net/bpf_jit_core.c
