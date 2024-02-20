Return-Path: <linux-kernel+bounces-72779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C51085B89D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D042C1F231FC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57F8612C6;
	Tue, 20 Feb 2024 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgqeYzQW"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E398160DF8;
	Tue, 20 Feb 2024 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423734; cv=none; b=mRYwA5UumPAtr9o4JGW5FPPw4Y3Jdg/3RmLqFA+5XgitbeXPit8VdW3UgKzEZKvTXdrZrZAfofiIy1yjkhtSUBJRmXEZqClDP68GWR+KolJjifeBTkDrspW7E27ltaVjd0NHu7ofCSwELTz/NCq/FTEZkcwqYmgjjy21wyEPIZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423734; c=relaxed/simple;
	bh=1ByA3kK6RWJbrZmHJUtWkMoTeNhDRWt/cJphNfAdUSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d34qE1gpQcpwTreK1SzvsMvLB3nWfvTExtWPNGFXMZd2qgNZjWFJDvPW0bj1O2sspBQYhph0brYYUZbRVe9uTyJA4g+5wYCXDnFDF6/4WqsKhjoJd18gBZAvjlW94TcyisB4Fw77TLAyZyoHnno04Pt1wIFumLO7fE/bzB+iC3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgqeYzQW; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512cba0f953so85367e87.2;
        Tue, 20 Feb 2024 02:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708423724; x=1709028524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+toL7F0kapuzeBLcfc5DcPeiTKIyw1Qh60DwqayzqDU=;
        b=IgqeYzQW4Z2zLlPhFH0IXtBkADGJVBLaTGQzWfmNrB+i0x82epR4+KaY8e3LBSBy+i
         0D6xYg/SHH5x6R/RwzJWqfuhTWtyyV6rz15MszxM1RsdZacVyU2L9iwmjjYjNIPssYmS
         jLr6l+UORekuXyjo7Kk3KK3sT6qKA8yPY3efDXRQDOgjNP0QFEpjqW6yFeRjx6bMNiVn
         BkGse1iGrY6XdBVjfyZgkIw9L4iTTBip5nIEcJ9+ecdiMQY5sLB0GtPpLQU8j3BsYoxJ
         tvh0YC8rEzcgQ/aZ1vzDzVtv5rfSK55dnMgaKM+8QhOYLoIM14EMBM/RZ26fb6+qHvC1
         oRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708423724; x=1709028524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+toL7F0kapuzeBLcfc5DcPeiTKIyw1Qh60DwqayzqDU=;
        b=NnWxhr+sh7V8mU2FW16MiT8fZyJ+Z7GNx4V4mLSFlkIwfdwHj6kos84cpJjANzPHho
         Z9i3Aq+D+aDK7sQVDZEm7UpilfCUisif5qVtXddd9Lg8RU0hD63NMKmfKWI/n83Lfiij
         4it0pFeegFLVU27AOVfdXbkwOtSgy6gIvuqBMURdhI/vcJ5xWMXZZtFv/AjqzrHsnqe1
         gaf6pGcfq4n8UQhQFGbZcpw90UBRSARjQyNl3g8ftHqkPYQBikz09aT+2yN0mphp5H6n
         FSIx6vSkTr9W7UsD6QY5OnwRevmdYH1mQne9mHUMKVGvp8RILZsWhwUKWSttHXpI2MT3
         Jp1w==
X-Forwarded-Encrypted: i=1; AJvYcCWYJCteWLp5CsaQPyVerT8N4NfaTB6705lN9Mya36qeJbHAse4odeYL4X2Ky2izHWYXvAbt3ZOyOeq87gd3XZEw6l6XsnTpVqPdzVGjVnIwttndmFU8I89Am6t74ymZk0xGvSHR
X-Gm-Message-State: AOJu0YwjokZqYdQm5Hqu5lZ14gnaQxXJqdSOMNLA3/kpMJskx1ydBd35
	HtmxFb8xskh2KLJdWnp6bPpCYur7o99/bFChEIR/TJIaF6UiZ3N2
X-Google-Smtp-Source: AGHT+IHRIUgCBvBMs2u9VD5mm0TT4sdm+ubatW6v+3YvFEbj6ODVK8F0sTO+qhcrQUMf2MsZ309twA==
X-Received: by 2002:a05:6512:39d1:b0:512:c2e7:27a3 with SMTP id k17-20020a05651239d100b00512c2e727a3mr1510368lfu.33.1708423724417;
        Tue, 20 Feb 2024 02:08:44 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id t17-20020a195f11000000b0051181cbea91sm1262744lfb.228.2024.02.20.02.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 02:08:43 -0800 (PST)
Date: Tue, 20 Feb 2024 13:08:40 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Piotr Wejman <piotrwejman90@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: fix rx queue priority assignment
Message-ID: <nniukwj6oil7hbr2aefvlwicw362h7gotrudarozre35dk3ugm@wjsosr7p27li>
References: <20240219102405.32015-1-piotrwejman90@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219102405.32015-1-piotrwejman90@gmail.com>

On Mon, Feb 19, 2024 at 11:24:05AM +0100, Piotr Wejman wrote:
> The driver should ensure that same priority is not mapped to multiple
> rx queues. Currently dwmac4_rx_queue_priority function is adding
> priorities for a queue without clearing them from others.
> 
> From DesignWare Cores Ethernet Quality-of-Service
> Databook, section 17.1.29 MAC_RxQ_Ctrl2:
> "[...]The software must ensure that the content of this field is
> mutually exclusive to the PSRQ fields for other queues, that is,
> the same priority is not mapped to multiple Rx queues[...]"
> 
> After this patch, dwmac4_rx_queue_priority function will:
> - assign desired priorities to a queue
> - remove those priorities from all other queues
> The write sequence of CTRL2 and CTRL3 registers is done in the way to
> ensure this order.
> 

Thanks for the fix. The change in general seems good. The same is
applicable for the DW XGMAC too. Could you please apply it to
dwxgmac2_rx_queue_prio()?

> Also, the PSRQn field contains the mask of priorities and not only one
> priority. Rename "prio" argument to "prio_mask".

Please move this to a separate patch applied on top of the main change
described above. Also in order to be done coherently the renaming
should be extended onto all the Tx/Rx queue prio parts in the
driver:
0. dwmac4_core.c
   +-> dwmac4_rx_queue_priority()
   +-> dwmac4_tx_queue_priority()
1. dwxgmac2_core.c
   +-> dwxgmac2_rx_queue_prio()
   +-> dwxgmac2_tx_queue_prio()
2. hwif.h
   +-> stmmac_ops::rx_queue_prio
   +-> stmmac_ops::tx_queue_prio
3. stmmac.h
   +-> stmmac_rxq_cfg::prio
   +-> stmmac_txq_cfg::prio
4. stmmac_main.c:
   +-> stmmac_mac_config_rx_queues_prio()::prio
   +-> stmmac_mac_config_tx_queues_prio()::prio

* Hope I listed all of them.

-Serge(y)

> 
> Signed-off-by: Piotr Wejman <piotrwejman90@gmail.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 36 +++++++++++++------
>  1 file changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> index 6b6d0de09619..6acc8bad794e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> @@ -89,22 +89,38 @@ static void dwmac4_rx_queue_enable(struct mac_device_info *hw,
>  }
>  
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
>  						GMAC_RXQCTRL_PSRQX_MASK(queue);
> -	writel(value, ioaddr + base_register);
> +
> +		writel(ctrl2, ioaddr + GMAC_RXQ_CTRL2);
> +		writel(ctrl3, ioaddr + GMAC_RXQ_CTRL3);
> +	} else {
> +		queue -= 4;
> +
> +		ctrl3 |= (prio_mask << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
> +						GMAC_RXQCTRL_PSRQX_MASK(queue);
> +
> +		writel(ctrl3, ioaddr + GMAC_RXQ_CTRL3);
> +		writel(ctrl2, ioaddr + GMAC_RXQ_CTRL2);
> +	}
>  }
>  
>  static void dwmac4_tx_queue_priority(struct mac_device_info *hw,
> -- 
> 2.25.1
> 
> 

