Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1757B7DAEBF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjJ2WPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 18:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjJ2WPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:15:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C413DB6;
        Sun, 29 Oct 2023 15:15:42 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.24.143.101])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0AB9466072BB;
        Sun, 29 Oct 2023 22:15:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698617741;
        bh=CjPNcKIkayOOu9llA0cQzyKcvkH1gHoQq6weHsJqTKA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DA0HpUwj+MG6H8VqTIZG9YKjh36wM/9UvhgOUuynwmqi4zwuxP0bcQoERR0/l/aPH
         FIIyksNtavnGYFGUfLtKBvpyLJb3MS/yp7Q7MAVLDWBDPh0ejzyWyb4kGRzuq8QL43
         zJ+vefd93vIr8XnbqJQK8Ii8kdMeA+rbjbW9PhDcRDqUbfuMx5ZSwt+VikYDVsfND3
         DR86t6NusBnM0O/j80Q5WD7PWHaJLaYrLtosNjOOo+WLGx/Tz8Ad26Se4u/+c69Fyh
         wvKsyEknLmue8ZQMb9/dEUX/eCL5ta4x+iN0l6O7aCNr1HYdyBL15w2I8miUippqCJ
         /7DWFNVOg9l5A==
Message-ID: <e86247b3-a6f4-44cf-90c4-583d850f6dd8@collabora.com>
Date:   Mon, 30 Oct 2023 00:15:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] dt-bindings: net: starfive,jh7110-dwmac: Add
 JH7100 SoC compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <e8f18634-7187-4e5a-a494-329c7c602fd2@linaro.org>
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

On 10/29/23 13:24, Krzysztof Kozlowski wrote:
> On 29/10/2023 05:27, Cristian Ciocaltea wrote:
>> The Synopsys DesignWare MAC found on StarFive JH7100 SoC is quite
>> similar to the newer JH7110, but it requires only two interrupts and a
>> single reset line.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
>>  .../bindings/net/starfive,jh7110-dwmac.yaml   | 74 +++++++++++++------
>>  2 files changed, 54 insertions(+), 21 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> index a4d7172ea701..c1380ff1c054 100644
>> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>> @@ -95,6 +95,7 @@ properties:
>>          - snps,dwmac-5.20
>>          - snps,dwxgmac
>>          - snps,dwxgmac-2.10
>> +        - starfive,jh7100-dwmac
>>          - starfive,jh7110-dwmac
>>  
>>    reg:
>> diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
>> index 44e58755a5a2..70e35a3401f4 100644
>> --- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
>> @@ -13,10 +13,14 @@ maintainers:
>>  
>>  properties:
>>    compatible:
>> -    items:
>> -      - enum:
>> -          - starfive,jh7110-dwmac
>> -      - const: snps,dwmac-5.20
>> +    oneOf:
>> +      - items:
>> +          - const: starfive,jh7100-dwmac
>> +          - const: snps,dwmac
>> +      - items:
>> +          - enum:
>> +              - starfive,jh7110-dwmac
>> +          - const: snps,dwmac-5.20
> 
> Why do you use different fallback?

AFAIK, dwmac-5.20 is currently only used by JH7110.

>>  
>>    reg:
>>      maxItems: 1
>> @@ -37,23 +41,6 @@ properties:
>>        - const: tx
>>        - const: gtx
>>  
>> -  interrupts:
>> -    minItems: 3
>> -    maxItems: 3
>> -
>> -  interrupt-names:
>> -    minItems: 3
>> -    maxItems: 3
>> -
>> -  resets:
>> -    minItems: 2
>> -    maxItems: 2
> 
> You just changed it in previous patches... So the previous code allowing
> one item was correct?

I mentioned the possible use-cases in the previous email. So yes, JH7110
requires 2 resets, while JH7100 just one.

Regards,
Cristian
