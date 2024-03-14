Return-Path: <linux-kernel+bounces-103586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 341B287C173
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7CDE1F22258
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941A774297;
	Thu, 14 Mar 2024 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XvAjdVsd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369141E480;
	Thu, 14 Mar 2024 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434600; cv=none; b=hmpjM+2006CWprsIFQH8gvFAWnEEhbn0w/dD7rtobgdzPI9kse6FVXojsmkPYBv38XENV/aqpF+p32XayixjKcmsdwmZkhDiYNrtKUtsl9KktSHfRxaGz4XjPbogQvWB+P8N9B3rxb52V7t5es2/I/kwUsqDFjBecF7nWs5kzgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434600; c=relaxed/simple;
	bh=gHWnvzVFXOXG5b3CGJ2cV162pB5RwA/iaRNU6uWunk0=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=Edy8S/TqmfDnMIoCxbz/XzHUvicMpr+9EDAdJD3Mp1DPMRgJwxc8kn3JmP6TmGUK6o5ehkg+8tVtBs11llodAOxid0yW/Um9k55VyDEac4r4CMtkkR7f49minB2iVvJM6mpToOa4cmfmyiPwjd08HuL2akMYD74mHSEQBeP58Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XvAjdVsd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A430EC433F1;
	Thu, 14 Mar 2024 16:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1710434599;
	bh=gHWnvzVFXOXG5b3CGJ2cV162pB5RwA/iaRNU6uWunk0=;
	h=Date:From:To:Cc:Subject:From;
	b=XvAjdVsd/u+2NWlVSO+V9SHK5RRfrZUrQNszJ64NbCEr1GwgooTMp1CUTkrbVDt1A
	 5oXThTnnuVfYz0sGuPK0LauEltzllenSC26Gah0i9fT65ExI8tIoy9u860Uk94jPdU
	 85fn9vmlaDtgdAWHaPruD9uaFG21ZTI/qApR2Vsw=
Date: Thu, 14 Mar 2024 09:43:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] non-MM updates for 6.9-rc1
Message-Id: <20240314094319.5d6cc99c653e4797f162af04@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Linus, please merge the non-MM updates for this cycle.

I'm seeing conflicts in Documentation/process/changes.rst,
arch/riscv/include/asm/ftrace.h and fs/ocfs2/super.c.  I don't have a
record of Stephen hitting these, but all are simple.

Thanks.


The following changes since commit b401b621758e46812da61fa58a67c3fd8d91de0d:

  Linux 6.8-rc5 (2024-02-18 12:56:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2024-03-14-09-36

for you to fetch changes up to 269cdf353b5bdd15f1a079671b0f889113865f20:

  nilfs2: prevent kernel bug at submit_bh_wbc() (2024-03-14 09:17:30 -0700)

----------------------------------------------------------------
- Kuan-Wei Chiu has developed the well-named series "lib min_heap: Min
  heap optimizations".

- Kuan-Wei Chiu has also sped up the library sorting code in the series
  "lib/sort: Optimize the number of swaps and comparisons".

- Alexey Gladkov has added the ability for code running within an IPC
  namespace to alter its IPC and MQ limits.  The series is "Allow to
  change ipc/mq sysctls inside ipc namespace".

- Geert Uytterhoeven has contributed some dhrystone maintenance work in
  the series "lib: dhry: miscellaneous cleanups".

- Ryusuke Konishi continues nilfs2 maintenance work in the series

	"nilfs2: eliminate kmap and kmap_atomic calls"
	"nilfs2: fix kernel bug at submit_bh_wbc()"

- Nathan Chancellor has updated our build tools requirements in the
  series "Bump the minimum supported version of LLVM to 13.0.1".

- Muhammad Usama Anjum continues with the selftests maintenance work in
  the series "selftests/mm: Improve run_vmtests.sh".

- Oleg Nesterov has done some maintenance work against the signal code
  in the series "get_signal: minor cleanups and fix".

Plus the usual shower of singleton patches in various parts of the tree.
Please see the individual changelogs for details.

----------------------------------------------------------------
Ahelenia Ziemiańska (1):
      Normalise "name (ad@dr)" MODULE_AUTHORs to "name <ad@dr>"

Alexey Dobriyan (1):
      smp: make __smp_processor_id() 0-argument macro

Alexey Gladkov (3):
      sysctl: allow change system v ipc sysctls inside ipc namespace
      docs: add information about ipc sysctls limitations
      sysctl: allow to change limits for posix messages queues

Andy Shevchenko (1):
      dyndbg: replace kstrdup() + strchr() with kstrdup_and_replace()

Baoquan He (1):
      panic: suppress gnu_printf warning

Chengming Zhou (1):
      ocfs2: remove SLAB_MEM_SPREAD flag usage

Feng Tang (1):
      panic: add option to dump blocked tasks in panic_print

Geert Uytterhoeven (4):
      lib: dhry: remove unneeded <linux/mutex.h>
      lib: dhry: use ktime_ms_delta() helper
      lib: dhry: add missing closing parenthesis
      init: remove obsolete arch_call_rest_init() wrapper

Jan Kara (1):
      fat: fix uninitialized field in nostale filehandles

Kemeng Shi (1):
      flex_proportions: remove unused fprop_local_single

Kuan-Wei Chiu (4):
      lib min_heap: optimize number of calls to min_heapify()
      lib min_heap: optimize number of comparisons in min_heapify()
      lib/sort: optimize heapsort for equal elements in sift-down path
      lib/sort: optimize heapsort with double-pop variation

Li zeming (1):
      user_namespace: remove unnecessary NULL values from kbuf

Matthew Wilcox (Oracle) (1):
      bounds: support non-power-of-two CONFIG_NR_CPUS

Muhammad Usama Anjum (5):
      selftests/mm: hugetlb_reparenting_test: do not unmount
      selftests/mm: run_vmtests: remove sudo and conform to tap
      selftests/mm: save and restore nr_hugepages value
      selftests/mm: protection_keys: save/restore nr_hugepages settings
      selftests/mm: run_vmtests.sh: add missing tests

Nathan Chancellor (13):
      arch and include: update LLVM Phabricator links
      treewide: update LLVM Bugzilla links
      kbuild: raise the minimum supported version of LLVM to 13.0.1
      Makefile: drop warn-stack-size plugin opt
      x86: drop stack-alignment plugin opt
      ARM: remove Thumb2 __builtin_thread_pointer workaround for Clang
      arm64: Kconfig: clean up tautological LLVM version checks
      powerpc: Kconfig: remove tautology in CONFIG_COMPAT
      riscv: remove MCOUNT_NAME workaround
      riscv: Kconfig: remove version dependency from CONFIG_CLANG_SUPPORTS_DYNAMIC_FTRACE
      fortify: drop Clang version check for 12.0.1 or newer
      lib/Kconfig.debug: update Clang version check in CONFIG_KCOV
      compiler-clang.h: update __diag_clang() macros for minimum version bump

Oleg Nesterov (4):
      ptrace_attach: shift send(SIGSTOP) into ptrace_set_stopped()
      get_signal: don't abuse ksig->info.si_signo and ksig->sig
      get_signal: hide_si_addr_tag_bits: fix the usage of uninitialized ksig
      get_signal: don't initialize ksig->info if SIGNAL_GROUP_EXIT/group_exec_task

Peng Hao (1):
      buildid: use kmap_local_page()

Pierre Gondois (3):
      list: add hlist_count_nodes()
      binder: use of hlist_count_nodes()
      bcache: use of hlist_count_nodes()

Randy Dunlap (1):
      lib/win_minmax: fix header comments

Ricardo B. Marliere (2):
      const_structs.checkpatch: add bus_type
      const_structs.checkpatch: add device_type

Roman Smirnov (1):
      assoc_array: fix the return value in assoc_array_insert_mid_shortcut()

Ryusuke Konishi (18):
      nilfs2: convert recovery logic to use kmap_local
      nilfs2: convert segment buffer to use kmap_local
      nilfs2: convert nilfs_copy_buffer() to use kmap_local
      nilfs2: convert metadata file common code to use kmap_local
      nilfs2: convert sufile to use kmap_local
      nilfs2: convert persistent object allocator to use kmap_local
      nilfs2: convert DAT to use kmap_local
      nilfs2: move nilfs_bmap_write call out of nilfs_write_inode_common
      nilfs2: do not acquire rwsem in nilfs_bmap_write()
      nilfs2: convert ifile to use kmap_local
      nilfs2: localize highmem mapping for checkpoint creation within cpfile
      nilfs2: localize highmem mapping for checkpoint finalization within cpfile
      nilfs2: localize highmem mapping for checkpoint reading within cpfile
      nilfs2: remove nilfs_cpfile_{get,put}_checkpoint()
      nilfs2: convert cpfile to use kmap_local
      nilfs2: MAINTAINERS: drop unreachable project mirror site
      nilfs2: fix failure to detect DAT corruption in btree and direct mappings
      nilfs2: prevent kernel bug at submit_bh_wbc()

Su Yue (1):
      ocfs2: enable ocfs2_listxattr for special files

Thomas Weißschuh (1):
      watchdog/core: remove sysctl handlers from public header

Thorsten Blum (1):
      nilfs2: use div64_ul() instead of do_div()

Uwe Kleine-König (1):
      mul_u64_u64_div_u64: increase precision by conditionally swapping a and b

Wei Yang (1):
      list: leverage list_is_head() for list_entry_is_head()

Wen Yang (1):
      selftests: add eventfd selftests

Yongzhen Zhang (1):
      ocfs2: spelling fix

yang.zhang (1):
      kexec: copy only happens before uchunk goes to zero

 Documentation/admin-guide/kernel-parameters.txt    |   1 +
 Documentation/admin-guide/sysctl/kernel.rst        |  15 +-
 Documentation/process/changes.rst                  |   2 +-
 MAINTAINERS                                        |   1 -
 Makefile                                           |   8 -
 arch/arm/include/asm/current.h                     |   8 +-
 arch/arm64/Kconfig                                 |   9 +-
 arch/powerpc/Kconfig                               |   1 -
 arch/powerpc/Makefile                              |   4 +-
 arch/powerpc/kvm/book3s_hv_nested.c                |   2 +-
 arch/riscv/Kconfig                                 |   4 +-
 arch/riscv/include/asm/ftrace.h                    |  14 +-
 arch/riscv/kernel/mcount.S                         |  10 +-
 arch/s390/include/asm/ftrace.h                     |   2 +-
 arch/sparc/kernel/chmc.c                           |   2 +-
 arch/sparc/kernel/ds.c                             |   2 +-
 arch/x86/Makefile                                  |   6 -
 arch/x86/power/Makefile                            |   2 +-
 crypto/blake2b_generic.c                           |   2 +-
 drivers/android/binder.c                           |   4 +-
 drivers/block/sunvdc.c                             |   2 +-
 drivers/char/hw_random/n2-drv.c                    |   2 +-
 drivers/char/tpm/st33zp24/i2c.c                    |   2 +-
 drivers/char/tpm/st33zp24/spi.c                    |   2 +-
 drivers/char/tpm/st33zp24/st33zp24.c               |   2 +-
 drivers/char/tpm/tpm-interface.c                   |   2 +-
 drivers/char/tpm/tpm_atmel.c                       |   2 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c                 |   2 +-
 drivers/char/tpm/tpm_nsc.c                         |   2 +-
 drivers/char/tpm/tpm_tis.c                         |   2 +-
 drivers/char/tpm/tpm_tis_core.c                    |   2 +-
 drivers/char/tpm/tpm_vtpm_proxy.c                  |   2 +-
 drivers/crypto/n2_core.c                           |   2 +-
 drivers/firmware/efi/libstub/Makefile              |   2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c           |   2 +-
 drivers/hwmon/dell-smm-hwmon.c                     |   2 +-
 drivers/hwmon/ultra45_env.c                        |   2 +-
 drivers/i2c/muxes/i2c-mux-mlxcpld.c                |   2 +-
 drivers/leds/leds-sunfire.c                        |   2 +-
 drivers/md/bcache/sysfs.c                          |   8 +-
 drivers/media/common/siano/smscoreapi.c            |   2 +-
 drivers/media/common/siano/smsdvb-main.c           |   2 +-
 drivers/media/dvb-frontends/cx24117.c              |   2 +-
 drivers/media/test-drivers/vicodec/codec-fwht.c    |   2 +-
 drivers/media/usb/siano/smsusb.c                   |   2 +-
 drivers/net/ethernet/broadcom/tg3.c                |   2 +-
 drivers/net/ethernet/sun/cassini.c                 |   2 +-
 drivers/net/ethernet/sun/niu.c                     |   2 +-
 drivers/net/ethernet/sun/sunhme.c                  |   2 +-
 drivers/net/ethernet/sun/sunvnet.c                 |   2 +-
 drivers/net/ethernet/sun/sunvnet_common.c          |   2 +-
 drivers/net/ppp/pptp.c                             |   2 +-
 drivers/platform/x86/compal-laptop.c               |   2 +-
 drivers/platform/x86/intel/oaktrail.c              |   2 +-
 drivers/platform/x86/mlx-platform.c                |   2 +-
 drivers/regulator/Kconfig                          |   2 +-
 drivers/s390/net/fsm.c                             |   2 +-
 drivers/sbus/char/openprom.c                       |   2 +-
 drivers/scsi/esp_scsi.c                            |   2 +-
 drivers/scsi/jazz_esp.c                            |   2 +-
 drivers/scsi/mesh.c                                |   2 +-
 drivers/scsi/qlogicpti.c                           |   2 +-
 drivers/scsi/sun3x_esp.c                           |   2 +-
 drivers/scsi/sun_esp.c                             |   2 +-
 drivers/video/fbdev/hgafb.c                        |   2 +-
 fs/fat/nfs.c                                       |   6 +
 fs/nilfs2/alloc.c                                  |  91 +++---
 fs/nilfs2/bmap.c                                   |   3 -
 fs/nilfs2/btree.c                                  |   9 +-
 fs/nilfs2/cpfile.c                                 | 321 ++++++++++++++-------
 fs/nilfs2/cpfile.h                                 |  10 +-
 fs/nilfs2/dat.c                                    |  40 +--
 fs/nilfs2/direct.c                                 |   9 +-
 fs/nilfs2/ifile.c                                  |  21 +-
 fs/nilfs2/ifile.h                                  |  10 +-
 fs/nilfs2/inode.c                                  |  46 ++-
 fs/nilfs2/ioctl.c                                  |   4 +-
 fs/nilfs2/mdt.c                                    |   4 +-
 fs/nilfs2/nilfs.h                                  |   3 +-
 fs/nilfs2/page.c                                   |   8 +-
 fs/nilfs2/recovery.c                               |   4 +-
 fs/nilfs2/segbuf.c                                 |   4 +-
 fs/nilfs2/segment.c                                | 121 +++-----
 fs/nilfs2/sufile.c                                 |  88 +++---
 fs/nilfs2/super.c                                  |  33 +--
 fs/nilfs2/the_nilfs.c                              |   2 +-
 fs/ocfs2/dlmfs/dlmfs.c                             |   2 +-
 fs/ocfs2/dlmglue.c                                 |   2 +-
 fs/ocfs2/file.c                                    |   1 +
 fs/ocfs2/super.c                                   |   7 +-
 include/asm-generic/vmlinux.lds.h                  |   2 +-
 include/linux/compiler-clang.h                     |  10 +-
 include/linux/flex_proportions.h                   |  32 --
 include/linux/list.h                               |  17 +-
 include/linux/min_heap.h                           |  44 +--
 include/linux/nmi.h                                |   7 -
 include/linux/smp.h                                |   2 +-
 include/linux/start_kernel.h                       |   2 -
 include/linux/win_minmax.h                         |   4 +-
 init/main.c                                        |   9 +-
 ipc/ipc_sysctl.c                                   |  37 ++-
 ipc/mq_sysctl.c                                    |  36 +++
 kernel/bounds.c                                    |   2 +-
 kernel/kexec_core.c                                |  44 +--
 kernel/panic.c                                     |   9 +
 kernel/ptrace.c                                    |  13 +-
 kernel/signal.c                                    |  28 +-
 kernel/user_namespace.c                            |   2 +-
 kernel/watchdog.c                                  |  22 +-
 lib/Kconfig.debug                                  |   4 +-
 lib/Kconfig.kasan                                  |   2 +-
 lib/assoc_array.c                                  |   2 +-
 lib/buildid.c                                      |   4 +-
 lib/dhry_1.c                                       |   2 +-
 lib/dhry_run.c                                     |   1 -
 lib/dynamic_debug.c                                |   7 +-
 lib/flex_proportions.c                             |  77 -----
 lib/math/div64.c                                   |  15 +
 lib/raid6/Makefile                                 |   2 +-
 lib/sort.c                                         |  20 +-
 lib/stackinit_kunit.c                              |   2 +-
 mm/slab_common.c                                   |   2 +-
 net/bridge/br_multicast.c                          |   2 +-
 net/ipv4/gre_demux.c                               |   2 +-
 net/ipv6/ip6_gre.c                                 |   2 +-
 net/iucv/iucv.c                                    |   2 +-
 net/mpls/mpls_gso.c                                |   2 +-
 scripts/const_structs.checkpatch                   |   2 +
 scripts/min-tool-version.sh                        |   2 +-
 scripts/recordmcount.pl                            |   2 +-
 security/Kconfig                                   |   2 -
 tools/objtool/noreturns.h                          |   1 -
 .../selftests/filesystems/eventfd/.gitignore       |   2 +
 .../testing/selftests/filesystems/eventfd/Makefile |   7 +
 .../selftests/filesystems/eventfd/eventfd_test.c   | 186 ++++++++++++
 tools/testing/selftests/mm/Makefile                |   5 +
 .../selftests/mm/charge_reserved_hugetlb.sh        |   4 +
 .../selftests/mm/hugetlb_reparenting_test.sh       |   9 +-
 tools/testing/selftests/mm/on-fault-limit.c        |  36 ++-
 tools/testing/selftests/mm/protection_keys.c       |  34 +++
 tools/testing/selftests/mm/run_vmtests.sh          |  17 +-
 141 files changed, 1055 insertions(+), 770 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/eventfd/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/eventfd/Makefile
 create mode 100644 tools/testing/selftests/filesystems/eventfd/eventfd_test.c


