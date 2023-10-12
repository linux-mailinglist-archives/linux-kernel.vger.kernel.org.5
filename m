Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6647C66C2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378076AbjJLHoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378051AbjJLHn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:43:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475BE90
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:43:57 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-313e742a787so329133f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697096636; x=1697701436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6pGb3HGceT5/2sWjhWBJAACKQ5znAHiL9SXNlGtYAVU=;
        b=XpRk4LoW8NG/6ivu/yLDQ0Kih+zA07VKEpIaJ5kt7b7n+ezYDxmN52gXTJ9SVmNFHX
         hdBqlF4elBpB020rVsaBt9eqFYo/UevkSUIrVCrgMVFtxTZlxTNAbxNEfNSBfZne14CL
         gFFTFGtAZub0SRLFZ19a3JuV8pWGWC3qVk64D/GosCb2o0qk85Xpe7Bfkb/VCl+1eIg6
         q0nsli6bVdxVAMg4oEamiLIwNvUenzGLc3P8K4AQVt6bbMTknSUvlkyrdMaNnW0j0jMO
         e+rqp6gfNcbiDjMWxpCfwFUIhKmDYzEMShFbOWFBuzu3BNbk7lbHgVTuIdUFUnxGzUXW
         WVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697096636; x=1697701436;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6pGb3HGceT5/2sWjhWBJAACKQ5znAHiL9SXNlGtYAVU=;
        b=iHxSFzSToqhWpdIrwgPZ6AtvSeaYwAqX//dX8lGlRb3eH43iLUBjp3Jh92Ty/5Wptr
         PnYtwZ9v7JLb2/HgP2KvZIQomPqHbRBULPh30B7OMV/eWVhmkrRLdzBQwOMIOdx1ogjB
         b0meyIT4gs/qPuZY3qtRZjOxp4UNuz2qNqISPcT3IK8gwqufky/gxANfAsiIa0CBkgjp
         5gppx1XxWgpz0vyX6v3gFi7OdQDFVBX+NNl5m5IQXsPsd53Xnj6hOOGZLXXwf4v85QaL
         ng1DViRGi/AsT7LSG5YHiM+81bErqpEjbMmt9iso2SpEeMgyxF2Sn3Q5R6ZEDuHPGMwZ
         Cwbw==
X-Gm-Message-State: AOJu0Yz3Fe25kZl5cxTpFpiDee5AADJjUeUcUvuIaQstFRQzXBmLLFfp
        ioUgsLh3Xw1YJBby64O/EA3B1w==
X-Google-Smtp-Source: AGHT+IFaWxysZLgTN32QN8lGWXQc+RXod5GHTptPjZL4LBGic628OKN+rsGkNpFfMStt2tFVcBuAVg==
X-Received: by 2002:adf:ff88:0:b0:319:5234:5c92 with SMTP id j8-20020adfff88000000b0031952345c92mr14497982wrr.35.1697096635651;
        Thu, 12 Oct 2023 00:43:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d43cf000000b003233b554e6esm17680843wrr.85.2023.10.12.00.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 00:43:55 -0700 (PDT)
Message-ID: <abe72aae-c43c-487a-8021-2c0f54319a5b@linaro.org>
Date:   Thu, 12 Oct 2023 09:43:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Add the binding example for the
 Genesys Logic GL3523 hub
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231011051152.133257-1-linux.amoon@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231011051152.133257-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2023 07:11, Anand Moon wrote:
> Add the binding example for the USB3.1 Genesys Logic GL3523
> integrates with USB 3.1 Gen 1 Super Speed and USB 2.0 High-Speed
> hub.

That's not what the patch does.

> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> New patch.
> ---
>  .../bindings/usb/genesys,gl850g.yaml          | 28 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> index d0927f6768a4..2f6e0c870e1d 100644
> --- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> +++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
> @@ -22,29 +22,51 @@ properties:
>    reg: true
>  
>    reset-gpios:
> +    maxItems: 1

Why?

>      description: GPIO controlling the RESET# pin.
>  
>    vdd-supply:
>      description:
>        the regulator that provides 3.3V core power to the hub.
>  
> +  peer-hub:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to the peer hub on the controller.
> +
>  required:
>    - compatible
>    - reg
> +  - reset-gpios

Why?

> +  - vdd-supply
> +  - peer-hub
>  
>  additionalProperties: false
>  
>  examples:
>    - |
>      #include <dt-bindings/gpio/gpio.h>
> +
>      usb {
>          dr_mode = "host";
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> -        hub: hub@1 {
> -            compatible = "usb5e3,608";
> +        /* 2.0 hub on port 1 */
> +        hub_2_0: hub@1 {
> +            compatible = "usb5e3,610";
>              reg = <1>;
> -            reset-gpios = <&pio 7 2 GPIO_ACTIVE_LOW>;
> +            vdd-supply = <&vcc_5v>;
> +            peer-hub = <&hub_3_0>;
> +            reset-gpios = <&gpio 20 GPIO_ACTIVE_LOW>;
> +        };
> +
> +        /* 3.1 hub on port 4 */
> +        hub_3_0: hub@2 {
> +            compatible = "usb5e3,620";
> +            reg = <2>;
> +            vdd-supply = <&vcc_5v>;
> +            peer-hub = <&hub_2_0>;
> +            reset-gpios = <&gpio 20 GPIO_ACTIVE_LOW>;

Really, what is happening here?

Best regards,
Krzysztof

