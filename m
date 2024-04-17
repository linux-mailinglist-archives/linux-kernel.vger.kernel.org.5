Return-Path: <linux-kernel+bounces-149129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD318A8C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73771C21A13
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D3E2EAF5;
	Wed, 17 Apr 2024 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcwfIlGy"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F133D2D03D;
	Wed, 17 Apr 2024 19:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713382788; cv=none; b=LffB6dOlgj9KqJmOkXp6eeOmY9ZKkfbZ8nyTI80drpRYX9PDtF//DFJkRIeEOLv37jCkxOKgZ+WUNCVisCfIJ/aNzWYhscSN8rsVTvGucq41SyfEP56WXAAiACOVEPnuV60G99ZUBWr+Q5TxyO1A0AQtlz+HW5S7tWQYldtGUpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713382788; c=relaxed/simple;
	bh=zxO5FTHZBJatbovSI1Bv8y3XpQsEQLyFo6WZvP6NdD4=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XaYbpVfMgL24L1zrb3psaMmkUtkXXtJzpY4bL3N7jVtslHSVzSBCmzDV74h5NUMsFTDALeUbngr5fKIU3ctLOT5cC6Mylem5n6Pe4INb5HbHQOpO7WChHWlLUvva634f46LFSVdvC6gNC3MgMDMvlo+plDVHGw2rA1oxX4/cGCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcwfIlGy; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so100978b6e.2;
        Wed, 17 Apr 2024 12:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713382786; x=1713987586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dayZus1mGCRrZdIvYDkToR0L5oG5CYWlQiBkii6pQtM=;
        b=IcwfIlGyAhYkwwsU3pXSReSdYMV+6lIKHbXRlRXZgglzKra/ac7UFIU9+Srb0UixHw
         HjSaPKT5hYcUm/Naocb5lVdmPc179orj17uvHUnEK3Wz0ioT6pYwxi5Lqj+WqjIT6mDS
         i0/0JlFOV/l1hCgbPtE9jhbNrvTYvJFATR3Sa5NO79wAs46dSbIAUb/sDz6ktsb+oe6X
         u7/o53ILmfIiUM/g5PfId08iswUjc37h05L324wDqNbfUx6ZJorpu1N7u3PPf3+6GR1G
         UWB8+X3d+BovZIdTpSYZcxWwOfabWEn/2QrNPSsdIGIDLpFdsXAWwZG9UVC5Fxe1OBec
         dsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713382786; x=1713987586;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dayZus1mGCRrZdIvYDkToR0L5oG5CYWlQiBkii6pQtM=;
        b=G4mP+hCTtiAJtBpP7nLdIfzxCmzOZu7SyXwz8oNUNkAt4RpHZ2uQMHzeNnGJUGpsJx
         1yfDvWXoiIHsHq390NZo6U1AA+bMB6FsiCoZueHjpoB02r1Ht6txkDOgAMjz2KfnuSVj
         BMNeX8fSqNFmxHHgwoGFLie+TZiii/whK//BMjsEDT3zt6+K1ssCExz9+trbkZkES/oY
         mqGxCYH7H83V782oRIA948pRESrMdGfa4djKsZytX9wKcD5HA4cvG/9nQnaKcxDiN4LL
         A5mfj4HmDkWyffXy6trzxKOehFS4xDXPQWhic5TcWyM4eT4KQLRAnKrYd59+3sgcT4fu
         eklQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs+RWBjqy7/QKgxiZmcmUMicYzWDu7aNoYF8sa6VK1MbMh1Ulswz/7B8RUsgtKfNmp7OnVncfboR2QzhGMiH/hc6joChOK0PdAqQtxvFyn5ndf41V5gMcNkNvhV7Cha1h2B01G
X-Gm-Message-State: AOJu0Ywog3yuAWZBuDCP1WbzIX6JzaL5B/q2SGAizMDB4r8EHys1I6/X
	k4TWZ0JUm5DVe/kw3WUa7XBf3Hnvgy7MaymjsG8DI8kFcIY328Mh
X-Google-Smtp-Source: AGHT+IHDk9UbacaOz4BVEILDw3rLBAEPXBv5z8odX48avi2verV9OcJKCLigNNBeKKfhKacNxHTODg==
X-Received: by 2002:aca:1106:0:b0:3c6:f34b:e90b with SMTP id 6-20020aca1106000000b003c6f34be90bmr624442oir.1.1713382785927;
        Wed, 17 Apr 2024 12:39:45 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id t24-20020ac865d8000000b00437392f1c20sm868744qto.76.2024.04.17.12.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 12:39:45 -0700 (PDT)
Date: Wed, 17 Apr 2024 15:39:45 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 aleksander.lobakin@intel.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <662025813539e_c86472944@willemb.c.googlers.com.notmuch>
In-Reply-To: <97a01bf9-99d2-4368-9ebd-1e1194c1d7fd@gmail.com>
References: <20240412152120.115067-1-richardbgobert@gmail.com>
 <20240412152120.115067-3-richardbgobert@gmail.com>
 <661ad2e8a7e95_3be9a7294a5@willemb.c.googlers.com.notmuch>
 <97a01bf9-99d2-4368-9ebd-1e1194c1d7fd@gmail.com>
Subject: Re: [PATCH net v1 2/2] net: gro: add p_off param in *_gro_complete
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Willem de Bruijn wrote:
> > Richard Gobert wrote:
> >> Commits a602456 ("udp: Add GRO functions to UDP socket") and 57c67ff ("udp:
> >> additional GRO support") introduce incorrect usage of {ip,ipv6}_hdr in the
> >> complete phase of gro. The functions always return skb->network_header,
> >> which in the case of encapsulated packets at the gro complete phase, is
> >> always set to the innermost L3 of the packet. That means that calling
> >> {ip,ipv6}_hdr for skbs which completed the GRO receive phase (both in
> >> gro_list and *_gro_complete) when parsing an encapsulated packet's _outer_
> >> L3/L4 may return an unexpected value.
> >>
> >> This incorrect usage leads to a bug in GRO's UDP socket lookup.
> >> udp{4,6}_lib_lookup_skb functions use ip_hdr/ipv6_hdr respectively. These
> >> *_hdr functions return network_header which will point to the innermost L3,
> >> resulting in the wrong offset being used in __udp{4,6}_lib_lookup with
> >> encapsulated packets.
> >>
> >> To fix this issue p_off param is used in *_gro_complete to pass off the
> >> offset of the previous layer.
> >>
> >> Reproduction example:
> >>
> >> Endpoint configuration example (fou + local address bind)
> >>
> >>     # ip fou add port 6666 ipproto 4
> >>     # ip link add name tun1 type ipip remote 2.2.2.1 local 2.2.2.2 encap fou encap-dport 5555 encap-sport 6666 mode ipip
> >>     # ip link set tun1 up
> >>     # ip a add 1.1.1.2/24 dev tun1
> >>
> >> Netperf TCP_STREAM result on net-next before patch is applied:
> >>
> >> net-next main, GRO enabled:
> >>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
> >>     Recv   Send    Send
> >>     Socket Socket  Message  Elapsed
> >>     Size   Size    Size     Time     Throughput
> >>     bytes  bytes   bytes    secs.    10^6bits/sec
> >>
> >>     131072  16384  16384    5.28        2.37
> >>
> >> net-next main, GRO disabled:
> >>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
> >>     Recv   Send    Send
> >>     Socket Socket  Message  Elapsed
> >>     Size   Size    Size     Time     Throughput
> >>     bytes  bytes   bytes    secs.    10^6bits/sec
> >>
> >>     131072  16384  16384    5.01     2745.06
> >>
> >> patch applied, GRO enabled:
> >>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
> >>     Recv   Send    Send
> >>     Socket Socket  Message  Elapsed
> >>     Size   Size    Size     Time     Throughput
> >>     bytes  bytes   bytes    secs.    10^6bits/sec
> >>
> >>     131072  16384  16384    5.01     2877.38
> >>
> >> Fixes: 57c67ff4bd92 ("udp: additional GRO support")
> >> Suggested-by: Eric Dumazet <edumazet@google.com>
> >> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> > 
> >> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> >> index 163f94a5a58f..9c18a39b0d0c 100644
> >> --- a/drivers/net/geneve.c
> >> +++ b/drivers/net/geneve.c
> >> @@ -555,7 +555,7 @@ static struct sk_buff *geneve_gro_receive(struct sock *sk,
> >>  }
> >>  
> >>  static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
> >> -			       int nhoff)
> >> +			       int p_off, int nhoff)
> >>  {
> >>  	struct genevehdr *gh;
> >>  	struct packet_offload *ptype;
> >> @@ -569,11 +569,12 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
> >>  
> >>  	/* since skb->encapsulation is set, eth_gro_complete() sets the inner mac header */
> >>  	if (likely(type == htons(ETH_P_TEB)))
> >> -		return eth_gro_complete(skb, nhoff + gh_len);
> >> +		return eth_gro_complete(skb, p_off, nhoff + gh_len);
> > 
> > Since the new field to the callback is only used between IP and
> > transport layer callback implementations, I think the others should
> > just return zero, to make it clear that the value is unused.
> > 
> 
> Got it. I'll push it in v2.
> 
> > I still think that if the only issue is with udp, we can just special
> > case those and pass the nhoff instead of thoff in the existing one
> > available offset field, and compute the transport offset in the udp
> > function. For much less code churn. But unless anyone else agrees you
> > can ignore that suggestion.
> > 
> >> -int inet_gro_complete(struct sk_buff *skb, int nhoff)
> >> +int inet_gro_complete(struct sk_buff *skb, int prior_off, int nhoff)
> >>  {
> >>  	struct iphdr *iph = (struct iphdr *)(skb->data + nhoff);
> >>  	const struct net_offload *ops;
> >> @@ -1667,17 +1667,17 @@ int inet_gro_complete(struct sk_buff *skb, int nhoff)
> >>  	 */
> >>  	err = INDIRECT_CALL_2(ops->callbacks.gro_complete,
> >>  			      tcp4_gro_complete, udp4_gro_complete,
> >> -			      skb, nhoff + sizeof(*iph));
> >> +				  skb, nhoff, nhoff + sizeof(*iph));
> > 
> > Identation change
> > 
> 
> Will fix in v2 as well, thanks!
> 
> >>  struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
> >> +				 int nhoff,
> >>  				 __be16 sport, __be16 dport)
> >>  {
> >> -	const struct iphdr *iph = ip_hdr(skb);
> >> +	const struct iphdr *iph = (const struct iphdr *)(skb->data + nhoff);
> > 
> > How about instead just pass the saddr and daddr and leave the iph
> > pointer to the caller (which also computes the udph pointer).
> 
> Here's a snippet I wrote - could you make sure this is what you mean?
> 
> BTW I couldn't find a union type which contains both in_addr and in6_addr
> and is generic enough (I wrote udp_offload_addr which is similar to
> tcp_ao_addr, is there a more generic one? Should it be created?)

Thanks for the sketch. That is a bit more complex than I had in mind.

>  
> diff --git a/include/net/gro.h b/include/net/gro.h
> index ebead1d642b4..56e5e21feb00 100644
> --- a/include/net/gro.h
> +++ b/include/net/gro.h
> @@ -405,7 +405,8 @@ INDIRECT_CALLABLE_DECLARE(int udp6_gro_complete(struct sk_buff *, int, int));
>  
>  struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
>  				struct udphdr *uh, struct sock *sk);
> -int udp_gro_complete(struct sk_buff *skb, int nhoff, int thoff,
> +int udp_gro_complete(struct sk_buff *skb, const union udp_offload_addr *saddr,
> +		     const union udp_offload_addr *daddr, int thoff,
>  		     udp_lookup_t lookup);
>  
>  static inline struct udphdr *udp_gro_udphdr(struct sk_buff *skb)
> diff --git a/include/net/udp.h b/include/net/udp.h
> index 601d1c3b677a..5f7224e6eb1e 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -62,6 +62,11 @@ struct udp_hslot {
>  	spinlock_t		lock;
>  } __attribute__((aligned(2 * sizeof(long))));
>  
> +union udp_offload_addr {
> +	__be32 ipaddr;
> +	struct in6_addr ip6addr;
> +};
> +

No need for such a union if the code just either calls
udp4_lib_lookup_skb or udp6_lib_lookup_skb
>  /**
>   *	struct udp_table - UDP table
>   *
> @@ -166,7 +171,9 @@ static inline void udp_csum_pull_header(struct sk_buff *skb)
>  	UDP_SKB_CB(skb)->cscov -= sizeof(struct udphdr);
>  }
>  
> -typedef struct sock *(*udp_lookup_t)(const struct sk_buff *skb, int nhoff,
> +typedef struct sock *(*udp_lookup_t)(const struct sk_buff *skb,
> +				     const union udp_offload_addr *saddr,
> +				     const union udp_offload_addr *daddr,
>  				     __be16 sport, __be16 dport);
>  
>  void udp_v6_early_demux(struct sk_buff *skb);
> @@ -301,7 +308,9 @@ struct sock *udp4_lib_lookup(struct net *net, __be32 saddr, __be16 sport,
>  struct sock *__udp4_lib_lookup(struct net *net, __be32 saddr, __be16 sport,
>  			       __be32 daddr, __be16 dport, int dif, int sdif,
>  			       struct udp_table *tbl, struct sk_buff *skb);
> -struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb, int nhoff,
> +struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
> +				 const union udp_offload_addr *saddr,
> +				 const union udp_offload_addr *daddr,
>  				 __be16 sport, __be16 dport);
>  struct sock *udp6_lib_lookup(struct net *net,
>  			     const struct in6_addr *saddr, __be16 sport,
> @@ -312,7 +321,9 @@ struct sock *__udp6_lib_lookup(struct net *net,
>  			       const struct in6_addr *daddr, __be16 dport,
>  			       int dif, int sdif, struct udp_table *tbl,
>  			       struct sk_buff *skb);
> -struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb, int nhoff,
> +struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
> +				 const union udp_offload_addr *saddr,
> +				 const union udp_offload_addr *daddr,
>  				 __be16 sport, __be16 dport);
>  int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor);
>  
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 306d2a78fefa..151c3adecc21 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -529,17 +529,18 @@ static inline struct sock *__udp4_lib_lookup_skb(struct sk_buff *skb,
>  				 inet_sdif(skb), udptable, skb);
>  }
>  
> -struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb, int nhoff,
> +struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
> +				 const union udp_offload_addr *saddr,
> +				 const union udp_offload_addr *daddr,
>  				 __be16 sport, __be16 dport)
>  {
> -	const struct iphdr *iph = (const struct iphdr *)(skb->data + nhoff);
>  	struct net *net = dev_net(skb->dev);
>  	int iif, sdif;
>  
>  	inet_get_iif_sdif(skb, &iif, &sdif);
>  
> -	return __udp4_lib_lookup(net, iph->saddr, sport,
> -				 iph->daddr, dport, iif,
> +	return __udp4_lib_lookup(net, saddr->ipaddr, sport,
> +				 daddr->ipaddr, dport, iif,
>  				 sdif, net->ipv4.udp_table, NULL);
>  }
>  
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index dcf8124b1a6a..0f05c7ed05d3 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -689,7 +689,8 @@ static int udp_gro_complete_segment(struct sk_buff *skb)
>  	return 0;
>  }
>  
> -int udp_gro_complete(struct sk_buff *skb, int nhoff, int thoff,
> +int udp_gro_complete(struct sk_buff *skb, const union udp_offload_addr *saddr,
> +		     const union udp_offload_addr *daddr, int thoff,
>  		     udp_lookup_t lookup)
>  {
>  	struct udphdr *uh = (struct udphdr *)(skb->data + thoff);
> @@ -700,8 +701,8 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff, int thoff,
>  	uh->len = newlen;
>  
>  	sk = INDIRECT_CALL_INET(lookup, udp6_lib_lookup_skb,
> -				udp4_lib_lookup_skb, skb, nhoff, uh->source,
> -				uh->dest);
> +				udp4_lib_lookup_skb, skb, saddr, daddr,
> +				uh->source, uh->dest);

Since this INDIRECT_CALL_INET needs to know about the definitions of
udp4_lib_lookup_skb and udp6_lib_lookup_skb anyway, we can just get
rid of the whole udp_lookup_t type and function pointer passing?

Or move the entire lookup to udp4_gro_complete/udp6_gro_complete and
pass the sk to udp_gro_complete.

