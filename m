Return-Path: <linux-kernel+bounces-155933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B47A18AF91D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6441F21A42
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF5514389F;
	Tue, 23 Apr 2024 21:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rdLpxDzp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5130B143882;
	Tue, 23 Apr 2024 21:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908469; cv=none; b=hf5SWsz+z8zcT+Jg1xE7QfzrveK07O4EWg+hjwFSFSLpYHm39LI9Z6UXBIwXPMl7ti/zroo8aH6ixMWxXlbcWugt9smgMUjKcD+iNeVcbt8TrH2gzWoVrAE9dpqPffYzruR0z/EBpfnvAGRuOdPMJpGQ4UU+sS4W+yddXMzwvz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908469; c=relaxed/simple;
	bh=YT2U12WF7bv5wjfMECi5NPy3heXQWqaVNOISq8//jak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XwyKHIfSKo6vTGyIoSQI76Rg1djbJtWPGq5ocYWn/5ADOZo65WmIjtj6rgVUWcybVvNNgt10V5Bc4qY5ErwdOYg6FfA8yelej2t2WJIqtypXaoiMvYt0rW+6Et/YJ5C10kbx5V/OSwgLdPpmGYrHmq6CTp2GpaMh3vyOdz6+rrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rdLpxDzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CFFC3277B;
	Tue, 23 Apr 2024 21:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908469;
	bh=YT2U12WF7bv5wjfMECi5NPy3heXQWqaVNOISq8//jak=;
	h=From:To:Cc:Subject:Date:From;
	b=rdLpxDzpQkLuun+m4nhBPdntMVDZhhzLykzOigmrVF5jt78dxfH+kpxrCbBVnbOyW
	 Aviv9rc7FiRubzsMY8A/5MGGhIYkSqfcD93GBJ/67z6QAdOqUTUFx7crGxyp/gBbCJ
	 tJuUbrtNkOYrnoCs6lhmoBKXmEiIfmvj4Sm0W2Jg=
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
Subject: [PATCH 6.8 000/158] 6.8.8-rc1 review
Date: Tue, 23 Apr 2024 14:37:02 -0700
Message-ID: <20240423213855.824778126@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.8-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.8.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.8.8-rc1
X-KernelTest-Deadline: 2024-04-25T21:39+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.8.8 release.
There are 158 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.8-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.8.8-rc1

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: common: use struct_group_attr instead of struct_group for network_open_info

Marios Makassikis <mmakassikis@freebox.fr>
    ksmbd: clear RENAME_NOREPLACE before calling vfs_rename

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: validate request buffer size in smb2_allocate_rsp_buf()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix slab-out-of-bounds in smb2_allocate_rsp_buf

Arınç ÜNAL <arinc.unal@arinc9.com>
    net: dsa: mt7530: fix enabling EEE on MT7531 switch on all boards

Arınç ÜNAL <arinc.unal@arinc9.com>
    net: dsa: mt7530: fix improper frames on all 25MHz and 40MHz XTAL MT7530

Miaohe Lin <linmiaohe@huawei.com>
    fork: defer linking file vma until vma is fully initialized

Jeongjun Park <aha310510@gmail.com>
    nilfs2: fix OOB in nilfs_set_de_type

Phillip Lougher <phillip@squashfs.org.uk>
    Squashfs: check the inode number is not the invalid value of zero

Qiang Zhang <qiang4.zhang@intel.com>
    bootconfig: use memblock_free_late to free xbc memory to buddy

Dave Airlie <airlied@redhat.com>
    nouveau: fix instmem race condition around ptr stores

Zack Rusin <zack.rusin@broadcom.com>
    drm/vmwgfx: Fix crtc's atomic check conditional

Zack Rusin <zack.rusin@broadcom.com>
    drm/vmwgfx: Sort primary plane formats by order of preference

Zack Rusin <zack.rusin@broadcom.com>
    drm/vmwgfx: Fix prime import/export

Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
    drm/xe: Fix bo leak in intel_fb_bo_framebuffer_init

Christian König <ckoenig.leichtzumerken@gmail.com>
    drm/ttm: stop pooling cached NUMA pages v2

Christian König <christian.koenig@amd.com>
    drm/amdgpu: remove invalid resource->start check v2

Felix Kuehling <felix.kuehling@amd.com>
    drm/amdkfd: Fix memory leak in create_process failure

xinhui pan <xinhui.pan@amd.com>
    drm/amdgpu: validate the parameters of bo mapping operations more clearly

Danny Lin <danny@orbstack.dev>
    fuse: fix leaked ENOSYS error on first statx call

Sumanth Korikkar <sumanthk@linux.ibm.com>
    mm/shmem: inline shmem_is_huge() for disabled transparent hugepages

Miaohe Lin <linmiaohe@huawei.com>
    mm/memory-failure: fix deadlock when hugetlb_optimize_vmemmap is enabled

Oscar Salvador <osalvador@suse.de>
    mm,swapops: update check in is_pfn_swap_entry for hwpoison entries

Peter Xu <peterx@redhat.com>
    mm/userfaultfd: allow hugetlb change protection upon poison entry

David Hildenbrand <david@redhat.com>
    mm/madvise: make MADV_POPULATE_(READ|WRITE) handle VM_FAULT_RETRY properly

Yuntao Wang <ytcoode@gmail.com>
    init/main.c: Fix potential static_command_line memory overflow

Yaxiong Tian <tianyaxiong@kylinos.cn>
    arm64: hibernate: Fix level3 translation fault in swsusp_save()

Ard Biesheuvel <ardb@kernel.org>
    arm64/head: Disable MMU at EL2 before clearing HCR_EL2.E2H

David Matlack <dmatlack@google.com>
    KVM: x86/mmu: Write-protect L2 SPTEs in TDP MMU when clearing dirty status

Rick Edgecombe <rick.p.edgecombe@intel.com>
    KVM: x86/mmu: x86: Don't overflow lpage_info when checking attributes

Sandipan Das <sandipan.das@amd.com>
    KVM: x86/pmu: Do not mask LVTPC when handling a PMI on AMD platforms

Sean Christopherson <seanjc@google.com>
    KVM: x86/pmu: Disable support for adaptive PEBS

Sean Christopherson <seanjc@google.com>
    KVM: x86: Snapshot if a vCPU's vendor model is AMD vs. Intel compatible

Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    sched: Add missing memory barrier in switch_mm_cid

Alan Stern <stern@rowland.harvard.edu>
    fs: sysfs: Fix reference leak in sysfs_break_active_protection()

Samuel Thibault <samuel.thibault@ens-lyon.org>
    speakup: Avoid crash on very long word

Alexander Usyskin <alexander.usyskin@intel.com>
    mei: me: disable RPL-S on SPS and IGN firmwares

Sakari Ailus <sakari.ailus@linux.intel.com>
    mei: vsc: Unregister interrupt handler for system suspend

Kyle Tso <kyletso@google.com>
    usb: typec: tcpm: Correct the PDO counting in pd_set

Norihiko Hama <Norihiko.Hama@alpsalpine.com>
    usb: gadget: f_ncm: Fix UAF ncm object at re-bind after usb ep transport error

Kai-Heng Feng <kai.heng.feng@canonical.com>
    usb: Disable USB3 LPM at shutdown

Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
    usb: dwc2: host: Fix dereference issue in DDMA completion flow.

Sakari Ailus <sakari.ailus@linux.intel.com>
    Revert "mei: vsc: Call wake_up() in the threaded IRQ handler"

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

Tony Lindgren <tony@atomide.com>
    serial: core: Fix missing shutdown and startup for serial base port

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    serial: core: Clearing the circular buffer before NULLifying it

Tony Lindgren <tony@atomide.com>
    serial: core: Fix regression when runtime PM is not enabled

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    serial: stm32: Reset .throttled state in .startup()

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    serial: stm32: Return IRQ_NONE in the ISR if no handling happend

Hans de Goede <hdegoede@redhat.com>
    serial: 8250_dw: Revert: Do not reclock if already at correct rate

Finn Thain <fthain@linux-m68k.org>
    serial/pmac_zilog: Remove flawed mitigation for rx irq flood

Emil Kronborg <emil.kronborg@protonmail.com>
    serial: mxs-auart: add spinlock around changing cts state

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    comedi: vmk80xx: fix incomplete endpoint checking

Mika Westerberg <mika.westerberg@linux.intel.com>
    thunderbolt: Do not create DisplayPort tunnels on adapters of the same router

Gil Fine <gil.fine@linux.intel.com>
    thunderbolt: Fix wake configurations after device unplug

Gil Fine <gil.fine@linux.intel.com>
    thunderbolt: Avoid notify PM core about runtime PM resume

Carlos Llamas <cmllamas@google.com>
    binder: check offset alignment in binder_get_object()

Ricky Wu <ricky_wu@realtek.com>
    misc: rtsx: Fix rts5264 driver status incorrect when card removed

Fabio Estevam <festevam@denx.de>
    usb: misc: onboard_usb_hub: Disable the USB hub clock on failure

Ai Chao <aichao@kylinos.cn>
    ALSA: hda/realtek - Enable audio jacks of Haier Boyue G42 with ALC269VC

Mauro Carvalho Chehab <mchehab@kernel.org>
    ALSA: hda/realtek: Add quirks for Huawei Matebook D14 NBLB-WAX9N

Shenghao Ding <shenghao-ding@ti.com>
    ALSA: hda/tas2781: Add new vendor_id and subsystem_id to support ThinkPad ICE-1

Shenghao Ding <shenghao-ding@ti.com>
    ALSA: hda/tas2781: correct the register for pow calibrated data

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: ump: Fix conversion from MIDI2 to MIDI1 UMP messages

Shay Drory <shayd@nvidia.com>
    net/mlx5: E-switch, store eswitch pointer before registering devlink_param

Christoph Hellwig <hch@lst.de>
    block: propagate partition scanning errors to the BLKRRPART ioctl

Eric Biggers <ebiggers@google.com>
    x86/cpufeatures: Fix dependencies for GFNI, VAES, and VPCLMULQDQ

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/bugs: Fix BHI retpoline check

Nathan Lynch <nathanl@linux.ibm.com>
    selftests/powerpc/papr-vpd: Fix missing variable initialization

Daniel Golle <daniel@makrotopia.org>
    clk: mediatek: mt7988-infracfg: fix clocks for 2nd PCIe port

Pin-yen Lin <treapking@chromium.org>
    clk: mediatek: Do a runtime PM get on controllers during probe

Stephen Boyd <sboyd@kernel.org>
    clk: Get runtime PM before walking tree for clk_summary

Stephen Boyd <sboyd@kernel.org>
    clk: Get runtime PM before walking tree during disable_unused

Stephen Boyd <sboyd@kernel.org>
    clk: Initialize struct clk_core kref earlier

Stephen Boyd <sboyd@kernel.org>
    clk: Remove prepare_lock hold assertion in __clk_release()

Mike Tipton <quic_mdtipton@quicinc.com>
    interconnect: Don't access req_list while it's being manipulated

Konrad Dybcio <konrad.dybcio@linaro.org>
    interconnect: qcom: x1e80100: Remove inexistent ACV_PERF BCM

Mario Limonciello <mario.limonciello@amd.com>
    platform/x86/amd/pmc: Extend Framework 13 quirk to more BIOSes

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    thermal/debugfs: Add missing count increment to thermal_debug_tz_trip_up()

Huayu Zhang <zhanghuayu1233@qq.com>
    ALSA: hda/realtek: Fix volumn control of ThinkBook 16P Gen4

Alex Deucher <alexander.deucher@amd.com>
    drm/radeon: make -fstrict-flex-arrays=3 happy

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/panel: visionox-rm69299: don't unregister DSI device

Sanath S <Sanath.S@amd.com>
    thunderbolt: Reset topology created by the boot firmware

Sanath S <Sanath.S@amd.com>
    thunderbolt: Make tb_switch_reset() support Thunderbolt 2, 3 and USB4 routers

Sanath S <Sanath.S@amd.com>
    thunderbolt: Introduce tb_path_deactivate_hop()

Sanath S <Sanath.S@amd.com>
    thunderbolt: Introduce tb_port_reset()

Lokesh Gidra <lokeshgidra@google.com>
    userfaultfd: change src_folio after ensuring it's unpinned in UFFDIO_MOVE

Maíra Canal <mcanal@igalia.com>
    drm/v3d: Don't increment `enabled_ns` twice

Mikhail Kobuk <m.kobuk@ispras.ru>
    drm: nv04: Fix out of bounds access

Muhammad Usama Anjum <usama.anjum@collabora.com>
    iommufd: Add config needed for iommufd_fail_nth

Jason Gunthorpe <jgg@ziepe.ca>
    iommufd: Add missing IOMMUFD_DRIVER kconfig for the selftest

Peter Oberparleiter <oberpar@linux.ibm.com>
    s390/cio: fix race condition during online processing

Peter Oberparleiter <oberpar@linux.ibm.com>
    s390/qdio: handle deferred cc1

Namhyung Kim <namhyung@kernel.org>
    perf lock contention: Add a missing NULL check

Namhyung Kim <namhyung@kernel.org>
    perf annotate: Make sure to call symbol__annotate2() in TUI

Michael Guralnik <michaelgur@nvidia.com>
    RDMA/mlx5: Fix port number for counter query in multi-port configuration

Mark Zhang <markzhang@nvidia.com>
    RDMA/cm: Print the old state when cm_destroy_id gets timeout

Yanjun.Zhu <yanjun.zhu@linux.dev>
    RDMA/rxe: Fix the problem "mutex_destroy missing"

Vasily Gorbik <gor@linux.ibm.com>
    NFSD: fix endianness issue in nfsd4_encode_fattr4

Siddharth Vadapalli <s-vadapalli@ti.com>
    net: ethernet: ti: am65-cpsw-nuss: cleanup DMA Channels before using them

Paul Barker <paul.barker.ct@bp.renesas.com>
    net: ravb: Allow RX loop to move past DMA mapping errors

Paul Barker <paul.barker.ct@bp.renesas.com>
    net: ravb: Count packets instead of descriptors in R-Car RX path

Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
    ravb: Group descriptor types used in Rx ring

Felix Fietkau <nbd@nbd.name>
    net: ethernet: mtk_eth_soc: fix WED + wifi reset

Eric Dumazet <edumazet@google.com>
    net/sched: Fix mirred deadlock on device recursion

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: fix memleak in map from abort path

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    gpiolib: swnode: Remove wrong header inclusion

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: restore set elements when delete set fails

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: missing iterator type in lookup walk

Gerd Bayer <gbayer@linux.ibm.com>
    s390/ism: Properly fix receive message buffer allocation

Arınç ÜNAL <arinc.unal@arinc9.com>
    net: dsa: mt7530: fix port mirroring for MT7988 SoC switch

Arınç ÜNAL <arinc.unal@arinc9.com>
    net: dsa: mt7530: fix mirroring frames received on local port

Lei Chen <lei.chen@smartx.com>
    tun: limit printing rate when illegal packet received by tun dev

Marcin Szycik <marcin.szycik@linux.intel.com>
    ice: Fix checking for unsupported keys on non-tunnel device

Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
    ice: tc: allow zero flags in parsing tc flower

Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
    ice: tc: check src_vsi in case of traffic from VF

Serge Semin <fancer.lancer@gmail.com>
    net: stmmac: Fix IP-cores specific MAC capabilities

Serge Semin <fancer.lancer@gmail.com>
    net: stmmac: Fix max-speed being ignored on queue re-init

Serge Semin <fancer.lancer@gmail.com>
    net: stmmac: Apply half-duplex-less constraint for DW QoS Eth only

Dmitry Safonov <0x7f454c46@gmail.com>
    selftests/tcp_ao: Printing fixes to confirm with format-security

Dmitry Safonov <0x7f454c46@gmail.com>
    selftests/tcp_ao: Fix fscanf() call for format-security

Dmitry Safonov <0x7f454c46@gmail.com>
    selftests/tcp_ao: Zero-init tcp_ao_info_opt

Dmitry Safonov <0x7f454c46@gmail.com>
    selftests/tcp_ao: Make RST tests less flaky

Asbjørn Sloth Tønnesen <ast@fiberby.net>
    octeontx2-pf: fix FLOW_DIS_IS_FRAGMENT implementation

Yuri Benditovich <yuri.benditovich@daynix.com>
    net: change maximum number of UDP segments to 128

Carolina Jubran <cjubran@nvidia.com>
    net/mlx5e: Prevent deadlock while disabling aRFS

Shay Drory <shayd@nvidia.com>
    net/mlx5: Restore mistakenly dropped parts in register devlink flow

Shay Drory <shayd@nvidia.com>
    net/mlx5: Lag, restore buckets number to default after hash LAG deactivation

Asbjørn Sloth Tønnesen <ast@fiberby.net>
    net: sparx5: flower: fix fragment flags handling

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Don't peek OOB data without MSG_OOB.

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Call manage_oob() for every skb in unix_stream_read_generic().

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: flowtable: incorrect pppoe tuple

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: flowtable: validate pppoe header

Florian Westphal <fw@strlen.de>
    netfilter: nft_set_pipapo: do not free live element

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_set_pipapo: walk over current view on netlink dump

Florian Westphal <fw@strlen.de>
    netfilter: nft_set_pipapo: constify lookup fn args where possible

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: br_netfilter: skip conntrack input hook for promisc packets

Ziyang Xuan <william.xuanziyang@huawei.com>
    netfilter: nf_tables: Fix potential data-race in __nft_obj_type_get()

Ziyang Xuan <william.xuanziyang@huawei.com>
    netfilter: nf_tables: Fix potential data-race in __nft_expr_type_get()

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
    scsi: ufs: qcom: Add missing interconnect bandwidth values for Gear 5

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: add missing conditional compiling for call to r8169_remove_leds

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix LED-related deadlock on module removal

Naohiro Aota <naohiro.aota@wdc.com>
    btrfs: zoned: do not flag ZEROOUT on non-dirty extent buffer

Qu Wenruo <wqu@suse.com>
    btrfs: do not wait for short bulk allocation

Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
    net: usb: ax88179_178a: avoid writing the mac address before first reading

Bart Van Assche <bvanassche@acm.org>
    scsi: core: Fix handling of SCMD_FAIL_IF_RECOVERING

Jason A. Donenfeld <Jason@zx2c4.com>
    random: handle creditable entropy from atomic process context

Yuanhe Shu <xiangzao@linux.alibaba.com>
    selftests/ftrace: Limit length in subsystem-enable tests

Steven Rostedt (Google) <rostedt@goodmis.org>
    SUNRPC: Fix rpcgss_context trace event acceptor field

Jason A. Donenfeld <Jason@zx2c4.com>
    Revert "vmgenid: emit uevent when VMGENID updates"

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915/cdclk: Fix voltage_level programming edge case

Alexey Izbyshev <izbyshev@ispras.ru>
    io_uring: Fix io_cqring_wait() not restoring sigmask on get_timespec64() failure


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm64/kernel/head.S                           |   5 +
 arch/arm64/mm/pageattr.c                           |   3 -
 arch/x86/include/asm/barrier.h                     |   3 +
 arch/x86/include/asm/kvm_host.h                    |   1 +
 arch/x86/kernel/cpu/bugs.c                         |  11 +-
 arch/x86/kernel/cpu/cpuid-deps.c                   |   6 +-
 arch/x86/kvm/cpuid.c                               |   1 +
 arch/x86/kvm/cpuid.h                               |  10 ++
 arch/x86/kvm/lapic.c                               |   3 +-
 arch/x86/kvm/mmu/mmu.c                             |   5 +-
 arch/x86/kvm/mmu/tdp_mmu.c                         |  21 ++-
 arch/x86/kvm/vmx/vmx.c                             |  24 ++-
 arch/x86/kvm/x86.c                                 |   2 +-
 block/bdev.c                                       |  29 ++--
 block/ioctl.c                                      |   3 +-
 drivers/accessibility/speakup/main.c               |   2 +-
 drivers/android/binder.c                           |   4 +-
 drivers/char/random.c                              |  10 +-
 drivers/clk/clk.c                                  | 161 ++++++++++++++----
 drivers/clk/mediatek/clk-mt7988-infracfg.c         |   2 +-
 drivers/clk/mediatek/clk-mtk.c                     |  15 ++
 drivers/comedi/drivers/vmk80xx.c                   |  35 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   4 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  72 ++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   4 +-
 drivers/gpu/drm/i915/display/intel_cdclk.c         |  37 +++--
 drivers/gpu/drm/nouveau/nouveau_bios.c             |  13 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c |   7 +-
 drivers/gpu/drm/panel/panel-visionox-rm69299.c     |   2 -
 drivers/gpu/drm/radeon/radeon_atombios.c           |   8 +-
 drivers/gpu/drm/ttm/ttm_pool.c                     |  38 +++--
 drivers/gpu/drm/v3d/v3d_irq.c                      |   4 -
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c               |  35 +++-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                 |   7 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h                 |   2 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |   1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |   3 +
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c                |  32 ++++
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |  11 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_prime.c              |  15 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c         |  44 +++--
 drivers/gpu/drm/xe/display/intel_fb_bo.c           |   8 +-
 drivers/infiniband/core/cm.c                       |  11 +-
 drivers/infiniband/hw/mlx5/mad.c                   |   3 +-
 drivers/infiniband/sw/rxe/rxe.c                    |   2 +
 drivers/interconnect/core.c                        |   8 +
 drivers/interconnect/qcom/x1e80100.c               |  26 ---
 drivers/iommu/iommufd/Kconfig                      |   1 +
 drivers/misc/cardreader/rtsx_pcr.c                 |   2 +-
 drivers/misc/mei/pci-me.c                          |   2 +-
 drivers/misc/mei/platform-vsc.c                    |  17 +-
 drivers/misc/mei/vsc-tp.c                          |  84 +++++++---
 drivers/misc/mei/vsc-tp.h                          |   3 +
 drivers/net/dsa/mt7530.c                           |  38 +++--
 drivers/net/dsa/mt7530.h                           |   5 +
 drivers/net/ethernet/intel/ice/ice_tc_lib.c        |  15 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   |   7 +-
 drivers/net/ethernet/mediatek/mtk_wed.c            |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c  |  27 ++--
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   9 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   4 +
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   5 +-
 .../ethernet/mellanox/mlx5/core/sf/dev/driver.c    |   1 -
 .../ethernet/microchip/sparx5/sparx5_tc_flower.c   |  61 ++++---
 drivers/net/ethernet/realtek/r8169.h               |   4 +-
 drivers/net/ethernet/realtek/r8169_leds.c          |  23 ++-
 drivers/net/ethernet/realtek/r8169_main.c          |   7 +-
 drivers/net/ethernet/renesas/ravb.h                |   6 +-
 drivers/net/ethernet/renesas/ravb_main.c           |  93 ++++++-----
 drivers/net/ethernet/stmicro/stmmac/common.h       |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |   2 +
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |   2 +
 .../net/ethernet/stmicro/stmmac/dwmac100_core.c    |   2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |   7 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  18 +--
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  29 ++--
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |  18 +++
 drivers/net/tun.c                                  |  18 ++-
 drivers/net/usb/ax88179_178a.c                     |   4 +-
 drivers/platform/x86/amd/pmc/pmc-quirks.c          |   9 ++
 drivers/s390/cio/device.c                          |  13 +-
 drivers/s390/cio/qdio_main.c                       |  28 +++-
 drivers/s390/net/ism_drv.c                         |  37 +++--
 drivers/scsi/scsi_lib.c                            |   7 +-
 drivers/thermal/thermal_debugfs.c                  |   1 +
 drivers/thunderbolt/domain.c                       |   5 +-
 drivers/thunderbolt/icm.c                          |   2 +-
 drivers/thunderbolt/lc.c                           |  45 ++++++
 drivers/thunderbolt/nhi.c                          |  19 ++-
 drivers/thunderbolt/path.c                         |  13 ++
 drivers/thunderbolt/switch.c                       | 180 ++++++++++++++++++---
 drivers/thunderbolt/tb.c                           |  36 +++--
 drivers/thunderbolt/tb.h                           |  10 +-
 drivers/thunderbolt/tb_regs.h                      |   6 +
 drivers/thunderbolt/usb4.c                         |  52 +++++-
 drivers/tty/serial/8250/8250_dw.c                  |   6 +-
 drivers/tty/serial/mxs-auart.c                     |   8 +-
 drivers/tty/serial/pmac_zilog.c                    |  14 --
 drivers/tty/serial/serial_base.h                   |   4 +
 drivers/tty/serial/serial_core.c                   |  23 ++-
 drivers/tty/serial/serial_port.c                   |  34 ++++
 drivers/tty/serial/stm32-usart.c                   |  13 +-
 drivers/ufs/host/ufs-qcom.c                        |   8 +-
 drivers/usb/class/cdc-wdm.c                        |   6 +-
 drivers/usb/core/port.c                            |   4 +-
 drivers/usb/dwc2/hcd_ddma.c                        |   4 +-
 drivers/usb/gadget/function/f_ncm.c                |   4 +-
 drivers/usb/misc/onboard_usb_hub.c                 |   6 +-
 drivers/usb/serial/option.c                        |  40 +++++
 drivers/usb/typec/tcpm/tcpm.c                      |   4 +-
 drivers/virt/vmgenid.c                             |   2 -
 fs/btrfs/extent_io.c                               |  20 +--
 fs/fuse/dir.c                                      |   1 +
 fs/nfsd/nfs4xdr.c                                  |  47 +++---
 fs/nilfs2/dir.c                                    |   2 +-
 fs/smb/common/smb2pdu.h                            |   2 +-
 fs/smb/server/server.c                             |  13 +-
 fs/smb/server/smb2pdu.c                            |   4 +
 fs/smb/server/vfs.c                                |   5 +
 fs/squashfs/inode.c                                |   5 +-
 fs/sysfs/file.c                                    |   2 +
 include/asm-generic/barrier.h                      |   8 +
 include/linux/blkdev.h                             |   2 +
 include/linux/bootconfig.h                         |   7 +-
 include/linux/gpio/property.h                      |   1 -
 include/linux/shmem_fs.h                           |   9 ++
 include/linux/swapops.h                            |  65 ++++----
 include/linux/udp.h                                |   2 +-
 include/net/netfilter/nf_flow_table.h              |  12 +-
 include/net/netfilter/nf_tables.h                  |  14 ++
 include/net/sch_generic.h                          |   1 +
 include/trace/events/rpcgss.h                      |   4 +-
 init/main.c                                        |   2 +
 io_uring/io_uring.c                                |  26 +--
 kernel/fork.c                                      |  33 ++--
 kernel/sched/sched.h                               |  20 ++-
 lib/bootconfig.c                                   |  19 ++-
 mm/gup.c                                           |  54 ++++---
 mm/huge_memory.c                                   |   6 +-
 mm/hugetlb.c                                       |  10 +-
 mm/internal.h                                      |  10 +-
 mm/madvise.c                                       |  17 +-
 mm/memory-failure.c                                |  18 ++-
 mm/shmem.c                                         |   6 -
 net/bridge/br_input.c                              |  15 +-
 net/bridge/br_netfilter_hooks.c                    |   6 +
 net/bridge/br_private.h                            |   1 +
 net/bridge/netfilter/nf_conntrack_bridge.c         |  14 +-
 net/core/dev.c                                     |   6 +
 net/netfilter/nf_flow_table_inet.c                 |   3 +-
 net/netfilter/nf_flow_table_ip.c                   |  10 +-
 net/netfilter/nf_tables_api.c                      |  82 ++++++++--
 net/netfilter/nft_lookup.c                         |   1 +
 net/netfilter/nft_set_bitmap.c                     |   4 +-
 net/netfilter/nft_set_hash.c                       |   8 +-
 net/netfilter/nft_set_pipapo.c                     |  43 ++---
 net/netfilter/nft_set_pipapo.h                     |   6 +-
 net/netfilter/nft_set_pipapo_avx2.c                |  59 ++++---
 net/netfilter/nft_set_rbtree.c                     |   4 +-
 net/sched/sch_generic.c                            |   1 +
 net/unix/af_unix.c                                 |  12 +-
 sound/core/seq/seq_ump_convert.c                   |   2 +-
 sound/pci/hda/patch_realtek.c                      |   7 +-
 sound/pci/hda/tas2781_hda_i2c.c                    |   4 +-
 tools/perf/ui/browsers/annotate.c                  |   2 +-
 tools/perf/util/annotate.c                         |   3 +
 tools/perf/util/bpf_skel/lock_contention.bpf.c     |   5 +-
 .../ftrace/test.d/event/subsystem-enable.tc        |   6 +-
 tools/testing/selftests/iommu/config               |   2 +
 tools/testing/selftests/net/tcp_ao/lib/proc.c      |   2 +-
 tools/testing/selftests/net/tcp_ao/lib/setup.c     |  12 +-
 tools/testing/selftests/net/tcp_ao/rst.c           |  23 +--
 .../selftests/net/tcp_ao/setsockopt-closed.c       |   2 +-
 tools/testing/selftests/net/udpgso.c               |   2 +-
 .../testing/selftests/powerpc/papr_vpd/papr_vpd.c  |   2 +-
 178 files changed, 1898 insertions(+), 827 deletions(-)



