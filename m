Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF3F8114C1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441976AbjLMOfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441923AbjLMOfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:35:50 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A108BD0;
        Wed, 13 Dec 2023 06:35:56 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 5b1f17b1804b1-40c2c65e6aaso72109025e9.2;
        Wed, 13 Dec 2023 06:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702478155; x=1703082955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUFSFbFgIum2NtAhJnNBP5hxWvYwzYJYVb9Fw/rpe9A=;
        b=f2rmOjrxmKRrbgQfkPYSgdaz2dxj911vkdvO9Ny+U1hkJy7ieHVUlmfucrF07LiKfX
         xsLpuS5VuFvO0YpyaKKsvjYTCs0CVLJ2KV2EOv3Ofh6PxPww/gTqNhxCHobhuhPEhpTm
         79yb+aVqIDcDM4tOQqQTg+INulSm6m939vOECrBMBmb7x/yD/SNKpqyL9xxYMw/e8Tek
         AfMmMeGdgGsSpoyxINFEoHPyFlrI04OjpHpDz0cQJ0KSOy2G4WcHQPw4sIDsBfhqE4BU
         OFbzNp4XzYujkCJKylxuqryJe281qVOC0h6mReeGhbT8tFKUNHYQXcuyrO4NLMap7q4/
         U0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702478155; x=1703082955;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nUFSFbFgIum2NtAhJnNBP5hxWvYwzYJYVb9Fw/rpe9A=;
        b=LXO8Zd3Xdgh3I+FBunhfOBybW8QbyeYWLrqGN9YNJp0YXGoj/9TVne6j/rwqPH8OBc
         4eD1scV81p/uZlIpC8ufffHdnMcwvl0ME3er3Pk9HxIjcLKKosj2vkNycAYmyW6c3kw+
         d9agR7AZcFkDmh3WeYUIbNMcPKnXffv99V7aar3FQUJb91rGBUpCaivZ5+7qCw7ICAII
         pcT3Q5UOFvO+StgCONZ3v6nT+PGr/wULAZpFZpKKUjlTKSx2a1g1E/qcr74tgDcLkJzA
         sZzGzu3J1ZknidAXWT62cnnjGr91oFjI+0JACpwwwwYZy7CVKch0E0iWSsgMbhw6SIHN
         /gag==
X-Gm-Message-State: AOJu0Yxbl/xzVBvU/BC9RudpGYGKfKq5/RjXWHgdBGYZYRrFMcdr0gsI
        03RqjQZtXpr4elJJFGePi1FEnUy+a4lXyMtc
X-Google-Smtp-Source: AGHT+IHH2DLkhZJfogZupcuD9ipfyMZH25Ro9qMHMsMnFpHPnwDdvFgUHUPTzm/6osDEIjFIHpoL3Q==
X-Received: by 2002:a05:600c:1394:b0:40c:55a7:770f with SMTP id u20-20020a05600c139400b0040c55a7770fmr1119780wmf.159.1702478154820;
        Wed, 13 Dec 2023 06:35:54 -0800 (PST)
Received: from [10.0.3.3] ([217.212.240.69])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c4f9500b0040b36ad5413sm20112472wmq.46.2023.12.13.06.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 06:35:54 -0800 (PST)
Message-ID: <ac24d9b6-bfff-4700-a301-d4bd0dbb9313@gmail.com>
Date:   Wed, 13 Dec 2023 15:33:19 +0100
MIME-Version: 1.0
Content-Language: en-US
From:   Leone Fernando <leone4fernando@gmail.com>
Subject: [PATCH net] ipmr: support IP_PKTINFO on cache report IGMP msg
To:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, willemdebruijn.kernel@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        leone4fernando@gmail.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support IP_PKTINFO on those packets, we need to call
ipv4_pktinfo_prepare, so introduced minor changes to this
function to support this flow.

When sending mrouted/pimd daemons a cache report IGMP msg, it is
unnecessary to set dst on the newly created skb.
It used to be necessary on older versions until
commit d826eb14ecef ("ipv4: PKTINFO doesnt need dst reference") which
changed the way IP_PKTINFO struct is been retrieved.

Fixes: d826eb14ecef ("ipv4: PKTINFO doesnt need dst reference")
Signed-off-by: Leone Fernando <leone4fernando@gmail.com>
---
 include/net/ip.h       | 10 +++++++++-
 net/ipv4/ip_sockglue.c | 25 ++++++++++++++++---------
 net/ipv4/ipmr.c        | 12 +++++-------
 net/ipv4/raw.c         |  2 +-
 net/ipv4/udp.c         |  2 +-
 5 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index b31be912489a..1b40b7386c56 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -767,7 +767,15 @@ int ip_options_rcv_srr(struct sk_buff *skb, struct net_device *dev);
  *	Functions provided by ip_sockglue.c
  */
 
-void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb);
+void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *iskb,
+			struct sk_buff *oskb);
+
+
+static inline void ipv4_pktinfo_input_prepare(const struct sock *sk, struct sk_buff *skb)
+{
+	ipv4_pktinfo_prepare(sk, skb, NULL);
+}
+
 void ip_cmsg_recv_offset(struct msghdr *msg, struct sock *sk,
 			 struct sk_buff *skb, int tlen, int offset);
 int ip_cmsg_send(struct sock *sk, struct msghdr *msg,
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index d7d13940774e..fb26963e3869 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1364,19 +1364,26 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 /**
  * ipv4_pktinfo_prepare - transfer some info from rtable to skb
  * @sk: socket
- * @skb: buffer
+ * @iskb: input buffer
+ * @oskb: out buffer
  *
  * To support IP_CMSG_PKTINFO option, we store rt_iif and specific
  * destination in skb->cb[] before dst drop.
  * This way, receiver doesn't make cache line misses to read rtable.
  */
-void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb)
+void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *iskb,
+			  struct sk_buff *oskb)
 {
-	struct in_pktinfo *pktinfo = PKTINFO_SKB_CB(skb);
+	struct in_pktinfo *pktinfo = PKTINFO_SKB_CB(iskb);
 	bool prepare = inet_test_bit(PKTINFO, sk) ||
 		       ipv6_sk_rxinfo(sk);
 
-	if (prepare && skb_rtable(skb)) {
+	if (oskb) {
+		memcpy(oskb->cb, iskb->cb, sizeof(iskb->cb));
+		pktinfo = PKTINFO_SKB_CB(oskb);
+	}
+
+	if (prepare && skb_rtable(iskb)) {
 		/* skb->cb is overloaded: prior to this point it is IP{6}CB
 		 * which has interface index (iif) as the first member of the
 		 * underlying inet{6}_skb_parm struct. This code then overlays
@@ -1386,20 +1393,20 @@ void ipv4_pktinfo_prepare(const struct sock *sk, struct sk_buff *skb)
 		 * (e.g., process binds socket to eth0 for Tx which is
 		 * redirected to loopback in the rtable/dst).
 		 */
-		struct rtable *rt = skb_rtable(skb);
-		bool l3slave = ipv4_l3mdev_skb(IPCB(skb)->flags);
+		struct rtable *rt = skb_rtable(iskb);
+		bool l3slave = ipv4_l3mdev_skb(IPCB(iskb)->flags);
 
 		if (pktinfo->ipi_ifindex == LOOPBACK_IFINDEX)
-			pktinfo->ipi_ifindex = inet_iif(skb);
+			pktinfo->ipi_ifindex = inet_iif(iskb);
 		else if (l3slave && rt && rt->rt_iif)
 			pktinfo->ipi_ifindex = rt->rt_iif;
 
-		pktinfo->ipi_spec_dst.s_addr = fib_compute_spec_dst(skb);
+		pktinfo->ipi_spec_dst.s_addr = fib_compute_spec_dst(iskb);
 	} else {
 		pktinfo->ipi_ifindex = 0;
 		pktinfo->ipi_spec_dst.s_addr = 0;
 	}
-	skb_dst_drop(skb);
+	skb_dst_drop(iskb);
 }
 
 int ip_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 9e222a57bc2b..6ed7c88743f9 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1025,6 +1025,10 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 	struct sk_buff *skb;
 	int ret;
 
+	mroute_sk = rcu_dereference(mrt->mroute_sk);
+	if (!mroute_sk)
+		return -EINVAL;
+
 	if (assert == IGMPMSG_WHOLEPKT || assert == IGMPMSG_WRVIFWHOLE)
 		skb = skb_realloc_headroom(pkt, sizeof(struct iphdr));
 	else
@@ -1069,7 +1073,7 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		msg = (struct igmpmsg *)skb_network_header(skb);
 		msg->im_vif = vifi;
 		msg->im_vif_hi = vifi >> 8;
-		skb_dst_set(skb, dst_clone(skb_dst(pkt)));
+		ipv4_pktinfo_prepare(mroute_sk, pkt, skb);
 		/* Add our header */
 		igmp = skb_put(skb, sizeof(struct igmphdr));
 		igmp->type = assert;
@@ -1079,12 +1083,6 @@ static int ipmr_cache_report(const struct mr_table *mrt,
 		skb->transport_header = skb->network_header;
 	}
 
-	mroute_sk = rcu_dereference(mrt->mroute_sk);
-	if (!mroute_sk) {
-		kfree_skb(skb);
-		return -EINVAL;
-	}
-
 	igmpmsg_netlink_event(mrt, skb);
 
 	/* Deliver to mrouted */
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 27da9d7294c0..cde60c8deed4 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -292,7 +292,7 @@ static int raw_rcv_skb(struct sock *sk, struct sk_buff *skb)
 
 	/* Charge it to the socket. */
 
-	ipv4_pktinfo_prepare(sk, skb);
+	ipv4_pktinfo_input_prepare(sk, skb);
 	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0) {
 		kfree_skb_reason(skb, reason);
 		return NET_RX_DROP;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 89e5a806b82e..3e5a418c96c3 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2169,7 +2169,7 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 
 	udp_csum_pull_header(skb);
 
-	ipv4_pktinfo_prepare(sk, skb);
+	ipv4_pktinfo_input_prepare(sk, skb);
 	return __udp_queue_rcv_skb(sk, skb);
 
 csum_error:
-- 
2.34.1

