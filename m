Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773737E8128
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbjKJSYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345630AbjKJSXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:23:44 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC6C3B31A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 07:48:40 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-35941ccaa85so8389195ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 07:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699631320; x=1700236120; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdJHmwBJ9/m07mk31SGh6elzGpd6nJhwryHWg/U7k+4=;
        b=XfqiKx8PmcfHjmCgjJVDPkDeYq+MQyUksbHd/wAWpWvGv8ptAbZAWN/Gv8O4VNwOys
         mXNpLT/N26+dj/BoB4Ru9yXA36vTQ8Q/DLJ4qjJZO6CVP9PFaTLFsr4piN26gnfwITzn
         Zjhw3DHlQefhInhxX6IImSFCJdey2b+K73LhMSG3hU32hwamVtpOLyc2yRo8Ei8X6aEC
         fWayHYELRUhnLyBltmm5wq2Kgn1E9Or3ME4EHWpSHs+8eq8vtSkYCVMsQ3J4imgAVc8F
         tlLN8Ji1oeC+PhOzkthzTS5Cv2r+hVk/UDQNZK4i74VXk9PVRKRE/YL5HFXYSQyE/Kot
         W36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699631320; x=1700236120;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdJHmwBJ9/m07mk31SGh6elzGpd6nJhwryHWg/U7k+4=;
        b=DY7x6lj6lt7UeJiyhdK5ot5ZaEYUJRKAdO/CMOFIt7YfqhwOdvGZWSBrHc4CBa2rFJ
         hx27ZzBu6E2t8DDbfh5l5xRI0FDbG9THuLERUKw+eSeaH11WOTxueTgb8GEcNF+jiD+l
         7iX76jqLn4VXRtfB4dSBCSfwsVdhDFRzOsiDK7k3ELnKhBDc3wuHe3YGZXX8Psy+uUKf
         EP47Hz58pjWm+CNN9xNX67jU4Hr8MepaMEhDAQ+1YVXWgtmg+fsj5NJx8ltzV/It0JJs
         C+Gzy6bt86cuv5UEFpl1WBYRZQo7VnorYKaF1GtE70CIpPQkHfP6NORJQlsfCQIX222y
         da/g==
X-Gm-Message-State: AOJu0Yz4egNBjEZninlEshr2zE4/kzFU6iV0ZS/H+tLcxf9sRLMOQx3v
        5M188IzUvAGxjCXizMZzQB10x/YFOsWjyb09FOI=
X-Google-Smtp-Source: AGHT+IFL45lf9gGvwrbLkFzwQa/Izw/v0uIwJrBy6da0KxBIFLAPdud3MISjfO4lBjoIn6t+zsKBiQ==
X-Received: by 2002:a05:6e02:1b07:b0:359:4199:1fe2 with SMTP id i7-20020a056e021b0700b0035941991fe2mr10499846ilv.8.1699631320013;
        Fri, 10 Nov 2023 07:48:40 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id k76-20020a636f4f000000b005b529d633b7sm6482643pgc.14.2023.11.10.07.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 07:48:39 -0800 (PST)
Date:   Fri, 10 Nov 2023 07:48:39 -0800 (PST)
X-Google-Original-Date: Fri, 10 Nov 2023 07:48:28 PST (-0800)
Subject: [GIT PULL] RISC-V Patches for the 6.7 Merge Window, Part 2
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-9011bd86-9f72-4223-b78a-b4c69c1c927f@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e1c05b3bf80f829ced464bdca90f1dfa96e8d251:

  RISC-V: hwprobe: Fix vDSO SIGSEGV (2023-11-02 14:05:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.7-mw2

for you to fetch changes up to 457926b253200bd9bdfae9a016a3b1d1dc661d55:

  riscv: Optimize bitops with Zbb extension (2023-11-09 10:15:52 -0800)

----------------------------------------------------------------
RISC-V Patches for the 6.7 Merge Window, Part 2

* Support for handling misaligned accesses in S-mode.
* Probing for misaligned access support is now properly cached and
  handled in parallel.
* PTDUMP now reflects the SW reserved bits, as well as the PBMT and
  NAPOT extensions.
* Performance improvements for TLB flushing.
* Support for many new relocations in the module loader.
* Various bug fixes and cleanups.

----------------------------------------------------------------
Alexandre Ghiti (12):
      riscv: Improve tlb_flush()
      riscv: Improve flush_tlb_range() for hugetlb pages
      riscv: Make __flush_tlb_range() loop over pte instead of flushing the whole tlb
      riscv: Improve flush_tlb_kernel_range()
      riscv: Improve tlb_flush()
      riscv: Improve flush_tlb_range() for hugetlb pages
      riscv: Make __flush_tlb_range() loop over pte instead of flushing the whole tlb
      riscv: Improve flush_tlb_kernel_range()
      riscv: Don't use PGD entries for the linear mapping
      riscv: Fix set_memory_XX() and set_direct_map_XX() by splitting huge linear mappings
      drivers: perf: Check find_first_bit() return value
      drivers: perf: Do not broadcast to other cpus when starting a counter

Andreas Schwab (1):
      riscv: select ARCH_PROC_KCORE_TEXT

Anup Patel (2):
      RISC-V: Don't fail in riscv_of_parent_hartid() for disabled HARTs
      of: property: Add fw_devlink support for msi-parent

Charlie Jenkins (2):
      riscv: Add remaining module relocations
      riscv: Add tests for riscv module loading

Christoph Hellwig (1):
      riscv: split cache ops out of dma-noncoherent.c

Clément Léger (11):
      riscv: remove unused functions in traps_misaligned.c
      riscv: add support for misaligned trap handling in S-mode
      riscv: report perf event for misaligned fault
      riscv: add floating point insn support to misaligned access emulation
      riscv: add support for sysctl unaligned_enabled control
      riscv: annotate check_unaligned_access_boot_cpu() with __init
      riscv: report misaligned accesses emulation to hwprobe
      riscv: add support for PR_SET_UNALIGN and PR_GET_UNALIGN
      riscv: use ".L" local labels in assembly when applicable
      riscv: Use SYM_*() assembly macros instead of deprecated ones
      riscv: kernel: Use correct SYM_DATA_*() macro for data

Conor Dooley (1):
      RISC-V: capitalise CMO op macros

Emil Renner Berthing (1):
      riscv: Avoid unaligned access when relocating modules

Evan Green (3):
      RISC-V: Show accurate per-hart isa in /proc/cpuinfo
      RISC-V: Remove __init on unaligned_emulation_finish()
      RISC-V: Probe misaligned access speed in parallel

Geert Uytterhoeven (1):
      riscv: boot: Fix creation of loader.bin

Haorong Lu (1):
      riscv: signal: handle syscall restart before get_signal

Jinyu Tang (1):
      riscv: defconfig : add CONFIG_MMC_DW for starfive

Jisheng Zhang (5):
      riscv: don't probe unaligned access speed if already done
      riscv: vdso.lds.S: drop __alt_start and __alt_end symbols
      riscv: vdso.lds.S: merge .data section into .rodata section
      riscv: vdso.lds.S: remove hardcoded 0x800 .text start addr
      riscv: mm: update T-Head memory type definitions

Nam Cao (2):
      riscv: provide riscv-specific is_trap_insn()
      riscv: kprobes: allow writing to x0

Palmer Dabbelt (10):
      Merge patch series "Add support to handle misaligned accesses in S-mode"
      Merge patch series "Improve PTDUMP and introduce new fields"
      Merge patch series "riscv: vdso.lds.S: some improvement"
      Merge patch series "riscv: tlb flush improvements"
      Merge patch series "riscv: tlb flush improvements"
      Merge patch series "riscv: Add remaining module relocations and tests"
      RISC-V: Don't rely on positional structure initialization
      Merge patch series "riscv: Fix set_memory_XX() and set_direct_map_XX()"
      Merge patch series "Linux RISC-V AIA Preparatory Series"
      Merge patch "drivers: perf: Do not broadcast to other cpus when starting a counter"

Xiao Wang (2):
      riscv: Rearrange hwcap.h and cpufeature.h
      riscv: Optimize bitops with Zbb extension

Yu Chien Peter Lin (3):
      riscv: Improve PTDUMP to show RSW with non-zero value
      riscv: Introduce PBMT field to PTDUMP
      riscv: Introduce NAPOT field to PTDUMP

Yunhui Cui (1):
      riscv: add userland instruction dump to RISC-V splats

 Documentation/riscv/uabi.rst                       |  20 +
 arch/riscv/Kconfig                                 |  12 +
 arch/riscv/Kconfig.debug                           |   1 +
 arch/riscv/Makefile                                |   1 -
 arch/riscv/boot/Makefile                           |   1 +
 arch/riscv/configs/defconfig                       |   2 +
 arch/riscv/errata/andes/Makefile                   |   4 +
 arch/riscv/include/asm/bitops.h                    | 254 ++++++++-
 arch/riscv/include/asm/cpufeature.h                | 102 +++-
 arch/riscv/include/asm/elf.h                       |   2 +-
 arch/riscv/include/asm/entry-common.h              |  14 +
 arch/riscv/include/asm/errata_list.h               |   6 +-
 arch/riscv/include/asm/ftrace.h                    |  21 +
 arch/riscv/include/asm/hwcap.h                     |  91 ---
 arch/riscv/include/asm/insn-def.h                  |   8 +-
 arch/riscv/include/asm/kprobes.h                   |  11 +-
 arch/riscv/include/asm/pgtable-64.h                |  14 +-
 arch/riscv/include/asm/pgtable-bits.h              |   4 +-
 arch/riscv/include/asm/pgtable.h                   |   1 +
 arch/riscv/include/asm/processor.h                 |   9 +
 arch/riscv/include/asm/sbi.h                       |   3 -
 arch/riscv/include/asm/switch_to.h                 |   2 +-
 arch/riscv/include/asm/tlb.h                       |   8 +-
 arch/riscv/include/asm/tlbflush.h                  |  15 +-
 arch/riscv/include/asm/uprobes.h                   |  13 +-
 arch/riscv/include/asm/vector.h                    |   2 +-
 arch/riscv/include/uapi/asm/elf.h                  |   5 +-
 arch/riscv/kernel/Makefile                         |   3 +-
 arch/riscv/kernel/copy-unaligned.S                 |   8 +-
 arch/riscv/kernel/cpu.c                            |  33 +-
 arch/riscv/kernel/cpufeature.c                     |  92 +++-
 arch/riscv/kernel/entry.S                          |  15 +-
 arch/riscv/kernel/fpu.S                            | 129 ++++-
 arch/riscv/kernel/head.S                           |  30 +-
 arch/riscv/kernel/hibernate-asm.S                  |  12 +-
 arch/riscv/kernel/irq.c                            |   4 +-
 arch/riscv/kernel/mcount-dyn.S                     |  20 +-
 arch/riscv/kernel/mcount.S                         |  18 +-
 arch/riscv/kernel/module.c                         | 608 +++++++++++++++++----
 arch/riscv/kernel/probes/rethook_trampoline.S      |   4 +-
 arch/riscv/kernel/probes/simulate-insn.c           |   2 +-
 arch/riscv/kernel/probes/uprobes.c                 |   6 +
 arch/riscv/kernel/process.c                        |  18 +
 arch/riscv/kernel/sbi.c                            |  32 +-
 arch/riscv/kernel/setup.c                          |  13 -
 arch/riscv/kernel/signal.c                         |  92 ++--
 arch/riscv/kernel/smpboot.c                        |   1 -
 arch/riscv/kernel/suspend_entry.S                  |   4 +-
 arch/riscv/kernel/tests/Kconfig.debug              |  35 ++
 arch/riscv/kernel/tests/Makefile                   |   1 +
 arch/riscv/kernel/tests/module_test/Makefile       |  15 +
 .../tests/module_test/test_module_linking_main.c   |  88 +++
 arch/riscv/kernel/tests/module_test/test_set16.S   |  23 +
 arch/riscv/kernel/tests/module_test/test_set32.S   |  20 +
 arch/riscv/kernel/tests/module_test/test_set6.S    |  23 +
 arch/riscv/kernel/tests/module_test/test_set8.S    |  23 +
 arch/riscv/kernel/tests/module_test/test_sub16.S   |  20 +
 arch/riscv/kernel/tests/module_test/test_sub32.S   |  20 +
 arch/riscv/kernel/tests/module_test/test_sub6.S    |  20 +
 arch/riscv/kernel/tests/module_test/test_sub64.S   |  25 +
 arch/riscv/kernel/tests/module_test/test_sub8.S    |  20 +
 arch/riscv/kernel/tests/module_test/test_uleb128.S |  31 ++
 arch/riscv/kernel/traps.c                          |  58 +-
 arch/riscv/kernel/traps_misaligned.c               | 375 +++++++++++--
 arch/riscv/kernel/vdso/flush_icache.S              |   4 +-
 arch/riscv/kernel/vdso/getcpu.S                    |   4 +-
 arch/riscv/kernel/vdso/rt_sigreturn.S              |   4 +-
 arch/riscv/kernel/vdso/sys_hwprobe.S               |   4 +-
 arch/riscv/kernel/vdso/vdso.lds.S                  |  30 +-
 arch/riscv/kvm/aia.c                               |   2 +-
 arch/riscv/kvm/main.c                              |   2 +-
 arch/riscv/kvm/tlb.c                               |   2 +-
 arch/riscv/kvm/vcpu_fp.c                           |   2 +-
 arch/riscv/kvm/vcpu_onereg.c                       |   2 +-
 arch/riscv/kvm/vcpu_vector.c                       |   2 +-
 arch/riscv/lib/clear_page.S                        |  32 +-
 arch/riscv/lib/memcpy.S                            |   6 +-
 arch/riscv/lib/memmove.S                           |  57 +-
 arch/riscv/lib/memset.S                            |   6 +-
 arch/riscv/lib/uaccess.S                           |  11 +-
 arch/riscv/mm/Makefile                             |   1 +
 arch/riscv/mm/cache-ops.c                          |  17 +
 arch/riscv/mm/dma-noncoherent.c                    |  23 +-
 arch/riscv/mm/init.c                               |  12 +-
 arch/riscv/mm/pageattr.c                           | 270 +++++++--
 arch/riscv/mm/pmem.c                               |   4 +-
 arch/riscv/mm/ptdump.c                             |  53 +-
 arch/riscv/mm/tlbflush.c                           | 181 +++---
 arch/riscv/purgatory/entry.S                       |  16 +-
 drivers/clocksource/timer-riscv.c                  |   2 +-
 drivers/firmware/efi/libstub/Makefile              |   2 +-
 drivers/of/property.c                              |   2 +
 drivers/perf/riscv_pmu.c                           |   3 +-
 drivers/perf/riscv_pmu_sbi.c                       |  17 +-
 tools/testing/selftests/riscv/mm/Makefile          |   6 +-
 .../riscv/mm/{testcases => }/mmap_bottomup.c       |   2 +-
 .../riscv/mm/{testcases => }/mmap_default.c        |   2 +-
 .../selftests/riscv/mm/{testcases => }/mmap_test.h |   0
 .../selftests/riscv/mm/{testcases => }/run_mmap.sh |   0
 99 files changed, 2619 insertions(+), 731 deletions(-)
 create mode 100644 arch/riscv/kernel/tests/Kconfig.debug
 create mode 100644 arch/riscv/kernel/tests/Makefile
 create mode 100644 arch/riscv/kernel/tests/module_test/Makefile
 create mode 100644 arch/riscv/kernel/tests/module_test/test_module_linking_main.c
 create mode 100644 arch/riscv/kernel/tests/module_test/test_set16.S
 create mode 100644 arch/riscv/kernel/tests/module_test/test_set32.S
 create mode 100644 arch/riscv/kernel/tests/module_test/test_set6.S
 create mode 100644 arch/riscv/kernel/tests/module_test/test_set8.S
 create mode 100644 arch/riscv/kernel/tests/module_test/test_sub16.S
 create mode 100644 arch/riscv/kernel/tests/module_test/test_sub32.S
 create mode 100644 arch/riscv/kernel/tests/module_test/test_sub6.S
 create mode 100644 arch/riscv/kernel/tests/module_test/test_sub64.S
 create mode 100644 arch/riscv/kernel/tests/module_test/test_sub8.S
 create mode 100644 arch/riscv/kernel/tests/module_test/test_uleb128.S
 create mode 100644 arch/riscv/mm/cache-ops.c
 rename tools/testing/selftests/riscv/mm/{testcases => }/mmap_bottomup.c (97%)
 rename tools/testing/selftests/riscv/mm/{testcases => }/mmap_default.c (97%)
 rename tools/testing/selftests/riscv/mm/{testcases => }/mmap_test.h (100%)
 rename tools/testing/selftests/riscv/mm/{testcases => }/run_mmap.sh (100%)
