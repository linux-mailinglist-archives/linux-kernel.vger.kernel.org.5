Return-Path: <linux-kernel+bounces-138824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8356789FACB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F681C227E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6E215F408;
	Wed, 10 Apr 2024 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QD4jsPcy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CBB16DEBB;
	Wed, 10 Apr 2024 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761032; cv=none; b=ZNZMJHmFFp1bPRCWyNi062XSTfG5vGjIxl4t2YBIBamI5YPgIloCJUNj1x8lFFeb33YLf7/+GyErbh9vJm/Z+lCtU1f+jjg29/Tudf/gQFrl8CdXX+1A84PVUB0ZPRxo6Lz5UlBYLXHSIqpHvmJt5XZgKbeQ+CvtHOm+3vxU2qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761032; c=relaxed/simple;
	bh=BQG5sJIIqBy9S2pP25pig0OlUtX6KzFIaMSJ4J/muZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M9fjaHN5TWWBnDD8L3ct8+zVDwIWIzI1I0Kh1xc39eX9T9BS66npwO+zub9bznrsesHHxLmYL/8jIpMjpP8TvVeU1BFpm//8LC+XLSIBE8QzLizj0MUj+IgrTUED7iwUJBwDh98a+RjUUEARu+ISKG9EMwgINwC8VS7+is6zpJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QD4jsPcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F163C43390;
	Wed, 10 Apr 2024 14:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712761031;
	bh=BQG5sJIIqBy9S2pP25pig0OlUtX6KzFIaMSJ4J/muZc=;
	h=From:To:Cc:Subject:Date:From;
	b=QD4jsPcyvdnvJEl5jflFlPUXMJrajU61TIHSLhpd6ecAVkEgSVsd0OL2PCDwwHLoT
	 GtecZSrOlk5PZauE21nL108bl6b2yh/ZpLVDEqnSOc2A0FvntIWnwgEJ2D6VCq18MN
	 g69aQTssu60BWfN8iPZc/y5aF/ndHx6WtW7FTSrI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.154
Date: Wed, 10 Apr 2024 16:57:06 +0200
Message-ID: <2024041007-afraid-underfoot-b5ef@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.154 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-devices-system-cpu           |    1 
 Documentation/admin-guide/filesystem-monitoring.rst          |   74 
 Documentation/admin-guide/hw-vuln/index.rst                  |    1 
 Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst |  104 
 Documentation/admin-guide/hw-vuln/spectre.rst                |   66 
 Documentation/admin-guide/index.rst                          |    1 
 Documentation/admin-guide/kernel-parameters.txt              |   39 
 Documentation/core-api/dma-api.rst                           |   14 
 Documentation/filesystems/locking.rst                        |   10 
 Documentation/filesystems/nfs/exporting.rst                  |   33 
 Documentation/x86/mds.rst                                    |   38 
 MAINTAINERS                                                  |    7 
 Makefile                                                     |    6 
 arch/Kconfig                                                 |   24 
 arch/arm/boot/dts/mmp2-brownstone.dts                        |    2 
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi                 |    2 
 arch/arm64/include/asm/kvm_pgtable.h                         |   18 
 arch/arm64/include/asm/stage2_pgtable.h                      |   20 
 arch/arm64/kvm/mmu.c                                         |    9 
 arch/hexagon/kernel/vmlinux.lds.S                            |    1 
 arch/ia64/Kconfig                                            |    1 
 arch/ia64/Makefile                                           |    2 
 arch/openrisc/kernel/dma.c                                   |   16 
 arch/parisc/include/asm/assembly.h                           |   18 
 arch/parisc/include/asm/checksum.h                           |   10 
 arch/powerpc/include/asm/reg_fsl_emb.h                       |   11 
 arch/powerpc/lib/Makefile                                    |    2 
 arch/riscv/include/asm/uaccess.h                             |    4 
 arch/riscv/kernel/process.c                                  |    3 
 arch/s390/kernel/entry.S                                     |    1 
 arch/sparc/kernel/nmi.c                                      |    2 
 arch/sparc/vdso/vma.c                                        |    7 
 arch/x86/Kconfig                                             |   38 
 arch/x86/boot/compressed/head_64.S                           |    8 
 arch/x86/entry/common.c                                      |    6 
 arch/x86/entry/entry.S                                       |   23 
 arch/x86/entry/entry_32.S                                    |    3 
 arch/x86/entry/entry_64.S                                    |   72 
 arch/x86/entry/entry_64_compat.S                             |    4 
 arch/x86/entry/syscall_32.c                                  |   21 
 arch/x86/entry/syscall_64.c                                  |   19 
 arch/x86/entry/syscall_x32.c                                 |   10 
 arch/x86/include/asm/asm-prototypes.h                        |    1 
 arch/x86/include/asm/asm.h                                   |    5 
 arch/x86/include/asm/cpufeature.h                            |    8 
 arch/x86/include/asm/cpufeatures.h                           |   18 
 arch/x86/include/asm/disabled-features.h                     |    3 
 arch/x86/include/asm/entry-common.h                          |    1 
 arch/x86/include/asm/linkage.h                               |   12 
 arch/x86/include/asm/msr-index.h                             |   19 
 arch/x86/include/asm/nospec-branch.h                         |   64 
 arch/x86/include/asm/required-features.h                     |    3 
 arch/x86/include/asm/suspend_32.h                            |   10 
 arch/x86/include/asm/syscall.h                               |   10 
 arch/x86/include/asm/text-patching.h                         |   31 
 arch/x86/kernel/alternative.c                                |   56 
 arch/x86/kernel/cpu/amd.c                                    |   10 
 arch/x86/kernel/cpu/bugs.c                                   |  360 ++-
 arch/x86/kernel/cpu/common.c                                 |   77 
 arch/x86/kernel/cpu/mce/core.c                               |    4 
 arch/x86/kernel/cpu/scattered.c                              |    1 
 arch/x86/kernel/kprobes/core.c                               |   38 
 arch/x86/kernel/nmi.c                                        |    3 
 arch/x86/kernel/static_call.c                                |   50 
 arch/x86/kvm/cpuid.c                                         |   29 
 arch/x86/kvm/reverse_cpuid.h                                 |   47 
 arch/x86/kvm/svm/sev.c                                       |   16 
 arch/x86/kvm/vmx/run_flags.h                                 |    7 
 arch/x86/kvm/vmx/vmenter.S                                   |   11 
 arch/x86/kvm/vmx/vmx.c                                       |   12 
 arch/x86/kvm/x86.c                                           |   17 
 arch/x86/lib/retpoline.S                                     |    5 
 arch/x86/mm/ident_map.c                                      |   23 
 block/blk-settings.c                                         |    4 
 crypto/algboss.c                                             |    4 
 drivers/accessibility/speakup/synth.c                        |    4 
 drivers/acpi/acpica/dbnames.c                                |    8 
 drivers/acpi/cppc_acpi.c                                     |   27 
 drivers/ata/ahci.c                                           |    5 
 drivers/ata/sata_mv.c                                        |   63 
 drivers/ata/sata_sx4.c                                       |    6 
 drivers/base/core.c                                          |   26 
 drivers/base/cpu.c                                           |    8 
 drivers/base/power/wakeirq.c                                 |    4 
 drivers/clk/qcom/gcc-ipq6018.c                               |    2 
 drivers/clk/qcom/gcc-ipq8074.c                               |    2 
 drivers/clk/qcom/gcc-sdm845.c                                |    1 
 drivers/clk/qcom/mmcc-apq8084.c                              |    2 
 drivers/clk/qcom/mmcc-msm8974.c                              |    2 
 drivers/clocksource/arm_global_timer.c                       |    2 
 drivers/cpufreq/brcmstb-avs-cpufreq.c                        |    5 
 drivers/cpufreq/cpufreq-dt.c                                 |    2 
 drivers/crypto/qat/qat_common/adf_aer.c                      |   23 
 drivers/firmware/efi/vars.c                                  |   17 
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c               |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c                      |    1 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c            |    8 
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c           |   12 
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c          |    3 
 drivers/gpu/drm/drm_panel.c                                  |   17 
 drivers/gpu/drm/etnaviv/etnaviv_drv.c                        |    2 
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c                       |    9 
 drivers/gpu/drm/exynos/exynos_drm_vidi.c                     |    4 
 drivers/gpu/drm/exynos/exynos_hdmi.c                         |    4 
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c                  |    3 
 drivers/gpu/drm/i915/gt/intel_engine_pm.c                    |    3 
 drivers/gpu/drm/i915/gt/intel_execlists_submission.c         |    3 
 drivers/gpu/drm/imx/parallel-display.c                       |    4 
 drivers/gpu/drm/vc4/vc4_hdmi.c                               |    2 
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c                      |   14 
 drivers/hid/uhid.c                                           |   20 
 drivers/hwmon/amc6821.c                                      |   11 
 drivers/i2c/busses/i2c-i801.c                                |    4 
 drivers/infiniband/core/cm_trace.h                           |    2 
 drivers/infiniband/core/cma_trace.h                          |    2 
 drivers/iommu/dma-iommu.c                                    |   15 
 drivers/iommu/iova.c                                         |    5 
 drivers/md/dm-integrity.c                                    |    2 
 drivers/md/dm-raid.c                                         |    2 
 drivers/md/dm-snap.c                                         |    4 
 drivers/media/tuners/xc4000.c                                |    4 
 drivers/misc/mei/hw-me-regs.h                                |    2 
 drivers/misc/mei/pci-me.c                                    |    2 
 drivers/mmc/core/block.c                                     |   14 
 drivers/mmc/host/tmio_mmc_core.c                             |    2 
 drivers/mtd/nand/raw/meson_nand.c                            |    2 
 drivers/mtd/ubi/fastmap.c                                    |    7 
 drivers/mtd/ubi/vtbl.c                                       |    6 
 drivers/net/ethernet/freescale/fec_main.c                    |   11 
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h     |    8 
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h   |    8 
 drivers/net/ethernet/intel/i40e/i40e.h                       |    6 
 drivers/net/ethernet/intel/i40e/i40e_main.c                  |   14 
 drivers/net/ethernet/intel/i40e/i40e_ptp.c                   |    6 
 drivers/net/ethernet/intel/i40e/i40e_register.h              |    3 
 drivers/net/ethernet/intel/i40e/i40e_txrx.c                  |   82 
 drivers/net/ethernet/intel/i40e/i40e_txrx.h                  |    5 
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c           |   34 
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c               |   16 
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c              |    5 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c          |    2 
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c         |    2 
 drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c   |   31 
 drivers/net/ethernet/realtek/r8169_main.c                    |   11 
 drivers/net/ethernet/renesas/ravb_main.c                     |    8 
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c            |   40 
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c          |   38 
 drivers/net/ethernet/xilinx/ll_temac_main.c                  |    2 
 drivers/net/usb/asix.h                                       |    3 
 drivers/net/usb/asix_devices.c                               |   20 
 drivers/net/wireguard/netlink.c                              |   10 
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c  |    4 
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c                 |   12 
 drivers/net/xen-netfront.c                                   |    1 
 drivers/nvme/host/core.c                                     |    6 
 drivers/nvmem/meson-efuse.c                                  |   25 
 drivers/of/dynamic.c                                         |   12 
 drivers/pci/controller/dwc/pcie-designware-ep.c              |    7 
 drivers/pci/pci-driver.c                                     |   23 
 drivers/pci/pcie/dpc.c                                       |   15 
 drivers/pci/pcie/err.c                                       |   20 
 drivers/pci/quirks.c                                         |  100 
 drivers/pci/setup-res.c                                      |    8 
 drivers/phy/tegra/xusb.c                                     |   13 
 drivers/s390/crypto/zcrypt_api.c                             |    2 
 drivers/s390/net/qeth_core_main.c                            |   38 
 drivers/scsi/hosts.c                                         |    7 
 drivers/scsi/lpfc/lpfc_nvmet.c                               |    2 
 drivers/scsi/myrb.c                                          |   20 
 drivers/scsi/myrs.c                                          |   24 
 drivers/scsi/qla2xxx/qla_attr.c                              |   14 
 drivers/scsi/qla2xxx/qla_def.h                               |    2 
 drivers/scsi/qla2xxx/qla_gbl.h                               |    2 
 drivers/scsi/qla2xxx/qla_gs.c                                |    2 
 drivers/scsi/qla2xxx/qla_init.c                              |  128 -
 drivers/scsi/qla2xxx/qla_iocb.c                              |   68 
 drivers/scsi/qla2xxx/qla_mbx.c                               |    2 
 drivers/scsi/qla2xxx/qla_os.c                                |    2 
 drivers/scsi/qla2xxx/qla_target.c                            |   10 
 drivers/slimbus/core.c                                       |    4 
 drivers/soc/fsl/qbman/qman.c                                 |   98 
 drivers/staging/media/ipu3/ipu3-v4l2.c                       |   16 
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c        |    5 
 drivers/tee/optee/device.c                                   |    3 
 drivers/thermal/devfreq_cooling.c                            |    2 
 drivers/tty/serial/8250/8250_port.c                          |    6 
 drivers/tty/serial/fsl_lpuart.c                              |    7 
 drivers/tty/serial/imx.c                                     |   22 
 drivers/tty/serial/sc16is7xx.c                               |   15 
 drivers/tty/serial/serial_core.c                             |   12 
 drivers/tty/vt/vt.c                                          |    2 
 drivers/usb/class/cdc-wdm.c                                  |    6 
 drivers/usb/core/hub.c                                       |   23 
 drivers/usb/core/hub.h                                       |    2 
 drivers/usb/core/port.c                                      |    5 
 drivers/usb/core/sysfs.c                                     |   16 
 drivers/usb/dwc2/core.h                                      |   14 
 drivers/usb/dwc2/core_intr.c                                 |   72 
 drivers/usb/dwc2/gadget.c                                    |   10 
 drivers/usb/dwc2/hcd.c                                       |   49 
 drivers/usb/dwc2/hcd_ddma.c                                  |   17 
 drivers/usb/dwc2/hw.h                                        |    2 
 drivers/usb/dwc2/platform.c                                  |    2 
 drivers/usb/gadget/function/f_ncm.c                          |    2 
 drivers/usb/gadget/udc/core.c                                |    4 
 drivers/usb/gadget/udc/tegra-xudc.c                          |   39 
 drivers/usb/host/xhci.c                                      |    2 
 drivers/usb/phy/phy-generic.c                                |    7 
 drivers/usb/serial/cp210x.c                                  |    4 
 drivers/usb/serial/ftdi_sio.c                                |    2 
 drivers/usb/serial/ftdi_sio_ids.h                            |    6 
 drivers/usb/serial/option.c                                  |    6 
 drivers/usb/storage/isd200.c                                 |   23 
 drivers/usb/storage/scsiglue.c                               |    1 
 drivers/usb/storage/uas.c                                    |   81 
 drivers/usb/storage/usb.c                                    |    4 
 drivers/usb/typec/ucsi/ucsi.c                                |   42 
 drivers/usb/typec/ucsi/ucsi.h                                |    4 
 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c                       |    7 
 drivers/vfio/pci/vfio_pci_intrs.c                            |  176 -
 drivers/vfio/platform/vfio_platform_irq.c                    |  106 
 drivers/vfio/virqfd.c                                        |   21 
 drivers/xen/events/events_base.c                             |    5 
 fs/Kconfig                                                   |    2 
 fs/aio.c                                                     |    8 
 fs/btrfs/scrub.c                                             |   12 
 fs/btrfs/volumes.c                                           |    2 
 fs/cifs/connect.c                                            |    2 
 fs/exec.c                                                    |    1 
 fs/exportfs/expfs.c                                          |    8 
 fs/ext4/mballoc.c                                            |   17 
 fs/ext4/resize.c                                             |    3 
 fs/ext4/super.c                                              |   10 
 fs/fat/nfs.c                                                 |    6 
 fs/fuse/dir.c                                                |    4 
 fs/fuse/fuse_i.h                                             |    1 
 fs/fuse/inode.c                                              |    7 
 fs/ksmbd/smb2pdu.c                                           |   10 
 fs/lockd/host.c                                              |    2 
 fs/lockd/svc.c                                               |  217 --
 fs/lockd/svc4proc.c                                          |   29 
 fs/lockd/svclock.c                                           |   31 
 fs/lockd/svcproc.c                                           |   30 
 fs/lockd/svcsubs.c                                           |    4 
 fs/lockd/xdr.c                                               |  152 -
 fs/lockd/xdr4.c                                              |  153 -
 fs/locks.c                                                   |   85 
 fs/nfs/callback.c                                            |   96 
 fs/nfs/callback_xdr.c                                        |    5 
 fs/nfs/direct.c                                              |   11 
 fs/nfs/export.c                                              |    9 
 fs/nfs/nfs4state.c                                           |    2 
 fs/nfs/nfs4trace.h                                           |  477 ----
 fs/nfs/nfstrace.h                                            |  269 --
 fs/nfs/pnfs.h                                                |    4 
 fs/nfs/write.c                                               |    2 
 fs/nfsd/Kconfig                                              |   27 
 fs/nfsd/Makefile                                             |    8 
 fs/nfsd/acl.h                                                |    6 
 fs/nfsd/blocklayout.c                                        |    1 
 fs/nfsd/blocklayoutxdr.c                                     |    1 
 fs/nfsd/cache.h                                              |    2 
 fs/nfsd/export.h                                             |    1 
 fs/nfsd/filecache.c                                          | 1168 ++++++-----
 fs/nfsd/filecache.h                                          |   19 
 fs/nfsd/flexfilelayout.c                                     |    3 
 fs/nfsd/lockd.c                                              |    2 
 fs/nfsd/netns.h                                              |   34 
 fs/nfsd/nfs2acl.c                                            |   55 
 fs/nfsd/nfs3acl.c                                            |   85 
 fs/nfsd/nfs3proc.c                                           |  212 +
 fs/nfsd/nfs3xdr.c                                            |  444 +---
 fs/nfsd/nfs4acl.c                                            |   46 
 fs/nfsd/nfs4callback.c                                       |  125 -
 fs/nfsd/nfs4idmap.c                                          |    9 
 fs/nfsd/nfs4layouts.c                                        |    4 
 fs/nfsd/nfs4proc.c                                           |  986 +++++----
 fs/nfsd/nfs4recover.c                                        |   12 
 fs/nfsd/nfs4state.c                                          | 1041 +++++++--
 fs/nfsd/nfs4xdr.c                                            | 1115 +++++-----
 fs/nfsd/nfscache.c                                           |   63 
 fs/nfsd/nfsctl.c                                             |  146 -
 fs/nfsd/nfsd.h                                               |   35 
 fs/nfsd/nfsfh.c                                              |  270 +-
 fs/nfsd/nfsfh.h                                              |  145 -
 fs/nfsd/nfsproc.c                                            |  121 -
 fs/nfsd/nfssvc.c                                             |  263 +-
 fs/nfsd/nfsxdr.c                                             |  178 -
 fs/nfsd/state.h                                              |   59 
 fs/nfsd/stats.c                                              |   16 
 fs/nfsd/stats.h                                              |    4 
 fs/nfsd/trace.h                                              |  692 +++++-
 fs/nfsd/vfs.c                                                |  820 +++----
 fs/nfsd/vfs.h                                                |   56 
 fs/nfsd/xdr.h                                                |   35 
 fs/nfsd/xdr3.h                                               |   61 
 fs/nfsd/xdr4.h                                               |   81 
 fs/nfsd/xdr4cb.h                                             |    6 
 fs/nilfs2/btree.c                                            |    9 
 fs/nilfs2/direct.c                                           |    9 
 fs/nilfs2/inode.c                                            |    2 
 fs/notify/dnotify/dnotify.c                                  |   15 
 fs/notify/fanotify/fanotify.c                                |  361 ++-
 fs/notify/fanotify/fanotify.h                                |  212 +
 fs/notify/fanotify/fanotify_user.c                           |  441 +++-
 fs/notify/fdinfo.c                                           |   16 
 fs/notify/fsnotify.c                                         |  177 -
 fs/notify/fsnotify.h                                         |    4 
 fs/notify/group.c                                            |   36 
 fs/notify/inotify/inotify.h                                  |   11 
 fs/notify/inotify/inotify_fsnotify.c                         |    7 
 fs/notify/inotify/inotify_user.c                             |   53 
 fs/notify/mark.c                                             |  137 -
 fs/notify/notification.c                                     |   14 
 fs/open.c                                                    |   42 
 fs/pipe.c                                                    |   17 
 fs/ubifs/file.c                                              |   13 
 fs/vboxsf/super.c                                            |    3 
 include/asm-generic/vmlinux.lds.h                            |    4 
 include/linux/cpu.h                                          |    2 
 include/linux/device.h                                       |    1 
 include/linux/dma-map-ops.h                                  |    1 
 include/linux/dma-mapping.h                                  |    5 
 include/linux/dnotify.h                                      |    2 
 include/linux/exportfs.h                                     |   17 
 include/linux/fanotify.h                                     |   31 
 include/linux/fs.h                                           |   26 
 include/linux/fsnotify.h                                     |   70 
 include/linux/fsnotify_backend.h                             |  356 ++-
 include/linux/gfp.h                                          |    9 
 include/linux/hyperv.h                                       |   22 
 include/linux/iova.h                                         |    2 
 include/linux/kthread.h                                      |    1 
 include/linux/linkage.h                                      |    4 
 include/linux/lockd/lockd.h                                  |   10 
 include/linux/lockd/xdr.h                                    |   27 
 include/linux/lockd/xdr4.h                                   |   29 
 include/linux/minmax.h                                       |   17 
 include/linux/module.h                                       |    6 
 include/linux/nfs.h                                          |    8 
 include/linux/nfs4.h                                         |   17 
 include/linux/nfs_fs.h                                       |    1 
 include/linux/nfs_ssc.h                                      |    4 
 include/linux/pci.h                                          |    1 
 include/linux/phy/tegra/xusb.h                               |    1 
 include/linux/ring_buffer.h                                  |    1 
 include/linux/secretmem.h                                    |    4 
 include/linux/sunrpc/svc.h                                   |   93 
 include/linux/sunrpc/svc_xprt.h                              |   11 
 include/linux/sunrpc/svcsock.h                               |    7 
 include/linux/sunrpc/xdr.h                                   |    2 
 include/linux/timer.h                                        |   18 
 include/linux/udp.h                                          |   28 
 include/linux/vfio.h                                         |    2 
 include/net/cfg802154.h                                      |    1 
 include/net/inet_connection_sock.h                           |    1 
 include/net/sock.h                                           |    7 
 include/soc/fsl/qman.h                                       |    9 
 include/trace/events/rdma.h                                  |  168 -
 include/trace/events/rpcgss.h                                |   18 
 include/trace/events/rpcrdma.h                               |   44 
 include/trace/events/sunrpc.h                                |   74 
 include/trace/misc/fs.h                                      |  122 +
 include/trace/misc/nfs.h                                     |  387 +++
 include/trace/misc/rdma.h                                    |  168 +
 include/trace/misc/sunrpc.h                                  |   18 
 include/uapi/linux/fanotify.h                                |   29 
 include/uapi/linux/nfsd/nfsfh.h                              |  115 -
 init/initramfs.c                                             |    2 
 io_uring/io_uring.c                                          |    2 
 kernel/audit_fsnotify.c                                      |    8 
 kernel/audit_tree.c                                          |    2 
 kernel/audit_watch.c                                         |    5 
 kernel/bounds.c                                              |    2 
 kernel/bpf/verifier.c                                        |    5 
 kernel/dma/mapping.c                                         |   12 
 kernel/dma/swiotlb.c                                         |   11 
 kernel/entry/common.c                                        |    8 
 kernel/events/core.c                                         |    9 
 kernel/kthread.c                                             |   23 
 kernel/locking/rwsem.c                                       |   14 
 kernel/module.c                                              |    8 
 kernel/power/suspend.c                                       |    1 
 kernel/printk/printk.c                                       |   63 
 kernel/time/timer.c                                          |  164 -
 kernel/trace/ring_buffer.c                                   |  233 +-
 kernel/trace/trace.c                                         |   21 
 lib/Kconfig.debug                                            |    1 
 lib/pci_iomap.c                                              |    2 
 lib/test_kasan.c                                             |   21 
 mm/compaction.c                                              |    7 
 mm/memtest.c                                                 |    4 
 mm/migrate.c                                                 |    6 
 mm/page_alloc.c                                              |   10 
 mm/swapfile.c                                                |   25 
 mm/vmscan.c                                                  |    5 
 net/bluetooth/bnep/core.c                                    |    2 
 net/bluetooth/cmtp/core.c                                    |    2 
 net/bluetooth/hci_debugfs.c                                  |   48 
 net/bluetooth/hci_event.c                                    |   25 
 net/bluetooth/hidp/core.c                                    |    2 
 net/bridge/netfilter/ebtables.c                              |    6 
 net/core/skbuff.c                                            |    6 
 net/core/sock_map.c                                          |    6 
 net/ipv4/inet_connection_sock.c                              |   14 
 net/ipv4/ip_gre.c                                            |    5 
 net/ipv4/netfilter/arp_tables.c                              |    4 
 net/ipv4/netfilter/ip_tables.c                               |    4 
 net/ipv4/tcp.c                                               |    2 
 net/ipv4/udp.c                                               |    7 
 net/ipv4/udp_offload.c                                       |   20 
 net/ipv6/ip6_fib.c                                           |   14 
 net/ipv6/ip6_gre.c                                           |    3 
 net/ipv6/netfilter/ip6_tables.c                              |    4 
 net/ipv6/udp.c                                               |    2 
 net/ipv6/udp_offload.c                                       |    8 
 net/mac80211/cfg.c                                           |    5 
 net/mac802154/llsec.c                                        |   18 
 net/mptcp/protocol.c                                         |    3 
 net/mptcp/subflow.c                                          |    3 
 net/netfilter/nf_tables_api.c                                |   20 
 net/nfc/nci/core.c                                           |    5 
 net/rds/rdma.c                                               |    2 
 net/sched/act_skbmod.c                                       |   10 
 net/sunrpc/svc.c                                             |  227 --
 net/sunrpc/svc_xprt.c                                        |   68 
 net/sunrpc/svcsock.c                                         |   24 
 net/sunrpc/xdr.c                                             |   22 
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c                   |    2 
 net/xfrm/xfrm_user.c                                         |    3 
 scripts/Makefile.extrawarn                                   |    2 
 security/landlock/syscalls.c                                 |   18 
 security/smack/smack_lsm.c                                   |   12 
 sound/pci/hda/patch_realtek.c                                |    9 
 sound/sh/aica.c                                              |   17 
 sound/soc/codecs/rt5682-sdw.c                                |    4 
 sound/soc/codecs/rt711-sdca-sdw.c                            |    4 
 sound/soc/codecs/rt711-sdw.c                                 |    4 
 sound/soc/soc-ops.c                                          |    2 
 tools/objtool/check.c                                        |    3 
 tools/testing/selftests/mqueue/setting                       |    1 
 tools/testing/selftests/net/mptcp/diag.sh                    |    6 
 tools/testing/selftests/net/mptcp/mptcp_connect.sh           |    7 
 tools/testing/selftests/net/reuseaddr_conflict.c             |    2 
 tools/testing/selftests/net/udpgro_fwd.sh                    |   10 
 virt/kvm/async_pf.c                                          |   31 
 446 files changed, 12088 insertions(+), 7026 deletions(-)

Al Viro (2):
      nfsd_splice_actor(): handle compound pages
      fs/notify: constify path

Alan Stern (3):
      USB: usb-storage: Prevent divide-by-0 error in isd200_ata_command
      USB: core: Add hub_get() and hub_put() routines
      USB: core: Fix deadlock in usb_deauthorize_interface()

Aleksandr Loktionov (2):
      i40e: fix i40e_count_filters() to count only active/new filters
      i40e: fix vf may be used uninitialized in this function warning

Alex Williamson (7):
      vfio/platform: Disable virqfds on cleanup
      vfio/pci: Disable auto-enable of exclusive INTx IRQ
      vfio/pci: Lock external INTx masking ops
      vfio: Introduce interface to flush virqfd inject workqueue
      vfio/pci: Create persistent INTx handler
      vfio/platform: Create persistent IRQ handlers
      vfio/fsl-mc: Block calling interrupt handler without trigger

Alexander Aring (1):
      lockd: introduce safe async lock op

Alexander Stein (1):
      Revert "usb: phy: generic: Get the vbus supply"

Alexander Usyskin (2):
      mei: me: add arrow lake point S DID
      mei: me: add arrow lake point H DID

Alexandra Winter (1):
      s390/qeth: handle deferred cc1

Amir Goldstein (37):
      fsnotify: pass data_type to fsnotify_name()
      fsnotify: pass dentry instead of inode data
      fsnotify: clarify contract for create event hooks
      fsnotify: clarify object type argument
      fsnotify: separate mark iterator type from object type enum
      fanotify: introduce group flag FAN_REPORT_TARGET_FID
      fsnotify: generate FS_RENAME event with rich information
      fanotify: use macros to get the offset to fanotify_info buffer
      fanotify: use helpers to parcel fanotify_info buffer
      fanotify: support secondary dir fh and name in fanotify_info
      fanotify: record old and new parent and name in FAN_RENAME event
      fanotify: record either old name new name or both for FAN_RENAME
      fanotify: report old and/or new parent+name in FAN_RENAME event
      fanotify: wire up FAN_RENAME event
      fsnotify: invalidate dcache before IN_DELETE event
      fsnotify: fix merge with parent's ignored mask
      fsnotify: optimize FS_MODIFY events with no ignored masks
      fanotify: do not allow setting dirent events in mask of non-dir
      inotify: move control flags from mask to mark flags
      fsnotify: pass flags argument to fsnotify_alloc_group()
      fsnotify: make allow_dups a property of the group
      fsnotify: create helpers for group mark_mutex lock
      inotify: use fsnotify group lock helpers
      nfsd: use fsnotify group lock helpers
      dnotify: use fsnotify group lock helpers
      fsnotify: allow adding an inode mark without pinning inode
      fanotify: create helper fanotify_mark_user_flags()
      fanotify: factor out helper fanotify_mark_update_flags()
      fanotify: implement "evictable" inode marks
      fanotify: use fsnotify group lock helpers
      fanotify: enable "evictable" inode marks
      fsnotify: introduce mark type iterator
      fsnotify: consistent behavior for parent not watching children
      fanotify: refine the validation checks on non-dir inode mask
      fanotify: prepare for setting event flags in ignore mask
      fanotify: cleanups for fanotify_mark() input validations
      fanotify: introduce FAN_MARK_IGNORE

Amit Pundir (1):
      clk: qcom: gcc-sdm845: Add soft dependency on rpmhpd

Andrei Matei (1):
      bpf: Protect against int overflow for stack access size

Andrey Jr. Melnikov (1):
      ahci: asm1064: correct count of reported ports

André Rösti (1):
      entry: Respect changes to system call number by trace_sys_enter()

Anna Schumaker (1):
      NFSD: Simplify READ_PLUS

Antoine Tenart (5):
      selftests: net: gro fwd: update vxlan GRO test expectations
      udp: do not accept non-tunnel GSO skbs landing in a tunnel
      udp: do not transition UDP GRO fraglist partial checksums to unnecessary
      udp: prevent local UDP tunnel packets from being GROed
      gro: fix ownership transfer

Anton Altaparmakov (1):
      x86/pm: Work around false positive kmemleak report in msr_build_context()

Arnd Bergmann (6):
      kasan/test: avoid gcc warning for intentional overflow
      staging: vc04_services: changen strncpy() to strscpy_pad()
      dm integrity: fix out-of-range warning
      ata: sata_sx4: fix pdc20621_get_from_dimm() on 64-bit
      scsi: mylex: Fix sysfs buffer lengths
      ata: sata_mv: Fix PCI device ID table declaration compilation warning

Arseniy Krasnov (1):
      mtd: rawnand: meson: fix scrambling mode value in command macro

Aurélien Jacobs (1):
      USB: serial: option: add MeiG Smart SLM320 product

Bang Li (1):
      fsnotify: remove redundant parameter judgment

Baokun Li (1):
      ext4: correct best extent lstart adjustment logic

Bart Van Assche (3):
      fs/aio: Check IOCB_AIO_RW before the struct aio_kiocb conversion
      scsi: usb: Call scsi_done() directly
      scsi: usb: Stop using the SCSI pointer

Bastien Nocera (1):
      Bluetooth: Fix TOCTOU in HCI debugfs implementation

Benjamin Coddington (1):
      NLM: Defend against file_lock changes after vfs_test_lock()

Bikash Hazarika (2):
      scsi: qla2xxx: Update manufacturer details
      scsi: qla2xxx: Update manufacturer detail

Bixuan Cui (1):
      iwlwifi: mvm: rfi: use kmemdup() to replace kzalloc + memcpy

Bjorn Helgaas (1):
      PCI: Work around Intel I210 ROM BAR overlap defect

Borislav Petkov (1):
      x86/bugs: Use sysfs_emit()

Borislav Petkov (AMD) (4):
      x86/CPU/AMD: Update the Zenbleed microcode revisions
      x86/mce: Make sure to grab mce_sysfs_mutex in set_bank()
      x86/bugs: Fix the SRSO mitigation on Zen3/4
      x86/retpoline: Do the necessary fixup to the Zen3/4 srso return thunk for !SRSO

Cameron Williams (1):
      USB: serial: add device ID for VeriFone adapter

Changcheng Deng (1):
      NFSD:fix boolreturn.cocci warning

ChenXiaoSong (5):
      nfsd: use DEFINE_PROC_SHOW_ATTRIBUTE to define nfsd_proc_ops
      nfsd: use DEFINE_SHOW_ATTRIBUTE to define export_features_fops and supported_enctypes_fops
      nfsd: use DEFINE_SHOW_ATTRIBUTE to define client_info_fops
      nfsd: use DEFINE_SHOW_ATTRIBUTE to define nfsd_reply_cache_stats_fops
      nfsd: use DEFINE_SHOW_ATTRIBUTE to define nfsd_file_cache_stats_fops

Chris Wilson (1):
      drm/i915/gt: Reset queue_priority_hint on parking

Christian A. Ehrhardt (2):
      usb: typec: ucsi: Ack unsupported commands
      usb: typec: ucsi: Clear UCSI_CCI_RESET_COMPLETE before reset

Christian Gmeiner (1):
      drm/etnaviv: Restore some id values

Christian Häggström (1):
      USB: serial: cp210x: add ID for MGP Instruments PDS100

Christophe JAILLET (4):
      slimbus: core: Remove usage of the deprecated ida_simple_xx() API
      nfsd: Avoid some useless tests
      nfsd: Propagate some error code returned by memdup_user()
      vboxsf: Avoid an spurious warning if load_nls_xxx() fails

Chuck Lever (155):
      NFS: Remove unnecessary TRACE_DEFINE_ENUM()s
      SUNRPC: Tracepoints should display tk_pid and cl_clid as a fixed-size field
      NFS: Move generic FS show macros to global header
      NFS: Move NFS protocol display macros to global header
      NFSD: Optimize DRC bucket pruning
      SUNRPC: Replace the "__be32 *p" parameter to .pc_decode
      SUNRPC: Change return value type of .pc_decode
      NFSD: Save location of NFSv4 COMPOUND status
      SUNRPC: Replace the "__be32 *p" parameter to .pc_encode
      SUNRPC: Change return value type of .pc_encode
      NFSD: Remove be32_to_cpu() from DRC hash function
      NFSD: Combine XDR error tracepoints
      NFSD: De-duplicate nfsd4_decode_bitmap4()
      NFSD: Clean up nfsd_vfs_write()
      NFSD: De-duplicate net_generic(SVC_NET(rqstp), nfsd_net_id)
      NFSD: Write verifier might go backwards
      NFSD: Clean up the nfsd_net::nfssvc_boot field
      NFSD: Rename boot verifier functions
      NFSD: Trace boot verifier resets
      NFSD: Move fill_pre_wcc() and fill_post_wcc()
      NFSD: Deprecate NFS_OFFSET_MAX
      orDate: Thu Sep 30 19:19:57 2021 -0400
      NFSD: Skip extra computation for RC_NOCACHE case
      NFSD: Streamline the rare "found" case
      NFSD: Remove NFSD_PROC_ARGS_* macros
      SUNRPC: Remove the .svo_enqueue_xprt method
      SUNRPC: Merge svc_do_enqueue_xprt() into svc_enqueue_xprt()
      SUNRPC: Remove svo_shutdown method
      SUNRPC: Rename svc_create_xprt()
      SUNRPC: Rename svc_close_xprt()
      SUNRPC: Remove svc_shutdown_net()
      NFSD: Remove svc_serv_ops::svo_module
      NFSD: Move svc_serv_ops::svo_function into struct svc_serv
      NFSD: Remove CONFIG_NFSD_V3
      NFSD: Clean up _lm_ operation names
      NFSD: Clean up nfsd_splice_actor()
      NFSD: Clean up nfsd3_proc_create()
      NFSD: Avoid calling fh_drop_write() twice in do_nfsd_create()
      NFSD: Refactor nfsd_create_setattr()
      NFSD: Refactor NFSv3 CREATE
      NFSD: Refactor NFSv4 OPEN(CREATE)
      NFSD: Remove do_nfsd_create()
      NFSD: Clean up nfsd_open_verified()
      NFSD: Instantiate a struct file when creating a regular NFSv4 file
      NFSD: Remove dprintk call sites from tail of nfsd4_open()
      NFSD: Fix whitespace
      NFSD: Move documenting comment for nfsd4_process_open2()
      NFSD: Trace filecache opens
      SUNRPC: Use RMW bitops in single-threaded hot paths
      NFSD: Modernize nfsd4_release_lockowner()
      NFSD: Add documenting comment for nfsd4_release_lockowner()
      NFSD: nfsd_file_put() can sleep
      NFSD: Fix potential use-after-free in nfsd_file_put()
      NFSD: Decode NFSv4 birth time attribute
      NFSD: Instrument fh_verify()
      NFSD: Demote a WARN to a pr_warn()
      NFSD: Report filecache LRU size
      NFSD: Report count of calls to nfsd_file_acquire()
      NFSD: Report count of freed filecache items
      NFSD: Report average age of filecache items
      NFSD: Add nfsd_file_lru_dispose_list() helper
      NFSD: Refactor nfsd_file_gc()
      NFSD: Refactor nfsd_file_lru_scan()
      NFSD: Report the number of items evicted by the LRU walk
      NFSD: Record number of flush calls
      NFSD: Zero counters when the filecache is re-initialized
      NFSD: Hook up the filecache stat file
      NFSD: WARN when freeing an item still linked via nf_lru
      NFSD: Trace filecache LRU activity
      NFSD: Leave open files out of the filecache LRU
      NFSD: Fix the filecache LRU shrinker
      NFSD: Never call nfsd_file_gc() in foreground paths
      NFSD: No longer record nf_hashval in the trace log
      NFSD: Remove lockdep assertion from unhash_and_release_locked()
      NFSD: nfsd_file_unhash can compute hashval from nf->nf_inode
      NFSD: Refactor __nfsd_file_close_inode()
      NFSD: nfsd_file_hash_remove can compute hashval
      NFSD: Remove nfsd_file::nf_hashval
      NFSD: Replace the "init once" mechanism
      NFSD: Set up an rhashtable for the filecache
      NFSD: Convert the filecache to use rhashtable
      NFSD: Clean up unused code after rhashtable conversion
      NFSD: Separate tracepoints for acquire and create
      NFSD: Move nfsd_file_trace_alloc() tracepoint
      NFSD: NFSv4 CLOSE should release an nfsd_file immediately
      NFSD: Ensure nf_inode is never dereferenced
      NFSD: Optimize nfsd4_encode_operation()
      NFSD: Optimize nfsd4_encode_fattr()
      NFSD: Clean up SPLICE_OK in nfsd4_encode_read()
      NFSD: Add an nfsd4_read::rd_eof field
      NFSD: Optimize nfsd4_encode_readv()
      NFSD: Simplify starting_len
      NFSD: Use xdr_pad_size()
      NFSD: Clean up nfsd4_encode_readlink()
      NFSD: Fix strncpy() fortify warning
      NFSD: nfserrno(-ENOMEM) is nfserr_jukebox
      NFSD: Shrink size of struct nfsd4_copy_notify
      NFSD: Shrink size of struct nfsd4_copy
      NFSD: Reorder the fields in struct nfsd4_op
      NFSD: Make nfs4_put_copy() static
      NFSD: Replace boolean fields in struct nfsd4_copy
      NFSD: Refactor nfsd4_cleanup_inter_ssc() (1/2)
      NFSD: Refactor nfsd4_cleanup_inter_ssc() (2/2)
      NFSD: Refactor nfsd4_do_copy()
      NFSD: Remove kmalloc from nfsd4_do_async_copy()
      NFSD: Add nfsd4_send_cb_offload()
      NFSD: Move copy offload callback arguments into a separate structure
      NFSD: Increase NFSD_MAX_OPS_PER_COMPOUND
      NFSD: Replace dprintk() call site in fh_verify()
      NFSD: Trace NFSv4 COMPOUND tags
      NFSD: Add tracepoints to report NFSv4 callback completions
      NFSD: Add a mechanism to wait for a DELEGRETURN
      NFSD: Refactor nfsd_setattr()
      NFSD: Make nfsd4_setattr() wait before returning NFS4ERR_DELAY
      NFSD: Make nfsd4_rename() wait before returning NFS4ERR_DELAY
      NFSD: Make nfsd4_remove() wait before returning NFS4ERR_DELAY
      SUNRPC: Parametrize how much of argsize should be zeroed
      NFSD: Reduce amount of struct nfsd4_compoundargs that needs clearing
      NFSD: Refactor common code out of dirlist helpers
      NFSD: Use xdr_inline_decode() to decode NFSv3 symlinks
      NFSD: Clean up WRITE arg decoders
      NFSD: Clean up nfs4svc_encode_compoundres()
      NFSD: Remove "inline" directives on op_rsize_bop helpers
      NFSD: Remove unused nfsd4_compoundargs::cachetype field
      NFSD: Pack struct nfsd4_compoundres
      NFSD: Rename the fields in copy_stateid_t
      NFSD: Cap rsize_bop result based on send buffer size
      NFSD: Fix trace_nfsd_fh_verify_err() crasher
      NFSD: Fix reads with a non-zero offset that don't end on a page boundary
      NFSD: Finish converting the NFSv3 GETACL result encoder
      NFSD: Pass the target nfsd_file to nfsd_commit()
      NFSD: Revert "NFSD: NFSv4 CLOSE should release an nfsd_file immediately"
      NFSD: Add an NFSD_FILE_GC flag to enable nfsd_file garbage collection
      NFSD: Flesh out a documenting comment for filecache.c
      NFSD: Clean up nfs4_preprocess_stateid_op() call sites
      NFSD: Trace stateids returned via DELEGRETURN
      NFSD: Trace delegation revocations
      NFSD: Use const pointers as parameters to fh_ helpers
      NFSD: Update file_hashtbl() helpers
      NFSD: Clean up nfsd4_init_file()
      NFSD: Add a nfsd4_file_hash_remove() helper
      NFSD: Clean up find_or_add_file()
      NFSD: Refactor find_file()
      NFSD: Use rhashtable for managing nfs4_file objects
      NFSD: Fix licensing header in filecache.c
      NFSD: Add an nfsd_file_fsync tracepoint
      trace: Relocate event helper files
      NFSD: Use only RQ_DROPME to signal the need to drop a reply
      Revert "SUNRPC: Use RMW bitops in single-threaded hot paths"
      NFSD: Use set_bit(RQ_DROPME)
      NFSD: copy the whole verifier in nfsd_copy_write_verifier
      NFSD: Protect against filesystem freezing
      NFSD: Convert filecache to rhltable
      NFSD: Add an nfsd4_encode_nfstime4() helper
      Documentation: Add missing documentation for EXPORT_OP flags

Claus Hansen Ries (1):
      net: ll_temac: platform_get_resource replaced by wrong function

Colin Ian King (3):
      NFSD: Initialize pointer ni with NULL and not plain integer 0
      nfsd: remove redundant assignment to variable len
      NFSD: Remove redundant assignment to variable host_err

Conrad Kostecki (1):
      ahci: asm1064: asm1166: don't limit reported ports

Dai Ngo (23):
      fs/lock: documentation cleanup. Replace inode->i_lock with flc_lock.
      NFSD: add courteous server support for thread with only delegation
      NFSD: add support for share reservation conflict to courteous server
      NFSD: move create/destroy of laundry_wq to init_nfsd and exit_nfsd
      fs/lock: add helper locks_owner_has_blockers to check for blockers
      fs/lock: add 2 callbacks to lock_manager_operations to resolve conflict
      NFSD: add support for lock conflict to courteous server
      NFSD: Show state of courtesy client in client info
      NFSD: refactoring v4 specific code to a helper in nfs4state.c
      NFSD: keep track of the number of v4 clients in the system
      NFSD: limit the number of v4 clients to 1024 per 1GB of system memory
      NFSD: keep track of the number of courtesy clients in the system
      NFSD: add shrinker to reap courtesy clients on low memory condition
      NFSD: refactoring courtesy_client_reaper to a generic low memory shrinker
      NFSD: add support for sending CB_RECALL_ANY
      NFSD: add delegation reaper to react to low memory condition
      NFSD: add CB_RECALL_ANY tracepoints
      NFSD: register/unregister of nfsd-client shrinker at nfsd startup/shutdown time
      NFSD: replace delayed_work with work_struct for nfsd_client_shrinker
      NFSD: enhance inter-server copy cleanup
      NFSD: fix leaked reference count of nfsd4_ssc_umount_item
      NFSD: fix problems with cleanup on errors in nfsd4_copy
      NFSD: Fix problem of COMMIT and NFS4ERR_DELAY in infinite loop

Damian Muszynski (1):
      crypto: qat - resolve race condition during AER recovery

Damien Le Moal (1):
      block: Clear zone limits for a non-zoned stacked queue

Dan Carpenter (2):
      nfsd: fix double fget() bug in __write_ports_addfd()
      staging: vc04_services: fix information leak in create_component()

Daniel Sneddon (2):
      x86/bhi: Define SPEC_CTRL_BHI_DIS_S
      KVM: x86: Add BHI_NO

Daniel Vogelbacher (1):
      USB: serial: ftdi_sio: add support for GMC Z216C Adapter IR-USB

David Disseldorp (1):
      exportfs: use pr_debug for unreachable debug statements

David Hildenbrand (1):
      mm/secretmem: fix GUP-fast succeeding on secretmem folios

David Laight (1):
      minmax: add umin(a, b) and umax(a, b)

David Thompson (3):
      mlxbf_gige: stop PHY during open() error paths
      mlxbf_gige: call request_irq() after NAPI initialized
      mlxbf_gige: stop interface during shutdown

Davide Caratti (1):
      mptcp: don't account accept() of non-MPC client as fallback to TCP

Denis Kirjanov (1):
      drivers: net: convert to boolean for the mac_managed_pm flag

Dominique Martinet (1):
      mmc: core: Fix switch on gp3 partition

Duje Mihanović (1):
      arm: dts: marvell: Fix maxium->maxim typo in brownstone dts

Duoming Zhou (1):
      ALSA: sh: aica: reorder cleanup operations to avoid UAF bugs

Eric Dumazet (4):
      tcp: properly terminate timers for kernel sockets
      netfilter: validate user input for expected length
      net/sched: act_skbmod: prevent kernel-infoleak
      erspan: make sure erspan_base_hdr is present in skb->head

Eric W. Biederman (2):
      exit: Implement kthread_exit
      exit: Rename module_put_and_exit to module_put_and_kthread_exit

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

Gabriel Krisman Bertazi (27):
      fsnotify: Don't insert unmergeable events in hashtable
      fanotify: Fold event size calculation to its own function
      fanotify: Split fsid check from other fid mode checks
      inotify: Don't force FS_IN_IGNORED
      fsnotify: Add helper to detect overflow_event
      fsnotify: Add wrapper around fsnotify_add_event
      fsnotify: Retrieve super block from the data field
      fsnotify: Protect fsnotify_handle_inode_event from no-inode events
      fsnotify: Pass group argument to free_event
      fanotify: Support null inode event in fanotify_dfid_inode
      fanotify: Allow file handle encoding for unhashed events
      fanotify: Encode empty file handle when no inode is provided
      fanotify: Require fid_mode for any non-fd event
      fsnotify: Support FS_ERROR event type
      fanotify: Reserve UAPI bits for FAN_FS_ERROR
      fanotify: Pre-allocate pool of error events
      fanotify: Support enqueueing of error events
      fanotify: Support merging of error events
      fanotify: Wrap object_fh inline space in a creator macro
      fanotify: Add helpers to decide whether to report FID/DFID
      fanotify: WARN_ON against too large file handles
      fanotify: Report fid info for file related file system errors
      fanotify: Emit generic error info for error event
      fanotify: Allow users to request FAN_FS_ERROR events
      ext4: Send notifications on error
      docs: Document the FAN_FS_ERROR event
      ext4: fix error code saved on super block during file system abort

Gaosheng Cui (3):
      nfsd: remove nfsd4_prepare_cb_recall() declaration
      fsnotify: remove unused declaration
      fanotify: Remove obsoleted fanotify_event_has_path()

Geert Uytterhoeven (1):
      net: ravb: Add R-Car Gen4 support

Geliang Tang (1):
      selftests: mptcp: diag: return KSFT_FAIL not test_cnt

Gokul krishna Krishnakumar (1):
      locking/rwsem: Disable preemption while trying for rwsem lock

Greg Kroah-Hartman (3):
      cpufreq: brcmstb-avs-cpufreq: fix up "add check for cpufreq_cpu_get's return value"
      x86: set SPECTRE_BHI_ON as default
      Linux 5.15.154

Guenter Roeck (4):
      parisc: Fix ip_fast_csum
      parisc: Fix csum_ipv6_magic on 32-bit systems
      parisc: Fix csum_ipv6_magic on 64-bit systems
      parisc: Strip upper 32 bit of sum in csum_ipv6_magic for 64-bit builds

Gui-Dong Han (1):
      media: xc4000: Fix atomicity violation in xc4000_get_frequency

Guilherme G. Piccoli (1):
      scsi: core: Fix unremoved procfs host directory regression

H. Peter Anvin (Intel) (1):
      x86/asm: Add _ASM_RIP() macro for x86-64 (%rip) suffix

Harald Freudenberger (1):
      s390/zcrypt: fix reference counting on zcrypt card objects

Hariprasad Kelam (2):
      Octeontx2-af: fix pause frame configuration in GMP mode
      octeontx2-af: Fix issue with loading coalesced KPU profiles

Heiner Kallweit (2):
      i2c: i801: Avoid potential double call to gpiod_remove_lookup_table
      r8169: fix issue caused by buggy BIOS on certain boards with RTL8168d

Herve Codina (2):
      driver core: Introduce device_link_wait_removal()
      of: dynamic: Synchronize of_changeset_destroy() with the devlink removals

Hidenori Kobayashi (1):
      media: staging: ipu3-imgu: Set fields before media_entity_pads_init()

Huang Ying (1):
      swap: comments get_swap_device() with usage rule

Hugo Villeneuve (1):
      serial: sc16is7xx: convert from _raw_ to _noinc_ regmap functions for FIFO

Hui Wang (1):
      Bluetooth: hci_event: set the conn encrypted before conn establishes

I Gede Agastya Darma Laksana (1):
      ALSA: hda/realtek: Update Panasonic CF-SZ6 quirk to support headset with microphone

Ingo Molnar (1):
      Revert "x86/mm/ident_map: Use gbpages only where full GB page should be mapped."

Ivan Vecera (2):
      i40e: Remove _t suffix from enum type names
      i40e: Enforce software interrupt during busy-poll exit

J. Bruce Fields (4):
      nfsd: update create verifier comment
      nfsd4: remove obselete comment
      nfsd: improve stateid access bitmask documentation
      nfs: block notification on fs with its own ->lock

Jakob Koschel (1):
      nfsd: fix using the correct variable for sizeof()

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

Jann Horn (3):
      HID: uhid: Use READ_ONCE()/WRITE_ONCE() for ->running
      openrisc: Fix pagewalk usage in arch_dma_{clear, set}_uncached
      fs/pipe: Fix lockdep false-positive in watchqueue pipe_write()

Jarred White (1):
      ACPI: CPPC: Use access_width over bit_width for system memory accesses

Jason A. Donenfeld (2):
      wireguard: netlink: check for dangling peer via is_dead instead of empty list
      wireguard: netlink: access device through ctx instead of peer

Jeff Layton (52):
      nfsd: Add errno mapping for EREMOTEIO
      nfsd: Retry once in nfsd_open on an -EOPENSTALE return
      nfsd: silence extraneous printk on nfsd.ko insertion
      NFSD: drop fh argument from alloc_init_deleg
      NFSD: verify the opened dentry after setting a delegation
      nfsd: clean up mounted_on_fileid handling
      nfsd: only fill out return pointer on success in nfsd4_lookup_stateid
      nfsd: fix comments about spinlock handling with delegations
      nfsd: make nfsd4_run_cb a bool return function
      nfsd: extra checks when freeing delegation stateids
      nfsd: fix nfsd_file_unhash_and_dispose
      nfsd: rework hashtable handling in nfsd_do_file_acquire
      nfsd: ensure we always call fh_verify_error tracepoint
      nfsd: fix net-namespace logic in __nfsd_file_cache_purge
      nfsd: fix use-after-free in nfsd_file_do_acquire tracepoint
      nfsd: put the export reference in nfsd4_verify_deleg_dentry
      lockd: use locks_inode_context helper
      nfsd: use locks_inode_context helper
      nfsd: ignore requests to disable unsupported versions
      nfsd: move nfserrno() to vfs.c
      nfsd: allow disabling NFSv2 at compile time
      nfsd: remove the pages_flushed statistic from filecache
      nfsd: reorganize filecache.c
      filelock: add a new locks_inode_context accessor function
      nfsd: fix up the filecache laundrette scheduling
      nfsd: return error if nfs4_setacl fails
      lockd: set missing fl_flags field when retrieving args
      lockd: ensure we use the correct file descriptor when unlocking
      lockd: fix file selection in nlmsvc_cancel_blocked
      nfsd: rework refcounting in filecache
      nfsd: fix handling of cached open files in nfsd4_open codepath
      nfsd: don't free files unconditionally in __nfsd_file_cache_purge
      nfsd: don't destroy global nfs4_file table in per-net shutdown
      nfsd: allow nfsd_file_get to sanely handle a NULL pointer
      nfsd: clean up potential nfsd_file refcount leaks in COPY codepath
      nfsd: don't hand out delegation on setuid files being opened for write
      nfsd: fix courtesy client with deny mode handling in nfs4_upgrade_open
      nfsd: don't fsync nfsd_files on last close
      nfsd: don't replace page in rq_pages if it's a continuation of last page
      nfsd: call op_release, even when op_func returns an error
      nfsd: don't open-code clear_and_wake_up_bit
      nfsd: NFSD_FILE_KEY_INODE only needs to find GC'ed entries
      nfsd: simplify test_bit return in NFSD_FILE_KEY_FULL comparator
      nfsd: don't kill nfsd_files because of lease break error
      nfsd: add some comments to nfsd_file_do_acquire
      nfsd: don't take/put an extra reference when putting a file
      nfsd: update comment over __nfsd_file_cache_purge
      nfsd: allow reaping files still under writeback
      nfsd: simplify the delayed disposal list code
      nfsd: make a copy of struct iattr before calling notify_change
      nfsd: drop the nfsd_put helper
      nfsd: hold a lighter-weight client reference over CB_RECALL_ANY

Jens Axboe (1):
      io_uring: ensure '0' is returned on file registration success

Jerome Brunet (1):
      nvmem: meson-efuse: fix function pointer type mismatch

Jesper Dangaard Brouer (1):
      xen-netfront: Add missing skb_mark_for_recycle

Jiapeng Chong (1):
      NFSD: Fix inconsistent indenting

Jim Mattson (2):
      KVM: x86: Advertise CPUID.(EAX=7,ECX=2):EDX[5:0] to userspace
      KVM: x86: Use a switch statement and macros in __feature_translate()

Jinpeng Cui (1):
      NFSD: remove redundant variable status

Joe Damato (1):
      i40e: Store the irq number in i40e_q_vector

Johan Hovold (1):
      arm64: dts: qcom: sc7180-trogdor: mark bluetooth address as broken

Johannes Berg (1):
      wifi: iwlwifi: mvm: rfi: fix potential response leaks

Johannes Thumshirn (1):
      btrfs: zoned: use zone aware sb location for scrub

John David Anglin (1):
      parisc: Avoid clobbering the C/B bits in the PSW with tophys and tovirt macros

John Garry (2):
      dma-mapping: add dma_opt_mapping_size()
      dma-iommu: add iommu_dma_opt_mapping_size()

John Ogness (1):
      printk: Update @console_may_schedule in console_trylock_spinning()

John Sperbeck (1):
      init: open /initrd.image with O_LARGEFILE

Josef Bacik (1):
      nfs: fix UAF in direct writes

Josh Poimboeuf (1):
      x86/bugs: Change commas to semicolons in 'spectre_v2' sysfs file

Josua Mayer (1):
      hwmon: (amc6821) add of_match table

Kailang Yang (1):
      ALSA: hda/realtek - Fix headset Mic no show at resume back for Lenovo ALC897 platform

Kees Cook (1):
      NFSD: Avoid clashing function prototypes

Kim Phillips (2):
      x86/cpu: Support AMD Automatic IBRS
      x86/cpu: Enable STIBP on AMD if Automatic IBRS is enabled

Krishna Kurapati (1):
      usb: gadget: ncm: Fix handling of zero block length packets

Kuniyuki Iwashima (1):
      ipv6: Fix infinite recursion in fib6_dump_done().

Leo Ma (1):
      drm/amd/display: Fix noise issue on HDMI AV mute

Lin Yujun (1):
      Documentation/hw-vuln: Update spectre doc

Linus Torvalds (1):
      x86/syscall: Don't force use of indirect calls for system calls

Mahmoud Adam (1):
      net/rds: fix possible cp null dereference

Marek Szyprowski (1):
      cpufreq: dt: always allocate zeroed cpumask

Marios Makassikis (1):
      ksmbd: retrieve number of blocks using vfs_getattr in set_file_allocation_info

Martin Blumenstingl (1):
      clocksource/drivers/arm_global_timer: Fix maximum prescaler value

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

Mickaël Salaün (1):
      landlock: Warn once if a Landlock action is requested while disabled

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

Minas Harutyunyan (5):
      usb: dwc2: host: Fix remote wakeup from hibernation
      usb: dwc2: host: Fix hibernation flow
      usb: dwc2: host: Fix ISOC flow in DDMA mode
      usb: dwc2: gadget: Fix exiting from clock gating
      usb: dwc2: gadget: LPM flow fix

Muhammad Usama Anjum (1):
      scsi: lpfc: Correct size for wqe for memset()

Nathan Chancellor (4):
      kbuild: Move -Wenum-{compare-conditional,enum-conversion} into W=1
      xfrm: Avoid clang fortify warning in copy_to_user_tmpl()
      powerpc: xor_vmx: Add '-mhard-float' to CFLAGS
      hexagon: vmlinux.lds.S: handle attributes section

NeilBrown (46):
      NFSD: move filehandle format declarations out of "uapi".
      NFSD: drop support for ancient filehandles
      NFSD: simplify struct nfsfh
      NFSD: handle errors better in write_ports_addfd()
      SUNRPC: change svc_get() to return the svc.
      SUNRPC/NFSD: clean up get/put functions.
      SUNRPC: stop using ->sv_nrthreads as a refcount
      nfsd: make nfsd_stats.th_cnt atomic_t
      SUNRPC: use sv_lock to protect updates to sv_nrthreads.
      NFSD: narrow nfsd_mutex protection in nfsd thread
      NFSD: Make it possible to use svc_set_num_threads_sync
      SUNRPC: discard svo_setup and rename svc_set_num_threads_sync()
      NFSD: simplify locking for network notifier.
      lockd: introduce nlmsvc_serv
      lockd: simplify management of network status notifiers
      lockd: move lockd_start_svc() call into lockd_create_svc()
      lockd: move svc_exit_thread() into the thread
      lockd: introduce lockd_put()
      lockd: rename lockd_create_svc() to lockd_get()
      SUNRPC: move the pool_map definitions (back) into svc.c
      SUNRPC: always treat sv_nrpools==1 as "not pooled"
      lockd: use svc_set_num_threads() for thread start and stop
      NFS: switch the callback service back to non-pooled.
      NFSD: simplify per-net file cache management
      NFS: restore module put when manager exits.
      NFSD: introduce struct nfsd_attrs
      NFSD: set attributes when creating symlinks
      NFSD: add security label to struct nfsd_attrs
      NFSD: add posix ACLs to struct nfsd_attrs
      NFSD: change nfsd_create()/nfsd_symlink() to unlock directory before returning.
      NFSD: always drop directory lock in nfsd_unlink()
      NFSD: only call fh_unlock() once in nfsd_link()
      NFSD: reduce locking in nfsd_lookup()
      NFSD: use explicit lock/unlock for directory ops
      NFSD: use (un)lock_inode instead of fh_(un)lock for file operations
      NFSD: discard fh_locked flag and fh_lock/fh_unlock
      NFSD: fix regression with setting ACLs.
      NFSD: drop fname and flen args from nfsd_create_locked()
      lockd: drop inappropriate svc_get() from locked_get()
      nfsd: Simplify code around svc_exit_thread() call in nfsd()
      nfsd: separate nfsd_last_thread() from nfsd_put()
      NFSD: fix possible oops when nfsd/pool_stats is closed.
      nfsd: call nfsd_last_thread() before final nfsd_put()
      nfsd: fix RELEASE_LOCKOWNER
      nfsd: don't take fi_lock in nfsd_break_deleg_cb()
      nfsd: don't call locks_release_private() twice concurrently

Nicolas Pitre (1):
      vt: fix unicode buffer corruption when deleting characters

Nicolin Chen (1):
      iommu/dma: Force swiotlb_max_mapping_size on an untrusted device

Nikita Kiryushin (1):
      ACPICA: debugger: check status of acpi_evaluate_object() in acpi_db_walk_for_fields()

Niklas Cassel (1):
      PCI: dwc: endpoint: Fix advertised resizable BAR size

Nirmoy Das (1):
      drm/i915: Check before removing mm notifier

Oleksij Rempel (1):
      net: usb: asix: suspend embedded PHY if external is used

Olga Kornievskaia (1):
      NFSD enforce filehandle check for source file in COPY

Oliver Ford (1):
      fs: inotify: Fix typo in inotify comment

Oliver Neukum (1):
      usb: cdc-wdm: close race between read and workqueue

Oliver Upton (2):
      KVM: arm64: Work out supported block level at compile time
      KVM: arm64: Limit stage2_apply_range() batch size to largest block

Ondrej Valousek (1):
      nfsd: Add support for the birth time attribute

Pablo Neira Ayuso (5):
      netfilter: nf_tables: mark set as dead when unbinding anonymous set with timeout
      netfilter: nf_tables: disallow anonymous set with timeout flag
      netfilter: nf_tables: reject constant set with timeout
      netfilter: nf_tables: reject new basechain after table flag update
      netfilter: nf_tables: flush pending destroy work before exit_net release

Paul Barker (1):
      net: ravb: Always process TX descriptor ring

Paul Menzel (1):
      PCI/DPC: Quirk PIO log size for Intel Raptor Lake Root Ports

Pawan Gupta (13):
      x86/bugs: Add asm helpers for executing VERW
      x86/entry_64: Add VERW just before userspace transition
      x86/entry_32: Add VERW just before userspace transition
      x86/bugs: Use ALTERNATIVE() instead of mds_user_clear static key
      KVM/VMX: Move VERW closer to VMentry for MDS mitigation
      x86/mmio: Disable KVM mitigation when X86_FEATURE_CLEAR_CPU_BUF is set
      Documentation/hw-vuln: Add documentation for RFDS
      x86/rfds: Mitigate Register File Data Sampling (RFDS)
      KVM/x86: Export RFDS_NO and RFDS_CLEAR to guests
      x86/bhi: Add support for clearing branch history at syscall entry
      x86/bhi: Enumerate Branch History Injection (BHI) bug
      x86/bhi: Add BHI mitigation knob
      x86/bhi: Mitigate KVM by default

Peng Tao (1):
      nfsd: map EBADF

Peter Collingbourne (2):
      kasan: test: add memcpy test that avoids out-of-bounds write
      serial: Lock console when calling into driver before registration

Peter Zijlstra (4):
      arch: Introduce CONFIG_FUNCTION_ALIGNMENT
      x86/alternatives: Introduce int3_emulate_jcc()
      x86/alternatives: Teach text_poke_bp() to patch Jcc.d32 instructions
      x86/static_call: Add support for Jcc tail-calls

Petr Mladek (1):
      printk/console: Split out code that enables default console

Philip Yang (1):
      drm/amdgpu: amdgpu_ttm_gart_bind set gtt bound flag

Philipp Stanner (1):
      pci_iounmap(): Fix MMIO mapping leak

Pierre-Louis Bossart (3):
      ASoC: rt5682-sdw: fix locking sequence
      ASoC: rt711-sdca: fix locking sequence
      ASoC: rt711-sdw: fix locking sequence

Piotr Wejman (1):
      net: stmmac: fix rx queue priority assignment

Prashanth K (1):
      usb: xhci: Add error handling in xhci_map_urb_for_dma

Przemek Kitszel (1):
      ixgbe: avoid sleeping allocation in ixgbe_ipsec_vf_add_sa()

Qiang Zhang (1):
      memtest: use {READ,WRITE}_ONCE in memory scanning

Qingliang Li (1):
      PM: sleep: wakeirq: fix wake irq warning in system suspend

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

Richard Weinberger (1):
      ubi: Check for too small LEB size in VTBL code

Rickard x Andersson (1):
      tty: serial: imx: Fix broken RS485

Roberto Sassu (2):
      smack: Set SMACK64TRANSMUTE only for dirs in smack_inode_setxattr()
      smack: Handle SMACK64TRANSMUTE in smack_inode_setsecurity()

Rodrigo Siqueira (1):
      drm/amd/display: Return the correct HDCP error code

Ryan Roberts (1):
      mm: swap: fix race between free_swap_and_cache() and swapoff()

Ryosuke Yasuoka (1):
      nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet

Ryusuke Konishi (2):
      nilfs2: fix failure to detect DAT corruption in btree and direct mappings
      nilfs2: prevent kernel bug at submit_bh_wbc()

Samuel Holland (1):
      riscv: Fix spurious errors from __get/put_kernel_nofault

Samuel Thibault (1):
      speakup: Fix 8bit characters from direct synth

Sandipan Das (1):
      x86/cpufeatures: Add new word for scattered features

Saurav Kashyap (2):
      scsi: qla2xxx: Fix double free of fcport
      scsi: qla2xxx: Change debug message during driver unload

Sean Anderson (4):
      soc: fsl: qbman: Always disable interrupts when taking cgr_lock
      soc: fsl: qbman: Add helper for sanity checking cgr ops
      soc: fsl: qbman: Add CGR update function
      soc: fsl: qbman: Use raw spinlock for cgr_lock

Sean Christopherson (7):
      KVM: x86: Update KVM-only leaf handling to allow for 100% KVM-only leafs
      KVM: Always flush async #PF workqueue when vCPU is being destroyed
      KVM: SVM: Flush pages under kvm->lock to fix UAF in svm_register_enc_region()
      KVM/VMX: Use BT+JNC, i.e. EFLAGS.CF to select VMRESUME vs. VMLAUNCH
      x86/cpufeatures: Add CPUID_LNX_5 to track recently added Linux-defined word
      KVM: x86: Bail to userspace if emulation of atomic user access faults
      KVM: x86: Mark target gfn of emulated atomic instruction as dirty

SeongJae Park (1):
      selftests/mqueue: Set timeout to 180 seconds

Sherry Sun (1):
      tty: serial: fsl_lpuart: avoid idle preamble pending if CTS is enabled

Stanislaw Gruszka (1):
      PCI/AER: Block runtime suspend when handling errors

Stefan O'Rear (1):
      riscv: process: Fix kernel gp leakage

Stephen Lee (1):
      ASoC: ops: Fix wraparound for mask in snd_soc_get_volsw

Steven Rostedt (Google) (8):
      ring-buffer: Fix waking up ring buffer readers
      ring-buffer: Do not set shortest_full when full target is hit
      ring-buffer: Fix resetting of shortest_full
      ring-buffer: Fix full_waiters_pending in poll
      ring-buffer: Use wait_event_interruptible() in ring_buffer_wait()
      NFSD: Fix nfsd_clid_class use of __string_len() macro
      net: hns3: tracing: fix hclgevf trace event strings
      tracing: Use .flush() call to wake up readers

Su Hui (1):
      octeontx2-pf: check negative error code in otx2_open()

Sumanth Korikkar (1):
      s390/entry: align system call table on 8 bytes

Sumit Garg (1):
      tee: optee: Fix kernel panic caused by incorrect error handling

Svyatoslav Pankratov (1):
      crypto: qat - fix double free during reset

Tavian Barnes (1):
      nfsd: Fix creation time serialization order

Tetsuo Handa (1):
      NFSD: unregister shrinker when nfsd_init_net() fails

Thomas Gleixner (4):
      timers: Update kernel-doc for various functions
      timers: Use del_timer_sync() even on UP
      timers: Rename del_timer_sync() to timer_delete_sync()
      x86/asm: Differentiate between code and function alignment

Tim Schumacher (1):
      efivarfs: Request at most 512 bytes for variable names

Tom Chung (1):
      drm/amd/display: Preserve original aspect ratio in create stream

Toru Katagiri (1):
      USB: serial: cp210x: add pid/vid for TDK NC0110013M and MM0110113M

Trond Myklebust (4):
      nfsd: Add a tracepoint for errors in nfsd4_clone_file_range()
      nfsd: Fix a write performance regression
      nfsd: Clean up nfsd_file_put()
      nfsd: Fix a regression in nfsd_setattr()

Uwe Kleine-König (1):
      PCI: Drop pci_device_remove() test of pci_dev->driver

Vasily Averin (2):
      nfsd4: add refcount for nfsd4_blocked_lock
      fanotify: fix incorrect fmode_t casts

Ville Syrjälä (1):
      drm/amdgpu: Use drm_mode_copy()

Vlastimil Babka (1):
      mm, vmscan: prevent infinite loop for costly GFP_NOIO | __GFP_RETRY_MAYFAIL allocations

Wayne Chang (2):
      phy: tegra: xusb: Add API to retrieve the port number of phy
      usb: gadget: tegra-xudc: Fix USB3 PHY retrieval logic

Wei Fang (1):
      net: fec: Set mac_managed_pm during probe

Weitao Wang (1):
      USB: UAS: return ENODEV when submit urbs fail with device not attached

Will Deacon (1):
      swiotlb: Fix alignment checks when both allocation and DMA masks are present

Wolfram Sang (3):
      mmc: tmio: avoid concurrent runs of mmc_request_done()
      NFSD: move from strlcpy with unused retval to strscpy
      lockd: move from strlcpy with unused retval to strscpy

Xin Gao (1):
      fsnotify: Fix comment typo

Xiu Jianfeng (1):
      NFSD: Use struct_size() helper in alloc_session()

Yang Jihong (1):
      perf/core: Fix reentry problem in perf_output_read_group()

Ye Zhang (1):
      thermal: devfreq_cooling: Fix perf state when calculate dfc res_util

Yu Kuai (1):
      dm-raid: fix lockdep waring in "pers->hot_add_disk"

Zack Rusin (1):
      drm/vmwgfx: Fix possible null pointer derefence with invalid contexts

Zhang Jiaming (1):
      NFSD: Fix space and spelling mistake

Zhang Xiaoxu (2):
      nfsd: Unregister the cld notifier when laundry_wq create failed
      nfsd: Fix null-ptr-deref in nfsd_fill_super()

Zhang Yi (1):
      ubi: correct the calculation of fastmap size

Zheng Wang (1):
      wifi: brcmfmac: Fix use-after-free bug in brcmf_cfg80211_detach

Zi Yan (1):
      mm/migrate: set swap entry values of THP tail pages properly.

Ziyang Xuan (1):
      netfilter: nf_tables: Fix potential data-race in __nft_flowtable_type_get()

min15.li (1):
      nvme: fix miss command type check

yuan linyu (1):
      usb: udc: remove warning when queue disabled ep


