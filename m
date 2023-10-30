Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586FF7DBAE9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 14:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjJ3Ngy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 09:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJ3Ngw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 09:36:52 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C48A2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 06:36:50 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9d2e7726d5bso200820466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 06:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698673009; x=1699277809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i3frOP0o6P9Pnw/YJHcCs3mjTkI9GDrTu8qJLH4cB3w=;
        b=yqd/cp0DCQ0adg/hjJdxhXuvvYXdhNI7yZEQE6c46C1plPSv1+MXFWARyIxoJo8R55
         LU+Y+9hAuTqpLga3v5gWWe/0mCGTlNVbESuYZKylAucI56scX/RQI8tjk/kVTfikXiCu
         uzR3rgyox732UXwGCNvL1pYjUE/iewKdnY5OUFB9Pbh9P82StvqXl/gABoWDTqBt1CQ0
         l6ODyfCmSB/a2pxc8/mpvRFHgNouMJMPLtY3OCzIqhS4eQXC6tnrzmy+rkBAwtlLdp+2
         uqF41EBIBqUEDmLTallGJEaB4trx09ayrBK8Xm9SgVRJcEbVi18ua+TH0uAip7VdqkRg
         x21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698673009; x=1699277809;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i3frOP0o6P9Pnw/YJHcCs3mjTkI9GDrTu8qJLH4cB3w=;
        b=jZHHqhM8OMexTiBfqyGm/ED1Q0vKFe1joTd7b+ezOvM9rFEILof51zXdJ29hDv3m7K
         Y/mCnQiD7f+FH1FH7MhHje/+SLnJAiIIjWn50Vcd14PXRQ2MrynKYda5oAsg+4jCdmwW
         5kl73tDs8Xon3v0qOxx7GkRFaOr4D/0qGIifAg0eI2jZ3gokfwJyy7A7fJq3O0NcClyJ
         A1y/plMq/wnSfgCYIsh1HiUdmR5rRjBx2KAZ0zlHrvn0WnucMJ0kiuVy65A8Xnj15ZkL
         0vCF3MRmurs9hAUh4fESSvqlBhA4BOvGtEc7XX6nTSj4lCJNRq3ElAPsdtvj1RzQNqN+
         nO5Q==
X-Gm-Message-State: AOJu0YwAv6wruSY5zyEXNBWMHrZfRJkicToy1m0ea6TVOIc+uv6Gr4FJ
        cLMHq++8jmRCORcy+BLLuOpwWg==
X-Google-Smtp-Source: AGHT+IE/9Ak6MS2t6e/0vJVZgBfU4Fq1EjzxTu8WLCTo2sab3wCEwARe/83WgIvrIIzKDu6wnIeZtw==
X-Received: by 2002:a17:907:c70b:b0:9d4:40d5:ccb2 with SMTP id ty11-20020a170907c70b00b009d440d5ccb2mr1579891ejc.22.1698673008672;
        Mon, 30 Oct 2023 06:36:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id l17-20020a170906415100b009c3827134e5sm5996064ejk.117.2023.10.30.06.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 06:36:48 -0700 (PDT)
Message-ID: <18a2efdd-b0b7-4cb5-9bd6-d8a9cb5abf3c@linaro.org>
Date:   Mon, 30 Oct 2023 14:36:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] dt-bindings: hwmon: lm87: convert to YAML
Content-Language: en-US
To:     Li peiyu <579lpy@gmail.com>, jdelvare@suse.com, linux@roeck-us.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231030125221.12974-1-579lpy@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231030125221.12974-1-579lpy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2023 13:52, Li peiyu wrote:
> Convert the lm87 hwmon sensor bindings to DT schema
> 
> Signed-off-by: Li peiyu <579lpy@gmail.com>
> ---
> Change for v5:
> - Change the file name to "ti,lm87.yaml"
> - Add maintainers get by get_maintainers.pl

Thank you for your patch. There is something to discuss/improve.

...

> diff --git a/Documentation/devicetree/bindings/hwmon/ti,lm87.yaml b/Documentation/devicetree/bindings/hwmon/ti,lm87.yaml
> new file mode 100644
> index 000000000000..6dadf181c9a6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/ti,lm87.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/ti,lm87.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LM87 hwmon sensor
> +
> +maintainers:
> +  - Jean Delvare <jdelvare@suse.com>
> +  - Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> +  - Rob Herring <robh+dt@kernel.org>

Please drop last two entries. We do not maintain this file. This should
be someone interested in the device, like driver maintainer or recent
contributor. As last resort, you can put there subsystem maintainer if
he is okay with this.

> +
> +properties:
> +  compatible:
> +    const: ti,lm87
> +
> +  reg:
> +    maxItems: 1
> +
> +  has-temp3:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      When set, pins 18 and 19 are configured to be used as a second
> +      remote temperature sensing channel. Otherwise the pins are
> +      configured as voltage input pins in0 and in5.
> +
> +  has-in6:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      When set, pin 5 is configured to be used as voltage input in6.
> +      Otherwise the pin is set as FAN1 input.
> +
> +  has-in7:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      When set, pin 6 is configured to be used as voltage input in7.
> +      Otherwise the pin is set as FAN2 input.
> +
> +  vcc-supply:
> +    description: |
> +      A Phandle for the regulator supplying power, can be configured to

Drop "A Phandle for the"

> +      measure 5.0V power supply. Default is 3.3V.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +

Rest looks good.

Best regards,
Krzysztof

