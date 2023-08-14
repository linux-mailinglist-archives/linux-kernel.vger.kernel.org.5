Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9DE77C0EA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbjHNTj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjHNTjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:39:46 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4154410FA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:39:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe1d462762so43469455e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692041983; x=1692646783;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ROJLZco4JemYu/fTJva9m2yQGXFsGiO+fv8ztilfBjQ=;
        b=KF9WyC6F4AqBJ1aAZHoYv2xC1p85qxmd3RbkyvrS2gpAibZnmBZG5yMJzd+wHbKxeL
         J3a3UW5zyVBBHGq+BsT80gB3K6beqW8yanN66BAdfC+W9IF+b9EGrj8o1dhX1HQ2Lxec
         crhpZVjLnVNyb75OE9qMkwFLDb3iH4STnPlUrJybOul4vucN0XHD4Px86IbacwPu9qIa
         F6E+2ZpdkwDIHopBAhxKdWagtNZ+WeTEe6+xXZjg2YKmNXpYzfgczv6RZjYbqaqkS6no
         bfuvgtSpnhXv/W0QJ4Q05oMfRi29w+Se64dabrimPLQflRUNCjBdjNMDi60yUyZkTIEs
         Zc2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692041983; x=1692646783;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ROJLZco4JemYu/fTJva9m2yQGXFsGiO+fv8ztilfBjQ=;
        b=IZGLFD7TAT5SL2LNJkNwILSBDc8s4J4Q3k1WhOChlnMiMaRScRWs2n11yLneXhmn1m
         SdzIg0owtxfZAdDrQ6I7scRJwllpnXiADGOfiobA7BibzY1XF+or2GSBoTJiRHcCGAd1
         NK2c5B2/i7GqJBBz5KjPg1xknecMLGf0i37yVL735FAfoOFftUtHvxf1zkVnfOxvN1Zp
         PPg8yS2NFx6TsDSyGloTTJayE2or+y0PRdjKarid/TUmg2/I+2X3k61i8tDwEZE4cMPJ
         BNLRvX0m73hj94UF/cuEqbITKb/zIpxI0tAAIye1SHjF+4FpYKX7HPucG1b0VeX0VbVg
         96rw==
X-Gm-Message-State: AOJu0YzuYi1pwLKolgGigmJn9dAeJ/AM764GdCi8aaKYGITGy91jJfM/
        jmqis29lEV1FgihlGzPZPgiHQg==
X-Google-Smtp-Source: AGHT+IG+r1hJetgi+phkFK5PuwtBM/rf++axV4VBx0RhCpdoo3UabLGB6RkubzEpT25nkpJrsb3ubg==
X-Received: by 2002:a05:600c:214d:b0:3fc:62c:8275 with SMTP id v13-20020a05600c214d00b003fc062c8275mr8454710wml.35.1692041982710;
        Mon, 14 Aug 2023 12:39:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id y21-20020a7bcd95000000b003fc00892c13sm15448673wmj.35.2023.08.14.12.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:39:42 -0700 (PDT)
Message-ID: <16eab776-07d4-3c31-7e82-444863303102@linaro.org>
Date:   Mon, 14 Aug 2023 21:39:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/4] dt-bindings: net: Add FSD EQoS device tree
 bindings
Content-Language: en-US
To:     Sriranjani P <sriranjani.p@samsung.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, richardcochran@gmail.com,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, alim.akhtar@samsung.com,
        linux-fsd@tesla.com, pankaj.dubey@samsung.com,
        swathi.ks@samsung.com, ravi.patel@samsung.com
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
 <CGME20230814112605epcas5p31aca7b23e70e8d93df11414291f7ce66@epcas5p3.samsung.com>
 <20230814112539.70453-2-sriranjani.p@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230814112539.70453-2-sriranjani.p@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2023 13:25, Sriranjani P wrote:
> Add FSD Ethernet compatible in Synopsys dt-bindings document. Add FSD
> Ethernet YAML schema to enable the DT validation.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
> Signed-off-by: Swathi K S <swathi.ks@samsung.com>
> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   |   5 +-
>  .../devicetree/bindings/net/tesla,ethqos.yaml | 114 ++++++++++++++++++
>  2 files changed, 117 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/tesla,ethqos.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index ddf9522a5dc2..0ced7901e644 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -96,6 +96,7 @@ properties:
>          - snps,dwxgmac
>          - snps,dwxgmac-2.10
>          - starfive,jh7110-dwmac
> +        - tesla,fsd-ethqos-4.21

I don't think one given SoC - and I was told FSD is strictly defined one
specific SoC - can have different versions of the same block, so drop
the block versioning.

>  
>    reg:
>      minItems: 1
> @@ -117,7 +118,7 @@ properties:
>  
>    clocks:
>      minItems: 1
> -    maxItems: 8
> +    maxItems: 10
>      additionalItems: true
>      items:
>        - description: GMAC main clock
> @@ -129,7 +130,7 @@ properties:
>  
>    clock-names:
>      minItems: 1
> -    maxItems: 8
> +    maxItems: 10
>      additionalItems: true
>      contains:
>        enum:
> diff --git a/Documentation/devicetree/bindings/net/tesla,ethqos.yaml b/Documentation/devicetree/bindings/net/tesla,ethqos.yaml
> new file mode 100644
> index 000000000000..b78829246364
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/tesla,ethqos.yaml
> @@ -0,0 +1,114 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/tesla,ethqos.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: FSD Ethernet Quality of Service
> +
> +maintainers:
> +  - Sriranjani P <sriranjani.p@samsung.com>
> +  - Swathi K S <swathi.ks@samsung.com>
> +
> +description:
> +  dwmmac based tesla ethernet devices which support Gigabit
> +  ethernet.
> +
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +
> +properties:
> +  compatible:
> +    const: tesla,fsd-ethqos-4.21.yaml

?

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 5

Why? I expect it to be specific.

> +    maxItems: 10
> +
> +  clock-names:
> +    minItems: 5
> +    maxItems: 10
> +    items:
> +      - const: ptp_ref
> +      - const: master_bus
> +      - const: slave_bus
> +      - const: tx
> +      - const: rx
> +      - const: master2_bus
> +      - const: slave2_bus
> +      - const: eqos_rxclk_mux
> +      - const: eqos_phyrxclk
> +      - const: dout_peric_rgmii_clk
> +
> +  fsd-rx-clock-skew:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to the syscon node
> +          - description: offset of the control register
> +    description:
> +      Should be phandle/offset pair. The phandle to the syscon node.
> +
> +  iommus:
> +    maxItems: 1
> +
> +  phy-mode:
> +    $ref: ethernet-controller.yaml#/properties/phy-connection-type
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - rx-clock-skew

Eee? Isn't it fsd-rx-clock-skew which anyway is not correct?

> +  - iommus
> +  - phy-mode
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/fsd-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    ethernet_1: ethernet@14300000 {
> +              compatible = "tesla,dwc-qos-ethernet-4.21";

Three different compatibles for the same.

No, please test your patches before sending.

I am not even checking if previous feedback was applied... Did you
really go through it?

Best regards,
Krzysztof

