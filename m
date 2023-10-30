Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CB57DBAE1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 14:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbjJ3Neb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 09:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbjJ3Ne2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 09:34:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1E3C9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 06:34:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADAEC433C9;
        Mon, 30 Oct 2023 13:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698672861;
        bh=FXboULI/1x9YAqPhskDxjqq/CXEB+1FqZkIvh/wWSYU=;
        h=From:To:Cc:Subject:Date:From;
        b=rtAFRTafZGu5ssGF5alkl2dt9/6lkpJKdQXHJRiYcO6xICcj2NiRMrayPrmYEDa4F
         1NJhfd5aDL5xMczarv7WBdZkn4zx/dfZHxuCIjla3ujVaTDupZbFZ5RuvtEycK5IOg
         ndjLGQzmhQUx9mYkiq5LOnX1TJyXSbIY+bxiVpbDq8smG6oG3FrHpaQts1toGXGt+K
         oxlEXAWBmShoHsSSPqkxyLUy7UfuwpD96+U60+XZqvvdeD9hlTpbym7dcXQRTaFzml
         0D5YTTzUKPwyvj1StN0Fotqo2/ELm/E2O+qqrM9eyaVwccc/t5R4JFHgvi1ospB2+v
         FRpvNvyR4qZnQ==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v6.7
Date:   Mon, 30 Oct 2023 13:34:10 +0000
Message-Id: <20231030133419.EADAEC433C9@smtp.kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6e800968f6a715c0661716d2ec5e1f56ed9f9c08:

  regulator/core: Revert "fix kobject release warning and memory leak in regulator_register()" (2023-09-26 17:26:08 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.7

for you to fetch changes up to 3e0569ff812675e896cbdcbbaec10c99b544b947:

  regulator: Merge up pending fix (2023-10-30 13:14:27 +0000)

----------------------------------------------------------------
regulator: Updates for v6.7

This has been a fairly quiet release for the regulator API, the changes
are dominated by some new drivers and a quite large set of cleanups and
filling in the blanks of features for the existing MT6358 driver.

 - Cleanups and additional features for the Mediatek MT6358 driver.
 - Under voltage detection in the fixed regulator.
 - Support for Maxim MAX77503, Mediatek MT6366, Qualcomm PM8909, PM8919,
   PMA8048 and PMC8380.

----------------------------------------------------------------
Abel Vesa (1):
      regulator: qcom-rpmh: Fix smps4 regulator for pm8550ve

Biju Das (8):
      regulator: pv880x0: Drop ifdeffery
      regulator: pv880x0: Simplify probe()
      regulator: fan53555: Simplify probe()
      regulator: sy8824x: Make similar OF and ID table
      regulator: ltc3589: Convert enum->pointer for data in the match tables
      regulator: mp886x: Make similar OF and ID table
      regulator: max20086: Make similar OF and ID table
      regulator: mp5416: Make similar OF and ID table

Chen-Yu Tsai (12):
      regulator: mt6358: Fail probe on unknown chip ID
      regulator: mt6358: Add output voltage fine tuning to fixed regulators
      regulator: mt6358: Add output voltage fine tuning to variable LDOs
      regulator: dt-bindings: mt6358: Convert to DT schema
      regulator: dt-bindings: mt6358: Add regulator-allowed-modes property
      regulator: dt-bindings: mt6358: Add regulator supplies
      regulator: mt6358: Use mt6397-regulator.h binding header for buck mode macros
      regulator: mt6358: Add supply names for MT6358 regulators
      regulator: mt6358: fix and drop type prefix in MT6366 regulator node names
      regulator: mt6358: Make MT6366 vcn18 LDO configurable
      regulator: mt6358: Add missing regulators for MT6366
      regulator: mt6358: Add supply names for MT6366 regulators

Geert Uytterhoeven (1):
      dt-bindings: regulator: dlg,da9210: Convert to json-schema

Gokhan Celik (2):
      regulator: max77503: Add ADI MAX77503 support
      regulator: dt-bindings: Add ADI MAX77503 support

Kees Cook (3):
      regulator: mc13xxx: Annotate struct mc13xxx_regulator_priv with __counted_by
      regulator: da9062: Annotate struct da9062_regulators with __counted_by
      regulator: da9063: Annotate struct da9063_regulators with __counted_by

Linus Walleij (1):
      regulator: rk808: Drop useless headers

Mark Brown (3):
      Match data improvements for pv880x0 regulator
      regulator: mt6358: Remove bogus regulators and
      regulator: Merge up pending fix

Naresh Solanki (2):
      regulator (max5970): Add hwmon support
      regulator (max5970): Remove duplicate line

Oleksij Rempel (2):
      regulator: dt-bindings: fixed-regulator: Add under-voltage interrupt support
      regulator: fixed: add support for under-voltage IRQ

Rajendra Nayak (2):
      regulator: qcom-rpmh: Add regulators support for PMC8380
      regulator: qcom,rpmh: Add PMC8380 compatible

Rob Herring (4):
      regulator: dt-bindings: Add missing unevaluatedProperties on child node schemas
      regulator: Drop unnecessary of_match_device() calls
      regulator: da9121: Use i2c_get_match_data()
      regulator: Use device_get_match_data()

Stephan Gerhold (6):
      dt-bindings: regulator: qcom,spmi: Document PM8909
      regulator: qcom_spmi: Add PM8909 regulators
      dt-bindings: regulator: qcom,spmi: Document PM8019
      regulator: qcom_spmi: Add PM8019 regulators
      dt-bindings: regulator: qcom,spmi: Document PMA8084
      regulator: qcom_spmi: Add PMA8084 regulators

Zhiyong Tao (1):
      regulator: dt-bindings: mt6358: Add MT6366 PMIC

 Documentation/arch/arm64/cpu-feature-registers.rst |  12 +
 Documentation/arch/arm64/elf_hwcaps.rst            |   3 +
 Documentation/arch/loongarch/introduction.rst      |   4 +-
 .../bindings/regulator/adi,max77503-regulator.yaml |  50 +++
 .../devicetree/bindings/regulator/da9210.txt       |  29 --
 .../devicetree/bindings/regulator/dlg,da9210.yaml  |  52 +++
 .../bindings/regulator/fixed-regulator.yaml        |   5 +
 .../bindings/regulator/maxim,max20086.yaml         |   1 +
 .../bindings/regulator/maxim,max77826.yaml         |   2 +
 .../regulator/mediatek,mt6358-regulator.yaml       | 250 +++++++++++
 .../bindings/regulator/mt6358-regulator.txt        | 350 ---------------
 .../bindings/regulator/onnn,fan53880.yaml          |   2 +
 .../bindings/regulator/qcom,rpmh-regulator.yaml    |  12 +
 .../bindings/regulator/qcom,spmi-regulator.yaml    |  68 ++-
 Documentation/filesystems/btrfs.rst                |   1 -
 Documentation/networking/ax25.rst                  |   4 +-
 .../process/embargoed-hardware-issues.rst          |   1 +
 Documentation/sound/designs/midi-2.0.rst           |   4 +-
 .../zh_CN/arch/loongarch/introduction.rst          |   4 +-
 MAINTAINERS                                        |  38 +-
 Makefile                                           |   2 +-
 arch/arm/xen/enlighten.c                           |   2 +-
 arch/arm64/include/asm/cpufeature.h                |   2 +-
 arch/arm64/include/asm/kvm_hyp.h                   |   2 +-
 arch/arm64/kernel/cpufeature.c                     |   3 +-
 arch/arm64/kvm/hyp/include/nvhe/ffa.h              |   2 +-
 arch/arm64/kvm/hyp/nvhe/ffa.c                      |   3 +-
 arch/arm64/kvm/hyp/nvhe/hyp-init.S                 |   1 +
 arch/arm64/kvm/hyp/nvhe/hyp-main.c                 |   8 +-
 arch/arm64/kvm/hyp/nvhe/psci-relay.c               |   3 +-
 arch/arm64/kvm/mmu.c                               |   3 +
 arch/arm64/tools/sysreg                            |   6 +-
 arch/ia64/kernel/acpi.c                            |   4 +
 arch/loongarch/include/asm/addrspace.h             |  12 +-
 arch/loongarch/include/asm/exception.h             |  45 ++
 arch/loongarch/include/asm/kasan.h                 |  59 +--
 arch/loongarch/include/asm/smp.h                   |   1 +
 arch/loongarch/kernel/Makefile                     |   4 +
 arch/loongarch/kernel/acpi.c                       |   1 -
 arch/loongarch/kernel/mem.c                        |   4 +-
 arch/loongarch/kernel/module-sections.c            |   1 +
 arch/loongarch/kernel/process.c                    |   1 +
 arch/loongarch/kernel/relocate_kernel.S            |   1 -
 arch/loongarch/kernel/signal.c                     |   7 +-
 arch/loongarch/kernel/smp.c                        |   3 +
 arch/loongarch/kernel/syscall.c                    |   1 +
 arch/loongarch/kernel/time.c                       |   2 +-
 arch/loongarch/kernel/topology.c                   |   3 +
 arch/loongarch/kernel/traps.c                      |  25 +-
 arch/loongarch/kernel/vmlinux.lds.S                |  55 +--
 arch/loongarch/mm/fault.c                          |   2 +-
 arch/loongarch/mm/hugetlbpage.c                    |  12 -
 arch/loongarch/mm/ioremap.c                        |   1 +
 arch/loongarch/mm/kasan_init.c                     |  51 +++
 arch/loongarch/mm/tlb.c                            |   2 +-
 arch/parisc/include/asm/cache.h                    |   1 +
 arch/parisc/include/asm/mckinley.h                 |   8 -
 arch/parisc/include/asm/pdc.h                      |   5 +-
 arch/parisc/include/asm/processor.h                |   1 +
 arch/parisc/include/asm/ropes.h                    |   7 +-
 arch/parisc/include/asm/shmparam.h                 |  15 +
 arch/parisc/kernel/asm-offsets.c                   |   2 +
 arch/parisc/kernel/cache.c                         |   8 +-
 arch/parisc/kernel/drivers.c                       |   2 +-
 arch/parisc/kernel/firmware.c                      |  56 ++-
 arch/parisc/kernel/head.S                          |  16 +-
 arch/parisc/kernel/irq.c                           |   2 +-
 arch/parisc/kernel/processor.c                     |   2 +
 arch/parisc/kernel/vmlinux.lds.S                   |   1 +
 arch/parisc/mm/init.c                              |  72 +++
 arch/powerpc/Kconfig                               |   2 +-
 arch/powerpc/kernel/hw_breakpoint.c                |  16 +-
 arch/powerpc/kernel/hw_breakpoint_constraints.c    |   7 +-
 arch/powerpc/kernel/traps.c                        |  56 ++-
 arch/powerpc/perf/hv-24x7.c                        |   2 +-
 arch/powerpc/platforms/82xx/Kconfig                |   3 +-
 arch/riscv/include/asm/errata_list.h               |   4 +-
 arch/riscv/kernel/elf_kexec.c                      |   8 +-
 arch/riscv/kvm/vcpu_onereg.c                       |   7 +-
 arch/s390/configs/debug_defconfig                  |  14 +-
 arch/s390/configs/defconfig                        |  13 +-
 arch/s390/configs/zfcpdump_defconfig               |   4 +-
 arch/s390/kernel/cert_store.c                      |   7 +-
 arch/sh/mm/ioremap.c                               |   4 +-
 arch/x86/Kconfig                                   |   2 +-
 arch/x86/boot/compressed/ident_map_64.c            |   8 +
 arch/x86/entry/common.c                            |   2 +-
 arch/x86/include/asm/boot.h                        |  45 +-
 arch/x86/include/asm/efi.h                         |  32 +-
 arch/x86/include/asm/kvm_host.h                    |   3 +-
 arch/x86/include/asm/linkage.h                     |  15 +
 arch/x86/include/asm/mmu_context.h                 |   3 +-
 arch/x86/include/asm/paravirt_types.h              |  15 -
 arch/x86/include/asm/processor.h                   |   2 -
 arch/x86/include/asm/xen/hypervisor.h              |  37 ++
 arch/x86/kernel/alternative.c                      |   9 +-
 arch/x86/kernel/apic/x2apic_uv_x.c                 |  11 +-
 arch/x86/kernel/callthunks.c                       |   1 -
 arch/x86/kernel/cpu/amd.c                          |  28 +-
 arch/x86/kernel/cpu/bugs.c                         |  17 +-
 arch/x86/kernel/paravirt.c                         |  67 ---
 arch/x86/kernel/process.c                          |   7 -
 arch/x86/kernel/setup.c                            |   8 +-
 arch/x86/kernel/shstk.c                            |  33 +-
 arch/x86/kernel/smpboot.c                          |  12 +-
 arch/x86/kvm/mmu/mmu.c                             |  21 +-
 arch/x86/kvm/mmu/mmu_internal.h                    |  15 +-
 arch/x86/kvm/mmu/tdp_mmu.c                         | 152 +++----
 arch/x86/kvm/mmu/tdp_mmu.h                         |   5 +-
 arch/x86/kvm/svm/sev.c                             |  34 +-
 arch/x86/kvm/svm/svm.c                             |  43 +-
 arch/x86/kvm/svm/svm.h                             |   1 +
 arch/x86/kvm/x86.c                                 |   5 +-
 arch/x86/lib/memcpy_64.S                           |   2 +-
 arch/x86/lib/memmove_64.S                          |   2 +-
 arch/x86/lib/memset_64.S                           |   2 +-
 arch/x86/lib/putuser.S                             |   4 -
 arch/x86/platform/efi/efi_32.c                     |  12 +
 arch/x86/platform/efi/efi_64.c                     |  19 +-
 arch/x86/purgatory/Makefile                        |   4 +
 arch/x86/xen/efi.c                                 |   2 +-
 arch/x86/xen/enlighten.c                           |   2 +-
 arch/x86/xen/enlighten_hvm.c                       |   2 +-
 arch/x86/xen/enlighten_pv.c                        |  40 +-
 arch/x86/xen/mmu_pv.c                              |  55 ++-
 arch/x86/xen/multicalls.h                          |   4 +-
 block/blk-mq.c                                     |  13 +-
 crypto/sm2.c                                       |   6 +-
 drivers/Makefile                                   |   2 +-
 drivers/accel/ivpu/ivpu_hw_40xx.c                  |   9 +-
 drivers/acpi/processor_pdc.c                       |   1 +
 drivers/acpi/thermal.c                             |   2 +-
 drivers/ata/ahci.c                                 |   9 +
 drivers/ata/libahci.c                              |  35 +-
 drivers/ata/libata-core.c                          |   7 +-
 drivers/ata/libata-eh.c                            |  16 +-
 drivers/ata/libata-sata.c                          |  19 +-
 drivers/ata/pata_parport/comm.c                    |   9 +-
 drivers/ata/sata_mv.c                              |   4 +-
 drivers/base/core.c                                |   2 +
 drivers/char/agp/parisc-agp.c                      |   2 -
 drivers/char/tpm/tpm-chip.c                        |   2 +-
 drivers/comedi/Kconfig                             | 103 ++---
 drivers/cxl/acpi.c                                 |   4 +-
 drivers/cxl/core/mbox.c                            |  23 +-
 drivers/cxl/core/port.c                            |  13 +-
 drivers/cxl/core/region.c                          |  41 +-
 drivers/cxl/pci.c                                  |   7 +-
 drivers/firewire/core-device.c                     |   2 +-
 drivers/firewire/core-topology.c                   |   2 +-
 drivers/firmware/cirrus/cs_dsp.c                   |  34 +-
 drivers/firmware/efi/efi.c                         |  32 +-
 drivers/firmware/efi/libstub/unaccepted_memory.c   |   2 +-
 drivers/gpio/gpio-sim.c                            |  60 +--
 drivers/gpio/gpio-tb10x.c                          |   6 +-
 drivers/gpu/drm/Kconfig                            |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h  |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  26 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |  19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c            |  76 ++--
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c             |   3 +
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h              |   4 +
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c          |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c       |  34 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h       |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c   |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   |  43 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |  46 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |  77 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h          |   2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 119 ++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c  |  35 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   1 +
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |  34 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |   8 +-
 .../drm/amd/display/dc/dcn314/dcn314_resource.c    |  23 +
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c   |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |   1 +
 drivers/gpu/drm/amd/display/dc/link/link_factory.c |   4 +
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h    |   9 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |   2 +-
 drivers/gpu/drm/drm_connector.c                    |   2 +
 drivers/gpu/drm/drm_exec.c                         |   2 +-
 drivers/gpu/drm/i915/display/intel_bios.c          |  21 +
 drivers/gpu/drm/i915/display/intel_bios.h          |   1 +
 drivers/gpu/drm/i915/display/intel_dp.c            |   7 +-
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |   1 -
 .../gpu/drm/i915/gt/intel_execlists_submission.c   |   2 +
 drivers/gpu/drm/i915/gt/intel_lrc.c                |   5 +-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c         |   2 +
 drivers/gpu/drm/nouveau/nouveau_drv.h              |  19 +-
 drivers/gpu/drm/nouveau/nouveau_exec.c             |   2 +-
 drivers/gpu/drm/nouveau/nouveau_fence.c            |   2 +-
 drivers/gpu/drm/nouveau/nouveau_sched.c            |  12 +-
 drivers/gpu/drm/radeon/radeon_sa.c                 |   2 +-
 drivers/gpu/drm/tests/drm_mm_test.c                |   2 +-
 drivers/gpu/drm/tiny/gm12u320.c                    |  10 +-
 drivers/gpu/drm/virtio/virtgpu_submit.c            |   1 -
 drivers/gpu/drm/vkms/vkms_composer.c               |   9 +-
 drivers/gpu/drm/vkms/vkms_crtc.c                   |   9 +-
 drivers/gpu/drm/vkms/vkms_drv.h                    |   4 +-
 drivers/hwmon/nct6775-core.c                       |   4 +
 drivers/i2c/Kconfig                                |   2 +-
 drivers/i2c/busses/Kconfig                         |   4 +-
 drivers/i2c/busses/i2c-aspeed.c                    |   7 +-
 drivers/i2c/busses/i2c-cadence.c                   |   1 +
 drivers/i2c/busses/i2c-designware-common.c         |  17 +
 drivers/i2c/busses/i2c-designware-core.h           |   3 +
 drivers/i2c/busses/i2c-i801.c                      |   1 +
 drivers/i2c/busses/i2c-xiic.c                      |   2 +-
 drivers/i2c/muxes/i2c-demux-pinctrl.c              |   4 +
 drivers/i2c/muxes/i2c-mux-gpio.c                   |   4 +-
 drivers/md/dm-core.h                               |   1 +
 drivers/md/dm-ioctl.c                              |   7 +-
 drivers/md/dm-table.c                              |  32 +-
 drivers/md/dm.c                                    |  23 +-
 drivers/md/md.c                                    |  23 +-
 drivers/md/md.h                                    |   3 +
 drivers/md/raid1.c                                 |   3 +-
 drivers/media/common/videobuf2/frame_vector.c      |   6 +-
 drivers/media/i2c/imx219.c                         |  13 +-
 drivers/media/i2c/max9286.c                        |   1 -
 drivers/media/i2c/rdacm21.c                        |   1 -
 drivers/media/pci/bt8xx/bttv-risc.c                |   4 +-
 drivers/media/pci/intel/ivsc/Kconfig               |   5 +-
 drivers/media/platform/marvell/Kconfig             |   4 +-
 drivers/media/platform/nxp/imx-mipi-csis.c         |   2 -
 drivers/media/platform/via/Kconfig                 |   2 +-
 drivers/media/usb/em28xx/Kconfig                   |   4 +-
 drivers/media/usb/go7007/Kconfig                   |   2 +-
 drivers/media/usb/uvc/uvc_ctrl.c                   |   3 +
 drivers/mfd/cs42l43.c                              |   4 +-
 drivers/net/dsa/sja1105/sja1105.h                  |   2 +
 drivers/net/dsa/sja1105/sja1105_dynamic_config.c   |  93 ++--
 drivers/net/dsa/sja1105/sja1105_main.c             |  69 ++-
 drivers/net/ethernet/adi/adin1110.c                |   2 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |   3 +
 drivers/net/ethernet/broadcom/asp2/bcmasp.c        |  10 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp.h        |   4 +-
 .../net/ethernet/broadcom/asp2/bcmasp_ethtool.c    |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   5 +
 drivers/net/ethernet/cadence/macb_main.c           |   5 +-
 drivers/net/ethernet/engleder/tsnep_ethtool.c      |   6 +-
 drivers/net/ethernet/engleder/tsnep_main.c         |  18 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |   9 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |  13 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |   3 +-
 drivers/net/ethernet/huawei/hinic/hinic_port.c     |   3 -
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   8 +-
 drivers/net/ethernet/intel/iavf/iavf.h             |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  17 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   5 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |  31 +-
 drivers/net/ethernet/intel/igc/igc_main.c          |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c       |  28 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |   5 +
 .../net/ethernet/marvell/octeon_ep/octep_main.c    |   8 +-
 drivers/net/ethernet/marvell/octeon_ep/octep_tx.c  |   8 +-
 drivers/net/ethernet/marvell/octeon_ep/octep_tx.h  |  16 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c |   6 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h |   2 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   |  43 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |   3 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   7 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |  49 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.h |   4 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   8 +-
 drivers/net/ethernet/mediatek/mtk_ppe_offload.c    |   6 +-
 drivers/net/ethernet/microchip/vcap/vcap_api.c     |  18 +-
 .../net/ethernet/microchip/vcap/vcap_api_kunit.c   |  59 ++-
 drivers/net/ethernet/pensando/ionic/ionic_dev.h    |   1 +
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c   |  10 +-
 drivers/net/ethernet/renesas/rswitch.c             |  20 +-
 drivers/net/ethernet/renesas/rswitch.h             |   2 +
 drivers/net/ethernet/sfc/tc.c                      |  21 +-
 drivers/net/ethernet/sfc/tc_conntrack.c            |   7 +-
 drivers/net/ethernet/sfc/tc_counters.c             |   2 +
 drivers/net/ethernet/sfc/tc_encap_actions.c        |   4 +
 drivers/net/ethernet/stmicro/stmmac/common.h       |   7 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |  16 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |  16 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c    |  16 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c |  16 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   2 -
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  32 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 135 +++---
 drivers/net/ethernet/ti/Kconfig                    |   1 +
 drivers/net/team/team.c                            |  10 +-
 drivers/net/thunderbolt/main.c                     |   3 +-
 drivers/net/usb/r8152.c                            |   3 +
 drivers/net/veth.c                                 |   2 +
 drivers/net/vxlan/vxlan_core.c                     |   4 +
 drivers/nvme/host/core.c                           |  54 ++-
 drivers/nvme/host/fc.c                             |   2 +-
 drivers/nvme/host/hwmon.c                          |   2 +-
 drivers/nvme/host/pci.c                            |   3 -
 drivers/nvme/target/tcp.c                          |   2 +-
 drivers/parisc/ccio-dma.c                          |  18 +-
 drivers/parisc/iommu-helpers.h                     |   8 +-
 drivers/parisc/iosapic.c                           |   4 +-
 drivers/parisc/iosapic_private.h                   |   4 +-
 drivers/parisc/sba_iommu.c                         |  38 +-
 drivers/pci/pcie/aer.c                             |   1 +
 drivers/pci/pcie/portdrv.h                         |   2 -
 drivers/platform/mellanox/Kconfig                  |   5 +-
 drivers/platform/mellanox/mlxbf-pmc.c              |  41 +-
 drivers/platform/mellanox/mlxbf-tmfifo.c           |  90 +++-
 drivers/platform/x86/asus-nb-wmi.c                 |   9 +
 drivers/platform/x86/intel_scu_ipc.c               |  66 +--
 drivers/platform/x86/thinkpad_acpi.c               |   2 +
 drivers/{genpd => pmdomain}/Makefile               |   0
 drivers/{genpd => pmdomain}/actions/Makefile       |   0
 .../{genpd => pmdomain}/actions/owl-sps-helper.c   |   0
 drivers/{genpd => pmdomain}/actions/owl-sps.c      |   0
 drivers/{genpd => pmdomain}/amlogic/Makefile       |   0
 .../{genpd => pmdomain}/amlogic/meson-ee-pwrc.c    |   0
 .../amlogic/meson-gx-pwrc-vpu.c                    |   0
 .../amlogic/meson-secure-pwrc.c                    |   0
 drivers/{genpd => pmdomain}/apple/Makefile         |   0
 drivers/{genpd => pmdomain}/apple/pmgr-pwrstate.c  |   0
 drivers/{genpd => pmdomain}/bcm/Makefile           |   0
 drivers/{genpd => pmdomain}/bcm/bcm-pmb.c          |   0
 drivers/{genpd => pmdomain}/bcm/bcm2835-power.c    |   0
 drivers/{genpd => pmdomain}/bcm/bcm63xx-power.c    |   0
 .../{genpd => pmdomain}/bcm/raspberrypi-power.c    |   0
 drivers/{genpd => pmdomain}/imx/Makefile           |   0
 drivers/{genpd => pmdomain}/imx/gpc.c              |   0
 drivers/{genpd => pmdomain}/imx/gpcv2.c            |   0
 drivers/{genpd => pmdomain}/imx/imx8m-blk-ctrl.c   |   0
 drivers/{genpd => pmdomain}/imx/imx8mp-blk-ctrl.c  |   0
 drivers/{genpd => pmdomain}/imx/imx93-blk-ctrl.c   |   0
 drivers/{genpd => pmdomain}/imx/imx93-pd.c         |   0
 drivers/{genpd => pmdomain}/imx/scu-pd.c           |   0
 drivers/{genpd => pmdomain}/mediatek/Makefile      |   0
 .../mediatek/mt6795-pm-domains.h                   |   0
 .../mediatek/mt8167-pm-domains.h                   |   0
 .../mediatek/mt8173-pm-domains.h                   |   0
 .../mediatek/mt8183-pm-domains.h                   |   0
 .../mediatek/mt8186-pm-domains.h                   |   0
 .../mediatek/mt8188-pm-domains.h                   |   0
 .../mediatek/mt8192-pm-domains.h                   |   0
 .../mediatek/mt8195-pm-domains.h                   |   0
 .../{genpd => pmdomain}/mediatek/mtk-pm-domains.c  |   0
 .../{genpd => pmdomain}/mediatek/mtk-pm-domains.h  |   0
 drivers/{genpd => pmdomain}/mediatek/mtk-scpsys.c  |   0
 drivers/{genpd => pmdomain}/qcom/Makefile          |   0
 drivers/{genpd => pmdomain}/qcom/cpr.c             |   0
 drivers/{genpd => pmdomain}/qcom/rpmhpd.c          |   0
 drivers/{genpd => pmdomain}/qcom/rpmpd.c           |   0
 drivers/{genpd => pmdomain}/renesas/Makefile       |   0
 drivers/{genpd => pmdomain}/renesas/r8a7742-sysc.c |   0
 drivers/{genpd => pmdomain}/renesas/r8a7743-sysc.c |   0
 drivers/{genpd => pmdomain}/renesas/r8a7745-sysc.c |   0
 .../{genpd => pmdomain}/renesas/r8a77470-sysc.c    |   0
 .../{genpd => pmdomain}/renesas/r8a774a1-sysc.c    |   0
 .../{genpd => pmdomain}/renesas/r8a774b1-sysc.c    |   0
 .../{genpd => pmdomain}/renesas/r8a774c0-sysc.c    |   0
 .../{genpd => pmdomain}/renesas/r8a774e1-sysc.c    |   0
 drivers/{genpd => pmdomain}/renesas/r8a7779-sysc.c |   0
 drivers/{genpd => pmdomain}/renesas/r8a7790-sysc.c |   0
 drivers/{genpd => pmdomain}/renesas/r8a7791-sysc.c |   0
 drivers/{genpd => pmdomain}/renesas/r8a7792-sysc.c |   0
 drivers/{genpd => pmdomain}/renesas/r8a7794-sysc.c |   0
 drivers/{genpd => pmdomain}/renesas/r8a7795-sysc.c |   0
 drivers/{genpd => pmdomain}/renesas/r8a7796-sysc.c |   0
 .../{genpd => pmdomain}/renesas/r8a77965-sysc.c    |   0
 .../{genpd => pmdomain}/renesas/r8a77970-sysc.c    |   0
 .../{genpd => pmdomain}/renesas/r8a77980-sysc.c    |   0
 .../{genpd => pmdomain}/renesas/r8a77990-sysc.c    |   0
 .../{genpd => pmdomain}/renesas/r8a77995-sysc.c    |   0
 .../{genpd => pmdomain}/renesas/r8a779a0-sysc.c    |   0
 .../{genpd => pmdomain}/renesas/r8a779f0-sysc.c    |   0
 .../{genpd => pmdomain}/renesas/r8a779g0-sysc.c    |   0
 .../{genpd => pmdomain}/renesas/rcar-gen4-sysc.c   |   0
 .../{genpd => pmdomain}/renesas/rcar-gen4-sysc.h   |   0
 drivers/{genpd => pmdomain}/renesas/rcar-sysc.c    |   0
 drivers/{genpd => pmdomain}/renesas/rcar-sysc.h    |   0
 drivers/{genpd => pmdomain}/renesas/rmobile-sysc.c |   0
 drivers/{genpd => pmdomain}/rockchip/Makefile      |   0
 drivers/{genpd => pmdomain}/rockchip/pm-domains.c  |   0
 drivers/{genpd => pmdomain}/samsung/Makefile       |   0
 .../samsung/exynos-pm-domains.c                    |   0
 drivers/{genpd => pmdomain}/st/Makefile            |   0
 .../{genpd => pmdomain}/st/ste-ux500-pm-domain.c   |   0
 drivers/{genpd => pmdomain}/starfive/Makefile      |   0
 drivers/{genpd => pmdomain}/starfive/jh71xx-pmu.c  |   0
 drivers/{genpd => pmdomain}/sunxi/Makefile         |   0
 drivers/{genpd => pmdomain}/sunxi/sun20i-ppu.c     |   0
 drivers/{genpd => pmdomain}/tegra/Makefile         |   0
 drivers/{genpd => pmdomain}/tegra/powergate-bpmp.c |   0
 drivers/{genpd => pmdomain}/ti/Makefile            |   0
 drivers/{genpd => pmdomain}/ti/omap_prm.c          |   0
 drivers/{genpd => pmdomain}/ti/ti_sci_pm_domains.c |   0
 drivers/{genpd => pmdomain}/xilinx/Makefile        |   0
 .../{genpd => pmdomain}/xilinx/zynqmp-pm-domains.c |   0
 drivers/regulator/Kconfig                          |  10 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/da9062-regulator.c               |   2 +-
 drivers/regulator/da9063-regulator.c               |   2 +-
 drivers/regulator/da9121-regulator.c               |  15 +-
 drivers/regulator/da9210-regulator.c               |  12 +-
 drivers/regulator/fan53555.c                       |   9 +-
 drivers/regulator/fixed.c                          |  50 +++
 drivers/regulator/lochnagar-regulator.c            |   8 +-
 drivers/regulator/ltc3589.c                        |  61 ++-
 drivers/regulator/max1586.c                        |   9 +-
 drivers/regulator/max20086-regulator.c             |  65 ++-
 drivers/regulator/max5970-regulator.c              | 145 +++++-
 drivers/regulator/max77503-regulator.c             | 137 ++++++
 drivers/regulator/mc13xxx.h                        |   2 +-
 drivers/regulator/mp5416.c                         |  10 +-
 drivers/regulator/mp886x.c                         |  14 +-
 drivers/regulator/mt6358-regulator.c               | 494 +++++++++++----------
 drivers/regulator/palmas-regulator.c               |   8 +-
 drivers/regulator/pv88080-regulator.c              |  58 +--
 drivers/regulator/qcom-labibb-regulator.c          |   7 +-
 drivers/regulator/qcom-rpmh-regulator.c            |  21 +-
 drivers/regulator/qcom_rpm-regulator.c             |   7 +-
 drivers/regulator/qcom_spmi-regulator.c            | 103 ++++-
 drivers/regulator/rk808-regulator.c                |   2 -
 drivers/regulator/stm32-booster.c                  |   5 +-
 drivers/regulator/sy8824x.c                        |  26 +-
 drivers/regulator/ti-abb-regulator.c               |  22 +-
 drivers/regulator/tps51632-regulator.c             |  11 -
 drivers/scsi/iscsi_tcp.c                           |   4 +
 drivers/scsi/lpfc/lpfc_debugfs.c                   |  14 +-
 drivers/scsi/lpfc/lpfc_hbadisc.c                   |   5 +-
 drivers/scsi/lpfc/lpfc_nvme.c                      |  24 +-
 drivers/scsi/megaraid/megaraid_sas.h               |   2 +-
 drivers/scsi/megaraid/megaraid_sas_base.c          |  21 +-
 drivers/scsi/pm8001/pm8001_hwi.c                   |   2 +-
 drivers/scsi/pm8001/pm8001_init.c                  |  51 +--
 drivers/scsi/pm8001/pm80xx_hwi.c                   |   4 +-
 drivers/scsi/ppa.c                                 |   4 +-
 drivers/scsi/qedf/qedf_io.c                        |  10 +-
 drivers/scsi/qedf/qedf_main.c                      |   7 +-
 drivers/scsi/qla2xxx/qla_dfs.c                     |   6 +-
 drivers/scsi/qla2xxx/qla_inline.h                  |   2 +-
 drivers/scsi/qla2xxx/qla_isr.c                     |   6 +-
 drivers/scsi/qla2xxx/qla_nvme.c                    |  10 +-
 drivers/scsi/qla2xxx/qla_target.c                  |   3 +-
 drivers/scsi/qla2xxx/tcm_qla2xxx.c                 |   4 +-
 drivers/spi/spi-imx.c                              |   2 +-
 drivers/spi/spi-intel-pci.c                        |   1 +
 drivers/spi/spi-nxp-fspi.c                         |   7 +
 drivers/spi/spi-stm32.c                            |   8 +
 drivers/spi/spi-zynqmp-gqspi.c                     |  12 +-
 drivers/target/target_core_configfs.c              |  24 +-
 drivers/target/target_core_transport.c             |   1 +
 drivers/thermal/thermal_core.c                     |   6 +-
 drivers/thermal/thermal_of.c                       |   8 +-
 drivers/thermal/thermal_sysfs.c                    |   9 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   3 +-
 drivers/ufs/core/ufshcd.c                          |  13 +-
 drivers/usb/typec/ucsi/debugfs.c                   |   3 +
 drivers/video/console/Kconfig                      |   1 +
 drivers/video/fbdev/Kconfig                        |   2 +-
 drivers/video/fbdev/core/Kconfig                   |   2 +-
 drivers/w1/masters/ds2482.c                        |   2 +-
 drivers/xen/events/events_base.c                   |  21 +-
 drivers/xen/platform-pci.c                         |   2 +-
 fs/btrfs/Kconfig                                   |   2 +-
 fs/btrfs/block-group.c                             |  12 +-
 fs/btrfs/delayed-inode.c                           | 104 +++--
 fs/btrfs/disk-io.c                                 |  22 +-
 fs/btrfs/extent_io.c                               |   9 +-
 fs/btrfs/file.c                                    |  40 +-
 fs/btrfs/inode.c                                   |  33 +-
 fs/btrfs/ioctl.c                                   |   8 +-
 fs/btrfs/locking.h                                 |   2 +-
 fs/btrfs/ordered-data.c                            |   2 +-
 fs/btrfs/super.c                                   |   5 +-
 fs/btrfs/transaction.c                             |  39 +-
 fs/btrfs/transaction.h                             |   1 +
 fs/btrfs/verity.c                                  |  64 ++-
 fs/buffer.c                                        |  25 +-
 fs/efivarfs/super.c                                |  14 +-
 fs/ext4/mballoc.c                                  |  54 ++-
 fs/ext4/namei.c                                    |  26 +-
 fs/ext4/super.c                                    |   2 +-
 fs/gfs2/glock.c                                    |   4 +-
 fs/gfs2/glops.c                                    |   9 +-
 fs/gfs2/quota.h                                    |   3 +-
 fs/inode.c                                         |  82 +---
 fs/iomap/buffered-io.c                             |  30 +-
 fs/jbd2/commit.c                                   |  16 +-
 fs/jbd2/journal.c                                  |   2 +
 fs/jbd2/transaction.c                              |  12 +-
 fs/netfs/buffered_read.c                           |   6 +-
 fs/nfs/direct.c                                    | 134 ++++--
 fs/nfs/flexfilelayout/flexfilelayout.c             |   1 +
 fs/nfs/nfs4client.c                                |   6 +-
 fs/nfs/nfs4proc.c                                  |   6 +-
 fs/nfs/write.c                                     |  23 +-
 fs/nfsd/nfs4proc.c                                 |   4 +-
 fs/nfsd/nfssvc.c                                   |   5 +-
 fs/overlayfs/copy_up.c                             |   3 +-
 fs/overlayfs/file.c                                |   9 +-
 fs/proc/internal.h                                 |   2 -
 fs/proc/task_nommu.c                               |  64 +--
 fs/smb/client/cached_dir.c                         |   6 +
 fs/smb/client/cifsglob.h                           |   3 +-
 fs/smb/client/cifsproto.h                          |   2 +-
 fs/smb/client/connect.c                            |   8 +-
 fs/smb/client/inode.c                              |   2 +-
 fs/smb/client/misc.c                               |  14 +-
 fs/smb/client/smb2inode.c                          |   3 +
 fs/smb/client/smb2maperror.c                       |   2 -
 fs/smb/client/smb2ops.c                            |   6 +-
 fs/smb/client/smb2pdu.c                            |  35 +-
 fs/smb/client/smbdirect.c                          |   9 +-
 fs/smb/client/trace.h                              |   2 +
 fs/smb/client/transport.c                          |  36 +-
 fs/smb/server/smb2pdu.c                            |   2 +-
 fs/smb/server/smbacl.c                             |   1 -
 fs/stat.c                                          |  47 +-
 fs/tracefs/event_inode.c                           | 146 +++++-
 fs/tracefs/inode.c                                 |   5 +-
 fs/tracefs/internal.h                              |   5 +-
 fs/xfs/Kconfig                                     |   2 +-
 fs/xfs/libxfs/xfs_log_recover.h                    |  22 +
 fs/xfs/libxfs/xfs_sb.c                             |   3 +-
 fs/xfs/libxfs/xfs_trans_inode.c                    |   6 +-
 fs/xfs/scrub/scrub.c                               |   4 +-
 fs/xfs/scrub/stats.c                               |   5 +-
 fs/xfs/xfs_attr_inactive.c                         |   1 -
 fs/xfs/xfs_attr_item.c                             |   7 +-
 fs/xfs/xfs_bmap_item.c                             |   4 +-
 fs/xfs/xfs_export.c                                |   6 +
 fs/xfs/xfs_extfree_item.c                          |   4 +-
 fs/xfs/xfs_fsmap.c                                 |  25 +-
 fs/xfs/xfs_icache.c                                |  80 ++--
 fs/xfs/xfs_icache.h                                |   1 -
 fs/xfs/xfs_inode.c                                 | 209 ++++++++-
 fs/xfs/xfs_inode.h                                 |  34 +-
 fs/xfs/xfs_iops.c                                  |   6 +-
 fs/xfs/xfs_itable.c                                |   9 +
 fs/xfs/xfs_log.c                                   |  17 -
 fs/xfs/xfs_log_cil.c                               |  52 +--
 fs/xfs/xfs_log_priv.h                              |  14 +-
 fs/xfs/xfs_log_recover.c                           |   4 +-
 fs/xfs/xfs_mount.h                                 |  17 +-
 fs/xfs/xfs_qm.c                                    |   7 +
 fs/xfs/xfs_refcount_item.c                         |   6 +-
 fs/xfs/xfs_rmap_item.c                             |   6 +-
 fs/xfs/xfs_super.c                                 |  88 +---
 fs/xfs/xfs_trace.h                                 |  45 ++
 fs/xfs/xfs_xattr.c                                 |  11 +
 include/drm/drm_exec.h                             |  35 +-
 include/drm/drm_kunit_helpers.h                    |   4 +-
 include/linux/aer.h                                |   2 +
 include/linux/arm-smccc.h                          |   2 +
 include/linux/atomic/atomic-arch-fallback.h        |  10 +-
 include/linux/btf_ids.h                            |   2 +-
 include/linux/buffer_head.h                        |   5 +-
 include/linux/cpuhotplug.h                         |   1 -
 include/linux/export-internal.h                    |   2 +
 include/linux/fs.h                                 |  46 +-
 include/linux/i2c.h                                |  11 +-
 include/linux/if_team.h                            |   2 +
 include/linux/instruction_pointer.h                |   5 +
 include/linux/kasan.h                              |   2 +-
 include/linux/libata.h                             |   4 +
 include/linux/memcontrol.h                         |   4 +-
 include/linux/mfd/mt6358/registers.h               |  23 +
 include/linux/nfs_fs_sb.h                          |   1 +
 include/linux/nfs_page.h                           |   4 +-
 include/linux/nvme-fc-driver.h                     |   6 +-
 include/linux/regulator/mt6358-regulator.h         |   3 +
 include/linux/resume_user_mode.h                   |   2 +-
 include/linux/seqlock.h                            |   2 +-
 include/linux/sunrpc/xdr.h                         |   4 +-
 include/linux/thermal.h                            |   4 +-
 include/linux/trace_events.h                       |   7 +-
 include/net/ipv6.h                                 |   7 +-
 include/net/netfilter/nf_tables.h                  |   7 +-
 include/trace/events/xen.h                         |  12 +-
 include/uapi/linux/bpf.h                           |   4 +-
 include/uapi/linux/stddef.h                        |   7 +
 include/xen/arm/hypervisor.h                       |  12 -
 include/xen/events.h                               |   3 +-
 io_uring/net.c                                     |   5 +
 kernel/bpf/btf.c                                   |   2 +-
 kernel/bpf/cgroup.c                                |  13 +-
 kernel/bpf/memalloc.c                              |  94 +++-
 kernel/bpf/offload.c                               |  12 +-
 kernel/bpf/queue_stack_maps.c                      |  21 +-
 kernel/panic.c                                     |   1 +
 kernel/pid.c                                       |   2 +-
 kernel/power/hibernate.c                           |  12 +-
 kernel/power/power.h                               |   4 +-
 kernel/power/swap.c                                |  14 +-
 kernel/sched/core.c                                |   2 +-
 kernel/sched/fair.c                                |  27 +-
 kernel/sched/idle.c                                |   1 +
 kernel/task_work.c                                 |   1 +
 kernel/trace/bpf_trace.c                           |  20 +-
 kernel/trace/ring_buffer.c                         |  35 +-
 kernel/trace/trace.c                               |  72 ++-
 kernel/trace/trace.h                               |   2 +
 kernel/trace/trace_events.c                        |  32 +-
 kernel/trace/trace_events_inject.c                 |   3 +-
 kernel/trace/trace_events_synth.c                  |   2 +-
 lib/argv_split.c                                   |   4 +-
 lib/kunit/executor.c                               |  48 +-
 lib/kunit/executor_test.c                          |  13 +-
 lib/kunit/test.c                                   |   3 +-
 lib/scatterlist.c                                  |   4 +-
 mm/filemap.c                                       |  69 ++-
 mm/kasan/kasan.h                                   |   8 +-
 mm/memcontrol.c                                    |   6 +-
 mm/mremap.c                                        |   2 +-
 mm/page_alloc.c                                    |  12 +-
 mm/shmem.c                                         |   2 +-
 net/ax25/Kconfig                                   |  16 +-
 net/bridge/br_forward.c                            |   4 +-
 net/bridge/br_input.c                              |   4 +-
 net/core/dev.c                                     |   6 +-
 net/core/flow_dissector.c                          |   2 +-
 net/dccp/ipv4.c                                    |   9 +-
 net/dccp/ipv6.c                                    |   9 +-
 net/handshake/handshake-test.c                     |  14 +-
 net/hsr/hsr_forward.c                              |   1 +
 net/hsr/hsr_framereg.c                             |   4 +-
 net/hsr/hsr_main.h                                 |   2 +-
 net/ipv4/devinet.c                                 |  10 +-
 net/ipv4/inet_hashtables.c                         |  36 +-
 net/ipv4/route.c                                   |   4 +-
 net/kcm/kcmsock.c                                  |  13 +-
 net/mptcp/options.c                                |   5 +-
 net/mptcp/protocol.c                               | 165 ++++---
 net/mptcp/protocol.h                               |  24 +-
 net/mptcp/subflow.c                                |  39 +-
 net/ncsi/ncsi-aen.c                                |   5 +
 net/netfilter/ipset/ip_set_core.c                  |  12 +-
 net/netfilter/nf_conntrack_bpf.c                   |   2 +
 net/netfilter/nf_conntrack_extend.c                |   4 +-
 net/netfilter/nf_tables_api.c                      |  79 +++-
 net/netfilter/nft_set_hash.c                       |  11 +-
 net/netfilter/nft_set_pipapo.c                     |   4 +-
 net/netfilter/nft_set_rbtree.c                     |   8 +-
 net/rds/rdma_transport.c                           |  12 +-
 net/smc/smc_core.c                                 |   2 +
 net/smc/smc_stats.h                                |   3 +-
 net/sunrpc/clnt.c                                  |  14 +-
 net/tls/tls_sw.c                                   |   4 +-
 scripts/Makefile.modinst                           |   2 +-
 scripts/atomic/gen-atomic-fallback.sh              |   2 +-
 scripts/gdb/linux/symbols.py                       |  23 +-
 scripts/mod/modpost.c                              |   9 +
 scripts/package/install-extmod-build               |   2 +-
 security/selinux/hooks.c                           |  10 +-
 sound/core/init.c                                  |   7 +-
 sound/core/rawmidi.c                               |   2 +-
 sound/core/seq/seq_midi.c                          |   4 +-
 sound/core/seq/seq_ump_client.c                    |  24 +-
 sound/core/seq/seq_ump_convert.c                   |   2 +
 sound/firewire/bebob/bebob_midi.c                  |   6 +-
 sound/firewire/dice/dice-midi.c                    |   4 +-
 sound/firewire/digi00x/digi00x-midi.c              |  14 +-
 sound/firewire/fireface/ff-midi.c                  |   4 +-
 sound/firewire/fireworks/fireworks.c               |  10 +-
 sound/firewire/fireworks/fireworks_midi.c          |   4 +-
 sound/firewire/motu/motu-midi.c                    |   4 +-
 sound/firewire/oxfw/oxfw-midi.c                    |   6 +-
 sound/firewire/oxfw/oxfw.c                         |  10 +-
 sound/firewire/tascam/tascam-midi.c                |  12 +-
 sound/hda/intel-sdw-acpi.c                         |   8 +-
 sound/isa/ad1848/ad1848.c                          |  12 +-
 sound/isa/cs423x/cs4231.c                          |  12 +-
 sound/isa/cs423x/cs4236.c                          |  14 +-
 sound/isa/es1688/es1688.c                          |   6 +-
 sound/isa/opti9xx/miro.c                           |   8 +-
 sound/isa/opti9xx/opti92x-ad1848.c                 |  16 +-
 sound/isa/sscape.c                                 |   2 +-
 sound/pci/cmipci.c                                 |   8 +-
 sound/pci/hda/cs35l56_hda.c                        |  21 +-
 sound/pci/hda/cs35l56_hda_i2c.c                    |   1 -
 sound/pci/hda/hda_generic.c                        |   6 +-
 sound/pci/hda/hda_intel.c                          |   1 +
 sound/pci/hda/patch_realtek.c                      |  13 +-
 sound/pci/riptide/riptide.c                        |  16 +-
 sound/soc/amd/yc/acp6x-mach.c                      |  21 +
 sound/soc/codecs/aw88395/aw88395_lib.c             |   2 +
 sound/soc/codecs/cs35l56-i2c.c                     |   1 -
 sound/soc/codecs/cs35l56.c                         |   1 +
 sound/soc/codecs/cs42l42-sdw.c                     |  20 +
 sound/soc/codecs/cs42l42.c                         |  21 +-
 sound/soc/codecs/cs42l42.h                         |   1 +
 sound/soc/codecs/cs42l43.c                         |  14 +-
 sound/soc/codecs/rt5640.c                          |  29 +-
 sound/soc/codecs/wm8960.c                          |  19 +-
 sound/soc/codecs/wm_adsp.c                         |  13 +-
 sound/soc/fsl/imx-audmix.c                         |   2 +-
 sound/soc/fsl/imx-pcm-rpmsg.c                      |   1 +
 sound/soc/fsl/imx-rpmsg.c                          |   8 +
 sound/soc/intel/avs/boards/hdaudio.c               |   3 +
 sound/soc/meson/axg-spdifin.c                      |  49 +-
 sound/soc/sh/rcar/core.c                           |   1 +
 sound/soc/soc-pcm.c                                |  23 +-
 sound/soc/soc-utils.c                              |   1 +
 sound/soc/sof/core.c                               |   3 +-
 sound/soc/sof/intel/mtl.c                          |   2 +-
 sound/soc/sof/intel/mtl.h                          |   1 -
 sound/soc/sof/ipc4-topology.c                      |   2 +-
 sound/soc/sof/sof-audio.c                          |   3 +-
 sound/soc/tegra/tegra_audio_graph_card.c           |  30 +-
 sound/usb/caiaq/device.c                           |   2 +-
 sound/usb/mixer.c                                  |   6 +-
 sound/usb/mixer_scarlett_gen2.c                    |   8 +-
 sound/xen/xen_snd_front_cfg.c                      |   2 +-
 tools/include/linux/btf_ids.h                      |   2 +-
 tools/include/linux/mm.h                           |   4 +-
 tools/include/linux/seq_file.h                     |   2 +
 tools/include/uapi/linux/bpf.h                     |   4 +-
 tools/objtool/check.c                              |   3 +-
 tools/testing/memblock/internal.h                  |   4 +
 tools/testing/memblock/mmzone.c                    |   2 +-
 tools/testing/memblock/tests/basic_api.c           |   2 +-
 tools/testing/memblock/tests/common.h              |   1 +
 tools/testing/selftests/alsa/conf.c                |   1 -
 tools/testing/selftests/alsa/mixer-test.c          |  11 +-
 tools/testing/selftests/alsa/pcm-test.c            |   4 +-
 tools/testing/selftests/alsa/test-pcmtest-driver.c |   1 -
 tools/testing/selftests/bpf/DENYLIST.aarch64       |  10 +-
 tools/testing/selftests/bpf/config                 |   1 +
 tools/testing/selftests/bpf/config.x86_64          |   1 -
 tools/testing/selftests/bpf/prog_tests/empty_skb.c |  12 +-
 .../selftests/bpf/prog_tests/kprobe_multi_test.c   |  37 ++
 .../testing/selftests/bpf/prog_tests/test_bpf_ma.c |  50 +++
 .../selftests/bpf/prog_tests/xdp_dev_bound_only.c  |  61 +++
 .../selftests/bpf/progs/kprobe_multi_override.c    |  13 +
 tools/testing/selftests/bpf/progs/test_bpf_ma.c    | 123 +++++
 tools/testing/selftests/bpf/test_verifier.c        |   2 +-
 tools/testing/selftests/fchmodat2/Makefile         |   2 +-
 tools/testing/selftests/ftrace/ftracetest          |  18 +-
 .../ftrace/test.d/instances/instance-event.tc      |   2 +-
 .../trigger-synthetic-event-dynstring.tc           |   2 +-
 .../trigger-synthetic_event_syntax_errors.tc       |   2 +-
 tools/testing/selftests/kselftest/runner.sh        |   3 +-
 tools/testing/selftests/kselftest_deps.sh          |  77 +++-
 tools/testing/selftests/kvm/lib/test_util.c        |   2 +-
 tools/testing/selftests/kvm/riscv/get-reg-list.c   |  58 ++-
 tools/testing/selftests/lib.mk                     |   4 +-
 tools/testing/selftests/net/bind_bhash.sh          |  26 +-
 tools/testing/selftests/net/bind_wildcard.c        |  68 ++-
 tools/testing/selftests/net/hsr/hsr_ping.sh        | 266 ++++++-----
 tools/testing/selftests/net/tls.c                  |   8 +-
 tools/testing/selftests/netfilter/.gitignore       |   1 +
 tools/testing/selftests/netfilter/Makefile         |   4 +-
 tools/testing/selftests/netfilter/audit_logread.c  | 165 +++++++
 tools/testing/selftests/netfilter/config           |   1 +
 tools/testing/selftests/netfilter/nft_audit.sh     | 108 +++++
 tools/testing/selftests/openat2/Makefile           |   2 +-
 tools/testing/selftests/proc/proc-empty-vm.c       |   1 +
 tools/testing/selftests/user_events/abi_test.c     |   3 +
 tools/testing/selftests/user_events/config         |   1 +
 tools/testing/selftests/user_events/dyn_test.c     |   2 +
 tools/testing/selftests/user_events/ftrace_test.c  |   3 +
 tools/testing/selftests/user_events/perf_test.c    |   3 +
 .../selftests/user_events/user_events_selftests.h  | 100 +++++
 785 files changed, 7416 insertions(+), 4354 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/adi,max77503-regulator.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/da9210.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/dlg,da9210.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
 create mode 100644 arch/loongarch/include/asm/exception.h
 delete mode 100644 arch/parisc/include/asm/mckinley.h
 rename drivers/{genpd => pmdomain}/Makefile (100%)
 rename drivers/{genpd => pmdomain}/actions/Makefile (100%)
 rename drivers/{genpd => pmdomain}/actions/owl-sps-helper.c (100%)
 rename drivers/{genpd => pmdomain}/actions/owl-sps.c (100%)
 rename drivers/{genpd => pmdomain}/amlogic/Makefile (100%)
 rename drivers/{genpd => pmdomain}/amlogic/meson-ee-pwrc.c (100%)
 rename drivers/{genpd => pmdomain}/amlogic/meson-gx-pwrc-vpu.c (100%)
 rename drivers/{genpd => pmdomain}/amlogic/meson-secure-pwrc.c (100%)
 rename drivers/{genpd => pmdomain}/apple/Makefile (100%)
 rename drivers/{genpd => pmdomain}/apple/pmgr-pwrstate.c (100%)
 rename drivers/{genpd => pmdomain}/bcm/Makefile (100%)
 rename drivers/{genpd => pmdomain}/bcm/bcm-pmb.c (100%)
 rename drivers/{genpd => pmdomain}/bcm/bcm2835-power.c (100%)
 rename drivers/{genpd => pmdomain}/bcm/bcm63xx-power.c (100%)
 rename drivers/{genpd => pmdomain}/bcm/raspberrypi-power.c (100%)
 rename drivers/{genpd => pmdomain}/imx/Makefile (100%)
 rename drivers/{genpd => pmdomain}/imx/gpc.c (100%)
 rename drivers/{genpd => pmdomain}/imx/gpcv2.c (100%)
 rename drivers/{genpd => pmdomain}/imx/imx8m-blk-ctrl.c (100%)
 rename drivers/{genpd => pmdomain}/imx/imx8mp-blk-ctrl.c (100%)
 rename drivers/{genpd => pmdomain}/imx/imx93-blk-ctrl.c (100%)
 rename drivers/{genpd => pmdomain}/imx/imx93-pd.c (100%)
 rename drivers/{genpd => pmdomain}/imx/scu-pd.c (100%)
 rename drivers/{genpd => pmdomain}/mediatek/Makefile (100%)
 rename drivers/{genpd => pmdomain}/mediatek/mt6795-pm-domains.h (100%)
 rename drivers/{genpd => pmdomain}/mediatek/mt8167-pm-domains.h (100%)
 rename drivers/{genpd => pmdomain}/mediatek/mt8173-pm-domains.h (100%)
 rename drivers/{genpd => pmdomain}/mediatek/mt8183-pm-domains.h (100%)
 rename drivers/{genpd => pmdomain}/mediatek/mt8186-pm-domains.h (100%)
 rename drivers/{genpd => pmdomain}/mediatek/mt8188-pm-domains.h (100%)
 rename drivers/{genpd => pmdomain}/mediatek/mt8192-pm-domains.h (100%)
 rename drivers/{genpd => pmdomain}/mediatek/mt8195-pm-domains.h (100%)
 rename drivers/{genpd => pmdomain}/mediatek/mtk-pm-domains.c (100%)
 rename drivers/{genpd => pmdomain}/mediatek/mtk-pm-domains.h (100%)
 rename drivers/{genpd => pmdomain}/mediatek/mtk-scpsys.c (100%)
 rename drivers/{genpd => pmdomain}/qcom/Makefile (100%)
 rename drivers/{genpd => pmdomain}/qcom/cpr.c (100%)
 rename drivers/{genpd => pmdomain}/qcom/rpmhpd.c (100%)
 rename drivers/{genpd => pmdomain}/qcom/rpmpd.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/Makefile (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a7742-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a7743-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a7745-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a77470-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a774a1-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a774b1-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a774c0-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a774e1-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a7779-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a7790-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a7791-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a7792-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a7794-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a7795-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a7796-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a77965-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a77970-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a77980-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a77990-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a77995-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a779a0-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a779f0-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/r8a779g0-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/rcar-gen4-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/rcar-gen4-sysc.h (100%)
 rename drivers/{genpd => pmdomain}/renesas/rcar-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/renesas/rcar-sysc.h (100%)
 rename drivers/{genpd => pmdomain}/renesas/rmobile-sysc.c (100%)
 rename drivers/{genpd => pmdomain}/rockchip/Makefile (100%)
 rename drivers/{genpd => pmdomain}/rockchip/pm-domains.c (100%)
 rename drivers/{genpd => pmdomain}/samsung/Makefile (100%)
 rename drivers/{genpd => pmdomain}/samsung/exynos-pm-domains.c (100%)
 rename drivers/{genpd => pmdomain}/st/Makefile (100%)
 rename drivers/{genpd => pmdomain}/st/ste-ux500-pm-domain.c (100%)
 rename drivers/{genpd => pmdomain}/starfive/Makefile (100%)
 rename drivers/{genpd => pmdomain}/starfive/jh71xx-pmu.c (100%)
 rename drivers/{genpd => pmdomain}/sunxi/Makefile (100%)
 rename drivers/{genpd => pmdomain}/sunxi/sun20i-ppu.c (100%)
 rename drivers/{genpd => pmdomain}/tegra/Makefile (100%)
 rename drivers/{genpd => pmdomain}/tegra/powergate-bpmp.c (100%)
 rename drivers/{genpd => pmdomain}/ti/Makefile (100%)
 rename drivers/{genpd => pmdomain}/ti/omap_prm.c (100%)
 rename drivers/{genpd => pmdomain}/ti/ti_sci_pm_domains.c (100%)
 rename drivers/{genpd => pmdomain}/xilinx/Makefile (100%)
 rename drivers/{genpd => pmdomain}/xilinx/zynqmp-pm-domains.c (100%)
 create mode 100644 drivers/regulator/max77503-regulator.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_ma.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_dev_bound_only.c
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_override.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bpf_ma.c
 create mode 100644 tools/testing/selftests/netfilter/audit_logread.c
 create mode 100755 tools/testing/selftests/netfilter/nft_audit.sh
 create mode 100644 tools/testing/selftests/user_events/config
 create mode 100644 tools/testing/selftests/user_events/user_events_selftests.h
