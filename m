Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BD77DDA8D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 02:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345046AbjKABSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 21:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbjKABSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 21:18:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1ABF4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 18:18:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EE9C433C8;
        Wed,  1 Nov 2023 01:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698801493;
        bh=Nba6ylNwvuUvLsMHOnd7vDr6OTFeqrwEKUClJP8rdnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iF+04qsFm7WOrh/U7P0/T0+sj3jQ47DijetytK2c9/ikYhcGOQww9O7cuLDCCqkMi
         iNQPWVMYK7zpUARn0FxRDQ8WATBrv05Ht8J8/0fwXHVyZYiu7bV253UzA7xY+MEAJU
         AF/8etJSBYrnbGi7xf7xGKa7Fn8K0CFI99mc7Om+hNojGg86maoUrP//GOcf2VUutA
         rJegixJIvSYQX5rumxGXGn9ANhceVkMmpS2d5P0ZHtgZGzu+krYAeHgDeufOj85cra
         n1Drwdw+pxLUx57Z4DBpq4qrd+kTUbBEVTjT4VO3l5meByCasosCCXFzeXVj5UrM9e
         KF9y8OGqqMXPw==
From:   Jakub Kicinski <kuba@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: [GIT PULL] Networking follow up for 6.7
Date:   Tue, 31 Oct 2023 18:18:12 -0700
Message-ID: <20231101011812.2653409-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <CAHk-=wjTWHVjEA2wfU+eHMXygyuh4Jf_tqXRxv8VnzqAPB4htg@mail.gmail.com>
References: <CAHk-=wjTWHVjEA2wfU+eHMXygyuh4Jf_tqXRxv8VnzqAPB4htg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, I had actually already merged the original pull request, and
> then started a full allmodconfig build.
> 
> And because I'm off gallivanting and traveling, that takes 2h on this
> poor little laptop, so I had left to do more fun things than watch
> paint dry.

Eish. Sorry.

> I pushed out my original merge. I'll pull the updates later.

In case it's helpful here's a tag with just the delta described.
Running a risk of another race condition :)


The following changes since commit f1c73396133cb3d913e2075298005644ee8dfade:

  net: pcs: xpcs: Add 2500BASE-X case in get state for XPCS drivers (2023-10-27 15:59:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.7-followup

for you to fetch changes up to f2fbb908112311423b09cd0d2b4978f174b99585:

  net: tcp: remove call to obsolete crypto_ahash_alignmask() (2023-10-31 13:11:51 -0700)

----------------------------------------------------------------
Follow up to networking PR for 6.7

 - Support GRO decapsulation for IPsec ESP in UDP.

 - Add a handful of MODULE_DESCRIPTION()s.

 - Drop questionable alignment check in TCP AO to avoid
   build issue after changes in the crypto tree.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Florian Westphal (4):
      xfrm: pass struct net to xfrm_decode_session wrappers
      xfrm: move mark and oif flowi decode into common code
      xfrm: policy: replace session decode with flow dissector
      xfrm: policy: fix layer 4 flowi decoding

Jakub Kicinski (5):
      net: fill in MODULE_DESCRIPTION()s in kuba@'s modules
      net: fill in MODULE_DESCRIPTION()s under net/core
      net: fill in MODULE_DESCRIPTION()s under net/802*
      net: fill in MODULE_DESCRIPTION()s under drivers/net/
      Merge tag 'ipsec-next-2023-10-28' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next

Kees Cook (1):
      xfrm: Annotate struct xfrm_sec_ctx with __counted_by

Steffen Klassert (6):
      xfrm: Use the XFRM_GRO to indicate a GRO call on input
      xfrm: Support GRO for IPv4 ESP in UDP encapsulation
      xfrm: Support GRO for IPv6 ESP in UDP encapsulation
      Merge  branch 'xfrm: Support GRO decapsulation for ESP in UDP encapsulation'
      Merge branch 'xfrm: policy: replace session decode with flow dissector'
      xfrm Fix use after free in __xfrm6_udp_encap_rcv.

Stephen Rothwell (1):
      net: tcp: remove call to obsolete crypto_ahash_alignmask()

Yue Haibing (1):
      xfrm: Remove unused function declarations

 drivers/net/amt.c                           |   1 +
 drivers/net/dummy.c                         |   1 +
 drivers/net/eql.c                           |   1 +
 drivers/net/ifb.c                           |   1 +
 drivers/net/macvtap.c                       |   1 +
 drivers/net/netdevsim/netdev.c              |   1 +
 drivers/net/sungem_phy.c                    |   1 +
 drivers/net/tap.c                           |   1 +
 drivers/net/wireless/mediatek/mt7601u/usb.c |   1 +
 include/net/gro.h                           |   2 +-
 include/net/ipv6_stubs.h                    |   3 +
 include/net/xfrm.h                          |  18 +-
 include/uapi/linux/xfrm.h                   |   3 +-
 net/802/fddi.c                              |   1 +
 net/802/garp.c                              |   1 +
 net/802/mrp.c                               |   1 +
 net/802/p8022.c                             |   1 +
 net/802/psnap.c                             |   1 +
 net/802/stp.c                               |   1 +
 net/8021q/vlan.c                            |   1 +
 net/core/dev_addr_lists_test.c              |   1 +
 net/core/selftests.c                        |   1 +
 net/ipv4/esp4_offload.c                     |   6 +-
 net/ipv4/icmp.c                             |   2 +-
 net/ipv4/ip_vti.c                           |   4 +-
 net/ipv4/netfilter.c                        |   2 +-
 net/ipv4/tcp_ao.c                           |   6 -
 net/ipv4/udp.c                              |  16 ++
 net/ipv4/xfrm4_input.c                      |  95 +++++++--
 net/ipv6/af_inet6.c                         |   1 +
 net/ipv6/esp6_offload.c                     |  10 +-
 net/ipv6/icmp.c                             |   2 +-
 net/ipv6/ip6_vti.c                          |   4 +-
 net/ipv6/netfilter.c                        |   2 +-
 net/ipv6/xfrm6_input.c                      | 103 ++++++++--
 net/netfilter/nf_nat_proto.c                |   2 +-
 net/xfrm/xfrm_input.c                       |   6 +-
 net/xfrm/xfrm_interface_core.c              |   4 +-
 net/xfrm/xfrm_policy.c                      | 301 ++++++++++++----------------
 39 files changed, 362 insertions(+), 248 deletions(-)
