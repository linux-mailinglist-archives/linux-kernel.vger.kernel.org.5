Return-Path: <linux-kernel+bounces-88452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EB186E1C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1100AB23809
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB79470CAD;
	Fri,  1 Mar 2024 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QaA0yKz7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7663370044;
	Fri,  1 Mar 2024 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298961; cv=none; b=aSh2ONv4ycIFFYLqTffJdt739qydYjfpwrzWVELaPJt7Pxa7JP2Dj7uTJLVErm0PfamiFjkftx9hZ/5x4wiwX2CemCYsB2M5DQT3j+ybVOTH76QewDMOAQoZXHhW4tl9pb2v3gLjNnl+se7wu01cnnMoJASvkqAQzJ/MoLdDSbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298961; c=relaxed/simple;
	bh=6EUXwAwzbP3ZnjZR8NpI3E1qeSxujKFYLBrJyEY1G6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QxrQNJyeaE7JN9v9eV6NgDNGPQZhPlb7rswzWAFELRkaKdqC+rIRHpa3ODB2H28vHlGWopF+nPUMaq27cX3xcg814MDq1vAWmVrHnGEUs8cH8BBBjWmCA1pYey7lyO1FB10IlZkNxsVqqwK2sphfspCMZur4YV400xzVAj6gsAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QaA0yKz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8072FC43394;
	Fri,  1 Mar 2024 13:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709298961;
	bh=6EUXwAwzbP3ZnjZR8NpI3E1qeSxujKFYLBrJyEY1G6c=;
	h=From:To:Cc:Subject:Date:From;
	b=QaA0yKz7cbWvxCkeKU5FkZdYUEIQNH4rSSi/vzYVer5KQ1C9S82NwGOGr/MwirJck
	 Rd17o1PrZ2GfuaKKOurzatcBEpO9G1bMqjq1tLzsJxN3Ijt9W4W5gch4NvDkggoHNe
	 gcnp8c0CCedeshxwha82vkB+9crI8rxZeEa/vllc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.80
Date: Fri,  1 Mar 2024 14:15:45 +0100
Message-ID: <2024030145-nastily-reprimand-ae91@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.80 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                       |    2 
 arch/arm/mach-ep93xx/core.c                                    |    1 
 arch/arm64/boot/dts/rockchip/px30.dtsi                         |    2 
 arch/arm64/include/asm/fpsimd.h                                |    2 
 arch/arm64/kernel/fpsimd.c                                     |   14 
 arch/arm64/kernel/suspend.c                                    |    3 
 arch/arm64/kvm/vgic/vgic-its.c                                 |    5 
 arch/loongarch/Kconfig                                         |   23 
 arch/loongarch/kernel/smp.c                                    |    1 
 arch/mips/kernel/traps.c                                       |    8 
 arch/parisc/kernel/processor.c                                 |    8 
 arch/s390/pci/pci.c                                            |    2 
 arch/x86/include/asm/nospec-branch.h                           |    2 
 arch/x86/kernel/alternative.c                                  |   13 
 arch/x86/kernel/ftrace.c                                       |    2 
 arch/x86/kernel/static_call.c                                  |    2 
 arch/x86/mm/numa.c                                             |   21 
 arch/x86/net/bpf_jit_comp.c                                    |    2 
 block/blk-map.c                                                |   13 
 drivers/ata/ahci.c                                             |   49 
 drivers/ata/ahci.h                                             |    1 
 drivers/ata/ahci_ceva.c                                        |  125 
 drivers/ata/libata-core.c                                      |    4 
 drivers/block/aoe/aoeblk.c                                     |    5 
 drivers/block/virtio_blk.c                                     |    7 
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c            |    5 
 drivers/cxl/core/pci.c                                         |    6 
 drivers/dma/apple-admac.c                                      |    5 
 drivers/dma/fsl-qdma.c                                         |    2 
 drivers/dma/sh/shdma.h                                         |    2 
 drivers/dma/ti/edma.c                                          |   10 
 drivers/firewire/core-card.c                                   |   18 
 drivers/firmware/efi/arm-runtime.c                             |    2 
 drivers/firmware/efi/efi-init.c                                |   19 
 drivers/firmware/efi/libstub/Makefile                          |    2 
 drivers/firmware/efi/riscv-runtime.c                           |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                            |    2 
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                        |    2 
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                          |    8 
 drivers/gpu/drm/amd/amdgpu/soc15.c                             |   22 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c              |    1 
 drivers/gpu/drm/drm_syncobj.c                                  |    6 
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c              |    8 
 drivers/gpu/drm/ttm/ttm_pool.c                                 |    2 
 drivers/hwmon/coretemp.c                                       |    2 
 drivers/i2c/busses/i2c-imx.c                                   |    5 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                       |    5 
 drivers/infiniband/hw/hfi1/pio.c                               |    6 
 drivers/infiniband/hw/hfi1/sdma.c                              |    2 
 drivers/infiniband/hw/irdma/defs.h                             |    1 
 drivers/infiniband/hw/irdma/hw.c                               |    8 
 drivers/infiniband/hw/irdma/verbs.c                            |    9 
 drivers/infiniband/hw/qedr/verbs.c                             |   11 
 drivers/infiniband/ulp/srpt/ib_srpt.c                          |   17 
 drivers/input/joystick/xpad.c                                  |    2 
 drivers/input/serio/i8042-acpipnpio.h                          |    8 
 drivers/input/touchscreen/goodix.c                             |    3 
 drivers/irqchip/irq-gic-v3-its.c                               |    2 
 drivers/irqchip/irq-sifive-plic.c                              |    8 
 drivers/md/dm-crypt.c                                          |   95 
 drivers/md/dm-integrity.c                                      |   91 
 drivers/md/dm-verity-target.c                                  |   86 
 drivers/md/dm-verity.h                                         |    6 
 drivers/md/md.c                                                |    6 
 drivers/misc/open-dice.c                                       |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c            |    4 
 drivers/net/ethernet/microchip/sparx5/sparx5_main.c            |    1 
 drivers/net/ethernet/microchip/sparx5/sparx5_main.h            |    1 
 drivers/net/ethernet/microchip/sparx5/sparx5_packet.c          |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c              |   20 
 drivers/net/gtp.c                                              |   10 
 drivers/net/phy/realtek.c                                      |    4 
 drivers/nvme/host/fc.c                                         |   47 
 drivers/nvme/target/fc.c                                       |  131 
 drivers/nvme/target/fcloop.c                                   |    6 
 drivers/nvme/target/tcp.c                                      |    1 
 drivers/pci/controller/dwc/pcie-designware-ep.c                |    3 
 drivers/pci/msi/irqdomain.c                                    |    2 
 drivers/platform/x86/intel/vbtn.c                              |    3 
 drivers/platform/x86/thinkpad_acpi.c                           |    5 
 drivers/platform/x86/touchscreen_dmi.c                         |   39 
 drivers/regulator/pwm-regulator.c                              |    3 
 drivers/s390/cio/device_ops.c                                  |    6 
 drivers/scsi/Kconfig                                           |    2 
 drivers/scsi/lpfc/lpfc_scsi.c                                  |   12 
 drivers/scsi/scsi.c                                            |   22 
 drivers/scsi/smartpqi/smartpqi_init.c                          |    5 
 drivers/soc/mediatek/mtk-pm-domains.c                          |   15 
 drivers/soc/renesas/r8a77980-sysc.c                            |    3 
 drivers/spi/spi-hisi-sfc-v3xx.c                                |    5 
 drivers/spi/spi-sh-msiof.c                                     |   16 
 drivers/target/target_core_device.c                            |    5 
 drivers/target/target_core_pscsi.c                             |    9 
 drivers/target/target_core_transport.c                         |    4 
 drivers/tty/serial/amba-pl011.c                                |   60 
 drivers/ufs/core/ufshcd.c                                      |    1 
 drivers/usb/cdns3/cdns3-gadget.c                               |    8 
 drivers/usb/cdns3/core.c                                       |    1 
 drivers/usb/cdns3/drd.c                                        |   13 
 drivers/usb/cdns3/drd.h                                        |    6 
 drivers/usb/cdns3/host.c                                       |   16 
 drivers/usb/dwc3/gadget.c                                      |    5 
 drivers/usb/gadget/function/f_ncm.c                            |   10 
 drivers/usb/roles/class.c                                      |   29 
 drivers/usb/typec/ucsi/ucsi_acpi.c                             |   71 
 drivers/vfio/iova_bitmap.c                                     |   25 
 drivers/video/fbdev/savage/savagefb_driver.c                   |    3 
 drivers/video/fbdev/sis/sis_main.c                             |    2 
 fs/afs/volume.c                                                |    4 
 fs/aio.c                                                       |    9 
 fs/cachefiles/cache.c                                          |    2 
 fs/cachefiles/daemon.c                                         |    1 
 fs/erofs/compress.h                                            |    4 
 fs/erofs/decompressor.c                                        |   60 
 fs/erofs/decompressor_lzma.c                                   |    4 
 fs/erofs/internal.h                                            |   28 
 fs/erofs/namei.c                                               |   28 
 fs/erofs/super.c                                               |   72 
 fs/erofs/zmap.c                                                |   23 
 fs/ext4/extents.c                                              |  111 
 fs/ext4/mballoc.c                                              |   15 
 fs/ntfs3/attrib.c                                              |   20 
 fs/ntfs3/attrlist.c                                            |    8 
 fs/ntfs3/dir.c                                                 |   40 
 fs/ntfs3/file.c                                                |    2 
 fs/ntfs3/fslog.c                                               |   14 
 fs/ntfs3/fsntfs.c                                              |   24 
 fs/ntfs3/inode.c                                               |    2 
 fs/ntfs3/ntfs.h                                                |    4 
 fs/ntfs3/ntfs_fs.h                                             |   14 
 fs/ntfs3/record.c                                              |   25 
 fs/ntfs3/xattr.c                                               |    3 
 fs/smb/client/cached_dir.c                                     |    2 
 fs/smb/client/cifsencrypt.c                                    |    2 
 fs/smb/client/cifsglob.h                                       |    2 
 fs/smb/client/fs_context.c                                     |    2 
 fs/smb/client/readdir.c                                        |   15 
 fs/smb/client/smb2pdu.c                                        |    6 
 fs/smb/client/transport.c                                      |   15 
 include/linux/fs.h                                             |    2 
 include/linux/memblock.h                                       |    2 
 include/linux/socket.h                                         |    5 
 include/linux/swap.h                                           |    5 
 include/net/netfilter/nf_flow_table.h                          |    4 
 include/net/switchdev.h                                        |    3 
 include/net/tcp.h                                              |    2 
 include/scsi/scsi_device.h                                     |    4 
 kernel/bpf/helpers.c                                           |    5 
 kernel/sched/rt.c                                              |   12 
 mm/damon/lru_sort.c                                            |   43 
 mm/damon/reclaim.c                                             |   18 
 mm/memblock.c                                                  |    5 
 mm/memcontrol.c                                                |   10 
 mm/memory.c                                                    |   20 
 mm/swap.h                                                      |    5 
 mm/swapfile.c                                                  |   13 
 mm/zswap.c                                                     |    2 
 net/bridge/br_switchdev.c                                      |   84 
 net/core/dev.c                                                 |    2 
 net/core/dev_ioctl.c                                           |    2 
 net/core/skmsg.c                                               |    7 
 net/ipv4/arp.c                                                 |    3 
 net/ipv4/devinet.c                                             |   21 
 net/ipv4/inet_hashtables.c                                     |   25 
 net/ipv6/addrconf.c                                            |   21 
 net/ipv6/exthdrs.c                                             |   10 
 net/ipv6/seg6.c                                                |   20 
 net/l2tp/l2tp_ip6.c                                            |    2 
 net/mac80211/cfg.c                                             |    2 
 net/mac80211/mlme.c                                            |    1 
 net/mac80211/sta_info.c                                        |    2 
 net/mac80211/tx.c                                              |    2 
 net/mctp/route.c                                               |    2 
 net/mptcp/diag.c                                               |    6 
 net/mptcp/pm_netlink.c                                         |   24 
 net/mptcp/pm_userspace.c                                       |   54 
 net/mptcp/protocol.h                                           |    2 
 net/netfilter/nf_conntrack_proto_sctp.c                        |    2 
 net/netfilter/nf_flow_table_core.c                             |   41 
 net/netfilter/nf_tables_api.c                                  |   87 
 net/netfilter/nft_flow_offload.c                               |   12 
 net/packet/af_packet.c                                         |   10 
 net/phonet/datagram.c                                          |    4 
 net/phonet/pep.c                                               |   41 
 net/sched/Kconfig                                              |   42 
 net/sched/Makefile                                             |    3 
 net/sched/sch_atm.c                                            |  706 ----
 net/sched/sch_cbq.c                                            | 1727 ----------
 net/sched/sch_dsmark.c                                         |  518 --
 net/switchdev/switchdev.c                                      |   73 
 net/tls/tls_main.c                                             |    2 
 net/tls/tls_sw.c                                               |   24 
 net/wireless/nl80211.c                                         |    1 
 scripts/bpf_doc.py                                             |    2 
 sound/soc/codecs/wm_adsp.c                                     |   29 
 sound/soc/sunxi/sun4i-spdif.c                                  |    5 
 sound/usb/clock.c                                              |   10 
 sound/usb/format.c                                             |   20 
 tools/testing/selftests/tc-testing/tc-tests/qdiscs/atm.json    |   94 
 tools/testing/selftests/tc-testing/tc-tests/qdiscs/cbq.json    |  184 -
 tools/testing/selftests/tc-testing/tc-tests/qdiscs/dsmark.json |  140 
 201 files changed, 1952 insertions(+), 4290 deletions(-)

Alexander Tsoy (2):
      ALSA: usb-audio: Check presence of valid altsetting control
      ALSA: usb-audio: Ignore clock selector errors for single connection

Alison Schofield (2):
      x86/numa: Fix the address overlap check in numa_fill_memblks()
      x86/numa: Fix the sort compare func used in numa_fill_memblks()

Andrew Bresticker (2):
      efi: runtime: Fix potential overflow of soft-reserved region size
      efi: Don't add memblocks for soft-reserved memory

Armin Wolf (1):
      drm/amd/display: Fix memory leak in dm_sw_fini()

Arnd Bergmann (3):
      dm-integrity, dm-verity: reduce stack usage for recheck
      RDMA/srpt: fix function pointer cast warnings
      nouveau: fix function cast warnings

Baokun Li (4):
      ext4: avoid dividing by 0 in mb_update_avg_fragment_size() when block bitmap corrupt
      ext4: avoid allocating blocks from corrupted group in ext4_mb_try_best_found()
      ext4: avoid allocating blocks from corrupted group in ext4_mb_find_by_goal()
      cachefiles: fix memory leak in cachefiles_add_cache()

Bart Van Assche (2):
      RDMA/srpt: Support specifying the srpt_service_guid parameter
      fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio

Borislav Petkov (AMD) (1):
      Revert "x86/alternative: Make custom return thunk unconditional"

Brenton Simpson (1):
      Input: xpad - add Lenovo Legion Go controllers

Chen-Yu Tsai (1):
      ASoC: sunxi: sun4i-spdif: Add support for Allwinner H616

Christian A. Ehrhardt (2):
      block: Fix WARNING in _copy_from_iter
      usb: ucsi_acpi: Quirk to ack a connector change ack cmd

Conrad Kostecki (1):
      ahci: asm1166: correct count of reported ports

Corey Minyard (1):
      i2c: imx: when being a target, mark the last read as processed

Cyril Hrubis (2):
      sched/rt: Disallow writing invalid values to sched_rt_period_us
      sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset

Damien Le Moal (1):
      ata: libata-core: Do not try to set sleeping devices to standby

Dan Carpenter (1):
      PCI: dwc: Fix a 64bit bug in dw_pcie_ep_raise_msix_irq()

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

Devyn Liu (1):
      spi: hisi-sfc-v3xx: Return IRQ_NONE if no interrupts were detected

Dmitry Bogdanov (1):
      scsi: target: core: Add TMF to tmr_list handling

Don Brace (1):
      scsi: smartpqi: Fix disable_managed_interrupts

Edward Adam Davis (1):
      fs/ntfs3: Fix oob in ntfs_listxattr

Edward Lo (1):
      fs/ntfs3: Enhance the attribute size check

Eric Dumazet (2):
      ipv4: properly combine dev_base_seq and ipv4.dev_addr_genid
      ipv6: properly combine dev_base_seq and ipv6.dev_addr_genid

Erik Kurzinger (1):
      drm/syncobj: call drm_syncobj_fence_add_wait when WAIT_AVAILABLE flag is set

Eugen Hristev (1):
      pmdomain: mediatek: fix race conditions with genpd

Felix Fietkau (1):
      wifi: mac80211: fix race condition on enabling fast-xmit

Florian Westphal (2):
      netfilter: nf_tables: set dormant flag on hook register failure
      netfilter: nf_tables: use kzalloc for hook allocation

Frank Li (2):
      usb: cdns3: fixed memory use after free at cdns3_gadget_ep_disable()
      usb: cdns3: fix memory double free when handle zero packet

Fullway Wang (2):
      fbdev: savage: Error out if pixclock equals zero
      fbdev: sis: Error out if pixclock equals zero

Gao Xiang (2):
      erofs: simplify compression configuration parser
      erofs: fix inconsistent per-file compression format

Geert Uytterhoeven (1):
      pmdomain: renesas: r8a77980-sysc: CR7 must be always on

Geliang Tang (4):
      mptcp: make userspace_pm_append_new_local_addr static
      mptcp: add needs_id for userspace appending addr
      mptcp: userspace pm send RM_ADDR for ID 0
      mptcp: add needs_id for netlink appending addr

Gianmarco Lusvardi (1):
      bpf, scripts: Correct GPL license name

Greg Kroah-Hartman (1):
      Linux 6.1.80

Guixin Liu (1):
      nvmet-tcp: fix nvme tcp ida memory leak

Hannes Reinecke (1):
      scsi: lpfc: Use unsigned type for num_sge

Hans de Goede (3):
      Input: goodix - accept ACPI resources with gpio_count == 3 && gpio_int_idx == 0
      platform/x86: intel-vbtn: Stop calling "VBDL" from notify_handler
      platform/x86: touchscreen_dmi: Allow partial (prefix) matches for ACPI names

Hector Martin (1):
      dmaengine: apple-admac: Keep upper bits of REG_BUS_WIDTH

Heiko Stuebner (1):
      arm64: dts: rockchip: set num-cs property for spi on px30

Helge Deller (1):
      Revert "parisc: Only list existing CPUs in cpu_possible_mask"

Horatiu Vultur (1):
      net: sparx5: Add spinlock for frame transmission from CPU

Huacai Chen (1):
      LoongArch: Disable IRQ before init_fn() for nonboot CPUs

Huang Pei (1):
      MIPS: reserve exception vector space ONLY ONCE

Ism Hong (1):
      fs/ntfs3: use non-movable memory for ntfs3 MFT buffer cache

Jamal Hadi Salim (3):
      net/sched: Retire CBQ qdisc
      net/sched: Retire ATM qdisc
      net/sched: Retire dsmark qdisc

Jan Kiszka (1):
      riscv/efistub: Ensure GP-relative addressing is not used

Jason Gunthorpe (1):
      s390: use the correct count for __iowrite64_copy()

Jeremy Kerr (1):
      net: mctp: put sock on tag allocation failure

Joao Martins (3):
      iommufd/iova_bitmap: Bounds check mapped::pages access
      iommufd/iova_bitmap: Switch iova_bitmap::bitmap to an u8 array
      iommufd/iova_bitmap: Consider page offset for the pages to be pinned

Johannes Berg (2):
      wifi: mac80211: set station RX-NSS on reconfig
      wifi: mac80211: adding missing drv_mgd_complete_tx() call

Johannes Weiner (1):
      mm: memcontrol: clarify swapaccount=0 deprecation warning

Justin Iurman (1):
      Fix write to cloned skb in ipv6_hop_ioam()

Kairui Song (1):
      mm/swap: fix race when skipping swapcache

Kalesh AP (1):
      RDMA/bnxt_re: Return error for SRQ resize

Kamal Heib (1):
      RDMA/qedr: Fix qedr_create_user_qp error flow

Kees Cook (2):
      smb: Work around Clang __bdos() type confusion
      net: dev: Convert sa_data to flexible array in struct sockaddr

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

Kuniyuki Iwashima (2):
      dccp/tcp: Unhash sk from ehash for tb2 alloc failure after check_estalblished().
      arp: Prevent overflow in arp_req_get().

Kunwu Chan (1):
      dmaengine: ti: edma: Add some null pointer checks to the edma_probe

Lennert Buytenhek (2):
      ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers
      ahci: Extend ASM1061 43-bit DMA address quirk to other ASM106x parts

Lino Sanfilippo (1):
      serial: amba-pl011: Fix DMA transmission in RS485 mode

Maksim Kiselev (1):
      aoe: avoid potential deadlock at set_capacity

Mario Limonciello (1):
      platform/x86: thinkpad_acpi: Only update profile if successfully converted

Mark Brown (1):
      arm64/sme: Restore SME registers on exit from suspend

Martin Blumenstingl (1):
      regulator: pwm-regulator: Add validity checks in continuous .get_voltage

Martin K. Petersen (1):
      scsi: core: Consult supported VPD page list prior to fetching page

Martin KaFai Lau (1):
      bpf: Fix racing between bpf_timer_cancel_and_free and bpf_timer_cancel

Masahiro Yamada (2):
      LoongArch: Select ARCH_ENABLE_THP_MIGRATION instead of redefining it
      LoongArch: Select HAVE_ARCH_SECCOMP to use the common SECCOMP menu

Michal Kazior (1):
      wifi: cfg80211: fix missing interfaces when dumping

Mike Marciniszyn (1):
      RDMA/irdma: Fix KASAN issue with tasklet

Mikulas Patocka (4):
      dm-crypt: recheck the integrity tag after a failure
      dm-integrity: recheck the integrity tag after a failure
      dm-crypt: don't modify the data when using authenticated encryption
      dm-verity: recheck the hash after a failure

Mustafa Ismail (2):
      RDMA/irdma: Set the CQ read threshold for GEN 1
      RDMA/irdma: Add AE for too many RNRS

Nam Cao (1):
      irqchip/sifive-plic: Enable interrupt if needed before EOI

Naohiro Aota (1):
      scsi: target: pscsi: Fix bio_put() for error case

Nikita Shubin (1):
      ARM: ep93xx: Add terminator to gpiod_lookup_table

Oliver Upton (3):
      KVM: arm64: vgic-its: Test for valid IRQ in MOVALL handler
      KVM: arm64: vgic-its: Test for valid IRQ in its_sync_lpi_pending_table()
      irqchip/gic-v3-its: Do not assume vPE tables are preallocated

Pablo Neira Ayuso (5):
      netfilter: flowtable: simplify route logic
      netfilter: nft_flow_offload: reset dst in route object after setting up flow
      netfilter: nft_flow_offload: release dst in case direct xmit path is used
      netfilter: nf_tables: rename function to destroy hook list
      netfilter: nf_tables: register hooks last when adding new chain/flowtable

Paolo Abeni (1):
      mptcp: fix lockless access in subflow ULP diag

Paulo Alcantara (2):
      smb: client: increase number of PDUs allowed in a compound request
      smb: client: set correct d_type for reparse points under DFS mounts

Pavel Sakharov (1):
      net: stmmac: Fix incorrect dereference in interrupt handlers

Pawel Laszczak (2):
      usb: cdnsp: blocked some cdns3 specific code
      usb: cdnsp: fixed issue with incorrect detecting CDNSP family controllers

Peter Oberparleiter (1):
      s390/cio: fix invalid -EBUSY on ccw_device_start

Peter Zijlstra (2):
      x86/returnthunk: Allow different return thunks
      x86/alternative: Make custom return thunk unconditional

Phoenix Chen (1):
      platform/x86: touchscreen_dmi: Add info for the TECLAST X16 Plus tablet

Prike Liang (2):
      drm/amdgpu: skip to program GFXDEC registers for suspend abort
      drm/amdgpu: reset gpu for s3 suspend abort case

Radhey Shyam Pandey (1):
      ata: ahci_ceva: fix error handling for Xilinx GT PHY support

Randy Dunlap (1):
      scsi: jazz_esp: Only build if SCSI core is builtin

Richard Fitzgerald (1):
      ASoC: wm_adsp: Don't overwrite fwf_name with the default

Robert Richter (1):
      cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS window

Rémi Denis-Courmont (2):
      phonet: take correct lock to peek at the RX queue
      phonet/pep: fix racy skb_queue_empty() use

SEO HOYOUNG (1):
      scsi: ufs: core: Remove the ufshcd_release() in ufshcd_err_handling_prepare()

Sabrina Dubroca (3):
      tls: break out of main loop when PEEK gets a non-data record
      tls: stop recv() if initial process_rx_list gave us non-DATA
      tls: don't skip over different type records from the rx_list

Sandeep Dhavale (1):
      erofs: fix refcount on the metabuf used for inode lookup

SeongJae Park (2):
      mm/damon/lru_sort: fix quota status loss due to online tunings
      mm/damon/reclaim: fix quota stauts loss due to online tunings

Shigeru Yoshida (1):
      bpf, sockmap: Fix NULL pointer dereference in sk_psock_verdict_data_ready()

Shiraz Saleem (1):
      RDMA/irdma: Validate max_send_wr and max_recv_wr

Shyam Prasad N (2):
      cifs: open_cached_dir should not rely on primary channel
      cifs: translate network errors on send to -ECONNABORTED

Siddharth Vadapalli (1):
      net: phy: realtek: Fix rtl8211f_config_init() for RTL8211F(D)(I)-VD-CG PHY

Sohaib Nadeem (2):
      drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz
      Revert "drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz"

Steve French (1):
      smb3: clarify mount warning

Subbaraya Sundeep (1):
      octeontx2-af: Consider the action set by PF

Szilard Fabian (1):
      Input: i8042 - add Fujitsu Lifebook U728 to i8042 quirk table

Szuying Chen (1):
      ata: ahci: add identifiers for ASM2116 series adapters

Takashi Sakamoto (1):
      firewire: core: send bus reset promptly on gap count error

Thinh Nguyen (1):
      usb: dwc3: gadget: Don't disconnect if not started

Thomas Hellström (1):
      drm/ttm: Fix an invalid freeing on already freed page in error path

Tobias Waldekranz (2):
      net: bridge: switchdev: Skip MDB replays of deferred events on offload
      net: bridge: switchdev: Ensure deferred event delivery on unoffload

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

Will Deacon (1):
      misc: open-dice: Fix spurious lockdep warning

Wolfram Sang (1):
      spi: sh-msiof: avoid integer overflow in constants

Xin Long (1):
      netfilter: conntrack: check SCTP_CID_SHUTDOWN_ACK for vtag setting in sctp_new

Xu Yang (2):
      usb: roles: fix NULL pointer issue when put module's reference
      usb: roles: don't get/set_role() when usb_role_switch is unregistered

Yi Sun (1):
      virtio-blk: Ensure no requests in virtqueues before deleting vqs.

Yosry Ahmed (1):
      mm: zswap: fix missing folio cleanup in writeback race path

Yu Kuai (1):
      md: Fix missing release of 'active_io' for flush

Zhang Rui (1):
      hwmon: (coretemp) Enlarge per package core count limit

Zhang Yi (1):
      ext4: correct the hole length returned by ext4_map_blocks()

Zhipeng Lu (1):
      IB/hfi1: Fix a memleak in init_credit_return

zhenwei pi (1):
      crypto: virtio/akcipher - Fix stack overflow on memcpy


