Return-Path: <linux-kernel+bounces-144867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CE28A4BFB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C73C288758
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1255C47F4B;
	Mon, 15 Apr 2024 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="MUNJzigI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E9hu7Xy/"
Received: from flow3-smtp.messagingengine.com (flow3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF442E83C;
	Mon, 15 Apr 2024 09:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174733; cv=none; b=Y4sz5vFfmkcgkNlEwdxmopIZgu21/yPXynUnmZ/FBj7eAayj8knH7HRvphU//GzYwlpRHtcM+Okq6Le5N/AZE9oI8FtIR7wht5r6qyRAsNXIh8A4ChsTKoevcFOMW11So7lueZaARGqKd+fHB+WIZTEZYXpxRgZ61lJYKFZ/WLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174733; c=relaxed/simple;
	bh=oHcDlWacJdd41JCL7bBkWYNUvg65SHhnzawOVXwtWVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogBiIgsUpa2vUrqMCmdjM+IGl2YgbNd7omE7b4UOEkWpElX1kBOTKVc+f2UKQ0uc0Grpd4O+2n7eFpTKBjX4tPHPp50YNdxkUmDCCQH5slrqT60srPWYzey1ny+M7q6FaEQNigpQC0p3t1k1mFWBOX1aImm6WeQALfm5B2DY4G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=MUNJzigI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E9hu7Xy/; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailflow.nyi.internal (Postfix) with ESMTP id 2653B2001FE;
	Mon, 15 Apr 2024 05:52:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 15 Apr 2024 05:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1713174730;
	 x=1713178330; bh=+8dbvCExmPdtoLeXoUWojJSeKEGIybbQ6EUqQPt499o=; b=
	MUNJzigIgM8Q8N+Y8dVv94ELKPqBHo/16IgWijBJeY2XRSSK62z7scsfIT7BtvZq
	eWC3XrXmMKBjoAe1H1UBlEci3ncxBCQu1I/j5aTbM8ITT7U3HP2YYrvyAQJsknBk
	Pe1K8C+1gR9VD0MkCsBOOTmpEJ5oKbWFw3ITJ9/ns85O1W9tFw1Deibz4bZ3L0zu
	yrsbiQRaBz40wREQ7g0KWlJz7LyWjVKd0dLdiWyz1nMqqlOd4Wd316amKy6Tfwy5
	JuFpDb5yt13SC8JLTP+vQZ69YPyuHe7Th6LbKrjJhVtPDxoF6ezWi+MYPuklrwgt
	2GENDLUBJsm7lGfCFwYqJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1713174730; x=
	1713178330; bh=+8dbvCExmPdtoLeXoUWojJSeKEGIybbQ6EUqQPt499o=; b=E
	9hu7Xy/MJDAywL3195z6XEOBxQ64rfMN76FoqU2RuraVeE49ECkljTaVN7YZPlb8
	sdUF7h12wZ/DguiLNSlY6Avl6X3pjp/yUJWxBBNibHEgUJW0GRxTBybpsM+kw6HJ
	o/HEJ4wqkdOCtvadQWuS0AWqtxKZ/a9f7MeWnfhlvhVyZqGqSIuvCN0dG6XfWkvU
	CsNxHEv6vOozYgEepLkU7WNYcACV0VAV2in8G2j58qL9x3FvX2VmLGyuVfPKKgBk
	hwPRqtwbl0WKQhiP0/WSEufPDjtKOLduemlPexKi4Q6EFsJMw/qJYpLvAVemsmjW
	DItkW8Fou+Ugy8MPlRqoQ==
X-ME-Sender: <xms:yfgcZmtnRDDM66rLjpmwt-VStVgJt0zhGfK9TPx5M8d9YsHQuLRH_Q>
    <xme:yfgcZrdGpGpW0dyQX8IBENwJEz6Z7RKJrAfPC99K7UzPCy12zh3KbRgpaGKsO_eXT
    5npNGubV2OfmhxxOPk>
X-ME-Received: <xmr:yfgcZhzejtkVwsDwL-lC2-g7h-RW8BIGzH0tUsJehrmlU5yL7AZ4MJWnu6BTHXjM5sXiqdttX3JNXeOh5Hak4JSiYnwvFEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejvddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhk
    lhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugdorhgvnh
    gvshgrshesrhgrghhnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeefhfellefh
    ffejgfefudfggeejlefhveehieekhfeulefgtdefueehffdtvdelieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggv
    rhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:yfgcZhMmFUyCp6qJ1Moq6HsbVGNZwVjJqIzaVR3C773D_kuQg6WlRg>
    <xmx:yfgcZm8M_jSlLiiKdsf0yEtrqmG_gPJUhpSsJ1wTIYai5zYOsmgDyg>
    <xmx:yfgcZpWhkQj_CPdtkuOgXYqIwS_XqVSZtJHA4iHUvUqb4z0KY8QCCQ>
    <xmx:yfgcZvc7JxuQY-jnkFJUH6GC1V518e0kwA8rh_w_IDQa31dsHEJSpw>
    <xmx:yfgcZrPsmPknKOWLbYDhEjn0C11QyUN_DJv9ld8Gbfq3k2tKNyA2nqwN>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Apr 2024 05:52:09 -0400 (EDT)
Date: Mon, 15 Apr 2024 11:52:06 +0200
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
Message-ID: <20240415095206.GC3156415@ragnatech.se>
References: <20240411114434.26186-1-paul.barker.ct@bp.renesas.com>
 <20240411114434.26186-3-paul.barker.ct@bp.renesas.com>
 <20240414121719.GB2860391@ragnatech.se>
 <d1ec92db-eefe-465a-9eb5-3a57c22b86c3@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1ec92db-eefe-465a-9eb5-3a57c22b86c3@bp.renesas.com>

Hello Paul,

On 2024-04-15 08:12:06 +0100, Paul Barker wrote:
> On 14/04/2024 13:17, Niklas Söderlund wrote:
> > Hi Paul,
> > 
> > Thanks for your patch.
> > 
> > On 2024-04-11 12:44:31 +0100, Paul Barker wrote:
> >> The RX loops in ravb_rx_gbeth() and ravb_rx_rcar() skip to the next loop
> >> interation if a zero-length descriptor is seen (indicating a DMA mapping
> >> error). However, the current rx descriptor index `priv->cur_rx[q]` was
> >> incremented at the end of the loop and so would not be incremented when
> >> we skip to the next loop iteration. This would cause the loop to keep
> >> seeing the same zero-length descriptor instead of moving on to the next
> >> descriptor.
> >>
> >> As the loop counter `i` still increments, the loop would eventually
> >> terminate so there is no risk of being stuck here forever - but we
> >> should still fix this to avoid wasting cycles.
> >>
> >> To fix this, the rx descriptor index is incremented at the top of the
> >> loop, in the for statement itself. The assignments of `entry` and `desc`
> >> are brought into the loop to avoid the need for duplication.
> >>
> >> Fixes: d8b48911fd24 ("ravb: fix ring memory allocation")
> >> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> >> ---
> >>  drivers/net/ethernet/renesas/ravb_main.c | 25 ++++++++++++------------
> >>  1 file changed, 13 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> >> index 70f2900648d4..028ab5c6aaf7 100644
> >> --- a/drivers/net/ethernet/renesas/ravb_main.c
> >> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> >> @@ -775,12 +775,15 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
> >>  	int limit;
> >>  	int i;
> >>  
> >> -	entry = priv->cur_rx[q] % priv->num_rx_ring[q];
> >>  	limit = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
> >>  	stats = &priv->stats[q];
> >>  
> >> -	desc = &priv->rx_ring[q].desc[entry];
> >> -	for (i = 0; i < limit && rx_packets < *quota && desc->die_dt != DT_FEMPTY; i++) {
> >> +	for (i = 0; i < limit && rx_packets < *quota; i++, priv->cur_rx[q]++) {
> >> +		entry = priv->cur_rx[q] % priv->num_rx_ring[q];
> >> +		desc = &priv->rx_ring[q].desc[entry];
> >> +		if (desc->die_dt == DT_FEMPTY)
> >> +			break;
> >> +
> >>  		/* Descriptor type must be checked before all other reads */
> >>  		dma_rmb();
> >>  		desc_status = desc->msc;
> >> @@ -848,9 +851,6 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
> >>  				break;
> >>  			}
> >>  		}
> >> -
> >> -		entry = (++priv->cur_rx[q]) % priv->num_rx_ring[q];
> >> -		desc = &priv->rx_ring[q].desc[entry];
> >>  	}
> >>  
> >>  	/* Refill the RX ring buffers. */
> >> @@ -891,7 +891,6 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
> >>  {
> >>  	struct ravb_private *priv = netdev_priv(ndev);
> >>  	const struct ravb_hw_info *info = priv->info;
> >> -	int entry = priv->cur_rx[q] % priv->num_rx_ring[q];
> >>  	struct net_device_stats *stats = &priv->stats[q];
> >>  	struct ravb_ex_rx_desc *desc;
> >>  	struct sk_buff *skb;
> >> @@ -900,12 +899,17 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
> >>  	int rx_packets = 0;
> >>  	u8  desc_status;
> >>  	u16 pkt_len;
> >> +	int entry;
> >>  	int limit;
> >>  	int i;
> >>  
> >>  	limit = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
> >> -	desc = &priv->rx_ring[q].ex_desc[entry];
> >> -	for (i = 0; i < limit && rx_packets < *quota && desc->die_dt != DT_FEMPTY; i++) {
> >> +	for (i = 0; i < limit && rx_packets < *quota; i++, priv->cur_rx[q]++) {
> >> +		entry = priv->cur_rx[q] % priv->num_rx_ring[q];
> >> +		desc = &priv->rx_ring[q].ex_desc[entry];
> >> +		if (desc->die_dt == DT_FEMPTY)
> >> +			break;
> > 
> > I really like moving the assignment of entry and desc to the top of the 
> > loop. But I don't like the loop limits as it's hard, at least for me, to 
> > immediately see what's going on. How about,
> > 
> >     limit = min(priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q], *quota);
> > 
> >     for (i = 0; i < limit; i++) {
> >         entry = priv->cur_rx[q] % priv->num_rx_ring[q];
> >         desc = &priv->rx_ring[q].ex_desc[entry];
> > 
> >         /* There are no more valid descriptors after an empty one. */
> >         if (desc->die_dt == DT_FEMPTY)
> >                 break;
> > 
> >         ...
> >     }
> 
> We need to count received packets separately from the number of
> descriptors processed, as done in the previous commit in this series,
> so we can't just have a single check against limit.

As noted in 1/4 I was only considering the R-Car code path where split 
descriptors are not supported. I agree it's good to keep the two code 
paths in sync and with that in mind I'm OK with this approach.

> 
> We also need to increment priv->cur_rx[q]. If we put `priv->cur_rx[q]++`
> at the end of the loop then we're back to having to worry about it when
> we have a continue statement.
> 
> We could move the `rx_packets < *quota` check inside the loop itself,
> but I don't see that as any clearer myself.

I do think this is a good idea however. As this would split the logic in 
two distinct sets. The loop would only deal with descriptors and the 
stop conditions based on number of packets / work done would be a stop
condition inside the loop.

Thinking a head a bit I think it would be nice if in future the private 
data variable rx_1st_skb could be reworked as this will not play nice 
with multiple queues. And with a split of the loop to only consider 
descriptors we could try and look a head and only process a packet if 
all descriptors for it are available to us. Lets cross that bridge when 
we get to it. But I think having the loop only consider descriptors 
would make this easier.

> 
> Thanks,
> 
> -- 
> Paul Barker






-- 
Kind Regards,
Niklas Söderlund

