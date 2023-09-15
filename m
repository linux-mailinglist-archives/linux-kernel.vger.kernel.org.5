Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6DC7A1C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjIOKnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbjIOKnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:43:08 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B64D1AD
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:42:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso269459066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694774566; x=1695379366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7cxED257cvOzhSOWnIcBdUQJ8KQY0kMpTskWgoFGhMs=;
        b=xibxPd5fCXlMyNmOvFhFZbKxHbvihAbLcYlB0BYdDS9h7oQcFDo7HhjqxYABqwVIW3
         fgiNMz35jb9CqjoFTbSNj4DKnR7jx39R6Q60jGaBjwp+/RgLV4yvuTCR/rzWb+bml5LX
         u1rHip2iZp+2P1Xc9riijKmM1jYi8cw8QtEK9nQ+yyPstlpD6kb7j1o57m6gonsatAWz
         Uc+UGAAw7Kp08LPolrDkWcOQu0h5NAjNVVVgDklBMt0rnI3CJdxeyVpqkFzhF9MlhsCv
         LrDIO42E92/ca7yKJGiGlgcinSbvtDNEYYt6mZrcPTowsn+F7OPZ/I3zb1QmnQqM9fSB
         v3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694774566; x=1695379366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7cxED257cvOzhSOWnIcBdUQJ8KQY0kMpTskWgoFGhMs=;
        b=lOIFbmaeHU8UsuUcZ+tR8Lcvs31cEGqBKD3nZUtrpZ5tktvl5ZGqQcd2Mn4Z1+Sw0L
         leOr9DPL89PYO/RkVfTFXQ9BrxiV+lLo5hFGjZ16VF1l2pg5QXz582HkNmT6llqAZ7o/
         JSVvPncvjfl0siGUTZG9Tzv5g8t1LM32+fQH+qD70dn9vefziVhDwXEAv6L+gU2l32B+
         EKbNHfSnhhsLozP4zOnkg7jWOor5mWVMEnpykBnwd1xpU/BqQ+VSQjvg7TWUFSLLQuic
         t1CRnn+GiNqpZUrEZ4B/594exG9jjr0seLvIzgivy5oNSaWu1B3//k2E//1EHqSa9sBN
         JuDg==
X-Gm-Message-State: AOJu0YxmMDenROIERV1Z3LoLG5U52YRmOwBPCe9opw4dYSeF1TBLGn7U
        RtTlOYOt2qrsFf/NOl2zJ/1iEQ==
X-Google-Smtp-Source: AGHT+IG40zYjbU/gtYqB47CJ1FbR+mtNl+08S70hJco3pjV+aeYW5PFbbNtVFTzQs3YiScp2JiVnIw==
X-Received: by 2002:a17:906:3108:b0:9a1:f81f:d0df with SMTP id 8-20020a170906310800b009a1f81fd0dfmr1042305ejx.69.1694774565775;
        Fri, 15 Sep 2023 03:42:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id kt26-20020a170906aada00b0098f99048053sm2272653ejb.148.2023.09.15.03.42.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 03:42:45 -0700 (PDT)
Message-ID: <84931c58-1f5b-02c7-0204-a67871f89a6a@linaro.org>
Date:   Fri, 15 Sep 2023 12:42:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 09/42] dt-bindings: soc: Add Cirrus EP93xx
Content-Language: en-US
To:     nikita.shubin@maquefel.me, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
 <20230915-ep93xx-v4-9-a1d779dcec10@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230915-ep93xx-v4-9-a1d779dcec10@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 10:10, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Add device tree bindings for the Cirrus Logic EP93xx SoC.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../bindings/arm/cirrus/cirrus,ep9301.yaml         | 38 ++++++++++++
>  .../bindings/soc/cirrus/cirrus,ep9301-syscon.yaml  | 71 ++++++++++++++++++++++
>  2 files changed, 109 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cirrus/cirrus,ep9301.yaml b/Documentation/devicetree/bindings/arm/cirrus/cirrus,ep9301.yaml
> new file mode 100644
> index 000000000000..97dd8b6aefa9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/cirrus/cirrus,ep9301.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/cirrus/cirrus,ep9301.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic EP93xx platforms
> +
> +description:
> +  The EP93xx SoC is a ARMv4T-based with 200 MHz ARM9 CPU.
> +
> +maintainers:
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: The TS-7250 is a compact, full-featured Single Board Computer (SBC)
> +          based upon the Cirrus EP9302 ARM9 CPU
> +        items:
> +          - const: technologic,ts7250
> +          - const: cirrus,ep9301
> +
> +      - description: The Liebherr BK3 is a derivate from ts7250 board
> +        items:
> +          - const: liebherr,bk3
> +          - const: cirrus,ep9301
> +
> +      - description: EDB302 is an evaluation board by Cirrus Logic,
> +          based on a Cirrus Logic EP9302 CPU
> +        items:
> +          - const: cirrus,edb9302
> +          - const: cirrus,ep9301
> +
> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/soc/cirrus/cirrus,ep9301-syscon.yaml b/Documentation/devicetree/bindings/soc/cirrus/cirrus,ep9301-syscon.yaml
> new file mode 100644
> index 000000000000..1692250251d9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/cirrus/cirrus,ep9301-syscon.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/cirrus/cirrus,ep9301-syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic EP93xx Platforms System Controller
> +
> +maintainers:
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - cirrus,ep9302-syscon
> +              - cirrus,ep9307-syscon
> +              - cirrus,ep9312-syscon
> +              - cirrus,ep9315-syscon
> +          - const: cirrus,ep9301-syscon
> +          - const: syscon
> +          - const: simple-mfd
> +      - items:
> +          - const: cirrus,ep9301-syscon
> +          - const: syscon
> +          - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  reboot:
> +    type: object
> +    $ref: /schemas/power/reset/cirrus,ep9301-reboot.yaml

There is no need to have empty node without any resources. There are no
benefits of this. Drop entire reboot schema and instantiate your driver
from parent device. simple-mfd also goes away. syscon probably as well,
unless you export registers for other devices?

> +
> +  clock-controller:
> +    type: object
> +    $ref: /schemas/clock/cirrus,ep9301-clk.yaml

This could be okay, if it took address. But it doesn't, so again, this
can be just part of top node. Unless this is a separate device and you
miss here proper reg/addressing?


> +
> +  pinctrl:
> +    type: object
> +    $ref: /schemas/pinctrl/cirrus,ep9301-pinctrl.yaml

No need, drop entire schema and node, just like with reboot.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    syscon@80930000 {
> +        compatible = "cirrus,ep9301-syscon",
> +                     "syscon", "simple-mfd";
> +        reg = <0x80930000 0x1000>;
Best regards,
Krzysztof

