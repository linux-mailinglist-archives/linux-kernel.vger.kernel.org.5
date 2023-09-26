Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99227AF347
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 20:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbjIZStw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 14:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbjIZStu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 14:49:50 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF456139
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:49:42 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a6190af24aso1166286766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 11:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695754181; x=1696358981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tyXalGA9+XN1iK71fzykPOplz8rTMa6VlrFOAX1gLuE=;
        b=laueBE0UOCHhUo5ab6qz6wVNUlDFJi2q989nbtPgZE4MllFgRddjxmLyGJHhnvEgEw
         lE5Gk5PiGEMYMYpvivsIjUk9548urDRh9NwaQmWA4RdqLk7RvnZp+zx7XHBaUHbnB2Sc
         +DxkkJHr2vtEL9F6ekX5pR/TSQhxqLKjVRdUNaOXQofYYJXAYSpbLeNswt1NFTMkJpzg
         JqkG1W/9Tb/UWR7Igu2VeGvWppjrbdrBaMAOWVicTk3ohcyqjtfZmj4KGwSWvu8hnlLh
         qtbHmLkuQyFNEB+ab9hEzaUzprLFNSRlPZiwUwgb1dLjOicxVwk1GVj14wk3sE8PiBGY
         O8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695754181; x=1696358981;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyXalGA9+XN1iK71fzykPOplz8rTMa6VlrFOAX1gLuE=;
        b=BIwS9mNK3LUlKnaQH+oH5ZcJ/n0gVmDod1koYkp6rlY11cGQDJx/5gulF89Vx3BXKC
         zyw6Nkx6hJdTEXWU+uEcgVVRMhKWbOsDBJEr1I9QvpODrEVsPAHnuOM/2vcMkU3SzmYu
         6hZwmKx5c3vWDStf+Z0GrQLwkRB1CQef/ZPX9quGCPc6pLshThzocA5J7Mg4+jYPF1/s
         EE4limKDOmPtzRpaivjuo2++xajoHKcxskoWsP3iq6jQKFt11KwPwCykmYLoZJqz9oBd
         Lt0B2uPgbRsSZbpVCVBOshXwNbzmYB0N5S7L/sc6D3zE+EI2QEAMahZF195ExI5n5XA7
         XxYw==
X-Gm-Message-State: AOJu0YzuaAe4p8mPRlhjetT9F9wJ9KCBRO3wVnaMY1gC0h5iYnpXZfkn
        vnEaEkPlIXKRQnpjdJ7+tl+OvA==
X-Google-Smtp-Source: AGHT+IGzA10+P51wbmU+Z0gnDj+kE8rF06FJ+BweHiVVO/K84QZQve4AIqdaWZ/XkcokugeSgPfeGw==
X-Received: by 2002:a17:906:30d3:b0:9ae:6538:643b with SMTP id b19-20020a17090630d300b009ae6538643bmr9073221ejb.38.1695754181174;
        Tue, 26 Sep 2023 11:49:41 -0700 (PDT)
Received: from [192.168.168.156] (host-87-4-82-94.retail.telecomitalia.it. [87.4.82.94])
        by smtp.gmail.com with ESMTPSA id sd6-20020a170906ce2600b00997e99a662bsm8080405ejb.20.2023.09.26.11.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 11:49:40 -0700 (PDT)
Message-ID: <d9b4c469-34b5-4616-aa79-93df94c07be1@linaro.org>
Date:   Tue, 26 Sep 2023 20:49:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: media: i2c: add galaxycore,gc2145
 dt-bindings
To:     Alain Volmat <alain.volmat@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230926092825.819229-1-alain.volmat@foss.st.com>
 <20230926092825.819229-2-alain.volmat@foss.st.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20230926092825.819229-2-alain.volmat@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2023 11:28, Alain Volmat wrote:
> Introduction of the Galaxy Core GC2145 XVGA CMOS camera sensor.
> 
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> ---

...

> +properties:
> +  compatible:
> +    const: galaxycore,gc2145
> +
> +  reg:
> +    enum:
> +      - 0x3c
> +
> +  clocks:
> +    description: Reference to the xclk clock.
> +    maxItems: 1

If xclk is the name of the pin and you want to mention it, then just:
items:
 - description: xclk clock

(no "reference" or "GPIO descriptor" because it is redundant as Conor wrote)

> +
> +  powerdown-gpios:
> +    description: GPIO descriptor for the powerdown pin.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: GPIO descriptor for the reset pin.
> +    maxItems: 1
> +
> +  IOVDD-supply:

lowercase, so iovdd-supply. Same in other places.

> +    description: Power Supply for I/O circuits (1.7 - 3V).
> +
> +  AVDD-supply:
> +    description: Power for analog circuit/sensor array (2.7 - 3V).
> +
> +  DVDD-supply:
> +    description: Power for digital core (1.7 - 1.9V).
> +
> +  orientation: true
> +
> +  rotation: true
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/media/video-interfaces.yaml#
> +        unevaluatedProperties: false
> +
> +    required:
> +      - endpoint
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - powerdown-gpios
> +  - reset-gpios
> +  - IOVDD-supply
> +  - AVDD-supply
> +  - DVDD-supply
> +  - port
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c5 {

i2c

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        gc2145@3c {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +            compatible = "galaxycore,gc2145";
> +            reg = <0x3c>;
Best regards,
Krzysztof

