Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EA37D0E3A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377038AbjJTLOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376994AbjJTLOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:14:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A9FCA
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:14:33 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-98377c5d53eso108619066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697800472; x=1698405272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qGsAA3n4bcgGN3etGa/Qvpv0Fnu8UXB8L4QIbODAi7Y=;
        b=RcKoMa2FF59QKP8R0R1gr8nHBdvM2DfLO8l3ASpluUjPtH4s+aj8U9BJqEbJEWsRUh
         q2y9FPQEd6NSr/9jjcVADBbk4A59TyCaNLAWIK7lcDMoHQVqmGujEOOTgICfgwy2j6bh
         knr1mll6zJa4CEgoe2ovaKAYJPgE3P9ukvH27djEnbsx0TvGrXy5RMsgTtiXRseBSN5x
         FaegQTLQVMc8YYIrLKVWvuukMQmxPj0AMylo/2TNwBsL6PWV0Z1UXxAPsaD0Av6PMnY4
         uPU6cdeE1yRQwtqULL0bXKAhmknDDoay6h7gpLF5Md2dkAmz1/uQ50T9xXWlblheVyHc
         CzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697800472; x=1698405272;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGsAA3n4bcgGN3etGa/Qvpv0Fnu8UXB8L4QIbODAi7Y=;
        b=MYC8kztGiTpizS+loOui8NzbYigwpDRv8fk6RVi1Ms4CDbzuxY8bx1EWbSNUsI8xG0
         qfxW4pR0INsdjICs3dUZgGJ2LBAj7fJv0Q2wbiW9iiPSNfqNriQecxEWh/f04/cHV1Uk
         Hxo+IY55mi/+llkrXN6PTRkHlkF11l3s6I95vBKeMayKxV0tT51I709SVgBfY7yp4EMQ
         WuGKukav9JOLZnN6MsqVffVi1uOQemekfeI8ZikNabv1xRHuveKx26oTlfhja0ugm1j0
         kM0BQJ1FxG/2RIEaqk3Vcpt7Bbw+vH/stBobwwbHPEWgUI6HdKLeU2ZS+ofDNySRc8pi
         wh/w==
X-Gm-Message-State: AOJu0Yyi9Lyok8heLR7ALZgc9XLHTldgE9Zwg+o4LdxtpWTBYD6eyinF
        +Z6I0Kxk/M8xMte93yfh+OZV7Q==
X-Google-Smtp-Source: AGHT+IF/ttqE0K6OGs6Ny/RdJ1s78fppeWFqZulXJro8SoHTWRW2rogRKIpafCmDhsEAaOWO8Qd64w==
X-Received: by 2002:a17:907:3f93:b0:9ae:673a:88c8 with SMTP id hr19-20020a1709073f9300b009ae673a88c8mr1219746ejc.21.1697800471603;
        Fri, 20 Oct 2023 04:14:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id j14-20020a1709064b4e00b009ad778a68c5sm1298142ejv.60.2023.10.20.04.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 04:14:31 -0700 (PDT)
Message-ID: <8ce3e155-8787-4a2f-b58e-237afa73fa55@linaro.org>
Date:   Fri, 20 Oct 2023 13:14:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dt-bindings: media: imx-jpeg: Assign slot for imx
 jpeg encoder/decoder
Content-Language: en-US
To:     ming qian <ming.qian@oss.nxp.com>, mirela.rabulea@oss.nxp.com,
        robh+dt@kernel.org, shawnguo@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        ming.qian@nxp.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1697597713.git.ming.qian@nxp.com>
 <c7995af1f91733626ff4e86f0575dea5d2ff0bb8.1697597713.git.ming.qian@nxp.com>
 <d640f5c2-8af5-4402-a981-0e962d4f2aca@linaro.org>
 <c2eb3a37-eadb-4ec6-a6c1-075d71127ac2@oss.nxp.com>
 <46f5f4ce-5033-44f1-bd4b-aef87535e4e3@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <46f5f4ce-5033-44f1-bd4b-aef87535e4e3@oss.nxp.com>
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

On 20/10/2023 07:38, ming qian wrote:
> Hi Krzysztof,
> 
>>
>>>> From: Ming Qian <ming.qian@nxp.com>
>>>>
>>>> This IP includes a jpeg wrapper and a jpeg engine, the wrapper is
>>>> working on descriptor based manner. It supports up to 4 slots, each slot
>>>> can have its own chained descriptors. Host won't configure the engine
>>>> directly, but fill some descriptors to encode or decode one jpeg
>>>> picture. Then configure the descriptors to certain slot register. The
>>>> jpeg wrapper will schedule between different slots. When some slot is
>>>> finished, the slot interrupt will be triggered. The purpose of slot is
>>>> that engine can be shared across multiple VMS and os.
>>>>
>>>> Currently, power domains and interrupts are enabled for all 4 slots, but
>>>> only one slot is used. There is no benefit in using more that one slot
>>>> from within the same OS, as the slots are scheduled in round-robin
>>>> manner and not executed in parallel.
>>>>
>>>> Use the property "nxp,slot" to assign a single slot, and just expose the
>>>> parts of the h/w for the assigned slot. For example, only put slot 1's
>>>> power-domains entry in the DT when slot 1 is assigned. If not specified,
>>>> 0 is used by default.
>>>>
>>>> Signed-off-by: Ming Qian <ming.qian@nxp.com>
>>>> ---
>>>> v5
>>>> - improve commit message
>>>> - improve property description
>>>>
>>>> v4
>>>> - improve commit message
>>>> - drop line making the property required, to avoid ABI break
>>>>
>>>> v3
>>>> - add vender prefix, change property slot to nxp,slot
>>>> - add type for property slot
>>>>
>>>> v2
>>>> - add a new property in bindings document
>>>>
>>>>   .../bindings/media/nxp,imx8-jpeg.yaml         | 46 +++++++++----------
>>>>   1 file changed, 22 insertions(+), 24 deletions(-)
>>>>
>>>> diff --git 
>>>> a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml 
>>>> b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
>>>> index 3d9d1db37040..0961856bdcab 100644
>>>> --- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
>>>> +++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
>>>> @@ -32,19 +32,27 @@ properties:
>>>>       maxItems: 1
>>>>     interrupts:
>>>> -    description: |
>>>> -      There are 4 slots available in the IP, which the driver may use
>>>> -      If a certain slot is used, it should have an associated interrupt
>>>> -      The interrupt with index i is assumed to be for slot i
>>>> -    minItems: 1               # At least one slot is needed by the 
>>>> driver
>>>> -    maxItems: 4               # The IP has 4 slots available for use
>>>> +    description:
>>>> +      Interrupt number for slot
>>>> +    maxItems: 1
>>>
>>> The device still has four interrupts, so we should allow up to four of
>>> them. One given OS might want to use two or all four slots.
>>>
>>>
>> Got it, I will fix it in v6 patch.
>>
> 
> We made an internal discussion about this, current approach of the

How does it help me? Why private discussion should matter to us?

> bindings implies that one dts node is for one slot only, and the slot
> property is integer, not a list of slots. Whoever wants to use 2 or more
> slots, should put more nodes in the dts, one for each slot. Therefor,

Really? Under the same IO address? Please show how it works and then run
`dtbs_check W=1`..

> there is no point in allowing more than one interrupt in one node. Or,
> if we do, for the sake of allowing one OS to use more slots within the
> same dts node, we must also allow more power domains, in any case, we do

power-domains, interrupts, everything.

> not have multiple slots functionality in the driver anymore.

Why your driver should limit bindings? My driver supports multiple slots...

Best regards,
Krzysztof

