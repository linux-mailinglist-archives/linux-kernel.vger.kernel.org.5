Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9A37EF154
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 12:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345923AbjKQLBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 06:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345820AbjKQLBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 06:01:07 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972CF129
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 03:01:01 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40790b0a224so14295415e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 03:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700218860; x=1700823660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gBWkWs6StiOKfZQ+gAI/eCLlmHQRf4tCCrVpnJkf8qc=;
        b=W0uNR290x1Ntnui7K7UmUFehZfs9YCbOHy08yjZeg6e3Rkh3piwN3o19Lzno8LaPMt
         /YVCXnFxGPfdBrIrk6a2RuJuGVy7QXePRcNj2RnkGE/l7LI/2D+RA36WKNi2sVWV3THQ
         fdSePkMBuPOztyQIZGUJQGotOVxSgBvdn1xpmEvuXeHY88f6UncLbUDmXoe+GMXHfpIJ
         MtTwX07n2C50WriWjJ1J+RuZOiyfH2+9O8c6F8DfePU4Ddk/DaAyr8SPVb4yBGYctrJA
         kpScAChJo7x/ee3mvCrikUkJgz1HCRf3b0Yissmy0Q+RIKo++j33LRWava+3pkyPsnBV
         2owA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700218860; x=1700823660;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gBWkWs6StiOKfZQ+gAI/eCLlmHQRf4tCCrVpnJkf8qc=;
        b=aJEF6wg937aYBfTQ7LszTDJTWklL5eqZhyCSiugQ86h9NU9QgGmlfIezoqO/46p0W3
         0CXXt5kAbaYqEfRFC1UBEQ5uUIJ5TWVqyIqZqpGGbzNWiHf7drez+eWCP7pmgYkrtj0e
         lrNSeYrbq84rO9yvwaxb+RhRpX91zNPx5z6n6sAr5QIKu6TRlsfQEySShXmCpNhzuvxi
         H3soxSd0I5bOj2WdG3odi0gCa8R6CZ7soLATpaRz2j3xCkm/NtrO7D1w27VU8ESfpINW
         8KmxnaNkADH7qL/KTsjtjji4YLaiSQIJTmzVpkPxbucZxrmGCqC/dxh8wiR1c3n0cc7V
         +y8w==
X-Gm-Message-State: AOJu0Yyx/cCO05ajS3zQXGTrQvsHM4Y62YS6aY+sRcfvCff6QnLdzBbe
        2rHD10dxaU1+Vgk9+NGuvWc0DA==
X-Google-Smtp-Source: AGHT+IGd8YPlZqn1eCwDFIOssIZfG00UFoHhXUsgBkImO7mtVQMHzM/KiiylOUJ/af6wFmBcGBqOhw==
X-Received: by 2002:a5d:6e01:0:b0:32f:d88b:2245 with SMTP id h1-20020a5d6e01000000b0032fd88b2245mr13415500wrz.19.1700218859958;
        Fri, 17 Nov 2023 03:00:59 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d60cb000000b00331697bbcf5sm1770892wrt.94.2023.11.17.03.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 03:00:57 -0800 (PST)
Message-ID: <d565624f-0cb2-4c42-bcfc-eebef3b7b26c@linaro.org>
Date:   Fri, 17 Nov 2023 12:00:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] Introduce ExynosAutov920 SoC and SADK board
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org
References: <CGME20231115095852epcas2p21e067efe75275c6abd2aebf04c5c6166@epcas2p2.samsung.com>
 <20231115095609.39883-1-jaewon02.kim@samsung.com>
 <170005362858.21132.4200897251821879805.b4-ty@linaro.org>
 <6e69df6c-10fa-404a-ac02-4880723b8c50@linaro.org>
 <55a0f27c-ea46-40ae-b1e5-e650802b89a8@linaro.org>
 <d6f3d451-6a53-46b6-2263-cc071a9dc44c@samsung.com>
 <d8fbd100-2351-4dbe-ae7f-d98a84432589@linaro.org>
 <af102ef7-aa34-1b9d-c39c-228729fef015@samsung.com>
 <2febc62c-c763-42ae-b649-2ca284543cc0@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <2febc62c-c763-42ae-b649-2ca284543cc0@linaro.org>
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

On 17/11/2023 11:57, Krzysztof Kozlowski wrote:
>>>>>> And dropped. You did not test it. Please read Samsung SoC maintainer
>>>>>> profile:
>>>>>> https://www.kernel.org/doc/html/latest/process/maintainers.html#arm-samsung-s3c-s5p-and-exynos-arm-architectures
>>>>>>
>>>>>> I also made announcements on the lists and on social.kernel.org. I don't
>>>>>> know where to announce it more...
>>>>>>
>>>>> To clarify, I dropped only DTS and kept bindings. Let me know if
>>>>> bindings are problematic here...
>>>>>
>>>>> I also repeated the announcement:
>>>>> https://social.kernel.org/notice/AbqJkj9gOZJ3sG8eCu
>>>>> Please share internally within Samsung, so there will be no surprises.
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>>
>>>>>
>>>> I already checked and there were no warnings or errors as shown below.
>>>>
>>>> Did I miss something??
>>> It's not what is written in maintainer profile. Where do you see the
>>> result of dtc W=1?
>>>
>>
>> Sorry, Krzysztof I miss W=1.
>>
>> I haven`t been active in mainline for a long time, so I`m missing out on 
>> a lot of things.
> 
> If you (plural you, Samsung) ever gave me an email address where I can
> send notifications I would gladly forward them to you.
> 
> Over the time I sent few of them, like the one about deprecation of
> platforms or changing some rules, feedback for common solution for
> minidump (to remind: Samsung decided to skip it so we go with Qualcomm
> idea and you will not be able to come with your own later) etc. I was
> even contacting some addresses in Samsung LSI, but there was never a
> response, except the one about minidump.
> 
> There was like never a chance to really get to Samsung, so sorry, now it
> is Samsung's fault it does not follow announcements.

Heh, my post on social.kernel.org is pinned (pinned!) for four months!
Four months is still not enough...

Best regards,
Krzysztof

