Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925D17741D3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjHHR3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjHHR22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:28:28 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBB021261
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:12:18 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so11039a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691511102; x=1692115902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vQN2WrIQDnKqqepfQOzswIPO1pOEXGaui58WV1ZpQ54=;
        b=c88i9im1qDuzlpThXlYvdLHv7FQlBybyP8QDn63NzICff5nODd2KYKfnfAV6HAYfE6
         hpZXA/CdbonpP0mMEw8L+8/xJXoIpN37e6zo79HYKPRgydyMMiDbeBYp2F8Dz8XuEkcM
         mTj7MRkFloKW39nQND0369tEXX9RMDhUsm7RoxB8mKopppIRulzjHX7PYXm9N0U2QAwc
         iMGpVdOut9/iXwedpzJmMR8EIcsMWSTsn2kUuFpt6b6pw80zE2mYoPWaWv5ZCIG/I4AX
         mM85qpAKHI+vMaoJH2rV5qqj5seCimYA3Phgg/uPfujb4TFcTd6m+g6ekHnMXvD0rPK2
         tQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511102; x=1692115902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vQN2WrIQDnKqqepfQOzswIPO1pOEXGaui58WV1ZpQ54=;
        b=UpzO3BBGB7yZfgOztCwtIpPWYbHZyiB67QkYmkjIJfwt2HTnUWn6rY72MkgMcWKAxZ
         a58mu1aHM1FVlSvr8tEHsP7Q+rp1j/h39fvJoiPZdU18HdwL4ozCWpUGjnvQ/lQ6VQAh
         Sy0jcHW2T6siUhdM5Ifw8vonME7g45xIZex5QtYEWOnpTDseB0lE6te1dkvikQfJWO7h
         HslKM7mMlbgGKU9Ne5VNnyrqDpElrHuwOv1FTssvG7jKwXeiPjiI0edNJC89vbygYPVe
         /5LqLnW3lNnvGKY/JEgz/tt+D47tmQ+uXo/cdvcg4sOxjIuhg7bpYSeWLUZ7DbD+xm2a
         yTsw==
X-Gm-Message-State: AOJu0Yxv+o/TOm+CSJF14uBXTsqdUcdh15BLiIQnif7cUKgDV2flUS4t
        V4K0F/YYiQx2lhEt61nQLQNaijB5Cf5168NuMkE=
X-Google-Smtp-Source: AGHT+IFjcCWkNLtd9+huFXphMmx84LzMQOGNVdG/8yC7bNAWF+WydiqZ3qQOP21ujscxDIahjIMkBA==
X-Received: by 2002:a17:907:2cea:b0:993:f127:2391 with SMTP id hz10-20020a1709072cea00b00993f1272391mr90854ejc.32.1691507137196;
        Tue, 08 Aug 2023 08:05:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id m17-20020a170906235100b00985bdb7dd5fsm6659807eja.201.2023.08.08.08.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 08:05:36 -0700 (PDT)
Message-ID: <91f57b0d-a6e9-c039-40b6-0a1a9af5f7a0@linaro.org>
Date:   Tue, 8 Aug 2023 17:05:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/2] gpio: dt-bindings: add parsing of loongson gpio
 offset
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn
References: <20230807074043.31288-1-zhuyinbo@loongson.cn>
 <20230807074043.31288-2-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230807074043.31288-2-zhuyinbo@loongson.cn>
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

On 07/08/2023 09:40, Yinbo Zhu wrote:
> Loongson GPIO controllers come in multiple variants that are compatible
> except for certain register offset values. Add support in yaml file for
> device properties allowing to specify them in DT.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  .../bindings/gpio/loongson,ls-gpio.yaml       | 40 ++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> index fb86e8ce6349..fc51cf40fccd 100644
> --- a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> @@ -14,6 +14,7 @@ properties:
>      enum:
>        - loongson,ls2k-gpio
>        - loongson,ls7a-gpio
> +      - loongson,ls2k1000-gpio
>  
>    reg:
>      maxItems: 1
> @@ -29,6 +30,33 @@ properties:
>  
>    gpio-ranges: true
>  
> +  loongson,gpio-conf-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      This option indicate this GPIO configuration register offset address.
> +
> +  loongson,gpio-out-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      This option indicate this GPIO output register offset address.
> +
> +  loongson,gpio-in-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      This option indicate this GPIO input register offset address.
> +
> +  loongson,gpio-ctrl-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      This option indicate this GPIO control mode, where '0' represents
> +      bit control mode and '1' represents byte control mode.

I have no clue what does it mean. Is it only 0 or 1? Then it should be
enum or even bool.

> +
> +  loongson,gpio-inten-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      This option indicate this GPIO interrupt enable register offset
> +      address.
> +
>    interrupts:
>      minItems: 1
>      maxItems: 64
> @@ -39,6 +67,11 @@ required:
>    - ngpios
>    - "#gpio-cells"
>    - gpio-controller
> +  - loongson,gpio-conf-offset
> +  - loongson,gpio-in-offset
> +  - loongson,gpio-out-offset
> +  - loongson,gpio-ctrl-mode
> +  - loongson,gpio-inten-offset

No, you cannot add them as required to every other device. First, there
is no single need. Second, it breaks the ABI.

>    - gpio-ranges
>    - interrupts
>  
> @@ -49,11 +82,16 @@ examples:
>      #include <dt-bindings/interrupt-controller/irq.h>
>  
>      gpio0: gpio@1fe00500 {
> -      compatible = "loongson,ls2k-gpio";
> +      compatible = "loongson,ls2k1000-gpio";
>        reg = <0x1fe00500 0x38>;
>        ngpios = <64>;
>        #gpio-cells = <2>;
>        gpio-controller;
> +      loongson,gpio-conf-offset = <0>;
> +      loongson,gpio-in-offset = <0x20>;
> +      loongson,gpio-out-offset = <0x10>;
> +      loongson,gpio-ctrl-mode = <0>;
> +      loongson,gpio-inten-offset = <0x30>;

I still think that you just embed the programming model into properties,
instead of using dedicated compatible for different blocks. It could be
fine, although I would prefer to check it with your DTS.

Where is your DTS?

Best regards,
Krzysztof

