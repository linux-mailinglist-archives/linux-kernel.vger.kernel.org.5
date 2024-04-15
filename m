Return-Path: <linux-kernel+bounces-145365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF508A5445
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0BB31C2202E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387177603A;
	Mon, 15 Apr 2024 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QL/UalkW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D6C762CD;
	Mon, 15 Apr 2024 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191554; cv=none; b=jF4/7gUIX+32ko4DBOpzaKUqXfh8W27PYyL7v4Ld37ZjgUBjSVxj3vYQAdpVPzZXtrOEQ6XFCMYVEXJiH7OjyXwoQvg9GFBjvlgG89afo39faXX3wuUOOtCswshAQ/R1o2zZWrOUvPxNo5+kmvjG2eVVIiM2FVIna8/qC4FBJZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191554; c=relaxed/simple;
	bh=Xx1JoQvqeT/fnM+4YxlqH+8Vc97vAtPvnPH4mGEWQHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bxh3JMFwBHHVrWd/z/9V87Q4m/FBSl7c3N/tG17epz+Yjc5jhF8x4oOnRBC+TATHnbEEy6xNNpN9PRRZuRZcplR+Zl1PdKrOlwY5lKunAjdr9JeJkr2Fe/SyC8eSxH2cK58e3oonYImK29Mfi4rb4xJbu7ea6nNokXO2MhEEpTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QL/UalkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5236C113CC;
	Mon, 15 Apr 2024 14:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713191554;
	bh=Xx1JoQvqeT/fnM+4YxlqH+8Vc97vAtPvnPH4mGEWQHg=;
	h=From:To:Cc:Subject:Date:From;
	b=QL/UalkWl7ldiauUdFZdactC4bkYB0LnUVY2x6iIdq5Km8iDZ6gy9GSsyndDhbG/d
	 eo9rYuEGhGlr/iBMsR55W9lRM02U9V2yzAWFmkhlGg6/fNi9NopHWD4f0UFEoySFYX
	 K44+pIRUAVVUwVhGzMHN8ccLlsi0NArAruJIi/Gw=
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
Subject: [PATCH 6.6 000/122] 6.6.28-rc1 review
Date: Mon, 15 Apr 2024 16:19:25 +0200
Message-ID: <20240415141953.365222063@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.28-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.28-rc1
X-KernelTest-Deadline: 2024-04-17T14:19+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.6.28 release.
There are 122 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 17 Apr 2024 14:19:30 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.28-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.6.28-rc1

Fudongwang <fudong.wang@amd.com>
    drm/amd/display: fix disable otg wa logic in DCN316

Harry Wentland <harry.wentland@amd.com>
    drm/amd/display: Set VSC SDP Colorimetry same way for MST and SST

Harry Wentland <harry.wentland@amd.com>
    drm/amd/display: Program VSC SDP colorimetry for all DP sinks >= 1.4

Tim Huang <Tim.Huang@amd.com>
    drm/amdgpu: fix incorrect number of active RBs for gfx11

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: always force full reset for SOC21

Lijo Lazar <lijo.lazar@amd.com>
    drm/amdgpu: Reset dGPU if suspend got aborted

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Disable port sync when bigjoiner is used

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

Arnd Bergmann <arnd@arndb.de>
    irqflags: Explicitly ignore lockdep_hrtimer_exit() argument

Adam Dunlap <acdunlap@google.com>
    x86/apic: Force native_apic_mem_read() to use the MOV instruction

John Stultz <jstultz@google.com>
    selftests: timers: Fix abs() warning in posix_timers test

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
    arm64: dts: imx8-ss-conn: fix usb lpcg indices

Frank Li <Frank.Li@nxp.com>
    arm64: dts: imx8-ss-dma: fix adc lpcg indices

Frank Li <Frank.Li@nxp.com>
    arm64: dts: imx8-ss-dma: fix can lpcg indices

Frank Li <Frank.Li@nxp.com>
    arm64: dts: imx8qm-ss-dma: fix can lpcg indices

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

Alexander Wetzel <Alexander@wetzel-home.de>
    scsi: sg: Avoid race in error handling & drop bogus warn

Alexander Wetzel <Alexander@wetzel-home.de>
    scsi: sg: Avoid sg device teardown race

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

Geliang Tang <tanggeliang@kylinos.cn>
    selftests: mptcp: use += operator to append strings

Jacob Pan <jacob.jun.pan@linux.intel.com>
    iommu/vt-d: Allocate local memory for page request queue

Xuchun Shang <xuchun.shang@linux.alibaba.com>
    iommu/vt-d: Fix wrong use of pasid config

Arnd Bergmann <arnd@arndb.de>
    tracing: hide unused ftrace_event_id_fops

David Arinzon <darinzon@amazon.com>
    net: ena: Set tx_info->xdpf value to NULL

David Arinzon <darinzon@amazon.com>
    net: ena: Use tx_ring instead of xdp_ring for XDP channel TX

David Arinzon <darinzon@amazon.com>
    net: ena: Pass ena_adapter instead of net_device to ena_xmit_common()

David Arinzon <darinzon@amazon.com>
    net: ena: Move XDP code to its new files

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
    Bluetooth: SCO: Fix not validating setsockopt user input

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_sync: Fix using the same interval and window for Coded PHY

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_sync: Use QoS to determine which PHY to scan

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: ISO: Don't reject BT_ISO_QOS if parameters are unset

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: ISO: Align broadcast sync_timeout with connection timeout

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

Arnd Bergmann <arnd@arndb.de>
    nouveau: fix function cast warning

Alex Constantino <dreaming.about.electric.sheep@gmail.com>
    Revert "drm/qxl: simplify qxl_fence_wait"

Kwangjin Ko <kwangjin.ko@sk.com>
    cxl/core: Fix initialization of mbox_cmd.size_out in get event

Frank Li <Frank.Li@nxp.com>
    arm64: dts: imx8-ss-conn: fix usdhc wrong lpcg clock order

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dpu: don't allow overriding data from catalog

Dave Jiang <dave.jiang@intel.com>
    cxl/core/regs: Fix usage of map->reg_type in cxl_decode_regblock() before assigned

Yuquan Wang <wangyuquan1236@phytium.com.cn>
    cxl/mem: Fix for the index of Clear Event Record Handle

Cristian Marussi <cristian.marussi@arm.com>
    firmware: arm_scmi: Make raw debugfs entries non-seekable

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

Sven Eckelmann <sven@narfation.org>
    batman-adv: Avoid infinite loop trying to resize local TT

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
 .../device_drivers/ethernet/amazon/ena.rst         |   1 +
 Makefile                                           |   4 +-
 arch/arm/boot/dts/nxp/imx/imx7s-warp.dts           |   1 +
 arch/arm/mach-omap2/board-n8x0.c                   |  23 +-
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi    |  16 +-
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi     |  36 +-
 arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi    |  16 +-
 arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi   |   8 +-
 arch/arm64/include/asm/tlbflush.h                  |  20 +-
 arch/x86/Kconfig                                   |  21 +-
 arch/x86/events/core.c                             |   1 +
 arch/x86/include/asm/apic.h                        |   3 +-
 arch/x86/kernel/apic/apic.c                        |   6 +-
 arch/x86/kernel/cpu/bugs.c                         |  82 ++-
 arch/x86/kernel/cpu/common.c                       |  48 +-
 block/blk-cgroup.c                                 |   9 +-
 block/blk-cgroup.h                                 |   2 +
 block/blk-core.c                                   |   2 +
 drivers/accel/ivpu/ivpu_drv.c                      |   2 +-
 drivers/acpi/scan.c                                |   3 +-
 drivers/ata/libata-core.c                          |   2 +-
 drivers/ata/libata-scsi.c                          |   9 +-
 drivers/cxl/core/mbox.c                            |   5 +-
 drivers/cxl/core/regs.c                            |   5 +-
 drivers/firmware/arm_scmi/raw_mode.c               |   7 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |  27 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |   1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  15 +-
 .../amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c |  19 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c   |  12 +-
 drivers/gpu/drm/ast/ast_dp.c                       |   3 +
 drivers/gpu/drm/drm_client_modeset.c               |   3 +-
 drivers/gpu/drm/i915/display/intel_cdclk.c         |   7 +-
 drivers/gpu/drm/i915/display/intel_cdclk.h         |   3 +
 drivers/gpu/drm/i915/display/intel_ddi.c           |   5 +
 drivers/gpu/drm/i915/display/intel_vrr.c           |   7 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c      |  10 +-
 .../gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c    |   7 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c            |  13 +-
 drivers/gpu/drm/qxl/qxl_release.c                  |  50 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |  11 +-
 drivers/iommu/intel/perfmon.c                      |   2 +-
 drivers/iommu/intel/svm.c                          |   2 +-
 drivers/md/raid1.c                                 |   2 +-
 drivers/media/cec/core/cec-adap.c                  |  14 -
 drivers/mmc/host/omap.c                            |  48 +-
 drivers/net/dsa/mt7530.c                           | 229 ++++++-
 drivers/net/dsa/mt7530.h                           |   5 +
 drivers/net/ethernet/amazon/ena/Makefile           |   2 +-
 drivers/net/ethernet/amazon/ena/ena_com.c          |   2 +-
 drivers/net/ethernet/amazon/ena/ena_ethtool.c      |   1 +
 drivers/net/ethernet/amazon/ena/ena_netdev.c       | 688 ++-------------------
 drivers/net/ethernet/amazon/ena/ena_netdev.h       |  83 +--
 drivers/net/ethernet/amazon/ena/ena_xdp.c          | 466 ++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_xdp.h          | 152 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |   6 +-
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |  22 +-
 drivers/net/ethernet/marvell/octeontx2/nic/qos.c   |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h   |   8 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c   |  33 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/selq.c  |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   2 -
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |   7 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |  17 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  37 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |   4 +-
 .../ethernet/mellanox/mlx5/core/sf/dev/driver.c    |  22 +-
 drivers/net/ethernet/micrel/ks8851.h               |   3 -
 drivers/net/ethernet/micrel/ks8851_common.c        |  16 +-
 drivers/net/ethernet/micrel/ks8851_par.c           |  11 -
 drivers/net/ethernet/micrel/ks8851_spi.c           |  11 -
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |   4 +-
 drivers/net/geneve.c                               |   4 +-
 drivers/platform/chrome/cros_ec_uart.c             |  28 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c              |   2 +-
 drivers/scsi/qla2xxx/qla_edif.c                    |   2 +-
 drivers/scsi/sg.c                                  |  20 +-
 drivers/vhost/vhost.c                              |  28 +-
 fs/btrfs/delayed-inode.c                           |   3 +
 fs/btrfs/inode.c                                   |  13 +-
 fs/btrfs/ioctl.c                                   |  37 +-
 fs/btrfs/qgroup.c                                  |   2 +
 fs/btrfs/root-tree.c                               |  10 -
 fs/btrfs/root-tree.h                               |   2 -
 fs/btrfs/transaction.c                             |  17 +-
 fs/smb/client/cached_dir.c                         |   4 +-
 include/linux/dma-fence.h                          |   7 +
 include/linux/irqflags.h                           |   2 +-
 include/linux/u64_stats_sync.h                     |   9 +-
 include/net/addrconf.h                             |   4 +
 include/net/af_unix.h                              |   2 +-
 include/net/bluetooth/bluetooth.h                  |  11 +
 include/net/ip_tunnels.h                           |  33 +
 io_uring/net.c                                     |   1 +
 kernel/cpu.c                                       |   3 +-
 kernel/kprobes.c                                   |  18 +-
 kernel/power/suspend.c                             |   6 +
 kernel/trace/ring_buffer.c                         |   6 +-
 kernel/trace/trace_events.c                        |   4 +
 net/batman-adv/translation-table.c                 |   2 +-
 net/bluetooth/hci_request.c                        |   4 +-
 net/bluetooth/hci_sync.c                           |  66 +-
 net/bluetooth/iso.c                                |  14 +-
 net/bluetooth/l2cap_core.c                         |   3 +-
 net/bluetooth/sco.c                                |  23 +-
 net/ipv4/netfilter/arp_tables.c                    |   4 +
 net/ipv4/netfilter/ip_tables.c                     |   4 +
 net/ipv4/route.c                                   |   4 +-
 net/ipv6/addrconf.c                                |   7 +-
 net/ipv6/ip6_fib.c                                 |   7 +-
 net/ipv6/netfilter/ip6_tables.c                    |   4 +
 net/openvswitch/conntrack.c                        |   5 +-
 net/unix/af_unix.c                                 |   8 +-
 net/unix/garbage.c                                 |  35 +-
 net/unix/scm.c                                     |   8 +-
 net/xdp/xsk.c                                      |   2 +
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  53 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  30 +-
 tools/testing/selftests/timers/posix_timers.c      |   2 +-
 123 files changed, 1765 insertions(+), 1263 deletions(-)



