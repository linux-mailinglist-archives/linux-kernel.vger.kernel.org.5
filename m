Return-Path: <linux-kernel+bounces-47450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5285D844E20
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACE4DB2B443
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DF03C24;
	Thu,  1 Feb 2024 00:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r6D0HYSB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88743FE0;
	Thu,  1 Feb 2024 00:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706748255; cv=none; b=WhXZ4bW5xVGV+3Z+29ujHJ0JeLgi8+RDbLuzic+KRWboc0azl+lKYaXcmtiFExchGvSngDVw5O9DXl22kE1Rdhf5bZ5w2I09+BAcJdvwellU+kl95WwaHLuw8KQNaP9sGZpvdsh4S69cr1pRV6gz5utAKnF5fZpCfFExRfQaWrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706748255; c=relaxed/simple;
	bh=AhFqkEPEUf2OLC1jBkpPEz/lfRPjoaJVWpkUlEkFjFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TzECh9qDkm4C19iYEq0Y1OMPygsA30Rl3ytLFICBOnfUVIMQz/HTRbzjUM6XtKdydGTI6qzB+yijT3bQhUoNhwKLRs+ZXggLrqiYj7F61Ccer2NVnYCNKh7e6KtGoJVl3XNLH6OdhgbypQlLIr8RjqYNYZHnstOLYU9Acb325y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r6D0HYSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09086C433C7;
	Thu,  1 Feb 2024 00:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706748255;
	bh=AhFqkEPEUf2OLC1jBkpPEz/lfRPjoaJVWpkUlEkFjFI=;
	h=From:To:Cc:Subject:Date:From;
	b=r6D0HYSB12LGOTQw9TMChNTa3kSt+jICP0/zuosivEBCQGwH/+0xvrDi5lzJAyqr6
	 5z1IzssLRfHtguSJNYO1HjUhhRnHm7eUrkOrsy80vcMEQJqTQEirtL3gz2159WB24y
	 AJWaJHvBBhM7Ns1ZXkJKnoHUWLqhBCqrsJn4ApqU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.7.3
Date: Wed, 31 Jan 2024 16:44:11 -0800
Message-ID: <2024013112-salute-arose-3382@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.7.3 kernel.

All users of the 6.7 kernel series must upgrade.

The updated 6.7.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.7.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-class-devfreq                          |    3 
 Documentation/admin-guide/abi-obsolete.rst                             |    2 
 Documentation/admin-guide/abi-removed.rst                              |    2 
 Documentation/admin-guide/abi-stable.rst                               |    2 
 Documentation/admin-guide/abi-testing.rst                              |    2 
 Documentation/arch/arm64/silicon-errata.rst                            |    2 
 Documentation/filesystems/directory-locking.rst                        |   29 
 Documentation/filesystems/locking.rst                                  |    5 
 Documentation/filesystems/overlayfs.rst                                |   16 
 Documentation/filesystems/porting.rst                                  |   18 
 Documentation/gpu/drm-kms.rst                                          |    2 
 Documentation/gpu/todo.rst                                             |    7 
 Documentation/sphinx/kernel_abi.py                                     |   56 -
 Makefile                                                               |    2 
 arch/alpha/kernel/rtc.c                                                |    2 
 arch/arm/boot/dts/nxp/imx/imx6q-apalis-ixora-v1.2.dts                  |    2 
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi                                 |   10 
 arch/arm/boot/dts/samsung/exynos4210-i9100.dts                         |    8 
 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi                         |    1 
 arch/arm64/Kconfig                                                     |   18 
 arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts                   |    1 
 arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts                  |    1 
 arch/arm64/boot/dts/qcom/msm8916.dtsi                                  |    1 
 arch/arm64/boot/dts/qcom/msm8939.dtsi                                  |    1 
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-mido.dts                       |    1 
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dts                     |    1 
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts                      |    1 
 arch/arm64/boot/dts/qcom/sc7180.dtsi                                   |    4 
 arch/arm64/boot/dts/qcom/sc7280.dtsi                                   |    4 
 arch/arm64/boot/dts/qcom/sc8180x.dtsi                                  |   16 
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts                              |    2 
 arch/arm64/boot/dts/qcom/sdm670.dtsi                                   |    8 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                                   |   16 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                                   |   16 
 arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus-lts.dts           |    4 
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi                              |    1 
 arch/arm64/boot/dts/sprd/ums512.dtsi                                   |    4 
 arch/arm64/boot/install.sh                                             |    3 
 arch/arm64/kernel/cpu_errata.c                                         |   21 
 arch/arm64/kernel/entry.S                                              |   22 
 arch/arm64/kernel/fpsimd.c                                             |    6 
 arch/arm64/tools/cpucaps                                               |    2 
 arch/loongarch/kernel/smp.c                                            |    1 
 arch/loongarch/mm/tlb.c                                                |   16 
 arch/mips/kernel/elf.c                                                 |    6 
 arch/mips/lantiq/prom.c                                                |    7 
 arch/mips/mm/init.c                                                    |   12 
 arch/parisc/kernel/firmware.c                                          |    4 
 arch/powerpc/configs/ps3_defconfig                                     |    1 
 arch/riscv/boot/dts/sophgo/sg2042.dtsi                                 |   80 +-
 arch/riscv/include/asm/pgtable.h                                       |    2 
 arch/riscv/include/asm/processor.h                                     |    2 
 arch/riscv/kernel/module.c                                             |   14 
 arch/riscv/kernel/pi/cmdline_early.c                                   |    3 
 arch/s390/crypto/aes_s390.c                                            |    4 
 arch/s390/crypto/paes_s390.c                                           |    4 
 arch/sh/boards/mach-ecovec24/setup.c                                   |    2 
 arch/x86/include/asm/syscall_wrapper.h                                 |   25 
 arch/x86/kernel/hpet.c                                                 |    2 
 arch/x86/kernel/rtc.c                                                  |    2 
 block/ioctl.c                                                          |    2 
 block/partitions/core.c                                                |    5 
 crypto/algapi.c                                                        |    1 
 drivers/base/power/main.c                                              |  148 +---
 drivers/base/power/trace.c                                             |    2 
 drivers/block/nbd.c                                                    |    6 
 drivers/block/rbd.c                                                    |   22 
 drivers/bus/mhi/host/main.c                                            |   29 
 drivers/char/hw_random/core.c                                          |   34 
 drivers/cpufreq/amd-pstate.c                                           |    7 
 drivers/cpufreq/intel_pstate.c                                         |   55 -
 drivers/cxl/core/region.c                                              |    4 
 drivers/devfreq/devfreq.c                                              |   57 +
 drivers/dma/dmaengine.c                                                |    3 
 drivers/dma/fsl-edma-main.c                                            |    8 
 drivers/dma/idxd/device.c                                              |    9 
 drivers/dma/xilinx/xdma.c                                              |    6 
 drivers/dpll/dpll_core.c                                               |   68 +
 drivers/dpll/dpll_core.h                                               |    4 
 drivers/dpll/dpll_netlink.c                                            |   57 +
 drivers/firmware/arm_ffa/driver.c                                      |   12 
 drivers/firmware/arm_scmi/clock.c                                      |    3 
 drivers/firmware/arm_scmi/common.h                                     |    1 
 drivers/firmware/arm_scmi/mailbox.c                                    |   14 
 drivers/firmware/arm_scmi/perf.c                                       |   23 
 drivers/firmware/arm_scmi/raw_mode.c                                   |   12 
 drivers/firmware/arm_scmi/shmem.c                                      |    6 
 drivers/firmware/sysfb.c                                               |    2 
 drivers/gpio/gpio-eic-sprd.c                                           |   32 
 drivers/gpio/gpiolib-acpi.c                                            |   14 
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                                    |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c                             |    6 
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c                          |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                                |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c                               |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c                               |   10 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c                           |   17 
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c                                 |   20 
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                                 |   10 
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c                                  |    3 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c                       |    1 
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c                       |    1 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c                      |    9 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c              |    6 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c              |    5 
 drivers/gpu/drm/amd/display/dc/bios/command_table2.c                   |   12 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c           |    2 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c         |   23 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c         |    2 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c         |    2 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c           |    2 
 drivers/gpu/drm/amd/display/dc/core/dc.c                               |   16 
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c                  |    2 
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c                      |   19 
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c                           |  176 ++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h                           |   59 +
 drivers/gpu/drm/amd/display/dc/dc_helper.c                             |    6 
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c                      |   14 
 drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c                  |    2 
 drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.c                       |    2 
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c                          |   33 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c                  |   16 
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h                  |    1 
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c                      |    2 
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c          |    4 
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_panel_cntl.c                |    4 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c                      |   17 
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c                  |    1 
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c                |    1 
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c                      |   10 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c                   |    6 
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c                |   30 
 drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c          |    2 
 drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c                |    4 
 drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c                |    8 
 drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c                |    4 
 drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c                |    6 
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c                |    8 
 drivers/gpu/drm/amd/display/dc/inc/core_types.h                        |    1 
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c                        |    8 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c     |    2 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia.c           |    3 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dpcd.c              |    4 
 drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c |   11 
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h                            |   21 
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c                        |   15 
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c              |    2 
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c                              |   14 
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c                         |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c                         |    2 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c                   |   54 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c                   |   15 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c                   |   54 +
 drivers/gpu/drm/bridge/analogix/anx7625.c                              |    7 
 drivers/gpu/drm/bridge/analogix/anx7625.h                              |    2 
 drivers/gpu/drm/bridge/nxp-ptn3460.c                                   |    6 
 drivers/gpu/drm/bridge/parade-ps8640.c                                 |   23 
 drivers/gpu/drm/bridge/samsung-dsim.c                                  |   32 
 drivers/gpu/drm/bridge/sii902x.c                                       |   42 -
 drivers/gpu/drm/drm_damage_helper.c                                    |    3 
 drivers/gpu/drm/drm_plane.c                                            |   14 
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c                          |    4 
 drivers/gpu/drm/exynos/exynos_drm_fimd.c                               |    4 
 drivers/gpu/drm/exynos/exynos_drm_gsc.c                                |    2 
 drivers/gpu/drm/i915/display/icl_dsi.c                                 |    3 
 drivers/gpu/drm/i915/display/intel_psr.c                               |   14 
 drivers/gpu/drm/nouveau/nouveau_fence.c                                |   28 
 drivers/gpu/drm/nouveau/nouveau_fence.h                                |    5 
 drivers/gpu/drm/nouveau/nouveau_vmm.c                                  |    3 
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga100.c                       |    4 
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/r535.c                        |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c                         |    8 
 drivers/gpu/drm/panel/Kconfig                                          |    2 
 drivers/gpu/drm/panel/panel-edp.c                                      |    7 
 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c                          |    2 
 drivers/gpu/drm/panel/panel-simple.c                                   |    2 
 drivers/gpu/drm/qxl/qxl_drv.c                                          |    2 
 drivers/gpu/drm/tidss/tidss_crtc.c                                     |   10 
 drivers/gpu/drm/vboxvideo/vbox_drv.c                                   |    2 
 drivers/gpu/drm/virtio/virtgpu_drv.c                                   |    2 
 drivers/gpu/drm/virtio/virtgpu_plane.c                                 |   10 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                                    |    2 
 drivers/iio/adc/ad7091r-base.c                                         |  169 ++++
 drivers/iio/adc/ad7091r-base.h                                         |    8 
 drivers/iio/adc/ad7091r5.c                                             |   28 
 drivers/media/common/videobuf2/videobuf2-dma-sg.c                      |   10 
 drivers/media/i2c/imx290.c                                             |   42 -
 drivers/media/i2c/imx355.c                                             |   12 
 drivers/media/i2c/ov01a10.c                                            |   18 
 drivers/media/i2c/ov13b10.c                                            |   14 
 drivers/media/i2c/ov9734.c                                             |   19 
 drivers/media/i2c/st-mipid02.c                                         |    9 
 drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c                   |   12 
 drivers/media/v4l2-core/v4l2-cci.c                                     |   52 +
 drivers/mmc/core/block.c                                               |   46 +
 drivers/mmc/host/mmc_spi.c                                             |  186 -----
 drivers/mtd/maps/vmu-flash.c                                           |    2 
 drivers/mtd/nand/raw/nand_base.c                                       |   87 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                              |    8 
 drivers/net/ethernet/engleder/tsnep_main.c                             |   17 
 drivers/net/ethernet/freescale/fec_main.c                              |    2 
 drivers/net/ethernet/intel/i40e/i40e_main.c                            |   47 -
 drivers/net/ethernet/intel/i40e/i40e_txrx.c                            |   49 -
 drivers/net/ethernet/intel/i40e/i40e_xsk.c                             |    4 
 drivers/net/ethernet/intel/ice/ice_base.c                              |   37 -
 drivers/net/ethernet/intel/ice/ice_txrx.c                              |   19 
 drivers/net/ethernet/intel/ice/ice_txrx.h                              |    1 
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h                          |   31 
 drivers/net/ethernet/intel/ice/ice_xsk.c                               |    4 
 drivers/net/ethernet/intel/idpf/idpf_lib.c                             |    2 
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                        |   27 
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                          |    5 
 drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c            |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c                    |    4 
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c                       |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c               |   10 
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c                      |   26 
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c                        |    5 
 drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_mcast.c             |    3 
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c                       |    2 
 drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c                      |    2 
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c           |   17 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c                      |    3 
 drivers/net/fjes/fjes_hw.c                                             |   37 -
 drivers/net/hyperv/netvsc_drv.c                                        |    4 
 drivers/net/phy/micrel.c                                               |   11 
 drivers/net/tun.c                                                      |   10 
 drivers/net/wireless/ath/ath11k/core.h                                 |    4 
 drivers/net/wireless/ath/ath11k/debugfs.c                              |   25 
 drivers/net/wireless/ath/ath11k/debugfs.h                              |   12 
 drivers/net/wireless/ath/ath11k/mac.c                                  |   12 
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c                       |    4 
 drivers/opp/core.c                                                     |    6 
 drivers/parisc/power.c                                                 |    2 
 drivers/platform/mellanox/mlxbf-pmc.c                                  |    4 
 drivers/platform/x86/intel/ifs/load.c                                  |    3 
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c  |   82 +-
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.h  |   32 
 drivers/platform/x86/p2sb.c                                            |  180 +++--
 drivers/platform/x86/wmi.c                                             |   16 
 drivers/rpmsg/virtio_rpmsg_bus.c                                       |    1 
 drivers/rtc/rtc-cmos.c                                                 |   28 
 drivers/rtc/rtc-mc146818-lib.c                                         |   39 -
 drivers/s390/crypto/vfio_ap_ops.c                                      |  269 +++++--
 drivers/s390/crypto/vfio_ap_private.h                                  |    3 
 drivers/scsi/scsi_error.c                                              |    9 
 drivers/soc/fsl/qe/qmc.c                                               |   35 
 drivers/soc/fsl/qe/tsa.c                                               |   22 
 drivers/soc/qcom/pmic_glink_altmode.c                                  |    4 
 drivers/soundwire/amd_manager.c                                        |    8 
 drivers/soundwire/bus.c                                                |    4 
 drivers/soundwire/debugfs.c                                            |    2 
 drivers/soundwire/intel_auxdevice.c                                    |    3 
 drivers/soundwire/master.c                                             |    2 
 drivers/soundwire/qcom.c                                               |    3 
 drivers/soundwire/slave.c                                              |   12 
 drivers/spi/spi-bcm-qspi.c                                             |    4 
 drivers/spi/spi-cadence.c                                              |   17 
 drivers/spi/spi-intel-pci.c                                            |    1 
 drivers/spi/spi.c                                                      |    4 
 drivers/thermal/gov_power_allocator.c                                  |    2 
 drivers/thermal/intel/intel_hfi.c                                      |  106 ++-
 drivers/tty/serial/sc16is7xx.c                                         |  353 +++++-----
 drivers/ufs/core/ufshcd.c                                              |    7 
 fs/afs/addr_list.c                                                     |  133 +--
 fs/afs/cmservice.c                                                     |    5 
 fs/afs/dir.c                                                           |   70 +
 fs/afs/dir_silly.c                                                     |    2 
 fs/afs/file.c                                                          |    7 
 fs/afs/fs_operation.c                                                  |   54 -
 fs/afs/fs_probe.c                                                      |   11 
 fs/afs/fsclient.c                                                      |    8 
 fs/afs/inode.c                                                         |    2 
 fs/afs/internal.h                                                      |   88 +-
 fs/afs/misc.c                                                          |   10 
 fs/afs/proc.c                                                          |    9 
 fs/afs/rotate.c                                                        |  224 ++++--
 fs/afs/rxrpc.c                                                         |  100 +-
 fs/afs/server.c                                                        |   53 -
 fs/afs/vl_alias.c                                                      |   57 -
 fs/afs/vl_list.c                                                       |   15 
 fs/afs/vl_probe.c                                                      |   19 
 fs/afs/vl_rotate.c                                                     |   98 +-
 fs/afs/vlclient.c                                                      |   98 +-
 fs/afs/write.c                                                         |    6 
 fs/btrfs/extent-tree.c                                                 |   53 +
 fs/btrfs/inode.c                                                       |   22 
 fs/btrfs/ioctl.c                                                       |    7 
 fs/btrfs/ref-verify.c                                                  |    6 
 fs/btrfs/scrub.c                                                       |   29 
 fs/btrfs/sysfs.c                                                       |    4 
 fs/btrfs/tree-checker.c                                                |    2 
 fs/btrfs/zoned.c                                                       |    8 
 fs/dlm/lowcomms.c                                                      |   14 
 fs/erofs/decompressor.c                                                |   31 
 fs/exec.c                                                              |    3 
 fs/ext4/mballoc.c                                                      |   15 
 fs/fscache/cache.c                                                     |    3 
 fs/ioctl.c                                                             |    3 
 fs/namei.c                                                             |   60 +
 fs/nfsd/nfs4state.c                                                    |   26 
 fs/overlayfs/namei.c                                                   |   43 -
 fs/overlayfs/overlayfs.h                                               |   23 
 fs/overlayfs/ovl_entry.h                                               |    4 
 fs/overlayfs/readdir.c                                                 |    7 
 fs/overlayfs/super.c                                                   |   15 
 fs/overlayfs/util.c                                                    |   53 -
 fs/pipe.c                                                              |    7 
 fs/proc/task_mmu.c                                                     |   24 
 fs/smb/client/smb2ops.c                                                |   10 
 fs/smb/client/smb2pdu.c                                                |  108 +--
 fs/smb/server/connection.c                                             |    1 
 fs/smb/server/ksmbd_netlink.h                                          |    3 
 fs/smb/server/oplock.c                                                 |   16 
 fs/smb/server/smb2pdu.c                                                |    8 
 fs/smb/server/transport_ipc.c                                          |    4 
 fs/ubifs/dir.c                                                         |    2 
 fs/xfs/xfs_super.c                                                     |   27 
 include/drm/drm_drv.h                                                  |    9 
 include/drm/drm_file.h                                                 |   12 
 include/drm/drm_plane.h                                                |   10 
 include/linux/async.h                                                  |    2 
 include/linux/lsm_hook_defs.h                                          |    2 
 include/linux/mc146818rtc.h                                            |    3 
 include/linux/mlx5/fs.h                                                |    1 
 include/linux/mlx5/mlx5_ifc.h                                          |    2 
 include/linux/mmzone.h                                                 |   14 
 include/linux/mtd/rawnand.h                                            |    2 
 include/linux/rmap.h                                                   |    4 
 include/linux/security.h                                               |    9 
 include/linux/seq_buf.h                                                |    3 
 include/linux/skmsg.h                                                  |    6 
 include/linux/soundwire/sdw.h                                          |    4 
 include/linux/syscalls.h                                               |    1 
 include/media/v4l2-cci.h                                               |   11 
 include/net/af_rxrpc.h                                                 |   15 
 include/net/inet_connection_sock.h                                     |    8 
 include/net/inet_sock.h                                                |    5 
 include/net/llc_pdu.h                                                  |    6 
 include/net/sch_generic.h                                              |    4 
 include/net/sock.h                                                     |   18 
 include/net/xdp_sock_drv.h                                             |   27 
 include/trace/events/afs.h                                             |   25 
 include/trace/events/rxrpc.h                                           |    3 
 include/uapi/linux/btrfs.h                                             |    3 
 kernel/async.c                                                         |   85 +-
 kernel/crash_core.c                                                    |   14 
 kernel/futex/core.c                                                    |   15 
 kernel/futex/pi.c                                                      |   11 
 kernel/irq/irqdesc.c                                                   |    2 
 kernel/kexec_core.c                                                    |    1 
 kernel/power/swap.c                                                    |   38 -
 kernel/rcu/tree.c                                                      |   34 
 kernel/rcu/tree_exp.h                                                  |    3 
 kernel/time/clocksource.c                                              |   25 
 kernel/time/tick-sched.c                                               |    5 
 kernel/trace/tracing_map.c                                             |    7 
 lib/crypto/mpi/ec.c                                                    |    3 
 mm/memblock.c                                                          |    3 
 mm/migrate.c                                                           |   27 
 mm/mm_init.c                                                           |    6 
 mm/page_alloc.c                                                        |   16 
 mm/sparse.c                                                            |   17 
 net/8021q/vlan_netlink.c                                               |    4 
 net/core/dev.c                                                         |    9 
 net/core/dev.h                                                         |    3 
 net/core/filter.c                                                      |   44 +
 net/core/request_sock.c                                                |    3 
 net/core/sock.c                                                        |   11 
 net/ipv4/af_inet.c                                                     |    3 
 net/ipv4/inet_connection_sock.c                                        |    4 
 net/ipv4/tcp.c                                                         |    1 
 net/ipv6/af_inet6.c                                                    |    3 
 net/llc/af_llc.c                                                       |   24 
 net/llc/llc_core.c                                                     |    7 
 net/mac80211/sta_info.c                                                |    5 
 net/netfilter/nf_tables_api.c                                          |   20 
 net/netfilter/nft_chain_filter.c                                       |   11 
 net/netfilter/nft_compat.c                                             |   12 
 net/netfilter/nft_flow_offload.c                                       |    5 
 net/netfilter/nft_limit.c                                              |   23 
 net/netfilter/nft_nat.c                                                |    5 
 net/netfilter/nft_rt.c                                                 |    5 
 net/netfilter/nft_socket.c                                             |    5 
 net/netfilter/nft_synproxy.c                                           |    7 
 net/netfilter/nft_tproxy.c                                             |    5 
 net/netfilter/nft_xfrm.c                                               |    5 
 net/netlink/af_netlink.c                                               |    2 
 net/rds/af_rds.c                                                       |    2 
 net/rxrpc/af_rxrpc.c                                                   |   62 +
 net/rxrpc/ar-internal.h                                                |    2 
 net/rxrpc/call_object.c                                                |   17 
 net/rxrpc/peer_object.c                                                |   58 +
 net/rxrpc/sendmsg.c                                                    |   11 
 net/sched/cls_api.c                                                    |    9 
 net/sched/cls_flower.c                                                 |   23 
 net/smc/smc_diag.c                                                     |    2 
 net/sunrpc/svcsock.c                                                   |    4 
 net/xdp/xsk.c                                                          |   12 
 net/xdp/xsk_buff_pool.c                                                |    1 
 scripts/get_abi.pl                                                     |    2 
 security/security.c                                                    |   18 
 security/selinux/hooks.c                                               |   28 
 security/smack/smack_lsm.c                                             |    1 
 security/tomoyo/tomoyo.c                                               |    1 
 sound/soc/intel/boards/sof_sdw.c                                       |    4 
 tools/testing/selftests/drivers/net/bonding/bond_options.sh            |    8 
 tools/testing/selftests/drivers/net/bonding/settings                   |    2 
 tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh        |    9 
 tools/testing/selftests/mm/hugepage-vmemmap.c                          |   29 
 tools/testing/selftests/net/config                                     |   28 
 tools/testing/selftests/net/rps_default_mask.sh                        |    6 
 tools/testing/selftests/net/so_incoming_cpu.c                          |   68 +
 tools/testing/selftests/riscv/hwprobe/cbo.c                            |   18 
 414 files changed, 4902 insertions(+), 2617 deletions(-)

Al Viro (1):
      rename(): fix the locking of subdirectories

Alain Volmat (1):
      media: i2c: st-mipid02: correct format propagation

Aleksander Jan Bajkowski (1):
      MIPS: lantiq: register smp_ops on non-smp platforms

Alex Deucher (3):
      drm/amdgpu: drop exp hw support check for GC 9.4.3
      drm/amdgpu/gfx10: set UNORD_DISPATCH in compute MQDs
      drm/amdgpu/gfx11: set UNORD_DISPATCH in compute MQDs

Alexander Stein (2):
      media: v4l2-cci: Add support for little-endian encoded registers
      media: i2c: imx290: Properly encode registers as little-endian

Alfred Piccioni (1):
      lsm: new security_file_ioctl_compat() hook

Amelie Delaunay (1):
      dmaengine: fix NULL pointer in channel unregistration function

Amir Goldstein (1):
      ovl: mark xwhiteouts directory with overlay.opaque='x'

Amit Kumar Mahapatra (1):
      spi: spi-cadence: Reverse the order of interleaved write and read operations

Andrejs Cainikovs (1):
      ARM: dts: imx6q-apalis: add can power-up delay on ixora board

Andrew Jones (1):
      RISC-V: selftests: cbo: Ensure asm operands match constraints

Andy Shevchenko (1):
      mmc: mmc_spi: remove custom DMA mapped buffers

Anthony Krowiak (1):
      s390/vfio-ap: unpin pages on gisc registration failure

Arkadiusz Kubalewski (4):
      dpll: fix broken error path in dpll_pin_alloc(..)
      dpll: fix pin dump crash for rebound module
      dpll: fix userspace availability of pins
      dpll: fix register pin with unregistered parent pin

Armin Wolf (1):
      platform/x86: wmi: Fix error handling in legacy WMI notify handler functions

Arnd Bergmann (2):
      drm/panel/raydium-rm692e5: select CONFIG_DRM_DISPLAY_DP_HELPER
      drm/exynos: fix accidental on-stack copy of exynos_drm_plane

Artur Weber (2):
      drm/panel: samsung-s6d7aa0: drop DRM_BUS_FLAG_DE_HIGH for lsl080al02
      ARM: dts: exynos4212-tab3: add samsung,invert-vclk flag to fimd

Aurabindo Pillai (1):
      drm/amd/display: Fix a debugfs null pointer error

Avri Altman (1):
      mmc: core: Use mrq.sbc in close-ended ffu

Baolin Wang (1):
      mm: migrate: fix getting incorrect page mapping during page migration

Bart Van Assche (1):
      scsi: ufs: core: Remove the ufshcd_hba_exit() call from ufshcd_async_scan()

Benjamin Berg (1):
      wifi: ath11k: rely on mac80211 debugfs handling for vif

Benjamin Poirier (1):
      selftests: bonding: Increase timeout to 1200s

Bernd Edlinger (2):
      net: stmmac: Wait a bit for the reset to take effect
      exec: Fix error handling in begin_new_exec()

Bhaumik Bhatt (1):
      bus: mhi: host: Add spinlock to protect WP access when queueing TREs

Bingbu Cao (4):
      media: imx355: Enable runtime PM before registering async sub-device
      media: ov9734: Enable runtime PM before registering async sub-device
      media: ov13b10: Enable runtime PM before registering async sub-device
      media: ov01a10: Enable runtime PM before registering async sub-device

Charan Teja Kalla (2):
      mm/sparsemem: fix race in accessing memory_section->usage
      mm: page_alloc: unreserve highatomic page blocks before oom

Charlene Liu (1):
      drm/amd/display: Add logging resource checks

Charlie Jenkins (3):
      riscv: Fix module loading free order
      riscv: Correctly free relocation hashtable on error
      riscv: Fix relocation_hashtable size

Christian Marangi (1):
      PM / devfreq: Fix buffer overflow in trans_stat_show

Christophe JAILLET (2):
      riscv: Fix an off-by-one in get_early_cmdline()
      drm/amd/display: Fix a switch statement in populate_dml_output_cfg_from_stream_state()

Chung-Chiang Cheng (1):
      btrfs: tree-checker: fix inline ref size in error messages

Cixi Geng (1):
      arm64: dts: sprd: fix the cpu node for UMS512

Cristian Marussi (7):
      firmware: arm_scmi: Check mailbox/SMT channel for consistency
      firmware: arm_scmi: Use xa_insert() to store opps
      firmware: arm_scmi: Use xa_insert() when saving raw queues
      firmware: arm_scmi: Fix the clock protocol version for v3.2
      firmware: arm_ffa: Add missing rwlock_init() in ffa_setup_partitions()
      firmware: arm_ffa: Add missing rwlock_init() for the driver partition
      firmware: arm_ffa: Check xa_load() return value

Dan Carpenter (3):
      netfs, fscache: Prevent Oops in fscache_put_cache()
      drm/bridge: nxp-ptn3460: fix i2c_master_send() error checking
      drm/bridge: nxp-ptn3460: simplify some error checking

Dave Airlie (3):
      nouveau/vmm: don't set addr on the fail path to avoid warning
      nouveau/gsp: handle engines in runl without nonstall interrupts.
      Revert "nouveau: push event block/allowing out of the fence context"

Dave Chinner (1):
      xfs: read only mounts with fsopen mount API are busted

David Disseldorp (1):
      btrfs: sysfs: validate scrub_speed_max value

David Howells (10):
      afs: Hide silly-rename files from userspace
      afs: Add comments on abort handling
      afs: Turn the afs_addr_list address array into an array of structs
      rxrpc, afs: Allow afs to pin rxrpc_peer objects
      afs: Handle the VIO and UAEIO aborts explicitly
      afs: Use op->nr_iterations=-1 to indicate to begin fileserver iteration
      afs: Wrap most op->error accesses with inline funcs
      afs: Don't put afs_call in afs_wait_for_call_to_complete()
      afs: Simplify error handling
      afs: Fix error handling with lookup via FS.InlineBulkStatus

David Lechner (1):
      spi: fix finalize message on error return

David Sterba (1):
      btrfs: don't warn if discard range is not aligned to sector

Dawei Li (1):
      genirq: Initialize resend_node hlist for all interrupt descriptors

Di Shen (1):
      thermal: gov_power_allocator: avoid inability to reset a cdev

Dillon Varone (1):
      drm/amd/display: Init link enc resources in dc_state only if res_pool presents

Dinghao Liu (1):
      net/mlx5e: fix a potential double-free in fs_any_create_groups

Donet Tom (1):
      selftests: mm: hugepage-vmemmap fails on 64K page size systems

Douglas Anderson (2):
      drm/bridge: parade-ps8640: Wait for HPD when doing an AUX transfer
      drm/bridge: parade-ps8640: Make sure we drop the AUX mutex in the error case

Emmanuel Grumbach (1):
      wifi: iwlwifi: fix a memory corruption

Eric Dumazet (3):
      nbd: always initialize struct msghdr completely
      llc: make llc_ui_sendmsg() more robust against bonding changes
      udp: fix busy polling

Fedor Pchelkin (2):
      btrfs: ref-verify: free ref cache before clearing mount opt
      drm/exynos: gsc: minor fix for loop iteration in gsc_runtime_resume

Florian Westphal (3):
      netfilter: nft_limit: reject configurations that cause integer overflow
      netfilter: nf_tables: restrict anonymous set and map names to 16 bytes
      netfilter: nf_tables: reject QUEUE/DROP verdict parameters

Frank Li (1):
      dmaengine: fsl-edma: fix eDMAv4 channel allocation issue

Frederic Weisbecker (1):
      rcu: Defer RCU kthreads wakeup when CPU is dying

Friedrich Vock (1):
      drm/amdgpu: Enable tunneling on high-priority compute queues

Gao Xiang (1):
      erofs: fix lz4 inplace decompression

Geert Uytterhoeven (1):
      sh: ecovec24: Rename missed backlight field from fbdev to dev

Geoff Levand (1):
      powerpc/ps3_defconfig: Disable PPC64_BIG_ENDIAN_ELF_ABI_V2

George Shen (1):
      drm/amd/display: Disconnect phantom pipe OPP from OPTC being disabled

Gerhard Engleder (2):
      tsnep: Remove FCS for XDP data path
      tsnep: Fix XDP_RING_NEED_WAKEUP for empty fill ring

Greg Kroah-Hartman (1):
      Linux 6.7.3

Guo Ren (2):
      riscv: mm: Fixup compat arch_get_mmap_end
      riscv: mm: Fixup compat mode boot failure

Hangbin Liu (1):
      selftests: bonding: do not test arp/ns target with mode balance-alb/tlb

Helge Deller (2):
      parisc/firmware: Fix F-extend for PDC addresses
      parisc/power: Fix power soft-off button emulation on qemu

Herbert Xu (3):
      crypto: api - Disallow identical driver names
      hwrng: core - Fix page fault dead lock on mmap-ed hwrng
      crypto: s390/aes - Fix buffer overread in CTR mode

Herve Codina (3):
      soc: fsl: cpm1: tsa: Fix __iomem addresses declaration
      soc: fsl: cpm1: qmc: Fix __iomem addresses declaration
      soc: fsl: cpm1: qmc: Fix rx channel reset

Hongchen Zhang (1):
      PM: hibernate: Enforce ordering during image compression/decompression

Horatiu Vultur (1):
      net: micrel: Fix PTP frame parsing for lan8814

Hsin-Yi Wang (3):
      drm/panel-edp: drm/panel-edp: Fix AUO B116XAK01 name and timing
      drm/panel-edp: drm/panel-edp: Fix AUO B116XTN02 name
      drm/bridge: anx7625: Ensure bridge is suspended in disable()

Huacai Chen (2):
      kdump: defer the insertion of crashkernel resources
      LoongArch/smp: Call rcutree_report_cpu_starting() at tlb_init()

Hugo Villeneuve (10):
      serial: sc16is7xx: improve regmap debugfs by using one regmap per port
      serial: sc16is7xx: remove wasteful static buffer in sc16is7xx_regmap_name()
      serial: sc16is7xx: remove global regmap from struct sc16is7xx_port
      serial: sc16is7xx: remove unused line structure member
      serial: sc16is7xx: change EFR lock to operate on each channels
      serial: sc16is7xx: convert from _raw_ to _noinc_ regmap functions for FIFO
      serial: sc16is7xx: fix unconditional activation of THRI interrupt
      serial: sc16is7xx: fix invalid sc16is7xx_lines bitfield in case of probe error
      serial: sc16is7xx: remove obsolete loop in sc16is7xx_port_irq()
      serial: sc16is7xx: improve do/while loop in sc16is7xx_irq()

Ido Schimmel (1):
      net/sched: flower: Fix chain template offload

Ilya Bakoulin (2):
      drm/amd/display: Fix hang/underflow when transitioning to ODM4:1
      drm/amd/display: Clear OPTC mem select on disable

Ilya Dryomov (1):
      rbd: don't move requests to the running list on errors

Inochi Amaoto (1):
      riscv: dts: sophgo: separate sg2042 mtime and mtimecmp to fit aclint format

Ivan Lipski (1):
      Revert "drm/amd/display: fix bandwidth validation failure on DCN 2.1"

Jakub Kicinski (4):
      net: fix removing a namespace with conflicting altnames
      selftests: fill in some missing configs for net
      selftests: net: fix rps_default_mask with >32 CPUs
      selftests: netdevsim: fix the udp_tunnel_nic test

James Gowans (1):
      kexec: do syscore_shutdown() in kernel_kexec

Javier Martinez Canillas (2):
      drm/virtio: Disable damage clipping if FB changed since last page-flip
      drm: Allow drivers to indicate the damage helpers to ignore damage clips

Jenishkumar Maheshbhai Patel (1):
      net: mvpp2: clear BM pool before initialization

Jiri Wiesner (1):
      clocksource: Skip watchdog check for large watchdog intervals

Jithu Joseph (1):
      platform/x86/intel/ifs: Call release_firmware() when handling errors.

Johan Hovold (20):
      soc: qcom: pmic_glink_altmode: fix port sanity check
      arm64: dts: qcom: sc8280xp-crd: fix eDP phy compatible
      ARM: dts: qcom: sdx55: fix USB wakeup interrupt types
      ARM: dts: qcom: sdx55: fix pdc '#interrupt-cells'
      arm64: dts: qcom: sc7180: fix USB wakeup interrupt types
      arm64: dts: qcom: sdm845: fix USB wakeup interrupt types
      arm64: dts: qcom: sdm670: fix USB wakeup interrupt types
      arm64: dts: qcom: sm8150: fix USB wakeup interrupt types
      arm64: dts: qcom: sc8180x: fix USB wakeup interrupt types
      arm64: dts: qcom: sc7280: fix usb_1 wakeup interrupt types
      ARM: dts: qcom: sdx55: fix USB DP/DM HS PHY interrupts
      arm64: dts: qcom: sdm845: fix USB DP/DM HS PHY interrupts
      arm64: dts: qcom: sdm845: fix USB SS wakeup
      arm64: dts: qcom: sm8150: fix USB DP/DM HS PHY interrupts
      arm64: dts: qcom: sm8150: fix USB SS wakeup
      arm64: dts: qcom: sc8180x: fix USB DP/DM HS PHY interrupts
      arm64: dts: qcom: sc8180x: fix USB SS wakeup
      arm64: dts: qcom: sdm670: fix USB DP/DM HS PHY interrupts
      arm64: dts: qcom: sdm670: fix USB SS wakeup
      ARM: dts: qcom: sdx55: fix USB SS wakeup

Johannes Berg (1):
      wifi: mac80211: fix potential sta-link leak

Jonathan Gray (1):
      Revert "drm/amd: Enable PCIe PME from D3"

Jordan Rife (1):
      dlm: use kernel_connect() and kernel_bind()

Josef Bacik (1):
      arm64: properly install vmlinuz.efi

Kamal Dasu (1):
      spi: bcm-qspi: fix SFDP BFPT read by usig mspi read

Kenneth Feng (1):
      drm/amd/pm: update the power cap setting

Krishna chaitanya chundru (1):
      bus: mhi: host: Add alignment check for event ring read pointer

Krzysztof Kozlowski (1):
      soundwire: fix initializing sysfs for same devices on different buses

Kuniyuki Iwashima (2):
      llc: Drop support for ETH_P_TR_802_2.
      selftest: Don't reuse port for SO_INCOMING_CPU test.

Leon Romanovsky (2):
      net/mlx5e: Allow software parsing when IPsec crypto is enabled
      net/mlx5e: Ignore IPsec replay window values on sender side

Li Lingfeng (1):
      block: Move checking GENHD_FL_NO_PART to bdev_add_partition()

Lijo Lazar (5):
      drm/amd/pm: Fix smuv13.0.6 current clock reporting
      drm/amd/pm: Add error log for smu v13.0.6 reset
      drm/amd/pm: Fetch current power limit from FW
      drm/amdgpu: Avoid fetching vram vendor information
      drm/amdgpu: Show vram vendor only if available

Likun Gao (1):
      drm/amdgpu: correct the cu count for gfx v11

Lin Ma (2):
      vlan: skip nested type that is not IFLA_VLAN_QOS_MAPPING
      ksmbd: fix global oob in ksmbd_nl_policy

Lucas Stach (1):
      SUNRPC: use request size to initialize bio_vec in svc_udp_sendto()

Lukas Schauer (1):
      pipe: wakeup wr_wait after setting max_usage

Ma Jun (2):
      drm/amdgpu: Fix the null pointer when load rlc firmware
      drm/amdgpu/pm: Fix the power source flag error

Ma Wupeng (1):
      efi: disable mirror feature during crashkernel

Maciej Fijalkowski (10):
      xsk: recycle buffer in case Rx queue was full
      xsk: make xsk_buff_pool responsible for clearing xdp_buff::flags
      xsk: fix usage of multi-buffer BPF helpers for ZC XDP
      ice: work on pre-XDP prog frag count
      ice: remove redundant xdp_rxq_info registration
      intel: xsk: initialize skb_frag_t::bv_offset in ZC drivers
      ice: update xdp_rxq_info::frag_size for ZC enabled Rx queue
      xdp: reflect tail increase for MEM_TYPE_XSK_BUFF_POOL
      i40e: set xdp_rxq_info::frag_size
      i40e: update xdp_rxq_info::frag_size for ZC enabled Rx queue

Marcelo Schmitt (3):
      iio: adc: ad7091r: Set alert bit in config register
      iio: adc: ad7091r: Allow users to configure device events
      iio: adc: ad7091r: Enable internal vref if external vref is not supplied

Mario Limonciello (8):
      rtc: cmos: Use ACPI alarm for non-Intel x86 systems too
      rtc: Adjust failure return code for cmos_set_alarm()
      rtc: mc146818-lib: Adjust failure return code for mc146818_get_time()
      rtc: Add support for configuring the UIP timeout for RTC reads
      rtc: Extend timeout for waiting for UIP to clear to 1s
      gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-04
      drm/amd/display: Disable PSR-SU on Parade 0803 TCON again
      cpufreq/amd-pstate: Fix setting scaling max/min freq values

Mark Brown (1):
      arm64/sme: Always exit sme_alloc() early with existing storage

Mark Rutland (1):
      arm64: entry: fix ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD

Markus Niebel (1):
      drm: panel-simple: add missing bus flags for Tianma tm070jvhg[30/33]

Melissa Wen (1):
      drm/amd/display: fix bandwidth validation failure on DCN 2.1

Michael Chan (2):
      bnxt_en: Wait for FLR to complete during probe
      bnxt_en: Prevent kernel warning when running offline self test

Michael Grzeschik (1):
      media: videobuf2-dma-sg: fix vmap callback

Michael Kelley (1):
      hv_netvsc: Calculate correct ring size when PAGE_SIZE is not 4 Kbytes

Michael Walle (1):
      drm: bridge: samsung-dsim: Don't use FORCE_STOP_STATE

Michal Schmidt (1):
      idpf: distinguish vports by the dev_port attribute

Mika Westerberg (1):
      spi: intel-pci: Remove Meteor Lake-S SoC PCI ID from the list

Miquel Raynal (6):
      mtd: maps: vmu-flash: Fix the (mtd core) switch to ref counters
      mtd: rawnand: Prevent crossing LUN boundaries during sequential reads
      mtd: rawnand: Fix core interference with sequential reads
      mtd: rawnand: Prevent sequential reads with on-die ECC engines
      mtd: rawnand: Clarify conditions to enable continuous reads
      dmaengine: xilinx: xdma: Fix the count of elapsed periods in cyclic mode

Moshe Shemesh (1):
      net/mlx5: Bridge, fix multicast packets sent to uplink

Muhammad Usama Anjum (1):
      fs/proc/task_mmu: move mmu notification mechanism inside mm lock

Namjae Jeon (5):
      ksmbd: set v2 lease version on lease upgrade
      ksmbd: fix potential circular locking issue in smb2_set_ea()
      ksmbd: don't increment epoch if current state and request state are same
      ksmbd: send lease break notification on FILE_RENAME_INFORMATION
      ksmbd: Add missing set_freezable() for freezable kthread

Naohiro Aota (3):
      btrfs: zoned: fix lock ordering in btrfs_zone_activate()
      btrfs: zoned: factor out prepare_allocation_zoned()
      btrfs: zoned: optimize hint byte for zoned allocator

Nathan Chancellor (1):
      platform/x86: intel-uncore-freq: Fix types in sysfs callbacks

Nathan Lynch (1):
      seq_buf: Make DECLARE_SEQ_BUF() usable

NeilBrown (1):
      nfsd: fix RELEASE_LOCKOWNER

Nicholas Kazlauskas (4):
      drm/amd/display: Port DENTIST hang and TDR fixes to OTG disable W/A
      drm/amd/display: Refactor DMCUB enter/exit idle interface
      drm/amd/display: Wake DMCUB before sending a command
      drm/amd/display: Wake DMCUB before executing GPINT commands

Niklas Cassel (1):
      scsi: core: Kick the requeue list after inserting when flushing

Oleg Nesterov (1):
      afs: fix the usage of read_seqbegin_or_lock() in afs_find_server*()

Omar Sandoval (2):
      btrfs: avoid copying BTRFS_ROOT_SUBVOL_DEAD flag to snapshot of subvolume being deleted
      btrfs: don't abort filesystem when attempting to snapshot deleted subvolume

Ori Messinger (1):
      drm/amdgpu: Enable GFXOFF for Compute on GFX11

Ovidiu Bunea (1):
      drm/amd/display: Fix DML2 watermark calculation

Pablo Neira Ayuso (2):
      netfilter: nf_tables: validate NFPROTO_* family
      netfilter: nft_chain_filter: handle NETDEV_UNREGISTER for inet/ingress basechain

Paul Cercueil (1):
      ARM: dts: samsung: exynos4210-i9100: Unconditionally enable LDO12

Paulo Alcantara (1):
      smb: client: fix parsing of SMB3.1.1 POSIX create context

Petr Pavlu (1):
      tracing: Ensure visibility when inserting an element into tracing_map

Pierre-Louis Bossart (1):
      soundwire: bus: introduce controller_id

Pin-yen Lin (1):
      drm/bridge: parade-ps8640: Ensure bridge is suspended in .post_disable()

Qiang Yu (1):
      bus: mhi: host: Drop chan lock before queuing buffers

Qu Wenruo (2):
      btrfs: scrub: avoid use-after-free when chunk length is not 64K aligned
      btrfs: defrag: reject unknown flags of btrfs_ioctl_defrag_range_args

Quanquan Cao (1):
      cxl/region：Fix overflow issue in alloc_hpa()

Rafael J. Wysocki (4):
      async: Split async_schedule_node_domain()
      async: Introduce async_schedule_dev_nocall()
      PM: sleep: Fix possible deadlocks in core system-wide PM code
      cpufreq: intel_pstate: Refine computation of P-state for given frequency

Rahul Rameshbabu (2):
      net/mlx5e: Fix operation precedence bug in port timestamping napi_poll context
      net/mlx5: Use mlx5 device constant for selecting CQ period mode for ASO

Rex Zhang (1):
      dmaengine: idxd: Move dma_free_coherent() out of spinlocked context

Ricardo Neri (3):
      thermal: intel: hfi: Refactor enabling code into helper functions
      thermal: intel: hfi: Disable an HFI instance when all its CPUs go offline
      thermal: intel: hfi: Add syscore callbacks for system-wide PM

Richard Palethorpe (1):
      x86/entry/ia32: Ensure s32 is sign extended to s64

Rob Herring (2):
      arm64: Rename ARM64_WORKAROUND_2966298
      arm64: errata: Add Cortex-A510 speculative unprivileged load workaround

Sakari Ailus (2):
      media: v4l: cci: Include linux/bits.h
      media: v4l: cci: Add macros to obtain register width and address

Salvatore Dipietro (1):
      tcp: Add memory barrier to tcp_push()

Sam Edwards (1):
      arm64: dts: rockchip: Fix rk3588 USB power-domain clocks

Samson Tam (1):
      drm/amd/display: do not send commands to DMUB if DMUB is inactive from S3

Sebastian Andrzej Siewior (1):
      futex: Prevent the reuse of stale pi_state

Serge Semin (1):
      mips: Fix max_mapnr being uninitialized on early stages

Sharath Srinivasan (1):
      net/rds: Fix UBSAN: array-index-out-of-bounds in rds_cmsg_recv

Sheng-Liang Pan (1):
      drm/panel-edp: Add AUO B116XTN02, BOE NT116WHM-N21,836X2, NV116WHM-N49 V8.0

Shenwei Wang (1):
      net: fec: fix the unhandled context fault from smmu

Shin'ichiro Kawasaki (1):
      platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe

Shravan Kumar Ramani (1):
      platform/mellanox: mlxbf-pmc: Fix offset calculation for crspace events

Shyam Prasad N (3):
      cifs: handle servers that still advertise multichannel after disabling
      cifs: update iface_last_update on each query-and-update
      cifs: fix stray unlock in cifs_chan_skip_or_disable

Srinivasan Shanmugam (3):
      drm/amd/display: Fix variable deferencing before NULL check in edp_setup_replay()
      drm/amd/display: Fix late derefrence 'dsc' check in 'link_set_dsc_pps_packet()'
      drm/amd/display: Fix uninitialized variable usage in core_link_ 'read_dpcd() & write_dpcd()' functions

Stephan Gerhold (3):
      arm64: dts: qcom: msm8916: Make blsp_dma controlled-remotely
      arm64: dts: qcom: msm8939: Make blsp_dma controlled-remotely
      arm64: dts: qcom: Add missing vio-supply for AW2013

Steven Rostedt (Google) (1):
      mm/rmap: fix misplaced parenthesis of a likely()

Suraj Jitindar Singh (1):
      ext4: allow for the last group to be marked as trimmed

Taimur Hassan (1):
      drm/amd/display: Fix conversions between bytes and KB

Tariq Toukan (1):
      net/mlx5e: Fix inconsistent hairpin RQT sizes

Thomas Zimmermann (2):
      Revert "drivers/firmware: Move sysfb_init() from device_initcall to subsys_initcall_sync"
      drm: Fix TODO list mentioning non-KMS drivers

Tianjia Zhang (1):
      crypto: lib/mpi - Fix unexpected pointer access in mpi_ec_init

Tianling Shen (1):
      arm64: dts: rockchip: configure eth pad driver strength for orangepi r1 plus lts

Tim Chen (1):
      tick/sched: Preserve number of idle sleeps across CPU hotplug events

Tirthendu Sarkar (1):
      i40e: handle multi-buffer packets that are shrunk by xdp prog

Tom St Denis (1):
      drm/amd/amdgpu: Assign GART pages to AMD device mapping

Tomi Valkeinen (3):
      drm/tidss: Fix atomic_flush check
      drm/bridge: sii902x: Fix probing race issue
      drm/bridge: sii902x: Fix audio codec unregistration

Tony Krowiak (6):
      s390/vfio-ap: always filter entire AP matrix
      s390/vfio-ap: loop over the shadow APCB when filtering guest's AP configuration
      s390/vfio-ap: let on_scan_complete() callback filter matrix and update guest's APCB
      s390/vfio-ap: reset queues filtered from the guest's AP config
      s390/vfio-ap: reset queues associated with adapter for queue unbound from driver
      s390/vfio-ap: do not reset queue removed from host config

Vegard Nossum (2):
      docs: kernel_abi.py: fix command injection
      scripts/get_abi: fix source path leak

Ville Syrjälä (3):
      Revert "drm/i915/dsi: Do display on sequence later on icl+"
      drm: Don't unref the same fb many times by mistake due to deadlock handling
      drm/i915/psr: Only allow PSR in LPSP mode on HSW non-ULT

Viresh Kumar (1):
      OPP: Pass rounded rate to _set_opp()

Vlad Buslov (1):
      net/mlx5e: Fix peer flow lists handling

Wayne Lin (1):
      drm/amd/display: Align the returned error code with legacy DP

Wen Gu (1):
      net/smc: fix illegal rmb_desc access in SMC-D connection dump

Wenhua Lin (1):
      gpio: eic-sprd: Clear interrupt after set the interrupt type

Wenjing Liu (1):
      drm/amd/display: update pixel clock params after stream slice count change in context

Xi Ruoyao (1):
      mips: Call lose_fpu(0) before initializing fcr31 in mips_set_personality_nan

Xiaolei Wang (1):
      rpmsg: virtio: Free driver_override when rpmsg_remove()

Yajun Deng (1):
      memblock: fix crash when reserved memory is not added to memory

Yevgeny Kliteynik (2):
      net/mlx5: DR, Use the right GVMI number for drop action
      net/mlx5: DR, Can't go to uplink vport on RX rule

Yifan Zhang (1):
      drm/amdgpu: update regGL2C_CTRL4 value in golden setting

Yishai Hadas (1):
      net/mlx5: Fix a WARN upon a callback command failure

Yunjian Wang (2):
      tun: fix missing dropped counter in tun_xdp_act
      tun: add missing rx stats accounting in tun_xdp_act

Zack Rusin (1):
      drm: Disable the cursor plane on atomic contexts with virtualized drivers

Zheng Wang (2):
      media: mtk-jpeg: Fix timeout schedule error in mtk_jpegdec_worker.
      media: mtk-jpeg: Fix use after free bug due to error path handling in mtk_jpeg_dec_device_run

Zhengchao Shao (3):
      tcp: make sure init the accept_queue's spinlocks once
      netlink: fix potential sleeping issue in mqueue_flush_file
      ipv6: init the accept_queue's spinlocks in inet6_create

Zhihao Cheng (1):
      ubifs: ubifs_symlink: Fix memleak of inode->i_link in error path

Zhipeng Lu (2):
      net/mlx5e: fix a double-free in arfs_create_groups
      fjes: fix memleaks in fjes_hw_setup


