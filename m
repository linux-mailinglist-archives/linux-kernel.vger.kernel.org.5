Return-Path: <linux-kernel+bounces-157556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294A68B12D1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E691F25B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4D5199B0;
	Wed, 24 Apr 2024 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="J1Nz0Jd8"
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884F71BF2B;
	Wed, 24 Apr 2024 18:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984536; cv=none; b=oZtWcJC8b56INTtf90LoRt8ogUJ1R+wDwsqApyGB1F7yOBn/y2R8GVxKzXFqTv1X1eGNWDA7GsE3MTK8pl+M4DdiQ+5vRsxZnGhgLjP+Isgf2Ghrfj22tDMcgw3r3DaQUrKMn4S0mZxfnwiQ21BoLUu3Tj6EyaE4DtmXnfZsM4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984536; c=relaxed/simple;
	bh=o8LJpEkE4yYPybCP4kfKGPt4Qz74mZcXYp6/YedXHTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+WiZVEZ0BhmpqMys1fD4cXj6x6XKyYNDLNEIOeOp6CB1/vubrFhcWnqLaIqdHYCIGvAmvUMHQV8rNG0fSPQ52m1RNeX2/TN27L/xMnvgiw75cN8EH//U3MALrS+AuGGCSQbouoKrbl1hmg2rs5x+4+kZk/0xmek1YsZoN6SEKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=J1Nz0Jd8; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LlfjSz+06TFcdqph25Lx5VBdUjKqbhfJRSC9oP2qMKM=; b=J1Nz0Jd8hk/pp+YNGSiBNmI3lu
	hZLg4JiMX4sq3G5bYJZc+8qzAD5UlgFiHtWMzKWU75/8LiuBIZw9ErC/LKKEqaC9DxXUOfZvhhA95
	yDH20/RqzHOUVVRfMlOzOQeLTtEYDse+fTRgIcPX1XhCSfdZmPrj1mYtSsJBSOD3QxZI=;
Received: from p200300daa70d8400593e4be1bb3506c9.dip0.t-ipconnect.de ([2003:da:a70d:8400:593e:4be1:bb35:6c9] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1rzhfj-006ski-2P;
	Wed, 24 Apr 2024 20:48:47 +0200
Message-ID: <87e6afb5-796b-48be-b68c-cd8a6a0f58f9@nbd.name>
Date: Wed, 24 Apr 2024 20:48:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] net: add heuristic for enabling TCP fraglist
 GRO
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, willemdebruijn.kernel@gmail.com,
 linux-kernel@vger.kernel.org
References: <20240424180458.56211-1-nbd@nbd.name>
 <20240424180458.56211-5-nbd@nbd.name>
 <CANn89iL39fo99P-mfiwR6jnMdw4do-tkyb=qxOQJLPtnB8cZvA@mail.gmail.com>
From: Felix Fietkau <nbd@nbd.name>
Content-Language: en-US
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <CANn89iL39fo99P-mfiwR6jnMdw4do-tkyb=qxOQJLPtnB8cZvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.04.24 20:23, Eric Dumazet wrote:
> On Wed, Apr 24, 2024 at 8:05 PM Felix Fietkau <nbd@nbd.name> wrote:
>>
>> When forwarding TCP after GRO, software segmentation is very expensive,
>> especially when the checksum needs to be recalculated.
>> One case where that's currently unavoidable is when routing packets over
>> PPPoE. Performance improves significantly when using fraglist GRO
>> implemented in the same way as for UDP.
>>
>> When NETIF_F_GRO_FRAGLIST is enabled, perform a lookup for an established
>> socket in the same netns as the receiving device. While this may not
>> cover all relevant use cases in multi-netns configurations, it should be
>> good enough for most configurations that need this.
>>
>> Here's a measurement of running 2 TCP streams through a MediaTek MT7622
>> device (2-core Cortex-A53), which runs NAT with flow offload enabled from
>> one ethernet port to PPPoE on another ethernet port + cake qdisc set to
>> 1Gbps.
>>
>> rx-gro-list off: 630 Mbit/s, CPU 35% idle
>> rx-gro-list on:  770 Mbit/s, CPU 40% idle
>>
>> Signe-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>  net/ipv4/tcp_offload.c   | 45 ++++++++++++++++++++++++++++++++++++++-
>>  net/ipv6/tcpv6_offload.c | 46 +++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 89 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
>> index 6294e7a5c099..f987e2d8423a 100644
>> --- a/net/ipv4/tcp_offload.c
>> +++ b/net/ipv4/tcp_offload.c
>> @@ -404,6 +404,49 @@ void tcp_gro_complete(struct sk_buff *skb)
>>  }
>>  EXPORT_SYMBOL(tcp_gro_complete);
>>
>> +static bool tcp4_check_fraglist_gro(struct sk_buff *skb)
>> +{
>> +       const struct iphdr *iph = skb_gro_network_header(skb);
>> +       struct net *net = dev_net(skb->dev);
>> +       unsigned int off, hlen, thlen;
>> +       struct tcphdr *th;
>> +       struct sock *sk;
>> +       int iif, sdif;
>> +
>> +       if (!(skb->dev->features & NETIF_F_GRO_FRAGLIST))
>> +               return false;
>> +
>> +       inet_get_iif_sdif(skb, &iif, &sdif);
>> +
>> +       off = skb_gro_offset(skb);
>> +       hlen = off + sizeof(*th);
>> +       th = skb_gro_header(skb, hlen, off);
>> +       if (unlikely(!th))
>> +               return false;
>> +
>> +       thlen = th->doff * 4;
>> +       if (thlen < sizeof(*th))
>> +               return false;
>> +
>> +       hlen = off + thlen;
>> +       if (!skb_gro_may_pull(skb, hlen)) {
>> +               th = skb_gro_header_slow(skb, hlen, off);
>> +               if (unlikely(!th))
>> +                       return false;
>> +       }
>> +
>> +       sk = __inet_lookup_established(net, net->ipv4.tcp_death_row.hashinfo,
>> +                                      iph->saddr, th->source,
>> +                                      iph->daddr, ntohs(th->dest),
>> +                                      iif, sdif);
> 
> Presumably all this could be done only for the first skb/segment of a GRO train.
> 
> We could store the fraglist in a single bit in NAPI_GRO_CB(skb) ?
> 
> GRO does a full tuple evaluation, we can trust it.

I will look into that, thanks.

- Felix

