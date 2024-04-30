Return-Path: <linux-kernel+bounces-163844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB068B740D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3081B285811
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EA712D746;
	Tue, 30 Apr 2024 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2gx2rPoW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B6417592;
	Tue, 30 Apr 2024 11:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476384; cv=none; b=MYf/IoZ/uZ6rEZtQypPz9CCtKobvSZkvc5eyXmeZpWNXwjhDJPMiHl5UxbrcOOIo+P/qtmD9tMZZhf6vFaETdCRfwStiSgxnTEMS7GG6N52Ac0TJmFlqikhZFgLqTdoh8sIrTEPn3yGDbmp4POieUXH0PXhCZUFvSOdgPwI7lVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476384; c=relaxed/simple;
	bh=ww5WQt3GhBh/vrI3RBSTla9eJowdXO8nFWN/PrFrsck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nkLOZj/XjUNlWIuS2k9ywrBWcbww2IQHQwdPpIzUoS6i8reRdfxie/qd2A0UZnd8QB6vyw3CZRe7PRe8xEG8kdm8QsC8T2z5w1jRrun4U9qFgxN2oIbx3A2Z4iYGHK0yxlDpmIAOy779HEHccWGzDDLU4PPeTXtfvtpqjp752Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2gx2rPoW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA47C4AF18;
	Tue, 30 Apr 2024 11:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714476383;
	bh=ww5WQt3GhBh/vrI3RBSTla9eJowdXO8nFWN/PrFrsck=;
	h=From:To:Cc:Subject:Date:From;
	b=2gx2rPoW7AZb1OjbJeYVyZ9O5oQdt7l8flIdc5WLRnBqkII7o2uCSW9Gm30GQJdPw
	 wl0YjKccOXwtVRdVGJRp4knJwc/P+PKUdsLn8DyJXBkkXILjHaxtK7cx3winMkrSMI
	 0yys/eGixwforWrqK4VW4YyqEwkuSMtVbk5Qqqxg=
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
Subject: [PATCH 6.1 000/110] 6.1.90-rc1 review
Date: Tue, 30 Apr 2024 12:39:29 +0200
Message-ID: <20240430103047.561802595@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.90-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.90-rc1
X-KernelTest-Deadline: 2024-05-02T10:30+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.1.90 release.
There are 110 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.90-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.90-rc1

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    net/mlx5e: Advertise mlx5 ethernet driver updates sk_buff md_dst for MACsec

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    macsec: Detect if Rx skb is macsec-related for offloading devices that update md_dst

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    macsec: Enable devices to advertise whether they update sk_buff md_dst during offloads

Matthew Wilcox (Oracle) <willy@infradead.org>
    bounds: Use the right number of bits for power-of-two CONFIG_NR_CPUS

Wolfram Sang <wsa+renesas@sang-engineering.com>
    i2c: smbus: fix NULL function pointer dereference

Hans de Goede <hdegoede@redhat.com>
    phy: ti: tusb1210: Resolve charger-det crash if charger psy is unregistered

Samuel Holland <samuel.holland@sifive.com>
    riscv: Fix TASK_SIZE on 64-bit NOMMU

Baoquan He <bhe@redhat.com>
    riscv: fix VMALLOC_START definition

Fenghua Yu <fenghua.yu@intel.com>
    dmaengine: idxd: Fix oops during rmmod on single-CPU platforms

Sean Anderson <sean.anderson@linux.dev>
    dma: xilinx_dpdma: Fix locking

Sebastian Reichel <sebastian.reichel@collabora.com>
    phy: rockchip-snps-pcie3: fix clearing PHP_GRF_PCIESEL_CON bits

Michal Tomek <mtdev79b@gmail.com>
    phy: rockchip-snps-pcie3: fix bifurcation on rk3588

Marcel Ziswiler <marcel.ziswiler@toradex.com>
    phy: freescale: imx8m-pcie: fix pcie link-up instability

Richard Zhu <hongxing.zhu@nxp.com>
    phy: freescale: imx8m-pcie: Refine i.MX8MM PCIe PHY driver

Mikhail Kobuk <m.kobuk@ispras.ru>
    phy: marvell: a3700-comphy: Fix hardcoded array size

Mikhail Kobuk <m.kobuk@ispras.ru>
    phy: marvell: a3700-comphy: Fix out of bounds read

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    idma64: Don't try to serve interrupts when device is powered off

Akhil R <akhilrajeev@nvidia.com>
    dmaengine: tegra186: Fix residual calculation

Arnd Bergmann <arnd@arndb.de>
    dmaengine: owl: fix register access functions

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/tdx: Preserve shared bit on mprotect()

Aswin Unnikrishnan <aswinunni01@gmail.com>
    rust: remove `params` from `module` macro example

Arnd Bergmann <arnd@arndb.de>
    mtd: diskonchip: work around ubsan link failure

Yick Xie <yick.xie@gmail.com>
    udp: preserve the connected status if only UDP cmsg

Nam Cao <namcao@linutronix.de>
    fbdev: fix incorrect address computation in deferred IO

Andrey Ryabinin <ryabinin.a.a@gmail.com>
    stackdepot: respect __GFP_NOLOCKDEP allocation flag

Peter Münster <pm@a16n.net>
    net: b44: set pause params only when interface is up

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    ethernet: Add helper for assigning packet type when dest address does not match device address

Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
    ACPI: CPPC: Fix access width used for PCC registers

Jarred White <jarredwhite@linux.microsoft.com>
    ACPI: CPPC: Fix bit_offset shift in MASK_VAL() macro

Jarred White <jarredwhite@linux.microsoft.com>
    ACPI: CPPC: Use access_width over bit_width for system memory accesses

Guanrui Huang <guanrui.huang@linux.alibaba.com>
    irqchip/gic-v3-its: Prevent double free on error

Mukul Joshi <mukul.joshi@amd.com>
    drm/amdgpu: Fix leak when GPU memory allocation fails

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/sdma5.2: use legacy HDP flush for SDMA2/3

Iskander Amara <iskander.amara@theobroma-systems.com>
    arm64: dts: rockchip: enable internal pull-up for Q7_THRM# on RK3399 Puma

Jiantao Shan <shanjiantao@loongson.cn>
    LoongArch: Fix access error when read fault on a write-only VMA

Huacai Chen <chenhuacai@kernel.org>
    LoongArch: Fix callchain parse error with kernel tracepoint events

Sean Christopherson <seanjc@google.com>
    cpu: Re-enable CPU mitigations by default for !X86 architectures

Johannes Thumshirn <johannes.thumshirn@wdc.com>
    btrfs: fix information leak in btrfs_ioctl_logical_to_ino()

Nam Cao <namcao@linutronix.de>
    HID: i2c-hid: remove I2C_HID_READ_PENDING flag to prevent lock-up

Steve French <stfrench@microsoft.com>
    smb3: fix lock ordering potential deadlock in cifs_sync_mid_result

Gustavo A. R. Silva <gustavoars@kernel.org>
    smb: client: Fix struct_group() usage in __packed structs

Mantas Pucka <mantas@8devices.com>
    mmc: sdhci-msm: pervent access to suspended controller

Johan Hovold <johan+linaro@kernel.org>
    Bluetooth: qca: fix NULL-deref on non-serdev suspend

WangYuli <wangyuli@uniontech.com>
    Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0bda:0x4853

Nathan Chancellor <nathan@kernel.org>
    Bluetooth: Fix type of len in {l2cap,sco}_sock_getsockopt_old()

Conor Dooley <conor.dooley@microchip.com>
    rust: make mutually exclusive with CFI_CLANG

Alice Ryhl <aliceryhl@google.com>
    rust: don't select CONSTRUCTORS

David Kaplan <david.kaplan@amd.com>
    x86/cpu: Fix check for RDPKRU in __show_regs()

Miaohe Lin <linmiaohe@huawei.com>
    fork: defer linking file vma until vma is fully initialized

Breno Leitao <leitao@debian.org>
    virtio_net: Do not send RSS key if it is not supported

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "crypto: api - Disallow identical driver names"

Kees Cook <keescook@chromium.org>
    cifs: Replace remaining 1-element arrays

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

Jakub Kicinski <kuba@kernel.org>
    eth: bnxt: fix counting packets discarded due to OOM and netpoll

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

Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
    Bluetooth: qca: set power_ctrl_enabled on NULL returned by gpiod_get_optional()

Chun-Yi Lee <jlee@suse.com>
    Bluetooth: hci_sync: Using hci_cmd_sync_submit when removing Adv Monitor

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: MGMT: Fix failing to MGMT_OP_ADD_UUID/MGMT_OP_REMOVE_UUID

Hyunwoo Kim <v4bel@theori.io>
    net: gtp: Fix Use-After-Free in gtp_dellink

Eric Dumazet <edumazet@google.com>
    net: usb: ax88179_178a: stop lying about skb->truesize

Eric Dumazet <edumazet@google.com>
    ipv4: check for NULL idev in ip_route_use_hint()

Eric Dumazet <edumazet@google.com>
    net: fix sk_memory_allocated_{add|sub} vs softirqs

Adam Li <adamli@os.amperecomputing.com>
    net: make SK_MEMORY_PCPU_RESERV tunable

Duoming Zhou <duoming@zju.edu.cn>
    ax25: Fix netdev refcount issue

Paul Geurts <paul_geurts@live.nl>
    NFC: trf7970a: disable all regulators on removal

Vikas Gupta <vikas.gupta@broadcom.com>
    bnxt_en: Fix the PCI-AER routines

Vikas Gupta <vikas.gupta@broadcom.com>
    bnxt_en: refactor reset close code

Hangbin Liu <liuhangbin@gmail.com>
    bridge/br_netlink.c: no need to return void function

Eric Dumazet <edumazet@google.com>
    icmp: prevent possible NULL dereferences from icmp_build_probe()

Andrei Simion <andrei.simion@microchip.com>
    ARM: dts: microchip: at91-sama7g5ek: Replace regulator-suspend-voltage with the valid property

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

Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
    arm64: dts: rockchip: regulator for sd needs to be always on for BPI-R2Pro

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

Pin-yen Lin <treapking@chromium.org>
    arm64: dts: mediatek: mt8195-cherry: Update min voltage constraint for MT6315

Pin-yen Lin <treapking@chromium.org>
    arm64: dts: mediatek: mt8192-asurada: Update min voltage constraint for MT6315

Nícolas F. R. A. Prado <nfraprado@collabora.com>
    arm64: dts: mediatek: mt8195: Add missing gce-client-reg to mutex

Nícolas F. R. A. Prado <nfraprado@collabora.com>
    arm64: dts: mediatek: mt8195: Add missing gce-client-reg to vpp/vdosys

Nícolas F. R. A. Prado <nfraprado@collabora.com>
    arm64: dts: mediatek: mt8192: Add missing gce-client-reg to mutex

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

Arınç ÜNAL <arinc.unal@arinc9.com>
    arm64: dts: rockchip: set PHY address of MT7531 switch to 0x1f

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

 Documentation/admin-guide/sysctl/net.rst           |   5 +
 Makefile                                           |   4 +-
 arch/Kconfig                                       |   8 ++
 arch/arc/boot/dts/hsdk.dts                         |   1 -
 arch/arm/boot/dts/at91-sama7g5ek.dts               |   8 +-
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts        |   8 +-
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |   3 +-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           |  34 +++----
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |   1 +
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi   |   6 +-
 arch/arm64/boot/dts/mediatek/mt8192.dtsi           |   1 +
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi    |   4 +-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi           |   4 +
 .../boot/dts/rockchip/rk3399-pinebook-pro.dts      |   1 -
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      |  31 ++++--
 arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts |   6 +-
 arch/loongarch/include/asm/perf_event.h            |   8 ++
 arch/loongarch/mm/fault.c                          |   4 +-
 arch/riscv/include/asm/pgtable.h                   |   4 +-
 arch/x86/Kconfig                                   |  11 +-
 arch/x86/include/asm/coco.h                        |   5 +-
 arch/x86/include/asm/pgtable_types.h               |   3 +-
 arch/x86/kernel/process_64.c                       |   2 +-
 crypto/algapi.c                                    |   1 -
 drivers/acpi/cppc_acpi.c                           |  72 ++++++++++---
 drivers/bluetooth/btusb.c                          |   2 +
 drivers/bluetooth/hci_qca.c                        |  21 +++-
 drivers/dma/idma64.c                               |   4 +
 drivers/dma/idxd/perfmon.c                         |   9 +-
 drivers/dma/owl-dma.c                              |   4 +-
 drivers/dma/tegra186-gpc-dma.c                     |   3 +
 drivers/dma/xilinx/xilinx_dpdma.c                  |  13 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |  24 +++--
 drivers/hid/hid-logitech-dj.c                      |   4 +-
 drivers/hid/i2c-hid/i2c-hid-core.c                 |   9 --
 drivers/hid/intel-ish-hid/ipc/ipc.c                |   2 +-
 drivers/i2c/i2c-core-base.c                        |  12 +--
 drivers/irqchip/irq-gic-v3-its.c                   |   9 +-
 drivers/mmc/host/sdhci-msm.c                       |  16 ++-
 drivers/mtd/nand/raw/diskonchip.c                  |   4 +-
 drivers/net/ethernet/broadcom/b44.c                |  14 +--
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  80 ++++++++-------
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   6 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  30 +++++-
 .../ethernet/mellanox/mlx5/core/en_accel/macsec.c  |   1 +
 drivers/net/ethernet/mellanox/mlxsw/core.c         |   2 +-
 .../ethernet/mellanox/mlxsw/spectrum_acl_tcam.c    |  54 ++++++++--
 drivers/net/ethernet/ti/am65-cpts.c                |   5 +
 drivers/net/gtp.c                                  |   3 +-
 drivers/net/macsec.c                               |  44 ++++++--
 drivers/net/usb/ax88179_178a.c                     |  11 +-
 drivers/net/virtio_net.c                           |  28 +++++-
 drivers/net/vxlan/vxlan_core.c                     |   4 +
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |   3 +-
 drivers/nfc/trf7970a.c                             |  42 ++++----
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c         | 112 +++++++++++++--------
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c       |   9 +-
 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c     |  31 +++---
 drivers/phy/ti/phy-tusb1210.c                      |  23 +++--
 drivers/video/fbdev/core/fb_defio.c                |   2 +-
 fs/btrfs/backref.c                                 |  12 +--
 fs/smb/client/cifs_spnego.h                        |   2 +-
 fs/smb/client/cifsfs.c                             |   1 +
 fs/smb/client/cifspdu.h                            | 100 +++++++++---------
 fs/smb/client/fs_context.c                         |  12 +++
 fs/smb/client/fs_context.h                         |   2 +
 fs/smb/client/readdir.c                            |   6 +-
 fs/smb/client/smb2pdu.c                            |   4 +-
 fs/smb/client/smb2pdu.h                            |   4 +-
 fs/smb/client/transport.c                          |   3 +
 include/linux/etherdevice.h                        |  25 +++++
 include/net/af_unix.h                              |   3 +
 include/net/macsec.h                               |   1 +
 include/net/sock.h                                 |  41 ++++----
 init/Kconfig                                       |   2 +-
 kernel/bounds.c                                    |   2 +-
 kernel/cpu.c                                       |   4 +-
 kernel/fork.c                                      |  18 ++--
 lib/stackdepot.c                                   |   4 +-
 net/ax25/af_ax25.c                                 |   2 +-
 net/bluetooth/l2cap_sock.c                         |   7 +-
 net/bluetooth/mgmt.c                               |  24 +++--
 net/bluetooth/sco.c                                |   7 +-
 net/bridge/br_netlink.c                            |   2 +-
 net/core/sock.c                                    |   1 +
 net/core/sysctl_net_core.c                         |   9 ++
 net/ethernet/eth.c                                 |  12 +--
 net/ipv4/icmp.c                                    |  12 ++-
 net/ipv4/route.c                                   |   3 +
 net/ipv4/udp.c                                     |   5 +-
 net/ipv6/udp.c                                     |   5 +-
 net/netfilter/ipvs/ip_vs_proto_sctp.c              |   6 +-
 net/netfilter/nft_chain_filter.c                   |   4 +-
 net/openvswitch/conntrack.c                        |   4 +-
 net/unix/garbage.c                                 |   2 +-
 rust/macros/lib.rs                                 |  12 ---
 98 files changed, 785 insertions(+), 456 deletions(-)



