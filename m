Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3647F7DB783
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjJ3KND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjJ3KNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:13:00 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55ED8A72
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:12:55 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:7082:5ab3:115b:c8d0])
        by baptiste.telenet-ops.be with bizsmtp
        id 4ACq2B00G1qcjVs01ACqoP; Mon, 30 Oct 2023 11:12:50 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qxPGL-007p2L-00;
        Mon, 30 Oct 2023 11:12:50 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qxPGM-006npy-I0;
        Mon, 30 Oct 2023 11:12:50 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [GIT PULL] m68k updates for v6.7
Date:   Mon, 30 Oct 2023 11:12:49 +0100
Message-Id: <20231030101249.1621533-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.7-tag1

for you to fetch changes up to 03191fb3db3d2585725bcffe0356d12fcfd27c4c:

  m68k: lib: Include <linux/libgcc.h> for __muldi3() (2023-10-16 14:30:40 +0200)

----------------------------------------------------------------
m68k updates for v6.7

  - Miscellaneous esthetical improvements for the floating point
    emulator,
  - Remove the last user of strlcpy(),
  - Use kernel's generic libgcc functions,
  - Miscellaneous fixes for W=1 builds,
  - Miscellaneous indentation fixes,
  - Miscellaneous fixes and improvements,
  - Defconfig updates.

Thanks for pulling!

----------------------------------------------------------------
Arnd Bergmann (1):
      m68k: io: Mark mmio read addresses as const

Azeem Shaikh (1):
      m68k: emu: Replace strlcpy() with strscpy()

Geert Uytterhoeven (68):
      m68k: math-emu: Fix incorrect file reference in fp_log.c
      m68k: math-emu: Sanitize include guards
      m68k: math-emu: Make multi_arith.h self-contained
      m68k: math-emu: Replace external declarations by header inclusion
      m68k: math-emu: Reformat function and variable headers
      m68k: math-emu: Add missing prototypes
      m68k: kernel: Add missing asmlinkage to do_notify_resume()
      m68k: kernel: Include <linux/cpu.h> for trap_init()
      m68k: kernel: Make bad_super_trap() static
      m68k: kernel: Add and use <asm/syscalls.h>
      m68k: kernel: Add and use "ints.h"
      m68k: kernel: Add and use "process.h"
      m68k: kernel: Add and use "ptrace.h"
      m68k: kernel: Add and use "signal.h"
      m68k: kernel: Add and use "traps.h"
      m68k: kernel: Add and use "vectors.h"
      m68k: mm: Include <asm/hwtest.h> for hwreg_()
      m68k: mm: Move paging_init() to common <asm/pgtable.h>
      m68k: mm: Add and use "fault.h"
      m68k: emu: Remove unused vsnprintf() return value in nfprint()
      m68k: emu: Mark version[] __maybe_unused
      m68k: amiga: pcmcia: Replace set but not used variable by READ_ONCE()
      m68k: amiga: Add and use "amiga.h"
      m68k: atari: Document data parameter of stdma_try_lock()
      m68k: atari: Make ikbd_reset() static
      m68k: atari: Make atari_platform_init() static
      m68k: atari: Make atari_stram_map_pages() static
      m68k: atari: Add and use "atari.h"
      m68k: apollo: Remove unused debug console functions
      m68k: apollo: Make local reset, serial, and irq functions static
      m68k: apollo: Replace set but not used variable by READ_ONCE()
      m68k: apollo: Add and use "apollo.h"
      m68k: bvme6000: Make bvme6000_abort_int() static
      m68k: hp300: Include "time.h" for hp300_sched_init()
      m68k: mac: Remove unused sine_data[]
      m68k: mac: Remove unused yday in unmktime()
      m68k: mac: Make mac_platform_init() static
      m68k: mac: Add and use "mac.h"
      m68k: mvme147: Make mvme147_init_IRQ() static
      m68k: mvme16x: Remove unused sink in mvme16x_cons_write()
      m68k: mvme16x: Add and use "mvme16x.h"
      m68k: q40: Add and use "q40.h"
      m68k: sun3/3x: Include <asm/config.h> for config_sun3*()
      m68k: sun3: Improve Sun3/3x DVMA abstraction in <asm/dvma.h>
      m68k: sun3: Fix context restore in flush_tlb_range()
      m68k: sun3: Fix signature of sun3_get_model()
      m68k: sun3: Add missing asmlinkage to sun3_init()
      m68k: sun3: Remove unused orig_baddr in free_baddr()
      m68k: sun3: Remove unused start_page in sun3_bootmem_alloc()
      m68k: sun3: Remove unused vsprintf() return value in prom_printf()
      m68k: sun3: Annotate prom_printf() with __printf()
      m68k: sun3: Make print_pte() static
      m68k: sun3: Make sun3_platform_init() static
      m68k: sun3x: Fix signature of sun3_leds()
      m68k: sun3x: Do not mark dvma_map_iommu() inline
      m68k: sun3x: Make sun3x_halt() static
      m68k: sun3x: Make dvma_print() static
      m68k: sun3/3x: Add and use "sun3.h"
      m68k: sun3: Change led_pattern[] to unsigned char
      m68k: Replace GPL 2.0+ README.legal boilerplate with SPDX
      m68k: defconfig: Update defconfigs for v6.6-rc1
      m68k: defconfig: Update virt_defconfig for v6.6-rc3
      m68k: Fix indentation by 7 spaces in <asm/io_mm.h>
      m68k: sun3: Fix indentation by 5 or 7 spaces
      m68k: kernel: Fix indentation by 7 spaces in traps.c
      m68k: Fix indentation by 2 or 5 spaces in <asm/page_mm.h>
      m68k: fpsp040: Fix indentation by 5 spaces
      m68k: lib: Include <linux/libgcc.h> for __muldi3()

Greg Ungerer (1):
      m68k: Use kernel's generic libgcc functions

Rolf Eike Beer (1):
      m68k: Add missing types to asm/irq.h

 arch/m68k/68000/entry.S              |  7 +--
 arch/m68k/Kconfig                    |  3 ++
 arch/m68k/amiga/amiga.h              |  5 ++
 arch/m68k/amiga/amisound.c           |  2 +
 arch/m68k/amiga/config.c             |  4 +-
 arch/m68k/amiga/pcmcia.c             |  3 +-
 arch/m68k/apollo/apollo.h            |  4 ++
 arch/m68k/apollo/config.c            | 45 ++++--------------
 arch/m68k/apollo/dn_ints.c           |  8 ++--
 arch/m68k/atari/ataints.c            |  3 +-
 arch/m68k/atari/atakeyb.c            |  2 +-
 arch/m68k/atari/atari.h              | 15 ++++++
 arch/m68k/atari/atasound.c           |  1 +
 arch/m68k/atari/config.c             | 13 ++----
 arch/m68k/atari/stdma.c              |  1 +
 arch/m68k/atari/stram.c              |  2 +-
 arch/m68k/atari/time.c               |  2 +
 arch/m68k/bvme6000/config.c          |  7 +--
 arch/m68k/coldfire/entry.S           |  7 +--
 arch/m68k/configs/amiga_defconfig    |  1 +
 arch/m68k/configs/apollo_defconfig   |  2 +
 arch/m68k/configs/atari_defconfig    |  1 +
 arch/m68k/configs/bvme6000_defconfig |  2 +
 arch/m68k/configs/hp300_defconfig    |  2 +
 arch/m68k/configs/mac_defconfig      |  1 +
 arch/m68k/configs/multi_defconfig    |  1 +
 arch/m68k/configs/mvme147_defconfig  |  2 +
 arch/m68k/configs/mvme16x_defconfig  |  2 +
 arch/m68k/configs/q40_defconfig      |  1 +
 arch/m68k/configs/sun3_defconfig     |  2 +
 arch/m68k/configs/sun3x_defconfig    |  2 +
 arch/m68k/configs/virt_defconfig     |  3 +-
 arch/m68k/emu/natfeat.c              |  9 ++--
 arch/m68k/emu/nfeth.c                |  2 +-
 arch/m68k/fpsp040/slogn.S            | 88 ++++++++++++++++++------------------
 arch/m68k/hp300/time.c               |  2 +
 arch/m68k/ifpsp060/Makefile          |  6 +--
 arch/m68k/include/asm/dvma.h         |  8 +++-
 arch/m68k/include/asm/io_mm.h        | 24 +++++-----
 arch/m68k/include/asm/irq.h          |  5 ++
 arch/m68k/include/asm/oplib.h        |  4 +-
 arch/m68k/include/asm/page_mm.h      | 45 +++++++++---------
 arch/m68k/include/asm/pgtable.h      |  9 ++++
 arch/m68k/include/asm/pgtable_no.h   |  1 -
 arch/m68k/include/asm/raw_io.h       | 32 +++++++------
 arch/m68k/include/asm/sun3_pgalloc.h | 10 ++--
 arch/m68k/include/asm/syscalls.h     | 19 ++++++++
 arch/m68k/include/asm/tlbflush.h     | 73 +++++++++++++++---------------
 arch/m68k/kernel/early_printk.c      |  4 +-
 arch/m68k/kernel/entry.S             |  7 +--
 arch/m68k/kernel/head.S              |  8 +---
 arch/m68k/kernel/ints.c              |  2 +
 arch/m68k/kernel/ints.h              |  7 +++
 arch/m68k/kernel/process.c           |  1 +
 arch/m68k/kernel/process.h           |  8 ++++
 arch/m68k/kernel/ptrace.c            |  2 +
 arch/m68k/kernel/ptrace.h            |  6 +++
 arch/m68k/kernel/setup_mm.c          |  2 -
 arch/m68k/kernel/signal.c            |  4 +-
 arch/m68k/kernel/signal.h            |  7 +++
 arch/m68k/kernel/sys_m68k.c          |  4 +-
 arch/m68k/kernel/traps.c             | 19 ++++----
 arch/m68k/kernel/traps.h             | 10 ++++
 arch/m68k/kernel/vectors.c           |  3 ++
 arch/m68k/kernel/vectors.h           |  3 ++
 arch/m68k/lib/Makefile               |  3 +-
 arch/m68k/lib/ashldi3.c              | 61 -------------------------
 arch/m68k/lib/ashrdi3.c              | 62 -------------------------
 arch/m68k/lib/lshrdi3.c              | 61 -------------------------
 arch/m68k/lib/muldi3.c               |  1 +
 arch/m68k/mac/baboon.c               |  2 +
 arch/m68k/mac/config.c               | 14 ++----
 arch/m68k/mac/iop.c                  |  2 +
 arch/m68k/mac/mac.h                  | 25 ++++++++++
 arch/m68k/mac/macboing.c             | 11 +----
 arch/m68k/mac/misc.c                 |  5 +-
 arch/m68k/mac/oss.c                  |  2 +
 arch/m68k/mac/psc.c                  |  2 +
 arch/m68k/mac/via.c                  |  2 +
 arch/m68k/math-emu/fp_arith.c        | 49 +++++++-------------
 arch/m68k/math-emu/fp_arith.h        | 49 ++++++++------------
 arch/m68k/math-emu/fp_log.c          | 46 +++++++------------
 arch/m68k/math-emu/fp_log.h          | 44 ++++++++++++++++++
 arch/m68k/math-emu/fp_trig.c         | 54 ++++++++--------------
 arch/m68k/math-emu/fp_trig.h         | 25 ++++++++--
 arch/m68k/math-emu/multi_arith.h     |  8 ++--
 arch/m68k/mm/fault.c                 |  2 +
 arch/m68k/mm/fault.h                 |  7 +++
 arch/m68k/mm/hwtest.c                |  2 +
 arch/m68k/mm/sun3kmap.c              |  6 +--
 arch/m68k/mm/sun3mmu.c               |  2 +-
 arch/m68k/mvme147/config.c           |  7 +--
 arch/m68k/mvme16x/config.c           | 10 ++--
 arch/m68k/mvme16x/mvme16x.h          |  6 +++
 arch/m68k/q40/config.c               | 11 ++---
 arch/m68k/q40/q40.h                  |  6 +++
 arch/m68k/q40/q40ints.c              |  2 +
 arch/m68k/sun3/config.c              | 13 +++---
 arch/m68k/sun3/idprom.c              |  4 +-
 arch/m68k/sun3/intersil.c            |  1 +
 arch/m68k/sun3/leds.c                |  2 +
 arch/m68k/sun3/mmu_emu.c             | 43 +++++++++---------
 arch/m68k/sun3/prom/printf.c         |  5 +-
 arch/m68k/sun3/sun3.h                | 22 +++++++++
 arch/m68k/sun3/sun3dvma.c            | 17 -------
 arch/m68k/sun3/sun3ints.c            | 12 ++---
 arch/m68k/sun3x/config.c             |  6 +--
 arch/m68k/sun3x/dvma.c               |  5 +-
 arch/m68k/sun3x/prom.c               |  2 +-
 109 files changed, 634 insertions(+), 677 deletions(-)
 create mode 100644 arch/m68k/amiga/amiga.h
 create mode 100644 arch/m68k/apollo/apollo.h
 create mode 100644 arch/m68k/atari/atari.h
 create mode 100644 arch/m68k/include/asm/syscalls.h
 create mode 100644 arch/m68k/kernel/ints.h
 create mode 100644 arch/m68k/kernel/process.h
 create mode 100644 arch/m68k/kernel/ptrace.h
 create mode 100644 arch/m68k/kernel/signal.h
 create mode 100644 arch/m68k/kernel/traps.h
 create mode 100644 arch/m68k/kernel/vectors.h
 delete mode 100644 arch/m68k/lib/ashldi3.c
 delete mode 100644 arch/m68k/lib/ashrdi3.c
 delete mode 100644 arch/m68k/lib/lshrdi3.c
 create mode 100644 arch/m68k/mac/mac.h
 create mode 100644 arch/m68k/math-emu/fp_log.h
 create mode 100644 arch/m68k/mm/fault.h
 create mode 100644 arch/m68k/mvme16x/mvme16x.h
 create mode 100644 arch/m68k/q40/q40.h
 create mode 100644 arch/m68k/sun3/sun3.h

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
