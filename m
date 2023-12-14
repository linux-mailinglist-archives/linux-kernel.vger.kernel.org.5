Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7626C812FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572926AbjLNMLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572936AbjLNMLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:11:11 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18B9126
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:11:12 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bfa5a6cffso9370863e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1702555871; x=1703160671; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xgrqFdV6UcxdxSO2fJT9XQI291SapSFGO4zYlzTTifY=;
        b=mK3Lc8MkuBCR3+0JWrGqjz/9WEFJoi1Xg8R2uqXA+/eUgsQVpGriScFxMxsAKELZdD
         TjM1Ss81xoMKIaYKPwiP9wwLd/MbBFnqXR1feJOsIm5WtvvFlB3vGRXPdhUrKjB43eqT
         nGW7GpqRsaGN4ZjPxvyBY6LlS1ZT+yrvJnaYC7C2UvNssjvR/SKqHRSEr/csUpLjLNNb
         PjYo9nbzK6rp29f0IT8fyVVh+/oOaQlFtRcT9AmOz3oL6++KNxjXqCdQJcqj8Af4Eep1
         pxNz55SqDGjaYdPHhqIiE8d7fDvWQi/zpp5kalDExVR+ugsXwEEE6X/Cd/6eJ5ksa3zZ
         CiOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702555871; x=1703160671;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xgrqFdV6UcxdxSO2fJT9XQI291SapSFGO4zYlzTTifY=;
        b=SoyOsNJRjIrD20hb4nwH53rTXD7ekzjXAZDUkbC/Ck/d7l4Plx8r3jFiLFm1+vbS96
         JApPQApKyAZ8SUNyklhBxM8C6oH8hqB85peVWHX8QhNQTB9mLKMU3o8O1QgVo8/Nzbnj
         Jdz7nEtGAeT+JZq3aOEvL0PkbM7fPmRcnaZFR6CZWtld9IYAWl09zEEE4rxbGzu8kOy7
         Z2OjUOm8cXT80XnGKXqJwLwTc932mcBOAgZlL5G6ILis0VT3cufOJ9PX0B9GOLmVG6j6
         bLKryCFkH61bYOuxTPoLZnEbElqmm9MoPljDSauIFXj2h/5HZETNbC5vExXPB6bWR6W5
         0ytw==
X-Gm-Message-State: AOJu0Yy/OiDufu6vkKuWlVlEh2rEoQ8avu0PkT+xm+jprd50qQGZsaR4
        QFAMMoEkzStNadLGtZEWmWHxCw==
X-Google-Smtp-Source: AGHT+IGnSjm5Hi+DAMqiJjbw0iT/RsGej7lC+5bYSSPg4CNP/j779F4eCE1ROr58TW0N7XE7G56SRg==
X-Received: by 2002:a05:6512:3ba8:b0:50e:d6e:67d6 with SMTP id g40-20020a0565123ba800b0050e0d6e67d6mr1943973lfv.14.1702555870935;
        Thu, 14 Dec 2023 04:11:10 -0800 (PST)
Received: from localhost (h-46-59-36-206.A463.priv.bahnhof.se. [46.59.36.206])
        by smtp.gmail.com with ESMTPSA id j13-20020ac2550d000000b0050bf4803234sm1876416lfk.194.2023.12.14.04.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:11:10 -0800 (PST)
Date:   Thu, 14 Dec 2023 13:11:09 +0100
From:   Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        claudiu.beznea.uj@bp.renesas.com, yoshihiro.shimoda.uh@renesas.com,
        wsa+renesas@sang-engineering.com, biju.das.jz@bp.renesas.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        mitsuhiro.kimura.kc@renesas.com, geert+renesas@glider.be,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: ravb: Wait for operation mode to be applied
Message-ID: <20231214121109.GK1863068@ragnatech.se>
References: <20231214113137.2450292-1-claudiu.beznea.uj@bp.renesas.com>
 <20231214113137.2450292-2-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231214113137.2450292-2-claudiu.beznea.uj@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,

Thanks for your patch.

On 2023-12-14 13:31:36 +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> CSR.OPS bits specify the current operating mode and (according to
> documentation) they are updated when the operating mode change request
> is processed. Thus, check CSR.OPS before proceeding.
> 
> Fixes: 568b3ce7a8ef ("ravb: factor out register bit twiddling code")
> Fixes: 0184165b2f42 ("ravb: add sleep PM suspend/resume support")
> Fixes: 7e09a052dc4e ("ravb: Exclude gPTP feature support for RZ/G2L")
> Fixes: 3e3d647715d4 ("ravb: add wake-on-lan support via magic packet")
> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")

I think the list of fixes tags can be reduced. The last item in the list 
is the patch which adds the RAVB driver so what's the point of listing 
the rest?

> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 47 ++++++++++++++++++++----
>  1 file changed, 39 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 9178f6d60e74..ce95eb5af354 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -683,8 +683,11 @@ static int ravb_dmac_init(struct net_device *ndev)
>  
>  	/* Setting the control will start the AVB-DMAC process. */
>  	ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_OPERATION);
> +	error = ravb_wait(ndev, CSR, CSR_OPS, CSR_OPS_OPERATION);
> +	if (error)
> +		netdev_err(ndev, "failed to switch device to operation mode\n");

As you add ravb_set_reset_mode() to compliment the existing 
ravb_set_config_mode(), would it not be coherent to also add a 
ravb_set_operation_mode() instead of open coding it here?

>  
> -	return 0;
> +	return error;
>  }
>  
>  static void ravb_get_tx_tstamp(struct net_device *ndev)
> @@ -1744,6 +1747,18 @@ static inline int ravb_hook_irq(unsigned int irq, irq_handler_t handler,
>  	return error;
>  }
>  
> +static int ravb_set_reset_mode(struct net_device *ndev)

nit: Maybe move this to be close to ravb_set_config_mode() to co-locate 
all mode changing logic?

> +{
> +	int error;
> +
> +	ravb_write(ndev, CCC_OPC_RESET, CCC);
> +	error = ravb_wait(ndev, CSR, CSR_OPS, CSR_OPS_RESET);
> +	if (error)
> +		netdev_err(ndev, "failed to switch device to reset mode\n");
> +
> +	return error;
> +}
> +
>  /* Network device open function for Ethernet AVB */
>  static int ravb_open(struct net_device *ndev)
>  {
> @@ -2551,10 +2566,11 @@ static int ravb_set_gti(struct net_device *ndev)
>  	return 0;
>  }
>  
> -static void ravb_set_config_mode(struct net_device *ndev)
> +static int ravb_set_config_mode(struct net_device *ndev)
>  {
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	const struct ravb_hw_info *info = priv->info;
> +	int error;
>  
>  	if (info->gptp) {
>  		ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
> @@ -2566,6 +2582,12 @@ static void ravb_set_config_mode(struct net_device *ndev)
>  	} else {
>  		ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
>  	}
> +
> +	error = ravb_wait(ndev, CSR, CSR_OPS, CSR_OPS_CONFIG);
> +	if (error)
> +		netdev_err(ndev, "failed to switch device to config mode\n");
> +
> +	return error;
>  }
>  
>  /* Set tx and rx clock internal delay modes */
> @@ -2785,7 +2807,9 @@ static int ravb_probe(struct platform_device *pdev)
>  	ndev->ethtool_ops = &ravb_ethtool_ops;
>  
>  	/* Set AVB config mode */
> -	ravb_set_config_mode(ndev);
> +	error = ravb_set_config_mode(ndev);
> +	if (error)
> +		goto out_disable_refclk;
>  
>  	if (info->gptp || info->ccc_gac) {
>  		/* Set GTI value */
> @@ -2893,6 +2917,7 @@ static void ravb_remove(struct platform_device *pdev)
>  	struct net_device *ndev = platform_get_drvdata(pdev);
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	const struct ravb_hw_info *info = priv->info;
> +	int error;
>  
>  	unregister_netdev(ndev);
>  	if (info->nc_queues)
> @@ -2908,8 +2933,9 @@ static void ravb_remove(struct platform_device *pdev)
>  	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
>  			  priv->desc_bat_dma);
>  
> -	/* Set reset mode */
> -	ravb_write(ndev, CCC_OPC_RESET, CCC);
> +	error = ravb_set_reset_mode(ndev);
> +	if (error)
> +		netdev_err(ndev, "Failed to reset ndev\n");
>  
>  	clk_disable_unprepare(priv->gptp_clk);
>  	clk_disable_unprepare(priv->refclk);
> @@ -2991,8 +3017,11 @@ static int __maybe_unused ravb_resume(struct device *dev)
>  	int ret = 0;
>  
>  	/* If WoL is enabled set reset mode to rearm the WoL logic */
> -	if (priv->wol_enabled)
> -		ravb_write(ndev, CCC_OPC_RESET, CCC);
> +	if (priv->wol_enabled) {
> +		ret = ravb_set_reset_mode(ndev);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	/* All register have been reset to default values.
>  	 * Restore all registers which where setup at probe time and
> @@ -3000,7 +3029,9 @@ static int __maybe_unused ravb_resume(struct device *dev)
>  	 */
>  
>  	/* Set AVB config mode */
> -	ravb_set_config_mode(ndev);
> +	ret = ravb_set_config_mode(ndev);
> +	if (ret)
> +		return ret;
>  
>  	if (info->gptp || info->ccc_gac) {
>  		/* Set GTI value */
> -- 
> 2.39.2
> 

-- 
Kind Regards,
Niklas Söderlund
