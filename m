Return-Path: <linux-kernel+bounces-145341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4933B8A5310
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C50C1C21813
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFBB71B32;
	Mon, 15 Apr 2024 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bF+pzgRS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ADE74E25;
	Mon, 15 Apr 2024 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191049; cv=none; b=Bi/EJyDkU5BmepSbxcW5hh8GK9ijQyeo4kQ2s0om0xRGvtStS4kmKskjya6F+Td4HMA4iu20gKEPxJyGDzglKH5CobqqfEKgYCXKGyPRgim6d0RQUBO3aFF4iyE2mnIGqmUf3icPUZyB3CDlMBbcX0WY33PWYedgU1vU29/HTB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191049; c=relaxed/simple;
	bh=ANA3g1Kxf8rk/HHEyKQoL3Jj5CN1XNNnxmVOTMHQhOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Le2/XaJmRMClrN6lexDYmfB9neGuG+54PzPCUybmigXI6RSwgHAOQ2DUFjfqX9jNwlnq0fNC0uHzGmJ5bi9IRDoCRQ5bt8XlE9bSaa2l+efyAg+PQCSmHqjS3A76YLDVRjM0F6fiwTwStRyXypiN/gGCVS6xwi1GUWhTkfaOaTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bF+pzgRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A9CC3277B;
	Mon, 15 Apr 2024 14:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713191049;
	bh=ANA3g1Kxf8rk/HHEyKQoL3Jj5CN1XNNnxmVOTMHQhOE=;
	h=From:To:Cc:Subject:Date:From;
	b=bF+pzgRSaef7k3KM7dQis5FtiQEUHFk7f4ARpUrSFig7jMhxbP3JQi1gfoSXg0fHK
	 n+iWXmk9JA3EQD/WOqA5yhBWQl4ATCLfK9/5H5cXzlFdtgpKW3vH4FdUs0lQBJOcRZ
	 U09mbgb2IhKHqBGZ6fmJmtIB5qhGwxc3/QEBR+zk=
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
Subject: [PATCH 6.8 000/172] 6.8.7-rc1 review
Date: Mon, 15 Apr 2024 16:18:19 +0200
Message-ID: <20240415141959.976094777@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.8.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.8.7-rc1
X-KernelTest-Deadline: 2024-04-17T14:20+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.8.7 release.
There are 172 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 17 Apr 2024 14:19:30 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.7-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.8.7-rc1

Fudongwang <fudong.wang@amd.com>
    drm/amd/display: fix disable otg wa logic in DCN316

Wenjing Liu <wenjing.liu@amd.com>
    drm/amd/display: always reset ODM mode in context when adding first plane

Alex Hung <alex.hung@amd.com>
    drm/amd/display: Return max resolution supported by DWB

Dillon Varone <dillon.varone@amd.com>
    drm/amd/display: Do not recursively call manual trigger programming

Harry Wentland <harry.wentland@amd.com>
    drm/amd/display: Set VSC SDP Colorimetry same way for MST and SST

Harry Wentland <harry.wentland@amd.com>
    drm/amd/display: Program VSC SDP colorimetry for all DP sinks >= 1.4

Yifan Zhang <yifan1.zhang@amd.com>
    drm/amdgpu: differentiate external rev id for gfx 11.5.0

Tim Huang <Tim.Huang@amd.com>
    drm/amdgpu: fix incorrect number of active RBs for gfx11

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: always force full reset for SOC21

Lijo Lazar <lijo.lazar@amd.com>
    drm/amdgpu: Reset dGPU if suspend got aborted

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Disable live M/N updates when using bigjoiner

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Disable port sync when bigjoiner is used

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915/psr: Disable PSR when bigjoiner is used

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915/cdclk: Fix CDCLK programming order when pipes are active

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/bugs: Replace CONFIG_SPECTRE_BHI_{ON,OFF} with CONFIG_MITIGATION_SPECTRE_BHI

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/bugs: Remove CONFIG_BHI_MITIGATION_AUTO and spectre_bhi=auto

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/bugs: Clarify that syscall hardening isn't a BHI mitigation

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/bugs: Fix BHI handling of RRSBA

Ingo Molnar <mingo@kernel.org>
    x86/bugs: Rename various 'ia32_cap' variables to 'x86_arch_cap_msr'

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/bugs: Cache the value of MSR_IA32_ARCH_CAPABILITIES

Josh Poimboeuf <jpoimboe@kernel.org>
    x86/bugs: Fix BHI documentation

Daniel Sneddon <daniel.sneddon@linux.intel.com>
    x86/bugs: Fix return type of spectre_bhi_state()

Amir Goldstein <amir73il@gmail.com>
    kernfs: annotate different lockdep class for of->mutex of writable files

Oleg Nesterov <oleg@redhat.com>
    selftests: kselftest: Fix build failure with NOLIBC

Arnd Bergmann <arnd@arndb.de>
    irqflags: Explicitly ignore lockdep_hrtimer_exit() argument

Adam Dunlap <acdunlap@google.com>
    x86/apic: Force native_apic_mem_read() to use the MOV instruction

Nathan Chancellor <nathan@kernel.org>
    selftests: kselftest: Mark functions that unconditionally call exit() as __noreturn

John Stultz <jstultz@google.com>
    selftests: timers: Fix abs() warning in posix_timers test

John Stultz <jstultz@google.com>
    selftests: timers: Fix posix_timers ksft_print_msg() warning

Oleg Nesterov <oleg@redhat.com>
    selftests/timers/posix_timers: Reimplement check_timer_distribution()

Sean Christopherson <seanjc@google.com>
    x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n

Namhyung Kim <namhyung@kernel.org>
    perf/x86: Fix out of range data

Gavin Shan <gshan@redhat.com>
    vhost: Add smp_rmb() in vhost_enable_notify()

Gavin Shan <gshan@redhat.com>
    vhost: Add smp_rmb() in vhost_vq_avail_empty()

Frank Li <Frank.Li@nxp.com>
    arm64: dts: imx8-ss-dma: fix spi lpcg indices

Frank Li <Frank.Li@nxp.com>
    arm64: dts: imx8-ss-lsio: fix pwm lpcg indices

Frank Li <Frank.Li@nxp.com>
    arm64: dts: imx8-ss-dma: fix pwm lpcg indices

Frank Li <Frank.Li@nxp.com>
    arm64: dts: imx8-ss-conn: fix usb lpcg indices

Frank Li <Frank.Li@nxp.com>
    arm64: dts: imx8-ss-dma: fix adc lpcg indices

Frank Li <Frank.Li@nxp.com>
    arm64: dts: imx8-ss-dma: fix can lpcg indices

Frank Li <Frank.Li@nxp.com>
    arm64: dts: imx8qm-ss-dma: fix can lpcg indices

Lang Yu <Lang.Yu@amd.com>
    drm/amdgpu/umsch: reinitialize write pointer in hw init

Johan Hovold <johan+linaro@kernel.org>
    drm/msm/dp: fix runtime PM leak on connect failure

Johan Hovold <johan+linaro@kernel.org>
    drm/msm/dp: fix runtime PM leak on disconnect

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/client: Fully protect modes[] with dev->mode_config.mutex

Boris Brezillon <boris.brezillon@collabora.com>
    drm/panfrost: Fix the error path in panfrost_mmu_map_fault_addr()

Jammy Huang <jammy_huang@aspeedtech.com>
    drm/ast: Fix soft lockup

Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
    drm/amdkfd: Reset GPU on queue preemption failure

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915/vrr: Disable VRR when using bigjoiner

Zack Rusin <zack.rusin@broadcom.com>
    drm/vmwgfx: Enable DMA mappings with SEV

Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
    accel/ivpu: Fix deadlock in context_xa

Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
    accel/ivpu: Return max freq for DRM_IVPU_PARAM_CORE_CLOCK_RATE

Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
    accel/ivpu: Put NPU back to D3hot after failed resume

Wachowski, Karol <karol.wachowski@intel.com>
    accel/ivpu: Fix PCI D0 state entry in resume

Wachowski, Karol <karol.wachowski@intel.com>
    accel/ivpu: Check return code of ipc->lock init

Alexander Wetzel <Alexander@wetzel-home.de>
    scsi: sg: Avoid race in error handling & drop bogus warn

Alexander Wetzel <Alexander@wetzel-home.de>
    scsi: sg: Avoid sg device teardown race

Masami Hiramatsu <mhiramat@kernel.org>
    fs/proc: Skip bootloader comment if no embedded kernel parameters

Zhenhua Huang <quic_zhenhuah@quicinc.com>
    fs/proc: remove redundant comments from /proc/bootconfig

Zheng Yejian <zhengyejian1@huawei.com>
    kprobes: Fix possible use-after-free issue on kprobe registration

Pavel Begunkov <asml.silence@gmail.com>
    io_uring/net: restore msg_control on sendzc retry

Boris Burkov <boris@bur.io>
    btrfs: qgroup: convert PREALLOC to PERTRANS after record_root_in_trans

Boris Burkov <boris@bur.io>
    btrfs: record delayed inode root in transaction

Boris Burkov <boris@bur.io>
    btrfs: qgroup: fix qgroup prealloc rsv leak in subvolume operations

Boris Burkov <boris@bur.io>
    btrfs: qgroup: correctly model root qgroup rsv in convert

Jens Axboe <axboe@kernel.dk>
    io_uring: disable io-wq execution of multishot NOWAIT requests

Pavel Begunkov <asml.silence@gmail.com>
    io_uring: refactor DEFER_TASKRUN multishot checks

Lu Baolu <baolu.lu@linux.intel.com>
    iommu/vt-d: Fix WARN_ON in iommu probe path

Jacob Pan <jacob.jun.pan@linux.intel.com>
    iommu/vt-d: Allocate local memory for page request queue

Xuchun Shang <xuchun.shang@linux.alibaba.com>
    iommu/vt-d: Fix wrong use of pasid config

Arnd Bergmann <arnd@arndb.de>
    tracing: hide unused ftrace_event_id_fops

Karthik Poosa <karthik.poosa@intel.com>
    drm/xe/hwmon: Cast result to output precision on left shift of operand

Lucas De Marchi <lucas.demarchi@intel.com>
    drm/xe/display: Fix double mutex initialization

David Arinzon <darinzon@amazon.com>
    net: ena: Set tx_info->xdpf value to NULL

David Arinzon <darinzon@amazon.com>
    net: ena: Fix incorrect descriptor free behavior

David Arinzon <darinzon@amazon.com>
    net: ena: Wrong missing IO completions check order

David Arinzon <darinzon@amazon.com>
    net: ena: Fix potential sign extension issue

Michal Luczaj <mhal@rbox.co>
    af_unix: Fix garbage collector racing against connect()

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Do not use atomic ops for unix_sk(sk)->inflight.

Arınç ÜNAL <arinc.unal@arinc9.com>
    net: dsa: mt7530: trap link-local frames regardless of ST Port State

Gerd Bayer <gbayer@linux.ibm.com>
    Revert "s390/ism: fix receive message buffer allocation"

Daniel Machon <daniel.machon@microchip.com>
    net: sparx5: fix wrong config being used when reconfiguring PCS

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    net/mlx5e: Do not produce metadata freelist entries in Tx port ts WQE xmit

Carolina Jubran <cjubran@nvidia.com>
    net/mlx5e: HTB, Fix inconsistencies with QoS SQs number

Carolina Jubran <cjubran@nvidia.com>
    net/mlx5e: Fix mlx5e_priv_init() cleanup flow

Carolina Jubran <cjubran@nvidia.com>
    net/mlx5e: RSS, Block changing channels number when RXFH is configured

Cosmin Ratiu <cratiu@nvidia.com>
    net/mlx5: Correctly compare pkt reformat ids

Cosmin Ratiu <cratiu@nvidia.com>
    net/mlx5: Properly link new fs rules into the tree

Michael Liang <mliang@purestorage.com>
    net/mlx5: offset comp irq index in name by one

Shay Drory <shayd@nvidia.com>
    net/mlx5: Register devlink first under devlink lock

Moshe Shemesh <moshe@nvidia.com>
    net/mlx5: SF, Stop waiting for FW as teardown was called

Eric Dumazet <edumazet@google.com>
    netfilter: complete validation of user input

Archie Pusaka <apusaka@chromium.org>
    Bluetooth: l2cap: Don't double set the HCI_CONN_MGMT_CONNECTED bit

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_sock: Fix not validating setsockopt user input

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: ISO: Fix not validating setsockopt user input

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: L2CAP: Fix not validating setsockopt user input

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: RFCOMM: Fix not validating setsockopt user input

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: SCO: Fix not validating setsockopt user input

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_sync: Fix using the same interval and window for Coded PHY

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_sync: Use QoS to determine which PHY to scan

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: ISO: Don't reject BT_ISO_QOS if parameters are unset

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: ISO: Align broadcast sync_timeout with connection timeout

Brett Creeley <brett.creeley@amd.com>
    pds_core: Fix pdsc_check_pci_health function to use work thread

Shannon Nelson <shannon.nelson@amd.com>
    pds_core: use pci_reset_function for health reset

Jiri Benc <jbenc@redhat.com>
    ipv6: fix race condition between ipv6_get_ifaddr and ipv6_del_addr

Arnd Bergmann <arnd@arndb.de>
    ipv4/route: avoid unused-but-set-variable warning

Arnd Bergmann <arnd@arndb.de>
    ipv6: fib: hide unused 'pn' variable

Geetha sowjanya <gakula@marvell.com>
    octeontx2-af: Fix NIX SQ mode and BP config

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Clear stale u->oob_skb.

Marek Vasut <marex@denx.de>
    net: ks8851: Handle softirqs at the end of IRQ thread to fix hang

Marek Vasut <marex@denx.de>
    net: ks8851: Inline ks8851_rx_skb()

Dave Jiang <dave.jiang@intel.com>
    cxl: Fix retrieving of access_coordinates in PCIe path

Dave Jiang <dave.jiang@intel.com>
    cxl: Remove checking of iter in cxl_endpoint_get_perf_coordinates()

Dave Jiang <dave.jiang@intel.com>
    cxl: Split out host bridge access coordinates

Dave Jiang <dave.jiang@intel.com>
    cxl: Split out combine_coordinates() for common shared usage

Dave Jiang <dave.jiang@intel.com>
    ACPI: HMAT / cxl: Add retrieval of generic port coordinates for both access classes

Dave Jiang <dave.jiang@intel.com>
    ACPI: HMAT: Introduce 2 levels of generic port access class

Dave Jiang <dave.jiang@intel.com>
    base/node / ACPI: Enumerate node access class for 'struct access_coordinate'

Raag Jadav <raag.jadav@intel.com>
    ACPI: bus: allow _UID matching for integer zero

Pavan Chebbi <pavan.chebbi@broadcom.com>
    bnxt_en: Reset PTP tx_avail after possible firmware reset

Vikas Gupta <vikas.gupta@broadcom.com>
    bnxt_en: Fix error recovery for RoCE ulp client

Vikas Gupta <vikas.gupta@broadcom.com>
    bnxt_en: Fix possible memory leak in bnxt_rdma_aux_device_init()

Gerd Bayer <gbayer@linux.ibm.com>
    s390/ism: fix receive message buffer allocation

Eric Dumazet <edumazet@google.com>
    geneve: fix header validation in geneve[6]_xmit_skb

Arnd Bergmann <arnd@arndb.de>
    lib: checksum: hide unused expected_csum_ipv6_magic[]

Ming Lei <ming.lei@redhat.com>
    block: fix q->blkg_list corruption during disk rebind

Hariprasad Kelam <hkelam@marvell.com>
    octeontx2-pf: Fix transmit scheduler resource leak

Eric Dumazet <edumazet@google.com>
    xsk: validate user input for XDP_{UMEM|COMPLETION}_FILL_RING

Petr Tesarik <petr@tesarici.cz>
    u64_stats: fix u64_stats_init() for lockdep when used repeatedly in one file

Ilya Maximets <i.maximets@ovn.org>
    net: openvswitch: fix unwanted error log on timeout policy probing

Dan Carpenter <dan.carpenter@linaro.org>
    scsi: qla2xxx: Fix off by one in qla_edif_app_getstats()

Xiang Chen <chenxiang66@hisilicon.com>
    scsi: hisi_sas: Modify the deadline for ata_wait_after_reset()

Luca Weiss <luca.weiss@fairphone.com>
    drm/msm/adreno: Set highest_bank_bit for A619

Arnd Bergmann <arnd@arndb.de>
    nouveau: fix function cast warning

Alex Constantino <dreaming.about.electric.sheep@gmail.com>
    Revert "drm/qxl: simplify qxl_fence_wait"

Kwangjin Ko <kwangjin.ko@sk.com>
    cxl/core: Fix initialization of mbox_cmd.size_out in get event

Frank Li <Frank.Li@nxp.com>
    arm64: dts: imx8-ss-conn: fix usdhc wrong lpcg clock order

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    dt-bindings: display/msm: sm8150-mdss: add DP node

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dpu: make error messages at dpu_core_irq_register_callback() more sensible

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dpu: don't allow overriding data from catalog

Stephen Boyd <swboyd@chromium.org>
    drm/msm: Add newlines to some debug prints

Tim Harvey <tharvey@gateworks.com>
    arm64: dts: freescale: imx8mp-venice-gw73xx-2x: fix USB vbus regulator

Tim Harvey <tharvey@gateworks.com>
    arm64: dts: freescale: imx8mp-venice-gw72xx-2x: fix USB vbus regulator

Dave Jiang <dave.jiang@intel.com>
    cxl/core/regs: Fix usage of map->reg_type in cxl_decode_regblock() before assigned

Yuquan Wang <wangyuquan1236@phytium.com.cn>
    cxl/mem: Fix for the index of Clear Event Record Handle

Cristian Marussi <cristian.marussi@arm.com>
    firmware: arm_scmi: Make raw debugfs entries non-seekable

Jens Wiklander <jens.wiklander@linaro.org>
    firmware: arm_ffa: Fix the partition ID check in ffa_notification_info_get()

Aaro Koskinen <aaro.koskinen@iki.fi>
    ARM: OMAP2+: fix USB regression on Nokia N8x0

Aaro Koskinen <aaro.koskinen@iki.fi>
    mmc: omap: restore original power up/down steps

Aaro Koskinen <aaro.koskinen@iki.fi>
    mmc: omap: fix deferred probe

Aaro Koskinen <aaro.koskinen@iki.fi>
    mmc: omap: fix broken slot switch lookup

Aaro Koskinen <aaro.koskinen@iki.fi>
    ARM: OMAP2+: fix N810 MMC gpiod table

Aaro Koskinen <aaro.koskinen@iki.fi>
    ARM: OMAP2+: fix bogus MMC GPIO labels on Nokia N8x0

David Sterba <dsterba@suse.com>
    btrfs: tests: allocate dummy fs_info and root in test_find_delalloc()

Nini Song <nini.song@mediatek.com>
    media: cec: core: remove length check of Timer Status

Anna-Maria Behnsen <anna-maria@linutronix.de>
    PM: s2idle: Make sure CPUs will wakeup directly on resume

Hans de Goede <hdegoede@redhat.com>
    ACPI: scan: Do not increase dep_unmet for already met dependencies

Noah Loomans <noah@noahloomans.com>
    platform/chrome: cros_ec_uart: properly fix race condition

Tim Huang <Tim.Huang@amd.com>
    drm/amd/pm: fixes a random hang in S4 for SMU v13.0.4/11

Dmitry Antipov <dmantipov@yandex.ru>
    Bluetooth: Fix memory leak in hci_req_sync_complete()

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Only update pages_touched when a new page is touched

Yu Kuai <yukuai3@huawei.com>
    raid1: fix use-after-free for original bio in raid1_write_request()

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx7s-warp: Pass OV2680 link-frequencies

Gavin Shan <gshan@redhat.com>
    arm64: tlb: Fix TLBI RANGE operand

Breno Leitao <leitao@debian.org>
    virtio_net: Do not send RSS key if it is not supported

Xiubo Li <xiubli@redhat.com>
    ceph: switch to use cap_delay_lock for the unlink delay list

NeilBrown <neilb@suse.de>
    ceph: redirty page before returning AOP_WRITEPAGE_ACTIVATE

Sven Eckelmann <sven@narfation.org>
    batman-adv: Avoid infinite loop trying to resize local TT

Peyton Lee <peytolee@amd.com>
    drm/amdgpu/vpe: power on vpe when hw_init

Damien Le Moal <dlemoal@kernel.org>
    ata: libata-scsi: Fix ata_scsi_dev_rescan() error path

Igor Pylypiv <ipylypiv@google.com>
    ata: libata-core: Allow command duration limits detection for ACS-4 drives

Steve French <stfrench@microsoft.com>
    smb3: fix Open files on server counter going negative


-------------

Diffstat:

 Documentation/admin-guide/hw-vuln/spectre.rst      |  22 +-
 Documentation/admin-guide/kernel-parameters.txt    |  12 +-
 .../bindings/display/msm/qcom,sm8150-mdss.yaml     |   9 +
 Makefile                                           |   4 +-
 arch/arm/boot/dts/nxp/imx/imx7s-warp.dts           |   1 +
 arch/arm/mach-omap2/board-n8x0.c                   |  23 +--
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi    |  16 +-
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi     |  40 ++--
 arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi    |  16 +-
 .../boot/dts/freescale/imx8mp-venice-gw72xx.dtsi   |   2 +-
 .../boot/dts/freescale/imx8mp-venice-gw73xx.dtsi   |   2 +-
 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi   |   8 +-
 arch/arm64/include/asm/tlbflush.h                  |  20 +-
 arch/x86/Kconfig                                   |  21 +-
 arch/x86/events/core.c                             |   1 +
 arch/x86/include/asm/apic.h                        |   3 +-
 arch/x86/kernel/apic/apic.c                        |   6 +-
 arch/x86/kernel/cpu/bugs.c                         |  82 ++++----
 arch/x86/kernel/cpu/common.c                       |  48 ++---
 block/blk-cgroup.c                                 |   9 +-
 block/blk-cgroup.h                                 |   2 +
 block/blk-core.c                                   |   2 +
 drivers/accel/ivpu/ivpu_drv.c                      |  20 +-
 drivers/accel/ivpu/ivpu_hw.h                       |   6 +
 drivers/accel/ivpu/ivpu_hw_37xx.c                  |   7 +-
 drivers/accel/ivpu/ivpu_hw_40xx.c                  |   6 +
 drivers/accel/ivpu/ivpu_ipc.c                      |   8 +-
 drivers/accel/ivpu/ivpu_pm.c                       |   7 +-
 drivers/acpi/numa/hmat.c                           |  43 ++--
 drivers/acpi/scan.c                                |   3 +-
 drivers/ata/libata-core.c                          |   2 +-
 drivers/ata/libata-scsi.c                          |   9 +-
 drivers/base/node.c                                |   6 +-
 drivers/cxl/acpi.c                                 |   8 +-
 drivers/cxl/core/cdat.c                            |  58 ++++--
 drivers/cxl/core/mbox.c                            |   5 +-
 drivers/cxl/core/port.c                            |  76 ++++---
 drivers/cxl/core/regs.c                            |   5 +-
 drivers/cxl/cxl.h                                  |   8 +-
 drivers/firmware/arm_ffa/driver.c                  |   2 +-
 drivers/firmware/arm_scmi/raw_mode.c               |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c            |   6 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |  32 ++-
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c         |   2 +
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  15 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |   6 +-
 .../amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c |  19 +-
 drivers/gpu/drm/amd/display/dc/core/dc_state.c     |   9 +
 .../gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.c |   3 -
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c   |  12 +-
 drivers/gpu/drm/ast/ast_dp.c                       |   3 +
 drivers/gpu/drm/drm_client_modeset.c               |   3 +-
 drivers/gpu/drm/i915/display/intel_cdclk.c         |   7 +-
 drivers/gpu/drm/i915/display/intel_cdclk.h         |   3 +
 drivers/gpu/drm/i915/display/intel_ddi.c           |   5 +
 drivers/gpu/drm/i915/display/intel_dp.c            |   6 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |  11 +
 drivers/gpu/drm/i915/display/intel_vrr.c           |   7 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |   4 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c      |  10 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c  |   8 +-
 drivers/gpu/drm/msm/dp/dp_display.c                |   2 +
 drivers/gpu/drm/msm/msm_fb.c                       |   6 +-
 drivers/gpu/drm/msm/msm_kms.c                      |   4 +-
 .../gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c    |   7 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c            |  13 +-
 drivers/gpu/drm/qxl/qxl_release.c                  |  50 ++++-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |  11 +-
 drivers/gpu/drm/xe/xe_display.c                    |   5 -
 drivers/gpu/drm/xe/xe_hwmon.c                      |   4 +-
 drivers/iommu/intel/iommu.c                        |  11 +-
 drivers/iommu/intel/perfmon.c                      |   2 +-
 drivers/iommu/intel/svm.c                          |   2 +-
 drivers/md/raid1.c                                 |   2 +-
 drivers/media/cec/core/cec-adap.c                  |  14 --
 drivers/mmc/host/omap.c                            |  48 +++--
 drivers/net/dsa/mt7530.c                           | 229 ++++++++++++++++++---
 drivers/net/dsa/mt7530.h                           |   5 +
 drivers/net/ethernet/amazon/ena/ena_com.c          |   2 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |  35 ++--
 drivers/net/ethernet/amazon/ena/ena_xdp.c          |   4 +-
 drivers/net/ethernet/amd/pds_core/core.c           |  14 +-
 drivers/net/ethernet/amd/pds_core/core.h           |   5 +-
 drivers/net/ethernet/amd/pds_core/dev.c            |   3 +
 drivers/net/ethernet/amd/pds_core/main.c           |   8 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |   6 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |  22 +-
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c   |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h   |   8 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c   |  33 +--
 drivers/net/ethernet/mellanox/mlx5/core/en/selq.c  |   2 +
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  17 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   2 -
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |   7 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |  17 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  37 ++--
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |   4 +-
 .../ethernet/mellanox/mlx5/core/sf/dev/driver.c    |  22 +-
 drivers/net/ethernet/micrel/ks8851.h               |   3 -
 drivers/net/ethernet/micrel/ks8851_common.c        |  16 +-
 drivers/net/ethernet/micrel/ks8851_par.c           |  11 -
 drivers/net/ethernet/micrel/ks8851_spi.c           |  11 -
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |   4 +-
 drivers/net/geneve.c                               |   4 +-
 drivers/net/virtio_net.c                           |  28 ++-
 drivers/platform/chrome/cros_ec_uart.c             |  28 +--
 drivers/scsi/hisi_sas/hisi_sas_main.c              |   2 +-
 drivers/scsi/qla2xxx/qla_edif.c                    |   2 +-
 drivers/scsi/sg.c                                  |  20 +-
 drivers/vhost/vhost.c                              |  28 ++-
 fs/btrfs/delayed-inode.c                           |   3 +
 fs/btrfs/inode.c                                   |  13 +-
 fs/btrfs/ioctl.c                                   |  37 +++-
 fs/btrfs/qgroup.c                                  |   2 +
 fs/btrfs/root-tree.c                               |  10 -
 fs/btrfs/root-tree.h                               |   2 -
 fs/btrfs/tests/extent-io-tests.c                   |  28 ++-
 fs/btrfs/transaction.c                             |  17 +-
 fs/ceph/addr.c                                     |   4 +-
 fs/ceph/caps.c                                     |   4 +-
 fs/ceph/mds_client.c                               |   9 +-
 fs/ceph/mds_client.h                               |   3 +-
 fs/kernfs/file.c                                   |   9 +-
 fs/proc/bootconfig.c                               |  12 +-
 fs/smb/client/cached_dir.c                         |   4 +-
 include/acpi/acpi_bus.h                            |   8 +-
 include/linux/bootconfig.h                         |   1 +
 include/linux/dma-fence.h                          |   7 +
 include/linux/irqflags.h                           |   2 +-
 include/linux/node.h                               |  18 +-
 include/linux/u64_stats_sync.h                     |   9 +-
 include/net/addrconf.h                             |   4 +
 include/net/af_unix.h                              |   2 +-
 include/net/bluetooth/bluetooth.h                  |  11 +
 include/net/ip_tunnels.h                           |  33 +++
 init/main.c                                        |   5 +
 io_uring/io_uring.c                                |  25 +++
 io_uring/net.c                                     |  22 +-
 io_uring/rw.c                                      |   2 -
 kernel/cpu.c                                       |   3 +-
 kernel/kprobes.c                                   |  18 +-
 kernel/power/suspend.c                             |   6 +
 kernel/trace/ring_buffer.c                         |   6 +-
 kernel/trace/trace_events.c                        |   4 +
 lib/checksum_kunit.c                               |   5 +-
 net/batman-adv/translation-table.c                 |   2 +-
 net/bluetooth/hci_request.c                        |   4 +-
 net/bluetooth/hci_sock.c                           |  21 +-
 net/bluetooth/hci_sync.c                           |  66 +++++-
 net/bluetooth/iso.c                                |  50 ++---
 net/bluetooth/l2cap_core.c                         |   3 +-
 net/bluetooth/l2cap_sock.c                         |  52 ++---
 net/bluetooth/rfcomm/sock.c                        |  14 +-
 net/bluetooth/sco.c                                |  23 +--
 net/ipv4/netfilter/arp_tables.c                    |   4 +
 net/ipv4/netfilter/ip_tables.c                     |   4 +
 net/ipv4/route.c                                   |   4 +-
 net/ipv6/addrconf.c                                |   7 +-
 net/ipv6/ip6_fib.c                                 |   7 +-
 net/ipv6/netfilter/ip6_tables.c                    |   4 +
 net/openvswitch/conntrack.c                        |   5 +-
 net/unix/af_unix.c                                 |   8 +-
 net/unix/garbage.c                                 |  35 +++-
 net/unix/scm.c                                     |   8 +-
 net/xdp/xsk.c                                      |   2 +
 tools/testing/selftests/kselftest.h                |  33 ++-
 tools/testing/selftests/timers/posix_timers.c      | 105 +++++-----
 170 files changed, 1559 insertions(+), 882 deletions(-)



