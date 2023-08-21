Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F1E7828BD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbjHUMPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjHUMPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:15:09 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343B5CD;
        Mon, 21 Aug 2023 05:15:07 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso4859635e87.1;
        Mon, 21 Aug 2023 05:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692620105; x=1693224905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=avV2BsJ1FLhhu79KeKfN0Ev+8booIHw8n+ZXD8aCVnA=;
        b=c5jpnXtPZchTfPtdD+NAyZpcNupHdzZV+pD84WcKk8uJIBSzC7W1uWaXcccQNUEBSO
         5RW55hM5m3dVq2HkVNUtqKXqlmOfsNHVAvzchVdF6GZoJQjqJfqs/Gw67knXOYQowLdV
         LdNjX6y0JW92cKc1mOUaxROW1X/wWgR6Of0J268IYa/shHy87Uj+HaWIw7bkl7YgJ39D
         DmQwsSFdoYQfZQmzNRT5HsdjJ6szG4pclaEtD5HxGThVrlPLK54aFQQwsAVVwsFfJurM
         PmgGflAJQjZ+DRQzel2z2SyeMqW14fq2QjNy/KKu8AIe1Ve3cKeB2IcCfFIAWkL/QN1q
         ZEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692620105; x=1693224905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avV2BsJ1FLhhu79KeKfN0Ev+8booIHw8n+ZXD8aCVnA=;
        b=FRk1vUmMDh3lc1a2U1NH6y7TbeiCsICpfDidn+74PRjvafO4ciSjv/GONoPJ8g47YG
         Ph4uxMDyXZOfivhuVSNdos63kdWaaMfLPDtW4+IZQuu+E6dkEOKZzeouoD5xEih5Gat1
         4s6hcnxIH+D0nYWjYDKOOn8eKkZMWetS+/mmNVsPiL+31QypgW191d0NxuR5Qp6KPCOY
         JWsav3kXgom4wleoDgX3xzQ/mdXzs3DQGUWNWgDWuagxUal7QSBmWnHCAjulc/0JFqvc
         ZxJnL50a/7VMFAqgfa57WNQnLS4QDYMGmJFMUcG4inM0rb1ig6N/ZQKIyWCLXUMYsJz+
         xhVw==
X-Gm-Message-State: AOJu0Yy3nQBeeyQbjTnFnDzBcIVmE7o3tGlp48Bb2gJSsKqsIn+SxCJn
        U4XIyvx1zesZB940Yfv/CYk=
X-Google-Smtp-Source: AGHT+IFNc61eHU9PArAyDrvV6DY1c2fksC/mbLMjK3WEsB9bq38x5BVHfXfD69uaWKpqHoHiv+Yn6Q==
X-Received: by 2002:a05:6512:3da0:b0:4fd:faa2:884c with SMTP id k32-20020a0565123da000b004fdfaa2884cmr5901431lfv.29.1692620105055;
        Mon, 21 Aug 2023 05:15:05 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id p28-20020ac246dc000000b004ff9ea1ad91sm1700132lfo.216.2023.08.21.05.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 05:15:04 -0700 (PDT)
Date:   Mon, 21 Aug 2023 15:15:02 +0300
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
Subject: Re: [PATCH net-next v5 2/2] net: stmmac: Tx coe sw fallback
Message-ID: <yayy6d3zfewgljwstunyl44qgsco3t5kdipbbb2sibx65honva@jobrmiqnhnhx>
References: <20230819023132.23082-1-rohan.g.thomas@intel.com>
 <20230819023132.23082-3-rohan.g.thomas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819023132.23082-3-rohan.g.thomas@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 10:31:32AM +0800, Rohan G Thomas wrote:
> Add sw fallback of tx checksum calculation for those tx queues that
> don't support tx checksum offloading. Because, some DWMAC IPs support
> tx checksum offloading only for a few initial tx queues, starting
> from tx queue 0.
> 
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>

LGTM,
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 ++++++++++++++++++
>  .../ethernet/stmicro/stmmac/stmmac_platform.c  |  4 ++++
>  include/linux/stmmac.h                         |  1 +
>  3 files changed, 23 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 733b5e900817..3ffef45a2861 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4409,6 +4409,16 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>  	WARN_ON(tx_q->tx_skbuff[first_entry]);
>  
>  	csum_insertion = (skb->ip_summed == CHECKSUM_PARTIAL);
> +	/* Some DWMAC IPs support tx coe only for a few initial tx queues,
> +	 * starting from tx queue 0. So checksum offloading for those queues
> +	 * that don't support tx coe needs to fallback to software checksum
> +	 * calculation.
> +	 */
> +	if (csum_insertion && queue >= priv->plat->tx_queues_with_coe) {
> +		if (unlikely(skb_checksum_help(skb)))
> +			goto dma_map_err;
> +		csum_insertion = !csum_insertion;
> +	}
>  
>  	if (likely(priv->extend_desc))
>  		desc = (struct dma_desc *)(tx_q->dma_etx + entry);
> @@ -7401,6 +7411,14 @@ int stmmac_dvr_probe(struct device *device,
>  		dev_info(priv->device, "SPH feature enabled\n");
>  	}
>  
> +	if (priv->plat->tx_coe && !priv->plat->tx_queues_with_coe)
> +		priv->plat->tx_queues_with_coe = priv->plat->tx_queues_to_use;
> +	else if (!priv->plat->tx_coe)
> +		priv->plat->tx_queues_with_coe = 0;
> +	else if (priv->plat->tx_queues_with_coe < priv->plat->tx_queues_to_use)
> +		dev_info(priv->device, "TX COE only available for %u queues\n",
> +			 priv->plat->tx_queues_with_coe);
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
