Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167A580B60C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 20:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjLIT0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 14:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjLIT0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 14:26:53 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBEAB7;
        Sat,  9 Dec 2023 11:27:00 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7b70f451399so70222539f.0;
        Sat, 09 Dec 2023 11:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702150019; x=1702754819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/CS+2dOrg8lRndJOViWuMxTn+pfWJIfx/SVtYqnhXtI=;
        b=Hh53SB8ahy2b/D0tp9eFElLQPxxwSL6IUPg02di6KBba92UYuFGMJ9QxujiFL7q0Nz
         3vp1Wk1RqfTV5aMeQC/qg/4wHqyIyCl88i5jDn8dBdws+WvKBwncYcPleTlK8V20lrme
         UNbp2MS0EJpe1WiqMMnzldwtqQKQvx3Ay8jOXOxmfjSVgiccXWw+tzgqjBrMeB5SOMEg
         G74QrWdfONX4Dt94Eo4uAzohtCUJsfMgjiQj/dOWrwIDZwSzplGgMC+cukatHf6DUk8R
         krdBjDDca4xOA2UEcWkJYEXsSZtw2iPbNTgN6S5ALyMJDV3GjuBH1shZCTNgshflVqEF
         trlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702150019; x=1702754819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/CS+2dOrg8lRndJOViWuMxTn+pfWJIfx/SVtYqnhXtI=;
        b=u9UgiauI7w9vwUt0vbo/COnxn5L+pJ8d3g1gI9xgPPPY7lA6ulMlu4fM81JvygLLZY
         LAr6v6tTKocjVKFCmdtMGONahAhuAwTcRI+i3heJKW1pX2Qh1ew4iYs0VTlPf5lzyuXJ
         z6Ap8bzuBvT/Wvs5MOCVBjvuMrhrUGcR2F544xdA3slIUxEvHfievuaCN1jFRABNs0g7
         O1e0Egd9ruRaN24VOI6SSLOB7WxRfCqbADouCA/JvpQ/Iv5YCkxc0jzLyhWiR+Qxp60d
         kQr7qn1N9dHGMUH28QdQtG9ABbqt6Fg8cZFD7sJ1Cvh1muyw9laxtKnyj836dIZD2av7
         KMrA==
X-Gm-Message-State: AOJu0Ywrys5XyZ0ZcJz8tC0KWom1/cD906eoLpEgw75ops+8GUtjsa4Q
        Ugt15VbW48CPRfZd8j4ZQFE=
X-Google-Smtp-Source: AGHT+IFGbII4YZhDonPEH7GIate2RH3+ElxvIRJUX8NgI0k1MZogzaEWMhWBgr/qDMtj9j8jLf7vLw==
X-Received: by 2002:a5e:9413:0:b0:7b7:19d2:b53a with SMTP id q19-20020a5e9413000000b007b719d2b53amr2659456ioj.28.1702150019544;
        Sat, 09 Dec 2023 11:26:59 -0800 (PST)
Received: from ?IPV6:2001:470:42c4:101:971d:15c7:de39:3b4b? ([2001:470:42c4:101:971d:15c7:de39:3b4b])
        by smtp.gmail.com with ESMTPSA id fh11-20020a056638628b00b004690150ade2sm1086084jab.147.2023.12.09.11.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Dec 2023 11:26:59 -0800 (PST)
Message-ID: <9915035d-88ce-f961-00c0-fad24aa07764@gmail.com>
Date:   Sat, 9 Dec 2023 12:26:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] xhci: Introduce "disable-usb3" DT property/quirk
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231208210458.912776-1-CFSworks@gmail.com>
 <20231208210458.912776-2-CFSworks@gmail.com>
 <d9ebe207-1f20-4254-9523-f2231bf9a0a4@kernel.org>
From:   Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <d9ebe207-1f20-4254-9523-f2231bf9a0a4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/9/23 06:53, Krzysztof Kozlowski wrote:
> On 08/12/2023 22:04, Sam Edwards wrote:
>> Some systems may have xHCI controllers that enumerate USB 3.0 ports, but
>> these ports nevertheless cannot be used. Perhaps enabling them triggers a
>> hardware bug, or perhaps they simply aren't connected and it would be
>> confusing to the user to see an unusable USB 3.0 rhub show up -- whatever
>> the case may be, it's reasonable to want to disable these ports.
>>
>> Add a DT property (and associated quirk) to the xHCI driver that skips
>> over (i.e. ignores and doesn't initialize) any USB 3.0 ports discovered
>> during driver initialization.
>>
>> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
>> ---
>>   Documentation/devicetree/bindings/usb/usb-xhci.yaml | 4 ++++

Hi Krzysztof,

> 
> Bindings are always separate patches.
> 
> Please do not sneak in properties without DT review.
> 

It makes sense that the new property should be introduced in a separate 
patch. I'll ensure that is the case in v2. (If there is one -- see below.)

> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling.

I have tried (and failed) to find the documentation for this 
linux-devicetree bot. Do you have the link? In particular, I'd like to 
ensure that patch 2/2 (the one that actually changes established 
behavior) is tested sufficiently thoroughly.

> Performing review on untested code might be
> a waste of time, thus I will skip this patch entirely till you follow
> the process allowing the patch to be tested.

That's fine; this patch has just failed review anyway (due to the new 
property not being introduced in a separate patch), and I'll need to 
prepare and send a v2 to proceed. However as I mentioned in the cover, 
this is a semi-RFC. I haven't discussed the overall idea with anyone 
yet, so to avoid wasting my own time, I need to give the USB folks ample 
opportunity to object to the proposed changes or suggest improvements 
before investing more effort in refining the patchset.

As of now, I'm only seeking commentary, not formal review. I'd 
appreciate any insights on the approach I've taken and whether there are 
any potential challenges or alternatives that haven't been explored yet. 
Therefore, I'll hold off on CC-ing linux-devicetree at this stage to 
keep the focus on the broader concept, and will loop them in (with any 
other recipients as appropriate) for v2 when (and if!) there's consensus 
here on linux-usb that the general direction is worth pursuing.

> 
> Please kindly resend and include all necessary To/Cc entries.
> 
> Best regards,
> Krzysztof
> 

Happy Saturday,
Sam
