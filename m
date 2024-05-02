Return-Path: <linux-kernel+bounces-166563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F958B9C79
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672251C2082C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662681534F5;
	Thu,  2 May 2024 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gdrY6E/X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B19D5FEE6;
	Thu,  2 May 2024 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714660671; cv=none; b=ezG7+OsOUm7jPif0IT6PuFyAEUpRCwlBzeasGcpTe4aCIxjaDW0D75zZCA8CPQFaOWnzE0wQLOqLQRknVE8uQvg9rMNs7x3jT3/wpF5wNnWZooLK+haK+DMZ5WYtUyRstRGg7y164pAAuDu51A2I8nhTCjEHQp0DV34F7lAHo8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714660671; c=relaxed/simple;
	bh=5kjKv/PieV4ZpMeooiZc46BRCN0JmGoKm1VHy/g6BcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oTt1Tvld9FrgteKr5reC0xR3KcvwtAtcxq5lkA6zZg0JdCk3nRUUcke1wR8CGt9oOIYBiXcqFGzNN/9LS7PSEeMTLO/ORW28E23EbUMADtDAljHLgzBbsrM0NFq1Py0k5daE2FcEVpEa5ggwqyBnj7SH77hF98KANyudw3WGwAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gdrY6E/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B3DC113CC;
	Thu,  2 May 2024 14:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714660670;
	bh=5kjKv/PieV4ZpMeooiZc46BRCN0JmGoKm1VHy/g6BcU=;
	h=From:To:Cc:Subject:Date:From;
	b=gdrY6E/XHZFt1uoyh91d1Zf59duV1NUzsiJDuievkWXiUMBl++sE/k8Z7QFH7vFCF
	 s5H4LqEBSunpvAUVFyRG7e+aTwxjSEtE4K5dP96b7EN+GP7JmKAukfZZ2w6LiUcCk+
	 lb3SD9/NHMXaPhvwjaJ2fyQBOtiL/PRkmmHMQtxA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.4.275
Date: Thu,  2 May 2024 16:37:46 +0200
Message-ID: <2024050246-agreed-creatable-b296@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.4.275 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                        |    2 
 arch/arc/boot/dts/hsdk.dts                                      |    1 
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts                     |   78 ++++-
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi                       |   68 ++++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi                        |    7 
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi                   |   29 +
 arch/x86/include/asm/apic.h                                     |    3 
 arch/x86/kernel/cpu/cpuid-deps.c                                |    6 
 crypto/algapi.c                                                 |    1 
 drivers/android/binder.c                                        |    4 
 drivers/bluetooth/btusb.c                                       |    2 
 drivers/clk/clk.c                                               |  154 +++++++---
 drivers/dma/idma64.c                                            |    4 
 drivers/dma/owl-dma.c                                           |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                          |   70 ++--
 drivers/gpu/drm/drm_client_modeset.c                            |    3 
 drivers/gpu/drm/nouveau/nouveau_bios.c                          |   13 
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c             |    7 
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c              |    7 
 drivers/hid/i2c-hid/i2c-hid-core.c                              |    8 
 drivers/i2c/i2c-core-base.c                                     |   12 
 drivers/infiniband/hw/mlx5/mad.c                                |    3 
 drivers/infiniband/sw/rxe/rxe.c                                 |    2 
 drivers/irqchip/irq-gic-v3-its.c                                |    9 
 drivers/md/dm-core.h                                            |    2 
 drivers/md/dm-ioctl.c                                           |    3 
 drivers/md/dm-table.c                                           |    9 
 drivers/mtd/nand/raw/diskonchip.c                               |    4 
 drivers/net/ethernet/amazon/ena/ena_com.c                       |    2 
 drivers/net/ethernet/broadcom/b44.c                             |   14 
 drivers/net/ethernet/intel/i40e/i40e_main.c                     |    2 
 drivers/net/ethernet/intel/iavf/iavf_main.c                     |   30 +
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                   |   12 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c               |    3 
 drivers/net/ethernet/mellanox/mlxsw/core.c                      |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c         |   54 ++-
 drivers/net/geneve.c                                            |    4 
 drivers/net/gtp.c                                               |    3 
 drivers/net/tun.c                                               |   18 -
 drivers/net/usb/ax88179_178a.c                                  |   11 
 drivers/net/vxlan.c                                             |    4 
 drivers/nfc/trf7970a.c                                          |   42 +-
 drivers/staging/comedi/drivers/vmk80xx.c                        |   35 --
 drivers/staging/speakup/main.c                                  |    2 
 drivers/tty/serial/mxs-auart.c                                  |    8 
 drivers/tty/serial/pmac_zilog.c                                 |   14 
 drivers/usb/class/cdc-wdm.c                                     |    6 
 drivers/usb/core/port.c                                         |    4 
 drivers/usb/dwc2/hcd_ddma.c                                     |    4 
 drivers/usb/serial/option.c                                     |   40 ++
 drivers/vhost/vhost.c                                           |   12 
 fs/btrfs/backref.c                                              |   12 
 fs/btrfs/delayed-inode.c                                        |    3 
 fs/btrfs/qgroup.c                                               |    2 
 fs/nilfs2/dir.c                                                 |    2 
 fs/sysfs/file.c                                                 |    2 
 include/linux/etherdevice.h                                     |   25 +
 include/linux/serial_core.h                                     |   79 +++++
 include/linux/trace_events.h                                    |    2 
 include/linux/u64_stats_sync.h                                  |    6 
 include/net/addrconf.h                                          |    4 
 include/net/af_unix.h                                           |    5 
 include/net/ip_tunnels.h                                        |   33 ++
 kernel/bounds.c                                                 |    2 
 kernel/kprobes.c                                                |   18 -
 kernel/trace/trace_event_perf.c                                 |    3 
 kernel/trace/trace_events_trigger.c                             |    6 
 lib/stackdepot.c                                                |    4 
 net/batman-adv/translation-table.c                              |    2 
 net/bluetooth/hci_request.c                                     |    4 
 net/bluetooth/l2cap_sock.c                                      |    7 
 net/bluetooth/sco.c                                             |    7 
 net/ethernet/eth.c                                              |   12 
 net/ipv4/inet_timewait_sock.c                                   |   32 +-
 net/ipv4/route.c                                                |    4 
 net/ipv4/udp.c                                                  |    5 
 net/ipv6/addrconf.c                                             |    7 
 net/ipv6/ip6_fib.c                                              |    7 
 net/ipv6/udp.c                                                  |    5 
 net/netfilter/ipvs/ip_vs_proto_sctp.c                           |    6 
 net/netfilter/nf_tables_api.c                                   |    8 
 net/openvswitch/conntrack.c                                     |    9 
 net/unix/af_unix.c                                              |    4 
 net/unix/garbage.c                                              |   35 +-
 net/unix/scm.c                                                  |    8 
 tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc |    6 
 tools/testing/selftests/timers/posix_timers.c                   |    2 
 virt/kvm/async_pf.c                                             |   19 -
 89 files changed, 902 insertions(+), 337 deletions(-)

Adam Dunlap (1):
      x86/apic: Force native_apic_mem_read() to use the MOV instruction

Alan Stern (1):
      fs: sysfs: Fix reference leak in sysfs_break_active_protection()

Alexey Brodkin (1):
      ARC: [plat-hsdk]: Remove misplaced interrupt-cells property

Andrey Ryabinin (1):
      stackdepot: respect __GFP_NOLOCKDEP allocation flag

Andy Shevchenko (1):
      idma64: Don't try to serve interrupts when device is powered off

Arnd Bergmann (5):
      nouveau: fix function cast warning
      ipv6: fib: hide unused 'pn' variable
      ipv4/route: avoid unused-but-set-variable warning
      mtd: diskonchip: work around ubsan link failure
      dmaengine: owl: fix register access functions

Biao Huang (1):
      arm64: dts: mt2712: add ethernet device node

Boris Burkov (2):
      btrfs: qgroup: correctly model root qgroup rsv in convert
      btrfs: record delayed inode root in transaction

Carlos Llamas (1):
      binder: check offset alignment in binder_get_object()

Chia-I Wu (1):
      amdgpu: validate offset_in_bo of drm_amdgpu_gem_va

Chuanhong Guo (1):
      USB: serial: option: add support for Fibocom FM650/FG650

Claudiu Beznea (1):
      clk: remove extra empty line

Coia Prant (1):
      USB: serial: option: add Lonsung U8300/U9300 product

Cosmin Ratiu (1):
      net/mlx5: Properly link new fs rules into the tree

Daniele Palmas (1):
      USB: serial: option: add Telit FN920C04 rmnet compositions

Dave Airlie (1):
      nouveau: fix instmem race condition around ptr stores

David Arinzon (1):
      net: ena: Fix potential sign extension issue

David Bauer (1):
      vxlan: drop packets from invalid src-address

Dmitry Antipov (1):
      Bluetooth: Fix memory leak in hci_req_sync_complete()

Emil Kronborg (1):
      serial: mxs-auart: add spinlock around changing cts state

Eric Biggers (1):
      x86/cpufeatures: Fix dependencies for GFNI, VAES, and VPCLMULQDQ

Eric Dumazet (3):
      geneve: fix header validation in geneve[6]_xmit_skb
      net: usb: ax88179_178a: stop lying about skb->truesize
      tcp: Fix NEW_SYN_RECV handling in inet_twsk_purge()

Finn Thain (1):
      serial/pmac_zilog: Remove flawed mitigation for rx irq flood

Gavin Shan (1):
      vhost: Add smp_rmb() in vhost_vq_avail_empty()

Greg Kroah-Hartman (3):
      Revert "usb: cdc-wdm: close race between read and workqueue"
      Revert "crypto: api - Disallow identical driver names"
      Linux 5.4.275

Guanrui Huang (1):
      irqchip/gic-v3-its: Prevent double free on error

Hyunwoo Kim (2):
      net: gtp: Fix Use-After-Free in gtp_dellink
      net: openvswitch: Fix Use-After-Free in ovs_ct_exit

Ido Schimmel (9):
      mlxsw: core: Unregister EMAD trap using FORWARD action
      mlxsw: spectrum_acl_tcam: Fix race during rehash delayed work
      mlxsw: spectrum_acl_tcam: Fix possible use-after-free during activity update
      mlxsw: spectrum_acl_tcam: Fix possible use-after-free during rehash
      mlxsw: spectrum_acl_tcam: Rate limit error message
      mlxsw: spectrum_acl_tcam: Fix memory leak during rehash
      mlxsw: spectrum_acl_tcam: Fix warning during rehash
      mlxsw: spectrum_acl_tcam: Fix incorrect list API usage
      mlxsw: spectrum_acl_tcam: Fix memory leak when canceling rehash work

Ilya Maximets (1):
      net: openvswitch: fix unwanted error log on timeout policy probing

Iskander Amara (2):
      arm64: dts: rockchip: fix alphabetical ordering RK3399 puma
      arm64: dts: rockchip: enable internal pull-up for Q7_THRM# on RK3399 Puma

Ismael Luceno (1):
      ipvs: Fix checksumming on GSO of SCTP packets

Jeongjun Park (1):
      nilfs2: fix OOB in nilfs_set_de_type

Jerry Meng (1):
      USB: serial: option: support Quectel EM060K sub-models

Jiri Benc (1):
      ipv6: fix race condition between ipv6_get_ifaddr and ipv6_del_addr

Johannes Thumshirn (1):
      btrfs: fix information leak in btrfs_ioctl_logical_to_ino()

John Stultz (1):
      selftests: timers: Fix abs() warning in posix_timers test

Kai-Heng Feng (1):
      usb: Disable USB3 LPM at shutdown

Konrad Dybcio (1):
      clk: Print an info line before disabling unused clocks

Kuniyuki Iwashima (3):
      af_unix: Do not use atomic ops for unix_sk(sk)->inflight.
      af_unix: Suppress false-positive lockdep splat for spin_lock() in __unix_gc().
      tcp: Clean up kernel listener's reqsk in inet_twsk_purge()

Lei Chen (1):
      tun: limit printing rate when illegal packet received by tun dev

Matthew Wilcox (Oracle) (1):
      bounds: Use the right number of bits for power-of-two CONFIG_NR_CPUS

Michael Guralnik (1):
      RDMA/mlx5: Fix port number for counter query in multi-port configuration

Michal Luczaj (1):
      af_unix: Fix garbage collector racing against connect()

Mikhail Kobuk (1):
      drm: nv04: Fix out of bounds access

Mikulas Patocka (1):
      dm: limit the number of targets and parameter size area

Minas Harutyunyan (1):
      usb: dwc2: host: Fix dereference issue in DDMA completion flow.

Mukul Joshi (1):
      drm/amdgpu: Fix leak when GPU memory allocation fails

Nam Cao (1):
      HID: i2c-hid: remove I2C_HID_READ_PENDING flag to prevent lock-up

Nathan Chancellor (1):
      Bluetooth: Fix type of len in {l2cap,sco}_sock_getsockopt_old()

Nikita Zhandarovich (1):
      comedi: vmk80xx: fix incomplete endpoint checking

Paul Geurts (1):
      NFC: trf7970a: disable all regulators on removal

Peter Münster (1):
      net: b44: set pause params only when interface is up

Petr Tesarik (1):
      u64_stats: fix u64_stats_init() for lockdep when used repeatedly in one file

Quentin Schulz (1):
      arm64: dts: rockchip: enable internal pull-up on PCIE_WAKE# for RK3399 Puma

Rafał Miłecki (4):
      arm64: dts: mediatek: mt7622: fix IR nodename
      arm64: dts: mediatek: mt7622: fix ethernet controller "compatible"
      arm64: dts: mediatek: mt7622: drop "reset-names" from thermal block
      arm64: dts: mediatek: mt2712: fix validation errors

Rahul Rameshbabu (1):
      ethernet: Add helper for assigning packet type when dest address does not match device address

Rajneesh Bhardwaj (1):
      drm/amdgpu: restrict bo mapping within gpu address limits

Randy Dunlap (1):
      serial: core: fix kernel-doc for uart_port_unlock_irqrestore()

Robin H. Johnson (2):
      tracing: Show size of requested perf buffer
      tracing: Increase PERF_MAX_TRACE_SIZE to handle Sentinel1 and docker together

Samuel Thibault (1):
      speakup: Avoid crash on very long word

Shifeng Li (1):
      net/mlx5e: Fix a race in command alloc flow

Siddh Raman Pant (1):
      Revert "tracing/trigger: Fix to return error if failed to alloc snapshot"

Sindhu Devale (1):
      i40e: Do not use WQ_MEM_RECLAIM flag for workqueue

Stephen Boyd (4):
      clk: Remove prepare_lock hold assertion in __clk_release()
      clk: Mark 'all_lists' as const
      clk: Initialize struct clk_core kref earlier
      clk: Get runtime PM before walking tree during disable_unused

Sudheer Mogilappagari (1):
      iavf: Fix TC config comparison with existing adapter TC config

Sven Eckelmann (1):
      batman-adv: Avoid infinite loop trying to resize local TT

Thomas Gleixner (1):
      serial: core: Provide port lock wrappers

Vanillan Wang (1):
      USB: serial: option: add Rolling RW101-GL and RW135-GL support

Ville Syrjälä (1):
      drm/client: Fully protect modes[] with dev->mode_config.mutex

Vitaly Kuznetsov (1):
      KVM: async_pf: Cleanup kvm_setup_async_pf()

WangYuli (1):
      Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0bda:0x4853

Wolfram Sang (1):
      i2c: smbus: fix NULL function pointer dereference

Yanjun.Zhu (1):
      RDMA/rxe: Fix the problem "mutex_destroy missing"

Yick Xie (1):
      udp: preserve the connected status if only UDP cmsg

Yuanhe Shu (1):
      selftests/ftrace: Limit length in subsystem-enable tests

Zheng Yejian (1):
      kprobes: Fix possible use-after-free issue on kprobe registration

Ziyang Xuan (1):
      netfilter: nf_tables: Fix potential data-race in __nft_expr_type_get()

bolan wang (1):
      USB: serial: option: add Fibocom FM135-GL variants

xinhui pan (1):
      drm/amdgpu: validate the parameters of bo mapping operations more clearly


