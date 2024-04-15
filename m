Return-Path: <linux-kernel+bounces-145067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DA28A4F08
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE982836F7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C4F6CDC5;
	Mon, 15 Apr 2024 12:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="hZtcPUmT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q5g1H2jy"
Received: from flow4-smtp.messagingengine.com (flow4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058981FA1;
	Mon, 15 Apr 2024 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184228; cv=none; b=Fi5zPv0gdXg/9nExNcVJQoa8/8EGc0t0QB/cHDc8MS+wKKLSw0/dM48/3Xifq/3Ojju1p8chNxsjAMwtQc0S/EvYXO6+eIsTNb9hoCfe2pIPtVRm1zP8iHR/MKgJF3WAjeedU6DU1Z3cEwPf+WsbvEmV7geqNpxuf2OBhKt48qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184228; c=relaxed/simple;
	bh=V5KT7TbqjYhhCloJY4FO0tNLNuUkY0Ymu32XeS1Q4Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iP2nGpZjqzy3dEw2EPDdc7wW0dLFIQmE5o6NGu0PToRfUx24hq60WeL9f4/RnHdWnw4EdmyT/wTSV/yyLuneS+X/E5ECNApPVgWU+C0Q8+448yIg6lcu+ZAhsl+VN0O3bkhVfpLQn2+kf0mtBiln1+iq44hv9iKDGMhK3SFLpuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=hZtcPUmT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q5g1H2jy; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailflow.nyi.internal (Postfix) with ESMTP id E94B5200316;
	Mon, 15 Apr 2024 08:30:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 15 Apr 2024 08:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1713184223;
	 x=1713187823; bh=jOTWdAJBYKw6oDV99zOe8caj1/ll24Qdj4BKn1FTGUg=; b=
	hZtcPUmTIWHVH0rx+WMD8Lfln15yVlRdKjdQXflwCnTwbsZ1RzylivD90v7QLHZU
	yDPut+Ia+L3zpPQ9fpM3hRxlwmDw7erYXCa9GGwMKf7rDNcGzNru6coJbFSNpsS0
	8Fo/w7gk1B9W9ZJ1X4ch02NmCWbnVXHYdKP4h6ONmOvPvx+9V1xGjMjz+y23ypVT
	mY9CNrr+mTTHkyf6klGMR8DQo4xM3T+w2qdvGCgEt8GyLqT0OV6stUji3zikFiTB
	7+sA3xafU8w9bBRgx0v7Abx3hR206v6rwdWmiT+aBzolpv3xqJFog8/2S3gSdLGK
	1Sm6oJiuTM9hzShXLE9L1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1713184223; x=
	1713187823; bh=jOTWdAJBYKw6oDV99zOe8caj1/ll24Qdj4BKn1FTGUg=; b=q
	5g1H2jy1Y98kiq9f2pqbsx4ZxyIQp0Oqf98oC+68gZNAKgF/Fs6IdC4/MVFkH0SZ
	3CCUp6bLfRRgBZN0bwgJqUmYdrUPUsdTgJveF1j8cOyM15TzjfwN3WCgaYG86i2w
	mdcZi6pYilE6IUkUrDBuS4wgLyFPLUMBTCYZ3P1RgkwdoIrYllzMNyIb1VxBtnY2
	fTa6pFflPI2tv8nYjnijnnw2Krf/s5sMjpUx+5+MOfUEQC7uAMH+FgFQYHAgPgIU
	6Am2ez33Vwqztad/gSFOpO97GQHOljzlWkPlpKOwrgam4VQe4rrfqNkJzP29S3u+
	AKOR2pLlKDrUgoX2qsjZA==
X-ME-Sender: <xms:3x0dZvqLMiH8VtXhx6dfTQjvPr0Fav-xmbDoMneh-AXNill519_Uiw>
    <xme:3x0dZppRtqosM26RNg1NijBxSLB1plJRiILyaIZWYkIPHSQuobmum234sFjuqEyr3
    UpOMnnd8YeqARfAKbw>
X-ME-Received: <xmr:3x0dZsNySTqBYyiBTKzxpVaXqnPjdz-KgdVVgQidTV4jnY7yC2piwiqRjxvdgDYhETNnRxxowv2tdNS_jicmUwOtor-4VUk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejvddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhk
    lhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugdorhgvnh
    gvshgrshesrhgrghhnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeefhfellefh
    ffejgfefudfggeejlefhveehieekhfeulefgtdefueehffdtvdelieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggv
    rhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:3x0dZi57CPn26OBAisHhtbbun2mnh8m4Lzo_bmEtwtvD1o-uFsuekA>
    <xmx:3x0dZu6K81VC_UApYCItaGOKMt7vt8IJfpn20u_D1D2Xh3_0RkSDFw>
    <xmx:3x0dZqiX0l-QhOTRcMaj-K4L0RdfofpD24Va0DSuv18JrD1fLr-xYA>
    <xmx:3x0dZg4UafJuHEW150CzCNaa33loPiiF8hVm7zI0kyV7xjAW_hfO7A>
    <xmx:3x0dZlZ2H3H9ZJ0gQ6lqnH8WINUGRqpBEdWYucOqmrqufMGHPqiLUdD4>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Apr 2024 08:30:22 -0400 (EDT)
Date: Mon, 15 Apr 2024 14:30:20 +0200
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
Message-ID: <20240415123020.GJ3156415@ragnatech.se>
References: <20240415094804.8016-1-paul.barker.ct@bp.renesas.com>
 <20240415094804.8016-4-paul.barker.ct@bp.renesas.com>
 <20240415115755.GH3156415@ragnatech.se>
 <b1d0ca22-de75-4d76-90ba-62c2a57f4301@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1d0ca22-de75-4d76-90ba-62c2a57f4301@bp.renesas.com>

On 2024-04-15 13:18:08 +0100, Paul Barker wrote:
> On 15/04/2024 12:57, Niklas Söderlund wrote:
> > Hi Paul,
> > 
> > Thanks for your work, I really like this deduplication of code!
> > 
> > On 2024-04-15 10:48:00 +0100, Paul Barker wrote:
> >> To reduce code duplication, we add a new RX ring refill function which
> >> can handle both the initial RX ring population (which was split between
> >> ravb_ring_init() and ravb_ring_format()) and the RX ring refill after
> >> polling (in ravb_rx()).
> >>
> >> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> >> ---
> >>  drivers/net/ethernet/renesas/ravb_main.c | 141 +++++++++--------------
> >>  1 file changed, 52 insertions(+), 89 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> >> index 1ac599a044b2..baa01bd81f2d 100644
> >> --- a/drivers/net/ethernet/renesas/ravb_main.c
> >> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> >> @@ -317,35 +317,42 @@ static void ravb_ring_free(struct net_device *ndev, int q)
> >>  	priv->tx_skb[q] = NULL;
> >>  }
> >>  
> >> -static void ravb_rx_ring_format(struct net_device *ndev, int q)
> >> +static u32
> >> +ravb_rx_ring_refill(struct net_device *ndev, int q, u32 count, gfp_t gfp_mask)
> >>  {
> >>  	struct ravb_private *priv = netdev_priv(ndev);
> >> +	const struct ravb_hw_info *info = priv->info;
> >>  	struct ravb_rx_desc *rx_desc;
> >> -	unsigned int rx_ring_size;
> >>  	dma_addr_t dma_addr;
> >> -	unsigned int i;
> >> +	u32 i, entry;
> >>  
> >> -	rx_ring_size = priv->info->rx_desc_size * priv->num_rx_ring[q];
> >> -	memset(priv->rx_ring[q].raw, 0, rx_ring_size);
> >> -	/* Build RX ring buffer */
> >> -	for (i = 0; i < priv->num_rx_ring[q]; i++) {
> >> -		/* RX descriptor */
> >> -		rx_desc = ravb_rx_get_desc(priv, q, i);
> >> -		rx_desc->ds_cc = cpu_to_le16(priv->info->rx_max_desc_use);
> >> -		dma_addr = dma_map_single(ndev->dev.parent, priv->rx_skb[q][i]->data,
> >> -					  priv->info->rx_max_frame_size,
> >> -					  DMA_FROM_DEVICE);
> >> -		/* We just set the data size to 0 for a failed mapping which
> >> -		 * should prevent DMA from happening...
> >> -		 */
> >> -		if (dma_mapping_error(ndev->dev.parent, dma_addr))
> >> -			rx_desc->ds_cc = cpu_to_le16(0);
> >> -		rx_desc->dptr = cpu_to_le32(dma_addr);
> >> +	for (i = 0; i < count; i++) {
> >> +		entry = (priv->dirty_rx[q] + i) % priv->num_rx_ring[q];
> >> +		rx_desc = ravb_rx_get_desc(priv, q, entry);
> >> +		rx_desc->ds_cc = cpu_to_le16(info->rx_max_desc_use);
> >> +
> >> +		if (!priv->rx_skb[q][entry]) {
> >> +			priv->rx_skb[q][entry] = ravb_alloc_skb(ndev, info, gfp_mask);
> >> +			if (!priv->rx_skb[q][entry])
> >> +				break;
> >> +			dma_addr = dma_map_single(ndev->dev.parent,
> >> +						  priv->rx_skb[q][entry]->data,
> >> +						  priv->info->rx_max_frame_size,
> >> +						  DMA_FROM_DEVICE);
> >> +			skb_checksum_none_assert(priv->rx_skb[q][entry]);
> >> +			/* We just set the data size to 0 for a failed mapping
> >> +			 * which should prevent DMA from happening...
> >> +			 */
> >> +			if (dma_mapping_error(ndev->dev.parent, dma_addr))
> >> +				rx_desc->ds_cc = cpu_to_le16(0);
> >> +			rx_desc->dptr = cpu_to_le32(dma_addr);
> >> +		}
> >> +		/* Descriptor type must be set after all the above writes */
> >> +		dma_wmb();
> >>  		rx_desc->die_dt = DT_FEMPTY;
> >>  	}
> >> -	rx_desc = ravb_rx_get_desc(priv, q, i);
> >> -	rx_desc->dptr = cpu_to_le32((u32)priv->rx_desc_dma[q]);
> >> -	rx_desc->die_dt = DT_LINKFIX; /* type */
> >> +
> >> +	return i;
> >>  }
> >>  
> >>  /* Format skb and descriptor buffer for Ethernet AVB */
> >> @@ -353,6 +360,7 @@ static void ravb_ring_format(struct net_device *ndev, int q)
> >>  {
> >>  	struct ravb_private *priv = netdev_priv(ndev);
> >>  	unsigned int num_tx_desc = priv->num_tx_desc;
> >> +	struct ravb_rx_desc *rx_desc;
> >>  	struct ravb_tx_desc *tx_desc;
> >>  	struct ravb_desc *desc;
> >>  	unsigned int tx_ring_size = sizeof(*tx_desc) * priv->num_tx_ring[q] *
> >> @@ -364,8 +372,6 @@ static void ravb_ring_format(struct net_device *ndev, int q)
> >>  	priv->dirty_rx[q] = 0;
> >>  	priv->dirty_tx[q] = 0;
> >>  
> >> -	ravb_rx_ring_format(ndev, q);
> >> -
> >>  	memset(priv->tx_ring[q], 0, tx_ring_size);
> >>  	/* Build TX ring buffer */
> >>  	for (i = 0, tx_desc = priv->tx_ring[q]; i < priv->num_tx_ring[q];
> >> @@ -379,6 +385,14 @@ static void ravb_ring_format(struct net_device *ndev, int q)
> >>  	tx_desc->dptr = cpu_to_le32((u32)priv->tx_desc_dma[q]);
> >>  	tx_desc->die_dt = DT_LINKFIX; /* type */
> >>  
> >> +	/* Regular RX descriptors have already been initialized by
> >> +	 * ravb_rx_ring_refill(), we just need to initialize the final link
> >> +	 * descriptor.
> >> +	 */
> >> +	rx_desc = ravb_rx_get_desc(priv, q, priv->num_rx_ring[q]);
> >> +	rx_desc->dptr = cpu_to_le32((u32)priv->rx_desc_dma[q]);
> >> +	rx_desc->die_dt = DT_LINKFIX; /* type */
> >> +
> > 
> > super-nit: Should you not move this addition up to where you removed the 
> > call to ravb_rx_ring_format()? Before this change the order of things 
> > are,
> > 
> >     /* Init RX ring */
> >     /* Init TX ring */
> >     /* Set RX descriptor base address */
> >     /* Set TX descriptor base address */
> > 
> > 
> > While after it is,
> > 
> >     /* Init TX ring */
> >     /* Init RX ring */
> >     /* Set RX descriptor base address */
> >     /* Set TX descriptor base address */
> > 
> > My OCD is itching ;-)
> 
> Since I'll need to re-spin this series anyway, I may as well tidy that
> up :)
> 
> > 
> >>  	/* RX descriptor base address for best effort */
> >>  	desc = &priv->desc_bat[RX_QUEUE_OFFSET + q];
> >>  	desc->die_dt = DT_LINKFIX; /* type */
> >> @@ -408,11 +422,9 @@ static void *ravb_alloc_rx_desc(struct net_device *ndev, int q)
> >>  static int ravb_ring_init(struct net_device *ndev, int q)
> >>  {
> >>  	struct ravb_private *priv = netdev_priv(ndev);
> >> -	const struct ravb_hw_info *info = priv->info;
> >>  	unsigned int num_tx_desc = priv->num_tx_desc;
> >>  	unsigned int ring_size;
> >> -	struct sk_buff *skb;
> >> -	unsigned int i;
> >> +	u32 num_filled;
> >>  
> >>  	/* Allocate RX and TX skb rings */
> >>  	priv->rx_skb[q] = kcalloc(priv->num_rx_ring[q],
> >> @@ -422,13 +434,6 @@ static int ravb_ring_init(struct net_device *ndev, int q)
> >>  	if (!priv->rx_skb[q] || !priv->tx_skb[q])
> >>  		goto error;
> >>  
> >> -	for (i = 0; i < priv->num_rx_ring[q]; i++) {
> >> -		skb = ravb_alloc_skb(ndev, info, GFP_KERNEL);
> >> -		if (!skb)
> >> -			goto error;
> >> -		priv->rx_skb[q][i] = skb;
> >> -	}
> >> -
> >>  	if (num_tx_desc > 1) {
> >>  		/* Allocate rings for the aligned buffers */
> >>  		priv->tx_align[q] = kmalloc(DPTR_ALIGN * priv->num_tx_ring[q] +
> >> @@ -443,6 +448,13 @@ static int ravb_ring_init(struct net_device *ndev, int q)
> >>  
> >>  	priv->dirty_rx[q] = 0;
> >>  
> >> +	/* Populate RX ring buffer. */
> >> +	ring_size = priv->info->rx_desc_size * priv->num_rx_ring[q];
> >> +	memset(priv->rx_ring[q].raw, 0, ring_size);
> >> +	num_filled = ravb_rx_ring_refill(ndev, q, priv->num_rx_ring[q], GFP_KERNEL);
> >> +	if (num_filled != priv->num_rx_ring[q])
> >> +		goto error;
> >> +
> > 
> > Here you also change the order, but it make sense here as you first deal 
> > with all TX and then all RX ;-)
> 
> The placement here is because we can't call ravb_rx_ring_refill() until
> priv->dirty_rx[q] has been zero'd.
> 
> The init order right now is actually:
>   RX page pool
>   RX buffers
>   TX SKBs
>   RX descriptors
>   RX ring buffer
>   TX descriptors
> 
> So maybe this should be re-ordered.
> 
> I considered breaking this all apart, so ravb_ring_init() would call
> ravb_rx_ring_init()/ravb_tx_ring_init() and ravb_ring_format() would
> call ravb_rx_ring_format()/ravb_tx_ring_format(). There are several
> steps happening for TX & RX in both init and format stages. Does that
> sound cleaner to you?

I think that is a good idea. If you wish I think this can be done on-top 
or break this first part of the series out to a cleanup set, this series 
is quiet large already.

> 
> Thanks,
> 
> -- 
> Paul Barker






-- 
Kind Regards,
Niklas Söderlund

