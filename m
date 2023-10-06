Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B337BB64C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjJFLUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjJFLUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:20:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E26FA;
        Fri,  6 Oct 2023 04:19:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81C0C433CC;
        Fri,  6 Oct 2023 11:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696591187;
        bh=/gYrlzlPeAGPRl94zXydn+BT/9a5xBliHQCfHQ1AvMo=;
        h=From:To:Cc:Subject:Date:From;
        b=LnkeFq3yVtxEcOr90pz2grGBlRqo62kTAKcKVfno4YgyDSBO5MDcL9apDo8vbAeUU
         YtV1/i9LXx4XOdQ0/6L0Qp+w6wwSykYoBEWPW+Zyk80jrMHBGPNSB/232FcySMlKA1
         L6pqBWtcvSMhOTx5mixEfSve9nnlg5pyEzxYia40=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.134
Date:   Fri,  6 Oct 2023 13:19:42 +0200
Message-ID: <2023100643-change-onset-3796@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.15.134 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                          |    2 
 arch/arm/boot/dts/am33xx.dtsi                                     |    5 
 arch/arm/boot/dts/am3517.dtsi                                     |    5 
 arch/arm/boot/dts/am4372.dtsi                                     |    5 
 arch/arm/boot/dts/artpec6-devboard.dts                            |    9 
 arch/arm/boot/dts/dm814x.dtsi                                     |    6 
 arch/arm/boot/dts/dm816x.dtsi                                     |    6 
 arch/arm/boot/dts/dra62x.dtsi                                     |    6 
 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi                        |    5 
 arch/arm/boot/dts/dra7-iva-thermal.dtsi                           |    5 
 arch/arm/boot/dts/imx6q-gk802.dts                                 |    9 
 arch/arm/boot/dts/motorola-mapphone-common.dtsi                   |    4 
 arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi                         |    6 
 arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi                         |    6 
 arch/arm/boot/dts/omap2.dtsi                                      |    5 
 arch/arm/boot/dts/omap2420.dtsi                                   |    5 
 arch/arm/boot/dts/omap2430.dtsi                                   |    5 
 arch/arm/boot/dts/omap3-cm-t3517.dts                              |   12 
 arch/arm/boot/dts/omap3-cpu-thermal.dtsi                          |    8 
 arch/arm/boot/dts/omap3-gta04.dtsi                                |    6 
 arch/arm/boot/dts/omap3-ldp.dts                                   |    2 
 arch/arm/boot/dts/omap3-n900.dts                                  |   38 
 arch/arm/boot/dts/omap3-zoom3.dts                                 |   44 
 arch/arm/boot/dts/omap3.dtsi                                      |    5 
 arch/arm/boot/dts/omap34xx.dtsi                                   |    5 
 arch/arm/boot/dts/omap36xx.dtsi                                   |    5 
 arch/arm/boot/dts/omap4-cpu-thermal.dtsi                          |   34 
 arch/arm/boot/dts/omap443x.dtsi                                   |    6 
 arch/arm/boot/dts/omap4460.dtsi                                   |    6 
 arch/arm/boot/dts/omap5-cm-t54.dts                                |   64 
 arch/arm/boot/dts/omap5-core-thermal.dtsi                         |    5 
 arch/arm/boot/dts/omap5-gpu-thermal.dtsi                          |    5 
 arch/arm/boot/dts/orion5x-lacie-d2-network.dts                    |    5 
 arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts         |    9 
 arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts             |    5 
 arch/arm/boot/dts/orion5x-mv88f5181.dtsi                          |    9 
 arch/arm/boot/dts/orion5x-mv88f5182.dtsi                          |    9 
 arch/arm/boot/dts/orion5x-netgear-wnr854t.dts                     |    9 
 arch/arm/boot/dts/orion5x-rd88f5182-nas.dts                       |    9 
 arch/arm/boot/dts/orion5x.dtsi                                    |    9 
 arch/arm/include/asm/hardware/cache-aurora-l2.h                   |    5 
 arch/arm/include/asm/hardware/cache-feroceon-l2.h                 |    6 
 arch/arm/include/asm/hardware/cache-tauros2.h                     |    5 
 arch/arm/mach-davinci/board-da830-evm.c                           |    6 
 arch/arm/mach-davinci/board-da850-evm.c                           |    6 
 arch/arm/mach-davinci/board-dm355-evm.c                           |    6 
 arch/arm/mach-davinci/board-dm355-leopard.c                       |    5 
 arch/arm/mach-davinci/board-dm644x-evm.c                          |    6 
 arch/arm/mach-davinci/board-dm646x-evm.c                          |    7 
 arch/arm/mach-davinci/board-mityomapl138.c                        |    5 
 arch/arm/mach-davinci/board-neuros-osd2.c                         |    5 
 arch/arm/mach-davinci/board-omapl138-hawk.c                       |    5 
 arch/arm/mach-davinci/common.c                                    |    6 
 arch/arm/mach-davinci/cpuidle.h                                   |    5 
 arch/arm/mach-davinci/da830.c                                     |    6 
 arch/arm/mach-davinci/da850.c                                     |    6 
 arch/arm/mach-davinci/dm355.c                                     |    6 
 arch/arm/mach-davinci/dm644x.c                                    |    6 
 arch/arm/mach-davinci/dm646x.c                                    |    6 
 arch/arm/mach-davinci/include/mach/common.h                       |    6 
 arch/arm/mach-davinci/include/mach/cputype.h                      |    6 
 arch/arm/mach-davinci/include/mach/da8xx.h                        |    6 
 arch/arm/mach-davinci/include/mach/hardware.h                     |    6 
 arch/arm/mach-davinci/include/mach/serial.h                       |    6 
 arch/arm/mach-davinci/mux.c                                       |    6 
 arch/arm/mach-davinci/mux.h                                       |    6 
 arch/arm/mach-davinci/pm_domain.c                                 |    5 
 arch/arm/mach-dove/bridge-regs.h                                  |    9 
 arch/arm/mach-dove/cm-a510.c                                      |    5 
 arch/arm/mach-dove/common.c                                       |    5 
 arch/arm/mach-dove/common.h                                       |    5 
 arch/arm/mach-dove/dove-db-setup.c                                |    5 
 arch/arm/mach-dove/dove.h                                         |    9 
 arch/arm/mach-dove/irq.c                                          |    5 
 arch/arm/mach-dove/irqs.h                                         |    9 
 arch/arm/mach-dove/mpp.c                                          |    5 
 arch/arm/mach-dove/pcie.c                                         |    5 
 arch/arm/mach-dove/pm.h                                           |    6 
 arch/arm/mach-lpc18xx/board-dt.c                                  |    5 
 arch/arm/mach-lpc32xx/pm.c                                        |    6 
 arch/arm/mach-lpc32xx/suspend.S                                   |    6 
 arch/arm/mach-mv78xx0/bridge-regs.h                               |    6 
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c                         |    5 
 arch/arm/mach-mv78xx0/common.c                                    |    5 
 arch/arm/mach-mv78xx0/common.h                                    |    5 
 arch/arm/mach-mv78xx0/db78x00-bp-setup.c                          |    5 
 arch/arm/mach-mv78xx0/irq.c                                       |    5 
 arch/arm/mach-mv78xx0/irqs.h                                      |    9 
 arch/arm/mach-mv78xx0/mpp.c                                       |    5 
 arch/arm/mach-mv78xx0/mpp.h                                       |    6 
 arch/arm/mach-mv78xx0/mv78xx0.h                                   |    5 
 arch/arm/mach-mv78xx0/pcie.c                                      |    5 
 arch/arm/mach-mv78xx0/rd78x00-masa-setup.c                        |    5 
 arch/arm/mach-mvebu/armada-370-xp.h                               |    5 
 arch/arm/mach-mvebu/board-v7.c                                    |    5 
 arch/arm/mach-mvebu/coherency.c                                   |    5 
 arch/arm/mach-mvebu/coherency.h                                   |    6 
 arch/arm/mach-mvebu/coherency_ll.S                                |    5 
 arch/arm/mach-mvebu/common.h                                      |    5 
 arch/arm/mach-mvebu/cpu-reset.c                                   |    5 
 arch/arm/mach-mvebu/dove.c                                        |    5 
 arch/arm/mach-mvebu/headsmp-a9.S                                  |    5 
 arch/arm/mach-mvebu/headsmp.S                                     |    5 
 arch/arm/mach-mvebu/kirkwood.c                                    |    5 
 arch/arm/mach-mvebu/kirkwood.h                                    |    5 
 arch/arm/mach-mvebu/mvebu-soc-id.c                                |    5 
 arch/arm/mach-mvebu/mvebu-soc-id.h                                |    5 
 arch/arm/mach-mvebu/platsmp-a9.c                                  |    5 
 arch/arm/mach-mvebu/platsmp.c                                     |    5 
 arch/arm/mach-mvebu/pm-board.c                                    |    5 
 arch/arm/mach-mvebu/pm.c                                          |    5 
 arch/arm/mach-mvebu/pmsu.c                                        |    5 
 arch/arm/mach-mvebu/pmsu.h                                        |    5 
 arch/arm/mach-mvebu/pmsu_ll.S                                     |    5 
 arch/arm/mach-mvebu/system-controller.c                           |    5 
 arch/arm/mach-omap1/include/mach/mtd-xip.h                        |    6 
 arch/arm/mach-omap1/pm_bus.c                                      |    6 
 arch/arm/mach-omap2/prcm43xx.h                                    |    5 
 arch/arm/mach-omap2/vc.c                                          |    6 
 arch/arm/mach-orion5x/board-d2net.c                               |    5 
 arch/arm/mach-orion5x/board-dt.c                                  |    5 
 arch/arm/mach-orion5x/board-rd88f5182.c                           |    5 
 arch/arm/mach-orion5x/bridge-regs.h                               |    9 
 arch/arm/mach-orion5x/common.c                                    |    5 
 arch/arm/mach-orion5x/db88f5281-setup.c                           |    5 
 arch/arm/mach-orion5x/irq.c                                       |    5 
 arch/arm/mach-orion5x/irqs.h                                      |    5 
 arch/arm/mach-orion5x/kurobox_pro-setup.c                         |    5 
 arch/arm/mach-orion5x/ls_hgl-setup.c                              |    5 
 arch/arm/mach-orion5x/mpp.c                                       |    5 
 arch/arm/mach-orion5x/net2big-setup.c                             |    6 
 arch/arm/mach-orion5x/orion5x.h                                   |    5 
 arch/arm/mach-orion5x/pci.c                                       |    5 
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c                      |    5 
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c                       |    5 
 arch/arm/mach-orion5x/rd88f5182-setup.c                           |    5 
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c                      |    5 
 arch/arm/mach-orion5x/ts78xx-setup.c                              |    5 
 arch/arm/mach-orion5x/wnr854t-setup.c                             |    9 
 arch/arm/mach-orion5x/wrt350n-v2-setup.c                          |    9 
 arch/arm/mach-pxa/eseries.c                                       |    7 
 arch/arm/mach-pxa/standby.S                                       |    6 
 arch/arm/mach-spear/generic.h                                     |    5 
 arch/arm/mach-spear/include/mach/misc_regs.h                      |    5 
 arch/arm/mach-spear/include/mach/spear.h                          |    5 
 arch/arm/mach-spear/pl080.c                                       |    5 
 arch/arm/mach-spear/pl080.h                                       |    5 
 arch/arm/mach-spear/restart.c                                     |    5 
 arch/arm/mach-spear/spear1310.c                                   |    5 
 arch/arm/mach-spear/spear1340.c                                   |    5 
 arch/arm/mach-spear/spear13xx.c                                   |    5 
 arch/arm/mach-spear/spear300.c                                    |    5 
 arch/arm/mach-spear/spear310.c                                    |    5 
 arch/arm/mach-spear/spear320.c                                    |    5 
 arch/arm/mach-spear/spear3xx.c                                    |    5 
 arch/arm/mach-spear/spear6xx.c                                    |    5 
 arch/arm/mach-spear/time.c                                        |    5 
 arch/arm/mm/cache-feroceon-l2.c                                   |    5 
 arch/arm/mm/cache-tauros2.c                                       |    5 
 arch/mips/alchemy/devboards/db1000.c                              |    4 
 arch/mips/alchemy/devboards/db1200.c                              |    6 
 arch/mips/alchemy/devboards/db1300.c                              |    4 
 arch/parisc/include/asm/ropes.h                                   |    3 
 arch/parisc/kernel/drivers.c                                      |    2 
 arch/parisc/kernel/irq.c                                          |    2 
 arch/powerpc/kernel/hw_breakpoint.c                               |   16 
 arch/powerpc/kernel/hw_breakpoint_constraints.c                   |    7 
 arch/powerpc/perf/hv-24x7.c                                       |    2 
 arch/x86/kernel/cpu/bugs.c                                        |    4 
 arch/x86/kernel/cpu/common.c                                      |    2 
 arch/xtensa/boot/Makefile                                         |    3 
 arch/xtensa/boot/lib/zmem.c                                       |    5 
 arch/xtensa/include/asm/core.h                                    |    4 
 arch/xtensa/platforms/iss/network.c                               |    4 
 drivers/ata/ahci.c                                                |  111 
 drivers/ata/ahci_brcm.c                                           |    2 
 drivers/ata/ahci_xgene.c                                          |    4 
 drivers/ata/libahci.c                                             |   49 
 drivers/ata/libata-core.c                                         |   41 
 drivers/ata/libata-eh.c                                           |   13 
 drivers/ata/libata-sata.c                                         |    2 
 drivers/ata/libata-scsi.c                                         |    2 
 drivers/ata/libata-transport.c                                    |    9 
 drivers/ata/libata.h                                              |    2 
 drivers/bus/ti-sysc.c                                             |   31 
 drivers/char/agp/parisc-agp.c                                     |    2 
 drivers/clk/tegra/clk-bpmp.c                                      |    2 
 drivers/firmware/imx/imx-dsp.c                                    |    1 
 drivers/gpio/gpio-pmic-eic-sprd.c                                 |    1 
 drivers/gpio/gpio-tb10x.c                                         |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                           |   17 
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c       |    4 
 drivers/gpu/drm/bridge/ti-sn65dsi83.c                             |    4 
 drivers/gpu/drm/meson/meson_encoder_hdmi.c                        |    2 
 drivers/i2c/busses/i2c-i801.c                                     |    1 
 drivers/i2c/busses/i2c-npcm7xx.c                                  |   17 
 drivers/i2c/muxes/i2c-demux-pinctrl.c                             |    4 
 drivers/i2c/muxes/i2c-mux-gpio.c                                  |   47 
 drivers/input/serio/i8042-acpipnpio.h                             | 1657 ++++++++++
 drivers/input/serio/i8042-x86ia64io.h                             | 1650 ---------
 drivers/input/serio/i8042.h                                       |    2 
 drivers/interconnect/core.c                                       |    1 
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c                   |   27 
 drivers/media/common/videobuf2/frame_vector.c                     |    6 
 drivers/misc/cardreader/rts5227.c                                 |   55 
 drivers/misc/cardreader/rts5228.c                                 |   57 
 drivers/misc/cardreader/rts5249.c                                 |   56 
 drivers/misc/cardreader/rts5260.c                                 |   43 
 drivers/misc/cardreader/rts5261.c                                 |   52 
 drivers/misc/cardreader/rtsx_pcr.c                                |   51 
 drivers/net/ethernet/amazon/ena/ena_netdev.c                      |    3 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                         |    5 
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c                   |    9 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c           |   13 
 drivers/net/ethernet/intel/i40e/i40e.h                            |    1 
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c                    |    9 
 drivers/net/ethernet/intel/i40e/i40e_main.c                       |  138 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                |   16 
 drivers/net/ethernet/intel/iavf/iavf_main.c                       |    3 
 drivers/net/ethernet/intel/igc/igc_ethtool.c                      |   31 
 drivers/net/ethernet/intel/igc/igc_main.c                         |    2 
 drivers/net/ethernet/pensando/ionic/ionic_dev.h                   |    1 
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c                  |   10 
 drivers/net/team/team.c                                           |   10 
 drivers/net/thunderbolt.c                                         |    3 
 drivers/nvme/host/pci.c                                           |  121 
 drivers/parisc/iosapic.c                                          |    4 
 drivers/parisc/iosapic_private.h                                  |    4 
 drivers/platform/mellanox/Kconfig                                 |    1 
 drivers/platform/x86/intel_scu_ipc.c                              |   66 
 drivers/power/supply/ucs1002_power.c                              |    3 
 drivers/scsi/pm8001/pm8001_hwi.c                                  |    2 
 drivers/scsi/pm8001/pm80xx_hwi.c                                  |    4 
 drivers/scsi/qedf/qedf_io.c                                       |   10 
 drivers/scsi/qedf/qedf_main.c                                     |    7 
 drivers/scsi/qla2xxx/qla_def.h                                    |    3 
 drivers/scsi/qla2xxx/qla_init.c                                   |    5 
 drivers/scsi/qla2xxx/qla_inline.h                                 |   58 
 drivers/scsi/qla2xxx/qla_isr.c                                    |   12 
 drivers/scsi/qla2xxx/qla_nvme.c                                   |    4 
 drivers/scsi/qla2xxx/qla_os.c                                     |    6 
 drivers/scsi/qla2xxx/qla_target.c                                 |    3 
 drivers/scsi/qla2xxx/tcm_qla2xxx.c                                |    4 
 drivers/scsi/ufs/ufshcd.c                                         |    6 
 drivers/soc/imx/soc-imx8m.c                                       |   10 
 drivers/spi/spi-nxp-fspi.c                                        |    7 
 drivers/spi/spi-stm32.c                                           |    8 
 drivers/spi/spi-sun6i.c                                           |   31 
 drivers/tty/n_gsm.c                                               |    4 
 drivers/tty/serial/8250/8250_port.c                               |    5 
 drivers/video/fbdev/Kconfig                                       |    2 
 drivers/watchdog/iTCO_wdt.c                                       |   26 
 fs/binfmt_elf_fdpic.c                                             |    5 
 fs/btrfs/delayed-inode.c                                          |    7 
 fs/btrfs/extent_io.c                                              |    8 
 fs/btrfs/super.c                                                  |    2 
 fs/cifs/inode.c                                                   |    2 
 fs/cifs/smb2ops.c                                                 |    6 
 fs/ext4/ext4.h                                                    |    2 
 fs/ext4/mballoc.c                                                 |   67 
 fs/nfs/direct.c                                                   |   25 
 fs/nfs/flexfilelayout/flexfilelayout.c                            |    1 
 fs/nfs/nfs4client.c                                               |    9 
 fs/nfs/nfs4proc.c                                                 |    4 
 fs/nfs/write.c                                                    |   23 
 fs/nilfs2/gcinode.c                                               |    6 
 fs/proc/task_nommu.c                                              |   27 
 fs/xfs/scrub/common.c                                             |   25 
 fs/xfs/scrub/common.h                                             |    2 
 fs/xfs/scrub/fscounters.c                                         |   13 
 fs/xfs/scrub/scrub.c                                              |    2 
 fs/xfs/scrub/scrub.h                                              |    1 
 fs/xfs/xfs_icache.c                                               |   92 
 fs/xfs/xfs_icache.h                                               |    1 
 fs/xfs/xfs_mount.h                                                |    5 
 fs/xfs/xfs_qm_syscalls.c                                          |    9 
 fs/xfs/xfs_super.c                                                |   12 
 fs/xfs/xfs_trace.h                                                |    1 
 include/linux/btf_ids.h                                           |    2 
 include/linux/cgroup.h                                            |    3 
 include/linux/if_team.h                                           |    2 
 include/linux/libata.h                                            |    4 
 include/linux/nfs_fs_sb.h                                         |    1 
 include/linux/nfs_page.h                                          |    4 
 include/linux/seqlock.h                                           |    2 
 include/net/netfilter/nf_tables.h                                 |  127 
 include/uapi/linux/bpf.h                                          |    4 
 io_uring/io_uring.c                                               |    2 
 kernel/bpf/queue_stack_maps.c                                     |   21 
 kernel/dma/debug.c                                                |   20 
 kernel/sched/core.c                                               |    2 
 kernel/sched/cpuacct.c                                            |    4 
 kernel/sched/cpupri.c                                             |    1 
 kernel/sched/idle.c                                               |    1 
 kernel/trace/ring_buffer.c                                        |   10 
 kernel/trace/trace.c                                              |   45 
 kernel/trace/trace.h                                              |    2 
 kernel/trace/trace_events.c                                       |    6 
 kernel/trace/trace_events_inject.c                                |    3 
 net/bridge/br_forward.c                                           |    4 
 net/bridge/br_input.c                                             |    4 
 net/core/flow_dissector.c                                         |    2 
 net/dccp/ipv4.c                                                   |    9 
 net/dccp/ipv6.c                                                   |    9 
 net/ipv4/route.c                                                  |    4 
 net/ncsi/ncsi-aen.c                                               |    5 
 net/netfilter/ipset/ip_set_core.c                                 |   12 
 net/netfilter/nf_tables_api.c                                     |  400 +-
 net/netfilter/nft_exthdr.c                                        |  110 
 net/netfilter/nft_set_hash.c                                      |   87 
 net/netfilter/nft_set_pipapo.c                                    |   69 
 net/netfilter/nft_set_rbtree.c                                    |  161 
 net/rds/rdma_transport.c                                          |   12 
 net/sunrpc/clnt.c                                                 |   15 
 security/smack/smack.h                                            |    1 
 security/smack/smack_lsm.c                                        |   65 
 sound/pci/hda/hda_intel.c                                         |    1 
 sound/soc/fsl/imx-audmix.c                                        |    2 
 sound/soc/fsl/imx-pcm-rpmsg.c                                     |    1 
 sound/soc/fsl/imx-rpmsg.c                                         |    8 
 sound/soc/meson/axg-spdifin.c                                     |   49 
 tools/include/linux/btf_ids.h                                     |    2 
 tools/include/uapi/linux/bpf.h                                    |    4 
 tools/perf/util/Build                                             |    6 
 tools/testing/selftests/ftrace/test.d/instances/instance-event.tc |    2 
 tools/testing/selftests/kselftest_deps.sh                         |   77 
 tools/testing/selftests/net/tls.c                                 |    8 
 327 files changed, 4040 insertions(+), 3540 deletions(-)

Adam Ford (1):
      bus: ti-sysc: Fix missing AM35xx SoC matching

Andrii Staikov (1):
      i40e: fix potential NULL pointer dereferencing of pf->vf i40e_sync_vsi_filters()

Andy Shevchenko (2):
      i2c: mux: gpio: Replace custom acpi_get_local_address()
      serial: 8250_port: Check IRQ data before use

Arnaldo Carvalho de Melo (1):
      perf build: Define YYNOMEM as YYNOABORT for bison < 3.81

Artem Chernyshev (1):
      net: rds: Fix possible NULL-pointer dereference

Ben Wolsieffer (1):
      proc: nommu: /proc/<pid>/maps: release mmap read lock

Benjamin Gray (3):
      powerpc/watchpoints: Disable preemption in thread_change_pc()
      powerpc/watchpoint: Disable pagefaults when getting user instruction
      powerpc/watchpoints: Annotate atomic context in more places

Chancel Liu (1):
      ASoC: imx-rpmsg: Set ignore_pmdown_time for dai_link

Chengming Zhou (2):
      sched/cpuacct: Optimize away RCU read lock
      cgroup: Fix suspicious rcu_dereference_check() usage warning

Christoph Hellwig (3):
      MIPS: Alchemy: only build mmc support helpers if au1xmmc is enabled
      nvme-pci: factor the iod mempool creation into a helper
      nvme-pci: factor out a nvme_pci_alloc_dev helper

Christophe JAILLET (2):
      gpio: tb10x: Fix an error handling path in tb10x_gpio_probe()
      firmware: imx-dsp: Fix an error handling path in imx_dsp_setup_channels()

Damien Le Moal (3):
      ata: libata-core: Fix ata_port_request_pm() locking
      ata: libata-core: Fix port and device removal
      ata: libata-core: Do not register PM operations for SAS ports

Dan Carpenter (1):
      power: supply: ucs1002: fix error code in ucs1002_get_property()

Daniel Starke (1):
      Revert "tty: n_gsm: fix UAF in gsm_cleanup_mux"

Darrick J. Wong (4):
      xfs: explicitly specify cpu when forcing inodegc delayed work to run immediately
      xfs: check that per-cpu inodegc workers actually run on that cpu
      xfs: disable reaping in fscounters scrub
      xfs: fix xfs_inodegc_stop racing with mod_delayed_work

Dave Chinner (2):
      xfs: bound maximum wait time for inodegc work
      xfs: introduce xfs_inodegc_push()

David Christensen (1):
      ionic: fix 16bit math issue when PAGE_SIZE >= 64KB

David Francis (1):
      drm/amdgpu: Handle null atom context in VBIOS info ioctl

David Thompson (1):
      platform/mellanox: mlxbf-bootctl: add NET dependency into Kconfig

Eric Dumazet (2):
      dccp: fix dccp_v4_err()/dccp_v6_err() again
      net: bridge: use DEV_STATS_INC()

Filipe Manana (1):
      btrfs: improve error message after failure to add delayed dir index item

Florian Westphal (7):
      netfilter: nf_tables: don't skip expired elements during walk
      netfilter: nf_tables: don't fail inserts if duplicate has expired
      netfilter: nf_tables: defer gc run if previous batch is still pending
      netfilter: nf_tables: fix memleak when more than 255 elements expired
      netfilter: nf_tables: disable toggling dormant table state more than once
      netfilter: exthdr: add support for tcp option removal
      netfilter: nf_tables: fix kdoc warnings after gc rework

Gleb Chesnokov (1):
      scsi: qla2xxx: Fix NULL pointer dereference in target mode

Greg Kroah-Hartman (1):
      Linux 5.15.134

Greg Ungerer (1):
      fs: binfmt_elf_efpic: fix personality for ELF-FDPIC

Han Xu (1):
      spi: nxp-fspi: reset the FLSHxCR1 registers

Hannes Reinecke (1):
      ata: ahci: Drop pointless VPRINTK() calls and convert the remaining ones

Hans Verkuil (1):
      media: vb2: frame_vector.c: replace WARN_ONCE with a comment

Heiner Kallweit (1):
      i2c: i801: unregister tco_pdev in i801_probe() error path

Helge Deller (4):
      parisc: sba: Fix compile warning wrt list of SBA devices
      parisc: iosapic.c: Fix sparse warnings
      parisc: drivers: Fix sparse warning
      parisc: irq: Make irq_stack_union static to avoid sparse warning

Huacai Chen (1):
      Input: i8042 - rename i8042-x86ia64io.h to i8042-acpipnpio.h

Irvin Cote (1):
      nvme-pci: always return an ERR_PTR from nvme_pci_alloc_dev

Ivan Vecera (1):
      i40e: Fix VF VLAN offloading when port VLAN is configured

Jan Kara (2):
      ext4: move setting of trimmed bit into ext4_try_to_trim_range()
      ext4: do not let fstrim block system suspend

Jani Nikula (1):
      drm/meson: fix memory leak on ->hpd_notify callback

Javed Hasan (1):
      scsi: qedf: Add synchronization between I/O completions and abort

Jens Axboe (1):
      io_uring/fs: remove sqe->rw_flags checking from LINKAT

Jerome Brunet (1):
      ASoC: meson: spdifin: start hw on dai probe

Jian Shen (1):
      net: hns3: only enable unicast promisc when mac table full

Jie Wang (2):
      net: hns3: fix GRE checksum offload issue
      net: hns3: add 5ms delay before clear firmware reset irq source

Jijie Shao (1):
      net: hns3: fix fail to delete tc flower rules during reset issue

Jiri Olsa (1):
      bpf: Fix BTF_ID symbol generation collision

Joel Fernandes (Google) (1):
      sched/rt: Fix live lock between select_fallback_rq() and RT push

John Keeping (1):
      tracing: Make trace_marker{,_raw} stream-like

Johnathan Mantey (1):
      ncsi: Propagate carrier gain/loss events to the NCSI controller

Josef Bacik (1):
      btrfs: properly report 0 avail for very full file systems

Josh Poimboeuf (2):
      x86/srso: Fix srso_show_state() side effect
      x86/srso: Fix SBPB enablement for spec_rstack_overflow=off

Jozsef Kadlecsik (1):
      netfilter: ipset: Fix race between IPSET_CMD_CREATE and IPSET_CMD_SWAP

Julien Panis (1):
      bus: ti-sysc: Use fsleep() instead of usleep_range() in sysc_reset()

Kailang Yang (1):
      ALSA: hda: Disable power save for solving pop issue on Lenovo ThinkCentre M70q

Kajol Jain (1):
      powerpc/perf/hv-24x7: Update domain value check

Kemeng Shi (1):
      ext4: replace the traditional ternary conditional operator with with max()/min()

Kiwoong Kim (1):
      scsi: ufs: core: Move __ufshcd_send_uic_cmd() outside host_lock

Krzysztof Kozlowski (1):
      ARM: dts: omap: correct indentation

Kyle Zeng (1):
      ipv4: fix null-deref in ipv4_link_failure

Liam R. Howlett (1):
      kernel/sched: Modify initial boot task idle setup

Liang He (1):
      i2c: mux: gpio: Add missing fwnode_handle_put()

Lukas Bulwahn (1):
      ext4: scope ret locally in ext4_try_to_trim_range()

Lukas Czerner (1):
      ext4: change s_last_trim_minblks type to unsigned long

Marek Vasut (1):
      drm/bridge: ti-sn65dsi83: Do not generate HFP/HBP/HSA and EOT packet

Mario Limonciello (1):
      ata: ahci: Rename board_ahci_mobile

Mateusz Palczewski (1):
      i40e: Add VF VLAN pruning

Matthias Schiffer (1):
      ata: libata-sata: increase PMP SRST timeout to 10s

Max Filippov (2):
      xtensa: add default definition for XCHAL_HAVE_DIV32
      xtensa: boot/lib: fix function prototypes

Michal Grzedzicki (2):
      scsi: pm80xx: Use phy-specific SAS address when sending PHY_START command
      scsi: pm80xx: Avoid leaking tags when processing OPC_INB_SET_CONTROLLER_CONFIG command

Mika Westerberg (3):
      watchdog: iTCO_wdt: No need to stop the timer in probe
      watchdog: iTCO_wdt: Set NO_REBOOT if the watchdog is not already running
      net: thunderbolt: Fix TCPv6 GSO checksum calculation

Muhammad Husaini Zulkifli (1):
      igc: Expose tx-usecs coalesce setting to user

Nathan Rossi (1):
      soc: imx8m: Enable OCOTP clock for imx8mm before reading registers

Nick Desaulniers (1):
      bpf: Fix BTF_ID symbol generation collision in tools/

Nicolin Chen (1):
      iommu/arm-smmu-v3: Fix soft lockup triggered by arm_smmu_mm_invalidate_range

Niklas Cassel (2):
      ata: libata-eh: do not clear ATA_PFLAG_EH_PENDING in ata_eh_reset()
      ata: libata-scsi: ignore reserved bits for REPORT SUPPORTED OPERATION CODES

Nilesh Javali (1):
      scsi: qla2xxx: Use raw_smp_processor_id() instead of smp_processor_id()

Olga Kornievskaia (2):
      NFSv4.1: use EXCHGID4_FLAG_USE_PNFS_DS for DS server
      NFSv4.1: fix pnfs MDS=DS session trunking

Pablo Neira Ayuso (15):
      netfilter: nf_tables: GC transaction API to avoid race with control plane
      netfilter: nf_tables: adapt set backend to use GC transaction API
      netfilter: nft_set_hash: mark set element as dead when deleting from packet path
      netfilter: nf_tables: remove busy mark and gc batch API
      netfilter: nf_tables: fix GC transaction races with netns and netlink event exit path
      netfilter: nf_tables: GC transaction race with netns dismantle
      netfilter: nf_tables: GC transaction race with abort path
      netfilter: nf_tables: use correct lock to protect gc_list
      netfilter: nft_set_rbtree: skip sync GC for new elements in this transaction
      netfilter: nft_set_rbtree: use read spinlock to avoid datapath contention
      netfilter: nft_set_pipapo: call nft_trans_gc_queue_sync() in catchall GC
      netfilter: nft_set_pipapo: stop GC iteration if GC transaction allocation fails
      netfilter: nft_set_hash: try later when GC hits EAGAIN on iteration
      netfilter: nf_tables: disallow element removal on anonymous sets
      netfilter: nf_tables: disallow rule removal from chain binding

Pan Bian (1):
      nilfs2: fix potential use after free in nilfs_gccache_submit_read_data()

Paul Menzel (2):
      ata: libata: Rename link flag ATA_LFLAG_NO_DB_DELAY
      ata: ahci: Add support for AMD A85 FCH (Hudson D4)

Pratyush Yadav (1):
      nvme-pci: do not set the NUMA node of device if it has none

Pu Wen (1):
      x86/srso: Add SRSO mitigation for Hygon processors

Qu Wenruo (1):
      btrfs: reset destination buffer when read_extent_buffer() gets invalid range

Radoslaw Tyl (1):
      iavf: do not process adminq tasks when __IAVF_IN_REMOVE_TASK is set

Randy Dunlap (2):
      xtensa: iss/network: make functions static
      xtensa: boot: don't add include-dirs

Ricardo B. Marliere (1):
      selftests: fix dependency checker script

Ricky WU (1):
      misc: rtsx: Fix some platforms can not boot and move the l1ss judgment to probe

Roberto Sassu (2):
      smack: Record transmuting in smk_transmuted
      smack: Retrieve transmuting information in smack_inode_getsecurity()

Sabrina Dubroca (1):
      selftests: tls: swap the TX and RX sockets in some tests

Sasha Levin (1):
      Fix up backport of 136191703038 ("interconnect: Teach lockdep about icc_bw_lock order")

Sasha Neftin (1):
      net/core: Fix ETH_P_1588 flow dissector

Sebastian Andrzej Siewior (3):
      locking/seqlock: Do the lockdep annotation before locking in do_write_seqcount_begin_nested()
      net: ena: Flush XDP packets on error.
      bnxt_en: Flush XDP for bnxt_poll_nitroa0()'s NAPI

Sergey Senozhatsky (1):
      dma-debug: don't call __dma_entry_alloc_check_leak() under free_entries_lock

Shengjiu Wang (2):
      ASoC: imx-audmix: Fix return error with devm_clk_get()
      ASoC: fsl: imx-pcm-rpmsg: Add SNDRV_PCM_INFO_BATCH flag

Shreyas Deodhar (1):
      scsi: qla2xxx: Select qpair depending on which CPU post_cmd() gets called

Stanislav Fomichev (1):
      bpf: Clarify error expectations from bpf_clone_redirect

Stephen Boyd (4):
      platform/x86: intel_scu_ipc: Check status after timeout in busy_loop()
      platform/x86: intel_scu_ipc: Check status upon timeout in ipc_wait_for_interrupt()
      platform/x86: intel_scu_ipc: Don't override scu in intel_scu_ipc_dev_simple_command()
      platform/x86: intel_scu_ipc: Fail IPC send if still busy

Steve French (1):
      smb3: correct places where ENOTSUPP is used instead of preferred EOPNOTSUPP

Steven Rostedt (Google) (4):
      tracing: Increase trace array ref count on enable and filter files
      tracing: Have event inject files inc the trace array ref count
      ring-buffer: Do not attempt to read past "commit"
      ring-buffer: Update "shortest_full" in polling

Swapnil Patel (1):
      drm/amd/display: Don't check registers, if using AUX BL control

Szuying Chen (1):
      ata: libahci: clear pending interrupt status

Thomas Gleixner (1):
      treewide: Replace GPLv2 boilerplate/reference with SPDX - gpl-2.0_56.RULE (part 1)

Thomas Zimmermann (1):
      fbdev/sh7760fb: Depend on FB=y

Timo Alho (1):
      clk: tegra: fix error return case for recalc_rate

Tobias Schramm (2):
      spi: sun6i: reduce DMA RX transfer width to single byte
      spi: sun6i: fix race between DMA RX transfer completion and RX FIFO drain

Toke Høiland-Jørgensen (1):
      bpf: Avoid deadlock when using queue and stack maps from NMI

Tony Lindgren (3):
      ARM: dts: ti: omap: Fix bandgap thermal cells addressing for omap3/4
      ARM: dts: ti: omap: motorola-mapphone: Fix abe_clkctrl warning on boot
      bus: ti-sysc: Fix SYSC_QUIRK_SWSUP_SIDLE_ACT handling for uart wake-up

Trond Myklebust (5):
      NFS: Use the correct commit info in nfs_join_page_group()
      NFS: More fixes for nfs_direct_write_reschedule_io()
      NFS/pNFS: Report EINVAL errors from connect() to the server
      SUNRPC: Mark the cred for revalidation if the server rejects it
      Revert "SUNRPC dont update timeout value on connection reset"

Valentin Caron (1):
      spi: stm32: add a delay before SPI disable

Vinicius Costa Gomes (1):
      igc: Fix infinite initialization loop with early XDP redirect

Vishal Goel (1):
      Smack:- Use overlay inode label in smack_inode_copy_up()

Wenhua Lin (1):
      gpio: pmic-eic-sprd: Add can_sleep flag for PMIC EIC chip

Werner Fischer (1):
      ata: ahci: Add Elkhart Lake AHCI controller

Werner Sembach (1):
      Input: i8042 - add quirk for TUXEDO Gemini 17 Gen1/Clevo PD70PN

William A. Kennington III (1):
      i2c: npcm7xx: Fix callback completion ordering

Xiao Liang (1):
      netfilter: nft_exthdr: Fix non-linear header modification

Xiaoke Wang (1):
      i2c: mux: demux-pinctrl: check the return value of devm_kstrdup()

Zheng Yejian (2):
      selftests/ftrace: Correctly enable event in instance-event.tc
      ring-buffer: Avoid softlockup in ring_buffer_resize()

Ziyang Xuan (1):
      team: fix null-ptr-deref when team device type is changed

