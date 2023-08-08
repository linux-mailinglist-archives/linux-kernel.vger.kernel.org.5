Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBAB77409D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjHHRGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjHHRFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:05:11 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0601A75F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:02:14 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98377c5d53eso806825266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510494; x=1692115294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HMEaWb1xblsQVJcXEol8oykgDk7Z/s9Dq4Nd7yRCjng=;
        b=vexXG2xTerZQwMJJcQnRXUliFW5d/ac57BZzBG2GC+hwP4e/Y0O8VU1UXr91wqQiZR
         F2lxxcuoG1OrEXK+DDp04hgYWbw3lwsAPSt9CnMgEmIpQsODMWMEjmLKnSjHoK3XIeV8
         PJ28UyS3z9zVYDDNKfDJWuZ03hrYN0JdIJ7XhPrRu7lQ6gww0CS4hrnR5bpiUQVN17Ui
         VbtWOSDOCowfdeUbwmKSxyBoPdyOllUlKOUdjEIIdeXevOghhzqNqEAsn5tAzrHFkDl0
         KQxisubn3BRSCoa+g8h3uVdZcnZInIx8m85CyX2fW1sb/d4VXufaHKKtDWRj0lNeXAYB
         WSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510494; x=1692115294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HMEaWb1xblsQVJcXEol8oykgDk7Z/s9Dq4Nd7yRCjng=;
        b=dcdWMvWT0azw0DVvPFoOYwMWiKIpkEI4ByQJmAdMgYt9pMQz7CHq7t5sJj9Ns6IIjs
         Dgh1lc7YI5JITzjA7r2znAcHT8qfUX9dzsX4EDQjrrqwToLj3+hCEqjFz6sElAn2880f
         oi3cHAEjJjg8JnQMZ4kMo9Snm5phYwfVfTfgfAXqxEhkjUArGthCx009ZWGVJUZE5kJC
         Ao6wtgyqGNX7nIJbFPfCG48ixnqTRrE8Vf5APopJw/qj+Tw3tTrVvZdqBU+KJCKzhpf6
         sarWs8Ik+6eMhcKzKCEFtwT5/RVFs4AYGEtxiac+gVniaYKRwzSzg4P7xICDoZqqfMnc
         zTcA==
X-Gm-Message-State: AOJu0YytPg3k+tc7ogyE9cBLmCFXeALdCBjqA9FrMD+kw0xGpg5/2VA9
        luu1sAnNXNkaOH0gLHyvhV7qm98XVqZPkZ6Sq5Y=
X-Google-Smtp-Source: AGHT+IG+hPH130GsaAWOXOCOgUJ4jN56dYOBsImJMdrSAJG+P3lNXldoERLeCFvY2fbEGvnW5W5Tww==
X-Received: by 2002:a05:6402:514:b0:51e:309:2e12 with SMTP id m20-20020a056402051400b0051e03092e12mr10221930edv.28.1691483803097;
        Tue, 08 Aug 2023 01:36:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id d13-20020a50fe8d000000b0051e1660a34esm6227195edt.51.2023.08.08.01.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 01:36:42 -0700 (PDT)
Message-ID: <a5b2f1a2-d509-0949-fc1d-929476c2618b@linaro.org>
Date:   Tue, 8 Aug 2023 10:36:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/9] i2c: mlxbf: Use dev_err_probe in probe function
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
 <20230808012954.1643834-3-liaochang1@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230808012954.1643834-3-liaochang1@huawei.com>
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

...

> @@ -2413,10 +2399,8 @@ static int mlxbf_i2c_probe(struct platform_device *pdev)
>  	ret = devm_request_irq(dev, irq, mlxbf_i2c_irq,
>  			       IRQF_SHARED | IRQF_PROBE_SHARED,
>  			       dev_name(dev), priv);
> -	if (ret < 0) {
> -		dev_err(dev, "Cannot get irq %d\n", irq);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Cannot get irq %d\n", irq);

I don't think this is needed:
https://lore.kernel.org/all/20230721094641.77189-1-frank.li@vivo.com/

Best regards,
Krzysztof

