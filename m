Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4687752EA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjHIGdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjHIGdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:33:14 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B1A10DC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 23:33:13 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe5c0e57d2so23690805e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 23:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691562792; x=1692167592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cfnpEIEDyi/TCsipFM/QmhqQBbx+uk+HPM/v/YS7T88=;
        b=NcTsez+m7D5lIPteEJnBGPXksQ+Xa69Z0EeFej10ob3Rx7TSTL/+92lEoA5VYQ1ZkR
         Ycgd4RoO2hSf4k+DU5e1sbSjd11P0v1ZAePhCTAjzSbjDtLVy0XUyyXNScBDcvPxD5UA
         vS3jpNRfqNxnpiVHAoos2u123/eyvAuVHP/t5E946iOUHszwfH1Q0jtghl3aMxMWjuoa
         7E9toOBHl2bvCQMmJZaVsCeV15c3VkpkNW6whMQgA0MhPENXCmKdyb6RfdlYmQ7OfcMA
         UtT3vEd3mrCtYyWsuc2Yd4KStandA2CIcoscxXDZgTKIjAXXoN2CJMOIdcj/7tsie+fl
         3Iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691562792; x=1692167592;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfnpEIEDyi/TCsipFM/QmhqQBbx+uk+HPM/v/YS7T88=;
        b=SDm+hY/vE6xeN0jK9V1w1AyV/b+MEkMDzVcAdk07Jl5/xNt7RzQkOGRu1yMIrpn39Z
         INpgix5MpmElUQNti9Jlk3vY8n7vm3/qAiLFaTDDlXovVK9XNfDznww/u6SeMZje2SGG
         RHqQBHCfDIHjR1Ucwh2UvxurtEmANMkM6mPCbe59emZonLayVGPTy/qFClDvNw9ZCnih
         d4YuQMNQecscTJ7A6SKdiLm5xZ9YkN3Xd7qXe4MYzxenFlrFfjvqI2u1vQCCAeDcmoTp
         t7S4m6qxVBTyOeIOSqlNA7kVyiSFvkMNptjzOBd0CJvzp1bXXYim/szhmZ9lGcjmg85h
         4s0g==
X-Gm-Message-State: AOJu0Yy+QBfsNLEhI7wAwY74SF8+o5iteNfslwxUDaeaykUYLqgxSgyc
        9wymOw4JWFoCFlaUt/SNgsOc3A==
X-Google-Smtp-Source: AGHT+IH+d3WmUb7ILr+M11EJlBVVeYtF/bjjpHcQlJAkEG1LP74eG+zgdbAQJoYgT+SRAG/CBLiUdg==
X-Received: by 2002:a05:600c:ca:b0:3fb:b05d:f27c with SMTP id u10-20020a05600c00ca00b003fbb05df27cmr1319420wmm.34.1691562791763;
        Tue, 08 Aug 2023 23:33:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id g8-20020a7bc4c8000000b003fe505319ffsm917652wmk.18.2023.08.08.23.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 23:33:11 -0700 (PDT)
Message-ID: <3bbd635f-85a6-9031-3264-e5209f8bc44f@linaro.org>
Date:   Wed, 9 Aug 2023 08:33:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] arm64: dts: imx8m-venice: Pass "brcm,bcm4329-fmac"
Content-Language: en-US
To:     Tim Harvey <tharvey@gateworks.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <festevam@denx.de>
References: <20230806233333.815702-1-festevam@gmail.com>
 <CAJ+vNU0cDTGHoqJMDdwea48RSaETyvsg2NXCcEE3FBNr4-ckvg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJ+vNU0cDTGHoqJMDdwea48RSaETyvsg2NXCcEE3FBNr4-ckvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 01:52, Tim Harvey wrote:
> On Sun, Aug 6, 2023 at 4:33 PM Fabio Estevam <festevam@gmail.com> wrote:
>>
>> From: Fabio Estevam <festevam@denx.de>
>>
>> Pass "brcm,bcm4329-fmac" to fix the following schema warnings:
>>
>> imx8mp-venice-gw74xx.dtb: wifi@0: compatible: 'oneOf' conditional failed, one must be fixed:
>>         ['cypress,cyw4373-fmac'] is too short
>>         'cypress,cyw4373-fmac' is not one of ['brcm,bcm4329-fmac', 'pci14e4,43dc', 'pci14e4,4464', 'pci14e4,4488', 'pci14e4,4425', 'pci14e4,4433']
>>         from schema $id: http://devicetree.org/schemas/net/wireless/brcm,bcm4329-fmac.yaml#
>>
>> imx8mn-venice-gw7902.dtb: wifi@0: compatible: 'oneOf' conditional failed, one must be fixed:
>>         ['brcm,bcm43455-fmac'] is too short
>>         'brcm,bcm43455-fmac' is not one of ['brcm,bcm4329-fmac', 'pci14e4,43dc', 'pci14e4,4464', 'pci14e4,4488', 'pci14e4,4425', 'pci14e4,4433']
>>         from schema $id: http://devicetree.org/schemas/net/wireless/brcm,bcm4329-fmac.yaml#
>>
>> Signed-off-by: Fabio Estevam <festevam@denx.de>
>> ---
>>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts | 2 +-
>>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts | 2 +-
>>  arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts | 2 +-
>>  arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts | 2 +-
>>  4 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
>> index 21d7b16d6f84..cde29aa1a0a2 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
>> @@ -801,7 +801,7 @@ &usdhc1 {
>>         status = "okay";
>>
>>         wifi@0 {
>> -               compatible = "brcm,bcm43455-fmac";
>> +               compatible = "brcm,bcm43455-fmac", "brcm,bcm4329-fmac";
>>                 reg = <0>;
>>         };
>>  };
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
>> index 964cc4fc2ddf..0bff7a6fdca6 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
>> @@ -726,7 +726,7 @@ &usdhc2 {
>>         status = "okay";
>>
>>         wifi@0 {
>> -               compatible = "brcm,bcm43455-fmac";
>> +               compatible = "brcm,bcm43455-fmac", "brcm,bcm4329-fmac";
>>                 reg = <0>;
>>         };
>>  };
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
>> index 3ac011bbc025..9a36edc60394 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
>> +++ b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
>> @@ -679,7 +679,7 @@ &usdhc2 {
>>         status = "okay";
>>
>>         wifi@0 {
>> -               compatible = "brcm,bcm43455-fmac";
>> +               compatible = "brcm,bcm43455-fmac", "brcm,bcm4329-fmac";
>>                 reg = <0>;
>>         };
>>  };
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
>> index 3473423ac939..faa370a5885f 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
>> @@ -737,7 +737,7 @@ &usdhc1 {
>>         status = "okay";
>>
>>         wifi@0 {
>> -               compatible = "cypress,cyw4373-fmac";
>> +               compatible = "cypress,cyw4373-fmac", "brcm,bcm4329-fmac";
>>                 reg = <0>;
>>         };
>>  };
>> --
>> 2.34.1
>>
> 
> Fabio,
> 
> Thank you for your continued efforts to squash out all these
> dt-binding warnings/issues.
> 
> Can you explain what the difference is in the dt-binding yaml between
> compatible/oneOf/items/{enum,const} and compatible/oneOf/enum? The

items defines a list. items with enum and const, defines a list of two
items, where first is an enum (so oneOf few) and second is fixed.

compatible/oneOf/enum is not a list. Or you could look at it as
one-element-list.


> first list for Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
> has a much larger set of enums including the bcm43455 on these boards
> but the second set of enums has a much more limited set.

What's the question here? Both define different things. One defines
compatible devices with some model, second defines just some devices.


> There is no
> driver code to look at for this because it is bound via SDIO device
> id's instead of the dt compatible property.
> 
> Best regards,
> 
> Tim

Best regards,
Krzysztof

