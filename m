Return-Path: <linux-kernel+bounces-163839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606178B734A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846D81C22E2A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E0E12D1FD;
	Tue, 30 Apr 2024 11:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JXHRDrDu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3498A17592;
	Tue, 30 Apr 2024 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475842; cv=none; b=EDGjiqaRFjVGBIfihaxf7jhq9wQYXZP7YiRVgEIKmLucuOEh4dFilZlFkJC0xV5e1JmMJJ1yE7A1/01SbnED9bwf+CCZefga3N3yBGTxma/XC7t0xWkQIvEUjTpmSirnsiX+lZ2s0FdXb6Jsaf94HjST6KGz9w4BqBC1qMW6OiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475842; c=relaxed/simple;
	bh=1N5fAmswOW2CJAUBi9CmqK5Jt65hx7NoDrXGCzh+IS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rc/JMsmlB4rR3TXm3oxIL5L2G02DKpvPLbSQSFjerEksGPcmeRvYf/HdRL7rRXGcqXef/WAs+2+lJoc2u2pEgPCENKSYouIeteWjhKzOlnaAjikUeLxtC0Xsd9dVfM/xNnWi2bDYGNKG6Ole1e0w3k+sFUDUI2tffKlIQoPf3A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JXHRDrDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AC5C2BBFC;
	Tue, 30 Apr 2024 11:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475842;
	bh=1N5fAmswOW2CJAUBi9CmqK5Jt65hx7NoDrXGCzh+IS4=;
	h=From:To:Cc:Subject:Date:From;
	b=JXHRDrDus4hTQu6dQUEt/791+NPUJY8C7PUlvJcysgEIZLSYtWDymI98oBhIA/S90
	 prxDYWEh10IEpleo9PIc8z4u/MpAcaU/nou/rf6lDdddiPfSdmYSpFkwzdV1MUuXaN
	 t8I2pgykTr0ANPrjrfqak78zBbcSmsfZjDatasDA=
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
Subject: [PATCH 5.15 00/80] 5.15.158-rc1 review
Date: Tue, 30 Apr 2024 12:39:32 +0200
Message-ID: <20240430103043.397234724@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.158-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.158-rc1
X-KernelTest-Deadline: 2024-05-02T10:30+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.15.158 release.
There are 80 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.158-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.158-rc1

Randy Dunlap <rdunlap@infradead.org>
    serial: core: fix kernel-doc for uart_port_unlock_irqrestore()

Yick Xie <yick.xie@gmail.com>
    udp: preserve the connected status if only UDP cmsg

Matthew Wilcox (Oracle) <willy@infradead.org>
    bounds: Use the right number of bits for power-of-two CONFIG_NR_CPUS

Nam Cao <namcao@linutronix.de>
    HID: i2c-hid: remove I2C_HID_READ_PENDING flag to prevent lock-up

Nam Cao <namcao@linutronix.de>
    fbdev: fix incorrect address computation in deferred IO

Wolfram Sang <wsa+renesas@sang-engineering.com>
    i2c: smbus: fix NULL function pointer dereference

Samuel Holland <samuel.holland@sifive.com>
    riscv: Fix TASK_SIZE on 64-bit NOMMU

Baoquan He <bhe@redhat.com>
    riscv: fix VMALLOC_START definition

Fenghua Yu <fenghua.yu@intel.com>
    dmaengine: idxd: Fix oops during rmmod on single-CPU platforms

Sean Anderson <sean.anderson@linux.dev>
    dma: xilinx_dpdma: Fix locking

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

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/sdma5.2: use legacy HDP flush for SDMA2/3

Iskander Amara <iskander.amara@theobroma-systems.com>
    arm64: dts: rockchip: enable internal pull-up for Q7_THRM# on RK3399 Puma

Sean Christopherson <seanjc@google.com>
    cpu: Re-enable CPU mitigations by default for !X86 architectures

Johannes Thumshirn <johannes.thumshirn@wdc.com>
    btrfs: fix information leak in btrfs_ioctl_logical_to_ino()

Mantas Pucka <mantas@8devices.com>
    mmc: sdhci-msm: pervent access to suspended controller

Johan Hovold <johan+linaro@kernel.org>
    Bluetooth: qca: fix NULL-deref on non-serdev suspend

WangYuli <wangyuli@uniontech.com>
    Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0bda:0x4853

Nathan Chancellor <nathan@kernel.org>
    Bluetooth: Fix type of len in {l2cap,sco}_sock_getsockopt_old()

David Kaplan <david.kaplan@amd.com>
    x86/cpu: Fix check for RDPKRU in __show_regs()

Robin H. Johnson <robbat2@gentoo.org>
    tracing: Increase PERF_MAX_TRACE_SIZE to handle Sentinel1 and docker together

Robin H. Johnson <robbat2@gentoo.org>
    tracing: Show size of requested perf buffer

Shifeng Li <lishifeng@sangfor.com.cn>
    net/mlx5e: Fix a race in command alloc flow

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "crypto: api - Disallow identical driver names"

Zack Rusin <zack.rusin@broadcom.com>
    drm/vmwgfx: Fix crtc's atomic check conditional

Jim Cromie <jim.cromie@gmail.com>
    drm-print: add drm_dbg_driver to improve namespace symmetry

Emil Kronborg <emil.kronborg@protonmail.com>
    serial: mxs-auart: add spinlock around changing cts state

Thomas Gleixner <tglx@linutronix.de>
    serial: core: Provide port lock wrappers

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Suppress false-positive lockdep splat for spin_lock() in __unix_gc().

Jason Reeder <jreeder@ti.com>
    net: ethernet: ti: am65-cpts: Fix PTPv1 message type on TX packets

Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
    iavf: Fix TC config comparison with existing adapter TC config

Erwan Velu <e.velu@criteo.com>
    i40e: Report MFS in decimal base instead of hex

Sindhu Devale <sindhu.devale@intel.com>
    i40e: Do not use WQ_MEM_RECLAIM flag for workqueue

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: honor table dormant flag from netdev release event path

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

Eric Dumazet <edumazet@google.com>
    ipv4: check for NULL idev in ip_route_use_hint()

Paul Geurts <paul_geurts@live.nl>
    NFC: trf7970a: disable all regulators on removal

Hangbin Liu <liuhangbin@gmail.com>
    bridge/br_netlink.c: no need to return void function

Eric Dumazet <edumazet@google.com>
    icmp: prevent possible NULL dereferences from icmp_build_probe()

Ido Schimmel <idosch@nvidia.com>
    mlxsw: core: Unregister EMAD trap using FORWARD action

David Bauer <mail@david-bauer.net>
    vxlan: drop packets from invalid src-address

Miri Korenblit <miriam.rachel.korenblit@intel.com>
    wifi: iwlwifi: mvm: return uid from iwl_mvm_build_scan_cmd

Avraham Stern <avraham.stern@intel.com>
    wifi: iwlwifi: mvm: remove old PASN station when adding a new one

Alexey Brodkin <Alexey.Brodkin@synopsys.com>
    ARC: [plat-hsdk]: Remove misplaced interrupt-cells property

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: mediatek: mt2712: fix validation errors

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: mediatek: mt7622: drop "reset-names" from thermal block

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: mediatek: mt7622: fix ethernet controller "compatible"

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: mediatek: mt7622: fix IR nodename

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: mediatek: mt7622: fix clock controllers

Felix Fietkau <nbd@nbd.name>
    arm64: dts: mediatek: mt7622: introduce nodes for Wireless Ethernet Dispatch

Felix Fietkau <nbd@nbd.name>
    arm64: dts: mediatek: mt7622: add support for coherent DMA

Ikjoon Jang <ikjn@chromium.org>
    arm64: dts: mediatek: mt8183: Add power-domains properity to mfgcfg

Dragan Simic <dsimic@manjaro.org>
    arm64: dts: rockchip: Remove unsupported node from the Pinebook Pro dts

Quentin Schulz <quentin.schulz@theobroma-systems.com>
    arm64: dts: rockchip: enable internal pull-up on PCIE_WAKE# for RK3399 Puma

Iskander Amara <iskander.amara@theobroma-systems.com>
    arm64: dts: rockchip: fix alphabetical ordering RK3399 puma

Quentin Schulz <quentin.schulz@theobroma-systems.com>
    arm64: dts: rockchip: enable internal pull-up on Q7_USB_ID for RK3399 Puma

Yaraslau Furman <yaro330@gmail.com>
    HID: logitech-dj: allow mice to use all types of reports

Zhang Lixu <lixu.zhang@intel.com>
    HID: intel-ish-hid: ipc: Fix dev_err usage with uninitialized dev->devc

Takayuki Nagata <tnagata@redhat.com>
    cifs: reinstate original behavior again for forceuid/forcegid

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix rename(2) regression against samba


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/Kconfig                                       |  8 +++
 arch/arc/boot/dts/hsdk.dts                         |  1 -
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts        |  8 +--
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |  3 +-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           | 62 +++++++++++------
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |  1 +
 .../boot/dts/rockchip/rk3399-pinebook-pro.dts      |  1 -
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      | 31 ++++++---
 arch/riscv/include/asm/pgtable.h                   |  4 +-
 arch/x86/Kconfig                                   | 11 +--
 arch/x86/kernel/process_64.c                       |  2 +-
 crypto/algapi.c                                    |  1 -
 drivers/bluetooth/btusb.c                          |  2 +
 drivers/bluetooth/hci_qca.c                        |  3 +
 drivers/dma/idma64.c                               |  4 ++
 drivers/dma/idxd/perfmon.c                         |  9 +--
 drivers/dma/owl-dma.c                              |  4 +-
 drivers/dma/xilinx/xilinx_dpdma.c                  | 13 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             | 24 ++++---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                | 11 ++-
 drivers/hid/hid-logitech-dj.c                      |  4 +-
 drivers/hid/i2c-hid/i2c-hid-core.c                 |  8 ---
 drivers/hid/intel-ish-hid/ipc/ipc.c                |  2 +-
 drivers/i2c/i2c-core-base.c                        | 12 ++--
 drivers/irqchip/irq-gic-v3-its.c                   |  9 +--
 drivers/mmc/host/sdhci-msm.c                       | 16 ++++-
 drivers/mtd/nand/raw/diskonchip.c                  |  4 +-
 drivers/net/ethernet/broadcom/b44.c                | 14 ++--
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  6 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        | 30 +++++++-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      | 12 ++--
 drivers/net/ethernet/mellanox/mlxsw/core.c         |  2 +-
 .../ethernet/mellanox/mlxsw/spectrum_acl_tcam.c    | 54 ++++++++++++---
 drivers/net/ethernet/ti/am65-cpts.c                |  5 ++
 drivers/net/gtp.c                                  |  3 +-
 drivers/net/usb/ax88179_178a.c                     | 11 +--
 drivers/net/vxlan/vxlan_core.c                     |  4 ++
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |  2 +
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |  3 +-
 drivers/nfc/trf7970a.c                             | 42 ++++++------
 drivers/tty/serial/mxs-auart.c                     |  8 ++-
 drivers/video/fbdev/core/fb_defio.c                |  2 +-
 fs/btrfs/backref.c                                 | 12 +---
 fs/cifs/cifsfs.c                                   |  1 +
 fs/cifs/fs_context.c                               | 12 ++++
 fs/cifs/fs_context.h                               |  2 +
 include/drm/drm_print.h                            |  3 +-
 include/linux/etherdevice.h                        | 25 +++++++
 include/linux/serial_core.h                        | 79 ++++++++++++++++++++++
 include/linux/trace_events.h                       |  2 +-
 include/net/af_unix.h                              |  3 +
 kernel/bounds.c                                    |  2 +-
 kernel/cpu.c                                       |  4 +-
 kernel/trace/trace_event_perf.c                    |  3 +-
 lib/stackdepot.c                                   |  4 +-
 net/bluetooth/l2cap_sock.c                         |  7 +-
 net/bluetooth/sco.c                                |  7 +-
 net/bridge/br_netlink.c                            |  2 +-
 net/ethernet/eth.c                                 | 12 +---
 net/ipv4/icmp.c                                    | 12 +++-
 net/ipv4/inet_timewait_sock.c                      | 34 ++++++----
 net/ipv4/route.c                                   |  3 +
 net/ipv4/udp.c                                     |  5 +-
 net/ipv6/udp.c                                     |  5 +-
 net/netfilter/ipvs/ip_vs_proto_sctp.c              |  6 +-
 net/netfilter/nft_chain_filter.c                   |  4 +-
 net/openvswitch/conntrack.c                        |  4 +-
 net/unix/garbage.c                                 |  2 +-
 70 files changed, 503 insertions(+), 213 deletions(-)



