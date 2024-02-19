Return-Path: <linux-kernel+bounces-71135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 161C185A12E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B517C2812F3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46C828E0F;
	Mon, 19 Feb 2024 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="APnXhhLk"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B713122F13;
	Mon, 19 Feb 2024 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339233; cv=none; b=OOYFurHRHaxGN0MrHXQ0azr6tFLdGnvR2HrvC/9VqRr9VlMWYD/SfIB8KrKQYRonlmFWJkmiYE27XvGLNC6pDjHWIGMRBpmpx9AupNOutgtDaqKg2O0PMvp+v9kt+i20XlpSOFYk/Azu0WO8sbXIfTJ5MF7Wt95/hp8SJPNygmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339233; c=relaxed/simple;
	bh=vPK/7i++5EkuRh3A9cB+oZcKXbKyaMhoFkcCQIQBXlM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pKXhfgRSL7g5w2xC34WbkKb9b68WEdsN7bK9InKoeUdw4EOAZC0OXLP1IiQB0pPCq7rBhnkgjMaUCWZfuQhI1bQkrowER3jM0AUGTyYEl4ITHdbvzSzFofsxHAaAblT1T2SVDVhp4nwn9ScsKvAfYFXpovr57ycpn9JlSLByMb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=APnXhhLk; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D31AAC0006;
	Mon, 19 Feb 2024 10:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708339228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pvJ5Bdzvp14vIivGP5ebUVk8Mv5zqJTnOjVP5r+RR6o=;
	b=APnXhhLkeqRTI+H3MWdxeMZNrdls3Bs3LmusHu3n/te7j+eVqu7MLTs1HPdKLdZORKad4n
	oU8YCUXIWJ1KU3AF/zEOZg3kxbOTjxjYy69J+4Oll7qGkM8nM3Uw3IMezvxZdM7wnct/Me
	HAVEtZbVcisMdbey1mV5zXIChEYPDT1JtSOAOo9bGfWr8ZZB7WHBkbpnAGF1FgOd0L7mAE
	WQKjyJhT8qRVea5UHtreltShxYcHBeA38xsdp/nFlHHiE1dHZvheo30m7PK9wlxqtnpfll
	MJD3Ho8GljzFJG4iCcApfzVcaYKBuAU6bgPiooeCBLE61kzhP0/iSdRuiTxESA==
Date: Mon, 19 Feb 2024 11:40:56 +0100 (CET)
From: Romain Gantois <romain.gantois@bootlin.com>
To: Piotr Wejman <piotrwejman90@gmail.com>
cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
    Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, 
    Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, 
    linux-stm32@st-md-mailman.stormreply.com, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: fix rx queue priority assignment
In-Reply-To: <20240219102405.32015-1-piotrwejman90@gmail.com>
Message-ID: <6bb634fb-fe02-085b-a96f-ea56698ebcb4@bootlin.com>
References: <20240219102405.32015-1-piotrwejman90@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-GND-Sasl: romain.gantois@bootlin.com

Hello Piotr,

On Mon, 19 Feb 2024, Piotr Wejman wrote:

>  static void dwmac4_rx_queue_priority(struct mac_device_info *hw,
> -				     u32 prio, u32 queue)
> +				     u32 prio_mask, u32 queue)
>  {
>  	void __iomem *ioaddr = hw->pcsr;
> -	u32 base_register;
> -	u32 value;
> +	u32 clear_mask = 0;
> +	u32 ctrl2, ctrl3;
> +	int i;
>  
> -	base_register = (queue < 4) ? GMAC_RXQ_CTRL2 : GMAC_RXQ_CTRL3;
> -	if (queue >= 4)
> -		queue -= 4;
> +	ctrl2 = readl(ioaddr + GMAC_RXQ_CTRL2);
> +	ctrl3 = readl(ioaddr + GMAC_RXQ_CTRL3);
>  
> -	value = readl(ioaddr + base_register);
> +	for (i = 0; i < 4; i++)
> +		clear_mask |= ((prio_mask << GMAC_RXQCTRL_PSRQX_SHIFT(i)) &
> +						GMAC_RXQCTRL_PSRQX_MASK(i));
>  
> -	value &= ~GMAC_RXQCTRL_PSRQX_MASK(queue);
> -	value |= (prio << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
> +	ctrl2 &= ~clear_mask;
> +	ctrl3 &= ~clear_mask;
> +
> +	if (queue < 4) {
> +		ctrl2 |= (prio_mask << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
This is a bit of a nitpick but do you think it would make sense to replace that 
"4" with a macro? Something like GMAC_RXQCTRL_PSRXQ_MAXCTRL2QUEUE?

>  						GMAC_RXQCTRL_PSRQX_MASK(queue);
> -	writel(value, ioaddr + base_register);
> +
> +		writel(ctrl2, ioaddr + GMAC_RXQ_CTRL2);
> +		writel(ctrl3, ioaddr + GMAC_RXQ_CTRL3);
I suppose that the order of these two writes are somehow important, else these 
could be factored out of the conditional block. Could you maybe add a short 
comment that explains why the order of these writes matter?

Best Regards,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

