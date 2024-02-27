Return-Path: <linux-kernel+bounces-83393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3818697EA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B031F2A1C2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8071413B29C;
	Tue, 27 Feb 2024 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yRBkjWAW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D081420DA;
	Tue, 27 Feb 2024 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043965; cv=none; b=cylE5ym4XV4bE2HbL1Ngqur0ajHTUEukNgAWrJ2hO6qhWzYwZdOlg2hUtueghfo/Rd3UQC2tPUwI6d2x/+1DO2JwjEZ4aCJvb/D8TyD4tFxPW0MYKCIXAvf5vIGPbj4M06Cidr/P2+HFig0ZRlMUMVBJ2M5uW9aTK+/2OB22glI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043965; c=relaxed/simple;
	bh=ILZ8Diyi2AIjRBG4d6XR6E5nmlLT6e18Wjox8PAA37g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gF9ymY1CVVyvlAcgaP5sBDRLRJe6EY3GXFiaA9ZsXr8hgx4hXp7JhiqbATeMdKvrM1hxRYZgvl+IA2krS6hFkFQkxo4FW0mf/qUWqnQgxLd1pN7+XkI7Vs6VRvypgTJT8poso3CLn+4QPxmVhmVzeZTDvPliMQi8Y+dtKZ8WABo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yRBkjWAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688B1C433F1;
	Tue, 27 Feb 2024 14:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043965;
	bh=ILZ8Diyi2AIjRBG4d6XR6E5nmlLT6e18Wjox8PAA37g=;
	h=From:To:Cc:Subject:Date:From;
	b=yRBkjWAWzrQFirHV2atF7xHqJx5YDdTuU9x4GfGA17fsvIe73nHr4G/mlxgNLt5zP
	 c/gasWY48rcrs6aKLHlpxZLhPpi0aAKsnlshYVOA7bfp/NMHB0vtBAzuFsCETtSjda
	 edNPYTBtZK1mu7pnJVZ/cFg9zmRnzO/rSRv/SGlY=
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
Subject: [PATCH 5.10 000/122] 5.10.211-rc1 review
Date: Tue, 27 Feb 2024 14:26:01 +0100
Message-ID: <20240227131558.694096204@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.211-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.211-rc1
X-KernelTest-Deadline: 2024-02-29T13:16+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.10.211 release.
There are 122 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.211-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.10.211-rc1

Baokun Li <libaokun1@huawei.com>
    ext4: regenerate buddy after block freeing failed if under fc replay

Kuniyuki Iwashima <kuniyu@amazon.com>
    arp: Prevent overflow in arp_req_get().

Bart Van Assche <bvanassche@acm.org>
    fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio

Michael Schmitz <schmitzmic@gmail.com>
    block: ataflop: more blk-mq refactoring fixes

Armin Wolf <W_Armin@gmx.de>
    drm/amd/display: Fix memory leak in dm_sw_fini()

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

Jason Gunthorpe <jgg@ziepe.ca>
    s390: use the correct count for __iowrite64_copy()

Kees Cook <keescook@chromium.org>
    net: dev: Convert sa_data to flexible array in struct sockaddr

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

Arnd Bergmann <arnd@arndb.de>
    RDMA/srpt: fix function pointer cast warnings

Heiko Stuebner <heiko.stuebner@cherry.de>
    arm64: dts: rockchip: set num-cs property for spi on px30

Kamal Heib <kheib@redhat.com>
    RDMA/qedr: Fix qedr_create_user_qp error flow

Bart Van Assche <bvanassche@acm.org>
    RDMA/srpt: Support specifying the srpt_service_guid parameter

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Return error for SRQ resize

Zhipeng Lu <alexious@zju.edu.cn>
    IB/hfi1: Fix a memleak in init_credit_return

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix lockless access in subflow ULP diag

Xu Yang <xu.yang_2@nxp.com>
    usb: roles: don't get/set_role() when usb_role_switch is unregistered

Xu Yang <xu.yang_2@nxp.com>
    usb: roles: fix NULL pointer issue when put module's reference

Krishna Kurapati <quic_kriskura@quicinc.com>
    usb: gadget: ncm: Avoid dropping datagrams of properly parsed NTBs

Frank Li <Frank.Li@nxp.com>
    usb: cdns3: fix memory double free when handle zero packet

Frank Li <Frank.Li@nxp.com>
    usb: cdns3: fixed memory use after free at cdns3_gadget_ep_disable()

Peter Zijlstra <peterz@infradead.org>
    x86/alternative: Make custom return thunk unconditional

Borislav Petkov (AMD) <bp@alien8.de>
    Revert "x86/alternative: Make custom return thunk unconditional"

Peter Zijlstra <peterz@infradead.org>
    x86/returnthunk: Allow different return thunks

Peter Zijlstra <peterz@infradead.org>
    x86/ftrace: Use alternative RET encoding

Peter Zijlstra <peterz@infradead.org>
    x86/ibt,paravirt: Use text_gen_insn() for paravirt_patch()

Peter Zijlstra <peterz@infradead.org>
    x86/text-patching: Make text_gen_insn() play nice with ANNOTATE_NOENDBR

Borislav Petkov (AMD) <bp@alien8.de>
    Revert "x86/ftrace: Use alternative RET encoding"

Nikita Shubin <nikita.shubin@maquefel.me>
    ARM: ep93xx: Add terminator to gpiod_lookup_table

Tom Parkin <tparkin@katalix.com>
    l2tp: pass correct message length to ip6_append_data

Vidya Sagar <vidyas@nvidia.com>
    PCI/MSI: Prevent MSI hardware interrupt number truncation

Vasiliy Kovalev <kovalev@altlinux.org>
    gtp: fix use-after-free and null-ptr-deref in gtp_genl_dump_pdp()

Oliver Upton <oliver.upton@linux.dev>
    KVM: arm64: vgic-its: Test for valid IRQ in its_sync_lpi_pending_table()

Oliver Upton <oliver.upton@linux.dev>
    KVM: arm64: vgic-its: Test for valid IRQ in MOVALL handler

Mikulas Patocka <mpatocka@redhat.com>
    dm-crypt: don't modify the data when using authenticated encryption

Peter Oberparleiter <oberpar@linux.ibm.com>
    s390/cio: fix invalid -EBUSY on ccw_device_start

Daniel Vacek <neelx@redhat.com>
    IB/hfi1: Fix sdma.h tx->num_descs off-by-one error

Gao Xiang <hsiangkao@linux.alibaba.com>
    erofs: fix lz4 inplace decompression

Jan Beulich <jbeulich@suse.com>
    x86: drop bogus "cc" clobber from __try_cmpxchg_user_asm()

Zhihao Cheng <chengzhihao1@huawei.com>
    jbd2: Fix wrongly judgement for buffer head removing while doing checkpoint

Zhang Yi <yi.zhang@huawei.com>
    jbd2: recheck chechpointing non-dirty buffer

Zhang Yi <yi.zhang@huawei.com>
    jbd2: remove redundant buffer io error checks

Johannes Berg <johannes.berg@intel.com>
    iwlwifi: mvm: write queue_sync_state only for sync

Johannes Berg <johannes.berg@intel.com>
    iwlwifi: mvm: do more useful queue sync accounting

Max Verevkin <me@maxverevkin.tk>
    platform/x86: intel-vbtn: Support for tablet mode on HP Pavilion 13 x360 PC

Sergej Bauer <sbauer@blackbox.su>
    lan743x: fix for potential NULL pointer dereference with bare card

Filipe Manana <fdmanana@suse.com>
    btrfs: do not pin logs too early during renames

Filipe Manana <fdmanana@suse.com>
    btrfs: unify lookup return value when dir entry is missing

Marcos Paulo de Souza <mpdesouza@suse.com>
    btrfs: introduce btrfs_lookup_match_dir

Josef Bacik <josef@toxicpanda.com>
    btrfs: tree-checker: check for overlapping extent items

Borislav Petkov <bp@suse.de>
    task_stack, x86/cea: Force-inline stack helpers

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    ASoC: Intel: bytcr_rt5651: Drop reference count of ACPI device after use

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: Intel: boards: get codec device with ACPI instead of bus search

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ASoC: Intel: boards: harden codec property handling

YouChing Lin <ycllin@mxic.com.tw>
    mtd: spinand: macronix: Add support for MX35LFxGE4AD

Shyam Prasad N <sprasad@microsoft.com>
    cifs: add a warning when the in-flight count goes negative

Benjamin Gray <bgray@linux.ibm.com>
    powerpc/watchpoints: Annotate atomic context in more places

Ravi Bangoria <ravi.bangoria@linux.ibm.com>
    powerpc/watchpoint: Workaround P10 DD1 issue with VSX-32 byte instructions

Michael Schmitz <schmitzmic@gmail.com>
    block: ataflop: fix breakage introduced at blk-mq refactoring

Kees Cook <keescook@chromium.org>
    seccomp: Invalidate seccomp mode to catch death failures

Peter Zijlstra <peterz@infradead.org>
    x86/uaccess: Implement macros for CMPXCHG on user addresses

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    hsr: Avoid double remove of a node.

Roger Pau Monne <roger.pau@citrix.com>
    hvc/xen: prevent concurrent accesses to the shared ring

Dan Carpenter <error27@gmail.com>
    media: av7110: prevent underflow in write_ts_to_decoder()

Shengjiu Wang <shengjiu.wang@nxp.com>
    ASoC: fsl_micfil: register platform component before registering cpu dai

Xiaolei Wang <xiaolei.wang@windriver.com>
    ARM: dts: imx: Set default tuning step for imx6sx usdhc

Jiaxun Yang <jiaxun.yang@flygoat.com>
    irqchip/mips-gic: Don't touch vl_map if a local interrupt is not routable

Rafał Miłecki <rafal@milecki.pl>
    ARM: dts: BCM53573: Drop nonexistent "default-off" LED trigger

Geert Uytterhoeven <geert+renesas@glider.be>
    pmdomain: renesas: r8a77980-sysc: CR7 must be always on

Yi Sun <yi.sun@unisoc.com>
    virtio-blk: Ensure no requests in virtqueues before deleting vqs.

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    firewire: core: send bus reset promptly on gap count error

Hannes Reinecke <hare@suse.de>
    scsi: lpfc: Use unsigned type for num_sge

Zhang Rui <rui.zhang@intel.com>
    hwmon: (coretemp) Enlarge per package core count limit

Andrew Bresticker <abrestic@rivosinc.com>
    efi: Don't add memblocks for soft-reserved memory

Andrew Bresticker <abrestic@rivosinc.com>
    efi: runtime: Fix potential overflow of soft-reserved region size

Szilard Fabian <szfabian@bluemarch.art>
    Input: i8042 - add Fujitsu Lifebook U728 to i8042 quirk table

Zhang Yi <yi.zhang@huawei.com>
    ext4: correct the hole length returned by ext4_map_blocks()

Daniel Wagner <dwagner@suse.de>
    nvmet-fc: abort command when there is no binding

Daniel Wagner <dwagner@suse.de>
    nvmet-fc: release reference on target port

Daniel Wagner <dwagner@suse.de>
    nvmet-fcloop: swap the list_add_tail arguments

Daniel Wagner <dwagner@suse.de>
    nvme-fc: do not wait in vain when unloading module

Xin Long <lucien.xin@gmail.com>
    netfilter: conntrack: check SCTP_CID_SHUTDOWN_ACK for vtag setting in sctp_new

Wolfram Sang <wsa+renesas@sang-engineering.com>
    spi: sh-msiof: avoid integer overflow in constants

Chen-Yu Tsai <wens@csie.org>
    ASoC: sunxi: sun4i-spdif: Add support for Allwinner H616

Guixin Liu <kanie@linux.alibaba.com>
    nvmet-tcp: fix nvme tcp ida memory leak

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    regulator: pwm-regulator: Add validity checks in continuous .get_voltage

Kunwu Chan <chentao@kylinos.cn>
    dmaengine: ti: edma: Add some null pointer checks to the edma_probe

Baokun Li <libaokun1@huawei.com>
    ext4: avoid allocating blocks from corrupted group in ext4_mb_find_by_goal()

Baokun Li <libaokun1@huawei.com>
    ext4: avoid allocating blocks from corrupted group in ext4_mb_try_best_found()

Lennert Buytenhek <kernel@wantstofly.org>
    ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers

Conrad Kostecki <conikost@gentoo.org>
    ahci: asm1166: correct count of reported ports

Devyn Liu <liudingyuan@huawei.com>
    spi: hisi-sfc-v3xx: Return IRQ_NONE if no interrupts were detected

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

Damien Le Moal <dlemoal@kernel.org>
    zonefs: Improve error handling

Lokesh Gidra <lokeshgidra@google.com>
    userfaultfd: fix mmap_changing checking in mfill_atomic_hugetlb

Cyril Hrubis <chrubis@suse.cz>
    sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix parsing of SMB3.1.1 POSIX create context

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential OOBs in smb2_parse_contexts()

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix OOB in receive_encrypted_standard()

Jamal Hadi Salim <jhs@mojatatu.com>
    net/sched: Retire dsmark qdisc

Jamal Hadi Salim <jhs@mojatatu.com>
    net/sched: Retire ATM qdisc

Jamal Hadi Salim <jhs@mojatatu.com>
    net/sched: Retire CBQ qdisc


-------------

Diffstat:

 Makefile                                          |    4 +-
 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts     |    1 -
 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts      |    2 -
 arch/arm/boot/dts/imx6sx.dtsi                     |    6 +
 arch/arm/mach-ep93xx/core.c                       |    1 +
 arch/arm64/boot/dts/rockchip/px30.dtsi            |    2 +
 arch/arm64/kvm/vgic/vgic-its.c                    |    5 +
 arch/powerpc/kernel/hw_breakpoint.c               |   76 +-
 arch/s390/pci/pci.c                               |    2 +-
 arch/x86/include/asm/cpu_entry_area.h             |    2 +-
 arch/x86/include/asm/nospec-branch.h              |    2 +
 arch/x86/include/asm/text-patching.h              |   46 +-
 arch/x86/include/asm/uaccess.h                    |  142 ++
 arch/x86/kernel/alternative.c                     |   13 +-
 arch/x86/kernel/ftrace.c                          |    4 +-
 arch/x86/kernel/paravirt.c                        |   22 +-
 arch/x86/kernel/static_call.c                     |    2 +-
 arch/x86/net/bpf_jit_comp.c                       |    2 +-
 drivers/ata/ahci.c                                |   34 +-
 drivers/ata/ahci.h                                |    1 +
 drivers/block/ataflop.c                           |   56 +-
 drivers/block/virtio_blk.c                        |    7 +-
 drivers/dma/fsl-qdma.c                            |    2 +-
 drivers/dma/sh/shdma.h                            |    2 +-
 drivers/dma/ti/edma.c                             |   10 +
 drivers/firewire/core-card.c                      |   18 +-
 drivers/firmware/efi/arm-runtime.c                |    2 +-
 drivers/firmware/efi/efi-init.c                   |   19 +-
 drivers/firmware/efi/riscv-runtime.c              |    2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    1 +
 drivers/gpu/drm/drm_syncobj.c                     |   16 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c |    8 +-
 drivers/hwmon/coretemp.c                          |    2 +-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c          |    5 +-
 drivers/infiniband/hw/hfi1/pio.c                  |    6 +-
 drivers/infiniband/hw/hfi1/sdma.c                 |    2 +-
 drivers/infiniband/hw/qedr/verbs.c                |   11 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c             |   17 +-
 drivers/input/serio/i8042-acpipnpio.h             |    8 +
 drivers/irqchip/irq-mips-gic.c                    |    2 +
 drivers/md/dm-crypt.c                             |    6 +
 drivers/media/pci/ttpci/av7110_av.c               |    4 +-
 drivers/mtd/nand/spi/macronix.c                   |   20 +
 drivers/net/ethernet/microchip/lan743x_ethtool.c  |    9 +-
 drivers/net/gtp.c                                 |   10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c |   14 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c      |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c     |   10 +-
 drivers/nvme/host/fc.c                            |   47 +-
 drivers/nvme/target/fc.c                          |   11 +-
 drivers/nvme/target/fcloop.c                      |    6 +-
 drivers/nvme/target/tcp.c                         |    1 +
 drivers/pci/msi.c                                 |    2 +-
 drivers/platform/x86/intel-vbtn.c                 |    6 +
 drivers/regulator/pwm-regulator.c                 |    3 +
 drivers/s390/cio/device_ops.c                     |    6 +-
 drivers/scsi/Kconfig                              |    2 +-
 drivers/scsi/lpfc/lpfc_scsi.c                     |   12 +-
 drivers/soc/renesas/r8a77980-sysc.c               |    3 +-
 drivers/spi/spi-hisi-sfc-v3xx.c                   |    5 +
 drivers/spi/spi-sh-msiof.c                        |   16 +-
 drivers/target/target_core_device.c               |    5 -
 drivers/target/target_core_transport.c            |    4 +
 drivers/tty/hvc/hvc_xen.c                         |   19 +-
 drivers/usb/cdns3/gadget.c                        |    8 +-
 drivers/usb/gadget/function/f_ncm.c               |   10 +-
 drivers/usb/roles/class.c                         |   29 +-
 drivers/video/fbdev/savage/savagefb_driver.c      |    3 +
 drivers/video/fbdev/sis/sis_main.c                |    2 +
 fs/afs/volume.c                                   |    4 +-
 fs/aio.c                                          |    9 +-
 fs/btrfs/ctree.h                                  |    2 +-
 fs/btrfs/dir-item.c                               |  122 +-
 fs/btrfs/inode.c                                  |   48 +-
 fs/btrfs/tree-checker.c                           |   25 +-
 fs/btrfs/tree-log.c                               |   14 +-
 fs/cifs/smb2ops.c                                 |   19 +-
 fs/cifs/smb2pdu.c                                 |   95 +-
 fs/cifs/smb2proto.h                               |   12 +-
 fs/erofs/decompressor.c                           |   24 +-
 fs/ext4/extents.c                                 |  111 +-
 fs/ext4/mballoc.c                                 |   33 +-
 fs/jbd2/checkpoint.c                              |  137 +-
 fs/zonefs/super.c                                 |   68 +-
 include/linux/fs.h                                |    2 +
 include/linux/lockdep.h                           |    5 +
 include/linux/sched/task_stack.h                  |    2 +-
 include/linux/socket.h                            |    5 +-
 include/net/tcp.h                                 |    2 +-
 kernel/sched/rt.c                                 |   10 +-
 kernel/seccomp.c                                  |   10 +
 kernel/sysctl.c                                   |    4 +
 mm/userfaultfd.c                                  |   14 +-
 net/core/dev.c                                    |    2 +-
 net/core/dev_ioctl.c                              |    2 +-
 net/hsr/hsr_framereg.c                            |   16 +-
 net/hsr/hsr_framereg.h                            |    1 +
 net/ipv4/arp.c                                    |    3 +-
 net/ipv4/devinet.c                                |   21 +-
 net/ipv6/addrconf.c                               |   21 +-
 net/ipv6/seg6.c                                   |   20 +-
 net/l2tp/l2tp_ip6.c                               |    2 +-
 net/mac80211/sta_info.c                           |    2 +
 net/mac80211/tx.c                                 |    2 +-
 net/mptcp/diag.c                                  |    6 +-
 net/netfilter/nf_conntrack_proto_sctp.c           |    2 +-
 net/netfilter/nf_tables_api.c                     |    1 +
 net/packet/af_packet.c                            |   12 +-
 net/sched/Kconfig                                 |   42 -
 net/sched/Makefile                                |    3 -
 net/sched/sch_atm.c                               |  709 --------
 net/sched/sch_cbq.c                               | 1816 ---------------------
 net/sched/sch_dsmark.c                            |  521 ------
 net/tls/tls_main.c                                |    2 +-
 net/tls/tls_sw.c                                  |   12 +-
 net/wireless/nl80211.c                            |    1 +
 scripts/bpf_helpers_doc.py                        |    2 +-
 sound/soc/fsl/fsl_micfil.c                        |   15 +-
 sound/soc/intel/boards/bytcht_es8316.c            |   14 +-
 sound/soc/intel/boards/bytcr_rt5640.c             |   46 +-
 sound/soc/intel/boards/bytcr_rt5651.c             |   41 +-
 sound/soc/sunxi/sun4i-spdif.c                     |    5 +
 123 files changed, 1267 insertions(+), 3694 deletions(-)



