Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FE87645F4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjG0Fn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjG0FnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:43:16 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD3230D6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:41:55 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-686ed1d2594so581957b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436458; x=1691041258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yTNp0sYgD5zMdnjd5nivhzfUxDOUpHBvlbZBBUuBSK8=;
        b=Do6o4dH6SqtgInZupQNgE3LGRebmjvQq9ntW2BM+eF/Fn4qI7L4SSBZz4SecjUCEFm
         3F+5gqWeNjsBAAJ+atklVaHFRcTGG9V4GZOr8MJ9jAcpIMdvTVC2bRvYnqXz4vuEErHj
         17Fw3zufiIbDMR63WQ2uJub4pY2s31+l7Z8nAvGAVcKoesI7gT5MFJw5GZjFUtV2U+S1
         hMlTBuPftFbUIlUkSwirMEFA3kTW6tIGz6YxdqyGSe80a9CvKLlYq+xRDjDvU9m8yk2h
         2/ekTdctVvPa5HP2Suf51o50NcC+0bqD7DDvVp9jWz8MO3a4EtqA1g2E/wayY7zKJMjW
         9Atw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436458; x=1691041258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yTNp0sYgD5zMdnjd5nivhzfUxDOUpHBvlbZBBUuBSK8=;
        b=MMmWZkdQ+uOzymqyqXJcZZSIedXqIGeLbZTyUgdE/sxNodo2oAmH6LI+zFHzSd75T5
         F3SbU2gbdrCt+4RahZe2c2SVTbHywtbUTwwK+xK2k8HeNzZcBBzeebqbtGA8KmFqjsep
         3AijeubR50GjvtvfFnWpGLhki2lwmedjkw0XiCOc8GevPnPGg3csFd+d4qumATAqimXW
         GM+pUgQjC4O01bcZ+vFGO86YRrx3hVLhM4akflHcz5+dPlCxK2lZtdeJFd0YqlfqdBhj
         mt68oeww6KWYRsi5AzB12y8JRh6HxSEcNTKFpUXJskYMQvBm5n4ILj9qZReno9q935b4
         V6bw==
X-Gm-Message-State: ABy/qLbe6z2ab1mSsW0fRYLMEfF9X3Mw+tKlxrQOwWDR+P3/vW1P51IU
        9Wbnjqt+uIvbKwEt8rVyE5GIUg==
X-Google-Smtp-Source: APBJJlEgwKoaKppLi57A68jn58J5UBv4vce3uoS3HBVYjj8iEbftSlHAHvZKgDA4UyD8gQuxYPMfHg==
X-Received: by 2002:a05:6a00:2d8e:b0:682:616a:f910 with SMTP id fb14-20020a056a002d8e00b00682616af910mr5155408pfb.20.1690436458474;
        Wed, 26 Jul 2023 22:40:58 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79111000000b00682a16f0b00sm538227pfh.210.2023.07.26.22.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 22:40:58 -0700 (PDT)
Message-ID: <aadee30c-8965-a3c3-c90c-bcdfa6ad143c@tuxon.dev>
Date:   Thu, 27 Jul 2023 08:40:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 12/61] mmc: sdhci-of-at91: Convert to platform remove
 callback returning void
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230726040041.26267-1-frank.li@vivo.com>
 <20230726040041.26267-12-frank.li@vivo.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230726040041.26267-12-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.07.2023 06:59, Yangtao Li wrote:
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

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>   drivers/mmc/host/sdhci-of-at91.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index cd0134580a90..af5bc0caf29b 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -443,7 +443,7 @@ static int sdhci_at91_probe(struct platform_device *pdev)
>   	return ret;
>   }
>   
> -static int sdhci_at91_remove(struct platform_device *pdev)
> +static void sdhci_at91_remove(struct platform_device *pdev)
>   {
>   	struct sdhci_host	*host = platform_get_drvdata(pdev);
>   	struct sdhci_pltfm_host	*pltfm_host = sdhci_priv(host);
> @@ -461,8 +461,6 @@ static int sdhci_at91_remove(struct platform_device *pdev)
>   	clk_disable_unprepare(gck);
>   	clk_disable_unprepare(hclock);
>   	clk_disable_unprepare(mainck);
> -
> -	return 0;
>   }
>   
>   static struct platform_driver sdhci_at91_driver = {
> @@ -473,7 +471,7 @@ static struct platform_driver sdhci_at91_driver = {
>   		.pm	= &sdhci_at91_dev_pm_ops,
>   	},
>   	.probe		= sdhci_at91_probe,
> -	.remove		= sdhci_at91_remove,
> +	.remove_new	= sdhci_at91_remove,
>   };
>   
>   module_platform_driver(sdhci_at91_driver);
