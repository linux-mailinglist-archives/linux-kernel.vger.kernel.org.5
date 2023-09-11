Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1E079A267
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 06:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjIKE2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 00:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIKE2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 00:28:30 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901F010D;
        Sun, 10 Sep 2023 21:28:26 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-495c61da03fso992791e0c.0;
        Sun, 10 Sep 2023 21:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694406505; x=1695011305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=39CcgD+03X9cXv+2upmXtbvj4NqiZBlzasJs6x6U7D4=;
        b=cJx16JgE5d+3TeeL+PzAjPQOIgjLZXiemIglu804TsilUvLHQqIHEmgUff04dF64cv
         xOGZcvZGSlL8Cx/ZUsVvbBdwmiIDLiigGTOYwx2gXCb4+sBCi3+XHgiKOUYyymOUiw4R
         y1dLRU7qyJgyMfNkDoE3Gtl+kACJV0TJ9OrAPWoLrM9TvHudNd+gSE4x1qJAtTLdkUG9
         77WFfl9qX9WQOrMo3XoALBXhbr92az+SI00OdpUCTGiuanZ0TjqNWVPX3dGmhTQjNG/u
         GKbjIVtm3kk/4Y89p4cBHOiLFW068p5gbLB3EVXZ8EDQLFO45rlbLlV3zDOIpg5P6nXU
         Qrww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694406505; x=1695011305;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39CcgD+03X9cXv+2upmXtbvj4NqiZBlzasJs6x6U7D4=;
        b=OUJ3AVJMXXOzETrQI2xoZ5wI6QdyOspnvGSoNkcVGlZIxoT5NgGTd8eq/un717mjJk
         kUXpKdN+yt49aWK9tzNxK9xeNsuzHECoU3jN3ZHGy725LV4Dl12C+GP16rbZy2ietRKe
         JG4WfHAfoOy+UNTI0lY1Cz9z93WPzCx1v2wpewtxwmYQH+FQ/r3G0lHi3G+z4maAwfMh
         DhLuCl1XM66R0KKtG8CFqcWa/gLyJK7VEMQPct1IFySkOjnqpGemmddFLO2AAhs8UMpX
         pfApC10lGNPIy7xDeQWtA2sX03VKlX8hhqyQ3DF4YYEUBEfH6R+0CvsBaEimZ5bDjgdi
         Z3lg==
X-Gm-Message-State: AOJu0YwjypgcCUop4mI0xwq8p07rOu0E58MM9opcGGt1SqXE57hClJjp
        mHtfDGwiaSqZF4E5KM2nYNI=
X-Google-Smtp-Source: AGHT+IGBLntCvCUcZAKnCE9LezsBAfzz+/Q7mNdmsmDJjP6s4SYlYhdmUabTokCk7MT1GWN2KJtcUA==
X-Received: by 2002:a1f:6d03:0:b0:495:e770:bbaa with SMTP id i3-20020a1f6d03000000b00495e770bbaamr1380572vkc.4.1694406505627;
        Sun, 10 Sep 2023 21:28:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r25-20020a02c859000000b0042bb394c249sm1903824jao.38.2023.09.10.21.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 21:28:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <51e1a409-4389-bccd-4093-d7fd6ff6ae95@roeck-us.net>
Date:   Sun, 10 Sep 2023 21:28:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/3] dt-bindings: regulator: Add mps,mpq2286
 power-management IC
Content-Language: en-US
To:     Saravanan Sekar <saravanan@linumiz.com>, sravanhome@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jdelvare@suse.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20230911034150.181880-1-saravanan@linumiz.com>
 <20230911034150.181880-3-saravanan@linumiz.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230911034150.181880-3-saravanan@linumiz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/23 20:41, Saravanan Sekar wrote:
> Document mpq2286 power-management IC
> 
> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>

I don't know how this kind of thing is typically handled in .yaml
files, but given that the chip is supposedly almost the same as MPQ7932
(except for the number of regulators), would it possibly make sense
to describe both in a single devicetree file ?

Guenter

> ---
>   .../bindings/regulator/mps,mpq2286.yaml       | 59 +++++++++++++++++++
>   1 file changed, 59 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml b/Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml
> new file mode 100644
> index 000000000000..d00d887870a9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/mps,mpq2286.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Monolithic Power System MPQ2286 PMIC
> +
> +maintainers:
> +  - Saravanan Sekar <saravanan@linumiz.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mps,mpq2286
> +
> +  reg:
> +    maxItems: 1
> +
> +  regulators:
> +    type: object
> +
> +    properties:
> +      "buck0":
> +        type: object
> +        $ref: regulator.yaml#
> +
> +        unevaluatedProperties: false
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - regulators
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic@3 {
> +            compatible = "mps,mpq2286";
> +            reg = <0x3>;
> +
> +            regulators {
> +                buck {
> +                    regulator-name = "buck0";
> +                    regulator-min-microvolt = <1600000>;
> +                    regulator-max-microvolt = <1800000>;
> +                    regulator-boot-on;
> +                };
> +            };
> +        };
> +    };
> +...

