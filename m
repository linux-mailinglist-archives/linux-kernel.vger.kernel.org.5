Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC59771A70
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjHGGcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjHGGcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:32:15 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6ED170A
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 23:32:12 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso41541105e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 23:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691389931; x=1691994731;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oomhBhepoHb+LZTOC+J99yf3KAYX+GX+1Abo9ZCPz1o=;
        b=W7qj3uHZTLBXRX3It5fbtH7ths8eUwVoZoSWE4Vsr8wlY7IxiHplDPfetKko8azlk4
         eMqw5knbYxgVxzkAuFK8lRfmwNC30zl+S4llTCTrAMa846RfzkikE3GCUMHK9mbF3Kbs
         W4V9pql5g+rCwf15ggmx9UUHAH9XxiWI+WtmiJpkV4BjyW7edG7miW10High2Xs5dTBj
         d9BRsqdLxNu5LFWzYt/4YyZjeHRUM90XWiccSjrXP8La7TLS91znMIXfFn6uV8uQ7YFY
         0UsYn9HcHfKB222WSnqcig5vGfuo+UicUbdte4oxHhhcgS4lDX3vTocyK4ONzfRU5Mhi
         Xb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691389931; x=1691994731;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oomhBhepoHb+LZTOC+J99yf3KAYX+GX+1Abo9ZCPz1o=;
        b=LLB0Nfm7qK2GGIQjp/Qsr+eqIGhuEa4HGRo8Q5jvGbmB03uPDoXTpZQMu39Es1IZSb
         /a/Nibyo6Q9LLT3KWWh2CVFX+yTufdvEkes2fGj7nZUAuuwB1sy5lpOZUibx2Hqg1Tf3
         5M6MOeJYwI9qDk19U3qzWHV2/hFRU08GLx8DS7ewSNss99GYPh+XtPGAnNXHYo6ask7A
         +F5xdj/bUXn5cYwB6yh+/tdOE5cNqKlXYyYnyWUlsUhEjK/ALzC3navrt3YgT/gkLOMX
         rrWmcGrkTKDt440umqssD/izSnE+5bvaHIqom/DL6r6lkOHhO/6ChoHFvX54wy6ZJ29t
         9BGQ==
X-Gm-Message-State: AOJu0YyTTkTTCa0Lj/r9mAyZZQ8mRR9O+jHVaouA7PSYC7RiafM63wOx
        wW/pvFYf/XWphQfRnCHvJpq3DMFptMN26bkAAXw=
X-Google-Smtp-Source: AGHT+IH7DcldVCQggD34wEJoSwWjyBJnM+SXOdljJCRzRvbllJfi7VmNDhCQDm2i8faedqBT4iLBLA==
X-Received: by 2002:a05:600c:22da:b0:3fb:e254:b81e with SMTP id 26-20020a05600c22da00b003fbe254b81emr6593888wmg.12.1691389931142;
        Sun, 06 Aug 2023 23:32:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c024d00b003fc015ae1e1sm9634360wmj.3.2023.08.06.23.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Aug 2023 23:32:10 -0700 (PDT)
Message-ID: <3ed8a34b-5f7d-6547-7e34-35e4d0994bba@linaro.org>
Date:   Mon, 7 Aug 2023 08:32:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: qcom: add sc7180-lazor board
 bindings
Content-Language: en-US
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230804095836.39551-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20230804175734.v2.1.I7a950de49ec24b957e90d7fe7abd5f2f5f2e24c3@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230804175734.v2.1.I7a950de49ec24b957e90d7fe7abd5f2f5f2e24c3@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 11:58, Sheng-Liang Pan wrote:
> Introduce more sc7180-lazor sku and board version configuration,
> add no-eSIM SKU 10 for Lazor, no-eSIM SKU 15 and 18 for Limozeen,
> add new board version 10 for audio codec ALC5682i-VS.
> 
> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
> ---
> 
> Changes in v2:
> - add new entry rev9 with Parade bridge chip
> 
>  .../devicetree/bindings/arm/qcom.yaml         | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 450f616774e0..dce7b771a280 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -470,6 +470,11 @@ properties:
>            - const: google,lazor-rev8
>            - const: qcom,sc7180
>  
> +      - description: Acer Chromebook Spin 513 Parade bridge chip (rev9)
> +        items:
> +          - const: google,lazor-rev9
> +          - const: qcom,sc7180
> +
>        - description: Acer Chromebook Spin 513 (newest rev)
>          items:
>            - const: google,lazor
> @@ -491,6 +496,11 @@ properties:
>            - const: google,lazor-rev8-sku2
>            - const: qcom,sc7180
>  
> +      - description: Acer Chromebook Spin 513 Parade bridge chip with KB Backlight (rev9)
> +        items:
> +          - const: google,lazor-rev9-sku2
> +          - const: qcom,sc7180
> +
>        - description: Acer Chromebook Spin 513 with KB Backlight (newest rev)
>          items:
>            - const: google,lazor-sku2
> @@ -512,11 +522,26 @@ properties:
>            - const: google,lazor-rev8-sku0
>            - const: qcom,sc7180
>  
> +      - description: Acer Chromebook Spin 513 Parade bridge chip with LTE (rev9)
> +        items:
> +          - const: google,lazor-rev9-sku0
> +          - const: qcom,sc7180
> +
>        - description: Acer Chromebook Spin 513 with LTE (newest rev)
>          items:
>            - const: google,lazor-sku0
>            - const: qcom,sc7180
>  
> +      - description: Acer Chromebook Spin 513 Parade bridge chip with LTE no-esim (rev9)
> +        items:
> +          - const: google,lazor-rev9-sku10
> +          - const: qcom,sc7180
> +
> +      - description: Acer Chromebook Spin 513 with LTE no-esim (newest rev)
> +        items:
> +          - const: google,lazor-sku10
> +          - const: qcom,sc7180
> +
>        - description: Acer Chromebook 511 (rev4 - rev8)
>          items:
>            - const: google,lazor-rev4-sku4
> @@ -526,6 +551,11 @@ properties:
>            - const: google,lazor-rev8-sku4
>            - const: qcom,sc7180
>  
> +      - description: Acer Chromebook 511 Parade bridge chip (rev9)
> +        items:
> +          - const: google,lazor-rev9-sku4
> +          - const: qcom,sc7180
> +
>        - description: Acer Chromebook 511 (newest rev)
>          items:
>            - const: google,lazor-sku4
> @@ -545,11 +575,36 @@ properties:
>            - const: google,lazor-rev8-sku6
>            - const: qcom,sc7180
>  
> +      - description: Acer Chromebook 511 Parade bridge chip without Touchscreen (rev9)
> +        items:
> +          - const: google,lazor-rev9-sku6
> +          - const: qcom,sc7180
> +
>        - description: Acer Chromebook 511 without Touchscreen (newest rev)
>          items:
>            - const: google,lazor-sku6
>            - const: qcom,sc7180
>  
> +      - description: Acer Chromebook 511 Parade bridge chip no-esim (rev9)
> +        items:
> +          - const: google,lazor-rev9-sku15
> +          - const: qcom,sc7180
> +
> +      - description: Acer Chromebook 511 no-esim (newest rev)
> +        items:
> +          - const: google,lazor-sku15
> +          - const: qcom,sc7180
> +
> +      - description: Acer Chromebook 511 Parade bridge chip without Touchscreen no-esim (rev9)
> +        items:
> +          - const: google,lazor-rev9-sku18
> +          - const: qcom,sc7180
> +
> +      - description: Acer Chromebook 511 without Touchscreen no-esim (newest rev)
> +        items:
> +          - const: google,lazor-sku18

All of these entries (existing and new) should be just one entry with:
 - enum:
     - ....
     - ....
 - const: qcom,sc7180

Best regards,
Krzysztof

