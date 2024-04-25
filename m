Return-Path: <linux-kernel+bounces-158800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 032FD8B250F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820622899D6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA7014BFAB;
	Thu, 25 Apr 2024 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kh7wNSRW"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4F014B083
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058783; cv=none; b=NGMaY7w7DmFjRVA19PP9CzD9h2c8IsJeKS9Zv0rHSV9D9prlp37oLs8kejHTiYFUPXuzckeMNL+Qr/+5hOfTCvAP1rf8MHVp8egJPJJhaeXXul7Wa3MX5JhE9nJW2uo5gGlIFXR58s2cz/w7glArCl3tvmt4YBQoKEVM5IsbuwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058783; c=relaxed/simple;
	bh=cHWyebxt5OQl4mT21gySDT3/gmUfFdKMxDeguLjl4yI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KnfmG8SGwxqQs1UMelN5ATI4vlS4snaUicOLqbVuserCG0+WY4kfc0pojzBd9ZZdwSpasn7nSPmAkq1hQ7kcPrfCoDS8rORkiBEezLxj2j721VK7AsMjLa02j6dD3eyYSXxa854hk+DxbVLhePonV/aIYjILgGtWyxKb4yXhsUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kh7wNSRW; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-571e13cd856so17782a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 08:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714058778; x=1714663578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qyLMtfVD3hHfrVSsuLjWOoTcQ0JXVPh5F7fHPduNv2k=;
        b=Kh7wNSRWIia7fITMOS1ZFH82nrbEVH8W//pVJJf1L5lR8ZShDvqphBI1rXV8rz5fwM
         5+Cc97ENzQgBPEn3mmHCkY4tgMGan28x1aVMhpdMhOkGp1AUt5mlI5HyFK7r80A8Rtr9
         8MNelVazeMcmYcEgpsMVlin+zrVU5YwvQXXD0s4NkJwTFXP1aqKrLHZ6CfOpqcLsAa6u
         5MpkzT75pxIQBA1U5ymHhcgQbBv8jxLHEEE5Ao3ak46fvDTkDYvnGp5YwhQ4KR1KMy5R
         wBU/cPDRsxt4xiLcqJcc746Ie4BClxm6Kam6vwwax8SRBxWiQ4Zxv+x2YkFqymE+Jywi
         TvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714058778; x=1714663578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qyLMtfVD3hHfrVSsuLjWOoTcQ0JXVPh5F7fHPduNv2k=;
        b=fMJE536Lu4a6ok3VoTXImv843jnLQmD3HVTBbai6V3CJ1GwGszesDtirLwFpGAsF8N
         IWmw4XgB3uRf6BPX7M0qUBzu400Z1SDgGJ+8aQ/zMiOHlEx8/W7+5wkcrjj46+DT+73i
         qSFZurCPrpwCs2hUTkZdcsiFR84A37gdcdnwmXCyjJfPg7FUAeGn4BdVsxhiSiUKPBiZ
         25VgUqKeo/9NxXzgZADJxh4lKG5BywxnkTE+PsoCIT4NV8Hqfr+3K5VplKJvXaGUAuBB
         GIz7RAhEs8/53HqleWgPItuDiJY9JqqZlucYzi6s/PUEMrYR83TnLivkB7CO+FAmH/to
         e1Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWzYLfI82M5ZQNZieym473gHR5YxsFoIGBX374v2RjuSzLkE+auQkE8JQwGhOJadtKYOJ5s3LR1FdH8xtjGNde5bzs9dei2PH6KmDpe
X-Gm-Message-State: AOJu0YxjCOOOzlgxhcWINg8KgUp3PfkcQ2WNMJpyoaYYF6qoj9G/1YI2
	QpoqdfdlCQw2L3sqS92+899bDxWAHDLyujv0loN308ITPkVwuFfWESPzSfpXzg7aVUFMQUU8fxm
	GD3WOiUnJ5G1Ok0ZzxyksdrEyqgJEI06pvUUF
X-Google-Smtp-Source: AGHT+IFiTUdvpYl91YDCAcS2bV0dz1FYCL5wneUM7lpb4Q/trYbnMteWBIQObXG8f2Mi7GjKqJNSG9gZrbhzkgSThRY=
X-Received: by 2002:a05:6402:40cb:b0:572:3b8c:b936 with SMTP id
 z11-20020a05640240cb00b005723b8cb936mr236550edb.2.1714058778010; Thu, 25 Apr
 2024 08:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425150432.44142-1-nbd@nbd.name> <20240425150432.44142-7-nbd@nbd.name>
In-Reply-To: <20240425150432.44142-7-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Apr 2024 17:26:04 +0200
Message-ID: <CANn89iLqpADT6T_JtecgMJKKcTEBORVdVqTYYBRtwWWnk6=4ng@mail.gmail.com>
Subject: Re: [PATCH v2 net-next v2 5/5] net: add heuristic for enabling TCP
 fraglist GRO
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:04=E2=80=AFPM Felix Fietkau <nbd@nbd.name> wrote:
>
> When forwarding TCP after GRO, software segmentation is very expensive,
> especially when the checksum needs to be recalculated.
> One case where that's currently unavoidable is when routing packets over
> PPPoE. Performance improves significantly when using fraglist GRO
> implemented in the same way as for UDP.
>
> When NETIF_F_GRO_FRAGLIST is enabled, perform a lookup for an established
> socket in the same netns as the receiving device. While this may not
> cover all relevant use cases in multi-netns configurations, it should be
> good enough for most configurations that need this.
>
> Here's a measurement of running 2 TCP streams through a MediaTek MT7622
> device (2-core Cortex-A53), which runs NAT with flow offload enabled from
> one ethernet port to PPPoE on another ethernet port + cake qdisc set to
> 1Gbps.
>
> rx-gro-list off: 630 Mbit/s, CPU 35% idle
> rx-gro-list on:  770 Mbit/s, CPU 40% idle
>
> Signe-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/ipv4/tcp_offload.c   | 48 +++++++++++++++++++++++++++++++++++++
>  net/ipv6/tcpv6_offload.c | 51 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 99 insertions(+)
>
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index 520fd425ab19..3bb96a110402 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -405,6 +405,52 @@ void tcp_gro_complete(struct sk_buff *skb)
>  }
>  EXPORT_SYMBOL(tcp_gro_complete);
>
> +static void tcp4_check_fraglist_gro(struct list_head *head, struct sk_bu=
ff *skb)
> +{
> +       const struct iphdr *iph =3D skb_gro_network_header(skb);

I do not think loading iph before all skb_gro_header() and
skb_gro_header_slow() calls is wise.

pskb_may_pull() can re-allocate skb->head

> +       struct net *net =3D dev_net(skb->dev);
> +       unsigned int off, hlen, thlen;
> +       struct sk_buff *p;
> +       struct tcphdr *th;
> +       struct sock *sk;
> +       int iif, sdif;
> +
> +       if (!(skb->dev->features & NETIF_F_GRO_FRAGLIST))
> +               return;
> +
> +       off =3D skb_gro_offset(skb);
> +       hlen =3D off + sizeof(*th);
> +       th =3D skb_gro_header(skb, hlen, off);
> +       if (unlikely(!th))
> +               return;
> +
> +       thlen =3D th->doff * 4;
> +       if (thlen < sizeof(*th))
> +               return;
> +
> +       hlen =3D off + thlen;
> +       if (!skb_gro_may_pull(skb, hlen)) {
> +               th =3D skb_gro_header_slow(skb, hlen, off);
> +               if (unlikely(!th))
> +                       return;
> +       }
> +
> +       p =3D tcp_gro_lookup(head, th);
> +       if (p) {
> +               NAPI_GRO_CB(skb)->is_flist =3D NAPI_GRO_CB(p)->is_flist;
> +               return;
> +       }
> +
> +       inet_get_iif_sdif(skb, &iif, &sdif);
> +       sk =3D __inet_lookup_established(net, net->ipv4.tcp_death_row.has=
hinfo,
> +                                      iph->saddr, th->source,
> +                                      iph->daddr, ntohs(th->dest),
> +                                      iif, sdif);
> +       NAPI_GRO_CB(skb)->is_flist =3D !sk;
> +       if (sk)
> +               sock_put(sk);
> +}
> +
>  INDIRECT_CALLABLE_SCOPE
>  struct sk_buff *tcp4_gro_receive(struct list_head *head, struct sk_buff =
*skb)
>  {
> @@ -416,6 +462,8 @@ struct sk_buff *tcp4_gro_receive(struct list_head *he=
ad, struct sk_buff *skb)
>                 return NULL;
>         }
>

I would probably pull the whole TCP header here, before calling
tcp4_check_fraglist_gro(head, skb)
and no longer do this twice from tcp4_check_fraglist_gro() and tcp_gro_rece=
ive()

Perhaps define a new inline helper, that will be called from
tcp4_gro_receive() and tcp6_gro_receive(),
and not anymore from  tcp_gro_receive()

static inline struct tcphdr *tcp_gro_pull_header(...)
{
     ....
       off =3D skb_gro_offset(skb);
       hlen =3D off + sizeof(*th);
       th =3D skb_gro_header(skb, hlen, off);
       if (unlikely(!th))
               return NULL;

       thlen =3D th->doff * 4;
       if (thlen < sizeof(*th))
               return NULL;

       hlen =3D off + thlen;
       if (!skb_gro_may_pull(skb, hlen))
               th =3D skb_gro_header_slow(skb, hlen, off);

      return th;
}


> +       tcp4_check_fraglist_gro(head, skb);
> +
>         return tcp_gro_receive(head, skb);
>  }
>
> diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
> index c97d55cf036f..7948420dcad0 100644
> --- a/net/ipv6/tcpv6_offload.c
> +++ b/net/ipv6/tcpv6_offload.c
> @@ -7,12 +7,61 @@
>   */
>  #include <linux/indirect_call_wrapper.h>
>  #include <linux/skbuff.h>
> +#include <net/inet6_hashtables.h>
>  #include <net/gro.h>
>  #include <net/protocol.h>
>  #include <net/tcp.h>
>  #include <net/ip6_checksum.h>
>  #include "ip6_offload.h"
>
> +static void tcp6_check_fraglist_gro(struct list_head *head, struct sk_bu=
ff *skb)
> +{
> +#if IS_ENABLED(CONFIG_IPV6)
> +       const struct ipv6hdr *hdr =3D skb_gro_network_header(skb);
> +       struct net *net =3D dev_net(skb->dev);
> +       unsigned int off, hlen, thlen;
> +       struct sk_buff *p;
> +       struct tcphdr *th;
> +       struct sock *sk;
> +       int iif, sdif;
> +
> +       if (!(skb->dev->features & NETIF_F_GRO_FRAGLIST))
> +               return;
> +
> +       off =3D skb_gro_offset(skb);
> +       hlen =3D off + sizeof(*th);
> +       th =3D skb_gro_header(skb, hlen, off);
> +       if (unlikely(!th))
> +               return;
> +
> +       thlen =3D th->doff * 4;
> +       if (thlen < sizeof(*th))
> +               return;
> +
> +       hlen =3D off + thlen;
> +       if (!skb_gro_may_pull(skb, hlen)) {
> +               th =3D skb_gro_header_slow(skb, hlen, off);
> +               if (unlikely(!th))
> +                       return;
> +       }
> +
> +       p =3D tcp_gro_lookup(head, th);
> +       if (p) {
> +               NAPI_GRO_CB(skb)->is_flist =3D NAPI_GRO_CB(p)->is_flist;
> +               return;
> +       }
> +
> +       inet6_get_iif_sdif(skb, &iif, &sdif);
> +       sk =3D __inet6_lookup_established(net, net->ipv4.tcp_death_row.ha=
shinfo,
> +                                       &hdr->saddr, th->source,
> +                                       &hdr->daddr, ntohs(th->dest),
> +                                       iif, sdif);
> +       NAPI_GRO_CB(skb)->is_flist =3D !sk;
> +       if (sk)
> +               sock_put(sk);
> +#endif /* IS_ENABLED(CONFIG_IPV6) */
> +}
> +
>  INDIRECT_CALLABLE_SCOPE
>  struct sk_buff *tcp6_gro_receive(struct list_head *head, struct sk_buff =
*skb)
>  {
> @@ -24,6 +73,8 @@ struct sk_buff *tcp6_gro_receive(struct list_head *head=
, struct sk_buff *skb)
>                 return NULL;
>         }
>
> +       tcp6_check_fraglist_gro(head, skb);
> +
>         return tcp_gro_receive(head, skb);
>  }
>
> --
> 2.44.0
>

