Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A4D79E17A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjIMIGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjIMIGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:06:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BEA1993;
        Wed, 13 Sep 2023 01:06:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBDAC433C9;
        Wed, 13 Sep 2023 08:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694592390;
        bh=hMngqCIqxH0xerZqGubTyiP9mKXetf4yITLHiyB4yWo=;
        h=From:To:Cc:Subject:Date:From;
        b=M9akYy+lB76zOptQyAXjqrRhORkUFsGg+aj8tl7WeGOte0AY+WA5SodpYr8wFERRK
         ei20ZoSAsSPQy5etfMb3HjgPDJqLY43H7GxhOHf/z+PqUWc6usWknCvj9u1GQryJgI
         popjgqCKwiEjjvKoRusUQBk5Z7zWddcwDPGiHIx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.4.16
Date:   Wed, 13 Sep 2023 10:06:24 +0200
Message-ID: <2023091345-prankish-during-e3b4@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.4.16 kernel.

NOTE, this is the LAST 6.4.y release, this branch is now end-of-life.
All users must move to the 6.5.y branch at this point in time.

The updated 6.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-bus-fsi-devices-sbefifo             |    6 
 Documentation/ABI/testing/sysfs-driver-chromeos-acpi                |    2 
 Documentation/ABI/testing/sysfs-fs-f2fs                             |    8 
 Documentation/devicetree/bindings/clock/qcom,qdu1000-gcc.yaml       |    3 
 Documentation/devicetree/bindings/extcon/maxim,max77843.yaml        |    1 
 Documentation/devicetree/bindings/regulator/qcom,rpm-regulator.yaml |    2 
 Documentation/scsi/scsi_mid_low_api.rst                             |    4 
 Documentation/userspace-api/media/v4l/vidioc-subdev-g-routing.rst   |    7 
 Makefile                                                            |    6 
 arch/arm/boot/dts/Makefile                                          |    8 
 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts                       |   14 
 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts                        |   15 
 arch/arm/boot/dts/bcm47189-tenda-ac9.dts                            |    4 
 arch/arm/boot/dts/bcm53573.dtsi                                     |    5 
 arch/arm/boot/dts/bcm947189acdbmr.dts                               |    6 
 arch/arm/boot/dts/integratorap.dts                                  |    2 
 arch/arm/boot/dts/qcom-ipq4019.dtsi                                 |    9 
 arch/arm/boot/dts/qcom-sdx65-mtp.dts                                |    2 
 arch/arm/boot/dts/s3c6410-mini6410.dts                              |    2 
 arch/arm/boot/dts/s5pv210-smdkv210.dts                              |   10 
 arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi                    |   10 
 arch/arm/boot/dts/stm32mp157c-odyssey-som.dtsi                      |    4 
 arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi                        |   22 
 arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi                  |   38 
 arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi                        |    4 
 arch/arm/include/asm/syscall.h                                      |    3 
 arch/arm/kernel/entry-common.S                                      |    1 
 arch/arm/kernel/ptrace.c                                            |    5 
 arch/arm/mach-omap2/powerdomain.c                                   |    2 
 arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts              |   22 
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts                       |    1 
 arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts       |    1 
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts                            |  188 --
 arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts                    |  129 -
 arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts                |  134 --
 arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts                      |  130 -
 arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts                  |  130 -
 arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts                      |  159 --
 arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts                |  132 -
 arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts                |  144 --
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi                          |    2 
 arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi                        |  102 +
 arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi          |  150 --
 arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts                |   12 
 arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts                |    6 
 arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi          |    6 
 arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts               |    6 
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi            |  124 -
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts                  |   12 
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt58.dts                   |    8 
 arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi             |  119 -
 arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts              |  145 --
 arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts                     |    8 
 arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts                   |   10 
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi                           |  105 -
 arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts               |  135 --
 arch/arm64/boot/dts/qcom/msm8916-yiming-uz801v3.dts                 |    8 
 arch/arm64/boot/dts/qcom/msm8916.dtsi                               |    5 
 arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dts                  |    2 
 arch/arm64/boot/dts/qcom/msm8996.dtsi                               |    5 
 arch/arm64/boot/dts/qcom/msm8998.dtsi                               |    8 
 arch/arm64/boot/dts/qcom/pm6150l.dtsi                               |    5 
 arch/arm64/boot/dts/qcom/pm660l.dtsi                                |    5 
 arch/arm64/boot/dts/qcom/pm8350.dtsi                                |    2 
 arch/arm64/boot/dts/qcom/pm8350b.dtsi                               |    2 
 arch/arm64/boot/dts/qcom/pm8916.dtsi                                |    1 
 arch/arm64/boot/dts/qcom/pmi8950.dtsi                               |    5 
 arch/arm64/boot/dts/qcom/pmi8994.dtsi                               |    5 
 arch/arm64/boot/dts/qcom/pmk8350.dtsi                               |    2 
 arch/arm64/boot/dts/qcom/pmr735b.dtsi                               |    2 
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts                           |    4 
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts          |    2 
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi                              |    1 
 arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi               |    9 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                                |    3 
 arch/arm64/boot/dts/qcom/sm6350.dtsi                                |   10 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                                |    6 
 arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts          |  233 +++
 arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts          |  243 +++
 arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi                |   54 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                                |   11 
 arch/arm64/boot/dts/qcom/sm8350.dtsi                                |   31 
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts                             |    1 
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts                             |    1 
 arch/arm64/boot/dts/rockchip/rk3399-eaidk-610.dts                   |    2 
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts             |    2 
 arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts                    |    2 
 arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts                   |   24 
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi                      |    2 
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi                          |    2 
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi                    |    2 
 arch/arm64/configs/defconfig                                        |    2 
 arch/arm64/include/asm/sdei.h                                       |    6 
 arch/arm64/kernel/entry.S                                           |   27 
 arch/arm64/kernel/fpsimd.c                                          |   22 
 arch/arm64/kernel/ptrace.c                                          |    3 
 arch/arm64/kernel/sdei.c                                            |    3 
 arch/arm64/kernel/smp.c                                             |    8 
 arch/arm64/lib/csum.c                                               |    2 
 arch/arm64/mm/hugetlbpage.c                                         |    2 
 arch/loongarch/Makefile                                             |    2 
 arch/loongarch/include/asm/fpu.h                                    |   22 
 arch/loongarch/include/asm/local.h                                  |    4 
 arch/loongarch/include/asm/pgtable.h                                |    3 
 arch/loongarch/kernel/ptrace.c                                      |    2 
 arch/loongarch/kernel/setup.c                                       |   16 
 arch/m68k/fpsp040/skeleton.S                                        |    4 
 arch/m68k/ifpsp060/os.S                                             |    4 
 arch/m68k/kernel/relocate_kernel.S                                  |    4 
 arch/mips/include/asm/local.h                                       |    4 
 arch/parisc/kernel/processor.c                                      |   13 
 arch/powerpc/include/asm/ftrace.h                                   |    2 
 arch/powerpc/include/asm/lppaca.h                                   |   13 
 arch/powerpc/include/asm/paca.h                                     |    6 
 arch/powerpc/include/asm/paravirt.h                                 |    1 
 arch/powerpc/include/asm/plpar_wrappers.h                           |    1 
 arch/powerpc/kernel/fadump.c                                        |    1 
 arch/powerpc/kernel/iommu.c                                         |   17 
 arch/powerpc/kvm/book3s_hv_ras.c                                    |    1 
 arch/powerpc/mm/book3s64/radix_tlb.c                                |  240 +--
 arch/powerpc/mm/book3s64/slb.c                                      |    1 
 arch/powerpc/perf/core-fsl-emb.c                                    |    8 
 arch/powerpc/platforms/powermac/time.c                              |    6 
 arch/powerpc/platforms/pseries/hvCall.S                             |    1 
 arch/powerpc/platforms/pseries/lpar.c                               |   10 
 arch/powerpc/platforms/pseries/lparcfg.c                            |    4 
 arch/powerpc/platforms/pseries/setup.c                              |    2 
 arch/powerpc/sysdev/mpc5xxx_clocks.c                                |    4 
 arch/powerpc/xmon/xmon.c                                            |    1 
 arch/riscv/mm/kasan_init.c                                          |    8 
 arch/s390/crypto/paes_s390.c                                        |    2 
 arch/s390/include/uapi/asm/pkey.h                                   |    2 
 arch/s390/kernel/ipl.c                                              |    2 
 arch/um/configs/i386_defconfig                                      |    1 
 arch/um/configs/x86_64_defconfig                                    |    1 
 arch/um/drivers/Kconfig                                             |   16 
 arch/um/drivers/Makefile                                            |    2 
 arch/um/drivers/virt-pci.c                                          |    2 
 arch/x86/boot/compressed/head_64.S                                  |   30 
 arch/x86/events/intel/uncore_snbep.c                                |   12 
 arch/x86/hyperv/hv_vtl.c                                            |    4 
 arch/x86/include/asm/local.h                                        |    4 
 arch/x86/include/asm/mem_encrypt.h                                  |    6 
 arch/x86/include/asm/pgtable_types.h                                |   11 
 arch/x86/kernel/apm_32.c                                            |    6 
 arch/x86/kernel/cpu/common.c                                        |    8 
 arch/x86/kernel/cpu/mce/core.c                                      |   26 
 arch/x86/kernel/cpu/mce/internal.h                                  |    5 
 arch/x86/kernel/cpu/sgx/virt.c                                      |    3 
 arch/x86/kernel/kvm.c                                               |    4 
 arch/x86/kernel/vmlinux.lds.S                                       |    2 
 arch/x86/kvm/mmu/mmu.c                                              |   41 
 arch/x86/mm/mem_encrypt_amd.c                                       |   13 
 arch/xtensa/include/asm/core.h                                      |    9 
 arch/xtensa/kernel/perf_event.c                                     |   17 
 block/blk-cgroup.c                                                  |   32 
 block/blk-settings.c                                                |    7 
 block/blk-sysfs.c                                                   |   21 
 block/ioctl.c                                                       |    2 
 block/mq-deadline.c                                                 |    3 
 crypto/af_alg.c                                                     |    3 
 crypto/algapi.c                                                     |   16 
 crypto/asymmetric_keys/x509_public_key.c                            |    5 
 drivers/acpi/x86/s2idle.c                                           |   39 
 drivers/amba/bus.c                                                  |    1 
 drivers/ata/pata_arasan_cf.c                                        |    3 
 drivers/base/core.c                                                 |   11 
 drivers/base/dd.c                                                   |    2 
 drivers/base/regmap/regcache-maple.c                                |   70 -
 drivers/base/regmap/regcache-rbtree.c                               |   10 
 drivers/base/test/test_async_driver_probe.c                         |    2 
 drivers/bluetooth/btintel.c                                         |    6 
 drivers/bluetooth/btrtl.c                                           |   74 -
 drivers/bluetooth/btusb.c                                           |    2 
 drivers/bluetooth/hci_nokia.c                                       |    6 
 drivers/bus/ti-sysc.c                                               |    2 
 drivers/char/hw_random/iproc-rng200.c                               |   25 
 drivers/char/hw_random/nomadik-rng.c                                |   12 
 drivers/char/hw_random/pic32-rng.c                                  |   19 
 drivers/char/ipmi/ipmi_si_intf.c                                    |    5 
 drivers/char/ipmi/ipmi_ssif.c                                       |    7 
 drivers/char/tpm/tpm_crb.c                                          |   33 
 drivers/clk/Kconfig                                                 |    1 
 drivers/clk/imx/clk-composite-8m.c                                  |   12 
 drivers/clk/imx/clk-imx8mp.c                                        |    5 
 drivers/clk/imx/clk-imx8ulp.c                                       |    2 
 drivers/clk/imx/clk-pllv4.c                                         |   46 
 drivers/clk/imx/clk.h                                               |    1 
 drivers/clk/keystone/pll.c                                          |    2 
 drivers/clk/qcom/dispcc-sc8280xp.c                                  |    8 
 drivers/clk/qcom/gcc-qdu1000.c                                      |   34 
 drivers/clk/qcom/gcc-sc7180.c                                       |    1 
 drivers/clk/qcom/gcc-sc8280xp.c                                     |  121 +
 drivers/clk/qcom/gcc-sm6350.c                                       |    1 
 drivers/clk/qcom/gcc-sm7150.c                                       |    1 
 drivers/clk/qcom/gcc-sm8250.c                                       |    1 
 drivers/clk/qcom/gcc-sm8450.c                                       |    4 
 drivers/clk/qcom/gpucc-sm6350.c                                     |   18 
 drivers/clk/qcom/reset.c                                            |    3 
 drivers/clk/rockchip/clk-rk3568.c                                   |    2 
 drivers/clk/sunxi-ng/ccu_mmc_timing.c                               |    2 
 drivers/cpufreq/amd-pstate-ut.c                                     |   46 
 drivers/cpufreq/brcmstb-avs-cpufreq.c                               |    6 
 drivers/cpufreq/cpufreq.c                                           |    2 
 drivers/cpufreq/intel_pstate.c                                      |    5 
 drivers/cpufreq/powernow-k8.c                                       |    3 
 drivers/cpufreq/tegra194-cpufreq.c                                  |   29 
 drivers/cpuidle/cpuidle-pseries.c                                   |    8 
 drivers/cpuidle/governors/teo.c                                     |   40 
 drivers/crypto/caam/caampkc.c                                       |    4 
 drivers/crypto/intel/qat/qat_common/adf_gen4_pm.h                   |    2 
 drivers/crypto/stm32/stm32-hash.c                                   |   11 
 drivers/devfreq/devfreq.c                                           |    1 
 drivers/dma/Kconfig                                                 |    2 
 drivers/dma/idxd/sysfs.c                                            |   33 
 drivers/dma/ste_dma40.c                                             |    4 
 drivers/edac/i10nm_base.c                                           |   54 
 drivers/edac/igen6_edac.c                                           |    8 
 drivers/extcon/Kconfig                                              |    1 
 drivers/firmware/arm_sdei.c                                         |   19 
 drivers/firmware/cirrus/cs_dsp.c                                    |    3 
 drivers/firmware/efi/libstub/x86-stub.c                             |    2 
 drivers/firmware/meson/meson_sm.c                                   |    2 
 drivers/firmware/ti_sci.c                                           |   36 
 drivers/fsi/fsi-master-aspeed.c                                     |    2 
 drivers/gpio/gpiolib.c                                              |   16 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                          |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                             |   14 
 drivers/gpu/drm/amd/amdgpu/cik.c                                    |   36 
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c                              |   15 
 drivers/gpu/drm/amd/amdgpu/si.c                                     |   36 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                   |   24 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c              |   12 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c          |   20 
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c         |    3 
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c                 |    1 
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c                   |    3 
 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c              |    2 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                                  |   10 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c                |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c                |    9 
 drivers/gpu/drm/armada/armada_overlay.c                             |    6 
 drivers/gpu/drm/ast/ast_dp.c                                        |   11 
 drivers/gpu/drm/ast/ast_dp501.c                                     |   37 
 drivers/gpu/drm/ast/ast_drv.h                                       |    2 
 drivers/gpu/drm/ast/ast_mode.c                                      |   30 
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c                        |    9 
 drivers/gpu/drm/bridge/analogix/anx7625.c                           |   12 
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c                       |   28 
 drivers/gpu/drm/bridge/tc358764.c                                   |    2 
 drivers/gpu/drm/etnaviv/etnaviv_dump.c                              |   14 
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c                             |    1 
 drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c                     |    2 
 drivers/gpu/drm/mediatek/mtk_dp.c                                   |   15 
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c                             |    7 
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c                         |   16 
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                              |    7 
 drivers/gpu/drm/mediatek/mtk_drm_gem.c                              |    6 
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c                               |    8 
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c                               |   11 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                               |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_3_0_msm8998.h             |    1 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_4_0_sdm845.h              |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h              |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h             |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h              |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h              |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h              |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h            |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h              |    2 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h              |    6 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c                 |    3 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c                      |   56 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h                      |   18 
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c                          |    3 
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c                   |    2 
 drivers/gpu/drm/panel/panel-simple.c                                |    4 
 drivers/gpu/drm/radeon/cik.c                                        |   36 
 drivers/gpu/drm/radeon/si.c                                         |   37 
 drivers/gpu/drm/tegra/dpaux.c                                       |    2 
 drivers/gpu/drm/tiny/repaper.c                                      |    2 
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c                                 |    4 
 drivers/hid/hid-input.c                                             |   18 
 drivers/hid/hid-logitech-dj.c                                       |    5 
 drivers/hid/hid-logitech-hidpp.c                                    |  115 +
 drivers/hid/hid-multitouch.c                                        |   13 
 drivers/hid/hid-uclogic-core.c                                      |   13 
 drivers/hv/vmbus_drv.c                                              |    3 
 drivers/hwmon/tmp513.c                                              |    2 
 drivers/hwtracing/coresight/coresight-tmc-etf.c                     |    2 
 drivers/hwtracing/coresight/coresight-tmc-etr.c                     |    5 
 drivers/hwtracing/coresight/coresight-tmc.h                         |    2 
 drivers/hwtracing/coresight/coresight-trbe.c                        |   32 
 drivers/i2c/busses/i2c-imx-lpi2c.c                                  |    3 
 drivers/i3c/master/svc-i3c-master.c                                 |   14 
 drivers/iio/accel/adxl313_i2c.c                                     |    4 
 drivers/infiniband/core/uverbs_std_types_counters.c                 |    2 
 drivers/infiniband/hw/bnxt_re/bnxt_re.h                             |    1 
 drivers/infiniband/hw/bnxt_re/main.c                                |    5 
 drivers/infiniband/hw/efa/efa_verbs.c                               |    6 
 drivers/infiniband/hw/hns/hns_roce_device.h                         |    1 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                          |   11 
 drivers/infiniband/hw/hns/hns_roce_main.c                           |    7 
 drivers/infiniband/hw/hns/hns_roce_qp.c                             |   28 
 drivers/infiniband/hw/irdma/ctrl.c                                  |    6 
 drivers/infiniband/hw/irdma/main.h                                  |    2 
 drivers/infiniband/hw/irdma/type.h                                  |    2 
 drivers/infiniband/hw/irdma/verbs.c                                 |   11 
 drivers/infiniband/sw/rxe/rxe_comp.c                                |    4 
 drivers/infiniband/sw/rxe/rxe_loc.h                                 |    6 
 drivers/infiniband/sw/rxe/rxe_qp.c                                  |  159 +-
 drivers/infiniband/sw/rxe/rxe_req.c                                 |   45 
 drivers/infiniband/sw/rxe/rxe_resp.c                                |    4 
 drivers/infiniband/sw/rxe/rxe_srq.c                                 |   60 
 drivers/infiniband/sw/siw/siw.h                                     |    1 
 drivers/infiniband/sw/siw/siw_cm.c                                  |    1 
 drivers/infiniband/sw/siw/siw_main.c                                |   22 
 drivers/infiniband/sw/siw/siw_verbs.c                               |    6 
 drivers/infiniband/ulp/isert/ib_isert.c                             |    2 
 drivers/infiniband/ulp/srp/ib_srp.c                                 |    4 
 drivers/input/serio/i8042-acpipnpio.h                               |    7 
 drivers/interconnect/qcom/bcm-voter.c                               |   43 
 drivers/interconnect/qcom/qcm2290.c                                 |    1 
 drivers/interconnect/qcom/sm8450.c                                  |    1 
 drivers/iommu/amd/iommu_v2.c                                        |    4 
 drivers/iommu/arm/arm-smmu/qcom_iommu.c                             |    7 
 drivers/iommu/intel/pasid.c                                         |    2 
 drivers/iommu/iommu.c                                               |    4 
 drivers/iommu/iommufd/device.c                                      |    2 
 drivers/iommu/mtk_iommu.c                                           |   22 
 drivers/iommu/rockchip-iommu.c                                      |   43 
 drivers/iommu/sprd-iommu.c                                          |    1 
 drivers/irqchip/irq-loongson-eiointc.c                              |    2 
 drivers/leds/led-class-multicolor.c                                 |    8 
 drivers/leds/led-core.c                                             |    8 
 drivers/leds/leds-pwm.c                                             |    2 
 drivers/leds/trigger/ledtrig-tty.c                                  |   12 
 drivers/md/md-bitmap.c                                              |    9 
 drivers/md/md.c                                                     |    6 
 drivers/md/raid0.c                                                  |   82 -
 drivers/md/raid10.c                                                 |   42 
 drivers/md/raid5-cache.c                                            |   12 
 drivers/media/cec/core/cec-adap.c                                   |    8 
 drivers/media/cec/usb/pulse8/pulse8-cec.c                           |    7 
 drivers/media/dvb-frontends/ascot2e.c                               |    2 
 drivers/media/dvb-frontends/atbm8830.c                              |    2 
 drivers/media/dvb-frontends/au8522_dig.c                            |    2 
 drivers/media/dvb-frontends/bcm3510.c                               |    2 
 drivers/media/dvb-frontends/cx22700.c                               |    2 
 drivers/media/dvb-frontends/cx22702.c                               |    2 
 drivers/media/dvb-frontends/cx24110.c                               |    2 
 drivers/media/dvb-frontends/cx24113.c                               |    2 
 drivers/media/dvb-frontends/cx24116.c                               |    2 
 drivers/media/dvb-frontends/cx24120.c                               |    6 
 drivers/media/dvb-frontends/cx24123.c                               |    2 
 drivers/media/dvb-frontends/cxd2820r_core.c                         |    2 
 drivers/media/dvb-frontends/cxd2841er.c                             |    4 
 drivers/media/dvb-frontends/cxd2880/cxd2880_top.c                   |    2 
 drivers/media/dvb-frontends/dib0070.c                               |    2 
 drivers/media/dvb-frontends/dib0090.c                               |    4 
 drivers/media/dvb-frontends/dib3000mb.c                             |    2 
 drivers/media/dvb-frontends/dib3000mc.c                             |    2 
 drivers/media/dvb-frontends/dib7000m.c                              |    2 
 drivers/media/dvb-frontends/dib7000p.c                              |    4 
 drivers/media/dvb-frontends/dib8000.c                               |    2 
 drivers/media/dvb-frontends/dib9000.c                               |    2 
 drivers/media/dvb-frontends/drx39xyj/drxj.c                         |    2 
 drivers/media/dvb-frontends/drxd_hard.c                             |    2 
 drivers/media/dvb-frontends/drxk_hard.c                             |    2 
 drivers/media/dvb-frontends/ds3000.c                                |    2 
 drivers/media/dvb-frontends/dvb-pll.c                               |    2 
 drivers/media/dvb-frontends/ec100.c                                 |    2 
 drivers/media/dvb-frontends/helene.c                                |    4 
 drivers/media/dvb-frontends/horus3a.c                               |    2 
 drivers/media/dvb-frontends/isl6405.c                               |    2 
 drivers/media/dvb-frontends/isl6421.c                               |    2 
 drivers/media/dvb-frontends/isl6423.c                               |    2 
 drivers/media/dvb-frontends/itd1000.c                               |    2 
 drivers/media/dvb-frontends/ix2505v.c                               |    2 
 drivers/media/dvb-frontends/l64781.c                                |    2 
 drivers/media/dvb-frontends/lg2160.c                                |    2 
 drivers/media/dvb-frontends/lgdt3305.c                              |    2 
 drivers/media/dvb-frontends/lgdt3306a.c                             |    2 
 drivers/media/dvb-frontends/lgdt330x.c                              |    2 
 drivers/media/dvb-frontends/lgs8gxx.c                               |    2 
 drivers/media/dvb-frontends/lnbh25.c                                |    2 
 drivers/media/dvb-frontends/lnbp21.c                                |    4 
 drivers/media/dvb-frontends/lnbp22.c                                |    2 
 drivers/media/dvb-frontends/m88ds3103.c                             |    2 
 drivers/media/dvb-frontends/m88rs2000.c                             |    2 
 drivers/media/dvb-frontends/mb86a16.c                               |    2 
 drivers/media/dvb-frontends/mb86a20s.c                              |    2 
 drivers/media/dvb-frontends/mt312.c                                 |    2 
 drivers/media/dvb-frontends/mt352.c                                 |    2 
 drivers/media/dvb-frontends/nxt200x.c                               |    2 
 drivers/media/dvb-frontends/nxt6000.c                               |    2 
 drivers/media/dvb-frontends/or51132.c                               |    2 
 drivers/media/dvb-frontends/or51211.c                               |    2 
 drivers/media/dvb-frontends/s5h1409.c                               |    2 
 drivers/media/dvb-frontends/s5h1411.c                               |    2 
 drivers/media/dvb-frontends/s5h1420.c                               |    2 
 drivers/media/dvb-frontends/s5h1432.c                               |    2 
 drivers/media/dvb-frontends/s921.c                                  |    2 
 drivers/media/dvb-frontends/si21xx.c                                |    2 
 drivers/media/dvb-frontends/sp887x.c                                |    2 
 drivers/media/dvb-frontends/stb0899_drv.c                           |    2 
 drivers/media/dvb-frontends/stb6000.c                               |    2 
 drivers/media/dvb-frontends/stb6100.c                               |    2 
 drivers/media/dvb-frontends/stv0288.c                               |    2 
 drivers/media/dvb-frontends/stv0297.c                               |    2 
 drivers/media/dvb-frontends/stv0299.c                               |    2 
 drivers/media/dvb-frontends/stv0367.c                               |    6 
 drivers/media/dvb-frontends/stv0900_core.c                          |    2 
 drivers/media/dvb-frontends/stv090x.c                               |    2 
 drivers/media/dvb-frontends/stv6110.c                               |    2 
 drivers/media/dvb-frontends/stv6110x.c                              |    2 
 drivers/media/dvb-frontends/tda10021.c                              |    2 
 drivers/media/dvb-frontends/tda10023.c                              |    2 
 drivers/media/dvb-frontends/tda10048.c                              |    2 
 drivers/media/dvb-frontends/tda1004x.c                              |    4 
 drivers/media/dvb-frontends/tda10086.c                              |    2 
 drivers/media/dvb-frontends/tda665x.c                               |    2 
 drivers/media/dvb-frontends/tda8083.c                               |    2 
 drivers/media/dvb-frontends/tda8261.c                               |    2 
 drivers/media/dvb-frontends/tda826x.c                               |    2 
 drivers/media/dvb-frontends/ts2020.c                                |    2 
 drivers/media/dvb-frontends/tua6100.c                               |    2 
 drivers/media/dvb-frontends/ves1820.c                               |    2 
 drivers/media/dvb-frontends/ves1x93.c                               |    2 
 drivers/media/dvb-frontends/zl10036.c                               |    2 
 drivers/media/dvb-frontends/zl10039.c                               |    2 
 drivers/media/dvb-frontends/zl10353.c                               |    2 
 drivers/media/i2c/Kconfig                                           |   13 
 drivers/media/i2c/ad5820.c                                          |    2 
 drivers/media/i2c/ccs/ccs-data.c                                    |  101 -
 drivers/media/i2c/imx290.c                                          |    7 
 drivers/media/i2c/ov2680.c                                          |  330 +---
 drivers/media/i2c/ov5640.c                                          |   22 
 drivers/media/i2c/rdacm21.c                                         |    2 
 drivers/media/i2c/tvp5150.c                                         |    4 
 drivers/media/pci/Kconfig                                           |    2 
 drivers/media/pci/bt8xx/dst.c                                       |    2 
 drivers/media/pci/bt8xx/dst_ca.c                                    |    2 
 drivers/media/pci/cx23885/cx23885-dvb.c                             |   12 
 drivers/media/pci/ddbridge/ddbridge-dummy-fe.c                      |    2 
 drivers/media/pci/intel/Kconfig                                     |   10 
 drivers/media/pci/intel/Makefile                                    |    4 
 drivers/media/pci/intel/ipu-bridge.c                                |  502 +++++++
 drivers/media/pci/intel/ipu-bridge.h                                |  153 ++
 drivers/media/pci/intel/ipu3/Kconfig                                |    1 
 drivers/media/pci/intel/ipu3/Makefile                               |    1 
 drivers/media/pci/intel/ipu3/cio2-bridge.c                          |  494 -------
 drivers/media/pci/intel/ipu3/cio2-bridge.h                          |  146 --
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c                       |    4 
 drivers/media/pci/intel/ipu3/ipu3-cio2.h                            |    6 
 drivers/media/platform/amphion/vdec.c                               |   41 
 drivers/media/platform/amphion/venc.c                               |    6 
 drivers/media/platform/amphion/vpu.h                                |    3 
 drivers/media/platform/amphion/vpu_cmds.c                           |   16 
 drivers/media/platform/amphion/vpu_core.c                           |    2 
 drivers/media/platform/amphion/vpu_dbg.c                            |   17 
 drivers/media/platform/amphion/vpu_helpers.c                        |   61 
 drivers/media/platform/amphion/vpu_mbox.c                           |    9 
 drivers/media/platform/amphion/vpu_msgs.c                           |   14 
 drivers/media/platform/amphion/vpu_v4l2.c                           |    7 
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c                |    1 
 drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c           |    5 
 drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c             |    2 
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg-hw.h                   |    1 
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c                      |  135 --
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h                      |    5 
 drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c             |    2 
 drivers/media/platform/qcom/venus/hfi_venus.c                       |   20 
 drivers/media/platform/verisilicon/hantro_v4l2.c                    |    9 
 drivers/media/tuners/fc0011.c                                       |    2 
 drivers/media/tuners/fc0012.c                                       |    2 
 drivers/media/tuners/fc0013.c                                       |    2 
 drivers/media/tuners/max2165.c                                      |    2 
 drivers/media/tuners/mc44s803.c                                     |    2 
 drivers/media/tuners/mt2060.c                                       |    2 
 drivers/media/tuners/mt2131.c                                       |    2 
 drivers/media/tuners/mt2266.c                                       |    2 
 drivers/media/tuners/mxl5005s.c                                     |    2 
 drivers/media/tuners/qt1010.c                                       |    2 
 drivers/media/tuners/tda18218.c                                     |    2 
 drivers/media/tuners/xc2028.c                                       |    2 
 drivers/media/tuners/xc4000.c                                       |    2 
 drivers/media/tuners/xc5000.c                                       |    2 
 drivers/media/usb/dvb-usb/m920x.c                                   |    5 
 drivers/media/usb/go7007/go7007-i2c.c                               |    2 
 drivers/media/usb/siano/smsusb.c                                    |   21 
 drivers/media/v4l2-core/v4l2-fwnode.c                               |   18 
 drivers/misc/fastrpc.c                                              |   13 
 drivers/mmc/host/renesas_sdhi_core.c                                |   10 
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                            |    7 
 drivers/mtd/nand/raw/fsmc_nand.c                                    |    7 
 drivers/mtd/spi-nor/core.c                                          |   19 
 drivers/net/arcnet/arcnet.c                                         |    2 
 drivers/net/can/m_can/tcan4x5x-regmap.c                             |    1 
 drivers/net/can/usb/gs_usb.c                                        |    5 
 drivers/net/dsa/microchip/ksz_common.c                              |   35 
 drivers/net/ethernet/amd/pds_core/core.c                            |   11 
 drivers/net/ethernet/amd/pds_core/dev.c                             |    9 
 drivers/net/ethernet/amd/pds_core/devlink.c                         |    3 
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c                     |    7 
 drivers/net/ethernet/broadcom/b44.c                                 |    8 
 drivers/net/ethernet/hisilicon/hns3/Makefile                        |    4 
 drivers/net/ethernet/hisilicon/hns3/hnae3.h                         |    5 
 drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c    |    1 
 drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h    |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c                  |    3 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h              |    4 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c              |   34 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c          |    1 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c             |  565 --------
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h             |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.c             |  668 ++++++++++
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_regs.h             |   17 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c               |   33 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h               |    5 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c           |  121 -
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h           |    1 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.c           |  127 +
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_regs.h           |   13 
 drivers/net/ethernet/intel/ice/ice_main.c                           |   13 
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c                         |   55 
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h                         |    3 
 drivers/net/ethernet/intel/igb/igb_main.c                           |   11 
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c                     |   17 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c                 |   45 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c            |   68 -
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h            |    3 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_dcbnl.c             |   19 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c                |   13 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c                |    4 
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c                  |    9 
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c                 |   32 
 drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c                    |    3 
 drivers/net/ethernet/mellanox/mlxsw/i2c.c                           |    5 
 drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c                |    4 
 drivers/net/ethernet/realtek/r8169_main.c                           |    4 
 drivers/net/ethernet/sfc/ptp.c                                      |    4 
 drivers/net/macsec.c                                                |    3 
 drivers/net/phy/sfp-bus.c                                           |   10 
 drivers/net/usb/qmi_wwan.c                                          |    1 
 drivers/net/wireless/ath/ath10k/pci.c                               |    9 
 drivers/net/wireless/ath/ath11k/dp_rx.c                             |    2 
 drivers/net/wireless/ath/ath11k/pci.c                               |   10 
 drivers/net/wireless/ath/ath12k/mac.c                               |    4 
 drivers/net/wireless/ath/ath12k/pci.c                               |   10 
 drivers/net/wireless/ath/ath12k/wmi.c                               |    3 
 drivers/net/wireless/ath/ath6kl/Makefile                            |    5 
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c                      |    2 
 drivers/net/wireless/ath/ath9k/wmi.c                                |   20 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h       |    7 
 drivers/net/wireless/marvell/mwifiex/debugfs.c                      |    9 
 drivers/net/wireless/marvell/mwifiex/pcie.c                         |   25 
 drivers/net/wireless/marvell/mwifiex/sta_rx.c                       |   12 
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c                     |   30 
 drivers/net/wireless/marvell/mwifiex/util.c                         |   10 
 drivers/net/wireless/mediatek/mt76/mt76.h                           |    2 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c                |   11 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h                |    1 
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                    |    7 
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                    |   93 +
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                     |  105 +
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c                    |   30 
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                  |   15 
 drivers/net/wireless/mediatek/mt76/mt7921/init.c                    |    3 
 drivers/net/wireless/mediatek/mt76/mt7996/dma.c                     |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                     |   13 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                     |   11 
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h                  |    1 
 drivers/net/wireless/mediatek/mt76/testmode.c                       |    1 
 drivers/net/wireless/mediatek/mt76/tx.c                             |    9 
 drivers/net/wireless/realtek/rtw89/debug.c                          |    8 
 drivers/net/wireless/realtek/rtw89/fw.c                             |   27 
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c                   |    4 
 drivers/ntb/ntb_transport.c                                         |   19 
 drivers/nvdimm/nd_perf.c                                            |    3 
 drivers/nvdimm/nd_virtio.c                                          |    3 
 drivers/of/overlay.c                                                |    3 
 drivers/of/property.c                                               |    2 
 drivers/of/unittest.c                                               |   12 
 drivers/opp/core.c                                                  |    2 
 drivers/pci/access.c                                                |   20 
 drivers/pci/controller/dwc/pcie-qcom-ep.c                           |    2 
 drivers/pci/controller/dwc/pcie-tegra194.c                          |   10 
 drivers/pci/controller/pci-hyperv.c                                 |    3 
 drivers/pci/controller/pcie-apple.c                                 |    6 
 drivers/pci/controller/pcie-microchip-host.c                        |    8 
 drivers/pci/controller/pcie-rockchip.h                              |    6 
 drivers/pci/doe.c                                                   |    2 
 drivers/pci/hotplug/pciehp_hpc.c                                    |   12 
 drivers/pci/pci.c                                                   |   13 
 drivers/pci/pcie/aspm.c                                             |   30 
 drivers/pci/probe.c                                                 |    2 
 drivers/perf/fsl_imx8_ddr_perf.c                                    |   24 
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c                       |    6 
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c                       |   18 
 drivers/pinctrl/mediatek/pinctrl-mt7981.c                           |   44 
 drivers/pinctrl/mediatek/pinctrl-mt7986.c                           |    8 
 drivers/pinctrl/pinctrl-mcp23s08_spi.c                              |   10 
 drivers/platform/chrome/chromeos_acpi.c                             |   31 
 drivers/platform/mellanox/mlxbf-tmfifo.c                            |    1 
 drivers/platform/x86/amd/pmf/core.c                                 |    3 
 drivers/platform/x86/amd/pmf/sps.c                                  |    3 
 drivers/platform/x86/asus-wmi.c                                     |   14 
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c                  |    9 
 drivers/platform/x86/huawei-wmi.c                                   |    2 
 drivers/platform/x86/intel/hid.c                                    |   27 
 drivers/platform/x86/think-lmi.c                                    |    4 
 drivers/powercap/arm_scmi_powercap.c                                |  159 +-
 drivers/rpmsg/qcom_glink_native.c                                   |    4 
 drivers/s390/block/dasd.c                                           |  125 -
 drivers/s390/block/dasd_3990_erp.c                                  |    2 
 drivers/s390/block/dasd_devmap.c                                    |    6 
 drivers/s390/block/dasd_eckd.c                                      |   10 
 drivers/s390/block/dasd_int.h                                       |    4 
 drivers/s390/block/dcssblk.c                                        |    4 
 drivers/s390/crypto/pkey_api.c                                      |   22 
 drivers/s390/crypto/zcrypt_ep11misc.c                               |  105 +
 drivers/s390/crypto/zcrypt_ep11misc.h                               |   11 
 drivers/scsi/be2iscsi/be_iscsi.c                                    |    4 
 drivers/scsi/fcoe/fcoe_ctlr.c                                       |   20 
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c                              |   11 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                              |   13 
 drivers/scsi/hosts.c                                                |    4 
 drivers/scsi/lpfc/lpfc_scsi.c                                       |   20 
 drivers/scsi/mpt3sas/mpt3sas_base.c                                 |   46 
 drivers/scsi/mpt3sas/mpt3sas_base.h                                 |    1 
 drivers/scsi/qedf/qedf_dbg.h                                        |    2 
 drivers/scsi/qedf/qedf_debugfs.c                                    |   35 
 drivers/scsi/qedi/qedi_main.c                                       |    5 
 drivers/scsi/qla2xxx/qla_init.c                                     |    2 
 drivers/scsi/qla4xxx/ql4_os.c                                       |   15 
 drivers/scsi/scsi_transport_iscsi.c                                 |   80 -
 drivers/soc/qcom/ocmem.c                                            |   14 
 drivers/soc/qcom/smem.c                                             |    2 
 drivers/spi/spi-mpc512x-psc.c                                       |    2 
 drivers/spi/spi-tegra20-sflash.c                                    |    6 
 drivers/staging/fbtft/fb_ili9341.c                                  |    2 
 drivers/staging/media/av7110/sp8870.c                               |    2 
 drivers/staging/media/rkvdec/rkvdec.c                               |    2 
 drivers/thermal/imx8mm_thermal.c                                    |    6 
 drivers/thermal/mediatek/lvts_thermal.c                             |  152 +-
 drivers/thermal/thermal_core.c                                      |    4 
 drivers/thermal/thermal_of.c                                        |    8 
 drivers/tty/serial/qcom_geni_serial.c                               |    7 
 drivers/tty/serial/sc16is7xx.c                                      |  145 +-
 drivers/tty/serial/serial-tegra.c                                   |    6 
 drivers/tty/serial/sprd_serial.c                                    |   30 
 drivers/ufs/core/ufshcd.c                                           |   12 
 drivers/usb/core/hcd.c                                              |   10 
 drivers/usb/core/hub.c                                              |  349 +++--
 drivers/usb/core/message.c                                          |   29 
 drivers/usb/core/usb.h                                              |    4 
 drivers/usb/gadget/function/f_mass_storage.c                        |    2 
 drivers/usb/gadget/udc/core.c                                       |    1 
 drivers/usb/phy/phy-mxs-usb.c                                       |   10 
 drivers/usb/typec/bus.c                                             |   12 
 drivers/usb/typec/tcpm/tcpm.c                                       |   38 
 drivers/vdpa/mlx5/net/mlx5_vnet.c                                   |   10 
 drivers/vfio/vfio_iommu_type1.c                                     |    2 
 drivers/vhost/scsi.c                                                |  186 ++
 drivers/video/backlight/bd6107.c                                    |    2 
 drivers/video/backlight/gpio_backlight.c                            |    2 
 drivers/video/backlight/lv5207lp.c                                  |    2 
 drivers/video/fbdev/goldfishfb.c                                    |    4 
 drivers/virtio/virtio_mem.c                                         |  168 +-
 drivers/virtio/virtio_ring.c                                        |    2 
 drivers/virtio/virtio_vdpa.c                                        |   17 
 fs/dlm/plock.c                                                      |    6 
 fs/eventfd.c                                                        |    2 
 fs/ext4/mballoc.c                                                   |    7 
 fs/ext4/namei.c                                                     |    3 
 fs/f2fs/checkpoint.c                                                |    2 
 fs/f2fs/debug.c                                                     |   33 
 fs/f2fs/f2fs.h                                                      |   56 
 fs/f2fs/file.c                                                      |   27 
 fs/f2fs/gc.c                                                        |   18 
 fs/f2fs/inode.c                                                     |   12 
 fs/f2fs/recovery.c                                                  |    1 
 fs/f2fs/segment.c                                                   |    4 
 fs/f2fs/super.c                                                     |   37 
 fs/f2fs/sysfs.c                                                     |  250 ++-
 fs/fs_context.c                                                     |   23 
 fs/fuse/file.c                                                      |   89 -
 fs/iomap/buffered-io.c                                              |    5 
 fs/jfs/jfs_extent.c                                                 |    5 
 fs/lockd/mon.c                                                      |    3 
 fs/namei.c                                                          |    2 
 fs/nfs/blocklayout/dev.c                                            |    4 
 fs/nfs/internal.h                                                   |    1 
 fs/nfs/nfs2xdr.c                                                    |    2 
 fs/nfs/nfs3xdr.c                                                    |    2 
 fs/nfs/nfs42.h                                                      |    1 
 fs/nfs/nfs42proc.c                                                  |    5 
 fs/nfs/nfs42xdr.c                                                   |   17 
 fs/nfs/nfs4proc.c                                                   |   13 
 fs/nfs/pnfs_nfs.c                                                   |    2 
 fs/nfs/read.c                                                       |   10 
 fs/nfsd/blocklayoutxdr.c                                            |    9 
 fs/nfsd/flexfilelayoutxdr.c                                         |    9 
 fs/nfsd/nfs4xdr.c                                                   |   25 
 fs/nls/nls_base.c                                                   |    4 
 fs/ocfs2/namei.c                                                    |    4 
 fs/overlayfs/super.c                                                |    2 
 fs/proc/base.c                                                      |    3 
 fs/pstore/ram_core.c                                                |    2 
 fs/quota/dquot.c                                                    |  174 +-
 fs/reiserfs/journal.c                                               |    4 
 fs/smb/client/cifsglob.h                                            |    1 
 fs/smb/client/cifssmb.c                                             |    3 
 fs/smb/client/connect.c                                             |    5 
 fs/smb/client/misc.c                                                |    1 
 fs/smb/client/smb2pdu.c                                             |    3 
 fs/smb/server/server.c                                              |    7 
 fs/smb/server/smb2pdu.c                                             |   20 
 fs/smb/server/smb_common.c                                          |   19 
 fs/smb/server/smb_common.h                                          |    2 
 fs/smb/server/vfs.c                                                 |    7 
 fs/splice.c                                                         |   44 
 fs/verity/signature.c                                               |   16 
 include/crypto/algapi.h                                             |    3 
 include/dt-bindings/clock/qcom,gcc-sc8280xp.h                       |   10 
 include/dt-bindings/clock/qcom,qdu1000-gcc.h                        |    4 
 include/linux/arm_sdei.h                                            |    2 
 include/linux/blkdev.h                                              |    1 
 include/linux/hid.h                                                 |    1 
 include/linux/if_arp.h                                              |    4 
 include/linux/kernfs.h                                              |    4 
 include/linux/lsm_hook_defs.h                                       |    1 
 include/linux/memcontrol.h                                          |    9 
 include/linux/nls.h                                                 |    2 
 include/linux/nvmem-consumer.h                                      |    2 
 include/linux/pci.h                                                 |   34 
 include/linux/pid_namespace.h                                       |   16 
 include/linux/security.h                                            |    6 
 include/linux/thermal.h                                             |    6 
 include/linux/trace_events.h                                        |    3 
 include/linux/usb/typec_altmode.h                                   |    2 
 include/media/cec.h                                                 |   11 
 include/net/bluetooth/hci.h                                         |   20 
 include/net/bluetooth/hci_core.h                                    |   67 -
 include/net/bluetooth/hci_sync.h                                    |    2 
 include/net/lwtunnel.h                                              |    5 
 include/net/mac80211.h                                              |    4 
 include/net/tcp.h                                                   |    1 
 include/scsi/scsi_host.h                                            |    2 
 include/uapi/linux/sync_file.h                                      |    2 
 include/ufs/ufs.h                                                   |    6 
 init/Kconfig                                                        |    1 
 io_uring/io-wq.c                                                    |   19 
 io_uring/io-wq.h                                                    |    3 
 io_uring/io_uring.c                                                 |   37 
 io_uring/io_uring.h                                                 |    1 
 io_uring/sqpoll.c                                                   |   17 
 io_uring/sqpoll.h                                                   |    1 
 kernel/auditsc.c                                                    |    2 
 kernel/bpf/btf.c                                                    |   22 
 kernel/bpf/helpers.c                                                |    2 
 kernel/bpf/verifier.c                                               |   58 
 kernel/cgroup/cpuset.c                                              |   33 
 kernel/cpu.c                                                        |   24 
 kernel/kprobes.c                                                    |   14 
 kernel/printk/printk_ringbuffer.c                                   |    2 
 kernel/rcu/refscale.c                                               |    3 
 kernel/sched/rt.c                                                   |    2 
 kernel/time/clocksource.c                                           |    8 
 kernel/time/tick-sched.c                                            |    2 
 kernel/trace/bpf_trace.c                                            |    2 
 kernel/trace/trace.c                                                |   72 -
 kernel/trace/trace.h                                                |    2 
 kernel/trace/trace_hwlat.c                                          |    2 
 kernel/trace/trace_uprobe.c                                         |    3 
 lib/iov_iter.c                                                      |   30 
 lib/sbitmap.c                                                       |   15 
 lib/xarray.c                                                        |    2 
 mm/memfd.c                                                          |   55 
 mm/shmem.c                                                          |   28 
 mm/util.c                                                           |    4 
 mm/vmalloc.c                                                        |   26 
 mm/vmpressure.c                                                     |    8 
 mm/vmscan.c                                                         |   18 
 net/9p/trans_virtio.c                                               |    4 
 net/bluetooth/hci_conn.c                                            |  624 ++++-----
 net/bluetooth/hci_core.c                                            |   28 
 net/bluetooth/hci_event.c                                           |  178 +-
 net/bluetooth/hci_sync.c                                            |  188 ++
 net/bluetooth/iso.c                                                 |   78 -
 net/bluetooth/mgmt.c                                                |   15 
 net/bluetooth/msft.c                                                |  412 +++++-
 net/bluetooth/sco.c                                                 |    2 
 net/bridge/br_stp_if.c                                              |    3 
 net/core/filter.c                                                   |    2 
 net/core/lwt_bpf.c                                                  |    7 
 net/core/skbuff.c                                                   |   44 
 net/core/sock.c                                                     |   42 
 net/dccp/ipv4.c                                                     |   13 
 net/dccp/ipv6.c                                                     |   15 
 net/ipv4/igmp.c                                                     |    3 
 net/ipv4/ip_output.c                                                |    2 
 net/ipv4/tcp_input.c                                                |    3 
 net/ipv4/tcp_timer.c                                                |   18 
 net/ipv4/udp.c                                                      |   20 
 net/ipv6/ip6_output.c                                               |    2 
 net/ipv6/udp.c                                                      |   19 
 net/mac80211/cfg.c                                                  |   12 
 net/netfilter/ipset/ip_set_hash_netportnet.c                        |    1 
 net/netfilter/nft_exthdr.c                                          |   20 
 net/netfilter/xt_sctp.c                                             |    2 
 net/netfilter/xt_u32.c                                              |   21 
 net/netrom/af_netrom.c                                              |    5 
 net/sched/em_meta.c                                                 |    6 
 net/sched/sch_hfsc.c                                                |    4 
 net/smc/af_smc.c                                                    |    2 
 net/socket.c                                                        |    6 
 net/wireless/nl80211.c                                              |    1 
 samples/bpf/tracex3_kern.c                                          |   36 
 samples/bpf/tracex6_kern.c                                          |   17 
 scripts/gdb/linux/constants.py.in                                   |    3 
 scripts/gdb/linux/modules.py                                        |   12 
 scripts/rust_is_available.sh                                        |  122 -
 security/integrity/ima/Kconfig                                      |   12 
 security/keys/keyctl.c                                              |   11 
 security/security.c                                                 |   14 
 security/selinux/hooks.c                                            |   22 
 security/smack/smack_lsm.c                                          |   51 
 security/smack/smackfs.c                                            |    2 
 sound/Kconfig                                                       |    2 
 sound/core/pcm_compat.c                                             |    8 
 sound/pci/ac97/ac97_codec.c                                         |    5 
 sound/pci/hda/patch_cs8409-tables.c                                 |    4 
 sound/pci/hda/patch_cs8409.c                                        |    2 
 sound/pci/hda/patch_cs8409.h                                        |    1 
 sound/soc/atmel/atmel-i2s.c                                         |    5 
 sound/soc/codecs/Kconfig                                            |    1 
 sound/soc/codecs/cs35l56-i2c.c                                      |    9 
 sound/soc/codecs/cs35l56-spi.c                                      |    9 
 sound/soc/codecs/cs43130.h                                          |  138 +-
 sound/soc/codecs/da7219-aad.c                                       |   12 
 sound/soc/codecs/es8316.c                                           |    2 
 sound/soc/codecs/nau8821.c                                          |   41 
 sound/soc/codecs/rt1308-sdw.c                                       |   13 
 sound/soc/codecs/rt5682-sdw.c                                       |    9 
 sound/soc/codecs/rt711-sdca-sdw.c                                   |   10 
 sound/soc/codecs/rt711-sdw.c                                        |    9 
 sound/soc/codecs/rt712-sdca-sdw.c                                   |   10 
 sound/soc/fsl/fsl_qmc_audio.c                                       |   28 
 sound/soc/soc-compress.c                                            |    1 
 sound/soc/sof/amd/acp.c                                             |    6 
 sound/soc/sof/intel/hda-mlink.c                                     |   20 
 sound/usb/mixer_maps.c                                              |   14 
 sound/usb/quirks.c                                                  |   37 
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c                           |   26 
 tools/bpf/bpftool/skeleton/profiler.bpf.c                           |   27 
 tools/hv/vmbus_testing                                              |    4 
 tools/lib/bpf/libbpf.c                                              |   42 
 tools/lib/bpf/usdt.c                                                |    5 
 tools/testing/radix-tree/multiorder.c                               |   68 -
 tools/testing/selftests/bpf/benchs/run_bench_rename.sh              |    2 
 tools/testing/selftests/bpf/prog_tests/bpf_nf.c                     |    5 
 tools/testing/selftests/bpf/prog_tests/kfunc_call.c                 |    2 
 tools/testing/selftests/bpf/progs/test_cls_redirect.h               |    9 
 tools/testing/selftests/futex/functional/futex_wait_timeout.c       |    7 
 tools/testing/selftests/kselftest_harness.h                         |   11 
 tools/testing/selftests/memfd/memfd_test.c                          |   40 
 tools/testing/selftests/resctrl/Makefile                            |    2 
 tools/testing/selftests/resctrl/cache.c                             |   18 
 tools/testing/selftests/resctrl/fill_buf.c                          |    3 
 tools/testing/selftests/resctrl/resctrl.h                           |    1 
 virt/kvm/vfio.c                                                     |  115 -
 873 files changed, 10654 insertions(+), 7653 deletions(-)

Abel Vesa (1):
      arm64: dts: qcom: sm8550-mtp: Add missing supply for L1B regulator

Abel Wu (1):
      net-memcg: Fix scope of sockmem pressure indicators

Aditya Kumar Singh (1):
      wifi: ath11k: fix band selection for ppdu received in channel 177 of 5 GHz

Adrien Thierry (1):
      phy: qcom-snps-femto-v2: use qcom_snps_hsphy_suspend/resume error code

Ahelenia Ziemiańska (3):
      splice: always fsnotify_access(in), fsnotify_modify(out) on success
      splice: fsnotify_access(fd)/fsnotify_modify(fd) in vmsplice
      splice: fsnotify_access(in), fsnotify_modify(out) on success in tee

Ahmad Fatoum (3):
      thermal: core: constify params in thermal_zone_device_register
      clk: imx: composite-8m: fix clock pauses when set_rate would be a no-op
      thermal/drivers/imx8mm: Suppress log message on probe deferral

Alan Maguire (1):
      selftests/bpf: fix static assert compilation issue for test_cls_*.c

Alan Stern (6):
      USB: gadget: core: Add missing kerneldoc for vbus_work
      USB: gadget: f_mass_storage: Fix unused variable warning
      USB: core: Unite old scheme and new scheme descriptor reads
      USB: core: Change usb_get_device_descriptor() API
      USB: core: Fix race by not overwriting udev->descriptor in hub_port_init()
      USB: core: Fix oversight in SuperSpeed initialization

Aleksa Sarai (4):
      selftests: memfd: error out test process when child test fails
      procfs: block chmod on /proc/thread-self/comm
      memfd: do not -EACCES old memfd_create() users with vm.memfd_noexec=2
      memfd: improve userspace warnings for missing exec-related flags

Alex Austin (1):
      sfc: Check firmware supports Ethernet PTP filter

Alexander Aring (1):
      dlm: fix plock lookup when using multiple lockspaces

Alexander Lobakin (3):
      bpftool: use a local copy of perf_event to fix accessing :: Bpf_cookie
      bpftool: Define a local bpf_perf_link to fix accessing its fields
      bpftool: Use a local bpf_perf_event_value to fix accessing its fields

Alexander Stein (1):
      media: amphion: use dev_err_probe

Alexandre Ghiti (2):
      riscv: Move create_tmp_mapping() to init sections
      riscv: Mark KASAN tmp* page tables variables as static

Alexei Filippov (1):
      jfs: validate max amount of blocks before allocation.

Alibek Omarov (1):
      clk: rockchip: rk3568: Fix PLL rate setting for 78.75MHz

Andrew Morton (1):
      revert "memfd: improve userspace warnings for missing exec-related flags".

Andrii Nakryiko (2):
      libbpf: only reset sec_def handler when necessary
      libbpf: Fix realloc API handling in zero-sized edge cases

André Apitzsch (1):
      arm64: dts: qcom: msm8916-longcheer-l8910: Add front flash LED

AngeloGioacchino Del Regno (2):
      drm/mediatek: dp: Add missing error checks in mtk_dp_parse_capabilities
      iommu/qcom: Disable and reset context bank before programming

Ani Sinha (1):
      vmbus_testing: fix wrong python syntax for integer value comparison

Anna Schumaker (4):
      NFSv4.2: Fix READ_PLUS smatch warnings
      NFSv4.2: Fix READ_PLUS size calculations
      NFSv4.2: Rework scratch handling for READ_PLUS (again)
      pNFS: Fix assignment of xprtdata.cred

Apelete Seketeli (1):
      arm64: dts: ti: k3-j784s4: Fix interrupt ranges for wkup & main gpio

Aradhya Bhatia (1):
      arm64: dts: ti: k3-am62x-sk-common: Update main-i2c1 frequency

Ard Biesheuvel (1):
      x86/decompressor: Don't rely on upper 32 bits of GPRs being preserved

Armin Wolf (1):
      platform/x86: dell-sysman: Fix reference leak

Arnd Bergmann (6):
      wifi: ath12k: fix memcpy array overflow in ath12k_peer_assoc_h_he()
      mac80211: make ieee80211_tx_info padding explicit
      drm/amdgpu: avoid integer overflow warning in amdgpu_device_resize_fb_bar()
      kernfs: add stub helper for kernfs_generic_poll()
      extcon: cht_wc: add POWER_SUPPLY dependency
      media: ipu3-cio2: allow ipu_bridge to be a module again

Artem Chernyshev (2):
      broadcom: b44: Use b44_writephy() return value
      fs: ocfs2: namei: check return value of ocfs2_add_entry()

Baokun Li (4):
      quota: factor out dquot_write_dquot()
      quota: rename dquot_active() to inode_quota_active()
      quota: add new helper dquot_active()
      quota: fix dqput() to follow the guarantees dquot_srcu should provide

Baoquan He (2):
      clk: fixed-mmio: make COMMON_CLK_FIXED_MMIO depend on HAS_IOMEM
      idmaengine: make FSL_EDMA and INTEL_IDMA64 depends on HAS_IOMEM

Bart Van Assche (3):
      scsi: RDMA/srp: Fix residual handling
      scsi: ufs: Fix residual handling
      scsi: core: Fix the scsi_set_resid() documentation

Bartosz Golaszewski (1):
      gpiolib: fix reference leaks when removing GPIO chips still in use

Ben Hutchings (1):
      m68k: Fix invalid .section syntax

Benjamin Coddington (1):
      NFS: Guard against READDIR loop when entry names exceed MAXNAMELEN

Benjamin Gaignard (1):
      media: rkvdec: increase max supported height for H.264

Benjamin Gray (1):
      powerpc/powermac: Use early_* IO variants in via_calibrate_decr()

Benjamin Tissoires (1):
      HID: logitech-hidpp: rework one more time the retries attempts

Bibo Mao (1):
      irqchip/loongson-eiointc: Fix return value checking of eiointc_index

Biju Das (2):
      hwmon: (tmp513) Fix the channel number in tmp51x_is_visible()
      iio: accel: adxl313: Fix adxl313_i2c_id[] table

Bingbu Cao (1):
      media: ipu3-cio2: rename cio2 bridge to ipu bridge and move out of ipu3

Bjorn Andersson (1):
      arm64: dts: qcom: sc8280xp-crd: Correct vreg_misc_3p3 GPIO

Bjorn Helgaas (1):
      Revert "PCI: Mark NVIDIA T4 GPUs to avoid bus reset"

Bob Pearson (4):
      RDMA/rxe: Move work queue code to subroutines
      RDMA/rxe: Fix unsafe drain work queue code
      RDMA/rxe: Fix rxe_modify_srq
      RDMA/rxe: Fix incomplete state save in rxe_requester

Bogdan Togorean (1):
      drm: adv7511: Fix low refresh rate register for ADV7533/5

Boris Brezillon (1):
      PM / devfreq: Fix leak in devfreq_dev_release()

Brian Foster (1):
      tracing: Zero the pipe cpumask on alloc to avoid spurious -EBUSY

Bryan O'Donoghue (2):
      arm64: dts: qcom: apq8016-sbc: Fix ov5640 regulator supply names
      arm64: dts: qcom: apq8016-sbc: Rename ov5640 enable-gpios to powerdown-gpios

Budimir Markovic (1):
      net/sched: sch_hfsc: Ensure inner classes have fsc curve

Carlos Song (1):
      i2c: imx-lpi2c: return -EINVAL when i2c peripheral clk doesn't work

Chao Yu (5):
      f2fs: fix to avoid mmap vs set_compress_option case
      Revert "f2fs: fix to do sanity check on extent cache correctly"
      f2fs: fix to account gc stats correctly
      f2fs: fix to drop all dirty meta/node pages during umount()
      f2fs: fix to account cp stats correctly

Chen Jiahao (1):
      soc: qcom: smem: Fix incompatible types in comparison

Chen-Yu Tsai (2):
      drm/bridge: anx7625: Use common macros for DP power sequencing commands
      drm/bridge: anx7625: Use common macros for HDCP capabilities

Chengchang Tang (2):
      RDMA/hns: Fix port active speed
      RDMA/hns: Fix CQ and QP cache affinity

Chengci.Xu (1):
      iommu/mediatek: Fix two IOMMU share pagetable issue

Chengfeng Ye (2):
      scsi: qedi: Fix potential deadlock on &qedi_percpu->p_work_lock
      scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock

Christian Brauner (1):
      tmpfs: verify {g,u}id mount options correctly

Christian Göttsche (1):
      security: keys: perform capable check only on privileged operations

Christoph Hellwig (2):
      block: cleanup queue_wc_store
      block: don't allow enabling a cache on devices that don't support it

Christophe JAILLET (3):
      arm64/ptrace: Clean up error handling path in sve_set_common()
      media: v4l2-core: Fix a potential resource leak in v4l2_fwnode_parse_link()
      media: dvb-usb: m920x: Fix a potential memory leak in m920x_i2c_xfer()

Christophe Leroy (2):
      powerpc/radix: Move some functions into #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
      powerpc/perf: Convert fsl_emb notifier to state machine callbacks

Christopher Bednarz (1):
      RDMA/irdma: Prevent zero-length STAG registration

Chuck Lever (2):
      NFSD: da_addr_body field missing in some GETDEVICEINFO replies
      RDMA/siw: Fabricate a GID on tun and loopback devices

Chunhai Guo (1):
      f2fs: Only lfs mode is allowed with zoned block device feature

Chunyan Zhang (2):
      serial: sprd: Assign sprd_port after initialized to avoid wrong access
      serial: sprd: Fix DMA buffer leak issue

Claudiu Beznea (2):
      pinctrl: mcp23s08: check return value of devm_kasprintf()
      media: i2c: tvp5150: check return value of devm_kasprintf()

Colin Ian King (1):
      media: go7007: Remove redundant if statement

Corey Minyard (1):
      ipmi:ssif: Fix a memory leak when scanning for an adapter

Cristian Marussi (1):
      powercap: arm_scmi: Remove recursion while parsing zones

Cyril Hrubis (1):
      sched/rt: Fix sysctl_sched_rr_timeslice intial value

D Scott Phillips (1):
      arm64: sdei: abort running SDEI handlers during crash

Daire McNamara (1):
      PCI: microchip: Correct the DED and SEC interrupt bit offsets

Dan Carpenter (7):
      regmap: rbtree: Use alloc_flags for memory allocations
      smackfs: Prevent underflow in smk_set_cipso()
      nfs/blocklayout: Use the passed in gfp flags
      media: mediatek: vcodec: fix potential double free
      media: mediatek: vcodec: fix resource leaks in vdec_msg_queue_init()
      driver core: test_async: fix an error code
      leds: pwm: Fix error code in led_pwm_create_fwnode()

Daniel Borkmann (1):
      selftests/bpf: Fix bpf_nf failure upon test rerun

Daniel Golle (2):
      pinctrl: mediatek: fix pull_type data for MT7981
      pinctrl: mediatek: assign functions to configure pin bias on MT7986

Daniel Marcovitch (1):
      iommu/amd/iommu_v2: Fix pasid_state refcount dec hit 0 warning on pasid unbind

Daniel Miess (1):
      Partially revert "drm/amd/display: Fix possible underflow for displays with large vblank"

Daniel T. Lee (2):
      samples/bpf: fix bio latency check with tracepoint
      samples/bpf: fix broken map lookup probe

Daniel Vetter (1):
      drm/msm/mdp5: Don't leak some plane state

Daniil Dulov (2):
      media: dib7000p: Fix potential division by zero
      media: cx24120: Add retval check for cx24120_message_send()

Danila Tikhonov (1):
      clk: qcom: gcc-sm7150: Add CLK_OPS_PARENT_ENABLE to sdcc2 rcg

Dave Hansen (1):
      x86/speculation: Mark all Skylake CPUs as vulnerable to GDS

Dave Jiang (3):
      ntb: Drop packets when qp link is down
      ntb: Clean up tx tail index on link down
      ntb: Fix calculation ntb_transport_tx_free_entry()

David Gow (1):
      drivers: base: Free devm resources when unregistering a device

David Hildenbrand (4):
      virtio-mem: remove unsafe unplug in Big Block Mode (BBM)
      virtio-mem: convert most offline_and_remove_memory() errors to -EBUSY
      virtio-mem: keep retrying on offline_and_remove_memory() errors in Sub Block Mode (SBM)
      virtio-mem: check if the config changed before fake offlining memory

David Howells (2):
      vfs, security: Fix automount superblock LSM init problem, preventing NFS sb sharing
      iov_iter: Fix iov_iter_extract_pages() with zero-sized entries

David Jeffery (2):
      sbitmap: fix batching wakeup
      md: raid0: account for split bio in iostat accounting

David Wronek (2):
      arm64: dts: qcom: msm8996: Fix dsi1 interrupts
      clk: qcom: gcc-sc7180: Fix up gcc_sdcc2_apps_clk_src

Dexuan Cui (1):
      PCI: hv: Fix a crash in hv_pci_restore_msi_msg() during hibernation

Diogo Ivo (1):
      arm64: tegra: Fix HSUART for Smaug

Dmitry Antipov (4):
      media: pulse8-cec: handle possible ping error
      wifi: mwifiex: fix error recovery in PCIE buffer descriptor management
      wifi: mwifiex: fix memory leak in mwifiex_histogram_read()
      wifi: mwifiex: avoid possible NULL skb pointer dereference

Dmitry Baryshkov (9):
      arm64: defconfig: enable Qualcomm MSM8996 Global Clock Controller as built-in
      arm64: dts: qcom: sm8150: use proper DSI PHY compatible
      arm64: dts: qcom: pm8350: fix thermal zone name
      arm64: dts: qcom: pm8350b: fix thermal zone name
      arm64: dts: qcom: pmr735b: fix thermal zone name
      arm64: dts: qcom: pmk8350: fix ADC-TM compatible string
      arm64: dts: qcom: sm8450-hdk: remove pmr735b PMIC inclusion
      drm/msm/dpu: drop the regdma configuration
      drm/msm/dpu: fix the irq index in dpu_encoder_phys_wb_wait_for_commit_done

Dmitry Torokhov (1):
      kvm/vfio: ensure kvg instance stays around in kvm_vfio_group_add()

Dmytro Maluka (2):
      ASoC: da7219: Flush pending AAD IRQ when suspending
      ASoC: da7219: Check for failure reading AAD IRQ events

Dominique Martinet (2):
      9p: virtio: fix unlikely null pointer deref in handle_rerror
      9p: virtio: make sure 'offs' is initialized in zc_request

Dongliang Mu (1):
      drivers: usb: smsusb: fix error handling code in smsusb_init_device

Doug Smythies (1):
      cpufreq: intel_pstate: set stale CPU frequency to minimum

Douglas Anderson (2):
      Bluetooth: hci_sync: Don't double print name in add/remove adv_monitor
      of: property: fw_devlink: Add a devlink for panel followers

Dragos Tatulea (1):
      vdpa/mlx5: Correct default number of queues when MQ is on

Eddie James (1):
      fsi: aspeed: Reset master errors after CFAM reset

Edgar (1):
      ASoc: codecs: ES8316: Fix DMIC config

Edson Juliano Drosdeck (1):
      ASoC: nau8821: Add DMI quirk mechanism for active-high jack-detect

Ekansh Gupta (1):
      misc: fastrpc: Pass proper scm arguments for static process init

Enlin Mu (1):
      pstore/ram: Check start of empty przs during init

Eric Biggers (1):
      fsverity: skip PKCS#7 parser when keyring is empty

Eric Dumazet (5):
      net: annotate data-races around sk->sk_{rcv|snd}timeo
      tcp: tcp_enter_quickack_mode() should be static
      net: annotate data-races around sk->sk_lingertime
      net: deal with integer overflows in kmalloc_reserve()
      igmp: limit igmpv3_newpack() packet size to IP_MAX_MTU

Eric Snowberg (1):
      ovl: Always reevaluate the file signature for IMA

Fabio Estevam (1):
      drm/msm/a2xx: Call adreno_gpu_init() earlier

Fedor Pchelkin (2):
      wifi: ath9k: fix races between ath9k_wmi_cmd and ath9k_wmi_ctrl_rx
      wifi: ath9k: protect WMI command response buffer replacement with a lock

Feiyang Chen (1):
      PCI/PM: Only read PCI_PM_CTRL register when available

Felix Fietkau (2):
      wifi: mt76: mt7915: fix capabilities in non-AP mode
      wifi: mt76: mt7915: remove VHT160 capability on MT7915

Fenghua Yu (4):
      dmaengine: idxd: Simplify WQ attribute visibility checks
      dmaengine: idxd: Expose ATS disable knob only when WQ ATS is supported
      dmaengine: idxd: Allow ATS disable update only for configurable devices
      dmaengine: idxd: Fix issues with PRS disable sysfs knob

Florian Fainelli (1):
      hwrng: iproc-rng200 - Implement suspend and resume calls

Frank Li (1):
      i3c: master: svc: fix probe failure when no i3c device exist

Frederick Lawler (1):
      crypto: af_alg - Decrement struct key.usage in alg_set_by_key_serial()

Fudong Wang (1):
      drm/amd/display: Add smu write msg id fail retry process

Gabriel Krisman Bertazi (1):
      io_uring: Don't set affinity on a dying sqpoll thread

Gaosheng Cui (1):
      audit: fix possible soft lockup in __audit_inode_child()

Gaurav Jain (1):
      crypto: caam - fix unchecked return value error

Geert Uytterhoeven (4):
      drm/armada: Fix off-by-one error in armada_overlay_get_property()
      drm/repaper: Reduce temporary buffer size in repaper_fb_dirty()
      of: overlay: Call of_changeset_init() early
      of: unittest: Fix overlay type in apply/revert check

George Shen (1):
      drm/amd/display: Guard DCN31 PHYD32CLK logic against chip family

Gerald Schaefer (1):
      s390/dcssblk: fix kernel crash with list_add corruption

Giovanni Cabiddu (1):
      crypto: qat - change value of default idle filter

Greg Kroah-Hartman (2):
      media: dvb: symbol fixup for dvb_attach()
      Linux 6.4.16

Guenter Roeck (1):
      regmap: maple: Use alloc_flags for memory allocations

Guiting Shen (1):
      ASoC: atmel: Fix the 8K sample parameter in I2SC master

Guoniu.zhou (1):
      media: ov5640: fix low resolution image abnormal issue

Guoqing Jiang (2):
      RDMA/siw: Balance the reference of cep->kref in the error path
      RDMA/siw: Correct wrong debug message

Gustavo A. R. Silva (3):
      RDMA/irdma: Replace one-element array with flexible-array member
      ARM: OMAP2+: Fix -Warray-bounds warning in _pwrdm_state_switch()
      cpufreq: brcmstb-avs-cpufreq: Fix -Warray-bounds bug

Hamza Mahfooz (2):
      drm/amd/display: ensure async flips are only accepted for fast updates
      drm/amd/display: register edp_backlight_control() for DCN301

Hans Verkuil (2):
      media: cec: core: add adap_nb_transmit_canceled() callback
      media: cec: core: add adap_unconfigured() callback

Hans de Goede (13):
      platform/x86: intel: hid: Always call BTNL ACPI method
      wifi: brcmfmac: Fix field-spanning write in brcmf_scan_params_v2_to_v1()
      media: ad5820: Drop unsupported ad5823 from i2c_ and of_device_id tables
      media: ipu-bridge: Fix null pointer deref on SSDB/PLD parsing warnings
      media: ipu-bridge: Do not use on stack memory for software_node.name field
      media: ov2680: Remove auto-gain and auto-exposure controls
      media: ov2680: Fix ov2680_bayer_order()
      media: ov2680: Fix vflip / hflip set functions
      media: ov2680: Remove VIDEO_V4L2_SUBDEV_API ifdef-s
      media: ov2680: Don't take the lock for try_fmt calls
      media: ov2680: Add ov2680_fill_format() helper function
      media: ov2680: Fix ov2680_set_fmt() which == V4L2_SUBDEV_FORMAT_TRY not working
      media: ov2680: Fix regulators being left enabled on ov2680_power_on() errors

Hao Lan (1):
      net: hns3: add tm flush when setting tm

Hariprasad Kelam (2):
      octeontx2-pf: Refactor schedular queue alloc/free calls
      octeontx2-af: CN10KB: fix PFC configuration

Heiko Carstens (1):
      s390/dasd: fix string length handling

Heiner Kallweit (1):
      r8169: fix ASPM-related issues on a number of systems with NIC version from RTL8168h

Helge Deller (1):
      parisc: Fix /proc/cpuinfo output for lscpu

Herbert Xu (1):
      crypto: api - Use work queue in crypto_destroy_instance

Herve Codina (1):
      ASoC: fsl: fsl_qmc_audio: Fix snd_pcm_format_t values handling

Hilda Wu (1):
      Bluetooth: msft: Extended monitor tracking by address filter

Holger Dengler (4):
      s390/pkey: fix/harmonize internal keyblob headers
      s390/pkey: fix PKEY_TYPE_EP11_AES handling in PKEY_GENSECK2 IOCTL
      s390/pkey: fix PKEY_TYPE_EP11_AES handling for sysfs attributes
      s390/paes: fix PKEY_TYPE_EP11_AES handling for secure keyblobs

Hongchen Zhang (1):
      LoongArch: mm: Add p?d_leaf() definitions

Hou Tao (1):
      virtio_pmem: add the missing REQ_OP_WRITE for flush bio

Hsin-Yi Wang (1):
      mtd: spi-nor: Check bus width while setting QE bit

Huacai Chen (2):
      LoongArch: Only fiddle with CHECKFLAGS if `need-compiler'
      LoongArch: Ensure FP/SIMD registers in the core dump file is up to date

Hugo Villeneuve (2):
      serial: sc16is7xx: remove obsolete out_thread label
      serial: sc16is7xx: fix regression with GPIO configuration

Illia Ostapyshyn (1):
      HID: input: Support devices sending Eraser without Invert

Ilpo Järvinen (13):
      selftests/resctrl: Add resctrl.h into build deps
      selftests/resctrl: Don't leak buffer in fill_cache()
      selftests/resctrl: Unmount resctrl FS if child fails to run benchmark
      selftests/resctrl: Close perf value read fd on errors
      PCI: Add locking to RMW PCI Express Capability Register accessors
      PCI: pciehp: Use RMW accessors for changing LNKCTL
      PCI/ASPM: Use RMW accessors for changing LNKCTL
      drm/amdgpu: Use RMW accessors for changing LNKCTL
      drm/radeon: Use RMW accessors for changing LNKCTL
      net/mlx5: Use RMW accessors for changing LNKCTL
      wifi: ath11k: Use RMW accessors for changing LNKCTL
      wifi: ath12k: Use RMW accessors for changing LNKCTL
      wifi: ath10k: Use RMW accessors for changing LNKCTL

Imran Shaik (4):
      clk: qcom: gcc-qdu1000: Fix gcc_pcie_0_pipe_clk_src clock handling
      clk: qcom: gcc-qdu1000: Fix clkref clocks handling
      dt-bindings: clock: Update GCC clocks for QDU1000 and QRU1000 SoCs
      clk: qcom: gcc-qdu1000: Register gcc_gpll1_out_even clock

Ira Weiny (1):
      PCI/DOE: Fix destroy_work_on_stack() race

Irui Wang (1):
      media: mediatek: vcodec: Return NULL if no vdec_fb is found

Iulia Tanasescu (2):
      Bluetooth: ISO: Add support for connecting multiple BISes
      Bluetooth: ISO: Notify user space about failed bis connections

Jack Wang (1):
      x86/sgx: Break up long non-preemptible delays in sgx_vepc_release()

Jacob Keller (1):
      ice: avoid executing commands on other ports when driving sync

Jacopo Mondi (1):
      media: i2c: rdacm21: Fix uninitialized value

Jan Kara (2):
      md/raid0: Factor out helper for mapping and submitting a bio
      md/raid0: Fix performance regression for large sequential writes

Jane Jian (1):
      drm/amd/smu: use AverageGfxclkFrequency* to replace previous GFX Curr Clock

Jann Horn (1):
      dccp: Fix out of bounds access in DCCP error handler

Janusz Krzysztofik (1):
      x86/mm: Fix PAT bit missing from page protection modify mask

Jarkko Sakkinen (1):
      tpm: Enable hwrng only for Pluton on AMD CPUs

Jason Gunthorpe (3):
      iommufd: Fix locking around hwpt allocation
      driver core: Call dma_cleanup() on the test_remove path
      iommu/sprd: Add missing force_aperture

Jason Wang (1):
      virtio_vdpa: build affinity masks conditionally

Jason-JH.Lin (3):
      drm/mediatek: Remove freeing not dynamic allocated memory
      drm/mediatek: Add cnt checking for coverity issue
      drm/mediatek: Fix void-pointer-to-enum-cast warning

Jeff Xu (2):
      mm/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
      selftests/memfd: sysctl: fix MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED

Jens Axboe (1):
      io_uring/sqpoll: fix io-wq affinity when IORING_SETUP_SQPOLL is used

Jian Shen (1):
      net: hns3: restore user pause configure when disable autoneg

Jiapeng Chong (1):
      Bluetooth: hci_conn: Use kmemdup() to replace kzalloc + memcpy

Jiasheng Jiang (3):
      drm: xlnx: zynqmp_dpsub: Add missing check for dma_set_mask
      ipmi:ssif: Add check for kstrdup
      rpmsg: glink: Add check for kstrdup

Jijie Shao (3):
      net: hns3: move dump regs function to a separate file
      net: hns3: Support tlv in regs data for HNS3 PF driver
      net: hns3: fix wrong rpu tln reg issue

Jinjie Ruan (2):
      Bluetooth: btusb: Do not call kfree_skb() under spin_lock_irqsave()
      net: arcnet: Do not call kfree_skb() under local_irq_disable()

Jocelyn Falempe (1):
      drm/ast: report connection status on Display Port.

Joel Fernandes (Google) (1):
      mm/vmalloc: add a safer version of find_vm_area() for debug

Johannes Berg (1):
      wifi: mac80211: fix puncturing bitmap handling in CSA

Jon Hunter (1):
      arm64: tegra: Fix HSUART for Jetson AGX Orin

Jonas Karlman (5):
      arm64: dts: rockchip: Fix PCIe regulators on Radxa E25
      arm64: dts: rockchip: Enable SATA on Radxa E25
      iommu: rockchip: Fix directory table address encoding
      phy/rockchip: inno-hdmi: use correct vco_div_5 macro on rk3328
      phy/rockchip: inno-hdmi: do not power on rk3328 post pll on reg write

Jonathan Marek (1):
      drm/msm/dpu: increase memtype count to 16 for sm8550

Jordan Rife (1):
      net: Avoid address overwrite in kernel_connect

Josua Mayer (1):
      net: sfp: handle 100G/25G active optical cables in sfp_parse_support

Junhao He (1):
      coresight: trbe: Fix TRBE potential sleep in atomic context

Junxian Huang (2):
      RDMA/hns: Fix incorrect post-send with direct wqe of wr-list
      RDMA/hns: Fix inaccurate error label name in init instance

Jussi Laako (1):
      ALSA: usb-audio: Update for native DSD support quirks

Justin Tee (1):
      scsi: lpfc: Remove reftag check in DIF paths

Kalesh AP (1):
      RDMA/bnxt_re: Remove a redundant flag

Kalesh Singh (1):
      Multi-gen LRU: fix per-zone reclaim

Kalle Valo (1):
      Revert "wifi: ath6k: silence false positive -Wno-dangling-pointer warning on GCC 12"

Kan Liang (1):
      perf/x86/uncore: Correct the number of CHAs on EMR

Kees Cook (4):
      selftests/harness: Actually report SKIP for signal tests
      ARM: ptrace: Restore syscall restart tracing
      ARM: ptrace: Restore syscall skipping for tracers
      printk: ringbuffer: Fix truncating buffer size min_t cast

Kemeng Shi (2):
      ext4: correct grp validation in ext4_mb_good_group
      ext4: avoid potential data overflow in next_linear_group

Konrad Dybcio (32):
      arm64: dts: qcom: sm6350: Fix ZAP region
      arm64: dts: qcom: sm8250-edo: Add gpio line names for TLMM
      arm64: dts: qcom: sm8250-edo: Add GPIO line names for PMIC GPIOs
      arm64: dts: qcom: sm8250-edo: Rectify gpio-keys
      arm64: dts: qcom: sc8280xp: Add missing SCM interconnect
      arm64: dts: qcom: msm8996: Add missing interrupt to the USB2 controller
      arm64: dts: qcom: sdm845-tama: Set serial indices and stdout-path
      arm64: dts: qcom: sm8350: Fix CPU idle state residency times
      arm64: dts: qcom: sm8350: Add missing LMH interrupts to cpufreq
      arm64: dts: qcom: sm8350: Use proper CPU compatibles
      arm64: dts: qcom: sm8250: Mark PCIe hosts as DMA coherent
      arm64: dts: qcom: pm6150l: Add missing short interrupt
      arm64: dts: qcom: pm660l: Add missing short interrupt
      arm64: dts: qcom: pmi8950: Add missing OVP interrupt
      arm64: dts: qcom: pmi8994: Add missing OVP interrupt
      arm64: dts: qcom: msm8998: Drop bus clock reference from MMSS SMMU
      arm64: dts: qcom: msm8998: Add missing power domain to MMSS SMMU
      arm64: dts: qcom: sc8280xp-x13s: Unreserve NC pins
      clk: qcom: gpucc-sm6350: Introduce index-based clk lookup
      clk: qcom: gpucc-sm6350: Fix clock source names
      clk: qcom: gcc-sc8280xp: Add missing GDSC flags
      dt-bindings: clock: qcom,gcc-sc8280xp: Add missing GDSCs
      clk: qcom: gcc-sc8280xp: Add missing GDSCs
      clk: qcom: dispcc-sc8280xp: Use ret registers on GDSCs
      clk: qcom: reset: Use the correct type of sleep/delay based on length
      clk: qcom: gcc-sm8450: Use floor ops for SDCC RCGs
      interconnect: qcom: qcm2290: Enable sync state
      media: venus: hfi_venus: Only consider sys_idle_indicator on V1
      interconnect: qcom: sm8450: Enable sync_state
      interconnect: qcom: bcm-voter: Improve enable_mask handling
      interconnect: qcom: bcm-voter: Use enable_maks for keepalive voting
      media: venus: hfi_venus: Write to VIDC_CTRL_INIT after unmasking interrupts

Konstantin Meskhidze (2):
      nvdimm: Fix memleak of pmu attr_groups in unregister_nvdimm_pmu()
      nvdimm: Fix dereference after free in register_nvdimm_pmu()

Konstantin Shelekhin (1):
      platform/x86: huawei-wmi: Silence ambient light sensor

Kristian Angelov (1):
      platform/x86: asus-wmi: Fix setting RGB mode on some TUF laptops

Krzysztof Kozlowski (11):
      arm64: dts: rockchip: correct wifi interrupt flag in eaidk-610
      arm64: dts: rockchip: correct wifi interrupt flag in Rock Pi 4B
      arm64: dts: rockchip: correct wifi interrupt flag in Box Demo
      arm64: dts: qcom: msm8916-l8150: correct light sensor VDDIO supply
      arm64: dts: qcom: sm8250-sony-xperia: correct GPIO keys wakeup again
      ARM: dts: samsung: s3c6410-mini6410: correct ethernet reg addresses (split)
      ARM: dts: s5pv210: add dummy 5V regulator for backlight on SMDKv210
      ARM: dts: samsung: s5pv210-smdkv210: correct ethernet reg addresses (split)
      arm64: dts: qcom: msm8996-gemini: fix touchscreen VIO supply
      dt-bindings: extcon: maxim,max77843: restrict connector properties
      regulator: dt-bindings: qcom,rpm: fix pattern for children

Kuan-Ying Lee (1):
      scripts/gdb: fix 'lx-lsmod' show the wrong size

Kui-Feng Lee (1):
      bpf: fix bpf_dynptr_slice() to stop return an ERR_PTR.

Kumar Kartikeya Dwivedi (1):
      bpf: Fix check_func_arg_reg_off bug for graph root/node

Kuniyuki Iwashima (2):
      Revert "bridge: Add extack warning when enabling STP in netns."
      netrom: Deny concurrent connect().

Kyle Zeng (1):
      netfilter: ipset: add the missing IP_SET_HASH_WITH_NET0 macro for ip_set_hash_netportnet.c

Larry Finger (1):
      wifi: rtw89: Fix loading of compressed firmware

Laurent Pinchart (1):
      arm64: defconfig: Drop CONFIG_VIDEO_IMX_MEDIA

Leo Chen (1):
      drm/amd/display: Exit idle optimizations before attempt to access PHY

Leon Romanovsky (1):
      Revert "IB/isert: Fix incorrect release of isert connection"

Li Lingfeng (1):
      block: don't add or resize partition on the disk with GENHD_FL_NO_PART

Li Nan (2):
      md/raid10: factor out dereference_rdev_and_rrdev()
      md/raid10: use dereference_rdev_and_rrdev() to get devices

Li Zetao (1):
      spi: mpc5xxx-psc: Fix unsigned expression compared with zero

Liang He (1):
      powerpc/mpc5xxx: Add missing fwnode_handle_put()

Liao Chang (2):
      cpufreq: powernow-k8: Use related_cpus instead of cpus in driver.exit()
      cpufreq: Fix the race condition while updating the transition_task of policy

Lijo Lazar (2):
      drm/amdgpu: Match against exact bootloader status
      drm/amd/pm: Fix temperature unit of SMU v13.0.6

Lin Ma (6):
      wifi: mt76: testmode: add nla_policy for MT76_TM_ATTR_TX_LENGTH
      wifi: nl80211/cfg80211: add forgotten nla_policy for BSS color attribute
      scsi: iscsi: Add length check for nlattr payload
      scsi: iscsi: Add strlen() check in iscsi_if_set{_host}_param()
      scsi: be2iscsi: Add length check when parsing nlattrs
      scsi: qla4xxx: Add length check when parsing nlattrs

Lin Yujun (1):
      ARM: dts: integrator: fix PCI bus dtc warnings

Lorenz Bauer (2):
      udp: re-score reuseport groups when connected sockets are present
      bpf: reject unhashed sockets in bpf_sk_assign

Luca Weiss (3):
      soc: qcom: ocmem: Add OCMEM hardware version print
      soc: qcom: ocmem: Fix NUM_PORTS & NUM_MACROS macros
      clk: qcom: gcc-sm6350: Fix gcc_sdcc2_apps_clk_src

Lucas Stach (1):
      drm/etnaviv: fix dumping of active MMU context

Luiz Augusto von Dentz (9):
      Bluetooth: hci_event: Fix parsing of CIS Established Event
      Bluetooth: ISO: Fix not checking for valid CIG/CIS IDs
      Bluetooth: hci_conn: Fix not allowing valid CIS ID
      Bluetooth: hci_conn: Fix hci_le_set_cig_params
      Bluetooth: hci_conn: Always allocate unique handles
      Bluetooth: hci_conn: Consolidate code for aborting connections
      Bluetooth: hci_sync: Fix UAF on hci_abort_conn_sync
      Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync
      Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED

Lukasz Majewski (1):
      net: dsa: microchip: KSZ9477 register regmap alignment to 32 bit boundaries

Maciej S. Szmigiero (1):
      Drivers: hv: vmbus: Don't dereference ACPI root object handle

Manish Mandlik (1):
      Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_add_adv_monitor()

Manivannan Sadhasivam (4):
      OPP: Fix passing 0 to PTR_ERR in _opp_attach_genpd()
      arm64: dts: qcom: sdm845: Add missing RPMh power domain to GCC
      arm64: dts: qcom: sdm845: Fix the min frequency of "ice_core_clk"
      PCI: qcom-ep: Switch MHI bus master clock off during L1SS

Marc Kleine-Budde (1):
      can: gs_usb: gs_usb_receive_bulk_callback(): count RX overflow errors also in case of OOM

Marco Felsch (2):
      arm64: dts: imx8mp-debix: remove unused fec pinctrl node
      clk: imx8mp: fix sai4 clock

Marek Behún (3):
      leds: multicolor: Use rounded division when calculating color components
      leds: Fix BUG_ON check for LED_COLOR_ID_MULTI that is always false
      leds: trigger: tty: Do not use LED_ON/OFF constants, use led_blink_set_oneshot instead

Marek Vasut (9):
      drm/bridge: tc358764: Fix debug print parameter order
      ARM: dts: stm32: Add missing detach mailbox for emtrion emSBC-Argon
      ARM: dts: stm32: Add missing detach mailbox for Odyssey SoM
      ARM: dts: stm32: Update to generic ADC channel binding on DHSOM systems
      ARM: dts: stm32: Add missing detach mailbox for DHCOM SoM
      ARM: dts: stm32: Add missing detach mailbox for DHCOR SoM
      drm/panel: simple: Add missing connector type and pixel format for AUO T215HVN01
      media: ov5640: Enable MIPI interface in ov5640_set_power_mipi()
      media: ov5640: Fix initial RESETB state and annotate timings

Mario Limonciello (3):
      ACPI: x86: s2idle: Post-increment variables when getting constraints
      ACPI: x86: s2idle: Fix a logic error parsing AMD constraints table
      platform/x86/amd/pmf: Fix a missing cleanup path

Mark Brown (2):
      arm64/fpsimd: Only provide the length to cpufeature for xCR registers
      regmap: Load register defaults in blocks rather than register by register

Markus Schneider-Pargmann (1):
      can: tcan4x5x: Remove reserved register 0x814 from writable table

Martin Kaiser (2):
      hwrng: nomadik - keep clock enabled while hwrng is registered
      hwrng: pic32 - use devm_clk_get_enabled

Martin Kohn (1):
      net: usb: qmi_wwan: add Quectel EM05GV2

Masahiro Yamada (1):
      kbuild: rust_is_available: remove -v option

Masami Hiramatsu (Google) (1):
      kprobes: Prohibit probing on CFI preamble symbol

Matthew Wilcox (1):
      reiserfs: Check the return value from __getblk()

Matthew Wilcox (Oracle) (2):
      iomap: Remove large folio handling in iomap_invalidate_folio()
      XArray: Do not return sibling entries from xa_load()

Max Chou (1):
      Bluetooth: btrtl: Load FW v2 otherwise FW v1 for RTL8852C

Max Filippov (1):
      xtensa: PMU: fix base address for the newer hardware

Maxim Mikityanskiy (1):
      platform/x86/intel/hid: Add HP Dragonfly G2 to VGBS DMI quirks

Menglong Dong (1):
      net: tcp: fix unexcepted socket die when snd_wnd is 0

Michael Ellerman (1):
      powerpc: Don't include lppaca.h in paca.h

Michael Tretter (1):
      media: verisilicon: Fix TRY_FMT on encoder OUTPUT

Michel Dänzer (1):
      Revert "drm/amd/display: Do not set drr on pipe commit"

Miguel Ojeda (2):
      kbuild: rust_is_available: add check for `bindgen` invocation
      kbuild: rust_is_available: fix confusion when a version appears in the path

Mike Christie (1):
      vhost-scsi: Fix alignment handling with windows

Mikel Rychliski (1):
      x86/efistub: Fix PCI ROM preservation in mixed mode

Mikhail Kobuk (1):
      tracing: Remove extra space at the end of hwlat_detector/mode

Miklos Szeredi (1):
      Revert "fuse: in fuse_flush only wait if someone wants the return code"

Min Li (1):
      Bluetooth: Fix potential use-after-free when clear keys

Ming Qian (9):
      media: imx-jpeg: Support to assign slot for encoder/decoder
      media: amphion: reinit vpu if reqbufs output 0
      media: amphion: add helper function to get id name
      media: amphion: decoder support display delay for all formats
      media: amphion: fix CHECKED_RETURN issues reported by coverity
      media: amphion: fix REVERSE_INULL issues reported by coverity
      media: amphion: fix UNINIT issues reported by coverity
      media: amphion: fix UNUSED_VALUE issue reported by coverity
      media: amphion: ensure the bitops don't cross boundaries

Ming Yen Hsieh (1):
      wifi: mt76: mt7921: fix non-PSC channel scan fail

Minjie Du (3):
      ata: pata_arasan_cf: Use dev_err_probe() instead dev_err() in data_xfer()
      drivers: clk: keystone: Fix parameter judgment in _of_pll_clk_init()
      RDMA/qedr: Remove a duplicate assignment in irdma_query_ah()

Miquel Raynal (1):
      nvmem: core: Return NULL when no nvmem layout is found

Mohamed Khalfella (1):
      skbuff: skb_segment, Call zero copy functions before using skbuff frags

Namjae Jeon (4):
      ksmbd: fix out of bounds in smb3_decrypt_req()
      ksmbd: validate session id and tree id in compound request
      ksmbd: no response from compound read
      ksmbd: fix out of bounds in init_smb2_rsp_hdr()

Nancy.Lin (1):
      drm/mediatek: Fix uninitialized symbol

Naveen N Rao (1):
      powerpc/ftrace: Fix dropping weak symbols with older toolchains

Nayna Jain (1):
      ima: Remove deprecated IMA_TRUSTED_KEYRING Kconfig

Nicholas Piggin (1):
      powerpc/pseries: Fix hcall tracepoints with JUMP_LABEL=n

Nicolas Dichtel (1):
      net: handle ARPHRD_PPP in dev_is_mac_header_xmit()

Nikita Zhandarovich (1):
      HID: logitech-dj: Fix error handling in logi_dj_recv_switch_to_dj_mode()

Nikolay Burykin (1):
      media: pci: cx23885: fix error handling for cx23885 ATSC boards

Nilesh Javali (1):
      Revert "scsi: qla2xxx: Fix buffer overrun"

Nishanth Menon (1):
      firmware: ti_sci: Use system_state to determine polling

Nysal Jan K.A (1):
      selftests/futex: Order calls to futex_lock_pi

Nícolas F. R. A. Prado (6):
      thermal/drivers/mediatek/lvts_thermal: Handle IRQ on all controllers
      thermal/drivers/mediatek/lvts_thermal: Honor sensors in immediate mode
      thermal/drivers/mediatek/lvts_thermal: Use offset threshold for IRQ
      thermal/drivers/mediatek/lvts_thermal: Disable undesired interrupts
      thermal/drivers/mediatek/lvts_thermal: Don't leave threshold zeroed
      thermal/drivers/mediatek/lvts_thermal: Manage threshold between sensors

Oleksandr Natalenko (3):
      scsi: qedf: Do not touch __user pointer in qedf_dbg_stop_io_on_error_cmd_read() directly
      scsi: qedf: Do not touch __user pointer in qedf_dbg_debug_cmd_read() directly
      scsi: qedf: Do not touch __user pointer in qedf_dbg_fp_int_cmd_read() directly

Olga Kornievskaia (1):
      NFSv4.2: fix handling of COPY ERR_OFFLOAD_NO_REQ

Olivier Moysan (1):
      ARM: dts: stm32: adopt generic iio bindings for adc channels on emstamp-argon

Ondrej Jirman (1):
      drm: bridge: dw-mipi-dsi: Fix enable/disable of DSI controller

Patrick Whewell (1):
      clk: qcom: gcc-sm8250: Fix gcc_sdcc2_apps_clk_src

Paul E. McKenney (1):
      clocksource: Handle negative skews in "skew is too large" messages

Paul Gortmaker (1):
      tick/rcu: Fix false positive "softirq work is pending" messages

Pauli Virtanen (3):
      Bluetooth: ISO: do not emit new LE Create CIS if previous is pending
      Bluetooth: hci_event: drop only unbound CIS if Set CIG Parameters fails
      Bluetooth: hci_conn: fail SCO/ISO via hci_conn_failed if ACL gone early

Pavel Begunkov (4):
      io_uring: fix drain stalls by invalid SQE
      io_uring: fix false positive KASAN warnings
      io_uring: break iopolling on signal
      io_uring: break out of iowq iopoll on teardown

Peng Fan (3):
      thermal/of: Fix potential uninitialized value access
      clk: imx: imx8ulp: update SPLL2 type
      amba: bus: fix refcount leak

Peter Chiu (3):
      wifi: mt76: mt7915: rework tx packets counting when WED is active
      wifi: mt76: mt7915: rework tx bytes counting when WED is active
      wifi: mt76: mt7996: fix bss wlan_idx when sending bss_info command

Phil Elwell (1):
      ASoC: cs43130: Fix numerator/denominator mixup

Pierre-Louis Bossart (2):
      ASoC: SOF: Intel: hda-mlink: fix off-by-one error
      ASoC: SOF: Intel: fix u16/32 confusion in LSDIID

Ping-Ke Shih (1):
      wifi: rtw89: 8852b: rfk: fine tune IQK parameters to improve performance on 2GHz band

Polaris Pi (2):
      wifi: mwifiex: Fix OOB and integer underflow when rx packets
      wifi: mwifiex: Fix missed return in oob checks failed path

Przemek Kitszel (1):
      ice: ice_aq_check_events: fix off-by-one check when filling buffer

Qi Zheng (1):
      arm64: mm: use ptep_clear() instead of pte_clear() in clear_flush()

Qiuxu Zhuo (2):
      EDAC/i10nm: Skip the absent memory controllers
      EDAC/igen6: Fix the issue of no error events

Quentin Monnet (1):
      bpftool: Use a local copy of BPF_LINK_TYPE_PERF_EVENT in pid_iter.bpf.c

RD Babiera (2):
      usb: typec: tcpm: set initial svdm version based on pd revision
      usb: typec: bus: verify partner exists in typec_altmode_attention

Radoslaw Tyl (1):
      igb: set max size RX buffer when store bad packet is enabled

Rafael J. Wysocki (1):
      cpuidle: teo: Update idle duration estimate when choosing shallower state

Rafał Miłecki (6):
      ARM: dts: BCM53573: Drop nonexistent "default-off" LED trigger
      ARM: dts: BCM53573: Drop nonexistent #usb-cells
      ARM: dts: BCM53573: Add cells sizes to PCIe node
      ARM: dts: BCM53573: Use updated "spi-gpio" binding properties
      ARM: dts: BCM53573: Fix Ethernet info for Luxul devices
      ARM: dts: BCM53573: Fix Tenda AC9 switch CPU port

Rahul Rameshbabu (3):
      net/mlx5: Dynamic cyclecounter shift calculation for PTP free running clock
      HID: uclogic: Correct devm device reference for hidinput input_dev name
      HID: multitouch: Correct devm device reference for hidinput input_dev name

Randy Dunlap (6):
      sched/psi: Select KERNFS as needed
      ASoC: stac9766: fix build errors with REGMAP_AC97
      x86/APM: drop the duplicate APM_MINOR_DEV macro
      docs: ABI: fix spelling/grammar in SBEFIFO timeout interface
      f2fs: fix spelling in ABI documentation
      um: Fix hostaudio build errors

Ranjan Kumar (1):
      scsi: mpt3sas: Perform additional retries if doorbell read returns 0

Rany Hany (1):
      wifi: mt76: mt7915: fix command timeout in AP stop period

Raphael Gallais-Pou (1):
      staging: fbtft: ili9341: use macro FBTFT_REGISTER_SPI_DRIVER

Rex Zhang (1):
      dmaengine: idxd: Modify the dependence of attribute pasid_enabled

Rick Wertenbroek (1):
      PCI: rockchip: Use 64-bit mask on MSI 64-bit PCI address

Rob Clark (2):
      drm/msm/a6xx: Fix GMU lockdep splat
      dma-buf/sync_file: Fix docs syntax

Rob Herring (1):
      ARM: dts: Add .dts files missing from the build

Robert Marko (1):
      ARM: dts: qcom: ipq4019: correct SDHCI XO clock

Rohit Agarwal (1):
      ARM: dts: qcom: sdx65-mtp: Update the pmic used in sdx65

Ross Lagerwall (1):
      PCI: Free released resource after coalescing

Ruan Jinjie (2):
      net: lan966x: Fix return value check for vcap_get_rule()
      of: unittest: fix null pointer dereferencing in of_unittest_find_node_by_name()

Ruidong Tian (1):
      coresight: tmc: Explicit type conversions to prevent integer overflow

Russell Currey (3):
      kbuild: rust_is_available: fix version check when CC has multiple arguments
      powerpc/pseries: Rework lppaca_shared_proc() to avoid DEBUG_PREEMPT
      powerpc/iommu: Fix notifiers being shared by PCI and VIO buses

Ryan McCann (1):
      drm/msm: Update dev core dump to not print backwards

Ryder Lee (3):
      wifi: mt76: mt7996: fix header translation logic
      wifi: mt76: mt7915: fix tlv length of mt7915_mcu_get_chan_mib_info
      wifi: mt76: mt7915: fix power-limits while chan_switch

Sabrina Dubroca (1):
      Revert "net: macsec: preserve ingress frame ordering"

Sakari Ailus (2):
      media: i2c: ccs: Check rules is non-NULL
      media: i2c: Add a camera sensor top level menu

Saurabh Sengar (1):
      x86/hyperv: add noop functions to x86_init mpparse functions

Sean Christopherson (1):
      KVM: x86/mmu: Add "never" option to allow sticky disabling of nx_huge_pages

Shannon Nelson (5):
      pds_core: protect devlink callbacks from fw_down state
      pds_core: no health reporter in VF
      pds_core: no reset command for VF
      pds_core: check for work queue before use
      pds_core: pass opcode to devcmd_wait

Shih-Yi Chen (1):
      platform/mellanox: Fix mlxbf-tmfifo not handling all virtio CONSOLE notifications

Shuming Fan (5):
      ASoC: rt5682-sdw: fix for JD event handling in ClockStop Mode0
      ASoC: rt712-sdca: fix for JD event handling in ClockStop Mode0
      ASoC: rt711: fix for JD event handling in ClockStop Mode0
      ASoC: rt711-sdca: fix for JD event handling in ClockStop Mode0
      ASoC: rt1308-sdw: fix random louder sound

Simon Trimmer (1):
      ASoC: cs35l56: Add an ACPI match table

Song Liu (1):
      x86/build: Fix linker fill bytes quirk/incompatibility for ld.lld

Sourabh Jain (1):
      powerpc/fadump: reset dump area size if fadump memory reserve fails

Srinivasan Shanmugam (1):
      drm/amdgpu: Update min() to min_t() in 'amdgpu_info_ioctl'

StanleyYP Wang (3):
      wifi: mt76: mt7915: fix background radar event being blocked
      wifi: mt76: mt7996: use correct phy for background radar event
      wifi: mt76: mt7996: fix WA event ring size

Stefan Binding (1):
      ALSA: hda/cs8409: Support new Dell Dolphin Variants

Stefan Haberland (2):
      s390/dasd: use correct number of retries for ERP requests
      s390/dasd: fix hanging device after request requeue

Stefan Hajnoczi (1):
      vfio/type1: fix cap_migration information leak

Stephan Gerhold (4):
      arm64: dts: qcom: msm8916: Fix regulator constraints
      arm64: dts: qcom: msm8916: Disable audio codecs by default
      arm64: dts: qcom: msm8916: Define regulator constraints next to usage
      arm64: dts: qcom: msm8916: Rename &msmgpio -> &tlmm

Steve Rutherford (1):
      x86/sev: Make enc_dec_hypercall() accept a size instead of npages

Su Hui (2):
      ALSA: ac97: Fix possible error value of *rac97
      fs: lockd: avoid possible wrong NULL parameter

Sui Jingfeng (2):
      drm/hyperv: Fix a compilation issue because of not including screen_info.h
      drm/mediatek: Fix potential memory leak if vmap() fail

Suman Ghosh (2):
      octeontx2-pf: Fix PFC TX scheduler free
      cteonxt2-pf: Fix backpressure config for multiple PFC priorities to work simultaneously

Sumit Gupta (2):
      cpufreq: tegra194: add online/offline hooks
      cpufreq: tegra194: remove opp table in exit hook

Sven Peter (1):
      PCI: apple: Initialize pcie->nvecs before use

Sven Schnelle (1):
      s390/ipl: add missing secure/has_secure file to ipl type 'unknown'

Swapnil Sapkal (2):
      cpufreq: amd-pstate-ut: Remove module parameter access
      cpufreq: amd-pstate-ut: Fix kernel panic when loading the driver

Takashi Iwai (2):
      ALSA: usb-audio: Add quirk for Microsoft Modern Wireless Headset
      ALSA: pcm: Fix missing fixup call in compat hw_refine ioctl

Tejun Heo (1):
      blk-cgroup: Fix NULL deref caused by blkg_policy_data being installed before init

Thomas Bourgoin (2):
      crypto: stm32 - fix loop iterating through scatterlist for DMA
      crypto: stm32 - fix MDMAT condition

Thomas Gleixner (1):
      cpu/hotplug: Prevent self deadlock on CPU hot-unplug

Thomas Zimmermann (3):
      backlight/gpio_backlight: Compare against struct fb_info.device
      backlight/bd6107: Compare against struct fb_info.device
      backlight/lv5207lp: Compare against struct fb_info.device

Thore Sommer (1):
      X.509: if signature is unsupported skip validation

Tomi Valkeinen (1):
      media: Documentation: Fix [GS]_ROUTING documentation

Tommaso Merciai (1):
      media: i2c: imx290: drop format param from imx290_ctrl_update

Tony Battersby (1):
      scsi: core: Use 32-bit hostnum in scsi_host_lookup()

Tony Lindgren (2):
      bus: ti-sysc: Fix build warning for 64-bit build
      bus: ti-sysc: Fix cast to enum warning

Tzung-Bi Shih (1):
      platform/chrome: chromeos_acpi: print hex string for ACPI_TYPE_BUFFER

Uros Bizjak (1):
      locking/arch: Avoid variable shadowing in local_try_cmpxchg()

Uwe Kleine-König (1):
      crypto: stm32 - Properly handle pm_runtime_get failing

Vadim Pasternak (3):
      mlxsw: i2c: Fix chunk size setting in output mailbox buffer
      mlxsw: i2c: Limit single transaction buffer size
      mlxsw: core_hwmon: Adjust module label names based on MTCAP sensor counter

Vidya Sagar (1):
      Revert "PCI: tegra194: Enable support for 256 Byte payload"

Vijaya Krishna Nivarthi (1):
      tty: serial: qcom-geni-serial: Poll primary sequencer irq status after cancel_tx

Vijendar Mukunda (1):
      ASoC: SOF: amd: clear dsp to host interrupt status

Vincent Guittot (1):
      arm64: dts: qcom: sm8250: correct dynamic power coefficients

Vincent Whitchurch (1):
      um: virt-pci: fix missing declaration warning

Vitaly Rodionov (1):
      ALSA: hda/cirrus: Fix broken audio on hardware with two CS42L42 codecs.

Vlad Karpovich (1):
      firmware: cs_dsp: Fix new control name check

Waiman Long (2):
      refscale: Fix uninitalized use of wait_queue_head_t
      cgroup/cpuset: Inherit parent's load balance state in v2

Wander Lairson Costa (2):
      netfilter: xt_u32: validate user space input
      netfilter: xt_sctp: validate the flag_info count

Wang Ming (4):
      ksmbd: Fix unsigned expression compared with zero
      platform/x86: think-lmi: Use kfree_sensitive instead of kfree
      fs: Fix error checking for d_hash_and_lookup()
      wifi: ath9k: use IS_ERR() with debugfs_create_dir()

Wen Gong (1):
      wifi: ath12k: Fix buffer overflow when scanning with extraie

Wen Yang (1):
      eventfd: prevent underflow for eventfd semaphores

Werner Sembach (1):
      Input: i8042 - add quirk for TUXEDO Gemini 17 Gen1/Clevo PD70PN

Wesley Chalmers (1):
      drm/amd/display: Do not set drr on pipe commit

Will Deacon (1):
      arm64: csum: Fix OoB access in IP checksum code for negative lengths

William Zhang (1):
      mtd: rawnand: brcmnand: Fix mtd oobsize

Winston Wen (2):
      fs/nls: make load_nls() take a const parameter
      cifs: fix charset issue in reconnection

Wolfram Sang (1):
      mmc: renesas_sdhi: register irqs before registering controller

Wu Zongyong (1):
      PCI: Mark NVIDIA T4 GPUs to avoid bus reset

Xiang Yang (1):
      IB/uverbs: Fix an potential error pointer dereference

Xiao Liang (1):
      netfilter: nft_exthdr: Fix non-linear header modification

Xingui Yang (2):
      scsi: hisi_sas: Fix warnings detected by sparse
      scsi: hisi_sas: Fix normally completed I/O analysed as failed

Xu Yang (2):
      perf/imx_ddr: don't enable counter0 if none of 4 counters are used
      usb: phy: mxs: fix getting wrong state with mxs_phy_is_otg_host()

Yafang Shao (4):
      bpf: Clear the probe_addr for uprobe
      bpf: Fix an error around PTR_UNTRUSTED
      bpf: Fix an error in verifying a field in a union
      bpf: Fix issue in verifying allow_ptr_leaks

Yan Zhai (2):
      lwt: Fix return values of BPF xmit ops
      lwt: Check LWTUNNEL_XMIT_CONTINUE strictly

Yanfei Xu (1):
      iommu/vt-d: Fix to flush cache of PASID directory table

Yang Li (1):
      platform/x86/amd/pmf: Fix unsigned comparison with less than zero

Yang Wang (1):
      drm/amd/pm: fix variable dereferenced issue in amdgpu_device_attr_create()

Yang Yingliang (1):
      media: nxp: Fix wrong return pointer check in mxc_isi_crossbar_init()

Yangtao Li (2):
      drm/tegra: dpaux: Fix incorrect return value of platform_get_irq
      f2fs: refactor struct f2fs_attr macro

Yazen Ghannam (1):
      x86/MCE: Always save CS register on AMD Zen IF Poison errors

Ye Li (1):
      clk: imx: pllv4: Fix SPLL2 MULT range

Yi Liu (1):
      kvm/vfio: Prepare for accepting vfio device fd

Yi Yang (3):
      serial: tegra: handle clk prepare error in tegra_uart_hw_init()
      mtd: rawnand: fsmc: handle clk prepare error in fsmc_nand_resume()
      ipmi_si: fix a memleak in try_smi_init()

Yipeng Zou (2):
      selftests/bpf: Fix repeat option when kfunc_call verification fails
      selftests/bpf: Clean up fmod_ret in bench_rename test script

Yonatan Nachum (1):
      RDMA/efa: Fix wrong resources deallocation order

Yonghong Song (1):
      bpf: Fix a bpf_kptr_xchg() issue with local kptr

Yu Kuai (5):
      md: restore 'noio_flag' for the last mddev_resume()
      md/md-bitmap: remove unnecessary local variable in backlog_store()
      md/md-bitmap: hold 'reconfig_mutex' in backlog_store()
      md/raid5-cache: fix a deadlock in r5l_exit_log()
      md/raid5-cache: fix null-ptr-deref for r5l_flush_stripe_to_raid()

Yuan Yao (1):
      virtio_ring: fix avail_wrap_counter in virtqueue_add_packed

Yuanjun Gong (2):
      ethernet: atheros: fix return value check in atl1c_tso_csum()
      Bluetooth: nokia: fix value check in nokia_bluetooth_serdev_probe()

Zeyan Li (1):
      arm64: dts: qcom: sm8150: Fix the I2C7 interrupt

Zhang Jianhua (1):
      clk: sunxi-ng: Modify mismatched function name

Zhang Shurong (3):
      wifi: rtw89: debug: Fix error handling in rtw89_debug_priv_btc_manual_set()
      spi: tegra20-sflash: fix to check return value of platform_get_irq() in tegra_sflash_probe()
      firmware: meson_sm: fix to avoid potential NULL pointer dereference

Zheng Wang (1):
      media: mtk-jpeg: Fix use after free bug due to uncanceled work

Zheng Yang (1):
      phy/rockchip: inno-hdmi: round fractal pixclock in rk3328 recalc_rate

Zheng Yejian (2):
      tracing: Introduce pipe_cpumask to avoid race on trace_pipes
      tracing: Fix race issue between cpu buffer write and swap

Zhiguo Niu (1):
      block/mq-deadline: use correct way to throttling write requests

Zhihao Cheng (1):
      ext4: fix unttached inode after power cut with orphan file feature enabled

Zhihong Dong (1):
      LoongArch: Fix CMDLINE_EXTEND and CMDLINE_BOOTLOADER handling

Zhu Wang (2):
      fbdev: goldfishfb: Do not check 0 for platform_get_irq()
      iommu: Remove kernel-doc warnings

Zqiang (1):
      rcu: dump vmalloc memory info safely

ruanjinjie (1):
      dmaengine: ste_dma40: Add missing IRQ check in d40_probe

yixuanjiang (1):
      ASoC: soc-compress: Fix deadlock in soc_compr_open_fe

