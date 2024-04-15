Return-Path: <linux-kernel+bounces-145002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E19838A4DF4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B3F280D35
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C21964A90;
	Mon, 15 Apr 2024 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="lu85usNE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XWvlmxKX"
Received: from flow4-smtp.messagingengine.com (flow4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2555FDA5;
	Mon, 15 Apr 2024 11:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713181466; cv=none; b=YQoX7AXj53on46Xft2nKo+ybssRvY2mJTnjyyH/LtVyacOrk1dXnNzLSX61BB+E2mEBUovq/KYSs6umASC8UeRlMSQOJDMuZruYTDozxn3pGAj1IDRzJUDxBAO4I9cKVnykKG2S6w7GhqKI0jGh65z2zs4dS++CA+SEuJz8+aG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713181466; c=relaxed/simple;
	bh=3UZKRtlzaPmVzhvGF3cNLISFgu+v90pgIojd+MaLDGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvOsRyhagrqvzVgAIEMoorguSwqCK3LjFLn3XRw8G9z9+f5haGolrceIGDR0p3finnxwb47Fm3bROgT57mUB6lTnDCcYkD/2wSZaE/jmy23s9p/NvZcH9mC0W66cLe39yN/6RU33HRBteeUsZDBWbWjshKOqgR+lXWk/RwcIj5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=lu85usNE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XWvlmxKX; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.nyi.internal (Postfix) with ESMTP id 223D52001CD;
	Mon, 15 Apr 2024 07:44:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 15 Apr 2024 07:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1713181462;
	 x=1713185062; bh=HbBxkVxjdBwvLWMiPXQ4M2ssgEVrCh8/UypiliPjU0A=; b=
	lu85usNEYHwAtaU9GYauYp10bqMgxYr+VQVBmDOHJkTlsqaaS5M6qxkcwP8TiHu+
	9nDZyq/vR8EgjCDhGuDKmgMgYoc2QJrGwCUr3edGr2IxYEndAno27SQpY/SufHBM
	weWemNWMtvsfcCrD572KkekppJt/tQC7tXH6KTOPlo7F1tbMjML4EQzXOFww8PRt
	z4NdzBcTqWXKZP52ftCZ1sG6E3YGeoNjdRi11CbyjjhFCnau0RjTZ1RVjg1rOVM8
	MqHetdx27GLxZZ+1lsUVdKscAOYvtnm85vULgEFjNverPH4CgaCtS6V2EcBoNOot
	PLHDQQa9s+Z1khuEEQTIYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1713181462; x=
	1713185062; bh=HbBxkVxjdBwvLWMiPXQ4M2ssgEVrCh8/UypiliPjU0A=; b=X
	WvlmxKXHtFJXmvzCjhiKAI4cg4z2JRsvPfNaPLqNM6N15qTJYRFFeTrIMIgW9dU/
	98IFQfNOfuhT1zz0GDQfsNoJhPocbfJM95uPSOv9rNNJpHoifu1LMAji69mGU765
	juPYFmbRk0Gmmjwi7n9siyEAiu1HIw8fJaUvq+sXJ22EhvhX6hZU45hjGeNey6hO
	L++pAuNZ9Re+o3mYh7qVZXRYoyLFY93SdXI3PqXx1ctbkLfwPHLu9amm4XxyqAWT
	ODm7xfRnuZPSX7fW/b1OiE+KW7B6l45eb+TtL5h+3ld+B9HTP8BZ/gLxlq49Tidz
	IUDG+TMYwRrF9INwzqOsQ==
X-ME-Sender: <xms:FRMdZk-49sy6lsVI-UTwkftki9XtrUrlfDwDUmts7FUMXEJ1R-Usgw>
    <xme:FRMdZsuPbaEPMVt8quEyvKzkfMfYjrU8oehUtXEBbr_3T5VCVTVk0csdh4rjKZQoq
    1RPR4nIvbwjMAEQftk>
X-ME-Received: <xmr:FRMdZqDzWrs3oBS2Xf6KBIVaYwffEF6-PgRxVqqugNHRR496dilJZXCd2OjGwHXp1GaMgIHEArZzzlNLSkS0owR9kqsq8a0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefpihhk
    lhgrshcuufpnuggvrhhluhhnugcuoehnihhklhgrshdrshhouggvrhhluhhnugdorhgvnh
    gvshgrshesrhgrghhnrghtvggthhdrshgvqeenucggtffrrghtthgvrhhnpeefhfellefh
    ffejgfefudfggeejlefhveehieekhfeulefgtdefueehffdtvdelieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnihhklhgrshdrshhouggv
    rhhluhhnugdorhgvnhgvshgrshesrhgrghhnrghtvggthhdrshgv
X-ME-Proxy: <xmx:FRMdZkfn_hiSbb8MiZwuRL8dTHj3e-aEQr-5m07Av8SzLRc5Q9pogw>
    <xmx:FRMdZpMHCqwijeW0qgnD_13X7hZsRF8z7hPDiuvzRQCU7ySoEb44eg>
    <xmx:FRMdZunnfTkZ-_AS-ep5z-pJobBLvKaYrnqHzv98gw2-bDJrl5H9-A>
    <xmx:FRMdZrulYOSdA6ZHpXTiVJwvL1j7ooOwrukcLdXjMqPpHXdk_aiJpg>
    <xmx:FRMdZseiVhJPoeG76jjDjT0SLZmPUyFvb0pyN0vf2C9L_YrSWc5TbM4z>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Apr 2024 07:44:20 -0400 (EDT)
Date: Mon, 15 Apr 2024 13:44:19 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC v3 2/7] net: ravb: Align poll function with NAPI
 docs
Message-ID: <20240415114419.GG3156415@ragnatech.se>
References: <20240415094804.8016-1-paul.barker.ct@bp.renesas.com>
 <20240415094804.8016-3-paul.barker.ct@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240415094804.8016-3-paul.barker.ct@bp.renesas.com>

Hi Paul,

Thanks for your work.

On 2024-04-15 10:47:59 +0100, Paul Barker wrote:
> Call napi_complete_done() in accordance with the documentation in
> `Documentation/networking/napi.rst`.

The way I understand it napi_complete() is still OK to use, it's just a 
wrapper for napi_complete_done(napi, 0). But of course using 
napi_complete_done() is better if you want to use the busypolling status 
returned. Maybe the commit message can be updated to reflect this 
change, how about?

    net: ravb: Consider busypolling status when re-enabling interrupts

    Make use of the busypolling status returned from NAPI complete to decide 
    if interrupts shall be re-enabled or not. This is useful to reduce the 
    interrupt overhead.

    While at it switch to using napi_complete_done() as it take into account 
    the work done when providing the busypolling status.

> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 26 ++++++++++--------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 33f8043143c1..1ac599a044b2 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -1340,23 +1340,19 @@ static int ravb_poll(struct napi_struct *napi, int budget)
>  	if (priv->rx_fifo_errors != ndev->stats.rx_fifo_errors)
>  		ndev->stats.rx_fifo_errors = priv->rx_fifo_errors;
>  
> -	if (work_done == budget)
> -		goto out;
> -
> -	napi_complete(napi);
> -
> -	/* Re-enable RX/TX interrupts */
> -	spin_lock_irqsave(&priv->lock, flags);
> -	if (!info->irq_en_dis) {
> -		ravb_modify(ndev, RIC0, mask, mask);
> -		ravb_modify(ndev, TIC,  mask, mask);
> -	} else {
> -		ravb_write(ndev, mask, RIE0);
> -		ravb_write(ndev, mask, TIE);
> +	if (work_done < budget && napi_complete_done(napi, work_done)) {
> +		/* Re-enable RX/TX interrupts */
> +		spin_lock_irqsave(&priv->lock, flags);
> +		if (!info->irq_en_dis) {
> +			ravb_modify(ndev, RIC0, mask, mask);
> +			ravb_modify(ndev, TIC,  mask, mask);
> +		} else {
> +			ravb_write(ndev, mask, RIE0);
> +			ravb_write(ndev, mask, TIE);
> +		}
> +		spin_unlock_irqrestore(&priv->lock, flags);
>  	}
> -	spin_unlock_irqrestore(&priv->lock, flags);
>  
> -out:
>  	return work_done;
>  }
>  
> -- 
> 2.39.2
> 

-- 
Kind Regards,
Niklas Söderlund

