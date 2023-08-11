Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDB8778BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbjHKKSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbjHKKR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:17:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EE230DD;
        Fri, 11 Aug 2023 03:17:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A588F66EDF;
        Fri, 11 Aug 2023 10:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866C5C433CC;
        Fri, 11 Aug 2023 10:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691749050;
        bh=wxyLEPoIXU998GWIB/32rqi42anTQHCl5hCyyzX/kEo=;
        h=From:To:Cc:Subject:Date:From;
        b=LUMBV3BQ7E1OS5t6mr5Ph9bMkqVPqybcwxOeAAVsQJzvCEbfJGY2GFxa014XZG+W8
         3d01LY3mMpVZvAqJ6VAw2Su65V2R+StEhMdQJ1jAqDSZs/8pHX8zxlperc4IMN9Iw/
         0l3RP7/9dmg97jafDSssXqufrnCVdSzsDTwjrrHk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.291
Date:   Fri, 11 Aug 2023 12:17:13 +0200
Message-ID: <2023081114-zone-ebony-d4a9@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 4.19.291 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/security-bugs.rst                   |   39 
 MAINTAINERS                                                   |   10 
 Makefile                                                      |    2 
 arch/arc/include/asm/entry-arcv2.h                            |  362 +++---
 arch/arc/include/asm/linkage.h                                |   22 
 arch/arc/kernel/asm-offsets.c                                 |    7 
 arch/arc/kernel/entry-arcv2.S                                 |    4 
 arch/arc/mm/tlbex.S                                           |   11 
 arch/arm/boot/dts/bcm5301x.dtsi                               |    1 
 arch/arm/boot/dts/imx6qdl.dtsi                                |    4 
 arch/arm/boot/dts/imx6sl.dtsi                                 |    3 
 arch/arm/boot/dts/imx6sll.dtsi                                |   32 
 arch/arm/boot/dts/imx6sx.dtsi                                 |    3 
 arch/arm/boot/dts/imx6ul.dtsi                                 |    2 
 arch/arm/boot/dts/imx7d.dtsi                                  |    6 
 arch/arm/boot/dts/imx7s.dtsi                                  |    2 
 arch/arm/mach-ep93xx/timer-ep93xx.c                           |    3 
 arch/arm/mach-orion5x/board-dt.c                              |    3 
 arch/arm/mach-orion5x/common.h                                |    6 
 arch/arm/mach-sa1100/assabet.c                                |    2 
 arch/arm/probes/kprobes/checkers-common.c                     |    2 
 arch/arm/probes/kprobes/core.c                                |    2 
 arch/arm/probes/kprobes/opt-arm.c                             |    2 
 arch/arm/probes/kprobes/test-core.c                           |    2 
 arch/arm/probes/kprobes/test-core.h                           |    4 
 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts        |    2 
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi                      |    3 
 arch/ia64/kernel/process.c                                    |    2 
 arch/ia64/mm/discontig.c                                      |    2 
 arch/ia64/mm/tlb.c                                            |    2 
 arch/powerpc/Kconfig.debug                                    |    2 
 arch/powerpc/include/asm/word-at-a-time.h                     |    2 
 arch/powerpc/mm/init_64.c                                     |    3 
 arch/powerpc/platforms/52xx/mpc52xx_pic.c                     |    2 
 arch/s390/kernel/smp.c                                        |    2 
 arch/s390/kernel/sthyi.c                                      |    6 
 arch/s390/kvm/intercept.c                                     |    9 
 arch/s390/kvm/kvm-s390.c                                      |    4 
 arch/sh/drivers/dma/dma-sh.c                                  |   37 
 arch/sh/kernel/cpu/sh2/probe.c                                |    2 
 arch/x86/kernel/quirks.c                                      |   10 
 arch/x86/kernel/smpboot.c                                     |   24 
 arch/xtensa/platforms/iss/network.c                           |    2 
 drivers/acpi/acpi_pad.c                                       |    2 
 drivers/ata/libata-scsi.c                                     |    2 
 drivers/ata/pata_ns87415.c                                    |    2 
 drivers/atm/zatm.c                                            |    2 
 drivers/base/arch_topology.c                                  |    2 
 drivers/base/cacheinfo.c                                      |   18 
 drivers/base/core.c                                           |    8 
 drivers/base/cpu.c                                            |   34 
 drivers/base/firmware_loader/fallback.c                       |    2 
 drivers/base/memory.c                                         |   24 
 drivers/base/node.c                                           |   34 
 drivers/base/platform.c                                       |    2 
 drivers/base/power/domain.c                                   |    6 
 drivers/base/power/power.h                                    |    8 
 drivers/base/power/runtime.c                                  |    6 
 drivers/base/power/sysfs.c                                    |   50 
 drivers/base/power/wakeirq.c                                  |  111 +
 drivers/base/soc.c                                            |    8 
 drivers/block/drbd/drbd_nl.c                                  |    6 
 drivers/block/loop.c                                          |    3 
 drivers/block/nbd.c                                           |    3 
 drivers/char/hw_random/imx-rngc.c                             |    6 
 drivers/char/hw_random/virtio-rng.c                           |   88 +
 drivers/char/tpm/tpm_tis_core.c                               |   10 
 drivers/char/tpm/tpm_vtpm_proxy.c                             |   30 
 drivers/clk/clk-gate.c                                        |    2 
 drivers/clocksource/Makefile                                  |   26 
 drivers/clocksource/cadence_ttc_timer.c                       |  543 ---------
 drivers/clocksource/fsl_ftm_timer.c                           |  376 ------
 drivers/clocksource/owl-timer.c                               |  173 ---
 drivers/clocksource/qcom-timer.c                              |  258 ----
 drivers/clocksource/time-armada-370-xp.c                      |  416 -------
 drivers/clocksource/time-efm32.c                              |  287 -----
 drivers/clocksource/time-lpc32xx.c                            |  314 -----
 drivers/clocksource/time-orion.c                              |  192 ---
 drivers/clocksource/time-pistachio.c                          |  218 ---
 drivers/clocksource/timer-armada-370-xp.c                     |  416 +++++++
 drivers/clocksource/timer-cadence-ttc.c                       |  560 ++++++++++
 drivers/clocksource/timer-efm32.c                             |  287 +++++
 drivers/clocksource/timer-fsl-ftm.c                           |  376 ++++++
 drivers/clocksource/timer-lpc32xx.c                           |  314 +++++
 drivers/clocksource/timer-orion.c                             |  192 +++
 drivers/clocksource/timer-owl.c                               |  173 +++
 drivers/clocksource/timer-pistachio.c                         |  218 +++
 drivers/clocksource/timer-qcom.c                              |  258 ++++
 drivers/clocksource/timer-versatile.c                         |   44 
 drivers/clocksource/timer-vf-pit.c                            |  204 +++
 drivers/clocksource/timer-vt8500.c                            |  168 +++
 drivers/clocksource/timer-zevio.c                             |  218 +++
 drivers/clocksource/versatile.c                               |   44 
 drivers/clocksource/vf_pit_timer.c                            |  204 ---
 drivers/clocksource/vt8500_timer.c                            |  168 ---
 drivers/clocksource/zevio-timer.c                             |  218 ---
 drivers/crypto/nx/Makefile                                    |    2 
 drivers/crypto/nx/nx.h                                        |    4 
 drivers/extcon/extcon.c                                       |    8 
 drivers/firewire/ohci.c                                       |   14 
 drivers/gpio/gpio-tps68470.c                                  |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                        |    4 
 drivers/gpu/drm/bridge/sil-sii8620.c                          |    2 
 drivers/gpu/drm/drm_atomic.c                                  |   11 
 drivers/gpu/drm/drm_edid.c                                    |    4 
 drivers/gpu/drm/drm_fb_helper.c                               |    5 
 drivers/gpu/drm/exynos/exynos_drm_dsi.c                       |    6 
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c                         |    2 
 drivers/gpu/drm/panel/panel-simple.c                          |    4 
 drivers/gpu/drm/radeon/ci_dpm.c                               |   28 
 drivers/gpu/drm/radeon/cypress_dpm.c                          |    8 
 drivers/gpu/drm/radeon/ni_dpm.c                               |    8 
 drivers/gpu/drm/radeon/rv740_dpm.c                            |    8 
 drivers/hwmon/nct7802.c                                       |    2 
 drivers/i2c/busses/i2c-rk3x.c                                 |    2 
 drivers/i2c/busses/i2c-xiic.c                                 |   39 
 drivers/ide/ide-acpi.c                                        |    2 
 drivers/ide/ide-atapi.c                                       |    2 
 drivers/ide/ide-io-std.c                                      |    4 
 drivers/ide/ide-io.c                                          |    8 
 drivers/ide/ide-sysfs.c                                       |    2 
 drivers/ide/umc8672.c                                         |    2 
 drivers/iio/adc/meson_saradc.c                                |    2 
 drivers/infiniband/core/uverbs_cmd.c                          |    4 
 drivers/infiniband/hw/cxgb4/cm.c                              |    2 
 drivers/infiniband/hw/cxgb4/cq.c                              |    2 
 drivers/infiniband/hw/hfi1/sdma.c                             |    4 
 drivers/infiniband/hw/hfi1/sdma.h                             |   15 
 drivers/infiniband/hw/mlx4/qp.c                               |   24 
 drivers/infiniband/hw/mlx5/cq.c                               |    2 
 drivers/infiniband/hw/mthca/mthca_qp.c                        |   10 
 drivers/input/misc/adxl34x.c                                  |    3 
 drivers/input/misc/drv260x.c                                  |    1 
 drivers/input/serio/serio_raw.c                               |    2 
 drivers/irqchip/irq-bcm6345-l1.c                              |   14 
 drivers/irqchip/irq-jcore-aic.c                               |   11 
 drivers/mailbox/ti-msgmgr.c                                   |   12 
 drivers/md/bcache/alloc.c                                     |   35 
 drivers/md/bcache/bcache.h                                    |    4 
 drivers/md/bcache/btree.c                                     |   16 
 drivers/md/bcache/super.c                                     |    6 
 drivers/md/dm-cache-policy-smq.c                              |   28 
 drivers/md/dm-io.c                                            |    2 
 drivers/md/dm-ioctl.c                                         |    2 
 drivers/md/dm-raid.c                                          |    9 
 drivers/md/dm-snap-persistent.c                               |    2 
 drivers/md/dm-table.c                                         |    2 
 drivers/md/md-bitmap.c                                        |   17 
 drivers/md/md.c                                               |   23 
 drivers/md/raid0.c                                            |   62 -
 drivers/md/raid0.h                                            |    1 
 drivers/md/raid10.c                                           |   24 
 drivers/md/raid5.c                                            |    2 
 drivers/media/dvb-frontends/rtl2832.c                         |    2 
 drivers/media/tuners/qt1010.c                                 |    4 
 drivers/media/usb/dvb-usb-v2/az6007.c                         |    3 
 drivers/media/usb/gspca/vicam.c                               |    2 
 drivers/media/usb/siano/smsusb.c                              |    3 
 drivers/media/usb/uvc/uvc_video.c                             |    8 
 drivers/memstick/host/jmb38x_ms.c                             |    2 
 drivers/memstick/host/r592.c                                  |    4 
 drivers/memstick/host/tifm_ms.c                               |    2 
 drivers/mfd/intel-lpss-acpi.c                                 |    3 
 drivers/mfd/rt5033.c                                          |    3 
 drivers/mfd/stmpe.c                                           |    4 
 drivers/misc/pci_endpoint_test.c                              |   10 
 drivers/mmc/core/quirks.h                                     |   14 
 drivers/mmc/host/sdhci.c                                      |    2 
 drivers/mtd/nand/raw/nand_ecc.c                               |    2 
 drivers/mtd/nand/raw/omap_elm.c                               |   24 
 drivers/mtd/nand/raw/s3c2410.c                                |    2 
 drivers/mtd/ubi/eba.c                                         |    2 
 drivers/net/bonding/bond_main.c                               |    5 
 drivers/net/can/janz-ican3.c                                  |    2 
 drivers/net/can/usb/gs_usb.c                                  |    2 
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c               |    7 
 drivers/net/ethernet/broadcom/bnx2.c                          |    4 
 drivers/net/ethernet/broadcom/genet/bcmmii.c                  |    2 
 drivers/net/ethernet/broadcom/tg3.c                           |    1 
 drivers/net/ethernet/emulex/benet/be_main.c                   |    3 
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c                |    2 
 drivers/net/ethernet/intel/igb/igb_main.c                     |    5 
 drivers/net/ethernet/marvell/mvneta.c                         |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c |    4 
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c           |    4 
 drivers/net/ethernet/microchip/lan743x_main.c                 |   21 
 drivers/net/ethernet/neterion/s2io.c                          |    2 
 drivers/net/ethernet/qlogic/qla3xxx.c                         |    2 
 drivers/net/ethernet/sun/cassini.c                            |    2 
 drivers/net/ethernet/sun/niu.c                                |    6 
 drivers/net/ethernet/ti/cpsw_ale.c                            |   24 
 drivers/net/gtp.c                                             |    2 
 drivers/net/ipvlan/ipvlan_core.c                              |    9 
 drivers/net/team/team.c                                       |    9 
 drivers/net/usb/cdc_ether.c                                   |   21 
 drivers/net/usb/usbnet.c                                      |    6 
 drivers/net/usb/zaurus.c                                      |   21 
 drivers/net/virtio_net.c                                      |    4 
 drivers/net/wan/z85230.c                                      |    2 
 drivers/net/wireless/ath/ath10k/core.c                        |    2 
 drivers/net/wireless/ath/ath6kl/init.c                        |    2 
 drivers/net/wireless/ath/ath9k/ar9003_hw.c                    |   27 
 drivers/net/wireless/ath/ath9k/htc_hst.c                      |    8 
 drivers/net/wireless/ath/ath9k/init.c                         |    2 
 drivers/net/wireless/ath/ath9k/main.c                         |   11 
 drivers/net/wireless/ath/ath9k/wmi.c                          |    4 
 drivers/net/wireless/atmel/atmel_cs.c                         |   13 
 drivers/net/wireless/broadcom/b43/debugfs.c                   |    2 
 drivers/net/wireless/broadcom/b43/dma.c                       |    2 
 drivers/net/wireless/broadcom/b43/lo.c                        |    2 
 drivers/net/wireless/broadcom/b43/phy_n.c                     |    2 
 drivers/net/wireless/broadcom/b43/xmit.c                      |   12 
 drivers/net/wireless/broadcom/b43legacy/debugfs.c             |    2 
 drivers/net/wireless/broadcom/b43legacy/main.c                |    2 
 drivers/net/wireless/cisco/airo.c                             |    5 
 drivers/net/wireless/intel/iwlegacy/3945.c                    |    2 
 drivers/net/wireless/intel/iwlegacy/4965-mac.c                |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c                  |    2 
 drivers/net/wireless/intersil/orinoco/orinoco_cs.c            |   13 
 drivers/net/wireless/intersil/orinoco/spectrum_cs.c           |   13 
 drivers/net/wireless/marvell/mwifiex/scan.c                   |    6 
 drivers/net/wireless/ray_cs.c                                 |   36 
 drivers/net/wireless/rsi/rsi_91x_sdio.c                       |    3 
 drivers/net/wireless/wl3501_cs.c                              |   51 
 drivers/ntb/hw/amd/ntb_hw_amd.c                               |    7 
 drivers/ntb/hw/idt/ntb_hw_idt.c                               |    7 
 drivers/ntb/hw/intel/ntb_hw_gen1.c                            |    7 
 drivers/ntb/ntb_transport.c                                   |    2 
 drivers/ntb/test/ntb_tool.c                                   |    2 
 drivers/pci/controller/dwc/pcie-qcom.c                        |    2 
 drivers/pci/controller/pcie-rockchip-ep.c                     |   64 -
 drivers/pci/controller/pcie-rockchip.c                        |   17 
 drivers/pci/controller/pcie-rockchip.h                        |   11 
 drivers/pci/pci.c                                             |   10 
 drivers/pci/pcie/aspm.c                                       |   57 -
 drivers/pci/quirks.c                                          |    2 
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c                    |    2 
 drivers/pinctrl/intel/pinctrl-cherryview.c                    |   15 
 drivers/pinctrl/pinctrl-amd.c                                 |   41 
 drivers/pinctrl/pinctrl-amd.h                                 |    1 
 drivers/pinctrl/pinctrl-at91-pio4.c                           |    2 
 drivers/platform/x86/hdaps.c                                  |    4 
 drivers/platform/x86/msi-laptop.c                             |    8 
 drivers/rtc/rtc-st-lpc.c                                      |    2 
 drivers/s390/block/dasd_ioctl.c                               |    1 
 drivers/s390/scsi/zfcp_fc.c                                   |    6 
 drivers/scsi/3w-xxxx.c                                        |    4 
 drivers/scsi/dc395x.c                                         |    2 
 drivers/scsi/pm8001/pm8001_hwi.c                              |    2 
 drivers/scsi/pm8001/pm80xx_hwi.c                              |    2 
 drivers/scsi/qla2xxx/qla_attr.c                               |   13 
 drivers/scsi/qla2xxx/qla_bsg.c                                |    6 
 drivers/scsi/qla2xxx/qla_iocb.c                               |    3 
 drivers/scsi/qla2xxx/qla_os.c                                 |    5 
 drivers/soc/fsl/qe/Kconfig                                    |    1 
 drivers/spi/spi-bcm-qspi.c                                    |   10 
 drivers/spi/spi-bcm63xx.c                                     |    2 
 drivers/spi/spi-fsl-spi.c                                     |   25 
 drivers/ssb/driver_chipcommon.c                               |    4 
 drivers/staging/ks7010/ks_wlan_net.c                          |    6 
 drivers/tty/cyclades.c                                        |    2 
 drivers/tty/isicom.c                                          |    2 
 drivers/tty/serial/8250/8250.h                                |    1 
 drivers/tty/serial/8250/8250_dwlib.c                          |  128 ++
 drivers/tty/serial/8250/8250_dwlib.h                          |   19 
 drivers/tty/serial/8250/8250_pci.c                            |   19 
 drivers/tty/serial/8250/8250_port.c                           |   11 
 drivers/tty/serial/8250/Kconfig                               |    3 
 drivers/tty/serial/8250/Makefile                              |    1 
 drivers/tty/serial/atmel_serial.c                             |    4 
 drivers/tty/serial/samsung.c                                  |   14 
 drivers/usb/core/quirks.c                                     |    4 
 drivers/usb/dwc3/core.c                                       |   20 
 drivers/usb/dwc3/core.h                                       |    3 
 drivers/usb/dwc3/dwc3-pci.c                                   |    6 
 drivers/usb/host/ohci-at91.c                                  |    8 
 drivers/usb/host/xhci-mtk.c                                   |    1 
 drivers/usb/musb/cppi_dma.c                                   |    2 
 drivers/usb/phy/phy-tahvo.c                                   |    2 
 drivers/usb/serial/option.c                                   |   10 
 drivers/usb/serial/usb-serial-simple.c                        |   73 -
 drivers/usb/storage/sddr55.c                                  |    4 
 drivers/vhost/net.c                                           |    4 
 drivers/video/fbdev/au1200fb.c                                |    3 
 drivers/video/fbdev/imsttfb.c                                 |   36 
 drivers/video/fbdev/imxfb.c                                   |    4 
 drivers/video/fbdev/matrox/matroxfb_maven.c                   |    6 
 drivers/video/fbdev/omap/lcd_mipid.c                          |    6 
 drivers/video/fbdev/pm3fb.c                                   |    6 
 drivers/video/fbdev/riva/riva_hw.c                            |    3 
 drivers/virtio/virtio_ring.c                                  |    2 
 drivers/w1/w1.c                                               |    4 
 fs/afs/dir.c                                                  |    2 
 fs/afs/security.c                                             |    2 
 fs/btrfs/ctree.c                                              |    2 
 fs/btrfs/qgroup.c                                             |    2 
 fs/btrfs/transaction.c                                        |    9 
 fs/ceph/caps.c                                                |    9 
 fs/dlm/netlink.c                                              |    2 
 fs/dlm/plock.c                                                |  104 +
 fs/ext2/ext2.h                                                |   12 
 fs/ext2/super.c                                               |   23 
 fs/ext4/ext4.h                                                |    2 
 fs/ext4/fsmap.c                                               |    8 
 fs/ext4/indirect.c                                            |    8 
 fs/ext4/inode.c                                               |   10 
 fs/ext4/ioctl.c                                               |    5 
 fs/ext4/mballoc.c                                             |    4 
 fs/ext4/super.c                                               |   25 
 fs/ext4/xattr.c                                               |   14 
 fs/f2fs/node.c                                                |    4 
 fs/fat/dir.c                                                  |    2 
 fs/fuse/control.c                                             |    2 
 fs/fuse/cuse.c                                                |    2 
 fs/fuse/dir.c                                                 |    2 
 fs/fuse/file.c                                                |    2 
 fs/gfs2/aops.c                                                |    2 
 fs/gfs2/bmap.c                                                |    2 
 fs/gfs2/super.c                                               |    8 
 fs/hfsplus/unicode.c                                          |    2 
 fs/isofs/namei.c                                              |    4 
 fs/jffs2/build.c                                              |    5 
 fs/jffs2/erase.c                                              |    2 
 fs/jffs2/xattr.c                                              |   13 
 fs/jffs2/xattr.h                                              |    4 
 fs/jfs/jfs_dmap.c                                             |    6 
 fs/jfs/jfs_filsys.h                                           |    2 
 fs/nfsd/nfs4xdr.c                                             |    2 
 fs/nfsd/nfsctl.c                                              |    2 
 fs/ocfs2/alloc.c                                              |    4 
 fs/ocfs2/dir.c                                                |   14 
 fs/ocfs2/extent_map.c                                         |    4 
 fs/ocfs2/namei.c                                              |    2 
 fs/ocfs2/refcounttree.c                                       |    2 
 fs/ocfs2/xattr.c                                              |    2 
 fs/omfs/file.c                                                |    2 
 fs/overlayfs/copy_up.c                                        |    2 
 fs/sysv/itree.c                                               |    4 
 fs/ubifs/commit.c                                             |    6 
 fs/ubifs/dir.c                                                |    2 
 fs/ubifs/file.c                                               |    4 
 fs/ubifs/journal.c                                            |    2 
 fs/ubifs/lpt.c                                                |    2 
 fs/ubifs/tnc.c                                                |    6 
 fs/ubifs/tnc_misc.c                                           |    4 
 fs/udf/balloc.c                                               |    2 
 fs/xfs/xfs_bmap_util.c                                        |    2 
 include/asm-generic/word-at-a-time.h                          |    2 
 include/linux/etherdevice.h                                   |   12 
 include/linux/netdevice.h                                     |   18 
 include/linux/netfilter/nfnetlink.h                           |   27 
 include/linux/nmi.h                                           |    2 
 include/linux/pci.h                                           |    1 
 include/linux/pm_wakeirq.h                                    |    9 
 include/linux/sched/signal.h                                  |    2 
 include/linux/serial_8250.h                                   |    1 
 include/linux/tcp.h                                           |    2 
 include/linux/workqueue.h                                     |   15 
 include/net/addrconf.h                                        |   16 
 include/net/ipv6.h                                            |    8 
 include/net/netfilter/nf_tables.h                             |   14 
 include/net/netns/nftables.h                                  |    5 
 include/net/nfc/nfc.h                                         |    4 
 include/net/pkt_sched.h                                       |    2 
 include/net/sock.h                                            |    1 
 include/net/tcp.h                                             |    7 
 include/uapi/linux/affs_hardblocks.h                          |   68 -
 include/uapi/linux/blkzoned.h                                 |   10 
 include/uapi/linux/videodev2.h                                |    2 
 kernel/async.c                                                |    4 
 kernel/audit.c                                                |    2 
 kernel/bpf/bpf_lru_list.c                                     |   21 
 kernel/bpf/bpf_lru_list.h                                     |    7 
 kernel/dma/debug.c                                            |    2 
 kernel/events/core.c                                          |   10 
 kernel/events/uprobes.c                                       |    2 
 kernel/exit.c                                                 |    2 
 kernel/futex.c                                                |   12 
 kernel/kexec_core.c                                           |    5 
 kernel/locking/lockdep.c                                      |    6 
 kernel/sched/fair.c                                           |    2 
 kernel/time/posix-timers.c                                    |   31 
 kernel/trace/ftrace.c                                         |   75 -
 kernel/trace/ring_buffer.c                                    |   48 
 kernel/trace/trace.c                                          |   21 
 kernel/trace/trace.h                                          |    2 
 kernel/trace/trace_events.c                                   |   14 
 kernel/trace/trace_events_hist.c                              |    9 
 kernel/watchdog_hld.c                                         |    6 
 kernel/workqueue.c                                            |   13 
 lib/debugobjects.c                                            |    9 
 lib/radix-tree.c                                              |    2 
 lib/test_firmware.c                                           |   18 
 lib/ts_bm.c                                                   |    4 
 mm/frontswap.c                                                |    2 
 mm/ksm.c                                                      |    2 
 mm/memcontrol.c                                               |    2 
 mm/mempolicy.c                                                |    4 
 mm/percpu.c                                                   |    2 
 mm/slub.c                                                     |    4 
 mm/swap.c                                                     |    4 
 net/bluetooth/l2cap_sock.c                                    |    2 
 net/bridge/br_if.c                                            |    5 
 net/can/bcm.c                                                 |   12 
 net/ceph/osd_client.c                                         |   20 
 net/core/rtnetlink.c                                          |    8 
 net/core/sock.c                                               |   23 
 net/dccp/options.c                                            |    2 
 net/ipv4/inet_hashtables.c                                    |   17 
 net/ipv4/inet_timewait_sock.c                                 |    8 
 net/ipv4/netfilter/nf_socket_ipv4.c                           |    6 
 net/ipv4/tcp.c                                                |   27 
 net/ipv4/tcp_fastopen.c                                       |    6 
 net/ipv4/tcp_input.c                                          |   12 
 net/ipv4/tcp_metrics.c                                        |   70 -
 net/ipv6/addrconf.c                                           |   17 
 net/ipv6/icmp.c                                               |   22 
 net/ipv6/ip6_flowlabel.c                                      |    2 
 net/ipv6/ip6_gre.c                                            |    3 
 net/ipv6/ip6mr.c                                              |    2 
 net/ipv6/netfilter/nf_socket_ipv6.c                           |    2 
 net/ipv6/reassembly.c                                         |    4 
 net/ipv6/udp.c                                                |    2 
 net/llc/llc_input.c                                           |    3 
 net/netfilter/ipset/ip_set_core.c                             |   17 
 net/netfilter/nf_conntrack_ftp.c                              |    2 
 net/netfilter/nf_conntrack_helper.c                           |    4 
 net/netfilter/nf_conntrack_netlink.c                          |   77 -
 net/netfilter/nf_conntrack_sip.c                              |    2 
 net/netfilter/nf_tables_api.c                                 |  486 +++++---
 net/netfilter/nf_tables_trace.c                               |    9 
 net/netfilter/nfnetlink_acct.c                                |   11 
 net/netfilter/nfnetlink_cthelper.c                            |   11 
 net/netfilter/nfnetlink_cttimeout.c                           |   22 
 net/netfilter/nfnetlink_log.c                                 |   13 
 net/netfilter/nfnetlink_queue.c                               |   16 
 net/netfilter/nft_byteorder.c                                 |   14 
 net/netfilter/nft_chain_filter.c                              |   11 
 net/netfilter/nft_compat.c                                    |   11 
 net/netfilter/nft_dynset.c                                    |    6 
 net/netlink/af_netlink.c                                      |    5 
 net/netlink/diag.c                                            |    7 
 net/nfc/core.c                                                |    4 
 net/nfc/hci/llc_shdlc.c                                       |   10 
 net/nfc/llcp.h                                                |    8 
 net/nfc/llcp_commands.c                                       |   47 
 net/nfc/llcp_core.c                                           |   44 
 net/nfc/nfc.h                                                 |    2 
 net/sched/act_pedit.c                                         |    1 
 net/sched/cls_flow.c                                          |    2 
 net/sched/cls_fw.c                                            |   10 
 net/sched/cls_route.c                                         |    1 
 net/sched/cls_u32.c                                           |   77 +
 net/sched/sch_cake.c                                          |    2 
 net/sched/sch_cbq.c                                           |    2 
 net/sched/sch_fq_codel.c                                      |    2 
 net/sched/sch_mqprio.c                                        |  144 +-
 net/sched/sch_qfq.c                                           |    7 
 net/sched/sch_sfq.c                                           |    2 
 net/sctp/socket.c                                             |    4 
 net/sunrpc/svcsock.c                                          |   27 
 net/unix/af_unix.c                                            |    2 
 net/wireless/wext-core.c                                      |    6 
 samples/bpf/tcp_basertt_kern.c                                |    2 
 scripts/mod/modpost.c                                         |   24 
 scripts/tags.sh                                               |    9 
 security/integrity/evm/evm_main.c                             |    2 
 security/integrity/iint.c                                     |   15 
 sound/core/control_compat.c                                   |    2 
 sound/core/jack.c                                             |   15 
 sound/isa/sb/sb16_csp.c                                       |    2 
 sound/pci/ac97/ac97_codec.c                                   |    4 
 sound/soc/codecs/cs42l51-i2c.c                                |    6 
 sound/soc/codecs/cs42l51.c                                    |    7 
 sound/soc/codecs/cs42l51.h                                    |    1 
 sound/soc/codecs/es8316.c                                     |    9 
 sound/soc/codecs/wm8904.c                                     |    3 
 sound/soc/fsl/fsl_spdif.c                                     |    2 
 sound/usb/endpoint.c                                          |    2 
 tools/perf/tests/shell/test_uprobe_from_different_cu.sh       |   83 +
 tools/perf/util/dwarf-aux.c                                   |    2 
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c           |    2 
 482 files changed, 6834 insertions(+), 5493 deletions(-)

Adrian Hunter (1):
      perf intel-pt: Fix CYC timestamps after standalone CBR

Ahmed S. Darwish (1):
      scripts/tags.sh: Resolve gtags empty index generation

Alan Stern (1):
      net: usbnet: Fix WARNING in usbnet_start_xmit/usb_submit_urb

Alex Dewar (1):
      wl3501_cs: Remove unnecessary NULL check

Alexander Aring (4):
      fs: dlm: return positive pid value for F_GETLK
      dlm: cleanup plock_op vs plock_xop
      dlm: rearrange async condition return
      fs: dlm: interrupt posix locks only when process is killed

Alexander Steffen (1):
      tpm_tis: Explicitly check for error code

Andreas Kemnade (1):
      ARM: dts: imx6sll: fixup of operating points

Andy Shevchenko (6):
      wifi: ray_cs: Utilize strnlen() in parse_addr()
      wifi: ray_cs: Drop useless status variable in parse_addr()
      pinctrl: cherryview: Return correct value if pin in push-pull mode
      extcon: Fix kernel doc of property fields to avoid warnings
      extcon: Fix kernel doc of property capability fields to avoid warnings
      serial: 8250_dw: split Synopsys DesignWare 8250 common functions

Aneesh Kumar K.V (1):
      powerpc/mm/altmap: Fix altmap boundary check

Arnd Bergmann (5):
      ARM: 9303/1: kprobes: avoid missing-declaration warnings
      memstick r592: make memstick_debug_get_tpc_name() static
      ARM: ep93xx: fix missing-prototype warnings
      ARM: orion5x: fix d2net gpio initialization
      ata: pata_ns87415: mark ns87560_tf_read static

Artur Rojek (1):
      sh: dma: Fix DMA channel offset calculation

Baokun Li (1):
      ext4: only update i_reserved_data_blocks on successful block allocation

Bart Van Assche (2):
      block: Fix a source code comment in include/uapi/linux/blkzoned.h
      loop: Select I/O scheduler 'none' from inside add_disk()

Bas Nieuwenhuizen (1):
      drm/amdgpu: Validate VM ioctl flags.

Bikash Hazarika (1):
      scsi: qla2xxx: Fix potential NULL pointer dereference

Bjorn Helgaas (1):
      PCI/ASPM: Return 0 or -ETIMEDOUT from pcie_retrain_link()

Bob Peterson (1):
      gfs2: Don't deref jdesc in evict

Cambda Zhu (2):
      ipvlan: Fix return value of ipvlan_queue_xmit()
      net: Replace the limit of TCP_LINGER2 with TCP_FIN_TIMEOUT_MAX

Chao Yu (2):
      f2fs: fix error path handling in truncate_dnode()
      ext4: fix to check return value of freeze_bdev() in ext4_shutdown()

Chengfeng Ye (1):
      sctp: fix potential deadlock on &net->sctp.addr_wq_lock

Christophe JAILLET (11):
      wifi: mwifiex: Fix the size of a memory allocation in mwifiex_ret_802_11_scan()
      wifi: orinoco: Fix an error handling path in spectrum_cs_probe()
      wifi: orinoco: Fix an error handling path in orinoco_cs_probe()
      wifi: atmel: Fix an error handling path in atmel_probe()
      wifi: wl3501_cs: Fix an error handling path in wl3501_probe()
      wifi: ray_cs: Fix an error handling path in ray_probe()
      fbdev: omapfb: lcd_mipid: Fix an error handling path in mipid_spi_probe()
      mfd: stmpe: Only disable the regulators if they are enabled
      rtc: st-lpc: Release some resources in st_rtc_probe() in case of error
      tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() in case of error
      tty: serial: samsung_tty: Fix a memory leak in s3c24xx_serial_getclk() when iterating clk

Chunfeng Yun (1):
      PM / wakeirq: support enabling wake-up irq after runtime_suspend called

Chunguang Xu (1):
      ext4: rename journal_dev to s_journal_dev inside ext4_sb_info

Claudiu Beznea (1):
      pinctrl: at91-pio4: check return value of devm_kasprintf()

Coly Li (1):
      bcache: remove 'int n' from parameter list of bch_bucket_alloc_set()

Cristian Ciocaltea (1):
      ASoC: es8316: Increment max value for ALC Capture Target Volume control

Dai Ngo (1):
      NFSD: add encoding of op_recall flag for write delegation

Damien Le Moal (2):
      misc: pci_endpoint_test: Free IRQs before removing the device
      misc: pci_endpoint_test: Re-init completion for every test

Dan Carpenter (3):
      w1: fix loop in w1_fini()
      serial: atmel: don't enable IRQs prematurely
      RDMA/mlx4: Make check for invalid flags stricter

Daniel Lezcano (1):
      clocksource/drivers: Unify the names to timer-* format

Daniel Vetter (1):
      drm/atomic: Fix potential use-after-free in nonblocking commits

Daniil Dulov (1):
      media: usb: Check az6007_read() return value

Dario Binacchi (1):
      drm/panel: simple: fix active size for Ampire AM-480272H3TMQW-T01H

Davide Tronchin (1):
      USB: serial: option: add LARA-R6 01B PIDs

Ding Hui (1):
      SUNRPC: Fix UAF in svc_tcp_listen_data_ready()

Dinh Nguyen (1):
      arm64: dts: stratix10: fix incorrect I2C property for SCL signal

Dmitry Antipov (1):
      wifi: ath9k: convert msecs to jiffies where needed

Douglas Anderson (2):
      watchdog/perf: define dummy watchdog_update_hrtimer_threshold() on correct config
      watchdog/perf: more properly prevent false positives with turbo modes

Duoming Zhou (1):
      media: usb: siano: Fix warning due to null work_func_t function pointer

Eric Dumazet (16):
      netlink: fix potential deadlock in netlink_set_err()
      netlink: do not hard code device address lenth in fdb dumps
      tcp: annotate data races in __tcp_oow_rate_limited()
      udp6: fix udp6_ehashfn() typo
      tcp: annotate data-races around tp->linger2
      tcp: annotate data-races around rskq_defer_accept
      tcp: annotate data-races around tp->notsent_lowat
      tcp: annotate data-races around fastopenq.max_qlen
      net: add missing data-race annotations around sk->sk_peek_off
      net: add missing data-race annotation for sk_ll_usec
      tcp_metrics: fix addr_same() helper
      tcp_metrics: annotate data-races around tm->tcpm_stamp
      tcp_metrics: annotate data-races around tm->tcpm_lock
      tcp_metrics: annotate data-races around tm->tcpm_vals[]
      tcp_metrics: annotate data-races around tm->tcpm_net
      tcp_metrics: fix data-race in tcpm_suck_dst() vs fastopen

Eric Whitney (1):
      ext4: correct inline offset when handling xattrs in inode body

Fabian Frederick (1):
      jffs2: reduce stack usage in jffs2_build_xattr_subsystem()

Fedor Pchelkin (2):
      wifi: ath9k: avoid referencing uninit memory in ath9k_wmi_ctrl_rx
      wifi: ath9k: don't allow to overwrite ENDPOINT0 attributes

Feng Mingxi (1):
      clocksource/drivers/cadence-ttc: Fix memory leak in ttc_timer_probe

Filipe Manana (3):
      btrfs: fix race when deleting quota root from the dirty cow roots list
      btrfs: fix extent buffer leak after tree mod log failure at split_node()
      btrfs: check for commit error at btrfs_attach_transaction_barrier()

Florent Revest (1):
      netfilter: conntrack: Avoid nf_ct_helper_hash uses after free

Florian Fainelli (1):
      net: bcmgenet: Ensure MDIO unregistration has clocks enabled

Florian Westphal (5):
      netfilter: nf_tables: fix nat hook table deletion
      netfilter: nf_tables: add rescheduling points during loop detection walks
      netfilter: nf_tables: fix scheduling-while-atomic splat
      netfilter: nf_tables: fix spurious set element insertion failure
      netfilter: nf_tables: can't schedule in nft_chain_validate

Gaosheng Cui (1):
      drm/msm: Fix IS_ERR_OR_NULL() vs NULL check in a5xx_submit_in_rb()

Georg Müller (2):
      perf probe: Add test for regression introduced by switch to die_get_decl_file()
      perf test uprobe_from_different_cu: Skip if there is no gcc

George Stark (1):
      meson saradc: fix clock divider mask length

Gilles Buloz (1):
      hwmon: (nct7802) Fix for temp6 (PECI1) processed even if PECI1 disabled

Gratian Crisan (1):
      usb: dwc3: pci: skip BYT GPIO lookup table for hardwired phy

Greg Kroah-Hartman (4):
      video: imsttfb: check for ioremap() failures
      Documentation: security-bugs.rst: update preferences when dealing with the linux-distros group
      Documentation: security-bugs.rst: clarify CVE handling
      Linux 4.19.291

Guiting Shen (1):
      usb: ohci-at91: Fix the unhandle interrupt when resume

Gustavo A. R. Silva (1):
      wifi: wext-core: Fix -Wstringop-overflow warning in ioctl_standard_iw_point()

Hangbin Liu (2):
      bonding: reset bond's flags when down link is P2P device
      team: reset team's flags when down link is P2P device

Hans de Goede (1):
      gpio: tps68470: Make tps68470_gpio_output() always set the initial value

Harshit Mogalapalli (1):
      phy: hisilicon: Fix an out of bounds check in hisi_inno_phy_probe()

Heiko Carstens (1):
      KVM: s390: fix sthyi error handling

Herbert Xu (1):
      hwrng: virtio - Fix race on data_avail and actual data

Ilia.Gavrilov (1):
      netfilter: nf_conntrack_sip: fix the ct_sip_parse_numerical_param() return value.

Ilpo Järvinen (2):
      PCI/ASPM: Factor out pcie_wait_for_retrain()
      PCI/ASPM: Avoid link retraining race

Ilya Dryomov (1):
      libceph: fix potential hang in ceph_osdc_notify()

Jakub Kicinski (2):
      net: create netdev->dev_addr assignment helpers
      wl3501_cs: use eth_hw_addr_set()

Jakub Vanek (1):
      Revert "usb: dwc3: core: Enable AutoRetry feature in the controller"

Jamal Hadi Salim (1):
      net: sched: cls_u32: Fix match key mis-addressing

Jan Kara (1):
      ext2: Drop fragment support

Jarkko Sakkinen (1):
      tpm: tpm_vtpm_proxy: fix a race condition in /dev/vtpmx creation

Jason Baron (1):
      md/raid0: add discard support for the 'original' layout

Jason Wang (1):
      virtio-net: fix race between set queues and probe

Jeremy Sowden (1):
      lib/ts_bm: reset initial match offset for every block of text

Jerry Meng (1):
      USB: serial: option: support Quectel EM060K_128

Jiaqing Zhao (1):
      Revert "8250: add support for ASIX devices with a FIFO bug"

Jiasheng Jiang (2):
      mfd: intel-lpss: Add missing check for platform_get_resource
      NTB: ntb_tool: Add check for devm_kcalloc

Jisheng Zhang (1):
      usb: dwc3: don't reset device side if dwc3 was configured as host-only

Jocelyn Falempe (1):
      drm/client: Fix memory leak in drm_client_target_cloned

Joe Perches (1):
      drivers core: Use sysfs_emit and sysfs_emit_at for show(device *...) functions

Joe Thornber (1):
      dm cache policy smq: ensure IO doesn't prevent cleaner policy progress

Johan Hovold (2):
      USB: serial: simple: sort driver entries
      PM: sleep: wakeirq: fix wake irq arming

Johannes Berg (1):
      wifi: iwlwifi: mvm: avoid baid size integer overflow

John Paul Adrian Glaubitz (2):
      irqchip/jcore-aic: Fix missing allocation of IRQ descriptors
      sh: j2: Use ioremap() to translate device tree address into kernel memory

Jonas Gorski (3):
      spi: bcm-qspi: return error if neither hif_mspi nor mspi is available
      spi: bcm63xx: fix max prepend length
      irq-bcm6345-l1: Do not assume a fixed block to cpu mapping

Kees Cook (1):
      treewide: Remove uninitialized_var() usage

Kemeng Shi (1):
      ext4: fix wrong unit use in ext4_mb_clear_bb

Klaus Kudielka (1):
      net: mvneta: fix txq_map in case of txq_number==1

Krzysztof Kozlowski (2):
      nfc: constify several pointers to u8, char and sk_buff
      nfc: llcp: fix possible use of uninitialized variable in nfc_llcp_send_connect()

Kuniyuki Iwashima (5):
      gtp: Fix use-after-free in __gtp_encap_destroy().
      netlink: Add __sock_i_ino() for __netlink_diag_dump().
      icmp6: Fix null-ptr-deref of ip6_null_entry->rt6i_idev in icmp6_dev().
      Revert "tcp: avoid the lookup process failing to get sk in ehash table"
      llc: Don't drop packet from non-root netns.

Laurent Vivier (4):
      hwrng: virtio - add an internal buffer
      hwrng: virtio - don't wait on cleanup
      hwrng: virtio - don't waste entropy
      hwrng: virtio - always add a pending request

Lee Jones (3):
      wl3501_cs: Fix a bunch of formatting issues related to function docs
      wl3501_cs: Fix misspelling and provide missing documentation
      net/sched: cls_u32: Fix reference counter leak leading to overflow

Li Nan (4):
      md/raid10: check slab-out-of-bounds in md_bitmap_get_counter
      md/raid10: fix overflow of md/safe_mode_delay
      md/raid10: fix wrong setting of max_corr_read_errors
      md/raid10: fix io loss while replacement replace rdev

Li Yang (1):
      usb: phy: phy-tahvo: fix memory leak in tahvo_usb_probe()

Lin Ma (2):
      net/sched: act_pedit: Add size check for TCA_PEDIT_PARMS_EX
      net/sched: mqprio: Add length check for TCA_MQPRIO_{MAX/MIN}_RATE64

Linus Torvalds (3):
      workqueue: clean up WORK_* constant types, clarify masking
      ftrace: Store the order of pages allocated in ftrace_page
      drm/edid: fix objtool warning in drm_cvt_modes()

Luca Weiss (1):
      Input: drv260x - sleep between polling GO bit

Lyude Paul (1):
      drm/edid: Fix uninitialized variable in drm_cvt_modes()

M A Ramdhan (1):
      net/sched: cls_fw: Fix improper refcount update leads to use-after-free

Maciej Żenczykowski (1):
      ipv6 addrconf: fix bug where deleting a mngtmpaddr can create a new temporary address

Manivannan Sadhasivam (1):
      PCI: qcom: Disable write access to read only registers for IP v2.3.3

Marc Kleine-Budde (1):
      can: gs_usb: gs_can_close(): add missing set of CAN state to CAN_STATE_STOPPED

Marc Zyngier (1):
      irqchip/jcore-aic: Kill use of irq_create_strict_mappings()

Marek Vasut (4):
      wifi: rsi: Do not set MMC_PM_KEEP_POWER in shutdown
      Input: adxl34x - do not hardcode interrupt trigger type
      media: videodev2.h: Fix struct v4l2_input tuner index comment
      i2c: xiic: Defer xiic_wakeup() and __xiic_start_xfer() in xiic_process()

Mario Limonciello (4):
      pinctrl: amd: Fix mistake in handling clearing pins at startup
      pinctrl: amd: Detect internal GPIO0 debounce handling
      pinctrl: amd: Only use special debounce behavior for GPIO 0
      pinctrl: amd: Use amd_pinconf_set() for all config options

Mark Brown (1):
      ASoC: wm8904: Fill the cache for WM8904_ADC_TEST_0 register

Martin KaFai Lau (1):
      bpf: Address KCSAN report on bpf_lru_list

Martin Kaiser (2):
      hwrng: imx-rngc - fix the timeout for init and self check
      fbdev: imxfb: warn about invalid left/right margin

Masahiro Yamada (3):
      modpost: fix section mismatch message for R_ARM_ABS32
      modpost: fix section mismatch message for R_ARM_{PC24,CALL,JUMP24}
      ARC: define ASM_NL and __ALIGN(_STR) outside #ifdef __ASSEMBLY__ guard

Matus Gajdos (1):
      ASoC: fsl_spdif: Silence output on stop

Max Filippov (1):
      xtensa: ISS: fix call to split_if_spec

Maxim Mikityanskiy (1):
      platform/x86: msi-laptop: Fix rfkill out-of-sync on MSI Wind U100

Michael Schmitz (1):
      block: change all __u32 annotations to __be32 in affs_hardblocks.h

Miklos Szeredi (1):
      fuse: revalidate: don't invalidate if interrupted

Mirsad Goran Todorovac (2):
      test_firmware: fix a memory leak with reqs buffer
      test_firmware: return ENOMEM instead of ENOSPC on failed memory allocation

Mohamed Khalfella (2):
      tracing/histograms: Add histograms to hist_vars if they have referenced variables
      tracing/histograms: Return an error if we fail to add histogram to hist_vars list

Mohsen Tahmasebi (1):
      USB: serial: option: add Quectel EC200A module support

Moritz Fischer (1):
      net: lan743x: Don't sleep in atomic context

Namhyung Kim (1):
      perf dwarf-aux: Fix off-by-one in die_get_varname()

Nico Boehr (1):
      KVM: s390: fix KVM_S390_GET_CMMA_BITS for GFNs in memslot holes

Nikita Zhandarovich (3):
      PM: domains: fix integer overflow issues in genpd_parse_state()
      radeon: avoid double free in ci_dpm_init()
      drm/radeon: fix possible division-by-zero errors

Nilesh Javali (2):
      scsi: qla2xxx: Check valid rport returned by fc_bsg_to_rport()
      scsi: qla2xxx: Array index may go out of bound

Nishanth Menon (1):
      mailbox: ti-msgmgr: Fill non-message tx data fields with 0x0

Oliver Neukum (1):
      USB: serial: simple: add Kaufmann RKS+CAN VCP

Ondrej Zary (1):
      PCI/PM: Avoid putting EloPOS E2/S2/H2 PCIe Ports in D3cold

Pablo Neira Ayuso (7):
      netfilter: nftables: add helper function to set the base sequence number
      netfilter: add helper function to set up the nfnetlink header and use it
      netfilter: nf_tables: use net_generic infra for transaction data
      netfilter: nf_tables: incorrect error path handling with NFT_MSG_NEWRULE
      netfilter: nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain
      netfilter: nf_tables: reject unbound anonymous set before commit phase
      netfilter: nf_tables: unbind non-anonymous set if rule construction fails

Patrick Kelsey (1):
      IB/hfi1: Fix sdma.h tx->num_descs off-by-one errors

Pedro Tammela (2):
      net/sched: make psched_mtu() RTNL-less safe
      net/sched: sch_qfq: account for stab overhead in qfq_enqueue

Peng Fan (1):
      ARM: dts: imx: add usb alias

Pengcheng Yang (1):
      samples/bpf: Fix buffer overflow in tcp_basertt

Peter Seiderer (1):
      wifi: ath9k: fix AR9003 mac hardware hang check register offset calculation

Peter Zijlstra (1):
      perf: Fix function pointer case

Prince Kumar Maurya (1):
      fs/sysv: Null check to prevent null-ptr-deref bug

Quinn Tran (1):
      scsi: qla2xxx: Wait for io return on terminate rport

Rafał Miłecki (1):
      ARM: dts: BCM5301X: Drop "clock-names" from the SPI node

Rajan Vaja (1):
      clocksource/drivers/cadence-ttc: Use ttc driver as platform driver

Randy Dunlap (4):
      soc/fsl/qe: fix usb.c build errors
      crypto: nx - fix build warnings when DEBUG_FS is not enabled
      powerpc: allow PPC_EARLY_DEBUG_CPM only when SERIAL_CPM=y
      wifi: airo: avoid uninitialized warning in airo_get_rate()

Rasmus Villemoes (3):
      spi: spi-fsl-spi: remove always-true conditional in fsl_spi_do_one_msg
      spi: spi-fsl-spi: relax message sanity checking a little
      spi: spi-fsl-spi: allow changing bits_per_word while CS is still active

Remi Pommarel (1):
      wifi: ath9k: Fix possible stall on ath9k_txq_list_has_key()

Ricardo Ribalda (1):
      usb: xhci-mtk: set the dma max_seg_size

Rick Wertenbroek (5):
      PCI: rockchip: Assert PCI Configuration Enable bit after probe
      PCI: rockchip: Write PCI Device ID to correct register
      PCI: rockchip: Add poll and timeout to wait for PHY PLLs to be locked
      PCI: rockchip: Fix legacy IRQ generation for RK3399 PCIe endpoint core
      PCI: rockchip: Use u32 variable to access 32-bit registers

Robert Hancock (1):
      i2c: xiic: Don't try to handle more interrupt events after error

Robert Marko (2):
      mmc: core: disable TRIM on Kingston EMMC04G-M627
      mmc: core: disable TRIM on Micron MTFC4GACAJCN-1M

Roberto Sassu (1):
      evm: Complete description of evm_inode_setattr()

Robin Murphy (1):
      PCI: Add function 1 DMA alias quirk for Marvell 88SE9235

Roger Quadros (1):
      mtd: rawnand: omap_elm: Fix incorrect type in assignment

Ross Maynard (1):
      USB: zaurus: Add ID for A-300/B-500/C-700

Ruihong Luo (1):
      serial: 8250_dw: Preserve original value of DLF register

Shenghui Wang (1):
      bcache: use MAX_CACHES_PER_SET instead of magic number 8 in __bch_bucket_alloc_set

Shengjiu Wang (1):
      ARM: dts: imx6sll: Make ssi node name same as other platforms

Shreyas Deodhar (1):
      scsi: qla2xxx: Pointer may be dereferenced

Siddh Raman Pant (1):
      jfs: jfs_dmap: Validate db_l2nbperpage while mounting

Stefan Haberland (1):
      s390/dasd: fix hanging device after quiesce/resume

Stefan Mätje (1):
      PCI: Rework pcie_retrain_link() wait loop

Steffen Maier (1):
      scsi: zfcp: Defer fc_rport blocking until after ADISC response

Stephan Gerhold (1):
      mfd: rt5033: Drop rt5033-battery sub-device

Stephen Suryaputra (1):
      vrf: Increment Icmp6InMsgs on the original netdev

Steven Rostedt (VMware) (2):
      ftrace: Add information on number of page groups allocated
      ftrace: Check if pages were allocated before calling free_pages()

Stewart Smith (1):
      tcp: Reduce chance of collisions in inet6_hashfn().

Su Hui (1):
      ALSA: ac97: Fix possible NULL dereference in snd_ac97_mixer

Sui Jingfeng (1):
      PCI: Add pci_clear_master() stub for non-CONFIG_PCI

Sungwoo Kim (1):
      Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_cb

Takashi Iwai (1):
      ALSA: jack: Fix mutex call in snd_jack_report()

Tanmay Patil (1):
      net: ethernet: ti: cpsw_ale: Fix cpsw_ale_get_field()/cpsw_ale_set_field()

Tetsuo Handa (1):
      debugobjects: Recheck debug_objects_enabled before reporting

Thadeu Lima de Souza Cascardo (1):
      netfilter: nf_tables: prevent OOB access in nft_byteorder_eval

Thomas Gleixner (2):
      x86/smp: Use dedicated cache-line for mwait_play_dead()
      posix-timers: Ensure timer ID search-loop limit is valid

Thomas Petazzoni (1):
      ASoC: cs42l51: fix driver to properly autoload with automatic module loading

Tianjia Zhang (1):
      integrity: Fix possible multiple allocation in integrity_inode_get()

Tobias Heider (1):
      Add MODULE_FIRMWARE() for FIRMWARE_TG357766.

Vineet Gupta (4):
      ARCv2: entry: comments about hardware auto-save on taken interrupts
      ARCv2: entry: push out the Z flag unclobber from common EXCEPTION_PROLOGUE
      ARCv2: entry: avoid a branch
      ARCv2: entry: rewrite to enable use of double load/stores LDD/STD

Vladimir Oltean (3):
      net: bridge: keep ports without IFF_UNICAST_FLT in BR_PROMISC mode
      net/sched: mqprio: refactor nlattr parsing to a separate function
      net/sched: mqprio: add extack to mqprio_parse_nlattr()

Wang Ming (1):
      i40e: Fix an NULL vs IS_ERR() bug for debugfs_create_dir()

Wolfram Sang (1):
      arm64: dts: renesas: ulcb-kf: Remove flow control for SCIF1

Xiubo Li (1):
      ceph: don't let check_caps skip sending responses for revoke msgs

Xu Yang (1):
      ARM: dts: nxp/imx6sll: fix wrong property name in usbphy node

Yang Yingliang (1):
      NTB: ntb_transport: fix possible memory leak while device_register() fails

Ye Bin (1):
      scsi: qla2xxx: Fix inconsistent format argument type in qla_os.c

Yicong Yang (1):
      sched/fair: Don't balance task to its current running CPU

Ying Hsu (1):
      igb: Fix igb_down hung on surprise removal

Yu Kuai (3):
      md: fix data corruption for raid456 when reshape restart while grow up
      md/raid10: prevent soft lockup while flush writes
      dm raid: fix missing reconfig_mutex unlock in raid_ctr() error paths

Yuan Can (3):
      ntb: idt: Fix error handling in idt_pci_driver_init()
      NTB: amd: Fix error handling in amd_ntb_pci_driver_init()
      ntb: intel: Fix error handling in intel_ntb_pci_driver_init()

Yuanjun Gong (4):
      net:ipv6: check return value of pskb_trim()
      ethernet: atheros: fix return value check in atl1e_tso_csum()
      benet: fix return value check in be_lancer_xmit_workarounds()
      net/mlx5e: fix return value check in mlx5e_ipsec_remove_trailer()

Yuchen Yang (1):
      scsi: 3w-xxxx: Add error handling for initialization failure in tw_probe()

Yue Haibing (1):
      ip6mr: Fix skb_under_panic in ip6mr_cache_report()

YueHaibing (1):
      can: bcm: Fix UAF in bcm_proc_show()

Zhang Shurong (2):
      fbdev: au1200fb: Fix missing IRQ check in au1200fb_drv_probe
      staging: ks7010: potential buffer overflow in ks_wlan_set_encode_ext()

Zhen Lei (1):
      kexec: fix a memory leak in crash_shrink_memory()

Zheng Wang (3):
      fbdev: imsttfb: Fix use after free bug in imsttfb_probe
      bcache: Remove unnecessary NULL point check in node allocations
      bcache: Fix __bch_btree_node_alloc to make the failure behavior consistent

Zheng Yejian (4):
      ring-buffer: Fix deadloop issue on reading trace_pipe
      ftrace: Fix possible warning on checking all pages used in ftrace_process_locs()
      ring-buffer: Fix wrong stat of cpu_buffer->read
      tracing: Fix warning in trace_buffered_event_disable()

Zhihao Cheng (1):
      ext4: Fix reusing stale buffer heads from last failed mounting

Zhong Jinghua (1):
      nbd: Add the maximum limit of allocated index in nbd_dev_add

Ziyang Xuan (1):
      ipv6/addrconf: fix a potential refcount underflow for idev

ndesaulniers@google.com (1):
      word-at-a-time: use the same return type for has_zero regardless of endianness

valis (2):
      net/sched: cls_u32: No longer copy tcf_result on update to avoid use-after-free
      net/sched: cls_route: No longer copy tcf_result on update to avoid use-after-free

Łukasz Bartosik (1):
      USB: quirks: add quirk for Focusrite Scarlett

