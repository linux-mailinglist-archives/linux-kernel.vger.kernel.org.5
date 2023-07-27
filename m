Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D92764E91
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjG0JGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjG0JGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:06:05 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332BC59CF;
        Thu, 27 Jul 2023 01:47:25 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe0cfc7ef9so181954e87.0;
        Thu, 27 Jul 2023 01:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690447643; x=1691052443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eTo6Edh8lHo2BapE1JCqPWXw2K03R9O2WOf57wkgONA=;
        b=UCr1BwouF4RfBo7hbx5lAgeH4wSlqENLK4DJ/7C6ujZkkwccylqrZOyqOyDMBWZbvT
         SgBidTwmevoiZm0WZj1pX32k9MZsg2nPBCW+U80K3qMg7wqPRbXq28eaMXRqE331Zah9
         sKSpkrxhf3UmkN1ab8AMjZ0c9m+2ZteV6/HKV+y2qM3w7iSLcfKKKfM30GdvkSLGIThQ
         L68qbARtnB1265yCYnBi39rmrvY1BPLVgQwsLy0xz0ato0KIJgEmKcSvMwedNmex1x78
         JZ379MGM9mdUMoiLHjwmmBsd1d4WGOV9rbQcrHT0EkpL33aRwPpwRC9vRMGrXXW1PyzN
         Hgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690447643; x=1691052443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eTo6Edh8lHo2BapE1JCqPWXw2K03R9O2WOf57wkgONA=;
        b=Kqb+7phlLVL1w9Pcwz3XCYXbEaILjnasC2XMHkl737pl2VoB6NR14MsGmbhEv/ljD4
         CtY9ZE8aXn8m9caeOtyiSDp1j1yRaKR7SgX8OCeNM3QH9dIYKCtIWtGSlyK76m2/2ayr
         Uircol1gnsju12k0QuSCCsqkBi0GCLkh2jGiXLU1EWLTLTqMwSiRGSm8dcJAweE6P00x
         RbQ54nu/6VFwblVqAEIYoPYGxRS6jR9ZNe4krDBjuVpBbxO8xpRhidbmqAWK+q+A2YCM
         r9kj6ba9/U2VVsvDIKz5K0dxuT7TwWbCNZFCBvkQdt9SvOTCXQgsNdQgkHV3k6nekzVG
         LE/Q==
X-Gm-Message-State: ABy/qLabVlVXaPCh0fcQRYP3ZgSaP/9ej2obmWUzKQNrG2GkWIaf80wl
        RsaxRcxNBDGZBA3N7VIOJqByLiimklE=
X-Google-Smtp-Source: APBJJlGs4tNJ17hoIOZ54mQyDzSi0jMyBxbdIcNT5QDYsnlHPfzXLcYPgUri69ktswyfD6HezZZTqg==
X-Received: by 2002:a2e:5759:0:b0:2b9:3c1d:6ec0 with SMTP id r25-20020a2e5759000000b002b93c1d6ec0mr2784929ljd.4.1690447643102;
        Thu, 27 Jul 2023 01:47:23 -0700 (PDT)
Received: from [192.168.0.192] ([194.146.248.75])
        by smtp.gmail.com with ESMTPSA id d10-20020a2e890a000000b002b6d7682050sm222911lji.89.2023.07.27.01.47.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 01:47:22 -0700 (PDT)
Message-ID: <fb0b48af-3bf7-184c-2a99-d1e06fcdabba@gmail.com>
Date:   Thu, 27 Jul 2023 10:47:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH -next] media: jpeg-core: Remove redundant dev_err()
To:     Ruan Jinjie <ruanjinjie@huawei.com>, jacek.anaszewski@gmail.com,
        s.nawrocki@samsung.com, mchehab@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230727100632.2737656-1-ruanjinjie@huawei.com>
Content-Language: en-US
From:   Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
In-Reply-To: <20230727100632.2737656-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

W dniu 27.07.2023 o 12:06, Ruan Jinjie pisze:
> There is no need to call the dev_err() function directly to print a custom
> message when handling an error from platform_get_irq() function as
> it is going to display an appropriate error message in case of a failure.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Acked-by: Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>

> ---
>   drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c b/drivers/media/platform/samThsung/s5p-jpeg/jpeg-core.c
> index 5e819b8b38a4..d2c4a0178b3c 100644
> --- a/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
> +++ b/drivers/media/platform/samsung/s5p-jpeg/jpeg-core.c
> @@ -2870,10 +2870,8 @@ static int s5p_jpeg_probe(struct platform_device *pdev)
>   
>   	/* interrupt service routine registration */
>   	jpeg->irq = ret = platform_get_irq(pdev, 0);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "cannot find IRQ\n");
> +	if (ret < 0)
>   		return ret;
> -	}
>   
>   	ret = devm_request_irq(&pdev->dev, jpeg->irq, jpeg->variant->jpeg_irq,
>   				0, dev_name(&pdev->dev), jpeg);
