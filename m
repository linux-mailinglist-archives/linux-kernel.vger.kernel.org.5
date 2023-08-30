Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE59978E0EE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239905AbjH3UtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236546AbjH3UtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:49:05 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFEC1B1;
        Wed, 30 Aug 2023 13:48:33 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C1CA15CC;
        Wed, 30 Aug 2023 20:46:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C1CA15CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1693428416; bh=HF/dDluRsWIvDgC7IgIEXfDOtsNsS58QLwWXuBLyQuk=;
        h=From:To:Cc:Subject:Date:From;
        b=Jd2PiZ3VPw6Wp9ZnAXIQa4WzpXJOyedFNPwrcShB7guAcWvai6Gn6v3KyrFs0gPY9
         hpxTwxo6CC/7ykGQBPpkW9+NFSsJtJ0B3BOlB5OYVHcFFxR5CGklgG7NL8znKLUlI4
         gCJSD6B6twDMX1TRwMe6bdTwTZ5j7lWVRLPCEyKMvIusDuxL7PuFkMAG6ue2C/qjt7
         vc+JvqaV2vmsUMcL/rM1c/jnh2g3EmDkJB32/fJ1zxke/ZHKuqD0LcpRuQIIeJm9rV
         l95KlAwfLDPHsWfzEU9y54HAVTkpyBv61TUPge6IWBVvtrXCcg8htCr+Vwq36JqEXO
         0+gZ+xlO1gRXw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [GIT PULL] Documentation for 6.6
Date:   Wed, 30 Aug 2023 14:46:56 -0600
Message-ID: <87edjkp8an.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.6

for you to fetch changes up to c63594f2d66690805eb78b75e4b8e8dc9f2672bf:

  Docu: genericirq.rst: fix irq-example (2023-08-28 12:45:31 -0600)

----------------------------------------------------------------
Documentation work keeps chugging along; stuff for 6.6 includes:

- Work from Carlos Bilbao to integrate rustdoc output into the generated
  HTML documentation.  This took some work to figure out how to do it
  without slowing the docs build and without creating people who don't have
  Rust installed, but Carlos got there.

- Move the loongarch and mips architecture documentation under
  Documentation/arch/.

- Some more maintainer documentation from Jakub

- Work from Randy to fill out some timekeeping-related kerneldoc
  comments.

...plus the usual assortment of updates, translations, and fixes.

There are a couple of minor conflicts with the char-misc and usb trees
resulting from the wide net of typo fixes; both are trivial to resolve.

----------------------------------------------------------------
Alexandre Ghiti (3):
      Documentation: arm: Add bootargs to the table of added DT parameters
      Documentation: riscv: Add early boot document
      Documentation: riscv: Update boot image header since EFI stub is supported

Andrei Emeltchenko (1):
      Documentation: serial-console: Fix literal block marker

Andy Shevchenko (1):
      docs: kernel-parameters: Refer to the correct bitmap function

Avadhut Naik (2):
      docs/sp_SP: Add translation of process/researcher-guidelines
      docs/sp_SP: Add translation of process/contribution-maturity-model

Bjorn Helgaas (2):
      Documentation/ABI: Fix typos
      Documentation: Fix typos

Carlos Bilbao (3):
      docs: Move rustdoc output, cross-reference it
      docs: Integrate rustdoc generation into htmldocs
      docs: Add book to process/kernel-docs.rst

Christophe JAILLET (1):
      docs: deprecated.rst: Update an example

Costa Shulyupin (4):
      docs: consolidate core subsystems
      docs: consolidate networking interfaces
      docs: move loongarch under arch
      docs: move mips under arch

Fabio M. De Francesco (1):
      Documentation/highmem: Add information about kmap_local_folio()

Hu Haowen (3):
      docs/zh_CN: change my own email address
      docs/zh_TW: rewrite index.rst
      docs/zh_TW: remove the mailing list entry for zh_TW

Jakub Kicinski (4):
      MAINTAINERS: treat Documentation/maintainer as process docs
      docs: maintainers: mention tag -s for signed tags
      docs: maintainers: add missing 's' in https for the base lore link
      docs: maintainer: document expectations of small time maintainers

Jonathan Corbet (5):
      docs: Slight maintainer's guide decrufting
      Merge branch 'hu' into docs-mw
      docs: ABI: fix an RST error in sysfs-bus-nvdimm
      docs: Add a section on surveys to the researcher guidelines
      docs: vfs: clean up after the iterate() removal

Krzysztof Pawlaczyk (1):
      docs: cgroup-v1: replace dead CONFIG_MEM_RES_CTRL_SWAP symbol

Lukas Bulwahn (1):
      afs: Documentation: correct reference to CONFIG_AFS_FS

Ma Wupeng (1):
      doc: update params of memhp_default_state=

Marco Pagani (1):
      docs/mm: remove references to hmm_mirror ops and clean typos

Marcus Folkesson (1):
      input: docs: pxrc: remove reference to phoenix-sim

Min-Hua Chen (1):
      docs: sparse: fix invalid link addresses

Pavan Kumar Linga (2):
      scripts: kernel-doc: parse DEFINE_DMA_UNMAP_[ADDR|LEN]
      scripts: kernel-doc: fix macro handling in enums

Philipp Stanner (1):
      Docu: genericirq.rst: fix irq-example

Ramazan Safiullin (1):
      docs: psi: use correct config name

Randy Dunlap (10):
      kconfig: docs: mention gconfig at top of kconfig.rst
      Documentation: doc-guide: use '%' constant indicator in Return: examples
      Documentation: admin-guide: correct "it's" to possessive "its"
      docs: add more driver-model infrastructure interfaces
      docs: time: make separate section for time and timers
      jiffies: add kernel-doc for all APIs
      time: add kernel-doc in time.c
      Docs: kernel-parameters: sort arm64 entries
      docs: panic: cleanups for panic params
      Docs: kernel-parameters: sort the LEGEND list

Rick Wertenbroek (1):
      docs: scheduler: completion: Fix minor error in pseudo-code

SeongJae Park (2):
      Docs/process/changes: Consolidate NFS-utils update links
      Docs/process/changes: Replace http:// with https://

Tiezhu Yang (2):
      Documentation/features: Check ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
      Documentation/features: Refresh support files for 6.5

Usama Arif (1):
      docs: mm: Fix number of base pages for 1GB HugeTLB

Xueshi Hu (1):
      docs/zh_CN: correct regi_chg(),regi_add() to region_chg(),region_add()

 Documentation/ABI/stable/sysfs-block               |   2 +-
 Documentation/ABI/stable/sysfs-class-infiniband    |   2 +-
 Documentation/ABI/stable/sysfs-platform-wmi-bmof   |   2 +-
 .../ABI/testing/debugfs-driver-habanalabs          |   2 +-
 Documentation/ABI/testing/procfs-diskstats         |   2 +-
 Documentation/ABI/testing/sysfs-bus-coreboot       |   2 +-
 .../ABI/testing/sysfs-bus-coresight-devices-etm3x  |   8 +-
 .../ABI/testing/sysfs-bus-coresight-devices-etm4x  |   2 +-
 .../testing/sysfs-bus-event_source-devices-events  |   4 +-
 .../ABI/testing/sysfs-bus-fsi-devices-sbefifo      |   4 +-
 .../ABI/testing/sysfs-bus-i2c-devices-fsa9480      |   2 +-
 Documentation/ABI/testing/sysfs-bus-nfit           |   2 +-
 Documentation/ABI/testing/sysfs-bus-nvdimm         |   4 +-
 Documentation/ABI/testing/sysfs-bus-papr-pmem      |   2 +-
 Documentation/ABI/testing/sysfs-bus-umc            |   2 +-
 Documentation/ABI/testing/sysfs-class              |   2 +-
 Documentation/ABI/testing/sysfs-class-cxl          |   4 +-
 Documentation/ABI/testing/sysfs-class-mtd          |   2 +-
 Documentation/ABI/testing/sysfs-class-net          |   2 +-
 Documentation/ABI/testing/sysfs-class-net-queues   |   2 +-
 Documentation/ABI/testing/sysfs-class-power-wilco  |   2 +-
 Documentation/ABI/testing/sysfs-class-remoteproc   |   2 +-
 Documentation/ABI/testing/sysfs-class-thermal      |   2 +-
 .../ABI/testing/sysfs-class-uwb_rc-wusbhc          |   2 +-
 Documentation/ABI/testing/sysfs-devices-online     |   2 +-
 Documentation/ABI/testing/sysfs-driver-ge-achc     |   2 +-
 Documentation/ABI/testing/sysfs-driver-tegra-fuse  |   2 +-
 Documentation/ABI/testing/sysfs-firmware-acpi      |   2 +-
 Documentation/ABI/testing/sysfs-firmware-sgi_uv    |   4 +-
 Documentation/ABI/testing/sysfs-fs-f2fs            |   8 +-
 Documentation/ABI/testing/sysfs-kernel-mm-damon    |   2 +-
 .../ABI/testing/sysfs-memory-page-offline          |   4 +-
 .../ABI/testing/sysfs-platform-dell-laptop         |   2 +-
 Documentation/ABI/testing/sysfs-platform-dfl-fme   |   2 +-
 Documentation/ABI/testing/sysfs-platform-kim       |   2 +-
 Documentation/ABI/testing/sysfs-platform-sst-atom  |   2 +-
 Documentation/Makefile                             |  16 ++
 Documentation/accounting/psi.rst                   |   2 +-
 Documentation/admin-guide/cgroup-v1/memcg_test.rst |   2 +-
 Documentation/admin-guide/kernel-parameters.rst    |  25 +--
 Documentation/admin-guide/kernel-parameters.txt    |  46 ++---
 Documentation/admin-guide/mm/damon/usage.rst       |   4 +-
 .../admin-guide/mm/numa_memory_policy.rst          |   2 +-
 Documentation/admin-guide/module-signing.rst       |   2 +-
 Documentation/admin-guide/serial-console.rst       |   2 +-
 Documentation/admin-guide/xfs.rst                  |   2 +-
 Documentation/arch/arm/arm.rst                     |   2 +-
 Documentation/arch/arm/ixp4xx.rst                  |   4 +-
 Documentation/arch/arm/sunxi/clocks.rst            |   2 +-
 Documentation/arch/arm/swp_emulation.rst           |   2 +-
 Documentation/arch/arm/tcm.rst                     |   2 +-
 Documentation/arch/arm/uefi.rst                    |   4 +-
 Documentation/arch/arm/vlocks.rst                  |   2 +-
 Documentation/arch/arm64/acpi_object_usage.rst     |   2 +-
 Documentation/arch/arm64/arm-acpi.rst              |   2 +-
 Documentation/arch/index.rst                       |   4 +-
 Documentation/{ => arch}/loongarch/booting.rst     |   0
 Documentation/{ => arch}/loongarch/features.rst    |   0
 Documentation/{ => arch}/loongarch/index.rst       |   0
 .../{ => arch}/loongarch/introduction.rst          |   0
 .../{ => arch}/loongarch/irq-chip-model.rst        |   0
 Documentation/{ => arch}/mips/booting.rst          |   0
 Documentation/{ => arch}/mips/features.rst         |   0
 Documentation/{ => arch}/mips/index.rst            |   0
 Documentation/{ => arch}/mips/ingenic-tcu.rst      |   0
 Documentation/arch/openrisc/openrisc_port.rst      |   4 +-
 Documentation/arch/x86/boot.rst                    |   2 +-
 Documentation/arch/x86/buslock.rst                 |   2 +-
 Documentation/arch/x86/mds.rst                     |   2 +-
 Documentation/arch/x86/sgx.rst                     |   2 +-
 Documentation/arch/xtensa/atomctl.rst              |   2 +-
 Documentation/block/data-integrity.rst             |   2 +-
 Documentation/block/ublk.rst                       |   2 +-
 Documentation/bpf/cpumasks.rst                     |   2 +-
 Documentation/bpf/graph_ds_impl.rst                |   2 +-
 Documentation/core-api/genericirq.rst              |   2 +-
 .../devicetree/bindings/timer/ingenic,tcu.yaml     |   2 +-
 Documentation/doc-guide/kernel-doc.rst             |  10 +-
 Documentation/driver-api/basics.rst                |  27 ++-
 Documentation/driver-api/infrastructure.rst        |  18 ++
 Documentation/fault-injection/fault-injection.rst  |   2 +-
 Documentation/fb/deferred_io.rst                   |   2 +-
 Documentation/fb/sm712fb.rst                       |   2 +-
 Documentation/fb/sstfb.rst                         |   2 +-
 .../core/thread-info-in-task/arch-support.txt      |   2 +-
 .../debug/kprobes-on-ftrace/arch-support.txt       |   2 +-
 .../features/debug/kprobes/arch-support.txt        |   2 +-
 .../features/debug/kretprobes/arch-support.txt     |   2 +-
 .../features/debug/stackprotector/arch-support.txt |   2 +-
 .../features/debug/uprobes/arch-support.txt        |   2 +-
 .../features/locking/lockdep/arch-support.txt      |   2 +-
 .../features/vm/ELF-ASLR/arch-support.txt          |   5 +-
 Documentation/filesystems/9p.rst                   |   2 +-
 Documentation/filesystems/afs.rst                  |   2 +-
 Documentation/filesystems/befs.rst                 |   4 +-
 Documentation/filesystems/caching/cachefiles.rst   |   2 +-
 Documentation/filesystems/caching/netfs-api.rst    |   6 +-
 Documentation/filesystems/configfs.rst             |   2 +-
 Documentation/filesystems/dax.rst                  |   2 +-
 Documentation/filesystems/devpts.rst               |   4 +-
 Documentation/filesystems/ext4/super.rst           |   2 +-
 Documentation/filesystems/f2fs.rst                 |   6 +-
 Documentation/filesystems/gfs2-glocks.rst          |   2 +-
 Documentation/filesystems/idmappings.rst           |  14 +-
 Documentation/filesystems/locking.rst              |   1 -
 Documentation/filesystems/netfs_library.rst        |   2 +-
 .../filesystems/nfs/client-identifier.rst          |   2 +-
 Documentation/filesystems/nfs/rpc-cache.rst        |   2 +-
 Documentation/filesystems/nfs/rpc-server-gss.rst   |   2 +-
 Documentation/filesystems/nilfs2.rst               |   2 +-
 Documentation/filesystems/ntfs3.rst                |   2 +-
 Documentation/filesystems/orangefs.rst             |   2 +-
 Documentation/filesystems/overlayfs.rst            |   4 +-
 Documentation/filesystems/porting.rst              |   6 +-
 Documentation/filesystems/proc.rst                 |  12 +-
 Documentation/filesystems/qnx6.rst                 |   2 +-
 Documentation/filesystems/seq_file.rst             |   4 +-
 Documentation/filesystems/ubifs-authentication.rst |   2 +-
 Documentation/filesystems/vfat.rst                 |   2 +-
 Documentation/filesystems/vfs.rst                  |   9 +-
 .../filesystems/xfs-online-fsck-design.rst         |  20 +--
 Documentation/filesystems/zonefs.rst               |   2 +-
 Documentation/firmware-guide/acpi/osi.rst          |   2 +-
 Documentation/gpu/amdgpu/display/mpo-overview.rst  |   2 +-
 Documentation/gpu/drm-kms-helpers.rst              |   2 +-
 Documentation/gpu/drm-kms.rst                      |   6 +-
 Documentation/gpu/drm-usage-stats.rst              |   4 +-
 Documentation/gpu/i915.rst                         |   4 +-
 Documentation/gpu/kms-properties.csv               |   2 +-
 Documentation/gpu/komeda-kms.rst                   |   4 +-
 Documentation/gpu/msm-crash-dump.rst               |   2 +-
 Documentation/gpu/rfc/i915_scheduler.rst           |   2 +-
 Documentation/gpu/rfc/i915_vm_bind.rst             |   2 +-
 Documentation/gpu/todo.rst                         |   8 +-
 Documentation/hwmon/pmbus-core.rst                 |   2 +-
 Documentation/input/devices/iforce-protocol.rst    |   2 +-
 Documentation/input/devices/pxrc.rst               |   7 +-
 Documentation/input/multi-touch-protocol.rst       |   2 +-
 Documentation/kbuild/kconfig.rst                   |   2 +
 Documentation/livepatch/reliable-stacktrace.rst    |   2 +-
 Documentation/locking/lockdep-design.rst           |   4 +-
 Documentation/locking/locktorture.rst              |   2 +-
 Documentation/locking/locktypes.rst                |   2 +-
 Documentation/maintainer/configure-git.rst         |  36 ++--
 .../maintainer/feature-and-driver-maintainers.rst  | 155 ++++++++++++++++
 Documentation/maintainer/index.rst                 |   1 +
 Documentation/maintainer/pull-requests.rst         |   4 +-
 Documentation/mm/highmem.rst                       |  27 +--
 Documentation/mm/hmm.rst                           |  13 +-
 Documentation/mm/hwpoison.rst                      |   2 +-
 Documentation/mm/page_migration.rst                |   2 +-
 Documentation/mm/unevictable-lru.rst               |   2 +-
 Documentation/mm/vmemmap_dedup.rst                 |   5 +-
 Documentation/netlink/genetlink-c.yaml             |   2 +-
 Documentation/netlink/genetlink-legacy.yaml        |   2 +-
 Documentation/networking/bonding.rst               |   2 +-
 Documentation/networking/devlink/devlink-port.rst  |   6 +-
 Documentation/networking/packet_mmap.rst           |   2 +-
 Documentation/power/energy-model.rst               |   4 +-
 Documentation/powerpc/dscr.rst                     |   2 +-
 Documentation/powerpc/kasan.txt                    |   2 +-
 Documentation/powerpc/papr_hcalls.rst              |   2 +-
 Documentation/powerpc/qe_firmware.rst              |   4 +-
 Documentation/powerpc/vas-api.rst                  |   4 +-
 Documentation/process/botching-up-ioctls.rst       |   2 +-
 Documentation/process/changes.rst                  |  16 +-
 Documentation/process/deprecated.rst               |   2 +-
 Documentation/process/kernel-docs.rst              |  11 +-
 Documentation/process/researcher-guidelines.rst    |  27 +++
 Documentation/riscv/boot-image-header.rst          |  13 +-
 Documentation/riscv/boot.rst                       | 169 ++++++++++++++++++
 Documentation/riscv/hwprobe.rst                    |   4 +-
 Documentation/riscv/index.rst                      |   1 +
 Documentation/riscv/vector.rst                     |   2 +-
 Documentation/rust/index.rst                       |   8 +
 Documentation/s390/vfio-ap.rst                     |   2 +-
 Documentation/scheduler/completion.rst             |   2 +-
 Documentation/scheduler/sched-bwc.rst              |   2 +-
 Documentation/scheduler/sched-energy.rst           |   4 +-
 Documentation/scsi/ChangeLog.lpfc                  |   2 +-
 Documentation/security/digsig.rst                  |   2 +-
 Documentation/security/keys/core.rst               |   2 +-
 Documentation/security/secrets/coco.rst            |   2 +-
 Documentation/sphinx/cdomain.py                    |   2 +-
 Documentation/spi/spi-lm70llp.rst                  |   2 +-
 Documentation/subsystem-apis.rst                   |  38 ++--
 Documentation/tools/rtla/rtla-timerlat-top.rst     |   2 +-
 .../trace/coresight/coresight-etm4x-reference.rst  |   2 +-
 Documentation/trace/events.rst                     |   6 +-
 Documentation/trace/fprobe.rst                     |   2 +-
 Documentation/trace/ftrace.rst                     |   2 +-
 Documentation/trace/hwlat_detector.rst             |   2 +-
 Documentation/trace/rv/da_monitor_synthesis.rst    |   2 +-
 Documentation/trace/rv/monitor_wwnr.rst            |   2 +-
 Documentation/trace/rv/runtime-verification.rst    |   2 +-
 Documentation/trace/uprobetracer.rst               |   2 +-
 Documentation/trace/user_events.rst                |   2 +-
 .../sp_SP/process/contribution-maturity-model.rst  | 120 +++++++++++++
 Documentation/translations/sp_SP/process/index.rst |   2 +
 .../sp_SP/process/researcher-guidelines.rst        | 150 ++++++++++++++++
 Documentation/translations/zh_CN/arch/index.rst    |   4 +-
 .../zh_CN/{ => arch}/loongarch/booting.rst         |   4 +-
 .../zh_CN/{ => arch}/loongarch/features.rst        |   4 +-
 .../zh_CN/{ => arch}/loongarch/index.rst           |   4 +-
 .../zh_CN/{ => arch}/loongarch/introduction.rst    |   4 +-
 .../zh_CN/{ => arch}/loongarch/irq-chip-model.rst  |   4 +-
 .../translations/zh_CN/{ => arch}/mips/booting.rst |   4 +-
 .../zh_CN/{ => arch}/mips/features.rst             |   4 +-
 .../translations/zh_CN/{ => arch}/mips/index.rst   |   4 +-
 .../zh_CN/{ => arch}/mips/ingenic-tcu.rst          |   4 +-
 .../zh_CN/dev-tools/testing-overview.rst           |   2 +-
 .../translations/zh_CN/mm/hugetlbfs_reserv.rst     |   4 +-
 Documentation/translations/zh_TW/IRQ.txt           |   8 +-
 .../translations/zh_TW/admin-guide/README.rst      |   2 +-
 .../translations/zh_TW/admin-guide/bug-bisect.rst  |   2 +-
 .../translations/zh_TW/admin-guide/bug-hunting.rst |   2 +-
 .../zh_TW/admin-guide/clearing-warn-once.rst       |   2 +-
 .../translations/zh_TW/admin-guide/cpu-load.rst    |   2 +-
 .../translations/zh_TW/admin-guide/index.rst       |   2 +-
 .../translations/zh_TW/admin-guide/init.rst        |   2 +-
 .../zh_TW/admin-guide/reporting-issues.rst         |   2 +-
 .../zh_TW/admin-guide/security-bugs.rst            |   2 +-
 .../zh_TW/admin-guide/tainted-kernels.rst          |   2 +-
 .../translations/zh_TW/admin-guide/unicode.rst     |   2 +-
 .../translations/zh_TW/arch/arm64/amu.rst          |   2 +-
 .../translations/zh_TW/arch/arm64/booting.txt      |   4 +-
 .../translations/zh_TW/arch/arm64/elf_hwcaps.rst   |   2 +-
 .../translations/zh_TW/arch/arm64/hugetlbpage.rst  |   2 +-
 .../translations/zh_TW/arch/arm64/index.rst        |   2 +-
 .../zh_TW/arch/arm64/legacy_instructions.txt       |   4 +-
 .../translations/zh_TW/arch/arm64/memory.txt       |   4 +-
 .../translations/zh_TW/arch/arm64/perf.rst         |   2 +-
 .../zh_TW/arch/arm64/silicon-errata.txt            |   4 +-
 .../zh_TW/arch/arm64/tagged-pointers.txt           |   4 +-
 Documentation/translations/zh_TW/cpu-freq/core.rst |   2 +-
 .../translations/zh_TW/cpu-freq/cpu-drivers.rst    |   2 +-
 .../translations/zh_TW/cpu-freq/cpufreq-stats.rst  |   2 +-
 .../translations/zh_TW/cpu-freq/index.rst          |   2 +-
 .../translations/zh_TW/disclaimer-zh_TW.rst        |   2 +-
 .../translations/zh_TW/filesystems/debugfs.rst     |   4 +-
 .../translations/zh_TW/filesystems/index.rst       |   2 +-
 .../translations/zh_TW/filesystems/sysfs.txt       |   2 +-
 .../translations/zh_TW/filesystems/tmpfs.rst       |   2 +-
 .../translations/zh_TW/filesystems/virtiofs.rst    |   2 +-
 Documentation/translations/zh_TW/gpio.txt          |   8 +-
 Documentation/translations/zh_TW/index.rst         | 158 ++++++-----------
 Documentation/translations/zh_TW/io_ordering.txt   |   8 +-
 .../translations/zh_TW/process/1.Intro.rst         |   2 +-
 .../translations/zh_TW/process/2.Process.rst       |   2 +-
 .../translations/zh_TW/process/3.Early-stage.rst   |   2 +-
 .../translations/zh_TW/process/4.Coding.rst        |   2 +-
 .../translations/zh_TW/process/5.Posting.rst       |   2 +-
 .../translations/zh_TW/process/6.Followthrough.rst |   2 +-
 .../zh_TW/process/7.AdvancedTopics.rst             |   2 +-
 .../translations/zh_TW/process/8.Conclusion.rst    |   2 +-
 .../process/code-of-conduct-interpretation.rst     |   2 +-
 .../translations/zh_TW/process/code-of-conduct.rst |   2 +-
 .../translations/zh_TW/process/coding-style.rst    |   2 +-
 .../zh_TW/process/development-process.rst          |   2 +-
 .../translations/zh_TW/process/email-clients.rst   |   2 +-
 .../zh_TW/process/embargoed-hardware-issues.rst    |   2 +-
 Documentation/translations/zh_TW/process/howto.rst |   2 +-
 Documentation/translations/zh_TW/process/index.rst |   2 +-
 .../zh_TW/process/kernel-driver-statement.rst      |   2 +-
 .../zh_TW/process/kernel-enforcement-statement.rst |   2 +-
 .../translations/zh_TW/process/license-rules.rst   |   2 +-
 .../translations/zh_TW/process/magic-number.rst    |   2 +-
 .../zh_TW/process/management-style.rst             |   2 +-
 .../zh_TW/process/programming-language.rst         |   2 +-
 .../zh_TW/process/stable-api-nonsense.rst          |   2 +-
 .../zh_TW/process/stable-kernel-rules.rst          |   2 +-
 .../zh_TW/process/submit-checklist.rst             |   2 +-
 .../zh_TW/process/submitting-patches.rst           |   2 +-
 .../zh_TW/process/volatile-considered-harmful.rst  |   2 +-
 Documentation/translations/zh_TW/sparse.txt        |  10 +-
 Documentation/usb/gadget_uvc.rst                   |   2 +-
 .../media/v4l/ext-ctrls-codec-stateless.rst        |   2 +-
 .../userspace-api/media/v4l/metafmt-d4xx.rst       |   2 +-
 Documentation/userspace-api/netlink/intro.rst      |   2 +-
 Documentation/virt/hyperv/clocks.rst               |   2 +-
 Documentation/virt/kvm/api.rst                     |  26 +--
 Documentation/virt/kvm/devices/vm.rst              |   2 +-
 Documentation/virt/kvm/devices/xive.rst            |   2 +-
 Documentation/virt/kvm/halt-polling.rst            |   2 +-
 Documentation/virt/kvm/x86/mmu.rst                 |   2 +-
 .../virt/kvm/x86/running-nested-guests.rst         |   2 +-
 .../virt/uml/user_mode_linux_howto_v2.rst          |   2 +-
 Documentation/w1/slaves/w1_therm.rst               |   2 +-
 Documentation/w1/w1-generic.rst                    |   2 +-
 Documentation/w1/w1-netlink.rst                    |   2 +-
 Documentation/watchdog/watchdog-kernel-api.rst     |   2 +-
 Documentation/wmi/devices/dell-wmi-ddv.rst         |   4 +-
 MAINTAINERS                                        |  10 +-
 drivers/irqchip/Kconfig                            |   2 +-
 include/linux/jiffies.h                            | 197 ++++++++++++++++++---
 kernel/time/time.c                                 | 169 ++++++++++++++++--
 rust/Makefile                                      |  15 +-
 scripts/kernel-doc                                 |   5 +
 298 files changed, 1593 insertions(+), 647 deletions(-)
 rename Documentation/{ => arch}/loongarch/booting.rst (100%)
 rename Documentation/{ => arch}/loongarch/features.rst (100%)
 rename Documentation/{ => arch}/loongarch/index.rst (100%)
 rename Documentation/{ => arch}/loongarch/introduction.rst (100%)
 rename Documentation/{ => arch}/loongarch/irq-chip-model.rst (100%)
 rename Documentation/{ => arch}/mips/booting.rst (100%)
 rename Documentation/{ => arch}/mips/features.rst (100%)
 rename Documentation/{ => arch}/mips/index.rst (100%)
 rename Documentation/{ => arch}/mips/ingenic-tcu.rst (100%)
 create mode 100644 Documentation/maintainer/feature-and-driver-maintainers.rst
 create mode 100644 Documentation/riscv/boot.rst
 create mode 100644 Documentation/translations/sp_SP/process/contribution-maturity-model.rst
 create mode 100644 Documentation/translations/sp_SP/process/researcher-guidelines.rst
 rename Documentation/translations/zh_CN/{ => arch}/loongarch/booting.rst (94%)
 rename Documentation/translations/zh_CN/{ => arch}/loongarch/features.rst (61%)
 rename Documentation/translations/zh_CN/{ => arch}/loongarch/index.rst (78%)
 rename Documentation/translations/zh_CN/{ => arch}/loongarch/introduction.rst (99%)
 rename Documentation/translations/zh_CN/{ => arch}/loongarch/irq-chip-model.rst (98%)
 rename Documentation/translations/zh_CN/{ => arch}/mips/booting.rst (92%)
 rename Documentation/translations/zh_CN/{ => arch}/mips/features.rst (65%)
 rename Documentation/translations/zh_CN/{ => arch}/mips/index.rst (79%)
 rename Documentation/translations/zh_CN/{ => arch}/mips/ingenic-tcu.rst (97%)
