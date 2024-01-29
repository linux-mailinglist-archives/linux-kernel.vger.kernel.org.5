Return-Path: <linux-kernel+bounces-43191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060ED840F65
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35394B2571C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97DC1649B8;
	Mon, 29 Jan 2024 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r81IaOn3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D019115B0ED;
	Mon, 29 Jan 2024 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548431; cv=none; b=l/HVdOk57Cx0SwJZGXoaesjJoZpBvuYZ5/9R8fEW0KfYaJe7uWSewrA5v8/JzVQL5SkztANy5BusgoOG+i2cKmfkGC+1mJk0Xql1nKtDehX2WTSGZ3CC17/w51KwkcN8FIDRwpLsBWEAcYZQGXWk6z1ToYwGlaXJ2INs1YlR0xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548431; c=relaxed/simple;
	bh=Fb0zjSGVBg4OS7RwO5ilcwwg9R8jxFv+7Cat7s/niJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XhDwv0/cpZNq2LkHMLoGifJqYnK+Jt6PuVpVBjZZ5AjoVWjjxLXbFmGkUQ9trpewiKmzziAHPHJSLCupYg7accG2uGgMJ7YBd6QcyPkWoULZ5bc1SmOZ2iNnlXd1D0mVzoNPPk46BXHnGhqP2vE3BbwPYOibJc1IVSqEOArAXz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r81IaOn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E52C433C7;
	Mon, 29 Jan 2024 17:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548431;
	bh=Fb0zjSGVBg4OS7RwO5ilcwwg9R8jxFv+7Cat7s/niJ8=;
	h=From:To:Cc:Subject:Date:From;
	b=r81IaOn3pxE6TvLn0B9D37wNEWdh8dgUhFCdUZUr6a+xqHvO2EFwmkgrq2OmKRfDD
	 rVqeKb8eL9os6IKC/bd2PFwRigDoKDmIjDVJ6SpVnGehM1Z0HtQ/a0YWhWTWQXNxJX
	 bFDYDM48W5MkRBpWtFvEdnvfiJJz+3/queBX6asY=
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
Subject: [PATCH 6.6 000/331] 6.6.15-rc1 review
Date: Mon, 29 Jan 2024 09:01:04 -0800
Message-ID: <20240129170014.969142961@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.15-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.15-rc1
X-KernelTest-Deadline: 2024-01-31T17:00+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.6.15 release.
There are 331 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.15-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.6.15-rc1

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    thermal: trip: Drop lockdep assertion from thermal_zone_trip_id()

Randy Dunlap <rdunlap@infradead.org>
    serial: core: fix kernel-doc for uart_port_unlock_irqrestore()

Richard Palethorpe <rpalethorpe@suse.com>
    x86/entry/ia32: Ensure s32 is sign extended to s64

Tim Chen <tim.c.chen@linux.intel.com>
    tick/sched: Preserve number of idle sleeps across CPU hotplug events

Jiri Wiesner <jwiesner@suse.de>
    clocksource: Skip watchdog check for large watchdog intervals

Dawei Li <dawei.li@shingroup.cn>
    genirq: Initialize resend_node hlist for all interrupt descriptors

Xi Ruoyao <xry111@xry111.site>
    mips: Call lose_fpu(0) before initializing fcr31 in mips_set_personality_nan

Quanquan Cao <caoqq@fujitsu.com>
    cxl/region：Fix overflow issue in alloc_hpa()

Michael Walle <mwalle@kernel.org>
    drm: bridge: samsung-dsim: Don't use FORCE_STOP_STATE

Aleksander Jan Bajkowski <olek2@wp.pl>
    MIPS: lantiq: register smp_ops on non-smp platforms

David Lechner <dlechner@baylibre.com>
    spi: fix finalize message on error return

Shyam Prasad N <sprasad@microsoft.com>
    cifs: fix stray unlock in cifs_chan_skip_or_disable

Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
    spi: spi-cadence: Reverse the order of interleaved write and read operations

Kamal Dasu <kamal.dasu@broadcom.com>
    spi: bcm-qspi: fix SFDP BFPT read by usig mspi read

Mario Limonciello <mario.limonciello@amd.com>
    cpufreq/amd-pstate: Fix setting scaling max/min freq values

Hsin-Yi Wang <hsinyi@chromium.org>
    drm/bridge: anx7625: Ensure bridge is suspended in disable()

Li Lingfeng <lilingfeng3@huawei.com>
    block: Move checking GENHD_FL_NO_PART to bdev_add_partition()

Mika Westerberg <mika.westerberg@linux.intel.com>
    spi: intel-pci: Remove Meteor Lake-S SoC PCI ID from the list

Artur Weber <aweber.kernel@gmail.com>
    ARM: dts: exynos4212-tab3: add samsung,invert-vclk flag to fimd

Wenhua Lin <Wenhua.Lin@unisoc.com>
    gpio: eic-sprd: Clear interrupt after set the interrupt type

Cristian Marussi <cristian.marussi@arm.com>
    firmware: arm_scmi: Use xa_insert() when saving raw queues

Cristian Marussi <cristian.marussi@arm.com>
    firmware: arm_scmi: Use xa_insert() to store opps

Fedor Pchelkin <pchelkin@ispras.ru>
    drm/exynos: gsc: minor fix for loop iteration in gsc_runtime_resume

Arnd Bergmann <arnd@arndb.de>
    drm/exynos: fix accidental on-stack copy of exynos_drm_plane

Yajun Deng <yajun.deng@linux.dev>
    memblock: fix crash when reserved memory is not added to memory

Douglas Anderson <dianders@chromium.org>
    drm/bridge: parade-ps8640: Make sure we drop the AUX mutex in the error case

Pin-yen Lin <treapking@chromium.org>
    drm/bridge: parade-ps8640: Ensure bridge is suspended in .post_disable()

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/bridge: sii902x: Fix audio codec unregistration

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/bridge: sii902x: Fix probing race issue

Artur Weber <aweber.kernel@gmail.com>
    drm/panel: samsung-s6d7aa0: drop DRM_BUS_FLAG_DE_HIGH for lsl080al02

Markus Niebel <Markus.Niebel@ew.tq-group.com>
    drm: panel-simple: add missing bus flags for Tianma tm070jvhg[30/33]

Douglas Anderson <dianders@chromium.org>
    drm/bridge: parade-ps8640: Wait for HPD when doing an AUX transfer

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/gfx11: set UNORD_DISPATCH in compute MQDs

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu/gfx10: set UNORD_DISPATCH in compute MQDs

Hsin-Yi Wang <hsinyi@chromium.org>
    drm/panel-edp: drm/panel-edp: Fix AUO B116XTN02 name

Hsin-Yi Wang <hsinyi@chromium.org>
    drm/panel-edp: drm/panel-edp: Fix AUO B116XAK01 name and timing

Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
    drm/panel-edp: Add AUO B116XTN02, BOE NT116WHM-N21,836X2, NV116WHM-N49 V8.0

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915/psr: Only allow PSR in LPSP mode on HSW non-ULT

Mika Kahola <mika.kahola@intel.com>
    drm/i915/lnl: Remove watchdog timers for PSR

Naohiro Aota <naohiro.aota@wdc.com>
    btrfs: zoned: optimize hint byte for zoned allocator

Naohiro Aota <naohiro.aota@wdc.com>
    btrfs: zoned: factor out prepare_allocation_zoned()

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: sc16is7xx: fix unconditional activation of THRI interrupt

Thomas Gleixner <tglx@linutronix.de>
    serial: sc16is7xx: Use port lock wrappers

Thomas Gleixner <tglx@linutronix.de>
    serial: core: Provide port lock wrappers

Baolin Wang <baolin.wang@linux.alibaba.com>
    mm: migrate: fix getting incorrect page mapping during page migration

Baolin Wang <baolin.wang@linux.alibaba.com>
    mm: migrate: record the mlocked page status to remove unnecessary lru drain

Di Shen <di.shen@unisoc.com>
    thermal: gov_power_allocator: avoid inability to reset a cdev

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    thermal: core: Store trip pointer in struct thermal_instance

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    thermal: trip: Drop redundant trips check from for_each_thermal_trip()

Alexander Stein <alexander.stein@ew.tq-group.com>
    media: i2c: imx290: Properly encode registers as little-endian

Alexander Stein <alexander.stein@ew.tq-group.com>
    media: v4l2-cci: Add support for little-endian encoded registers

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: v4l: cci: Add macros to obtain register width and address

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: v4l: cci: Include linux/bits.h

Lukas Schauer <lukas@schauer.dev>
    pipe: wakeup wr_wait after setting max_usage

Max Kellermann <max.kellermann@ionos.com>
    fs/pipe: move check to pipe_has_watch_queue()

Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
    thermal: intel: hfi: Add syscore callbacks for system-wide PM

Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
    thermal: intel: hfi: Disable an HFI instance when all its CPUs go offline

Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
    thermal: intel: hfi: Refactor enabling code into helper functions

Martin KaFai Lau <martin.lau@kernel.org>
    net/bpf: Avoid unused "sin_addr_len" warning when CONFIG_CGROUP_BPF is not set

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amd/display: Fix uninitialized variable usage in core_link_ 'read_dpcd() & write_dpcd()' functions

Ma Jun <Jun.Ma2@amd.com>
    drm/amdgpu/pm: Fix the power source flag error

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amd/display: Fix late derefrence 'dsc' check in 'link_set_dsc_pps_packet()'

Wayne Lin <Wayne.Lin@amd.com>
    drm/amd/display: Align the returned error code with legacy DP

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Port DENTIST hang and TDR fixes to OTG disable W/A

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amd/display: Fix variable deferencing before NULL check in edp_setup_replay()

Likun Gao <Likun.Gao@amd.com>
    drm/amdgpu: correct the cu count for gfx v11

Dan Carpenter <dan.carpenter@linaro.org>
    drm/bridge: nxp-ptn3460: simplify some error checking

Ivan Lipski <ivlipski@amd.com>
    Revert "drm/amd/display: fix bandwidth validation failure on DCN 2.1"

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd/display: Disable PSR-SU on Parade 0803 TCON again

Melissa Wen <mwen@igalia.com>
    drm/amd/display: fix bandwidth validation failure on DCN 2.1

Javier Martinez Canillas <javierm@redhat.com>
    drm: Allow drivers to indicate the damage helpers to ignore damage clips

Javier Martinez Canillas <javierm@redhat.com>
    drm/virtio: Disable damage clipping if FB changed since last page-flip

Zack Rusin <zackr@vmware.com>
    drm: Disable the cursor plane on atomic contexts with virtualized drivers

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/tidss: Fix atomic_flush check

Thomas Zimmermann <tzimmermann@suse.de>
    drm: Fix TODO list mentioning non-KMS drivers

Dan Carpenter <dan.carpenter@linaro.org>
    drm/bridge: nxp-ptn3460: fix i2c_master_send() error checking

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm: Don't unref the same fb many times by mistake due to deadlock handling

Ville Syrjälä <ville.syrjala@linux.intel.com>
    Revert "drm/i915/dsi: Do display on sequence later on icl+"

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    cpufreq: intel_pstate: Refine computation of P-state for given frequency

Mario Limonciello <mario.limonciello@amd.com>
    gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-04

Dave Chinner <dchinner@redhat.com>
    xfs: read only mounts with fsopen mount API are busted

Ma Jun <Jun.Ma2@amd.com>
    drm/amdgpu: Fix the null pointer when load rlc firmware

Thomas Zimmermann <tzimmermann@suse.de>
    Revert "drivers/firmware: Move sysfb_init() from device_initcall to subsys_initcall_sync"

Cristian Marussi <cristian.marussi@arm.com>
    firmware: arm_scmi: Check mailbox/SMT channel for consistency

Lin Ma <linma@zju.edu.cn>
    ksmbd: fix global oob in ksmbd_nl_policy

Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
    platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe

Nathan Chancellor <nathan@kernel.org>
    platform/x86: intel-uncore-freq: Fix types in sysfs callbacks

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: reject QUEUE/DROP verdict parameters

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_chain_filter: handle NETDEV_UNREGISTER for inet/ingress basechain

Michael Kelley <mhklinux@outlook.com>
    hv_netvsc: Calculate correct ring size when PAGE_SIZE is not 4 Kbytes

NeilBrown <neilb@suse.de>
    nfsd: fix RELEASE_LOCKOWNER

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    wifi: iwlwifi: fix a memory corruption

Bernd Edlinger <bernd.edlinger@hotmail.de>
    exec: Fix error handling in begin_new_exec()

Ilya Dryomov <idryomov@gmail.com>
    rbd: don't move requests to the running list on errors

Omar Sandoval <osandov@fb.com>
    btrfs: don't abort filesystem when attempting to snapshot deleted subvolume

Qu Wenruo <wqu@suse.com>
    btrfs: defrag: reject unknown flags of btrfs_ioctl_defrag_range_args

David Sterba <dsterba@suse.com>
    btrfs: don't warn if discard range is not aligned to sector

Chung-Chiang Cheng <cccheng@synology.com>
    btrfs: tree-checker: fix inline ref size in error messages

Fedor Pchelkin <pchelkin@ispras.ru>
    btrfs: ref-verify: free ref cache before clearing mount opt

Omar Sandoval <osandov@fb.com>
    btrfs: avoid copying BTRFS_ROOT_SUBVOL_DEAD flag to snapshot of subvolume being deleted

Naohiro Aota <naohiro.aota@wdc.com>
    btrfs: zoned: fix lock ordering in btrfs_zone_activate()

Qu Wenruo <wqu@suse.com>
    btrfs: scrub: avoid use-after-free when chunk length is not 64K aligned

Gerhard Engleder <gerhard@engleder-embedded.com>
    tsnep: Fix XDP_RING_NEED_WAKEUP for empty fill ring

Gerhard Engleder <gerhard@engleder-embedded.com>
    tsnep: Remove FCS for XDP data path

Shenwei Wang <shenwei.wang@nxp.com>
    net: fec: fix the unhandled context fault from smmu

Hangbin Liu <liuhangbin@gmail.com>
    selftests: bonding: do not test arp/ns target with mode balance-alb/tlb

Zhipeng Lu <alexious@zju.edu.cn>
    fjes: fix memleaks in fjes_hw_setup

Maciej Fijalkowski <maciej.fijalkowski@intel.com>
    i40e: update xdp_rxq_info::frag_size for ZC enabled Rx queue

Maciej Fijalkowski <maciej.fijalkowski@intel.com>
    i40e: set xdp_rxq_info::frag_size

Maciej Fijalkowski <maciej.fijalkowski@intel.com>
    xdp: reflect tail increase for MEM_TYPE_XSK_BUFF_POOL

Maciej Fijalkowski <maciej.fijalkowski@intel.com>
    ice: update xdp_rxq_info::frag_size for ZC enabled Rx queue

Maciej Fijalkowski <maciej.fijalkowski@intel.com>
    intel: xsk: initialize skb_frag_t::bv_offset in ZC drivers

Maciej Fijalkowski <maciej.fijalkowski@intel.com>
    ice: remove redundant xdp_rxq_info registration

Tirthendu Sarkar <tirthendu.sarkar@intel.com>
    i40e: handle multi-buffer packets that are shrunk by xdp prog

Maciej Fijalkowski <maciej.fijalkowski@intel.com>
    ice: work on pre-XDP prog frag count

Maciej Fijalkowski <maciej.fijalkowski@intel.com>
    xsk: fix usage of multi-buffer BPF helpers for ZC XDP

Daan De Meyer <daan.j.demeyer@gmail.com>
    bpf: Add bpf_sock_addr_set_sun_path() to allow writing unix sockaddr from bpf

Daan De Meyer <daan.j.demeyer@gmail.com>
    bpf: Propagate modified uaddrlen from cgroup sockaddr programs

Maciej Fijalkowski <maciej.fijalkowski@intel.com>
    xsk: make xsk_buff_pool responsible for clearing xdp_buff::flags

Maciej Fijalkowski <maciej.fijalkowski@intel.com>
    xsk: recycle buffer in case Rx queue was full

Jakub Kicinski <kuba@kernel.org>
    selftests: netdevsim: fix the udp_tunnel_nic test

Jakub Kicinski <kuba@kernel.org>
    selftests: net: fix rps_default_mask with >32 CPUs

Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
    net: mvpp2: clear BM pool before initialization

Bernd Edlinger <bernd.edlinger@hotmail.de>
    net: stmmac: Wait a bit for the reset to take effect

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: validate NFPROTO_* family

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: restrict anonymous set and map names to 16 bytes

Florian Westphal <fw@strlen.de>
    netfilter: nft_limit: reject configurations that cause integer overflow

Frederic Weisbecker <frederic@kernel.org>
    rcu: Defer RCU kthreads wakeup when CPU is dying

Dinghao Liu <dinghao.liu@zju.edu.cn>
    net/mlx5e: fix a potential double-free in fs_any_create_groups

Zhipeng Lu <alexious@zju.edu.cn>
    net/mlx5e: fix a double-free in arfs_create_groups

Leon Romanovsky <leon@kernel.org>
    net/mlx5e: Ignore IPsec replay window values on sender side

Leon Romanovsky <leon@kernel.org>
    net/mlx5e: Allow software parsing when IPsec crypto is enabled

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    net/mlx5: Use mlx5 device constant for selecting CQ period mode for ASO

Yevgeny Kliteynik <kliteyn@nvidia.com>
    net/mlx5: DR, Can't go to uplink vport on RX rule

Yevgeny Kliteynik <kliteyn@nvidia.com>
    net/mlx5: DR, Use the right GVMI number for drop action

Moshe Shemesh <moshe@nvidia.com>
    net/mlx5: Bridge, fix multicast packets sent to uplink

Erez Shitrit <erezsh@nvidia.com>
    net/mlx5: Bridge, Enable mcast in smfs steering mode

Yishai Hadas <yishaih@nvidia.com>
    net/mlx5: Fix a WARN upon a callback command failure

Vlad Buslov <vladbu@nvidia.com>
    net/mlx5e: Fix peer flow lists handling

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    net/mlx5e: Fix operation precedence bug in port timestamping napi_poll context

Ido Schimmel <idosch@nvidia.com>
    net/sched: flower: Fix chain template offload

Jakub Kicinski <kuba@kernel.org>
    selftests: fill in some missing configs for net

Zhengchao Shao <shaozhengchao@huawei.com>
    ipv6: init the accept_queue's spinlocks in inet6_create

Zhengchao Shao <shaozhengchao@huawei.com>
    netlink: fix potential sleeping issue in mqueue_flush_file

Kuniyuki Iwashima <kuniyu@amazon.com>
    selftest: Don't reuse port for SO_INCOMING_CPU test.

Salvatore Dipietro <dipiets@amazon.com>
    tcp: Add memory barrier to tcp_push()

David Howells <dhowells@redhat.com>
    afs: Hide silly-rename files from userspace

Petr Pavlu <petr.pavlu@suse.com>
    tracing: Ensure visibility when inserting an element into tracing_map

Dan Carpenter <dan.carpenter@linaro.org>
    netfs, fscache: Prevent Oops in fscache_put_cache()

Sharath Srinivasan <sharath.srinivasan@oracle.com>
    net/rds: Fix UBSAN: array-index-out-of-bounds in rds_cmsg_recv

Horatiu Vultur <horatiu.vultur@microchip.com>
    net: micrel: Fix PTP frame parsing for lan8814

Yunjian Wang <wangyunjian@huawei.com>
    tun: add missing rx stats accounting in tun_xdp_act

Yunjian Wang <wangyunjian@huawei.com>
    tun: fix missing dropped counter in tun_xdp_act

Jakub Kicinski <kuba@kernel.org>
    net: fix removing a namespace with conflicting altnames

Eric Dumazet <edumazet@google.com>
    udp: fix busy polling

Kuniyuki Iwashima <kuniyu@amazon.com>
    llc: Drop support for ETH_P_TR_802_2.

Eric Dumazet <edumazet@google.com>
    llc: make llc_ui_sendmsg() more robust against bonding changes

Lin Ma <linma@zju.edu.cn>
    vlan: skip nested type that is not IFLA_VLAN_QOS_MAPPING

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Prevent kernel warning when running offline self test

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Wait for FLR to complete during probe

Zhengchao Shao <shaozhengchao@huawei.com>
    tcp: make sure init the accept_queue's spinlocks once

Benjamin Poirier <bpoirier@nvidia.com>
    selftests: bonding: Increase timeout to 1200s

Wen Gu <guwen@linux.alibaba.com>
    net/smc: fix illegal rmb_desc access in SMC-D connection dump

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: fix potential sta-link leak

Lucas Stach <l.stach@pengutronix.de>
    SUNRPC: use request size to initialize bio_vec in svc_udp_sendto()

Shyam Prasad N <sprasad@microsoft.com>
    cifs: after disabling multichannel, mark tcon for reconnect

Shyam Prasad N <sprasad@microsoft.com>
    cifs: fix a pending undercount of srv_count

Shyam Prasad N <sprasad@microsoft.com>
    cifs: fix lock ordering while disabling multichannel

Jonathan Gray <jsg@jsg.id.au>
    Revert "drm/amd: Enable PCIe PME from D3"

Eduard Zingerman <eddyz87@gmail.com>
    selftests/bpf: check if max number of bpf_loop iterations is tracked

Eduard Zingerman <eddyz87@gmail.com>
    bpf: keep track of max number of bpf_loop callback iterations

Eduard Zingerman <eddyz87@gmail.com>
    selftests/bpf: test widening for iterating callbacks

Eduard Zingerman <eddyz87@gmail.com>
    bpf: widening for callback iterators

Eduard Zingerman <eddyz87@gmail.com>
    selftests/bpf: tests for iterating callbacks

Eduard Zingerman <eddyz87@gmail.com>
    bpf: verify callbacks as if they are called unknown number of times

Eduard Zingerman <eddyz87@gmail.com>
    bpf: extract setup_func_entry() utility function

Eduard Zingerman <eddyz87@gmail.com>
    bpf: extract __check_reg_arg() utility function

Eduard Zingerman <eddyz87@gmail.com>
    selftests/bpf: track string payload offset as scalar in strobemeta

Eduard Zingerman <eddyz87@gmail.com>
    selftests/bpf: track tcp payload offset as scalar in xdp_synproxy

Eduard Zingerman <eddyz87@gmail.com>
    bpf: print full verifier states on infinite loop detection

Eduard Zingerman <eddyz87@gmail.com>
    selftests/bpf: test if state loops are detected in a tricky case

Eduard Zingerman <eddyz87@gmail.com>
    bpf: correct loop detection for iterators convergence

Eduard Zingerman <eddyz87@gmail.com>
    selftests/bpf: tests with delayed read/precision makrs in loop body

Eduard Zingerman <eddyz87@gmail.com>
    bpf: exact states comparison for iterator convergence checks

Eduard Zingerman <eddyz87@gmail.com>
    bpf: extract same_callsites() as utility function

Eduard Zingerman <eddyz87@gmail.com>
    bpf: move explored_state() closer to the beginning of verifier.c

Rohan G Thomas <rohan.g.thomas@intel.com>
    dt-bindings: net: snps,dwmac: Tx coe unsupported

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: Add missing set_freezable() for freezable kthread

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: send lease break notification on FILE_RENAME_INFORMATION

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: don't increment epoch if current state and request state are same

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: fix potential circular locking issue in smb2_set_ea()

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: set v2 lease version on lease upgrade

Lino Sanfilippo <l.sanfilippo@kunbus.com>
    serial: Do not hold the port lock when setting rx-during-tx GPIO

Charan Teja Kalla <quic_charante@quicinc.com>
    mm: page_alloc: unreserve highatomic page blocks before oom

Huacai Chen <chenhuacai@kernel.org>
    LoongArch/smp: Call rcutree_report_cpu_starting() earlier

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: sc16is7xx: improve do/while loop in sc16is7xx_irq()

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: sc16is7xx: remove obsolete loop in sc16is7xx_port_irq()

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: sc16is7xx: fix invalid sc16is7xx_lines bitfield in case of probe error

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: sc16is7xx: convert from _raw_ to _noinc_ regmap functions for FIFO

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: sc16is7xx: change EFR lock to operate on each channels

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: sc16is7xx: remove unused line structure member

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: sc16is7xx: remove global regmap from struct sc16is7xx_port

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: sc16is7xx: remove wasteful static buffer in sc16is7xx_regmap_name()

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: sc16is7xx: improve regmap debugfs by using one regmap per port

Al Viro <viro@zeniv.linux.org.uk>
    rename(): fix the locking of subdirectories

Charan Teja Kalla <quic_charante@quicinc.com>
    mm/sparsemem: fix race in accessing memory_section->usage

Steven Rostedt (Google) <rostedt@goodmis.org>
    mm/rmap: fix misplaced parenthesis of a likely()

Donet Tom <donettom@linux.vnet.ibm.com>
    selftests: mm: hugepage-vmemmap fails on 64K page size systems

James Gowans <jgowans@amazon.com>
    kexec: do syscore_shutdown() in kernel_kexec

Zhihao Cheng <chengzhihao1@huawei.com>
    ubifs: ubifs_symlink: Fix memleak of inode->i_link in error path

Ma Wupeng <mawupeng1@huawei.com>
    efi: disable mirror feature during crashkernel

Dave Airlie <airlied@redhat.com>
    nouveau/vmm: don't set addr on the fail path to avoid warning

Mario Limonciello <mario.limonciello@amd.com>
    rtc: Extend timeout for waiting for UIP to clear to 1s

Mario Limonciello <mario.limonciello@amd.com>
    rtc: Add support for configuring the UIP timeout for RTC reads

Mario Limonciello <mario.limonciello@amd.com>
    rtc: mc146818-lib: Adjust failure return code for mc146818_get_time()

Mario Limonciello <mario.limonciello@amd.com>
    rtc: Adjust failure return code for cmos_set_alarm()

Mario Limonciello <mario.limonciello@amd.com>
    rtc: cmos: Use ACPI alarm for non-Intel x86 systems too

Mark Rutland <mark.rutland@arm.com>
    arm64: entry: fix ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD

Mark Brown <broonie@kernel.org>
    arm64/sme: Always exit sme_alloc() early with existing storage

Rob Herring <robh@kernel.org>
    arm64: errata: Add Cortex-A510 speculative unprivileged load workaround

Rob Herring <robh@kernel.org>
    arm64: Rename ARM64_WORKAROUND_2966298

Guo Ren <guoren@kernel.org>
    riscv: mm: Fixup compat mode boot failure

Guo Ren <guoren@kernel.org>
    riscv: mm: Fixup compat arch_get_mmap_end

Zheng Wang <zyytlz.wz@163.com>
    media: mtk-jpeg: Fix use after free bug due to error path handling in mtk_jpeg_dec_device_run

Zheng Wang <zyytlz.wz@163.com>
    media: mtk-jpeg: Fix timeout schedule error in mtk_jpegdec_worker.

Alain Volmat <alain.volmat@foss.st.com>
    media: i2c: st-mipid02: correct format propagation

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    mmc: mmc_spi: remove custom DMA mapped buffers

Avri Altman <avri.altman@wdc.com>
    mmc: core: Use mrq.sbc in close-ended ffu

Michael Grzeschik <m.grzeschik@pengutronix.de>
    media: videobuf2-dma-sg: fix vmap callback

Vegard Nossum <vegard.nossum@oracle.com>
    scripts/get_abi: fix source path leak

Vegard Nossum <vegard.nossum@oracle.com>
    docs: kernel_abi.py: fix command injection

Jordan Rife <jrife@google.com>
    dlm: use kernel_connect() and kernel_bind()

Alfred Piccioni <alpic@google.com>
    lsm: new security_file_ioctl_compat() hook

Johan Hovold <johan+linaro@kernel.org>
    ARM: dts: qcom: sdx55: fix USB SS wakeup

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sdm670: fix USB SS wakeup

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sdm670: fix USB DP/DM HS PHY interrupts

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sc8180x: fix USB SS wakeup

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sc8180x: fix USB DP/DM HS PHY interrupts

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sm8150: fix USB SS wakeup

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sm8150: fix USB DP/DM HS PHY interrupts

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sdm845: fix USB SS wakeup

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sdm845: fix USB DP/DM HS PHY interrupts

Johan Hovold <johan+linaro@kernel.org>
    ARM: dts: qcom: sdx55: fix USB DP/DM HS PHY interrupts

Stephan Gerhold <stephan@gerhold.net>
    arm64: dts: qcom: Add missing vio-supply for AW2013

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sc7280: fix usb_1 wakeup interrupt types

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sc8180x: fix USB wakeup interrupt types

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sm8150: fix USB wakeup interrupt types

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sdm670: fix USB wakeup interrupt types

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sdm845: fix USB wakeup interrupt types

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sc7180: fix USB wakeup interrupt types

Stephan Gerhold <stephan@gerhold.net>
    arm64: dts: qcom: msm8939: Make blsp_dma controlled-remotely

Stephan Gerhold <stephan@gerhold.net>
    arm64: dts: qcom: msm8916: Make blsp_dma controlled-remotely

Sam Edwards <cfsworks@gmail.com>
    arm64: dts: rockchip: Fix rk3588 USB power-domain clocks

Tianling Shen <cnsztl@gmail.com>
    arm64: dts: rockchip: configure eth pad driver strength for orangepi r1 plus lts

Cixi Geng <cixi.geng1@unisoc.com>
    arm64: dts: sprd: fix the cpu node for UMS512

Johan Hovold <johan+linaro@kernel.org>
    ARM: dts: qcom: sdx55: fix pdc '#interrupt-cells'

Paul Cercueil <paul@crapouillou.net>
    ARM: dts: samsung: exynos4210-i9100: Unconditionally enable LDO12

Johan Hovold <johan+linaro@kernel.org>
    ARM: dts: qcom: sdx55: fix USB wakeup interrupt types

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sc8280xp-crd: fix eDP phy compatible

Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
    ARM: dts: imx6q-apalis: add can power-up delay on ixora board

Helge Deller <deller@gmx.de>
    parisc/power: Fix power soft-off button emulation on qemu

Helge Deller <deller@gmx.de>
    parisc/firmware: Fix F-extend for PDC addresses

Bhaumik Bhatt <bbhatt@codeaurora.org>
    bus: mhi: host: Add spinlock to protect WP access when queueing TREs

Qiang Yu <quic_qianyu@quicinc.com>
    bus: mhi: host: Drop chan lock before queuing buffers

Krishna chaitanya chundru <quic_krichai@quicinc.com>
    bus: mhi: host: Add alignment check for event ring read pointer

Serge Semin <fancer.lancer@gmail.com>
    mips: Fix max_mapnr being uninitialized on early stages

Eric Dumazet <edumazet@google.com>
    nbd: always initialize struct msghdr completely

Tony Krowiak <akrowiak@linux.ibm.com>
    s390/vfio-ap: do not reset queue removed from host config

Tony Krowiak <akrowiak@linux.ibm.com>
    s390/vfio-ap: reset queues associated with adapter for queue unbound from driver

Tony Krowiak <akrowiak@linux.ibm.com>
    s390/vfio-ap: reset queues filtered from the guest's AP config

Tony Krowiak <akrowiak@linux.ibm.com>
    s390/vfio-ap: let on_scan_complete() callback filter matrix and update guest's APCB

Tony Krowiak <akrowiak@linux.ibm.com>
    s390/vfio-ap: loop over the shadow APCB when filtering guest's AP configuration

Tony Krowiak <akrowiak@linux.ibm.com>
    s390/vfio-ap: always filter entire AP matrix

Herve Codina <herve.codina@bootlin.com>
    soc: fsl: cpm1: qmc: Fix rx channel reset

Herve Codina <herve.codina@bootlin.com>
    soc: fsl: cpm1: qmc: Fix __iomem addresses declaration

Herve Codina <herve.codina@bootlin.com>
    soc: fsl: cpm1: tsa: Fix __iomem addresses declaration

Bingbu Cao <bingbu.cao@intel.com>
    media: ov01a10: Enable runtime PM before registering async sub-device

Bingbu Cao <bingbu.cao@intel.com>
    media: ov13b10: Enable runtime PM before registering async sub-device

Bingbu Cao <bingbu.cao@intel.com>
    media: ov9734: Enable runtime PM before registering async sub-device

Xiaolei Wang <xiaolei.wang@windriver.com>
    rpmsg: virtio: Free driver_override when rpmsg_remove()

Bingbu Cao <bingbu.cao@intel.com>
    media: imx355: Enable runtime PM before registering async sub-device

Johan Hovold <johan+linaro@kernel.org>
    soc: qcom: pmic_glink_altmode: fix port sanity check

Miquel Raynal <miquel.raynal@bootlin.com>
    mtd: rawnand: Clarify conditions to enable continuous reads

Miquel Raynal <miquel.raynal@bootlin.com>
    mtd: rawnand: Prevent sequential reads with on-die ECC engines

Miquel Raynal <miquel.raynal@bootlin.com>
    mtd: rawnand: Fix core interference with sequential reads

Miquel Raynal <miquel.raynal@bootlin.com>
    mtd: rawnand: Prevent crossing LUN boundaries during sequential reads

Miquel Raynal <miquel.raynal@bootlin.com>
    mtd: maps: vmu-flash: Fix the (mtd core) switch to ref counters

Christian Marangi <ansuelsmth@gmail.com>
    PM / devfreq: Fix buffer overflow in trans_stat_show

Anthony Krowiak <akrowiak@linux.ibm.com>
    s390/vfio-ap: unpin pages on gisc registration failure

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: s390/aes - Fix buffer overread in CTR mode

Herbert Xu <herbert@gondor.apana.org.au>
    hwrng: core - Fix page fault dead lock on mmap-ed hwrng

Hongchen Zhang <zhanghongchen@loongson.cn>
    PM: hibernate: Enforce ordering during image compression/decompression

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: api - Disallow identical driver names

Gao Xiang <xiang@kernel.org>
    erofs: fix lz4 inplace decompression

Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
    crypto: lib/mpi - Fix unexpected pointer access in mpi_ec_init

David Disseldorp <ddiss@suse.de>
    btrfs: sysfs: validate scrub_speed_max value

Viresh Kumar <viresh.kumar@linaro.org>
    OPP: Pass rounded rate to _set_opp()

Josef Bacik <josef@toxicpanda.com>
    arm64: properly install vmlinuz.efi

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PM: sleep: Fix possible deadlocks in core system-wide PM code

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    async: Introduce async_schedule_dev_nocall()

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    async: Split async_schedule_node_domain()

Suraj Jitindar Singh <surajjs@amazon.com>
    ext4: allow for the last group to be marked as trimmed

Geoff Levand <geoff@infradead.org>
    powerpc/ps3_defconfig: Disable PPC64_BIG_ENDIAN_ELF_ABI_V2

Shyam Prasad N <sprasad@microsoft.com>
    cifs: update iface_last_update on each query-and-update

Shyam Prasad N <sprasad@microsoft.com>
    cifs: handle servers that still advertise multichannel after disabling

Shyam Prasad N <sprasad@microsoft.com>
    cifs: reconnect worker should take reference on server struct unconditionally

Shyam Prasad N <sprasad@microsoft.com>
    Revert "cifs: reconnect work should have reference on server struct"

Shyam Prasad N <sprasad@microsoft.com>
    cifs: handle when server stops supporting multichannel

Shyam Prasad N <sprasad@microsoft.com>
    cifs: handle when server starts supporting multichannel

Shyam Prasad N <sprasad@microsoft.com>
    cifs: reconnect work should have reference on server struct

Shyam Prasad N <sprasad@microsoft.com>
    cifs: handle cases where a channel is closed

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix parsing of SMB3.1.1 POSIX create context

Geert Uytterhoeven <geert+renesas@glider.be>
    sh: ecovec24: Rename missed backlight field from fbdev to dev

Niklas Cassel <cassel@kernel.org>
    scsi: core: Kick the requeue list after inserting when flushing

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    riscv: Fix an off-by-one in get_early_cmdline()

Bart Van Assche <bvanassche@acm.org>
    scsi: ufs: core: Remove the ufshcd_hba_exit() call from ufshcd_async_scan()

Rex Zhang <rex.zhang@intel.com>
    dmaengine: idxd: Move dma_free_coherent() out of spinlocked context

Amelie Delaunay <amelie.delaunay@foss.st.com>
    dmaengine: fix NULL pointer in channel unregistration function

Frank Li <Frank.Li@nxp.com>
    dmaengine: fsl-edma: fix eDMAv4 channel allocation issue

Marcelo Schmitt <marcelo.schmitt@analog.com>
    iio: adc: ad7091r: Enable internal vref if external vref is not supplied

Marcelo Schmitt <marcelo.schmitt@analog.com>
    iio: adc: ad7091r: Allow users to configure device events

Marcelo Schmitt <marcelo.schmitt@analog.com>
    iio: adc: ad7091r: Set alert bit in config register

Romain Gantois <romain.gantois@bootlin.com>
    net: stmmac: Prevent DSA tags from breaking COE

Rohan G Thomas <rohan.g.thomas@intel.com>
    net: stmmac: Tx coe sw fallback

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    soundwire: fix initializing sysfs for same devices on different buses

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    soundwire: bus: introduce controller_id

Lino Sanfilippo <l.sanfilippo@kunbus.com>
    serial: core: set missing supported flag for RX during TX GPIO

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    serial: core: Simplify uart_get_rs485_mode()

Vegard Nossum <vegard.nossum@oracle.com>
    docs: kernel_feat.py: fix potential command injection

Min-Hua Chen <minhuadotchen@gmail.com>
    docs: sparse: add sparse.rst to toctree

Min-Hua Chen <minhuadotchen@gmail.com>
    docs: sparse: move TW sparse.txt to TW dev-tools


-------------

Diffstat:

 Documentation/ABI/testing/sysfs-class-devfreq      |   3 +
 Documentation/admin-guide/abi-obsolete.rst         |   2 +-
 Documentation/admin-guide/abi-removed.rst          |   2 +-
 Documentation/admin-guide/abi-stable.rst           |   2 +-
 Documentation/admin-guide/abi-testing.rst          |   2 +-
 Documentation/admin-guide/features.rst             |   2 +-
 Documentation/arch/arc/features.rst                |   2 +-
 Documentation/arch/arm/features.rst                |   2 +-
 Documentation/arch/arm64/features.rst              |   2 +-
 Documentation/arch/arm64/silicon-errata.rst        |   2 +
 Documentation/arch/loongarch/features.rst          |   2 +-
 Documentation/arch/m68k/features.rst               |   2 +-
 Documentation/arch/mips/features.rst               |   2 +-
 Documentation/arch/nios2/features.rst              |   2 +-
 Documentation/arch/openrisc/features.rst           |   2 +-
 Documentation/arch/parisc/features.rst             |   2 +-
 Documentation/arch/s390/features.rst               |   2 +-
 Documentation/arch/sh/features.rst                 |   2 +-
 Documentation/arch/sparc/features.rst              |   2 +-
 Documentation/arch/x86/features.rst                |   2 +-
 Documentation/arch/xtensa/features.rst             |   2 +-
 .../devicetree/bindings/net/snps,dwmac.yaml        |   5 +
 Documentation/filesystems/directory-locking.rst    |  29 +-
 Documentation/filesystems/locking.rst              |   5 +-
 Documentation/filesystems/porting.rst              |  18 +
 Documentation/gpu/drm-kms.rst                      |   2 +
 Documentation/gpu/todo.rst                         |   7 +-
 Documentation/powerpc/features.rst                 |   2 +-
 Documentation/riscv/features.rst                   |   2 +-
 Documentation/sphinx/kernel_abi.py                 |  56 +-
 Documentation/sphinx/kernel_feat.py                |  55 +-
 .../translations/zh_CN/arch/loongarch/features.rst |   2 +-
 .../translations/zh_CN/arch/mips/features.rst      |   2 +-
 .../translations/zh_TW/dev-tools/index.rst         |  40 +
 .../translations/zh_TW/{ => dev-tools}/sparse.txt  |   0
 Documentation/translations/zh_TW/index.rst         |   2 +-
 Makefile                                           |   4 +-
 arch/alpha/kernel/rtc.c                            |   2 +-
 .../boot/dts/nxp/imx/imx6q-apalis-ixora-v1.2.dts   |   2 +
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi             |  10 +-
 arch/arm/boot/dts/samsung/exynos4210-i9100.dts     |   8 +
 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi     |   1 +
 arch/arm64/Kconfig                                 |  18 +
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts      |   1 +
 .../boot/dts/qcom/msm8916-wingtech-wt88047.dts     |   1 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   1 +
 arch/arm64/boot/dts/qcom/msm8939.dtsi              |   1 +
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-mido.dts   |   1 +
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dts |   1 +
 arch/arm64/boot/dts/qcom/msm8953-xiaomi-vince.dts  |   1 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |   4 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   4 +-
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              |  16 +-
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts          |   2 +
 arch/arm64/boot/dts/qcom/sdm670.dtsi               |   8 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |  16 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |  16 +-
 .../dts/rockchip/rk3328-orangepi-r1-plus-lts.dts   |   4 +-
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi          |   1 +
 arch/arm64/boot/dts/sprd/ums512.dtsi               |   4 +-
 arch/arm64/boot/install.sh                         |   3 +-
 arch/arm64/kernel/cpu_errata.c                     |  21 +-
 arch/arm64/kernel/entry.S                          |  22 +-
 arch/arm64/kernel/fpsimd.c                         |   6 +-
 arch/arm64/tools/cpucaps                           |   2 +-
 arch/loongarch/kernel/smp.c                        |   3 +-
 arch/mips/kernel/elf.c                             |   6 +
 arch/mips/lantiq/prom.c                            |   7 +-
 arch/mips/mm/init.c                                |  12 +-
 arch/parisc/kernel/firmware.c                      |   4 +-
 arch/powerpc/configs/ps3_defconfig                 |   1 +
 arch/riscv/include/asm/pgtable.h                   |   2 +-
 arch/riscv/include/asm/processor.h                 |   2 +-
 arch/riscv/kernel/pi/cmdline_early.c               |   3 +-
 arch/s390/crypto/aes_s390.c                        |   4 +-
 arch/s390/crypto/paes_s390.c                       |   4 +-
 arch/sh/boards/mach-ecovec24/setup.c               |   2 +-
 arch/x86/include/asm/syscall_wrapper.h             |  25 +-
 arch/x86/kernel/hpet.c                             |   2 +-
 arch/x86/kernel/rtc.c                              |   2 +-
 block/ioctl.c                                      |   2 -
 block/partitions/core.c                            |   5 +
 crypto/algapi.c                                    |   1 +
 drivers/base/power/main.c                          | 148 ++--
 drivers/base/power/trace.c                         |   2 +-
 drivers/block/nbd.c                                |   6 +-
 drivers/block/rbd.c                                |  22 +-
 drivers/bus/mhi/host/main.c                        |  29 +-
 drivers/char/hw_random/core.c                      |  34 +-
 drivers/cpufreq/amd-pstate.c                       |   7 +-
 drivers/cpufreq/intel_pstate.c                     |  55 +-
 drivers/cxl/core/region.c                          |   4 +-
 drivers/devfreq/devfreq.c                          |  57 +-
 drivers/dma/dmaengine.c                            |   3 +
 drivers/dma/fsl-edma-main.c                        |   8 +
 drivers/dma/idxd/device.c                          |   9 +-
 drivers/firmware/arm_scmi/common.h                 |   1 +
 drivers/firmware/arm_scmi/mailbox.c                |  14 +
 drivers/firmware/arm_scmi/perf.c                   |  23 +-
 drivers/firmware/arm_scmi/raw_mode.c               |  12 +-
 drivers/firmware/arm_scmi/shmem.c                  |   6 +
 drivers/firmware/sysfb.c                           |   2 +-
 drivers/gpio/gpio-eic-sprd.c                       |  32 +-
 drivers/gpio/gpiolib-acpi.c                        |  14 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   2 -
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  17 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c   |   1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |   5 +
 .../amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c |  21 +-
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |   8 +-
 .../drm/amd/display/dc/link/protocols/link_dpcd.c  |   4 +-
 .../dc/link/protocols/link_edp_panel_control.c     |  11 +-
 .../drm/amd/display/modules/power/power_helpers.c  |   2 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  13 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |   2 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |   2 +
 drivers/gpu/drm/bridge/analogix/anx7625.c          |   7 +-
 drivers/gpu/drm/bridge/analogix/anx7625.h          |   2 +
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |   6 +-
 drivers/gpu/drm/bridge/parade-ps8640.c             |  23 +
 drivers/gpu/drm/bridge/samsung-dsim.c              |  32 +-
 drivers/gpu/drm/bridge/sii902x.c                   |  42 +-
 drivers/gpu/drm/drm_damage_helper.c                |   3 +-
 drivers/gpu/drm/drm_plane.c                        |  14 +
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_fimd.c           |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_gsc.c            |   2 +-
 drivers/gpu/drm/i915/display/icl_dsi.c             |   3 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |  22 +-
 drivers/gpu/drm/nouveau/nouveau_vmm.c              |   3 +
 drivers/gpu/drm/panel/panel-edp.c                  |   7 +-
 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c      |   2 +-
 drivers/gpu/drm/panel/panel-simple.c               |   2 +
 drivers/gpu/drm/qxl/qxl_drv.c                      |   2 +-
 drivers/gpu/drm/tidss/tidss_crtc.c                 |  10 +-
 drivers/gpu/drm/vboxvideo/vbox_drv.c               |   2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c               |   2 +-
 drivers/gpu/drm/virtio/virtgpu_plane.c             |  10 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |   2 +-
 drivers/iio/adc/ad7091r-base.c                     | 169 ++++
 drivers/iio/adc/ad7091r-base.h                     |   8 +
 drivers/iio/adc/ad7091r5.c                         |  28 +-
 drivers/media/common/videobuf2/videobuf2-dma-sg.c  |  10 +-
 drivers/media/i2c/imx290.c                         |  42 +-
 drivers/media/i2c/imx355.c                         |  12 +-
 drivers/media/i2c/ov01a10.c                        |  18 +-
 drivers/media/i2c/ov13b10.c                        |  14 +-
 drivers/media/i2c/ov9734.c                         |  19 +-
 drivers/media/i2c/st-mipid02.c                     |   9 +-
 .../media/platform/mediatek/jpeg/mtk_jpeg_core.c   |  12 +-
 drivers/media/v4l2-core/v4l2-cci.c                 |  52 +-
 drivers/mmc/core/block.c                           |  46 +-
 drivers/mmc/host/mmc_spi.c                         | 186 +----
 drivers/mtd/maps/vmu-flash.c                       |   2 +-
 drivers/mtd/nand/raw/nand_base.c                   |  87 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   8 +
 drivers/net/ethernet/engleder/tsnep_main.c         |  17 +-
 drivers/net/ethernet/freescale/fec_main.c          |   2 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  47 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |  49 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c         |   4 +-
 drivers/net/ethernet/intel/ice/ice_base.c          |  37 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |  19 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h          |   1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h      |  31 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c           |   4 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |  27 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |   5 +-
 .../mellanox/mlx5/core/en/fs_tt_redirect.c         |   1 +
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |   2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |  10 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c  |  26 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   3 +-
 .../ethernet/mellanox/mlx5/core/esw/bridge_mcast.c |  14 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c  |   2 +-
 .../mellanox/mlx5/core/steering/dr_action.c        |  17 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  43 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   3 +
 drivers/net/fjes/fjes_hw.c                         |  37 +-
 drivers/net/hyperv/netvsc_drv.c                    |   4 +-
 drivers/net/phy/micrel.c                           |  11 +
 drivers/net/tun.c                                  |  10 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |   4 +-
 drivers/opp/core.c                                 |   6 +-
 drivers/parisc/power.c                             |   2 +-
 .../uncore-frequency/uncore-frequency-common.c     |  82 +-
 .../uncore-frequency/uncore-frequency-common.h     |  32 +-
 drivers/platform/x86/p2sb.c                        | 180 ++++-
 drivers/rpmsg/virtio_rpmsg_bus.c                   |   1 +
 drivers/rtc/rtc-cmos.c                             |  28 +-
 drivers/rtc/rtc-mc146818-lib.c                     |  39 +-
 drivers/s390/crypto/vfio_ap_ops.c                  | 269 ++++---
 drivers/s390/crypto/vfio_ap_private.h              |   3 +
 drivers/scsi/scsi_error.c                          |   9 +-
 drivers/soc/fsl/qe/qmc.c                           |  35 +-
 drivers/soc/fsl/qe/tsa.c                           |  22 +-
 drivers/soc/qcom/pmic_glink_altmode.c              |   4 +-
 drivers/soundwire/amd_manager.c                    |   8 +
 drivers/soundwire/bus.c                            |   4 +
 drivers/soundwire/debugfs.c                        |   2 +-
 drivers/soundwire/intel_auxdevice.c                |   3 +
 drivers/soundwire/master.c                         |   2 +-
 drivers/soundwire/qcom.c                           |   3 +
 drivers/soundwire/slave.c                          |  12 +-
 drivers/spi/spi-bcm-qspi.c                         |   4 +-
 drivers/spi/spi-cadence.c                          |  17 +-
 drivers/spi/spi-intel-pci.c                        |   1 -
 drivers/spi/spi.c                                  |   4 +
 drivers/thermal/gov_bang_bang.c                    |  23 +-
 drivers/thermal/gov_fair_share.c                   |   5 +-
 drivers/thermal/gov_power_allocator.c              |  13 +-
 drivers/thermal/gov_step_wise.c                    |  16 +-
 drivers/thermal/intel/intel_hfi.c                  | 106 ++-
 drivers/thermal/thermal_core.c                     |  15 +-
 drivers/thermal/thermal_core.h                     |   4 +-
 drivers/thermal/thermal_helpers.c                  |   5 +-
 drivers/thermal/thermal_sysfs.c                    |   3 +-
 drivers/thermal/thermal_trip.c                     |  16 +-
 drivers/tty/serial/imx.c                           |   4 -
 drivers/tty/serial/sc16is7xx.c                     | 389 ++++-----
 drivers/tty/serial/serial_core.c                   |  58 +-
 drivers/tty/serial/stm32-usart.c                   |   8 +-
 drivers/ufs/core/ufshcd.c                          |   7 +-
 fs/afs/dir.c                                       |   8 +
 fs/btrfs/extent-tree.c                             |  53 +-
 fs/btrfs/inode.c                                   |  22 +-
 fs/btrfs/ioctl.c                                   |   7 +
 fs/btrfs/ref-verify.c                              |   6 +-
 fs/btrfs/scrub.c                                   |  29 +-
 fs/btrfs/sysfs.c                                   |   4 +
 fs/btrfs/tree-checker.c                            |   2 +-
 fs/btrfs/zoned.c                                   |   8 +-
 fs/dlm/lowcomms.c                                  |  14 +-
 fs/erofs/decompressor.c                            |  31 +-
 fs/exec.c                                          |   3 +
 fs/ext4/mballoc.c                                  |  15 +-
 fs/fscache/cache.c                                 |   3 +-
 fs/ioctl.c                                         |   3 +-
 fs/namei.c                                         |  60 +-
 fs/nfsd/nfs4state.c                                |  26 +-
 fs/pipe.c                                          |  19 +-
 fs/smb/client/cifs_debug.c                         |   5 +
 fs/smb/client/cifsglob.h                           |   2 +
 fs/smb/client/cifsproto.h                          |   5 +-
 fs/smb/client/connect.c                            |  31 +-
 fs/smb/client/sess.c                               |  96 ++-
 fs/smb/client/smb2ops.c                            |  10 +-
 fs/smb/client/smb2pdu.c                            | 162 +++-
 fs/smb/client/smb2transport.c                      |   8 +-
 fs/smb/client/transport.c                          |   2 +-
 fs/smb/server/connection.c                         |   1 +
 fs/smb/server/ksmbd_netlink.h                      |   3 +-
 fs/smb/server/oplock.c                             |  16 +-
 fs/smb/server/smb2pdu.c                            |   8 +-
 fs/smb/server/transport_ipc.c                      |   4 +-
 fs/ubifs/dir.c                                     |   2 +
 fs/xfs/xfs_super.c                                 |  27 +-
 include/drm/drm_drv.h                              |   9 +
 include/drm/drm_file.h                             |  12 +
 include/drm/drm_plane.h                            |  10 +
 include/linux/async.h                              |   2 +
 include/linux/bpf-cgroup.h                         |  73 +-
 include/linux/bpf_verifier.h                       |  32 +
 include/linux/filter.h                             |   1 +
 include/linux/lsm_hook_defs.h                      |   2 +
 include/linux/mc146818rtc.h                        |   3 +-
 include/linux/mlx5/fs.h                            |   2 +
 include/linux/mlx5/mlx5_ifc.h                      |   2 +-
 include/linux/mmzone.h                             |  14 +-
 include/linux/mtd/rawnand.h                        |   2 +
 include/linux/pipe_fs_i.h                          |  16 +
 include/linux/rmap.h                               |   4 +-
 include/linux/security.h                           |   9 +
 include/linux/serial_core.h                        |  79 ++
 include/linux/skmsg.h                              |   6 -
 include/linux/soundwire/sdw.h                      |   4 +-
 include/linux/stmmac.h                             |   1 +
 include/linux/syscalls.h                           |   1 +
 include/media/v4l2-cci.h                           |  11 +
 include/net/inet_connection_sock.h                 |   8 +
 include/net/inet_sock.h                            |   5 -
 include/net/llc_pdu.h                              |   6 +-
 include/net/sch_generic.h                          |   4 +
 include/net/sock.h                                 |  18 +-
 include/net/xdp_sock_drv.h                         |  27 +
 include/uapi/linux/btrfs.h                         |   3 +
 kernel/async.c                                     |  85 +-
 kernel/bpf/btf.c                                   |   1 +
 kernel/bpf/cgroup.c                                |  17 +-
 kernel/bpf/verifier.c                              | 875 ++++++++++++++++-----
 kernel/irq/irqdesc.c                               |   2 +-
 kernel/kexec_core.c                                |   1 +
 kernel/power/swap.c                                |  38 +-
 kernel/rcu/tree.c                                  |  34 +-
 kernel/rcu/tree_exp.h                              |   3 +-
 kernel/time/clocksource.c                          |  25 +-
 kernel/time/tick-sched.c                           |   5 +
 kernel/trace/tracing_map.c                         |   7 +-
 lib/crypto/mpi/ec.c                                |   3 +
 mm/memblock.c                                      |   3 +
 mm/migrate.c                                       |  65 +-
 mm/mm_init.c                                       |   6 +
 mm/page_alloc.c                                    |  16 +-
 mm/sparse.c                                        |  17 +-
 net/8021q/vlan_netlink.c                           |   4 +
 net/core/dev.c                                     |   9 +
 net/core/dev.h                                     |   3 +
 net/core/filter.c                                  |  79 +-
 net/core/request_sock.c                            |   3 -
 net/core/sock.c                                    |  11 +-
 net/ipv4/af_inet.c                                 |  12 +-
 net/ipv4/inet_connection_sock.c                    |   4 +
 net/ipv4/ping.c                                    |   2 +-
 net/ipv4/tcp.c                                     |   1 +
 net/ipv4/tcp_ipv4.c                                |   2 +-
 net/ipv4/udp.c                                     |   9 +-
 net/ipv6/af_inet6.c                                |  12 +-
 net/ipv6/ping.c                                    |   2 +-
 net/ipv6/tcp_ipv6.c                                |   2 +-
 net/ipv6/udp.c                                     |   6 +-
 net/llc/af_llc.c                                   |  24 +-
 net/llc/llc_core.c                                 |   7 -
 net/mac80211/sta_info.c                            |   5 +-
 net/netfilter/nf_tables_api.c                      |  20 +-
 net/netfilter/nft_chain_filter.c                   |  11 +-
 net/netfilter/nft_compat.c                         |  12 +
 net/netfilter/nft_flow_offload.c                   |   5 +
 net/netfilter/nft_limit.c                          |  23 +-
 net/netfilter/nft_nat.c                            |   5 +
 net/netfilter/nft_rt.c                             |   5 +
 net/netfilter/nft_socket.c                         |   5 +
 net/netfilter/nft_synproxy.c                       |   7 +-
 net/netfilter/nft_tproxy.c                         |   5 +
 net/netfilter/nft_xfrm.c                           |   5 +
 net/netlink/af_netlink.c                           |   2 +-
 net/rds/af_rds.c                                   |   2 +-
 net/sched/cls_api.c                                |   9 +-
 net/sched/cls_flower.c                             |  23 +
 net/smc/smc_diag.c                                 |   2 +-
 net/sunrpc/svcsock.c                               |   4 +-
 net/xdp/xsk.c                                      |  12 +-
 net/xdp/xsk_buff_pool.c                            |   1 +
 scripts/get_abi.pl                                 |   2 +-
 security/security.c                                |  18 +
 security/selinux/hooks.c                           |  28 +
 security/smack/smack_lsm.c                         |   1 +
 security/tomoyo/tomoyo.c                           |   1 +
 sound/soc/intel/boards/sof_sdw.c                   |   4 +-
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 tools/testing/selftests/bpf/progs/cb_refs.c        |   1 +
 tools/testing/selftests/bpf/progs/iters.c          | 695 ++++++++++++++++
 tools/testing/selftests/bpf/progs/strobemeta.h     |  78 +-
 .../bpf/progs/verifier_iterating_callbacks.c       | 242 ++++++
 .../bpf/progs/verifier_subprog_precision.c         |  86 +-
 .../selftests/bpf/progs/xdp_synproxy_kern.c        |  84 +-
 .../selftests/drivers/net/bonding/bond_options.sh  |   8 +-
 .../testing/selftests/drivers/net/bonding/settings |   2 +-
 .../drivers/net/netdevsim/udp_tunnel_nic.sh        |   9 +
 tools/testing/selftests/mm/hugepage-vmemmap.c      |  29 +-
 tools/testing/selftests/net/config                 |  28 +
 tools/testing/selftests/net/rps_default_mask.sh    |   6 +-
 tools/testing/selftests/net/so_incoming_cpu.c      |  68 +-
 366 files changed, 5747 insertions(+), 2192 deletions(-)



