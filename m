Return-Path: <linux-kernel+bounces-102120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6F787AE95
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B241F26F4D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEDE6A8D9;
	Wed, 13 Mar 2024 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k27iRdeC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF84F4D9E3;
	Wed, 13 Mar 2024 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349336; cv=none; b=FSvx97AGi7BbjhMHIHL+ABbnkPsF8gY20wtBOP2RjmzuKhuYIQY6cKR9g+eCY1e6sC670t8UNxE6zjA+9c2trPZrYb0C+gfnumdfw1Nn0CF5QiI/EQU/yRPUkkn2h7A67OsMMv312Cmex/VD/pKObOfS5VUHCkjZIrdFbvYYvwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349336; c=relaxed/simple;
	bh=l2KV/M/vR1XTLDq4ZjsX8fhnvdqjc1lnjlQbD6a1PLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qg5KfE5eBqNlk5HXBkLp9wkm2/1C87Hotaj4DORCOtV/VKJuhdP49OKUgMNmtD0IgKNVNSt7+BZ4mShlQ2smRve0GsuEeNXdOYQ6aD6hYlR9nWYrgeTujglaN08hSYeHx2/Ly2sy4WZ90x/0pFdjacGfPXM12fpL21cC+aN4JI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k27iRdeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357B0C433F1;
	Wed, 13 Mar 2024 17:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349335;
	bh=l2KV/M/vR1XTLDq4ZjsX8fhnvdqjc1lnjlQbD6a1PLE=;
	h=From:To:Cc:Subject:Date:From;
	b=k27iRdeC4l2nuetoCEO90lZtnukYQ4+TzTL0r+T63F+/Z2hXSsFdDBB0nPYKXkDT9
	 dkdROBP9wWZDoTcQqV1IT+mqM/gtXDCdKlZwspIexUXZVUk4wnxixbGEh/Ro/xAxm0
	 t+vYPGr26UNV8/fFqjB7Jov/dEM2mF32Jdh3RNQVJGRRqm9Kb3FXiKCOQy/4D7Z5nX
	 sZPm5PJLBziMHABW595JOUhXwm3fJJK3ouaQBB+rvZtl+mEkbIA7DakfhIp0PL5mYh
	 zRy8y4AWCetLGRE9Gq2Vnb3BkKmiFKjEaalhzzQ7fGJuPLGfSuk+u8vLmnpyYzfLi8
	 8h/V4EaezgXOQ==
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
Subject: [PATCH 5.4 00/51] 5.4.272-rc1 review
Date: Wed, 13 Mar 2024 13:01:21 -0400
Message-ID: <20240313170212.616443-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.272-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.272-rc1
X-KernelTest-Deadline: 2024-03-15T17:02+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit


This is the start of the stable review cycle for the 5.4.272 release.
There are 51 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Mar 15 05:02:10 PM UTC 2024.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.4.y&id2=v5.4.271
or in the git tree and branch at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
and the diffstat can be found below.

Thanks,
Sasha

-------------
Pseudo-Shortlog of commits:

Andy Shevchenko (4):
  serial: max310x: Use devm_clk_get_optional() to get the input clock
  serial: max310x: Try to get crystal clock rate from property
  serial: max310x: Make use of device properties
  serial: max310x: Unprepare and disable clock in error path

Ansuel Smith (1):
  regmap: allow to define reg_update_bits for no bus configuration

Arnd Bergmann (1):
  y2038: rusage: use __kernel_old_timeval

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

Maciej Fijalkowski (1):
  ixgbe: {dis, en}able irqs in ixgbe_txrx_ring_{dis, en}able

Marek Vasut (1):
  regmap: Add bulk read/write callbacks into regmap_config

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

Rand Deeb (1):
  net: ice: Fix potential NULL pointer dereference in
    ice_bridge_setlink()

Sasha Levin (1):
  Linux 5.4.272-rc1

Shradha Gupta (1):
  hv_netvsc: Register VF in netvsc_probe if NET_DEVICE_REGISTER missed

Werner Sembach (1):
  Input: i8042 - fix strange behavior of touchpad on Clevo NS70PU

 Makefile                                      |   4 +-
 arch/alpha/kernel/osf_sys.c                   |   2 +-
 arch/um/Kconfig                               |  13 +
 arch/um/Makefile                              |   3 +-
 arch/x86/Makefile.um                          |   2 +-
 drivers/base/regmap/internal.h                |   4 +
 drivers/base/regmap/regmap.c                  |  77 +-
 drivers/input/serio/i8042-x86ia64io.h         |   6 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  56 +-
 drivers/net/geneve.c                          |  18 +-
 drivers/net/hyperv/netvsc_drv.c               |  96 +-
 drivers/net/usb/lan78xx.c                     | 910 ++++++++++++++----
 drivers/tty/serial/Kconfig                    |   1 +
 drivers/tty/serial/max310x.c                  | 378 ++++++--
 include/linux/regmap.h                        |  19 +
 include/uapi/linux/resource.h                 |   4 +-
 kernel/exit.c                                 |  12 +-
 kernel/sys.c                                  |  91 +-
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
 tools/testing/selftests/vm/map_hugetlb.c      |   7 +
 31 files changed, 1322 insertions(+), 465 deletions(-)

-- 
2.43.0


