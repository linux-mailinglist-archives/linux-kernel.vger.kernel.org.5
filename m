Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B10E7645B7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjG0FhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjG0Fgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:36:49 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70783A87
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:36:07 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-666e916b880so386088b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436121; x=1691040921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VE1RKeu52PgibbEIBcvNdMAWZR9XL/q48yHh6zX8qpU=;
        b=ZdiEspP3hAzK8jr8c1RjOaeFxbbgWadFHaizDXB/yYr2Z2Ma6C+7lpL6n2bLCxNKSa
         afm//rlW1zI3PJFGG/xTiP3ChFoc026rCTXbBntbU6C1nKmgnMu2pIKGX87Q34bpFWZ7
         xsQQcpHZ5WYSrKL00yTgTTWrukWquxWEkTiz6Bort38KBZIHqMEOhYV0YjY/yQdEBamW
         zWgJbjNOEEwFj+yLpsuz5kz2YN29g6qS0+I773XF8PCY+2W5igbkYa//L/DAs7+zMrMd
         BfbFgBwzuNG6pnMQ1FgeFiYuMX6UyxdsQZsT3szVYGvYLUy1CxiLdQMzW32kGVsF7c5m
         pE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436121; x=1691040921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VE1RKeu52PgibbEIBcvNdMAWZR9XL/q48yHh6zX8qpU=;
        b=gUoLGz5V5s30nsvRW7O19Cnjw5osfYpZ1chqh2uen9jFWMRusRJOwpVWXs/+J1FkRl
         j/7cm8QJudXn4u0qMtdp9YA5Igy3/PeQ+d+hc3JQQqJc3nFYJVKOgAgtyaMtW1iw31AV
         GwHAUQZEOgYTB42+h5z6N4QvIprXyT+v10NceujfJ3UQUt/8nDJUx91vOHov6QKYP759
         yiY8iFeo18ApSx4qc963cMfYgfsyeHLkJQ+JFu6uZ2jIuqEgUzVckyLSzIL/cTAoUJZQ
         XwxDCa0tWQVNgdEwU+S8J9WRecOVI93j5iUMyb5wLq1naUBBWNWRbXiLqN0Sy5fW0a6P
         RwzA==
X-Gm-Message-State: ABy/qLbLLpCLlaPF/A7F3y/j0Bd9MLy3IYoxjqIXm/Zdc5Q1nxv37zDl
        zeX2c9OEQmyL3RHXzDmqp5ACXg==
X-Google-Smtp-Source: APBJJlEUHD2Kw/BKUMIea3L0J/1rbnc7rNyEW42ukWbo4hsMaNeB7JSQpI9MBjiNeNJ/0PVGEkYfBA==
X-Received: by 2002:a05:6a00:21d4:b0:682:4de1:adcc with SMTP id t20-20020a056a0021d400b006824de1adccmr3613132pfj.12.1690436121244;
        Wed, 26 Jul 2023 22:35:21 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id j24-20020aa79298000000b006765cb3255asm550215pfa.68.2023.07.26.22.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 22:35:20 -0700 (PDT)
Message-ID: <27427d7a-f1e0-87f5-bb74-d1151c598e26@tuxon.dev>
Date:   Thu, 27 Jul 2023 08:35:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/30] usb: ehci-atmel: Use
 devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230726113816.888-1-frank.li@vivo.com>
 <20230726113816.888-10-frank.li@vivo.com>
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230726113816.888-10-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.07.2023 14:37, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>   drivers/usb/host/ehci-atmel.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
> index 61808c51e702..e14b66d848ee 100644
> --- a/drivers/usb/host/ehci-atmel.c
> +++ b/drivers/usb/host/ehci-atmel.c
> @@ -122,8 +122,7 @@ static int ehci_atmel_drv_probe(struct platform_device *pdev)
>   	}
>   	atmel_ehci = hcd_to_atmel_ehci_priv(hcd);
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
> +	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>   	if (IS_ERR(hcd->regs)) {
>   		retval = PTR_ERR(hcd->regs);
>   		goto fail_request_resource;
