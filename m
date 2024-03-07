Return-Path: <linux-kernel+bounces-95921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C215B8754F9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CF78B24B42
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66FE133291;
	Thu,  7 Mar 2024 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+UE7Dnr"
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB91130E55;
	Thu,  7 Mar 2024 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831596; cv=none; b=Lrx0lsRSrhRDF7JEMBm/mSIisyG+okstLs4wkc6/YDcSTa/01of2C37Y6VJIsDu0WvbudTvDWQvJwLOa6w0PqLU9m2WLnu/0IyW3mq//YOaDknGwZ24taafd/bcGT8cngC+jR5nNGHhzvBAJ4psD+pvDQaxHrCMr7zTsqLbf5oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831596; c=relaxed/simple;
	bh=D0dSVHSuci7gj5wzLl4A5UtYxHnqjhZpKwqkQF5Ompg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fFIa9ape78de6VcURp+6/HWjShdiJzLFXo/k6Y+OuBCSyH+aD5G2niiXoDEbsGif8Y0IDOoCJ4P+eruN8SkVGQLVdxQqDFIqAZ31a5wCtfkCk7rBokmikmsGOtDHLSAQA9H2MowTZyG5XQx9sbwELaZ8lBUESYsJRp4HgO2zbiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+UE7Dnr; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-41315e5ca60so1940715e9.1;
        Thu, 07 Mar 2024 09:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709831593; x=1710436393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5V7isOPkOkpIn0RzBMGkGVuMIHctht21G0fcVyOfHzU=;
        b=b+UE7Dnr9xegh4qDNLbCBJrs4yFhtk53iGepQ0f3JotXnS7Dajd7yyQesCDbyIXbaI
         kO9N6TJp0MNPdk+nqRu7T20PrMjOYNxGX2KoS3LjvINrn3mUTV3/Poq2cBbKrnjUpae+
         9ZUj4EPhkaWldA+YAhHgHKM5XwIOEdnJ5+hlxtGbuDQ9QDNmcya3I9zl+g4nVYW8aDb2
         hPlnt3wSWmpnZDqLm9+XP3/kzlGxg+ksqXUGv36bHkuPFWq5o5SkTDqutVX/7u6/aW4h
         1JncrwDGE/2GYk9sMZAIPY5T0/Dfl96sx0qwpBYTlKvTH/pgLKTUHU49NtzPtNG1688J
         Pn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709831593; x=1710436393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5V7isOPkOkpIn0RzBMGkGVuMIHctht21G0fcVyOfHzU=;
        b=Yt7HYC3Vj0DfqNhDdmlQ4wodL9JIAqks2YwJz5e739+9OE/NSogw4jutavzXUz49EQ
         dVs78vcTd39nin9eXsNfWUq9Uhq+IxzETLLUGKwozkXEDny2JsDDJjJ7Gy81UQ0d95aX
         HK7570GpfWZ3f2dqKuRGwgT5mXtfNzl7lX5yBeRxiVc9lw3Cftap71BrU+7T7IT4H+Ff
         m96i4tIPMwME/29P8pKg/LUULXO+WXaWed4w5/TBUjWDD/HA3YK9uLYcARBwn5zkDZCV
         RdlVF/+ToKvBdysrAATcEAXQueByv2FJMHBqmwmCr8veXoAj1eFVR3EzMkChnXhqCxvN
         RFXg==
X-Forwarded-Encrypted: i=1; AJvYcCU0LP9xcoy0Esmfhx5VqdyKTl+Cez5m1hZbFrphVEzASFtcDQuZTlvsoAhgrRffvBRmHanVx7VZw5nXilw8FigJwd2EtQ/ztuQkDaIw
X-Gm-Message-State: AOJu0YwNK9vHk7nLCGdKFyMvNJXPu7U88iz8jw7BxUsLAEt1WbKe5Foy
	PvJufRyxe+8sU17ggmlL7xokBoFYi36QVVG+H2q/zpQmK+YZlk1nAbInJVOApto=
X-Google-Smtp-Source: AGHT+IFERP2NHl4mUWdFZzZiQRER2saahhN68LE0apjl0jhnbYFsjuO/JpqGhvowbRFfywjuwJ4KHg==
X-Received: by 2002:a05:600c:4589:b0:412:bca4:6a00 with SMTP id r9-20020a05600c458900b00412bca46a00mr1948568wmo.18.1709831593055;
        Thu, 07 Mar 2024 09:13:13 -0800 (PST)
Received: from localhost ([45.130.85.5])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b00412f12f00adsm3318759wmo.10.2024.03.07.09.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 09:13:12 -0800 (PST)
From: Leone Fernando <leone4fernando@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemb@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leone Fernando <leone4fernando@gmail.com>
Subject: [PATCH net-next 4/4] net: route: replace route hints with input_dst_cache
Date: Thu,  7 Mar 2024 18:12:02 +0100
Message-Id: <20240307171202.232684-5-leone4fernando@gmail.com>
In-Reply-To: <20240307171202.232684-1-leone4fernando@gmail.com>
References: <20240307171202.232684-1-leone4fernando@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace route hints with cached dsts - ip_rcv_finish_core will first try
to use the cache and only then fall back to the demux or perform a full
lookup.

Only add newly found dsts to the cache after all the checks have passed
successfully to avoid adding a dropped packet's dst to the cache.

Multicast dsts are not added to the dst_cache as it will require additional
checks and multicast packets are rarer and a slower path anyway.

A check was added to ip_route_use_dst_cache that prevents forwarding
packets received by devices for which forwarding is disabled.

Relevant checks were added to ip_route_use_dst_cache to make sure the
dst can be used and to ensure IPCB(skb) flags are correct.

Signed-off-by: Leone Fernando <leone4fernando@gmail.com>
---
 include/net/route.h |  6 ++--
 net/ipv4/ip_input.c | 58 +++++++++++++++++++-----------------
 net/ipv4/route.c    | 72 +++++++++++++++++++++++++++++++++------------
 3 files changed, 88 insertions(+), 48 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index d4a0147942f1..0940383719a0 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -186,9 +186,9 @@ int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
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
index 73e742424e97..e7de683f7b49 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1787,6 +1787,24 @@ static void ip_handle_martian_source(struct net_device *dev,
 #endif
 }
 
+static void ip_route_set_doredirect(struct in_device *in_dev,
+				    struct in_device *out_dev,
+				    struct sk_buff *skb,
+				    u8 gw_family,
+				    __be32 gw4,
+				    __be32 saddr)
+{
+	if (out_dev == in_dev && IN_DEV_TX_REDIRECTS(out_dev) &&
+	    skb->protocol == htons(ETH_P_IP)) {
+		__be32 gw;
+
+		gw = gw_family == AF_INET ? gw4 : 0;
+		if (IN_DEV_SHARED_MEDIA(out_dev) ||
+		    inet_addr_onlink(out_dev, saddr, gw))
+			IPCB(skb)->flags |= IPSKB_DOREDIRECT;
+	}
+}
+
 /* called in rcu_read_lock() section */
 static int __mkroute_input(struct sk_buff *skb,
 			   const struct fib_result *res,
@@ -1819,15 +1837,10 @@ static int __mkroute_input(struct sk_buff *skb,
 	}
 
 	do_cache = res->fi && !itag;
-	if (out_dev == in_dev && err && IN_DEV_TX_REDIRECTS(out_dev) &&
-	    skb->protocol == htons(ETH_P_IP)) {
-		__be32 gw;
-
-		gw = nhc->nhc_gw_family == AF_INET ? nhc->nhc_gw.ipv4 : 0;
-		if (IN_DEV_SHARED_MEDIA(out_dev) ||
-		    inet_addr_onlink(out_dev, saddr, gw))
-			IPCB(skb)->flags |= IPSKB_DOREDIRECT;
-	}
+	if (err)
+		ip_route_set_doredirect(in_dev, out_dev, skb,
+					nhc->nhc_gw_family,
+					nhc->nhc_gw.ipv4, saddr);
 
 	if (skb->protocol != htons(ETH_P_IP)) {
 		/* Not IP (i.e. ARP). Do not create route, if it is
@@ -2157,14 +2170,15 @@ static int ip_mkroute_input(struct sk_buff *skb,
 
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
+	struct in_device *out_dev = __in_dev_get_rcu(dst->dev);
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
-	struct rtable *rt = skb_rtable(hint);
+	struct rtable *rt = (struct rtable *)dst;
 	struct net *net = dev_net(dev);
 	int err = -EINVAL;
 	u32 tag = 0;
@@ -2178,21 +2192,43 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
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
 
+	if (err)
+		ip_route_set_doredirect(in_dev, out_dev, skb, rt->rt_gw_family,
+					rt->rt_gw4, saddr);
+
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
@@ -2213,7 +2249,7 @@ static struct net_device *ip_rt_get_dev(struct net *net,
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


