Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDF078B571
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjH1Qht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjH1Qhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:37:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD12F110
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:37:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CDFE61711
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 16:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966E6C433C8;
        Mon, 28 Aug 2023 16:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693240653;
        bh=RjeeNZcoYaUaFojWabGXKfbijXpq0OebXOr7vZpZFU4=;
        h=Date:From:To:Cc:Subject:From;
        b=Jag9+BNYpngfSD+sl4JKMTO1ReaRpDvV/mj/vGVlRBuFBJRulbhWZteirICOWOTzt
         pUOr5zYpPEyIk6LBpaMcYgnuyyo1DnCePINahORf7Pyrgii2E5z/8Cxb6qgukAm/Vg
         0GHdly/YF89jeHpD3ZhqTSiVJJIs8hf+cVmRcUMhsYEuUd6FRB46okrYal7P6l7vFZ
         LIKKMnBUDVaQ0APgTL34U3qhczJr09AKjE1/H2NwAWaDc4CrfHzLf8UTQH/AGdFF0A
         DETdvNCh5JaF5RdgglXqDwqOiXhybOCmEow6VyOgUy/tRs8QJ29wsNhqvyIi8dwTiH
         +hXXgpAlLqlcQ==
Date:   Mon, 28 Aug 2023 17:37:24 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 updates for 6.6
Message-ID: <20230828163723.GB27321@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 updates for 6.6.

I think we have a bit less than usual on the architecture side, but
that's somewhat balanced out by a large crop of perf/PMU driver updates
and extensions to our selftests. Summary in the tag.

Cheers,

Will

--->8

The following changes since commit 6eaae198076080886b9e7d57f4ae06fa782f90ef:

  Linux 6.5-rc3 (2023-07-23 15:24:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to e1df27213941725962f68c64349bbcc60ece0314:

  Merge branch 'for-next/selftests' into for-next/core (2023-08-25 12:36:57 +0100)

----------------------------------------------------------------
arm64 updates for 6.6

CPU features and system registers:
	* Advertise hinted conditional branch support (FEAT_HBC) to
	  userspace

	* Avoid false positive "SANITY CHECK" warning when xCR registers
	  differ outside of the length field

Documentation:
	* Fix macro name typo in SME documentation

Entry code:
	* Unmask exceptions earlier on the system call entry path

Memory management:
	* Don't bother clearing PTE_RDONLY for dirty ptes in
	  pte_wrprotect() and pte_modify()

Perf and PMU drivers:
	* Initial support for Coresight TRBE devices on ACPI systems (the
	  coresight driver changes will come later)

	* Fix hw_breakpoint single-stepping when called from bpf

	* Fixes for DDR PMU on i.MX8MP SoC

	* Add NUMA-awareness to Hisilicon PCIe PMU driver

	* Fix locking dependency issue in Arm DMC620 PMU driver

	* Workaround Hisilicon erratum 162001900 in the SMMUv3 PMU driver

	* Add support for Arm CMN-700 r3 parts to the CMN PMU driver

	* Add support for recent Arm Cortex CPU PMUs

	* Update Hisilicon PMU maintainers

Selftests:
	* Add a bunch of new features to the hwcap test (JSCVT, PMULL,
	  AES, SHA1, etc)

	* Fix SSVE test to leave streaming-mode after grabbing the
	  signal context

	* Add new test for SVE vector-length changes with SME enabled

Miscellaneous:
	* Allow compiler to warn on suspicious looking system register
	  expressions

	* Work around SDEI firmware bug by aborting any running
	  handlers on a kernel crash

	* Fix some harmless warnings when building with W=1

	* Remove some unused function declarations

	* Other minor fixes and cleanup

----------------------------------------------------------------
Andre Przywara (1):
      kselftest/arm64: build BTI tests in output directory

Anshuman Khandual (7):
      arm64/mm: Replace an open coding with ID_AA64MMFR1_EL1_HAFDBS_MASK
      arm64/mm: Directly use ID_AA64MMFR2_EL1_VARange_MASK
      arm64/mm: Add pte_rdonly() helper
      arm64/mm: Set only the PTE_DIRTY bit while preserving the HW dirty state
      perf: pmuv3: Remove comments from armv8pmu_[enable|disable]_event()
      arm_pmu: acpi: Refactor arm_spe_acpi_register_device()
      arm_pmu: acpi: Add a representative platform device for TRBE

Christophe JAILLET (1):
      arm64/ptrace: Clean up error handling path in sve_set_common()

D Scott Phillips (1):
      arm64: sdei: abort running SDEI handlers during crash

David Spickett (1):
      Documentation: arm64: Correct SME ZA macros name

Ding Xiang (1):
      kselftest/arm64: fix a memleak in zt_regs_run()

James Clark (1):
      arm64: sysreg: Generate C compiler warnings on {read,write}_sysreg_s arguments

Jijie Shao (1):
      drivers/perf: hisi: Update HiSilicon PMU maintainers

Jing Zhang (1):
      driver/perf: Add identifier sysfs file for Yitian 710 DDR

Jisheng Zhang (1):
      arm64: vdso: remove two .altinstructions related symbols

Joey Gouly (2):
      arm64: add HWCAP for FEAT_HBC (hinted conditional branches)
      selftests/arm64: add HWCAP2_HBC test

Justin Stitt (1):
      arm64/sysreg: refactor deprecated strncpy

Mark Brown (12):
      arm64/cpufeature: Use ARM64_CPUID_FIELD() to match EVT
      kselftest/arm64: Add a test case for SVE VL changes with SME active
      kselftest/arm64: Validate that changing one VL type does not affect another
      kselftest/arm64: Exit streaming mode after collecting signal context
      tools compiler.h: Add OPTIMIZER_HIDE_VAR()
      tools include: Add some common function attributes
      kselftest/arm64: Make the tools/include headers available
      kselftest/arm64: Use shared OPTIMZER_HIDE_VAR() definiton
      kselftest/arm64: Use the tools/include compiler.h rather than our own
      arm64/fpsimd: Only provide the length to cpufeature for xCR registers
      kselftest/arm64: Size sycall-abi buffers for the actual maximum VL
      kselftest/arm64: Fix hwcaps selftest build

Mark Rutland (1):
      arm64: syscall: unmask DAIF earlier for SVCs

Rob Herring (5):
      arm64: errata: Group all Cortex-A510 errata together
      dt-bindings: arm: pmu: Add Cortex A520, A715, A720, X3, and X4
      perf: pmuv3: Add Cortex A520, A715, A720, X3 and X4 PMUs
      drivers/perf: Explicitly include correct DT includes
      arm64: Explicitly include correct DT includes

Robin Murphy (3):
      perf/arm-cmn: Remove spurious event aliases
      perf/arm-cmn: Refactor HN-F event selector macros
      perf/arm-cmn: Add CMN-700 r3 support

Tomislav Novak (1):
      hw_breakpoint: fix single-stepping when using bpf_overflow_handler

Vincent Whitchurch (1):
      perf/smmuv3: Remove build dependency on ACPI

Waiman Long (1):
      perf/arm-dmc620: Fix dmc620_pmu_irqs_lock/cpu_hotplug_lock circular lock dependency

Will Deacon (8):
      Merge branch 'for-next/cpufeature' into for-next/core
      Merge branch 'for-next/docs' into for-next/core
      Merge branch 'for-next/entry' into for-next/core
      Merge branch 'for-next/errata' into for-next/core
      Merge branch 'for-next/misc' into for-next/core
      Merge branch 'for-next/mm' into for-next/core
      Merge branch 'for-next/perf' into for-next/core
      Merge branch 'for-next/selftests' into for-next/core

Xu Yang (2):
      perf/imx_ddr: speed up overflow frequency of cycle
      perf/imx_ddr: don't enable counter0 if none of 4 counters are used

Yangtao Li (1):
      perf: xgene_pmu: Convert to devm_platform_ioremap_resource()

Yicong Yang (3):
      perf/smmuv3: Enable HiSilicon Erratum 162001900 quirk for HIP08/09
      perf/smmuv3: Add MODULE_ALIAS for module auto loading
      drivers/perf: hisi: Schedule perf session according to locality

YueHaibing (1):
      arm64: Remove unsued extern declaration init_mem_pgprot()

Zeng Heng (11):
      arm64/Kconfig: Sort the RCpc feature under the ARMv8.3 features menu
      kselftest/arm64: add RCpc load-acquire to hwcap test
      kselftest/arm64: add float-point feature to hwcap test
      kselftest/arm64: add crc32 feature to hwcap test
      kselftest/arm64: add DEF_SIGHANDLER_FUNC() and DEF_INST_RAISE_SIG() helpers
      kselftest/arm64: add test item that support to capturing the SIGBUS signal
      kselftest/arm64: add lse and lse2 features to hwcap test
      kselftest/arm64: add SHA1 and related features to hwcap test
      kselftest/arm64: add AES feature check to hwcap test
      kselftest/arm64: add pmull feature to hwcap test
      kselftest/arm64: add jscvt feature to hwcap test

Zhang Jianhua (1):
      arm64: fix build warning for ARM64_MEMSTART_SHIFT

 Documentation/arch/arm64/silicon-errata.rst        |  19 +-
 Documentation/arch/arm64/sme.rst                   |   2 +-
 Documentation/devicetree/bindings/arm/pmu.yaml     |   5 +
 MAINTAINERS                                        |   4 +-
 arch/arm/kernel/hw_breakpoint.c                    |   8 +-
 arch/arm64/Kconfig                                 |   6 +-
 arch/arm64/include/asm/acpi.h                      |   3 +
 arch/arm64/include/asm/hwcap.h                     |   1 +
 arch/arm64/include/asm/kernel-pgtable.h            |  27 --
 arch/arm64/include/asm/mmu.h                       |   1 -
 arch/arm64/include/asm/pgtable.h                   |   8 +-
 arch/arm64/include/asm/sdei.h                      |   6 +
 arch/arm64/include/asm/sysreg.h                    |   6 +
 arch/arm64/include/uapi/asm/hwcap.h                |   1 +
 arch/arm64/kernel/cpufeature.c                     |   9 +-
 arch/arm64/kernel/cpuidle.c                        |   2 -
 arch/arm64/kernel/cpuinfo.c                        |   1 +
 arch/arm64/kernel/entry-common.c                   |  32 ++
 arch/arm64/kernel/entry.S                          |  27 +-
 arch/arm64/kernel/fpsimd.c                         |  22 +-
 arch/arm64/kernel/head.S                           |   4 +-
 arch/arm64/kernel/hw_breakpoint.c                  |   4 +-
 arch/arm64/kernel/idreg-override.c                 |   6 +-
 arch/arm64/kernel/pci.c                            |   2 -
 arch/arm64/kernel/ptrace.c                         |   3 +-
 arch/arm64/kernel/sdei.c                           |   3 +
 arch/arm64/kernel/smp.c                            |   8 +-
 arch/arm64/kernel/syscall.c                        |  33 ---
 arch/arm64/kernel/vdso/vdso.lds.S                  |   2 -
 arch/arm64/mm/init.c                               |  27 ++
 arch/arm64/mm/proc.S                               |   2 +-
 drivers/acpi/arm64/iort.c                          |   5 +-
 drivers/firmware/arm_sdei.c                        |  19 ++
 drivers/perf/Kconfig                               |   2 +-
 drivers/perf/alibaba_uncore_drw_pmu.c              |  27 ++
 drivers/perf/amlogic/meson_ddr_pmu_core.c          |   2 -
 drivers/perf/arm-cci.c                             |   5 +-
 drivers/perf/arm-cmn.c                             | 163 +++++++++--
 drivers/perf/arm_dmc620_pmu.c                      |  19 +-
 drivers/perf/arm_dsu_pmu.c                         |   2 +-
 drivers/perf/arm_pmu_acpi.c                        | 139 ++++++---
 drivers/perf/arm_pmu_platform.c                    |   1 -
 drivers/perf/arm_pmuv3.c                           |  33 +--
 drivers/perf/arm_smmuv3_pmu.c                      |  47 ++-
 drivers/perf/arm_spe_pmu.c                         |   3 +-
 drivers/perf/fsl_imx8_ddr_perf.c                   |  48 +--
 drivers/perf/fsl_imx9_ddr_perf.c                   |   4 +-
 drivers/perf/hisilicon/hisi_pcie_pmu.c             |  17 +-
 drivers/perf/marvell_cn10k_ddr_pmu.c               |   3 +-
 drivers/perf/marvell_cn10k_tad_pmu.c               |   3 +-
 drivers/perf/xgene_pmu.c                           |   4 +-
 include/linux/acpi_iort.h                          |   1 +
 include/linux/arm_sdei.h                           |   2 +
 include/linux/perf/arm_pmu.h                       |   1 +
 include/linux/perf_event.h                         |  22 +-
 tools/include/linux/compiler.h                     |  18 ++
 tools/testing/selftests/arm64/Makefile             |   2 +
 tools/testing/selftests/arm64/abi/hwcap.c          | 321 +++++++++++++++++----
 tools/testing/selftests/arm64/abi/syscall-abi.c    |  38 ++-
 tools/testing/selftests/arm64/bti/Makefile         |  45 ++-
 tools/testing/selftests/arm64/bti/compiler.h       |  21 --
 tools/testing/selftests/arm64/bti/gen/.gitignore   |   2 -
 tools/testing/selftests/arm64/bti/system.c         |   4 +-
 tools/testing/selftests/arm64/bti/system.h         |   4 +-
 tools/testing/selftests/arm64/bti/test.c           |   1 -
 tools/testing/selftests/arm64/fp/vec-syscfg.c      | 127 +++++++-
 .../selftests/arm64/signal/test_signals_utils.h    |  27 +-
 .../selftests/arm64/signal/testcases/zt_regs.c     |   1 +
 68 files changed, 1074 insertions(+), 393 deletions(-)
 delete mode 100644 tools/testing/selftests/arm64/bti/compiler.h
 delete mode 100644 tools/testing/selftests/arm64/bti/gen/.gitignore
