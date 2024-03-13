Return-Path: <linux-kernel+bounces-102024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 177B187ADB3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27832837BF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C3455C26;
	Wed, 13 Mar 2024 16:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XarEkFik"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90EA495F0;
	Wed, 13 Mar 2024 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348404; cv=none; b=Xqd0BwgnqVjnOjQzX1Cegewusf5RtSPTX0/EQBZExRoX8wevZRtOtLiabxTEf/2xilipdC7sOQQATa7rhwkmtJJdmrizN4cRiyd2rffR/B/2DsUR6Apg8jDhOCIQM7/OfX4FX9vIAs6gE8cShQbbocYvN/lWB3MJMDgH8dYV41w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348404; c=relaxed/simple;
	bh=KMl7ackn4G4x4NouuYQGLzDa8mNJAOZuVgV0+BlotPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eU6u4ZJdWS/xYNt/7rDB3Ou8k5WQq5hkjXM9VxVSsM0x/B+LtoKIoeZosWRB/B0HzBZSuTcQjWJlEomVDATZ3Ing6MahDr0bp0rg2pQlAa95NhrMBwhs0iy6YKwiyjiy7oQ/EW7i2CW8dFYrvMb2HKFakCdDnkvWFe/SI7sSN2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XarEkFik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAECC433C7;
	Wed, 13 Mar 2024 16:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348403;
	bh=KMl7ackn4G4x4NouuYQGLzDa8mNJAOZuVgV0+BlotPo=;
	h=From:To:Cc:Subject:Date:From;
	b=XarEkFikWI1Ken+HAxE9gXoJhk9QXNUrEQWQIA7ni4R0DX79tsHjJsUK5T6M8nN5p
	 A3Cnmi8D/Kg7uVnC+Xt+ubVX1mAbo7KAx0TTk+9yWYpmdf+Cpc61CfMbBbh0kT+XIg
	 JL8QSmhe2678N/AvAdKBQux1Wx6jIe9w0136r3BukicCs44JA1Nj4xDirYWeUcHTCn
	 W7zFJlBct6P1hXKZR/mbltiU1+v9PFqTyVwM1QXBqou5fYg4BR/CfFGeZ1H9ymEaVF
	 zrdjx4cIBrcMywI/YHL6PQdxnhra2njHZwwpiE9CkuZQjJOLTgTia7UstzzWMSmvPr
	 7wpz4bwbAAEyg==
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
Subject: [PATCH 5.10 00/73] 5.10.213-rc1 review
Date: Wed, 13 Mar 2024 12:45:27 -0400
Message-ID: <20240313164640.616049-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit


This is the start of the stable review cycle for the 5.10.213 release.
There are 73 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Mar 15 04:46:39 PM UTC 2024.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.10.y&id2=v5.10.212
or in the git tree and branch at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
and the diffstat can be found below.

Thanks,
Sasha

-------------
Pseudo-Shortlog of commits:

Andrea Parri (Microsoft) (1):
  Drivers: hv: vmbus: Drop error message when 'No request id available'

Andres Beltran (2):
  Drivers: hv: vmbus: Add vmbus_requestor data structure for VMBus
    hardening
  hv_netvsc: Use vmbus_requestor to generate transaction IDs for VMBus
    hardening

Andy Shevchenko (4):
  serial: max310x: Use devm_clk_get_optional() to get the input clock
  serial: max310x: Try to get crystal clock rate from property
  serial: max310x: Make use of device properties
  serial: max310x: Unprepare and disable clock in error path

Ansuel Smith (1):
  regmap: allow to define reg_update_bits for no bus configuration

Baokun Li (1):
  ext4: make ext4_es_insert_extent() return void

Christophe Kerello (1):
  mmc: mmci: stm32: fix DMA API overlapping mappings warning

Cosmin Tanislav (4):
  serial: max310x: use regmap methods for SPI batch operations
  serial: max310x: use a separate regmap for each port
  serial: max310x: make accessing revision id interface-agnostic
  serial: max310x: implement I2C support

Dexuan Cui (1):
  hv_netvsc: Make netvsc/VF binding check both MAC and serial number

Edward Adam Davis (1):
  net/rds: fix WARNING in rds_conn_connect_if_down

Eric Dumazet (2):
  geneve: make sure to pull inner header in geneve_rx()
  net/ipv6: avoid possible UAF in ip6_route_mpath_notify()

Florian Westphal (1):
  netfilter: nft_ct: fix l3num expectations with inet pseudo family

Hugo Villeneuve (2):
  serial: max310x: fail probe if clock crystal is unstable
  serial: max310x: prevent infinite while() loop in port startup

Ingo Molnar (1):
  exit: Fix typo in comment: s/sub-theads/sub-threads

Jan Kundrát (1):
  serial: max310x: fix IO data corruption in batched operations

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

Johannes Berg (1):
  um: allow not setting extra rpaths in the linux binary

John Efstathiades (4):
  lan78xx: Fix white space and style issues
  lan78xx: Add missing return code checks
  lan78xx: Fix partial packet errors on suspend/resume
  lan78xx: Fix race conditions in suspend/resume handling

Juhee Kang (1):
  hv_netvsc: use netif_is_bond_master() instead of open code

Lena Wang (1):
  netfilter: nf_conntrack_h323: Add protection for bmp length out of
    range

Long Li (2):
  hv_netvsc: Wait for completion on request SWITCH_DATA_PATH
  hv_netvsc: Process NETDEV_GOING_DOWN on VF hot remove

Maciej Fijalkowski (2):
  ixgbe: {dis, en}able irqs in ixgbe_txrx_ring_{dis, en}able
  i40e: disable NAPI right after disabling irqs when handling xsk_pool

Marek Vasut (1):
  regmap: Add bulk read/write callbacks into regmap_config

Martin KaFai Lau (2):
  net: Change sock_getsockopt() to take the sk ptr instead of the sock
    ptr
  bpf: net: Change sk_getsockopt() to take the sockptr_t argument

Mathias Nyman (3):
  xhci: remove extra loop in interrupt context
  xhci: prevent double-fetch of transfer and transfer event TRBs
  xhci: process isoc TD properly when there was a transaction error mid
    TD.

Michal Pecio (1):
  xhci: handle isoc Babble and Buffer Overrun events properly

Mike Kravetz (1):
  mm/hugetlb: change hugetlb_reserve_pages() to type bool

Muhammad Usama Anjum (1):
  selftests/mm: switch to bash from sh

Nico Pache (1):
  selftests: mm: fix map_hugetlb failure on 64K page size systems

Oleg Nesterov (5):
  getrusage: add the "signal_struct *sig" local variable
  getrusage: move thread_group_cputime_adjusted() outside of
    lock_task_sighand()
  getrusage: use __for_each_thread()
  getrusage: use sig->stats_lock rather than lock_task_sighand()
  exit: wait_task_zombie: kill the no longer necessary
    spin_lock_irq(siglock)

Oleksij Rempel (1):
  net: lan78xx: fix runtime PM count underflow on link stop

Ondrej Mosnacek (1):
  lsm: fix default return value of the socket_getpeersec_*() hooks

Paul Moore (1):
  lsm: make security_socket_getpeersec_stream() sockptr_t safe

Prakash Sangappa (1):
  mm: hugetlb pages should not be reserved by shmat() if SHM_NORESERVE

Rand Deeb (1):
  net: ice: Fix potential NULL pointer dereference in
    ice_bridge_setlink()

Sasha Levin (1):
  Linux 5.10.213-rc1

Shradha Gupta (1):
  hv_netvsc: Register VF in netvsc_probe if NET_DEVICE_REGISTER missed

Steven Rostedt (Google) (1):
  tracing/net_sched: Fix tracepoints that save qdisc_dev() as a string

Toke Høiland-Jørgensen (1):
  cpumap: Zero-initialise xdp_rxq_info struct before running XDP program

Yann Gautier (1):
  mmc: mmci: stm32: use a buffer for unaligned DMA requests

Zhang Yi (2):
  ext4: refactor ext4_da_map_blocks()
  ext4: convert to exclusive lock while inserting delalloc extents

 Makefile                                      |   4 +-
 arch/um/Kconfig                               |  13 +
 arch/um/Makefile                              |   3 +-
 arch/x86/Makefile.um                          |   2 +-
 drivers/base/regmap/internal.h                |   4 +
 drivers/base/regmap/regmap.c                  |  77 +-
 drivers/hv/channel.c                          | 174 +++-
 drivers/hv/hyperv_vmbus.h                     |   3 +-
 drivers/hv/ring_buffer.c                      |  28 +-
 drivers/mmc/host/mmci_stm32_sdmmc.c           | 112 ++-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  56 +-
 drivers/net/geneve.c                          |  18 +-
 drivers/net/hyperv/hyperv_net.h               |  13 +
 drivers/net/hyperv/netvsc.c                   |  55 +-
 drivers/net/hyperv/netvsc_drv.c               | 107 +-
 drivers/net/hyperv/rndis_filter.c             |   1 +
 drivers/net/usb/lan78xx.c                     | 910 ++++++++++++++----
 drivers/tty/serial/Kconfig                    |   1 +
 drivers/tty/serial/max310x.c                  | 378 ++++++--
 drivers/usb/host/xhci-ring.c                  | 143 ++-
 drivers/usb/host/xhci.h                       |   3 +
 fs/ext4/extents.c                             |   5 +-
 fs/ext4/extents_status.c                      |  14 +-
 fs/ext4/extents_status.h                      |   6 +-
 fs/ext4/inode.c                               |  65 +-
 fs/hugetlbfs/inode.c                          |  17 +-
 include/linux/filter.h                        |   3 +-
 include/linux/hugetlb.h                       |   2 +-
 include/linux/hyperv.h                        |  23 +
 include/linux/lsm_hook_defs.h                 |   6 +-
 include/linux/lsm_hooks.h                     |   4 +-
 include/linux/regmap.h                        |  19 +
 include/linux/security.h                      |  11 +-
 include/linux/sockptr.h                       |   5 +
 include/trace/events/qdisc.h                  |  20 +-
 kernel/bpf/cpumap.c                           |   2 +-
 kernel/exit.c                                 |  12 +-
 kernel/sys.c                                  |  91 +-
 mm/hugetlb.c                                  |  37 +-
 net/core/filter.c                             |   5 +-
 net/core/sock.c                               |  52 +-
 net/ipv6/route.c                              |  21 +-
 net/netfilter/nf_conntrack_h323_asn1.c        |   4 +
 net/netfilter/nft_ct.c                        |  11 +-
 net/netrom/af_netrom.c                        |  14 +-
 net/netrom/nr_dev.c                           |   2 +-
 net/netrom/nr_in.c                            |   6 +-
 net/netrom/nr_out.c                           |   2 +-
 net/netrom/nr_route.c                         |   8 +-
 net/netrom/nr_subr.c                          |   5 +-
 net/rds/rdma.c                                |   3 +
 net/rds/send.c                                |   6 +-
 security/apparmor/lsm.c                       |  29 +-
 security/security.c                           |  35 +-
 security/selinux/hooks.c                      |  13 +-
 security/smack/smack_lsm.c                    |  19 +-
 .../selftests/vm/charge_reserved_hugetlb.sh   |   2 +-
 tools/testing/selftests/vm/map_hugetlb.c      |   7 +
 .../selftests/vm/write_hugetlb_memory.sh      |   2 +-
 61 files changed, 1986 insertions(+), 711 deletions(-)

-- 
2.43.0


