Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F72F7F113F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjKTLD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjKTLDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:03:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3AD9C;
        Mon, 20 Nov 2023 03:03:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BEFC433C8;
        Mon, 20 Nov 2023 11:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700478225;
        bh=djKz9SixUMRvQ7IXRyUmTz4KbrzjdXLSEHPtNH0km+Q=;
        h=From:To:Cc:Subject:Date:From;
        b=ld2xbXSjZPC9phheGsl8bBAVMjhfV3aCAgROSzvK0BFPm9jkraKs+65kIinMXviG8
         Zqz42LxckYgzqRSJ7XaxO+N4fW1gO7BoGF0h6TNE7wza0a5B7ULpwVToXqB8DPG7mC
         kPfTpzgvoNlBahSeQBvQmP2JzG2/BHnaHd6asP0A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.63
Date:   Mon, 20 Nov 2023 12:03:41 +0100
Message-ID: <2023112041-cleat-vertigo-6995@gregkh>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.1.63 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/mfd/mt6397.txt                |    5 
 Documentation/virt/coco/sev-guest.rst                           |   20 
 Makefile                                                        |    2 
 arch/arm/boot/dts/am3517-evm.dts                                |   16 
 arch/arm/boot/dts/qcom-mdm9615.dtsi                             |   14 
 arch/arm/boot/dts/r8a7792-blanche.dts                           |    2 
 arch/arm/lib/memset.S                                           |    1 
 arch/arm/xen/enlighten.c                                        |   25 
 arch/arm64/boot/dts/freescale/imx8mm.dtsi                       |    1 
 arch/arm64/boot/dts/freescale/imx8mn.dtsi                       |    1 
 arch/arm64/boot/dts/freescale/imx8qm-ss-img.dtsi                |    2 
 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi                     |    4 
 arch/arm64/boot/dts/marvell/cn9130-db.dtsi                      |    4 
 arch/arm64/boot/dts/nvidia/tegra234.dtsi                        |   12 
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts                        |    3 
 arch/arm64/boot/dts/qcom/msm8916.dtsi                           |    2 
 arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts               |    5 
 arch/arm64/boot/dts/qcom/sc7280.dtsi                            |   11 
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi                      |   12 
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts                         |    2 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                            |   12 
 arch/arm64/boot/dts/qcom/sm8350.dtsi                            |    2 
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                         |    2 
 arch/arm64/include/asm/cputype.h                                |    3 
 arch/arm64/kvm/guest.c                                          |    2 
 arch/powerpc/include/asm/nohash/32/pte-40x.h                    |    3 
 arch/powerpc/kernel/traps.c                                     |    2 
 arch/powerpc/perf/imc-pmu.c                                     |    2 
 arch/powerpc/platforms/book3s/vas-api.c                         |   34 
 arch/powerpc/platforms/pseries/lpar.c                           |    4 
 arch/powerpc/platforms/pseries/vas.c                            |    4 
 arch/powerpc/sysdev/xive/native.c                               |    2 
 arch/riscv/kernel/cpu.c                                         |   11 
 arch/sh/Kconfig.debug                                           |   11 
 arch/x86/include/asm/sev-common.h                               |    4 
 arch/x86/include/asm/sev.h                                      |   10 
 arch/x86/include/asm/sparsemem.h                                |    2 
 arch/x86/include/asm/uaccess.h                                  |    2 
 arch/x86/kernel/amd_nb.c                                        |    3 
 arch/x86/kernel/cpu/bugs.c                                      |    2 
 arch/x86/kernel/head64.c                                        |    2 
 arch/x86/kernel/sev.c                                           |   15 
 arch/x86/lib/copy_mc.c                                          |    8 
 arch/x86/mm/maccess.c                                           |   19 
 arch/x86/mm/numa.c                                              |   80 
 block/blk-core.c                                                |    4 
 drivers/acpi/device_sysfs.c                                     |   10 
 drivers/acpi/numa/srat.c                                        |   11 
 drivers/acpi/property.c                                         |   19 
 drivers/acpi/video_detect.c                                     |   26 
 drivers/base/regmap/regmap-debugfs.c                            |    2 
 drivers/base/regmap/regmap.c                                    |   16 
 drivers/block/nbd.c                                             |   11 
 drivers/char/hw_random/bcm2835-rng.c                            |    2 
 drivers/char/hw_random/core.c                                   |    6 
 drivers/char/hw_random/geode-rng.c                              |    6 
 drivers/clk/clk-npcm7xx.c                                       |    2 
 drivers/clk/clk-scmi.c                                          |    1 
 drivers/clk/imx/Kconfig                                         |    1 
 drivers/clk/imx/clk-imx8mq.c                                    |   17 
 drivers/clk/imx/clk-imx8qxp.c                                   |    2 
 drivers/clk/keystone/pll.c                                      |   15 
 drivers/clk/mediatek/clk-mt2701.c                               |    8 
 drivers/clk/mediatek/clk-mt6765.c                               |    6 
 drivers/clk/mediatek/clk-mt6779.c                               |    4 
 drivers/clk/mediatek/clk-mt6797.c                               |    6 
 drivers/clk/mediatek/clk-mt7629-eth.c                           |    4 
 drivers/clk/mediatek/clk-mt7629.c                               |    6 
 drivers/clk/qcom/Kconfig                                        |    1 
 drivers/clk/qcom/clk-rcg2.c                                     |   14 
 drivers/clk/qcom/gcc-msm8996.c                                  |  237 -
 drivers/clk/qcom/gcc-sm8150.c                                   |    2 
 drivers/clk/qcom/mmcc-msm8998.c                                 |    7 
 drivers/clk/renesas/rcar-cpg-lib.c                              |   15 
 drivers/clk/renesas/rzg2l-cpg.c                                 |   62 
 drivers/clk/renesas/rzg2l-cpg.h                                 |    2 
 drivers/clk/ti/apll.c                                           |    4 
 drivers/clk/ti/clk-dra7-atl.c                                   |    2 
 drivers/clk/ti/clk.c                                            |   34 
 drivers/clk/ti/clkctrl.c                                        |    4 
 drivers/clk/ti/clock.h                                          |   10 
 drivers/clk/ti/composite.c                                      |    2 
 drivers/clk/ti/divider.c                                        |    8 
 drivers/clk/ti/dpll.c                                           |    4 
 drivers/clk/ti/fixed-factor.c                                   |    2 
 drivers/clk/ti/gate.c                                           |    6 
 drivers/clk/ti/interface.c                                      |    7 
 drivers/clk/ti/mux.c                                            |    6 
 drivers/clocksource/arm_arch_timer.c                            |    5 
 drivers/clocksource/timer-ti-dm.c                               |   36 
 drivers/crypto/caam/caamalg.c                                   |    3 
 drivers/crypto/caam/caamalg_qi2.c                               |    3 
 drivers/crypto/ccp/sev-dev.c                                    |    8 
 drivers/crypto/hisilicon/Makefile                               |    2 
 drivers/crypto/hisilicon/debugfs.c                              | 1097 ++++++++
 drivers/crypto/hisilicon/hpre/hpre_main.c                       |   14 
 drivers/crypto/hisilicon/qm.c                                   | 1370 ----------
 drivers/crypto/hisilicon/qm_common.h                            |   86 
 drivers/crypto/hisilicon/sec2/sec_main.c                        |   12 
 drivers/crypto/hisilicon/zip/zip_main.c                         |   12 
 drivers/crypto/qat/qat_common/Makefile                          |    3 
 drivers/crypto/qat/qat_common/adf_accel_devices.h               |    2 
 drivers/crypto/qat/qat_common/adf_common_drv.h                  |    1 
 drivers/crypto/qat/qat_common/adf_init.c                        |    6 
 drivers/crypto/qat/qat_common/adf_sysfs.c                       |    4 
 drivers/crypto/qat/qat_common/adf_transport_debug.c             |    4 
 drivers/crypto/qat/qat_common/qat_algs.c                        |  208 -
 drivers/crypto/qat/qat_common/qat_algs_send.c                   |   46 
 drivers/crypto/qat/qat_common/qat_bl.c                          |  224 +
 drivers/crypto/qat/qat_common/qat_bl.h                          |   55 
 drivers/crypto/qat/qat_common/qat_crypto.h                      |   36 
 drivers/cxl/core/memdev.c                                       |    2 
 drivers/devfreq/event/rockchip-dfi.c                            |   15 
 drivers/dma/idxd/Makefile                                       |    6 
 drivers/dma/pxa_dma.c                                           |    1 
 drivers/dma/ti/edma.c                                           |    4 
 drivers/firmware/arm_ffa/bus.c                                  |    1 
 drivers/firmware/arm_ffa/driver.c                               |   12 
 drivers/firmware/ti_sci.c                                       |   46 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                            |    8 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c               |   70 
 drivers/gpu/drm/bridge/ite-it66121.c                            |   12 
 drivers/gpu/drm/bridge/lontium-lt8912b.c                        |   37 
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c                      |   10 
 drivers/gpu/drm/bridge/tc358768.c                               |  168 -
 drivers/gpu/drm/drm_syncobj.c                                   |    3 
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c                         |    3 
 drivers/gpu/drm/mediatek/mtk_drm_plane.c                        |    2 
 drivers/gpu/drm/mediatek/mtk_dsi.c                              |    4 
 drivers/gpu/drm/msm/dsi/dsi.c                                   |    1 
 drivers/gpu/drm/msm/dsi/dsi.h                                   |    1 
 drivers/gpu/drm/msm/dsi/dsi_host.c                              |   16 
 drivers/gpu/drm/radeon/evergreen.c                              |    7 
 drivers/gpu/drm/rockchip/cdn-dp-core.c                          |   15 
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c                     |    2 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c                     |    8 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c                    |   39 
 drivers/gpu/host1x/context.c                                    |    4 
 drivers/hid/hid-cp2112.c                                        |   43 
 drivers/hid/hid-logitech-hidpp.c                                |   76 
 drivers/hte/hte-tegra194-test.c                                 |    4 
 drivers/hwmon/axi-fan-control.c                                 |   29 
 drivers/hwmon/coretemp.c                                        |    2 
 drivers/hwmon/nct6775-core.c                                    |   12 
 drivers/hwmon/sch5627.c                                         |   21 
 drivers/hwmon/sch56xx-common.c                                  |   64 
 drivers/i2c/busses/i2c-bcm-iproc.c                              |  133 
 drivers/i3c/master.c                                            |    4 
 drivers/iio/frequency/adf4350.c                                 |   75 
 drivers/infiniband/core/device.c                                |    2 
 drivers/infiniband/core/sa_query.c                              |    4 
 drivers/infiniband/core/sysfs.c                                 |   10 
 drivers/infiniband/core/user_mad.c                              |    4 
 drivers/infiniband/hw/hfi1/efivar.c                             |    2 
 drivers/infiniband/hw/hns/hns_roce_ah.c                         |   13 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                      |   34 
 drivers/infiniband/hw/hns/hns_roce_qp.c                         |    2 
 drivers/infiniband/hw/mlx5/main.c                               |    4 
 drivers/infiniband/hw/mlx5/qp.c                                 |   27 
 drivers/input/rmi4/rmi_bus.c                                    |    2 
 drivers/interconnect/core.c                                     |   12 
 drivers/interconnect/qcom/sc7180.c                              |  256 +
 drivers/interconnect/qcom/sc7280.c                              |    1 
 drivers/interconnect/qcom/sc8180x.c                             |    1 
 drivers/interconnect/qcom/sc8280xp.c                            |    1 
 drivers/interconnect/qcom/sdm845.c                              |  278 +-
 drivers/interconnect/qcom/sm6350.c                              |  252 +
 drivers/interconnect/qcom/sm8150.c                              |  305 +-
 drivers/interconnect/qcom/sm8150.h                              |    4 
 drivers/interconnect/qcom/sm8350.c                              |  309 ++
 drivers/leds/leds-pwm.c                                         |    2 
 drivers/leds/leds-turris-omnia.c                                |   65 
 drivers/leds/trigger/ledtrig-cpu.c                              |    4 
 drivers/media/cec/platform/Makefile                             |    2 
 drivers/media/i2c/max9286.c                                     |    2 
 drivers/media/i2c/ov5640.c                                      |   37 
 drivers/media/pci/bt8xx/bttv-driver.c                           |    1 
 drivers/media/platform/amphion/vpu_defs.h                       |    1 
 drivers/media/platform/amphion/vpu_helpers.c                    |    1 
 drivers/media/platform/amphion/vpu_malone.c                     |    1 
 drivers/media/platform/amphion/vpu_msgs.c                       |   31 
 drivers/media/platform/cadence/cdns-csi2rx.c                    |    7 
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c          |    5 
 drivers/media/platform/samsung/s3c-camif/camif-capture.c        |    6 
 drivers/media/platform/verisilicon/hantro_drv.c                 |    3 
 drivers/media/platform/verisilicon/hantro_postproc.c            |    2 
 drivers/media/test-drivers/vidtv/vidtv_mux.c                    |    7 
 drivers/media/test-drivers/vidtv/vidtv_psi.c                    |   45 
 drivers/media/usb/dvb-usb-v2/af9035.c                           |   13 
 drivers/mfd/arizona-spi.c                                       |    3 
 drivers/mfd/dln2.c                                              |    1 
 drivers/mfd/mfd-core.c                                          |   17 
 drivers/misc/ti-st/st_core.c                                    |    7 
 drivers/mmc/core/mmc.c                                          |    2 
 drivers/net/can/dev/dev.c                                       |   10 
 drivers/net/can/dev/skb.c                                       |    6 
 drivers/net/ethernet/broadcom/tg3.c                             |    3 
 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c     |    2 
 drivers/net/ethernet/google/gve/gve_main.c                      |    2 
 drivers/net/ethernet/intel/i40e/i40e_main.c                     |   10 
 drivers/net/ethernet/intel/iavf/iavf.h                          |   16 
 drivers/net/ethernet/intel/iavf/iavf_main.c                     |   43 
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c                 |   75 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c         |    5 
 drivers/net/ethernet/marvell/octeontx2/nic/Makefile             |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c        |   64 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h        |   42 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c            |  131 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_struct.h        |   34 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c          |   66 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h          |    3 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c            |    9 
 drivers/net/ethernet/marvell/octeontx2/nic/qos.h                |   19 
 drivers/net/ethernet/marvell/octeontx2/nic/qos_sq.c             |  282 ++
 drivers/net/ethernet/mediatek/mtk_wed_regs.h                    |    4 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c |    2 
 drivers/net/ethernet/realtek/r8169_main.c                       |   15 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h                  |    2 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c             |   14 
 drivers/net/ethernet/toshiba/spider_net.c                       |    2 
 drivers/net/ipvlan/ipvlan_core.c                                |    8 
 drivers/net/ipvlan/ipvlan_main.c                                |    1 
 drivers/net/macsec.c                                            |    6 
 drivers/net/wireless/ath/ath11k/mac.c                           |    8 
 drivers/net/wireless/ath/ath11k/pci.c                           |   24 
 drivers/net/wireless/ath/dfs_pattern_detector.c                 |    2 
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c                     |    5 
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h             |    1 
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h                |    5 
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c                    |   51 
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h                  |   11 
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                     |    4 
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h              |    1 
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c                    |   18 
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c            |    2 
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c                 |    2 
 drivers/net/wireless/intel/iwlwifi/queue/tx.c                   |    9 
 drivers/net/wireless/intel/iwlwifi/queue/tx.h                   |    2 
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c              |   76 
 drivers/net/wireless/mediatek/mt76/mt7603/core.c                |    2 
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c                 |   52 
 drivers/net/wireless/mediatek/mt76/mt7603/regs.h                |    5 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                 |    4 
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c             |    2 
 drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c       |    2 
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c             |    2 
 drivers/net/wireless/realtek/rtw88/debug.c                      |    4 
 drivers/net/wireless/silabs/wfx/data_tx.c                       |   71 
 drivers/nvdimm/of_pmem.c                                        |    8 
 drivers/nvdimm/region_devs.c                                    |    8 
 drivers/nvme/host/ioctl.c                                       |    7 
 drivers/pci/controller/vmd.c                                    |    3 
 drivers/pcmcia/cs.c                                             |    1 
 drivers/pcmcia/ds.c                                             |   14 
 drivers/perf/arm-cmn.c                                          |  161 -
 drivers/perf/hisilicon/hisi_pcie_pmu.c                          |    7 
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c                     |    4 
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c                   |    4 
 drivers/perf/hisilicon/hns3_pmu.c                               |    8 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                         |    3 
 drivers/platform/x86/wmi.c                                      |   36 
 drivers/pwm/pwm-brcmstb.c                                       |    4 
 drivers/pwm/pwm-sti.c                                           |   29 
 drivers/regulator/mt6358-regulator.c                            |   14 
 drivers/rtc/rtc-pcf85363.c                                      |    2 
 drivers/scsi/ibmvscsi/ibmvfc.c                                  |    3 
 drivers/soc/qcom/llcc-qcom.c                                    |    3 
 drivers/spi/Kconfig                                             |    1 
 drivers/spi/spi-nxp-fspi.c                                      |    2 
 drivers/spi/spi-tegra20-slink.c                                 |    2 
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c                  |   24 
 drivers/thermal/thermal_core.c                                  |    6 
 drivers/tty/tty_jobctrl.c                                       |   17 
 drivers/ufs/core/ufshcd.c                                       |    2 
 drivers/usb/chipidea/host.c                                     |   48 
 drivers/usb/dwc2/hcd.c                                          |    2 
 drivers/usb/host/xhci-pci.c                                     |    2 
 drivers/usb/host/xhci-plat.c                                    |   23 
 drivers/usb/usbip/stub_dev.c                                    |    9 
 drivers/vhost/vsock.c                                           |  214 -
 drivers/video/fbdev/fsl-diu-fb.c                                |    2 
 drivers/video/fbdev/imsttfb.c                                   |   33 
 drivers/virt/coco/sev-guest/sev-guest.c                         |  113 
 drivers/watchdog/ixp4xx_wdt.c                                   |   28 
 drivers/xen/xen-pciback/conf_space.c                            |   19 
 drivers/xen/xen-pciback/conf_space_capability.c                 |    8 
 drivers/xen/xen-pciback/conf_space_header.c                     |   21 
 drivers/xen/xenbus/xenbus_probe.c                               |    2 
 fs/btrfs/ioctl.c                                                |   10 
 fs/ext4/extents.c                                               |   10 
 fs/f2fs/data.c                                                  |  106 
 fs/f2fs/file.c                                                  |    1 
 fs/f2fs/super.c                                                 |   33 
 fs/fs-writeback.c                                               |   41 
 fs/pstore/platform.c                                            |    9 
 include/kunit/visibility.h                                      |   33 
 include/linux/clk-provider.h                                    |   15 
 include/linux/cpuhotplug.h                                      |    1 
 include/linux/hisi_acc_qm.h                                     |   15 
 include/linux/hw_random.h                                       |    1 
 include/linux/idr.h                                             |    6 
 include/linux/mfd/core.h                                        |    2 
 include/linux/netdevice.h                                       |    1 
 include/linux/numa.h                                            |    7 
 include/linux/pagemap.h                                         |    2 
 include/linux/string.h                                          |    7 
 include/linux/verification.h                                    |    1 
 include/linux/virtio_vsock.h                                    |  129 
 include/net/cfg80211.h                                          |   21 
 include/net/flow.h                                              |    2 
 include/net/netfilter/nf_nat_redirect.h                         |    3 
 include/net/tcp.h                                               |    2 
 include/uapi/linux/psp-sev.h                                    |    7 
 include/uapi/linux/sev-guest.h                                  |   18 
 io_uring/kbuf.c                                                 |   11 
 io_uring/net.c                                                  |   24 
 kernel/bpf/hashtab.c                                            |    7 
 kernel/bpf/helpers.c                                            |   25 
 kernel/futex/core.c                                             |   12 
 kernel/irq/matrix.c                                             |    6 
 kernel/livepatch/core.c                                         |    2 
 kernel/module/decompress.c                                      |    4 
 kernel/padata.c                                                 |    6 
 kernel/sched/core.c                                             |   10 
 kernel/sched/deadline.c                                         |    2 
 kernel/sched/fair.c                                             |   35 
 kernel/sched/rt.c                                               |    4 
 kernel/trace/trace_kprobe.c                                     |    2 
 lib/kunit/executor.c                                            |    4 
 mm/filemap.c                                                    |   54 
 mm/readahead.c                                                  |    3 
 net/9p/client.c                                                 |    6 
 net/bluetooth/hci_sync.c                                        |    4 
 net/core/page_pool.c                                            |    6 
 net/core/skbuff.c                                               |    3 
 net/dccp/ipv4.c                                                 |    6 
 net/dccp/ipv6.c                                                 |    6 
 net/hsr/hsr_forward.c                                           |    4 
 net/ipv4/syncookies.c                                           |   20 
 net/ipv4/tcp_input.c                                            |    9 
 net/ipv4/tcp_metrics.c                                          |   15 
 net/ipv4/udp.c                                                  |    6 
 net/ipv6/ip6_output.c                                           |    8 
 net/ipv6/syncookies.c                                           |    7 
 net/llc/llc_input.c                                             |   10 
 net/llc/llc_s_ac.c                                              |    3 
 net/llc/llc_station.c                                           |    3 
 net/mac80211/ieee80211_i.h                                      |   18 
 net/mac80211/iface.c                                            |    2 
 net/mac80211/main.c                                             |   25 
 net/mac80211/offchannel.c                                       |   36 
 net/mac80211/scan.c                                             |   36 
 net/mac80211/sta_info.c                                         |    2 
 net/mac80211/util.c                                             |   11 
 net/netfilter/nf_nat_redirect.c                                 |   98 
 net/netfilter/nf_tables_api.c                                   |    4 
 net/netfilter/nft_redir.c                                       |   84 
 net/netfilter/xt_REDIRECT.c                                     |   10 
 net/netfilter/xt_recent.c                                       |    2 
 net/smc/af_smc.c                                                |    4 
 net/smc/smc.h                                                   |    5 
 net/smc/smc_cdc.c                                               |   11 
 net/smc/smc_close.c                                             |    5 
 net/tipc/link.c                                                 |    4 
 net/tipc/netlink.c                                              |    4 
 net/tls/tls.h                                                   |    2 
 net/tls/tls_sw.c                                                |   42 
 net/vmw_vsock/virtio_transport.c                                |  149 -
 net/vmw_vsock/virtio_transport_common.c                         |  449 +--
 net/vmw_vsock/vsock_loopback.c                                  |   59 
 net/wireless/core.c                                             |   34 
 net/wireless/core.h                                             |    3 
 net/wireless/sysfs.c                                            |    4 
 scripts/mod/file2alias.c                                        |   14 
 security/apparmor/Kconfig                                       |    4 
 security/apparmor/Makefile                                      |    3 
 security/apparmor/include/policy_unpack.h                       |   50 
 security/apparmor/policy.c                                      |    1 
 security/apparmor/policy_unpack.c                               |  241 -
 security/apparmor/policy_unpack_test.c                          |   69 
 sound/pci/hda/cs35l41_hda.c                                     |    5 
 sound/soc/codecs/cs35l41.c                                      |   14 
 sound/soc/codecs/hdmi-codec.c                                   |   27 
 sound/soc/fsl/fsl_easrc.c                                       |    8 
 sound/soc/fsl/mpc5200_dma.c                                     |    3 
 sound/soc/intel/skylake/skl-sst-utils.c                         |    1 
 sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c        |    4 
 sound/soc/soc-dapm.c                                            |    2 
 sound/soc/sof/core.c                                            |    6 
 sound/soc/ti/ams-delta.c                                        |    4 
 tools/iio/iio_generic_buffer.c                                  |   13 
 tools/objtool/objtool.c                                         |    4 
 tools/perf/Documentation/perf-kwork.txt                         |    2 
 tools/perf/builtin-kwork.c                                      |   13 
 tools/perf/builtin-stat.c                                       |    2 
 tools/perf/util/bpf_off_cpu.c                                   |    5 
 tools/perf/util/hist.c                                          |   10 
 tools/perf/util/machine.c                                       |   22 
 tools/testing/selftests/bpf/prog_tests/tailcalls.c              |   32 
 tools/testing/selftests/net/pmtu.sh                             |    2 
 tools/testing/selftests/netfilter/Makefile                      |    5 
 tools/testing/selftests/netfilter/conntrack_sctp_collision.sh   |   89 
 tools/testing/selftests/netfilter/sctp_collision.c              |   99 
 tools/testing/selftests/netfilter/xt_string.sh                  |  128 
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c               |    2 
 tools/testing/selftests/pidfd/pidfd_test.c                      |   12 
 tools/testing/selftests/resctrl/resctrl_tests.c                 |    5 
 407 files changed, 7410 insertions(+), 4528 deletions(-)

Aananth V (1):
      tcp: call tcp_try_undo_recovery when an RTOd TFO SYNACK is ACKed

Aaron Plattner (1):
      objtool: Propagate early errors

Abel Vesa (1):
      clk: imx: Select MXC_CLK for CLK_IMX8QXP

Adam Dunlap (1):
      x86/sev-es: Allow copy_from_kernel_nofault() in earlier boot

Adam Ford (3):
      ARM: dts: am3517-evm: Fix LED3/4 pinmux
      arm64: dts: imx8mm: Add sound-dai-cells to micfil node
      arm64: dts: imx8mn: Add sound-dai-cells to micfil node

Aditya Kumar Singh (1):
      wifi: ath11k: fix Tx power value during active CAC

Alison Schofield (2):
      x86/numa: Introduce numa_fill_memblks()
      ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window

Amit Kumar Mahapatra (1):
      spi: spi-zynq-qspi: add spi-mem to driver kconfig dependencies

Andre Przywara (1):
      clocksource/drivers/arm_arch_timer: limit XGene-1 workaround

Andrea Righi (1):
      module/decompress: use vmalloc() for gzip decompression workspace

Andrii Staikov (1):
      i40e: fix potential memory leaks in i40e_remove()

Andy Shevchenko (2):
      ACPI: property: Allow _DSD buffer data only for byte accessors
      HID: cp2112: Make irq_chip immutable

AngeloGioacchino Del Regno (1):
      drm: mediatek: mtk_dsi: Fix NO_EOT_PACKET settings/handling

Anuj Gupta (1):
      nvme: fix error-handling for io_uring nvme-passthrough

Anup Patel (1):
      RISC-V: Don't fail in riscv_of_parent_hartid() for disabled HARTs

Armin Wolf (4):
      platform/x86: wmi: Fix probe failure when failing to register WMI devices
      platform/x86: wmi: Fix opening of char device
      hwmon: (sch5627) Use bit macros when accessing the control register
      hwmon: (sch5627) Disallow write access if virtual registers are locked

Arnd Bergmann (1):
      fbdev: fsl-diu-fb: mark wr_reg_wa() static

Arseniy Krasnov (4):
      virtio/vsock: don't use skbuff state to account credit
      virtio/vsock: remove redundant 'skb_pull()' call
      virtio/vsock: don't drop skbuff on copy failure
      virtio/vsock: fix header length on skb merging

Baochen Qiang (1):
      wifi: ath11k: fix boot failure with one MSI vector

Basavaraj Natikar (1):
      xhci: Loosen RPM as default policy to cover for AMD xHC 1.1

Bastien Nocera (2):
      Revert "HID: logitech-hidpp: add a module parameter to keep firmware gestures"
      HID: logitech-hidpp: Remove HIDPP_QUIRK_NO_HIDINPUT quirk

Ben Wolsieffer (2):
      futex: Don't include process MM in futex key on no-MMU
      regmap: prevent noinc writes from clobbering cache

Benjamin Gray (1):
      powerpc/xive: Fix endian conversion size

Biju Das (1):
      pinctrl: renesas: rzg2l: Make reverse order of enable() for disable()

Bobby Eshleman (2):
      virtio/vsock: replace virtio_vsock_pkt with sk_buff
      virtio/vsock: fix leaks due to missing skb owner

Brett Creeley (1):
      iavf: Fix promiscuous mode configuration flow messages

Cezary Rojewski (1):
      ASoC: Intel: Skylake: Fix mem leak when parsing UUIDs fails

Chao Yu (4):
      f2fs: compress: fix deadloop in f2fs_write_cache_pages()
      f2fs: compress: fix to avoid use-after-free on dic
      f2fs: compress: fix to avoid redundant compress extension
      f2fs: fix to initialize map.m_pblk in f2fs_precache_extents()

Chen Ni (1):
      libnvdimm/of_pmem: Use devm_kstrdup instead of kstrdup and check its return value

Chen Yu (1):
      genirq/matrix: Exclude managed interrupts in irq_matrix_allocated()

Chen-Yu Tsai (2):
      regulator: mt6358: Fail probe on unknown chip ID
      dt-bindings: mfd: mt6397: Split out compatible for MediaTek MT6366 PMIC

Chengchang Tang (3):
      RDMA/hns: Fix printing level of asynchronous events
      RDMA/hns: Fix uninitialized ucmd in hns_roce_create_qp_common()
      RDMA/hns: Fix signed-unsigned mixed comparisons

Chengming Zhou (1):
      sched/fair: Fix cfs_rq_is_decayed() on !SMP

Chris Packham (1):
      ARM64: dts: marvell: cn9310: Use appropriate label for spi1 pins

Christophe JAILLET (8):
      wifi: ath: dfs_pattern_detector: Fix a memory initialization issue
      ACPI: sysfs: Fix create_pnp_modalias() and create_of_modalias()
      regmap: debugfs: Fix a erroneous check after snprintf()
      drm/rockchip: cdn-dp: Fix some error handling paths in cdn_dp_probe()
      crypto: hisilicon/hpre - Fix a erroneous check after snprintf()
      leds: trigger: ledtrig-cpu:: Fix 'output may be truncated' issue for 'cpu'
      dmaengine: pxa_dma: Remove an erroneous BUG_ON() in pxad_free_desc()
      media: i2c: max9286: Fix some redundant of_node_put() calls

Christophe Leroy (2):
      powerpc: Only define __parse_fpscr() when required
      powerpc/40x: Remove stale PTE_ATOMIC_UPDATES macro

Claudiu Beznea (5):
      clk: renesas: rzg2l: Wait for status bit of SD mux before continuing
      clk: renesas: rzg2l: Lock around writes to mux register
      clk: renesas: rzg2l: Trust value returned by hardware
      clk: renesas: rzg2l: Use FIELD_GET() for PLL register fields
      clk: renesas: rzg2l: Fix computation formula

Cristian Ciocaltea (4):
      ASoC: cs35l41: Verify PM runtime resume errors in IRQ handler
      ASoC: cs35l41: Undo runtime PM changes at driver exit time
      ALSA: hda: cs35l41: Fix unbalanced pm_runtime_get()
      ALSA: hda: cs35l41: Undo runtime PM changes at driver exit time

D. Wythe (3):
      net/smc: fix dangling sock under state SMC_APPFINCLOSEWAIT
      net/smc: allow cdc msg send rather than drop it with NULL sndbuf_desc
      net/smc: put sk reference if close work was canceled

Dan Carpenter (8):
      thermal: core: prevent potential string overflow
      clk: keystone: pll: fix a couple NULL vs IS_ERR() checks
      clk: ti: fix double free in of_ti_divider_clk_setup()
      drm/rockchip: Fix type promotion bug in rockchip_gem_iommu_map()
      dmaengine: ti: edma: handle irq_of_parse_and_map() errors
      Input: synaptics-rmi4 - fix use after free in rmi_unregister_function()
      hsr: Prevent use after free in prp_create_tagged_frame()
      fbdev: imsttfb: fix a resource leak in probe

Dan Williams (2):
      cxl/mem: Fix shutdown order
      virt: sevguest: Fix passing a stack buffer as a scatterlist target

Daniel Mentz (1):
      scsi: ufs: core: Leave space for '\0' in utf8 desc string

Danila Tikhonov (1):
      clk: qcom: gcc-sm8150: Fix gcc_sdcc2_apps_clk_src

Danny Kaehn (2):
      hid: cp2112: Fix duplicate workqueue initialization
      hid: cp2112: Fix IRQ shutdown stopping polling for all IRQs on chip

Dario Binacchi (1):
      clk: ti: change ti_clk_register[_omap_hw]() API

David Heidelberg (1):
      arm64: dts: qcom: sdm845: cheza doesn't support LMh node

David Howells (1):
      iov_iter, x86: Be consistent about the __user tag on copy_mc_to_user()

Devi Priya (1):
      clk: qcom: clk-rcg2: Fix clock rate overflow for high parent frequencies

Dhruva Gole (1):
      firmware: ti_sci: Mark driver as non removable

Dinghao Liu (2):
      mfd: dln2: Fix double put in dln2_probe
      i3c: Fix potential refcount leak in i3c_master_register_new_i3c_devs

Dionna Glaze (1):
      x86/sev: Change snp_guest_issue_request()'s fw_err argument

Dirk Behme (1):
      clk: renesas: rcar-gen3: Extend SDnH divider table

Dmitry Antipov (1):
      wifi: rtlwifi: fix EDCA limit set by BT coexistence

Dmitry Baryshkov (9):
      drm/bridge: lt9611uxc: fix the race in the error path
      drm/msm/dsi: use msm_gem_kernel_put to free TX buffer
      drm/msm/dsi: free TX buffer in unbind
      arm64: dts: qcom: sc7280: link usb3_phy_wrapper_gcc_usb30_pipe_clk
      arm64: dts: qcom: sm8150: add ref clock to PCIe PHYs
      arm64: dts: qcom: sm8350: fix pinctrl for UART18
      arm64: dts: qcom: sdm845-mtp: fix WiFi configuration
      interconnect: move ignore_list out of of_count_icc_providers()
      interconnect: qcom: sm8150: Drop IP0 interconnects

Dominique Martinet (1):
      Revert "mmc: core: Capture correct oemid-bits for eMMC cards"

Dragos Bogdan (1):
      hwmon: (axi-fan-control) Fix possible NULL pointer dereference

Emmanuel Grumbach (1):
      wifi: iwlwifi: honor the enable_ini value

Eric Dumazet (9):
      udp: add missing WRITE_ONCE() around up->encap_rcv
      tcp_metrics: add missing barriers on delete
      tcp_metrics: properly set tp->snd_ssthresh in tcp_init_metrics()
      tcp_metrics: do not create an entry from tcp_init_metrics()
      chtls: fix tp->rcv_tstamp initialization
      tcp: fix cookie_init_timestamp() overflows
      net: add DEV_STATS_READ() helper
      ipvlan: properly track tx_errors
      inet: shrink struct flowi_common

Erik Kurzinger (1):
      drm/syncobj: fix DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE

Eugen Hristev (1):
      ASoC: mediatek: mt8186_mt6366_rt1019_rt5682s: trivial: fix error messages

Fabien Parent (1):
      dt-bindings: mfd: mt6397: Add binding for MT6357

Fabio Estevam (1):
      arm64: dts: imx8qm-ss-img: Fix jpegenc compatible entry

Fei Shao (1):
      media: mtk-jpegenc: Fix bug in JPEG encode quality selection

Felipe Negrelli Wolter (1):
      wifi: wfx: fix case where rates are out of order

Felix Fietkau (3):
      wifi: mt76: mt7603: rework/fix rx pse hang check
      wifi: mt76: mt7603: improve watchdog reset reliablity
      wifi: mt76: mt7603: improve stuck beacon handling

Fenghua Yu (1):
      dmaengine: idxd: Register dsa_bus_type before registering idxd sub-drivers

Filipe Manana (1):
      btrfs: use u64 for buffer sizes in the tree search ioctls

Filippo Storniolo (1):
      vsock/virtio: remove socket from connected/bound list on shutdown

Florian Fainelli (1):
      pwm: brcmstb: Utilize appropriate clock APIs in suspend/resume

Florian Westphal (1):
      netfilter: nat: fix ipv6 nat redirect with mapped and scoped addresses

Francesco Dolcini (1):
      drm/bridge: tc358768: remove unused variable

Furong Xu (1):
      net: stmmac: xgmac: Enable support for multiple Flexible PPS outputs

Gabriel Krisman Bertazi (2):
      io_uring/kbuf: Fix check of BID wrapping in provided buffers
      io_uring/kbuf: Allow the full buffer id space for provided buffers

Gaurav Jain (2):
      crypto: caam/qi2 - fix Chacha20 + Poly1305 self test failure
      crypto: caam/jr - fix Chacha20 + Poly1305 self test failure

Gaurav Kohli (1):
      arm64: dts: qcom: msm8916: Fix iommu local address range

Geert Uytterhoeven (2):
      ARM: dts: renesas: blanche: Fix typo in GP_11_2 pin name
      sh: bios: Revive earlyprintk support

Geetha sowjanya (1):
      octeontx2-pf: Free pending and dropped SQEs

George Kennedy (1):
      IB/mlx5: Fix init stage error handling to avoid double free of same QP and UAF

George Shuklin (1):
      tg3: power down device only on SYSTEM_POWER_OFF

Georgia Garcia (1):
      apparmor: fix invalid reference on profile->disconnected

Giovanni Cabiddu (9):
      crypto: qat - ignore subsequent state up commands
      crypto: qat - relocate bufferlist logic
      crypto: qat - rename bufferlist functions
      crypto: qat - change bufferlist logic interface
      crypto: qat - generalize crypto request buffers
      crypto: qat - extend buffer list interface
      crypto: qat - fix unregistration of crypto algorithms
      crypto: qat - increase size of buffers
      crypto: qat - fix deadlock in backlog processing

Gou Hao (1):
      ext4: move 'ix' sanity check to corrent position

Greg Kroah-Hartman (1):
      Linux 6.1.63

Gregory Greenman (1):
      wifi: iwlwifi: call napi_synchronize() before freeing rx/tx queues

Guenter Roeck (2):
      Revert "hwmon: (sch56xx-common) Add DMI override table"
      Revert "hwmon: (sch56xx-common) Add automatic module loading on supported devices"

Guoniu.zhou (1):
      media: ov5640: fix vblank unchange issue when work at dvp mode

Gustavo A. R. Silva (6):
      gve: Use size_add() in call to struct_size()
      mlxsw: Use size_mul() in call to struct_size()
      tls: Use size_add() in call to struct_size()
      tipc: Use size_add() in calls to struct_size()
      net: spider_net: Use size_add() in call to struct_size()
      RDMA/core: Use size_{add,sub,mul}() in calls to struct_size()

Han Xu (1):
      spi: nxp-fspi: use the correct ioremap function

Hangbin Liu (1):
      selftests: pmtu.sh: fix result checking

Hangyu Hua (1):
      9p/net: fix possible memory leak in p9_check_errors()

Hans Verkuil (1):
      media: dvb-usb-v2: af9035: fix missing unlock

Hans de Goede (4):
      HID: logitech-hidpp: Don't restart IO, instead defer hid_connect() only
      HID: logitech-hidpp: Revert "Don't restart communication if not necessary"
      HID: logitech-hidpp: Move get_wireless_feature_index() check to hidpp_connect_event()
      mfd: arizona-spi: Set pdata.hpdet_channel for ACPI enumerated devs

Hao Chen (1):
      drivers/perf: hisi: use cpuhp_state_remove_instance_nocalls() for hisi_hns3_pmu uninit process

Haren Myneni (1):
      powerpc/vas: Limit open window failure messages in log bufffer

Hariprasad Kelam (1):
      octeontx2-pf: Rename tot_tx_queues to non_qos_queues

Harshit Mogalapalli (1):
      hte: tegra: Fix missing error code in tegra_hte_test_probe()

Heiner Kallweit (2):
      r8169: fix rare issue with broken rx after link-down on RTL8125
      r8169: respect userspace disabling IFF_MULTICAST

Helge Deller (1):
      fbdev: imsttfb: Fix error path of imsttfb_probe()

Herbert Xu (2):
      tls: Only use data field in crypto completion function
      KEYS: Include linux/errno.h in linux/verification.h

Herve Codina (1):
      mfd: core: Ensure disabled devices are skipped without aborting

Hou Tao (1):
      bpf: Check map->usercnt after timer->timer is assigned

Ian Rogers (3):
      perf stat: Fix aggr mode initialization
      perf machine: Avoid out of bounds LBR memory read
      perf hist: Add missing puts to hist__account_cycles

Ilpo Järvinen (2):
      selftests/resctrl: Ensure the benchmark commands fits to its array
      PCI: vmd: Correct PCI Header Type Register's multi-function check

Ivaylo Dimitrov (1):
      drivers/clocksource/timer-ti-dm: Don't call clk_get_rate() in stop function

Jacopo Mondi (1):
      media: ov5640: Drop dead code using frame_interval

Jai Luthra (2):
      drm: bridge: it66121: Fix invalid connector dereference
      arm64: dts: ti: k3-am62a7-sk: Drop i2c-1 to 100Khz

Jason-JH.Lin (2):
      drm/mediatek: Fix iommu fault by swapping FBs after updating plane state
      drm/mediatek: Fix iommu fault during crtc enabling

Javier Carrasco (1):
      rtc: pcf85363: fix wrong mask/val parameters in regmap_update_bits call

Jens Axboe (1):
      io_uring/net: ensure socket is marked connected on connect retry

Jeremy Sowden (1):
      netfilter: nft_redir: use `struct nf_nat_range2` throughout and deduplicate eval call-backs

Jernej Skrabec (1):
      media: cedrus: Fix clock/reset sequence

Jerome Brunet (2):
      ASoC: hdmi-codec: register hpd callback on component probe
      ASoC: dapm: fix clock get name

Jia-Ju Bai (1):
      usb: dwc2: fix possible NULL pointer dereference caused by driver concurrency

Jian Shen (1):
      net: page_pool: add missing free_percpu when page_pool_init fail

Jiasheng Jiang (9):
      pstore/platform: Add check for kstrdup
      clk: mediatek: clk-mt6765: Add check for mtk_alloc_clk_data
      clk: mediatek: clk-mt6779: Add check for mtk_alloc_clk_data
      clk: mediatek: clk-mt6797: Add check for mtk_alloc_clk_data
      clk: mediatek: clk-mt7629-eth: Add check for mtk_alloc_clk_data
      clk: mediatek: clk-mt7629: Add check for mtk_alloc_clk_data
      clk: mediatek: clk-mt2701: Add check for mtk_alloc_clk_data
      media: vidtv: psi: Add check for kstrdup
      media: vidtv: mux: Add check and kfree for kstrdup

Jingbo Xu (1):
      writeback, cgroup: switch inodes with dirty timestamps to release dying cgwbs

Jinjie Ruan (4):
      wifi: rtw88: debug: Fix the NULL vs IS_ERR() bug for debugfs_create_file()
      kunit: Fix missed memory release in kunit_free_suite_set()
      iio: frequency: adf4350: Use device managed functions and fix power down issue.
      misc: st_core: Do not call kfree_skb() under spin_lock_irqsave()

Johannes Berg (8):
      wifi: cfg80211: add flush functions for wiphy work
      wifi: mac80211: move radar detect work to wiphy work
      wifi: mac80211: move scan work to wiphy work
      wifi: mac80211: move offchannel works to wiphy work
      wifi: mac80211: move sched-scan stop work to wiphy work
      wifi: mac80211: fix # of MSDU in A-MSDU calculation
      wifi: iwlwifi: pcie: synchronize IRQs before NAPI
      wifi: cfg80211: fix kernel-doc for wiphy_delayed_work_flush()

Johnny Liu (1):
      gpu: host1x: Correct allocated size for contexts

Jonas Blixt (1):
      USB: usbip: fix stub_dev hub disconnect

Jonas Gorski (1):
      hwrng: geode - fix accessing registers

Jonas Karlman (4):
      drm/rockchip: vop: Fix reset of state in duplicate state crtc funcs
      drm/rockchip: vop: Fix call to crtc reset helper
      drm/rockchip: vop2: Don't crash for invalid duplicate_state
      drm/rockchip: vop2: Add missing call to crtc reset helper

Jonathan Neuschäfer (1):
      clk: npcm7xx: Fix incorrect kfree

Josh Poimboeuf (1):
      x86/srso: Fix SBPB enablement for (possible) future fixed HW

Juergen Gross (1):
      xenbus: fix error exit in xenbus_init()

Juhee Kang (1):
      r8169: use tp_to_dev instead of open code

Junhao He (1):
      perf: hisi: Fix use-after-free when register pmu fails

Kai Ye (3):
      crypto: hisilicon/qm - delete redundant null assignment operations
      crypto: hisilicon/qm - modify the process of regs dfx
      crypto: hisilicon/qm - split a debugfs.c from qm

Katya Orlova (1):
      media: s3c-camif: Avoid inappropriate kfree()

Kees Cook (1):
      string: Adjust strtomem() logic to allow for smaller sources

Konrad Dybcio (17):
      clk: qcom: gcc-msm8996: Remove RPM bus clocks
      clk: qcom: mmcc-msm8998: Don't check halt bit on some branch clks
      clk: qcom: mmcc-msm8998: Fix the SMMU GDSC
      arm64: dts: qcom: sc7280: Add missing LMH interrupts
      interconnect: qcom: sc7180: Retire DEFINE_QBCM
      interconnect: qcom: sc7180: Set ACV enable_mask
      interconnect: qcom: sc7280: Set ACV enable_mask
      interconnect: qcom: sc8180x: Set ACV enable_mask
      interconnect: qcom: sc8280xp: Set ACV enable_mask
      interconnect: qcom: sdm845: Retire DEFINE_QBCM
      interconnect: qcom: sdm845: Set ACV enable_mask
      interconnect: qcom: sm6350: Retire DEFINE_QBCM
      interconnect: qcom: sm6350: Set ACV enable_mask
      interconnect: qcom: sm8150: Retire DEFINE_QBCM
      interconnect: qcom: sm8150: Set ACV enable_mask
      interconnect: qcom: sm8350: Retire DEFINE_QBCM
      interconnect: qcom: sm8350: Set ACV enable_mask

Konstantin Meskhidze (1):
      drm/radeon: possible buffer overflow

Krzysztof Kozlowski (2):
      arm64: dts: qcom: msm8992-libra: drop duplicated reserved memory
      ARM: dts: qcom: mdm9615: populate vsdcc fixed regulator

Kuninori Morimoto (2):
      ASoC: fsl: mpc5200_dma.c: Fix warning of Function parameter or member not described
      ASoC: ams-delta.c: use component after check

Kuniyuki Iwashima (2):
      dccp: Call security_inet_conn_request() after setting IPv4 addresses.
      dccp/tcp: Call security_inet_conn_request() after setting IPv6 addresses.

Kursad Oney (1):
      ARM: 9321/1: memset: cast the constant byte to unsigned char

Leon Hwang (1):
      selftests/bpf: Correct map_fd to data_fd in tailcalls

Leon Romanovsky (1):
      RDMA/hfi1: Workaround truncation compilation error

Li Lingfeng (1):
      nbd: fix uaf in nbd_open

Linus Walleij (1):
      watchdog: ixp4xx: Make sure restart always works

Longfang Liu (1):
      crypto: hisilicon/qm - fix PF queue parameter issue

Lorenzo Bianconi (1):
      net: ethernet: mtk_wed: fix EXT_INT_STATUS_RX_FBUF definitions for MT7986 SoC

Luoyouming (2):
      RDMA/hns: Add check for SL
      RDMA/hns: The UD mode can only be configured with DCQCN

Maarten Lankhorst (1):
      ASoC: SOF: core: Ensure sof_ops_free() is still called when probe never ran.

Maciej Wieczor-Retman (1):
      selftests/pidfd: Fix ksft print formats

Maciej Żenczykowski (1):
      netfilter: xt_recent: fix (increase) ipv6 literal buffer length

Marc Kleine-Budde (3):
      can: dev: can_restart(): don't crash kernel if carrier is OK
      can: dev: can_restart(): fix race condition between controller restart and netif_carrier_on()
      can: dev: can_put_echo_skb(): don't crash kernel if can_priv::echo_skb is accessed out of bounds

Marcel Ziswiler (1):
      Bluetooth: hci_sync: Fix Opcode prints in bt_dev_dbg/err

Marek Behún (2):
      leds: turris-omnia: Drop unnecessary mutex locking
      leds: turris-omnia: Do not use SMBUS calls

Marek Marczykowski-Górecki (1):
      xen-pciback: Consider INTx disabled when MSI/MSI-X is enabled

Marek Szyprowski (1):
      media: cec: meson: always include meson sub-directory in Makefile

Marek Vasut (2):
      media: hantro: Check whether reset op is defined before use
      media: verisilicon: Do not enable G2 postproc downscale if source is narrower than destination

Mark Rutland (1):
      arm64/arm: xen: enlighten: Fix KPTI checks

Masahiro Yamada (2):
      modpost: fix tee MODULE_DEVICE_TABLE built on big-endian host
      modpost: fix ishtp MODULE_DEVICE_TABLE built on big-endian host

Matti Vaittinen (1):
      tools: iio: iio_generic_buffer ensure alignment

MeiChia Chiu (1):
      wifi: mt76: mt7915: fix beamforming availability check

Michał Mirosław (3):
      mfd: core: Un-constify mfd_cell.of_reg
      usb: chipidea: Fix DMA overwrite for Tegra
      usb: chipidea: Simplify Tegra DMA alignment code

Michel Dänzer (3):
      drm/amd/display: Check all enabled planes in dm_check_crtc_cursor
      drm/amd/display: Refactor dm_get_plane_scale helper
      drm/amd/display: Bail from dm_check_crtc_cursor if no relevant change

Ming Qian (1):
      media: amphion: handle firmware debug message

Miri Korenblit (1):
      wifi: iwlwifi: empty overflow queue during flush

Namhyung Kim (1):
      perf record: Fix BTF type checks in the off-cpu profiling

NeilBrown (1):
      Fix termination state for idr_for_each_entry_ul()

Ondrej Zary (1):
      ACPI: video: Add acpi_backlight=vendor quirk for Toshiba Portégé R100

Patrick Thompson (1):
      net: r8169: Disable multicast filter for RTL8168H and RTL8107E

Patrisious Haddad (1):
      IB/mlx5: Fix rdma counter binding for RAW QP

Peng Fan (1):
      clk: imx: imx8mq: correct error handling path

Peter Gonda (1):
      crypto: ccp - Name -1 return value as SEV_RET_NO_FW_CALL

Peter Zijlstra (1):
      sched: Fix stop_one_cpu_nowait() vs hotplug

Phil Sutter (2):
      netfilter: nf_tables: Drop pointless memset when dumping rules
      net: skb_find_text: Ignore patterns extending past 'to'

Pratyush Yadav (1):
      media: cadence: csi2rx: Unregister v4l2 async notifier

Qais Yousef (2):
      sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is 0
      sched/uclamp: Ignore (util == 0) optimization in feec() when p_util_max = 0

Rae Moar (2):
      kunit: add macro to allow conditionally exposing static symbols to tests
      apparmor: test: make static symbols visible during kunit testing

Randy Dunlap (1):
      clk: linux/clk-provider.h: fix kernel-doc warnings and typos

Ratheesh Kannoth (2):
      octeontx2-pf: Fix error codes
      octeontx2-pf: Fix holes in error code

Reuben Hawkins (1):
      vfs: fix readahead(2) on block devices

Robert Chiras (1):
      clk: imx: imx8qxp: Fix elcdif_pll clock

Robin Murphy (2):
      perf/arm-cmn: Revamp model detection
      perf/arm-cmn: Fix DTC domain detection

Roman Bacik (1):
      i2c: iproc: handle invalid slave state

Sascha Hauer (1):
      PM / devfreq: rockchip-dfi: Make pmu regmap mandatory

Sebastian Andrzej Siewior (1):
      powerpc/imc-pmu: Use the correct spinlock initializer.

Sergey Shtylyov (1):
      usb: host: xhci-plat: fix possible kernel oops while resuming

Shigeru Yoshida (2):
      tipc: Change nla_policy for bearer-related names to NLA_NUL_STRING
      virtio/vsock: Fix uninit-value in virtio_transport_recv_pkt()

Song Liu (1):
      bpf: Fix unnecessary -EBUSY from htab_lock_bucket

Stefan Eichenberger (1):
      drm/bridge: lt8912b: Add hot plug detection

Stefan Wahren (1):
      hwrng: bcm2835 - Fix hwrng throughput regression

Stefano Garzarella (1):
      vsock/loopback: use only sk_buff_head.lock to protect the packet queue

Stephan Gerhold (1):
      arm64: dts: qcom: apq8016-sbc: Add missing ADV7533 regulators

Subbaraya Sundeep (1):
      octeontx2-pf: qos send queues management

Sudeep Holla (3):
      firmware: arm_ffa: Assign the missing IDR allocation ID to the FFA device
      firmware: arm_ffa: Allow the FF-A drivers to use 32bit mode of messaging
      clk: scmi: Free scmi_clk allocated when the clocks with invalid info are skipped

Thierry Reding (1):
      arm64: tegra: Use correct interrupts for Tegra234 TKE

Tomas Glozar (1):
      nd_btt: Make BTT lanes preemptible

Tomi Valkeinen (12):
      drm/bridge: lt8912b: Fix bridge_detach
      drm/bridge: lt8912b: Fix crash on bridge detach
      drm/bridge: lt8912b: Manually disable HPD only if it was enabled
      drm/bridge: lt8912b: Add missing drm_bridge_attach call
      drm/bridge: tc358768: Fix use of uninitialized variable
      drm/bridge: tc358768: Fix bit updates
      drm/bridge: tc358768: Use struct videomode
      drm/bridge: tc358768: Print logical values, not raw register values
      drm/bridge: tc358768: Use dev for dbg prints, not priv->dev
      drm/bridge: tc358768: Rename dsibclk to hsbyteclk
      drm/bridge: tc358768: Clean up clock period code
      drm/bridge: tc358768: Fix tc358768_ns_to_cnt()

Tyrel Datwyler (1):
      scsi: ibmvfc: Fix erroneous use of rtas_busy_delay with hcall return code

Uwe Kleine-König (3):
      soc: qcom: llcc: Handle a second device without data corruption
      leds: pwm: Don't disable the PWM when the LED should be off
      pwm: sti: Reduce number of allocations and drop usage of chip_data

Varadarajan Narayanan (1):
      clk: qcom: config IPQ_APSS_6018 should depend on QCOM_SMEM

Vishal Moola (Oracle) (2):
      filemap: add filemap_get_folios_tag()
      f2fs: convert f2fs_write_cache_pages() to use filemap_get_folios_tag()

Wang Yufen (1):
      powerpc/pseries: fix potential memory leak in init_cpu_associativity()

WangJinchao (1):
      padata: Fix refcnt handling in padata_free_shell()

Willem de Bruijn (1):
      llc: verify mac len before reading mac header

Xiaogang Chen (1):
      drm/amdkfd: fix some race conditions in vram buffer alloc/free of svm code

Xiaolei Wang (1):
      media: ov5640: Fix a memory leak when ov5640_probe fails

Xin Long (1):
      selftests: netfilter: test for sctp collision processing in nf_conntrack

Yan Zhai (1):
      ipv6: avoid atomic fragment on GSO packets

Yang Jihong (3):
      perf kwork: Fix incorrect and missing free atom in work_push_atom()
      perf kwork: Add the supported subcommands to the document
      perf kwork: Set ordered_events to true in 'struct perf_tool'

Yang Yingliang (3):
      pcmcia: cs: fix possible hung task and memory leak pccardd()
      pcmcia: ds: fix refcount leak in pcmcia_device_add()
      pcmcia: ds: fix possible name leak in error path in pcmcia_device_add()

Yazen Ghannam (1):
      x86/amd_nb: Use Family 19h Models 60h-7Fh Function 4 IDs

Yi Yang (1):
      tty: tty_jobctrl: fix pid memleak in disassociate_ctty()

Yicong Yang (1):
      drivers/perf: hisi_pcie: Check the type first in pmu::event_init()

Yu Kuai (1):
      blk-core: use pr_warn_ratelimited() in bio_check_ro()

Yujie Liu (1):
      tracing/kprobes: Fix the order of argument descriptions

Yuntao Wang (1):
      x86/boot: Fix incorrect startup_gdt_descr.size

Zev Weiss (1):
      hwmon: (nct6775) Fix incorrect variable reuse in fan_div calculation

Zhang Rui (1):
      hwmon: (coretemp) Fix potentially truncated sysfs attribute name

Zhang Shurong (2):
      spi: tegra: Fix missing IRQ check in tegra_slink_probe()
      ASoC: fsl: Fix PM disable depth imbalance in fsl_easrc_probe

Zheng Wang (1):
      media: bttv: fix use after free error due to btv->timeout timer

Zheng Yejian (1):
      livepatch: Fix missing newline character in klp_resolve_symbols()

