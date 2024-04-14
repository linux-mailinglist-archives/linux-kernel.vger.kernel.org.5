Return-Path: <linux-kernel+bounces-144135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C7C8A423E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960951C21086
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764ED40BED;
	Sun, 14 Apr 2024 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="x+Ov1Cp4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ndCiiagD"
Received: from wflow2-smtp.messagingengine.com (wflow2-smtp.messagingengine.com [64.147.123.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E5B1DFFC;
	Sun, 14 Apr 2024 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713097047; cv=none; b=azsiyeXub8BHEVaw1+Vr9rTlD/VXRJHRTaR4i3WmWwfeqRR774D4bVClLkgsulkiKb/44apV8MNSFrnhCBa2iXXBB6MG4jC1ORmqjM+t2Q3AvvfME4TIur3zJhgqO/IONQ+HcV05nDmkJpRJERYhUM0SqEPTJ1sZ5UjgSQg5n/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713097047; c=relaxed/simple;
	bh=wL+WFy4GoNoaKZAqu+EsyXXdksBpg/OLkVQWR8iJ990=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSVqGrrNsyTJeq6HF5VANFQnQQemdB3urbG+CyZs0LdQZ9s+cI9xSy54qaKxpvleOnhj5dW2OKNqbuH/hA37BH1CCSR0k6hbPhK0eU/GrOsMdNel4xFP8F13mfu/5TKFJFnFbnZHPy1MXNodJ3R8M4XbmnynON4JHVmstFEVdrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=x+Ov1Cp4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ndCiiagD; arc=none smtp.client-ip=64.147.123.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailflow.west.internal (Postfix) with ESMTP id 328EB2CC035B;
	Sun, 14 Apr 2024 08:17:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 14 Apr 2024 08:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1713097042;
	 x=1713100642; bh=RKm9SRPHzGh7i5KA9jjXdJiE10zpNkW/BL5dL5EFRys=; b=
	x+Ov1Cp42k3HQVSo+EaeT/zy78QdYE+MK6igj5CVIs5yYSpDXDy5FbMSVPHea/By
	bd4E+LWUKjtHspCLEOTJ2ayqP5PNvMD+5AzPGt8HrgmEf3ycRr6q2W1mIQEpTDAO
	XbhQuw48DgrDkqOyK7glWStjQwbcY7Swc+miNNRc5Ff4vUPV/PlClyXn2i880OWG
	9zKFB+vgnHJv0LAESfiWfwvQw8cXMhqrNLdanOeBRRLNhJ5OkM41QEwml/8q++Zn
	8AuReHTtI+CDXEYZ973NJw/PkO5WPi+jo7ocftSzmQTzT0Zq8UCt+fId5zW0U+V+
	h4xA1QCx7IfpIORgD+ebWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1713097042; x=
	1713100642; bh=RKm9SRPHzGh7i5KA9jjXdJiE10zpNkW/BL5dL5EFRys=; b=n
	dCiiagDN5EOx9qGL3bfjqp17kA+GuPuhjPiNX5etXpXlyXU/sYFhCQI7jyLDtF5O
	SEYk/xjMFqcROpDafJ89rXhz2h7Hd0tsDPWZSaDuMDXeQHQO4XbIIhsRAMgTjb/o
	WsifhYkeMYsr4rrR39ZNiHV46LM2swcqlNDaqYFmCOdBMJaYNpEOEA+BuzKrWdss
	iuaa5nuPzbx/lf+ggFzwD7GSHFCdf/YOvbL04dM31zJW2N39eVhvW7zEvzKVnjq3
	6S4pZsNK7rF0PAG93epIp9HEsiffwHGlGPrUGJBdhTydrIXGSJesjl6b8LNA2NLz
	IV8J3S8IzCsb9ejZ40CKg==
X-ME-Sender: <xms:UckbZhe1QzR-LCoxjICfZwLfcHXj0ejxPoKXJ47We1j0kCyMFvPBDA>
    <xme:UckbZvPgsEDIx7mitUIBw4d2qVVMDpptCsCWiX3lexeRBlGq4w3jxe96SKCHY-wVm
    I0Odjbvhc41dliakQ0>
X-ME-Received: <xmr:UckbZqhxzobyzCE8r3LbWDcHAHCrpmSJ9DVmXMw4tYABAX6pahXOIojPylbknpeh1gH7eRBW9oi00UTL007CujBsaBNcx34>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeiledghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhk
    lhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugdorhgvnh
    gvshgrshesrhgrghhnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeefhfellefh
    ffejgfefudfggeejlefhveehieekhfeulefgtdefueehffdtvdelieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggv
    rhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:UckbZq_Axpu2_jM3Ofax0eRSsfudsovMrrUEDf9nCCjmuGMuXE6gyQ>
    <xmx:UckbZtsIVYTU34Kz2qWXPwU1cdOarnCrzhaj0I1W_kb7irDflZK5cg>
    <xmx:UckbZpEj9FLJZqhD8VTjOE1M-g8xLmeSJ6ZOwbn_dHIjvA9nCs2EvA>
    <xmx:UckbZkP8MKReS6rKtoB0Znki8CAYzsnEg_UGt7Qpd7wprFglOnGFgg>
    <xmx:UskbZu-NMM9lMyqWbOKDDIQQ2TKkNZuoD_4WA9FqPt9MloYMlADQwT2t>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Apr 2024 08:17:21 -0400 (EDT)
Date: Sun, 14 Apr 2024 14:17:19 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/4] net: ravb: Allow RX loop to move past DMA
 mapping errors
Message-ID: <20240414121719.GB2860391@ragnatech.se>
References: <20240411114434.26186-1-paul.barker.ct@bp.renesas.com>
 <20240411114434.26186-3-paul.barker.ct@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240411114434.26186-3-paul.barker.ct@bp.renesas.com>

Hi Paul,

Thanks for your patch.

On 2024-04-11 12:44:31 +0100, Paul Barker wrote:
> The RX loops in ravb_rx_gbeth() and ravb_rx_rcar() skip to the next loop
> interation if a zero-length descriptor is seen (indicating a DMA mapping
> error). However, the current rx descriptor index `priv->cur_rx[q]` was
> incremented at the end of the loop and so would not be incremented when
> we skip to the next loop iteration. This would cause the loop to keep
> seeing the same zero-length descriptor instead of moving on to the next
> descriptor.
> 
> As the loop counter `i` still increments, the loop would eventually
> terminate so there is no risk of being stuck here forever - but we
> should still fix this to avoid wasting cycles.
> 
> To fix this, the rx descriptor index is incremented at the top of the
> loop, in the for statement itself. The assignments of `entry` and `desc`
> are brought into the loop to avoid the need for duplication.
> 
> Fixes: d8b48911fd24 ("ravb: fix ring memory allocation")
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 25 ++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 70f2900648d4..028ab5c6aaf7 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -775,12 +775,15 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
>  	int limit;
>  	int i;
>  
> -	entry = priv->cur_rx[q] % priv->num_rx_ring[q];
>  	limit = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
>  	stats = &priv->stats[q];
>  
> -	desc = &priv->rx_ring[q].desc[entry];
> -	for (i = 0; i < limit && rx_packets < *quota && desc->die_dt != DT_FEMPTY; i++) {
> +	for (i = 0; i < limit && rx_packets < *quota; i++, priv->cur_rx[q]++) {
> +		entry = priv->cur_rx[q] % priv->num_rx_ring[q];
> +		desc = &priv->rx_ring[q].desc[entry];
> +		if (desc->die_dt == DT_FEMPTY)
> +			break;
> +
>  		/* Descriptor type must be checked before all other reads */
>  		dma_rmb();
>  		desc_status = desc->msc;
> @@ -848,9 +851,6 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
>  				break;
>  			}
>  		}
> -
> -		entry = (++priv->cur_rx[q]) % priv->num_rx_ring[q];
> -		desc = &priv->rx_ring[q].desc[entry];
>  	}
>  
>  	/* Refill the RX ring buffers. */
> @@ -891,7 +891,6 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
>  {
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	const struct ravb_hw_info *info = priv->info;
> -	int entry = priv->cur_rx[q] % priv->num_rx_ring[q];
>  	struct net_device_stats *stats = &priv->stats[q];
>  	struct ravb_ex_rx_desc *desc;
>  	struct sk_buff *skb;
> @@ -900,12 +899,17 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
>  	int rx_packets = 0;
>  	u8  desc_status;
>  	u16 pkt_len;
> +	int entry;
>  	int limit;
>  	int i;
>  
>  	limit = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
> -	desc = &priv->rx_ring[q].ex_desc[entry];
> -	for (i = 0; i < limit && rx_packets < *quota && desc->die_dt != DT_FEMPTY; i++) {
> +	for (i = 0; i < limit && rx_packets < *quota; i++, priv->cur_rx[q]++) {
> +		entry = priv->cur_rx[q] % priv->num_rx_ring[q];
> +		desc = &priv->rx_ring[q].ex_desc[entry];
> +		if (desc->die_dt == DT_FEMPTY)
> +			break;

I really like moving the assignment of entry and desc to the top of the 
loop. But I don't like the loop limits as it's hard, at least for me, to 
immediately see what's going on. How about,

    limit = min(priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q], *quota);

    for (i = 0; i < limit; i++) {
        entry = priv->cur_rx[q] % priv->num_rx_ring[q];
        desc = &priv->rx_ring[q].ex_desc[entry];

        /* There are no more valid descriptors after an empty one. */
        if (desc->die_dt == DT_FEMPTY)
                break;

        ...
    }

> +
>  		/* Descriptor type must be checked before all other reads */
>  		dma_rmb();
>  		desc_status = desc->msc;
> @@ -959,9 +963,6 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
>  			rx_packets++;
>  			stats->rx_bytes += pkt_len;
>  		}
> -
> -		entry = (++priv->cur_rx[q]) % priv->num_rx_ring[q];
> -		desc = &priv->rx_ring[q].ex_desc[entry];
>  	}
>  
>  	/* Refill the RX ring buffers. */
> -- 
> 2.39.2
> 

-- 
Kind Regards,
Niklas Söderlund

