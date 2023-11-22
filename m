Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AC87F4F36
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344141AbjKVSVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjKVSVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:21:09 -0500
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBF41B9;
        Wed, 22 Nov 2023 10:21:05 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 87DA158034F;
        Wed, 22 Nov 2023 13:21:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 22 Nov 2023 13:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1700677264; x=
        1700684464; bh=pAXMuw36t4A5a6iy5D+iXmBn9GlBmIUIyg5Iqf95p7I=; b=f
        WMKENtYhXbTeI2PbKCiatC9Tzw91bHej/Dcc5zPpOUTJtwujIzZI38FTSVynRHQZ
        wvSlgXN1cWJK5vFYohWU0Xd8HGsILYeCsSqYRy0NSjxMjNdQMOYa5RWuzV9wfVsD
        /diMeZLGKhEv+DFyd+mK4Jcj2k4fpWAx8as99zf9FXISiWle+0zufWAxK/h4rjhM
        A2O6S/Q+yrmX7wtzx+qb6i3CM8nmIQaQYG8H+XU3BkzlCGWdjpTCC5qay8qBYgh/
        O3XP9z1N8e0dKGYe2iutqH46kRpKr9wgIe8VMNPGbjOzaWl5kjrphEhpa/92BVTs
        DVFfgqFUU761A6veKvLRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1700677264; x=
        1700684464; bh=pAXMuw36t4A5a6iy5D+iXmBn9GlBmIUIyg5Iqf95p7I=; b=B
        OUl/rwQ71o6LTPAGfnbdb7yt2tzHLcVY+feh/mbDVlTzinAGZO14hjxHEf2whgGb
        Jjv70ovgUvzyuHgb3Afo/67RlSm+riohjlSdhF0VCyxTSv8u4E0FZJkmK2rr0muD
        bEX8ab1Wig+Vf9N0/3mgJFqcqAMkLQxPvsoEH8DBwTKbLfS4jsrekfkP7/v39GfS
        l+VfqI3TjRluZhcPai1iaw69lMiX0OJTsumNqcrqb2/7evD5Jppi0zRCZq52G5Sl
        qcTtA+v3y2hwCM45LIdLBSxavaxSkeRmVs25/zFAluABAdTeDaM35lrnRQHqAZIF
        IO9e2RLzIy9npIcb/Jd7w==
X-ME-Sender: <xms:kEZeZWF9ugO6MwFfOlAbcUJO3LhkUpfDmJytgwsLXcBPl5H8I8Iwhg>
    <xme:kEZeZXWkbh6xCuUm8JPnvrGL3F3F2r8ueqL0JqYD5LueRdj8ALVUOTh6kSy1PxEGQ
    o79dEQSLyHzsuJGDQ>
X-ME-Received: <xmr:kEZeZQJ8GWb00iQN-FkZyFCUYret6eZwuKjkG7GKIz4egFI7nzHh7C87kfXfywcZKKkotNnPB1wIdJ_9LnHNDvMva2onEvl9_wAcLbhbQnu7OA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehuddguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeevtdekjeffkefgfe
    fhvefffeetgfeuueeutdetjeduudehheeiffdvgefhhfevhfenucffohhmrghinhepghhi
    thhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:kEZeZQEF_7DuYmEpcLoQ3tKuf6FtONnvAgvGVCtJR-EX5e36qvTnTQ>
    <xmx:kEZeZcXLQzKV5q_kpir9SeRsXwh8vuqbVIU3zDcuEFfJnqW-5n0UEg>
    <xmx:kEZeZTNdc4BePZKzNr9DvPPgno44FfQe67lrp0lkWrgaq0N9O2NbIg>
    <xmx:kEZeZXZ3YNNqSRgF6KXRCZ15XA-AOBxjmNGmIdyMFAaN-KAGmrU9iQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Nov 2023 13:21:02 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     shuah@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ast@kernel.org, steffen.klassert@secunet.com,
        antony.antony@secunet.com, alexei.starovoitov@gmail.com
Cc:     mykolal@fb.com, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@linux-ipsec.org, netdev@vger.kernel.org
Subject: [PATCH ipsec-next v1 3/7] bpf: selftests: test_tunnel: Use ping -6 over ping6
Date:   Wed, 22 Nov 2023 11:20:24 -0700
Message-ID: <4c6de574f5de959ca5af77f4463e119186ac3202.1700676682.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1700676682.git.dxu@dxuuu.xyz>
References: <cover.1700676682.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ping6 binary went away over 7 years ago [0].

[0]: https://github.com/iputils/iputils/commit/ebad35fee3de851b809c7b72ccc654a72b6af61d

Co-developed-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/testing/selftests/bpf/test_tunnel.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_tunnel.sh b/tools/testing/selftests/bpf/test_tunnel.sh
index 2dec7dbf29a2..85ba39992461 100755
--- a/tools/testing/selftests/bpf/test_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tunnel.sh
@@ -295,13 +295,13 @@ test_ip6gre()
 	add_ip6gretap_tunnel
 	attach_bpf $DEV ip6gretap_set_tunnel ip6gretap_get_tunnel
 	# underlay
-	ping6 $PING_ARG ::11
+	ping -6 $PING_ARG ::11
 	# overlay: ipv4 over ipv6
 	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
 	ping $PING_ARG 10.1.1.100
 	check_err $?
 	# overlay: ipv6 over ipv6
-	ip netns exec at_ns0 ping6 $PING_ARG fc80::200
+	ip netns exec at_ns0 ping -6 $PING_ARG fc80::200
 	check_err $?
 	cleanup
 
@@ -324,13 +324,13 @@ test_ip6gretap()
 	add_ip6gretap_tunnel
 	attach_bpf $DEV ip6gretap_set_tunnel ip6gretap_get_tunnel
 	# underlay
-	ping6 $PING_ARG ::11
+	ping -6 $PING_ARG ::11
 	# overlay: ipv4 over ipv6
 	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
 	ping $PING_ARG 10.1.1.100
 	check_err $?
 	# overlay: ipv6 over ipv6
-	ip netns exec at_ns0 ping6 $PING_ARG fc80::200
+	ip netns exec at_ns0 ping -6 $PING_ARG fc80::200
 	check_err $?
 	cleanup
 
@@ -376,7 +376,7 @@ test_ip6erspan()
 	config_device
 	add_ip6erspan_tunnel $1
 	attach_bpf $DEV ip4ip6erspan_set_tunnel ip4ip6erspan_get_tunnel
-	ping6 $PING_ARG ::11
+	ping -6 $PING_ARG ::11
 	ip netns exec at_ns0 ping $PING_ARG 10.1.1.200
 	check_err $?
 	cleanup
@@ -474,7 +474,7 @@ test_ipip6()
 	ip link set dev veth1 mtu 1500
 	attach_bpf $DEV ipip6_set_tunnel ipip6_get_tunnel
 	# underlay
-	ping6 $PING_ARG ::11
+	ping -6 $PING_ARG ::11
 	# ip4 over ip6
 	ping $PING_ARG 10.1.1.100
 	check_err $?
@@ -502,11 +502,11 @@ test_ip6ip6()
 	ip link set dev veth1 mtu 1500
 	attach_bpf $DEV ip6ip6_set_tunnel ip6ip6_get_tunnel
 	# underlay
-	ping6 $PING_ARG ::11
+	ping -6 $PING_ARG ::11
 	# ip6 over ip6
-	ping6 $PING_ARG 1::11
+	ping -6 $PING_ARG 1::11
 	check_err $?
-	ip netns exec at_ns0 ping6 $PING_ARG 1::22
+	ip netns exec at_ns0 ping -6 $PING_ARG 1::22
 	check_err $?
 	cleanup
 
-- 
2.42.1

