Return-Path: <linux-kernel+bounces-166569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2B58B9C86
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47252816D5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065CA153830;
	Thu,  2 May 2024 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QP/BQ6R8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A39615356B;
	Thu,  2 May 2024 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714660694; cv=none; b=f3zV6QAUJPryfarfY4G0mBCNjQ+OPR4U254QMYR0H22LVkhBzmeZJn5RgiqX68vCVoeuUBHe15v65kD3RH8Rp2VeNntmqOL6MLJZG0TDN+L/KTrNcEkgFSCK02a88zf4/XlZnrRwbajvqN2EBV4q/SnW9oNpK/FUA5jj94bySRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714660694; c=relaxed/simple;
	bh=ALhiDHUgANbnatQX62lgLwjfO+nnVc7zHZ5o+Z0RHQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y2Inm+qbOa0heE73ziGzE/F0vh5ldZ+C6Ek4hJEj4zuZ1Gi3S6FA3xBurqXDW+Aj9PsD8WRgzCndTdUMwGucqI8Gyf9ae0cnBeJam8GqsuXIG5iCisqtHeOe34NH+mgF2Oks6Lp7ULiag9k4goIBXxEAbGbV13Qis1HSAk314ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QP/BQ6R8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A061CC4AF19;
	Thu,  2 May 2024 14:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714660694;
	bh=ALhiDHUgANbnatQX62lgLwjfO+nnVc7zHZ5o+Z0RHQ8=;
	h=From:To:Cc:Subject:Date:From;
	b=QP/BQ6R8CFypAssIsCq9AcPScvJqfMxE5rKs10JQtY1JGuvZNpNtCXwxiqLuiTsaJ
	 mAZyvrDOjfht8PXU049FmfOjqR/saQSaGG6gyXvA3v3eOoKsLV98GAaFuxOCsCqh1h
	 VycOpMOmsgNgfKNBZw1egMBLRwh2u+fF01+SUd6U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.90
Date: Thu,  2 May 2024 16:38:06 +0200
Message-ID: <2024050207-fanning-blot-4ba4@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.90 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/sysctl/net.rst                  |    5 
 Makefile                                                  |    2 
 arch/Kconfig                                              |    8 +
 arch/arc/boot/dts/hsdk.dts                                |    1 
 arch/arm/boot/dts/at91-sama7g5ek.dts                      |    8 -
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts               |    8 -
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi                 |    3 
 arch/arm64/boot/dts/mediatek/mt7622.dtsi                  |   34 +---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi                  |    1 
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi          |    6 
 arch/arm64/boot/dts/mediatek/mt8192.dtsi                  |    1 
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi           |    4 
 arch/arm64/boot/dts/mediatek/mt8195.dtsi                  |    4 
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts      |    1 
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi             |   31 ++-
 arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts        |    6 
 arch/loongarch/include/asm/perf_event.h                   |    8 +
 arch/loongarch/mm/fault.c                                 |    4 
 arch/riscv/include/asm/pgtable.h                          |    4 
 arch/x86/Kconfig                                          |   11 -
 arch/x86/include/asm/coco.h                               |    5 
 arch/x86/include/asm/pgtable_types.h                      |    3 
 arch/x86/kernel/process_64.c                              |    2 
 crypto/algapi.c                                           |    1 
 drivers/acpi/cppc_acpi.c                                  |   72 +++++++--
 drivers/bluetooth/btusb.c                                 |    2 
 drivers/bluetooth/hci_qca.c                               |   21 ++
 drivers/dma/idma64.c                                      |    4 
 drivers/dma/idxd/perfmon.c                                |    9 -
 drivers/dma/owl-dma.c                                     |    4 
 drivers/dma/tegra186-gpc-dma.c                            |    3 
 drivers/dma/xilinx/xilinx_dpdma.c                         |   13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c          |    1 
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c                    |   26 +--
 drivers/hid/hid-logitech-dj.c                             |    4 
 drivers/hid/i2c-hid/i2c-hid-core.c                        |    9 -
 drivers/hid/intel-ish-hid/ipc/ipc.c                       |    2 
 drivers/i2c/i2c-core-base.c                               |   12 -
 drivers/irqchip/irq-gic-v3-its.c                          |    9 -
 drivers/mmc/host/sdhci-msm.c                              |   16 +-
 drivers/mtd/nand/raw/diskonchip.c                         |    4 
 drivers/net/ethernet/broadcom/b44.c                       |   14 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                 |   80 +++++-----
 drivers/net/ethernet/intel/i40e/i40e_main.c               |    6 
 drivers/net/ethernet/intel/iavf/iavf_main.c               |   30 +++
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c |    1 
 drivers/net/ethernet/mellanox/mlxsw/core.c                |    2 
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c   |   54 +++++-
 drivers/net/ethernet/ti/am65-cpts.c                       |    5 
 drivers/net/gtp.c                                         |    3 
 drivers/net/macsec.c                                      |   44 ++++-
 drivers/net/usb/ax88179_178a.c                            |   11 -
 drivers/net/virtio_net.c                                  |   26 ++-
 drivers/net/vxlan/vxlan_core.c                            |    4 
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c    |    2 
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c             |    3 
 drivers/nfc/trf7970a.c                                    |   42 ++---
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c                |  112 ++++++++------
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c              |    9 -
 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c            |   31 +--
 drivers/phy/ti/phy-tusb1210.c                             |   23 +-
 drivers/video/fbdev/core/fb_defio.c                       |    2 
 fs/btrfs/backref.c                                        |   12 -
 fs/smb/client/cifs_spnego.h                               |    2 
 fs/smb/client/cifsfs.c                                    |    1 
 fs/smb/client/cifspdu.h                                   |  100 ++++++------
 fs/smb/client/fs_context.c                                |   12 +
 fs/smb/client/fs_context.h                                |    2 
 fs/smb/client/readdir.c                                   |    6 
 fs/smb/client/smb2pdu.c                                   |    4 
 fs/smb/client/smb2pdu.h                                   |    4 
 fs/smb/client/transport.c                                 |    3 
 include/linux/etherdevice.h                               |   25 +++
 include/net/af_unix.h                                     |    3 
 include/net/macsec.h                                      |    1 
 include/net/sock.h                                        |   39 ++--
 init/Kconfig                                              |    2 
 kernel/bounds.c                                           |    2 
 kernel/cpu.c                                              |    4 
 kernel/fork.c                                             |   18 +-
 lib/stackdepot.c                                          |    4 
 net/ax25/af_ax25.c                                        |    2 
 net/bluetooth/l2cap_sock.c                                |    7 
 net/bluetooth/mgmt.c                                      |   24 ++-
 net/bluetooth/sco.c                                       |    7 
 net/bridge/br_netlink.c                                   |    2 
 net/core/sock.c                                           |    1 
 net/core/sysctl_net_core.c                                |    9 +
 net/ethernet/eth.c                                        |   12 -
 net/ipv4/icmp.c                                           |   12 +
 net/ipv4/route.c                                          |    3 
 net/ipv4/udp.c                                            |    5 
 net/ipv6/udp.c                                            |    5 
 net/netfilter/ipvs/ip_vs_proto_sctp.c                     |    6 
 net/netfilter/nft_chain_filter.c                          |    4 
 net/openvswitch/conntrack.c                               |    4 
 net/unix/garbage.c                                        |    2 
 rust/macros/lib.rs                                        |   12 -
 98 files changed, 783 insertions(+), 454 deletions(-)

Adam Li (1):
      net: make SK_MEMORY_PCPU_RESERV tunable

Akhil R (1):
      dmaengine: tegra186: Fix residual calculation

Alex Deucher (1):
      drm/amdgpu/sdma5.2: use legacy HDP flush for SDMA2/3

Alexey Brodkin (1):
      ARC: [plat-hsdk]: Remove misplaced interrupt-cells property

Alice Ryhl (1):
      rust: don't select CONSTRUCTORS

Andrei Simion (1):
      ARM: dts: microchip: at91-sama7g5ek: Replace regulator-suspend-voltage with the valid property

Andrey Ryabinin (1):
      stackdepot: respect __GFP_NOLOCKDEP allocation flag

Andy Shevchenko (1):
      idma64: Don't try to serve interrupts when device is powered off

Arnd Bergmann (2):
      mtd: diskonchip: work around ubsan link failure
      dmaengine: owl: fix register access functions

Arınç ÜNAL (1):
      arm64: dts: rockchip: set PHY address of MT7531 switch to 0x1f

Aswin Unnikrishnan (1):
      rust: remove `params` from `module` macro example

Avraham Stern (1):
      wifi: iwlwifi: mvm: remove old PASN station when adding a new one

Baoquan He (1):
      riscv: fix VMALLOC_START definition

Bartosz Golaszewski (1):
      Bluetooth: qca: set power_ctrl_enabled on NULL returned by gpiod_get_optional()

Breno Leitao (1):
      virtio_net: Do not send RSS key if it is not supported

Chun-Yi Lee (1):
      Bluetooth: hci_sync: Using hci_cmd_sync_submit when removing Adv Monitor

Conor Dooley (1):
      rust: make mutually exclusive with CFI_CLANG

David Bauer (1):
      vxlan: drop packets from invalid src-address

David Kaplan (1):
      x86/cpu: Fix check for RDPKRU in __show_regs()

Dragan Simic (1):
      arm64: dts: rockchip: Remove unsupported node from the Pinebook Pro dts

Duoming Zhou (1):
      ax25: Fix netdev refcount issue

Eric Dumazet (4):
      icmp: prevent possible NULL dereferences from icmp_build_probe()
      net: fix sk_memory_allocated_{add|sub} vs softirqs
      ipv4: check for NULL idev in ip_route_use_hint()
      net: usb: ax88179_178a: stop lying about skb->truesize

Erwan Velu (1):
      i40e: Report MFS in decimal base instead of hex

Fenghua Yu (1):
      dmaengine: idxd: Fix oops during rmmod on single-CPU platforms

Greg Kroah-Hartman (2):
      Revert "crypto: api - Disallow identical driver names"
      Linux 6.1.90

Guanrui Huang (1):
      irqchip/gic-v3-its: Prevent double free on error

Gustavo A. R. Silva (1):
      smb: client: Fix struct_group() usage in __packed structs

Hangbin Liu (1):
      bridge/br_netlink.c: no need to return void function

Hans de Goede (1):
      phy: ti: tusb1210: Resolve charger-det crash if charger psy is unregistered

Huacai Chen (1):
      LoongArch: Fix callchain parse error with kernel tracepoint events

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

Jakub Kicinski (1):
      eth: bnxt: fix counting packets discarded due to OOM and netpoll

Jarred White (2):
      ACPI: CPPC: Use access_width over bit_width for system memory accesses
      ACPI: CPPC: Fix bit_offset shift in MASK_VAL() macro

Jason Reeder (1):
      net: ethernet: ti: am65-cpts: Fix PTPv1 message type on TX packets

Jiantao Shan (1):
      LoongArch: Fix access error when read fault on a write-only VMA

Johan Hovold (1):
      Bluetooth: qca: fix NULL-deref on non-serdev suspend

Johannes Thumshirn (1):
      btrfs: fix information leak in btrfs_ioctl_logical_to_ino()

Jose Ignacio Tornos Martinez (1):
      arm64: dts: rockchip: regulator for sd needs to be always on for BPI-R2Pro

Kees Cook (1):
      cifs: Replace remaining 1-element arrays

Kirill A. Shutemov (1):
      x86/tdx: Preserve shared bit on mprotect()

Kuniyuki Iwashima (1):
      af_unix: Suppress false-positive lockdep splat for spin_lock() in __unix_gc().

Luiz Augusto von Dentz (1):
      Bluetooth: MGMT: Fix failing to MGMT_OP_ADD_UUID/MGMT_OP_REMOVE_UUID

Mantas Pucka (1):
      mmc: sdhci-msm: pervent access to suspended controller

Marcel Ziswiler (1):
      phy: freescale: imx8m-pcie: fix pcie link-up instability

Matthew Wilcox (Oracle) (1):
      bounds: Use the right number of bits for power-of-two CONFIG_NR_CPUS

Miaohe Lin (1):
      fork: defer linking file vma until vma is fully initialized

Michal Tomek (1):
      phy: rockchip-snps-pcie3: fix bifurcation on rk3588

Mikhail Kobuk (2):
      phy: marvell: a3700-comphy: Fix out of bounds read
      phy: marvell: a3700-comphy: Fix hardcoded array size

Miri Korenblit (1):
      wifi: iwlwifi: mvm: return uid from iwl_mvm_build_scan_cmd

Mukul Joshi (1):
      drm/amdgpu: Fix leak when GPU memory allocation fails

Nam Cao (2):
      HID: i2c-hid: remove I2C_HID_READ_PENDING flag to prevent lock-up
      fbdev: fix incorrect address computation in deferred IO

Nathan Chancellor (1):
      Bluetooth: Fix type of len in {l2cap,sco}_sock_getsockopt_old()

Nícolas F. R. A. Prado (3):
      arm64: dts: mediatek: mt8192: Add missing gce-client-reg to mutex
      arm64: dts: mediatek: mt8195: Add missing gce-client-reg to vpp/vdosys
      arm64: dts: mediatek: mt8195: Add missing gce-client-reg to mutex

Pablo Neira Ayuso (1):
      netfilter: nf_tables: honor table dormant flag from netdev release event path

Paul Geurts (1):
      NFC: trf7970a: disable all regulators on removal

Paulo Alcantara (1):
      smb: client: fix rename(2) regression against samba

Peter Münster (1):
      net: b44: set pause params only when interface is up

Pin-yen Lin (2):
      arm64: dts: mediatek: mt8192-asurada: Update min voltage constraint for MT6315
      arm64: dts: mediatek: mt8195-cherry: Update min voltage constraint for MT6315

Quentin Schulz (2):
      arm64: dts: rockchip: enable internal pull-up on Q7_USB_ID for RK3399 Puma
      arm64: dts: rockchip: enable internal pull-up on PCIE_WAKE# for RK3399 Puma

Rafał Miłecki (5):
      arm64: dts: mediatek: mt7622: fix clock controllers
      arm64: dts: mediatek: mt7622: fix IR nodename
      arm64: dts: mediatek: mt7622: fix ethernet controller "compatible"
      arm64: dts: mediatek: mt7622: drop "reset-names" from thermal block
      arm64: dts: mediatek: mt2712: fix validation errors

Rahul Rameshbabu (4):
      ethernet: Add helper for assigning packet type when dest address does not match device address
      macsec: Enable devices to advertise whether they update sk_buff md_dst during offloads
      macsec: Detect if Rx skb is macsec-related for offloading devices that update md_dst
      net/mlx5e: Advertise mlx5 ethernet driver updates sk_buff md_dst for MACsec

Richard Zhu (1):
      phy: freescale: imx8m-pcie: Refine i.MX8MM PCIe PHY driver

Samuel Holland (1):
      riscv: Fix TASK_SIZE on 64-bit NOMMU

Sean Anderson (1):
      dma: xilinx_dpdma: Fix locking

Sean Christopherson (1):
      cpu: Re-enable CPU mitigations by default for !X86 architectures

Sebastian Reichel (1):
      phy: rockchip-snps-pcie3: fix clearing PHP_GRF_PCIESEL_CON bits

Sindhu Devale (1):
      i40e: Do not use WQ_MEM_RECLAIM flag for workqueue

Steve French (1):
      smb3: fix lock ordering potential deadlock in cifs_sync_mid_result

Sudheer Mogilappagari (1):
      iavf: Fix TC config comparison with existing adapter TC config

Takayuki Nagata (1):
      cifs: reinstate original behavior again for forceuid/forcegid

Vanshidhar Konda (1):
      ACPI: CPPC: Fix access width used for PCC registers

Vikas Gupta (2):
      bnxt_en: refactor reset close code
      bnxt_en: Fix the PCI-AER routines

WangYuli (1):
      Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0bda:0x4853

Wolfram Sang (1):
      i2c: smbus: fix NULL function pointer dereference

Yaraslau Furman (1):
      HID: logitech-dj: allow mice to use all types of reports

Yick Xie (1):
      udp: preserve the connected status if only UDP cmsg

Zhang Lixu (1):
      HID: intel-ish-hid: ipc: Fix dev_err usage with uninitialized dev->devc


