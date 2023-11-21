Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56847F2791
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjKUIeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjKUIeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:34:10 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4234310C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:34:06 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so64080921fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700555644; x=1701160444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KrMj19vsl0kSqsf6FPK0QmlAMs/Qdk3cNg78FESN9s8=;
        b=nldNHXPVlEgsCL88QLbz9iLr8lqpgu9vdurQ/mzV3ZnnUKPFM/ireox792ET7G4NVH
         nG+rsiIHdxbf4dVz8xboHkT2OLwcE/87AyEwEnUYvQjt07ns0XGZpnYpL10xpF+d2eSt
         2mqt2NmAxU2fKx8MX9hr1qqJb5PPAAI1h+ATrK4Nme7Vb3nGYIPl1MBGErlxv1eY66Av
         fllcP7upj5f137yS+bV5WWdzB4nHD1zmm/uOxaq1aFpe+A+7Zvjtp2NfRcmb+G8Khd1c
         RShxRirTgCR1je5hsXL5i1KSTE65pOiyKKJsqJ7BHUaB6h07NuCJsYbXoLgJzGcfw2Gv
         XGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700555644; x=1701160444;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KrMj19vsl0kSqsf6FPK0QmlAMs/Qdk3cNg78FESN9s8=;
        b=AGhGWb2ClS7sHBPLm6sgDTt0Ba7Uo2lKF8BimDug7W3ExUkOEXdcjyawwYvwJw4Omr
         xU7J/88BPMG8WA6k1gu7JEJYQJcvPCXHrCvhvbS/J2U5ROqwUY0N74Qk68kv/NOH1SRM
         5nMTWfK8ObtnLivYC3tXwVIgZQql6VqpyPpA28gNtBFroP0sCbzyt0nj7/7foPFEYPjy
         tBjRRSIcRP0sVEhSisX1qtSVgIYQFweWQjLfBxryKfrDTduloCO8VeOU6DY+94LxJjwL
         7DeIQ15fSiQXzfRPBrsUqKibrn1gMn6ps7XbxuKNN0FybnaljEbi3/V0vv7ygWRcE4hk
         1gHg==
X-Gm-Message-State: AOJu0YxpWtphBorkS8uWJ09brPujWTx4mOZdg2hLoCPxKUt8MvYdJUJy
        AL+NKZpj0Hb3Dm6cMox/kbEciQ==
X-Google-Smtp-Source: AGHT+IEIxbZ/YPyBCox+qwkgZr1WWsLyitkFh3pS5SAxs6Wbu+mmxNIwPTZjSbrv0EipObyy/47hyw==
X-Received: by 2002:a2e:3e17:0:b0:2c5:1bd3:5658 with SMTP id l23-20020a2e3e17000000b002c51bd35658mr7020225lja.28.1700555644416;
        Tue, 21 Nov 2023 00:34:04 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id s5-20020a5d6a85000000b0032d9f32b96csm13765372wru.62.2023.11.21.00.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 00:34:03 -0800 (PST)
Message-ID: <67a2cea0-f2de-4e7d-bc9d-ae29885f9210@linaro.org>
Date:   Tue, 21 Nov 2023 09:34:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Content-Language: en-US
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-2-linux@rasmusvillemoes.dk>
 <fd5c7d9f-a52b-4abb-a0d4-f5bdf2a669de@linaro.org>
 <1c016987-da88-47f2-bc1b-fcbe4c71a5c9@rasmusvillemoes.dk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1c016987-da88-47f2-bc1b-fcbe4c71a5c9@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2023 09:27, Rasmus Villemoes wrote:
> On 21/11/2023 08.52, Krzysztof Kozlowski wrote:
>> On 20/11/2023 16:10, Rasmus Villemoes wrote:
>>> Some boards are capable of both rs232 and rs485, and control which
>>> external terminals are active via a gpio-controlled mux. Allow
>>> describing that gpio in DT so that the kernel can transparently handle
>>> the proper setting when the uart is switched between rs232 and rs485
>>> modes.
>>>
>>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>>> ---
>>>  Documentation/devicetree/bindings/serial/rs485.yaml | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
>>> index 9418fd66a8e9..e8136c7d22ed 100644
>>> --- a/Documentation/devicetree/bindings/serial/rs485.yaml
>>> +++ b/Documentation/devicetree/bindings/serial/rs485.yaml
>>> @@ -61,6 +61,11 @@ properties:
>>>        the active state enables RX during TX.
>>>      maxItems: 1
>>>  
>>> +  rs485-mux-gpios:
>>> +    description: GPIO pin to control muxing of the SOC signals to the RS485
>>> +      transceiver.
>>> +    maxItems: 1
>>
>> Aren't you duplicating
>> https://lore.kernel.org/all/3Nk.ZZrp.5w3Yn0Ecy5C.1bMzDp@seznam.cz/ ?
> 
> Hadn't seen that, but no, this is not at all the same. That patch seems
> to define an input pin to tell whether to enable rs485 mode or not (sort
> of early run-time version of the linux,rs485-enabled-at-boot-time).
> 
>> Anyway, similar comments: this does not look like generic RS485
>> property. Are you saying that standard defines such GPIO?
> 
> No, I'm saying that several boards that exist in the wild have the
> RX/TX/CTS etc. pins routed to a multiplexer, which in turn routes those
> signals to either a rs485 transceiver or an rs232 driver (and those in
> turn are connected to different screw terminals). So no, it's not a
> property of the rs485 protocol itself, but very much related to making
> use of rs485 (and rs232, though of course not simultaneously) on such
> boards.

Which upstream boards use it? To me it looks like specific to each
controller, not to RS485.

> 
> Would a link to a schematic help?

Yes, always :)

Best regards,
Krzysztof

