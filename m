Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D0375A649
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjGTGZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjGTGZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:25:48 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA0C2127
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:25:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fd190065a7so2693545e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689834342; x=1692426342;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQMHOjJYZ76TGhG8B0nlx/g+YkMmgmasZcqaKFcuJjM=;
        b=zeE415wH8jka8fvaJ69vhsN2OPoAzBmHBD40wozzyCzY7WwBPtXOddqoB5lhZtt6o/
         xoQvfNxWFWisjOHDEy5OKB4m1Tc+q4O+yGIC81p268YuN5K0iEYLhnfjicD7y0P6gDFU
         ddBqrW6e8lX96qowmYGINym9Fchz5uR0uzhwfu41pzu7OkB+Iv/fgcILX6zq6ecg209N
         CB1yHwqLs9itz57agB4yfWwLL02ry8X7HVB1tncj+hM36MDM1jtwvZ2l+tDqkDRZkiqz
         EufSS/E1P6g0z6LU69/wD3j0BeGxdtRf++iSFue8ZHuRpyO+prFNJNtZ/itJcxMtb9X5
         HLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689834342; x=1692426342;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQMHOjJYZ76TGhG8B0nlx/g+YkMmgmasZcqaKFcuJjM=;
        b=eaPsTXPKAst++skkiSQcQv9/OuqFwBIegD1RwWQOoVxBXs+69JNWdVkYaNPLb22GYb
         ODqr0xZjyH5nP3gIG72PUTgIm7vlhLAZpy4tEU2gJto8Tbv2KaWZ+tWP0HBrrBZKlcKP
         yCxvSYhu9I7hv67arnLvihyZwe8baL0i7mT8kMe6wXbc0eCBH2AB6jCLloyh1Bvw8E7Q
         O6c8bbfTscUrmooLtGPraKKaqSz4KGKbCwtU25aqrNNPLog9sN/O4OJR8UBbec6IHO8d
         pBdsZlAUF+8Qom3oTSHQzrc8wnHAYbHjPTJ0QNg3AAPn2HPZXCsAlVSbsM4ZGgpWgz8m
         c4Og==
X-Gm-Message-State: ABy/qLaI1LTjsW7QB6mP28XjhAkVCVWpIJryvHYfoLOwQJXOt0mI+59T
        Owk/zxqJYOnkHvvcknRvnHrANYJZi2DE9psiygM=
X-Google-Smtp-Source: APBJJlErniNxjsytxmWnSd3zFi4m0T93POcwGlPJw9URpkAQIVH3uYPfGB2oNqXPySV7wPgw0iuZhQ==
X-Received: by 2002:a5d:54c6:0:b0:316:f25c:d0c0 with SMTP id x6-20020a5d54c6000000b00316f25cd0c0mr1489597wrv.16.1689834342327;
        Wed, 19 Jul 2023 23:25:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id o20-20020a5d58d4000000b0031433443265sm284501wrf.53.2023.07.19.23.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 23:25:41 -0700 (PDT)
Message-ID: <4027f2f8-4d60-3907-ec36-4c9b0ca52214@linaro.org>
Date:   Thu, 20 Jul 2023 08:25:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/2] dt-bindings: usb: rockchip,dwc3: Add RK3588
 binding
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20230719174015.68153-1-sebastian.reichel@collabora.com>
 <20230719174015.68153-2-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230719174015.68153-2-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 19:40, Sebastian Reichel wrote:
> RK3588 contains three DWC3 cores. Two of them are connected to
> dedicated USBDP PHY and can be used in dual-role. The third is
> connected to one of the shared combo PHYs used for PCIe/SATA/USB3
> and can only be used in host mode. Since the binding is all about
> the PHY glueing and involved clocks, separate compatible values
> have been created for these two types.

The cores are the same. To which phy they are connected to, does not
justify difference in compatibles. It's still the same devoce.

> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/usb/rockchip,rk3399-dwc3.yaml    | 107 ++++++++++++++----
>  1 file changed, 85 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/rockchip,rk3399-dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,rk3399-dwc3.yaml
> index 3159f9a6a0f7..0db4dc86e506 100644
> --- a/Documentation/devicetree/bindings/usb/rockchip,rk3399-dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/rockchip,rk3399-dwc3.yaml
> @@ -11,7 +11,13 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: rockchip,rk3399-dwc3
> +    oneOf:
> +      - items:
> +          - enum:
> +              - rockchip,rk3588-dwc3-otg
> +              - rockchip,rk3588-dwc3-host
> +          - const: rockchip,rk3399-dwc3
> +      - const: rockchip,rk3399-dwc3
>  
>    '#address-cells':
>      const: 2
> @@ -22,35 +28,37 @@ properties:
>    ranges: true
>  
>    clocks:
> -    items:
> -      - description:
> -          Controller reference clock, must to be 24 MHz
> -      - description:
> -          Controller suspend clock, must to be 24 MHz or 32 KHz
> -      - description:
> -          Master/Core clock, must to be >= 62.5 MHz for SS
> -          operation and >= 30MHz for HS operation
> -      - description:
> -          USB3 aclk peri
> -      - description:
> -          USB3 aclk
> -      - description:
> -          Controller grf clock
> +    minItems: 3
> +    maxItems: 6
>  
>    clock-names:
>      items:
> -      - const: ref_clk
> -      - const: suspend_clk
> -      - const: bus_clk
> -      - const: aclk_usb3_rksoc_axi_perf
> -      - const: aclk_usb3
> -      - const: grf_clk
> +      oneOf:
> +        - enum:
> +            - ref
> +            - ref_clk

This is not oneOf. You cannot have here one clock. There is also no
point in making all these changes here,.

> +        - enum:
> +            - suspend
> +            - suspend_clk
> +        - enum:
> +            - bus
> +            - bus_clk
> +        - const: aclk_usb3_rksoc_axi_perf
> +        - const: aclk_usb3
> +        - const: grf_clk
> +        - const: utmi
> +        - const: php
> +        - const: pipe
> +    minItems: 3
> +    maxItems: 6
>  
>    resets:
>      maxItems: 1
>  
>    reset-names:
> -    const: usb3-otg
> +    enum:
> +      - usb3-host
> +      - usb3-otg

I don't see a point in changing this.

>  
>  patternProperties:
>    '^usb@':
> @@ -68,6 +76,61 @@ required:
>    - resets
>    - reset-names
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          const: rockchip,rk3399-dwc3
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 6
> +        clock-names:
> +          items:
> +            - const: ref_clk
> +            - const: suspend_clk
> +            - const: bus_clk
> +            - const: aclk_usb3_rksoc_axi_perf
> +            - const: aclk_usb3
> +            - const: grf_clk
> +        reset-names:
> +          const: usb3-otg
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3588-dwc3-otg
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: ref
> +            - const: suspend
> +            - const: bus

Use the same clock names.

> +        reset-names:
> +          const: usb3-otg
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3588-dwc3-host
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 6
> +        clock-names:
> +          items:
> +            - const: ref
> +            - const: suspend
> +            - const: bus
> +            - const: utmi
> +            - const: php
> +            - const: pipe

Same clock names

> +        reset-names:
> +          const: usb3-host

Same reset name.


Best regards,
Krzysztof

