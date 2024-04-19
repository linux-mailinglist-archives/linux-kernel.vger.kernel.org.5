Return-Path: <linux-kernel+bounces-151884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C25D48AB53F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D754282DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB8B130A5B;
	Fri, 19 Apr 2024 18:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixjqi4Qa"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEEFD268;
	Fri, 19 Apr 2024 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713552708; cv=none; b=HKEAxSZqEzFr50oR1D054zxjRWNnZ21wZka5+pv4iCc7mrmmQkphcDW0LyhjT+oFgOUQFdClAstbka7gvJWJ+7d3OjFt7JE8XjnPgumtzGRehZRfgnRftlaV5kXxTrmBBf2AEJk5mkfcIwADhieWV2qFoggSvOqCm+8A3xOvd3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713552708; c=relaxed/simple;
	bh=4d3Fypo2168+K4PgyttFdkSeL+sh2a96uVhh00RSqm0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=C536sNm3wFwrLiJToDh5WB5kWeiOAgcg5c9ow6Up3dAEVhp0RTRK+marOcFjLedGyHXWPh3o8+29VtUJ7bnd6GjkNbm3CoHdyoZt6vXn5Bu3dTV+YUUTRvjsEvY0nU96nTciAd0NDv6BNjT/pCm5L+czAAnHak7vjfpkK/wHomM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixjqi4Qa; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c749aa444fso547160b6e.0;
        Fri, 19 Apr 2024 11:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713552706; x=1714157506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27V+Y2NeTgAE7ep+KT2Y25Y98TvpuDuQH3tXtyb2m4U=;
        b=ixjqi4Qaxc90GeFgjzjo0WV95B7T1dYT/nV43hktPvrNnVJjzLREm64Pzm5W3/Gg6x
         CsJSCJZUWqQKKWpsJ/A+IshmGtVnCw940+YFUMkMnISBmXU7KcnUq9O4LqNRm1Pmf0Qd
         96WvDTt7xfBWPjAuGw9J5Ihjj8pZP4qRrtSL4M4C6lTTuIzihv2vXwhuy1XeA19Cf8iO
         Ychsn0ezTw1JSxdKk/mJpWvLWwa2nyw9NF16srVUmw2qZBMZ9FMxmcdJ0zabnwxkQ0tw
         KaRrbGAGsB2vRBcZJMBqHboCc1HbvWnxHwYJtTsfaAqpI0i4zK594T8p4loOQz3oE8hq
         Y7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713552706; x=1714157506;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=27V+Y2NeTgAE7ep+KT2Y25Y98TvpuDuQH3tXtyb2m4U=;
        b=EVatG7PWTRL60Srg7pP9DSnDgLD6Rrj2W8i1JZXH8/+S0G2wyenG6RbVQcyQp1yONx
         xjeOO5c0kFtlecgdwmF2KqcevpmcH36BSETckkRqrKtVma0NGEABtmiJVSncjs7MP3as
         QX6zkFTTuqYJtFYf3VbYVBKyscW4q1hJKBbGuoqQnpWdo7V3GM5MFk5vJ/wdewyHugoL
         nKOXHOlVk/S/Sgdjmb+RZrSJC/LMwbHpHHNuR8SYEIW4Ra1+/sZ3S+i1+udlaK0BVNnF
         Kcu/MzL14fwjCw/c/nHlKYu7m5WwGFJ6dCOdDoCzaTMQK1fZacf/+krjvUkvZaFawwXi
         QXIw==
X-Forwarded-Encrypted: i=1; AJvYcCU5uoBcNNPNLibIjH48Tk+2aNSIztjZmDrb+18RovG+CrHEHmtpCEWCqh4ZNL6V2Yqc1jPiyG2bVybFEutu+oyAI0KOe2wqTUQqRB7tG446fDj12X1gJlypgdZyinkoMjYGbrju
X-Gm-Message-State: AOJu0Ywo5GADr8dFt0hcVOiuXy6Beha086g1hpwYwR02c/zYLGp8enmj
	mOZPQotYFQDCcN/0umdoCjfCcTX/nR+RKeAL6pWuXwIQwTshG/VS
X-Google-Smtp-Source: AGHT+IHO3f0byTLQNe/UFWR5ukG0/WNovdAwWOEPjc1iftTSZkiF1WXk2kUQNeG3TYzTM2Y/5Sk70A==
X-Received: by 2002:a05:6808:140d:b0:3c7:28a9:2775 with SMTP id w13-20020a056808140d00b003c728a92775mr3730653oiv.11.1713552706022;
        Fri, 19 Apr 2024 11:51:46 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id b6-20020ac812c6000000b0043769a2d3d3sm1804782qtj.78.2024.04.19.11.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 11:51:45 -0700 (PDT)
Date: Fri, 19 Apr 2024 14:51:45 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 alexander.duyck@gmail.com, 
 aleksander.lobakin@intel.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Message-ID: <6622bd416e567_1241e229425@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240419153542.121087-2-richardbgobert@gmail.com>
References: <20240419153542.121087-1-richardbgobert@gmail.com>
 <20240419153542.121087-2-richardbgobert@gmail.com>
Subject: Re: [PATCH net v2 1/3] net: gro: add {inner_}network_offset to
 napi_gro_cb
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
> This patch adds network_offset and inner_network_offset to napi_gro_cb, and
> makes sure both are set correctly. In the common path there's only one
> write (skb_gro_reset_offset, which replaces skb_set_network_header).
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  drivers/net/geneve.c           |  1 +
>  drivers/net/vxlan/vxlan_core.c |  1 +
>  include/net/gro.h              | 18 ++++++++++++++++--
>  net/8021q/vlan_core.c          |  2 ++
>  net/core/gro.c                 |  1 +
>  net/ethernet/eth.c             |  1 +
>  net/ipv4/af_inet.c             |  5 +----
>  net/ipv4/gre_offload.c         |  1 +
>  net/ipv6/ip6_offload.c         |  8 ++++----
>  9 files changed, 28 insertions(+), 10 deletions(-)
> 

> +static inline int skb_gro_network_offset(const struct sk_buff *skb)
> +{
> +	return NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark];
> +}
> +


> @@ -236,8 +236,6 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
>  	if (unlikely(!iph))
>  		goto out;
>  
> -	skb_set_network_header(skb, off);
> -

Especially for net, this is still a large patch.

Can we avoid touching all those tunnel callbacks and just set the
offsets in inet_gro_receive and ipv6_gro_receive themselves, just
as skb_set_network_header now:

@@ -236,7 +236,7 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
        if (unlikely(!iph))
                goto out;
 
-       skb_set_network_header(skb, off);
+       NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark] = off;


