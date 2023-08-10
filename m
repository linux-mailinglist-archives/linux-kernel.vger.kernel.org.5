Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83024777B70
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbjHJO5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjHJO5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:57:35 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237E826B2;
        Thu, 10 Aug 2023 07:57:35 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AClMGg009215;
        Thu, 10 Aug 2023 16:57:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=uWaBWJYxBkUNO48/o8MmvLtGPToyy8i14IR+7MRvnVU=; b=ET
        +ak5sm+bza9rbhYKy9OYWDH+7jI8wIfqqW+6gtYW6ArRE2y+T2GH/GDOe1VWpkh0
        uO81R2KumLG1bUdEzD8kG1xM3omWHGheT5TfDQMv4/gjO2M/VeIS5vboHjxlzy7O
        7WwXFuc6JrWh+Vz8iD1+SleOjZ4CX2b8YJ5j84DBIx6aZe5VcwB8AAiUsPoBkOED
        frHc81/92al4zLSYM/q1giJL68niF8nUAPe+MpQ1sODLT7YWrj+klr/45GF8Uw51
        CzRndY8gkqsWpEqutLCcpLYt377IQ1SBT+h9mnoHOv92MAgCfcP66iCHLEGjSqXd
        K0GXH9lKMdicU2T1YRKQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sd0730ph1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 16:57:15 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 92AFF100053;
        Thu, 10 Aug 2023 16:57:01 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 893DA2248B0;
        Thu, 10 Aug 2023 16:57:01 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 10 Aug
 2023 16:57:00 +0200
Message-ID: <43ea0060-ed69-4efe-4a39-224aa67ae9b8@foss.st.com>
Date:   Thu, 10 Aug 2023 16:57:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next v3 10/10] net: stmmac: platform: support parsing
 per channel irq from DT
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230809165007.1439-1-jszhang@kernel.org>
 <20230809165007.1439-11-jszhang@kernel.org>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230809165007.1439-11-jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_12,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 18:50, Jisheng Zhang wrote:
> The snps dwmac IP may support per channel interrupt. Add support to
> parse the per channel irq from DT.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   .../net/ethernet/stmicro/stmmac/stmmac_main.c | 10 ++++----
>   .../ethernet/stmicro/stmmac/stmmac_platform.c | 23 +++++++++++++++++++
>   2 files changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 4ed5c976c7a3..245eeb7d3e83 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3612,7 +3612,7 @@ static int stmmac_request_irq_multi(struct net_device *dev)
>   	for (i = 0; i < priv->plat->rx_queues_to_use; i++) {
>   		if (i >= MTL_MAX_RX_QUEUES)
>   			break;
> -		if (priv->rx_irq[i] == 0)
> +		if (priv->rx_irq[i] <= 0)

What do you fix here ?

>   			continue;
>   
>   		int_name = priv->int_name_rx_irq[i];
> @@ -3637,7 +3637,7 @@ static int stmmac_request_irq_multi(struct net_device *dev)
>   	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
>   		if (i >= MTL_MAX_TX_QUEUES)
>   			break;
> -		if (priv->tx_irq[i] == 0)
> +		if (priv->tx_irq[i] <= 0)

same here
>   			continue;
>   
>   		int_name = priv->int_name_tx_irq[i];
> @@ -7278,8 +7278,10 @@ int stmmac_dvr_probe(struct device *device,
>   	priv->plat = plat_dat;
>   	priv->ioaddr = res->addr;
>   	priv->dev->base_addr = (unsigned long)res->addr;
> -	priv->plat->dma_cfg->perch_irq_en =
> -		(priv->plat->flags & STMMAC_FLAG_PERCH_IRQ_EN);
> +	if (res->rx_irq[0] > 0 && res->tx_irq[0] > 0) {
> +		priv->plat->flags |= STMMAC_FLAG_PERCH_IRQ_EN;
> +		priv->plat->dma_cfg->perch_irq_en = true;
> +	}
>   
>   	priv->dev->irq = res->irq;
>   	priv->wol_irq = res->wol_irq;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 29145682b57b..9b46775b41ab 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -705,6 +705,9 @@ EXPORT_SYMBOL_GPL(stmmac_remove_config_dt);
>   int stmmac_get_platform_resources(struct platform_device *pdev,
>   				  struct stmmac_resources *stmmac_res)
>   {
> +	char irq_name[8];
> +	int i;
> +
>   	memset(stmmac_res, 0, sizeof(*stmmac_res));
>   
>   	/* Get IRQ information early to have an ability to ask for deferred
> @@ -738,6 +741,26 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
>   		dev_info(&pdev->dev, "IRQ eth_lpi not found\n");
>   	}
>   
> +	for (i = 0; i < MTL_MAX_RX_QUEUES; i++) {
> +		snprintf(irq_name, sizeof(irq_name), "rx%i", i);
> +		stmmac_res->rx_irq[i] = platform_get_irq_byname_optional(pdev, irq_name);
> +		if (stmmac_res->rx_irq[i] < 0) {
> +			if (stmmac_res->rx_irq[i] == -EPROBE_DEFER)
> +				return -EPROBE_DEFER;
> +			break;
> +		}
> +	}
> +
> +	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
> +		snprintf(irq_name, sizeof(irq_name), "tx%i", i);
> +		stmmac_res->tx_irq[i] = platform_get_irq_byname_optional(pdev, irq_name);
> +		if (stmmac_res->tx_irq[i] < 0) {
> +			if (stmmac_res->tx_irq[i] == -EPROBE_DEFER)
> +				return -EPROBE_DEFER;
> +			break;
> +		}
> +	}
> +
>   	stmmac_res->sfty_ce_irq = platform_get_irq_byname_optional(pdev, "sfty_ce");
>   	if (stmmac_res->sfty_ce_irq < 0) {
>   		if (stmmac_res->sfty_ce_irq == -EPROBE_DEFER)

