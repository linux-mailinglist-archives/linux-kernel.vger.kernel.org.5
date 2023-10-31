Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEA87DD496
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346521AbjJaRYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjJaRYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:24:10 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DDC91;
        Tue, 31 Oct 2023 10:24:05 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6E88B6D6;
        Tue, 31 Oct 2023 17:24:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6E88B6D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1698773045; bh=ZwrAH2yN3AOZCG0j/MpOKJQXaDsyFURsqcbBVXNqiJ4=;
        h=From:To:Cc:Subject:Date:From;
        b=CutSSKhgoDKnVy0PtILD1yZ5VhXH+smmsex+yMU/3zDg5aZchcLcDkJgKyU7kGRNG
         EXqRsQQNY6r42DFLONg+OdXGSGGglYnE+ns6mm6CG1UUYUmFV5ov71lmW0ddRlihK1
         9L8wLXhhxYBlgQKo8Z8tjvlsnGmAYuOT0UHdHBhJa3yS9H+Rw0lKXAa195bGf9ceD5
         1iSv8JwhxxCiz/uIfi83e3lcgZmUbWT0dE1JxV4+WqSii+4ah5Yec2HIUr5p4K+Oee
         hB9Hu9Xn9rSdTDa2GwS091Yg2veNjYfvagRLPbRr2T+lA57OmF5RFqmfZaiSMX7Eds
         xp1f+JZ8uYKVA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Documentation for 6.7
Date:   Tue, 31 Oct 2023 11:24:04 -0600
Message-ID: <87fs1qd7t7.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.7

for you to fetch changes up to cf63348b4c45384d02126f86676d5afc75d661a7:

  scripts/kernel-doc: Fix the regex for matching -Werror flag (2023-10-30 1=
0:52:07 -0600)

----------------------------------------------------------------
The number of commits for documentation is not huge this time around, but
there are some significant changes nonetheless:

- Some more Spanish-language and Chinese translations.

- The much-discussed documentation of the confidential-computing threat
  model.

- Powerpc and RISCV documentation move under Documentation/arch - these
  complete this particular bit of documentation churn.

- A large traditional-Chinese documentation update.

- A new document on backporting and conflict resolution.

- Some kernel-doc and Sphinx fixes.

Plus the usual smattering of smaller updates and typo fixes.

Expect a small conflict with the powerpc tree, which adds a new file to
the old documentation location; Git mostly figures it out, but you may
need to add the file explicitly.

----------------------------------------------------------------
Amos Wenger (1):
      mm/memory-hotplug: fix typo in documentation

Andy Shevchenko (1):
      PCI: Update the devres documentation regarding to pcim_*()

Avadhut Naik (2):
      docs/sp_SP: Add translation of process/security-bugs
      docs/sp_SP: Add translation of process/embargoed-hardware-issues

Benjamin Gray (1):
      Documentation/sphinx: fix Python string escapes

Carlos Bilbao (1):
      docs: security: Confidential computing intro and threat model for x86=
 virtualization

Charles Han (2):
      Documentation: xfs: Remove repeated word in comments
      Documentation/sphinx: Remove the repeated word "the" in comments.

Costa Shulyupin (4):
      docs: move leds under section Human interfaces
      docs: move powerpc under arch
      docs: update link to powerpc/vmemmap_dedup.rst
      docs: move riscv under arch

Fabio M. De Francesco (1):
      Documentation/page_tables: Add info about MMU/TLB and Page Faults

Hu Haowen (1):
      docs/zh_TW: update contents for zh_TW

Jade Lovelace (1):
      Documentation: fix typo in dynamic-debug howto

Jonathan Corbet (1):
      Merge branch 'riscv-move' into docs-mw

Kuan-Wei Chiu (1):
      docs: block: blk-mq.rst: correct places -> place

Mark Brown (1):
      docs: submitting-patches: Suggest a longer expected time for responses

Matthew Wilcox (Oracle) (1):
      fork: Fix kernel-doc

Mikko Rapeli (1):
      Documentation efi-stub.rst: fix arm64 EFI source location

Min-Hua Chen (4):
      docs: sparse: move TW sparse.txt to TW dev-tools
      docs: sparse: convert sparse.txt to RST
      docs: sparse: add sparse.rst to toctree
      docs: sparse: add SPDX-License-Identifier

Oliver Faso (1):
      docs/sphinx: Explicitly convert Sphinx paths to str

Pandith N (1):
      Documentation: driver-api: pps: Update PPS generator documentation

Randy Dunlap (1):
      docs: admin-guide: sysctl: fix details of struct dentry_stat_t

Samuel Thibault (1):
      speakup: Document USB support

Takahiro Itazuri (1):
      docs/hw-vuln: Update desc of best effort mode

Tang Yizhou (2):
      docs/zh_CN: Add subsystem-apis Chinese translation
      doc: blk-ioprio: Bring the doc in line with the implementation

Thomas Wei=C3=9Fschuh (1):
      docs: submitting-patches: encourage direct notifications to commenters

Uwe Kleine-K=C3=B6nig (1):
      pwm: Adapt sysfs API documentation to reality

Vegard Nossum (4):
      docs: add backporting and conflict resolution document
      docs: doc-guide: mention 'make refcheckdocs'
      docs: usb: fix reference to nonexistent file in UVC Gadget
      docs: backporting: address feedback

Vratislav Bendel (1):
      docs: mm: fix vm overcommit documentation for OVERCOMMIT_GUESS

Wang Jinchao (1):
      memory-hotplug.rst: fix wrong /sys/device/ path

Yujie Liu (2):
      scripts/kernel-doc: match -Werror flag strictly
      scripts/kernel-doc: Fix the regex for matching -Werror flag

 Documentation/ABI/testing/sysfs-bus-papr-pmem      |   2 +-
 Documentation/PCI/pci-error-recovery.rst           |   4 +-
 Documentation/admin-guide/cgroup-v2.rst            |  10 +-
 Documentation/admin-guide/dynamic-debug-howto.rst  |   2 +-
 Documentation/admin-guide/efi-stub.rst             |   2 +-
 Documentation/admin-guide/hw-vuln/mds.rst          |  34 +-
 .../hw-vuln/processor_mmio_stale_data.rst          |  13 +-
 .../admin-guide/hw-vuln/tsx_async_abort.rst        |  33 +-
 Documentation/admin-guide/mm/memory-hotplug.rst    |  10 +-
 Documentation/admin-guide/spkguide.txt             |  11 +-
 Documentation/admin-guide/sysctl/fs.rst            |  16 +-
 Documentation/admin-guide/sysctl/vm.rst            |   4 +-
 Documentation/arch/index.rst                       |   4 +-
 Documentation/{ =3D> arch}/powerpc/associativity.rst |   0
 Documentation/{ =3D> arch}/powerpc/booting.rst       |   0
 Documentation/{ =3D> arch}/powerpc/bootwrapper.rst   |   0
 Documentation/{ =3D> arch}/powerpc/cpu_families.rst  |   0
 Documentation/{ =3D> arch}/powerpc/cpu_features.rst  |   0
 Documentation/{ =3D> arch}/powerpc/cxl.rst           |   0
 Documentation/{ =3D> arch}/powerpc/cxlflash.rst      |   2 +-
 Documentation/{ =3D> arch}/powerpc/dawr-power9.rst   |   0
 Documentation/{ =3D> arch}/powerpc/dexcr.rst         |   0
 Documentation/{ =3D> arch}/powerpc/dscr.rst          |   0
 .../{ =3D> arch}/powerpc/eeh-pci-error-recovery.rst  |   0
 Documentation/{ =3D> arch}/powerpc/elf_hwcaps.rst    |   6 +-
 Documentation/{ =3D> arch}/powerpc/elfnote.rst       |   0
 Documentation/{ =3D> arch}/powerpc/features.rst      |   0
 .../{ =3D> arch}/powerpc/firmware-assisted-dump.rst  |   0
 Documentation/{ =3D> arch}/powerpc/hvcs.rst          |   0
 Documentation/{ =3D> arch}/powerpc/imc.rst           |   0
 Documentation/{ =3D> arch}/powerpc/index.rst         |   0
 Documentation/{ =3D> arch}/powerpc/isa-versions.rst  |   0
 Documentation/{ =3D> arch}/powerpc/kasan.txt         |   0
 Documentation/{ =3D> arch}/powerpc/kaslr-booke32.rst |   0
 Documentation/{ =3D> arch}/powerpc/mpc52xx.rst       |   0
 Documentation/{ =3D> arch}/powerpc/papr_hcalls.rst   |   0
 .../powerpc/pci_iov_resource_on_powernv.rst        |   0
 Documentation/{ =3D> arch}/powerpc/pmu-ebb.rst       |   0
 Documentation/{ =3D> arch}/powerpc/ptrace.rst        |   0
 Documentation/{ =3D> arch}/powerpc/qe_firmware.rst   |   0
 Documentation/{ =3D> arch}/powerpc/syscall64-abi.rst |   0
 .../{ =3D> arch}/powerpc/transactional_memory.rst    |   0
 Documentation/{ =3D> arch}/powerpc/ultravisor.rst    |   0
 Documentation/{ =3D> arch}/powerpc/vas-api.rst       |   0
 .../{ =3D> arch}/powerpc/vcpudispatch_stats.rst      |   0
 Documentation/{ =3D> arch}/powerpc/vmemmap_dedup.rst |   0
 Documentation/{ =3D> arch}/riscv/acpi.rst            |   0
 .../{ =3D> arch}/riscv/boot-image-header.rst         |   0
 Documentation/{ =3D> arch}/riscv/boot.rst            |   0
 Documentation/{ =3D> arch}/riscv/features.rst        |   0
 Documentation/{ =3D> arch}/riscv/hwprobe.rst         |   0
 Documentation/{ =3D> arch}/riscv/index.rst           |   0
 .../{ =3D> arch}/riscv/patch-acceptance.rst          |   0
 Documentation/{ =3D> arch}/riscv/uabi.rst            |   0
 Documentation/{ =3D> arch}/riscv/vector.rst          |   0
 Documentation/{ =3D> arch}/riscv/vm-layout.rst       |   0
 Documentation/block/blk-mq.rst                     |   2 +-
 Documentation/doc-guide/contributing.rst           |   4 +
 Documentation/driver-api/driver-model/devres.rst   |  14 +-
 Documentation/driver-api/pps.rst                   |  16 +-
 Documentation/driver-api/pwm.rst                   |   6 +-
 .../filesystems/xfs-online-fsck-design.rst         |   2 +-
 .../maintainer/maintainer-entry-profile.rst        |   2 +-
 Documentation/mm/overcommit-accounting.rst         |   3 +-
 Documentation/mm/page_tables.rst                   | 127 ++++
 Documentation/mm/vmemmap_dedup.rst                 |   2 +-
 Documentation/process/backporting.rst              | 604 +++++++++++++++++
 Documentation/process/index.rst                    |   3 +-
 Documentation/process/submitting-patches.rst       |  10 +-
 Documentation/security/index.rst                   |   1 +
 Documentation/security/snp-tdx-threat-model.rst    | 253 +++++++
 Documentation/sphinx/cdomain.py                    |   4 +-
 Documentation/sphinx/kernel_abi.py                 |   2 +-
 Documentation/sphinx/kernel_feat.py                |   2 +-
 Documentation/sphinx/kerneldoc.py                  |   4 +-
 Documentation/sphinx/kfigure.py                    |   2 +-
 Documentation/sphinx/maintainers_include.py        |   8 +-
 Documentation/subsystem-apis.rst                   |   2 +-
 .../translations/it_IT/riscv/patch-acceptance.rst  |   2 +-
 .../sp_SP/process/embargoed-hardware-issues.rst    | 341 ++++++++++
 Documentation/translations/sp_SP/process/index.rst |   2 +
 .../translations/sp_SP/process/security-bugs.rst   | 103 +++
 Documentation/translations/zh_CN/arch/index.rst    |   2 +-
 .../zh_CN/{ =3D> arch}/riscv/boot-image-header.rst   |   4 +-
 .../translations/zh_CN/{ =3D> arch}/riscv/index.rst  |   4 +-
 .../zh_CN/{ =3D> arch}/riscv/patch-acceptance.rst    |   4 +-
 .../zh_CN/{ =3D> arch}/riscv/vm-layout.rst           |   4 +-
 Documentation/translations/zh_CN/index.rst         |   5 +-
 .../zh_CN/maintainer/maintainer-entry-profile.rst  |   2 +-
 .../translations/zh_CN/subsystem-apis.rst          | 110 +++
 .../translations/zh_TW/admin-guide/README.rst      | 164 ++---
 .../translations/zh_TW/admin-guide/bootconfig.rst  | 294 ++++++++
 .../translations/zh_TW/admin-guide/bug-bisect.rst  |  10 +-
 .../translations/zh_TW/admin-guide/bug-hunting.rst |  38 +-
 .../zh_TW/admin-guide/clearing-warn-once.rst       |   4 +-
 .../translations/zh_TW/admin-guide/cpu-load.rst    |   8 +-
 .../translations/zh_TW/admin-guide/cputopology.rst |  97 +++
 .../translations/zh_TW/admin-guide/index.rst       | 137 ++--
 .../translations/zh_TW/admin-guide/init.rst        |  36 +-
 .../zh_TW/admin-guide/lockup-watchdogs.rst         |  67 ++
 .../zh_TW/admin-guide/mm/damon/index.rst           |  30 +
 .../zh_TW/admin-guide/mm/damon/lru_sort.rst        | 264 ++++++++
 .../zh_TW/admin-guide/mm/damon/reclaim.rst         | 229 +++++++
 .../zh_TW/admin-guide/mm/damon/start.rst           | 125 ++++
 .../zh_TW/admin-guide/mm/damon/usage.rst           | 592 ++++++++++++++++
 .../translations/zh_TW/admin-guide/mm/index.rst    |  50 ++
 .../translations/zh_TW/admin-guide/mm/ksm.rst      | 199 ++++++
 .../zh_TW/admin-guide/reporting-issues.rst         | 727 ++++++++++-------=
---
 .../zh_TW/admin-guide/reporting-regressions.rst    | 371 ++++++++++
 .../zh_TW/admin-guide/security-bugs.rst            |  26 +-
 .../translations/zh_TW/admin-guide/sysrq.rst       | 281 ++++++++
 .../zh_TW/admin-guide/tainted-kernels.rst          |  84 +--
 .../translations/zh_TW/admin-guide/unicode.rst     |  10 +-
 Documentation/translations/zh_TW/arch/arm/Booting  | 176 +++++
 .../zh_TW/arch/arm/kernel_user_helpers.txt         | 285 ++++++++
 .../translations/zh_TW/arch/arm64/amu.rst          |   6 +-
 .../translations/zh_TW/arch/arm64/booting.txt      |  28 +-
 .../translations/zh_TW/arch/arm64/elf_hwcaps.rst   |  10 +-
 .../zh_TW/arch/arm64/legacy_instructions.txt       |  14 +-
 .../translations/zh_TW/arch/arm64/memory.txt       |  16 +-
 .../translations/zh_TW/arch/arm64/perf.rst         |   2 +-
 .../zh_TW/arch/arm64/silicon-errata.txt            |  28 +-
 .../zh_TW/arch/arm64/tagged-pointers.txt           |  10 +-
 Documentation/translations/zh_TW/arch/index.rst    |  29 +
 .../translations/zh_TW/arch/loongarch/booting.rst  |  49 ++
 .../translations/zh_TW/arch/loongarch/features.rst |   9 +
 .../translations/zh_TW/arch/loongarch/index.rst    |  28 +
 .../zh_TW/arch/loongarch/introduction.rst          | 354 ++++++++++
 .../zh_TW/arch/loongarch/irq-chip-model.rst        | 158 +++++
 .../translations/zh_TW/arch/mips/booting.rst       |  35 +
 .../translations/zh_TW/arch/mips/features.rst      |  14 +
 .../translations/zh_TW/arch/mips/index.rst         |  30 +
 .../translations/zh_TW/arch/mips/ingenic-tcu.rst   |  73 ++
 .../translations/zh_TW/arch/openrisc/index.rst     |  33 +
 .../zh_TW/arch/openrisc/openrisc_port.rst          | 128 ++++
 .../translations/zh_TW/arch/openrisc/todo.rst      |  24 +
 .../translations/zh_TW/arch/parisc/debugging.rst   |  46 ++
 .../translations/zh_TW/arch/parisc/index.rst       |  32 +
 .../translations/zh_TW/arch/parisc/registers.rst   | 157 +++++
 Documentation/translations/zh_TW/cpu-freq/core.rst |  38 +-
 .../translations/zh_TW/cpu-freq/cpu-drivers.rst    | 158 ++---
 .../translations/zh_TW/cpu-freq/cpufreq-stats.rst  |  52 +-
 .../translations/zh_TW/cpu-freq/index.rst          |  13 +-
 .../translations/zh_TW/dev-tools/gcov.rst          | 265 ++++++++
 .../zh_TW/dev-tools/gdb-kernel-debugging.rst       | 168 +++++
 .../translations/zh_TW/dev-tools/index.rst         |  43 ++
 .../translations/zh_TW/dev-tools/kasan.rst         | 463 +++++++++++++
 .../zh_TW/{sparse.txt =3D> dev-tools/sparse.rst}     |   4 +-
 .../zh_TW/dev-tools/testing-overview.rst           | 162 +++++
 .../translations/zh_TW/filesystems/debugfs.rst     |  47 +-
 .../translations/zh_TW/filesystems/index.rst       |   2 +-
 .../translations/zh_TW/filesystems/sysfs.txt       |  14 +-
 .../translations/zh_TW/filesystems/tmpfs.rst       |  35 +-
 .../translations/zh_TW/filesystems/virtiofs.rst    |   9 +-
 Documentation/translations/zh_TW/index.rst         |   7 +-
 .../translations/zh_TW/process/1.Intro.rst         |  78 +--
 .../translations/zh_TW/process/2.Process.rst       | 130 ++--
 .../translations/zh_TW/process/3.Early-stage.rst   |  44 +-
 .../translations/zh_TW/process/4.Coding.rst        | 104 +--
 .../translations/zh_TW/process/5.Posting.rst       |  80 +--
 .../translations/zh_TW/process/6.Followthrough.rst |  46 +-
 .../zh_TW/process/7.AdvancedTopics.rst             |  56 +-
 .../translations/zh_TW/process/8.Conclusion.rst    |  14 +-
 .../process/code-of-conduct-interpretation.rst     |  52 +-
 .../translations/zh_TW/process/code-of-conduct.rst |  18 +-
 .../translations/zh_TW/process/coding-style.rst    | 405 +++++++----
 .../zh_TW/process/development-process.rst          |   2 +-
 .../translations/zh_TW/process/email-clients.rst   | 279 +++++---
 .../zh_TW/process/embargoed-hardware-issues.rst    |  76 +--
 Documentation/translations/zh_TW/process/index.rst |   5 +-
 .../zh_TW/process/kernel-driver-statement.rst      |   2 +-
 .../translations/zh_TW/process/license-rules.rst   |  54 +-
 .../zh_TW/process/management-style.rst             |  60 +-
 .../zh_TW/process/stable-api-nonsense.rst          |  86 +--
 .../zh_TW/process/stable-kernel-rules.rst          |  36 +-
 .../zh_TW/process/submit-checklist.rst             |  92 +--
 .../zh_TW/process/submitting-patches.rst           | 749 ++++++++++-------=
----
 .../zh_TW/process/volatile-considered-harmful.rst  |  32 +-
 Documentation/usb/gadget_uvc.rst                   |   2 +-
 MAINTAINERS                                        |  16 +-
 arch/powerpc/kernel/exceptions-64s.S               |   6 +-
 arch/powerpc/kernel/paca.c                         |   2 +-
 arch/powerpc/kvm/book3s_64_entry.S                 |   2 +-
 arch/riscv/include/uapi/asm/hwprobe.h              |   2 +-
 arch/riscv/kernel/sys_riscv.c                      |   2 +-
 drivers/soc/fsl/qe/qe.c                            |   2 +-
 drivers/tty/hvc/hvcs.c                             |   2 +-
 include/soc/fsl/qe/qe.h                            |   2 +-
 kernel/fork.c                                      |  15 +-
 scripts/kernel-doc                                 |   2 +-
 190 files changed, 9293 insertions(+), 2168 deletions(-)
 rename Documentation/{ =3D> arch}/powerpc/associativity.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/booting.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/bootwrapper.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/cpu_families.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/cpu_features.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/cxl.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/cxlflash.rst (99%)
 rename Documentation/{ =3D> arch}/powerpc/dawr-power9.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/dexcr.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/dscr.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/eeh-pci-error-recovery.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/elf_hwcaps.rst (97%)
 rename Documentation/{ =3D> arch}/powerpc/elfnote.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/features.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/firmware-assisted-dump.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/hvcs.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/imc.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/index.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/isa-versions.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/kasan.txt (100%)
 rename Documentation/{ =3D> arch}/powerpc/kaslr-booke32.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/mpc52xx.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/papr_hcalls.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/pci_iov_resource_on_powernv.rst =
(100%)
 rename Documentation/{ =3D> arch}/powerpc/pmu-ebb.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/ptrace.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/qe_firmware.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/syscall64-abi.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/transactional_memory.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/ultravisor.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/vas-api.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/vcpudispatch_stats.rst (100%)
 rename Documentation/{ =3D> arch}/powerpc/vmemmap_dedup.rst (100%)
 rename Documentation/{ =3D> arch}/riscv/acpi.rst (100%)
 rename Documentation/{ =3D> arch}/riscv/boot-image-header.rst (100%)
 rename Documentation/{ =3D> arch}/riscv/boot.rst (100%)
 rename Documentation/{ =3D> arch}/riscv/features.rst (100%)
 rename Documentation/{ =3D> arch}/riscv/hwprobe.rst (100%)
 rename Documentation/{ =3D> arch}/riscv/index.rst (100%)
 rename Documentation/{ =3D> arch}/riscv/patch-acceptance.rst (100%)
 rename Documentation/{ =3D> arch}/riscv/uabi.rst (100%)
 rename Documentation/{ =3D> arch}/riscv/vector.rst (100%)
 rename Documentation/{ =3D> arch}/riscv/vm-layout.rst (100%)
 create mode 100644 Documentation/process/backporting.rst
 create mode 100644 Documentation/security/snp-tdx-threat-model.rst
 create mode 100644 Documentation/translations/sp_SP/process/embargoed-hard=
ware-issues.rst
 create mode 100644 Documentation/translations/sp_SP/process/security-bugs.=
rst
 rename Documentation/translations/zh_CN/{ =3D> arch}/riscv/boot-image-head=
er.rst (96%)
 rename Documentation/translations/zh_CN/{ =3D> arch}/riscv/index.rst (79%)
 rename Documentation/translations/zh_CN/{ =3D> arch}/riscv/patch-acceptanc=
e.rst (93%)
 rename Documentation/translations/zh_CN/{ =3D> arch}/riscv/vm-layout.rst (=
98%)
 create mode 100644 Documentation/translations/zh_CN/subsystem-apis.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/bootconfig=
.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/cputopolog=
y.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/lockup-wat=
chdogs.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/mm/damon/i=
ndex.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/mm/damon/l=
ru_sort.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/mm/damon/r=
eclaim.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/mm/damon/s=
tart.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/mm/damon/u=
sage.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/mm/index.r=
st
 create mode 100644 Documentation/translations/zh_TW/admin-guide/mm/ksm.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/reporting-=
regressions.rst
 create mode 100644 Documentation/translations/zh_TW/admin-guide/sysrq.rst
 create mode 100644 Documentation/translations/zh_TW/arch/arm/Booting
 create mode 100644 Documentation/translations/zh_TW/arch/arm/kernel_user_h=
elpers.txt
 create mode 100644 Documentation/translations/zh_TW/arch/index.rst
 create mode 100644 Documentation/translations/zh_TW/arch/loongarch/booting=
.rst
 create mode 100644 Documentation/translations/zh_TW/arch/loongarch/feature=
s.rst
 create mode 100644 Documentation/translations/zh_TW/arch/loongarch/index.r=
st
 create mode 100644 Documentation/translations/zh_TW/arch/loongarch/introdu=
ction.rst
 create mode 100644 Documentation/translations/zh_TW/arch/loongarch/irq-chi=
p-model.rst
 create mode 100644 Documentation/translations/zh_TW/arch/mips/booting.rst
 create mode 100644 Documentation/translations/zh_TW/arch/mips/features.rst
 create mode 100644 Documentation/translations/zh_TW/arch/mips/index.rst
 create mode 100644 Documentation/translations/zh_TW/arch/mips/ingenic-tcu.=
rst
 create mode 100644 Documentation/translations/zh_TW/arch/openrisc/index.rst
 create mode 100644 Documentation/translations/zh_TW/arch/openrisc/openrisc=
_port.rst
 create mode 100644 Documentation/translations/zh_TW/arch/openrisc/todo.rst
 create mode 100644 Documentation/translations/zh_TW/arch/parisc/debugging.=
rst
 create mode 100644 Documentation/translations/zh_TW/arch/parisc/index.rst
 create mode 100644 Documentation/translations/zh_TW/arch/parisc/registers.=
rst
 create mode 100644 Documentation/translations/zh_TW/dev-tools/gcov.rst
 create mode 100644 Documentation/translations/zh_TW/dev-tools/gdb-kernel-d=
ebugging.rst
 create mode 100644 Documentation/translations/zh_TW/dev-tools/index.rst
 create mode 100644 Documentation/translations/zh_TW/dev-tools/kasan.rst
 rename Documentation/translations/zh_TW/{sparse.txt =3D> dev-tools/sparse.=
rst} (98%)
 create mode 100644 Documentation/translations/zh_TW/dev-tools/testing-over=
view.rst
