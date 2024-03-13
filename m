Return-Path: <linux-kernel+bounces-101802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E3D87ABBC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214AD1F21490
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D3D56B64;
	Wed, 13 Mar 2024 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnTvQPqW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832FB4D117;
	Wed, 13 Mar 2024 16:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347830; cv=none; b=DM+zu2NQGzYMpj5W7ZgvlCqAenrAwFkHMTbVthjhdKMLKSuKGNKIrHcJVVjQV6vIB/N/gY3HtUrjzCZjZusryNeo2Bequ3Y/dFnmtnoUKb+bUBmR0jsZc9cNqgtgIDJXFLQA7GIKGmoGPN8oEhYbtih0spRXn25eqHyMTvVijfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347830; c=relaxed/simple;
	bh=vxCvN74slx6qwPEWIaCK0orZLRirU7DXrn9mgZhZbKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YIjDUZw1Gd3TV9cVoGk8MYLrgHm/XeG0WfHE6SjRvwuDHe8w6SH8tBuB/FPQ1HVSiYCLPFpTUTo9SR9EK2SdPIb0bF57oUp4xNVoxVVPuIbYZMlp3dGEw6krmvo3QDl1murWIG3OyVDcuuGmlpEUhM/EW94KpmlSKKc6fyfQmwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnTvQPqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA624C433C7;
	Wed, 13 Mar 2024 16:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347830;
	bh=vxCvN74slx6qwPEWIaCK0orZLRirU7DXrn9mgZhZbKg=;
	h=From:To:Cc:Subject:Date:From;
	b=WnTvQPqW5tbwGJPXxlo/VuB9PTzb8coj5KOXrSjwuGHD1Zctdk66ibbYAjVHYUzJa
	 WR3qw1Hl0VpEE3Rwq5O8qaUX7wavn1vzfTXOuny2OCdnrr1LIOK+6NMPasCaDT52iT
	 /N7n7sxRAQF949zUFReJXupt7v7lqiQbVzsgQJAp262prZsJ9Xzsj4QzhnOzCeSkQT
	 hwEGl9okHtRrLTYueWrddlJHhCLTLosWGrvPQjHW++qW3T/OUw5z+lMcIgISOYYMK+
	 L6xKBqIf1Cz4rPjYEQctu/HiRgGKPvkodo9rvYnQjJH1FboXsLmez3TvLVU+k1d7tS
	 tbq5QUGzizi7A==
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
Subject: [PATCH 6.6 00/60] 6.6.22-rc1 review
Date: Wed, 13 Mar 2024 12:36:07 -0400
Message-ID: <20240313163707.615000-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit


This is the start of the stable review cycle for the 6.6.22 release.
There are 60 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Mar 15 04:36:58 PM UTC 2024.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.6.y&id2=v6.6.21
or in the git tree and branch at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
and the diffstat can be found below.

Thanks,
Sasha

-------------
Pseudo-Shortlog of commits:

Byungchul Park (1):
  mm/vmscan: fix a bug calling wakeup_kswapd() with a wrong zone index

Christian Borntraeger (1):
  KVM: s390: vsie: fix race during shadow creation

Daniel Borkmann (2):
  xdp, bonding: Fix feature flags when there are no slave devs anymore
  selftests/bpf: Fix up xdp bonding test wrt feature flags

Eduard Zingerman (1):
  bpf: check bpf_func_state->callback_depth when pruning states

Edward Adam Davis (1):
  net/rds: fix WARNING in rds_conn_connect_if_down

Emeel Hakim (1):
  net/mlx5e: Fix MACsec state loss upon state update in offload path

Eric Dumazet (2):
  geneve: make sure to pull inner header in geneve_rx()
  net/ipv6: avoid possible UAF in ip6_route_mpath_notify()

Florian Kauer (1):
  igc: avoid returning frame twice in XDP_REDIRECT

Florian Westphal (1):
  netfilter: nft_ct: fix l3num expectations with inet pseudo family

Frank Li (3):
  dt-bindings: dma: fsl-edma: Add fsl-edma.h to prevent hardcoding in
    dts
  dmaengine: fsl-edma: utilize common dt-binding header file
  dmaengine: fsl-edma: correct max_segment_size setting

Gao Xiang (1):
  erofs: apply proper VMA alignment for memory mapped files on THP

Gavin Li (1):
  Revert "net/mlx5: Block entering switchdev mode with ns inconsistency"

Horatiu Vultur (1):
  net: sparx5: Fix use after free inside sparx5_del_mact_entry

Jacob Keller (1):
  ice: virtchnl: stop pretending to support RSS over AQ or registers

Jan Kara (1):
  readahead: avoid multiple marked readahead pages

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

Jianbo Liu (2):
  net/mlx5: E-switch, Change flow rule destination checking
  net/mlx5e: Change the warning when ignore_flow_level is not supported

Kefeng Wang (3):
  mm: migrate: remove PageTransHuge check in numamigrate_isolate_page()
  mm: migrate: remove THP mapcount check in numamigrate_isolate_page()
  mm: migrate: convert numamigrate_isolate_page() to
    numamigrate_isolate_folio()

Lena Wang (1):
  netfilter: nf_conntrack_h323: Add protection for bmp length out of
    range

Leon Romanovsky (1):
  xfrm: Pass UDP encapsulation in TX packet offload

Maciej Fijalkowski (3):
  ixgbe: {dis, en}able irqs in ixgbe_txrx_ring_{dis, en}able
  i40e: disable NAPI right after disabling irqs when handling xsk_pool
  ice: reorder disabling IRQ and NAPI in ice_qp_dis

Matthieu Baerts (NGI0) (1):
  selftests: mptcp: decrease BW in simult flows

Moshe Shemesh (1):
  net/mlx5: Check capability for fw_reset

Nico Boehr (1):
  KVM: s390: add stat counter for shadow gmap events

Oleg Nesterov (1):
  exit: wait_task_zombie: kill the no longer necessary
    spin_lock_irq(siglock)

Oleksij Rempel (1):
  net: lan78xx: fix runtime PM count underflow on link stop

Pawan Gupta (4):
  x86/mmio: Disable KVM mitigation when X86_FEATURE_CLEAR_CPU_BUF is set
  Documentation/hw-vuln: Add documentation for RFDS
  x86/rfds: Mitigate Register File Data Sampling (RFDS)
  KVM/x86: Export RFDS_NO and RFDS_CLEAR to guests

Rahul Rameshbabu (2):
  net/mlx5e: Use a memory barrier to enforce PTP WQ xmit submission
    tracking occurs after populating the metadata_map
  net/mlx5e: Switch to using _bh variant of of spinlock API in port
    timestamping NAPI poll context

Rand Deeb (1):
  net: ice: Fix potential NULL pointer dereference in
    ice_bridge_setlink()

Saeed Mahameed (1):
  Revert "net/mlx5e: Check the number of elements before walk TC
    rhashtable"

Sasha Levin (1):
  Linux 6.6.22-rc1

Steven Rostedt (Google) (1):
  tracing/net_sched: Fix tracepoints that save qdisc_dev() as a string

Tobias Jakobi (Compleo) (1):
  net: dsa: microchip: fix register write order in ksz8_ind_write8()

Toke Høiland-Jørgensen (1):
  cpumap: Zero-initialise xdp_rxq_info struct before running XDP program

Xiubo Li (1):
  ceph: switch to corrected encoding of max_xattr_size in mdsmap

Yongzhi Liu (1):
  net: pds_core: Fix possible double free in error handling path

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
 drivers/base/cpu.c                            |   3 +
 drivers/dma/fsl-edma-common.h                 |   5 +-
 drivers/dma/fsl-edma-main.c                   |  21 ++--
 drivers/net/bonding/bond_main.c               |   2 +-
 drivers/net/dsa/microchip/ksz8795.c           |   4 +-
 drivers/net/ethernet/amd/pds_core/auxbus.c    |  12 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   2 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |   9 +-
 .../intel/ice/ice_virtchnl_allowlist.c        |   2 -
 drivers/net/ethernet/intel/ice/ice_xsk.c      |   9 +-
 drivers/net/ethernet/intel/igc/igc_main.c     |  13 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  56 ++++++++--
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   6 +
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c  |  12 +-
 .../mellanox/mlx5/core/en/tc/post_act.c       |   2 +-
 .../mellanox/mlx5/core/en_accel/macsec.c      |  82 ++++++++------
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   |   2 +
 .../mellanox/mlx5/core/esw/ipsec_fs.c         |   2 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |  46 +++-----
 .../ethernet/mellanox/mlx5/core/fw_reset.c    |  22 +++-
 .../microchip/sparx5/sparx5_mactable.c        |   4 +-
 drivers/net/geneve.c                          |  18 ++-
 drivers/net/usb/lan78xx.c                     |   3 +-
 fs/ceph/mdsmap.c                              |   7 +-
 fs/erofs/data.c                               |   1 +
 include/dt-bindings/dma/fsl-edma.h            |  21 ++++
 include/linux/ceph/mdsmap.h                   |   6 +-
 include/linux/cpu.h                           |   2 +
 include/linux/mlx5/mlx5_ifc.h                 |   4 +-
 include/trace/events/qdisc.h                  |  20 ++--
 kernel/bpf/cpumap.c                           |   2 +-
 kernel/bpf/verifier.c                         |   3 +
 kernel/exit.c                                 |  10 +-
 mm/migrate.c                                  |  34 +++---
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
 net/xfrm/xfrm_device.c                        |   2 +-
 .../selftests/bpf/prog_tests/xdp_bonding.c    |   4 +-
 .../selftests/net/mptcp/simult_flows.sh       |   8 +-
 66 files changed, 628 insertions(+), 237 deletions(-)
 create mode 100644 Documentation/admin-guide/hw-vuln/reg-file-data-sampling.rst
 create mode 100644 include/dt-bindings/dma/fsl-edma.h

-- 
2.43.0


