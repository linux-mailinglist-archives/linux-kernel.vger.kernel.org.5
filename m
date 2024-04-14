Return-Path: <linux-kernel+bounces-144132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 529298A4233
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8FEF28231D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B003E470;
	Sun, 14 Apr 2024 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="CeSQNMF4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U9WHFLx+"
Received: from wflow2-smtp.messagingengine.com (wflow2-smtp.messagingengine.com [64.147.123.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06A228E11;
	Sun, 14 Apr 2024 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713096535; cv=none; b=L+L+Y6pAaBeNsX3YfeJPTN4dipVvajVZn6K2sauUGcDNXdgSBa+y/XaE329LKbHaF0woREhTjMUVu8AWUaZYVFAR401PAHgj40KzJkZ7msmAL1IzWI92wTCdT08FOGVOPD7ttsm/KftRYi2X+HkPx3Dz2wOBEYBmFhTKScvVvLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713096535; c=relaxed/simple;
	bh=5N4BnsKzj90u66yivCv897XiJyZSNF6/P0ikC49cmXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAJS6wN0HqmPkkT9nrxv0WaJ/ZSeia1NSBDHgZXMkPU94YJWuJJ4nDZcufo779mnvuzTAIxTsztJCtElOjrGs+ZMqTnbkhLHTVoJX7kWGFF9PVWe+afdJZMb3RsKgckt4eNEAq9uwM7oKLS7durvD9Ek0V0Yc43RmX71FhdRaQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=CeSQNMF4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U9WHFLx+; arc=none smtp.client-ip=64.147.123.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailflow.west.internal (Postfix) with ESMTP id AA5C62CC0354;
	Sun, 14 Apr 2024 08:08:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 14 Apr 2024 08:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1713096528;
	 x=1713100128; bh=DnTYqtiqxkdL8TutLD+ycAMOScjACnt4jFDuyfyg2WA=; b=
	CeSQNMF42XN27F44NSY+sfmr5C7BlL4cjSzPU5l6lDPgGXYgtCEqc+SkzTsipiX0
	I4QcK6gwD/MX4KZWGyKzHyIE+/cKI/niEhfS0Jf3QVRup72Y7JZzDgh6I/Gfocdu
	/8cafiAWC5HAuIb/T08tUehBPjcaUrvSRp7IqjTthzChrOAHqOAnlYnuREPL87Dk
	+rHKYyt3qAbH62FIQSdIIlbPfem3vp9JyphxHD7GU1zIxyvJ5Bl2CMquY9m/Nfha
	nIR8KrJ6rANkiP3XNijitosarm8ygHy5Rf9kAYTOV0KBnx6yc0EaNrC/DcavSBDI
	mFsVLRjywPpSYTenKe4Asw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1713096528; x=
	1713100128; bh=DnTYqtiqxkdL8TutLD+ycAMOScjACnt4jFDuyfyg2WA=; b=U
	9WHFLx+BDuI0uQgIsI3FLyQJ2XXI0FnjRHORd94kEuOICiyYid/sHPuGPp4xSbRe
	M39kEwgcf/8L+dbbjzvm5hAKkHuapn04GflmqNRW1nWJp/8CjEQmDsPEaO8GIkqz
	dKce5gfkJkAAAq+/63sPd4tN5v9gZsU19Rr21K/3ExqciPQzmX9N6gcPWhjSpYl7
	C1Uj36t6xsKkI3pHSRUgvixv2Eyjsem+QZvymASXn/hcynaB4nUBDb9JBsO4a+61
	W5csU6yY6on3ovRD+A5aPYxMmrv3AizT7LVEFeAw9KUKd2Mu3eNE2Gmmejo0SmWE
	BQXwpugDAFZashb+XwVuA==
X-ME-Sender: <xms:TscbZjbCiokxQMq68b78guQmg3KjoKZyaN3_I0fko3211zcMVG8C2g>
    <xme:TscbZiZRT2CPZtJ3P3S7xFTYDwhfr6ImD05ryODpKnP9drAc-wX_KHvOMZv4nwtM2
    IX-mHlzvDotey_VRrk>
X-ME-Received: <xmr:TscbZl8JFv9rQi6tkHnIlC2_-GV7a6x88ZnDk99Zzi1sO3FiBi-MucbQbcWUEwwjZCGXDXD9jJLKHN5-KmLz6wsVVvoj5rU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeiledggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhk
    lhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugdorhgvnh
    gvshgrshesrhgrghhnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeefhfellefh
    ffejgfefudfggeejlefhveehieekhfeulefgtdefueehffdtvdelieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggv
    rhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:TscbZprDRLM3y8XedHYqPLqoIN4kCjt0D1uDpzVEa4m0A9d4WJSVHA>
    <xmx:TscbZupoPzbF5DgeXxzB60uosWucsi6O391AVL7-kdh1UJf28DoT2w>
    <xmx:TscbZvSD4DV1M1DK3QRJB2FduAtaXMjjl7V5xVIYLDGkqHj1LmEoYA>
    <xmx:TscbZmr4sla6k0b6jCohP3N8x4COpPILDFrfRXm3pgCzhK_fesU43w>
    <xmx:UMcbZuJwZwpITPaZnANjtHiaBganof7-7V6ceqzUxB5FsZorEWdGuKxj>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Apr 2024 08:08:46 -0400 (EDT)
Date: Sun, 14 Apr 2024 14:08:43 +0200
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
Message-ID: <20240414120843.GA2860391@ragnatech.se>
References: <20240411114434.26186-1-paul.barker.ct@bp.renesas.com>
 <20240411114434.26186-2-paul.barker.ct@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240411114434.26186-2-paul.barker.ct@bp.renesas.com>

Hi Paul,

Thanks for your patch.

On 2024-04-11 12:44:30 +0100, Paul Barker wrote:
> The units of "work done" in the RX path should be packets instead of
> descriptors.
> 
> Descriptors which are used by the hardware to record error conditions or
> are empty in the case of a DMA mapping error should not count towards
> our RX work budget.
> 
> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index ba01c8cc3c90..70f2900648d4 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -892,29 +892,25 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	const struct ravb_hw_info *info = priv->info;
>  	int entry = priv->cur_rx[q] % priv->num_rx_ring[q];
> -	int boguscnt = (priv->dirty_rx[q] + priv->num_rx_ring[q]) -
> -			priv->cur_rx[q];
>  	struct net_device_stats *stats = &priv->stats[q];
>  	struct ravb_ex_rx_desc *desc;
>  	struct sk_buff *skb;
>  	dma_addr_t dma_addr;
>  	struct timespec64 ts;
> +	int rx_packets = 0;
>  	u8  desc_status;
>  	u16 pkt_len;
>  	int limit;
> +	int i;

The loop variable can never be negative, use unsigned int.

>  
> -	boguscnt = min(boguscnt, *quota);
> -	limit = boguscnt;
> +	limit = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
>  	desc = &priv->rx_ring[q].ex_desc[entry];
> -	while (desc->die_dt != DT_FEMPTY) {
> +	for (i = 0; i < limit && rx_packets < *quota && desc->die_dt != DT_FEMPTY; i++) {
>  		/* Descriptor type must be checked before all other reads */
>  		dma_rmb();
>  		desc_status = desc->msc;
>  		pkt_len = le16_to_cpu(desc->ds_cc) & RX_DS;
>  
> -		if (--boguscnt < 0)
> -			break;
> -

nit: It's a matter of taste, but I like this break condition in the code 
instead of modifying the loop as it's much clearer what's going on. But 
feel free to keep it as is as Sergey likes it.

>  		/* We use 0-byte descriptors to mark the DMA mapping errors */
>  		if (!pkt_len)
>  			continue;
> @@ -960,7 +956,7 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
>  			if (ndev->features & NETIF_F_RXCSUM)
>  				ravb_rx_csum(skb);
>  			napi_gro_receive(&priv->napi[q], skb);
> -			stats->rx_packets++;
> +			rx_packets++;

Why do you add this intermediary variable? Is it not confusing to treat 
rx_packets and rx_bytes differently? Why not instead decrement *quota 
here?

>  			stats->rx_bytes += pkt_len;
>  		}
>  
> @@ -995,9 +991,9 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
>  		desc->die_dt = DT_FEMPTY;
>  	}
>  
> -	*quota -= limit - (++boguscnt);
> -
> -	return boguscnt <= 0;
> +	stats->rx_packets += rx_packets;
> +	*quota -= rx_packets;
> +	return *quota == 0;
>  }
>  
>  /* Packet receive function for Ethernet AVB */
> -- 
> 2.39.2
> 

-- 
Kind Regards,
Niklas Söderlund

