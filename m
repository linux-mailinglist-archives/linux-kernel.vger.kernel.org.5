Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6848F76E858
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbjHCMfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbjHCMfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:35:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD6035A2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 05:35:01 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-317744867a6so746487f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 05:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691066100; x=1691670900;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJJ9qJiOv0G7HMQjbiIKrFLcNirkUQDo0H5qNV9GEQA=;
        b=SJpwUC05tWzEyelJ3a2TSZaEZfWFIePkz9SCekMbUlLs+5EySWtT5nSP7WUBypiROb
         /+ldtFSlXKraSOodBFh96ITt7dDAB5ieJJMMvJ7RyNepSE6wNWXK6YJXnu2O5zvjMja1
         z+us5Zw+RrVg3IaNcjghMJGss3aKnQJ2w3lMEbyCOE0RORIjTtF96PxqYqmeMrqTelKR
         tjMGSHpmT/suG8jILy3SCwi8lNyAtmxvMLRxwwQh5g6/6neZobO2nCSnJ32091eXWENY
         eCjV70RhiFldfKSEMPkxK18LmfU9vpwGkAPQydrb0oarQzjtjNl1QzOkDWKSstoUySQ8
         2xIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691066100; x=1691670900;
        h=content-transfer-encoding:in-reply-to:subject:organization
         :references:cc:to:content-language:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WJJ9qJiOv0G7HMQjbiIKrFLcNirkUQDo0H5qNV9GEQA=;
        b=Fxe42J+ctXS4hsWpMB1pUA9+PkMcHouo83M9YYzTWhh3cVRjso2pcEK3cUJX6w1ykU
         BnhwOKH0PkOVGVjtlYnugNsjyDiD1Eddq94rkgzMaH8acVHvE9AIm/KO2GahxUUqmabQ
         wTiX1Rqv9RK0FhLmI3NNslYuDGBRQ85Ci5SkZJ/F3LGS34uPnTbrQ6G9Bb4qZSHYAMXz
         xmX38oXEzCXE1tiPWiFroTHa7uUWRskgLJeUaOnrykwMd4pJSmZFCQH3B3GN4dVqyu23
         PIEh8g9vHgGtiKgAisqpXGBZqOrVZavy1pDJOURqvmL1McB/KOa0PJQartkPu1brzwjU
         VFGg==
X-Gm-Message-State: ABy/qLYNiorgPEPl5r4+zY6Wx5qlvs2lj34CZDETu+fm3JhQfuQ/+Vhk
        mzGMauqL2td2dgmTKvr0QOymQA==
X-Google-Smtp-Source: APBJJlH7eK9YiZvHBqaTZLhPa68PLhJGbb04OrulSf0llnNzG6Ksw81XL0g7UCeSVVMe8AZAN2p7UQ==
X-Received: by 2002:a05:6000:1046:b0:317:6623:e33f with SMTP id c6-20020a056000104600b003176623e33fmr6810018wrx.14.1691066100348;
        Thu, 03 Aug 2023 05:35:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8656:583:d034:d966? ([2a01:e0a:982:cbb0:8656:583:d034:d966])
        by smtp.gmail.com with ESMTPSA id w3-20020a5d6083000000b003179d5aee67sm13658067wrt.94.2023.08.03.05.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 05:34:59 -0700 (PDT)
Message-ID: <e8c395e4-23b7-b252-21a1-5f8f8c5c552a@linaro.org>
Date:   Thu, 3 Aug 2023 14:34:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Content-Language: en-US
To:     Maxime Ripard <mripard@kernel.org>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sebastian Reichel <sre@kernel.org>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        David Airlie <airlied@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230718-feature-lcd-panel-v1-0-e9a85d5374fd@wolfvision.net>
 <292c3e7d-82ea-2631-bd4b-ef747f56287c@linaro.org>
 <ekmwiy3iuvtqtb6hwjbba2ia3aemt3dxmx6dj3zh6ljfmuim4w@4jzhqdenxth4>
 <ZMtqraOyGN9JvVj9@phenom.ffwll.local>
 <qmwtcungahbe2bhty7v2rso2kf3vai6k47muwipifbybmi7o6s@oj6lngnhyhtg>
 <CAKMK7uFbQURKYvB2JWnwZDEeA-qURpx_GFqR1FxgtuvK7jX4TA@mail.gmail.com>
 <d2sgj2iap4ouu425buqkorx76kpdqh77k3z36vaegma67pciyv@n3mbiglfidxx>
Organization: Linaro Developer Services
Subject: Re: [PATCH 0/4] drm/panel: sitronix-st7789v: add support for partial
 mode
In-Reply-To: <d2sgj2iap4ouu425buqkorx76kpdqh77k3z36vaegma67pciyv@n3mbiglfidxx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2023 13:43, Maxime Ripard wrote:
> On Thu, Aug 03, 2023 at 12:26:03PM +0200, Daniel Vetter wrote:
>> On Thu, 3 Aug 2023 at 11:22, Maxime Ripard <mripard@kernel.org> wrote:
>>>
>>> On Thu, Aug 03, 2023 at 10:51:57AM +0200, Daniel Vetter wrote:
>>>> On Thu, Aug 03, 2023 at 10:48:57AM +0200, Maxime Ripard wrote:
>>>>> On Thu, Aug 03, 2023 at 10:11:22AM +0200, Neil Armstrong wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 18/07/2023 17:31, Michael Riesch wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> This series adds support for the partial display mode to the Sitronix
>>>>>>> ST7789V panel driver. This is useful for panels that are partially
>>>>>>> occluded by design, such as the Jasonic JT240MHQS-HWT-EK-E3. Support
>>>>>>> for this particular panel is added as well.
>>>>>>>
>>>>>>> Note: This series is already based on
>>>>>>> https://lore.kernel.org/lkml/20230714013756.1546769-1-sre@kernel.org/
>>>>>>
>>>>>> I understand Maxime's arguments, but by looking closely at the code,
>>>>>> this doesn't look like an hack at all and uses capabilities of the
>>>>>> panel controller to expose a smaller area without depending on any
>>>>>> changes or hacks on the display controller side which is coherent.
>>>>>>
>>>>>> Following's Daniel's summary we cannot compare it to TV overscan
>>>>>> because overscan is only on *some* displays, we can still get 100%
>>>>>> of the picture from the signal.
>>>>>
>>>>> Still disagree on the fact that it only affects some display. But it's
>>>>> not really relevant for that series.
>>>>
>>>> See my 2nd point, from a quick grep aside from i915 hdmi support, no one
>>>> else sets all the required hdmi infoframes correctly. Which means on a
>>>> compliant hdmi tv, you _should_ get overscan. That's how that stuff is
>>>> speced.
>>>>
>>>> Iirc you need to at least set both the VIC and the content type, maybe
>>>> even more stuff.
>>>>
>>>> Unless all that stuff is set I'd say it's a kms driver bug if you get
>>>> overscan on a hdmi TV.
>>>
>>> I have no doubt that i915 works there. The source of my disagreement is
>>> that if all drivers but one don't do that, then userspace will have to
>>> care. You kind of said it yourself, i915 is kind of the exception there.
>>>
>>> The exception can be (and I'm sure it is) right, but still, it deviates
>>> from the norm.
>>
>> The right fix for these is sending the right infoframes, _not_ trying
>> to fiddle with overscan margins. Only the kernel can make sure the
>> right infoframes are sent out. If you try to paper over this in
>> userspace, you'll make the situation worse, not better (because
>> fiddling with overscan means you get scaling, and so rescaling
>> artifacts, and for hard contrasts along pixel lines that'll look like
>> crap).
>>
>> So yeah this is a case of "most upstream hdmi drivers are broken".
>> Please don't try to fix kernel bugs in userspace.
> 
> ACK.
> 
>>>>> I think I'll still like to have something clarified before we merge it:
>>>>> if userspace forces a mode, does it contain the margins or not? I don't
>>>>> have an opinion there, I just think it should be documented.
>>>>
>>>> The mode comes with the margins, so if userspace does something really
>>>> funny then either it gets garbage (as in, part of it's crtc area isn't
>>>> visible, or maybe black bars on the screen), or the driver rejects it
>>>> (which I think is the case for panels, they only take their mode and
>>>> nothing else).
>>>
>>> Panels can usually be quite flexible when it comes to the timings they
>>> accept, and we could actually use that to our advantage, but even if we
>>> assume that they have a single mode, I don't think we have anything that
>>> enforces that, either at the framework or documentation levels?
>>
>> Maybe more bugs? We've been slowly filling out all kinds of atomic kms
>> validation bugs in core/helper code because as a rule of thumb,
>> drivers get it wrong. Developers test until things work, then call it
>> good enough, and very few driver teams make a serious effort in trying
>> to really validate all invalid input. Because doing that is an
>> enormous amount of work.
>>
>> I think for clear-cut cases like drm_panel the fix is to just put more
>> stricter validation into shared code (and then if we break something,
>> figure out how we can be sufficiently lenient again).
> 
> Panels are kind of weird, since they essentially don't exist at all in
> the framework so it's difficult to make it handle them or their state.
> 
> It's typically handled by encoders directly, so each and every driver
> would need to make that check, and from a quick grep, none of them are
> (for the reasons you said).
> 
> Just like for HDMI, even though we can commit to changing those facts,
> it won't happen overnight, so to circle back to that series, I'd like a
> comment in the driver when the partial mode is enabled that if userspace
> ever pushes a mode different from the expected one, we'll add the margins.

To be fair, a majority of the panel drivers would do the wrong
init of the controller with a different mode because:
- mainly the controller model is unknown
- when it's known the datasheet is missing
- when the datasheet is here, most of the registers are missing
- and most of the time the timings are buried in the init sequence

It's sad but it's the real situation.

Only a few drivers can handle a different mode, and we should perhaps
add a flag when not set rejecting a different mode for those controllers and
mark the few ones who can handle that...
And this should be a first step before adding an atomic Panel API.

Neil

> 
> That way, if and when we come back to it, we'll know what the original
> intent and semantics were.
> 
> Maxime

