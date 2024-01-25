Return-Path: <linux-kernel+bounces-39437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D4483D11A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE39BB27022
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CD113BE91;
	Thu, 25 Jan 2024 23:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HTj3fekC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D54B13B7AF;
	Thu, 25 Jan 2024 23:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706227070; cv=none; b=Ws4bcXgPpUsueGK2aKhhHyI1ddIXlgOAXpMhBlG1xErSxL3Q7mkg81hZ+FT5k17L+1OsLnvteVx2y30T0w69MFM+uTzbE/gW+6P3j2395Pb3LrYcdicUB7FoKXvCirAjYIaEBjnQDMIUPLIuH4xtWtxsMogYM7bLPvMuifnhTq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706227070; c=relaxed/simple;
	bh=cSbJT+IZY1kwJPiv2T/kPLV0qjgf/Z9OfyN1PBoFmmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ls//Ne6I1LZ6sUumemfWak71qkQXOsiRmpvsGF2cCokuF5r4Cjx/HX9dg5XDaTxAZ7cPZC56Y3lw09I7SqkXlFVV2hAVt9HzH2fNxl68oy+hUt3gfMe6IOT7cWMn53rj8hEDzyqdpBnPG9hYrl5IxfkQGDmZOxOBbizULeNzgY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HTj3fekC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262B0C43399;
	Thu, 25 Jan 2024 23:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706227070;
	bh=cSbJT+IZY1kwJPiv2T/kPLV0qjgf/Z9OfyN1PBoFmmc=;
	h=From:To:Cc:Subject:Date:From;
	b=HTj3fekCbbRJnJwkLeq9Z2TFf7F79m9MrCoVfhSRetIU0kaRmOzhf5hsYfklSGuUv
	 iepbGKJaCgE5Oh9xrtNJJnPY1YbgFYo1yN47gmk+x2VDvh55meis4qLNhiG7wo0bi+
	 RVvw6lEgDlaQxg1ihc0jAcOyzvrR97d8xdidsios=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.75
Date: Thu, 25 Jan 2024 15:57:46 -0800
Message-ID: <2024012547-width-recede-0063@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.75 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml      |    2 
 Documentation/devicetree/bindings/media/mediatek,mdp3-rdma.yaml   |   29 -
 Documentation/devicetree/bindings/media/mediatek,mdp3-wrot.yaml   |   23 
 Documentation/devicetree/bindings/media/rockchip-isp1.yaml        |   11 
 Documentation/driver-api/pci/p2pdma.rst                           |   16 
 Makefile                                                          |    2 
 arch/arm/boot/dts/qcom-apq8064.dtsi                               |    2 
 arch/arm/boot/dts/qcom-sdx65.dtsi                                 |    2 
 arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts                        |    2 
 arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts                        |    2 
 arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts                        |    2 
 arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts                        |    3 
 arch/arm/mach-davinci/Kconfig                                     |    2 
 arch/arm64/boot/dts/freescale/imx8mm.dtsi                         |    4 
 arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi                  |    3 
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts            |    2 
 arch/arm64/boot/dts/mediatek/mt8183.dtsi                          |    6 
 arch/arm64/boot/dts/qcom/ipq6018.dtsi                             |   73 +-
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts                          |    2 
 arch/arm64/boot/dts/qcom/sc7180.dtsi                              |    2 
 arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi                |   24 
 arch/arm64/boot/dts/qcom/sc7280.dtsi                              |   20 
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi                            |    2 
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts                        |    2 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                              |    2 
 arch/arm64/boot/dts/qcom/sm6350.dtsi                              |    2 
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts                           |   12 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                              |    2 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                              |    2 
 arch/arm64/boot/dts/qcom/sm8350.dtsi                              |    4 
 arch/arm64/boot/dts/renesas/r8a779g0-white-hawk-cpu.dtsi          |    3 
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi                         |    4 
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi                          |    2 
 arch/arm64/kvm/vgic/vgic-its.c                                    |    5 
 arch/arm64/kvm/vgic/vgic-mmio-v3.c                                |   27 
 arch/csky/include/asm/jump_label.h                                |    5 
 arch/loongarch/include/asm/elf.h                                  |    5 
 arch/loongarch/kernel/elf.c                                       |    5 
 arch/loongarch/kernel/process.c                                   |    1 
 arch/loongarch/net/bpf_jit.c                                      |    5 
 arch/mips/alchemy/devboards/db1200.c                              |    2 
 arch/mips/alchemy/devboards/db1550.c                              |    2 
 arch/mips/include/asm/dmi.h                                       |    2 
 arch/mips/kernel/setup.c                                          |    4 
 arch/mips/kernel/smp.c                                            |    4 
 arch/powerpc/Kconfig                                              |    1 
 arch/powerpc/Makefile                                             |   17 
 arch/powerpc/lib/Makefile                                         |    4 
 arch/powerpc/perf/imc-pmu.c                                       |    6 
 arch/powerpc/platforms/44x/Kconfig                                |    1 
 arch/powerpc/platforms/powernv/opal-irqchip.c                     |    2 
 arch/powerpc/platforms/powernv/opal-powercap.c                    |    6 
 arch/powerpc/platforms/powernv/opal-xscom.c                       |    5 
 arch/powerpc/platforms/pseries/hotplug-memory.c                   |    9 
 arch/riscv/include/asm/sections.h                                 |    1 
 arch/riscv/include/asm/xip_fixup.h                                |    2 
 arch/riscv/kernel/module.c                                        |    3 
 arch/riscv/kernel/patch.c                                         |   11 
 arch/riscv/kernel/vmlinux-xip.lds.S                               |    2 
 arch/riscv/kernel/vmlinux.lds.S                                   |    2 
 arch/riscv/mm/pageattr.c                                          |  275 ++++++++--
 arch/s390/include/asm/pci_io.h                                    |   32 -
 arch/s390/pci/pci_mmio.c                                          |   12 
 arch/x86/kernel/cpu/mce/inject.c                                  |    1 
 arch/x86/kernel/kvmclock.c                                        |   12 
 arch/x86/lib/misc.c                                               |    2 
 block/bio.c                                                       |   38 -
 block/blk-mq.c                                                    |   16 
 block/blk-settings.c                                              |    2 
 block/genhd.c                                                     |    5 
 block/ioctl.c                                                     |   11 
 crypto/af_alg.c                                                   |   14 
 crypto/scompress.c                                                |    6 
 drivers/acpi/acpi_extlog.c                                        |    7 
 drivers/acpi/acpi_lpit.c                                          |    2 
 drivers/acpi/acpi_lpss.c                                          |    3 
 drivers/acpi/acpi_video.c                                         |   12 
 drivers/acpi/property.c                                           |    4 
 drivers/android/binder_alloc.c                                    |   22 
 drivers/base/node.c                                               |    9 
 drivers/base/swnode.c                                             |    3 
 drivers/block/loop.c                                              |   52 -
 drivers/block/null_blk/main.c                                     |   13 
 drivers/bluetooth/btmtkuart.c                                     |   11 
 drivers/clk/clk-si5341.c                                          |    4 
 drivers/clk/qcom/gpucc-sm8150.c                                   |    4 
 drivers/clk/qcom/videocc-sm8150.c                                 |    5 
 drivers/clk/renesas/rzg2l-cpg.c                                   |   91 ++-
 drivers/clk/zynqmp/clk-mux-zynqmp.c                               |    2 
 drivers/clk/zynqmp/divider.c                                      |   66 --
 drivers/clocksource/timer-ti-dm.c                                 |    4 
 drivers/cpufreq/cpufreq-dt-platdev.c                              |    2 
 drivers/cpufreq/imx-cpufreq-dt.c                                  |    2 
 drivers/cpufreq/imx6q-cpufreq.c                                   |    4 
 drivers/cpufreq/scmi-cpufreq.c                                    |    7 
 drivers/cpufreq/tegra20-cpufreq.c                                 |    2 
 drivers/crypto/ccp/ccp-ops.c                                      |    5 
 drivers/crypto/hisilicon/hpre/hpre_main.c                         |  122 ++--
 drivers/crypto/hisilicon/qm.c                                     |   98 +++
 drivers/crypto/hisilicon/sec2/sec.h                               |    7 
 drivers/crypto/hisilicon/sec2/sec_crypto.c                        |   13 
 drivers/crypto/hisilicon/sec2/sec_main.c                          |   70 +-
 drivers/crypto/hisilicon/zip/zip_main.c                           |  175 ++++--
 drivers/crypto/inside-secure/safexcel_cipher.c                    |   19 
 drivers/crypto/sa2ul.c                                            |    3 
 drivers/crypto/sahara.c                                           |  248 +++------
 drivers/crypto/virtio/virtio_crypto_common.h                      |    2 
 drivers/crypto/virtio/virtio_crypto_core.c                        |   26 
 drivers/cxl/core/port.c                                           |    2 
 drivers/cxl/core/region.c                                         |    2 
 drivers/edac/thunderx_edac.c                                      |   10 
 drivers/firmware/meson/meson_sm.c                                 |    5 
 drivers/firmware/ti_sci.c                                         |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c                       |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                           |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c                          |    7 
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c                         |   21 
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c                        |    4 
 drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c                    |   52 -
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c                        |    5 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c               |    6 
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c               |    3 
 drivers/gpu/drm/bridge/tc358767.c                                 |    2 
 drivers/gpu/drm/bridge/ti-tpd12s015.c                             |    4 
 drivers/gpu/drm/drm_drv.c                                         |   10 
 drivers/gpu/drm/mediatek/mtk_disp_merge.c                         |    2 
 drivers/gpu/drm/mediatek/mtk_dp.c                                 |    1 
 drivers/gpu/drm/mediatek/mtk_mdp_rdma.c                           |    3 
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c                          |    4 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                       |    4 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c                       |    6 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h                       |    4 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c                         |    6 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h                         |    3 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c                       |   20 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h                       |    8 
 drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c                         |    9 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c                             |    4 
 drivers/gpu/drm/nouveau/nv04_fence.c                              |    2 
 drivers/gpu/drm/omapdrm/omap_drv.c                                |    9 
 drivers/gpu/drm/panel/panel-elida-kd35t133.c                      |    2 
 drivers/gpu/drm/panel/panel-sitronix-st7701.c                     |    2 
 drivers/gpu/drm/panfrost/panfrost_gpu.c                           |   70 +-
 drivers/gpu/drm/radeon/r100.c                                     |    4 
 drivers/gpu/drm/radeon/r600_cs.c                                  |    4 
 drivers/gpu/drm/radeon/radeon_display.c                           |    7 
 drivers/gpu/drm/radeon/radeon_vm.c                                |    8 
 drivers/gpu/drm/radeon/si.c                                       |    4 
 drivers/gpu/drm/radeon/sumo_dpm.c                                 |    4 
 drivers/gpu/drm/radeon/trinity_dpm.c                              |    4 
 drivers/gpu/drm/tidss/tidss_dispc.c                               |   63 ++
 drivers/gpu/drm/tidss/tidss_kms.c                                 |    4 
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                               |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                                |    7 
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c                           |    8 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                               |   20 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                           |   12 
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c                               |   24 
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                               |   10 
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c                           |    3 
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c                          |   18 
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c                            |    5 
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c                           |   27 
 drivers/hid/wacom_wac.c                                           |   32 -
 drivers/i2c/busses/i2c-s3c2410.c                                  |   40 -
 drivers/iio/adc/ad7091r-base.c                                    |    6 
 drivers/iio/adc/ad9467.c                                          |  105 ++-
 drivers/iio/adc/adi-axi-adc.c                                     |   74 --
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                        |    6 
 drivers/infiniband/hw/hns/hns_roce_pd.c                           |    2 
 drivers/infiniband/hw/mthca/mthca_cmd.c                           |    4 
 drivers/infiniband/hw/mthca/mthca_main.c                          |    2 
 drivers/infiniband/ulp/iser/iscsi_iser.h                          |    2 
 drivers/infiniband/ulp/iser/iser_initiator.c                      |    5 
 drivers/infiniband/ulp/iser/iser_memory.c                         |    8 
 drivers/infiniband/ulp/iser/iser_verbs.c                          |    1 
 drivers/input/keyboard/atkbd.c                                    |   12 
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c                        |    1 
 drivers/iommu/dma-iommu.c                                         |    3 
 drivers/leds/Kconfig                                              |    1 
 drivers/md/md.c                                                   |   22 
 drivers/md/raid1.c                                                |   12 
 drivers/md/raid5.c                                                |   12 
 drivers/media/dvb-core/dvbdev.c                                   |    2 
 drivers/media/dvb-frontends/m88ds3103.c                           |    7 
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c              |    1 
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c            |    6 
 drivers/media/platform/nxp/imx-mipi-csis.c                        |    4 
 drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c               |    6 
 drivers/media/platform/verisilicon/hantro_drv.c                   |    2 
 drivers/media/platform/verisilicon/hantro_v4l2.c                  |    3 
 drivers/media/usb/cx231xx/cx231xx-core.c                          |    2 
 drivers/media/usb/pvrusb2/pvrusb2-context.c                       |    3 
 drivers/mfd/intel-lpss.c                                          |    2 
 drivers/mfd/syscon.c                                              |    4 
 drivers/misc/habanalabs/common/habanalabs_ioctl.c                 |    2 
 drivers/mmc/host/Kconfig                                          |   10 
 drivers/mtd/mtd_blkdevs.c                                         |    4 
 drivers/mtd/nand/raw/fsl_ifc_nand.c                               |    2 
 drivers/net/amt.c                                                 |    6 
 drivers/net/dsa/vitesse-vsc73xx-core.c                            |    2 
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c        |   26 
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c          |    6 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c            |    8 
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c                |    2 
 drivers/net/ethernet/renesas/ravb_main.c                          |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac.h                      |    1 
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c              |   10 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                 |    1 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c                          |    5 
 drivers/net/phy/micrel.c                                          |    1 
 drivers/net/wireless/ath/ath11k/ahb.c                             |    4 
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c                 |   11 
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                       |    2 
 drivers/net/wireless/marvell/libertas/Kconfig                     |    2 
 drivers/net/wireless/marvell/mwifiex/cfg80211.c                   |    2 
 drivers/net/wireless/marvell/mwifiex/fw.h                         |    1 
 drivers/net/wireless/marvell/mwifiex/ioctl.h                      |    1 
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c                    |    8 
 drivers/net/wireless/mediatek/mt76/eeprom.c                       |    2 
 drivers/net/wireless/mediatek/mt76/mt76.h                         |    3 
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c                  |    2 
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                   |   11 
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c                  |    4 
 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c              |    3 
 drivers/net/wireless/mediatek/mt76/sdio.c                         |   18 
 drivers/net/wireless/purelifi/plfxlc/usb.c                        |    5 
 drivers/net/wireless/realtek/rtlwifi/pci.c                        |   79 --
 drivers/net/wireless/realtek/rtlwifi/pci.h                        |    5 
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c              |   14 
 drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c        |   12 
 drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.h        |    1 
 drivers/net/wireless/realtek/rtlwifi/rtl8192ce/phy.c              |    6 
 drivers/net/wireless/realtek/rtlwifi/rtl8192ce/phy.h              |    1 
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/phy.c              |    6 
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c              |   15 
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c              |   16 
 drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c              |   15 
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c              |    5 
 drivers/net/wireless/realtek/rtlwifi/wifi.h                       |    7 
 drivers/net/wireless/realtek/rtw88/mac80211.c                     |    4 
 drivers/net/xen-netback/netback.c                                 |   44 +
 drivers/nvme/target/tcp.c                                         |   20 
 drivers/nvme/target/trace.h                                       |    5 
 drivers/of/base.c                                                 |    1 
 drivers/of/unittest-data/tests-phandle.dtsi                       |   10 
 drivers/of/unittest.c                                             |   74 +-
 drivers/pci/controller/dwc/pci-keystone.c                         |    9 
 drivers/pci/controller/dwc/pcie-designware-ep.c                   |    1 
 drivers/pci/controller/pcie-mediatek-gen3.c                       |   85 +--
 drivers/pci/controller/pcie-mediatek.c                            |   10 
 drivers/platform/x86/intel/vsec.c                                 |   46 +
 drivers/platform/x86/intel/vsec.h                                 |    7 
 drivers/power/supply/bq256xx_charger.c                            |    5 
 drivers/power/supply/cw2015_battery.c                             |    2 
 drivers/pwm/core.c                                                |    2 
 drivers/pwm/pwm-jz4740.c                                          |    7 
 drivers/pwm/pwm-stm32.c                                           |   63 +-
 drivers/scsi/fnic/fnic_debugfs.c                                  |    3 
 drivers/scsi/hisi_sas/hisi_sas_main.c                             |    4 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                            |    9 
 drivers/scsi/mpi3mr/mpi3mr_app.c                                  |   16 
 drivers/scsi/mpi3mr/mpi3mr_os.c                                   |   10 
 drivers/soc/qcom/llcc-qcom.c                                      |    8 
 drivers/spi/Kconfig                                               |    3 
 drivers/spi/spi-sh-msiof.c                                        |   17 
 drivers/spmi/spmi-mtk-pmif.c                                      |   20 
 drivers/staging/media/rkvdec/rkvdec.c                             |    3 
 drivers/target/target_core_file.c                                 |   10 
 drivers/tty/serial/8250/8250_bcm2835aux.c                         |    2 
 drivers/tty/serial/8250/8250_exar.c                               |    5 
 drivers/tty/serial/8250/8250_omap.c                               |    2 
 drivers/tty/serial/imx.c                                          |   36 -
 drivers/tty/serial/omap-serial.c                                  |   27 
 drivers/tty/serial/sc16is7xx.c                                    |    8 
 drivers/tty/serial/serial_core.c                                  |   33 -
 drivers/tty/tty.h                                                 |    2 
 drivers/tty/tty_io.c                                              |   35 -
 drivers/tty/tty_ioctl.c                                           |    2 
 drivers/ufs/core/ufshcd.c                                         |    7 
 drivers/usb/cdns3/cdns3-gadget.c                                  |  142 +++--
 drivers/usb/cdns3/cdns3-gadget.h                                  |    3 
 drivers/usb/chipidea/core.c                                       |    7 
 drivers/usb/class/cdc-acm.c                                       |    3 
 drivers/usb/dwc3/core.c                                           |   39 -
 drivers/usb/dwc3/ep0.c                                            |    5 
 drivers/usb/host/xhci-mtk.c                                       |   40 +
 drivers/usb/host/xhci-mtk.h                                       |    2 
 drivers/usb/mon/mon_bin.c                                         |    7 
 drivers/usb/phy/phy-mxs-usb.c                                     |    3 
 drivers/usb/typec/class.c                                         |    4 
 drivers/vdpa/alibaba/eni_vdpa.c                                   |    6 
 drivers/video/fbdev/core/fb_defio.c                               |    8 
 drivers/video/fbdev/imxfb.c                                       |   27 
 drivers/watchdog/bcm2835_wdt.c                                    |    3 
 drivers/watchdog/hpwdt.c                                          |    2 
 drivers/watchdog/rti_wdt.c                                        |   13 
 drivers/watchdog/watchdog_dev.c                                   |    3 
 fs/efivarfs/super.c                                               |   15 
 fs/erofs/zdata.c                                                  |    5 
 fs/f2fs/data.c                                                    |    7 
 fs/f2fs/file.c                                                    |    7 
 fs/f2fs/namei.c                                                   |    2 
 fs/f2fs/node.c                                                    |    6 
 fs/f2fs/xattr.c                                                   |   11 
 fs/gfs2/rgrp.c                                                    |    2 
 fs/namespace.c                                                    |   11 
 fs/nfs/blocklayout/blocklayout.c                                  |    7 
 fs/nfs/direct.c                                                   |    5 
 fs/nfs/internal.h                                                 |    2 
 fs/nfs/nfs4proc.c                                                 |    3 
 fs/nfs/pnfs.c                                                     |    3 
 fs/pstore/ram_core.c                                              |    2 
 fs/smb/server/asn1.c                                              |    5 
 fs/smb/server/connection.c                                        |    6 
 fs/smb/server/connection.h                                        |    2 
 fs/smb/server/oplock.c                                            |    6 
 fs/smb/server/smb2pdu.c                                           |   22 
 fs/smb/server/smb_common.c                                        |    6 
 fs/smb/server/transport_rdma.c                                    |   11 
 fs/smb/server/transport_tcp.c                                     |   13 
 include/crypto/if_alg.h                                           |    3 
 include/drm/drm_bridge.h                                          |    2 
 include/dt-bindings/clock/qcom,videocc-sm8150.h                   |    4 
 include/linux/bio.h                                               |    9 
 include/linux/blkdev.h                                            |    3 
 include/linux/bpf.h                                               |   43 +
 include/linux/clk-provider.h                                      |    4 
 include/linux/hisi_acc_qm.h                                       |   20 
 include/linux/iio/adc/adi-axi-adc.h                               |    4 
 include/linux/netfilter_bridge.h                                  |    6 
 include/linux/of.h                                                |   17 
 include/linux/rcupdate.h                                          |   12 
 include/linux/skbuff.h                                            |    2 
 include/net/bluetooth/hci_core.h                                  |    1 
 include/uapi/linux/bpf.h                                          |    3 
 init/do_mounts.c                                                  |    9 
 io_uring/rw.c                                                     |   10 
 kernel/bpf/arraymap.c                                             |   12 
 kernel/bpf/hashtab.c                                              |    6 
 kernel/bpf/lpm_trie.c                                             |    3 
 kernel/bpf/map_in_map.c                                           |   13 
 kernel/bpf/map_in_map.h                                           |    2 
 kernel/bpf/stackmap.c                                             |   11 
 kernel/bpf/syscall.c                                              |   41 +
 kernel/bpf/verifier.c                                             |   27 
 kernel/debug/kdb/kdb_main.c                                       |    2 
 kernel/dma/coherent.c                                             |    4 
 kernel/rcu/tasks.h                                                |    2 
 kernel/time/tick-sched.c                                          |    5 
 lib/kunit/debugfs.c                                               |    4 
 net/bluetooth/hci_conn.c                                          |    8 
 net/bluetooth/hci_debugfs.c                                       |   12 
 net/bluetooth/hci_event.c                                         |   11 
 net/bridge/br_netfilter_hooks.c                                   |   42 +
 net/bridge/br_netfilter_ipv6.c                                    |   14 
 net/core/rtnetlink.c                                              |   14 
 net/dns_resolver/dns_key.c                                        |    2 
 net/ethtool/features.c                                            |    9 
 net/ipv4/af_inet.c                                                |    1 
 net/ipv4/ipmr.c                                                   |   13 
 net/ipv4/netfilter/nf_reject_ipv4.c                               |    9 
 net/ipv4/udp.c                                                    |   12 
 net/ipv6/ip6_tunnel.c                                             |   26 
 net/ipv6/mcast.c                                                  |    4 
 net/ipv6/netfilter/nf_reject_ipv6.c                               |   11 
 net/ipv6/udp.c                                                    |   16 
 net/mptcp/options.c                                               |    6 
 net/mptcp/subflow.c                                               |   17 
 net/ncsi/internal.h                                               |    7 
 net/ncsi/ncsi-netlink.c                                           |    4 
 net/ncsi/ncsi-pkt.h                                               |    7 
 net/ncsi/ncsi-rsp.c                                               |   26 
 net/netfilter/ipset/ip_set_hash_netiface.c                        |    8 
 net/netfilter/ipvs/ip_vs_xmit.c                                   |    4 
 net/netfilter/nf_log_syslog.c                                     |   13 
 net/netfilter/nf_queue.c                                          |    6 
 net/netfilter/nf_tables_api.c                                     |   27 
 net/netfilter/nfnetlink_log.c                                     |    8 
 net/netfilter/nft_limit.c                                         |   19 
 net/netfilter/xt_physdev.c                                        |    2 
 net/netlabel/netlabel_calipso.c                                   |   49 -
 net/sched/act_ct.c                                                |   12 
 net/sctp/socket.c                                                 |   13 
 net/sunrpc/xprtmultipath.c                                        |    2 
 net/unix/unix_bpf.c                                               |   21 
 net/vmw_vsock/virtio_transport_common.c                           |   13 
 scripts/Makefile.compiler                                         |    4 
 security/apparmor/policy_unpack.c                                 |    4 
 security/selinux/hooks.c                                          |    7 
 sound/pci/hda/patch_realtek.c                                     |    3 
 sound/pci/oxygen/oxygen_mixer.c                                   |    2 
 sound/soc/codecs/cs35l33.c                                        |    4 
 sound/soc/codecs/cs35l34.c                                        |    4 
 sound/soc/codecs/rt5645.c                                         |    8 
 sound/soc/intel/common/soc-acpi-intel-glk-match.c                 |   14 
 sound/soc/mediatek/common/mtk-dsp-sof-common.c                    |    2 
 sound/usb/mixer_scarlett_gen2.c                                   |  223 +++++---
 tools/include/uapi/linux/bpf.h                                    |    3 
 tools/lib/api/io.h                                                |    1 
 tools/perf/util/bpf-event.c                                       |    8 
 tools/perf/util/bpf-event.h                                       |   12 
 tools/perf/util/env.c                                             |   50 +
 tools/perf/util/env.h                                             |    4 
 tools/perf/util/genelf.c                                          |    6 
 tools/perf/util/header.c                                          |   13 
 tools/perf/util/hisi-ptt.c                                        |    1 
 tools/testing/selftests/alsa/mixer-test.c                         |    4 
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c                 |    2 
 tools/testing/selftests/bpf/prog_tests/time_tai.c                 |    2 
 tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c           |    5 
 tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c             |    4 
 tools/testing/selftests/drivers/net/mlxsw/qos_pfc.sh              |   18 
 tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh |   52 +
 tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh        |    2 
 tools/testing/selftests/net/fib_nexthop_multiprefix.sh            |    4 
 tools/testing/selftests/powerpc/math/fpu_preempt.c                |    9 
 tools/testing/selftests/powerpc/math/vmx_preempt.c                |   10 
 tools/testing/selftests/sgx/Makefile                              |    2 
 tools/testing/selftests/sgx/load.c                                |    9 
 tools/testing/selftests/sgx/sigstruct.c                           |    5 
 tools/testing/selftests/sgx/test_encl.c                           |    8 
 422 files changed, 3531 insertions(+), 2105 deletions(-)

Abhinav Singh (1):
      drm/nouveau/fence:: fix warning directly dereferencing a rcu pointer

Adam Ford (1):
      arm64: dts: imx8mm: Reduce GPU to nominal speed

Ahmad Fatoum (1):
      ARM: dts: stm32: don't mix SCMI and non-SCMI board compatibles

Alex Deucher (1):
      drm/amdgpu/debugfs: fix error code when smc register accessors are NULL

Alexandra Diupina (1):
      cpufreq: scmi: process the result of devm_of_clk_add_hw_provider()

Alexandre Ghiti (5):
      riscv: Check if the code to patch lies in the exit section
      riscv: Fix module_alloc() that did not reset the linear mapping permissions
      riscv: Fix set_memory_XX() and set_direct_map_XX() by splitting huge linear mappings
      riscv: Fix set_direct_map_default_noflush() to reset _PAGE_EXEC
      riscv: Fix wrong usage of lm_alias() when splitting a huge linear mapping

Amir Goldstein (1):
      scsi: target: core: add missing file_{start,end}_write()

Amit Cohen (2):
      mlxsw: spectrum_acl_erp: Fix error flow of pool allocation failure
      selftests: mlxsw: qos_pfc: Adjust the test to support 8 lanes

Amit Kumar Mahapatra (1):
      spi: spi-zynqmp-gqspi: fix driver kconfig dependencies

Andrei Matei (1):
      bpf: Fix verification of indirect var-off stack access

Andrii Nakryiko (2):
      bpf: enforce precision of R0 on callback return
      bpf: fix check for attempt to corrupt spilled pointer

Andy Shevchenko (2):
      ACPI: LPSS: Fix the fractional clock divider flags
      mfd: intel-lpss: Fix the fractional clock divider flags

AngeloGioacchino Del Regno (3):
      drm/panfrost: Really power off GPU cores in panfrost_gpu_power_off()
      drm/panfrost: Ignore core_mask for poweroff and disable PWRTRANS irq
      ASoC: mediatek: sof-common: Add NULL check for normal_link string

Anton Protopopov (1):
      bpf: add percpu stats for bpf_map elements insertions/deletions

Ard Biesheuvel (1):
      efivarfs: Free s_fs_info on unmount

Arnaldo Carvalho de Melo (1):
      libapi: Add missing linux/types.h header to get the __u64 type on io.h

Arnd Bergmann (6):
      EDAC/thunderx: Fix possible out-of-bounds string access
      csky: fix arch_jump_label_transform_static override
      wifi: libertas: stop selecting wext
      ARM: davinci: always select CONFIG_CPU_ARM926T
      nvmet: re-fix tracing strncpy() warning
      nvme: trace: avoid memcpy overflow warning

Arseniy Krasnov (1):
      virtio/vsock: fix logic which reduces credit update messages

Artem Chernyshev (1):
      scsi: fnic: Return error if vmalloc() failed

Asmaa Mnebhi (2):
      mlxbf_gige: Fix intermittent no ip issue
      mlxbf_gige: Enable the GigE port in mlxbf_gige_open

Atul Dhudase (1):
      soc: qcom: llcc: Fix dis_cap_alloc and retain_on_pc configuration

Bart Van Assche (2):
      scsi: ufs: core: Simplify power management during async scan
      md/raid1: Use blk_opf_t for read and write operations

Benjamin Coddington (1):
      blocklayoutdriver: Fix reference leak of pnfs_device_node

Bin Li (1):
      ALSA: hda/realtek: Enable headset mic on Lenovo M70 Gen5

Brent Lu (1):
      ASoC: Intel: glk_rt5682_max98357a: fix board id mismatch

Carlos Llamas (3):
      binder: fix async space check for 0-sized buffers
      binder: fix unused alloc->free_async_space
      binder: fix race between mmput() and do_exit()

Chandrakanth patil (2):
      scsi: mpi3mr: Refresh sdev queue depth after controller reset
      scsi: mpi3mr: Block PEL Enable Command on Controller Reset and Unrecoverable State

Chao Yu (4):
      f2fs: fix to avoid dirent corruption
      f2fs: fix to wait on block writeback for post_read case
      f2fs: fix to check compress file in f2fs_move_file_range()
      f2fs: fix to update iostat correctly in f2fs_filemap_fault()

Chen Ni (2):
      KEYS: encrypted: Add check for strsep
      crypto: sa2ul - Return crypto_aead_setkey to transfer the error

Chengchang Tang (1):
      RDMA/hns: Fix memory leak in free_mr_init()

Chenghai Huang (1):
      crypto: hisilicon/zip - add zip comp high perf mode configuration

Chengming Zhou (1):
      crypto: scomp - fix req->dst buffer overflow

Chih-Kang Chang (1):
      wifi: rtw88: fix RX filter in FIF_ALLMULTI flag

Chris Morgan (2):
      drm/panel-elida-kd35t133: hold panel in reset for unprepare
      drm/panel: st7701: Fix AVCL calculation

Christian A. Ehrhardt (1):
      of: Fix double free in of_parse_phandle_with_args_map

Christian Brauner (1):
      fs: indicate request originates from old mount API

Christian Marangi (2):
      arm64: dts: qcom: ipq6018: improve pcie phy pcs reg table
      wifi: mt76: fix broken precal loading from MTD for mt7915

Christoph Hellwig (2):
      null_blk: don't cap max_hw_sectors to BLK_DEF_MAX_SECTORS
      loop: fix the the direct I/O support check when used on top of block devices

Christoph Niedermaier (2):
      serial: imx: Ensure that imx_uart_rs485_config() is called with enabled clock
      serial: imx: Correct clock error message in function probe()

Christophe JAILLET (6):
      firmware: ti_sci: Fix an off-by-one in ti_sci_debugfs_create()
      media: dvb-frontends: m88ds3103: Fix a memory leak in an error handling path of m88ds3103_probe()
      MIPS: Alchemy: Fix an out-of-bound access in db1200_dev_setup()
      MIPS: Alchemy: Fix an out-of-bound access in db1550_dev_setup()
      vdpa: Fix an error handling path in eni_vdpa_probe()
      kdb: Fix a potential buffer overflow in kdb_local()

Chukun Pan (1):
      arm64: dts: qcom: ipq6018: fix clock rates for GCC_USB0_MOCK_UTMI_CLK

Chunfeng Yun (1):
      usb: xhci-mtk: fix a short packet issue of gen1 isoc-in transfer

Claudiu Beznea (3):
      clk: renesas: rzg2l-cpg: Reuse code in rzg2l_cpg_reset()
      clk: renesas: rzg2l: Check reset monitor registers
      net: phy: micrel: populate .soft_reset for KSZ9131

Colin Ian King (1):
      x86/lib: Fix overflow when counting digits

Curtis Klein (1):
      watchdog: set cdev owner before adding

Dafna Hirschfeld (1):
      drm/amdkfd: fixes for HMM mem allocation

Dan Carpenter (2):
      wifi: plfxlc: check for allocation failure in plfxlc_usb_wreq_async()
      media: dvbdev: drop refcount on error path in dvb_device_open()

Dang Huynh (1):
      leds: aw2013: Select missing dependency REGMAP_I2C

Dario Binacchi (2):
      drm/bridge: Fix typo in post_disable() description
      fbdev: imxfb: fix left margin setting

David E. Box (1):
      platform/x86/intel/vsec: Fix xa_alloc memory leak

David Howells (1):
      keys, dns: Fix size check of V1 server-list header

David Lin (1):
      wifi: mwifiex: configure BSSID consistently when starting AP

Deepak R Varma (1):
      drm/amdkfd: Use resource_size() helper function

Dinghao Liu (1):
      crypto: ccp - fix memleak in ccp_init_dm_workarea

Dmitry Baryshkov (4):
      ARM: dts: qcom: apq8064: correct XOADC register address
      arm64: dts: qcom: sm8150-hdk: fix SS USB regulators
      drm/msm/mdp4: flush vblank event on disable
      drm/drv: propagate errors from drm_modeset_register_all()

Dmitry Rokosov (1):
      firmware: meson_sm: populate platform devices from sm device tree data

Douglas Anderson (7):
      arm64: dts: qcom: sc7180: Make watchdog bark interrupt edge triggered
      arm64: dts: qcom: sc7280: Make watchdog bark interrupt edge triggered
      arm64: dts: qcom: sdm845: Make watchdog bark interrupt edge triggered
      arm64: dts: qcom: sm8150: Make watchdog bark interrupt edge triggered
      arm64: dts: qcom: sm8250: Make watchdog bark interrupt edge triggered
      arm64: dts: qcom: sc8280xp: Make watchdog bark interrupt edge triggered
      arm64: dts: qcom: sm6350: Make watchdog bark interrupt edge triggered

Eric Dumazet (9):
      sctp: support MSG_ERRQUEUE flag in recvmsg()
      sctp: fix busy polling
      ip6_tunnel: fix NEXTHDR_FRAGMENT handling in ip6_tnl_parse_tlv_enc_lim()
      mptcp: mptcp_parse_option() fix for MPTCPOPT_MP_JOIN
      mptcp: strict validation before using mp_opt->hmac
      mptcp: use OPTION_MPTCP_MPJ_SYNACK in subflow_finish_connect()
      mptcp: use OPTION_MPTCP_MPJ_SYN in subflow_check_req()
      mptcp: refine opt_mp_capable determination
      udp: annotate data-races around up->pending

Fedor Pchelkin (2):
      apparmor: avoid crash when parsed profile name is empty
      ipvs: avoid stat macros calls from preemptible context

Florian Lehner (1):
      bpf, lpm: Fix check prefixlen before walking trie

Florian Westphal (1):
      netfilter: nf_tables: mark newset as dead on transaction abort

Francesco Dolcini (1):
      Bluetooth: btmtkuart: fix recv_buf() return value

Frank Li (3):
      usb: cdns3: fix uvc failure work since sg support enabled
      usb: cdns3: fix iso transfer error when mult is not zero
      usb: cdns3: Fix uvc fail when DMA cross 4k boundery since sg enabled

Frederik Haxel (1):
      riscv: Fixed wrong register in XIP_FIXUP_FLASH_OFFSET macro

Gao Xiang (1):
      erofs: fix memory leak on short-lived bounced pages

Gavrilov Ilia (1):
      calipso: fix memory leak in netlbl_calipso_add_pass()

Geert Uytterhoeven (2):
      arm64: dts: renesas: white-hawk-cpu: Fix missing serial console pin control
      of: unittest: Fix of_count_phandle_with_args() expected value message

Geoffrey D. Bennett (5):
      ALSA: scarlett2: Add missing error check to scarlett2_config_save()
      ALSA: scarlett2: Add missing error check to scarlett2_usb_set_config()
      ALSA: scarlett2: Allow passing any output to line_out_remap()
      ALSA: scarlett2: Add missing error checks to *_ctl_get()
      ALSA: scarlett2: Add clamp() in scarlett2_mixer_ctl_put()

Gonglei (Arei) (1):
      crypto: virtio - Handle dataq logic with tasklet

Greg Kroah-Hartman (1):
      Linux 6.1.75

Gregory Price (1):
      base/node.c: initialize the accessor list before registering

Gui-Dong Han (2):
      usb: mon: Fix atomicity violation in mon_bin_vma_fault
      Bluetooth: Fix atomicity violation in {min,max}_key_size_set

Hangbin Liu (2):
      selftests/net: specify the interface when do arping
      selftests/net: fix grep checking for fib_nexthop_multiprefix

Hans de Goede (2):
      ASoC: rt5645: Drop double EF20 entry from dmi_platform_data[]
      Input: atkbd - use ab83 as id when skipping the getid command

Hao Sun (1):
      bpf: Reject variable offset alu on PTR_TO_FLOW_KEYS

Heikki Krogerus (1):
      Revert "usb: typec: class: fix typec_altmode_put_partner to put plugs"

Heiko Carstens (1):
      tick-sched: Fix idle and iowait sleeptime accounting vs CPU hotplug

Hengqi Chen (1):
      LoongArch: BPF: Prevent out-of-bounds memory access

Herbert Xu (1):
      crypto: af_alg - Disallow multiple in-flight AIO requests

Hou Tao (2):
      bpf: Add map and need_defer parameters to .map_fd_put_ptr()
      bpf: Defer the free of inner map when necessary

Hsiao Chien Sung (2):
      drm/mediatek: Return error if MDP RDMA failed to enable the clock
      drm/mediatek: Fix underrun in VDO1 when switches off the layer

Huang Ying (1):
      cxl/port: Fix decoder initialization when nr_targets > interleave_ways

Hugo Villeneuve (2):
      serial: sc16is7xx: add check for unsupported SPI modes during probe
      serial: sc16is7xx: set safe default SPI clock frequency

Ian Rogers (1):
      perf env: Avoid recursively taking env->bpf_progs.lock

Ilias Apalodimas (1):
      efivarfs: force RO when remounting if SetVariable is not supported

Ilpo Järvinen (2):
      wifi: rtlwifi: Remove bogus and dangerous ASPM disable/enable code
      wifi: rtlwifi: Convert LNKCTL change to PCIe cap RMW accessors

Isaac J. Manjarres (1):
      iommu/dma: Trace bounce buffer usage when mapping buffers

Jan Beulich (1):
      xen-netback: don't produce zero-size SKB frags

Jan Palus (1):
      power: supply: cw2015: correct time_to_empty units in sysfs

Jason Gerecke (1):
      HID: wacom: Correct behavior when processing some confidence == false touches

Jay Buddhabhatti (2):
      drivers: clk: zynqmp: calculate closest mux rate
      drivers: clk: zynqmp: update divider round rate logic

Jens Axboe (2):
      io_uring/rw: ensure io->bytes_done is always initialized
      block: ensure we hold a queue reference when using queue limits

Jeroen van Ingen Schenau (1):
      selftests/bpf: Fix erroneous bitmask operation

Jerry Hoemann (1):
      watchdog/hpwdt: Only claim UNKNOWN NMI if from iLO

Jessica Zhang (2):
      drm/msm/dpu: Set input_sel bit for INTF
      drm/msm/dpu: Drop enable and frame_count parameters from dpu_hw_setup_misr()

Jianjun Wang (1):
      PCI: mediatek-gen3: Fix translation window size calculation

Jim Harris (1):
      cxl/region: fix x9 interleave typo

Jiri Olsa (1):
      bpf: Fix re-attachment branch in bpf_tracing_prog_attach

Jiri Slaby (SUSE) (4):
      tty: change tty_write_lock()'s ndelay parameter to bool
      tty: early return from send_break() on TTY_DRIVER_HARDWARE_BREAK
      tty: don't check for signal_pending() in send_break()
      tty: use 'if' in send_break() instead of 'goto'

Jo Van Bulck (3):
      selftests/sgx: Fix uninitialized pointer dereference in error path
      selftests/sgx: Fix uninitialized pointer dereferences in encl_get_entry
      selftests/sgx: Include memory clobber for inline asm in test enclave

Joakim Zhang (1):
      dma-mapping: clear dev->dma_mem to NULL after freeing it

Johan Hovold (2):
      arm64: dts: qcom: sc7280: fix usb_2 wakeup interrupt types
      arm64: dts: hisilicon: hikey970-pmic: fix regulator cells properties

Johannes Berg (2):
      wifi: iwlwifi: mvm: set siso/mimo chains to 1 in FW SMPS request
      wifi: iwlwifi: mvm: send TX path flush in rfkill

John Fastabend (1):
      bpf: sockmap, fix proto update hook to avoid dup calls

Jordan Rome (2):
      bpf: Add crosstask check to __bpf_get_stack
      selftests/bpf: Add assert for user stacks in test_task_stack

Junxian Huang (1):
      RDMA/hns: Fix inappropriate err code for unsupported operations

Keith Busch (1):
      block: make BLK_DEF_MAX_SECTORS unsigned

Kirill A. Shutemov (1):
      x86/kvm: Do not try to disable kvmclock if it was not enabled

Konrad Dybcio (7):
      arm64: dts: qcom: sc7280: Fix up GPU SIDs
      arm64: dts: qcom: sc7280: Mark Adreno SMMU as DMA coherent
      arm64: dts: qcom: sc7280: Mark SDHCI hosts as cache-coherent
      arm64: dts: qcom: ipq6018: Use lowercase hex
      arm64: dts: qcom: ipq6018: Pad addresses to 8 hex digits
      arm64: dts: qcom: ipq6018: Fix up indentation
      drm/msm/dsi: Use pm_runtime_resume_and_get to prevent refcnt leaks

Krzysztof Kozlowski (3):
      ARM: dts: qcom: sdx65: correct SPMI node name
      arm64: dts: qcom: qrb5165-rb5: correct LED panic indicator
      arm64: dts: qcom: sdm845-db845c: correct LED panic indicator

Kunwu Chan (6):
      powerpc/powernv: Add a null pointer check to scom_debug_init_one()
      powerpc/powernv: Add a null pointer check in opal_event_init()
      powerpc/powernv: Add a null pointer check in opal_powercap_init()
      powerpc/imc-pmu: Add a null pointer check in update_events_in_group()
      mfd: syscon: Fix null pointer dereference in of_syscon_register()
      net: dsa: vsc73xx: Add null pointer check to vsc73xx_gpio_probe

Leon Romanovsky (1):
      RDMA/usnic: Silence uninitialized symbol smatch warnings

Leone Fernando (1):
      ipmr: support IP_PKTINFO on cache report IGMP msg

Li Nan (3):
      block: Set memalloc_noio to false on device_add_disk() error path
      block: add check of 'minors' and 'first_minor' in device_add_disk()
      ksmbd: validate the zero field of packet header

Lin Ma (1):
      net: qualcomm: rmnet: fix global oob in rmnet_policy

Lino Sanfilippo (5):
      serial: core: fix sanitizing check for RTS settings
      serial: core: make sure RS485 cannot be enabled when it is not supported
      serial: core, imx: do not set RS485 enabled if it is not supported
      serial: 8250_exar: Set missing rs485_supported flag
      serial: omap: do not override settings for RS485 support

Linus Walleij (2):
      ASoC: cs35l33: Fix GPIO name and drop legacy include
      ASoC: cs35l34: Fix GPIO name and drop legacy include

Luca Weiss (2):
      wifi: ath11k: Defer on rproc_get failure
      arm64: dts: qcom: sc7280: Mark some nodes as 'reserved'

Ludvig Pärsson (1):
      ethtool: netlink: Add missing ethnl_ops_begin/complete

Luiz Augusto von Dentz (1):
      Bluetooth: Fix bogus check for re-auth no supported with non-ssp

Marc Zyngier (1):
      KVM: arm64: vgic-v4: Restore pending state on host userspace write

Marcelo Schmitt (1):
      iio: adc: ad7091r: Pass iio_dev to event handler

Marek Szyprowski (2):
      i2c: s3c24xx: fix read transfers in polling mode
      i2c: s3c24xx: fix transferring more than one message in polling mode

Mario Limonciello (1):
      drm/amd: Enable PCIe PME from D3

Masahiro Yamada (2):
      powerpc: remove checks for binutils older than 2.25
      powerpc: add crtsavres.o to always-y instead of extra-y

Matthew Wilcox (Oracle) (2):
      block: Fix iterating over an empty bio with bio_for_each_folio_all
      block: Remove special-casing of compound pages

Maurizio Lombardi (3):
      nvmet-tcp: Fix a kernel panic when host sends an invalid H2C PDU length
      nvmet-tcp: fix a crash in nvmet_req_complete()
      nvmet-tcp: Fix the H2C expected PDU len calculation

Mehdi Djait (1):
      media: dt-bindings: media: rkisp1: Fix the port description for the parallel interface

Michael Ellerman (2):
      selftests/powerpc: Fix error handling in FPU/VMX preemption tests
      powerpc/64s: Increase default stack size to 32KB

Michal Simek (1):
      dt-bindings: gpio: xilinx: Fix node address in gpio

Mickaël Salaün (1):
      selinux: Fix error priority for bind with AF_UNSPEC on PF_INET6 socket

Mimi Zohar (1):
      Revert "KEYS: encrypted: Add check for strsep"

Min Li (1):
      block: add check that partition length needs to be aligned with block size

Ming Yen Hsieh (1):
      wifi: mt76: mt7921: fix country count limitation for CLC

Mirsad Todorovac (2):
      kselftest/alsa - mixer-test: fix the number of parameters to ksft_exit_fail_msg()
      kselftest/alsa - mixer-test: Fix the print format specifier warning

Moudy Ho (2):
      dt-bindings: media: mediatek: mdp3: correct RDMA and WROT node with generic names
      arm64: dts: mediatek: mt8183: correct MDP3 DMA-related nodes

Nam Cao (2):
      fbdev: flush deferred work in fb_deferred_io_fsync()
      fbdev: flush deferred IO before closing

Namhyung Kim (1):
      perf genelf: Set ELF program header addresses properly

Namjae Jeon (3):
      ksmbd: validate mech token in session setup
      ksmbd: fix UAF issue in ksmbd_tcp_new_connection()
      ksmbd: only v2 leases handle the directory

Nathan Lynch (1):
      powerpc/pseries/memhp: Fix access beyond end of drmem array

Nia Espera (1):
      arm64: dts: qcom: sm8350: Fix DMA0 address

Nicolas Dichtel (1):
      Revert "net: rtnetlink: Enslave device before bringing it up"

Nikita Kiryushin (2):
      ACPI: video: check for error while searching for backlight device parent
      ACPI: LPIT: Avoid u32 multiplication overflow

Nikita Yushchenko (1):
      net: ravb: Fix dma_addr_t truncation in error case

Nikita Zhandarovich (5):
      crypto: safexcel - Add error handling for dma_map_sg() calls
      drm/radeon/r600_cs: Fix possible int overflows in r600_cs_check_reg()
      drm/radeon/r100: Fix integer overflow issues in r100_cs_track_check()
      drm/radeon: check return value of radeon_ring_lock()
      ipv6: mcast: fix data-race in ipv6_mc_down / mld_ifc_work

Niklas Cassel (1):
      PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment support

Niklas Schnelle (1):
      s390/pci: fix max size calculation in zpci_memcpy_toio()

Nitin Yadav (1):
      arm64: dts: ti: k3-am62a-main: Fix GPIO pin count in DT nodes

Nuno Sa (3):
      iio: adc: ad9467: fix reset gpio handling
      iio: adc: ad9467: don't ignore error codes
      iio: adc: ad9467: fix scale setting

Nícolas F. R. A. Prado (2):
      drm/mediatek: dp: Add phy_mtk_dp module as pre-dependency
      spmi: mtk-pmif: Serialize PMIF status check and command submission

Olga Kornievskaia (1):
      SUNRPC: fix _xprt_switch_find_current_entry logic

Oliver Neukum (1):
      usb: cdc-acm: return correct error code on unsupported break

Oliver Upton (1):
      KVM: arm64: vgic-its: Avoid potential UAF in LPI translation cache

Osama Muhammad (1):
      gfs2: Fix kernel NULL pointer dereference in gfs2_rgrp_dump

Ovidiu Panait (12):
      crypto: sahara - remove FLAGS_NEW_KEY logic
      crypto: sahara - fix cbc selftest failure
      crypto: sahara - fix ahash selftest failure
      crypto: sahara - fix processing requests with cryptlen < sg->length
      crypto: sahara - fix error handling in sahara_hw_descriptor_create()
      crypto: sahara - avoid skcipher fallback code duplication
      crypto: sahara - handle zero-length aes requests
      crypto: sahara - fix ahash reqsize
      crypto: sahara - fix wait_for_completion_timeout() error handling
      crypto: sahara - improve error handling in sahara_sha_process()
      crypto: sahara - fix processing hash requests with req->nbytes < sg->length
      crypto: sahara - do not resize req->src when doing hash operations

Pablo Neira Ayuso (6):
      netfilter: nf_tables: check if catch-all set element is active in next generation
      netfilter: nf_tables: reject invalid set policy
      netfilter: nft_limit: do not ignore unsupported flags
      netfilter: nf_tables: do not allow mismatch field size and set key length
      netfilter: nf_tables: skip dead set elements in netlink dump
      netfilter: nf_tables: reject NFT_SET_CONCAT with not field length description

Paolo Abeni (1):
      mptcp: relax check on MPC passive fallback

Paul E. McKenney (1):
      rcu-tasks: Provide rcu_trace_implies_rcu_gp()

Paul Geurts (1):
      serial: imx: fix tx statemachine deadlock

Paul Kocialkowski (2):
      media: verisilicon: Hook the (TRY_)DECODER_CMD stateless ioctls
      media: rkvdec: Hook the (TRY_)DECODER_CMD stateless ioctls

Pavel Tikhomirov (4):
      netfilter: nfnetlink_log: use proper helper for fetching physinif
      netfilter: nf_queue: remove excess nf_bridge variable
      netfilter: propagate net to nf_bridge_get_physindev
      netfilter: bridge: replace physindev with physinif in nf_bridge_info

Peter Delevoryas (1):
      net/ncsi: Fix netlink major/minor version numbers

Peter Robinson (2):
      mmc: sdhci_am654: Fix TI SoC dependencies
      mmc: sdhci_omap: Fix TI SoC dependencies

Philipp Zabel (2):
      pwm: stm32: Use hweight32 in stm32_pwm_detect_channels
      pwm: stm32: Fix enable count for clk in .probe()

Qiang Ma (1):
      net: stmmac: ethtool: Fixed calltrace caused by unbalanced disable_irq_wake calls

RD Babiera (1):
      usb: typec: class: fix typec_altmode_put_partner to put plugs

Randy Dunlap (2):
      powerpc/44x: select I2C for CURRITUCK
      ARM: 9330/1: davinci: also select PINCTRL

Ricardo B. Marliere (1):
      media: pvrusb2: fix use after free on context disconnection

Richard Fitzgerald (1):
      kunit: debugfs: Fix unchecked dereference in debugfs_print_results()

Rob Clark (1):
      iommu/arm-smmu-qcom: Add missing GMU entry to match table

Rob Herring (2):
      of: Add of_property_present() helper
      cpufreq: Use of_property_present() for testing DT property presence

Ronald Monthero (1):
      mtd: rawnand: Increment IFC_TIMEOUT_MSECS for nand controller response

Sakari Ailus (2):
      acpi: property: Let args be NULL in __acpi_node_get_property_reference
      software node: Let args be NULL in software_node_get_reference_args

Sanjuán García, Jorge (1):
      net: ethernet: ti: am65-cpsw: Fix max mtu to fit ethernet frames

Satya Priya Kakitapalli (4):
      clk: qcom: gpucc-sm8150: Update the gpu_cc_pll1 config
      dt-bindings: clock: Update the videocc resets for sm8150
      clk: qcom: videocc-sm8150: Update the videocc resets
      clk: qcom: videocc-sm8150: Add missing PLL config property

Serge Semin (2):
      mips: dmi: Fix early remap on MIPS32
      mips: Fix incorrect max_low_pfn adjustment

Sergey Gorenko (1):
      IB/iser: Prevent invalidating wrong MR

Sergey Shtylyov (1):
      pstore: ram_core: fix possible overflow in persistent_ram_init_ecc()

Siddharth Vadapalli (1):
      PCI: keystone: Fix race condition when initializing PHYs

Sjoerd Simons (1):
      arm64: dts: armada-3720-turris-mox: set irq type for RTC

Song Liu (1):
      Revert "Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d""

Srinivas Pandruvada (3):
      platform/x86/intel/vsec: Enhance and Export intel_vsec_add_aux()
      platform/x86/intel/vsec: Support private data
      platform/x86/intel/vsec: Use mutex for ida_alloc() and ida_free()

Srinivasan Shanmugam (1):
      drm/amdkfd: Confirm list is non-empty before utilizing list_first_entry in kfd_topology.c

Stefan Berger (1):
      rootfs: Fix support for rootfstype= when root= is given

Stefan Wahren (2):
      watchdog: bcm2835_wdt: Fix WDIOC_SETTIMEOUT handling
      serial: 8250_bcm2835aux: Restore clock error handling

Stefan Wiehler (1):
      mips/smp: Call rcutree_report_cpu_starting() earlier

Su Hui (11):
      wifi: rtlwifi: rtl8821ae: phy: fix an undefined bitwise shift behavior
      wifi: rtlwifi: add calculate_bit_shift()
      wifi: rtlwifi: rtl8188ee: phy: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192c: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192cu: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192ce: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192de: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192ee: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192se: using calculate_bit_shift()
      clk: si5341: fix an error code problem in si5341_output_clk_set_rate
      power: supply: bq256xx: fix some problem in bq256xx_hw_init

Tadeusz Struk (1):
      PCI/P2PDMA: Remove reference to pci_p2pdma_map_sg()

Taehee Yoo (1):
      amt: do not use overwrapped cb area

Takashi Iwai (1):
      ALSA: oxygen: Fix right channel of capture volume mixer

Tao Liu (1):
      net/sched: act_ct: fix skb leak and crash on ooo frags

Thinh Nguyen (2):
      Revert "usb: dwc3: Soft reset phy on probe for host"
      Revert "usb: dwc3: don't reset device side if dwc3 was configured as host-only"

Théo Lebrun (1):
      clk: fixed-rate: fix clk_hw_register_fixed_rate_with_accuracy_parent_hw

Tomi Valkeinen (12):
      arm64: dts: ti: k3-am65-main: Fix DSS irq trigger type
      Revert "drm/tidss: Annotate dma-fence critical section in commit path"
      Revert "drm/omapdrm: Annotate dma-fence critical section in commit path"
      drm/tilcdc: Fix irq free on unload
      drm/tidss: Move reset to the end of dispc_init()
      drm/tidss: Return error value from from softreset
      drm/tidss: Check for K2G in in dispc_softreset()
      drm/tidss: Fix dss reset
      drm/bridge: cdns-mhdp8546: Fix use of uninitialized variable
      drm/bridge: tc358767: Fix return value on error case
      media: imx-mipi-csis: Fix clock handling in remove()
      media: rkisp1: Fix media device memory leak

Tony Lindgren (1):
      clocksource/drivers/timer-ti-dm: Fix make W=n kerneldoc warnings

Tony Luck (1):
      ACPI: extlog: Clear Extended Error Log status when RAS_CEC handled the error

Trond Myklebust (2):
      NFSv4.1/pnfs: Ensure we handle the error NFS4ERR_RETURNCONFLICT
      pNFS: Fix the pnfs block driver's calculation of layoutget size

Uttkarsh Aggarwal (1):
      usb: dwc: ep0: Update request status in dwc3_ep0_stall_restart

Uwe Kleine-König (5):
      drm/bridge: tpd12s015: Drop buggy __exit annotation for remove function
      pwm: stm32: Use regmap_clear_bits and regmap_set_bits where applicable
      pwm: jz4740: Don't use dev_err_probe() in .request()
      pwm: Fix out-of-bounds access in of_pwm_single_xlate()
      serial: 8250: omap: Don't skip resource freeing if pm_runtime_resume_and_get() failed

Vignesh Raghavendra (1):
      watchdog: rti_wdt: Drop runtime pm reference count when watchdog is unused

Wang Zhao (1):
      wifi: mt76: mt7921s: fix workqueue problem causes STA association fail

Wenkai Lin (1):
      crypto: hisilicon/qm - add a function to set qm algs

Wolfram Sang (1):
      spi: sh-msiof: Enforce fixed DTDL for R-Car H3

Xi Ruoyao (1):
      LoongArch: Fix and simplify fcsr initialization on execve()

Xingyuan Mo (1):
      accel/habanalabs: fix information leak in sec_attest_info()

Xu Yang (2):
      usb: phy: mxs: remove CONFIG_USB_OTG condition for mxs_phy_is_otg_host()
      usb: chipidea: wait controller resume finished for wakeup irq

Yang Yingliang (1):
      drm/radeon: check the alloc_workqueue return value in radeon_crtc_init()

Yazen Ghannam (1):
      x86/mce/inject: Clear test status value

YiFei Zhu (1):
      selftests/bpf: Relax time_tai test for equal timestamps in tai_forward

Yicong Yang (2):
      perf header: Fix one memory leakage in perf_event__fprintf_event_update()
      perf hisi-ptt: Fix one memory leakage in hisi_ptt_process_auxtrace_event()

Yihang Li (3):
      scsi: hisi_sas: Replace with standard error code return value
      scsi: hisi_sas: Rollback some operations if FLR failed
      scsi: hisi_sas: Correct the number of global debugfs registers

Yo-Jung Lin (1):
      ALSA: hda/realtek: Enable mute/micmute LEDs and limit mic boost on HP ZBook

Yu Kuai (1):
      md: synchronize flush io with array reconfiguration

Zack Rusin (2):
      drm/vmwgfx: Fix possible invalid drm gem put calls
      drm/vmwgfx: Keep a gem reference to user bos in surfaces

Zhao Mengmeng (1):
      selftests/sgx: Skip non X86_64 platform

ZhaoLong Wang (1):
      mtd: Fix gluebi NULL pointer dereference caused by ftl notifier

Zheng Wang (1):
      media: mtk-jpeg: Remove cancel worker in mtk_jpeg_remove to avoid the crash of multi-core JPEG devices

Zhiguo Niu (1):
      f2fs: fix to check return value of f2fs_recover_xattr_data

Zhipeng Lu (8):
      drm/radeon/dpm: fix a memleak in sumo_parse_power_table
      drm/radeon/trinity_dpm: fix a memleak in trinity_parse_power_table
      media: cx231xx: fix a memleak in cx231xx_init_isoc
      drm/amd/pm: fix a double-free in si_dpm_init
      drivers/amd/pm: fix a use-after-free in kv_parse_power_table
      gpu/drm/radeon: fix two memleaks in radeon_vm_init
      drm/amd/pm: fix a double-free in amdgpu_parse_extended_power_table
      drm/amd/pm/smu7: fix a memleak in smu7_hwmgr_backend_init

Zhiqi Song (4):
      crypto: hisilicon/qm - save capability registers in qm init process
      crypto: hisilicon/hpre - save capability registers in probe process
      crypto: hisilicon/sec2 - save capability registers in probe process
      crypto: hisilicon/zip - save capability registers in probe process

kyrie wu (1):
      media: mtk-jpegdec: export jpeg decoder functions

qizhong cheng (1):
      PCI: mediatek: Clear interrupt status before dispatching handler

wangyangxin (1):
      crypto: virtio - Wait for tasklet to complete on device remove

Çağhan Demir (1):
      ALSA: hda/relatek: Enable Mute LED on HP Laptop 15s-fq2xxx


