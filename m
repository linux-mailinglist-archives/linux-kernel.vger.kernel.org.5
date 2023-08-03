Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EB976DF14
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 05:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjHCDip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 23:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjHCDi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 23:38:28 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CF52D65;
        Wed,  2 Aug 2023 20:38:24 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-56433b18551so255996a12.3;
        Wed, 02 Aug 2023 20:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691033903; x=1691638703;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PRHAPEVjgzXRCPv6d2/RKwpH+FmCtSY3abxyLk4RO7k=;
        b=PaLk05tt557tPtKkQE8FfJhVy0dDEalp8Dytop/HW7HfiqgSS24YL1oMS+1/tvXoAb
         3CNin21BFUPadD63iWgKaQifqpTed/LJlv/5LZ5jS/LNcyLJrgRP9lheEcYkqtWyHGNJ
         pN6x4Y/AW452HuYahgnUAFwpDtGoRDy7Y3KdH/VsKFtMetUZxKI9YMM+sOMAgD/ptH+p
         wQevkM+LQ0b8vBH9UXVj9Lrl1t0xI8XvPZGBMPjuUmRnqETsXl7Ym3II7Cl5AWOVVDXM
         MEMOiXdalxpB6WEkYrHDgqHrIlzKF656zl2qMpEp03Pr4a6bSLg/LFUNlxaN/uylwc9o
         akEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691033903; x=1691638703;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRHAPEVjgzXRCPv6d2/RKwpH+FmCtSY3abxyLk4RO7k=;
        b=DK2w/FHBzvjTYhC99QEaqvk+LAgZubZOUWPcDEDT3oJjj42YOeJ22XNGTj0ZfDZtvV
         uK6hRNPIhs6/J/GzvJJQ3km1EB71TB6wJ5uDbj1ZhQ9OmorRz8YkkgVUl9ZfpOA0xnOw
         HVCb2R7Y4Yqnb0SJtl/xleKp6FyTzJQXSLoUkVfjFcldXlLkiJSCZq5h7tWFIG3I4pFg
         4qPcLvxqI9uMASPfGOCqDv25YzcwXJiS+daz+4LItDvTjh3tLl2ZSDeqBus+YHXWvrwq
         066lSApl3Ocahu4beqiVz6hEsn9IRnmKLEKzqGimUs8v2GOrgp6SSjIEpWmlGBB7YXPZ
         XuYw==
X-Gm-Message-State: ABy/qLZ1qV4w0HD4+RhIhCxhmbsK2bzTxszAbDQ/QhzQMWJkcAIbOiNb
        Jck0t6B3koSUCh/jUvAYItE=
X-Google-Smtp-Source: APBJJlFYsb0g5x4HUoXk859r8KqB2DzSZI6auDFn/yPjTK5V55Kz9e1mOrxsf2ARiUNTiEo76nwcHA==
X-Received: by 2002:a17:90a:2fcf:b0:268:5fd8:d8ff with SMTP id n15-20020a17090a2fcf00b002685fd8d8ffmr14375599pjm.0.1691033903451;
        Wed, 02 Aug 2023 20:38:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v23-20020a17090ae99700b00268040bbc6asm1692923pjy.4.2023.08.02.20.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 20:38:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ca698b1e-0e81-fdf4-289f-b5a6676a25a7@roeck-us.net>
Date:   Wed, 2 Aug 2023 20:38:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2 v11] dt-bindings: watchdog: marvell GTI system
 watchdog driver
Content-Language: en-US
To:     Bharat Bhushan <bbhushan2@marvell.com>, wim@linux-watchdog.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sgoutham@marvell.com
References: <20230803032523.6242-1-bbhushan2@marvell.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230803032523.6242-1-bbhushan2@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/23 20:25, Bharat Bhushan wrote:
> Add binding documentation for the Marvell GTI system
> watchdog driver.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v11:
>   - No change
> 
> v10:
>   - Added Reviewed by Krzysztof Kozlowski
> 
> v9:
>   - Rename binding file name from marvell,octeontx2-wdt.yaml to
>     marvell,cn10624-wdt.yaml
>   - "allOf: - $ref: watchdog.yaml#" moved after maintainers
>   - clocks have maxItems rather than minItems
>   - Added "clock-names" name defination
>   - Added Fallback to compatible
> 
> v8:
>    - Compatible name as per soc name
> 
>   .../watchdog/marvell,cn10624-wdt.yaml         | 83 +++++++++++++++++++
>   .../watchdog/marvell,cn10624-wdt.yaml         | 83 +++++++++++++++++++
>   1 file changed, 83 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/marvell,cn10624-wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/marvell,cn10624-wdt.yaml b/Documentation/devicetree/bindings/watchdog/marvell,cn10624-wdt.yaml
> new file mode 100644
> index 000000000000..1b583f232e53
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/marvell,cn10624-wdt.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/marvell,cn10624-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell Global Timer (GTI) system watchdog
> +
> +maintainers:
> +  - Bharat Bhushan <bbhushan2@marvell.com>
> +
> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - marvell,cn9670-wdt
> +          - marvell,cn10624-wdt
> +
> +      - items:
> +          - enum:
> +              - marvell,cn9880-wdt
> +              - marvell,cnf9535-wdt
> +          - const: marvell,cn9670-wdt
> +
> +      - items:
> +          - enum:
> +              - marvell,cn10308-wdt
> +              - marvell,cnf10518-wdt
> +          - const: marvell,cn10624-wdt
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: refclk
> +
> +  marvell,wdt-timer-index:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 63
> +    description:
> +      An SoC have many timers (up to 64), firmware can reserve one or more timer
> +      for some other use case and configures one of the global timer as watchdog
> +      timer. Firmware will update this field with the timer number configured
> +      as watchdog timer.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        watchdog@802000040000 {
> +            compatible = "marvell,cn9670-wdt";
> +            reg = <0x00008020 0x00040000 0x00000000 0x00020000>;
> +            interrupts = <GIC_SPI 38 IRQ_TYPE_EDGE_RISING>;
> +            clocks = <&sclk>;
> +            clock-names = "refclk";
> +            marvell,wdt-timer-index = <63>;
> +        };
> +    };
> +
> +...

