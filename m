Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E947845BE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237215AbjHVPjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237184AbjHVPjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:39:05 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4346CED
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:39:00 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99d937b83efso597145366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692718739; x=1693323539;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7uDZNE/L2WypJzzrI7vqxRXdhClZjfBh3CCjZ36A17c=;
        b=KR5CKO3txtjG3t2iB9uTdoOqPbb50mrTmkVmG9sRhDQfi8JoN4zJzwdNQK6W/RgEHm
         j6FCSbBNhOavnBr+r9kJO5qLyWgxGoDVWxT11kCXf5Aw9PG272XQmsMVAER6NEd6aide
         T/n/zjZOmQ8B+uXfmVxMbw+e3WGFAycPe/AEne4GScjp+4+G+SIOv1osF4wNI729TOM6
         3Q9u690LuLgVGpSyd/AvrTyHInE+j5BcYsPJNxi/PbGu5dv9FnAptWxBPYxLZwyVGcKB
         rQv6RV5xsOzXJPw2XL2Q/XpYe32zdgFLylpUTsxVYvIPMYrOPhxm5SfcvpSV78D4+8ce
         7hvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718739; x=1693323539;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7uDZNE/L2WypJzzrI7vqxRXdhClZjfBh3CCjZ36A17c=;
        b=e7gMLF+8Ppv/AHke4MV/WqlXBrRPl9vAiFmWn48RlU8ktzFiuPkwhmV0oEt7kHfqTy
         tMXeDCRpn6V5XHbx7OLETAEmUPUZ6ajsg+PXpEMTKksPLvIIq/CiD6Hr7QFvUrcFcSd9
         sVbcQQq/LEIC1djgTgavC5Gysfufc0S0hRGR1f4d0U3DiDw7hdjHyjraI6W5MF4VsJkF
         1oN/o/I/3U+oT2tC4pO9URMnsBQkdb9Tn7cUwz7XmImSOiLi1bpBJmSTyv+iI8s/x8j7
         vb/Era76ZRDXPZ6AZ0l/0YXS/W43PHH1fHFhekSZK6zWrbH3Z7N3QzuWuU9eOo+L+zAC
         2KCQ==
X-Gm-Message-State: AOJu0YxXhfFMQ9XCP0BtuwFOK38BWo+uLMAACTNC8DGhivLbOcWsvgXD
        E60asO/d8+eIx0RY2FYVY+rKzA==
X-Google-Smtp-Source: AGHT+IHgJywDjqvWr4qipa5JD526Rk7A2oYdS4BbDCxC+VwxCzxAmx6wZN+j+yHCJEBntWf40M7SEQ==
X-Received: by 2002:a17:907:77d8:b0:99b:c517:88a1 with SMTP id kz24-20020a17090777d800b0099bc51788a1mr7367250ejc.67.1692718739384;
        Tue, 22 Aug 2023 08:38:59 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id y21-20020a1709063a9500b0099364d9f0e6sm8371210ejd.117.2023.08.22.08.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 08:38:58 -0700 (PDT)
Message-ID: <1e0632d6-73e9-4633-a709-bf9140f2fd32@linaro.org>
Date:   Tue, 22 Aug 2023 17:38:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 2/2] dt-bindings: extcon: Add Realtek DHC RTD SoC
 Type-C
Content-Language: en-US
To:     Stanley Chang <stanley_chang@realtek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230822102846.4683-1-stanley_chang@realtek.com>
 <20230822102846.4683-2-stanley_chang@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230822102846.4683-2-stanley_chang@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2023 12:28, Stanley Chang wrote:
> Document the device-tree bindings for Realtek SoCs Type-C.
> Realtek DHC (digital home center) RTD SoCs support a Type-C module.
> 
> Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
> ---
>  .../bindings/extcon/extcon-rtk-type-c.yaml    | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/extcon/extcon-rtk-type-c.yaml

Filename like compatible.

> 
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-rtk-type-c.yaml b/Documentation/devicetree/bindings/extcon/extcon-rtk-type-c.yaml
> new file mode 100644
> index 000000000000..d14b9ee544b9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/extcon/extcon-rtk-type-c.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2023 Realtek Semiconductor Corporation
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/extcon/extcon-rtk-type-c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Realtek DHC RTD SoCs USB Type-C detection

Type-c usually go to usb directory.

> +
> +maintainers:
> +  - Stanley Chang <stanley_chang@realtek.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  Realtek digital home center (DHC) RTD series SoCs include a type c module.
> +  This module is able to detect the state of type c connector.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - realtek,rtd1295-type-c
> +      - realtek,rtd1312c-type-c
> +      - realtek,rtd1315e-type-c
> +      - realtek,rtd1319-type-c
> +      - realtek,rtd1319d-type-c
> +      - realtek,rtd1395-type-c
> +      - realtek,rtd1619-type-c
> +      - realtek,rtd1619b-type-c
> +
> +  reg:
> +    maxItems: 1
> +    description: Address and length of register set for type-c module.

Drop description, it's obvious.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  nvmem-cells:
> +    maxItems: 1
> +    description:
> +      The phandle to nvmem cell that contains the trimming data.
> +      If unspecified, default value is used.
> +
> +  pinctrl-names:
> +    const: default
> +    description: A pinctrl state names "default" must be defined.

Drop, property not needed.

> +
> +  pinctrl-0:
> +    description:
> +      Should contain default pinctrl.

Drop, property not needed.


> +
> +  nvmem-cell-names:
> +    const: usb-cal

items:
  - const: usb-cal


and move description to nvmem-cells.

> +    description:
> +      The type c parameter trimming data specified via efuse.

Keep same properties next to each other. nvmem-cells should be followed
by nvmem-cell-names.

> +
> +  realtek,rd-ctrl-gpio:
> +    description: The gpio node to control external Rd on board.

The names are always "gpios".

> +    maxItems: 1
> +

You miss here connector. Probably also VBUS supply and other supplies.

> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    type-c@7220 {
> +        compatible = "realtek,rtd1619b-type-c";
> +        reg = <0x7220 0x20>;
> +        interrupts = <0 60 4>;

Use proper defines for common constants.

> +
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&usb_cc1_pins>, <&usb_cc2_pins>;
> +        nvmem-cells = <&otp_usb_cal>;
> +        nvmem-cell-names = "usb-cal";

Type-c without connector? This is incomplete.

> +    };

Best regards,
Krzysztof

