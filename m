Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB787516DB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjGMDoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjGMDo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:44:26 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9FD212E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:44:01 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-55ba5fae2e6so302476a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689219840; x=1689824640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hVjQTrjhAgBoK60RvPAfIw0EZID7PTIyARw4vx1MjIQ=;
        b=Zjh5MGD4DgBqKkIZf9kMQ5CF4fyhyzzaQdofJQdXaDG/QC4dbKDnVJvnEaYUFMyGyJ
         bvVj6rHw4EHTnPfxCGVPBUxeDHwo85sZoAcXSCcRYYTFtbvYLyCB67/ymUrNszWV7Zj8
         i9fpFUQqnh7zNZObRKZbidiRO5FL2ZHomFRAGzegZ0KO8j0vC77Hk/9XUnwTkBTvqk21
         4lJDQeJbkiNc0hYJiCujjvan/IVWbSaJPClKrdyHlhU6ufd4VKVkN0y/6zTWxuo+7UwI
         rIicJKpRb0Lgp8I0U9LY7yJN+l6Q2diSbJwRs9dBxnb1PauJUaLjXQiMKjWvl06e3Cba
         0MTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689219840; x=1689824640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVjQTrjhAgBoK60RvPAfIw0EZID7PTIyARw4vx1MjIQ=;
        b=W/J/arMNpgcyassj//dl0zR4dKz/7senEypJ3nPtEdWLyHClJ0+PCuvtKjJDuSAU7r
         jKIOcle/MTu5lE2RoLcRWTU8uCbaIPcMaR1/yZCAvpwWrnU7fyipWBSCohqIgFOzvBRi
         kiMFDXO4MR3MXm8GwO1Z67ZeeEqxvFS4cthfsBK7QIs4WMly6csd8mH/URGjQxHkALT/
         z0n5FEVkANqxXYXtotGYVFt4UOh8ccc3sYc3jwidEc1hkcftP4ihnm9IkC7ft2Q0/aBH
         /xjJ9WJBm5vwUHQ4kjo3TF/fpvWhRczm7b5msBdYxYyNiU3/XUsPJ8WAN6s4wIcBSrBc
         Nlrw==
X-Gm-Message-State: ABy/qLYBbiXG9BFjDFCqGnLAYzWr1U0C6pQdXknF18WKYeiaoVW9FXL2
        o4zXg62CH4wKm74BifvfuQ0lmw==
X-Google-Smtp-Source: APBJJlHOof2UHVhe+eU54U/aT2RSacobLy7qJyJL2R/eRzPhVtf1XmAWOv8h7kvPJl1Lb4CQtkQNVQ==
X-Received: by 2002:a05:6a20:7485:b0:11f:39e2:d08c with SMTP id p5-20020a056a20748500b0011f39e2d08cmr356986pzd.30.1689219840158;
        Wed, 12 Jul 2023 20:44:00 -0700 (PDT)
Received: from [10.94.58.170] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090274cb00b001b694130c05sm4755621plt.1.2023.07.12.20.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 20:43:59 -0700 (PDT)
Message-ID: <a70eaa87-2afa-a5c7-a463-7199744cefa4@bytedance.com>
Date:   Thu, 13 Jul 2023 11:43:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: Re: [PATCH v2 5/7] sched: Implement shared runqueue in CFS
Content-Language: en-US
To:     David Vernet <void@manifault.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com, clm@meta.com,
        tj@kernel.org, roman.gushchin@linux.dev, kernel-team@meta.com,
        linux-kernel@vger.kernel.org
References: <20230710200342.358255-1-void@manifault.com>
 <20230710200342.358255-6-void@manifault.com>
 <93260dd9-818a-7f98-e030-635e0dc8cad8@bytedance.com>
 <20230712221657.GF12207@maniforge>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20230712221657.GF12207@maniforge>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/23 6:16 AM, David Vernet wrote:
> On Wed, Jul 12, 2023 at 06:47:26PM +0800, Abel Wu wrote:
>>> + *
>>> + * HOW
>>> + * ===
>>> + *
>>> + * An shared_runq is comprised of a list, and a spinlock for synchronization.
>>> + * Given that the critical section for a shared_runq is typically a fast list
>>> + * operation, and that the shared_runq is localized to a single LLC, the
>>> + * spinlock will typically only be contended on workloads that do little else
>>> + * other than hammer the runqueue.
>>
>> Would there be scalability issues on large LLCs?
> 
> See the next patch in the series [0] where we shard the per-LLC shared
> runqueues to avoid contention.
> 
> [0]: https://lore.kernel.org/lkml/20230710200342.358255-7-void@manifault.com/

Sorry, I should have read the cover letter more carefully. By sharding,
the LLC is partitioned into several zones, hence contention is relieved.
But sharding itself might be tricky. Making the SMT siblings not cross
shards, as suggested by Peter, is generally a good thing. But I wonder
if there is any workload might benefit from other sharding form.

>>
>>> +
>>> +	task_rq_unlock(src_rq, p, &src_rf);
>>> +
>>> +	raw_spin_rq_lock(rq);
>>> +	rq_repin_lock(rq, rf);
>>
>> By making it looks more ugly, we can save some cycles..
>>
>> 	if (src_rq != rq) {
>> 		task_rq_unlock(src_rq, p, &src_rf);
>> 	} else {
>> 		rq_unpin_lock(src_rq, src_rf);
>> 		raw_spin_unlock_irqrestore(&p->pi_lock, src_rf.flags);
>> 		rq_repin_lock(rq, rf);
>> 	}

I forgot the repin part when src_rq != rq, but I'm sure you already got
my point :)

Cheers,
	Abel
