Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3A47E65CF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjKII4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjKII43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:56:29 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AA02A4;
        Thu,  9 Nov 2023 00:56:26 -0800 (PST)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1r10ps-0001kt-00; Thu, 09 Nov 2023 09:56:24 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 01752C0136; Thu,  9 Nov 2023 09:56:08 +0100 (CET)
Date:   Thu, 9 Nov 2023 09:56:08 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS changes for v6.7
Message-ID: <ZUyeqBC1CEFmApgZ@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa:

  Linux 6.6-rc4 (2023-10-01 14:15:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.7

for you to fetch changes up to 4b7d3ab445653336db9854eedad812607760c015:

  MIPS: AR7: remove platform (2023-10-19 10:39:46 +0200)

----------------------------------------------------------------
- removed AR7 platform support
- cleanups and fixes

----------------------------------------------------------------
Arınç ÜNAL (2):
      mips: dts: ralink: mt7621: define each reset as an item
      mips: dts: ralink: mt7621: rename to GnuBee GB-PC1 and GnuBee GB-PC2

Bjorn Helgaas (2):
      MIPS: lantiq: Fix pcibios_plat_dev_init() "no previous prototype" warning
      MIPS: lantiq: Remove unnecessary include of <linux/of_irq.h>

Geert Uytterhoeven (1):
      mips: dts: ingenic: Remove unneeded probe-type properties

Huacai Chen (1):
      MIPS: KVM: Fix a build warning about variable set but not used

Keguang Zhang (1):
      MIPS: loongson32: Remove dma.h and nand.h

Peter Lafreniere (1):
      arch: mips: remove ReiserFS from defconfig

Tiezhu Yang (1):
      MIPS: Remove dead code in relocate_new_kernel

Wolfram Sang (5):
      serial: 8250: remove AR7 support
      mtd: parsers: ar7: remove support
      vlynq: remove bus driver
      watchdog: ar7_wdt: remove driver to prepare for platform removal
      MIPS: AR7: remove platform

 MAINTAINERS                                        |   7 -
 arch/arm/configs/pxa_defconfig                     |   1 -
 arch/mips/Kbuild.platforms                         |   1 -
 arch/mips/Kconfig                                  |  22 -
 arch/mips/ar7/Makefile                             |  11 -
 arch/mips/ar7/Platform                             |   5 -
 arch/mips/ar7/clock.c                              | 439 -----------
 arch/mips/ar7/gpio.c                               | 332 ---------
 arch/mips/ar7/irq.c                                | 165 -----
 arch/mips/ar7/memory.c                             |  51 --
 arch/mips/ar7/platform.c                           | 722 -------------------
 arch/mips/ar7/prom.c                               | 256 -------
 arch/mips/ar7/setup.c                              |  93 ---
 arch/mips/ar7/time.c                               |  31 -
 arch/mips/boot/compressed/uart-16550.c             |   5 -
 arch/mips/boot/dts/ingenic/jz4725b.dtsi            |   1 -
 arch/mips/boot/dts/ingenic/jz4770.dtsi             |   1 -
 arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts |   2 +-
 arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts |   2 +-
 arch/mips/boot/dts/ralink/mt7621.dtsi              |   5 +-
 arch/mips/configs/ar7_defconfig                    | 119 ---
 arch/mips/configs/fuloong2e_defconfig              |   1 -
 arch/mips/configs/jazz_defconfig                   |   4 -
 arch/mips/configs/lemote2f_defconfig               |   3 -
 arch/mips/configs/malta_defconfig                  |   5 -
 arch/mips/configs/malta_kvm_defconfig              |   5 -
 arch/mips/configs/maltaup_xpa_defconfig            |   5 -
 arch/mips/configs/rm200_defconfig                  |   4 -
 arch/mips/include/asm/mach-ar7/ar7.h               | 191 -----
 arch/mips/include/asm/mach-ar7/irq.h               |  16 -
 arch/mips/include/asm/mach-ar7/prom.h              |  12 -
 arch/mips/include/asm/mach-ar7/spaces.h            |  22 -
 arch/mips/include/asm/mach-loongson32/dma.h        |  21 -
 arch/mips/include/asm/mach-loongson32/nand.h       |  26 -
 arch/mips/include/asm/mach-loongson32/platform.h   |   3 -
 arch/mips/kernel/relocate_kernel.S                 |   1 -
 arch/mips/kvm/mmu.c                                |   3 +-
 arch/mips/loongson32/common/platform.c             |   2 -
 arch/mips/loongson32/ls1b/board.c                  |   2 -
 arch/mips/pci/fixup-lantiq.c                       |   2 +-
 drivers/Kconfig                                    |   2 -
 drivers/Makefile                                   |   1 -
 drivers/mtd/parsers/Kconfig                        |   5 -
 drivers/mtd/parsers/Makefile                       |   1 -
 drivers/mtd/parsers/ar7part.c                      | 129 ----
 drivers/tty/serial/8250/8250_port.c                |   7 -
 drivers/vlynq/Kconfig                              |  21 -
 drivers/vlynq/Makefile                             |   6 -
 drivers/vlynq/vlynq.c                              | 799 ---------------------
 drivers/watchdog/Kconfig                           |   6 -
 drivers/watchdog/Makefile                          |   1 -
 drivers/watchdog/ar7_wdt.c                         | 315 --------
 include/linux/vlynq.h                              | 149 ----
 53 files changed, 6 insertions(+), 4035 deletions(-)
 delete mode 100644 arch/mips/ar7/Makefile
 delete mode 100644 arch/mips/ar7/Platform
 delete mode 100644 arch/mips/ar7/clock.c
 delete mode 100644 arch/mips/ar7/gpio.c
 delete mode 100644 arch/mips/ar7/irq.c
 delete mode 100644 arch/mips/ar7/memory.c
 delete mode 100644 arch/mips/ar7/platform.c
 delete mode 100644 arch/mips/ar7/prom.c
 delete mode 100644 arch/mips/ar7/setup.c
 delete mode 100644 arch/mips/ar7/time.c
 delete mode 100644 arch/mips/configs/ar7_defconfig
 delete mode 100644 arch/mips/include/asm/mach-ar7/ar7.h
 delete mode 100644 arch/mips/include/asm/mach-ar7/irq.h
 delete mode 100644 arch/mips/include/asm/mach-ar7/prom.h
 delete mode 100644 arch/mips/include/asm/mach-ar7/spaces.h
 delete mode 100644 arch/mips/include/asm/mach-loongson32/dma.h
 delete mode 100644 arch/mips/include/asm/mach-loongson32/nand.h
 delete mode 100644 drivers/mtd/parsers/ar7part.c
 delete mode 100644 drivers/vlynq/Kconfig
 delete mode 100644 drivers/vlynq/Makefile
 delete mode 100644 drivers/vlynq/vlynq.c
 delete mode 100644 drivers/watchdog/ar7_wdt.c
 delete mode 100644 include/linux/vlynq.h

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
