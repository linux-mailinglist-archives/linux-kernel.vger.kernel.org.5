Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22D77576F7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjGRIpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjGRIpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:45:49 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43141FA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:45:48 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb7373dd35so8213908e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689669946; x=1690274746;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z9Y9Pg8GYAj1Bq7hDWPPHyY4wzFItCVRYd5Xl6htUGY=;
        b=JpC7rmKsDQfmOY+u/kU7z8i0+1uT29zXmfsZEiNKcCbkpYf26JDQ1aHaix86K77fg1
         JTNZJziZGYYYPGOiZIz7lU9ABGCEkEUGFBFlozJEoUsE5AhSiCuGGk/q161gNFSgyuL9
         VTktivDjruIdaJPFCNR5o/8tViI+rDGdze78cJMK3CRjVZmJrlq0GCfRjmKzEpgbP00E
         f3OwvXzMzjudH00XUrfl2VPgZF/w6mEF6G3mpW81B8qRzvEFt5LJBZu8Y7FbVgSLpQp1
         R2iXPnR04//rJ/HigeLPldiS/jTKO6/SmYAl2kqaA+uxruCZ63Pn7KXHNvQHO44loGiP
         0MvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689669946; x=1690274746;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9Y9Pg8GYAj1Bq7hDWPPHyY4wzFItCVRYd5Xl6htUGY=;
        b=kcMLfVwaln36JaUlATw3C44j3wzjEcZ0qDoOJJHB2RgcNrkzWMGYFuf0DOX8PW7i90
         ihoeTJQowoyCw5w31fDdjQnBAnPZVci+J4UDxBEaPCvKqY4vtMprvQP5/xSdfz2g2pse
         7MnBKK+5eJZTxvWtTbAwmM+qKhyme0f7Ipib9ZQ6a0HlNIKU5iyaSFeSwiqJOydlZ2T+
         qDk8F6WwhBZ5pEh5kmvkjJw6G1JhIj/K/E9Z67fiAQlN0oE6YI2yvj2HHDx/Ee+xjnBh
         T6SKqN1mPrWub1v93Nuza3caTBqYYU69f1XaBSIgbfwfeUefNMoJ3e+4YD+UAHgb2z6b
         xotg==
X-Gm-Message-State: ABy/qLZj5diPBwEqz2lWLcH6pFXvG/+SvlKfIDn6YVQgMehfVr6rs2mO
        IT43ym0cHecyzfke6Dy6z2Ndew==
X-Google-Smtp-Source: APBJJlFS0aKSozVnVDDjqTi1y2ONkMtOUitE926Na0mWMo42ptOgTCjKp8dQwzsO+AdhmGEwWnR66A==
X-Received: by 2002:a05:6512:3b25:b0:4fb:7bf8:51c8 with SMTP id f37-20020a0565123b2500b004fb7bf851c8mr4503058lfv.1.1689669946524;
        Tue, 18 Jul 2023 01:45:46 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id w13-20020a19c50d000000b004fdb6d3ac96sm330333lfe.280.2023.07.18.01.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 01:45:45 -0700 (PDT)
Message-ID: <7df84e50-f152-c58d-bd1c-fdb25dbb550c@linaro.org>
Date:   Tue, 18 Jul 2023 11:45:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] sparc: add missing put_device()
Content-Language: en-GB
To:     sunran001@208suo.com, davem@davemloft.net
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230718071735.16312-1-xujianghui@cdjrlc.com>
 <4a1fd666ef4700ec17d1be60debf016b@208suo.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <4a1fd666ef4700ec17d1be60debf016b@208suo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 10:19, sunran001@208suo.com wrote:
> The of_find_device_by_node() takes a reference to the underlying device
> structure, we should release that reference.
> 
> Detected by coccinelle with the following ERRORS:
> ./arch/sparc/kernel/of_device_common.c:23:1-7: ERROR: missing
> put_device; call of_find_device_by_node on line 18, but without a
> corresponding object release within this function.
> ./arch/sparc/kernel/of_device_common.c:36:1-7: ERROR: missing
> put_device; call of_find_device_by_node on line 30, but without a
> corresponding object release within this function.
> ./arch/sparc/kernel/of_device_common.c:50:1-7: ERROR: missing
> put_device; call of_find_device_by_node on line 42, but without a
> corresponding object release within this function.
> 
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   arch/sparc/kernel/of_device_common.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/sparc/kernel/of_device_common.c 
> b/arch/sparc/kernel/of_device_common.c
> index 60f86b837658..7851307de6d0 100644
> --- a/arch/sparc/kernel/of_device_common.c
> +++ b/arch/sparc/kernel/of_device_common.c
> @@ -20,6 +20,7 @@ unsigned int irq_of_parse_and_map(struct device_node 
> *node, int index)
>       if (!op || index >= op->archdata.num_irqs)
>           return 0;
> 
> +    put_device(op->dev);
>       return op->archdata.irqs[index];

Device can be gone and freed after the put_device() call. So at least 
put_device() should come after the op->archdata access.

Same applies to all the cases below.

>   }
>   EXPORT_SYMBOL(irq_of_parse_and_map);
> @@ -32,6 +33,7 @@ int of_address_to_resource(struct device_node *node, 
> int index,
>       if (!op || index >= op->num_resources)
>           return -EINVAL;
> 
> +    put_device(op->dev);
>       memcpy(r, &op->archdata.resource[index], sizeof(*r));
>       return 0;
>   }
> @@ -45,6 +47,7 @@ void __iomem *of_iomap(struct device_node *node, int 
> index)
>       if (!op || index >= op->num_resources)
>           return NULL;
> 
> +    put_device(op->dev);
>       r = &op->archdata.resource[index];
> 
>       return of_ioremap(r, 0, resource_size(r), (char *) r->name);

-- 
With best wishes
Dmitry

