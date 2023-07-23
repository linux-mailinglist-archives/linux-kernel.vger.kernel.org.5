Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7436175E129
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 12:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjGWKRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 06:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWKRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 06:17:32 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E3612F
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 03:17:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbca8935bfso26135195e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 03:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690107449; x=1690712249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G9bizb2XUBHywNQ7OsFuDywmc/SZSAKRG7HN4IcLmxA=;
        b=m24HZMH7N13lRaOv5+b9dQidpC9uy3119QSO4PCp2b/m6+hXwqvQ7jPMFHXOmkj9ts
         TzMW1Yu46FjlE6yn1eOJqSqntfWnPUbNSIQX/7ZXWZ4mjjkbFBoFXJ21aSHAmpY4BFoo
         EQl2X49dqkT4GA5yFDoPHXtJN8+L+6Ysd243ij7VDjcvI+r+gteX+q2+/vFSSpTiaoCS
         JR6r7rdB0uxqIAC/MYsBicf80X3QG92XkdBLAMkfz7PaWKiuY68jVPZ4/uf5654ZgUDj
         Q39juTJMrZkfFt9a/OGS+Y/JsEwcvAndxpncQQFfAxgHsyw2ejsNHDad6IeHiiKzlRyn
         dCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690107449; x=1690712249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9bizb2XUBHywNQ7OsFuDywmc/SZSAKRG7HN4IcLmxA=;
        b=Tx6cpsdnPZ8zEQZtGHh1+es8h/quvfBiGWiU/u6CKBBmNwqXA0eBwRxp5crOcIQqKx
         Oqew6Pt6lqMwusdCUhRCxoVAssIvBZdal4qXbaFux85ikqZDNveWppfEZGwo6Koj2Ajr
         CCyvMhQy5DPHAruEz+lacMTMI3HQ2TVz5lnQNDzuBCQGaIJsIsEkG9M/FJmGDWk5jvn6
         tp6n1gaAfkoMeA1NgP/AeycWdYPQgAgPMWkVYc3oDxRNQZf1Pp1jTGKVtka38ICIqr/E
         27djVILzMCuQxzf2EJn2U/gAQQmrIoCx2lysQmv6oZNVF2x0puJVGy9+1yDNKVlmFzCr
         KFeA==
X-Gm-Message-State: ABy/qLb5siA3axicRZnBv5/nozvWZP8CaaMfGNMT53iy+S91YUxAGZIM
        XzLwIKJ5lK5Ld4QAYLjG+M/fRQ==
X-Google-Smtp-Source: APBJJlFljllVDRV4zSU98uny4rzyJPJfcQknRSy2KfrcGhNrDXhlnkPeB3obyiKeYnJqpyP75u5rDw==
X-Received: by 2002:a05:600c:210d:b0:3fb:4055:1ddd with SMTP id u13-20020a05600c210d00b003fb40551dddmr4567872wml.28.1690107449150;
        Sun, 23 Jul 2023 03:17:29 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bh17-20020a05600c3d1100b003fbb1ce274fsm25898354wmb.0.2023.07.23.03.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jul 2023 03:17:28 -0700 (PDT)
Message-ID: <c0f1d7b9-5923-75d6-cb57-bb4bd4635cd7@linaro.org>
Date:   Sun, 23 Jul 2023 12:17:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] thermal/drivers/mediatek: fix a regression affecting
 other subsystems
Content-Language: en-US
To:     Icenowy Zheng <uwu@icenowy.me>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kang Chen <void0red@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230529162056.3786301-1-uwu@icenowy.me>
 <40546a57-27ac-8bf9-a2d8-77f7d4ab4aad@linaro.org>
 <05e6d2d6dd8805c4cded28f85ac873b96bc1467e.camel@icenowy.me>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <05e6d2d6dd8805c4cded28f85ac873b96bc1467e.camel@icenowy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2023 14:13, Icenowy Zheng wrote:
> 在 2023-06-13星期二的 10:44 +0200，Daniel Lezcano写道：
>> On 29/05/2023 18:20, Icenowy Zheng wrote:
>>> In the commit I reverted as the first commit of this patchset, the
>>> of_iomap function call, which allows multiple mapping of the same
>>> physical memory space, is replaced to calling devm_of_iomap, which
>>> registers exclusivity, and on my system (mt8173-elm), preventing
>>> display
>>> from working.
>>>
>>> So I reverted it, and to really solve the problem that the original
>>> commit wants to solve, I read the source of auxadc-thermal and
>>> realized
>>> that the address of these two memory blocks are not saved after
>>> probe,
>>> and they're only used when initializing the thermal sensors. This
>>> leads
>>> to my final fix, which is the second commit here, that adds
>>> of_iounmap
>>> just to the probe function.
>>>
>>> Icenowy Zheng (2):
>>>     Revert "thermal/drivers/mediatek: Use devm_of_iomap to avoid
>>> resource
>>>       leak in mtk_thermal_probe"
>>>     thermal/drivers/mediatek: unmap foreign MMIO after probing
>>>
>>>    drivers/thermal/mediatek/auxadc_thermal.c | 46 ++++++++++++------
>>> -----
>>>    1 file changed, 24 insertions(+), 22 deletions(-)
>>
>> I'll apply only the revert and let you revisit the patch 2 which
>> could
>> be improved.
> 
> Sorry, is the first patch applied? I didn't see it in any kernel
> trees...

Yes, sorry, I got another patch meanwhile which provided the same revert 
with more tags

https://lore.kernel.org/r/20230525121811.3360268-1-ricardo.canuelo@collabora.com


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

