Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585D4802C9C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 09:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343633AbjLDIEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDIEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:04:21 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55F4BB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:04:26 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c09b021daso10462255e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 00:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701677065; x=1702281865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vVaID42WmWo7eAY8bPdAR9Y2HBlZxV8DXl4tSWq+kCU=;
        b=UmCdDeUimwDSJXDXMnaNInf7VqyroZVSgM/00E+iK+2At4ZzjQ0C/1/EumMkpr6dTm
         54fXsHLTWnD8iOYIYJe3/UvQkTx8lk0+QbEsrXyG9oVuayjr8PrQDf1NH9wu6GnR+elD
         Gqto24Jg5zuXvbCsXK7BV2RXu3eJ3TRgtu2Rf4u2A5qGAjRncJc7t89JumeoBn0yJW9v
         ybkEkfITCLwZMcXI9aNx1LXEq3r6SBXyEXU44cmUJVWedg+cCmFAwusKz01yemPczF6D
         PCjeHEs6mvMV/6M8KQvfu9l9gfWs8rqpICrOLerKHk2MifZtfEW1W+zrIM9/jh7u2ZIh
         mpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701677065; x=1702281865;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVaID42WmWo7eAY8bPdAR9Y2HBlZxV8DXl4tSWq+kCU=;
        b=pMMJPJlAafFCB3Lv8ZfRjwNr8IXLX05MT/6AFUfxQrQHviG8v/M9c/WKpVRpOfHTG/
         g1CGnTSOfg+Nz3ZiRyOVxxXxgtVIYS/RvPSL1eyfVUWQhe3sHCbzhZN+tDTyAJoCxPp5
         +iIpsSduUVtj/Ys9eLHQnLqKPXPJcaHx+7MEZxV+mHAD/ybH7KKJO9JzafVqM5SMhkIM
         82ip6ZkKLk+7RCRKPpQktoUC18gbF0lC8MvbHrIKkjXfv8dMgBsiw6+H6twbvNwcKrJq
         nYi7/HWGm8KYFSRp/jbkIIABbpdcTrPtk2vQxuNaOrnlIi/ReG+c5psR0Vi04ZJaHbPL
         UQxA==
X-Gm-Message-State: AOJu0YyximS/8jeB5V5tepd6BxlsqlwUe2cJwCQs+uKtweDie72q9UjT
        i8ACI3NWFUJypiy4eyxi0vqh6Q==
X-Google-Smtp-Source: AGHT+IFDoUbztBuebRWauGH5T7fwkI29ue733eofsJfUis1cTAJsJlWv+11v3XBcwxPMPBByEw3u6w==
X-Received: by 2002:a05:600c:1da7:b0:40b:5e1f:6fd9 with SMTP id p39-20020a05600c1da700b0040b5e1f6fd9mr1832082wms.46.1701677065240;
        Mon, 04 Dec 2023 00:04:25 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id fc12-20020a05600c524c00b0040b400711f5sm17787653wmb.7.2023.12.04.00.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 00:04:24 -0800 (PST)
Message-ID: <94607c47-9824-4e2c-8f22-99ca2e088b27@linaro.org>
Date:   Mon, 4 Dec 2023 09:04:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: hwmon: Add nct736x bindings
Content-Language: en-US
To:     baneric926@gmail.com, jdelvare@suse.com, linux@roeck-us.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, corbet@lwn.net
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        openbmc@lists.ozlabs.org, kwliu@nuvoton.com, kcfeng0@nuvoton.com,
        DELPHINE_CHIU@wiwynn.com, Bonnie_Lo@wiwynn.com
References: <20231204055650.788388-1-kcfeng0@nuvoton.com>
 <20231204055650.788388-2-kcfeng0@nuvoton.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231204055650.788388-2-kcfeng0@nuvoton.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2023 06:56, baneric926@gmail.com wrote:
> From: Ban Feng <kcfeng0@nuvoton.com>
> 
> This change documents the device tree bindings for the Nuvoton
> NCT7362Y, NCT7363Y driver.
> 
> Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
> ---
>  .../bindings/hwmon/nuvoton,nct736x.yaml       | 80 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct736x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct736x.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct736x.yaml
> new file mode 100644
> index 000000000000..f98fd260a20f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct736x.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/hwmon/nuvoton,nct736x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NCT736X Hardware Monitoring IC
> +
> +maintainers:
> +  - Ban Feng <kcfeng0@nuvoton.com>
> +
> +description: |
> +  The NCT736X is a Fan controller which provides up to 16 independent
> +  FAN input monitors, and up to 16 independent PWM output with SMBus interface.
> +  Besides, NCT7363Y has a built-in watchdog timer which is used for
> +  conditionally generating a system reset output (INT#).
> +
> +additionalProperties: false

Please place it just like other bindings are placing it. Not in some
random order. See example-schema.

You should use common fan properties. If it was not merged yet, you must
rebase on patchset on LKML and mention the dependency in the change log
(---).

> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,nct7362
> +      - nuvoton,nct7363
> +
> +  reg:
> +    maxItems: 1
> +
> +  nuvoton,pwm-mask:
> +    description: |
> +      each bit means PWMx enable/disable setting, where x = 0~15.
> +      0: disabled, 1: enabled
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0x0
> +    maximum: 0xFFFF
> +    default: 0x0

Use pwms, not own property for this.

> +
> +  nuvoton,fanin-mask:
> +    description: |
> +      each bit means FANINx monitoring enable/disable setting,
> +      where x = 0~15.
> +      0: disabled, 1: enabled
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0x0
> +    maximum: 0xFFFF
> +    default: 0x0

Use properties from common fan bindings.

> +
> +  nuvoton,wdt-timeout:
> +    description: |
> +      Watchdog Timer time configuration for NCT7363Y, as below
> +      0: 15 sec (default)
> +      1: 7.5 sec
> +      2: 3.75 sec
> +      3: 30 sec
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +    default: 0

Nope, reference watchdog.yaml and use its properties. See other watchdog
bindings for examples.

> +
> +required:
> +  - compatible
> +  - reg
> +  - nuvoton,pwm-mask
> +  - nuvoton,fanin-mask
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        nct7363@22 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation




Best regards,
Krzysztof

