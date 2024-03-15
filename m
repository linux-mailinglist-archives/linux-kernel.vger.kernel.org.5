Return-Path: <linux-kernel+bounces-104217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9879A87CAD7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54EF1C21ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4080417C6F;
	Fri, 15 Mar 2024 09:44:52 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CA517C66;
	Fri, 15 Mar 2024 09:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710495891; cv=none; b=T3SitfioplTDTX3+haVT3zNyDJtTH2f6xRdF3huunmWsma4McvwzBtDwL69GUKof2wf4sUjKYANDN4dbfbMtlJlzAr/ndulSiU38FInfablLiQDhhvC6iMgNlMHtPfU1RJ9/3un5qIqUPANABnhG1K1/3/h85qXiPbQH8Kcp5k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710495891; c=relaxed/simple;
	bh=0jGDH/dyYXZFXjOFk/pyfPSGUV4a9lho+ZbGA9PHzts=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tEzZHTYNK6Q2M9Gpiv0nJ4DG7i0qu7SVWmsh65dfyftFKjBcOW0F58P8MFqRSTCm3ijD1bimSXgWopblL15A2qJTDsK5s3hXJM8pR1Q4l5qV+7dDvsWlAKRGrrIv/DPUKqMzNL3YtzfZAv82/SrmzzhbGyj14l5LjdC7Zny3Ljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rl47B-00031f-00; Fri, 15 Mar 2024 10:44:37 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id DFC75C0267; Fri, 15 Mar 2024 10:44:28 +0100 (CET)
Date: Fri, 15 Mar 2024 10:44:28 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: torvalds@linux-foundation.org
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS changes for v6.9
Message-ID: <ZfQYfNzwx/4WeGKT@alpha.franken.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit b401b621758e46812da61fa58a67c3fd8d91de0d:

  Linux 6.8-rc5 (2024-02-18 12:56:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.9

for you to fetch changes up to 732932220078f6312f3ef57c17523d3d7f995655:

  mips: cm: Convert __mips_cm_phys_base() to weak function (2024-03-11 14:02:15 +0100)

----------------------------------------------------------------
- added support for Mobileye SoCs
- unified GPR/CP0 regs handling for uasm
- cleanups and fixes

----------------------------------------------------------------
Andy Shevchenko (2):
      MIPS: ralink: Remove unused of_gpio.h
      MIPS: ralink: Don't use "proxy" headers

Erick Archer (1):
      MIPS: Alchemy: Use kcalloc() instead of kzalloc()

Gregory CLEMENT (12):
      MIPS: spaces: Define a couple of handy macros
      MIPS: traps: Give more explanations if ebase doesn't belong to KSEG0
      MIPS: cps-vec: Use macros for 64bits access
      dt-bindings: Add vendor prefix for Mobileye Vision Technologies Ltd.
      dt-bindings: mips: cpus: Sort the entries
      dt-bindings: mips: cpu: Add I-Class I6500 Multiprocessor Core
      dt-bindings: mips: Add bindings for Mobileye SoCs
      MIPS: mobileye: Add EyeQ5 dtsi
      MIPS: mobileye: Add EPM5 device tree
      MIPS: Share generic kernel code with other architecture
      MIPS: Add support for Mobileye EyeQ5
      MAINTAINERS: Add entry for Mobileye MIPS SoCs

Ilpo Järvinen (4):
      MIPS: lantiq: Remove unused function pointer variables
      MIPS: ath79: Don't return PCIBIOS_* code from pcibios_enable_device()
      MIPS: PCI: Return PCIBIOS_* from tx4927_pci_config_read/write()
      MIPS: TXx9: Use PCI_SET_ERROR_RESPONSE()

Jiapeng Chong (1):
      bus: bt1-apb: Remove duplicate include

Jiaxun Yang (19):
      MIPS: Unify define of CP0 registers for uasm code
      MIPS: regdefs.h: Guard all defines with __ASSEMBLY__
      MIPS: regdefs.h: Define a set of register numbers
      MIPS: traps: Use GPR number macros
      MIPS: page: Use GPR number macros
      MIPS: tlbex: Use GPR number macros
      MIPS: kvm/entry: Use GPR number macros
      MIPS: pm-cps: Use GPR number macros
      MIPS: Fix set_uncached_handler for ebase in XKPHYS
      MIPS: Allows relocation exception vectors everywhere
      MIPS: Probe toolchain support of -msym32
      MIPS: Remove cc-option checks for -march=octeon
      MIPS: Fallback CPU -march flag to ISA level if unsupported
      MIPS: BMIPS: Drop unnecessary assembler flag
      MIPS: Loongson64: test for -march=loongson3a cflag
      MIPS: Limit MIPS_MT_SMP support by ISA reversion
      MIPS: Implement microMIPS MT ASE helpers
      MIPS: mipsregs: Set proper ISA level for virt extensions
      MIPS: mipsregs: Parse fp and sp register by name in parse_r

Justin Swartz (4):
      mips: dts: ralink: mt7621: associate uart1_pins with serial0
      mips: dts: ralink: mt7621: reorder serial0 properties
      mips: dts: ralink: mt7621: add serial1 and serial2 nodes
      mips: dts: ralink: mt7621: add cell count properties to usb

Lukas Bulwahn (1):
      MAINTAINERS: remove entry to non-existing file in MOBILEYE MIPS SOCS

Masahiro Yamada (1):
      MIPS: move unselectable entries out of the "CPU type" choice

Ricardo B. Marliere (6):
      mips: sgi-ip22: make gio_bus_type const
      mips: txx9: make txx9_sramc_subsys const
      tc: make tc_bus_type const
      mips: bus: make mips_cdmm_bustype const
      mips: mt: make mt_class constant
      mips: sibyte: make tb_class constant

Serge Semin (5):
      MAINTAINERS: Add maintainer for MIPS Baikal-T1 platform code
      mips: zboot: Fix "no previous prototype" build warning
      tty: mips_ejtag_fdc: Fix passing incompatible pointer type warning
      mips: cm: Convert __mips_cm_l2sync_phys_base() to weak function
      mips: cm: Convert __mips_cm_phys_base() to weak function

 Documentation/devicetree/bindings/mips/cpus.yaml   |  13 +-
 .../devicetree/bindings/mips/mobileye.yaml         |  32 ++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |  22 ++
 arch/mips/Kbuild                                   |   1 +
 arch/mips/Kbuild.platforms                         |   1 +
 arch/mips/Kconfig                                  | 138 +++++--
 arch/mips/Makefile                                 |  46 ++-
 arch/mips/alchemy/common/clock.c                   |   2 +-
 arch/mips/boot/compressed/uart-16550.c             |   2 +
 arch/mips/boot/compressed/uart-alchemy.c           |   2 +
 arch/mips/boot/compressed/uart-prom.c              |   2 +
 arch/mips/boot/dts/Makefile                        |   1 +
 arch/mips/boot/dts/mobileye/Makefile               |   4 +
 arch/mips/boot/dts/mobileye/eyeq5-epm5.dts         |  23 ++
 .../mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi | 292 ++++++++++++++
 arch/mips/boot/dts/mobileye/eyeq5.dtsi             | 124 ++++++
 arch/mips/boot/dts/ralink/mt7621.dtsi              |  47 +++
 arch/mips/configs/eyeq5_defconfig                  | 108 ++++++
 arch/mips/generic/Makefile                         |   6 +-
 arch/mips/include/asm/addrspace.h                  |   5 +
 arch/mips/include/asm/asmmacro.h                   |  22 +-
 arch/mips/include/asm/cdmm.h                       |   2 +-
 arch/mips/include/asm/mach-generic/spaces.h        |   4 +
 arch/mips/include/asm/mips-cm.h                    |  21 +-
 arch/mips/include/asm/mips_mt.h                    |   2 +-
 arch/mips/include/asm/mipsmtregs.h                 | 256 +++++++-----
 arch/mips/include/asm/mipsregs.h                   | 278 ++++++++++---
 arch/mips/include/asm/regdef.h                     |  91 +++++
 arch/mips/include/asm/smp-cps.h                    |   9 +-
 arch/mips/kernel/cps-vec.S                         |  54 +--
 arch/mips/kernel/mips-cm.c                         |  10 +-
 arch/mips/kernel/mips-mt.c                         |  14 +-
 arch/mips/kernel/pm-cps.c                          | 134 +++----
 arch/mips/kernel/rtlx-mt.c                         |   8 +-
 arch/mips/kernel/smp-cps.c                         | 141 +++++--
 arch/mips/kernel/traps.c                           |  13 +-
 arch/mips/kernel/vpe-mt.c                          |   4 +-
 arch/mips/kvm/entry.c                              | 431 +++++++++------------
 arch/mips/mm/page.c                                | 202 +++++-----
 arch/mips/mm/tlbex.c                               | 214 +++++-----
 arch/mips/mobileye/Makefile                        |   1 +
 arch/mips/mobileye/Platform                        |  15 +
 arch/mips/mobileye/board-epm5.its.S                |  24 ++
 arch/mips/mobileye/vmlinux.its.S                   |  32 ++
 arch/mips/pci/fixup-ath79.c                        |   2 +-
 arch/mips/pci/fixup-lantiq.c                       |   9 -
 arch/mips/pci/ops-tx4927.c                         |  18 +-
 arch/mips/ralink/timer.c                           |  11 +-
 arch/mips/sgi-ip22/ip22-gio.c                      |   4 +-
 arch/mips/sibyte/common/sb_tbprof.c                |  21 +-
 arch/mips/txx9/generic/setup.c                     |   2 +-
 drivers/bus/bt1-apb.c                              |   1 -
 drivers/bus/mips_cdmm.c                            |   2 +-
 drivers/tc/tc-driver.c                             |   2 +-
 drivers/tty/mips_ejtag_fdc.c                       |   2 +-
 include/linux/tc.h                                 |   2 +-
 57 files changed, 2010 insertions(+), 921 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mips/mobileye.yaml
 create mode 100644 arch/mips/boot/dts/mobileye/Makefile
 create mode 100644 arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
 create mode 100644 arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi
 create mode 100644 arch/mips/boot/dts/mobileye/eyeq5.dtsi
 create mode 100644 arch/mips/configs/eyeq5_defconfig
 create mode 100644 arch/mips/mobileye/Makefile
 create mode 100644 arch/mips/mobileye/Platform
 create mode 100644 arch/mips/mobileye/board-epm5.its.S
 create mode 100644 arch/mips/mobileye/vmlinux.its.S

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

