Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BB27F115F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjKTLJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjKTLJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:09:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3CC1717;
        Mon, 20 Nov 2023 03:08:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C39EC433C9;
        Mon, 20 Nov 2023 11:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700478517;
        bh=29mXiHuMiw5yMGbQ/4sRvl3IEdERDxAsP0U8FE34FO0=;
        h=From:To:Cc:Subject:Date:From;
        b=E3YjQJNDCHjKnVDpzN9lXyIUDvVeakCjXShg1UYoEg6Y9td3WFO/KSwA12tNug0VZ
         df/QgnoHouf0c84osUOrn4vhQ5TTvzsAj8MhEcEmxFalO8umcgXyiG0YyI6mZLeK+9
         ZFL4ms3BvYpipoy+KxoNFx0bZIvAHIGktT2MkglE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.2
Date:   Mon, 20 Nov 2023 12:08:32 +0100
Message-ID: <2023112033-tavern-compost-ec76@gregkh>
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

I'm announcing the release of the 6.6.2 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-driver-qat                         |    2 
 Documentation/admin-guide/hw-vuln/srso.rst                         |   24 
 Documentation/devicetree/bindings/mfd/mt6397.txt                   |    4 
 Makefile                                                           |    2 
 arch/arm/boot/dts/broadcom/bcm4708-buffalo-wzr-1166dhp-common.dtsi |    8 
 arch/arm/boot/dts/broadcom/bcm4708-luxul-xap-1510.dts              |    8 
 arch/arm/boot/dts/broadcom/bcm4708-luxul-xwc-1000.dts              |    8 
 arch/arm/boot/dts/broadcom/bcm4708-netgear-r6250.dts               |    8 
 arch/arm/boot/dts/broadcom/bcm4708-smartrg-sr400ac.dts             |    8 
 arch/arm/boot/dts/broadcom/bcm47081-buffalo-wzr-600dhp2.dts        |    8 
 arch/arm/boot/dts/broadcom/bcm47081-luxul-xap-1410.dts             |    8 
 arch/arm/boot/dts/broadcom/bcm47081-luxul-xwr-1200.dts             |    8 
 arch/arm/boot/dts/broadcom/bcm4709-netgear-r8000.dts               |    8 
 arch/arm/boot/dts/broadcom/bcm47094-dlink-dir-885l.dts             |    8 
 arch/arm/boot/dts/broadcom/bcm47094-dlink-dir-890l.dts             |    8 
 arch/arm/boot/dts/broadcom/bcm47094-luxul-abr-4500.dts             |    8 
 arch/arm/boot/dts/broadcom/bcm47094-luxul-xap-1610.dts             |    8 
 arch/arm/boot/dts/broadcom/bcm47094-luxul-xbr-4500.dts             |    8 
 arch/arm/boot/dts/broadcom/bcm47094-luxul-xwc-2000.dts             |    8 
 arch/arm/boot/dts/broadcom/bcm47094-luxul-xwr-3100.dts             |    8 
 arch/arm/boot/dts/broadcom/bcm47094-luxul-xwr-3150-v1.dts          |    8 
 arch/arm/boot/dts/broadcom/bcm53015-meraki-mr26.dts                |    8 
 arch/arm/boot/dts/broadcom/bcm53016-meraki-mr32.dts                |    8 
 arch/arm/boot/dts/broadcom/bcm953012er.dts                         |    8 
 arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts       |    4 
 arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi                           |   14 
 arch/arm/boot/dts/renesas/r8a7792-blanche.dts                      |    2 
 arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi                          |    1 
 arch/arm/boot/dts/ti/omap/am3517-evm.dts                           |   16 
 arch/arm/include/asm/arm_pmuv3.h                                   |   48 
 arch/arm/include/asm/dma.h                                         |    3 
 arch/arm/lib/memset.S                                              |    1 
 arch/arm/xen/enlighten.c                                           |   25 
 arch/arm64/boot/dts/freescale/imx8mm.dtsi                          |    1 
 arch/arm64/boot/dts/freescale/imx8mn.dtsi                          |    1 
 arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts             |    3 
 arch/arm64/boot/dts/freescale/imx8qm-ss-img.dtsi                   |    2 
 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi                        |    4 
 arch/arm64/boot/dts/marvell/cn9130-db.dtsi                         |    4 
 arch/arm64/boot/dts/nvidia/tegra234-p3767.dtsi                     |    4 
 arch/arm64/boot/dts/nvidia/tegra234.dtsi                           |   12 
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts                           |    3 
 arch/arm64/boot/dts/qcom/msm8916.dtsi                              |    2 
 arch/arm64/boot/dts/qcom/msm8939.dtsi                              |    2 
 arch/arm64/boot/dts/qcom/msm8976.dtsi                              |    8 
 arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts                  |    5 
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts                           |   90 -
 arch/arm64/boot/dts/qcom/sc7280.dtsi                               |   32 
 arch/arm64/boot/dts/qcom/sdm670.dtsi                               |    3 
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi                         |   32 
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts                            |    2 
 arch/arm64/boot/dts/qcom/sdx75-idp.dts                             |    2 
 arch/arm64/boot/dts/qcom/sm6125.dtsi                               |    2 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                               |   12 
 arch/arm64/boot/dts/qcom/sm8350.dtsi                               |    2 
 arch/arm64/boot/dts/ti/Makefile                                    |    7 
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                         |    1 
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts                     |    2 
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts                            |    2 
 arch/arm64/include/asm/arm_pmuv3.h                                 |   25 
 arch/arm64/include/asm/cputype.h                                   |    3 
 arch/arm64/kvm/guest.c                                             |    2 
 arch/powerpc/include/asm/nohash/32/pte-40x.h                       |    3 
 arch/powerpc/kernel/process.c                                      |   26 
 arch/powerpc/kernel/traps.c                                        |    2 
 arch/powerpc/kexec/core.c                                          |    3 
 arch/powerpc/perf/imc-pmu.c                                        |    2 
 arch/powerpc/platforms/book3s/vas-api.c                            |   34 
 arch/powerpc/platforms/pseries/lpar.c                              |    4 
 arch/powerpc/platforms/pseries/vas.c                               |    4 
 arch/powerpc/sysdev/xive/native.c                                  |    2 
 arch/riscv/boot/Makefile                                           |    1 
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi                      |    1 
 arch/riscv/kernel/cpu.c                                            |   11 
 arch/sh/Kconfig.debug                                              |   11 
 arch/x86/coco/tdx/tdcall.S                                         |    1 
 arch/x86/include/asm/nospec-branch.h                               |    4 
 arch/x86/include/asm/sparsemem.h                                   |    2 
 arch/x86/include/asm/uaccess.h                                     |    2 
 arch/x86/kernel/amd_nb.c                                           |    3 
 arch/x86/kernel/apic/apic.c                                        |   11 
 arch/x86/kernel/cpu/bugs.c                                         |   42 
 arch/x86/kernel/head64.c                                           |    2 
 arch/x86/kernel/nmi.c                                              |   13 
 arch/x86/lib/copy_mc.c                                             |    8 
 arch/x86/mm/maccess.c                                              |   19 
 arch/x86/mm/numa.c                                                 |   80 +
 arch/x86/net/bpf_jit_comp.c                                        |   28 
 block/blk-core.c                                                   |    4 
 crypto/asymmetric_keys/Kconfig                                     |    3 
 crypto/asymmetric_keys/Makefile                                    |    3 
 crypto/asymmetric_keys/selftest.c                                  |   13 
 crypto/asymmetric_keys/x509_parser.h                               |    9 
 crypto/asymmetric_keys/x509_public_key.c                           |    8 
 drivers/accel/habanalabs/gaudi2/gaudi2.c                           |    4 
 drivers/acpi/device_sysfs.c                                        |   10 
 drivers/acpi/numa/srat.c                                           |   11 
 drivers/acpi/property.c                                            |   19 
 drivers/acpi/video_detect.c                                        |   26 
 drivers/base/regmap/regmap-debugfs.c                               |    2 
 drivers/base/regmap/regmap.c                                       |   16 
 drivers/block/nbd.c                                                |   11 
 drivers/char/hw_random/bcm2835-rng.c                               |    2 
 drivers/char/hw_random/core.c                                      |    6 
 drivers/char/hw_random/geode-rng.c                                 |    6 
 drivers/clk/clk-npcm7xx.c                                          |    2 
 drivers/clk/clk-scmi.c                                             |    1 
 drivers/clk/imx/Kconfig                                            |    1 
 drivers/clk/imx/clk-imx8-acm.c                                     |   16 
 drivers/clk/imx/clk-imx8mq.c                                       |   17 
 drivers/clk/imx/clk-imx8qxp.c                                      |    2 
 drivers/clk/keystone/pll.c                                         |   15 
 drivers/clk/mediatek/clk-mt2701.c                                  |    8 
 drivers/clk/mediatek/clk-mt6765.c                                  |    6 
 drivers/clk/mediatek/clk-mt6779.c                                  |    4 
 drivers/clk/mediatek/clk-mt6797.c                                  |    6 
 drivers/clk/mediatek/clk-mt7629-eth.c                              |    4 
 drivers/clk/mediatek/clk-mt7629.c                                  |    6 
 drivers/clk/mediatek/clk-pll.c                                     |    6 
 drivers/clk/qcom/Kconfig                                           |    1 
 drivers/clk/qcom/apss-ipq-pll.c                                    |    4 
 drivers/clk/qcom/clk-alpha-pll.c                                   |   63 +
 drivers/clk/qcom/clk-alpha-pll.h                                   |    1 
 drivers/clk/qcom/clk-rcg2.c                                        |   14 
 drivers/clk/qcom/gcc-ipq5018.c                                     |    3 
 drivers/clk/qcom/gcc-ipq5332.c                                     |    4 
 drivers/clk/qcom/gcc-ipq9574.c                                     |    4 
 drivers/clk/qcom/gcc-msm8996.c                                     |  237 ----
 drivers/clk/qcom/gcc-sm8150.c                                      |    2 
 drivers/clk/qcom/mmcc-msm8998.c                                    |    7 
 drivers/clk/ralink/clk-mtmips.c                                    |   20 
 drivers/clk/renesas/rcar-cpg-lib.c                                 |   15 
 drivers/clk/renesas/rzg2l-cpg.c                                    |   62 -
 drivers/clk/renesas/rzg2l-cpg.h                                    |    2 
 drivers/clk/ti/divider.c                                           |    8 
 drivers/clocksource/arm_arch_timer.c                               |    5 
 drivers/clocksource/timer-ti-dm.c                                  |   36 
 drivers/cpufreq/tegra194-cpufreq.c                                 |    2 
 drivers/crypto/caam/caamalg.c                                      |    3 
 drivers/crypto/caam/caamalg_qi2.c                                  |    3 
 drivers/crypto/ccp/dbc.c                                           |    2 
 drivers/crypto/hisilicon/hpre/hpre_main.c                          |    7 
 drivers/crypto/hisilicon/qm.c                                      |   18 
 drivers/crypto/hisilicon/qm_common.h                               |    1 
 drivers/crypto/hisilicon/sec2/sec_main.c                           |    5 
 drivers/crypto/hisilicon/zip/zip_main.c                            |    5 
 drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c               |  211 ++--
 drivers/crypto/intel/qat/qat_4xxx/adf_drv.c                        |   34 
 drivers/crypto/intel/qat/qat_common/adf_accel_devices.h            |    3 
 drivers/crypto/intel/qat/qat_common/adf_admin.c                    |   39 
 drivers/crypto/intel/qat/qat_common/adf_cfg_services.h             |   34 
 drivers/crypto/intel/qat/qat_common/adf_cfg_strings.h              |    1 
 drivers/crypto/intel/qat/qat_common/adf_common_drv.h               |    2 
 drivers/crypto/intel/qat/qat_common/adf_init.c                     |   20 
 drivers/crypto/intel/qat/qat_common/adf_sysfs.c                    |   28 
 drivers/crypto/intel/qat/qat_common/adf_transport_debug.c          |    4 
 drivers/crypto/intel/qat/qat_common/icp_qat_fw_init_admin.h        |    1 
 drivers/crypto/intel/qat/qat_common/qat_algs_send.c                |   46 
 drivers/cxl/core/core.h                                            |    1 
 drivers/cxl/core/hdm.c                                             |   40 
 drivers/cxl/core/mbox.c                                            |   55 -
 drivers/cxl/core/memdev.c                                          |  157 +--
 drivers/cxl/core/port.c                                            |   53 -
 drivers/cxl/core/region.c                                          |  241 ++--
 drivers/cxl/core/regs.c                                            |   28 
 drivers/cxl/cxl.h                                                  |    4 
 drivers/cxl/cxlmem.h                                               |   13 
 drivers/cxl/pci.c                                                  |   80 -
 drivers/devfreq/event/rockchip-dfi.c                               |   15 
 drivers/dma/idxd/Makefile                                          |    6 
 drivers/dma/pxa_dma.c                                              |    1 
 drivers/dma/ti/edma.c                                              |    4 
 drivers/firmware/arm_ffa/bus.c                                     |    1 
 drivers/firmware/arm_ffa/driver.c                                  |   12 
 drivers/firmware/tegra/bpmp.c                                      |   30 
 drivers/firmware/ti_sci.c                                          |   46 
 drivers/gpio/gpio-sim.c                                            |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c                            |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h                             |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                             |   12 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                             |   12 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                               |   92 -
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h                               |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                  |   73 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c               |    4 
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c                            |    7 
 drivers/gpu/drm/bridge/Kconfig                                     |    2 
 drivers/gpu/drm/bridge/cadence/Kconfig                             |    1 
 drivers/gpu/drm/bridge/ite-it66121.c                               |   12 
 drivers/gpu/drm/bridge/lontium-lt8912b.c                           |   22 
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c                         |   10 
 drivers/gpu/drm/bridge/samsung-dsim.c                              |   20 
 drivers/gpu/drm/bridge/tc358768.c                                  |  166 +--
 drivers/gpu/drm/drm_syncobj.c                                      |    3 
 drivers/gpu/drm/loongson/lsdc_pixpll.c                             |    6 
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c                            |    3 
 drivers/gpu/drm/mediatek/mtk_drm_drv.c                             |    1 
 drivers/gpu/drm/mediatek/mtk_drm_gem.c                             |    9 
 drivers/gpu/drm/mediatek/mtk_drm_plane.c                           |   41 
 drivers/gpu/drm/mediatek/mtk_dsi.c                                 |    4 
 drivers/gpu/drm/mgag200/mgag200_drv.c                              |    8 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                              |    2 
 drivers/gpu/drm/msm/adreno/adreno_device.c                         |    2 
 drivers/gpu/drm/msm/dsi/dsi.c                                      |    1 
 drivers/gpu/drm/msm/dsi/dsi.h                                      |    1 
 drivers/gpu/drm/msm/dsi/dsi_host.c                                 |   16 
 drivers/gpu/drm/pl111/pl111_drv.c                                  |    7 
 drivers/gpu/drm/radeon/evergreen.c                                 |    7 
 drivers/gpu/drm/radeon/radeon.h                                    |    4 
 drivers/gpu/drm/radeon/radeon_drv.c                                |    2 
 drivers/gpu/drm/radeon/radeon_gem.c                                |   16 
 drivers/gpu/drm/rockchip/cdn-dp-core.c                             |   15 
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c                        |    2 
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c                        |    8 
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c                       |   39 
 drivers/gpu/drm/solomon/ssd130x.c                                  |   47 
 drivers/gpu/drm/stm/drv.c                                          |    7 
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                                |   11 
 drivers/gpu/drm/tve200/tve200_drv.c                                |    7 
 drivers/gpu/drm/vboxvideo/vbox_drv.c                               |   10 
 drivers/gpu/drm/vc4/tests/vc4_mock_crtc.c                          |    2 
 drivers/gpu/drm/vc4/tests/vc4_mock_output.c                        |    2 
 drivers/gpu/host1x/context.c                                       |    4 
 drivers/hid/hid-cp2112.c                                           |   10 
 drivers/hid/hid-logitech-hidpp.c                                   |   60 -
 drivers/hid/hid-uclogic-core-test.c                                |    7 
 drivers/hid/hid-uclogic-params-test.c                              |   16 
 drivers/hte/hte-tegra194-test.c                                    |    4 
 drivers/hwmon/axi-fan-control.c                                    |   29 
 drivers/hwmon/coretemp.c                                           |    2 
 drivers/hwmon/nct6775-core.c                                       |   12 
 drivers/hwmon/pmbus/mp2975.c                                       |   10 
 drivers/hwmon/sch5627.c                                            |   21 
 drivers/hwmon/sch56xx-common.c                                     |   64 -
 drivers/i2c/busses/i2c-bcm-iproc.c                                 |  133 +-
 drivers/i3c/master.c                                               |    4 
 drivers/iio/frequency/adf4350.c                                    |   75 -
 drivers/infiniband/core/device.c                                   |    2 
 drivers/infiniband/core/sa_query.c                                 |    4 
 drivers/infiniband/core/sysfs.c                                    |   10 
 drivers/infiniband/core/user_mad.c                                 |    4 
 drivers/infiniband/hw/hfi1/efivar.c                                |    2 
 drivers/infiniband/hw/hns/hns_roce_ah.c                            |   13 
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                         |   34 
 drivers/infiniband/hw/hns/hns_roce_main.c                          |   22 
 drivers/infiniband/hw/hns/hns_roce_qp.c                            |    2 
 drivers/infiniband/hw/mlx5/main.c                                  |    4 
 drivers/infiniband/hw/mlx5/qp.c                                    |   27 
 drivers/input/rmi4/rmi_bus.c                                       |    2 
 drivers/interconnect/qcom/icc-rpm.c                                |   14 
 drivers/interconnect/qcom/osm-l3.c                                 |    3 
 drivers/interconnect/qcom/qdu1000.c                                |    1 
 drivers/interconnect/qcom/sc7180.c                                 |    1 
 drivers/interconnect/qcom/sc7280.c                                 |    1 
 drivers/interconnect/qcom/sc8180x.c                                |    1 
 drivers/interconnect/qcom/sc8280xp.c                               |    1 
 drivers/interconnect/qcom/sdm670.c                                 |    1 
 drivers/interconnect/qcom/sdm845.c                                 |    1 
 drivers/interconnect/qcom/sm6350.c                                 |    1 
 drivers/interconnect/qcom/sm8150.c                                 |    1 
 drivers/interconnect/qcom/sm8250.c                                 |    1 
 drivers/interconnect/qcom/sm8350.c                                 |    1 
 drivers/iommu/iommufd/io_pagetable.c                               |   18 
 drivers/iommu/iommufd/pages.c                                      |    2 
 drivers/irqchip/irq-sifive-plic.c                                  |    7 
 drivers/leds/leds-pwm.c                                            |    2 
 drivers/leds/leds-turris-omnia.c                                   |   54 -
 drivers/leds/trigger/ledtrig-cpu.c                                 |    4 
 drivers/media/cec/platform/Makefile                                |    2 
 drivers/media/i2c/Kconfig                                          |    1 
 drivers/media/i2c/imx219.c                                         |  503 ++++------
 drivers/media/i2c/max9286.c                                        |    2 
 drivers/media/i2c/ov13b10.c                                        |    2 
 drivers/media/i2c/ov5640.c                                         |   24 
 drivers/media/pci/bt8xx/bttv-driver.c                              |    1 
 drivers/media/platform/amphion/vpu_defs.h                          |    1 
 drivers/media/platform/amphion/vpu_helpers.c                       |    1 
 drivers/media/platform/amphion/vpu_malone.c                        |    1 
 drivers/media/platform/amphion/vpu_msgs.c                          |   31 
 drivers/media/platform/cadence/cdns-csi2rx.c                       |    7 
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c             |    5 
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c               |    2 
 drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_util.c    |   56 -
 drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c       |    5 
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c                     |   34 
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.h                     |    1 
 drivers/media/platform/samsung/s3c-camif/camif-capture.c           |    6 
 drivers/media/platform/verisilicon/hantro_drv.c                    |    3 
 drivers/media/platform/verisilicon/hantro_postproc.c               |    2 
 drivers/media/platform/verisilicon/rockchip_vpu_hw.c               |    2 
 drivers/media/test-drivers/vidtv/vidtv_mux.c                       |    7 
 drivers/media/test-drivers/vidtv/vidtv_psi.c                       |   45 
 drivers/media/usb/dvb-usb-v2/af9035.c                              |   13 
 drivers/memory/tegra/tegra234.c                                    |    4 
 drivers/mfd/arizona-spi.c                                          |    3 
 drivers/mfd/dln2.c                                                 |    1 
 drivers/mfd/mfd-core.c                                             |   17 
 drivers/misc/ti-st/st_core.c                                       |    7 
 drivers/mmc/core/mmc.c                                             |    2 
 drivers/net/can/dev/dev.c                                          |   10 
 drivers/net/can/dev/skb.c                                          |    6 
 drivers/net/can/usb/etas_es58x/es58x_core.c                        |    1 
 drivers/net/can/usb/etas_es58x/es58x_core.h                        |    6 
 drivers/net/can/usb/etas_es58x/es58x_devlink.c                     |   57 -
 drivers/net/ethernet/broadcom/tg3.c                                |    3 
 drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c        |    2 
 drivers/net/ethernet/freescale/enetc/enetc.c                       |    2 
 drivers/net/ethernet/google/gve/gve_main.c                         |    2 
 drivers/net/ethernet/intel/i40e/i40e_main.c                        |   10 
 drivers/net/ethernet/intel/iavf/iavf.h                             |   16 
 drivers/net/ethernet/intel/iavf/iavf_main.c                        |   43 
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c                    |   75 -
 drivers/net/ethernet/intel/ice/ice_lag.c                           |   18 
 drivers/net/ethernet/intel/ice/ice_ptp.c                           |   12 
 drivers/net/ethernet/intel/ice/ice_tc_lib.c                        |  114 +-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c           |   15 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h           |    1 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c               |   81 -
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_struct.h           |   34 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c             |   42 
 drivers/net/ethernet/mediatek/mtk_wed_regs.h                       |    4 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c    |    2 
 drivers/net/ethernet/realtek/r8169_main.c                          |   10 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h                     |    2 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c                |   14 
 drivers/net/ethernet/ti/icssg/icss_iep.c                           |    2 
 drivers/net/ethernet/toshiba/spider_net.c                          |    2 
 drivers/net/gtp.c                                                  |    4 
 drivers/net/ipvlan/ipvlan_core.c                                   |    8 
 drivers/net/ipvlan/ipvlan_main.c                                   |    1 
 drivers/net/macsec.c                                               |    6 
 drivers/net/usb/r8152.c                                            |   18 
 drivers/net/virtio_net.c                                           |  198 ++-
 drivers/net/wireless/ath/ath11k/mac.c                              |    8 
 drivers/net/wireless/ath/ath11k/pci.c                              |   24 
 drivers/net/wireless/ath/ath12k/dp_rx.c                            |    2 
 drivers/net/wireless/ath/ath12k/dp_tx.c                            |    7 
 drivers/net/wireless/ath/dfs_pattern_detector.c                    |    2 
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c                        |   14 
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c                        |   10 
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c                        |    5 
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h                |    1 
 drivers/net/wireless/intel/iwlwifi/iwl-config.h                    |    5 
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h                   |    5 
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c                       |   51 -
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h                      |    4 
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h                     |   11 
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                        |   10 
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c             |    9 
 drivers/net/wireless/intel/iwlwifi/mvm/link.c                      |   22 
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c                  |    8 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c                  |  182 +--
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c                   |   16 
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c              |  105 --
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c                   |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h                       |    9 
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c                       |   12 
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c                |   31 
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                        |   22 
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c               |    1 
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c                    |    1 
 drivers/net/wireless/intel/iwlwifi/queue/tx.c                      |    9 
 drivers/net/wireless/intel/iwlwifi/queue/tx.h                      |    2 
 drivers/net/wireless/mediatek/mt76/dma.c                           |    3 
 drivers/net/wireless/mediatek/mt76/mac80211.c                      |    9 
 drivers/net/wireless/mediatek/mt76/mt76.h                          |    4 
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c                 |   76 +
 drivers/net/wireless/mediatek/mt76/mt7603/core.c                   |    2 
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c                    |   52 -
 drivers/net/wireless/mediatek/mt76/mt7603/regs.h                   |    5 
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                    |    2 
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c                |    2 
 drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h              |    2 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c               |   24 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c               |    9 
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c                    |    2 
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                   |    8 
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                    |   69 -
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h                    |   18 
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                 |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/main.c                   |   12 
 drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c                |    2 
 drivers/net/wireless/mediatek/mt76/mt792x.h                        |    1 
 drivers/net/wireless/mediatek/mt76/mt792x_core.c                   |    4 
 drivers/net/wireless/mediatek/mt76/mt7996/init.c                   |    9 
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c                    |   12 
 drivers/net/wireless/mediatek/mt76/mt7996/main.c                   |   16 
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                    |   67 -
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.h                    |   11 
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c                |    2 
 drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c          |    2 
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c                |    2 
 drivers/net/wireless/realtek/rtw88/debug.c                         |    4 
 drivers/net/wireless/realtek/rtw88/usb.c                           |    9 
 drivers/net/wireless/silabs/wfx/data_tx.c                          |   71 -
 drivers/nvdimm/of_pmem.c                                           |    8 
 drivers/nvdimm/region_devs.c                                       |    8 
 drivers/nvme/host/ioctl.c                                          |    7 
 drivers/pci/controller/vmd.c                                       |    3 
 drivers/pci/endpoint/pci-epc-core.c                                |    1 
 drivers/pci/pcie/aspm.c                                            |    3 
 drivers/pcmcia/cs.c                                                |    1 
 drivers/pcmcia/ds.c                                                |   14 
 drivers/perf/arm-cmn.c                                             |   16 
 drivers/perf/arm_pmuv3.c                                           |    6 
 drivers/perf/hisilicon/hisi_pcie_pmu.c                             |    7 
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c                        |    4 
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c                      |    4 
 drivers/perf/hisilicon/hns3_pmu.c                                  |    8 
 drivers/perf/riscv_pmu_sbi.c                                       |    6 
 drivers/pinctrl/intel/pinctrl-baytrail.c                           |   11 
 drivers/pinctrl/renesas/pinctrl-rzg2l.c                            |    3 
 drivers/platform/chrome/cros_ec.c                                  |  116 +-
 drivers/platform/chrome/cros_ec.h                                  |    4 
 drivers/platform/chrome/cros_ec_lpc.c                              |   22 
 drivers/platform/x86/wmi.c                                         |   36 
 drivers/pwm/pwm-brcmstb.c                                          |    4 
 drivers/pwm/pwm-sti.c                                              |   29 
 drivers/regulator/mt6358-regulator.c                               |   14 
 drivers/regulator/qcom-rpmh-regulator.c                            |    2 
 drivers/rtc/rtc-brcmstb-waketimer.c                                |   47 
 drivers/rtc/rtc-pcf85363.c                                         |    2 
 drivers/s390/crypto/ap_bus.c                                       |   21 
 drivers/s390/crypto/ap_bus.h                                       |    1 
 drivers/s390/crypto/ap_queue.c                                     |    9 
 drivers/scsi/ibmvscsi/ibmvfc.c                                     |    3 
 drivers/soc/qcom/llcc-qcom.c                                       |    3 
 drivers/soc/qcom/pmic_glink_altmode.c                              |    2 
 drivers/spi/Kconfig                                                |    1 
 drivers/spi/spi-nxp-fspi.c                                         |    2 
 drivers/spi/spi-omap2-mcspi.c                                      |  263 ++---
 drivers/spi/spi-tegra20-slink.c                                    |    2 
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c                     |   24 
 drivers/thermal/mediatek/auxadc_thermal.c                          |    2 
 drivers/thermal/thermal_core.c                                     |    6 
 drivers/thermal/thermal_trip.c                                     |   19 
 drivers/tty/tty_jobctrl.c                                          |   17 
 drivers/ufs/core/ufshcd.c                                          |    2 
 drivers/usb/chipidea/host.c                                        |   48 
 drivers/usb/dwc2/hcd.c                                             |    2 
 drivers/usb/host/xhci-pci.c                                        |    2 
 drivers/usb/host/xhci-plat.c                                       |   23 
 drivers/usb/usbip/stub_dev.c                                       |    9 
 drivers/video/backlight/pwm_bl.c                                   |   22 
 drivers/video/fbdev/fsl-diu-fb.c                                   |    2 
 drivers/video/fbdev/imsttfb.c                                      |   35 
 drivers/virt/coco/sev-guest/sev-guest.c                            |   45 
 drivers/watchdog/ixp4xx_wdt.c                                      |   28 
 drivers/watchdog/marvell_gti_wdt.c                                 |    2 
 drivers/xen/privcmd.c                                              |    2 
 drivers/xen/xen-pciback/conf_space.c                               |   19 
 drivers/xen/xen-pciback/conf_space_capability.c                    |    8 
 drivers/xen/xen-pciback/conf_space_header.c                        |   21 
 drivers/xen/xenbus/xenbus_probe.c                                  |    2 
 fs/btrfs/ioctl.c                                                   |   10 
 fs/btrfs/scrub.c                                                   |   10 
 fs/debugfs/file.c                                                  |    2 
 fs/dlm/debug_fs.c                                                  |   13 
 fs/dlm/midcomms.c                                                  |   39 
 fs/erofs/utils.c                                                   |    8 
 fs/erofs/zdata.c                                                   |    1 
 fs/ext4/extents.c                                                  |   10 
 fs/ext4/super.c                                                    |    3 
 fs/f2fs/data.c                                                     |   24 
 fs/f2fs/file.c                                                     |    1 
 fs/f2fs/super.c                                                    |   35 
 fs/fs-writeback.c                                                  |   41 
 fs/nfsd/filecache.c                                                |   27 
 fs/nfsd/vfs.c                                                      |   28 
 fs/nfsd/vfs.h                                                      |    4 
 fs/pstore/platform.c                                               |    9 
 fs/tracefs/event_inode.c                                           |    4 
 include/drm/bridge/samsung-dsim.h                                  |    1 
 include/linux/bpf.h                                                |    5 
 include/linux/clk-provider.h                                       |   15 
 include/linux/cpuhotplug.h                                         |    1 
 include/linux/hisi_acc_qm.h                                        |    7 
 include/linux/hw_random.h                                          |    1 
 include/linux/idr.h                                                |    6 
 include/linux/mfd/core.h                                           |    2 
 include/linux/netdevice.h                                          |    1 
 include/linux/numa.h                                               |   14 
 include/linux/objtool.h                                            |    3 
 include/linux/pci.h                                                |   34 
 include/linux/perf_event.h                                         |    1 
 include/linux/pm.h                                                 |   43 
 include/linux/string.h                                             |    7 
 include/linux/topology.h                                           |    2 
 include/linux/udp.h                                                |   66 -
 include/linux/verification.h                                       |    1 
 include/net/bluetooth/hci.h                                        |    3 
 include/net/bluetooth/hci_core.h                                   |   31 
 include/net/cfg80211.h                                             |   21 
 include/net/flow.h                                                 |    2 
 include/net/netfilter/nf_conntrack_act_ct.h                        |   30 
 include/net/tcp.h                                                  |    2 
 include/net/udp_tunnel.h                                           |    9 
 include/net/udplite.h                                              |   14 
 include/soc/tegra/bpmp.h                                           |    6 
 include/sound/cs35l41.h                                            |    4 
 include/uapi/xen/privcmd.h                                         |    4 
 io_uring/kbuf.c                                                    |   11 
 io_uring/net.c                                                     |   24 
 kernel/bpf/hashtab.c                                               |    7 
 kernel/bpf/helpers.c                                               |   32 
 kernel/bpf/trampoline.c                                            |    4 
 kernel/bpf/verifier.c                                              |    7 
 kernel/cgroup/cpuset.c                                             |   12 
 kernel/cpu.c                                                       |   18 
 kernel/events/core.c                                               |  115 +-
 kernel/futex/core.c                                                |   12 
 kernel/irq/matrix.c                                                |    6 
 kernel/livepatch/core.c                                            |    2 
 kernel/module/decompress.c                                         |    8 
 kernel/padata.c                                                    |    6 
 kernel/rcu/srcutree.c                                              |   31 
 kernel/sched/core.c                                                |   10 
 kernel/sched/deadline.c                                            |    2 
 kernel/sched/fair.c                                                |   35 
 kernel/sched/rt.c                                                  |    4 
 kernel/sched/topology.c                                            |    6 
 kernel/trace/trace_kprobe.c                                        |    2 
 lib/kunit/executor.c                                               |   23 
 lib/kunit/executor_test.c                                          |   36 
 mm/mempolicy.c                                                     |   18 
 mm/readahead.c                                                     |    3 
 net/9p/client.c                                                    |    6 
 net/bluetooth/amp.c                                                |    3 
 net/bluetooth/hci_conn.c                                           |   58 -
 net/bluetooth/hci_core.c                                           |    3 
 net/bluetooth/hci_event.c                                          |   84 +
 net/bluetooth/hci_sync.c                                           |    4 
 net/bluetooth/iso.c                                                |   19 
 net/core/page_pool.c                                               |    6 
 net/core/skbuff.c                                                  |    3 
 net/dccp/ipv4.c                                                    |    6 
 net/dccp/ipv6.c                                                    |    6 
 net/hsr/hsr_forward.c                                              |    4 
 net/ipv4/syncookies.c                                              |   20 
 net/ipv4/tcp_input.c                                               |    9 
 net/ipv4/tcp_metrics.c                                             |   15 
 net/ipv4/udp.c                                                     |   74 -
 net/ipv4/udp_offload.c                                             |    4 
 net/ipv4/udp_tunnel_core.c                                         |    2 
 net/ipv4/udplite.c                                                 |    1 
 net/ipv4/xfrm4_input.c                                             |    4 
 net/ipv6/ip6_output.c                                              |    8 
 net/ipv6/syncookies.c                                              |    7 
 net/ipv6/udp.c                                                     |   34 
 net/ipv6/udplite.c                                                 |    1 
 net/ipv6/xfrm6_input.c                                             |    4 
 net/l2tp/l2tp_core.c                                               |    6 
 net/llc/llc_input.c                                                |   10 
 net/llc/llc_s_ac.c                                                 |    3 
 net/llc/llc_station.c                                              |    3 
 net/mac80211/driver-ops.c                                          |    9 
 net/mac80211/drop.h                                                |    3 
 net/mac80211/ieee80211_i.h                                         |   18 
 net/mac80211/iface.c                                               |    2 
 net/mac80211/link.c                                                |    2 
 net/mac80211/main.c                                                |   25 
 net/mac80211/mesh_pathtbl.c                                        |    2 
 net/mac80211/offchannel.c                                          |   36 
 net/mac80211/rx.c                                                  |    2 
 net/mac80211/scan.c                                                |   36 
 net/mac80211/sta_info.c                                            |    2 
 net/mac80211/util.c                                                |   11 
 net/mptcp/fastopen.c                                               |    1 
 net/netfilter/nf_nat_redirect.c                                    |   27 
 net/netfilter/nf_tables_api.c                                      |    4 
 net/netfilter/xt_recent.c                                          |    2 
 net/openvswitch/conntrack.c                                        |    2 
 net/rxrpc/conn_object.c                                            |    2 
 net/rxrpc/local_object.c                                           |    2 
 net/sched/act_ct.c                                                 |   15 
 net/smc/af_smc.c                                                   |    4 
 net/smc/smc.h                                                      |    5 
 net/smc/smc_cdc.c                                                  |   11 
 net/smc/smc_close.c                                                |    5 
 net/tipc/link.c                                                    |    4 
 net/tipc/netlink.c                                                 |    4 
 net/tls/tls_sw.c                                                   |    2 
 net/vmw_vsock/virtio_transport_common.c                            |   18 
 net/wireless/core.c                                                |   34 
 net/wireless/core.h                                                |    3 
 net/wireless/scan.c                                                |    4 
 net/wireless/sysfs.c                                               |    4 
 scripts/Makefile.vmlinux_o                                         |    3 
 scripts/gdb/linux/constants.py.in                                  |    9 
 scripts/mod/file2alias.c                                           |   14 
 security/apparmor/policy.c                                         |    1 
 security/apparmor/policy_unpack.c                                  |    5 
 sound/pci/hda/cs35l41_hda.c                                        |    9 
 sound/pci/hda/patch_realtek.c                                      |   40 
 sound/soc/codecs/cs35l41-lib.c                                     |   60 -
 sound/soc/codecs/cs35l41.c                                         |   38 
 sound/soc/codecs/cs35l41.h                                         |    1 
 sound/soc/codecs/hdmi-codec.c                                      |   27 
 sound/soc/codecs/rt712-sdca.c                                      |   14 
 sound/soc/fsl/fsl-asoc-card.c                                      |    1 
 sound/soc/fsl/fsl_easrc.c                                          |    8 
 sound/soc/fsl/mpc5200_dma.c                                        |    3 
 sound/soc/intel/boards/sof_sdw.c                                   |    2 
 sound/soc/intel/boards/sof_sdw_rt_sdca_jack_common.c               |    8 
 sound/soc/intel/skylake/skl-sst-utils.c                            |    1 
 sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c           |    4 
 sound/soc/soc-dapm.c                                               |    2 
 sound/soc/soc-pcm.c                                                |   21 
 sound/soc/sof/core.c                                               |    6 
 sound/soc/sof/ipc4-topology.c                                      |    3 
 sound/soc/ti/ams-delta.c                                           |    4 
 tools/crypto/ccp/dbc.c                                             |   17 
 tools/crypto/ccp/dbc.py                                            |    8 
 tools/crypto/ccp/test_dbc.py                                       |   45 
 tools/iio/iio_generic_buffer.c                                     |   13 
 tools/lib/bpf/bpf_tracing.h                                        |    2 
 tools/lib/perf/include/internal/rc_check.h                         |    6 
 tools/objtool/objtool.c                                            |    4 
 tools/perf/Documentation/perf-kwork.txt                            |    2 
 tools/perf/Makefile.perf                                           |    4 
 tools/perf/builtin-kwork.c                                         |   13 
 tools/perf/builtin-lock.c                                          |   17 
 tools/perf/builtin-stat.c                                          |    2 
 tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json     |  418 ++++----
 tools/perf/pmu-events/arch/powerpc/power10/pmc.json                |    2 
 tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json      |   14 
 tools/perf/util/bpf_off_cpu.c                                      |    5 
 tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c              |   16 
 tools/perf/util/bpf_skel/vmlinux/.gitignore                        |    1 
 tools/perf/util/hist.c                                             |   10 
 tools/perf/util/machine.c                                          |   22 
 tools/perf/util/mem-events.c                                       |    3 
 tools/perf/util/parse-events.y                                     |    9 
 tools/power/cpupower/man/cpupower-powercap-info.1                  |    2 
 tools/testing/cxl/test/mem.c                                       |    4 
 tools/testing/selftests/bpf/prog_tests/linked_list.c               |   10 
 tools/testing/selftests/bpf/prog_tests/module_fentry_shadow.c      |    5 
 tools/testing/selftests/bpf/prog_tests/tailcalls.c                 |   32 
 tools/testing/selftests/bpf/progs/bpf_misc.h                       |    3 
 tools/testing/selftests/bpf/progs/linked_list_fail.c               |    4 
 tools/testing/selftests/bpf/test_progs.h                           |    2 
 tools/testing/selftests/mm/mdwe_test.c                             |    9 
 tools/testing/selftests/net/mptcp/mptcp_join.sh                    |   18 
 tools/testing/selftests/net/pmtu.sh                                |    2 
 tools/testing/selftests/netfilter/Makefile                         |    2 
 tools/testing/selftests/netfilter/xt_string.sh                     |  128 ++
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c                  |    2 
 tools/testing/selftests/pidfd/pidfd_test.c                         |   12 
 tools/testing/selftests/resctrl/resctrl_tests.c                    |    5 
 tools/testing/selftests/x86/lam.c                                  |    6 
 tools/tracing/rtla/src/utils.c                                     |    2 
 651 files changed, 6537 insertions(+), 4427 deletions(-)

Aananth V (1):
      tcp: call tcp_try_undo_recovery when an RTOd TFO SYNACK is ACKed

Aaron Plattner (1):
      objtool: Propagate early errors

Abel Vesa (2):
      clk: imx: Select MXC_CLK for CLK_IMX8QXP
      regulator: qcom-rpmh: Fix smps4 regulator for pm8550ve

Adam Dunlap (1):
      x86/sev-es: Allow copy_from_kernel_nofault() in earlier boot

Adam Ford (3):
      ARM: dts: am3517-evm: Fix LED3/4 pinmux
      arm64: dts: imx8mm: Add sound-dai-cells to micfil node
      arm64: dts: imx8mn: Add sound-dai-cells to micfil node

Adam Guerin (1):
      crypto: qat - enable dc chaining service

Adam Skladowski (1):
      arm64: dts: qcom: msm8976: Fix ipc bit shifts

Aditya Gupta (1):
      powerpc/vmcore: Add MMU information to vmcoreinfo

Aditya Kumar Singh (1):
      wifi: ath11k: fix Tx power value during active CAC

Alex Deucher (2):
      drm/amdgpu/gfx10,11: use memcpy_to/fromio for MQDs
      drm/amdgpu: don't put MQDs in VRAM on ARM | ARM64

Alexander Aring (4):
      dlm: fix creating multiple node structures
      dlm: fix remove member after close call
      dlm: be sure we reset all nodes at forced shutdown
      dlm: fix no ack after final message

Alexandre Ghiti (2):
      libbpf: Fix syscall access arguments on riscv
      drivers: perf: Do not broadcast to other cpus when starting a counter

Alison Schofield (5):
      x86/numa: Introduce numa_fill_memblks()
      ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window
      cxl/region: Prepare the decoder match range helper for reuse
      cxl/region: Calculate a target position in a region interleave
      cxl/region: Use cxl_calc_interleave_pos() for auto-discovery

Amit Kumar Mahapatra (1):
      spi: spi-zynq-qspi: add spi-mem to driver kconfig dependencies

Andre Przywara (1):
      clocksource/drivers/arm_arch_timer: limit XGene-1 workaround

Andrea Righi (2):
      module/decompress: use vmalloc() for gzip decompression workspace
      module/decompress: use kvmalloc() consistently

Andrii Staikov (1):
      i40e: fix potential memory leaks in i40e_remove()

Andy Shevchenko (2):
      ACPI: property: Allow _DSD buffer data only for byte accessors
      interconnect: qcom: osm-l3: Replace custom implementation of COUNT_ARGS()

AngeloGioacchino Del Regno (1):
      drm: mediatek: mtk_dsi: Fix NO_EOT_PACKET settings/handling

Aniruddha Paul (1):
      ice: Fix VF-VF filter rules in switchdev mode

Anuj Gupta (1):
      nvme: fix error-handling for io_uring nvme-passthrough

Anup Patel (2):
      irqchip/sifive-plic: Fix syscore registration for multi-socket systems
      RISC-V: Don't fail in riscv_of_parent_hartid() for disabled HARTs

Aradhya Bhatia (1):
      arm64: dts: ti: Fix HDMI Audio overlay in Makefile

Armin Wolf (4):
      platform/x86: wmi: Fix probe failure when failing to register WMI devices
      platform/x86: wmi: Fix opening of char device
      hwmon: (sch5627) Use bit macros when accessing the control register
      hwmon: (sch5627) Disallow write access if virtual registers are locked

Arnaldo Carvalho de Melo (1):
      perf build: Add missing comment about NO_LIBTRACEEVENT=1

Arnd Bergmann (1):
      fbdev: fsl-diu-fb: mark wr_reg_wa() static

Artem Savkov (1):
      selftests/bpf: Skip module_fentry_shadow test when bpf_testmod is not available

Avraham Stern (2):
      wifi: iwlwifi: mvm: update station's MFP flag after association
      wifi: iwlwifi: mvm: fix removing pasn station for responder

Baochen Qiang (2):
      wifi: ath12k: fix DMA unmap warning on NULL DMA address
      wifi: ath11k: fix boot failure with one MSI vector

Bard Liao (1):
      ASoC: Intel: sof_sdw_rt_sdca_jack_common: add rt713 support

Bartosz Golaszewski (1):
      gpio: sim: initialize a managed pointer when declaring it

Basavaraj Natikar (1):
      xhci: Loosen RPM as default policy to cover for AMD xHC 1.1

Ben Wolsieffer (2):
      futex: Don't include process MM in futex key on no-MMU
      regmap: prevent noinc writes from clobbering cache

Benjamin Gaignard (1):
      media: verisilicon: Fixes clock list for rk3588 av1 decoder

Benjamin Gray (1):
      powerpc/xive: Fix endian conversion size

Biju Das (1):
      pinctrl: renesas: rzg2l: Make reverse order of enable() for disable()

Binbin Wu (1):
      selftests/x86/lam: Zero out buffer for readlink()

Björn Töpel (2):
      selftests/bpf: Define SYS_PREFIX for riscv
      selftests/bpf: Define SYS_NANOSLEEP_KPROBE_NAME for riscv

Bo Jiao (1):
      wifi: mt76: fix potential memory leak of beacon commands

Brad Griffis (2):
      arm64: tegra: Fix P3767 card detect polarity
      arm64: tegra: Fix P3767 QSPI speed

Brett Creeley (1):
      iavf: Fix promiscuous mode configuration flow messages

Cezary Rojewski (1):
      ASoC: Intel: Skylake: Fix mem leak when parsing UUIDs fails

Chancel Liu (1):
      ASoC: soc-pcm.c: Make sure DAI parameters cleared if the DAI becomes inactive

Chao Yu (5):
      f2fs: compress: fix deadloop in f2fs_write_cache_pages()
      f2fs: compress: fix to avoid use-after-free on dic
      f2fs: compress: fix to avoid redundant compress extension
      f2fs: fix to drop meta_inode's page cache in f2fs_put_super()
      f2fs: fix to initialize map.m_pblk in f2fs_precache_extents()

Charles Keepax (1):
      ASoC: intel: sof_sdw: Stop processing CODECs when enough are found

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

Christophe JAILLET (14):
      wifi: ath: dfs_pattern_detector: Fix a memory initialization issue
      ACPI: sysfs: Fix create_pnp_modalias() and create_of_modalias()
      regmap: debugfs: Fix a erroneous check after snprintf()
      clk: imx: imx8: Fix an error handling path in clk_imx_acm_attach_pm_domains()
      clk: imx: imx8: Fix an error handling path if devm_clk_hw_register_mux_parent_data_table() fails
      clk: imx: imx8: Fix an error handling path in imx8_acm_clk_probe()
      accel/habanalabs/gaudi2: Fix incorrect string length computation in gaudi2_psoc_razwi_get_engines()
      drm/rockchip: cdn-dp: Fix some error handling paths in cdn_dp_probe()
      crypto: hisilicon/hpre - Fix a erroneous check after snprintf()
      fs: dlm: Fix the size of a buffer in dlm_create_debug_file()
      leds: trigger: ledtrig-cpu:: Fix 'output may be truncated' issue for 'cpu'
      dmaengine: pxa_dma: Remove an erroneous BUG_ON() in pxad_free_desc()
      media: i2c: max9286: Fix some redundant of_node_put() calls
      fs: dlm: Simplify buffer size computation in dlm_create_debug_file()

Christophe Leroy (2):
      powerpc: Only define __parse_fpscr() when required
      powerpc/40x: Remove stale PTE_ATOMIC_UPDATES macro

Claudiu Beznea (5):
      clk: renesas: rzg2l: Wait for status bit of SD mux before continuing
      clk: renesas: rzg2l: Lock around writes to mux register
      clk: renesas: rzg2l: Trust value returned by hardware
      clk: renesas: rzg2l: Use FIELD_GET() for PLL register fields
      clk: renesas: rzg2l: Fix computation formula

Clément Léger (1):
      scripts/gdb: fix usage of MOD_TEXT not defined when CONFIG_MODULES=n

Colin Ian King (1):
      rtla: Fix uninitialized variable found

Cong Liu (1):
      drm/amd/display: Fix null pointer dereference in error message

Conor Dooley (1):
      riscv: dts: allwinner: remove address-cells from intc node

Cristian Ciocaltea (8):
      ASoC: cs35l41: Handle mdsync_down reg write errors
      ASoC: cs35l41: Handle mdsync_up reg write errors
      ASoC: cs35l41: Initialize completion object before requesting IRQ
      ASoC: cs35l41: Fix broken shared boost activation
      ASoC: cs35l41: Verify PM runtime resume errors in IRQ handler
      ASoC: cs35l41: Undo runtime PM changes at driver exit time
      ALSA: hda: cs35l41: Fix unbalanced pm_runtime_get()
      ALSA: hda: cs35l41: Undo runtime PM changes at driver exit time

D. Wythe (3):
      net/smc: fix dangling sock under state SMC_APPFINCLOSEWAIT
      net/smc: allow cdc msg send rather than drop it with NULL sndbuf_desc
      net/smc: put sk reference if close work was canceled

Dan Carpenter (13):
      thermal: core: prevent potential string overflow
      clk: keystone: pll: fix a couple NULL vs IS_ERR() checks
      clk: ti: fix double free in of_ti_divider_clk_setup()
      clk: mediatek: fix double free in mtk_clk_register_pllfh()
      drm/rockchip: Fix type promotion bug in rockchip_gem_iommu_map()
      PCI: endpoint: Fix double free in __pci_epc_create()
      dmaengine: ti: edma: handle irq_of_parse_and_map() errors
      media: ov13b10: Fix some error checking in probe
      Input: synaptics-rmi4 - fix use after free in rmi_unregister_function()
      watchdog: marvell_gti_wdt: Fix error code in probe()
      hsr: Prevent use after free in prp_create_tagged_frame()
      fbdev: imsttfb: fix double free in probe()
      fbdev: imsttfb: fix a resource leak in probe

Dan Williams (10):
      cxl/pci: Remove unnecessary device reference management in sanitize work
      cxl/pci: Cleanup 'sanitize' to always poll
      cxl/pci: Remove inconsistent usage of dev_err_probe()
      cxl/pci: Clarify devm host for memdev relative setup
      cxl/pci: Fix sanitize notifier setup
      cxl/memdev: Fix sanitize vs decoder setup locking
      cxl/mem: Fix shutdown order
      virt: sevguest: Fix passing a stack buffer as a scatterlist target
      cxl/port: Fix @host confusion in cxl_dport_setup_regs()
      cxl/hdm: Remove broken error path

Daniel Mentz (1):
      scsi: ufs: core: Leave space for '\0' in utf8 desc string

Danila Tikhonov (1):
      clk: qcom: gcc-sm8150: Fix gcc_sdcc2_apps_clk_src

Danny Kaehn (2):
      hid: cp2112: Fix duplicate workqueue initialization
      hid: cp2112: Fix IRQ shutdown stopping polling for all IRQs on chip

Dario Binacchi (1):
      ARM: dts: stm32: stm32f7-pinctrl: don't use multiple blank lines

Dave Ertman (1):
      ice: Fix SRIOV LAG disable on non-compliant aggregate

David Heidelberg (2):
      arm64: dts: qcom: sdm845: Fix PSCI power domain names
      arm64: dts: qcom: sdm845: cheza doesn't support LMh node

David Howells (2):
      iov_iter, x86: Be consistent about the __user tag on copy_mc_to_user()
      rxrpc: Fix two connection reaping bugs

Devi Priya (1):
      clk: qcom: clk-rcg2: Fix clock rate overflow for high parent frequencies

Dhruva Gole (1):
      firmware: ti_sci: Mark driver as non removable

Dinghao Liu (2):
      mfd: dln2: Fix double put in dln2_probe
      i3c: Fix potential refcount leak in i3c_master_register_new_i3c_devs

Diogo Ivo (1):
      net: ti: icss-iep: fix setting counter value

Dirk Behme (1):
      clk: renesas: rcar-gen3: Extend SDnH divider table

Dmitry Antipov (1):
      wifi: rtlwifi: fix EDCA limit set by BT coexistence

Dmitry Baryshkov (8):
      drm/bridge: lt9611uxc: fix the race in the error path
      drm/msm/dsi: use msm_gem_kernel_put to free TX buffer
      drm/msm/dsi: free TX buffer in unbind
      arm64: dts: qcom: sc7280: link usb3_phy_wrapper_gcc_usb30_pipe_clk
      arm64: dts: qcom: sm8150: add ref clock to PCIe PHYs
      arm64: dts: qcom: sm8350: fix pinctrl for UART18
      arm64: dts: qcom: sdm845-mtp: fix WiFi configuration
      soc: qcom: pmic_glink: fix connector type to be DisplayPort

Dominique Martinet (1):
      Revert "mmc: core: Capture correct oemid-bits for eMMC cards"

Doug Berger (1):
      rtc: brcmstb-waketimer: support level alarm_irq

Douglas Anderson (1):
      drm: Call drm_atomic_helper_shutdown() at shutdown/remove time for misc drivers

Dragos Bogdan (1):
      hwmon: (axi-fan-control) Fix possible NULL pointer dereference

Emmanuel Grumbach (1):
      wifi: iwlwifi: honor the enable_ini value

Eric Dumazet (19):
      udp: introduce udp->udp_flags
      udp: move udp->no_check6_tx to udp->udp_flags
      udp: move udp->no_check6_rx to udp->udp_flags
      udp: move udp->gro_enabled to udp->udp_flags
      udp: add missing WRITE_ONCE() around up->encap_rcv
      udp: move udp->accept_udp_{l4|fraglist} to udp->udp_flags
      udp: lockless UDP_ENCAP_L2TPINUDP / UDP_GRO
      udp: annotate data-races around udp->encap_type
      udplite: remove UDPLITE_BIT
      udplite: fix various data-races
      tcp_metrics: add missing barriers on delete
      tcp_metrics: properly set tp->snd_ssthresh in tcp_init_metrics()
      tcp_metrics: do not create an entry from tcp_init_metrics()
      chtls: fix tp->rcv_tstamp initialization
      tcp: fix cookie_init_timestamp() overflows
      virtio_net: use u64_stats_t infra to avoid data-races
      net: add DEV_STATS_READ() helper
      ipvlan: properly track tx_errors
      inet: shrink struct flowi_common

Erik Kurzinger (1):
      drm/syncobj: fix DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE

Eugen Hristev (1):
      ASoC: mediatek: mt8186_mt6366_rt1019_rt5682s: trivial: fix error messages

Fabio Estevam (2):
      arm64: dts: imx8qm-ss-img: Fix jpegenc compatible entry
      arm64: dts: imx8mp-debix-model-a: Remove USB hub reset-gpios

Fei Shao (1):
      media: mtk-jpegenc: Fix bug in JPEG encode quality selection

Felipe Negrelli Wolter (1):
      wifi: wfx: fix case where rates are out of order

Felix Fietkau (4):
      wifi: mt76: mt7603: rework/fix rx pse hang check
      wifi: mt76: mt7603: improve watchdog reset reliablity
      wifi: mt76: mt7603: improve stuck beacon handling
      wifi: mt76: remove unused error path in mt76_connac_tx_complete_skb

Fenghua Yu (1):
      dmaengine: idxd: Register dsa_bus_type before registering idxd sub-drivers

Filipe Manana (1):
      btrfs: use u64 for buffer sizes in the tree search ioctls

Filippo Storniolo (1):
      vsock/virtio: remove socket from connected/bound list on shutdown

Florent Revest (1):
      kselftest: vm: fix mdwe's mmap_FIXED test case

Florian Fainelli (1):
      pwm: brcmstb: Utilize appropriate clock APIs in suspend/resume

Florian Westphal (1):
      netfilter: nat: fix ipv6 nat redirect with mapped and scoped addresses

Francesco Dolcini (1):
      arm64: dts: ti: verdin-am62: disable MIPI DSI bridge

Frederic Weisbecker (1):
      srcu: Fix callbacks acceleration mishandling

Furong Xu (1):
      net: stmmac: xgmac: Enable support for multiple Flexible PPS outputs

Gabriel Krisman Bertazi (2):
      io_uring/kbuf: Fix check of BID wrapping in provided buffers
      io_uring/kbuf: Allow the full buffer id space for provided buffers

Gao Xiang (1):
      erofs: fix erofs_insert_workgroup() lockref usage

Gaurav Jain (2):
      crypto: caam/qi2 - fix Chacha20 + Poly1305 self test failure
      crypto: caam/jr - fix Chacha20 + Poly1305 self test failure

Gaurav Kohli (2):
      arm64: dts: qcom: msm8916: Fix iommu local address range
      arm64: dts: qcom: msm8939: Fix iommu local address range

Geert Uytterhoeven (4):
      drm/ssd130x: Fix screen clearing
      ARM: dts: renesas: blanche: Fix typo in GP_11_2 pin name
      sh: bios: Revive earlyprintk support
      riscv: boot: Fix creation of loader.bin

Geetha sowjanya (1):
      octeontx2-pf: Free pending and dropped SQEs

Geliang Tang (2):
      selftests: mptcp: run userspace pm tests slower
      selftests: mptcp: fix wait_rm_addr/sf parameters

George Kennedy (1):
      IB/mlx5: Fix init stage error handling to avoid double free of same QP and UAF

George Shuklin (1):
      tg3: power down device only on SYSTEM_POWER_OFF

Georgia Garcia (1):
      apparmor: fix invalid reference on profile->disconnected

Giovanni Cabiddu (10):
      crypto: qat - fix state machines cleanup paths
      crypto: qat - ignore subsequent state up commands
      crypto: qat - fix unregistration of crypto algorithms
      crypto: qat - fix unregistration of compression algorithms
      crypto: qat - increase size of buffers
      crypto: qat - consolidate services structure
      crypto: qat - refactor fw config related functions
      crypto: qat - use masks for AE groups
      crypto: qat - fix ring to service map for QAT GEN4
      crypto: qat - fix deadlock in backlog processing

Gou Hao (1):
      ext4: move 'ix' sanity check to corrent position

Greg Kroah-Hartman (1):
      Linux 6.6.2

Guenter Roeck (2):
      Revert "hwmon: (sch56xx-common) Add DMI override table"
      Revert "hwmon: (sch56xx-common) Add automatic module loading on supported devices"

Guoniu.zhou (1):
      media: ov5640: fix vblank unchange issue when work at dvp mode

Gustavo A. R. Silva (7):
      gve: Use size_add() in call to struct_size()
      mlxsw: Use size_mul() in call to struct_size()
      tls: Use size_add() in call to struct_size()
      tipc: Use size_add() in calls to struct_size()
      net: spider_net: Use size_add() in call to struct_size()
      RDMA/core: Use size_{add,sub,mul}() in calls to struct_size()
      ASoC: SOF: ipc4-topology: Use size_add() in call to struct_size()

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

Harald Freudenberger (1):
      s390/ap: re-init AP queues on config on

Haren Myneni (1):
      powerpc/vas: Limit open window failure messages in log bufffer

Harshit Mogalapalli (2):
      hte: tegra: Fix missing error code in tegra_hte_test_probe()
      drm/loongson: Fix error handling in lsdc_pixel_pll_setup()

Harshitha Prem (1):
      wifi: ath12k: fix undefined behavior with __fls in dp

Hayes Wang (1):
      r8152: break the loop when the budget is exhausted

Heiner Kallweit (3):
      r8169: fix rare issue with broken rx after link-down on RTL8125
      r8169: respect userspace disabling IFF_MULTICAST
      Revert "PCI/ASPM: Disable only ASPM_STATE_L1 when driver, disables L1"

Heng Qi (4):
      virtio-net: fix mismatch of getting tx-frames
      virtio-net: consistently save parameters for per-queue
      virtio-net: fix per queue coalescing parameter setting
      virtio-net: fix the vq coalescing setting for vq resize

Herbert Xu (2):
      KEYS: Include linux/errno.h in linux/verification.h
      certs: Break circular dependency when selftest is modular

Herve Codina (1):
      mfd: core: Ensure disabled devices are skipped without aborting

Hou Tao (1):
      bpf: Check map->usercnt after timer->timer is assigned

Howard Hsu (2):
      wifi: mt76: mt7996: fix beamform mcu cmd configuration
      wifi: mt76: mt7996: fix beamformee ss subfield in EHT PHY cap

Hui Wang (1):
      ASoC: fsl-asoc-card: Add comment for mclk in the codec_priv

Ian Rogers (9):
      perf stat: Fix aggr mode initialization
      perf parse-events: Fix tracepoint name memory leak
      perf parse-events: Fix for term values that are raw events
      perf mem-events: Avoid uninitialized read
      perf machine: Avoid out of bounds LBR memory read
      libperf rc_check: Make implicit enabling work for GCC
      perf hist: Add missing puts to hist__account_cycles
      perf vendor events intel: Fix broadwellde tma_info_system_dram_bw_use metric
      perf vendor events intel: Add broadwellde two metrics

Ilan Peer (4):
      wifi: mac80211: Fix setting vif links
      wifi: iwlwifi: mvm: Correctly set link configuration
      wifi: iwlwifi: mvm: Fix key flags for IGTK on AP interface
      wifi: iwlwifi: mvm: Don't always bind/link the P2P Device interface

Ilkka Koskinen (2):
      perf vendor events arm64: Fix for AmpereOne metrics
      arm64/arm: arm_pmuv3: perf: Don't truncate 64-bit registers

Ilpo Järvinen (2):
      selftests/resctrl: Ensure the benchmark commands fits to its array
      PCI: vmd: Correct PCI Header Type Register's multi-function check

Irui Wang (1):
      media: mediatek: vcodec: Handle invalid encoder vsi

Iulia Tanasescu (1):
      Bluetooth: ISO: Pass BIG encryption info through QoS

Ivaylo Dimitrov (1):
      drivers/clocksource/timer-ti-dm: Don't call clk_get_rate() in stop function

Jacob Keller (1):
      ice: fix pin assignment for E810-T without SMA control

Jai Luthra (2):
      drm: bridge: it66121: Fix invalid connector dereference
      arm64: dts: ti: k3-am62a7-sk: Drop i2c-1 to 100Khz

Jason Gunthorpe (1):
      iommufd: Add iopt_area_alloc()

Jason-JH.Lin (4):
      drm/mediatek: Fix coverity issue with unintentional integer overflow
      drm/mediatek: Add mmsys_dev_num to mt8188 vdosys0 driver data
      drm/mediatek: Fix iommu fault by swapping FBs after updating plane state
      drm/mediatek: Fix iommu fault during crtc enabling

Javier Carrasco (1):
      rtc: pcf85363: fix wrong mask/val parameters in regmap_update_bits call

Jens Axboe (1):
      io_uring/net: ensure socket is marked connected on connect retry

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

Jinjie Ruan (10):
      wifi: rtw88: debug: Fix the NULL vs IS_ERR() bug for debugfs_create_file()
      wifi: rtw88: Remove duplicate NULL check before calling usb_kill/free_urb()
      kunit: Fix missed memory release in kunit_free_suite_set()
      kunit: Fix the wrong kfree of copy for kunit_filter_suites()
      kunit: Fix possible memory leak in kunit_filter_suites()
      kunit: test: Fix the possible memory leak in executor_test
      HID: uclogic: Fix user-memory-access bug in uclogic_params_ugee_v2_init_event_hooks()
      HID: uclogic: Fix a work->entry not empty bug in __queue_work()
      iio: frequency: adf4350: Use device managed functions and fix power down issue.
      misc: st_core: Do not call kfree_skb() under spin_lock_irqsave()

Johannes Berg (18):
      wifi: cfg80211: add flush functions for wiphy work
      wifi: mac80211: move radar detect work to wiphy work
      wifi: mac80211: move scan work to wiphy work
      wifi: mac80211: move offchannel works to wiphy work
      wifi: mac80211: move sched-scan stop work to wiphy work
      wifi: mac80211: fix RCU usage warning in mesh fast-xmit
      wifi: cfg80211: fix off-by-one in element defrag
      wifi: mac80211: fix # of MSDU in A-MSDU calculation
      wifi: cfg80211: fix kernel-doc for wiphy_delayed_work_flush()
      wifi: mac80211: fix check for unusable RX result
      wifi: iwlwifi: mvm: use correct sta ID for IGTK/BIGTK
      wifi: mac80211: don't recreate driver link debugfs in reconfig
      wifi: iwlwifi: mvm: change iwl_mvm_flush_sta() API
      wifi: iwlwifi: mvm: fix iwl_mvm_mac_flush_sta()
      wifi: iwlwifi: mvm: remove TDLS stations from FW
      wifi: iwlwifi: increase number of RX buffers for EHT devices
      wifi: iwlwifi: mvm: fix netif csum flags
      wifi: iwlwifi: pcie: synchronize IRQs before NAPI

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

Josh Poimboeuf (4):
      x86/srso: Fix SBPB enablement for (possible) future fixed HW
      x86/srso: Print mitigation for retbleed IBPB case
      x86/srso: Fix vulnerability reporting for missing microcode
      x86/srso: Fix unret validation dependencies

Juergen Gross (1):
      xenbus: fix error exit in xenbus_init()

Junhao He (1):
      perf: hisi: Fix use-after-free when register pmu fails

Junxian Huang (2):
      RDMA/hns: Fix unnecessary port_num transition in HW stats allocation
      RDMA/hns: Fix init failure of RoCE VF and HIP08

Kai Huang (1):
      x86/tdx: Zero out the missing RSI in TDX_HYPERCALL macro

Kailang Yang (1):
      ALSA: hda/realtek: Add support dual speaker for Dell

Kajol Jain (2):
      tools/perf: Update call stack check in builtin-lock.c
      perf vendor events: Update PMC used in PM_RUN_INST_CMPL event for power10 platform

Kathiravan Thirumoorthy (3):
      clk: qcom: ipq5018: drop the CLK_SET_RATE_PARENT flag from GPLL clocks
      clk: qcom: ipq9574: drop the CLK_SET_RATE_PARENT flag from GPLL clocks
      clk: qcom: ipq5332: drop the CLK_SET_RATE_PARENT flag from GPLL clocks

Katya Orlova (1):
      media: s3c-camif: Avoid inappropriate kfree()

Kees Cook (1):
      string: Adjust strtomem() logic to allow for smaller sources

Konrad Dybcio (20):
      clk: qcom: gcc-msm8996: Remove RPM bus clocks
      clk: qcom: mmcc-msm8998: Don't check halt bit on some branch clks
      clk: qcom: mmcc-msm8998: Fix the SMMU GDSC
      drm/msm/adreno: Fix SM6375 GPU ID
      drm/msm/a6xx: Fix unknown speedbin case
      arm64: dts: qcom: sc7280: Add missing LMH interrupts
      arm64: dts: qcom: qrb2210-rb1: Swap UART index
      arm64: dts: qcom: qrb2210-rb1: Fix regulators
      arm64: dts: qcom: sdm670: Fix pdc mapping
      interconnect: qcom: qdu1000: Set ACV enable_mask
      interconnect: qcom: sc7180: Set ACV enable_mask
      interconnect: qcom: sc7280: Set ACV enable_mask
      interconnect: qcom: sc8180x: Set ACV enable_mask
      interconnect: qcom: sc8280xp: Set ACV enable_mask
      interconnect: qcom: sdm670: Set ACV enable_mask
      interconnect: qcom: sdm845: Set ACV enable_mask
      interconnect: qcom: sm6350: Set ACV enable_mask
      interconnect: qcom: sm8150: Set ACV enable_mask
      interconnect: qcom: sm8250: Set ACV enable_mask
      interconnect: qcom: sm8350: Set ACV enable_mask

Konstantin Meskhidze (1):
      drm/radeon: possible buffer overflow

Krzysztof Kozlowski (4):
      arm64: dts: qcom: msm8992-libra: drop duplicated reserved memory
      arm64: dts: qcom: sc7280: drop incorrect EUD port on SoC side
      arm64: dts: qcom: sdx75-idp: align RPMh regulator nodes with bindings
      ARM: dts: qcom: mdm9615: populate vsdcc fixed regulator

Kumar Kartikeya Dwivedi (2):
      bpf: Fix kfunc callback register type handling
      selftests/bpf: Make linked_list failure test more robust

Kuninori Morimoto (2):
      ASoC: fsl: mpc5200_dma.c: Fix warning of Function parameter or member not described
      ASoC: ams-delta.c: use component after check

Kuniyuki Iwashima (2):
      dccp: Call security_inet_conn_request() after setting IPv4 addresses.
      dccp/tcp: Call security_inet_conn_request() after setting IPv6 addresses.

Kunwu.Chan (1):
      drm/amd/pm: Fix a memory leak on an error path

Kursad Oney (1):
      ARM: 9321/1: memset: cast the constant byte to unsigned char

Lalith Rajendran (1):
      platform/chrome: cros_ec_lpc: Separate host command and irq disable

Laurent Pinchart (3):
      media: i2c: imx219: Convert to CCI register access helpers
      media: i2c: imx219: Replace register addresses with macros
      media: i2c: imx219: Drop IMX219_REG_CSI_LANE_MODE from common regs array

Leon Hwang (2):
      selftests/bpf: Correct map_fd to data_fd in tailcalls
      bpf, x64: Fix tailcall infinite loop

Leon Romanovsky (1):
      RDMA/hfi1: Workaround truncation compilation error

Li Lingfeng (1):
      nbd: fix uaf in nbd_open

Li Zhijian (1):
      cxl/region: Fix cxl_region_rwsem lock held when returning to user space

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

Marcin Szycik (1):
      ice: Fix VF-VF direction matching in drop rule in switchdev

Marek Behún (1):
      leds: turris-omnia: Do not use SMBUS calls

Marek Marczykowski-Górecki (1):
      xen-pciback: Consider INTx disabled when MSI/MSI-X is enabled

Marek Szyprowski (2):
      drm: bridge: samsung-dsim: Fix waiting for empty cmd transfer FIFO on older Exynos
      media: cec: meson: always include meson sub-directory in Makefile

Marek Vasut (3):
      drm: bridge: samsung-dsim: Initialize ULPS EXIT for i.MX8M DSIM
      media: hantro: Check whether reset op is defined before use
      media: verisilicon: Do not enable G2 postproc downscale if source is narrower than destination

Marijn Suijten (1):
      arm64: dts: qcom: sm6125: Pad APPS IOMMU address to 8 characters

Mario Limonciello (5):
      crypto: ccp - Get a free page to use while fetching initial nonce
      crypto: ccp - Fix ioctl unit tests
      crypto: ccp - Fix DBC sample application error handling
      crypto: ccp - Fix sample application signature passing
      crypto: ccp - Fix some unfused tests

Mark Rutland (1):
      arm64/arm: xen: enlighten: Fix KPTI checks

Markus Schneider-Pargmann (1):
      thermal/drivers/mediatek: Fix probe for THERMAL_V2

Masahiro Yamada (2):
      modpost: fix tee MODULE_DEVICE_TABLE built on big-endian host
      modpost: fix ishtp MODULE_DEVICE_TABLE built on big-endian host

Matti Lehtimäki (1):
      ARM: dts: qcom: apq8026-samsung-matisse-wifi: Fix inverted hall sensor

Matti Vaittinen (1):
      tools: iio: iio_generic_buffer ensure alignment

Maxime Ripard (1):
      drm/vc4: tests: Fix UAF in the mock helpers

MeiChia Chiu (2):
      wifi: mt76: update beacon size limitation
      wifi: mt76: mt7915: fix beamforming availability check

Michael Ellerman (1):
      powerpc: Hide empty pt_regs at base of the stack

Michal Schmidt (1):
      ice: lag: in RCU, use atomic allocation

Michał Mirosław (3):
      mfd: core: Un-constify mfd_cell.of_reg
      usb: chipidea: Fix DMA overwrite for Tegra
      usb: chipidea: Simplify Tegra DMA alignment code

Michel Dänzer (3):
      drm/amd/display: Check all enabled planes in dm_check_crtc_cursor
      drm/amd/display: Refactor dm_get_plane_scale helper
      drm/amd/display: Bail from dm_check_crtc_cursor if no relevant change

Mike Tipton (1):
      debugfs: Fix __rcu type comparison warning

Ming Qian (3):
      media: imx-jpeg: initiate a drain of the capture queue in dynamic resolution change
      media: amphion: handle firmware debug message
      media: imx-jpeg: notify source chagne event when the first picture parsed

Miri Korenblit (2):
      wifi: iwlwifi: don't use an uninitialized variable
      wifi: iwlwifi: empty overflow queue during flush

Moudy Ho (1):
      media: platform: mtk-mdp3: fix uninitialized variable in mdp_path_config()

Namhyung Kim (2):
      perf record: Fix BTF type checks in the off-cpu profiling
      perf tools: Do not ignore the default vmlinux.h

Naresh Solanki (1):
      hwmon: (pmbus/mp2975) Move PGOOD fix

NeilBrown (1):
      Fix termination state for idr_for_each_entry_ul()

Nícolas F. R. A. Prado (1):
      thermal: core: Don't update trip points inside the hysteresis range

Ondrej Zary (1):
      ACPI: video: Add acpi_backlight=vendor quirk for Toshiba Portégé R100

Paolo Abeni (1):
      mptcp: properly account fastopen data

Patrick Thompson (1):
      net: r8169: Disable multicast filter for RTL8168H and RTL8107E

Patrisious Haddad (1):
      IB/mlx5: Fix rdma counter binding for RAW QP

Paul E. McKenney (1):
      x86/nmi: Fix out-of-order NMI nesting checks & false positive warning

Peng Fan (1):
      clk: imx: imx8mq: correct error handling path

Peter Chiu (4):
      wifi: mt76: mt7996: set correct wcid in txp
      wifi: mt76: mt7996: fix wmm queue mapping
      wifi: mt76: mt7996: fix rx rate report for CBW320-2
      wifi: mt76: mt7996: fix TWT command format

Peter Zijlstra (2):
      sched: Fix stop_one_cpu_nowait() vs hotplug
      perf: Optimize perf_cgroup_switch()

Phil Sutter (2):
      netfilter: nf_tables: Drop pointless memset when dumping rules
      net: skb_find_text: Ignore patterns extending past 'to'

Philip Yang (3):
      drm/amdgpu: Increase IH soft ring size for GFX v9.4.3 dGPU
      drm/amdkfd: Remove svm range validated_once flag
      drm/amdkfd: Handle errors from svm validate and map

Pratyush Yadav (1):
      media: cadence: csi2rx: Unregister v4l2 async notifier

Qais Yousef (2):
      sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is 0
      sched/uclamp: Ignore (util == 0) optimization in feec() when p_util_max = 0

Qu Wenruo (1):
      btrfs: make found_logical_ret parameter mandatory for function queue_scrub_stripe()

Raag Jadav (2):
      PM: sleep: Fix symbol export for _SIMPLE_ variants of _PM_OPS()
      pinctrl: baytrail: fix debounce disable case

Rafał Miłecki (1):
      ARM: dts: BCM5301X: Explicitly disable unused switch CPU ports

Randy Dunlap (2):
      clk: linux/clk-provider.h: fix kernel-doc warnings and typos
      drm: bridge: for GENERIC_PHY_MIPI_DPHY also select GENERIC_PHY

Ratheesh Kannoth (2):
      octeontx2-pf: Fix error codes
      octeontx2-pf: Fix holes in error code

Reinette Chatre (1):
      PCI/MSI: Provide stubs for IMS functions

Reuben Hawkins (1):
      vfs: fix readahead(2) on block devices

Robert Chiras (1):
      clk: imx: imx8qxp: Fix elcdif_pll clock

Robert Richter (1):
      cxl/core/regs: Rename @dev to @host in struct cxl_register_map

Robin Murphy (1):
      perf/arm-cmn: Fix DTC domain detection

Roman Bacik (1):
      i2c: iproc: handle invalid slave state

Rotem Saado (1):
      wifi: iwlwifi: yoyo: swap cdb and jacket bits values

Sascha Hauer (1):
      PM / devfreq: rockchip-dfi: Make pmu regmap mandatory

Sean Wang (3):
      wifi: mt76: move struct ieee80211_chanctx_conf up to struct mt76_vif
      wifi: mt76: mt7921: fix the wrong rate pickup for the chanctx driver
      wifi: mt76: mt7921: fix the wrong rate selected in fw for the chanctx driver

Sebastian Andrzej Siewior (1):
      powerpc/imc-pmu: Use the correct spinlock initializer.

Sergey Shtylyov (1):
      usb: host: xhci-plat: fix possible kernel oops while resuming

Sergio Paracuellos (1):
      clk: ralink: mtmips: quiet unused variable warning

Shayne Chen (1):
      wifi: mt76: fix per-band IEEE80211_CONF_MONITOR flag comparison

Shigeru Yoshida (2):
      tipc: Change nla_policy for bearer-related names to NLA_NUL_STRING
      virtio/vsock: Fix uninit-value in virtio_transport_recv_pkt()

Shuming Fan (1):
      ASoC: rt712-sdca: fix speaker route missing issue

Siddharth Vadapalli (1):
      arm64: dts: ti: k3-j721s2-evm-gesi: Specify base dtb for overlay file

Song Liu (1):
      bpf: Fix unnecessary -EBUSY from htab_lock_bucket

Srinivasan Shanmugam (1):
      drm/radeon: Remove the references of radeon_gem_ pread & pwrite ioctls

StanleyYP Wang (1):
      wifi: mt76: get rid of false alamrs of tx emission issues

Stefan Wahren (1):
      hwrng: bcm2835 - Fix hwrng throughput regression

Stephan Gerhold (1):
      arm64: dts: qcom: apq8016-sbc: Add missing ADV7533 regulators

Steven Rostedt (Google) (1):
      eventfs: Check for NULL ef in eventfs_set_attr()

Sudeep Holla (3):
      firmware: arm_ffa: Assign the missing IDR allocation ID to the FFA device
      firmware: arm_ffa: Allow the FF-A drivers to use 32bit mode of messaging
      clk: scmi: Free scmi_clk allocated when the clocks with invalid info are skipped

Sumit Gupta (2):
      cpufreq: tegra194: fix warning due to missing opp_put
      firmware: tegra: Add suspend hook and reset BPMP IPC early on resume

Theodore Ts'o (1):
      ext4: add missing initialization of call_notify_error in update_super_work()

Thierry Reding (2):
      memory: tegra: Set BPMP msg flags to reset IPC channels
      arm64: tegra: Use correct interrupts for Tegra234 TKE

Thomas Gleixner (2):
      cpu/SMT: Make SMT control more robust against enumeration failures
      x86/apic: Fake primary thread mask for XEN/PV

Thomas Richter (1):
      perf trace: Use the right bpf_probe_read(_str) variant for reading user data

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

Trond Myklebust (1):
      nfsd: Handle EOPENSTALE correctly in the filecache

Tyrel Datwyler (1):
      scsi: ibmvfc: Fix erroneous use of rtas_busy_delay with hcall return code

Uwe Kleine-König (4):
      soc: qcom: llcc: Handle a second device without data corruption
      backlight: pwm_bl: Disable PWM on shutdown, suspend and remove
      leds: pwm: Don't disable the PWM when the LED should be off
      pwm: sti: Reduce number of allocations and drop usage of chip_data

Vaishnav Achath (1):
      spi: omap2-mcspi: Fix hardcoded reference clock

Varadarajan Narayanan (5):
      clk: qcom: ipq5332: Drop set rate parent from gpll0 dependent clocks
      clk: qcom: config IPQ_APSS_6018 should depend on QCOM_SMEM
      clk: qcom: clk-alpha-pll: introduce stromer plus ops
      clk: qcom: apss-ipq-pll: Use stromer plus ops for stromer plus pll
      clk: qcom: apss-ipq-pll: Fix 'l' value for ipq5332_pll_config

Vegard Nossum (1):
      cpupower: fix reference to nonexistent document

Vincent Mailhol (2):
      can: etas_es58x: rework the version check logic to silence -Wformat-truncation
      can: etas_es58x: add missing a blank line after declaration

Viresh Kumar (2):
      xen: Make struct privcmd_irqfd's layout architecture independent
      xen: irqfd: Use _IOW instead of the internal _IOC() macro

Vlad Buslov (1):
      net/sched: act_ct: Always fill offloading tuple iifidx

Vladimir Oltean (1):
      net: enetc: shorten enetc_setup_xdp_prog() error message to fit NETLINK_MAX_FMTMSG_LEN

Wadim Egorov (1):
      arm64: dts: ti: k3-am625-beagleplay: Fix typo in ramoops reg

Waiman Long (1):
      cgroup/cpuset: Fix load balance state in update_partition_sd_lb()

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

Yafang Shao (1):
      bpf: Fix missed rcu read lock in bpf_task_under_cgroup()

Yan Zhai (1):
      ipv6: avoid atomic fragment on GSO packets

Yang Jihong (3):
      perf kwork: Fix incorrect and missing free atom in work_push_atom()
      perf kwork: Add the supported subcommands to the document
      perf kwork: Set ordered_events to true in 'struct perf_tool'

Yang Yingliang (5):
      spi: omap2-mcspi: switch to use modern name
      interconnect: fix error handling in qnoc_probe()
      pcmcia: cs: fix possible hung task and memory leak pccardd()
      pcmcia: ds: fix refcount leak in pcmcia_device_add()
      pcmcia: ds: fix possible name leak in error path in pcmcia_device_add()

Yazen Ghannam (1):
      x86/amd_nb: Use Family 19h Models 60h-7Fh Function 4 IDs

Yedidya Benshimol (1):
      wifi: iwlwifi: mvm: update IGTK in mvmvif upon D3 resume

Yi Yang (1):
      tty: tty_jobctrl: fix pid memleak in disassociate_ctty()

Yicong Yang (1):
      drivers/perf: hisi_pcie: Check the type first in pmu::event_init()

Yu Kuai (1):
      blk-core: use pr_warn_ratelimited() in bio_check_ro()

Yujie Liu (1):
      tracing/kprobes: Fix the order of argument descriptions

Yunfei Dong (1):
      media: mediatek: vcodec: using encoder device to alloc/free encoder memory

Yuntao Wang (1):
      x86/boot: Fix incorrect startup_gdt_descr.size

Yury Norov (3):
      numa: Generalize numa_map_to_online_node()
      sched/topology: Fix sched_numa_find_nth_cpu() in CPU-less case
      sched/topology: Fix sched_numa_find_nth_cpu() in non-NUMA case

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

Ziyang Xuan (1):
      Bluetooth: Make handle of hci_conn be unique

wahrenst (1):
      ARM: 9323/1: mm: Fix ARCH_LOW_ADDRESS_LIMIT when CONFIG_ZONE_DMA

