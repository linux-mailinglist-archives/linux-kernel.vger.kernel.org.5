Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15007C6B04
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbjJLKZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbjJLKZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:25:19 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDB490
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:25:18 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690ce3c55f1so634413b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697106317; x=1697711117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7ICXJkU98oSQJrBKC7mcojL9G7RN3hGsGY8b4JhLlQ=;
        b=D6MjR8/U7KwXdfuDydeoWIjfUkN1Q9uXnbtGv5JG0hzU4VHE6183QldC1ZJ2gN/FAO
         zVIb8win9X1WG7hIFDwKBOuUnTk/PkIMbczB+YKkeYetwvri+54KXjqUJMCsHCj7lOHX
         mXAfXfOLefjYsgud35TqdkmXJvwTxTTZt55xAiiluFCB094YjjsYAM56Zn5EA6/ljceQ
         usFHgzxDzD7X1JwmfOfBoXMsoYnzRUaxrsN/VAjcFLbN5Xn9ttCDi1udgkHpWQ1x9JPp
         D7SY8Y2QFu3jCqbKxUURZhvtCZVJcDDirjV0+rxMdbWLlj8hc0WDVQWs7zhRDnRY1O08
         YV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697106317; x=1697711117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7ICXJkU98oSQJrBKC7mcojL9G7RN3hGsGY8b4JhLlQ=;
        b=onnP8A1jCR9Eo7RLXFdVLMc3CBgR4RYkGCTnJQhJn1wKgT7lcJSMqnLiq7CVtM6d6o
         3nTHR/2ftlr240qYUn0akpr3qlMq9R3yO/IkV5/R2Rbk7eyyCX5T1XKoG46KHq3lJoVA
         2v81pqCH/+p0xzukS3Lrz7mEyPevVDTwoYhXqDx9vaffbGcAAS2OFat8Es2pfbItmqEx
         O3nYlIje8NJ46sbuVg5YTlln0ygkf/NORZ76RPrxF00sMuymLLDcdp1sQS9HPzRU8MiL
         SvM5z4cw3BtjkFs9DRV2xiPPpvOG7qiOL6KnOpTVHmka4HFwCbmc/lX84rGeXnv4YMBJ
         6vGA==
X-Gm-Message-State: AOJu0YzN44ndkFPN6MR9V48/FHbgrq9YwSdatoUSllqVXJdi4BWCMqZD
        ap8uyN2trr1Lxy+KMsp33SCexg==
X-Google-Smtp-Source: AGHT+IFPtqeh5N5m2ZtF3tQL0i5yUeseoxyUkL4nW4v6O3/zNgWHQATgJckAY0ikq+tHM3Z6zUvLdg==
X-Received: by 2002:a05:6a20:3c88:b0:14c:910d:972d with SMTP id b8-20020a056a203c8800b0014c910d972dmr25253157pzj.12.1697106317507;
        Thu, 12 Oct 2023 03:25:17 -0700 (PDT)
Received: from [10.84.153.115] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id cv14-20020a17090afd0e00b00271c5811019sm1506246pjb.38.2023.10.12.03.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 03:25:17 -0700 (PDT)
Message-ID: <699cc8b1-f341-4af7-9c47-fee961c5c4b7@bytedance.com>
Date:   Thu, 12 Oct 2023 18:25:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH] sched/fair: fix pick_eevdf to always find the correct
 se
Content-Language: en-US
To:     Benjamin Segall <bsegall@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bristot@redhat.com,
        corbet@lwn.net, qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
References: <20230531115839.089944915@infradead.org>
 <20230531124603.931005524@infradead.org> <xm261qego72d.fsf_-_@google.com>
 <6b606049-3412-437f-af25-a4c33139e2d8@bytedance.com>
 <xm26bkd4x5v4.fsf@bsegall-linux.svl.corp.google.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <xm26bkd4x5v4.fsf@bsegall-linux.svl.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/23 5:01 AM, Benjamin Segall Wrote:
> Abel Wu <wuyun.abel@bytedance.com> writes:
> 
>> On 9/30/23 8:09 AM, Benjamin Segall Wrote:
>>> +	/*
>>> +	 * Now best_left and all of its children are eligible, and we are just
>>> +	 * looking for deadline == min_deadline
>>> +	 */
>>> +	node = &best_left->run_node;
>>> +	while (node) {
>>> +		struct sched_entity *se = __node_2_se(node);
>>> +
>>> +		/* min_deadline is the current node */
>>> +		if (se->deadline == se->min_deadline)
>>> +			return se;
>>
>> IMHO it would be better tiebreak on vruntime by moving this hunk to ..
>>
>>> +
>>> +		/* min_deadline is in the left branch */
>>>    		if (node->rb_left &&
>>>    		    __node_2_se(node->rb_left)->min_deadline == se->min_deadline) {
>>>    			node = node->rb_left;
>>>    			continue;
>>>    		}
>>
>> .. here, thoughts?
> 
> Yeah, that should work and be better on the tiebreak (and my test code
> agrees). There's an argument that the tiebreak will never really come up
> and it's better to avoid the potential one extra cache line from
> "__node_2_se(node->rb_left)->min_deadline" though.

I see. Then probably do the same thing in the first loop?

> 
>>
>>>    +		/* else min_deadline is in the right branch */
>>>    		node = node->rb_right;
>>>    	}
>>> +	return NULL;
>>
>> Why not 'best'? Since ..
> 
> The only time this can happen is if the tree is corrupt. We only reach
> this case if best_left is set at all (and best_left's min_deadline is
> better than "best"'s, which includes curr). In that case getting an
> error message is good, and in general I wasn't worrying about it much.

Right.

> 
>>
>>> +}
>>>    -	if (!best || (curr && deadline_gt(deadline, best, curr)))
>>> -		best = curr;
>>> +static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>>> +{
>>> +	struct sched_entity *se = __pick_eevdf(cfs_rq);
>>>    -	if (unlikely(!best)) {
>>> +	if (!se) {
>>>    		struct sched_entity *left = __pick_first_entity(cfs_rq);
>>
>> .. cfs_rq->curr isn't considered here.
> 
> That said, we should probably consider curr here in the error-case
> fallback, if just as a "if (!left) left = cfs_rq->curr;"

I don't think so as there must be some bugs in the scheduler, replacing
'pr_err' with 'BUG()' would be more appropriate.

> 
> 
> I've also attached my ugly userspace EEVDF tester as an attachment,
> hopefully I attached it in a correct mode to go through lkml.

Received. Thanks, Ben.
