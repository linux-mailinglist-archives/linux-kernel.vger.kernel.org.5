Return-Path: <linux-kernel+bounces-53905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD5C84A7E1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C971C27D29
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C17131E30;
	Mon,  5 Feb 2024 20:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TIdKNOmI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10C3131E25;
	Mon,  5 Feb 2024 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707164492; cv=none; b=tYxbSByRIB+iwgNYwuVmD9/5TSIvw+Ax9wAdKUHQKM63f+lX3M1ZHDttOA7mI8QyNf2PKweQZKms3NxCSsugDGXZ8zF9KIBC8A8WVoscNYI0ZJP+qMeQDnTGGRkszcTbR1znp59TqBLGWOq6m1QOmah7NYH7xUZntMGqbT5vHPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707164492; c=relaxed/simple;
	bh=NGg0O3HC3trcKTsnSypqSQ4JiSRtD0jmt+RJFPfM2oc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qBKiehF/46p28cS4R1ZmHfOyxiaB1aKVQAc9iKsDB9Nj8OniPHYbBVA47y6jsgnMK6tiVzFPx5niPd7Nz+qibdMEDI2bXZzZo0zpM0sSKEMYVQNUWgG7wroKlDw3c53x+jCOfbDMLWh82Vn5kH36J2sPyUx+JgxFt2If+kC1Ur4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TIdKNOmI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03594C433F1;
	Mon,  5 Feb 2024 20:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707164491;
	bh=NGg0O3HC3trcKTsnSypqSQ4JiSRtD0jmt+RJFPfM2oc=;
	h=From:To:Cc:Subject:Date:From;
	b=TIdKNOmIIFiE41awJe+dobwJAxx2zbKidjfybQy18mqsRWGoWh0ksCfGgBVVw48mE
	 /jRE955nH1iA2qRxqGn4WeocMCGZR7yKGDhaivEuhzxhaDHNLxIaGzNTlxX67rR6PT
	 1xNlQs1vDlxn47zE1uWSWoTvaVdZ+sxcf60fKZF8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.77
Date: Mon,  5 Feb 2024 20:21:26 +0000
Message-ID: <2024020527-exemplary-unfreeze-7bd6@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.77 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-class-net-queues                    |   22 -
 Documentation/sound/soc/dapm.rst                                    |    2 
 Makefile                                                            |    2 
 arch/arm/boot/dts/imx1-ads.dts                                      |    2 
 arch/arm/boot/dts/imx1-apf9328.dts                                  |    2 
 arch/arm/boot/dts/imx1.dtsi                                         |    5 
 arch/arm/boot/dts/imx23-sansa.dts                                   |   12 
 arch/arm/boot/dts/imx23.dtsi                                        |    2 
 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi                        |    2 
 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts     |    2 
 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts     |    2 
 arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts      |    2 
 arch/arm/boot/dts/imx25-pdk.dts                                     |    2 
 arch/arm/boot/dts/imx25.dtsi                                        |    2 
 arch/arm/boot/dts/imx27-apf27dev.dts                                |    4 
 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi                        |    4 
 arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts              |    2 
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts                    |    2 
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts                      |    2 
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi                     |    2 
 arch/arm/boot/dts/imx27.dtsi                                        |    3 
 arch/arm/boot/dts/imx28.dtsi                                        |    2 
 arch/arm/boot/dts/imx7d.dtsi                                        |    3 
 arch/arm/boot/dts/imx7s.dtsi                                        |   10 
 arch/arm/boot/dts/rk3036.dtsi                                       |   14 
 arch/arm/include/asm/irq_work.h                                     |    2 
 arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts               |    4 
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi                           |    4 
 arch/arm64/boot/dts/qcom/msm8996.dtsi                               |   21 +
 arch/arm64/boot/dts/qcom/msm8998.dtsi                               |   32 +
 arch/arm64/include/asm/irq_work.h                                   |    2 
 arch/arm64/kernel/irq.c                                             |    7 
 arch/arm64/kernel/perf_event.c                                      |    6 
 arch/csky/include/asm/irq_work.h                                    |    2 
 arch/loongarch/kernel/smp.c                                         |    1 
 arch/loongarch/mm/tlb.c                                             |   16 
 arch/powerpc/include/asm/irq_work.h                                 |    1 
 arch/powerpc/include/asm/mmu.h                                      |    4 
 arch/powerpc/include/asm/mmzone.h                                   |    8 
 arch/powerpc/kernel/traps.c                                         |    2 
 arch/powerpc/lib/sstep.c                                            |   10 
 arch/powerpc/mm/book3s64/pgtable.c                                  |    2 
 arch/powerpc/mm/init-common.c                                       |    5 
 arch/powerpc/mm/mmu_decl.h                                          |    5 
 arch/riscv/include/asm/irq_work.h                                   |    2 
 arch/s390/include/asm/irq_work.h                                    |    2 
 arch/s390/kernel/ptrace.c                                           |    6 
 arch/s390/kvm/kvm-s390.c                                            |    5 
 arch/um/drivers/net_kern.c                                          |    2 
 arch/um/include/shared/kern_util.h                                  |    2 
 arch/um/kernel/process.c                                            |    2 
 arch/um/kernel/time.c                                               |   32 +
 arch/um/os-Linux/helper.c                                           |    6 
 arch/um/os-Linux/util.c                                             |   19 
 arch/x86/boot/compressed/ident_map_64.c                             |    5 
 arch/x86/boot/compressed/idt_64.c                                   |    1 
 arch/x86/boot/compressed/idt_handlers_64.S                          |    1 
 arch/x86/boot/compressed/misc.h                                     |    1 
 arch/x86/include/asm/irq_work.h                                     |    1 
 arch/x86/include/asm/kmsan.h                                        |   17 
 arch/x86/kernel/cpu/mce/core.c                                      |   16 
 block/bio.c                                                         |    2 
 block/blk-mq.c                                                      |   16 
 drivers/acpi/acpi_extlog.c                                          |    5 
 drivers/acpi/acpi_video.c                                           |    9 
 drivers/acpi/apei/ghes.c                                            |   29 +
 drivers/acpi/numa/srat.c                                            |    4 
 drivers/base/arch_numa.c                                            |    2 
 drivers/block/rnbd/rnbd-srv.c                                       |   19 
 drivers/bluetooth/hci_qca.c                                         |    1 
 drivers/clk/hisilicon/clk-hi3620.c                                  |    4 
 drivers/clk/imx/clk-imx8qxp.c                                       |   24 +
 drivers/clk/mmp/clk-of-pxa168.c                                     |    3 
 drivers/crypto/marvell/octeontx2/otx2_cptlf.c                       |    6 
 drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c                  |    3 
 drivers/crypto/stm32/stm32-crc32.c                                  |    2 
 drivers/devfreq/devfreq.c                                           |   24 +
 drivers/gpu/drm/amd/amdgpu/aldebaran.c                              |   26 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c                    |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c                          |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c                             |   21 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c                          |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h                          |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c                            |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                             |    5 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c                           |    6 
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c                              |    4 
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c                              |    5 
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c                               |    4 
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c                               |    4 
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c                               |    4 
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c                               |    8 
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c                                |   42 --
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c                           |   24 -
 drivers/gpu/drm/amd/display/dc/core/dc.c                            |    4 
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h                        |    2 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c      |    3 
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c |   33 +
 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h |    1 
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c           |    2 
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c      |    2 
 drivers/gpu/drm/bridge/analogix/anx7625.c                           |   51 +-
 drivers/gpu/drm/bridge/analogix/anx7625.h                           |    4 
 drivers/gpu/drm/drm_file.c                                          |    2 
 drivers/gpu/drm/drm_framebuffer.c                                   |    2 
 drivers/gpu/drm/drm_mipi_dsi.c                                      |   17 
 drivers/gpu/drm/exynos/exynos_drm_drv.c                             |   11 
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                         |    5 
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c                           |    3 
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h                             |    1 
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c                               |    4 
 drivers/gpu/drm/panel/panel-edp.c                                   |   48 ++
 drivers/hid/hidraw.c                                                |    7 
 drivers/hwmon/nct6775-core.c                                        |    7 
 drivers/i3c/master/i3c-master-cdns.c                                |    7 
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c                      |    7 
 drivers/leds/trigger/ledtrig-panic.c                                |    5 
 drivers/mailbox/arm_mhuv2.c                                         |    3 
 drivers/md/md.c                                                     |   54 ++
 drivers/media/i2c/imx335.c                                          |    4 
 drivers/media/pci/ddbridge/ddbridge-main.c                          |    2 
 drivers/media/platform/amphion/vpu.h                                |    3 
 drivers/media/platform/amphion/vpu_cmds.c                           |   28 -
 drivers/media/platform/amphion/vpu_v4l2.c                           |    1 
 drivers/media/platform/rockchip/rga/rga.c                           |   15 
 drivers/media/platform/rockchip/rkisp1/rkisp1-common.h              |   11 
 drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c                 |   14 
 drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c                 |   35 +
 drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c                 |   20 -
 drivers/media/usb/stk1160/stk1160-video.c                           |    5 
 drivers/mfd/Kconfig                                                 |    1 
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c                              |    1 
 drivers/net/bonding/bond_alb.c                                      |    3 
 drivers/net/dsa/mv88e6xxx/chip.h                                    |    4 
 drivers/net/dsa/mv88e6xxx/serdes.c                                  |   10 
 drivers/net/dsa/mv88e6xxx/serdes.h                                  |    8 
 drivers/net/dsa/qca/qca8k-8xxx.c                                    |   24 -
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.c                     |   28 -
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c                    |   61 ---
 drivers/net/ethernet/aquantia/atlantic/aq_ring.h                    |   22 -
 drivers/net/ethernet/aquantia/atlantic/aq_vec.c                     |   23 -
 drivers/net/ethernet/google/gve/gve_tx_dqo.c                        |    5 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c                  |   32 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h                  |    1 
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h                     |   18 
 drivers/net/ethernet/intel/ice/ice_lib.c                            |    7 
 drivers/net/ethernet/intel/ice/ice_virtchnl.c                       |   12 
 drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c                   |   16 
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c                      |   36 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c                      |   61 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c                     |  145 +++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c                    |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                       |   42 --
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c                        |   34 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h                        |    1 
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c                        |  105 ++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h                        |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c                      |    2 
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h                       |   43 --
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c                       |   44 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c                       |  149 +++----
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c                 |   13 
 drivers/net/ethernet/microchip/lan966x/lan966x_port.c               |    5 
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c                 |    4 
 drivers/net/ethernet/pensando/ionic/ionic_dev.c                     |    1 
 drivers/net/ethernet/pensando/ionic/ionic_dev.h                     |    1 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                     |    3 
 drivers/net/ethernet/pensando/ionic/ionic_main.c                    |   22 -
 drivers/net/phy/at803x.c                                            |    6 
 drivers/net/usb/ax88179_178a.c                                      |    2 
 drivers/net/virtio_net.c                                            |    9 
 drivers/net/wireless/ath/ath11k/pcic.c                              |    4 
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c                       |    5 
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c                      |    2 
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c                      |    3 
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c                      |   11 
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c               |   12 
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c                |    6 
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c                |    4 
 drivers/net/wireless/silabs/wfx/sta.c                               |   42 +-
 drivers/pci/pci.h                                                   |    2 
 drivers/pci/pcie/aer.c                                              |    9 
 drivers/pci/quirks.c                                                |   24 +
 drivers/pci/switch/switchtec.c                                      |   25 -
 drivers/pnp/pnpacpi/rsparser.c                                      |   12 
 drivers/regulator/core.c                                            |   56 +-
 drivers/regulator/ti-abb-regulator.c                                |   22 -
 drivers/s390/crypto/vfio_ap_ops.c                                   |   16 
 drivers/scsi/arcmsr/arcmsr.h                                        |    4 
 drivers/scsi/arcmsr/arcmsr_hba.c                                    |    6 
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c                              |   10 
 drivers/scsi/isci/request.c                                         |    2 
 drivers/scsi/libfc/fc_fcp.c                                         |   18 
 drivers/scsi/lpfc/lpfc.h                                            |    1 
 drivers/scsi/lpfc/lpfc_init.c                                       |    4 
 drivers/scsi/mpi3mr/mpi3mr_fw.c                                     |    3 
 drivers/scsi/mpi3mr/mpi3mr_os.c                                     |    5 
 drivers/scsi/scsi_error.c                                           |    8 
 drivers/scsi/scsi_lib.c                                             |    2 
 drivers/scsi/scsi_priv.h                                            |    2 
 drivers/soc/xilinx/xlnx_event_manager.c                             |    7 
 drivers/spmi/spmi-mtk-pmif.c                                        |    7 
 drivers/tty/tty_ioctl.c                                             |    4 
 drivers/usb/core/hub.c                                              |   33 +
 drivers/watchdog/it87_wdt.c                                         |   14 
 drivers/xen/gntdev-dmabuf.c                                         |   50 +-
 fs/9p/v9fs_vfs.h                                                    |    1 
 fs/9p/vfs_inode.c                                                   |    6 
 fs/9p/vfs_inode_dotl.c                                              |    1 
 fs/afs/callback.c                                                   |    3 
 fs/afs/server.c                                                     |    7 
 fs/ceph/caps.c                                                      |    9 
 fs/ceph/mds_client.c                                                |    2 
 fs/ceph/quota.c                                                     |   39 +
 fs/dcache.c                                                         |    7 
 fs/ecryptfs/inode.c                                                 |    8 
 fs/erofs/zdata.c                                                    |    2 
 fs/ext4/mballoc.c                                                   |   11 
 fs/ext4/resize.c                                                    |   37 +
 fs/f2fs/compress.c                                                  |    4 
 fs/f2fs/file.c                                                      |    2 
 fs/f2fs/recovery.c                                                  |   25 -
 fs/jfs/jfs_dmap.c                                                   |   57 +-
 fs/jfs/jfs_dtree.c                                                  |    7 
 fs/jfs/jfs_imap.c                                                   |    3 
 fs/jfs/jfs_mount.c                                                  |    6 
 fs/kernfs/dir.c                                                     |   12 
 fs/pstore/ram.c                                                     |    1 
 include/asm-generic/numa.h                                          |    2 
 include/asm-generic/unaligned.h                                     |   24 -
 include/drm/drm_color_mgmt.h                                        |    1 
 include/drm/drm_mipi_dsi.h                                          |    2 
 include/linux/irq_work.h                                            |    3 
 include/linux/mmzone.h                                              |    6 
 include/linux/pci_ids.h                                             |    1 
 include/net/af_unix.h                                               |   20 -
 include/net/ip.h                                                    |    2 
 include/net/netfilter/nf_tables.h                                   |    2 
 kernel/audit.c                                                      |   31 +
 kernel/bpf/helpers.c                                                |   13 
 kernel/bpf/syscall.c                                                |    6 
 kernel/events/core.c                                                |   38 +
 lib/debugobjects.c                                                  |  200 +++-------
 net/bluetooth/hci_sync.c                                            |   10 
 net/bluetooth/l2cap_core.c                                          |    3 
 net/bridge/br_cfm_netlink.c                                         |    2 
 net/bridge/br_multicast.c                                           |   20 -
 net/bridge/br_private.h                                             |    4 
 net/ipv4/ip_output.c                                                |   12 
 net/ipv4/ip_sockglue.c                                              |    6 
 net/ipv4/ipmr.c                                                     |    2 
 net/ipv4/raw.c                                                      |   10 
 net/ipv4/tcp.c                                                      |   12 
 net/ipv4/udp.c                                                      |    2 
 net/ipv6/addrconf_core.c                                            |   21 -
 net/ipv6/ip6_tunnel.c                                               |   21 -
 net/llc/af_llc.c                                                    |    2 
 net/netfilter/nf_conntrack_proto_tcp.c                              |   10 
 net/netfilter/nf_log.c                                              |    7 
 net/netfilter/nf_tables_api.c                                       |   14 
 net/netfilter/nft_ct.c                                              |   24 +
 net/netfilter/nft_tunnel.c                                          |    1 
 net/rxrpc/conn_service.c                                            |    3 
 net/smc/smc_clc.c                                                   |   14 
 net/sunrpc/xprtmultipath.c                                          |   17 
 net/unix/af_unix.c                                                  |   14 
 net/unix/diag.c                                                     |    2 
 net/wireless/scan.c                                                 |    4 
 sound/hda/hdac_stream.c                                             |    9 
 sound/pci/hda/hda_intel.c                                           |    2 
 sound/pci/hda/patch_conexant.c                                      |  115 +++++
 sound/soc/amd/acp-config.c                                          |   15 
 sound/soc/codecs/lpass-wsa-macro.c                                  |    7 
 sound/soc/codecs/wsa883x.c                                          |    6 
 tools/build/feature/test-libopencsd.c                               |    4 
 tools/lib/bpf/libbpf.c                                              |    2 
 tools/lib/subcmd/help.c                                             |   18 
 tools/testing/selftests/bpf/cgroup_helpers.c                        |   18 
 tools/testing/selftests/bpf/prog_tests/btf.c                        |    1 
 tools/testing/selftests/bpf/progs/pyperf180.c                       |   22 +
 tools/testing/selftests/drivers/net/bonding/lag_lib.sh              |   11 
 tools/testing/selftests/drivers/net/team/config                     |    4 
 tools/testing/selftests/net/config                                  |    1 
 tools/testing/selftests/net/pmtu.sh                                 |   16 
 tools/testing/selftests/net/setup_veth.sh                           |    2 
 tools/testing/selftests/sgx/test_encl.lds                           |    6 
 286 files changed, 2318 insertions(+), 1337 deletions(-)

Abhinav Kumar (1):
      drm/msm/dpu: fix writeback programming for YUV cases

Adrian Reber (1):
      tty: allow TIOCSLCKTRMIOS with CAP_CHECKPOINT_RESTORE

Ahmed Zaki (1):
      ice: fix ICE_AQ_VSI_Q_OPT_RSS_* register values

Al Viro (1):
      fast_dput(): handle underflows gracefully

Alex Lyakas (1):
      md: Whenassemble the array, consult the superblock of the freshest device

Alexander Stein (4):
      ARM: dts: imx7d: Fix coresight funnel ports
      ARM: dts: imx7s: Fix lcdif compatible
      ARM: dts: imx7s: Fix nand-controller #size-cells
      clk: imx: clk-imx8qxp: fix LVDS bypass, pixel and phy clocks

Alvin Lee (1):
      drm/amd/display: For prefetch mode > 0, extend prefetch if possible

Andrii Nakryiko (1):
      selftests/bpf: satisfy compiler by having explicit return in btf test

Andrii Staikov (1):
      i40e: Fix VF disable behavior to block all traffic

Andrzej Hajda (1):
      debugobjects: Stop accessing objects after releasing hash bucket lock

Anna Schumaker (1):
      SUNRPC: Fix a suspicious RCU usage warning

Anton Ivanov (1):
      um: Fix naming clash between UML and scheduler

Arnd Bergmann (1):
      arch: consolidate arch_irq_work_raise prototypes

Baochen Qiang (1):
      wifi: ath11k: fix race due to setting ATH11K_FLAG_EXT_IRQ_ENABLED too early

Baokun Li (3):
      ext4: unify the type of flexbg_size to unsigned int
      ext4: remove unnecessary check from alloc_flex_gd()
      ext4: avoid online resizing failures due to oversized flex bg

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

Chao Yu (2):
      f2fs: fix to check return value of f2fs_reserve_new_block()
      f2fs: fix to tag gcing flag on page during block migration

Chris Riches (1):
      audit: Send netlink ACK before setting connection in auditd_set

Christian Marangi (1):
      net: phy: at803x: fix passing the wrong reference for config_intr

Christoph Hellwig (1):
      block: prevent an integer overflow in bvec_try_merge_hw_page

Christophe JAILLET (1):
      ixgbe: Fix an error handling path in ixgbe_read_iosf_sb_reg_x550()

Cristian Ciocaltea (1):
      ASoC: doc: Fix undefined SND_SOC_DAPM_NOPM argument

Daniel Stodden (1):
      PCI: switchtec: Fix stdev_release() crash after surprise hot remove

Daniel Vacek (1):
      IB/ipoib: Fix mcast list locking

David Howells (1):
      9p: Fix initialisation of netfs_inode for 9p

Dmitry Antipov (2):
      PNP: ACPI: fix fortify warning
      wifi: wfx: fix possible NULL pointer dereference in wfx_set_mfp_ap()

Dmitry Torokhov (1):
      asm-generic: make sparse happy with odd-sized put_unaligned_*()

Douglas Anderson (1):
      drm/exynos: Call drm_atomic_helper_shutdown() at shutdown/unbind time

Edward Adam Davis (3):
      jfs: fix uaf in jfs_evict_inode
      jfs: fix array-index-out-of-bounds in diNewExt
      wifi: cfg80211: fix RCU dereference in __cfg80211_bss_update

Eric Dumazet (5):
      ip6_tunnel: make sure to pull inner header in __ip6_tnl_rcv()
      ipv4: raw: add drop reasons
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

Felix Kuehling (2):
      drm/amdgpu: Let KFD sync with VM fences
      drm/amdkfd: Fix lock dependency warning

Frédéric Danis (1):
      Bluetooth: L2CAP: Fix possible multiple reject send

Gabriel Krisman Bertazi (1):
      ecryptfs: Reject casefold directory inodes

Gao Xiang (1):
      erofs: fix ztailpacking for subpage compressed blocks

Ghanshyam Agrawal (1):
      media: stk1160: Fixed high volume of stk1160_dbg messages

Greg KH (1):
      perf/core: Fix narrow startup race when creating the perf nr_addr_filters sysfs file

Greg Kroah-Hartman (1):
      Linux 6.1.77

Guilherme G. Piccoli (1):
      PCI: Only override AMD USB controller if required

Hannes Reinecke (2):
      scsi: libfc: Don't schedule abort twice
      scsi: libfc: Fix up timeout error in fc_fcp_rec_error()

Hans de Goede (1):
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

Hou Tao (2):
      bpf: Check rcu_read_lock_trace_held() before calling bpf map helpers
      bpf: Set uattr->batch.count as zero before batched update or deletion

Hsin-Yi Wang (1):
      drm/panel-edp: Add override_edid_mode quirk for generic edp

Huacai Chen (1):
      LoongArch/smp: Call rcutree_report_cpu_starting() at tlb_init()

Huang Shijie (2):
      arm64: irq: set the correct node for VMAP stack
      arm64: irq: set the correct node for shadow call stack

Ian Rogers (1):
      libsubcmd: Fix memory leak in uniq()

Ido Schimmel (1):
      PCI: Add no PM reset quirk for NVIDIA Spectrum devices

Igor Russkikh (1):
      net: atlantic: eliminate double free in error handling logic

Ilpo Järvinen (1):
      PCI: Fix 64GT/s effective data rate calculation

Jack Wang (1):
      RDMA/IPoIB: Fix error code return in ipoib_mcast_join

Jaegeuk Kim (1):
      f2fs: fix write pointers on zoned device after roll forward

James Clark (1):
      perf cs-etm: Bump minimum OpenCSD version to ensure a bugfix is present

Jedrzej Jagielski (2):
      ixgbe: Refactor returning internal error codes
      ixgbe: Refactor overtemp event handling

Jesse Brandeburg (1):
      ice: fix pre-shifted bit usage

Jo Van Bulck (1):
      selftests/sgx: Fix linker script asserts

Johan Hovold (2):
      ASoC: codecs: lpass-wsa-macro: fix compander volume hack
      ASoC: codecs: wsa883x: fix PA volume control

Johan Jonker (1):
      ARM: dts: rockchip: fix rk3036 hdmi ports node

Johannes Berg (1):
      um: time-travel: fix time corruption

Jonathan Gray (1):
      Revert "drm/amd/display: Disable PSR-SU on Parade 0803 TCON again"

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: avoid two consecutive device resets

Josip Pavic (1):
      drm/amd/display: make flip_timestamp_in_us a 64-bit variable

Jun'ichi Nomura (1):
      x86/boot: Ignore NMIs during very early boot

Justin Tee (1):
      scsi: lpfc: Fix possible file string name overflow when updating firmware

Kees Cook (1):
      block/rnbd-srv: Check for unlikely string overflow

Kieran Bingham (1):
      media: i2c: imx335: Fix hblank min/max values

Konrad Dybcio (1):
      drm/msm/dsi: Enable runtime PM

Kuan-Wei Chiu (2):
      clk: hi3620: Fix memory leak in hi3620_mmc_clk_init()
      clk: mmp: pxa168: Fix memory leak in pxa168_clk_init()

Kunwu Chan (1):
      powerpc/mm: Fix null-pointer dereference in pgtable_cache_add

Lin Ma (1):
      bridge: cfm: fix enum typo in br_cc_ccm_tx_parse

Linus Lüssing (1):
      bridge: mcast: fix disabled snooping after long uptime

Manas Ghandat (2):
      jfs: fix slab-out-of-bounds Read in dtSearch
      jfs: fix array-index-out-of-bounds in dbAdjTree

Mao Jinlong (2):
      arm64: dts: qcom: msm8996: Fix 'in-ports' is a required property
      arm64: dts: qcom: msm8998: Fix 'out-ports' is a required property

Marco Elver (1):
      mm, kmsan: fix infinite recursion due to RCU critical section

Mark Rutland (1):
      drivers/perf: pmuv3: don't expose SW_INCR event in sysfs

Matthias May (1):
      selftests: net: add missing config for GENEVE

Max Kellermann (1):
      fs/kernfs/dir: obey S_ISGID

Meenakshikumar Somasundaram (1):
      drm/amd/display: Fix tiled display misalignment

Michael Ellerman (3):
      powerpc: Fix build error due to is_valid_bugaddr()
      powerpc/mm: Fix build failures due to arch_reserved_kernel_pages()
      powerpc/64s: Fix CONFIG_NUMA=n build due to create_section_mapping()

Michael Tretter (1):
      media: rockchip: rga: fix swizzling for RGB formats

Michal Vokáč (1):
      net: dsa: qca8k: fix illegal usage of GPIO

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

Nicolas Dichtel (1):
      ipmr: fix kernel panic when forwarding mcast packets

Oleg Nesterov (3):
      afs: fix the usage of read_seqbegin_or_lock() in afs_lookup_volume_rcu()
      afs: fix the usage of read_seqbegin_or_lock() in afs_find_server*()
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

Paolo Abeni (2):
      selftests: net: give more time for GRO aggregation
      selftests: net: fix available tunnels detection

Peter Robinson (1):
      mfd: ti_am335x_tscadc: Fix TI SoC dependencies

Peter Zijlstra (1):
      perf: Fix the nr_addr_filters fix

Philip Yang (1):
      drm/amdkfd: Fix lock dependency warning with srcu

Pierre-Louis Bossart (2):
      PCI: add INTEL_HDA_ARL to pci_ids.h
      ALSA: hda: Intel: add HDA_ARL PCI ID support

Prarit Bhargava (1):
      ACPI: extlog: fix NULL pointer dereference check

Praveen Kaligineedi (1):
      gve: Fix use-after-free vulnerability

Rob Clark (1):
      drm/msm/dpu: Ratelimit framedone timeout msgs

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

Srinivasan Shanmugam (8):
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

Stephen Rothwell (2):
      powerpc: pmd_move_must_withdraw() is only needed for CONFIG_TRANSPARENT_HUGEPAGE
      drm: using mul_u32_u32() requires linux/math64.h

Su Hui (4):
      wifi: rtlwifi: rtl8723{be,ae}: using calculate_bit_shift()
      media: ddbridge: fix an error code problem in ddb_probe
      scsi: isci: Fix an error code problem in isci_io_request_build()
      HID: hidraw: fix a problem of memory leak in hidraw_release()

Suman Ghosh (1):
      octeontx2-af: Fix max NPC MCAM entry check while validating ref_entry

Sumit Saxena (1):
      scsi: mpi3mr: Add PCI checks where SAS5116 diverges from SAS4116

Takashi Iwai (1):
      ALSA: hda: Refer to correct stream index at loops

Tanmay Shah (1):
      soc: xilinx: fix unhandled SGI warning message

Thomas Bourgoin (1):
      crypto: stm32/crc32 - fix parsing list of devices

Tobias Waldekranz (1):
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

Ye Bin (1):
      ext4: fix inconsistent between segment fstrim and full fstrim

Yihang Li (1):
      scsi: hisi_sas: Set .phy_attached before notifing phyup event HISI_PHYE_PHY_UP_PM

Yonghong Song (1):
      selftests/bpf: Fix pyperf180 compilation failure with clang18

Yu-Che Cheng (1):
      spmi: mediatek: Fix UAF on device remove

Yuluo Qiu (1):
      ACPI: video: Add quirk for the Colorful X15 AT 23 Laptop

Yuntao Wang (1):
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


