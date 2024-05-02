Return-Path: <linux-kernel+bounces-166561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 527F38B9C6F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D081F22425
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E126515350D;
	Thu,  2 May 2024 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V1zuKlnw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4815FEE6;
	Thu,  2 May 2024 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714660585; cv=none; b=bwkQB5TDL7A6wFX5TDxcVG8AyPmgatsdyrqMIWQF2FH43kjf6Cnyve9WTzMtfm61kEZlAQS442M/gVq644/s2jcG2+sec2ecBC1V6v8E0USfMUW0bEtBDJEtaFkDkIlFzeFNuiBrU04WjL8FmNVcCNAovtZVPjtHA7VQ/exQekE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714660585; c=relaxed/simple;
	bh=T4cZNWAchhK1hJ1XVpBm4CRRQU63Gq2/E39N8bjuMAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a3ILGnvQfucDq6X5BVfRUhKmvz+u+9HSal0Uf+7SzKQovfUrSk39WrIC+tnIpayxJsWiqkYQBkADcfdM0LpBWNrioY+4sT5wqqx3ClTQBtRaK169A3slEpEL5vMDv/duspXuN5o4+RzvQL3UTekRP5zWrqODWd7IlW4cT4XYOUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V1zuKlnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEF3C113CC;
	Thu,  2 May 2024 14:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714660585;
	bh=T4cZNWAchhK1hJ1XVpBm4CRRQU63Gq2/E39N8bjuMAQ=;
	h=From:To:Cc:Subject:Date:From;
	b=V1zuKlnw2IX2u5mNoj5SVGZT7RWvr70KhtWRzAw06jMsTDtTXaj8+1nDZ/NoQmoro
	 /y6iDLkq3YYMyLb+nWOb+Toat3U0gNec5iY3ATaFLmb5kDUeiC35YDVpxlaStwaFMQ
	 Sa8DjHppLIBmlFASHW+zXSX6PV9n3Sfw8uv1vL68=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 4.19.313
Date: Thu,  2 May 2024 16:36:20 +0200
Message-ID: <2024050221-half-juniper-51e1@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 4.19.313 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                        |    2 
 arch/alpha/kernel/osf_sys.c                                     |    2 
 arch/arc/boot/dts/hsdk.dts                                      |    1 
 arch/arm64/boot/dts/mediatek/mt7622.dtsi                        |    7 
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi                   |   29 ++-
 arch/x86/include/asm/apic.h                                     |    3 
 crypto/algapi.c                                                 |    1 
 drivers/block/loop.c                                            |   19 +-
 drivers/dma/idma64.c                                            |    4 
 drivers/dma/owl-dma.c                                           |    4 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                          |   70 +++++---
 drivers/gpu/drm/nouveau/nouveau_bios.c                          |   13 -
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c             |    7 
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c              |    7 
 drivers/hid/i2c-hid/i2c-hid-core.c                              |    8 
 drivers/i2c/i2c-core-base.c                                     |    7 
 drivers/infiniband/hw/mlx5/mad.c                                |    3 
 drivers/irqchip/irq-gic-v3-its.c                                |    9 -
 drivers/mtd/nand/raw/diskonchip.c                               |    4 
 drivers/net/ethernet/broadcom/b44.c                             |   14 -
 drivers/net/ethernet/intel/i40e/i40e_main.c                     |    2 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c               |    3 
 drivers/net/ethernet/mellanox/mlxsw/core.c                      |    2 
 drivers/net/geneve.c                                            |    4 
 drivers/net/gtp.c                                               |    3 
 drivers/net/tun.c                                               |   18 +-
 drivers/net/usb/ax88179_178a.c                                  |   11 -
 drivers/net/vxlan.c                                             |    4 
 drivers/nfc/trf7970a.c                                          |   42 ++--
 drivers/staging/comedi/drivers/vmk80xx.c                        |   35 +---
 drivers/staging/speakup/main.c                                  |    2 
 drivers/tty/serial/mxs-auart.c                                  |    8 
 drivers/tty/serial/pmac_zilog.c                                 |   14 -
 drivers/usb/class/cdc-wdm.c                                     |    6 
 drivers/usb/dwc2/hcd_ddma.c                                     |    4 
 drivers/usb/serial/option.c                                     |   40 ++++
 drivers/vhost/vhost.c                                           |   12 +
 fs/btrfs/backref.c                                              |   12 -
 fs/btrfs/delayed-inode.c                                        |    3 
 fs/nilfs2/dir.c                                                 |    2 
 fs/sysfs/file.c                                                 |    2 
 include/linux/serial_core.h                                     |   79 +++++++++
 include/linux/trace_events.h                                    |    2 
 include/net/addrconf.h                                          |    4 
 include/net/ip_tunnels.h                                        |   33 +++
 include/uapi/linux/resource.h                                   |    4 
 kernel/kprobes.c                                                |   18 +-
 kernel/sys.c                                                    |    4 
 kernel/trace/trace_event_perf.c                                 |    3 
 kernel/trace/trace_events.c                                     |    4 
 kernel/trace/trace_events_hist.c                                |   86 +---------
 kernel/trace/trace_events_trigger.c                             |    6 
 lib/stackdepot.c                                                |    4 
 net/batman-adv/translation-table.c                              |    2 
 net/bluetooth/hci_request.c                                     |    4 
 net/bluetooth/l2cap_sock.c                                      |    7 
 net/bluetooth/sco.c                                             |    7 
 net/ipv4/inet_timewait_sock.c                                   |   32 ++-
 net/ipv4/route.c                                                |    4 
 net/ipv4/udp.c                                                  |    5 
 net/ipv6/addrconf.c                                             |    7 
 net/ipv6/ip6_fib.c                                              |    7 
 net/ipv6/udp.c                                                  |    5 
 net/netfilter/ipvs/ip_vs_proto_sctp.c                           |    6 
 net/netfilter/nf_tables_api.c                                   |   23 +-
 net/openvswitch/conntrack.c                                     |    3 
 net/openvswitch/datapath.c                                      |    4 
 tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc |    6 
 tools/testing/selftests/timers/posix_timers.c                   |    2 
 69 files changed, 496 insertions(+), 318 deletions(-)

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

Arnd Bergmann (6):
      nouveau: fix function cast warning
      ipv6: fib: hide unused 'pn' variable
      ipv4/route: avoid unused-but-set-variable warning
      tracing: hide unused ftrace_event_id_fops
      mtd: diskonchip: work around ubsan link failure
      dmaengine: owl: fix register access functions

Ben Hutchings (2):
      Revert "loop: Remove sector_t truncation checks"
      Revert "y2038: rusage: use __kernel_old_timeval"

Boris Burkov (1):
      btrfs: record delayed inode root in transaction

Chia-I Wu (1):
      amdgpu: validate offset_in_bo of drm_amdgpu_gem_va

Chuanhong Guo (1):
      USB: serial: option: add support for Fibocom FM650/FG650

Coia Prant (1):
      USB: serial: option: add Lonsung U8300/U9300 product

Cosmin Ratiu (1):
      net/mlx5: Properly link new fs rules into the tree

Daniele Palmas (1):
      USB: serial: option: add Telit FN920C04 rmnet compositions

Dave Airlie (1):
      nouveau: fix instmem race condition around ptr stores

David Bauer (1):
      vxlan: drop packets from invalid src-address

Dmitry Antipov (1):
      Bluetooth: Fix memory leak in hci_req_sync_complete()

Emil Kronborg (1):
      serial: mxs-auart: add spinlock around changing cts state

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
      Linux 4.19.313

Guanrui Huang (1):
      irqchip/gic-v3-its: Prevent double free on error

Hyunwoo Kim (2):
      net: gtp: Fix Use-After-Free in gtp_dellink
      net: openvswitch: Fix Use-After-Free in ovs_ct_exit

Ido Schimmel (1):
      mlxsw: core: Unregister EMAD trap using FORWARD action

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

Kuniyuki Iwashima (1):
      tcp: Clean up kernel listener's reqsk in inet_twsk_purge()

Lei Chen (1):
      tun: limit printing rate when illegal packet received by tun dev

Michael Guralnik (1):
      RDMA/mlx5: Fix port number for counter query in multi-port configuration

Mikhail Kobuk (1):
      drm: nv04: Fix out of bounds access

Minas Harutyunyan (1):
      usb: dwc2: host: Fix dereference issue in DDMA completion flow.

Nam Cao (1):
      HID: i2c-hid: remove I2C_HID_READ_PENDING flag to prevent lock-up

Nathan Chancellor (1):
      Bluetooth: Fix type of len in {l2cap,sco}_sock_getsockopt_old()

Nikita Zhandarovich (1):
      comedi: vmk80xx: fix incomplete endpoint checking

Pablo Neira Ayuso (1):
      netfilter: nf_tables: __nft_expr_type_get() selects specific family type

Paul Geurts (1):
      NFC: trf7970a: disable all regulators on removal

Peter Münster (1):
      net: b44: set pause params only when interface is up

Quentin Schulz (1):
      arm64: dts: rockchip: enable internal pull-up on PCIE_WAKE# for RK3399 Puma

Rafał Miłecki (3):
      arm64: dts: mediatek: mt7622: fix IR nodename
      arm64: dts: mediatek: mt7622: fix ethernet controller "compatible"
      arm64: dts: mediatek: mt7622: drop "reset-names" from thermal block

Rajneesh Bhardwaj (1):
      drm/amdgpu: restrict bo mapping within gpu address limits

Randy Dunlap (1):
      serial: core: fix kernel-doc for uart_port_unlock_irqrestore()

Robin H. Johnson (2):
      tracing: Show size of requested perf buffer
      tracing: Increase PERF_MAX_TRACE_SIZE to handle Sentinel1 and docker together

Samuel Thibault (1):
      speakup: Avoid crash on very long word

Siddh Raman Pant (1):
      Revert "tracing/trigger: Fix to return error if failed to alloc snapshot"

Sindhu Devale (1):
      i40e: Do not use WQ_MEM_RECLAIM flag for workqueue

Sven Eckelmann (1):
      batman-adv: Avoid infinite loop trying to resize local TT

Thomas Gleixner (1):
      serial: core: Provide port lock wrappers

Tom Zanussi (2):
      tracing: Remove hist trigger synth_var_refs
      tracing: Use var_refs[] for hist trigger reference checking

Tonghao Zhang (1):
      net: openvswitch: ovs_ct_exit to be done under ovs_lock

Vanillan Wang (1):
      USB: serial: option: add Rolling RW101-GL and RW135-GL support

Wolfram Sang (1):
      i2c: smbus: fix NULL function pointer dereference

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


