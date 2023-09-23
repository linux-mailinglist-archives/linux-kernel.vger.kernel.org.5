Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7547ABF24
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjIWJCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjIWJBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:01:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B4719C;
        Sat, 23 Sep 2023 02:01:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01099C433CA;
        Sat, 23 Sep 2023 09:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695459697;
        bh=iYbFTi4HL2wqhQSj/Qo4r8VGkmOjBOKu5b+I/e6AFmw=;
        h=From:To:Cc:Subject:Date:From;
        b=2pLu3+aVXFGNzT0vQYZRCU6ufIiUtB5rGEVzf9fMY06xmG5lZYnTf7lMYDUtoqMrU
         iwkrvWTwsd7hgCeswQQg5WDwEdE/A90ArJTqfsDB5AnM1PPplyXeLTVxlHA/B+0pDz
         Avv+79P9Rk4o4U0kx+fD6MbOENlWyZkX3cx2UOzc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.295
Date:   Sat, 23 Sep 2023 11:01:29 +0200
Message-ID: <2023092329-relive-distort-435a@gregkh>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 4.19.295 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                             |    2 
 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts        |   13 
 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts         |   13 
 arch/arm/boot/dts/bcm5301x.dtsi                      |    4 
 arch/arm/boot/dts/bcm53573.dtsi                      |   27 
 arch/arm/boot/dts/bcm947189acdbmr.dts                |    6 
 arch/arm/boot/dts/s3c6410-mini6410.dts               |   38 
 arch/arm/boot/dts/s3c64xx-pinctrl.dtsi               |  210 ++---
 arch/arm/boot/dts/s5pv210-smdkv210.dts               |   24 
 arch/arm/kernel/hw_breakpoint.c                      |    8 
 arch/arm/mach-omap2/powerdomain.c                    |    2 
 arch/arm/mach-pxa/sharpsl_pm.c                       |    2 
 arch/arm/mach-pxa/spitz.c                            |   14 
 arch/arm64/boot/dts/qcom/msm8996.dtsi                |    7 
 arch/arm64/kernel/hw_breakpoint.c                    |    4 
 arch/m68k/fpsp040/skeleton.S                         |    4 
 arch/m68k/ifpsp060/os.S                              |    4 
 arch/m68k/kernel/relocate_kernel.S                   |    4 
 arch/mips/alchemy/devboards/db1000.c                 |    8 
 arch/mips/alchemy/devboards/db1200.c                 |   19 
 arch/mips/alchemy/devboards/db1300.c                 |   10 
 arch/parisc/include/asm/led.h                        |    4 
 arch/parisc/include/asm/processor.h                  |    1 
 arch/parisc/kernel/processor.c                       |   18 
 arch/powerpc/kernel/head_32.S                        |    2 
 arch/powerpc/kernel/iommu.c                          |   17 
 arch/powerpc/kernel/vmlinux.lds.S                    |    1 
 arch/powerpc/platforms/pseries/ibmebus.c             |    1 
 arch/um/configs/i386_defconfig                       |    1 
 arch/um/configs/x86_64_defconfig                     |    1 
 arch/um/drivers/Kconfig                              |  366 ++++----
 arch/um/drivers/Makefile                             |    2 
 arch/x86/include/asm/virtext.h                       |    6 
 arch/x86/kernel/apm_32.c                             |    6 
 crypto/asymmetric_keys/x509_public_key.c             |    5 
 drivers/acpi/acpica/psopcode.c                       |    2 
 drivers/acpi/video_detect.c                          |    9 
 drivers/amba/bus.c                                   |    1 
 drivers/ata/pata_ftide010.c                          |    1 
 drivers/ata/sata_gemini.c                            |    1 
 drivers/base/regmap/regcache-rbtree.c                |   10 
 drivers/bluetooth/btsdio.c                           |    1 
 drivers/bluetooth/hci_nokia.c                        |    6 
 drivers/char/ipmi/ipmi_si_intf.c                     |    5 
 drivers/char/tpm/tpm_tis_core.c                      |   15 
 drivers/clk/keystone/pll.c                           |    2 
 drivers/clk/qcom/gcc-mdm9615.c                       |    2 
 drivers/clk/sunxi-ng/ccu_mmc_timing.c                |    2 
 drivers/cpufreq/brcmstb-avs-cpufreq.c                |    6 
 drivers/cpufreq/powernow-k8.c                        |    3 
 drivers/crypto/caam/caampkc.c                        |    4 
 drivers/crypto/stm32/stm32-hash.c                    |    2 
 drivers/devfreq/devfreq.c                            |    1 
 drivers/dma/Kconfig                                  |    2 
 drivers/dma/ste_dma40.c                              |    4 
 drivers/fsi/fsi-master-ast-cf.c                      |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           |    3 
 drivers/gpu/drm/amd/amdgpu/cik.c                     |   97 +-
 drivers/gpu/drm/amd/amdgpu/si.c                      |   99 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c     |    5 
 drivers/gpu/drm/ast/ast_post.c                       |    2 
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c         |    9 
 drivers/gpu/drm/exynos/exynos_drm_crtc.c             |    5 
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c           |    5 
 drivers/gpu/drm/radeon/cik.c                         |   96 +-
 drivers/gpu/drm/radeon/si.c                          |   98 +-
 drivers/gpu/drm/tegra/dpaux.c                        |    6 
 drivers/hid/hid-multitouch.c                         |   13 
 drivers/hid/wacom.h                                  |    1 
 drivers/hid/wacom_sys.c                              |   25 
 drivers/hid/wacom_wac.c                              |    1 
 drivers/hid/wacom_wac.h                              |    1 
 drivers/iio/industrialio-core.c                      |    2 
 drivers/infiniband/core/uverbs_std_types_counters.c  |    2 
 drivers/infiniband/ulp/isert/ib_isert.c              |    2 
 drivers/md/raid1.c                                   |    3 
 drivers/media/dvb-frontends/ascot2e.c                |    2 
 drivers/media/dvb-frontends/atbm8830.c               |    2 
 drivers/media/dvb-frontends/au8522_dig.c             |    2 
 drivers/media/dvb-frontends/bcm3510.c                |    2 
 drivers/media/dvb-frontends/cx22700.c                |    2 
 drivers/media/dvb-frontends/cx22702.c                |    2 
 drivers/media/dvb-frontends/cx24110.c                |    2 
 drivers/media/dvb-frontends/cx24113.c                |    2 
 drivers/media/dvb-frontends/cx24116.c                |    2 
 drivers/media/dvb-frontends/cx24120.c                |    6 
 drivers/media/dvb-frontends/cx24123.c                |    2 
 drivers/media/dvb-frontends/cxd2820r_core.c          |    2 
 drivers/media/dvb-frontends/cxd2841er.c              |    4 
 drivers/media/dvb-frontends/cxd2880/cxd2880_top.c    |    2 
 drivers/media/dvb-frontends/dib0070.c                |    2 
 drivers/media/dvb-frontends/dib0090.c                |    4 
 drivers/media/dvb-frontends/dib3000mb.c              |    2 
 drivers/media/dvb-frontends/dib3000mc.c              |    2 
 drivers/media/dvb-frontends/dib7000m.c               |    2 
 drivers/media/dvb-frontends/dib7000p.c               |    4 
 drivers/media/dvb-frontends/dib8000.c                |    2 
 drivers/media/dvb-frontends/dib9000.c                |    2 
 drivers/media/dvb-frontends/drx39xyj/drxj.c          |    2 
 drivers/media/dvb-frontends/drxd_hard.c              |    2 
 drivers/media/dvb-frontends/drxk_hard.c              |    2 
 drivers/media/dvb-frontends/ds3000.c                 |    2 
 drivers/media/dvb-frontends/dvb-pll.c                |    2 
 drivers/media/dvb-frontends/ec100.c                  |    2 
 drivers/media/dvb-frontends/helene.c                 |    4 
 drivers/media/dvb-frontends/horus3a.c                |    2 
 drivers/media/dvb-frontends/isl6405.c                |    2 
 drivers/media/dvb-frontends/isl6421.c                |    2 
 drivers/media/dvb-frontends/isl6423.c                |    2 
 drivers/media/dvb-frontends/itd1000.c                |    2 
 drivers/media/dvb-frontends/ix2505v.c                |    2 
 drivers/media/dvb-frontends/l64781.c                 |    2 
 drivers/media/dvb-frontends/lg2160.c                 |    2 
 drivers/media/dvb-frontends/lgdt3305.c               |    2 
 drivers/media/dvb-frontends/lgdt3306a.c              |    2 
 drivers/media/dvb-frontends/lgdt330x.c               |    2 
 drivers/media/dvb-frontends/lgs8gxx.c                |    2 
 drivers/media/dvb-frontends/lnbh25.c                 |    2 
 drivers/media/dvb-frontends/lnbp21.c                 |    4 
 drivers/media/dvb-frontends/lnbp22.c                 |    2 
 drivers/media/dvb-frontends/m88ds3103.c              |    2 
 drivers/media/dvb-frontends/m88rs2000.c              |    2 
 drivers/media/dvb-frontends/mb86a16.c                |    2 
 drivers/media/dvb-frontends/mb86a20s.c               |    2 
 drivers/media/dvb-frontends/mt312.c                  |    2 
 drivers/media/dvb-frontends/mt352.c                  |    2 
 drivers/media/dvb-frontends/nxt200x.c                |    2 
 drivers/media/dvb-frontends/nxt6000.c                |    2 
 drivers/media/dvb-frontends/or51132.c                |    2 
 drivers/media/dvb-frontends/or51211.c                |    2 
 drivers/media/dvb-frontends/s5h1409.c                |    2 
 drivers/media/dvb-frontends/s5h1411.c                |    2 
 drivers/media/dvb-frontends/s5h1420.c                |    2 
 drivers/media/dvb-frontends/s5h1432.c                |    2 
 drivers/media/dvb-frontends/s921.c                   |    2 
 drivers/media/dvb-frontends/si21xx.c                 |    2 
 drivers/media/dvb-frontends/sp887x.c                 |    2 
 drivers/media/dvb-frontends/stb0899_drv.c            |    2 
 drivers/media/dvb-frontends/stb6000.c                |    2 
 drivers/media/dvb-frontends/stb6100.c                |    2 
 drivers/media/dvb-frontends/stv0288.c                |    2 
 drivers/media/dvb-frontends/stv0297.c                |    2 
 drivers/media/dvb-frontends/stv0299.c                |    2 
 drivers/media/dvb-frontends/stv0367.c                |    6 
 drivers/media/dvb-frontends/stv0900_core.c           |    2 
 drivers/media/dvb-frontends/stv6110.c                |    2 
 drivers/media/dvb-frontends/stv6110x.c               |    2 
 drivers/media/dvb-frontends/tda10021.c               |    2 
 drivers/media/dvb-frontends/tda10023.c               |    2 
 drivers/media/dvb-frontends/tda10048.c               |    2 
 drivers/media/dvb-frontends/tda1004x.c               |    4 
 drivers/media/dvb-frontends/tda10086.c               |    2 
 drivers/media/dvb-frontends/tda665x.c                |    2 
 drivers/media/dvb-frontends/tda8083.c                |    2 
 drivers/media/dvb-frontends/tda8261.c                |    2 
 drivers/media/dvb-frontends/tda826x.c                |    2 
 drivers/media/dvb-frontends/ts2020.c                 |    2 
 drivers/media/dvb-frontends/tua6100.c                |    2 
 drivers/media/dvb-frontends/ves1820.c                |    2 
 drivers/media/dvb-frontends/ves1x93.c                |    2 
 drivers/media/dvb-frontends/zl10036.c                |    2 
 drivers/media/dvb-frontends/zl10039.c                |    2 
 drivers/media/dvb-frontends/zl10353.c                |    2 
 drivers/media/i2c/ov2680.c                           |  246 +-----
 drivers/media/pci/bt8xx/dst.c                        |    2 
 drivers/media/pci/bt8xx/dst_ca.c                     |    2 
 drivers/media/pci/cx23885/cx23885-video.c            |    2 
 drivers/media/pci/intel/ipu3/ipu3-cio2.c             |    2 
 drivers/media/platform/exynos4-is/media-dev.c        |   12 
 drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c |    5 
 drivers/media/platform/ti-vpe/cal.c                  |    4 
 drivers/media/platform/xilinx/xilinx-tpg.c           |    2 
 drivers/media/tuners/fc0011.c                        |    2 
 drivers/media/tuners/fc0012.c                        |    2 
 drivers/media/tuners/fc0013.c                        |    2 
 drivers/media/tuners/max2165.c                       |    2 
 drivers/media/tuners/mc44s803.c                      |    2 
 drivers/media/tuners/mt2060.c                        |    2 
 drivers/media/tuners/mt2131.c                        |    2 
 drivers/media/tuners/mt2266.c                        |    2 
 drivers/media/tuners/mxl5005s.c                      |    2 
 drivers/media/tuners/qt1010.c                        |   13 
 drivers/media/tuners/tda18218.c                      |    2 
 drivers/media/tuners/xc4000.c                        |    2 
 drivers/media/tuners/xc5000.c                        |    2 
 drivers/media/usb/dvb-usb-v2/af9035.c                |   14 
 drivers/media/usb/dvb-usb-v2/anysee.c                |    2 
 drivers/media/usb/dvb-usb-v2/az6007.c                |    8 
 drivers/media/usb/dvb-usb/af9005.c                   |    5 
 drivers/media/usb/dvb-usb/dw2102.c                   |   24 
 drivers/media/usb/dvb-usb/m920x.c                    |    5 
 drivers/media/usb/go7007/go7007-i2c.c                |    2 
 drivers/media/usb/siano/smsusb.c                     |   21 
 drivers/media/v4l2-core/v4l2-fwnode.c                |   45 -
 drivers/mmc/host/Kconfig                             |    5 
 drivers/mtd/nand/raw/brcmnand/brcmnand.c             |  113 +-
 drivers/net/arcnet/arcnet.c                          |    2 
 drivers/net/can/usb/gs_usb.c                         |    5 
 drivers/net/ethernet/atheros/alx/ethtool.c           |    5 
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c      |    7 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c     |    9 
 drivers/net/ethernet/intel/igb/igb.h                 |    4 
 drivers/net/ethernet/intel/igb/igb_main.c            |   16 
 drivers/net/ethernet/intel/igbvf/igbvf.h             |    4 
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c         |   28 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c          |    3 
 drivers/net/macsec.c                                 |    3 
 drivers/net/usb/qmi_wwan.c                           |    1 
 drivers/net/veth.c                                   |    4 
 drivers/net/vxlan.c                                  |   58 -
 drivers/net/wireless/ath/ath10k/pci.c                |    9 
 drivers/net/wireless/ath/ath9k/ahb.c                 |    4 
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c       |    2 
 drivers/net/wireless/ath/ath9k/pci.c                 |    4 
 drivers/net/wireless/ath/ath9k/wmi.c                 |   20 
 drivers/net/wireless/marvell/mwifiex/debugfs.c       |    9 
 drivers/net/wireless/marvell/mwifiex/pcie.c          |  179 ++--
 drivers/net/wireless/marvell/mwifiex/sta_rx.c        |   12 
 drivers/net/wireless/marvell/mwifiex/tdls.c          |    9 
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c      |   30 
 drivers/net/wireless/marvell/mwifiex/util.c          |   10 
 drivers/ntb/ntb_transport.c                          |   19 
 drivers/of/unittest.c                                |   12 
 drivers/parisc/led.c                                 |    4 
 drivers/pci/ats.c                                    |   30 
 drivers/pci/hotplug/pciehp_hpc.c                     |   12 
 drivers/pci/pci-sysfs.c                              |    3 
 drivers/pci/pci.c                                    |    4 
 drivers/pci/pcie/aspm.c                              |   30 
 drivers/pci/probe.c                                  |    2 
 drivers/pci/slot.c                                   |    1 
 drivers/pinctrl/pinctrl-amd.c                        |    4 
 drivers/platform/x86/intel-hid.c                     |   21 
 drivers/pwm/pwm-lpc32xx.c                            |   16 
 drivers/rpmsg/qcom_glink_native.c                    |    4 
 drivers/rtc/rtc-ds1685.c                             |    2 
 drivers/s390/block/dasd.c                            |  125 +--
 drivers/s390/block/dasd_3990_erp.c                   |    2 
 drivers/scsi/be2iscsi/be_iscsi.c                     |    4 
 drivers/scsi/fcoe/fcoe_ctlr.c                        |   20 
 drivers/scsi/hosts.c                                 |    4 
 drivers/scsi/qedf/qedf_dbg.h                         |    2 
 drivers/scsi/qedf/qedf_debugfs.c                     |   28 
 drivers/scsi/qedi/qedi_main.c                        |    5 
 drivers/scsi/qla2xxx/qla_isr.c                       |    1 
 drivers/scsi/qla2xxx/qla_nvme.c                      |    2 
 drivers/scsi/qla4xxx/ql4_os.c                        |   15 
 drivers/scsi/scsi_transport_iscsi.c                  |    8 
 drivers/soc/qcom/qmi_encdec.c                        |    4 
 drivers/spi/spi-tegra20-sflash.c                     |    6 
 drivers/staging/erofs/unzip_vle.c                    |    2 
 drivers/target/iscsi/iscsi_target_configfs.c         |   54 -
 drivers/tty/serial/cpm_uart/cpm_uart_core.c          |   13 
 drivers/tty/serial/sc16is7xx.c                       |   18 
 drivers/tty/serial/serial-tegra.c                    |    6 
 drivers/usb/gadget/function/f_mass_storage.c         |    2 
 drivers/usb/gadget/udc/fsl_qe_udc.c                  |    6 
 drivers/usb/phy/phy-mxs-usb.c                        |   10 
 drivers/usb/serial/option.c                          |    7 
 drivers/usb/typec/tcpci.c                            |    4 
 drivers/usb/typec/tcpci.h                            |    1 
 drivers/video/backlight/bd6107.c                     |    2 
 drivers/video/backlight/gpio_backlight.c             |    2 
 drivers/video/backlight/lv5207lp.c                   |    2 
 drivers/video/fbdev/ep93xx-fb.c                      |    1 
 drivers/watchdog/intel-mid_wdt.c                     |    1 
 fs/attr.c                                            |   20 
 fs/autofs/waitq.c                                    |    3 
 fs/btrfs/delayed-inode.c                             |   19 
 fs/btrfs/extent-tree.c                               |    5 
 fs/btrfs/transaction.c                               |    7 
 fs/cifs/cifsfs.c                                     |    7 
 fs/cifs/smb2ops.c                                    |    1 
 fs/debugfs/inode.c                                   |    6 
 fs/dlm/plock.c                                       |    6 
 fs/eventfd.c                                         |    7 
 fs/ext2/xattr.c                                      |    4 
 fs/jfs/jfs_dmap.c                                    |    1 
 fs/jfs/jfs_extent.c                                  |    5 
 fs/jfs/jfs_imap.c                                    |    1 
 fs/kernfs/mount.c                                    |    2 
 fs/lockd/mon.c                                       |    3 
 fs/namei.c                                           |   22 
 fs/nfs/blocklayout/dev.c                             |    4 
 fs/nfs/pnfs_dev.c                                    |    2 
 fs/nfsd/blocklayoutxdr.c                             |    9 
 fs/nfsd/flexfilelayoutxdr.c                          |    9 
 fs/nfsd/nfs3xdr.c                                    |    4 
 fs/nfsd/nfs4proc.c                                   |    4 
 fs/nfsd/nfs4xdr.c                                    |   36 
 fs/nilfs2/alloc.c                                    |    3 
 fs/nilfs2/inode.c                                    |    7 
 fs/nilfs2/segment.c                                  |    5 
 fs/nls/nls_base.c                                    |    4 
 fs/ocfs2/namei.c                                     |    4 
 fs/overlayfs/namei.c                                 |   24 
 fs/proc/base.c                                       |    3 
 fs/pstore/ram_core.c                                 |    2 
 fs/quota/dquot.c                                     |  189 ++--
 fs/reiserfs/journal.c                                |    4 
 fs/udf/balloc.c                                      |   31 
 fs/udf/inode.c                                       |   45 -
 include/linux/eventfd.h                              |    6 
 include/linux/if_arp.h                               |    4 
 include/linux/namei.h                                |    1 
 include/linux/nls.h                                  |    2 
 include/linux/pci-ats.h                              |    5 
 include/linux/pci.h                                  |    1 
 include/linux/perf_event.h                           |   22 
 include/linux/trace_events.h                         |    3 
 include/net/lwtunnel.h                               |    5 
 include/net/tcp.h                                    |    1 
 include/scsi/scsi_host.h                             |    2 
 include/uapi/linux/pci_regs.h                        |  139 +--
 include/uapi/linux/sync_file.h                       |    2 
 kernel/auditsc.c                                     |    2 
 kernel/cgroup/namespace.c                            |    6 
 kernel/module.c                                      |   15 
 kernel/trace/bpf_trace.c                             |    2 
 kernel/trace/trace_uprobe.c                          |    3 
 lib/idr.c                                            |    2 
 lib/kobject.c                                        |    5 
 lib/mpi/mpi-cmp.c                                    |    8 
 net/9p/trans_virtio.c                                |    2 
 net/core/skbuff.c                                    |   34 
 net/core/sock.c                                      |    9 
 net/dccp/ipv4.c                                      |   13 
 net/dccp/ipv6.c                                      |   15 
 net/ipv4/igmp.c                                      |    3 
 net/ipv4/ip_output.c                                 |    2 
 net/ipv4/tcp_input.c                                 |    3 
 net/ipv6/addrconf.c                                  |    2 
 net/ipv6/ip6_output.c                                |    2 
 net/kcm/kcmsock.c                                    |   15 
 net/netfilter/ipset/ip_set_hash_netportnet.c         |    1 
 net/netfilter/nf_tables_api.c                        |    1 
 net/netfilter/nfnetlink_osf.c                        |    8 
 net/netfilter/nft_flow_offload.c                     |    3 
 net/netfilter/xt_sctp.c                              |    2 
 net/netfilter/xt_u32.c                               |   21 
 net/netlabel/netlabel_kapi.c                         |    3 
 net/netrom/af_netrom.c                               |    5 
 net/sched/Kconfig                                    |   28 
 net/sched/Makefile                                   |    2 
 net/sched/cls_fw.c                                   |    1 
 net/sched/cls_rsvp.c                                 |   28 
 net/sched/cls_rsvp.h                                 |  775 -------------------
 net/sched/cls_rsvp6.c                                |   28 
 net/sched/sch_hfsc.c                                 |    4 
 net/sched/sch_plug.c                                 |    2 
 net/sched/sch_qfq.c                                  |   22 
 net/sctp/sm_sideeffect.c                             |    5 
 net/socket.c                                         |    6 
 net/unix/af_unix.c                                   |    2 
 net/unix/scm.c                                       |    6 
 scripts/kconfig/preprocess.c                         |    3 
 security/keys/keyctl.c                               |   11 
 security/smack/smackfs.c                             |    2 
 sound/Kconfig                                        |    2 
 sound/core/pcm_compat.c                              |    8 
 sound/core/seq/oss/seq_oss_midi.c                    |   35 
 sound/pci/ac97/ac97_codec.c                          |    5 
 sound/soc/atmel/atmel-i2s.c                          |    5 
 sound/soc/codecs/da7219-aad.c                        |   12 
 sound/soc/codecs/es8316.c                            |    2 
 tools/perf/ui/browsers/hists.c                       |    2 
 366 files changed, 2348 insertions(+), 2655 deletions(-)

Aaron Armstrong Skomra (1):
      HID: wacom: remove the battery when the EKR is off

Abhishek Mainkar (1):
      ACPICA: Add AML_NO_OPERAND_RESOLVE flag to Timer

Al Viro (1):
      new helper: lookup_positive_unlocked()

Alan Stern (1):
      USB: gadget: f_mass_storage: Fix unused variable warning

Aleksa Sarai (1):
      procfs: block chmod on /proc/thread-self/comm

Alex Henrie (1):
      net: ipv6/addrconf: avoid integer underflow in ipv6_create_tempaddr

Alexander Aring (1):
      dlm: fix plock lookup when using multiple lockspaces

Alexander Steffen (1):
      tpm_tis: Resend command to recover from data transfer errors

Alexei Filippov (1):
      jfs: validate max amount of blocks before allocation.

Amit Kucheria (1):
      arm64: dts: msm8996: thermal: Add interrupt support

Andrew Kanner (1):
      fs/jfs: prevent double-free in dbUnmount() after failed jfs_remount()

Andy Shevchenko (1):
      iio: core: Use min() instead of min_t() to make code more robust

Ariel Marcovitch (1):
      idr: fix param name in idr_alloc_cyclic() doc

Arnd Bergmann (2):
      ARM: pxa: remove use of symbol_get()
      drm/amdgpu: avoid integer overflow warning in amdgpu_device_resize_fb_bar()

Artem Chernyshev (1):
      fs: ocfs2: namei: check return value of ocfs2_add_entry()

Baokun Li (4):
      quota: factor out dquot_write_dquot()
      quota: rename dquot_active() to inode_quota_active()
      quota: add new helper dquot_active()
      quota: fix dqput() to follow the guarantees dquot_srcu should provide

Baoquan He (1):
      idmaengine: make FSL_EDMA and INTEL_IDMA64 depends on HAS_IOMEM

Ben Hutchings (1):
      m68k: Fix invalid .section syntax

Bjorn Helgaas (7):
      PCI: Cleanup register definition width and whitespace
      PCI: Add #defines for Enter Compliance, Transmit Margin
      drm/amdgpu: Correct Transmit Margin masks
      drm/amdgpu: Replace numbers with PCI_EXP_LNKCTL2 definitions
      drm/radeon: Correct Transmit Margin masks
      drm/radeon: Replace numbers with PCI_EXP_LNKCTL2 definitions
      Revert "PCI: Mark NVIDIA T4 GPUs to avoid bus reset"

Bogdan Togorean (1):
      drm: adv7511: Fix low refresh rate register for ADV7533/5

Boris Brezillon (1):
      PM / devfreq: Fix leak in devfreq_dev_release()

Brian Norris (1):
      mwifiex: drop 'set_consistent_dma_mask' log message

Budimir Markovic (1):
      net/sched: sch_hfsc: Ensure inner classes have fsc curve

Chengfeng Ye (2):
      scsi: qedi: Fix potential deadlock on &qedi_percpu->p_work_lock
      scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock

Chengguang Xu (2):
      quota: add dqi_dirty_list description to comment of Dquot List Management
      quota: avoid increasing DQST_LOOKUPS when iterating over dirty/inuse list

Chris Lew (1):
      soc: qcom: qmi_encdec: Restrict string length in decode

Christian Brauner (1):
      attr: block mode changes of symlinks

Christian Göttsche (1):
      security: keys: perform capable check only on privileged operations

Christoph Hellwig (3):
      mmc: au1xmmc: force non-modular build and remove symbol_get usage
      rtc: ds1685: use EXPORT_SYMBOL_GPL for ds1685_rtc_poweroff
      modules: only allow symbol_get of EXPORT_SYMBOL_GPL modules

Christophe JAILLET (3):
      mwifiex: switch from 'pci_' to 'dma_' API
      media: v4l2-core: Fix a potential resource leak in v4l2_fwnode_parse_link()
      media: dvb-usb: m920x: Fix a potential memory leak in m920x_i2c_xfer()

Christophe Leroy (2):
      powerpc/32s: Fix assembler warning about r0
      serial: cpm_uart: Avoid suspicious locking

Chuck Lever (1):
      NFSD: da_addr_body field missing in some GETDEVICEINFO replies

Colin Ian King (1):
      media: go7007: Remove redundant if statement

Corinna Vinschen (1):
      igb: disable virtualization features on 82580

Damien Le Moal (2):
      ata: sata_gemini: Add missing MODULE_DESCRIPTION
      ata: pata_ftide010: Add missing MODULE_DESCRIPTION

Dan Carpenter (4):
      sctp: handle invalid error codes without calling BUG()
      regmap: rbtree: Use alloc_flags for memory allocations
      smackfs: Prevent underflow in smk_set_cipso()
      nfs/blocklayout: Use the passed in gfp flags

Daniel Mack (1):
      sc16is7xx: Set iobase to device index

Daniel Vetter (1):
      drm/msm/mdp5: Don't leak some plane state

Daniil Dulov (2):
      media: dib7000p: Fix potential division by zero
      media: cx24120: Add retval check for cx24120_message_send()

Dave Jiang (3):
      ntb: Drop packets when qp link is down
      ntb: Clean up tx tail index on link down
      ntb: Fix calculation ntb_transport_tx_free_entry()

Dave Stevenson (1):
      media: i2c: ov2680: Set V4L2_CTRL_FLAG_MODIFY_LAYOUT on flips

David Christensen (1):
      bnx2x: fix page fault following EEH recovery

David Woodhouse (1):
      eventfd: Export eventfd_ctx_do_read()

Dmitry Antipov (4):
      wifi: mwifiex: fix error recovery in PCIE buffer descriptor management
      wifi: mwifiex: fix memory leak in mwifiex_histogram_read()
      wifi: mwifiex: avoid possible NULL skb pointer dereference
      wifi: mwifiex: fix fortify warning

Dmitry Baryshkov (1):
      clk: qcom: gcc-mdm9615: use proper parent for pll0_vote clock

Dmitry Mastykin (1):
      netlabel: fix shift wrapping bug in netlbl_catmap_setlong()

Dmytro Maluka (2):
      ASoC: da7219: Flush pending AAD IRQ when suspending
      ASoC: da7219: Check for failure reading AAD IRQ events

Dominique Martinet (1):
      9p: virtio: make sure 'offs' is initialized in zc_request

Dongliang Mu (2):
      drivers: usb: smsusb: fix error handling code in smsusb_init_device
      wifi: ath9k: fix printk specifier

Edgar (1):
      ASoc: codecs: ES8316: Fix DMIC config

Enlin Mu (1):
      pstore/ram: Check start of empty przs during init

Enrico Weigelt, metux IT consult (1):
      arch: um: drivers: Kconfig: pedantic formatting

Eric Dumazet (3):
      tcp: tcp_enter_quickack_mode() should be static
      igmp: limit igmpv3_newpack() packet size to IP_MAX_MTU
      net: read sk->sk_family once in sk_mc_loop()

Fedor Pchelkin (4):
      wifi: ath9k: fix races between ath9k_wmi_cmd and ath9k_wmi_ctrl_rx
      wifi: ath9k: protect WMI command response buffer replacement with a lock
      NFSv4/pnfs: minor fix for cleanup path in nfs4_get_device_info
      autofs: fix memory leak of waitqueues in autofs_catatonic_mode

Filipe Manana (2):
      btrfs: don't start transaction when joining with TRANS_JOIN_NOSTART
      btrfs: fix lockdep splat and potential deadlock after failure running delayed items

Frederick Lawler (2):
      drm/amdgpu: Prefer pcie_capability_read_word()
      drm/radeon: Prefer pcie_capability_read_word()

GONG, Ruiqi (1):
      alx: fix OOB-read compiler warning

Gao Xiang (1):
      erofs: ensure that the post-EOF tails are all zeroed

Gaosheng Cui (1):
      audit: fix possible soft lockup in __audit_inode_child()

Gaurav Jain (1):
      crypto: caam - fix unchecked return value error

Geert Uytterhoeven (1):
      of: unittest: Fix overlay type in apply/revert check

Georg Ottinger (1):
      ext2: fix datatype of block number in ext2_xattr_set2()

Greg Kroah-Hartman (2):
      media: dvb: symbol fixup for dvb_attach()
      Linux 4.19.295

Guiting Shen (1):
      ASoC: atmel: Fix the 8K sample parameter in I2SC master

Gustavo A. R. Silva (2):
      ARM: OMAP2+: Fix -Warray-bounds warning in _pwrdm_state_switch()
      cpufreq: brcmstb-avs-cpufreq: Fix -Warray-bounds bug

Gustavo Pimentel (1):
      PCI: Decode PCIe 32 GT/s link speed

Hangyu Hua (1):
      net: ethernet: mtk_eth_soc: fix possible NULL pointer dereference in mtk_hwlro_get_fdir_all()

Hans Verkuil (2):
      media: tuners: qt1010: replace BUG_ON with a regular error
      media: pci: cx23885: replace BUG with error return

Hans de Goede (5):
      platform/x86: intel: hid: Always call BTNL ACPI method
      media: ov2680: Remove auto-gain and auto-exposure controls
      media: ov2680: Fix ov2680_bayer_order()
      media: ov2680: Fix vflip / hflip set functions
      media: ov2680: Fix regulators being left enabled on ov2680_power_on() errors

Helge Deller (4):
      parisc: Fix /proc/cpuinfo output for lscpu
      parisc: led: Fix LAN receive and transmit LEDs
      parisc: led: Reduce CPU overhead for disk & lan LED computation
      parisc: Drop loops_per_jiffy from per_cpu struct

Hugo Villeneuve (2):
      serial: sc16is7xx: fix bug when first setting GPIO direction
      serial: sc16is7xx: fix broken port 0 uart init

Ilpo Järvinen (5):
      PCI: pciehp: Use RMW accessors for changing LNKCTL
      PCI/ASPM: Use RMW accessors for changing LNKCTL
      drm/amdgpu: Use RMW accessors for changing LNKCTL
      drm/radeon: Use RMW accessors for changing LNKCTL
      wifi: ath10k: Use RMW accessors for changing LNKCTL

Irui Wang (1):
      media: mediatek: vcodec: Return NULL if no vdec_fb is found

Jamal Hadi Salim (1):
      net/sched: Retire rsvp classifier

Jan Kara (1):
      udf: Handle error when adding extent to a file

Jann Horn (1):
      dccp: Fix out of bounds access in DCCP error handler

Jeff Layton (1):
      nfsd: fix change_info in NFSv4 RENAME replies

Jiasheng Jiang (1):
      rpmsg: glink: Add check for kstrdup

Jinjie Ruan (1):
      net: arcnet: Do not call kfree_skb() under local_irq_disable()

Jiri Benc (1):
      vxlan: generalize vxlan_parse_gpe_hdr and remove unused args

Jiri Slaby (SUSE) (1):
      ACPI: video: Add backlight=native DMI quirk for Lenovo Ideapad Z470

Joel Stanley (1):
      powerpc/32: Include .branch_lt in data section

Jordan Rife (1):
      net: Avoid address overwrite in kernel_connect

Juerg Haefliger (1):
      fsi: master-ast-cf: Add MODULE_FIRMWARE macro

Konrad Dybcio (1):
      arm64: dts: qcom: msm8996: Add missing interrupt to the USB2 controller

Konstantin Meskhidze (1):
      kconfig: fix possible buffer overflow

Konstantin Shelekhin (1):
      scsi: target: iscsi: Fix buffer overflow in lio_target_nacl_info_show()

Krzysztof Kozlowski (9):
      ARM: dts: s3c6410: move fixed clocks under root node in Mini6410
      ARM: dts: s3c6410: align node SROM bus node name with dtschema in Mini6410
      ARM: dts: s3c64xx: align pinctrl with dtschema
      ARM: dts: samsung: s3c6410-mini6410: correct ethernet reg addresses (split)
      ARM: dts: s5pv210: add RTC 32 KHz clock in SMDKV210
      ARM: dts: s5pv210: use defines for IRQ flags in SMDKV210
      ARM: dts: s5pv210: correct ethernet unit address in SMDKV210
      ARM: dts: s5pv210: add dummy 5V regulator for backlight on SMDKv210
      ARM: dts: samsung: s5pv210-smdkv210: correct ethernet reg addresses (split)

Kuniyuki Iwashima (6):
      netrom: Deny concurrent connect().
      af_unix: Fix data-races around user->unix_inflight.
      af_unix: Fix data-race around unix_tot_inflight.
      af_unix: Fix data-races around sk->sk_shutdown.
      af_unix: Fix data race around sk->sk_err.
      kcm: Fix error handling for SOCK_DGRAM in kcm_sendmsg().

Kuppuswamy Sathyanarayanan (2):
      PCI/ATS: Add pci_prg_resp_pasid_required() interface.
      PCI/ATS: Add inline to pci_prg_resp_pasid_required()

Kyle Zeng (1):
      netfilter: ipset: add the missing IP_SET_HASH_WITH_NET0 macro for ip_set_hash_netportnet.c

Leon Romanovsky (1):
      Revert "IB/isert: Fix incorrect release of isert connection"

Liang Chen (1):
      veth: Fixing transmit return status for dropped packets

Liao Chang (1):
      cpufreq: powernow-k8: Use related_cpus instead of cpus in driver.exit()

Lin Ma (3):
      scsi: iscsi: Add strlen() check in iscsi_if_set{_host}_param()
      scsi: be2iscsi: Add length check when parsing nlattrs
      scsi: qla4xxx: Add length check when parsing nlattrs

Liu Shixin via Jfs-discussion (1):
      jfs: fix invalid free of JFS_IP(ipimap)->i_imap in diUnmount

Lu Jialin (1):
      cgroup:namespace: Remove unused cgroup_namespaces_init()

Ma Ke (1):
      usb: gadget: fsl_qe_udc: validate endpoint index for ch9 udc

Marc Kleine-Budde (1):
      can: gs_usb: gs_usb_receive_bulk_callback(): count RX overflow errors also in case of OOM

Marco Felsch (3):
      media: v4l2-fwnode: fix v4l2_fwnode_parse_link handling
      media: v4l2-fwnode: simplify v4l2_fwnode_parse_link
      usb: typec: tcpci: clear the fault status bit

Mario Limonciello (1):
      pinctrl: amd: Don't show `Invalid config param` errors

Mark O'Donovan (1):
      crypto: lib/mpi - avoid null pointer deref in mpi_cmp_ui()

Martin Kohn (2):
      USB: serial: option: add Quectel EM05G variant (0x030e)
      net: usb: qmi_wwan: add Quectel EM05GV2

Matthew Wilcox (1):
      reiserfs: Check the return value from __getblk()

Minjie Du (1):
      drivers: clk: keystone: Fix parameter judgment in _of_pll_clk_init()

Mohamed Khalfella (1):
      skbuff: skb_segment, Call zero copy functions before using skbuff frags

Namhyung Kim (1):
      perf hists browser: Fix hierarchy mode header

Nicolas Dichtel (1):
      net: handle ARPHRD_PPP in dev_is_mac_header_xmit()

Nigel Croxon (1):
      md/raid1: fix error: ISO C90 forbids mixed declarations

Oleksandr Natalenko (2):
      scsi: qedf: Do not touch __user pointer in qedf_dbg_stop_io_on_error_cmd_read() directly
      scsi: qedf: Do not touch __user pointer in qedf_dbg_fp_int_cmd_read() directly

Olga Zaborska (2):
      igbvf: Change IGBVF_MIN to allow set rx/tx value between 64 and 80
      igb: Change IGB_MIN to allow set rx/tx value between 64 and 80

Pablo Neira Ayuso (1):
      netfilter: nf_tables: missing NFT_TRANS_PREPARE_ERROR in flowtable deactivatation

Peng Fan (1):
      amba: bus: fix refcount leak

Polaris Pi (2):
      wifi: mwifiex: Fix OOB and integer underflow when rx packets
      wifi: mwifiex: Fix missed return in oob checks failed path

Qu Wenruo (1):
      btrfs: output extra debug info if we failed to find an inline backref

Quinn Tran (2):
      scsi: qla2xxx: fix inconsistent TMF timeout
      scsi: qla2xxx: Turn off noisy message log

Raag Jadav (1):
      watchdog: intel-mid_wdt: add MODULE_ALIAS() to allow auto-load

Radoslaw Tyl (1):
      igb: set max size RX buffer when store bad packet is enabled

Rafał Miłecki (5):
      ARM: dts: BCM53573: Describe on-SoC BCM53125 rev 4 switch
      ARM: dts: BCM53573: Drop nonexistent #usb-cells
      ARM: dts: BCM53573: Add cells sizes to PCIe node
      ARM: dts: BCM53573: Use updated "spi-gpio" binding properties
      ARM: dts: BCM53573: Fix Ethernet info for Luxul devices

Rahul Rameshbabu (1):
      HID: multitouch: Correct devm device reference for hidinput input_dev name

Randy Dunlap (2):
      x86/APM: drop the duplicate APM_MINOR_DEV macro
      um: Fix hostaudio build errors

Rob Clark (1):
      dma-buf/sync_file: Fix docs syntax

Rob Herring (1):
      media: Use of_node_name_eq for node name comparisons

Ruan Jinjie (1):
      of: unittest: fix null pointer dereferencing in of_unittest_find_node_by_name()

Russell Currey (1):
      powerpc/iommu: Fix notifiers being shared by PCI and VIO buses

Ryusuke Konishi (2):
      nilfs2: fix general protection fault in nilfs_lookup_dirty_data_buffers()
      nilfs2: fix WARNING in mark_buffer_dirty due to discarded buffer reuse

Sabrina Dubroca (1):
      Revert "net: macsec: preserve ingress frame ordering"

Sakari Ailus (1):
      media: pci: ipu3-cio2: Initialise timing struct to avoid a compiler warning

Sean Christopherson (1):
      x86/virt: Drop unnecessary check on extended CPUID level in cpu_has_svm()

Serge Semin (1):
      ARM: dts: BCM5301X: Harmonize EHCI/OHCI DT nodes name

Shigeru Yoshida (2):
      kcm: Destroy mutex in kcm_exit_net()
      kcm: Fix memory leak in error path of kcm_sendmsg()

Shyam Prasad N (1):
      cifs: add a warning when the in-flight count goes negative

Slark Xiao (1):
      USB: serial: option: add FOXCONN T99W368/T99W373 product

Stefan Haberland (2):
      s390/dasd: use correct number of retries for ERP requests
      s390/dasd: fix hanging device after request requeue

Su Hui (2):
      ALSA: ac97: Fix possible error value of *rac97
      fs: lockd: avoid possible wrong NULL parameter

Takashi Iwai (2):
      ALSA: seq: oss: Fix racy open/close of MIDI devices
      ALSA: pcm: Fix missing fixup call in compat hw_refine ioctl

Tan Zhongjun (1):
      drm/tegra: Remove superfluous error messages around platform_get_irq()

Thomas Bourgoin (1):
      crypto: stm32 - fix loop iterating through scatterlist for DMA

Thomas Zimmermann (6):
      drm/msm: Replace drm_framebuffer_{un/reference} with put, get functions
      backlight/gpio_backlight: Compare against struct fb_info.device
      backlight/bd6107: Compare against struct fb_info.device
      backlight/lv5207lp: Compare against struct fb_info.device
      fbdev/ep93xx-fb: Do not assign to struct fb_info.dev
      drm/ast: Fix DRAM init on AST2200

Thore Sommer (1):
      X.509: if signature is unsupported skip validation

Tom Rix (1):
      udf: initialize newblock to 0

Tomislav Novak (1):
      hw_breakpoint: fix single-stepping when using bpf_overflow_handler

Tony Battersby (1):
      scsi: core: Use 32-bit hostnum in scsi_host_lookup()

Tuo Li (1):
      drm/exynos: fix a possible null-pointer dereference due to data race in exynos_drm_crtc_atomic_disable()

Vadim Fedorenko (1):
      ixgbe: fix timestamp configuration code

Vladimir Zapolskiy (1):
      pwm: lpc32xx: Remove handling of PWM channels

Vladislav Efanov (1):
      udf: Check consistency of Space Bitmap Descriptor

Wander Lairson Costa (3):
      netfilter: xt_u32: validate user space input
      netfilter: xt_sctp: validate the flag_info count
      netfilter: nfnetlink_osf: avoid OOB read

Wang Ming (2):
      fs: Fix error checking for d_hash_and_lookup()
      wifi: ath9k: use IS_ERR() with debugfs_create_dir()

Wen Yang (1):
      eventfd: prevent underflow for eventfd semaphores

Wesley Chalmers (1):
      drm/amd/display: Fix a bug when searching for insert_above_mpcc

William Zhang (4):
      mtd: rawnand: brcmnand: Fix crash during the panic_write
      mtd: rawnand: brcmnand: Fix potential out-of-bounds access in oob write
      mtd: rawnand: brcmnand: Fix potential false time out warning
      mtd: rawnand: brcmnand: Fix ECC level field setting for v7.2 controller

Winston Wen (1):
      fs/nls: make load_nls() take a const parameter

Wu Zongyong (1):
      PCI: Mark NVIDIA T4 GPUs to avoid bus reset

Xiang Yang (1):
      IB/uverbs: Fix an potential error pointer dereference

Xu Yang (1):
      usb: phy: mxs: fix getting wrong state with mxs_phy_is_otg_host()

Yafang Shao (1):
      bpf: Clear the probe_addr for uprobe

Yan Zhai (1):
      lwt: Check LWTUNNEL_XMIT_CONTINUE strictly

Yangtao Li (1):
      drm/tegra: dpaux: Fix incorrect return value of platform_get_irq

Yi Yang (2):
      serial: tegra: handle clk prepare error in tegra_uart_hw_init()
      ipmi_si: fix a memleak in try_smi_init()

Yuanjun Gong (2):
      ethernet: atheros: fix return value check in atl1c_tso_csum()
      Bluetooth: nokia: fix value check in nokia_bluetooth_serdev_probe()

Zhang Jianhua (1):
      clk: sunxi-ng: Modify mismatched function name

Zhang Shurong (7):
      spi: tegra20-sflash: fix to check return value of platform_get_irq() in tegra_sflash_probe()
      md: raid1: fix potential OOB in raid1_remove_disk()
      media: dvb-usb-v2: af9035: Fix null-ptr-deref in af9035_i2c_master_xfer
      media: dw2102: Fix null-ptr-deref in dw2102_i2c_transfer()
      media: af9005: Fix null-ptr-deref in af9005_i2c_xfer
      media: anysee: fix null-ptr-deref in anysee_master_xfer
      media: az6007: Fix null-ptr-deref in az6007_i2c_xfer()

Zhen Lei (1):
      kobject: Add sanity check for kset->kobj.ktype in kset_register()

Zheng Wang (1):
      Bluetooth: btsdio: fix use after free bug in btsdio_remove due to race condition

ruanjinjie (2):
      dmaengine: ste_dma40: Add missing IRQ check in d40_probe
      powerpc/pseries: fix possible memory leak in ibmebus_bus_init()

valis (2):
      net: sched: sch_qfq: Fix UAF in qfq_dequeue()
      net/sched: cls_fw: No longer copy tcf_result on update to avoid use-after-free

wenxu (1):
      netfilter: nft_flow_offload: fix underflow in flowtable reference counter

