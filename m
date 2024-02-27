Return-Path: <linux-kernel+bounces-83388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB80869787
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6311F24906
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192411419AE;
	Tue, 27 Feb 2024 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1lGv8078"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E686E13B2B8;
	Tue, 27 Feb 2024 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043730; cv=none; b=EGeJFAr2VR2EJylANJK45zo5QH4m0i7wFGS/7sgwvMoScvEBCLxJpGkirC18Ah1VabAQLMbWOCXG4bfm8lJZhUTQtjAF7Jyo5XEujcIbGZk0GSvNzvBziQEYVrBdzGzes6ZSXORBRc3V7gzY13JakBfI6BpTa5z1TVxDzNl+xyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043730; c=relaxed/simple;
	bh=oH/3uGXxFvTANRvKWf+vQCsT9uEAyM/awrGK6FBiOCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WpDvIDd3LU7wRh/IOvpb5ydcl/vDn2V2k47hBvDoZIF4ZDA8yzjRDi2ES7F5xM84SAWnfb+R/J5+dUXRMvA4kOV0CDmwL8vMxYWnE+UJQoY6h0lYtk1y4eV/Lqzq8XxnTZzIAX6YV4kQEpJWLIaOxukEKmVTE1Xy5RBUxvCIv7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1lGv8078; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FE7C433F1;
	Tue, 27 Feb 2024 14:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043729;
	bh=oH/3uGXxFvTANRvKWf+vQCsT9uEAyM/awrGK6FBiOCY=;
	h=From:To:Cc:Subject:Date:From;
	b=1lGv8078Vk/VHXnLy7mGiPqUqbz1RnSMIFY/ZnuWBLvskTFYACxmM7Ai+UXJ70Dov
	 JuHJ9vu9hRdTYOWXLbYWTvyGgCqRFLmv+4oltcGS/AmMgyV97jbpTD84XYDwFRNdBp
	 63g54Wi/9mF1ZAZlFT8VYJSSiRWmdnPibQQhMNaI=
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
Subject: [PATCH 5.4 00/84] 5.4.270-rc1 review
Date: Tue, 27 Feb 2024 14:26:27 +0100
Message-ID: <20240227131552.864701583@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.270-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.270-rc1
X-KernelTest-Deadline: 2024-02-29T13:15+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.4.270 release.
There are 84 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.270-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.4.270-rc1

Andrii Nakryiko <andriin@fb.com>
    scripts/bpf: Fix xdp_md forward declaration typo

Bart Van Assche <bvanassche@acm.org>
    fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio

Erik Kurzinger <ekurzinger@nvidia.com>
    drm/syncobj: call drm_syncobj_fence_add_wait when WAIT_AVAILABLE flag is set

Christian König <christian.koenig@amd.com>
    drm/syncobj: make lockdep complain on WAIT_FOR_SUBMIT v3

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: set dormant flag on hook register failure

Sabrina Dubroca <sd@queasysnail.net>
    tls: stop recv() if initial process_rx_list gave us non-DATA

Jakub Kicinski <kuba@kernel.org>
    tls: rx: drop pointless else after goto

Jakub Kicinski <kuba@kernel.org>
    tls: rx: jump to a more appropriate label

Jason Gunthorpe <jgg@nvidia.com>
    s390: use the correct count for __iowrite64_copy()

Wolfram Sang <wsa+renesas@sang-engineering.com>
    packet: move from strlcpy with unused retval to strscpy

Vasiliy Kovalev <kovalev@altlinux.org>
    ipv6: sr: fix possible use-after-free and null-ptr-deref

Daniil Dulov <d.dulov@aladdin.ru>
    afs: Increase buffer size in afs_update_volume_status()

Eric Dumazet <edumazet@google.com>
    ipv6: properly combine dev_base_seq and ipv6.dev_addr_genid

Eric Dumazet <edumazet@google.com>
    ipv4: properly combine dev_base_seq and ipv4.dev_addr_genid

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

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Return error for SRQ resize

Zhipeng Lu <alexious@zju.edu.cn>
    IB/hfi1: Fix a memleak in init_credit_return

Xu Yang <xu.yang_2@nxp.com>
    usb: roles: don't get/set_role() when usb_role_switch is unregistered

Krishna Kurapati <quic_kriskura@quicinc.com>
    usb: gadget: ncm: Avoid dropping datagrams of properly parsed NTBs

Frank Li <Frank.Li@nxp.com>
    usb: cdns3: fix memory double free when handle zero packet

Frank Li <Frank.Li@nxp.com>
    usb: cdns3: fixed memory use after free at cdns3_gadget_ep_disable()

Nikita Shubin <nikita.shubin@maquefel.me>
    ARM: ep93xx: Add terminator to gpiod_lookup_table

Tom Parkin <tparkin@katalix.com>
    l2tp: pass correct message length to ip6_append_data

Vidya Sagar <vidyas@nvidia.com>
    PCI/MSI: Prevent MSI hardware interrupt number truncation

Vasiliy Kovalev <kovalev@altlinux.org>
    gtp: fix use-after-free and null-ptr-deref in gtp_genl_dump_pdp()

Mikulas Patocka <mpatocka@redhat.com>
    dm-crypt: don't modify the data when using authenticated encryption

Daniel Vacek <neelx@redhat.com>
    IB/hfi1: Fix sdma.h tx->num_descs off-by-one error

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    PCI: tegra: Fix OF node reference leak

Pali Rohár <pali@kernel.org>
    PCI: tegra: Fix reporting GPIO error value

Sireesh Kodali <sireeshkodali1@gmail.com>
    arm64: dts: qcom: msm8916: Fix typo in pronto remoteproc node

Nathan Chancellor <nathan@kernel.org>
    drm/amdgpu: Fix type of second parameter in trans_msg() callback

Matthew Wilcox (Oracle) <willy@infradead.org>
    iomap: Set all uptodate bits for an Uptodate page

Mikulas Patocka <mpatocka@redhat.com>
    dm-integrity: don't modify bio's immutable bio_vec in integrity_metadata()

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/alternatives: Disable KASAN in apply_alternatives()

Trek <trek00@inbox.ru>
    drm/amdgpu: Check for valid number of registers to read

Icenowy Zheng <icenowy@aosc.io>
    Revert "drm/sun4i: dsi: Change the start delay calculation"

Kai-Heng Feng <kai.heng.feng@canonical.com>
    ALSA: hda/realtek - Enable micmute LED on and HP system

Björn Töpel <bjorn.topel@gmail.com>
    selftests/bpf: Avoid running unprivileged tests with alignment requirements

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    net: bridge: clear bridge's private skb space on xmit

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    spi: mt7621: Fix an error message in mt7621_spi_probe()

John Stultz <john.stultz@linaro.org>
    driver core: Set deferred_probe_timeout to a longer default if CONFIG_MODULES is set

Miaoqian Lin <linmq006@gmail.com>
    pinctrl: rockchip: Fix refcount leak in rockchip_pinctrl_parse_groups

Lee Jones <lee.jones@linaro.org>
    pinctrl: pinctrl-rockchip: Fix a bunch of kerneldoc misdemeanours

Eric Dumazet <edumazet@google.com>
    tcp: add annotations around sk->sk_shutdown accesses

Soheil Hassas Yeganeh <soheil@google.com>
    tcp: return EPOLLOUT from tcp_poll only when notsent_bytes is half the limit

Paolo Abeni <pabeni@redhat.com>
    tcp: factor out __tcp_close() helper

Geert Uytterhoeven <geert+renesas@glider.be>
    pmdomain: renesas: r8a77980-sysc: CR7 must be always on

Alexandra Winter <wintera@linux.ibm.com>
    s390/qeth: Fix potential loss of L3-IP@ in case of network issues

Yi Sun <yi.sun@unisoc.com>
    virtio-blk: Ensure no requests in virtqueues before deleting vqs.

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    firewire: core: send bus reset promptly on gap count error

Hannes Reinecke <hare@suse.de>
    scsi: lpfc: Use unsigned type for num_sge

Zhang Rui <rui.zhang@intel.com>
    hwmon: (coretemp) Enlarge per package core count limit

Daniel Wagner <dwagner@suse.de>
    nvmet-fc: abort command when there is no binding

Xin Long <lucien.xin@gmail.com>
    netfilter: conntrack: check SCTP_CID_SHUTDOWN_ACK for vtag setting in sctp_new

Chen-Yu Tsai <wens@csie.org>
    ASoC: sunxi: sun4i-spdif: Add support for Allwinner H616

Guixin Liu <kanie@linux.alibaba.com>
    nvmet-tcp: fix nvme tcp ida memory leak

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    regulator: pwm-regulator: Add validity checks in continuous .get_voltage

Baokun Li <libaokun1@huawei.com>
    ext4: avoid allocating blocks from corrupted group in ext4_mb_find_by_goal()

Baokun Li <libaokun1@huawei.com>
    ext4: avoid allocating blocks from corrupted group in ext4_mb_try_best_found()

Lennert Buytenhek <kernel@wantstofly.org>
    ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers

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
    dmaengine: fsl-qdma: increase size of 'irq_name'

Vinod Koul <vkoul@kernel.org>
    dmaengine: shdma: increase size of 'dev_id'

Dmitry Bogdanov <d.bogdanov@yadro.com>
    scsi: target: core: Add TMF to tmr_list handling

Cyril Hrubis <chrubis@suse.cz>
    sched/rt: Disallow writing invalid values to sched_rt_period_us

Cyril Hrubis <chrubis@suse.cz>
    sched/rt: Fix sysctl_sched_rr_timeslice intial value

Lokesh Gidra <lokeshgidra@google.com>
    userfaultfd: fix mmap_changing checking in mfill_atomic_hugetlb

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: replace WARN_ONs for invalid DAT metadata block requests

GONG, Ruiqi <gongruiqi1@huawei.com>
    memcg: add refcnt for pcpu stock to avoid UAF problem in drain_all_stock()

Cyril Hrubis <chrubis@suse.cz>
    sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset

Jamal Hadi Salim <jhs@mojatatu.com>
    net/sched: Retire dsmark qdisc

Jamal Hadi Salim <jhs@mojatatu.com>
    net/sched: Retire ATM qdisc

Jamal Hadi Salim <jhs@mojatatu.com>
    net/sched: Retire CBQ qdisc

Oliver Upton <oliver.upton@linux.dev>
    KVM: arm64: vgic-its: Test for valid IRQ in MOVALL handler

Oliver Upton <oliver.upton@linux.dev>
    KVM: arm64: vgic-its: Test for valid IRQ in its_sync_lpi_pending_table()


-------------

Diffstat:

 Makefile                                          |    4 +-
 arch/arm/mach-ep93xx/core.c                       |    1 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi             |    4 +-
 arch/s390/pci/pci.c                               |    2 +-
 arch/x86/kernel/alternative.c                     |   13 +
 drivers/ata/ahci.c                                |   34 +-
 drivers/ata/ahci.h                                |    1 +
 drivers/base/dd.c                                 |    9 +
 drivers/block/virtio_blk.c                        |    7 +-
 drivers/dma/fsl-qdma.c                            |    2 +-
 drivers/dma/sh/shdma.h                            |    2 +-
 drivers/firewire/core-card.c                      |   18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c           |    3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h          |    5 +-
 drivers/gpu/drm/drm_syncobj.c                     |   16 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c |    8 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c            |    3 +-
 drivers/hwmon/coretemp.c                          |    2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c          |    5 +-
 drivers/infiniband/hw/hfi1/pio.c                  |    6 +-
 drivers/infiniband/hw/hfi1/sdma.c                 |    2 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c             |   18 +-
 drivers/md/dm-crypt.c                             |    6 +
 drivers/md/dm-integrity.c                         |   11 +-
 drivers/net/gtp.c                                 |   10 +-
 drivers/nvme/target/fc.c                          |    8 +-
 drivers/nvme/target/tcp.c                         |    1 +
 drivers/pci/controller/pci-tegra.c                |   17 +-
 drivers/pci/msi.c                                 |    2 +-
 drivers/pinctrl/pinctrl-rockchip.c                |   23 +-
 drivers/regulator/pwm-regulator.c                 |    3 +
 drivers/s390/net/qeth_l3_main.c                   |    9 +-
 drivers/scsi/Kconfig                              |    2 +-
 drivers/scsi/lpfc/lpfc_scsi.c                     |   12 +-
 drivers/soc/renesas/r8a77980-sysc.c               |    3 +-
 drivers/spi/spi-mt7621.c                          |    8 +-
 drivers/target/target_core_device.c               |    5 -
 drivers/target/target_core_transport.c            |    4 +
 drivers/usb/cdns3/gadget.c                        |    8 +-
 drivers/usb/gadget/function/f_ncm.c               |   10 +-
 drivers/usb/roles/class.c                         |   12 +-
 drivers/video/fbdev/savage/savagefb_driver.c      |    3 +
 drivers/video/fbdev/sis/sis_main.c                |    2 +
 fs/afs/volume.c                                   |    4 +-
 fs/aio.c                                          |    9 +-
 fs/ext4/mballoc.c                                 |   13 +-
 fs/iomap/buffered-io.c                            |    3 +
 fs/nilfs2/dat.c                                   |   27 +-
 include/linux/fs.h                                |    2 +
 include/linux/lockdep.h                           |    5 +
 include/net/tcp.h                                 |    1 +
 kernel/sched/rt.c                                 |   10 +-
 kernel/sysctl.c                                   |    4 +
 mm/memcontrol.c                                   |    6 +
 mm/userfaultfd.c                                  |   14 +-
 net/bridge/br_device.c                            |    2 +
 net/ipv4/af_inet.c                                |    2 +-
 net/ipv4/devinet.c                                |   21 +-
 net/ipv4/tcp.c                                    |   27 +-
 net/ipv4/tcp_input.c                              |    4 +-
 net/ipv6/addrconf.c                               |   21 +-
 net/ipv6/seg6.c                                   |   20 +-
 net/l2tp/l2tp_ip6.c                               |    2 +-
 net/mac80211/sta_info.c                           |    2 +
 net/mac80211/tx.c                                 |    2 +-
 net/netfilter/nf_conntrack_proto_sctp.c           |    2 +-
 net/netfilter/nf_tables_api.c                     |    1 +
 net/packet/af_packet.c                            |    4 +-
 net/sched/Kconfig                                 |   42 -
 net/sched/Makefile                                |    3 -
 net/sched/sch_atm.c                               |  710 --------
 net/sched/sch_cbq.c                               | 1818 ---------------------
 net/sched/sch_dsmark.c                            |  523 ------
 net/tls/tls_sw.c                                  |   12 +-
 net/wireless/nl80211.c                            |    1 +
 scripts/bpf_helpers_doc.py                        |  157 +-
 sound/pci/hda/patch_realtek.c                     |    6 +-
 sound/soc/sunxi/sun4i-spdif.c                     |    5 +
 tools/testing/selftests/bpf/test_verifier.c       |   13 +
 virt/kvm/arm/vgic/vgic-its.c                      |    5 +
 80 files changed, 572 insertions(+), 3255 deletions(-)



