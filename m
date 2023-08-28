Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1200E78A647
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjH1HLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjH1HLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:11:00 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1751E0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:10:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bcfe28909so357303366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693206656; x=1693811456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zWhn4TLCrD9nnYOeDxCtGtHbvSHL8FcsnQppWoyo1ZQ=;
        b=gz6VYD7cQSaCPEwUNZgwzM/ul0NvtDfRQCO3N4xGbmGYLoyXrp30hzbcCCSi1GbHv1
         fo229owV2HnlbLRnnAdtpMlHtwF+Bnkc1J2rsT0ae/U7CR9jT7iCvkeIFKLM7w4BKFT3
         WLWt0heF6JIgS1Tq96QJXN7NagjUdzAZr1my5Ao2JYFO/rgMTzB/DfPy2Y1iNVSo1JfC
         Lb8+5ocFBN7aPl0/ZSBtQWgYttYD1jsg77tW0mgnvt7m28oBVezXqjEF+KuGYL4WFsOf
         cLUup4wUViblHcreJJYwYY0SJfIL2dzCY51behwy3ny2qK9AHR43qeKMzRsJBgacDbJc
         elRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693206656; x=1693811456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWhn4TLCrD9nnYOeDxCtGtHbvSHL8FcsnQppWoyo1ZQ=;
        b=NIx8jZEgH4C+DP0wjs3YcrQ+tfxoK5TTWtvcmJD1noUS3PSryYbAMpkPwVi9itjKrd
         UkvdaOYzjqPwMv6z9lT7Nyn4Te5kbOIildlZh8dnbn7T7zXz5u0vGiDhZWDrzfwRZM1S
         SrRr1zcNBBKaPQvR9CxfFGfriPH6qNLiX1NPaLmKqMetGDYex6Yd7G0UsS3lRoOg4jo3
         UKx0LEqpPArZztVr/YnHfnar9DdvkhJhua0i6Y8/NT5OJOVghirW3LI8ui47LZbndRaq
         6TV3ISnJWl6A47WB7hoEB6ysEkmViDUqqn+UHouAAf0cDLEwZsc2tMUWtLqH6ZwkEmhq
         qNAg==
X-Gm-Message-State: AOJu0YzbEw/fzM8WNMIkbbkHv7lKqnlZqDjX1G1+6OLyu7hOXnGjvBER
        8J3GHvIiezNGXW/LRlf8lEOqbQ==
X-Google-Smtp-Source: AGHT+IEaCRRwj6SO7Oi8ML0+d8UnRRo5zK1JU0aNPKESlrbjf2ZzvRCrS2h+a1pGRnqMm/7ZRhUQGw==
X-Received: by 2002:a17:906:7391:b0:9a1:c659:7c62 with SMTP id f17-20020a170906739100b009a1c6597c62mr11455127ejl.66.1693206656333;
        Mon, 28 Aug 2023 00:10:56 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id h1-20020a1709062dc100b0098921e1b064sm4269753eji.181.2023.08.28.00.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 00:10:55 -0700 (PDT)
Message-ID: <eccc6a7a-b30f-8c77-77cb-5deef47a1954@linaro.org>
Date:   Mon, 28 Aug 2023 09:10:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v6 1/2] dt-binding: pinctrl: Add NPCM8XX pinctrl and GPIO
 documentation
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, avifishman70@gmail.com, tali.perry1@gmail.com,
        joel@jms.id.au, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, j.neuschaefer@gmx.net
Cc:     openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
References: <20230827203612.173562-1-tmaimon77@gmail.com>
 <20230827203612.173562-2-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230827203612.173562-2-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/2023 22:36, Tomer Maimon wrote:
> Added device tree binding documentation for Nuvoton Arbel BMC NPCM8XX
> pinmux and GPIO controller.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---


> +  '^pin':
> +    $ref: pincfg-node.yaml#
> +
> +    properties:
> +      pins:
> +        description:
> +          A list of pins to configure in certain ways, such as enabling
> +          debouncing

What pin names are allowed?

> +
> +      bias-disable: true
> +
> +      bias-pull-up: true
> +
> +      bias-pull-down: true
> +
> +      input-enable: true
> +
> +      output-low: true
> +
> +      output-high: true
> +
> +      drive-push-pull: true
> +
> +      drive-open-drain: true
> +
> +      input-debounce:
> +        description:
> +          Debouncing periods in microseconds, one period per interrupt
> +          bank found in the controller
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        minItems: 1
> +        maxItems: 4
> +
> +      slew-rate:
> +        description: |
> +          0: Low rate
> +          1: High rate
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1]
> +
> +      drive-strength:
> +        enum: [ 0, 1, 2, 4, 8, 12 ]
> +
> +    additionalProperties: false
> +
> +allOf:
> +  - $ref: pinctrl.yaml#
> +
> +required:
> +  - compatible
> +  - ranges
> +  - '#address-cells'
> +  - '#size-cells'
> +  - nuvoton,sysgcr
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      pinctrl: pinctrl@f0800260 {

Nothing improved here. Test your DTS. This is being reported - I checked.

> +        compatible = "nuvoton,npcm845-pinctrl";
> +        ranges = <0x0 0x0 0xf0010000 0x8000>;
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        nuvoton,sysgcr = <&gcr>;
> +
> +        gpio0: gpio@0 {
> +          gpio-controller;
> +          #gpio-cells = <2>;
> +          reg = <0x0 0xB0>;

Keep lowercase hex.


Best regards,
Krzysztof

