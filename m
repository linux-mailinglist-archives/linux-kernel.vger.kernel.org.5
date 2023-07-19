Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F23F75991D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjGSPGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjGSPGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:06:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BAE1711;
        Wed, 19 Jul 2023 08:06:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC3AE611F9;
        Wed, 19 Jul 2023 15:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4ACDC433C8;
        Wed, 19 Jul 2023 15:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689779199;
        bh=BMwLBuqByrsecan4KZthPbUT6UJO6vMLZ1ZQVMqE+Q4=;
        h=From:To:Cc:Subject:Date:From;
        b=DLqve5VzTf3HOopS9wOz/wcMYl9mhkLLqTjD5E7uqcbrIU2NCdlKQu55ZqlaoziiC
         E9WuXvuHlWa/ha/AScScL6nbArIJjv/8xK7UbSphChjPJCKDV7Oje4xhBkugcSO8AC
         pH8Po+FahUeMfswyIGDSzEOIN5GXE+3fc/ar3NgI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.39
Date:   Wed, 19 Jul 2023 17:06:34 +0200
Message-ID: <2023071934-curliness-ammonium-6695@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.1.39 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-driver-eud                           |    2 
 Documentation/devicetree/bindings/power/reset/qcom,pon.yaml          |    4 
 Documentation/fault-injection/provoke-crashes.rst                    |    2 
 Documentation/filesystems/autofs-mount-control.rst                   |    2 
 Documentation/filesystems/autofs.rst                                 |    2 
 Documentation/filesystems/directory-locking.rst                      |   26 
 Documentation/networking/af_xdp.rst                                  |    9 
 Makefile                                                             |    2 
 arch/arc/include/asm/linkage.h                                       |    8 
 arch/arm/boot/dts/bcm53015-meraki-mr26.dts                           |    2 
 arch/arm/boot/dts/bcm53016-meraki-mr32.dts                           |    2 
 arch/arm/boot/dts/bcm5301x.dtsi                                      |    1 
 arch/arm/boot/dts/iwg20d-q7-common.dtsi                              |    2 
 arch/arm/boot/dts/lan966x-kontron-kswitch-d10-mmt.dtsi               |   16 
 arch/arm/boot/dts/meson8.dtsi                                        |    4 
 arch/arm/boot/dts/meson8b.dtsi                                       |    4 
 arch/arm/boot/dts/omap3-gta04a5one.dts                               |    4 
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts                       |    4 
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts                      |    8 
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi                        |   10 
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi                        |   12 
 arch/arm/boot/dts/qcom-msm8974.dtsi                                  |    2 
 arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi                        |   11 
 arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi                   |    8 
 arch/arm/boot/dts/stm32mp15xx-dhcor-drc-compact.dtsi                 |    6 
 arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi                         |    6 
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi                               |    2 
 arch/arm/include/asm/assembler.h                                     |   17 
 arch/arm/include/asm/sync_bitops.h                                   |   29 
 arch/arm/lib/bitops.h                                                |   14 
 arch/arm/lib/testchangebit.S                                         |    4 
 arch/arm/lib/testclearbit.S                                          |    4 
 arch/arm/lib/testsetbit.S                                            |    4 
 arch/arm/mach-ep93xx/timer-ep93xx.c                                  |    3 
 arch/arm/mach-omap2/board-generic.c                                  |    1 
 arch/arm/mach-orion5x/board-dt.c                                     |    3 
 arch/arm/mach-orion5x/common.h                                       |    6 
 arch/arm/probes/kprobes/checkers-common.c                            |    2 
 arch/arm/probes/kprobes/core.c                                       |    2 
 arch/arm/probes/kprobes/opt-arm.c                                    |    2 
 arch/arm/probes/kprobes/test-core.c                                  |    2 
 arch/arm/probes/kprobes/test-core.h                                  |    4 
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi                       |    4 
 arch/arm64/boot/dts/mediatek/mt8192.dtsi                             |   22 
 arch/arm64/boot/dts/microchip/sparx5.dtsi                            |    2 
 arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi                 |   12 
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts                             |   78 +-
 arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts                         |    4 
 arch/arm64/boot/dts/qcom/msm8916.dtsi                                |    6 
 arch/arm64/boot/dts/qcom/msm8994.dtsi                                |    2 
 arch/arm64/boot/dts/qcom/msm8996.dtsi                                |    2 
 arch/arm64/boot/dts/qcom/pm7250b.dtsi                                |    1 
 arch/arm64/boot/dts/qcom/sdm630.dtsi                                 |    2 
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts                   |    1 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                                 |    3 
 arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi                 |    7 
 arch/arm64/boot/dts/qcom/sm8350.dtsi                                 |    8 
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi                             |    3 
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts                |   28 
 arch/arm64/include/asm/fpsimdmacros.h                                |    6 
 arch/powerpc/Kconfig.debug                                           |    2 
 arch/powerpc/boot/dts/turris1x.dts                                   |    6 
 arch/powerpc/kernel/interrupt.c                                      |    3 
 arch/powerpc/kernel/ppc_save_regs.S                                  |   61 -
 arch/powerpc/kernel/signal_32.c                                      |   15 
 arch/powerpc/mm/book3s64/radix_pgtable.c                             |   34 
 arch/powerpc/mm/init_64.c                                            |    2 
 arch/powerpc/platforms/powernv/pci-sriov.c                           |    6 
 arch/powerpc/platforms/powernv/vas-window.c                          |    2 
 arch/powerpc/platforms/pseries/vas.c                                 |    2 
 arch/riscv/kernel/probes/uprobes.c                                   |    2 
 arch/riscv/mm/init.c                                                 |    4 
 arch/s390/kvm/diag.c                                                 |    8 
 arch/s390/kvm/kvm-s390.c                                             |    4 
 arch/s390/kvm/vsie.c                                                 |    6 
 arch/sh/boards/mach-dreamcast/irq.c                                  |    6 
 arch/sh/boards/mach-highlander/setup.c                               |    4 
 arch/sh/boards/mach-r2d/irq.c                                        |    4 
 arch/sh/cchips/Kconfig                                               |    4 
 arch/sh/drivers/dma/dma-sh.c                                         |   37 
 arch/sh/include/asm/hd64461.h                                        |    2 
 arch/sh/include/mach-common/mach/highlander.h                        |    2 
 arch/sh/include/mach-common/mach/r2d.h                               |    2 
 arch/sh/include/mach-dreamcast/mach/sysasic.h                        |    2 
 arch/sh/include/mach-se/mach/se7724.h                                |    2 
 arch/sh/kernel/cpu/sh2/probe.c                                       |    2 
 arch/sh/kernel/cpu/sh3/entry.S                                       |    4 
 arch/um/Makefile                                                     |    2 
 arch/x86/coco/tdx/tdx.c                                              |   51 +
 arch/x86/events/amd/core.c                                           |    2 
 arch/x86/events/amd/ibs.c                                            |   53 -
 arch/x86/include/asm/perf_event.h                                    |    2 
 arch/x86/include/asm/pgtable_64.h                                    |    4 
 arch/x86/include/asm/sev.h                                           |   16 
 arch/x86/include/asm/x86_init.h                                      |    2 
 arch/x86/kernel/cpu/resctrl/rdtgroup.c                               |    8 
 arch/x86/kernel/sev.c                                                |   14 
 arch/x86/kernel/x86_init.c                                           |    2 
 arch/x86/mm/mem_encrypt_amd.c                                        |    4 
 arch/x86/mm/pat/set_memory.c                                         |    3 
 arch/x86/platform/efi/efi_64.c                                       |    6 
 block/blk-iocost.c                                                   |    7 
 block/blk-mq-debugfs.c                                               |    2 
 block/blk-mq-tag.c                                                   |   15 
 block/blk-mq.h                                                       |    3 
 block/disk-events.c                                                  |    1 
 block/genhd.c                                                        |    5 
 block/partitions/amiga.c                                             |  104 ++
 crypto/jitterentropy.c                                               |    9 
 drivers/base/power/domain.c                                          |   15 
 drivers/base/property.c                                              |  132 ++-
 drivers/bus/fsl-mc/dprc-driver.c                                     |    6 
 drivers/bus/ti-sysc.c                                                |    4 
 drivers/char/hw_random/st-rng.c                                      |   21 
 drivers/char/hw_random/virtio-rng.c                                  |   10 
 drivers/clk/bcm/clk-raspberrypi.c                                    |    4 
 drivers/clk/clk-cdce925.c                                            |   12 
 drivers/clk/clk-renesas-pcie.c                                       |    2 
 drivers/clk/clk-si5341.c                                             |   38 -
 drivers/clk/clk-versaclock5.c                                        |   48 -
 drivers/clk/clk-versaclock7.c                                        |    2 
 drivers/clk/clk.c                                                    |    2 
 drivers/clk/imx/clk-imx8mn.c                                         |    8 
 drivers/clk/imx/clk-imx8mp.c                                         |   24 
 drivers/clk/imx/clk-imx93.c                                          |   15 
 drivers/clk/imx/clk-imxrt1050.c                                      |   22 
 drivers/clk/imx/clk-scu.c                                            |    4 
 drivers/clk/keystone/sci-clk.c                                       |    2 
 drivers/clk/qcom/camcc-sc7180.c                                      |   19 
 drivers/clk/qcom/dispcc-qcm2290.c                                    |   12 
 drivers/clk/qcom/gcc-ipq6018.c                                       |   34 
 drivers/clk/qcom/gcc-qcm2290.c                                       |   62 -
 drivers/clk/qcom/mmcc-msm8974.c                                      |   23 
 drivers/clk/qcom/reset.c                                             |    4 
 drivers/clk/qcom/reset.h                                             |    1 
 drivers/clk/renesas/rzg2l-cpg.c                                      |    6 
 drivers/clk/renesas/rzg2l-cpg.h                                      |    3 
 drivers/clk/tegra/clk-tegra124-emc.c                                 |    2 
 drivers/clk/ti/clkctrl.c                                             |    7 
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c                           |    2 
 drivers/clocksource/timer-cadence-ttc.c                              |   19 
 drivers/cpufreq/intel_pstate.c                                       |    2 
 drivers/cpufreq/mediatek-cpufreq.c                                   |   13 
 drivers/crypto/marvell/cesa/cipher.c                                 |    2 
 drivers/crypto/nx/Makefile                                           |    2 
 drivers/crypto/nx/nx.h                                               |    4 
 drivers/crypto/qat/qat_common/qat_asym_algs.c                        |   20 
 drivers/dax/bus.c                                                    |   61 +
 drivers/dax/dax-private.h                                            |    4 
 drivers/dax/kmem.c                                                   |    2 
 drivers/extcon/extcon-usbc-tusb320.c                                 |   47 -
 drivers/extcon/extcon.c                                              |    8 
 drivers/firmware/efi/libstub/efi-stub-helper.c                       |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                               |   11 
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c                              |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                              |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                               |   16 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c                      |   13 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                    |   10 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c |    3 
 drivers/gpu/drm/amd/display/dc/core/dc.c                             |    3 
 drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c       |    2 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c    |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c              |   18 
 drivers/gpu/drm/bridge/analogix/anx7625.c                            |  133 ++-
 drivers/gpu/drm/bridge/ite-it6505.c                                  |    3 
 drivers/gpu/drm/bridge/tc358767.c                                    |    4 
 drivers/gpu/drm/bridge/tc358768.c                                    |   93 +-
 drivers/gpu/drm/bridge/ti-sn65dsi83.c                                |   20 
 drivers/gpu/drm/display/drm_dp_mst_topology.c                        |    2 
 drivers/gpu/drm/drm_bridge.c                                         |  145 +++
 drivers/gpu/drm/drm_gem_vram_helper.c                                |    6 
 drivers/gpu/drm/i915/display/intel_ddi.c                             |    8 
 drivers/gpu/drm/i915/display/intel_display_types.h                   |    1 
 drivers/gpu/drm/i915/display/intel_psr.c                             |    4 
 drivers/gpu/drm/i915/display/intel_tc.c                              |  127 ++-
 drivers/gpu/drm/i915/display/intel_tc.h                              |    3 
 drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.c                          |    2 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c                                |    3 
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c                             |    5 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c                       |   10 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h                       |   12 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c                           |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c                           |    5 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c                          |    8 
 drivers/gpu/drm/msm/dp/dp_display.c                                  |    2 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                   |   25 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c                           |    3 
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c                      |   11 
 drivers/gpu/drm/panel/panel-simple.c                                 |    4 
 drivers/gpu/drm/radeon/ci_dpm.c                                      |   28 
 drivers/gpu/drm/radeon/cypress_dpm.c                                 |    8 
 drivers/gpu/drm/radeon/ni_dpm.c                                      |    8 
 drivers/gpu/drm/radeon/rv740_dpm.c                                   |    8 
 drivers/gpu/drm/sun4i/sun4i_tcon.c                                   |   19 
 drivers/gpu/drm/vkms/vkms_composer.c                                 |    4 
 drivers/gpu/drm/vkms/vkms_drv.h                                      |    4 
 drivers/gpu/drm/vkms/vkms_formats.c                                  |  131 +--
 drivers/gpu/drm/vkms/vkms_formats.h                                  |    2 
 drivers/gpu/drm/vkms/vkms_plane.c                                    |    2 
 drivers/hid/Kconfig                                                  |    2 
 drivers/hwmon/f71882fg.c                                             |    7 
 drivers/hwmon/gsc-hwmon.c                                            |    6 
 drivers/hwmon/pmbus/adm1275.c                                        |   52 -
 drivers/hwtracing/coresight/coresight-core.c                         |    9 
 drivers/hwtracing/ptt/hisi_ptt.c                                     |   12 
 drivers/hwtracing/ptt/hisi_ptt.h                                     |    2 
 drivers/i2c/busses/i2c-designware-pcidrv.c                           |   13 
 drivers/i2c/busses/i2c-nvidia-gpu.c                                  |    7 
 drivers/i2c/busses/i2c-qup.c                                         |   21 
 drivers/i2c/busses/i2c-xiic.c                                        |    2 
 drivers/i3c/master/svc-i3c-master.c                                  |   19 
 drivers/iio/accel/fxls8962af-core.c                                  |    8 
 drivers/iio/adc/ad7192.c                                             |    8 
 drivers/infiniband/hw/bnxt_re/main.c                                 |   20 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                             |   40 -
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                             |    2 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c                           |   46 -
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h                           |    1 
 drivers/infiniband/hw/hfi1/ipoib_tx.c                                |    4 
 drivers/infiniband/hw/hfi1/mmu_rb.c                                  |  101 +-
 drivers/infiniband/hw/hfi1/mmu_rb.h                                  |    3 
 drivers/infiniband/hw/hfi1/sdma.c                                    |   23 
 drivers/infiniband/hw/hfi1/sdma.h                                    |   47 -
 drivers/infiniband/hw/hfi1/sdma_txreq.h                              |    2 
 drivers/infiniband/hw/hfi1/user_sdma.c                               |  137 +--
 drivers/infiniband/hw/hfi1/user_sdma.h                               |    1 
 drivers/infiniband/hw/hfi1/vnic_sdma.c                               |    4 
 drivers/infiniband/hw/hns/hns_roce_hem.c                             |    7 
 drivers/infiniband/hw/irdma/uk.c                                     |   10 
 drivers/infiniband/sw/rxe/rxe.h                                      |   19 
 drivers/infiniband/sw/rxe/rxe_mw.c                                   |   37 
 drivers/input/misc/adxl34x.c                                         |    3 
 drivers/input/misc/drv260x.c                                         |    1 
 drivers/input/misc/pm8941-pwrkey.c                                   |   19 
 drivers/iommu/virtio-iommu.c                                         |   57 +
 drivers/irqchip/irq-jcore-aic.c                                      |    7 
 drivers/irqchip/irq-loongson-pch-pic.c                               |   10 
 drivers/irqchip/irq-stm32-exti.c                                     |   12 
 drivers/leds/trigger/ledtrig-netdev.c                                |    3 
 drivers/mailbox/ti-msgmgr.c                                          |   12 
 drivers/md/bcache/btree.c                                            |   25 
 drivers/md/bcache/btree.h                                            |    1 
 drivers/md/bcache/super.c                                            |    4 
 drivers/md/bcache/writeback.c                                        |   10 
 drivers/md/dm-crypt.c                                                |    3 
 drivers/md/dm-ioctl.c                                                |   43 -
 drivers/md/dm-log-userspace-transfer.c                               |    5 
 drivers/md/dm-log.c                                                  |    3 
 drivers/md/dm-mpath.c                                                |    2 
 drivers/md/dm-ps-service-time.c                                      |    3 
 drivers/md/dm-raid1.c                                                |    7 
 drivers/md/dm-snap-persistent.c                                      |    6 
 drivers/md/dm-snap-transient.c                                       |    3 
 drivers/md/dm-snap.c                                                 |   27 
 drivers/md/dm-stripe.c                                               |   12 
 drivers/md/dm-table.c                                                |   20 
 drivers/md/dm-thin-metadata.c                                        |    8 
 drivers/md/dm-uevent.h                                               |    2 
 drivers/md/dm-writecache.c                                           |    4 
 drivers/md/dm-zoned-metadata.c                                       |   14 
 drivers/md/md-bitmap.c                                               |   21 
 drivers/md/md-bitmap.h                                               |    7 
 drivers/md/md.c                                                      |    9 
 drivers/md/raid1-10.c                                                |   42 +
 drivers/md/raid1.c                                                   |   25 
 drivers/md/raid10.c                                                  |   75 --
 drivers/media/cec/i2c/Kconfig                                        |    1 
 drivers/media/i2c/hi846.c                                            |    3 
 drivers/media/i2c/st-mipid02.c                                       |    9 
 drivers/media/platform/amphion/vdec.c                                |    7 
 drivers/media/platform/amphion/venc.c                                |    4 
 drivers/media/platform/amphion/vpu_malone.c                          |   12 
 drivers/media/platform/amphion/vpu_v4l2.c                            |    5 
 drivers/media/platform/amphion/vpu_v4l2.h                            |    2 
 drivers/media/platform/mediatek/vcodec/vdec_msg_queue.c              |   33 
 drivers/media/platform/mediatek/vcodec/vdec_msg_queue.h              |   16 
 drivers/media/platform/qcom/venus/helpers.c                          |    4 
 drivers/media/usb/dvb-usb-v2/az6007.c                                |    3 
 drivers/media/usb/siano/smsusb.c                                     |    3 
 drivers/memory/brcmstb_dpfe.c                                        |    4 
 drivers/memstick/host/r592.c                                         |    4 
 drivers/mfd/intel-lpss-acpi.c                                        |    3 
 drivers/mfd/rt5033.c                                                 |    3 
 drivers/mfd/stmfx.c                                                  |    7 
 drivers/mfd/stmpe.c                                                  |    4 
 drivers/mfd/wcd934x.c                                                |    9 
 drivers/misc/fastrpc.c                                               |    3 
 drivers/misc/lkdtm/core.c                                            |    2 
 drivers/mmc/core/card.h                                              |   30 
 drivers/mmc/core/quirks.h                                            |   27 
 drivers/mmc/core/sd.c                                                |    2 
 drivers/mmc/host/mmci.c                                              |    1 
 drivers/mmc/host/mtk-sd.c                                            |    2 
 drivers/mmc/host/sdhci.c                                             |    4 
 drivers/mtd/parsers/Kconfig                                          |    2 
 drivers/net/bonding/bond_main.c                                      |    2 
 drivers/net/can/kvaser_pciefd.c                                      |   39 -
 drivers/net/dsa/ocelot/felix.c                                       |   12 
 drivers/net/dsa/sja1105/sja1105.h                                    |    2 
 drivers/net/dsa/sja1105/sja1105_main.c                               |   14 
 drivers/net/dsa/sja1105/sja1105_ptp.c                                |   48 -
 drivers/net/dsa/vitesse-vsc73xx-core.c                               |    6 
 drivers/net/ethernet/broadcom/tg3.c                                  |    1 
 drivers/net/ethernet/ibm/ibmvnic.c                                   |    9 
 drivers/net/ethernet/intel/ice/ice.h                                 |    7 
 drivers/net/ethernet/intel/ice/ice_main.c                            |   29 
 drivers/net/ethernet/intel/ice/ice_ptp.c                             |   12 
 drivers/net/ethernet/intel/ice/ice_ptp.h                             |    4 
 drivers/net/ethernet/intel/igc/igc.h                                 |   28 
 drivers/net/ethernet/intel/igc/igc_main.c                            |   31 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c                      |    7 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h                      |   11 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c                  |    4 
 drivers/net/ethernet/mellanox/mlxsw/minimal.c                        |    1 
 drivers/net/ethernet/mscc/ocelot.c                                   |    1 
 drivers/net/ethernet/mscc/ocelot_ptp.c                               |   66 +
 drivers/net/ethernet/sfc/ef10.c                                      |   13 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                    |    6 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                    |   10 
 drivers/net/gtp.c                                                    |    2 
 drivers/net/ipvlan/ipvlan_core.c                                     |    9 
 drivers/net/ppp/pptp.c                                               |   31 
 drivers/net/wireguard/netlink.c                                      |   14 
 drivers/net/wireguard/queueing.c                                     |    1 
 drivers/net/wireguard/queueing.h                                     |   25 
 drivers/net/wireguard/receive.c                                      |    2 
 drivers/net/wireguard/send.c                                         |    2 
 drivers/net/wireless/ath/ath10k/core.c                               |   12 
 drivers/net/wireless/ath/ath10k/core.h                               |    3 
 drivers/net/wireless/ath/ath10k/mac.c                                |   13 
 drivers/net/wireless/ath/ath11k/qmi.c                                |    5 
 drivers/net/wireless/ath/ath9k/ar9003_hw.c                           |   27 
 drivers/net/wireless/ath/ath9k/htc_hst.c                             |    8 
 drivers/net/wireless/ath/ath9k/main.c                                |   11 
 drivers/net/wireless/ath/ath9k/wmi.c                                 |    4 
 drivers/net/wireless/atmel/atmel_cs.c                                |   13 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                         |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c                        |    9 
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c                         |    5 
 drivers/net/wireless/intersil/orinoco/orinoco_cs.c                   |   13 
 drivers/net/wireless/intersil/orinoco/spectrum_cs.c                  |   13 
 drivers/net/wireless/marvell/mwifiex/scan.c                          |    6 
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c                      |    4 
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                      |    8 
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c                      |    8 
 drivers/net/wireless/microchip/wilc1000/hif.c                        |    8 
 drivers/net/wireless/ray_cs.c                                        |   16 
 drivers/net/wireless/rsi/rsi_91x_sdio.c                              |    9 
 drivers/net/wireless/wl3501_cs.c                                     |   16 
 drivers/nvme/host/auth.c                                             |   51 -
 drivers/nvme/host/core.c                                             |   26 
 drivers/nvme/host/nvme.h                                             |    8 
 drivers/nvmem/rmem.c                                                 |    1 
 drivers/nvmem/sunplus-ocotp.c                                        |    9 
 drivers/pci/controller/cadence/pcie-cadence-host.c                   |   27 
 drivers/pci/controller/dwc/pcie-qcom.c                               |  249 +++---
 drivers/pci/controller/pci-ftpci100.c                                |   14 
 drivers/pci/controller/vmd.c                                         |   11 
 drivers/pci/endpoint/functions/Kconfig                               |   18 
 drivers/pci/endpoint/functions/pci-epf-test.c                        |    2 
 drivers/pci/hotplug/pciehp_ctrl.c                                    |    8 
 drivers/pci/pcie/aspm.c                                              |   21 
 drivers/perf/arm-cmn.c                                               |    7 
 drivers/perf/hisilicon/hisi_pcie_pmu.c                               |    2 
 drivers/phy/tegra/xusb.c                                             |    4 
 drivers/pinctrl/bcm/pinctrl-bcm2835.c                                |    6 
 drivers/pinctrl/intel/pinctrl-cherryview.c                           |   15 
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c                            |    2 
 drivers/pinctrl/pinctrl-at91-pio4.c                                  |    2 
 drivers/pinctrl/pinctrl-microchip-sgpio.c                            |    3 
 drivers/pinctrl/sunplus/sppctl.c                                     |   23 
 drivers/platform/x86/dell/dell-rbtn.c                                |   13 
 drivers/platform/x86/lenovo-yogabook-wmi.c                           |   34 
 drivers/platform/x86/think-lmi.c                                     |   20 
 drivers/platform/x86/thinkpad_acpi.c                                 |    6 
 drivers/powercap/Kconfig                                             |    4 
 drivers/powercap/intel_rapl_msr.c                                    |    1 
 drivers/pwm/pwm-ab8500.c                                             |    2 
 drivers/pwm/pwm-imx-tpm.c                                            |    7 
 drivers/pwm/pwm-mtk-disp.c                                           |   13 
 drivers/pwm/sysfs.c                                                  |   17 
 drivers/regulator/core.c                                             |   30 
 drivers/regulator/tps65219-regulator.c                               |    6 
 drivers/rtc/rtc-st-lpc.c                                             |    2 
 drivers/s390/net/qeth_l3_sys.c                                       |    2 
 drivers/scsi/3w-xxxx.c                                               |    4 
 drivers/scsi/lpfc/lpfc_els.c                                         |   14 
 drivers/scsi/qedf/qedf_main.c                                        |    3 
 drivers/soc/amlogic/meson-secure-pwrc.c                              |    2 
 drivers/soc/fsl/qe/Kconfig                                           |    1 
 drivers/soc/mediatek/mtk-svs.c                                       |    4 
 drivers/soc/xilinx/xlnx_event_manager.c                              |    6 
 drivers/spi/spi-bcm-qspi.c                                           |   10 
 drivers/spi/spi-dw-core.c                                            |    5 
 drivers/spi/spi-geni-qcom.c                                          |    8 
 drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c            |    2 
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c        |    4 
 drivers/thermal/sun8i_thermal.c                                      |   55 -
 drivers/tty/serial/8250/8250_omap.c                                  |   25 
 drivers/tty/serial/fsl_lpuart.c                                      |    1 
 drivers/tty/serial/serial_core.c                                     |   10 
 drivers/usb/core/devio.c                                             |    2 
 drivers/usb/dwc2/platform.c                                          |   18 
 drivers/usb/dwc3/dwc3-meson-g12a.c                                   |    5 
 drivers/usb/dwc3/dwc3-qcom.c                                         |   17 
 drivers/usb/dwc3/gadget.c                                            |    4 
 drivers/usb/gadget/function/u_serial.c                               |   13 
 drivers/usb/phy/phy-tahvo.c                                          |    2 
 drivers/usb/serial/option.c                                          |    4 
 drivers/usb/typec/ucsi/psy.c                                         |   14 
 drivers/vfio/mdev/mdev_core.c                                        |   23 
 drivers/video/fbdev/omap/lcd_mipid.c                                 |    6 
 drivers/virt/coco/sev-guest/Kconfig                                  |    1 
 drivers/w1/slaves/w1_therm.c                                         |   31 
 drivers/w1/w1.c                                                      |    4 
 fs/afs/write.c                                                       |    8 
 fs/btrfs/block-group.c                                               |   36 
 fs/btrfs/ctree.c                                                     |   28 
 fs/btrfs/free-space-tree.c                                           |    3 
 fs/btrfs/locking.c                                                   |    5 
 fs/btrfs/qgroup.c                                                    |    2 
 fs/erofs/data.c                                                      |    9 
 fs/erofs/inode.c                                                     |    2 
 fs/erofs/internal.h                                                  |   16 
 fs/erofs/tagptr.h                                                    |  107 --
 fs/erofs/xattr.c                                                     |   20 
 fs/erofs/zdata.c                                                     |  373 ++++++----
 fs/erofs/zdata.h                                                     |  178 ----
 fs/erofs/zmap.c                                                      |   19 
 fs/ext4/namei.c                                                      |   17 
 fs/f2fs/compress.c                                                   |    7 
 fs/f2fs/data.c                                                       |    7 
 fs/f2fs/f2fs.h                                                       |    2 
 fs/f2fs/file.c                                                       |    8 
 fs/f2fs/gc.c                                                         |   25 
 fs/f2fs/namei.c                                                      |   16 
 fs/f2fs/node.c                                                       |    4 
 fs/fs_context.c                                                      |    3 
 fs/gfs2/file.c                                                       |    2 
 fs/inode.c                                                           |   42 +
 fs/internal.h                                                        |    2 
 fs/jffs2/build.c                                                     |    5 
 fs/jffs2/xattr.c                                                     |   13 
 fs/jffs2/xattr.h                                                     |    4 
 fs/kernfs/dir.c                                                      |    2 
 fs/lockd/svc.c                                                       |    1 
 fs/namei.c                                                           |   25 
 fs/nfs/nfs42xattr.c                                                  |   79 +-
 fs/nfs/nfs4proc.c                                                    |    1 
 fs/nfsd/nfs4xdr.c                                                    |    2 
 fs/notify/fanotify/fanotify_user.c                                   |   14 
 fs/ntfs3/xattr.c                                                     |    3 
 fs/ocfs2/cluster/tcp.c                                               |   23 
 fs/overlayfs/copy_up.c                                               |    2 
 fs/overlayfs/dir.c                                                   |    3 
 fs/overlayfs/export.c                                                |    3 
 fs/overlayfs/namei.c                                                 |    3 
 fs/overlayfs/overlayfs.h                                             |    6 
 fs/overlayfs/super.c                                                 |    2 
 fs/overlayfs/util.c                                                  |   24 
 fs/pstore/ram_core.c                                                 |    2 
 fs/ramfs/inode.c                                                     |    2 
 fs/smb/client/file.c                                                 |   25 
 fs/smb/client/smb2inode.c                                            |    9 
 fs/smb/client/smb2ops.c                                              |   19 
 fs/smb/client/transport.c                                            |   20 
 fs/smb/server/smb_common.c                                           |    2 
 fs/xfs/scrub/common.c                                                |   26 
 fs/xfs/scrub/common.h                                                |    2 
 fs/xfs/scrub/fscounters.c                                            |   13 
 fs/xfs/scrub/scrub.c                                                 |    2 
 fs/xfs/scrub/scrub.h                                                 |    1 
 fs/xfs/xfs_icache.c                                                  |   40 -
 fs/xfs/xfs_mount.h                                                   |    3 
 fs/xfs/xfs_super.c                                                   |    3 
 include/crypto/internal/kpp.h                                        |    6 
 include/drm/drm_bridge.h                                             |    8 
 include/drm/drm_fixed.h                                              |    6 
 include/linux/bitmap.h                                               |    8 
 include/linux/blk-mq.h                                               |    3 
 include/linux/blkdev.h                                               |    2 
 include/linux/blktrace_api.h                                         |    6 
 include/linux/bootmem_info.h                                         |    2 
 include/linux/bpf.h                                                  |    1 
 include/linux/can/length.h                                           |   14 
 include/linux/dsa/sja1105.h                                          |    4 
 include/linux/ieee80211.h                                            |   14 
 include/linux/ip.h                                                   |   21 
 include/linux/mmc/card.h                                             |    1 
 include/linux/netdevice.h                                            |    9 
 include/linux/nmi.h                                                  |    2 
 include/linux/pci.h                                                  |    1 
 include/linux/pipe_fs_i.h                                            |    4 
 include/linux/ramfs.h                                                |    1 
 include/linux/sh_intc.h                                              |    6 
 include/linux/watch_queue.h                                          |    3 
 include/net/bluetooth/mgmt.h                                         |   79 +-
 include/net/regulatory.h                                             |   13 
 include/net/route.h                                                  |    3 
 include/net/sock.h                                                   |    1 
 include/soc/mscc/ocelot.h                                            |   10 
 include/trace/events/erofs.h                                         |    4 
 include/trace/events/net.h                                           |    3 
 include/trace/events/timer.h                                         |    6 
 include/uapi/linux/affs_hardblocks.h                                 |   68 -
 include/uapi/linux/auto_dev-ioctl.h                                  |    2 
 include/uapi/linux/videodev2.h                                       |    2 
 io_uring/io_uring.c                                                  |   35 
 kernel/bpf/btf.c                                                     |    6 
 kernel/bpf/cgroup.c                                                  |   15 
 kernel/bpf/trampoline.c                                              |   32 
 kernel/kcsan/core.c                                                  |    2 
 kernel/kexec_core.c                                                  |    5 
 kernel/rcu/rcu.h                                                     |    6 
 kernel/rcu/rcuscale.c                                                |  204 ++---
 kernel/rcu/tasks.h                                                   |    7 
 kernel/rcu/tree.c                                                    |   23 
 kernel/time/posix-timers.c                                           |   43 -
 kernel/time/tick-sched.c                                             |    2 
 kernel/watch_queue.c                                                 |   12 
 kernel/watchdog_hld.c                                                |    6 
 lib/bitmap.c                                                         |    2 
 lib/ts_bm.c                                                          |    4 
 mm/damon/ops-common.c                                                |   16 
 mm/damon/ops-common.h                                                |    4 
 mm/damon/paddr.c                                                     |    4 
 mm/damon/vaddr.c                                                     |    4 
 mm/memory.c                                                          |    7 
 mm/mmap.c                                                            |    5 
 mm/shmem.c                                                           |    2 
 net/bluetooth/hci_conn.c                                             |   47 +
 net/bluetooth/hci_event.c                                            |   15 
 net/bluetooth/hci_sync.c                                             |   28 
 net/bluetooth/mgmt.c                                                 |   12 
 net/bridge/br_if.c                                                   |    5 
 net/core/filter.c                                                    |  126 ++-
 net/core/rtnetlink.c                                                 |  104 +-
 net/core/sock.c                                                      |   17 
 net/dsa/tag_sja1105.c                                                |   90 --
 net/ipv4/tcp_input.c                                                 |   12 
 net/mac80211/debugfs_netdev.c                                        |    2 
 net/mac80211/sta_info.c                                              |    2 
 net/mac80211/util.c                                                  |    4 
 net/netfilter/ipvs/Kconfig                                           |   27 
 net/netfilter/ipvs/ip_vs_conn.c                                      |    4 
 net/netfilter/nf_conntrack_helper.c                                  |    4 
 net/netfilter/nf_conntrack_proto_dccp.c                              |   52 +
 net/netfilter/nf_conntrack_sip.c                                     |    2 
 net/netfilter/nf_tables_api.c                                        |   13 
 net/netfilter/nft_byteorder.c                                        |   14 
 net/netlink/af_netlink.c                                             |    5 
 net/netlink/diag.c                                                   |    7 
 net/nfc/llcp.h                                                       |    1 
 net/nfc/llcp_commands.c                                              |   15 
 net/nfc/llcp_core.c                                                  |   49 +
 net/nfc/llcp_sock.c                                                  |   18 
 net/nfc/netlink.c                                                    |   20 
 net/nfc/nfc.h                                                        |    1 
 net/sched/act_ipt.c                                                  |   60 +
 net/sched/act_pedit.c                                                |    1 
 net/sctp/socket.c                                                    |   22 
 net/sunrpc/svcsock.c                                                 |   23 
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c                              |   12 
 net/wireless/core.c                                                  |   16 
 net/wireless/reg.c                                                   |   16 
 net/wireless/scan.c                                                  |  367 +++------
 net/xdp/xsk.c                                                        |    5 
 samples/bpf/tcp_basertt_kern.c                                       |    2 
 samples/bpf/xdp1_kern.c                                              |    2 
 samples/bpf/xdp2_kern.c                                              |    2 
 scripts/Makefile.modfinal                                            |    2 
 scripts/mod/modpost.c                                                |   86 --
 security/apparmor/policy_unpack.c                                    |    9 
 security/integrity/evm/evm_crypto.c                                  |    2 
 security/integrity/evm/evm_main.c                                    |    4 
 security/integrity/iint.c                                            |   15 
 security/integrity/ima/ima_modsig.c                                  |    3 
 security/integrity/ima/ima_policy.c                                  |    3 
 sound/core/jack.c                                                    |   15 
 sound/core/pcm_memory.c                                              |   44 -
 sound/pci/ac97/ac97_codec.c                                          |    4 
 sound/pci/hda/patch_realtek.c                                        |    7 
 sound/soc/amd/acp/acp-pdm.c                                          |    2 
 sound/soc/codecs/es8316.c                                            |   23 
 sound/soc/fsl/imx-audmix.c                                           |    9 
 sound/soc/intel/boards/sof_sdw.c                                     |    2 
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c                           |   13 
 tools/bpf/bpftool/feature.c                                          |   24 
 tools/lib/bpf/bpf_helpers.h                                          |   15 
 tools/lib/bpf/btf_dump.c                                             |   22 
 tools/perf/arch/x86/util/Build                                       |    1 
 tools/perf/arch/x86/util/env.c                                       |   19 
 tools/perf/arch/x86/util/env.h                                       |    7 
 tools/perf/arch/x86/util/evsel.c                                     |   16 
 tools/perf/arch/x86/util/mem-events.c                                |   19 
 tools/perf/builtin-bench.c                                           |    2 
 tools/perf/builtin-script.c                                          |   16 
 tools/perf/util/dwarf-aux.c                                          |    2 
 tools/testing/selftests/bpf/Makefile                                 |    3 
 tools/testing/selftests/bpf/prog_tests/check_mtu.c                   |    2 
 tools/testing/selftests/cgroup/test_memcontrol.c                     |    4 
 tools/testing/selftests/net/rtnetlink.sh                             |    1 
 tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot     |    2 
 tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot           |    2 
 tools/testing/selftests/vDSO/vdso_test_clock_getres.c                |    4 
 tools/testing/selftests/wireguard/netns.sh                           |   30 
 607 files changed, 5590 insertions(+), 3833 deletions(-)

Abhijeet Rastogi (1):
      ipvs: increase ip_vs_conn_tab_bits range for 64BIT

Aditya Gupta (1):
      powerpc: update ppc_save_regs to save current r1 in pt_regs

Alan Maguire (1):
      bpftool: JIT limited misreported as negative value on aarch64

Alexander Mikhalitsyn (1):
      sctp: add bpf_bypass_getsockopt proto callback

Alexander Stein (2):
      drm/bridge: ti-sn65dsi83: Fix enable error path
      drm/bridge: tc358767: Switch to devm MIPI-DSI helpers

Alexander Wetzel (1):
      wifi: ath10k: Serialize wake_tx_queue ops

Alexey Gladkov (1):
      selftests/bpf: Do not use sign-file as testcase

Alexey Romanov (1):
      drivers: meson: secure-pwrc: always enable DMA domain

Allen-KH Cheng (1):
      arm64: dts: mediatek: Add cpufreq nodes for MT8192

Alvin Šipraga (1):
      extcon: usbc-tusb320: Unregister typec port on driver removal

Amelie Delaunay (2):
      mfd: stmfx: Fix error path in stmfx_chip_init
      mfd: stmfx: Nullify stmfx->vdd in case of error

Amir Goldstein (2):
      ovl: update of dentry revalidate flags after copy up
      fanotify: disallow mount/sb marks on kernel internal pseudo fs

Amisha Patel (1):
      wifi: wilc1000: fix for absent RSN capabilities WFA testcase

Andres Freund (1):
      io_uring: Use io_schedule* in cqring wait

Andrii Nakryiko (1):
      libbpf: fix offsetof() and container_of() to work with CO-RE

Andy Chi (1):
      ALSA: hda/realtek: Enable mute/micmute LEDs and limit mic boost on EliteBook

Andy Shevchenko (4):
      pinctrl: cherryview: Return correct value if pin in push-pull mode
      extcon: Fix kernel doc of property fields to avoid warnings
      extcon: Fix kernel doc of property capability fields to avoid warnings
      device property: Clarify description of returned value in some functions

Aneesh Kumar K.V (2):
      powerpc/book3s64/mm: Fix DirectMap stats in /proc/meminfo
      powerpc/mm/dax: Fix the condition when checking if altmap vmemap can cross-boundary

Anjaneyulu (1):
      wifi: iwlwifi: pcie: fix NULL pointer dereference in iwl_pcie_irq_rx_msix_handler()

Antonio Borneo (1):
      irqchip/stm32-exti: Fix warning on initialized field overwritten

Ard Biesheuvel (1):
      efi/libstub: Disable PCI DMA before grabbing the EFI memory map

Arnaldo Carvalho de Melo (2):
      perf bench: Add missing setlocale() call to allow usage of %'d style formatting
      perf script: Fix allocation of evsel->priv related to per-event dump files

Arnd Bergmann (13):
      fs: pipe: reveal missing function protoypes
      virt: sevguest: Add CONFIG_CRYPTO dependency
      ARM: 9303/1: kprobes: avoid missing-declaration warnings
      memstick r592: make memstick_debug_get_tpc_name() static
      ARM: ep93xx: fix missing-prototype warnings
      ARM: omap2: fix missing tick_broadcast() prototype
      RDMA/irdma: avoid fortify-string warning in irdma_clr_wqes
      crypto: marvell/cesa - Fix type mismatch warning
      ksmbd: avoid field overflow warning
      staging: vchiq_arm: mark vchiq_platform_init() static
      usb: hide unused usbfs_notify_suspend/resume functions
      autofs: use flexible array in ioctl structure
      ARM: orion5x: fix d2net gpio initialization

Artur Rojek (2):
      sh: dma: Fix DMA channel offset calculation
      sh: hd64461: Handle virq offset for offchip IRQ base and HD64461 IRQ

Aurabindo Pillai (1):
      drm/amd/display: Fix artifacting on eDP panels when engaging freesync video mode

Bard Liao (1):
      ASoC: Intel: sof_sdw: remove SOF_SDW_TGL_HDMI for MeteorLake devices

Bart Van Assche (1):
      block: Fix the type of the second bdev_op_is_zoned_write() argument

Bartosz Golaszewski (1):
      net: stmmac: fix double serdes powerdown

Benjamin Berg (2):
      wifi: cfg80211: rewrite merging of inherited elements
      wifi: cfg80211: drop incorrect nontransmitted BSS update code

Bharath SM (1):
      SMB3: Do not send lease break acknowledgment if all file handles have been closed

Bhupesh Sharma (1):
      usb: misc: eud: Fix eud sysfs path (use 'qcom_eud')

Biju Das (1):
      clk: renesas: rzg2l: Fix CPG_SIPLL5_CLK1 register write

Bjorn Andersson (1):
      drm/msm/dp: Free resources after unregistering them

Bob Pearson (3):
      RDMA/rxe: Add ibdev_dbg macros for rxe
      RDMA/rxe: Replace pr_xxx by rxe_dbg_xxx in rxe_mw.c
      RDMA/rxe: Fix access checks in rxe_check_bind_mw

Bob Peterson (1):
      gfs2: Fix duplicate should_fault_in_pages() call

Brendan Cunningham (1):
      IB/hfi1: Fix wrong mmu_node used for user SDMA packet after invalidate

Caleb Connolly (1):
      Input: pm8941-powerkey - fix debounce on gen2+ PMICs

Cambda Zhu (1):
      ipvlan: Fix return value of ipvlan_queue_xmit()

Chaitanya Kulkarni (4):
      nvme-core: fix memory leak in dhchap_secret_store
      nvme-core: fix memory leak in dhchap_ctrl_secret
      nvme-core: add missing fault-injection cleanup
      nvme-core: fix dev_pm_qos memleak

Chao Yu (4):
      f2fs: fix potential deadlock due to unpaired node_write lock use
      f2fs: fix to avoid NULL pointer dereference f2fs_write_end_io()
      f2fs: check return value of freeze_super()
      f2fs: fix error path handling in truncate_dnode()

Chen-Yu Tsai (1):
      soc: mediatek: SVS: Fix MT8192 GPU node name

Chengchang Tang (1):
      RDMA/hns: Fix hns_roce_table_get return value

Chengfeng Ye (1):
      sctp: fix potential deadlock on &net->sctp.addr_wq_lock

Chevron Li (1):
      mmc: sdhci: fix DMA configure compatibility issue when 64bit DMA mode is used.

Chia-I Wu (1):
      amdgpu: validate offset_in_bo of drm_amdgpu_gem_va

Christian Borntraeger (1):
      KVM: s390/diag: fix racy access of physical cpu number in diag 9c handler

Christian König (1):
      drm/amdgpu: fix number of fence calculations

Christian Lamparter (1):
      ARM: dts: BCM5301X: fix duplex-full => full-duplex

Christian Marangi (1):
      leds: trigger: netdev: Recheck NETDEV_LED_MODE_LINKUP on dev rename

Christophe JAILLET (18):
      thermal/drivers/sun8i: Fix some error handling paths in sun8i_ths_probe()
      wifi: mwifiex: Fix the size of a memory allocation in mwifiex_ret_802_11_scan()
      wifi: orinoco: Fix an error handling path in spectrum_cs_probe()
      wifi: orinoco: Fix an error handling path in orinoco_cs_probe()
      wifi: atmel: Fix an error handling path in atmel_probe()
      wifi: wl3501_cs: Fix an error handling path in wl3501_probe()
      wifi: ray_cs: Fix an error handling path in ray_probe()
      fbdev: omapfb: lcd_mipid: Fix an error handling path in mipid_spi_probe()
      drm/amd/display: Fix a test CalculatePrefetchSchedule()
      drm/amd/display: Fix a test dml32_rq_dlg_get_rq_reg()
      pinctrl: bcm2835: Handle gpiochip_add_pin_range() errors
      usb: dwc2: Fix some error handling paths
      usb: dwc3: qcom: Release the correct resources in dwc3_qcom_remove()
      usb: dwc3: qcom: Fix an error handling path in dwc3_qcom_probe()
      usb: dwc3-meson-g12a: Fix an error handling path in dwc3_meson_g12a_probe()
      mfd: wcd934x: Fix an error handling path in wcd934x_slim_probe()
      mfd: stmpe: Only disable the regulators if they are enabled
      rtc: st-lpc: Release some resources in st_rtc_probe() in case of error

Christophe Leroy (3):
      kcsan: Don't expect 64 bits atomic builtins from 32 bits architectures
      powerpc/interrupt: Don't read MSR from interrupt_exit_kernel_prepare()
      powerpc/signal32: Force inlining of __unsafe_save_user_regs() and save_tm_user_regs_unsafe()

Chuck Lever (1):
      svcrdma: Prevent page release when nothing was received

Clark Wang (1):
      i3c: master: svc: fix cpu schedule in spin lock

Claudiu Beznea (12):
      clk: vc5: check memory returned by kasprintf()
      clk: cdce925: check return value of kasprintf()
      clk: si5341: return error if one synth clock registration fails
      clk: si5341: check return value of {devm_}kasprintf()
      clk: si5341: free unused memory on probe failure
      clk: keystone: sci-clk: check return value of kasprintf()
      clk: ti: clkctrl: check return value of kasprintf()
      ASoC: imx-audmix: check return value of devm_kasprintf()
      pinctrl: microchip-sgpio: check return value of devm_kasprintf()
      pinctrl: at91-pio4: check return value of devm_kasprintf()
      misc: fastrpc: check return value of devm_kasprintf()
      phy: tegra: xusb: check return value of devm_kzalloc()

Colin Ian King (2):
      kselftest: vDSO: Fix accumulation of uninitialized ret when CLOCK_REALTIME is undefined
      powerpc/powernv/sriov: perform null check on iov before dereferencing iov

Cristian Ciocaltea (2):
      ASoC: es8316: Increment max value for ALC Capture Target Volume control
      ASoC: es8316: Do not set rate constraints for unsupported MCLKs

Dai Ngo (1):
      NFSD: add encoding of op_recall flag for write delegation

Dan Carpenter (8):
      driver: soc: xilinx: use _safe loop iterator to avoid a use after free
      clk: imx: scu: use _safe list iterator to avoid a use after free
      clk: bcm: rpi: Fix off by one in raspberrypi_discover_clocks()
      clk: clocking-wizard: Fix Oops in clk_wzrd_register_divider()
      modpost: fix off by one in is_executable_section()
      w1: fix loop in w1_fini()
      media: atomisp: gmin_platform: fix out_len in gmin_get_config_dsm_var()
      pwm: ab8500: Fix error code in probe()

Dan Williams (2):
      dax: Fix dax_mapping_release() use after free
      dax: Introduce alloc_dev_dax_id()

Daniel Golle (1):
      cpufreq: mediatek: correct voltages for MT7622 and MT7623

Daniel Scally (1):
      media: i2c: Correct format propagation for st-mipid02

Daniil Dulov (2):
      drm/amdkfd: Fix potential deallocation of previously deallocated memory.
      media: usb: Check az6007_read() return value

Danila Chernetsov (1):
      apparmor: fix missing error check for rhashtable_insert_fast

Dario Binacchi (1):
      drm/panel: simple: fix active size for Ampire AM-480272H3TMQW-T01H

Darrick J. Wong (4):
      xfs: explicitly specify cpu when forcing inodegc delayed work to run immediately
      xfs: check that per-cpu inodegc workers actually run on that cpu
      xfs: disable reaping in fscounters scrub
      xfs: fix xfs_inodegc_stop racing with mod_delayed_work

Dave Stevenson (1):
      drm/bridge: Introduce pre_enable_prev_first to alter bridge init order

David Howells (2):
      ocfs2: Fix use of slab data with sendpage
      afs: Fix accidental truncation when storing data

David Sterba (1):
      btrfs: add block-group tree to lockdep classes

Davide Tronchin (1):
      USB: serial: option: add LARA-R6 01B PIDs

Demi Marie Obenour (2):
      block: increment diskseq on all media change events
      dm ioctl: Avoid double-fetch of version

Ding Hui (2):
      PCI/ASPM: Disable ASPM on MFD function removal to avoid use-after-free
      SUNRPC: Fix UAF in svc_tcp_listen_data_ready()

Dmitry Antipov (1):
      wifi: ath9k: convert msecs to jiffies where needed

Dmitry Baryshkov (10):
      drm/panel: sharp-ls043t1le01: adjust mode settings
      drm/msm/dsi: don't allow enabling 14nm VCO with unprogrammed rate
      ARM: dts: qcom: apq8074-dragonboard: Set DMA as remotely controlled
      drm/msm/a5xx: really check for A510 in a5xx_gpu_init
      drm/msm/dpu: do not enable color-management if DSPPs are not available
      drm/msm/dpu: correct MERGE_3D length
      clk: qcom: mmcc-msm8974: remove oxili_ocmemgx_clk
      clk: qcom: mmcc-msm8974: use clk_rcg2_shared_ops for mdp_clk_src clock
      clk: qcom: mmcc-msm8974: fix MDSS_GDSC power flags
      spi: spi-geni-qcom: enable SPI_CONTROLLER_MUST_TX for GPI DMA mode

Douglas Anderson (4):
      watchdog/perf: define dummy watchdog_update_hrtimer_threshold() on correct config
      watchdog/perf: more properly prevent false positives with turbo modes
      mmc: mediatek: Avoid ugly error message when SDIO wakeup IRQ isn't used
      arm64: dts: mediatek: mt8183: Add mediatek,broken-save-restore-fw to kukui

Duoming Zhou (1):
      media: usb: siano: Fix warning due to null work_func_t function pointer

EJ Hsu (1):
      phy: tegra: xusb: Clear the driver reference in usb-phy dev

Edward Cree (1):
      sfc: fix crash when reading stats while NIC is resetting

Edwin Peer (1):
      rtnetlink: extend RTEXT_FILTER_SKIP_STATS to IFLA_VF_INFO

Eric Dumazet (5):
      netlink: fix potential deadlock in netlink_set_err()
      netlink: do not hard code device address lenth in fdb dumps
      bonding: do not assume skb mac_header is set
      net: fix net_dev_start_xmit trace event vs skb_transport_offset()
      tcp: annotate data races in __tcp_oow_rate_limited()

Eric Farman (1):
      vfio/mdev: Move the compat_class initialization to module init

Fabian Frederick (1):
      jffs2: reduce stack usage in jffs2_build_xattr_subsystem()

Fabrizio Lamarque (2):
      iio: adc: ad7192: Fix null ad7192_state pointer access
      iio: adc: ad7192: Fix internal/external clock selection

Fancy Fang (1):
      pwm: imx-tpm: force 'real_period' to be zero in suspend

Fedor Pchelkin (2):
      wifi: ath9k: avoid referencing uninit memory in ath9k_wmi_ctrl_rx
      wifi: ath9k: don't allow to overwrite ENDPOINT0 attributes

Fei Shao (1):
      clk: Fix memory leak in devm_clk_notifier_register()

Feng Mingxi (1):
      clocksource/drivers/cadence-ttc: Fix memory leak in ttc_timer_probe

Filipe Manana (5):
      btrfs: fix race when deleting free space root from the dirty cow roots list
      btrfs: do not BUG_ON() on tree mod log failure at balance_level()
      btrfs: fix race when deleting quota root from the dirty cow roots list
      btrfs: fix extent buffer leak after tree mod log failure at split_node()
      btrfs: do not BUG_ON() on tree mod log failure at __btrfs_cow_block()

Florent Revest (1):
      netfilter: conntrack: Avoid nf_ct_helper_hash uses after free

Florian Westphal (3):
      netfilter: conntrack: dccp: copy entire header to stack buffer, not just basic one
      net/sched: act_ipt: add sanity checks on table name and hook locations
      net/sched: act_ipt: add sanity checks on skb before calling target

Francesco Dolcini (9):
      drm/bridge: tc358768: always enable HS video mode
      drm/bridge: tc358768: fix PLL parameters computation
      drm/bridge: tc358768: fix PLL target frequency
      drm/bridge: tc358768: fix TCLK_ZEROCNT computation
      drm/bridge: tc358768: Add atomic_get_input_bus_fmts() implementation
      drm/bridge: tc358768: fix TCLK_TRAILCNT computation
      drm/bridge: tc358768: fix THS_ZEROCNT computation
      drm/bridge: tc358768: fix TXTAGOCNT computation
      drm/bridge: tc358768: fix THS_TRAILCNT computation

Frieder Schrempf (1):
      drm/bridge: ti-sn65dsi83: Fix enable/disable flow to meet spec

Gao Xiang (7):
      erofs: clean up cached I/O strategies
      erofs: avoid tagged pointers to mark sync decompression
      erofs: remove tagged pointer helpers
      erofs: move zdata.h into zdata.c
      erofs: kill hooked chains to avoid loops on deduplicated compressed images
      erofs: simplify iloc()
      erofs: fix compact 4B support for 16k block size

Geert Uytterhoeven (7):
      regulator: core: Fix more error checking for debugfs_create_dir()
      regulator: core: Streamline debugfs operations
      ARM: dts: iwg20d-q7-common: Fix backlight pwm specifier
      HID: uclogic: Modular KUnit tests should not depend on KUNIT=y
      sh: mach-r2d: Handle virq offset in cascaded IRL demux
      sh: mach-highlander: Handle virq offset in cascaded IRL demux
      sh: mach-dreamcast: Handle virq offset in cascaded IRQ demux

Gilad Sever (3):
      bpf: Factor out socket lookup functions for the TC hookpoint.
      bpf: Call __bpf_sk_lookup()/__bpf_skc_lookup() directly via TC hookpoint
      bpf: Fix bpf socket lookup from tc/xdp to respect socket VRF bindings

Greg Kroah-Hartman (2):
      Revert "usb: common: usb-conn-gpio: Set last role to unknown before initial detection"
      Linux 6.1.39

Guenter Roeck (1):
      hwmon: (pmbus/adm1275) Fix problems with temperature monitoring on ADM1272

Guillaume Nault (1):
      pptp: Fix fib lookup calls.

Haifeng Xu (1):
      selftests: cgroup: fix unexpected failure on test_memcg_low

Hans de Goede (3):
      platform/x86: lenovo-yogabook: Fix work race on remove()
      platform/x86: lenovo-yogabook: Reprobe devices on remove()
      platform/x86: lenovo-yogabook: Set default keyboard backligh brightness on probe()

Hao Luo (1):
      clk: imx: clk-imx8mn: fix memory leak in imx8mn_clocks_probe

Hareshx Sankar Raj (2):
      crypto: qat - unmap buffer before free for DH
      crypto: qat - unmap buffers before free for RSA

Hariprasad Kelam (3):
      octeontx2-af: Fix mapping for NIX block from CGX connection
      octeontx2-af: Add validation before accessing cgx and lmac
      octeontx-af: fix hardware timestamp configuration

Heinz Mauelshagen (3):
      dm: fix undue/missing spaces
      dm: avoid split of quoted strings where possible
      dm ioctl: have constant on the right side of the test

Herbert Xu (3):
      hwrng: virtio - Fix race on data_avail and actual data
      crypto: kpp - Add helper to set reqsize
      crypto: qat - Use helper to set reqsize

Hersen Wu (1):
      Revert "drm/amd/display: edp do not add non-edid timings"

Ian Rogers (1):
      perf tool x86: Fix perf_env memory leak

Ilan Peer (3):
      wifi: mac80211: Fix permissions for valid_links debugfs entry
      wifi: cfg80211/mac80211: Fix ML element common size calculation
      wifi: ieee80211: Fix the common size calculation for reconfiguration ML

Ilia.Gavrilov (1):
      netfilter: nf_conntrack_sip: fix the ct_sip_parse_numerical_param() return value.

Ilya Maximets (1):
      xsk: Honor SO_BINDTODEVICE on bind

Imre Deak (3):
      drm/i915: Fix TypeC mode initialization during system resume
      drm/i915/tc: Fix TC port link ref init for DP MST during HW readout
      drm/i915/tc: Fix system resume MST mode restore for DP-alt sinks

James Clark (1):
      coresight: Fix loss of connection info when a module is unloaded

Jan Kara (5):
      ext4: Remove ext4 locking of moved directory
      Revert "f2fs: fix potential corruption when moving a directory"
      fs: Establish locking order for unrelated directories
      fs: Lock moved directories
      fs: no need to check source

Jason A. Donenfeld (2):
      wireguard: queueing: use saner cpu selection wrapping
      wireguard: netlink: send staged packets when setting initial private key

Jean-Philippe Brucker (2):
      iommu/virtio: Detach domain on endpoint release
      iommu/virtio: Return size mapped for a detached domain

Jeff Layton (1):
      drm: use mgr->dev in drm_dbg_kms in drm_dp_add_payload_part2

Jens Axboe (1):
      io_uring: wait interruptibly for request completions on exit

Jeremy Sowden (1):
      lib/ts_bm: reset initial match offset for every block of text

Jesper Dangaard Brouer (3):
      igc: Enable and fix RX hash usage by netstack
      samples/bpf: xdp1 and xdp2 reduce XDPBUFSIZE to 60
      selftests/bpf: Fix check_mtu using wrong variable type

Jessica Zhang (2):
      drm/msm/dpu: Fix slice_last_group_size calculation
      drm/msm/dsi: Remove incorrect references to slice_count

Jianmin Lv (1):
      irqchip/loongson-pch-pic: Fix initialization of HT vector register

Jiasheng Jiang (4):
      pstore/ram: Add check for kstrdup
      wifi: ath11k: Add missing check for ioremap
      pinctrl: npcm7xx: Add missing check for ioremap
      mfd: intel-lpss: Add missing check for platform_get_resource

Jimmy Assarsson (2):
      can: kvaser_pciefd: Add function to set skb hwtstamps
      can: kvaser_pciefd: Set hardware timestamp on transmitted packets

Jinhong Zhu (1):
      scsi: qedf: Fix NULL dereference in error handling

Johan Hovold (1):
      Bluetooth: fix invalid-bdaddr quirk for non-persistent setup

Johannes Berg (5):
      wifi: mac80211: recalc min chandef for new STA links
      wifi: iwlwifi: pull from TXQs with softirqs disabled
      wifi: cfg80211: fix regulatory disconnect with OCB/NAN
      wifi: iwlwifi: mvm: indicate HW decrypt for beacon protection
      wifi: cfg80211: fix regulatory disconnect for non-MLO

John Ogness (4):
      serial: core: lock port for stop_rx() in uart_suspend_port()
      serial: 8250: lock port for stop_rx() in omap8250_irq()
      serial: core: lock port for start_rx() in uart_resume_port()
      serial: 8250: lock port for UART_IER access in omap8250_irq()

John Paul Adrian Glaubitz (2):
      irqchip/jcore-aic: Fix missing allocation of IRQ descriptors
      sh: j2: Use ioremap() to translate device tree address into kernel memory

Jonas Gorski (1):
      spi: bcm-qspi: return error if neither hif_mspi nor mspi is available

Jouni Högander (1):
      drm/i915/psr: Use hw.adjusted mode when calculating io/fast wake times

Joy Chakraborty (1):
      spi: dw: Round of n_bytes to power of 2

Juergen Gross (1):
      x86/mm: Fix __swp_entry_to_pte() for Xen PV guests

Junhao He (1):
      drivers/perf: hisi: Don't migrate perf to the CPU going to teardown

Junyan Ye (1):
      PCI: ftpci100: Release the clock resources

Justin Tee (1):
      scsi: lpfc: Revise NPIV ELS unsol rcv cmpl logic to drop ndlp based on nlp_state

Kai Ma (1):
      clk: imx: clk-imxrt1050: fix memory leak in imxrt1050_clocks_probe

Kalesh AP (4):
      RDMA/bnxt_re: Fix to remove unnecessary return labels
      RDMA/bnxt_re: Use unique names while registering interrupts
      RDMA/bnxt_re: Remove a redundant check inside bnxt_re_update_gid
      RDMA/bnxt_re: Fix to remove an unnecessary log

Karol Kolacinski (1):
      ice: handle extts in the miscellaneous interrupt thread

Kashyap Desai (2):
      RDMA/bnxt_re: wraparound mbox producer index
      RDMA/bnxt_re: Avoid calling wake_up threads from spin_lock context

Keerthy (1):
      arm64: dts: ti: k3-j7200: Fix physical address of pin

Kees Cook (1):
      um: Use HOST_DIR for mrproper

Kirill A. Shutemov (2):
      x86/mm: Allow guest.enc_status_change_prepare() to fail
      x86/tdx: Fix race between set_memory_encrypted() and load_unaligned_zeropad()

Konrad Dybcio (6):
      drm/msm/dpu: Set DPU_DATA_HCTL_EN for in INTF_SC7180_MASK
      arm64: dts: qcom: sdm845: Flush RSC sleep & wake votes
      dt-bindings: power: reset: qcom-pon: Only allow reboot-mode pre-pmk8350
      clk: qcom: gcc-qcm2290: Mark RCGs shared where applicable
      clk: qcom: dispcc-qcm2290: Fix BI_TCXO_AO handling
      clk: qcom: dispcc-qcm2290: Fix GPLL0_OUT_DIV handling

Krishna Kurapati (1):
      usb: dwc3: gadget: Propagate core init errors to UDC during pullup

Krzysztof Kozlowski (15):
      nfc: llcp: fix possible use of uninitialized variable in nfc_llcp_send_connect()
      ARM: dts: qcom: msm8974: do not use underscore in node name (again)
      arm64: dts: qcom: msm8916: correct camss unit address
      arm64: dts: qcom: msm8916: correct MMC unit address
      arm64: dts: qcom: msm8994: correct SPMI unit address
      arm64: dts: qcom: msm8996: correct camss unit address
      arm64: dts: qcom: sdm630: correct camss unit address
      arm64: dts: qcom: sdm845: correct camss unit address
      arm64: dts: qcom: sm8350: Add GPI DMA compatible fallback
      arm64: dts: qcom: sm8350: correct DMA controller unit address
      arm64: dts: qcom: sdm845-polaris: add missing touchscreen child node reg
      arm64: dts: qcom: apq8096: fix fixed regulator name property
      memory: brcmstb_dpfe: fix testing array offset after use
      regulator: tps65219: Fix matching interrupts for their regulators
      ARM: dts: qcom: ipq4019: fix broken NAND controller properties override

Kuniyuki Iwashima (2):
      gtp: Fix use-after-free in __gtp_encap_destroy().
      netlink: Add __sock_i_ino() for __netlink_diag_dump().

Kuogee Hsieh (1):
      drm/msm/dpu: set DSC flush bit correctly at MDP CTL flush register

Lars-Peter Clausen (1):
      clk: vc5: Use `clamp()` to restrict PLL range

Laurentiu Tudor (1):
      bus: fsl-mc: don't assume child devices are all fsl-mc devices

Li Nan (7):
      blk-iocost: use spin_lock_irqsave in adjust_inuse_and_calc_cost
      md/raid10: check slab-out-of-bounds in md_bitmap_get_counter
      md/raid10: fix overflow of md/safe_mode_delay
      md/raid10: fix wrong setting of max_corr_read_errors
      md/raid10: fix null-ptr-deref of mreplace in raid10_sync_request
      md/raid10: fix io loss while replacement replace rdev
      md/raid10: fix the condition to call bio_end_io_acct()

Li Yang (1):
      usb: phy: phy-tahvo: fix memory leak in tahvo_usb_probe()

Liam R. Howlett (1):
      mm/mmap: Fix extra maple tree write

Lin Ma (2):
      net: nfc: Fix use-after-free caused by nfc_llcp_find_local
      net/sched: act_pedit: Add size check for TCA_PEDIT_PARMS_EX

Liu Peibao (1):
      irqchip/loongson-pch-pic: Fix potential incorrect hwirq assignment

Liu Shixin (1):
      bootmem: remove the vmemmap pages from kmemleak in free_bootmem_page

Luben Tuikov (1):
      drm/amdgpu: Fix usage of UMC fill record in RAS

Luc Ma (1):
      drm/vram-helper: fix function names in vram helper doc

Luca Weiss (2):
      Input: drv260x - sleep between polling GO bit
      arm64: dts: qcom: pm7250b: add missing spmi-vadc include

Luiz Augusto von Dentz (2):
      Bluetooth: MGMT: Use BIT macro when defining bitfields
      Bluetooth: MGMT: Fix marking SCAN_RSP as not connectable

Lukas Bulwahn (1):
      mtd: parsers: refer to ARCH_BCMBCA instead of ARCH_BCM4908

Manivannan Sadhasivam (5):
      PCI: qcom: Remove PCIE20_ prefix from register definitions
      PCI: qcom: Sort and group registers and bitfield definitions
      PCI: qcom: Use lower case for hex
      PCI: qcom: Use DWC helpers for modifying the read-only DBI registers
      PCI: qcom: Disable write access to read only registers for IP v2.9.0

Mantas Pucka (1):
      clk: qcom: gcc-ipq6018: Use floor ops for sdcc clocks

Marek Vasut (12):
      wifi: rsi: Do not configure WoWlan in shutdown hook if not enabled
      wifi: rsi: Do not set MMC_PM_KEEP_POWER in shutdown
      mmc: Add MMC_QUIRK_BROKEN_SD_CACHE for Kingston Canvas Go Plus from 11/2019
      clk: vc5: Fix .driver_data content in i2c_device_id
      clk: vc7: Fix .driver_data content in i2c_device_id
      clk: rs9: Fix .driver_data content in i2c_device_id
      Input: adxl34x - do not hardcode interrupt trigger type
      ARM: dts: stm32: Move ethernet MAC EEPROM from SoM to carrier boards
      ARM: dts: stm32: Shorten the AV96 HDMI sound card name
      ARM: dts: stm32: Fix audio routing on STM32MP15xx DHCOM PDK2
      media: videodev2.h: Fix struct v4l2_input tuner index comment
      pwm: sysfs: Do not apply state to already disabled PWMs

Marijn Suijten (3):
      arm64: dts: qcom: sm8250-edo: Panel framebuffer is 2.5k instead of 4k
      drm/msm/dsi: Use DSC slice(s) packet size to compute word count
      drm/msm/dsi: Flip greater-than check for slice_count and slice_per_intf

Mario Limonciello (2):
      drm/amd: Don't try to enable secure display TA multiple times
      usb: typec: ucsi: Mark dGPUs as DEVICE scope

Mark Pearson (4):
      platform/x86: think-lmi: mutex protection around multiple WMI calls
      platform/x86: think-lmi: Correct System password interface
      platform/x86: think-lmi: Correct NVME password handling
      platform/x86: thinkpad_acpi: Fix lkp-tests warnings for platform profiles

Mark Rutland (1):
      locking/atomic: arm: fix sync ops

Markus Elfring (1):
      drm/bridge: it6505: Move a variable assignment behind a null pointer check in receive_timing_debugfs_show()

Martin Blumenstingl (1):
      ARM: dts: meson8: correct uart_B and uart_C clock references

Martin KaFai Lau (1):
      libbpf: btf_dump_type_data_check_overflow needs to consider BTF_MEMBER_BITFIELD_SIZE

Martin Kaiser (1):
      hwrng: st - keep clock enabled while hwrng is registered

Martin Kepplinger (1):
      media: hi846: fix usage of pm_runtime_get_if_in_use()

Masahiro Yamada (4):
      modpost: remove broken calculation of exception_table_entry size
      modpost: fix section mismatch message for R_ARM_ABS32
      modpost: fix section mismatch message for R_ARM_{PC24,CALL,JUMP24}
      ARC: define ASM_NL and __ALIGN(_STR) outside #ifdef __ASSEMBLY__ guard

Matt Corallo (1):
      btrfs: add handling for RAID1C23/DUP to btrfs_reduce_alloc_profile

Matti Vaittinen (1):
      drivers: fwnode: fix fwnode_irq_get[_byname]()

Maxim Kochetkov (1):
      net: axienet: Move reset before 64-bit DMA detection

Maxime Ripard (1):
      clk: Export clk_hw_forward_rate_request()

Maíra Canal (3):
      drm/vkms: isolate pixel conversion functionality
      drm: Add fixed-point helper to get rounded integer values
      drm/vkms: Fix RGB565 pixel conversion

Miaoqian Lin (1):
      device property: Fix documentation for fwnode_get_next_parent()

Michael Schmitz (4):
      block: fix signed int overflow in Amiga partition support
      block: add overflow checks for Amiga partition support
      block: change all __u32 annotations to __be32 in affs_hardblocks.h
      block/partition: fix signedness issue for Amiga partitions

Michael Walle (2):
      ARM: dts: lan966x: kontron-d10: fix board reset
      ARM: dts: lan966x: kontron-d10: fix SPI CS

Michal Wilczynski (1):
      platform/x86/dell/dell-rbtn: Fix resources leaking on error path

Ming Qian (3):
      media: amphion: drop repeated codec data for vc1l format
      media: amphion: drop repeated codec data for vc1g format
      media: amphion: initiate a drain of the capture queue in dynamic resolution change

Mingzhe Zou (1):
      bcache: fixup btree_cache_wait list damage

Muchun Song (1):
      kernfs: fix missing kernfs_idr_lock to remove an ID from the IDR

Namhyung Kim (1):
      perf dwarf-aux: Fix off-by-one in die_get_varname()

Naohiro Aota (3):
      btrfs: delete unused BGs while reclaiming BGs
      btrfs: bail out reclaim process if filesystem is read-only
      btrfs: reinsert BGs failed to reclaim

NeilBrown (1):
      lockd: drop inappropriate svc_get() from locked_get()

Nicholas Kazlauskas (1):
      drm/amd/display: Explicitly specify update type per plane info change

Nicholas Piggin (2):
      powerpc/64s: Fix VAS mm use after free
      powerpc: simplify ppc_save_regs

Nick Child (1):
      ibmvnic: Do not reset dql stats on NON_FATAL err

Nico Boehr (1):
      KVM: s390: fix KVM_S390_GET_CMMA_BITS for GFNs in memslot holes

Nicolas Cavallari (1):
      wifi: mac80211: Remove "Missing iftype sband data/EHT cap" spam

Nikita Zhandarovich (4):
      PM: domains: fix integer overflow issues in genpd_parse_state()
      radeon: avoid double free in ci_dpm_init()
      hwmon: (f71882fg) prevent possible division by zero
      drm/radeon: fix possible division-by-zero errors

Nirmal Patel (1):
      PCI: vmd: Reset VMD config register between soft reboots

Nishanth Menon (1):
      mailbox: ti-msgmgr: Fill non-message tx data fields with 0x0

Nícolas F. R. A. Prado (2):
      drm/bridge: anx7625: Prevent endless probe loop
      arm64: dts: mediatek: mt8192: Fix CPUs capacity-dmips-mhz

Olga Kornievskaia (1):
      NFSv4.1: freeze the session table upon receiving NFS4ERR_BADSESSION

Olivier Moysan (1):
      ARM: dts: stm32: fix i2s endpoint format property for stm32mp15xx-dkx

Pablo Neira Ayuso (1):
      netfilter: nf_tables: unbind non-anonymous set if rule construction fails

Pali Rohár (1):
      powerpc: dts: turris1x.dts: Fix PCIe MEM size for pci2 node

Paul E. McKenney (4):
      rcu: Make rcu_cpu_starting() rely on interrupts being disabled
      rcu-tasks: Stop rcu_tasks_invoke_cbs() from using never-onlined CPUs
      rcutorture: Correct name of use_softirq module parameter
      rcuscale: Move shutdown from wait_event() to wait_event_idle()

Pauli Virtanen (2):
      Bluetooth: ISO: use hci_sync for setting CIG parameters
      Bluetooth: MGMT: add CIS feature bits to controller information

Paulo Alcantara (1):
      smb: client: fix broken file attrs with nodfs mounts

Pawel Dembicki (1):
      net: dsa: vsc73xx: fix MTU configuration

Pengcheng Yang (1):
      samples/bpf: Fix buffer overflow in tcp_basertt

Peter Collingbourne (1):
      mm: call arch_swap_restore() from do_swap_page()

Peter Seiderer (1):
      wifi: ath9k: fix AR9003 mac hardware hang check register offset calculation

Phil Elwell (1):
      nvmem: rmem: Use NVMEM_DEVID_AUTO

Pierre Morel (1):
      KVM: s390: vsie: fix the length of APCB bitmap

Prashanth K (2):
      usb: gadget: u_serial: Add null pointer check in gserial_suspend
      usb: common: usb-conn-gpio: Set last role to unknown before initial detection

Qi Zheng (1):
      NFSv4.2: fix wrong shrinker_id

Qiuxu Zhuo (2):
      rcu/rcuscale: Move rcu_scale_*() after kfree_scale_cleanup()
      rcu/rcuscale: Stop kfree_scale_thread thread(s) after unloading rcuscale

Quan Zhou (1):
      wifi: mt76: mt7921e: fix init command fail with enabled device

Rafał Miłecki (1):
      ARM: dts: BCM5301X: Drop "clock-names" from the SPI node

Randy Dunlap (4):
      soc/fsl/qe: fix usb.c build errors
      crypto: nx - fix build warnings when DEBUG_FS is not enabled
      media: cec: i2c: ch7322: also select REGMAP
      powerpc: allow PPC_EARLY_DEBUG_CPM only when SERIAL_CPM=y

Ravi Bangoria (2):
      perf/ibs: Fix interface via core pmu events
      perf tool x86: Consolidate is_amd check into single function

Remi Pommarel (1):
      wifi: ath9k: Fix possible stall on ath9k_txq_list_has_key()

Ricardo Ribalda Delgado (2):
      ASoC: mediatek: mt8173: Fix irq error path
      ASoC: mediatek: mt8173: Fix snd_soc_component_initialize error path

Rikard Falkeborn (1):
      media: venus: helpers: Fix ALIGN() of non power of two

Robert Hancock (1):
      i2c: xiic: Don't try to handle more interrupt events after error

Robert Marko (5):
      arm64: dts: microchip: sparx5: do not use PSCI on reference boards
      clk: qcom: reset: support resetting multiple bits
      clk: qcom: ipq6018: fix networking resets
      mmc: core: disable TRIM on Kingston EMMC04G-M627
      mmc: core: disable TRIM on Micron MTFC4GACAJCN-1M

Roberto Sassu (4):
      evm: Complete description of evm_inode_setattr()
      evm: Fix build warnings
      ima: Fix build warnings
      shmem: use ramfs_kill_sb() for kill_sb method of ramfs-based tmpfs

Robin Murphy (1):
      perf/arm-cmn: Fix DTC reset

Rongguang Wei (1):
      PCI: pciehp: Cancel bringup sequence if card is not present

Ryan Roberts (1):
      mm/damon/ops-common: atomically test and clear young on ptes and pmds

Sabrina Dubroca (1):
      selftests: rtnetlink: remove netdevsim device after ipsec offload test

Sagi Grimberg (5):
      nvme-auth: rename __nvme_auth_[reset|free] to nvme_auth[reset|free]_dhchap
      nvme-auth: rename authentication work elements
      nvme-auth: remove symbol export from nvme_auth_reset
      nvme-auth: no need to reset chap contexts on re-authentication
      nvme-auth: don't ignore key generation failures when initializing ctrl keys

Sami Tolvanen (1):
      kbuild: Disable GCOV for *.mod.o

Sean Nyekjaer (2):
      iio: accel: fxls8962af: errata bug only applicable for FXLS8962AF
      iio: accel: fxls8962af: fixup buffer scan element type

Sebastian Andrzej Siewior (1):
      tracing/timer: Add missing hrtimer modes to decode_hrtimer_mode().

Selvin Xavier (1):
      RDMA/bnxt_re: Disable/kill tasklet only if it is enabled

SeongJae Park (1):
      bpf, btf: Warn but return no error for NULL btf from __register_btf_kfunc_id_set()

Sergey Shtylyov (1):
      sh: Avoid using IRQ0 on SH3 and SH4

Shawn Wang (1):
      x86/resctrl: Only show tasks' pid in current pid namespace

Sherry Sun (1):
      tty: serial: fsl_lpuart: add earlycon for imx8ulp platform

Shuai Jiang (1):
      i2c: qup: Add missing unwind goto in qup_i2c_probe()

Shuijing Li (1):
      pwm: mtk_disp: Fix the disable flow of disp_pwm

Shunsuke Mie (2):
      PCI: endpoint: Fix Kconfig indent style
      PCI: endpoint: Fix a Kconfig prompt of vNTB driver

Shyam Prasad N (2):
      cifs: prevent use-after-free by freeing the cfile later
      cifs: do all necessary checks for credits within or before locking

Siddh Raman Pant (1):
      watch_queue: prevent dangling pipe pointer

Siddharth Vadapalli (1):
      PCI: cadence: Fix Gen2 Link Retraining process

Srinivasan Shanmugam (1):
      drm/amdgpu: Fix memcpy() in sienna_cichlid_append_powerplay_table function.

Stanislav Fomichev (1):
      bpf: Don't EFAULT for {g,s}setsockopt with wrong optlen

Stefan Wahren (1):
      w1: w1_therm: fix locking behavior in convert_t

Stephan Gerhold (3):
      arm64: dts: qcom: apq8016-sbc: Fix regulator constraints
      arm64: dts: qcom: apq8016-sbc: Fix 1.8V power rail on LS expansion
      mfd: rt5033: Drop rt5033-battery sub-device

Stephan Müller (1):
      crypto: jitter - correct health test during initialization

Su Hui (1):
      ALSA: ac97: Fix possible NULL dereference in snd_ac97_mixer

Sui Jingfeng (1):
      PCI: Add pci_clear_master() stub for non-CONFIG_PCI

Suren Baghdasaryan (1):
      mm/mmap: Fix VM_LOCKED check in do_vmi_align_munmap()

Syed Saba Kareem (1):
      ASoC: amd: acp: clear pdm dma interrupt mask

Takashi Iwai (2):
      ALSA: jack: Fix mutex call in snd_jack_report()
      ALSA: pcm: Fix potential data race at PCM memory allocation helpers

Taniya Das (1):
      clk: qcom: camcc-sc7180: Add parent dependency to all camera GDSCs

Tarun Sahu (1):
      dax/kmem: Pass valid argument to memory_group_register_static

Tero Kristo (1):
      cpufreq: intel_pstate: Fix energy_performance_preference for passive

Thadeu Lima de Souza Cascardo (2):
      netfilter: nf_tables: do not ignore genmask when looking up chain by id
      netfilter: nf_tables: prevent OOB access in nft_byteorder_eval

Thomas Gleixner (2):
      posix-timers: Prevent RT livelock in itimer_delete()
      x86/efi: Make efi_set_virtual_address_map IBT safe

Thomas Weißschuh (1):
      fs: avoid empty option when generating legacy mount string

Thorsten Winkler (1):
      s390/qeth: Fix vipa deletion

Tianjia Zhang (1):
      integrity: Fix possible multiple allocation in integrity_inode_get()

Tiezhu Yang (1):
      riscv: uprobes: Restore thread.bad_cause

Tim Harvey (1):
      hwmon: (gsc-hwmon) fix fan pwm temperature scaling

Tobias Heider (1):
      Add MODULE_FIRMWARE() for FIRMWARE_TG357766.

Tom Lendacky (1):
      x86/sev: Fix calculation of end address based on number of pages

Tony Lindgren (4):
      bus: ti-sysc: Fix dispc quirk masking bool variables
      ARM: dts: gta04: Move model property out of pinctrl node
      serial: 8250: omap: Fix freeing of resources on failed register
      serial: 8250_omap: Use force_suspend and resume for system suspend

Ulf Hansson (2):
      PM: domains: Move the verification of in-params from genpd_add_device()
      mmc: mmci: Set PROBE_PREFER_ASYNCHRONOUS

Uwe Kleine-König (3):
      drm/bridge: anx7625: Convert to i2c's .probe_new()
      usb: dwc2: platform: Improve error reporting for problems during .remove()
      extcon: usbc-tusb320: Convert to i2c's .probe_new()

Vijaya Krishna Nivarthi (1):
      spi: spi-geni-qcom: Correct CS_TOGGLE bit in SPI_TRANS_CFG

Vinay Belgaumkar (1):
      drm/i915/guc/slpc: Apply min softlimit correctly

Vincent Mailhol (1):
      can: length: fix bitstuffing count

Vinod Polimera (1):
      drm/msm/disp/dpu: get timing engine status from intf status register

Vladimir Oltean (9):
      net: mscc: ocelot: don't report that RX timestamping is enabled by default
      net: mscc: ocelot: don't keep PTP configuration of all ports in single structure
      net: dsa: felix: don't drop PTP frames with tag_8021q when RX timestamping is disabled
      net: dsa: sja1105: always enable the INCL_SRCPT option
      net: dsa: tag_sja1105: always prefer source port information from INCL_SRCPT
      net: bridge: keep ports without IFF_UNICAST_FLT in BR_PROMISC mode
      net: dsa: tag_sja1105: fix source port decoding in vlan_filtering=0 bridge mode
      net: dsa: tag_sja1105: fix MAC DA patching from meta frames
      net: dsa: sja1105: always enable the send_meta options

Vladislav Efanov (1):
      usb: dwc3: qcom: Fix potential memory leak

Wayne Chang (2):
      i2c: nvidia-gpu: Add ACPI property to align with device-tree
      i2c: nvidia-gpu: Remove ccgx,firmware-build property

Wells Lu (2):
      pinctrl: sunplus: Add check for kmalloc
      pinctrl:sunplus: Add check for kmalloc

Wen Yang (1):
      tick/rcu: Fix bogus ratelimit condition

Werner Sembach (1):
      ALSA: hda/realtek: Add quirk for Clevo NPx0SNx

Wesley Chalmers (1):
      drm/amd/display: Add logging for display MALL refresh setting

Will Deacon (1):
      arm64: sme: Use STR P to clear FFR context field in streaming SVE mode

Wolfram Sang (1):
      arm64: dts: renesas: ulcb-kf: Remove flow control for SCIF1

Woody Zhang (1):
      riscv: move memblock_allow_resize() after linear mapping is ready

Xin Long (1):
      net: add a couple of helpers for iph tot_len

Xinghui Li (1):
      PCI: vmd: Fix uninitialized variable usage in vmd_enable_domain()

XuDong Liu (1):
      drm: sun4i_tcon: use devm_clk_get_enabled in `sun4i_tcon_init_clocks`

Yafang Shao (2):
      bpf: Remove bpf trampoline selector
      bpf: Fix memleak due to fentry attach failure

Yangtao Li (1):
      f2fs: do not allow to defragment files have FI_COMPRESS_RELEASED

Yi Yingao (1):
      nvmem: sunplus-ocotp: release otp->clk before return

Yicong Yang (1):
      hwtracing: hisi_ptt: Fix potential sleep in atomic context

Yoshihiro Shimoda (1):
      PCI: endpoint: functions/pci-epf-test: Fix dma_chan direction

Youghandhar Chintala (1):
      wifi: ath10k: Trigger STA disconnect after reconfig complete on hardware restart

Yu Kuai (7):
      blk-mq: fix potential io hang by wrong 'wake_batch'
      md/raid1-10: factor out a helper to add bio to plug
      md/raid1-10: factor out a helper to submit normal write
      md/raid1-10: submit write io directly if bitmap is not enabled
      block: fix blktrace debugfs entries leakage
      md/raid1-10: fix casting from randomized structure in raid1_submit_write()
      blktrace: use inline function for blk_trace_remove() while blktrace is disabled

Yuan Can (1):
      clk: tegra: tegra124-emc: Fix potential memory leak

Yuchen Yang (1):
      scsi: 3w-xxxx: Add error handling for initialization failure in tw_probe()

Yue Zhao (1):
      lkdtm: replace ll_rw_block with submit_bh

Yunfei Dong (1):
      media: mediatek: vcodec: using decoder status instead of core work count

Yury Norov (1):
      lib/bitmap: drop optimization of bitmap_{from,to}_arr64

Yuxing Liu (1):
      clk: imx: clk-imx8mp: improve error handling in imx8mp_clocks_probe()

Zeng Heng (1):
      ntfs: Fix panic about slab-out-of-bounds caused by ntfs_listxattr()

Zhang Rui (1):
      powercap: RAPL: Fix CONFIG_IOSF_MBI dependency

Zhanhao Hu (1):
      clk: imx93: fix memory leak and missing unwind goto in imx93_clocks_probe

Zhen Lei (1):
      kexec: fix a memory leak in crash_shrink_memory()

Zheng Wang (2):
      bcache: Remove unnecessary NULL point check in node allocations
      bcache: Fix __bch_btree_node_alloc to make the failure behavior consistent

Zhengchao Shao (1):
      mlxsw: minimal: fix potential memory leak in mlxsw_m_linecards_init

hfdevel@gmx.net (1):
      ARM: dts: meson8b: correct uart_B and uart_C clock references

