Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB4C7654AE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjG0NNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjG0NNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:13:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE22D1715
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 06:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690463586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FYy7XLdCnALp3/D9ahfmtvQ5zGKKrEf0N94s0r+0boI=;
        b=DRpAhGKnyavOAJSqtPnxWjj2gmSMf5OmYR2ozGuVv76vU66D5GJ7624NCGd92me/cw2UBq
        ypRki15zkiO6Y0y5umgJ0Gui9onSOU3PyQlbQApBuXLhYh5wsfmOVr8+91LrIkktQnJqvf
        IRuBLdY/aq+jr+owOTFBhkV5XmuLvy4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-FPN6QHfIP2erXVmf6daIOQ-1; Thu, 27 Jul 2023 09:13:05 -0400
X-MC-Unique: FPN6QHfIP2erXVmf6daIOQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C64529AA385;
        Thu, 27 Jul 2023 13:13:04 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76FA74094DC0;
        Thu, 27 Jul 2023 13:13:03 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for 6.5-rc4
Date:   Thu, 27 Jul 2023 15:12:50 +0200
Message-ID: <20230727131250.40515-1-pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

The following changes since commit 57f1f9dd3abea322173ea75a15887ccf14bbbe51:

  Merge tag 'net-6.5-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-07-20 14:46:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.5-rc4

for you to fetch changes up to de52e17326c3e9a719c9ead4adb03467b8fae0ef:

  tipc: stop tipc crypto on failure in tipc_node_create (2023-07-27 11:45:05 +0200)

----------------------------------------------------------------
Networking fixes for 6.5-rc4, including fixes from can, netfilter

Current release - regressions:

  - core: fix splice_to_socket() for O_NONBLOCK socket

  - af_unix: fix fortify_panic() in unix_bind_bsd().

  - can: raw: fix lockdep issue in raw_release()

Previous releases - regressions:

  - tcp: reduce chance of collisions in inet6_hashfn().

  - netfilter: skip immediate deactivate in _PREPARE_ERROR

  - tipc: stop tipc crypto on failure in tipc_node_create

  - eth: igc: fix kernel panic during ndo_tx_timeout callback

  - eth: iavf: fix potential deadlock on allocation failure

Previous releases - always broken:

  - ipv6: fix bug where deleting a mngtmpaddr can create a new temporary address

  - eth: ice: fix memory management in ice_ethtool_fdir.c

  - eth: hns3: fix the imp capability bit cannot exceed 32 bits issue

  - eth: vxlan: calculate correct header length for GPE

  - eth: stmmac: apply redundant write work around on 4.xx too

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alex Elder (1):
      net: ipa: only reset hashed tables when supported

Arkadiusz Kubalewski (2):
      tools: ynl-gen: fix enum index in _decode_enum(..)
      tools: ynl-gen: fix parse multi-attr enum attribute

Christian Marangi (4):
      net: dsa: qca8k: enable use_single_write for qca8xxx
      net: dsa: qca8k: fix search_and_insert wrong handling of new rule
      net: dsa: qca8k: fix broken search_and_del
      net: dsa: qca8k: fix mdb add/del case with 0 VID

David S. Miller (2):
      Merge branch 'hns3-fixes'
      Merge branch 'vxlan-gro-fixes'

Eric Dumazet (1):
      can: raw: fix lockdep issue in raw_release()

Fedor Pchelkin (1):
      tipc: stop tipc crypto on failure in tipc_node_create

Florian Westphal (1):
      netfilter: nft_set_rbtree: fix overlap expiration walk

Hangbin Liu (2):
      bonding: reset bond's flags when down link is P2P device
      team: reset team's flags when down link is P2P device

Hao Lan (2):
      net: hns3: fix the imp capability bit cannot exceed 32 bits issue
      net: hns3: add tm flush when setting tm

Jacob Keller (2):
      iavf: fix potential deadlock on allocation failure
      iavf: check for removal state before IAVF_FLAG_PF_COMMS_FAILED

Jakub Kicinski (7):
      docs: net: clarify the NAPI rules around XDP Tx
      Merge tag 'linux-can-fixes-for-6.5-20230724' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
      Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
      Merge branch 'net-fix-error-warning-by-fstrict-flex-arrays-3'
      Merge branch 'tools-ynl-gen-fix-parse-multi-attr-enum-attribute'
      Merge branch 'mptcp-more-fixes-for-6-5'
      Merge tag 'nf-23-07-26' of https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Jan Stancek (1):
      splice, net: Fix splice_to_socket() for O_NONBLOCK socket

Jason Wang (1):
      virtio-net: fix race between set queues and probe

Jedrzej Jagielski (1):
      ice: Fix memory management in ice_ethtool_fdir.c

Jiawen Wu (1):
      net: phy: marvell10g: fix 88x3310 power up

Jijie Shao (2):
      net: hns3: fix wrong tc bandwidth weight data issue
      net: hns3: fix wrong bw weight of disabled tc issue

Jiri Benc (3):
      vxlan: calculate correct header length for GPE
      vxlan: generalize vxlan_parse_gpe_hdr and remove unused args
      vxlan: fix GRO with VXLAN-GPE

Kuniyuki Iwashima (3):
      af_unix: Fix fortify_panic() in unix_bind_bsd().
      af_packet: Fix warning of fortified memcpy() in packet_getname().
      af_unix: Terminate sun_path when bind()ing pathname socket.

Lin Ma (2):
      macvlan: add forgotten nla_policy for IFLA_MACVLAN_BC_CUTOFF
      net/sched: mqprio: Add length check for TCA_MQPRIO_{MAX/MIN}_RATE64

Maciej Żenczykowski (1):
      ipv6 addrconf: fix bug where deleting a mngtmpaddr can create a new temporary address

Marc Kleine-Budde (1):
      can: gs_usb: gs_can_close(): add missing set of CAN state to CAN_STATE_STOPPED

Matthieu Baerts (1):
      selftests: mptcp: join: only check for ip6tables if needed

Muhammad Husaini Zulkifli (1):
      igc: Fix Kernel Panic during ndo_tx_timeout callback

Pablo Neira Ayuso (2):
      netfilter: nf_tables: skip immediate deactivate in _PREPARE_ERROR
      netfilter: nf_tables: disallow rule addition to bound chain via NFTA_RULE_CHAIN_ID

Paolo Abeni (2):
      Merge branch 'fix-up-dev-flags-when-add-p2p-down-link'
      mptcp: more accurate NL event generation

Stewart Smith (1):
      tcp: Reduce chance of collisions in inet6_hashfn().

Suman Ghosh (1):
      octeontx2-af: Fix hash extraction enable configuration

Vincent Whitchurch (1):
      net: stmmac: Apply redundant write work around on 4.xx too

Wang Ming (1):
      i40e: Fix an NULL vs IS_ERR() bug for debugfs_create_dir()

Wei Fang (2):
      net: fec: avoid tx queue timeout when XDP is enabled
      net: fec: tx processing does not call XDP APIs if budget is 0

Yuanjun Gong (5):
      ethernet: atheros: fix return value check in atl1c_tso_csum()
      atheros: fix return value check in atl1_tso()
      ethernet: atheros: fix return value check in atl1e_tso_csum()
      benet: fix return value check in be_lancer_xmit_workarounds()
      tipc: check return value of pskb_trim()

 Documentation/networking/napi.rst                  |  13 +-
 drivers/net/bonding/bond_main.c                    |   5 +
 drivers/net/can/usb/gs_usb.c                       |   2 +
 drivers/net/dsa/qca/qca8k-8xxx.c                   |   7 +-
 drivers/net/dsa/qca/qca8k-common.c                 |  19 ++-
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c    |   7 +-
 drivers/net/ethernet/atheros/atl1e/atl1e_main.c    |   7 +-
 drivers/net/ethernet/atheros/atlx/atl1.c           |   7 +-
 drivers/net/ethernet/emulex/benet/be_main.c        |   3 +-
 drivers/net/ethernet/freescale/fec_main.c          |  18 ++-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |   7 +-
 .../hisilicon/hns3/hns3_common/hclge_comm_cmd.c    |  22 ++-
 .../hisilicon/hns3/hns3_common/hclge_comm_cmd.h    |   2 +
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c |   3 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c |  51 ++++++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c |   3 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |  34 ++++-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h  |   4 +
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |   2 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  11 +-
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c  |  26 ++--
 drivers/net/ethernet/intel/igc/igc_main.c          |  40 +++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   2 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc_hash.c   |  43 +++++-
 .../ethernet/marvell/octeontx2/af/rvu_npc_hash.h   |   8 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |   4 +-
 drivers/net/ipa/ipa_table.c                        |  20 +--
 drivers/net/macvlan.c                              |   1 +
 drivers/net/phy/marvell10g.c                       |   7 +
 drivers/net/team/team.c                            |   9 ++
 drivers/net/virtio_net.c                           |   4 +-
 drivers/net/vxlan/vxlan_core.c                     | 165 +++++++++++++--------
 fs/splice.c                                        |   2 +
 include/net/ipv6.h                                 |   8 +-
 include/net/vxlan.h                                |  13 +-
 include/uapi/linux/if_packet.h                     |   6 +-
 net/can/raw.c                                      |   5 +-
 net/ipv6/addrconf.c                                |  14 +-
 net/mptcp/protocol.c                               |   3 +-
 net/netfilter/nf_tables_api.c                      |   5 +-
 net/netfilter/nft_immediate.c                      |  27 ++--
 net/netfilter/nft_set_rbtree.c                     |  20 ++-
 net/packet/af_packet.c                             |   2 +-
 net/sched/sch_mqprio.c                             |  14 ++
 net/tipc/crypto.c                                  |   3 +-
 net/tipc/node.c                                    |   2 +-
 net/unix/af_unix.c                                 |  23 ++-
 tools/net/ynl/lib/ynl.py                           |  16 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    |   4 +-
 49 files changed, 522 insertions(+), 201 deletions(-)

