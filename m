Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D941C78114E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345588AbjHRRKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378922AbjHRRK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:10:28 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A04C3C2D;
        Fri, 18 Aug 2023 10:10:26 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe85fd3d27so1810294e87.0;
        Fri, 18 Aug 2023 10:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692378625; x=1692983425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qZncaXQLSh9js0I4WjpTSahy4Bvx67wGvUaNA9X9QL4=;
        b=mWiVtgsWZW2NgtZV2B1VWpSdYomDbnE5IM3I8NwhrcqW1ICl6KDFCrHBvLEuRWsiw4
         h68dv3P2mof7Uvn0W27wQKaU+szILp/iQk+ZZ7NCHMVhJhaaxYk1+a6IgcFBFaY8cReV
         hvVjg6Cg+nEmYiod4CbK7H4JM4/8z4fuiu3u9xolueCbV5aqABwD/8/5V7g2I2feoYCR
         G5ILCR+KA5LzRYlbIJJR4nNGFEdPFRL7j0QSshp/zTF4GjzyaXgW7MjbGUrCcX5PuhQv
         Ye3hwRCyudxym7NAyPZZLQ5am6U3HSWki/kp7aWRPkMXCwRq46p0gkXyFdFG+B5oJG4d
         a9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692378625; x=1692983425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZncaXQLSh9js0I4WjpTSahy4Bvx67wGvUaNA9X9QL4=;
        b=Qozq4dgkE4kcxKEk2ycHumjRQ/xLNoZg6VwmiWfVEIZ355q82sRmczw+rK/9rGHwrQ
         UHUH3UU81Mbc2zh0ZsZzdiNIVFA8q1dZVctsW6ekri3yhpwZXP/tJLQTO1aw6kkxew8q
         bRZrUo42bG8dM4lma+pjnpY+3tSSnu61BvmXuMmMufWwm09gMulrcnyh8yeUzQhWW5MW
         mZQGYJ9ErPJ2P9qtMtJKwBUgGe/tSZVdnvY8U+wqv9k8kb+lpK4Iam715jH/5Lsq0oUQ
         rR3b27dvZCS5Nq/Xv6geJVIvuPTLmY38BV0VncwFZbMEamILgEkv8s3DaEO6VAsmbv36
         bXrQ==
X-Gm-Message-State: AOJu0Ywn/Nxtj7Sar8VjLZpWCWDICumAgzrhYVbz9wqNtd32ePTcT389
        px6NIgzgZFHs1ACj3kMrQgI=
X-Google-Smtp-Source: AGHT+IHsEr3WOE514VOmtMPl7fzHNR2vgMsIyU//tQb/ScBsu4i9rGSZix1w2kzZUdJX/qwEfDWk5Q==
X-Received: by 2002:a05:6512:477:b0:4f8:49a7:2deb with SMTP id x23-20020a056512047700b004f849a72debmr2118416lfd.8.1692378624613;
        Fri, 18 Aug 2023 10:10:24 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id v20-20020ac25934000000b004faf6a87d63sm417332lfi.38.2023.08.18.10.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 10:10:24 -0700 (PDT)
Date:   Fri, 18 Aug 2023 20:10:21 +0300
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
Subject: Re: [PATCH net-next v5 5/9] net: stmmac: xgmac: support per-channel
 irq
Message-ID: <k57laovdsomy4eblyu5neujkkcqinitfmdvojcph3zh2ygn4jt@iton4m73y6nz>
References: <20230817165749.672-1-jszhang@kernel.org>
 <20230817165749.672-6-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817165749.672-6-jszhang@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 12:57:45AM +0800, Jisheng Zhang wrote:
> The IP supports per channel interrupt, add support for this usage case.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  2 ++
>  .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 33 +++++++++++--------
>  2 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> index 7f68bef456b7..18a042834d75 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -340,6 +340,8 @@
>  
>  /* DMA Registers */
>  #define XGMAC_DMA_MODE			0x00003000
> +#define XGMAC_INTM			GENMASK(13, 12)
> +#define XGMAC_INTM_MODE1		0x1
>  #define XGMAC_SWR			BIT(0)
>  #define XGMAC_DMA_SYSBUS_MODE		0x00003004
>  #define XGMAC_WR_OSR_LMT		GENMASK(29, 24)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> index 1ef8fc132c2d..ce228c362403 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> @@ -31,6 +31,13 @@ static void dwxgmac2_dma_init(void __iomem *ioaddr,
>  		value |= XGMAC_EAME;
>  
>  	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
> +
> +	if (dma_cfg->perch_irq_en) {
> +		value = readl(ioaddr + XGMAC_DMA_MODE);
> +		value &= ~XGMAC_INTM;
> +		value |= FIELD_PREP(XGMAC_INTM, XGMAC_INTM_MODE1);
> +		writel(value, ioaddr + XGMAC_DMA_MODE);
> +	}
>  }
>  
>  static void dwxgmac2_dma_init_chan(struct stmmac_priv *priv,
> @@ -365,20 +372,20 @@ static int dwxgmac2_dma_interrupt(struct stmmac_priv *priv,
>  	}
>  
>  	/* TX/RX NORMAL interrupts */

> -	if (likely(intr_status & XGMAC_NIS)) {
> -		if (likely(intr_status & XGMAC_RI)) {
> -			u64_stats_update_begin(&rx_q->rxq_stats.syncp);
> -			rx_q->rxq_stats.rx_normal_irq_n++;
> -			u64_stats_update_end(&rx_q->rxq_stats.syncp);
> -			ret |= handle_rx;
> -		}
> -		if (likely(intr_status & (XGMAC_TI | XGMAC_TBU))) {
> -			u64_stats_update_begin(&tx_q->txq_stats.syncp);
> -			tx_q->txq_stats.tx_normal_irq_n++;
> -			u64_stats_update_end(&tx_q->txq_stats.syncp);
> -			ret |= handle_tx;
> -		}
> +	if (likely(intr_status & XGMAC_RI)) {
> +		u64_stats_update_begin(&rx_q->rxq_stats.syncp);
> +		rx_q->rxq_stats.rx_normal_irq_n++;
> +		u64_stats_update_end(&rx_q->rxq_stats.syncp);
> +		ret |= handle_rx;
> +	}
> +	if (likely(intr_status & XGMAC_TI)) {
> +		u64_stats_update_begin(&tx_q->txq_stats.syncp);
> +		tx_q->txq_stats.tx_normal_irq_n++;
> +		u64_stats_update_end(&tx_q->txq_stats.syncp);
> +		ret |= handle_tx;
>  	}
> +	if (unlikely(intr_status & XGMAC_TBU))
> +		ret |= handle_tx;

Just curious. Is this change really necessary seeing NIS IRQ is
unmasked and it is unmasked-OR of the RI/TI/TBU flags in the
DMA_CHx_Status register? Moreover based on the HW manual,
DMA_CHx_Status reflects raw IRQ flags status except NIS and AIS which
are the masked OR of the respective flags. So AFAIU NIS will be set in
anyway if you have RI/TI/TBU IRQs enabled.

-Serge(y)

>  
>  	/* Clear interrupts */
>  	writel(intr_en & intr_status, ioaddr + XGMAC_DMA_CH_STATUS(chan));
> -- 
> 2.40.1
> 
> 
