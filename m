Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268EF762FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjGZIia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjGZIiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:38:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7275244;
        Wed, 26 Jul 2023 01:26:52 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A25B066015A0;
        Wed, 26 Jul 2023 09:26:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690360011;
        bh=ZYxITNMiGjtQvR5S9TjwH1BfrvaXGbffyhHXRFGf49A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Cy0waiqRUwzbrVWOa+xWag5QP7C4EmDDnQmJh5j5AvFhhDiXF389WoG3HTgdVW3SC
         SRfHPCB7PcfrinDSmbbbs6Tvhb0a4gjMBg22KiaYOJvXGldKSuRZv4AghwTTh3Zry4
         tleHZMbuj9XypFEDonJlmstqjHtUGpN+ZYmEGbg0bVHqbZRzKo6NAeK/F9j9KFuj3g
         uOlO97Z3DfsCGC35YKIlLAPNXnkfPdjvaGQYVR3r42zA4EVtCr1rCtzrejO+OIuUkq
         0KTTBSK8HycJHLQ93y1Jk3r/PFR6YXPxLleUIvxy8F1w8Os7UyJQpjNPvqkQF3fPMd
         kAywPYmk1yrkA==
Message-ID: <479e4e09-899a-63a0-e606-40427bdd6cf8@collabora.com>
Date:   Wed, 26 Jul 2023 10:26:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 05/61] mmc: mtk-sd: Convert to platform remove callback
 returning void
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230726040041.26267-1-frank.li@vivo.com>
 <20230726040041.26267-5-frank.li@vivo.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230726040041.26267-5-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/07/23 05:59, Yangtao Li ha scritto:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/mmc/host/mtk-sd.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 02403ff99e0d..9e2debd1edbe 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2887,7 +2887,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
>   	return ret;
>   }
>   
> -static int msdc_drv_remove(struct platform_device *pdev)
> +static void msdc_drv_remove(struct platform_device *pdev)
>   {
>   	struct mmc_host *mmc;
>   	struct msdc_host *host;
> @@ -2911,8 +2911,6 @@ static int msdc_drv_remove(struct platform_device *pdev)
>   			host->dma.bd, host->dma.bd_addr);
>   
>   	mmc_free_host(mmc);
> -
> -	return 0;
>   }
>   
>   static void msdc_save_reg(struct msdc_host *host)
> @@ -3054,7 +3052,7 @@ static const struct dev_pm_ops msdc_dev_pm_ops = {
>   
>   static struct platform_driver mt_msdc_driver = {
>   	.probe = msdc_drv_probe,
> -	.remove = msdc_drv_remove,
> +	.remove_new = msdc_drv_remove,
>   	.driver = {
>   		.name = "mtk-msdc",
>   		.probe_type = PROBE_PREFER_ASYNCHRONOUS,

