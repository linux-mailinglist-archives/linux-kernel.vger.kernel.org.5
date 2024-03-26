Return-Path: <linux-kernel+bounces-118701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 110E188BE34
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926F21F630D8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C5E6F079;
	Tue, 26 Mar 2024 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="FoMd9J5+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P7Nj+ovv"
Received: from wflow4-smtp.messagingengine.com (wflow4-smtp.messagingengine.com [64.147.123.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925F045975;
	Tue, 26 Mar 2024 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711446128; cv=none; b=bAdLOX/FfqKvh1RQsZORKJYVn9s3mCCkr6dSPlsMr+u8V+Wjpvl0XjMXPsrJ2a03F2e3+FP/LiNpyLS/Cu1LkjBqFksQkz2V7gA131qcB9+8zGVUNAwoiNcd7FkeXaZXSYSgNv23Cwk25AajX4ll8GDETW/bPsWDu5HZKtsJ/bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711446128; c=relaxed/simple;
	bh=+6XqUYNhs6qPfV3a1WUmWjWqUdxFP87MT6OSK+AGQlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gmb/qK97/aUPv/Ymf4TKTNEJQ3sleyOVW3lJfg4KeuwNflhLa0ZmKKO9i8e57wQ/GOTF/UfqrYCY3mC1AGd588cqqCvc8hFU7CNwbnmRg+INgBQenOlssDR5PYLx8iXUvrnfLbddVsQuZxj3cm75pEBTZTMmVVd+4JU0ZBngex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=FoMd9J5+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P7Nj+ovv; arc=none smtp.client-ip=64.147.123.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailflow.west.internal (Postfix) with ESMTP id C98E12CC01E9;
	Tue, 26 Mar 2024 05:42:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 26 Mar 2024 05:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1711446124;
	 x=1711449724; bh=E1sSzlU2DFr0ZKZ7anXAEd8HAvsf018DCCWOpUCnKRM=; b=
	FoMd9J5+YZ0ELZ4B3Nf0sCFFrJl3FNs1h1HaZtllU1mmjzdbWbnAo1UJ+oWr1lzT
	/69sJFWYO/C+ciDBsLb0x+DmcL9SN8QwFV4DQpqerjdyBciPKf/n0P6T8Fd90vZi
	+AgZ+fhki3sh/nzq5dJ+vjE9zHQYYNTXnygmnduGBE86WP4cB1GNImQxCiyPlOjD
	DUT9QpBHalYxvNL61agaJQHw9u7bqpbjMDkYJotCTVitGduEC3kpe6tzUyAOVfrC
	4HXgFn3htqLqZ+FTfLqmRbMTz0XkCFAkllUpoY1AulWA9XNTKcTx8Kq02sgmMtGp
	ZJ4yA8h0GA2GokokyMGyag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711446124; x=
	1711449724; bh=E1sSzlU2DFr0ZKZ7anXAEd8HAvsf018DCCWOpUCnKRM=; b=P
	7Nj+ovvT0Ft8XgvjEOimiSPXRmJtt7vGu3VgWknM98MwTJV1a9IDOVM/6TnJcRSb
	5IK/4hqWqqVvRfSeQYaNn7CpxjXE1Kke42EEsHSqyUWozwpPH/RkkqHdwBs4BsN1
	UGRx1/aBh63SLHYJCvpuD0eOPHV+Cw07XxrInoruH6OmRU6qSXuDW+AJXOr/HaOM
	nGKy0alaO89WlOzGV35FwyPY/ikfSQh7EO4+rC1emoJZn4jJPVMPO4gMU1FJQsfb
	w1VQAj5+s9NKS1cYdxPUkYdhdXm/FbqjojHWOelx87tdJLnMKF5LkBJiOxr7G0N7
	uuC4NccCEvWo13HSc0l9w==
X-ME-Sender: <xms:a5gCZjgK5eqsGGUEhf1lw8wT1EmwCdiOfbdDyT6qM28leYAfXYvMJQ>
    <xme:a5gCZgDGSQ7S3j4nOg9qWF0ZCv2QnJCXWUQHH-mx-6M7bCQM0DopTLqmHlDbkStRi
    z0k6vPbNoP4pP2pz0I>
X-ME-Received: <xmr:a5gCZjGmrdxt2FqOtwDSoGnIADsQbnYn_3hwCHSyh9GZhlR8YlwUZJFGzJk-LXq7AU7RUrMd-vneETpsRPmRT_OOURWA5LY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhk
    lhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugdorhgvnh
    gvshgrshesrhgrghhnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeefhfellefh
    ffejgfefudfggeejlefhveehieekhfeulefgtdefueehffdtvdelieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggv
    rhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:a5gCZgQ1T_HotxQAHsH07YkWrsvMw81ROZIIabXz5GQdD3_IuMvXaA>
    <xmx:a5gCZgzvTnxo-oY3vk9yNw01WShMcG80LaZOYYnJMh0qHvNHA2HppA>
    <xmx:a5gCZm4sVyAY5gjcRS857GASKCszXJ5dZlsfKjiRv8mfTkLDA_lWkQ>
    <xmx:a5gCZlxQDuOh-FjIf4vkJ7jzGjmZp0YU8siga8uPQ6SbZUEuMxucjQ>
    <xmx:bJgCZseea4ZHP0ZiQiqwG08CH33LgL0LP3JDjd3EUfE2jqDxD5Y_qT4MWF0TCUcw>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 05:42:03 -0400 (EDT)
Date: Tue, 26 Mar 2024 10:42:01 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: ravb: Always update error counters
Message-ID: <20240326094201.GE1108818@ragnatech.se>
References: <20240326083740.23364-1-paul.barker.ct@bp.renesas.com>
 <20240326083740.23364-2-paul.barker.ct@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240326083740.23364-2-paul.barker.ct@bp.renesas.com>

Hi Paul,

Thanks for your work.

On 2024-03-26 08:37:40 +0000, Paul Barker wrote:
> The error statistics should be updated each time the poll function is
> called, even if the full RX work budget has been consumed. This prevents
> the counts from becoming stuck when RX bandwidth usage is high.
> 
> This also ensures that error counters are not updated after we've
> re-enabled interrupts as that could result in a race condition.
> 
> Also drop an unnecessary space.
> 
> Fixes: a0d2f20650e8 ("Renesas Ethernet AVB PTP clock driver")

Same comment about fixes tag is in patch 1/2.

> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 4f98e4e2badb..a95703948a36 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -1339,6 +1339,15 @@ static int ravb_poll(struct napi_struct *napi, int budget)
>  	netif_wake_subqueue(ndev, q);
>  	spin_unlock_irqrestore(&priv->lock, flags);
>  
> +	/* Receive error message handling */
> +	priv->rx_over_errors =  priv->stats[RAVB_BE].rx_over_errors;

While you are dropping spaces s/=  priv/= priv/ here.

> +	if (info->nc_queues)
> +		priv->rx_over_errors += priv->stats[RAVB_NC].rx_over_errors;
> +	if (priv->rx_over_errors != ndev->stats.rx_over_errors)
> +		ndev->stats.rx_over_errors = priv->rx_over_errors;
> +	if (priv->rx_fifo_errors != ndev->stats.rx_fifo_errors)
> +		ndev->stats.rx_fifo_errors = priv->rx_fifo_errors;
> +
>  	if (!rearm)
>  		goto out;
>  
> @@ -1355,14 +1364,6 @@ static int ravb_poll(struct napi_struct *napi, int budget)
>  	}
>  	spin_unlock_irqrestore(&priv->lock, flags);
>  
> -	/* Receive error message handling */
> -	priv->rx_over_errors =  priv->stats[RAVB_BE].rx_over_errors;
> -	if (info->nc_queues)
> -		priv->rx_over_errors += priv->stats[RAVB_NC].rx_over_errors;
> -	if (priv->rx_over_errors != ndev->stats.rx_over_errors)
> -		ndev->stats.rx_over_errors = priv->rx_over_errors;
> -	if (priv->rx_fifo_errors != ndev->stats.rx_fifo_errors)
> -		ndev->stats.rx_fifo_errors = priv->rx_fifo_errors;
>  out:
>  	return budget - quota;
>  }
> -- 
> 2.44.0
> 

-- 
Kind Regards,
Niklas Söderlund

