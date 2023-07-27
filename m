Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B96764865
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjG0HVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjG0HUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:20:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B7B49C5;
        Thu, 27 Jul 2023 00:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B09C61D7B;
        Thu, 27 Jul 2023 07:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C889AC433C9;
        Thu, 27 Jul 2023 07:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690442016;
        bh=QDmzTO9YxOiP9Q4WTsKD7yPXWw5ieMcsTfbtt/hLa34=;
        h=From:To:Cc:Subject:Date:From;
        b=yQ/bpyOJKnnxZVZERDXeB1KZTRmkyWjp0tn8Xo5AvqoJd+FicbX+SVZbo0nwanSBE
         IkFYQIhD36wgBxh1lHHaqE8EO5jPB5djjFEnSAiZpP8nDUitLlI+wYbjJChBu5shoC
         3v+4YELppezkd1veUxMkXpwQDMbqXoWRJbE4n8xM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.188
Date:   Thu, 27 Jul 2023 09:13:25 +0200
Message-ID: <2023072726-capsize-reprise-ffda@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.10.188 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/filesystems/autofs-mount-control.rst        |    2 
 Documentation/filesystems/autofs.rst                      |    2 
 Documentation/filesystems/directory-locking.rst           |   26 
 Documentation/networking/af_xdp.rst                       |    9 
 Documentation/networking/ip-sysctl.rst                    |   25 
 Makefile                                                  |    2 
 arch/alpha/include/asm/pgtable.h                          |    8 
 arch/arc/include/asm/linkage.h                            |    8 
 arch/arm/boot/dts/bcm53015-meraki-mr26.dts                |    2 
 arch/arm/boot/dts/bcm53016-meraki-mr32.dts                |    2 
 arch/arm/boot/dts/bcm5301x.dtsi                           |    1 
 arch/arm/boot/dts/iwg20d-q7-common.dtsi                   |    2 
 arch/arm/boot/dts/meson8.dtsi                             |    4 
 arch/arm/boot/dts/meson8b.dtsi                            |    4 
 arch/arm/boot/dts/omap3-gta04a5one.dts                    |    4 
 arch/arm/boot/dts/stm32mp15xx-dhcom-pdk2.dtsi             |   11 
 arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi        |    8 
 arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi              |    6 
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi                    |    2 
 arch/arm/include/asm/pgtable-3level.h                     |    2 
 arch/arm/mach-ep93xx/timer-ep93xx.c                       |    3 
 arch/arm/mach-omap2/board-generic.c                       |    1 
 arch/arm/mach-orion5x/board-dt.c                          |    3 
 arch/arm/mach-orion5x/common.h                            |    6 
 arch/arm/probes/kprobes/checkers-common.c                 |    2 
 arch/arm/probes/kprobes/core.c                            |    2 
 arch/arm/probes/kprobes/opt-arm.c                         |    2 
 arch/arm/probes/kprobes/test-core.c                       |    2 
 arch/arm/probes/kprobes/test-core.h                       |    4 
 arch/arm64/boot/dts/microchip/sparx5.dtsi                 |    2 
 arch/arm64/boot/dts/microchip/sparx5_pcb_common.dtsi      |   12 
 arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts              |    4 
 arch/arm64/boot/dts/qcom/msm8916.dtsi                     |    2 
 arch/arm64/boot/dts/qcom/msm8994.dtsi                     |    2 
 arch/arm64/boot/dts/qcom/msm8996.dtsi                     |    2 
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi                  |    3 
 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts     |   28 
 arch/arm64/include/asm/exception.h                        |    5 
 arch/arm64/include/asm/pgtable.h                          |    8 
 arch/arm64/mm/mmu.c                                       |    4 
 arch/ia64/include/asm/pgtable.h                           |    4 
 arch/m68k/include/asm/motorola_pgtable.h                  |    2 
 arch/mips/include/asm/pgtable-64.h                        |    8 
 arch/mips/kernel/cpu-probe.c                              |    9 
 arch/parisc/include/asm/pgtable.h                         |    4 
 arch/powerpc/Kconfig.debug                                |    2 
 arch/powerpc/Makefile                                     |    8 
 arch/powerpc/include/asm/book3s/64/pgtable.h              |   11 
 arch/powerpc/include/asm/nohash/64/pgtable-4k.h           |    6 
 arch/powerpc/include/asm/nohash/64/pgtable.h              |    6 
 arch/powerpc/mm/book3s64/radix_pgtable.c                  |   40 
 arch/powerpc/mm/init_64.c                                 |    2 
 arch/powerpc/mm/pgtable_64.c                              |    4 
 arch/powerpc/platforms/powernv/pci-sriov.c                |    6 
 arch/riscv/include/asm/pgtable-64.h                       |    4 
 arch/riscv/net/bpf_jit.h                                  |    5 
 arch/riscv/net/bpf_jit_comp64.c                           |   13 
 arch/riscv/net/bpf_jit_core.c                             |   29 
 arch/s390/Makefile                                        |    1 
 arch/s390/kvm/kvm-s390.c                                  |    4 
 arch/s390/kvm/vsie.c                                      |    6 
 arch/sh/drivers/dma/dma-sh.c                              |   37 
 arch/sh/include/asm/pgtable-3level.h                      |    4 
 arch/sh/kernel/cpu/sh2/probe.c                            |    2 
 arch/sparc/include/asm/pgtable_32.h                       |    6 
 arch/sparc/include/asm/pgtable_64.h                       |   10 
 arch/um/Makefile                                          |    2 
 arch/um/include/asm/pgtable-3level.h                      |    2 
 arch/x86/events/amd/core.c                                |    2 
 arch/x86/events/amd/ibs.c                                 |   53 -
 arch/x86/include/asm/perf_event.h                         |    2 
 arch/x86/include/asm/pgtable.h                            |    8 
 arch/x86/include/asm/pgtable_64.h                         |    4 
 arch/x86/kernel/cpu/resctrl/rdtgroup.c                    |    8 
 arch/x86/kernel/smpboot.c                                 |   24 
 arch/x86/mm/init_64.c                                     |    4 
 arch/x86/mm/pat/set_memory.c                              |    4 
 arch/x86/mm/pgtable.c                                     |    2 
 arch/xtensa/platforms/iss/network.c                       |    2 
 block/blk-iocost.c                                        |    7 
 block/partitions/amiga.c                                  |  104 +-
 drivers/acpi/button.c                                     |    9 
 drivers/acpi/video_detect.c                               |   16 
 drivers/base/power/domain.c                               |    6 
 drivers/base/regmap/regmap-i2c.c                          |    8 
 drivers/base/regmap/regmap-spi-avmm.c                     |    2 
 drivers/base/regmap/regmap.c                              |    6 
 drivers/block/nbd.c                                       |    3 
 drivers/bus/ti-sysc.c                                     |    4 
 drivers/char/hw_random/imx-rngc.c                         |    6 
 drivers/char/hw_random/st-rng.c                           |   21 
 drivers/char/hw_random/virtio-rng.c                       |   88 +
 drivers/char/tpm/tpm_tis_core.c                           |    2 
 drivers/char/tpm/tpm_vtpm_proxy.c                         |   30 
 drivers/clk/clk-cdce925.c                                 |   12 
 drivers/clk/clk-si5341.c                                  |  242 ++++
 drivers/clk/clk-versaclock5.c                             |   29 
 drivers/clk/imx/clk-imx8mn.c                              |    8 
 drivers/clk/imx/clk-imx8mp.c                              |   24 
 drivers/clk/keystone/sci-clk.c                            |    2 
 drivers/clk/qcom/gcc-ipq6018.c                            |   34 
 drivers/clk/qcom/reset.c                                  |    8 
 drivers/clk/qcom/reset.h                                  |    2 
 drivers/clk/tegra/clk-tegra124-emc.c                      |    2 
 drivers/clk/ti/clkctrl.c                                  |    7 
 drivers/clocksource/timer-cadence-ttc.c                   |   19 
 drivers/cpufreq/intel_pstate.c                            |    2 
 drivers/crypto/marvell/cesa/cipher.c                      |    2 
 drivers/crypto/nx/Makefile                                |    2 
 drivers/crypto/nx/nx.h                                    |    4 
 drivers/dax/bus.c                                         |   61 -
 drivers/dax/dax-private.h                                 |    4 
 drivers/extcon/extcon.c                                   |    8 
 drivers/firmware/stratix10-svc.c                          |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                    |   20 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c           |   13 
 drivers/gpu/drm/amd/display/dc/core/dc.c                  |    3 
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h               |    2 
 drivers/gpu/drm/bridge/tc358768.c                         |   93 +
 drivers/gpu/drm/drm_atomic.c                              |   11 
 drivers/gpu/drm/drm_atomic_helper.c                       |   11 
 drivers/gpu/drm/drm_client_modeset.c                      |    6 
 drivers/gpu/drm/drm_gem_vram_helper.c                     |    6 
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c                  |    5 
 drivers/gpu/drm/msm/dp/dp_display.c                       |    2 
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c           |   11 
 drivers/gpu/drm/panel/panel-simple.c                      |    6 
 drivers/gpu/drm/radeon/ci_dpm.c                           |   28 
 drivers/gpu/drm/radeon/cypress_dpm.c                      |    8 
 drivers/gpu/drm/radeon/ni_dpm.c                           |    8 
 drivers/gpu/drm/radeon/rv740_dpm.c                        |    8 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c               |    8 
 drivers/gpu/drm/sun4i/sun4i_tcon.c                        |   19 
 drivers/hid/hid-logitech-hidpp.c                          |    2 
 drivers/hid/wacom_wac.c                                   |    6 
 drivers/hid/wacom_wac.h                                   |    2 
 drivers/hwmon/gsc-hwmon.c                                 |    6 
 drivers/hwmon/pmbus/adm1275.c                             |   96 +
 drivers/hwtracing/coresight/coresight-core.c              |    9 
 drivers/i2c/busses/i2c-qup.c                              |   21 
 drivers/i2c/busses/i2c-xiic.c                             |   39 
 drivers/iio/adc/meson_saradc.c                            |    2 
 drivers/infiniband/core/cma.c                             |   23 
 drivers/infiniband/core/cma_priv.h                        |    1 
 drivers/infiniband/core/device.c                          |   11 
 drivers/infiniband/core/uverbs_cmd.c                      |    2 
 drivers/infiniband/hw/bnxt_re/main.c                      |   20 
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                  |   40 
 drivers/infiniband/hw/bnxt_re/qplib_fp.h                  |    2 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c                |   46 
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h                |    1 
 drivers/infiniband/hw/efa/efa_main.c                      |    3 
 drivers/infiniband/hw/hfi1/ipoib_tx.c                     |    4 
 drivers/infiniband/hw/hfi1/mmu_rb.c                       |  101 +-
 drivers/infiniband/hw/hfi1/mmu_rb.h                       |    3 
 drivers/infiniband/hw/hfi1/sdma.c                         |   27 
 drivers/infiniband/hw/hfi1/sdma.h                         |   62 -
 drivers/infiniband/hw/hfi1/sdma_txreq.h                   |    2 
 drivers/infiniband/hw/hfi1/user_sdma.c                    |  145 +-
 drivers/infiniband/hw/hfi1/user_sdma.h                    |    1 
 drivers/infiniband/hw/hfi1/vnic_sdma.c                    |    4 
 drivers/infiniband/hw/hns/hns_roce_cmd.c                  |   27 
 drivers/infiniband/hw/hns/hns_roce_cmd.h                  |    4 
 drivers/infiniband/hw/hns/hns_roce_cq.c                   |    2 
 drivers/infiniband/hw/hns/hns_roce_device.h               |    2 
 drivers/infiniband/hw/hns/hns_roce_hem.c                  |  131 --
 drivers/infiniband/hw/hns/hns_roce_hem.h                  |   15 
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c                |   93 +
 drivers/infiniband/hw/hns/hns_roce_hw_v1.h                |    7 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                |    9 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h                |    6 
 drivers/infiniband/hw/hns/hns_roce_main.c                 |    8 
 drivers/infiniband/hw/hns/hns_roce_mr.c                   |    4 
 drivers/infiniband/hw/hns/hns_roce_qp.c                   |    2 
 drivers/infiniband/hw/hns/hns_roce_srq.c                  |    1 
 drivers/infiniband/hw/mlx4/main.c                         |   14 
 drivers/infiniband/hw/mlx5/main.c                         |   14 
 drivers/input/misc/adxl34x.c                              |    3 
 drivers/input/misc/drv260x.c                              |    1 
 drivers/irqchip/irq-jcore-aic.c                           |   11 
 drivers/leds/trigger/ledtrig-netdev.c                     |    3 
 drivers/mailbox/ti-msgmgr.c                               |   12 
 drivers/md/bcache/btree.c                                 |   25 
 drivers/md/bcache/btree.h                                 |    1 
 drivers/md/bcache/super.c                                 |    4 
 drivers/md/bcache/writeback.c                             |   10 
 drivers/md/md-bitmap.c                                    |   17 
 drivers/md/md.c                                           |   23 
 drivers/md/raid0.c                                        |   62 +
 drivers/md/raid0.h                                        |    1 
 drivers/md/raid10.c                                       |   38 
 drivers/media/cec/i2c/Kconfig                             |    1 
 drivers/media/platform/qcom/venus/helpers.c               |    4 
 drivers/media/usb/dvb-usb-v2/az6007.c                     |    3 
 drivers/media/usb/siano/smsusb.c                          |    3 
 drivers/memory/brcmstb_dpfe.c                             |    4 
 drivers/memstick/host/r592.c                              |    4 
 drivers/mfd/intel-lpss-acpi.c                             |    3 
 drivers/mfd/rt5033.c                                      |    3 
 drivers/mfd/stmfx.c                                       |    7 
 drivers/mfd/stmpe.c                                       |    4 
 drivers/misc/fastrpc.c                                    |    2 
 drivers/misc/pci_endpoint_test.c                          |   10 
 drivers/mmc/core/quirks.h                                 |   14 
 drivers/mmc/host/mmci.c                                   |    1 
 drivers/mmc/host/sdhci.c                                  |    4 
 drivers/mtd/nand/raw/meson_nand.c                         |    4 
 drivers/net/dsa/vitesse-vsc73xx-core.c                    |    6 
 drivers/net/ethernet/amazon/ena/ena_com.c                 |    3 
 drivers/net/ethernet/broadcom/bgmac.c                     |    4 
 drivers/net/ethernet/broadcom/genet/bcmmii.c              |    2 
 drivers/net/ethernet/broadcom/tg3.c                       |    1 
 drivers/net/ethernet/google/gve/gve_ethtool.c             |    3 
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c            |    2 
 drivers/net/ethernet/intel/iavf/iavf_main.c               |    5 
 drivers/net/ethernet/intel/igb/igb_main.c                 |    5 
 drivers/net/ethernet/intel/igc/igc.h                      |   33 
 drivers/net/ethernet/intel/igc/igc_ethtool.c              |    2 
 drivers/net/ethernet/intel/igc/igc_main.c                 |   45 
 drivers/net/ethernet/intel/igc/igc_ptp.c                  |   57 -
 drivers/net/ethernet/marvell/mvneta.c                     |    4 
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h           |   11 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cgx.c       |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c      |    5 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c           |    6 
 drivers/net/ethernet/microchip/lan743x_main.c             |   21 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c           |    5 
 drivers/net/ethernet/sfc/ef10.c                           |   13 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c         |    6 
 drivers/net/ethernet/ti/cpsw_ale.c                        |   24 
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c         |   10 
 drivers/net/gtp.c                                         |    2 
 drivers/net/ipvlan/ipvlan_core.c                          |    9 
 drivers/net/netdevsim/dev.c                               |    9 
 drivers/net/phy/phy_device.c                              |   21 
 drivers/net/ppp/pptp.c                                    |   31 
 drivers/net/wireguard/netlink.c                           |   14 
 drivers/net/wireguard/queueing.c                          |    1 
 drivers/net/wireguard/queueing.h                          |   25 
 drivers/net/wireguard/receive.c                           |    2 
 drivers/net/wireguard/send.c                              |    2 
 drivers/net/wireless/ath/ath11k/mac.c                     |    2 
 drivers/net/wireless/ath/ath9k/ar9003_hw.c                |   27 
 drivers/net/wireless/ath/ath9k/htc_hst.c                  |    8 
 drivers/net/wireless/ath/ath9k/main.c                     |   11 
 drivers/net/wireless/ath/ath9k/wmi.c                      |    4 
 drivers/net/wireless/atmel/atmel_cs.c                     |   13 
 drivers/net/wireless/cisco/airo.c                         |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c              |    5 
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c              |    2 
 drivers/net/wireless/intersil/orinoco/orinoco_cs.c        |   13 
 drivers/net/wireless/intersil/orinoco/spectrum_cs.c       |   13 
 drivers/net/wireless/marvell/mwifiex/scan.c               |    6 
 drivers/net/wireless/microchip/wilc1000/hif.c             |    8 
 drivers/net/wireless/ray_cs.c                             |   36 
 drivers/net/wireless/rsi/rsi_91x_sdio.c                   |    9 
 drivers/net/wireless/wl3501_cs.c                          |   27 
 drivers/ntb/hw/amd/ntb_hw_amd.c                           |    7 
 drivers/ntb/hw/idt/ntb_hw_idt.c                           |    7 
 drivers/ntb/hw/intel/ntb_hw_gen1.c                        |    7 
 drivers/ntb/ntb_transport.c                               |    2 
 drivers/ntb/test/ntb_tool.c                               |    2 
 drivers/nubus/proc.c                                      |   22 
 drivers/nvme/host/pci.c                                   |    3 
 drivers/pci/controller/cadence/pcie-cadence-host.c        |   27 
 drivers/pci/controller/dwc/pcie-qcom.c                    |    2 
 drivers/pci/controller/pci-ftpci100.c                     |   14 
 drivers/pci/controller/pcie-rockchip-ep.c                 |   65 -
 drivers/pci/controller/pcie-rockchip.c                    |   17 
 drivers/pci/controller/pcie-rockchip.h                    |   11 
 drivers/pci/hotplug/pciehp_ctrl.c                         |    8 
 drivers/pci/pci.c                                         |   10 
 drivers/pci/pcie/aspm.c                                   |   21 
 drivers/pci/quirks.c                                      |    2 
 drivers/perf/arm-cmn.c                                    |    7 
 drivers/phy/tegra/xusb.c                                  |    4 
 drivers/pinctrl/bcm/pinctrl-bcm2835.c                     |    6 
 drivers/pinctrl/intel/pinctrl-cherryview.c                |   15 
 drivers/pinctrl/pinctrl-amd.c                             |   41 
 drivers/pinctrl/pinctrl-amd.h                             |    1 
 drivers/pinctrl/pinctrl-at91-pio4.c                       |    2 
 drivers/platform/x86/wmi.c                                |   64 -
 drivers/powercap/Kconfig                                  |    4 
 drivers/powercap/intel_rapl_msr.c                         |    1 
 drivers/pwm/pwm-imx-tpm.c                                 |    7 
 drivers/pwm/sysfs.c                                       |   17 
 drivers/regulator/core.c                                  |   30 
 drivers/rtc/rtc-st-lpc.c                                  |    2 
 drivers/s390/net/qeth_l3_sys.c                            |    2 
 drivers/scsi/3w-xxxx.c                                    |    4 
 drivers/scsi/qedf/qedf_main.c                             |    3 
 drivers/scsi/qla2xxx/qla_attr.c                           |   13 
 drivers/scsi/qla2xxx/qla_bsg.c                            |    6 
 drivers/scsi/qla2xxx/qla_def.h                            |    1 
 drivers/scsi/qla2xxx/qla_init.c                           |    2 
 drivers/scsi/qla2xxx/qla_inline.h                         |    5 
 drivers/scsi/qla2xxx/qla_iocb.c                           |    5 
 drivers/scsi/qla2xxx/qla_nvme.c                           |    3 
 drivers/scsi/qla2xxx/qla_os.c                             |    3 
 drivers/soc/amlogic/meson-secure-pwrc.c                   |    2 
 drivers/soc/fsl/qe/Kconfig                                |    1 
 drivers/spi/spi-bcm-qspi.c                                |   10 
 drivers/spi/spi-bcm63xx.c                                 |    2 
 drivers/spi/spi-geni-qcom.c                               |    2 
 drivers/staging/media/atomisp/pci/atomisp_cmd.c           |    3 
 drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c |    2 
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c         |    3 
 drivers/thermal/mtk_thermal.c                             |   14 
 drivers/thermal/sun8i_thermal.c                           |   55 -
 drivers/tty/serial/8250/8250.h                            |    1 
 drivers/tty/serial/8250/8250_omap.c                       |   25 
 drivers/tty/serial/8250/8250_pci.c                        |   19 
 drivers/tty/serial/8250/8250_port.c                       |   11 
 drivers/tty/serial/atmel_serial.c                         |    4 
 drivers/tty/serial/fsl_lpuart.c                           |    1 
 drivers/tty/serial/samsung_tty.c                          |   14 
 drivers/usb/core/devio.c                                  |    2 
 drivers/usb/dwc3/dwc3-meson-g12a.c                        |    5 
 drivers/usb/dwc3/dwc3-qcom.c                              |   17 
 drivers/usb/dwc3/gadget.c                                 |    4 
 drivers/usb/gadget/function/u_serial.c                    |   13 
 drivers/usb/host/xhci-mem.c                               |   39 
 drivers/usb/host/xhci-pci.c                               |   12 
 drivers/usb/host/xhci.h                                   |    2 
 drivers/usb/phy/phy-tahvo.c                               |    2 
 drivers/usb/serial/option.c                               |    4 
 drivers/video/fbdev/au1200fb.c                            |    3 
 drivers/video/fbdev/imsttfb.c                             |   36 
 drivers/video/fbdev/imxfb.c                               |    4 
 drivers/video/fbdev/omap/lcd_mipid.c                      |    6 
 drivers/w1/slaves/w1_therm.c                              |   31 
 drivers/w1/w1.c                                           |    4 
 fs/btrfs/block-group.c                                    |    9 
 fs/btrfs/disk-io.c                                        |    3 
 fs/btrfs/qgroup.c                                         |    3 
 fs/ceph/caps.c                                            |    9 
 fs/dlm/plock.c                                            |    4 
 fs/erofs/zdata.c                                          |    2 
 fs/erofs/zmap.c                                           |    6 
 fs/ext4/indirect.c                                        |    8 
 fs/ext4/inode.c                                           |   10 
 fs/ext4/mballoc.c                                         |   17 
 fs/ext4/namei.c                                           |   17 
 fs/ext4/super.c                                           |   13 
 fs/ext4/xattr.c                                           |   14 
 fs/f2fs/f2fs.h                                            |    2 
 fs/f2fs/file.c                                            |    2 
 fs/f2fs/gc.c                                              |   22 
 fs/f2fs/namei.c                                           |   16 
 fs/f2fs/node.c                                            |    4 
 fs/fs_context.c                                           |    3 
 fs/fuse/dir.c                                             |    2 
 fs/inode.c                                                |   42 
 fs/internal.h                                             |    2 
 fs/jffs2/build.c                                          |    5 
 fs/jffs2/xattr.c                                          |   13 
 fs/jffs2/xattr.h                                          |    4 
 fs/jfs/jfs_dmap.c                                         |    6 
 fs/jfs/jfs_filsys.h                                       |    2 
 fs/kernfs/dir.c                                           |    2 
 fs/namei.c                                                |   25 
 fs/nfs/nfs4proc.c                                         |    1 
 fs/nfsd/nfs4xdr.c                                         |    2 
 fs/notify/fanotify/fanotify_user.c                        |   22 
 fs/overlayfs/copy_up.c                                    |    2 
 fs/overlayfs/dir.c                                        |    3 
 fs/overlayfs/export.c                                     |    3 
 fs/overlayfs/namei.c                                      |    3 
 fs/overlayfs/overlayfs.h                                  |    6 
 fs/overlayfs/super.c                                      |    2 
 fs/overlayfs/util.c                                       |   24 
 fs/pstore/ram_core.c                                      |    2 
 fs/ramfs/inode.c                                          |    2 
 include/asm-generic/pgtable-nop4d.h                       |    2 
 include/asm-generic/pgtable-nopmd.h                       |    2 
 include/asm-generic/pgtable-nopud.h                       |    2 
 include/linux/bpf-cgroup.h                                |   27 
 include/linux/etherdevice.h                               |   12 
 include/linux/indirect_call_wrapper.h                     |    6 
 include/linux/netdevice.h                                 |   18 
 include/linux/nmi.h                                       |    2 
 include/linux/pci.h                                       |    1 
 include/linux/pgtable.h                                   |    4 
 include/linux/pipe_fs_i.h                                 |    4 
 include/linux/ramfs.h                                     |    1 
 include/linux/sched/signal.h                              |    2 
 include/linux/serial_8250.h                               |    1 
 include/linux/tcp.h                                       |    2 
 include/linux/workqueue.h                                 |   15 
 include/net/netfilter/nf_tables.h                         |   41 
 include/net/netns/ipv4.h                                  |    1 
 include/net/netns/nftables.h                              |    7 
 include/net/nfc/nfc.h                                     |    4 
 include/net/pkt_sched.h                                   |    2 
 include/net/sock.h                                        |    3 
 include/net/tcp.h                                         |   32 
 include/trace/events/timer.h                              |    6 
 include/uapi/linux/affs_hardblocks.h                      |   68 -
 include/uapi/linux/auto_dev-ioctl.h                       |    2 
 include/uapi/linux/videodev2.h                            |    2 
 io_uring/io_uring.c                                       |   66 +
 kernel/bpf/bpf_lru_list.c                                 |   21 
 kernel/bpf/bpf_lru_list.h                                 |    7 
 kernel/bpf/cgroup.c                                       |   46 
 kernel/kcsan/core.c                                       |    2 
 kernel/kexec_core.c                                       |    5 
 kernel/rcu/rcuscale.c                                     |  214 ++--
 kernel/rcu/tasks.h                                        |   37 
 kernel/sched/fair.c                                       |    2 
 kernel/time/posix-timers.c                                |   74 +
 kernel/trace/ftrace.c                                     |   72 -
 kernel/trace/ring_buffer.c                                |   24 
 kernel/trace/trace.c                                      |    3 
 kernel/trace/trace_events_hist.c                          |    9 
 kernel/trace/trace_probe_tmpl.h                           |    2 
 kernel/watchdog_hld.c                                     |    6 
 kernel/workqueue.c                                        |   13 
 lib/debugobjects.c                                        |    9 
 lib/test_firmware.c                                       |   12 
 lib/ts_bm.c                                               |    4 
 mm/shmem.c                                                |    2 
 net/bridge/br_if.c                                        |    5 
 net/bridge/br_stp_if.c                                    |    3 
 net/can/bcm.c                                             |   12 
 net/can/isotp.c                                           |    5 
 net/core/devlink.c                                        |    5 
 net/core/rtnetlink.c                                      |  104 +-
 net/core/skbuff.c                                         |    5 
 net/core/sock.c                                           |   17 
 net/dsa/tag_sja1105.c                                     |    4 
 net/ipv4/esp4.c                                           |    2 
 net/ipv4/inet_connection_sock.c                           |    3 
 net/ipv4/inet_hashtables.c                                |   17 
 net/ipv4/inet_timewait_sock.c                             |    8 
 net/ipv4/sysctl_net_ipv4.c                                |    9 
 net/ipv4/tcp.c                                            |   68 -
 net/ipv4/tcp_fastopen.c                                   |    6 
 net/ipv4/tcp_input.c                                      |   12 
 net/ipv4/tcp_ipv4.c                                       |    3 
 net/ipv4/tcp_minisocks.c                                  |    9 
 net/ipv4/tcp_output.c                                     |    2 
 net/ipv4/tcp_timer.c                                      |   10 
 net/ipv6/addrconf.c                                       |    3 
 net/ipv6/icmp.c                                           |    5 
 net/ipv6/ip6_gre.c                                        |    3 
 net/ipv6/tcp_ipv6.c                                       |    3 
 net/ipv6/udp.c                                            |    2 
 net/llc/llc_input.c                                       |    3 
 net/netfilter/nf_conntrack_helper.c                       |    4 
 net/netfilter/nf_conntrack_proto_dccp.c                   |   52 +
 net/netfilter/nf_conntrack_sip.c                          |    2 
 net/netfilter/nf_tables_api.c                             |  681 +++++++++-----
 net/netfilter/nf_tables_offload.c                         |   30 
 net/netfilter/nft_byteorder.c                             |   14 
 net/netfilter/nft_chain_filter.c                          |   11 
 net/netfilter/nft_dynset.c                                |    6 
 net/netfilter/nft_immediate.c                             |   90 +
 net/netfilter/nft_set_bitmap.c                            |    5 
 net/netfilter/nft_set_hash.c                              |   23 
 net/netfilter/nft_set_pipapo.c                            |   20 
 net/netfilter/nft_set_rbtree.c                            |    5 
 net/netlink/af_netlink.c                                  |    5 
 net/netlink/diag.c                                        |    7 
 net/nfc/core.c                                            |    4 
 net/nfc/hci/llc_shdlc.c                                   |   10 
 net/nfc/llcp.h                                            |    9 
 net/nfc/llcp_commands.c                                   |   59 -
 net/nfc/llcp_core.c                                       |   93 +
 net/nfc/llcp_sock.c                                       |   21 
 net/nfc/netlink.c                                         |   20 
 net/nfc/nfc.h                                             |    3 
 net/sched/act_pedit.c                                     |    1 
 net/sched/cls_flower.c                                    |   10 
 net/sched/cls_fw.c                                        |   10 
 net/sched/sch_qfq.c                                       |   41 
 net/sctp/socket.c                                         |   22 
 net/socket.c                                              |    3 
 net/sunrpc/svcsock.c                                      |   23 
 net/wireless/scan.c                                       |  213 ++--
 net/wireless/wext-core.c                                  |    6 
 net/xdp/xsk.c                                             |    5 
 samples/bpf/tcp_basertt_kern.c                            |    2 
 samples/ftrace/ftrace-direct-too.c                        |   14 
 scripts/mod/modpost.c                                     |   26 
 scripts/tags.sh                                           |    9 
 security/apparmor/policy_unpack.c                         |    9 
 security/integrity/evm/evm_main.c                         |    2 
 security/integrity/iint.c                                 |   15 
 security/integrity/ima/ima_modsig.c                       |    3 
 security/integrity/ima/ima_policy.c                       |    3 
 security/keys/request_key.c                               |   35 
 security/keys/trusted-keys/trusted_tpm2.c                 |    2 
 sound/core/jack.c                                         |   15 
 sound/pci/ac97/ac97_codec.c                               |    4 
 sound/pci/hda/patch_realtek.c                             |   28 
 sound/soc/codecs/es8316.c                                 |   23 
 sound/soc/fsl/fsl_sai.c                                   |    2 
 sound/soc/fsl/fsl_sai.h                                   |    1 
 sound/soc/fsl/imx-audmix.c                                |    9 
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c                |   13 
 tools/bpf/bpftool/feature.c                               |   24 
 tools/include/uapi/linux/tcp.h                            |  357 +++++++
 tools/lib/bpf/bpf_helpers.h                               |   15 
 tools/perf/builtin-bench.c                                |    7 
 tools/perf/builtin-script.c                               |   34 
 tools/perf/tests/builtin-test.c                           |    3 
 tools/perf/tests/shell/test_uprobe_from_different_cu.sh   |   77 +
 tools/perf/util/dwarf-aux.c                               |    2 
 tools/testing/selftests/bpf/prog_tests/bpf_tcp_ca.c       |    1 
 tools/testing/selftests/bpf/prog_tests/cls_redirect.c     |    1 
 tools/testing/selftests/bpf/prog_tests/sockmap_basic.c    |    1 
 tools/testing/selftests/bpf/prog_tests/sockopt_sk.c       |   28 
 tools/testing/selftests/bpf/progs/sockopt_sk.c            |   23 
 tools/testing/selftests/bpf/test_progs.h                  |    1 
 tools/testing/selftests/bpf/test_verifier.c               |   12 
 tools/testing/selftests/bpf/verifier/spill_fill.c         |   30 
 tools/testing/selftests/net/rtnetlink.sh                  |    1 
 tools/testing/selftests/tc-testing/config                 |    1 
 tools/testing/selftests/tc-testing/settings               |    1 
 tools/testing/selftests/wireguard/netns.sh                |   30 
 521 files changed, 5599 insertions(+), 2681 deletions(-)

Ahmed S. Darwish (1):
      scripts/tags.sh: Resolve gtags empty index generation

Alan Maguire (1):
      bpftool: JIT limited misreported as negative value on aarch64

Alexander Aring (1):
      fs: dlm: return positive pid value for F_GETLK

Alexander Mikhalitsyn (1):
      sctp: add bpf_bypass_getsockopt proto callback

Alexey Romanov (1):
      drivers: meson: secure-pwrc: always enable DMA domain

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

Andy Shevchenko (6):
      wifi: ray_cs: Utilize strnlen() in parse_addr()
      wifi: ray_cs: Drop useless status variable in parse_addr()
      pinctrl: cherryview: Return correct value if pin in push-pull mode
      extcon: Fix kernel doc of property fields to avoid warnings
      extcon: Fix kernel doc of property capability fields to avoid warnings
      platform/x86: wmi: Break possible infinite loop when parsing GUID

Aneesh Kumar K.V (4):
      mm: rename pud_page_vaddr to pud_pgtable and make it return pmd_t *
      mm: rename p4d_page_vaddr to p4d_pgtable and make it return pud_t *
      powerpc/book3s64/mm: Fix DirectMap stats in /proc/meminfo
      powerpc/mm/dax: Fix the condition when checking if altmap vmemap can cross-boundary

Arnaldo Carvalho de Melo (3):
      perf bench: Add missing setlocale() call to allow usage of %'d style formatting
      perf script: Fixup 'struct evsel_script' method prefix
      perf script: Fix allocation of evsel->priv related to per-event dump files

Arnd Bergmann (9):
      fs: pipe: reveal missing function protoypes
      ARM: 9303/1: kprobes: avoid missing-declaration warnings
      memstick r592: make memstick_debug_get_tpc_name() static
      ARM: ep93xx: fix missing-prototype warnings
      ARM: omap2: fix missing tick_broadcast() prototype
      crypto: marvell/cesa - Fix type mismatch warning
      usb: hide unused usbfs_notify_suspend/resume functions
      autofs: use flexible array in ioctl structure
      ARM: orion5x: fix d2net gpio initialization

Arseniy Krasnov (1):
      mtd: rawnand: meson: fix unaligned DMA buffers handling

Artur Rojek (1):
      sh: dma: Fix DMA channel offset calculation

Baokun Li (1):
      ext4: only update i_reserved_data_blocks on successful block allocation

Barnabás Pőcze (3):
      platform/x86: wmi: remove unnecessary argument
      platform/x86: wmi: use guid_t and guid_equal()
      platform/x86: wmi: move variables

Bartosz Golaszewski (1):
      net: stmmac: fix double serdes powerdown

Bas Nieuwenhuizen (1):
      drm/amdgpu: Validate VM ioctl flags.

Benjamin Berg (1):
      wifi: cfg80211: rewrite merging of inherited elements

Bikash Hazarika (2):
      scsi: qla2xxx: Fix potential NULL pointer dereference
      scsi: qla2xxx: Correct the index of array

Bjorn Andersson (1):
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

Chao Yu (2):
      f2fs: fix error path handling in truncate_dnode()
      f2fs: fix to avoid NULL pointer dereference f2fs_write_end_io()

Chengchang Tang (1):
      RDMA/hns: Fix hns_roce_table_get return value

Chengfeng Ye (1):
      sctp: fix potential deadlock on &net->sctp.addr_wq_lock

Chevron Li (1):
      mmc: sdhci: fix DMA configure compatibility issue when 64bit DMA mode is used.

Chia-I Wu (1):
      amdgpu: validate offset_in_bo of drm_amdgpu_gem_va

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
      IB/hfi1: Use bitmap_zalloc() when applicable
      fbdev: omapfb: lcd_mipid: Fix an error handling path in mipid_spi_probe()
      pinctrl: bcm2835: Handle gpiochip_add_pin_range() errors
      usb: dwc3: qcom: Release the correct resources in dwc3_qcom_remove()
      usb: dwc3: qcom: Fix an error handling path in dwc3_qcom_probe()
      usb: dwc3-meson-g12a: Fix an error handling path in dwc3_meson_g12a_probe()
      mfd: stmpe: Only disable the regulators if they are enabled
      rtc: st-lpc: Release some resources in st_rtc_probe() in case of error
      tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() in case of error
      tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() when iterating clk
      firmware: stratix10-svc: Fix a potential resource leak in svc_create_memory_pool()

Christophe Leroy (1):
      kcsan: Don't expect 64 bits atomic builtins from 32 bits architectures

Chu Lin (1):
      hwmon: (adm1275) enable adm1272 temperature reporting

Chunhai Guo (1):
      erofs: avoid infinite loop in z_erofs_do_read_page() when reading beyond EOF

Claudiu Beznea (10):
      clk: vc5: check memory returned by kasprintf()
      clk: cdce925: check return value of kasprintf()
      clk: si5341: return error if one synth clock registration fails
      clk: si5341: check return value of {devm_}kasprintf()
      clk: si5341: free unused memory on probe failure
      clk: keystone: sci-clk: check return value of kasprintf()
      clk: ti: clkctrl: check return value of kasprintf()
      ASoC: imx-audmix: check return value of devm_kasprintf()
      pinctrl: at91-pio4: check return value of devm_kasprintf()
      phy: tegra: xusb: check return value of devm_kzalloc()

Colin Ian King (1):
      powerpc/powernv/sriov: perform null check on iov before dereferencing iov

Cristian Ciocaltea (2):
      ASoC: es8316: Increment max value for ALC Capture Target Volume control
      ASoC: es8316: Do not set rate constraints for unsupported MCLKs

Dai Ngo (1):
      NFSD: add encoding of op_recall flag for write delegation

Damien Le Moal (3):
      PCI: rockchip: Set address alignment for endpoint mode
      misc: pci_endpoint_test: Free IRQs before removing the device
      misc: pci_endpoint_test: Re-init completion for every test

Dan Carpenter (6):
      modpost: fix off by one in is_executable_section()
      w1: fix loop in w1_fini()
      media: atomisp: gmin_platform: fix out_len in gmin_get_config_dsm_var()
      scsi: qla2xxx: Fix error code in qla2x00_start_sp()
      netdevsim: fix uninitialized data in nsim_dev_trap_fa_cookie_write()
      serial: atmel: don't enable IRQs prematurely

Dan Williams (2):
      dax: Fix dax_mapping_release() use after free
      dax: Introduce alloc_dev_dax_id()

Daniel Vetter (1):
      drm/atomic: Fix potential use-after-free in nonblocking commits

Daniil Dulov (2):
      drm/amdkfd: Fix potential deallocation of previously deallocated memory.
      media: usb: Check az6007_read() return value

Danila Chernetsov (1):
      apparmor: fix missing error check for rhashtable_insert_fast

Dario Binacchi (1):
      drm/panel: simple: fix active size for Ampire AM-480272H3TMQW-T01H

David Sterba (1):
      btrfs: add xxhash to fast checksum implementations

Davide Tronchin (1):
      USB: serial: option: add LARA-R6 01B PIDs

Ding Hui (4):
      PCI/ASPM: Disable ASPM on MFD function removal to avoid use-after-free
      SUNRPC: Fix UAF in svc_tcp_listen_data_ready()
      iavf: Fix use-after-free in free_netdev
      iavf: Fix out-of-bounds when setting channels on remove

Dmitry Antipov (1):
      wifi: ath9k: convert msecs to jiffies where needed

Dmitry Baryshkov (2):
      drm/panel: sharp-ls043t1le01: adjust mode settings
      drm/msm/dpu: do not enable color-management if DSPPs are not available

Douglas Anderson (2):
      watchdog/perf: define dummy watchdog_update_hrtimer_threshold() on correct config
      watchdog/perf: more properly prevent false positives with turbo modes

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

Eric Dumazet (15):
      netlink: fix potential deadlock in netlink_set_err()
      netlink: do not hard code device address lenth in fdb dumps
      tcp: annotate data races in __tcp_oow_rate_limited()
      udp6: fix udp6_ehashfn() typo
      tcp: annotate data-races around tcp_rsk(req)->ts_recent
      tcp: annotate data-races around tp->tcp_tx_delay
      tcp: annotate data-races around tp->keepalive_time
      tcp: annotate data-races around tp->keepalive_intvl
      tcp: annotate data-races around tp->keepalive_probes
      tcp: annotate data-races around icsk->icsk_syn_retries
      tcp: annotate data-races around tp->linger2
      tcp: annotate data-races around rskq_defer_accept
      tcp: annotate data-races around tp->notsent_lowat
      tcp: annotate data-races around icsk->icsk_user_timeout
      tcp: annotate data-races around fastopenq.max_qlen

Eric Whitney (1):
      ext4: correct inline offset when handling xattrs in inode body

Fabian Frederick (1):
      jffs2: reduce stack usage in jffs2_build_xattr_subsystem()

Fabio Estevam (1):
      drm/panel: simple: Add connector_type for innolux_at043tn24

Fancy Fang (1):
      pwm: imx-tpm: force 'real_period' to be zero in suspend

Fedor Pchelkin (2):
      wifi: ath9k: avoid referencing uninit memory in ath9k_wmi_ctrl_rx
      wifi: ath9k: don't allow to overwrite ENDPOINT0 attributes

Feng Mingxi (1):
      clocksource/drivers/cadence-ttc: Fix memory leak in ttc_timer_probe

Filipe Manana (2):
      btrfs: fix race when deleting quota root from the dirty cow roots list
      btrfs: fix warning when putting transaction with qgroups enabled after abort

Finn Thain (1):
      nubus: Partially revert proc_create_single_data() conversion

Florent Revest (2):
      netfilter: conntrack: Avoid nf_ct_helper_hash uses after free
      samples: ftrace: Save required argument registers in sample trampolines

Florian Fainelli (1):
      net: bcmgenet: Ensure MDIO unregistration has clocks enabled

Florian Kauer (2):
      igc: Fix launchtime before start of cycle
      igc: Fix inserting of empty frame for launchtime

Florian Westphal (7):
      netfilter: conntrack: dccp: copy entire header to stack buffer, not just basic one
      netfilter: nf_tables: use net_generic infra for transaction data
      netfilter: nf_tables: add rescheduling points during loop detection walks
      netfilter: nf_tables: fix scheduling-while-atomic splat
      netfilter: nf_tables: fix spurious set element insertion failure
      netfilter: nf_tables: can't schedule in nft_chain_validate
      netfilter: nft_set_pipapo: fix improper element removal

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

Gao Xiang (1):
      erofs: fix compact 4B support for 16k block size

Geert Uytterhoeven (4):
      regulator: core: Fix more error checking for debugfs_create_dir()
      regulator: core: Streamline debugfs operations
      ARM: dts: iwg20d-q7-common: Fix backlight pwm specifier
      sh: pgtable-3level: Fix cast to pointer from integer of different size

Geetha sowjanya (1):
      octeontx2-pf: Dont allocate BPIDs for LBK interfaces

Georg Müller (1):
      perf probe: Add test for regression introduced by switch to die_get_decl_file()

George Stark (1):
      meson saradc: fix clock divider mask length

Gilad Reti (1):
      selftests/bpf: Add verifier test for PTR_TO_MEM spill

Greg Kroah-Hartman (3):
      video: imsttfb: check for ioremap() failures
      Revert "usb: common: usb-conn-gpio: Set last role to unknown before initial detection"
      Linux 5.10.188

Guenter Roeck (1):
      hwmon: (pmbus/adm1275) Fix problems with temperature monitoring on ADM1272

Guillaume Nault (1):
      pptp: Fix fib lookup calls.

Gustavo A. R. Silva (1):
      wifi: wext-core: Fix -Wstringop-overflow warning in ioctl_standard_iw_point()

Hans de Goede (3):
      ACPI: button: Add lid disable DMI quirk for Nextbook Ares 8A
      ACPI: video: Add backlight=native DMI quirk for Apple iMac11,3
      ACPI: video: Add backlight=native DMI quirk for Lenovo ThinkPad X131e (3371 AMD version)

Hao Luo (1):
      clk: imx: clk-imx8mn: fix memory leak in imx8mn_clocks_probe

Hariprasad Kelam (1):
      octeontx2-af: Fix mapping for NIX block from CGX connection

Heiko Carstens (1):
      s390/decompressor: fix misaligned symbol build error

Herbert Xu (1):
      hwrng: virtio - Fix race on data_avail and actual data

Huacai Chen (1):
      MIPS: Loongson: Fix cpu_probe_loongson() again

Ido Schimmel (1):
      net/sched: flower: Ensure both minimum and maximum ports are specified

Ilia.Gavrilov (1):
      netfilter: nf_conntrack_sip: fix the ct_sip_parse_numerical_param() return value.

Ilya Maximets (1):
      xsk: Honor SO_BINDTODEVICE on bind

Jakub Kicinski (2):
      net: create netdev->dev_addr assignment helpers
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

Jason Gerecke (1):
      HID: wacom: Use ktime_t rather than int when dealing with timestamps

Jason Gunthorpe (2):
      RDMA: Remove uverbs_ex_cmd_mask values that are linked to functions
      RDMA/cma: Ensure rdma_addr_cancel() happens before issuing more requests

Jens Axboe (3):
      io_uring: ensure IOPOLL locks around deferred work
      io_uring: wait interruptibly for request completions on exit
      io_uring: add reschedule point to handle_tw_list()

Jeremy Sowden (1):
      lib/ts_bm: reset initial match offset for every block of text

Jesper Dangaard Brouer (1):
      igc: Enable and fix RX hash usage by netstack

Jiangong.Han (1):
      rcuscale: Console output claims too few grace periods

Jiapeng Chong (1):
      security: keys: Modify mismatched function name

Jiaqing Zhao (1):
      Revert "8250: add support for ASIX devices with a FIFO bug"

Jiasheng Jiang (3):
      pstore/ram: Add check for kstrdup
      mfd: intel-lpss: Add missing check for platform_get_resource
      NTB: ntb_tool: Add check for devm_kcalloc

Jinhong Zhu (1):
      scsi: qedf: Fix NULL dereference in error handling

Jisheng Zhang (2):
      riscv: bpf: Move bpf_jit_alloc_exec() and bpf_jit_free_exec() to core
      riscv: bpf: Avoid breaking W^X

Jocelyn Falempe (2):
      drm/client: Fix memory leak in drm_client_target_cloned
      drm/client: Fix memory leak in drm_client_modeset_probe

Johannes Berg (2):
      wifi: iwlwifi: pull from TXQs with softirqs disabled
      wifi: iwlwifi: mvm: avoid baid size integer overflow

John Ogness (2):
      serial: 8250: lock port for stop_rx() in omap8250_irq()
      serial: 8250: lock port for UART_IER access in omap8250_irq()

John Paul Adrian Glaubitz (2):
      irqchip/jcore-aic: Fix missing allocation of IRQ descriptors
      sh: j2: Use ioremap() to translate device tree address into kernel memory

Jonas Gorski (2):
      spi: bcm-qspi: return error if neither hif_mspi nor mspi is available
      spi: bcm63xx: fix max prepend length

Juergen Gross (1):
      x86/mm: Fix __swp_entry_to_pte() for Xen PV guests

Junfeng Guo (1):
      gve: Set default duplex configuration to full

Junyan Ye (1):
      PCI: ftpci100: Release the clock resources

Kailang Yang (1):
      ALSA: hda/realtek - remove 3k pull low procedure

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

Kemeng Shi (3):
      ext4: fix wrong unit use in ext4_mb_clear_bb
      ext4: get block from bh in ext4_free_blocks for fast commit replay
      ext4: fix wrong unit use in ext4_mb_new_blocks

Klaus Kudielka (1):
      net: mvneta: fix txq_map in case of txq_number==1

Krishna Kurapati (1):
      usb: dwc3: gadget: Propagate core init errors to UDC during pullup

Krister Johansen (1):
      net: ena: fix shift-out-of-bounds in exponential backoff

Krzysztof Kozlowski (8):
      nfc: constify several pointers to u8, char and sk_buff
      nfc: llcp: fix possible use of uninitialized variable in nfc_llcp_send_connect()
      nfc: llcp: simplify llcp_sock_connect() error paths
      arm64: dts: qcom: msm8916: correct camss unit address
      arm64: dts: qcom: msm8994: correct SPMI unit address
      arm64: dts: qcom: msm8996: correct camss unit address
      arm64: dts: qcom: apq8096: fix fixed regulator name property
      memory: brcmstb_dpfe: fix testing array offset after use

Kuniyuki Iwashima (8):
      gtp: Fix use-after-free in __gtp_encap_destroy().
      netlink: Add __sock_i_ino() for __netlink_diag_dump().
      icmp6: Fix null-ptr-deref of ip6_null_entry->rt6i_idev in icmp6_dev().
      bridge: Add extack warning when enabling STP in netns.
      Revert "tcp: avoid the lookup process failing to get sk in ehash table"
      llc: Don't drop packet from non-root netns.
      net: Introduce net.ipv4.tcp_migrate_req.
      tcp: Fix data-races around sysctl_tcp_syn(ack)?_retries.

Lang Cheng (1):
      RDMA/hns: Fix coding style issues

Laurent Vivier (4):
      hwrng: virtio - add an internal buffer
      hwrng: virtio - don't wait on cleanup
      hwrng: virtio - don't waste entropy
      hwrng: virtio - always add a pending request

Lee Jones (1):
      wl3501_cs: Fix misspelling and provide missing documentation

Li Nan (6):
      blk-iocost: use spin_lock_irqsave in adjust_inuse_and_calc_cost
      md/raid10: check slab-out-of-bounds in md_bitmap_get_counter
      md/raid10: fix overflow of md/safe_mode_delay
      md/raid10: fix wrong setting of max_corr_read_errors
      md/raid10: fix null-ptr-deref of mreplace in raid10_sync_request
      md/raid10: fix io loss while replacement replace rdev

Li Yang (1):
      usb: phy: phy-tahvo: fix memory leak in tahvo_usb_probe()

Li Zhijian (1):
      rcuscale: Always log error message

Lin Ma (2):
      net: nfc: Fix use-after-free caused by nfc_llcp_find_local
      net/sched: act_pedit: Add size check for TCA_PEDIT_PARMS_EX

Lino Sanfilippo (1):
      tpm, tpm_tis: Claim locality in interrupt handler

Linus Torvalds (2):
      workqueue: clean up WORK_* constant types, clarify masking
      ftrace: Store the order of pages allocated in ftrace_page

Luc Ma (1):
      drm/vram-helper: fix function names in vram helper doc

Luca Weiss (1):
      Input: drv260x - sleep between polling GO bit

Luka Guzenko (1):
      ALSA: hda/realtek: Enable Mute LED on HP Laptop 15s-eq2xxx

M A Ramdhan (1):
      net/sched: cls_fw: Fix improper refcount update leads to use-after-free

Manish Rangankar (1):
      scsi: qla2xxx: Remove unused nvme_ls_waitq wait queue

Manivannan Sadhasivam (1):
      PCI: qcom: Disable write access to read only registers for IP v2.3.3

Mantas Pucka (1):
      clk: qcom: gcc-ipq6018: Use floor ops for sdcc clocks

Marc Zyngier (1):
      irqchip/jcore-aic: Kill use of irq_create_strict_mappings()

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

Mario Limonciello (5):
      pinctrl: amd: Fix mistake in handling clearing pins at startup
      pinctrl: amd: Detect internal GPIO0 debounce handling
      pinctrl: amd: Only use special debounce behavior for GPIO 0
      drm/amd/display: Correct `DMUB_FW_VERSION` macro
      pinctrl: amd: Use amd_pinconf_set() for all config options

Mark Brown (2):
      regmap: Drop initial version of maximum transfer length fixes
      regmap: Account for register length in SMBus I/O limits

Mark Rutland (1):
      arm64: mm: fix VA-range sanity check

Martin Blumenstingl (1):
      ARM: dts: meson8: correct uart_B and uart_C clock references

Martin KaFai Lau (1):
      bpf: Address KCSAN report on bpf_lru_list

Martin Kaiser (3):
      hwrng: st - keep clock enabled while hwrng is registered
      hwrng: imx-rngc - fix the timeout for init and self check
      fbdev: imxfb: warn about invalid left/right margin

Masahiro Yamada (3):
      modpost: fix section mismatch message for R_ARM_ABS32
      modpost: fix section mismatch message for R_ARM_{PC24,CALL,JUMP24}
      ARC: define ASM_NL and __ALIGN(_STR) outside #ifdef __ASSEMBLY__ guard

Masami Hiramatsu (Google) (1):
      tracing/probes: Fix not to count error code to total length

Mateusz Stachyra (1):
      tracing: Fix null pointer dereference in tracing_err_log_open()

Matt Corallo (1):
      btrfs: add handling for RAID1C23/DUP to btrfs_reduce_alloc_profile

Matthieu Baerts (2):
      selftests: tc: set timeout to 15 minutes
      selftests: tc: add 'ct' action kconfig dep

Matus Gajdos (1):
      ASoC: fsl_sai: Disable bit clock with transmitter

Max Filippov (1):
      xtensa: ISS: fix call to split_if_spec

Maxim Kochetkov (1):
      net: axienet: Move reset before 64-bit DMA detection

Maxime Bizon (1):
      wifi: ath11k: fix registration of 6Ghz-only phy without the full channel range

Michael Schmitz (4):
      block: fix signed int overflow in Amiga partition support
      block: change all __u32 annotations to __be32 in affs_hardblocks.h
      block: add overflow checks for Amiga partition support
      block/partition: fix signedness issue for Amiga partitions

Mike Hommey (1):
      HID: logitech-hidpp: add HIDPP_QUIRK_DELAYED_INIT for the T651.

Miklos Szeredi (1):
      fuse: revalidate: don't invalidate if interrupted

Ming Lei (1):
      nvme-pci: fix DMA direction of unmapping integrity data

Mingzhe Zou (1):
      bcache: fixup btree_cache_wait list damage

Mirsad Goran Todorovac (1):
      test_firmware: return ENOMEM instead of ENOSPC on failed memory allocation

Mohamed Khalfella (2):
      tracing/histograms: Add histograms to hist_vars if they have referenced variables
      tracing/histograms: Return an error if we fail to add histogram to hist_vars list

Moritz Fischer (1):
      net: lan743x: Don't sleep in atomic context

Muchun Song (1):
      kernfs: fix missing kernfs_idr_lock to remove an ID from the IDR

Muhammad Husaini Zulkifli (1):
      igc: Remove delay during TX ring configuration

Namhyung Kim (1):
      perf dwarf-aux: Fix off-by-one in die_get_varname()

Naveen N Rao (1):
      powerpc: Fail build if using recordmcount with binutils v2.37

Nicholas Kazlauskas (1):
      drm/amd/display: Explicitly specify update type per plane info change

Nico Boehr (1):
      KVM: s390: fix KVM_S390_GET_CMMA_BITS for GFNs in memslot holes

Nikita Zhandarovich (3):
      PM: domains: fix integer overflow issues in genpd_parse_state()
      radeon: avoid double free in ci_dpm_init()
      drm/radeon: fix possible division-by-zero errors

Nilesh Javali (2):
      scsi: qla2xxx: Array index may go out of bound
      scsi: qla2xxx: Check valid rport returned by fc_bsg_to_rport()

Nishanth Menon (1):
      mailbox: ti-msgmgr: Fill non-message tx data fields with 0x0

Nitya Sunkad (1):
      ionic: remove WARN_ON to prevent panic_on_warn

Olga Kornievskaia (1):
      NFSv4.1: freeze the session table upon receiving NFS4ERR_BADSESSION

Oliver Hartkopp (1):
      can: isotp: isotp_sendmsg(): fix return error fix on TX path

Olivier Moysan (1):
      ARM: dts: stm32: fix i2s endpoint format property for stm32mp15xx-dkx

Ondrej Zary (1):
      PCI/PM: Avoid putting EloPOS E2/S2/H2 PCIe Ports in D3cold

Pablo Neira Ayuso (10):
      netfilter: nf_tables: incorrect error path handling with NFT_MSG_NEWRULE
      netfilter: nf_tables: fix chain binding transaction logic
      netfilter: nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain
      netfilter: nf_tables: reject unbound anonymous set before commit phase
      netfilter: nf_tables: reject unbound chain set before commit phase
      netfilter: nftables: rename set element data activation/deactivation functions
      netfilter: nf_tables: drop map element references from preparation phase
      netfilter: nf_tables: unbind non-anonymous set if rule construction fails
      netfilter: nf_tables: skip bound chain in netns release path
      netfilter: nf_tables: skip bound chain on rule flush

Paolo Abeni (1):
      net: prevent skb corruption on frag list segmentation

Patrick Kelsey (1):
      IB/hfi1: Fix sdma.h tx->num_descs off-by-one errors

Paul E. McKenney (4):
      rcuscale: Move shutdown from wait_event() to wait_event_idle()
      rcu-tasks: Mark ->trc_reader_nesting data races
      rcu-tasks: Mark ->trc_reader_special.b.need_qs data races
      rcu-tasks: Simplify trc_read_check_handler() atomic operations

Pawel Dembicki (1):
      net: dsa: vsc73xx: fix MTU configuration

Pedro Tammela (4):
      net/sched: make psched_mtu() RTNL-less safe
      net/sched: sch_qfq: refactor parsing of netlink parameters
      net/sched: sch_qfq: account for stab overhead in qfq_enqueue
      net/sched: sch_qfq: reintroduce lmax bound check for MTU

Pengcheng Yang (1):
      samples/bpf: Fix buffer overflow in tcp_basertt

Peter Seiderer (1):
      wifi: ath9k: fix AR9003 mac hardware hang check register offset calculation

Petr Oros (1):
      devlink: report devlink_port_type_warn source device

Petr Pavlu (1):
      keys: Fix linking a duplicate key to a keyring's assoc_array

Pierre Morel (1):
      KVM: s390: vsie: fix the length of APCB bitmap

Potin Lai (1):
      hwmon: (adm1275) Allow setting sample averaging

Prasad Koya (1):
      igc: set TP bit in 'supported' and 'advertising' fields of ethtool_link_ksettings

Prashanth K (2):
      usb: gadget: u_serial: Add null pointer check in gserial_suspend
      usb: common: usb-conn-gpio: Set last role to unknown before initial detection

Pu Lehui (1):
      bpf, riscv: Support riscv jit to provide bpf_line_info

Qiuxu Zhuo (2):
      rcu/rcuscale: Move rcu_scale_*() after kfree_scale_cleanup()
      rcu/rcuscale: Stop kfree_scale_thread thread(s) after unloading rcuscale

Quinn Tran (2):
      scsi: qla2xxx: Wait for io return on terminate rport
      scsi: qla2xxx: Fix buffer overrun

Rafał Miłecki (2):
      ARM: dts: BCM5301X: Drop "clock-names" from the SPI node
      net: bgmac: postpone turning IRQs off to avoid SoC hangs

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

Ricardo Cañuelo (1):
      Revert "thermal/drivers/mediatek: Use devm_of_iomap to avoid resource leak in mtk_thermal_probe"

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

Robert Hancock (3):
      clk: si5341: Allow different output VDD_SEL values
      clk: si5341: Add sysfs properties to allow checking/resetting device faults
      i2c: xiic: Don't try to handle more interrupt events after error

Robert Marko (5):
      arm64: dts: microchip: sparx5: do not use PSCI on reference boards
      clk: qcom: reset: support resetting multiple bits
      clk: qcom: ipq6018: fix networking resets
      mmc: core: disable TRIM on Kingston EMMC04G-M627
      mmc: core: disable TRIM on Micron MTFC4GACAJCN-1M

Roberto Sassu (3):
      evm: Complete description of evm_inode_setattr()
      ima: Fix build warnings
      shmem: use ramfs_kill_sb() for kill_sb method of ramfs-based tmpfs

Robin Murphy (2):
      perf/arm-cmn: Fix DTC reset
      PCI: Add function 1 DMA alias quirk for Marvell 88SE9235

Rongguang Wei (1):
      PCI: pciehp: Cancel bringup sequence if card is not present

Sabrina Dubroca (1):
      selftests: rtnetlink: remove netdevsim device after ipsec offload test

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

Siddh Raman Pant (1):
      jfs: jfs_dmap: Validate db_l2nbperpage while mounting

Siddharth Vadapalli (1):
      PCI: cadence: Fix Gen2 Link Retraining process

Sohaib Mohamed (1):
      perf bench: Use unbuffered output when pipe/tee'ing to a file

Stanislav Fomichev (1):
      bpf: Remove extra lock_sock for TCP_ZEROCOPY_RECEIVE

Stefan Wahren (1):
      w1: w1_therm: fix locking behavior in convert_t

Stephan Gerhold (2):
      clk: qcom: reset: Allow specifying custom reset delay
      mfd: rt5033: Drop rt5033-battery sub-device

Su Hui (1):
      ALSA: ac97: Fix possible NULL dereference in snd_ac97_mixer

Sui Jingfeng (1):
      PCI: Add pci_clear_master() stub for non-CONFIG_PCI

Takashi Iwai (1):
      ALSA: jack: Fix mutex call in snd_jack_report()

Tanmay Patil (1):
      net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()/cpsw_ale_set_field()

Tero Kristo (1):
      cpufreq: intel_pstate: Fix energy_performance_preference for passive

Tetsuo Handa (1):
      debugobjects: Recheck debug_objects_enabled before reporting

Thadeu Lima de Souza Cascardo (2):
      netfilter: nf_tables: do not ignore genmask when looking up chain by id
      netfilter: nf_tables: prevent OOB access in nft_byteorder_eval

Thomas Gleixner (3):
      x86/smp: Use dedicated cache-line for mwait_play_dead()
      posix-timers: Prevent RT livelock in itimer_delete()
      posix-timers: Ensure timer ID search-loop limit is valid

Thomas Weißschuh (1):
      fs: avoid empty option when generating legacy mount string

Thorsten Winkler (1):
      s390/qeth: Fix vipa deletion

Tianjia Zhang (1):
      integrity: Fix possible multiple allocation in integrity_inode_get()

Tim Harvey (1):
      hwmon: (gsc-hwmon) fix fan pwm temperature scaling

Tobias Heider (1):
      Add MODULE_FIRMWARE() for FIRMWARE_TG357766.

Tony Lindgren (4):
      bus: ti-sysc: Fix dispc quirk masking bool variables
      ARM: dts: gta04: Move model property out of pinctrl node
      serial: 8250: omap: Fix freeing of resources on failed register
      serial: 8250_omap: Use force_suspend and resume for system suspend

Tsuchiya Yuto (1):
      media: atomisp: fix "variable dereferenced before check 'asd'"

Ulf Hansson (1):
      mmc: mmci: Set PROBE_PREFER_ASYNCHRONOUS

Vijaya Krishna Nivarthi (1):
      spi: spi-geni-qcom: Correct CS_TOGGLE bit in SPI_TRANS_CFG

Vinicius Costa Gomes (1):
      igc: Fix race condition in PTP tx code

Vlad Buslov (1):
      net/mlx5e: Check for NOT_READY flag state after locking

Vladimir Oltean (3):
      net: bridge: keep ports without IFF_UNICAST_FLT in BR_PROMISC mode
      net: dsa: tag_sja1105: fix MAC DA patching from meta frames
      net: phy: prevent stale pointer dereference in phy_init()

Vladislav Efanov (1):
      usb: dwc3: qcom: Fix potential memory leak

Wang Ming (1):
      net: ipv4: Use kfree_sensitive instead of kfree

Weihang Li (1):
      RDMA/hns: Use refcount_t APIs for HEM

Weitao Wang (3):
      xhci: Fix resume issue of some ZHAOXIN hosts
      xhci: Fix TRB prefetch issue of ZHAOXIN hosts
      xhci: Show ZHAOXIN xHCI root hub speed correctly

Wolfram Sang (1):
      arm64: dts: renesas: ulcb-kf: Remove flow control for SCIF1

Xi Wang (1):
      RDMA/hns: Clean the hardware related code for HEM

Xiubo Li (1):
      ceph: don't let check_caps skip sending responses for revoke msgs

XuDong Liu (1):
      drm: sun4i_tcon: use devm_clk_get_enabled in `sun4i_tcon_init_clocks`

Yang Yingliang (1):
      NTB: ntb_transport: fix possible memory leak while device_register() fails

Yicong Yang (1):
      sched/fair: Don't balance task to its current running CPU

Ying Hsu (1):
      igb: Fix igb_down hung on surprise removal

Youngmin Nam (1):
      arm64: set __exception_irq_entry with __irq_entry as a default

Yu Kuai (2):
      md: fix data corruption for raid456 when reshape restart while grow up
      md/raid10: prevent soft lockup while flush writes

Yuan Can (4):
      clk: tegra: tegra124-emc: Fix potential memory leak
      ntb: idt: Fix error handling in idt_pci_driver_init()
      NTB: amd: Fix error handling in amd_ntb_pci_driver_init()
      ntb: intel: Fix error handling in intel_ntb_pci_driver_init()

Yuanjun Gong (1):
      net:ipv6: check return value of pskb_trim()

Yuchen Yang (1):
      scsi: 3w-xxxx: Add error handling for initialization failure in tw_probe()

YueHaibing (1):
      can: bcm: Fix UAF in bcm_proc_show()

Yuxing Liu (1):
      clk: imx: clk-imx8mp: improve error handling in imx8mp_clocks_probe()

Zhang Rui (1):
      powercap: RAPL: Fix CONFIG_IOSF_MBI dependency

Zhang Shurong (1):
      fbdev: au1200fb: Fix missing IRQ check in au1200fb_drv_probe

Zhen Lei (1):
      kexec: fix a memory leak in crash_shrink_memory()

Zheng Wang (3):
      fbdev: imsttfb: Fix use after free bug in imsttfb_probe
      bcache: Remove unnecessary NULL point check in node allocations
      bcache: Fix __bch_btree_node_alloc to make the failure behavior consistent

Zheng Yejian (3):
      ring-buffer: Fix deadloop issue on reading trace_pipe
      tracing: Fix memory leak of iter->temp when reading trace_pipe
      ftrace: Fix possible warning on checking all pages used in ftrace_process_locs()

Zhengchao Shao (1):
      net/mlx5e: fix double free in mlx5e_destroy_flow_table

Zhihao Cheng (1):
      ext4: Fix reusing stale buffer heads from last failed mounting

Zhong Jinghua (1):
      nbd: Add the maximum limit of allocated index in nbd_dev_add

Ziyang Xuan (1):
      ipv6/addrconf: fix a potential refcount underflow for idev

hfdevel@gmx.net (1):
      ARM: dts: meson8b: correct uart_B and uart_C clock references

