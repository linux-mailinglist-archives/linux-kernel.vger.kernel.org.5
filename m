Return-Path: <linux-kernel+bounces-148237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02F08A7FBD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A611C21879
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C771F136E32;
	Wed, 17 Apr 2024 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R5vkIIj0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D4F1350FA;
	Wed, 17 Apr 2024 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713346451; cv=none; b=cInRhOUOPi9214i3qFHC5XltOFx4XoVkHlm4kBnt7WkEsVCX6A3VPhndnQw9rlQQpkHEiB7+mDvid0XpJQxx5umUYpL+vS8MRbCzfT406IPuUqa+Cw2qagyVmQzxxgk8A+ocIRLbm2Y7bMOpdAIzvIPPhQSHZS6PtnePTHMwIC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713346451; c=relaxed/simple;
	bh=lDW1Fc7UsiOFhJPcGTUz8zW/XqGHmyngqp2ASaZ9OS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T3GBskts1EMdTbSEeDiRDIkv7eM2kTLFvC42orX7TUwIPug2Beqexnmg0Mzn3+m2E4/WFRoXgP6yeglXaDY/AkuJdDxpRU4TcO8uGdluq1O+mnumrtu5Rr5Ud7Ij9UAZkBn58dsWNC6S/gckR0OqKhWTqTuAVYp5T8gWNYO8AeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R5vkIIj0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E453C072AA;
	Wed, 17 Apr 2024 09:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713346449;
	bh=lDW1Fc7UsiOFhJPcGTUz8zW/XqGHmyngqp2ASaZ9OS8=;
	h=From:To:Cc:Subject:Date:From;
	b=R5vkIIj0KPuARPyLJU0c8TYa36Ebe7YJthpSXtN0s3xDob+qVwNAw+VtIjmuaLsYd
	 40WetM/ifUh8s95bZXBvouMEjUXPyUuBM5IZRZxUNZaN2Yjm9NHfHFsb/eIzxL0+te
	 TH2Osp0GRG2CHG8hf9mb4eCV0ZW0MkkB8xSFtEoA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.156
Date: Wed, 17 Apr 2024 11:34:01 +0200
Message-ID: <2024041700-skirmish-pajamas-e9a7@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.156 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/admin-guide/hw-vuln/spectre.rst       |   22 -
 Documentation/admin-guide/kernel-parameters.txt     |   12 -
 Makefile                                            |    2 
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi     |   12 -
 arch/x86/Kconfig                                    |   21 -
 arch/x86/events/core.c                              |    1 
 arch/x86/include/asm/apic.h                         |    3 
 arch/x86/kernel/cpu/bugs.c                          |   82 +++----
 arch/x86/kernel/cpu/common.c                        |   48 ++--
 drivers/gpu/drm/drm_client_modeset.c                |    3 
 drivers/gpu/drm/i915/display/intel_cdclk.c          |    7 
 drivers/gpu/drm/i915/display/intel_cdclk.h          |    3 
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/shadowof.c |    7 
 drivers/gpu/drm/qxl/qxl_release.c                   |   50 +++-
 drivers/iommu/intel/svm.c                           |    2 
 drivers/media/cec/core/cec-adap.c                   |   14 -
 drivers/net/dsa/mt7530.c                            |  229 +++++++++++++++++---
 drivers/net/dsa/mt7530.h                            |    5 
 drivers/net/ethernet/amazon/ena/ena_com.c           |    2 
 drivers/net/ethernet/amazon/ena/ena_netdev.c        |   35 ++-
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c |   20 -
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c   |    3 
 drivers/net/ethernet/microchip/sparx5/sparx5_port.c |    4 
 drivers/net/geneve.c                                |    4 
 drivers/scsi/qla2xxx/qla_edif.c                     |    2 
 drivers/vhost/vhost.c                               |   12 -
 fs/btrfs/qgroup.c                                   |    2 
 include/linux/dma-fence.h                           |    7 
 include/linux/irqflags.h                            |    2 
 include/linux/u64_stats_sync.h                      |   42 ++-
 include/net/addrconf.h                              |    4 
 include/net/af_unix.h                               |    2 
 include/net/ip_tunnels.h                            |   33 ++
 kernel/cpu.c                                        |    3 
 kernel/trace/ring_buffer.c                          |    6 
 kernel/trace/trace_events.c                         |    4 
 net/batman-adv/translation-table.c                  |    2 
 net/bluetooth/hci_request.c                         |    4 
 net/ipv4/netfilter/arp_tables.c                     |    4 
 net/ipv4/netfilter/ip_tables.c                      |    4 
 net/ipv4/route.c                                    |    4 
 net/ipv6/addrconf.c                                 |    7 
 net/ipv6/ip6_fib.c                                  |    7 
 net/ipv6/netfilter/ip6_tables.c                     |    4 
 net/openvswitch/conntrack.c                         |    5 
 net/unix/af_unix.c                                  |    8 
 net/unix/garbage.c                                  |   35 ++-
 net/unix/scm.c                                      |    8 
 net/xdp/xsk.c                                       |    2 
 tools/testing/selftests/timers/posix_timers.c       |    2 
 50 files changed, 553 insertions(+), 253 deletions(-)

Adam Dunlap (1):
      x86/apic: Force native_apic_mem_read() to use the MOV instruction

Alex Constantino (1):
      Revert "drm/qxl: simplify qxl_fence_wait"

Arnd Bergmann (5):
      nouveau: fix function cast warning
      ipv6: fib: hide unused 'pn' variable
      ipv4/route: avoid unused-but-set-variable warning
      tracing: hide unused ftrace_event_id_fops
      irqflags: Explicitly ignore lockdep_hrtimer_exit() argument

Arınç ÜNAL (1):
      net: dsa: mt7530: trap link-local frames regardless of ST Port State

Boris Burkov (1):
      btrfs: qgroup: correctly model root qgroup rsv in convert

Cosmin Ratiu (1):
      net/mlx5: Properly link new fs rules into the tree

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

Gavin Shan (1):
      vhost: Add smp_rmb() in vhost_vq_avail_empty()

Geetha sowjanya (1):
      octeontx2-af: Fix NIX SQ mode and BP config

Greg Kroah-Hartman (1):
      Linux 5.15.156

Ilya Maximets (1):
      net: openvswitch: fix unwanted error log on timeout policy probing

Ingo Molnar (1):
      x86/bugs: Rename various 'ia32_cap' variables to 'x86_arch_cap_msr'

Jacob Pan (1):
      iommu/vt-d: Allocate local memory for page request queue

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

Michal Luczaj (1):
      af_unix: Fix garbage collector racing against connect()

Namhyung Kim (1):
      perf/x86: Fix out of range data

Nini Song (1):
      media: cec: core: remove length check of Timer Status

Sean Christopherson (1):
      x86/cpu: Actually turn off mitigations by default for SPECULATION_MITIGATIONS=n

Sebastian Andrzej Siewior (1):
      u64_stats: Disable preemption on 32bit UP+SMP PREEMPT_RT during updates.

Steven Rostedt (Google) (1):
      ring-buffer: Only update pages_touched when a new page is touched

Sven Eckelmann (1):
      batman-adv: Avoid infinite loop trying to resize local TT

Ville Syrjälä (2):
      drm/client: Fully protect modes[] with dev->mode_config.mutex
      drm/i915/cdclk: Fix CDCLK programming order when pipes are active


