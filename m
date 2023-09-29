Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D887B31A9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 13:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjI2Lpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 07:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbjI2Lp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 07:45:27 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BED2171E
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 04:45:11 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-405417465aaso133452265e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 04:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695987909; x=1696592709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8bm0ODN6EVFxISuZSf0X5YLAHe/Sx50i0t5BgX3iJIc=;
        b=cbB1yLE9KkVRmubK79T2H08A2jl7COb6+3G1RKcvP0psSvm+VtTHQM4lv9bbxK3f3T
         JdajpYNusJ06KE50fhdgfk4CCTrD7DVzqJjW8cRz0LoGkBeJebBstuCMo2/Egk/xd8vs
         ype7XbQR0m6wRCabharm6hPJv7z7GfX7J+QnaIGZSDr3+jrnQ2uCV8IVk9qXzmSa/o1X
         /R4+89a+g/LxapVYC0dhMquMR0AidkVl/SP3xWR2vzDHd4XsPFPWl91575Oljqcsmzyb
         TKVV1EHC8uvBOMmJFvMf1yeHjUueKTAYYDb1JsfcByPBTK4U1WQCZ9iojyrjPlp7nkhR
         DElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695987909; x=1696592709;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bm0ODN6EVFxISuZSf0X5YLAHe/Sx50i0t5BgX3iJIc=;
        b=UPU9tKT8LW0mv4w8/kVaGl0fvXR/s0eW5rwH88bLFXxQ5a/nn8BdMZQfDBhWSxfKeJ
         XryMwZKrkiMYcWEwrh1paQnaEcJ1XO8WgKv1kTiro/Nkc9YDGCTBdNNC4R3bFFNV77Z1
         6rY4gAJXobbhzM8cEHTWYbbm/PpnXn0QczJkbb4NC5OWi/pk7t2SOPaX5Y8lTjumkr99
         kyrW2ZJnt8LdvKVOTvQJ6/URg5n8jjjusMwgk9PAHUyE74CFTdYeUri5wbDr6eMm/26I
         K+p9souk7m9IlHaTRwICy9+/OOBCI8PHTnnIa9G276/qfY52vLG6xi6TKi0SHjwoDdbI
         FY8w==
X-Gm-Message-State: AOJu0YwtLDAzj3BD7Wg6GSKgnsBletbpapKaID5dVTeIrO+c4a6FbylV
        CjVgHuYnWgXFnzjrLZiBqmbo3A==
X-Google-Smtp-Source: AGHT+IHsIEssfQt5XeKAofIU/RxmZVpToDfthUbKqwTlh2dGt/cky4WWeS6zIlGKK/dVFRr9l5w41Q==
X-Received: by 2002:a1c:4c03:0:b0:405:7400:1e42 with SMTP id z3-20020a1c4c03000000b0040574001e42mr3462853wmf.41.1695987909197;
        Fri, 29 Sep 2023 04:45:09 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id s22-20020a7bc396000000b003fee53feab5sm1267451wmj.10.2023.09.29.04.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 04:45:08 -0700 (PDT)
Message-ID: <10e6377e-ab3f-c318-9860-56ff3b8aed92@linaro.org>
Date:   Fri, 29 Sep 2023 13:45:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/7] thermal: exynos: simplify regulator
 (de)initialization
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        m.majewski2@samsung.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <a6f943be-a92f-f9ec-4103-7edc70a2c9a8@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2023 13:03, Marek Szyprowski wrote:
> On 29.09.2023 12:46, Daniel Lezcano wrote:
>> On 26/09/2023 13:02, Mateusz Majewski wrote:
>>> Hi,
>>>
>>>> This is not equivalent. If regulator is provided and enable fails, the
>>>> old code is nicely returning error. Now, it will print misleading
>>>> message - failed to get regulator - and continue.
>>>>
>>>> While this simplifies the code, it ignores important running
>>>> condition -
>>>> having regulator enabled.
>>>
>>> Would doing this be correct?
>>>
>>> ret = devm_regulator_get_enable_optional(&pdev->dev, "vtmu");
>>> switch (ret) {
>>> case 0:
>>> case -ENODEV:
>>
>> Not sure to understand why -NODEV is not an error
> 
> 
> Because this what devm_regulator_get_enable_optional() returns if no
> regulator is defined. I also got confused by this a few times.

The code before this change calls devm_regulator_get_optional() which 
returns -ENODEV too, right ? But there is no special case for this error.

So this change uses devm_regulator_get_enable_optional() and handle the 
ENODEV as a non-error, so there is a change in the behavior.


>>>      break;
>>> case -EPROBE_DEFER:
>>>      return -EPROBE_DEFER;
>>> default:
>>>      dev_err(&pdev->dev, "Failed to get enabled regulator: %d\n",
>>>          ret);
>>>      return ret;
>>> }
>>
>> ret = devm_regulator_get_enable_optional(&pdev->dev, "vtmu");
>> if (ret < 0) {
>>      if (ret != EPROBE_DEFER)
>>          dev_err(&pdev->dev, "Failed to get enabled regulator: %d\n",
>> ret);
>>      return ret;
>> }
>>
>> ??
>>
> Best regards

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

