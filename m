Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A697E8356
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345624AbjKJT7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjKJT7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:59:05 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7A7C7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:59:01 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9c3aec5f326so720791366b.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699646340; x=1700251140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R8cn+VJG8Pr0dfxLT+np0Cpc2PKRfJh+uwOoxIwTEjg=;
        b=r7LfKSBTi14sdlyoYOYrPeJToQW1Dnv8Fa/t3R3RBi41GDUozIC1OMudUR6pLHfzCs
         uLHJlvBTHqm1acbg/szUNIGQzCLErgmS/XPQN6EuEDYAXMxhxgAd62f2EXgF0QU94CUV
         EirZxcQky8V5y/LV+AjR9iYNCHSL1RG1tsLzkBy/HIWfzIITEe6ur9mqMkOh0Cu07CyW
         RqGkTz2u7kXtSNQwjf4kdIdBnDrGqVCNPhdhIw7Ggphbkj9cVtpC7dwpyglnboAygi3I
         nc5IExTQZNwpK6ZHQ9ssTRBcoKmC9zKH0egegaWp/AtJ8C3KgTDou2Of2+aRyVnUzYmY
         D3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699646340; x=1700251140;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8cn+VJG8Pr0dfxLT+np0Cpc2PKRfJh+uwOoxIwTEjg=;
        b=gf3Ah2LntMf8UaX5sY2pamRwL9HfLufrFomK3Vas1Q2jM90X9AuHvjj/gg2IoAXha6
         BQYOs8nwDO43rFDbh9ZziIeDNKsNDlt6AudNS61mMArfBp22cXSCqtLTp1TPadaxeJMj
         GdZS/orqNKugNXSRzgHfflcMFtPxqOmp5IetRzuJ1vZk3HDhu7pPN3wNlJyPrnG0oD+R
         LN3buxagIiqj9YsDZp+R85feA/n8ktV+osayDRxI0G0R1KNCi8hX9iZecihp6f9Bv6gr
         qKOPjdXlPgfiLtDHUWMKQ0Cz4ZOlMOU0ym3xVlOr7r//niwFLftPyMVY/tdotAu8fNgA
         OP5Q==
X-Gm-Message-State: AOJu0YwqriPO6T9SP/2JH3gs4wJnOTRNfys2pOkWlasM/ey3DjN03OIr
        GRZJHuUl3MwhW0J+uH1dbeTPNw==
X-Google-Smtp-Source: AGHT+IHei+7ZbC5KkewDhMCHfScGn96Z1oERkUul6+q+W4O+tbGD/2YHzDZdNvHQ+F8IQ9LkMvdT7w==
X-Received: by 2002:a17:907:7f27:b0:9da:de23:738e with SMTP id qf39-20020a1709077f2700b009dade23738emr3955561ejc.37.1699646339719;
        Fri, 10 Nov 2023 11:58:59 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id u7-20020a1709063b8700b009b9a1714524sm25127ejf.12.2023.11.10.11.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 11:58:59 -0800 (PST)
Message-ID: <8846adad-9504-4ffd-b9c3-f5e78082d261@linaro.org>
Date:   Fri, 10 Nov 2023 20:58:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: mediatek,mtk-wdt: add MT7988
 watchdog and toprgu
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
References: <2678cb48-1d2b-47bc-9272-06d9aa140c58@collabora.com>
 <ZU47hV1i66WN8nZJ@makrotopia.org>
 <d7b72b3e-c8f4-4675-ae62-26f5ae576f0a@linaro.org>
 <ZU5A59KO8Y_Q97IG@makrotopia.org>
 <a56cfe76-ab03-4187-b6f1-04a5c3414e64@linaro.org>
 <ZU5DVNOmtyFwUTdC@makrotopia.org>
 <708046ae-a821-420c-959a-ab5cb712aa9e@linaro.org>
 <ZU5IcrjqQpwMopJC@makrotopia.org>
 <6576d4a6-31fa-4780-9a8a-5a1d1974836f@linaro.org>
 <bb0ed593-082b-4edd-9a1e-78cccf796677@linaro.org>
 <ZU5jU-T0m5QW4ZeF@makrotopia.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZU5jU-T0m5QW4ZeF@makrotopia.org>
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

On 10/11/2023 18:07, Daniel Golle wrote:
> On Fri, Nov 10, 2023 at 04:21:35PM +0100, Krzysztof Kozlowski wrote:
>> On 10/11/2023 16:15, Krzysztof Kozlowski wrote:
>>>>>> So adding the file to include/dt-bindings/reset/ should go into a
>>>>>> seperate patch? Because including it with the driver itself gave me
>>>>>> a checkpath warning telling me that dt-bindings should go seperate,
>>>>>> which is why I included it with the binding docs.
>>>>>
>>>>> No, I said the hunk should be dropped. Removed.
>>>>
>>>> I guess we are somehow misunderstanding each other.
>>>> Lets go with an example. I can put the header into a commit of its own,
>>>> just like commit
>>>> 5794dda109fc8 dt-bindings: reset: mt7986: Add reset-controller header file
>>>> https://lore.kernel.org/r/20220105100456.7126-2-sam.shih@mediatek.com
>>>>
>>>> Would that be acceptable? And if not, why?
>>>
>>> ...this question.
> 
> ... which you didn't answer. Sorry, but it's not helpful to be polemic
> or ironic in a code review involving non-native English speakers
> trying to understand each others.

Why do you keep skipping - third time - my earlier reply? The earlier
paragraph?

Cutting lines out of context is not how this should be discussed.

So let me bring it:

>> FOO
> Here is the answer to...

>> BAR
> ...this question.

The "FOO" Is the answer. Go open the emails and read the answer.



> 
>>>
>>> Again, whether this is separate patch - it is still hunk which I think
>>> should be removed. I gave the reason "why" in this mail thread and in
>>> multiple other discussions.
>>
>> I gave you clear reasoning 7 hours ago:
>> https://lore.kernel.org/all/59629ec1-cc0c-4c5a-87cc-ea30d64ec191@linaro.org/
>> to which you did not respond.
> 
> Because it doesn't match anything existing regarding MediaTek reset
> drivers, and I was assuming there must be some kind of misunderstanding,
> which is why I replied to your later email in the same thread.
> 
> My assumption that the problem was merely having documentation and
> header combined in a single commit stems from the fact that a very
> similar patch for MT7986[1] was Ack'ed by Rob Herring about a year and
> a half ago; hence the rule you apply here may have always existed, but
> apparently then hasn't been applied in the past.
> 
> Literally *all* existing dt-binding headers for MediaTek SoCs follow a
> direct 1:1 mapping of reset bit in hardware and reset number in the
> header files. The driver is simple, all it cares about is the maximum
> number defined in the header (and I like that, because it makes it very
> easy to add new SoCs). At this point the abstraction needed to
> fulfill your request doesn't exist, not for any of the SoCs using
> mtk_wdt.c. It can be implemented, surely, it's a problem computers can
> solve. If that's what you (and current maintainers of that driver)
> would want me to implement, please say so clearly and spell it out.
> 
> Also be clear about if all the other existing headers need to be
> converted, mappings for all SoCs created in the driver, ... all before
> support for MT7988 can go in?
> Or should the existing headers for other MediaTek SoCs remain
> untouched because they are already considered stable API or something?

I am repeating myself... but I don't know how to put it other way. I did
not ask you to rewrite your driver. I asked to drop the change to
bindings, because it is entirely pointless.

Drop this change, only this. No need to rewrite drivers, they stay the same.

Best regards,
Krzysztof

