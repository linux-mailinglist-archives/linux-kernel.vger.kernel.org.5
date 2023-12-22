Return-Path: <linux-kernel+bounces-10008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1A281CEA3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63FE4B242F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2DA2D780;
	Fri, 22 Dec 2023 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUTOe3So"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5FA2C1AE;
	Fri, 22 Dec 2023 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e558e16e7so2064076e87.1;
        Fri, 22 Dec 2023 11:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703271772; x=1703876572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/WNkEye7dFIS+EDfctJcq2mxRq3d7CRsgYJhjbfmoKo=;
        b=MUTOe3SouwXWEGAtnMDavX8jq7hGtd1/fVdid09sv8UZHaN8nu80Vrmu0xupSoW04j
         6KT7biNLvK1EUGnVzmB3BNcLI8SabzNAOBlDcH/K7tGVMjSizHUMEN6q3cOt/5vsxcZH
         b2Dnu7FrmnDY1VANk3qXfUdqgZyCgtdq90RvSeHnQL/Mo0dp7I1Q6qXd9yV/85kt6a5L
         aPgmcy6M2UrQ3WpCgZmStQnDnjyRQK/dqrp0EcOLxy6GBZBO+6+cfMGxnputGV4fm4Gq
         dSH1LrPCZabsqw6mDu5cKLtdExbqW8S6znFekkAE0S6YhlYx4H2EdiSDJGyhjUuTdmyF
         xJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703271772; x=1703876572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WNkEye7dFIS+EDfctJcq2mxRq3d7CRsgYJhjbfmoKo=;
        b=GRmZ4o2TIV7M1NjUudAAMzh7h87ZsRklgUoKXwydoSRWWA/y+MougtmKB+lxbdZ/Lz
         +tzqpy52bWAfwFFFf/as5MN8z7rYirXcdPHJcNVsB8VkH2n64toZU25+tBT+kavpFyGR
         7WTBOsgVavcFCZ4Q6Crm9BwttH9EbqAxrMn7WGp3rPmJbYAVPL6bH8hAh+18otqrW3yG
         J8pJAxSIp6J4O9ANEHwvJ8fr8KdgLBfriMfqNmrVLJN1LH+s15xl3F9mfVk4ReqY2ya7
         KkwEK4pW99fsEUQtui/T7fMa/1deRpNuwiXt4GdT6zRkQBoypSNhtnVAzPQAwykCFLN5
         Lr4Q==
X-Gm-Message-State: AOJu0YwfrXR0Cxu4+TqfnVqVhFQXgQJVbMmvIJGOyoylBp3zfYhBrIag
	V49fFe21o7F11ntlGNiBfB4=
X-Google-Smtp-Source: AGHT+IGz/FqM2N1Z4rL+rLpRsvL9Un5LXgILvgOSlHba9sLT12TSLmn3JXu/fLGcWUryA565wKYB2g==
X-Received: by 2002:a19:2d42:0:b0:50e:4b79:b825 with SMTP id t2-20020a192d42000000b0050e4b79b825mr982189lft.20.1703271771959;
        Fri, 22 Dec 2023 11:02:51 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id q17-20020ac25fd1000000b0050e3719148fsm608211lfg.235.2023.12.22.11.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 11:02:51 -0800 (PST)
Date: Fri, 22 Dec 2023 22:02:47 +0300
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
Subject: Re: [PATCH net-next v1 2/4] net: stmmac: Make MSI interrupt routine
 generic
Message-ID: <zwlnzllanmd6wtmn6ts7pd6y2sxgbauy4ffgqlf3yaq4uo65tw@ybigwcjpk7uf>
References: <20231222054451.2683242-1-leong.ching.swee@intel.com>
 <20231222054451.2683242-3-leong.ching.swee@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222054451.2683242-3-leong.ching.swee@intel.com>

On Fri, Dec 22, 2023 at 01:44:49PM +0800, Leong Ching Swee wrote:
> From: Swee Leong Ching <leong.ching.swee@intel.com>
> 
> There is no support for per DMA channel interrupt for non-MSI platform,
> where the MAC's per channel interrupt hooks up to interrupt controller(GIC)
> through shared peripheral interrupt(SPI) to handle interrupt from TX/RX
> transmit channel.
> 
> This patch generalize the existing MSI ISR to also support non-MSI
> platform.
> 
> Signed-off-by: Teoh Ji Sheng <ji.sheng.teoh@intel.com>
> Signed-off-by: Swee Leong Ching <leong.ching.swee@intel.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  4 +--
>  .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |  2 +-
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 29 ++++++++++---------
>  include/linux/stmmac.h                        |  4 +--
>  4 files changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> index 60283543ffc8..f0ec69af96c9 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> @@ -952,7 +952,7 @@ static int stmmac_config_single_msi(struct pci_dev *pdev,
>  
>  	res->irq = pci_irq_vector(pdev, 0);
>  	res->wol_irq = res->irq;
> -	plat->flags &= ~STMMAC_FLAG_MULTI_MSI_EN;
> +	plat->flags &= ~STMMAC_FLAG_MULTI_IRQ_EN;
>  	dev_info(&pdev->dev, "%s: Single IRQ enablement successful\n",
>  		 __func__);
>  
> @@ -1004,7 +1004,7 @@ static int stmmac_config_multi_msi(struct pci_dev *pdev,
>  	if (plat->msi_sfty_ue_vec < STMMAC_MSI_VEC_MAX)
>  		res->sfty_ue_irq = pci_irq_vector(pdev, plat->msi_sfty_ue_vec);
>  
> -	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> +	plat->flags |= STMMAC_FLAG_MULTI_IRQ_EN;
>  	dev_info(&pdev->dev, "%s: multi MSI enablement successful\n", __func__);
>  
>  	return 0;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> index 84d3a8551b03..5f649106ffcd 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> @@ -175,7 +175,7 @@ static void dwmac4_dma_init(void __iomem *ioaddr,
>  
>  	value = readl(ioaddr + DMA_BUS_MODE);
>  
> -	if (dma_cfg->multi_msi_en) {
> +	if (dma_cfg->multi_irq_en) {
>  		value &= ~DMA_BUS_MODE_INTM_MASK;
>  		value |= (DMA_BUS_MODE_INTM_MODE1 << DMA_BUS_MODE_INTM_SHIFT);
>  	}
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 47de466e432c..30cc9edb4198 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -129,8 +129,8 @@ static irqreturn_t stmmac_interrupt(int irq, void *dev_id);
>  /* For MSI interrupts handling */
>  static irqreturn_t stmmac_mac_interrupt(int irq, void *dev_id);
>  static irqreturn_t stmmac_safety_interrupt(int irq, void *dev_id);

> -static irqreturn_t stmmac_msi_intr_tx(int irq, void *data);
> -static irqreturn_t stmmac_msi_intr_rx(int irq, void *data);
> +static irqreturn_t stmmac_tx_queue_interrupt(int irq, void *data);
> +static irqreturn_t stmmac_rx_queue_interrupt(int irq, void *data);

Let's use the next names instead:

+static irqreturn_t stmmac_dma_tx_interrupt(int irq, void *data);
+static irqreturn_t stmmac_dma_rx_interrupt(int irq, void *data);

It would be semantically more correct and would refer to the
stmmac_dma_interrupt() handler.

>  static void stmmac_reset_rx_queue(struct stmmac_priv *priv, u32 queue);
>  static void stmmac_reset_tx_queue(struct stmmac_priv *priv, u32 queue);
>  static void stmmac_reset_queues_param(struct stmmac_priv *priv);
> @@ -3602,7 +3602,7 @@ static void stmmac_free_irq(struct net_device *dev,
>  	}
>  }
>  
> -static int stmmac_request_irq_multi_msi(struct net_device *dev)
> +static int stmmac_request_irq_multi(struct net_device *dev)
>  {
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  	enum request_irq_err irq_err;
> @@ -3701,13 +3701,13 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>  	for (i = 0; i < priv->plat->rx_queues_to_use; i++) {
>  		if (i >= MTL_MAX_RX_QUEUES)
>  			break;

> -		if (priv->rx_irq[i] == 0)
> +		if (priv->rx_irq[i] <= 0)

Why? What about just using a temporary variable in
stmmac_get_platform_resources() to get the Per-channel DMA IRQs and
not saving error number in priv->rx_irq[]?

>  			continue;
>  
>  		int_name = priv->int_name_rx_irq[i];
>  		sprintf(int_name, "%s:%s-%d", dev->name, "rx", i);
>  		ret = request_irq(priv->rx_irq[i],
> -				  stmmac_msi_intr_rx,
> +				  stmmac_rx_queue_interrupt,
>  				  0, int_name, &priv->dma_conf.rx_queue[i]);
>  		if (unlikely(ret < 0)) {
>  			netdev_err(priv->dev,
> @@ -3726,13 +3726,13 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>  	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
>  		if (i >= MTL_MAX_TX_QUEUES)
>  			break;

> -		if (priv->tx_irq[i] == 0)
> +		if (priv->tx_irq[i] <= 0)

ditto.

>  			continue;
>  
>  		int_name = priv->int_name_tx_irq[i];
>  		sprintf(int_name, "%s:%s-%d", dev->name, "tx", i);
>  		ret = request_irq(priv->tx_irq[i],
> -				  stmmac_msi_intr_tx,
> +				  stmmac_tx_queue_interrupt,
>  				  0, int_name, &priv->dma_conf.tx_queue[i]);
>  		if (unlikely(ret < 0)) {
>  			netdev_err(priv->dev,

Please fix the error message strings in stmmac_request_irq_multi_msi()
too.

> @@ -3811,8 +3811,8 @@ static int stmmac_request_irq(struct net_device *dev)
>  	int ret;
>  
>  	/* Request the IRQ lines */
> -	if (priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN)
> -		ret = stmmac_request_irq_multi_msi(dev);
> +	if (priv->plat->flags & STMMAC_FLAG_MULTI_IRQ_EN)
> +		ret = stmmac_request_irq_multi(dev);
>  	else
>  		ret = stmmac_request_irq_single(dev);
>  
> @@ -6075,7 +6075,7 @@ static irqreturn_t stmmac_safety_interrupt(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static irqreturn_t stmmac_msi_intr_tx(int irq, void *data)
> +static irqreturn_t stmmac_tx_queue_interrupt(int irq, void *data)
>  {
>  	struct stmmac_tx_queue *tx_q = (struct stmmac_tx_queue *)data;
>  	struct stmmac_dma_conf *dma_conf;
> @@ -6107,7 +6107,7 @@ static irqreturn_t stmmac_msi_intr_tx(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -static irqreturn_t stmmac_msi_intr_rx(int irq, void *data)
> +static irqreturn_t stmmac_rx_queue_interrupt(int irq, void *data)
>  {
>  	struct stmmac_rx_queue *rx_q = (struct stmmac_rx_queue *)data;
>  	struct stmmac_dma_conf *dma_conf;
> @@ -7456,8 +7456,11 @@ int stmmac_dvr_probe(struct device *device,
>  	priv->plat = plat_dat;
>  	priv->ioaddr = res->addr;
>  	priv->dev->base_addr = (unsigned long)res->addr;
> -	priv->plat->dma_cfg->multi_msi_en =
> -		(priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN);
> +

> +	if (res->rx_irq[0] > 0 && res->tx_irq[0] > 0) {
> +		priv->plat->flags |= STMMAC_FLAG_MULTI_IRQ_EN;
> +		priv->plat->dma_cfg->multi_irq_en = true;
> +	}

This is wrong. It activates the stmmac_request_irq_multi_msi() method
to assign all the IRQ handlers to the individual IRQs. Even if DMA
IRQs line are available it doesn't mean that for instance Safety
Feature IRQs too. So it's better to rely on the glue drivers to set
that flag as before and leave the code as is.

-Serge(y) 

>  
>  	priv->dev->irq = res->irq;
>  	priv->wol_irq = res->wol_irq;
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index dee5ad6e48c5..b950e6f9761d 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -98,7 +98,7 @@ struct stmmac_dma_cfg {
>  	int mixed_burst;
>  	bool aal;
>  	bool eame;
> -	bool multi_msi_en;
> +	bool multi_irq_en;
>  	bool dche;
>  };
>  
> @@ -215,7 +215,7 @@ struct dwmac4_addrs {
>  #define STMMAC_FLAG_TSO_EN			BIT(4)
>  #define STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP	BIT(5)
>  #define STMMAC_FLAG_VLAN_FAIL_Q_EN		BIT(6)
> -#define STMMAC_FLAG_MULTI_MSI_EN		BIT(7)
> +#define STMMAC_FLAG_MULTI_IRQ_EN		BIT(7)
>  #define STMMAC_FLAG_EXT_SNAPSHOT_EN		BIT(8)
>  #define STMMAC_FLAG_INT_SNAPSHOT_EN		BIT(9)
>  #define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(10)
> -- 
> 2.34.1
> 
> 

