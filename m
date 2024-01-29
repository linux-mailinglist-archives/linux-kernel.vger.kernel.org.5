Return-Path: <linux-kernel+bounces-43188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E8F840DDE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A03283D79
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E4C15D5B7;
	Mon, 29 Jan 2024 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qhFgwuTC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5E0159570;
	Mon, 29 Jan 2024 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548179; cv=none; b=BE9h6nHy7jikQsdVyfKG++JEBLViS9+/+TFN75HavnzqvaLiLOJgig1g2YUFCiGEUdW5GvzY8AtgcoON5jao1BrnE//rJCYZoJHX/LvnyN59aOW/f1ApqwYkPhQtZPUkZwGvwWGdmANWz7pBrhYUAbBSbN3spzddLkew7IVk2+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548179; c=relaxed/simple;
	bh=tw+ek9TPEObrHvSzlofS+C62llYtJxtJ2ZaKgsa7O4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=es1cD03bAqmrFSkcRTZ58pZP4eOGlof6B5IVk34NJ3iOjykGR/IIfWFDDVCu85E1EaKige6T5fgclk3irMrTqqnm/vtxdTliY0OXq/1dAnulT7wq5Dmswt4m0eWPtLTnEA5akQuVikq7m0HI3s3TI2Ve/TCHE0dpVnHpw2O2pRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qhFgwuTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68299C433C7;
	Mon, 29 Jan 2024 17:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548179;
	bh=tw+ek9TPEObrHvSzlofS+C62llYtJxtJ2ZaKgsa7O4A=;
	h=From:To:Cc:Subject:Date:From;
	b=qhFgwuTCla3SfNEpQ6YLEYWLNwBR451lFt4u9v1DxOYKWOFuhdrNJx7TlKo8sQ5OG
	 JprX0QnVgjoV4CKGoK113zakulFPsQHQtrjYwIX6f6fQIxrTDZPLncPwBDNJNEllrt
	 LWnFg8XSaYJSivYskaZkNHoYFSWZ9b9APXhTUSP0=
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
Subject: [PATCH 6.1 000/185] 6.1.76-rc1 review
Date: Mon, 29 Jan 2024 09:03:20 -0800
Message-ID: <20240129165958.589924174@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.76-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.76-rc1
X-KernelTest-Deadline: 2024-01-31T17:00+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.1.76 release.
There are 185 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.76-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.1.76-rc1

Randy Dunlap <rdunlap@infradead.org>
    serial: core: fix kernel-doc for uart_port_unlock_irqrestore()

Richard Palethorpe <rpalethorpe@suse.com>
    x86/entry/ia32: Ensure s32 is sign extended to s64

Tim Chen <tim.c.chen@linux.intel.com>
    tick/sched: Preserve number of idle sleeps across CPU hotplug events

Xi Ruoyao <xry111@xry111.site>
    mips: Call lose_fpu(0) before initializing fcr31 in mips_set_personality_nan

Quanquan Cao <caoqq@fujitsu.com>
    cxl/region：Fix overflow issue in alloc_hpa()

Aleksander Jan Bajkowski <olek2@wp.pl>
    MIPS: lantiq: register smp_ops on non-smp platforms

David Lechner <dlechner@baylibre.com>
    spi: fix finalize message on error return

Kamal Dasu <kamal.dasu@broadcom.com>
    spi: bcm-qspi: fix SFDP BFPT read by usig mspi read

Hsin-Yi Wang <hsinyi@chromium.org>
    drm/bridge: anx7625: Ensure bridge is suspended in disable()

Li Lingfeng <lilingfeng3@huawei.com>
    block: Move checking GENHD_FL_NO_PART to bdev_add_partition()

Wenhua Lin <Wenhua.Lin@unisoc.com>
    gpio: eic-sprd: Clear interrupt after set the interrupt type

Fedor Pchelkin <pchelkin@ispras.ru>
    drm/exynos: gsc: minor fix for loop iteration in gsc_runtime_resume

Arnd Bergmann <arnd@arndb.de>
    drm/exynos: fix accidental on-stack copy of exynos_drm_plane

Douglas Anderson <dianders@chromium.org>
    drm/bridge: parade-ps8640: Make sure we drop the AUX mutex in the error case

Pin-yen Lin <treapking@chromium.org>
    drm/bridge: parade-ps8640: Ensure bridge is suspended in .post_disable()

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/bridge: sii902x: Fix audio codec unregistration

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/bridge: sii902x: Fix probing race issue

Matti Vaittinen <mazziesaccount@gmail.com>
    drm/bridge: sii902x: Use devm_regulator_bulk_get_enable()

Markus Niebel <Markus.Niebel@ew.tq-group.com>
    drm: panel-simple: add missing bus flags for Tianma tm070jvhg[30/33]

Douglas Anderson <dianders@chromium.org>
    drm/bridge: parade-ps8640: Wait for HPD when doing an AUX transfer

Sasha Levin <sashal@kernel.org>
    Revert "powerpc/64s: Increase default stack size to 32KB"

Hsin-Yi Wang <hsinyi@chromium.org>
    drm/panel-edp: drm/panel-edp: Fix AUO B116XAK01 name and timing

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

Jordan Rife <jrife@google.com>
    dlm: use kernel_connect() and kernel_bind()

Johan Hovold <johan+linaro@kernel.org>
    ARM: dts: qcom: sdx55: fix USB SS wakeup

Johan Hovold <johan+linaro@kernel.org>
    ARM: dts: qcom: sdx55: fix USB DP/DM HS PHY interrupts

Johan Hovold <johan+linaro@kernel.org>
    ARM: dts: qcom: sdx55: fix pdc '#interrupt-cells'

Paul Cercueil <paul@crapouillou.net>
    ARM: dts: samsung: exynos4210-i9100: Unconditionally enable LDO12

Johan Hovold <johan+linaro@kernel.org>
    ARM: dts: qcom: sdx55: fix USB wakeup interrupt types

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

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PM: sleep: Fix possible deadlocks in core system-wide PM code

Li zeming <zeming@nfschina.com>
    PM: core: Remove unnecessary (void *) conversions

Manivannan Sadhasivam <mani@kernel.org>
    bus: mhi: ep: Do not allocate event ring element on stack

Bingbu Cao <bingbu.cao@intel.com>
    media: ov13b10: Enable runtime PM before registering async sub-device

Arec Kao <arec.kao@intel.com>
    media: ov13b10: Support device probe in non-zero ACPI D state

Gao Xiang <xiang@kernel.org>
    erofs: fix lz4 inplace decompression

Gao Xiang <xiang@kernel.org>
    erofs: get rid of the remaining kmap_atomic()

Ma Jun <Jun.Ma2@amd.com>
    drm/amdgpu/pm: Fix the power source flag error

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Port DENTIST hang and TDR fixes to OTG disable W/A

Dan Carpenter <dan.carpenter@linaro.org>
    drm/bridge: nxp-ptn3460: simplify some error checking

Nathan Chancellor <nathan@kernel.org>
    platform/x86: intel-uncore-freq: Fix types in sysfs callbacks

Mario Limonciello <mario.limonciello@amd.com>
    drm/amd/display: Disable PSR-SU on Parade 0803 TCON again

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/tidss: Fix atomic_flush check

Dan Carpenter <dan.carpenter@linaro.org>
    drm/bridge: nxp-ptn3460: fix i2c_master_send() error checking

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm: Don't unref the same fb many times by mistake due to deadlock handling

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    cpufreq: intel_pstate: Refine computation of P-state for given frequency

Mario Limonciello <mario.limonciello@amd.com>
    gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-04

Dave Chinner <dchinner@redhat.com>
    xfs: read only mounts with fsopen mount API are busted

Cristian Marussi <cristian.marussi@arm.com>
    firmware: arm_scmi: Check mailbox/SMT channel for consistency

Lin Ma <linma@zju.edu.cn>
    ksmbd: fix global oob in ksmbd_nl_policy

Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
    platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: reject QUEUE/DROP verdict parameters

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_chain_filter: handle NETDEV_UNREGISTER for inet/ingress basechain

Michael Kelley <mhklinux@outlook.com>
    hv_netvsc: Calculate correct ring size when PAGE_SIZE is not 4 Kbytes

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

Eric Dumazet <edumazet@google.com>
    nbd: always initialize struct msghdr completely

Shenwei Wang <shenwei.wang@nxp.com>
    net: fec: fix the unhandled context fault from smmu

Zhipeng Lu <alexious@zju.edu.cn>
    fjes: fix memleaks in fjes_hw_setup

Jakub Kicinski <kuba@kernel.org>
    selftests: netdevsim: fix the udp_tunnel_nic test

Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
    net: mvpp2: clear BM pool before initialization

Bernd Edlinger <bernd.edlinger@hotmail.de>
    net: stmmac: Wait a bit for the reset to take effect

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: validate NFPROTO_* family

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: restrict anonymous set and map names to 16 bytes

Filipe Manana <fdmanana@suse.com>
    btrfs: fix race between reading a directory and adding entries to it

Filipe Manana <fdmanana@suse.com>
    btrfs: refresh dir last index during a rewinddir(3) call

Filipe Manana <fdmanana@suse.com>
    btrfs: set last dir index to the current last index when opening dir

Filipe Manana <fdmanana@suse.com>
    btrfs: fix infinite directory reads

Florian Westphal <fw@strlen.de>
    netfilter: nft_limit: reject configurations that cause integer overflow

Frederic Weisbecker <frederic@kernel.org>
    rcu: Defer RCU kthreads wakeup when CPU is dying

Dinghao Liu <dinghao.liu@zju.edu.cn>
    net/mlx5e: fix a potential double-free in fs_any_create_groups

Zhipeng Lu <alexious@zju.edu.cn>
    net/mlx5e: fix a double-free in arfs_create_groups

Leon Romanovsky <leon@kernel.org>
    net/mlx5e: Allow software parsing when IPsec crypto is enabled

Rahul Rameshbabu <rrameshbabu@nvidia.com>
    net/mlx5: Use mlx5 device constant for selecting CQ period mode for ASO

Yevgeny Kliteynik <kliteyn@nvidia.com>
    net/mlx5: DR, Can't go to uplink vport on RX rule

Yevgeny Kliteynik <kliteyn@nvidia.com>
    net/mlx5: DR, Use the right GVMI number for drop action

Zhengchao Shao <shaozhengchao@huawei.com>
    ipv6: init the accept_queue's spinlocks in inet6_create

Zhengchao Shao <shaozhengchao@huawei.com>
    netlink: fix potential sleeping issue in mqueue_flush_file

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
    bnxt_en: Wait for FLR to complete during probe

Zhengchao Shao <shaozhengchao@huawei.com>
    tcp: make sure init the accept_queue's spinlocks once

Wen Gu <guwen@linux.alibaba.com>
    net/smc: fix illegal rmb_desc access in SMC-D connection dump

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: fix potential sta-link leak

Wayne Lin <wayne.lin@amd.com>
    drm/amd/display: pbn_div need be updated for hotplug event

Jonathan Gray <jsg@jsg.id.au>
    Revert "drm/amd: Enable PCIe PME from D3"

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

Zhihao Cheng <chengzhihao1@huawei.com>
    ubifs: ubifs_symlink: Fix memleak of inode->i_link in error path

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

Rob Herring <robh@kernel.org>
    arm64: Rename ARM64_WORKAROUND_2966298

Zheng Wang <zyytlz.wz@163.com>
    media: mtk-jpeg: Fix use after free bug due to error path handling in mtk_jpeg_dec_device_run

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

Alfred Piccioni <alpic@google.com>
    lsm: new security_file_ioctl_compat() hook

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sm8150: fix USB DP/DM HS PHY interrupts

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sdm845: fix USB DP/DM HS PHY interrupts

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sc7280: fix usb_1 wakeup interrupt types

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sm8150: fix USB wakeup interrupt types

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sdm845: fix USB wakeup interrupt types

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sc7180: fix USB wakeup interrupt types

Bart Van Assche <bvanassche@acm.org>
    scsi: ufs: core: Remove the ufshcd_hba_exit() call from ufshcd_async_scan()

Amelie Delaunay <amelie.delaunay@foss.st.com>
    dmaengine: fix NULL pointer in channel unregistration function

Marcelo Schmitt <marcelo.schmitt@analog.com>
    iio: adc: ad7091r: Enable internal vref if external vref is not supplied

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    async: Introduce async_schedule_dev_nocall()

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    async: Split async_schedule_node_domain()

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

Tony Krowiak <akrowiak@linux.ibm.com>
    s390/vfio-ap: let on_scan_complete() callback filter matrix and update guest's APCB

Tony Krowiak <akrowiak@linux.ibm.com>
    s390/vfio-ap: loop over the shadow APCB when filtering guest's AP configuration

Tony Krowiak <akrowiak@linux.ibm.com>
    s390/vfio-ap: always filter entire AP matrix

Bingbu Cao <bingbu.cao@intel.com>
    media: ov9734: Enable runtime PM before registering async sub-device

Xiaolei Wang <xiaolei.wang@windriver.com>
    rpmsg: virtio: Free driver_override when rpmsg_remove()

Bingbu Cao <bingbu.cao@intel.com>
    media: imx355: Enable runtime PM before registering async sub-device

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

David Disseldorp <ddiss@suse.de>
    btrfs: sysfs: validate scrub_speed_max value

Viresh Kumar <viresh.kumar@linaro.org>
    OPP: Pass rounded rate to _set_opp()

Josef Bacik <josef@toxicpanda.com>
    arm64: properly install vmlinuz.efi

Suraj Jitindar Singh <surajjs@amazon.com>
    ext4: allow for the last group to be marked as trimmed

Marcelo Schmitt <marcelo.schmitt@analog.com>
    iio: adc: ad7091r: Allow users to configure device events

Marcelo Schmitt <marcelo.schmitt@analog.com>
    iio: adc: ad7091r: Set alert bit in config register

Sean Christopherson <seanjc@google.com>
    Revert "nSVM: Check for reserved encodings of TLB_CONTROL in nested VMCB"

Wesley Cheng <quic_wcheng@quicinc.com>
    usb: dwc3: gadget: Handle EP0 request dequeuing properly

Wesley Cheng <quic_wcheng@quicinc.com>
    usb: dwc3: gadget: Queue PM runtime idle on disconnect event

Wesley Cheng <quic_wcheng@quicinc.com>
    usb: dwc3: gadget: Refactor EP0 forced stall/restart into a separate API


-------------

Diffstat:

 Documentation/ABI/testing/sysfs-class-devfreq      |   3 +
 Documentation/admin-guide/abi-obsolete.rst         |   2 +-
 Documentation/admin-guide/abi-removed.rst          |   2 +-
 Documentation/admin-guide/abi-stable.rst           |   2 +-
 Documentation/admin-guide/abi-testing.rst          |   2 +-
 Documentation/filesystems/directory-locking.rst    |  29 +-
 Documentation/filesystems/locking.rst              |   5 +-
 Documentation/filesystems/porting.rst              |  18 +
 Documentation/sphinx/kernel_abi.py                 |  56 +--
 Makefile                                           |   4 +-
 arch/alpha/kernel/rtc.c                            |   2 +-
 arch/arm/boot/dts/exynos4210-i9100.dts             |   8 +
 arch/arm/boot/dts/qcom-sdx55.dtsi                  |  10 +-
 arch/arm64/Kconfig                                 |   4 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |   4 +-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   4 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |  16 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |  16 +-
 arch/arm64/boot/install.sh                         |   3 +-
 arch/arm64/kernel/cpu_errata.c                     |   4 +-
 arch/arm64/kernel/entry.S                          |   2 +-
 arch/arm64/tools/cpucaps                           |   2 +-
 arch/loongarch/kernel/smp.c                        |   3 +-
 arch/mips/kernel/elf.c                             |   6 +
 arch/mips/lantiq/prom.c                            |   7 +-
 arch/mips/mm/init.c                                |  12 +-
 arch/parisc/kernel/firmware.c                      |   4 +-
 arch/powerpc/Kconfig                               |   1 -
 arch/s390/crypto/aes_s390.c                        |   4 +-
 arch/s390/crypto/paes_s390.c                       |   4 +-
 arch/x86/include/asm/syscall_wrapper.h             |  25 +-
 arch/x86/kernel/hpet.c                             |   2 +-
 arch/x86/kernel/rtc.c                              |   2 +-
 arch/x86/kvm/svm/nested.c                          |  14 -
 block/ioctl.c                                      |   2 -
 block/partitions/core.c                            |   5 +
 crypto/algapi.c                                    |   1 +
 drivers/base/power/main.c                          | 160 ++++-----
 drivers/base/power/trace.c                         |   2 +-
 drivers/block/nbd.c                                |   6 +-
 drivers/block/rbd.c                                |  22 +-
 drivers/bus/mhi/ep/main.c                          |  68 +++-
 drivers/bus/mhi/host/main.c                        |  29 +-
 drivers/char/hw_random/core.c                      |  34 +-
 drivers/cpufreq/intel_pstate.c                     |  55 +--
 drivers/cxl/core/region.c                          |   4 +-
 drivers/devfreq/devfreq.c                          |  57 ++-
 drivers/dma/dmaengine.c                            |   3 +
 drivers/firmware/arm_scmi/common.h                 |   1 +
 drivers/firmware/arm_scmi/mailbox.c                |  14 +
 drivers/firmware/arm_scmi/shmem.c                  |   6 +
 drivers/gpio/gpio-eic-sprd.c                       |  32 +-
 drivers/gpio/gpiolib-acpi.c                        |  14 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   2 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   3 +-
 .../amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c |  21 +-
 .../drm/amd/display/modules/power/power_helpers.c  |   2 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  13 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |   2 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |   2 +
 drivers/gpu/drm/bridge/analogix/anx7625.c          |   7 +-
 drivers/gpu/drm/bridge/analogix/anx7625.h          |   2 +
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |   6 +-
 drivers/gpu/drm/bridge/parade-ps8640.c             |  23 ++
 drivers/gpu/drm/bridge/sii902x.c                   |  68 ++--
 drivers/gpu/drm/drm_plane.c                        |   1 +
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_fimd.c           |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_gsc.c            |   2 +-
 drivers/gpu/drm/nouveau/nouveau_vmm.c              |   3 +
 drivers/gpu/drm/panel/panel-edp.c                  |   4 +-
 drivers/gpu/drm/panel/panel-simple.c               |   2 +
 drivers/gpu/drm/tidss/tidss_crtc.c                 |  10 +-
 drivers/iio/adc/ad7091r-base.c                     | 169 +++++++++
 drivers/iio/adc/ad7091r-base.h                     |   8 +
 drivers/iio/adc/ad7091r5.c                         |  28 +-
 drivers/media/common/videobuf2/videobuf2-dma-sg.c  |  10 +-
 drivers/media/i2c/imx355.c                         |  12 +-
 drivers/media/i2c/ov13b10.c                        |  86 +++--
 drivers/media/i2c/ov9734.c                         |  19 +-
 .../media/platform/mediatek/jpeg/mtk_jpeg_core.c   |   6 +-
 drivers/mmc/core/block.c                           |  46 ++-
 drivers/mmc/host/mmc_spi.c                         | 186 +---------
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   5 +
 drivers/net/ethernet/freescale/fec_main.c          |   2 +
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |  27 +-
 .../mellanox/mlx5/core/en/fs_tt_redirect.c         |   1 +
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c  |  26 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c  |   2 +-
 .../mellanox/mlx5/core/steering/dr_action.c        |  17 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   3 +
 drivers/net/fjes/fjes_hw.c                         |  37 +-
 drivers/net/hyperv/netvsc_drv.c                    |   4 +-
 drivers/net/phy/micrel.c                           |  11 +
 drivers/net/tun.c                                  |  10 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |   2 +-
 drivers/opp/core.c                                 |   6 +-
 drivers/parisc/power.c                             |   2 +-
 .../uncore-frequency/uncore-frequency-common.c     |  64 ++--
 .../uncore-frequency/uncore-frequency-common.h     |  20 +-
 drivers/platform/x86/p2sb.c                        | 180 +++++++---
 drivers/rpmsg/virtio_rpmsg_bus.c                   |   1 +
 drivers/rtc/rtc-cmos.c                             |  28 +-
 drivers/rtc/rtc-mc146818-lib.c                     |  39 ++-
 drivers/s390/crypto/vfio_ap_ops.c                  |  72 ++--
 drivers/spi/spi-bcm-qspi.c                         |   4 +-
 drivers/spi/spi.c                                  |   4 +
 drivers/thermal/intel/intel_hfi.c                  | 106 ++++--
 drivers/tty/serial/sc16is7xx.c                     | 389 +++++++++++----------
 drivers/ufs/core/ufshcd.c                          |   7 +-
 drivers/usb/dwc3/gadget.c                          |  70 ++--
 fs/afs/dir.c                                       |   8 +
 fs/btrfs/ctree.h                                   |   1 +
 fs/btrfs/delayed-inode.c                           |   5 +-
 fs/btrfs/delayed-inode.h                           |   1 +
 fs/btrfs/extent-tree.c                             |  53 ++-
 fs/btrfs/inode.c                                   | 172 +++++----
 fs/btrfs/ioctl.c                                   |   7 +
 fs/btrfs/ref-verify.c                              |   6 +-
 fs/btrfs/sysfs.c                                   |   4 +
 fs/btrfs/tree-checker.c                            |   2 +-
 fs/dlm/lowcomms.c                                  |  14 +-
 fs/erofs/decompressor.c                            |  49 +--
 fs/exec.c                                          |   3 +
 fs/ext4/mballoc.c                                  |  15 +-
 fs/fscache/cache.c                                 |   3 +-
 fs/ioctl.c                                         |   3 +-
 fs/namei.c                                         |  60 ++--
 fs/pipe.c                                          |  19 +-
 fs/smb/server/connection.c                         |   1 +
 fs/smb/server/ksmbd_netlink.h                      |   3 +-
 fs/smb/server/oplock.c                             |  16 +-
 fs/smb/server/smb2pdu.c                            |   8 +-
 fs/smb/server/transport_ipc.c                      |   4 +-
 fs/ubifs/dir.c                                     |   2 +
 fs/xfs/xfs_super.c                                 |  27 +-
 include/linux/async.h                              |   2 +
 include/linux/lsm_hook_defs.h                      |   2 +
 include/linux/mc146818rtc.h                        |   3 +-
 include/linux/mmzone.h                             |  14 +-
 include/linux/pipe_fs_i.h                          |  16 +
 include/linux/rmap.h                               |   4 +-
 include/linux/security.h                           |   9 +
 include/linux/serial_core.h                        |  79 +++++
 include/linux/skmsg.h                              |   6 -
 include/linux/syscalls.h                           |   1 +
 include/net/inet_connection_sock.h                 |   8 +
 include/net/inet_sock.h                            |   5 -
 include/net/llc_pdu.h                              |   6 +-
 include/net/sock.h                                 |  18 +-
 include/uapi/linux/btrfs.h                         |   3 +
 kernel/async.c                                     |  85 +++--
 kernel/power/swap.c                                |  38 +-
 kernel/rcu/tree.c                                  |  34 +-
 kernel/rcu/tree_exp.h                              |   3 +-
 kernel/time/tick-sched.c                           |   5 +
 kernel/trace/tracing_map.c                         |   7 +-
 mm/page_alloc.c                                    |  16 +-
 mm/sparse.c                                        |  17 +-
 net/8021q/vlan_netlink.c                           |   4 +
 net/core/dev.c                                     |   9 +
 net/core/dev.h                                     |   3 +
 net/core/request_sock.c                            |   3 -
 net/core/sock.c                                    |  11 +-
 net/ipv4/af_inet.c                                 |   3 +
 net/ipv4/inet_connection_sock.c                    |   4 +
 net/ipv4/tcp.c                                     |   1 +
 net/ipv6/af_inet6.c                                |   3 +
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
 net/smc/smc_diag.c                                 |   2 +-
 scripts/get_abi.pl                                 |   2 +-
 security/security.c                                |  18 +
 security/selinux/hooks.c                           |  28 ++
 security/smack/smack_lsm.c                         |   1 +
 security/tomoyo/tomoyo.c                           |   1 +
 .../drivers/net/netdevsim/udp_tunnel_nic.sh        |   9 +
 192 files changed, 2418 insertions(+), 1385 deletions(-)



