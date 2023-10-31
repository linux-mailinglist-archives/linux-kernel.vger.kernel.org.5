Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B5B7DD44B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 18:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346027AbjJaRJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 13:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbjJaRJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 13:09:31 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B461AD
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:08:49 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9d23be183c6so489647166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 10:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698772128; x=1699376928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+feQs+itGdxA7Jm7f8P6UpJRY3RLYxDN+ML61Wt8IfA=;
        b=JzOU3uurkijpJ/gjOyKN0ODkzWPWcNf4xFkMis73Y6AJaGP+m9TBSbYZrkP+ivEkyi
         m53D/eA0Sp+1bBosL9q4L6qKdSUIk4svlCJOdfbK5XQQW+rB6XZkNJzQTCSTWkfBC6yC
         V+GjGilQx5d9Hmvz+fWNFSdBK8m/5lBBhAFyuTfXw0I8ij8vT1zFC0XSTkmy445JDj0e
         KqcjcYVZ6U1sUDnt/+7A6iZcbpBK9LNWx330lsdHmNvesgyRnrcTADTjfBWuF6RF2kgT
         hn1T0GcMlu+PmNROLhroTTGlEiaWNQx3KDo/MSOs4bQpZWV0LYKzOg2F02o565QDmBZO
         orfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698772128; x=1699376928;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+feQs+itGdxA7Jm7f8P6UpJRY3RLYxDN+ML61Wt8IfA=;
        b=bXM8fTz/ZiG7qHt15iq3Sb9Aixjy3yB8GjfWZI40ZPh26nvbgoZmi4CaEwN3q5aQwb
         8h+NpTZbJG55UUy7R0vnKMXrsgs+Q6R5kpQjNhRKQCoPquV/0ZkY5Ht976jyNoYqtdaf
         aBb1HcxDxCuO3arow6hU7vo5HMEW7e7pYvaelsa2FVqy9ndZQoQSvD6UTsfiPkTPy5tL
         bVtRHVUwTldJh807sY48Wq7mwDxApm6WwV/hUHQk+/TJLKP7HwNR/rQyd4Ax5H9i07XP
         VnXmQF2R2/Ll4d642giTGcqrTdstsy0E/iRkABYQPkjTkEcALoGCnmZDJ77a0DYs2Fz7
         Gmxw==
X-Gm-Message-State: AOJu0Yx4Uj2dyPxPstw7Rq+F/P4SUGPzWh3ZpR0bC+yUg/JLdeb1EcES
        vy1jmwt5TB47RikM3RMSQWvWCA==
X-Google-Smtp-Source: AGHT+IHNVvDfKgiVTVWwyGmdsJki5ouK2yEzuxPef8Y/cOycrK5RxEm3D0Hzd3jvNoa64LCA73HpjQ==
X-Received: by 2002:a17:906:c148:b0:9be:6ccb:6a8b with SMTP id dp8-20020a170906c14800b009be6ccb6a8bmr12321140ejc.10.1698772127901;
        Tue, 31 Oct 2023 10:08:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id lg17-20020a170906f89100b0098e78ff1a87sm1259634ejb.120.2023.10.31.10.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 10:08:47 -0700 (PDT)
Message-ID: <084b6dd7-2078-43ca-90fe-3611c65dad8a@linaro.org>
Date:   Tue, 31 Oct 2023 18:08:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: rtc: max31335: add max31335 bindings
Content-Language: en-US
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20231031153100.92939-1-antoniu.miclaus@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231031153100.92939-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2023 16:30, Antoniu Miclaus wrote:
> Document the Analog Devices MAX31335 device tree bindings.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v3:
>  - `trickle-resistor-ohms` description specifies that the property is mandatory
>     if trickle charger should be enabled.
>  .../devicetree/bindings/rtc/adi,max31335.yaml | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/adi,max31335.yaml
> 
> diff --git a/Documentation/devicetree/bindings/rtc/adi,max31335.yaml b/Documentation/devicetree/bindings/rtc/adi,max31335.yaml
> new file mode 100644
> index 000000000000..8da9cf2565be
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/adi,max31335.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/adi,max31335.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX31335 RTC
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description:
> +  Analog Devices MAX31335 I2C RTC ±2ppm Automotive Real-Time Clock with
> +  Integrated MEMS Resonator.
> +
> +allOf:
> +  - $ref: rtc.yaml#
> +
> +properties:
> +  compatible:
> +    const: adi,max31335
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    description:
> +      RTC can be used as a clock source through its clock output pin.
> +    const: 0
> +
> +  trickle-resistor-ohms:
> +    description:
> +      Selected resistor for trickle charger. Should be specified if trickle
> +      charger should be enabled.
> +    enum: [3000, 6000, 11000]
> +
> +  aux-voltage-chargeable: true

Drop, it comes with rtc.yaml.

With this property removed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

