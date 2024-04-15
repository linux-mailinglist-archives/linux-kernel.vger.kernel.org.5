Return-Path: <linux-kernel+bounces-145018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF12B8A4E3C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FFD282229
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5F86A031;
	Mon, 15 Apr 2024 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="UwHe80wt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gnoonKqZ"
Received: from flow4-smtp.messagingengine.com (flow4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3AC66B50;
	Mon, 15 Apr 2024 11:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182283; cv=none; b=CbC+iNtvWZang7VERENXXRhYbhqZZvpKuzPfwk8M74kEbIbr+/YjnTz2rr4sOar6iJzj97IfJpLvsko0Vi95Ml9gD2GTDVm+naMDOr+OavouJqhkPWlqu0cBzLHw9ibqiyWS9JENmXyalndw+NJkSW8yExklGeFPf+Q1gMebiLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182283; c=relaxed/simple;
	bh=js2YN1Qo629boZLbSY3aVwQVI34D4FtKkj4pbWAjcWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCPc5GlYjKe9ZjLiSrqCW1/RkKFQ4g6UukPWed9GTPU22x6Uupp1hmjUVVz1fZSikXEBxffu77uXBB9ZGvves+AzDOnpaBz7L3TqosfYDErgCrLxAZuM1VmS/jM3ezzVN6kMVTO7MwxRTfqIVf5H34n+rQFyP2fHoEeI9yCjZLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=UwHe80wt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gnoonKqZ; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailflow.nyi.internal (Postfix) with ESMTP id 14D9A200308;
	Mon, 15 Apr 2024 07:57:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 15 Apr 2024 07:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1713182279;
	 x=1713185879; bh=fpeIFJt/e4VgY821sioo/9oXpbmdWuQxmoFZkYNqrJ0=; b=
	UwHe80wt/CyBz6Ucar+bkTjPWe/Hb7Q/V52aR5SA7vMjC5LhXO1kCjl3B/sX5ecR
	dAAF6MXDrMAeIaF9ippombXh6e89ZjdW9mWtixPuLGMVKuu4erq5X2OZoxEUlU2w
	+ZrodEh3vgxd3O0ylgp2bkTtRTkYtJDm27TCbAydYpneHK5IadfztxP48r8H0mpg
	ugZsJslR0fcjSMdbfYxR/U2hFY+ZzxLW35RGzPqe17rTR20DJJA6MbipSDuF1c3/
	LcU9sDHhi7QPMyVNdZx8P5L5cIc5KLDaxvr+F5znoPapX4i+A3OymGhNkwh/L5Od
	6E9c9cJRABS1fyNk4qZPTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1713182279; x=
	1713185879; bh=fpeIFJt/e4VgY821sioo/9oXpbmdWuQxmoFZkYNqrJ0=; b=g
	noonKqZaIiFD+XfFjRy7dRmvZSGftzGjobKv/4JhYDt4lh3Lxlviu9NphBCNXe/j
	10Xn6MrHNO9UIZ9lSUxX4wwDJsd2glIqQ+uU7BqbYJY/4lIEtdDcMYg5YnSbdpbL
	Lzk1rw9ZyCCgQ7RU96ap48nEUzJU9951aAnGUocOgnNFYgJznwDZNdWfg9DDYOGn
	4lr0Y0DOxj6umoq3cYiFX46YbsgKxVFdZCV6oxpUyKXoW8mq+HCR9M9Vf/TLhLnu
	Z653l4fHMaru50akucIU8yIaBEMSPhYGxCYHyRof7qgyo6Did9NGgLGR7aOQUn3j
	qgBZXi1XJeuuWpmdVgIvA==
X-ME-Sender: <xms:RhYdZtvONupHr1X1EOMrW7RExqNYHceLYlIosk332v65--JpKiBkjQ>
    <xme:RhYdZmfxCNuiMTecc4xdZ-qU0im8hpOJq66mMP3R5miS9kUKx-jO0hzt1G1VNlKdR
    wY0IxWkT64tliNPdBY>
X-ME-Received: <xmr:RhYdZgyrBSCXBxWSApbHbq6DDvknMtTJYB9ZNWI2xMk8m216tfS-yXaEBSyMSe4-7a66zZw1ndNfB11iVzumLGI3TRI9P3c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejvddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhk
    lhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugdorhgvnh
    gvshgrshesrhgrghhnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeefhfellefh
    ffejgfefudfggeejlefhveehieekhfeulefgtdefueehffdtvdelieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggv
    rhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:RhYdZkMIChbwxyeUCuI9GQf9KJE-Nq_jNwmkyOnAhCLiopfsAapZKA>
    <xmx:RhYdZt96uVkVfrs-uHNthCJu-T0hguyQH1nIKchP8kZ2unmrpfXPKw>
    <xmx:RhYdZkVH2AC3KG0gKCD5EGiMT06_nNDdILfRM2JLCtcy8A44HjEqbQ>
    <xmx:RhYdZufnV6jpMK8lKr0zXWWJ94gOu_BfCAVRZiBkVLD4UnQNV14D7A>
    <xmx:RhYdZmOjPaS_n-Mo8MF0qnBZjGsMToND_YRHNFu2ueQIqmkiHLXCZAhF>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Apr 2024 07:57:57 -0400 (EDT)
Date: Mon, 15 Apr 2024 13:57:55 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC v3 3/7] net: ravb: Refactor RX ring refill
Message-ID: <20240415115755.GH3156415@ragnatech.se>
References: <20240415094804.8016-1-paul.barker.ct@bp.renesas.com>
 <20240415094804.8016-4-paul.barker.ct@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240415094804.8016-4-paul.barker.ct@bp.renesas.com>

Hi Paul,

Thanks for your work, I really like this deduplication of code!

On 2024-04-15 10:48:00 +0100, Paul Barker wrote:
> To reduce code duplication, we add a new RX ring refill function which
> can handle both the initial RX ring population (which was split between
> ravb_ring_init() and ravb_ring_format()) and the RX ring refill after
> polling (in ravb_rx()).
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 141 +++++++++--------------
>  1 file changed, 52 insertions(+), 89 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 1ac599a044b2..baa01bd81f2d 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -317,35 +317,42 @@ static void ravb_ring_free(struct net_device *ndev, int q)
>  	priv->tx_skb[q] = NULL;
>  }
>  
> -static void ravb_rx_ring_format(struct net_device *ndev, int q)
> +static u32
> +ravb_rx_ring_refill(struct net_device *ndev, int q, u32 count, gfp_t gfp_mask)
>  {
>  	struct ravb_private *priv = netdev_priv(ndev);
> +	const struct ravb_hw_info *info = priv->info;
>  	struct ravb_rx_desc *rx_desc;
> -	unsigned int rx_ring_size;
>  	dma_addr_t dma_addr;
> -	unsigned int i;
> +	u32 i, entry;
>  
> -	rx_ring_size = priv->info->rx_desc_size * priv->num_rx_ring[q];
> -	memset(priv->rx_ring[q].raw, 0, rx_ring_size);
> -	/* Build RX ring buffer */
> -	for (i = 0; i < priv->num_rx_ring[q]; i++) {
> -		/* RX descriptor */
> -		rx_desc = ravb_rx_get_desc(priv, q, i);
> -		rx_desc->ds_cc = cpu_to_le16(priv->info->rx_max_desc_use);
> -		dma_addr = dma_map_single(ndev->dev.parent, priv->rx_skb[q][i]->data,
> -					  priv->info->rx_max_frame_size,
> -					  DMA_FROM_DEVICE);
> -		/* We just set the data size to 0 for a failed mapping which
> -		 * should prevent DMA from happening...
> -		 */
> -		if (dma_mapping_error(ndev->dev.parent, dma_addr))
> -			rx_desc->ds_cc = cpu_to_le16(0);
> -		rx_desc->dptr = cpu_to_le32(dma_addr);
> +	for (i = 0; i < count; i++) {
> +		entry = (priv->dirty_rx[q] + i) % priv->num_rx_ring[q];
> +		rx_desc = ravb_rx_get_desc(priv, q, entry);
> +		rx_desc->ds_cc = cpu_to_le16(info->rx_max_desc_use);
> +
> +		if (!priv->rx_skb[q][entry]) {
> +			priv->rx_skb[q][entry] = ravb_alloc_skb(ndev, info, gfp_mask);
> +			if (!priv->rx_skb[q][entry])
> +				break;
> +			dma_addr = dma_map_single(ndev->dev.parent,
> +						  priv->rx_skb[q][entry]->data,
> +						  priv->info->rx_max_frame_size,
> +						  DMA_FROM_DEVICE);
> +			skb_checksum_none_assert(priv->rx_skb[q][entry]);
> +			/* We just set the data size to 0 for a failed mapping
> +			 * which should prevent DMA from happening...
> +			 */
> +			if (dma_mapping_error(ndev->dev.parent, dma_addr))
> +				rx_desc->ds_cc = cpu_to_le16(0);
> +			rx_desc->dptr = cpu_to_le32(dma_addr);
> +		}
> +		/* Descriptor type must be set after all the above writes */
> +		dma_wmb();
>  		rx_desc->die_dt = DT_FEMPTY;
>  	}
> -	rx_desc = ravb_rx_get_desc(priv, q, i);
> -	rx_desc->dptr = cpu_to_le32((u32)priv->rx_desc_dma[q]);
> -	rx_desc->die_dt = DT_LINKFIX; /* type */
> +
> +	return i;
>  }
>  
>  /* Format skb and descriptor buffer for Ethernet AVB */
> @@ -353,6 +360,7 @@ static void ravb_ring_format(struct net_device *ndev, int q)
>  {
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	unsigned int num_tx_desc = priv->num_tx_desc;
> +	struct ravb_rx_desc *rx_desc;
>  	struct ravb_tx_desc *tx_desc;
>  	struct ravb_desc *desc;
>  	unsigned int tx_ring_size = sizeof(*tx_desc) * priv->num_tx_ring[q] *
> @@ -364,8 +372,6 @@ static void ravb_ring_format(struct net_device *ndev, int q)
>  	priv->dirty_rx[q] = 0;
>  	priv->dirty_tx[q] = 0;
>  
> -	ravb_rx_ring_format(ndev, q);
> -
>  	memset(priv->tx_ring[q], 0, tx_ring_size);
>  	/* Build TX ring buffer */
>  	for (i = 0, tx_desc = priv->tx_ring[q]; i < priv->num_tx_ring[q];
> @@ -379,6 +385,14 @@ static void ravb_ring_format(struct net_device *ndev, int q)
>  	tx_desc->dptr = cpu_to_le32((u32)priv->tx_desc_dma[q]);
>  	tx_desc->die_dt = DT_LINKFIX; /* type */
>  
> +	/* Regular RX descriptors have already been initialized by
> +	 * ravb_rx_ring_refill(), we just need to initialize the final link
> +	 * descriptor.
> +	 */
> +	rx_desc = ravb_rx_get_desc(priv, q, priv->num_rx_ring[q]);
> +	rx_desc->dptr = cpu_to_le32((u32)priv->rx_desc_dma[q]);
> +	rx_desc->die_dt = DT_LINKFIX; /* type */
> +

super-nit: Should you not move this addition up to where you removed the 
call to ravb_rx_ring_format()? Before this change the order of things 
are,

    /* Init RX ring */
    /* Init TX ring */
    /* Set RX descriptor base address */
    /* Set TX descriptor base address */


While after it is,

    /* Init TX ring */
    /* Init RX ring */
    /* Set RX descriptor base address */
    /* Set TX descriptor base address */

My OCD is itching ;-)

>  	/* RX descriptor base address for best effort */
>  	desc = &priv->desc_bat[RX_QUEUE_OFFSET + q];
>  	desc->die_dt = DT_LINKFIX; /* type */
> @@ -408,11 +422,9 @@ static void *ravb_alloc_rx_desc(struct net_device *ndev, int q)
>  static int ravb_ring_init(struct net_device *ndev, int q)
>  {
>  	struct ravb_private *priv = netdev_priv(ndev);
> -	const struct ravb_hw_info *info = priv->info;
>  	unsigned int num_tx_desc = priv->num_tx_desc;
>  	unsigned int ring_size;
> -	struct sk_buff *skb;
> -	unsigned int i;
> +	u32 num_filled;
>  
>  	/* Allocate RX and TX skb rings */
>  	priv->rx_skb[q] = kcalloc(priv->num_rx_ring[q],
> @@ -422,13 +434,6 @@ static int ravb_ring_init(struct net_device *ndev, int q)
>  	if (!priv->rx_skb[q] || !priv->tx_skb[q])
>  		goto error;
>  
> -	for (i = 0; i < priv->num_rx_ring[q]; i++) {
> -		skb = ravb_alloc_skb(ndev, info, GFP_KERNEL);
> -		if (!skb)
> -			goto error;
> -		priv->rx_skb[q][i] = skb;
> -	}
> -
>  	if (num_tx_desc > 1) {
>  		/* Allocate rings for the aligned buffers */
>  		priv->tx_align[q] = kmalloc(DPTR_ALIGN * priv->num_tx_ring[q] +
> @@ -443,6 +448,13 @@ static int ravb_ring_init(struct net_device *ndev, int q)
>  
>  	priv->dirty_rx[q] = 0;
>  
> +	/* Populate RX ring buffer. */
> +	ring_size = priv->info->rx_desc_size * priv->num_rx_ring[q];
> +	memset(priv->rx_ring[q].raw, 0, ring_size);
> +	num_filled = ravb_rx_ring_refill(ndev, q, priv->num_rx_ring[q], GFP_KERNEL);
> +	if (num_filled != priv->num_rx_ring[q])
> +		goto error;
> +

Here you also change the order, but it make sense here as you first deal 
with all TX and then all RX ;-)

>  	/* Allocate all TX descriptors. */
>  	ring_size = sizeof(struct ravb_tx_desc) *
>  		    (priv->num_tx_ring[q] * num_tx_desc + 1);
> @@ -762,11 +774,9 @@ static struct sk_buff *ravb_get_skb_gbeth(struct net_device *ndev, int entry,
>  static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
>  {
>  	struct ravb_private *priv = netdev_priv(ndev);
> -	const struct ravb_hw_info *info = priv->info;
>  	struct net_device_stats *stats;
>  	struct ravb_rx_desc *desc;
>  	struct sk_buff *skb;
> -	dma_addr_t dma_addr;
>  	int rx_packets = 0;
>  	u8  desc_status;
>  	u16 desc_len;
> @@ -854,32 +864,9 @@ static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
>  	}
>  
>  	/* Refill the RX ring buffers. */
> -	for (; priv->cur_rx[q] - priv->dirty_rx[q] > 0; priv->dirty_rx[q]++) {
> -		entry = priv->dirty_rx[q] % priv->num_rx_ring[q];
> -		desc = &priv->rx_ring[q].desc[entry];
> -		desc->ds_cc = cpu_to_le16(priv->info->rx_max_desc_use);
> -
> -		if (!priv->rx_skb[q][entry]) {
> -			skb = ravb_alloc_skb(ndev, info, GFP_ATOMIC);
> -			if (!skb)
> -				break;
> -			dma_addr = dma_map_single(ndev->dev.parent,
> -						  skb->data,
> -						  priv->info->rx_max_frame_size,
> -						  DMA_FROM_DEVICE);
> -			skb_checksum_none_assert(skb);
> -			/* We just set the data size to 0 for a failed mapping
> -			 * which should prevent DMA  from happening...
> -			 */
> -			if (dma_mapping_error(ndev->dev.parent, dma_addr))
> -				desc->ds_cc = cpu_to_le16(0);
> -			desc->dptr = cpu_to_le32(dma_addr);
> -			priv->rx_skb[q][entry] = skb;
> -		}
> -		/* Descriptor type must be set after all the above writes */
> -		dma_wmb();
> -		desc->die_dt = DT_FEMPTY;
> -	}
> +	priv->dirty_rx[q] += ravb_rx_ring_refill(ndev, q,
> +						 priv->cur_rx[q] - priv->dirty_rx[q],
> +						 GFP_ATOMIC);
>  
>  	return rx_packets;
>  }
> @@ -888,11 +875,9 @@ static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
>  static int ravb_rx_rcar(struct net_device *ndev, int budget, int q)
>  {
>  	struct ravb_private *priv = netdev_priv(ndev);
> -	const struct ravb_hw_info *info = priv->info;
>  	struct net_device_stats *stats = &priv->stats[q];
>  	struct ravb_ex_rx_desc *desc;
>  	struct sk_buff *skb;
> -	dma_addr_t dma_addr;
>  	struct timespec64 ts;
>  	int rx_packets = 0;
>  	u8  desc_status;
> @@ -964,31 +949,9 @@ static int ravb_rx_rcar(struct net_device *ndev, int budget, int q)
>  	}
>  
>  	/* Refill the RX ring buffers. */
> -	for (; priv->cur_rx[q] - priv->dirty_rx[q] > 0; priv->dirty_rx[q]++) {
> -		entry = priv->dirty_rx[q] % priv->num_rx_ring[q];
> -		desc = &priv->rx_ring[q].ex_desc[entry];
> -		desc->ds_cc = cpu_to_le16(priv->info->rx_max_desc_use);
> -
> -		if (!priv->rx_skb[q][entry]) {
> -			skb = ravb_alloc_skb(ndev, info, GFP_ATOMIC);
> -			if (!skb)
> -				break;	/* Better luck next round. */
> -			dma_addr = dma_map_single(ndev->dev.parent, skb->data,
> -						  priv->info->rx_max_frame_size,
> -						  DMA_FROM_DEVICE);
> -			skb_checksum_none_assert(skb);
> -			/* We just set the data size to 0 for a failed mapping
> -			 * which should prevent DMA  from happening...
> -			 */
> -			if (dma_mapping_error(ndev->dev.parent, dma_addr))
> -				desc->ds_cc = cpu_to_le16(0);
> -			desc->dptr = cpu_to_le32(dma_addr);
> -			priv->rx_skb[q][entry] = skb;
> -		}
> -		/* Descriptor type must be set after all the above writes */
> -		dma_wmb();
> -		desc->die_dt = DT_FEMPTY;
> -	}
> +	priv->dirty_rx[q] += ravb_rx_ring_refill(ndev, q,
> +						 priv->cur_rx[q] - priv->dirty_rx[q],
> +						 GFP_ATOMIC);
>  
>  	return rx_packets;
>  }
> -- 
> 2.39.2
> 

-- 
Kind Regards,
Niklas Söderlund

