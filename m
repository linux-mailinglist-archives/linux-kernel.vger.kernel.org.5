Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8517DFC05
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 22:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376675AbjKBVdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 17:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKBVdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 17:33:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A096187;
        Thu,  2 Nov 2023 14:33:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79898C433C8;
        Thu,  2 Nov 2023 21:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1698960822;
        bh=E/p6mfZhYY7Q4dSD0WcXH+z2cmhagtpoCT7yLOwGskk=;
        h=Date:From:To:Cc:Subject:From;
        b=fMs4l4+Sn18xJXu3E4N7fTtgxpiG2ANbs7Oe7opqWyZQ2AtFbE9Ca2xuqHNDx+b8k
         quq2BM3xsT3ZKVd9/54Sb60UP0R2bbu9uOGKLc+9JLzygX6vaeypWNxaG90RD7b4z0
         ejbLw2IVc4p3W7M90W33XYZfOoPLaUvulMGc2RXw=
Date:   Thu, 2 Nov 2023 14:33:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Non MM updates for 6.8-rc1
Message-Id: <20231102143341.9e83402cf087ba82e2b4760c@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please merge this cycle's batch of non-MM updates.

I'm aware of no merge-time or runtime issues this time around.

Thanks.


The following changes since commit 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa:

  Linux 6.6-rc4 (2023-10-01 14:15:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stabl=
e-2023-11-02-14-08

for you to fetch changes up to 6620999f0d41e4fd6f047727936a964c3399d249:

  scripts/gdb/vmalloc: disable on no-MMU (2023-11-01 12:46:59 -0700)

----------------------------------------------------------------
As usual, lots of singleton and doubleton patches all over the tree and
there's little I can say which isn't in the individual changelogs.

The lengthier patch series are

- "kdump: use generic functions to simplify crashkernel reservation in
  arch", from Baoquan He.  This is mainly cleanups and consolidation of
  the "crashkernel=3D" kernel parameter handling.

- After much discussion, David Laight's "minmax: Relax type checks in
  min() and max()" is here.  Hopefully reduces some typecasting and the
  use of min_t() and max_t().

- A group of patches from Oleg Nesterov which clean up and slightly fix
  our handling of reads from /proc/PID/task/...  and which remove
  task_struct.therad_group.

----------------------------------------------------------------
Alexey Dobriyan (5):
      extract and use FILE_LINE macro
      proc: use initializer for clearing some buffers
      proc: save LOC by using while loop
      treewide: mark stuff as __ro_after_init
      proc: fix proc-empty-vm test with vsyscall

Andreas Gruenbacher (1):
      kthread: add kthread_stop_put

Andy Shevchenko (2):
      minmax: deduplicate __unconst_integer_typeof()
      minmax: fix header inclusions

Artem Chernyshev (1):
      fs: ocfs2: check status values

Azeem Shaikh (1):
      fs: ocfs2: replace strlcpy with sysfs_emit

Bagas Sanjaya (2):
      .mailmap: map Benjamin Poirier's address
      .mailmap: add address mapping for Tomeu Vizoso

Baoquan He (9):
      crash_core.c: remove unnecessary parameter of function
      crash_core: change the prototype of function parse_crashkernel()
      crash_core: change parse_crashkernel() to support crashkernel=3D,high=
|low parsing
      crash_core: add generic function to do reservation
      crash_core: move crashk_*res definition into crash_core.c
      x86: kdump: use generic interface to simplify crashkernel reservation=
 code
      arm64: kdump: use generic interface to simplify crashkernel reservati=
on
      riscv: kdump: use generic interface to simplify crashkernel reservati=
on
      crash_core.c: remove unneeded functions

Ben Wolsieffer (1):
      scripts/gdb/vmalloc: disable on no-MMU

Christophe JAILLET (1):
      kstrtox: remove strtobool()

Claudiu Beznea (1):
      mailmap: update email address for Claudiu Beznea

Cl=E9ment L=E9ger (1):
      scripts/gdb: fix usage of MOD_TEXT not defined when CONFIG_MODULES=3Dn

Costa Shulyupin (1):
      docs: fix link s390/zfcpdump.rst

David Laight (6):
      minmax: add umin(a, b) and umax(a, b)
      minmax: allow min()/max()/clamp() if the arguments have the same sign=
edness.
      minmax: fix indentation of __cmp_once() and __clamp_once()
      minmax: allow comparisons of 'int' against 'unsigned char/short'
      minmax: relax check to allow comparison between unsigned arguments an=
d signed constants
      compiler.h: move __is_constexpr() to compiler.h

Deepak Gupta (1):
      scripts/gdb: add lx_current support for riscv

Hu Haowen (1):
      scripts/show_delta: add __main__ judgement before main code

Itaru Kitayama (1):
      tools/testing/selftests/mm/run_vmtests.sh: lower the ptrace permissio=
ns

Jia Rui (1):
      ocfs2: replace BUG_ON() at ocfs2_num_free_extents() with ocfs2_error()

Joe Perches (1):
      get_maintainer: add --keywords-in-file option

Kees Cook (2):
      ocfs2: annotate struct ocfs2_replay_map with __counted_by
      gcov: annotate struct gcov_iterator with __counted_by

Kunwu Chan (1):
      ocfs2: fix a spelling typo in comment

Li kunyu (1):
      kernel/signal: remove unnecessary NULL values from ucounts

Nick Desaulniers (1):
      compiler.h: unify __UNIQUE_ID

Oleg Nesterov (12):
      introduce __next_thread(), fix next_tid() vs exec() race
      change next_thread() to use __next_thread() ?: group_leader
      change thread_group_empty() to use task_struct->thread_node
      kill task_struct->thread_group
      __kill_pgrp_info: simplify the calculation of return value
      fs/proc: do_task_stat: use __for_each_thread()
      signal: complete_signal: use __for_each_thread()
      getrusage: add the "signal_struct *sig" local variable
      getrusage: use __for_each_thread()
      taskstats: fill_stats_for_tgid: use for_each_thread()
      do_io_accounting: use __for_each_thread()
      do_io_accounting: use sig->stats_lock

Rong Tao (1):
      pid: pid_ns_ctl_handler: remove useless comment

Swarup Laxman Kotiaklapudi (2):
      proc: test /proc/${pid}/statm
      proc: test ProtectionKey in proc-empty-vm test

Uros Bizjak (1):
      panic: use atomic_try_cmpxchg in panic() and nmi_panic()

Xingui Yang (3):
      seq_file: add helper macro to define attribute for rw file
      scsi: hisi_sas: use DEFINE_SHOW_STORE_ATTRIBUTE() helper for debugfs
      scsi: qla2xxx: use DEFINE_SHOW_STORE_ATTRIBUTE() helper for debugfs

Yang Li (1):
      fs/proc/base.c: remove unneeded semicolon

Yuanheng Zhang (2):
      ocfs2: correct range->len in ocfs2_trim_fs()
      ocfs2: fix a typo in a comment

 .mailmap                                     |   3 +
 arch/arm/kernel/setup.c                      |   3 +-
 arch/arm64/Kconfig                           |   3 +
 arch/arm64/include/asm/crash_core.h          |  10 ++
 arch/arm64/mm/init.c                         | 140 ++------------------
 arch/ia64/kernel/setup.c                     |   2 +-
 arch/loongarch/kernel/setup.c                |   4 +-
 arch/mips/kernel/setup.c                     |   3 +-
 arch/powerpc/kernel/fadump.c                 |   2 +-
 arch/powerpc/kexec/core.c                    |   2 +-
 arch/powerpc/mm/nohash/kaslr_booke.c         |   2 +-
 arch/riscv/Kconfig                           |   3 +
 arch/riscv/include/asm/crash_core.h          |  11 ++
 arch/riscv/include/asm/processor.h           |   2 +
 arch/riscv/kernel/setup.c                    |  13 --
 arch/riscv/mm/init.c                         | 141 ++------------------
 arch/s390/kernel/setup.c                     |   4 +-
 arch/sh/kernel/machine_kexec.c               |   2 +-
 arch/x86/Kconfig                             |   3 +
 arch/x86/include/asm/crash_core.h            |  42 ++++++
 arch/x86/kernel/setup.c                      | 147 ++-------------------
 block/bdev.c                                 |   6 +-
 drivers/accel/ivpu/ivpu_job.c                |   3 +-
 drivers/dma-buf/st-dma-fence-chain.c         |  12 +-
 drivers/dma-buf/st-dma-fence.c               |   4 +-
 drivers/gpu/drm/i915/gt/selftest_migrate.c   |   4 +-
 drivers/net/xen-netback/interface.c          |   3 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c       | 137 ++------------------
 drivers/scsi/qla2xxx/qla_dfs.c               |  59 +--------
 drivers/usb/usbip/usbip_common.h             |   6 -
 fs/anon_inodes.c                             |   4 +-
 fs/buffer.c                                  |   4 +-
 fs/char_dev.c                                |   2 +-
 fs/dcache.c                                  |   8 +-
 fs/direct-io.c                               |   2 +-
 fs/eventpoll.c                               |   6 +-
 fs/fcntl.c                                   |   2 +-
 fs/file_table.c                              |   2 +-
 fs/gfs2/ops_fstype.c                         |   9 +-
 fs/inode.c                                   |   8 +-
 fs/kernfs/mount.c                            |   5 +-
 fs/locks.c                                   |   4 +-
 fs/namespace.c                               |  16 +--
 fs/notify/dnotify/dnotify.c                  |   6 +-
 fs/notify/fanotify/fanotify_user.c           |   8 +-
 fs/notify/inotify/inotify_user.c             |   2 +-
 fs/ocfs2/alloc.c                             |  11 +-
 fs/ocfs2/buffer_head_io.c                    |   4 +-
 fs/ocfs2/dlmfs/dlmfs.c                       |   3 +-
 fs/ocfs2/journal.c                           |   2 +-
 fs/ocfs2/namei.c                             |   8 ++
 fs/ocfs2/quota_local.c                       |   4 +
 fs/pipe.c                                    |   2 +-
 fs/proc/array.c                              |   7 +-
 fs/proc/base.c                               |  52 ++++----
 fs/proc/inode.c                              |  11 +-
 fs/proc/task_mmu.c                           |  11 +-
 fs/userfaultfd.c                             |   2 +-
 include/linux/compiler-clang.h               |   5 -
 include/linux/compiler-gcc.h                 |   2 -
 include/linux/compiler.h                     |  13 +-
 include/linux/const.h                        |   8 --
 include/linux/crash_core.h                   |  49 ++++++-
 include/linux/fortify-string.h               |   2 +-
 include/linux/kexec.h                        |   4 -
 include/linux/kstrtox.h                      |   5 -
 include/linux/kthread.h                      |   1 +
 include/linux/minmax.h                       | 129 ++++++++++---------
 include/linux/sched.h                        |   1 -
 include/linux/sched/signal.h                 |  19 ++-
 include/linux/seq_file.h                     |  15 +++
 include/linux/stringify.h                    |   2 +
 include/linux/timer.h                        |   3 +-
 init/init_task.c                             |   1 -
 kernel/Kconfig.kexec                         |   2 +-
 kernel/audit_tree.c                          |   4 +-
 kernel/crash_core.c                          | 184 +++++++++++++++++++++++=
+---
 kernel/exit.c                                |   1 -
 kernel/fork.c                                |   3 -
 kernel/gcov/fs.c                             |   2 +-
 kernel/irq/manage.c                          |  15 +--
 kernel/kexec_core.c                          |  17 ---
 kernel/kthread.c                             |  18 +++
 kernel/panic.c                               |  22 ++--
 kernel/pid_namespace.c                       |   6 -
 kernel/sched/core.c                          |   2 +-
 kernel/signal.c                              |  24 ++--
 kernel/smpboot.c                             |   3 +-
 kernel/sys.c                                 |  41 +++---
 kernel/taskstats.c                           |   5 +-
 kernel/user_namespace.c                      |   2 +-
 kernel/workqueue.c                           |  16 +--
 lib/debugobjects.c                           |   2 +-
 mm/damon/core.c                              |   3 +-
 mm/khugepaged.c                              |   2 +-
 mm/shmem.c                                   |   8 +-
 net/core/pktgen.c                            |   3 +-
 scripts/gdb/linux/constants.py.in            |  10 +-
 scripts/gdb/linux/cpus.py                    |  15 +++
 scripts/gdb/linux/vmalloc.py                 |   8 +-
 scripts/get_maintainer.pl                    |  38 +++---
 scripts/show_delta                           |   3 +-
 security/integrity/iint.c                    |   2 +-
 sound/pci/asihpi/hpidebug.h                  |   9 +-
 tools/include/linux/compiler.h               |   8 ++
 tools/include/linux/const.h                  |   8 --
 tools/testing/selftests/mm/run_vmtests.sh    |   1 +
 tools/testing/selftests/proc/proc-empty-vm.c | 182 ++++++++++++++++++++++-=
---
 108 files changed, 895 insertions(+), 1014 deletions(-)
 create mode 100644 arch/arm64/include/asm/crash_core.h
 create mode 100644 arch/riscv/include/asm/crash_core.h
 create mode 100644 arch/x86/include/asm/crash_core.h

