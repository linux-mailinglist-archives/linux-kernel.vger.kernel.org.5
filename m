Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130187944DB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244600AbjIFU5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236060AbjIFU5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:57:07 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A99C1133;
        Wed,  6 Sep 2023 13:57:02 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qdza7-0000HF-00; Wed, 06 Sep 2023 22:56:59 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 3569DC020D; Wed,  6 Sep 2023 22:54:44 +0200 (CEST)
Date:   Wed, 6 Sep 2023 22:54:44 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS changes for v6.6
Message-ID: <ZPjnFLtq9OK+UxZ2@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6eaae198076080886b9e7d57f4ae06fa782f90ef:

  Linux 6.5-rc3 (2023-07-23 15:24:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.6

for you to fetch changes up to e7513eccb7d7f82e28f4730210b42da71edaa6a6:

  MIPS: TXx9: Do PCI error checks on own line (2023-08-28 09:59:06 +0200)

----------------------------------------------------------------
just cleanups and fixes

----------------------------------------------------------------
Ilpo Järvinen (1):
      MIPS: TXx9: Do PCI error checks on own line

Jiaxun Yang (1):
      MIPS: Loongson64: Fix more __iomem attributes

Keguang Zhang (2):
      MIPS: loongson32: Remove regs-clk.h
      MIPS: loongson32: Remove regs-rtc.h

Maciej W. Rozycki (3):
      MIPS: Fix CONFIG_CPU_DADDI_WORKAROUNDS `modules_install' regression
      MIPS: Only fiddle with CHECKFLAGS if `need-compiler'
      Revert MIPS: Loongson: Fix build error when make modules_install

Masahiro Yamada (3):
      mips: remove unneeded #include <asm/export.h>
      mips: replace #include <asm/export.h> with #include <linux/export.h>
      mips: remove <asm/export.h>

Nathan Chancellor (1):
      MIPS: VDSO: Conditionally export __vdso_gettimeofday()

Rob Herring (3):
      MIPS: Explicitly include correct DT includes
      MIPS: Fixup explicit DT include clean-up
      MIPS: More explicit DT include clean-ups

Sui Jingfeng (1):
      Mips: loongson3_defconfig: Enable ast drm driver by default

Trevor Woerner (1):
      arch/mips/configs/*_defconfig cleanup

 arch/mips/Makefile                                |  16 ++-
 arch/mips/bmips/setup.c                           |   1 -
 arch/mips/cavium-octeon/flash_setup.c             |   3 +-
 arch/mips/cavium-octeon/octeon-memcpy.S           |   2 +-
 arch/mips/cavium-octeon/octeon-platform.c         |   2 +
 arch/mips/cavium-octeon/octeon-usb.c              |   2 +
 arch/mips/configs/ip22_defconfig                  |   1 -
 arch/mips/configs/loongson3_defconfig             |   1 +
 arch/mips/configs/malta_defconfig                 |   1 -
 arch/mips/configs/malta_kvm_defconfig             |   1 -
 arch/mips/configs/maltaup_xpa_defconfig           |   1 -
 arch/mips/configs/rm200_defconfig                 |   1 -
 arch/mips/include/asm/Kbuild                      |   1 -
 arch/mips/include/asm/mach-loongson32/loongson1.h |   2 -
 arch/mips/include/asm/mach-loongson32/regs-clk.h  |  81 -----------
 arch/mips/include/asm/mach-loongson32/regs-rtc.h  |  19 ---
 arch/mips/kernel/mcount.S                         |   2 +-
 arch/mips/kernel/octeon_switch.S                  |   1 -
 arch/mips/kernel/r2300_fpu.S                      |   2 +-
 arch/mips/kernel/r2300_switch.S                   |   1 -
 arch/mips/kernel/r4k_fpu.S                        |   2 +-
 arch/mips/lantiq/irq.c                            |   2 +-
 arch/mips/lantiq/xway/dcdc.c                      |   3 +-
 arch/mips/lantiq/xway/gptu.c                      |   3 +-
 arch/mips/lantiq/xway/sysctrl.c                   |   1 -
 arch/mips/lantiq/xway/vmmc.c                      |   3 +-
 arch/mips/lib/csum_partial.S                      |   2 +-
 arch/mips/lib/memcpy.S                            |   2 +-
 arch/mips/lib/memset.S                            |   2 +-
 arch/mips/lib/strncpy_user.S                      |   2 +-
 arch/mips/lib/strnlen_user.S                      |   2 +-
 arch/mips/loongson32/common/platform.c            |   8 --
 arch/mips/loongson64/smp.c                        | 160 +++++++++++-----------
 arch/mips/mm/page-funcs.S                         |   2 +-
 arch/mips/mm/tlb-funcs.S                          |   2 +-
 arch/mips/pci/pci-lantiq.c                        |   4 +-
 arch/mips/pci/pci-rt2880.c                        |   5 +-
 arch/mips/pic32/pic32mzda/config.c                |   2 +-
 arch/mips/ralink/ill_acc.c                        |   2 +
 arch/mips/ralink/irq.c                            |   2 +-
 arch/mips/ralink/of.c                             |   2 +-
 arch/mips/ralink/prom.c                           |   2 -
 arch/mips/txx9/generic/pci.c                      |  43 +++---
 arch/mips/vdso/vdso.lds.S                         |   2 +
 44 files changed, 149 insertions(+), 252 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-clk.h
 delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-rtc.h

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
