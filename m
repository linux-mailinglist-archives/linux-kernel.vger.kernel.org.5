Return-Path: <linux-kernel+bounces-104828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE1987D43C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7D11C221B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA874CB38;
	Fri, 15 Mar 2024 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjjwss61"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1399F4DA1F;
	Fri, 15 Mar 2024 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710529314; cv=none; b=gGmXl8IL1jgjfFoR/jGxBtVjqqRNqDlC8eX7Aaz04EQbGvxEZ4d5AMF/+xheo89tdZ7YS5bjdvcxRAS++17O+YKjGxANpKIjHdJEqvRevOKNXZ0RXWjYb01fgZXM3tOAegLurMvY95B6Ui+JBfeAUC4HIPGwhtc/nz3dVac616k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710529314; c=relaxed/simple;
	bh=QvY365IiaqVnWKCxiOBtKcGofIVOm0xG9HX14/t9U10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PMRJXisiFE0jISccQIbvl0P+0gwJTdwLyOsx7OqJT4PUIb3FAKOw/VJV5e2nQ2NvQCtgq8DiXzPMHsaEZHsp+ZYmq9YOFFCo6oPnGiNfrhhfqvJBdO6gOf0v+fB93Tn6kIm9PVW2Z4Opa10z6irSNgK0OmXFs5TxDQJxP4jPOJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjjwss61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFF9C433C7;
	Fri, 15 Mar 2024 19:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710529313;
	bh=QvY365IiaqVnWKCxiOBtKcGofIVOm0xG9HX14/t9U10=;
	h=From:To:Cc:Subject:Date:From;
	b=fjjwss61IQEDyxkvdCsVAlZGto40J1I/qFSYY8XWcuAymyercOOF2xELy02GNpVqa
	 b0eH6Pue5WGzSdO5qWXUMIdLSvBjGcNuB5FPkbS3kXBTN3LSWJAfk7mnA9Kyy/fapk
	 O3sh9u2WDd4A+HQk9eoUXSAxfBuO1f2nPfJxmDtl7RRbTiXW+6M2+N9cxT4ZFO6FW2
	 LYANLusNeYAU74xE8XtiqlcFBWQWhrC5KdCHO0j0Xuscf2zcnKe9+k0ae8GacBwAJc
	 pHHbb8UkjRx/QIn3fUjOVrPs5B1GAmkwiiW5wuXxBIoMTVgdi7K1fAJB2iGvisIlWh
	 yfYgEKHGBUInQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Linux 5.15.152
Date: Fri, 15 Mar 2024 15:01:48 -0400
Message-ID: <20240315190151.1842554-1-sashal@kernel.org>
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

I'm announcing the release of the 5.15.152 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary


Thanks,
Sasha

- ------------


 Makefile                                           |   2 +-
 drivers/base/regmap/internal.h                     |   4 +
 drivers/base/regmap/regmap.c                       |  77 ++++-----
 drivers/gpu/drm/amd/amdgpu/cik_ih.c                |   6 +
 drivers/gpu/drm/amd/amdgpu/cz_ih.c                 |   5 +
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c            |   5 +
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c             |   6 +
 drivers/gpu/drm/amd/amdgpu/si_ih.c                 |   6 +
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c              |   6 +
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c             |   6 +
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c             |   6 +
 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c     |   2 +-
 drivers/gpu/drm/amd/display/dc/Makefile            |   4 +-
 drivers/gpu/drm/amd/display/dc/calcs/Makefile      |  68 --------
 drivers/gpu/drm/amd/display/dc/core/dc_link_dpcd.c |   4 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |   2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |  22 ++-
 .../drm/amd/display/dc/{ => dml}/calcs/bw_fixed.c  |   0
 .../amd/display/dc/{ => dml}/calcs/calcs_logger.h  |   0
 .../amd/display/dc/{ => dml}/calcs/custom_float.c  |   0
 .../drm/amd/display/dc/{ => dml}/calcs/dce_calcs.c |   0
 .../amd/display/dc/{ => dml}/calcs/dcn_calc_auto.c |   0
 .../amd/display/dc/{ => dml}/calcs/dcn_calc_auto.h |   0
 .../amd/display/dc/{ => dml}/calcs/dcn_calc_math.c |   0
 .../drm/amd/display/dc/{ => dml}/calcs/dcn_calcs.c |   0
 .../dc/dml/{dcn2x/dcn2x.c => dcn20/dcn20_fpu.c}    |   2 +-
 .../dc/dml/{dcn2x/dcn2x.h => dcn20/dcn20_fpu.h}    |   6 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |  23 ---
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h            |   2 -
 drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c          |  25 ++-
 drivers/mmc/host/mmci_stm32_sdmmc.c                | 112 +++++++++++--
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c          |   2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  56 ++++++-
 .../ethernet/microchip/sparx5/sparx5_mactable.c    |   4 +-
 .../net/ethernet/netronome/nfp/flower/conntrack.c  |  28 +++-
 .../net/ethernet/netronome/nfp/flower/conntrack.h  |   2 +
 drivers/net/geneve.c                               |  18 ++-
 drivers/net/hyperv/netvsc_drv.c                    |  83 +++++++---
 drivers/net/usb/lan78xx.c                          |   3 +-
 drivers/tty/serial/max310x.c                       | 151 +++++++++++-------
 drivers/usb/host/xhci-ring.c                       |  80 ++++++++--
 drivers/usb/host/xhci.h                            |   1 +
 fs/erofs/data.c                                    |   1 +
 fs/proc/array.c                                    |  17 +-
 include/linux/regmap.h                             |  19 +++
 include/trace/events/qdisc.h                       |  20 +--
 kernel/bpf/cpumap.c                                |   2 +-
 kernel/sys.c                                       |  91 ++++++-----
 net/ipv6/route.c                                   |  21 +--
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
 sound/usb/card.c                                   |   1 +
 sound/usb/card.h                                   |   7 +-
 sound/usb/endpoint.c                               | 177 +++++++++++++++++----
 sound/usb/endpoint.h                               |   9 +-
 sound/usb/implicit.c                               |   9 +-
 sound/usb/implicit.h                               |   2 +-
 sound/usb/mixer.c                                  |   7 +
 sound/usb/pcm.c                                    |  89 +++++++----
 sound/usb/pcm.h                                    |   2 +
 sound/usb/quirks.c                                 |  30 ++--
 sound/usb/usbaudio.h                               |   9 ++
 tools/testing/selftests/net/mptcp/simult_flows.sh  |   8 +-
 .../selftests/vm/charge_reserved_hugetlb.sh        |   2 +-
 tools/testing/selftests/vm/map_hugetlb.c           |   7 +
 tools/testing/selftests/vm/write_hugetlb_memory.sh |   2 +-
 76 files changed, 957 insertions(+), 469 deletions(-)

Ansuel Smith (1):
      regmap: allow to define reg_update_bits for no bus configuration

Christophe Kerello (1):
      mmc: mmci: stm32: fix DMA API overlapping mappings warning

Christos Skevis (1):
      ALSA: usb-audio: Fix microphone sound on Nexigo webcam.

Cosmin Tanislav (3):
      serial: max310x: use regmap methods for SPI batch operations
      serial: max310x: use a separate regmap for each port
      serial: max310x: make accessing revision id interface-agnostic

Edward Adam Davis (1):
      net/rds: fix WARNING in rds_conn_connect_if_down

Eric Dumazet (2):
      geneve: make sure to pull inner header in geneve_rx()
      net/ipv6: avoid possible UAF in ip6_route_mpath_notify()

Evan Quan (1):
      drm/amd/pm: do not expose the API used internally only in kv_dpm.c

Florian Westphal (1):
      netfilter: nft_ct: fix l3num expectations with inet pseudo family

Friedrich Vock (1):
      drm/amdgpu: Reset IH OVERFLOW_CLEAR bit

Gao Xiang (1):
      erofs: apply proper VMA alignment for memory mapped files on THP

Horatiu Vultur (1):
      net: sparx5: Fix use after free inside sparx5_del_mact_entry

Hugo Villeneuve (1):
      serial: max310x: prevent infinite while() loop in port startup

Hui Zhou (1):
      nfp: flower: add hardware offload check for post ct entry

Isabella Basso (1):
      drm/amd/display: move calcs folder into DML

Jan Kundrát (1):
      serial: max310x: fix IO data corruption in batched operations

Jaroslav Kysela (2):
      ALSA: usb-audio: Add new quirk FIXED_RATE for JBL Quantum810 Wireless
      ALSA: usb-audio: Always initialize fixed_rate in snd_usb_find_implicit_fb_sync_format()

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

John Keeping (1):
      ALSA: usb-audio: Add quirk for Tascam Model 12

Juhee Kang (1):
      hv_netvsc: use netif_is_bond_master() instead of open code

Kees Cook (1):
      proc: Use task_is_running() for wchan in /proc/$pid/stat

Lena Wang (1):
      netfilter: nf_conntrack_h323: Add protection for bmp length out of range

Maciej Fijalkowski (2):
      ixgbe: {dis, en}able irqs in ixgbe_txrx_ring_{dis, en}able
      i40e: disable NAPI right after disabling irqs when handling xsk_pool

Magali Lemes (1):
      drm/amd/display: remove DML Makefile duplicate lines

Marek Vasut (1):
      regmap: Add bulk read/write callbacks into regmap_config

Mathias Nyman (1):
      xhci: process isoc TD properly when there was a transaction error mid TD.

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: decrease BW in simult flows

Michal Pecio (1):
      xhci: handle isoc Babble and Buffer Overrun events properly

Muhammad Usama Anjum (1):
      selftests/mm: switch to bash from sh

Nathan Chancellor (1):
      drm/amd/display: Increase frame-larger-than for all display_mode_vba files

Nico Pache (1):
      selftests: mm: fix map_hugetlb failure on 64K page size systems

Oleg Nesterov (5):
      getrusage: add the "signal_struct *sig" local variable
      getrusage: move thread_group_cputime_adjusted() outside of lock_task_sighand()
      getrusage: use __for_each_thread()
      getrusage: use sig->stats_lock rather than lock_task_sighand()
      fs/proc: do_task_stat: move thread_group_cputime_adjusted() outside of lock_task_sighand()

Oleksij Rempel (1):
      net: lan78xx: fix runtime PM count underflow on link stop

Qingqing Zhuo (1):
      drm/amd/display: Re-arrange FPU code structure for dcn2x

Rand Deeb (1):
      net: ice: Fix potential NULL pointer dereference in ice_bridge_setlink()

Sasha Levin (1):
      Linux 5.15.152

Sean Young (1):
      ALSA: usb-audio: add quirk for RODE NT-USB+

Shradha Gupta (1):
      hv_netvsc: Register VF in netvsc_probe if NET_DEVICE_REGISTER missed

Srinivasan Shanmugam (1):
      drm/amd/display: Fix uninitialized variable usage in core_link_ 'read_dpcd() & write_dpcd()' functions

Steven Rostedt (Google) (1):
      tracing/net_sched: Fix tracepoints that save qdisc_dev() as a string

Takashi Iwai (9):
      ALSA: usb-audio: Refcount multiple accesses on the single clock
      ALSA: usb-audio: Clear fixed clock rate at closing EP
      ALSA: usb-audio: Split endpoint setups for hw_params and prepare (take#2)
      ALSA: usb-audio: Properly refcounting clock rate
      ALSA: usb-audio: Apply mutex around snd_usb_endpoint_set_params()
      ALSA: usb-audio: Correct the return code from snd_usb_endpoint_set_params()
      ALSA: usb-audio: Avoid superfluous endpoint setup
      ALSA: usb-audio: Add FIXED_RATE quirk for JBL Quantum610 Wireless
      ALSA: usb-audio: Sort quirk table entries

Toke Høiland-Jørgensen (1):
      cpumap: Zero-initialise xdp_rxq_info struct before running XDP program

Wan Jiabing (1):
      ALSA: usb-audio: Fix wrong kfree issue in snd_usb_endpoint_free_all

Wentao Jia (1):
      nfp: flower: add goto_chain_index for ct entry

Yann Gautier (1):
      mmc: mmci: stm32: use a buffer for unaligned DMA requests

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAmX0mxsACgkQ3qZv95d3
LNzoVhAAlP71z8qQfPrzdvj6wtyZiiaZmO58KBpLwjXiEWoxtR8zOeBY+92ijK+m
bVy1RThpYVMXwxQypHE60T2k3wQUSZgTWJglarFlw4vg99pK2iacVaJmW9Y9OGRv
MTxRuB6l33O905xddEDbrbgY+kk3ev4UmcC7o18my91ETlWOQTY6WA8G3U9lIaxA
2xl90eUOvGgfuSS6Zm0X1P82DzBrXK2Z6xx5OTt2tzf5eslcxpaUkew3YmffMO2/
3NW+p3mDVqyBIfVyvUULGLWVGjPS6wVfJsHWNHE6MA7EDI/nIEmOsAteZFSgxkDb
8iLPHZEfUzu0z9VN0J4OWHr/mQU7EoJKH5hq+86oZA2cGf7X5saug0uVWkYfq1Et
J8lwZsN7j6XxpuE+FTz+/HuAe2NvCNuxusxrRxEX1lwob9VV6h/lC8Z0fy8LSUNj
o9ac0lYrbr7Pq+dYSh/naYBrRsERZOZm3NM0t8gxoIRor+ezlHeUDEYn/bJ5TVso
Na9PSIe/I3xotu8lb9CZ88BLQj/WgaoMS4WwiYuGb/R9Jt837eu7pr3zhnW7hWMk
pmJ+dGk7EhrH9FElqbMCG0Q4+UmJ/hvmOqAzlHO2qllb2vkR8Jos8XcC72vfHsrS
3iIYYiIvvDt1RZTDgR1c0c3byROWqE01MBRUiKre3y3FrtIHnWY=
=aSc5
-----END PGP SIGNATURE-----

