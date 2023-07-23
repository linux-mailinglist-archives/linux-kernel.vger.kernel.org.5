Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDCA75E1CC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 14:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjGWM0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 08:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGWM0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 08:26:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353FF10DE;
        Sun, 23 Jul 2023 05:26:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CFFD60CA5;
        Sun, 23 Jul 2023 12:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E07C433C7;
        Sun, 23 Jul 2023 12:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690115177;
        bh=sVb5V4LbGz7aiGgtbeTIhYYIIeG+W1ohDI+zAgR3mrU=;
        h=From:To:Cc:Subject:Date:From;
        b=fdF5fStQ2LkYEsyWc7XY+e+oOyxJd+YAGt4CdiRQ4rZn0xcxcof6dnSZgaCOC4dXO
         +1X+o1zu6OrOdw6T5dOUD/p3h1mP/ut3WTfLY4LaeABCfS81ley33pqlH/QjbXY1Iz
         d185Rpzy6xQFXteieL4EjIRlY8Tx7FOgr5RoXVwM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.121
Date:   Sun, 23 Jul 2023 14:26:09 +0200
Message-ID: <2023072309-passport-unmovable-6f0f@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.15.121 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/device-mapper/dm-init.rst                  |    8 
 Documentation/arm64/silicon-errata.rst                               |    4 
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
 arch/arm/boot/dts/meson8.dtsi                                        |    4 
 arch/arm/boot/dts/meson8b.dtsi                                       |    4 
 arch/arm/boot/dts/omap3-gta04a5one.dts                               |    4 
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dts                      |    8 
 arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1.dtsi                        |   10 
 arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1.dtsi                        |   12 
 arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi                        |   11 
 arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi                   |    8 
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
 arch/arm64/Kconfig                                                   |   41 
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi                       |    4 
 arch/arm64/boot/dts/mediatek/mt8192.dtsi                             |   22 
 arch/arm64/boot/dts/microchip/sparx5.dtsi                            |    2 
 arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi                 |   12 
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts                             |  840 +++++++
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi                            |  826 -------
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts                          | 1070 +++++++++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi                         | 1105 ----------
 arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts                         |    4 
 arch/arm64/boot/dts/qcom/msm8916-mtp.dts                             |   15 
 arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi                            |   21 
 arch/arm64/boot/dts/qcom/msm8916.dtsi                                |    4 
 arch/arm64/boot/dts/qcom/msm8994.dtsi                                |    2 
 arch/arm64/boot/dts/qcom/msm8996-mtp.dts                             |   24 
 arch/arm64/boot/dts/qcom/msm8996-mtp.dtsi                            |   30 
 arch/arm64/boot/dts/qcom/msm8996.dtsi                                |   19 
 arch/arm64/boot/dts/qcom/sdm630.dtsi                                 |    2 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                                 |    2 
 arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi                 |    7 
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi                             |    3 
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts                |   28 
 arch/arm64/kernel/cpu_errata.c                                       |   26 
 arch/arm64/tools/cpucaps                                             |    1 
 arch/mips/include/asm/kvm_host.h                                     |    6 
 arch/mips/kernel/cpu-probe.c                                         |    9 
 arch/mips/kvm/emulate.c                                              |   22 
 arch/mips/kvm/mips.c                                                 |   16 
 arch/mips/kvm/stats.c                                                |    4 
 arch/mips/kvm/trace.h                                                |    8 
 arch/mips/kvm/vz.c                                                   |   20 
 arch/powerpc/Kconfig.debug                                           |    2 
 arch/powerpc/Makefile                                                |    8 
 arch/powerpc/kernel/interrupt.c                                      |    3 
 arch/powerpc/kernel/ppc_save_regs.S                                  |   61 
 arch/powerpc/kernel/security.c                                       |   37 
 arch/powerpc/kernel/signal_32.c                                      |   15 
 arch/powerpc/mm/book3s64/radix_pgtable.c                             |   34 
 arch/powerpc/mm/init_64.c                                            |    2 
 arch/powerpc/platforms/powernv/pci-sriov.c                           |    6 
 arch/powerpc/platforms/powernv/vas-window.c                          |    2 
 arch/powerpc/platforms/pseries/vas.c                                 |    2 
 arch/riscv/kernel/probes/uprobes.c                                   |    2 
 arch/riscv/mm/init.c                                                 |    6 
 arch/riscv/net/bpf_jit.h                                             |    5 
 arch/riscv/net/bpf_jit_core.c                                        |   15 
 arch/s390/Makefile                                                   |    1 
 arch/s390/kvm/diag.c                                                 |    8 
 arch/s390/kvm/kvm-s390.c                                             |    4 
 arch/s390/kvm/vsie.c                                                 |    6 
 arch/sh/drivers/dma/dma-sh.c                                         |   37 
 arch/sh/kernel/cpu/sh2/probe.c                                       |    2 
 arch/um/Makefile                                                     |    2 
 arch/x86/events/amd/core.c                                           |    2 
 arch/x86/events/amd/ibs.c                                            |   53 
 arch/x86/include/asm/perf_event.h                                    |    2 
 arch/x86/include/asm/pgtable_64.h                                    |    4 
 arch/x86/kernel/cpu/resctrl/rdtgroup.c                               |    8 
 arch/xtensa/platforms/iss/network.c                                  |    2 
 block/blk-iocost.c                                                   |    7 
 block/disk-events.c                                                  |    1 
 block/partitions/amiga.c                                             |  104 
 drivers/base/power/domain.c                                          |    6 
 drivers/bus/intel-ixp4xx-eb.c                                        |    2 
 drivers/bus/ti-sysc.c                                                |    4 
 drivers/char/hw_random/imx-rngc.c                                    |    6 
 drivers/char/hw_random/st-rng.c                                      |   21 
 drivers/char/hw_random/virtio-rng.c                                  |   88 
 drivers/char/tpm/tpm_vtpm_proxy.c                                    |   30 
 drivers/clk/clk-cdce925.c                                            |   12 
 drivers/clk/clk-si5341.c                                             |   38 
 drivers/clk/clk-versaclock5.c                                        |   29 
 drivers/clk/clk.c                                                    |    1 
 drivers/clk/imx/clk-imx8mn.c                                         |    8 
 drivers/clk/imx/clk-imx8mp.c                                         |   24 
 drivers/clk/imx/clk-scu.c                                            |    4 
 drivers/clk/keystone/sci-clk.c                                       |    2 
 drivers/clk/qcom/camcc-sc7180.c                                      |   19 
 drivers/clk/qcom/gcc-ipq6018.c                                       |   34 
 drivers/clk/qcom/reset.c                                             |    8 
 drivers/clk/qcom/reset.h                                             |    2 
 drivers/clk/tegra/clk-tegra124-emc.c                                 |    2 
 drivers/clk/ti/clkctrl.c                                             |    7 
 drivers/clocksource/timer-cadence-ttc.c                              |   19 
 drivers/cpufreq/intel_pstate.c                                       |    2 
 drivers/crypto/marvell/cesa/cipher.c                                 |    2 
 drivers/crypto/nx/Makefile                                           |    2 
 drivers/crypto/nx/nx.h                                               |    4 
 drivers/crypto/qat/qat_common/adf_common_drv.h                       |    5 
 drivers/crypto/qat/qat_common/qat_algs.c                             |   23 
 drivers/crypto/qat/qat_common/qat_asym_algs.c                        |   53 
 drivers/crypto/qat/qat_common/qat_crypto.h                           |    5 
 drivers/dax/bus.c                                                    |   61 
 drivers/dax/dax-private.h                                            |    4 
 drivers/dax/kmem.c                                                   |    2 
 drivers/extcon/extcon-usbc-tusb320.c                                 |    5 
 drivers/extcon/extcon.c                                              |    8 
 drivers/firmware/efi/libstub/efi-stub-helper.c                       |    7 
 drivers/firmware/stratix10-svc.c                                     |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                     |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                               |   28 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c                      |   13 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                    |    2 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c |    3 
 drivers/gpu/drm/amd/display/dc/core/dc.c                             |    3 
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h                          |    2 
 drivers/gpu/drm/bridge/tc358768.c                                    |   93 
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                                |   33 
 drivers/gpu/drm/drm_atomic.c                                         |   11 
 drivers/gpu/drm/drm_atomic_helper.c                                  |   11 
 drivers/gpu/drm/drm_gem_vram_helper.c                                |    6 
 drivers/gpu/drm/i915/display/intel_psr.c                             |    4 
 drivers/gpu/drm/i915/gt/intel_gtt.c                                  |    2 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c                                |    3 
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c                             |    5 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c                       |   10 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h                       |   12 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c                          |    8 
 drivers/gpu/drm/msm/dp/dp_display.c                                  |    2 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c                           |    3 
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c                      |   11 
 drivers/gpu/drm/panel/panel-simple.c                                 |    6 
 drivers/gpu/drm/radeon/ci_dpm.c                                      |   28 
 drivers/gpu/drm/radeon/cypress_dpm.c                                 |    8 
 drivers/gpu/drm/radeon/ni_dpm.c                                      |    8 
 drivers/gpu/drm/radeon/rv740_dpm.c                                   |    8 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c                          |    8 
 drivers/gpu/drm/sun4i/sun4i_tcon.c                                   |   19 
 drivers/gpu/drm/ttm/ttm_bo.c                                         |    1 
 drivers/hwmon/gsc-hwmon.c                                            |    6 
 drivers/hwmon/pmbus/adm1275.c                                        |   90 
 drivers/hwtracing/coresight/coresight-core.c                         |    9 
 drivers/i2c/busses/i2c-qup.c                                         |   21 
 drivers/i2c/busses/i2c-xiic.c                                        |   39 
 drivers/iio/accel/fxls8962af-core.c                                  |    8 
 drivers/iio/adc/ad7192.c                                             |    8 
 drivers/iio/adc/meson_saradc.c                                       |    2 
 drivers/infiniband/hw/bnxt_re/main.c                                 |   20 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                             |   40 
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                             |    2 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c                           |   46 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h                           |    1 
 drivers/infiniband/hw/hfi1/ipoib_tx.c                                |    4 
 drivers/infiniband/hw/hfi1/mmu_rb.c                                  |  101 
 drivers/infiniband/hw/hfi1/mmu_rb.h                                  |    3 
 drivers/infiniband/hw/hfi1/sdma.c                                    |   23 
 drivers/infiniband/hw/hfi1/sdma.h                                    |   47 
 drivers/infiniband/hw/hfi1/sdma_txreq.h                              |    2 
 drivers/infiniband/hw/hfi1/user_sdma.c                               |  145 -
 drivers/infiniband/hw/hfi1/user_sdma.h                               |    1 
 drivers/infiniband/hw/hfi1/vnic_sdma.c                               |    4 
 drivers/infiniband/hw/hns/hns_roce_hem.c                             |    7 
 drivers/infiniband/hw/irdma/uk.c                                     |   10 
 drivers/input/misc/adxl34x.c                                         |    3 
 drivers/input/misc/drv260x.c                                         |    1 
 drivers/irqchip/irq-jcore-aic.c                                      |    7 
 drivers/leds/trigger/ledtrig-netdev.c                                |    3 
 drivers/mailbox/ti-msgmgr.c                                          |   12 
 drivers/md/bcache/btree.c                                            |   25 
 drivers/md/bcache/btree.h                                            |    1 
 drivers/md/bcache/super.c                                            |    4 
 drivers/md/bcache/writeback.c                                        |   10 
 drivers/md/dm-init.c                                                 |   22 
 drivers/md/dm-integrity.c                                            |    4 
 drivers/md/md-bitmap.c                                               |   17 
 drivers/md/md.c                                                      |    9 
 drivers/md/raid0.c                                                   |   62 
 drivers/md/raid0.h                                                   |    1 
 drivers/md/raid10.c                                                  |   38 
 drivers/media/cec/i2c/Kconfig                                        |    1 
 drivers/media/i2c/st-mipid02.c                                       |    9 
 drivers/media/platform/qcom/venus/helpers.c                          |    4 
 drivers/media/usb/dvb-usb-v2/az6007.c                                |    3 
 drivers/media/usb/siano/smsusb.c                                     |    3 
 drivers/memory/brcmstb_dpfe.c                                        |    4 
 drivers/memstick/host/r592.c                                         |    4 
 drivers/mfd/intel-lpss-acpi.c                                        |    3 
 drivers/mfd/qcom-pm8008.c                                            |    1 
 drivers/mfd/rt5033.c                                                 |    3 
 drivers/mfd/stmfx.c                                                  |    7 
 drivers/mfd/stmpe.c                                                  |    4 
 drivers/misc/fastrpc.c                                               |    2 
 drivers/misc/pci_endpoint_test.c                                     |   10 
 drivers/mmc/core/quirks.h                                            |   14 
 drivers/mmc/host/mmci.c                                              |    1 
 drivers/mmc/host/sdhci.c                                             |    4 
 drivers/mtd/nand/raw/meson_nand.c                                    |    4 
 drivers/net/bonding/bond_main.c                                      |    2 
 drivers/net/dsa/vitesse-vsc73xx-core.c                               |    6 
 drivers/net/ethernet/amazon/ena/ena_com.c                            |    3 
 drivers/net/ethernet/broadcom/bgmac.c                                |    4 
 drivers/net/ethernet/broadcom/genet/bcmmii.c                         |    2 
 drivers/net/ethernet/broadcom/tg3.c                                  |    1 
 drivers/net/ethernet/google/gve/gve_ethtool.c                        |    3 
 drivers/net/ethernet/ibm/ibmvnic.c                                   |    9 
 drivers/net/ethernet/intel/igc/igc.h                                 |   33 
 drivers/net/ethernet/intel/igc/igc_ethtool.c                         |    2 
 drivers/net/ethernet/intel/igc/igc_main.c                            |   45 
 drivers/net/ethernet/intel/igc/igc_ptp.c                             |   82 
 drivers/net/ethernet/marvell/mvneta.c                                |    4 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c                      |    7 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h                      |   11 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c                  |    4 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c              |    8 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c                 |   15 
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c                     |    6 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c            |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c                      |    6 
 drivers/net/ethernet/microchip/lan743x_main.c                        |   21 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                      |    5 
 drivers/net/ethernet/sfc/ef10.c                                      |   13 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                    |    6 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c                    |   10 
 drivers/net/gtp.c                                                    |    2 
 drivers/net/ipvlan/ipvlan_core.c                                     |    9 
 drivers/net/netdevsim/dev.c                                          |    9 
 drivers/net/ppp/pptp.c                                               |   31 
 drivers/net/wireguard/netlink.c                                      |   14 
 drivers/net/wireguard/queueing.c                                     |    1 
 drivers/net/wireguard/queueing.h                                     |   25 
 drivers/net/wireguard/receive.c                                      |    2 
 drivers/net/wireguard/send.c                                         |    2 
 drivers/net/wireless/ath/ath9k/ar9003_hw.c                           |   27 
 drivers/net/wireless/ath/ath9k/htc_hst.c                             |    8 
 drivers/net/wireless/ath/ath9k/main.c                                |   11 
 drivers/net/wireless/ath/ath9k/wmi.c                                 |    4 
 drivers/net/wireless/atmel/atmel_cs.c                                |   13 
 drivers/net/wireless/cisco/airo.c                                    |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c                         |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c                        |    9 
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c                         |   12 
 drivers/net/wireless/intersil/orinoco/orinoco_cs.c                   |   13 
 drivers/net/wireless/intersil/orinoco/spectrum_cs.c                  |   13 
 drivers/net/wireless/marvell/mwifiex/scan.c                          |    6 
 drivers/net/wireless/microchip/wilc1000/hif.c                        |    8 
 drivers/net/wireless/ray_cs.c                                        |   36 
 drivers/net/wireless/rsi/rsi_91x_sdio.c                              |    9 
 drivers/net/wireless/wl3501_cs.c                                     |   19 
 drivers/ntb/hw/amd/ntb_hw_amd.c                                      |    7 
 drivers/ntb/hw/idt/ntb_hw_idt.c                                      |    7 
 drivers/ntb/hw/intel/ntb_hw_gen1.c                                   |    7 
 drivers/ntb/ntb_transport.c                                          |    2 
 drivers/ntb/test/ntb_tool.c                                          |    2 
 drivers/nvme/host/pci.c                                              |   30 
 drivers/nvmem/rmem.c                                                 |    1 
 drivers/opp/core.c                                                   |    3 
 drivers/pci/controller/cadence/pcie-cadence-host.c                   |   27 
 drivers/pci/controller/dwc/pcie-qcom.c                               |    2 
 drivers/pci/controller/pci-ftpci100.c                                |   14 
 drivers/pci/controller/pcie-rockchip-ep.c                            |   65 
 drivers/pci/controller/pcie-rockchip.c                               |   17 
 drivers/pci/controller/pcie-rockchip.h                               |   11 
 drivers/pci/controller/vmd.c                                         |    8 
 drivers/pci/hotplug/pciehp_ctrl.c                                    |    8 
 drivers/pci/pci.c                                                    |   10 
 drivers/pci/pcie/aspm.c                                              |   21 
 drivers/pci/quirks.c                                                 |    2 
 drivers/perf/arm-cmn.c                                               |    7 
 drivers/phy/tegra/xusb.c                                             |    4 
 drivers/pinctrl/bcm/pinctrl-bcm2835.c                                |    6 
 drivers/pinctrl/intel/pinctrl-cherryview.c                           |   15 
 drivers/pinctrl/pinctrl-amd.c                                        |   25 
 drivers/pinctrl/pinctrl-amd.h                                        |    1 
 drivers/pinctrl/pinctrl-at91-pio4.c                                  |    2 
 drivers/pinctrl/pinctrl-microchip-sgpio.c                            |    3 
 drivers/platform/x86/wmi.c                                           |   64 
 drivers/powercap/Kconfig                                             |    4 
 drivers/powercap/intel_rapl_msr.c                                    |    1 
 drivers/pwm/pwm-ab8500.c                                             |    2 
 drivers/pwm/pwm-imx-tpm.c                                            |    7 
 drivers/pwm/pwm-mtk-disp.c                                           |   13 
 drivers/pwm/sysfs.c                                                  |   17 
 drivers/regulator/core.c                                             |   30 
 drivers/rtc/rtc-st-lpc.c                                             |    2 
 drivers/s390/net/qeth_l3_sys.c                                       |    2 
 drivers/scsi/3w-xxxx.c                                               |    4 
 drivers/scsi/qedf/qedf_main.c                                        |    3 
 drivers/scsi/qla2xxx/qla_attr.c                                      |   13 
 drivers/scsi/qla2xxx/qla_bsg.c                                       |    6 
 drivers/scsi/qla2xxx/qla_def.h                                       |    1 
 drivers/scsi/qla2xxx/qla_edif.c                                      |    4 
 drivers/scsi/qla2xxx/qla_init.c                                      |    2 
 drivers/scsi/qla2xxx/qla_inline.h                                    |    5 
 drivers/scsi/qla2xxx/qla_iocb.c                                      |    5 
 drivers/scsi/qla2xxx/qla_nvme.c                                      |    3 
 drivers/scsi/qla2xxx/qla_os.c                                        |    3 
 drivers/soc/amlogic/meson-secure-pwrc.c                              |    2 
 drivers/soc/fsl/qe/Kconfig                                           |    1 
 drivers/soundwire/qcom.c                                             |    3 
 drivers/spi/spi-bcm-qspi.c                                           |   10 
 drivers/spi/spi-dw-core.c                                            |    5 
 drivers/spi/spi-geni-qcom.c                                          |    2 
 drivers/staging/clocking-wizard/clk-xlnx-clock-wizard.c              |    2 
 drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c            |    2 
 drivers/thermal/sun8i_thermal.c                                      |   55 
 drivers/tty/serial/8250/8250.h                                       |    1 
 drivers/tty/serial/8250/8250_omap.c                                  |   25 
 drivers/tty/serial/8250/8250_pci.c                                   |   19 
 drivers/tty/serial/8250/8250_port.c                                  |   11 
 drivers/tty/serial/atmel_serial.c                                    |    4 
 drivers/tty/serial/fsl_lpuart.c                                      |    1 
 drivers/tty/serial/imx.c                                             |   18 
 drivers/tty/serial/samsung_tty.c                                     |   14 
 drivers/usb/core/devio.c                                             |    2 
 drivers/usb/dwc2/platform.c                                          |   18 
 drivers/usb/dwc3/dwc3-meson-g12a.c                                   |    5 
 drivers/usb/dwc3/dwc3-qcom.c                                         |   17 
 drivers/usb/dwc3/gadget.c                                            |    4 
 drivers/usb/gadget/function/u_serial.c                               |   13 
 drivers/usb/host/xhci-mem.c                                          |   39 
 drivers/usb/host/xhci-pci.c                                          |   12 
 drivers/usb/host/xhci.h                                              |    2 
 drivers/usb/phy/phy-tahvo.c                                          |    2 
 drivers/usb/serial/option.c                                          |    4 
 drivers/video/fbdev/omap/lcd_mipid.c                                 |    6 
 drivers/w1/slaves/w1_therm.c                                         |   31 
 drivers/w1/w1.c                                                      |    4 
 fs/btrfs/block-group.c                                               |   36 
 fs/btrfs/ctree.c                                                     |   28 
 fs/btrfs/qgroup.c                                                    |    2 
 fs/ceph/caps.c                                                       |    9 
 fs/cifs/file.c                                                       |   25 
 fs/dlm/plock.c                                                       |    4 
 fs/erofs/inode.c                                                     |    5 
 fs/erofs/internal.h                                                  |   16 
 fs/erofs/super.c                                                     |   58 
 fs/erofs/xattr.c                                                     |    4 
 fs/erofs/zdata.c                                                     |   10 
 fs/erofs/zmap.c                                                      |    6 
 fs/ext4/indirect.c                                                   |    8 
 fs/ext4/inode.c                                                      |   10 
 fs/ext4/ioctl.c                                                      |    5 
 fs/ext4/mballoc.c                                                    |   17 
 fs/ext4/namei.c                                                      |   17 
 fs/ext4/super.c                                                      |   19 
 fs/f2fs/f2fs.h                                                       |    2 
 fs/f2fs/file.c                                                       |    2 
 fs/f2fs/gc.c                                                         |   21 
 fs/f2fs/namei.c                                                      |   16 
 fs/f2fs/node.c                                                       |    4 
 fs/fs_context.c                                                      |    3 
 fs/inode.c                                                           |   42 
 fs/internal.h                                                        |    2 
 fs/jffs2/build.c                                                     |    5 
 fs/jffs2/xattr.c                                                     |   13 
 fs/jffs2/xattr.h                                                     |    4 
 fs/jfs/jfs_dmap.c                                                    |    6 
 fs/jfs/jfs_filsys.h                                                  |    2 
 fs/kernfs/dir.c                                                      |    2 
 fs/ksmbd/server.c                                                    |   33 
 fs/ksmbd/smb2misc.c                                                  |   38 
 fs/ksmbd/smb2pdu.c                                                   |   44 
 fs/ksmbd/smb_common.c                                                |    2 
 fs/namei.c                                                           |   25 
 fs/nfs/nfs4proc.c                                                    |    1 
 fs/nfsd/nfs4xdr.c                                                    |    2 
 fs/notify/fanotify/fanotify_user.c                                   |   22 
 fs/ntfs3/index.c                                                     |   84 
 fs/ntfs3/inode.c                                                     |   18 
 fs/ntfs3/ntfs_fs.h                                                   |    4 
 fs/ntfs3/run.c                                                       |    7 
 fs/ntfs3/xattr.c                                                     |  112 -
 fs/overlayfs/copy_up.c                                               |    2 
 fs/overlayfs/dir.c                                                   |    3 
 fs/overlayfs/export.c                                                |    3 
 fs/overlayfs/inode.c                                                 |   10 
 fs/overlayfs/namei.c                                                 |    3 
 fs/overlayfs/overlayfs.h                                             |    6 
 fs/overlayfs/super.c                                                 |    2 
 fs/overlayfs/util.c                                                  |   24 
 fs/pstore/ram_core.c                                                 |    2 
 fs/ramfs/inode.c                                                     |    2 
 include/acpi/acpi_bus.h                                              |    3 
 include/crypto/internal/kpp.h                                        |    6 
 include/linux/bootmem_info.h                                         |    2 
 include/linux/can/length.h                                           |   14 
 include/linux/netdevice.h                                            |    9 
 include/linux/nmi.h                                                  |    2 
 include/linux/pci.h                                                  |    1 
 include/linux/pipe_fs_i.h                                            |    4 
 include/linux/ramfs.h                                                |    1 
 include/linux/serial_8250.h                                          |    1 
 include/linux/workqueue.h                                            |   15 
 include/net/netfilter/nf_tables.h                                    |    5 
 include/net/pkt_sched.h                                              |    2 
 include/net/sock.h                                                   |    1 
 include/trace/events/timer.h                                         |    6 
 include/uapi/linux/affs_hardblocks.h                                 |   68 
 include/uapi/linux/auto_dev-ioctl.h                                  |    2 
 include/uapi/linux/videodev2.h                                       |    2 
 io_uring/io_uring.c                                                  |   66 
 kernel/bpf/cgroup.c                                                  |   15 
 kernel/bpf/cpumap.c                                                  |   40 
 kernel/bpf/verifier.c                                                |    5 
 kernel/kcsan/core.c                                                  |    2 
 kernel/kexec_core.c                                                  |    5 
 kernel/rcu/rcuscale.c                                                |  212 -
 kernel/time/posix-timers.c                                           |   43 
 kernel/trace/ftrace.c                                                |   45 
 kernel/trace/ring_buffer.c                                           |   24 
 kernel/trace/trace.c                                                 |    3 
 kernel/trace/trace_eprobe.c                                          |   18 
 kernel/trace/trace_events_hist.c                                     |    8 
 kernel/trace/trace_probe_tmpl.h                                      |   14 
 kernel/watchdog_hld.c                                                |    6 
 kernel/workqueue.c                                                   |   13 
 lib/test_firmware.c                                                  |   12 
 lib/ts_bm.c                                                          |    4 
 mm/damon/vaddr.c                                                     |   20 
 mm/shmem.c                                                           |    2 
 net/bridge/br_if.c                                                   |    5 
 net/ceph/messenger_v2.c                                              |   41 
 net/core/filter.c                                                    |  131 -
 net/core/rtnetlink.c                                                 |  104 
 net/core/skbuff.c                                                    |    5 
 net/core/sock.c                                                      |   17 
 net/dsa/tag_sja1105.c                                                |    4 
 net/ipv4/tcp_input.c                                                 |   12 
 net/ipv6/addrconf.c                                                  |    3 
 net/ipv6/icmp.c                                                      |    5 
 net/ipv6/udp.c                                                       |    2 
 net/netfilter/ipvs/Kconfig                                           |   27 
 net/netfilter/ipvs/ip_vs_conn.c                                      |    4 
 net/netfilter/nf_conntrack_helper.c                                  |    4 
 net/netfilter/nf_conntrack_proto_dccp.c                              |   52 
 net/netfilter/nf_conntrack_sip.c                                     |    2 
 net/netfilter/nf_tables_api.c                                        |  158 +
 net/netfilter/nft_byteorder.c                                        |   14 
 net/netfilter/nft_set_bitmap.c                                       |    5 
 net/netfilter/nft_set_hash.c                                         |   23 
 net/netfilter/nft_set_pipapo.c                                       |   14 
 net/netfilter/nft_set_rbtree.c                                       |    5 
 net/netlink/af_netlink.c                                             |    5 
 net/netlink/diag.c                                                   |    7 
 net/nfc/llcp.h                                                       |    1 
 net/nfc/llcp_commands.c                                              |   15 
 net/nfc/llcp_core.c                                                  |   49 
 net/nfc/llcp_sock.c                                                  |   21 
 net/nfc/netlink.c                                                    |   20 
 net/nfc/nfc.h                                                        |    1 
 net/sched/act_ipt.c                                                  |   27 
 net/sched/act_pedit.c                                                |    1 
 net/sched/cls_flower.c                                               |   10 
 net/sched/cls_fw.c                                                   |   10 
 net/sched/sch_qfq.c                                                  |   41 
 net/sctp/socket.c                                                    |   22 
 net/sunrpc/svcsock.c                                                 |   23 
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c                              |   12 
 net/wireless/scan.c                                                  |  213 +
 net/xdp/xsk.c                                                        |    5 
 samples/bpf/tcp_basertt_kern.c                                       |    2 
 samples/ftrace/ftrace-direct-too.c                                   |   14 
 scripts/Makefile.modfinal                                            |    2 
 scripts/mod/modpost.c                                                |   86 
 security/apparmor/policy_unpack.c                                    |    9 
 security/integrity/evm/evm_crypto.c                                  |    2 
 security/integrity/evm/evm_main.c                                    |    4 
 security/integrity/iint.c                                            |   15 
 security/integrity/ima/ima_modsig.c                                  |    3 
 security/integrity/ima/ima_policy.c                                  |    3 
 sound/core/jack.c                                                    |   15 
 sound/pci/ac97/ac97_codec.c                                          |    4 
 sound/pci/hda/patch_realtek.c                                        |    1 
 sound/soc/codecs/es8316.c                                            |   23 
 sound/soc/fsl/imx-audmix.c                                           |    9 
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c                           |   13 
 tools/bpf/bpftool/feature.c                                          |   24 
 tools/lib/bpf/bpf_helpers.h                                          |   15 
 tools/lib/bpf/btf_dump.c                                             |   22 
 tools/perf/builtin-bench.c                                           |    7 
 tools/perf/builtin-script.c                                          |   16 
 tools/perf/tests/builtin-test.c                                      |    3 
 tools/perf/util/dwarf-aux.c                                          |    2 
 tools/testing/selftests/bpf/prog_tests/check_mtu.c                   |    2 
 tools/testing/selftests/net/mptcp/config                             |    1 
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh                   |    9 
 tools/testing/selftests/net/rtnetlink.sh                             |    1 
 tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot     |    2 
 tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot           |    2 
 tools/testing/selftests/vDSO/vdso_test_clock_getres.c                |    4 
 tools/testing/selftests/wireguard/netns.sh                           |   30 
 518 files changed, 6689 insertions(+), 4479 deletions(-)

Abhijeet Rastogi (1):
      ipvs: increase ip_vs_conn_tab_bits range for 64BIT

Aditya Gupta (1):
      powerpc: update ppc_save_regs to save current r1 in pt_regs

Alan Maguire (1):
      bpftool: JIT limited misreported as negative value on aarch64

Alexander Aring (1):
      fs: dlm: return positive pid value for F_GETLK

Alexander Mikhalitsyn (1):
      sctp: add bpf_bypass_getsockopt proto callback

Alexey Romanov (1):
      drivers: meson: secure-pwrc: always enable DMA domain

Allen-KH Cheng (1):
      arm64: dts: mediatek: Add cpufreq nodes for MT8192

Amelie Delaunay (2):
      mfd: stmfx: Fix error path in stmfx_chip_init
      mfd: stmfx: Nullify stmfx->vdd in case of error

Amir Goldstein (2):
      ovl: update of dentry revalidate flags after copy up
      fanotify: disallow mount/sb marks on kernel internal pseudo fs

Amisha Patel (1):
      wifi: wilc1000: fix for absent RSN capabilities WFA testcase

Andre Przywara (1):
      crypto: qat - replace get_current_node() with numa_node_id()

Andres Freund (1):
      io_uring: Use io_schedule* in cqring wait

Andrii Nakryiko (1):
      libbpf: fix offsetof() and container_of() to work with CO-RE

Andy Shevchenko (6):
      wifi: ray_cs: Utilize strnlen() in parse_addr()
      wifi: ray_cs: Drop useless status variable in parse_addr()
      pinctrl: cherryview: Return correct value if pin in push-pull mode
      extcon: Fix kernel doc of property fields to avoid warnings
      extcon: Fix kernel doc of property capability fields to avoid warnings
      platform/x86: wmi: Break possible infinite loop when parsing GUID

Aneesh Kumar K.V (2):
      powerpc/book3s64/mm: Fix DirectMap stats in /proc/meminfo
      powerpc/mm/dax: Fix the condition when checking if altmap vmemap can cross-boundary

Anjaneyulu (1):
      wifi: iwlwifi: pcie: fix NULL pointer dereference in iwl_pcie_irq_rx_msix_handler()

Aravindhan Gunasekaran (1):
      igc: Handle PPS start time programming for past time values

Ard Biesheuvel (1):
      efi/libstub: Disable PCI DMA before grabbing the EFI memory map

Arnaldo Carvalho de Melo (2):
      perf bench: Add missing setlocale() call to allow usage of %'d style formatting
      perf script: Fix allocation of evsel->priv related to per-event dump files

Arnd Bergmann (11):
      fs: pipe: reveal missing function protoypes
      ARM: 9303/1: kprobes: avoid missing-declaration warnings
      memstick r592: make memstick_debug_get_tpc_name() static
      ARM: ep93xx: fix missing-prototype warnings
      ARM: omap2: fix missing tick_broadcast() prototype
      RDMA/irdma: avoid fortify-string warning in irdma_clr_wqes
      crypto: marvell/cesa - Fix type mismatch warning
      ksmbd: avoid field overflow warning
      usb: hide unused usbfs_notify_suspend/resume functions
      autofs: use flexible array in ioctl structure
      ARM: orion5x: fix d2net gpio initialization

Arseniy Krasnov (1):
      mtd: rawnand: meson: fix unaligned DMA buffers handling

Artur Rojek (1):
      sh: dma: Fix DMA channel offset calculation

Aurabindo Pillai (1):
      drm/amd/display: Fix artifacting on eDP panels when engaging freesync video mode

Baokun Li (2):
      ext4: turn quotas off if mount failed after enabling quotas
      ext4: only update i_reserved_data_blocks on successful block allocation

Barnabás Pőcze (3):
      platform/x86: wmi: remove unnecessary argument
      platform/x86: wmi: use guid_t and guid_equal()
      platform/x86: wmi: move variables

Bartosz Golaszewski (1):
      net: stmmac: fix double serdes powerdown

Benjamin Berg (1):
      wifi: cfg80211: rewrite merging of inherited elements

Bharath SM (1):
      SMB3: Do not send lease break acknowledgment if all file handles have been closed

Bikash Hazarika (2):
      scsi: qla2xxx: Fix potential NULL pointer dereference
      scsi: qla2xxx: Correct the index of array

Bjorn Andersson (2):
      arm64: dts: qcom: apq8016-sbc: Update modem and WiFi firmware path
      drm/msm/dp: Free resources after unregistering them

Björn Töpel (1):
      riscv, bpf: Fix inconsistent JIT image generation

Brendan Cunningham (1):
      IB/hfi1: Fix wrong mmu_node used for user SDMA packet after invalidate

Brian Norris (2):
      drm/atomic: Allow vblank-enabled + self-refresh "disable"
      drm/rockchip: vop: Leave vblank enabled in self-refresh

Cambda Zhu (1):
      ipvlan: Fix return value of ipvlan_queue_xmit()

Chao Yu (3):
      f2fs: fix error path handling in truncate_dnode()
      f2fs: fix to avoid NULL pointer dereference f2fs_write_end_io()
      ext4: fix to check return value of freeze_bdev() in ext4_shutdown()

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

Christian Lamparter (1):
      ARM: dts: BCM5301X: fix duplex-full => full-duplex

Christian Marangi (1):
      leds: trigger: netdev: Recheck NETDEV_LED_MODE_LINKUP on dev rename

Christophe JAILLET (19):
      thermal/drivers/sun8i: Fix some error handling paths in sun8i_ths_probe()
      wifi: mwifiex: Fix the size of a memory allocation in mwifiex_ret_802_11_scan()
      wifi: orinoco: Fix an error handling path in spectrum_cs_probe()
      wifi: orinoco: Fix an error handling path in orinoco_cs_probe()
      wifi: atmel: Fix an error handling path in atmel_probe()
      wifi: wl3501_cs: Fix an error handling path in wl3501_probe()
      wifi: ray_cs: Fix an error handling path in ray_probe()
      IB/hfi1: Use bitmap_zalloc() when applicable
      fbdev: omapfb: lcd_mipid: Fix an error handling path in mipid_spi_probe()
      pinctrl: bcm2835: Handle gpiochip_add_pin_range() errors
      usb: dwc2: Fix some error handling paths
      usb: dwc3: qcom: Release the correct resources in dwc3_qcom_remove()
      usb: dwc3: qcom: Fix an error handling path in dwc3_qcom_probe()
      usb: dwc3-meson-g12a: Fix an error handling path in dwc3_meson_g12a_probe()
      mfd: stmpe: Only disable the regulators if they are enabled
      rtc: st-lpc: Release some resources in st_rtc_probe() in case of error
      tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() in case of error
      tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() when iterating clk
      firmware: stratix10-svc: Fix a potential resource leak in svc_create_memory_pool()

Christophe Leroy (3):
      kcsan: Don't expect 64 bits atomic builtins from 32 bits architectures
      powerpc/interrupt: Don't read MSR from interrupt_exit_kernel_prepare()
      powerpc/signal32: Force inlining of __unsafe_save_user_regs() and save_tm_user_regs_unsafe()

Chuck Lever (1):
      svcrdma: Prevent page release when nothing was received

Chunhai Guo (1):
      erofs: avoid infinite loop in z_erofs_do_read_page() when reading beyond EOF

Claudiu Beznea (11):
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
      phy: tegra: xusb: check return value of devm_kzalloc()

Colin Ian King (2):
      kselftest: vDSO: Fix accumulation of uninitialized ret when CLOCK_REALTIME is undefined
      powerpc/powernv/sriov: perform null check on iov before dereferencing iov

Cristian Ciocaltea (2):
      ASoC: es8316: Increment max value for ALC Capture Target Volume control
      ASoC: es8316: Do not set rate constraints for unsupported MCLKs

Dai Ngo (1):
      NFSD: add encoding of op_recall flag for write delegation

Damian Muszynski (1):
      crypto: qat - use reference to structure in dma_map_single()

Damien Le Moal (3):
      PCI: rockchip: Set address alignment for endpoint mode
      misc: pci_endpoint_test: Free IRQs before removing the device
      misc: pci_endpoint_test: Re-init completion for every test

Dan Carpenter (9):
      clk: imx: scu: use _safe list iterator to avoid a use after free
      clk: clocking-wizard: Fix Oops in clk_wzrd_register_divider()
      modpost: fix off by one in is_executable_section()
      w1: fix loop in w1_fini()
      media: atomisp: gmin_platform: fix out_len in gmin_get_config_dsm_var()
      pwm: ab8500: Fix error code in probe()
      scsi: qla2xxx: Fix error code in qla2x00_start_sp()
      netdevsim: fix uninitialized data in nsim_dev_trap_fa_cookie_write()
      serial: atmel: don't enable IRQs prematurely

Dan Williams (2):
      dax: Fix dax_mapping_release() use after free
      dax: Introduce alloc_dev_dax_id()

Daniel Scally (1):
      media: i2c: Correct format propagation for st-mipid02

Daniel Vetter (1):
      drm/atomic: Fix potential use-after-free in nonblocking commits

Daniil Dulov (2):
      drm/amdkfd: Fix potential deallocation of previously deallocated memory.
      media: usb: Check az6007_read() return value

Danila Chernetsov (1):
      apparmor: fix missing error check for rhashtable_insert_fast

Dario Binacchi (1):
      drm/panel: simple: fix active size for Ampire AM-480272H3TMQW-T01H

Davide Tronchin (1):
      USB: serial: option: add LARA-R6 01B PIDs

Demi Marie Obenour (1):
      block: increment diskseq on all media change events

Ding Hui (2):
      PCI/ASPM: Disable ASPM on MFD function removal to avoid use-after-free
      SUNRPC: Fix UAF in svc_tcp_listen_data_ready()

Dmitry Antipov (1):
      wifi: ath9k: convert msecs to jiffies where needed

Dmitry Baryshkov (6):
      drm/panel: sharp-ls043t1le01: adjust mode settings
      drm/msm/dsi: don't allow enabling 14nm VCO with unprogrammed rate
      arm64: dts: qcom: apq8016-sbc: fix mpps state names
      drm/msm/a5xx: really check for A510 in a5xx_gpu_init
      drm/msm/dpu: do not enable color-management if DSPPs are not available
      drm/msm/dpu: correct MERGE_3D length

Douglas Anderson (4):
      watchdog/perf: define dummy watchdog_update_hrtimer_threshold() on correct config
      watchdog/perf: more properly prevent false positives with turbo modes
      arm64: dts: mediatek: mt8183: Add mediatek,broken-save-restore-fw to kukui
      drm/bridge: ti-sn65dsi86: Fix auxiliary bus lifetime

Duoming Zhou (1):
      media: usb: siano: Fix warning due to null work_func_t function pointer

EJ Hsu (1):
      phy: tegra: xusb: Clear the driver reference in usb-phy dev

Edward Cree (1):
      sfc: fix crash when reading stats while NIC is resetting

Edwin Peer (1):
      rtnetlink: extend RTEXT_FILTER_SKIP_STATS to IFLA_VF_INFO

Ekansh Gupta (1):
      misc: fastrpc: Create fastrpc scalar with correct buffer count

Emmanuel Grumbach (1):
      iwlwifi: don't dump_stack() when we get an unexpected interrupt

Eric Dumazet (5):
      netlink: fix potential deadlock in netlink_set_err()
      netlink: do not hard code device address lenth in fdb dumps
      bonding: do not assume skb mac_header is set
      tcp: annotate data races in __tcp_oow_rate_limited()
      udp6: fix udp6_ehashfn() typo

Fabian Frederick (1):
      jffs2: reduce stack usage in jffs2_build_xattr_subsystem()

Fabio Estevam (1):
      drm/panel: simple: Add connector_type for innolux_at043tn24

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

Filipe Manana (4):
      btrfs: do not BUG_ON() on tree mod log failure at balance_level()
      btrfs: fix race when deleting quota root from the dirty cow roots list
      btrfs: fix extent buffer leak after tree mod log failure at split_node()
      btrfs: do not BUG_ON() on tree mod log failure at __btrfs_cow_block()

Florent Revest (2):
      netfilter: conntrack: Avoid nf_ct_helper_hash uses after free
      samples: ftrace: Save required argument registers in sample trampolines

Florian Fainelli (1):
      net: bcmgenet: Ensure MDIO unregistration has clocks enabled

Florian Kauer (2):
      igc: Fix launchtime before start of cycle
      igc: Fix inserting of empty frame for launchtime

Florian Westphal (2):
      netfilter: conntrack: dccp: copy entire header to stack buffer, not just basic one
      net/sched: act_ipt: add sanity checks on table name and hook locations

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

Gao Xiang (2):
      erofs: decouple basic mount options from fs_context
      erofs: fix compact 4B support for 16k block size

Geert Uytterhoeven (3):
      regulator: core: Fix more error checking for debugfs_create_dir()
      regulator: core: Streamline debugfs operations
      ARM: dts: iwg20d-q7-common: Fix backlight pwm specifier

George Stark (1):
      meson saradc: fix clock divider mask length

Gilad Sever (3):
      bpf: Factor out socket lookup functions for the TC hookpoint.
      bpf: Call __bpf_sk_lookup()/__bpf_skc_lookup() directly via TC hookpoint
      bpf: Fix bpf socket lookup from tc/xdp to respect socket VRF bindings

Giovanni Cabiddu (1):
      crypto: qat - honor CRYPTO_TFM_REQ_MAY_SLEEP flag

Greg Kroah-Hartman (2):
      Revert "usb: common: usb-conn-gpio: Set last role to unknown before initial detection"
      Linux 5.15.121

Guenter Roeck (1):
      hwmon: (pmbus/adm1275) Fix problems with temperature monitoring on ADM1272

Guillaume Nault (1):
      pptp: Fix fib lookup calls.

Hao Luo (1):
      clk: imx: clk-imx8mn: fix memory leak in imx8mn_clocks_probe

Hareshx Sankar Raj (2):
      crypto: qat - unmap buffer before free for DH
      crypto: qat - unmap buffers before free for RSA

Hariprasad Kelam (3):
      octeontx2-af: Fix mapping for NIX block from CGX connection
      octeontx2-af: Add validation before accessing cgx and lmac
      octeontx-af: fix hardware timestamp configuration

Heiko Carstens (1):
      s390/decompressor: fix misaligned symbol build error

Herbert Xu (3):
      hwrng: virtio - Fix race on data_avail and actual data
      crypto: kpp - Add helper to set reqsize
      crypto: qat - Use helper to set reqsize

Huacai Chen (2):
      MIPS: Loongson: Fix cpu_probe_loongson() again
      MIPS: KVM: Fix NULL pointer dereference

Ido Schimmel (1):
      net/sched: flower: Ensure both minimum and maximum ports are specified

Ilia.Gavrilov (1):
      netfilter: nf_conntrack_sip: fix the ct_sip_parse_numerical_param() return value.

Ilya Dryomov (1):
      libceph: harden msgr2.1 frame segment length checks

Ilya Maximets (1):
      xsk: Honor SO_BINDTODEVICE on bind

Jakub Kicinski (1):
      wl3501_cs: use eth_hw_addr_set()

James Clark (1):
      coresight: Fix loss of connection info when a module is unloaded

Jan Kara (5):
      ext4: Remove ext4 locking of moved directory
      Revert "f2fs: fix potential corruption when moving a directory"
      fs: Establish locking order for unrelated directories
      fs: Lock moved directories
      fs: no need to check source

Jarkko Sakkinen (1):
      tpm: tpm_vtpm_proxy: fix a race condition in /dev/vtpmx creation

Jason A. Donenfeld (2):
      wireguard: queueing: use saner cpu selection wrapping
      wireguard: netlink: send staged packets when setting initial private key

Jason Baron (1):
      md/raid0: add discard support for the 'original' layout

Jens Axboe (3):
      io_uring: ensure IOPOLL locks around deferred work
      io_uring: wait interruptibly for request completions on exit
      io_uring: add reschedule point to handle_tw_list()

Jeremy Sowden (1):
      lib/ts_bm: reset initial match offset for every block of text

Jesper Dangaard Brouer (2):
      igc: Enable and fix RX hash usage by netstack
      selftests/bpf: Fix check_mtu using wrong variable type

Jiaqing Zhao (1):
      Revert "8250: add support for ASIX devices with a FIFO bug"

Jiasheng Jiang (3):
      pstore/ram: Add check for kstrdup
      mfd: intel-lpss: Add missing check for platform_get_resource
      NTB: ntb_tool: Add check for devm_kcalloc

Jinhong Zhu (1):
      scsi: qedf: Fix NULL dereference in error handling

Jisheng Zhang (1):
      riscv: mm: fix truncation warning on RV32

Johan Hovold (1):
      mfd: pm8008: Fix module autoloading

Johannes Berg (2):
      wifi: iwlwifi: pull from TXQs with softirqs disabled
      wifi: iwlwifi: mvm: indicate HW decrypt for beacon protection

John Ogness (2):
      serial: 8250: lock port for stop_rx() in omap8250_irq()
      serial: 8250: lock port for UART_IER access in omap8250_irq()

John Paul Adrian Glaubitz (2):
      irqchip/jcore-aic: Fix missing allocation of IRQ descriptors
      sh: j2: Use ioremap() to translate device tree address into kernel memory

Jonas Gorski (2):
      spi: bcm-qspi: return error if neither hif_mspi nor mspi is available
      bus: ixp4xx: fix IXP4XX_EXP_T1_MASK

Jouni Högander (1):
      drm/i915/psr: Use hw.adjusted mode when calculating io/fast wake times

Joy Chakraborty (1):
      spi: dw: Round of n_bytes to power of 2

Juergen Gross (1):
      x86/mm: Fix __swp_entry_to_pte() for Xen PV guests

Junfeng Guo (1):
      gve: Set default duplex configuration to full

Junyan Ye (1):
      PCI: ftpci100: Release the clock resources

Kalesh AP (4):
      RDMA/bnxt_re: Fix to remove unnecessary return labels
      RDMA/bnxt_re: Use unique names while registering interrupts
      RDMA/bnxt_re: Remove a redundant check inside bnxt_re_update_gid
      RDMA/bnxt_re: Fix to remove an unnecessary log

Kashyap Desai (2):
      RDMA/bnxt_re: wraparound mbox producer index
      RDMA/bnxt_re: Avoid calling wake_up threads from spin_lock context

Keerthy (1):
      arm64: dts: ti: k3-j7200: Fix physical address of pin

Kees Cook (1):
      um: Use HOST_DIR for mrproper

Keith Busch (1):
      nvme-pci: remove nvme_queue from nvme_iod

Kemeng Shi (3):
      ext4: fix wrong unit use in ext4_mb_clear_bb
      ext4: get block from bh in ext4_free_blocks for fast commit replay
      ext4: fix wrong unit use in ext4_mb_new_blocks

Kiran K (1):
      ACPI: utils: Fix acpi_evaluate_dsm_typed() redefinition error

Klaus Kudielka (1):
      net: mvneta: fix txq_map in case of txq_number==1

Konrad Dybcio (1):
      drm/msm/dpu: Set DPU_DATA_HCTL_EN for in INTF_SC7180_MASK

Konstantin Komarov (1):
      fs/ntfs3: Check fields while reading

Kornel Dulęba (1):
      pinctrl: amd: Detect and mask spurious interrupts

Krishna Kurapati (1):
      usb: dwc3: gadget: Propagate core init errors to UDC during pullup

Krister Johansen (1):
      net: ena: fix shift-out-of-bounds in exponential backoff

Krzysztof Kozlowski (11):
      nfc: llcp: fix possible use of uninitialized variable in nfc_llcp_send_connect()
      nfc: llcp: simplify llcp_sock_connect() error paths
      arm64: dts: qcom: msm8916: correct camss unit address
      arm64: dts: qcom: msm8994: correct SPMI unit address
      arm64: dts: qcom: msm8996: correct camss unit address
      arm64: dts: qcom: sdm630: correct camss unit address
      arm64: dts: qcom: sdm845: correct camss unit address
      arm64: dts: qcom: apq8096: fix fixed regulator name property
      memory: brcmstb_dpfe: fix testing array offset after use
      ARM: dts: qcom: ipq4019: fix broken NAND controller properties override
      soundwire: qcom: fix storing port config out-of-bounds

Kumar Kartikeya Dwivedi (1):
      bpf: Fix max stack depth check for async callbacks

Kuniyuki Iwashima (3):
      gtp: Fix use-after-free in __gtp_encap_destroy().
      netlink: Add __sock_i_ino() for __netlink_diag_dump().
      icmp6: Fix null-ptr-deref of ip6_null_entry->rt6i_idev in icmp6_dev().

Laurent Vivier (4):
      hwrng: virtio - add an internal buffer
      hwrng: virtio - don't wait on cleanup
      hwrng: virtio - don't waste entropy
      hwrng: virtio - always add a pending request

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

Li Zhijian (1):
      rcuscale: Always log error message

Lin Ma (2):
      net: nfc: Fix use-after-free caused by nfc_llcp_find_local
      net/sched: act_pedit: Add size check for TCA_PEDIT_PARMS_EX

Linus Torvalds (1):
      workqueue: clean up WORK_* constant types, clarify masking

Liu Shixin (1):
      bootmem: remove the vmemmap pages from kmemleak in free_bootmem_page

Luc Ma (1):
      drm/vram-helper: fix function names in vram helper doc

Luca Weiss (1):
      Input: drv260x - sleep between polling GO bit

M A Ramdhan (1):
      net/sched: cls_fw: Fix improper refcount update leads to use-after-free

Manish Rangankar (1):
      scsi: qla2xxx: Remove unused nvme_ls_waitq wait queue

Manivannan Sadhasivam (1):
      PCI: qcom: Disable write access to read only registers for IP v2.3.3

Mantas Pucka (1):
      clk: qcom: gcc-ipq6018: Use floor ops for sdcc clocks

Marek Vasut (10):
      wifi: rsi: Do not configure WoWlan in shutdown hook if not enabled
      wifi: rsi: Do not set MMC_PM_KEEP_POWER in shutdown
      Input: adxl34x - do not hardcode interrupt trigger type
      ARM: dts: stm32: Move ethernet MAC EEPROM from SoM to carrier boards
      ARM: dts: stm32: Shorten the AV96 HDMI sound card name
      ARM: dts: stm32: Fix audio routing on STM32MP15xx DHCOM PDK2
      media: videodev2.h: Fix struct v4l2_input tuner index comment
      pwm: sysfs: Do not apply state to already disabled PWMs
      i2c: xiic: Defer xiic_wakeup() and __xiic_start_xfer() in xiic_process()
      drm/panel: simple: Add Powertip PH800480T013 drm_display_mode flags

Marijn Suijten (1):
      arm64: dts: qcom: sm8250-edo: Panel framebuffer is 2.5k instead of 4k

Mario Limonciello (4):
      pinctrl: amd: Fix mistake in handling clearing pins at startup
      pinctrl: amd: Detect internal GPIO0 debounce handling
      pinctrl: amd: Only use special debounce behavior for GPIO 0
      drm/amd/display: Correct `DMUB_FW_VERSION` macro

Mark Rutland (1):
      locking/atomic: arm: fix sync ops

Martin Blumenstingl (1):
      ARM: dts: meson8: correct uart_B and uart_C clock references

Martin Fuzzey (1):
      tty: serial: imx: fix rs485 rx after tx

Martin KaFai Lau (1):
      libbpf: btf_dump_type_data_check_overflow needs to consider BTF_MEMBER_BITFIELD_SIZE

Martin Kaiser (2):
      hwrng: st - keep clock enabled while hwrng is registered
      hwrng: imx-rngc - fix the timeout for init and self check

Masahiro Yamada (4):
      modpost: remove broken calculation of exception_table_entry size
      modpost: fix section mismatch message for R_ARM_ABS32
      modpost: fix section mismatch message for R_ARM_{PC24,CALL,JUMP24}
      ARC: define ASM_NL and __ALIGN(_STR) outside #ifdef __ASSEMBLY__ guard

Masami Hiramatsu (Google) (2):
      tracing/probes: Fix not to count error code to total length
      tracing/probes: Fix to update dynamic data counter if fetcharg uses it

Mateusz Stachyra (1):
      tracing: Fix null pointer dereference in tracing_err_log_open()

Matt Corallo (1):
      btrfs: add handling for RAID1C23/DUP to btrfs_reduce_alloc_profile

Matthieu Baerts (2):
      selftests: mptcp: sockopt: return error if wrong mark
      selftests: mptcp: depend on SYN_COOKIES

Max Filippov (1):
      xtensa: ISS: fix call to split_if_spec

Maxim Kochetkov (1):
      net: axienet: Move reset before 64-bit DMA detection

Michael Ellerman (1):
      powerpc/security: Fix Speculation_Store_Bypass reporting on Power10

Michael Schmitz (4):
      block: fix signed int overflow in Amiga partition support
      block: add overflow checks for Amiga partition support
      block: change all __u32 annotations to __be32 in affs_hardblocks.h
      block/partition: fix signedness issue for Amiga partitions

Mikulas Patocka (1):
      dm integrity: reduce vmalloc space footprint on 32-bit architectures

Ming Lei (1):
      nvme-pci: fix DMA direction of unmapping integrity data

Mingzhe Zou (1):
      bcache: fixup btree_cache_wait list damage

Mirsad Goran Todorovac (1):
      test_firmware: return ENOMEM instead of ENOSPC on failed memory allocation

Mohamed Khalfella (1):
      tracing/histograms: Add histograms to hist_vars if they have referenced variables

Moritz Fischer (1):
      net: lan743x: Don't sleep in atomic context

Muchun Song (1):
      kernfs: fix missing kernfs_idr_lock to remove an ID from the IDR

Muhammad Husaini Zulkifli (1):
      igc: Remove delay during TX ring configuration

Namhyung Kim (1):
      perf dwarf-aux: Fix off-by-one in die_get_varname()

Namjae Jeon (3):
      ksmbd: validate command payload size
      ksmbd: fix out-of-bound read in smb2_write
      ksmbd: validate session id and tree id in the compound request

Naohiro Aota (3):
      btrfs: delete unused BGs while reclaiming BGs
      btrfs: bail out reclaim process if filesystem is read-only
      btrfs: reinsert BGs failed to reclaim

Naveen N Rao (1):
      powerpc: Fail build if using recordmcount with binutils v2.37

Nicholas Kazlauskas (1):
      drm/amd/display: Explicitly specify update type per plane info change

Nicholas Piggin (2):
      powerpc/64s: Fix VAS mm use after free
      powerpc: simplify ppc_save_regs

Nick Child (1):
      ibmvnic: Do not reset dql stats on NON_FATAL err

Nico Boehr (1):
      KVM: s390: fix KVM_S390_GET_CMMA_BITS for GFNs in memslot holes

Nikita Zhandarovich (3):
      PM: domains: fix integer overflow issues in genpd_parse_state()
      radeon: avoid double free in ci_dpm_init()
      drm/radeon: fix possible division-by-zero errors

Nilesh Javali (3):
      scsi: qla2xxx: Array index may go out of bound
      scsi: qla2xxx: Avoid fcport pointer dereference
      scsi: qla2xxx: Check valid rport returned by fc_bsg_to_rport()

Nirmal Patel (1):
      PCI: vmd: Reset VMD config register between soft reboots

Nishanth Menon (1):
      mailbox: ti-msgmgr: Fill non-message tx data fields with 0x0

Nitya Sunkad (1):
      ionic: remove WARN_ON to prevent panic_on_warn

Nícolas F. R. A. Prado (1):
      arm64: dts: mediatek: mt8192: Fix CPUs capacity-dmips-mhz

Olga Kornievskaia (1):
      NFSv4.1: freeze the session table upon receiving NFS4ERR_BADSESSION

Olivier Moysan (1):
      ARM: dts: stm32: fix i2s endpoint format property for stm32mp15xx-dkx

Ondrej Zary (1):
      PCI/PM: Avoid putting EloPOS E2/S2/H2 PCIe Ports in D3cold

Pablo Neira Ayuso (2):
      netfilter: nf_tables: drop map element references from preparation phase
      netfilter: nf_tables: unbind non-anonymous set if rule construction fails

Paolo Abeni (1):
      net: prevent skb corruption on frag list segmentation

Paul E. McKenney (2):
      rcutorture: Correct name of use_softirq module parameter
      rcuscale: Move shutdown from wait_event() to wait_event_idle()

Pawel Dembicki (1):
      net: dsa: vsc73xx: fix MTU configuration

Pedro Tammela (4):
      net/sched: make psched_mtu() RTNL-less safe
      net/sched: sch_qfq: refactor parsing of netlink parameters
      net/sched: sch_qfq: account for stab overhead in qfq_enqueue
      net/sched: sch_qfq: reintroduce lmax bound check for MTU

Pengcheng Yang (1):
      samples/bpf: Fix buffer overflow in tcp_basertt

Peter Korsgaard (1):
      dm init: add dm-mod.waitfor to wait for asynchronously probed block devices

Peter Seiderer (1):
      wifi: ath9k: fix AR9003 mac hardware hang check register offset calculation

Phil Elwell (1):
      nvmem: rmem: Use NVMEM_DEVID_AUTO

Pierre Morel (1):
      KVM: s390: vsie: fix the length of APCB bitmap

Potin Lai (1):
      hwmon: (adm1275) Allow setting sample averaging

Prasad Koya (1):
      igc: set TP bit in 'supported' and 'advertising' fields of ethtool_link_ksettings

Prashanth K (2):
      usb: gadget: u_serial: Add null pointer check in gserial_suspend
      usb: common: usb-conn-gpio: Set last role to unknown before initial detection

Pu Lehui (2):
      bpf, riscv: Support riscv jit to provide bpf_line_info
      bpf: cpumap: Fix memory leak in cpu_map_update_elem

Qiuxu Zhuo (2):
      rcu/rcuscale: Move rcu_scale_*() after kfree_scale_cleanup()
      rcu/rcuscale: Stop kfree_scale_thread thread(s) after unloading rcuscale

Quinn Tran (2):
      scsi: qla2xxx: Wait for io return on terminate rport
      scsi: qla2xxx: Fix buffer overrun

Rafał Miłecki (2):
      ARM: dts: BCM5301X: Drop "clock-names" from the SPI node
      net: bgmac: postpone turning IRQs off to avoid SoC hangs

Ralph Boehme (1):
      ksmbd: use ksmbd_req_buf_next() in ksmbd_smb2_check_message()

Randy Dunlap (5):
      soc/fsl/qe: fix usb.c build errors
      crypto: nx - fix build warnings when DEBUG_FS is not enabled
      media: cec: i2c: ch7322: also select REGMAP
      powerpc: allow PPC_EARLY_DEBUG_CPM only when SERIAL_CPM=y
      wifi: airo: avoid uninitialized warning in airo_get_rate()

Ravi Bangoria (1):
      perf/ibs: Fix interface via core pmu events

Remi Pommarel (1):
      wifi: ath9k: Fix possible stall on ath9k_txq_list_has_key()

Ricardo Ribalda Delgado (2):
      ASoC: mediatek: mt8173: Fix irq error path
      ASoC: mediatek: mt8173: Fix snd_soc_component_initialize error path

Rick Wertenbroek (5):
      PCI: rockchip: Assert PCI Configuration Enable bit after probe
      PCI: rockchip: Write PCI Device ID to correct register
      PCI: rockchip: Add poll and timeout to wait for PHY PLLs to be locked
      PCI: rockchip: Fix legacy IRQ generation for RK3399 PCIe endpoint core
      PCI: rockchip: Use u32 variable to access 32-bit registers

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

Robin Murphy (2):
      perf/arm-cmn: Fix DTC reset
      PCI: Add function 1 DMA alias quirk for Marvell 88SE9235

Rongguang Wei (1):
      PCI: pciehp: Cancel bringup sequence if card is not present

Ryan Roberts (1):
      mm/damon/ops-common: atomically test and clear young on ptes and pmds

Sabrina Dubroca (1):
      selftests: rtnetlink: remove netdevsim device after ipsec offload test

Sami Tolvanen (1):
      kbuild: Disable GCOV for *.mod.o

Samuel Pitoiset (1):
      drm/amdgpu: fix clearing mappings for BOs that are always valid in VM

Sean Nyekjaer (2):
      iio: accel: fxls8962af: errata bug only applicable for FXLS8962AF
      iio: accel: fxls8962af: fixup buffer scan element type

Sebastian Andrzej Siewior (1):
      tracing/timer: Add missing hrtimer modes to decode_hrtimer_mode().

Selvin Xavier (1):
      RDMA/bnxt_re: Disable/kill tasklet only if it is enabled

Shawn Wang (1):
      x86/resctrl: Only show tasks' pid in current pid namespace

Sherry Sun (1):
      tty: serial: fsl_lpuart: add earlycon for imx8ulp platform

Shreyas Deodhar (1):
      scsi: qla2xxx: Pointer may be dereferenced

Shuai Jiang (1):
      i2c: qup: Add missing unwind goto in qup_i2c_probe()

Shuijing Li (1):
      pwm: mtk_disp: Fix the disable flow of disp_pwm

Siddh Raman Pant (1):
      jfs: jfs_dmap: Validate db_l2nbperpage while mounting

Siddharth Vadapalli (1):
      PCI: cadence: Fix Gen2 Link Retraining process

Sohaib Mohamed (1):
      perf bench: Use unbuffered output when pipe/tee'ing to a file

Stanislav Fomichev (1):
      bpf: Don't EFAULT for {g,s}setsockopt with wrong optlen

Stefan Wahren (1):
      w1: w1_therm: fix locking behavior in convert_t

Stephan Gerhold (7):
      arm64: dts: qcom: apq8016-sbc: Clarify firmware-names
      arm64: dts: qcom: Drop unneeded extra device-specific includes
      arm64: dts: qcom: apq8016-sbc: Fix regulator constraints
      arm64: dts: qcom: apq8016-sbc: Fix 1.8V power rail on LS expansion
      clk: qcom: reset: Allow specifying custom reset delay
      mfd: rt5033: Drop rt5033-battery sub-device
      opp: Fix use-after-free in lazy_opp_tables after probe deferral

Su Hui (1):
      ALSA: ac97: Fix possible NULL dereference in snd_ac97_mixer

Sui Jingfeng (1):
      PCI: Add pci_clear_master() stub for non-CONFIG_PCI

Suman Ghosh (1):
      octeontx2-pf: Add additional check for MCAM rules

Suzuki K Poulose (1):
      arm64: errata: Add detection for TRBE overwrite in FILL mode

Takashi Iwai (1):
      ALSA: jack: Fix mutex call in snd_jack_report()

Taniya Das (1):
      clk: qcom: camcc-sc7180: Add parent dependency to all camera GDSCs

Tarun Sahu (1):
      dax/kmem: Pass valid argument to memory_group_register_static

Tero Kristo (1):
      cpufreq: intel_pstate: Fix energy_performance_preference for passive

Thadeu Lima de Souza Cascardo (2):
      netfilter: nf_tables: do not ignore genmask when looking up chain by id
      netfilter: nf_tables: prevent OOB access in nft_byteorder_eval

Thomas Bogendoerfer (1):
      MIPS: kvm: Fix build error with KVM_MIPS_DEBUG_COP0_COUNTERS enabled

Thomas Gleixner (1):
      posix-timers: Prevent RT livelock in itimer_delete()

Thomas Hellström (1):
      drm/ttm: Don't leak a resource on swapout move error

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

Tobias Klauser (1):
      bpf: Omit superfluous address family check in __bpf_skc_lookup

Tony Lindgren (4):
      bus: ti-sysc: Fix dispc quirk masking bool variables
      ARM: dts: gta04: Move model property out of pinctrl node
      serial: 8250: omap: Fix freeing of resources on failed register
      serial: 8250_omap: Use force_suspend and resume for system suspend

Tvrtko Ursulin (1):
      drm/i915: Fix one wrong caching mode enum usage

Tzvetomir Stoyanov (VMware) (1):
      kernel/trace: Fix cleanup logic of enable_trace_eprobe

Ulf Hansson (1):
      mmc: mmci: Set PROBE_PREFER_ASYNCHRONOUS

Uwe Kleine-König (2):
      usb: dwc2: platform: Improve error reporting for problems during .remove()
      extcon: usbc-tusb320: Convert to i2c's .probe_new()

Vijaya Krishna Nivarthi (1):
      spi: spi-geni-qcom: Correct CS_TOGGLE bit in SPI_TRANS_CFG

Vincent Mailhol (1):
      can: length: fix bitstuffing count

Vinicius Costa Gomes (1):
      igc: Fix race condition in PTP tx code

Vinod Polimera (1):
      drm/msm/disp/dpu: get timing engine status from intf status register

Vlad Buslov (1):
      net/mlx5e: Check for NOT_READY flag state after locking

Vladimir Oltean (2):
      net: bridge: keep ports without IFF_UNICAST_FLT in BR_PROMISC mode
      net: dsa: tag_sja1105: fix MAC DA patching from meta frames

Vladislav Efanov (1):
      usb: dwc3: qcom: Fix potential memory leak

Weitao Wang (3):
      xhci: Fix resume issue of some ZHAOXIN hosts
      xhci: Fix TRB prefetch issue of ZHAOXIN hosts
      xhci: Show ZHAOXIN xHCI root hub speed correctly

Werner Sembach (1):
      ALSA: hda/realtek: Add quirk for Clevo NPx0SNx

Wesley Chalmers (1):
      drm/amd/display: Add logging for display MALL refresh setting

Wolfram Sang (1):
      arm64: dts: renesas: ulcb-kf: Remove flow control for SCIF1

Woody Zhang (1):
      riscv: move memblock_allow_resize() after linear mapping is ready

Xin Yin (1):
      erofs: fix fsdax unavailability for chunk-based regular files

Xiubo Li (1):
      ceph: don't let check_caps skip sending responses for revoke msgs

XuDong Liu (1):
      drm: sun4i_tcon: use devm_clk_get_enabled in `sun4i_tcon_init_clocks`

Yang Yingliang (1):
      NTB: ntb_transport: fix possible memory leak while device_register() fails

Yassine Oudjana (1):
      arm64: dts: qcom: db820c: Move blsp1_uart2 pin states to msm8996.dtsi

Yuan Can (4):
      clk: tegra: tegra124-emc: Fix potential memory leak
      ntb: idt: Fix error handling in idt_pci_driver_init()
      NTB: amd: Fix error handling in amd_ntb_pci_driver_init()
      ntb: intel: Fix error handling in intel_ntb_pci_driver_init()

Yuchen Yang (1):
      scsi: 3w-xxxx: Add error handling for initialization failure in tw_probe()

Yuxing Liu (1):
      clk: imx: clk-imx8mp: improve error handling in imx8mp_clocks_probe()

Zeng Heng (1):
      ntfs: Fix panic about slab-out-of-bounds caused by ntfs_listxattr()

Zhang Rui (1):
      powercap: RAPL: Fix CONFIG_IOSF_MBI dependency

Zhen Lei (1):
      kexec: fix a memory leak in crash_shrink_memory()

Zheng Wang (2):
      bcache: Remove unnecessary NULL point check in node allocations
      bcache: Fix __bch_btree_node_alloc to make the failure behavior consistent

Zheng Yejian (3):
      tracing: Fix memory leak of iter->temp when reading trace_pipe
      ring-buffer: Fix deadloop issue on reading trace_pipe
      ftrace: Fix possible warning on checking all pages used in ftrace_process_locs()

Zhengchao Shao (2):
      net/mlx5e: fix double free in mlx5e_destroy_flow_table
      net/mlx5e: fix memory leak in mlx5e_ptp_open

Zhihao Cheng (2):
      ovl: fix null pointer dereference in ovl_get_acl_rcu()
      ext4: Fix reusing stale buffer heads from last failed mounting

Ziyang Xuan (1):
      ipv6/addrconf: fix a potential refcount underflow for idev

gaba (1):
      drm/amdgpu: avoid restore process run into dead loop.

hfdevel@gmx.net (1):
      ARM: dts: meson8b: correct uart_B and uart_C clock references

