Return-Path: <linux-kernel+bounces-88450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EBA86E1BE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A606283D62
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328996E604;
	Fri,  1 Mar 2024 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="whhaUHwJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8396E5E8;
	Fri,  1 Mar 2024 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298954; cv=none; b=nhX2a1MKnuYtiRtj4oA+7ZPMLUN6yCs/q58we22iTb/MrUJZXxLQgXtdEXWxRMC9vthVsShUqo+YNU+uzNnfNijSiAcHK3jpKWU38WV4eOKW5PerJesTVy7WA/pm2J9IyY2Ny4Ecl7Z0iKGR5+IjPckkUXo9pzOqZhOCneyjxd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298954; c=relaxed/simple;
	bh=vO14Z8Fwvba+1zuHPMwDGGa1i/oDve9CNV/+fsMzrSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YJSE0C+Tdqg5rQqFD9dj+opxQAimKO4mL4WNzvLfPDc3euvEDitdL8ibkHi+T8FriO9vEZGMUPOyFvfZDCQjRQ8T2rvxZlOq7d5J31V7GGONkUzvrHxQ1uKqhX9gnIpa40c9H/M9xzVGsaP4VG3Zs0WcY2EwZ7qbv/glSI2Z9M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=whhaUHwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9867DC433C7;
	Fri,  1 Mar 2024 13:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709298954;
	bh=vO14Z8Fwvba+1zuHPMwDGGa1i/oDve9CNV/+fsMzrSI=;
	h=From:To:Cc:Subject:Date:From;
	b=whhaUHwJCHgrjctJ6gA9ZC2Hi0QPuM3/nlTLonTIL69TVUj8Xj7um8DlocVrWYO7/
	 FqxUJD+Pw/6ectFkS/vdmqbFsXFg+bwblg463pge3hdb/OqVVgH6oI7Tl3tLsh58VW
	 WN4D4jMUcougzrTCPDgXdGaIVmh3+jCCxR59EHA4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.211
Date: Fri,  1 Mar 2024 14:15:39 +0100
Message-ID: <2024030140-spendable-turtle-d886@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.211 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                          |    2 
 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts     |    1 
 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts      |    2 
 arch/arm/boot/dts/imx6sx.dtsi                     |    6 
 arch/arm/mach-ep93xx/core.c                       |    1 
 arch/arm64/boot/dts/rockchip/px30.dtsi            |    2 
 arch/arm64/kvm/vgic/vgic-its.c                    |    5 
 arch/powerpc/kernel/hw_breakpoint.c               |   76 
 arch/s390/pci/pci.c                               |    2 
 arch/x86/include/asm/cpu_entry_area.h             |    2 
 arch/x86/include/asm/nospec-branch.h              |    2 
 arch/x86/include/asm/text-patching.h              |   30 
 arch/x86/include/asm/uaccess.h                    |  142 +
 arch/x86/kernel/alternative.c                     |   13 
 arch/x86/kernel/ftrace.c                          |    4 
 arch/x86/kernel/paravirt.c                        |   22 
 arch/x86/kernel/static_call.c                     |    2 
 arch/x86/net/bpf_jit_comp.c                       |    2 
 drivers/ata/ahci.c                                |   34 
 drivers/ata/ahci.h                                |    1 
 drivers/block/ataflop.c                           |   56 
 drivers/block/virtio_blk.c                        |    7 
 drivers/dma/fsl-qdma.c                            |    2 
 drivers/dma/sh/shdma.h                            |    2 
 drivers/dma/ti/edma.c                             |   10 
 drivers/firewire/core-card.c                      |   18 
 drivers/firmware/efi/arm-runtime.c                |    2 
 drivers/firmware/efi/efi-init.c                   |   19 
 drivers/firmware/efi/riscv-runtime.c              |    2 
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    1 
 drivers/gpu/drm/drm_syncobj.c                     |   16 
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c |    8 
 drivers/hwmon/coretemp.c                          |    2 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c          |    5 
 drivers/infiniband/hw/hfi1/pio.c                  |    6 
 drivers/infiniband/hw/hfi1/sdma.c                 |    2 
 drivers/infiniband/hw/qedr/verbs.c                |   11 
 drivers/infiniband/ulp/srpt/ib_srpt.c             |   17 
 drivers/input/serio/i8042-acpipnpio.h             |    8 
 drivers/irqchip/irq-mips-gic.c                    |    2 
 drivers/md/dm-crypt.c                             |    6 
 drivers/media/pci/ttpci/av7110_av.c               |    4 
 drivers/mtd/nand/spi/macronix.c                   |   20 
 drivers/net/ethernet/microchip/lan743x_ethtool.c  |    9 
 drivers/net/gtp.c                                 |   10 
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |   14 
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c      |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c     |   10 
 drivers/nvme/host/fc.c                            |   47 
 drivers/nvme/target/fc.c                          |   11 
 drivers/nvme/target/fcloop.c                      |    6 
 drivers/nvme/target/tcp.c                         |    1 
 drivers/pci/msi.c                                 |    2 
 drivers/platform/x86/intel-vbtn.c                 |    6 
 drivers/regulator/pwm-regulator.c                 |    3 
 drivers/s390/cio/device_ops.c                     |    6 
 drivers/scsi/Kconfig                              |    2 
 drivers/scsi/lpfc/lpfc_scsi.c                     |   12 
 drivers/soc/renesas/r8a77980-sysc.c               |    3 
 drivers/spi/spi-hisi-sfc-v3xx.c                   |    5 
 drivers/spi/spi-sh-msiof.c                        |   16 
 drivers/target/target_core_device.c               |    5 
 drivers/target/target_core_transport.c            |    4 
 drivers/tty/hvc/hvc_xen.c                         |   19 
 drivers/usb/cdns3/gadget.c                        |    8 
 drivers/usb/gadget/function/f_ncm.c               |   10 
 drivers/usb/roles/class.c                         |   29 
 drivers/video/fbdev/savage/savagefb_driver.c      |    3 
 drivers/video/fbdev/sis/sis_main.c                |    2 
 fs/afs/volume.c                                   |    4 
 fs/aio.c                                          |    9 
 fs/btrfs/ctree.h                                  |    2 
 fs/btrfs/dir-item.c                               |  122 -
 fs/btrfs/inode.c                                  |   48 
 fs/btrfs/tree-checker.c                           |   25 
 fs/btrfs/tree-log.c                               |   14 
 fs/cifs/smb2ops.c                                 |   19 
 fs/cifs/smb2pdu.c                                 |   93 -
 fs/cifs/smb2proto.h                               |   12 
 fs/erofs/decompressor.c                           |   24 
 fs/ext4/extents.c                                 |  111 -
 fs/ext4/mballoc.c                                 |   33 
 fs/jbd2/checkpoint.c                              |  137 -
 fs/zonefs/super.c                                 |   68 
 include/linux/fs.h                                |    2 
 include/linux/lockdep.h                           |    5 
 include/linux/sched/task_stack.h                  |    2 
 include/linux/socket.h                            |    5 
 include/net/tcp.h                                 |    2 
 kernel/sched/rt.c                                 |   10 
 kernel/seccomp.c                                  |   10 
 kernel/sysctl.c                                   |    4 
 mm/userfaultfd.c                                  |   14 
 net/core/dev.c                                    |    2 
 net/core/dev_ioctl.c                              |    2 
 net/hsr/hsr_framereg.c                            |   16 
 net/hsr/hsr_framereg.h                            |    1 
 net/ipv4/arp.c                                    |    3 
 net/ipv4/devinet.c                                |   21 
 net/ipv6/addrconf.c                               |   21 
 net/ipv6/seg6.c                                   |   20 
 net/l2tp/l2tp_ip6.c                               |    2 
 net/mac80211/sta_info.c                           |    2 
 net/mac80211/tx.c                                 |    2 
 net/mptcp/diag.c                                  |    6 
 net/netfilter/nf_conntrack_proto_sctp.c           |    2 
 net/netfilter/nf_tables_api.c                     |    1 
 net/packet/af_packet.c                            |   12 
 net/sched/Kconfig                                 |   42 
 net/sched/Makefile                                |    3 
 net/sched/sch_atm.c                               |  709 --------
 net/sched/sch_cbq.c                               | 1816 ----------------------
 net/sched/sch_dsmark.c                            |  521 ------
 net/tls/tls_main.c                                |    2 
 net/tls/tls_sw.c                                  |   12 
 net/wireless/nl80211.c                            |    1 
 scripts/bpf_helpers_doc.py                        |    2 
 sound/soc/fsl/fsl_micfil.c                        |   15 
 sound/soc/intel/boards/bytcht_es8316.c            |   14 
 sound/soc/intel/boards/bytcr_rt5640.c             |   46 
 sound/soc/intel/boards/bytcr_rt5651.c             |   41 
 sound/soc/sunxi/sun4i-spdif.c                     |    5 
 123 files changed, 1257 insertions(+), 3684 deletions(-)

Andrew Bresticker (2):
      efi: runtime: Fix potential overflow of soft-reserved region size
      efi: Don't add memblocks for soft-reserved memory

Andy Shevchenko (1):
      ASoC: Intel: bytcr_rt5651: Drop reference count of ACPI device after use

Armin Wolf (1):
      drm/amd/display: Fix memory leak in dm_sw_fini()

Arnd Bergmann (2):
      RDMA/srpt: fix function pointer cast warnings
      nouveau: fix function cast warnings

Baokun Li (3):
      ext4: avoid allocating blocks from corrupted group in ext4_mb_try_best_found()
      ext4: avoid allocating blocks from corrupted group in ext4_mb_find_by_goal()
      ext4: regenerate buddy after block freeing failed if under fc replay

Bart Van Assche (2):
      RDMA/srpt: Support specifying the srpt_service_guid parameter
      fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio

Benjamin Gray (1):
      powerpc/watchpoints: Annotate atomic context in more places

Borislav Petkov (1):
      task_stack, x86/cea: Force-inline stack helpers

Borislav Petkov (AMD) (2):
      Revert "x86/ftrace: Use alternative RET encoding"
      Revert "x86/alternative: Make custom return thunk unconditional"

Chen-Yu Tsai (1):
      ASoC: sunxi: sun4i-spdif: Add support for Allwinner H616

Christian König (1):
      drm/syncobj: make lockdep complain on WAIT_FOR_SUBMIT v3

Conrad Kostecki (1):
      ahci: asm1166: correct count of reported ports

Cyril Hrubis (3):
      sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset
      sched/rt: Fix sysctl_sched_rr_timeslice intial value
      sched/rt: Disallow writing invalid values to sched_rt_period_us

Damien Le Moal (1):
      zonefs: Improve error handling

Dan Carpenter (1):
      media: av7110: prevent underflow in write_ts_to_decoder()

Daniel Vacek (1):
      IB/hfi1: Fix sdma.h tx->num_descs off-by-one error

Daniel Wagner (4):
      nvme-fc: do not wait in vain when unloading module
      nvmet-fcloop: swap the list_add_tail arguments
      nvmet-fc: release reference on target port
      nvmet-fc: abort command when there is no binding

Daniil Dulov (1):
      afs: Increase buffer size in afs_update_volume_status()

Devyn Liu (1):
      spi: hisi-sfc-v3xx: Return IRQ_NONE if no interrupts were detected

Dmitry Bogdanov (1):
      scsi: target: core: Add TMF to tmr_list handling

Eric Dumazet (2):
      ipv4: properly combine dev_base_seq and ipv4.dev_addr_genid
      ipv6: properly combine dev_base_seq and ipv6.dev_addr_genid

Erik Kurzinger (1):
      drm/syncobj: call drm_syncobj_fence_add_wait when WAIT_AVAILABLE flag is set

Felix Fietkau (1):
      wifi: mac80211: fix race condition on enabling fast-xmit

Filipe Manana (2):
      btrfs: unify lookup return value when dir entry is missing
      btrfs: do not pin logs too early during renames

Florian Westphal (1):
      netfilter: nf_tables: set dormant flag on hook register failure

Frank Li (2):
      usb: cdns3: fixed memory use after free at cdns3_gadget_ep_disable()
      usb: cdns3: fix memory double free when handle zero packet

Fullway Wang (2):
      fbdev: savage: Error out if pixclock equals zero
      fbdev: sis: Error out if pixclock equals zero

Gao Xiang (1):
      erofs: fix lz4 inplace decompression

Geert Uytterhoeven (1):
      pmdomain: renesas: r8a77980-sysc: CR7 must be always on

Gianmarco Lusvardi (1):
      bpf, scripts: Correct GPL license name

Greg Kroah-Hartman (1):
      Linux 5.10.211

Guixin Liu (1):
      nvmet-tcp: fix nvme tcp ida memory leak

Hannes Reinecke (1):
      scsi: lpfc: Use unsigned type for num_sge

Heiko Stuebner (1):
      arm64: dts: rockchip: set num-cs property for spi on px30

Jakub Kicinski (2):
      tls: rx: jump to a more appropriate label
      tls: rx: drop pointless else after goto

Jamal Hadi Salim (3):
      net/sched: Retire CBQ qdisc
      net/sched: Retire ATM qdisc
      net/sched: Retire dsmark qdisc

Jan Beulich (1):
      x86: drop bogus "cc" clobber from __try_cmpxchg_user_asm()

Jason Gunthorpe (1):
      s390: use the correct count for __iowrite64_copy()

Jiaxun Yang (1):
      irqchip/mips-gic: Don't touch vl_map if a local interrupt is not routable

Johannes Berg (2):
      iwlwifi: mvm: do more useful queue sync accounting
      iwlwifi: mvm: write queue_sync_state only for sync

Josef Bacik (1):
      btrfs: tree-checker: check for overlapping extent items

Kalesh AP (1):
      RDMA/bnxt_re: Return error for SRQ resize

Kamal Heib (1):
      RDMA/qedr: Fix qedr_create_user_qp error flow

Kees Cook (2):
      seccomp: Invalidate seccomp mode to catch death failures
      net: dev: Convert sa_data to flexible array in struct sockaddr

Krishna Kurapati (1):
      usb: gadget: ncm: Avoid dropping datagrams of properly parsed NTBs

Kuniyuki Iwashima (1):
      arp: Prevent overflow in arp_req_get().

Kunwu Chan (1):
      dmaengine: ti: edma: Add some null pointer checks to the edma_probe

Lennert Buytenhek (1):
      ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers

Lokesh Gidra (1):
      userfaultfd: fix mmap_changing checking in mfill_atomic_hugetlb

Marcos Paulo de Souza (1):
      btrfs: introduce btrfs_lookup_match_dir

Martin Blumenstingl (1):
      regulator: pwm-regulator: Add validity checks in continuous .get_voltage

Max Verevkin (1):
      platform/x86: intel-vbtn: Support for tablet mode on HP Pavilion 13 x360 PC

Michael Schmitz (2):
      block: ataflop: fix breakage introduced at blk-mq refactoring
      block: ataflop: more blk-mq refactoring fixes

Michal Kazior (1):
      wifi: cfg80211: fix missing interfaces when dumping

Mikulas Patocka (1):
      dm-crypt: don't modify the data when using authenticated encryption

Nikita Shubin (1):
      ARM: ep93xx: Add terminator to gpiod_lookup_table

Oliver Upton (2):
      KVM: arm64: vgic-its: Test for valid IRQ in MOVALL handler
      KVM: arm64: vgic-its: Test for valid IRQ in its_sync_lpi_pending_table()

Paolo Abeni (1):
      mptcp: fix lockless access in subflow ULP diag

Paulo Alcantara (3):
      smb: client: fix OOB in receive_encrypted_standard()
      smb: client: fix potential OOBs in smb2_parse_contexts()
      smb: client: fix parsing of SMB3.1.1 POSIX create context

Peter Oberparleiter (1):
      s390/cio: fix invalid -EBUSY on ccw_device_start

Peter Zijlstra (6):
      x86/uaccess: Implement macros for CMPXCHG on user addresses
      x86/text-patching: Make text_gen_insn() play nice with ANNOTATE_NOENDBR
      x86/ibt,paravirt: Use text_gen_insn() for paravirt_patch()
      x86/ftrace: Use alternative RET encoding
      x86/returnthunk: Allow different return thunks
      x86/alternative: Make custom return thunk unconditional

Pierre-Louis Bossart (2):
      ASoC: Intel: boards: harden codec property handling
      ASoC: Intel: boards: get codec device with ACPI instead of bus search

Rafał Miłecki (1):
      ARM: dts: BCM53573: Drop nonexistent "default-off" LED trigger

Randy Dunlap (1):
      scsi: jazz_esp: Only build if SCSI core is builtin

Ravi Bangoria (1):
      powerpc/watchpoint: Workaround P10 DD1 issue with VSX-32 byte instructions

Roger Pau Monne (1):
      hvc/xen: prevent concurrent accesses to the shared ring

Sabrina Dubroca (1):
      tls: stop recv() if initial process_rx_list gave us non-DATA

Sebastian Andrzej Siewior (1):
      hsr: Avoid double remove of a node.

Sergej Bauer (1):
      lan743x: fix for potential NULL pointer dereference with bare card

Shengjiu Wang (1):
      ASoC: fsl_micfil: register platform component before registering cpu dai

Shyam Prasad N (1):
      cifs: add a warning when the in-flight count goes negative

Szilard Fabian (1):
      Input: i8042 - add Fujitsu Lifebook U728 to i8042 quirk table

Takashi Sakamoto (1):
      firewire: core: send bus reset promptly on gap count error

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

Wolfram Sang (2):
      spi: sh-msiof: avoid integer overflow in constants
      packet: move from strlcpy with unused retval to strscpy

Xiaolei Wang (1):
      ARM: dts: imx: Set default tuning step for imx6sx usdhc

Xin Long (1):
      netfilter: conntrack: check SCTP_CID_SHUTDOWN_ACK for vtag setting in sctp_new

Xu Yang (2):
      usb: roles: fix NULL pointer issue when put module's reference
      usb: roles: don't get/set_role() when usb_role_switch is unregistered

Yi Sun (1):
      virtio-blk: Ensure no requests in virtqueues before deleting vqs.

YouChing Lin (1):
      mtd: spinand: macronix: Add support for MX35LFxGE4AD

Zhang Rui (1):
      hwmon: (coretemp) Enlarge per package core count limit

Zhang Yi (3):
      ext4: correct the hole length returned by ext4_map_blocks()
      jbd2: remove redundant buffer io error checks
      jbd2: recheck chechpointing non-dirty buffer

Zhihao Cheng (1):
      jbd2: Fix wrongly judgement for buffer head removing while doing checkpoint

Zhipeng Lu (1):
      IB/hfi1: Fix a memleak in init_credit_return


