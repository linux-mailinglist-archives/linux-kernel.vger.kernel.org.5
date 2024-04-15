Return-Path: <linux-kernel+bounces-144983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58ED8A4D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F5CD285289
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5375FBB2;
	Mon, 15 Apr 2024 11:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="WyK5RMxR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I/sEnOHj"
Received: from flow3-smtp.messagingengine.com (flow3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D754D9FA;
	Mon, 15 Apr 2024 11:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713180190; cv=none; b=Oj0bbfwQDBEXwmJdkoWz9aDttyqKv+555VQiS8b2DY7+H5HPtBP8ENzDLUC4D1wUVJLUyhp4bMZFrtZpMitq22BA33MmZaagk7qQmNjCPMy7a885yVs3GeizIXelqgQ0gj41ivG4cjWjnUWCJqhKuEG3aHDWNA7xeyqTJYVECl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713180190; c=relaxed/simple;
	bh=8xQH4bVJwjyOmsKPPc1k9MHQMfHspFpU6Z563Qi7xQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAS1VG+zDPACnHoihWOf37lf7cM0IockzqBa7i/2Dmus8QwNjW9WHqyKIZaMfLWa2Oi58kDAovJIptSTa5e8iF0v4GENwRd/PXW1U82uVWGyaccIrdli1wCgSlMihiULQuM9pNCLqVh79j893Ylo8EexnENCq562BEH6VLt41os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=WyK5RMxR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I/sEnOHj; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.nyi.internal (Postfix) with ESMTP id 0D459200217;
	Mon, 15 Apr 2024 07:23:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 15 Apr 2024 07:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1713180184;
	 x=1713183784; bh=6Dr+SIKKZT7PNCQdR2lrh0qUm7HIjWo0+FjXvOUmaCI=; b=
	WyK5RMxRIJqlwD7LxUGlw1CilZiJJ1i4sbC5jgkj/1QNbGqdxRzFTZZlGifRxDCr
	HC3KeYfZ1SffS55tL2Pd2Dgv2WShSF4V5TFqHfXKLiq5IsV59AWKXFOHAqs/8DdZ
	rMLCl2sEmb0dA+7RA61JyObj+Hrx1MxJIta6flGcrY5aNyaN/yeA/0Iip3qo82pc
	L3dp93CCnTPwx4WhXlo8pe2uYLJY5Awn/MgQ9c6sR2mpEG7qVMHau8cOmJFkzcpu
	V518To9ZrAwSgDp/cGDwaUjeUkV0641+uPRLQ/BbS7SKfGQ5jP9Cwx0zGpydrfG5
	YwOYPVJOdmFamG6NX+r3Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1713180184; x=
	1713183784; bh=6Dr+SIKKZT7PNCQdR2lrh0qUm7HIjWo0+FjXvOUmaCI=; b=I
	/sEnOHjesOSSMXzhqS0ce85cI56uFcs/U9o18DEJRK6kiXdobv2Xeby6KihMDqOD
	VNm2hzgn/vDhZKG1ZrBX+1RRCvNo9fr0ez9eckyJAzq9DKEr5P8LN8p0mihb8pXZ
	LLUKjFi7tz5pqdfBZDME3NEtKTbQw2rHD6b/f1FZ4pMb/aGlGhg6Vb61s2kVko5v
	U414dCTOh6ahzkhcxCoQ8ytXstrCYyvByE05H61aPaqmtPtXENQeceNLDDvXOt3M
	SSzpNzX1maWMLgOMpG238DOrzcFNKAwmNB9WO2CRSTWKzFS/t9CsR46pE/VmmBks
	vsL2kQqKxPtdS8GSDepwQ==
X-ME-Sender: <xms:Fg4dZpQHL-EBzMqUIHmSgxg61_3d_ugRRrNJvgQM3V08hbeBQsex7Q>
    <xme:Fg4dZixOO752MfPDDxjuGdM6aSL9XAaPmL02sxQzPmSbkcBoMQyChn80nQbV7s5N_
    AvnkkDHih24uPrPjjY>
X-ME-Received: <xmr:Fg4dZu0obHf2MEzEhm4ihiOuTucNZTADMo1EYDYviIWAI60sakYreEe7UIbZxEFdHLU9W_RmFX01LjHncwvO6wmhYGLiOMM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhk
    lhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugdorhgvnh
    gvshgrshesrhgrghhnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeefhfellefh
    ffejgfefudfggeejlefhveehieekhfeulefgtdefueehffdtvdelieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggv
    rhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:Fg4dZhDHMYs_zmARhXOviBd7fXcD2PaTPjCt5mBN-Ch-yZbFoFDURw>
    <xmx:Fg4dZijmDZyrUvQSuZyfVMZCwykx_Ck2axIGeYgcXQcYCWn-uCLKeA>
    <xmx:Fg4dZlqLeUyGhXU01htwQAnNyWrp2CFc6fX2mEMlCVtIE9d8YM6twQ>
    <xmx:Fg4dZtjCiLjGcVmQ1c62lyccZeL4fKE2YI-lMWddQG35DeQJHvfpaQ>
    <xmx:Fw4dZmi7BKJGhkWhks2mWJZ3LNl_0d4mQye0w0ssI-5sTjT1Iz5CpNfT>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Apr 2024 07:23:02 -0400 (EDT)
Date: Mon, 15 Apr 2024 13:23:01 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC v3 1/7] net: ravb: Simplify poll & receive
 functions
Message-ID: <20240415112301.GF3156415@ragnatech.se>
References: <20240415094804.8016-1-paul.barker.ct@bp.renesas.com>
 <20240415094804.8016-2-paul.barker.ct@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240415094804.8016-2-paul.barker.ct@bp.renesas.com>

Hi Paul,

I really like this patch!

One nit below.

On 2024-04-15 10:47:58 +0100, Paul Barker wrote:
> We don't need to pass the work budget to ravb_rx() by reference, it's
> cleaner to pass this by value and return the amount of work done. This
> allows us to simplify the ravb_poll() function and use the common
> `work_done` variable name seen in other network drivers for consistency
> and ease of understanding.
> 
> This is a pure refactor and should not affect behaviour.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>  drivers/net/ethernet/renesas/ravb.h      |  2 +-
>  drivers/net/ethernet/renesas/ravb_main.c | 29 ++++++++++--------------
>  2 files changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
> index b48935ec7e28..71de2a7aa27c 100644
> --- a/drivers/net/ethernet/renesas/ravb.h
> +++ b/drivers/net/ethernet/renesas/ravb.h
> @@ -1039,7 +1039,7 @@ struct ravb_ptp {
>  };
>  
>  struct ravb_hw_info {
> -	bool (*receive)(struct net_device *ndev, int *quota, int q);
> +	int (*receive)(struct net_device *ndev, int budget, int q);
>  	void (*set_rate)(struct net_device *ndev);
>  	int (*set_feature)(struct net_device *ndev, netdev_features_t features);
>  	int (*dmac_init)(struct net_device *ndev);
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index fd2679ce4e3d..33f8043143c1 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -759,7 +759,7 @@ static struct sk_buff *ravb_get_skb_gbeth(struct net_device *ndev, int entry,
>  }
>  
>  /* Packet receive function for Gigabit Ethernet */
> -static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
> +static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
>  {
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	const struct ravb_hw_info *info = priv->info;
> @@ -778,7 +778,7 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
>  	limit = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
>  	stats = &priv->stats[q];
>  
> -	for (i = 0; i < limit && rx_packets < *quota; i++, priv->cur_rx[q]++) {
> +	for (i = 0; i < limit && rx_packets < budget; i++, priv->cur_rx[q]++) {
>  		entry = priv->cur_rx[q] % priv->num_rx_ring[q];
>  		desc = &priv->rx_ring[q].desc[entry];
>  		if (desc->die_dt == DT_FEMPTY)
> @@ -881,13 +881,11 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
>  		desc->die_dt = DT_FEMPTY;
>  	}
>  
> -	stats->rx_packets += rx_packets;
> -	*quota -= rx_packets;
> -	return *quota == 0;
> +	return rx_packets;
>  }
>  
>  /* Packet receive function for Ethernet AVB */
> -static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
> +static int ravb_rx_rcar(struct net_device *ndev, int budget, int q)
>  {
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	const struct ravb_hw_info *info = priv->info;
> @@ -904,7 +902,7 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
>  	int i;
>  
>  	limit = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
> -	for (i = 0; i < limit && rx_packets < *quota; i++, priv->cur_rx[q]++) {
> +	for (i = 0; i < limit && rx_packets < budget; i++, priv->cur_rx[q]++) {
>  		entry = priv->cur_rx[q] % priv->num_rx_ring[q];
>  		desc = &priv->rx_ring[q].ex_desc[entry];
>  		if (desc->die_dt == DT_FEMPTY)
> @@ -992,18 +990,16 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
>  		desc->die_dt = DT_FEMPTY;
>  	}
>  
> -	stats->rx_packets += rx_packets;

Don't we still need to update the statistics? Same for ravb_rx_gbeth().

> -	*quota -= rx_packets;
> -	return *quota == 0;
> +	return rx_packets;
>  }
>  
>  /* Packet receive function for Ethernet AVB */
> -static bool ravb_rx(struct net_device *ndev, int *quota, int q)
> +static int ravb_rx(struct net_device *ndev, int budget, int q)
>  {
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	const struct ravb_hw_info *info = priv->info;
>  
> -	return info->receive(ndev, quota, q);
> +	return info->receive(ndev, budget, q);
>  }
>  
>  static void ravb_rcv_snd_disable(struct net_device *ndev)
> @@ -1320,13 +1316,12 @@ static int ravb_poll(struct napi_struct *napi, int budget)
>  	unsigned long flags;
>  	int q = napi - priv->napi;
>  	int mask = BIT(q);
> -	int quota = budget;
> -	bool unmask;
> +	int work_done;
>  
>  	/* Processing RX Descriptor Ring */
>  	/* Clear RX interrupt */
>  	ravb_write(ndev, ~(mask | RIS0_RESERVED), RIS0);
> -	unmask = !ravb_rx(ndev, &quota, q);
> +	work_done = ravb_rx(ndev, budget, q);
>  
>  	/* Processing TX Descriptor Ring */
>  	spin_lock_irqsave(&priv->lock, flags);
> @@ -1345,7 +1340,7 @@ static int ravb_poll(struct napi_struct *napi, int budget)
>  	if (priv->rx_fifo_errors != ndev->stats.rx_fifo_errors)
>  		ndev->stats.rx_fifo_errors = priv->rx_fifo_errors;
>  
> -	if (!unmask)
> +	if (work_done == budget)
>  		goto out;
>  
>  	napi_complete(napi);
> @@ -1362,7 +1357,7 @@ static int ravb_poll(struct napi_struct *napi, int budget)
>  	spin_unlock_irqrestore(&priv->lock, flags);
>  
>  out:
> -	return budget - quota;
> +	return work_done;
>  }
>  
>  static void ravb_set_duplex_gbeth(struct net_device *ndev)
> -- 
> 2.39.2
> 

-- 
Kind Regards,
Niklas Söderlund

