Return-Path: <linux-kernel+bounces-164033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A288B8B776A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A63CDB22840
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B2D1F171;
	Tue, 30 Apr 2024 13:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GoduuMrm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C86171E66;
	Tue, 30 Apr 2024 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484609; cv=none; b=MmyRf69GIJvhmL98C3QGAsDzgz2BdMwAHpoRw6voOYDVN64akAFW2+Io34otfpMTvY6I9fnKOJGqhObD/6C7XU9QGfWm4n9988YUb+Gju6G5Xz3fWtPxX2BIA80sFFyC3tAvVY7BmI3z6ghcC6PoI3MIhvLylLhtGNVZrYtQYEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484609; c=relaxed/simple;
	bh=32Tj/PvB56S7awoUQdRXI2aDxCLwLAKzbmehVe0xzRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hqRPhdcxoKxxrSjO23SB7llO1rBOabNlEIjRg1lWR4rGzlsM7y4/FsI7BgFgMeCnlkEs9vJPAcY6K3nQo4Hm540rG53CgEuJI2NO9L2AcmuNX4H4HUObpG+Mqs/tamfKYUlASAy1hmo62KzziWkplcL6R6pOnoltQUamDxZahro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GoduuMrm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1342CC4AF18;
	Tue, 30 Apr 2024 13:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714484608;
	bh=32Tj/PvB56S7awoUQdRXI2aDxCLwLAKzbmehVe0xzRU=;
	h=From:To:Cc:Subject:Date:From;
	b=GoduuMrmCfgxGLoMmU8pYvWH4sKR5nMw9z12lG3fjulU1oBTgyZggdpdf30SX6apf
	 wx+dw8M/Ad22eSZvNSfuegGH+SJSqzfu/W+OKkhnRObyAEDLLuz8OphseNY9RIP5i3
	 0B0SUp2HE9ZvGLifTq7lZx/Gcs6g4kAcwSLQY05A=
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
Subject: [PATCH 5.4 000/106] 5.4.275-rc2 review
Date: Tue, 30 Apr 2024 15:43:24 +0200
Message-ID: <20240430134021.555330198@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.275-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.275-rc2
X-KernelTest-Deadline: 2024-05-02T13:40+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.4.275 release.
There are 106 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 02 May 2024 13:40:04 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.275-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.4.275-rc2

Randy Dunlap <rdunlap@infradead.org>
    serial: core: fix kernel-doc for uart_port_unlock_irqrestore()

Yick Xie <yick.xie@gmail.com>
    udp: preserve the connected status if only UDP cmsg

Mikulas Patocka <mpatocka@redhat.com>
    dm: limit the number of targets and parameter size area

Matthew Wilcox (Oracle) <willy@infradead.org>
    bounds: Use the right number of bits for power-of-two CONFIG_NR_CPUS

Nam Cao <namcao@linutronix.de>
    HID: i2c-hid: remove I2C_HID_READ_PENDING flag to prevent lock-up

Wolfram Sang <wsa+renesas@sang-engineering.com>
    i2c: smbus: fix NULL function pointer dereference

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    idma64: Don't try to serve interrupts when device is powered off

Arnd Bergmann <arnd@arndb.de>
    dmaengine: owl: fix register access functions

Eric Dumazet <edumazet@google.com>
    tcp: Fix NEW_SYN_RECV handling in inet_twsk_purge()

Kuniyuki Iwashima <kuniyu@amazon.com>
    tcp: Clean up kernel listener's reqsk in inet_twsk_purge()

Arnd Bergmann <arnd@arndb.de>
    mtd: diskonchip: work around ubsan link failure

Andrey Ryabinin <ryabinin.a.a@gmail.com>
    stackdepot: respect __GFP_NOLOCKDEP allocation flag

Peter Münster <pm@a16n.net>
    net: b44: set pause params only when interface is up

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    ethernet: Add helper for assigning packet type when dest address does not match device address

Guanrui Huang <guanrui.huang@linux.alibaba.com>
    irqchip/gic-v3-its: Prevent double free on error

Mukul Joshi <mukul.joshi@amd.com>
    drm/amdgpu: Fix leak when GPU memory allocation fails

Iskander Amara <iskander.amara@theobroma-systems.com>
    arm64: dts: rockchip: enable internal pull-up for Q7_THRM# on RK3399 Puma

Johannes Thumshirn <johannes.thumshirn@wdc.com>
    btrfs: fix information leak in btrfs_ioctl_logical_to_ino()

WangYuli <wangyuli@uniontech.com>
    Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0bda:0x4853

Nathan Chancellor <nathan@kernel.org>
    Bluetooth: Fix type of len in {l2cap,sco}_sock_getsockopt_old()

Robin H. Johnson <robbat2@gentoo.org>
    tracing: Increase PERF_MAX_TRACE_SIZE to handle Sentinel1 and docker together

Robin H. Johnson <robbat2@gentoo.org>
    tracing: Show size of requested perf buffer

Shifeng Li <lishifeng@sangfor.com.cn>
    net/mlx5e: Fix a race in command alloc flow

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "crypto: api - Disallow identical driver names"

xinhui pan <xinhui.pan@amd.com>
    drm/amdgpu: validate the parameters of bo mapping operations more clearly

Chia-I Wu <olvaffe@gmail.com>
    amdgpu: validate offset_in_bo of drm_amdgpu_gem_va

Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
    drm/amdgpu: restrict bo mapping within gpu address limits

Emil Kronborg <emil.kronborg@protonmail.com>
    serial: mxs-auart: add spinlock around changing cts state

Thomas Gleixner <tglx@linutronix.de>
    serial: core: Provide port lock wrappers

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Suppress false-positive lockdep splat for spin_lock() in __unix_gc().

Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
    iavf: Fix TC config comparison with existing adapter TC config

Sindhu Devale <sindhu.devale@intel.com>
    i40e: Do not use WQ_MEM_RECLAIM flag for workqueue

Ido Schimmel <idosch@nvidia.com>
    mlxsw: spectrum_acl_tcam: Fix memory leak when canceling rehash work

Ido Schimmel <idosch@nvidia.com>
    mlxsw: spectrum_acl_tcam: Fix incorrect list API usage

Ido Schimmel <idosch@nvidia.com>
    mlxsw: spectrum_acl_tcam: Fix warning during rehash

Ido Schimmel <idosch@nvidia.com>
    mlxsw: spectrum_acl_tcam: Fix memory leak during rehash

Ido Schimmel <idosch@nvidia.com>
    mlxsw: spectrum_acl_tcam: Rate limit error message

Ido Schimmel <idosch@nvidia.com>
    mlxsw: spectrum_acl_tcam: Fix possible use-after-free during rehash

Ido Schimmel <idosch@nvidia.com>
    mlxsw: spectrum_acl_tcam: Fix possible use-after-free during activity update

Ido Schimmel <idosch@nvidia.com>
    mlxsw: spectrum_acl_tcam: Fix race during rehash delayed work

Hyunwoo Kim <v4bel@theori.io>
    net: openvswitch: Fix Use-After-Free in ovs_ct_exit

Ismael Luceno <iluceno@suse.de>
    ipvs: Fix checksumming on GSO of SCTP packets

Hyunwoo Kim <v4bel@theori.io>
    net: gtp: Fix Use-After-Free in gtp_dellink

Eric Dumazet <edumazet@google.com>
    net: usb: ax88179_178a: stop lying about skb->truesize

Paul Geurts <paul_geurts@live.nl>
    NFC: trf7970a: disable all regulators on removal

Ido Schimmel <idosch@nvidia.com>
    mlxsw: core: Unregister EMAD trap using FORWARD action

David Bauer <mail@david-bauer.net>
    vxlan: drop packets from invalid src-address

Alexey Brodkin <Alexey.Brodkin@synopsys.com>
    ARC: [plat-hsdk]: Remove misplaced interrupt-cells property

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: mediatek: mt2712: fix validation errors

Biao Huang <biao.huang@mediatek.com>
    arm64: dts: mt2712: add ethernet device node

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: mediatek: mt7622: drop "reset-names" from thermal block

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: mediatek: mt7622: fix ethernet controller "compatible"

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: mediatek: mt7622: fix IR nodename

Quentin Schulz <quentin.schulz@theobroma-systems.com>
    arm64: dts: rockchip: enable internal pull-up on PCIE_WAKE# for RK3399 Puma

Iskander Amara <iskander.amara@theobroma-systems.com>
    arm64: dts: rockchip: fix alphabetical ordering RK3399 puma

Vitaly Kuznetsov <vkuznets@redhat.com>
    KVM: async_pf: Cleanup kvm_setup_async_pf()

Jeongjun Park <aha310510@gmail.com>
    nilfs2: fix OOB in nilfs_set_de_type

Dave Airlie <airlied@redhat.com>
    nouveau: fix instmem race condition around ptr stores

Alan Stern <stern@rowland.harvard.edu>
    fs: sysfs: Fix reference leak in sysfs_break_active_protection()

Samuel Thibault <samuel.thibault@ens-lyon.org>
    speakup: Avoid crash on very long word

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

Carlos Llamas <cmllamas@google.com>
    binder: check offset alignment in binder_get_object()

Eric Biggers <ebiggers@google.com>
    x86/cpufeatures: Fix dependencies for GFNI, VAES, and VPCLMULQDQ

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

Mikhail Kobuk <m.kobuk@ispras.ru>
    drm: nv04: Fix out of bounds access

Michael Guralnik <michaelgur@nvidia.com>
    RDMA/mlx5: Fix port number for counter query in multi-port configuration

Yanjun.Zhu <yanjun.zhu@linux.dev>
    RDMA/rxe: Fix the problem "mutex_destroy missing"

Lei Chen <lei.chen@smartx.com>
    tun: limit printing rate when illegal packet received by tun dev

Ziyang Xuan <william.xuanziyang@huawei.com>
    netfilter: nf_tables: Fix potential data-race in __nft_expr_type_get()

Siddh Raman Pant <siddh.raman.pant@oracle.com>
    Revert "tracing/trigger: Fix to return error if failed to alloc snapshot"

Zheng Yejian <zhengyejian1@huawei.com>
    kprobes: Fix possible use-after-free issue on kprobe registration

Yuanhe Shu <xiangzao@linux.alibaba.com>
    selftests/ftrace: Limit length in subsystem-enable tests

Boris Burkov <boris@bur.io>
    btrfs: record delayed inode root in transaction

Adam Dunlap <acdunlap@google.com>
    x86/apic: Force native_apic_mem_read() to use the MOV instruction

John Stultz <jstultz@google.com>
    selftests: timers: Fix abs() warning in posix_timers test

Gavin Shan <gshan@redhat.com>
    vhost: Add smp_rmb() in vhost_vq_avail_empty()

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/client: Fully protect modes[] with dev->mode_config.mutex

Boris Burkov <boris@bur.io>
    btrfs: qgroup: correctly model root qgroup rsv in convert

David Arinzon <darinzon@amazon.com>
    net: ena: Fix potential sign extension issue

Michal Luczaj <mhal@rbox.co>
    af_unix: Fix garbage collector racing against connect()

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Do not use atomic ops for unix_sk(sk)->inflight.

Cosmin Ratiu <cratiu@nvidia.com>
    net/mlx5: Properly link new fs rules into the tree

Jiri Benc <jbenc@redhat.com>
    ipv6: fix race condition between ipv6_get_ifaddr and ipv6_del_addr

Arnd Bergmann <arnd@arndb.de>
    ipv4/route: avoid unused-but-set-variable warning

Arnd Bergmann <arnd@arndb.de>
    ipv6: fib: hide unused 'pn' variable

Eric Dumazet <edumazet@google.com>
    geneve: fix header validation in geneve[6]_xmit_skb

Petr Tesarik <petr@tesarici.cz>
    u64_stats: fix u64_stats_init() for lockdep when used repeatedly in one file

Ilya Maximets <i.maximets@ovn.org>
    net: openvswitch: fix unwanted error log on timeout policy probing

Arnd Bergmann <arnd@arndb.de>
    nouveau: fix function cast warning

Dmitry Antipov <dmantipov@yandex.ru>
    Bluetooth: Fix memory leak in hci_req_sync_complete()

Sven Eckelmann <sven@narfation.org>
    batman-adv: Avoid infinite loop trying to resize local TT


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arc/boot/dts/hsdk.dts                         |   1 -
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts        |  78 ++++++++++-
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |  68 ++++++++-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           |   7 +-
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      |  29 +++-
 arch/x86/include/asm/apic.h                        |   3 +-
 arch/x86/kernel/cpu/cpuid-deps.c                   |   6 +-
 crypto/algapi.c                                    |   1 -
 drivers/android/binder.c                           |   4 +-
 drivers/bluetooth/btusb.c                          |   2 +
 drivers/clk/clk.c                                  | 154 ++++++++++++++++-----
 drivers/dma/idma64.c                               |   4 +
 drivers/dma/owl-dma.c                              |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  70 ++++++----
 drivers/gpu/drm/drm_client_modeset.c               |   3 +-
 drivers/gpu/drm/nouveau/nouveau_bios.c             |  13 +-
 .../gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c    |   7 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c |   7 +-
 drivers/hid/i2c-hid/i2c-hid-core.c                 |   8 --
 drivers/i2c/i2c-core-base.c                        |  12 +-
 drivers/infiniband/hw/mlx5/mad.c                   |   3 +-
 drivers/infiniband/sw/rxe/rxe.c                    |   2 +
 drivers/irqchip/irq-gic-v3-its.c                   |   9 +-
 drivers/md/dm-core.h                               |   2 +
 drivers/md/dm-ioctl.c                              |   3 +-
 drivers/md/dm-table.c                              |   9 +-
 drivers/mtd/nand/raw/diskonchip.c                  |   4 +-
 drivers/net/ethernet/amazon/ena/ena_com.c          |   2 +-
 drivers/net/ethernet/broadcom/b44.c                |  14 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  30 +++-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |  12 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |   3 +-
 drivers/net/ethernet/mellanox/mlxsw/core.c         |   2 +-
 .../ethernet/mellanox/mlxsw/spectrum_acl_tcam.c    |  54 ++++++--
 drivers/net/geneve.c                               |   4 +-
 drivers/net/gtp.c                                  |   3 +-
 drivers/net/tun.c                                  |  18 +--
 drivers/net/usb/ax88179_178a.c                     |  11 +-
 drivers/net/vxlan.c                                |   4 +
 drivers/nfc/trf7970a.c                             |  42 +++---
 drivers/staging/comedi/drivers/vmk80xx.c           |  35 ++---
 drivers/staging/speakup/main.c                     |   2 +-
 drivers/tty/serial/mxs-auart.c                     |   8 +-
 drivers/tty/serial/pmac_zilog.c                    |  14 --
 drivers/usb/class/cdc-wdm.c                        |   6 +-
 drivers/usb/core/port.c                            |   4 +-
 drivers/usb/dwc2/hcd_ddma.c                        |   4 +-
 drivers/usb/serial/option.c                        |  40 ++++++
 drivers/vhost/vhost.c                              |  14 +-
 fs/btrfs/backref.c                                 |  12 +-
 fs/btrfs/delayed-inode.c                           |   3 +
 fs/btrfs/qgroup.c                                  |   2 +
 fs/nilfs2/dir.c                                    |   2 +-
 fs/sysfs/file.c                                    |   2 +
 include/linux/etherdevice.h                        |  25 ++++
 include/linux/serial_core.h                        |  79 +++++++++++
 include/linux/trace_events.h                       |   2 +-
 include/linux/u64_stats_sync.h                     |   6 +-
 include/net/addrconf.h                             |   4 +
 include/net/af_unix.h                              |   5 +-
 include/net/ip_tunnels.h                           |  33 +++++
 kernel/bounds.c                                    |   2 +-
 kernel/kprobes.c                                   |  18 ++-
 kernel/trace/trace_event_perf.c                    |   3 +-
 kernel/trace/trace_events_trigger.c                |   6 +-
 lib/stackdepot.c                                   |   4 +-
 net/batman-adv/translation-table.c                 |   2 +-
 net/bluetooth/hci_request.c                        |   4 +-
 net/bluetooth/l2cap_sock.c                         |   7 +-
 net/bluetooth/sco.c                                |   7 +-
 net/ethernet/eth.c                                 |  12 +-
 net/ipv4/inet_timewait_sock.c                      |  34 +++--
 net/ipv4/route.c                                   |   4 +-
 net/ipv4/udp.c                                     |   5 +-
 net/ipv6/addrconf.c                                |   7 +-
 net/ipv6/ip6_fib.c                                 |   7 +-
 net/ipv6/udp.c                                     |   5 +-
 net/netfilter/ipvs/ip_vs_proto_sctp.c              |   6 +-
 net/netfilter/nf_tables_api.c                      |   8 +-
 net/openvswitch/conntrack.c                        |   9 +-
 net/unix/af_unix.c                                 |   4 +-
 net/unix/garbage.c                                 |  35 +++--
 net/unix/scm.c                                     |   8 +-
 .../ftrace/test.d/event/subsystem-enable.tc        |   6 +-
 tools/testing/selftests/timers/posix_timers.c      |   2 +-
 virt/kvm/async_pf.c                                |  19 +--
 89 files changed, 905 insertions(+), 340 deletions(-)



