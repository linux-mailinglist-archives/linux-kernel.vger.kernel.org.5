Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3E77A8314
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbjITNRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbjITNRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:17:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC9CAD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:17:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-530fa34ab80so2013633a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695215849; x=1695820649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4z1ebTU1XlJL0RNvsPG4JRKzQxEhUmSGzIqnEtPiLRQ=;
        b=fdf7T2WSp1aqkPRuZ7vK0uFXsWWJozqklf5R0YrYAtvJ+ccj4tP3m6hZetS3ge5rqf
         qg47/gMfcFQS6UFDjWhm6qM2KPhVdR34vgtb73tmTU3V6uHIWpietCu9ExsPbh2nCtHv
         lWGqfUS4Jr5qy7zqWx7e5ABStT7iH4ObaBYf4w3fHu46BNiSCXcafmNS0naM1IZkDpdA
         dAf2o1xgHcM4KX1jPWEuftE4cpSNOxg54Fj7U6UPHV3uWgGHBlo1lxOLT/vQlyXsXlCD
         +Dmv3nJCNbuTtWpAxfIjeay8qHXKXYLRtywNpvtgJQERRgC+uQTgvPoU+DLMZp1NKWB3
         SYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695215849; x=1695820649;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4z1ebTU1XlJL0RNvsPG4JRKzQxEhUmSGzIqnEtPiLRQ=;
        b=e3omX4Rz8238nQHCJKJNI598wwNwQUg3IY0B+yJYznJvYYE/Sx/n22XLgIN1uHFkO2
         51+5sKhvyGUYgVUbqyqKraL84ezoNDoeKaM2jTrHqjUe7U7QfG8XjH2BTiIgHiKlRJQ2
         GR8qBLcABol+YhIUd61vLHx2A5aufWAV18GYGDbZ5gM3Qq1n1lUlaOMOGHoeXct1lyL6
         EbykZFCw2jB/uQdAWF/q8OUSM1h8SMOyPjx9qIoFCAZNwIGHarXgckaBZ3P8xAWr/nHD
         1Xl9MINE92Bmpc6YY/FjbORk0e5wbxOOQVj0O28CK+FJ1XMJn4zIBanfcCmAK5ASRx85
         YTdw==
X-Gm-Message-State: AOJu0YwCKqR0WRW/XjbJyQ0BsvHTdtZyFjbjIUHYZWdt9Pg8rNn8Cjhh
        FrZlqJLV/Sb500IIRns0O3Z2cA==
X-Google-Smtp-Source: AGHT+IEmvvIFfHDLufK6B7+1Zm9nQFebxNW9ONYqmXunc/NW7CodSVkSB9tXJZNIb7OE8MRpGCwd0w==
X-Received: by 2002:a17:907:360a:b0:98e:4f1:f987 with SMTP id bk10-20020a170907360a00b0098e04f1f987mr7939528ejc.3.1695215848815;
        Wed, 20 Sep 2023 06:17:28 -0700 (PDT)
Received: from [172.20.24.238] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id g5-20020a170906394500b0099bc038eb2bsm9305870eje.58.2023.09.20.06.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 06:17:28 -0700 (PDT)
Message-ID: <85958d72-a06c-b709-594e-52550f591175@linaro.org>
Date:   Wed, 20 Sep 2023 15:17:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: mediatek,net: add
 phandles for SerDes on MT7988
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, Rob Herring <robh@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <cover.1695058909.git.daniel@makrotopia.org>
 <35c12a115893d324db16ec6983afb5f1951fd4c9.1695058909.git.daniel@makrotopia.org>
 <20230919180909.GA4151534-robh@kernel.org> <ZQoJpGLhNZ0M2JhI@makrotopia.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZQoJpGLhNZ0M2JhI@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2023 22:50, Daniel Golle wrote:
> Hi Rob,
> 
> thank you for the review!
> 
> On Tue, Sep 19, 2023 at 01:09:09PM -0500, Rob Herring wrote:
>> On Mon, Sep 18, 2023 at 11:26:34PM +0100, Daniel Golle wrote:
>>> Add several phandles needed for Ethernet SerDes interfaces on the
>>> MediaTek MT7988 SoC.
>>>
>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>> ---
>>>  .../devicetree/bindings/net/mediatek,net.yaml | 28 +++++++++++++++++++
>>>  1 file changed, 28 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
>>> index e74502a0afe86..78219158b96af 100644
>>> --- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
>>> +++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
>>> @@ -385,6 +385,34 @@ allOf:
>>>            minItems: 2
>>>            maxItems: 2
>>>  
>>> +        mediatek,toprgu:
>>> +          $ref: /schemas/types.yaml#/definitions/phandle
>>> +          description:
>>> +            Phandle to the syscon representing the reset controller.
>>
>> Use the reset binding
> 
> I got an alternative implementation ready which implements an actual
> reset controller (by extending drivers/watchdog/mtk_wdt.c to cover
> also MT7988 and its addition sw-reset-enable bits) and uses single
> phandles for each reset bit assigned to the corresponding units
> instead of listing them all for the ethernet controller (maybe that's
> one step too far though...)
> 
> However, as mentioned in the cover letter, using the Linux reset
> controller API (which having to use is a consequence of having to use
> the reset bindings) doesn't allow to simultanously deassert the
> resets of pextp, usxgmii pcs and/or sgmii pcs which is how the vendor
> implementation is doing it as all reset bits are on the same 32-bit
> register and the Ethernet driver is the only driver needing to access
> that register.

You can have reset for entire register, why not? And even if current
Linux implementation had some troubles with this, you could fix it.


> 
>>
>>> +
>>> +        mediatek,xfi-pll:
>>> +          $ref: /schemas/types.yaml#/definitions/phandle
>>> +          description:
>>> +            Phandle to the syscon node handling the 10GE SerDes clock setup.
>>
>> Use the clock binding
> 
> Does that imply that I should implement a clock driver whith only a
> single clock offering only a single operation ('enable') which would
> then do the magic register writes?

Yes

> 
> While one part is actually identifyable as taking care of enabling a
> clock, I would not know how to meaningfully abstract the other (first)
> part, see vendor driver:
> 
> /* Register to control USXGMII XFI PLL digital */
> #define XFI_PLL_DIG_GLB8        0x08
> #define RG_XFI_PLL_EN           BIT(31)
> 
> /* Register to control USXGMII XFI PLL analog */
> #define XFI_PLL_ANA_GLB8        0x108
> #define RG_XFI_PLL_ANA_SWWA     0x02283248
> 
> [...]
> 
> /* Add software workaround for USXGMII PLL TCL issue */
> regmap_write(ss->pll, XFI_PLL_ANA_GLB8, RG_XFI_PLL_ANA_SWWA);
> // How would you represent the line above using the abstractions of the
> // common clk framework?

What is above line? Please do not ask us to decode your vendor code. You
know, we also have nothing to do with it.

And anyway, why do you need to abstract it? Why not writing unconditionally?


> 
> regmap_read(ss->pll, XFI_PLL_DIG_GLB8, &val); //    that looks like it
> val |= RG_XFI_PLL_EN;                         // <- could be a abstracted
> regmap_write(ss->pll, XFI_PLL_DIG_GLB8, val); //    in a meaningful way in
>                                                     clock driver.
> 
> ... which is all we ever do on that regmap. Ever.

Not only. You will also get all Linux infrastructure associated with
this clock, so proper devlinks, sysfs/debug entries, automatic gating of
unused clocks etc.

Best regards,
Krzysztof

