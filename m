Return-Path: <linux-kernel+bounces-104835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5FC87D458
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6761C209F4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B7A51005;
	Fri, 15 Mar 2024 19:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQms5C5V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2E61F922;
	Fri, 15 Mar 2024 19:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710529728; cv=none; b=b9XvhysBsaBdZd0rZXYtFscLmYsjm+sHUruk6dlmp+84nkZFkbFyK5vYTN19XaFBwMNZEBTsm//Ckf5mawafuFT1rtkDrj7b+rytlgIRd8Gd0UV3WtWGkXIDJH7O8vLCmWMFjdaKFyOfBVYzm/gcW4F/vEgeLpNhPdCI1HXgXzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710529728; c=relaxed/simple;
	bh=zzUqG1WU549eO/btRXbksc5TjerrX8vjxGYEcFIQwnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F3VdQLJ6Hw+borOLmXKEwClhjDjBC/9WSaj/4BQV9fwt0cSk/7uuBUHEfQY5E4uLdSa71SUWxEVzYGUQTOn72X4S5wIgHIpkNZazWX8JxNMwinul/+toLdsuxgvjruMjmGU5WdK24caRK8kWd4aZVVfbr39bKBwEXPWGpYeZF4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQms5C5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EE8C433C7;
	Fri, 15 Mar 2024 19:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710529728;
	bh=zzUqG1WU549eO/btRXbksc5TjerrX8vjxGYEcFIQwnE=;
	h=From:To:Cc:Subject:Date:From;
	b=WQms5C5VXIArpSqDUztZBblB6q0CIznTw8l6wcMXryHF8K2cQLJmnal9JPzvUJbux
	 uWSU73rQqg/arpuVmrVWre1VWVbWBwYEK5NNHJqFfq5GagHj58tV+j6+KcbTvgYeNX
	 uWArwaRxgzHsNUsN40hOIKhWjktra7Oe3GLvbTQvJIGUn89H4zRV1IRp5I2/lMahZa
	 7klJlJfjSd1gm/GjzTHnkj7ls3OlxXOzNS6sI7ed9tUlBVm+ZKtbn7GIAQs/Uicetr
	 DkNpewOOUfcg3x5qSZUhaopD+EEdhYkb2q0TTMYDM+D57yWKhbVRF6V5GSKvJCgVty
	 vjZg0doU2s5bw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Linux 5.4.272
Date: Fri, 15 Mar 2024 15:08:43 -0400
Message-ID: <20240315190845.1843591-1-sashal@kernel.org>
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

I'm announcing the release of the 5.4.272 kernel.

All users of the 5.4 kernel series must upgrade.

The updated 5.4.y git tree can be found at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary


Thanks,
Sasha

- ------------


 Makefile                                      |   2 +-
 arch/alpha/kernel/osf_sys.c                   |   2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  25 +-
 arch/um/Kconfig                               |  13 +
 arch/um/Makefile                              |   3 +-
 arch/x86/Makefile.um                          |   2 +-
 drivers/base/regmap/internal.h                |   4 +
 drivers/base/regmap/regmap.c                  |  77 ++-
 drivers/input/serio/i8042-x86ia64io.h         |   6 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  56 +-
 drivers/net/geneve.c                          |  18 +-
 drivers/net/hyperv/netvsc_drv.c               |  96 ++-
 drivers/net/usb/lan78xx.c                     | 910 ++++++++++++++++++++------
 drivers/tty/serial/Kconfig                    |   1 +
 drivers/tty/serial/max310x.c                  | 378 ++++++++---
 include/linux/regmap.h                        |  19 +
 include/uapi/linux/resource.h                 |   4 +-
 kernel/sys.c                                  |  91 +--
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
 31 files changed, 1334 insertions(+), 464 deletions(-)

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

Johan Hovold (1):
      arm64: dts: qcom: sdm845: fix USB DP/DM HS PHY interrupts

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

Lina Iyer (1):
      arm64: dts: qcom: add PDC interrupt controller for SDM845

Maciej Fijalkowski (1):
      ixgbe: {dis, en}able irqs in ixgbe_txrx_ring_{dis, en}able

Marek Vasut (1):
      regmap: Add bulk read/write callbacks into regmap_config

Nico Pache (1):
      selftests: mm: fix map_hugetlb failure on 64K page size systems

Oleg Nesterov (4):
      getrusage: add the "signal_struct *sig" local variable
      getrusage: move thread_group_cputime_adjusted() outside of lock_task_sighand()
      getrusage: use __for_each_thread()
      getrusage: use sig->stats_lock rather than lock_task_sighand()

Oleksij Rempel (1):
      net: lan78xx: fix runtime PM count underflow on link stop

Rand Deeb (1):
      net: ice: Fix potential NULL pointer dereference in ice_bridge_setlink()

Sasha Levin (1):
      Linux 5.4.272

Shradha Gupta (1):
      hv_netvsc: Register VF in netvsc_probe if NET_DEVICE_REGISTER missed

Werner Sembach (1):
      Input: i8042 - fix strange behavior of touchpad on Clevo NS70PU

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAmX0nLoACgkQ3qZv95d3
LNxrdw/+OcKPa2m7vFsJC7VGQgT9PtU14MOS3rrsVBotR76muYTk9xCXk2JX2fnK
qaJKLv59rX0bkXTqzrHZbBlWSzslaM9Ka4gdB3hIyLglIAmjXNRb2PKPb0HVA9Dw
a7vCLxGvv3wGPopTHd5/kED/XPh361VZP3OuNM9+qGsSPh/G4sgy031/6ABLx/i/
NyUKqY/+5CIx8uzMXKdytseNwBKh0oEaq6JbZ9o+9J6Uf5ZxonW5svSYhWPnr8ks
WbkH1+Ykxdz77w84WGL1EHjeR5FmeXECUcDviQ9UqHVJabpJManmSV1t4O+8uoev
x/1+/En9+1viEyUN4F+kbQFwb0a3icN+uF8LSz1GPOR4zJP/AKw7qec4vgcIXElm
MDGSRNss41pNcCGXQzqQ40fXtdbP+ZOQS1l4GqrLzwt0YKEmF/rAgCxMCfPtiQRI
BmUoTlTnpD/Yq7VudOXs8dNcH1Fmmfr1jGkEKTulcK8xyHbjxEMaJE19YSa7lnOy
A1jdfwuNmlY+aM+keUqST5gJDM0qiLTMizxiZwSR9faMefh2teKekLEbCSenJXxw
OEGlUBZ7EW1P6N6/IUO07Q5BJAcX+pgpj1u3lKYA/x+SxQscAh38F6k/Z44929UK
F50bBtIsGliRxdktknGA7lYuUJTuVCYulLHYCqP7ovxsOu7D9z8=
=116+
-----END PGP SIGNATURE-----

