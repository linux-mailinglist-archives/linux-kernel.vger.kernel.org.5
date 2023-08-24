Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC55E7867AA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbjHXGoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240188AbjHXGoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:44:09 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE7C1707
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:43:56 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52889bc61b6so8392745a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692859434; x=1693464234;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ti0tJCov0gsw8bly+e2gyZeZthleb2G4QELgyb6xbJk=;
        b=I1zZJTfjm821j0x0yIfW4QMqklnH56r4qmM4t/5dYbVuZvxkzL6f3cpaltMFY/XXb5
         EbBmse/2gH7Az1sjHnvD9d+bFlnXxuvT+dLR4XipRXRu1xwKka+Q9LO1v+FFzL+GIaWz
         0cVmlYk9dfAS+JngsrZjYRBPG+0nml6up0U9AIoleTYqjuor4sjx9/J71jj6x5FSSxDb
         vslV6rKx06UALgB1NX3JGRM1uHitgAyN5A8+zq5pvCynRMWjsL7Gqq5Xpmeu+eaSQE1v
         B/ivDRgW24kbp+udc2TWTWgk1ia0hjrO4iUBWDsezAR6QDlNXXxd9oR59pEWV/KdP+G5
         TkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692859434; x=1693464234;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ti0tJCov0gsw8bly+e2gyZeZthleb2G4QELgyb6xbJk=;
        b=LriF/xjiU0Xy0LbhMLBFqKDzqONTNAJR3m0POGu/qriV1U7hPEewZEnkkPflHbxgYl
         JzzQ/KFATLFz7FYXrGsP4xGBCMDuOjY11UkA4JZjV6I/osrz0Ojc1tPcJQyaCuLRNjEA
         COVyC9A5vZMY817HWRVFA4k7yDpnJGpz99iyK0Z2nWpyUQGAjii89ujHKyjcgNxOmxkw
         12WkAVlZnG5tMiXonyLB+VUmX6AaBda93mQzIgvfarTvPgTH9KjPHlTIYmICfeNXsd4n
         YDMHDSN3GMQXfAm/CAebYyvIOG45GfV563nMvXNzbbuA8ewtYQVfNA5A/8FrJ2wQ2BQv
         Fe+g==
X-Gm-Message-State: AOJu0YzfmOmVUjOrDFaqw0wsVJZTVLR88yDWQrAnVlsmUV7l+QBTc5K8
        ydan0BAeRxqONJf3nU6+tF9aRg==
X-Google-Smtp-Source: AGHT+IEQvZYgarQloyMnR+HnLjWh6aBRXyE5c7u2/JigeeURkpGl76ThL5cokigKZvqW5eh82CHhgg==
X-Received: by 2002:aa7:d34f:0:b0:523:b1b0:f69f with SMTP id m15-20020aa7d34f000000b00523b1b0f69fmr10351857edr.32.1692859434571;
        Wed, 23 Aug 2023 23:43:54 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id x21-20020aa7dad5000000b0052284228e3bsm10068665eds.8.2023.08.23.23.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 23:43:54 -0700 (PDT)
Message-ID: <d5a343c8-c384-6eea-94bf-e0c4f96e5fb0@linaro.org>
Date:   Thu, 24 Aug 2023 08:43:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v6 1/5] dt-bindings: net: Add ICSS IEP
Content-Language: en-US
To:     MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     nm@ti.com, srk@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230823113254.292603-1-danishanwar@ti.com>
 <20230823113254.292603-2-danishanwar@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230823113254.292603-2-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2023 13:32, MD Danish Anwar wrote:
> Add a DT binding document for the ICSS Industrial Ethernet Peripheral(IEP)
> hardware. IEP supports packet timestamping, PTP and PPS.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Really? Where?

> Reviewed-by: Roger Quadros <rogerq@kernel.org>

Now you are making things up. Please stop faking tags.

> Reviewed-by: Simon Horman <horms@kernel.org>

Where?

> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  .../devicetree/bindings/net/ti,icss-iep.yaml  | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/ti,icss-iep.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
> new file mode 100644
> index 000000000000..75668bea8614
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/ti,icss-iep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments ICSS Industrial Ethernet Peripheral (IEP) module
> +
> +maintainers:
> +  - Md Danish Anwar <danishanwar@ti.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - ti,am642-icss-iep
> +              - ti,j721e-icss-iep
> +          - const: ti,am654-icss-iep
> +
> +      - const: ti,am654-icss-iep
> +
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: phandle to the IEP source clock
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +

Drop stray blank line

> +    /* AM65x */
> +    icssg0_iep0: iep@2e000 {
> +        compatible = "ti,am654-icss-iep";
> +        reg = <0x2e000 0x1000>;
> +        clocks = <&icssg0_iepclk_mux>;
> +    };

Choose one example.


Best regards,
Krzysztof

