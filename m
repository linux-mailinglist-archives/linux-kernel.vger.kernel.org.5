Return-Path: <linux-kernel+bounces-91330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1980870F57
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711E31F22D6B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C90D7AE6B;
	Mon,  4 Mar 2024 21:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eTA5GrOm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A311C6AB;
	Mon,  4 Mar 2024 21:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709589215; cv=none; b=B9ggAXfssvfsfCJZtDzpvw3GEbFzEr0efN23IOm+2zjLiz1MsMtLh9xRsYVQJ0wbS5x7q7404clyyIXAOWvKIjMyELEg+8aV/Vb0iZsFbfZjMbrjrYBWmMWg5jTTRuXyyW5BH1vtydEosbNkYWNHHhhuwBntVZSdu23D3HSPQ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709589215; c=relaxed/simple;
	bh=bcFGcn/7wASYM0Bt2yGKIfKcLYHWUytcLvEknlx+63Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sHgpRzR2/lB9CXp6o/8s7yByYmYhqmKHU1BAtorx5S5pCUKr3z+mV147W+/M6EARd0pDqXN0HnFGyoZ3Rxd+S1/TqEaXjxgmJbsuPQTzP+wB+LLpmzqvJHJVzmkvdxbRminSgJbYrAzmNAKVtP/AJgZm2YQ5eZzsJdF/BO2d0o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eTA5GrOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F2DC433F1;
	Mon,  4 Mar 2024 21:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709589215;
	bh=bcFGcn/7wASYM0Bt2yGKIfKcLYHWUytcLvEknlx+63Y=;
	h=From:To:Cc:Subject:Date:From;
	b=eTA5GrOmCbMeUhWaaCKzUjy/4Tvz0NAJFbb5RAxJZ8O5e4sxsy/WHijXnyt3VN8yo
	 86DMFDdV67UEcrM9SWn36fVaEjSH5kcapptgVWhHonPX0gaW3dDRzxtC9NI03jJCUk
	 mcW9lsBSP5OT8DQMGxSzwYFSboLnmTYuMwjFdBko=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com
Subject: [PATCH 5.15 00/84] 5.15.151-rc1 review
Date: Mon,  4 Mar 2024 21:23:33 +0000
Message-ID: <20240304211542.332206551@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.151-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.151-rc1
X-KernelTest-Deadline: 2024-03-06T21:15+00:00
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.15.151 release.
There are 84 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.151-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.151-rc1

Davide Caratti <dcaratti@redhat.com>
    mptcp: fix double-free on socket dismantle

Gal Pressman <gal@nvidia.com>
    Revert "tls: rx: move counting TlsDecryptErrors for sync"

Jakub Kicinski <kuba@kernel.org>
    net: tls: fix async vs NIC crypto offload

Martynas Pumputis <m@lambda.lt>
    bpf: Derive source IP addr via bpf_*_fib_lookup()

Louis DeLosSantos <louis.delos.devel@gmail.com>
    bpf: Add table ID to bpf_fib_lookup BPF helper

Martin KaFai Lau <martin.lau@kernel.org>
    bpf: Add BPF_FIB_LOOKUP_SKIP_NEIGH for bpf_fib_lookup

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "interconnect: Teach lockdep about icc_bw_lock order"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "interconnect: Fix locking for runpm vs reclaim"

Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
    gpio: fix resource unwinding order in error path

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    gpiolib: Fix the error path order in gpiochip_add_data_with_key()

Arturas Moskvinas <arturas.moskvinas@gmail.com>
    gpio: 74x164: Enable output pins after registers are reset

Kuniyuki Iwashima <kuniyu@amazon.com>
    af_unix: Drop oob_skb ref before purging queue in GC.

Max Krummenacher <max.krummenacher@toradex.com>
    Revert "drm/bridge: lt8912b: Register and attach our DSI device at probe"

Oscar Salvador <osalvador@suse.de>
    fs,hugetlb: fix NULL pointer dereference in hugetlbs_fill_super

Baokun Li <libaokun1@huawei.com>
    cachefiles: fix memory leak in cachefiles_add_cache()

Paolo Abeni <pabeni@redhat.com>
    mptcp: fix possible deadlock in subflow diag

Paolo Abeni <pabeni@redhat.com>
    mptcp: push at DSS boundaries

Geliang Tang <tanggeliang@kylinos.cn>
    mptcp: add needs_id for netlink appending addr

Jean Sacren <sakiwit@gmail.com>
    mptcp: clean up harmless false expressions

Matthieu Baerts (NGI0) <matttbe@kernel.org>
    selftests: mptcp: add missing kconfig for NF Filter in v6

Matthieu Baerts (NGI0) <matttbe@kernel.org>
    selftests: mptcp: add missing kconfig for NF Filter

Paolo Abeni <pabeni@redhat.com>
    mptcp: rename timer related helper to less confusing names

Paolo Abeni <pabeni@redhat.com>
    mptcp: process pending subflow error on close

Paolo Abeni <pabeni@redhat.com>
    mptcp: move __mptcp_error_report in protocol.c

Paolo Bonzini <pbonzini@redhat.com>
    x86/cpu/intel: Detect TME keyid bits before setting MTRR mask registers

Bjorn Andersson <quic_bjorande@quicinc.com>
    pmdomain: qcom: rpmhpd: Fix enabled_corner aggregation

Zong Li <zong.li@sifive.com>
    riscv: add CALLER_ADDRx support

Elad Nachman <enachman@marvell.com>
    mmc: sdhci-xenon: fix PHY init clock stability

Elad Nachman <enachman@marvell.com>
    mmc: sdhci-xenon: add timeout for PHY init complete

Ivan Semenov <ivan@semenov.dev>
    mmc: core: Fix eMMC initialization with 1-bit bus connection

Curtis Klein <curtis.klein@hpe.com>
    dmaengine: fsl-qdma: init irq after reg initialization

Tadeusz Struk <tstruk@gigaio.com>
    dmaengine: ptdma: use consistent DMA masks

Peng Ma <peng.ma@nxp.com>
    dmaengine: fsl-qdma: fix SoC may hang on 16 byte unaligned read

David Sterba <dsterba@suse.com>
    btrfs: dev-replace: properly validate device names

Johannes Berg <johannes.berg@intel.com>
    wifi: nl80211: reject iftype change with mesh ID change

Alexander Ofitserov <oficerovas@altlinux.org>
    gtp: fix use-after-free and null-ptr-deref in gtp_newlink()

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: firewire-lib: fix to check cycle continuity

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    tomoyo: fix UAF write bug in tomoyo_write_control()

Dimitris Vlachos <dvlachos@ics.forth.gr>
    riscv: Sparse-Memory/vmemmap out-of-bounds fix

David Howells <dhowells@redhat.com>
    afs: Fix endless loop in directory parsing

Jiri Slaby (SUSE) <jirislaby@kernel.org>
    fbcon: always restore the old font data in fbcon_do_set_font()

Takashi Iwai <tiwai@suse.de>
    ALSA: Drop leftover snd-rtctimer stuff from Makefile

Hans de Goede <hdegoede@redhat.com>
    power: supply: bq27xxx-i2c: Do not free non existing IRQ

Arnd Bergmann <arnd@arndb.de>
    efi/capsule-loader: fix incorrect allocation size

Sabrina Dubroca <sd@queasysnail.net>
    tls: decrement decrypt_pending if no async completion will be called

Jakub Kicinski <kuba@kernel.org>
    tls: rx: use async as an in-out argument

Jakub Kicinski <kuba@kernel.org>
    tls: rx: assume crypto always calls our callback

Jakub Kicinski <kuba@kernel.org>
    tls: rx: move counting TlsDecryptErrors for sync

Jakub Kicinski <kuba@kernel.org>
    tls: rx: don't track the async count

Jakub Kicinski <kuba@kernel.org>
    tls: rx: factor out writing ContentType to cmsg

Jakub Kicinski <kuba@kernel.org>
    tls: rx: wrap decryption arguments in a structure

Jakub Kicinski <kuba@kernel.org>
    tls: rx: don't report text length from the bowels of decrypt

Jakub Kicinski <kuba@kernel.org>
    tls: rx: drop unnecessary arguments from tls_setup_from_iter()

Jakub Kicinski <kuba@kernel.org>
    tls: hw: rx: use return value of tls_device_decrypted() to carry status

Jakub Kicinski <kuba@kernel.org>
    tls: rx: refactor decrypt_skb_update()

Jakub Kicinski <kuba@kernel.org>
    tls: rx: don't issue wake ups when data is decrypted

Jakub Kicinski <kuba@kernel.org>
    tls: rx: don't store the decryption status in socket context

Jakub Kicinski <kuba@kernel.org>
    tls: rx: don't store the record type in socket context

Oleksij Rempel <linux@rempel-privat.de>
    igb: extend PTP timestamp adjustments to i211

Lin Ma <linma@zju.edu.cn>
    rtnetlink: fix error logic of IFLA_BRIDGE_FLAGS writing back

Florian Westphal <fw@strlen.de>
    netfilter: bridge: confirm multicast packets before passing them up the stack

Florian Westphal <fw@strlen.de>
    netfilter: let reset rules clean out conntrack entries

Florian Westphal <fw@strlen.de>
    netfilter: make function op structures const

Florian Westphal <fw@strlen.de>
    netfilter: core: move ip_ct_attach indirection to struct nf_ct_hook

Florian Westphal <fw@strlen.de>
    netfilter: nfnetlink_queue: silence bogus compiler warning

Ignat Korchagin <ignat@cloudflare.com>
    netfilter: nf_tables: allow NFPROTO_INET in nft_(match/target)_validate()

Kai-Heng Feng <kai.heng.feng@canonical.com>
    Bluetooth: Enforce validation on max value of connection interval

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: hci_event: Fix handling of HCI_EV_IO_CAPA_REQUEST

Zijun Hu <quic_zijuhu@quicinc.com>
    Bluetooth: hci_event: Fix wrongly recorded wakeup BD_ADDR

Ying Hsu <yinghsu@chromium.org>
    Bluetooth: Avoid potential use-after-free in hci_error_reset

Jakub Raczynski <j.raczynski@samsung.com>
    stmmac: Clear variable when destroying workqueue

Justin Iurman <justin.iurman@uliege.be>
    uapi: in6: replace temporary label with rfc9486

Javier Carrasco <javier.carrasco.cruz@gmail.com>
    net: usb: dm9601: fix wrong return value in dm9601_mdio_read

Jakub Kicinski <kuba@kernel.org>
    veth: try harder when allocating queue memory

Vasily Averin <vvs@openvz.org>
    net: enable memcg accounting for veth queues

Oleksij Rempel <linux@rempel-privat.de>
    lan78xx: enable auto speed configuration for LAN7850 if no EEPROM is detected

Eric Dumazet <edumazet@google.com>
    ipv6: fix potential "struct net" leak in inet6_rtm_getaddr()

Jakub Kicinski <kuba@kernel.org>
    net: veth: clear GRO when clearing XDP even when down

Doug Smythies <dsmythies@telus.net>
    cpufreq: intel_pstate: fix pstate limits enforcement for adjust_perf call back

Yunjian Wang <wangyunjian@huawei.com>
    tun: Fix xdp_rxq_info's queue_index when detaching

Florian Westphal <fw@strlen.de>
    net: ip_tunnel: prevent perpetual headroom growth

Ryosuke Yasuoka <ryasuoka@redhat.com>
    netlink: Fix kernel-infoleak-after-free in __skb_datagram_iter

Han Xu <han.xu@nxp.com>
    mtd: spinand: gigadevice: Fix the get ecc status issue

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: disallow timeout for anonymous sets


-------------

Diffstat:

 Makefile                                          |   4 +-
 arch/riscv/include/asm/ftrace.h                   |   5 +
 arch/riscv/include/asm/pgtable.h                  |   2 +-
 arch/riscv/kernel/Makefile                        |   2 +
 arch/riscv/kernel/return_address.c                |  48 ++++
 arch/x86/kernel/cpu/intel.c                       | 178 ++++++------
 drivers/cpufreq/intel_pstate.c                    |   3 +
 drivers/dma/fsl-qdma.c                            |  25 +-
 drivers/dma/ptdma/ptdma-dmaengine.c               |   2 -
 drivers/firmware/efi/capsule-loader.c             |   2 +-
 drivers/gpio/gpio-74x164.c                        |   4 +-
 drivers/gpio/gpiolib.c                            |  12 +-
 drivers/gpu/drm/bridge/lontium-lt8912b.c          |  11 +-
 drivers/interconnect/core.c                       |  18 +-
 drivers/mmc/core/mmc.c                            |   2 +
 drivers/mmc/host/sdhci-xenon-phy.c                |  48 +++-
 drivers/mtd/nand/spi/gigadevice.c                 |   6 +-
 drivers/net/ethernet/intel/igb/igb_ptp.c          |   5 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |   4 +-
 drivers/net/gtp.c                                 |  12 +-
 drivers/net/tun.c                                 |   1 +
 drivers/net/usb/dm9601.c                          |   2 +-
 drivers/net/usb/lan78xx.c                         |   3 +-
 drivers/net/veth.c                                |  40 +--
 drivers/power/supply/bq27xxx_battery_i2c.c        |   4 +-
 drivers/soc/qcom/rpmhpd.c                         |   7 +-
 drivers/video/fbdev/core/fbcon.c                  |   8 +-
 fs/afs/dir.c                                      |   4 +-
 fs/btrfs/dev-replace.c                            |  24 +-
 fs/cachefiles/bind.c                              |   3 +
 fs/hugetlbfs/inode.c                              |   6 +-
 include/linux/netfilter.h                         |  14 +-
 include/net/ipv6_stubs.h                          |   5 +
 include/net/netfilter/nf_conntrack.h              |   8 +
 include/net/strparser.h                           |   4 +
 include/net/tls.h                                 |  11 +-
 include/uapi/linux/bpf.h                          |  37 ++-
 include/uapi/linux/in6.h                          |   2 +-
 net/bluetooth/hci_core.c                          |   7 +-
 net/bluetooth/hci_event.c                         |  13 +-
 net/bluetooth/l2cap_core.c                        |   8 +-
 net/bridge/br_netfilter_hooks.c                   |  96 +++++++
 net/bridge/netfilter/nf_conntrack_bridge.c        |  30 ++
 net/core/filter.c                                 |  67 ++++-
 net/core/rtnetlink.c                              |  11 +-
 net/ipv4/ip_tunnel.c                              |  28 +-
 net/ipv4/netfilter/nf_reject_ipv4.c               |   1 +
 net/ipv6/addrconf.c                               |   7 +-
 net/ipv6/af_inet6.c                               |   1 +
 net/ipv6/netfilter/nf_reject_ipv6.c               |   1 +
 net/mptcp/diag.c                                  |   3 +
 net/mptcp/pm_netlink.c                            |  30 +-
 net/mptcp/protocol.c                              | 123 +++++++--
 net/mptcp/subflow.c                               |  36 ---
 net/netfilter/core.c                              |  45 +--
 net/netfilter/nf_conntrack_core.c                 |  21 +-
 net/netfilter/nf_conntrack_netlink.c              |   4 +-
 net/netfilter/nf_conntrack_proto_tcp.c            |  35 +++
 net/netfilter/nf_nat_core.c                       |   2 +-
 net/netfilter/nf_tables_api.c                     |   7 +
 net/netfilter/nfnetlink_queue.c                   |  10 +-
 net/netfilter/nft_compat.c                        |  20 ++
 net/netlink/af_netlink.c                          |   2 +-
 net/tls/tls_device.c                              |   6 +-
 net/tls/tls_sw.c                                  | 316 ++++++++++------------
 net/unix/garbage.c                                |  22 +-
 net/wireless/nl80211.c                            |   2 +
 security/tomoyo/common.c                          |   3 +-
 sound/core/Makefile                               |   1 -
 sound/firewire/amdtp-stream.c                     |   2 +-
 tools/include/uapi/linux/bpf.h                    |  37 ++-
 tools/testing/selftests/net/mptcp/config          |   2 +
 72 files changed, 1046 insertions(+), 529 deletions(-)



