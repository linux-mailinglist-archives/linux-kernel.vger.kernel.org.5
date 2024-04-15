Return-Path: <linux-kernel+bounces-144851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0914E8A4BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D6B2820ED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E624B5C1;
	Mon, 15 Apr 2024 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="RGTUJ1Hw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v43Nt5eJ"
Received: from flow2-smtp.messagingengine.com (flow2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10574085D;
	Mon, 15 Apr 2024 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174291; cv=none; b=Sp1atdnJIviMr3Pd7yy401cshGNfD7veDQBKlNC5lmG/fNbGXLjGBYABgZtgd5YkQS2oNm8rN4RN4n8OoKVnKa5Wl6kizcSid9n/2S0+gHLSB0jHlUU/JKDBVIt46ACcW0zSlsqws2SWrNftLzVLZwgJkNs8wfp+L2dypbieGvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174291; c=relaxed/simple;
	bh=4tp9q1Ept89LsDz4D1tlkOlj57eLDlwUkYlDGcreNKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDXgYUX/26Q64b0QIXpAu5HgNMptM4J9XcNiFybIFy1JOeydp4kMx6l4MVQRhstY9tLJ4EPw4iSS3hZan+T0m3QZSNnJUxA8awyqRQzISErcnQ9eEpLZBgSUSCsqauL706Hv7Ikd4FNkTjB5VdDQnK2L4satLJLDh042R3K1nck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=RGTUJ1Hw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v43Nt5eJ; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.nyi.internal (Postfix) with ESMTP id 4DA392002E5;
	Mon, 15 Apr 2024 05:44:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 15 Apr 2024 05:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1713174285;
	 x=1713177885; bh=dGJZqsLu3WRrXgnWfxEZaWnIqgfYmeKMdNrp7kRxwj0=; b=
	RGTUJ1Hwyls0FDBkdGLAmCw0vjTdmyEa83Mp4/kOkXShIPYmqTcLc003kVAyTbDE
	wVGqtLBq+srp2Nomeie52JQ+6MfzGZ8k4/9ffXEzkN+MqiTDzzgVqxLxL8FLYJUN
	nUzUQNSajRI9V2e++mPQ9Crdskzb6ODpkYb30Yuki1WeTKVoF0Qakiz/O7nwpM36
	bsU4nOXiyvT57uZQL5+IufGNSUpMTcnealT4woy2Hi0sbPvQHI6IMFuijqAE+TCA
	bJYY4m7SQD5FXMfNDk0BEfdSfRzlMSqM2XK1aJCTdegnRBKkHazsLo4HlCwL9AUq
	poZXCNQnyOqB1WkDYeNFaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1713174285; x=
	1713177885; bh=dGJZqsLu3WRrXgnWfxEZaWnIqgfYmeKMdNrp7kRxwj0=; b=v
	43Nt5eJ9TP+mOTWmTeh7o2ku0uR/OF7FXI9YF7toELGB+7n0WtJO9YnUNbHj5PTq
	OzR7mGokawa66jJSFWK3uuAlAZKsuOuP90uDRQsvsf+fRtoyWJDdJPSe3Qf63oAy
	MzKBDrtdDh+d4dteKedtdplM+bYIcvWH4TtYWr175YE5nZ1FDqI6BQynUBfJ5Wvy
	duO16PbAn9WpxSgzgqFSlfNr7SO9LzGnhu2qst+zBsPqJyBqQT5qK9QAm1MyTPy1
	7pgxzuls3xFstCf91om3lL5N5JIDNkLwqLEu7KDXDfkHsMNvWz+3PDv7MGNZkjL9
	jnq4rW00OqLNGNgrhRu/w==
X-ME-Sender: <xms:DPccZlivFYi_bMgSruJ-4fb0GjT7ffhoi5w8WEnsh6UvCgGFj213ng>
    <xme:DPccZqDU2qkJcIWz8Dm6T1fcFb1MZ8g5CuGazzUkxVPRXwqE8ERKfLk8JDLt5EyJs
    vJT_NFMV3d5Oz_Udm0>
X-ME-Received: <xmr:DPccZlGgFKiiAuqobCJy52N049Z2pYAC7EZixGDcZLFY2HZMMGYyo7vrqyEuXaBE_KNiUr3iVM-TUjQCunbXvRl2QE-J0Jc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhk
    lhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugdorhgvnh
    gvshgrshesrhgrghhnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeefhfellefh
    ffejgfefudfggeejlefhveehieekhfeulefgtdefueehffdtvdelieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggv
    rhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:DPccZqR0YGauxqkFWNXjcXX_dBOcbteaWYz7U1JgZOQC3j9zThdXPg>
    <xmx:DPccZizGUDtqKc_jki6hlgiRi5eICBNYvetRfNHq7Dc8N2YfXL1nfQ>
    <xmx:DPccZg6F5iwtgdU4qWoZGp_tQUF7B1PWaY4327ElLNKdOnXJKveVQg>
    <xmx:DPccZnzMNnneFjebuRW1gnkrBX-ef9UCto_D9C7qf_I5vyBYGzH5lQ>
    <xmx:DfccZtzGIiFL_KbzqNtkDjadPYoHLs9quFIY6yIiT6ZDt6S2Yxv1iwyR>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Apr 2024 05:44:43 -0400 (EDT)
Date: Mon, 15 Apr 2024 11:44:40 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/4] net: ravb: Count packets instead of descriptors
 in R-Car RX path
Message-ID: <20240415094440.GB3156415@ragnatech.se>
References: <20240411114434.26186-1-paul.barker.ct@bp.renesas.com>
 <20240411114434.26186-2-paul.barker.ct@bp.renesas.com>
 <20240414120843.GA2860391@ragnatech.se>
 <e3e3c75f-9aee-40b6-b5b8-08260a8bac06@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3e3c75f-9aee-40b6-b5b8-08260a8bac06@bp.renesas.com>

Hi Paul,

On 2024-04-15 08:04:05 +0100, Paul Barker wrote:
> On 14/04/2024 13:08, Niklas Söderlund wrote:
> > Hi Paul,
> > 
> > Thanks for your patch.
> > 
> > On 2024-04-11 12:44:30 +0100, Paul Barker wrote:
> >> The units of "work done" in the RX path should be packets instead of
> >> descriptors.
> >>
> >> Descriptors which are used by the hardware to record error conditions or
> >> are empty in the case of a DMA mapping error should not count towards
> >> our RX work budget.
> >>
> >> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> >> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> >> ---
> >>  drivers/net/ethernet/renesas/ravb_main.c | 20 ++++++++------------
> >>  1 file changed, 8 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> >> index ba01c8cc3c90..70f2900648d4 100644
> >> --- a/drivers/net/ethernet/renesas/ravb_main.c
> >> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> >> @@ -892,29 +892,25 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
> >>  	struct ravb_private *priv = netdev_priv(ndev);
> >>  	const struct ravb_hw_info *info = priv->info;
> >>  	int entry = priv->cur_rx[q] % priv->num_rx_ring[q];
> >> -	int boguscnt = (priv->dirty_rx[q] + priv->num_rx_ring[q]) -
> >> -			priv->cur_rx[q];
> >>  	struct net_device_stats *stats = &priv->stats[q];
> >>  	struct ravb_ex_rx_desc *desc;
> >>  	struct sk_buff *skb;
> >>  	dma_addr_t dma_addr;
> >>  	struct timespec64 ts;
> >> +	int rx_packets = 0;
> >>  	u8  desc_status;
> >>  	u16 pkt_len;
> >>  	int limit;
> >> +	int i;
> > 
> > The loop variable can never be negative, use unsigned int.
> 
> I matched the type we're comparing against - should we also convert
> limit to an unsigned int?

If it can't be negative I think that is a good idea.

> 
> > 
> >>  
> >> -	boguscnt = min(boguscnt, *quota);
> >> -	limit = boguscnt;
> >> +	limit = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
> >>  	desc = &priv->rx_ring[q].ex_desc[entry];
> >> -	while (desc->die_dt != DT_FEMPTY) {
> >> +	for (i = 0; i < limit && rx_packets < *quota && desc->die_dt != DT_FEMPTY; i++) {
> >>  		/* Descriptor type must be checked before all other reads */
> >>  		dma_rmb();
> >>  		desc_status = desc->msc;
> >>  		pkt_len = le16_to_cpu(desc->ds_cc) & RX_DS;
> >>  
> >> -		if (--boguscnt < 0)
> >> -			break;
> >> -
> > 
> > nit: It's a matter of taste, but I like this break condition in the code 
> > instead of modifying the loop as it's much clearer what's going on. But 
> > feel free to keep it as is as Sergey likes it.
> > 
> >>  		/* We use 0-byte descriptors to mark the DMA mapping errors */
> >>  		if (!pkt_len)
> >>  			continue;
> >> @@ -960,7 +956,7 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
> >>  			if (ndev->features & NETIF_F_RXCSUM)
> >>  				ravb_rx_csum(skb);
> >>  			napi_gro_receive(&priv->napi[q], skb);
> >> -			stats->rx_packets++;
> >> +			rx_packets++;
> > 
> > Why do you add this intermediary variable? Is it not confusing to treat 
> > rx_packets and rx_bytes differently? Why not instead decrement *quota 
> > here?
> 
> To me, it's simpler to count received packets once instead of twice
> inside the loop (once by incrementing stats->rx_packets, a second time
> by decrementing *quota). This also makes future refactoring simpler as
> we already have the rx_packets count which we will need to be able to
> return so that we can properly track work done in ravb_poll().

I see your point, I think my point was made with the R-Car code path in 
mind as it do not yet support splitting a packet over multiple 
descriptors. And I agree there is value in trying to keep the two code 
paths as close together as possible so we eventually can merge them.

With the unsigned issue above fixed,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> 
> Thanks,
> 
> -- 
> Paul Barker






-- 
Kind Regards,
Niklas Söderlund

