Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829717B64F9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239489AbjJCJGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239477AbjJCJGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:06:08 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E11FAC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:06:04 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5362bcc7026so1041000a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 02:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696323963; x=1696928763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yTn3D6znwaCBRUiGNETpplkhBo7JdWjGGXiqyWYcpRY=;
        b=dB00IByxelr8I0TQ+SlfL/zcGz7pvnvf/z3AFkZRagSvngaUCY9P3EP9oBeAHxNCVN
         P3QlxtscZrj9HT4s4q0FJ/f/fEH4NXoBZCy/h+cMBU/VMv9WQkuYv2Lrmt4Fo3pokCIk
         4U4Kw+NLgcP5Tgr+JhKjxNETXAXxaobu90M69kjXnqE7LsUUZ/Hc+09SSeIUGELv3y93
         +eaZGGfw+9UabcTP5j9PqN6jDLt6AYaSgpPt5vsSfQ2weEPZ7wuaVxE26Y/WF47nd59K
         zKEzF0ZayDrXdtsFDTiyLlXi+7wyQkvXYMK0WndiOt2rCBsSyxyuaKi/eWFi7vNwfZIG
         ofFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696323963; x=1696928763;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yTn3D6znwaCBRUiGNETpplkhBo7JdWjGGXiqyWYcpRY=;
        b=dmahqs1WChuIon7qtFsJPZhH5j33DrPgVtuI/0N7IXLDZbp3ofMedWAyYLJiLvbVsv
         TCo09t38IJDw6oYndtncgHEAYR+PePFORRexpBLH4Gzc+Uqc1fX6rwKaNQ5+RN7P7Pzm
         m9ojfTwXOq2jLQIIxvng+6ns9eQwdwsjCqE3FS6u4STOa55CyBzl/Gvi1v7T4O2IWedP
         Uf9gGeC06sU5K9jnLeiQGk8nciCrztHm0CkMeg9gYiDaiU2nLIJehrSyYHgFx4Z67jP3
         3L6bsd7PdE+s4oRndCWzuE6ya8PfK3lEPSmU5asRXCoLMAD32aADAGJKw2NqkOxjf7MU
         Tbgg==
X-Gm-Message-State: AOJu0YwXGew3eaoo6xiMUnCOvm1CBiYQHJaSckTeFYFEchh5HiIw67So
        Ufk4hmsHIWAqmjKLcVg5LCH00Q==
X-Google-Smtp-Source: AGHT+IG3WBtRtTk9mAInS4n1ptJJuNmHc7Y6kJeSwHHKSDILPqaOyieoUgi9z1ravG8PuW/F1IZzNw==
X-Received: by 2002:aa7:c584:0:b0:530:a226:1f25 with SMTP id g4-20020aa7c584000000b00530a2261f25mr11151740edq.17.1696323962742;
        Tue, 03 Oct 2023 02:06:02 -0700 (PDT)
Received: from [192.168.1.197] (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id j15-20020a50ed0f000000b0052ffc2e82f1sm545005eds.4.2023.10.03.02.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 02:06:02 -0700 (PDT)
Message-ID: <8f139c6e-78e1-4804-bbd5-f598bba9908d@linaro.org>
Date:   Tue, 3 Oct 2023 11:06:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] thermal: exynos: simplify regulator
 (de)initialization
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        m.majewski2@samsung.com,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
References: <bf9a07ff-5628-05ab-2362-a917d3d38313@linaro.org>
 <20230911133435.14061-1-m.majewski2@samsung.com>
 <20230911133435.14061-5-m.majewski2@samsung.com>
 <CGME20230911133616eucas1p10c5eeb0f0240dde975ccc5935cb5c311@eucms1p2>
 <20230926110239eucms1p2b539245c5b10591def4cd15f14896ad6@eucms1p2>
 <67a7d507-7025-ee3e-f388-0a96e11eae41@linaro.org>
 <a6f943be-a92f-f9ec-4103-7edc70a2c9a8@samsung.com>
 <10e6377e-ab3f-c318-9860-56ff3b8aed92@linaro.org>
 <2e688177-7a69-051f-2d2c-c8067c38f3be@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <2e688177-7a69-051f-2d2c-c8067c38f3be@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2023 14:00, Marek Szyprowski wrote:
> On 29.09.2023 13:45, Daniel Lezcano wrote:
>> On 29/09/2023 13:03, Marek Szyprowski wrote:
>>> On 29.09.2023 12:46, Daniel Lezcano wrote:
>>>> On 26/09/2023 13:02, Mateusz Majewski wrote:
>>>>> Hi,
>>>>>
>>>>>> This is not equivalent. If regulator is provided and enable fails, 
>>>>>> the
>>>>>> old code is nicely returning error. Now, it will print misleading
>>>>>> message - failed to get regulator - and continue.
>>>>>>
>>>>>> While this simplifies the code, it ignores important running
>>>>>> condition -
>>>>>> having regulator enabled.
>>>>>
>>>>> Would doing this be correct?
>>>>>
>>>>> ret = devm_regulator_get_enable_optional(&pdev->dev, "vtmu");
>>>>> switch (ret) {
>>>>> case 0:
>>>>> case -ENODEV:
>>>>
>>>> Not sure to understand why -NODEV is not an error
>>>
>>>
>>> Because this what devm_regulator_get_enable_optional() returns if no
>>> regulator is defined. I also got confused by this a few times.
>>
>> The code before this change calls devm_regulator_get_optional() which 
>> returns -ENODEV too, right ? But there is no special case for this error.
>>
>> So this change uses devm_regulator_get_enable_optional() and handle 
>> the ENODEV as a non-error, so there is a change in the behavior.
> 
> 
> It looks that the original code ignores any non-EPROBE_DEFER errors from 
> devm_regulator_get_optional(). That's a bug, indeed.

How about separate change fixing it? I know the same code will be
changed twice, but it will be easier to backport and analyze in case of
issues.

Best regards,
Krzysztof

