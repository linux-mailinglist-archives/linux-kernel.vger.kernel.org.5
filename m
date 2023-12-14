Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C0081372C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443688AbjLNRD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLNRD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:03:26 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064DE9A;
        Thu, 14 Dec 2023 09:03:33 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5527ee1b5c3so1210679a12.1;
        Thu, 14 Dec 2023 09:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702573411; x=1703178211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m+lglxETz+fWuFm30gl8riT+YXHxcre+z450cDyvkZs=;
        b=l25U2BUz7/AJXxKejqiQedLOZM3UNYP6j8fpXIcqavb5EqXTKB/Z1+OV10aqJW/MgA
         kyN/D1YqbPNoIT4QjK8qL9HLY+QeerPPrwRawew9Q5c4RBCJOC3HFmY06IbeqSKTcT7r
         QCZPg5c4Hft/GRUGXuyK/y1tCNwX9oB4jMwBOcbUkUyZGwRSwzdAsUXrtEx2vwLlz9cd
         zYwHnfF0fJttJx1cVpNIpPviC1zmLuBI8eGWwT1a5GezhFnCzZigcL3id9orf8jWuDUT
         lHhnfc4f3OTorjfypNRORTyGMqJgQV8+/UjHeusUlQ7rBU27ifC9Sl23XBXv1fFHnZ8s
         cz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702573411; x=1703178211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m+lglxETz+fWuFm30gl8riT+YXHxcre+z450cDyvkZs=;
        b=LpPEbv6BqM9LS03fOKyHScgnGL6uDQbk2qGJqG/kJ1qpdNmTSx5v/sxBl35CP1GDVL
         Dwl8zrkYZEJbnvg0Jsvi4DMOEzR50QOKDIIHTMmu2GhI0lGtwFJ50FeVjzP1m7zol88t
         pHQSR/qj97CTrCJSPpur3qVrZUn/z2hwqI4VoxaG+aSuapphhauzxPBrbmTC5GdJhsRD
         phRN+MHVyc64u1ENzb/GaJv0IMkuX+cDau8EJgkUXALiDRdO5JqI7RYqfW0uJ/3+3gR0
         G0166Lbsu+gdN8b8EuzVAfMuumUVfkhB+EF1BqkXTADfblccN0mTxIKKJDi7umps+4jg
         ATpw==
X-Gm-Message-State: AOJu0Yx/lhCv8AtUUhFep57nxo372timslSpC2YPyde6ZjbQ+RSxOjs6
        Q5Q9PQ4RWUPkG9QZy1niIZk=
X-Google-Smtp-Source: AGHT+IEiyYYre0/uJwpHGfY4Q6A9LX0eNGn78B8SJTWcCnWQnDgsz8GyuwoMo0Rm/VlgLpP6o4qBKA==
X-Received: by 2002:a17:906:48d:b0:9a5:dc2b:6a5 with SMTP id f13-20020a170906048d00b009a5dc2b06a5mr11055203eja.35.1702573411184;
        Thu, 14 Dec 2023 09:03:31 -0800 (PST)
Received: from [172.25.98.130] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id mm20-20020a1709077a9400b00a1a53e9f401sm9666879ejc.132.2023.12.14.09.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 09:03:30 -0800 (PST)
Message-ID: <a1f60bf6-5fb6-4814-b3b5-799fb8ffb847@gmail.com>
Date:   Thu, 14 Dec 2023 19:03:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] dt-bindings: adc: add AD7173
To:     David Lechner <dlechner@baylibre.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231212104451.22522-1-mitrutzceclan@gmail.com>
 <CAMknhBEfisaSbHhnnei=gT1HZvHNWHrJD3O2y4b_TikkH=v2Ag@mail.gmail.com>
 <e4a9dde7-dca6-4862-bfb3-a93b879c9a1f@gmail.com>
 <CAMknhBFQ56SwMvOni6UDqvaq8t0iydHcggiL0biUeLQ6OV1ONA@mail.gmail.com>
Content-Language: en-US
From:   Ceclan Dumitru <mitrutzceclan@gmail.com>
In-Reply-To: <CAMknhBFQ56SwMvOni6UDqvaq8t0iydHcggiL0biUeLQ6OV1ONA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/23 18:12, David Lechner wrote:
> On Thu, Dec 14, 2023 at 1:43 PM Ceclan Dumitru <mitrutzceclan@gmail.com> wrote:
>> On 12/12/23 17:09, David Lechner wrote:
>>> On Tue, Dec 12, 2023 at 11:45 AM Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:

>> ...
>>
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>
>>> Shouldn't this be 2? The datasheet says there is a "Data Output Ready"
>>> signal on the DOUT/RDY pin and an "Error Output" on the SYNC/ERROR
>>> pin. Although I could see how RDY could be considered part of the SPI
>>> bus. In any case, a description explaining what the interrupt is would
>>> be useful.
>>>
>>
>> I do not see how there could be 2 interrupts. DOUT/RDY is used as an
>> interrupt when waiting for a conversion to finalize.
>>
>> Sync and Error are sepparate pins, Sync(if enabled) works only as an
>> input that resets the modulator and the digital filter.
> 
> I only looked at the AD7172-2 datasheet and pin 15 is labeled
> SYNC/ERROR. Maybe they are separate pins on other chips?

Yep, sorry, missed that. All other supported models have them separate.

> 
>>
>> Error can be configured as input, output or ERROR output (OR between all
>> internal error sources).
>>
>> Would this be alright
>>   interrupts:
>>
>>     description: Conversion completion interrupt.
>>                  Pin is shared with SPI DOUT.
>>     maxItems: 1
> 
> Since ERROR is an output, I would expect it to be an interrupt. The
> RDY output, on the other hand, would be wired to a SPI controller with
> the SPI_READY feature (I use the Linux flag name here because I'm not
> aware of a corresponding devicetree flag). So I don't think the RDY
> signal would be an interrupt.
> 

Error does not have the purpose to be an interrupt. The only interrupt
used from this chip is the one from the DOUT/~RDY pin. Sure, it is wired
to the SPI controller, but when you can't also receive interrupts on
that very same CPU pin an issue arises. So that pin is also wired to
another GPIO with interrupt support.

This is the same way that ad4130.yaml is written for example (with the
exception that ad4130 supports configuring where the interrupt is routed).

In regards to SPI_READY _BITUL(7) /* slave pulls low to pause */: the
ad_sigma_delta framework (if it can be called that) is written to expect
a pin interrupt, not to use SPI_READY controller feature.

