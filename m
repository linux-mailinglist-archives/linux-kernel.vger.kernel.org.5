Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E9D7B5A90
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbjJBStp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjJBStn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:49:43 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2469B;
        Mon,  2 Oct 2023 11:49:39 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2bfea381255so581751fa.3;
        Mon, 02 Oct 2023 11:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696272578; x=1696877378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QArjfUTTcgJwwXB2cHAnDmcQypRbqPPM7kA043mYYzA=;
        b=Y1/N4ixQxacvshz2OvOUeh5iTSNIMmzW6fz938wKqu/3SKX54FuSXkYB1dPE6spDot
         w8O5KHTT0PMnKxMKXJNsq0dZCrfiDO0tybQKmV2GTmUE2op+GjXrt0BBUHMCCwFGEmCm
         Z1pvQ8H+xQ9j/+qFq94swx4oAG3QJbxllBFP3v3K1BtiDiIwhdwCtomlpveuursCcjN7
         wmtqapB0UCug3SEbxy4nMBNfwUKBOIOsvJqqGWML19gqWGM7kuZxK0Men9PuPD8xwkBq
         iGt+c4dUj3URFEtwJfGU0JUKnWcruwbJ0PpQnSwFBLSN5gZOCI4/KQLghXzy7KE3QBlW
         tUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696272578; x=1696877378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QArjfUTTcgJwwXB2cHAnDmcQypRbqPPM7kA043mYYzA=;
        b=urpi3N2YdXOe/oR+TQTkqPj4LNouOBg6G1VvQLQvr/3HKpspFf2P19QyeDJPLO2IZ8
         6xulmlfso+YppN5M6mKQZDMX3M3GUb0so/gclPZqzqDQ1sOM4oNvnubjwoeSnx3myOYb
         4zmH9STm9+OV37U0uwI7mi/7nbaAIYVMHkPlBBa0T+ip/TQ/Xtwfj7Jlgvz6uEWZ2cNS
         GN8nO8AKRCff7flu6pSp6L5PrYuVDIKrfyOb7GD6fybo+iS9FXyHLzkdjh8n9dewM9wH
         mVf8biIxPG/riR9TFr/G/QtEVB35w6p5oLnnnTY2XgbJ/62tpEmJ+jS+JksQNemewCPL
         ClRg==
X-Gm-Message-State: AOJu0Yw9C06BOK2h4BErxNt+r0VOIsh3ndZjwUxs0dPtqT51LpbTilu8
        BCzhj1VaA7V0wPzDRAjWL+A=
X-Google-Smtp-Source: AGHT+IH3M+qevVH7Kr9KnZ3kt9CcZO9iV+yGM+179shLGbvDskmG59LydCDjwjajO6Hvh17XAOJKvQ==
X-Received: by 2002:a05:6512:2813:b0:4fb:caed:95c3 with SMTP id cf19-20020a056512281300b004fbcaed95c3mr12030931lfb.53.1696272577665;
        Mon, 02 Oct 2023 11:49:37 -0700 (PDT)
Received: from pc.localnet (c-7e17235c.012-196-6c6b701.bbcust.telenor.se. [92.35.23.126])
        by smtp.gmail.com with ESMTPSA id f21-20020a19ae15000000b00500d1f67be9sm4820914lfc.43.2023.10.02.11.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 11:49:37 -0700 (PDT)
From:   Henrik =?ISO-8859-1?Q?Lindstr=F6m?= <lindstrom515@gmail.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: macvtap performs IP defragmentation,
 causing MTU problems for virtual machines
Date:   Mon, 02 Oct 2023 20:49:36 +0200
Message-ID: <2197902.NgBsaNRSFp@pc>
In-Reply-To: <20231002092010.GA30843@breakpoint.cc>
References: <CAHkKap3sdN4wZm_euAZEyt3XB4bvr6cV-oAMGtrmrm5Z8biZ_Q@mail.gmail.com>
 <20231002092010.GA30843@breakpoint.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Had to change "return 0" to "return vif" but other than that your changes
seem to work, even with macvlan defragmentation removed.

I tested it by sending 8K fragmented multicast packets, with 5 macvlans on
the receiving side. I consistently received 6 copies of the packet (1 from the
real interface and 1 per macvlan). While doing this i had my VM running with
a macvtap, and it was receiving fragmented packets as expected.

Here are the changes i was testing with, first time sending a diff over mail
so hope it works :-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 02bd201bc7e5..5f638433cef9 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -462,10 +462,6 @@ static rx_handler_result_t macvlan_handle_frame(struct sk_buff **pskb)
 	if (is_multicast_ether_addr(eth->h_dest)) {
 		unsigned int hash;
 
-		skb = ip_check_defrag(dev_net(skb->dev), skb, IP_DEFRAG_MACVLAN);
-		if (!skb)
-			return RX_HANDLER_CONSUMED;
-		*pskb = skb;
 		eth = eth_hdr(skb);
 		if (macvlan_forward_source(skb, port, eth->h_source)) {
 			kfree_skb(skb);
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index a4941f53b523..30b822dfa222 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -479,11 +479,29 @@ static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
 	return err;
 }
 
+static int ip_defrag_vif(const struct sk_buff *skb, const struct net_device *dev)
+{
+	int vif = l3mdev_master_ifindex_rcu(dev);
+
+	if (vif)
+		return vif;
+
+	/* some folks insist that receiving a fragmented mcast dgram on n devices shall
+	 * result in n defragmented packets.
+	 */
+	if (skb->pkt_type == PACKET_BROADCAST || skb->pkt_type == PACKET_MULTICAST) {
+		if (dev)
+			vif = dev->ifindex;
+	}
+
+	return vif;
+}
+
 /* Process an incoming IP datagram fragment. */
 int ip_defrag(struct net *net, struct sk_buff *skb, u32 user)
 {
 	struct net_device *dev = skb->dev ? : skb_dst(skb)->dev;
-	int vif = l3mdev_master_ifindex_rcu(dev);
+	int vif = ip_defrag_vif(skb, dev);
 	struct ipq *qp;
 
 	__IP_INC_STATS(net, IPSTATS_MIB_REASMREQDS);



