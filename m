Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC03C7812C5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379412AbjHRSU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 14:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241209AbjHRSUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:20:05 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29A012A;
        Fri, 18 Aug 2023 11:20:03 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4ff9bbc83a5so1743192e87.1;
        Fri, 18 Aug 2023 11:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692382802; x=1692987602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E8CxnfReoMP8+uynZ3PaiswXkll6MQ1QWbgzzSuo5uI=;
        b=M90Axk+SC7+eqj0O+eFZe4ZVw5wCvO6kuQZG2fA5Lkw8jX9tMaL0Xs8dYbUbomfJBO
         N532nXeYInk9qFyMDAx1u91lk83bkBUEihVePgrK+mxHFA8Bc7EtHwn0VoF+JQvbCHwp
         lqX27qrC4fmWbGRYb6ndSFcRce4os1zneM6CKwvHIU+wM0e8pl2UC005XwuTZ2Z/EMsP
         KONqjFqK2Lf6DTtgV2/j4NRcPY0EihUqq+CkaQWUuu24gzBNRlqfulVkVvSQuExcUIzP
         oyg3jtWS1cJGwFLwtb4qwEV5/xjaEyKSvvhxbiZzmoO0jsP2q4rRmXsIQ4JIUN+ZGmmf
         dMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692382802; x=1692987602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8CxnfReoMP8+uynZ3PaiswXkll6MQ1QWbgzzSuo5uI=;
        b=bESHuqYfVBljEQhfM3Cv1suepFdvBSVvVkWXUCtkRS+84shI9ok/4hf1z05UIIdlkj
         1taa9g9wkdmz2YXvAN7ONA/uj87y7B7YS+aLJymDty9QjBcVOyzRU0doJM9AOGboBXPY
         5hi7boiZZ3m4/P58PC8nh2YkOqF2kHkkZvpp56R07PnUjlhJXeYAF6BJ4j/sR6/UJbzG
         7A878+yjrVDai2aFJVW8EYIJyd1WftLCJU6+Sx3NPKqtB5yvIXATdVfU7c1oL63JcGFo
         1E/p0GEV0s2D4+pdwy7MmfuqGWin7SWZ+pxfKYPVUMzV1o6s5PuW5leB4y7ZtGgk6eWw
         W3TQ==
X-Gm-Message-State: AOJu0YyCt9xc22gi/1Uab9LTd4na8x8+SUtNnyQyHwUTXuHMCXuRBY2x
        c/xntrBPvhR0V3wRp48bRj0LxSJnOJdkSg==
X-Google-Smtp-Source: AGHT+IE6pOb2aA6c9i0JOYlkYdU8iBBET0RocIW9RhWyDSrjfOd6FnBxlnddWEtRiITAyhWfSwz/Pw==
X-Received: by 2002:a19:5019:0:b0:4f9:556b:93c4 with SMTP id e25-20020a195019000000b004f9556b93c4mr2281962lfb.31.1692382801675;
        Fri, 18 Aug 2023 11:20:01 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id o9-20020a05651238a900b004fe15a2f0f6sm440762lft.62.2023.08.18.11.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 11:20:01 -0700 (PDT)
Date:   Fri, 18 Aug 2023 21:19:59 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rohan G Thomas <rohan.g.thomas@intel.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/2] net: stmmac: Tx coe sw fallback
Message-ID: <trcp4f77dv2e36zpe53s7sjoyevgd5qtpv6m4a75ryalglqnev@trcsnsmvtijy>
References: <20230818135350.12474-1-rohan.g.thomas@intel.com>
 <20230818135350.12474-3-rohan.g.thomas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818135350.12474-3-rohan.g.thomas@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 09:53:50PM +0800, Rohan G Thomas wrote:
> Add sw fallback of tx checksum calculation for those tx queues that
> don't support tx checksum offloading. Because, some DWMAC IPs support
> tx checksum offloading only for a few initial tx queues, starting
> from tx queue 0.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  5 +++++
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 19 +++++++++++++++++++
>  .../ethernet/stmicro/stmmac/stmmac_platform.c |  4 ++++
>  include/linux/stmmac.h                        |  1 +
>  4 files changed, 29 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index 3401e888a9f6..64d7dbe474bd 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -210,12 +210,17 @@ struct stmmac_dma_conf {
>  	unsigned int dma_tx_size;
>  };
>  
> +#define STMMAC_PRIV_FLG_TXQ_COE_LIMIT	BIT(0)
> +
>  struct stmmac_priv {
>  	/* Frequently used values are kept adjacent for cache effect */
>  	u32 tx_coal_frames[MTL_MAX_TX_QUEUES];
>  	u32 tx_coal_timer[MTL_MAX_TX_QUEUES];
>  	u32 rx_coal_frames[MTL_MAX_TX_QUEUES];
>  

> +	u32 flags;

This looks redundant. See my last comment.

> +

> +	u32 tx_q_with_coe;

This one too. Can't you just use the
plat_stmmacenet_data.tx_queues_with_coe field?

>  	int hwts_tx_en;
>  	bool tx_path_in_lpi_mode;
>  	bool tso;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 733b5e900817..f9ab6635218c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4409,6 +4409,17 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>  	WARN_ON(tx_q->tx_skbuff[first_entry]);
>  
>  	csum_insertion = (skb->ip_summed == CHECKSUM_PARTIAL);
> +	/* Some DWMAC IPs support tx coe only for a few initial tx queues,
> +	 * starting from tx queue 0. So checksum offloading for those queues
> +	 * that don't support tx coe needs to fallback to software checksum
> +	 * calculation.
> +	 */

> +	if (csum_insertion && (priv->flags & STMMAC_PRIV_FLG_TXQ_COE_LIMIT) &&
> +	    queue >= priv->tx_q_with_coe) {
> +		if (unlikely(skb_checksum_help(skb)))
> +			goto dma_map_err;
> +		csum_insertion = !csum_insertion;
> +	}

just (csum_insertion && queue >= priv->plat->tx_queues_with_coe). See
further what to do for this to work as I suggested.

>  
>  	if (likely(priv->extend_desc))
>  		desc = (struct dma_desc *)(tx_q->dma_etx + entry);
> @@ -7401,6 +7412,14 @@ int stmmac_dvr_probe(struct device *device,
>  		dev_info(priv->device, "SPH feature enabled\n");
>  	}
>  

> +	if (priv->plat->tx_coe &&
> +	    priv->plat->tx_queues_with_coe < priv->plat->tx_queues_to_use) {
> +		priv->flags |= STMMAC_PRIV_FLG_TXQ_COE_LIMIT;
> +		priv->tx_q_with_coe = priv->plat->tx_queues_with_coe;
> +		dev_info(priv->device, "TX COE limited to %u tx queues\n",
> +			 priv->tx_q_with_coe);
> +	}

What about:
+	if (priv->plat->tx_coe && !priv->plat->tx_queues_with_coe)
+		priv->plat->tx_queues_with_coe = priv->plat->tx_queues_to_use;
+	else if (!priv->plat->tx_coe)
+		priv->plat->tx_queues_with_coe = 0;
+	else if (priv->plat->tx_queues_with_coe < priv->plat->tx_queues_to_use)
+		dev_info(priv->device, "TX COE is available for %u queues\n", priv->plat->tx_queues_with_coe);

?

-Serge(y)

> +
>  	/* Ideally our host DMA address width is the same as for the
>  	 * device. However, it may differ and then we have to use our
>  	 * host DMA width for allocation and the device DMA width for
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index be8e79c7aa34..0138b7c9c7ab 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -225,6 +225,10 @@ static int stmmac_mtl_setup(struct platform_device *pdev,
>  				 &plat->tx_queues_to_use))
>  		plat->tx_queues_to_use = 1;
>  
> +	if (of_property_read_u32(tx_node, "snps,tx-queues-with-coe",
> +				 &plat->tx_queues_with_coe))
> +		plat->tx_queues_with_coe = plat->tx_queues_to_use;
> +
>  	if (of_property_read_bool(tx_node, "snps,tx-sched-wrr"))
>  		plat->tx_sched_algorithm = MTL_TX_ALGORITHM_WRR;
>  	else if (of_property_read_bool(tx_node, "snps,tx-sched-wfq"))
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 784277d666eb..cb508164eaea 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -252,6 +252,7 @@ struct plat_stmmacenet_data {
>  	u32 host_dma_width;
>  	u32 rx_queues_to_use;
>  	u32 tx_queues_to_use;
> +	u32 tx_queues_with_coe;
>  	u8 rx_sched_algorithm;
>  	u8 tx_sched_algorithm;
>  	struct stmmac_rxq_cfg rx_queues_cfg[MTL_MAX_RX_QUEUES];
> -- 
> 2.19.0
> 
> 
