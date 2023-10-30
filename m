Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795407DB454
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjJ3HbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjJ3Ha6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:30:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF13DEA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:30:54 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so6914934a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698651053; x=1699255853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dKsyf8LXjrxhnDHkoYar39IjV7I2cF7I3rz9k9N3k64=;
        b=CC0tXHaVCpIsVlUByf1cUZZptlUQdTkXQCyh07joUAXZkT20opq7d6YxYfY2Emxf0m
         03rFDfUJup8wzTqvCEdPydfJuSwWFkqbiC3IueOP9HHnYGGLhs+qUESHk6Xw0llEuqwS
         ywPwDvHGqNEBFgfh8YqDMTp3vJ1Rdb5Etn3bL6qaPD4JSd4+flJiAGq6eTM+JU7TaBYu
         DF4AuR85/VEIjUP6XVYlEIrzUfjvvAF6geiK6/7cz6WP9Yhwypj2zbqFSTkfxf1m9Vfo
         q2+LAmRcklyVwP1M9Y58G/7B4bfdwMiVK49W8N/h3rP3t9mP8Q1b40dEIcqkmxxw87le
         371Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698651053; x=1699255853;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dKsyf8LXjrxhnDHkoYar39IjV7I2cF7I3rz9k9N3k64=;
        b=Yjc56zue+NLcCEP1NlG4k6zp31WvtLuVh8GzYR0mqENXsRDYZcj7jFuhLtvn3D3ouP
         usGXcFPcQkRozZX7i9Ew6bAdOsiLh6FcHowLuCPSD95BC4ABCLIpOSFWHCHskb3RYBgE
         sF7ctNL67IhYlBvML6/w72vEX6IRlq/Uu+fQI0unMaAU4Vi0tky0Nk6jZDmY6fFvBH0t
         TVs1t/EVJQdzA23oTCoFgbDbV09B025cZHAG4z1S5kh6jPqD1o69okg/ex75QuSItM3B
         iVqVmAql0RNt/KNg0c6nzqxKsSP/ukXEqPwk9rG1Ko7/Jeybxz7iMAc+bYg2r1BRQ5sJ
         s5EQ==
X-Gm-Message-State: AOJu0YxDf1fnkLXSKGrSVF7QKLZVUAjw++PoMIC0vDzOkjzOO7B7Rdpr
        dl49NsGt5kNbrbNjrCG8c6LPXw==
X-Google-Smtp-Source: AGHT+IFbW3c/ycdFODwV1d2F+eIuDrPKoVPwJFEooXEALeleQB0leVMW+7i7JJjX0HH390RyocEIAg==
X-Received: by 2002:a50:ccc1:0:b0:540:16d0:3332 with SMTP id b1-20020a50ccc1000000b0054016d03332mr7243263edj.20.1698651053222;
        Mon, 30 Oct 2023 00:30:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id eg25-20020a056402289900b0053dab756073sm5579901edb.84.2023.10.30.00.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 00:30:52 -0700 (PDT)
Message-ID: <35556392-3b9a-4997-b482-082dc2f9121f@linaro.org>
Date:   Mon, 30 Oct 2023 08:30:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] dt-bindings: net: starfive,jh7110-dwmac: Add
 JH7100 SoC compatible
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Samin Guo <samin.guo@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
 <20231029042712.520010-5-cristian.ciocaltea@collabora.com>
 <e8f18634-7187-4e5a-a494-329c7c602fd2@linaro.org>
 <e86247b3-a6f4-44cf-90c4-583d850f6dd8@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <e86247b3-a6f4-44cf-90c4-583d850f6dd8@collabora.com>
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

On 29/10/2023 23:15, Cristian Ciocaltea wrote:
> On 10/29/23 13:24, Krzysztof Kozlowski wrote:
>> On 29/10/2023 05:27, Cristian Ciocaltea wrote:
>>> The Synopsys DesignWare MAC found on StarFive JH7100 SoC is quite
>>> similar to the newer JH7110, but it requires only two interrupts and a
>>> single reset line.
>>>
>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>> ---
>>>  .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
>>>  .../bindings/net/starfive,jh7110-dwmac.yaml   | 74 +++++++++++++------
>>>  2 files changed, 54 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>> index a4d7172ea701..c1380ff1c054 100644
>>> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>> @@ -95,6 +95,7 @@ properties:
>>>          - snps,dwmac-5.20
>>>          - snps,dwxgmac
>>>          - snps,dwxgmac-2.10
>>> +        - starfive,jh7100-dwmac
>>>          - starfive,jh7110-dwmac
>>>  
>>>    reg:
>>> diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
>>> index 44e58755a5a2..70e35a3401f4 100644
>>> --- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
>>> +++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
>>> @@ -13,10 +13,14 @@ maintainers:
>>>  
>>>  properties:
>>>    compatible:
>>> -    items:
>>> -      - enum:
>>> -          - starfive,jh7110-dwmac
>>> -      - const: snps,dwmac-5.20
>>> +    oneOf:
>>> +      - items:
>>> +          - const: starfive,jh7100-dwmac
>>> +          - const: snps,dwmac
>>> +      - items:
>>> +          - enum:
>>> +              - starfive,jh7110-dwmac
>>> +          - const: snps,dwmac-5.20
>>
>> Why do you use different fallback?
> 
> AFAIK, dwmac-5.20 is currently only used by JH7110.

What is used by JH7000?

> 
>>>  
>>>    reg:
>>>      maxItems: 1
>>> @@ -37,23 +41,6 @@ properties:
>>>        - const: tx
>>>        - const: gtx
>>>  
>>> -  interrupts:
>>> -    minItems: 3
>>> -    maxItems: 3
>>> -
>>> -  interrupt-names:
>>> -    minItems: 3
>>> -    maxItems: 3
>>> -
>>> -  resets:
>>> -    minItems: 2
>>> -    maxItems: 2
>>
>> You just changed it in previous patches... So the previous code allowing
>> one item was correct?
> 
> I mentioned the possible use-cases in the previous email. So yes, JH7110
> requires 2 resets, while JH7100 just one.


Your previous patch does not make sense now...

Best regards,
Krzysztof

