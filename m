Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8404C798952
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243458AbjIHO4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241895AbjIHO4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:56:10 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC21B1FC4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 07:55:58 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-27373f0916dso1813023a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 07:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694184958; x=1694789758; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWvDwnthFmylIYNCBooVf93TbNy8B5Sk0upDAgXIZyU=;
        b=iHYbchfRoqEHgjpBnPW6a0FCxIYMcNpxX8x1GV1edH02UCD+i2W6IeGAitJuL24nT7
         gEBU1PKUBYeZnFIkf/65kC1g2MhRNd0gpvsWJ6laF8CJE60ePyRokPO9MIWE7duuZcjy
         S6Vf5O3sJobLlHkmty9c8dbbnKLT4BEodlzalWHsqEyIPyFV+JR82I7yAfPaVd9mdfkT
         RDAg8ma4ZAtQKkcz8ozkz7Ouc/RP+cef984H+r8sVYb0WJI2ErvMCKnS8vq5wVpyO11D
         L9pOu+bQRFRBV+KAAyV1tDx+HzsbR6/BhxDGcv9srsYJLHYt9ZKn9o/OdgibpHRubIoh
         YiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694184958; x=1694789758;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWvDwnthFmylIYNCBooVf93TbNy8B5Sk0upDAgXIZyU=;
        b=nUPsNpY1b/POHdOdh+tArnNQH2pWyGYhI5piAYRSPhP2LOvuhBWb0Ra2pdPluPeUco
         hi+LA9MK3HLBOuoKwztaiLmEXEZYBij1oVO9YdB+aH+uG4c6slCyVQbx9Nk65mGAQaaH
         KYekr3awKCT4TrDHuBviCJXFWGJ+bpRu5HBkXfSFqyObgqYANb8V6Z+WPd0xpdLRk7XI
         l+z9vV+qPUs/LfB9JrMcJEZ/FBOJUHxqzyFgnb6CzNj7FiV+y8iZEqkjBjy4allaF1Tp
         Xj4h5f1iV4WHnJ2ZOqeRtnbX0WXAeJOy02fIEIvOecmsnibnuhpprpcrtYRiA0P7ICJl
         WKTw==
X-Gm-Message-State: AOJu0YzImDznC15QCZswq7c2JF7Z+67WFVwvRKZzTRsVyRpIP1RuBFe+
        IqlZNXrCRMxgzw1HSma6s7Z4t+APzB9ni3NTf+8=
X-Google-Smtp-Source: AGHT+IH2JggA2YNrdpTxqEGSVskK0ubX2LA70P5P2DF3BlnUuNO7kvVShAow2701N14Pdeecr7sJ3g==
X-Received: by 2002:a17:90a:72c4:b0:268:5c3b:6f28 with SMTP id l4-20020a17090a72c400b002685c3b6f28mr2898737pjk.19.1694184958238;
        Fri, 08 Sep 2023 07:55:58 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id 12-20020a17090a194c00b0026f90d7947csm1525435pjh.34.2023.09.08.07.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 07:55:57 -0700 (PDT)
Date:   Fri, 08 Sep 2023 07:55:57 -0700 (PDT)
X-Google-Original-Date: Fri, 08 Sep 2023 07:53:21 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 6.6 Merge Window, Part 2
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-f4556557-af4d-4b6a-aa89-de77f7dacf2b@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged tag 'riscv-for-linus-6.6-mw1'
The following changes since commit e0152e7481c6c63764d6ea8ee41af5cf9dfac5e9:

  Merge tag 'riscv-for-linus-6.6-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2023-09-01 08:09:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.6-mw2

for you to fetch changes up to accb14aa1e699d11b8172283e8cb82a695b96c85:

  soc: renesas: Kconfig: For ARCH_R9A07G043 select the required configs if dependencies are met (2023-09-06 07:20:13 -0700)

----------------------------------------------------------------
RISC-V Patches for the 6.6 Merge Window, Part 2

* The kernel now dynamically probes for misaligned access speed, as
  opposed to relying on a table of known implementations.
* Support for non-coherent devices on systems using the Andes AX45MP
  core, including the RZ/Five SoCs.
* Support for the V extension in ptrace(), again.
* Support for KASLR.
* Support for the BPF prog pack allocator in RISC-V.
* A handful of bug fixes and cleanups.

----------------------------------------------------------------
The shortlog looks correct here, but the diffstat includes all sorts of files I
wasn't expecting.  I'm not entirely sure what's going on here, but I have a
little bit of a complex set of base branches here as the BPF changes have a
dependency on some arm64 BPF work and IIRC that sort of thing sometimes makes
diffstat go off the rails.  So hopefully that's just it.

I also have two merge conflicts: one in Documentation/bpf/instruction-set.rst
and one in drivers/firmware/efi/libstub/.

Resolving the BPF one seems pretty straight-forward, there was a line break
introduced during the file moves in 4d496be9ca05 ("bpf,docs: Create new
standardization subdirectory").  It's a bit worrying given the diffstat,
though.

I resolved the libstub conflict as part of mergeing in the patch set.  The
actual conflict also looks pretty straight-forward: we refactored some KASLR
handling out to shared code, but there was also a new argument added.  I
resolved it when picking up the patch series, but after talking to some of the
Arm folks I'm not quite sure that was the right way to go.  So it won't show up
when actually merging, but figured I'd say something anyway as end up doing
that sort of "fix a conflict when merging a patch set" from time to time.

----------------------------------------------------------------
Alexandre Ghiti (5):
      riscv: Introduce virtual kernel mapping KASLR
      riscv: Dump out kernel offset information on panic
      arm64: libstub: Move KASLR handling functions to kaslr.c
      libstub: Fix compilation warning for rv32
      riscv: libstub: Implement KASLR by using generic functions

Andy Chiu (1):
      RISC-V: Add ptrace support for vectors

Arnd Bergmann (2):
      riscv: dma-mapping: only invalidate after DMA, not flush
      riscv: dma-mapping: skip invalidation before bidirectional DMA

Evan Green (2):
      RISC-V: Probe for unaligned access speed
      RISC-V: alternative: Remove feature_probe_func

Lad Prabhakar (11):
      riscv: dma-mapping: switch over to generic implementation
      riscv: asm: vendorid_list: Add Andes Technology to the vendors list
      riscv: errata: Add Andes alternative ports
      riscv: mm: dma-noncoherent: nonstandard cache operations support
      dt-bindings: cache: andestech,ax45mp-cache: Add DT binding documentation for L2 cache controller
      cache: Add L2 cache management for Andes AX45MP RISC-V core
      soc: renesas: Kconfig: Select the required configs for RZ/Five SoC
      riscv: Kconfig: Select DMA_DIRECT_REMAP only if MMU is enabled
      riscv: Kconfig.errata: Drop dependency for MMU in ERRATA_ANDES_CMO config
      riscv: Kconfig.errata: Add dependency for RISCV_SBI in ERRATA_ANDES config
      soc: renesas: Kconfig: For ARCH_R9A07G043 select the required configs if dependencies are met

Palmer Dabbelt (6):
      Merge patch series "RISC-V: Probe for misaligned access speed"
      Merge patch series "riscv: dma-mapping: unify support for cache flushes"
      Merge patch series "Add non-coherent DMA support for AX45MP"
      Merge patch "RISC-V: Add ptrace support for vectors"
      Merge patch series "riscv: Introduce KASLR"
      Merge patch series "bpf, riscv: use BPF prog pack allocator in BPF JIT"

Puranjay Mohan (4):
      bpf: make bpf_prog_pack allocator portable
      riscv: extend patch_text_nosync() for multiple pages
      riscv: implement a memset like function for text
      bpf, riscv: use prog pack allocator in the BPF JIT

 Documentation/bpf/instruction-set.rst              |  478 +++++++++
 Documentation/bpf/linux-notes.rst                  |   83 ++
 Documentation/devicetree/bindings/arm/msm/ssbi.txt |   18 +
 .../devicetree/bindings/arm/tegra/nvidia,nvec.txt  |   21 +
 .../bindings/arm/tegra/nvidia,tegra20-ahb.txt      |   17 +
 .../bindings/arm/tegra/nvidia,tegra20-flowctrl.txt |   18 +
 .../bindings/cache/andestech,ax45mp-cache.yaml     |   81 ++
 .../bindings/clock/amlogic,gxbb-aoclkc.txt         |   64 ++
 .../bindings/clock/amlogic,gxbb-clkc.txt           |   53 +
 .../devicetree/bindings/clock/hix5hd2-clock.txt    |   30 +
 .../devicetree/bindings/clock/oxnas,stdclk.txt     |   28 +
 .../devicetree/bindings/clock/xlnx,zynqmp-clk.txt  |   63 ++
 .../devicetree/bindings/cpufreq/ti-cpufreq.txt     |  132 +++
 .../devicetree/bindings/gpio/brcm,kona-gpio.txt    |   52 +
 .../devicetree/bindings/gpio/gpio_oxnas.txt        |   47 +
 .../bindings/input/rmi4/rmi_2d_sensor.txt          |   56 +
 .../devicetree/bindings/input/rmi4/rmi_f01.txt     |   39 +
 .../devicetree/bindings/input/rmi4/rmi_i2c.txt     |   61 ++
 .../devicetree/bindings/input/rmi4/rmi_spi.txt     |   56 +
 .../devicetree/bindings/net/davicom-dm9000.txt     |   27 +
 .../devicetree/bindings/net/ftgmac100.txt          |   67 ++
 .../devicetree/bindings/net/oxnas-dwmac.txt        |   41 +
 .../devicetree/bindings/net/xilinx_gmii2rgmii.txt  |   35 +
 .../bindings/opp/ti-omap5-opp-supply.txt           |   63 ++
 .../bindings/pinctrl/brcm,bcm11351-pinctrl.txt     |  461 +++++++++
 .../devicetree/bindings/pinctrl/oxnas,pinctrl.txt  |   56 +
 .../devicetree/bindings/pinctrl/pinctrl-single.txt |  262 +++++
 .../bindings/pinctrl/ti,omap-pinctrl.txt           |   13 +
 .../bindings/power/xlnx,zynqmp-genpd.txt           |   34 +
 Documentation/devicetree/bindings/pps/pps-gpio.txt |   30 +
 .../devicetree/bindings/regulator/slg51000.txt     |   88 ++
 .../devicetree/bindings/serial/cavium-uart.txt     |   19 +
 .../bindings/serial/nvidia,tegra20-hsuart.txt      |   73 ++
 .../bindings/serial/nxp,lpc1850-uart.txt           |   28 +
 Documentation/devicetree/bindings/sound/gtm601.txt |   19 +
 .../devicetree/bindings/sound/max9892x.txt         |   44 +
 .../devicetree/bindings/sound/nau8821.txt          |   55 +
 .../bindings/sound/qcom,msm8916-wcd-analog.txt     |  101 ++
 Documentation/devicetree/bindings/sound/wm8904.txt |   33 +
 .../bindings/spi/nvidia,tegra114-spi.txt           |   61 ++
 .../bindings/spi/nvidia,tegra20-sflash.txt         |   37 +
 .../bindings/spi/nvidia,tegra20-slink.txt          |   37 +
 .../devicetree/bindings/spi/spi-bcm63xx.txt        |   33 +
 .../bindings/thermal/nvidia,tegra124-soctherm.txt  |  238 +++++
 .../devicetree/bindings/usb/samsung-hsotg.txt      |   38 +
 Documentation/hwmon/smm665.rst                     |  187 ++++
 Documentation/loongarch/booting.rst                |   42 +
 Documentation/loongarch/features.rst               |    3 +
 Documentation/loongarch/index.rst                  |   22 +
 Documentation/loongarch/introduction.rst           |  390 +++++++
 Documentation/loongarch/irq-chip-model.rst         |  160 +++
 Documentation/mips/booting.rst                     |   28 +
 Documentation/mips/features.rst                    |    3 +
 Documentation/mips/index.rst                       |   21 +
 Documentation/mips/ingenic-tcu.rst                 |   71 ++
 Documentation/mm/frontswap.rst                     |  264 +++++
 .../ethernet/mellanox/mlx5/devlink.rst             |  313 ++++++
 Documentation/riscv/hwprobe.rst                    |   11 +-
 Documentation/s390/3270.ChangeLog                  |   44 +
 Documentation/s390/3270.rst                        |  298 ++++++
 Documentation/s390/cds.rst                         |  530 ++++++++++
 Documentation/s390/common_io.rst                   |  140 +++
 Documentation/s390/config3270.sh                   |   76 ++
 Documentation/s390/driver-model.rst                |  328 ++++++
 Documentation/s390/features.rst                    |    3 +
 Documentation/s390/index.rst                       |   30 +
 Documentation/s390/monreader.rst                   |  212 ++++
 Documentation/s390/pci.rst                         |  133 +++
 Documentation/s390/qeth.rst                        |   64 ++
 Documentation/s390/s390dbf.rst                     |  478 +++++++++
 Documentation/s390/text_files.rst                  |   11 +
 Documentation/s390/vfio-ap-locking.rst             |  115 +++
 Documentation/s390/vfio-ap.rst                     | 1069 ++++++++++++++++++++
 Documentation/s390/vfio-ccw.rst                    |  445 ++++++++
 Documentation/s390/zfcpdump.rst                    |   50 +
 .../translations/zh_CN/loongarch/booting.rst       |   48 +
 .../translations/zh_CN/loongarch/features.rst      |    8 +
 .../translations/zh_CN/loongarch/index.rst         |   27 +
 .../translations/zh_CN/loongarch/introduction.rst  |  353 +++++++
 .../zh_CN/loongarch/irq-chip-model.rst             |  157 +++
 Documentation/translations/zh_CN/mips/booting.rst  |   34 +
 Documentation/translations/zh_CN/mips/features.rst |   13 +
 Documentation/translations/zh_CN/mips/index.rst    |   29 +
 .../translations/zh_CN/mips/ingenic-tcu.rst        |   72 ++
 Documentation/translations/zh_CN/mm/frontswap.rst  |  196 ++++
 MAINTAINERS                                        |    7 +
 arch/arm/mach-keystone/keystone.h                  |   16 +
 arch/arm/mach-keystone/memory.h                    |   18 +
 arch/arm/mach-keystone/pm_domain.c                 |   50 +
 arch/arm/mach-nspire/mmio.h                        |   16 +
 arch/arm/mach-ux500/pm_domains.c                   |   79 ++
 arch/arm/mach-ux500/pm_domains.h                   |   17 +
 arch/arm/vfp/entry.S                               |   31 +
 arch/arm64/boot/dts/arm/vexpress-v2m-rs1.dtsi      |    1 +
 arch/arm64/include/asm/efi.h                       |    2 +
 arch/hexagon/mm/ioremap.c                          |   44 +
 arch/parisc/include/asm/machdep.h                  |   17 +
 arch/parisc/kernel/pa7300lc.c                      |   51 +
 arch/powerpc/include/asm/mpc8260.h                 |   22 +
 arch/powerpc/kernel/trace/ftrace_64_pg.S           |   67 ++
 arch/powerpc/kernel/trace/ftrace_low.S             |   78 ++
 arch/powerpc/kernel/trace/ftrace_mprofile.S        |  251 +++++
 arch/powerpc/lib/alloc.c                           |   23 +
 arch/powerpc/platforms/82xx/m82xx_pci.h            |   14 +
 arch/powerpc/platforms/83xx/usb.c                  |  251 +++++
 arch/riscv/Kconfig                                 |   28 +-
 arch/riscv/Kconfig.errata                          |   21 +
 arch/riscv/errata/Makefile                         |    1 +
 arch/riscv/errata/andes/Makefile                   |    1 +
 arch/riscv/errata/andes/errata.c                   |   66 ++
 arch/riscv/errata/thead/errata.c                   |    8 -
 arch/riscv/include/asm/alternative.h               |    8 +-
 arch/riscv/include/asm/cpufeature.h                |    2 +
 arch/riscv/include/asm/dma-noncoherent.h           |   28 +
 arch/riscv/include/asm/efi.h                       |    2 +
 arch/riscv/include/asm/errata_list.h               |    5 +
 arch/riscv/include/asm/page.h                      |    3 +
 arch/riscv/include/asm/patch.h                     |    1 +
 arch/riscv/include/asm/vendorid_list.h             |    1 +
 arch/riscv/include/uapi/asm/ptrace.h               |   13 +-
 arch/riscv/kernel/Makefile                         |    1 +
 arch/riscv/kernel/alternative.c                    |   24 +-
 arch/riscv/kernel/copy-unaligned.S                 |   71 ++
 arch/riscv/kernel/copy-unaligned.h                 |   13 +
 arch/riscv/kernel/cpufeature.c                     |  104 ++
 arch/riscv/kernel/image-vars.h                     |    1 +
 arch/riscv/kernel/patch.c                          |  114 ++-
 arch/riscv/kernel/pi/Makefile                      |    2 +-
 arch/riscv/kernel/pi/cmdline_early.c               |   13 +
 arch/riscv/kernel/pi/fdt_early.c                   |   30 +
 arch/riscv/kernel/ptrace.c                         |   79 ++
 arch/riscv/kernel/setup.c                          |   25 +
 arch/riscv/kernel/smpboot.c                        |    3 +-
 arch/riscv/mm/dma-noncoherent.c                    |  103 +-
 arch/riscv/mm/init.c                               |   36 +-
 arch/riscv/mm/pmem.c                               |   13 +
 arch/riscv/net/bpf_jit.h                           |    3 +
 arch/riscv/net/bpf_jit_comp64.c                    |   60 +-
 arch/riscv/net/bpf_jit_core.c                      |  106 +-
 arch/x86/include/asm/microcode_amd.h               |   58 ++
 arch/x86/include/asm/microcode_intel.h             |   88 ++
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    1 +
 drivers/accel/ivpu/ivpu_hw_mtl.c                   | 1053 +++++++++++++++++++
 drivers/accel/ivpu/ivpu_hw_mtl_reg.h               |  281 +++++
 drivers/acpi/acpi_amba.c                           |  130 +++
 drivers/cache/Kconfig                              |   11 +
 drivers/cache/Makefile                             |    3 +
 drivers/cache/ax45mp_cache.c                       |  213 ++++
 drivers/clk/clk-oxnas.c                            |  251 +++++
 drivers/clk/meson/axg-aoclk.h                      |   18 +
 drivers/clk/meson/g12a-aoclk.h                     |   32 +
 drivers/clk/meson/gxbb-aoclk.h                     |   15 +
 drivers/clk/mmp/clk-mmp2.c                         |  454 +++++++++
 drivers/clk/mmp/clk-pxa168.c                       |  354 +++++++
 drivers/clk/mmp/clk-pxa910.c                       |  325 ++++++
 drivers/clk/qcom/lcc-mdm9615.c                     |  572 +++++++++++
 drivers/firmware/efi/libstub/Makefile              |    4 +-
 drivers/firmware/efi/libstub/arm64-stub.c          |  117 +--
 drivers/firmware/efi/libstub/efistub.h             |    8 +
 drivers/firmware/efi/libstub/kaslr.c               |  159 +++
 drivers/firmware/efi/libstub/riscv-stub.c          |   33 +-
 drivers/firmware/imx/scu-pd.c                      |  428 ++++++++
 .../gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c    |  658 ++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c             |  356 +++++++
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.h             |   84 ++
 .../drm/amd/display/dmub/inc/dmub_subvp_state.h    |  183 ++++
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramga102.c  |   40 +
 drivers/soc/renesas/Kconfig                        |    5 +
 include/uapi/linux/elf.h                           |    2 +
 kernel/bpf/core.c                                  |    8 +-
 171 files changed, 17642 insertions(+), 216 deletions(-)
 create mode 100644 Documentation/bpf/instruction-set.rst
 create mode 100644 Documentation/bpf/linux-notes.rst
 create mode 100644 Documentation/devicetree/bindings/arm/msm/ssbi.txt
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,nvec.txt
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-ahb.txt
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-flowctrl.txt
 create mode 100644 Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/hix5hd2-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/oxnas,stdclk.txt
 create mode 100644 Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt
 create mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/brcm,kona-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_f01.txt
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_spi.txt
 create mode 100644 Documentation/devicetree/bindings/net/davicom-dm9000.txt
 create mode 100644 Documentation/devicetree/bindings/net/ftgmac100.txt
 create mode 100644 Documentation/devicetree/bindings/net/oxnas-dwmac.txt
 create mode 100644 Documentation/devicetree/bindings/net/xilinx_gmii2rgmii.txt
 create mode 100644 Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,bcm11351-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/oxnas,pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/ti,omap-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
 create mode 100644 Documentation/devicetree/bindings/pps/pps-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/slg51000.txt
 create mode 100644 Documentation/devicetree/bindings/serial/cavium-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/nxp,lpc1850-uart.txt
 create mode 100644 Documentation/devicetree/bindings/sound/gtm601.txt
 create mode 100644 Documentation/devicetree/bindings/sound/max9892x.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nau8821.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
 create mode 100644 Documentation/devicetree/bindings/sound/wm8904.txt
 create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra20-sflash.txt
 create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra20-slink.txt
 create mode 100644 Documentation/devicetree/bindings/spi/spi-bcm63xx.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt
 create mode 100644 Documentation/devicetree/bindings/usb/samsung-hsotg.txt
 create mode 100644 Documentation/hwmon/smm665.rst
 create mode 100644 Documentation/loongarch/booting.rst
 create mode 100644 Documentation/loongarch/features.rst
 create mode 100644 Documentation/loongarch/index.rst
 create mode 100644 Documentation/loongarch/introduction.rst
 create mode 100644 Documentation/loongarch/irq-chip-model.rst
 create mode 100644 Documentation/mips/booting.rst
 create mode 100644 Documentation/mips/features.rst
 create mode 100644 Documentation/mips/index.rst
 create mode 100644 Documentation/mips/ingenic-tcu.rst
 create mode 100644 Documentation/mm/frontswap.rst
 create mode 100644 Documentation/networking/device_drivers/ethernet/mellanox/mlx5/devlink.rst
 create mode 100644 Documentation/s390/3270.ChangeLog
 create mode 100644 Documentation/s390/3270.rst
 create mode 100644 Documentation/s390/cds.rst
 create mode 100644 Documentation/s390/common_io.rst
 create mode 100644 Documentation/s390/config3270.sh
 create mode 100644 Documentation/s390/driver-model.rst
 create mode 100644 Documentation/s390/features.rst
 create mode 100644 Documentation/s390/index.rst
 create mode 100644 Documentation/s390/monreader.rst
 create mode 100644 Documentation/s390/pci.rst
 create mode 100644 Documentation/s390/qeth.rst
 create mode 100644 Documentation/s390/s390dbf.rst
 create mode 100644 Documentation/s390/text_files.rst
 create mode 100644 Documentation/s390/vfio-ap-locking.rst
 create mode 100644 Documentation/s390/vfio-ap.rst
 create mode 100644 Documentation/s390/vfio-ccw.rst
 create mode 100644 Documentation/s390/zfcpdump.rst
 create mode 100644 Documentation/translations/zh_CN/loongarch/booting.rst
 create mode 100644 Documentation/translations/zh_CN/loongarch/features.rst
 create mode 100644 Documentation/translations/zh_CN/loongarch/index.rst
 create mode 100644 Documentation/translations/zh_CN/loongarch/introduction.rst
 create mode 100644 Documentation/translations/zh_CN/loongarch/irq-chip-model.rst
 create mode 100644 Documentation/translations/zh_CN/mips/booting.rst
 create mode 100644 Documentation/translations/zh_CN/mips/features.rst
 create mode 100644 Documentation/translations/zh_CN/mips/index.rst
 create mode 100644 Documentation/translations/zh_CN/mips/ingenic-tcu.rst
 create mode 100644 Documentation/translations/zh_CN/mm/frontswap.rst
 create mode 100644 arch/arm/mach-keystone/keystone.h
 create mode 100644 arch/arm/mach-keystone/memory.h
 create mode 100644 arch/arm/mach-keystone/pm_domain.c
 create mode 100644 arch/arm/mach-nspire/mmio.h
 create mode 100644 arch/arm/mach-ux500/pm_domains.c
 create mode 100644 arch/arm/mach-ux500/pm_domains.h
 create mode 100644 arch/arm/vfp/entry.S
 create mode 120000 arch/arm64/boot/dts/arm/vexpress-v2m-rs1.dtsi
 create mode 100644 arch/hexagon/mm/ioremap.c
 create mode 100644 arch/parisc/include/asm/machdep.h
 create mode 100644 arch/parisc/kernel/pa7300lc.c
 create mode 100644 arch/powerpc/include/asm/mpc8260.h
 create mode 100644 arch/powerpc/kernel/trace/ftrace_64_pg.S
 create mode 100644 arch/powerpc/kernel/trace/ftrace_low.S
 create mode 100644 arch/powerpc/kernel/trace/ftrace_mprofile.S
 create mode 100644 arch/powerpc/lib/alloc.c
 create mode 100644 arch/powerpc/platforms/82xx/m82xx_pci.h
 create mode 100644 arch/powerpc/platforms/83xx/usb.c
 create mode 100644 arch/riscv/errata/andes/Makefile
 create mode 100644 arch/riscv/errata/andes/errata.c
 create mode 100644 arch/riscv/include/asm/dma-noncoherent.h
 create mode 100644 arch/riscv/kernel/copy-unaligned.S
 create mode 100644 arch/riscv/kernel/copy-unaligned.h
 create mode 100644 arch/riscv/kernel/pi/fdt_early.c
 create mode 100644 arch/x86/include/asm/microcode_amd.h
 create mode 100644 arch/x86/include/asm/microcode_intel.h
 create mode 100644 drivers/accel/ivpu/ivpu_hw_mtl.c
 create mode 100644 drivers/accel/ivpu/ivpu_hw_mtl_reg.h
 create mode 100644 drivers/acpi/acpi_amba.c
 create mode 100644 drivers/cache/Kconfig
 create mode 100644 drivers/cache/Makefile
 create mode 100644 drivers/cache/ax45mp_cache.c
 create mode 100644 drivers/clk/clk-oxnas.c
 create mode 100644 drivers/clk/meson/axg-aoclk.h
 create mode 100644 drivers/clk/meson/g12a-aoclk.h
 create mode 100644 drivers/clk/meson/gxbb-aoclk.h
 create mode 100644 drivers/clk/mmp/clk-mmp2.c
 create mode 100644 drivers/clk/mmp/clk-pxa168.c
 create mode 100644 drivers/clk/mmp/clk-pxa910.c
 create mode 100644 drivers/clk/qcom/lcc-mdm9615.c
 create mode 100644 drivers/firmware/efi/libstub/kaslr.c
 create mode 100644 drivers/firmware/imx/scu-pd.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_iommu.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/inc/dmub_subvp_state.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramga102.c
