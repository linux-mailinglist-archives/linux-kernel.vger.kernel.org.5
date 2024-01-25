Return-Path: <linux-kernel+bounces-38631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F8483C36E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF8A1C22801
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF31B4F89D;
	Thu, 25 Jan 2024 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzV/VcN2"
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127884F605;
	Thu, 25 Jan 2024 13:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706188568; cv=none; b=QbkXyZH5ZtVYX7Cix82KPMQ6+qn9h+TuOL5e9D7fs+pd5G0apjVkfeFVKGDCLc1J948XCh/qJ/IOd2QgS4r5kpdqSLlTUMVp6f+C7Bs0o7B/1kk2+7ACg/N/NoC1DX605unvLvTMDeSn7M508ceCEZcG1Aq3fLNO3TxFVgFcAm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706188568; c=relaxed/simple;
	bh=ZJSyLgJ61nDMOcehRqEBFXo3jWlONyIZTqzQ93mmFDQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=T5v9H8ga0tTE/Mvy8KxwLFXQsfyxrgdi8ObID1oolvY8LVgFxIzMMvN33ZCKtkbMV1odW6l4Z9QfsU5Pi43sVkGbifNb2jyplHL/f+IIHeCcB0h3rG4AzXe9Ri2PGGHkFncvOyWOPwhLM6M7AC+ZAac5gTch92PIKd2KtudZ6Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzV/VcN2; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-40eb033c1b0so49385415e9.2;
        Thu, 25 Jan 2024 05:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706188565; x=1706793365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=500hpU7ciKstMts7ME1z4g/cj3B8hAa7ln6Zs2/XYoA=;
        b=hzV/VcN2vtA3h97Pv220nI77tf2wPx1ssSwaU9Dt/UipfkpHxosRD977I4bijwghmS
         nKv3VdremPFyZ2tV7XLziraX4wiwzTSwiPMjtlgb58EOE790cbboagn9ibZHvY/Ch2Ye
         4eFSyDId3oPHH2OPOyrtJhc0cVMbGloV5hmqC76cS7EFMglscmtpntK9CA3NHcIPPY7t
         u/RdFx8FclBayOI3YvxBoRz+e21uuKHBo9RW+iGAId01THqnA6EHi3gVn3ZqE2GCJOP0
         J2dcTr0t8p6PvtDFmEkqOLdA7Yb70bVi2Bgr4akJirnFC1MfLU1lPd36jBR4ZHe7cDqk
         ZArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706188565; x=1706793365;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=500hpU7ciKstMts7ME1z4g/cj3B8hAa7ln6Zs2/XYoA=;
        b=kMaiUXb4/QYy4XAgu5hao5zBrADtwA6GrHcMyhzZfheUzLyaX31UxuZfdu8oF1ebpm
         I+KfyqPAMRySXmNKwEClvi22x1ZJDQatmGHbbHVH9+Ntt1O5ltMcsBtkM4SPW48D6J6z
         TfDI4d9Jr8hUzsLwQ2WR3iCNjxCNK7rSNDTEvO01/BUBGceHoAY8mjAop55v2pPBG9d5
         fBxKuFTVwfUFnoZnu+n9G0QLaIaf00PteOIcg9lnXFF5xF/b7cd6/VOVhVbh6bc6eS4J
         rTatuhi6c+EKFpE588+n5DHHxLaCOwb/ccns4eT7H0NNEnk/3Hc+FUldhpOI2zrwHO3H
         ChtQ==
X-Gm-Message-State: AOJu0YwAPj6IkosJ3hQk4APVGXuQklkb2VN69czxVqdctHjA+tTnvpm9
	cwHurBXg/vx4jdqYymEyooDOOf17yTXDc9MSr83bbvSiYVMO9kfb
X-Google-Smtp-Source: AGHT+IE+sqmTgv2lgX3bs8kvWkbRw3h069uiugTXbICPwZ4qxDO4ck87O0blKxThh2IqNnzbRAWLLQ==
X-Received: by 2002:a7b:c408:0:b0:40e:476d:6832 with SMTP id k8-20020a7bc408000000b0040e476d6832mr531445wmi.159.1706188565066;
        Thu, 25 Jan 2024 05:16:05 -0800 (PST)
Received: from localhost ([45.130.85.2])
        by smtp.gmail.com with ESMTPSA id l1-20020a05600c4f0100b0040e549c77a1sm2621155wmq.32.2024.01.25.05.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 05:16:04 -0800 (PST)
Message-ID: <301afa25-485f-460d-a06c-007f80a060d5@gmail.com>
Date: Thu, 25 Jan 2024 14:15:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [RFC PATCH net-next v1 3/3] net: route: replace route hints with
 input_dst_cache
Content-Language: en-US
From: Leone Fernando <leone4fernando@gmail.com>
To: dennis@kernel.org, tj@kernel.org, cl@linux.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <d951b371-4138-4bda-a1c5-7606a28c81f0@gmail.com>
In-Reply-To: <d951b371-4138-4bda-a1c5-7606a28c81f0@gmail.com>
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


