Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E677B63EE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239316AbjJCIVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjJCIVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:21:44 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CE1A1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 01:21:41 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9adca291f99so101575366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 01:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696321300; x=1696926100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2OsUWa+60Pk/AwTuhKv3SYSg0qsl/O+pywEtKcJj0U4=;
        b=kyatjfgI8kTaYXD8JYMoQV29xTNsVumDSSr4ZprEx+pKfY3M4IHRKsQM5xZIKhbm2P
         CtqIjuX4zQb1tc4UmmZrSaB+mxeGgvdbNLRmuazHa4QdcIgW/DEbTMvx9eI8LbDGDB9B
         w6OvnylPC7N+Ce+f2Itd1NFWsmICjUkPrzZpFLGFuwtDdph1RqsZdjm7DoGudC/P1qi0
         E2SXbyy4Bjum0Sjqr8vq9nRCqdlrqxrqG1XluQFFyF0Sjuz+T9WuQ2YBZt13sfImhhkQ
         5AN8BQ4VFBSD4RdjN43QOAo/CV+XqP82i6Komcv7qlYKr7+byzGQTh3NeozJy3WX0Flm
         6RJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696321300; x=1696926100;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OsUWa+60Pk/AwTuhKv3SYSg0qsl/O+pywEtKcJj0U4=;
        b=PSt6Bsf9ep/HAy61Mq6NZBZEurM2dcxZgws7OBrYKohLbWIEkJh8pFDI1b3KWMcTHm
         Cg2cyjONcYTLMuPkWe9BojyinkaX+IUkj9sqnIRcofsNdeEStvGvDolbac16hE5SHpU5
         gGpEMNXt089w4uXRkVajGtRRegZJVIzvnXO311NZT8lMA7pCat3pRqJrdzBY8FoW0zwi
         nOZvMeclCTAGi+g+RaMnaXQDfCcPmFBJObzZhN9QSL+m75prAmZgD864UlAetaOE/Q00
         p124oQ/RxqIphj9Wa/4GoWeQh3KmVxXOuEoG/QhSFyV1BZLnM6mny+1uW6BWATfzwxOT
         qlUA==
X-Gm-Message-State: AOJu0Yz5BPqMdG6haTA0JrGebjFe0tUbWZI/yKWic0PqD5FjNWoeRl7i
        qW8dVOvECHQsHVcJPLJ28tgPig==
X-Google-Smtp-Source: AGHT+IH3HQzbyGQgwHtW4F7KkdiMtDAItUpb1f/p4BpmXpMj6j1XBSlB9Bmr3VI3n8dbbWhiX5f/kA==
X-Received: by 2002:a17:907:7859:b0:9ad:78b7:29ea with SMTP id lb25-20020a170907785900b009ad78b729eamr12220794ejc.44.1696321299824;
        Tue, 03 Oct 2023 01:21:39 -0700 (PDT)
Received: from [192.168.1.197] (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id s17-20020a170906c31100b009adc77fe164sm643707ejz.66.2023.10.03.01.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 01:21:39 -0700 (PDT)
Message-ID: <55f63415-781a-4107-8643-9f77c7ee38d1@linaro.org>
Date:   Tue, 3 Oct 2023 10:21:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] dt-bindings: Add beaglecc1352
Content-Language: en-US
To:     Ayush Singh <ayushdevel1325@gmail.com>,
        greybus-dev@lists.linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vaishnav@beagleboard.org,
        jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20231002182454.211165-1-ayushdevel1325@gmail.com>
 <20231002182454.211165-2-ayushdevel1325@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231002182454.211165-2-ayushdevel1325@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2023 20:24, Ayush Singh wrote:
> Add DT bindings for BeaglePlay CC1352 co-processor.
> 

Thank you for your patch. There is something to discuss/improve.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. For example:
dt-bindings: net:


> The BeaglePlay has a CC1352 co-processor. This co-processor is connected
> to the main AM62 (running Linux) over UART. In the BeagleConnect
> Technology, CC1352 is responsible for handling 6LoWPAN communication
> with beagleconnect freedom nodes as well as their discovery
> 
> This commit adds net/ti,cc1352p7. It is used by gb-beagleplay greybus

A nit: I pointed you to the documentation explaining not to use "This
commit adds". It's v6 and the wording is back. Instead drop both
sentences - they are pointless in this context. First one repeats
previous text, second describes driver, but we do not talk here about
drivers.

> driver.
> 
> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
> ---
>  .../devicetree/bindings/net/ti,cc1352p7.yaml  | 48 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> new file mode 100644
> index 000000000000..57bc2c43e5b1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/ti,cc1352p7.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/ti,cc1352p7.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments Simplelink CC1352P7 wireless MCU
> +
> +description:
> +  The cc1352p7 mcu can be connected via SPI or UART.

If over SPI, then the binding is incomplete. This is fine for now, I guess.

> +
> +maintainers:
> +  - Ayush Singh <ayushdevel1325@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: ti,cc1352p7
> +
> +  clocks:
> +    maxItems: 2

Instead please list the items like:

clocks:
  items:
    - description: High-Foo-bar
    - description: Low-Foo-bar

> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  power-gpios:
> +    maxItems: 3
> +    description:
> +      The device has three power rails that are exposed on external pins VDDS,
> +      VDDR and DCOUPL.

No, power rails are not GPIOs. You need supplies, so:
vdds-supply: true
vddr-supply: true
dcoupl-supply: true

Look also at:
Documentation/devicetree/bindings/gpio/gpio-consumer-common.yaml
which explicitly allows only one powerdown GPIO.

> +

Best regards,
Krzysztof

