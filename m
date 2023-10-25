Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61127D6F23
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344905AbjJYOWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344903AbjJYOWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:22:33 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7FB136
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:22:30 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31fa15f4cc6so4017818f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698243749; x=1698848549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G/Qu43zNd7XQ5kFiOx/NP64exhepkPFL2OMjkKGHe18=;
        b=BrOyUYj0AID73Kygku5Y6xPu1JtwqTYgDICQxJb01QkmQ5jTZzBA5g6qYYIv3mUuF4
         au9ExJHUun9tlRINX4cgpUfq3vX9Ruyz4gSdIAeA5eIGLyZj7xApCelJSpC5lmv/IBcQ
         zhKZRSh8tZ8AphN39dV6xt4azMPRpE0puS8C/VKzsAO7mFRnsQ+qnAqQFkr3T77EGZXA
         OAnLB9r4Q950SyIjddnUha3zPkBMMEekc61ci9b4PKFDk4OAwqk/bkaF70nMCCObBmo+
         DLVUxyzUGvuWFJWBjpCOGLEiK0mrsv3vsUHzpx6ep9gLWOdXGM2OI7gfHf7fA9J+FQb9
         Hong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698243749; x=1698848549;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/Qu43zNd7XQ5kFiOx/NP64exhepkPFL2OMjkKGHe18=;
        b=EYgfyyxsBBpnO6a8ysfJchXjHs+CqVOYPCGu238WRDR7ohy/pJZZmkMcDXBY4rv0A5
         eZc6uYDVbxhbkjG5BzuAMPd0k61kV0WUz5JYH+gWmv7DQL2Q+eD6GvcZeMX9k1I0QFQk
         RN3FF8/VefIygxi/xteJBM3pEsz6bksXYAEZTT5ypu6hIcwcGqTeIX6vv3cME8CUu/X/
         ISXcoFI6Zid1nC5o4AW7l+1ClkiEUwjL+LJGex+1mcHsD129ZBrJlqnEFf3ICDsDPdXr
         bcWzf2xcSv9QBOVD5TqNrTCpPKA2WN8KMKMoDZaDk6Ss2q00OjoTLSVvVQijvDr6pWmM
         j44Q==
X-Gm-Message-State: AOJu0Yw1pFvWNnVG52KcZ/MlZlsTkFJrPk2bRIG9DWTRlOhky/GteJQw
        Kd9Lo2/Fkj0ZJdkpI/LMUSRLgQ==
X-Google-Smtp-Source: AGHT+IG+P94r9kZMOwS+DNc3hbWsXodilW2Dud57ltgzXfPpK1sQiNfUa9mLM5c6S0F/pIS4OHPRUA==
X-Received: by 2002:a5d:6a07:0:b0:32d:a466:48d8 with SMTP id m7-20020a5d6a07000000b0032da46648d8mr11658558wru.69.1698243749291;
        Wed, 25 Oct 2023 07:22:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id t8-20020adff048000000b0032dc2110d01sm12197341wro.61.2023.10.25.07.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 07:22:28 -0700 (PDT)
Message-ID: <0844080c-7524-4686-9df6-ba25e3f6b808@linaro.org>
Date:   Wed, 25 Oct 2023 16:22:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] dt-bindings: hwmon: ti,ina238: add ti,ina237
Content-Language: en-US
To:     Richard Leitner <richard.leitner@linux.dev>,
        Conor Dooley <conor@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20231025-ina237-v1-0-a0196119720c@linux.dev>
 <20231025-ina237-v1-4-a0196119720c@linux.dev>
 <20231025-unclip-ion-826a58681a12@spud>
 <pwfj54krrau3rihjb73dd4p3yizzjyuv4gwxky776m2goerjw6@6rfxo6kzjhjs>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <pwfj54krrau3rihjb73dd4p3yizzjyuv4gwxky776m2goerjw6@6rfxo6kzjhjs>
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

On 25/10/2023 16:13, Richard Leitner wrote:
> On Wed, Oct 25, 2023 at 02:58:44PM +0100, Conor Dooley wrote:
>> On Wed, Oct 25, 2023 at 10:34:14AM +0000, Richard Leitner wrote:
>>> Add ti,ina237 binding to ti,ina238 as they share the same driver.
>>>
>>> Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
>>> ---
>>>  Documentation/devicetree/bindings/hwmon/ti,ina238.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina238.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina238.yaml
>>> index aba89e5f34b3..17408076696c 100644
>>> --- a/Documentation/devicetree/bindings/hwmon/ti,ina238.yaml
>>> +++ b/Documentation/devicetree/bindings/hwmon/ti,ina238.yaml
>>> @@ -22,6 +22,7 @@ description: |
>>>  properties:
>>>    compatible:
>>>      enum:
>>> +      - ti,ina237
>>
>> The driver patch you have done implies no difference between the
>> programming model for both of these devices. It'd seem to make more sense
>> for the ina237 to fall back to the ina238, thereby requiring no change in
>> the driver to support it.
> 
> Thanks for the quick feedback, Conor.
> 
> I first thought of just mentioning the ina237 in the documentation as
> "compatible" to the ina238. But IMHO it is better understandable if it's
> listed as compatible.

Conor did not oppose listing it. The point is to use fall-back.

> 
> And I would strongly encourage mentioning it somewhere (documentation or
> compatible). So other people using the ina237 are able to find it and
> don't have to compare the datasheets by themselves to find the right
> driver.

Sure, there is plenty of space in the driver code (.c or Kconfig) to
document whatever you wish. We focus here on the bindings, though.

Best regards,
Krzysztof

