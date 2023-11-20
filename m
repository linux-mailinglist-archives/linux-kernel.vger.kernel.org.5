Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF477F1031
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjKTKVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjKTKVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:21:52 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D34A4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:21:47 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32faea0fa1fso2391387f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700475706; x=1701080506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tngpdwuisNQKc4yHRR1zw3uy9f0IRUoH/YVWCHWZtpQ=;
        b=CvrXlCb7LvOU8cne5sPAFJcgM0/zraAMRqYAxohoDZuZ+bY0r7xINlNO11KBRWiRmD
         P2dqdTopGbSSfA+q087GhhSKtj3yqu39635syKo9q0CqGSeYPVJFglcHDfeRZjhlekVD
         +jUbNMUS+ND0zx3dE+pfU2slEQnwm6U/v99kATkPoJCMUp7cJrFwXRgQTo+d8gr1UHpe
         ywZnv6gvT9FUxvWCIrS9wjRyrjS8byBUZtg7qKwzlzx61oyEohwTcy6vEpfcuJaod9Nr
         WzItzodLMKkDdoZmnIXPAwZIzM1HDRS6w+C+cjdb5wrX/2ZyvlFpYPmuqyzbUYne1n/h
         hThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700475706; x=1701080506;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tngpdwuisNQKc4yHRR1zw3uy9f0IRUoH/YVWCHWZtpQ=;
        b=I5/zrVGprZ9Kf2IUDV2NxuvOQLQRLIprzdT28J3fNIrquZQY826D2tqItOAZ2/22cf
         HJIrZ3LgXHxSc2eZpoQ+MbVGv9Kaf9EkXxtOAYKtzGsfYwaABUgHK+F3PAniXQcIsGOI
         NRhelZq42fkZvlSD93sxuXofBkYHfrI9mgbe14UXRV7kRX/uxC8FjerWNkIfWQ1EQqW8
         FbxNGBd18jW1qm6Zu4voX+TJa2+oHxBB9Dr7O4z0PLCj6DcA8DMaovFoATQ137pjaWva
         ur8TmkBowrf8MJRJNDLA9fYaDR9a+6WpxNPeOFqrKeOvBqB+rwiBS70zv3G+Z2Ab6mle
         TXpA==
X-Gm-Message-State: AOJu0YyCJnTiehXy41KKy+FeN0FgHoAYb7bjMyO5/dncpSczscYZ+TOr
        +Xz8WsMURRzHc7A3UZb60fBC4Q==
X-Google-Smtp-Source: AGHT+IHdpu/jgQOo1ThY3WmjYCGXOAN5pKC+tnMqToAyZ8BBNTmS0ynW6TgaqBsZCwA107M21yFjEg==
X-Received: by 2002:a05:6000:1a88:b0:332:cb9d:c145 with SMTP id f8-20020a0560001a8800b00332cb9dc145mr336973wry.18.1700475706348;
        Mon, 20 Nov 2023 02:21:46 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id r7-20020a056000014700b0032fab28e9c9sm10766114wrx.73.2023.11.20.02.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 02:21:44 -0800 (PST)
Message-ID: <5b2e4b05-9408-48ea-92ac-15883e102013@linaro.org>
Date:   Mon, 20 Nov 2023 11:21:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: pressure: add honeywell,hsc030
Content-Language: en-US
To:     Petre Rodan <petre.rodan@subdimension.ro>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Jonathan Cameron <jic23@kernel.org>
References: <20231117164232.8474-1-petre.rodan@subdimension.ro>
 <20231117192305.17612-1-petre.rodan@subdimension.ro>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231117192305.17612-1-petre.rodan@subdimension.ro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2023 20:22, Petre Rodan wrote:
> Adds binding for digital Honeywell TruStability HSC and SSC series pressure 
> and temperature sensors.
> 
> Datasheet:
>  [HSC] https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf
>  [SSC] https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-ssc-series/documents/sps-siot-trustability-ssc-series-standard-accuracy-board-mount-pressure-sensors-50099533-a-en-ciid-151134.pdf
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
> 
> Changes for v2:
> - Removed redundant quotations reported by robh's bot
> - Fixed yamllint warnings
> 
> I'm failing to run 'make DT_CHECKER_FLAGS=-m dt_binding_check' due to
> python errors and exceptions
> ---
>  .../iio/pressure/honeywell,hsc030pa.yaml      | 156 ++++++++++++++++++
>  1 file changed, 156 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
> new file mode 100644
> index 000000000000..c7e5d3bd5ef4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
> @@ -0,0 +1,156 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/pressure/honeywell,hsc030pa.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Honeywell TruStability HSC and SSC pressure sensor families
> +
> +description: |
> +  support for Honeywell TruStability HSC and SSC digital pressure sensor
> +  families.
> +
> +  These sensors have either an I2C, an SPI or an analog interface. Only the
> +  digital versions are supported by this driver.
> +
> +  There are 118 models with different pressure ranges available in each family.
> +  The vendor calls them "HSC series" and "SSC series". All of them have an
> +  identical programming model but differ in pressure range, unit and transfer
> +  function.
> +
> +  To support different models one need to specify the pressure range as well as
> +  the transfer function. Pressure range can either be provided via range_str or
> +  in case it's a custom chip via numerical range limits converted to pascals.
> +
> +  The transfer function defines the ranges of raw conversion values delivered
> +  by the sensor. pmin-pascal and pmax-pascal corespond to the minimum and
> +  maximum pressure that can be measured.
> +
> +  Specifications about the devices can be found at:
> +  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf
> +  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-ssc-series/documents/sps-siot-trustability-ssc-series-standard-accuracy-board-mount-pressure-sensors-50099533-a-en-ciid-151134.pdf
> +
> +maintainers:
> +  - Petre Rodan <petre.rodan@subdimension.ro>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - honeywell,hsc

Way too generic

> +      - honeywell,ssc

Way too generic

> +
> +  reg:
> +    maxItems: 1
> +
> +  honeywell,transfer-function:
> +    description: |
> +      Transfer function which defines the range of valid values delivered by
> +      the sensor.
> +      0 - A, 10% to 90% of 2^14
> +      1 - B, 5% to 95% of 2^14
> +      2 - C, 5% to 85% of 2^14
> +      3 - F, 4% to 94% of 2^14
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  honeywell,range_str:

No underscores in property names.

"str" is redundant. Instead say what is it, because "range" is way too
vague.

> +    description: |
> +      Five character string that defines "pressure range, unit and type"
> +      as part of the device nomenclature. In the unlikely case of a custom
> +      chip, set to "NA" and provide honeywell,pmin-pascal honeywell,pmax-pascal
> +    enum: [001BA, 1.6BA, 2.5BA, 004BA, 006BA, 010BA, 1.6MD, 2.5MD, 004MD,
> +           006MD, 010MD, 016MD, 025MD, 040MD, 060MD, 100MD, 160MD, 250MD,
> +           400MD, 600MD, 001BD, 1.6BD, 2.5BD, 004BD, 2.5MG, 004MG, 006MG,
> +           010MG, 016MG, 025MG, 040MG, 060MG, 100MG, 160MG, 250MG, 400MG,
> +           600MG, 001BG, 1.6BG, 2.5BG, 004BG, 006BG, 010BG, 100KA, 160KA,
> +           250KA, 400KA, 600KA, 001GA, 160LD, 250LD, 400LD, 600LD, 001KD,
> +           1.6KD, 2.5KD, 004KD, 006KD, 010KD, 016KD, 025KD, 040KD, 060KD,
> +           100KD, 160KD, 250KD, 400KD, 250LG, 400LG, 600LG, 001KG, 1.6KG,
> +           2.5KG, 004KG, 006KG, 010KG, 016KG, 025KG, 040KG, 060KG, 100KG,
> +           160KG, 250KG, 400KG, 600KG, 001GG, 015PA, 030PA, 060PA, 100PA,
> +           150PA, 0.5ND, 001ND, 002ND, 004ND, 005ND, 010ND, 020ND, 030ND,
> +           001PD, 005PD, 015PD, 030PD, 060PD, 001NG, 002NG, 004NG, 005NG,
> +           010NG, 020NG, 030NG, 001PG, 005PG, 015PG, 030PG, 060PG, 100PG,
> +           150PG, NA]
> +    $ref: /schemas/types.yaml#/definitions/string
> +
> +  honeywell,pmin-pascal:
> +    description: |
> +      Minimum pressure value the sensor can measure in pascal.
> +      To be specified only if honeywell,range_str is set to "NA".
> +    $ref: /schemas/types.yaml#/definitions/int32

That's uint32. Why do you need negative values?

> +
> +  honeywell,pmax-pascal:
> +    description: |
> +      Maximum pressure value the sensor can measure in pascal.
> +      To be specified only if honeywell,range_str is set to "NA".
> +    $ref: /schemas/types.yaml#/definitions/int32

Ditto

> +
> +  vdd-supply:
> +    description: |
> +      Provide VDD power to the sensor (either 3.3V or 5V depending on the chip).
> +      Optional, activate only if required by the target board.

Drop the last sentence. The supplies are required not by target board
but by hardware. I also do not understand what "activate" means in terms
of bindings and DTS.

> +
> +  spi-max-frequency:
> +    description: SPI clock to be kept between 50 and 800kHz

Drop description, add minimum/maximum constraints if worth.

> +
> +  clock-frequency:
> +    description: i2c clock to be kept between 100 and 400kHz

Drop, that's not really an I2C device property. Your driver must use
common clock framework.

> +
> +required:
> +  - compatible
> +  - reg
> +  - honeywell,transfer-function
> +  - honeywell,range_str
> +  - clock-frequency

Why?

> +  - spi-max-frequency
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +        status = "okay";

?!? Drop

> +        clock-frequency = <400000>;

Drop

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        HSCMRNN030PA2A3@28 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Plus, upper case is not allowed...

> +          status = "okay";

Drop. BTW status never comes first!

> +          compatible = "honeywell,hsc";
> +          reg = <0x28>;
> +
> +          honeywell,transfer-function = <0>;
> +          honeywell,range_str = "030PA";
> +        };
> +    };
> +
> +    spi {
> +        # note that MOSI is not required by this sensor

This should be then part of description, not example.

> +        status = "okay";

Drop

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        HSCMLNN100PASA3@0 {

Eh...

> +          status = "okay";

Drop

> +          compatible = "honeywell,hsc";
> +          reg = <0>;
> +          spi-max-frequency = <800000>;
> +
> +          honeywell,transfer-function = <0>;
> +          honeywell,range_str = "100PA";
> +        };
> +
> +        HSC_CUSTOM_CHIP@0 {

Drop, not needed. One example is enough.

> +          status = "okay";
> +          compatible = "honeywell,hsc";
> +          reg = <1>;
> +          spi-max-frequency = <800000>;

Also, your indentation is broken.

Use 4 spaces for example indentation.

> +
> +          honeywell,transfer-function = <0>;
> +          honeywell,range_str = "NA";
> +          honeywell,pmin-pascal = <0>;
> +          honeywell,pmax-pascal = <206850>;
> +        };
> +

No stray blank lines.

Best regards,
Krzysztof

