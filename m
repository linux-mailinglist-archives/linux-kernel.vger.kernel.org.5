Return-Path: <linux-kernel+bounces-8582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A9681B9BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205AE1C242FA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876611D6A9;
	Thu, 21 Dec 2023 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLTm5/j9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198AD360AE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703169703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OlbaQf4LUULkeplImJ1JZak1wRpgwcAC/tvF/dEg/mU=;
	b=KLTm5/j9qNUBP16Wzw0QV2iCDUf2D5+7+H6lh4k8f1Lf75FGPmkXj/EkiOjXXJe6tLZ5vV
	YNlzd/zV63IiCje2mryYy+5sF8kNoOjQZLan9UinK2eDDrDQXf39jAkMbdypqUV03pr+Ku
	1OO2ho50M4auAbvH+SQ9Br7CzGEqyLs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-mj0F3z1PPRGFzhq6A6-JAA-1; Thu, 21 Dec 2023 09:41:40 -0500
X-MC-Unique: mj0F3z1PPRGFzhq6A6-JAA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8E0185A589;
	Thu, 21 Dec 2023 14:41:39 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 334AF51D5;
	Thu, 21 Dec 2023 14:41:38 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.7-rc7
Date: Thu, 21 Dec 2023 15:41:31 +0100
Message-ID: <20231221144131.366000-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Hi Linus!

We are not aware of any standing regressions, and we do not
plan to send a PR next week - unless very bad things happen.

Let me leverage this opportunity to wish you a merry winter
holiday and happy new year!

The following changes since commit c7402612e2e61b76177f22e6e7f705adcbecc6fe:

  Merge tag 'net-6.7-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-12-14 13:11:49 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.7-rc7

for you to fetch changes up to 74769d810ead7e7af1a481f07a4d890861a6a4cc:

  Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2023-12-21 12:27:29 +0100)

----------------------------------------------------------------
Including fixes from WiFi and bpf.

Current release - regressions:

  - bpf: syzkaller found null ptr deref in unix_bpf proto add

  - eth: i40e: fix ST code value for clause 45

Previous releases - regressions:

  - core: return error from sk_stream_wait_connect() if sk_wait_event() fails

  - ipv6: revert remove expired routes with a separated list of routes

  - wifi rfkill:
    - set GPIO direction
    - fix crash with WED rx support enabled

  - bluetooth:
    - fix deadlock in vhci_send_frame
    - fix use-after-free in bt_sock_recvmsg

  - eth: mlx5e: fix a race in command alloc flow

  - eth: ice: fix PF with enabled XDP going no-carrier after reset

  - eth: bnxt_en: do not map packet buffers twice

Previous releases - always broken:

  - core:
    - check vlan filter feature in vlan_vids_add_by_dev() and vlan_vids_del_by_dev()
    - check dev->gso_max_size in gso_features_check()

  - mptcp: fix inconsistent state on fastopen race

  - phy: skip LED triggers on PHYs on SFP modules

  - eth: mlx5e:
    - fix double free of encap_header
    - fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list()

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alex Lu (1):
      Bluetooth: Add more enc key size check

Andy Gospodarek (1):
      bnxt_en: do not map packet buffers twice

Arnd Bergmann (1):
      Bluetooth: hci_event: shut up a false-positive warning

Avraham Stern (1):
      wifi: iwlwifi: pcie: avoid a NULL pointer dereference

Carolina Jubran (1):
      net/mlx5e: XDP, Drop fragmented packets larger than MTU size

Chen-Yu Tsai (1):
      wifi: cfg80211: Add my certificate

Chris Mi (1):
      net/mlx5e: Decrease num_block_tc when unblock tc offload

Dan Carpenter (2):
      net/mlx5e: Fix error code in mlx5e_tc_action_miss_mapping_get()
      net/mlx5e: Fix error codes in alloc_branch_attr()

Daniel Golle (1):
      net: phy: skip LED triggers on PHYs on SFP modules

Dave Ertman (1):
      ice: alter feature support check for SRIOV and LAG

David Ahern (1):
      net/ipv6: Revert remove expired routes with a separated list of routes

David S. Miller (2):
      Merge branch 'mptcp-misc-fixes'
      Merge tag 'for-net-2023-12-15' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth

Dinghao Liu (1):
      net/mlx5e: fix a potential double-free in fs_udp_create_groups

Edward Adam Davis (1):
      wifi: mac80211: check if the existing link config remains unchanged

Eric Dumazet (3):
      net: sched: ife: fix potential use-after-free
      net/rose: fix races in rose_kill_by_device()
      net: check dev->gso_max_size in gso_features_check()

Felix Fietkau (1):
      wifi: mt76: fix crash with WED rx support enabled

Frédéric Danis (1):
      Bluetooth: L2CAP: Send reject on command corrupted request

Geliang Tang (2):
      selftests: mptcp: join: fix subflow_send_ack lookup
      mailmap: add entries for Geliang Tang

Hangbin Liu (1):
      kselftest: rtnetlink.sh: use grep_fail when expecting the cmd fail

Hyunwoo Kim (1):
      Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg

Ivan Vecera (1):
      i40e: Fix ST code value for Clause 45

Jacob Keller (1):
      ice: stop trashing VF VSI aggregator node ID information

Jakub Kicinski (3):
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'mlx5-fixes-2023-12-13' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge tag 'wireless-2023-12-14' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

Jianbo Liu (1):
      net/mlx5e: Fix overrun reported by coverity

Jijie Shao (1):
      net: hns3: add new maintainer for the HNS3 ethernet driver

Jiri Olsa (1):
      bpf: Add missing BPF_LINK_TYPE invocations

Johannes Berg (7):
      wifi: ieee80211: don't require protected vendor action frames
      wifi: iwlwifi: pcie: add another missing bh-disable for rxq->lock
      wifi: mac80211: don't re-add debugfs during reconfig
      wifi: mac80211: check defragmentation succeeded
      wifi: mac80211: mesh: check element parsing succeeded
      wifi: mac80211: mesh_plink: fix matches_local logic
      wifi: cfg80211: fix certs build to not depend on file order

John Fastabend (2):
      bpf: syzkaller found null ptr deref in unix_bpf proto add
      bpf: sockmap, test for unconnected af_unix sock

Lai Peter Jun Ann (1):
      net: stmmac: fix incorrect flag check in timestamp interrupt

Larysa Zaremba (1):
      ice: Fix PF with enabled XDP going no-carrier after reset

Liu Jian (2):
      net: check vlan filter feature in vlan_vids_add_by_dev() and vlan_vids_del_by_dev()
      selftests: add vlan hw filter tests

Lorenzo Bianconi (1):
      net: ethernet: mtk_wed: fix possible NULL pointer dereference in mtk_wed_wo_queue_tx_clean()

Luiz Augusto von Dentz (3):
      Bluetooth: Fix not notifying when connection encryption changes
      Bluetooth: hci_event: Fix not checking if HCI_OP_INQUIRY has been sent
      Bluetooth: hci_core: Fix hci_conn_hash_lookup_cis

Martin KaFai Lau (1):
      Merge branch ' bpf fix for unconnect af_unix socket'

Matthieu Baerts (1):
      mptcp: fill in missing MODULE_DESCRIPTION()

Michal Schmidt (1):
      ice: fix theoretical out-of-bounds access in ethtool link modes

Moshe Shemesh (1):
      net/mlx5: Fix fw tracer first block check

Paolo Abeni (4):
      mptcp: fix inconsistent state on fastopen race
      Merge branch 'check-vlan-filter-feature-in-vlan_vids_add_by_dev-and-vlan_vids_del_by_dev'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf

Rahul Rameshbabu (2):
      net/mlx5e: Correct snprintf truncation handling for fw_version buffer
      net/mlx5e: Correct snprintf truncation handling for fw_version buffer used by representors

Ronald Wahl (1):
      net: ks8851: Fix TX stall caused by TX buffer overrun

Rouven Czerwinski (1):
      net: rfkill: gpio: set GPIO direction

Shifeng Li (2):
      net/mlx5e: Fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list()
      net/mlx5e: Fix a race in command alloc flow

Shigeru Yoshida (1):
      net: Return error from sk_stream_wait_connect() if sk_wait_event() fails

Suman Ghosh (1):
      octeontx2-pf: Fix graceful exit during PFC configuration failure

Thomas Weißschuh (1):
      net: avoid build bug in skb extension length calculation

Vlad Buslov (4):
      Revert "net/mlx5e: fix double free of encap_header in update funcs"
      Revert "net/mlx5e: fix double free of encap_header"
      net/mlx5e: fix double free of encap_header
      net/mlx5: Refactor mlx5_flow_destination->rep pointer to vport num

Vladimir Oltean (2):
      net: mscc: ocelot: fix eMAC TX RMON stats for bucket 256-511 and above
      net: mscc: ocelot: fix pMAC TX RMON stats for bucket 256-511 and above

Xiao Yao (1):
      Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE

Ying Hsu (1):
      Bluetooth: Fix deadlock in vhci_send_frame

Yury Norov (1):
      net: mana: select PAGE_POOL

Zhipeng Lu (1):
      ethernet: atheros: fix a memleak in atl1e_setup_ring_resources

duanqiangwen (1):
      net: libwx: fix memory leak on free page

 .mailmap                                           |  4 +
 MAINTAINERS                                        |  1 +
 drivers/bluetooth/hci_vhci.c                       | 10 ++-
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c    |  5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      | 11 +--
 drivers/net/ethernet/intel/i40e/i40e_register.h    |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h        |  4 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  4 +-
 drivers/net/ethernet/intel/ice/ice_lag.c           |  2 +
 drivers/net/ethernet/intel/ice/ice_lib.c           |  7 +-
 .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c    | 17 ++++-
 drivers/net/ethernet/mediatek/mtk_wed_wo.c         |  3 +
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      | 12 +--
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |  2 +-
 .../mellanox/mlx5/core/en/fs_tt_redirect.c         |  1 +
 .../ethernet/mellanox/mlx5/core/en/tc/act/mirred.c |  5 +-
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.c    | 50 +++++++------
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |  3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |  4 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    | 10 ++-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |  3 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c | 31 +++++---
 .../mellanox/mlx5/core/eswitch_offloads_termtbl.c  |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |  2 +-
 drivers/net/ethernet/micrel/ks8851.h               |  3 +
 drivers/net/ethernet/micrel/ks8851_common.c        | 20 ++---
 drivers/net/ethernet/micrel/ks8851_spi.c           | 42 +++++++----
 drivers/net/ethernet/microsoft/Kconfig             |  1 +
 drivers/net/ethernet/mscc/ocelot_stats.c           | 16 ++--
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  |  2 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        | 82 ++------------------
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |  1 -
 drivers/net/phy/phy_device.c                       |  6 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |  4 +-
 drivers/net/wireless/mediatek/mt76/dma.c           | 10 ++-
 include/linux/bpf_types.h                          |  4 +
 include/linux/ieee80211.h                          |  3 +-
 include/net/bluetooth/hci_core.h                   |  9 ++-
 include/net/ip6_fib.h                              | 64 ++++------------
 include/net/sock.h                                 |  5 ++
 net/8021q/vlan_core.c                              |  9 ++-
 net/bluetooth/af_bluetooth.c                       |  7 +-
 net/bluetooth/hci_event.c                          | 30 +++++---
 net/bluetooth/l2cap_core.c                         | 21 ++++--
 net/bluetooth/mgmt.c                               | 25 +++++--
 net/bluetooth/smp.c                                |  7 ++
 net/core/dev.c                                     |  3 +
 net/core/skbuff.c                                  |  2 +
 net/core/sock_map.c                                |  2 +
 net/core/stream.c                                  |  2 +-
 net/ife/ife.c                                      |  1 +
 net/ipv6/ip6_fib.c                                 | 55 ++------------
 net/ipv6/route.c                                   |  6 +-
 net/mac80211/cfg.c                                 |  4 +-
 net/mac80211/driver-ops.c                          |  6 +-
 net/mac80211/mesh_plink.c                          | 16 ++--
 net/mac80211/mlme.c                                |  4 +-
 net/mptcp/crypto_test.c                            |  1 +
 net/mptcp/protocol.c                               |  6 +-
 net/mptcp/protocol.h                               |  9 ++-
 net/mptcp/subflow.c                                | 28 ++++---
 net/mptcp/token_test.c                             |  1 +
 net/rfkill/rfkill-gpio.c                           |  8 ++
 net/rose/af_rose.c                                 | 39 ++++++++--
 net/wireless/certs/wens.hex                        | 87 ++++++++++++++++++++++
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 34 +++++++++
 tools/testing/selftests/net/Makefile               |  1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  8 +-
 tools/testing/selftests/net/rtnetlink.sh           |  2 +-
 tools/testing/selftests/net/vlan_hw_filter.sh      | 29 ++++++++
 74 files changed, 561 insertions(+), 369 deletions(-)
 create mode 100644 net/wireless/certs/wens.hex
 create mode 100755 tools/testing/selftests/net/vlan_hw_filter.sh
The following changes since commit c7402612e2e61b76177f22e6e7f705adcbecc6fe:

  Merge tag 'net-6.7-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-12-14 13:11:49 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.7-rc7

for you to fetch changes up to 74769d810ead7e7af1a481f07a4d890861a6a4cc:

  Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2023-12-21 12:27:29 +0100)

----------------------------------------------------------------
Including fixes from WiFi and bpf.

Current release - regressions:

  - bpf: syzkaller found null ptr deref in unix_bpf proto add

  - eth: i40e: fix ST code value for clause 45

Previous releases - regressions:

  - core: return error from sk_stream_wait_connect() if sk_wait_event() fails

  - ipv6: revert remove expired routes with a separated list of routes

  - wifi rfkill:
    - set GPIO direction
    - fix crash with WED rx support enabled

  - bluetooth:
    - fix deadlock in vhci_send_frame
    - fix use-after-free in bt_sock_recvmsg

  - eth: mlx5e: fix a race in command alloc flow

  - eth: ice: fix PF with enabled XDP going no-carrier after reset

  - eth: bnxt_en: do not map packet buffers twice

Previous releases - always broken:

  - core:
    - check vlan filter feature in vlan_vids_add_by_dev() and vlan_vids_del_by_dev()
    - check dev->gso_max_size in gso_features_check()

  - mptcp: fix inconsistent state on fastopen race

  - phy: skip LED triggers on PHYs on SFP modules

  - eth: mlx5e:
    - fix double free of encap_header
    - fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list()

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alex Lu (1):
      Bluetooth: Add more enc key size check

Andy Gospodarek (1):
      bnxt_en: do not map packet buffers twice

Arnd Bergmann (1):
      Bluetooth: hci_event: shut up a false-positive warning

Avraham Stern (1):
      wifi: iwlwifi: pcie: avoid a NULL pointer dereference

Carolina Jubran (1):
      net/mlx5e: XDP, Drop fragmented packets larger than MTU size

Chen-Yu Tsai (1):
      wifi: cfg80211: Add my certificate

Chris Mi (1):
      net/mlx5e: Decrease num_block_tc when unblock tc offload

Dan Carpenter (2):
      net/mlx5e: Fix error code in mlx5e_tc_action_miss_mapping_get()
      net/mlx5e: Fix error codes in alloc_branch_attr()

Daniel Golle (1):
      net: phy: skip LED triggers on PHYs on SFP modules

Dave Ertman (1):
      ice: alter feature support check for SRIOV and LAG

David Ahern (1):
      net/ipv6: Revert remove expired routes with a separated list of routes

David S. Miller (2):
      Merge branch 'mptcp-misc-fixes'
      Merge tag 'for-net-2023-12-15' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth

Dinghao Liu (1):
      net/mlx5e: fix a potential double-free in fs_udp_create_groups

Edward Adam Davis (1):
      wifi: mac80211: check if the existing link config remains unchanged

Eric Dumazet (3):
      net: sched: ife: fix potential use-after-free
      net/rose: fix races in rose_kill_by_device()
      net: check dev->gso_max_size in gso_features_check()

Felix Fietkau (1):
      wifi: mt76: fix crash with WED rx support enabled

Frédéric Danis (1):
      Bluetooth: L2CAP: Send reject on command corrupted request

Geliang Tang (2):
      selftests: mptcp: join: fix subflow_send_ack lookup
      mailmap: add entries for Geliang Tang

Hangbin Liu (1):
      kselftest: rtnetlink.sh: use grep_fail when expecting the cmd fail

Hyunwoo Kim (1):
      Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg

Ivan Vecera (1):
      i40e: Fix ST code value for Clause 45

Jacob Keller (1):
      ice: stop trashing VF VSI aggregator node ID information

Jakub Kicinski (3):
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'mlx5-fixes-2023-12-13' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge tag 'wireless-2023-12-14' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

Jianbo Liu (1):
      net/mlx5e: Fix overrun reported by coverity

Jijie Shao (1):
      net: hns3: add new maintainer for the HNS3 ethernet driver

Jiri Olsa (1):
      bpf: Add missing BPF_LINK_TYPE invocations

Johannes Berg (7):
      wifi: ieee80211: don't require protected vendor action frames
      wifi: iwlwifi: pcie: add another missing bh-disable for rxq->lock
      wifi: mac80211: don't re-add debugfs during reconfig
      wifi: mac80211: check defragmentation succeeded
      wifi: mac80211: mesh: check element parsing succeeded
      wifi: mac80211: mesh_plink: fix matches_local logic
      wifi: cfg80211: fix certs build to not depend on file order

John Fastabend (2):
      bpf: syzkaller found null ptr deref in unix_bpf proto add
      bpf: sockmap, test for unconnected af_unix sock

Lai Peter Jun Ann (1):
      net: stmmac: fix incorrect flag check in timestamp interrupt

Larysa Zaremba (1):
      ice: Fix PF with enabled XDP going no-carrier after reset

Liu Jian (2):
      net: check vlan filter feature in vlan_vids_add_by_dev() and vlan_vids_del_by_dev()
      selftests: add vlan hw filter tests

Lorenzo Bianconi (1):
      net: ethernet: mtk_wed: fix possible NULL pointer dereference in mtk_wed_wo_queue_tx_clean()

Luiz Augusto von Dentz (3):
      Bluetooth: Fix not notifying when connection encryption changes
      Bluetooth: hci_event: Fix not checking if HCI_OP_INQUIRY has been sent
      Bluetooth: hci_core: Fix hci_conn_hash_lookup_cis

Martin KaFai Lau (1):
      Merge branch ' bpf fix for unconnect af_unix socket'

Matthieu Baerts (1):
      mptcp: fill in missing MODULE_DESCRIPTION()

Michal Schmidt (1):
      ice: fix theoretical out-of-bounds access in ethtool link modes

Moshe Shemesh (1):
      net/mlx5: Fix fw tracer first block check

Paolo Abeni (4):
      mptcp: fix inconsistent state on fastopen race
      Merge branch 'check-vlan-filter-feature-in-vlan_vids_add_by_dev-and-vlan_vids_del_by_dev'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf

Rahul Rameshbabu (2):
      net/mlx5e: Correct snprintf truncation handling for fw_version buffer
      net/mlx5e: Correct snprintf truncation handling for fw_version buffer used by representors

Ronald Wahl (1):
      net: ks8851: Fix TX stall caused by TX buffer overrun

Rouven Czerwinski (1):
      net: rfkill: gpio: set GPIO direction

Shifeng Li (2):
      net/mlx5e: Fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list()
      net/mlx5e: Fix a race in command alloc flow

Shigeru Yoshida (1):
      net: Return error from sk_stream_wait_connect() if sk_wait_event() fails

Suman Ghosh (1):
      octeontx2-pf: Fix graceful exit during PFC configuration failure

Thomas Weißschuh (1):
      net: avoid build bug in skb extension length calculation

Vlad Buslov (4):
      Revert "net/mlx5e: fix double free of encap_header in update funcs"
      Revert "net/mlx5e: fix double free of encap_header"
      net/mlx5e: fix double free of encap_header
      net/mlx5: Refactor mlx5_flow_destination->rep pointer to vport num

Vladimir Oltean (2):
      net: mscc: ocelot: fix eMAC TX RMON stats for bucket 256-511 and above
      net: mscc: ocelot: fix pMAC TX RMON stats for bucket 256-511 and above

Xiao Yao (1):
      Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE

Ying Hsu (1):
      Bluetooth: Fix deadlock in vhci_send_frame

Yury Norov (1):
      net: mana: select PAGE_POOL

Zhipeng Lu (1):
      ethernet: atheros: fix a memleak in atl1e_setup_ring_resources

duanqiangwen (1):
      net: libwx: fix memory leak on free page

 .mailmap                                           |  4 +
 MAINTAINERS                                        |  1 +
 drivers/bluetooth/hci_vhci.c                       | 10 ++-
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c    |  5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      | 11 +--
 drivers/net/ethernet/intel/i40e/i40e_register.h    |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h        |  4 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  4 +-
 drivers/net/ethernet/intel/ice/ice_lag.c           |  2 +
 drivers/net/ethernet/intel/ice/ice_lib.c           |  7 +-
 .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c    | 17 ++++-
 drivers/net/ethernet/mediatek/mtk_wed_wo.c         |  3 +
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      | 12 +--
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |  2 +-
 .../mellanox/mlx5/core/en/fs_tt_redirect.c         |  1 +
 .../ethernet/mellanox/mlx5/core/en/tc/act/mirred.c |  5 +-
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.c    | 50 +++++++------
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |  3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |  4 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    | 10 ++-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |  3 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c | 31 +++++---
 .../mellanox/mlx5/core/eswitch_offloads_termtbl.c  |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |  2 +-
 drivers/net/ethernet/micrel/ks8851.h               |  3 +
 drivers/net/ethernet/micrel/ks8851_common.c        | 20 ++---
 drivers/net/ethernet/micrel/ks8851_spi.c           | 42 +++++++----
 drivers/net/ethernet/microsoft/Kconfig             |  1 +
 drivers/net/ethernet/mscc/ocelot_stats.c           | 16 ++--
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  |  2 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        | 82 ++------------------
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |  1 -
 drivers/net/phy/phy_device.c                       |  6 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |  4 +-
 drivers/net/wireless/mediatek/mt76/dma.c           | 10 ++-
 include/linux/bpf_types.h                          |  4 +
 include/linux/ieee80211.h                          |  3 +-
 include/net/bluetooth/hci_core.h                   |  9 ++-
 include/net/ip6_fib.h                              | 64 ++++------------
 include/net/sock.h                                 |  5 ++
 net/8021q/vlan_core.c                              |  9 ++-
 net/bluetooth/af_bluetooth.c                       |  7 +-
 net/bluetooth/hci_event.c                          | 30 +++++---
 net/bluetooth/l2cap_core.c                         | 21 ++++--
 net/bluetooth/mgmt.c                               | 25 +++++--
 net/bluetooth/smp.c                                |  7 ++
 net/core/dev.c                                     |  3 +
 net/core/skbuff.c                                  |  2 +
 net/core/sock_map.c                                |  2 +
 net/core/stream.c                                  |  2 +-
 net/ife/ife.c                                      |  1 +
 net/ipv6/ip6_fib.c                                 | 55 ++------------
 net/ipv6/route.c                                   |  6 +-
 net/mac80211/cfg.c                                 |  4 +-
 net/mac80211/driver-ops.c                          |  6 +-
 net/mac80211/mesh_plink.c                          | 16 ++--
 net/mac80211/mlme.c                                |  4 +-
 net/mptcp/crypto_test.c                            |  1 +
 net/mptcp/protocol.c                               |  6 +-
 net/mptcp/protocol.h                               |  9 ++-
 net/mptcp/subflow.c                                | 28 ++++---
 net/mptcp/token_test.c                             |  1 +
 net/rfkill/rfkill-gpio.c                           |  8 ++
 net/rose/af_rose.c                                 | 39 ++++++++--
 net/wireless/certs/wens.hex                        | 87 ++++++++++++++++++++++
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 34 +++++++++
 tools/testing/selftests/net/Makefile               |  1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  8 +-
 tools/testing/selftests/net/rtnetlink.sh           |  2 +-
 tools/testing/selftests/net/vlan_hw_filter.sh      | 29 ++++++++
 74 files changed, 561 insertions(+), 369 deletions(-)
 create mode 100644 net/wireless/certs/wens.hex
 create mode 100755 tools/testing/selftests/net/vlan_hw_filter.sh
The following changes since commit c7402612e2e61b76177f22e6e7f705adcbecc6fe:

  Merge tag 'net-6.7-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-12-14 13:11:49 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.7-rc7

for you to fetch changes up to 74769d810ead7e7af1a481f07a4d890861a6a4cc:

  Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2023-12-21 12:27:29 +0100)

----------------------------------------------------------------
Including fixes from WiFi and bpf.

Current release - regressions:

  - bpf: syzkaller found null ptr deref in unix_bpf proto add

  - eth: i40e: fix ST code value for clause 45

Previous releases - regressions:

  - core: return error from sk_stream_wait_connect() if sk_wait_event() fails

  - ipv6: revert remove expired routes with a separated list of routes

  - wifi rfkill:
    - set GPIO direction
    - fix crash with WED rx support enabled

  - bluetooth:
    - fix deadlock in vhci_send_frame
    - fix use-after-free in bt_sock_recvmsg

  - eth: mlx5e: fix a race in command alloc flow

  - eth: ice: fix PF with enabled XDP going no-carrier after reset

  - eth: bnxt_en: do not map packet buffers twice

Previous releases - always broken:

  - core:
    - check vlan filter feature in vlan_vids_add_by_dev() and vlan_vids_del_by_dev()
    - check dev->gso_max_size in gso_features_check()

  - mptcp: fix inconsistent state on fastopen race

  - phy: skip LED triggers on PHYs on SFP modules

  - eth: mlx5e:
    - fix double free of encap_header
    - fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list()

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alex Lu (1):
      Bluetooth: Add more enc key size check

Andy Gospodarek (1):
      bnxt_en: do not map packet buffers twice

Arnd Bergmann (1):
      Bluetooth: hci_event: shut up a false-positive warning

Avraham Stern (1):
      wifi: iwlwifi: pcie: avoid a NULL pointer dereference

Carolina Jubran (1):
      net/mlx5e: XDP, Drop fragmented packets larger than MTU size

Chen-Yu Tsai (1):
      wifi: cfg80211: Add my certificate

Chris Mi (1):
      net/mlx5e: Decrease num_block_tc when unblock tc offload

Dan Carpenter (2):
      net/mlx5e: Fix error code in mlx5e_tc_action_miss_mapping_get()
      net/mlx5e: Fix error codes in alloc_branch_attr()

Daniel Golle (1):
      net: phy: skip LED triggers on PHYs on SFP modules

Dave Ertman (1):
      ice: alter feature support check for SRIOV and LAG

David Ahern (1):
      net/ipv6: Revert remove expired routes with a separated list of routes

David S. Miller (2):
      Merge branch 'mptcp-misc-fixes'
      Merge tag 'for-net-2023-12-15' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth

Dinghao Liu (1):
      net/mlx5e: fix a potential double-free in fs_udp_create_groups

Edward Adam Davis (1):
      wifi: mac80211: check if the existing link config remains unchanged

Eric Dumazet (3):
      net: sched: ife: fix potential use-after-free
      net/rose: fix races in rose_kill_by_device()
      net: check dev->gso_max_size in gso_features_check()

Felix Fietkau (1):
      wifi: mt76: fix crash with WED rx support enabled

Frédéric Danis (1):
      Bluetooth: L2CAP: Send reject on command corrupted request

Geliang Tang (2):
      selftests: mptcp: join: fix subflow_send_ack lookup
      mailmap: add entries for Geliang Tang

Hangbin Liu (1):
      kselftest: rtnetlink.sh: use grep_fail when expecting the cmd fail

Hyunwoo Kim (1):
      Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg

Ivan Vecera (1):
      i40e: Fix ST code value for Clause 45

Jacob Keller (1):
      ice: stop trashing VF VSI aggregator node ID information

Jakub Kicinski (3):
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'mlx5-fixes-2023-12-13' of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux
      Merge tag 'wireless-2023-12-14' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

Jianbo Liu (1):
      net/mlx5e: Fix overrun reported by coverity

Jijie Shao (1):
      net: hns3: add new maintainer for the HNS3 ethernet driver

Jiri Olsa (1):
      bpf: Add missing BPF_LINK_TYPE invocations

Johannes Berg (7):
      wifi: ieee80211: don't require protected vendor action frames
      wifi: iwlwifi: pcie: add another missing bh-disable for rxq->lock
      wifi: mac80211: don't re-add debugfs during reconfig
      wifi: mac80211: check defragmentation succeeded
      wifi: mac80211: mesh: check element parsing succeeded
      wifi: mac80211: mesh_plink: fix matches_local logic
      wifi: cfg80211: fix certs build to not depend on file order

John Fastabend (2):
      bpf: syzkaller found null ptr deref in unix_bpf proto add
      bpf: sockmap, test for unconnected af_unix sock

Lai Peter Jun Ann (1):
      net: stmmac: fix incorrect flag check in timestamp interrupt

Larysa Zaremba (1):
      ice: Fix PF with enabled XDP going no-carrier after reset

Liu Jian (2):
      net: check vlan filter feature in vlan_vids_add_by_dev() and vlan_vids_del_by_dev()
      selftests: add vlan hw filter tests

Lorenzo Bianconi (1):
      net: ethernet: mtk_wed: fix possible NULL pointer dereference in mtk_wed_wo_queue_tx_clean()

Luiz Augusto von Dentz (3):
      Bluetooth: Fix not notifying when connection encryption changes
      Bluetooth: hci_event: Fix not checking if HCI_OP_INQUIRY has been sent
      Bluetooth: hci_core: Fix hci_conn_hash_lookup_cis

Martin KaFai Lau (1):
      Merge branch ' bpf fix for unconnect af_unix socket'

Matthieu Baerts (1):
      mptcp: fill in missing MODULE_DESCRIPTION()

Michal Schmidt (1):
      ice: fix theoretical out-of-bounds access in ethtool link modes

Moshe Shemesh (1):
      net/mlx5: Fix fw tracer first block check

Paolo Abeni (4):
      mptcp: fix inconsistent state on fastopen race
      Merge branch 'check-vlan-filter-feature-in-vlan_vids_add_by_dev-and-vlan_vids_del_by_dev'
      Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf

Rahul Rameshbabu (2):
      net/mlx5e: Correct snprintf truncation handling for fw_version buffer
      net/mlx5e: Correct snprintf truncation handling for fw_version buffer used by representors

Ronald Wahl (1):
      net: ks8851: Fix TX stall caused by TX buffer overrun

Rouven Czerwinski (1):
      net: rfkill: gpio: set GPIO direction

Shifeng Li (2):
      net/mlx5e: Fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list()
      net/mlx5e: Fix a race in command alloc flow

Shigeru Yoshida (1):
      net: Return error from sk_stream_wait_connect() if sk_wait_event() fails

Suman Ghosh (1):
      octeontx2-pf: Fix graceful exit during PFC configuration failure

Thomas Weißschuh (1):
      net: avoid build bug in skb extension length calculation

Vlad Buslov (4):
      Revert "net/mlx5e: fix double free of encap_header in update funcs"
      Revert "net/mlx5e: fix double free of encap_header"
      net/mlx5e: fix double free of encap_header
      net/mlx5: Refactor mlx5_flow_destination->rep pointer to vport num

Vladimir Oltean (2):
      net: mscc: ocelot: fix eMAC TX RMON stats for bucket 256-511 and above
      net: mscc: ocelot: fix pMAC TX RMON stats for bucket 256-511 and above

Xiao Yao (1):
      Bluetooth: MGMT/SMP: Fix address type when using SMP over BREDR/LE

Ying Hsu (1):
      Bluetooth: Fix deadlock in vhci_send_frame

Yury Norov (1):
      net: mana: select PAGE_POOL

Zhipeng Lu (1):
      ethernet: atheros: fix a memleak in atl1e_setup_ring_resources

duanqiangwen (1):
      net: libwx: fix memory leak on free page

 .mailmap                                           |  4 +
 MAINTAINERS                                        |  1 +
 drivers/bluetooth/hci_vhci.c                       | 10 ++-
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c    |  5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c      | 11 +--
 drivers/net/ethernet/intel/i40e/i40e_register.h    |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h        |  4 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  4 +-
 drivers/net/ethernet/intel/ice/ice_lag.c           |  2 +
 drivers/net/ethernet/intel/ice/ice_lib.c           |  7 +-
 .../ethernet/marvell/octeontx2/nic/otx2_dcbnl.c    | 17 ++++-
 drivers/net/ethernet/mediatek/mtk_wed_wo.c         |  3 +
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      | 12 +--
 .../ethernet/mellanox/mlx5/core/diag/fw_tracer.c   |  2 +-
 .../mellanox/mlx5/core/en/fs_tt_redirect.c         |  1 +
 .../ethernet/mellanox/mlx5/core/en/tc/act/mirred.c |  5 +-
 .../net/ethernet/mellanox/mlx5/core/en/tc_tun.c    | 50 +++++++------
 .../ethernet/mellanox/mlx5/core/en/tc_tun_encap.c  |  3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c   |  4 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    | 10 ++-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h  |  3 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c | 31 +++++---
 .../mellanox/mlx5/core/eswitch_offloads_termtbl.c  |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |  2 +-
 drivers/net/ethernet/micrel/ks8851.h               |  3 +
 drivers/net/ethernet/micrel/ks8851_common.c        | 20 ++---
 drivers/net/ethernet/micrel/ks8851_spi.c           | 42 +++++++----
 drivers/net/ethernet/microsoft/Kconfig             |  1 +
 drivers/net/ethernet/mscc/ocelot_stats.c           | 16 ++--
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  |  2 +-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c        | 82 ++------------------
 drivers/net/ethernet/wangxun/libwx/wx_type.h       |  1 -
 drivers/net/phy/phy_device.c                       |  6 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |  4 +-
 drivers/net/wireless/mediatek/mt76/dma.c           | 10 ++-
 include/linux/bpf_types.h                          |  4 +
 include/linux/ieee80211.h                          |  3 +-
 include/net/bluetooth/hci_core.h                   |  9 ++-
 include/net/ip6_fib.h                              | 64 ++++------------
 include/net/sock.h                                 |  5 ++
 net/8021q/vlan_core.c                              |  9 ++-
 net/bluetooth/af_bluetooth.c                       |  7 +-
 net/bluetooth/hci_event.c                          | 30 +++++---
 net/bluetooth/l2cap_core.c                         | 21 ++++--
 net/bluetooth/mgmt.c                               | 25 +++++--
 net/bluetooth/smp.c                                |  7 ++
 net/core/dev.c                                     |  3 +
 net/core/skbuff.c                                  |  2 +
 net/core/sock_map.c                                |  2 +
 net/core/stream.c                                  |  2 +-
 net/ife/ife.c                                      |  1 +
 net/ipv6/ip6_fib.c                                 | 55 ++------------
 net/ipv6/route.c                                   |  6 +-
 net/mac80211/cfg.c                                 |  4 +-
 net/mac80211/driver-ops.c                          |  6 +-
 net/mac80211/mesh_plink.c                          | 16 ++--
 net/mac80211/mlme.c                                |  4 +-
 net/mptcp/crypto_test.c                            |  1 +
 net/mptcp/protocol.c                               |  6 +-
 net/mptcp/protocol.h                               |  9 ++-
 net/mptcp/subflow.c                                | 28 ++++---
 net/mptcp/token_test.c                             |  1 +
 net/rfkill/rfkill-gpio.c                           |  8 ++
 net/rose/af_rose.c                                 | 39 ++++++++--
 net/wireless/certs/wens.hex                        | 87 ++++++++++++++++++++++
 .../selftests/bpf/prog_tests/sockmap_basic.c       | 34 +++++++++
 tools/testing/selftests/net/Makefile               |  1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |  8 +-
 tools/testing/selftests/net/rtnetlink.sh           |  2 +-
 tools/testing/selftests/net/vlan_hw_filter.sh      | 29 ++++++++
 74 files changed, 561 insertions(+), 369 deletions(-)
 create mode 100644 net/wireless/certs/wens.hex
 create mode 100755 tools/testing/selftests/net/vlan_hw_filter.sh


