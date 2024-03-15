Return-Path: <linux-kernel+bounces-104837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E678E87D45C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D93F284030
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26E950A98;
	Fri, 15 Mar 2024 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCU5w8zm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F481EB2C;
	Fri, 15 Mar 2024 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710529856; cv=none; b=nK9xr126pvm6xEFbDle7etR3c97XDf7kgGqo0fYYf2ILXTEH2rAqdBzJkNf23gobe8/8pt9qyUTv9v3i7tMCnFwOSvkvCcuYqSBuP9fDyotuQhw2lw1dNjngZ76PhRIvXggmwbJ7uigDe0mgnjWgMgGXecmIIitsCMR/uMKb+iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710529856; c=relaxed/simple;
	bh=UFDhknKSbVgfL/goGiO7QqgBsvOR464JDO/QqFM83rw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rvl39O3TWtkxR7R1e5wZ2hD2uhHLY0gotK7ADY1T+GN2mMozTUyuw4n7svKrdtlKV6WxjvzSO21QAyeV6S6JgOsxmiERsiaYOVbab4z2NI5GkCrNmVjdGCFyBvs1i6X9TxaKIgbXmuFtutKS1eQhvYeHgPaALG6yUkFm3JBhBCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCU5w8zm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A159C433F1;
	Fri, 15 Mar 2024 19:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710529855;
	bh=UFDhknKSbVgfL/goGiO7QqgBsvOR464JDO/QqFM83rw=;
	h=From:To:Cc:Subject:Date:From;
	b=qCU5w8zmpScphLf1BQ+DlHn9QwGeM4WeBIKqHFV/IsM16gpPSMgkmKudZj375TkiV
	 h+5l/A7nrt83ZrpRwuCi1CdZ0U/Qa3L3oF0wsbU4dNkEEeMOX1li45oIvZnquzf2eX
	 h+SynpsQXZ3tyAJEuCelzj+eFXDIoN0PsVO6vZ1OReQYXA4Y6JFmYYeO6sWcYrnzeS
	 DLUq31I4se3T7UGKtXhBNUfnB7xZt2zgJp252EWsYR+GrV29v9Nv6yL+4nJdoTvywf
	 3VTVFyYw2n3lGokfIE3fiu4rxGUsIoAoGCU9WDm5wrP+SY76Rqa5TfdL6eCyY2cvTw
	 wGjUzVhou2Saw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Linux 4.19.310
Date: Fri, 15 Mar 2024 15:10:52 -0400
Message-ID: <20240315191053.1844191-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I'm announcing the release of the 4.19.310 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.19.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary


Thanks,
Sasha

- ------------


 Makefile                                 |   2 +-
 arch/alpha/kernel/osf_sys.c              |   2 +-
 arch/um/Kconfig                          |  13 +
 arch/um/Makefile                         |   3 +-
 arch/x86/Makefile.um                     |   2 +-
 drivers/input/serio/i8042-x86ia64io.h    |   6 +
 drivers/net/geneve.c                     |  18 +-
 drivers/net/hyperv/netvsc_drv.c          |  96 ++-
 drivers/net/loopback.c                   |   6 -
 drivers/net/nlmon.c                      |   6 -
 drivers/net/usb/lan78xx.c                | 966 +++++++++++++++++++++++--------
 drivers/net/vsockmon.c                   |  14 +-
 fs/btrfs/ref-verify.c                    |   6 +-
 include/linux/netdevice.h                |   6 +
 include/uapi/linux/resource.h            |   4 +-
 kernel/sys.c                             |  91 +--
 net/ipv6/route.c                         |  21 +-
 net/netfilter/nf_conntrack_h323_asn1.c   |   4 +
 net/netrom/af_netrom.c                   |  14 +-
 net/netrom/nr_dev.c                      |   2 +-
 net/netrom/nr_in.c                       |   6 +-
 net/netrom/nr_out.c                      |   2 +-
 net/netrom/nr_route.c                    |   8 +-
 net/netrom/nr_subr.c                     |   5 +-
 net/rds/rdma.c                           |   3 +
 net/rds/send.c                           |   6 +-
 tools/testing/selftests/vm/map_hugetlb.c |  50 +-
 27 files changed, 989 insertions(+), 373 deletions(-)

Arnd Bergmann (1):
      y2038: rusage: use __kernel_old_timeval

Christophe Leroy (3):
      tools/selftest/vm: allow choosing mem size and page size in map_hugetlb
      selftests/vm: fix display of page size in map_hugetlb
      selftests/vm: fix map_hugetlb length used for testing read and write

Dexuan Cui (1):
      hv_netvsc: Make netvsc/VF binding check both MAC and serial number

Edward Adam Davis (1):
      net/rds: fix WARNING in rds_conn_connect_if_down

Eric Dumazet (2):
      geneve: make sure to pull inner header in geneve_rx()
      net/ipv6: avoid possible UAF in ip6_route_mpath_notify()

Fedor Pchelkin (1):
      btrfs: ref-verify: free ref cache before clearing mount opt

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

Lee Jones (1):
      net: usb: lan78xx: Remove lots of set but unused 'ret' variables

Lena Wang (1):
      netfilter: nf_conntrack_h323: Add protection for bmp length out of range

Li RongQing (1):
      net: move definition of pcpu_lstats to header file

Nico Pache (1):
      selftests: mm: fix map_hugetlb failure on 64K page size systems

Oleg Nesterov (4):
      getrusage: add the "signal_struct *sig" local variable
      getrusage: move thread_group_cputime_adjusted() outside of lock_task_sighand()
      getrusage: use __for_each_thread()
      getrusage: use sig->stats_lock rather than lock_task_sighand()

Oleksij Rempel (1):
      net: lan78xx: fix runtime PM count underflow on link stop

Sasha Levin (1):
      Linux 4.19.310

Shradha Gupta (1):
      hv_netvsc: Register VF in netvsc_probe if NET_DEVICE_REGISTER missed

Werner Sembach (1):
      Input: i8042 - fix strange behavior of touchpad on Clevo NS70PU

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAmX0nTsACgkQ3qZv95d3
LNxqzQ//Zn+wIORW6+gZGsidAvNaWWvtGOJII2rW1ZJsCfduCvuFPNRrab9m6JrQ
O+S7QgyLhLQpdqwbjA+MhGbai2KVPuv/MgsOT8ext5y9WpEDcy2uLSoabC9yOd0U
VDq27hhE6F3TgZpJwuVzHByuMmWSd96bLNuqhUEL5+07AIsRO+xqOK9Otwt6iuLd
uCMTtE0GlHIVAT73l8Pv7u1mOMXvEou/7xjDqQAB8Oo8pO+gHZfUqyExAjip4g9M
Ve6Sj8//zZWZHodKs/xtSX94ljP1qS3b3PdkkHJB2gbgqeymWm4v2X6IQgZ2PTXd
/Iy/4r9d9unBvEhfzXDcyHpvqZBOlR9nd6J0pjmERTpr6KWAwhRU/iaKDwt9lfij
nZ31PWR+qS8i7VxQGi+IKJ9QDLAhvMuR6yIF74ITuYWc+y19qsDE+KL8775eAGzA
/qOUqJsICtISSSsZ1jPJOJ4o469sxmAaT/xElFfVEbZLmtkx0FdI2mPeZ7WasHkN
421UnsoZnHr43Zc2uscquhmZuDEnoBkmGBhp2z6PTDe1SgMbR8c+qGJUNY31hKLv
XvuVMgrkLfXRu1LuZAaaxhPdIbjX9dDca5/I75C8S6a5eCpVmjZv+GhwZMuajxFU
qEUVkHQRch2RFyvV0Avl8IEIprRW46EuCx2eX2wXF/Fq4Mp20G4=
=zydN
-----END PGP SIGNATURE-----

