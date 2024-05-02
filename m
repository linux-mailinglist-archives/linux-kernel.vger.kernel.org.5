Return-Path: <linux-kernel+bounces-166567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D328B9C81
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7537B20AB8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E392153563;
	Thu,  2 May 2024 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DSeJNV4m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FC9153589;
	Thu,  2 May 2024 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714660686; cv=none; b=Y5uD7brbpzwKZak4HBeixt8NmFPTu0vP5wR17M0avVOyHUqsdcNyondnn4cGvnOfqDw1Q7avq2fkdtXdH4ZsCtNooB3gzcAwRP8mi7t2kFuQbs3KA5K72whM9Vt9wvFCrnTwMSy7yz2+TZe+nS2ubQTb60xMFB5iTXhHbOCDgEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714660686; c=relaxed/simple;
	bh=sDHAUUG/pjvzccCSdAlh/UBoCvM67o9zE0w1gTwx4gI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tkz2dj5884xUe6yCgB/toN3FL0zt50abFT1KWVUXwkkvArPouc/xyjUMvNEaFF1vc41lTDb/JYeKK5JRS+Zl5VfFS22sNnckWNsFcHQsHNqa9ZY18logEVa/XMiLXZMQTs8dp/VnRe7wCBNJgjsf2561mtzJ7hGl2bLtaAn0Op4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DSeJNV4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8E8C113CC;
	Thu,  2 May 2024 14:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714660686;
	bh=sDHAUUG/pjvzccCSdAlh/UBoCvM67o9zE0w1gTwx4gI=;
	h=From:To:Cc:Subject:Date:From;
	b=DSeJNV4mG1HSO/o13PdS9xCzV9N/FKLaP4N/PE1i3WhTMYEqEmA4xKEF/eii+24Ra
	 cfjl2pQhCCbYT2O+R4893IK2N96pDb0EH1iYMze3tQZLu9WyQWNl6KC+36UOEfZXiK
	 SHg7/mnrsS8xeXv68XwYXn37TB55K8m+7keUQKzs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.158
Date: Thu,  2 May 2024 16:37:58 +0200
Message-ID: <2024050259-slapping-joyride-535e@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.158 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                                |    2 
 arch/Kconfig                                            |    8 +
 arch/arc/boot/dts/hsdk.dts                              |    1 
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts             |    8 -
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi               |    3 
 arch/arm64/boot/dts/mediatek/mt7622.dtsi                |   62 ++++++++----
 arch/arm64/boot/dts/mediatek/mt8183.dtsi                |    1 
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts    |    1 
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi           |   31 ++++--
 arch/riscv/include/asm/pgtable.h                        |    4 
 arch/x86/Kconfig                                        |   11 +-
 arch/x86/kernel/process_64.c                            |    2 
 crypto/algapi.c                                         |    1 
 drivers/bluetooth/btusb.c                               |    2 
 drivers/bluetooth/hci_qca.c                             |    3 
 drivers/dma/idma64.c                                    |    4 
 drivers/dma/idxd/perfmon.c                              |    9 -
 drivers/dma/owl-dma.c                                   |    4 
 drivers/dma/xilinx/xilinx_dpdma.c                       |   13 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c        |    1 
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c                  |   26 +++--
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                     |   11 +-
 drivers/hid/hid-logitech-dj.c                           |    4 
 drivers/hid/i2c-hid/i2c-hid-core.c                      |    8 -
 drivers/hid/intel-ish-hid/ipc/ipc.c                     |    2 
 drivers/i2c/i2c-core-base.c                             |   12 +-
 drivers/irqchip/irq-gic-v3-its.c                        |    9 -
 drivers/mmc/host/sdhci-msm.c                            |   16 +++
 drivers/mtd/nand/raw/diskonchip.c                       |    4 
 drivers/net/ethernet/broadcom/b44.c                     |   14 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c             |    6 -
 drivers/net/ethernet/intel/iavf/iavf_main.c             |   30 +++++-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c           |   12 +-
 drivers/net/ethernet/mellanox/mlxsw/core.c              |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c |   54 +++++++++-
 drivers/net/ethernet/ti/am65-cpts.c                     |    5 +
 drivers/net/gtp.c                                       |    3 
 drivers/net/usb/ax88179_178a.c                          |   11 --
 drivers/net/vxlan/vxlan_core.c                          |    4 
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c  |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c           |    3 
 drivers/nfc/trf7970a.c                                  |   42 ++++----
 drivers/tty/serial/mxs-auart.c                          |    8 +
 drivers/video/fbdev/core/fb_defio.c                     |    2 
 fs/btrfs/backref.c                                      |   12 --
 fs/cifs/cifsfs.c                                        |    1 
 fs/cifs/fs_context.c                                    |   12 ++
 fs/cifs/fs_context.h                                    |    2 
 include/drm/drm_print.h                                 |    3 
 include/linux/etherdevice.h                             |   25 +++++
 include/linux/serial_core.h                             |   79 ++++++++++++++++
 include/linux/trace_events.h                            |    2 
 include/net/af_unix.h                                   |    3 
 kernel/bounds.c                                         |    2 
 kernel/cpu.c                                            |    4 
 kernel/trace/trace_event_perf.c                         |    3 
 lib/stackdepot.c                                        |    4 
 net/bluetooth/l2cap_sock.c                              |    7 -
 net/bluetooth/sco.c                                     |    7 -
 net/bridge/br_netlink.c                                 |    2 
 net/ethernet/eth.c                                      |   12 --
 net/ipv4/icmp.c                                         |   12 ++
 net/ipv4/inet_timewait_sock.c                           |   32 ++++--
 net/ipv4/route.c                                        |    3 
 net/ipv4/udp.c                                          |    5 -
 net/ipv6/udp.c                                          |    5 -
 net/netfilter/ipvs/ip_vs_proto_sctp.c                   |    6 -
 net/netfilter/nft_chain_filter.c                        |    4 
 net/openvswitch/conntrack.c                             |    4 
 net/unix/garbage.c                                      |    2 
 70 files changed, 502 insertions(+), 212 deletions(-)

Alex Deucher (1):
      drm/amdgpu/sdma5.2: use legacy HDP flush for SDMA2/3

Alexey Brodkin (1):
      ARC: [plat-hsdk]: Remove misplaced interrupt-cells property

Andrey Ryabinin (1):
      stackdepot: respect __GFP_NOLOCKDEP allocation flag

Andy Shevchenko (1):
      idma64: Don't try to serve interrupts when device is powered off

Arnd Bergmann (2):
      mtd: diskonchip: work around ubsan link failure
      dmaengine: owl: fix register access functions

Avraham Stern (1):
      wifi: iwlwifi: mvm: remove old PASN station when adding a new one

Baoquan He (1):
      riscv: fix VMALLOC_START definition

David Bauer (1):
      vxlan: drop packets from invalid src-address

David Kaplan (1):
      x86/cpu: Fix check for RDPKRU in __show_regs()

Dragan Simic (1):
      arm64: dts: rockchip: Remove unsupported node from the Pinebook Pro dts

Emil Kronborg (1):
      serial: mxs-auart: add spinlock around changing cts state

Eric Dumazet (4):
      icmp: prevent possible NULL dereferences from icmp_build_probe()
      ipv4: check for NULL idev in ip_route_use_hint()
      net: usb: ax88179_178a: stop lying about skb->truesize
      tcp: Fix NEW_SYN_RECV handling in inet_twsk_purge()

Erwan Velu (1):
      i40e: Report MFS in decimal base instead of hex

Felix Fietkau (2):
      arm64: dts: mediatek: mt7622: add support for coherent DMA
      arm64: dts: mediatek: mt7622: introduce nodes for Wireless Ethernet Dispatch

Fenghua Yu (1):
      dmaengine: idxd: Fix oops during rmmod on single-CPU platforms

Greg Kroah-Hartman (2):
      Revert "crypto: api - Disallow identical driver names"
      Linux 5.15.158

Guanrui Huang (1):
      irqchip/gic-v3-its: Prevent double free on error

Hangbin Liu (1):
      bridge/br_netlink.c: no need to return void function

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

Ikjoon Jang (1):
      arm64: dts: mediatek: mt8183: Add power-domains properity to mfgcfg

Iskander Amara (2):
      arm64: dts: rockchip: fix alphabetical ordering RK3399 puma
      arm64: dts: rockchip: enable internal pull-up for Q7_THRM# on RK3399 Puma

Ismael Luceno (1):
      ipvs: Fix checksumming on GSO of SCTP packets

Jason Reeder (1):
      net: ethernet: ti: am65-cpts: Fix PTPv1 message type on TX packets

Jim Cromie (1):
      drm-print: add drm_dbg_driver to improve namespace symmetry

Johan Hovold (1):
      Bluetooth: qca: fix NULL-deref on non-serdev suspend

Johannes Thumshirn (1):
      btrfs: fix information leak in btrfs_ioctl_logical_to_ino()

Kuniyuki Iwashima (2):
      af_unix: Suppress false-positive lockdep splat for spin_lock() in __unix_gc().
      tcp: Clean up kernel listener's reqsk in inet_twsk_purge()

Mantas Pucka (1):
      mmc: sdhci-msm: pervent access to suspended controller

Matthew Wilcox (Oracle) (1):
      bounds: Use the right number of bits for power-of-two CONFIG_NR_CPUS

Miri Korenblit (1):
      wifi: iwlwifi: mvm: return uid from iwl_mvm_build_scan_cmd

Mukul Joshi (1):
      drm/amdgpu: Fix leak when GPU memory allocation fails

Nam Cao (2):
      fbdev: fix incorrect address computation in deferred IO
      HID: i2c-hid: remove I2C_HID_READ_PENDING flag to prevent lock-up

Nathan Chancellor (1):
      Bluetooth: Fix type of len in {l2cap,sco}_sock_getsockopt_old()

Pablo Neira Ayuso (1):
      netfilter: nf_tables: honor table dormant flag from netdev release event path

Paul Geurts (1):
      NFC: trf7970a: disable all regulators on removal

Paulo Alcantara (1):
      smb: client: fix rename(2) regression against samba

Peter Münster (1):
      net: b44: set pause params only when interface is up

Quentin Schulz (2):
      arm64: dts: rockchip: enable internal pull-up on Q7_USB_ID for RK3399 Puma
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

Sean Anderson (1):
      dma: xilinx_dpdma: Fix locking

Sean Christopherson (1):
      cpu: Re-enable CPU mitigations by default for !X86 architectures

Shifeng Li (1):
      net/mlx5e: Fix a race in command alloc flow

Sindhu Devale (1):
      i40e: Do not use WQ_MEM_RECLAIM flag for workqueue

Sudheer Mogilappagari (1):
      iavf: Fix TC config comparison with existing adapter TC config

Takayuki Nagata (1):
      cifs: reinstate original behavior again for forceuid/forcegid

Thomas Gleixner (1):
      serial: core: Provide port lock wrappers

WangYuli (1):
      Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0bda:0x4853

Wolfram Sang (1):
      i2c: smbus: fix NULL function pointer dereference

Yaraslau Furman (1):
      HID: logitech-dj: allow mice to use all types of reports

Yick Xie (1):
      udp: preserve the connected status if only UDP cmsg

Zack Rusin (1):
      drm/vmwgfx: Fix crtc's atomic check conditional

Zhang Lixu (1):
      HID: intel-ish-hid: ipc: Fix dev_err usage with uninitialized dev->devc


