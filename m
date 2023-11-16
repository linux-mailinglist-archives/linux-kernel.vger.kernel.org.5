Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0872C7EDFE8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345074AbjKPLdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjKPLdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:33:37 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFAD85
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:33:34 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b44befac59so1414993b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700134413; x=1700739213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZnHHkx/zZWXPaN/v9k+BxDswHODU9mI/N0X97OmKL0c=;
        b=NcERFIqYJkvIsgr4Oo3Ydl5dhC0FZpk4TzOK5i1Dw/2F9nGMgyLEv3ZqjQjhWeG5al
         6zhruFH5b/fOqQbbvPXV6N5vXkdcaWKhjKuRQp53LImVgbAr/QD2WUm3iuX8MdYKjsb9
         O/bWvEPaiPbjlGgEfesbsSDemvUyaiArt6Q1nlWs1m5/kQz/u4aMZoTFiZepZD679zqa
         z2K75Mr9+nBe9MufGfL//mkbeLHnW7hiivDXjd+r64Oy6IWYzv3cjiEJlRlwTHQbWCyN
         Ty8YA7HVYV7hAjkHXFuojqttRgaxEMyJlnwtJ8bit4Z4pTzTGwyof0n2CYhox+mKW4Rt
         YZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700134413; x=1700739213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnHHkx/zZWXPaN/v9k+BxDswHODU9mI/N0X97OmKL0c=;
        b=D+VUnlA948q5CKHElHuPBOxd4nNbasCing8aD+IGRZVqp6C3OurTeRuOeE6vN2MgHf
         pcSDwdmbG1X1GMkhWNuOuw7y0SX1G6O8+0zgSO2FlNcm/NncY9kesuD7jceONn9m4cGr
         lTMvCPkZrJNy1dte6WCmeIu+hmrTa4Qv+YzWU+i9kDfxXCq6bzzAEBdCIx3hFZ8rt5sY
         LIJGV4jCTnw7C1mhwORnQplcc9wNH4uHD27B2ve9nDEWiVEuh2+s+uQsJFODlHArqO9b
         gW7ZY4lb7t0NQpn8VDwS9mH6m0UZbO/DtYPJ3+wGH90E0g3GMNiKXiKKYv8IsZEpes8Y
         iL9g==
X-Gm-Message-State: AOJu0Yxc5SARl/6Oc7OoeGAQGQvzksDiij0JPK9WDPhBsD1zyeRFtPuP
        4xXtkqMznKbrqLEOB9VqcNqLOuDSLjSTQA==
X-Google-Smtp-Source: AGHT+IFrpuu7gGw21Bj71FZsKRK0kvqmuw/gt+VSGB78uEAihi0+AneTDIUjkeisAUVV6oKimaBT6w==
X-Received: by 2002:a05:6a21:19a:b0:15c:b7ba:1671 with SMTP id le26-20020a056a21019a00b0015cb7ba1671mr2341964pzb.2.1700134413491;
        Thu, 16 Nov 2023 03:33:33 -0800 (PST)
Received: from [192.168.1.105] (111-255-239-171.dynamic-ip.hinet.net. [111.255.239.171])
        by smtp.gmail.com with ESMTPSA id g22-20020aa78196000000b006c4cf21489asm4286510pfi.205.2023.11.16.03.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 03:33:33 -0800 (PST)
Message-ID: <5932bbd6-afe7-416f-b590-c9f5c1c02db5@gmail.com>
Date:   Thu, 16 Nov 2023 19:33:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] sched/fair: Update min_vruntime in more relaxed way
Content-Language: en-US
To:     Abel Wu <wuyun.abel@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org
References: <20231116105425.84773-1-s921975628@gmail.com>
 <20231116105425.84773-2-s921975628@gmail.com>
 <377e0f71-80f9-4d83-a09d-e86bd61ce9ae@bytedance.com>
From:   Yiwei Lin <s921975628@gmail.com>
In-Reply-To: <377e0f71-80f9-4d83-a09d-e86bd61ce9ae@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/16/23 19:16, Abel Wu wrote:
> On 11/16/23 6:54 PM, Yiwei Lin Wrote:
>> As EEVDF adopts lag-based solution which is irrespective of
>> min_vruntime like CFS before, min_vruntime is only used as
>> an offset to avoid overflow on evaluation of avg_vruntime now.
>> Rely on the fact we will always update_curr() before change
>> to cfs_rq, it seems to make sense if we just
>> update_min_vruntime() with update_curr() to reduce the cost.
>>
>> Signed-off-by: Yiwei Lin <s921975628@gmail.com>
>> ---
>>   kernel/sched/fair.c | 20 +-------------------
>>   1 file changed, 1 insertion(+), 19 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 07f555857..5c40adfae 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -3815,17 +3815,8 @@ static void reweight_entity(struct cfs_rq 
>> *cfs_rq, struct sched_entity *se,
>>       enqueue_load_avg(cfs_rq, se);
>>       if (se->on_rq) {
>>           update_load_add(&cfs_rq->load, se->load.weight);
>> -        if (!curr) {
>> -            /*
>> -             * The entity's vruntime has been adjusted, so let's check
>> -             * whether the rq-wide min_vruntime needs updated too. 
>> Since
>> -             * the calculations above require stable min_vruntime 
>> rather
>> -             * than up-to-date one, we do the update at the end of the
>> -             * reweight process.
>> -             */
>> +        if (!curr)
>>               __enqueue_entity(cfs_rq, se);
>> -            update_min_vruntime(cfs_rq);
>> -        }
>>       }
>>   }
>>   @@ -5347,15 +5338,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct 
>> sched_entity *se, int flags)
>>         update_cfs_group(se);
>>   -    /*
>> -     * Now advance min_vruntime if @se was the entity holding it back,
>> -     * except when: DEQUEUE_SAVE && !DEQUEUE_MOVE, in this case 
>> we'll be
>> -     * put back on, and if we advance min_vruntime, we'll be placed 
>> back
>> -     * further than we started -- ie. we'll be penalized.
>> -     */
>> -    if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
>> -        update_min_vruntime(cfs_rq);
>> -
>>       if (cfs_rq->nr_running == 0)
>>           update_idle_cfs_rq_clock_pelt(cfs_rq);
>>   }
>
> For now, core pick of core scheduling relies on min_vruntime to be fresh,
> so please just fix commit eab03c23c2a1 to preserve its original behavior
> by moving update_min_vruntime() to proper position. And behavior change
> can be posted separated.

Sorry for not noticing the requirement on core scheduling and applying 
bad solution. I should take a closer look for the influence when 
changing the approach to update_min_vruntime().

I'll send another patch which just move update_min_vruntime() to the 
right place later on.

>
> BTW it seems unnecessary to include a cover-letter for a single patch.
>
Got it! Still learning how to work with the kernel mailing list. Thanks 
for the kind suggestion!
> Thanks,
>     Abel

