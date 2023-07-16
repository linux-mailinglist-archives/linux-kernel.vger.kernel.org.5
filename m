Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7C2754F93
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 18:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjGPQId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 12:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjGPQIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 12:08:31 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DE5E66
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 09:08:28 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51de9c2bc77so4787471a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 09:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689523707; x=1692115707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yFNOxCkZidbalN7CuyDDRpdo9zeZvLW7A53Aw1rLKbM=;
        b=HE//uS2g8oJofWthSV32zbw+CJapJ/Tm9PZHDtSngUqz/r5XkJc+b4Tc0sLTaTvKec
         zqJ00IlLi8lak5WeR8YLitYN3Bkzh817YQi9Bp7ypzpZB2bE3EEk+U+xjVZ695Bn+EPt
         mERPLvOewkPUntu/559HrttHK4qFScRiUc8NPkyH4rEam7+/cn+U4N+UJkBVrQGoPJMV
         tnzvlkqbfdhnGCGytVmUv+CPan6p/vMJHvJ/lFJ4uq/721YrER1nWvVr/45mHJkJttAy
         6z2Hd9W8kMAP1CXmTvbfuQZbYSJwG5k0dgs0vQi6Iox0liE8LmiFvew9Hb13NsKLOVk5
         CkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689523707; x=1692115707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yFNOxCkZidbalN7CuyDDRpdo9zeZvLW7A53Aw1rLKbM=;
        b=DA0r1sijJKXfwRhen0yv2OSkXr3a0vyAQCkK/yWJLagpBcxD4OD9crx81hwEGnpb43
         4uaS0llT2P4NGOcZ1vx+cYoyqHsYq4z13OKIwktt6H1sbx9lLk5/Gz5UXxBjGLaj3L/c
         0NP2uclfwGX+xfeL8KVPa2xE/IPE0uOCnH6TXIYZd0PpXFOFMRHX+y7AhLoPrJGVGE0L
         dsrAgd1QRhmyALs1kO1WXcZLyivXTN/CwcKT1etRVsdkSXS9LUHktv8HPfVsvvFG5UEi
         mNuqNDLhk5RZec2hCQl15k7WibKXipnzucZYN3r4GR+nLV0h05ejxYlkBDFUy9enESrO
         Y4ag==
X-Gm-Message-State: ABy/qLYb9g/5qaWiqbd9Oxol24f6XrLHtxBPEHZMRmW2XjEHNXi7TxpS
        P83XvL+kIqqUOq0buIGQ1pANxg==
X-Google-Smtp-Source: APBJJlGTep8KdTxvuPl0WnJS8vyPvSMZi8aDsQQ+H0L3EiFiiq2Ww4jKrPFs5gGwcbADlAqstdyWEA==
X-Received: by 2002:a17:906:1114:b0:98e:4c96:6e1f with SMTP id h20-20020a170906111400b0098e4c966e1fmr9722967eja.69.1689523706778;
        Sun, 16 Jul 2023 09:08:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id l9-20020a170906230900b0099342c87775sm8124189eja.20.2023.07.16.09.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 09:08:25 -0700 (PDT)
Message-ID: <cf91edc9-1093-495b-48eb-6b05198c2541@linaro.org>
Date:   Sun, 16 Jul 2023 18:08:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [v6 2/4] dt-bindings: hwmon: Add ASPEED TACH Control
 documentation
To:     =?UTF-8?B?6JSh5om/6YGU?= <billyking19920205@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        Billy Tsai <billy_tsai@aspeedtech.com>
References: <CAGUgbhCqOJaEPjS96o2au21uW4NhqFScm4Ayd8PzOQvqxQ94SQ@mail.gmail.com>
 <0b9dd5cf-f4ca-2e6b-624d-0b451bbc2f30@linaro.org>
 <0ba3767c-d481-6e2c-2d32-b79af0e1efd8@roeck-us.net>
 <CAGUgbhC34-pUp4ECULc0ScaN7hUF1L-z69h+ji-TiVrv4gKd3Q@mail.gmail.com>
 <7b198d57-ddec-3074-314a-3e5e5b8f48f9@roeck-us.net>
 <CAGUgbhDbFedVe-pc+muD_NtDpjHpGqMDdrS3A73C-QbxeHn4oQ@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAGUgbhDbFedVe-pc+muD_NtDpjHpGqMDdrS3A73C-QbxeHn4oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2023 13:17, 蔡承達 wrote:
> Guenter Roeck <linux@roeck-us.net> 於 2023年7月14日 週五 下午6:26寫道：
>>
>> On 7/14/23 03:18, 蔡承達 wrote:
>>> Guenter Roeck <linux@roeck-us.net> 於 2023年7月14日 週五 下午5:59寫道：
>>>>
>>>> On 7/14/23 00:13, Krzysztof Kozlowski wrote:
>>>>> On 14/07/2023 09:04, 蔡承達 wrote:
>>>>>
>>>>>>           > This is because our register layout for PWM and Tach is not
>>>>>> continuous.
>>>>>>
>>>>>>           > PWM0 used 0x0 0x4, Tach0 used 0x8 0xc
>>>>>>
>>>>>>           > PWM1 used 0x10 0x14, Tach1 used 0x18 0x1c
>>>>>>
>>>>>>           > ...
>>>>>>
>>>>>>           > Each PWM/Tach instance has its own controller register and is not
>>>>>> dependent on others.
>>>>>
>>>>> Your email reply quoting style is very difficult to read.
>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> Hi Guenter,
>>>>>>
>>>>>>
>>>>>>
>>>>>> Did you receive a response to my previous email?
>>>>>>
>>>>>> I would like to inquire if you have any further concerns regarding the PWM
>>>>>> and Tach with 16 instances.
>>>>>
>>>>> But isn't like this in all PWMs in all SoCs?
>>>>>
>>>>
>>>> Correct, pretty much every fan controller is implemented that way.
>>>> I don't understand the logic.
>>>>
>>>
>>> Hi Krzysztof and Guenter,
>>>
>>> Apologies for any confusion earlier.
>>> So, you think that the implementation with 16 instances of TACH/PWM
>>> device nodes in dts instead of one is ok to you, right?
>>>
>>
>> Did I say that ? No, it is not ok with me. It is confusing and doesn't make
>> sense to me. This is one fan controller with 16 channels, not 16 separate
>> controllers.
>>
> 
> This patch serial doesn't use to binding the fan control h/w. It is
> used to binding the two independent h/w blocks.
> One is used to provide pwm output and another is used to monitor the
> speed of the input.
> My patch is used to point out that the pwm and the tach is the
> different function and don't need to
> bind together. You can not only combine them as the fan usage but also
> treat them as the individual module for
> use. For example: the pwm can use to be the beeper (pwm-beeper.c), the
> tach can be used to monitor the heart beat signal.

Isn't this exactly the same as in every other SoC? PWMs can be used in
different ways?

Anyway, it is tricky to keep the discussion since you avoid posting
entire DTS. I already said:

"I will start NAKing such patches without DTS user. It's like reviewing
fake code for some unknown solution and trying to get from you piece of
answers one by one, because you do not want to share entire part."



Best regards,
Krzysztof

