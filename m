Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7F17F9D53
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjK0KUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbjK0KUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:20:53 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A1FDC;
        Mon, 27 Nov 2023 02:20:58 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c871d566cfso44541351fa.3;
        Mon, 27 Nov 2023 02:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701080457; x=1701685257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ExvmcaBmtMG79z7Iqahkd4y5Qc/HJbGcEwVPJT9+anc=;
        b=MZFgS3HsGu8hN02OnrAD739hjZvUo5bbZ+zb+pjcWaoRAVPzI/vez81M3Dq/aL52y/
         rX9RzmKgZWAphXp56ihKR01nnESRb8zrjQLlvw6cdMQUfoImu0JtkIYnLvWHyijeiGEJ
         zUUliPlKG8RN8T/hPq6Ro6HgKt6C1Ot3Vy9dFVeSFo0AITIzNyh9yF1hqN2B3i3ywylk
         aw6rMcou68i7MoMyHM8u6TF+rOr232NL1igxGwcV/qe065MCGesNXosrPxuw8RaU7RDY
         spyaEQWjjcX1GvQlHjcBZSSkN3h9mmSPqTdAa/QWLure719y+Ai+/KQOdJqQZs0t3JxW
         6UdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701080457; x=1701685257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExvmcaBmtMG79z7Iqahkd4y5Qc/HJbGcEwVPJT9+anc=;
        b=skhKKdixggFnKI8TdIV7Xc7D07kn/ztKlshMEm1CPjTcoENM7P6D8xatUQHyTdAxfH
         BnKKKyqX3uhXJqpbNdx98TnrsicMHJwzYhpWegrVesVhkYd4YbGuAyKsbcha7LrZbwKN
         hPwCtA4WUxgxOdE4VgjSCHgnICr+GD7rjclCydj066nXMKJ5vSH5d5lZK6uxBSqZBRy0
         A2Fl5svV1pvC7JbxOvP//SnEHv2VODY314Jl8yZKUPP6Z9Qe9no3vsj1oUsqsJj0RH/l
         DMmZ1Z2/CVMBy3pNfAeBFy9Yfyi89Ay8/suwxXtlXfNiU8eQYGiLv+AToepjllF5srJx
         baqg==
X-Gm-Message-State: AOJu0YxHHwuEhCAaprWCG0ZItmeJPPTxs1Bk9YIBci2mMGos09OPi6x5
        tXmcKp0cg73/cQER2lbgGa9aF/dqrhh0ig==
X-Google-Smtp-Source: AGHT+IHFvU38B/KUK8EW7W2GDlIJK1kT3L7x6bHmk5zwGmADxT7yj2QOJsgIHXtc/tzPluuHkK/V1A==
X-Received: by 2002:a2e:b74c:0:b0:2c9:a707:beb0 with SMTP id k12-20020a2eb74c000000b002c9a707beb0mr837832ljo.3.1701080456752;
        Mon, 27 Nov 2023 02:20:56 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id z26-20020a2eb53a000000b002bba2da7955sm1305573ljm.132.2023.11.27.02.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 02:20:56 -0800 (PST)
Date:   Mon, 27 Nov 2023 13:20:53 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jianheng Zhang <Jianheng.Zhang@synopsys.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Johannes Zink <j.zink@pengutronix.de>,
        "Russell King (Oracle" <rmk+kernel@armlinux.org.uk>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Mohammad Athari Bin Ismail <mohammad.athari.ismail@intel.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        Tan Tee Min <tee.min.tan@intel.com>,
        "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Martin McKenny <Martin.McKenny@synopsys.com>,
        James Li <James.Li1@synopsys.com>
Subject: Re: [PATCH v2] net: stmmac: fix FPE events losing
Message-ID: <mpapy5qi6q5wfyblhtroqtggqtdfxrh5czkhbgabqdyy4m7ini@s5zwmr457252>
References: <CY5PR12MB637218C74342CCAF7AFCB85FBFBDA@CY5PR12MB6372.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY5PR12MB637218C74342CCAF7AFCB85FBFBDA@CY5PR12MB6372.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianheng

On Mon, Nov 27, 2023 at 07:08:17AM +0000, Jianheng Zhang wrote:
> 
> The status bits of register MAC_FPE_CTRL_STS are clear on read. Using
> 32-bit read for MAC_FPE_CTRL_STS in dwmac5_fpe_configure() and
> dwmac5_fpe_send_mpacket() clear the status bits. Then the stmmac interrupt
> handler missing FPE event status and leads to FPE handshaking failure and
> retries.
> To avoid clear status bits of MAC_FPE_CTRL_STS in dwmac5_fpe_configure()
> and dwmac5_fpe_send_mpacket(), add fpe_csr to stmmac_fpe_cfg structure to
> cache the control bits of MAC_FPE_CTRL_STS and to avoid reading
> MAC_FPE_CTRL_STS in those methods.
> 
> Fixes: 5a5586112b92 ("net: stmmac: support FPE link partner hand-shaking procedure")
> Signed-off-by: jianheng <jianheng@synopsys.com>

Thanks for the fix and taking all my notes and nitpicks into account.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac5.c       | 45 +++++++++-------------
>  drivers/net/ethernet/stmicro/stmmac/dwmac5.h       |  4 +-
>  .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  3 +-
>  drivers/net/ethernet/stmicro/stmmac/hwif.h         |  4 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  8 +++-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    |  1 +
>  include/linux/stmmac.h                             |  1 +
>  7 files changed, 36 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> index e95d35f..8fd1675 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> @@ -710,28 +710,22 @@ void dwmac5_est_irq_status(void __iomem *ioaddr, struct net_device *dev,
>  	}
>  }
>  
> -void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
> +void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
> +			  u32 num_txq, u32 num_rxq,
>  			  bool enable)
>  {
>  	u32 value;
>  
> -	if (!enable) {
> -		value = readl(ioaddr + MAC_FPE_CTRL_STS);
> -
> -		value &= ~EFPE;
> -
> -		writel(value, ioaddr + MAC_FPE_CTRL_STS);
> -		return;
> +	if (enable) {
> +		cfg->fpe_csr = EFPE;
> +		value = readl(ioaddr + GMAC_RXQ_CTRL1);
> +		value &= ~GMAC_RXQCTRL_FPRQ;
> +		value |= (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
> +		writel(value, ioaddr + GMAC_RXQ_CTRL1);
> +	} else {
> +		cfg->fpe_csr = 0;
>  	}
> -
> -	value = readl(ioaddr + GMAC_RXQ_CTRL1);
> -	value &= ~GMAC_RXQCTRL_FPRQ;
> -	value |= (num_rxq - 1) << GMAC_RXQCTRL_FPRQ_SHIFT;
> -	writel(value, ioaddr + GMAC_RXQ_CTRL1);
> -
> -	value = readl(ioaddr + MAC_FPE_CTRL_STS);
> -	value |= EFPE;
> -	writel(value, ioaddr + MAC_FPE_CTRL_STS);
> +	writel(cfg->fpe_csr, ioaddr + MAC_FPE_CTRL_STS);
>  }
>  
>  int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
> @@ -741,6 +735,9 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
>  
>  	status = FPE_EVENT_UNKNOWN;
>  
> +	/* Reads from the MAC_FPE_CTRL_STS register should only be performed
> +	 * here, since the status flags of MAC_FPE_CTRL_STS are "clear on read"
> +	 */
>  	value = readl(ioaddr + MAC_FPE_CTRL_STS);
>  
>  	if (value & TRSP) {
> @@ -766,19 +763,15 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
>  	return status;
>  }
>  
> -void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, enum stmmac_mpacket_type type)
> +void dwmac5_fpe_send_mpacket(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
> +			     enum stmmac_mpacket_type type)
>  {
> -	u32 value;
> +	u32 value = cfg->fpe_csr;
>  
> -	value = readl(ioaddr + MAC_FPE_CTRL_STS);
> -
> -	if (type == MPACKET_VERIFY) {
> -		value &= ~SRSP;
> +	if (type == MPACKET_VERIFY)
>  		value |= SVER;
> -	} else {
> -		value &= ~SVER;
> +	else if (type == MPACKET_RESPONSE)
>  		value |= SRSP;
> -	}
>  
>  	writel(value, ioaddr + MAC_FPE_CTRL_STS);
>  }
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> index 53c138d..34e6207 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> @@ -153,9 +153,11 @@ int dwmac5_est_configure(void __iomem *ioaddr, struct stmmac_est *cfg,
>  			 unsigned int ptp_rate);
>  void dwmac5_est_irq_status(void __iomem *ioaddr, struct net_device *dev,
>  			   struct stmmac_extra_stats *x, u32 txqcnt);
> -void dwmac5_fpe_configure(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
> +void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
> +			  u32 num_txq, u32 num_rxq,
>  			  bool enable);
>  void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
> +			     struct stmmac_fpe_cfg *cfg,
>  			     enum stmmac_mpacket_type type);
>  int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev);
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index 453e88b..a74e71d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -1484,7 +1484,8 @@ static int dwxgmac3_est_configure(void __iomem *ioaddr, struct stmmac_est *cfg,
>  	return 0;
>  }
>  
> -static void dwxgmac3_fpe_configure(void __iomem *ioaddr, u32 num_txq,
> +static void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
> +				   u32 num_txq,
>  				   u32 num_rxq, bool enable)
>  {
>  	u32 value;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index b95d3e1..68aa2d5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -412,9 +412,11 @@ struct stmmac_ops {
>  			     unsigned int ptp_rate);
>  	void (*est_irq_status)(void __iomem *ioaddr, struct net_device *dev,
>  			       struct stmmac_extra_stats *x, u32 txqcnt);
> -	void (*fpe_configure)(void __iomem *ioaddr, u32 num_txq, u32 num_rxq,
> +	void (*fpe_configure)(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
> +			      u32 num_txq, u32 num_rxq,
>  			      bool enable);
>  	void (*fpe_send_mpacket)(void __iomem *ioaddr,
> +				 struct stmmac_fpe_cfg *cfg,
>  				 enum stmmac_mpacket_type type);
>  	int (*fpe_irq_status)(void __iomem *ioaddr, struct net_device *dev);
>  };
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 3e50fd5..7791e9b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -964,7 +964,8 @@ static void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
>  	bool *hs_enable = &fpe_cfg->hs_enable;
>  
>  	if (is_up && *hs_enable) {
> -		stmmac_fpe_send_mpacket(priv, priv->ioaddr, MPACKET_VERIFY);
> +		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
> +					MPACKET_VERIFY);
>  	} else {
>  		*lo_state = FPE_STATE_OFF;
>  		*lp_state = FPE_STATE_OFF;
> @@ -5838,6 +5839,7 @@ static void stmmac_fpe_event_status(struct stmmac_priv *priv, int status)
>  		/* If user has requested FPE enable, quickly response */
>  		if (*hs_enable)
>  			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> +						fpe_cfg,
>  						MPACKET_RESPONSE);
>  	}
>  
> @@ -7262,6 +7264,7 @@ static void stmmac_fpe_lp_task(struct work_struct *work)
>  		if (*lo_state == FPE_STATE_ENTERING_ON &&
>  		    *lp_state == FPE_STATE_ENTERING_ON) {
>  			stmmac_fpe_configure(priv, priv->ioaddr,
> +					     fpe_cfg,
>  					     priv->plat->tx_queues_to_use,
>  					     priv->plat->rx_queues_to_use,
>  					     *enable);
> @@ -7280,6 +7283,7 @@ static void stmmac_fpe_lp_task(struct work_struct *work)
>  			netdev_info(priv->dev, SEND_VERIFY_MPAKCET_FMT,
>  				    *lo_state, *lp_state);
>  			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> +						fpe_cfg,
>  						MPACKET_VERIFY);
>  		}
>  		/* Sleep then retry */
> @@ -7294,6 +7298,7 @@ void stmmac_fpe_handshake(struct stmmac_priv *priv, bool enable)
>  	if (priv->plat->fpe_cfg->hs_enable != enable) {
>  		if (enable) {
>  			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> +						priv->plat->fpe_cfg,
>  						MPACKET_VERIFY);
>  		} else {
>  			priv->plat->fpe_cfg->lo_fpe_state = FPE_STATE_OFF;
> @@ -7754,6 +7759,7 @@ int stmmac_suspend(struct device *dev)
>  	if (priv->dma_cap.fpesel) {
>  		/* Disable FPE */
>  		stmmac_fpe_configure(priv, priv->ioaddr,
> +				     priv->plat->fpe_cfg,
>  				     priv->plat->tx_queues_to_use,
>  				     priv->plat->rx_queues_to_use, false);
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index ac41ef4..6ad3e0a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -1079,6 +1079,7 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
>  
>  	priv->plat->fpe_cfg->enable = false;
>  	stmmac_fpe_configure(priv, priv->ioaddr,
> +			     priv->plat->fpe_cfg,
>  			     priv->plat->tx_queues_to_use,
>  			     priv->plat->rx_queues_to_use,
>  			     false);
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 0b4658a..dee5ad6 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -175,6 +175,7 @@ struct stmmac_fpe_cfg {
>  	bool hs_enable;				/* FPE handshake enable */
>  	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
>  	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
> +	u32 fpe_csr;				/* MAC_FPE_CTRL_STS reg cache */
>  };
>  
>  struct stmmac_safety_feature_cfg {
> -- 
> 1.8.3.1
> 
> 
