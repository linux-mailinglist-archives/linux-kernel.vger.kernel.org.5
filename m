Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CF47829B6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbjHUNAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjHUNAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:00:22 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71807E1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:00:19 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4ffae5bdc9aso2770732e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692622818; x=1693227618;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AXD55IpQ28QwNaboUgeu7XR1+/pauVVuQAUGdvfKMhg=;
        b=SIOAOocUezetqG5twCI7hF/qncTfZLbIPZOiWX6cYFlDV0eNdQ/mJzhcXEa8tJIzC6
         7oRqNRltLeU1JumuerXcdysf+jNVVDPADr0lTYtdnb334jaDRn6iH0L0Ghe+52vb9eFY
         N2II1e8D3lt+3LLBR0hhH+aZR6HSkc7fxVlWVGkPj67B6hGvrkQvjm1os5OYZgCuPj0y
         G4iLJ/R9UmQlA16kZSllKAmT0CfRArGUOXvrrsCFCmoKsSOXie7nyPoDfeLfUWBlRF0f
         CIqzoyEOJV8b530GcgP1hv9LOYTug7GwHyc4QXm69kXKPplYJ5R32IdKE9sMNFbryMEB
         oRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692622818; x=1693227618;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AXD55IpQ28QwNaboUgeu7XR1+/pauVVuQAUGdvfKMhg=;
        b=YuuY5hArkA8Vw6EMNpD2qSAtgoUk/uwWlMN/p/G790Mz0T8TiRASbOBpUAp2ePkhDp
         8s/fY5kEgqOb8ryiwhUgro+fX5Eeu5t2rWod6da4T5ksYjrLWlk6pyt0vZ8yR0hyDCOQ
         zalzqeLouDVrl2qsQWIRHpMCgdybUUX1V6/67k/s8WEvMC3iQDRrzHAdS3SNX/SQd+rF
         pzEXoZo7t8f4rbBIVFmyWeJK/WfrqKJpUpV/u/v3jrvsaTRFPfSWfhQ5lNvZMMObhSX4
         a550ZDUgWAgRpYXllxKYMysmAROnceIWOJ7kUJteCDgDpgSYB1HBOQiv/JdSrwGlnnI0
         W8bQ==
X-Gm-Message-State: AOJu0YwE4UTG+7IrY1O/kDt/d31Ue5d5phufe4iwnBN5yozsp5HJnExN
        R8EpBouF6STcSGvUyzzqCwVcXw==
X-Google-Smtp-Source: AGHT+IEso7aKT7I1eVkoH1fesBsxFN+42Ir0Pvzb2Q+oH9fL/5fQI8T3LD4xRCNGC7DIcrEbuBwr3w==
X-Received: by 2002:a05:6512:3d8a:b0:4ff:793f:fbf8 with SMTP id k10-20020a0565123d8a00b004ff793ffbf8mr5838272lfv.51.1692622817567;
        Mon, 21 Aug 2023 06:00:17 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.107])
        by smtp.gmail.com with ESMTPSA id b7-20020a170906d10700b00992d122af63sm6495471ejz.89.2023.08.21.06.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 06:00:15 -0700 (PDT)
Message-ID: <697712da-bff9-4621-28ac-9c9f68a76e43@linaro.org>
Date:   Mon, 21 Aug 2023 14:00:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v3 11/50] dt-bindings: crypto: add sam9x7 in Atmel TDES
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Varshini.Rajendran@microchip.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230728102442.265820-1-varshini.rajendran@microchip.com>
 <09bd1388-02aa-32c7-319e-d7150a0f3e9c@linaro.org>
 <1ec901d0-44c2-1d28-5976-d93abfffee67@microchip.com>
 <37782447-43c7-50f9-b9b4-5fbca94ce8c6@linaro.org>
 <96033a59-a2ea-c906-a033-84119c5783d7@linaro.org>
 <adeed0b2-e09b-78cf-ebfd-08d3949ca9ea@microchip.com>
 <57e9a9ff-26ed-62d1-91f8-cd5596f1c308@linaro.org>
 <5235260c-8fd6-2b2a-58b9-703191fff526@linaro.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <5235260c-8fd6-2b2a-58b9-703191fff526@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/23 13:10, Krzysztof Kozlowski wrote:
> On 21/08/2023 11:54, Tudor Ambarus wrote:
>>>>>> I am aware that there is no change in the crypto IP used. This patch is
>>>
>>> Actually, recent history showed us that it's not only the IP itself but
>>> its integration into final product that could have an influence on the
>>> behavior.
>>>
>>>>>> to add a SoC specific compatible as expected by writing-bindings
>>>>>> guideline. Maybe a bit more explanation in the commit description might
>>>>>> do the trick.
>>>>>>
>>>>>
>>>>> So you add a compatible that will never be used just to comply with
>>>>> the writing bindings guideline?
>>>>
>>>> How do you know that it is never going to be used? The guideline asks
>>
>> See
>> https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git/tree/drivers/crypto/atmel-tdes.c?h=at91-dt#n1120
> 
> What's there? One compatible? How does it prove that it will not be
> used? It only proves that currently it is not used... And anyway this is

Correct, as of now the compatible was not used to determine the hw caps,
the capabilities were retrieved by checking at runtime a version
register. I'm against adding a compatible that will not be used, in this
particular case, defining "microchip,sam9x7-tdes" in the driver but
still solely relying on the runtime version register interrogation.
Unfortunately the commit message does not reveal any intention and from
there these emails changed. Maybe it's just a matter of personal
preference, so I'll stop commenting on this.

> just one implementation in one system. How can you possibly know all
> other possible implementations (other bootloaders/firmwares/systems)?
> One cannot. The guideline is there for specific reason.
> 

I didn't say the guideline is wrong, I just tried to understand how this
particular case is handled.
> 
> 
>>
>>>> for this on purpose, so any future quirks or incompatibilities can be
>>>> easily addressed.
>>>
>>> In this recent case, having a an adapted compatibility string is an
>>> added value.
>>>
>>> And yes, I changed my mind and would like to be systematic now with
>>> at91/microchip DT compatibility strings. Our long history and big legacy
>>> in arm-soc is sometimes difficult to handle, but we're moving little by
>>> little to comply with guidelines.
>>>
>>> My conclusion is that Varshini's addition is the way to go.
>>
>> Ok, fine by me. Then it would be good if one adds compatibles for the
>> previous SoCs as well and add a comment in the drivers that inform
>> readers that the atmel_*_get_cap() methods are used as backup where
>> "atmel,at91sam9g46-" compatibles are used. You'll then have all the
>> previous SoCs have their own dedicated compatibles which will have
>> "atmel,at91sam9g46-" compatible as backup, and "sam9x7" will be the
>> first that will not need the "atmel,at91sam9g46-" backup compatible.
>> In the drivers you'll have 2 flavors of identifying the IP caps, the
>> first one that backups to atmel_*_get_cap(), and a second one where
>> of_device_id data will suffice.
>>
>> If the commit message described how the driver will handle the new
>> compatible, Varshini would have spared us of all these emails exchanged.
> 
> The driver does not have to handle the new compatible, because it is
> independent question. Although if you meant to explicitly say that

As you wish. I retrieve my NACK.

Cheers,
ta
> device is compatible in commit msg, although it is obvious from the
> patch, then sure.
> 
>> Varshini, please update the commit message in the next iteration and
>> describe how the driver will handle the new compatible.
> 
> Best regards,
> Krzysztof
> 
