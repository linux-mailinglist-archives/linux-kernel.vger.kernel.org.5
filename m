Return-Path: <linux-kernel+bounces-163822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9AD8B7267
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131FD1F23A11
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7182012DD8E;
	Tue, 30 Apr 2024 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nc9ZMA6j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC4812DD87;
	Tue, 30 Apr 2024 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475252; cv=none; b=PbrX8tEzUQ4vlDLl+wStCMlQVjKYtHPCbIMpqAJy7hIIU/ftLlErRN5VzacjmlYq2AuUEWCl3OKUDy5QCedUZntfY3u1T/OvSTjkGPI9Dd4jh/WaPml8KSqr3DvQXLSj9dElgwLarm6o+VIIg+6yOcjBW7chLHT/32ENI7P+u0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475252; c=relaxed/simple;
	bh=zdZ9fdyZlMqldBfzjCLWE/mTC9IzXnKYBMymF7if8Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QE4R1JNgRYKZBlbKI8F972JoUYVx7QVIck+DkUAV1KrqneN5iSoi+bBT2SZsudWcQurz8Cm9nMjM9bKRSeTccjoMCSfLyQRFJkJruEBhrieuTbg4l13mR7YSPagOy/megkzagMzOGwrz4VtR/5jKxUD0QqnfWWN0096YiHH64VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nc9ZMA6j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7FFC4AF1B;
	Tue, 30 Apr 2024 11:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475252;
	bh=zdZ9fdyZlMqldBfzjCLWE/mTC9IzXnKYBMymF7if8Ig=;
	h=From:To:Cc:Subject:Date:From;
	b=nc9ZMA6jhn7u35M06tbyUJ5rFArqXnCKQ552ir2mmvCOuvUtxVTyM6qSDs0DHMs0i
	 NhjgZ6oMcdICIU3xeSf1Py5Rs6Vw7lmqNJ7pT6VlsCHTMXY044acNYkHNseEdmluQV
	 txb2XO991Em7RQ3yjogQzB+mftQl2UTjbTztrXVk=
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
Subject: [PATCH 6.6 000/186] 6.6.30-rc1 review
Date: Tue, 30 Apr 2024 12:37:32 +0200
Message-ID: <20240430103058.010791820@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.30-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.30-rc1
X-KernelTest-Deadline: 2024-05-02T10:31+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.6.30 release.
There are 186 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.30-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.6.30-rc1

Matthew Wilcox (Oracle) <willy@infradead.org>
    bounds: Use the right number of bits for power-of-two CONFIG_NR_CPUS

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    net/mlx5e: Advertise mlx5 ethernet driver updates sk_buff md_dst for MACsec

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    macsec: Detect if Rx skb is macsec-related for offloading devices that update md_dst

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    macsec: Enable devices to advertise whether they update sk_buff md_dst during offloads

Mingzheng Xing <xingmingzheng@iscas.ac.cn>
    Revert "riscv: kdump: fix crashkernel reserving problem on RISC-V"

Amir Goldstein <amir73il@gmail.com>
    ovl: fix memory leak in ovl_parse_param()

Johan Hovold <johan+linaro@kernel.org>
    phy: qcom: qmp-combo: fix VCO div offset on v5_5nm and v6

Wolfram Sang <wsa+renesas@sang-engineering.com>
    i2c: smbus: fix NULL function pointer dereference

Xuewen Yan <xuewen.yan@unisoc.com>
    sched/eevdf: Prevent vlag from going out of bounds in reweight_eevdf()

Tianchen Ding <dtcccc@linux.alibaba.com>
    sched/eevdf: Fix miscalculation in reweight_entity() when se is not curr

Tianchen Ding <dtcccc@linux.alibaba.com>
    sched/eevdf: Always update V if se->on_rq when reweighting

Hans de Goede <hdegoede@redhat.com>
    phy: ti: tusb1210: Resolve charger-det crash if charger psy is unregistered

Samuel Holland <samuel.holland@sifive.com>
    riscv: Fix loading 64-bit NOMMU kernels past the start of RAM

Samuel Holland <samuel.holland@sifive.com>
    riscv: Fix TASK_SIZE on 64-bit NOMMU

Baoquan He <bhe@redhat.com>
    riscv: fix VMALLOC_START definition

Fenghua Yu <fenghua.yu@intel.com>
    dmaengine: idxd: Fix oops during rmmod on single-CPU platforms

Sean Anderson <sean.anderson@linux.dev>
    dma: xilinx_dpdma: Fix locking

Rex Zhang <rex.zhang@intel.com>
    dmaengine: idxd: Convert spinlock to mutex to lock evl workqueue

Gabor Juhos <j4g8y7@gmail.com>
    phy: qcom: m31: match requested regulator name with dt schema

Sebastian Reichel <sebastian.reichel@collabora.com>
    phy: rockchip: naneng-combphy: Fix mux on rk3588

Sebastian Reichel <sebastian.reichel@collabora.com>
    phy: rockchip-snps-pcie3: fix clearing PHP_GRF_PCIESEL_CON bits

Michal Tomek <mtdev79b@gmail.com>
    phy: rockchip-snps-pcie3: fix bifurcation on rk3588

Marcel Ziswiler <marcel.ziswiler@toradex.com>
    phy: freescale: imx8m-pcie: fix pcie link-up instability

Mikhail Kobuk <m.kobuk@ispras.ru>
    phy: marvell: a3700-comphy: Fix hardcoded array size

Mikhail Kobuk <m.kobuk@ispras.ru>
    phy: marvell: a3700-comphy: Fix out of bounds read

Vijendar Mukunda <Vijendar.Mukunda@amd.com>
    soundwire: amd: fix for wake interrupt handling for clockstop mode

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    idma64: Don't try to serve interrupts when device is powered off

Akhil R <akhilrajeev@nvidia.com>
    dmaengine: tegra186: Fix residual calculation

Arnd Bergmann <arnd@arndb.de>
    dmaengine: owl: fix register access functions

Matthew Wilcox (Oracle) <willy@infradead.org>
    mm: turn folio_test_hugetlb into a PageType

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/tdx: Preserve shared bit on mprotect()

Stephen Boyd <swboyd@chromium.org>
    phy: qcom: qmp-combo: Fix VCO div offset on v3

Stephen Boyd <swboyd@chromium.org>
    phy: qcom: qmp-combo: Fix register base for QSERDES_DP_PHY_MODE

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

Lijo Lazar <lijo.lazar@amd.com>
    drm/amdgpu: Assign correct bits for SDMA HDP flush

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/sdma5.2: use legacy HDP flush for SDMA2/3

Iskander Amara <iskander.amara@theobroma-systems.com>
    arm64: dts: rockchip: enable internal pull-up for Q7_THRM# on RK3399 Puma

Manivannan Sadhasivam <mani@kernel.org>
    arm64: dts: qcom: sm8450: Fix the msi-map entries

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP

Jiantao Shan <shanjiantao@loongson.cn>
    LoongArch: Fix access error when read fault on a write-only VMA

Huacai Chen <chenhuacai@kernel.org>
    LoongArch: Fix callchain parse error with kernel tracepoint events

Sean Christopherson <seanjc@google.com>
    cpu: Re-enable CPU mitigations by default for !X86 architectures

Johannes Thumshirn <johannes.thumshirn@wdc.com>
    btrfs: fix information leak in btrfs_ioctl_logical_to_ino()

Naohiro Aota <naohiro.aota@wdc.com>
    btrfs: scrub: run relocation repair when/only needed

Qu Wenruo <wqu@suse.com>
    btrfs: fix wrong block_start calculation for btrfs_drop_extent_map_range()

Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
    btrfs: fallback if compressed IO fails for ENOSPC

Nam Cao <namcao@linutronix.de>
    HID: i2c-hid: remove I2C_HID_READ_PENDING flag to prevent lock-up

Steve French <stfrench@microsoft.com>
    smb3: fix lock ordering potential deadlock in cifs_sync_mid_result

Steve French <stfrench@microsoft.com>
    smb3: missing lock when picking channel

Gustavo A. R. Silva <gustavoars@kernel.org>
    smb: client: Fix struct_group() usage in __packed structs

Matthew Wilcox (Oracle) <willy@infradead.org>
    mm: support page_mapcount() on page_has_type() pages

Matthew Wilcox (Oracle) <willy@infradead.org>
    mm: create FOLIO_FLAG_FALSE and FOLIO_TYPE_OPS macros

Mantas Pucka <mantas@8devices.com>
    mmc: sdhci-msm: pervent access to suspended controller

Peter Xu <peterx@redhat.com>
    mm/hugetlb: fix missing hugetlb_lock for resv uncharge

Christian Marangi <ansuelsmth@gmail.com>
    mtd: rawnand: qcom: Fix broken OP_RESET_DEVICE command in qcom_misc_cmd_type_exec()

Johan Hovold <johan+linaro@kernel.org>
    Bluetooth: qca: fix NULL-deref on non-serdev setup

Johan Hovold <johan+linaro@kernel.org>
    Bluetooth: qca: fix NULL-deref on non-serdev suspend

WangYuli <wangyuli@uniontech.com>
    Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0bda:0x4853

Nathan Chancellor <nathan@kernel.org>
    Bluetooth: Fix type of len in {l2cap,sco}_sock_getsockopt_old()

Aswin Unnikrishnan <aswinunni01@gmail.com>
    rust: remove `params` from `module` macro example

Miguel Ojeda <ojeda@kernel.org>
    kbuild: rust: force `alloc` extern to allow "empty" Rust files

Miguel Ojeda <ojeda@kernel.org>
    kbuild: rust: remove unneeded `@rustc_cfg` to avoid ICE

Conor Dooley <conor.dooley@microchip.com>
    rust: make mutually exclusive with CFI_CLANG

Laine Taffin Altman <alexanderaltman@me.com>
    rust: init: remove impl Zeroable for Infallible

Alice Ryhl <aliceryhl@google.com>
    rust: don't select CONSTRUCTORS

David Kaplan <david.kaplan@amd.com>
    x86/cpu: Fix check for RDPKRU in __show_regs()

Miaohe Lin <linmiaohe@huawei.com>
    fork: defer linking file vma until vma is fully initialized

Terry Tritton <terry.tritton@linaro.org>
    selftests/seccomp: Handle EINVAL on unshare(CLONE_NEWPID)

Terry Tritton <terry.tritton@linaro.org>
    selftests/seccomp: Change the syscall used in KILL_THREAD test

Terry Tritton <terry.tritton@linaro.org>
    selftests/seccomp: user_notification_addfd check nextfd is available

Phillip Lougher <phillip@squashfs.org.uk>
    Squashfs: check the inode number is not the invalid value of zero

Jeff Layton <jlayton@kernel.org>
    squashfs: convert to new timestamp accessors

Christian König <ckoenig.leichtzumerken@gmail.com>
    drm/ttm: stop pooling cached NUMA pages v2

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    mm, treewide: introduce NR_PAGE_ORDERS

Christian König <christian.koenig@amd.com>
    drm/amdgpu: fix visible VRAM handling during faults

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: add shared fdinfo stats

Alex Deucher <alexander.deucher@amd.com>
    drm: add drm_gem_object_is_shared_for_memory_stats() helper

David Hildenbrand <david@redhat.com>
    mm/madvise: make MADV_POPULATE_(READ|WRITE) handle VM_FAULT_RETRY properly

Lorenzo Stoakes <lstoakes@gmail.com>
    mm/gup: explicitly define and check internal GUP flags, disallow FOLL_TOUCH

Sean Christopherson <seanjc@google.com>
    KVM: x86/pmu: Set enable bits for GP counters in PERF_GLOBAL_CTRL at "RESET"

Sean Christopherson <seanjc@google.com>
    KVM: x86/pmu: Zero out PMU metadata on AMD if PMU is disabled

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Suppress false-positive lockdep splat for spin_lock() in __unix_gc().

Sabrina Dubroca <sd@queasysnail.net>
    tls: fix lockless read of strp->msg_ready in ->poll

Jason Reeder <jreeder@ti.com>
    net: ethernet: ti: am65-cpts: Fix PTPv1 message type on TX packets

Jacob Keller <jacob.e.keller@intel.com>
    ice: fix LAG and VF lock dependency in ice_reset_vf()

Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
    iavf: Fix TC config comparison with existing adapter TC config

Erwan Velu <e.velu@criteo.com>
    i40e: Report MFS in decimal base instead of hex

Sindhu Devale <sindhu.devale@intel.com>
    i40e: Do not use WQ_MEM_RECLAIM flag for workqueue

Dan Carpenter <dan.carpenter@linaro.org>
    net: ti: icssg-prueth: Fix signedness bug in prueth_init_rx_chns()

MD Danish Anwar <danishanwar@ti.com>
    net: phy: dp83869: Fix MII mode failure

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: honor table dormant flag from netdev release event path

Michael Heimpold <michael.heimpold@chargebyte.com>
    ARM: dts: imx6ull-tarragon: fix USB over-current polarity

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

Ido Schimmel <idosch@nvidia.com>
    mlxsw: spectrum_acl_tcam: Fix race in region ID allocation

Amit Cohen <amcohen@nvidia.com>
    mlxsw: Use refcount_t for reference counting

Hyunwoo Kim <v4bel@theori.io>
    net: openvswitch: Fix Use-After-Free in ovs_ct_exit

Ismael Luceno <iluceno@suse.de>
    ipvs: Fix checksumming on GSO of SCTP packets

Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
    Bluetooth: qca: set power_ctrl_enabled on NULL returned by gpiod_get_optional()

Chun-Yi Lee <jlee@suse.com>
    Bluetooth: hci_sync: Using hci_cmd_sync_submit when removing Adv Monitor

Sean Wang <sean.wang@mediatek.com>
    Bluetooth: btusb: mediatek: Fix double free of skb in coredump

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: MGMT: Fix failing to MGMT_OP_ADD_UUID/MGMT_OP_REMOVE_UUID

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_event: Fix sending HCI_OP_READ_ENC_KEY_SIZE

Zijun Hu <quic_zijuhu@quicinc.com>
    Bluetooth: btusb: Fix triggering coredump implementation for QCA

Prathamesh Shete <pshete@nvidia.com>
    gpio: tegra186: Fix tegra186_gpio_is_accessible() check

Daniel Golle <daniel@makrotopia.org>
    net: phy: mediatek-ge-soc: follow netdev LED trigger semantics

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

Jakub Kicinski <kuba@kernel.org>
    tools: ynl: don't ignore errors in NLMSG_DONE messages

Duoming Zhou <duoming@zju.edu.cn>
    ax25: Fix netdev refcount issue

Paul Geurts <paul_geurts@live.nl>
    NFC: trf7970a: disable all regulators on removal

Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
    net: dsa: mv88e6xx: fix supported_interfaces setup in mv88e6250_phylink_get_caps()

Dan Williams <dan.j.williams@intel.com>
    cxl/core: Fix potential payload size confusion in cxl_mem_get_poison()

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
    mlxsw: core_env: Fix driver initialization with old firmware

Ido Schimmel <idosch@nvidia.com>
    mlxsw: core: Unregister EMAD trap using FORWARD action

Justin Chen <justin.chen@broadcom.com>
    net: bcmasp: fix memory leak when bringing down interface

David Bauer <mail@david-bauer.net>
    vxlan: drop packets from invalid src-address

Duanqiang Wen <duanqiangwen@net-swift.com>
    net: libwx: fix alloc msix vectors failed

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: fix unaligned le16 access

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: remove link before AP

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211_hwsim: init peer measurement result

Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
    drm/gma500: Remove lid code

Miri Korenblit <miriam.rachel.korenblit@intel.com>
    wifi: iwlwifi: mvm: return uid from iwl_mvm_build_scan_cmd

Avraham Stern <avraham.stern@intel.com>
    wifi: iwlwifi: mvm: remove old PASN station when adding a new one

Felix Fietkau <nbd@nbd.name>
    wifi: mac80211: split mesh fast tx cache into local/proxied/forwarded

Colin Ian King <colin.i.king@intel.com>
    wifi: mac80211: clean up assignments to pointer cache.

Alexey Brodkin <Alexey.Brodkin@synopsys.com>
    ARC: [plat-hsdk]: Remove misplaced interrupt-cells property

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    gpio: tangier: Use correct type for the IRQ chip data

Maximilian Luz <luzmaximilian@gmail.com>
    arm64: dts: qcom: sc8180x: Fix ss_phy_irq for secondary USB controller

Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
    arm64: dts: rockchip: regulator for sd needs to be always on for BPI-R2Pro

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: mediatek: mt2712: fix validation errors

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: mediatek: mt7986: prefix BPI-R3 cooling maps with "map-"

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: mediatek: mt7986: drop invalid thermal block clock

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: mediatek: mt7986: reorder nodes

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: mediatek: mt7986: drop "#reset-cells" from Ethernet controller

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: mediatek: mt7986: drop invalid properties from ethsys

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: mediatek: mt7986: reorder properties

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: mediatek: mt7622: drop "reset-names" from thermal block

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: mediatek: mt7622: fix ethernet controller "compatible"

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: mediatek: mt7622: fix IR nodename

Rafał Miłecki <rafal@milecki.pl>
    arm64: dts: mediatek: mt7622: fix clock controllers

Pin-yen Lin <treapking@chromium.org>
    arm64: dts: mediatek: mt8183-kukui: Use default min voltage for MT6358

Pin-yen Lin <treapking@chromium.org>
    arm64: dts: mediatek: mt8195-cherry: Update min voltage constraint for MT6315

Pin-yen Lin <treapking@chromium.org>
    arm64: dts: mediatek: mt8192-asurada: Update min voltage constraint for MT6315

Nícolas F. R. A. Prado <nfraprado@collabora.com>
    arm64: dts: mediatek: cherry: Describe CPU supplies

AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
    arm64: dts: mediatek: cherry: Add platform thermal configuration

Nícolas F. R. A. Prado <nfraprado@collabora.com>
    arm64: dts: mediatek: mt8195: Add missing gce-client-reg to mutex1

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

David Howells <dhowells@redhat.com>
    cifs: Fix reacquisition of volume cookie on still-live connection


-------------

Diffstat:

 Documentation/admin-guide/kdump/vmcoreinfo.rst     |   6 +-
 Documentation/admin-guide/sysctl/net.rst           |   5 +
 Makefile                                           |   4 +-
 arch/Kconfig                                       |   8 +
 arch/arc/boot/dts/hsdk.dts                         |   1 -
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts     |   8 +-
 .../boot/dts/nxp/imx/imx6ull-tarragon-common.dtsi  |   1 +
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts        |   8 +-
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |   3 +-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           |  34 ++--
 .../boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts  |   6 +-
 arch/arm64/boot/dts/mediatek/mt7986a.dtsi          | 215 ++++++++++-----------
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi     |   1 -
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |   1 +
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi   |   6 +-
 arch/arm64/boot/dts/mediatek/mt8192.dtsi           |   1 +
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi    | 141 +++++++++++++-
 arch/arm64/boot/dts/mediatek/mt8195.dtsi           |   5 +
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              |   2 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |   5 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  16 +-
 .../boot/dts/rockchip/rk3399-pinebook-pro.dts      |   1 -
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      |  31 ++-
 arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts |   6 +-
 arch/arm64/kvm/hyp/include/nvhe/gfp.h              |   2 +-
 arch/loongarch/include/asm/perf_event.h            |   8 +
 arch/loongarch/mm/fault.c                          |   4 +-
 arch/riscv/include/asm/page.h                      |   2 +-
 arch/riscv/include/asm/pgtable.h                   |   4 +-
 arch/riscv/kernel/setup.c                          |  13 ++
 arch/riscv/mm/init.c                               |   2 +-
 arch/sparc/kernel/traps_64.c                       |   2 +-
 arch/x86/Kconfig                                   |  11 +-
 arch/x86/include/asm/coco.h                        |   5 +-
 arch/x86/include/asm/pgtable_types.h               |   3 +-
 arch/x86/kernel/process_64.c                       |   2 +-
 arch/x86/kvm/pmu.c                                 |  30 ++-
 arch/x86/kvm/vmx/pmu_intel.c                       |  16 +-
 drivers/acpi/cppc_acpi.c                           |  72 +++++--
 drivers/bluetooth/btmtk.c                          |   7 +-
 drivers/bluetooth/btusb.c                          |  11 +-
 drivers/bluetooth/hci_qca.c                        |  27 ++-
 drivers/cxl/core/mbox.c                            |  38 ++--
 drivers/dma/idma64.c                               |   4 +
 drivers/dma/idxd/cdev.c                            |   5 +-
 drivers/dma/idxd/debugfs.c                         |   4 +-
 drivers/dma/idxd/device.c                          |   8 +-
 drivers/dma/idxd/idxd.h                            |   2 +-
 drivers/dma/idxd/init.c                            |   2 +-
 drivers/dma/idxd/irq.c                             |   4 +-
 drivers/dma/idxd/perfmon.c                         |   9 +-
 drivers/dma/owl-dma.c                              |   4 +-
 drivers/dma/tegra186-gpc-dma.c                     |   3 +
 drivers/dma/xilinx/xilinx_dpdma.c                  |  13 +-
 drivers/gpio/gpio-tangier.c                        |   9 +-
 drivers/gpio/gpio-tegra186.c                       |  20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c         |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  33 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |  28 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  73 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |   3 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c           |   3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |  24 ++-
 drivers/gpu/drm/gma500/Makefile                    |   1 -
 drivers/gpu/drm/gma500/psb_device.c                |   5 +-
 drivers/gpu/drm/gma500/psb_drv.h                   |   9 -
 drivers/gpu/drm/gma500/psb_lid.c                   |  80 --------
 drivers/gpu/drm/ttm/tests/ttm_device_test.c        |   2 +-
 drivers/gpu/drm/ttm/ttm_pool.c                     |  54 ++++--
 drivers/hid/hid-logitech-dj.c                      |   4 +-
 drivers/hid/i2c-hid/i2c-hid-core.c                 |   9 -
 drivers/hid/intel-ish-hid/ipc/ipc.c                |   2 +-
 drivers/i2c/i2c-core-base.c                        |  12 +-
 drivers/irqchip/irq-gic-v3-its.c                   |   9 +-
 drivers/mmc/host/sdhci-msm.c                       |  16 +-
 drivers/mtd/nand/raw/diskonchip.c                  |   4 +-
 drivers/mtd/nand/raw/qcom_nandc.c                  |   7 +-
 drivers/net/dsa/mv88e6xxx/chip.c                   |  56 +++++-
 drivers/net/dsa/mv88e6xxx/port.h                   |  23 ++-
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c   |  21 +-
 drivers/net/ethernet/broadcom/b44.c                |  14 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |  80 ++++----
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   6 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  30 ++-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c        |  16 +-
 .../ethernet/mellanox/mlx5/core/en_accel/macsec.c  |   1 +
 drivers/net/ethernet/mellanox/mlxsw/core.c         |   2 +-
 .../mellanox/mlxsw/core_acl_flex_actions.c         |  16 +-
 .../ethernet/mellanox/mlxsw/core_acl_flex_keys.c   |   9 +-
 drivers/net/ethernet/mellanox/mlxsw/core_env.c     |  20 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c |  11 +-
 .../ethernet/mellanox/mlxsw/spectrum_acl_tcam.c    | 132 ++++++++-----
 .../ethernet/mellanox/mlxsw/spectrum_acl_tcam.h    |   5 +-
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |  15 +-
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |   8 +-
 drivers/net/ethernet/ti/am65-cpts.c                |   5 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c       |   8 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        |   2 +-
 drivers/net/gtp.c                                  |   3 +-
 drivers/net/macsec.c                               |  46 ++++-
 drivers/net/phy/dp83869.c                          |   3 +-
 drivers/net/phy/mediatek-ge-soc.c                  |  43 +++--
 drivers/net/usb/ax88179_178a.c                     |  11 +-
 drivers/net/vxlan/vxlan_core.c                     |   4 +
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |   3 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |   2 +-
 drivers/nfc/trf7970a.c                             |  42 ++--
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c         |   6 +-
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c       |   9 +-
 drivers/phy/qualcomm/phy-qcom-m31.c                |   2 +-
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          |  12 +-
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   2 +
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c |  36 +++-
 drivers/phy/rockchip/phy-rockchip-snps-pcie3.c     |  31 ++-
 drivers/phy/ti/phy-tusb1210.c                      |  23 +--
 drivers/soundwire/amd_manager.c                    |  15 ++
 drivers/soundwire/amd_manager.h                    |   3 +-
 drivers/video/fbdev/core/fb_defio.c                |   2 +-
 fs/btrfs/backref.c                                 |  12 +-
 fs/btrfs/extent_map.c                              |   2 +-
 fs/btrfs/inode.c                                   |  13 +-
 fs/btrfs/scrub.c                                   |  18 +-
 fs/btrfs/tests/extent-map-tests.c                  |   5 +
 fs/overlayfs/params.c                              |  11 +-
 fs/proc/page.c                                     |   7 +-
 fs/smb/client/cifsfs.c                             |   1 +
 fs/smb/client/cifsglob.h                           |   2 +
 fs/smb/client/cifspdu.h                            |   4 +-
 fs/smb/client/fs_context.c                         |  12 ++
 fs/smb/client/fs_context.h                         |   2 +
 fs/smb/client/fscache.c                            |  13 ++
 fs/smb/client/misc.c                               |   3 +
 fs/smb/client/smb2pdu.h                            |   2 +-
 fs/smb/client/transport.c                          |   7 +-
 fs/squashfs/inode.c                                |  11 +-
 include/drm/drm_gem.h                              |  13 ++
 include/drm/ttm/ttm_pool.h                         |   2 +-
 include/linux/etherdevice.h                        |  25 +++
 include/linux/mm.h                                 |   8 +-
 include/linux/mmzone.h                             |   6 +-
 include/linux/page-flags.h                         | 146 ++++++++------
 include/net/af_unix.h                              |   3 +
 include/net/bluetooth/hci_core.h                   |   4 +
 include/net/macsec.h                               |   1 +
 include/net/sock.h                                 |  41 ++--
 include/net/tls.h                                  |   3 +-
 include/trace/events/mmflags.h                     |   1 +
 init/Kconfig                                       |   2 +-
 kernel/bounds.c                                    |   2 +-
 kernel/cpu.c                                       |   4 +-
 kernel/crash_core.c                                |   7 +-
 kernel/fork.c                                      |  18 +-
 kernel/sched/fair.c                                |  34 ++--
 lib/stackdepot.c                                   |   4 +-
 lib/test_meminit.c                                 |   2 +-
 mm/compaction.c                                    |   2 +-
 mm/gup.c                                           |  59 +++---
 mm/hugetlb.c                                       |  27 +--
 mm/internal.h                                      |  11 +-
 mm/kmsan/init.c                                    |   2 +-
 mm/madvise.c                                       |  17 +-
 mm/page_alloc.c                                    |  13 +-
 mm/page_reporting.c                                |   2 +-
 mm/show_mem.c                                      |   8 +-
 mm/vmstat.c                                        |  12 +-
 net/ax25/af_ax25.c                                 |   2 +-
 net/bluetooth/hci_event.c                          |   5 +-
 net/bluetooth/l2cap_sock.c                         |   7 +-
 net/bluetooth/mgmt.c                               |  24 ++-
 net/bluetooth/sco.c                                |   7 +-
 net/bridge/br_netlink.c                            |   2 +-
 net/core/sock.c                                    |   1 +
 net/core/sysctl_net_core.c                         |   9 +
 net/ethernet/eth.c                                 |  12 +-
 net/ipv4/icmp.c                                    |  12 +-
 net/ipv4/route.c                                   |   3 +
 net/ipv4/udp.c                                     |   5 +-
 net/ipv6/udp.c                                     |   5 +-
 net/mac80211/mesh.c                                |   8 +-
 net/mac80211/mesh.h                                |  36 +++-
 net/mac80211/mesh_pathtbl.c                        |  37 ++--
 net/mac80211/mlme.c                                |   9 +-
 net/mac80211/rx.c                                  |  13 +-
 net/netfilter/ipvs/ip_vs_proto_sctp.c              |   6 +-
 net/netfilter/nft_chain_filter.c                   |   4 +-
 net/openvswitch/conntrack.c                        |   4 +-
 net/tls/tls.h                                      |   2 +-
 net/tls/tls_strp.c                                 |   6 +-
 net/unix/garbage.c                                 |   2 +-
 rust/Makefile                                      |   1 -
 rust/kernel/init.rs                                |  11 +-
 rust/macros/lib.rs                                 |  12 --
 scripts/Makefile.build                             |   2 +-
 tools/net/ynl/lib/ynl.py                           |   1 +
 tools/testing/selftests/seccomp/seccomp_bpf.c      |  41 +++-
 198 files changed, 1787 insertions(+), 1132 deletions(-)



