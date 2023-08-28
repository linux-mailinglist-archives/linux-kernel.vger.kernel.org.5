Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B883B78AD1A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjH1Kpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjH1Kpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:45:44 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDBDE49
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:45:24 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99c1d03e124so399851366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693219522; x=1693824322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7OanaXXnrMsaEfBjCXrcfdtKi7g9UEMwaAf60pZJsSc=;
        b=C1oa92btKyiq9BivM1fEjwLmi66V9PA7yJw4LUzkelTctM0ppXJ//6PCvBudrgPQCi
         nEis/LIE3gfdzxcrDS8lyKyjEPmxAyLdoVQW/z79vVwyZOlcbX0JxAxePNCGQRxl8TvP
         YaUF8nWONY/lPa/awNeyRtbr64JYs45xfZaQYjTcXKx0pLWS07q+sZkiK3TtfaF5e5c6
         Rp1Tgl/Vkwo1lXaUSL37MZu6AyX9p2R5TN8S1Ow4OLVaw/fSoPRQ2guC7OF7QRJD17rb
         jEo6fFDE0Uf52p1ZgJEckdYTJgfmz+1FvVZpC1gSRzJEPyex18gFdedoKdRTWn88Lv8r
         +bZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693219522; x=1693824322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OanaXXnrMsaEfBjCXrcfdtKi7g9UEMwaAf60pZJsSc=;
        b=SqvCsCsWNnEksAenKNLl9l0/WCyr9zGPS+uwYUA4Nmk6DBMgSqDZavJXxWimelKwaa
         m3uxKCxYkMT2nUmRpGq9ZoStlizP2qIH26t7LCrt8tEzyULrVIs21m4sn8qrAQU94AG5
         +1oqVjs8spNBFOFitFszTs0zW7TIqo0Cym0pbT6Bo/ovzRvOpVfzj837PwKwrbVtf9FI
         sOaG8G2ij94fcRDKdHODbTcYyT8X9ZNa0b/bnKf5c2AUY1GqxJ4YAr+Y0Ni9Br3LlC8G
         UorlsA/rWmqO3kUUB60BqyV5VzFSW9qok9eoGTVsu9+HwHAwSQXHZmNT9TTaUR3WCT0h
         huQQ==
X-Gm-Message-State: AOJu0YxYFb3p9iZKfLAvfxuIKS/j/JfEx7FEIfR0BJMA/5P8X0YRp8Uu
        tJkZQsUxWqg1wQxW3cLm5koWjw==
X-Google-Smtp-Source: AGHT+IHTA017TesrZlA/sySPLP1brYSSYzfcBNjrMk0jhiVJiNfeXLqU0j3wzbMWlEZaqDpfvcftoQ==
X-Received: by 2002:a17:906:7392:b0:9a1:d087:e0bd with SMTP id f18-20020a170906739200b009a1d087e0bdmr11535283ejl.6.1693219522129;
        Mon, 28 Aug 2023 03:45:22 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id cf20-20020a170906b2d400b0098e78ff1a87sm4500818ejb.120.2023.08.28.03.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 03:45:21 -0700 (PDT)
Message-ID: <8f9f24c7-c93f-4cb8-bbd2-f0a8502d5f1b@linaro.org>
Date:   Mon, 28 Aug 2023 12:45:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] dt-bindings: power: Add regulator-pd yaml file
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Shenwei Wang <shenwei.wang@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
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
 <CAPDyKFro6roynXuS1caARpMK08hvARQ7mQfiJcDgCyJXiw=nzw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPDyKFro6roynXuS1caARpMK08hvARQ7mQfiJcDgCyJXiw=nzw@mail.gmail.com>
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

On 28/08/2023 11:59, Ulf Hansson wrote:
> On Sat, 26 Aug 2023 at 19:31, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 25/08/2023 17:44, Shenwei Wang wrote:
>>>>
>>>> The genpd provider then needs to be a consumer of the resources it needs. In
>>>> this case a couple of regulators it seems like.
>>>>
>>>
>>> If I understood your reply correctly,  it seems that the current implementation of
>>> regulator-pd is what you have described. Please correct me if I'm mistaken.
>>>
>>> The following are the diff of scu-pd and this regulator-pd.
>>>
>>>     power-controller {                                                    power-controller {
>>>         compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";      |               compatible = "regulator-power-domain";
>>>         #power-domain-cells = <1>;                                    #power-domain-cells = <1>;
>>>                                                             >
>>>                                                             >         regulator-number = <2>;
>>>                                                             >         regulator-0-supply = <&reg1>;
>>>                                                             >         regulator-1-supply = <&reg2>;
>>>     };                                                                    };
>>>
>>> Are you suggesting to move the regulator-pd to the imx directory and add a company prefix
>>> to the compatible string?
>>
>> There is no such part of iMX processor as such regulator-power-domain,
>> so I don't recommend that approach. DTS nodes represent hardware, not
>> your SW layers.
> 
> I would agree if this was pure SW layers, but I don't think it is. At
> least, if I have understood the earlier discussions correctly [1],
> there are certainly one or more power-domains here. The power-domains
> just happen to be powered through something that can be modelled as a
> regular regulator(s). No?

No. It was for controlling power of multiple devices, supplied by
multiple different or similar regulators, where Linux drivers for these
devices (so not even all drivers...) do not have regulator control. The
bindings for these devices allow power-domains, but not regulator.

There are no multiple power domains in the problem. Even term "power
domain" is questionable here, because we tend to look power domain as
part of SoC. Here it is some selected part of the circuitry, like few
totally independent devices which share purpose and power rails.

But more important is my first paragraph - this is purely to avoid
adding regulators to these devices.

Best regards,
Krzysztof

