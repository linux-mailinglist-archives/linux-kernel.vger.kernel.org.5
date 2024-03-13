Return-Path: <linux-kernel+bounces-102185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584D087AF3C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A647B26525
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B462160ED8;
	Wed, 13 Mar 2024 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RykeFtAo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05C860DFB;
	Wed, 13 Mar 2024 17:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349478; cv=none; b=qbyEaIM1fqqXXQOss2lt8Om40pYsD6U+WLd+HYwhxLykyboRIvq/aQuj7D+0fW7N4IK3Ldpn4kC2OFcnW87i7e4P+sWKOZApSS7R8wMAgGXYgDxVlUerW+hmWKucQlJrSgTNsTJADTIZD68UPoapuL3sDLUk75RFzvrgaQIvlFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349478; c=relaxed/simple;
	bh=NiYGXLVg9gxjtm8wiGDuM7Xp7yvCfG4vRt5gUIfl8h4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LQL2AV1vgUyc+pfwOf921on+JCiUT5uYm25w1Ft3QMDKsxE/VwpWCHgaY2jJ1QHHaPwyWW+pDodvRVn98oKLlnzHbFGTXGrwkCIcsRYIKGl2OrpO8I4/LD3+gBczBoz+Y0ijoD0EhROassoz00I56b5tfndDdQRFjrFp+MdIEpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RykeFtAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D1CC433F1;
	Wed, 13 Mar 2024 17:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349478;
	bh=NiYGXLVg9gxjtm8wiGDuM7Xp7yvCfG4vRt5gUIfl8h4=;
	h=From:To:Cc:Subject:Date:From;
	b=RykeFtAoPAVeMItJO8YMBxNXL1RTVJdHp5AdSmfHOuWlUSBT3dX1hW+VNKoePTUhV
	 mgCUewn/szn7bEJ6/XA9CXuz4qUb0V7Vob5X2fHbSoOMqfyA4ECFJbSmnlkOHt1S/u
	 1LXogAoAz3dHgZ4sdAzV+M5vHAKiQEsyWoP2rMaKZUHuY4hUcleABEISrve+VgCjIn
	 NUrB0nksxkH/w9hAUMPJncUAuVS9tpMMPFdUty1HuX8nIPmZ++Hlaye+tye64KxT39
	 La+BU3hckTltHZ9bqV3C5lW0YQB+9OiweSQVwPDqLHowCkgZpH7q1DAoDwPXI6mXZp
	 T6+031EWdgS6g==
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
Subject: [PATCH 4.19 00/41] 4.19.310-rc1 review
Date: Wed, 13 Mar 2024 13:03:54 -0400
Message-ID: <20240313170435.616724-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.310-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.310-rc1
X-KernelTest-Deadline: 2024-03-15T17:04+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit


This is the start of the stable review cycle for the 4.19.310 release.
There are 41 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Mar 15 05:04:34 PM UTC 2024.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-4.19.y&id2=v4.19.309
or in the git tree and branch at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

Thanks,
Sasha

-------------
Pseudo-Shortlog of commits:

Arnd Bergmann (1):
  y2038: rusage: use __kernel_old_timeval

Christophe Leroy (3):
  tools/selftest/vm: allow choosing mem size and page size in
    map_hugetlb
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

Ingo Molnar (1):
  exit: Fix typo in comment: s/sub-theads/sub-threads

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

Lee Jones (1):
  net: usb: lan78xx: Remove lots of set but unused 'ret' variables

Lena Wang (1):
  netfilter: nf_conntrack_h323: Add protection for bmp length out of
    range

Li RongQing (1):
  net: move definition of pcpu_lstats to header file

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

Sasha Levin (1):
  Linux 4.19.310-rc1

Shradha Gupta (1):
  hv_netvsc: Register VF in netvsc_probe if NET_DEVICE_REGISTER missed

Werner Sembach (1):
  Input: i8042 - fix strange behavior of touchpad on Clevo NS70PU

 Makefile                                 |   4 +-
 arch/alpha/kernel/osf_sys.c              |   2 +-
 arch/um/Kconfig                          |  13 +
 arch/um/Makefile                         |   3 +-
 arch/x86/Makefile.um                     |   2 +-
 drivers/input/serio/i8042-x86ia64io.h    |   6 +
 drivers/net/geneve.c                     |  18 +-
 drivers/net/hyperv/netvsc_drv.c          |  96 ++-
 drivers/net/loopback.c                   |   6 -
 drivers/net/nlmon.c                      |   6 -
 drivers/net/usb/lan78xx.c                | 966 +++++++++++++++++------
 drivers/net/vsockmon.c                   |  14 +-
 fs/btrfs/ref-verify.c                    |   6 +-
 include/linux/netdevice.h                |   6 +
 include/uapi/linux/resource.h            |   4 +-
 kernel/exit.c                            |  12 +-
 kernel/sys.c                             |  91 ++-
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
 28 files changed, 994 insertions(+), 382 deletions(-)

-- 
2.43.0


