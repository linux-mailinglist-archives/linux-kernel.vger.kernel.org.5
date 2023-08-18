Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287E57810B7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378687AbjHRQoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378830AbjHRQnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:43:51 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B753C2D;
        Fri, 18 Aug 2023 09:43:27 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ff8f2630e3so1748128e87.1;
        Fri, 18 Aug 2023 09:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692376992; x=1692981792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oYtXL0NSPo2Sx9mZURNXbPMFWhwK0lv2QJZL2BTRUR4=;
        b=qSJtTnZdvdHBXYcPooneO8b/Ois76IP5qr2V0N+pftktfru7hy/+IqaQOH36SIFBcq
         /FRBqwVcmGy9mAcp9yxq7Ve6tILFgFEnoMG/qDpjlZQJdeWabDW0jW3/h9pEcmTDW2jL
         acb2LtP0RZ3yYT/1ffiu303p+l6MfYtjpPipJZtHUnD92sqRPRNk/+PgCCGZks1GSViE
         +EDZL2eXeNGtixTYeG4JJMGCEV82Qg6I7IdXFQPjCQWeHZ/HhmCKC9hX8cUwoVWnIrmM
         XE0nC1nN1lbBqaYkRhfA4IgoN/SHLxMuYqT6LfZe/AuFpscEc77j3V3fNncVauzd5Ass
         zapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692376992; x=1692981792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYtXL0NSPo2Sx9mZURNXbPMFWhwK0lv2QJZL2BTRUR4=;
        b=GHrm9+e7cb0Ogwp9xkTD1PRdzdyCxCA7iNkoPRsB7+DDq8IkGKRffAngNb1lIXMDgo
         EgVFnMhOnNQWGDWp5479Hiv8gtbxzFyB/ovy+DtOMW/N64GQ1kS0qf5VB9DgT/kNPpcY
         j1tCYD+CbuLPmjEiPxu8V4H98lXhh/aLiOovibFyLFRhjPqYUVUzytbu5/qPLJ5vjH1L
         o2UTafk2ixRwb9uIZcBwyVRnpS98Ei+jjgZqCWhm8qFAVz9IeL3f/iS/Attsl9a9S60M
         h+ldbifMQCXXXt9f38L9eQN23rEI4qtUIpORMuz7iKP/61EsxOJwhSrGTMLbQYFRghSI
         TXow==
X-Gm-Message-State: AOJu0YyLeY8DnL82xU2FLQV//VSPYIIOlFxEZ0iI0N7Ng96R8VWlLD9H
        9WF+HEzINqkEo1Yv9FwLTIc=
X-Google-Smtp-Source: AGHT+IGAin2MuYLMw4/ElZJGC5Y7V0/Bh6UYFLMRHQ0asjIQ5A5+tP96g/fElaSRBVDsPKv9acRDMQ==
X-Received: by 2002:a05:6512:2391:b0:4fb:9168:1fce with SMTP id c17-20020a056512239100b004fb91681fcemr2747631lfv.59.1692376992068;
        Fri, 18 Aug 2023 09:43:12 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id w14-20020a19c50e000000b004fbb610c354sm414084lfe.0.2023.08.18.09.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 09:43:11 -0700 (PDT)
Date:   Fri, 18 Aug 2023 19:43:09 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v5 4/9] net: stmmac: reflect multi irqs for
 tx/rx channels and mac and safety
Message-ID: <qowgzrratv3xpjavyjlht4fhz3kviifzcznmnftenzactvldcp@l4nzozjltmty>
References: <20230817165749.672-1-jszhang@kernel.org>
 <20230817165749.672-5-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817165749.672-5-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 12:57:44AM +0800, Jisheng Zhang wrote:
> The IP supports per channel interrupt, when intel adds the per channel
> interrupt support, the per channel irq is from MSI vector, but this
> feature can also be supported on non-MSI platforms. Do some necessary
> renaming to reflects this fact.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-intel.c |  4 +-
>  .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |  2 +-
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 48 +++++++++----------
>  include/linux/stmmac.h                        |  4 +-
>  4 files changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> index 979c755964b1..9050de31ed76 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
> @@ -952,7 +952,7 @@ static int stmmac_config_single_msi(struct pci_dev *pdev,
>  
>  	res->irq = pci_irq_vector(pdev, 0);
>  	res->wol_irq = res->irq;
> -	plat->flags &= ~STMMAC_FLAG_MULTI_MSI_EN;
> +	plat->flags &= ~STMMAC_FLAG_PERCH_IRQ_EN;
>  	dev_info(&pdev->dev, "%s: Single IRQ enablement successful\n",
>  		 __func__);
>  
> @@ -1004,7 +1004,7 @@ static int stmmac_config_multi_msi(struct pci_dev *pdev,
>  	if (plat->msi_sfty_ue_vec < STMMAC_MSI_VEC_MAX)
>  		res->sfty_ue_irq = pci_irq_vector(pdev, plat->msi_sfty_ue_vec);
>  
> -	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
> +	plat->flags |= STMMAC_FLAG_PERCH_IRQ_EN;
>  	dev_info(&pdev->dev, "%s: multi MSI enablement successful\n", __func__);
>  
>  	return 0;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> index 84d3a8551b03..9bf8adf466a2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
> @@ -175,7 +175,7 @@ static void dwmac4_dma_init(void __iomem *ioaddr,
>  
>  	value = readl(ioaddr + DMA_BUS_MODE);
>  
> -	if (dma_cfg->multi_msi_en) {
> +	if (dma_cfg->perch_irq_en) {
>  		value &= ~DMA_BUS_MODE_INTM_MASK;
>  		value |= (DMA_BUS_MODE_INTM_MODE1 << DMA_BUS_MODE_INTM_SHIFT);
>  	}
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 3d90ca983389..64c55024d69d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -126,11 +126,11 @@ module_param(chain_mode, int, 0444);
>  MODULE_PARM_DESC(chain_mode, "To use chain instead of ring mode");
>  
>  static irqreturn_t stmmac_interrupt(int irq, void *dev_id);
> -/* For MSI interrupts handling */
> +/* For multi channel interrupts handling */
>  static irqreturn_t stmmac_mac_interrupt(int irq, void *dev_id);
>  static irqreturn_t stmmac_safety_interrupt(int irq, void *dev_id);

> -static irqreturn_t stmmac_msi_intr_tx(int irq, void *data);
> -static irqreturn_t stmmac_msi_intr_rx(int irq, void *data);

What about

+static irqreturn_t stmmac_tx_queue_interrupt(int irq, void *data);
+static irqreturn_t stmmac_rx_queue_interrupt(int irq, void *data);

to have the names similar to stmmac_mac_interrupt() and
stmmac_safety_interrupt().

BTW are you aware that the IRQs in subject are actually
per-DMA-channel interrupts, not per-MTL-queue interrupts?

>  static void stmmac_reset_rx_queue(struct stmmac_priv *priv, u32 queue);
>  static void stmmac_reset_tx_queue(struct stmmac_priv *priv, u32 queue);
>  static void stmmac_reset_queues_param(struct stmmac_priv *priv);
> @@ -3520,7 +3520,7 @@ static void stmmac_free_irq(struct net_device *dev,
>  	}
>  }
>  

> -static int stmmac_request_irq_multi_msi(struct net_device *dev)
> +static int stmmac_request_irq_multi_channel(struct net_device *dev)

What about stmmac_request_irq_perch() to shorten out the name and have
a unified "perch" suffix like in the flag STMMAC_FLAG_PERCH_IRQ_EN?

-Serge(y)

>  {
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  	enum request_irq_err irq_err;
> @@ -3537,7 +3537,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>  			  0, int_name, dev);
>  	if (unlikely(ret < 0)) {
>  		netdev_err(priv->dev,
> -			   "%s: alloc mac MSI %d (error: %d)\n",
> +			   "%s: alloc mac irq %d (error: %d)\n",
>  			   __func__, dev->irq, ret);
>  		irq_err = REQ_IRQ_ERR_MAC;
>  		goto irq_error;
> @@ -3554,7 +3554,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>  				  0, int_name, dev);
>  		if (unlikely(ret < 0)) {
>  			netdev_err(priv->dev,
> -				   "%s: alloc wol MSI %d (error: %d)\n",
> +				   "%s: alloc wol irq %d (error: %d)\n",
>  				   __func__, priv->wol_irq, ret);
>  			irq_err = REQ_IRQ_ERR_WOL;
>  			goto irq_error;
> @@ -3572,7 +3572,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>  				  0, int_name, dev);
>  		if (unlikely(ret < 0)) {
>  			netdev_err(priv->dev,
> -				   "%s: alloc lpi MSI %d (error: %d)\n",
> +				   "%s: alloc lpi irq %d (error: %d)\n",
>  				   __func__, priv->lpi_irq, ret);
>  			irq_err = REQ_IRQ_ERR_LPI;
>  			goto irq_error;
> @@ -3590,7 +3590,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>  				  0, int_name, dev);
>  		if (unlikely(ret < 0)) {
>  			netdev_err(priv->dev,
> -				   "%s: alloc sfty ce MSI %d (error: %d)\n",
> +				   "%s: alloc sfty ce irq %d (error: %d)\n",
>  				   __func__, priv->sfty_ce_irq, ret);
>  			irq_err = REQ_IRQ_ERR_SFTY_CE;
>  			goto irq_error;
> @@ -3608,14 +3608,14 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>  				  0, int_name, dev);
>  		if (unlikely(ret < 0)) {
>  			netdev_err(priv->dev,
> -				   "%s: alloc sfty ue MSI %d (error: %d)\n",
> +				   "%s: alloc sfty ue irq %d (error: %d)\n",
>  				   __func__, priv->sfty_ue_irq, ret);
>  			irq_err = REQ_IRQ_ERR_SFTY_UE;
>  			goto irq_error;
>  		}
>  	}
>  
> -	/* Request Rx MSI irq */
> +	/* Request Rx queue irq */
>  	for (i = 0; i < priv->plat->rx_queues_to_use; i++) {
>  		if (i >= MTL_MAX_RX_QUEUES)
>  			break;
> @@ -3625,11 +3625,11 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>  		int_name = priv->int_name_rx_irq[i];
>  		sprintf(int_name, "%s:%s-%d", dev->name, "rx", i);
>  		ret = request_irq(priv->rx_irq[i],
> -				  stmmac_msi_intr_rx,
> +				  stmmac_queue_intr_rx,
>  				  0, int_name, &priv->dma_conf.rx_queue[i]);
>  		if (unlikely(ret < 0)) {
>  			netdev_err(priv->dev,
> -				   "%s: alloc rx-%d  MSI %d (error: %d)\n",
> +				   "%s: alloc rx-%d irq %d (error: %d)\n",
>  				   __func__, i, priv->rx_irq[i], ret);
>  			irq_err = REQ_IRQ_ERR_RX;
>  			irq_idx = i;
> @@ -3640,7 +3640,7 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>  		irq_set_affinity_hint(priv->rx_irq[i], &cpu_mask);
>  	}
>  
> -	/* Request Tx MSI irq */
> +	/* Request Tx queue irq */
>  	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
>  		if (i >= MTL_MAX_TX_QUEUES)
>  			break;
> @@ -3650,11 +3650,11 @@ static int stmmac_request_irq_multi_msi(struct net_device *dev)
>  		int_name = priv->int_name_tx_irq[i];
>  		sprintf(int_name, "%s:%s-%d", dev->name, "tx", i);
>  		ret = request_irq(priv->tx_irq[i],
> -				  stmmac_msi_intr_tx,
> +				  stmmac_queue_intr_tx,
>  				  0, int_name, &priv->dma_conf.tx_queue[i]);
>  		if (unlikely(ret < 0)) {
>  			netdev_err(priv->dev,
> -				   "%s: alloc tx-%d  MSI %d (error: %d)\n",
> +				   "%s: alloc tx-%d irq %d (error: %d)\n",
>  				   __func__, i, priv->tx_irq[i], ret);
>  			irq_err = REQ_IRQ_ERR_TX;
>  			irq_idx = i;
> @@ -3729,8 +3729,8 @@ static int stmmac_request_irq(struct net_device *dev)
>  	int ret;
>  
>  	/* Request the IRQ lines */
> -	if (priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN)
> -		ret = stmmac_request_irq_multi_msi(dev);
> +	if (priv->plat->flags & STMMAC_FLAG_PERCH_IRQ_EN)
> +		ret = stmmac_request_irq_multi_channel(dev);
>  	else
>  		ret = stmmac_request_irq_single(dev);
>  
> @@ -5945,7 +5945,7 @@ static irqreturn_t stmmac_safety_interrupt(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static irqreturn_t stmmac_msi_intr_tx(int irq, void *data)
> +static irqreturn_t stmmac_queue_intr_tx(int irq, void *data)
>  {
>  	struct stmmac_tx_queue *tx_q = (struct stmmac_tx_queue *)data;
>  	struct stmmac_dma_conf *dma_conf;
> @@ -5977,7 +5977,7 @@ static irqreturn_t stmmac_msi_intr_tx(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -static irqreturn_t stmmac_msi_intr_rx(int irq, void *data)
> +static irqreturn_t stmmac_queue_intr_rx(int irq, void *data)
>  {
>  	struct stmmac_rx_queue *rx_q = (struct stmmac_rx_queue *)data;
>  	struct stmmac_dma_conf *dma_conf;
> @@ -6014,12 +6014,12 @@ static void stmmac_poll_controller(struct net_device *dev)
>  	if (test_bit(STMMAC_DOWN, &priv->state))
>  		return;
>  
> -	if (priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN) {
> +	if (priv->plat->flags & STMMAC_FLAG_PERCH_IRQ_EN) {
>  		for (i = 0; i < priv->plat->rx_queues_to_use; i++)
> -			stmmac_msi_intr_rx(0, &priv->dma_conf.rx_queue[i]);
> +			stmmac_queue_intr_rx(0, &priv->dma_conf.rx_queue[i]);
>  
>  		for (i = 0; i < priv->plat->tx_queues_to_use; i++)
> -			stmmac_msi_intr_tx(0, &priv->dma_conf.tx_queue[i]);
> +			stmmac_queue_intr_tx(0, &priv->dma_conf.tx_queue[i]);
>  	} else {
>  		disable_irq(dev->irq);
>  		stmmac_interrupt(dev->irq, dev);
> @@ -7300,8 +7300,8 @@ int stmmac_dvr_probe(struct device *device,
>  	priv->plat = plat_dat;
>  	priv->ioaddr = res->addr;
>  	priv->dev->base_addr = (unsigned long)res->addr;
> -	priv->plat->dma_cfg->multi_msi_en =
> -		(priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN);
> +	priv->plat->dma_cfg->perch_irq_en =
> +		(priv->plat->flags & STMMAC_FLAG_PERCH_IRQ_EN);
>  
>  	priv->dev->irq = res->irq;
>  	priv->wol_irq = res->wol_irq;
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 9c90e2e295d4..c052c222fa3e 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -98,7 +98,7 @@ struct stmmac_dma_cfg {
>  	int mixed_burst;
>  	bool aal;
>  	bool eame;
> -	bool multi_msi_en;
> +	bool perch_irq_en;
>  	bool dche;
>  };
>  
> @@ -213,7 +213,7 @@ struct dwmac4_addrs {
>  #define STMMAC_FLAG_TSO_EN			BIT(4)
>  #define STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP	BIT(5)
>  #define STMMAC_FLAG_VLAN_FAIL_Q_EN		BIT(6)
> -#define STMMAC_FLAG_MULTI_MSI_EN		BIT(7)
> +#define STMMAC_FLAG_PERCH_IRQ_EN		BIT(7)
>  #define STMMAC_FLAG_EXT_SNAPSHOT_EN		BIT(8)
>  #define STMMAC_FLAG_INT_SNAPSHOT_EN		BIT(9)
>  #define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(10)
> -- 
> 2.40.1
> 
> 
