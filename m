Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536087D4934
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjJXIDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjJXIDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:03:45 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEB2120
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:03:41 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9c5b313b3ffso590589866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698134619; x=1698739419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ql5Q8FOWaOd+nb6/H3/ESaBIL30yXZyLnkCaJtQzqT0=;
        b=UMOrs8rb5G2bZCm/pJc6O2B3+lANiBcJDN3j551uW2GjuYertlu3Boc4wB4wNS118c
         FtEpaBby1YHMCR1Jst1/BVolTh9YbQ3J6AilU9HyOvrbn5h6BrURsxt8wcnqYd3Dcodu
         iYhrBZjlnPta6j9EXKI1HR1gTBz428ull4vSgCod8n3fljPrIZqbM0Uil6wRfD0buBwl
         2c4dJeXYzEU6SvAlV//GtfG1RzME7QDWRGbZhXuNy3MldxDDpP8AZ1jOuMcNfdWoDW4Z
         wHrdzJYq3vGQOzBFdDWaeKwJJaz83jlX6W9xWmyNbZydg/f0Sk0ucaCjh4iuZSQXBFJU
         tkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698134619; x=1698739419;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ql5Q8FOWaOd+nb6/H3/ESaBIL30yXZyLnkCaJtQzqT0=;
        b=jNX9Me45rGQPqbXLQi/Fjznc2lOBjyqRc8KDSq+1eMEf9fiB5Dtmr6piIErdAC4k1M
         GFq/KoGvr+8RVmaV1+Qf30l3bXAoFlHFRLl+EgVSLP4t0vocQc2PDX852W4uKBxF4IHo
         YmJuYM4yB/WyBx8yMBgAYl1MGefBxJtdcWYC0Whahnf47rvuXAJk9wkDiCKDprltti9E
         sDXCob9ChbaMrAHTaBDFE33PnXmau/tv08hXimJkCT4R7b1BhX10iNbKjJEQuTgHJ4KZ
         TAcAZLMLoURZ7OVKSD/sRR5Q3fuL2+pqcpcKjpmsg6V3Eoz0U7CF1QFMZ1mWQMMfXHfm
         7F8w==
X-Gm-Message-State: AOJu0YwmUX4E6Kz92HDzE3SyZIWE7Rjx9xP5Uxic8FaoBH+VEaK1dOO0
        7jrBHzWWIEJAbtc9UokgIZO5kg==
X-Google-Smtp-Source: AGHT+IFVooAJl5fWHgr45jmFwB8Oe4BFvAgfTrtsvxzZZRlzL56/Mb5UBFVMkGxIF7wMbXAgxUggCA==
X-Received: by 2002:a17:907:7251:b0:9ad:e298:a5d with SMTP id ds17-20020a170907725100b009ade2980a5dmr10917817ejc.19.1698134619544;
        Tue, 24 Oct 2023 01:03:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id z16-20020a170906075000b009a5f1d1564dsm7806148ejb.126.2023.10.24.01.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 01:03:38 -0700 (PDT)
Message-ID: <91764d23-eed2-48f9-97c5-ac6a44f48f2b@linaro.org>
Date:   Tue, 24 Oct 2023 10:03:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 9/9] dt-bindings: net: add Microchip's LAN865X
 10BASE-T1S MACPHY
Content-Language: en-US
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, steen.hegelund@microchip.com,
        rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com,
        andrew@lunn.ch
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        horatiu.vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
        Thorsten.Kummermehr@microchip.com
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-10-Parthiban.Veerasooran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231023154649.45931-10-Parthiban.Veerasooran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2023 17:46, Parthiban Veerasooran wrote:
> Add DT bindings for Microchip's LAN865X 10BASE-T1S MACPHY. The LAN8650/1
> combines a Media Access Controller (MAC) and an Ethernet PHY to enable
> 10BASE‑T1S networks. The Ethernet Media Access Controller (MAC) module
> implements a 10 Mbps half duplex Ethernet MAC, compatible with the IEEE
> 802.3 standard and a 10BASE-T1S physical layer transceiver integrated
> into the LAN8650/1. The communication between the Host and the MAC-PHY is
> specified in the OPEN Alliance 10BASE-T1x MACPHY Serial Interface (TC6).

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> ---
>  .../bindings/net/microchip,lan865x.yaml       | 101 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/microchip,lan865x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/microchip,lan865x.yaml b/Documentation/devicetree/bindings/net/microchip,lan865x.yaml
> new file mode 100644
> index 000000000000..974622dd6846
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/microchip,lan865x.yaml
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/microchip,lan865x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip LAN8650/1 10BASE-T1S MACPHY Ethernet Controllers
> +
> +maintainers:
> +  - Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
> +
> +description:
> +  The LAN8650/1 combines a Media Access Controller (MAC) and an Ethernet
> +  PHY to enable 10BASE‑T1S networks. The Ethernet Media Access Controller
> +  (MAC) module implements a 10 Mbps half duplex Ethernet MAC, compatible
> +  with the IEEE 802.3 standard and a 10BASE-T1S physical layer transceiver
> +  integrated into the LAN8650/1. The communication between the Host and
> +  the MAC-PHY is specified in the OPEN Alliance 10BASE-T1x MACPHY Serial
> +  Interface (TC6).
> +
> +  Specifications about the LAN8650/1 can be found at:
> +    https://www.microchip.com/en-us/product/lan8650
> +
> +allOf:
> +  - $ref: ethernet-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: microchip,lan865x

No wildcards in compatibles.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Interrupt from MAC-PHY asserted in the event of Receive Chunks
> +      Available, Transmit Chunk Credits Available and Extended Status
> +      Event.
> +    maxItems: 1
> +
> +  local-mac-address:

Drop property, not needed.

> +    description:
> +      Specifies the MAC address assigned to the network device.
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +    minItems: 6
> +    maxItems: 6
> +
> +  spi-max-frequency:
> +    minimum: 15000000
> +    maximum: 25000000
> +
> +  oa-tc6:
> +    $ref: oa-tc6.yaml#
> +    unevaluatedProperties: true

This must be false.

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - pinctrl-names
> +  - pinctrl-0
> +  - interrupts
> +  - interrupt-parent
> +  - local-mac-address
> +  - spi-max-frequency
> +  - oa-tc6
> +
> +additionalProperties: false

Instead:
unevaluatedProperties: false

> +
> +examples:
> +  - |
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      ethernet@0 {
> +        compatible = "microchip,lan865x";
> +        reg = <0>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&eth0_pins>;
> +        interrupt-parent = <&gpio>;
> +        interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
> +        local-mac-address = [04 05 06 01 02 03];
> +        spi-max-frequency = <15000000>;
> +        status = "okay";

Drop status.

> +        oa-tc6 {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +          oa-cps = <64>;
> +          oa-txcte;
> +	  oa_rxcte;
> +	  oa-prote;
> +	  oa-dprac;

Again totally mixed up indentation.

> +        };
> +      };
> +    };

Best regards,
Krzysztof

