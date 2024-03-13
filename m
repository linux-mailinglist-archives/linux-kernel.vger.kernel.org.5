Return-Path: <linux-kernel+bounces-101868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9608B87AC4B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B94901C21ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECE860DC2;
	Wed, 13 Mar 2024 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umSmsh3+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19D660BB5;
	Wed, 13 Mar 2024 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348001; cv=none; b=LL3mn7LAkBOOjQy11IQdFpiJ4c/Jml4JAL78O31e+6qDh/HB+pTfe0U9IcwUo5NfQVf/BD+waTSFvW5r7ZIBq5XsZf3HLMxAnNKAiG/z82DDamDmMq6n6u5nCOw4CDY4KXUODOUHfUehqmqHAC2mjswn0W/G0hWYidpEuEkbgs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348001; c=relaxed/simple;
	bh=94pM2mNQGCFIIfP+47hVQrtTAQs7EU8wfb5PtmR0k1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OGPg/mlyiWJWt4v+hU/4aShBms+Yq0XyZCvwu3TGm2EpjzMJ7mj1fwnjquuoo+iOBM95lKIMJsWdQt6FjNjX3OlffS0Mq3q/mP/kcX9b3WUew+HZbZb+SE57+mdIi2M4kCfcyk5BGHz6zv47K6j+42w6wfWtzknOoOCdQCZSPFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umSmsh3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27132C43390;
	Wed, 13 Mar 2024 16:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348000;
	bh=94pM2mNQGCFIIfP+47hVQrtTAQs7EU8wfb5PtmR0k1Y=;
	h=From:To:Cc:Subject:Date:From;
	b=umSmsh3+j2R54xnDWjfbBnCA/K0uVeHW0cYrbLTbA2kCsKYvJvTYKLquovSh/jm+U
	 0FHwx8PbagJ1u/HSmjAtg4RDBXD5ZGDECfZsfFvFXIcr+92cEEne9NsLLjBCIqBa/g
	 pjK5rnBWMaXoNQq794FA2LYCejaMn+ulcyAPHaAEAo0zVvQlcddWHEK3GOOvz5117H
	 8UszAYnS8wYd4IDQytYVkhZTl030NhHe/wUNNVxlZ7CmiTuWhEmAf7sQWToU+keorD
	 w6Ian+purDrTu13xshkchnUXQMCqFzsDkYetMcI3XOGVWIPMFwwSdbJZR9038A4tzx
	 xqLW9jrwfHIUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de
Subject: [PATCH 6.1 00/71] 6.1.82-rc1 review
Date: Wed, 13 Mar 2024 12:38:46 -0400
Message-ID: <20240313163957.615276-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit


This is the start of the stable review cycle for the 6.1.82 release.
There are 71 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Mar 15 04:39:56 PM UTC 2024.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.1.y&id2=v6.1.81
or in the git tree and branch at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
and the diffstat can be found below.

Thanks,
Sasha

-------------
Pseudo-Shortlog of commits:

Breno Leitao (1):
  blk-iocost: Pass gendisk to ioc_refresh_params

Christian Borntraeger (1):
  KVM: s390: vsie: fix race during shadow creation

Christoph Hellwig (6):
  blk-wbt: pass a gendisk to wbt_{enable,disable}_default
  blk-wbt: pass a gendisk to wbt_init
  blk-rq-qos: move rq_qos_add and rq_qos_del out of line
  blk-rq-qos: make rq_qos_add and rq_qos_del more useful
  blk-rq-qos: constify rq_qos_ops
  blk-rq-qos: store a gendisk instead of request_queue in struct rq_qos

Edward Adam Davis (1):
  net/rds: fix WARNING in rds_conn_connect_if_down

Eric Dumazet (2):
  geneve: make sure to pull inner header in geneve_rx()
  net/ipv6: avoid possible UAF in ip6_route_mpath_notify()

Fangzhi Zuo (1):
  drm/amd/display: Fix MST Null Ptr for RV

Florian Kauer (1):
  igc: avoid returning frame twice in XDP_REDIRECT

Florian Westphal (1):
  netfilter: nft_ct: fix l3num expectations with inet pseudo family

Friedrich Vock (1):
  drm/amdgpu: Reset IH OVERFLOW_CLEAR bit

Gao Xiang (1):
  erofs: apply proper VMA alignment for memory mapped files on THP

Horatiu Vultur (1):
  net: sparx5: Fix use after free inside sparx5_del_mact_entry

Hui Zhou (1):
  nfp: flower: add hardware offload check for post ct entry

Jacob Keller (1):
  ice: virtchnl: stop pretending to support RSS over AQ or registers

Jan Kara (2):
  readahead: avoid multiple marked readahead pages
  blk-wbt: Fix detection of dirty-throttled tasks

Jason Xing (12):
  netrom: Fix a data-race around sysctl_netrom_default_path_quality
  netrom: Fix a data-race around
    sysctl_netrom_obsolescence_count_initialiser
  netrom: Fix data-races around sysctl_netrom_network_ttl_initialiser
  netrom: Fix a data-race around sysctl_netrom_transport_timeout
  netrom: Fix a data-race around sysctl_netrom_transport_maximum_tries
  netrom: Fix a data-race around
    sysctl_netrom_transport_acknowledge_delay
  netrom: Fix a data-race around sysctl_netrom_transport_busy_delay
  netrom: Fix a data-race around
    sysctl_netrom_transport_requested_window_size
  netrom: Fix a data-race around
    sysctl_netrom_transport_no_activity_timeout
  netrom: Fix a data-race around sysctl_netrom_routing_control
  netrom: Fix a data-race around sysctl_netrom_link_fails_count
  netrom: Fix data-races around sysctl_net_busy_read

Johan Hovold (1):
  ASoC: codecs: wcd938x: fix headphones volume controls

Lena Wang (1):
  netfilter: nf_conntrack_h323: Add protection for bmp length out of
    range

Ma Hanghong (1):
  drm/amd/display: Wrong colorimetry workaround

Maciej Fijalkowski (3):
  ixgbe: {dis, en}able irqs in ixgbe_txrx_ring_{dis, en}able
  i40e: disable NAPI right after disabling irqs when handling xsk_pool
  ice: reorder disabling IRQ and NAPI in ice_qp_dis

Mathias Nyman (1):
  xhci: process isoc TD properly when there was a transaction error mid
    TD.

Matthieu Baerts (NGI0) (1):
  selftests: mptcp: decrease BW in simult flows

Michal Pecio (1):
  xhci: handle isoc Babble and Buffer Overrun events properly

Muhammad Usama Anjum (1):
  selftests/mm: switch to bash from sh

Nico Boehr (1):
  KVM: s390: add stat counter for shadow gmap events

Nico Pache (1):
  selftests: mm: fix map_hugetlb failure on 64K page size systems

Oleg Nesterov (7):
  getrusage: add the "signal_struct *sig" local variable
  getrusage: move thread_group_cputime_adjusted() outside of
    lock_task_sighand()
  getrusage: use __for_each_thread()
  getrusage: use sig->stats_lock rather than lock_task_sighand()
  fs/proc: do_task_stat: use __for_each_thread()
  fs/proc: do_task_stat: use sig->stats_lock to gather the
    threads/children stats
  exit: wait_task_zombie: kill the no longer necessary
    spin_lock_irq(siglock)

Oleksij Rempel (1):
  net: lan78xx: fix runtime PM count underflow on link stop

Pawan Gupta (4):
  x86/mmio: Disable KVM mitigation when X86_FEATURE_CLEAR_CPU_BUF is set
  Documentation/hw-vuln: Add documentation for RFDS
  x86/rfds: Mitigate Register File Data Sampling (RFDS)
  KVM/x86: Export RFDS_NO and RFDS_CLEAR to guests

Rand Deeb (1):
  net: ice: Fix potential NULL pointer dereference in
    ice_bridge_setlink()

Sasha Levin (1):
  Linux 6.1.82-rc1

Srinivasan Shanmugam (1):
  drm/amd/display: Fix uninitialized variable usage in core_link_
    'read_dpcd() & write_dpcd()' functions

Steven Rostedt (Google) (1):
  tracing/net_sched: Fix tracepoints that save qdisc_dev() as a string

Tobias Jakobi (Compleo) (1):
  net: dsa: microchip: fix register write order in ksz8_ind_write8()

Toke Høiland-Jørgensen (1):
  cpumap: Zero-initialise xdp_rxq_info struct before running XDP program

Wentao Jia (1):
  nfp: flower: add goto_chain_index for ct entry

Xiubo Li (1):
  ceph: switch to corrected encoding of max_xattr_size in mdsmap

Yu Kuai (6):
  blk-iocost: disable writeback throttling
  elevator: remove redundant code in elv_unregister_queue()
  blk-wbt: remove unnecessary check in wbt_enable_default()
  elevator: add new field flags in struct elevator_queue
  blk-wbt: don't enable throttling if default elevator is bfq
  blk-wbt: fix that wbt can't be disabled by default

 .../ABI/testing/sysfs-devices-system-cpu      |   1 +
 Documentation/admin-guide/hw-vuln/index.rst   |   1 +
 .../hw-vuln/reg-file-data-sampling.rst        | 104 ++++++++++++++++++
 .../admin-guide/kernel-parameters.txt         |  21 ++++
 Makefile                                      |   4 +-
 arch/s390/include/asm/kvm_host.h              |   7 ++
 arch/s390/kvm/gaccess.c                       |   7 ++
 arch/s390/kvm/kvm-s390.c                      |   9 +-
 arch/s390/kvm/vsie.c                          |   6 +-
 arch/s390/mm/gmap.c                           |   1 +
 arch/x86/Kconfig                              |  11 ++
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/msr-index.h              |   8 ++
 arch/x86/kernel/cpu/bugs.c                    |  92 +++++++++++++++-
 arch/x86/kernel/cpu/common.c                  |  38 ++++++-
 arch/x86/kvm/x86.c                            |   5 +-
 block/bfq-iosched.c                           |   6 +-
 block/blk-iocost.c                            |  51 +++++----
 block/blk-iolatency.c                         |  30 ++---
 block/blk-mq-debugfs.c                        |  10 +-
 block/blk-rq-qos.c                            |  67 +++++++++++
 block/blk-rq-qos.h                            |  66 +----------
 block/blk-sysfs.c                             |   4 +-
 block/blk-wbt.c                               |  50 +++++----
 block/blk-wbt.h                               |  12 +-
 block/elevator.c                              |   8 +-
 block/elevator.h                              |   5 +-
 drivers/base/cpu.c                            |   8 ++
 drivers/gpu/drm/amd/amdgpu/cik_ih.c           |   6 +
 drivers/gpu/drm/amd/amdgpu/cz_ih.c            |   5 +
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c       |   5 +
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          |   6 +
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |   6 +
 drivers/gpu/drm/amd/amdgpu/si_ih.c            |   6 +
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c         |   6 +
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c        |   6 +
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c        |   6 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  17 ++-
 .../drm/amd/display/dc/core/dc_link_dpcd.c    |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   6 +
 .../amd/display/modules/inc/mod_info_packet.h |   3 +-
 .../display/modules/info_packet/info_packet.c |   6 +-
 drivers/net/dsa/microchip/ksz8795.c           |   4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   2 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |   9 +-
 .../intel/ice/ice_virtchnl_allowlist.c        |   2 -
 drivers/net/ethernet/intel/ice/ice_xsk.c      |   9 +-
 drivers/net/ethernet/intel/igc/igc_main.c     |  13 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  56 ++++++++--
 .../microchip/sparx5/sparx5_mactable.c        |   4 +-
 .../ethernet/netronome/nfp/flower/conntrack.c |  28 ++++-
 .../ethernet/netronome/nfp/flower/conntrack.h |   2 +
 drivers/net/geneve.c                          |  18 ++-
 drivers/net/usb/lan78xx.c                     |   3 +-
 drivers/usb/host/xhci-ring.c                  |  80 +++++++++++---
 drivers/usb/host/xhci.h                       |   1 +
 fs/ceph/mdsmap.c                              |   7 +-
 fs/erofs/data.c                               |   1 +
 fs/proc/array.c                               |  57 +++++-----
 include/linux/backing-dev-defs.h              |   7 +-
 include/linux/ceph/mdsmap.h                   |   6 +-
 include/linux/cpu.h                           |   2 +
 include/trace/events/qdisc.h                  |  20 ++--
 kernel/bpf/cpumap.c                           |   2 +-
 kernel/exit.c                                 |  10 +-
 kernel/sys.c                                  |  91 ++++++++-------
 mm/backing-dev.c                              |   2 +-
 mm/page-writeback.c                           |   2 +-
 mm/readahead.c                                |   4 +-
 net/ipv6/route.c                              |  21 ++--
 net/netfilter/nf_conntrack_h323_asn1.c        |   4 +
 net/netfilter/nft_ct.c                        |  11 +-
 net/netrom/af_netrom.c                        |  14 +--
 net/netrom/nr_dev.c                           |   2 +-
 net/netrom/nr_in.c                            |   6 +-
 net/netrom/nr_out.c                           |   2 +-
 net/netrom/nr_route.c                         |   8 +-
 net/netrom/nr_subr.c                          |   5 +-
 net/rds/rdma.c                                |   3 +
 net/rds/send.c                                |   6 +-
 sound/soc/codecs/wcd938x.c                    |   2 +-
 .../selftests/net/mptcp/simult_flows.sh       |   8 +-
 .../selftests/vm/charge_reserved_hugetlb.sh   |   2 +-
 tools/testing/selftests/vm/map_hugetlb.c      |   7 ++
 .../selftests/vm/write_hugetlb_memory.sh      |   2 +-
 86 files changed, 903 insertions(+), 365 deletions(-)
 create mode 100644 Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst

-- 
2.43.0


