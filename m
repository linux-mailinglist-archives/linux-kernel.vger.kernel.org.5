Return-Path: <linux-kernel+bounces-21284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFB7828D0D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D0F285D4D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D883D0AF;
	Tue,  9 Jan 2024 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2Z9qGnjy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D68E3C6A4;
	Tue,  9 Jan 2024 19:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB75C433C7;
	Tue,  9 Jan 2024 19:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1704827060;
	bh=Eap1vhUpzX5HcSA3JwR74MM1WrPdfly7YndILs0trNU=;
	h=Date:From:To:Cc:Subject:From;
	b=2Z9qGnjyNruUGCiAmdX4/wsthRaCXpHP6K7rG/jd05fbdFeussBk7n+zo51ubrRY0
	 lp58fuhYmxz7SyCLoblW9dI4OoK7bIBxTUD0w5trrH4vtacTq8ZYATt4OanlmAKvOo
	 g4Mz4HFL63MeBPhpDYxN3P2YszAZWFUSqIO36Kts=
Date: Tue, 9 Jan 2024 11:04:20 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] non-MM updates for 6.8-rc1
Message-Id: <20240109110420.dcdefe80d76257d9ff645a32@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Linus, please merge this cycle's batch of non-MM patches, thanks.


There is one known forthcoming build issue which is not accompanied by
a merge issue.  This, and its linux-next resolution is:

next-next tree, drivers/net/phy/aquantia/aquantia_firmware.c:
	https://lkml.kernel.org/r/20231221130946.7ed9a805@canb.auug.org.au



Forthcoming merge issues and their linux-next resolutions are:

asm-generic tree, arch/mips/include/asm/traps.h
	https://lkml.kernel.org/r/20231205090546.7dffe3aa@canb.auug.org.au

iommu tree, arch/Kconfig
	https://lkml.kernel.org/r/20231213124302.2a6281af@canb.auug.org.au

mips tree, arch/mips/kernel/traps.c
	https://lkml.kernel.org/r/20240102090812.4243eb88@canb.auug.org.au




The following changes since commit 4376807bf2d5371c3e00080c972be568c3f8a7d1:

  mm/mglru: reclaim offlined memcgs harder (2023-12-12 17:20:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2024-01-09-10-33

for you to fetch changes up to 6dff315972640bfe542e2d044933751afd8e6c4a:

  crash_core: fix and simplify the logic of crash_exclude_mem_range() (2024-01-05 10:45:25 -0800)

----------------------------------------------------------------
Quite a lot of kexec work this time around.  Many singleton patches in
many places.  The notable patch series are:

- nilfs2 folio conversion from Matthew Wilcox in "nilfs2: Folio
  conversions for file paths".

- Additional nilfs2 folio conversion from Ryusuke Konishi in "nilfs2:
  Folio conversions for directory paths".

- IA64 remnant removal in Heiko Carstens's "Remove unused code after
  IA-64 removal".

- Arnd Bergmann has enabled the -Wmissing-prototypes warning everywhere
  in "Treewide: enable -Wmissing-prototypes".  This had some followup
  fixes:

  - Nathan Chancellor has cleaned up the hexagon build in the series
    "hexagon: Fix up instances of -Wmissing-prototypes".

  - Nathan also addressed some s390 warnings in "s390: A couple of
    fixes for -Wmissing-prototypes".

  - Arnd Bergmann addresses the same warnings for MIPS in his series
    "mips: address -Wmissing-prototypes warnings".

- Baoquan He has made kexec_file operate in a top-down-fitting manner
  similar to kexec_load in the series "kexec_file: Load kernel at top of
  system RAM if required"

- Baoquan He has also added the self-explanatory "kexec_file: print out
  debugging message if required".

- Some checkstack maintenance work from Tiezhu Yang in the series
  "Modify some code about checkstack".

- Douglas Anderson has disentangled the watchdog code's logging when
  multiple reports are occurring simultaneously.  The series is "watchdog:
  Better handling of concurrent lockups".

- Yuntao Wang has contributed some maintenance work on the crash code in
  "crash: Some cleanups and fixes".

----------------------------------------------------------------
Ahelenia Ziemiańska (1):
      kernel: relay: remove relay_file_splice_read dead code, doesn't work

Andrew Morton (1):
      merge mm-hotfixes-stable into mm-nonmm-stable to pick up depended-upon changes

Ariel Miculas (1):
      docs: filesystems: document the squashfs specific mount options

Arnd Bergmann (27):
      arch: turn off -Werror for architectures with known warnings
      mips: decompress: fix add missing prototypes
      mips: add asm/syscalls.h header
      mips: add missing declarations for trap handlers
      mips: rs870e: stop exporting local functions
      mips: signal: move sigcontext declarations to header
      mips: mark local function static if possible
      mips: move build_tlb_refill_handler() prototype
      mips: move jump_label_apply_nops() declaration to header
      mips: unhide uasm_in_compat_space_p() declaration
      mips: fix setup_zero_pages() prototype
      mips: fix tlb_init() prototype
      mips: move cache declarations into header
      mips: add missing declarations
      mips: spram: fix missing prototype warning for spram_config
      mips: mt: include asm/mips_mt.h
      mips: suspend: include linux/suspend.h as needed
      mips: hide conditionally unused functions
      mips: smp: fix setup_profiling_timer() prototype
      mips: kexec: include linux/reboot.h
      ida: make 'ida_dump' static
      jffs2: mark __jffs2_dbg_superblock_counts() static
      sched: fair: move unused stub functions to header
      x86: sta2x11: include header for sta2x11_get_instance() prototype
      usb: fsl-mph-dr-of: mark fsl_usb2_mpc5121_init() static
      mips: fix r3k_cache_init build regression
      Makefile.extrawarn: turn on missing-prototypes globally

Bagas Sanjaya (1):
      MAINTAINERS: remove Ohad Ben-Cohen from hwspinlock subsystem

Baoquan He (10):
      resource: add walk_system_ram_res_rev()
      kexec_file: load kernel at top of system RAM if required
      kexec_file: add kexec_file flag to control debug printing
      kexec_file: print out debugging message if required
      kexec_file, x86: print out debugging message if required
      kexec_file, arm64: print out debugging message if required
      kexec_file, riscv: print out debugging message if required
      kexec_file, power: print out debugging message if required
      kexec_file, parisc: print out debugging message if required
      riscv, kexec: fix the ifdeffery for AFLAGS_kexec_relocate.o

Bjorn Andersson (1):
      scripts/decode_stacktrace.sh: strip unexpected CR from lines

Colin Ian King (1):
      scripts/spelling.txt: add more spellings to spelling.txt

Dongmin Lee (1):
      kernel/reboot: explicitly notify if halt occurred instead of power off

Douglas Anderson (4):
      watchdog/hardlockup: adopt softlockup logic avoiding double-dumps
      watchdog/softlockup: use printk_cpu_sync_get_irqsave() to serialize reporting
      watchdog/hardlockup: use printk_cpu_sync_get_irqsave() to serialize reporting
      watchdog: if panicking and we dumped everything, don't re-enable dumping

Heiko Carstens (5):
      arch: remove ARCH_THREAD_STACK_ALLOCATOR
      arch: remove ARCH_TASK_STRUCT_ALLOCATOR
      arch: remove ARCH_TASK_STRUCT_ON_STACK
      checkstack: sort output by size and function name
      checkstack: allow to pass MINSTACKSIZE parameter

Kevin Hao (2):
      fork: remove redundant TASK_UNINTERRUPTIBLE
      nilfs2: add missing set_freezable() for freezable kthread

Kuan-Ying Lee (3):
      scripts/gdb/stackdepot: rename pool_index to pools_num
      scripts/gdb: remove exception handling and refine print format
      scripts/checkstack.pl: fix no space expression between sp and offset

Li Zhe (1):
      softlockup: serialized softlockup's log

Mark Rutland (1):
      kcov: remove stale RANDOMIZE_BASE text

Mathis Marion (1):
      lib: crc_ccitt_false() is identical to crc_itu_t()

Matthew Wilcox (Oracle) (35):
      nilfs2: add nilfs_end_folio_io()
      nilfs2: convert nilfs_abort_logs to use folios
      nilfs2: convert nilfs_segctor_complete_write to use folios
      nilfs2: convert nilfs_forget_buffer to use a folio
      nilfs2: convert to nilfs_folio_buffers_clean()
      nilfs2: convert nilfs_writepage() to use a folio
      nilfs2: convert nilfs_mdt_write_page() to use a folio
      nilfs2: convert to nilfs_clear_folio_dirty()
      nilfs2: convert to __nilfs_clear_folio_dirty()
      nilfs2: convert nilfs_segctor_prepare_write to use folios
      nilfs2: convert nilfs_page_mkwrite() to use a folio
      nilfs2: convert nilfs_mdt_create_block to use a folio
      nilfs2: convert nilfs_mdt_submit_block to use a folio
      nilfs2: convert nilfs_gccache_submit_read_data to use a folio
      nilfs2: convert nilfs_btnode_create_block to use a folio
      nilfs2: convert nilfs_btnode_submit_block to use a folio
      nilfs2: convert nilfs_btnode_delete to use a folio
      nilfs2: convert nilfs_btnode_prepare_change_key to use a folio
      nilfs2: convert nilfs_btnode_commit_change_key to use a folio
      nilfs2: convert nilfs_btnode_abort_change_key to use a folio
      nilfs2: remove page_address() from nilfs_set_link
      nilfs2: remove page_address() from nilfs_add_link
      nilfs2: remove page_address() from nilfs_delete_entry
      nilfs2: return the mapped address from nilfs_get_page()
      nilfs2: pass the mapped address to nilfs_check_page()
      nilfs2: switch to kmap_local for directory handling
      nilfs2: add nilfs_get_folio()
      nilfs2: convert nilfs_readdir to use a folio
      nilfs2: convert nilfs_find_entry to use a folio
      nilfs2: convert nilfs_rename() to use folios
      nilfs2: convert nilfs_add_link() to use a folio
      nilfs2: convert nilfs_empty_dir() to use a folio
      nilfs2: convert nilfs_make_empty() to use a folio
      nilfs2: convert nilfs_prepare_chunk() and nilfs_commit_chunk() to folios
      nilfs2: convert nilfs_page_bug() to nilfs_folio_bug()

Nathan Chancellor (21):
      hexagon: uaccess: remove clear_user_hexagon()
      hexagon: mm: mark paging_init() as static
      hexagon: mm: include asm/setup.h for setup_arch_memory()'s prototype
      hexagon: smp: mark handle_ipi() and start_secondary() as static
      hexagon: vm_fault: mark do_page_fault() as static
      hexagon: vm_fault: include asm/vm_fault.h for prototypes
      hexagon: vm_tlb: include asm/tlbflush.h for prototypes
      hexagon: time: include asm/time.h for prototypes
      hexagon: time: mark time_init_deferred() as static
      hexagon: time: include asm/delay.h for prototypes
      hexagon: signal: switch to SYSCALL_DEFINE0 for sys_rt_sigreturn()
      hexagon: reset: include linux/reboot.h for prototypes
      hexagon: process: include linux/cpu.h for arch_cpu_idle() prototype
      hexagon: process: add internal prototype for do_work_pending()
      hexagon: vdso: include asm/elf.h for arch_setup_additional_pages() prototype
      hexagon: vm_events: remove unused dummy_handler()
      hexagon: irq: add prototype for arch_do_IRQ()
      hexagon: traps: remove sys_syscall()
      hexagon: traps: add internal prototypes for functions only called from asm
      s390/dasd: remove dasd_stats_generic_show()
      s390/traps: only define is_valid_bugaddr() under CONFIG_GENERIC_BUG

Oleg Nesterov (3):
      introduce for_other_threads(p, t)
      kernel/signal.c: simplify force_sig_info_to_task(), kill recalc_sigpending_and_wake()
      __ptrace_unlink: kill the obsolete "FIXME" code

Philipp Stanner (1):
      fs/nilfs2: use standard array-copy-function

Phillip Lougher (1):
      Squashfs: fix variable overflow triggered by sysbot

Randy Dunlap (8):
      rapidio/tsi721: fix kernel-doc warnings
      freevxfs: bmap: fix kernel-doc warnings
      freevxfs: immed: fix kernel-doc param name
      freevxfs: lookup: fix function params kernel-doc
      init/Kconfig: move more items into the EXPERT menu
      usr/Kconfig: fix typos of "its"
      stacktrace: fix kernel-doc typo
      nilfs2: cpfile: fix some kernel-doc warnings

Ryusuke Konishi (3):
      nilfs2: move page release outside of nilfs_delete_entry and nilfs_set_link
      nilfs2: eliminate staggered calls to kunmap in nilfs_rename
      nilfs2: switch WARN_ONs to warning output in nilfs_sufile_do_free()

Sergey Senozhatsky (1):
      checkpatch: do not require an empty line before error injection

Stephen Rothwell (1):
      powerpc: pmd_move_must_withdraw() is only needed for CONFIG_TRANSPARENT_HUGEPAGE

Tanzir Hasan (1):
      lib/trace_readwrite.c:: replace asm-generic/io with linux/io

Tiezhu Yang (5):
      scripts/checkstack.pl: remove ia64 support
      scripts/checkstack.pl: add min_stack to the usage comment
      scripts/checkstack.pl: match all stack sizes for some archs
      scripts/checkstack.pl: change min_stack to 512 by default
      docs: submit-checklist: remove all of "make namespacecheck"

Uros Bizjak (1):
      kexec: use atomic_try_cmpxchg in crash_kexec

Uwe Kleine-König (1):
      lib: add note about process exit message for DEBUG_STACK_USAGE

Wang Jinchao (1):
      crash_core: remove duplicated including of kexec.h

Youling Tang (3):
      scripts/decodecode: add support for LoongArch
      checkstack: add loongarch support for scripts/checkstack.pl
      kdump: remove redundant DEFAULT_CRASH_KERNEL_LOW_SIZE

Yuntao Wang (11):
      kexec: use ALIGN macro instead of open-coding it
      x86/kexec: simplify the logic of mem_region_callback()
      kexec: modify the meaning of the end parameter in kimage_is_destination_range()
      kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down()
      x86/kexec: use pr_err() instead of kexec_dprintk() when an error occurs
      x86/kexec: fix incorrect argument passed to kexec_dprintk()
      x86/kexec: fix incorrect end address passed to kernel_ident_mapping_init()
      kexec_core: fix the assignment to kimage->control_page
      x86/crash: remove the unused image parameter from prepare_elf_headers()
      x86/crash: use SZ_1M macro instead of hardcoded value
      crash_core: fix and simplify the logic of crash_exclude_mem_range()

 CREDITS                                            |   3 +
 .../driver-api/surface_aggregator/ssh.rst          |   2 +-
 Documentation/filesystems/squashfs.rst             |  60 +++++
 Documentation/translations/ja_JP/SubmitChecklist   |   4 +-
 .../zh_CN/process/submit-checklist.rst             |   3 +-
 .../zh_TW/process/submit-checklist.rst             |   3 +-
 MAINTAINERS                                        |   4 +-
 Makefile                                           |   6 +-
 arch/Kconfig                                       |  13 --
 arch/alpha/lib/Makefile                            |   1 -
 arch/alpha/mm/Makefile                             |   2 -
 arch/arm64/kernel/kexec_image.c                    |   6 +-
 arch/arm64/kernel/machine_kexec.c                  |  26 +--
 arch/arm64/kernel/machine_kexec_file.c             |  12 +-
 arch/hexagon/include/asm/irq.h                     |   3 +
 arch/hexagon/kernel/process.c                      |   2 +
 arch/hexagon/kernel/reset.c                        |   1 +
 arch/hexagon/kernel/signal.c                       |   2 +-
 arch/hexagon/kernel/smp.c                          |   4 +-
 arch/hexagon/kernel/time.c                         |   4 +-
 arch/hexagon/kernel/traps.c                        |  11 +-
 arch/hexagon/kernel/vdso.c                         |   1 +
 arch/hexagon/kernel/vm_events.c                    |   7 -
 arch/hexagon/mm/init.c                             |   3 +-
 arch/hexagon/mm/uaccess.c                          |   8 -
 arch/hexagon/mm/vm_fault.c                         |   3 +-
 arch/hexagon/mm/vm_tlb.c                           |   1 +
 arch/mips/Kbuild                                   |   6 -
 arch/mips/boot/compressed/dbg.c                    |   2 +
 arch/mips/boot/compressed/decompress.c             |  16 +-
 arch/mips/boot/compressed/decompress.h             |  24 ++
 arch/mips/boot/compressed/string.c                 |   1 +
 arch/mips/include/asm/cache.h                      |   6 +
 arch/mips/include/asm/jump_label.h                 |   3 +
 arch/mips/include/asm/mach-loongson64/mmzone.h     |   1 -
 arch/mips/include/asm/mmzone.h                     |   2 +
 arch/mips/include/asm/processor.h                  |   2 +
 arch/mips/include/asm/r4kcache.h                   |   4 +
 arch/mips/include/asm/setup.h                      |   1 +
 arch/mips/include/asm/signal.h                     |   1 +
 arch/mips/include/asm/smp.h                        |   2 +
 arch/mips/include/asm/spram.h                      |   2 +-
 arch/mips/include/asm/syscalls.h                   |  33 +++
 arch/mips/include/asm/tlbex.h                      |   1 +
 arch/mips/include/asm/traps.h                      |  24 ++
 arch/mips/include/asm/uasm.h                       |   2 -
 arch/mips/kernel/cpu-probe.c                       |   1 -
 arch/mips/kernel/cpu-r3k-probe.c                   |   1 -
 arch/mips/kernel/linux32.c                         |   1 +
 arch/mips/kernel/machine_kexec.c                   |   1 +
 arch/mips/kernel/mips-cm.c                         |   2 +-
 arch/mips/kernel/mips-mt-fpaff.c                   |   1 +
 arch/mips/kernel/mips-mt.c                         |   1 +
 arch/mips/kernel/module.c                          |   3 +-
 arch/mips/kernel/r4k-bugs64.c                      |   1 +
 arch/mips/kernel/signal-common.h                   |   3 +
 arch/mips/kernel/signal.c                          |   1 +
 arch/mips/kernel/signal32.c                        |   1 +
 arch/mips/kernel/signal_n32.c                      |   4 +-
 arch/mips/kernel/signal_o32.c                      |   1 +
 arch/mips/kernel/smp.c                             |   3 +
 arch/mips/kernel/spram.c                           |   1 +
 arch/mips/kernel/syscall.c                         |   1 +
 arch/mips/kernel/traps.c                           |   2 -
 arch/mips/kernel/unaligned.c                       |   1 +
 arch/mips/mm/c-r4k.c                               |   6 +-
 arch/mips/mm/cache.c                               |  15 +-
 arch/mips/mm/fault.c                               |   1 +
 arch/mips/mm/init.c                                |   1 +
 arch/mips/mm/pgtable-64.c                          |   2 +
 arch/mips/mm/tlb-r3k.c                             |   4 +-
 arch/mips/mm/tlb-r4k.c                             |   6 +-
 arch/mips/power/cpu.c                              |   1 +
 arch/mips/power/hibernate.c                        |   1 +
 arch/parisc/kernel/kexec_file.c                    |   8 +-
 arch/powerpc/kexec/core_64.c                       |   3 +-
 arch/powerpc/kexec/elf_64.c                        |   8 +-
 arch/powerpc/kexec/file_load_64.c                  |  18 +-
 arch/powerpc/mm/book3s64/pgtable.c                 |   2 +
 arch/riscv/kernel/Makefile                         |   2 +-
 arch/riscv/kernel/elf_kexec.c                      |  11 +-
 arch/riscv/kernel/machine_kexec.c                  |  26 ---
 arch/s390/kernel/traps.c                           |   2 +
 arch/sparc/kernel/Makefile                         |   1 -
 arch/sparc/lib/Makefile                            |   1 -
 arch/sparc/mm/Makefile                             |   1 -
 arch/sparc/prom/Makefile                           |   1 -
 arch/x86/kernel/crash.c                            |  16 +-
 arch/x86/kernel/kexec-bzimage64.c                  |  23 +-
 arch/x86/kernel/machine_kexec_64.c                 |   7 +-
 arch/x86/pci/sta2x11-fixup.c                       |   1 +
 drivers/mfd/Kconfig                                |   2 +-
 drivers/mfd/rave-sp.c                              |   4 +-
 drivers/platform/mips/rs780e-acpi.c                |  12 +-
 drivers/platform/surface/aggregator/Kconfig        |   2 +-
 drivers/rapidio/devices/tsi721.c                   |  67 ++++--
 drivers/rapidio/devices/tsi721_dma.c               |   4 +-
 drivers/s390/block/dasd.c                          |   6 -
 drivers/usb/host/fsl-mph-dr-of.c                   |   2 +-
 fs/exec.c                                          |   3 +-
 fs/freevxfs/vxfs_bmap.c                            |   8 +-
 fs/freevxfs/vxfs_immed.c                           |   2 +-
 fs/freevxfs/vxfs_lookup.c                          |   3 +-
 fs/jffs2/debug.c                                   |   2 +-
 fs/nilfs2/btnode.c                                 |  62 +++---
 fs/nilfs2/cpfile.c                                 |  28 ++-
 fs/nilfs2/dir.c                                    | 244 ++++++++++-----------
 fs/nilfs2/file.c                                   |  28 +--
 fs/nilfs2/gcinode.c                                |   4 +-
 fs/nilfs2/inode.c                                  |  11 +-
 fs/nilfs2/ioctl.c                                  |  10 +-
 fs/nilfs2/mdt.c                                    |  23 +-
 fs/nilfs2/namei.c                                  |  38 ++--
 fs/nilfs2/nilfs.h                                  |  20 +-
 fs/nilfs2/page.c                                   |  93 ++++----
 fs/nilfs2/page.h                                   |  12 +-
 fs/nilfs2/segment.c                                | 158 ++++++-------
 fs/nilfs2/sufile.c                                 |   9 +-
 fs/squashfs/file.c                                 |   3 +-
 fs/squashfs/file_direct.c                          |   6 +-
 include/linux/crash_core.h                         |   6 -
 include/linux/crc-ccitt.h                          |   7 -
 include/linux/init_task.h                          |   7 -
 include/linux/ioport.h                             |   3 +
 include/linux/kexec.h                              |   9 +-
 include/linux/sched.h                              |   2 -
 include/linux/sched/signal.h                       |   4 +-
 include/linux/surface_aggregator/serial_hub.h      |   4 +-
 include/uapi/linux/kexec.h                         |   1 +
 init/Kconfig                                       | 102 +++++----
 init/init_task.c                                   |  10 +-
 kernel/crash_core.c                                |  89 +++-----
 kernel/fork.c                                      |  28 +--
 kernel/kexec_core.c                                |  21 +-
 kernel/kexec_file.c                                |  20 +-
 kernel/ptrace.c                                    |  13 +-
 kernel/reboot.c                                    |  17 +-
 kernel/relay.c                                     | 162 --------------
 kernel/resource.c                                  |  57 +++++
 kernel/sched/fair.c                                |  13 --
 kernel/sched/sched.h                               |  11 +
 kernel/signal.c                                    |  28 +--
 kernel/stacktrace.c                                |   2 +-
 kernel/watchdog.c                                  |  40 +++-
 lib/Kconfig.debug                                  |   6 +-
 lib/crc-ccitt.c                                    |  55 -----
 lib/test_ida.c                                     |   2 +-
 lib/trace_readwrite.c                              |   2 +-
 mm/highmem.c                                       |   2 -
 scripts/Makefile.extrawarn                         |   4 +-
 scripts/checkpatch.pl                              |   2 +-
 scripts/checkstack.pl                              |  45 ++--
 scripts/decode_stacktrace.sh                       |   3 +
 scripts/decodecode                                 |   5 +
 scripts/gdb/linux/page_owner.py                    |  58 +++--
 scripts/gdb/linux/slab.py                          |   3 +-
 scripts/gdb/linux/stackdepot.py                    |   6 +-
 scripts/spelling.txt                               |  14 ++
 security/integrity/ima/ima_kexec.c                 |   4 +-
 usr/Kconfig                                        |   6 +-
 160 files changed, 1110 insertions(+), 1155 deletions(-)
 create mode 100644 arch/mips/boot/compressed/decompress.h
 create mode 100644 arch/mips/include/asm/syscalls.h


