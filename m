Return-Path: <linux-kernel+bounces-83341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 774CF8693A6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1B78291444
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88AE1468F4;
	Tue, 27 Feb 2024 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZuXcsUyH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCD11419B5;
	Tue, 27 Feb 2024 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041531; cv=none; b=kd5ZAwJmaKk5Um7wVScQ5oAJ2W7Mp8NmoNvv5kct11Vy8ltMUNYwmyZvysQtTBRBrrIXCVCfmyIyuMwyOHuosh21n2d4Hg8DbGqOv1Oaun7PnjfJSt6ghrbHR3dqxjeZ/5H7eoKvOGWl2aN/x8JbVa4emA2VX36FJc5z2qBnn78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041531; c=relaxed/simple;
	bh=oI0YsBN5IXwuXiTa5ndwSnjgtw+sgMN08yHCIlyYX10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FmAL5a+QQ9smr9ym6lSFHguePXIoF1Z/SVQNNa8uwM7IfCKB6mHcbh8yad2PjYxHIwmPXc2qhv0eKQSi8mP/mCoOhUC5VvdI/JIJKF35lgcXx4m7SB/W7a+uE3Ad9aQw//FHbDAzaLsHMz+emJTGFzhz0XE6Fa1o+NTWZJDn/M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZuXcsUyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDE6C433F1;
	Tue, 27 Feb 2024 13:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041531;
	bh=oI0YsBN5IXwuXiTa5ndwSnjgtw+sgMN08yHCIlyYX10=;
	h=From:To:Cc:Subject:Date:From;
	b=ZuXcsUyHmo8oqNEIdD+THb111+C01CSaADZ4RSpzhSNHUJXEBEZshSZR9F3c0zEEq
	 yEXzKrvpbmGidezHoht7aFbQOa9qBSoaFUoYWDnb6XGrda2/jEo6eyvsupGLS5ns4c
	 vuSmcJTPAFhbR2+Uutxa6nYlmC9pT4htMIz5fCE4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com
Subject: [PATCH 4.19 00/52] 4.19.308-rc1 review
Date: Tue, 27 Feb 2024 14:25:47 +0100
Message-ID: <20240227131548.514622258@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.308-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.308-rc1
X-KernelTest-Deadline: 2024-02-29T13:15+00:00
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 4.19.308 release.
There are 52 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.308-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.308-rc1

Andrii Nakryiko <andriin@fb.com>
    scripts/bpf: Fix xdp_md forward declaration typo

Bart Van Assche <bvanassche@acm.org>
    fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio

Oliver Upton <oliver.upton@linux.dev>
    KVM: arm64: vgic-its: Test for valid IRQ in MOVALL handler

Oliver Upton <oliver.upton@linux.dev>
    KVM: arm64: vgic-its: Test for valid IRQ in its_sync_lpi_pending_table()

Vidya Sagar <vidyas@nvidia.com>
    PCI/MSI: Prevent MSI hardware interrupt number truncation

Jason Gunthorpe <jgg@nvidia.com>
    s390: use the correct count for __iowrite64_copy()

Wolfram Sang <wsa+renesas@sang-engineering.com>
    packet: move from strlcpy with unused retval to strscpy

Vasiliy Kovalev <kovalev@altlinux.org>
    ipv6: sr: fix possible use-after-free and null-ptr-deref

Arnd Bergmann <arnd@arndb.de>
    nouveau: fix function cast warnings

Randy Dunlap <rdunlap@infradead.org>
    scsi: jazz_esp: Only build if SCSI core is builtin

Gianmarco Lusvardi <glusvardi@posteo.net>
    bpf, scripts: Correct GPL license name

Andrii Nakryiko <andriin@fb.com>
    scripts/bpf: teach bpf_helpers_doc.py to dump BPF helper definitions

Arnd Bergmann <arnd@arndb.de>
    RDMA/srpt: fix function pointer cast warnings

Bart Van Assche <bvanassche@acm.org>
    RDMA/srpt: Make debug output more detailed

Jason Gunthorpe <jgg@ziepe.ca>
    RDMA/ulp: Use dev_name instead of ibdev->name

Bart Van Assche <bvanassche@acm.org>
    RDMA/srpt: Support specifying the srpt_service_guid parameter

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Return error for SRQ resize

Zhipeng Lu <alexious@zju.edu.cn>
    IB/hfi1: Fix a memleak in init_credit_return

Xu Yang <xu.yang_2@nxp.com>
    usb: roles: don't get/set_role() when usb_role_switch is unregistered

Krishna Kurapati <quic_kriskura@quicinc.com>
    usb: gadget: ncm: Avoid dropping datagrams of properly parsed NTBs

Nikita Shubin <nikita.shubin@maquefel.me>
    ARM: ep93xx: Add terminator to gpiod_lookup_table

Tom Parkin <tparkin@katalix.com>
    l2tp: pass correct message length to ip6_append_data

Vasiliy Kovalev <kovalev@altlinux.org>
    gtp: fix use-after-free and null-ptr-deref in gtp_genl_dump_pdp()

Mikulas Patocka <mpatocka@redhat.com>
    dm-crypt: don't modify the data when using authenticated encryption

Roman Gushchin <guro@fb.com>
    mm: memcontrol: switch to rcu protection in drain_all_stock()

Daniel Vacek <neelx@redhat.com>
    IB/hfi1: Fix sdma.h tx->num_descs off-by-one error

Geert Uytterhoeven <geert+renesas@glider.be>
    pmdomain: renesas: r8a77980-sysc: CR7 must be always on

Alexandra Winter <wintera@linux.ibm.com>
    s390/qeth: Fix potential loss of L3-IP@ in case of network issues

Yi Sun <yi.sun@unisoc.com>
    virtio-blk: Ensure no requests in virtqueues before deleting vqs.

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    firewire: core: send bus reset promptly on gap count error

Zhang Rui <rui.zhang@intel.com>
    hwmon: (coretemp) Enlarge per package core count limit

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    regulator: pwm-regulator: Add validity checks in continuous .get_voltage

Baokun Li <libaokun1@huawei.com>
    ext4: avoid allocating blocks from corrupted group in ext4_mb_find_by_goal()

Baokun Li <libaokun1@huawei.com>
    ext4: avoid allocating blocks from corrupted group in ext4_mb_try_best_found()

Conrad Kostecki <conikost@gentoo.org>
    ahci: asm1166: correct count of reported ports

Fullway Wang <fullwaywang@outlook.com>
    fbdev: sis: Error out if pixclock equals zero

Fullway Wang <fullwaywang@outlook.com>
    fbdev: savage: Error out if pixclock equals zero

Felix Fietkau <nbd@nbd.name>
    wifi: mac80211: fix race condition on enabling fast-xmit

Michal Kazior <michal@plume.com>
    wifi: cfg80211: fix missing interfaces when dumping

Vinod Koul <vkoul@kernel.org>
    dmaengine: shdma: increase size of 'dev_id'

Dmitry Bogdanov <d.bogdanov@yadro.com>
    scsi: target: core: Add TMF to tmr_list handling

Cyril Hrubis <chrubis@suse.cz>
    sched/rt: Disallow writing invalid values to sched_rt_period_us

Cyril Hrubis <chrubis@suse.cz>
    sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset

Cyril Hrubis <chrubis@suse.cz>
    sched/rt: Fix sysctl_sched_rr_timeslice intial value

Lokesh Gidra <lokeshgidra@google.com>
    userfaultfd: fix mmap_changing checking in mfill_atomic_hugetlb

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: replace WARN_ONs for invalid DAT metadata block requests

GONG, Ruiqi <gongruiqi1@huawei.com>
    memcg: add refcnt for pcpu stock to avoid UAF problem in drain_all_stock()

Aaro Koskinen <aaro.koskinen@nokia.com>
    net: stmmac: fix notifier registration

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    stmmac: no need to check return value of debugfs_create functions

Jamal Hadi Salim <jhs@mojatatu.com>
    net/sched: Retire dsmark qdisc

Jamal Hadi Salim <jhs@mojatatu.com>
    net/sched: Retire ATM qdisc

Jamal Hadi Salim <jhs@mojatatu.com>
    net/sched: Retire CBQ qdisc


-------------

Diffstat:

 Makefile                                          |    4 +-
 arch/arm/mach-ep93xx/core.c                       |    1 +
 arch/s390/pci/pci.c                               |    2 +-
 drivers/ata/ahci.c                                |    5 +
 drivers/block/virtio_blk.c                        |    7 +-
 drivers/dma/sh/shdma.h                            |    2 +-
 drivers/firewire/core-card.c                      |   18 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c |    8 +-
 drivers/hwmon/coretemp.c                          |    2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c          |    5 +-
 drivers/infiniband/hw/hfi1/pio.c                  |    6 +-
 drivers/infiniband/hw/hfi1/sdma.c                 |    2 +-
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c        |    2 +-
 drivers/infiniband/ulp/iser/iser_verbs.c          |    9 +-
 drivers/infiniband/ulp/isert/ib_isert.c           |    2 +-
 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c   |    3 +-
 drivers/infiniband/ulp/srp/ib_srp.c               |   10 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c             |   52 +-
 drivers/md/dm-crypt.c                             |    6 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |    2 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |   65 +-
 drivers/net/gtp.c                                 |   10 +-
 drivers/pci/msi.c                                 |    2 +-
 drivers/regulator/pwm-regulator.c                 |    3 +
 drivers/s390/net/qeth_l3_main.c                   |    9 +-
 drivers/scsi/Kconfig                              |    2 +-
 drivers/soc/renesas/r8a77980-sysc.c               |    3 +-
 drivers/target/target_core_device.c               |    5 -
 drivers/target/target_core_transport.c            |    4 +
 drivers/usb/gadget/function/f_ncm.c               |   10 +-
 drivers/usb/roles/class.c                         |   12 +-
 drivers/video/fbdev/savage/savagefb_driver.c      |    3 +
 drivers/video/fbdev/sis/sis_main.c                |    2 +
 fs/aio.c                                          |    9 +-
 fs/ext4/mballoc.c                                 |   13 +-
 fs/nilfs2/dat.c                                   |   27 +-
 include/linux/fs.h                                |    2 +
 include/rdma/rdma_vt.h                            |    2 +-
 kernel/sched/rt.c                                 |   10 +-
 kernel/sysctl.c                                   |    5 +
 mm/memcontrol.c                                   |   23 +-
 mm/userfaultfd.c                                  |   14 +-
 net/ipv6/seg6.c                                   |   20 +-
 net/l2tp/l2tp_ip6.c                               |    2 +-
 net/mac80211/sta_info.c                           |    2 +
 net/mac80211/tx.c                                 |    2 +-
 net/packet/af_packet.c                            |    4 +-
 net/sched/Kconfig                                 |   42 -
 net/sched/Makefile                                |    3 -
 net/sched/sch_atm.c                               |  708 --------
 net/sched/sch_cbq.c                               | 1823 ---------------------
 net/sched/sch_dsmark.c                            |  519 ------
 net/wireless/nl80211.c                            |    1 +
 scripts/bpf_helpers_doc.py                        |  157 +-
 virt/kvm/arm/vgic/vgic-its.c                      |    5 +
 55 files changed, 412 insertions(+), 3259 deletions(-)



