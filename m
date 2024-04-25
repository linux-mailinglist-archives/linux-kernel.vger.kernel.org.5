Return-Path: <linux-kernel+bounces-157932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FA68B18CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91B27282655
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B48A179B7;
	Thu, 25 Apr 2024 02:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyePFAKK"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB9114A82;
	Thu, 25 Apr 2024 02:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714011341; cv=none; b=U689YYNUA3o7Vafj9sjkFXJIZoX59GgtgAtPUo+iERwOOee8rFxhzL3vnYTDZI3RbIVM3C2OF74vsX7RImckOqvG/bnpcmYj/cVMY99d21toxLb5DHuP6l3WBHoRusdySn6ck6NA/WEJndXBjKI2XVDZ5k1dmA4DNQlfq43JORE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714011341; c=relaxed/simple;
	bh=GyxDwYnJ39ZrgJ3JVz45q3qX7sw3KLeM8AYFSAslXqw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=VjKTdITE+cUZ4cn/ItEWuzJAeB1fGTX1ksG1ZDLXQhf3W4953b/jbrIU/mr0SUxgVbX2GDx2Pe02VTBvYvw0r6aIpb9Cyf+3XTQO1neR0rLTPBhZQ2fzOAu4XuwZdLlwj8P5gu8IsgHhSa7MJFW7Kl89a4buCTeY3HU8MFAWkfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyePFAKK; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78efd533a00so30184085a.0;
        Wed, 24 Apr 2024 19:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714011338; x=1714616138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FETZyzzgOy3/OO9AKO4Kyi7R436DW3eCT8ogFkKrJyU=;
        b=hyePFAKKxkEIbGQpTgMfxN1ndD2U/31KP+1iQyw49QxdzranE9Ug/AfsOcUpfGUitW
         fvYGqSIvPMisti5QP6D1TrJQetF1nw7Z2mdWFR5ECpoVtuH5IYEbcVskMyA4EITKN5gC
         sFwLOsPxbvPm4sANAPSBc9okQtlANEuQnuWeCk/eM2bbsqD860LzBJsFCimgpGrn+0px
         4SvsGUt9KDV2cAdvAnMPiIyewRFu3ZLWX2MwG/hhNQz+AChDPekDOYr47X9186PgtbtT
         kTn6YLsmlEs73qZhSi+Xc8zAOFaQfllEc4rQVmdDTF732YPEWm9grzKwR4mxy5HPqtK6
         O2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714011338; x=1714616138;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FETZyzzgOy3/OO9AKO4Kyi7R436DW3eCT8ogFkKrJyU=;
        b=cKEDH/GN1+nbyLaCNCPXIXBy0ZzAR2l/4KX9uxjKhcXx7yB9ZFplIGGvlOEwFcrWgs
         1NjfQZdl/cJ4biH0M33AZ/1ML+yM9adowQtCOmxeYoMTHBIlhpAGjWTFmor8p382w3/c
         2SDw13btZaqMiX0y9xxiYjn2be14bSREKmI6RYiCQ0qbQWNzrjBRPs1SMOsEJ8zhzC1a
         oV3ec228HNXwptDNKI0Ci4FDz/AuCMPt4HvYHpW/fx+Fsm2HJzFv+JJkzMQ/zCj9X76r
         OpGz3ZuspjPZqFdx/qulmhxVH3nbDepBafzY2eOQ1uus06aH2N5iSPsuzYZTpKs0tQIr
         5AaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo+wQdzRHDzdaiaCicHpTD91bxgHSHQMA4GZvcAu+Up0d/qyKk/5TvkkZxUXHWakpQZ78LIxDz3JGmsXvOpuoTFPLLFg7mibtuYxoiKO9rTAR+rlWMViFfh/lrQ6SKxrcD7JnZ
X-Gm-Message-State: AOJu0YxajYJouDy4SOYBzfjHNLCsiYvbHnQ/1Q/L2INwx7VC0W979aA+
	XEr4rYLThhBeh4VM1nzJfLUOHLD7I/eIw8oQD+zg1Fxw/DDk/6bs
X-Google-Smtp-Source: AGHT+IEGWdt21e1zxCIWhfvvBaMuUj0DYbnQ8aX5i0JkdmpZjttrd/ymQ8geKgNdyyWM0S/aDlP6bQ==
X-Received: by 2002:a05:620a:5811:b0:78d:73db:27a2 with SMTP id wm17-20020a05620a581100b0078d73db27a2mr4447296qkn.76.1714011338028;
        Wed, 24 Apr 2024 19:15:38 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id h14-20020a05620a10ae00b0078d6303c099sm6620443qkk.112.2024.04.24.19.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 19:15:37 -0700 (PDT)
Date: Wed, 24 Apr 2024 22:15:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 alobakin@pm.me, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Message-ID: <6629bcc9486a3_1bd6b02949c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240424163045.123528-2-richardbgobert@gmail.com>
References: <20240424163045.123528-1-richardbgobert@gmail.com>
 <20240424163045.123528-2-richardbgobert@gmail.com>
Subject: Re: [PATCH net v3 1/2] net: gro: fix udp bad offset in socket lookup
 by adding {inner_}network_offset to napi_gro_cb
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
> Commits a602456 ("udp: Add GRO functions to UDP socket") and 57c67ff ("udp:
> additional GRO support") introduce incorrect usage of {ip,ipv6}_hdr in the
> complete phase of gro. The functions always return skb->network_header,
> which in the case of encapsulated packets at the gro complete phase, is
> always set to the innermost L3 of the packet. That means that calling
> {ip,ipv6}_hdr for skbs which completed the GRO receive phase (both in
> gro_list and *_gro_complete) when parsing an encapsulated packet's _outer_
> L3/L4 may return an unexpected value.
> 
> This incorrect usage leads to a bug in GRO's UDP socket lookup.
> udp{4,6}_lib_lookup_skb functions use ip_hdr/ipv6_hdr respectively. These
> *_hdr functions return network_header which will point to the innermost L3,
> resulting in the wrong offset being used in __udp{4,6}_lib_lookup with
> encapsulated packets.
> 
> This patch adds network_offset and inner_network_offset to napi_gro_cb, and
> makes sure both are set correctly.
> 
> To fix the issue, network_offsets union is used inside napi_gro_cb, in
> which both the outer and the inner network offsets are saved.
> 
> Reproduction example:
> 
> Endpoint configuration example (fou + local address bind)
> 
>     # ip fou add port 6666 ipproto 4
>     # ip link add name tun1 type ipip remote 2.2.2.1 local 2.2.2.2 encap fou encap-dport 5555 encap-sport 6666 mode ipip
>     # ip link set tun1 up
>     # ip a add 1.1.1.2/24 dev tun1
> 
> Netperf TCP_STREAM result on net-next before patch is applied:
> 
> net-next main, GRO enabled:
>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
>     Recv   Send    Send
>     Socket Socket  Message  Elapsed
>     Size   Size    Size     Time     Throughput
>     bytes  bytes   bytes    secs.    10^6bits/sec
> 
>     131072  16384  16384    5.28        2.37
> 
> net-next main, GRO disabled:
>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
>     Recv   Send    Send
>     Socket Socket  Message  Elapsed
>     Size   Size    Size     Time     Throughput
>     bytes  bytes   bytes    secs.    10^6bits/sec
> 
>     131072  16384  16384    5.01     2745.06
> 
> patch applied, GRO enabled:
>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
>     Recv   Send    Send
>     Socket Socket  Message  Elapsed
>     Size   Size    Size     Time     Throughput
>     bytes  bytes   bytes    secs.    10^6bits/sec
> 
>     131072  16384  16384    5.01     2877.38
> 
> Fixes: 57c67ff4bd92 ("udp: additional GRO support")
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  include/net/gro.h        | 18 ++++++++++++++++--
>  net/8021q/vlan_core.c    |  2 ++
>  net/core/gro.c           |  1 +
>  net/ipv4/af_inet.c       |  5 +----
>  net/ipv4/tcp_offload.c   |  3 ++-
>  net/ipv4/udp.c           |  3 ++-
>  net/ipv4/udp_offload.c   |  3 ++-
>  net/ipv6/ip6_offload.c   |  6 +++---
>  net/ipv6/tcpv6_offload.c |  3 ++-
>  net/ipv6/udp.c           |  3 ++-
>  net/ipv6/udp_offload.c   |  3 ++-
>  11 files changed, 35 insertions(+), 15 deletions(-)
> 
> diff --git a/include/net/gro.h b/include/net/gro.h
> index 50f1e403dbbb..1faff23b66e8 100644
> --- a/include/net/gro.h
> +++ b/include/net/gro.h
> @@ -87,6 +87,15 @@ struct napi_gro_cb {
>  
>  	/* used to support CHECKSUM_COMPLETE for tunneling protocols */
>  	__wsum	csum;
> +
> +	/* L3 offsets */
> +	union {
> +		struct {
> +			u16 network_offset;
> +			u16 inner_network_offset;
> +		};
> +		u16 network_offsets[2];
> +	};
>  };
>  
>  #define NAPI_GRO_CB(skb) ((struct napi_gro_cb *)(skb)->cb)
> @@ -172,12 +181,17 @@ static inline void *skb_gro_header(struct sk_buff *skb, unsigned int hlen,
>  	return ptr;
>  }
>  
> +static inline int skb_gro_network_offset(const struct sk_buff *skb)
> +{
> +	return NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark];
> +}
> +
>  static inline void *skb_gro_network_header(const struct sk_buff *skb)
>  {
>  	if (skb_gro_may_pull(skb, skb_gro_offset(skb)))
> -		return skb_gro_header_fast(skb, skb_network_offset(skb));
> +		return skb_gro_header_fast(skb, skb_gro_network_offset(skb));
>  
> -	return skb_network_header(skb);
> +	return skb->data + skb_gro_network_offset(skb);
>  }
>  
>  static inline __wsum inet_gro_compute_pseudo(const struct sk_buff *skb,
> diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
> index f00158234505..9404dd551dfd 100644
> --- a/net/8021q/vlan_core.c
> +++ b/net/8021q/vlan_core.c
> @@ -478,6 +478,8 @@ static struct sk_buff *vlan_gro_receive(struct list_head *head,
>  	if (unlikely(!vhdr))
>  		goto out;
>  
> +	NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark] = hlen;
> +
>  	type = vhdr->h_vlan_encapsulated_proto;
>  
>  	ptype = gro_find_receive_by_type(type);
> diff --git a/net/core/gro.c b/net/core/gro.c
> index 83f35d99a682..c7901253a1a8 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -371,6 +371,7 @@ static inline void skb_gro_reset_offset(struct sk_buff *skb, u32 nhoff)
>  	const skb_frag_t *frag0;
>  	unsigned int headlen;
>  
> +	NAPI_GRO_CB(skb)->network_offset = 0;
>  	NAPI_GRO_CB(skb)->data_offset = 0;
>  	headlen = skb_headlen(skb);
>  	NAPI_GRO_CB(skb)->frag0 = skb->data;
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 55bd72997b31..2daf635ab99e 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -1568,10 +1568,7 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
>  
>  	NAPI_GRO_CB(skb)->is_atomic = !!(iph->frag_off & htons(IP_DF));
>  	NAPI_GRO_CB(skb)->flush |= flush;
> -	skb_set_network_header(skb, off);
> -	/* The above will be needed by the transport layer if there is one
> -	 * immediately following this IP hdr.
> -	 */
> +	NAPI_GRO_CB(skb)->inner_network_offset = off;
>  
>  	/* Note : No need to call skb_gro_postpull_rcsum() here,
>  	 * as we already checked checksum over ipv4 header was 0
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index ebe4722bb020..be8ddf6da88c 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -332,7 +332,8 @@ struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff *skb)
>  
>  INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
>  {
> -	const struct iphdr *iph = ip_hdr(skb);
> +	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
> +	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
>  	struct tcphdr *th = tcp_hdr(skb);
>  
>  	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index c02bf011d4a6..1399fce82b3f 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -532,7 +532,8 @@ static inline struct sock *__udp4_lib_lookup_skb(struct sk_buff *skb,
>  struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
>  				 __be16 sport, __be16 dport)
>  {
> -	const struct iphdr *iph = ip_hdr(skb);
> +	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
> +	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
>  	struct net *net = dev_net(skb->dev);
>  	int iif, sdif;
>  
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 3498dd1d0694..fd29d21d579c 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -718,7 +718,8 @@ EXPORT_SYMBOL(udp_gro_complete);
>  
>  INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
>  {
> -	const struct iphdr *iph = ip_hdr(skb);
> +	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
> +	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
>  	struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
>  
>  	/* do fraglist only if there is no outer UDP encap (or we already processed it) */
> diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
> index b41e35af69ea..5d6b875a4638 100644
> --- a/net/ipv6/ip6_offload.c
> +++ b/net/ipv6/ip6_offload.c
> @@ -67,7 +67,7 @@ static int ipv6_gro_pull_exthdrs(struct sk_buff *skb, int off, int proto)
>  		off += len;
>  	}
>  
> -	skb_gro_pull(skb, off - skb_network_offset(skb));
> +	skb_gro_pull(skb, off - skb_gro_network_offset(skb));
>  	return proto;
>  }
>  
> @@ -236,7 +236,7 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
>  	if (unlikely(!iph))
>  		goto out;
>  
> -	skb_set_network_header(skb, off);
> +	NAPI_GRO_CB(skb)->inner_network_offset = off;
>  
>  	flush += ntohs(iph->payload_len) != skb->len - hlen;
>  
> @@ -259,7 +259,7 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
>  	NAPI_GRO_CB(skb)->proto = proto;
>  
>  	flush--;
> -	nlen = skb_network_header_len(skb);
> +	nlen = skb_gro_offset(skb) - off;
>  
>  	list_for_each_entry(p, head, list) {
>  		const struct ipv6hdr *iph2;
> diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
> index 4b07d1e6c952..e70d60e0f86f 100644
> --- a/net/ipv6/tcpv6_offload.c
> +++ b/net/ipv6/tcpv6_offload.c
> @@ -29,7 +29,8 @@ struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff *skb)
>  
>  INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int thoff)
>  {
> -	const struct ipv6hdr *iph = ipv6_hdr(skb);
> +	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
> +	const struct ipv6hdr *iph = (struct ipv6hdr *)(skb->data + offset);
>  	struct tcphdr *th = tcp_hdr(skb);
>  

Only udp code is affected, as only that can be used as tunnel.

For bug fixes, let's try to avoid touching other code. Also that vlan.

As a minimal patch all that is needed is the following, right?

- add the fields
- store in inet_gro_receive + ipv6_gro_receive
- read in udp[46]_gro_complete and udp[46]_lib_lookup_skb

+++ b/include/net/gro.h
@@ -87,6 +87,8 @@ struct napi_gro_cb {
 
        /* used to support CHECKSUM_COMPLETE for tunneling protocols */
        __wsum  csum;
+
+       u16 network_offsets[2];
 };
 
 #define NAPI_GRO_CB(skb) ((struct napi_gro_cb *)(skb)->cb)
@@ -180,6 +182,11 @@ static inline void *skb_gro_network_header(const struct sk_buff *skb)
        return skb_network_header(skb);
 }
 
+static inline void *skb_gro_complete_network_header(const struct sk_buff *skb)
+{
+       return skb->data + NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
+}
+
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index a7cfeda28bb2..4294efdd5613 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1569,6 +1569,7 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)

        NAPI_GRO_CB(skb)->is_atomic = !!(iph->frag_off & htons(IP_DF));
        NAPI_GRO_CB(skb)->flush |= flush;
+       NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark] = off;
        skb_set_network_header(skb, off);
        /* The above will be needed by the transport layer if there is one
         * immediately following this IP hdr.
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 944922172c98..1469e19bafd5 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -543,7 +543,7 @@ static inline struct sock *__udp4_lib_lookup_skb(struct sk_buff *skb,
 struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
                                 __be16 sport, __be16 dport)
 {
-       const struct iphdr *iph = ip_hdr(skb);
+       const struct iphdr *iph = skb_gro_complete_network_header(skb);
        struct net *net = dev_net(skb->dev);
        int iif, sdif;
 diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 3498dd1d0694..e93ddd42a091 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -718,7 +718,7 @@ EXPORT_SYMBOL(udp_gro_complete);

 INDIRECT_CALLABLE_SCOPE int udp4_gro_complete(struct sk_buff *skb, int nhoff)
 {
-       const struct iphdr *iph = ip_hdr(skb);
+       const struct iphdr *iph = skb_gro_complete_network_header(skb);
        struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
 
        /* do fraglist only if there is no outer UDP encap (or we already processed it) */
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index b41e35af69ea..5033ebfd5e92 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -236,6 +236,7 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
        if (unlikely(!iph))
                goto out;
 
+       NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark] = off;
        skb_set_network_header(skb, off);
 
        flush += ntohs(iph->payload_len) != skb->len - hlen;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 9914e73f4785..c012f6c41444 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -285,7 +285,7 @@ static struct sock *__udp6_lib_lookup_skb(struct sk_buff *skb,
 struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
                                 __be16 sport, __be16 dport)
 {
-       const struct ipv6hdr *iph = ipv6_hdr(skb);
+       const struct ipv6hdr *iph = skb_gro_complete_network_header(skb);
        struct net *net = dev_net(skb->dev);
        int iif, sdif;

diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index bbd347de00b4..274dd2983216 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -164,7 +164,7 @@ struct sk_buff *udp6_gro_receive(struct list_head *head, struct sk_buff *skb)

 INDIRECT_CALLABLE_SCOPE int udp6_gro_complete(struct sk_buff *skb, int nhoff)
 {
-       const struct ipv6hdr *ipv6h = ipv6_hdr(skb);
+       const struct ipv6hdr *ipv6h = skb_gro_complete_network_header(skb);
        struct udphdr *uh = (struct udphdr *)(skb->data + nhoff);
 

The part in udp_gro_complete that clears encap_mark and sets
encapsulation is definitely something to watch out for.

