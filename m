Return-Path: <linux-kernel+bounces-26224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3904982DD01
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BCC5B21E98
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C431B17BA5;
	Mon, 15 Jan 2024 16:07:30 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B2F17BA6;
	Mon, 15 Jan 2024 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rPPUY-0002dI-00; Mon, 15 Jan 2024 17:07:14 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 62A97C0135; Mon, 15 Jan 2024 17:07:09 +0100 (CET)
Date: Mon, 15 Jan 2024 17:07:09 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: torvalds@linux-foundation.org
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: GIT PULL] MIPS changes for v6.8
Message-ID: <ZaVYLcSedkTi90lY@alpha.franken.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

there is one merge conflict in arch/mips/kernel/traps.c. Resolution is

diff --cc arch/mips/kernel/traps.c
index c58c0c3c5b40,0e3f2f2fa732..dec6878b35f6
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@@ -2152,11 -2120,8 +2120,6 @@@ void *set_vi_handler(int n, vi_handler_
  	return (void *)old_handler;
  }
  
- void *set_vi_handler(int n, vi_handler_t addr)
- {
- 	return set_vi_srs_handler(n, addr, 0);
- }
 -extern void tlb_init(void);
--
  /*
   * Timer interrupt
   */

Thomas.

The following changes since commit a39b6ac3781d46ba18193c9dbb2110f31e9bffe9:

  Linux 6.7-rc5 (2023-12-10 14:33:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.8

for you to fetch changes up to 3c1e5abcda64bed0c7bffa65af2316995f269a61:

  MIPS: Alchemy: Fix an out-of-bound access in db1550_dev_setup() (2024-01-11 12:50:30 +0100)

----------------------------------------------------------------
Just cleanups and fixes

----------------------------------------------------------------
Bjorn Helgaas (1):
      MIPS: Fix typos

Christophe JAILLET (2):
      MIPS: Alchemy: Fix an out-of-bound access in db1200_dev_setup()
      MIPS: Alchemy: Fix an out-of-bound access in db1550_dev_setup()

Gregory CLEMENT (1):
      MIPS: compressed: Use correct instruction for 64 bit code

Randy Dunlap (1):
      MIPS: SGI-IP27: hubio: fix nasid kernel-doc warning

Serge Semin (6):
      mips: dmi: Fix early remap on MIPS32
      mips: Fix incorrect max_low_pfn adjustment
      mips: Fix max_mapnr being uninitialized on early stages
      mips: Optimize max_mapnr init procedure
      mips: mm: add slab availability checking in ioremap_prot
      mips: Set dump-stack arch description

Sergio Paracuellos (1):
      MAINTAINERS: Add myself as maintainer of the Ralink architecture

Thomas Bogendoerfer (2):
      MIPS: Allow vectored interrupt handler to reside everywhere for 64bit
      MIPS: Remove unused shadow GPR support from vector irq setup

 MAINTAINERS                                        |  1 +
 arch/mips/alchemy/devboards/db1200.c               |  2 +-
 arch/mips/alchemy/devboards/db1550.c               |  2 +-
 arch/mips/bcm47xx/buttons.c                        |  6 +-
 arch/mips/bcm63xx/clk.c                            |  4 +-
 arch/mips/boot/compressed/dbg.c                    |  2 +-
 arch/mips/boot/compressed/head.S                   |  4 +-
 arch/mips/boot/elf2ecoff.c                         |  2 +-
 arch/mips/cavium-octeon/csrc-octeon.c              |  2 +-
 .../cavium-octeon/executive/cvmx-boot-vector.c     |  2 +-
 arch/mips/cavium-octeon/executive/cvmx-bootmem.c   |  2 +-
 arch/mips/cavium-octeon/executive/cvmx-cmd-queue.c |  4 +-
 .../cavium-octeon/executive/cvmx-helper-jtag.c     |  2 +-
 arch/mips/cavium-octeon/executive/cvmx-pko.c       |  2 +-
 arch/mips/cavium-octeon/octeon-platform.c          |  2 +-
 arch/mips/fw/arc/promlib.c                         |  6 +-
 arch/mips/include/asm/debug.h                      |  2 +-
 arch/mips/include/asm/dmi.h                        |  2 +-
 arch/mips/include/asm/io.h                         |  4 +-
 arch/mips/include/asm/mach-au1x00/au1000_dma.h     |  2 +-
 arch/mips/include/asm/mach-au1x00/gpio-au1000.h    |  2 +-
 .../include/asm/mach-lantiq/falcon/lantiq_soc.h    |  2 +-
 .../include/asm/mach-loongson64/loongson_hwmon.h   |  2 +-
 .../include/asm/mach-loongson64/loongson_regs.h    |  2 +-
 arch/mips/include/asm/mach-malta/spaces.h          |  4 +-
 arch/mips/include/asm/mips-boards/bonito64.h       |  2 +-
 arch/mips/include/asm/mips-cpc.h                   |  2 +-
 arch/mips/include/asm/mipsregs.h                   |  4 +-
 arch/mips/include/asm/octeon/cvmx-bootinfo.h       |  2 +-
 arch/mips/include/asm/octeon/cvmx-cmd-queue.h      |  6 +-
 arch/mips/include/asm/octeon/cvmx-pko.h            |  2 +-
 arch/mips/include/asm/octeon/cvmx-pow.h            |  4 +-
 arch/mips/include/asm/octeon/octeon-model.h        |  4 +-
 arch/mips/include/asm/page.h                       |  2 +-
 arch/mips/include/asm/pci.h                        |  2 +-
 arch/mips/include/asm/pgtable-bits.h               |  2 +-
 arch/mips/include/asm/sgi/mc.h                     |  2 +-
 arch/mips/include/asm/sn/klconfig.h                |  2 +-
 arch/mips/include/asm/sync.h                       |  2 +-
 arch/mips/include/asm/thread_info.h                |  2 +-
 arch/mips/include/asm/timex.h                      |  2 +-
 arch/mips/include/asm/vdso/vdso.h                  |  2 +-
 arch/mips/include/uapi/asm/mman.h                  |  2 +-
 arch/mips/include/uapi/asm/msgbuf.h                |  2 +-
 arch/mips/kernel/cpu-probe.c                       |  2 +-
 arch/mips/kernel/genex.S                           |  8 +-
 arch/mips/kernel/kprobes.c                         |  2 +-
 arch/mips/kernel/prom.c                            |  2 +
 arch/mips/kernel/relocate.c                        |  2 +-
 arch/mips/kernel/relocate_kernel.S                 |  2 +-
 arch/mips/kernel/setup.c                           |  6 +-
 arch/mips/kernel/signal.c                          |  2 +-
 arch/mips/kernel/traps.c                           | 93 +++++++---------------
 arch/mips/kernel/vpe.c                             |  4 +-
 arch/mips/kvm/emulate.c                            |  2 +-
 arch/mips/loongson2ef/common/platform.c            |  2 +-
 arch/mips/loongson64/smp.c                         |  2 +-
 arch/mips/mm/c-r4k.c                               |  2 +-
 arch/mips/mm/cex-gen.S                             |  2 +-
 arch/mips/mm/init.c                                | 16 ++--
 arch/mips/mm/ioremap.c                             |  4 +
 arch/mips/mm/tlb-r3k.c                             |  2 +-
 arch/mips/mm/tlb-r4k.c                             |  2 +-
 arch/mips/mm/tlbex.c                               |  4 +-
 arch/mips/net/bpf_jit_comp32.c                     |  2 +-
 arch/mips/pci/ops-loongson2.c                      |  2 +-
 arch/mips/pci/pci-alchemy.c                        |  2 +-
 arch/mips/pci/pci-ar2315.c                         |  2 +-
 arch/mips/pci/pci-lantiq.c                         |  2 +-
 arch/mips/pci/pci-octeon.c                         |  2 +-
 arch/mips/pci/pci-xtalk-bridge.c                   |  2 +-
 arch/mips/pci/pcie-octeon.c                        |  2 +-
 arch/mips/ralink/mt7621.c                          |  2 +-
 arch/mips/sgi-ip27/ip27-hubio.c                    |  2 +-
 arch/mips/txx9/generic/pci.c                       |  2 +-
 75 files changed, 135 insertions(+), 163 deletions(-)

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

