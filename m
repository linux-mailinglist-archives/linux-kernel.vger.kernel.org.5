Return-Path: <linux-kernel+bounces-118696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCD588BE26
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD0F1F3DFF6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C87F6F08E;
	Tue, 26 Mar 2024 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="O/+upGDI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LL6AkurC"
Received: from wflow4-smtp.messagingengine.com (wflow4-smtp.messagingengine.com [64.147.123.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571F66A008;
	Tue, 26 Mar 2024 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711445935; cv=none; b=ocv5/YWowcj+6b/JJ7Yq3mL2N1Ojz74TbhxR/N5zxobGjJE0rZmaukelU9i1UsVxqCWoMj1CaBXHHXLNWID1L85X6SmmFCBkpAt9CV2CYHj8f4AIAa+dG+OqVuztC9SA4B9pAitkV1NN5/VIUJAyfZ6W5dGiDUxoOLeGwSvqxMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711445935; c=relaxed/simple;
	bh=LQiYZFwG2wXA7RRUY/zPIfSp3BpCPvPSe57B2cwoZeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJkDX0wjlFzqVWZcQ+7TuDry4tuIgxHs4cPvpLgMO2AlR2RUu7BnNNxfNeWGb0/kAdDtE42Xdop9bIEuBy9dTtfGT13//A8PTVb7lABqUL47TS9rmI2D4mqxYafuC8aTmIMU2AbwrsGrfr0VJoUqw01FnRRYe3IFFlx52Ot7MSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=O/+upGDI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LL6AkurC; arc=none smtp.client-ip=64.147.123.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailflow.west.internal (Postfix) with ESMTP id 663442CC01D7;
	Tue, 26 Mar 2024 05:38:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 26 Mar 2024 05:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1711445928;
	 x=1711449528; bh=e67jrYC5m2Y/Tub3MmlHMgqTO1mZwsGuZF11VR92RAU=; b=
	O/+upGDIO+7q+214HmnlIGbPT47p9uJw+CnRQqInk9NPKf7lzNAdUkPLsLZttsjC
	lXbsIOf98XYQXNz+EJ70SU4MkhSu+M1SFweWbVqh5SU3D0mLpQXsdl5gBqfERLeM
	9CUyPfwflZsQXh5d8wnQIB1J8rsYM5xu93z8g6dEkLb7fsJqpJdnwmQCEGewkmyY
	okE1EFf6TR3uUjyoPPFukN4GijmN1pxQpjxTQu/xAG4MoCG3H0Cp9QzWR0llPnos
	HF9WkTT+KbKGC3KkqvuhxSgLKH6yZUySLNy7DPwYBlrvUUKZrzCcga9JBX7Bi7FD
	8B2W33WkhZzbsYudkd/vpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711445928; x=
	1711449528; bh=e67jrYC5m2Y/Tub3MmlHMgqTO1mZwsGuZF11VR92RAU=; b=L
	L6AkurC8LdCgD962iNdBk2DtOXib1b3wvai2SVXyPcbxEu0skd0dg5bRjzbMxMnT
	UwiL0fxudlEzvu6IjnmGtMZZ4E+ajU6cfy6bYhEqDYzDb0YsTTbrpPkIT7EH9Akk
	8e24ieBYfznR5bk5lcRwP60n5L/Y6EdmBIDCQ8ike9Fabkm1q8O1cc7Jg00zJT9P
	0HeWLr8pS/tX1yRESsnnsQCgNVZCu6z7/7ZHcyyFIMoeQLr/mH4HCk+ABDxoarOs
	QYATp2BkOHZDtdcFRU5UyRnTSxqL6et4LIG4hPm3X1nM6JnbCrSjHY/h+jVV/RdB
	crkhW0wyCuww2CNTj4yOA==
X-ME-Sender: <xms:p5cCZiMx7g1LKZnwgxA1CONy-2FBhUxXe0xNDgbTXDeS8ytHq3zGIg>
    <xme:p5cCZg96ytwBAq7BY7gWNp5gOfiIwhZ-bew-ejDlCNMHsHLJ1605zj-OrE2CVYIZd
    -3N9YPHtLOD2Ga9L2M>
X-ME-Received: <xmr:p5cCZpTKE2vA-nlihFRl3LDoLWo6vrQ-h1hEueocSEKuSRzwdOSp_YWncWbXOIXZkvozXuihwiRg7H5_VLjKELn7D9sxQc4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhk
    lhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugdorhgvnh
    gvshgrshesrhgrghhnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeefhfellefh
    ffejgfefudfggeejlefhveehieekhfeulefgtdefueehffdtvdelieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggv
    rhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:p5cCZiulwbwfFax14kSoeC1hrb92R3IVC60b53nK6Yo_ztTbHk2aGQ>
    <xmx:p5cCZqe5vyJplcs8F5HxBFeSoHYxzkzzusNz7FK_de9sg9aqWNyvxQ>
    <xmx:p5cCZm2ySIUFa07pCqADDqcTEubWYgWmt3lP3uQVaQ6Bo4jkmKMAaQ>
    <xmx:p5cCZu93W4U0pTe528wzpefW0Mxw7uZmrrRhggA_r6eDCJYmuDqeIA>
    <xmx:qJcCZq5mBoUXuPPE2GkyksQL8SeMEPSZbWO9eLccaGrAHMUNpwzHoPCLH6rWiYgD>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 05:38:47 -0400 (EDT)
Date: Tue, 26 Mar 2024 10:38:43 +0100
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net: ravb: Always process TX descriptor ring
Message-ID: <20240326093843.GD1108818@ragnatech.se>
References: <20240326083740.23364-1-paul.barker.ct@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240326083740.23364-1-paul.barker.ct@bp.renesas.com>

Hi Paul,

Thanks for your work.

On 2024-03-26 08:37:39 +0000, Paul Barker wrote:
> The TX queue should be serviced each time the poll function is called,
> even if the full RX work budget has been consumed. This prevents
> starvation of the TX queue when RX bandwidth usage is high.

Is this not a design decision? That the driver should prioritize Rx over 
Tx if there is contention. I have no opinion on if this design is good 
or bad, I let Sergey judge that.

> 
> Fixes: a0d2f20650e8 ("Renesas Ethernet AVB PTP clock driver")

However, I do not think it is a bug and should not have a fixes tag.  
Also this fixes tag is incorrect, this points to the commit where ravb.c 
was renamed ravb_main.c. ravb_poll() is not touched by this commit.

> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index d1be030c8848..4f98e4e2badb 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -1324,12 +1324,12 @@ static int ravb_poll(struct napi_struct *napi, int budget)
>  	int q = napi - priv->napi;
>  	int mask = BIT(q);
>  	int quota = budget;
> +	bool rearm = true;
>  
>  	/* Processing RX Descriptor Ring */
>  	/* Clear RX interrupt */
>  	ravb_write(ndev, ~(mask | RIS0_RESERVED), RIS0);
> -	if (ravb_rx(ndev, &quota, q))
> -		goto out;
> +	rearm = !ravb_rx(ndev, &quota, q);
>  
>  	/* Processing TX Descriptor Ring */
>  	spin_lock_irqsave(&priv->lock, flags);
> @@ -1339,6 +1339,9 @@ static int ravb_poll(struct napi_struct *napi, int budget)
>  	netif_wake_subqueue(ndev, q);
>  	spin_unlock_irqrestore(&priv->lock, flags);
>  
> +	if (!rearm)
> +		goto out;
> +
>  	napi_complete(napi);
>  
>  	/* Re-enable RX/TX interrupts */
> 
> base-commit: 4cece764965020c22cff7665b18a012006359095
> -- 
> 2.44.0
> 

-- 
Kind Regards,
Niklas Söderlund

