Return-Path: <linux-kernel+bounces-166565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F978B9C7C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2569281127
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2629D153502;
	Thu,  2 May 2024 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S+81oU1I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A126B1534F4;
	Thu,  2 May 2024 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714660679; cv=none; b=SnBD1DWCdJyOkQoFCKpidqEffs/oSC+hB9tGsvFomYqYScLHH5BKGHa4OJ0wj0bVSB3/lyDg9m/XOon131I9mfISQ/yUOVsnZDIyZdak+6m+YqtY0Kqhc6iBR97yxa7Dg5MSXGxZByHEknfdMw/FSXFrzS5J+vegvkA1OlhTgU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714660679; c=relaxed/simple;
	bh=7SNpr6A0jH0DIt693vmn8iDedIppLJhC7s3X/5vM+bo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QOWOcEyOx0ltNXK5L3okN02gZpCuaaUxeWvrG4GFbbpyd+T/RCY83gvaUNsq3wxtcQnLMlDOGLCTa+SxGFKpMyzw7oj8my6+5dKU+7J18u8UyUPKWgcyA6wlO5WRnolP2eOhTaAwyN3DtlE+qcmfIaXeYbQv2K01v3Yrby1Qi/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S+81oU1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23799C113CC;
	Thu,  2 May 2024 14:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714660679;
	bh=7SNpr6A0jH0DIt693vmn8iDedIppLJhC7s3X/5vM+bo=;
	h=From:To:Cc:Subject:Date:From;
	b=S+81oU1IPauHLUhbGvwiwZ7Glf7X7sFqFbTjgi+5H+xMuVfxABYIY5RtKmDqnKeJb
	 Zu7U2zCKMHxlRTclMZ1UMQuhxMaG7n6r9BifU0V1no7XrrlE26oqNJMx/0feBe3XKU
	 sKy7Q95Jrjev+wWyRLbHoWVIHBMvEH87hOcHDsdQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.216
Date: Thu,  2 May 2024 16:37:51 +0200
Message-ID: <2024050252-curse-dreamless-0543@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.10.216 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/ABI/testing/sysfs-class-devfreq                   |    3 
 Makefile                                                        |    2 
 arch/Kconfig                                                    |    8 
 arch/arc/boot/dts/hsdk.dts                                      |    1 
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts                     |    8 
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi                       |    3 
 arch/arm64/boot/dts/mediatek/mt7622.dtsi                        |   62 ++--
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts            |    1 
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi                   |   29 +
 arch/riscv/Kconfig                                              |    8 
 arch/riscv/Makefile                                             |   10 
 arch/riscv/include/asm/pgtable.h                                |    4 
 arch/riscv/include/asm/stackprotector.h                         |    3 
 arch/riscv/kernel/asm-offsets.c                                 |    3 
 arch/riscv/kernel/process.c                                     |    5 
 arch/x86/Kconfig                                                |   11 
 arch/x86/include/asm/apic.h                                     |    3 
 arch/x86/kernel/cpu/cpuid-deps.c                                |    6 
 crypto/algapi.c                                                 |    1 
 drivers/accessibility/speakup/main.c                            |    2 
 drivers/android/binder.c                                        |    4 
 drivers/bluetooth/btusb.c                                       |    2 
 drivers/clk/clk.c                                               |  154 +++++++---
 drivers/devfreq/devfreq.c                                       |   59 ++-
 drivers/dma/idma64.c                                            |    4 
 drivers/dma/owl-dma.c                                           |    4 
 drivers/dma/xilinx/xilinx_dpdma.c                               |   13 
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c                |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c                          |   72 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c                          |   26 -
 drivers/gpu/drm/drm_client_modeset.c                            |    3 
 drivers/gpu/drm/nouveau/nouveau_bios.c                          |   13 
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c             |    7 
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c              |    7 
 drivers/gpu/drm/panel/panel-visionox-rm69299.c                  |    2 
 drivers/hid/i2c-hid/i2c-hid-core.c                              |    8 
 drivers/i2c/i2c-core-base.c                                     |   12 
 drivers/infiniband/core/cm.c                                    |   11 
 drivers/infiniband/hw/mlx5/mad.c                                |    3 
 drivers/infiniband/sw/rxe/rxe.c                                 |    2 
 drivers/iommu/intel/svm.c                                       |    2 
 drivers/irqchip/irq-gic-v3-its.c                                |    9 
 drivers/mailbox/imx-mailbox.c                                   |    8 
 drivers/media/cec/core/cec-adap.c                               |   14 
 drivers/misc/mei/pci-me.c                                       |    2 
 drivers/mtd/nand/raw/diskonchip.c                               |    4 
 drivers/net/ethernet/amazon/ena/ena_com.c                       |    2 
 drivers/net/ethernet/amazon/ena/ena_netdev.c                    |   35 +-
 drivers/net/ethernet/broadcom/b44.c                             |   14 
 drivers/net/ethernet/intel/i40e/i40e_main.c                     |    6 
 drivers/net/ethernet/intel/iavf/iavf_main.c                     |   30 +
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c             |   20 -
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c                   |   12 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c               |    3 
 drivers/net/ethernet/mellanox/mlxsw/core.c                      |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c         |   54 ++-
 drivers/net/ethernet/ti/am65-cpts.c                             |    5 
 drivers/net/geneve.c                                            |    4 
 drivers/net/gtp.c                                               |    3 
 drivers/net/tun.c                                               |   18 -
 drivers/net/usb/ax88179_178a.c                                  |   11 
 drivers/net/vxlan/vxlan_core.c                                  |    4 
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c          |    2 
 drivers/nfc/trf7970a.c                                          |   42 +-
 drivers/staging/comedi/drivers/vmk80xx.c                        |   35 --
 drivers/thunderbolt/switch.c                                    |   48 ++-
 drivers/thunderbolt/tb.c                                        |    4 
 drivers/thunderbolt/tb.h                                        |    3 
 drivers/thunderbolt/usb4.c                                      |   13 
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
 include/linux/irqflags.h                                        |    2 
 include/linux/serial_core.h                                     |   79 +++++
 include/linux/trace_events.h                                    |    2 
 include/linux/u64_stats_sync.h                                  |    6 
 include/net/addrconf.h                                          |    4 
 include/net/af_unix.h                                           |    5 
 include/net/bluetooth/bluetooth.h                               |    9 
 include/net/ip_tunnels.h                                        |   33 ++
 init/main.c                                                     |    2 
 kernel/bounds.c                                                 |    2 
 kernel/cpu.c                                                    |    3 
 kernel/kprobes.c                                                |   18 -
 kernel/trace/trace_event_perf.c                                 |    3 
 kernel/trace/trace_events_trigger.c                             |    6 
 lib/stackdepot.c                                                |    4 
 net/batman-adv/translation-table.c                              |    2 
 net/bluetooth/hci_request.c                                     |    4 
 net/bluetooth/l2cap_sock.c                                      |    7 
 net/bluetooth/sco.c                                             |   26 -
 net/ethernet/eth.c                                              |   12 
 net/ipv4/inet_timewait_sock.c                                   |   32 +-
 net/ipv4/netfilter/arp_tables.c                                 |    4 
 net/ipv4/netfilter/ip_tables.c                                  |    4 
 net/ipv4/route.c                                                |    7 
 net/ipv4/udp.c                                                  |    5 
 net/ipv6/addrconf.c                                             |    7 
 net/ipv6/ip6_fib.c                                              |    7 
 net/ipv6/netfilter/ip6_tables.c                                 |    4 
 net/ipv6/udp.c                                                  |    5 
 net/netfilter/ipvs/ip_vs_proto_sctp.c                           |    6 
 net/netfilter/nf_tables_api.c                                   |    8 
 net/netfilter/nft_chain_filter.c                                |    4 
 net/netfilter/nft_set_pipapo.c                                  |   14 
 net/openvswitch/conntrack.c                                     |    9 
 net/unix/af_unix.c                                              |    4 
 net/unix/garbage.c                                              |   35 +-
 net/unix/scm.c                                                  |    8 
 net/xdp/xsk.c                                                   |    2 
 tools/testing/selftests/ftrace/test.d/event/subsystem-enable.tc |    6 
 tools/testing/selftests/timers/posix_timers.c                   |    2 
 122 files changed, 1053 insertions(+), 472 deletions(-)

Adam Dunlap (1):
      x86/apic: Force native_apic_mem_read() to use the MOV instruction

Alan Stern (1):
      fs: sysfs: Fix reference leak in sysfs_break_active_protection()

Alex Deucher (1):
      drm/amdgpu/sdma5.2: use legacy HDP flush for SDMA2/3

Alexander Usyskin (1):
      mei: me: disable RPL-S on SPS and IGN firmwares

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
      irqflags: Explicitly ignore lockdep_hrtimer_exit() argument
      mtd: diskonchip: work around ubsan link failure
      dmaengine: owl: fix register access functions

Avraham Stern (1):
      wifi: iwlwifi: mvm: remove old PASN station when adding a new one

Baoquan He (1):
      riscv: fix VMALLOC_START definition

Boris Burkov (2):
      btrfs: qgroup: correctly model root qgroup rsv in convert
      btrfs: record delayed inode root in transaction

Carlos Llamas (1):
      binder: check offset alignment in binder_get_object()

Christian Marangi (1):
      PM / devfreq: Fix buffer overflow in trans_stat_show

Chuanhong Guo (1):
      USB: serial: option: add support for Fibocom FM650/FG650

Claudiu Beznea (1):
      clk: remove extra empty line

Coia Prant (1):
      USB: serial: option: add Lonsung U8300/U9300 product

Cosmin Ratiu (1):
      net/mlx5: Properly link new fs rules into the tree

Daisuke Mizobuchi (1):
      mailbox: imx: fix suspend failue

Daniele Palmas (1):
      USB: serial: option: add Telit FN920C04 rmnet compositions

Dave Airlie (1):
      nouveau: fix instmem race condition around ptr stores

David Arinzon (3):
      net: ena: Fix potential sign extension issue
      net: ena: Wrong missing IO completions check order
      net: ena: Fix incorrect descriptor free behavior

David Bauer (1):
      vxlan: drop packets from invalid src-address

Dmitry Antipov (1):
      Bluetooth: Fix memory leak in hci_req_sync_complete()

Dmitry Baryshkov (1):
      drm/panel: visionox-rm69299: don't unregister DSI device

Dragan Simic (1):
      arm64: dts: rockchip: Remove unsupported node from the Pinebook Pro dts

Emil Kronborg (1):
      serial: mxs-auart: add spinlock around changing cts state

Eric Biggers (1):
      x86/cpufeatures: Fix dependencies for GFNI, VAES, and VPCLMULQDQ

Eric Dumazet (6):
      xsk: validate user input for XDP_{UMEM|COMPLETION}_FILL_RING
      geneve: fix header validation in geneve[6]_xmit_skb
      netfilter: complete validation of user input
      ipv4: check for NULL idev in ip_route_use_hint()
      net: usb: ax88179_178a: stop lying about skb->truesize
      tcp: Fix NEW_SYN_RECV handling in inet_twsk_purge()

Erwan Velu (1):
      i40e: Report MFS in decimal base instead of hex

Felix Fietkau (2):
      arm64: dts: mediatek: mt7622: add support for coherent DMA
      arm64: dts: mediatek: mt7622: introduce nodes for Wireless Ethernet Dispatch

Finn Thain (1):
      serial/pmac_zilog: Remove flawed mitigation for rx irq flood

Florian Westphal (1):
      netfilter: nft_set_pipapo: do not free live element

Gavin Shan (1):
      vhost: Add smp_rmb() in vhost_vq_avail_empty()

Geetha sowjanya (1):
      octeontx2-af: Fix NIX SQ mode and BP config

Gil Fine (2):
      thunderbolt: Avoid notify PM core about runtime PM resume
      thunderbolt: Fix wake configurations after device unplug

Greg Kroah-Hartman (3):
      Revert "usb: cdc-wdm: close race between read and workqueue"
      Revert "crypto: api - Disallow identical driver names"
      Linux 5.10.216

Guanrui Huang (1):
      irqchip/gic-v3-its: Prevent double free on error

Guenter Roeck (1):
      riscv: Disable STACKPROTECTOR_PER_TASK if GCC_PLUGIN_RANDSTRUCT is enabled

Guo Ren (1):
      riscv: Enable per-task stack canaries

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

Jacob Pan (1):
      iommu/vt-d: Allocate local memory for page request queue

Jason Reeder (1):
      net: ethernet: ti: am65-cpts: Fix PTPv1 message type on TX packets

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

Luiz Augusto von Dentz (1):
      Bluetooth: SCO: Fix not validating setsockopt user input

Mark Zhang (1):
      RDMA/cm: Print the old state when cm_destroy_id gets timeout

Matthew Wilcox (Oracle) (1):
      bounds: Use the right number of bits for power-of-two CONFIG_NR_CPUS

Michael Guralnik (1):
      RDMA/mlx5: Fix port number for counter query in multi-port configuration

Michal Luczaj (1):
      af_unix: Fix garbage collector racing against connect()

Mikhail Kobuk (1):
      drm: nv04: Fix out of bounds access

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

Nini Song (1):
      media: cec: core: remove length check of Timer Status

Pablo Neira Ayuso (1):
      netfilter: nf_tables: honor table dormant flag from netdev release event path

Paul Geurts (1):
      NFC: trf7970a: disable all regulators on removal

Peter Münster (1):
      net: b44: set pause params only when interface is up

Petr Tesarik (1):
      u64_stats: fix u64_stats_init() for lockdep when used repeatedly in one file

Quentin Schulz (1):
      arm64: dts: rockchip: enable internal pull-up on PCIE_WAKE# for RK3399 Puma

Rafał Miłecki (5):
      arm64: dts: mediatek: mt7622: fix clock controllers
      arm64: dts: mediatek: mt7622: fix IR nodename
      arm64: dts: mediatek: mt7622: fix ethernet controller "compatible"
      arm64: dts: mediatek: mt7622: drop "reset-names" from thermal block
      arm64: dts: mediatek: mt2712: fix validation errors

Rahul Rameshbabu (1):
      ethernet: Add helper for assigning packet type when dest address does not match device address

Randy Dunlap (1):
      serial: core: fix kernel-doc for uart_port_unlock_irqrestore()

Robin H. Johnson (2):
      tracing: Show size of requested perf buffer
      tracing: Increase PERF_MAX_TRACE_SIZE to handle Sentinel1 and docker together

Samuel Holland (1):
      riscv: Fix TASK_SIZE on 64-bit NOMMU

Samuel Thibault (1):
      speakup: Avoid crash on very long word

Sean Anderson (1):
      dma: xilinx_dpdma: Fix locking

Sean Christopherson (2):
      x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n
      cpu: Re-enable CPU mitigations by default for !X86 architectures

Shifeng Li (1):
      net/mlx5e: Fix a race in command alloc flow

Siddh Raman Pant (1):
      Revert "tracing/trigger: Fix to return error if failed to alloc snapshot"

Sindhu Devale (1):
      i40e: Do not use WQ_MEM_RECLAIM flag for workqueue

Stefan O'Rear (1):
      riscv: process: Fix kernel gp leakage

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

Yuntao Wang (1):
      init/main.c: Fix potential static_command_line memory overflow

Zheng Yejian (1):
      kprobes: Fix possible use-after-free issue on kprobe registration

Ziyang Xuan (1):
      netfilter: nf_tables: Fix potential data-race in __nft_expr_type_get()

bolan wang (1):
      USB: serial: option: add Fibocom FM135-GL variants

xinhui pan (1):
      drm/amdgpu: validate the parameters of bo mapping operations more clearly


