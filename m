Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300E281306F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573126AbjLNMnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573090AbjLNMnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:43:08 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA9D11D;
        Thu, 14 Dec 2023 04:43:13 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50bf2d9b3fdso10891313e87.3;
        Thu, 14 Dec 2023 04:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702557792; x=1703162592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DLS5Sl/tcs7UdHUclsP8wzE7HsHwHptKsbrYJkJgZGU=;
        b=GuBkbk8X//vN2MqB3QH9cyd69URtayCAMJI12a8HoECoWdRwrkDVsnAhZ+q/Is84Pr
         bIrt+2dEmsP4wXyOZtRghQO77n7wK2foJsDpEdotyABrYNkPWO4iUvawl/slzmWrvm0q
         6h1fksVXcrhD5U3VJAzTLpDnCtMCfLv+6eQILKWQnA2GhIMjlsrQR43NsTcxEcnYzmJ7
         ketzu+CDgiTuM1rxANdo8HBqnArsvQFTGXOZTcbUwgpsS5Dc1WH5mDGxA6VtDnvSZWvB
         p3tSBD3vv/Ui6zeZHfINakAFjeydfrv+7TtcEqdAKigJK3QY8PLlOjWzKb0V3liaGLJo
         q+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702557792; x=1703162592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLS5Sl/tcs7UdHUclsP8wzE7HsHwHptKsbrYJkJgZGU=;
        b=Uwxo0wK8cIOGJzAeyKbxAH+9irj8ryaxKdpKDaKPYYOEKqn6EVGS58YmAZgK2QgQgI
         wgo909Zue0WQXIZppT5EsVlHJuS7sdNjpbqNA1lfmKL+/HKHfetECA3WmUWFUnCZQcnB
         6xPEM6J1ubnVWCKxCs3gNStwzly/IAOY3Fjfr+epmbUaLEB9MEtxvNTq7gsjysVg4z8/
         RIaOQs1uCXxyyUbbMtdulGpAKWujhDfu/nhhbmtbCtdqQ8E0wEkMRV8VHLzs3q768kSY
         PfuaNTWgO7Pw9xGT7prr9dQdjawbxHsLsJidFXHLkkpB9UeD/H4sEALyVfopXPEAGSLa
         XcKA==
X-Gm-Message-State: AOJu0YzLrFjBrHEE4+yWpdGc3KW9zBjA4tpDwbuxRnft/M3tHd35FdH7
        M5NXY3v0fMSiJCkRbMoYI3Q=
X-Google-Smtp-Source: AGHT+IGua8eR59eAZWjpuEYJuoRA4g6iYT9xAqu1nYyVI+ph0ivN3XaLaaXUVKwY8kqqIGO1CcwTQA==
X-Received: by 2002:a05:6512:238f:b0:50d:1a7f:f76 with SMTP id c15-20020a056512238f00b0050d1a7f0f76mr5708024lfv.65.1702557791782;
        Thu, 14 Dec 2023 04:43:11 -0800 (PST)
Received: from [172.25.98.130] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id vh2-20020a170907d38200b00a1be80a0b69sm9324342ejc.58.2023.12.14.04.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 04:43:11 -0800 (PST)
Message-ID: <e4a9dde7-dca6-4862-bfb3-a93b879c9a1f@gmail.com>
Date:   Thu, 14 Dec 2023 14:43:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] dt-bindings: adc: add AD7173
Content-Language: en-US
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
From:   Ceclan Dumitru <mitrutzceclan@gmail.com>
In-Reply-To: <CAMknhBEfisaSbHhnnei=gT1HZvHNWHrJD3O2y4b_TikkH=v2Ag@mail.gmail.com>
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



On 12/12/23 17:09, David Lechner wrote:
> On Tue, Dec 12, 2023 at 11:45 AM Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:
>>
>> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
>> which can be used in high precision, low noise single channel applications
>> or higher speed multiplexed applications. The Sigma-Delta ADC is intended
>> primarily for measurement of signals close to DC but also delivers
>> outstanding performance with input bandwidths out to ~10kHz.
> 
> As stated in [1], we should try to make complete bindings. I think
> more could be done here to make this more complete. Most notably, the
> gpio-controller binding is missing. Also maybe something is needed to
> describe how the SYNC/ERROR pin is wired up since it can be an input
> or an output with different functions?
> 

GPIO-controller:
  '#gpio-cells':

    const: 2


  gpio-controller: true
Like this, in properties?

Sync can only be an output, Error is configurable. Are there any
examples for how something like this is described?

...

>> +  interrupts:
>> +    maxItems: 1
> 
> Shouldn't this be 2? The datasheet says there is a "Data Output Ready"
> signal on the DOUT/RDY pin and an "Error Output" on the SYNC/ERROR
> pin. Although I could see how RDY could be considered part of the SPI
> bus. In any case, a description explaining what the interrupt is would
> be useful.
> 

I do not see how there could be 2 interrupts. DOUT/RDY is used as an
interrupt when waiting for a conversion to finalize.

Sync and Error are sepparate pins, Sync(if enabled) works only as an
input that resets the modulator and the digital filter.

Error can be configured as input, output or ERROR output (OR between all
internal error sources).

Would this be alright
  interrupts:

    description: Conversion completion interrupt.
		 Pin is shared with SPI DOUT.
    maxItems: 1

...

>> +
>> +patternProperties:
>> +  "^channel@[0-9a-f]$":
>> +    type: object
>> +    $ref: adc.yaml
>> +    unevaluatedProperties: false
>> +
>> +    properties:
>> +      reg:
>> +        minimum: 0
>> +        maximum: 15
>> +
>> +      diff-channels:
>> +        items:
>> +          minimum: 0
>> +          maximum: 31
> 
> Do we need to add overrides to limit the maximums for each compatible string?
> 

Just to be sure, in the allOf section?
If yes, is there any other more elegant method to obtain this behavior?

...

>> +
>> +    required:
>> +      - reg
>> +      - diff-channels
> 
> Individual analog inputs can be used as single-ended or in pairs as
> differential, right? If so, diff-channels should not be required to
> allow for single-ended use.
> 
> And we would need to add something like a single-ended-channel
> property to adc.yaml to allow mapping analog input pins to channels
> similar to how diff-channels works, I think (I don't see anything like
> that there already)?
> 
> So maybe something like:
> 
> oneOf:
>   - required:
>       single-ended-channel
>   - required:
>       diff-channels
> 
All channels must specify 2 analog input sources, there is no input
source wired by default to AVSS.

In my opinion, there is no need to specify channels as single-ended
because that would require a property that specifies the input that is
wired to AVSS.
