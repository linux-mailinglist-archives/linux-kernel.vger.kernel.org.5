Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DCE7EDBAB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 07:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjKPGvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 01:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjKPGvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 01:51:37 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907B5130
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 22:51:34 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc3bb32b5dso4506885ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 22:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700117494; x=1700722294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MeRDN0+BzEJDhzSTXzv3THJfG/m7lmaKGuoDAqx8pdw=;
        b=Ml6N1yTp3XfzCPxfdDkpONdud49NVVbQeuHQz/OVcq4rQ89gxdicFtzCWxV3wDq1XG
         LTdPdvRkT8TN3LLv6dI5R8/rXWy2SITUGZo2jxoEUoP2rbAgmmDfQkgcBeoT5EPtYtuT
         efWPWpho2BP+mOlg5YNtDmxoFKphPtJVp4V85XUmfOSP47pjZte5KIFrAgSfpvDv/StZ
         YqJhm/11WE3uUnL0RYO9xaweSk5oQM1LSHL5h58TTiugQn2CzBjNMmukW9Tpt40b/b2v
         ltZqqKu/6bmQO8v0GXTJNWb1FyEaBj4L8ZKFg4nyMp0Jh6+bEA4rxNx6/13okBQMnTYG
         yYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700117494; x=1700722294;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MeRDN0+BzEJDhzSTXzv3THJfG/m7lmaKGuoDAqx8pdw=;
        b=fnDVy2C8c/UXac2JhyQguEYd4aLYXYhGO/UK7jMvJQ8b+Fwrl0fteipGT1AvPFg7i0
         O5Dd60KxxxzcMudLEUZsFCNJ4veyXDErnVkgi1NfNT83BFFtlgUtnn+gfv/NqrAYGfYM
         BZUvJJChuyw/nMA5wfQe7aA9/sXsAhUowCPQBT/2Y16VoVaLB4fEkuX8gjJCMcUbdbq6
         3023AhJsboPZoj3juQW5TyBfepCvUt90so9dwLkRs2IdC4Kv79vwWbG1LIQtA/S2lTRy
         AoS4a7zIvKWxPmQ3vpb2eq8fwaT2KowYOynRaSVXK+KsAwOB23glwOWo4rOW7x4HwgW9
         wJAg==
X-Gm-Message-State: AOJu0Yxp9eAlmMM9R3UFykQjEq63MkLTVT3BFoMW5uSj+IKJYh1mkvrx
        mtti4ImsyMXJrXLLHiIKKUI=
X-Google-Smtp-Source: AGHT+IENJaDdO5ijmKXNE1qvEI8UTn4J9g23ELWygk6g8LI1d3sWNpOKICmIfh0I7qGfBlsfQiPlIA==
X-Received: by 2002:a17:902:e88e:b0:1c2:1068:1f4f with SMTP id w14-20020a170902e88e00b001c210681f4fmr8580678plg.17.1700117493905;
        Wed, 15 Nov 2023 22:51:33 -0800 (PST)
Received: from [192.168.1.105] (111-255-239-171.dynamic-ip.hinet.net. [111.255.239.171])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b001b3bf8001a9sm8474771plg.48.2023.11.15.22.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 22:51:33 -0800 (PST)
Message-ID: <446aeb22-55c4-4ef6-81cc-1d1d994d5268@gmail.com>
Date:   Thu, 16 Nov 2023 14:51:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] sched/eevdf: Fix vruntime adjustment on reweight
Content-Language: en-US
To:     Abel Wu <wuyun.abel@bytedance.com>
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
From:   Yiwei Lin <s921975628@gmail.com>
In-Reply-To: <19c6accf-1cc0-489d-9c82-e0ddf982b098@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/16/23 13:07, Abel Wu wrote:
> On 11/16/23 12:48 PM, Abel Wu Wrote:
>> On 11/15/23 11:36 PM, Yiwei Lin Wrote:
>>>
>>>> @@ -3712,8 +3811,17 @@ static void reweight_entity(struct cfs_rq 
>>>> *cfs_rq, struct sched_entity *se,
>>>>       enqueue_load_avg(cfs_rq, se);
>>>>       if (se->on_rq) {
>>>>           update_load_add(&cfs_rq->load, se->load.weight);
>>>> -        if (cfs_rq->curr != se)
>>>> -            avg_vruntime_add(cfs_rq, se);
>>>> +        if (!curr) {
>>>> +            /*
>>>> +             * The entity's vruntime has been adjusted, so let's 
>>>> check
>>>> +             * whether the rq-wide min_vruntime needs updated too. 
>>>> Since
>>>> +             * the calculations above require stable min_vruntime 
>>>> rather
>>>> +             * than up-to-date one, we do the update at the end of 
>>>> the
>>>> +             * reweight process.
>>>> +             */
>>>> +            __enqueue_entity(cfs_rq, se);
>>>> +            update_min_vruntime(cfs_rq);
>>>> +        }
>>>>       }
>>>>   }
>>> Sorry if I am asking stupid question...... It looks like 
>>> reweight_entity() may have chance to change the weight of 
>>> cfs_rq->curr entity, but we'll never update_min_vruntime() when 
>>> reweighting it. Is there any reason that we can skip the 
>>> update_min_vruntime() for this case?
>>
>> No, you are right!
>
> I was intended to update_min_vruntime() if se->on_rq and no matter
> it is curr or not, just as you suggested. But after a second thought
> I wonder if it is necessary to update *NOW*, since we will always
> update_curr() before making any change to cfs_rq. Thoughts?
I lost the fact that we'll update_min_vruntime() every time we 
update_curr(). Because of this fact, we can indeed wait until we need 
the correct min_vruntime and update_min_vruntime() then. The only 
consideration that I came up with is that the sched_debug may not be 
able to reflect the accurate min_vruntime in time. But this may not be a 
big problem.

Further, I have another advanced thought we can remove the 
update_min_vruntime() here in the reweight_entity() directly to save 
more time. The reason that I think this is because min_vruntime is not 
for normalization of vruntime as before which is required on CFS, so we 
will always update_curr() for the latest min_vruntime before using it. 
Also, the update_min_vruntime() in dequeue_entity() may also be removed 
as the reason, i.e. just do update_min_vruntime() in update_curr() to 
simplify. What do you think?

Thanks,
Yiwei Lin

