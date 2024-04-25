Return-Path: <linux-kernel+bounces-158787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBA88B24E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98B11F23F06
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB2914AD26;
	Thu, 25 Apr 2024 15:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RETx1rYi"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DA637152;
	Thu, 25 Apr 2024 15:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058340; cv=none; b=ZDto8Jp/FoENq4LVROpCkHC4+zDJMKVPqAK4EZD49TnyhqcKmlSQpUKZdw57d7ZLwCJBsV5YuMYbTPYqJ+itkrhmT4/F+DdU13DQR5QU737uDGP0D/WWsF/lUj6A52DQUNm23VfGx5DtqgzyoJ7Dvuo5YzZ/WtjPi1hKcUnEAY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058340; c=relaxed/simple;
	bh=9M6vtUakJu+k55Gvwn+/QlmTn6sbD+rg0lQOIarprlM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sqh87/T9IhbZ63u8ofFUt+OkSmdYhROZpEmxIlYzTD7j/FcuuaAcssRtry/PZIztfX4L3vt92KMRAgzgpscHSGIaCffPiIrPzXrYHc3hJaDDvLnU+t6yHIhlg6sy74sdxqjz7M4DeHU35L8H6tTwwtQM7WuTw6mcm8h/TPO4EWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RETx1rYi; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-43a14bce92dso6879731cf.0;
        Thu, 25 Apr 2024 08:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714058338; x=1714663138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEb4JCTaNACqAi0ozv0IUDrgXjigFGOhgDW02zP1PRE=;
        b=RETx1rYiEV5CMXSlJ3xp+vzAbA6tLLTvg5JkVhlgr/cSnBP5aGelQ5kpGWVqqtJSRy
         Ypu9vQdLlirO7jOGrJFQOQ3Hj5IBXINkMlNotH5vc2TV8IJsHK7P1PPPUVN64u72hMB+
         YueE30I/Ysion97DvgUGN6eS6/bGpB38XtlAdQlUmWTXSGY66ixSdvLI/+akWAoCudAw
         CQmKaOH9MIrl6CqcdqGQNVF1MxFI5aMPh4rk9i1B2xSZTPlLAR0hVJPCIE9fPYe3yiyd
         W3Y5k33e8BTz3RKCPsdu3UTMLiRZkGwl8FcMqc9CK1J4b8Fk2v5FdOX0bw7aeeiHxpzL
         0Lcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714058338; x=1714663138;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DEb4JCTaNACqAi0ozv0IUDrgXjigFGOhgDW02zP1PRE=;
        b=JO/NQFBWpB08cFpJFCrstBB4yJvx1pye9f/H4Dvuf7+DhBbxZltci8U/P4zzM08n9S
         yDdDtcoQTrNjQGWUEqt3BG4+EZ3MAtaWvF5uYqtoe17yuNpIA/Unsa9DSZXQimAzAmrS
         QdR+GA8LjnYI0YejyEp6ByFLxC1qC2InW1UpAGWhL/vDVj4HspTi8gJM54whFwusu9JD
         FXa4LfAPsIy43NxKBNFb5WKcWxYXdrL4K5YH1WaJ5kMYmgRa4g0AeCRkqYpimNmGR1it
         5bDkJBRQ9SZbor8iY3bGYF/cv6487EK90nb4F1EFgISuTfvaVfXu5WVuzkqe/1Y/cvHo
         2E3w==
X-Forwarded-Encrypted: i=1; AJvYcCWUVul8C+re0gZs5LphxyCoEZtupuuLBQ6HlCnBm1q4vTfYowsxnhW1GkGYhINWnJFaE1lWQDg8U3GdYLoxuY+dzhKZluQkTEHyyekJqB0F7IH64bJo9BisLmCNP8iNR6YjVw1w
X-Gm-Message-State: AOJu0Yx6tGonloxB+8nFz+pP27Z9CReoRvnhA6ptJwGzevMEA7jC/Km1
	X6lAGjuwfh/c+4zvnC67PEm4L2ANhgKR2QNqJxwlHDaEGdRGWbQK
X-Google-Smtp-Source: AGHT+IHNMcFHsQBa+kIhwaKZKKBm7/akFvzUGBJhM/lFn/CjGAKWF2ixGsiaiwYxrsmwKBDT9nl1LA==
X-Received: by 2002:ad4:4ea5:0:b0:699:2cd9:fbee with SMTP id ed5-20020ad44ea5000000b006992cd9fbeemr104306qvb.3.1714058337683;
        Thu, 25 Apr 2024 08:18:57 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id k10-20020a0c970a000000b006a079a9adc4sm4437276qvd.40.2024.04.25.08.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 08:18:57 -0700 (PDT)
Date: Thu, 25 Apr 2024 11:18:57 -0400
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
Message-ID: <662a746130c38_1e1a1629422@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240425150432.44142-4-nbd@nbd.name>
References: <20240425150432.44142-1-nbd@nbd.name>
 <20240425150432.44142-4-nbd@nbd.name>
Subject: Re: [PATCH v2 net-next v2 3/5] net: add code for TCP fraglist GRO
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
> This implements fraglist GRO similar to how it's handled in UDP, however
> no functional changes are added yet. The next change adds a heuristic for
> using fraglist GRO instead of regular GRO.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/ipv4/tcp_offload.c   | 22 ++++++++++++++++++++++
>  net/ipv6/tcpv6_offload.c |  9 +++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index e455f884190c..68157130c264 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -336,6 +336,19 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
>  	flush |= (ntohl(th2->seq) + skb_gro_len(p)) ^ ntohl(th->seq);
>  	flush |= skb_cmp_decrypted(p, skb);
>  
> +	if (NAPI_GRO_CB(p)->is_flist) {
> +		flush |= (__force int)(flags ^ tcp_flag_word(th2));

What is the purpose of this check, given the existing check above

        flush |= (__force int)((flags ^ tcp_flag_word(th2)) &
                  ~(TCP_FLAG_CWR | TCP_FLAG_FIN | TCP_FLAG_PSH));

> +		flush |= skb->ip_summed != p->ip_summed;
> +		flush |= skb->csum_level != p->csum_level;
> +		flush |= !pskb_may_pull(skb, skb_gro_offset(skb));
> +		flush |= NAPI_GRO_CB(p)->count >= 64;
> +
> +		if (flush || skb_gro_receive_list(p, skb))
> +			mss = 1;
> +
> +		goto out_check_final;
> +	}
> +
>  	if (flush || skb_gro_receive(p, skb)) {
>  		mss = 1;
>  		goto out_check_final;
> @@ -402,6 +415,15 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
>  	const struct iphdr *iph = ip_hdr(skb);
>  	struct tcphdr *th = tcp_hdr(skb);
>  
> +	if (NAPI_GRO_CB(skb)->is_flist) {
> +		skb_shinfo(skb)->gso_type |= SKB_GSO_FRAGLIST | SKB_GSO_TCPV4;
> +		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
> +
> +		__skb_incr_checksum_unnecessary(skb);
> +
> +		return 0;
> +	}
> +
>  	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
>  				  iph->daddr, 0);
>  
> diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
> index b3b8e1f6b92a..c97d55cf036f 100644
> --- a/net/ipv6/tcpv6_offload.c
> +++ b/net/ipv6/tcpv6_offload.c
> @@ -32,6 +32,15 @@ INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int thoff)
>  	const struct ipv6hdr *iph = ipv6_hdr(skb);
>  	struct tcphdr *th = tcp_hdr(skb);
>  
> +	if (NAPI_GRO_CB(skb)->is_flist) {
> +		skb_shinfo(skb)->gso_type |= SKB_GSO_FRAGLIST | SKB_GSO_TCPV6;
> +		skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
> +
> +		__skb_incr_checksum_unnecessary(skb);
> +
> +		return 0;
> +	}
> +
>  	th->check = ~tcp_v6_check(skb->len - thoff, &iph->saddr,
>  				  &iph->daddr, 0);
>  	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV6;
> -- 
> 2.44.0
> 



