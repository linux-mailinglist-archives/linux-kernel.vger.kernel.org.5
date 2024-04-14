Return-Path: <linux-kernel+bounces-144136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 429418A4241
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27E92821E4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9563E48F;
	Sun, 14 Apr 2024 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="Fv6Nn/Ox";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FRk0Ueop"
Received: from wflow2-smtp.messagingengine.com (wflow2-smtp.messagingengine.com [64.147.123.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387EC1E53F;
	Sun, 14 Apr 2024 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713097290; cv=none; b=QsW34TQWP7KQHedalrsY2mpLI0YSG3IjlNktS+j+PS9nFv7RReO0J0FNGNuEDz1sccnX+r5+hU1urRJlznE8pnV9pKwgZ676Wo5XoVpAsPtf5YRzpY5aNlFF2cmP8gzcHsB7QXtLrtFU5J8QsnlGJZHDAd7GwQEMOHfSximuhG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713097290; c=relaxed/simple;
	bh=eiHSzsxeuqiDLvRiYUbJcrgheNfEAU8yTQK2+tcSELg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4AwtVRwy6G6mEo65OY8fWKtDuT/JfbiLeXSanOoWd5WZyDBmImeoenseM3spfSVAd1joBW0IUogbyxLsCDaWS6QHAXVYq52Z+AbWJsizdhJ9jAcRWvaluKgVy8skFJJk2FAvA7eP0cCcrowDIRb35zQw0RTUAr/JkrsXOnXTzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=Fv6Nn/Ox; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FRk0Ueop; arc=none smtp.client-ip=64.147.123.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailflow.west.internal (Postfix) with ESMTP id 4D3D42CC027A;
	Sun, 14 Apr 2024 08:21:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 14 Apr 2024 08:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1713097285;
	 x=1713100885; bh=iqTbHey5ppwfwHNXIVUS9WfeIhrEiC0Li38QsxFjfPI=; b=
	Fv6Nn/OxprVLfCfgZzxQzBQ89Jk3xexHvPmmFGO7OuU4zoVN/e3v7RsPm1e/wzLY
	5UrHWE3VwUEOP0BcZ68GSTqtNBBXY7IsdndJadq+cU4mwWCaTPKO9CKCoJM11jQ2
	njCgH8kX/lXzAmTbnBXnHKxf8umS+HouFGDv54X03xME710TNe/sHSADBGTHIcDA
	R4LFJVprNMle8ZqJgmQdYCQkf/eIw/S1VXI9VFEcPplt/FOL+ZGr0HMM5e+CNrr4
	SuAFe/ziJIrsbVhWrgBW1mEFINlXSaMP3GWmtPnpR3RkZnBuCV+GPMde/vwAUGNT
	iHb8dBGUtmBrwszl1W6bAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1713097285; x=
	1713100885; bh=iqTbHey5ppwfwHNXIVUS9WfeIhrEiC0Li38QsxFjfPI=; b=F
	Rk0Ueopy2TlwSF3m3Ev78jdTEs7+009y4DQWBzWkvuvm637G3NX2VSQZGtx3SKca
	S6wI3Id5SiqNTVRLxLlzhR8N6YwfKcN2aUFncH5h34FRPrr8q24Ac6VhU5GumbLe
	Y3Itvsf5ElwGdU/jyfbZMpNxu5WL63pJKTAVIf1wpYgLleEvrItxhlLh6357sFCp
	aBTv4KwguH8oYmf+luc5lsPvGMpvB3Omed1aSnFTipe47ASpaL16x7YFPIA+O2np
	r5q1UUiZnDiybDpXJRoq0TPCEMoBVqZtDq82T1UF2cTi6M19KAyJpHvFOSbQA5NC
	KEicoPdB+AmsPxPF4yzUg==
X-ME-Sender: <xms:RcobZp7YcFvpesQ52lNV9kca8kw6M-Sc-1Fz5BcKBTNFlB_umqzIbg>
    <xme:RcobZm5LSE8VIEh8QyiRZQ0UaS3vvXlCPHQrnFMSio9NtLiZC_EbeMZr4KhaxaeKQ
    HqDbLUDoHyYGcGq1bE>
X-ME-Received: <xmr:RcobZgdKVZpBY0itGokHNqrbaU4XoFyFhg5YSTo_IGIqt3uDIfikWj-kVqbdZxYxoLvEdrWJmDh6BirYBY_y2bAl8YpRxlI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeiledghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhk
    lhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugdorhgvnh
    gvshgrshesrhgrghhnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeefhfellefh
    ffejgfefudfggeejlefhveehieekhfeulefgtdefueehffdtvdelieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggv
    rhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:RcobZiI7KuxWIY23MzHxBNUPSXTYesc0jmNZH3CuyxPZQdVw5YPnBQ>
    <xmx:RcobZtJ9t7o1NQRhNdBHWdFyezsBXC-z6FE3FuC5wWN3nItSTygV4g>
    <xmx:RcobZrzaqfXlu9Ysr4tgojjFMXfodh2mXkIjAT5f8F6vq0EJ9CRb4Q>
    <xmx:RcobZpKbxFPT672HK6533JwYl4E3dhpWWAuttH_urzKU5Zy_dey90A>
    <xmx:RcobZmVorPOJNuxVLJ9E_70n3p5asYD8qRWvrDpRZUG5WC-LTefH4I5t>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Apr 2024 08:21:24 -0400 (EDT)
Date: Sun, 14 Apr 2024 14:21:23 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	YueHaibing <yuehaibing@huawei.com>, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net PATCH v2 1/4] net: ravb: Count packets instead of
 descriptors in R-Car RX path
Message-ID: <20240414122123.GC2860391@ragnatech.se>
References: <20240412100024.2296-1-paul.barker.ct@bp.renesas.com>
 <20240412100024.2296-2-paul.barker.ct@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240412100024.2296-2-paul.barker.ct@bp.renesas.com>

Hi Paul,

Sorry I just posted my review comments on v1 of this series instead of 
v2. They where intended and are still valid for v2, sorry for the noise, 
let me know if you want me to repost them here.

On 2024-04-12 11:00:21 +0100, Paul Barker wrote:
> The units of "work done" in the RX path should be packets instead of
> descriptors.
> 
> Descriptors which are used by the hardware to record error conditions or
> are empty in the case of a DMA mapping error should not count towards
> our RX work budget.
> 
> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
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
>  		/* We use 0-byte descriptors to mark the DMA mapping errors */
>  		if (!pkt_len)
>  			continue;
> @@ -960,7 +956,7 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
>  			if (ndev->features & NETIF_F_RXCSUM)
>  				ravb_rx_csum(skb);
>  			napi_gro_receive(&priv->napi[q], skb);
> -			stats->rx_packets++;
> +			rx_packets++;
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

