Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88C47C7C4A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 05:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjJMDrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 23:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJMDrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 23:47:02 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C3DB7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 20:46:38 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c9d922c039so13966675ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 20:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697168797; x=1697773597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=33P5FFRygetlcU5+dGmEWjGqVa6SrGuz6L2T8K/a7s4=;
        b=N1XhCv/sQWoTsG0v0+clT6fI9n0WsXHuAynW0y2LGiPgB9L7mijTLLO3okQ1JMBkMT
         bZ072SGPVHP5heyJ7pJpXscsSbXWW+A00ZJf/kx97NVqNmfxAohYyaJnGD8c1ehDxvJy
         YzkYhYQv4gcxVZZ+mBNBOZ9VBCAhOyVSvz0kdYUhEdj5Hstu1qXDiclvcUQCrvZ7D8nb
         qWfvbCNHIe/DcRzyaGEc5PBGKp8NnRAlEHB5j7W2qrsyMgtPwRjCeSABlph1RSE9sHr/
         hvuJhHEs+U9KKIah63UETC5CZKt2qQyo5pnyo0JC9z65VsHeyK0AZhEOd7QZ9uuG/nD2
         ZysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697168797; x=1697773597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=33P5FFRygetlcU5+dGmEWjGqVa6SrGuz6L2T8K/a7s4=;
        b=UQjfRSy5CyN6w7qEYx8SOGyol5/UjqHbQkqXYfNMQCIwQwExgGuQy+YGe+g/30dg/V
         24AqWIgXLLSu0h+TFyQqQjRd4VxOet5LNUGn78NLYtsPSdl15NTo9lDFlY1FDYulU0SV
         B8dR1lGth+C0rR+HZUo5vMKI/h3nP940shFkCH/IWLyfspwS22RwTCI3+wV/XRTcHTuk
         H57+DmCbcl7I+ZdcvIXwN6gGU5jE1ZO53DRqmlDmP8RE++wyuQXWiasy+OUVCs08XeEJ
         Mjwy6lIc66NPgnwjAwnfkAaVM5ElqAJ0HQ3k6OxuaI82Y4Cq8g06cjTN5I66vyrtQ0bw
         xv5g==
X-Gm-Message-State: AOJu0Yy+d7TM43XnKP1mfbQsilXYlegARZWvjPyg1VkxddCb60LKHRRZ
        X9OfkQ/syPmBndJe5MgUiLPwsg==
X-Google-Smtp-Source: AGHT+IGmtIuRylG6tWS3X2p1tSnWquo4kI3XUhSHJ71OX9LnfIFLneZpcFkSW+lN7kE0mE89k2eRtw==
X-Received: by 2002:a17:903:110f:b0:1c3:3b5c:1fbf with SMTP id n15-20020a170903110f00b001c33b5c1fbfmr34206950plh.10.1697168797524;
        Thu, 12 Oct 2023 20:46:37 -0700 (PDT)
Received: from [10.84.153.115] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id iz12-20020a170902ef8c00b001c9c3c377f2sm2772958plb.203.2023.10.12.20.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 20:46:37 -0700 (PDT)
Message-ID: <e2a42ff2-d0f9-4963-bed7-229224ee8287@bytedance.com>
Date:   Fri, 13 Oct 2023 11:46:24 +0800
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
 <699cc8b1-f341-4af7-9c47-fee961c5c4b7@bytedance.com>
 <xm26pm1jhgpx.fsf@bsegall-linux.svl.corp.google.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <xm26pm1jhgpx.fsf@bsegall-linux.svl.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/23 1:51 AM, Benjamin Segall Wrote:
> Abel Wu <wuyun.abel@bytedance.com> writes:
> 
>> On 10/12/23 5:01 AM, Benjamin Segall Wrote:
>>> Abel Wu <wuyun.abel@bytedance.com> writes:
>>>
>>>> On 9/30/23 8:09 AM, Benjamin Segall Wrote:
>>>>> +	/*
>>>>> +	 * Now best_left and all of its children are eligible, and we are just
>>>>> +	 * looking for deadline == min_deadline
>>>>> +	 */
>>>>> +	node = &best_left->run_node;
>>>>> +	while (node) {
>>>>> +		struct sched_entity *se = __node_2_se(node);
>>>>> +
>>>>> +		/* min_deadline is the current node */
>>>>> +		if (se->deadline == se->min_deadline)
>>>>> +			return se;
>>>>
>>>> IMHO it would be better tiebreak on vruntime by moving this hunk to ..
>>>>
>>>>> +
>>>>> +		/* min_deadline is in the left branch */
>>>>>     		if (node->rb_left &&
>>>>>     		    __node_2_se(node->rb_left)->min_deadline == se->min_deadline) {
>>>>>     			node = node->rb_left;
>>>>>     			continue;
>>>>>     		}
>>>>
>>>> .. here, thoughts?
>>> Yeah, that should work and be better on the tiebreak (and my test code
>>> agrees). There's an argument that the tiebreak will never really come up
>>> and it's better to avoid the potential one extra cache line from
>>> "__node_2_se(node->rb_left)->min_deadline" though.
>>
>> I see. Then probably do the same thing in the first loop?
>>
> 
> We effectively do that already sorta by accident almost always -
> computing best and best_left via deadline_gt rather than gte prioritizes
> earlier elements, which always have a better vruntime.

Sorry for not clarifying clearly about the 'same thing'. What I meant
was to avoid touch left if the node itself has the min deadline.

@@ -894,6 +894,9 @@ static struct sched_entity *__pick_eevdf(struct cfs_rq *cfs_rq)
                 if (!best || deadline_gt(deadline, best, se))
                         best = se;

+               if (se->deadline == se->min_deadline)
+                       break;
+
                 /*
                  * Every se in a left branch is eligible, keep track of the
                  * branch with the best min_deadline
@@ -913,10 +916,6 @@ static struct sched_entity *__pick_eevdf(struct cfs_rq *cfs_rq)
                                 break;
                 }

-               /* min_deadline is at this node, no need to look right */
-               if (se->deadline == se->min_deadline)
-                       break;
-
                 /* else min_deadline is in the right branch. */
                 node = node->rb_right;
         }

(But still thanks for the convincing explanation on fairness.)

Best,
	Abel

> 
> Then when we do the best_left->min_deadline vs best->deadline
> computation, we prioritize best_left, which is the one case it can be
> wrong, we'd need an additional
> "if (se->min_deadline == best->deadline &&
> (s64)(se->vruntime - best->vruntime) > 0) return best;" check at the end
> of the second loop.
> 
> (Though again I don't know how much this sort of never-going-to-happen
> slight fairness improvement is worth compared to the extra bit of
> overhead)
