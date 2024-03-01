Return-Path: <linux-kernel+bounces-88445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CAF86E1B1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12161F220DB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9236C6F085;
	Fri,  1 Mar 2024 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yobEm+G1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853076D1C7;
	Fri,  1 Mar 2024 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298933; cv=none; b=gP0FD1VS0P3o1VdyICLutAPsMkiUag5vKsrOUqrgAUSthpSnVxHC5TmSSbkFr1wl6GNU2pBBxtiT5dPB86tECnDrqDUYpRFuq6OTEbXUrcQLEcG21A8Se5bMJMnYQ54+cd8FYR+W8QCwc6b/Dkagt6/fZyFc/0ueu5jGHjL5TKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298933; c=relaxed/simple;
	bh=jFCD2ydHrGro9XnbM8BQ5+gpbO4DPT/CxeUtNKh29Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hnQN04HiA4alxHpUvWylA6BLOck2lsFIkVa//DERr1990JhtYZOa1unmO7L8Dzgq8/0pznCCmOOnfj61sLTbCTOuvjsitmBFqfsV/NeIjsXq+/fS2a62e4y58J63JhJKW+d2VN14JlMZz8Abl4/P88/h16TL3kPT4OUoZ+l6hyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yobEm+G1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3095C433F1;
	Fri,  1 Mar 2024 13:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709298933;
	bh=jFCD2ydHrGro9XnbM8BQ5+gpbO4DPT/CxeUtNKh29Sc=;
	h=From:To:Cc:Subject:Date:From;
	b=yobEm+G1XXnCYacSKpTp5cwk0va0j67IHQPsV7IdHJCLHGu02KgMYRl+8uzwsPHg8
	 ME/SOyE4XQ76v9Q5IXuSSdGryOsZaKrs+gcWHIfGE5KjHiNyNGQD4IPp8JIe0dIgP2
	 80Qz1Z0/dx03de+gr+pXfzypliljU2Na7OEzH6j0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.308
Date: Fri,  1 Mar 2024 14:15:28 +0100
Message-ID: <2024030128-recharger-bullwhip-fa3f@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 4.19.308 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                          |    2 
 arch/arm/mach-ep93xx/core.c                       |    1 
 arch/s390/pci/pci.c                               |    2 
 drivers/ata/ahci.c                                |    5 
 drivers/block/virtio_blk.c                        |    7 
 drivers/dma/sh/shdma.h                            |    2 
 drivers/firewire/core-card.c                      |   18 
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c |    8 
 drivers/hwmon/coretemp.c                          |    2 
 drivers/infiniband/hw/bnxt_re/ib_verbs.c          |    5 
 drivers/infiniband/hw/hfi1/pio.c                  |    6 
 drivers/infiniband/hw/hfi1/sdma.c                 |    2 
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c        |    2 
 drivers/infiniband/ulp/iser/iser_verbs.c          |    9 
 drivers/infiniband/ulp/isert/ib_isert.c           |    2 
 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c   |    3 
 drivers/infiniband/ulp/srp/ib_srp.c               |   10 
 drivers/infiniband/ulp/srpt/ib_srpt.c             |   52 
 drivers/md/dm-crypt.c                             |    6 
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |    2 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |   65 
 drivers/net/gtp.c                                 |   10 
 drivers/pci/msi.c                                 |    2 
 drivers/regulator/pwm-regulator.c                 |    3 
 drivers/s390/net/qeth_l3_main.c                   |    9 
 drivers/scsi/Kconfig                              |    2 
 drivers/soc/renesas/r8a77980-sysc.c               |    3 
 drivers/target/target_core_device.c               |    5 
 drivers/target/target_core_transport.c            |    4 
 drivers/usb/gadget/function/f_ncm.c               |   10 
 drivers/usb/roles/class.c                         |   12 
 drivers/video/fbdev/savage/savagefb_driver.c      |    3 
 drivers/video/fbdev/sis/sis_main.c                |    2 
 fs/aio.c                                          |    9 
 fs/ext4/mballoc.c                                 |   13 
 fs/nilfs2/dat.c                                   |   27 
 include/linux/fs.h                                |    2 
 include/rdma/rdma_vt.h                            |    2 
 kernel/sched/rt.c                                 |   10 
 kernel/sysctl.c                                   |    5 
 mm/memcontrol.c                                   |   23 
 mm/userfaultfd.c                                  |   14 
 net/ipv6/seg6.c                                   |   20 
 net/l2tp/l2tp_ip6.c                               |    2 
 net/mac80211/sta_info.c                           |    2 
 net/mac80211/tx.c                                 |    2 
 net/packet/af_packet.c                            |    4 
 net/sched/Kconfig                                 |   42 
 net/sched/Makefile                                |    3 
 net/sched/sch_atm.c                               |  708 --------
 net/sched/sch_cbq.c                               | 1823 ----------------------
 net/sched/sch_dsmark.c                            |  519 ------
 net/wireless/nl80211.c                            |    1 
 scripts/bpf_helpers_doc.py                        |  157 +
 virt/kvm/arm/vgic/vgic-its.c                      |    5 
 55 files changed, 411 insertions(+), 3258 deletions(-)

Aaro Koskinen (1):
      net: stmmac: fix notifier registration

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

Bart Van Assche (3):
      RDMA/srpt: Support specifying the srpt_service_guid parameter
      RDMA/srpt: Make debug output more detailed
      fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio

Conrad Kostecki (1):
      ahci: asm1166: correct count of reported ports

Cyril Hrubis (3):
      sched/rt: Fix sysctl_sched_rr_timeslice intial value
      sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset
      sched/rt: Disallow writing invalid values to sched_rt_period_us

Daniel Vacek (1):
      IB/hfi1: Fix sdma.h tx->num_descs off-by-one error

Dmitry Bogdanov (1):
      scsi: target: core: Add TMF to tmr_list handling

Felix Fietkau (1):
      wifi: mac80211: fix race condition on enabling fast-xmit

Fullway Wang (2):
      fbdev: savage: Error out if pixclock equals zero
      fbdev: sis: Error out if pixclock equals zero

GONG, Ruiqi (1):
      memcg: add refcnt for pcpu stock to avoid UAF problem in drain_all_stock()

Geert Uytterhoeven (1):
      pmdomain: renesas: r8a77980-sysc: CR7 must be always on

Gianmarco Lusvardi (1):
      bpf, scripts: Correct GPL license name

Greg Kroah-Hartman (2):
      stmmac: no need to check return value of debugfs_create functions
      Linux 4.19.308

Jamal Hadi Salim (3):
      net/sched: Retire CBQ qdisc
      net/sched: Retire ATM qdisc
      net/sched: Retire dsmark qdisc

Jason Gunthorpe (2):
      RDMA/ulp: Use dev_name instead of ibdev->name
      s390: use the correct count for __iowrite64_copy()

Kalesh AP (1):
      RDMA/bnxt_re: Return error for SRQ resize

Krishna Kurapati (1):
      usb: gadget: ncm: Avoid dropping datagrams of properly parsed NTBs

Lokesh Gidra (1):
      userfaultfd: fix mmap_changing checking in mfill_atomic_hugetlb

Martin Blumenstingl (1):
      regulator: pwm-regulator: Add validity checks in continuous .get_voltage

Michal Kazior (1):
      wifi: cfg80211: fix missing interfaces when dumping

Mikulas Patocka (1):
      dm-crypt: don't modify the data when using authenticated encryption

Nikita Shubin (1):
      ARM: ep93xx: Add terminator to gpiod_lookup_table

Oliver Upton (2):
      KVM: arm64: vgic-its: Test for valid IRQ in its_sync_lpi_pending_table()
      KVM: arm64: vgic-its: Test for valid IRQ in MOVALL handler

Randy Dunlap (1):
      scsi: jazz_esp: Only build if SCSI core is builtin

Roman Gushchin (1):
      mm: memcontrol: switch to rcu protection in drain_all_stock()

Ryusuke Konishi (1):
      nilfs2: replace WARN_ONs for invalid DAT metadata block requests

Takashi Sakamoto (1):
      firewire: core: send bus reset promptly on gap count error

Tom Parkin (1):
      l2tp: pass correct message length to ip6_append_data

Vasiliy Kovalev (2):
      gtp: fix use-after-free and null-ptr-deref in gtp_genl_dump_pdp()
      ipv6: sr: fix possible use-after-free and null-ptr-deref

Vidya Sagar (1):
      PCI/MSI: Prevent MSI hardware interrupt number truncation

Vinod Koul (1):
      dmaengine: shdma: increase size of 'dev_id'

Wolfram Sang (1):
      packet: move from strlcpy with unused retval to strscpy

Xu Yang (1):
      usb: roles: don't get/set_role() when usb_role_switch is unregistered

Yi Sun (1):
      virtio-blk: Ensure no requests in virtqueues before deleting vqs.

Zhang Rui (1):
      hwmon: (coretemp) Enlarge per package core count limit

Zhipeng Lu (1):
      IB/hfi1: Fix a memleak in init_credit_return


