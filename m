Return-Path: <linux-kernel+bounces-143711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205CD8A3C81
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6647282AB5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B1C3F9FB;
	Sat, 13 Apr 2024 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WT2QooBj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D13C3EA97;
	Sat, 13 Apr 2024 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713007562; cv=none; b=JM1edfNtX4Ystph3Zg6HnN3RLf1QK6uJD0Xi0WjEBLmWPY5Akzi9MBMkt6IAR2d35LHcTfqQ8c5IPCe5e4JsK+ve1wVG7VvRSYqV9J+ohFwurR1GPIZXedk51HdrP0oFS8TGEclaCBe1hTr3lmdG5w/kFz9r02DbkybBXtYvLGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713007562; c=relaxed/simple;
	bh=Lw5MDJlquDqTeJeaCbkR+piuQ3g8qHwrItvKnJWWcnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n6Ms+tyBfcyGalhEYOpGai5sV5UX7VNiKEH61ifMi3+m3G5A/FuUR9W4MLLDacbVmMgxPS6wOFM7cxLFuvAw345o7RWYM14H4ivyIX9fiDgtBpp6sUX04qa0AhZJVVh7wxCGCkpM5D+CwPhDH7MNl0JHkb6G9jX+eELHqQQ7iJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WT2QooBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22872C4AF10;
	Sat, 13 Apr 2024 11:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713007561;
	bh=Lw5MDJlquDqTeJeaCbkR+piuQ3g8qHwrItvKnJWWcnw=;
	h=From:To:Cc:Subject:Date:From;
	b=WT2QooBjT5X90wvrPARaO9Ahw9sK1FCpgg7BN+y8upavPnHbiTONooV8H4WhEg7aJ
	 1V+BHdU0pMl03zJ8TU6Ceu87ZNUKz6dlwcjVfsJpKWbMOn2QVUb3OMUdGHx7e3hU6f
	 c4fDoEhxQ5Xk+GPsiL5JEg83b/oORtolS4jMkmNc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.215
Date: Sat, 13 Apr 2024 13:25:49 +0200
Message-ID: <2024041350-crestless-humility-04b2@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.215 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-devices-system-cpu              |    1 
 Documentation/admin-guide/hw-vuln/index.rst                     |    1 
 Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst    |  104 ++++
 Documentation/admin-guide/hw-vuln/spectre.rst                   |   18 
 Documentation/admin-guide/kernel-parameters.txt                 |   27 -
 Documentation/block/queue-sysfs.rst                             |    7 
 Documentation/x86/mds.rst                                       |   38 +
 Makefile                                                        |    2 
 arch/arm/boot/dts/mmp2-brownstone.dts                           |    2 
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi                    |    3 
 arch/arm64/boot/dts/rockchip/rk3328.dtsi                        |   11 
 arch/arm64/boot/dts/rockchip/rk3399.dtsi                        |   12 
 arch/hexagon/kernel/vmlinux.lds.S                               |    1 
 arch/parisc/include/asm/assembly.h                              |   18 
 arch/parisc/include/asm/checksum.h                              |   10 
 arch/powerpc/include/asm/reg_fsl_emb.h                          |   11 
 arch/powerpc/lib/Makefile                                       |    2 
 arch/riscv/include/asm/uaccess.h                                |    4 
 arch/s390/kernel/entry.S                                        |    1 
 arch/sparc/kernel/nmi.c                                         |    2 
 arch/sparc/vdso/vma.c                                           |    7 
 arch/x86/Kconfig                                                |   18 
 arch/x86/Makefile                                               |    8 
 arch/x86/entry/entry.S                                          |   23 
 arch/x86/entry/entry_32.S                                       |   59 --
 arch/x86/entry/entry_64.S                                       |   10 
 arch/x86/entry/entry_64_compat.S                                |    1 
 arch/x86/include/asm/asm-prototypes.h                           |    1 
 arch/x86/include/asm/asm.h                                      |    5 
 arch/x86/include/asm/cpufeature.h                               |    8 
 arch/x86/include/asm/cpufeatures.h                              |    5 
 arch/x86/include/asm/disabled-features.h                        |    3 
 arch/x86/include/asm/entry-common.h                             |    1 
 arch/x86/include/asm/irqflags.h                                 |    1 
 arch/x86/include/asm/msr-index.h                                |   10 
 arch/x86/include/asm/nospec-branch.h                            |   47 +
 arch/x86/include/asm/processor.h                                |   15 
 arch/x86/include/asm/ptrace.h                                   |    5 
 arch/x86/include/asm/required-features.h                        |    3 
 arch/x86/include/asm/segment.h                                  |   30 -
 arch/x86/include/asm/setup.h                                    |    1 
 arch/x86/include/asm/stackprotector.h                           |   79 ---
 arch/x86/include/asm/suspend_32.h                               |   12 
 arch/x86/kernel/Makefile                                        |    1 
 arch/x86/kernel/asm-offsets_32.c                                |    5 
 arch/x86/kernel/cpu/amd.c                                       |   10 
 arch/x86/kernel/cpu/bugs.c                                      |  245 ++++++----
 arch/x86/kernel/cpu/common.c                                    |   64 ++
 arch/x86/kernel/cpu/mce/core.c                                  |    4 
 arch/x86/kernel/doublefault_32.c                                |    4 
 arch/x86/kernel/head64.c                                        |    9 
 arch/x86/kernel/head_32.S                                       |   18 
 arch/x86/kernel/head_64.S                                       |   24 
 arch/x86/kernel/nmi.c                                           |    3 
 arch/x86/kernel/setup_percpu.c                                  |    1 
 arch/x86/kernel/tls.c                                           |    8 
 arch/x86/kvm/cpuid.h                                            |    2 
 arch/x86/kvm/svm/sev.c                                          |   16 
 arch/x86/kvm/vmx/run_flags.h                                    |    7 
 arch/x86/kvm/vmx/vmenter.S                                      |    9 
 arch/x86/kvm/vmx/vmx.c                                          |   12 
 arch/x86/kvm/x86.c                                              |    5 
 arch/x86/lib/insn-eval.c                                        |    4 
 arch/x86/lib/retpoline.S                                        |    6 
 arch/x86/mm/ident_map.c                                         |   23 
 arch/x86/mm/pat/memtype.c                                       |   50 +-
 arch/x86/platform/pvh/head.S                                    |   14 
 arch/x86/power/cpu.c                                            |    6 
 arch/x86/xen/enlighten_pv.c                                     |    1 
 block/blk-settings.c                                            |   41 +
 block/blk-stat.c                                                |    2 
 block/blk-sysfs.c                                               |    8 
 block/ioctl.c                                                   |   11 
 drivers/accessibility/speakup/synth.c                           |    4 
 drivers/acpi/acpica/dbnames.c                                   |    8 
 drivers/acpi/sleep.c                                            |   12 
 drivers/ata/ahci.c                                              |    5 
 drivers/ata/sata_mv.c                                           |   63 +-
 drivers/ata/sata_sx4.c                                          |    6 
 drivers/base/core.c                                             |   26 -
 drivers/base/cpu.c                                              |    8 
 drivers/base/power/wakeirq.c                                    |    4 
 drivers/bluetooth/btintel.c                                     |    2 
 drivers/clk/qcom/gcc-ipq6018.c                                  |    2 
 drivers/clk/qcom/gcc-ipq8074.c                                  |    2 
 drivers/clk/qcom/gcc-sdm845.c                                   |    1 
 drivers/clk/qcom/mmcc-apq8084.c                                 |    2 
 drivers/clk/qcom/mmcc-msm8974.c                                 |    2 
 drivers/cpufreq/brcmstb-avs-cpufreq.c                           |    5 
 drivers/cpufreq/cpufreq-dt.c                                    |    2 
 drivers/crypto/qat/qat_common/adf_aer.c                         |   23 
 drivers/firmware/efi/vars.c                                     |   17 
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                        |    4 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c              |   12 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c             |    3 
 drivers/gpu/drm/amd/display/modules/inc/mod_stats.h             |    4 
 drivers/gpu/drm/drm_panel.c                                     |   17 
 drivers/gpu/drm/etnaviv/etnaviv_drv.c                           |    2 
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c                          |    9 
 drivers/gpu/drm/exynos/exynos_drm_vidi.c                        |    4 
 drivers/gpu/drm/exynos/exynos_hdmi.c                            |    4 
 drivers/gpu/drm/i915/gt/intel_engine_pm.c                       |    3 
 drivers/gpu/drm/i915/gt/intel_lrc.c                             |    3 
 drivers/gpu/drm/imx/parallel-display.c                          |    4 
 drivers/gpu/drm/ttm/ttm_memory.c                                |    2 
 drivers/gpu/drm/vc4/vc4_hdmi.c                                  |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c                         |   20 
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c                            |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                              |   92 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c                          |    8 
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c                      |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c                         |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                             |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                             |   11 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                         |   12 
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c                              |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_mob.c                             |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c                             |    6 
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c                        |   12 
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c                            |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c                          |    4 
 drivers/gpu/drm/vmwgfx/vmwgfx_so.c                              |    3 
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c                      |   50 --
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c                      |    6 
 drivers/hwmon/amc6821.c                                         |   11 
 drivers/infiniband/core/cm.c                                    |   20 
 drivers/input/rmi4/rmi_driver.c                                 |    6 
 drivers/md/dm-integrity.c                                       |    2 
 drivers/md/dm-raid.c                                            |    2 
 drivers/md/dm-snap.c                                            |    4 
 drivers/md/raid5.c                                              |   12 
 drivers/media/pci/sta2x11/sta2x11_vip.c                         |    9 
 drivers/media/tuners/xc4000.c                                   |    4 
 drivers/misc/mei/hw-me-regs.h                                   |    2 
 drivers/misc/mei/pci-me.c                                       |    2 
 drivers/misc/vmw_vmci/vmci_datagram.c                           |    6 
 drivers/mmc/core/block.c                                        |   14 
 drivers/mmc/host/tmio_mmc_core.c                                |    2 
 drivers/mtd/nand/raw/meson_nand.c                               |    2 
 drivers/mtd/ubi/fastmap.c                                       |    7 
 drivers/mtd/ubi/vtbl.c                                          |    6 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h        |    8 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h      |    8 
 drivers/net/ethernet/intel/i40e/i40e_main.c                     |    7 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c              |   34 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c                  |   16 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c                 |    5 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c            |    2 
 drivers/net/ethernet/neterion/vxge/vxge-config.c                |    2 
 drivers/net/ethernet/pensando/ionic/ionic_lif.c                 |    5 
 drivers/net/ethernet/realtek/r8169_main.c                       |    9 
 drivers/net/ethernet/renesas/ravb_main.c                        |    7 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c               |   40 +
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c             |   38 +
 drivers/net/ethernet/xilinx/ll_temac_main.c                     |    2 
 drivers/net/wireguard/netlink.c                                 |   10 
 drivers/net/wireless/ath/ath9k/antenna.c                        |    2 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c     |    4 
 drivers/nvme/host/pci.c                                         |    3 
 drivers/nvmem/meson-efuse.c                                     |   25 -
 drivers/of/dynamic.c                                            |   12 
 drivers/pci/controller/dwc/pcie-designware-ep.c                 |    7 
 drivers/pci/pci-driver.c                                        |   23 
 drivers/pci/pci.c                                               |    6 
 drivers/pci/pci.h                                               |   17 
 drivers/pci/pcie/Makefile                                       |    2 
 drivers/pci/pcie/dpc.c                                          |   15 
 drivers/pci/pcie/err.c                                          |   33 +
 drivers/pci/pcie/rcec.c                                         |   59 ++
 drivers/pci/probe.c                                             |    7 
 drivers/pci/quirks.c                                            |  100 ++++
 drivers/pci/setup-res.c                                         |    8 
 drivers/phy/tegra/xusb.c                                        |   13 
 drivers/pinctrl/renesas/core.c                                  |    4 
 drivers/platform/x86/touchscreen_dmi.c                          |    9 
 drivers/s390/crypto/zcrypt_api.c                                |    2 
 drivers/scsi/hosts.c                                            |    7 
 drivers/scsi/lpfc/lpfc_nportdisc.c                              |    6 
 drivers/scsi/lpfc/lpfc_nvmet.c                                  |    2 
 drivers/scsi/myrb.c                                             |   20 
 drivers/scsi/myrs.c                                             |   24 
 drivers/scsi/qla2xxx/qla_attr.c                                 |   14 
 drivers/scsi/qla2xxx/qla_def.h                                  |    2 
 drivers/scsi/qla2xxx/qla_gs.c                                   |    2 
 drivers/scsi/qla2xxx/qla_init.c                                 |  102 +---
 drivers/scsi/qla2xxx/qla_target.c                               |   10 
 drivers/scsi/sd.c                                               |    7 
 drivers/slimbus/core.c                                          |    4 
 drivers/soc/fsl/qbman/qman.c                                    |   98 +++-
 drivers/staging/comedi/drivers/comedi_test.c                    |   30 +
 drivers/staging/media/ipu3/ipu3-v4l2.c                          |   16 
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c           |    5 
 drivers/tee/optee/device.c                                      |    3 
 drivers/tty/n_gsm.c                                             |    3 
 drivers/tty/serial/8250/8250_port.c                             |    6 
 drivers/tty/serial/fsl_lpuart.c                                 |    7 
 drivers/tty/serial/max310x.c                                    |    7 
 drivers/tty/serial/sc16is7xx.c                                  |   15 
 drivers/tty/serial/serial_core.c                                |   12 
 drivers/tty/vt/vt.c                                             |    2 
 drivers/usb/class/cdc-wdm.c                                     |    6 
 drivers/usb/core/hub.c                                          |   23 
 drivers/usb/core/hub.h                                          |    2 
 drivers/usb/core/port.c                                         |    5 
 drivers/usb/core/sysfs.c                                        |   16 
 drivers/usb/dwc2/core.h                                         |   14 
 drivers/usb/dwc2/core_intr.c                                    |   63 +-
 drivers/usb/dwc2/gadget.c                                       |    4 
 drivers/usb/dwc2/hcd.c                                          |   47 +
 drivers/usb/dwc2/hcd_ddma.c                                     |   17 
 drivers/usb/dwc2/hw.h                                           |    2 
 drivers/usb/gadget/function/f_ncm.c                             |    2 
 drivers/usb/gadget/udc/core.c                                   |    4 
 drivers/usb/gadget/udc/tegra-xudc.c                             |   53 +-
 drivers/usb/host/sl811-hcd.c                                    |    2 
 drivers/usb/phy/phy-generic.c                                   |    7 
 drivers/usb/serial/cp210x.c                                     |    4 
 drivers/usb/serial/ftdi_sio.c                                   |    2 
 drivers/usb/serial/ftdi_sio_ids.h                               |    6 
 drivers/usb/serial/option.c                                     |    6 
 drivers/usb/storage/isd200.c                                    |   23 
 drivers/usb/typec/tcpm/tcpci.c                                  |    1 
 drivers/usb/typec/ucsi/ucsi.c                                   |   42 +
 drivers/usb/typec/ucsi/ucsi.h                                   |    4 
 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c                          |    7 
 drivers/vfio/pci/vfio_pci_intrs.c                               |  176 ++++---
 drivers/vfio/platform/vfio_platform_irq.c                       |  106 ++--
 drivers/vfio/virqfd.c                                           |   21 
 drivers/video/fbdev/core/fbmon.c                                |    7 
 drivers/video/fbdev/via/accel.c                                 |    4 
 drivers/virtio/virtio.c                                         |   10 
 drivers/xen/events/events_base.c                                |    5 
 fs/aio.c                                                        |    8 
 fs/btrfs/export.c                                               |    9 
 fs/btrfs/ioctl.c                                                |   25 -
 fs/btrfs/send.c                                                 |   10 
 fs/btrfs/volumes.c                                              |   14 
 fs/exec.c                                                       |    1 
 fs/ext4/mballoc.c                                               |   22 
 fs/ext4/resize.c                                                |    3 
 fs/ext4/super.c                                                 |   12 
 fs/fat/nfs.c                                                    |    6 
 fs/fuse/dir.c                                                   |    4 
 fs/fuse/fuse_i.h                                                |    1 
 fs/fuse/inode.c                                                 |    7 
 fs/isofs/inode.c                                                |   18 
 fs/nfs/direct.c                                                 |   11 
 fs/nfs/write.c                                                  |    2 
 fs/nilfs2/btree.c                                               |    9 
 fs/nilfs2/direct.c                                              |    9 
 fs/nilfs2/inode.c                                               |    2 
 fs/pstore/zone.c                                                |    2 
 fs/sysv/itree.c                                                 |   10 
 fs/ubifs/file.c                                                 |   13 
 fs/vboxsf/super.c                                               |    3 
 include/linux/blkdev.h                                          |   15 
 include/linux/cpu.h                                             |    2 
 include/linux/device.h                                          |    1 
 include/linux/gfp.h                                             |    9 
 include/linux/hyperv.h                                          |   22 
 include/linux/nfs_fs.h                                          |    1 
 include/linux/objtool.h                                         |    8 
 include/linux/pci.h                                             |    6 
 include/linux/phy/tegra/xusb.h                                  |    2 
 include/linux/sunrpc/sched.h                                    |    2 
 include/linux/timer.h                                           |   18 
 include/linux/udp.h                                             |   28 +
 include/linux/vfio.h                                            |    2 
 include/net/cfg802154.h                                         |    1 
 include/net/inet_connection_sock.h                              |    1 
 include/net/sock.h                                              |    7 
 include/soc/fsl/qman.h                                          |    9 
 include/uapi/linux/input-event-codes.h                          |    1 
 init/initramfs.c                                                |    2 
 io_uring/io_uring.c                                             |    2 
 kernel/bounds.c                                                 |    2 
 kernel/bpf/verifier.c                                           |    5 
 kernel/events/core.c                                            |    9 
 kernel/panic.c                                                  |    8 
 kernel/power/suspend.c                                          |    1 
 kernel/printk/printk.c                                          |   63 +-
 kernel/time/timer.c                                             |  164 +++---
 kernel/trace/ring_buffer.c                                      |  193 ++++---
 mm/compaction.c                                                 |    7 
 mm/memory-failure.c                                             |    2 
 mm/memory.c                                                     |    4 
 mm/memtest.c                                                    |    4 
 mm/migrate.c                                                    |    6 
 mm/page_alloc.c                                                 |   10 
 mm/swapfile.c                                                   |   13 
 mm/vmscan.c                                                     |    5 
 net/bluetooth/hci_debugfs.c                                     |   48 +
 net/bluetooth/hci_event.c                                       |   25 +
 net/bridge/netfilter/ebtables.c                                 |    6 
 net/core/sock_map.c                                             |    6 
 net/ipv4/inet_connection_sock.c                                 |   14 
 net/ipv4/ip_gre.c                                               |    5 
 net/ipv4/netfilter/arp_tables.c                                 |    4 
 net/ipv4/netfilter/ip_tables.c                                  |    4 
 net/ipv4/tcp.c                                                  |    2 
 net/ipv4/udp.c                                                  |    7 
 net/ipv4/udp_offload.c                                          |   13 
 net/ipv6/ip6_fib.c                                              |   14 
 net/ipv6/ip6_gre.c                                              |    3 
 net/ipv6/netfilter/ip6_tables.c                                 |    4 
 net/ipv6/udp.c                                                  |    2 
 net/ipv6/udp_offload.c                                          |    8 
 net/mac80211/cfg.c                                              |    5 
 net/mac802154/llsec.c                                           |   18 
 net/mptcp/protocol.c                                            |    3 
 net/mptcp/subflow.c                                             |    3 
 net/netfilter/nf_tables_api.c                                   |   74 ++-
 net/nfc/nci/core.c                                              |    5 
 net/rds/rdma.c                                                  |    2 
 net/sched/act_skbmod.c                                          |   10 
 net/smc/smc_pnet.c                                              |   10 
 net/xfrm/xfrm_user.c                                            |    3 
 scripts/Makefile.extrawarn                                      |    2 
 scripts/dummy-tools/gcc                                         |    6 
 scripts/gcc-x86_32-has-stack-protector.sh                       |    6 
 scripts/kernel-doc                                              |    2 
 security/smack/smack_lsm.c                                      |   12 
 sound/pci/hda/patch_realtek.c                                   |    9 
 sound/sh/aica.c                                                 |   17 
 sound/soc/soc-ops.c                                             |    2 
 tools/iio/iio_utils.c                                           |    2 
 tools/include/linux/objtool.h                                   |    8 
 tools/lib/perf/evlist.c                                         |   18 
 tools/lib/perf/include/internal/evlist.h                        |    4 
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c |    1 
 tools/testing/ktest/ktest.pl                                    |    1 
 tools/testing/selftests/mqueue/setting                          |    1 
 tools/testing/selftests/net/reuseaddr_conflict.c                |    2 
 virt/kvm/async_pf.c                                             |   31 +
 334 files changed, 3242 insertions(+), 1521 deletions(-)

Alan Stern (3):
      USB: usb-storage: Prevent divide-by-0 error in isd200_ata_command
      USB: core: Add hub_get() and hub_put() routines
      USB: core: Fix deadlock in usb_deauthorize_interface()

Alban Boyé (1):
      platform/x86: touchscreen_dmi: Add an extra entry for a variant of the Chuwi Vi8 tablet

Aleksandr Burakov (1):
      fbdev: viafb: fix typo in hw_bitblt_1 and hw_bitblt_2

Aleksandr Loktionov (2):
      i40e: fix i40e_count_filters() to count only active/new filters
      i40e: fix vf may be used uninitialized in this function warning

Alex Henrie (1):
      isofs: handle CDs with bad root inode but good Joliet root directory

Alex Williamson (7):
      vfio/platform: Disable virqfds on cleanup
      vfio/pci: Disable auto-enable of exclusive INTx IRQ
      vfio/pci: Lock external INTx masking ops
      vfio: Introduce interface to flush virqfd inject workqueue
      vfio/pci: Create persistent INTx handler
      vfio/platform: Create persistent IRQ handlers
      vfio/fsl-mc: Block calling interrupt handler without trigger

Alexander Stein (1):
      Revert "usb: phy: generic: Get the vbus supply"

Alexander Usyskin (2):
      mei: me: add arrow lake point S DID
      mei: me: add arrow lake point H DID

Amey Narkhede (1):
      PCI: Cache PCIe Device Capabilities register

Amit Pundir (1):
      clk: qcom: gcc-sdm845: Add soft dependency on rpmhpd

Andrei Matei (1):
      bpf: Protect against int overflow for stack access size

Andrey Jr. Melnikov (1):
      ahci: asm1064: correct count of reported ports

Andy Lutomirski (1):
      x86/stackprotector/32: Make the canary into a regular percpu variable

Antoine Tenart (2):
      udp: do not transition UDP GRO fraglist partial checksums to unnecessary
      udp: do not accept non-tunnel GSO skbs landing in a tunnel

Anton Altaparmakov (1):
      x86/pm: Work around false positive kmemleak report in msr_build_context()

Aric Cyr (1):
      drm/amd/display: Fix nanosec stat overflow

Arnd Bergmann (6):
      staging: vc04_services: changen strncpy() to strscpy_pad()
      dm integrity: fix out-of-range warning
      ata: sata_sx4: fix pdc20621_get_from_dimm() on 64-bit
      scsi: mylex: Fix sysfs buffer lengths
      ata: sata_mv: Fix PCI device ID table declaration compilation warning
      media: sta2x11: fix irq handler cast

Arseniy Krasnov (1):
      mtd: rawnand: meson: fix scrambling mode value in command macro

Aurélien Jacobs (1):
      USB: serial: option: add MeiG Smart SLM320 product

Baokun Li (1):
      ext4: correct best extent lstart adjustment logic

Bart Van Assche (1):
      fs/aio: Check IOCB_AIO_RW before the struct aio_kiocb conversion

Bastien Nocera (1):
      Bluetooth: Fix TOCTOU in HCI debugfs implementation

Bikash Hazarika (2):
      scsi: qla2xxx: Update manufacturer details
      scsi: qla2xxx: Update manufacturer detail

Bjorn Helgaas (1):
      PCI: Work around Intel I210 ROM BAR overlap defect

Borislav Petkov (1):
      x86/bugs: Use sysfs_emit()

Borislav Petkov (AMD) (5):
      x86/CPU/AMD: Update the Zenbleed microcode revisions
      x86/mce: Make sure to grab mce_sysfs_mutex in set_bank()
      x86/bugs: Fix the SRSO mitigation on Zen3/4
      x86/retpoline: Do the necessary fixup to the Zen3/4 srso return thunk for !SRSO
      x86/retpoline: Add NOENDBR annotation to the SRSO dummy return thunk

Cameron Williams (1):
      USB: serial: add device ID for VeriFone adapter

Chris Wilson (1):
      drm/i915/gt: Reset queue_priority_hint on parking

Christian A. Ehrhardt (2):
      usb: typec: ucsi: Ack unsupported commands
      usb: typec: ucsi: Clear UCSI_CCI_RESET_COMPLETE before reset

Christian Gmeiner (1):
      drm/etnaviv: Restore some id values

Christian Häggström (1):
      USB: serial: cp210x: add ID for MGP Instruments PDS100

Christian König (2):
      drm/vmwgfx: stop using ttm_bo_create v2
      drm/vmwgfx: switch over to the new pin interface v2

Christophe JAILLET (2):
      slimbus: core: Remove usage of the deprecated ida_simple_xx() API
      vboxsf: Avoid an spurious warning if load_nls_xxx() fails

Claus Hansen Ries (1):
      net: ll_temac: platform_get_resource replaced by wrong function

Colin Ian King (1):
      usb: sl811-hcd: only defined function checkdone if QUIRK2 is defined

Conrad Kostecki (1):
      ahci: asm1064: asm1166: don't limit reported ports

Dai Ngo (1):
      SUNRPC: increase size of rpc_wait_queue.qlen from unsigned short to unsigned int

Damian Muszynski (1):
      crypto: qat - resolve race condition during AER recovery

Damien Le Moal (2):
      block: introduce zone_write_granularity limit
      block: Clear zone limits for a non-zoned stacked queue

Dan Carpenter (1):
      staging: vc04_services: fix information leak in create_component()

Daniel Drake (1):
      Revert "ACPI: PM: Block ASUS B1400CEAE from suspend to idle by default"

Daniel Vogelbacher (1):
      USB: serial: ftdi_sio: add support for GMC Z216C Adapter IR-USB

Dave Airlie (1):
      amdkfd: use calloc instead of kzalloc to avoid integer overflow

David Hildenbrand (2):
      virtio: reenable config if freezing device failed
      x86/mm/pat: fix VM_PAT handling in COW mappings

David Sterba (3):
      btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()
      btrfs: export: handle invalid inode or root reference in btrfs_get_parent()
      btrfs: send: handle path ref underflow in header iterate_inode_ref()

Davide Caratti (1):
      mptcp: don't account accept() of non-MPC client as fallback to TCP

Dmitry Antipov (1):
      wifi: ath9k: fix LNA selection in ath_ant_try_scan()

Dominique Martinet (1):
      mmc: core: Fix switch on gp3 partition

Duje Mihanović (1):
      arm: dts: marvell: Fix maxium->maxim typo in brownstone dts

Duoming Zhou (1):
      ALSA: sh: aica: reorder cleanup operations to avoid UAF bugs

Edward Adam Davis (1):
      Bluetooth: btintel: Fix null ptr deref in btintel_read_version

Eric Dumazet (5):
      tcp: properly terminate timers for kernel sockets
      netfilter: validate user input for expected length
      net/sched: act_skbmod: prevent kernel-infoleak
      erspan: make sure erspan_base_hdr is present in skb->head
      net/smc: reduce rtnl pressure in smc_pnet_create_pnetids_list()

Fedor Pchelkin (1):
      mac802154: fix llsec key resources release in mac802154_llsec_key_del

Felix Fietkau (1):
      wifi: mac80211: check/clear fast rx for non-4addr sta VLAN changes

Filipe Manana (1):
      btrfs: fix off-by-one chunk length calculation at contains_pending_extent()

Gabor Juhos (4):
      clk: qcom: gcc-ipq6018: fix terminating of frequency table arrays
      clk: qcom: gcc-ipq8074: fix terminating of frequency table arrays
      clk: qcom: mmcc-apq8084: fix terminating of frequency table arrays
      clk: qcom: mmcc-msm8974: fix terminating of frequency table arrays

Geert Uytterhoeven (1):
      pinctrl: renesas: checker: Limit cfg reg enum checks to provided IDs

Gergo Koteles (1):
      Input: allocate keycode for Display refresh rate toggle

Goldwyn Rodrigues (1):
      btrfs: allocate btrfs_ioctl_defrag_range_args on stack

Greg Kroah-Hartman (2):
      cpufreq: brcmstb-avs-cpufreq: fix up "add check for cpufreq_cpu_get's return value"
      Linux 5.10.215

Guenter Roeck (4):
      parisc: Fix ip_fast_csum
      parisc: Fix csum_ipv6_magic on 32-bit systems
      parisc: Fix csum_ipv6_magic on 64-bit systems
      parisc: Strip upper 32 bit of sum in csum_ipv6_magic for 64-bit builds

Gui-Dong Han (1):
      media: xc4000: Fix atomicity violation in xc4000_get_frequency

Guilherme G. Piccoli (1):
      scsi: core: Fix unremoved procfs host directory regression

Harald Freudenberger (1):
      s390/zcrypt: fix reference counting on zcrypt card objects

Hariprasad Kelam (1):
      Octeontx2-af: fix pause frame configuration in GMP mode

Harshit Mogalapalli (1):
      VMCI: Fix memcpy() run-time warning in dg_dispatch_as_host()

Heiner Kallweit (1):
      r8169: fix issue caused by buggy BIOS on certain boards with RTL8168d

Herve Codina (2):
      driver core: Introduce device_link_wait_removal()
      of: dynamic: Synchronize of_changeset_destroy() with the devlink removals

Hidenori Kobayashi (1):
      media: staging: ipu3-imgu: Set fields before media_entity_pads_init()

Hugo Villeneuve (2):
      serial: max310x: fix NULL pointer dereference in I2C instantiation
      serial: sc16is7xx: convert from _raw_ to _noinc_ regmap functions for FIFO

Hui Wang (1):
      Bluetooth: hci_event: set the conn encrypted before conn establishes

I Gede Agastya Darma Laksana (1):
      ALSA: hda/realtek: Update Panasonic CF-SZ6 quirk to support headset with microphone

Ian Abbott (1):
      comedi: comedi_test: Prevent timers rescheduling during deletion

Ian Rogers (1):
      libperf evlist: Avoid out-of-bounds access

Ingo Molnar (1):
      Revert "x86/mm/ident_map: Use gbpages only where full GB page should be mapped."

Jakub Kicinski (1):
      selftests: reuseaddr_conflict: add missing new line at the end of the output

Jakub Sitnicki (1):
      bpf, sockmap: Prevent lock inversion deadlock in map delete elem

Jameson Thies (1):
      usb: typec: ucsi: Clean up UCSI_CABLE_PROP macros

Jan Kara (1):
      fat: fix uninitialized field in nostale filehandles

Jani Nikula (4):
      drm/panel: do not return negative error codes from drm_panel_get_modes()
      drm/exynos: do not return negative values from .get_modes()
      drm/imx/ipuv3: do not return negative values from .get_modes()
      drm/vc4: hdmi: do not return negative values from .get_modes()

Jason A. Donenfeld (2):
      wireguard: netlink: check for dangling peer via is_dead instead of empty list
      wireguard: netlink: access device through ctx instead of peer

Jens Axboe (1):
      io_uring: ensure '0' is returned on file registration success

Jerome Brunet (1):
      nvmem: meson-efuse: fix function pointer type mismatch

Jiawei Fu (iBug) (1):
      drivers/nvme: Add quirks for device 126f:2262

Johan Hovold (1):
      arm64: dts: qcom: sc7180-trogdor: mark bluetooth address as broken

Johan Jonker (2):
      arm64: dts: rockchip: fix rk3328 hdmi ports node
      arm64: dts: rockchip: fix rk3399 hdmi ports node

John David Anglin (1):
      parisc: Avoid clobbering the C/B bits in the PSW with tophys and tovirt macros

John Ogness (2):
      printk: Update @console_may_schedule in console_trylock_spinning()
      panic: Flush kernel log buffer at the end

John Sperbeck (1):
      init: open /initrd.image with O_LARGEFILE

Jon Hunter (1):
      usb: gadget: tegra-xudc: Use dev_err_probe()

Josef Bacik (1):
      nfs: fix UAF in direct writes

Josh Poimboeuf (1):
      objtool: Add asm version of STACK_FRAME_NON_STANDARD

Josua Mayer (1):
      hwmon: (amc6821) add of_match table

Justin Tee (1):
      scsi: lpfc: Fix possible memory leak in lpfc_rcv_padisc()

Kailang Yang (1):
      ALSA: hda/realtek - Fix headset Mic no show at resume back for Lenovo ALC897 platform

Kim Phillips (2):
      x86/cpu: Support AMD Automatic IBRS
      x86/cpu: Enable STIBP on AMD if Automatic IBRS is enabled

Krishna Kurapati (1):
      usb: gadget: ncm: Fix handling of zero block length packets

Kuniyuki Iwashima (1):
      ipv6: Fix infinite recursion in fib6_dump_done().

Kunwu Chan (2):
      pstore/zone: Add a null pointer check to the psz_kmsg_read
      Input: synaptics-rmi4 - fail probing if memory allocation for "phys" fails

Lee Jones (1):
      drm/vmwgfx/vmwgfx_cmdbuf_res: Remove unused variable 'ret'

Leo Ma (1):
      drm/amd/display: Fix noise issue on HDMI AV mute

Lin Yujun (1):
      Documentation/hw-vuln: Update spectre doc

Liu Shixin (1):
      mm/memory-failure: fix an incorrect use of tail pages

Luiz Augusto von Dentz (1):
      Bluetooth: btintel: Fixe build regression

Mahmoud Adam (1):
      net/rds: fix possible cp null dereference

Manjunath Patil (1):
      RDMA/cm: add timeout to cm_destroy_id wait

Marco Felsch (1):
      usb: typec: tcpci: add generic tcpci fallback compatible

Marek Szyprowski (1):
      cpufreq: dt: always allocate zeroed cpumask

Mathias Nyman (1):
      usb: port: Don't try to peer unused USB ports based on location

Matthew Wilcox (Oracle) (2):
      bounds: support non-power-of-two CONFIG_NR_CPUS
      ubifs: Set page uptodate in the correct place

Maulik Shah (1):
      PM: suspend: Set mem_sleep_current during kernel command line setup

Max Filippov (1):
      exec: Fix NOMMU linux_binprm::exec in transfer_args_to_stack()

Maximilian Heyne (2):
      ext4: fix corruption during on-line resize
      xen/events: close evtchn after mapping cleanup

Michael Ellerman (1):
      powerpc/fsl: Fix mfpmr build errors with newer binutils

Michael Kelley (1):
      Drivers: hv: vmbus: Calculate ring buffer size for more efficient use of memory

Michael Roth (1):
      x86/head/64: Re-enable stack protection

Michal Kubecek (1):
      kbuild: dummy-tools: adjust to stricter stackprotector check

Mika Westerberg (3):
      PCI/ASPM: Make Intel DG2 L1 acceptable latency unlimited
      PCI/DPC: Quirk PIO log size for certain Intel Root Ports
      PCI/DPC: Quirk PIO log size for Intel Ice Lake Root Ports

Mikko Rapeli (2):
      mmc: core: Initialize mmc_blk_ioc_data
      mmc: core: Avoid negative index with array access

Miklos Szeredi (2):
      fuse: fix root lookup with nonzero generation
      fuse: don't unhash root

Mikulas Patocka (1):
      dm snapshot: fix lockup in dm_exception_table_exit

Min Li (1):
      block: add check that partition length needs to be aligned with block size

Minas Harutyunyan (4):
      usb: dwc2: host: Fix remote wakeup from hibernation
      usb: dwc2: host: Fix hibernation flow
      usb: dwc2: host: Fix ISOC flow in DDMA mode
      usb: dwc2: gadget: LPM flow fix

Muhammad Usama Anjum (1):
      scsi: lpfc: Correct size for wqe for memset()

Nathan Chancellor (4):
      kbuild: Move -Wenum-{compare-conditional,enum-conversion} into W=1
      xfrm: Avoid clang fortify warning in copy_to_user_tmpl()
      powerpc: xor_vmx: Add '-mhard-float' to CFLAGS
      hexagon: vmlinux.lds.S: handle attributes section

Nicolas Pitre (1):
      vt: fix unicode buffer corruption when deleting characters

Nikita Kiryushin (1):
      ACPICA: debugger: check status of acpi_evaluate_object() in acpi_db_walk_for_fields()

Niklas Cassel (1):
      PCI: dwc: endpoint: Fix advertised resizable BAR size

Oliver Neukum (1):
      usb: cdc-wdm: close race between read and workqueue

Pablo Neira Ayuso (9):
      netfilter: nf_tables: mark set as dead when unbinding anonymous set with timeout
      netfilter: nf_tables: disallow anonymous set with timeout flag
      netfilter: nf_tables: reject constant set with timeout
      netfilter: nf_tables: disallow timeout for anonymous sets
      netfilter: nf_tables: reject new basechain after table flag update
      netfilter: nf_tables: flush pending destroy work before exit_net release
      netfilter: nf_tables: release batch on table validation from abort path
      netfilter: nf_tables: release mutex after nft_gc_seq_end from abort path
      netfilter: nf_tables: discard table flag update with pending basechain deletion

Paul Barker (1):
      net: ravb: Always process TX descriptor ring

Paul Menzel (1):
      PCI/DPC: Quirk PIO log size for Intel Raptor Lake Root Ports

Pawan Gupta (11):
      x86/asm: Add _ASM_RIP() macro for x86-64 (%rip) suffix
      x86/bugs: Add asm helpers for executing VERW
      x86/entry_64: Add VERW just before userspace transition
      x86/entry_32: Add VERW just before userspace transition
      x86/bugs: Use ALTERNATIVE() instead of mds_user_clear static key
      KVM/VMX: Use BT+JNC, i.e. EFLAGS.CF to select VMRESUME vs. VMLAUNCH
      KVM/VMX: Move VERW closer to VMentry for MDS mitigation
      x86/mmio: Disable KVM mitigation when X86_FEATURE_CLEAR_CPU_BUF is set
      Documentation/hw-vuln: Add documentation for RFDS
      x86/rfds: Mitigate Register File Data Sampling (RFDS)
      KVM/x86: Export RFDS_NO and RFDS_CLEAR to guests

Peter Collingbourne (1):
      serial: Lock console when calling into driver before registration

Petr Mladek (1):
      printk/console: Split out code that enables default console

Petre Rodan (1):
      tools: iio: replace seekdir() in iio_generic_buffer

Piotr Wejman (1):
      net: stmmac: fix rx queue priority assignment

Przemek Kitszel (1):
      ixgbe: avoid sleeping allocation in ixgbe_ipsec_vf_add_sa()

Pu Wen (1):
      x86/srso: Add SRSO mitigation for Hygon processors

Qiang Zhang (1):
      memtest: use {READ,WRITE}_ONCE in memory scanning

Qingliang Li (1):
      PM: sleep: wakeirq: fix wake irq warning in system suspend

Quinn Tran (3):
      scsi: qla2xxx: Split FCE|EFT trace control
      scsi: qla2xxx: Fix command flush on cable pull
      scsi: qla2xxx: Delay I/O Abort on PCI error

Rafael J. Wysocki (1):
      PCI/PM: Drain runtime-idle callbacks before driver removal

Randy Dunlap (2):
      sparc64: NMI watchdog: fix return value of __setup handler
      sparc: vDSO: fix return value of __setup handler

Ricardo B. Marliere (1):
      ktest: force $buildonly = 1 for 'make_warnings_file' test type

Richard Weinberger (1):
      ubi: Check for too small LEB size in VTBL code

Roberto Sassu (2):
      smack: Set SMACK64TRANSMUTE only for dirs in smack_inode_setxattr()
      smack: Handle SMACK64TRANSMUTE in smack_inode_setsecurity()

Rodrigo Siqueira (1):
      drm/amd/display: Return the correct HDCP error code

Roman Smirnov (2):
      block: prevent division by zero in blk_rq_stat_sum()
      fbmon: prevent division by zero in fb_videomode_from_videomode()

Ryan Roberts (1):
      mm: swap: fix race between free_swap_and_cache() and swapoff()

Ryosuke Yasuoka (1):
      nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet

Ryusuke Konishi (2):
      nilfs2: fix failure to detect DAT corruption in btree and direct mappings
      nilfs2: prevent kernel bug at submit_bh_wbc()

Salvatore Bonaccorso (1):
      scripts: kernel-doc: Fix syntax error due to undeclared args variable

Samasth Norway Ananda (1):
      tools/power x86_energy_perf_policy: Fix file leak in get_pkg_num()

Samuel Holland (1):
      riscv: Fix spurious errors from __get/put_kernel_nofault

Samuel Thibault (1):
      speakup: Fix 8bit characters from direct synth

Sandipan Das (1):
      x86/cpufeatures: Add new word for scattered features

Sean Anderson (4):
      soc: fsl: qbman: Always disable interrupts when taking cgr_lock
      soc: fsl: qbman: Add helper for sanity checking cgr ops
      soc: fsl: qbman: Add CGR update function
      soc: fsl: qbman: Use raw spinlock for cgr_lock

Sean Christopherson (3):
      KVM: Always flush async #PF workqueue when vCPU is being destroyed
      KVM: SVM: Flush pages under kvm->lock to fix UAF in svm_register_enc_region()
      x86/cpufeatures: Add CPUID_LNX_5 to track recently added Linux-defined word

Sean V Kelley (2):
      PCI/ERR: Cache RCEC EA Capability offset in pci_init_capabilities()
      PCI/ERR: Clear AER status only when we control AER

SeongJae Park (1):
      selftests/mqueue: Set timeout to 180 seconds

Shannon Nelson (1):
      ionic: set adminq irq affinity

Sherry Sun (1):
      tty: serial: fsl_lpuart: avoid idle preamble pending if CTS is enabled

Shin'ichiro Kawasaki (1):
      scsi: sd: Fix wrong zone_write_granularity value during revalidate

Song Liu (1):
      Revert "Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d""

Stanislaw Gruszka (1):
      PCI/AER: Block runtime suspend when handling errors

Stephen Lee (1):
      ASoC: ops: Fix wraparound for mask in snd_soc_get_volsw

Steven Rostedt (Google) (5):
      ring-buffer: Fix waking up ring buffer readers
      ring-buffer: Do not set shortest_full when full target is hit
      ring-buffer: Fix resetting of shortest_full
      ring-buffer: Fix full_waiters_pending in poll
      net: hns3: tracing: fix hclgevf trace event strings

Su Hui (1):
      octeontx2-pf: check negative error code in otx2_open()

Sumanth Korikkar (1):
      s390/entry: align system call table on 8 bytes

Sumit Garg (1):
      tee: optee: Fix kernel panic caused by incorrect error handling

Svyatoslav Pankratov (1):
      crypto: qat - fix double free during reset

Tetsuo Handa (1):
      sysv: don't call sb_bread() with pointers_lock held

Thadeu Lima de Souza Cascardo (1):
      tty: n_gsm: require CAP_NET_ADMIN to attach N_GSM0710 ldisc

Thomas Gleixner (3):
      timers: Update kernel-doc for various functions
      timers: Use del_timer_sync() even on UP
      timers: Rename del_timer_sync() to timer_delete_sync()

Tim Schumacher (1):
      efivarfs: Request at most 512 bytes for variable names

Toru Katagiri (1):
      USB: serial: cp210x: add pid/vid for TDK NC0110013M and MM0110113M

Uwe Kleine-König (1):
      PCI: Drop pci_device_remove() test of pci_dev->driver

Vasiliy Kovalev (1):
      VMCI: Fix possible memcpy() run-time warning in vmci_datagram_invoke_guest_handler()

Venkata Lakshmi Narayana Gubba (1):
      arm64: dts: qcom: sc7180: Remove clock for bluetooth on Trogdor

Vlastimil Babka (1):
      mm, vmscan: prevent infinite loop for costly GFP_NOIO | __GFP_RETRY_MAYFAIL allocations

Wayne Chang (2):
      phy: tegra: xusb: Add API to retrieve the port number of phy
      usb: gadget: tegra-xudc: Fix USB3 PHY retrieval logic

Wolfram Sang (1):
      mmc: tmio: avoid concurrent runs of mmc_request_done()

Xu Wang (1):
      vxge: remove unnecessary cast in kfree()

Yang Jihong (1):
      perf/core: Fix reentry problem in perf_output_read_group()

Ye Bin (1):
      ext4: forbid commit inconsistent quota data when errors=remount-ro

Yu Kuai (1):
      dm-raid: fix lockdep waring in "pers->hot_add_disk"

Zack Rusin (2):
      drm/vmwgfx: Fix some static checker warnings
      drm/vmwgfx: Fix possible null pointer derefence with invalid contexts

Zhang Yi (2):
      ubi: correct the calculation of fastmap size
      ext4: add a hint for block bitmap corrupt state in mb_groups

Zheng Wang (1):
      wifi: brcmfmac: Fix use-after-free bug in brcmf_cfg80211_detach

Zi Yan (1):
      mm/migrate: set swap entry values of THP tail pages properly.

Ziyang Xuan (1):
      netfilter: nf_tables: Fix potential data-race in __nft_flowtable_type_get()

linke li (1):
      ring-buffer: use READ_ONCE() to read cpu_buffer->commit_page in concurrent environment

yuan linyu (1):
      usb: udc: remove warning when queue disabled ep


