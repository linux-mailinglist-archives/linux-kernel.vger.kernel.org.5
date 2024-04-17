Return-Path: <linux-kernel+bounces-148238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE888A7FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1551C20EEA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864FE13A276;
	Wed, 17 Apr 2024 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dYrA/iZd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C43F1311A1;
	Wed, 17 Apr 2024 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346457; cv=none; b=IkcZH3/o3nyzmZzrQ9gjjpNi+zILnL32lLTezLd/LtVI5i3G8OwDvUL5F3kxTBlhLAnx2QMI07P9rew+TFDbBQmzryU2P/OkUwsJYpHKG7ne394MFHaDgQF41SYMRdqUIch6vwgQ1cO9hDydXNK9Zp37vsJQddJzJmkLog7kizk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346457; c=relaxed/simple;
	bh=H0TZSaI3kRJEDHXgtyCauVovt06qSkBze7Q+rX7GN9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ju/urvMM0B46t98OkDvX8vJC6cAfiU0rXT9crt57vdfR9qCVUIhvlZ2U2PX20HXcoXDIrzDGSu9IiWePsajm07gVxraB4azpS1IwDkTFbZUmvxViGk9URa7ubdNghyoi7jtfUEAEZWumYjzHEbXGxajfZM/M08bgkz6m0JAud7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dYrA/iZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F12C2BD10;
	Wed, 17 Apr 2024 09:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713346457;
	bh=H0TZSaI3kRJEDHXgtyCauVovt06qSkBze7Q+rX7GN9M=;
	h=From:To:Cc:Subject:Date:From;
	b=dYrA/iZdWnkVuCWJ68Ie7YMnLBWryCMSJZK84FWF+8FG9ySxqPuMbukrwg6yYJ07J
	 UTQgMd+axUkmrHhFPfkR2Ew2G0ZhE2bDIhO1DyPsxpUV1D7T1sbew8trXtY/kEKOkZ
	 a3ZrPb86tjNi4mTPiTPprPuyWFW7rD/sugZOkqHE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.87
Date: Wed, 17 Apr 2024 11:34:12 +0200
Message-ID: <2024041711-acronym-grading-1a9c@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.1.87 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/hw-vuln/spectre.rst                  |   22 
 Documentation/admin-guide/kernel-parameters.txt                |   12 
 Makefile                                                       |    2 
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi                |   12 
 arch/x86/Kconfig                                               |   21 
 arch/x86/events/core.c                                         |    1 
 arch/x86/include/asm/apic.h                                    |    3 
 arch/x86/kernel/apic/apic.c                                    |    6 
 arch/x86/kernel/cpu/bugs.c                                     |   82 +--
 arch/x86/kernel/cpu/common.c                                   |   48 +-
 drivers/ata/libata-scsi.c                                      |    9 
 drivers/gpu/drm/amd/amdgpu/soc21.c                             |   27 +
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c          |    1 
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c |   19 
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c           |   12 
 drivers/gpu/drm/ast/ast_dp.c                                   |    3 
 drivers/gpu/drm/drm_client_modeset.c                           |    3 
 drivers/gpu/drm/i915/display/intel_cdclk.c                     |    7 
 drivers/gpu/drm/i915/display/intel_cdclk.h                     |    3 
 drivers/gpu/drm/i915/display/intel_ddi.c                       |    5 
 drivers/gpu/drm/i915/display/intel_vrr.c                       |    7 
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c            |    7 
 drivers/gpu/drm/qxl/qxl_release.c                              |   50 +-
 drivers/iommu/intel/svm.c                                      |    2 
 drivers/media/cec/core/cec-adap.c                              |   14 
 drivers/net/dsa/mt7530.c                                       |  229 ++++++++--
 drivers/net/dsa/mt7530.h                                       |    5 
 drivers/net/ethernet/amazon/ena/ena_com.c                      |    2 
 drivers/net/ethernet/amazon/ena/ena_netdev.c                   |   35 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c                      |    2 
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c            |   20 
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c               |   33 -
 drivers/net/ethernet/mellanox/mlx5/core/en/selq.c              |    2 
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c              |    2 
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c              |    3 
 drivers/net/ethernet/micrel/ks8851.h                           |    3 
 drivers/net/ethernet/micrel/ks8851_common.c                    |   16 
 drivers/net/ethernet/micrel/ks8851_par.c                       |   11 
 drivers/net/ethernet/micrel/ks8851_spi.c                       |   11 
 drivers/net/ethernet/microchip/sparx5/sparx5_port.c            |    4 
 drivers/net/geneve.c                                           |    4 
 drivers/scsi/hisi_sas/hisi_sas_main.c                          |    2 
 drivers/scsi/qla2xxx/qla_edif.c                                |    2 
 drivers/vhost/vhost.c                                          |   24 -
 fs/btrfs/delayed-inode.c                                       |    3 
 fs/btrfs/qgroup.c                                              |    2 
 fs/btrfs/transaction.c                                         |   17 
 fs/smb/client/cached_dir.c                                     |    4 
 include/linux/dma-fence.h                                      |    7 
 include/linux/irqflags.h                                       |    2 
 include/linux/u64_stats_sync.h                                 |    9 
 include/net/addrconf.h                                         |    4 
 include/net/af_unix.h                                          |    2 
 include/net/bluetooth/bluetooth.h                              |    9 
 include/net/ip_tunnels.h                                       |   33 +
 io_uring/net.c                                                 |    1 
 kernel/cpu.c                                                   |    3 
 kernel/kprobes.c                                               |   18 
 kernel/power/suspend.c                                         |    6 
 kernel/trace/ring_buffer.c                                     |    6 
 kernel/trace/trace_events.c                                    |    4 
 net/batman-adv/translation-table.c                             |    2 
 net/bluetooth/hci_request.c                                    |    4 
 net/bluetooth/l2cap_sock.c                                     |   52 --
 net/bluetooth/sco.c                                            |   23 -
 net/ipv4/netfilter/arp_tables.c                                |    4 
 net/ipv4/netfilter/ip_tables.c                                 |    4 
 net/ipv4/route.c                                               |    4 
 net/ipv6/addrconf.c                                            |    7 
 net/ipv6/ip6_fib.c                                             |    7 
 net/ipv6/netfilter/ip6_tables.c                                |    4 
 net/openvswitch/conntrack.c                                    |    5 
 net/unix/af_unix.c                                             |    8 
 net/unix/garbage.c                                             |   35 +
 net/unix/scm.c                                                 |    8 
 net/xdp/xsk.c                                                  |    2 
 tools/testing/selftests/timers/posix_timers.c                  |    2 
 77 files changed, 711 insertions(+), 378 deletions(-)

Adam Dunlap (1):
      x86/apic: Force native_apic_mem_read() to use the MOV instruction

Alex Constantino (1):
      Revert "drm/qxl: simplify qxl_fence_wait"

Alex Deucher (1):
      drm/amdgpu: always force full reset for SOC21

Anna-Maria Behnsen (1):
      PM: s2idle: Make sure CPUs will wakeup directly on resume

Arnd Bergmann (5):
      nouveau: fix function cast warning
      ipv6: fib: hide unused 'pn' variable
      ipv4/route: avoid unused-but-set-variable warning
      tracing: hide unused ftrace_event_id_fops
      irqflags: Explicitly ignore lockdep_hrtimer_exit() argument

Arınç ÜNAL (1):
      net: dsa: mt7530: trap link-local frames regardless of ST Port State

Boris Burkov (3):
      btrfs: qgroup: correctly model root qgroup rsv in convert
      btrfs: record delayed inode root in transaction
      btrfs: qgroup: convert PREALLOC to PERTRANS after record_root_in_trans

Carolina Jubran (2):
      net/mlx5e: Fix mlx5e_priv_init() cleanup flow
      net/mlx5e: HTB, Fix inconsistencies with QoS SQs number

Cosmin Ratiu (1):
      net/mlx5: Properly link new fs rules into the tree

Damien Le Moal (1):
      ata: libata-scsi: Fix ata_scsi_dev_rescan() error path

Dan Carpenter (1):
      scsi: qla2xxx: Fix off by one in qla_edif_app_getstats()

Daniel Machon (1):
      net: sparx5: fix wrong config being used when reconfiguring PCS

Daniel Sneddon (1):
      x86/bugs: Fix return type of spectre_bhi_state()

David Arinzon (3):
      net: ena: Fix potential sign extension issue
      net: ena: Wrong missing IO completions check order
      net: ena: Fix incorrect descriptor free behavior

Dmitry Antipov (1):
      Bluetooth: Fix memory leak in hci_req_sync_complete()

Eric Dumazet (3):
      xsk: validate user input for XDP_{UMEM|COMPLETION}_FILL_RING
      geneve: fix header validation in geneve[6]_xmit_skb
      netfilter: complete validation of user input

Frank Li (1):
      arm64: dts: imx8-ss-conn: fix usdhc wrong lpcg clock order

Fudongwang (1):
      drm/amd/display: fix disable otg wa logic in DCN316

Gavin Shan (2):
      vhost: Add smp_rmb() in vhost_vq_avail_empty()
      vhost: Add smp_rmb() in vhost_enable_notify()

Geetha sowjanya (1):
      octeontx2-af: Fix NIX SQ mode and BP config

Greg Kroah-Hartman (1):
      Linux 6.1.87

Harish Kasiviswanathan (1):
      drm/amdkfd: Reset GPU on queue preemption failure

Ilya Maximets (1):
      net: openvswitch: fix unwanted error log on timeout policy probing

Ingo Molnar (1):
      x86/bugs: Rename various 'ia32_cap' variables to 'x86_arch_cap_msr'

Jacob Pan (1):
      iommu/vt-d: Allocate local memory for page request queue

Jammy Huang (1):
      drm/ast: Fix soft lockup

Jiri Benc (1):
      ipv6: fix race condition between ipv6_get_ifaddr and ipv6_del_addr

John Stultz (1):
      selftests: timers: Fix abs() warning in posix_timers test

Josh Poimboeuf (6):
      x86/bugs: Fix BHI documentation
      x86/bugs: Cache the value of MSR_IA32_ARCH_CAPABILITIES
      x86/bugs: Fix BHI handling of RRSBA
      x86/bugs: Clarify that syscall hardening isn't a BHI mitigation
      x86/bugs: Remove CONFIG_BHI_MITIGATION_AUTO and spectre_bhi=auto
      x86/bugs: Replace CONFIG_SPECTRE_BHI_{ON,OFF} with CONFIG_MITIGATION_SPECTRE_BHI

Kuniyuki Iwashima (2):
      af_unix: Clear stale u->oob_skb.
      af_unix: Do not use atomic ops for unix_sk(sk)->inflight.

Lijo Lazar (1):
      drm/amdgpu: Reset dGPU if suspend got aborted

Luiz Augusto von Dentz (2):
      Bluetooth: SCO: Fix not validating setsockopt user input
      Bluetooth: L2CAP: Fix not validating setsockopt user input

Marek Vasut (2):
      net: ks8851: Inline ks8851_rx_skb()
      net: ks8851: Handle softirqs at the end of IRQ thread to fix hang

Michal Luczaj (1):
      af_unix: Fix garbage collector racing against connect()

Namhyung Kim (1):
      perf/x86: Fix out of range data

Nini Song (1):
      media: cec: core: remove length check of Timer Status

Pavan Chebbi (1):
      bnxt_en: Reset PTP tx_avail after possible firmware reset

Pavel Begunkov (1):
      io_uring/net: restore msg_control on sendzc retry

Petr Tesarik (1):
      u64_stats: fix u64_stats_init() for lockdep when used repeatedly in one file

Sean Christopherson (1):
      x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n

Steve French (1):
      smb3: fix Open files on server counter going negative

Steven Rostedt (Google) (1):
      ring-buffer: Only update pages_touched when a new page is touched

Sven Eckelmann (1):
      batman-adv: Avoid infinite loop trying to resize local TT

Tim Huang (1):
      drm/amd/pm: fixes a random hang in S4 for SMU v13.0.4/11

Ville Syrjälä (4):
      drm/i915/vrr: Disable VRR when using bigjoiner
      drm/client: Fully protect modes[] with dev->mode_config.mutex
      drm/i915/cdclk: Fix CDCLK programming order when pipes are active
      drm/i915: Disable port sync when bigjoiner is used

Xiang Chen (1):
      scsi: hisi_sas: Modify the deadline for ata_wait_after_reset()

Zheng Yejian (1):
      kprobes: Fix possible use-after-free issue on kprobe registration


