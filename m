Return-Path: <linux-kernel+bounces-155940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8868AFB3D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73BBFB2CBEF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD3D145B25;
	Tue, 23 Apr 2024 21:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oWsqojX8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FE414882D;
	Tue, 23 Apr 2024 21:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908782; cv=none; b=CaxAeDKFUc7UezHNmcvz2ZyXd1MskgL3O8CGb15lcydKh2rMMoP7VZJQpM5BfX1smAANfEl7YB+tgTe3llmUVhgbM+CaJ/2UqMGVIwsazQqK+xW8XQ9Hp2PYJzrX4EodRFmAKcqcPd0hbtYOw+XzaXa1vfu+ueOu2oNqrGeBAcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908782; c=relaxed/simple;
	bh=tfifBMPkQiUwviutHeEboN+OAAGFPgxchyGM6bulZ7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cLvFSmbJNIZq/NajLP6QLPtnVE1YidFvyDqAuxd1gNkkwA4tNoXAAe0N8Mdd7k/Ti2v4FEbPilWUjpYPSNpDLKbAZZMcYp2+jL9xXkOG/q3k+vOV6ZSs7/AimvgzOc63rP66N+kyzl7EegwaRC7q5zvfzd0rL86ESsqOb7WO0e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oWsqojX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E8EC3277B;
	Tue, 23 Apr 2024 21:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908781;
	bh=tfifBMPkQiUwviutHeEboN+OAAGFPgxchyGM6bulZ7w=;
	h=From:To:Cc:Subject:Date:From;
	b=oWsqojX85uruBd9KIQjnUInM68Wp/bEHd/fcrUW+Ywt/zvzyjUDbSlyZPUmFiSTsF
	 2DGY55UMAL/U35eV9mm75kagpGyYqyLEn5+m26/B8xUNxO/k94n6oIkG5gNs857En2
	 aorreQtrwixUcZ0//e3btBuqnv8oxCH88uykzcH0=
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
	allen.lkml@gmail.com,
	broonie@kernel.org
Subject: [PATCH 5.15 00/71] 5.15.157-rc1 review
Date: Tue, 23 Apr 2024 14:39:13 -0700
Message-ID: <20240423213844.122920086@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.157-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.157-rc1
X-KernelTest-Deadline: 2024-04-25T21:38+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.15.157 release.
There are 71 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.157-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.157-rc1

Arınç ÜNAL <arinc.unal@arinc9.com>
    net: dsa: mt7530: fix enabling EEE on MT7531 switch on all boards

Arınç ÜNAL <arinc.unal@arinc9.com>
    net: dsa: mt7530: fix improper frames on all 25MHz and 40MHz XTAL MT7530

Vladimir Oltean <olteanv@gmail.com>
    net: dsa: introduce preferred_default_local_cpu_port and use on MT7530

Arınç ÜNAL <arinc.unal@arinc9.com>
    net: dsa: mt7530: set all CPU ports in MT7531_CPU_PMAP

Jeongjun Park <aha310510@gmail.com>
    nilfs2: fix OOB in nilfs_set_de_type

Dave Airlie <airlied@redhat.com>
    nouveau: fix instmem race condition around ptr stores

Zack Rusin <zack.rusin@broadcom.com>
    drm/vmwgfx: Sort primary plane formats by order of preference

xinhui pan <xinhui.pan@amd.com>
    drm/amdgpu: validate the parameters of bo mapping operations more clearly

Carlos Llamas <cmllamas@google.com>
    binder: check offset alignment in binder_get_object()

Yuntao Wang <ytcoode@gmail.com>
    init/main.c: Fix potential static_command_line memory overflow

Yaxiong Tian <tianyaxiong@kylinos.cn>
    arm64: hibernate: Fix level3 translation fault in swsusp_save()

Sandipan Das <sandipan.das@amd.com>
    KVM: x86/pmu: Do not mask LVTPC when handling a PMI on AMD platforms

Sean Christopherson <seanjc@google.com>
    KVM: x86: Snapshot if a vCPU's vendor model is AMD vs. Intel compatible

Alan Stern <stern@rowland.harvard.edu>
    fs: sysfs: Fix reference leak in sysfs_break_active_protection()

Samuel Thibault <samuel.thibault@ens-lyon.org>
    speakup: Avoid crash on very long word

Alexander Usyskin <alexander.usyskin@intel.com>
    mei: me: disable RPL-S on SPS and IGN firmwares

Norihiko Hama <Norihiko.Hama@alpsalpine.com>
    usb: gadget: f_ncm: Fix UAF ncm object at re-bind after usb ep transport error

Kai-Heng Feng <kai.heng.feng@canonical.com>
    usb: Disable USB3 LPM at shutdown

Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
    usb: dwc2: host: Fix dereference issue in DDMA completion flow.

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "usb: cdc-wdm: close race between read and workqueue"

Daniele Palmas <dnlplm@gmail.com>
    USB: serial: option: add Telit FN920C04 rmnet compositions

Vanillan Wang <vanillanwang@163.com>
    USB: serial: option: add Rolling RW101-GL and RW135-GL support

Jerry Meng <jerry-meng@foxmail.com>
    USB: serial: option: support Quectel EM060K sub-models

Coia Prant <coiaprant@gmail.com>
    USB: serial: option: add Lonsung U8300/U9300 product

Chuanhong Guo <gch981213@gmail.com>
    USB: serial: option: add support for Fibocom FM650/FG650

bolan wang <bolan.wang@fibocom.com>
    USB: serial: option: add Fibocom FM135-GL variants

Finn Thain <fthain@linux-m68k.org>
    serial/pmac_zilog: Remove flawed mitigation for rx irq flood

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    comedi: vmk80xx: fix incomplete endpoint checking

Gil Fine <gil.fine@linux.intel.com>
    thunderbolt: Fix wake configurations after device unplug

Gil Fine <gil.fine@linux.intel.com>
    thunderbolt: Avoid notify PM core about runtime PM resume

Eric Biggers <ebiggers@google.com>
    x86/cpufeatures: Fix dependencies for GFNI, VAES, and VPCLMULQDQ

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/bugs: Fix BHI retpoline check

Stephen Boyd <sboyd@kernel.org>
    clk: Get runtime PM before walking tree during disable_unused

Stephen Boyd <sboyd@kernel.org>
    clk: Initialize struct clk_core kref earlier

Konrad Dybcio <konrad.dybcio@linaro.org>
    clk: Print an info line before disabling unused clocks

Claudiu Beznea <claudiu.beznea@microchip.com>
    clk: remove extra empty line

Stephen Boyd <sboyd@kernel.org>
    clk: Mark 'all_lists' as const

Stephen Boyd <sboyd@kernel.org>
    clk: Remove prepare_lock hold assertion in __clk_release()

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/panel: visionox-rm69299: don't unregister DSI device

Mikhail Kobuk <m.kobuk@ispras.ru>
    drm: nv04: Fix out of bounds access

Peter Oberparleiter <oberpar@linux.ibm.com>
    s390/cio: fix race condition during online processing

Peter Oberparleiter <oberpar@linux.ibm.com>
    s390/qdio: handle deferred cc1

Michael Guralnik <michaelgur@nvidia.com>
    RDMA/mlx5: Fix port number for counter query in multi-port configuration

Mark Zhang <markzhang@nvidia.com>
    RDMA/cm: Print the old state when cm_destroy_id gets timeout

Yanjun.Zhu <yanjun.zhu@linux.dev>
    RDMA/rxe: Fix the problem "mutex_destroy missing"

Siddharth Vadapalli <s-vadapalli@ti.com>
    net: ethernet: ti: am65-cpsw-nuss: cleanup DMA Channels before using them

Arınç ÜNAL <arinc.unal@arinc9.com>
    net: dsa: mt7530: fix mirroring frames received on local port

Lei Chen <lei.chen@smartx.com>
    tun: limit printing rate when illegal packet received by tun dev

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Don't peek OOB data without MSG_OOB.

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Call manage_oob() for every skb in unix_stream_read_generic().

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: flowtable: incorrect pppoe tuple

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: flowtable: validate pppoe header

Vlad Buslov <vladbu@nvidia.com>
    netfilter: nf_flow_table: count pending offload workqueue tasks

Florian Westphal <fw@strlen.de>
    netfilter: nft_set_pipapo: do not free live element

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: br_netfilter: skip conntrack input hook for promisc packets

Ziyang Xuan <william.xuanziyang@huawei.com>
    netfilter: nf_tables: Fix potential data-race in __nft_obj_type_get()

Ziyang Xuan <william.xuanziyang@huawei.com>
    netfilter: nf_tables: Fix potential data-race in __nft_expr_type_get()

Chuck Lever <chuck.lever@oracle.com>
    Revert "lockd: introduce safe async lock op"

Siddh Raman Pant <siddh.raman.pant@oracle.com>
    Revert "tracing/trigger: Fix to return error if failed to alloc snapshot"

Zheng Yejian <zhengyejian1@huawei.com>
    kprobes: Fix possible use-after-free issue on kprobe registration

Daniel Borkmann <daniel@iogearbox.net>
    bpf: Fix ringbuf memory type confusion when passing to helpers

Daniel Borkmann <daniel@iogearbox.net>
    bpf: Fix out of bounds access for ringbuf helpers

Daniel Borkmann <daniel@iogearbox.net>
    bpf: Generally fix helper register offset check

Daniel Borkmann <daniel@iogearbox.net>
    bpf: Generalize check_ctx_reg for reuse with other types

Kumar Kartikeya Dwivedi <memxor@gmail.com>
    bpf: Extend kfunc with PTR_TO_CTX, PTR_TO_MEM argument support

Yuanhe Shu <xiangzao@linux.alibaba.com>
    selftests/ftrace: Limit length in subsystem-enable tests

Steven Rostedt (Google) <rostedt@goodmis.org>
    SUNRPC: Fix rpcgss_context trace event acceptor field

Boris Burkov <boris@bur.io>
    btrfs: record delayed inode root in transaction

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: do not set SMB2_GLOBAL_CAP_ENCRYPTION for SMB 3.1.1

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: validate payload size in ipc response

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: don't send oplock break if rename fails


-------------

Diffstat:

 Documentation/filesystems/nfs/exporting.rst        |   7 -
 Makefile                                           |   4 +-
 arch/arm64/mm/pageattr.c                           |   3 -
 arch/x86/include/asm/kvm_host.h                    |   1 +
 arch/x86/kernel/cpu/bugs.c                         |  11 +-
 arch/x86/kernel/cpu/cpuid-deps.c                   |   6 +-
 arch/x86/kvm/cpuid.c                               |   1 +
 arch/x86/kvm/cpuid.h                               |  10 ++
 arch/x86/kvm/lapic.c                               |   3 +-
 arch/x86/kvm/mmu/mmu.c                             |   2 +-
 arch/x86/kvm/x86.c                                 |   2 +-
 drivers/accessibility/speakup/main.c               |   2 +-
 drivers/android/binder.c                           |   4 +-
 drivers/clk/clk.c                                  | 154 ++++++++++++++++-----
 drivers/comedi/drivers/vmk80xx.c                   |  35 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  72 ++++++----
 drivers/gpu/drm/nouveau/nouveau_bios.c             |  13 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c |   7 +-
 drivers/gpu/drm/panel/panel-visionox-rm69299.c     |   2 -
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |   4 +-
 drivers/infiniband/core/cm.c                       |  11 +-
 drivers/infiniband/hw/mlx5/mad.c                   |   3 +-
 drivers/infiniband/sw/rxe/rxe.c                    |   2 +
 drivers/misc/mei/pci-me.c                          |   2 +-
 drivers/net/dsa/mt7530.c                           |  60 +++++---
 drivers/net/dsa/mt7530.h                           |   6 +
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |  18 +++
 drivers/net/tun.c                                  |  18 +--
 drivers/s390/cio/device.c                          |  13 +-
 drivers/s390/cio/qdio_main.c                       |  28 +++-
 drivers/thunderbolt/switch.c                       |  50 +++++--
 drivers/thunderbolt/tb.c                           |   4 +-
 drivers/thunderbolt/tb.h                           |   3 +-
 drivers/thunderbolt/usb4.c                         |  13 +-
 drivers/tty/serial/pmac_zilog.c                    |  14 --
 drivers/usb/class/cdc-wdm.c                        |   6 +-
 drivers/usb/core/port.c                            |   4 +-
 drivers/usb/dwc2/hcd_ddma.c                        |   4 +-
 drivers/usb/gadget/function/f_ncm.c                |   4 +-
 drivers/usb/serial/option.c                        |  40 ++++++
 fs/btrfs/delayed-inode.c                           |   3 +
 fs/ksmbd/ksmbd_netlink.h                           |   3 +-
 fs/ksmbd/mgmt/share_config.c                       |   7 +-
 fs/ksmbd/smb2ops.c                                 |  10 +-
 fs/ksmbd/smb2pdu.c                                 |   3 +-
 fs/ksmbd/transport_ipc.c                           |  37 +++++
 fs/lockd/svclock.c                                 |   4 +-
 fs/nfsd/nfs4state.c                                |  10 +-
 fs/nilfs2/dir.c                                    |   2 +-
 fs/sysfs/file.c                                    |   2 +
 include/linux/bpf.h                                |   9 +-
 include/linux/bpf_verifier.h                       |   4 +-
 include/linux/exportfs.h                           |  14 --
 include/net/dsa.h                                  |   8 ++
 include/net/net_namespace.h                        |   6 +
 include/net/netfilter/nf_flow_table.h              |  33 ++++-
 include/net/netns/flow_table.h                     |  14 ++
 include/trace/events/rpcgss.h                      |   4 +-
 init/main.c                                        |   2 +
 kernel/bpf/btf.c                                   |  93 ++++++++++---
 kernel/bpf/verifier.c                              |  66 ++++++---
 kernel/kprobes.c                                   |  18 ++-
 kernel/trace/trace_events_trigger.c                |   6 +-
 net/bridge/br_input.c                              |  15 +-
 net/bridge/br_netfilter_hooks.c                    |   6 +
 net/bridge/br_private.h                            |   1 +
 net/bridge/netfilter/nf_conntrack_bridge.c         |  14 +-
 net/dsa/dsa2.c                                     |  24 +++-
 net/netfilter/Kconfig                              |   9 ++
 net/netfilter/Makefile                             |   1 +
 net/netfilter/nf_flow_table_core.c                 |  62 ++++++++-
 net/netfilter/nf_flow_table_inet.c                 |   3 +-
 net/netfilter/nf_flow_table_ip.c                   |  10 +-
 net/netfilter/nf_flow_table_offload.c              |  17 ++-
 net/netfilter/nf_flow_table_procfs.c               |  80 +++++++++++
 net/netfilter/nf_tables_api.c                      |  16 ++-
 net/netfilter/nft_set_pipapo.c                     |  14 +-
 net/unix/af_unix.c                                 |  12 +-
 .../ftrace/test.d/event/subsystem-enable.tc        |   6 +-
 79 files changed, 973 insertions(+), 321 deletions(-)



