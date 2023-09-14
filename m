Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE89E7A055B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238862AbjINNTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238880AbjINNRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:17:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB5881FDF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694697402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TP7EQCf2aTNDyoyo+k/4/B3xye6UkWhN/LawUuuo7N0=;
        b=K1+v0cZ5SGxQq1CgCE43uMslvEIqec/BAeCNFY3Dqv0SAcd2mTYsUMkK0zUnjAzNdS2z5D
        XNLixYxjax3xBfgGmswU9YPD4XrfyJuCAJugB3cl4TaYr+xcTdG35N3q/bfNL3E3YdrOvB
        iYV5Jt9G8ZlpEyhMhyFKWXEGzd1WlvA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-1mmvaPkqPU-7ZVWym7Nd3w-1; Thu, 14 Sep 2023 09:16:39 -0400
X-MC-Unique: 1mmvaPkqPU-7ZVWym7Nd3w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C039A81652F;
        Thu, 14 Sep 2023 13:16:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A27482026D4B;
        Thu, 14 Sep 2023 13:16:37 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for 6.6-rc2
Date:   Thu, 14 Sep 2023 15:16:26 +0200
Message-ID: <20230914131626.49468-1-pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

Quite unusually, this does not contains any fix coming from subtrees
(nf, ebpf, wifi, etc).

The following changes since commit 73be7fb14e83d24383f840a22f24d3ed222ca319:

  Merge tag 'net-6.6-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-09-07 18:33:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.6-rc2

for you to fetch changes up to a22730b1b4bf437c6bbfdeff5feddf54be4aeada:

  kcm: Fix error handling for SOCK_DGRAM in kcm_sendmsg(). (2023-09-14 10:43:51 +0200)

----------------------------------------------------------------
Networking fixes for 6.6-rc2.

Current release - regressions:

  - bcmasp: fix possible OOB write in bcmasp_netfilt_get_all_active()

Previous releases - regressions:

  - ipv4: fix one memleak in __inet_del_ifa()

  - tcp: fix bind() regressions for v4-mapped-v6 addresses.

  - tls: do not free tls_rec on async operation in bpf_exec_tx_verdict()

  - dsa: fixes for SJA1105 FDB regressions

  - veth: update XDP feature set when bringing up device

  - igb: fix hangup when enabling SR-IOV

Previous releases - always broken:

  - kcm: fix memory leak in error path of kcm_sendmsg()

  - smc: fix data corruption in smcr_port_add

  - microchip: fix possible memory leak for vcap_dup_rule()

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Ciprian Regus (1):
      net:ethernet:adi:adin1110: Fix forwarding offload

Corinna Vinschen (1):
      igb: clean up in all error paths when enabling SR-IOV

Daniel Golle (1):
      net: ethernet: mtk_eth_soc: fix uninitialized variable

David S. Miller (4):
      Merge branch 'smc-r-fixes'
      Merge branch 'rule_buf-OOB'
      Merge branch 'sha1105-regressions'
      Merge branch 'tcp-bind-fixes'

Eric Dumazet (1):
      ipv6: fix ip6_sock_set_addr_preferences() typo

Guangguan Wang (2):
      net/smc: bugfix for smcr v2 server connect success statistic
      net/smc: use smc_lgr_list.lock to protect smc_lgr_list.list iterate in smcr_port_add

Hangyu Hua (3):
      net: ethernet: bcmasp: fix possible OOB write in bcmasp_netfilt_get_all_active()
      net: ethernet: mvpp2_main: fix possible OOB write in mvpp2_ethtool_get_rxnfc()
      net: ethernet: mtk_eth_soc: fix possible NULL pointer dereference in mtk_hwlro_get_fdir_all()

Hayes Wang (1):
      r8152: check budget for r8152_poll()

Jinjie Ruan (1):
      net: microchip: vcap api: Fix possible memory leak for vcap_dup_rule()

Julia Lawall (1):
      net: bcmasp: add missing of_node_put

Juntong Deng (1):
      selftests/net: Improve bind_bhash.sh to accommodate predictable network interface names

Kuniyuki Iwashima (7):
      tcp: Factorise sk_family-independent comparison in inet_bind2_bucket_match(_addr_any).
      tcp: Fix bind() regression for v4-mapped-v6 wildcard address.
      tcp: Fix bind() regression for v4-mapped-v6 non-wildcard address.
      selftest: tcp: Fix address length in bind_wildcard.c.
      selftest: tcp: Move expected_errno into each test case in bind_wildcard.c.
      selftest: tcp: Add v4-mapped-v6 cases in bind_wildcard.c.
      kcm: Fix error handling for SOCK_DGRAM in kcm_sendmsg().

Liu Jian (2):
      net: ipv4: fix one memleak in __inet_del_ifa()
      net/tls: do not free tls_rec on async operation in bpf_exec_tx_verdict()

Lorenzo Bianconi (1):
      net: ethernet: mtk_eth_soc: fix pse_port configuration for MT7988

Paolo Abeni (1):
      Merge branch 'net-renesas-rswitch-fix-a-lot-of-redundant-irq-issue'

Ratheesh Kannoth (1):
      octeontx2-pf: Fix page pool cache index corruption.

Sascha Hauer (1):
      net: macb: fix sleep inside spinlock

Shigeru Yoshida (1):
      kcm: Fix memory leak in error path of kcm_sendmsg()

Toke Høiland-Jørgensen (1):
      veth: Update XDP feature set when bringing up device

Vadim Fedorenko (1):
      ixgbe: fix timestamp configuration code

Vincent Whitchurch (1):
      net: stmmac: fix handling of zero coalescing tx-usecs

Vladimir Oltean (5):
      net: dsa: sja1105: hide all multicast addresses from "bridge fdb show"
      net: dsa: sja1105: propagate exact error code from sja1105_dynamic_config_poll_valid()
      net: dsa: sja1105: fix multicast forwarding working only for last added mdb entry
      net: dsa: sja1105: serialize sja1105_port_mcast_flood() with other FDB accesses
      net: dsa: sja1105: block FDB accesses that are concurrent with a switch reset

Yoshihiro Shimoda (2):
      net: renesas: rswitch: Fix unmasking irq condition
      net: renesas: rswitch: Add spin lock protection for irq {un}mask

Ziyang Xuan (1):
      hsr: Fix uninit-value access in fill_frame_info()

 drivers/net/dsa/sja1105/sja1105.h                  |  2 +
 drivers/net/dsa/sja1105/sja1105_dynamic_config.c   | 93 ++++++++++------------
 drivers/net/dsa/sja1105/sja1105_main.c             | 69 +++++++++++-----
 drivers/net/ethernet/adi/adin1110.c                |  2 +-
 drivers/net/ethernet/broadcom/asp2/bcmasp.c        | 10 ++-
 drivers/net/ethernet/broadcom/asp2/bcmasp.h        |  4 +-
 .../net/ethernet/broadcom/asp2/bcmasp_ethtool.c    |  2 +-
 drivers/net/ethernet/cadence/macb_main.c           |  5 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |  5 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c       | 28 ++++---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |  5 ++
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c |  6 +-
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h |  2 +-
 .../ethernet/marvell/octeontx2/nic/otx2_common.c   | 43 ++--------
 .../ethernet/marvell/octeontx2/nic/otx2_common.h   |  3 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   |  7 +-
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 30 +++++--
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.h |  4 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        |  8 +-
 drivers/net/ethernet/mediatek/mtk_ppe_offload.c    |  6 +-
 drivers/net/ethernet/microchip/vcap/vcap_api.c     | 18 ++++-
 drivers/net/ethernet/renesas/rswitch.c             | 20 ++++-
 drivers/net/ethernet/renesas/rswitch.h             |  2 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 10 ++-
 drivers/net/usb/r8152.c                            |  3 +
 drivers/net/veth.c                                 |  2 +
 include/net/ipv6.h                                 |  7 +-
 net/hsr/hsr_forward.c                              |  1 +
 net/ipv4/devinet.c                                 | 10 +--
 net/ipv4/inet_hashtables.c                         | 36 +++++----
 net/kcm/kcmsock.c                                  | 13 +--
 net/smc/smc_core.c                                 |  2 +
 net/smc/smc_stats.h                                |  3 +-
 net/tls/tls_sw.c                                   |  4 +-
 tools/testing/selftests/net/bind_bhash.sh          | 26 +++---
 tools/testing/selftests/net/bind_wildcard.c        | 68 +++++++++++++---
 36 files changed, 352 insertions(+), 207 deletions(-)

