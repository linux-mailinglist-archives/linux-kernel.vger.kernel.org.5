Return-Path: <linux-kernel+bounces-83378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BE4869690
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E000F294F3C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330D978B61;
	Tue, 27 Feb 2024 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FzMNJZim"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342B71420D4;
	Tue, 27 Feb 2024 14:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043169; cv=none; b=sMNKkIXV48ptp4f9aBqaho6cRqEXzZxqcBC5JevN4QiLMaX8TFjEewbVTMZk+g1dN91b4euTfvSEEda5aHxCjfpemEZn2YGsKFU1vJZV5UkaGvz77vbvLc5OrWDS69pl970IQQQWZBsnJ+n1GZpNu1nQm06A+id2tolh67VcQeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043169; c=relaxed/simple;
	bh=0ZzTiGhXh7LXTvd1Dn/pYy5aE9WVghzsbLbfeNWKLBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fd2EFgDWMrKwRiHbLFNssiEtRKuuGA26OU+FOytWosdOdgH1WPkaWfS/ISuq+9UdyKUOimqCxEBZlF98dcSYDAcggmjmHuO6QDg1bTq2GAgbw6Z2uVXG9b4N6bCehVyyCjTWm11/vbJDSKeyS7v7af3hm+kmEBrB5hj1nqS+kNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FzMNJZim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A19C43394;
	Tue, 27 Feb 2024 14:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043168;
	bh=0ZzTiGhXh7LXTvd1Dn/pYy5aE9WVghzsbLbfeNWKLBE=;
	h=From:To:Cc:Subject:Date:From;
	b=FzMNJZim/6yr6GkU1OrZ0M4TUgg8bC2QeTIjxkKB7QLBwEH++ERCK5fD6Vy56iXHF
	 qbTFlDa037BsMPVl73OCrg/DcQPzfD0WqHqJemcb8T6q87yivSHfo5qHXbn959bVmQ
	 MBm7oLcmyi6iDkbA1OsUzFjeJAhupv9JAqAkg+TE=
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
	allen.lkml@gmail.com
Subject: [PATCH 6.1 000/195] 6.1.80-rc1 review
Date: Tue, 27 Feb 2024 14:24:21 +0100
Message-ID: <20240227131610.391465389@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.80-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.80-rc1
X-KernelTest-Deadline: 2024-02-29T13:16+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.1.80 release.
There are 195 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.80-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.80-rc1

Edward Lo <edward.lo@ambergroup.io>
    fs/ntfs3: Enhance the attribute size check

Kuniyuki Iwashima <kuniyu@amazon.com>
    arp: Prevent overflow in arp_req_get().

Lennert Buytenhek <kernel@wantstofly.org>
    ahci: Extend ASM1061 43-bit DMA address quirk to other ASM106x parts

Szuying Chen <chensiying21@gmail.com>
    ata: ahci: add identifiers for ASM2116 series adapters

Geliang Tang <tanggeliang@kylinos.cn>
    mptcp: add needs_id for netlink appending addr

Geliang Tang <geliang.tang@suse.com>
    mptcp: userspace pm send RM_ADDR for ID 0

Yosry Ahmed <yosryahmed@google.com>
    mm: zswap: fix missing folio cleanup in writeback race path

Bart Van Assche <bvanassche@acm.org>
    fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio

SeongJae Park <sj@kernel.org>
    mm/damon/reclaim: fix quota stauts loss due to online tunings

Gao Xiang <xiang@kernel.org>
    erofs: fix inconsistent per-file compression format

Gao Xiang <xiang@kernel.org>
    erofs: simplify compression configuration parser

Corey Minyard <minyard@acm.org>
    i2c: imx: when being a target, mark the last read as processed

Armin Wolf <W_Armin@gmx.de>
    drm/amd/display: Fix memory leak in dm_sw_fini()

Erik Kurzinger <ekurzinger@nvidia.com>
    drm/syncobj: call drm_syncobj_fence_add_wait when WAIT_AVAILABLE flag is set

Siddharth Vadapalli <s-vadapalli@ti.com>
    net: phy: realtek: Fix rtl8211f_config_init() for RTL8211F(D)(I)-VD-CG PHY

Justin Iurman <justin.iurman@uliege.be>
    Fix write to cloned skb in ipv6_hop_ioam()

Rémi Denis-Courmont <courmisch@gmail.com>
    phonet/pep: fix racy skb_queue_empty() use

Rémi Denis-Courmont <courmisch@gmail.com>
    phonet: take correct lock to peek at the RX queue

Horatiu Vultur <horatiu.vultur@microchip.com>
    net: sparx5: Add spinlock for frame transmission from CPU

Jeremy Kerr <jk@codeconstruct.com.au>
    net: mctp: put sock on tag allocation failure

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: use kzalloc for hook allocation

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: register hooks last when adding new chain/flowtable

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: rename function to destroy hook list

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_flow_offload: release dst in case direct xmit path is used

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_flow_offload: reset dst in route object after setting up flow

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: flowtable: simplify route logic

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: set dormant flag on hook register failure

Sabrina Dubroca <sd@queasysnail.net>
    tls: don't skip over different type records from the rx_list

Sabrina Dubroca <sd@queasysnail.net>
    tls: stop recv() if initial process_rx_list gave us non-DATA

Sabrina Dubroca <sd@queasysnail.net>
    tls: break out of main loop when PEEK gets a non-data record

Shigeru Yoshida <syoshida@redhat.com>
    bpf, sockmap: Fix NULL pointer dereference in sk_psock_verdict_data_ready()

Jason Gunthorpe <jgg@ziepe.ca>
    s390: use the correct count for __iowrite64_copy()

Subbaraya Sundeep <sbhatta@marvell.com>
    octeontx2-af: Consider the action set by PF

Mario Limonciello <mario.limonciello@amd.com>
    platform/x86: thinkpad_acpi: Only update profile if successfully converted

Mark Brown <broonie@kernel.org>
    arm64/sme: Restore SME registers on exit from suspend

Kees Cook <keescook@chromium.org>
    net: dev: Convert sa_data to flexible array in struct sockaddr

Vasiliy Kovalev <kovalev@altlinux.org>
    ipv6: sr: fix possible use-after-free and null-ptr-deref

Daniil Dulov <d.dulov@aladdin.ru>
    afs: Increase buffer size in afs_update_volume_status()

Martin KaFai Lau <martin.lau@kernel.org>
    bpf: Fix racing between bpf_timer_cancel_and_free and bpf_timer_cancel

Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
    ata: ahci_ceva: fix error handling for Xilinx GT PHY support

Eric Dumazet <edumazet@google.com>
    ipv6: properly combine dev_base_seq and ipv6.dev_addr_genid

Eric Dumazet <edumazet@google.com>
    ipv4: properly combine dev_base_seq and ipv4.dev_addr_genid

Pavel Sakharov <p.sakharov@ispras.ru>
    net: stmmac: Fix incorrect dereference in interrupt handlers

Alison Schofield <alison.schofield@intel.com>
    x86/numa: Fix the sort compare func used in numa_fill_memblks()

Alison Schofield <alison.schofield@intel.com>
    x86/numa: Fix the address overlap check in numa_fill_memblks()

Arnd Bergmann <arnd@arndb.de>
    nouveau: fix function cast warnings

Randy Dunlap <rdunlap@infradead.org>
    net: ethernet: adi: requires PHYLIB support

Kuniyuki Iwashima <kuniyu@amazon.com>
    dccp/tcp: Unhash sk from ehash for tb2 alloc failure after check_estalblished().

Tobias Waldekranz <tobias@waldekranz.com>
    net: bridge: switchdev: Ensure deferred event delivery on unoffload

Tobias Waldekranz <tobias@waldekranz.com>
    net: bridge: switchdev: Skip MDB replays of deferred events on offload

Randy Dunlap <rdunlap@infradead.org>
    scsi: jazz_esp: Only build if SCSI core is builtin

Don Brace <don.brace@microchip.com>
    scsi: smartpqi: Fix disable_managed_interrupts

Gianmarco Lusvardi <glusvardi@posteo.net>
    bpf, scripts: Correct GPL license name

Arnd Bergmann <arnd@arndb.de>
    RDMA/srpt: fix function pointer cast warnings

Heiko Stuebner <heiko.stuebner@cherry.de>
    arm64: dts: rockchip: set num-cs property for spi on px30

Kamal Heib <kheib@redhat.com>
    RDMA/qedr: Fix qedr_create_user_qp error flow

Joao Martins <joao.m.martins@oracle.com>
    iommufd/iova_bitmap: Consider page offset for the pages to be pinned

Joao Martins <joao.m.martins@oracle.com>
    iommufd/iova_bitmap: Switch iova_bitmap::bitmap to an u8 array

Joao Martins <joao.m.martins@oracle.com>
    iommufd/iova_bitmap: Bounds check mapped::pages access

Bart Van Assche <bvanassche@acm.org>
    RDMA/srpt: Support specifying the srpt_service_guid parameter

Mustafa Ismail <mustafa.ismail@intel.com>
    RDMA/irdma: Add AE for too many RNRS

Mustafa Ismail <mustafa.ismail@intel.com>
    RDMA/irdma: Set the CQ read threshold for GEN 1

Shiraz Saleem <shiraz.saleem@intel.com>
    RDMA/irdma: Validate max_send_wr and max_recv_wr

Mike Marciniszyn <mike.marciniszyn@intel.com>
    RDMA/irdma: Fix KASAN issue with tasklet

Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
    RDMA/bnxt_re: Return error for SRQ resize

Zhipeng Lu <alexious@zju.edu.cn>
    IB/hfi1: Fix a memleak in init_credit_return

Sohaib Nadeem <sohaib.nadeem@amd.com>
    Revert "drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz"

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix lockless access in subflow ULP diag

Geliang Tang <tanggeliang@kylinos.cn>
    mptcp: add needs_id for userspace appending addr

Geliang Tang <geliang.tang@suse.com>
    mptcp: make userspace_pm_append_new_local_addr static

Xu Yang <xu.yang_2@nxp.com>
    usb: roles: don't get/set_role() when usb_role_switch is unregistered

Xu Yang <xu.yang_2@nxp.com>
    usb: roles: fix NULL pointer issue when put module's reference

Krishna Kurapati <quic_kriskura@quicinc.com>
    usb: gadget: ncm: Avoid dropping datagrams of properly parsed NTBs

Frank Li <Frank.Li@nxp.com>
    usb: cdns3: fix memory double free when handle zero packet

Frank Li <Frank.Li@nxp.com>
    usb: cdns3: fixed memory use after free at cdns3_gadget_ep_disable()

Pawel Laszczak <pawell@cadence.com>
    usb: cdnsp: fixed issue with incorrect detecting CDNSP family controllers

Pawel Laszczak <pawell@cadence.com>
    usb: cdnsp: blocked some cdns3 specific code

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: gadget: Don't disconnect if not started

Lino Sanfilippo <l.sanfilippo@kunbus.com>
    serial: amba-pl011: Fix DMA transmission in RS485 mode

Sandeep Dhavale <dhavale@google.com>
    erofs: fix refcount on the metabuf used for inode lookup

Arnd Bergmann <arnd@arndb.de>
    dm-integrity, dm-verity: reduce stack usage for recheck

Peter Zijlstra <peterz@infradead.org>
    x86/alternative: Make custom return thunk unconditional

Borislav Petkov (AMD) <bp@alien8.de>
    Revert "x86/alternative: Make custom return thunk unconditional"

Peter Zijlstra <peterz@infradead.org>
    x86/returnthunk: Allow different return thunks

Nikita Shubin <nikita.shubin@maquefel.me>
    ARM: ep93xx: Add terminator to gpiod_lookup_table

Tom Parkin <tparkin@katalix.com>
    l2tp: pass correct message length to ip6_append_data

Vidya Sagar <vidyas@nvidia.com>
    PCI/MSI: Prevent MSI hardware interrupt number truncation

Nam Cao <namcao@linutronix.de>
    irqchip/sifive-plic: Enable interrupt if needed before EOI

Oliver Upton <oliver.upton@linux.dev>
    irqchip/gic-v3-its: Do not assume vPE tables are preallocated

zhenwei pi <pizhenwei@bytedance.com>
    crypto: virtio/akcipher - Fix stack overflow on memcpy

Vasiliy Kovalev <kovalev@altlinux.org>
    gtp: fix use-after-free and null-ptr-deref in gtp_genl_dump_pdp()

Oliver Upton <oliver.upton@linux.dev>
    KVM: arm64: vgic-its: Test for valid IRQ in its_sync_lpi_pending_table()

Oliver Upton <oliver.upton@linux.dev>
    KVM: arm64: vgic-its: Test for valid IRQ in MOVALL handler

Yu Kuai <yukuai3@huawei.com>
    md: Fix missing release of 'active_io' for flush

Baokun Li <libaokun1@huawei.com>
    cachefiles: fix memory leak in cachefiles_add_cache()

Hans de Goede <hdegoede@redhat.com>
    platform/x86: touchscreen_dmi: Allow partial (prefix) matches for ACPI names

Hans de Goede <hdegoede@redhat.com>
    platform/x86: intel-vbtn: Stop calling "VBDL" from notify_handler

Johannes Weiner <hannes@cmpxchg.org>
    mm: memcontrol: clarify swapaccount=0 deprecation warning

SeongJae Park <sj@kernel.org>
    mm/damon/lru_sort: fix quota status loss due to online tunings

Kairui Song <kasong@tencent.com>
    mm/swap: fix race when skipping swapcache

Martin K. Petersen <martin.petersen@oracle.com>
    scsi: core: Consult supported VPD page list prior to fetching page

Naohiro Aota <naohiro.aota@wdc.com>
    scsi: target: pscsi: Fix bio_put() for error case

Robert Richter <rrichter@amd.com>
    cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS window

Mikulas Patocka <mpatocka@redhat.com>
    dm-verity: recheck the hash after a failure

Mikulas Patocka <mpatocka@redhat.com>
    dm-crypt: don't modify the data when using authenticated encryption

Mikulas Patocka <mpatocka@redhat.com>
    dm-integrity: recheck the integrity tag after a failure

Helge Deller <deller@gmx.de>
    Revert "parisc: Only list existing CPUs in cpu_possible_mask"

Mikulas Patocka <mpatocka@redhat.com>
    dm-crypt: recheck the integrity tag after a failure

Damien Le Moal <dlemoal@kernel.org>
    ata: libata-core: Do not try to set sleeping devices to standby

Peter Oberparleiter <oberpar@linux.ibm.com>
    s390/cio: fix invalid -EBUSY on ccw_device_start

Thomas Hellström <thomas.hellstrom@linux.intel.com>
    drm/ttm: Fix an invalid freeing on already freed page in error path

Huacai Chen <chenhuacai@kernel.org>
    LoongArch: Disable IRQ before init_fn() for nonboot CPUs

Daniel Vacek <neelx@redhat.com>
    IB/hfi1: Fix sdma.h tx->num_descs off-by-one error

Geert Uytterhoeven <geert+renesas@glider.be>
    pmdomain: renesas: r8a77980-sysc: CR7 must be always on

Eugen Hristev <eugen.hristev@collabora.com>
    pmdomain: mediatek: fix race conditions with genpd

Steve French <stfrench@microsoft.com>
    smb3: clarify mount warning

Yi Sun <yi.sun@unisoc.com>
    virtio-blk: Ensure no requests in virtqueues before deleting vqs.

Paulo Alcantara <pc@manguebit.com>
    smb: client: set correct d_type for reparse points under DFS mounts

Prike Liang <Prike.Liang@amd.com>
    drm/amdgpu: reset gpu for s3 suspend abort case

Prike Liang <Prike.Liang@amd.com>
    drm/amdgpu: skip to program GFXDEC registers for suspend abort

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    firewire: core: send bus reset promptly on gap count error

Masahiro Yamada <masahiroy@kernel.org>
    LoongArch: Select HAVE_ARCH_SECCOMP to use the common SECCOMP menu

Masahiro Yamada <masahiroy@kernel.org>
    LoongArch: Select ARCH_ENABLE_THP_MIGRATION instead of redefining it

SEO HOYOUNG <hy50.seo@samsung.com>
    scsi: ufs: core: Remove the ufshcd_release() in ufshcd_err_handling_prepare()

Hannes Reinecke <hare@suse.de>
    scsi: lpfc: Use unsigned type for num_sge

Zhang Rui <rui.zhang@intel.com>
    hwmon: (coretemp) Enlarge per package core count limit

Andrew Bresticker <abrestic@rivosinc.com>
    efi: Don't add memblocks for soft-reserved memory

Andrew Bresticker <abrestic@rivosinc.com>
    efi: runtime: Fix potential overflow of soft-reserved region size

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: adding missing drv_mgd_complete_tx() call

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: set station RX-NSS on reconfig

Edward Adam Davis <eadavis@qq.com>
    fs/ntfs3: Fix oob in ntfs_listxattr

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Update inode->i_size after success write into compressed file

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Correct function is_rst_area_valid

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Prevent generic message "attempt to access beyond end of device"

Ism Hong <ism.hong@gmail.com>
    fs/ntfs3: use non-movable memory for ntfs3 MFT buffer cache

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Disable ATTR_LIST_ENTRY size check

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Add NULL ptr dereference checking at the end of attr_allocate_frame()

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Fix detected field-spanning write (size 8) of single field "le->name"

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Print warning while fixing hard links count

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Correct hard links updating when dealing with DOS names

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Improve ntfs_dir_count

Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
    fs/ntfs3: Modified fix directory element type detection

Szilard Fabian <szfabian@bluemarch.art>
    Input: i8042 - add Fujitsu Lifebook U728 to i8042 quirk table

Zhang Yi <yi.zhang@huawei.com>
    ext4: correct the hole length returned by ext4_map_blocks()

Paulo Alcantara <pc@manguebit.com>
    smb: client: increase number of PDUs allowed in a compound request

Daniel Wagner <dwagner@suse.de>
    nvmet-fc: take ref count on tgtport before delete assoc

Daniel Wagner <dwagner@suse.de>
    nvmet-fc: avoid deadlock on delete association path

Daniel Wagner <dwagner@suse.de>
    nvmet-fc: abort command when there is no binding

Daniel Wagner <dwagner@suse.de>
    nvmet-fc: hold reference on hostport match

Daniel Wagner <dwagner@suse.de>
    nvmet-fc: defer cleanup using RCU properly

Daniel Wagner <dwagner@suse.de>
    nvmet-fc: release reference on target port

Daniel Wagner <dwagner@suse.de>
    nvmet-fcloop: swap the list_add_tail arguments

Daniel Wagner <dwagner@suse.de>
    nvme-fc: do not wait in vain when unloading module

Alexander Tsoy <alexander@tsoy.me>
    ALSA: usb-audio: Ignore clock selector errors for single connection

Richard Fitzgerald <rf@opensource.cirrus.com>
    ASoC: wm_adsp: Don't overwrite fwf_name with the default

Sohaib Nadeem <sohaib.nadeem@amd.com>
    drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz

Xin Long <lucien.xin@gmail.com>
    netfilter: conntrack: check SCTP_CID_SHUTDOWN_ACK for vtag setting in sctp_new

Will Deacon <will@kernel.org>
    misc: open-dice: Fix spurious lockdep warning

Brenton Simpson <appsforartists@google.com>
    Input: xpad - add Lenovo Legion Go controllers

Wolfram Sang <wsa+renesas@sang-engineering.com>
    spi: sh-msiof: avoid integer overflow in constants

Chen-Yu Tsai <wens@csie.org>
    ASoC: sunxi: sun4i-spdif: Add support for Allwinner H616

Alexander Tsoy <alexander@tsoy.me>
    ALSA: usb-audio: Check presence of valid altsetting control

Christian A. Ehrhardt <lk@c--e.de>
    usb: ucsi_acpi: Quirk to ack a connector change ack cmd

Guixin Liu <kanie@linux.alibaba.com>
    nvmet-tcp: fix nvme tcp ida memory leak

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    regulator: pwm-regulator: Add validity checks in continuous .get_voltage

Kunwu Chan <chentao@kylinos.cn>
    dmaengine: ti: edma: Add some null pointer checks to the edma_probe

Hans de Goede <hdegoede@redhat.com>
    Input: goodix - accept ACPI resources with gpio_count == 3 && gpio_int_idx == 0

Baokun Li <libaokun1@huawei.com>
    ext4: avoid allocating blocks from corrupted group in ext4_mb_find_by_goal()

Baokun Li <libaokun1@huawei.com>
    ext4: avoid allocating blocks from corrupted group in ext4_mb_try_best_found()

Baokun Li <libaokun1@huawei.com>
    ext4: avoid dividing by 0 in mb_update_avg_fragment_size() when block bitmap corrupt

Phoenix Chen <asbeltogf@gmail.com>
    platform/x86: touchscreen_dmi: Add info for the TECLAST X16 Plus tablet

Huang Pei <huangpei@loongson.cn>
    MIPS: reserve exception vector space ONLY ONCE

Lennert Buytenhek <kernel@wantstofly.org>
    ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers

Maksim Kiselev <bigunclemax@gmail.com>
    aoe: avoid potential deadlock at set_capacity

Conrad Kostecki <conikost@gentoo.org>
    ahci: asm1166: correct count of reported ports

Shyam Prasad N <sprasad@microsoft.com>
    cifs: translate network errors on send to -ECONNABORTED

Kees Cook <keescook@chromium.org>
    smb: Work around Clang __bdos() type confusion

Christian A. Ehrhardt <lk@c--e.de>
    block: Fix WARNING in _copy_from_iter

Devyn Liu <liudingyuan@huawei.com>
    spi: hisi-sfc-v3xx: Return IRQ_NONE if no interrupts were detected

Fullway Wang <fullwaywang@outlook.com>
    fbdev: sis: Error out if pixclock equals zero

Fullway Wang <fullwaywang@outlook.com>
    fbdev: savage: Error out if pixclock equals zero

Felix Fietkau <nbd@nbd.name>
    wifi: mac80211: fix race condition on enabling fast-xmit

Michal Kazior <michal@plume.com>
    wifi: cfg80211: fix missing interfaces when dumping

Vinod Koul <vkoul@kernel.org>
    dmaengine: fsl-qdma: increase size of 'irq_name'

Vinod Koul <vkoul@kernel.org>
    dmaengine: shdma: increase size of 'dev_id'

Shyam Prasad N <sprasad@microsoft.com>
    cifs: open_cached_dir should not rely on primary channel

Dmitry Bogdanov <d.bogdanov@yadro.com>
    scsi: target: core: Add TMF to tmr_list handling

Hector Martin <marcan@marcan.st>
    dmaengine: apple-admac: Keep upper bits of REG_BUS_WIDTH

Jan Kiszka <jan.kiszka@siemens.com>
    riscv/efistub: Ensure GP-relative addressing is not used

Dan Carpenter <dan.carpenter@linaro.org>
    PCI: dwc: Fix a 64bit bug in dw_pcie_ep_raise_msix_irq()

Cyril Hrubis <chrubis@suse.cz>
    sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset

Cyril Hrubis <chrubis@suse.cz>
    sched/rt: Disallow writing invalid values to sched_rt_period_us

Jamal Hadi Salim <jhs@mojatatu.com>
    net/sched: Retire dsmark qdisc

Jamal Hadi Salim <jhs@mojatatu.com>
    net/sched: Retire ATM qdisc

Jamal Hadi Salim <jhs@mojatatu.com>
    net/sched: Retire CBQ qdisc


-------------

Diffstat:

 Makefile                                           |    4 +-
 arch/arm/mach-ep93xx/core.c                        |    1 +
 arch/arm64/boot/dts/rockchip/px30.dtsi             |    2 +
 arch/arm64/include/asm/fpsimd.h                    |    2 +
 arch/arm64/kernel/fpsimd.c                         |   14 +
 arch/arm64/kernel/suspend.c                        |    3 +
 arch/arm64/kvm/vgic/vgic-its.c                     |    5 +
 arch/loongarch/Kconfig                             |   23 +-
 arch/loongarch/kernel/smp.c                        |    1 +
 arch/mips/kernel/traps.c                           |    8 +-
 arch/parisc/kernel/processor.c                     |    8 -
 arch/s390/pci/pci.c                                |    2 +-
 arch/x86/include/asm/nospec-branch.h               |    2 +
 arch/x86/kernel/alternative.c                      |   13 +-
 arch/x86/kernel/ftrace.c                           |    2 +-
 arch/x86/kernel/static_call.c                      |    2 +-
 arch/x86/mm/numa.c                                 |   21 +-
 arch/x86/net/bpf_jit_comp.c                        |    2 +-
 block/blk-map.c                                    |   13 +-
 drivers/ata/ahci.c                                 |   49 +-
 drivers/ata/ahci.h                                 |    1 +
 drivers/ata/ahci_ceva.c                            |  125 +-
 drivers/ata/libata-core.c                          |    4 +
 drivers/block/aoe/aoeblk.c                         |    5 +-
 drivers/block/virtio_blk.c                         |    7 +-
 .../crypto/virtio/virtio_crypto_akcipher_algs.c    |    5 +-
 drivers/cxl/core/pci.c                             |    6 +-
 drivers/dma/apple-admac.c                          |    5 +-
 drivers/dma/fsl-qdma.c                             |    2 +-
 drivers/dma/sh/shdma.h                             |    2 +-
 drivers/dma/ti/edma.c                              |   10 +
 drivers/firewire/core-card.c                       |   18 +-
 drivers/firmware/efi/arm-runtime.c                 |    2 +-
 drivers/firmware/efi/efi-init.c                    |   19 +-
 drivers/firmware/efi/libstub/Makefile              |    2 +-
 drivers/firmware/efi/riscv-runtime.c               |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |    2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |    2 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |    8 +
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   22 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |    1 +
 drivers/gpu/drm/drm_syncobj.c                      |    6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadow.c  |    8 +-
 drivers/gpu/drm/ttm/ttm_pool.c                     |    2 +-
 drivers/hwmon/coretemp.c                           |    2 +-
 drivers/i2c/busses/i2c-imx.c                       |    5 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c           |    5 +-
 drivers/infiniband/hw/hfi1/pio.c                   |    6 +-
 drivers/infiniband/hw/hfi1/sdma.c                  |    2 +-
 drivers/infiniband/hw/irdma/defs.h                 |    1 +
 drivers/infiniband/hw/irdma/hw.c                   |    8 +
 drivers/infiniband/hw/irdma/verbs.c                |    9 +-
 drivers/infiniband/hw/qedr/verbs.c                 |   11 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c              |   17 +-
 drivers/input/joystick/xpad.c                      |    2 +
 drivers/input/serio/i8042-acpipnpio.h              |    8 +
 drivers/input/touchscreen/goodix.c                 |    3 +-
 drivers/irqchip/irq-gic-v3-its.c                   |    2 +-
 drivers/irqchip/irq-sifive-plic.c                  |    8 +-
 drivers/md/dm-crypt.c                              |   95 +-
 drivers/md/dm-integrity.c                          |   91 +-
 drivers/md/dm-verity-target.c                      |   86 +-
 drivers/md/dm-verity.h                             |    6 +
 drivers/md/md.c                                    |    6 +-
 drivers/misc/open-dice.c                           |    2 +-
 drivers/net/ethernet/adi/Kconfig                   |    1 +
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |    4 +
 .../net/ethernet/microchip/sparx5/sparx5_main.c    |    1 +
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |    1 +
 .../net/ethernet/microchip/sparx5/sparx5_packet.c  |    2 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   20 -
 drivers/net/gtp.c                                  |   10 +-
 drivers/net/phy/realtek.c                          |    4 +-
 drivers/nvme/host/fc.c                             |   47 +-
 drivers/nvme/target/fc.c                           |  131 +-
 drivers/nvme/target/fcloop.c                       |    6 +-
 drivers/nvme/target/tcp.c                          |    1 +
 drivers/pci/controller/dwc/pcie-designware-ep.c    |    3 +-
 drivers/pci/msi/irqdomain.c                        |    2 +-
 drivers/platform/x86/intel/vbtn.c                  |    3 -
 drivers/platform/x86/thinkpad_acpi.c               |    5 +-
 drivers/platform/x86/touchscreen_dmi.c             |   39 +-
 drivers/regulator/pwm-regulator.c                  |    3 +
 drivers/s390/cio/device_ops.c                      |    6 +-
 drivers/scsi/Kconfig                               |    2 +-
 drivers/scsi/lpfc/lpfc_scsi.c                      |   12 +-
 drivers/scsi/scsi.c                                |   22 +-
 drivers/scsi/smartpqi/smartpqi_init.c              |    5 +-
 drivers/soc/mediatek/mtk-pm-domains.c              |   15 +-
 drivers/soc/renesas/r8a77980-sysc.c                |    3 +-
 drivers/spi/spi-hisi-sfc-v3xx.c                    |    5 +
 drivers/spi/spi-sh-msiof.c                         |   16 +-
 drivers/target/target_core_device.c                |    5 -
 drivers/target/target_core_pscsi.c                 |    9 +-
 drivers/target/target_core_transport.c             |    4 +
 drivers/tty/serial/amba-pl011.c                    |   60 +-
 drivers/ufs/core/ufshcd.c                          |    1 -
 drivers/usb/cdns3/cdns3-gadget.c                   |    8 +-
 drivers/usb/cdns3/core.c                           |    1 -
 drivers/usb/cdns3/drd.c                            |   13 +-
 drivers/usb/cdns3/drd.h                            |    6 +-
 drivers/usb/cdns3/host.c                           |   16 +-
 drivers/usb/dwc3/gadget.c                          |    5 +
 drivers/usb/gadget/function/f_ncm.c                |   10 +-
 drivers/usb/roles/class.c                          |   29 +-
 drivers/usb/typec/ucsi/ucsi_acpi.c                 |   71 +-
 drivers/vfio/iova_bitmap.c                         |   25 +-
 drivers/video/fbdev/savage/savagefb_driver.c       |    3 +
 drivers/video/fbdev/sis/sis_main.c                 |    2 +
 fs/afs/volume.c                                    |    4 +-
 fs/aio.c                                           |    9 +-
 fs/cachefiles/cache.c                              |    2 +
 fs/cachefiles/daemon.c                             |    1 +
 fs/erofs/compress.h                                |    4 +
 fs/erofs/decompressor.c                            |   60 +-
 fs/erofs/decompressor_lzma.c                       |    4 +-
 fs/erofs/internal.h                                |   28 +-
 fs/erofs/namei.c                                   |   28 +-
 fs/erofs/super.c                                   |   72 +-
 fs/erofs/zmap.c                                    |   23 +-
 fs/ext4/extents.c                                  |  111 +-
 fs/ext4/mballoc.c                                  |   15 +-
 fs/ntfs3/attrib.c                                  |   20 +-
 fs/ntfs3/attrlist.c                                |    8 +-
 fs/ntfs3/dir.c                                     |   40 +-
 fs/ntfs3/file.c                                    |    2 +
 fs/ntfs3/fslog.c                                   |   14 +-
 fs/ntfs3/fsntfs.c                                  |   24 +
 fs/ntfs3/inode.c                                   |    2 +-
 fs/ntfs3/ntfs.h                                    |    4 +-
 fs/ntfs3/ntfs_fs.h                                 |   14 +-
 fs/ntfs3/record.c                                  |   25 +-
 fs/ntfs3/xattr.c                                   |    3 +
 fs/smb/client/cached_dir.c                         |    2 +-
 fs/smb/client/cifsencrypt.c                        |    2 +-
 fs/smb/client/cifsglob.h                           |    2 +-
 fs/smb/client/fs_context.c                         |    2 +-
 fs/smb/client/readdir.c                            |   15 +-
 fs/smb/client/smb2pdu.c                            |    6 +
 fs/smb/client/transport.c                          |   15 +-
 include/linux/fs.h                                 |    2 +
 include/linux/memblock.h                           |    2 +
 include/linux/socket.h                             |    5 +-
 include/linux/swap.h                               |    5 +
 include/net/netfilter/nf_flow_table.h              |    4 +-
 include/net/switchdev.h                            |    3 +
 include/net/tcp.h                                  |    2 +-
 include/scsi/scsi_device.h                         |    4 -
 kernel/bpf/helpers.c                               |    5 +-
 kernel/sched/rt.c                                  |   12 +-
 mm/damon/lru_sort.c                                |   43 +-
 mm/damon/reclaim.c                                 |   18 +-
 mm/memblock.c                                      |    5 +-
 mm/memcontrol.c                                    |   10 +-
 mm/memory.c                                        |   20 +
 mm/swap.h                                          |    5 +
 mm/swapfile.c                                      |   13 +
 mm/zswap.c                                         |    2 +
 net/bridge/br_switchdev.c                          |   86 +-
 net/core/dev.c                                     |    2 +-
 net/core/dev_ioctl.c                               |    2 +-
 net/core/skmsg.c                                   |    7 +-
 net/ipv4/arp.c                                     |    3 +-
 net/ipv4/devinet.c                                 |   21 +-
 net/ipv4/inet_hashtables.c                         |   25 +-
 net/ipv6/addrconf.c                                |   21 +-
 net/ipv6/exthdrs.c                                 |   10 +
 net/ipv6/seg6.c                                    |   20 +-
 net/l2tp/l2tp_ip6.c                                |    2 +-
 net/mac80211/cfg.c                                 |    2 +
 net/mac80211/mlme.c                                |    1 +
 net/mac80211/sta_info.c                            |    2 +
 net/mac80211/tx.c                                  |    2 +-
 net/mctp/route.c                                   |    2 +-
 net/mptcp/diag.c                                   |    6 +-
 net/mptcp/pm_netlink.c                             |   24 +-
 net/mptcp/pm_userspace.c                           |   54 +-
 net/mptcp/protocol.h                               |    2 -
 net/netfilter/nf_conntrack_proto_sctp.c            |    2 +-
 net/netfilter/nf_flow_table_core.c                 |   41 +-
 net/netfilter/nf_tables_api.c                      |   87 +-
 net/netfilter/nft_flow_offload.c                   |   14 +-
 net/packet/af_packet.c                             |   10 +-
 net/phonet/datagram.c                              |    4 +-
 net/phonet/pep.c                                   |   41 +-
 net/sched/Kconfig                                  |   42 -
 net/sched/Makefile                                 |    3 -
 net/sched/sch_atm.c                                |  706 --------
 net/sched/sch_cbq.c                                | 1727 --------------------
 net/sched/sch_dsmark.c                             |  518 ------
 net/switchdev/switchdev.c                          |   73 +
 net/tls/tls_main.c                                 |    2 +-
 net/tls/tls_sw.c                                   |   24 +-
 net/wireless/nl80211.c                             |    1 +
 scripts/bpf_doc.py                                 |    2 +-
 sound/soc/codecs/wm_adsp.c                         |   29 +-
 sound/soc/sunxi/sun4i-spdif.c                      |    5 +
 sound/usb/clock.c                                  |   10 +-
 sound/usb/format.c                                 |   20 +
 .../selftests/tc-testing/tc-tests/qdiscs/atm.json  |   94 --
 .../selftests/tc-testing/tc-tests/qdiscs/cbq.json  |  184 ---
 .../tc-testing/tc-tests/qdiscs/dsmark.json         |  140 --
 202 files changed, 1956 insertions(+), 4293 deletions(-)



