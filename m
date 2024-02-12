Return-Path: <linux-kernel+bounces-61439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 127C6851257
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E380B25394
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99983985A;
	Mon, 12 Feb 2024 11:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9xk1CHq"
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207A238FB0;
	Mon, 12 Feb 2024 11:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707737728; cv=none; b=ECnZMpeFUkCcCFo1xFoWkj+f8fANQ0blXeTjRO9GGxCH7xS3JozVIKMNQ83yS0aC/U/cbOTo3Cdh3ltgpOpXRMYObEEbJXa8ciqMIKLofONmXYmqJnjQkIWTXWWeTcZdqsDRiah5OnLeAirFiTIXgilLbWRsjWDRlB81RMrBKPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707737728; c=relaxed/simple;
	bh=ZJSyLgJ61nDMOcehRqEBFXo3jWlONyIZTqzQ93mmFDQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=hhbUiGnIsBXGspp1Mm9MTR/sl6JKLpvT9snG3k0Dv8s3LC90EApsVEfcmG3t2TrbRdCn2neVCpdIkbmM2xMbG4RcHNxY4aZnlZbk0HE45ElY+U8ZSO+LwDxfvTQeasOlZ7IT/yMqiVZ+LT5XXyZ5B9uFkozOT4VOuyVQ0FANi+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9xk1CHq; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-5114c05806eso4796806e87.1;
        Mon, 12 Feb 2024 03:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707737725; x=1708342525; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=500hpU7ciKstMts7ME1z4g/cj3B8hAa7ln6Zs2/XYoA=;
        b=f9xk1CHquk/oG43cuEF2YAYafe8mFVNOOrN7hCMQJk3D0rhEAbc67mdlJFIyqhQhls
         h8NMM7aO+9zUdmz4ha4gzMZ3sVlPodbNUPm3l0D3UxW/TOeGfKH8KoKHgLmyIcQZEKwa
         0Zcg4Gu/1giMhY8kDnSffHkzMfEVALp7zfLIb/1JwFUNQxkVHvbzOJvwS82x52AhBAjT
         2QAP6RRni33C3tpp4ImOfLAPLdYO40JHUdLu4ibQTsFFUrsg53Dymnb4BeeFsOc9Qv7t
         2JRLIUa7ic/adOTrO8asG5rrTgz5ydsA8fCjxcf3BFb9YpXfQ+vDXOA4qa2bCIx9q5np
         Z0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707737725; x=1708342525;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=500hpU7ciKstMts7ME1z4g/cj3B8hAa7ln6Zs2/XYoA=;
        b=uhFGp/zlSrxk91X6kE4G5EHwkV8i1Snp+fEFu8XhYVuzYwZSw6ow6zSM20XGy6e8zC
         MQahAfyrym3oYBtQgGCwMXCYriUJUiqia8YbN5KDmEq/QEAB4ymE76oSYZEFiWyRgCYw
         qnXJi4JX778P+mLoQgAcZtk2ylWjqG8uusvmiehwxxZH78hBSn8H/81NC6FYwzFSAvHO
         lCMKSVoFS1AbaYUOtXKlvujYAtAMvSxXb6F4erYsO/kk2mfS9OB2OU84ZMr+o5OHE54r
         Oo3IdPeJfUDj+4+wnlfL6ePmPx3aXqYoFebNWtUGYF+ql/ayDwA3Z1WR2mb418n5mq3w
         TsUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHZLd8PTrvzb7XZEeYOUBmxdyYXCdnXwhv0Jp37a/Z1XJKxuu3UgWSxvNlfiGAGvf5B3F83z8yYNtCxfgFszcGsw3gKq8yOyv3Tj0I4kWhoHZYUTVNlOx2LlD8/RayXUsZfLpY
X-Gm-Message-State: AOJu0YzZMSCWYbhGFmXA7dngcexIf6lww8J/vVX8vaLlAWkFKyw5r7th
	QJ+Z9grO1wqmNF9cQK0aZUgwLnLRq3XJH6PiJYzILQaCFDpA6SL2
X-Google-Smtp-Source: AGHT+IFpUNu7JBK53C8guILQZxtsAyLk8WnpfH9BF4OYbl5iUfh/HGxaJH08+ixnH7gdiPlAaQi37Q==
X-Received: by 2002:a05:6512:2035:b0:511:5653:16ae with SMTP id s21-20020a056512203500b00511565316aemr3826974lfs.42.1707737724901;
        Mon, 12 Feb 2024 03:35:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUC+1Mo00QG71a+rUD67i+BEwwj7KGFAT5ux0lXrJZo6h2psbYW8vhlqnJA0urpsYBLP4f4H3Oopo50jmc3Y8uNRP5nAmRJ2JwqSqcKc6uZJyQaK8iBhkKmg+BfVVrTewsdlwcWv0U2Fw0D3D8T21kR5yh08soHDfJOeqATAggn9YbknNSgGC4OmqvvysVS28hSUmnfACGN0q7LqsEhpKWA+8UxAX4h0WcYPAUk+dLTm7I=
Received: from localhost ([45.130.85.2])
        by smtp.gmail.com with ESMTPSA id r17-20020a05600c35d100b004106c2278eesm8459064wmq.0.2024.02.12.03.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 03:35:24 -0800 (PST)
Message-ID: <484f2e68-a5d0-4ddb-9f7b-22acd95d4cce@gmail.com>
Date: Mon, 12 Feb 2024 12:34:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [RFC PATCH net-next v2 3/3] net: route: replace route hints with
 input_dst_cache
Content-Language: en-US
From: Leone Fernando <leone4fernando@gmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <3a17c86d-08a5-46d2-8622-abc13d4a411e@gmail.com>
In-Reply-To: <3a17c86d-08a5-46d2-8622-abc13d4a411e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Replace route hints with cached dsts - ip_rcv_finish_core will first try
to use the cache and only then fall back to the demux or perform a full
lookup.

Only add newly found dsts to the cache after all the checks have passed
successfully to avoid adding a dropped packet's dst to the cache.

Multicast dsts are not added to the dst_cache as it will require additional
checks and multicast packets are rarer and a slower path anyway.

A check was added to ip_route_use_dst_cache that prevents forwarding
packets received by devices for which forwarding is disabled.

Signed-off-by: Leone Fernando <leone4fernando@gmail.com>
---
 include/net/route.h |  6 ++---
 net/ipv4/ip_input.c | 58 ++++++++++++++++++++++++---------------------
 net/ipv4/route.c    | 36 +++++++++++++++++++++-------
 3 files changed, 61 insertions(+), 39 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index 980ab474eabd..a5a2f55947d6 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -189,9 +189,9 @@ int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			  struct in_device *in_dev, u32 *itag);
 int ip_route_input_noref(struct sk_buff *skb, __be32 dst, __be32 src,
 			 u8 tos, struct net_device *devin);
-int ip_route_use_hint(struct sk_buff *skb, __be32 dst, __be32 src,
-		      u8 tos, struct net_device *devin,
-		      const struct sk_buff *hint);
+int ip_route_use_dst_cache(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+			   u8 tos, struct net_device *dev,
+			   struct dst_entry *dst);
 
 static inline int ip_route_input(struct sk_buff *skb, __be32 dst, __be32 src,
 				 u8 tos, struct net_device *devin)
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 5e9c8156656a..35c8b122d62f 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -305,30 +305,44 @@ static inline bool ip_rcv_options(struct sk_buff *skb, struct net_device *dev)
 	return true;
 }
 
-static bool ip_can_use_hint(const struct sk_buff *skb, const struct iphdr *iph,
-			    const struct sk_buff *hint)
+static bool ip_can_add_dst_cache(struct sk_buff *skb, __u16 rt_type)
 {
-	return hint && !skb_dst(skb) && ip_hdr(hint)->daddr == iph->daddr &&
-	       ip_hdr(hint)->tos == iph->tos;
+	return skb_valid_dst(skb) &&
+	       rt_type != RTN_BROADCAST &&
+	       rt_type != RTN_MULTICAST &&
+	       !(IPCB(skb)->flags & IPSKB_MULTIPATH);
+}
+
+static bool ip_can_use_dst_cache(const struct net *net, struct sk_buff *skb)
+{
+	return !skb_dst(skb) && !fib4_has_custom_rules(net);
 }
 
 int tcp_v4_early_demux(struct sk_buff *skb);
 int udp_v4_early_demux(struct sk_buff *skb);
 static int ip_rcv_finish_core(struct net *net, struct sock *sk,
-			      struct sk_buff *skb, struct net_device *dev,
-			      const struct sk_buff *hint)
+			      struct sk_buff *skb, struct net_device *dev)
 {
+	struct dst_cache *dst_cache = net_generic(net, dst_cache_net_id);
 	const struct iphdr *iph = ip_hdr(skb);
+	struct dst_entry *dst;
 	int err, drop_reason;
 	struct rtable *rt;
+	bool do_cache;
 
 	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 
-	if (ip_can_use_hint(skb, iph, hint)) {
-		err = ip_route_use_hint(skb, iph->daddr, iph->saddr, iph->tos,
-					dev, hint);
-		if (unlikely(err))
-			goto drop_error;
+	do_cache = ip_can_use_dst_cache(net, skb);
+	if (do_cache) {
+		dst = dst_cache_input_get_noref(dst_cache, skb);
+		if (dst) {
+			err = ip_route_use_dst_cache(skb, iph->daddr,
+						     iph->saddr, iph->tos,
+						     dev, dst);
+			if (unlikely(err))
+				goto drop_error;
+			do_cache = false;
+		}
 	}
 
 	if (READ_ONCE(net->ipv4.sysctl_ip_early_demux) &&
@@ -418,6 +432,9 @@ static int ip_rcv_finish_core(struct net *net, struct sock *sk,
 		}
 	}
 
+	if (do_cache && ip_can_add_dst_cache(skb, rt->rt_type))
+		dst_cache_input_add(dst_cache, skb);
+
 	return NET_RX_SUCCESS;
 
 drop:
@@ -444,7 +461,7 @@ static int ip_rcv_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (!skb)
 		return NET_RX_SUCCESS;
 
-	ret = ip_rcv_finish_core(net, sk, skb, dev, NULL);
+	ret = ip_rcv_finish_core(net, sk, skb, dev);
 	if (ret != NET_RX_DROP)
 		ret = dst_input(skb);
 	return ret;
@@ -581,21 +598,11 @@ static void ip_sublist_rcv_finish(struct list_head *head)
 	}
 }
 
-static struct sk_buff *ip_extract_route_hint(const struct net *net,
-					     struct sk_buff *skb, int rt_type)
-{
-	if (fib4_has_custom_rules(net) || rt_type == RTN_BROADCAST ||
-	    IPCB(skb)->flags & IPSKB_MULTIPATH)
-		return NULL;
-
-	return skb;
-}
-
 static void ip_list_rcv_finish(struct net *net, struct sock *sk,
 			       struct list_head *head)
 {
-	struct sk_buff *skb, *next, *hint = NULL;
 	struct dst_entry *curr_dst = NULL;
+	struct sk_buff *skb, *next;
 	struct list_head sublist;
 
 	INIT_LIST_HEAD(&sublist);
@@ -610,14 +617,11 @@ static void ip_list_rcv_finish(struct net *net, struct sock *sk,
 		skb = l3mdev_ip_rcv(skb);
 		if (!skb)
 			continue;
-		if (ip_rcv_finish_core(net, sk, skb, dev, hint) == NET_RX_DROP)
+		if (ip_rcv_finish_core(net, sk, skb, dev) == NET_RX_DROP)
 			continue;
 
 		dst = skb_dst(skb);
 		if (curr_dst != dst) {
-			hint = ip_extract_route_hint(net, skb,
-					       ((struct rtable *)dst)->rt_type);
-
 			/* dispatch old sublist */
 			if (!list_empty(&sublist))
 				ip_sublist_rcv_finish(&sublist);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 7c5e68117ee2..3f1977f9b25c 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2157,14 +2157,14 @@ static int ip_mkroute_input(struct sk_buff *skb,
 
 /* Implements all the saddr-related checks as ip_route_input_slow(),
  * assuming daddr is valid and the destination is not a local broadcast one.
- * Uses the provided hint instead of performing a route lookup.
+ * Uses the provided dst from dst_cache instead of performing a route lookup.
  */
-int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-		      u8 tos, struct net_device *dev,
-		      const struct sk_buff *hint)
+int ip_route_use_dst_cache(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+			   u8 tos, struct net_device *dev,
+			   struct dst_entry *dst)
 {
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
-	struct rtable *rt = skb_rtable(hint);
+	struct rtable *rt = (struct rtable *)dst;
 	struct net *net = dev_net(dev);
 	int err = -EINVAL;
 	u32 tag = 0;
@@ -2178,21 +2178,39 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	if (ipv4_is_loopback(saddr) && !IN_DEV_NET_ROUTE_LOCALNET(in_dev, net))
 		goto martian_source;
 
-	if (rt->rt_type != RTN_LOCAL)
-		goto skip_validate_source;
+	if (ipv4_is_loopback(daddr) && !IN_DEV_NET_ROUTE_LOCALNET(in_dev, net))
+		goto martian_destination;
 
+	if (rt->rt_type != RTN_LOCAL) {
+		if (!IN_DEV_FORWARD(in_dev)) {
+			err = -EHOSTUNREACH;
+			goto out_err;
+		}
+		goto skip_validate_source;
+	}
 	tos &= IPTOS_RT_MASK;
 	err = fib_validate_source(skb, saddr, daddr, tos, 0, dev, in_dev, &tag);
 	if (err < 0)
 		goto martian_source;
 
 skip_validate_source:
-	skb_dst_copy(skb, hint);
+	skb_dst_set_noref(skb, dst);
 	return 0;
 
 martian_source:
 	ip_handle_martian_source(dev, in_dev, skb, daddr, saddr);
+out_err:
 	return err;
+
+martian_destination:
+	RT_CACHE_STAT_INC(in_martian_dst);
+#ifdef CONFIG_IP_ROUTE_VERBOSE
+		if (IN_DEV_LOG_MARTIANS(in_dev))
+			net_warn_ratelimited("martian destination %pI4 from %pI4, dev %s\n",
+					     &daddr, &saddr, dev->name);
+#endif
+	err = -EINVAL;
+	goto out_err;
 }
 
 /* get device for dst_alloc with local routes */
@@ -2213,7 +2231,7 @@ static struct net_device *ip_rt_get_dev(struct net *net,
  *	addresses, because every properly looped back packet
  *	must have correct destination already attached by output routine.
  *	Changes in the enforced policies must be applied also to
- *	ip_route_use_hint().
+ *	ip_route_use_dst_cache().
  *
  *	Such approach solves two big problems:
  *	1. Not simplex devices are handled properly.
-- 
2.34.1


