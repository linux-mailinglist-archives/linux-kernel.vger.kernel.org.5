Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8967376E467
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbjHCJbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbjHCJa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:30:58 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7187D30ED
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 02:30:56 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-317798b359aso607588f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 02:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691055054; x=1691659854;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LkIHcBr4D3AWyeFHkNvp/kzN1jYSpCMGS1AHF/o5c9A=;
        b=KaTNqcmMU8XrC4AlTAK7GLUb0OVSgvQmMe1GzwuMaGkT1bC6Ar+eB8Bex5fmM2UfAs
         XYnfFEgWij0eey3gAObflxdGhrH7lMy3wuc3h/7KTqOqKAzYIg0OovTKhZAELasTaMIR
         4/SAmd53zay0A67BoVIri5qIuqAQ0qXSU7wkUcXoqbCQRehQFnuJkzTdlCuG11FXpsZ4
         4yyQf19kWgnz5e+OCij04nDpXhqGgSWZ83fYkmgwOyeSIqyyku1X240LwQ9TEkwJeLLO
         QQVDDmJ5EcpRkf7SiK4ipizrKRj3ubccJLF48c27rEwzHbYS31G4mJsH1eSHKm1Ygt6S
         z/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691055054; x=1691659854;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LkIHcBr4D3AWyeFHkNvp/kzN1jYSpCMGS1AHF/o5c9A=;
        b=iGByoV/wCpuVbjsnCQcIdAqk71C9fWnWM7ctgydFRQJLdRHwpmT03T9fFr8VOsmMFe
         sJK1rcZM246kCvDRI4ZL1UZDqIiZH0s6MeFjp9Bh273tIJGA+WDEwzhWOmugxpO/fHLP
         R4qVX4Mkunvmi/WP6szHISeyAOylIB/e0/mE6Or6b62b5oDGmUxh6XyhALIjO8vpB372
         vHgqKeElRAydFCv2/EntsRxi/jPuyyDF43guBE+b9OJffNG1ByBDvIlxhTL0NDV7Sici
         DGb0YGM0jbt76Tr20TIc6OREzhsSAPqsMy+raQg1/mRD0Hb7oYaF5HxU/8NAJFjpteMV
         Qilw==
X-Gm-Message-State: ABy/qLaQAoIhvkd0pZCjKeNMD5sIfAnqE9d1U0fl3d5QpYgodqbHiX7y
        1tzqwX+OlOS5iYOuyFQ90XPAkA==
X-Google-Smtp-Source: APBJJlFZEiNSoW7XP3KC4CMX4RvkaDRIpCL6qNHmhmh7S6W+5L/Q6Ko5fmVchCDSe4efmQUf8OGYPg==
X-Received: by 2002:a5d:6782:0:b0:314:182a:3d96 with SMTP id v2-20020a5d6782000000b00314182a3d96mr6148630wru.28.1691055054566;
        Thu, 03 Aug 2023 02:30:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8656:583:d034:d966? ([2a01:e0a:982:cbb0:8656:583:d034:d966])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d68d0000000b003140f47224csm21286033wrw.15.2023.08.03.02.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 02:30:53 -0700 (PDT)
Message-ID: <9f0670a7-6ef6-7823-19c2-de10683f303f@linaro.org>
Date:   Thu, 3 Aug 2023 11:30:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/4] drm/panel: sitronix-st7789v: add support for partial
 mode
Content-Language: en-US
To:     Maxime Ripard <mripard@kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
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
Organization: Linaro Developer Services
In-Reply-To: <qmwtcungahbe2bhty7v2rso2kf3vai6k47muwipifbybmi7o6s@oj6lngnhyhtg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2023 11:22, Maxime Ripard wrote:
> On Thu, Aug 03, 2023 at 10:51:57AM +0200, Daniel Vetter wrote:
>> On Thu, Aug 03, 2023 at 10:48:57AM +0200, Maxime Ripard wrote:
>>> On Thu, Aug 03, 2023 at 10:11:22AM +0200, Neil Armstrong wrote:
>>>> Hi,
>>>>
>>>> On 18/07/2023 17:31, Michael Riesch wrote:
>>>>> Hi all,
>>>>>
>>>>> This series adds support for the partial display mode to the Sitronix
>>>>> ST7789V panel driver. This is useful for panels that are partially
>>>>> occluded by design, such as the Jasonic JT240MHQS-HWT-EK-E3. Support
>>>>> for this particular panel is added as well.
>>>>>
>>>>> Note: This series is already based on
>>>>> https://lore.kernel.org/lkml/20230714013756.1546769-1-sre@kernel.org/
>>>>
>>>> I understand Maxime's arguments, but by looking closely at the code,
>>>> this doesn't look like an hack at all and uses capabilities of the
>>>> panel controller to expose a smaller area without depending on any
>>>> changes or hacks on the display controller side which is coherent.
>>>>
>>>> Following's Daniel's summary we cannot compare it to TV overscan
>>>> because overscan is only on *some* displays, we can still get 100%
>>>> of the picture from the signal.
>>>
>>> Still disagree on the fact that it only affects some display. But it's
>>> not really relevant for that series.
>>
>> See my 2nd point, from a quick grep aside from i915 hdmi support, no one
>> else sets all the required hdmi infoframes correctly. Which means on a
>> compliant hdmi tv, you _should_ get overscan. That's how that stuff is
>> speced.
>>
>> Iirc you need to at least set both the VIC and the content type, maybe
>> even more stuff.
>>
>> Unless all that stuff is set I'd say it's a kms driver bug if you get
>> overscan on a hdmi TV.
> 
> I have no doubt that i915 works there. The source of my disagreement is
> that if all drivers but one don't do that, then userspace will have to
> care. You kind of said it yourself, i915 is kind of the exception there.
> 
> The exception can be (and I'm sure it is) right, but still, it deviates
> from the norm.

HDMI spec is hidden behind a paywall, HDMI testing is a mess, HDMI real
implementation on TVs and Displays is mostly broken, and HDMI certification
devices are too expensive... this is mainly why only i915 handles it correctly.

> 
>>> I think I'll still like to have something clarified before we merge it:
>>> if userspace forces a mode, does it contain the margins or not? I don't
>>> have an opinion there, I just think it should be documented.
>>
>> The mode comes with the margins, so if userspace does something really
>> funny then either it gets garbage (as in, part of it's crtc area isn't
>> visible, or maybe black bars on the screen), or the driver rejects it
>> (which I think is the case for panels, they only take their mode and
>> nothing else).
> 
> Panels can usually be quite flexible when it comes to the timings they
> accept, and we could actually use that to our advantage, but even if we
> assume that they have a single mode, I don't think we have anything that
> enforces that, either at the framework or documentation levels?

Yep, this is why we would need a better atomic based panel API that would
permit us handling dynamic timings for panel and get out of the single-mode
for modern panels.

Neil

> 
> Maxime

