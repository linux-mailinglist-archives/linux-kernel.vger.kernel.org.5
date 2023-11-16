Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9657EDBCC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbjKPHLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjKPHLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:11:24 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E0D192
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 23:11:16 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2806cbd43b8so335179a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 23:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700118675; x=1700723475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mA9iboiAyXV3dWlM8+BWCGvRgom1QhuQa9XC12KZvSU=;
        b=Jwp7lkP0CQFnndyaSvNYJ4BgqjBXkmQPTYYSAsy7E86wA1XUO7OCZWUeL2OU0+CbrD
         LngKyKKBMAAD8jsUNuOoO/Sdy8kP7tv+/JtNf8aWiNMxMdy/mwkP8D7kKYVlOtnDaniy
         9gNWvnUkbYLl8jKqu6QBN7tH1awP+Oz/U7RfohBLya63mYAKxxrnQrS3vJPos4Kt1/j8
         tXEWj+Eba7zjU8FMWqwFiLmZWSCmvOV1dHHM50HXvrSDe/d7cc+PAuUmXE4J4XedOTwL
         EB0FDhQ4th2i7cYMoLXy3y2Cyd/Y4p0FvhMaDairo4ECGCimOBg5bKU8rbA6zZq7A2gA
         W+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700118675; x=1700723475;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mA9iboiAyXV3dWlM8+BWCGvRgom1QhuQa9XC12KZvSU=;
        b=WKe3rcQxIfuzjh6cRFS9zioJ7SaY3oRCjcvnsntko4MjqC6txzOfpH8mb4G8rHz+3a
         S3WCvk5MIqyBRxh2ZUAUOTWX/wUEldPeucDB9K/dYT1tXirbbrP48XX95bZN1EpTsbTi
         ypGBQBrlwiTpWNBey/GldJ7chX2nAmxS7spaJMgKDSvJbHGCG7unolPpoD4pjaeVQuz6
         MCRtI7Tm4BGl/c+TYQeV+Tstahcb8EZ3ZgDahXQpx+NXkKjun7e18S08vckA7vdcT8c9
         o4sCHOAZE3BZRCj6TOYby4SqAWyF1SDQOo+zeplzs83Q9sPyVKNK5nvqSwfXJtv6ADX1
         dBXg==
X-Gm-Message-State: AOJu0YxgYyA956Wugx/Lr63ogfzaWhqSbCY2yDoUeOM+ZBNF4O+LBp8Q
        CScYLu7xxFQYJ7QGXzF40IvaBQ==
X-Google-Smtp-Source: AGHT+IFg0n9FXTnhKUEGX2h2DnL4okaS/BS57C5yRPRgdCKpm4sgFPYH33SbggcN8rDD7mv4HjG5cg==
X-Received: by 2002:a17:90b:1646:b0:25e:a8ab:9157 with SMTP id il6-20020a17090b164600b0025ea8ab9157mr16165716pjb.22.1700118675452;
        Wed, 15 Nov 2023 23:11:15 -0800 (PST)
Received: from [10.254.46.51] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id lm14-20020a17090b334e00b002630c9d78aasm934271pjb.5.2023.11.15.23.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 23:11:14 -0800 (PST)
Message-ID: <7f179261-72a7-41d9-aa79-6ba8cc3c4286@bytedance.com>
Date:   Thu, 16 Nov 2023 15:11:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH 1/4] sched/eevdf: Fix vruntime adjustment on reweight
Content-Language: en-US
To:     Yiwei Lin <s921975628@gmail.com>
Cc:     Barry Song <21cnbao@gmail.com>,
        Benjamin Segall <bsegall@google.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Mike Galbraith <efault@gmx.de>,
        Qais Yousef <qyousef@layalina.io>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Youssef Esmat <youssefesmat@chromium.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
References: <20231107090510.71322-1-wuyun.abel@bytedance.com>
 <20231107090510.71322-2-wuyun.abel@bytedance.com>
 <da42f1d7-adfe-485e-987e-3e8dae78b4c2@gmail.com>
 <23cebdf8-1a51-481e-a8c2-e17021099e05@bytedance.com>
 <19c6accf-1cc0-489d-9c82-e0ddf982b098@bytedance.com>
 <446aeb22-55c4-4ef6-81cc-1d1d994d5268@gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <446aeb22-55c4-4ef6-81cc-1d1d994d5268@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/23 2:51 PM, Yiwei Lin Wrote:
> 
> On 11/16/23 13:07, Abel Wu wrote:
>> On 11/16/23 12:48 PM, Abel Wu Wrote:
>>> On 11/15/23 11:36 PM, Yiwei Lin Wrote:
>>>>
>>>>> @@ -3712,8 +3811,17 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>>>>>       enqueue_load_avg(cfs_rq, se);
>>>>>       if (se->on_rq) {
>>>>>           update_load_add(&cfs_rq->load, se->load.weight);
>>>>> -        if (cfs_rq->curr != se)
>>>>> -            avg_vruntime_add(cfs_rq, se);
>>>>> +        if (!curr) {
>>>>> +            /*
>>>>> +             * The entity's vruntime has been adjusted, so let's check
>>>>> +             * whether the rq-wide min_vruntime needs updated too. Since
>>>>> +             * the calculations above require stable min_vruntime rather
>>>>> +             * than up-to-date one, we do the update at the end of the
>>>>> +             * reweight process.
>>>>> +             */
>>>>> +            __enqueue_entity(cfs_rq, se);
>>>>> +            update_min_vruntime(cfs_rq);
>>>>> +        }
>>>>>       }
>>>>>   }
>>>> Sorry if I am asking stupid question...... It looks like reweight_entity() may have chance to change the weight of cfs_rq->curr entity, but we'll never update_min_vruntime() when reweighting it. Is there any reason that we can skip the update_min_vruntime() for this case?
>>>
>>> No, you are right!
>>
>> I was intended to update_min_vruntime() if se->on_rq and no matter
>> it is curr or not, just as you suggested. But after a second thought
>> I wonder if it is necessary to update *NOW*, since we will always
>> update_curr() before making any change to cfs_rq. Thoughts?
> I lost the fact that we'll update_min_vruntime() every time we update_curr(). Because of this fact, we can indeed wait until we need the correct min_vruntime and update_min_vruntime() then. The only consideration that I came up with is that the sched_debug may not be able to reflect the accurate min_vruntime in time. But this may not be a big problem.
> 
> Further, I have another advanced thought we can remove the update_min_vruntime() here in the reweight_entity() directly to save more time. The reason that I think this is because min_vruntime is not for normalization of vruntime as before which is required on CFS, so we will always update_curr() for the latest min_vruntime before using it. Also, the update_min_vruntime() in dequeue_entity() may also be removed as the reason, i.e. just do update_min_vruntime() in update_curr() to simplify. What do you think?

Yes, this is also exactly what I am thinking about. As task placement
now adopts lag-based solution which is irrespective of min_vruntime,
and also based on the fact that it is only used as a base offset for
calculating avg_vruntime (in order to avoid overflow), we probably
can update it in a more relaxed way e.g. in ticks. If relaxed update
works, there seems still work to be done first:

   1) the priority of core pick when core scheduling needs to change
      to deadline-based solution;
   2) need to make sure not overflow in NOHZ_FULL mode

Just some first thoughts come into my mind :)

Thanks,
	Abel
