Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAAA7FB2D0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343751AbjK1Hev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbjK1Heq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:34:46 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CCAD5D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:34:51 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54b8a4d64b5so1771794a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 23:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701156889; x=1701761689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oppdECoii9C97GzWPtRPxUKs5Z+XKzBXE30YzOcnZn4=;
        b=b5TBxvD/lPlc7v/s6kjDIieZjpQMHzc4RPoRP3DSNneApKQecmdiCWWUvHei9B+SuC
         aAfHjolS4/oQtNohdqymRjTCmQNJk3Bnx18bZhy7m0FMPzqFIENKeWOAWaI1QfFtMTzT
         gtM9xraZED0vCtEnsO/2SXc1oWF38PRExxS2TgS2zpI5jTbYT8El6Iqt0fkZ2xi92bEM
         Lr9xPIVOUHV+IHcAKRSIigwtL27PdP/C/Woyr0KpmhQysEsB/vryC5i3UtSIUg6XHbMz
         /coiVPdBUGR1xRj1Dt+K4Alo7CtEgT4mxFPMaKREriPjYbImtEKuaMpHmPU/N6Mq8pJE
         1h+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156889; x=1701761689;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oppdECoii9C97GzWPtRPxUKs5Z+XKzBXE30YzOcnZn4=;
        b=UoEhgYSgPO2AnFc2LcR6SsOBhzDcXdXj9QJt+/iNB6qXJA55dKDhEhY1aEgoIbE1Dr
         t8Y88z5XPxLCcDfEEk7uX3/cOKg0iBDbi196fuYHm25Q3RDUimQgV3H3xDN3a7oWWRNq
         qxCc9kK/k3TpjGQsOadhLRD3YFImyfFj8ea2ueJ8pcJmebagxE9ZaYmpKP8jcYVR4kag
         6Ab7T3DgOnx7T6B+TupuOqPEwuun7fBVkadm9vBINXvmkt5vUkrjHuNwQY44sQpOXjNo
         3ECLh+iP1vcAB1FW/6DFf87jwPnUgbpdXuLV/RnY8R0DH1gxqCDfKCRSyTuhjU7K32Cr
         obnA==
X-Gm-Message-State: AOJu0YwjY/EXU+3bug+axb21WSD0YUrLVquIyVytWw4i9VPnzMwrqzg8
        s8ZPRqvMBd9yX+3RqShrWhQZRA==
X-Google-Smtp-Source: AGHT+IGhSAZzfxGZiQjd7by5/oca1zu++XQytUpQyLpGfbCWRs3lVuhRqOi4AfEF0Mk9D5+VC2vXpw==
X-Received: by 2002:a17:906:594a:b0:9dd:30c8:6f33 with SMTP id g10-20020a170906594a00b009dd30c86f33mr9988094ejr.57.1701156889465;
        Mon, 27 Nov 2023 23:34:49 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id q23-20020a17090676d700b00a017da998bdsm6473249ejn.32.2023.11.27.23.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 23:34:49 -0800 (PST)
Message-ID: <7c24aaf8-8f93-4b93-b7e5-abc88e95682d@linaro.org>
Date:   Tue, 28 Nov 2023 08:34:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dt-bindings: pinctrl: Document nuvoton ma35d1 pin
 control
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, p.zabel@pengutronix.de, j.neuschaefer@gmx.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ychuang3@nuvoton.com, schung@nuvoton.com
References: <20231128061118.575847-1-ychuang570808@gmail.com>
 <20231128061118.575847-3-ychuang570808@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231128061118.575847-3-ychuang570808@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2023 07:11, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add documentation to describe nuvoton ma35d1 pin control and GPIO.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---

Your changelog said:

>   - Remove ma35d1-pinfunc.h which is unused after update definition of
'nuvoton,pins'.

You forgot to add:

" - Do not test the bindings before sending"

I assume none of the driver changes compile either.

>  .../pinctrl/nuvoton,ma35d1-pinctrl.yaml       | 189 ++++++++++++++++++
>  1 file changed, 189 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
> new file mode 100644
> index 000000000000..84287293a726
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
> @@ -0,0 +1,189 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/nuvoton,ma35d1-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton MA35D1 pin control and GPIO
> +
> +maintainers:
> +  - Shan-Chun Hung <schung@nuvoton.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,ma35d1-pinctrl
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  nuvoton,sys:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle of the system-management node.
> +
> +  ranges: true
> +
> +allOf:
> +  - $ref: pinctrl.yaml#

allOf goes before additionalProperties.

> +
> +required:
> +  - compatible
> +  - nuvoton,sys

This goes after patternProperties

> +
> +patternProperties:
> +  "^gpio@[0-9a-f]+$":
> +    type: object
> +    additionalProperties: false
> +    properties:
> +      gpio-controller: true
> +
> +      '#gpio-cells':
> +        const: 2
> +
> +      reg:
> +        maxItems: 1
> +
> +      clocks:
> +        maxItems: 1
> +
> +      interrupt-controller: true
> +
> +      '#interrupt-cells':
> +        const: 2
> +
> +      interrupts:
> +        description:
> +          The interrupt outputs to sysirq.
> +        maxItems: 1
> +
> +    required:
> +      - gpio-controller
> +      - '#gpio-cells'
> +      - reg
> +      - clocks
> +      - interrupt-controller
> +      - '#interrupt-cells'
> +      - interrupts
> +
> +  "^pin-[a-z0-9]+$":
> +    type: object
> +    description:
> +      A pinctrl node should contain at least one subnodes representing the
> +      pinctrl groups available on the machine. Each subnode will list the
> +      pins it needs, and how they should be configured, with regard to muxer
> +      configuration, pullups, drive strength, input enable/disable and input
> +      schmitt.
> +
> +    allOf:

Drop allOf, just $ref

> +      - $ref: pincfg-node.yaml#
> +
> +    properties:
> +      bias-disable: true

Drop this and other "true", why do you need them here?

> +
> +      bias-pull-down: true
> +
> +      bias-pull-up: true
> +
> +      power-source:
> +        description: |
> +          Valid arguments are described as below:
> +          0: power supply of 1.8V
> +          1: power supply of 3.3V
> +        enum: [0, 1]
> +
> +      drive-strength-microamp:
> +        oneOf:
> +          - enum: [ 2900, 4400, 5800, 7300, 8600, 10100, 11500, 13000 ]
> +            description: 1.8V I/O driving strength
> +          - enum: [ 17100, 25600, 34100, 42800, 48000, 56000, 77000, 82000 ]
> +            description: 3.3V I/O driving strength
> +
> +      input-enable: true
> +
> +      input-schmitt-enable: true
> +
> +    unevaluatedProperties: false



Best regards,
Krzysztof

