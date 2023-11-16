Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71FF7EDAFD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 06:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjKPFAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 00:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjKPFAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 00:00:08 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF02B4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 21:00:03 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6c4884521f6so371274b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 21:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700110803; x=1700715603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+CcNNmY3Dtn0Exoh8rKHqvCaj6fNssS432Vz47jLZwM=;
        b=E/hpds43EzUFs2HlTxKUIEUq5W2JwIrR3JwdeAsmbwviscGh2eicIjcQYIq6w2CrBz
         VUd2TfQ9iBKOFNKdMOD0BcilWyMTGdr7QlAalflkxhwYy5R7nzHWWQc8vXuEj3OWVgzv
         hUdZnEZnIrrcOcORAYNy3UFT12NLyAvHojHs4JoEL017jxQPfxMoYL2KISKinHJ49zpO
         u360m6OcCGTDhzCm3LHb5PzSA4B4B2PsS0B+Ta86M133C4bWOgcMjbnhvXlVICPI0GRE
         oUtK4mEbV4sN5nRF/CMbIeJoVaYTwHotsAitZoh/O8vERnRC1sPj+RbavOSK6u25cIK9
         wYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700110803; x=1700715603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+CcNNmY3Dtn0Exoh8rKHqvCaj6fNssS432Vz47jLZwM=;
        b=AXrnjeJZzi6hg22E8ol4q6LNBq/J90q6oBIN8wLZH7krsQKmYBE5CCFthI6D1LsbkT
         PDKvGNEHN0n6BMEJVZZrXs7DROYnn2BVTOMGW4m/xZLV7i/b2D2VNW6GeR1+jj0eYfVq
         SRh2JxFv+smlwSU3vEUPaHbXkOjH35VsJjpGvnutirsFDCtGuhYgV7jO9o2Caa1z9O7V
         KehkgKd+eD/t9B5Xlm6fDBedfsDChtgL9Ole8NLZ+QuG+YLQk//JSztO7JfN8a+KJzpx
         3nEug2A4nN3dkk/H61Bzqe6hg7Qg4w6uvgXYo4wWzvNaDVFW9ZhXuFYAG3hkkttVeonE
         WOXw==
X-Gm-Message-State: AOJu0YxmxhCm29Q5paasNKrs8f9BPw94bHh1ULDOl+RLNSDgkEz6Axdh
        7nWvtVnSl1FNproiLWtF8Kc=
X-Google-Smtp-Source: AGHT+IGoSp6HHGoZBM7PQU9kj6xX3kvZeJ9ov/I5dyamPWDqqs/4hMjcS3S6IJlE16MaXClEnBZb/A==
X-Received: by 2002:a05:6a20:2323:b0:187:652d:95c3 with SMTP id n35-20020a056a20232300b00187652d95c3mr2911085pzc.56.1700110802938;
        Wed, 15 Nov 2023 21:00:02 -0800 (PST)
Received: from [192.168.1.105] (111-255-239-171.dynamic-ip.hinet.net. [111.255.239.171])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c08500b001ab39cd875csm8224107pld.133.2023.11.15.20.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 21:00:02 -0800 (PST)
Message-ID: <4d6f0382-0012-4b22-9e9a-c659615dbad1@gmail.com>
Date:   Thu, 16 Nov 2023 12:59:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] sched/eevdf: Fix vruntime adjustment on reweight
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
Content-Language: en-US
From:   Yiwei Lin <s921975628@gmail.com>
In-Reply-To: <23cebdf8-1a51-481e-a8c2-e17021099e05@bytedance.com>
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


On 11/16/23 12:48, Abel Wu wrote:
> On 11/15/23 11:36 PM, Yiwei Lin Wrote:
>>
>>> @@ -3712,8 +3811,17 @@ static void reweight_entity(struct cfs_rq 
>>> *cfs_rq, struct sched_entity *se,
>>>       enqueue_load_avg(cfs_rq, se);
>>>       if (se->on_rq) {
>>>           update_load_add(&cfs_rq->load, se->load.weight);
>>> -        if (cfs_rq->curr != se)
>>> -            avg_vruntime_add(cfs_rq, se);
>>> +        if (!curr) {
>>> +            /*
>>> +             * The entity's vruntime has been adjusted, so let's check
>>> +             * whether the rq-wide min_vruntime needs updated too. 
>>> Since
>>> +             * the calculations above require stable min_vruntime 
>>> rather
>>> +             * than up-to-date one, we do the update at the end of the
>>> +             * reweight process.
>>> +             */
>>> +            __enqueue_entity(cfs_rq, se);
>>> +            update_min_vruntime(cfs_rq);
>>> +        }
>>>       }
>>>   }
>> Sorry if I am asking stupid question...... It looks like 
>> reweight_entity() may have chance to change the weight of 
>> cfs_rq->curr entity, but we'll never update_min_vruntime() when 
>> reweighting it. Is there any reason that we can skip the 
>> update_min_vruntime() for this case?
>
> No, you are right!
>
> Thanks!
>     Abel
Thank you! I'll take the responsibility to fix this.

Yiwei Lin
