Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3EF7560FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 12:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjGQK7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 06:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjGQK7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 06:59:35 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C3DE52
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:59:33 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fdb856482fso1916673e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 03:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689591571; x=1692183571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T7SZG+2T9lEbrNjc07wlF2HjBaRW0VTkdwbTVSLTnRA=;
        b=IAmEnx0BSltprjmxtxcr0+YjWd2LZZ8iRl7sm8xoHqfEhyKnQmSgA9daBznErbNNe9
         ju/PF0917QVHIg6s6M7RHHj16axck6n1gN2DMtmrdy2XFAVIpDkYPmdX0Ytb/LOz+W0y
         QP7dk/ZQDT0Svq4LJy21+0v5J3o6xO//6NfBeq5uvCPkeYFDGQXjq1k6tFpCZMr2uhHg
         plSevJ8Nmpymfk1DKaSu7lrawmEoVQrABC8sv9imjaFy29mjhnd+6lxjdh0zg0YhFmba
         y0+7+5pOBgBCFmvaCWbyXblFhvxQBj31XcxqSeeeYilD+4iXKcORjAToOWIpxyVwBV0C
         ah6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689591571; x=1692183571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7SZG+2T9lEbrNjc07wlF2HjBaRW0VTkdwbTVSLTnRA=;
        b=XagbrAcGgJ7IDyWy+Qfbh5DnHikMpJ/3DnVgPDRjmTn+t0ry2u76Ukm/F4FgPtN4Zu
         6+KEgj5JR10+cNlM8Cm0z8w/At2xB5MUiEHXL8Q0iT5KXHQ+pr9e5YWjMEDO7XSfrfoO
         1ofJiY4gpPW/etaeDTnrey++ipgxcVdRx6mFGqBLbz30f+8LaYshBidsfvN5nsshhGXo
         FCR6LnEGYUrlAHbieqbwO/9xJ7vCCs/3mQ203YZiSJ1/Or8RWDIPnyC4drmbfCv3ZcTq
         GcUdLB5uk3iI4hU7hkG5NNCa2VF6cCI3E9fKbzkD1VKdxKeq+WnkhCnsH2gwgLNe1T3y
         7A0Q==
X-Gm-Message-State: ABy/qLZ4gTCEKrNn3glhGXQ8uE9wBCBB22b6xSOcGX2yRzWww9HrPUKI
        P7tny34zvaGJHl4EZAVoQ0DT/Q==
X-Google-Smtp-Source: APBJJlEsw+2f8VSbGPFFqH0DQs+jkrIhjY2A10P+fUUx3XjHf1qljPsUqTTMCRCfPI+L1gu9CYECLA==
X-Received: by 2002:a05:6512:3c92:b0:4fa:5e76:7ad4 with SMTP id h18-20020a0565123c9200b004fa5e767ad4mr9507508lfv.10.1689591571251;
        Mon, 17 Jul 2023 03:59:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n7-20020aa7c447000000b0051e22660835sm9826507edr.46.2023.07.17.03.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 03:59:29 -0700 (PDT)
Message-ID: <9b09afec-4e0e-a600-92e1-2104a1b2e36e@linaro.org>
Date:   Mon, 17 Jul 2023 12:59:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 1/2] dt-bindings: pwm: samsung: add exynosautov9
 compatible
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20230717094202.18296-1-jaewon02.kim@samsung.com>
 <CGME20230717094721epcas2p1c5c1254e24d4a1d0fb366e1b4d551536@epcas2p1.samsung.com>
 <20230717094202.18296-2-jaewon02.kim@samsung.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717094202.18296-2-jaewon02.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
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

On 17/07/2023 11:42, Jaewon Kim wrote:
> Add samsung,exynosautov9-pwm compatible string to binding document.
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>  .../devicetree/bindings/pwm/pwm-samsung.yaml     | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
> index fe603fb1b2cc..6f65e2b52f52 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.yaml
> @@ -20,12 +20,16 @@ description: |+
>  
>  properties:
>    compatible:
> -    enum:
> -      - samsung,s3c2410-pwm             # 16-bit, S3C24xx
> -      - samsung,s3c6400-pwm             # 32-bit, S3C64xx
> -      - samsung,s5p6440-pwm             # 32-bit, S5P64x0
> -      - samsung,s5pc100-pwm             # 32-bit, S5PC100, S5PV210, Exynos4210 rev0 SoCs
> -      - samsung,exynos4210-pwm          # 32-bit, Exynos
> +    oneOf:
> +      - const: samsung,s3c2410-pwm        # 16-bit
> +      - const: samsung,s3c6400-pwm        # 32-bit, S3C64xx
> +      - const: samsung,s5p6440-pwm        # 32-bit, S5P64x0
> +      - const: samsung,s5pc100-pwm        # 32-bit, S5PC100, S5PV210, Exynos4210 rev0 SoCs
> +      - const: samsung,exynos4210-pwm     # 32-bit, Exynos

These are still an enum.

> +      - items:
> +          - enum:
> +              - samsung,exynosautov9-pwm  # 32-bit, ExynosAutov9

Let's drop the comment?

> +          - const: samsung,exynos4210-pwm
>  

Best regards,
Krzysztof

