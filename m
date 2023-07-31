Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAF77690BF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjGaItD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjGaIs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:48:26 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC289172B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:46:44 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-317716a4622so3901753f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690793203; x=1691398003;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wr9S1xevkiceWDkqzJOGXDauW47kODXtzJg0v0eVCYQ=;
        b=Fk8MgaPoFog3wIA3AJUKoUQceKgnRMQRHry3wmSVur7INMe7B2zyLfuQIc5HDSTuPj
         AtRU+XI7m8jAzTyoL1ZFpeGk19OGWmEFBbbhW3j2evZ+Y/L7TdrXBM7aOaJ3i2b6blDv
         fbm88HFPhW/6QQqAj4VsH7mYdO2HNe4Bt9bN8PWCDeBU4O+3JZmdOKEkVgn3dWAlBEUy
         qfRto9lbq5TKDd1K4sX/7XyHztv3NQaxRlnb09svePujAmMXKmAthtVf1S7ZBUXce/HH
         O1+iRm3V/RyM7+TmIUPymkTtXmIkqvQkvet5NCtBsIC1fH0LRBech3gu2/t73GHzi3h5
         vVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690793203; x=1691398003;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wr9S1xevkiceWDkqzJOGXDauW47kODXtzJg0v0eVCYQ=;
        b=Q3M3Papqf2TnfL6m+GQtRZSpfLk0EHYFmCWqnRs6cVYj2bF5/1pGCymD0A3lcaVT5b
         /oFg3YYfDxDtdrwnUmiK+3T0VR68RF8l+qQ3g7oC+a9Weo1xWIaKYGtkSitYtFbLR4Ug
         5SwPT+S5cMp1yClZ8wTxtJQJy6f488R512zZINkRPYsLvSudNKRvm+6mggkV5qCXUr/F
         KqdFYi6nUkyosIYkEgVgIg7MiD9fjUVyAwpO9H26A68+qozuD3KRtw2A0AQa1k9nKnTI
         +kS1QmdjsXk7LUqjcBzo0tkXOuLxUfCt8EH38f2sVedAJih9ehu03Ad1xNffvqpWx5Xq
         gD9w==
X-Gm-Message-State: ABy/qLYXPSwbc7hXb4CJAY1B72oH1OdQw83EBZUudo4WEGM5+U1FwNEQ
        1pZXGLwHn3G4B8v+o00SDu9bIyN8HZQVuo55iIQFypsQ
X-Google-Smtp-Source: APBJJlGReOaWf7EDwA4liFEYkK+faS6psAGzATwisa4wFGMbpJ2OF/FRsZPrmGGGYkW1JAMOFAF8Pg==
X-Received: by 2002:a5d:63c8:0:b0:317:6be9:538a with SMTP id c8-20020a5d63c8000000b003176be9538amr5711448wrw.20.1690793203393;
        Mon, 31 Jul 2023 01:46:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d? ([2a01:e0a:982:cbb0:14b8:9aa7:6bf0:256d])
        by smtp.gmail.com with ESMTPSA id d12-20020a5d644c000000b003142e438e8csm12443440wrw.26.2023.07.31.01.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 01:46:42 -0700 (PDT)
Message-ID: <7ecdb9c9-6620-67b5-be46-a36490e7ba33@linaro.org>
Date:   Mon, 31 Jul 2023 10:46:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: amlogic: meson-g12b-bananapi: switch to
 enable-gpios
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230725142703.157547-1-krzysztof.kozlowski@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230725142703.157547-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 16:27, Krzysztof Kozlowski wrote:
> The recommended name for enable GPIOs property in regulator-gpio is
> enable-gpios.  This is also required by bindings:
> 
>    meson-g12b-bananapi-cm4-cm4io.dtb: regulator-vddio-c: Unevaluated properties are not allowed ('enable-gpio' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
> index 97e522921b06..86adc1423385 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4.dtsi
> @@ -56,7 +56,7 @@ vddio_c: regulator-vddio-c {
>   		regulator-min-microvolt = <1800000>;
>   		regulator-max-microvolt = <3300000>;
>   
> -		enable-gpio = <&gpio_ao GPIOAO_3 GPIO_OPEN_DRAIN>;
> +		enable-gpios = <&gpio_ao GPIOAO_3 GPIO_OPEN_DRAIN>;
>   		enable-active-high;
>   		regulator-always-on;
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
