Return-Path: <linux-kernel+bounces-88447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB9386E1B5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE9D1F226E3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CDB6F506;
	Fri,  1 Mar 2024 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PBuGuqpo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB886D518;
	Fri,  1 Mar 2024 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298942; cv=none; b=E6O1GbrybshPtQOeP5dN8SF1w3Qh8ViIeXMh7EhivqXh/tRvhETwp+rks/ULKtjj2ExiAj9lJLOj2lA0CiU6bLznlMq1Tt8O5u//POFEHvYlkjMXeGLQ/Am4yl3HBb3f8/iuJ9FxAkkKlD6YBOadD8M1kK8Jp315vmvWBob58sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298942; c=relaxed/simple;
	bh=5F9m28hQfmy/sFGpqaLgJsTBHPDSynCfhbg7qGPS8gU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UhqRsYmhr8H3qgVlHMdHqX5CWNROV6WOTtFIwoVL1BZyBs+8kVT9hDhuXUF7fXPFUZOHydkEUgBUndvwYKEctpUukMsJmnFnxk1CJ6QIwoJhphp49mtMqIBVftZYhjSrhcfqIc0cHzHgZBITyj/sGRktjWQ+Exj/ZG8tyKVlajM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PBuGuqpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B497AC433C7;
	Fri,  1 Mar 2024 13:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709298942;
	bh=5F9m28hQfmy/sFGpqaLgJsTBHPDSynCfhbg7qGPS8gU=;
	h=From:To:Cc:Subject:Date:From;
	b=PBuGuqpooSk057CuHumdNpVoX+3tp8nYWBHEbZNlEX6utWtPEZClJruQQ6dLWXGJn
	 Q5o/KGA7VTIuNOh64IYNJ1Bn6LrCthkqMcPp+aMuKKXy2glcSduCewfA78iykHaWyA
	 kPWVtGfWRidWX/MxTwEfv2eAgKaSe/6KvrRkAreg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.270
Date: Fri,  1 Mar 2024 14:15:34 +0100
Message-ID: <2024030134-wool-heave-1282@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.270 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                          |    2 
 arch/arm/mach-ep93xx/core.c                       |    1 
 arch/arm64/boot/dts/qcom/msm8916.dtsi             |    4 
 arch/s390/pci/pci.c                               |    2 
 arch/x86/kernel/alternative.c                     |   13 
 drivers/ata/ahci.c                                |   34 
 drivers/ata/ahci.h                                |    1 
 drivers/block/virtio_blk.c                        |    7 
 drivers/dma/fsl-qdma.c                            |    2 
 drivers/dma/sh/shdma.h                            |    2 
 drivers/firewire/core-card.c                      |   18 
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c           |    3 
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h          |    5 
 drivers/gpu/drm/drm_syncobj.c                     |   16 
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c |    8 
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c            |    3 
 drivers/hwmon/coretemp.c                          |    2 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c          |    5 
 drivers/infiniband/hw/hfi1/pio.c                  |    6 
 drivers/infiniband/hw/hfi1/sdma.c                 |    2 
 drivers/infiniband/ulp/srpt/ib_srpt.c             |   18 
 drivers/md/dm-crypt.c                             |    6 
 drivers/md/dm-integrity.c                         |   11 
 drivers/net/gtp.c                                 |   10 
 drivers/nvme/target/fc.c                          |    8 
 drivers/nvme/target/tcp.c                         |    1 
 drivers/pci/controller/pci-tegra.c                |   17 
 drivers/pci/msi.c                                 |    2 
 drivers/pinctrl/pinctrl-rockchip.c                |   23 
 drivers/regulator/pwm-regulator.c                 |    3 
 drivers/s390/net/qeth_l3_main.c                   |    9 
 drivers/scsi/Kconfig                              |    2 
 drivers/scsi/lpfc/lpfc_scsi.c                     |   12 
 drivers/soc/renesas/r8a77980-sysc.c               |    3 
 drivers/spi/spi-mt7621.c                          |    8 
 drivers/target/target_core_device.c               |    5 
 drivers/target/target_core_transport.c            |    4 
 drivers/usb/cdns3/gadget.c                        |    8 
 drivers/usb/gadget/function/f_ncm.c               |   10 
 drivers/usb/roles/class.c                         |   12 
 drivers/video/fbdev/savage/savagefb_driver.c      |    3 
 drivers/video/fbdev/sis/sis_main.c                |    2 
 fs/afs/volume.c                                   |    4 
 fs/aio.c                                          |    9 
 fs/ext4/mballoc.c                                 |   13 
 fs/iomap/buffered-io.c                            |    3 
 fs/nilfs2/dat.c                                   |   27 
 include/linux/fs.h                                |    2 
 include/linux/lockdep.h                           |    5 
 include/net/tcp.h                                 |    1 
 kernel/sched/rt.c                                 |   10 
 kernel/sysctl.c                                   |    4 
 mm/memcontrol.c                                   |    6 
 mm/userfaultfd.c                                  |   14 
 net/bridge/br_device.c                            |    2 
 net/ipv4/af_inet.c                                |    2 
 net/ipv4/devinet.c                                |   21 
 net/ipv4/tcp.c                                    |   27 
 net/ipv4/tcp_input.c                              |    4 
 net/ipv6/addrconf.c                               |   21 
 net/ipv6/seg6.c                                   |   20 
 net/l2tp/l2tp_ip6.c                               |    2 
 net/mac80211/sta_info.c                           |    2 
 net/mac80211/tx.c                                 |    2 
 net/netfilter/nf_conntrack_proto_sctp.c           |    2 
 net/netfilter/nf_tables_api.c                     |    1 
 net/packet/af_packet.c                            |    4 
 net/sched/Kconfig                                 |   42 
 net/sched/Makefile                                |    3 
 net/sched/sch_atm.c                               |  710 --------
 net/sched/sch_cbq.c                               | 1818 ----------------------
 net/sched/sch_dsmark.c                            |  523 ------
 net/tls/tls_sw.c                                  |   12 
 net/wireless/nl80211.c                            |    1 
 scripts/bpf_helpers_doc.py                        |  157 +
 sound/pci/hda/patch_realtek.c                     |    6 
 sound/soc/sunxi/sun4i-spdif.c                     |    5 
 tools/testing/selftests/bpf/test_verifier.c       |   13 
 virt/kvm/arm/vgic/vgic-its.c                      |    5 
 79 files changed, 562 insertions(+), 3254 deletions(-)

Alexandra Winter (1):
      s390/qeth: Fix potential loss of L3-IP@ in case of network issues

Andrii Nakryiko (2):
      scripts/bpf: teach bpf_helpers_doc.py to dump BPF helper definitions
      scripts/bpf: Fix xdp_md forward declaration typo

Arnd Bergmann (2):
      RDMA/srpt: fix function pointer cast warnings
      nouveau: fix function cast warnings

Baokun Li (2):
      ext4: avoid allocating blocks from corrupted group in ext4_mb_try_best_found()
      ext4: avoid allocating blocks from corrupted group in ext4_mb_find_by_goal()

Bart Van Assche (2):
      RDMA/srpt: Make debug output more detailed
      fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio

Björn Töpel (1):
      selftests/bpf: Avoid running unprivileged tests with alignment requirements

Chen-Yu Tsai (1):
      ASoC: sunxi: sun4i-spdif: Add support for Allwinner H616

Christian König (1):
      drm/syncobj: make lockdep complain on WAIT_FOR_SUBMIT v3

Christophe JAILLET (2):
      spi: mt7621: Fix an error message in mt7621_spi_probe()
      PCI: tegra: Fix OF node reference leak

Conrad Kostecki (1):
      ahci: asm1166: correct count of reported ports

Cyril Hrubis (3):
      sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset
      sched/rt: Fix sysctl_sched_rr_timeslice intial value
      sched/rt: Disallow writing invalid values to sched_rt_period_us

Daniel Vacek (1):
      IB/hfi1: Fix sdma.h tx->num_descs off-by-one error

Daniel Wagner (1):
      nvmet-fc: abort command when there is no binding

Daniil Dulov (1):
      afs: Increase buffer size in afs_update_volume_status()

Dmitry Bogdanov (1):
      scsi: target: core: Add TMF to tmr_list handling

Eric Dumazet (3):
      tcp: add annotations around sk->sk_shutdown accesses
      ipv4: properly combine dev_base_seq and ipv4.dev_addr_genid
      ipv6: properly combine dev_base_seq and ipv6.dev_addr_genid

Erik Kurzinger (1):
      drm/syncobj: call drm_syncobj_fence_add_wait when WAIT_AVAILABLE flag is set

Felix Fietkau (1):
      wifi: mac80211: fix race condition on enabling fast-xmit

Florian Westphal (1):
      netfilter: nf_tables: set dormant flag on hook register failure

Frank Li (2):
      usb: cdns3: fixed memory use after free at cdns3_gadget_ep_disable()
      usb: cdns3: fix memory double free when handle zero packet

Fullway Wang (2):
      fbdev: savage: Error out if pixclock equals zero
      fbdev: sis: Error out if pixclock equals zero

GONG, Ruiqi (1):
      memcg: add refcnt for pcpu stock to avoid UAF problem in drain_all_stock()

Geert Uytterhoeven (1):
      pmdomain: renesas: r8a77980-sysc: CR7 must be always on

Gianmarco Lusvardi (1):
      bpf, scripts: Correct GPL license name

Greg Kroah-Hartman (1):
      Linux 5.4.270

Guixin Liu (1):
      nvmet-tcp: fix nvme tcp ida memory leak

Hannes Reinecke (1):
      scsi: lpfc: Use unsigned type for num_sge

Icenowy Zheng (1):
      Revert "drm/sun4i: dsi: Change the start delay calculation"

Jakub Kicinski (2):
      tls: rx: jump to a more appropriate label
      tls: rx: drop pointless else after goto

Jamal Hadi Salim (3):
      net/sched: Retire CBQ qdisc
      net/sched: Retire ATM qdisc
      net/sched: Retire dsmark qdisc

Jason Gunthorpe (1):
      s390: use the correct count for __iowrite64_copy()

Kai-Heng Feng (1):
      ALSA: hda/realtek - Enable micmute LED on and HP system

Kalesh AP (1):
      RDMA/bnxt_re: Return error for SRQ resize

Kirill A. Shutemov (1):
      x86/alternatives: Disable KASAN in apply_alternatives()

Krishna Kurapati (1):
      usb: gadget: ncm: Avoid dropping datagrams of properly parsed NTBs

Lee Jones (1):
      pinctrl: pinctrl-rockchip: Fix a bunch of kerneldoc misdemeanours

Lennert Buytenhek (1):
      ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers

Lokesh Gidra (1):
      userfaultfd: fix mmap_changing checking in mfill_atomic_hugetlb

Martin Blumenstingl (1):
      regulator: pwm-regulator: Add validity checks in continuous .get_voltage

Matthew Wilcox (Oracle) (1):
      iomap: Set all uptodate bits for an Uptodate page

Miaoqian Lin (1):
      pinctrl: rockchip: Fix refcount leak in rockchip_pinctrl_parse_groups

Michal Kazior (1):
      wifi: cfg80211: fix missing interfaces when dumping

Mikulas Patocka (2):
      dm-integrity: don't modify bio's immutable bio_vec in integrity_metadata()
      dm-crypt: don't modify the data when using authenticated encryption

Nathan Chancellor (1):
      drm/amdgpu: Fix type of second parameter in trans_msg() callback

Nikita Shubin (1):
      ARM: ep93xx: Add terminator to gpiod_lookup_table

Nikolay Aleksandrov (1):
      net: bridge: clear bridge's private skb space on xmit

Oliver Upton (2):
      KVM: arm64: vgic-its: Test for valid IRQ in its_sync_lpi_pending_table()
      KVM: arm64: vgic-its: Test for valid IRQ in MOVALL handler

Pali Rohár (1):
      PCI: tegra: Fix reporting GPIO error value

Paolo Abeni (1):
      tcp: factor out __tcp_close() helper

Randy Dunlap (1):
      scsi: jazz_esp: Only build if SCSI core is builtin

Ryusuke Konishi (1):
      nilfs2: replace WARN_ONs for invalid DAT metadata block requests

Sabrina Dubroca (1):
      tls: stop recv() if initial process_rx_list gave us non-DATA

Sireesh Kodali (1):
      arm64: dts: qcom: msm8916: Fix typo in pronto remoteproc node

Soheil Hassas Yeganeh (1):
      tcp: return EPOLLOUT from tcp_poll only when notsent_bytes is half the limit

Takashi Sakamoto (1):
      firewire: core: send bus reset promptly on gap count error

Tom Parkin (1):
      l2tp: pass correct message length to ip6_append_data

Trek (1):
      drm/amdgpu: Check for valid number of registers to read

Vasiliy Kovalev (2):
      gtp: fix use-after-free and null-ptr-deref in gtp_genl_dump_pdp()
      ipv6: sr: fix possible use-after-free and null-ptr-deref

Vidya Sagar (1):
      PCI/MSI: Prevent MSI hardware interrupt number truncation

Vinod Koul (2):
      dmaengine: shdma: increase size of 'dev_id'
      dmaengine: fsl-qdma: increase size of 'irq_name'

Wolfram Sang (1):
      packet: move from strlcpy with unused retval to strscpy

Xin Long (1):
      netfilter: conntrack: check SCTP_CID_SHUTDOWN_ACK for vtag setting in sctp_new

Xu Yang (1):
      usb: roles: don't get/set_role() when usb_role_switch is unregistered

Yi Sun (1):
      virtio-blk: Ensure no requests in virtqueues before deleting vqs.

Zhang Rui (1):
      hwmon: (coretemp) Enlarge per package core count limit

Zhipeng Lu (1):
      IB/hfi1: Fix a memleak in init_credit_return


