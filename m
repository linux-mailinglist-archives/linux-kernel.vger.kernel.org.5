Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE030808301
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378256AbjLGIav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjLGIah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:30:37 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7D2193
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 00:30:42 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c2bb872e2so1699175e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 00:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701937840; x=1702542640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KhEtGaBfm1DY3HJhPYjgVLkGIjTJ/KYfwl/sNUZov4M=;
        b=qTSyzG2EPfgFLTY6GXc0PsVMv2RDzttGJtwLxS0evFFsKmtb0q2GXbmV6ralCdDIxX
         qCxWfUfWxV28DeifVLlaVYQ4JW/QmXZJtbcW9Q9tU7vThfta8V6cfFbQ4d4LWRxqk4Nw
         bRjX2x6j5t8SL6ZljXXb9+yBMiBUrkke45bsQ7/YVbXhQw/AN/A9U1yjBim+t3rd4L77
         r7bWaKxVCu0QyGt4n20gzJRpiu/jMoTN4VD9VIVe5OcVhEY/aojIVXBE8oB+BSnFW2Vj
         BOtcIxXsrml0zBHibD2CDj4uSnFmWecEJ+YFYOqNVyWJ/G0nO4Ltk2q54q8+LTCt/q+p
         Yx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701937840; x=1702542640;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhEtGaBfm1DY3HJhPYjgVLkGIjTJ/KYfwl/sNUZov4M=;
        b=Pvn3ljcXiQRqS7zfH5mqUyEmEjjodeifXVJDli1xS6PLMMwueA9Gug5DpTmJUn4FJl
         3rNfrp4AfxhE0gJVqMX+CxHIEpHfzpmhr2jfnSzhKCuko0i8pEbB61oe0BzsI+s5+/V3
         YumlcWGGiY265O7JdYb+AaCkAsYfahgzeG8mfCJmwV+iL5cnSEzFHLAR9JABTOwo7ctW
         xeZIyWuSBKsCIAuC3vC7oDagOO6EZuGo4FyHZ9LCIMzyg6djUITfL95mGsenYNL9b0uh
         58e4x7PQDKsIqNmw+HzbD62V5hpO8YoIvtDQK205mLgcfhOHfidNULyexSDGo59RPMk8
         7/Qw==
X-Gm-Message-State: AOJu0YxVxTZOG5+Ia4AzsmA3n8wGbMyjRHvm8d8iz5v6t8Lz2E/de6qD
        i0QnWWmACCW0+vEDVtXopnNfRw==
X-Google-Smtp-Source: AGHT+IG/jbZKZa3yW5zIfToWsszFtese/t0rCQRxREsxxh+J3kwaX61EwsG0bKv6p3pjHFXVKTrSfw==
X-Received: by 2002:a05:600c:4743:b0:40b:5f03:b3ef with SMTP id w3-20020a05600c474300b0040b5f03b3efmr696963wmo.273.1701937840372;
        Thu, 07 Dec 2023 00:30:40 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id ek10-20020a05600c3eca00b0040b3d33ab55sm1149728wmb.47.2023.12.07.00.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 00:30:39 -0800 (PST)
Message-ID: <21673bfd-bb87-4c7d-a53f-337c263f3a00@linaro.org>
Date:   Thu, 7 Dec 2023 09:30:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: usb: Add the binding example for the
 Genesys Logic GL3523 hub
Content-Language: en-US
To:     Anand Moon <linux.amoon@gmail.com>, Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Icenowy Zheng <uwu@icenowy.me>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-amlogic@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231204144429.45197-1-linux.amoon@gmail.com>
 <20231204144429.45197-2-linux.amoon@gmail.com>
 <20231206135311.GA2043711-robh@kernel.org>
 <CANAwSgTS0ZSFPv4x803pCLEpjH5imh8vEoWpbiJRH14Sy3GZww@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CANAwSgTS0ZSFPv4x803pCLEpjH5imh8vEoWpbiJRH14Sy3GZww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2023 18:14, Anand Moon wrote:
> Hi Rob,
> 
> On Wed, 6 Dec 2023 at 19:23, Rob Herring <robh@kernel.org> wrote:
>>
>> On Mon, Dec 04, 2023 at 08:14:25PM +0530, Anand Moon wrote:
>>> Add the binding example for the USB3.1 Genesys Logic GL3523
>>> integrates with USB 3.1 Gen 1 Super Speed and USB 2.0 High-Speed
>>> hub.
>>>
>>> For onboard hub controllers that support USB 3.x and USB 2.0 hubs
>>> with shared resets and power supplies, this property is used to identify
>>> the hubs with which these are shared.
>>>
>>> GL3523 has built-in 5V to 3.3V and 5V to 1.2V regulators, which serves
>>> power to the USB HUB, it uses 5V power regulator.
>>>
>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>> ---
>>> V6: fix the description of the regulators
>>> Updated the commit message for regulator updates.
>>> add reviewed by Conor Dooley
>>> [1] https://lore.kernel.org/all/20231130053130.21966-2-linux.amoon@gmail.com/
>>> v5: upgrade peer-hub description : Conor Dooley
>>> [0] https://www.genesyslogic.com.tw/en/product_view.php?show=67 [Block Diagram]
>>> v4: Fix the description of peer-hub and update the commit message.
>>> Schematics of the Odroid N2+
>>> https://dn.odroid.com/S922X/ODROID-N2/Schematic/odroid-n2_rev0.6_20210121.pdf
>>> V3: fix the dt_binding_check error, added new example for Genesys GL3523
>>> v2: added Genesys GL3523 binding
>>> v1: none
>>> ---
>>>  .../bindings/usb/genesys,gl850g.yaml          | 65 +++++++++++++++++--
>>>  1 file changed, 61 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
>>> index ee08b9c3721f..c6f63a69396d 100644
>>> --- a/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
>>> +++ b/Documentation/devicetree/bindings/usb/genesys,gl850g.yaml
>>> @@ -9,9 +9,6 @@ title: Genesys Logic USB hub controller
>>>  maintainers:
>>>    - Icenowy Zheng <uwu@icenowy.me>
>>>
>>> -allOf:
>>> -  - $ref: usb-device.yaml#
>>> -
>>>  properties:
>>>    compatible:
>>>      enum:
>>> @@ -27,12 +24,46 @@ properties:
>>>
>>>    vdd-supply:
>>>      description:
>>> -      the regulator that provides 3.3V core power to the hub.
>>> +      The regulator that provides 3.3V or 5.0V core power to the hub.
>>> +
>>> +  peer-hub:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description:
>>> +      For onboard hub controllers that support USB 3.x and USB 2.0 hubs
>>> +      with shared resets and power supplies, this property is used to identify
>>> +      the hubs with which these are shared.
>>>
>>>  required:
>>>    - compatible
>>>    - reg
>>>
>>> +allOf:
>>> +  - $ref: usb-device.yaml#
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - usb5e3,608
>>> +    then:
>>> +      properties:
>>> +        peer-hub: false
>>> +        vdd-supply: false
>>> +        reset-gpios: true
>>> +
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - usb5e3,610
>>> +              - usb5e3,620
>>> +    then:
>>> +      properties:
>>> +        peer-hub: true
>>> +        vdd-supply: true
>>> +        reset-gpios: true
>>
>> No need for this if schema. The default is they are allowed.
>>
> 
> If I move reset-gpios to required, I observe the below warning.
> 
>   DTC_CHK Documentation/devicetree/bindings/usb/maxim,max33359.example.dtb
> /home/alarm/linux-amlogic-5.y-devel/Documentation/devicetree/bindings/usb/usb-device.example.dtb:
> hub@1: 'reset-gpio' is a required property
>         from schema $id: http://devicetree.org/schemas/usb/genesys,gl850g.yaml#

Where are the properties defined? If you open the binding you see:
nowhere. You cannot define properties in some variant with "true".
Please define all of them in top-level and only narrow/constrain when
applicable.


Best regards,
Krzysztof

