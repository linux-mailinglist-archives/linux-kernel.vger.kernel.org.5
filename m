Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8427645A1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjG0Ff3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjG0Fey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:34:54 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83901FFA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:34:28 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-55e1ae72dceso432086eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690436067; x=1691040867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KTaajNH7kTp6fI9Xo9N4+w+xfiev+BWa6ZHyvMwcPl8=;
        b=HXN5OQDmS3v+xn2BH/Ae3zhxd54WRt/bndMAmqOC4A4G78F+7pbgIEIuCWssiIKq71
         jV/MMkqrSyxvIStUj0Ypa6fy1SIIVo2wU00uOIJOcYURHRSuh++MN+B/MQZqWU/40TdE
         niGwqccV3U9XzhLqTF02myEoCtKxA/otC+/SFRAivfLXYkrQxOppqzLzUc6m+C4QhscJ
         Q3c2C3LIAmM9QXoIXSr/NrPRs3yZ/GVc5JxZoZgmWkdT0mzXCrTezmRvQZVRhlJSoTPa
         VtECMZ1NfU8qJHs0eiDhnsaGaMaPwJKOPd4L1OtvFM6K8ZVhUcCd4zLSFyzFL1ElpRtU
         qjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436067; x=1691040867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTaajNH7kTp6fI9Xo9N4+w+xfiev+BWa6ZHyvMwcPl8=;
        b=h/zWjUy4gRs6WpuH/5WEvCtZ3eQ2zXAOPlKfLt3C62x+uulghsugupxn5e+0ay5uZ3
         QGPKcg6aQOv6kG4xZNTzyOiZxO3hIz5FIA1F7cSnSiEWvy28Ps6QPElhBNHTbu+UEK0e
         Up8zBobDIAyh7YjzTnYbcd8udxCINEQrZVeaJxXmAPHkU17dLSigVQv0NvlsV6tfno+c
         AjTXWfPJrhStHzdFhJunC/kBUqJGaWY3lJnhSHtZQN76PpdwTvEuTB4Brg9zfeoukCuR
         ATtkxS69XD7Kx4GIXd6yR7oVYCdyEA5tdYA/koplye9/+TFVZ2mL4/EC8Bmgs7C+ImmP
         BoLA==
X-Gm-Message-State: ABy/qLbaHTB3hvuEJLrbINY3hSbU3dTyF+2BWCAkymb/x3FEfVVBZQZB
        Z/TJtTDlC76DAol//iLD5oF/YS+mt074zPiSD6yvmbSI
X-Google-Smtp-Source: APBJJlFuEOPyG+INAoa9TDEX0JyXr4vZJpCc/Z0+4yPF+joBbR4nk3jzVllIxp0fXswX5h+hxwcGkA==
X-Received: by 2002:a05:6808:1924:b0:3a3:baf8:5b8a with SMTP id bf36-20020a056808192400b003a3baf85b8amr2727697oib.13.1690436067169;
        Wed, 26 Jul 2023 22:34:27 -0700 (PDT)
Received: from [10.0.2.15] ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id c16-20020a17090ad91000b00265a7145fe5sm2052972pjv.41.2023.07.26.22.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 22:34:26 -0700 (PDT)
Message-ID: <9887e7a5-2422-4ab1-baf8-6eb0e27c1314@tuxon.dev>
Date:   Thu, 27 Jul 2023 08:34:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 08/30] usb: gadget/atmel_usba_udc: Use
 devm_platform_get_and_ioremap_resource()
To:     Yangtao Li <frank.li@vivo.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230726113816.888-1-frank.li@vivo.com>
 <20230726113816.888-8-frank.li@vivo.com>
Content-Language: en-US
From:   claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230726113816.888-8-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
>   drivers/usb/gadget/udc/atmel_usba_udc.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index 6c0ed3fa5eb1..02b1bef5e22e 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -2285,15 +2285,13 @@ static int usba_udc_probe(struct platform_device *pdev)
>   	udc->gadget = usba_gadget_template;
>   	INIT_LIST_HEAD(&udc->gadget.ep_list);
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, CTRL_IOMEM_ID);
> -	udc->regs = devm_ioremap_resource(&pdev->dev, res);
> +	udc->regs = devm_platform_get_and_ioremap_resource(pdev, CTRL_IOMEM_ID, &res);
>   	if (IS_ERR(udc->regs))
>   		return PTR_ERR(udc->regs);
>   	dev_info(&pdev->dev, "MMIO registers at %pR mapped at %p\n",
>   		 res, udc->regs);
>   
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, FIFO_IOMEM_ID);
> -	udc->fifo = devm_ioremap_resource(&pdev->dev, res);
> +	udc->fifo = devm_platform_get_and_ioremap_resource(pdev, FIFO_IOMEM_ID, &res);
>   	if (IS_ERR(udc->fifo))
>   		return PTR_ERR(udc->fifo);
>   	dev_info(&pdev->dev, "FIFO at %pR mapped at %p\n", res, udc->fifo);
