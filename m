Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5492C7EDD3D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbjKPJBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbjKPJBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:01:39 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CED1A3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:01:11 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so489046b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700125271; x=1700730071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PPENwY+RzNW6fAhXnQjBMIY6rHdSo45qA+Xh3DfXQ6g=;
        b=DR3KZIY2w0MA6UdZlQ5VNTo0bqFhPW4JBBQdd0GO8L1XLmSUAWl5HlezTuK8wfJDJm
         /OKS/RlT/jmU5lEie8FO129qvlfMGYZ2zHnPhe/bzU9I7FA8JE301Ox8FsLKnkVvuEBV
         kiQ0SYgR8LSLWluLzYGoJEgF93TTqQaEArT/h5TMg7nAWdPEeY/3PTzaiCpDKRF5F2uC
         /U+tvBG7RbGMhIp8lmGwQHgZ2LfCOE/kMJ589jHMHdxNiRDhLr0M/82/WvF1iB1raQXS
         Ktu8xX/tvG48ShXd8UnzSzr44GJmMo2Wbpk7AXhwy7da9sV7UIrF2SY7JMP3NOsfGV3X
         aYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700125271; x=1700730071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPENwY+RzNW6fAhXnQjBMIY6rHdSo45qA+Xh3DfXQ6g=;
        b=uLdsJx8FJ8j+FOsw4uXKgGAkHW6qTvxuk8ec4QdPg4EgYJnSt6jZaot1+lRgsOPvIo
         pFQDHv+Goso/gS6RSHxnv8zD8vcsOqyPlVnZxevXsLGx+M/zKXUbWRJ6gF7Q6LC773Kn
         AamqvhGmJOsKeigIxfpzCCe4AsfD9FMbUDE0w9gJRxeA9Gqbm01TOfjUGkFaSV2qEi+0
         AeUoeY7pUggsWigDZ7HtgCN3p6zu6vuuhotGLfLI+udldSZx4PT6HJ0i83ahP9Y1viip
         rHEpWyAL667uR4G3w3a4lnwgrq5C08/+LeICSsHOY2fPYy9/l45rmYmBthKhOZnxOXQP
         UE+Q==
X-Gm-Message-State: AOJu0YyMurPycIPJrZlECdEn5IGM89WoUEkmg7DsFzu20YjMtcl8MNcY
        8+//yBxcMBCCgbZ8u7lr0qP5Jd+Lu6aFSAVMpK4=
X-Google-Smtp-Source: AGHT+IEC4WPAlZTGYFBvhn8SfMpjxr8hH/3HaBFozJ/8eJdNLWWY5B5Suc5jvJCinTCobJT914AiHA==
X-Received: by 2002:a05:6a20:a303:b0:187:517a:ff3f with SMTP id x3-20020a056a20a30300b00187517aff3fmr3868648pzk.11.1700125271096;
        Thu, 16 Nov 2023 01:01:11 -0800 (PST)
Received: from [10.254.46.51] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id i3-20020aa787c3000000b006c3467ae25asm4032769pfo.206.2023.11.16.01.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 01:01:10 -0800 (PST)
Message-ID: <236e122b-a24b-4eb9-865e-a54979a3f0c0@bytedance.com>
Date:   Thu, 16 Nov 2023 17:01:02 +0800
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
 <4d6f0382-0012-4b22-9e9a-c659615dbad1@gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <4d6f0382-0012-4b22-9e9a-c659615dbad1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/23 12:59 PM, Yiwei Lin Wrote:
> 
> On 11/16/23 12:48, Abel Wu wrote:
>> On 11/15/23 11:36 PM, Yiwei Lin Wrote:
>>>
>>>> @@ -3712,8 +3811,17 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>>>>       enqueue_load_avg(cfs_rq, se);
>>>>       if (se->on_rq) {
>>>>           update_load_add(&cfs_rq->load, se->load.weight);
>>>> -        if (cfs_rq->curr != se)
>>>> -            avg_vruntime_add(cfs_rq, se);
>>>> +        if (!curr) {
>>>> +            /*
>>>> +             * The entity's vruntime has been adjusted, so let's check
>>>> +             * whether the rq-wide min_vruntime needs updated too. Since
>>>> +             * the calculations above require stable min_vruntime rather
>>>> +             * than up-to-date one, we do the update at the end of the
>>>> +             * reweight process.
>>>> +             */
>>>> +            __enqueue_entity(cfs_rq, se);
>>>> +            update_min_vruntime(cfs_rq);
>>>> +        }
>>>>       }
>>>>   }
>>> Sorry if I am asking stupid question...... It looks like reweight_entity() may have chance to change the weight of cfs_rq->curr entity, but we'll never update_min_vruntime() when reweighting it. Is there any reason that we can skip the update_min_vruntime() for this case?
>>
>> No, you are right!
>>
>> Thanks!
>>     Abel
> Thank you! I'll take the responsibility to fix this.

That would be appreciated. I suggest fixing this before we
do further optimizations.

Thanks,
	Abel
