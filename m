Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4197D8019
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjJZJ4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjJZJ4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:56:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CBF93
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 02:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698314127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zyWJrVb8i16NmtX1jUj9T8HsL1UYZG7szk+M19SAoeM=;
        b=g+wdLQ2R2DukESUWXXgCqSy6y0cdG3xhkitubY6oB5WEaEClNZSyusfmTF/FFVaqf470/w
        YQSKbktucUgzhvzD9tOkjpJoWK9pmr1El9M17N1mytIFA6E+y4oFWY9Oy6EVy23FNYvPfz
        /vw/bfFRK6ivrDzg9n2+l6fse1Mdyc0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-v9wgk7aZM-KwCqVvp5tUqA-1; Thu, 26 Oct 2023 05:55:25 -0400
X-MC-Unique: v9wgk7aZM-KwCqVvp5tUqA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C38A68C7EC3;
        Thu, 26 Oct 2023 09:55:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.233])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B29C71C060AE;
        Thu, 26 Oct 2023 09:55:23 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Networking for v6.6-rc8
Date:   Thu, 26 Oct 2023 11:55:10 +0200
Message-ID: <20231026095510.23688-1-pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

The following changes since commit ce55c22ec8b223a90ff3e084d842f73cfba35588:

  Merge tag 'net-6.6-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-10-19 12:08:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.6-rc8

for you to fetch changes up to 53798666648af3aa0dd512c2380576627237a800:

  iavf: in iavf_down, disable queues when removing the driver (2023-10-25 17:48:31 -0700)

----------------------------------------------------------------
Including fixes from WiFi and netfilter.

Most regressions addressed here come from quite old versions, with
the exceptions of the iavf one and the WiFi fixes. No known
outstanding reports or investigation.

Fixes to fixes:

 - eth: iavf: in iavf_down, disable queues when removing the driver

Previous releases - regressions:

 - sched: act_ct: additional checks for outdated flows

 - tcp: do not leave an empty skb in write queue

 - tcp: fix wrong RTO timeout when received SACK reneging

 - wifi: cfg80211: pass correct pointer to rdev_inform_bss()

 - eth: i40e: sync next_to_clean and next_to_process for programming status desc

 - eth: iavf: initialize waitqueues before starting watchdog_task

Previous releases - always broken:

 - eth: r8169: fix data-races

 - eth: igb: fix potential memory leak in igb_add_ethtool_nfc_entry

 - eth: r8152: avoid writing garbage to the adapter's registers

 - eth: gtp: fix fragmentation needed check with gso

Signed-off-by: Paolo Abeni <pabeni@redhat.com>

----------------------------------------------------------------
Alexandru Matei (1):
      vsock/virtio: initialize the_virtio_vsock before using VQs

Anjali Kulkarni (1):
      Fix NULL pointer dereference in cn_filter()

Avraham Stern (1):
      wifi: mac80211: don't drop all unprotected public action frames

Ben Greear (1):
      wifi: cfg80211: pass correct pointer to rdev_inform_bss()

Christophe JAILLET (1):
      net: ieee802154: adf7242: Fix some potential buffer overflow in adf7242_stats_show()

David S. Miller (1):
      Merge branch 'r8152-reg-garbage'

Dell Jin (1):
      net: ethernet: adi: adin1110: Fix uninitialized variable

Deming Wang (2):
      net: ipv4: fix typo in comments
      net: ipv6: fix typo in comments

Douglas Anderson (8):
      r8152: Increase USB control msg timeout to 5000ms as per spec
      r8152: Run the unload routine if we have errors during probe
      r8152: Cancel hw_phy_work if we have an error in probe
      r8152: Release firmware if we have an error in probe
      r8152: Check for unplug in rtl_phy_patch_request()
      r8152: Check for unplug in r8153b_ups_en() / r8153c_ups_en()
      r8152: Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE
      r8152: Block future register access if register access fails

Eric Dumazet (2):
      net: do not leave an empty skb in write queue
      neighbour: fix various data-races

Fred Chen (1):
      tcp: fix wrong RTO timeout when received SACK reneging

Ivan Vecera (2):
      i40e: Fix I40E_FLAG_VF_VLAN_PRUNING value
      i40e: Fix wrong check for I40E_TXR_FLAGS_WB_ON_ITR

Jakub Kicinski (2):
      Merge tag 'wireless-2023-10-24' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless
      Merge tag 'nf-23-10-25' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf

Johannes Berg (1):
      wifi: cfg80211: fix assoc response warning on failed links

Kunwu Chan (2):
      treewide: Spelling fix in comment
      isdn: mISDN: hfcsusb: Spelling fix in comment

Maciej Fijalkowski (1):
      i40e: xsk: remove count_mask

Mateusz Palczewski (1):
      igb: Fix potential memory leak in igb_add_ethtool_nfc_entry

Michael Sit Wei Hong (1):
      net: stmmac: update MAC capabilities when tx queues are updated

Michal Schmidt (2):
      iavf: initialize waitqueues before starting watchdog_task
      iavf: in iavf_down, disable queues when removing the driver

Mirsad Goran Todorovac (3):
      r8169: fix the KCSAN reported data-race in rtl_tx() while reading tp->cur_tx
      r8169: fix the KCSAN reported data-race in rtl_tx while reading TxDescArray[entry].opts1
      r8169: fix the KCSAN reported data race in rtl_rx while reading desc->opts1

Moritz Wanzenböck (1):
      net/handshake: fix file ref count in handshake_nl_accept_doit()

Pablo Neira Ayuso (3):
      gtp: uapi: fix GTPA_MAX
      gtp: fix fragmentation needed check with gso
      netfilter: flowtable: GC pushes back packets to classic path

Paolo Abeni (1):
      Merge branch 'gtp-tunnel-driver-fixes'

Pieter Jansen van Vuuren (1):
      sfc: cleanup and reduce netlink error messages

Rob Herring (1):
      net: xgene: Fix unused xgene_enet_of_match warning for !CONFIG_OF

Sasha Neftin (1):
      igc: Fix ambiguity in the ethtool advertising

Shigeru Yoshida (1):
      net: usb: smsc95xx: Fix uninit-value access in smsc95xx_read_reg

Su Hui (1):
      net: chelsio: cxgb4: add an error code check in t4_load_phy_fw

Tirthendu Sarkar (1):
      i40e: sync next_to_clean and next_to_process for programming status desc

Vlad Buslov (1):
      net/sched: act_ct: additional checks for outdated flows

 drivers/connector/cn_proc.c                       |   2 +-
 drivers/isdn/hardware/mISDN/hfcsusb.c             |   2 +-
 drivers/net/ethernet/adi/adin1110.c               |   2 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c  |   2 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c        |   2 +
 drivers/net/ethernet/intel/i40e/i40e.h            |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c       |  11 +-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c        |  22 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c       |   7 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c      |   6 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c      |  35 ++-
 drivers/net/ethernet/realtek/r8169_main.c         |   6 +-
 drivers/net/ethernet/sfc/tc.c                     |  38 +--
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  17 +-
 drivers/net/ethernet/toshiba/ps3_gelic_wireless.c |   2 +-
 drivers/net/gtp.c                                 |   5 +-
 drivers/net/ieee802154/adf7242.c                  |   5 +-
 drivers/net/usb/r8152.c                           | 303 ++++++++++++++++------
 drivers/net/usb/smsc95xx.c                        |   4 +-
 include/linux/ieee80211.h                         |  29 +++
 include/net/netfilter/nf_flow_table.h             |   1 +
 include/uapi/linux/gtp.h                          |   2 +-
 net/core/neighbour.c                              |  67 ++---
 net/handshake/netlink.c                           |  30 +--
 net/ipv4/esp4.c                                   |   2 +-
 net/ipv4/tcp.c                                    |   8 +-
 net/ipv4/tcp_input.c                              |   9 +-
 net/ipv6/esp6.c                                   |   2 +-
 net/mac80211/rx.c                                 |   3 +-
 net/netfilter/nf_flow_table_core.c                |  14 +-
 net/sched/act_ct.c                                |   9 +
 net/vmw_vsock/virtio_transport.c                  |  18 +-
 net/wireless/mlme.c                               |   3 +-
 net/wireless/scan.c                               |   2 +-
 34 files changed, 458 insertions(+), 214 deletions(-)

