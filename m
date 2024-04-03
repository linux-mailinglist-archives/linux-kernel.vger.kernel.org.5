Return-Path: <linux-kernel+bounces-129947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAD8897264
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E211C265C4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62A914901E;
	Wed,  3 Apr 2024 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1e4pvNKd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E55414882F;
	Wed,  3 Apr 2024 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712154157; cv=none; b=OE1W5WwFJFQDdG165BUfgcNgpJU0QED70GbcD0ZvnZ3rexU1tb/gQk7/M6+0IB5qHPE5t0ULCAitgIN/lwsYZbqY8wWwe0HOakZhIenDuubi3PcvnhMKbpjyYXsILOCB+jI5DT6HVzDmkPJkKQW4l1Lhf0B1i8uQk6rTIZ7qs3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712154157; c=relaxed/simple;
	bh=cDFYJCknQLzkwDGZ2/8C5TWOh+nBKtXC0+pV2fqPIN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZC0IIM5T6xLMxHnroSOsM0FNaCbYhRyBMf85v1gdKokApIdDzJyrLhNJwk9q2G963cWOOz2e9OjIaPhr5mfRIoJTK1sdltOTzuN+PgvVGb9pEdvYajU2i9P4AxeIsmqK+O6wHzChQV1s4lXVdCCcH2UNW5AWAbU1IQm9/pvF9K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1e4pvNKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6573AC433C7;
	Wed,  3 Apr 2024 14:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712154157;
	bh=cDFYJCknQLzkwDGZ2/8C5TWOh+nBKtXC0+pV2fqPIN8=;
	h=From:To:Cc:Subject:Date:From;
	b=1e4pvNKdb7n4zQHtIO3tnmM9XJ/7fAhx6lAVnFyQb8685o30bPbxgeDVN1lhTpfsI
	 xNmgBmEwCm96hHIqfuOlzcXFfV1WDQDFX+djC0nPSP13A1Sk3dqRXBIpVK0ZRAEIzN
	 wiSgiqD250t8BRlaSc4sXvNy5B9PPytPwE6GXfTE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.84
Date: Wed,  3 Apr 2024 16:22:31 +0200
Message-ID: <2024040332-worried-rind-c6f4@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.84 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/hw-vuln/spectre.rst               |   17 
 Documentation/admin-guide/kernel-parameters.txt             |   10 
 Documentation/userspace-api/media/mediactl/media-types.rst  |   11 
 Documentation/x86/amd-memory-encryption.rst                 |   16 
 Makefile                                                    |    2 
 arch/arm/boot/dts/mmp2-brownstone.dts                       |    2 
 arch/arm64/boot/dts/qcom/sc7280.dtsi                        |   12 
 arch/hexagon/kernel/vmlinux.lds.S                           |    1 
 arch/loongarch/include/asm/io.h                             |    2 
 arch/loongarch/include/asm/percpu.h                         |    7 
 arch/parisc/include/asm/assembly.h                          |   18 
 arch/parisc/include/asm/checksum.h                          |   10 
 arch/parisc/kernel/unaligned.c                              |   27 -
 arch/powerpc/include/asm/reg_fsl_emb.h                      |   11 
 arch/powerpc/kernel/prom.c                                  |   12 
 arch/powerpc/lib/Makefile                                   |    2 
 arch/sparc/crypto/crop_devid.c                              |    2 
 arch/sparc/include/asm/floppy_32.h                          |    2 
 arch/sparc/include/asm/floppy_64.h                          |    2 
 arch/sparc/include/asm/parport.h                            |  258 ------------
 arch/sparc/include/asm/parport_64.h                         |  256 +++++++++++
 arch/sparc/kernel/apc.c                                     |    2 
 arch/sparc/kernel/auxio_32.c                                |    1 
 arch/sparc/kernel/auxio_64.c                                |    3 
 arch/sparc/kernel/central.c                                 |    2 
 arch/sparc/kernel/chmc.c                                    |    3 
 arch/sparc/kernel/ioport.c                                  |    2 
 arch/sparc/kernel/leon_kernel.c                             |    2 
 arch/sparc/kernel/leon_pci.c                                |    3 
 arch/sparc/kernel/leon_pci_grpci1.c                         |    3 
 arch/sparc/kernel/leon_pci_grpci2.c                         |    4 
 arch/sparc/kernel/nmi.c                                     |    2 
 arch/sparc/kernel/of_device_32.c                            |    2 
 arch/sparc/kernel/of_device_64.c                            |    4 
 arch/sparc/kernel/of_device_common.c                        |    4 
 arch/sparc/kernel/pci.c                                     |    3 
 arch/sparc/kernel/pci_common.c                              |    3 
 arch/sparc/kernel/pci_fire.c                                |    3 
 arch/sparc/kernel/pci_impl.h                                |    1 
 arch/sparc/kernel/pci_msi.c                                 |    2 
 arch/sparc/kernel/pci_psycho.c                              |    4 
 arch/sparc/kernel/pci_sun4v.c                               |    3 
 arch/sparc/kernel/pmc.c                                     |    2 
 arch/sparc/kernel/power.c                                   |    3 
 arch/sparc/kernel/prom_irqtrans.c                           |    1 
 arch/sparc/kernel/psycho_common.c                           |    1 
 arch/sparc/kernel/sbus.c                                    |    3 
 arch/sparc/kernel/time_32.c                                 |    1 
 arch/sparc/mm/io-unit.c                                     |    3 
 arch/sparc/mm/iommu.c                                       |    5 
 arch/sparc/vdso/vma.c                                       |    7 
 arch/x86/Kconfig                                            |   13 
 arch/x86/boot/compressed/efi_mixed.S                        |   29 +
 arch/x86/coco/core.c                                        |   20 
 arch/x86/coco/tdx/tdx.c                                     |    2 
 arch/x86/include/asm/asm.h                                  |   14 
 arch/x86/include/asm/coco.h                                 |   10 
 arch/x86/include/asm/cpufeatures.h                          |    1 
 arch/x86/include/asm/mem_encrypt.h                          |   15 
 arch/x86/include/asm/msr-index.h                            |    2 
 arch/x86/include/asm/sev.h                                  |    4 
 arch/x86/include/asm/suspend_32.h                           |   10 
 arch/x86/include/asm/x86_init.h                             |    3 
 arch/x86/kernel/cpu/amd.c                                   |   10 
 arch/x86/kernel/cpu/bugs.c                                  |  138 +++---
 arch/x86/kernel/cpu/common.c                                |   19 
 arch/x86/kernel/cpu/mshyperv.c                              |    2 
 arch/x86/kernel/eisa.c                                      |    3 
 arch/x86/kernel/fpu/xstate.c                                |    5 
 arch/x86/kernel/fpu/xstate.h                                |   14 
 arch/x86/kernel/kprobes/core.c                              |   11 
 arch/x86/kernel/probe_roms.c                                |   10 
 arch/x86/kernel/setup.c                                     |    3 
 arch/x86/kernel/sev-shared.c                                |   12 
 arch/x86/kernel/sev.c                                       |   31 -
 arch/x86/kernel/x86_init.c                                  |    2 
 arch/x86/kvm/cpuid.c                                        |   29 +
 arch/x86/kvm/lapic.c                                        |    5 
 arch/x86/kvm/reverse_cpuid.h                                |   42 +
 arch/x86/kvm/svm/sev.c                                      |   16 
 arch/x86/kvm/x86.c                                          |   10 
 arch/x86/kvm/xen.c                                          |    2 
 arch/x86/kvm/xen.h                                          |   18 
 arch/x86/mm/mem_encrypt_amd.c                               |   18 
 arch/x86/mm/mem_encrypt_identity.c                          |   38 -
 block/bio.c                                                 |   11 
 block/blk-mq.c                                              |   33 +
 block/blk-settings.c                                        |    4 
 block/mq-deadline.c                                         |    3 
 drivers/accessibility/speakup/synth.c                       |    4 
 drivers/ata/ahci.c                                          |    5 
 drivers/ata/libata-eh.c                                     |    5 
 drivers/ata/libata-scsi.c                                   |    9 
 drivers/base/power/wakeirq.c                                |    4 
 drivers/clk/qcom/gcc-ipq6018.c                              |    2 
 drivers/clk/qcom/gcc-ipq8074.c                              |    2 
 drivers/clk/qcom/gcc-sdm845.c                               |    1 
 drivers/clk/qcom/mmcc-apq8084.c                             |    2 
 drivers/clk/qcom/mmcc-msm8974.c                             |    2 
 drivers/clocksource/arm_global_timer.c                      |    2 
 drivers/cpufreq/amd-pstate.c                                |    2 
 drivers/cpufreq/brcmstb-avs-cpufreq.c                       |    5 
 drivers/cpufreq/cpufreq-dt.c                                |    2 
 drivers/crypto/qat/qat_common/adf_aer.c                     |   23 -
 drivers/firmware/efi/efi.c                                  |    2 
 drivers/firmware/efi/libstub/randomalloc.c                  |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                     |    1 
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                       |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           |   19 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c          |   12 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c         |    3 
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                          |   12 
 drivers/gpu/drm/drm_panel.c                                 |   17 
 drivers/gpu/drm/drm_probe_helper.c                          |    7 
 drivers/gpu/drm/etnaviv/etnaviv_drv.c                       |    2 
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c                      |    9 
 drivers/gpu/drm/exynos/exynos_drm_vidi.c                    |    4 
 drivers/gpu/drm/exynos/exynos_hdmi.c                        |    4 
 drivers/gpu/drm/i915/display/intel_bios.c                   |    3 
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c                 |    3 
 drivers/gpu/drm/i915/gt/intel_engine_pm.c                   |    3 
 drivers/gpu/drm/i915/gt/intel_execlists_submission.c        |    3 
 drivers/gpu/drm/imx/parallel-display.c                      |    4 
 drivers/gpu/drm/nouveau/nouveau_dmem.c                      |   12 
 drivers/gpu/drm/vc4/vc4_hdmi.c                              |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                         |   15 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                     |   14 
 drivers/hwmon/amc6821.c                                     |   11 
 drivers/i2c/busses/i2c-i801.c                               |    4 
 drivers/iio/accel/adxl367.c                                 |    8 
 drivers/iio/accel/adxl367_i2c.c                             |    2 
 drivers/iommu/dma-iommu.c                                   |    9 
 drivers/iommu/iommu.c                                       |    3 
 drivers/irqchip/irq-renesas-rzg2l.c                         |   93 +++-
 drivers/md/dm-raid.c                                        |    2 
 drivers/md/dm-snap.c                                        |    4 
 drivers/md/raid5.c                                          |   14 
 drivers/media/mc/mc-entity.c                                |   93 +++-
 drivers/media/tuners/xc4000.c                               |    4 
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c                      |   21 
 drivers/misc/mei/hw-me-regs.h                               |    2 
 drivers/misc/mei/pci-me.c                                   |    2 
 drivers/mmc/core/block.c                                    |   14 
 drivers/mmc/host/sdhci-omap.c                               |    3 
 drivers/mmc/host/tmio_mmc_core.c                            |    2 
 drivers/mtd/nand/raw/meson_nand.c                           |    2 
 drivers/mtd/ubi/fastmap.c                                   |    7 
 drivers/mtd/ubi/vtbl.c                                      |    6 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h    |    8 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h  |    8 
 drivers/net/ethernet/xilinx/ll_temac_main.c                 |    2 
 drivers/net/wireguard/netlink.c                             |   10 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |    4 
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c                 |   15 
 drivers/nvmem/meson-efuse.c                                 |   25 -
 drivers/pci/controller/dwc/pcie-designware-ep.c             |    7 
 drivers/pci/controller/dwc/pcie-qcom.c                      |  153 +++----
 drivers/pci/controller/pci-hyperv.c                         |    3 
 drivers/pci/pci-driver.c                                    |    7 
 drivers/pci/pcie/err.c                                      |   20 
 drivers/pci/quirks.c                                        |    2 
 drivers/phy/tegra/xusb.c                                    |   13 
 drivers/platform/x86/p2sb.c                                 |   25 -
 drivers/pwm/pwm-img.c                                       |    4 
 drivers/remoteproc/remoteproc_virtio.c                      |    6 
 drivers/s390/crypto/zcrypt_api.c                            |    2 
 drivers/scsi/hosts.c                                        |    7 
 drivers/scsi/libsas/sas_expander.c                          |   51 +-
 drivers/scsi/lpfc/lpfc_bsg.c                                |    4 
 drivers/scsi/lpfc/lpfc_nvmet.c                              |    2 
 drivers/scsi/qla2xxx/qla_attr.c                             |   14 
 drivers/scsi/qla2xxx/qla_def.h                              |    2 
 drivers/scsi/qla2xxx/qla_gbl.h                              |    2 
 drivers/scsi/qla2xxx/qla_init.c                             |  128 +++--
 drivers/scsi/qla2xxx/qla_iocb.c                             |   68 ++-
 drivers/scsi/qla2xxx/qla_mbx.c                              |    2 
 drivers/scsi/qla2xxx/qla_os.c                               |    2 
 drivers/scsi/qla2xxx/qla_target.c                           |   10 
 drivers/scsi/scsi_scan.c                                    |   34 +
 drivers/scsi/sd.c                                           |   25 -
 drivers/slimbus/core.c                                      |    4 
 drivers/soc/fsl/qbman/qman.c                                |   25 -
 drivers/staging/media/ipu3/ipu3-v4l2.c                      |   16 
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c       |    5 
 drivers/tee/optee/device.c                                  |    3 
 drivers/thermal/devfreq_cooling.c                           |    2 
 drivers/tty/serial/8250/8250_port.c                         |    6 
 drivers/tty/serial/fsl_lpuart.c                             |    7 
 drivers/tty/serial/imx.c                                    |   22 -
 drivers/tty/serial/max310x.c                                |    7 
 drivers/tty/serial/serial_core.c                            |   12 
 drivers/tty/vt/vt.c                                         |    2 
 drivers/usb/class/cdc-wdm.c                                 |    6 
 drivers/usb/core/hub.c                                      |   23 -
 drivers/usb/core/hub.h                                      |    2 
 drivers/usb/core/port.c                                     |   43 +-
 drivers/usb/core/sysfs.c                                    |   16 
 drivers/usb/dwc2/core.h                                     |   14 
 drivers/usb/dwc2/core_intr.c                                |   72 ++-
 drivers/usb/dwc2/gadget.c                                   |   10 
 drivers/usb/dwc2/hcd.c                                      |   49 +-
 drivers/usb/dwc2/hcd_ddma.c                                 |   17 
 drivers/usb/dwc2/hw.h                                       |    2 
 drivers/usb/dwc2/platform.c                                 |    2 
 drivers/usb/dwc3/dwc3-am62.c                                |   90 +---
 drivers/usb/gadget/function/f_ncm.c                         |    2 
 drivers/usb/gadget/udc/core.c                               |    4 
 drivers/usb/gadget/udc/tegra-xudc.c                         |   39 +
 drivers/usb/host/xhci.c                                     |    2 
 drivers/usb/phy/phy-generic.c                               |    7 
 drivers/usb/serial/cp210x.c                                 |    4 
 drivers/usb/serial/ftdi_sio.c                               |    2 
 drivers/usb/serial/ftdi_sio_ids.h                           |    6 
 drivers/usb/serial/option.c                                 |    6 
 drivers/usb/storage/isd200.c                                |   23 -
 drivers/usb/storage/uas.c                                   |   28 -
 drivers/usb/typec/class.c                                   |    7 
 drivers/usb/typec/ucsi/ucsi.c                               |   46 +-
 drivers/usb/typec/ucsi/ucsi.h                               |    4 
 drivers/usb/typec/ucsi/ucsi_acpi.c                          |   75 +--
 drivers/vfio/container.c                                    |    2 
 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c                      |    7 
 drivers/vfio/pci/vfio_pci_config.c                          |    6 
 drivers/vfio/pci/vfio_pci_core.c                            |    7 
 drivers/vfio/pci/vfio_pci_igd.c                             |    2 
 drivers/vfio/pci/vfio_pci_intrs.c                           |  206 +++++----
 drivers/vfio/pci/vfio_pci_rdwr.c                            |    2 
 drivers/vfio/platform/vfio_platform_irq.c                   |  106 +++-
 drivers/vfio/virqfd.c                                       |   23 +
 fs/aio.c                                                    |    8 
 fs/btrfs/block-group.c                                      |    3 
 fs/btrfs/qgroup.c                                           |   10 
 fs/btrfs/scrub.c                                            |   12 
 fs/btrfs/volumes.c                                          |    2 
 fs/exec.c                                                   |    1 
 fs/ext4/mballoc.c                                           |   17 
 fs/ext4/resize.c                                            |    3 
 fs/f2fs/f2fs.h                                              |    1 
 fs/f2fs/segment.c                                           |    4 
 fs/fat/nfs.c                                                |    6 
 fs/fuse/dir.c                                               |    4 
 fs/fuse/fuse_i.h                                            |    1 
 fs/fuse/inode.c                                             |    7 
 fs/nfs/direct.c                                             |   11 
 fs/nfs/write.c                                              |    2 
 fs/nfsd/trace.h                                             |    2 
 fs/nilfs2/btree.c                                           |    9 
 fs/nilfs2/direct.c                                          |    9 
 fs/nilfs2/inode.c                                           |    2 
 fs/smb/client/cached_dir.c                                  |    3 
 fs/smb/server/smb2pdu.c                                     |   10 
 fs/ubifs/file.c                                             |   13 
 include/drm/drm_modeset_helper_vtables.h                    |    3 
 include/linux/cpufreq.h                                     |   15 
 include/linux/gfp.h                                         |    9 
 include/linux/hyperv.h                                      |   22 -
 include/linux/libata.h                                      |    1 
 include/linux/minmax.h                                      |   17 
 include/linux/nfs_fs.h                                      |    1 
 include/linux/phy/tegra/xusb.h                              |    1 
 include/linux/ring_buffer.h                                 |    1 
 include/linux/timer.h                                       |   18 
 include/linux/vfio.h                                        |    2 
 include/media/media-entity.h                                |    2 
 include/net/cfg802154.h                                     |    1 
 include/scsi/scsi_driver.h                                  |    1 
 include/scsi/scsi_host.h                                    |    1 
 init/Kconfig                                                |    6 
 init/initramfs.c                                            |    2 
 io_uring/net.c                                              |    3 
 kernel/bounds.c                                             |    2 
 kernel/dma/swiotlb.c                                        |   11 
 kernel/entry/common.c                                       |    8 
 kernel/power/suspend.c                                      |    1 
 kernel/printk/printk.c                                      |   27 +
 kernel/time/timer.c                                         |  164 ++++---
 kernel/trace/ring_buffer.c                                  |  233 ++++++----
 kernel/trace/trace.c                                        |   21 
 lib/pci_iomap.c                                             |    2 
 mm/compaction.c                                             |    7 
 mm/kasan/kasan_test.c                                       |    3 
 mm/memtest.c                                                |    4 
 mm/migrate.c                                                |    6 
 mm/page_alloc.c                                             |   10 
 mm/swapfile.c                                               |   25 -
 mm/vmscan.c                                                 |    5 
 net/bluetooth/hci_core.c                                    |    6 
 net/bluetooth/hci_sync.c                                    |    5 
 net/mac80211/cfg.c                                          |    5 
 net/mac802154/llsec.c                                       |   18 
 net/netfilter/nf_tables_api.c                               |    7 
 net/tls/tls_sw.c                                            |   60 ++
 net/xfrm/xfrm_user.c                                        |    3 
 scripts/Makefile.extrawarn                                  |    2 
 security/landlock/syscalls.c                                |   18 
 security/smack/smack_lsm.c                                  |   12 
 sound/pci/hda/patch_realtek.c                               |   13 
 sound/sh/aica.c                                             |   17 
 sound/soc/amd/yc/acp6x-mach.c                               |    7 
 tools/include/linux/btf_ids.h                               |    2 
 tools/testing/selftests/mqueue/setting                      |    1 
 tools/testing/selftests/net/mptcp/diag.sh                   |    6 
 virt/kvm/async_pf.c                                         |   31 +
 303 files changed, 2970 insertions(+), 1661 deletions(-)

Adamos Ttofari (1):
      x86/fpu: Keep xfd_state in sync with MSR_IA32_XFD

Alan Stern (4):
      USB: usb-storage: Prevent divide-by-0 error in isd200_ata_command
      USB: core: Add hub_get() and hub_put() routines
      USB: core: Fix deadlock in port "disable" sysfs attribute
      USB: core: Fix deadlock in usb_deauthorize_interface()

Alex Deucher (1):
      drm/amd/display: handle range offsets in VRR ranges

Alex Williamson (7):
      vfio/pci: Lock external INTx masking ops
      vfio/platform: Disable virqfds on cleanup
      vfio/pci: Disable auto-enable of exclusive INTx IRQ
      vfio: Introduce interface to flush virqfd inject workqueue
      vfio/pci: Create persistent INTx handler
      vfio/platform: Create persistent IRQ handlers
      vfio/fsl-mc: Block calling interrupt handler without trigger

Alexander Stein (1):
      Revert "usb: phy: generic: Get the vbus supply"

Alexander Usyskin (2):
      mei: me: add arrow lake point S DID
      mei: me: add arrow lake point H DID

Amit Pundir (1):
      clk: qcom: gcc-sdm845: Add soft dependency on rpmhpd

Andrey Jr. Melnikov (1):
      ahci: asm1064: correct count of reported ports

André Rösti (1):
      entry: Respect changes to system call number by trace_sys_enter()

Andy Chi (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for HP EliteBook

Anton Altaparmakov (1):
      x86/pm: Work around false positive kmemleak report in msr_build_context()

Ard Biesheuvel (4):
      x86/efistub: Call mixed mode boot services on the firmware's stack
      x86/sev: Fix position dependent variable references in startup code
      x86/efistub: Add missing boot_params for mixed mode compat entry
      efi/libstub: Cast away type warning in use of max()

Arnd Bergmann (2):
      kasan/test: avoid gcc warning for intentional overflow
      staging: vc04_services: changen strncpy() to strscpy_pad()

Arseniy Krasnov (1):
      mtd: rawnand: meson: fix scrambling mode value in command macro

Aurélien Jacobs (1):
      USB: serial: option: add MeiG Smart SLM320 product

Baokun Li (1):
      ext4: correct best extent lstart adjustment logic

Bart Van Assche (2):
      Revert "block/mq-deadline: use correct way to throttling write requests"
      fs/aio: Check IOCB_AIO_RW before the struct aio_kiocb conversion

Biju Das (4):
      irqchip/renesas-rzg2l: Flush posted write in irq_eoi()
      irqchip/renesas-rzg2l: Rename rzg2l_tint_eoi()
      irqchip/renesas-rzg2l: Rename rzg2l_irq_eoi()
      irqchip/renesas-rzg2l: Prevent spurious interrupts when setting trigger type

Bikash Hazarika (1):
      scsi: qla2xxx: Update manufacturer detail

Borislav Petkov (1):
      x86/bugs: Use sysfs_emit()

Borislav Petkov (AMD) (4):
      x86/CPU/AMD: Update the Zenbleed microcode revisions
      x86/coco: Export cc_vendor
      x86/coco: Get rid of accessor functions
      x86/Kconfig: Remove CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT

Cameron Williams (1):
      USB: serial: add device ID for VeriFone adapter

Charan Teja Kalla (1):
      iommu: Avoid races around default domain allocations

Chengming Zhou (1):
      blk-mq: release scheduler resource when request completes

Chris Wilson (1):
      drm/i915/gt: Reset queue_priority_hint on parking

Christian A. Ehrhardt (4):
      usb: typec: ucsi: Clear EVENT_PENDING under PPM lock
      usb: typec: ucsi: Ack unsupported commands
      usb: typec: ucsi_acpi: Refactor and fix DELL quirk
      usb: typec: ucsi: Clear UCSI_CCI_RESET_COMPLETE before reset

Christian Gmeiner (1):
      drm/etnaviv: Restore some id values

Christian Häggström (1):
      USB: serial: cp210x: add ID for MGP Instruments PDS100

Christophe JAILLET (1):
      slimbus: core: Remove usage of the deprecated ida_simple_xx() API

Claudiu Beznea (2):
      irqchip/renesas-rzg2l: Implement restriction when writing ISCR register
      irqchip/renesas-rzg2l: Add macro to retrieve TITSR register offset based on register's index

Claus Hansen Ries (1):
      net: ll_temac: platform_get_resource replaced by wrong function

Conrad Kostecki (1):
      ahci: asm1064: asm1166: don't limit reported ports

Cosmin Tanislav (2):
      iio: accel: adxl367: fix DEVID read after reset
      iio: accel: adxl367: fix I2C FIFO data register

Damian Muszynski (1):
      crypto: qat - resolve race condition during AER recovery

Damien Le Moal (3):
      block: Clear zone limits for a non-zoned stacked queue
      block: Do not force full zone append completion in req_bio_endio()
      scsi: sd: Fix TCG OPAL unlock on system resume

Dan Carpenter (1):
      staging: vc04_services: fix information leak in create_component()

Daniel Vogelbacher (1):
      USB: serial: ftdi_sio: add support for GMC Z216C Adapter IR-USB

David Laight (1):
      minmax: add umin(a, b) and umax(a, b)

David Woodhouse (1):
      KVM: x86/xen: inject vCPU upcall vector when local APIC is enabled

Dominique Martinet (1):
      mmc: core: Fix switch on gp3 partition

Duje Mihanović (1):
      arm: dts: marvell: Fix maxium->maxim typo in brownstone dts

Duoming Zhou (2):
      nouveau/dmem: handle kcalloc() allocation failure
      ALSA: sh: aica: reorder cleanup operations to avoid UAF bugs

Eric Huang (1):
      drm/amdkfd: fix TLB flush after unmap for GFX9.4.2

Eugene Korenevsky (1):
      cifs: open_cached_dir(): add FILE_READ_EA to desired access

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

Geliang Tang (1):
      selftests: mptcp: diag: return KSFT_FAIL not test_cnt

Greg Kroah-Hartman (2):
      cpufreq: brcmstb-avs-cpufreq: fix up "add check for cpufreq_cpu_get's return value"
      Linux 6.1.84

Guenter Roeck (5):
      parisc/unaligned: Rewrite 64-bit inline assembly of emulate_ldd()
      parisc: Fix ip_fast_csum
      parisc: Fix csum_ipv6_magic on 32-bit systems
      parisc: Fix csum_ipv6_magic on 64-bit systems
      parisc: Strip upper 32 bit of sum in csum_ipv6_magic for 64-bit builds

Gui-Dong Han (2):
      media: xc4000: Fix atomicity violation in xc4000_get_frequency
      md/raid5: fix atomicity violation in raid5_cache_count

Guilherme G. Piccoli (1):
      scsi: core: Fix unremoved procfs host directory regression

Hans de Goede (2):
      platform/x86: p2sb: On Goldmont only cache P2SB and SPI devfn BAR
      misc: lis3lv02d_i2c: Fix regulators getting en-/dis-abled twice on suspend/resume

Harald Freudenberger (1):
      s390/zcrypt: fix reference counting on zcrypt card objects

Heiner Kallweit (1):
      i2c: i801: Avoid potential double call to gpiod_remove_lookup_table

Hidenori Kobayashi (1):
      media: staging: ipu3-imgu: Set fields before media_entity_pads_init()

Huacai Chen (2):
      LoongArch: Change __my_cpu_offset definition to avoid mis-optimization
      LoongArch: Define the __io_aw() hook as mmiowb()

Huang Ying (1):
      swap: comments get_swap_device() with usage rule

Hugo Villeneuve (1):
      serial: max310x: fix NULL pointer dereference in I2C instantiation

Jakub Kicinski (2):
      tls: fix race between tx work scheduling and socket close
      net: tls: handle backlogging of crypto requests

Jameson Thies (1):
      usb: typec: ucsi: Clean up UCSI_CABLE_PROP macros

Jan Kara (1):
      fat: fix uninitialized field in nostale filehandles

Jani Nikula (5):
      drm/probe-helper: warn about negative .get_modes()
      drm/panel: do not return negative error codes from drm_panel_get_modes()
      drm/exynos: do not return negative values from .get_modes()
      drm/imx/ipuv3: do not return negative values from .get_modes()
      drm/vc4: hdmi: do not return negative values from .get_modes()

Jason A. Donenfeld (2):
      wireguard: netlink: check for dangling peer via is_dead instead of empty list
      wireguard: netlink: access device through ctx instead of peer

Jason Gunthorpe (1):
      vfio: Use GFP_KERNEL_ACCOUNT for userspace persistent allocations

Jens Axboe (1):
      io_uring/net: correctly handle multishot recvmsg retry setup

Jerome Brunet (1):
      nvmem: meson-efuse: fix function pointer type mismatch

Jiawei Wang (1):
      ASoC: amd: yc: Revert "Fix non-functional mic on Lenovo 21J2"

Jim Mattson (2):
      KVM: x86: Advertise CPUID.(EAX=7,ECX=2):EDX[5:0] to userspace
      KVM: x86: Use a switch statement and macros in __feature_translate()

Joakim Zhang (1):
      remoteproc: virtio: Fix wdg cannot recovery remote processor

Jocelyn Falempe (1):
      drm/vmwgfx: Create debugfs ttm_resource_manager entry only if needed

Johannes Berg (1):
      wifi: iwlwifi: fw: don't always use FW dump trig

Johannes Thumshirn (2):
      btrfs: zoned: don't skip block groups with 100% zone unusable
      btrfs: zoned: use zone aware sb location for scrub

John David Anglin (1):
      parisc: Avoid clobbering the C/B bits in the PSW with tophys and tovirt macros

John Ogness (1):
      printk: Update @console_may_schedule in console_trylock_spinning()

John Sperbeck (1):
      init: open /initrd.image with O_LARGEFILE

Josef Bacik (1):
      nfs: fix UAF in direct writes

Josua Mayer (1):
      hwmon: (amc6821) add of_match table

KONDO KAZUMA(近藤　和真) (1):
      efi/libstub: fix efi_random_alloc() to allocate memory at alloc_min or higher address

Kailang Yang (2):
      ALSA: hda/realtek - Fix headset Mic no show at resume back for Lenovo ALC897 platform
      ALSA: hda/realtek - Add Headset Mic supported Acer NB platform

Kees Cook (1):
      init/Kconfig: lower GCC version check for -Warray-bounds

Kevin Loughlin (1):
      x86/sev: Skip ROM range scans and validation for SEV-SNP guests

Kim Phillips (2):
      x86/cpu: Support AMD Automatic IBRS
      x86/cpu: Enable STIBP on AMD if Automatic IBRS is enabled

Krishna Kurapati (1):
      usb: gadget: ncm: Fix handling of zero block length packets

Krishna chaitanya chundru (1):
      arm64: dts: qcom: sc7280: Add additional MSI interrupts

Kyle Tso (1):
      usb: typec: Return size of buffer if pd_set operation succeeds

Ladislav Michl (1):
      usb: dwc3-am62: Rename private data

Laurent Pinchart (5):
      media: mc: Add local pad to pipeline regardless of the link state
      media: mc: Fix flags handling when creating pad links
      media: mc: Add num_links flag to media_pad
      media: mc: Rename pad variable to clarify intent
      media: mc: Expand MUST_CONNECT flag to always require an enabled link

Leo Ma (1):
      drm/amd/display: Fix noise issue on HDMI AV mute

Luiz Augusto von Dentz (1):
      Bluetooth: hci_sync: Fix not checking error on hci_cmd_sync_cancel_sync

Ma Jun (1):
      drm/amdgpu/pm: Fix the error of pwm1_enable setting

Manivannan Sadhasivam (2):
      PCI: qcom: Rename qcom_pcie_config_sid_sm8250() to reflect IP version
      PCI: qcom: Enable BDF to SID translation properly

Marek Szyprowski (1):
      cpufreq: dt: always allocate zeroed cpumask

Marios Makassikis (1):
      ksmbd: retrieve number of blocks using vfs_getattr in set_file_allocation_info

Martin Blumenstingl (1):
      clocksource/drivers/arm_global_timer: Fix maximum prescaler value

Masami Hiramatsu (Google) (1):
      kprobes/x86: Use copy_from_kernel_nofault() to read from unsafe address

Mathias Nyman (1):
      usb: port: Don't try to peer unused USB ports based on location

Matthew Wilcox (Oracle) (2):
      bounds: support non-power-of-two CONFIG_NR_CPUS
      ubifs: Set page uptodate in the correct place

Maulik Shah (1):
      PM: suspend: Set mem_sleep_current during kernel command line setup

Max Filippov (1):
      exec: Fix NOMMU linux_binprm::exec in transfer_args_to_stack()

Maximilian Heyne (1):
      ext4: fix corruption during on-line resize

Michael Ellerman (3):
      powerpc/smp: Adjust nr_cpu_ids to cover all threads of a core
      powerpc/smp: Increase nr_cpu_ids to include the boot CPU
      powerpc/fsl: Fix mfpmr build errors with newer binutils

Michael Kelley (2):
      PCI: hv: Fix ring buffer size calculation
      Drivers: hv: vmbus: Calculate ring buffer size for more efficient use of memory

Mickaël Salaün (1):
      landlock: Warn once if a Landlock action is requested while disabled

Mikko Rapeli (2):
      mmc: core: Initialize mmc_blk_ioc_data
      mmc: core: Avoid negative index with array access

Miklos Szeredi (2):
      fuse: fix root lookup with nonzero generation
      fuse: don't unhash root

Mikulas Patocka (1):
      dm snapshot: fix lockup in dm_exception_table_exit

Minas Harutyunyan (5):
      usb: dwc2: host: Fix remote wakeup from hibernation
      usb: dwc2: host: Fix hibernation flow
      usb: dwc2: host: Fix ISOC flow in DDMA mode
      usb: dwc2: gadget: Fix exiting from clock gating
      usb: dwc2: gadget: LPM flow fix

Muhammad Usama Anjum (2):
      scsi: lpfc: Correct size for cmdwqe/rspwqe for memset()
      scsi: lpfc: Correct size for wqe for memset()

Natanael Copa (1):
      tools/resolve_btfids: fix build with musl libc

Nathan Chancellor (4):
      powerpc: xor_vmx: Add '-mhard-float' to CFLAGS
      kbuild: Move -Wenum-{compare-conditional,enum-conversion} into W=1
      xfrm: Avoid clang fortify warning in copy_to_user_tmpl()
      hexagon: vmlinux.lds.S: handle attributes section

Nicolas Pitre (1):
      vt: fix unicode buffer corruption when deleting characters

Nicolin Chen (1):
      iommu/dma: Force swiotlb_max_mapping_size on an untrusted device

Niklas Cassel (1):
      PCI: dwc: endpoint: Fix advertised resizable BAR size

Nirmoy Das (1):
      drm/i915: Check before removing mm notifier

Oleksandr Tymoshenko (1):
      efi: fix panic in kdump kernel

Oliver Neukum (1):
      usb: cdc-wdm: close race between read and workqueue

Pablo Neira Ayuso (3):
      netfilter: nf_tables: mark set as dead when unbinding anonymous set with timeout
      netfilter: nf_tables: disallow anonymous set with timeout flag
      netfilter: nf_tables: reject constant set with timeout

Paul Menzel (1):
      PCI/DPC: Quirk PIO log size for Intel Raptor Lake Root Ports

Peter Collingbourne (1):
      serial: Lock console when calling into driver before registration

Philip Yang (1):
      drm/amdgpu: amdgpu_ttm_gart_bind set gtt bound flag

Philipp Stanner (1):
      pci_iounmap(): Fix MMIO mapping leak

Prashanth K (1):
      usb: xhci: Add error handling in xhci_map_urb_for_dma

Qiang Zhang (1):
      memtest: use {READ,WRITE}_ONCE in memory scanning

Qingliang Li (1):
      PM: sleep: wakeirq: fix wake irq warning in system suspend

Qu Wenruo (1):
      btrfs: qgroup: always free reserved space for extent records

Quinn Tran (6):
      scsi: qla2xxx: Prevent command send on chip reset
      scsi: qla2xxx: Fix N2N stuck connection
      scsi: qla2xxx: Split FCE|EFT trace control
      scsi: qla2xxx: NVME|FCP prefer flag not being honored
      scsi: qla2xxx: Fix command flush on cable pull
      scsi: qla2xxx: Delay I/O Abort on PCI error

Rafael J. Wysocki (1):
      PCI/PM: Drain runtime-idle callbacks before driver removal

Randy Dunlap (2):
      sparc64: NMI watchdog: fix return value of __setup handler
      sparc: vDSO: fix return value of __setup handler

Reinette Chatre (2):
      vfio/pci: Consolidate irq cleanup on MSI/MSI-X disable
      vfio/pci: Remove negative check on unsigned vector

Richard Weinberger (1):
      ubi: Check for too small LEB size in VTBL code

Rickard x Andersson (1):
      tty: serial: imx: Fix broken RS485

Rob Herring (1):
      sparc: Explicitly include correct DT includes

Roberto Sassu (2):
      smack: Set SMACK64TRANSMUTE only for dirs in smack_inode_setxattr()
      smack: Handle SMACK64TRANSMUTE in smack_inode_setsecurity()

Rodrigo Siqueira (1):
      drm/amd/display: Return the correct HDCP error code

Roger Quadros (1):
      usb: dwc3-am62: fix module unload/reload behavior

Romain Naour (1):
      mmc: sdhci-omap: re-tuning is needed after a pm transition to support emmc HS200 mode

Ryan Roberts (1):
      mm: swap: fix race between free_swap_and_cache() and swapoff()

Ryusuke Konishi (2):
      nilfs2: fix failure to detect DAT corruption in btree and direct mappings
      nilfs2: prevent kernel bug at submit_bh_wbc()

Sabrina Dubroca (1):
      tls: fix use-after-free on failed backlog decryption

Sam Ravnborg (1):
      sparc32: Fix parport build with sparc32

Samuel Thibault (1):
      speakup: Fix 8bit characters from direct synth

Saurav Kashyap (2):
      scsi: qla2xxx: Fix double free of fcport
      scsi: qla2xxx: Change debug message during driver unload

Sean Anderson (2):
      soc: fsl: qbman: Always disable interrupts when taking cgr_lock
      soc: fsl: qbman: Use raw spinlock for cgr_lock

Sean Christopherson (4):
      KVM: x86: Update KVM-only leaf handling to allow for 100% KVM-only leafs
      KVM: Always flush async #PF workqueue when vCPU is being destroyed
      KVM: x86: Mark target gfn of emulated atomic instruction as dirty
      KVM: SVM: Flush pages under kvm->lock to fix UAF in svm_register_enc_region()

SeongJae Park (1):
      selftests/mqueue: Set timeout to 180 seconds

Sherry Sun (1):
      tty: serial: fsl_lpuart: avoid idle preamble pending if CTS is enabled

Shivnandan Kumar (1):
      cpufreq: Limit resolving a frequency to policy min/max

Stanislaw Gruszka (1):
      PCI/AER: Block runtime suspend when handling errors

Steven Rostedt (Google) (8):
      ring-buffer: Fix waking up ring buffer readers
      ring-buffer: Do not set shortest_full when full target is hit
      ring-buffer: Fix resetting of shortest_full
      ring-buffer: Fix full_waiters_pending in poll
      ring-buffer: Use wait_event_interruptible() in ring_buffer_wait()
      NFSD: Fix nfsd_clid_class use of __string_len() macro
      net: hns3: tracing: fix hclgevf trace event strings
      tracing: Use .flush() call to wake up readers

Sumit Garg (1):
      tee: optee: Fix kernel panic caused by incorrect error handling

Sunmin Jeong (2):
      f2fs: mark inode dirty for FI_ATOMIC_COMMITTED flag
      f2fs: truncate page cache before clearing flags when aborting atomic write

Svyatoslav Pankratov (1):
      crypto: qat - fix double free during reset

Thomas Gleixner (3):
      timers: Update kernel-doc for various functions
      timers: Use del_timer_sync() even on UP
      timers: Rename del_timer_sync() to timer_delete_sync()

Tony Battersby (1):
      block: Fix page refcounts for unaligned buffers in __bio_release_pages()

Tor Vic (1):
      cpufreq: amd-pstate: Fix min_perf assignment in amd_pstate_adjust_perf()

Toru Katagiri (1):
      USB: serial: cp210x: add pid/vid for TDK NC0110013M and MM0110113M

Ville Syrjälä (1):
      drm/i915/bios: Tolerate devdata==NULL in intel_bios_encoder_supports_dp_dual_mode()

Vlastimil Babka (1):
      mm, vmscan: prevent infinite loop for costly GFP_NOIO | __GFP_RETRY_MAYFAIL allocations

Wayne Chang (2):
      phy: tegra: xusb: Add API to retrieve the port number of phy
      usb: gadget: tegra-xudc: Fix USB3 PHY retrieval logic

Weitao Wang (1):
      USB: UAS: return ENODEV when submit urbs fail with device not attached

Will Deacon (1):
      swiotlb: Fix alignment checks when both allocation and DMA masks are present

Wolfram Sang (1):
      mmc: tmio: avoid concurrent runs of mmc_request_done()

Xingui Yang (2):
      scsi: libsas: Add a helper sas_get_sas_addr_and_dev_type()
      scsi: libsas: Fix disk not being scanned in after being removed

Ye Zhang (1):
      thermal: devfreq_cooling: Fix perf state when calculate dfc res_util

Yu Kuai (1):
      dm-raid: fix lockdep waring in "pers->hot_add_disk"

Zack Rusin (1):
      drm/vmwgfx: Fix possible null pointer derefence with invalid contexts

Zhang Yi (1):
      ubi: correct the calculation of fastmap size

Zheng Wang (1):
      wifi: brcmfmac: Fix use-after-free bug in brcmf_cfg80211_detach

Zi Yan (1):
      mm/migrate: set swap entry values of THP tail pages properly.

Zoltan HERPAI (1):
      pwm: img: fix pwm clock lookup

yuan linyu (1):
      usb: udc: remove warning when queue disabled ep


