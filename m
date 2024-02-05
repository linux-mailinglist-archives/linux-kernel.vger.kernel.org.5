Return-Path: <linux-kernel+bounces-53912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D52484A7F0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A911C253F5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D75132C28;
	Mon,  5 Feb 2024 20:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nmNKO4ic"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D8113248B;
	Mon,  5 Feb 2024 20:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707164514; cv=none; b=oX7g+tGFYjfJa6paM/MwM5PnYyPvfG9o9EK7bouQVIOXjOoKDu2rYUiWVbDdoPB2pjNItiX56i07r8SA+1r5gqVrE1nr2kPq3yNLZAyvdkgAylZuIzfhPwEAR7PFSfYFBdpba+kNXCnKOzUts6C/wPKRR0mxeKWR43xmSAXMku8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707164514; c=relaxed/simple;
	bh=LddbR0SVVhTmmHgHj+iIEprWWy14RK8WahZ56wNQ2gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jluIBICLeq3YWH9dY7hBUXhZRQOeMGx3N7BlzMTjEqvekv9SlF2BX1mew+RiYjWSQWowkFPB8a4yPwbA4NQ/GyxR0VKn+ZWWkHUk0hKH/oZVyOsWRvc1nwlP1JINW4qFONh4kCRoCISkVTOmY1Ww0Xlt0SsT2IhqpDR9lDozX6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nmNKO4ic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6105C433B2;
	Mon,  5 Feb 2024 20:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707164513;
	bh=LddbR0SVVhTmmHgHj+iIEprWWy14RK8WahZ56wNQ2gs=;
	h=From:To:Cc:Subject:Date:From;
	b=nmNKO4ic4+WNMIeMmxGmPmsrGN0jNePIwav5T8kbeOS7utRNn0OI2yRMrUIqQ95Vi
	 BoGRK1aTv1HKaeL0vUkEiBM3IvmD7f6a62mFbEEm8IlKUZC4ml/k42BGpm0hq8RdRD
	 LRqPXMSqHAQ+WCW3UcsfbRlWVyIqZcxf5oWVZDtM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.7.4
Date: Mon,  5 Feb 2024 20:21:39 +0000
Message-ID: <2024020539-helpless-destruct-c4eb@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.7.4 kernel.

All users of the 6.7 kernel series must upgrade.

The updated 6.7.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.7.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-class-net-queues                        |   22 
 Documentation/sound/soc/dapm.rst                                        |    2 
 Makefile                                                                |    2 
 arch/alpha/kernel/asm-offsets.c                                         |    2 
 arch/arm/boot/dts/intel/ixp/intel-ixp42x-usrobotics-usr8200.dts         |   22 
 arch/arm/boot/dts/marvell/armada-370-rd.dts                             |   24 
 arch/arm/boot/dts/marvell/armada-381-netgear-gs110emx.dts               |   44 -
 arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts                |   38 -
 arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-s4.dts                |   22 
 arch/arm/boot/dts/marvell/armada-385-linksys.dtsi                       |   18 
 arch/arm/boot/dts/marvell/armada-385-turris-omnia.dts                   |   20 
 arch/arm/boot/dts/marvell/armada-388-clearfog.dts                       |   20 
 arch/arm/boot/dts/marvell/armada-xp-linksys-mamba.dts                   |   18 
 arch/arm/boot/dts/nxp/imx/imx1-ads.dts                                  |    2 
 arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts                              |    2 
 arch/arm/boot/dts/nxp/imx/imx1.dtsi                                     |    5 
 arch/arm/boot/dts/nxp/imx/imx25-eukrea-cpuimx25.dtsi                    |    2 
 arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts |    2 
 arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts |    2 
 arch/arm/boot/dts/nxp/imx/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts  |    2 
 arch/arm/boot/dts/nxp/imx/imx25-pdk.dts                                 |    2 
 arch/arm/boot/dts/nxp/imx/imx25.dtsi                                    |    2 
 arch/arm/boot/dts/nxp/imx/imx27-apf27dev.dts                            |    4 
 arch/arm/boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi                    |    4 
 arch/arm/boot/dts/nxp/imx/imx27-eukrea-mbimxsd27-baseboard.dts          |    2 
 arch/arm/boot/dts/nxp/imx/imx27-phytec-phycard-s-rdk.dts                |    2 
 arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-rdk.dts                  |    2 
 arch/arm/boot/dts/nxp/imx/imx27-phytec-phycore-som.dtsi                 |    2 
 arch/arm/boot/dts/nxp/imx/imx27.dtsi                                    |    3 
 arch/arm/boot/dts/nxp/imx/imx7d.dtsi                                    |    3 
 arch/arm/boot/dts/nxp/imx/imx7s.dtsi                                    |   10 
 arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts                               |   12 
 arch/arm/boot/dts/nxp/mxs/imx23.dtsi                                    |    2 
 arch/arm/boot/dts/nxp/mxs/imx28.dtsi                                    |    2 
 arch/arm/boot/dts/qcom/pm8226.dtsi                                      |  180 +++++++
 arch/arm/boot/dts/qcom/pm8841.dtsi                                      |   68 ++
 arch/arm/boot/dts/qcom/pm8941.dtsi                                      |  254 ++++++++++
 arch/arm/boot/dts/qcom/pma8084.dtsi                                     |   99 +++
 arch/arm/boot/dts/qcom/pmx55.dtsi                                       |   85 +++
 arch/arm/boot/dts/qcom/pmx65.dtsi                                       |   33 +
 arch/arm/boot/dts/qcom/qcom-apq8026-asus-sparrow.dts                    |    2 
 arch/arm/boot/dts/qcom/qcom-apq8026-huawei-sturgeon.dts                 |    2 
 arch/arm/boot/dts/qcom/qcom-apq8026-lg-lenok.dts                        |    2 
 arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts            |    2 
 arch/arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts                     |    4 
 arch/arm/boot/dts/qcom/qcom-apq8074-dragonboard.dts                     |    4 
 arch/arm/boot/dts/qcom/qcom-apq8084-ifc6540.dts                         |    2 
 arch/arm/boot/dts/qcom/qcom-apq8084-mtp.dts                             |    2 
 arch/arm/boot/dts/qcom/qcom-mdm9615-wp8548.dtsi                         |    2 
 arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi                                |   14 
 arch/arm/boot/dts/qcom/qcom-msm8660.dtsi                                |   16 
 arch/arm/boot/dts/qcom/qcom-msm8974-lge-nexus5-hammerhead.dts           |    4 
 arch/arm/boot/dts/qcom/qcom-msm8974-sony-xperia-rhine.dtsi              |    4 
 arch/arm/boot/dts/qcom/qcom-msm8974pro-fairphone-fp2.dts                |    4 
 arch/arm/boot/dts/qcom/qcom-msm8974pro-oneplus-bacon.dts                |    4 
 arch/arm/boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts                 |    2 
 arch/arm/boot/dts/qcom/qcom-msm8974pro-sony-xperia-shinano-castor.dts   |    4 
 arch/arm/boot/dts/qcom/qcom-pm8226.dtsi                                 |  180 -------
 arch/arm/boot/dts/qcom/qcom-pm8841.dtsi                                 |   68 --
 arch/arm/boot/dts/qcom/qcom-pm8941.dtsi                                 |  254 ----------
 arch/arm/boot/dts/qcom/qcom-pma8084.dtsi                                |   99 ---
 arch/arm/boot/dts/qcom/qcom-pmx55.dtsi                                  |   85 ---
 arch/arm/boot/dts/qcom/qcom-pmx65.dtsi                                  |   33 -
 arch/arm/boot/dts/qcom/qcom-sdx55-mtp.dts                               |    2 
 arch/arm/boot/dts/qcom/qcom-sdx55-t55.dts                               |    2 
 arch/arm/boot/dts/qcom/qcom-sdx55-telit-fn980-tlb.dts                   |    2 
 arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts                               |    2 
 arch/arm/boot/dts/rockchip/rk3036.dtsi                                  |   14 
 arch/arm/boot/dts/samsung/exynos4.dtsi                                  |   26 -
 arch/arm/boot/dts/samsung/exynos4x12.dtsi                               |   17 
 arch/arm/boot/dts/samsung/s5pv210.dtsi                                  |   18 
 arch/arm/include/asm/irq_work.h                                         |    2 
 arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts                   |    4 
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi                               |    4 
 arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts           |   14 
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi                |   20 
 arch/arm64/boot/dts/marvell/armada-3720-gl-mv1000.dts                   |   20 
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts                  |   85 +--
 arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts                    |   24 
 arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts              |   22 
 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi                             |   42 -
 arch/arm64/boot/dts/qcom/msm8996.dtsi                                   |   21 
 arch/arm64/boot/dts/qcom/msm8998.dtsi                                   |   32 -
 arch/arm64/boot/dts/qcom/sdm845.dtsi                                    |    5 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                                    |    5 
 arch/arm64/boot/dts/qcom/sm8250.dtsi                                    |   24 
 arch/arm64/boot/dts/qcom/sm8350.dtsi                                    |    8 
 arch/arm64/boot/dts/qcom/sm8450.dtsi                                    |    8 
 arch/arm64/boot/dts/qcom/sm8550.dtsi                                    |    8 
 arch/arm64/boot/dts/sprd/ums512.dtsi                                    |    3 
 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso                    |   40 -
 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso                    |   42 -
 arch/arm64/include/asm/irq_work.h                                       |    2 
 arch/arm64/kernel/irq.c                                                 |    7 
 arch/csky/include/asm/irq_work.h                                        |    2 
 arch/loongarch/kernel/asm-offsets.c                                     |   26 -
 arch/powerpc/crypto/aes-gcm-p10-glue.c                                  |    2 
 arch/powerpc/include/asm/irq_work.h                                     |    1 
 arch/powerpc/include/asm/mmu.h                                          |    4 
 arch/powerpc/include/asm/mmzone.h                                       |    8 
 arch/powerpc/kernel/traps.c                                             |    2 
 arch/powerpc/lib/sstep.c                                                |   10 
 arch/powerpc/mm/book3s64/pgtable.c                                      |    2 
 arch/powerpc/mm/init-common.c                                           |    5 
 arch/powerpc/mm/mmu_decl.h                                              |    5 
 arch/riscv/include/asm/irq_work.h                                       |    2 
 arch/riscv/kernel/head.S                                                |    1 
 arch/riscv/mm/init.c                                                    |   12 
 arch/s390/boot/ipl_parm.c                                               |    2 
 arch/s390/boot/startup.c                                                |    3 
 arch/s390/include/asm/irq_work.h                                        |    2 
 arch/s390/kernel/ptrace.c                                               |    6 
 arch/s390/kvm/kvm-s390.c                                                |    5 
 arch/sparc/kernel/asm-offsets.c                                         |    6 
 arch/um/drivers/net_kern.c                                              |    2 
 arch/um/include/shared/kern_util.h                                      |    2 
 arch/um/kernel/process.c                                                |    2 
 arch/um/kernel/time.c                                                   |   32 +
 arch/um/os-Linux/helper.c                                               |    6 
 arch/um/os-Linux/util.c                                                 |   19 
 arch/x86/boot/compressed/ident_map_64.c                                 |    5 
 arch/x86/boot/compressed/idt_64.c                                       |    1 
 arch/x86/boot/compressed/idt_handlers_64.S                              |    1 
 arch/x86/boot/compressed/misc.h                                         |    1 
 arch/x86/include/asm/irq_work.h                                         |    1 
 arch/x86/include/asm/kmsan.h                                            |   17 
 arch/x86/kernel/cpu/mce/core.c                                          |   16 
 block/bio.c                                                             |    2 
 block/blk-mq.c                                                          |   16 
 drivers/accel/habanalabs/common/device.c                                |   17 
 drivers/accel/habanalabs/common/habanalabs.h                            |    2 
 drivers/accel/habanalabs/common/habanalabs_drv.c                        |    3 
 drivers/accel/habanalabs/common/mmu/mmu.c                               |    1 
 drivers/accel/habanalabs/common/sysfs.c                                 |    3 
 drivers/accel/habanalabs/gaudi2/gaudi2.c                                |   14 
 drivers/accel/habanalabs/include/hw_ip/pci/pci_general.h                |    1 
 drivers/acpi/acpi_extlog.c                                              |    5 
 drivers/acpi/acpi_video.c                                               |    9 
 drivers/acpi/apei/ghes.c                                                |   29 -
 drivers/acpi/numa/srat.c                                                |    4 
 drivers/acpi/resource.c                                                 |   21 
 drivers/base/arch_numa.c                                                |    2 
 drivers/block/rnbd/rnbd-srv.c                                           |   19 
 drivers/bluetooth/hci_qca.c                                             |    1 
 drivers/char/hw_random/jh7110-trng.c                                    |    2 
 drivers/clk/hisilicon/clk-hi3620.c                                      |    4 
 drivers/clk/imx/clk-imx8qxp.c                                           |   24 
 drivers/clk/imx/clk-scu.c                                               |    4 
 drivers/clk/mmp/clk-of-pxa168.c                                         |    3 
 drivers/crypto/caam/caamalg_qi2.c                                       |    7 
 drivers/crypto/caam/caamhash.c                                          |    7 
 drivers/crypto/marvell/octeontx2/otx2_cptlf.c                           |    6 
 drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c                      |    3 
 drivers/crypto/starfive/jh7110-cryp.c                                   |    2 
 drivers/crypto/stm32/stm32-crc32.c                                      |    2 
 drivers/devfreq/devfreq.c                                               |   24 
 drivers/extcon/extcon.c                                                 |    3 
 drivers/gpu/drm/amd/amdgpu/aldebaran.c                                  |   26 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c                        |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                              |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c                                 |   21 
 drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c                                 |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c                                 |   31 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h                                 |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c                              |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h                              |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                                 |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c                                |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                                 |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c                               |    6 
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c                                |    4 
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c                                |    4 
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c                                  |    4 
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c                                  |    5 
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c                                   |    4 
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c                                   |    4 
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c                                   |    4 
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c                                   |    8 
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c                                 |    4 
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c                  |    2 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                                    |   42 -
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c                               |   24 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                       |   30 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c                  |    9 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c          |   71 ++
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h          |   11 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c            |    8 
 drivers/gpu/drm/amd/display/dc/core/dc.c                                |    4 
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h                            |    2 
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c                          |    2 
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c                   |    9 
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c           |    5 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c          |    3 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c     |   33 +
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h     |    1 
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c                 |    2 
 drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c                        |    8 
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c               |    5 
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c                 |    3 
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c                 |   23 
 drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c                 |    3 
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c                 |   25 
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h                         |    1 
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h                            |    4 
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c                         |   40 +
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c         |  221 +++-----
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h         |    4 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c     |   12 
 drivers/gpu/drm/amd/display/include/audio_types.h                       |    2 
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c               |    2 
 drivers/gpu/drm/amd/include/amd_shared.h                                |    2 
 drivers/gpu/drm/amd/include/mes_v11_api_def.h                           |    3 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c          |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c                     |   17 
 drivers/gpu/drm/bridge/analogix/anx7625.c                               |   51 +-
 drivers/gpu/drm/bridge/analogix/anx7625.h                               |    4 
 drivers/gpu/drm/drm_file.c                                              |    2 
 drivers/gpu/drm/drm_framebuffer.c                                       |    2 
 drivers/gpu/drm/drm_mipi_dsi.c                                          |   17 
 drivers/gpu/drm/exynos/exynos_drm_drv.c                                 |   11 
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c                                   |   23 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h                  |   18 
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h                  |   18 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                             |    6 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h                        |    4 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c                    |   32 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c                    |   33 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c                               |    3 
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h                                 |    1 
 drivers/gpu/drm/msm/dp/dp_display.c                                     |    6 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c                                   |    4 
 drivers/gpu/drm/msm/msm_mdss.c                                          |    2 
 drivers/gpu/drm/panel/panel-edp.c                                       |   48 +
 drivers/hid/hidraw.c                                                    |    7 
 drivers/hwmon/hp-wmi-sensors.c                                          |  127 ++++-
 drivers/hwmon/nct6775-core.c                                            |    7 
 drivers/i2c/busses/i2c-rk3x.c                                           |    8 
 drivers/i3c/master/i3c-master-cdns.c                                    |    7 
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c                          |    7 
 drivers/leds/trigger/ledtrig-panic.c                                    |    5 
 drivers/mailbox/arm_mhuv2.c                                             |    3 
 drivers/md/md.c                                                         |   54 +-
 drivers/media/i2c/imx335.c                                              |    4 
 drivers/media/i2c/ov2740.c                                              |   17 
 drivers/media/pci/ddbridge/ddbridge-main.c                              |    2 
 drivers/media/platform/amphion/vpu.h                                    |    3 
 drivers/media/platform/amphion/vpu_cmds.c                               |   28 -
 drivers/media/platform/amphion/vpu_v4l2.c                               |    1 
 drivers/media/platform/rockchip/rga/rga.c                               |   15 
 drivers/media/platform/rockchip/rkisp1/rkisp1-common.h                  |   11 
 drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c                     |   14 
 drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c                     |   35 +
 drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c                     |   20 
 drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c                 |   38 -
 drivers/media/usb/stk1160/stk1160-video.c                               |    5 
 drivers/media/usb/uvc/uvc_driver.c                                      |   18 
 drivers/mfd/Kconfig                                                     |    1 
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c                                  |    1 
 drivers/net/bonding/bond_alb.c                                          |    3 
 drivers/net/dsa/mt7530.c                                                |    3 
 drivers/net/dsa/mv88e6xxx/chip.h                                        |    4 
 drivers/net/dsa/mv88e6xxx/serdes.c                                      |   10 
 drivers/net/dsa/mv88e6xxx/serdes.h                                      |    8 
 drivers/net/dsa/qca/qca8k-8xxx.c                                        |   24 
 drivers/net/ethernet/amd/pds_core/adminq.c                              |   64 +-
 drivers/net/ethernet/amd/pds_core/core.c                                |   46 +
 drivers/net/ethernet/amd/pds_core/core.h                                |    2 
 drivers/net/ethernet/amd/pds_core/debugfs.c                             |    4 
 drivers/net/ethernet/amd/pds_core/dev.c                                 |   16 
 drivers/net/ethernet/amd/pds_core/devlink.c                             |    3 
 drivers/net/ethernet/amd/pds_core/fw.c                                  |    3 
 drivers/net/ethernet/amd/pds_core/main.c                                |   26 -
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.c                         |   28 -
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c                        |   61 --
 drivers/net/ethernet/aquantia/atlantic/aq_ring.h                        |   22 
 drivers/net/ethernet/aquantia/atlantic/aq_vec.c                         |   23 
 drivers/net/ethernet/google/gve/gve_rx.c                                |    8 
 drivers/net/ethernet/intel/e1000/e1000_hw.c                             |    1 
 drivers/net/ethernet/intel/e1000e/e1000.h                               |   20 
 drivers/net/ethernet/intel/e1000e/ptp.c                                 |   22 
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c                             |    1 
 drivers/net/ethernet/intel/fm10k/fm10k_vf.c                             |    1 
 drivers/net/ethernet/intel/i40e/i40e_common.c                           |    1 
 drivers/net/ethernet/intel/i40e/i40e_dcb.c                              |    2 
 drivers/net/ethernet/intel/i40e/i40e_nvm.c                              |    1 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                      |   32 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h                      |    1 
 drivers/net/ethernet/intel/iavf/iavf_common.c                           |    3 
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c                          |    5 
 drivers/net/ethernet/intel/iavf/iavf_fdir.c                             |    1 
 drivers/net/ethernet/intel/iavf/iavf_txrx.c                             |    1 
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h                         |   18 
 drivers/net/ethernet/intel/ice/ice_lib.c                                |    7 
 drivers/net/ethernet/intel/ice/ice_virtchnl.c                           |   12 
 drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c                       |   16 
 drivers/net/ethernet/intel/idpf/virtchnl2.h                             |    2 
 drivers/net/ethernet/intel/igb/e1000_i210.c                             |    4 
 drivers/net/ethernet/intel/igb/e1000_nvm.c                              |    4 
 drivers/net/ethernet/intel/igb/e1000_phy.c                              |    4 
 drivers/net/ethernet/intel/igbvf/netdev.c                               |   28 -
 drivers/net/ethernet/intel/igc/igc_i225.c                               |    1 
 drivers/net/ethernet/intel/igc/igc_phy.c                                |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c                          |   36 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c                          |   61 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c                         |  145 ++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c                        |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                           |   42 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c                            |   34 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h                            |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c                            |  105 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h                            |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c                          |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h                           |   43 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c                           |   44 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c                           |  149 +++--
 drivers/net/ethernet/marvell/mvmdio.c                                   |   53 --
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c                     |   13 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c               |    1 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c                    |    3 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c                  |    7 
 drivers/net/ethernet/mediatek/mtk_eth_soc.c                             |    5 
 drivers/net/ethernet/microchip/lan966x/lan966x_port.c                   |    5 
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c                     |    4 
 drivers/net/ethernet/pensando/ionic/ionic_dev.c                         |    1 
 drivers/net/ethernet/pensando/ionic/ionic_dev.h                         |    1 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                         |    3 
 drivers/net/ethernet/pensando/ionic/ionic_main.c                        |   22 
 drivers/net/phy/at803x.c                                                |    6 
 drivers/net/phy/mediatek-ge-soc.c                                       |  147 +++--
 drivers/net/phy/micrel.c                                                |    6 
 drivers/net/usb/ax88179_178a.c                                          |    2 
 drivers/net/virtio_net.c                                                |    9 
 drivers/net/wireless/ath/ath11k/pcic.c                                  |    4 
 drivers/net/wireless/ath/ath12k/hal.c                                   |    4 
 drivers/net/wireless/ath/ath12k/hw.c                                    |    3 
 drivers/net/wireless/ath/ath12k/mac.c                                   |    4 
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c                           |    5 
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c                    |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c                         |    8 
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c                          |    2 
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c                          |    3 
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c                          |   11 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c                   |   12 
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c                    |    6 
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c                    |    4 
 drivers/net/wireless/realtek/rtw89/coex.c                               |    4 
 drivers/net/wireless/realtek/rtw89/core.c                               |    2 
 drivers/net/wireless/realtek/rtw89/core.h                               |   12 
 drivers/net/wireless/realtek/rtw89/fw.c                                 |   17 
 drivers/net/wireless/realtek/rtw89/mac.c                                |  100 +++
 drivers/net/wireless/realtek/rtw89/mac.h                                |    1 
 drivers/net/wireless/realtek/rtw89/mac80211.c                           |    3 
 drivers/net/wireless/realtek/rtw89/reg.h                                |   17 
 drivers/net/wireless/silabs/wfx/sta.c                                   |   42 -
 drivers/opp/core.c                                                      |    9 
 drivers/pci/pci.h                                                       |    2 
 drivers/pci/pcie/aer.c                                                  |    9 
 drivers/pci/quirks.c                                                    |   24 
 drivers/pci/switch/switchtec.c                                          |   25 
 drivers/perf/arm_pmuv3.c                                                |    6 
 drivers/pinctrl/intel/pinctrl-baytrail.c                                |    3 
 drivers/pnp/pnpacpi/rsparser.c                                          |   12 
 drivers/regulator/core.c                                                |   56 +-
 drivers/regulator/ti-abb-regulator.c                                    |   22 
 drivers/s390/crypto/vfio_ap_ops.c                                       |   16 
 drivers/scsi/arcmsr/arcmsr.h                                            |    4 
 drivers/scsi/arcmsr/arcmsr_hba.c                                        |    6 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                                  |   10 
 drivers/scsi/isci/request.c                                             |    2 
 drivers/scsi/libfc/fc_fcp.c                                             |   18 
 drivers/scsi/lpfc/lpfc.h                                                |    1 
 drivers/scsi/lpfc/lpfc_els.c                                            |   14 
 drivers/scsi/lpfc/lpfc_init.c                                           |    4 
 drivers/scsi/lpfc/lpfc_vmid.c                                           |    1 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                         |    3 
 drivers/scsi/mpi3mr/mpi3mr_os.c                                         |   13 
 drivers/scsi/scsi_error.c                                               |    8 
 drivers/scsi/scsi_lib.c                                                 |    2 
 drivers/scsi/scsi_priv.h                                                |    2 
 drivers/soc/xilinx/xlnx_event_manager.c                                 |    7 
 drivers/spmi/spmi-mtk-pmif.c                                            |    7 
 drivers/staging/vme_user/vme.c                                          |    2 
 drivers/thermal/thermal_core.c                                          |   30 -
 drivers/tty/serial/8250/8250_pci.c                                      |   58 ++
 drivers/tty/tty_ioctl.c                                                 |    4 
 drivers/usb/core/hub.c                                                  |   33 +
 drivers/usb/host/xhci-plat.c                                            |   23 
 drivers/watchdog/it87_wdt.c                                             |   14 
 drivers/watchdog/starfive-wdt.c                                         |    2 
 drivers/xen/gntdev-dmabuf.c                                             |   50 -
 fs/9p/v9fs_vfs.h                                                        |    1 
 fs/9p/vfs_inode.c                                                       |    6 
 fs/9p/vfs_inode_dotl.c                                                  |    1 
 fs/afs/callback.c                                                       |    3 
 fs/ceph/caps.c                                                          |    9 
 fs/ceph/mds_client.c                                                    |    2 
 fs/ceph/quota.c                                                         |   39 -
 fs/dcache.c                                                             |    7 
 fs/ecryptfs/inode.c                                                     |    8 
 fs/erofs/zdata.c                                                        |    2 
 fs/erofs/zmap.c                                                         |   32 -
 fs/ext4/extents.c                                                       |    6 
 fs/ext4/mballoc.c                                                       |   11 
 fs/ext4/resize.c                                                        |   37 -
 fs/f2fs/compress.c                                                      |    4 
 fs/f2fs/file.c                                                          |    2 
 fs/f2fs/recovery.c                                                      |   25 
 fs/jfs/jfs_dmap.c                                                       |   57 +-
 fs/jfs/jfs_dtree.c                                                      |    7 
 fs/jfs/jfs_imap.c                                                       |    3 
 fs/jfs/jfs_mount.c                                                      |    6 
 fs/kernfs/dir.c                                                         |   12 
 fs/ocfs2/namei.c                                                        |    8 
 fs/proc/proc_sysctl.c                                                   |    9 
 fs/pstore/ram.c                                                         |    1 
 fs/reiserfs/namei.c                                                     |   54 +-
 fs/smb/client/cifsglob.h                                                |   30 -
 fs/smb/client/cifsproto.h                                               |   15 
 fs/smb/client/cifssmb.c                                                 |   17 
 fs/smb/client/inode.c                                                   |    3 
 fs/smb/client/link.c                                                    |    4 
 fs/smb/client/sess.c                                                    |   14 
 fs/smb/client/smb2inode.c                                               |   55 +-
 fs/smb/client/smb2proto.h                                               |   16 
 fs/tracefs/event_inode.c                                                |  117 +++-
 fs/tracefs/inode.c                                                      |  198 ++++---
 fs/tracefs/internal.h                                                   |    4 
 include/asm-generic/numa.h                                              |    2 
 include/asm-generic/unaligned.h                                         |   24 
 include/drm/drm_color_mgmt.h                                            |    1 
 include/drm/drm_mipi_dsi.h                                              |    2 
 include/linux/avf/virtchnl.h                                            |    1 
 include/linux/bpf.h                                                     |    2 
 include/linux/irq_work.h                                                |    3 
 include/linux/mm_types.h                                                |    3 
 include/linux/mmzone.h                                                  |    6 
 include/linux/pci_ids.h                                                 |    1 
 include/linux/pm_opp.h                                                  |    4 
 include/linux/thermal.h                                                 |    2 
 include/net/af_unix.h                                                   |   20 
 include/net/ip.h                                                        |    2 
 include/net/netfilter/nf_tables.h                                       |    2 
 kernel/audit.c                                                          |   31 -
 kernel/bpf/arraymap.c                                                   |   23 
 kernel/bpf/helpers.c                                                    |   15 
 kernel/bpf/syscall.c                                                    |    6 
 kernel/events/core.c                                                    |   38 +
 kernel/sched/fair.c                                                     |   56 ++
 lib/debugobjects.c                                                      |  200 +++----
 lib/fw_table.c                                                          |   30 -
 lib/kunit/executor.c                                                    |    4 
 lib/kunit/test.c                                                        |   15 
 net/bluetooth/hci_sync.c                                                |   10 
 net/bluetooth/iso.c                                                     |   51 +-
 net/bluetooth/l2cap_core.c                                              |    3 
 net/bpf/test_run.c                                                      |    2 
 net/bridge/br_cfm_netlink.c                                             |    2 
 net/bridge/br_multicast.c                                               |   20 
 net/bridge/br_private.h                                                 |    4 
 net/devlink/port.c                                                      |    2 
 net/ipv4/ip_output.c                                                    |   12 
 net/ipv4/ip_sockglue.c                                                  |    6 
 net/ipv4/ipmr.c                                                         |    2 
 net/ipv4/raw.c                                                          |    2 
 net/ipv4/tcp.c                                                          |   12 
 net/ipv4/udp.c                                                          |    2 
 net/ipv6/addrconf_core.c                                                |   21 
 net/ipv6/ip6_tunnel.c                                                   |   21 
 net/kcm/kcmsock.c                                                       |    2 
 net/llc/af_llc.c                                                        |    2 
 net/netfilter/nf_conntrack_proto_tcp.c                                  |   10 
 net/netfilter/nf_log.c                                                  |    7 
 net/netfilter/nf_tables_api.c                                           |   14 
 net/netfilter/nft_ct.c                                                  |   24 
 net/netfilter/nft_tunnel.c                                              |    1 
 net/rxrpc/conn_service.c                                                |    3 
 net/smc/smc_clc.c                                                       |   14 
 net/sunrpc/xprtmultipath.c                                              |   17 
 net/unix/af_unix.c                                                      |   14 
 net/unix/diag.c                                                         |    2 
 net/wireless/scan.c                                                     |    4 
 sound/hda/hdac_stream.c                                                 |    9 
 sound/hda/intel-dsp-config.c                                            |   10 
 sound/pci/hda/hda_intel.c                                               |    2 
 sound/pci/hda/patch_conexant.c                                          |  115 ++++
 sound/soc/amd/acp-config.c                                              |   15 
 sound/soc/codecs/lpass-wsa-macro.c                                      |    7 
 sound/soc/codecs/rtq9128.c                                              |   73 +-
 sound/soc/codecs/wcd938x.c                                              |    2 
 sound/soc/codecs/wsa883x.c                                              |    6 
 sound/soc/qcom/sc8280xp.c                                               |   12 
 tools/build/feature/test-libopencsd.c                                   |    4 
 tools/lib/bpf/libbpf.c                                                  |    2 
 tools/lib/bpf/libbpf_common.h                                           |   13 
 tools/lib/subcmd/help.c                                                 |   18 
 tools/testing/kunit/kunit_parser.py                                     |    4 
 tools/testing/selftests/bpf/cgroup_helpers.c                            |   18 
 tools/testing/selftests/bpf/prog_tests/btf.c                            |    6 
 tools/testing/selftests/bpf/prog_tests/tc_opts.c                        |    6 
 tools/testing/selftests/bpf/progs/pyperf180.c                           |   22 
 tools/testing/selftests/bpf/progs/test_global_func17.c                  |    1 
 tools/testing/selftests/bpf/veristat.c                                  |    2 
 tools/testing/selftests/bpf/xdp_hw_metadata.c                           |    2 
 tools/testing/selftests/drivers/net/bonding/lag_lib.sh                  |   11 
 tools/testing/selftests/drivers/net/team/config                         |    4 
 tools/testing/selftests/net/Makefile                                    |    5 
 tools/testing/selftests/net/config                                      |   16 
 tools/testing/selftests/net/pmtu.sh                                     |   18 
 tools/testing/selftests/net/setup_veth.sh                               |    2 
 tools/testing/selftests/net/udpgro.sh                                   |    4 
 tools/testing/selftests/net/udpgro_bench.sh                             |    4 
 tools/testing/selftests/net/udpgro_frglist.sh                           |    6 
 tools/testing/selftests/net/udpgro_fwd.sh                               |    8 
 tools/testing/selftests/net/veth.sh                                     |    4 
 tools/testing/selftests/net/xdp_dummy.c                                 |   13 
 tools/testing/selftests/nolibc/nolibc-test.c                            |    4 
 tools/testing/selftests/sgx/test_encl.lds                               |    6 
 517 files changed, 5331 insertions(+), 3339 deletions(-)

Abhinav Kumar (1):
      drm/msm/dpu: fix writeback programming for YUV cases

Adrian Reber (1):
      tty: allow TIOCSLCKTRMIOS with CAP_CHECKPOINT_RESTORE

Ahmed Zaki (1):
      ice: fix ICE_AQ_VSI_Q_OPT_RSS_* register values

Al Viro (1):
      fast_dput(): handle underflows gracefully

Alex Deucher (2):
      drm/amdgpu: apply the RV2 system aperture fix to RN/CZN as well
      drm/amdgpu: fix avg vs input power reporting on smu7

Alex Lyakas (1):
      md: Whenassemble the array, consult the superblock of the freshest device

Alexander Gordeev (1):
      s390/boot: always align vmalloc area on segment boundary

Alexander Stein (4):
      ARM: dts: imx7d: Fix coresight funnel ports
      ARM: dts: imx7s: Fix lcdif compatible
      ARM: dts: imx7s: Fix nand-controller #size-cells
      clk: imx: clk-imx8qxp: fix LVDS bypass, pixel and phy clocks

Alexandre Ghiti (1):
      riscv: Fix build error on rv32 + XIP

Alexei Starovoitov (1):
      x86/cfi,bpf: Fix bpf_exception_cb() signature

Allen Pan (1):
      drm/amd/display: fix usb-c connector_type

Alvin Lee (3):
      drm/amd/display: For prefetch mode > 0, extend prefetch if possible
      drm/amd/display: Force p-state disallow if leaving no plane config
      drm/amd/display: Only clear symclk otg flag for HDMI

Andrii Nakryiko (3):
      selftests/bpf: fix RELEASE=1 build for tc_opts
      selftests/bpf: satisfy compiler by having explicit return in btf test
      selftests/bpf: fix compiler warnings in RELEASE=1 mode

Andrii Staikov (1):
      i40e: Fix VF disable behavior to block all traffic

Andrzej Hajda (1):
      debugobjects: Stop accessing objects after releasing hash bucket lock

Andy Shevchenko (1):
      pinctrl: baytrail: Fix types of config value in byt_pin_config_set()

Anna Schumaker (1):
      SUNRPC: Fix a suspicious RCU usage warning

Anton Ivanov (1):
      um: Fix naming clash between UML and scheduler

Arnd Bergmann (2):
      arch: consolidate arch_irq_work_raise prototypes
      arch: fix asm-offsets.c building with -Wmissing-prototypes

Baochen Qiang (1):
      wifi: ath11k: fix race due to setting ATH11K_FLAG_EXT_IRQ_ENABLED too early

Baokun Li (3):
      ext4: unify the type of flexbg_size to unsigned int
      ext4: remove unnecessary check from alloc_flex_gd()
      ext4: avoid online resizing failures due to oversized flex bg

Ben Dooks (1):
      watchdog: starfive: add lock annotations to fix context imbalances

Ben Mayo (1):
      ACPI: resource: Add DMI quirks for ASUS Vivobook E1504GA and E1504GAB

Benjamin Berg (2):
      wifi: cfg80211: free beacon_ies when overridden from hidden BSS
      um: Don't use vfprintf() for os_info()

Benjamin Poirier (2):
      selftests: team: Add missing config options
      selftests: bonding: Check initial state

Bharat Bhushan (1):
      crypto: octeontx2 - Fix cptvf driver cleanup

Bjorn Helgaas (1):
      PCI/AER: Decode Requester ID when no error info found

Breno Leitao (1):
      net: sysfs: Fix /sys/class/net/<iface> path

Brett Creeley (6):
      pds_core: Prevent health thread from running during reset/remove
      pds_core: Cancel AQ work on teardown
      pds_core: Use struct pdsc for the pdsc_adminq_isr private data
      pds_core: Prevent race issues involving the adminq
      pds_core: Clear BARs on reset
      pds_core: Rework teardown/setup flow to be more common

Chao Yu (2):
      f2fs: fix to check return value of f2fs_reserve_new_block()
      f2fs: fix to tag gcing flag on page during block migration

ChiYuan Huang (2):
      ASoC: codecs: rtq9128: Fix PM_RUNTIME usage
      ASoC: codecs: rtq9128: Fix TDM enable and DAI format control flow

Chih-Kang Chang (1):
      wifi: rtw89: fix misbehavior of TX beacon in concurrent mode

Ching-Te Ku (1):
      wifi: rtw89: coex: Fix wrong Wi-Fi role info and FDDT parameter members

Chris Riches (1):
      audit: Send netlink ACK before setting connection in auditd_set

Christian Marangi (1):
      net: phy: at803x: fix passing the wrong reference for config_intr

Christoph Hellwig (1):
      block: prevent an integer overflow in bvec_try_merge_hw_page

Christophe JAILLET (1):
      ixgbe: Fix an error handling path in ixgbe_read_iosf_sb_reg_x550()

Chunyan Zhang (2):
      arm64: dts: sprd: Add clock reference for pll2 on UMS512
      arm64: dts: sprd: Change UMS512 idle-state nodename to match bindings

Crescent CY Hsieh (1):
      tty: serial: 8250: Set RS422 interface by default to fix Moxa RS422/RS485 PCIe boards

Cristian Ciocaltea (1):
      ASoC: doc: Fix undefined SND_SOC_DAPM_NOPM argument

Dafna Hirschfeld (1):
      accel/habanalabs/gaudi2: fix undef opcode reporting

Daniel Golle (3):
      net: ethernet: mtk_eth_soc: set DMA coherent mask to get PPE working
      net: phy: mediatek-ge-soc: sync driver with MediaTek SDK
      net: dsa: mt7530: fix 10M/100M speed on MT7988 switch

Daniel Miess (1):
      Revert "drm/amd/display: Fix conversions between bytes and KB"

Daniel Stodden (1):
      PCI: switchtec: Fix stdev_release() crash after surprise hot remove

Daniel Vacek (1):
      IB/ipoib: Fix mcast list locking

Danylo Piliaiev (1):
      drm/msm/a690: Fix reg values for a690

David Howells (1):
      9p: Fix initialisation of netfs_inode for 9p

Dennis Chan (1):
      drm/amd/display: Fix Replay Desync Error IRQ handler

Dmitry Antipov (3):
      PNP: ACPI: fix fortify warning
      wifi: rtw89: fix timeout calculation in rtw89_roc_end()
      wifi: wfx: fix possible NULL pointer dereference in wfx_set_mfp_ap()

Dmitry Baryshkov (5):
      ARM: dts: qcom: strip prefix from PMIC files
      ARM: dts: qcom: mdm9615: fix PMIC node labels
      ARM: dts: qcom: msm8660: fix PMIC node labels
      drm/msm/dpu: enable writeback on SM8350
      drm/msm/dpu: enable writeback on SM8450

Dmitry Torokhov (1):
      asm-generic: make sparse happy with odd-sized put_unaligned_*()

Douglas Anderson (1):
      drm/exynos: Call drm_atomic_helper_shutdown() at shutdown/unbind time

Edward Adam Davis (3):
      jfs: fix uaf in jfs_evict_inode
      jfs: fix array-index-out-of-bounds in diNewExt
      wifi: cfg80211: fix RCU dereference in __cfg80211_bss_update

Eric Dumazet (4):
      ip6_tunnel: make sure to pull inner header in __ip6_tnl_rcv()
      tcp: add sanity checks to rx zerocopy
      llc: call sock_orphan() at release time
      af_unix: fix lockdep positive in sk_diag_dump_icons()

Fabio Estevam (9):
      ARM: dts: imx25/27-eukrea: Fix RTC node name
      ARM: dts: imx: Use flash@0,0 pattern
      ARM: dts: imx27: Fix sram node
      ARM: dts: imx1: Fix sram node
      ARM: dts: imx25: Fix the iim compatible string
      ARM: dts: imx25/27: Pass timing0
      ARM: dts: imx27-apf27dev: Fix LED name
      ARM: dts: imx23-sansa: Use preferred i2c-gpios properties
      ARM: dts: imx23/28: Fix the DMA controller node name

Farah Kassabri (1):
      accel/habanalabs: fix EQ heartbeat mechanism

Felix Kuehling (2):
      drm/amdgpu: Let KFD sync with VM fences
      drm/amdkfd: Fix lock dependency warning

Frederik Haxel (1):
      riscv: Make XIP bootable again

Frédéric Danis (1):
      Bluetooth: L2CAP: Fix possible multiple reject send

Gabriel Krisman Bertazi (1):
      ecryptfs: Reject casefold directory inodes

Gao Xiang (2):
      erofs: fix up compacted indexes for block size < 4096
      erofs: fix ztailpacking for subpage compressed blocks

Gaurav Jain (1):
      crypto: caam - fix asynchronous hash

Geetha sowjanya (1):
      octeontx2-pf: Remove xdp queues on program detach

Ghanshyam Agrawal (1):
      media: stk1160: Fixed high volume of stk1160_dbg messages

Greg KH (1):
      perf/core: Fix narrow startup race when creating the perf nr_addr_filters sysfs file

Greg Kroah-Hartman (1):
      Linux 6.7.4

Guilherme G. Piccoli (1):
      PCI: Only override AMD USB controller if required

Gustavo A. R. Silva (1):
      crypto: p10-aes-gcm - Avoid -Wstringop-overflow warnings

Hannes Reinecke (2):
      scsi: libfc: Don't schedule abort twice
      scsi: libfc: Fix up timeout error in fc_fcp_rec_error()

Hans de Goede (2):
      media: ov2740: Fix hts value
      misc: lis3lv02d_i2c: Add missing setting of the reg_ctrl callback

Hardik Gajjar (2):
      usb: hub: Replace hardcoded quirk value with BIT() macro
      usb: hub: Add quirk to decrease IN-ep poll interval for Microchip USB491x hub

HariBabu Gattem (1):
      soc: xilinx: Fix for call trace due to the usage of smp_processor_id()

Harshit Shah (1):
      i3c: master: cdns: Update maximum prescaler value for i2c clock

Heiko Carstens (2):
      s390/ptrace: handle setting of fpc register correctly
      KVM: s390: fix setting of fpc register

Heiner Kallweit (1):
      leds: trigger: panic: Don't register panic notifier if creating the trigger failed

Helge Deller (1):
      ipv6: Ensure natural alignment of const ipv6 loopback and router addresses

Horatiu Vultur (1):
      net: lan966x: Fix port configuration when using SGMII interface

Hou Tao (3):
      bpf: Check rcu_read_lock_trace_held() before calling bpf map helpers
      bpf: Set need_defer as false when clearing fd array during map free
      bpf: Set uattr->batch.count as zero before batched update or deletion

Hsin-Yi Wang (1):
      drm/panel-edp: Add override_edid_mode quirk for generic edp

Huang Shijie (2):
      arm64: irq: set the correct node for VMAP stack
      arm64: irq: set the correct node for shadow call stack

Ian Rogers (1):
      libsubcmd: Fix memory leak in uniq()

Ido Schimmel (2):
      PCI: Add no PM reset quirk for NVIDIA Spectrum devices
      selftests: net: Add missing matchall classifier

Igor Russkikh (1):
      net: atlantic: eliminate double free in error handling logic

Ilpo Järvinen (1):
      PCI: Fix 64GT/s effective data rate calculation

Ilya Bakoulin (1):
      drm/amd/display: Fix MST PBN/X.Y value calculations

Iulia Tanasescu (1):
      Bluetooth: ISO: Avoid creating child socket if PA sync is terminating

Ivan Lipski (1):
      Re-revert "drm/amd/display: Enable Replay for static screen use cases"

Jack Wang (1):
      RDMA/IPoIB: Fix error code return in ipoib_mcast_join

Jacob Keller (1):
      e1000e: correct maximum frequency adjustment values

Jaegeuk Kim (1):
      f2fs: fix write pointers on zoned device after roll forward

Jakub Kicinski (2):
      selftests: net: add missing config for nftables-backed iptables
      selftests: net: add missing config for NF_TARGET_TTL

James Clark (1):
      perf cs-etm: Bump minimum OpenCSD version to ensure a bugfix is present

James Seo (1):
      hwmon: (hp-wmi-sensors) Fix failure to load on EliteDesk 800 G6

Jan Kara (2):
      reiserfs: Avoid touching renamed directory if parent does not change
      ocfs2: Avoid touching renamed directory if parent does not change

Jedrzej Jagielski (2):
      ixgbe: Refactor returning internal error codes
      ixgbe: Refactor overtemp event handling

Jesse Brandeburg (2):
      intel: add bit macro includes where needed
      ice: fix pre-shifted bit usage

Jia Jie Ho (2):
      hwrng: starfive - Fix dev_err_probe return error
      crypto: starfive - Fix dev_err_probe return error

Jo Van Bulck (1):
      selftests/sgx: Fix linker script asserts

Joel Granados (1):
      sysctl: Fix out of bounds access for empty sysctl registers

Johan Hovold (4):
      ASoC: qcom: sc8280xp: limit speaker volumes
      ASoC: codecs: wcd938x: fix headphones volume controls
      ASoC: codecs: lpass-wsa-macro: fix compander volume hack
      ASoC: codecs: wsa883x: fix PA volume control

Johan Jonker (1):
      ARM: dts: rockchip: fix rk3036 hdmi ports node

Johannes Berg (1):
      um: time-travel: fix time corruption

Jonathan Gray (1):
      Revert "drm/amd/display: Disable PSR-SU on Parade 0803 TCON again"

Jonathan Kim (2):
      drm/amdkfd: fix mes set shader debugger process management
      drm/amdkfd: only flush mes process context if mes support is there

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: avoid two consecutive device resets

Josip Pavic (1):
      drm/amd/display: make flip_timestamp_in_us a 64-bit variable

Jun'ichi Nomura (1):
      x86/boot: Ignore NMIs during very early boot

Justin Tee (3):
      scsi: lpfc: Fix possible file string name overflow when updating firmware
      scsi: lpfc: Reinitialize an NPIV's VMID data structures after FDISC
      scsi: lpfc: Move determination of vmid_flag after VMID reinitialization completes

Kang Yang (1):
      wifi: ath12k: fix and enable AP mode for WCN7850

Kees Cook (1):
      block/rnbd-srv: Check for unlikely string overflow

Kieran Bingham (1):
      media: i2c: imx335: Fix hblank min/max values

Konrad Dybcio (1):
      drm/msm/dsi: Enable runtime PM

Kory Maincent (1):
      net: phy: micrel: fix ts_info value in case of no phc

Krzysztof Kozlowski (2):
      ARM: dts: samsung: exynos4: fix camera unit addresses/ranges
      ARM: dts: samsung: s5pv210: fix camera unit addresses/ranges

Kuan-Wei Chiu (3):
      clk: hi3620: Fix memory leak in hi3620_mmc_clk_init()
      clk: mmp: pxa168: Fix memory leak in pxa168_clk_init()
      clk: imx: scu: Fix memory leak in __imx_clk_gpr_scu()

Kunwu Chan (1):
      powerpc/mm: Fix null-pointer dereference in pgtable_cache_add

Laurent Pinchart (1):
      media: rkisp1: resizer: Stop manual allocation of v4l2_subdev_state

Lin Ma (1):
      bridge: cfm: fix enum typo in br_cc_ccm_tx_parse

Lingbo Kong (1):
      wifi: ath12k: fix the issue that the multicast/broadcast indicator is not read correctly for WCN7850

Linus Lüssing (1):
      bridge: mcast: fix disabled snooping after long uptime

Linus Torvalds (1):
      tracefs: remove stale 'update_gid' code

Linus Walleij (3):
      ARM: dts: marvell: Fix some common switch mistakes
      ARM64: dts: marvell: Fix some common switch mistakes
      ARM: dts: usr8200: Fix phy registers

Manas Ghandat (2):
      jfs: fix slab-out-of-bounds Read in dtSearch
      jfs: fix array-index-out-of-bounds in dbAdjTree

Mao Jinlong (3):
      arm64: dts: qcom: msm8996: Fix 'in-ports' is a required property
      arm64: dts: qcom: msm8998: Fix 'out-ports' is a required property
      arm64: dts: qcom: Fix coresight warnings in in-ports and out-ports

Marco Elver (1):
      mm, kmsan: fix infinite recursion due to RCU critical section

Marco Pagani (1):
      kunit: run test suites only after module initialization completes

Mark Rutland (1):
      drivers/perf: pmuv3: don't expose SW_INCR event in sysfs

Martin Tsai (1):
      drm/amd/display: To adjust dprefclk by down spread percentage

Matthias May (1):
      selftests: net: add missing config for GENEVE

Max Kellermann (1):
      fs/kernfs/dir: obey S_ISGID

Meenakshikumar Somasundaram (2):
      drm/amd/display: Fix tiled display misalignment
      drm/amd/display: Fix minor issues in BW Allocation Phase2

MeiChia Chiu (1):
      wifi: mt76: connac: fix EHT phy mode check

Michael Ellerman (3):
      powerpc: Fix build error due to is_valid_bugaddr()
      powerpc/mm: Fix build failures due to arch_reserved_kernel_pages()
      powerpc/64s: Fix CONFIG_NUMA=n build due to create_section_mapping()

Michael Maltsev (1):
      ACPI: resource: Skip IRQ override on ASUS ExpertBook B1502CGA

Michael Strauss (1):
      drm/amd/display: Fix lightup regression with DP2 single display configs

Michael Tretter (1):
      media: rockchip: rga: fix swizzling for RGB formats

Michal Simek (2):
      arm64: zynqmp: Move fixed clock to / for kv260
      arm64: zynqmp: Fix clock node name in kv260 cards

Michal Vokáč (1):
      net: dsa: qca8k: fix illegal usage of GPIO

Michal Wajdeczko (1):
      kunit: Reset test->priv after each param iteration

Mina Almasry (1):
      net: kcm: fix direct access to bv_len

Ming Lei (2):
      blk-mq: fix IO hang from sbitmap wakeup race
      scsi: core: Move scsi_host_busy() out of host lock for waking up EH handler

Ming Qian (1):
      media: amphion: remove mutext lock in condition of wait_event

Mingyi Zhang (1):
      libbpf: Fix NULL pointer dereference in bpf_object__collect_prog_relos

Minsuk Kang (1):
      wifi: ath9k: Fix potential array-index-out-of-bounds read in ath9k_htc_txstatus()

Mukesh Ojha (1):
      PM / devfreq: Synchronize devfreq_monitor_[start/stop]

Nathan Chancellor (1):
      um: net: Fix return type of uml_net_start_xmit()

Naveen N Rao (1):
      powerpc/lib: Validate size for vector operations

Neil Armstrong (3):
      arm64: dts: qcom: sm8550: fix soundwire controllers node name
      arm64: dts: qcom: sm8450: fix soundwire controllers node name
      drm/msm/dp: Add DisplayPort controller for SM8650

Nia Espera (1):
      arm64: dts: qcom: sm8350: Fix remoteproc interrupt type

Nicholas Susanto (1):
      drm/amd/display: Fix disable_otg_wa logic

Nicolas Dichtel (1):
      ipmr: fix kernel panic when forwarding mcast packets

Oded Gabbay (1):
      accel/habanalabs: add support for Gaudi2C device

Ojaswin Mujoo (1):
      ext4: treat end of range as exclusive in ext4_zero_range()

Oleg Nesterov (2):
      afs: fix the usage of read_seqbegin_or_lock() in afs_lookup_volume_rcu()
      rxrpc_find_service_conn_rcu: fix the usage of read_seqbegin_or_lock()

Oleksandr Tyshchenko (1):
      xen/gntdev: Fix the abuse of underlying struct page in DMA-buf import

Osama Muhammad (2):
      FS:JFS:UBSAN:array-index-out-of-bounds in dbAdjTree
      UBSAN: array-index-out-of-bounds in dtSplitRoot

Pablo Neira Ayuso (3):
      netfilter: nf_tables: restrict tunnel object to NFPROTO_NETDEV
      netfilter: nf_log: replace BUG_ON by WARN_ON_ONCE when putting logger
      netfilter: nft_ct: sanitize layer 3 and 4 protocol number in custom expectations

Paloma Arellano (1):
      drm/msm/dpu: Add mutex lock in control vblank irq

Paolo Abeni (9):
      selftests: net: remove dependency on ebpf tests
      selftests: net: explicitly wait for listener ready
      selftests: net: add missing config for big tcp tests
      selftests: net: add missing required classifier
      selftests: net: give more time for GRO aggregation
      selftests: net: add missing config for pmtu.sh tests
      selftests: net: fix available tunnels detection
      selftests: net: don't access /dev/stdout in pmtu.sh
      selftests: net: enable some more knobs

Parav Pandit (1):
      devlink: Fix referring to hw_addr attribute during state validation

Paulo Alcantara (2):
      smb: client: fix renaming of reparse points
      smb: client: fix hardlinking of reparse points

Pavan Kumar Linga (1):
      idpf: avoid compiler padding in virtchnl2_ptype struct

Peter Robinson (1):
      mfd: ti_am335x_tscadc: Fix TI SoC dependencies

Peter Zijlstra (1):
      perf: Fix the nr_addr_filters fix

Philip Yang (1):
      drm/amdkfd: Fix lock dependency warning with srcu

Pierre-Louis Bossart (3):
      PCI: add INTEL_HDA_ARL to pci_ids.h
      ALSA: hda: Intel: add HDA_ARL PCI ID support
      ALSA: hda: intel-dspcfg: add filters for ARL-S and ARL

Piro Yang (1):
      staging: vme_user: Fix the issue of return the wrong error code

Po-Hao Huang (1):
      wifi: rtw89: fix not entering PS mode after AP stops

Prarit Bhargava (1):
      ACPI: extlog: fix NULL pointer dereference check

Praveen Kaligineedi (1):
      gve: Fix skb truesize underestimation

Rae Moar (1):
      kunit: tool: fix parsing of test attributes

Rafael J. Wysocki (1):
      thermal: core: Fix thermal zone suspend-resume synchronization

Raghavendra K T (1):
      sched/numa: Fix mm numa_scan_seq based unconditional scan

Ricardo Ribalda (2):
      media: uvcvideo: Fix power line control for a Chicony camera
      media: uvcvideo: Fix power line control for SunplusIT camera

Rob Clark (2):
      drm/msm/dpu: Ratelimit framedone timeout msgs
      drm/msm/dpu: Correct UBWC settings for sc8280xp

Romain Naour (1):
      regulator: ti-abb: don't use devm_platform_ioremap_resource_byname for shared interrupt register

Rui Zhang (1):
      regulator: core: Only increment use_count when enable_count changes

Ryan Schaefer (1):
      netfilter: conntrack: correct window scaling with retransmitted SYN

Shannon Nelson (2):
      ionic: pass opcode to devcmd_wait
      ionic: bypass firmware cmds when stuck in reset

Shiji Yang (2):
      wifi: rt2x00: restart beacon queue when hardware reset
      wifi: rt2x00: correct wrong BBP register in RxDCOC calibration

Shuai Xue (1):
      ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED on synchronous events

Shyam Prasad N (1):
      cifs: fix in logging in cifs_chan_update_iface

Srinivasan Shanmugam (10):
      drm/amdgpu: Fix possible NULL dereference in amdgpu_ras_query_error_status_helper()
      drm/amdgpu: Fix variable 'mca_funcs' dereferenced before NULL check in 'amdgpu_mca_smu_get_mca_entry()'
      drm/amdgpu: Fix '*fw' from request_firmware() not released in 'amdgpu_ucode_request()'
      drm/amdgpu: Drop 'fence' check in 'to_amdgpu_amdkfd_fence()'
      drm/amdkfd: Fix iterator used outside loop in 'kfd_add_peer_prop()'
      drm/amd/powerplay: Fix kzalloc parameter 'ATOM_Tonga_PPM_Table' in 'get_platform_power_management_table()'
      drm/amdgpu: Fix with right return code '-EIO' in 'amdgpu_gmc_vram_checking()'
      drm/amdgpu: Release 'adev->pm.fw' before return in 'amdgpu_device_need_post()'
      drm/amdkfd: Fix 'node' NULL check in 'svm_range_get_range_boundaries()'
      drm/amdgpu: Fix missing error code in 'gmc_v6/7/8/9_0_hw_init()'

Stanley.Yang (1):
      drm/amdgpu: Fix ecc irq enable/disable unpaired

StanleyYP Wang (1):
      wifi: mt76: mt7996: add PCI IDs for mt7992

Stephen Rothwell (2):
      powerpc: pmd_move_must_withdraw() is only needed for CONFIG_TRANSPARENT_HUGEPAGE
      drm: using mul_u32_u32() requires linux/math64.h

Steven Rostedt (Google) (1):
      tracefs/eventfs: Use root and instance inodes as default ownership

Su Hui (4):
      wifi: rtlwifi: rtl8723{be,ae}: using calculate_bit_shift()
      media: ddbridge: fix an error code problem in ddb_probe
      scsi: isci: Fix an error code problem in isci_io_request_build()
      HID: hidraw: fix a problem of memory leak in hidraw_release()

Suman Ghosh (1):
      octeontx2-af: Fix max NPC MCAM entry check while validating ref_entry

Sumit Saxena (2):
      scsi: mpi3mr: Add support for SAS5116 PCI IDs
      scsi: mpi3mr: Add PCI checks where SAS5116 diverges from SAS4116

Takashi Iwai (1):
      ALSA: hda: Refer to correct stream index at loops

Tanmay Shah (1):
      soc: xilinx: fix unhandled SGI warning message

Thomas Bourgoin (1):
      crypto: stm32/crc32 - fix parsing list of devices

Thomas Weißschuh (1):
      selftests/nolibc: fix testcase status alignment

Tim Lunn (1):
      i2c: rk3x: Adjust mask/value offset for i2c2 on rv1126

Tobias Waldekranz (2):
      net: mvmdio: Avoid excessive sleeps in polled mode
      net: dsa: mv88e6xxx: Fix mv88e6352_serdes_get_stats error path

Tomi Valkeinen (7):
      drm/drm_file: fix use of uninitialized variable
      drm/framebuffer: Fix use of uninitialized variable
      drm/mipi-dsi: Fix detach call without attach
      media: rkisp1: Drop IRQF_SHARED
      media: rkisp1: Fix IRQ handler return values
      media: rkisp1: Store IRQ lines
      media: rkisp1: Fix IRQ disable race issue

Tony Krowiak (1):
      s390/vfio-ap: fix sysfs status attribute for AP queue devices

Venkata Prasad Potturu (1):
      ASoC: amd: Add new dmi entries for acp5x platform

Venky Shankar (1):
      ceph: reinitialize mds feature bit even when session in open

Vincent Guittot (1):
      sched/fair: Fix tg->load when offlining a CPU

Viresh Kumar (1):
      OPP: The level field is always of unsigned int type

Vladimir Oltean (1):
      net: dsa: qca8k: put MDIO bus OF node on qca8k_mdio_register() failure

Wang, Beyond (1):
      drm/amdgpu: fix ftrace event amdgpu_bo_move always move on same heap

Weichen Chen (1):
      pstore/ram: Fix crash when setting number of cpus to an odd number

Wen Gu (1):
      net/smc: disable SEID on non-s390 archs where virtual ISM may be used

Wenchao Hao (1):
      ceph: fix invalid pointer access if get_quota_realm return ERR_PTR

Wenjing Liu (1):
      drm/amd/display: add support for DTO genarated dscclk

Werner Fischer (1):
      watchdog: it87_wdt: Keep WDTCTRL bit 3 unmodified for IT8784/IT8786

Xianwei Zhao (1):
      arm64: dts: amlogic: fix format for s4 uart node

Xiaowu.ding (1):
      mailbox: arm_mhuv2: Fix a bug for mhuv2_sender_interrupt

Xin Ji (1):
      drm/bridge: anx7625: Fix Set HPD irq detect window to 2ms

Xing Tong Wu (1):
      hwmon: (nct6775) Fix fan speed set failure in automatic mode

Xiubo Li (1):
      ceph: fix deadlock or deadcode of misusing dget()

Yafang Shao (1):
      selftests/bpf: Fix issues in setup_classid_environment()

Yaxiong Tian (1):
      extcon: fix possible name leak in extcon_dev_register()

Ye Bin (1):
      ext4: fix inconsistent between segment fstrim and full fstrim

Yihang Li (1):
      scsi: hisi_sas: Set .phy_attached before notifing phyup event HISI_PHYE_PHY_UP_PM

Yinbo Zhu (1):
      usb: xhci-plat: fix usb disconnect issue after s4

Yonghong Song (4):
      libbpf: Fix potential uninitialized tail padding with LIBBPF_OPTS_RESET
      selftests/bpf: Fix pyperf180 compilation failure with clang18
      bpf: Fix a few selftest failures due to llvm18 change
      selftests/bpf: Remove flaky test_btf_id test

Yu-Che Cheng (1):
      spmi: mediatek: Fix UAF on device remove

Yuluo Qiu (1):
      ACPI: video: Add quirk for the Colorful X15 AT 23 Laptop

Yuntao Wang (2):
      ACPI: tables: Correct and clean up the logic of acpi_parse_entries_array()
      ACPI: NUMA: Fix the logic of getting the fake_pxm value

Zenm Chen (1):
      wifi: rtl8xxxu: Add additional USB IDs for RTL8192EU devices

Zhengchao Shao (2):
      bonding: return -ENOMEM instead of BUG in alb_upper_dev_walk
      bonding: remove print in bond_verify_device_path

Zhipeng Lu (1):
      net: ipv4: fix a memleak in ip_setup_cork

Zhiquan Li (1):
      x86/mce: Mark fatal MCE's page as poison to avoid panic in the kdump kernel

Zhu Yanjun (1):
      virtio_net: Fix "‘%d’ directive writing between 1 and 11 bytes into a region of size 10" warnings

Zijun Hu (1):
      Bluetooth: qca: Set both WIDEBAND_SPEECH and LE_STATES quirks for QCA2066

bo liu (1):
      ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140

ching Huang (1):
      scsi: arcmsr: Support new PCI device IDs 1883 and 1886

clancy shang (1):
      Bluetooth: hci_sync: fix BR/EDR wakeup bug


