Return-Path: <linux-kernel+bounces-143843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E8E8A3E21
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 20:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9427B1F21790
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 18:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BB953E17;
	Sat, 13 Apr 2024 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPGgfFZ0"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557F741C93;
	Sat, 13 Apr 2024 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713033963; cv=none; b=j2/v1bu9Almce8utWjqh5Y8guwwpwrjsHTw5jkb54W4sYcwFp79U5t6oCq3gM6J2BnS2vg402RlwSH9dYWxlHewEZ3xxaidIuZv28lGWuvVBRCQvioR9Uwqry6Ng9RNy/YyvCCM3xB4EdHDmn6XAbjtYrcW0IhIjgVE43cYN3KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713033963; c=relaxed/simple;
	bh=hp+cZbOGUc/QMU9wD+lRPwoJU4H1B4EOsTLsjCzt2A4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eysq3EdIt5XkPpKiqJJrpnZ7w29EN49yA2Nx2kL9wGvFtFtUgUuwJNSURcy8lLmQ6Hm8WntV6uM870hkFh1A2LSf5H1FuKRkBcowKeZuNFiykSJ7PwRBwyAqKHWiV4eiKExa5Z87sZShAUIes586yxBdevYVRYHeZQnVoOIBsHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPGgfFZ0; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4365c1451d4so8392401cf.2;
        Sat, 13 Apr 2024 11:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713033961; x=1713638761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pW67T+qUQM50F+0toP2yI/LFVI197DGuTCoBQXe7TOE=;
        b=GPGgfFZ0ElOYW+58plzOlS6MEArPoBcrVjToWWV3p7r2Xgc3OIEnUcphI7YGFAaWqm
         MUvv8QIajPaMVia1wOg3Z3SJFjuLy2HlYGzzX40LMBLlmN+BXPG/FKoTDpi0g573Uzf3
         d5LWsvi+nq7Aehy1cFqmGZBoSz1YyRNP9Y3p6d2U1OhoVzImucDFYGBwQ7W90hnwoqUY
         k9j4O0vIifzd11k/GI0XjX2jI8cGbjPjdPY+Ul79tOklBRjAYdjkk2twAPPS+bYbDQeN
         WjVoAYOa82cYyrfacwSRWxEY9L2OXkn+335BtPAeM/YDxSWY83SbjmhqvFpIW5+L8mww
         45lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713033961; x=1713638761;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pW67T+qUQM50F+0toP2yI/LFVI197DGuTCoBQXe7TOE=;
        b=m/Jv/sq4tqrFjyRbc8mA/q1qzBcWmUSXF2PoPRzrXZ/Dmpyj9hl02vhjWr+7/7pHAV
         tKM+qoNiIPWox9f7uu4+ocpvtcWjkymk43LI4lQa7sKFPXr9a+TeEbDoir01aDoTBs0n
         IYAkUkxjjCH0Y84rMdb1xMpiKVaozEQcuhHE6KecxFQQHwfcmS+gbernp1V2z+C0J+vD
         g1dunngTOn3rlQ3UHPTkwmGTqmYr1jLakZql0mCVFcvHeHmfEfWshaB4jjyV0cMdIEm6
         cEfwRm9OSJFAhj/5yc3Lcuebauy2QSa3XdBuVV9FvATHHQ2DaEZfeygOestbJpRYaZ0I
         TGYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeSM65vLmdfWVrtyp+pqbmJN5mMdEV0QHGpJ68BeDpZ2Pl5w3YwKjrIBZvvVKMIR0EEBNX/WMDTvvMsDHbvQaRxCX/Rs4wsR4snID9g1unI/FmM+tQkUXY/M8yB2CXlwn75uht
X-Gm-Message-State: AOJu0Yxsnq8Vh5+QqmMJe8U3cPyUjA/UczjQ0868e1tU8flUtawlxZGp
	X7ehQAXcbXNfStt/ZXYPMX/ra4QoHyq9x/3GKpblMQ9Ehiyo+FSX
X-Google-Smtp-Source: AGHT+IFtFXbJOcTBu71b3myFnqKFQJFfdwoTCK40N6wDfMWAHYCxxued7XkKyrmGrWZwqTf1RRMKUg==
X-Received: by 2002:a05:622a:138b:b0:432:e789:e0b0 with SMTP id o11-20020a05622a138b00b00432e789e0b0mr9227603qtk.38.1713033961275;
        Sat, 13 Apr 2024 11:46:01 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id l12-20020ac8458c000000b00436c316b737sm934108qtn.78.2024.04.13.11.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 11:46:00 -0700 (PDT)
Date: Sat, 13 Apr 2024 14:46:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 dsahern@kernel.org, 
 aleksander.lobakin@intel.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Message-ID: <661ad2e8a7e95_3be9a7294a5@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240412152120.115067-3-richardbgobert@gmail.com>
References: <20240412152120.115067-1-richardbgobert@gmail.com>
 <20240412152120.115067-3-richardbgobert@gmail.com>
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
> To fix this issue p_off param is used in *_gro_complete to pass off the
> offset of the previous layer.
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
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> index 163f94a5a58f..9c18a39b0d0c 100644
> --- a/drivers/net/geneve.c
> +++ b/drivers/net/geneve.c
> @@ -555,7 +555,7 @@ static struct sk_buff *geneve_gro_receive(struct sock *sk,
>  }
>  
>  static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
> -			       int nhoff)
> +			       int p_off, int nhoff)
>  {
>  	struct genevehdr *gh;
>  	struct packet_offload *ptype;
> @@ -569,11 +569,12 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
>  
>  	/* since skb->encapsulation is set, eth_gro_complete() sets the inner mac header */
>  	if (likely(type == htons(ETH_P_TEB)))
> -		return eth_gro_complete(skb, nhoff + gh_len);
> +		return eth_gro_complete(skb, p_off, nhoff + gh_len);

Since the new field to the callback is only used between IP and
transport layer callback implementations, I think the others should
just return zero, to make it clear that the value is unused.

I still think that if the only issue is with udp, we can just special
case those and pass the nhoff instead of thoff in the existing one
available offset field, and compute the transport offset in the udp
function. For much less code churn. But unless anyone else agrees you
can ignore that suggestion.

> -int inet_gro_complete(struct sk_buff *skb, int nhoff)
> +int inet_gro_complete(struct sk_buff *skb, int prior_off, int nhoff)
>  {
>  	struct iphdr *iph = (struct iphdr *)(skb->data + nhoff);
>  	const struct net_offload *ops;
> @@ -1667,17 +1667,17 @@ int inet_gro_complete(struct sk_buff *skb, int nhoff)
>  	 */
>  	err = INDIRECT_CALL_2(ops->callbacks.gro_complete,
>  			      tcp4_gro_complete, udp4_gro_complete,
> -			      skb, nhoff + sizeof(*iph));
> +				  skb, nhoff, nhoff + sizeof(*iph));

Identation change

>  struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
> +				 int nhoff,
>  				 __be16 sport, __be16 dport)
>  {
> -	const struct iphdr *iph = ip_hdr(skb);
> +	const struct iphdr *iph = (const struct iphdr *)(skb->data + nhoff);

How about instead just pass the saddr and daddr and leave the iph
pointer to the caller (which also computes the udph pointer).

