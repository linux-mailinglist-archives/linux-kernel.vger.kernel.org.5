Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD909780764
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358718AbjHRIoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358710AbjHRInk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:43:40 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E833ABA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:43:36 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so978916e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692348214; x=1692953014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pZRVjP108x+rTr243Ys5IG0z60fpovntpqPusD6Tea0=;
        b=f9gpAHr79wue2A4A8FhUN39Eld/pbkXaaRmdUOUc58dSFwm0nMrkzkD9iHka0adjkx
         q2X0aJj9Gj/V8jATscJRSCj+kZKzdoo7udXW82xn+DpzCCnocR9KmRXl2T1g1ZmxSA1B
         Ix7Dd3I48Jk9BYyqo6FmUM0whM7AaQCvb28MRn74OdzNkOFKRnPrXtoZHPZ1T5egPtkl
         jReyFGRcobmfK7JzGyqs3q1t24asVXM0KPtHTv4m9V9TjcegWoJFF34syO3oIiwhFxm6
         CY+xtuzltxJCvRatj6KOyqXq0+NgWsRvpHaQucgj8FvcHEQlA1jTkWzk0QJBMeOmcE2K
         d46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692348214; x=1692953014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZRVjP108x+rTr243Ys5IG0z60fpovntpqPusD6Tea0=;
        b=cuCDVYfDRSioMUQd1HggHNT1r6cSAPOj/GfqwCyXjATv3oUNoPs0eF50JGf/0HZNu+
         1NUC07jKXD/KHlJcTyUC9OZ5jn7ICLs+qLtQrW/SHMzD+Y3qEXbzs2CthBxENhp8Qik3
         c0qQwVTgkcI/MNIBWBqtA/OQBsetYX07p88C+VRRUTbhHba99pYdp6cCNKvMf62/QmA3
         gS+Y+NksP3ZbDzx4HPBkbL5S1a5eMDhjqWB4IwgpXSvs6xqBNK6gDUrOYmfJNNfKcIpN
         mhwEjNPyi0aOkrIACGrwq3GlvKgwFFHm02LMzMKyxpK5xL2GtmIBln3C9f0D6NxSF00A
         2BTQ==
X-Gm-Message-State: AOJu0YzwfMo7WXFJx8jHPFxkk4yfYCAK6O5Z724EwCyQST3xQYTuAwvj
        KnV25faxf7J+4jnphZ/liGNB4w==
X-Google-Smtp-Source: AGHT+IF6ntKUJ2GHg1KNpDfnUqxnYmyCYICvCAZzypBZYOp69VCs6hqmt5KRSPpLD/BKeoB3vX8w8w==
X-Received: by 2002:a05:6512:31c6:b0:4fb:9105:58b0 with SMTP id j6-20020a05651231c600b004fb910558b0mr1480301lfe.20.1692348214162;
        Fri, 18 Aug 2023 01:43:34 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id g25-20020aa7d1d9000000b0052996528b81sm104966edp.45.2023.08.18.01.43.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 01:43:33 -0700 (PDT)
Message-ID: <6fb1176f-90f1-7a65-3ab5-f6447418c51e@linaro.org>
Date:   Fri, 18 Aug 2023 10:43:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 0/1] Add add-maintainer.py script
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_pkondeti@quicinc.com, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <cover.1691049436.git.quic_gurus@quicinc.com>
 <20230810185526.GC31860@quicinc.com>
 <4d94d0fd-72d4-0196-3a30-3e1efb9f5aca@linaro.org>
 <20230816171538.GB26279@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230816171538.GB26279@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 19:15, Guru Das Srinagesh wrote:
> Thanks for the comments, Krzysztof.
> 
> On Aug 15 2023 23:06, Krzysztof Kozlowski wrote:
>> On 10/08/2023 20:55, Guru Das Srinagesh wrote:
>>> On Aug 03 2023 01:23, Guru Das Srinagesh wrote:
>>>> When pushing patches to upstream, the `get_maintainer.pl` script is used to
>>>> determine whom to send the patches to. Instead of having to manually process
>>>> the output of the script, add a wrapper script to do that for you.
>>>>
>>>> The add-maintainer.py script adds maintainers (and mailing lists) to a patch,
>>>> editing it in-place.
>>>
>>> Could I request reviews from the other maintainers as well, please? Just to see
>>> if I should continue working on this script or if the `b4` tool obviates the
>>> need for such a script.
>>
>> I send a bit of patches but I use very simple workflow. It is really
>> simple, so simple, that I was always surprised how people can make their
>> life difficult with some complicated process to send patches... and then
>> obviously skip some maintainers, because of that process.
> 
> Exactly - this script aims to solve precisely that problem. It fills the gap
> between running `get_maintainers.pl` and having to manually edit its output to
> add "To: " and "Cc: " and somehow incorporate it in the body of the patch(es).

Why would anyone need to manually update it? Just some simple bash
function or git send-email identity.

> 
> With this script, the workflow would be as simple as:
> 
>   1. Generate patches using `git format-patch`
>   2. Run `add-maintainer.py` on the above patches
>   3. `git send-email` the patches.

So one more unnecessary step (2). I don't think it is easier than my
workflow.

I just do only 1 and 3 and that's it. The simplest way ever.

> 
> That's it - no need to manually work with email addresses.

No one suggested it...

>   
>> I almost always feed git send-email with addresses from
>> scripts/get_maintainers.pl. This tool would not bring any benefits to my
>> simple workflow.
> 
> In the light of the 3-step workflow I've envisioned above, could you please
> elaborate why not? If anything, it will only save a developer's time.

Because of unnecessary step 2? One more tool to remember to run?

> 
>> For newcomers, OTOH, I would either recommend simple workflow or just
>> use b4. Why? Because if you cannot use git-send-email, then it means
>> your email setup will make your life difficult and adding maintainers to
>> existing patch won't help you.
> 
> You've mentioned a "simple workflow" many times - could you please share more
> details on the steps you follow in your workflow for sending patches?

I shared it on LKML few times already (and Rob's git send-email identity
is also on LKML), so one more time:

https://github.com/krzk/tools/blob/master/linux/.bash_aliases_linux#L91


> 
>> This tool depends on the command line and shell interface of
>> scripts/get_maintainers.pl which is another reason why it might not be a
>> good idea.
> 
> Could you please elaborate on why depending on the output of
> `get_maintainer.pl` is a bad idea? It's what everyone uses, no?

No, because if interface changes you need to update two tools.

Best regards,
Krzysztof

