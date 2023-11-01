Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919137DDDB1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 09:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjKAIY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 04:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjKAIY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 04:24:27 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2E0F1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 01:24:21 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9d267605ceeso525497866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 01:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698827060; x=1699431860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TBWvET6IBXszoErEcoe2EKRkpfFSeipc62qQ0bXnK5Y=;
        b=NM/XQxbL7sIGYhoYQHP7lJdqmdxv3mT+6at5gv7jUPTZFLtidwDAYymEiHEFMB2tQR
         bLzY624PVAmRL8tX70oaStuJNaIFyOZRb0wDArTEPvkkm96b0HWVn0EwNEFHmhxoi+Vz
         oa1eWoAaqPm6Q8Zu3ifbgerLYk2xFfElyREszvw9L2ifmpM4fU9pQbdA2wur0xzkQj5C
         mBf6X57gLtUVy0eu+MUlWB1PehWEjipKrIR/ybJymzdIOCz7keHrGw9vZaBrXP7GHTJz
         I3z8+SWCYCI5yxKjz2yUdPryY8Dw2KGXSFGyl2xBhV2oLZXkchmZpMQ0T9p7UxQcIIjH
         T2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698827060; x=1699431860;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBWvET6IBXszoErEcoe2EKRkpfFSeipc62qQ0bXnK5Y=;
        b=GQzHuYsZpHasZuJt9P3N88yehbQa83mBppQ5AeNTMasDHUQeRogQTmJucJtZvxKmRU
         JQnHnK5Q2Svu7MiG7Yg9lhp0AFymTfk0/GW55KAQZpB3rFHAXmvbt+vgncSehuX32nsL
         0v+qzIzC9MgNPpZLswxmfcfAzM7JgHXJo/5oHrKACAy5DJgCw0tFWKvInD+P4hbjVkUH
         KY1qMisnp6zZ7YlRz79W2jiDEjeSSl2SwVGE9XNlzuc92NKRGlaVBFCqNqb/ex06WyiC
         OuYofSwqpCq6BZUoKEnd5FXTt/2xN82g0UoamZF61fSmVy84lXwZcCwO3IPhfF+sWS0I
         Hwfg==
X-Gm-Message-State: AOJu0YwKDe02XBCAPc6GJpcGRSZ+DdAjL5LFqBBVBUU0XvHFBfMMrqUM
        vvZsP9Gt/b2c0JuxPSUEd+k6Sg==
X-Google-Smtp-Source: AGHT+IFXuz6IzcS31cThS1mjXs5Daa68aY9heBRyvv2tCKxzSOtjEesbeLeoQ0qrc1RQGrPWnodCYQ==
X-Received: by 2002:a17:906:6a27:b0:9ae:6ff4:9f15 with SMTP id qw39-20020a1709066a2700b009ae6ff49f15mr1187552ejc.11.1698827060146;
        Wed, 01 Nov 2023 01:24:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id la5-20020a170906ad8500b00992e265495csm2131182ejb.212.2023.11.01.01.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 01:24:19 -0700 (PDT)
Message-ID: <630d58e0-589e-4411-905a-2514048e6ec4@linaro.org>
Date:   Wed, 1 Nov 2023 09:24:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 01/11] dt-bindings: media: s5p-mfc: Add mfcv12 variant
Content-Language: en-US
To:     Aakarsh Jain <aakarsh.jain@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        linux-samsung-soc@vger.kernel.org, andi@etezian.org,
        gost.dev@samsung.com, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        ajaykumar.rs@samsung.com, linux-fsd@tesla.com
References: <20231025102216.50480-1-aakarsh.jain@samsung.com>
 <CGME20231025102233epcas5p16b716d5b650bbc5af0d759ea4f58f44d@epcas5p1.samsung.com>
 <20231025102216.50480-2-aakarsh.jain@samsung.com>
 <948af111-e7a1-4757-a784-b4256657abd6@linaro.org>
 <000001da0810$c2b17680$48146380$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <000001da0810$c2b17680$48146380$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2023 15:31, Aakarsh Jain wrote:
> Hello Krzysztof
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: 25 October 2023 18:30
>> To: Aakarsh Jain <aakarsh.jain@samsung.com>; linux-arm-
>> kernel@lists.infradead.org; linux-media@vger.kernel.org; linux-
>> kernel@vger.kernel.org; devicetree@vger.kernel.org
>> Cc: m.szyprowski@samsung.com; andrzej.hajda@intel.com;
>> mchehab@kernel.org; hverkuil-cisco@xs4all.nl;
>> krzysztof.kozlowski+dt@linaro.org; dillon.minfei@gmail.com;
>> david.plowman@raspberrypi.com; mark.rutland@arm.com;
>> robh+dt@kernel.org; conor+dt@kernel.org; linux-samsung-
>> soc@vger.kernel.org; andi@etezian.org; gost.dev@samsung.com;
>> alim.akhtar@samsung.com; aswani.reddy@samsung.com;
>> pankaj.dubey@samsung.com; ajaykumar.rs@samsung.com; linux-
>> fsd@tesla.com
>> Subject: Re: [Patch v4 01/11] dt-bindings: media: s5p-mfc: Add mfcv12
>> variant
>>
>> On 25/10/2023 12:22, Aakarsh Jain wrote:
>>> Add Tesla FSD MFC(MFC v12) compatible.
>>>
>>> Cc: linux-fsd@tesla.com
>>> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
>>> ---
>>
>> No changelog and your cover letter does not explain what happened here.
>> Specifically, why did you decide to ignore received tag.
>>
> Last patch series we had two different patches for schema which was one for adding MFCv12 compatible string and other for adding its HW properties.
> In one of the patches you gave reviewed-by tag. Since mfc dt_schema got merged already, and this is relatively  new patch so thought of getting reviewed again.
> 
> Link to those patches:
> https://patchwork.kernel.org/project/linux-media/patch/20221011122516.32135-2-aakarsh.jain@samsung.com/
> https://patchwork.kernel.org/project/linux-media/patch/20221011122516.32135-3-aakarsh.jain@samsung.com/    
> 
> if you are ok, I will add your reviewed-by in next patch series.

It is okay to drop Reviewed-by tag, but this should be explicitly
mentioned in the changelog with a reason.

> 
>>>  .../bindings/media/samsung,s5p-mfc.yaml          | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/media/samsung,s5p-
>> mfc.yaml b/Documentation/devicetree/bindings/media/samsung,s5p-
>> mfc.yaml
>>> index 084b44582a43..c30eb309f670 100644
>>> --- a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
>>> +++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
>>> @@ -24,6 +24,7 @@ properties:
>>>            - samsung,mfc-v7                # Exynos5420
>>>            - samsung,mfc-v8                # Exynos5800
>>>            - samsung,mfc-v10               # Exynos7880
>>> +          - tesla,fsd-mfc                 # Tesla FSD
>>>        - items:
>>>            - enum:
>>>                - samsung,exynos3250-mfc    # Exynos3250
>>> @@ -165,6 +166,21 @@ allOf:
>>>            minItems: 1
>>>            maxItems: 2
>>>
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - tesla,fsd-mfc
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          maxItems: 1
>>> +        clock-names:
>>> +          items:
>>> +            - const: mfc
>>> +        iommus: false
>>
>> That's odd. How so? MFC v12 does not support IOMMU?
>>
> MFC v12 do support IOMMU. But currently it is not enabled in SW (has dependencies on some of the floating dma-mapping patches) and not tested on upstream kernel. 

Bindings describe hardware, not software.

> Current patch sets intend to add support for MFCv12 using reserve memory and later patches related to enable iommu will be posted (after resolving the dependencies). So I marked iommu property as false. 
> Now what is your suggestion here? Should I keep iommu as false or add memory-region as below?

I expect complete picture of the hardware, not something limited to
current driver, so for sure iommus must be there.

Please wrap your emails according to mailing lists rules.

Best regards,
Krzysztof

