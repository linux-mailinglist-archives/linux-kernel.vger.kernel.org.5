Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11565761C24
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjGYOpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjGYOpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:45:47 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4001BE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:45:37 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso8550970e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690296336; x=1690901136;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/kUiRi3u6N/MlZfNyxNPzUi1P0ixrcFS1M9c/d06CFs=;
        b=r/jjD9Z+xBB2xS48NeGdh1lL2g6bxa+UQFoL4wsbT9TAkzPJTyl5CcrinTlF1B3wBj
         Ow7mLUGvdnCJ1NCIMLbyDQFNbe164vq+9RVLRS/qUiDIKGC8dsG0yOSNR1+73kf1UnTu
         Q9EKuSz0aur+6UlWGC0O/EXHRkmwNbiRwOa3zJUS3iOZMaa7VJVNkkZDFH4XgUcd1cE7
         x23125TyRddoeKOgIP0+R8EZODBv1RWsq6+yP+5rPsM4Zqdq/XwDC606/PftMR5yVeq1
         f0skiLUu+wleT3GxIJ+GRTmDX1nVPNLTFwQ7VYdh4zSe51pg6AU6rSm3SdrFDF4vbNc3
         Zukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690296336; x=1690901136;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/kUiRi3u6N/MlZfNyxNPzUi1P0ixrcFS1M9c/d06CFs=;
        b=cxn1iJf9o3HcEouSeJLToZ0wjyPTZIvojKHAuvUH5b4BOR27I8qbgXqoW/hoGTVVVJ
         FEB0n4AlG9iGwdiFfmrfmIQ/Ws+Rc2+JqzBksEaui8FUIALRQNMu9sB1tI4hOkIKfNT0
         sOwjkjcdD1A2J6TCWK52gSMa53F8LT+xn9GBI7mQYuQphsiT2oPG/h41UK/UNK79nrtI
         ngAP6Bs86mDzZktOsJbLU6VXm+MPXB0/Puh8Ck/pZ9dHtP+Lw+2l1YBs35SMBfd4sHfW
         gud2OZG2CruFsA8HWuDNzl6d+YovhzB0o2C966sJxoBWJlLb4KZKyT1t2+u/0MfV9PHY
         7JcA==
X-Gm-Message-State: ABy/qLYMi/rsmAEO5Ur9oDZrf6IkCxfNYItvxxOgHlDg6/3jAkhDSMjJ
        tzg9kaMJurHOO0wl+GR3qRsYsA==
X-Google-Smtp-Source: APBJJlEVKYMU8f4DH0Q82swoJYLy9X0XIaOIkFMSXGSpVuRgeC5yLC97u/k2iksHFXGURNITwuwbyw==
X-Received: by 2002:ac2:5e71:0:b0:4fb:89bb:ca19 with SMTP id a17-20020ac25e71000000b004fb89bbca19mr6560739lfr.66.1690296335660;
        Tue, 25 Jul 2023 07:45:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id y11-20020a056402134b00b0051de018af1esm446407edw.59.2023.07.25.07.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 07:45:35 -0700 (PDT)
Message-ID: <11b08764-87bd-1d9b-a1d2-603193231f40@linaro.org>
Date:   Tue, 25 Jul 2023 16:45:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: mfd: st,stpmic1: Add missing
 unevaluatedProperties for each regulator
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        pascal Paillet <p.paillet@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230725123740.149559-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230725123740.149559-1-krzysztof.kozlowski@linaro.org>
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

On 25/07/2023 14:37, Krzysztof Kozlowski wrote:
> Each regulator node, which references common regulator.yaml schema,
> should disallow additional or unevaluated properties.  Otherwise
> mistakes in properties will go unnoticed.  unevaluatedProperties:false
> requires listing existing properties (present in example and in other
> regulators of this device).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/st,stpmic1.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
> index 97c61097f9e2..1a1ced489ef7 100644
> --- a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
> +++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
> @@ -189,6 +189,16 @@ properties:
>  
>        "^(buck[1-4]|ldo[1-6]|boost|vref_ddr|pwr_sw[1-2])$":
>          $ref: ../regulator/regulator.yaml
> +        unevaluatedProperties: false
> +
> +        properties:
> +          interrupts:
> +            maxItems: 1
> +
> +          st,mask-reset:
> +            description: mask reset for this regulator, the regulator configuration
> +              is maintained during pmic reset.
> +            $ref: /schemas/types.yaml#/definitions/flag

After further testing I see this patch is wrong. There are already
buck[1-4] entries, so this is duplicating things. I will send v2.

Best regards,
Krzysztof

