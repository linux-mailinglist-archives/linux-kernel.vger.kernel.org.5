Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D767ABF33
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 11:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjIWJW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 05:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjIWJW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 05:22:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C073136;
        Sat, 23 Sep 2023 02:22:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741B4C433C8;
        Sat, 23 Sep 2023 09:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695460968;
        bh=r/PS39cJX9c/pPA54KFAKNt5PFLGbOgiFe0+6k4MQLg=;
        h=From:To:Cc:Subject:Date:From;
        b=WeNBPIUSiSXGK9+G7iUcYHcHmeg3YgC1ZSZkxMz/QtbdpIiLjIustgjqlchaUKtpo
         zhnFey4apuNfF4uj6Zm1QNapAsBhRdnJAuMStvhUPOyj0EdoLrJxljOLLUKyKyOaB9
         MNA3l00PTxwOt9xpygrbLKNf82hARnbPo7uprtm4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.257
Date:   Sat, 23 Sep 2023 11:22:43 +0200
Message-ID: <2023092344-paralyses-cement-0040@gregkh>
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

I'm announcing the release of the 5.4.257 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/arm64/silicon-errata.rst               |    3 
 Makefile                                             |    2 
 arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts      |    3 
 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts        |   14 
 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts         |   15 
 arch/arm/boot/dts/bcm53573.dtsi                      |    3 
 arch/arm/boot/dts/bcm947189acdbmr.dts                |    6 
 arch/arm/boot/dts/s3c6410-mini6410.dts               |   38 
 arch/arm/boot/dts/s3c64xx-pinctrl.dtsi               |  210 ++---
 arch/arm/boot/dts/s5pv210-smdkv210.dts               |   24 
 arch/arm/kernel/hw_breakpoint.c                      |    8 
 arch/arm/mach-omap2/powerdomain.c                    |    2 
 arch/arm/mach-pxa/sharpsl_pm.c                       |    2 
 arch/arm/mach-pxa/spitz.c                            |   14 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                 |    1 
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
 arch/powerpc/kernel/fadump.c                         |    1 
 arch/powerpc/kernel/head_32.S                        |    2 
 arch/powerpc/kernel/iommu.c                          |   17 
 arch/powerpc/platforms/pseries/ibmebus.c             |    1 
 arch/s390/kernel/ipl.c                               |    2 
 arch/sh/boards/mach-ap325rxa/setup.c                 |    2 
 arch/sh/boards/mach-ecovec24/setup.c                 |    6 
 arch/sh/boards/mach-kfr2r09/setup.c                  |    2 
 arch/sh/boards/mach-migor/setup.c                    |    2 
 arch/sh/boards/mach-se/7724/setup.c                  |    6 
 arch/um/configs/i386_defconfig                       |    1 
 arch/um/configs/x86_64_defconfig                     |    1 
 arch/um/drivers/Kconfig                              |   16 
 arch/um/drivers/Makefile                             |    2 
 arch/x86/boot/compressed/head_32.S                   |    3 
 arch/x86/boot/compressed/head_64.S                   |   39 
 arch/x86/boot/pmjump.S                               |    6 
 arch/x86/entry/entry_64.S                            |    4 
 arch/x86/include/asm/virtext.h                       |    6 
 arch/x86/kernel/apm_32.c                             |    6 
 arch/x86/kernel/cpu/common.c                         |    8 
 arch/x86/realmode/rm/wakeup_asm.S                    |    6 
 arch/xtensa/include/asm/core.h                       |    9 
 arch/xtensa/kernel/perf_event.c                      |   17 
 crypto/asymmetric_keys/x509_public_key.c             |    5 
 drivers/acpi/acpica/psopcode.c                       |    2 
 drivers/acpi/arm64/iort.c                            |    5 
 drivers/acpi/video_detect.c                          |    9 
 drivers/amba/bus.c                                   |    1 
 drivers/ata/pata_ftide010.c                          |    1 
 drivers/ata/sata_gemini.c                            |    1 
 drivers/base/regmap/regcache-rbtree.c                |   10 
 drivers/base/test/test_async_driver_probe.c          |    2 
 drivers/bluetooth/btsdio.c                           |    1 
 drivers/bluetooth/hci_nokia.c                        |    6 
 drivers/bus/ti-sysc.c                                |    2 
 drivers/char/hw_random/iproc-rng200.c                |   33 
 drivers/char/ipmi/ipmi_si_intf.c                     |    5 
 drivers/char/ipmi/ipmi_ssif.c                        |    7 
 drivers/char/tpm/tpm_tis_core.c                      |   15 
 drivers/clk/Kconfig                                  |    1 
 drivers/clk/imx/clk-composite-8m.c                   |   12 
 drivers/clk/imx/clk-imx8mm.c                         |   87 --
 drivers/clk/imx/clk-pll14xx.c                        |   30 
 drivers/clk/imx/clk.h                                |    3 
 drivers/clk/keystone/pll.c                           |    2 
 drivers/clk/qcom/gcc-mdm9615.c                       |    2 
 drivers/clk/sunxi-ng/ccu_mmc_timing.c                |    2 
 drivers/cpufreq/brcmstb-avs-cpufreq.c                |    6 
 drivers/cpufreq/cpufreq.c                            |    2 
 drivers/cpufreq/powernow-k8.c                        |    3 
 drivers/crypto/caam/caampkc.c                        |    4 
 drivers/crypto/stm32/stm32-hash.c                    |    9 
 drivers/devfreq/devfreq.c                            |    1 
 drivers/dma/Kconfig                                  |    2 
 drivers/dma/ste_dma40.c                              |    4 
 drivers/firmware/stratix10-svc.c                     |    2 
 drivers/fsi/fsi-master-ast-cf.c                      |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c               |   18 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c              |   14 
 drivers/gpu/drm/amd/amdgpu/cik.c                     |   97 +-
 drivers/gpu/drm/amd/amdgpu/si.c                      |   99 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c     |    5 
 drivers/gpu/drm/armada/armada_overlay.c              |    6 
 drivers/gpu/drm/ast/ast_post.c                       |    2 
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c         |    9 
 drivers/gpu/drm/bridge/tc358764.c                    |    2 
 drivers/gpu/drm/drm_gem_vram_helper.c                |   24 
 drivers/gpu/drm/etnaviv/etnaviv_dump.c               |   14 
 drivers/gpu/drm/exynos/exynos_drm_crtc.c             |    5 
 drivers/gpu/drm/mediatek/mtk_drm_gem.c               |    6 
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c           |    3 
 drivers/gpu/drm/panel/panel-simple.c                 |    4 
 drivers/gpu/drm/radeon/cik.c                         |   96 +-
 drivers/gpu/drm/radeon/si.c                          |   98 +-
 drivers/gpu/drm/tegra/dpaux.c                        |    6 
 drivers/hid/hid-logitech-dj.c                        |    5 
 drivers/hid/hid-multitouch.c                         |   13 
 drivers/hid/wacom.h                                  |    1 
 drivers/hid/wacom_sys.c                              |   25 
 drivers/hid/wacom_wac.c                              |    1 
 drivers/hid/wacom_wac.h                              |    1 
 drivers/hwtracing/coresight/coresight-tmc-etf.c      |    2 
 drivers/hwtracing/coresight/coresight-tmc-etr.c      |    5 
 drivers/hwtracing/coresight/coresight-tmc.h          |    2 
 drivers/i2c/busses/i2c-aspeed.c                      |    7 
 drivers/infiniband/core/uverbs_std_types_counters.c  |    2 
 drivers/infiniband/sw/siw/siw_cm.c                   |    1 
 drivers/infiniband/sw/siw/siw_verbs.c                |    2 
 drivers/infiniband/ulp/isert/ib_isert.c              |    2 
 drivers/iommu/intel-pasid.c                          |    2 
 drivers/md/md-bitmap.c                               |   26 
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
 drivers/media/dvb-frontends/stv090x.c                |    2 
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
 drivers/media/i2c/ov5640.c                           |  127 +--
 drivers/media/pci/bt8xx/dst.c                        |    2 
 drivers/media/pci/bt8xx/dst_ca.c                     |    2 
 drivers/media/pci/cx23885/cx23885-video.c            |    2 
 drivers/media/pci/intel/ipu3/ipu3-cio2.c             |    2 
 drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c |    5 
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
 drivers/media/v4l2-core/v4l2-fwnode.c                |   43 -
 drivers/mmc/host/Kconfig                             |    5 
 drivers/mmc/host/sdhci-esdhc-imx.c                   |    7 
 drivers/mtd/nand/raw/brcmnand/brcmnand.c             |  112 +-
 drivers/mtd/nand/raw/fsmc_nand.c                     |    7 
 drivers/net/arcnet/arcnet.c                          |    2 
 drivers/net/can/usb/gs_usb.c                         |    5 
 drivers/net/ethernet/atheros/alx/ethtool.c           |    5 
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c      |    7 
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c     |    9 
 drivers/net/ethernet/freescale/enetc/enetc_ptp.c     |    2 
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c   |    4 
 drivers/net/ethernet/intel/igb/igb.h                 |    4 
 drivers/net/ethernet/intel/igb/igb_main.c            |   16 
 drivers/net/ethernet/intel/igbvf/igbvf.h             |    4 
 drivers/net/ethernet/intel/igc/igc.h                 |    4 
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c         |   28 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c      |    5 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c          |    3 
 drivers/net/ethernet/mellanox/mlxsw/i2c.c            |    5 
 drivers/net/macsec.c                                 |    3 
 drivers/net/usb/qmi_wwan.c                           |    1 
 drivers/net/usb/r8152.c                              |    3 
 drivers/net/veth.c                                   |    4 
 drivers/net/vxlan.c                                  |   58 -
 drivers/net/wireless/ath/ath10k/pci.c                |    9 
 drivers/net/wireless/ath/ath9k/ahb.c                 |    4 
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c       |    2 
 drivers/net/wireless/ath/ath9k/pci.c                 |    4 
 drivers/net/wireless/ath/ath9k/wmi.c                 |   20 
 drivers/net/wireless/mac80211_hwsim.c                |    7 
 drivers/net/wireless/marvell/mwifiex/debugfs.c       |    9 
 drivers/net/wireless/marvell/mwifiex/pcie.c          |  176 ++--
 drivers/net/wireless/marvell/mwifiex/sta_rx.c        |   12 
 drivers/net/wireless/marvell/mwifiex/tdls.c          |    9 
 drivers/net/wireless/marvell/mwifiex/uap_txrx.c      |   30 
 drivers/net/wireless/marvell/mwifiex/util.c          |   10 
 drivers/ntb/ntb_transport.c                          |   19 
 drivers/of/unittest.c                                |   12 
 drivers/opp/core.c                                   |    2 
 drivers/parisc/led.c                                 |    4 
 drivers/pci/hotplug/pciehp_hpc.c                     |   12 
 drivers/pci/pcie/aspm.c                              |   30 
 drivers/perf/arm_smmuv3_pmu.c                        |   46 +
 drivers/perf/fsl_imx8_ddr_perf.c                     |   24 
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c        |   18 
 drivers/pinctrl/pinctrl-amd.c                        |    4 
 drivers/platform/mellanox/mlxbf-tmfifo.c             |  104 +-
 drivers/platform/x86/huawei-wmi.c                    |    2 
 drivers/platform/x86/intel-hid.c                     |   21 
 drivers/pwm/pwm-lpc32xx.c                            |   16 
 drivers/rpmsg/qcom_glink_native.c                    |    4 
 drivers/rtc/rtc-ds1685.c                             |    2 
 drivers/s390/block/dasd.c                            |  125 +--
 drivers/s390/block/dasd_3990_erp.c                   |    2 
 drivers/s390/crypto/zcrypt_api.c                     |    1 
 drivers/scsi/be2iscsi/be_iscsi.c                     |    4 
 drivers/scsi/fcoe/fcoe_ctlr.c                        |   20 
 drivers/scsi/hosts.c                                 |    4 
 drivers/scsi/megaraid/megaraid_sas.h                 |    2 
 drivers/scsi/megaraid/megaraid_sas_base.c            |   21 
 drivers/scsi/qedf/qedf_dbg.h                         |    2 
 drivers/scsi/qedf/qedf_debugfs.c                     |   35 
 drivers/scsi/qedi/qedi_main.c                        |    5 
 drivers/scsi/qla2xxx/qla_attr.c                      |    2 
 drivers/scsi/qla2xxx/qla_dbg.c                       |    2 
 drivers/scsi/qla2xxx/qla_init.c                      |    3 
 drivers/scsi/qla2xxx/qla_isr.c                       |    7 
 drivers/scsi/qla2xxx/qla_nvme.c                      |    2 
 drivers/scsi/qla2xxx/qla_os.c                        |    9 
 drivers/scsi/qla4xxx/ql4_os.c                        |   15 
 drivers/scsi/scsi_transport_iscsi.c                  |    8 
 drivers/scsi/storvsc_drv.c                           |    2 
 drivers/soc/qcom/qmi_encdec.c                        |    4 
 drivers/spi/spi-tegra20-sflash.c                     |    6 
 drivers/staging/rtl8712/os_intfs.c                   |    1 
 drivers/staging/rtl8712/usb_intf.c                   |    1 
 drivers/target/iscsi/iscsi_target_configfs.c         |   54 -
 drivers/tty/serial/cpm_uart/cpm_uart_core.c          |   13 
 drivers/tty/serial/sc16is7xx.c                       |   18 
 drivers/tty/serial/serial-tegra.c                    |    6 
 drivers/tty/serial/sprd_serial.c                     |   68 -
 drivers/usb/gadget/function/f_mass_storage.c         |    2 
 drivers/usb/gadget/udc/fsl_qe_udc.c                  |    6 
 drivers/usb/phy/phy-mxs-usb.c                        |   10 
 drivers/usb/serial/option.c                          |    7 
 drivers/usb/typec/bus.c                              |   12 
 drivers/usb/typec/tcpm/tcpci.c                       |    4 
 drivers/usb/typec/tcpm/tcpci.h                       |    1 
 drivers/usb/typec/tcpm/tcpm.c                        |  122 +-
 drivers/video/backlight/bd6107.c                     |    2 
 drivers/video/backlight/gpio_backlight.c             |    2 
 drivers/video/backlight/lv5207lp.c                   |    2 
 drivers/video/fbdev/ep93xx-fb.c                      |    1 
 drivers/virtio/virtio_ring.c                         |    2 
 drivers/watchdog/intel-mid_wdt.c                     |    1 
 fs/attr.c                                            |   20 
 fs/autofs/waitq.c                                    |    3 
 fs/btrfs/ctree.h                                     |    2 
 fs/btrfs/delayed-inode.c                             |   19 
 fs/btrfs/disk-io.c                                   |   13 
 fs/btrfs/extent-tree.c                               |    5 
 fs/btrfs/transaction.c                               |    7 
 fs/btrfs/volumes.c                                   |    8 
 fs/btrfs/volumes.h                                   |    3 
 fs/cifs/cifsfs.c                                     |    7 
 fs/cifs/smb2ops.c                                    |    1 
 fs/debugfs/inode.c                                   |    6 
 fs/dlm/plock.c                                       |    6 
 fs/erofs/zdata.c                                     |    2 
 fs/eventfd.c                                         |    7 
 fs/ext2/xattr.c                                      |    4 
 fs/ext4/namei.c                                      |   26 
 fs/fuse/readdir.c                                    |   10 
 fs/jfs/jfs_dmap.c                                    |    1 
 fs/jfs/jfs_extent.c                                  |    5 
 fs/jfs/jfs_imap.c                                    |    1 
 fs/kernfs/mount.c                                    |    2 
 fs/lockd/mon.c                                       |    3 
 fs/locks.c                                           |    2 
 fs/namei.c                                           |   22 
 fs/nfs/blocklayout/dev.c                             |    4 
 fs/nfs/nfs2xdr.c                                     |    2 
 fs/nfs/nfs3xdr.c                                     |    2 
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
 fs/quota/dquot.c                                     |  184 ++--
 fs/reiserfs/journal.c                                |    4 
 fs/tracefs/inode.c                                   |    3 
 fs/udf/balloc.c                                      |   31 
 fs/udf/inode.c                                       |   45 -
 fs/verity/signature.c                                |   16 
 include/linux/acpi_iort.h                            |    1 
 include/linux/eventfd.h                              |    6 
 include/linux/if_arp.h                               |    4 
 include/linux/namei.h                                |    1 
 include/linux/nls.h                                  |    2 
 include/linux/perf_event.h                           |   22 
 include/linux/sched/task.h                           |   28 
 include/linux/trace_events.h                         |    3 
 include/linux/usb/typec_altmode.h                    |    2 
 include/net/ip_tunnels.h                             |   15 
 include/net/lwtunnel.h                               |    5 
 include/net/tcp.h                                    |    1 
 include/scsi/scsi_host.h                             |    2 
 include/uapi/linux/pci_regs.h                        |    2 
 include/uapi/linux/sync_file.h                       |    2 
 kernel/auditsc.c                                     |    2 
 kernel/fork.c                                        |    8 
 kernel/module.c                                      |   15 
 kernel/trace/bpf_trace.c                             |    2 
 kernel/trace/trace.c                                 |   43 -
 kernel/trace/trace_uprobe.c                          |    3 
 lib/idr.c                                            |    2 
 lib/kobject.c                                        |    5 
 lib/mpi/mpi-cmp.c                                    |    8 
 lib/test_meminit.c                                   |    2 
 mm/shmem.c                                           |   28 
 net/9p/trans_virtio.c                                |    2 
 net/core/devlink.c                                   |    4 
 net/core/flow_dissector.c                            |    3 
 net/core/lwt_bpf.c                                   |    7 
 net/core/skbuff.c                                    |   34 
 net/core/sock.c                                      |    9 
 net/dccp/ipv4.c                                      |   13 
 net/dccp/ipv6.c                                      |   15 
 net/ipv4/devinet.c                                   |   10 
 net/ipv4/fib_semantics.c                             |    5 
 net/ipv4/fib_trie.c                                  |    3 
 net/ipv4/igmp.c                                      |    3 
 net/ipv4/ip_output.c                                 |    2 
 net/ipv4/tcp_input.c                                 |    3 
 net/ipv6/addrconf.c                                  |    2 
 net/ipv6/ip6_output.c                                |    2 
 net/kcm/kcmsock.c                                    |   15 
 net/netfilter/ipset/ip_set_hash_netportnet.c         |    1 
 net/netfilter/nfnetlink_osf.c                        |    8 
 net/netfilter/xt_sctp.c                              |    2 
 net/netfilter/xt_u32.c                               |   21 
 net/netlabel/netlabel_kapi.c                         |    3 
 net/netrom/af_netrom.c                               |    5 
 net/sched/Kconfig                                    |   28 
 net/sched/Makefile                                   |    2 
 net/sched/cls_rsvp.c                                 |   24 
 net/sched/cls_rsvp.h                                 |  777 -------------------
 net/sched/cls_rsvp6.c                                |   24 
 net/sched/sch_hfsc.c                                 |    4 
 net/sched/sch_plug.c                                 |    2 
 net/sched/sch_qfq.c                                  |   22 
 net/sctp/proc.c                                      |    2 
 net/sctp/sm_sideeffect.c                             |    5 
 net/sctp/socket.c                                    |   10 
 net/socket.c                                         |    6 
 net/tls/tls_sw.c                                     |    4 
 net/unix/af_unix.c                                   |    2 
 net/unix/scm.c                                       |    6 
 scripts/kconfig/preprocess.c                         |    3 
 security/integrity/ima/Kconfig                       |   12 
 security/keys/keyctl.c                               |   11 
 security/smack/smackfs.c                             |    2 
 sound/Kconfig                                        |    2 
 sound/core/pcm_compat.c                              |    8 
 sound/core/seq/oss/seq_oss_midi.c                    |   35 
 sound/pci/ac97/ac97_codec.c                          |    5 
 sound/soc/atmel/atmel-i2s.c                          |    5 
 sound/soc/codecs/da7219-aad.c                        |   12 
 sound/soc/codecs/es8316.c                            |    2 
 tools/build/Makefile.feature                         |    2 
 tools/build/feature/Makefile                         |    4 
 tools/build/feature/test-all.c                       |    5 
 tools/build/feature/test-libbfd-buildid.c            |    8 
 tools/perf/Makefile.config                           |   43 -
 tools/perf/builtin-top.c                             |    1 
 tools/perf/pmu-events/Build                          |    5 
 tools/perf/ui/browsers/hists.c                       |    2 
 tools/perf/util/annotate.c                           |   10 
 tools/perf/util/header.c                             |   11 
 tools/testing/selftests/ftrace/ftracetest            |    8 
 465 files changed, 2914 insertions(+), 2927 deletions(-)

Aaron Armstrong Skomra (1):
      HID: wacom: remove the battery when the EKR is off

Abhishek Mainkar (1):
      ACPICA: Add AML_NO_OPERAND_RESOLVE flag to Timer

Ahmad Fatoum (1):
      clk: imx: composite-8m: fix clock pauses when set_rate would be a no-op

Al Viro (1):
      new helper: lookup_positive_unlocked()

Alan Stern (1):
      USB: gadget: f_mass_storage: Fix unused variable warning

Aleksa Sarai (1):
      procfs: block chmod on /proc/thread-self/comm

Aleksey Nasibulin (1):
      ARM: dts: BCM5301X: Extend RAM to full 256MB for Linksys EA6500 V2

Alex Henrie (1):
      net: ipv6/addrconf: avoid integer underflow in ipv6_create_tempaddr

Alexander Aring (1):
      dlm: fix plock lookup when using multiple lockspaces

Alexander Steffen (1):
      tpm_tis: Resend command to recover from data transfer errors

Alexei Filippov (1):
      jfs: validate max amount of blocks before allocation.

Anand Jain (3):
      btrfs: use the correct superblock to compare fsid in btrfs_validate_super
      btrfs: add a helper to read the superblock metadata_uuid
      btrfs: compare the correct fsid/metadata_uuid in btrfs_validate_super

Andrew Donnellan (1):
      lib/test_meminit: allocate pages up to order MAX_ORDER

Andrew Kanner (1):
      fs/jfs: prevent double-free in dbUnmount() after failed jfs_remount()

Andy Shevchenko (1):
      s390/zcrypt: don't leak memory if dev_set_name() fails

Anson Huang (1):
      clk: imx8mm: Move 1443X/1416X PLL clock structure to common place

Ard Biesheuvel (1):
      x86/decompressor: Don't rely on upper 32 bits of GPRs being preserved

Ariel Marcovitch (1):
      idr: fix param name in idr_alloc_cyclic() doc

Arnaldo Carvalho de Melo (3):
      perf annotate bpf: Don't enclose non-debug code with an assert()
      perf top: Don't pass an ERR_PTR() directly to perf_session__delete()
      tools features: Add feature test to check if libbfd has buildid support

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

Baoquan He (2):
      clk: fixed-mmio: make COMMON_CLK_FIXED_MMIO depend on HAS_IOMEM
      idmaengine: make FSL_EDMA and INTEL_IDMA64 depends on HAS_IOMEM

Ben Hutchings (1):
      m68k: Fix invalid .section syntax

Benjamin Coddington (1):
      NFS: Guard against READDIR loop when entry names exceed MAXNAMELEN

Bjorn Helgaas (6):
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

Budimir Markovic (1):
      net/sched: sch_hfsc: Ensure inner classes have fsc curve

Chengfeng Ye (2):
      scsi: qedi: Fix potential deadlock on &qedi_percpu->p_work_lock
      scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock

Chengguang Xu (1):
      quota: avoid increasing DQST_LOOKUPS when iterating over dirty/inuse list

Chris Lew (1):
      soc: qcom: qmi_encdec: Restrict string length in decode

Christian Brauner (2):
      tmpfs: verify {g,u}id mount options correctly
      attr: block mode changes of symlinks

Christian Göttsche (1):
      security: keys: perform capable check only on privileged operations

Christian König (1):
      drm/amdgpu: fix amdgpu_cs_p1_user_fence

Christoph Hellwig (4):
      mmc: au1xmmc: force non-modular build and remove symbol_get usage
      net: enetc: use EXPORT_SYMBOL_GPL for enetc_phc_index
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

Chunyan Zhang (4):
      serial: sprd: getting port index via serial aliases only
      serial: sprd: remove redundant sprd_port cleanup
      serial: sprd: Assign sprd_port after initialized to avoid wrong access
      serial: sprd: Fix DMA buffer leak issue

Colin Ian King (1):
      media: go7007: Remove redundant if statement

Corey Minyard (1):
      ipmi:ssif: Fix a memory leak when scanning for an adapter

Corinna Vinschen (1):
      igb: disable virtualization features on 82580

Damien Le Moal (2):
      ata: sata_gemini: Add missing MODULE_DESCRIPTION
      ata: pata_ftide010: Add missing MODULE_DESCRIPTION

Dan Carpenter (5):
      sctp: handle invalid error codes without calling BUG()
      regmap: rbtree: Use alloc_flags for memory allocations
      smackfs: Prevent underflow in smk_set_cipso()
      nfs/blocklayout: Use the passed in gfp flags
      driver core: test_async: fix an error code

Daniel Mack (1):
      sc16is7xx: Set iobase to device index

Daniel Vetter (1):
      drm/msm/mdp5: Don't leak some plane state

Daniil Dulov (2):
      media: dib7000p: Fix potential division by zero
      media: cx24120: Add retval check for cx24120_message_send()

Dave Hansen (1):
      x86/speculation: Mark all Skylake CPUs as vulnerable to GDS

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

Eric Biggers (1):
      fsverity: skip PKCS#7 parser when keyring is empty

Eric Dumazet (6):
      tcp: tcp_enter_quickack_mode() should be static
      igmp: limit igmpv3_newpack() packet size to IP_MAX_MTU
      sctp: annotate data-races around sk->sk_wmem_queued
      ipv4: annotate data-races around fi->fib_dead
      net: read sk->sk_family once in sk_mc_loop()
      ip_tunnels: use DEV_STATS_INC()

Fedor Pchelkin (4):
      wifi: ath9k: fix races between ath9k_wmi_cmd and ath9k_wmi_ctrl_rx
      wifi: ath9k: protect WMI command response buffer replacement with a lock
      NFSv4/pnfs: minor fix for cleanup path in nfs4_get_device_info
      autofs: fix memory leak of waitqueues in autofs_catatonic_mode

Filipe Manana (2):
      btrfs: don't start transaction when joining with TRANS_JOIN_NOSTART
      btrfs: fix lockdep splat and potential deadlock after failure running delayed items

Florian Fainelli (1):
      hwrng: iproc-rng200 - Implement suspend and resume calls

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

Geert Uytterhoeven (2):
      drm/armada: Fix off-by-one error in armada_overlay_get_property()
      of: unittest: Fix overlay type in apply/revert check

Georg Ottinger (1):
      ext2: fix datatype of block number in ext2_xattr_set2()

Giulio Benetti (1):
      mmc: sdhci-esdhc-imx: improve ESDHC_FLAG_ERR010450

Greg Kroah-Hartman (2):
      media: dvb: symbol fixup for dvb_attach()
      Linux 5.4.257

Guiting Shen (1):
      ASoC: atmel: Fix the 8K sample parameter in I2SC master

Guoqing Jiang (3):
      md/bitmap: don't set max_write_behind if there is no write mostly device
      RDMA/siw: Balance the reference of cep->kref in the error path
      RDMA/siw: Correct wrong debug message

Gustavo A. R. Silva (2):
      ARM: OMAP2+: Fix -Warray-bounds warning in _pwrdm_state_switch()
      cpufreq: brcmstb-avs-cpufreq: Fix -Warray-bounds bug

Hangyu Hua (2):
      net: ethernet: mvpp2_main: fix possible OOB write in mvpp2_ethtool_get_rxnfc()
      net: ethernet: mtk_eth_soc: fix possible NULL pointer dereference in mtk_hwlro_get_fdir_all()

Hans Verkuil (2):
      media: tuners: qt1010: replace BUG_ON with a regular error
      media: pci: cx23885: replace BUG with error return

Hans de Goede (7):
      platform/x86: intel: hid: Always call BTNL ACPI method
      media: ov2680: Remove auto-gain and auto-exposure controls
      media: ov2680: Fix ov2680_bayer_order()
      media: ov2680: Fix vflip / hflip set functions
      media: ov2680: Fix regulators being left enabled on ov2680_power_on() errors
      usb: typec: tcpm: Refactor tcpm_handle_vdm_request payload handling
      usb: typec: tcpm: Refactor tcpm_handle_vdm_request

Hayes Wang (1):
      r8152: check budget for r8152_poll()

Helge Deller (4):
      parisc: Fix /proc/cpuinfo output for lscpu
      parisc: led: Fix LAN receive and transmit LEDs
      parisc: led: Reduce CPU overhead for disk & lan LED computation
      parisc: Drop loops_per_jiffy from per_cpu struct

Hugo Villeneuve (2):
      serial: sc16is7xx: fix bug when first setting GPIO direction
      serial: sc16is7xx: fix broken port 0 uart init

Ian Rogers (1):
      perf tools: Add an option to build without libbfd

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

Jia Yang (1):
      drm: fix double free for gbo in drm_gem_vram_init and drm_gem_vram_create

Jiasheng Jiang (2):
      ipmi:ssif: Add check for kstrdup
      rpmsg: glink: Add check for kstrdup

Jinjie Ruan (1):
      net: arcnet: Do not call kfree_skb() under local_irq_disable()

Jiri Benc (1):
      vxlan: generalize vxlan_parse_gpe_hdr and remove unused args

Jiri Pirko (1):
      devlink: remove reload failed checks in params get/set callbacks

Jiri Slaby (2):
      x86/asm: Make more symbols local
      x86/boot: Annotate local functions

Jiri Slaby (SUSE) (1):
      ACPI: video: Add backlight=native DMI quirk for Lenovo Ideapad Z470

Johannes Berg (1):
      wifi: mac80211_hwsim: drop short frames

John Garry (1):
      perf jevents: Make build dependency on test JSONs

Jonas Karlman (2):
      phy/rockchip: inno-hdmi: use correct vco_div_5 macro on rk3328
      phy/rockchip: inno-hdmi: do not power on rk3328 post pll on reg write

Jordan Rife (1):
      net: Avoid address overwrite in kernel_connect

Josef Bacik (1):
      btrfs: move btrfs_pinned_by_swapfile prototype into volumes.h

Juerg Haefliger (1):
      fsi: master-ast-cf: Add MODULE_FIRMWARE macro

Julia Lawall (1):
      hwrng: iproc-rng200 - use semicolons rather than commas to separate statements

Junxiao Bi (1):
      scsi: megaraid_sas: Fix deadlock on firmware crashdump

Konstantin Meskhidze (1):
      kconfig: fix possible buffer overflow

Konstantin Shelekhin (2):
      platform/x86: huawei-wmi: Silence ambient light sensor
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

Kyle Zeng (1):
      netfilter: ipset: add the missing IP_SET_HASH_WITH_NET0 macro for ip_set_hash_netportnet.c

Lad Prabhakar (1):
      media: i2c: ov5640: Configure HVP lines in s_power callback

Leon Romanovsky (1):
      Revert "IB/isert: Fix incorrect release of isert connection"

Liang Chen (1):
      veth: Fixing transmit return status for dropped packets

Liao Chang (2):
      cpufreq: powernow-k8: Use related_cpus instead of cpus in driver.exit()
      cpufreq: Fix the race condition while updating the transition_task of policy

Liming Sun (2):
      platform/mellanox: mlxbf-tmfifo: Drop the Rx packet if no more descriptors
      platform/mellanox: mlxbf-tmfifo: Drop jumbo frames

Lin Ma (3):
      scsi: iscsi: Add strlen() check in iscsi_if_set{_host}_param()
      scsi: be2iscsi: Add length check when parsing nlattrs
      scsi: qla4xxx: Add length check when parsing nlattrs

Liu Jian (2):
      net: ipv4: fix one memleak in __inet_del_ifa()
      net/tls: do not free tls_rec on async operation in bpf_exec_tx_verdict()

Liu Shixin via Jfs-discussion (1):
      jfs: fix invalid free of JFS_IP(ipimap)->i_imap in diUnmount

Lucas Stach (1):
      drm/etnaviv: fix dumping of active MMU context

Ma Ke (1):
      usb: gadget: fsl_qe_udc: validate endpoint index for ch9 udc

Manish Rangankar (1):
      scsi: qla2xxx: Remove unsupported ql2xenabledif option

Manivannan Sadhasivam (2):
      OPP: Fix passing 0 to PTR_ERR in _opp_attach_genpd()
      arm64: dts: qcom: sdm845: Add missing RPMh power domain to GCC

Marc Kleine-Budde (1):
      can: gs_usb: gs_usb_receive_bulk_callback(): count RX overflow errors also in case of OOM

Marco Felsch (3):
      media: v4l2-fwnode: fix v4l2_fwnode_parse_link handling
      media: v4l2-fwnode: simplify v4l2_fwnode_parse_link
      usb: typec: tcpci: clear the fault status bit

Marek Vasut (3):
      drm/bridge: tc358764: Fix debug print parameter order
      drm/panel: simple: Add missing connector type and pixel format for AUO T215HVN01
      media: ov5640: Enable MIPI interface in ov5640_set_power_mipi()

Mario Limonciello (1):
      pinctrl: amd: Don't show `Invalid config param` errors

Mark O'Donovan (1):
      crypto: lib/mpi - avoid null pointer deref in mpi_cmp_ui()

Martin Kohn (2):
      USB: serial: option: add Quectel EM05G variant (0x030e)
      net: usb: qmi_wwan: add Quectel EM05GV2

Masami Hiramatsu (Google) (1):
      selftests: tracing: Fix to unmount tracefs for recovering environment

Matthew Wilcox (1):
      reiserfs: Check the return value from __getblk()

Max Filippov (1):
      xtensa: PMU: fix base address for the newer hardware

Michael Kelley (1):
      scsi: storvsc: Always set no_report_opcodes

Michael S. Tsirkin (1):
      mlxbf-tmfifo: sparse tags for config access

Minjie Du (1):
      drivers: clk: keystone: Fix parameter judgment in _of_pll_clk_init()

Mohamed Khalfella (1):
      skbuff: skb_segment, Call zero copy functions before using skbuff frags

Nam Cao (1):
      staging: rtl8712: fix race condition

Namhyung Kim (2):
      perf hists browser: Fix hierarchy mode header
      perf tools: Handle old data in PERF_RECORD_ATTR

Nayna Jain (1):
      ima: Remove deprecated IMA_TRUSTED_KEYRING Kconfig

Nicolas Dichtel (1):
      net: handle ARPHRD_PPP in dev_is_mac_header_xmit()

Nigel Croxon (1):
      md/raid1: fix error: ISO C90 forbids mixed declarations

Nikita Zhandarovich (1):
      HID: logitech-dj: Fix error handling in logi_dj_recv_switch_to_dj_mode()

Oleksandr Natalenko (3):
      scsi: qedf: Do not touch __user pointer in qedf_dbg_stop_io_on_error_cmd_read() directly
      scsi: qedf: Do not touch __user pointer in qedf_dbg_debug_cmd_read() directly
      scsi: qedf: Do not touch __user pointer in qedf_dbg_fp_int_cmd_read() directly

Olga Zaborska (3):
      igc: Change IGC_MIN to allow set rx/tx value between 64 and 80
      igbvf: Change IGBVF_MIN to allow set rx/tx value between 64 and 80
      igb: Change IGB_MIN to allow set rx/tx value between 64 and 80

Peng Fan (1):
      amba: bus: fix refcount leak

Petr Tesarik (1):
      sh: boards: Fix CEU buffer size passed to dma_declare_coherent_memory()

Polaris Pi (2):
      wifi: mwifiex: Fix OOB and integer underflow when rx packets
      wifi: mwifiex: Fix missed return in oob checks failed path

Qu Wenruo (1):
      btrfs: output extra debug info if we failed to find an inline backref

Quan Tian (1):
      net/ipv6: SKB symmetric hash should incorporate transport ports

Quinn Tran (3):
      scsi: qla2xxx: fix inconsistent TMF timeout
      scsi: qla2xxx: Fix erroneous link up failure
      scsi: qla2xxx: Turn off noisy message log

RD Babiera (1):
      usb: typec: bus: verify partner exists in typec_altmode_attention

Raag Jadav (1):
      watchdog: intel-mid_wdt: add MODULE_ALIAS() to allow auto-load

Radoslaw Tyl (1):
      igb: set max size RX buffer when store bad packet is enabled

Rafał Miłecki (4):
      ARM: dts: BCM53573: Drop nonexistent "default-off" LED trigger
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

Ruan Jinjie (1):
      of: unittest: fix null pointer dereferencing in of_unittest_find_node_by_name()

Ruidong Tian (1):
      coresight: tmc: Explicit type conversions to prevent integer overflow

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

Shida Zhang (1):
      ext4: fix rec_len verify error

Shigeru Yoshida (2):
      kcm: Destroy mutex in kcm_exit_net()
      kcm: Fix memory leak in error path of kcm_sendmsg()

Shih-Yi Chen (1):
      platform/mellanox: Fix mlxbf-tmfifo not handling all virtio CONSOLE notifications

Shyam Prasad N (1):
      cifs: add a warning when the in-flight count goes negative

Slark Xiao (1):
      USB: serial: option: add FOXCONN T99W368/T99W373 product

Sourabh Jain (1):
      powerpc/fadump: reset dump area size if fadump memory reserve fails

Srinivasan Shanmugam (1):
      drm/amdgpu: Update min() to min_t() in 'amdgpu_info_ioctl'

Stefan Haberland (2):
      s390/dasd: use correct number of retries for ERP requests
      s390/dasd: fix hanging device after request requeue

Steven Rostedt (Google) (3):
      tracing: Have current_trace inc the trace array ref count
      tracing: Have option files inc the trace array ref count
      tracefs: Add missing lockdown check to tracefs_create_dir()

Su Hui (2):
      ALSA: ac97: Fix possible error value of *rac97
      fs: lockd: avoid possible wrong NULL parameter

Sui Jingfeng (1):
      drm/mediatek: Fix potential memory leak if vmap() fail

Sven Schnelle (1):
      s390/ipl: add missing secure/has_secure file to ipl type 'unknown'

Takashi Iwai (2):
      ALSA: seq: oss: Fix racy open/close of MIDI devices
      ALSA: pcm: Fix missing fixup call in compat hw_refine ioctl

Tan Zhongjun (1):
      drm/tegra: Remove superfluous error messages around platform_get_irq()

Thomas Bourgoin (1):
      crypto: stm32 - fix loop iterating through scatterlist for DMA

Thomas Zimmermann (5):
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

Tommy Huang (1):
      i2c: aspeed: Reset the i2c controller when timeout occurs

Tony Battersby (1):
      scsi: core: Use 32-bit hostnum in scsi_host_lookup()

Tony Lindgren (1):
      bus: ti-sysc: Configure uart quirks for k3 SoC

Tuo Li (1):
      drm/exynos: fix a possible null-pointer dereference due to data race in exynos_drm_crtc_atomic_disable()

Uwe Kleine-König (1):
      crypto: stm32 - Properly handle pm_runtime_get failing

Vadim Fedorenko (1):
      ixgbe: fix timestamp configuration code

Vadim Pasternak (2):
      mlxsw: i2c: Fix chunk size setting in output mailbox buffer
      mlxsw: i2c: Limit single transaction buffer size

Vladimir Zapolskiy (1):
      pwm: lpc32xx: Remove handling of PWM channels

Vladislav Efanov (1):
      udf: Check consistency of Space Bitmap Descriptor

Wander Lairson Costa (4):
      netfilter: xt_u32: validate user space input
      netfilter: xt_sctp: validate the flag_info count
      netfilter: nfnetlink_osf: avoid OOB read
      kernel/fork: beware of __put_task_struct() calling context

Wang Ming (3):
      firmware: stratix10-svc: Fix an NULL vs IS_ERR() bug in probe
      fs: Fix error checking for d_hash_and_lookup()
      wifi: ath9k: use IS_ERR() with debugfs_create_dir()

Wen Yang (1):
      eventfd: prevent underflow for eventfd semaphores

Wesley Chalmers (1):
      drm/amd/display: Fix a bug when searching for insert_above_mpcc

Will Shiu (1):
      locks: fix KASAN: use-after-free in trace_event_raw_event_filelock_lock

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

Xu Yang (2):
      perf/imx_ddr: don't enable counter0 if none of 4 counters are used
      usb: phy: mxs: fix getting wrong state with mxs_phy_is_otg_host()

Yafang Shao (1):
      bpf: Clear the probe_addr for uprobe

Yan Zhai (2):
      lwt: Fix return values of BPF xmit ops
      lwt: Check LWTUNNEL_XMIT_CONTINUE strictly

Yanfei Xu (1):
      iommu/vt-d: Fix to flush cache of PASID directory table

Yangtao Li (1):
      drm/tegra: dpaux: Fix incorrect return value of platform_get_irq

Yi Yang (3):
      serial: tegra: handle clk prepare error in tegra_uart_hw_init()
      mtd: rawnand: fsmc: handle clk prepare error in fsmc_nand_resume()
      ipmi_si: fix a memleak in try_smi_init()

Yicong Yang (1):
      perf/smmuv3: Enable HiSilicon Erratum 162001900 quirk for HIP08/09

Yisen Zhuang (1):
      net: hns3: fix the port information display when sfp is absent

Yu Kuai (1):
      md/md-bitmap: hold 'reconfig_mutex' in backlog_store()

Yuan Yao (1):
      virtio_ring: fix avail_wrap_counter in virtqueue_add_packed

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

Zheng Yang (1):
      phy/rockchip: inno-hdmi: round fractal pixclock in rk3328 recalc_rate

Zheng Yejian (1):
      tracing: Fix race issue between cpu buffer write and swap

ruanjinjie (2):
      dmaengine: ste_dma40: Add missing IRQ check in d40_probe
      powerpc/pseries: fix possible memory leak in ibmebus_bus_init()

ruanmeisi (1):
      fuse: nlookup missing decrement in fuse_direntplus_link

valis (1):
      net: sched: sch_qfq: Fix UAF in qfq_dequeue()

