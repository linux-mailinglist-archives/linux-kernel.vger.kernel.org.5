Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C947E7E50
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344425AbjKJRne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbjKJRmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:42:00 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39D73A233
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 07:15:08 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40836ea8cbaso15112515e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 07:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699629307; x=1700234107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AImaWoC/tXOEtHWLdz8sCITz8wYqENXhjXAG+qBs1Ww=;
        b=tpSsRiU+9W4+M5RCkiS5Mu+UZjXQVynVYlVKnbNqDNCX7H8MQqaw8qjTkDS+P2nJiH
         aWw2yYgRo7V53CnCF0UgABHTT51STDjBAG5pLWITdnup3PJF6D28/6qPEiFYttRtH3dp
         7855rfLKBgcOh2xG9pU+usdQ9KqvFXv7ekFcYJSkp/5mMCtm2bAYIuc+OZpROjRuwKeJ
         UmoH+9eRMmu9cz/eOk1kn56kzYkI/+BJv2WG/WpXAmAfGc5z8ylfBRVEnbrgRmBobQT/
         VSyCK9rU7zuKAHBRDjwJdgkGp3VRcgha4MuhEuFUdX/2nBGERWyWNgRyhd0a5q8FSc4z
         IJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699629307; x=1700234107;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AImaWoC/tXOEtHWLdz8sCITz8wYqENXhjXAG+qBs1Ww=;
        b=cVs2lHrgyALyz/hf7qbwQFXvNFvO+pEhdQsbVLt/ePFSY5kBfpKUCRU7gslluGKhS7
         48i7TLVUg7Qvn5hz/xHLJ2attR4MshbyLDnPdnzngWMUZu8Xys1Yfy7zQXL/931K6x7N
         EOhH4iF3YKfRdTUsaEAbJ95qN7b78TZdNtWMYAtxf42bCM9fEk6UOQ0s5reC8gbuhT0+
         qQuUCXL4JNaqdku+TLGv8Z1FGLVkndVXIy+BUnOFu4oMMjeCaBP5ayPfJfyvVSrwdkn4
         Wg88Y7Mrmf5P4DBlUxSyG+2s0J//+WVkI5ycaztJJf3qzbeTiTD2pUUsthE3GIil88Or
         NBRA==
X-Gm-Message-State: AOJu0YyZD9o6z8XspKWcnPTYbH1Mi6kaOcMcMbre0ICpCWzELtcowA68
        Pys5U/chPJfHJS9Cj8lGNGVWww8TsBYS+P+eFw0=
X-Google-Smtp-Source: AGHT+IG1TYHHTG3svUv7jCY7QOVVGQjPbgYLHfFFQV1Vw2BWE1A9MFglG+K5Ly4wwt4fubC15YtD6w==
X-Received: by 2002:a05:600c:4f52:b0:409:79cb:81a3 with SMTP id m18-20020a05600c4f5200b0040979cb81a3mr6913523wmq.30.1699629307312;
        Fri, 10 Nov 2023 07:15:07 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id be7-20020a05600c1e8700b004063c9f68f2sm5428398wmb.26.2023.11.10.07.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 07:15:06 -0800 (PST)
Message-ID: <6576d4a6-31fa-4780-9a8a-5a1d1974836f@linaro.org>
Date:   Fri, 10 Nov 2023 16:15:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: mediatek,mtk-wdt: add MT7988
 watchdog and toprgu
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <6912f6f406bc45674020681184f3eeca2f2cb63f.1699576174.git.daniel@makrotopia.org>
 <2678cb48-1d2b-47bc-9272-06d9aa140c58@collabora.com>
 <ZU47hV1i66WN8nZJ@makrotopia.org>
 <d7b72b3e-c8f4-4675-ae62-26f5ae576f0a@linaro.org>
 <ZU5A59KO8Y_Q97IG@makrotopia.org>
 <a56cfe76-ab03-4187-b6f1-04a5c3414e64@linaro.org>
 <ZU5DVNOmtyFwUTdC@makrotopia.org>
 <708046ae-a821-420c-959a-ab5cb712aa9e@linaro.org>
 <ZU5IcrjqQpwMopJC@makrotopia.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZU5IcrjqQpwMopJC@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2023 16:12, Daniel Golle wrote:
>>>>>>>>> diff --git a/include/dt-bindings/reset/mediatek,mt7988-resets.h b/include/dt-bindings/reset/mediatek,mt7988-resets.h
>>>>>>>>> new file mode 100644
>>>>>>>>> index 0000000000000..fa7c937505e08
>>>>>>>>> --- /dev/null
>>>>>>>>> +++ b/include/dt-bindings/reset/mediatek,mt7988-resets.h
>>>>>>>>> @@ -0,0 +1,12 @@
>>>>>>>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>>>>>>>> +
>>>>>>>>> +/* TOPRGU resets */
>>>>>>>>
>>>>>>>> The first reset is zero, the second reset is one.
>>>>>>>>
>>>>>>>> Where's the zero'th reset? :-)
>>>>>>>
>>>>>>> Currently the reset numbers represent the corresponding bit positions in
>>>>>>> the toprgu register, as this is how the mtk-wdt driver is organized.
>>>>>>>
>>>>>>> So there is probably something at bit 0, and also at bit 3~11 and
>>>>>>> maybe also 17~23, but it's unknown and may be added later once known
>>>>>>> and/or needed.
>>>>>>
>>>>>> There is no need to put register bits, which are not used by the driver,
>>>>>> in the bindings.
>>>>>
>>>>> There aren't. That's why there isn't a zero'th reset (and also not 3~11, 17~24).
>>>>>
>>>>> Or should the driver be reorganized to provide a mapping of logical to
>>>>> physical resets, and then have only the needed once present and start
>>>>> counting logical resets from 0? This is doable, of course, but it's a
>>>>> bit of effort just for the aesthetical goal of starting to count from
>>>>> zero and continous in header file.
>>>>>
>>>>> And, of course, chances are that other currently still unused bits
>>>>> will be needed at a later point which then would mean having to add
>>>>> them in at least 2 places (header file and mapping logical<->physical)
>>>>> where as currently it would just mean adding a line defining it in the
>>>>> header file.
>>>>
>>>> You can do it, but it's not what I wrote here. So bear with me:
>>>>
>>>> "There is no need to put register bits in the bindings."
>>
>> No comments here, so I assume you agree with this.

Here is the answer to...

>>
>>>>
>>>> You replied "There aren't", which I don't understand in this context. I
>>>> can be clearer:
>>>> Drop this hunk.
>>>
>>> So adding the file to include/dt-bindings/reset/ should go into a
>>> seperate patch? Because including it with the driver itself gave me
>>> a checkpath warning telling me that dt-bindings should go seperate,
>>> which is why I included it with the binding docs.
>>
>> No, I said the hunk should be dropped. Removed.
> 
> I guess we are somehow misunderstanding each other.
> Lets go with an example. I can put the header into a commit of its own,
> just like commit
> 5794dda109fc8 dt-bindings: reset: mt7986: Add reset-controller header file
> https://lore.kernel.org/r/20220105100456.7126-2-sam.shih@mediatek.com
> 
> Would that be acceptable? And if not, why?

...this question.

Again, whether this is separate patch - it is still hunk which I think
should be removed. I gave the reason "why" in this mail thread and in
multiple other discussions.



Best regards,
Krzysztof

