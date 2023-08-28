Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22A278B797
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjH1Swt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjH1Swg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:52:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84558C5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:52:33 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4bdso154314a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693248752; x=1693853552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=msgoo0EGmKZT8iEDbAnkmxIQCbH4ZJi+yNmYHn/RV8k=;
        b=moL27IuVCTH2AG4+6tuUvP+GeGteJW5VZhN4gXHv5C1Dn/mx1zXOgP1nH65N7Nx1g+
         MaUl0ZgYI6SkiN0EP9UQtHdmbIjUl1rIrLJiPB4g9VO8MDk3M3oH8uQ1ewQZpQ5a9JFD
         zI71vOKS5GyReJz4Xc5DPLOktnjtK5y66GdSwQ3HtCrJEnleo3ZZfGoC/twyPrzJt3YM
         oCtdk5iVqv2/2bLqCLuHy+Zyt+qcTLquGp67KdqV4YrblGSVMyKSRg1NUZIiqNRf3aFH
         6TZeaPRu6lcQ749niSZImXLUjT77k2p6NPvfV5b1A/GwEwiogYV55j4RFi3LzBdEblum
         PcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693248752; x=1693853552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=msgoo0EGmKZT8iEDbAnkmxIQCbH4ZJi+yNmYHn/RV8k=;
        b=BQI0esCqTRkq2p+tQXo8j/QBafwwI7XW3C5vaXIH/2cSGCFHccCP+fsg2IQ1WkKHb/
         UGaScXUcL9gIZAXnU2lFNXvsaudy2IGsVJp5uKoLXRXi5w83lAjxAypCETq7NBplB69w
         aZZouisEeWgQNon6zNOvsbM1gWqRLIbahNlnGp/OntaCoXq5j3O8uTzvHkh/yV7pY+HC
         I0MWB6ML3SkSs6mctiQQvPy1xNtff7JnSkCp1A44Dws0ZIr3WIJZRWhjafSVcsn23+Sl
         p+4udkItKiGjtvEl6WQZ2YrUGHLQtqmHrMz+4Q2b3WzEFyGmMW9tbk9NrZiZwx3h5S0j
         yESg==
X-Gm-Message-State: AOJu0YzVXeFsLjNAr1oQFpxKY1Uq8XV4sjDWAjuXL3e+haRnLwUJJukY
        KenYrb/9+8zqx7UelhCWIEJyAA==
X-Google-Smtp-Source: AGHT+IFJhhHTUDFg9dK6RUh/03jqVt7lmO39ivTXreeW8kAHxJp0tKCaq6azeuowmPdxM526mWbB8w==
X-Received: by 2002:a17:906:300c:b0:9a1:6252:16a0 with SMTP id 12-20020a170906300c00b009a1625216a0mr19361228ejz.46.1693248751894;
        Mon, 28 Aug 2023 11:52:31 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906339300b009932337747esm4932604eja.86.2023.08.28.11.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 11:52:31 -0700 (PDT)
Message-ID: <f3e89479-14ab-d1d0-ad87-6f457f313c39@linaro.org>
Date:   Mon, 28 Aug 2023 20:52:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
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
 <CAPDyKFqsn6kVjPFUdVyRxNDiOaHO9hq=9c+6eAK4N-v-LVWUPw@mail.gmail.com>
 <PAXPR04MB91858254554272C90822FED1891DA@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <CAPDyKFoV2Z=-WUiF3SgXqhF+K+r5QqsLgz8_hau0WKfZxTzYpg@mail.gmail.com>
 <PAXPR04MB9185F6AA20B0440B8FAB847789E3A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <4e2c18e3-b1ed-6361-3998-5de060d2bcf0@linaro.org>
 <PAXPR04MB9185957B729588D3E7CA3A5089E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <51fe3126-16ba-ade6-b106-e3683f96ad26@linaro.org>
 <PAXPR04MB9185DC79721E78E631F9889589E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <154b36de-652b-3931-96e6-04e99253a09f@linaro.org>
 <PAXPR04MB91852AD4E5242306B57A910B89E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PAXPR04MB91852AD4E5242306B57A910B89E0A@PAXPR04MB9185.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 20:50, Shenwei Wang wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Monday, August 28, 2023 1:42 PM
>> To: Shenwei Wang <shenwei.wang@nxp.com>; Ulf Hansson
>> <ulf.hansson@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
>> Liam Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>;
>> imx@lists.linux.dev; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
>> dl-linux-imx <linux-imx@nxp.com>
>> Subject: [EXT] Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
>>>>>>> Are you suggesting to move the regulator-pd to the imx directory
>>>>>>> and add a company prefix to the compatible string?
>>>>>>
>>>>>> There is no such part of iMX processor as such
>>>>>> regulator-power-domain, so I don't recommend that approach. DTS
>>>>>> nodes represent hardware, not your SW layers.
>>>>>>
>>>>>
>>>>> That's not always the case, as we do sometimes need a virtual device.
>>>>> As an example, the "regulator-fixed" acts as a software abstraction
>>>>> layer to create virtual regulator devices by interfacing with the
>>>>> underlying
>>>> GPIO drivers.
>>>>
>>>> Not true. This is a real regulator device. Real hardware on the board.
>>>> You can even see and touch it.
>>>>
>>>
>>> The physical hardware component is the GPIO pin, which is what you can only
>> touch.
>>
>> No. The regulator is the chip.
>>
> 
> In the definition of dts node below, where is the chip? The real hardware is just a GPIO Pin.
>     reg1: regulator-1 {
>     	compatible = "regulator-fixed";
>     	regulator-name = "REG1";
>     	regulator-min-microvolt = <3000000>;
>     	regulator-max-microvolt = <3000000>;
>     	gpio = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
>     	enable-active-high;
>     };

There is a chip. This is the chip. If you have there only GPIO pin, then
your DTS is just wrong. Drop it. If you learn from wrong DTS, then sure,
power-domain-regulator seems like great idea...

> 
>>> The regulator functions virtually through software layer above of the
>>> GPIO driver. While we may call it a "regulator" or whatever else, this
>>> cannot obscure the fact that the underlying hardware is just a GPIO pin being
>> used in a specialized way.
>>
>> The regulator is some tiny little box, you can touch and called
>> ti,tps51632 or similar.
>>
> 
> We are talking about the specific "regulator-fixed" driver, why did you bring up "ti,tps51632" here?

Just an example. Can be TPS123098.

Best regards,
Krzysztof

