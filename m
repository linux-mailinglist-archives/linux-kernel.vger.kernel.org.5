Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1C478FF5A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350043AbjIAOlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 10:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbjIAOla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:41:30 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA5A18C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 07:41:26 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c1f8aaab9aso16293695ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 07:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1693579286; x=1694184086; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLlSfXwVonxJLrQGX+Lv1RGvQVN/wPNIsAMhfrK2IUM=;
        b=l7mN03/XvZcB1L52WktN/Z+HBIHe5PZVwcx/bDraozdpJ66hdDtFAv4wuD358wn/Kp
         keTnGaXyjw7RLMH4Jr9S43rmGa0mgRXayLOIy8tsPA+ygIE7Ptx4R4X2UyO28G0TCPFf
         LVPjyqOH0ewmlUaQpxGbYGCG1ONQMX0vud3b6folJLFewqEqmbS3Jmsda/bwYDb1U83D
         P29nE8uCMKT7XYJ+I0d5iz3TtXDwbV179H0TG4fwuPBvLDiM6Czs+ueZSJNXCP7CsI59
         OBm7eUiCrxgTxhrCqA40S1ft+m9TQRSVvT66ZadNncT972V/9nFyoKTWHBCWwXk1BuLP
         t/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693579286; x=1694184086;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLlSfXwVonxJLrQGX+Lv1RGvQVN/wPNIsAMhfrK2IUM=;
        b=GlWlRfGxSSu1FTWr/D7Q70uM4jyyEgUmuKPyKW2+V20Jl7s2Oe3mvMld7PP38NF5QZ
         LsURLHZcTNw0Ql6JNNM7mTxv5WNRbSvDcwYyBvWl4USE7BOrOVK1uLYVFqDrqH/jWqs4
         sY5rNzE5UinWL8GzzYqpxXMODBaMR4ot7CZL445/TvvVjBsLPE/d4m8MAe+eImaawaj1
         BtpUfExRPYN4KdHzHqp9EyIrnr6wOUlAizL87CXrQSrrUMWuMnKmNKEI7IPEHEmwNk3N
         ww8pJiJ/xCbAQcwFUwny54zv0Hme5QI+ABW7eN43get1TraIIzsmaG7bWeFv67ECJtr0
         jwAw==
X-Gm-Message-State: AOJu0YycqbjTLOUdtAcnYK3xAOkCeXvQDiHi1LJ1iMLrXzm4QgGE2d3V
        6aOXhcYfyxvlIpaBRuPvv20yEIWQorqZNCwSe+A=
X-Google-Smtp-Source: AGHT+IEho09RSXAlSSvcunWsCMhPHOWZ4UtPEasDr/qdHewzd368KiJVUS05Tybf5XCnrYejhMhq/g==
X-Received: by 2002:a17:902:d48e:b0:1c0:ce51:8e8d with SMTP id c14-20020a170902d48e00b001c0ce518e8dmr3266256plg.67.1693579286312;
        Fri, 01 Sep 2023 07:41:26 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id jo6-20020a170903054600b001b86492d724sm3073656plb.223.2023.09.01.07.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 07:41:21 -0700 (PDT)
Date:   Fri, 01 Sep 2023 07:41:21 -0700 (PDT)
X-Google-Original-Date: Fri, 01 Sep 2023 07:41:10 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 6.6 Merge Window, Part 1
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-d12081f2-1ff7-4f68-b320-f3aa5c458365@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.6-mw1

for you to fetch changes up to 89775a27ff6d0396b44de0d6f44dcbc25221fdda:

  lib/Kconfig.debug: Restrict DEBUG_INFO_SPLIT for RISC-V (2023-08-31 00:18:37 -0700)

----------------------------------------------------------------
RISC-V Patches for the 6.6 Merge Window, Part 1

* Support for the new "riscv,isa-extensions" and "riscv,isa-base" device
  tree interfaces for probing extensions.
* Support for userspace access to the performance counters.
* Support for more instructions in kprobes.
* Crash kernels can be allocated above 4GiB.
* Support for KCFI.
* Support for ELFs in !MMU configurations.
* ARCH_KMALLOC_MINALIGN has been reduced to 8.
* mmap() defaults to sv48-sized addresses, with longer addresses hidden
  behind a hint (similar to Arm and Intel).
* Also various fixes and cleanups.

----------------------------------------------------------------
I'll all but certainly have a second pull request, there's already some stuff
stacking up on for-next and there's a few stragglers on the lists -- mostly
stuff with dependencies on other trees, but this cycle has been a bit clunkier
than usual on my end so there's a little more floating around that usual.

I had to fix up two merge conflicts manually, only one managed to show up in
git.  There's some more --cc diff in cpufeature.c, I remember having fixed that
all up on the merge side but apologies if something ended up in rerere and I
forgot about it.

Here's the one that showed up in git:

diff --cc arch/riscv/mm/init.cindex c07ff3e2c90a,156e09a1ceee..8f47a6ee353e---
a/arch/riscv/mm/init.c+++ b/arch/riscv/mm/init.c@@@ -1347,12 -1393,37 +1395,38
@@@ static void __init reserve_crashkernel(         * swiotlb can work on the
crash kernel.         */        crash_base =
memblock_phys_alloc_range(crash_size, PMD_SIZE, -                             
               search_start, search_end); +                                   
         search_start, +                                            
min(search_end, (unsigned long)(SZ_4G - 1)));

for the other the result I ended up with was

extern pgd_t early_pg_dir[PTRS_PER_PGD];
static pgd_t tmp_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
static p4d_t tmp_p4d[PTRS_PER_P4D] __page_aligned_bss;
static pud_t tmp_pud[PTRS_PER_PUD] __page_aligned_bss;

though that's not showing up in the git diff, so I may have something odd going
on here.

----------------------------------------------------------------
Alexandre Ghiti (12):
      perf: Fix wrong comment about default event_idx
      include: riscv: Fix wrong include guard in riscv_pmu.h
      riscv: Make legacy counter enum match the HW numbering
      drivers: perf: Rename riscv pmu sbi driver
      riscv: Prepare for user-space perf event mmap support
      drivers: perf: Implement perf event mmap support in the legacy backend
      drivers: perf: Implement perf event mmap support in the SBI backend
      Documentation: admin-guide: Add riscv sysctl_perf_user_access
      tools: lib: perf: Implement riscv mmap support
      perf: tests: Adapt mmap-basic.c for riscv
      riscv: Mark KASAN tmp* page tables variables as static
      riscv: Move create_tmp_mapping() to init sections

Björn Töpel (1):
      riscv: Require FRAME_POINTER for some configurations

Charlie Jenkins (4):
      RISC-V: mm: Restrict address space for sv39,sv48,sv57
      RISC-V: mm: Add tests for RISC-V mm
      RISC-V: mm: Update pgtable comment documentation
      RISC-V: mm: Document mmap changes

Chen Jiahao (2):
      riscv: kdump: Implement crashkernel=X,[high,low]
      docs: kdump: Update the crashkernel description for riscv

Conor Dooley (9):
      RISC-V: drop a needless check in print_isa_ext()
      RISC-V: shunt isa_ext_arr to cpufeature.c
      RISC-V: repurpose riscv_isa_ext array in riscv_fill_hwcap()
      RISC-V: add missing single letter extension definitions
      RISC-V: add single letter extensions to riscv_isa_ext
      RISC-V: split riscv_fill_hwcap() in 3
      RISC-V: enable extension detection from dedicated properties
      RISC-V: try new extension properties in of_early_processor_hartid()
      RISC-V: provide Kconfig & commandline options to control parsing "riscv,isa"

Greg Ungerer (2):
      binfmt_elf_fdpic: support 64-bit systems
      riscv: support the elf-fdpic binfmt loader

Guo Ren (1):
      riscv: sigcontext: Correct the comment of sigreturn

Heiko Stuebner (1):
      RISC-V: don't parse dt/acpi isa string to get rv32/rv64

Jisheng Zhang (4):
      riscv: allow kmalloc() caches aligned to the smallest value
      riscv: enable DMA_BOUNCE_UNALIGNED_KMALLOC for !dma_coherent
      riscv: enable DEBUG_FORCE_FUNCTION_ALIGN_64B
      riscv: support PREEMPT_DYNAMIC with static keys

Justin Stitt (1):
      RISC-V: cpu: refactor deprecated strncpy

Nam Cao (4):
      riscv: kprobes: simulate c.j instruction
      riscv: kprobes: simulate c.jr and c.jalr instructions
      riscv: kprobes: simulate c.beqz and c.bnez
      riscv: remove redundant mv instructions

Nathan Chancellor (1):
      lib/Kconfig.debug: Restrict DEBUG_INFO_SPLIT for RISC-V

Palmer Dabbelt (9):
      RISC-V: Provide a more helpful error message on invalid ISA strings
      Merge patch series "RISC-V: Probe DT extension support using riscv,isa-extensions & riscv,isa-base"
      Merge patch series "riscv: Allow userspace to directly access perf counters"
      Merge patch series "riscv: kprobes: simulate some instructions"
      Merge patch series "support allocating crashkernel above 4G explicitly on riscv"
      Merge patch series "riscv: KCFI support"
      Merge patch series "riscv: support ELF format binaries in nommu mode"
      Merge patch series "riscv: Reduce ARCH_KMALLOC_MINALIGN to 8"
      Merge patch series "RISC-V: mm: Make SV48 the default address space"

Sami Tolvanen (6):
      riscv: Implement syscall wrappers
      riscv: Add types to indirectly called assembly functions
      riscv: Add ftrace_stub_graph
      riscv: Add CFI error handling
      riscv/purgatory: Disable CFI
      riscv: Allow CONFIG_CFI_CLANG to be selected

Ye Xingchen (1):
      riscv: mm: use bitmap_zero() API

Yuan Tan (1):
      riscv: alternatives: fix a typo in comment

 Documentation/admin-guide/kernel-parameters.txt    |  22 +-
 Documentation/admin-guide/sysctl/kernel.rst        |  27 +-
 Documentation/riscv/vm-layout.rst                  |  22 +
 arch/riscv/Kconfig                                 |  24 +
 arch/riscv/Makefile                                |   3 -
 arch/riscv/include/asm/alternative-macros.h        |   2 +-
 arch/riscv/include/asm/cache.h                     |  14 +
 arch/riscv/include/asm/cacheflush.h                |   2 +
 arch/riscv/include/asm/cfi.h                       |  22 +
 arch/riscv/include/asm/elf.h                       |  13 +-
 arch/riscv/include/asm/hwcap.h                     |  17 +-
 arch/riscv/include/asm/insn.h                      |  10 +
 arch/riscv/include/asm/mmu.h                       |   4 +
 arch/riscv/include/asm/pgtable.h                   |  33 +-
 arch/riscv/include/asm/processor.h                 |  52 +-
 arch/riscv/include/asm/syscall.h                   |   5 +-
 arch/riscv/include/asm/syscall_wrapper.h           |  87 ++++
 arch/riscv/include/uapi/asm/ptrace.h               |   5 +
 arch/riscv/include/uapi/asm/sigcontext.h           |   2 +-
 arch/riscv/kernel/Makefile                         |   2 +
 arch/riscv/kernel/cfi.c                            |  77 +++
 arch/riscv/kernel/compat_syscall_table.c           |   8 +-
 arch/riscv/kernel/cpu.c                            | 181 +++----
 arch/riscv/kernel/cpufeature.c                     | 521 ++++++++++++++-------
 arch/riscv/kernel/head.S                           |   6 +-
 arch/riscv/kernel/mcount.S                         |   9 +-
 arch/riscv/kernel/probes/decode-insn.c             |  11 +-
 arch/riscv/kernel/probes/simulate-insn.c           | 105 +++++
 arch/riscv/kernel/probes/simulate-insn.h           |   5 +
 arch/riscv/kernel/setup.c                          |   6 +
 arch/riscv/kernel/suspend_entry.S                  |   5 +-
 arch/riscv/kernel/sys_riscv.c                      |   6 +
 arch/riscv/kernel/syscall_table.c                  |   8 +-
 arch/riscv/kernel/traps.c                          |   4 +-
 arch/riscv/mm/context.c                            |   2 +-
 arch/riscv/mm/dma-noncoherent.c                    |   8 +
 arch/riscv/mm/init.c                               |  93 +++-
 arch/riscv/mm/kasan_init.c                         |   8 +-
 arch/riscv/purgatory/Makefile                      |   4 +
 drivers/perf/riscv_pmu.c                           | 113 +++++
 drivers/perf/riscv_pmu_legacy.c                    |  28 +-
 drivers/perf/riscv_pmu_sbi.c                       | 196 +++++++-
 fs/Kconfig.binfmt                                  |   2 +-
 fs/binfmt_elf_fdpic.c                              |  38 +-
 include/asm-generic/preempt.h                      |  14 +-
 include/linux/elf-fdpic.h                          |  14 +-
 include/linux/perf/riscv_pmu.h                     |  12 +-
 include/linux/perf_event.h                         |   3 +-
 include/uapi/linux/elf-fdpic.h                     |  15 +
 lib/Kconfig.debug                                  |   7 +-
 tools/lib/perf/mmap.c                              |  66 +++
 tools/perf/tests/mmap-basic.c                      |   6 +-
 tools/testing/selftests/riscv/Makefile             |   2 +-
 tools/testing/selftests/riscv/mm/.gitignore        |   2 +
 tools/testing/selftests/riscv/mm/Makefile          |  15 +
 .../selftests/riscv/mm/testcases/mmap_bottomup.c   |  35 ++
 .../selftests/riscv/mm/testcases/mmap_default.c    |  35 ++
 .../selftests/riscv/mm/testcases/mmap_test.h       |  64 +++
 .../selftests/riscv/mm/testcases/run_mmap.sh       |  12 +
 59 files changed, 1707 insertions(+), 407 deletions(-)
 create mode 100644 arch/riscv/include/asm/cfi.h
 create mode 100644 arch/riscv/include/asm/syscall_wrapper.h
 create mode 100644 arch/riscv/kernel/cfi.c
 create mode 100644 tools/testing/selftests/riscv/mm/.gitignore
 create mode 100644 tools/testing/selftests/riscv/mm/Makefile
 create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap_bottomup.c
 create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap_default.c
 create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap_test.h
 create mode 100755 tools/testing/selftests/riscv/mm/testcases/run_mmap.sh
