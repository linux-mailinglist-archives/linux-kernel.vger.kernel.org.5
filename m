Return-Path: <linux-kernel+bounces-88454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C9F86E1CA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD484B226CB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24BC70CCB;
	Fri,  1 Mar 2024 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jRE9scE5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E436EB53;
	Fri,  1 Mar 2024 13:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298968; cv=none; b=cCuX8POTTCZ1J74X6tHQjlV644mVXbw8c25aoS7hTZ6OKqzrXUoKAFMz8PDZmGPCS1ek3+n+KgVy24yvYVFGuw8vctHNtuUwGxlp96D+8rO44C5PBddvRno9IAR6qsethf4vgPH4ok2t9jkscxNqoneNTThaUskHXf8ySvGCxpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298968; c=relaxed/simple;
	bh=NI7Zku0yOWD5KLdWZNLi/GlIdNe57lmYLXs5ZlAZyJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ClDrleBbH0NAmM4YUU1irrW2du+miaYsyxwPKhEFnNhlANXHxaRJk8gblo1tZiNFy+DsAean2pN2/d5Qj/2qCio1Jmnw3cRovLUFVbdtPf9SB6o0EYmxuUm3Hg6ijt28AssLPZZQjeFLI4gcIcJR4z+yNHXXKW6VrHItcNVsdoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jRE9scE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B6AC43390;
	Fri,  1 Mar 2024 13:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709298967;
	bh=NI7Zku0yOWD5KLdWZNLi/GlIdNe57lmYLXs5ZlAZyJQ=;
	h=From:To:Cc:Subject:Date:From;
	b=jRE9scE5OPkHAyC4pprWgvMQ0NAJ7yLEfsjY8iI+4d9YpX9yxIauQ7BuWBH0EUyk9
	 Yqg5qMPZbFVFxnDrvcfrMFIwiCIT3R/xst2KXfF1FRnsbUV1rXdeOsSboJ/WT+fIAU
	 kkjjOOUtLiaTHGPgLK9cq7j69CRP35nRip9NxT/8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.150
Date: Fri,  1 Mar 2024 14:15:51 +0100
Message-ID: <2024030152-unwatched-mug-892a@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.150 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-platform-asus-wmi    |    9 
 Makefile                                             |    2 
 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts        |    1 
 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts         |    2 
 arch/arm/boot/dts/bcm53573.dtsi                      |   20 
 arch/arm/mach-ep93xx/core.c                          |    1 
 arch/arm64/boot/dts/rockchip/px30.dtsi               |    2 
 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi   |   79 
 arch/arm64/include/asm/exception.h                   |    5 
 arch/arm64/kvm/vgic/vgic-its.c                       |    5 
 arch/arm64/mm/mmu.c                                  |    4 
 arch/mips/include/asm/vpe.h                          |    1 
 arch/mips/kernel/smp-cps.c                           |    8 
 arch/mips/kernel/traps.c                             |    8 
 arch/mips/kernel/vpe-mt.c                            |    7 
 arch/mips/lantiq/prom.c                              |    6 
 arch/powerpc/kernel/eeh_driver.c                     |   71 
 arch/powerpc/kernel/rtas.c                           |   24 
 arch/powerpc/perf/hv-24x7.c                          |   42 
 arch/powerpc/platforms/powernv/pci-ioda.c            |    3 
 arch/powerpc/platforms/pseries/lpar.c                |   20 
 arch/powerpc/platforms/pseries/lparcfg.c             |   20 
 arch/riscv/include/asm/parse_asm.h                   |    2 
 arch/s390/pci/pci.c                                  |    2 
 arch/x86/include/asm/nospec-branch.h                 |    2 
 arch/x86/include/asm/text-patching.h                 |   30 
 arch/x86/kernel/alternative.c                        |   13 
 arch/x86/kernel/fpu/signal.c                         |   12 
 arch/x86/kernel/ftrace.c                             |    4 
 arch/x86/kernel/paravirt.c                           |   23 
 arch/x86/kernel/static_call.c                        |    2 
 arch/x86/net/bpf_jit_comp.c                          |    2 
 drivers/acpi/button.c                                |    9 
 drivers/acpi/property.c                              |    4 
 drivers/acpi/resource.c                              |   35 
 drivers/acpi/video_detect.c                          |   34 
 drivers/ata/ahci.c                                   |   34 
 drivers/ata/ahci.h                                   |    6 
 drivers/ata/ahci_ceva.c                              |  125 -
 drivers/ata/ahci_da850.c                             |   47 
 drivers/ata/ahci_dm816.c                             |    4 
 drivers/ata/libahci_platform.c                       |  133 -
 drivers/block/nbd.c                                  |    3 
 drivers/block/virtio_blk.c                           |    7 
 drivers/clk/clk.c                                    |   11 
 drivers/clk/imx/clk-imx8mp.c                         |   23 
 drivers/clk/imx/clk.c                                |    3 
 drivers/clk/qcom/gcc-qcs404.c                        |   24 
 drivers/clk/qcom/gpucc-sc7180.c                      |    7 
 drivers/clk/qcom/gpucc-sdm845.c                      |    7 
 drivers/clk/renesas/renesas-cpg-mssr.c               |    8 
 drivers/dma/fsl-qdma.c                               |    2 
 drivers/dma/sh/shdma.h                               |    2 
 drivers/dma/ti/edma.c                                |   10 
 drivers/firewire/core-card.c                         |   18 
 drivers/firmware/efi/arm-runtime.c                   |    2 
 drivers/firmware/efi/efi-init.c                      |   19 
 drivers/firmware/efi/riscv-runtime.c                 |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                  |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           |    8 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c              |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                |    8 
 drivers/gpu/drm/amd/amdgpu/soc15.c                   |   22 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |    1 
 drivers/gpu/drm/drm_syncobj.c                        |    6 
 drivers/gpu/drm/i915/display/intel_display_debugfs.c |    4 
 drivers/gpu/drm/i915/i915_reg.h                      |    3 
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c    |    8 
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c   |    2 
 drivers/gpu/drm/ttm/ttm_pool.c                       |    2 
 drivers/hwmon/coretemp.c                             |    2 
 drivers/i2c/busses/i2c-imx.c                         |   97 -
 drivers/infiniband/hw/bnxt_re/ib_verbs.c             |    5 
 drivers/infiniband/hw/hfi1/pio.c                     |    6 
 drivers/infiniband/hw/hfi1/sdma.c                    |    2 
 drivers/infiniband/hw/irdma/defs.h                   |    1 
 drivers/infiniband/hw/irdma/hw.c                     |    8 
 drivers/infiniband/hw/irdma/verbs.c                  |    9 
 drivers/infiniband/hw/qedr/verbs.c                   |   11 
 drivers/infiniband/sw/siw/siw_cm.c                   |    1 
 drivers/infiniband/sw/siw/siw_verbs.c                |    2 
 drivers/infiniband/ulp/srpt/ib_srpt.c                |   17 
 drivers/input/joystick/xpad.c                        |    2 
 drivers/input/misc/iqs269a.c                         |  335 +--
 drivers/input/serio/i8042-acpipnpio.h                |    8 
 drivers/input/touchscreen/ads7846.c                  |   23 
 drivers/md/dm-crypt.c                                |    6 
 drivers/md/md.c                                      |   14 
 drivers/md/raid10.c                                  |    2 
 drivers/mmc/host/jz4740_mmc.c                        |   10 
 drivers/mmc/host/mxcmmc.c                            |    6 
 drivers/mtd/nand/raw/sunxi_nand.c                    |    2 
 drivers/net/ethernet/intel/igb/igb_main.c            |    5 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c  |    4 
 drivers/net/ethernet/realtek/r8169_main.c            |   14 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    |   20 
 drivers/net/ethernet/ti/am65-cpsw-nuss.c             |   29 
 drivers/net/gtp.c                                    |   10 
 drivers/net/wireless/ath/ath11k/mac.c                |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c         |    2 
 drivers/nvme/host/fc.c                               |   47 
 drivers/nvme/target/fc.c                             |  131 -
 drivers/nvme/target/fcloop.c                         |    6 
 drivers/nvme/target/tcp.c                            |    1 
 drivers/pci/controller/dwc/pcie-designware-ep.c      |    3 
 drivers/pci/msi.c                                    |    2 
 drivers/platform/x86/intel/vbtn.c                    |    3 
 drivers/platform/x86/touchscreen_dmi.c               |   39 
 drivers/regulator/pwm-regulator.c                    |    3 
 drivers/scsi/Kconfig                                 |    2 
 drivers/scsi/lpfc/lpfc_scsi.c                        |   12 
 drivers/soc/mediatek/mtk-pm-domains.c                |   15 
 drivers/soc/renesas/r8a77980-sysc.c                  |    3 
 drivers/spi/spi-hisi-sfc-v3xx.c                      |    5 
 drivers/spi/spi-sh-msiof.c                           |   16 
 drivers/target/target_core_device.c                  |    5 
 drivers/target/target_core_transport.c               |    4 
 drivers/tty/serial/8250/8250_port.c                  |   18 
 drivers/tty/serial/amba-pl011.c                      |   60 
 drivers/usb/cdns3/cdns3-gadget.c                     |    8 
 drivers/usb/cdns3/core.c                             |    1 
 drivers/usb/cdns3/drd.c                              |   13 
 drivers/usb/cdns3/drd.h                              |    6 
 drivers/usb/cdns3/host.c                             |   16 
 drivers/usb/dwc3/gadget.c                            |    5 
 drivers/usb/gadget/function/f_ncm.c                  |   10 
 drivers/usb/host/xhci-hub.c                          |  228 +-
 drivers/usb/host/xhci-mem.c                          |   10 
 drivers/usb/host/xhci-ring.c                         |   13 
 drivers/usb/host/xhci.h                              |    9 
 drivers/usb/roles/class.c                            |   29 
 drivers/vdpa/mlx5/core/mr.c                          |    1 
 drivers/video/fbdev/savage/savagefb_driver.c         |    3 
 drivers/video/fbdev/sis/sis_main.c                   |    2 
 fs/afs/volume.c                                      |    4 
 fs/aio.c                                             |    9 
 fs/btrfs/disk-io.c                                   |    3 
 fs/cifs/connect.c                                    |   19 
 fs/cifs/smb2file.c                                   |    1 
 fs/cifs/smb2ops.c                                    |   54 
 fs/cifs/smb2pdu.c                                    |  113 -
 fs/cifs/smb2proto.h                                  |   16 
 fs/erofs/decompressor.c                              |   34 
 fs/exfat/dir.c                                       |   15 
 fs/exfat/exfat_fs.h                                  |    5 
 fs/ext4/extents.c                                    |  111 -
 fs/ext4/mballoc.c                                    |   70 
 fs/f2fs/gc.c                                         |   41 
 fs/ksmbd/smb2pdu.c                                   |    8 
 fs/ntfs3/attrib.c                                    |   20 
 fs/ntfs3/attrlist.c                                  |    8 
 fs/ntfs3/dir.c                                       |   40 
 fs/ntfs3/file.c                                      |    2 
 fs/ntfs3/fslog.c                                     |   14 
 fs/ntfs3/fsntfs.c                                    |   24 
 fs/ntfs3/inode.c                                     |    2 
 fs/ntfs3/ntfs.h                                      |    4 
 fs/ntfs3/ntfs_fs.h                                   |   14 
 fs/ntfs3/record.c                                    |   16 
 fs/ntfs3/xattr.c                                     |    3 
 fs/zonefs/super.c                                    |   68 
 include/dt-bindings/clock/imx8mp-clock.h             |   10 
 include/linux/ahci_platform.h                        |    5 
 include/linux/bpf.h                                  |   14 
 include/linux/clk-provider.h                         |   15 
 include/linux/fs.h                                   |    2 
 include/linux/pm.h                                   |   80 
 include/linux/sched.h                                |    4 
 include/linux/sched/signal.h                         |    2 
 include/linux/socket.h                               |    5 
 include/net/netfilter/nf_flow_table.h                |    4 
 include/net/tcp.h                                    |    2 
 kernel/bpf/bpf_lru_list.c                            |   21 
 kernel/bpf/bpf_lru_list.h                            |    7 
 kernel/bpf/helpers.c                                 |   76 
 kernel/bpf/verifier.c                                |    3 
 kernel/sched/fair.c                                  |    2 
 kernel/sched/rt.c                                    |   10 
 kernel/sysctl.c                                      |    4 
 kernel/time/posix-timers.c                           |   31 
 kernel/trace/bpf_trace.c                             |   39 
 lib/debugobjects.c                                   |    9 
 mm/userfaultfd.c                                     |   14 
 net/core/dev.c                                       |    2 
 net/core/dev_ioctl.c                                 |    2 
 net/core/devlink.c                                   |    5 
 net/ipv4/arp.c                                       |    3 
 net/ipv4/devinet.c                                   |   21 
 net/ipv6/addrconf.c                                  |   21 
 net/ipv6/seg6.c                                      |   20 
 net/l2tp/l2tp_ip6.c                                  |    2 
 net/mac80211/mlme.c                                  |    1 
 net/mac80211/sta_info.c                              |    2 
 net/mac80211/tx.c                                    |    2 
 net/mptcp/diag.c                                     |    6 
 net/netfilter/nf_conntrack_proto_sctp.c              |    2 
 net/netfilter/nf_flow_table_core.c                   |   41 
 net/netfilter/nf_tables_api.c                        |    3 
 net/netfilter/nft_flow_offload.c                     |   12 
 net/packet/af_packet.c                               |   12 
 net/sched/Kconfig                                    |   42 
 net/sched/Makefile                                   |    3 
 net/sched/sch_api.c                                  |   20 
 net/sched/sch_atm.c                                  |  710 -------
 net/sched/sch_cbq.c                                  | 1817 -------------------
 net/sched/sch_dsmark.c                               |  522 -----
 net/tls/tls_main.c                                   |    2 
 net/tls/tls_sw.c                                     |   12 
 net/wireless/nl80211.c                               |    1 
 net/wireless/wext-core.c                             |    6 
 scripts/bpf_doc.py                                   |    2 
 sound/soc/sunxi/sun4i-spdif.c                        |    5 
 sound/usb/clock.c                                    |   10 
 sound/usb/format.c                                   |   20 
 tools/include/uapi/linux/fscrypt.h                   |    3 
 tools/perf/trace/beauty/include/linux/socket.h       |    2 
 tools/testing/selftests/net/vrf-xfrm-tests.sh        |   32 
 tools/virtio/linux/kernel.h                          |    2 
 tools/virtio/linux/vringh.h                          |    1 
 219 files changed, 2291 insertions(+), 4618 deletions(-)

Alex Bee (2):
      arm64: dts: rockchip: add ES8316 codec for ROCK Pi 4
      arm64: dts: rockchip: add SPDIF node for ROCK Pi 4

Alexander Tsoy (2):
      ALSA: usb-audio: Check presence of valid altsetting control
      ALSA: usb-audio: Ignore clock selector errors for single connection

Alexey Khoroshilov (1):
      clk: renesas: cpg-mssr: Fix use after free if cpg_mssr_common_init() failed

Andrei Vagin (1):
      x86/fpu: Stop relying on userspace for info to fault in xsave buffer

Andrew Bresticker (2):
      efi: runtime: Fix potential overflow of soft-reserved region size
      efi: Don't add memblocks for soft-reserved memory

Armin Wolf (1):
      drm/amd/display: Fix memory leak in dm_sw_fini()

Arnaldo Carvalho de Melo (2):
      tools headers UAPI: Sync linux/fscrypt.h with the kernel sources
      perf beauty: Update copy of linux/socket.h with the kernel sources

Arnd Bergmann (2):
      RDMA/srpt: fix function pointer cast warnings
      nouveau: fix function cast warnings

Baokun Li (5):
      ext4: avoid dividing by 0 in mb_update_avg_fragment_size() when block bitmap corrupt
      ext4: avoid allocating blocks from corrupted group in ext4_mb_try_best_found()
      ext4: avoid allocating blocks from corrupted group in ext4_mb_find_by_goal()
      ext4: regenerate buddy after block freeing failed if under fc replay
      ext4: avoid bb_free and bb_fragments inconsistency in mb_free_blocks()

Bart Van Assche (2):
      RDMA/srpt: Support specifying the srpt_service_guid parameter
      fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio

Borislav Petkov (AMD) (2):
      Revert "x86/ftrace: Use alternative RET encoding"
      Revert "x86/alternative: Make custom return thunk unconditional"

Brenton Simpson (1):
      Input: xpad - add Lenovo Legion Go controllers

Byungki Lee (1):
      f2fs: write checkpoint during FG_GC

Chao Yu (1):
      f2fs: don't set GC_FAILURE_PIN for background GC

Chen-Yu Tsai (2):
      ASoC: sunxi: sun4i-spdif: Add support for Allwinner H616
      clk: Honor CLK_OPS_PARENT_ENABLE in clk_core_is_enabled()

Chuansheng Liu (1):
      drm/i915/dg1: Update DMC_DEBUG3 register

Conrad Kostecki (1):
      ahci: asm1166: correct count of reported ports

Corey Minyard (2):
      i2c: imx: Add timer for handling the stop condition
      i2c: imx: when being a target, mark the last read as processed

Cyril Hrubis (3):
      sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset
      sched/rt: Fix sysctl_sched_rr_timeslice intial value
      sched/rt: Disallow writing invalid values to sched_rt_period_us

Damien Le Moal (1):
      zonefs: Improve error handling

Dan Carpenter (1):
      PCI: dwc: Fix a 64bit bug in dw_pcie_ep_raise_msix_irq()

Daniel Axtens (1):
      powerpc/eeh: Small refactor of eeh_handle_normal_event()

Daniel Vacek (1):
      IB/hfi1: Fix sdma.h tx->num_descs off-by-one error

Daniel Wagner (8):
      nvme-fc: do not wait in vain when unloading module
      nvmet-fcloop: swap the list_add_tail arguments
      nvmet-fc: release reference on target port
      nvmet-fc: defer cleanup using RCU properly
      nvmet-fc: hold reference on hostport match
      nvmet-fc: abort command when there is no binding
      nvmet-fc: avoid deadlock on delete association path
      nvmet-fc: take ref count on tgtport before delete assoc

Daniil Dulov (1):
      afs: Increase buffer size in afs_update_volume_status()

Dave Marchevsky (1):
      bpf: Merge printk and seq_printf VARARG max macros

David Sterba (1):
      btrfs: add xxhash to fast checksum implementations

Devyn Liu (1):
      spi: hisi-sfc-v3xx: Return IRQ_NONE if no interrupts were detected

Dmitry Baryshkov (4):
      clk: qcom: gcc-qcs404: disable gpll[04]_out_aux parents
      clk: qcom: gcc-qcs404: fix names of the DSI clocks used as parents
      clk: qcom: gpucc-sc7180: fix clk_dis_wait being programmed for CX GDSC
      clk: qcom: gpucc-sdm845: fix clk_dis_wait being programmed for CX GDSC

Dmitry Bogdanov (1):
      scsi: target: core: Add TMF to tmr_list handling

Edward Adam Davis (1):
      fs/ntfs3: Fix oob in ntfs_listxattr

Eli Cohen (1):
      vdpa/mlx5: Don't clear mr struct on destroy MR

Enzo Matsumiya (1):
      cifs: remove useless parameter 'is_fsctl' from SMB2_ioctl()

Eric Dumazet (2):
      ipv4: properly combine dev_base_seq and ipv4.dev_addr_genid
      ipv6: properly combine dev_base_seq and ipv6.dev_addr_genid

Erik Kurzinger (1):
      drm/syncobj: call drm_syncobj_fence_add_wait when WAIT_AVAILABLE flag is set

Eugen Hristev (1):
      pmdomain: mediatek: fix race conditions with genpd

FUKAUMI Naoki (1):
      arm64: dts: rockchip: fix regulator name on rk3399-rock-4

Fedor Pchelkin (1):
      ksmbd: free aux buffer if ksmbd_iov_pin_rsp_read fails

Felix Fietkau (1):
      wifi: mac80211: fix race condition on enabling fast-xmit

Florian Westphal (4):
      netfilter: nf_tables: add rescheduling points during loop detection walks
      netfilter: nf_tables: set dormant flag on hook register failure
      netfilter: nf_tables: fix scheduling-while-atomic splat
      netfilter: nf_tables: can't schedule in nft_chain_validate

Frank Li (2):
      usb: cdns3: fixed memory use after free at cdns3_gadget_ep_disable()
      usb: cdns3: fix memory double free when handle zero packet

Frederic Barrat (1):
      powerpc/powernv/ioda: Skip unallocated resources when mapping to PE

Fullway Wang (2):
      fbdev: savage: Error out if pixclock equals zero
      fbdev: sis: Error out if pixclock equals zero

Ganesh Goudar (1):
      powerpc/eeh: Set channel state after notifying the drivers

Gao Xiang (1):
      erofs: fix lz4 inplace decompression

Geert Uytterhoeven (2):
      pmdomain: renesas: r8a77980-sysc: CR7 must be always on
      clk: renesas: cpg-mssr: Remove superfluous check in resume code

Gianmarco Lusvardi (1):
      bpf, scripts: Correct GPL license name

Greg Kroah-Hartman (1):
      Linux 5.15.150

Guixin Liu (1):
      nvmet-tcp: fix nvme tcp ida memory leak

Guo Zhengkui (1):
      drm/nouveau/instmem: fix uninitialized_var.cocci warning

Guoqing Jiang (2):
      RDMA/siw: Balance the reference of cep->kref in the error path
      RDMA/siw: Correct wrong debug message

Gustavo A. R. Silva (1):
      wifi: wext-core: Fix -Wstringop-overflow warning in ioctl_standard_iw_point()

Hannes Reinecke (1):
      scsi: lpfc: Use unsigned type for num_sge

Hans de Goede (7):
      platform/x86: intel-vbtn: Stop calling "VBDL" from notify_handler
      platform/x86: touchscreen_dmi: Allow partial (prefix) matches for ACPI names
      ACPI: button: Add lid disable DMI quirk for Nextbook Ares 8A
      ACPI: video: Add backlight=native DMI quirk for Apple iMac11,3
      ACPI: video: Add backlight=native DMI quirk for Lenovo ThinkPad X131e (3371 AMD version)
      ACPI: video: Add backlight=native DMI quirk for Apple iMac12,1 and iMac12,2
      ACPI: resource: Add Asus ExpertBook B2502 to Asus quirks

Heiko Stuebner (2):
      RISC-V: fix funct4 definition for c.jalr in parse_asm.h
      arm64: dts: rockchip: set num-cs property for spi on px30

Heiner Kallweit (1):
      r8169: use new PM macros

Huang Pei (1):
      MIPS: reserve exception vector space ONLY ONCE

Hui Su (1):
      kernel/sched: Remove dl_boosted flag comment

Ilpo Järvinen (1):
      serial: 8250: Remove serial_rs485 sanitization from em485

Ism Hong (1):
      fs/ntfs3: use non-movable memory for ntfs3 MFT buffer cache

Jakub Kicinski (2):
      tls: rx: jump to a more appropriate label
      tls: rx: drop pointless else after goto

Jamal Hadi Salim (3):
      net/sched: Retire CBQ qdisc
      net/sched: Retire ATM qdisc
      net/sched: Retire dsmark qdisc

Jason Gunthorpe (1):
      s390: use the correct count for __iowrite64_copy()

Jeff LaBundy (5):
      Input: iqs269a - drop unused device node references
      Input: iqs269a - configure device with a single block write
      Input: iqs269a - increase interrupt handler return delay
      Input: iqs269a - do not poll during suspend or resume
      Input: iqs269a - do not poll during ATI

Jiri Olsa (3):
      bpf: Add struct for bin_args arg in bpf_bprintf_prepare
      bpf: Do cleanup in bpf_bprintf_cleanup only when needed
      bpf: Remove trace_printk_lock

Johannes Berg (2):
      wifi: mac80211: adding missing drv_mgd_complete_tx() call
      wifi: iwlwifi: mvm: avoid baid size integer overflow

Jonathan Cameron (1):
      Input: iqs269a - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()

Kalesh AP (1):
      RDMA/bnxt_re: Return error for SRQ resize

Kamal Heib (1):
      RDMA/qedr: Fix qedr_create_user_qp error flow

Kees Cook (1):
      net: dev: Convert sa_data to flexible array in struct sockaddr

Kellen Renshaw (1):
      ACPI: resource: Add ASUS model S5402ZA to quirks

Konstantin Komarov (10):
      fs/ntfs3: Modified fix directory element type detection
      fs/ntfs3: Improve ntfs_dir_count
      fs/ntfs3: Correct hard links updating when dealing with DOS names
      fs/ntfs3: Print warning while fixing hard links count
      fs/ntfs3: Fix detected field-spanning write (size 8) of single field "le->name"
      fs/ntfs3: Add NULL ptr dereference checking at the end of attr_allocate_frame()
      fs/ntfs3: Disable ATTR_LIST_ENTRY size check
      fs/ntfs3: Prevent generic message "attempt to access beyond end of device"
      fs/ntfs3: Correct function is_rst_area_valid
      fs/ntfs3: Update inode->i_size after success write into compressed file

Krishna Kurapati (1):
      usb: gadget: ncm: Avoid dropping datagrams of properly parsed NTBs

Kuniyuki Iwashima (1):
      arp: Prevent overflow in arp_req_get().

Kunwu Chan (1):
      dmaengine: ti: edma: Add some null pointer checks to the edma_probe

Lennert Buytenhek (1):
      ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers

Li Jun (2):
      clk: imx: imx8mp: add shared clk gate for usb suspend clk
      dt-bindings: clocks: imx8mp: Add ID for usb suspend clock

Lino Sanfilippo (1):
      serial: amba-pl011: Fix DMA transmission in RS485 mode

Lokesh Gidra (1):
      userfaultfd: fix mmap_changing checking in mfill_atomic_hugetlb

Luca Ellero (3):
      Input: ads7846 - don't report pressure for ads7845
      Input: ads7846 - always set last command to PWRDOWN
      Input: ads7846 - don't check penirq immediately for 7845

Lucas Stach (1):
      clk: imx8mp: add clkout1/2 support

Luke D. Jones (1):
      platform/x86: asus-wmi: Document the dgpu_disable sysfs attribute

Magali Lemes (1):
      selftests: net: vrf-xfrm-tests: change authentication and encryption algos

Marek Vasut (1):
      clk: imx8mp: Add DISP2 pixel clock

Mark Rutland (1):
      arm64: mm: fix VA-range sanity check

Martin Blumenstingl (1):
      regulator: pwm-regulator: Add validity checks in continuous .get_voltage

Martin KaFai Lau (2):
      bpf: Address KCSAN report on bpf_lru_list
      bpf: Fix racing between bpf_timer_cancel_and_free and bpf_timer_cancel

Mathias Nyman (6):
      xhci: cleanup xhci_hub_control port references
      xhci: move port specific items such as state completions to port structure
      xhci: rename resume_done to resume_timestamp
      xhci: clear usb2 resume related variables in one place.
      xhci: decouple usb2 port resume and get_port_status request handling
      xhci: track port suspend state correctly in unsuccessful resume cases

Maxime Bizon (1):
      wifi: ath11k: fix registration of 6Ghz-only phy without the full channel range

Michal Kazior (1):
      wifi: cfg80211: fix missing interfaces when dumping

Mike Marciniszyn (1):
      RDMA/irdma: Fix KASAN issue with tasklet

Mikulas Patocka (1):
      dm-crypt: don't modify the data when using authenticated encryption

Mustafa Ismail (2):
      RDMA/irdma: Set the CQ read threshold for GEN 1
      RDMA/irdma: Add AE for too many RNRS

Nathan Lynch (5):
      powerpc/pseries/lparcfg: add missing RTAS retry status handling
      powerpc/perf/hv-24x7: add missing RTAS retry status handling
      powerpc/pseries/lpar: add missing RTAS retry status handling
      powerpc/rtas: make all exports GPL
      powerpc/rtas: ensure 4KB alignment for rtas_data_buf

Nikita Shubin (1):
      ARM: ep93xx: Add terminator to gpiod_lookup_table

Oliver Upton (2):
      KVM: arm64: vgic-its: Test for valid IRQ in MOVALL handler
      KVM: arm64: vgic-its: Test for valid IRQ in its_sync_lpi_pending_table()

Pablo Neira Ayuso (3):
      netfilter: flowtable: simplify route logic
      netfilter: nft_flow_offload: reset dst in route object after setting up flow
      netfilter: nft_flow_offload: release dst in case direct xmit path is used

Paolo Abeni (1):
      mptcp: fix lockless access in subflow ULP diag

Paul Cercueil (5):
      PM: core: Redefine pm_ptr() macro
      PM: core: Add new *_PM_OPS macros, deprecate old ones
      mmc: jz4740: Use the new PM macros
      mmc: mxc: Use the new PM macros
      PM: core: Remove static qualifier in DEFINE_SIMPLE_DEV_PM_OPS macro

Paul Menzel (1):
      ACPI: resource: Skip IRQ override on ASUS ExpertBook B1502CBA

Paulo Alcantara (3):
      smb: client: fix OOB in receive_encrypted_standard()
      smb: client: fix potential OOBs in smb2_parse_contexts()
      smb: client: fix parsing of SMB3.1.1 POSIX create context

Pavel Sakharov (1):
      net: stmmac: Fix incorrect dereference in interrupt handlers

Pawel Laszczak (2):
      usb: cdnsp: blocked some cdns3 specific code
      usb: cdnsp: fixed issue with incorrect detecting CDNSP family controllers

Peilin Ye (1):
      net/sched: Refactor qdisc_graft() for ingress and clsact Qdiscs

Peng Fan (1):
      clk: imx: avoid memory leak

Peter Zijlstra (5):
      x86/text-patching: Make text_gen_insn() play nice with ANNOTATE_NOENDBR
      x86/ibt,paravirt: Use text_gen_insn() for paravirt_patch()
      x86/ftrace: Use alternative RET encoding
      x86/returnthunk: Allow different return thunks
      x86/alternative: Make custom return thunk unconditional

Petr Oros (1):
      devlink: report devlink_port_type_warn source device

Phoenix Chen (1):
      platform/x86: touchscreen_dmi: Add info for the TECLAST X16 Plus tablet

Prike Liang (2):
      drm/amdgpu: skip to program GFXDEC registers for suspend abort
      drm/amdgpu: reset gpu for s3 suspend abort case

Radhey Shyam Pandey (1):
      ata: ahci_ceva: fix error handling for Xilinx GT PHY support

Rafał Miłecki (3):
      ARM: dts: BCM53573: Drop nonexistent #usb-cells
      ARM: dts: BCM53573: Drop nonexistent "default-off" LED trigger
      ARM: dts: BCM53573: Describe on-SoC BCM53125 rev 4 switch

Randy Dunlap (4):
      MIPS: SMP-CPS: fix build error when HOTPLUG_CPU not set
      MIPS: vpe-mt: drop physical_memsize
      clk: linux/clk-provider.h: fix kernel-doc warnings and typos
      scsi: jazz_esp: Only build if SCSI core is builtin

Sabrina Dubroca (1):
      tls: stop recv() if initial process_rx_list gave us non-DATA

Sakari Ailus (1):
      acpi: property: Let args be NULL in __acpi_node_get_property_reference

Samuel Holland (1):
      mtd: rawnand: sunxi: Fix the size of the last OOB region

Serge Semin (2):
      ata: libahci_platform: Convert to using devm bulk clocks API
      ata: libahci_platform: Introduce reset assertion/deassertion methods

Shiraz Saleem (1):
      RDMA/irdma: Validate max_send_wr and max_recv_wr

Shyam Prasad N (2):
      cifs: add a warning when the in-flight count goes negative
      cifs: fix mid leak during reconnection after timeout threshold

Stefano Garzarella (1):
      tools/virtio: fix build

Subbaraya Sundeep (1):
      octeontx2-af: Consider the action set by PF

Szilard Fabian (1):
      Input: i8042 - add Fujitsu Lifebook U728 to i8042 quirk table

Takashi Sakamoto (1):
      firewire: core: send bus reset promptly on gap count error

Tamim Khan (2):
      ACPI: resource: Skip IRQ override on Asus Vivobook S5602ZA
      ACPI: resource: Skip IRQ override on Asus Expertbook B2402CBA

Tetsuo Handa (1):
      debugobjects: Recheck debug_objects_enabled before reporting

Thinh Nguyen (1):
      usb: dwc3: gadget: Don't disconnect if not started

Thomas Gleixner (1):
      posix-timers: Ensure timer ID search-loop limit is valid

Thomas Hellström (1):
      drm/ttm: Fix an invalid freeing on already freed page in error path

Tom Parkin (1):
      l2tp: pass correct message length to ip6_append_data

Vasiliy Kovalev (2):
      gtp: fix use-after-free and null-ptr-deref in gtp_genl_dump_pdp()
      ipv6: sr: fix possible use-after-free and null-ptr-deref

Vidya Sagar (1):
      PCI/MSI: Prevent MSI hardware interrupt number truncation

Vinod Koul (2):
      dmaengine: shdma: increase size of 'dev_id'
      dmaengine: fsl-qdma: increase size of 'irq_name'

Wang Qing (1):
      net: ethernet: ti: add missing of_node_put before return

Wolfram Sang (2):
      spi: sh-msiof: avoid integer overflow in constants
      packet: move from strlcpy with unused retval to strscpy

Xin Long (1):
      netfilter: conntrack: check SCTP_CID_SHUTDOWN_ACK for vtag setting in sctp_new

Xu Yang (2):
      usb: roles: fix NULL pointer issue when put module's reference
      usb: roles: don't get/set_role() when usb_role_switch is unregistered

Yi Sun (1):
      virtio-blk: Ensure no requests in virtqueues before deleting vqs.

Yicong Yang (1):
      sched/fair: Don't balance task to its current running CPU

Yifan Zhang (1):
      drm/amdgpu: init iommu after amdkfd device init

Ying Hsu (1):
      igb: Fix igb_down hung on surprise removal

Youngmin Nam (1):
      arm64: set __exception_irq_entry with __irq_entry as a default

Yu Kuai (2):
      md: fix data corruption for raid456 when reshape restart while grow up
      md/raid10: prevent soft lockup while flush writes

Yuezhang Mo (1):
      exfat: support dynamic allocate bh for exfat_entry_set_cache

Zhang Rui (1):
      hwmon: (coretemp) Enlarge per package core count limit

Zhang Yi (1):
      ext4: correct the hole length returned by ext4_map_blocks()

Zhipeng Lu (1):
      IB/hfi1: Fix a memleak in init_credit_return

Zhong Jinghua (1):
      nbd: Add the maximum limit of allocated index in nbd_dev_add


