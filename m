Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B69F782697
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 11:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbjHUJyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 05:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjHUJym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 05:54:42 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48AAA9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 02:54:39 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fee06efd6bso10892515e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 02:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692611678; x=1693216478;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=id9/YhJL+4chNCDVCICHkGrZN4Yz2i9YibVp7IlSmuQ=;
        b=FRwXx//mrplR6x+qZtNHHUetXvmE9LhDHEjisyDi5ub7CHXly3A4aUH0O+kbWj9osy
         /3lChGFRWoBRiqp1wa7CITWMIyOmqCvPtEdITuDmO3s49YWod8RWCEG+o6S7nHSkQVfN
         2vlaJ0aLQwvSKfdeN+i4b2+0DS4yTJt7tswa0N4b07w+5gkmYhuOF0JY9+qNAai30IDn
         h8rKfmqQxDEda0N74LQfZseAnebGnAkfbDKxzSfC7iOV5Uw5s4ZIUmVUa34aZhrIjvsf
         GZe2NdTOEb6TYJT9HauxMoWrOQVRQxXQQihI+q6e0SqP/7SxdMh+Unj/idcRN0Jd8W9Z
         //eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692611678; x=1693216478;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=id9/YhJL+4chNCDVCICHkGrZN4Yz2i9YibVp7IlSmuQ=;
        b=Ge9WERxGtpeKxVL2vfQhKcVvqbPsN6pF3bAMnkuYhPvWarUi9ycSLRygA7mNXrYVwn
         JNIYk8g3OkcUWfXe7wHNtfaiA2/KNoYXTt4DJs5XK5F7rq5cRX08zOQtyb9DbclcQH20
         gS5690nZY1oVRuHPfLXkpmPDu68QJtu7/N1bYXOdl1iTui/zr/tF0rEBWCLUb/moTcne
         Cv07V4jfcBuZw+64LO810vWEyRhMi/XzyzbHxRj3dZU3R74N7YW528LzB+7Luz2CaC52
         Xbc2v/8mDKkjilHEYODNGWweOtfYdU4RFCdvg4rNg/DerbjEihyGrNR21hNCs0pMO9NP
         s1Lw==
X-Gm-Message-State: AOJu0YzLSrSII1btDGFUAwJB1jlTZZMuQeQET9PE5gprX8EPlg43XiB9
        NRoN35EPtvIyzshGifKNxsiMiA==
X-Google-Smtp-Source: AGHT+IGiA86qVNpAZQtYrpPOVNDZsZlC1TCqkKTlS7ELGVi0NlqPR3b7Zu58x4G+n+wQpjpgKHqKcg==
X-Received: by 2002:a05:600c:3646:b0:3fe:d45a:5bfd with SMTP id y6-20020a05600c364600b003fed45a5bfdmr4456692wmq.13.1692611678050;
        Mon, 21 Aug 2023 02:54:38 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.107])
        by smtp.gmail.com with ESMTPSA id t23-20020a7bc3d7000000b003fe1fe56202sm12294108wmj.33.2023.08.21.02.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 02:54:37 -0700 (PDT)
Message-ID: <57e9a9ff-26ed-62d1-91f8-cd5596f1c308@linaro.org>
Date:   Mon, 21 Aug 2023 10:54:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v3 11/50] dt-bindings: crypto: add sam9x7 in Atmel TDES
Content-Language: en-US
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <adeed0b2-e09b-78cf-ebfd-08d3949ca9ea@microchip.com>
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



On 8/21/23 09:41, Nicolas Ferre wrote:
> Hi Tudor, all,
> 
Hi,

> On 19/08/2023 at 16:34, Krzysztof Kozlowski wrote:
>> On 10/08/2023 09:22, Tudor Ambarus wrote:
>>>
>>> On 8/10/23 06:38, Varshini.Rajendran@microchip.com wrote:
>>>>> On 7/28/23 11:24, Varshini Rajendran wrote:
>>>>>> Add DT bindings for atmel TDES.
>>>>> NACK. The atmel crypto drivers check the version at runtime and
>>>>> fill a capabilities structure based on the version identified.
>>>>> There's a single compatible regardless of the version of the IP
>>>>> used until now, why do you want to change it?
>>>>>
>>>> Hi Tudor,
>>>
>>> Hi,
>>>
>>>> I am aware that there is no change in the crypto IP used. This patch is
> 
> Actually, recent history showed us that it's not only the IP itself but
> its integration into final product that could have an influence on the
> behavior.
> 
>>>> to add a SoC specific compatible as expected by writing-bindings
>>>> guideline. Maybe a bit more explanation in the commit description might
>>>> do the trick.
>>>>
>>>
>>> So you add a compatible that will never be used just to comply with
>>> the writing bindings guideline?
>>
>> How do you know that it is never going to be used? The guideline asks

See
https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git/tree/drivers/crypto/atmel-tdes.c?h=at91-dt#n1120

>> for this on purpose, so any future quirks or incompatibilities can be
>> easily addressed.
> 
> In this recent case, having a an adapted compatibility string is an
> added value.
> 
> And yes, I changed my mind and would like to be systematic now with
> at91/microchip DT compatibility strings. Our long history and big legacy
> in arm-soc is sometimes difficult to handle, but we're moving little by
> little to comply with guidelines.
> 
> My conclusion is that Varshini's addition is the way to go.

Ok, fine by me. Then it would be good if one adds compatibles for the
previous SoCs as well and add a comment in the drivers that inform
readers that the atmel_*_get_cap() methods are used as backup where
"atmel,at91sam9g46-" compatibles are used. You'll then have all the
previous SoCs have their own dedicated compatibles which will have
"atmel,at91sam9g46-" compatible as backup, and "sam9x7" will be the
first that will not need the "atmel,at91sam9g46-" backup compatible.
In the drivers you'll have 2 flavors of identifying the IP caps, the
first one that backups to atmel_*_get_cap(), and a second one where
of_device_id data will suffice.

If the commit message described how the driver will handle the new
compatible, Varshini would have spared us of all these emails exchanged.
Varshini, please update the commit message in the next iteration and
describe how the driver will handle the new compatible.

Cheers,
ta
