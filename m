Return-Path: <linux-kernel+bounces-104831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9871C87D44A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5521E286D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1148D4CB37;
	Fri, 15 Mar 2024 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYSEMTdY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121A851005;
	Fri, 15 Mar 2024 19:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710529455; cv=none; b=Dqi9oSLd0BQ+odmnlKCkp3yh87L6SehkKgU23awGk25RB9K3p3QYg7CnqQeL5tnWNMvNd09L+WZKRHxvdCFABbli9Bg2PhYcprPLC8Xl3ByvcRnfLX85FMN4hhznFyUJUYdU3LqjV98kSKL6x4BMy9HpnlDIiMRK5flA3SEf6Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710529455; c=relaxed/simple;
	bh=w1QSBIEJLDFrMUZ5rb9xFvxoKDFkdAmzZUEKDiHE/FE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LXyyrA8hTX7lMkYQ5ynQ5D3FstZPeGulcC6/NOq5vFxt2LIyY/bR+QoROA0usd6mpWjbb7z9EzdSxUrA9K87djUP0hV/zTpWjuT0noe9PdNNgjY2BNjhMptWoYIIWX+9cnJaY9uZ21pTZT3cvPzFKHxdd3oDehoRzRGUGCsTFxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYSEMTdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1A4C433C7;
	Fri, 15 Mar 2024 19:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710529454;
	bh=w1QSBIEJLDFrMUZ5rb9xFvxoKDFkdAmzZUEKDiHE/FE=;
	h=From:To:Cc:Subject:Date:From;
	b=QYSEMTdY6oYUuWh/T2ZVVxorw3QIO6NdyW4+XfyQXm97WJb3Z+djiaKodREPv9X67
	 GX+hrSndIWfBKa7ruUWM7iAsc8eKf66S92Dzq1y7e/pg48Z8cvHyZTTq9q3A47nqiU
	 34CnWTtZ+WmVgBUdgBBwTeBvmVUaawQ8jjYds99rN/YGZbFur0Qx8qMjqzQVT+kttz
	 Xx1MND8RM19dq7t6htSDXkA4y5LYQY6psldxY6jJoYKd8B7FGJnxatyGS8QHNhWmf1
	 9zXGDJ1SDNoFOKmDlMGJHaG3r7xBXLAKOAAZLoZ8qDFIVjLRVDEhmnWBLwksGUE38l
	 F2pUC0sM6XOtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Linux 5.10.213
Date: Fri, 15 Mar 2024 15:04:09 -0400
Message-ID: <20240315190412.1843035-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I'm announcing the release of the 5.10.213 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary


Thanks,
Sasha

- ------------


 Makefile                                           |   2 +-
 arch/um/Kconfig                                    |  13 +
 arch/um/Makefile                                   |   3 +-
 arch/x86/Makefile.um                               |   2 +-
 drivers/base/regmap/internal.h                     |   4 +
 drivers/base/regmap/regmap.c                       |  77 +-
 drivers/hv/channel.c                               | 174 +++-
 drivers/hv/hyperv_vmbus.h                          |   3 +-
 drivers/hv/ring_buffer.c                           |  28 +-
 drivers/mmc/host/mmci_stm32_sdmmc.c                | 112 ++-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |   2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  56 +-
 drivers/net/geneve.c                               |  18 +-
 drivers/net/hyperv/hyperv_net.h                    |  13 +
 drivers/net/hyperv/netvsc.c                        |  55 +-
 drivers/net/hyperv/netvsc_drv.c                    | 107 ++-
 drivers/net/hyperv/rndis_filter.c                  |   1 +
 drivers/net/usb/lan78xx.c                          | 910 ++++++++++++++++-----
 drivers/tty/serial/Kconfig                         |   1 +
 drivers/tty/serial/max310x.c                       | 378 ++++++---
 drivers/usb/host/xhci-ring.c                       | 143 +++-
 drivers/usb/host/xhci.h                            |   3 +
 fs/ext4/extents.c                                  |   5 +-
 fs/ext4/extents_status.c                           |  14 +-
 fs/ext4/extents_status.h                           |   6 +-
 fs/ext4/inode.c                                    |  65 +-
 fs/hugetlbfs/inode.c                               |  17 +-
 include/linux/filter.h                             |   3 +-
 include/linux/hugetlb.h                            |   2 +-
 include/linux/hyperv.h                             |  23 +
 include/linux/lsm_hook_defs.h                      |   6 +-
 include/linux/lsm_hooks.h                          |   4 +-
 include/linux/regmap.h                             |  19 +
 include/linux/security.h                           |  11 +-
 include/linux/sockptr.h                            |   5 +
 include/trace/events/qdisc.h                       |  20 +-
 kernel/bpf/cpumap.c                                |   2 +-
 kernel/sys.c                                       |  91 ++-
 mm/hugetlb.c                                       |  37 +-
 net/core/filter.c                                  |   5 +-
 net/core/sock.c                                    |  52 +-
 net/ipv6/route.c                                   |  21 +-
 net/netfilter/nf_conntrack_h323_asn1.c             |   4 +
 net/netfilter/nft_ct.c                             |  11 +-
 net/netrom/af_netrom.c                             |  14 +-
 net/netrom/nr_dev.c                                |   2 +-
 net/netrom/nr_in.c                                 |   6 +-
 net/netrom/nr_out.c                                |   2 +-
 net/netrom/nr_route.c                              |   8 +-
 net/netrom/nr_subr.c                               |   5 +-
 net/rds/rdma.c                                     |   3 +
 net/rds/send.c                                     |   6 +-
 security/apparmor/lsm.c                            |  29 +-
 security/security.c                                |  35 +-
 security/selinux/hooks.c                           |  13 +-
 security/smack/smack_lsm.c                         |  19 +-
 .../selftests/vm/charge_reserved_hugetlb.sh        |   2 +-
 tools/testing/selftests/vm/map_hugetlb.c           |   7 +
 tools/testing/selftests/vm/write_hugetlb_memory.sh |   2 +-
 60 files changed, 1981 insertions(+), 702 deletions(-)

Andrea Parri (Microsoft) (1):
      Drivers: hv: vmbus: Drop error message when 'No request id available'

Andres Beltran (2):
      Drivers: hv: vmbus: Add vmbus_requestor data structure for VMBus hardening
      hv_netvsc: Use vmbus_requestor to generate transaction IDs for VMBus hardening

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

Jan Kundrát (1):
      serial: max310x: fix IO data corruption in batched operations

Jason Xing (12):
      netrom: Fix a data-race around sysctl_netrom_default_path_quality
      netrom: Fix a data-race around sysctl_netrom_obsolescence_count_initialiser
      netrom: Fix data-races around sysctl_netrom_network_ttl_initialiser
      netrom: Fix a data-race around sysctl_netrom_transport_timeout
      netrom: Fix a data-race around sysctl_netrom_transport_maximum_tries
      netrom: Fix a data-race around sysctl_netrom_transport_acknowledge_delay
      netrom: Fix a data-race around sysctl_netrom_transport_busy_delay
      netrom: Fix a data-race around sysctl_netrom_transport_requested_window_size
      netrom: Fix a data-race around sysctl_netrom_transport_no_activity_timeout
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
      netfilter: nf_conntrack_h323: Add protection for bmp length out of range

Long Li (2):
      hv_netvsc: Wait for completion on request SWITCH_DATA_PATH
      hv_netvsc: Process NETDEV_GOING_DOWN on VF hot remove

Maciej Fijalkowski (2):
      ixgbe: {dis, en}able irqs in ixgbe_txrx_ring_{dis, en}able
      i40e: disable NAPI right after disabling irqs when handling xsk_pool

Marek Vasut (1):
      regmap: Add bulk read/write callbacks into regmap_config

Martin KaFai Lau (2):
      net: Change sock_getsockopt() to take the sk ptr instead of the sock ptr
      bpf: net: Change sk_getsockopt() to take the sockptr_t argument

Mathias Nyman (3):
      xhci: remove extra loop in interrupt context
      xhci: prevent double-fetch of transfer and transfer event TRBs
      xhci: process isoc TD properly when there was a transaction error mid TD.

Michal Pecio (1):
      xhci: handle isoc Babble and Buffer Overrun events properly

Mike Kravetz (1):
      mm/hugetlb: change hugetlb_reserve_pages() to type bool

Muhammad Usama Anjum (1):
      selftests/mm: switch to bash from sh

Nico Pache (1):
      selftests: mm: fix map_hugetlb failure on 64K page size systems

Oleg Nesterov (4):
      getrusage: add the "signal_struct *sig" local variable
      getrusage: move thread_group_cputime_adjusted() outside of lock_task_sighand()
      getrusage: use __for_each_thread()
      getrusage: use sig->stats_lock rather than lock_task_sighand()

Oleksij Rempel (1):
      net: lan78xx: fix runtime PM count underflow on link stop

Ondrej Mosnacek (1):
      lsm: fix default return value of the socket_getpeersec_*() hooks

Paul Moore (1):
      lsm: make security_socket_getpeersec_stream() sockptr_t safe

Prakash Sangappa (1):
      mm: hugetlb pages should not be reserved by shmat() if SHM_NORESERVE

Rand Deeb (1):
      net: ice: Fix potential NULL pointer dereference in ice_bridge_setlink()

Sasha Levin (1):
      Linux 5.10.213

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

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAmX0m6kACgkQ3qZv95d3
LNwhoRAAvOhsQoD+aq3Z7sknD20UJ9JRkofM+91UJUfvWeWpOoZo/mqKYi487sTY
gxOZk9hE5oMNvu4KHbRXWfA7PYLLXYeyI3QGbCnB1WaEVrfRHEQExeA1sWvMZzHB
wuBY1a0j7ysk/unDGSoLPlSDJFj5iO39AoSoaorgGUZ9Z/k9K4CuLzSP5oBblsSl
zPMvXUsn7nGAfyThbS89wJOEYMmDQe0vglAnkCAX+p6JABc5uUVyNDmQ12EPRD11
P2/uZ9YlKejPNuaJxyZqFxxFTlAXjGhJu/gA4G3mQxtk5YQuFxQPtapw0XV0yJwu
Nz8OgSRFU24QBklsMTGXjXoi2fP2k6PpNYVdsC/wBSBGAnKYu0SmdeJfEY4GrxNZ
foGIAjnnR49pYfVVl94S6OpYsfLNPyjTEdYm2fJht5WzYSXc2GFMLZ7YqoIiWJum
CjtT0Yw/4C/OPcb2SE72XY932ieUnNhrTxUa9JejSCPa4nn8XRIo2oaUTPRcqR4T
OescRIfAvlJe9/H4DpzVzZZB53yFGRmIa3kMKw4r6oVlPq5xvJZ9tXxloApqCkzL
JZSxRoFLSwh3iRe8uUIP0YfhbOJxmaySr4/rlcnVdh+VW8dKRh1E+d+yDHTiFqz5
6waTahRk61y4oEAkI6kKOr4fM7lM6SHE69wnHMR5C79fbNhJowE=
=FqJj
-----END PGP SIGNATURE-----

