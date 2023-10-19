Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B017CF3ED
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345073AbjJSJU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345070AbjJSJU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:20:56 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337A3115
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:20:53 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4083cd39188so12638555e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697707251; x=1698312051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TSlsagBKkgJ+2a+MiKZlopa82SyFbytA+9bZGE9UX8o=;
        b=gfmK15sddpvPwD2n8E7S9mlIO5u+HBiy2wp8xJawfuZ0aqpJkgnrJt/Ff3ZUGycFkQ
         ++eigCaRm2ypsjPPWmZNWHZtU59gFcLp3TqmLqzoQd4Apt7wcNfxd50EWbYTfOZr5yOB
         pEPuUIMd4UX1hpQg7pvT5ee/NPJr1/Za2HesZow7HiCSVNeWdz0S9t43GJA8dDAkkIaE
         TV1zve1X9G3smFtDW93Ht6Ra3sU18Rs4gnIsrcLCLcr/IXf21n6kFvJe2Q/RnehbbeHZ
         A4NizTFU9X9CAOq7mjCSywQuDomSXtYM1NjAAcvX886cUe0cfWijG/6m0SauQuTZ+uNb
         +r+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697707251; x=1698312051;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TSlsagBKkgJ+2a+MiKZlopa82SyFbytA+9bZGE9UX8o=;
        b=JBz/QlmZQDtSGAv6GPS32+rVOTU7MXB/mBY2Qgxsp0IqBhzIjVwRUPlx5aaN3LB5if
         tehszQDe6dUqbkoTBrqvMCwhCidx3+iiZ0b5VrtyJ349i645gPmHH/naRJE+HOBHziBb
         H4gPRZnWBFpOhNkfw0715JyXgq+P3VCKc8OIn+0qFsgPxaVrMnQnLmWZK4djCiBGaftI
         qQ4JSjMdCikKOxEwPy5jeFnIPO4W0L3CYGbFiG/U+NMCzmHrUBJcOGaL6v0IpXogzl+R
         c72EbnHN5a6eeMjv4rMyEMK5OKdu2X7x2fI5m/j40dKQY70f4XGbAFuS4JIxuIEjYitf
         ncrg==
X-Gm-Message-State: AOJu0YxE1aIOhqzHlNN0U2QBHJxvlCq3Xey7xrT1Tiym9tOccNh4sCCd
        BFtpfqOSKunllVArUCk/2EaPJQ==
X-Google-Smtp-Source: AGHT+IEE0s9F102bpcIi450J9v5xUWWU+eXtKlLCzDqJYZNRPJfOCkrrWJ4faOUi+qRam2YQy4FCmw==
X-Received: by 2002:a05:600c:138f:b0:3fe:dcd0:2e32 with SMTP id u15-20020a05600c138f00b003fedcd02e32mr1405657wmf.19.1697707251438;
        Thu, 19 Oct 2023 02:20:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id f13-20020a1c6a0d000000b003fe23b10fdfsm3850668wmc.36.2023.10.19.02.20.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 02:20:51 -0700 (PDT)
Message-ID: <472aa31d-7d6c-41df-86e6-d17f05998256@linaro.org>
Date:   Thu, 19 Oct 2023 11:20:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: iio: light: Squash APDS9300 and APDS9960
 schemas
Content-Language: en-US
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231019080437.94849-1-subhajit.ghosh@tweaklogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231019080437.94849-1-subhajit.ghosh@tweaklogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2023 10:04, Subhajit Ghosh wrote:
> Squashing Avago (Broadcom) APDS9300 and APDS9960 schemas into one
> file and removing the other.

Please answer: why?

> Link: https://lore.kernel.org/all/4e785d2e-d310-4592-a75a-13549938dcef@linaro.org/
> 
> Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> ---
>  .../bindings/iio/light/avago,apds9300.yaml    | 35 ++++++++++++---
>  .../bindings/iio/light/avago,apds9960.yaml    | 44 -------------------
>  2 files changed, 29 insertions(+), 50 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9960.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
> index 206af44f2c43..7826a1749fcd 100644
> --- a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
> @@ -4,17 +4,26 @@
>  $id: http://devicetree.org/schemas/iio/light/avago,apds9300.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Avago APDS9300 ambient light sensor
> +title: Avago Gesture, RGB, ALS and Proximity sensors
>  
>  maintainers:
>    - Jonathan Cameron <jic23@kernel.org>
> +  - Matt Ranostay <matt.ranostay@konsulko.com>
>  
>  description: |
> -  Datasheet at https://www.avagotech.com/docs/AV02-1077EN
> +  Avago (Broadcom) optical and proximity sensors with I2C interfaces.
> +  Datasheet at https://docs.broadcom.com/doc/AV02-1077EN
> +  Datasheet at https://docs.broadcom.com/doc/AV02-4191EN
>  
>  properties:
>    compatible:
> -    const: avago,apds9300
> +    oneOf:
> +      - items:
> +          - const: avago,apds9300
> +          - const: avago,apds9960


Why? Commit msg does not explain this.

> +      - enum:
> +          - avago,apds9300
> +          - avago,apds9960
>  
>    reg:
>      maxItems: 1
> @@ -22,14 +31,28 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -additionalProperties: false
> -
>  required:
>    - compatible
>    - reg
>  
> +allOf:
> +  - $ref: ../common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - avago,apds9960
> +    then:
> +      required:
> +        - interrupts

Why? This wasn't in original binding.

> +
> +additionalProperties: false
> +
>  examples:
>    - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
>      i2c {
>          #address-cells = <1>;
>          #size-cells = <0>;
> @@ -38,7 +61,7 @@ examples:
>              compatible = "avago,apds9300";
>              reg = <0x39>;
>              interrupt-parent = <&gpio2>;
> -            interrupts = <29 8>;
> +            interrupts = <29 IRQ_TYPE_LEVEL_LOW>;

Separate patch please.

You are doing way too many unexpected and not explained changes.

Best regards,
Krzysztof

