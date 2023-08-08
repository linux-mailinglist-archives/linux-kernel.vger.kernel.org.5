Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EF7773FD1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbjHHQyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbjHHQx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:53:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB00C18C1A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:58:37 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99c0cb7285fso769004466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510316; x=1692115116;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k2MJPyoks2T/ViX3nyRQF8CYDSyq3wamUO8HlMVdzMs=;
        b=ICo1vc5omKnxifKbTO5Z9UOAH0ct9pJ9Xx42zxgBqdN7kakXP3YOaw43/l9yfvjBqD
         92hUqIwzuOSpfD6W/Tp++boBMgsUqs7vLg0IQ0ZwB+1oVFGTPR2B4HJy3JGNNUlMcNm8
         rfycaFtJ1+dfpxTayF7uu74Jrl2LDkO7Zb2VEbZVho4ySmqI8Oo+LMTeeA8cWdgLe2EZ
         vAarQ7HMqybg6e770dNgGLV673OHTeGpUI7I4gguVTGxnpZTSp/ABXBoElY019XQA6Ui
         B5Ojef2IcGyXlgQLh4A6bULFVU3Xay5+1myNrpJiJ4j1XhZpyplaDE4l+aA35iBKdQMA
         UGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510316; x=1692115116;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k2MJPyoks2T/ViX3nyRQF8CYDSyq3wamUO8HlMVdzMs=;
        b=hrrKAyqVD8mQ11Byv9B3iDi7dVj8D/mUDkv0WOnjw+oZDpFA00ajrN/ZFCieMxt66G
         LCGR6Y7QFgbRqc4adcjlkvY1GExa7O+gMGTB2lSzxLptn3iAS2eo4WKACPAkVscJ10vZ
         PDerVlTGCwt9J/o8QS3iRU7kBt266y6Kb56ecTNPvBgYksjGQdjtNnB2fgZDWzUktzjO
         TB71gn1beEKFRjblpK9lssYAKBcVQSd4n0UkYWYdT6sOUvofgy2+exn4vo7fpqprQItT
         yBm56FlUXw8lgnreuwvs1idBBnArRCdGB81CR7Ctf9KrfY081q+ytOjK3hhzaG5pa2KP
         AJVQ==
X-Gm-Message-State: AOJu0YxEPXp08af/RiFrYPGrEr2SLpiXegWgBUE7YpTFLRQqpITQMDix
        ON268dAXG/zbaHy0IGu4sZmI19WrQnFNhojV4ds=
X-Google-Smtp-Source: AGHT+IHVYl6k7X1HkWuOZJGrwfDyphp8mGeKHbuzBByCu7FEdYTXY1+5KAwkmhFPQxZ+9wIOIIVSOg==
X-Received: by 2002:aa7:d7c7:0:b0:523:2df6:395e with SMTP id e7-20020aa7d7c7000000b005232df6395emr5416705eds.31.1691483787005;
        Tue, 08 Aug 2023 01:36:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id n24-20020a05640204d800b0052307566ed2sm6257416edw.14.2023.08.08.01.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 01:36:26 -0700 (PDT)
Message-ID: <b32797d7-ef81-7051-85b5-cbe0cd3302ae@linaro.org>
Date:   Tue, 8 Aug 2023 10:36:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 3/9] i2c: xlp9xx: Use dev_err_probe in probe function
Content-Language: en-US
To:     Liao Chang <liaochang1@huawei.com>, andi.shyti@kernel.org,
        florian.fainelli@broadcom.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        yangyicong@hisilicon.com, aisheng.dong@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, kblaiech@nvidia.com,
        asmaa@nvidia.com, loic.poulain@linaro.org, rfoss@kernel.org,
        ardb@kernel.org, gcherian@marvell.com
Cc:     linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230808012954.1643834-1-liaochang1@huawei.com>
 <20230808012954.1643834-4-liaochang1@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230808012954.1643834-4-liaochang1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 03:29, Liao Chang wrote:
> Use the dev_err_probe function instead of dev_err in the probe function
> so that the printed messge includes the return value and also handles
> -EPROBE_DEFER nicely.
> 
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  drivers/i2c/busses/i2c-xlp9xx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
> index f59e8c544f36..08a59a920929 100644
> --- a/drivers/i2c/busses/i2c-xlp9xx.c
> +++ b/drivers/i2c/busses/i2c-xlp9xx.c
> @@ -529,10 +529,8 @@ static int xlp9xx_i2c_probe(struct platform_device *pdev)
>  
>  	err = devm_request_irq(&pdev->dev, priv->irq, xlp9xx_i2c_isr, 0,
>  			       pdev->name, priv);
> -	if (err) {
> -		dev_err(&pdev->dev, "IRQ request failed!\n");

I don't think this is needed:
https://lore.kernel.org/all/20230721094641.77189-1-frank.li@vivo.com/

Best regards,
Krzysztof

