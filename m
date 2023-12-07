Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C768089A5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjLGN5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjLGN5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:57:50 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E07010CA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:57:56 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c0fc1cf3dso10294955e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 05:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701957474; x=1702562274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8nrtmbZhihcOTPQj1ObH2wiKry//e3Y22NpcOn65kr4=;
        b=XQXhZ6g9coiRNMpV4rD9izYORkKtS1cwaTqY5ylAACyaltozXvLahQ1l63nbH0lH6n
         zTHl0sAazVgwUF4mPr5jnCxwyLMIDxHFhv6ztgS8HH9O9REDx/yxT0ye+lG/0hTn0ioZ
         UO/VC4smbAjNaEuer9BpVGDFSnrfTWApwrtaa3Ien7VFTlvaQ+EIl5Ip0XdViharawXL
         qImSA2PuayZogc7knRwe+GBg3q3SQp8lCUAnwNWnCWgg7WIEnCwNp3QR7FAqIPt9JQwi
         G7lM+DgEYrzsqYOzKql3yJhx2yhL9GQgR8kWjYLLX+rVu77dgeELvl3Q75FywhuDW6AH
         WrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957474; x=1702562274;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8nrtmbZhihcOTPQj1ObH2wiKry//e3Y22NpcOn65kr4=;
        b=HV0emeK060Ogfj4JAgc80W5K51hau/0OourLCTgzAZZ7iyjh4nGIhsBfbBjLzjEgns
         oyPGjsHDGplFb4w7ryJUwoewXPFpLT2IzV7at4qlE0HYHxcb6XgnaTHE1VeLGhWILmmu
         3jHoXKgd8iQ5oqfsoHkTTdkV2NA0AJQLUpK6EkxRnzPBcX1A1Peey4wYlZzeNDz+uv3P
         gn5rgE221A1mMpDvOUAITU1WAxB7P+ygIAXkEG7Y4u5JW7vHTIXLjHRLew5nM4FMVEpK
         wXZQvgj790QQj8FCvHeGMwmUt2bc6lvCUXv7PXzxEaPWA/LjKA3Qtpex/y3PAXnyBXLC
         IL7g==
X-Gm-Message-State: AOJu0YyA+RAMfFnnhrLtK915FKzcLADP0vS1saqP85z8yh09Ru/Tz78A
        lFxpcPh8owPEOSd69jo1T41NFg==
X-Google-Smtp-Source: AGHT+IHqqInOQ5qDNJvhTUWJE0UqL+fwaB/8swjT5x7qI7S+Tc7pOZR7ccApV7T601DsEd9hagw/DQ==
X-Received: by 2002:a05:600c:54f1:b0:40c:838:a695 with SMTP id jb17-20020a05600c54f100b0040c0838a695mr1407049wmb.174.1701957474585;
        Thu, 07 Dec 2023 05:57:54 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id l26-20020a170906a41a00b00a1da2c9b06asm862918ejz.42.2023.12.07.05.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 05:57:54 -0800 (PST)
Message-ID: <526bfe1e-7f6a-4402-80d6-2c97a1e3198e@linaro.org>
Date:   Thu, 7 Dec 2023 14:57:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: marvell: move MMP boards to common marvell
 directory
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231201132306.60753-1-krzysztof.kozlowski@linaro.org>
 <1e25e2f4-e4b9-4219-a9c2-cb6230a62549@lunn.ch>
 <a44b7bb2-34ac-45ab-84c6-630d604f1bcf@linaro.org>
 <5d511e31-8ff5-4c23-a65e-8660833a9799@lunn.ch>
 <944c02f5-d0e6-4367-bb4d-b366054b3e4e@linaro.org>
 <9c50d09e-98a0-416f-b779-9cf39d1a94b5@lunn.ch>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <9c50d09e-98a0-416f-b779-9cf39d1a94b5@lunn.ch>
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

On 01/12/2023 17:17, Andrew Lunn wrote:
> On Fri, Dec 01, 2023 at 03:38:36PM +0100, Krzysztof Kozlowski wrote:
>> On 01/12/2023 15:34, Andrew Lunn wrote:
>>> On Fri, Dec 01, 2023 at 03:21:05PM +0100, Krzysztof Kozlowski wrote:
>>>> On 01/12/2023 14:51, Andrew Lunn wrote:
>>>>> On Fri, Dec 01, 2023 at 02:23:06PM +0100, Krzysztof Kozlowski wrote:
>>>>>> Marvell board bindings are spread over arm/marvell/ and arm/mrvl/
>>>>>> directories.  Move MMP board bindings from the latter to the former, to
>>>>>> keep all of them together.
>>>>>
>>>>> Hi Krzysztof
>>>>>
>>>>> Did you test get_maintainers.pl? MMP has a different maintainer to
>>>>> many of the other Marvell SoCs. We want emails going to the correct
>>>>> Maintainers, and ideally not spamming the others.
>>>>
>>>> The old binding was not referenced in MAINTAINERS, at least I could not
>>>> find it.
>>>> My change does not affect status quo - orphaned files.
>>>>
>>>> OTOH, some entries like Orion list specific files. Others like Marvell
>>>> list entire directory, which is their mistake in the first place.
>>>>
>>>> There is a mess in this approach, but the mess exists before my patch.
>>>
>>> I think these moved files will now match:
>>>
>>> ARM/Marvell Kirkwood and Armada 370, 375, 38x, 39x, XP, 3700, 7K/8K, CN9130 SOC support
>>> M:      Andrew Lunn <andrew@lunn.ch>
>>> M:      Gregory Clement <gregory.clement@bootlin.com>
>>> M:      Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>>> L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>> S:      Maintained
>>> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu.git
>>> F:      Documentation/devicetree/bindings/arm/marvell/
>>>
>>> But these files are not Gregory or my problem.
>>
>> Yeah, that's what I meant by listing entire directory.
>>
>>>
>>> If they were orphaned before, i would prefer they are either orphaned
>>> after the move, or associated to the correct maintainer. Being
>>> associated to the wrong maintainers is worse than having no
>>> maintainers at all.
>>
>> I can add this to existing maintainers entry. Which one? I see only two
>> ARM/Marvell.
> 
> MMP SUPPORT
> R:      Lubomir Rintel <lkundrak@v3.sk>
> L:      linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> S:      Odd Fixes
> T:      git git://git.kernel.org/pub/scm/linux/kernel/git/lkundrak/linux-mmp.git
> F:      arch/arm/boot/dts/marvell/mmp*
> F:      arch/arm/mach-mmp/
> F:      include/linux/soc/mmp/
> 
> But you also need to modify the ARM/Marvell Kirkwood and ... so that
> it excludes these MMP files.

Let's make it then in subdirectory? There are like 20 items from
Marvell/Kirkwood, so I imagine all apply to it. At least currently they
are applying.

Best regards,
Krzysztof

