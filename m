Return-Path: <linux-kernel+bounces-157951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 161BC8B1928
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A89352858AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFE517C77;
	Thu, 25 Apr 2024 03:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSqvxoXq"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ED2134BC;
	Thu, 25 Apr 2024 03:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014217; cv=none; b=Riozu2No080VeaYMfhVvht3+vLfRvPG+2ifNzKO0jF4Hcnsc4YGF1C2F+qCTJtL6vUsKQfoHXn4RVJ4pEjpuOp3M3Yg4J0zHOpHifSwp+7mf5JRtaRBOe3FZRelxkD9rMSNGEMBjGpZeVJzJL0M1JTU8cGtOw7QpjLOC75JrsCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014217; c=relaxed/simple;
	bh=hrls28VZUqrKfmBz7qUiC4yMIaZdD3XAD/qf9p56ofk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ep6JpChttoC7tlTAZ8UdvfjQuyRxIBYHQh11L22uyOv5fK9sASCnHToy/KRhrVrwRPj3VU3WqsgHGPRomLo+TG0ewLDJXXnlM0uTKp4Fy5Is0VqzukFt4OPnjSaitAtLH40lV9kAkeUqMoGh34kRpvf1gyYW55NzUckRh5fDXNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSqvxoXq; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-439dfa27003so2907401cf.2;
        Wed, 24 Apr 2024 20:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714014215; x=1714619015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rop1XuWPJglB9LLnXsaZnX6mSKTbj0oKKR7zZbLFFkM=;
        b=bSqvxoXqAB4I2OQjl8tRSh6hyTXpLe03TYeCmo9Ec8w8vFjpPUzRY26bojv0nQcIoM
         tAub+kw/WxfiDqtCGVh29SmGryyTN+/ttNjA5Rhw16tZE90wcfligh0WPX+pLPjhiZ+l
         NewoHqMk2ETGh6tkqF6ip1wT2WhBnYmy70XEg2JTK57BenGuY+x1p+LryBxqtgAfOoix
         UJrlUwuKXd02KGmVnyXOJ+du+UWHNK/XDznb5fSvJUFuO9YaPH+B3Xqiqo++E8ZZ6f/m
         S6aw/NciFw62GHLH2dy7P6f2bGyuvj0OjEJrNWg24t8ztKJ4f9Cx9SmDl1/l4Is61keD
         l9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714014215; x=1714619015;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rop1XuWPJglB9LLnXsaZnX6mSKTbj0oKKR7zZbLFFkM=;
        b=FOfkHunruyQ/MRPL66K6cwIrk4vOn2F/40iU/P3gnNivqlh9jidEzQuk2W0M44t6qA
         m9DeZRbr5NtxmbjhUPI1H/MR9j8Q0s5l4vJZBdraDMkkEF0bgWWE0FnNMDmAV6OwY5I8
         uXQ0AvvaI4dPOBBai89ZSsPGmDsW3qQDNfIwxsW6wvFRFBBKF9CvOef331zSpG30jO/S
         PVM2DQBPR/XEi4mCrcNuvBik2Dcs7GKWqJeWImHQvAscOR2LWVq+yxJvDFN9mulEOBU0
         7ODnViRC+rY8JQFLJOYzPFDKFSe8JTpSchF1pX7HGDiBXlKDt12XWtLpLSrkpaYViQI9
         S6Xg==
X-Forwarded-Encrypted: i=1; AJvYcCX+C7ztu0/XgnmLGCiQaRRNHV/CXQp/fAOUzgS7Ny7ANexjtWkhCAvtKUdVyKOOdsB07baDxOa1zKfKNX5ivJbJ9kDYPE9ku+XUlX0Ky6CeuF+kZOYlQFYSg6d6cYIL0rwWv2j2
X-Gm-Message-State: AOJu0YxueTDNAt4WnnuVOMNhO1gzJLtjkbCdGyCo3GewQhJ3/CBKnKoC
	XjluPFAEyli1ERLCpNXmG8Jw/iWGGZCrMtFPrmydHk35LqhxYmfF
X-Google-Smtp-Source: AGHT+IGgudiCnro+jtgubs47QTW5IYjR2+6Y29KB8ZwDsczpOSV2fWd2Ww4ZtPGfdse9aZJnnxkZ4g==
X-Received: by 2002:a05:622a:191f:b0:439:e95e:5bc0 with SMTP id w31-20020a05622a191f00b00439e95e5bc0mr5315694qtc.40.1714014214589;
        Wed, 24 Apr 2024 20:03:34 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id p9-20020ac84089000000b00437a996ca44sm6241153qtl.21.2024.04.24.20.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 20:03:34 -0700 (PDT)
Date: Wed, 24 Apr 2024 23:03:33 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Felix Fietkau <nbd@nbd.name>, 
 netdev@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: willemdebruijn.kernel@gmail.com, 
 linux-kernel@vger.kernel.org
Message-ID: <6629c805d808e_1bd6b029424@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240424180458.56211-3-nbd@nbd.name>
References: <20240424180458.56211-1-nbd@nbd.name>
 <20240424180458.56211-3-nbd@nbd.name>
Subject: Re: [PATCH net-next 2/4] net: add support for segmenting TCP fraglist
 GSO packets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Felix Fietkau wrote:
> Preparation for adding TCP fraglist GRO support. It expects packets to be
> combined in a similar way as UDP fraglist GSO packets.
> One difference is the fact that this code assumes that the TCP flags of
> all packets have the same value. This allows simple handling of flags
> mutations.

Can you clarify this some more? We expect potentially different flags
on first and last packet in a TSO train. With fraglist, the segments
keep their original flags, as the headers are only pulled. When do
segment flags need to be replaced with those of the first segment?

> For IPv4 packets, NAT is handled in the same way as UDP
> fraglist GSO.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/ipv4/tcp_offload.c   | 74 ++++++++++++++++++++++++++++++++++++++++
>  net/ipv6/tcpv6_offload.c | 37 ++++++++++++++++++++
>  2 files changed, 111 insertions(+)
> 
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index fab0973f995b..06dbb2e2b2f3 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -28,6 +28,77 @@ static void tcp_gso_tstamp(struct sk_buff *skb, unsigned int ts_seq,
>  	}
>  }
>  
> +static void __tcpv4_gso_segment_csum(struct sk_buff *seg,
> +				     __be32 *oldip, __be32 *newip,
> +				     __be16 *oldport, __be16 *newport)
> +{
> +	struct tcphdr *th;
> +	struct iphdr *iph;
> +
> +	if (*oldip == *newip && *oldport == *newport)
> +		return;
> +
> +	th = tcp_hdr(seg);
> +	iph = ip_hdr(seg);
> +
> +	inet_proto_csum_replace4(&th->check, seg, *oldip, *newip, true);
> +	inet_proto_csum_replace2(&th->check, seg, *oldport, *newport, false);
> +	*oldport = *newport;
> +
> +	csum_replace4(&iph->check, *oldip, *newip);
> +	*oldip = *newip;
> +}
> +
> +static struct sk_buff *__tcpv4_gso_segment_list_csum(struct sk_buff *segs)
> +{
> +	struct sk_buff *seg;
> +	struct tcphdr *th, *th2;
> +	struct iphdr *iph, *iph2;
> +	__be32 flags, flags2;
> +
> +	seg = segs;
> +	th = tcp_hdr(seg);
> +	iph = ip_hdr(seg);
> +	flags = tcp_flag_word(th);
> +	flags2 = tcp_flag_word(tcp_hdr(seg->next));
> +
> +	if ((tcp_hdr(seg)->dest == tcp_hdr(seg->next)->dest) &&
> +	    (tcp_hdr(seg)->source == tcp_hdr(seg->next)->source) &&
> +	    (ip_hdr(seg)->daddr == ip_hdr(seg->next)->daddr) &&
> +	    (ip_hdr(seg)->saddr == ip_hdr(seg->next)->saddr) &&
> +	    (flags == flags2))
> +		return segs;
> +
> +	while ((seg = seg->next)) {
> +		th2 = tcp_hdr(seg);
> +		iph2 = ip_hdr(seg);
> +
> +		__tcpv4_gso_segment_csum(seg,
> +					 &iph2->saddr, &iph->saddr,
> +					 &th2->source, &th->source);
> +		__tcpv4_gso_segment_csum(seg,
> +					 &iph2->daddr, &iph->daddr,
> +					 &th2->dest, &th->dest);
> +		if (flags == flags2)
> +			continue;
> +
> +		inet_proto_csum_replace4(&th2->check, seg, flags2, flags, false);
> +		tcp_flag_word(th2) = flags;
> +	}
> +
> +	return segs;
> +}
> +
> +static struct sk_buff *__tcp_gso_segment_list(struct sk_buff *skb,
> +					      netdev_features_t features)

For consistency and to avoid having the same name in ipv6,
add the 4/6 suffix here too.

> +{
> +	skb = skb_segment_list(skb, features, skb_mac_header_len(skb));
> +	if (IS_ERR(skb))
> +		return skb;
> +
> +	return __tcpv4_gso_segment_list_csum(skb);
> +}
> +
>  static struct sk_buff *tcp4_gso_segment(struct sk_buff *skb,
>  					netdev_features_t features)
>  {
> @@ -37,6 +108,9 @@ static struct sk_buff *tcp4_gso_segment(struct sk_buff *skb,
>  	if (!pskb_may_pull(skb, sizeof(struct tcphdr)))
>  		return ERR_PTR(-EINVAL);
>  
> +	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)
> +		return __tcp_gso_segment_list(skb, features);
> +
>  	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL)) {
>  		const struct iphdr *iph = ip_hdr(skb);
>  		struct tcphdr *th = tcp_hdr(skb);
> diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
> index 4b07d1e6c952..12fe79cb2c10 100644
> --- a/net/ipv6/tcpv6_offload.c
> +++ b/net/ipv6/tcpv6_offload.c
> @@ -40,6 +40,40 @@ INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int thoff)
>  	return 0;
>  }
>  
> +static struct sk_buff *__tcpv6_gso_segment_list_csum(struct sk_buff *segs)
> +{
> +	struct tcphdr *th, *th2;
> +	__be32 flags, flags2;
> +	struct sk_buff *seg;
> +
> +	seg = segs;
> +	th = tcp_hdr(seg);
> +	flags = tcp_flag_word(th);
> +	flags2 = tcp_flag_word(tcp_hdr(seg->next));
> +
> +	if (flags == flags2)
> +		return segs;
> +
> +	while ((seg = seg->next)) {
> +		th2 = tcp_hdr(seg);
> +
> +		inet_proto_csum_replace4(&th2->check, seg, flags2, flags, false);
> +		tcp_flag_word(th2) = flags;
> +	}
> +
> +	return segs;
> +}
> +
> +static struct sk_buff *__tcp_gso_segment_list(struct sk_buff *skb,
> +					      netdev_features_t features)
> +{
> +	skb = skb_segment_list(skb, features, skb_mac_header_len(skb));
> +	if (IS_ERR(skb))
> +		return skb;
> +
> +	return __tcpv6_gso_segment_list_csum(skb);
> +}
> +
>  static struct sk_buff *tcp6_gso_segment(struct sk_buff *skb,
>  					netdev_features_t features)
>  {
> @@ -51,6 +85,9 @@ static struct sk_buff *tcp6_gso_segment(struct sk_buff *skb,
>  	if (!pskb_may_pull(skb, sizeof(*th)))
>  		return ERR_PTR(-EINVAL);
>  
> +	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)
> +		return __tcp_gso_segment_list(skb, features);
> +
>  	if (unlikely(skb->ip_summed != CHECKSUM_PARTIAL)) {
>  		const struct ipv6hdr *ipv6h = ipv6_hdr(skb);
>  		struct tcphdr *th = tcp_hdr(skb);
> -- 
> 2.44.0
> 
x


