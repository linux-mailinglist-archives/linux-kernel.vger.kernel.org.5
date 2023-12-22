Return-Path: <linux-kernel+bounces-10072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B7081CF99
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 22:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D09EB22A90
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 21:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B962EAFE;
	Fri, 22 Dec 2023 21:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsGMYKr5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A658A2F844;
	Fri, 22 Dec 2023 21:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e741123acso31263e87.0;
        Fri, 22 Dec 2023 13:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703282209; x=1703887009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Mc4RBdrTIsg9v7kQI4wrbgPnTmbysRGhL3z9WVMn0Q=;
        b=YsGMYKr5epG85biZsLjhEPz1i66S+3ZzbDJaXyiuV04v/oX1gJlC/wD9s6atIfS3Pk
         XnFqjITPk5ekI7krqe0Ye2/qCgLl2CBW26VXcL7neyy9jkvVuFe6qGNVq7UPnTYhyLrx
         nwU6D/DVu3qNvx7liVJwbDg+MYmrNZblcLchBRu07Zg6CLOYB5Z2dW7kt1w+nRYcXv1H
         Wwpsa9d+WndgFt+K/zPt3XXybHJglgpGpXzj108XXOZVQIWbeL7/vdi8ww3IxAiYeMoK
         6HTCSI72ER5UTiGn/jKmBl85PF02+Llbo0rctD/u7uSU0KVz35nlwXbEvEfT5h1/neEm
         hMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703282209; x=1703887009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Mc4RBdrTIsg9v7kQI4wrbgPnTmbysRGhL3z9WVMn0Q=;
        b=E+i4uc+HorrP0rjq6VR10C/TQyjcJNbxBJYQVY2vxQsQwRSas44OfBqQNswUZFWRLV
         KkfRchFjj0pqdeXZqePTr60sviv0gHMoFwaiTzftTGh6zV8nELZ7UEb/GevPhO9pbC56
         4cl8LDJn9bCLRV5+PtJcWUGpJhbdFuZ9mhpAp9OFNoZyjm2tPoSMWzcW8Z53g+N3u8HR
         OfuA0UE27Q8QOUKmiSX8BbYoOfaUcd7i9ouqGIt2FQmEkmVapA7cUAQBil5PUgCdS+hI
         J6XqI2uMxvP47qCgp2jDBiHVcLW9k5OeNC37MtDs8inoTmzs6DxoR/GT6mwcgugGMPIc
         O1rA==
X-Gm-Message-State: AOJu0YwUZhAi8sZVxEzdSICbWfpF53Vl71hzjOsV3Tl5hrgd7rlbUBg8
	EiWbhvqppsjlXAhk5gj/Dg0=
X-Google-Smtp-Source: AGHT+IEBqb6aBSiNjefugxbF5FxM+uS4ON7a8MJONhwTjEhYFmhSAQyyPuQO/gFlPYroXZ7/7kRJdg==
X-Received: by 2002:a05:6512:158d:b0:50e:6b4f:9809 with SMTP id bp13-20020a056512158d00b0050e6b4f9809mr928408lfb.20.1703282209390;
        Fri, 22 Dec 2023 13:56:49 -0800 (PST)
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id bi30-20020a0565120e9e00b0050e5909db5fsm640342lfb.113.2023.12.22.13.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 13:56:48 -0800 (PST)
Date: Sat, 23 Dec 2023 00:56:46 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Leong Ching Swee <leong.ching.swee@intel.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	Teoh Ji Sheng <ji.sheng.teoh@intel.com>
Subject: Re: [PATCH net-next v1 4/4] net: stmmac: Use interrupt mode INTM=1
 for per channel irq
Message-ID: <prjrrsznvpnbanseqttqgtu3s6kgillyyhs5hozwxwh4kt7eiv@zmups3rcbvby>
References: <20231222054451.2683242-1-leong.ching.swee@intel.com>
 <20231222054451.2683242-5-leong.ching.swee@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222054451.2683242-5-leong.ching.swee@intel.com>

On Fri, Dec 22, 2023 at 01:44:51PM +0800, Leong Ching Swee wrote:
> From: Swee Leong Ching <leong.ching.swee@intel.com>
> 
> Enable per DMA channel interrupt that uses shared peripheral
> interrupt (SPI), so only per channel TX and RX intr (TI/RI)
> are handled by TX/RX ISR without calling common interrupt ISR.
> 
> Signed-off-by: Teoh Ji Sheng <ji.sheng.teoh@intel.com>
> Signed-off-by: Swee Leong Ching <leong.ching.swee@intel.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  3 ++
>  .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 32 +++++++++++--------
>  2 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> index 207ff1799f2c..04bf731cb7ea 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -346,6 +346,9 @@
>  /* DMA Registers */
>  #define XGMAC_DMA_MODE			0x00003000
>  #define XGMAC_SWR			BIT(0)
> +#define XGMAC_DMA_MODE_INTM_MASK	GENMASK(13, 12)
> +#define XGMAC_DMA_MODE_INTM_SHIFT	12
> +#define XGMAC_DMA_MODE_INTM_MODE1	0x1
>  #define XGMAC_DMA_SYSBUS_MODE		0x00003004
>  #define XGMAC_WR_OSR_LMT		GENMASK(29, 24)
>  #define XGMAC_WR_OSR_LMT_SHIFT		24
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> index 3cde695fec91..dcb9f094415d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> @@ -31,6 +31,13 @@ static void dwxgmac2_dma_init(void __iomem *ioaddr,
>  		value |= XGMAC_EAME;
>  
>  	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
> +
> +	if (dma_cfg->multi_irq_en) {
> +		value = readl(ioaddr + XGMAC_DMA_MODE);
> +		value &= ~XGMAC_DMA_MODE_INTM_MASK;
> +		value |= (XGMAC_DMA_MODE_INTM_MODE1 << XGMAC_DMA_MODE_INTM_SHIFT);
> +		writel(value, ioaddr + XGMAC_DMA_MODE);
> +	}
>  }
>  
>  static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
> @@ -365,19 +372,18 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
>  	}
>  

>  	/* TX/RX NORMAL interrupts */
> -	if (likely(intr_status & XGMAC_NIS)) {
> -		if (likely(intr_status & XGMAC_RI)) {
> -			u64_stats_update_begin(&rxq_stats->syncp);
> -			rxq_stats->rx_normal_irq_n++;
> -			u64_stats_update_end(&rxq_stats->syncp);
> -			ret |= handle_rx;
> -		}
> -		if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
> -			u64_stats_update_begin(&txq_stats->syncp);
> -			txq_stats->tx_normal_irq_n++;
> -			u64_stats_update_end(&txq_stats->syncp);
> -			ret |= handle_tx;
> -		}
> +	if (likely(intr_status & XGMAC_RI)) {
> +		u64_stats_update_begin(&rxq_stats->syncp);
> +		rxq_stats->rx_normal_irq_n++;
> +		u64_stats_update_end(&rxq_stats->syncp);
> +		ret |= handle_rx;
> +	}
> +
> +	if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
> +		u64_stats_update_begin(&txq_stats->syncp);
> +		txq_stats->tx_normal_irq_n++;
> +		u64_stats_update_end(&txq_stats->syncp);
> +		ret |= handle_tx;

Could you please clarify my comment to the original patch:

On Fri, Aug 18, 2023 at 20:10:21PM +0300, Serge Semin wrote:
> Just curious. Is this change really necessary seeing NIS IRQ is
> unmasked and it is unmasked-OR of the RI/TI/TBU flags in the
> DMA_CHx_Status register? Moreover based on the HW manual,
> DMA_CHx_Status reflects raw IRQ flags status except NIS and AIS which
> are the masked OR of the respective flags. So AFAIU NIS will be set in
> anyway if you have RI/TI/TBU IRQs enabled.

-Serge(y)

>  	}
>  
>  	/* Clear interrupts */
> -- 
> 2.34.1
> 
> 

