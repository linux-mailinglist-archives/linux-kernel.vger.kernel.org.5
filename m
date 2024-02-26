Return-Path: <linux-kernel+bounces-82315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D1786824F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9331F257D7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240BB13172E;
	Mon, 26 Feb 2024 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="AN44pfrW"
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0482612F388;
	Mon, 26 Feb 2024 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708981212; cv=none; b=Jc40W0UozmvDxpwmHvAlBW4g6b3xOQUMb1agzGVG0JaFlE/jWpObmnwvPIGm6M+3KY8e6snVxj7/bx6fyHpMxaW9R1eFo3zmUUB5ii80G4TNNpchfgqjP18HVE+RgVKJ+BG9u7lCDcVmpc6UQKHRqmHSaZeADCJGcpgO0iRt3Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708981212; c=relaxed/simple;
	bh=Hk66Ru/hxzpxeboKp+8Fx6WMw3mVrtFmp58Noh1Dpms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MxS7pvAZSUbVDKQRQ468uDFQzzIz6nyijFMZazdN2H9R9ETDmDfbHi8MHHlEO3c6oFg6FsiZy0tX/n6jwsj6Fw7g6kNEV07sl40qL9iz/NHEPUmZt+P4KlHgBxT4EeItC9L2xVfXBMiH7rTq3lIXiLXkk2gYaIkEUdCPp5aaWn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=AN44pfrW; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Received: from [IPV6:2003:e9:d739:bb29:632d:d63:dac0:8169] (p200300e9d739bb29632d0d63dac08169.dip0.t-ipconnect.de [IPv6:2003:e9:d739:bb29:632d:d63:dac0:8169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 70DC0C0924;
	Mon, 26 Feb 2024 22:00:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1708981208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8Apb+j/UNpSz6gcuGX4ccTZ+NAAhK5iZmSsj/IGxm8=;
	b=AN44pfrWdBgwbs5UfS5MkZz2X/hOYH578DX7DWdbYhNPiInI24tREWy0svpYNPKzfBTOSu
	dXUcJYU7mWKUD2EeIAMQoeaZTzOInXn+SaUhk0iGhTtBIfuXowZi7HdEBbhQcXSoObW5qu
	QIxIkzPRpQBdSr0O6RHIhPhUCTqC3ti4SoJ8PrDLBtG52Dna/DAKLI4ftQMlxrYkZjo4UR
	v3srk8ggrBdSYN527581PLLQnyz7i1i2nasljrdouTb2FzHiCtbuC2amoByqg6Gm4L8gLM
	zQrvYr7jqaI/cNWaBNereqJPBB00oAcApb/fXtlDMATtPiPUV3P5qKA+codhGg==
Message-ID: <f0280912-6423-494f-8d61-28216551ebb9@datenfreihafen.org>
Date: Mon, 26 Feb 2024 22:00:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ieee802154: ca8210: Drop spurious WQ_UNBOUND from
 alloc_ordered_workqueue() call
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, Alexander Aring <alex.aring@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ZcF1El7fn5xkeoB1@slm.duckdns.org>
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <ZcF1El7fn5xkeoB1@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 06.02.24 00:53, Tejun Heo wrote:
> Workqueue is in the process of cleaning up the distinction between unbound
> workqueues w/ @nr_active==1 and ordered workqueues. Explicit WQ_UNBOUND
> isn't needed for alloc_ordered_workqueue() and will trigger a warning in the
> future. Let's remove it. This doesn't cause any functional changes.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>   drivers/net/ieee802154/ca8210.c |   10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> --- a/drivers/net/ieee802154/ca8210.c
> +++ b/drivers/net/ieee802154/ca8210.c
> @@ -2857,19 +2857,13 @@ static int ca8210_interrupt_init(struct
>    */
>   static int ca8210_dev_com_init(struct ca8210_priv *priv)
>   {
> -	priv->mlme_workqueue = alloc_ordered_workqueue(
> -		"MLME work queue",
> -		WQ_UNBOUND
> -	);
> +	priv->mlme_workqueue = alloc_ordered_workqueue("MLME work queue", 0);
>   	if (!priv->mlme_workqueue) {
>   		dev_crit(&priv->spi->dev, "alloc of mlme_workqueue failed!\n");
>   		return -ENOMEM;
>   	}
>   
> -	priv->irq_workqueue = alloc_ordered_workqueue(
> -		"ca8210 irq worker",
> -		WQ_UNBOUND
> -	);
> +	priv->irq_workqueue = alloc_ordered_workqueue("ca8210 irq worker", 0);
>   	if (!priv->irq_workqueue) {
>   		dev_crit(&priv->spi->dev, "alloc of irq_workqueue failed!\n");
>   		destroy_workqueue(priv->mlme_workqueue);

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt

