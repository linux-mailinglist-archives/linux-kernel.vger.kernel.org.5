Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C81763C17
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjGZQOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGZQOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:14:20 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239591FCF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:14:18 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51de9c2bc77so9843823a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690388056; x=1690992856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MAWnb7QFbSxQlRhJkEh2E/t//H6BY0En+cTF7iWgSRo=;
        b=bJLyG+YjZOjwLgfTKsB4IiqYw7Pl4my4lZkGzfUbLbZAFWTwH1lNhk14TxvwpyVpSj
         C0gNSbWCHvV9bJb7cTMOy9/D1aTel8xLx3/QiY4j821WananWsBrBotj1tzECxcSCmjb
         rI3iFS0JsARbEZcAu14I+rZFirFClu3KxTy4TdLlRaN3kUWrlX8q1hBkBiAYdrPACHJn
         n3EQacmW7OdEb3c8CigQRy3GMsItg7D2OJ4Cp0Wuc5M86BRayISR9K58NwRoZWiTGTQ7
         xSI0oNcivqRpZm15PQtKgUaZg9lUrNwuitb5u/I4HWszqDY55fIDyKBj/IfkzYP3rfsO
         OCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690388056; x=1690992856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MAWnb7QFbSxQlRhJkEh2E/t//H6BY0En+cTF7iWgSRo=;
        b=HmkQvM6WkkoyHrYiwntliz+YQsiks71wvFMjWRzp5yT4jrUMHQNJB3WC94FA++mUPV
         aCdEketRW4NzoldcE59B62jpLLUyO/NdG29yV554HOPmGB/v2UcIamV+LJ1zgwqLhZsO
         tW76dMv3iQt6dNCm0iOwRPGTnXzitmJuVQh26h/Rj7L8lnfFGj8e1nLMuNpQHhBjDD96
         a9fkpwjhXHE0yXSAmueETlsVNP7rN2Zuwqafudjpptv5cRsxGO5+zAgP+HCa8tNyQMZ9
         PughKjUuHOpfVFMdBpBQxYN8nuYYxfZyetHASSe8CCke/xAvuDPsG4IOxNpeuQ072I1a
         9ryw==
X-Gm-Message-State: ABy/qLbKMjx99nf/lNBXlnhYWaKwGKNgsjUDXqnVU5H2iuNyu5K3Q1ZW
        VACmVX47NHPOdw3mUNFqvfyKHg==
X-Google-Smtp-Source: APBJJlEXTthH03AU/9BQ+Ck77v4MD/2nK+Zt2K6dh3fgtIgyg5KL0U2IQWnuP/dW7rt/kCwiEl8YOQ==
X-Received: by 2002:a05:6402:1259:b0:521:7779:d918 with SMTP id l25-20020a056402125900b005217779d918mr2023959edw.19.1690388056555;
        Wed, 26 Jul 2023 09:14:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id l25-20020aa7c3d9000000b0051873c201a0sm8906020edr.26.2023.07.26.09.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 09:14:16 -0700 (PDT)
Message-ID: <82628237-e087-269e-9673-cf3873fe4b35@linaro.org>
Date:   Wed, 26 Jul 2023 18:14:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: add renesas,isl28022
Content-Language: en-US
To:     =?UTF-8?Q?Carsten_Spie=c3=9f?= <mail@carsten-spiess.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20230726152235.249569-1-mail@carsten-spiess.de>
 <20230726152235.249569-3-mail@carsten-spiess.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230726152235.249569-3-mail@carsten-spiess.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2023 17:22, Carsten Spieß wrote:
> Add dt-bindings for Renesase ISL28022 power monitor.
> 
> Signed-off-by: Carsten Spieß <mail@carsten-spiess.de>
> ---

Thank you for your patch. There is something to discuss/improve.


>  .../bindings/hwmon/renesas,isl28022.yaml      | 67 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml b/Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml
> new file mode 100644
> index 000000000000..5ecf892db269
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +

No blank line.

> +$id: http://devicetree.org/schemas/hwmon/renesas,isl28022.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas ISL28022 power monitor
> +
> +maintainers:
> +  - Carsten Spieß <mail@carsten-spiess.de>
> +
> +description: |
> +  The ISL28022 is a power monitor with I2C interface. The device monitors
> +  voltage, current via shunt resistor and calculated power.
> +
> +  Datasheets:
> +    https://www.renesas.com/us/en/www/doc/datasheet/isl28022.pdf
> +
> +Required properties:
> +  compatible:
> +    enum:
> +      - renesas,isl28022
> +
> +  reg:
> +    maxItems: 1
> +
> +Optional properties:

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

These are "properties"

> +  shunt-resistor-micro-ohms:
> +    description:
> +      Shunt resistor value in micro-Ohm
> +      defaults to <0> when not set
> +      monitoring of current and power not supported when <0>
> +
> +  shunt-gain:

1. Missing vendor prefix (does not look like generic property)
2. -microvolt

> +    description:
> +      Shunt gain to scale maximal shunt voltage to
> +      40mV, 80mV, 160mV, 320mV
> +      defaults to <8> (320mV) when not set

And then enum is for 40, 80, 160 and 320.

> +    enum: [1, 2, 4, 8]
> +
> +  average:
> +    description: |
> +      Number of samples to be used to report voltage, current and power values.
> +      defaults to <0> when not set
> +    enum: [0, 1, 2, 4, 8, 16, 32, 64, 128]

I am sure hwmon has some property for this. Are you sure it is called
"average"?

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +


Best regards,
Krzysztof

