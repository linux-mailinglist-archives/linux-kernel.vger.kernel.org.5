Return-Path: <linux-kernel+bounces-148623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA9D8A8535
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0A801F2374C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8821411C1;
	Wed, 17 Apr 2024 13:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMfHs23y"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95219140375;
	Wed, 17 Apr 2024 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361714; cv=none; b=dqgKbF/VhM4Sam8vrqKBNswllJHSYCdKJ4OoVumgzN/eRU8kVhtJGIFc5Z2969/I225HGD5QSa2YnLUJTrBbhopWtBjWZiO2QqJhvkFobTYNPY+oc5va18P2lWmbTg1/sqbgenLE5Z13VQBrjxDm1Xv7ShBr3+guJrmtZfx1pi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361714; c=relaxed/simple;
	bh=zmRtQNXFL9uDnRVC+VIF1D3o3b1lvVSYsrxe8HYmCA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Uo63bdlWSitP+4lcKzo78qhjay7yG+ROLGlEiR6/lEOVKvhrMzyevthwWtqmHldYBSrrfx+OTo5YqUff6EwPvx8iTGaNXBs0vj7h8RsiO22vWQ+1AIHly7MHoTGsSLCPqXysXHKiXbsT76IPo9L7XrIh5suD3gZasLYSiCTmIeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMfHs23y; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-343e096965bso3680173f8f.3;
        Wed, 17 Apr 2024 06:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713361711; x=1713966511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sLHTQw9rZarZMkpylRYGQNmUjflIBzSBqZgRPGp43nE=;
        b=XMfHs23y7hagUUYhmDqljnD0xoB+kuybCxl3nNhAQGzemz6xkgWCbRYQ9Mhd6By3NN
         Bgf7r7h9SpeqsBkwSfUssqhWqfTJMiu98MRh9DtD54XT5lKsXeoJDk/GIDB9B7EHMpkX
         0urKeQDKytq1IxaJV5soPlK4+gZa2pzgyQ/paD/ERg+yZkpofEiceUfwt7iJraCnxRgh
         86OAlMsDY7tE3sLce86hxw0ihm17LQBN/gI1LibsaKa1j/ocZos7Su+KKmRG8m6KrZ7Q
         YQOcVR73PTHZhi+C1AUgvI2Q0XuHYGQDkWPnFg9oYV6tLHeNLTlpfvomtHL7SDfD0LY6
         oByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713361711; x=1713966511;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sLHTQw9rZarZMkpylRYGQNmUjflIBzSBqZgRPGp43nE=;
        b=t6DHm7OwcLcbsPPBYYVpvR//KQOlEv6vexcV1j8+kkzlEPMX2quK9CK95uNhNjQN5U
         zOO95dLbV3gmcVfUtfbrm45tFWk63NRTrbXgUbeV/1mIHJNQnH7TWlK3bAWr+96dQbU6
         PAH73fvyfL/SeyxtPRkHKHTdZRtvSm/cIMezoBKECsQVdf4QYeHvOL1VVjH9P1VVe3cX
         Yf2gHxNzSm1CP03mRRs2UZGjgmjzMs9Gpxs82zolWuMfizJ9EPpAmw1igMS4DMWi9YPr
         PLMezIiwKLIdhvROLPVwkE/jqGgjHxeNQnsDcVb0jLnjaeXz5cIZkrCkDpt+uEsHxqEw
         zjWw==
X-Forwarded-Encrypted: i=1; AJvYcCVk3oBvUmpUcE4neJmqWHhI8ei/NcCzHzefblCA+Zk5oWVQJ0n9UU7QgZKdaaJ9lkVnYaULBfPcsTDE1r+xeFoIydRRO/5UZcCqrNgkP+QiBf3qPgz0YNgq5I8jxNEW1K9OZ40y
X-Gm-Message-State: AOJu0YwZVsf69XB0aln5MZEJ0yaA+PCfuXY5EWncr1cD9K4sjYSsWtaR
	9xXPrsq/ZFQ/SAZTiCD7fp3FamhCs/suPqbSC8LTPo2TgAJfjCbc
X-Google-Smtp-Source: AGHT+IEKdwFJthrILEF+SHGiorgcryprbZIGPkr9rK00G0thKZ0IusphEFJVzkuH+Mht4wxkvEbwUg==
X-Received: by 2002:a05:6000:1cb:b0:343:68c5:6ba5 with SMTP id t11-20020a05600001cb00b0034368c56ba5mr13669334wrx.50.1713361710662;
        Wed, 17 Apr 2024 06:48:30 -0700 (PDT)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id gb32-20020a05600045a000b003462b54bc8asm17559646wrb.109.2024.04.17.06.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 06:48:30 -0700 (PDT)
Message-ID: <97a01bf9-99d2-4368-9ebd-1e1194c1d7fd@gmail.com>
Date: Wed, 17 Apr 2024 15:48:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v1 2/2] net: gro: add p_off param in *_gro_complete
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 aleksander.lobakin@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240412152120.115067-1-richardbgobert@gmail.com>
 <20240412152120.115067-3-richardbgobert@gmail.com>
 <661ad2e8a7e95_3be9a7294a5@willemb.c.googlers.com.notmuch>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <661ad2e8a7e95_3be9a7294a5@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Richard Gobert wrote:
>> Commits a602456 ("udp: Add GRO functions to UDP socket") and 57c67ff ("udp:
>> additional GRO support") introduce incorrect usage of {ip,ipv6}_hdr in the
>> complete phase of gro. The functions always return skb->network_header,
>> which in the case of encapsulated packets at the gro complete phase, is
>> always set to the innermost L3 of the packet. That means that calling
>> {ip,ipv6}_hdr for skbs which completed the GRO receive phase (both in
>> gro_list and *_gro_complete) when parsing an encapsulated packet's _outer_
>> L3/L4 may return an unexpected value.
>>
>> This incorrect usage leads to a bug in GRO's UDP socket lookup.
>> udp{4,6}_lib_lookup_skb functions use ip_hdr/ipv6_hdr respectively. These
>> *_hdr functions return network_header which will point to the innermost L3,
>> resulting in the wrong offset being used in __udp{4,6}_lib_lookup with
>> encapsulated packets.
>>
>> To fix this issue p_off param is used in *_gro_complete to pass off the
>> offset of the previous layer.
>>
>> Reproduction example:
>>
>> Endpoint configuration example (fou + local address bind)
>>
>>     # ip fou add port 6666 ipproto 4
>>     # ip link add name tun1 type ipip remote 2.2.2.1 local 2.2.2.2 encap fou encap-dport 5555 encap-sport 6666 mode ipip
>>     # ip link set tun1 up
>>     # ip a add 1.1.1.2/24 dev tun1
>>
>> Netperf TCP_STREAM result on net-next before patch is applied:
>>
>> net-next main, GRO enabled:
>>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
>>     Recv   Send    Send
>>     Socket Socket  Message  Elapsed
>>     Size   Size    Size     Time     Throughput
>>     bytes  bytes   bytes    secs.    10^6bits/sec
>>
>>     131072  16384  16384    5.28        2.37
>>
>> net-next main, GRO disabled:
>>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
>>     Recv   Send    Send
>>     Socket Socket  Message  Elapsed
>>     Size   Size    Size     Time     Throughput
>>     bytes  bytes   bytes    secs.    10^6bits/sec
>>
>>     131072  16384  16384    5.01     2745.06
>>
>> patch applied, GRO enabled:
>>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
>>     Recv   Send    Send
>>     Socket Socket  Message  Elapsed
>>     Size   Size    Size     Time     Throughput
>>     bytes  bytes   bytes    secs.    10^6bits/sec
>>
>>     131072  16384  16384    5.01     2877.38
>>
>> Fixes: 57c67ff4bd92 ("udp: additional GRO support")
>> Suggested-by: Eric Dumazet <edumazet@google.com>
>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> 
>> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
>> index 163f94a5a58f..9c18a39b0d0c 100644
>> --- a/drivers/net/geneve.c
>> +++ b/drivers/net/geneve.c
>> @@ -555,7 +555,7 @@ static struct sk_buff *geneve_gro_receive(struct sock *sk,
>>  }
>>  
>>  static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
>> -			       int nhoff)
>> +			       int p_off, int nhoff)
>>  {
>>  	struct genevehdr *gh;
>>  	struct packet_offload *ptype;
>> @@ -569,11 +569,12 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
>>  
>>  	/* since skb->encapsulation is set, eth_gro_complete() sets the inner mac header */
>>  	if (likely(type == htons(ETH_P_TEB)))
>> -		return eth_gro_complete(skb, nhoff + gh_len);
>> +		return eth_gro_complete(skb, p_off, nhoff + gh_len);
> 
> Since the new field to the callback is only used between IP and
> transport layer callback implementations, I think the others should
> just return zero, to make it clear that the value is unused.
> 

Got it. I'll push it in v2.

> I still think that if the only issue is with udp, we can just special
> case those and pass the nhoff instead of thoff in the existing one
> available offset field, and compute the transport offset in the udp
> function. For much less code churn. But unless anyone else agrees you
> can ignore that suggestion.
> 
>> -int inet_gro_complete(struct sk_buff *skb, int nhoff)
>> +int inet_gro_complete(struct sk_buff *skb, int prior_off, int nhoff)
>>  {
>>  	struct iphdr *iph = (struct iphdr *)(skb->data + nhoff);
>>  	const struct net_offload *ops;
>> @@ -1667,17 +1667,17 @@ int inet_gro_complete(struct sk_buff *skb, int nhoff)
>>  	 */
>>  	err = INDIRECT_CALL_2(ops->callbacks.gro_complete,
>>  			      tcp4_gro_complete, udp4_gro_complete,
>> -			      skb, nhoff + sizeof(*iph));
>> +				  skb, nhoff, nhoff + sizeof(*iph));
> 
> Identation change
> 

Will fix in v2 as well, thanks!

>>  struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
>> +				 int nhoff,
>>  				 __be16 sport, __be16 dport)
>>  {
>> -	const struct iphdr *iph = ip_hdr(skb);
>> +	const struct iphdr *iph = (const struct iphdr *)(skb->data + nhoff);
> 
> How about instead just pass the saddr and daddr and leave the iph
> pointer to the caller (which also computes the udph pointer).

Here's a snippet I wrote - could you make sure this is what you mean?

BTW I couldn't find a union type which contains both in_addr and in6_addr
and is generic enough (I wrote udp_offload_addr which is similar to
tcp_ao_addr, is there a more generic one? Should it be created?)
 
diff --git a/include/net/gro.h b/include/net/gro.h
index ebead1d642b4..56e5e21feb00 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -405,7 +405,8 @@ INDIRECT_CALLABLE_DECLARE(int udp6_gro_complete(struct sk_buff *, int, int));
 
 struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 				struct udphdr *uh, struct sock *sk);
-int udp_gro_complete(struct sk_buff *skb, int nhoff, int thoff,
+int udp_gro_complete(struct sk_buff *skb, const union udp_offload_addr *saddr,
+		     const union udp_offload_addr *daddr, int thoff,
 		     udp_lookup_t lookup);
 
 static inline struct udphdr *udp_gro_udphdr(struct sk_buff *skb)
diff --git a/include/net/udp.h b/include/net/udp.h
index 601d1c3b677a..5f7224e6eb1e 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -62,6 +62,11 @@ struct udp_hslot {
 	spinlock_t		lock;
 } __attribute__((aligned(2 * sizeof(long))));
 
+union udp_offload_addr {
+	__be32 ipaddr;
+	struct in6_addr ip6addr;
+};
+
 /**
  *	struct udp_table - UDP table
  *
@@ -166,7 +171,9 @@ static inline void udp_csum_pull_header(struct sk_buff *skb)
 	UDP_SKB_CB(skb)->cscov -= sizeof(struct udphdr);
 }
 
-typedef struct sock *(*udp_lookup_t)(const struct sk_buff *skb, int nhoff,
+typedef struct sock *(*udp_lookup_t)(const struct sk_buff *skb,
+				     const union udp_offload_addr *saddr,
+				     const union udp_offload_addr *daddr,
 				     __be16 sport, __be16 dport);
 
 void udp_v6_early_demux(struct sk_buff *skb);
@@ -301,7 +308,9 @@ struct sock *udp4_lib_lookup(struct net *net, __be32 saddr, __be16 sport,
 struct sock *__udp4_lib_lookup(struct net *net, __be32 saddr, __be16 sport,
 			       __be32 daddr, __be16 dport, int dif, int sdif,
 			       struct udp_table *tbl, struct sk_buff *skb);
-struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb, int nhoff,
+struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
+				 const union udp_offload_addr *saddr,
+				 const union udp_offload_addr *daddr,
 				 __be16 sport, __be16 dport);
 struct sock *udp6_lib_lookup(struct net *net,
 			     const struct in6_addr *saddr, __be16 sport,
@@ -312,7 +321,9 @@ struct sock *__udp6_lib_lookup(struct net *net,
 			       const struct in6_addr *daddr, __be16 dport,
 			       int dif, int sdif, struct udp_table *tbl,
 			       struct sk_buff *skb);
-struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb, int nhoff,
+struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
+				 const union udp_offload_addr *saddr,
+				 const union udp_offload_addr *daddr,
 				 __be16 sport, __be16 dport);
 int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
 
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 306d2a78fefa..151c3adecc21 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -529,17 +529,18 @@ static inline struct sock *__udp4_lib_lookup_skb(struct sk_buff *skb,
 				 inet_sdif(skb), udptable, skb);
 }
 
-struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb, int nhoff,
+struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
+				 const union udp_offload_addr *saddr,
+				 const union udp_offload_addr *daddr,
 				 __be16 sport, __be16 dport)
 {
-	const struct iphdr *iph = (const struct iphdr *)(skb->data + nhoff);
 	struct net *net = dev_net(skb->dev);
 	int iif, sdif;
 
 	inet_get_iif_sdif(skb, &iif, &sdif);
 
-	return __udp4_lib_lookup(net, iph->saddr, sport,
-				 iph->daddr, dport, iif,
+	return __udp4_lib_lookup(net, saddr->ipaddr, sport,
+				 daddr->ipaddr, dport, iif,
 				 sdif, net->ipv4.udp_table, NULL);
 }
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index dcf8124b1a6a..0f05c7ed05d3 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -689,7 +689,8 @@ static int udp_gro_complete_segment(struct sk_buff *skb)
 	return 0;
 }
 
-int udp_gro_complete(struct sk_buff *skb, int nhoff, int thoff,
+int udp_gro_complete(struct sk_buff *skb, const union udp_offload_addr *saddr,
+		     const union udp_offload_addr *daddr, int thoff,
 		     udp_lookup_t lookup)
 {
 	struct udphdr *uh = (struct udphdr *)(skb->data + thoff);
@@ -700,8 +701,8 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff, int thoff,
 	uh->len = newlen;
 
 	sk = INDIRECT_CALL_INET(lookup, udp6_lib_lookup_skb,
-				udp4_lib_lookup_skb, skb, nhoff, uh->source,
-				uh->dest);
+				udp4_lib_lookup_skb, skb, saddr, daddr,
+				uh->source, uh->dest);
 	if (sk && udp_sk(sk)->gro_complete) {
 		skb_shinfo(skb)->gso_type = uh->check ? SKB_GSO_UDP_TUNNEL_CSUM
 					: SKB_GSO_UDP_TUNNEL;
@@ -733,6 +734,8 @@ INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff,
 {
 	const struct iphdr *iph = (const struct iphdr *)(skb->data + nhoff);
 	struct udphdr *uh = (struct udphdr *)(skb->data + thoff);
+	const union udp_offload_addr *saddr = (union udp_offload_addr *)&iph->saddr;
+	const union udp_offload_addr *daddr = (union udp_offload_addr *)&iph->daddr;
 
 	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
 	if (NAPI_GRO_CB(skb)->is_flist && !NAPI_GRO_CB(skb)->encap_mark) {
@@ -750,7 +753,7 @@ INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff,
 		uh->check = ~udp_v4_check(skb->len - thoff, iph->saddr,
 					  iph->daddr, 0);
 
-	return udp_gro_complete(skb, nhoff, thoff, udp4_lib_lookup_skb);
+	return udp_gro_complete(skb, saddr, daddr, thoff, udp4_lib_lookup_skb);
 }
 
 int __init udpv4_offload_init(void)
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 74d4a0e4d754..124beb4f4ea5 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -270,17 +270,18 @@ static struct sock *__udp6_lib_lookup_skb(struct sk_buff *skb,
 				 inet6_sdif(skb), udptable, skb);
 }
 
-struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb, int nhoff,
+struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
+				 const union udp_offload_addr *saddr,
+				 const union udp_offload_addr *daddr,
 				 __be16 sport, __be16 dport)
 {
-	const struct ipv6hdr *iph = (const struct ipv6hdr *)(skb->data + nhoff);
 	struct net *net = dev_net(skb->dev);
 	int iif, sdif;
 
 	inet6_get_iif_sdif(skb, &iif, &sdif);
 
-	return __udp6_lib_lookup(net, &iph->saddr, sport,
-				 &iph->daddr, dport, iif,
+	return __udp6_lib_lookup(net, &saddr->ip6addr, sport,
+				 &daddr->ip6addr, dport, iif,
 				 sdif, net->ipv4.udp_table, NULL);
 }
 
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index 078055665397..651ec7ade1af 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -167,6 +167,8 @@ INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int nhoff,
 {
 	const struct ipv6hdr *ipv6h = (const struct ipv6hdr *)(skb->data + nhoff);
 	struct udphdr *uh = (struct udphdr *)(skb->data + thoff);
+	const union udp_offload_addr *saddr = (union udp_offload_addr *)&ipv6h->saddr;
+	const union udp_offload_addr *daddr = (union udp_offload_addr *)&ipv6h->daddr;
 
 	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
 	if (NAPI_GRO_CB(skb)->is_flist && !NAPI_GRO_CB(skb)->encap_mark) {
@@ -181,10 +183,10 @@ INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int nhoff,
 	}
 
 	if (uh->check)
-		uh->check = ~udp_v6_check(skb->len - thoff, &ipv6h->saddr,
-					  &ipv6h->daddr, 0);
+		uh->check = ~udp_v6_check(skb->len - thoff, &saddr->ip6addr,
+					  &daddr->ip6addr, 0);
 
-	return udp_gro_complete(skb, nhoff, thoff, udp6_lib_lookup_skb);
+	return udp_gro_complete(skb, saddr, daddr, thoff, udp6_lib_lookup_skb);
 }
 
 int __init udpv6_offload_init(void)

