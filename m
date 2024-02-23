Return-Path: <linux-kernel+bounces-77911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0929A860C10
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151EF1C23E52
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0254C17552;
	Fri, 23 Feb 2024 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YY4/Yj9Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AD618E1A;
	Fri, 23 Feb 2024 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676351; cv=none; b=YraYosbCtzE/8F6tk25UB0OSqy1rU9l3dog26DTnMAZW8y2qdtACP2Gs5d314HpCjz8nYpsBBpzYdpOnRIo0PurbjL04w5KanDTjG5PwJo5vAMq27/MWSZPXiZIegTnPW43P8jcAtDS4g5XB/iX2SuAUq/ZLP3GBp/icP+rfW7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676351; c=relaxed/simple;
	bh=2XnlSXGDqoMFStabsiK0mX00xDG5emN2vJE2u4fP49g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JASjtAZmO6/IZt7DKMKGlqCmixRI5efO46uwED3zdd0dCoi7Mo+ZJL/ZuBe7GdY/hjZwZ3eIbIK5LIRJvS7MbB1oJlj8WPpkGFBjIfNg5cEuJOl7+Gr/LwbAkLHhgTbgbUzEJV2sPSv5m0ZBADNYVhzOY3u/8xExN+WkpLx+xvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YY4/Yj9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C447C433C7;
	Fri, 23 Feb 2024 08:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708676350;
	bh=2XnlSXGDqoMFStabsiK0mX00xDG5emN2vJE2u4fP49g=;
	h=From:To:Cc:Subject:Date:From;
	b=YY4/Yj9YKKsJaLWYVFAkq900aVg5rfTPnRX6rRolGpiIrTGhy8GpqIqvHTZIHfhQ/
	 uLb5evCmlpZH94LvhZP/X5+TmxKjoqNJIjrTrdKkzVR4LPfTdsXaqpbTMRKJG+6ycN
	 xVQ/ZREF6kPbxhDLfwE5ZSATHUn/q5pP0R5Q3DIo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.149
Date: Fri, 23 Feb 2024 09:19:03 +0100
Message-ID: <2024022304-prelaw-probe-d1a2@gregkh>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.149 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-class-devfreq                   |    3 
 Documentation/ABI/testing/sysfs-class-net-queues                |   22 -
 Documentation/ABI/testing/sysfs-class-net-statistics            |   48 +-
 Documentation/arm64/silicon-errata.rst                          |    7 
 Documentation/filesystems/directory-locking.rst                 |   29 -
 Documentation/filesystems/locking.rst                           |    5 
 Documentation/filesystems/porting.rst                           |   18 
 Documentation/sound/soc/dapm.rst                                |    2 
 Makefile                                                        |    2 
 arch/Kconfig                                                    |    1 
 arch/arm/boot/dts/exynos4210-i9100.dts                          |    8 
 arch/arm/boot/dts/imx1-ads.dts                                  |    2 
 arch/arm/boot/dts/imx1-apf9328.dts                              |    2 
 arch/arm/boot/dts/imx1.dtsi                                     |    5 
 arch/arm/boot/dts/imx23-sansa.dts                               |   12 
 arch/arm/boot/dts/imx23.dtsi                                    |    2 
 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi                    |    2 
 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts |    2 
 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts |    2 
 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts  |    2 
 arch/arm/boot/dts/imx25-pdk.dts                                 |    2 
 arch/arm/boot/dts/imx25.dtsi                                    |    2 
 arch/arm/boot/dts/imx27-apf27dev.dts                            |    4 
 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi                    |    4 
 arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts          |    2 
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts                |    2 
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts                  |    2 
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi                 |    2 
 arch/arm/boot/dts/imx27.dtsi                                    |    3 
 arch/arm/boot/dts/imx28.dtsi                                    |    2 
 arch/arm/boot/dts/imx7d.dtsi                                    |    3 
 arch/arm/boot/dts/imx7s.dtsi                                    |   10 
 arch/arm/boot/dts/qcom-sdx55.dtsi                               |   10 
 arch/arm/boot/dts/rk3036.dtsi                                   |   14 
 arch/arm64/boot/dts/qcom/msm8996.dtsi                           |   21 +
 arch/arm64/boot/dts/qcom/msm8998.dtsi                           |   32 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi                            |    4 
 arch/arm64/boot/dts/qcom/sdm845.dtsi                            |   16 
 arch/arm64/boot/dts/qcom/sm8150.dtsi                            |    8 
 arch/arm64/include/asm/cputype.h                                |    4 
 arch/arm64/include/asm/irq_work.h                               |    2 
 arch/arm64/kernel/cpu_errata.c                                  |    3 
 arch/arm64/kernel/irq.c                                         |    7 
 arch/arm64/kernel/perf_event.c                                  |    6 
 arch/csky/include/asm/irq_work.h                                |    2 
 arch/mips/include/asm/checksum.h                                |    3 
 arch/mips/kernel/elf.c                                          |    6 
 arch/mips/mm/init.c                                             |   12 
 arch/parisc/kernel/firmware.c                                   |    4 
 arch/powerpc/include/asm/irq_work.h                             |    1 
 arch/powerpc/include/asm/mmu.h                                  |    4 
 arch/powerpc/include/asm/mmzone.h                               |    8 
 arch/powerpc/kernel/interrupt_64.S                              |    4 
 arch/powerpc/kernel/traps.c                                     |    2 
 arch/powerpc/lib/sstep.c                                        |   10 
 arch/powerpc/mm/book3s64/pgtable.c                              |    2 
 arch/powerpc/mm/init-common.c                                   |    5 
 arch/powerpc/mm/kasan/kasan_init_32.c                           |    1 
 arch/powerpc/mm/mmu_decl.h                                      |    5 
 arch/riscv/include/asm/irq_work.h                               |    2 
 arch/s390/crypto/aes_s390.c                                     |    4 
 arch/s390/crypto/paes_s390.c                                    |    4 
 arch/s390/include/asm/irq_work.h                                |    2 
 arch/s390/kernel/ptrace.c                                       |    6 
 arch/s390/kvm/kvm-s390.c                                        |    5 
 arch/um/drivers/net_kern.c                                      |    2 
 arch/um/include/shared/kern_util.h                              |    2 
 arch/um/kernel/process.c                                        |    2 
 arch/um/kernel/time.c                                           |   32 +
 arch/um/os-Linux/helper.c                                       |    6 
 arch/um/os-Linux/util.c                                         |   19 
 arch/x86/Kconfig.cpu                                            |    2 
 arch/x86/boot/compressed/ident_map_64.c                         |    5 
 arch/x86/boot/compressed/idt_64.c                               |    1 
 arch/x86/boot/compressed/idt_handlers_64.S                      |    1 
 arch/x86/boot/compressed/misc.h                                 |    1 
 arch/x86/include/asm/irq_work.h                                 |    1 
 arch/x86/include/asm/syscall_wrapper.h                          |   25 +
 arch/x86/kernel/cpu/mce/core.c                                  |   16 
 arch/x86/mm/ident_map.c                                         |   23 -
 block/bio.c                                                     |    2 
 block/blk-iocost.c                                              |    7 
 block/blk-mq.c                                                  |   16 
 block/ioctl.c                                                   |    2 
 block/partitions/core.c                                         |    5 
 crypto/algapi.c                                                 |    1 
 drivers/acpi/acpi_extlog.c                                      |    5 
 drivers/acpi/acpi_video.c                                       |    9 
 drivers/acpi/apei/ghes.c                                        |   29 +
 drivers/android/binder.c                                        |   10 
 drivers/atm/idt77252.c                                          |    2 
 drivers/base/arch_numa.c                                        |    2 
 drivers/base/power/domain.c                                     |    2 
 drivers/base/power/main.c                                       |  160 +++-----
 drivers/base/power/runtime.c                                    |    5 
 drivers/block/rbd.c                                             |   22 -
 drivers/block/rnbd/rnbd-srv.c                                   |   19 
 drivers/bluetooth/hci_qca.c                                     |    1 
 drivers/bus/mhi/host/init.c                                     |    6 
 drivers/bus/mhi/host/internal.h                                 |    2 
 drivers/bus/mhi/host/main.c                                     |   49 +-
 drivers/bus/moxtet.c                                            |    7 
 drivers/char/hw_random/core.c                                   |   34 +
 drivers/clk/hisilicon/clk-hi3620.c                              |    4 
 drivers/clk/imx/clk-imx8qxp.c                                   |   24 +
 drivers/clk/imx/clk-scu.c                                       |    4 
 drivers/clk/mmp/clk-of-pxa168.c                                 |    3 
 drivers/cpufreq/intel_pstate.c                                  |   67 +--
 drivers/crypto/ccp/sev-dev.c                                    |   10 
 drivers/crypto/marvell/octeontx2/otx2_cptlf.c                   |    6 
 drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c              |    3 
 drivers/crypto/stm32/stm32-crc32.c                              |    2 
 drivers/devfreq/devfreq.c                                       |   83 +++-
 drivers/dma-buf/dma-fence-unwrap.c                              |  176 ++++++++
 drivers/dma-buf/sync_file.c                                     |    9 
 drivers/dma/dmaengine.c                                         |    3 
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c                         |   10 
 drivers/dma/fsl-qdma.c                                          |   27 -
 drivers/dma/ti/k3-udma.c                                        |   10 
 drivers/firewire/core-device.c                                  |    7 
 drivers/firmware/arm_scmi/common.h                              |    1 
 drivers/firmware/arm_scmi/mailbox.c                             |   14 
 drivers/firmware/arm_scmi/shmem.c                               |    6 
 drivers/gpio/gpio-eic-sprd.c                                    |   32 +
 drivers/gpio/gpiolib-acpi.c                                     |   14 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c                |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                      |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c                         |    9 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c                      |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h                      |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c                        |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                         |    5 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                            |   36 -
 drivers/gpu/drm/amd/display/dc/core/dc.c                        |    4 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c           |    6 
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c         |    6 
 drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c         |    6 
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c           |    6 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c  |    2 
 drivers/gpu/drm/bridge/nxp-ptn3460.c                            |    6 
 drivers/gpu/drm/drm_fb_helper.c                                 |   11 
 drivers/gpu/drm/drm_file.c                                      |    2 
 drivers/gpu/drm/drm_framebuffer.c                               |    2 
 drivers/gpu/drm/drm_mipi_dsi.c                                  |   17 
 drivers/gpu/drm/drm_plane.c                                     |    1 
 drivers/gpu/drm/drm_prime.c                                     |    2 
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c                   |    4 
 drivers/gpu/drm/exynos/exynos_drm_drv.c                         |   11 
 drivers/gpu/drm/exynos/exynos_drm_fimd.c                        |    4 
 drivers/gpu/drm/exynos/exynos_drm_gsc.c                         |    2 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                     |    5 
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h                         |    1 
 drivers/gpu/drm/msm/dp/dp_link.c                                |   12 
 drivers/gpu/drm/msm/dp/dp_reg.h                                 |    3 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c                           |    4 
 drivers/gpu/drm/nouveau/nouveau_vmm.c                           |    3 
 drivers/gpu/drm/panel/panel-simple.c                            |    2 
 drivers/gpu/drm/scheduler/sched_main.c                          |    3 
 drivers/gpu/drm/tidss/tidss_crtc.c                              |   10 
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c                              |    8 
 drivers/hid/hid-apple.c                                         |   33 +
 drivers/hid/hid-ids.h                                           |    1 
 drivers/hid/hid-picolcd_fb.c                                    |    2 
 drivers/hid/hid-quirks.c                                        |    1 
 drivers/hid/i2c-hid/i2c-hid-of.c                                |    1 
 drivers/hid/wacom_sys.c                                         |   63 ++-
 drivers/hid/wacom_wac.c                                         |    9 
 drivers/hwmon/aspeed-pwm-tacho.c                                |    7 
 drivers/hwmon/coretemp.c                                        |   40 +-
 drivers/i2c/busses/i2c-i801.c                                   |   19 
 drivers/i3c/master/i3c-master-cdns.c                            |    7 
 drivers/iio/accel/Kconfig                                       |    2 
 drivers/iio/adc/ad7091r-base.c                                  |  173 ++++++++
 drivers/iio/adc/ad7091r-base.h                                  |    8 
 drivers/iio/adc/ad7091r5.c                                      |   29 -
 drivers/iio/industrialio-core.c                                 |    5 
 drivers/iio/light/hid-sensor-als.c                              |    1 
 drivers/iio/magnetometer/rm3100-core.c                          |   10 
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c                  |    7 
 drivers/input/keyboard/atkbd.c                                  |   13 
 drivers/input/serio/i8042-acpipnpio.h                           |    6 
 drivers/irqchip/irq-brcmstb-l2.c                                |    5 
 drivers/irqchip/irq-gic-v3-its.c                                |   22 -
 drivers/leds/trigger/ledtrig-panic.c                            |    5 
 drivers/mailbox/arm_mhuv2.c                                     |    3 
 drivers/md/dm-core.h                                            |    2 
 drivers/md/dm-ioctl.c                                           |    3 
 drivers/md/dm-table.c                                           |    9 
 drivers/md/md.c                                                 |   54 ++
 drivers/media/i2c/imx335.c                                      |    4 
 drivers/media/i2c/imx355.c                                      |   12 
 drivers/media/i2c/ov9734.c                                      |   19 
 drivers/media/pci/ddbridge/ddbridge-main.c                      |    2 
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c                 |    6 
 drivers/media/platform/rockchip/rga/rga.c                       |   15 
 drivers/media/rc/bpf-lirc.c                                     |    6 
 drivers/media/rc/ir_toy.c                                       |    2 
 drivers/media/rc/lirc_dev.c                                     |    5 
 drivers/media/rc/rc-core-priv.h                                 |    2 
 drivers/media/usb/stk1160/stk1160-video.c                       |    5 
 drivers/mfd/Kconfig                                             |    1 
 drivers/misc/fastrpc.c                                          |    2 
 drivers/misc/lkdtm/bugs.c                                       |    2 
 drivers/mmc/core/block.c                                        |   46 ++
 drivers/mmc/core/slot-gpio.c                                    |    6 
 drivers/mmc/host/mmc_spi.c                                      |  186 ---------
 drivers/net/bonding/bond_alb.c                                  |    3 
 drivers/net/dsa/mv88e6xxx/chip.h                                |    4 
 drivers/net/dsa/mv88e6xxx/serdes.c                              |    8 
 drivers/net/dsa/mv88e6xxx/serdes.h                              |    8 
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                       |    5 
 drivers/net/ethernet/broadcom/genet/bcmgenet.c                  |   22 -
 drivers/net/ethernet/broadcom/genet/bcmgenet.h                  |    3 
 drivers/net/ethernet/broadcom/genet/bcmmii.c                    |    6 
 drivers/net/ethernet/freescale/fec_main.c                       |    2 
 drivers/net/ethernet/google/gve/gve_tx_dqo.c                    |    5 
 drivers/net/ethernet/intel/i40e/i40e_main.c                     |    2 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c              |   32 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h              |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c                  |   36 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c                  |   61 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c                 |  177 ++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c                |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                   |   44 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c                    |   34 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h                    |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c                    |  105 ++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h                    |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c                  |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h                   |   51 --
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c                   |   44 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c                   |  149 +++----
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                 |   27 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c             |   13 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c        |   14 
 drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c     |    1 
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c               |   26 -
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c    |   19 
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_domain.c    |    2 
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c      |    4 
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h     |    7 
 drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c         |    2 
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c       |    6 
 drivers/net/ethernet/pensando/ionic/ionic_dev.c                 |    1 
 drivers/net/ethernet/pensando/ionic/ionic_dev.h                 |    1 
 drivers/net/ethernet/pensando/ionic/ionic_main.c                |    2 
 drivers/net/ethernet/stmicro/stmmac/common.h                    |    1 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h                  |    3 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c             |   58 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c               |    3 
 drivers/net/ethernet/ti/cpsw.c                                  |    2 
 drivers/net/ethernet/ti/cpsw_new.c                              |    3 
 drivers/net/fjes/fjes_hw.c                                      |   37 +
 drivers/net/hyperv/netvsc.c                                     |    5 
 drivers/net/hyperv/netvsc_drv.c                                 |    4 
 drivers/net/ppp/ppp_async.c                                     |    4 
 drivers/net/virtio_net.c                                        |    9 
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c                   |    5 
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c                    |   12 
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c                |    2 
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c                  |    3 
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c                  |   11 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c           |   12 
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c            |    6 
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c            |    4 
 drivers/net/xen-netback/netback.c                               |   84 ++--
 drivers/of/property.c                                           |    2 
 drivers/of/unittest.c                                           |   12 
 drivers/pci/pci.h                                               |    2 
 drivers/pci/pcie/aer.c                                          |    9 
 drivers/pci/quirks.c                                            |   24 +
 drivers/pci/switch/switchtec.c                                  |   25 -
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                        |    4 
 drivers/phy/ti/phy-omap-usb2.c                                  |    4 
 drivers/pnp/pnpacpi/rsparser.c                                  |   12 
 drivers/regulator/core.c                                        |   56 +-
 drivers/rpmsg/virtio_rpmsg_bus.c                                |    1 
 drivers/rtc/rtc-cmos.c                                          |    4 
 drivers/s390/net/qeth_l3_main.c                                 |    9 
 drivers/scsi/arcmsr/arcmsr.h                                    |    4 
 drivers/scsi/arcmsr/arcmsr_hba.c                                |    6 
 drivers/scsi/fcoe/fcoe_ctlr.c                                   |   20 -
 drivers/scsi/isci/request.c                                     |    2 
 drivers/scsi/libfc/fc_fcp.c                                     |   18 
 drivers/scsi/lpfc/lpfc.h                                        |    1 
 drivers/scsi/lpfc/lpfc_init.c                                   |    4 
 drivers/scsi/scsi_error.c                                       |    9 
 drivers/scsi/scsi_lib.c                                         |    4 
 drivers/scsi/scsi_priv.h                                        |    2 
 drivers/scsi/storvsc_drv.c                                      |   12 
 drivers/scsi/ufs/ufshcd.c                                       |   14 
 drivers/spi/spi-bcm-qspi.c                                      |    4 
 drivers/spi/spi-ppc4xx.c                                        |    5 
 drivers/staging/fbtft/fbtft-core.c                              |   14 
 drivers/staging/iio/impedance-analyzer/ad5933.c                 |    2 
 drivers/tty/serial/8250/8250_exar.c                             |   13 
 drivers/tty/serial/max310x.c                                    |   33 +
 drivers/tty/tty_ioctl.c                                         |    4 
 drivers/usb/core/hub.c                                          |   34 +
 drivers/usb/dwc3/core.h                                         |    1 
 drivers/usb/dwc3/ep0.c                                          |   27 +
 drivers/usb/dwc3/gadget.c                                       |  162 ++++++--
 drivers/usb/dwc3/gadget.h                                       |    3 
 drivers/usb/dwc3/host.c                                         |    4 
 drivers/usb/gadget/function/f_mass_storage.c                    |   20 -
 drivers/usb/host/xhci-plat.c                                    |    3 
 drivers/usb/serial/cp210x.c                                     |    1 
 drivers/usb/serial/option.c                                     |    1 
 drivers/usb/serial/qcserial.c                                   |    2 
 drivers/usb/typec/ucsi/ucsi_acpi.c                              |   17 
 drivers/vhost/vhost.c                                           |    5 
 drivers/video/fbdev/broadsheetfb.c                              |   14 
 drivers/video/fbdev/core/fb_defio.c                             |  168 ++++++--
 drivers/video/fbdev/core/fbmem.c                                |    4 
 drivers/video/fbdev/hecubafb.c                                  |    3 
 drivers/video/fbdev/hyperv_fb.c                                 |    8 
 drivers/video/fbdev/metronomefb.c                               |   14 
 drivers/video/fbdev/sh_mobile_lcdcfb.c                          |   20 -
 drivers/video/fbdev/smscufx.c                                   |    9 
 drivers/video/fbdev/ssd1307fb.c                                 |    3 
 drivers/video/fbdev/udlfb.c                                     |   10 
 drivers/video/fbdev/xen-fbfront.c                               |    8 
 drivers/watchdog/it87_wdt.c                                     |   14 
 drivers/xen/gntdev-dmabuf.c                                     |   50 +-
 fs/afs/callback.c                                               |    3 
 fs/afs/dir.c                                                    |    8 
 fs/afs/server.c                                                 |    7 
 fs/btrfs/ctree.h                                                |   22 +
 fs/btrfs/delayed-inode.c                                        |    5 
 fs/btrfs/delayed-inode.h                                        |    1 
 fs/btrfs/disk-io.c                                              |   13 
 fs/btrfs/extent-tree.c                                          |    3 
 fs/btrfs/inode.c                                                |  172 +++++---
 fs/btrfs/ioctl.c                                                |   12 
 fs/btrfs/qgroup.c                                               |   14 
 fs/btrfs/ref-verify.c                                           |    6 
 fs/btrfs/send.c                                                 |    2 
 fs/btrfs/sysfs.c                                                |    9 
 fs/btrfs/tree-checker.c                                         |    2 
 fs/ceph/caps.c                                                  |   12 
 fs/cifs/smb2misc.c                                              |    2 
 fs/cifs/smb2ops.c                                               |   14 
 fs/cifs/smb2pdu.c                                               |   13 
 fs/cifs/smb2pdu.h                                               |   42 +-
 fs/dcache.c                                                     |    7 
 fs/ecryptfs/inode.c                                             |    8 
 fs/exec.c                                                       |    3 
 fs/ext4/mballoc.c                                               |   26 -
 fs/ext4/move_extent.c                                           |    6 
 fs/ext4/resize.c                                                |   37 +
 fs/f2fs/compress.c                                              |    4 
 fs/f2fs/file.c                                                  |    2 
 fs/f2fs/recovery.c                                              |   25 -
 fs/hugetlbfs/inode.c                                            |   13 
 fs/ioctl.c                                                      |    3 
 fs/jfs/jfs_dmap.c                                               |   57 +-
 fs/jfs/jfs_dtree.c                                              |    7 
 fs/jfs/jfs_imap.c                                               |    3 
 fs/jfs/jfs_mount.c                                              |    6 
 fs/kernfs/dir.c                                                 |   12 
 fs/ksmbd/asn1.c                                                 |    5 
 fs/ksmbd/connection.c                                           |    7 
 fs/ksmbd/connection.h                                           |    2 
 fs/ksmbd/ksmbd_netlink.h                                        |    3 
 fs/ksmbd/oplock.c                                               |   22 -
 fs/ksmbd/smb2pdu.c                                              |   53 +-
 fs/ksmbd/smbacl.c                                               |   11 
 fs/ksmbd/transport_ipc.c                                        |    4 
 fs/ksmbd/transport_rdma.c                                       |   11 
 fs/ksmbd/transport_tcp.c                                        |   13 
 fs/namei.c                                                      |   60 +--
 fs/nilfs2/dat.c                                                 |   27 -
 fs/nilfs2/file.c                                                |    8 
 fs/nilfs2/recovery.c                                            |    7 
 fs/nilfs2/segment.c                                             |    8 
 fs/ntfs3/fsntfs.c                                               |   16 
 fs/ntfs3/index.c                                                |    3 
 fs/ntfs3/ntfs_fs.h                                              |    2 
 fs/pipe.c                                                       |   19 
 fs/pstore/ram.c                                                 |    1 
 fs/ubifs/dir.c                                                  |    2 
 fs/xfs/xfs_super.c                                              |   27 -
 include/asm-generic/numa.h                                      |    2 
 include/drm/drm_color_mgmt.h                                    |    1 
 include/drm/drm_fb_helper.h                                     |    3 
 include/drm/drm_mipi_dsi.h                                      |    2 
 include/linux/async.h                                           |    2 
 include/linux/bpf.h                                             |    6 
 include/linux/dma-fence.h                                       |   19 
 include/linux/dmaengine.h                                       |    3 
 include/linux/fb.h                                              |   18 
 include/linux/hrtimer.h                                         |    4 
 include/linux/irq_work.h                                        |    3 
 include/linux/lsm_hook_defs.h                                   |    2 
 include/linux/mmzone.h                                          |   18 
 include/linux/netfilter/ipset/ip_set.h                          |    4 
 include/linux/overflow.h                                        |   72 ++-
 include/linux/pci_ids.h                                         |    1 
 include/linux/pipe_fs_i.h                                       |   16 
 include/linux/pm_runtime.h                                      |    4 
 include/linux/security.h                                        |    9 
 include/linux/syscalls.h                                        |    1 
 include/net/af_unix.h                                           |   20 -
 include/net/inet_connection_sock.h                              |    8 
 include/net/llc_pdu.h                                           |    6 
 include/net/netfilter/nf_tables.h                               |    2 
 include/uapi/linux/btrfs.h                                      |    4 
 include/uapi/linux/netfilter/nf_tables.h                        |    2 
 kernel/async.c                                                  |   85 +++-
 kernel/audit.c                                                  |   31 +
 kernel/bpf/arraymap.c                                           |   12 
 kernel/bpf/hashtab.c                                            |    6 
 kernel/bpf/map_in_map.c                                         |    2 
 kernel/bpf/map_in_map.h                                         |    2 
 kernel/bpf/syscall.c                                            |    6 
 kernel/events/core.c                                            |   38 +
 kernel/power/swap.c                                             |   38 -
 kernel/sched/membarrier.c                                       |    9 
 kernel/time/clocksource.c                                       |   25 +
 kernel/time/hrtimer.c                                           |   17 
 kernel/time/tick-sched.c                                        |    5 
 kernel/trace/ring_buffer.c                                      |    2 
 kernel/trace/trace.c                                            |   78 ++-
 kernel/trace/trace_events_trigger.c                             |    6 
 kernel/trace/tracing_map.c                                      |    7 
 lib/debugobjects.c                                              |  200 +++-------
 lib/mpi/ec.c                                                    |    3 
 mm/page-writeback.c                                             |    2 
 mm/sparse.c                                                     |   17 
 net/8021q/vlan_netlink.c                                        |    4 
 net/bluetooth/l2cap_core.c                                      |    3 
 net/bridge/br_cfm_netlink.c                                     |    2 
 net/bridge/br_multicast.c                                       |   20 -
 net/bridge/br_private.h                                         |    4 
 net/can/j1939/j1939-priv.h                                      |    3 
 net/can/j1939/main.c                                            |    2 
 net/can/j1939/socket.c                                          |   46 +-
 net/core/request_sock.c                                         |    3 
 net/core/skbuff.c                                               |    3 
 net/hsr/hsr_device.c                                            |    4 
 net/ipv4/af_inet.c                                              |    9 
 net/ipv4/inet_connection_sock.c                                 |    4 
 net/ipv4/ip_output.c                                            |   12 
 net/ipv4/ip_tunnel_core.c                                       |    2 
 net/ipv4/tcp.c                                                  |   13 
 net/ipv6/addrconf_core.c                                        |   21 -
 net/ipv6/af_inet6.c                                             |    3 
 net/ipv6/ip6_tunnel.c                                           |   28 -
 net/llc/af_llc.c                                                |   26 -
 net/llc/llc_core.c                                              |    7 
 net/mac80211/tx.c                                               |    3 
 net/mptcp/protocol.c                                            |    3 
 net/netfilter/ipset/ip_set_bitmap_gen.h                         |   14 
 net/netfilter/ipset/ip_set_core.c                               |   39 +
 net/netfilter/ipset/ip_set_hash_gen.h                           |   19 
 net/netfilter/ipset/ip_set_list_set.c                           |   13 
 net/netfilter/nf_log.c                                          |    7 
 net/netfilter/nf_tables_api.c                                   |   34 -
 net/netfilter/nft_chain_filter.c                                |   11 
 net/netfilter/nft_compat.c                                      |   23 +
 net/netfilter/nft_ct.c                                          |   27 +
 net/netfilter/nft_flow_offload.c                                |    5 
 net/netfilter/nft_limit.c                                       |   23 -
 net/netfilter/nft_nat.c                                         |    5 
 net/netfilter/nft_rt.c                                          |    5 
 net/netfilter/nft_set_pipapo.c                                  |  108 ++---
 net/netfilter/nft_set_pipapo.h                                  |   18 
 net/netfilter/nft_set_pipapo_avx2.c                             |   17 
 net/netfilter/nft_set_rbtree.c                                  |    6 
 net/netfilter/nft_socket.c                                      |    5 
 net/netfilter/nft_synproxy.c                                    |    7 
 net/netfilter/nft_tproxy.c                                      |    5 
 net/netfilter/nft_tunnel.c                                      |    1 
 net/netfilter/nft_xfrm.c                                        |    5 
 net/netlink/af_netlink.c                                        |    2 
 net/nfc/nci/core.c                                              |    4 
 net/openvswitch/flow_netlink.c                                  |   49 +-
 net/rds/af_rds.c                                                |    2 
 net/rxrpc/conn_event.c                                          |    8 
 net/rxrpc/conn_service.c                                        |    3 
 net/smc/smc_diag.c                                              |    2 
 net/sunrpc/xprtmultipath.c                                      |   17 
 net/tipc/bearer.c                                               |    6 
 net/unix/af_unix.c                                              |   14 
 net/unix/diag.c                                                 |    2 
 net/unix/garbage.c                                              |   12 
 net/wireless/scan.c                                             |    4 
 scripts/decode_stacktrace.sh                                    |   60 ++-
 scripts/get_abi.pl                                              |    2 
 scripts/link-vmlinux.sh                                         |    9 
 scripts/mod/sumversion.c                                        |    7 
 security/security.c                                             |   32 +
 security/selinux/hooks.c                                        |   28 +
 security/smack/smack_lsm.c                                      |    1 
 security/tomoyo/tomoyo.c                                        |    1 
 sound/hda/hdac_stream.c                                         |    9 
 sound/hda/intel-dsp-config.c                                    |   10 
 sound/pci/hda/hda_intel.c                                       |    2 
 sound/pci/hda/patch_conexant.c                                  |  133 ++++++
 sound/pci/hda/patch_cs8409.c                                    |    1 
 sound/pci/hda/patch_realtek.c                                   |    3 
 sound/soc/codecs/lpass-wsa-macro.c                              |    7 
 sound/soc/codecs/rt5645.c                                       |    1 
 sound/soc/codecs/wcd938x.c                                      |    2 
 sound/usb/quirks.c                                              |    4 
 tools/build/feature/test-libopencsd.c                           |    4 
 tools/lib/bpf/libbpf.c                                          |    2 
 tools/lib/subcmd/help.c                                         |   18 
 tools/testing/selftests/bpf/cgroup_helpers.c                    |   18 
 tools/testing/selftests/bpf/prog_tests/btf.c                    |    1 
 tools/testing/selftests/bpf/prog_tests/tailcalls.c              |   55 --
 tools/testing/selftests/bpf/progs/pyperf180.c                   |   22 +
 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c           |   42 --
 tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh |    9 
 tools/testing/selftests/net/pmtu.sh                             |   34 +
 tools/testing/selftests/net/setup_veth.sh                       |    2 
 tools/testing/selftests/net/udpgro_fwd.sh                       |   14 
 tools/testing/selftests/net/udpgso_bench_rx.c                   |    2 
 tools/testing/selftests/sgx/test_encl.lds                       |    6 
 519 files changed, 5029 insertions(+), 2677 deletions(-)

Aaron Conole (1):
      net: openvswitch: limit the number of recursions from action sets

Adrian Reber (1):
      tty: allow TIOCSLCKTRMIOS with CAP_CHECKPOINT_RESTORE

Al Viro (2):
      rename(): fix the locking of subdirectories
      fast_dput(): handle underflows gracefully

Aleksander Mazur (1):
      x86/Kconfig: Transmeta Crusoe is CPU family 5, not 6

Alex Henrie (1):
      HID: apple: Add support for the 2021 Magic Keyboard

Alex Lyakas (1):
      md: Whenassemble the array, consult the superblock of the freshest device

Alexander Stein (5):
      ARM: dts: imx7d: Fix coresight funnel ports
      ARM: dts: imx7s: Fix lcdif compatible
      ARM: dts: imx7s: Fix nand-controller #size-cells
      clk: imx: clk-imx8qxp: fix LVDS bypass, pixel and phy clocks
      mmc: slot-gpio: Allow non-sleeping GPIO ro

Alexander Tsoy (1):
      ALSA: usb-audio: Add delay quirk for MOTU M Series 2nd revision

Alexandra Winter (1):
      s390/qeth: Fix potential loss of L3-IP@ in case of network issues

Alexey Khoroshilov (1):
      ASoC: rt5645: Fix deadlock in rt5645_jack_detect_work()

Alfred Piccioni (1):
      lsm: new security_file_ioctl_compat() hook

Amelie Delaunay (1):
      dmaengine: fix NULL pointer in channel unregistration function

Andrii Nakryiko (1):
      selftests/bpf: satisfy compiler by having explicit return in btf test

Andrii Staikov (1):
      i40e: Fix VF disable behavior to block all traffic

Andrzej Hajda (1):
      debugobjects: Stop accessing objects after releasing hash bucket lock

Andy Shevchenko (1):
      mmc: mmc_spi: remove custom DMA mapped buffers

Anna Schumaker (1):
      SUNRPC: Fix a suspicious RCU usage warning

Anson Jacob (1):
      drm/amd/display: Fix multiple memory leaks reported by coverity

Antoine Tenart (1):
      tunnels: fix out of bounds access when building IPv6 PMTU error

Anton Ivanov (1):
      um: Fix naming clash between UML and scheduler

Arnd Bergmann (2):
      drm/exynos: fix accidental on-stack copy of exynos_drm_plane
      arch: consolidate arch_irq_work_raise prototypes

Avri Altman (1):
      mmc: core: Use mrq.sbc in close-ended ffu

Baokun Li (4):
      ext4: unify the type of flexbg_size to unsigned int
      ext4: remove unnecessary check from alloc_flex_gd()
      ext4: avoid online resizing failures due to oversized flex bg
      ext4: fix double-free of blocks due to wrong extents moved_len

Bart Van Assche (2):
      scsi: ufs: core: Simplify power management during async scan
      scsi: ufs: core: Remove the ufshcd_hba_exit() call from ufshcd_async_scan()

Benjamin Berg (3):
      wifi: cfg80211: free beacon_ies when overridden from hidden BSS
      um: Don't use vfprintf() for os_info()
      HID: apple: Add 2021 magic keyboard FN key mapping

Bernd Edlinger (2):
      net: stmmac: Wait a bit for the reset to take effect
      exec: Fix error handling in begin_new_exec()

Bharat Bhushan (1):
      crypto: octeontx2 - Fix cptvf driver cleanup

Bhaumik Bhatt (1):
      bus: mhi: host: Add spinlock to protect WP access when queueing TREs

Bingbu Cao (2):
      media: imx355: Enable runtime PM before registering async sub-device
      media: ov9734: Enable runtime PM before registering async sub-device

Bjorn Helgaas (1):
      PCI/AER: Decode Requester ID when no error info found

Boris Burkov (2):
      btrfs: forbid creating subvol qgroups
      btrfs: forbid deleting live subvol qgroup

Breno Leitao (2):
      net: sysfs: Fix /sys/class/net/<iface> path
      net: sysfs: Fix /sys/class/net/<iface> path for statistics

Carlos Llamas (2):
      binder: signal epoll threads of self-work
      scripts/decode_stacktrace.sh: optionally use LLVM utilities

Chao Yu (2):
      f2fs: fix to check return value of f2fs_reserve_new_block()
      f2fs: fix to tag gcing flag on page during block migration

Charan Teja Kalla (1):
      mm/sparsemem: fix race in accessing memory_section->usage

Chris Riches (1):
      audit: Send netlink ACK before setting connection in auditd_set

Christian A. Ehrhardt (2):
      of: unittest: Fix compile in the non-dynamic case
      usb: ucsi_acpi: Fix command completion handling

Christian König (1):
      dma-buf: add dma_fence_timestamp helper

Christian Marangi (1):
      PM / devfreq: Fix buffer overflow in trans_stat_show

Christoph Hellwig (1):
      block: prevent an integer overflow in bvec_try_merge_hw_page

Christophe JAILLET (3):
      ixgbe: Fix an error handling path in ixgbe_read_iosf_sb_reg_x550()
      dmaengine: fsl-qdma: Fix a memory leak related to the status queue DMA
      dmaengine: fsl-qdma: Fix a memory leak related to the queue command DMA

Chuansheng Liu (1):
      fbdev: defio: fix the pagelist corruption

Chung-Chiang Cheng (1):
      btrfs: tree-checker: fix inline ref size in error messages

Cristian Ciocaltea (1):
      ASoC: doc: Fix undefined SND_SOC_DAPM_NOPM argument

Cristian Marussi (1):
      firmware: arm_scmi: Check mailbox/SMT channel for consistency

Dan Carpenter (4):
      drm/bridge: nxp-ptn3460: fix i2c_master_send() error checking
      drm/bridge: nxp-ptn3460: simplify some error checking
      fs/ntfs3: Fix an NULL dereference bug
      wifi: iwlwifi: Fix some error codes

Daniel Basilio (1):
      nfp: use correct macro for LengthSelect in BAR config

Daniel Stodden (1):
      PCI: switchtec: Fix stdev_release() crash after surprise hot remove

Daniel Vacek (1):
      IB/ipoib: Fix mcast list locking

Daniel de Villiers (1):
      nfp: flower: prevent re-adding mac index for bonded port

Dave Airlie (1):
      nouveau/vmm: don't set addr on the fail path to avoid warning

Dave Chinner (1):
      xfs: read only mounts with fsopen mount API are busted

David Disseldorp (1):
      btrfs: sysfs: validate scrub_speed_max value

David Howells (2):
      afs: Hide silly-rename files from userspace
      rxrpc: Fix response to PING RESPONSE ACKs to a dead call

David Schiller (1):
      staging: iio: ad5933: fix type mismatch regression

David Senoner (1):
      ALSA: hda/realtek: Fix the external mic not being recognised for Acer Swift 1 SF114-32

David Sterba (2):
      btrfs: don't warn if discard range is not aligned to sector
      btrfs: send: return EOPNOTSUPP on unknown flags

Davidlohr Bueso (1):
      hrtimer: Ignore slack time for RT tasks in schedule_hrtimeout_range()

Dinghao Liu (2):
      net/mlx5e: fix a potential double-free in fs_any_create_groups
      iio: core: fix memleak in iio_device_register_sysfs

Dmitry Antipov (1):
      PNP: ACPI: fix fortify warning

Doug Berger (1):
      irqchip/irq-brcmstb-l2: Add write memory barrier before exit

Douglas Anderson (2):
      drm/exynos: Call drm_atomic_helper_shutdown() at shutdown/unbind time
      PM: runtime: Have devm_pm_runtime_enable() handle pm_runtime_dont_use_autosuspend()

Easwar Hariharan (1):
      arm64: Subscribe Microsoft Azure Cobalt 100 to ARM Neoverse N2 errata

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Enable headset mic on Vaio VJFE-ADL

Edward Adam Davis (3):
      jfs: fix uaf in jfs_evict_inode
      jfs: fix array-index-out-of-bounds in diNewExt
      wifi: cfg80211: fix RCU dereference in __cfg80211_bss_update

Ekansh Gupta (1):
      misc: fastrpc: Mark all sessions as invalid in cb_remove

Emmanuel Grumbach (1):
      wifi: iwlwifi: fix a memory corruption

Eric Dumazet (9):
      llc: make llc_ui_sendmsg() more robust against bonding changes
      ip6_tunnel: use dev_sw_netstats_rx_add()
      ip6_tunnel: make sure to pull inner header in __ip6_tnl_rcv()
      tcp: add sanity checks to rx zerocopy
      llc: call sock_orphan() at release time
      af_unix: fix lockdep positive in sk_diag_dump_icons()
      inet: read sk->sk_family once in inet_recv_error()
      ppp_async: limit MRU to 64K
      net: prevent mss overflow in skb_segment()

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

Fedor Pchelkin (4):
      ksmbd: free ppace array on error in parse_dacl
      btrfs: ref-verify: free ref cache before clearing mount opt
      drm/exynos: gsc: minor fix for loop iteration in gsc_runtime_resume
      nfc: nci: free rx_data_reassembly skb on NCI device cleanup

Felix Kuehling (2):
      drm/amdgpu: Let KFD sync with VM fences
      drm/amdkfd: Fix lock dependency warning

Filipe Manana (4):
      btrfs: fix infinite directory reads
      btrfs: set last dir index to the current last index when opening dir
      btrfs: refresh dir last index during a rewinddir(3) call
      btrfs: fix race between reading a directory and adding entries to it

Florian Fainelli (1):
      net: bcmgenet: Fix EEE implementation

Florian Westphal (6):
      netfilter: nft_limit: reject configurations that cause integer overflow
      netfilter: nf_tables: restrict anonymous set and map names to 16 bytes
      netfilter: nf_tables: reject QUEUE/DROP verdict parameters
      netfilter: nft_set_pipapo: store index in scratch maps
      netfilter: nft_set_pipapo: add helper to release pcpu scratch area
      netfilter: nft_set_pipapo: remove scratch_aligned pointer

Frank Li (1):
      dmaengine: fix is_slave_direction() return false when DMA_DEV_TO_DEV

Frederic Weisbecker (1):
      hrtimer: Report offline hrtimer enqueue

Frédéric Danis (1):
      Bluetooth: L2CAP: Fix possible multiple reject send

Furong Xu (2):
      net: stmmac: xgmac: fix handling of DPP safety error for DMA channels
      net: stmmac: xgmac: fix a typo of register name in DPP safety handling

Gabriel Krisman Bertazi (1):
      ecryptfs: Reject casefold directory inodes

Ghanshyam Agrawal (1):
      media: stk1160: Fixed high volume of stk1160_dbg messages

Greg KH (1):
      perf/core: Fix narrow startup race when creating the perf nr_addr_filters sysfs file

Greg Kroah-Hartman (1):
      Linux 5.15.149

Guanhua Gao (1):
      dmaengine: fsl-dpaa2-qdma: Fix the size of dma pools

Guenter Roeck (1):
      MIPS: Add 'memory' clobber to csum_ipv6_magic() inline assembler

Guilherme G. Piccoli (1):
      PCI: Only override AMD USB controller if required

Hannes Reinecke (2):
      scsi: libfc: Don't schedule abort twice
      scsi: libfc: Fix up timeout error in fc_fcp_rec_error()

Hans de Goede (1):
      Input: atkbd - skip ATKBD_CMD_SETLEDS when skipping ATKBD_CMD_GETID

Hardik Gajjar (1):
      usb: hub: Replace hardcoded quirk value with BIT() macro

Harshit Shah (1):
      i3c: master: cdns: Update maximum prescaler value for i2c clock

Heiko Carstens (2):
      s390/ptrace: handle setting of fpc register correctly
      KVM: s390: fix setting of fpc register

Heiner Kallweit (2):
      leds: trigger: panic: Don't register panic notifier if creating the trigger failed
      i2c: i801: Remove i801_set_block_buffer_mode

Helge Deller (2):
      parisc/firmware: Fix F-extend for PDC addresses
      ipv6: Ensure natural alignment of const ipv6 loopback and router addresses

Herbert Xu (3):
      crypto: api - Disallow identical driver names
      hwrng: core - Fix page fault dead lock on mmap-ed hwrng
      crypto: s390/aes - Fix buffer overread in CTR mode

Hongchen Zhang (1):
      PM: hibernate: Enforce ordering during image compression/decompression

Hou Tao (2):
      bpf: Add map and need_defer parameters to .map_fd_put_ptr()
      bpf: Set uattr->batch.count as zero before batched update or deletion

Huang Shijie (2):
      arm64: irq: set the correct node for VMAP stack
      arm64: irq: set the correct node for shadow call stack

Hugo Villeneuve (3):
      serial: max310x: set default value when reading clock ready bit
      serial: max310x: improve crystal stable clock detection
      serial: max310x: fail probe if clock crystal is unstable

Ian Rogers (1):
      libsubcmd: Fix memory leak in uniq()

Ido Schimmel (1):
      PCI: Add no PM reset quirk for NVIDIA Spectrum devices

Ilpo Järvinen (2):
      PCI: Fix 64GT/s effective data rate calculation
      serial: 8250_exar: Fill in rs485_supported

Ilya Dryomov (1):
      rbd: don't move requests to the running list on errors

Ivan Vecera (1):
      i40e: Fix waiting for queues of all VSIs to be disabled

Jack Wang (1):
      RDMA/IPoIB: Fix error code return in ipoib_mcast_join

JackBB Wu (1):
      USB: serial: qcserial: add new usb-id for Dell Wireless DW5826e

Jaegeuk Kim (1):
      f2fs: fix write pointers on zoned device after roll forward

Jai Luthra (1):
      dmaengine: ti: k3-udma: Report short packet errors

Jakub Kicinski (1):
      selftests: netdevsim: fix the udp_tunnel_nic test

James Clark (1):
      perf cs-etm: Bump minimum OpenCSD version to ensure a bugfix is present

Jan Beulich (1):
      xen-netback: properly sync TX responses

Jason Gerecke (1):
      HID: wacom: Do not register input devices until after hid_hw_start

Jean Delvare (1):
      i2c: i801: Fix block process call transactions

Jedrzej Jagielski (2):
      ixgbe: Refactor returning internal error codes
      ixgbe: Refactor overtemp event handling

Jenishkumar Maheshbhai Patel (1):
      net: mvpp2: clear BM pool before initialization

Jiangfeng Xiao (1):
      powerpc/kasan: Fix addr error caused by page alignment

Jiri Wiesner (1):
      clocksource: Skip watchdog check for large watchdog intervals

Jo Van Bulck (1):
      selftests/sgx: Fix linker script asserts

Johan Hovold (10):
      arm64: dts: qcom: sc7180: fix USB wakeup interrupt types
      arm64: dts: qcom: sdm845: fix USB wakeup interrupt types
      arm64: dts: qcom: sm8150: fix USB wakeup interrupt types
      arm64: dts: qcom: sdm845: fix USB DP/DM HS PHY interrupts
      ARM: dts: qcom: sdx55: fix USB wakeup interrupt types
      ARM: dts: qcom: sdx55: fix pdc '#interrupt-cells'
      ARM: dts: qcom: sdx55: fix USB DP/DM HS PHY interrupts
      ARM: dts: qcom: sdx55: fix USB SS wakeup
      ASoC: codecs: lpass-wsa-macro: fix compander volume hack
      HID: i2c-hid-of: fix NULL-deref on failed power up

Johan Jonker (1):
      ARM: dts: rockchip: fix rk3036 hdmi ports node

Johannes Berg (2):
      um: time-travel: fix time corruption
      wifi: mac80211: reload info pointer in ieee80211_tx_dequeue()

Jonathan Cameron (1):
      iio:adc:ad7091r: Move exports into IIO_AD7091R namespace.

Josef Bacik (1):
      btrfs: add definition for EXTENT_TREE_V2

Jozsef Kadlecsik (2):
      netfilter: ipset: fix performance regression in swap operation
      netfilter: ipset: Missing gc cancellations fixed

Julian Sikorski (1):
      ALSA: usb-audio: Add a quirk for Yamaha YIT-W12TX transmitter

Jun'ichi Nomura (1):
      x86/boot: Ignore NMIs during very early boot

Justin Stitt (1):
      drivers: lkdtm: fix clang -Wformat warning

Justin Tee (1):
      scsi: lpfc: Fix possible file string name overflow when updating firmware

Kamal Dasu (1):
      spi: bcm-qspi: fix SFDP BFPT read by usig mspi read

Kees Cook (3):
      overflow: Allow mixed type arguments
      block/rnbd-srv: Check for unlikely string overflow
      smb3: Replace smb2pdu 1-element arrays with flex-arrays

Kieran Bingham (1):
      media: i2c: imx335: Fix hblank min/max values

Kim Phillips (1):
      crypto: ccp - Fix null pointer dereference in __sev_platform_shutdown_locked

Konrad Dybcio (2):
      pmdomain: core: Move the unused cleanup to a _sync initcall
      drm/msm/dsi: Enable runtime PM

Konstantin Komarov (1):
      fs/ntfs3: Add null pointer checks

Krishna chaitanya chundru (1):
      bus: mhi: host: Add alignment check for event ring read pointer

Krzysztof Kozlowski (1):
      ASoC: codecs: wcd938x: handle deferred probe

Kuan-Wei Chiu (3):
      clk: hi3620: Fix memory leak in hi3620_mmc_clk_init()
      clk: mmp: pxa168: Fix memory leak in pxa168_clk_init()
      clk: imx: scu: Fix memory leak in __imx_clk_gpr_scu()

Kuniyuki Iwashima (3):
      llc: Drop support for ETH_P_TR_802_2.
      af_unix: Call kfree_skb() for dead unix_(sk)->oob_skb in GC.
      af_unix: Fix task hung while purging oob_skb in GC.

Kunwu Chan (1):
      powerpc/mm: Fix null-pointer dereference in pgtable_cache_add

Kuogee Hsieh (1):
      drm/msm/dp: return correct Colorimetry for DP_TEST_DYNAMIC_RANGE_CEA case

Lee Duncan (1):
      scsi: Revert "scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock"

Leonard Dallmayr (1):
      USB: serial: cp210x: add ID for IMST iM871A-USB

Li Lingfeng (1):
      block: Move checking GENHD_FL_NO_PART to bdev_add_partition()

Li zeming (1):
      PM: core: Remove unnecessary (void *) conversions

Lin Ma (3):
      vlan: skip nested type that is not IFLA_VLAN_QOS_MAPPING
      ksmbd: fix global oob in ksmbd_nl_policy
      bridge: cfm: fix enum typo in br_cc_ccm_tx_parse

Lino Sanfilippo (1):
      serial: 8250_exar: Set missing rs485_supported flag

Linus Lüssing (1):
      bridge: mcast: fix disabled snooping after long uptime

Linus Torvalds (1):
      sched/membarrier: reduce the ability to hammer on sys_membarrier

Loic Prylli (1):
      hwmon: (aspeed-pwm-tacho) mutex for tach reading

Luka Guzenko (1):
      ALSA: hda/realtek: Enable Mute LED on HP Laptop 14-fq0xxx

Lukas Schauer (1):
      pipe: wakeup wr_wait after setting max_usage

Manas Ghandat (2):
      jfs: fix slab-out-of-bounds Read in dtSearch
      jfs: fix array-index-out-of-bounds in dbAdjTree

Manivannan Sadhasivam (1):
      bus: mhi: host: Rename "struct mhi_tre" to "struct mhi_ring_element"

Mao Jinlong (2):
      arm64: dts: qcom: msm8996: Fix 'in-ports' is a required property
      arm64: dts: qcom: msm8998: Fix 'out-ports' is a required property

Marc Zyngier (1):
      irqchip/gic-v3-its: Fix GICv4.1 VPE affinity update

Marcelo Schmitt (3):
      iio: adc: ad7091r: Set alert bit in config register
      iio: adc: ad7091r: Allow users to configure device events
      iio: adc: ad7091r: Enable internal vref if external vref is not supplied

Mario Limonciello (4):
      rtc: Adjust failure return code for cmos_set_alarm()
      gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-04
      Revert "drm/amd: flush any delayed gfxoff on suspend entry"
      iio: accel: bma400: Fix a compilation problem

Mark Rutland (1):
      drivers/perf: pmuv3: don't expose SW_INCR event in sysfs

Markus Niebel (1):
      drm: panel-simple: add missing bus flags for Tianma tm070jvhg[30/33]

Masami Hiramatsu (Google) (1):
      tracing/trigger: Fix to return error if failed to alloc snapshot

Max Kellermann (2):
      fs/pipe: move check to pipe_has_watch_queue()
      fs/kernfs/dir: obey S_ISGID

Mayank Rana (1):
      usb: dwc3: Fix ep0 handling when getting reset while doing control transfer

Meenakshikumar Somasundaram (1):
      drm/amd/display: Fix tiled display misalignment

Michael Chan (1):
      bnxt_en: Wait for FLR to complete during probe

Michael Ellerman (3):
      powerpc: Fix build error due to is_valid_bugaddr()
      powerpc/mm: Fix build failures due to arch_reserved_kernel_pages()
      powerpc/64s: Fix CONFIG_NUMA=n build due to create_section_mapping()

Michael Kelley (2):
      hv_netvsc: Calculate correct ring size when PAGE_SIZE is not 4 Kbytes
      scsi: storvsc: Fix ring buffer size calculation

Michael Tretter (1):
      media: rockchip: rga: fix swizzling for RGB formats

Miguel Ojeda (1):
      scripts: decode_stacktrace: demangle Rust symbols

Mikulas Patocka (1):
      dm: limit the number of targets and parameter size area

Ming Lei (3):
      blk-mq: fix IO hang from sbitmap wakeup race
      scsi: core: Move scsi_host_busy() out of host lock for waking up EH handler
      scsi: core: Move scsi_host_busy() out of host lock if it is for per-command

Mingyi Zhang (1):
      libbpf: Fix NULL pointer dereference in bpf_object__collect_prog_relos

Minsuk Kang (1):
      wifi: ath9k: Fix potential array-index-out-of-bounds read in ath9k_htc_txstatus()

Mukesh Ojha (1):
      PM / devfreq: Synchronize devfreq_monitor_[start/stop]

Nam Cao (1):
      fbdev: flush deferred IO before closing

Namjae Jeon (9):
      ksmbd: don't allow O_TRUNC open on read-only share
      ksmbd: validate mech token in session setup
      ksmbd: fix UAF issue in ksmbd_tcp_new_connection()
      ksmbd: only v2 leases handle the directory
      ksmbd: set v2 lease version on lease upgrade
      ksmbd: fix potential circular locking issue in smb2_set_ea()
      ksmbd: don't increment epoch if current state and request state are same
      ksmbd: send lease break notification on FILE_RENAME_INFORMATION
      ksmbd: Add missing set_freezable() for freezable kthread

Nathan Chancellor (2):
      um: net: Fix return type of uml_net_start_xmit()
      kbuild: Fix changing ELF file type for output of gen_btf for big endian

Naveen N Rao (2):
      powerpc/lib: Validate size for vector operations
      powerpc/64: Set task pt_regs->link to the LR value on scv entry

Nikita Zhandarovich (1):
      net: hsr: remove WARN_ONCE() in send_hsr_supervision_frame()

Nuno Sa (1):
      of: property: fix typo in io-channels

Oleg Nesterov (3):
      afs: fix the usage of read_seqbegin_or_lock() in afs_lookup_volume_rcu()
      afs: fix the usage of read_seqbegin_or_lock() in afs_find_server*()
      rxrpc_find_service_conn_rcu: fix the usage of read_seqbegin_or_lock()

Oleksandr Tyshchenko (1):
      xen/gntdev: Fix the abuse of underlying struct page in DMA-buf import

Oleksij Rempel (1):
      can: j1939: Fix UAF in j1939_sk_match_filter during setsockopt(SO_J1939_FILTER)

Oliver Neukum (1):
      USB: hub: check for alternate port before enabling A_ALT_HNP_SUPPORT

Omar Sandoval (2):
      btrfs: avoid copying BTRFS_ROOT_SUBVOL_DEAD flag to snapshot of subvolume being deleted
      btrfs: don't abort filesystem when attempting to snapshot deleted subvolume

Ondrej Mosnacek (1):
      lsm: fix the logic in security_inode_getsecctx()

Osama Muhammad (2):
      FS:JFS:UBSAN:array-index-out-of-bounds in dbAdjTree
      UBSAN: array-index-out-of-bounds in dtSplitRoot

Pablo Neira Ayuso (9):
      netfilter: nf_tables: validate NFPROTO_* family
      netfilter: nft_chain_filter: handle NETDEV_UNREGISTER for inet/ingress basechain
      netfilter: nf_tables: restrict tunnel object to NFPROTO_NETDEV
      netfilter: nf_log: replace BUG_ON by WARN_ON_ONCE when putting logger
      netfilter: nft_ct: sanitize layer 3 and 4 protocol number in custom expectations
      netfilter: nft_compat: reject unused compat flag
      netfilter: nft_compat: restrict match/target protocol to u16
      netfilter: nft_ct: reject direction for ct id
      netfilter: nft_set_rbtree: skip end interval element from gc

Paolo Abeni (5):
      selftests: net: give more time for GRO aggregation
      selftests: net: fix available tunnels detection
      selftests: net: cut more slack for gro fwd tests.
      selftests: net: avoid just another constant wait
      mptcp: fix data re-injection from stale subflow

Paul Cercueil (1):
      ARM: dts: samsung: exynos4210-i9100: Unconditionally enable LDO12

Peter Robinson (1):
      mfd: ti_am335x_tscadc: Fix TI SoC dependencies

Peter Suti (1):
      staging: fbtft: core: set smem_len before fb_deferred_io_init call

Peter Zijlstra (1):
      perf: Fix the nr_addr_filters fix

Petr Pavlu (1):
      tracing: Ensure visibility when inserting an element into tracing_map

Philip Yang (1):
      drm/prime: Support page array >= 4GB

Pierre-Louis Bossart (3):
      PCI: add INTEL_HDA_ARL to pci_ids.h
      ALSA: hda: Intel: add HDA_ARL PCI ID support
      ALSA: hda: intel-dspcfg: add filters for ARL-S and ARL

Piotr Skajewski (1):
      ixgbe: Remove non-inclusive language

Prakash Sangappa (1):
      mm: hugetlb pages should not be reserved by shmat() if SHM_NORESERVE

Prarit Bhargava (1):
      ACPI: extlog: fix NULL pointer dereference check

Prashanth K (2):
      usb: dwc3: host: Set XHCI_SG_TRB_CACHE_SIZE_QUIRK
      usb: host: xhci-plat: Add support for XHCI_SG_TRB_CACHE_SIZE_QUIRK

Prathu Baronia (1):
      vhost: use kzalloc() instead of kmalloc() followed by memset()

Praveen Kaligineedi (1):
      gve: Fix use-after-free vulnerability

Puliang Lu (1):
      USB: serial: option: add Fibocom FM101-GL variant

Qiang Yu (1):
      bus: mhi: host: Drop chan lock before queuing buffers

Qu Wenruo (2):
      btrfs: defrag: reject unknown flags of btrfs_ioctl_defrag_range_args
      btrfs: do not ASSERT() if the newly created subvolume already got read

Radek Krejci (1):
      modpost: trim leading spaces when processing source files list

Rafael J. Wysocki (5):
      async: Split async_schedule_node_domain()
      async: Introduce async_schedule_dev_nocall()
      PM: sleep: Fix possible deadlocks in core system-wide PM code
      cpufreq: intel_pstate: Drop redundant intel_pstate_get_hwp_cap() call
      cpufreq: intel_pstate: Refine computation of P-state for given frequency

Richard Palethorpe (1):
      x86/entry/ia32: Ensure s32 is sign extended to s64

Rishabh Dave (1):
      ceph: prevent use-after-free in encode_cap_msg()

Rob Clark (1):
      drm/msm/dpu: Ratelimit framedone timeout msgs

Rolf Eike Beer (1):
      mm: use __pfn_to_section() instead of open coding it

Rui Zhang (1):
      regulator: core: Only increment use_count when enable_count changes

Ryusuke Konishi (4):
      nilfs2: fix data corruption in dsync block recovery for small block sizes
      nilfs2: fix hang in nilfs_lookup_dirty_data_buffers()
      nilfs2: fix potential bug in end_buffer_async_write
      nilfs2: replace WARN_ONs for invalid DAT metadata block requests

Salvatore Dipietro (1):
      tcp: Add memory barrier to tcp_push()

Samasth Norway Ananda (1):
      Revert "selftests/bpf: Test tail call counting with bpf2bpf and data on stack"

Samuel Holland (1):
      scs: add CONFIG_MMU dependency for vfree_atomic()

Schspa Shi (1):
      scripts/decode_stacktrace.sh: support old bash version

Sean Young (1):
      media: rc: bpf attach/detach requires write permission

Serge Semin (1):
      mips: Fix max_mapnr being uninitialized on early stages

Shannon Nelson (1):
      ionic: pass opcode to devcmd_wait

Sharath Srinivasan (1):
      net/rds: Fix UBSAN: array-index-out-of-bounds in rds_cmsg_recv

Shenwei Wang (1):
      net: fec: fix the unhandled context fault from smmu

Shigeru Yoshida (1):
      tipc: Check the bearer type before calling tipc_udp_nl_bearer_add()

Shiji Yang (1):
      wifi: rt2x00: restart beacon queue when hardware reset

Shuai Xue (1):
      ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED on synchronous events

Shun Hao (1):
      net/mlx5: DR, Align mlx5dv_dr API vport action with FW behavior

Simon Horman (1):
      net: stmmac: xgmac: use #define for string constants

Sinthu Raja (2):
      net: ethernet: ti: cpsw: enable mac_managed_pm to fix mdio
      net: ethernet: ti: cpsw_new: enable mac_managed_pm to fix mdio

Sjoerd Simons (1):
      bus: moxtet: Add spi device table

Souradeep Chakrabarti (1):
      hv_netvsc: Fix race condition between netvsc_probe and netvsc_remove

Srinivas Pandruvada (1):
      iio: hid-sensor-als: Return 0 for HID_USAGE_SENSOR_TIME_TIMESTAMP

Srinivasan Shanmugam (5):
      drm/amdgpu: Drop 'fence' check in 'to_amdgpu_amdkfd_fence()'
      drm/amd/powerplay: Fix kzalloc parameter 'ATOM_Tonga_PPM_Table' in 'get_platform_power_management_table()'
      drm/amdgpu: Release 'adev->pm.fw' before return in 'amdgpu_device_need_post()'
      drm/amdkfd: Fix 'node' NULL check in 'svm_range_get_range_boundaries()'
      drm/amd/display: Implement bounds check for stream encoder creation in DCN301

Stephen Rothwell (2):
      powerpc: pmd_move_must_withdraw() is only needed for CONFIG_TRANSPARENT_HUGEPAGE
      drm: using mul_u32_u32() requires linux/math64.h

Steve Wahl (1):
      x86/mm/ident_map: Use gbpages only where full GB page should be mapped.

Steven Rostedt (Google) (2):
      tracing: Fix wasted memory in saved_cmdlines logic
      tracing: Inform kmemleak of saved_cmdlines allocation

Su Hui (3):
      wifi: rtlwifi: rtl8723{be,ae}: using calculate_bit_shift()
      media: ddbridge: fix an error code problem in ddb_probe
      scsi: isci: Fix an error code problem in isci_io_request_build()

Suman Ghosh (1):
      octeontx2-af: Fix max NPC MCAM entry check while validating ref_entry

Suraj Jitindar Singh (1):
      ext4: allow for the last group to be marked as trimmed

Takashi Iwai (3):
      ALSA: hda: Refer to correct stream index at loops
      fbdev: Fix invalid page access after closing deferred I/O devices
      fbdev: Fix incorrect page mapping clearance at fb_deferred_io_release()

Takashi Sakamoto (1):
      firewire: core: correct documentation of fw_csr_string() kernel API

Tatsunosuke Tobita (1):
      HID: wacom: generic: Avoid reporting a serial of '0' to userspace

Tejun Heo (1):
      blk-iocost: Fix an UBSAN shift-out-of-bounds warning

Thinh Nguyen (6):
      usb: dwc3: gadget: Wait for ep0 xfers to complete during dequeue
      usb: dwc3: ep0: Don't prepare beyond Setup stage
      usb: dwc3: gadget: Only End Transfer for ep0 data phase
      usb: dwc3: gadget: Delay issuing End Transfer
      usb: dwc3: gadget: Don't delay End Transfer on delayed_status
      usb: dwc3: gadget: Ignore End Transfer delay on teardown

Thomas Bourgoin (1):
      crypto: stm32/crc32 - fix parsing list of devices

Thomas Zimmermann (4):
      fbdev/defio: Early-out if page is already enlisted
      fbdev: Don't sort deferred-I/O pages by default
      fbdev: Track deferred-I/O pages in pageref struct
      fbdev: Rename pagelist to pagereflist for deferred I/O

Tianjia Zhang (1):
      crypto: lib/mpi - Fix unexpected pointer access in mpi_ec_init

Tim Chen (1):
      tick/sched: Preserve number of idle sleeps across CPU hotplug events

Tobias Waldekranz (1):
      net: dsa: mv88e6xxx: Fix mv88e6352_serdes_get_stats error path

Tomi Valkeinen (6):
      drm/tidss: Fix atomic_flush check
      drm/drm_file: fix use of uninitialized variable
      drm/framebuffer: Fix use of uninitialized variable
      drm/mipi-dsi: Fix detach call without attach
      media: rkisp1: Drop IRQF_SHARED
      media: Revert "media: rkisp1: Drop IRQF_SHARED"

Tony Lindgren (1):
      phy: ti: phy-omap-usb2: Fix NULL pointer dereference for SRP

Uttkarsh Aggarwal (1):
      usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspend

Uwe Kleine-König (1):
      spi: ppc4xx: Drop write-only variable

Vegard Nossum (1):
      scripts/get_abi: fix source path leak

Ville Syrjälä (1):
      drm: Don't unref the same fb many times by mistake due to deadlock handling

Vincent Donnefort (1):
      ring-buffer: Clean ring_buffer_poll_wait() error return

Vitaly Rodionov (1):
      ALSA: hda/cs8409: Suppress vmaster control for Dolphin models

Wang, Beyond (1):
      drm/amdgpu: fix ftrace event amdgpu_bo_move always move on same heap

Weichen Chen (1):
      pstore/ram: Fix crash when setting number of cpus to an odd number

Wen Gu (1):
      net/smc: fix illegal rmb_desc access in SMC-D connection dump

Wenhua Lin (1):
      gpio: eic-sprd: Clear interrupt after set the interrupt type

Werner Fischer (1):
      watchdog: it87_wdt: Keep WDTCTRL bit 3 unmodified for IT8784/IT8786

Werner Sembach (1):
      Input: i8042 - fix strange behavior of touchpad on Clevo NS70PU

Wesley Cheng (7):
      usb: dwc3: gadget: Force sending delayed status during soft disconnect
      usb: dwc3: gadget: Submit endxfer command if delayed during disconnect
      usb: dwc3: gadget: Stall and restart EP0 if host is unresponsive
      usb: dwc3: gadget: Refactor EP0 forced stall/restart into a separate API
      usb: dwc3: gadget: Handle EP0 request dequeuing properly
      usb: dwc3: gadget: Queue PM runtime idle on disconnect event
      usb: dwc3: gadget: Execute gadget stop after halting the controller

Xi Ruoyao (1):
      mips: Call lose_fpu(0) before initializing fcr31 in mips_set_personality_nan

Xiaolei Wang (1):
      rpmsg: virtio: Free driver_override when rpmsg_remove()

Xiaowu.ding (1):
      mailbox: arm_mhuv2: Fix a bug for mhuv2_sender_interrupt

Xiubo Li (1):
      ceph: fix deadlock or deadcode of misusing dget()

Yafang Shao (1):
      selftests/bpf: Fix issues in setup_classid_environment()

Ye Bin (1):
      ext4: fix inconsistent between segment fstrim and full fstrim

Yevgeny Kliteynik (3):
      net/mlx5: DR, Use the right GVMI number for drop action
      net/mlx5: DR, Replace local WIRE_PORT macro with the existing MLX5_VPORT_UPLINK
      net/mlx5: DR, Can't go to uplink vport on RX rule

Yonghong Song (1):
      selftests/bpf: Fix pyperf180 compilation failure with clang18

Yoshihiro Shimoda (1):
      phy: renesas: rcar-gen3-usb2: Fix returning wrong error code

Yuluo Qiu (1):
      ACPI: video: Add quirk for the Colorful X15 AT 23 Laptop

Zach O'Keefe (1):
      mm/writeback: fix possible divide-by-zero in wb_dirty_limits(), again

Zenm Chen (1):
      wifi: rtl8xxxu: Add additional USB IDs for RTL8192EU devices

Zhang Rui (2):
      hwmon: (coretemp) Fix out-of-bounds memory access
      hwmon: (coretemp) Fix bogus core_id to attr name mapping

Zheng Wang (1):
      media: mtk-jpeg: Fix use after free bug due to error path handling in mtk_jpeg_dec_device_run

Zhengchao Shao (5):
      tcp: make sure init the accept_queue's spinlocks once
      netlink: fix potential sleeping issue in mqueue_flush_file
      ipv6: init the accept_queue's spinlocks in inet6_create
      bonding: return -ENOMEM instead of BUG in alb_upper_dev_walk
      bonding: remove print in bond_verify_device_path

Zhihao Cheng (1):
      ubifs: ubifs_symlink: Fix memleak of inode->i_link in error path

Zhipeng Lu (6):
      net/mlx5e: fix a double-free in arfs_create_groups
      fjes: fix memleaks in fjes_hw_setup
      net: ipv4: fix a memleak in ip_setup_cork
      atm: idt77252: fix a memleak in open_card_ubr0
      octeontx2-pf: Fix a memleak otx2_sq_init
      media: ir_toy: fix a memleak in irtoy_tx

Zhiquan Li (1):
      x86/mce: Mark fatal MCE's page as poison to avoid panic in the kdump kernel

Zhu Yanjun (1):
      virtio_net: Fix "‘%d’ directive writing between 1 and 11 bytes into a region of size 10" warnings

Zijun Hu (1):
      Bluetooth: qca: Set both WIDEBAND_SPEECH and LE_STATES quirks for QCA2066

Ziqi Zhao (1):
      can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock

bo liu (2):
      ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140
      ALSA: hda/conexant: Add quirk for SWS JS201D

ching Huang (1):
      scsi: arcmsr: Support new PCI device IDs 1883 and 1886

yuan linyu (1):
      usb: f_mass_storage: forbid async queue when shutdown happen

zhili.liu (1):
      iio: magnetometer: rm3100: add boundary check for the value read from RM3100_REG_TMRC


