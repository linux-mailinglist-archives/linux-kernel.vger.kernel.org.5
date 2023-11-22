Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4DE7F4F34
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344115AbjKVSVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjKVSVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:21:09 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445AEA2;
        Wed, 22 Nov 2023 10:21:02 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1BD265C0131;
        Wed, 22 Nov 2023 13:20:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 22 Nov 2023 13:20:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1700677259; x=1700763659; bh=IXy9hEwDva
        zgBgsi6N7DtR+e9WjAm48zXkbX44TGPGQ=; b=GS/APCbrMj2F3EvQBvMqdGxB0m
        lU0U2qu2WVG+6csf0xBpIO5GR+iNDvatl2UrLabMtjjV4grTi/KwB+nDDbDE4Wpk
        TG0yiDVlzA0iWJvFlG0ySYigTtNDCuaDckG6qAExIGYAdILqrWwHcJia3jyRcQnu
        dMxzbakbDjcI7gEhMVwyU9R/Xsl1TQHtuMw5bjV0mwXQk6bpQMZcYqyigWeb3s1T
        UzRbjGjSVgoo3MYrk5x+S6WhSlrKDLP06Y89J8Z0VsJ6wsflvG4vwSaS+vpvXdZk
        /aN2S/s+KDJ5S0hH1/GUVEpk4B/igL1YLnOJ5kBLDHlYnmiQSOO+T9oeqXgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1700677259; x=1700763659; bh=IXy9hEwDvazgB
        gsi6N7DtR+e9WjAm48zXkbX44TGPGQ=; b=szbLNXMRsBV1JbaczpHNx3zsmIhnk
        QDSvv6xRx5oA2cCrseTNNyZ1C6ELqe3HwIuQu1HGuP+IZJSZGWRJZ3Heehfg6FHo
        pLCcGjeru4izEzhI0sR0feZLBbT6Ylm267D5/N+hvzl8f3XhaMDZgukhn7Tkkx3c
        UXNuYfTQy7YTctFi74/M69vsytdZIPQCu8Us6RUFCLKv2yIwb5a7AhCCaQXxxKzA
        hohTyG1AGg65vPg+lG20IJDOq+zfRt70Zj2PZhy74QpdrShEVZZqjlhsRpYTCykJ
        6BOJe/Rz8GPDuiFrHZCV1JjKdnIKnxKAMPqsqmhFg4zUdIXfWb1GZc+pQ==
X-ME-Sender: <xms:ikZeZRA69fsvHlD-91jJp8i6LSJdbtglycXyxoVF5mRExJeH6fMMJg>
    <xme:ikZeZfg0Skj4tRRhmSd4oXUjGY9YtHOe55HatmKxXcqRvzw8F1rMTHMqhkYKT8su-
    -QQjkIGg1w7hEQmYw>
X-ME-Received: <xmr:ikZeZcm1L0-GhzkPVLPqwS4rneerAoAKrzsGl8uZlDvTWCMsGWHxvyxHfZINy3xcNAWzeP87Yh0vaXwvCDJEXDZ4w47ufp4R7iF-FtaElos1AQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehuddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculddvfedmnecujfgurhephf
    fvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeikeehudegteevuddthf
    eilefhjefgueeuueffveevheeggfeufeejfeeuudekfeenucffohhmrghinhepihgvthhf
    rdhorhhgpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:ikZeZbxo0rz_iAxlkNzfSmPoqdGaN3jmI4b__fs_TpN-Au_A60T-nQ>
    <xmx:ikZeZWREQ0H-cS1AXfjDkgS6wr8RaOj8v9wsaPswJqk-3DFnoNS-4Q>
    <xmx:ikZeZeaSLH4Sxx2sVvoPhJsFKEsxJ5IzzI98YmR8lu41-H8IZphkMA>
    <xmx:i0ZeZVFDZd7eMFlnhBQZ_ZpJIu3iAsuW0I8M5hjyMDU5wNXaov9_EQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Nov 2023 13:20:57 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        steffen.klassert@secunet.com, antony.antony@secunet.com,
        alexei.starovoitov@gmail.com
Cc:     devel@linux-ipsec.org
Subject: [PATCH ipsec-next v1 0/7] Add bpf_xdp_get_xfrm_state() kfunc
Date:   Wed, 22 Nov 2023 11:20:21 -0700
Message-ID: <cover.1700676682.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patchset adds two kfunc helpers, bpf_xdp_get_xfrm_state() and
bpf_xdp_xfrm_state_release() that wrap xfrm_state_lookup() and
xfrm_state_put(). The intent is to support software RSS (via XDP) for
the ongoing/upcoming ipsec pcpu work [0]. Recent experiments performed
on (hopefully) reproducible AWS testbeds indicate that single tunnel
pcpu ipsec can reach line rate on 100G ENA nics.

Note this patchset only tests/shows generic xfrm_state access. The
"secret sauce" (if you can really even call it that) involves accessing
a soon-to-be-upstreamed pcpu_num field in xfrm_state. Early example is
available here [1].

[0]: https://datatracker.ietf.org/doc/draft-ietf-ipsecme-multi-sa-performance/03/
[1]: https://github.com/danobi/xdp-tools/blob/e89a1c617aba3b50d990f779357d6ce2863ecb27/xdp-bench/xdp_redirect_cpumap.bpf.c#L385-L406

Changes from RFCv2:
* Rebased to ipsec-next
* Fix netns leak

Changes from RFCv1:
* Add Antony's commit tags
* Add KF_ACQUIRE and KF_RELEASE semantics

Daniel Xu (7):
  bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
  bpf: xfrm: Add bpf_xdp_xfrm_state_release() kfunc
  bpf: selftests: test_tunnel: Use ping -6 over ping6
  bpf: selftests: test_tunnel: Mount bpffs if necessary
  bpf: selftests: test_tunnel: Use vmlinux.h declarations
  bpf: selftests: test_tunnel: Disable CO-RE relocations
  bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()

 include/net/xfrm.h                            |   9 ++
 net/xfrm/Makefile                             |   1 +
 net/xfrm/xfrm_policy.c                        |   2 +
 net/xfrm/xfrm_state_bpf.c                     | 127 ++++++++++++++++++
 .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
 .../selftests/bpf/progs/test_tunnel_kern.c    |  98 ++++++++------
 tools/testing/selftests/bpf/test_tunnel.sh    |  43 ++++--
 7 files changed, 227 insertions(+), 54 deletions(-)
 create mode 100644 net/xfrm/xfrm_state_bpf.c

-- 
2.42.1

