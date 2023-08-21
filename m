Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C19D783152
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjHUTPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjHUTPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:15:01 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94331C2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:14:59 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-523d2ef19e4so4657335a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692645298; x=1693250098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hcH1ALy9H3tDFbJm3wOr+HufOrkenlcpo1T0f8uoLM=;
        b=qFv+04FGS6uFsxRMQK/sE7bot81vGImL9SQAwBSFzzFodX1zNjUnvrE7BrVx1/OaFw
         5paA9cY4UhbKnHVH9pjZa+y+xktCYoy2xNMdiO0IMt42Smke1N3dfd6DwuVFsDg/GR7H
         Qh7rdOLKVp/IbvGUKUcmJMbZ3iK9loxlqvGiYnlWpwyn+gKHVWPT2QPiAoThWY68Yb06
         skzrjNnhL2Mudf8PEK1fqUEO6DJlaPcTfHCA5ZpDrNsOTGZmpLIoPvFolfWmmzfGWKhm
         LI+gLILRqMfFw2CzTYz99mQ5O7GgFvC8fETY517UfRvQmgDoSSbEjCVDjFE6u+1l8M7p
         76JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692645298; x=1693250098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hcH1ALy9H3tDFbJm3wOr+HufOrkenlcpo1T0f8uoLM=;
        b=mDDojy0EB7shKiXMdknDcEx8+9JdvwV/1sJKqO2uvW02qB1ajkCYZXlArzQDi6FakH
         uIF4OtaSUygs262e5NAoe7pgcxC3RonIki53MaYk+tgqWRld1/QX6NuezHLyPyIYXNce
         DnBoprh/H3lOiFWug/fzzeC4Jzhg6q9V1tWtffK7mRyIJI/zRVQcoggtqMm4epPnJGj+
         cQlTnU/3wDSz1demj+r8gp6d6FuQRa4KLcviC6+kG8mEBTGINW2FEBOChKwUYp5uz9x4
         Osdsjtf7KM1Ax33+iIdCJrHaZiMysspm2zSDOj4G9O6VSs2xqSVKSO2ydIVvv85ODDpi
         ObFQ==
X-Gm-Message-State: AOJu0YyhNh/Y1OmqkgL5Cj/YnF72viakN2mITbBT48mRKyXKZ3iOKdx+
        DBUm+nlOrzfh+2y7oTDICULd7ov5rtXdeAyFxgw=
X-Google-Smtp-Source: AGHT+IHOXwU5zBh/FCh6APGxe0258tOTWE5VlIe7CGEdtJVLH8z/Wa01dvGw8u3T21KyspeVVm8Glg==
X-Received: by 2002:a17:906:1099:b0:99d:5adc:fdff with SMTP id u25-20020a170906109900b0099d5adcfdffmr5786196eju.45.1692643262214;
        Mon, 21 Aug 2023 11:41:02 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id l12-20020a17090612cc00b0098de7d28c34sm6956195ejb.193.2023.08.21.11.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 11:41:01 -0700 (PDT)
Message-ID: <e3d53646-9d04-d599-0670-a43f3c4a7d3e@linaro.org>
Date:   Mon, 21 Aug 2023 20:41:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] dt-bindings: regulator: Add MAX77503 regulator
 bindings
To:     Gokhan Celik <gokhan.celik@analog.com>, outreachy@lists.linux.dev
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1692634090.git.gokhan.celik@analog.com>
 <50b983f2eb74aab5947cf7721770983b51ffd949.1692634090.git.gokhan.celik@analog.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <50b983f2eb74aab5947cf7721770983b51ffd949.1692634090.git.gokhan.celik@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2023 18:28, Gokhan Celik wrote:
> Add bindings for MAX77503 buck converter.
> 
> Signed-off-by: Gokhan Celik <gokhan.celik@analog.com>

Subject:
regulator: dt-bindings:

and drop final, redundant "bindings"

> ---
>  .../regulator/adi,max77503-regulator.yaml     | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/adi,max77503-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/adi,max77503-regulator.yaml b/Documentation/devicetree/bindings/regulator/adi,max77503-regulator.yaml
> new file mode 100644
> index 000000000000..0d351225e107
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/adi,max77503-regulator.yaml

Filename like compatible.

> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (c) 2023 Analog Devices, Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/adi,max77503-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices MAX77503 Buck Converter
> +
> +maintainers:
> +  - Gokhan Celik <Gokhan.Celik@analog.com>
> +
> +description: Analog Devices MAX77503 Buck Converter
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,max77503
> +
> +  reg:
> +    description: I2C address of the device
> +    items:
> +      - enum: [0x1e, 0x24, 0x37]
> +
> +  regulator:

Why having this intermediate node? It's useless for one regulator, isn't it?


> +    type: object
> +    $ref: regulator.yaml#
> +    additionalProperties: false

You should rather use unevaluatedProperties:false and drop these ":true"
properties below.

> +    description: |
> +      Buck regulator
> +
> +    properties:
> +      regulator-name: true

Drop

> +      regulator-always-on: true

Drop

> +      regulator-boot-on: true

Drop

> +      regulator-min-microvolt:
> +        minimum: 800000

maximum?

> +      regulator-max-microvolt:
> +        maximum: 5000000

minimum?

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        max77503@1e {

regulator@1e

> +            compatible = "adi,max77503";
> +            reg = <0x1e>;
> +            regulator{
> +                regulator-name = "max777503-regulator";
> +                regulator-min-microvolt = <800000>;
> +                regulator-max-microvolt = <5000000>;
> +                regulator-boot-on;
> +            };
> +        };
> +    };
> +

Best regards,
Krzysztof

