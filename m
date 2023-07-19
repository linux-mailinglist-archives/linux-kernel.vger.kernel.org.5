Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11645759161
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjGSJSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjGSJSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:18:07 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43EB9D
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:18:05 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fbf09a9139so10828450e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689758284; x=1692350284;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8bR6aQXx5gvtM8troROxyJmOZ+pi9iajw/Z15AHeaio=;
        b=vFfwGMfwvCrNPj4v9IrGwMmaaZW/CeEPEQQj1A5KHspVAVg2/z5ddaYwFsU/jB683n
         SxwmkZ1wa/7bKCQs11/tzVVp2tfeSjy2uDQzAP8TM5Iy05gFc7J9AZTUVdevV8A1Y2zt
         bBPXISWXd3y8SOCg3Ikbdi+Ps+XZPEfKhsqNatEbXevtasFL5BzXZtOyrnTmc4mGsqfp
         GNPtAx9uOchcvfqsV6n8mJ7X2bqqfhcEvlmMhtTjFFsNNKeU4l6O6NJFrj3afOWefOz1
         TwjZueFaZMegw+tjoNnPd/ykQ0c12EGOcP7gtAiEsnl8XloXRPvMsC+myJ15FSOyLZgA
         DSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689758284; x=1692350284;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bR6aQXx5gvtM8troROxyJmOZ+pi9iajw/Z15AHeaio=;
        b=MLx5pH1FCBX6a+RqTMc5pYVkGrMt6vXWM+nFPsxu+HMt0NxngxIwOXy6nYDoSiKVuB
         me4NTctVCYSjGXLTAmVEGY6PWvc+xI66qXbyA2BiSgOBbCO7Y2qrjNJel0tSMvDvbMJY
         Cv4BlPvwJf4fVHuzaqk/oPDiuivzbjz9CLxc4VJvantcTd/O9u+ntEwUM+4oFWJ24/jP
         xqxqVKsO2KQFK+woHwsSoPNcnMHMw75xNyTeal9hY5LcPbZ/S8BAvXVNvr8p7j3rGByn
         5VSUFHTIilRHWnfBM/4oasmR6hIKrl86aqBYoXK1ym4OQnNy57bmlNP1yPX/3kgBIkMl
         jraw==
X-Gm-Message-State: ABy/qLaKFCJ1eueBKWkaGAoaGFSDfL2XzFC6OdVYThWulldxt/9KFGzq
        E7H8r2PrqqFLxsm005Vta8JMQuqvRboFZUsNgrRqCA==
X-Google-Smtp-Source: APBJJlFegdZTVHyt7GrEMcFiknGLKSDT6xWCe7LltsFQrdarnRlnbEqzhTEm8K9uOAbfXVzsEnfndA==
X-Received: by 2002:ac2:4553:0:b0:4f8:cd67:88e6 with SMTP id j19-20020ac24553000000b004f8cd6788e6mr11961116lfm.44.1689758284109;
        Wed, 19 Jul 2023 02:18:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id y11-20020aa7d50b000000b0051e2a4edfd5sm2408972edq.21.2023.07.19.02.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 02:18:03 -0700 (PDT)
Message-ID: <e99c428f-0d70-cfee-dcc1-d82b2d270390@linaro.org>
Date:   Wed, 19 Jul 2023 11:18:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/7] ARM: dts: exynos: k3g: Document the devices which are
 not supported
Content-Language: en-US
To:     Markuss Broks <markuss.broks@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230716220644.22158-1-markuss.broks@gmail.com>
 <20230716220644.22158-8-markuss.broks@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230716220644.22158-8-markuss.broks@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 00:05, Markuss Broks wrote:
> Add placeholders for peripherals which we currently lack support for.
> This includes Maxim MAX86900 heart rate sensor and oximeter, which
> seems to be similar to other health sensors by Maxim, but it is not
> fully compatible; STM32F401 MCU which acts like a sensor hub,
> which can be flashed and controlled via the SPI bus, for which I made
> some simple firmware to check if it's possible to program with custom
> code, and it appears you can do so, but at the moment kernel lacks
> the APIs to either control sensors directly through the MCU or any
> standards for a sensor hub, so it's laid off; WM5110 audio codec which
> fails to communicate for some reason.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> ---
>  arch/arm/boot/dts/exynos5422-samsung-k3g.dts | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
> index 813dbf0438de..e019b630db94 100644
> --- a/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
> +++ b/arch/arm/boot/dts/exynos5422-samsung-k3g.dts
> @@ -743,6 +743,24 @@ rmi4-f12@12 {
>  	};
>  };
>  
> +&i2c_3 {
> +	status = "okay";
> +
> +	/* Maxim MAX86900 heart rate sensor and oximeter on address 0x57 */
> +};
> +
> +&spi_0 {

The node overrides/extends are ordered by name.



Best regards,
Krzysztof

