Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F7578B869
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjH1Tbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjH1TbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:31:11 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D641F185
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:30:48 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52a1ce52ef4so4531140a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693251047; x=1693855847;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7FF3uWcCF/fBgcKyKYxNsxhAz0t2E3t1fA13G/6hVqE=;
        b=WEEl2jADfaEkZMnwQHrnA1kfCneRgIh7ji/YjnBUeF0qSyiwTFRa19bkGzczgTWQPu
         YAI+ASpbvsAVvg9AF3d4lXje4x8ZTlqkqr8yGmz01jFYVdqYUvdCDAJBSphkK3F8sVsr
         4oI1cy7A6KefK+HFJ92pGJroNIlakD2oKPyTDZQ86VGmJGQbv73EIiuMTrLP7tuqpjoR
         zyaHDvMAjfVLbA8m0Jf65GftzmQa/kvaOXGKmcIJ2AJSRXUN77U08wuBdauzgr6uENt/
         0os0OO4SHMceKiPHCaujMPJbZFGrN3vmp+8buPKqqQgOcXK7gDotT8KdN9esZbaumi3J
         8F9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693251047; x=1693855847;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7FF3uWcCF/fBgcKyKYxNsxhAz0t2E3t1fA13G/6hVqE=;
        b=O7ffNVZPJGXdf47snME8k0Za3NJK0gQIB6Ju4F5lbyzzhLmmEnJ95YMl83mJwgdmqI
         lclhBVMpJSlRe9+lrYuc6ZeaMI30osnYfZ/WVx5z4kjbZaIfA2dZJYuT+Thh4ncJj/Ml
         o00WGyFemrZcO10EbeLuoZ+hczC3Angad3LVu/Md7voX3kB/qttL8BBNCcLYXovaE30R
         t5XItBgT1Ja97bKZja+293kkLOY9YkGeS3ub79G44wsb56CIn2WveeMR64zEeVTM94rq
         FlmDlIlEOueF7nE8B/IIUWKZiolSXSsmQY6DUZIpbdN4pCCilY3T1chD8M9FT1eiFRoM
         m+9A==
X-Gm-Message-State: AOJu0YxgnGGjyjArPR88Jzd42fWpSQXnNcR+5SDr02CiFMT19soMXP7L
        9rMr3bP2BKauIZA6BURILVgcRg==
X-Google-Smtp-Source: AGHT+IEKG5tzShBpR2V6RQtN9mM20TxelL4ewWN+rJjWEoIaBql1h7z0FvNmPsb79dAbg0aOhovkIQ==
X-Received: by 2002:a17:907:778d:b0:9a1:d7cd:603a with SMTP id ky13-20020a170907778d00b009a1d7cd603amr12300358ejc.58.1693251047351;
        Mon, 28 Aug 2023 12:30:47 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id h7-20020a170906718700b0099bcf1c07c6sm5036313ejk.138.2023.08.28.12.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 12:30:46 -0700 (PDT)
Message-ID: <2bd01950-20e0-51f1-91d2-88c9ee2e8dc0@linaro.org>
Date:   Mon, 28 Aug 2023 21:30:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [EXT] Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml
 file
Content-Language: en-US
To:     Shenwei Wang <shenwei.wang@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <20230818153446.1076027-1-shenwei.wang@nxp.com>
 <PAXPR04MB91858254554272C90822FED1891DA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <CAPDyKFoV2Z=-WUiF3SgXqhF+K+r5QqsLgz8_hau0WKfZxTzYpg@mail.gmail.com>
 <PAXPR04MB9185F6AA20B0440B8FAB847789E3A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <4e2c18e3-b1ed-6361-3998-5de060d2bcf0@linaro.org>
 <PAXPR04MB9185957B729588D3E7CA3A5089E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <51fe3126-16ba-ade6-b106-e3683f96ad26@linaro.org>
 <PAXPR04MB9185DC79721E78E631F9889589E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <154b36de-652b-3931-96e6-04e99253a09f@linaro.org>
 <PAXPR04MB91852AD4E5242306B57A910B89E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <f3e89479-14ab-d1d0-ad87-6f457f313c39@linaro.org>
 <PAXPR04MB9185D87525AA88A8C3543EEA89E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <465e61a0-895d-54b9-d1b9-424265c82855@linaro.org>
 <PAXPR04MB91851302EAB989EC8261AEFD89E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PAXPR04MB91851302EAB989EC8261AEFD89E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 21:23, Shenwei Wang wrote:
>>>>>     reg1: regulator-1 {
>>>>>       compatible = "regulator-fixed";
>>>>>       regulator-name = "REG1";
>>>>>       regulator-min-microvolt = <3000000>;
>>>>>       regulator-max-microvolt = <3000000>;
>>>>>       gpio = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
>>>>>       enable-active-high;
>>>>>     };
>>>>
>>>> There is a chip. This is the chip. If you have there only GPIO pin,
>>>> then your DTS is just wrong. Drop it. If you learn from wrong DTS,
>>>> then sure, power-domain- regulator seems like great idea...
>>>>
>>>
>>> When you talk about the chip, can you please be more specific?
>>
>> What to say more? The device node you quoted above is the regulator. You
>> brought specific example and now claim this is not a regulator, but just GPIO.
>> Please fix your DTS.
>>
> 
> The fixed-regulator is a virtual regulator driver that uses the GPIO pin. 

We do not talk about drivers but bindings and DTS. Why do you bring
again drivers, all the time?

> You claimed this
> as a hardware chip.

??? Sorry, this is getting boring. The DTS-snippet is a hardware chip.
If it is not, then drop it from your DTS. I insist. Srsly, third time I
insist.


> 
> The regulator-pd driver also uses the same GPIO pin. 

Again, what is with the drivers? Can you stop bringing it to the discussion?

> You now claimed this as a software layer.

???

> 
> What's your standard?

I don't think there is anything more to say. You clearly do not
understand what is DTS, schematics and how the actual hardware looks like.

I am not going to respond more to this patchset (which is a clear NAK
just in case).

Best regards,
Krzysztof

