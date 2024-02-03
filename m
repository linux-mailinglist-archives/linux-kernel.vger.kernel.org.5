Return-Path: <linux-kernel+bounces-51222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D66F848805
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4710C1C215A5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D2A5FDAC;
	Sat,  3 Feb 2024 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZTLEYS7u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F695FB8E;
	Sat,  3 Feb 2024 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706982786; cv=none; b=Rt1c61Jr6bfynAu+Uf2jAyIHlZkOB3XPvsQc4n907cU9ZKGgPhvzsh9PlaRcTa7y1rNrF6Tvd1eMDvAtOtlO8MQbb1hR5IzkI25kxzxehezoPhGYe/muFRb3YF9Byk3jyETwaCjUrNyTbEnLrf5Bvw189o6vLa//0DVHtmq4EFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706982786; c=relaxed/simple;
	bh=aDAh23vYEWf22u5ytc6QwQYSxHhssjuwI4A6ZY0lPVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RlcCWUhWndxyW/9HTGltRo9HTUhoQL1tdbwgFOQRKuUz0C09T4ruehFj2+xZOdIiCq2s/WixATzNLgyNvUqwfWDnJCXaAPsX1PXmHxVpuWpH7iwbKopIXmi7XQ3sjdSMWEqelhjeZibU1AsBMrYyZ4/ZBQF8Mc0JM5P8sXJ8bis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZTLEYS7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127D5C433C7;
	Sat,  3 Feb 2024 17:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706982786;
	bh=aDAh23vYEWf22u5ytc6QwQYSxHhssjuwI4A6ZY0lPVY=;
	h=From:To:Cc:Subject:Date:From;
	b=ZTLEYS7uPccMwyxT1uyzq6CezmQXXZPKpL00mXXbRpNjVNj38NFsTx5OP08SQtgBU
	 BA+Maz1b3Hy2+SCDJCSmGoBytivt+qHclVMzGiiu1FNll4l5p7GeWOJeYZqAIxHodr
	 dUun/5uzBVG2dFgDV01Btm2AI2dy6nBHKPuUo0GQ=
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
Subject: [PATCH 6.6 000/326] 6.6.16-rc2 review
Date: Sat,  3 Feb 2024 09:52:59 -0800
Message-ID: <20240203174810.768708706@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.16-rc2.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.16-rc2
X-KernelTest-Deadline: 2024-02-05T17:48+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.6.16 release.
There are 326 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon, 05 Feb 2024 17:47:20 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.16-rc2.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.6.16-rc2

Brett Creeley <brett.creeley@amd.com>
    pds_core: Prevent health thread from running during reset/remove

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amdgpu: Fix missing error code in 'gmc_v6/7/8/9_0_hw_init()'

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wsa883x: fix PA volume control

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: lpass-wsa-macro: fix compander volume hack

Johan Hovold <johan+linaro@kernel.org>
    ASoC: codecs: wcd938x: fix headphones volume controls

Johan Hovold <johan+linaro@kernel.org>
    ASoC: qcom: sc8280xp: limit speaker volumes

Zhengchao Shao <shaozhengchao@huawei.com>
    bonding: remove print in bond_verify_device_path

Yonghong Song <yonghong.song@linux.dev>
    selftests/bpf: Remove flaky test_btf_id test

Huacai Chen <chenhuacai@kernel.org>
    LoongArch/smp: Call rcutree_report_cpu_starting() at tlb_init()

Konrad Dybcio <konrad.dybcio@linaro.org>
    drm/msm/dsi: Enable runtime PM

Jonathan Gray <jsg@jsg.id.au>
    Revert "drm/amd/display: Disable PSR-SU on Parade 0803 TCON again"

Marco Elver <elver@google.com>
    mm, kmsan: fix infinite recursion due to RCU critical section

Huang Shijie <shijie@os.amperecomputing.com>
    arm64: irq: set the correct node for shadow call stack

Paolo Abeni <pabeni@redhat.com>
    selftests: net: enable some more knobs

Jakub Kicinski <kuba@kernel.org>
    selftests: net: add missing config for NF_TARGET_TTL

Benjamin Poirier <bpoirier@nvidia.com>
    selftests: bonding: Check initial state

Benjamin Poirier <bpoirier@nvidia.com>
    selftests: team: Add missing config options

Breno Leitao <leitao@debian.org>
    net: sysfs: Fix /sys/class/net/<iface> path

Geetha sowjanya <gakula@marvell.com>
    octeontx2-pf: Remove xdp queues on program detach

Paolo Abeni <pabeni@redhat.com>
    selftests: net: don't access /dev/stdout in pmtu.sh

Paolo Abeni <pabeni@redhat.com>
    selftests: net: fix available tunnels detection

Paolo Abeni <pabeni@redhat.com>
    selftests: net: add missing config for pmtu.sh tests

Jakub Kicinski <kuba@kernel.org>
    selftests: net: add missing config for nftables-backed iptables

Brett Creeley <brett.creeley@amd.com>
    pds_core: Rework teardown/setup flow to be more common

Brett Creeley <brett.creeley@amd.com>
    pds_core: Clear BARs on reset

Brett Creeley <brett.creeley@amd.com>
    pds_core: Prevent race issues involving the adminq

Shannon Nelson <shannon.nelson@amd.com>
    pds_core: implement pci reset handlers

Brett Creeley <brett.creeley@amd.com>
    pds_core: Use struct pdsc for the pdsc_adminq_isr private data

Brett Creeley <brett.creeley@amd.com>
    pds_core: Cancel AQ work on teardown

Eric Dumazet <edumazet@google.com>
    af_unix: fix lockdep positive in sk_diag_dump_icons()

Zhipeng Lu <alexious@zju.edu.cn>
    net: ipv4: fix a memleak in ip_setup_cork

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_ct: sanitize layer 3 and 4 protocol number in custom expectations

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_log: replace BUG_ON by WARN_ON_ONCE when putting logger

Jozsef Kadlecsik <kadlec@netfilter.org>
    netfilter: ipset: fix performance regression in swap operation

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: restrict tunnel object to NFPROTO_NETDEV

Ryan Schaefer <ryanschf@amazon.com>
    netfilter: conntrack: correct window scaling with retransmitted SYN

Matthias May <Matthias.May@westermo.com>
    selftests: net: add missing config for GENEVE

Parav Pandit <parav@nvidia.com>
    devlink: Fix referring to hw_addr attribute during state validation

Linus Lüssing <linus.luessing@c0d3.blue>
    bridge: mcast: fix disabled snooping after long uptime

Ido Schimmel <idosch@nvidia.com>
    selftests: net: Add missing matchall classifier

Eric Dumazet <edumazet@google.com>
    llc: call sock_orphan() at release time

Helge Deller <deller@kernel.org>
    ipv6: Ensure natural alignment of const ipv6 loopback and router addresses

Michal Vokáč <michal.vokac@ysoft.com>
    net: dsa: qca8k: fix illegal usage of GPIO

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    ixgbe: Fix an error handling path in ixgbe_read_iosf_sb_reg_x550()

Jedrzej Jagielski <jedrzej.jagielski@intel.com>
    ixgbe: Refactor overtemp event handling

Jedrzej Jagielski <jedrzej.jagielski@intel.com>
    ixgbe: Refactor returning internal error codes

Jacob Keller <jacob.e.keller@intel.com>
    e1000e: correct maximum frequency adjustment values

Eric Dumazet <edumazet@google.com>
    tcp: add sanity checks to rx zerocopy

Horatiu Vultur <horatiu.vultur@microchip.com>
    net: lan966x: Fix port configuration when using SGMII interface

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    ipmr: fix kernel panic when forwarding mcast packets

Daniel Golle <daniel@makrotopia.org>
    net: dsa: mt7530: fix 10M/100M speed on MT7988 switch

Eric Dumazet <edumazet@google.com>
    ip6_tunnel: make sure to pull inner header in __ip6_tnl_rcv()

Paolo Abeni <pabeni@redhat.com>
    selftests: net: give more time for GRO aggregation

Paolo Abeni <pabeni@redhat.com>
    selftests: net: add missing required classifier

Paolo Abeni <pabeni@redhat.com>
    selftests: net: add missing config for big tcp tests

Daniel Golle <daniel@makrotopia.org>
    net: phy: mediatek-ge-soc: sync driver with MediaTek SDK

Daniel Golle <daniel@makrotopia.org>
    net: ethernet: mtk_eth_soc: set DMA coherent mask to get PPE working

Praveen Kaligineedi <pkaligineedi@google.com>
    gve: Fix skb truesize underestimation

Paolo Abeni <pabeni@redhat.com>
    selftests: net: explicitly wait for listener ready

Paolo Abeni <pabeni@redhat.com>
    selftests: net: remove dependency on ebpf tests

Su Hui <suhui@nfschina.com>
    HID: hidraw: fix a problem of memory leak in hidraw_release()

Ming Lei <ming.lei@redhat.com>
    scsi: core: Move scsi_host_busy() out of host lock for waking up EH handler

Romain Naour <romain.naour@skf.com>
    regulator: ti-abb: don't use devm_platform_ioremap_resource_byname for shared interrupt register

Marco Pagani <marpagan@redhat.com>
    kunit: run test suites only after module initialization completes

Su Hui <suhui@nfschina.com>
    scsi: isci: Fix an error code problem in isci_io_request_build()

Alexandre Ghiti <alexghiti@rivosinc.com>
    riscv: Fix build error on rv32 + XIP

Jonathan Kim <jonathan.kim@amd.com>
    drm/amdkfd: only flush mes process context if mes support is there

Stephen Rothwell <sfr@canb.auug.org.au>
    drm: using mul_u32_u32() requires linux/math64.h

Edward Adam Davis <eadavis@qq.com>
    wifi: cfg80211: fix RCU dereference in __cfg80211_bss_update

Peter Zijlstra <peterz@infradead.org>
    perf: Fix the nr_addr_filters fix

Tim Lunn <tim@feathertop.org>
    i2c: rk3x: Adjust mask/value offset for i2c2 on rv1126

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amdkfd: Fix 'node' NULL check in 'svm_range_get_range_boundaries()'

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amdgpu: Release 'adev->pm.fw' before return in 'amdgpu_device_need_post()'

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amdgpu: Fix with right return code '-EIO' in 'amdgpu_gmc_vram_checking()'

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amd/powerplay: Fix kzalloc parameter 'ATOM_Tonga_PPM_Table' in 'get_platform_power_management_table()'

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: fix avg vs input power reporting on smu7

Wenchao Hao <haowenchao2@huawei.com>
    ceph: fix invalid pointer access if get_quota_realm return ERR_PTR

Xiubo Li <xiubli@redhat.com>
    ceph: fix deadlock or deadcode of misusing dget()

Venky Shankar <vshankar@redhat.com>
    ceph: reinitialize mds feature bit even when session in open

Ming Lei <ming.lei@redhat.com>
    blk-mq: fix IO hang from sbitmap wakeup race

Zhu Yanjun <yanjun.zhu@linux.dev>
    virtio_net: Fix "‘%d’ directive writing between 1 and 11 bytes into a region of size 10" warnings

Philip Yang <Philip.Yang@amd.com>
    drm/amdkfd: Fix lock dependency warning with srcu

Felix Kuehling <felix.kuehling@amd.com>
    drm/amdkfd: Fix lock dependency warning

Ian Rogers <irogers@google.com>
    libsubcmd: Fix memory leak in uniq()

Hans de Goede <hdegoede@redhat.com>
    misc: lis3lv02d_i2c: Add missing setting of the reg_ctrl callback

Yinbo Zhu <zhuyinbo@loongson.cn>
    usb: xhci-plat: fix usb disconnect issue after s4

David Howells <dhowells@redhat.com>
    9p: Fix initialisation of netfs_inode for 9p

Bjorn Helgaas <bhelgaas@google.com>
    PCI/AER: Decode Requester ID when no error info found

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    PCI: Fix 64GT/s effective data rate calculation

Yu-Che Cheng <giver@chromium.org>
    spmi: mediatek: Fix UAF on device remove

Max Kellermann <max.kellermann@ionos.com>
    fs/kernfs/dir: obey S_ISGID

Adrian Reber <areber@redhat.com>
    tty: allow TIOCSLCKTRMIOS with CAP_CHECKPOINT_RESTORE

Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
    selftests/sgx: Fix linker script asserts

Hardik Gajjar <hgajjar@de.adit-jv.com>
    usb: hub: Add quirk to decrease IN-ep poll interval for Microchip USB491x hub

Hardik Gajjar <hgajjar@de.adit-jv.com>
    usb: hub: Replace hardcoded quirk value with BIT() macro

Yaxiong Tian <tianyaxiong@kylinos.cn>
    extcon: fix possible name leak in extcon_dev_register()

James Clark <james.clark@arm.com>
    perf cs-etm: Bump minimum OpenCSD version to ensure a bugfix is present

Daniel Stodden <dns@arista.com>
    PCI: switchtec: Fix stdev_release() crash after surprise hot remove

Guilherme G. Piccoli <gpiccoli@igalia.com>
    PCI: Only override AMD USB controller if required

Xiaowu.ding <xiaowu.ding@jaguarmicro.com>
    mailbox: arm_mhuv2: Fix a bug for mhuv2_sender_interrupt

Peter Robinson <pbrobinson@gmail.com>
    mfd: ti_am335x_tscadc: Fix TI SoC dependencies

Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
    xen/gntdev: Fix the abuse of underlying struct page in DMA-buf import

Frederik Haxel <haxel@fzi.de>
    riscv: Make XIP bootable again

Harshit Shah <harshitshah.opendev@gmail.com>
    i3c: master: cdns: Update maximum prescaler value for i2c clock

Johannes Berg <johannes.berg@intel.com>
    um: time-travel: fix time corruption

Nathan Chancellor <nathan@kernel.org>
    um: net: Fix return type of uml_net_start_xmit()

Benjamin Berg <benjamin@sipsolutions.net>
    um: Don't use vfprintf() for os_info()

Anton Ivanov <anton.ivanov@cambridgegreys.com>
    um: Fix naming clash between UML and scheduler

Heiner Kallweit <hkallweit1@gmail.com>
    leds: trigger: panic: Don't register panic notifier if creating the trigger failed

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    pinctrl: baytrail: Fix types of config value in byt_pin_config_set()

bo liu <bo.liu@senarytech.com>
    ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: apply the RV2 system aperture fix to RN/CZN as well

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amdkfd: Fix iterator used outside loop in 'kfd_add_peer_prop()'

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amdgpu: Drop 'fence' check in 'to_amdgpu_amdkfd_fence()'

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amdgpu: Fix '*fw' from request_firmware() not released in 'amdgpu_ucode_request()'

Ivan Lipski <ivlipski@amd.com>
    Re-revert "drm/amd/display: Enable Replay for static screen use cases"

Felix Kuehling <Felix.Kuehling@amd.com>
    drm/amdgpu: Let KFD sync with VM fences

Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
    drm/amd/display: Fix minor issues in BW Allocation Phase2

Stanley.Yang <Stanley.Yang@amd.com>
    drm/amdgpu: Fix ecc irq enable/disable unpaired

Alexander Stein <alexander.stein@ew.tq-group.com>
    clk: imx: clk-imx8qxp: fix LVDS bypass, pixel and phy clocks

Alvin Lee <alvin.lee2@amd.com>
    drm/amd/display: Only clear symclk otg flag for HDMI

Josip Pavic <josip.pavic@amd.com>
    drm/amd/display: make flip_timestamp_in_us a 64-bit variable

Oded Gabbay <ogabbay@kernel.org>
    accel/habanalabs: add support for Gaudi2C device

Werner Fischer <devlists@wefi.net>
    watchdog: it87_wdt: Keep WDTCTRL bit 3 unmodified for IT8784/IT8786

Ben Dooks <ben.dooks@codethink.co.uk>
    watchdog: starfive: add lock annotations to fix context imbalances

Kuan-Wei Chiu <visitorckw@gmail.com>
    clk: mmp: pxa168: Fix memory leak in pxa168_clk_init()

Kuan-Wei Chiu <visitorckw@gmail.com>
    clk: hi3620: Fix memory leak in hi3620_mmc_clk_init()

Wang, Beyond <Wang.Beyond@amd.com>
    drm/amdgpu: fix ftrace event amdgpu_bo_move always move on same heap

Abhinav Kumar <quic_abhinavk@quicinc.com>
    drm/msm/dpu: fix writeback programming for YUV cases

Rob Clark <robdclark@chromium.org>
    drm/msm/dpu: Ratelimit framedone timeout msgs

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dpu: enable writeback on SM8450

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    drm/msm/dpu: enable writeback on SM8350

Jonathan Kim <jonathan.kim@amd.com>
    drm/amdkfd: fix mes set shader debugger process management

Alvin Lee <alvin.lee2@amd.com>
    drm/amd/display: Force p-state disallow if leaving no plane config

Alvin Lee <alvin.lee2@amd.com>
    drm/amd/display: For prefetch mode > 0, extend prefetch if possible

Kieran Bingham <kieran.bingham@ideasonboard.com>
    media: i2c: imx335: Fix hblank min/max values

Su Hui <suhui@nfschina.com>
    media: ddbridge: fix an error code problem in ddb_probe

Ming Qian <ming.qian@nxp.com>
    media: amphion: remove mutext lock in condition of wait_event

Daniel Vacek <neelx@redhat.com>
    IB/ipoib: Fix mcast list locking

Douglas Anderson <dianders@chromium.org>
    drm/exynos: Call drm_atomic_helper_shutdown() at shutdown/unbind time

Chao Yu <chao@kernel.org>
    f2fs: fix to tag gcing flag on page during block migration

James Seo <james@equiv.tech>
    hwmon: (hp-wmi-sensors) Fix failure to load on EliteDesk 800 G6

Xing Tong Wu <xingtong.wu@siemens.com>
    hwmon: (nct6775) Fix fan speed set failure in automatic mode

Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    media: rkisp1: resizer: Stop manual allocation of v4l2_subdev_state

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    media: rkisp1: Fix IRQ disable race issue

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    media: rkisp1: Store IRQ lines

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    media: rkisp1: Fix IRQ handler return values

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    media: rkisp1: Drop IRQF_SHARED

Ricardo Ribalda <ribalda@chromium.org>
    media: uvcvideo: Fix power line control for SunplusIT camera

Ricardo Ribalda <ribalda@chromium.org>
    media: uvcvideo: Fix power line control for a Chicony camera

Neil Armstrong <neil.armstrong@linaro.org>
    drm/msm/dp: Add DisplayPort controller for SM8650

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ALSA: hda: intel-dspcfg: add filters for ARL-S and ARL

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ALSA: hda: Intel: add HDA_ARL PCI ID support

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    PCI: add INTEL_HDA_ARL to pci_ids.h

Michael Tretter <m.tretter@pengutronix.de>
    media: rockchip: rga: fix swizzling for RGB formats

Ghanshyam Agrawal <ghanshyam1898@gmail.com>
    media: stk1160: Fixed high volume of stk1160_dbg messages

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/mipi-dsi: Fix detach call without attach

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/framebuffer: Fix use of uninitialized variable

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/drm_file: fix use of uninitialized variable

Ilya Bakoulin <ilya.bakoulin@amd.com>
    drm/amd/display: Fix MST PBN/X.Y value calculations

Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
    ASoC: amd: Add new dmi entries for acp5x platform

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: fix write pointers on zoned device after roll forward

Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
    drm/amd/display: Fix tiled display misalignment

Xin Ji <xji@analogixsemi.com>
    drm/bridge: anx7625: Fix Set HPD irq detect window to 2ms

Hsin-Yi Wang <hsinyi@chromium.org>
    drm/panel-edp: Add override_edid_mode quirk for generic edp

Jack Wang <jinpu.wang@ionos.com>
    RDMA/IPoIB: Fix error code return in ipoib_mcast_join

Jan Kara <jack@suse.cz>
    reiserfs: Avoid touching renamed directory if parent does not change

Al Viro <viro@zeniv.linux.org.uk>
    fast_dput(): handle underflows gracefully

Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
    ASoC: doc: Fix undefined SND_SOC_DAPM_NOPM argument

Takashi Iwai <tiwai@suse.de>
    ALSA: hda: Refer to correct stream index at loops

Chao Yu <chao@kernel.org>
    f2fs: fix to check return value of f2fs_reserve_new_block()

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: qca8k: put MDIO bus OF node on qca8k_mdio_register() failure

Mina Almasry <almasrymina@google.com>
    net: kcm: fix direct access to bv_len

Suman Ghosh <sumang@marvell.com>
    octeontx2-af: Fix max NPC MCAM entry check while validating ref_entry

Andrii Staikov <andrii.staikov@intel.com>
    i40e: Fix VF disable behavior to block all traffic

Chunyan Zhang <chunyan.zhang@unisoc.com>
    arm64: dts: sprd: Change UMS512 idle-state nodename to match bindings

Chunyan Zhang <chunyan.zhang@unisoc.com>
    arm64: dts: sprd: Add clock reference for pll2 on UMS512

Lin Ma <linma@zju.edu.cn>
    bridge: cfm: fix enum typo in br_cc_ccm_tx_parse

Wen Gu <guwen@linux.alibaba.com>
    net/smc: disable SEID on non-s390 archs where virtual ISM may be used

Frédéric Danis <frederic.danis@collabora.com>
    Bluetooth: L2CAP: Fix possible multiple reject send

clancy shang <clancy.shang@quectel.com>
    Bluetooth: hci_sync: fix BR/EDR wakeup bug

Iulia Tanasescu <iulia.tanasescu@nxp.com>
    Bluetooth: ISO: Avoid creating child socket if PA sync is terminating

Zijun Hu <quic_zijuhu@quicinc.com>
    Bluetooth: qca: Set both WIDEBAND_SPEECH and LE_STATES quirks for QCA2066

Benjamin Berg <benjamin.berg@intel.com>
    wifi: cfg80211: free beacon_ies when overridden from hidden BSS

Su Hui <suhui@nfschina.com>
    wifi: rtlwifi: rtl8723{be,ae}: using calculate_bit_shift()

Mingyi Zhang <zhangmingyi5@huawei.com>
    libbpf: Fix NULL pointer dereference in bpf_object__collect_prog_relos

Ching-Te Ku <ku920601@realtek.com>
    wifi: rtw89: coex: Fix wrong Wi-Fi role info and FDDT parameter members

Zenm Chen <zenmchen@gmail.com>
    wifi: rtl8xxxu: Add additional USB IDs for RTL8192EU devices

Xianwei Zhao <xianwei.zhao@amlogic.com>
    arm64: dts: amlogic: fix format for s4 uart node

Jesse Brandeburg <jesse.brandeburg@intel.com>
    ice: fix pre-shifted bit usage

Mao Jinlong <quic_jinlmao@quicinc.com>
    arm64: dts: qcom: Fix coresight warnings in in-ports and out-ports

Mao Jinlong <quic_jinlmao@quicinc.com>
    arm64: dts: qcom: msm8998: Fix 'out-ports' is a required property

Mao Jinlong <quic_jinlmao@quicinc.com>
    arm64: dts: qcom: msm8996: Fix 'in-ports' is a required property

Alex Lyakas <alex.lyakas@zadara.com>
    md: Whenassemble the array, consult the superblock of the freshest device

Christoph Hellwig <hch@lst.de>
    block: prevent an integer overflow in bvec_try_merge_hw_page

Tobias Waldekranz <tobias@waldekranz.com>
    net: dsa: mv88e6xxx: Fix mv88e6352_serdes_get_stats error path

Igor Russkikh <irusskikh@marvell.com>
    net: atlantic: eliminate double free in error handling logic

Ahmed Zaki <ahmed.zaki@intel.com>
    ice: fix ICE_AQ_VSI_Q_OPT_RSS_* register values

Yihang Li <liyihang9@huawei.com>
    scsi: hisi_sas: Set .phy_attached before notifing phyup event HISI_PHYE_PHY_UP_PM

Justin Tee <justin.tee@broadcom.com>
    scsi: lpfc: Move determination of vmid_flag after VMID reinitialization completes

Justin Tee <justin.tee@broadcom.com>
    scsi: lpfc: Reinitialize an NPIV's VMID data structures after FDISC

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx23/28: Fix the DMA controller node name

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx23-sansa: Use preferred i2c-gpios properties

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx27-apf27dev: Fix LED name

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx25/27: Pass timing0

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx25: Fix the iim compatible string

Andrii Nakryiko <andrii@kernel.org>
    selftests/bpf: fix compiler warnings in RELEASE=1 mode

Michal Simek <michal.simek@amd.com>
    arm64: zynqmp: Fix clock node name in kv260 cards

Michal Simek <michal.simek@amd.com>
    arm64: zynqmp: Move fixed clock to / for kv260

Kees Cook <keescook@chromium.org>
    block/rnbd-srv: Check for unlikely string overflow

Shannon Nelson <shannon.nelson@amd.com>
    ionic: bypass firmware cmds when stuck in reset

Shannon Nelson <shannon.nelson@amd.com>
    ionic: pass opcode to devcmd_wait

Christian Marangi <ansuelsmth@gmail.com>
    net: phy: at803x: fix passing the wrong reference for config_intr

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx1: Fix sram node

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx27: Fix sram node

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx: Use flash@0,0 pattern

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx25/27-eukrea: Fix RTC node name

Johan Jonker <jbx6244@gmail.com>
    ARM: dts: rockchip: fix rk3036 hdmi ports node

Lingbo Kong <quic_lingbok@quicinc.com>
    wifi: ath12k: fix the issue that the multicast/broadcast indicator is not read correctly for WCN7850

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: wfx: fix possible NULL pointer dereference in wfx_set_mfp_ap()

Hou Tao <houtao1@huawei.com>
    bpf: Set uattr->batch.count as zero before batched update or deletion

StanleyYP Wang <StanleyYP.Wang@mediatek.com>
    wifi: mt76: mt7996: add PCI IDs for mt7992

MeiChia Chiu <meichia.chiu@mediatek.com>
    wifi: mt76: connac: fix EHT phy mode check

Nia Espera <nespera@igalia.com>
    arm64: dts: qcom: sm8350: Fix remoteproc interrupt type

Neil Armstrong <neil.armstrong@linaro.org>
    arm64: dts: qcom: sm8450: fix soundwire controllers node name

Neil Armstrong <neil.armstrong@linaro.org>
    arm64: dts: qcom: sm8550: fix soundwire controllers node name

Tobias Waldekranz <tobias@waldekranz.com>
    net: mvmdio: Avoid excessive sleeps in polled mode

David Laight <David.Laight@ACULAB.COM>
    minmax: relax check to allow comparison between unsigned arguments and signed constants

David Laight <David.Laight@ACULAB.COM>
    minmax: allow comparisons of 'int' against 'unsigned char/short'

David Laight <David.Laight@ACULAB.COM>
    minmax: fix indentation of __cmp_once() and __clamp_once()

David Laight <David.Laight@ACULAB.COM>
    minmax: allow min()/max()/clamp() if the arguments have the same signedness.

David Laight <David.Laight@ACULAB.COM>
    minmax: add umin(a, b) and umax(a, b)

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    minmax: fix header inclusions

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    minmax: deduplicate __unconst_integer_typeof()

Hannes Reinecke <hare@suse.de>
    scsi: libfc: Fix up timeout error in fc_fcp_rec_error()

Hannes Reinecke <hare@suse.de>
    scsi: libfc: Don't schedule abort twice

Kang Yang <quic_kangyang@quicinc.com>
    wifi: ath12k: fix and enable AP mode for WCN7850

Hou Tao <houtao1@huawei.com>
    bpf: Set need_defer as false when clearing fd array during map free

Hou Tao <houtao1@huawei.com>
    bpf: Check rcu_read_lock_trace_held() before calling bpf map helpers

Chih-Kang Chang <gary.chang@realtek.com>
    wifi: rtw89: fix misbehavior of TX beacon in concurrent mode

Baochen Qiang <quic_bqiang@quicinc.com>
    wifi: ath11k: fix race due to setting ATH11K_FLAG_EXT_IRQ_ENABLED too early

Minsuk Kang <linuxlovemin@yonsei.ac.kr>
    wifi: ath9k: Fix potential array-index-out-of-bounds read in ath9k_htc_txstatus()

Yonghong Song <yonghong.song@linux.dev>
    bpf: Fix a few selftest failures due to llvm18 change

Alexander Stein <alexander.stein@ew.tq-group.com>
    ARM: dts: imx7s: Fix nand-controller #size-cells

Alexander Stein <alexander.stein@ew.tq-group.com>
    ARM: dts: imx7s: Fix lcdif compatible

Alexander Stein <alexander.stein@ew.tq-group.com>
    ARM: dts: imx7d: Fix coresight funnel ports

ching Huang <ching2048@areca.com.tw>
    scsi: arcmsr: Support new PCI device IDs 1883 and 1886

Sumit Saxena <sumit.saxena@broadcom.com>
    scsi: mpi3mr: Add PCI checks where SAS5116 diverges from SAS4116

Sumit Saxena <sumit.saxena@broadcom.com>
    scsi: mpi3mr: Add support for SAS5116 PCI IDs

Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
    net: usb: ax88179_178a: avoid two consecutive device resets

Zhengchao Shao <shaozhengchao@huawei.com>
    bonding: return -ENOMEM instead of BUG in alb_upper_dev_walk

Ido Schimmel <idosch@nvidia.com>
    PCI: Add no PM reset quirk for NVIDIA Spectrum devices

Kory Maincent <kory.maincent@bootlin.com>
    net: phy: micrel: fix ts_info value in case of no phc

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: samsung: s5pv210: fix camera unit addresses/ranges

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    ARM: dts: samsung: exynos4: fix camera unit addresses/ranges

Justin Tee <justin.tee@broadcom.com>
    scsi: lpfc: Fix possible file string name overflow when updating firmware

Tanmay Shah <tanmay.shah@xilinx.com>
    soc: xilinx: fix unhandled SGI warning message

HariBabu Gattem <haribabu.gattem@xilinx.com>
    soc: xilinx: Fix for call trace due to the usage of smp_processor_id()

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    ARM: dts: qcom: msm8660: fix PMIC node labels

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    ARM: dts: qcom: mdm9615: fix PMIC node labels

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    ARM: dts: qcom: strip prefix from PMIC files

Yafang Shao <laoar.shao@gmail.com>
    selftests/bpf: Fix issues in setup_classid_environment()

Shiji Yang <yangshiji66@outlook.com>
    wifi: rt2x00: correct wrong BBP register in RxDCOC calibration

Yonghong Song <yonghong.song@linux.dev>
    selftests/bpf: Fix pyperf180 compilation failure with clang18

Yonghong Song <yonghong.song@linux.dev>
    libbpf: Fix potential uninitialized tail padding with LIBBPF_OPTS_RESET

Andrii Nakryiko <andrii@kernel.org>
    selftests/bpf: satisfy compiler by having explicit return in btf test

Andrii Nakryiko <andrii@kernel.org>
    selftests/bpf: fix RELEASE=1 build for tc_opts

Shiji Yang <yangshiji66@outlook.com>
    wifi: rt2x00: restart beacon queue when hardware reset

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: rtw89: fix timeout calculation in rtw89_roc_end()

Baokun Li <libaokun1@huawei.com>
    ext4: avoid online resizing failures due to oversized flex bg

Baokun Li <libaokun1@huawei.com>
    ext4: remove unnecessary check from alloc_flex_gd()

Baokun Li <libaokun1@huawei.com>
    ext4: unify the type of flexbg_size to unsigned int

Ye Bin <yebin10@huawei.com>
    ext4: fix inconsistent between segment fstrim and full fstrim

Gabriel Krisman Bertazi <krisman@suse.de>
    ecryptfs: Reject casefold directory inodes

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix hardlinking of reparse points

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix renaming of reparse points

Ojaswin Mujoo <ojaswin@linux.ibm.com>
    ext4: treat end of range as exclusive in ext4_zero_range()

Anna Schumaker <Anna.Schumaker@Netapp.com>
    SUNRPC: Fix a suspicious RCU usage warning

Joel Granados <j.granados@samsung.com>
    sysctl: Fix out of bounds access for empty sysctl registers

Heiko Carstens <hca@linux.ibm.com>
    KVM: s390: fix setting of fpc register

Heiko Carstens <hca@linux.ibm.com>
    s390/ptrace: handle setting of fpc register correctly

Tony Krowiak <akrowiak@linux.ibm.com>
    s390/vfio-ap: fix sysfs status attribute for AP queue devices

Arnd Bergmann <arnd@arndb.de>
    arch: consolidate arch_irq_work_raise prototypes

Alexander Gordeev <agordeev@linux.ibm.com>
    s390/boot: always align vmalloc area on segment boundary

Edward Adam Davis <eadavis@qq.com>
    jfs: fix array-index-out-of-bounds in diNewExt

Oleg Nesterov <oleg@redhat.com>
    rxrpc_find_service_conn_rcu: fix the usage of read_seqbegin_or_lock()

Oleg Nesterov <oleg@redhat.com>
    afs: fix the usage of read_seqbegin_or_lock() in afs_find_server*()

Oleg Nesterov <oleg@redhat.com>
    afs: fix the usage of read_seqbegin_or_lock() in afs_lookup_volume_rcu()

Thomas Bourgoin <thomas.bourgoin@foss.st.com>
    crypto: stm32/crc32 - fix parsing list of devices

Gao Xiang <xiang@kernel.org>
    erofs: fix ztailpacking for subpage compressed blocks

Bharat Bhushan <bbhushan2@marvell.com>
    crypto: octeontx2 - Fix cptvf driver cleanup

Jia Jie Ho <jiajie.ho@starfivetech.com>
    crypto: starfive - Fix dev_err_probe return error

Gao Xiang <xiang@kernel.org>
    erofs: fix up compacted indexes for block size < 4096

Weichen Chen <weichen.chen@mediatek.com>
    pstore/ram: Fix crash when setting number of cpus to an odd number

Gustavo A. R. Silva <gustavoars@kernel.org>
    crypto: p10-aes-gcm - Avoid -Wstringop-overflow warnings

Jia Jie Ho <jiajie.ho@starfivetech.com>
    hwrng: starfive - Fix dev_err_probe return error

Edward Adam Davis <eadavis@qq.com>
    jfs: fix uaf in jfs_evict_inode

Manas Ghandat <ghandatmanas@gmail.com>
    jfs: fix array-index-out-of-bounds in dbAdjTree

Manas Ghandat <ghandatmanas@gmail.com>
    jfs: fix slab-out-of-bounds Read in dtSearch

Osama Muhammad <osmtendev@gmail.com>
    UBSAN: array-index-out-of-bounds in dtSplitRoot

Osama Muhammad <osmtendev@gmail.com>
    FS:JFS:UBSAN:array-index-out-of-bounds in dbAdjTree

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    thermal: core: Fix thermal zone suspend-resume synchronization

Shuai Xue <xueshuai@linux.alibaba.com>
    ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED on synchronous events

Mukesh Ojha <quic_mojha@quicinc.com>
    PM / devfreq: Synchronize devfreq_monitor_[start/stop]

Rae Moar <rmoar@google.com>
    kunit: tool: fix parsing of test attributes

Yuntao Wang <ytcoode@gmail.com>
    ACPI: NUMA: Fix the logic of getting the fake_pxm value

Thomas Weißschuh <linux@weissschuh.net>
    selftests/nolibc: fix testcase status alignment

Prarit Bhargava <prarit@redhat.com>
    ACPI: extlog: fix NULL pointer dereference check

Dmitry Antipov <dmantipov@yandex.ru>
    PNP: ACPI: fix fortify warning

Yuluo Qiu <qyl27@outlook.com>
    ACPI: video: Add quirk for the Colorful X15 AT 23 Laptop

Chris Riches <chris.riches@nutanix.com>
    audit: Send netlink ACK before setting connection in auditd_set

Rui Zhang <zr.zhang@vivo.com>
    regulator: core: Only increment use_count when enable_count changes

Andrzej Hajda <andrzej.hajda@intel.com>
    debugobjects: Stop accessing objects after releasing hash bucket lock

Greg KH <gregkh@linuxfoundation.org>
    perf/core: Fix narrow startup race when creating the perf nr_addr_filters sysfs file

Zhiquan Li <zhiquan1.li@intel.com>
    x86/mce: Mark fatal MCE's page as poison to avoid panic in the kdump kernel

Naveen N Rao <naveen@kernel.org>
    powerpc/lib: Validate size for vector operations

Stephen Rothwell <sfr@canb.auug.org.au>
    powerpc: pmd_move_must_withdraw() is only needed for CONFIG_TRANSPARENT_HUGEPAGE

Jun'ichi Nomura <junichi.nomura@nec.com>
    x86/boot: Ignore NMIs during very early boot

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Fix CONFIG_NUMA=n build due to create_section_mapping()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/mm: Fix build failures due to arch_reserved_kernel_pages()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc: Fix build error due to is_valid_bugaddr()

Mark Rutland <mark.rutland@arm.com>
    drivers/perf: pmuv3: don't expose SW_INCR event in sysfs

Huang Shijie <shijie@os.amperecomputing.com>
    arm64: irq: set the correct node for VMAP stack

Kunwu Chan <chentao@kylinos.cn>
    powerpc/mm: Fix null-pointer dereference in pgtable_cache_add

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    asm-generic: make sparse happy with odd-sized put_unaligned_*()

Benjamin Gray <bgray@linux.ibm.com>
    Documentation/sphinx: fix Python string escapes


-------------

Diffstat:

 Documentation/ABI/testing/sysfs-class-net-queues   |  22 +-
 Documentation/sound/soc/dapm.rst                   |   2 +-
 Documentation/sphinx/cdomain.py                    |   2 +-
 Documentation/sphinx/kernel_abi.py                 |   2 +-
 Documentation/sphinx/kernel_feat.py                |   2 +-
 Documentation/sphinx/kerneldoc.py                  |   2 +-
 Documentation/sphinx/maintainers_include.py        |   8 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/nxp/imx/imx1-ads.dts             |   2 +-
 arch/arm/boot/dts/nxp/imx/imx1-apf9328.dts         |   2 +-
 arch/arm/boot/dts/nxp/imx/imx1.dtsi                |   5 +-
 .../boot/dts/nxp/imx/imx25-eukrea-cpuimx25.dtsi    |   2 +-
 .../imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts  |   2 +-
 .../imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts  |   2 +-
 .../imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts   |   2 +-
 arch/arm/boot/dts/nxp/imx/imx25-pdk.dts            |   2 +-
 arch/arm/boot/dts/nxp/imx/imx25.dtsi               |   2 +-
 arch/arm/boot/dts/nxp/imx/imx27-apf27dev.dts       |   4 +-
 .../boot/dts/nxp/imx/imx27-eukrea-cpuimx27.dtsi    |   4 +-
 .../nxp/imx/imx27-eukrea-mbimxsd27-baseboard.dts   |   2 +-
 .../dts/nxp/imx/imx27-phytec-phycard-s-rdk.dts     |   2 +-
 .../boot/dts/nxp/imx/imx27-phytec-phycore-rdk.dts  |   2 +-
 .../boot/dts/nxp/imx/imx27-phytec-phycore-som.dtsi |   2 +-
 arch/arm/boot/dts/nxp/imx/imx27.dtsi               |   3 +
 arch/arm/boot/dts/nxp/imx/imx7d.dtsi               |   3 -
 arch/arm/boot/dts/nxp/imx/imx7s.dtsi               |  10 +-
 arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts          |  12 +-
 arch/arm/boot/dts/nxp/mxs/imx23.dtsi               |   2 +-
 arch/arm/boot/dts/nxp/mxs/imx28.dtsi               |   2 +-
 .../dts/qcom/{qcom-pm8226.dtsi => pm8226.dtsi}     |   0
 .../dts/qcom/{qcom-pm8841.dtsi => pm8841.dtsi}     |   0
 .../dts/qcom/{qcom-pm8941.dtsi => pm8941.dtsi}     |   0
 .../dts/qcom/{qcom-pma8084.dtsi => pma8084.dtsi}   |   0
 .../boot/dts/qcom/{qcom-pmx55.dtsi => pmx55.dtsi}  |   0
 .../boot/dts/qcom/{qcom-pmx65.dtsi => pmx65.dtsi}  |   0
 .../boot/dts/qcom/qcom-apq8026-asus-sparrow.dts    |   2 +-
 .../boot/dts/qcom/qcom-apq8026-huawei-sturgeon.dts |   2 +-
 arch/arm/boot/dts/qcom/qcom-apq8026-lg-lenok.dts   |   2 +-
 .../dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts |   2 +-
 .../arm/boot/dts/qcom/qcom-apq8060-dragonboard.dts |   4 +-
 .../arm/boot/dts/qcom/qcom-apq8074-dragonboard.dts |   4 +-
 arch/arm/boot/dts/qcom/qcom-apq8084-ifc6540.dts    |   2 +-
 arch/arm/boot/dts/qcom/qcom-apq8084-mtp.dts        |   2 +-
 arch/arm/boot/dts/qcom/qcom-mdm9615-wp8548.dtsi    |   2 +-
 arch/arm/boot/dts/qcom/qcom-mdm9615.dtsi           |  14 +-
 arch/arm/boot/dts/qcom/qcom-msm8660.dtsi           |  16 +-
 .../qcom/qcom-msm8974-lge-nexus5-hammerhead.dts    |   4 +-
 .../dts/qcom/qcom-msm8974-sony-xperia-rhine.dtsi   |   4 +-
 .../dts/qcom/qcom-msm8974pro-fairphone-fp2.dts     |   4 +-
 .../dts/qcom/qcom-msm8974pro-oneplus-bacon.dts     |   4 +-
 .../boot/dts/qcom/qcom-msm8974pro-samsung-klte.dts |   2 +-
 .../qcom-msm8974pro-sony-xperia-shinano-castor.dts |   4 +-
 arch/arm/boot/dts/qcom/qcom-sdx55-mtp.dts          |   2 +-
 arch/arm/boot/dts/qcom/qcom-sdx55-t55.dts          |   2 +-
 .../boot/dts/qcom/qcom-sdx55-telit-fn980-tlb.dts   |   2 +-
 arch/arm/boot/dts/qcom/qcom-sdx65-mtp.dts          |   2 +-
 arch/arm/boot/dts/rockchip/rk3036.dtsi             |  14 +-
 arch/arm/boot/dts/samsung/exynos4.dtsi             |  26 +--
 arch/arm/boot/dts/samsung/exynos4x12.dtsi          |  17 +-
 arch/arm/boot/dts/samsung/s5pv210.dtsi             |  18 +-
 arch/arm/include/asm/irq_work.h                    |   2 -
 .../boot/dts/amlogic/meson-s4-s805x2-aq222.dts     |   4 +-
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi          |   4 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  21 ++
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  32 +--
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   5 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |   5 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |  24 +--
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |   8 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |   8 +-
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |   8 +-
 arch/arm64/boot/dts/sprd/ums512.dtsi               |   3 +-
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso      |  40 ++--
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso      |  42 ++--
 arch/arm64/include/asm/irq_work.h                  |   2 -
 arch/arm64/kernel/irq.c                            |   7 +-
 arch/csky/include/asm/irq_work.h                   |   2 +-
 arch/loongarch/kernel/smp.c                        |   1 -
 arch/loongarch/mm/tlb.c                            |  16 +-
 arch/powerpc/crypto/aes-gcm-p10-glue.c             |   2 +-
 arch/powerpc/include/asm/irq_work.h                |   1 -
 arch/powerpc/include/asm/mmu.h                     |   4 +
 arch/powerpc/include/asm/mmzone.h                  |   8 -
 arch/powerpc/kernel/traps.c                        |   2 +
 arch/powerpc/lib/sstep.c                           |  10 +
 arch/powerpc/mm/book3s64/pgtable.c                 |   2 +
 arch/powerpc/mm/init-common.c                      |   5 +-
 arch/powerpc/mm/mmu_decl.h                         |   5 +
 arch/riscv/include/asm/irq_work.h                  |   2 +-
 arch/riscv/kernel/head.S                           |   1 +
 arch/riscv/mm/init.c                               |  12 +-
 arch/s390/boot/ipl_parm.c                          |   2 +-
 arch/s390/boot/startup.c                           |   3 +-
 arch/s390/include/asm/irq_work.h                   |   2 -
 arch/s390/kernel/ptrace.c                          |   6 +-
 arch/s390/kvm/kvm-s390.c                           |   5 -
 arch/um/drivers/net_kern.c                         |   2 +-
 arch/um/include/shared/kern_util.h                 |   2 +-
 arch/um/kernel/process.c                           |   2 +-
 arch/um/kernel/time.c                              |  32 ++-
 arch/um/os-Linux/helper.c                          |   6 +-
 arch/um/os-Linux/util.c                            |  19 +-
 arch/x86/boot/compressed/ident_map_64.c            |   5 +
 arch/x86/boot/compressed/idt_64.c                  |   1 +
 arch/x86/boot/compressed/idt_handlers_64.S         |   1 +
 arch/x86/boot/compressed/misc.h                    |   1 +
 arch/x86/include/asm/irq_work.h                    |   1 -
 arch/x86/include/asm/kmsan.h                       |  17 +-
 arch/x86/kernel/cpu/mce/core.c                     |  16 ++
 block/bio.c                                        |   2 +-
 block/blk-mq.c                                     |  16 ++
 drivers/accel/habanalabs/common/device.c           |   3 +
 drivers/accel/habanalabs/common/habanalabs.h       |   2 +
 drivers/accel/habanalabs/common/habanalabs_drv.c   |   3 +
 drivers/accel/habanalabs/common/mmu/mmu.c          |   1 +
 drivers/accel/habanalabs/common/sysfs.c            |   3 +
 .../habanalabs/include/hw_ip/pci/pci_general.h     |   1 +
 drivers/acpi/acpi_extlog.c                         |   5 +-
 drivers/acpi/acpi_video.c                          |   9 +
 drivers/acpi/apei/ghes.c                           |  29 ++-
 drivers/acpi/numa/srat.c                           |   4 +-
 drivers/base/arch_numa.c                           |   2 +-
 drivers/block/rnbd/rnbd-srv.c                      |  19 +-
 drivers/bluetooth/hci_qca.c                        |   1 +
 drivers/char/hw_random/jh7110-trng.c               |   2 +-
 drivers/clk/hisilicon/clk-hi3620.c                 |   4 +-
 drivers/clk/imx/clk-imx8qxp.c                      |  24 ++-
 drivers/clk/mmp/clk-of-pxa168.c                    |   3 +
 drivers/crypto/marvell/octeontx2/otx2_cptlf.c      |   6 +-
 drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c |   3 +
 drivers/crypto/starfive/jh7110-cryp.c              |   2 +-
 drivers/crypto/stm32/stm32-crc32.c                 |   2 +-
 drivers/devfreq/devfreq.c                          |  24 ++-
 drivers/extcon/extcon.c                            |   3 +-
 drivers/gpu/drm/amd/amdgpu/aldebaran.c             |  26 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |  21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |  31 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |   6 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c           |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c           |   4 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |   4 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c             |   5 +
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |   4 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   8 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c            |   4 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |   2 +
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  42 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |  24 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  30 +--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c |   9 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   4 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |   2 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   3 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  23 ++-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c |   3 +-
 .../amd/display/dc/dml/dcn32/display_mode_vba_32.c |   3 +
 .../dc/dml/dcn32/display_mode_vba_util_32.c        |  33 ++-
 .../dc/dml/dcn32/display_mode_vba_util_32.h        |   1 +
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c    |  13 +-
 .../display/dc/link/protocols/link_dp_dpia_bw.c    | 221 +++++++++------------
 .../display/dc/link/protocols/link_dp_dpia_bw.h    |   4 +-
 .../drm/amd/display/modules/power/power_helpers.c  |   2 -
 drivers/gpu/drm/amd/include/amd_shared.h           |   2 -
 drivers/gpu/drm/amd/include/mes_v11_api_def.h      |   3 +-
 .../amd/pm/powerplay/hwmgr/process_pptables_v1_0.c |   2 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  17 +-
 drivers/gpu/drm/bridge/analogix/anx7625.c          |  51 +++--
 drivers/gpu/drm/bridge/analogix/anx7625.h          |   4 +
 drivers/gpu/drm/drm_file.c                         |   2 +-
 drivers/gpu/drm/drm_framebuffer.c                  |   2 +-
 drivers/gpu/drm/drm_mipi_dsi.c                     |  17 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |  11 +
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h |  18 ++
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h |  18 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.c          |   3 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h            |   1 +
 drivers/gpu/drm/msm/dp/dp_display.c                |   6 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |   4 +
 drivers/gpu/drm/panel/panel-edp.c                  |  48 ++++-
 drivers/hid/hidraw.c                               |   7 +-
 drivers/hwmon/hp-wmi-sensors.c                     | 127 ++++++++++--
 drivers/hwmon/nct6775-core.c                       |   7 +
 drivers/i2c/busses/i2c-rk3x.c                      |   8 +-
 drivers/i3c/master/i3c-master-cdns.c               |   7 +-
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c     |   7 +-
 drivers/leds/trigger/ledtrig-panic.c               |   5 +-
 drivers/mailbox/arm_mhuv2.c                        |   3 +-
 drivers/md/md.c                                    |  54 ++++-
 drivers/media/i2c/imx335.c                         |   4 +-
 drivers/media/pci/ddbridge/ddbridge-main.c         |   2 +-
 drivers/media/platform/amphion/vpu.h               |   3 +-
 drivers/media/platform/amphion/vpu_cmds.c          |  28 +--
 drivers/media/platform/amphion/vpu_v4l2.c          |   1 +
 drivers/media/platform/rockchip/rga/rga.c          |  15 +-
 .../media/platform/rockchip/rkisp1/rkisp1-common.h |  11 +-
 .../media/platform/rockchip/rkisp1/rkisp1-csi.c    |  14 +-
 .../media/platform/rockchip/rkisp1/rkisp1-dev.c    |  35 +++-
 .../media/platform/rockchip/rkisp1/rkisp1-isp.c    |  20 +-
 .../platform/rockchip/rkisp1/rkisp1-resizer.c      |  38 ++--
 drivers/media/usb/stk1160/stk1160-video.c          |   5 +-
 drivers/media/usb/uvc/uvc_driver.c                 |  18 ++
 drivers/mfd/Kconfig                                |   1 +
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c             |   1 +
 drivers/net/bonding/bond_alb.c                     |   3 +-
 drivers/net/dsa/mt7530.c                           |   3 +-
 drivers/net/dsa/mv88e6xxx/chip.h                   |   4 +-
 drivers/net/dsa/mv88e6xxx/serdes.c                 |  10 +-
 drivers/net/dsa/mv88e6xxx/serdes.h                 |   8 +-
 drivers/net/dsa/qca/qca8k-8xxx.c                   |  24 ++-
 drivers/net/ethernet/amd/pds_core/adminq.c         |  64 ++++--
 drivers/net/ethernet/amd/pds_core/core.c           |  52 +++--
 drivers/net/ethernet/amd/pds_core/core.h           |   6 +-
 drivers/net/ethernet/amd/pds_core/debugfs.c        |   4 +
 drivers/net/ethernet/amd/pds_core/dev.c            |  16 +-
 drivers/net/ethernet/amd/pds_core/devlink.c        |   3 +-
 drivers/net/ethernet/amd/pds_core/fw.c             |   3 +
 drivers/net/ethernet/amd/pds_core/main.c           |  74 ++++++-
 drivers/net/ethernet/aquantia/atlantic/aq_ptp.c    |  28 +--
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |  61 ++----
 drivers/net/ethernet/aquantia/atlantic/aq_ring.h   |  22 +-
 drivers/net/ethernet/aquantia/atlantic/aq_vec.c    |  23 +--
 drivers/net/ethernet/google/gve/gve_rx.c           |   8 +-
 drivers/net/ethernet/intel/e1000e/e1000.h          |  20 ++
 drivers/net/ethernet/intel/e1000e/ptp.c            |  22 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  32 +++
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   1 +
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h    |  18 +-
 drivers/net/ethernet/intel/ice/ice_lib.c           |   7 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c      |  12 +-
 drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c  |  16 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c     |  36 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c     |  61 +++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c    | 145 +++++++-------
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  42 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c       |  34 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h       |   1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c       | 105 +++++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h       |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h      |  43 +---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c      |  44 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      | 149 +++++++-------
 drivers/net/ethernet/marvell/mvmdio.c              |  53 ++---
 .../net/ethernet/marvell/octeontx2/af/rvu_npc.c    |  13 +-
 .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c  |   1 -
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |   3 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c |   7 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |   5 +-
 .../net/ethernet/microchip/lan966x/lan966x_port.c  |   5 +-
 .../net/ethernet/pensando/ionic/ionic_bus_pci.c    |   4 +
 drivers/net/ethernet/pensando/ionic/ionic_dev.c    |   1 +
 drivers/net/ethernet/pensando/ionic/ionic_dev.h    |   1 +
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |   3 +
 drivers/net/ethernet/pensando/ionic/ionic_main.c   |  22 +-
 drivers/net/phy/at803x.c                           |   6 +-
 drivers/net/phy/mediatek-ge-soc.c                  | 147 ++++++++------
 drivers/net/phy/micrel.c                           |   6 +-
 drivers/net/usb/ax88179_178a.c                     |   2 -
 drivers/net/virtio_net.c                           |   9 +-
 drivers/net/wireless/ath/ath11k/pcic.c             |   4 +-
 drivers/net/wireless/ath/ath12k/hal.c              |   4 +-
 drivers/net/wireless/ath/ath12k/hw.c               |   3 +-
 drivers/net/wireless/ath/ath12k/mac.c              |   4 +-
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c      |   5 +-
 .../net/wireless/mediatek/mt76/mt76_connac_mcu.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c    |   8 +-
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c     |   2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c     |   3 +
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c     |  11 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |  12 ++
 .../net/wireless/realtek/rtlwifi/rtl8723ae/phy.c   |   6 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/phy.c   |   4 +-
 drivers/net/wireless/realtek/rtw89/coex.c          |   4 +-
 drivers/net/wireless/realtek/rtw89/core.c          |   2 +-
 drivers/net/wireless/realtek/rtw89/core.h          |  12 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  17 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |  29 ++-
 drivers/net/wireless/realtek/rtw89/mac.h           |   1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   3 +
 drivers/net/wireless/silabs/wfx/sta.c              |  42 ++--
 drivers/pci/pci.h                                  |   2 +-
 drivers/pci/pcie/aer.c                             |   9 +-
 drivers/pci/quirks.c                               |  24 ++-
 drivers/pci/switch/switchtec.c                     |  25 ++-
 drivers/perf/arm_pmuv3.c                           |   6 +-
 drivers/pinctrl/intel/pinctrl-baytrail.c           |   3 +-
 drivers/pnp/pnpacpi/rsparser.c                     |  12 +-
 drivers/regulator/core.c                           |  56 +++---
 drivers/regulator/ti-abb-regulator.c               |  22 +-
 drivers/s390/crypto/vfio_ap_ops.c                  |  16 +-
 drivers/scsi/arcmsr/arcmsr.h                       |   4 +
 drivers/scsi/arcmsr/arcmsr_hba.c                   |   6 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c             |  10 +-
 drivers/scsi/isci/request.c                        |   2 +-
 drivers/scsi/libfc/fc_fcp.c                        |  18 +-
 drivers/scsi/lpfc/lpfc.h                           |   1 +
 drivers/scsi/lpfc/lpfc_els.c                       |  14 +-
 drivers/scsi/lpfc/lpfc_init.c                      |   4 +-
 drivers/scsi/lpfc/lpfc_vmid.c                      |   1 +
 drivers/scsi/mpi3mr/mpi3mr_fw.c                    |   3 +-
 drivers/scsi/mpi3mr/mpi3mr_os.c                    |  13 +-
 drivers/scsi/scsi_error.c                          |   8 +-
 drivers/scsi/scsi_lib.c                            |   2 +-
 drivers/scsi/scsi_priv.h                           |   2 +-
 drivers/soc/xilinx/xlnx_event_manager.c            |   7 +-
 drivers/spmi/spmi-mtk-pmif.c                       |   7 +-
 drivers/thermal/thermal_core.c                     |  30 ++-
 drivers/tty/tty_ioctl.c                            |   4 +-
 drivers/usb/core/hub.c                             |  33 ++-
 drivers/usb/host/xhci-plat.c                       |  23 ++-
 drivers/watchdog/it87_wdt.c                        |  14 +-
 drivers/watchdog/starfive-wdt.c                    |   2 +
 drivers/xen/gntdev-dmabuf.c                        |  50 ++---
 fs/9p/v9fs_vfs.h                                   |   1 +
 fs/9p/vfs_inode.c                                  |   6 +-
 fs/9p/vfs_inode_dotl.c                             |   1 +
 fs/afs/callback.c                                  |   3 +-
 fs/afs/server.c                                    |   7 +-
 fs/ceph/caps.c                                     |   9 +-
 fs/ceph/mds_client.c                               |   2 +-
 fs/ceph/quota.c                                    |  39 ++--
 fs/dcache.c                                        |   7 +-
 fs/ecryptfs/inode.c                                |   8 +
 fs/erofs/zdata.c                                   |   2 +-
 fs/erofs/zmap.c                                    |  32 ++-
 fs/ext4/extents.c                                  |   6 +-
 fs/ext4/mballoc.c                                  |  11 +-
 fs/ext4/resize.c                                   |  37 ++--
 fs/f2fs/compress.c                                 |   4 +-
 fs/f2fs/file.c                                     |   2 +
 fs/f2fs/recovery.c                                 |  25 ++-
 fs/jfs/jfs_dmap.c                                  |  57 +++---
 fs/jfs/jfs_dtree.c                                 |   7 +-
 fs/jfs/jfs_imap.c                                  |   3 +
 fs/jfs/jfs_mount.c                                 |   6 +-
 fs/kernfs/dir.c                                    |  12 ++
 fs/proc/proc_sysctl.c                              |   9 +-
 fs/pstore/ram.c                                    |   1 +
 fs/reiserfs/namei.c                                |  54 ++---
 fs/smb/client/cifsglob.h                           |  30 ++-
 fs/smb/client/cifsproto.h                          |  15 +-
 fs/smb/client/cifssmb.c                            |  17 +-
 fs/smb/client/inode.c                              |   3 +-
 fs/smb/client/link.c                               |   4 +-
 fs/smb/client/smb2inode.c                          |  55 +++--
 fs/smb/client/smb2proto.h                          |  16 +-
 include/asm-generic/numa.h                         |   2 +
 include/asm-generic/unaligned.h                    |  24 +--
 include/drm/drm_color_mgmt.h                       |   1 +
 include/drm/drm_mipi_dsi.h                         |   2 +
 include/linux/irq_work.h                           |   3 +
 include/linux/minmax.h                             | 129 ++++++------
 include/linux/mmzone.h                             |   6 +-
 include/linux/netfilter/ipset/ip_set.h             |   4 +
 include/linux/pci_ids.h                            |   1 +
 include/linux/thermal.h                            |   2 +
 include/net/af_unix.h                              |  20 +-
 include/net/ip.h                                   |   2 +-
 include/net/netfilter/nf_tables.h                  |   2 +
 kernel/audit.c                                     |  31 ++-
 kernel/bpf/arraymap.c                              |  23 ++-
 kernel/bpf/helpers.c                               |  13 +-
 kernel/bpf/syscall.c                               |   6 +
 kernel/events/core.c                               |  38 ++--
 lib/debugobjects.c                                 | 200 ++++++++-----------
 lib/kunit/executor.c                               |   4 +
 lib/kunit/test.c                                   |  14 +-
 net/bluetooth/hci_sync.c                           |  10 +-
 net/bluetooth/iso.c                                |  51 ++++-
 net/bluetooth/l2cap_core.c                         |   3 +-
 net/bpf/test_run.c                                 |   2 +-
 net/bridge/br_cfm_netlink.c                        |   2 +-
 net/bridge/br_multicast.c                          |  20 +-
 net/bridge/br_private.h                            |   4 +-
 net/devlink/port.c                                 |   2 +-
 net/ipv4/ip_output.c                               |  12 +-
 net/ipv4/ip_sockglue.c                             |   6 +-
 net/ipv4/ipmr.c                                    |   2 +-
 net/ipv4/raw.c                                     |   2 +-
 net/ipv4/tcp.c                                     |  12 +-
 net/ipv4/udp.c                                     |   2 +-
 net/ipv6/addrconf_core.c                           |  21 +-
 net/ipv6/ip6_tunnel.c                              |  21 +-
 net/kcm/kcmsock.c                                  |   2 +-
 net/llc/af_llc.c                                   |   2 +
 net/netfilter/ipset/ip_set_bitmap_gen.h            |  14 +-
 net/netfilter/ipset/ip_set_core.c                  |  37 +++-
 net/netfilter/ipset/ip_set_hash_gen.h              |  15 +-
 net/netfilter/ipset/ip_set_list_set.c              |  13 +-
 net/netfilter/nf_conntrack_proto_tcp.c             |  10 +-
 net/netfilter/nf_log.c                             |   7 +-
 net/netfilter/nf_tables_api.c                      |  14 +-
 net/netfilter/nft_ct.c                             |  24 +++
 net/netfilter/nft_tunnel.c                         |   1 +
 net/rxrpc/conn_service.c                           |   3 +-
 net/smc/smc_clc.c                                  |  14 ++
 net/sunrpc/xprtmultipath.c                         |  17 +-
 net/unix/af_unix.c                                 |  14 +-
 net/unix/diag.c                                    |   2 +-
 net/wireless/scan.c                                |   4 +
 sound/hda/hdac_stream.c                            |   9 +-
 sound/hda/intel-dsp-config.c                       |  10 +
 sound/pci/hda/hda_intel.c                          |   2 +
 sound/pci/hda/patch_conexant.c                     | 115 ++++++++++-
 sound/soc/amd/acp-config.c                         |  15 +-
 sound/soc/codecs/lpass-wsa-macro.c                 |   7 -
 sound/soc/codecs/wcd938x.c                         |   2 +-
 sound/soc/codecs/wsa883x.c                         |   6 +-
 sound/soc/qcom/sc8280xp.c                          |  12 +-
 tools/build/feature/test-libopencsd.c              |   4 +-
 tools/lib/bpf/libbpf.c                             |   2 +
 tools/lib/bpf/libbpf_common.h                      |  13 +-
 tools/lib/subcmd/help.c                            |  18 +-
 tools/testing/kunit/kunit_parser.py                |   4 +-
 tools/testing/selftests/bpf/cgroup_helpers.c       |  18 +-
 tools/testing/selftests/bpf/prog_tests/btf.c       |   6 +-
 tools/testing/selftests/bpf/prog_tests/tc_opts.c   |   6 +-
 tools/testing/selftests/bpf/progs/pyperf180.c      |  22 ++
 .../selftests/bpf/progs/test_global_func17.c       |   1 +
 tools/testing/selftests/bpf/veristat.c             |   2 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |   2 +-
 .../selftests/drivers/net/bonding/lag_lib.sh       |  11 +
 tools/testing/selftests/drivers/net/team/config    |   4 +-
 tools/testing/selftests/net/Makefile               |   5 +-
 tools/testing/selftests/net/config                 |  16 ++
 tools/testing/selftests/net/pmtu.sh                |  18 +-
 tools/testing/selftests/net/setup_veth.sh          |   2 +-
 tools/testing/selftests/net/udpgro.sh              |   4 +-
 tools/testing/selftests/net/udpgro_bench.sh        |   4 +-
 tools/testing/selftests/net/udpgro_frglist.sh      |   6 +-
 tools/testing/selftests/net/udpgro_fwd.sh          |   8 +-
 tools/testing/selftests/net/veth.sh                |   4 +-
 tools/testing/selftests/net/xdp_dummy.c            |  13 ++
 tools/testing/selftests/nolibc/nolibc-test.c       |   4 +-
 tools/testing/selftests/sgx/test_encl.lds          |   6 +-
 447 files changed, 3791 insertions(+), 2156 deletions(-)



