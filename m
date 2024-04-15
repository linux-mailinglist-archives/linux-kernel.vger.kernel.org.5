Return-Path: <linux-kernel+bounces-145378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEC58A5543
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A8F282547
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CC4745C9;
	Mon, 15 Apr 2024 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S3ry4WMq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF25F2119;
	Mon, 15 Apr 2024 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713192151; cv=none; b=S7IcDrPh8NkeFJD6zJChixJClPW1bqb8Uy5vyHgmOikEINwVcrWDUUb6TNuSO19uPBLrHOnxJLbQVor4FdiwkPOOvuzhpbnkOMue8X8cjNgOwpSCuYD9pnNUugloXikeK4WYnP84u7C2WC1zvF2MYlqplZ1E2Nlcdf5ObloXT/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713192151; c=relaxed/simple;
	bh=AEE/kAal8msykZr8wNUqNNDQTT2i4kApJdMfbwhU2vY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ThAd27sc35+/O3miq9w4/vxbxUezzL2IqqdFGpTczTUWI6xxow2yeSB7fzz5YXELbHE/+Jt5yvF4xkeSoSbCnB0e0nFSPEqpIfdBinxdXRXW7PpVCVbSr2h4RBPUrJxBbYAajMHgn4npVlhengd44NTdU3WLRMyMIAoXXC2UcNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S3ry4WMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09243C113CC;
	Mon, 15 Apr 2024 14:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713192151;
	bh=AEE/kAal8msykZr8wNUqNNDQTT2i4kApJdMfbwhU2vY=;
	h=From:To:Cc:Subject:Date:From;
	b=S3ry4WMqNoI/OJVr0ckb7xoE1DO7VpqLLHUkgbonOeBZKbc3+5ZHZmNLuv0xadSg1
	 1T6vMVWNfYFGXx3LzmQ8M2JpLxEmYXaHGTvBTP4vWcybc9n7B/ZBFIvS3zhjOpkOec
	 mo37WDuEhP5xuaW/fXi/Qw83agdVIgyhGg5gAImk=
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
Subject: [PATCH 5.15 00/45] 5.15.156-rc1 review
Date: Mon, 15 Apr 2024 16:21:07 +0200
Message-ID: <20240415141942.235939111@linuxfoundation.org>
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
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.156-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.156-rc1
X-KernelTest-Deadline: 2024-04-17T14:19+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.15.156 release.
There are 45 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 17 Apr 2024 14:19:30 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.156-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.156-rc1

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
    vhost: Add smp_rmb() in vhost_vq_avail_empty()

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/client: Fully protect modes[] with dev->mode_config.mutex

Boris Burkov <boris@bur.io>
    btrfs: qgroup: correctly model root qgroup rsv in convert

Jacob Pan <jacob.jun.pan@linux.intel.com>
    iommu/vt-d: Allocate local memory for page request queue

Arnd Bergmann <arnd@arndb.de>
    tracing: hide unused ftrace_event_id_fops

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

Daniel Machon <daniel.machon@microchip.com>
    net: sparx5: fix wrong config being used when reconfiguring PCS

Cosmin Ratiu <cratiu@nvidia.com>
    net/mlx5: Properly link new fs rules into the tree

Eric Dumazet <edumazet@google.com>
    netfilter: complete validation of user input

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

Eric Dumazet <edumazet@google.com>
    geneve: fix header validation in geneve[6]_xmit_skb

Eric Dumazet <edumazet@google.com>
    xsk: validate user input for XDP_{UMEM|COMPLETION}_FILL_RING

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    u64_stats: Disable preemption on 32bit UP+SMP PREEMPT_RT during updates.

Ilya Maximets <i.maximets@ovn.org>
    net: openvswitch: fix unwanted error log on timeout policy probing

Dan Carpenter <dan.carpenter@linaro.org>
    scsi: qla2xxx: Fix off by one in qla_edif_app_getstats()

Arnd Bergmann <arnd@arndb.de>
    nouveau: fix function cast warning

Alex Constantino <dreaming.about.electric.sheep@gmail.com>
    Revert "drm/qxl: simplify qxl_fence_wait"

Frank Li <Frank.Li@nxp.com>
    arm64: dts: imx8-ss-conn: fix usdhc wrong lpcg clock order

Nini Song <nini.song@mediatek.com>
    media: cec: core: remove length check of Timer Status

Dmitry Antipov <dmantipov@yandex.ru>
    Bluetooth: Fix memory leak in hci_req_sync_complete()

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Only update pages_touched when a new page is touched

Sven Eckelmann <sven@narfation.org>
    batman-adv: Avoid infinite loop trying to resize local TT


-------------

Diffstat:

 Documentation/admin-guide/hw-vuln/spectre.rst      |  22 +-
 Documentation/admin-guide/kernel-parameters.txt    |  12 +-
 Makefile                                           |   4 +-
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi    |  12 +-
 arch/x86/Kconfig                                   |  21 +-
 arch/x86/events/core.c                             |   1 +
 arch/x86/include/asm/apic.h                        |   3 +-
 arch/x86/kernel/cpu/bugs.c                         |  82 ++++----
 arch/x86/kernel/cpu/common.c                       |  48 ++---
 drivers/gpu/drm/drm_client_modeset.c               |   3 +-
 drivers/gpu/drm/i915/display/intel_cdclk.c         |   7 +-
 drivers/gpu/drm/i915/display/intel_cdclk.h         |   3 +
 .../gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c    |   7 +-
 drivers/gpu/drm/qxl/qxl_release.c                  |  50 ++++-
 drivers/iommu/intel/svm.c                          |   2 +-
 drivers/media/cec/core/cec-adap.c                  |  14 --
 drivers/net/dsa/mt7530.c                           | 229 ++++++++++++++++++---
 drivers/net/dsa/mt7530.h                           |   5 +
 drivers/net/ethernet/amazon/ena/ena_com.c          |   2 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       |  35 ++--
 .../net/ethernet/marvell/octeontx2/af/rvu_nix.c    |  22 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |   3 +-
 .../net/ethernet/microchip/sparx5/sparx5_port.c    |   4 +-
 drivers/net/geneve.c                               |   4 +-
 drivers/scsi/qla2xxx/qla_edif.c                    |   2 +-
 drivers/vhost/vhost.c                              |  14 +-
 fs/btrfs/qgroup.c                                  |   2 +
 include/linux/dma-fence.h                          |   7 +
 include/linux/irqflags.h                           |   2 +-
 include/linux/u64_stats_sync.h                     |  42 ++--
 include/net/addrconf.h                             |   4 +
 include/net/af_unix.h                              |   2 +-
 include/net/ip_tunnels.h                           |  33 +++
 kernel/cpu.c                                       |   3 +-
 kernel/trace/ring_buffer.c                         |   6 +-
 kernel/trace/trace_events.c                        |   4 +
 net/batman-adv/translation-table.c                 |   2 +-
 net/bluetooth/hci_request.c                        |   4 +-
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
 tools/testing/selftests/timers/posix_timers.c      |   2 +-
 50 files changed, 556 insertions(+), 256 deletions(-)



