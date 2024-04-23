Return-Path: <linux-kernel+bounces-155934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F2A8AF9B7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F691F27697
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23CF143898;
	Tue, 23 Apr 2024 21:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nk749YXx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEADA1420BE;
	Tue, 23 Apr 2024 21:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908573; cv=none; b=g+Tn9Z/gLV0dry0J6njeDyu3vfU7Rowdqp+i+/bxOhHVPR0fRS2tZdr4Vcf2qBqxGfy9DReQLQH85bWwiROUtTVNXnPEIu4MIlM6xJa9Dno0UYZUt+McnQKgtzXQZGzeQhwPFczY5jjVCt9uw/l/Oz7FbU7N4ZxCBnXDIOXmJOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908573; c=relaxed/simple;
	bh=R9GTbnrDzPGCz9tJKEpIKdxpkMorjxKgKodZHCz78gM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LZPGyK+G+rmmjsTd7AvtSSVcAZ4i4VVfoQPyHui9XihxVqLzgtI0Kb6y3c0ACZ4y98x/Y/tBHc6H77xzcJD9BaIVfw/UhashNrk8jfIEqk68y4J5DY15JQaXKhjwR/UhaQteFNDTAmU62ZL2LNNzBQXiQy/RUnPyESEpjWtWvsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nk749YXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4A7C32783;
	Tue, 23 Apr 2024 21:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908572;
	bh=R9GTbnrDzPGCz9tJKEpIKdxpkMorjxKgKodZHCz78gM=;
	h=From:To:Cc:Subject:Date:From;
	b=Nk749YXxxXKnHvaL5R3gqcMkb5aL+D7PbMUZ8Zpq9/DPc1IOInWSfoN4/hCCHVhkv
	 XqV+I7sRrOTEClTUkfCnvjmtCwDC0UhmEt8vduW5nXd/pFBT3LO7C9JOarHHKcnMiM
	 5nM6ovRwaAmXM/0XscfBMDWgFtsiz5VpnhQQaP68=
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
Subject: [PATCH 6.6 000/158] 6.6.29-rc1 review
Date: Tue, 23 Apr 2024 14:37:17 -0700
Message-ID: <20240423213855.696477232@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.29-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.29-rc1
X-KernelTest-Deadline: 2024-04-25T21:39+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.6.29 release.
There are 158 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.29-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.6.29-rc1

Johan Hovold <johan+linaro@kernel.org>
    PCI/ASPM: Fix deadlock when enabling ASPM

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: common: use struct_group_attr instead of struct_group for network_open_info

Marios Makassikis <mmakassikis@freebox.fr>
    ksmbd: clear RENAME_NOREPLACE before calling vfs_rename

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: validate request buffer size in smb2_allocate_rsp_buf()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix slab-out-of-bounds in smb2_allocate_rsp_buf

Naveen N Rao <naveen@kernel.org>
    powerpc/ftrace: Ignore ftrace locations in exit text sections

Breno Leitao <leitao@debian.org>
    virtio_net: Do not send RSS key if it is not supported

Arınç ÜNAL <arinc.unal@arinc9.com>
    net: dsa: mt7530: fix enabling EEE on MT7531 switch on all boards

Arınç ÜNAL <arinc.unal@arinc9.com>
    net: dsa: mt7530: fix improper frames on all 25MHz and 40MHz XTAL MT7530

Jeongjun Park <aha310510@gmail.com>
    nilfs2: fix OOB in nilfs_set_de_type

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

Yuntao Wang <ytcoode@gmail.com>
    init/main.c: Fix potential static_command_line memory overflow

Yaxiong Tian <tianyaxiong@kylinos.cn>
    arm64: hibernate: Fix level3 translation fault in swsusp_save()

Ard Biesheuvel <ardb@kernel.org>
    arm64/head: Disable MMU at EL2 before clearing HCR_EL2.E2H

David Matlack <dmatlack@google.com>
    KVM: x86/mmu: Write-protect L2 SPTEs in TDP MMU when clearing dirty status

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

Norihiko Hama <Norihiko.Hama@alpsalpine.com>
    usb: gadget: f_ncm: Fix UAF ncm object at re-bind after usb ep transport error

Kai-Heng Feng <kai.heng.feng@canonical.com>
    usb: Disable USB3 LPM at shutdown

Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
    usb: dwc2: host: Fix dereference issue in DDMA completion flow.

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

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    serial: stm32: Reset .throttled state in .startup()

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    serial: stm32: Return IRQ_NONE in the ISR if no handling happend

Finn Thain <fthain@linux-m68k.org>
    serial/pmac_zilog: Remove flawed mitigation for rx irq flood

Emil Kronborg <emil.kronborg@protonmail.com>
    serial: mxs-auart: add spinlock around changing cts state

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    comedi: vmk80xx: fix incomplete endpoint checking

Gil Fine <gil.fine@linux.intel.com>
    thunderbolt: Fix wake configurations after device unplug

Gil Fine <gil.fine@linux.intel.com>
    thunderbolt: Avoid notify PM core about runtime PM resume

Carlos Llamas <cmllamas@google.com>
    binder: check offset alignment in binder_get_object()

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

Eric Biggers <ebiggers@google.com>
    x86/cpufeatures: Fix dependencies for GFNI, VAES, and VPCLMULQDQ

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/bugs: Fix BHI retpoline check

Pin-yen Lin <treapking@chromium.org>
    clk: mediatek: Do a runtime PM get on controllers during probe

Stephen Boyd <sboyd@kernel.org>
    clk: Get runtime PM before walking tree for clk_summary

Vishal Badole <badolevishal1116@gmail.com>
    clk: Show active consumers of clocks in debugfs

Stephen Boyd <sboyd@kernel.org>
    clk: Get runtime PM before walking tree during disable_unused

Stephen Boyd <sboyd@kernel.org>
    clk: Initialize struct clk_core kref earlier

Stephen Boyd <sboyd@kernel.org>
    clk: Remove prepare_lock hold assertion in __clk_release()

Mike Tipton <quic_mdtipton@quicinc.com>
    interconnect: Don't access req_list while it's being manipulated

Mario Limonciello <mario.limonciello@amd.com>
    platform/x86/amd/pmc: Extend Framework 13 quirk to more BIOSes

Hardik Gajjar <hgajjar@de.adit-jv.com>
    usb: new quirk to reduce the SET_ADDRESS request timeout

Hardik Gajjar <hgajjar@de.adit-jv.com>
    usb: xhci: Add timeout argument in address_device USB HCD callback

Brenton Simpson <appsforartists@google.com>
    drm: panel-orientation-quirks: Add quirk for Lenovo Legion Go

Geoffrey D. Bennett <g@b4.vu>
    ALSA: scarlett2: Rename scarlett_gen2 to scarlett2

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI: Simplify pcie_capability_clear_and_set_word() to ..._clear_word()

Bjorn Helgaas <bhelgaas@google.com>
    PCI/DPC: Use FIELD_GET()

Geoffrey D. Bennett <g@b4.vu>
    ALSA: scarlett2: Add Focusrite Clarett 2Pre and 4Pre USB support

Geoffrey D. Bennett <g@b4.vu>
    ALSA: scarlett2: Add Focusrite Clarett+ 2Pre and 4Pre support

Geoffrey D. Bennett <g@b4.vu>
    ALSA: scarlett2: Add correct product series name to messages

Geoffrey D. Bennett <g@b4.vu>
    ALSA: scarlett2: Default mixer driver to enabled

Sanath S <Sanath.S@amd.com>
    thunderbolt: Reset topology created by the boot firmware

Sanath S <Sanath.S@amd.com>
    thunderbolt: Make tb_switch_reset() support Thunderbolt 2, 3 and USB4 routers

Sanath S <Sanath.S@amd.com>
    thunderbolt: Introduce tb_path_deactivate_hop()

Sanath S <Sanath.S@amd.com>
    thunderbolt: Introduce tb_port_reset()

Niklas Schnelle <schnelle@linux.ibm.com>
    usb: pci-quirks: handle HAS_IOPORT dependency for UHCI handoff

Niklas Schnelle <schnelle@linux.ibm.com>
    usb: pci-quirks: handle HAS_IOPORT dependency for AMD quirk

Niklas Schnelle <schnelle@linux.ibm.com>
    usb: pci-quirks: group AMD specific quirk code together

Linus Walleij <linus.walleij@linaro.org>
    ASoC: ti: Convert Pandora ASoC to GPIO descriptors

Geoffrey D. Bennett <g@b4.vu>
    ALSA: scarlett2: Add support for Clarett 8Pre USB

Geoffrey D. Bennett <g@b4.vu>
    ALSA: scarlett2: Move USB IDs out from device_info struct

Alex Deucher <alexander.deucher@amd.com>
    drm/radeon: make -fstrict-flex-arrays=3 happy

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/panel: visionox-rm69299: don't unregister DSI device

Mikhail Kobuk <m.kobuk@ispras.ru>
    drm: nv04: Fix out of bounds access

Peter Oberparleiter <oberpar@linux.ibm.com>
    s390/cio: fix race condition during online processing

Peter Oberparleiter <oberpar@linux.ibm.com>
    s390/qdio: handle deferred cc1

Namhyung Kim <namhyung@kernel.org>
    perf lock contention: Add a missing NULL check

Michael Guralnik <michaelgur@nvidia.com>
    RDMA/mlx5: Fix port number for counter query in multi-port configuration

Mark Zhang <markzhang@nvidia.com>
    RDMA/cm: Print the old state when cm_destroy_id gets timeout

Yanjun.Zhu <yanjun.zhu@linux.dev>
    RDMA/rxe: Fix the problem "mutex_destroy missing"

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915/mst: Limit MST+DSC to TGL+

Siddharth Vadapalli <s-vadapalli@ti.com>
    net: ethernet: ti: am65-cpsw-nuss: cleanup DMA Channels before using them

Felix Fietkau <nbd@nbd.name>
    net: ethernet: mtk_eth_soc: fix WED + wifi reset

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    gpiolib: swnode: Remove wrong header inclusion

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

Asbjørn Sloth Tønnesen <ast@fiberby.net>
    octeontx2-pf: fix FLOW_DIS_IS_FRAGMENT implementation

Yuri Benditovich <yuri.benditovich@daynix.com>
    net: change maximum number of UDP segments to 128

Carolina Jubran <cjubran@nvidia.com>
    net/mlx5e: Prevent deadlock while disabling aRFS

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
    netfilter: br_netfilter: skip conntrack input hook for promisc packets

Ziyang Xuan <william.xuanziyang@huawei.com>
    netfilter: nf_tables: Fix potential data-race in __nft_obj_type_get()

Ziyang Xuan <william.xuanziyang@huawei.com>
    netfilter: nf_tables: Fix potential data-race in __nft_expr_type_get()

Manivannan Sadhasivam <mani@kernel.org>
    scsi: ufs: qcom: Add missing interconnect bandwidth values for Gear 5

Gavin Shan <gshan@redhat.com>
    arm64: tlb: Fix TLBI RANGE operand

Ryan Roberts <ryan.roberts@arm.com>
    arm64/mm: Modify range-based tlbi to decrement scale

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

Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
    drm/i915/vma: Fix UAF on destroy against retire race

Alexey Izbyshev <izbyshev@ispras.ru>
    io_uring: Fix io_cqring_wait() not restoring sigmask on get_timespec64() failure

Hans Verkuil <hverkuil-cisco@xs4all.nl>
    media: videobuf2: request more buffers for vb2_read

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dpu: populate SSPP scaler block version

John Stultz <jstultz@google.com>
    selftests: timers: Fix posix_timers ksft_print_msg() warning

NeilBrown <neilb@suse.de>
    ceph: redirty page before returning AOP_WRITEPAGE_ACTIVATE

Xiubo Li <xiubli@redhat.com>
    ceph: rename _to_client() to _to_fs_client()

Xiubo Li <xiubli@redhat.com>
    ceph: pass the mdsc to several helpers

Dillon Varone <dillon.varone@amd.com>
    drm/amd/display: Do not recursively call manual trigger programming

Oleg Nesterov <oleg@redhat.com>
    selftests/timers/posix_timers: Reimplement check_timer_distribution()

Mark Brown <broonie@kernel.org>
    selftests: timers: Convert posix_timers test to generate KTAP output

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Disable live M/N updates when using bigjoiner

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Adjust seamless_m_n flag behaviour

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Enable VRR later during fastsets

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Extract intel_crtc_vblank_evade_scanlines()

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Change intel_pipe_update_{start,end}() calling convention

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915/cdclk: Fix voltage_level programming edge case

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915/mst: Reject FEC+MST on ICL

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Fix FEC pipe A vs. DDI A mixup

Paulo Alcantara <pc@manguebit.com>
    smb: client: refresh referral without acquiring refpath_lock

Paulo Alcantara <pc@manguebit.com>
    smb: client: guarantee refcounted children from parent session

Steve French <stfrench@microsoft.com>
    smb3: show beginning time for per share stats

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix UAF in smb2_reconnect_server()

Paulo Alcantara <pc@manguebit.com>
    smb: client: remove extra @chan_count check in __cifs_put_smb_ses()


-------------

Diffstat:

 Documentation/admin-guide/kernel-parameters.txt    |   3 +
 MAINTAINERS                                        |   2 +-
 Makefile                                           |   4 +-
 arch/arm/mach-omap2/pdata-quirks.c                 |  10 +
 arch/arm64/include/asm/tlbflush.h                  |  40 ++--
 arch/arm64/kernel/head.S                           |   5 +
 arch/arm64/mm/pageattr.c                           |   3 -
 arch/powerpc/include/asm/ftrace.h                  |  10 +-
 arch/powerpc/include/asm/sections.h                |   1 +
 arch/powerpc/kernel/trace/ftrace.c                 |  12 +
 arch/powerpc/kernel/trace/ftrace_64_pg.c           |   5 +
 arch/powerpc/kernel/vmlinux.lds.S                  |   2 +
 arch/x86/include/asm/barrier.h                     |   3 +
 arch/x86/include/asm/kvm_host.h                    |   1 +
 arch/x86/kernel/cpu/bugs.c                         |  11 +-
 arch/x86/kernel/cpu/cpuid-deps.c                   |   6 +-
 arch/x86/kvm/cpuid.c                               |   1 +
 arch/x86/kvm/cpuid.h                               |  10 +
 arch/x86/kvm/lapic.c                               |   3 +-
 arch/x86/kvm/mmu/mmu.c                             |   2 +-
 arch/x86/kvm/mmu/tdp_mmu.c                         |  21 +-
 arch/x86/kvm/vmx/vmx.c                             |  24 +-
 arch/x86/kvm/x86.c                                 |   2 +-
 drivers/accessibility/speakup/main.c               |   2 +-
 drivers/android/binder.c                           |   4 +-
 drivers/char/random.c                              |  10 +-
 drivers/clk/clk.c                                  | 195 ++++++++++++----
 drivers/clk/mediatek/clk-mtk.c                     |  15 ++
 drivers/comedi/drivers/vmk80xx.c                   |  35 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   4 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |  72 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   4 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c  |   3 -
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |   6 +
 drivers/gpu/drm/i915/display/intel_atomic.c        |   1 +
 drivers/gpu/drm/i915/display/intel_cdclk.c         |  37 ++-
 drivers/gpu/drm/i915/display/intel_crtc.c          |  96 +++++---
 drivers/gpu/drm/i915/display/intel_crtc.h          |   6 +-
 drivers/gpu/drm/i915/display/intel_display.c       |  43 ++--
 .../gpu/drm/i915/display/intel_display_device.h    |   1 +
 drivers/gpu/drm/i915/display/intel_display_types.h |   2 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |  13 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |   2 +-
 drivers/gpu/drm/i915/i915_vma.c                    |  42 +++-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_5_0_sm8150.h |   8 +-
 .../drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h    |   8 +-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h |   8 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  95 ++++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   3 +-
 drivers/gpu/drm/nouveau/nouveau_bios.c             |  13 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c |   7 +-
 drivers/gpu/drm/panel/panel-visionox-rm69299.c     |   2 -
 drivers/gpu/drm/radeon/radeon_atombios.c           |   8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c               |  35 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                 |   7 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h                 |   2 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |   1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |   3 +
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c                |  32 +++
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |  11 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_prime.c              |  15 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c         |  44 ++--
 drivers/infiniband/core/cm.c                       |  11 +-
 drivers/infiniband/hw/mlx5/mad.c                   |   3 +-
 drivers/infiniband/sw/rxe/rxe.c                    |   2 +
 drivers/interconnect/core.c                        |   8 +
 drivers/media/common/videobuf2/videobuf2-core.c    |   9 +-
 drivers/misc/mei/pci-me.c                          |   2 +-
 drivers/net/dsa/mt7530.c                           |  38 ++-
 drivers/net/dsa/mt7530.h                           |   5 +
 drivers/net/ethernet/intel/ice/ice_tc_lib.c        |  15 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_tc.c   |   7 +-
 drivers/net/ethernet/mediatek/mtk_wed.c            |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c  |  27 ++-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   9 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   4 +
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |   4 +-
 .../ethernet/microchip/sparx5/sparx5_tc_flower.c   |  61 +++--
 drivers/net/ethernet/stmicro/stmmac/common.h       |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |   2 +
 .../net/ethernet/stmicro/stmmac/dwmac1000_core.c   |   2 +
 .../net/ethernet/stmicro/stmmac/dwmac100_core.c    |   2 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |   7 +-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  18 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  29 +--
 drivers/net/ethernet/ti/am65-cpsw-nuss.c           |  18 ++
 drivers/net/tun.c                                  |  18 +-
 drivers/net/usb/ax88179_178a.c                     |   4 +-
 drivers/net/virtio_net.c                           |  27 ++-
 drivers/pci/bus.c                                  |  49 ++--
 drivers/pci/pci.c                                  |  78 ++++---
 drivers/pci/pci.h                                  |   4 +-
 drivers/pci/pcie/aspm.c                            |  21 +-
 drivers/pci/pcie/dpc.c                             |   5 +-
 drivers/pci/quirks.c                               |   8 +-
 drivers/platform/x86/amd/pmc/pmc-quirks.c          |   9 +
 drivers/s390/cio/device.c                          |  13 +-
 drivers/s390/cio/qdio_main.c                       |  28 ++-
 drivers/s390/net/ism_drv.c                         |  37 ++-
 drivers/scsi/scsi_lib.c                            |   7 +-
 drivers/thunderbolt/domain.c                       |   5 +-
 drivers/thunderbolt/icm.c                          |   2 +-
 drivers/thunderbolt/lc.c                           |  45 ++++
 drivers/thunderbolt/nhi.c                          |  19 +-
 drivers/thunderbolt/path.c                         |  13 ++
 drivers/thunderbolt/switch.c                       | 180 +++++++++++++--
 drivers/thunderbolt/tb.c                           |  30 ++-
 drivers/thunderbolt/tb.h                           |  10 +-
 drivers/thunderbolt/tb_regs.h                      |   6 +
 drivers/thunderbolt/usb4.c                         |  52 ++++-
 drivers/tty/serial/mxs-auart.c                     |   8 +-
 drivers/tty/serial/pmac_zilog.c                    |  14 --
 drivers/tty/serial/serial_base.h                   |   4 +
 drivers/tty/serial/serial_core.c                   |  21 +-
 drivers/tty/serial/serial_port.c                   |  34 +++
 drivers/tty/serial/stm32-usart.c                   |  13 +-
 drivers/ufs/host/ufs-qcom.c                        |   8 +-
 drivers/usb/Kconfig                                |  10 +
 drivers/usb/class/cdc-wdm.c                        |   6 +-
 drivers/usb/core/hcd-pci.c                         |   3 +-
 drivers/usb/core/hub.c                             |  15 +-
 drivers/usb/core/port.c                            |   4 +-
 drivers/usb/core/quirks.c                          |   7 +
 drivers/usb/dwc2/hcd_ddma.c                        |   4 +-
 drivers/usb/gadget/function/f_ncm.c                |   4 +-
 drivers/usb/host/pci-quirks.c                      | 144 ++++++------
 drivers/usb/host/pci-quirks.h                      |  34 ++-
 drivers/usb/host/xhci-mem.c                        |   2 +
 drivers/usb/host/xhci-ring.c                       |  11 +-
 drivers/usb/host/xhci.c                            |  23 +-
 drivers/usb/host/xhci.h                            |   9 +-
 drivers/usb/serial/option.c                        |  40 ++++
 fs/ceph/addr.c                                     |  22 +-
 fs/ceph/cache.c                                    |   2 +-
 fs/ceph/caps.c                                     |  53 +++--
 fs/ceph/crypto.c                                   |   2 +-
 fs/ceph/debugfs.c                                  |   4 +-
 fs/ceph/dir.c                                      |  24 +-
 fs/ceph/export.c                                   |  10 +-
 fs/ceph/file.c                                     |  26 +--
 fs/ceph/inode.c                                    |  14 +-
 fs/ceph/ioctl.c                                    |   8 +-
 fs/ceph/mds_client.c                               |  41 ++--
 fs/ceph/mds_client.h                               |   3 +-
 fs/ceph/mdsmap.c                                   |   3 +-
 fs/ceph/snap.c                                     |  18 +-
 fs/ceph/super.c                                    |  22 +-
 fs/ceph/super.h                                    |  13 +-
 fs/ceph/xattr.c                                    |  12 +-
 fs/fuse/dir.c                                      |   1 +
 fs/nilfs2/dir.c                                    |   2 +-
 fs/smb/client/cifs_debug.c                         |   6 +-
 fs/smb/client/cifsglob.h                           |   3 +-
 fs/smb/client/cifsproto.h                          |  20 +-
 fs/smb/client/connect.c                            | 135 ++++++-----
 fs/smb/client/dfs.c                                |  51 ++--
 fs/smb/client/dfs.h                                |  33 ++-
 fs/smb/client/dfs_cache.c                          |  53 ++---
 fs/smb/client/misc.c                               |   7 +-
 fs/smb/common/smb2pdu.h                            |   2 +-
 fs/smb/server/server.c                             |  13 +-
 fs/smb/server/smb2pdu.c                            |   4 +
 fs/smb/server/vfs.c                                |   5 +
 fs/sysfs/file.c                                    |   2 +
 include/asm-generic/barrier.h                      |   8 +
 include/linux/bootconfig.h                         |   7 +-
 include/linux/ceph/mdsmap.h                        |   5 +-
 include/linux/gpio/property.h                      |   1 -
 include/linux/pci.h                                |   5 +
 include/linux/shmem_fs.h                           |   9 +
 include/linux/swapops.h                            |  65 +++---
 include/linux/udp.h                                |   2 +-
 include/linux/usb/hcd.h                            |  22 +-
 include/linux/usb/quirks.h                         |   3 +
 include/net/netfilter/nf_flow_table.h              |  12 +-
 include/trace/events/rpcgss.h                      |   4 +-
 include/uapi/linux/pci_regs.h                      |   1 +
 init/main.c                                        |   2 +
 io_uring/io_uring.c                                |  26 +--
 kernel/sched/sched.h                               |  20 +-
 lib/bootconfig.c                                   |  19 +-
 mm/hugetlb.c                                       |  10 +-
 mm/memory-failure.c                                |  18 +-
 mm/shmem.c                                         |   6 -
 net/bridge/br_input.c                              |  15 +-
 net/bridge/br_netfilter_hooks.c                    |   6 +
 net/bridge/br_private.h                            |   1 +
 net/bridge/netfilter/nf_conntrack_bridge.c         |  14 +-
 net/netfilter/nf_flow_table_inet.c                 |   3 +-
 net/netfilter/nf_flow_table_ip.c                   |  10 +-
 net/netfilter/nf_tables_api.c                      |  16 +-
 net/netfilter/nft_set_pipapo.c                     |  14 +-
 net/unix/af_unix.c                                 |  12 +-
 sound/core/seq/seq_ump_convert.c                   |   2 +-
 sound/pci/hda/patch_realtek.c                      |   3 +
 sound/pci/hda/tas2781_hda_i2c.c                    |   4 +-
 sound/soc/ti/omap3pandora.c                        |  63 ++---
 sound/usb/Makefile                                 |   2 +-
 sound/usb/mixer_quirks.c                           |   9 +-
 .../{mixer_scarlett_gen2.c => mixer_scarlett2.c}   | 257 +++++++++++++++------
 sound/usb/mixer_scarlett2.h                        |   7 +
 sound/usb/mixer_scarlett_gen2.h                    |   7 -
 tools/perf/util/bpf_skel/lock_contention.bpf.c     |   5 +-
 .../ftrace/test.d/event/subsystem-enable.tc        |   6 +-
 tools/testing/selftests/kselftest.h                |  13 ++
 tools/testing/selftests/net/udpgso.c               |   2 +-
 tools/testing/selftests/timers/posix_timers.c      | 156 ++++++-------
 208 files changed, 2654 insertions(+), 1290 deletions(-)



