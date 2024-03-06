Return-Path: <linux-kernel+bounces-94117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DA8873A36
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B391F26B58
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B68D13793F;
	Wed,  6 Mar 2024 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ox5ufsVr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1DC13792C;
	Wed,  6 Mar 2024 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709737546; cv=none; b=B4+z670u4+ltil6XQ3UuL75Hk8KTesnqon5XBEykZY98WOwhk47bD3kRGibP0pkWk2im9Ex/tCOsW2GvpJX73UtVGr8VT8mMYvzIe98SQ8QZJYR3onbmWaD1HwKIypHlT6kTtLJSgUdDD+5PBXHANWaELhSddL4SPS11qDg3dSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709737546; c=relaxed/simple;
	bh=cliSuK5W3de/4jN4vjaXVqslSoPFbPuxaGbFkk4dyoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VpqOvFX7OO0JtjerKa5p0P3VLG04Y8TCv6RrxgZszDwWgBphEKE7MTWGQEnRnEX/qxbGpVRotv1ZvvPzEWbWqn59kDBa5AbMc/jgiP5c8WbD2Q+wdSzZE2HhhbhF92rANvRBMpN2dvRsqJfsT4xDHEHZDyu2kdrYUMyS+TybnmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ox5ufsVr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855EEC433C7;
	Wed,  6 Mar 2024 15:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709737545;
	bh=cliSuK5W3de/4jN4vjaXVqslSoPFbPuxaGbFkk4dyoQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ox5ufsVr5A7eUIovQkW+tcf6ZgH2hahrdH920soS/8h0dQvgnIhIP/ubncSNYJ02h
	 hbLqNb95HYAby/bElm0LD5L9KOSTeCu1nazoIrsKL9IPsJftzm/YNv/C51K0AG6e9I
	 BzfXOU0zIB02xbYs4t4Iq7sFTMFbxiPOTBSY9B7o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.151
Date: Wed,  6 Mar 2024 15:05:39 +0000
Message-ID: <2024030640-stilt-carrot-f6cd@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 5.15.151 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                          |    2 
 arch/riscv/include/asm/pgtable.h                  |    2 
 arch/x86/kernel/cpu/intel.c                       |  178 ++++++------
 drivers/cpufreq/intel_pstate.c                    |    3 
 drivers/dma/fsl-qdma.c                            |   21 -
 drivers/dma/ptdma/ptdma-dmaengine.c               |    2 
 drivers/firmware/efi/capsule-loader.c             |    2 
 drivers/gpio/gpio-74x164.c                        |    4 
 drivers/gpio/gpiolib.c                            |   10 
 drivers/gpu/drm/bridge/lontium-lt8912b.c          |   11 
 drivers/interconnect/core.c                       |   18 -
 drivers/mmc/core/mmc.c                            |    2 
 drivers/mmc/host/sdhci-xenon-phy.c                |   48 ++-
 drivers/mtd/nand/spi/gigadevice.c                 |    6 
 drivers/net/ethernet/intel/igb/igb_ptp.c          |    5 
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |    4 
 drivers/net/gtp.c                                 |   12 
 drivers/net/tun.c                                 |    1 
 drivers/net/usb/dm9601.c                          |    2 
 drivers/net/usb/lan78xx.c                         |    3 
 drivers/net/veth.c                                |   40 +-
 drivers/power/supply/bq27xxx_battery_i2c.c        |    4 
 drivers/soc/qcom/rpmhpd.c                         |    7 
 drivers/video/fbdev/core/fbcon.c                  |    8 
 fs/afs/dir.c                                      |    4 
 fs/btrfs/dev-replace.c                            |   24 +
 fs/cachefiles/bind.c                              |    3 
 fs/hugetlbfs/inode.c                              |    6 
 include/linux/netfilter.h                         |   14 
 include/net/ipv6_stubs.h                          |    5 
 include/net/netfilter/nf_conntrack.h              |    8 
 include/net/strparser.h                           |    4 
 include/net/tls.h                                 |   11 
 include/uapi/linux/bpf.h                          |   37 ++
 include/uapi/linux/in6.h                          |    2 
 net/bluetooth/hci_core.c                          |    7 
 net/bluetooth/hci_event.c                         |   13 
 net/bluetooth/l2cap_core.c                        |    8 
 net/bridge/br_netfilter_hooks.c                   |   96 ++++++
 net/bridge/netfilter/nf_conntrack_bridge.c        |   30 ++
 net/core/filter.c                                 |   67 +++-
 net/core/rtnetlink.c                              |   11 
 net/ipv4/ip_tunnel.c                              |   28 +
 net/ipv4/netfilter/nf_reject_ipv4.c               |    1 
 net/ipv6/addrconf.c                               |    7 
 net/ipv6/af_inet6.c                               |    1 
 net/ipv6/netfilter/nf_reject_ipv6.c               |    1 
 net/mptcp/diag.c                                  |    3 
 net/mptcp/pm_netlink.c                            |   30 +-
 net/mptcp/protocol.c                              |  123 +++++++-
 net/mptcp/subflow.c                               |   36 --
 net/netfilter/core.c                              |   45 ++-
 net/netfilter/nf_conntrack_core.c                 |   21 +
 net/netfilter/nf_conntrack_netlink.c              |    4 
 net/netfilter/nf_conntrack_proto_tcp.c            |   35 ++
 net/netfilter/nf_nat_core.c                       |    2 
 net/netfilter/nf_tables_api.c                     |    7 
 net/netfilter/nfnetlink_queue.c                   |   10 
 net/netfilter/nft_compat.c                        |   20 +
 net/netlink/af_netlink.c                          |    2 
 net/tls/tls_device.c                              |    6 
 net/tls/tls_sw.c                                  |  310 ++++++++++------------
 net/unix/garbage.c                                |   22 -
 net/wireless/nl80211.c                            |    2 
 security/tomoyo/common.c                          |    3 
 sound/core/Makefile                               |    1 
 sound/firewire/amdtp-stream.c                     |    2 
 tools/include/uapi/linux/bpf.h                    |   37 ++
 tools/testing/selftests/net/mptcp/config          |    2 
 69 files changed, 984 insertions(+), 522 deletions(-)

Alexander Ofitserov (1):
      gtp: fix use-after-free and null-ptr-deref in gtp_newlink()

Andy Shevchenko (1):
      gpiolib: Fix the error path order in gpiochip_add_data_with_key()

Arnd Bergmann (1):
      efi/capsule-loader: fix incorrect allocation size

Arturas Moskvinas (1):
      gpio: 74x164: Enable output pins after registers are reset

Baokun Li (1):
      cachefiles: fix memory leak in cachefiles_add_cache()

Bartosz Golaszewski (1):
      gpio: fix resource unwinding order in error path

Bjorn Andersson (1):
      pmdomain: qcom: rpmhpd: Fix enabled_corner aggregation

Curtis Klein (1):
      dmaengine: fsl-qdma: init irq after reg initialization

David Howells (1):
      afs: Fix endless loop in directory parsing

David Sterba (1):
      btrfs: dev-replace: properly validate device names

Davide Caratti (1):
      mptcp: fix double-free on socket dismantle

Dimitris Vlachos (1):
      riscv: Sparse-Memory/vmemmap out-of-bounds fix

Doug Smythies (1):
      cpufreq: intel_pstate: fix pstate limits enforcement for adjust_perf call back

Elad Nachman (2):
      mmc: sdhci-xenon: add timeout for PHY init complete
      mmc: sdhci-xenon: fix PHY init clock stability

Eric Dumazet (1):
      ipv6: fix potential "struct net" leak in inet6_rtm_getaddr()

Florian Westphal (6):
      net: ip_tunnel: prevent perpetual headroom growth
      netfilter: nfnetlink_queue: silence bogus compiler warning
      netfilter: core: move ip_ct_attach indirection to struct nf_ct_hook
      netfilter: make function op structures const
      netfilter: let reset rules clean out conntrack entries
      netfilter: bridge: confirm multicast packets before passing them up the stack

Gal Pressman (1):
      Revert "tls: rx: move counting TlsDecryptErrors for sync"

Geliang Tang (1):
      mptcp: add needs_id for netlink appending addr

Greg Kroah-Hartman (3):
      Revert "interconnect: Fix locking for runpm vs reclaim"
      Revert "interconnect: Teach lockdep about icc_bw_lock order"
      Linux 5.15.151

Han Xu (1):
      mtd: spinand: gigadevice: Fix the get ecc status issue

Hans de Goede (1):
      power: supply: bq27xxx-i2c: Do not free non existing IRQ

Ignat Korchagin (1):
      netfilter: nf_tables: allow NFPROTO_INET in nft_(match/target)_validate()

Ivan Semenov (1):
      mmc: core: Fix eMMC initialization with 1-bit bus connection

Jakub Kicinski (16):
      net: veth: clear GRO when clearing XDP even when down
      veth: try harder when allocating queue memory
      tls: rx: don't store the record type in socket context
      tls: rx: don't store the decryption status in socket context
      tls: rx: don't issue wake ups when data is decrypted
      tls: rx: refactor decrypt_skb_update()
      tls: hw: rx: use return value of tls_device_decrypted() to carry status
      tls: rx: drop unnecessary arguments from tls_setup_from_iter()
      tls: rx: don't report text length from the bowels of decrypt
      tls: rx: wrap decryption arguments in a structure
      tls: rx: factor out writing ContentType to cmsg
      tls: rx: don't track the async count
      tls: rx: move counting TlsDecryptErrors for sync
      tls: rx: assume crypto always calls our callback
      tls: rx: use async as an in-out argument
      net: tls: fix async vs NIC crypto offload

Jakub Raczynski (1):
      stmmac: Clear variable when destroying workqueue

Javier Carrasco (1):
      net: usb: dm9601: fix wrong return value in dm9601_mdio_read

Jean Sacren (1):
      mptcp: clean up harmless false expressions

Jiri Slaby (SUSE) (1):
      fbcon: always restore the old font data in fbcon_do_set_font()

Johannes Berg (1):
      wifi: nl80211: reject iftype change with mesh ID change

Justin Iurman (1):
      uapi: in6: replace temporary label with rfc9486

Kai-Heng Feng (1):
      Bluetooth: Enforce validation on max value of connection interval

Kuniyuki Iwashima (1):
      af_unix: Drop oob_skb ref before purging queue in GC.

Lin Ma (1):
      rtnetlink: fix error logic of IFLA_BRIDGE_FLAGS writing back

Louis DeLosSantos (1):
      bpf: Add table ID to bpf_fib_lookup BPF helper

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Fix handling of HCI_EV_IO_CAPA_REQUEST

Martin KaFai Lau (1):
      bpf: Add BPF_FIB_LOOKUP_SKIP_NEIGH for bpf_fib_lookup

Martynas Pumputis (1):
      bpf: Derive source IP addr via bpf_*_fib_lookup()

Matthieu Baerts (NGI0) (2):
      selftests: mptcp: add missing kconfig for NF Filter
      selftests: mptcp: add missing kconfig for NF Filter in v6

Max Krummenacher (1):
      Revert "drm/bridge: lt8912b: Register and attach our DSI device at probe"

Oleksij Rempel (2):
      lan78xx: enable auto speed configuration for LAN7850 if no EEPROM is detected
      igb: extend PTP timestamp adjustments to i211

Oscar Salvador (1):
      fs,hugetlb: fix NULL pointer dereference in hugetlbs_fill_super

Pablo Neira Ayuso (1):
      netfilter: nf_tables: disallow timeout for anonymous sets

Paolo Abeni (5):
      mptcp: move __mptcp_error_report in protocol.c
      mptcp: process pending subflow error on close
      mptcp: rename timer related helper to less confusing names
      mptcp: push at DSS boundaries
      mptcp: fix possible deadlock in subflow diag

Paolo Bonzini (1):
      x86/cpu/intel: Detect TME keyid bits before setting MTRR mask registers

Peng Ma (1):
      dmaengine: fsl-qdma: fix SoC may hang on 16 byte unaligned read

Ryosuke Yasuoka (1):
      netlink: Fix kernel-infoleak-after-free in __skb_datagram_iter

Sabrina Dubroca (1):
      tls: decrement decrypt_pending if no async completion will be called

Tadeusz Struk (1):
      dmaengine: ptdma: use consistent DMA masks

Takashi Iwai (1):
      ALSA: Drop leftover snd-rtctimer stuff from Makefile

Takashi Sakamoto (1):
      ALSA: firewire-lib: fix to check cycle continuity

Tetsuo Handa (1):
      tomoyo: fix UAF write bug in tomoyo_write_control()

Vasily Averin (1):
      net: enable memcg accounting for veth queues

Ying Hsu (1):
      Bluetooth: Avoid potential use-after-free in hci_error_reset

Yunjian Wang (1):
      tun: Fix xdp_rxq_info's queue_index when detaching

Zijun Hu (1):
      Bluetooth: hci_event: Fix wrongly recorded wakeup BD_ADDR


