Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFC0800C1B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378996AbjLANaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378935AbjLANaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:30:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF26C131
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 05:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701437419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3SF4LBDmvggYUs6YCBmai3LIdtRwh3BbHTnbgRAnqDo=;
        b=DiDQ1u5kfek9ODT8qsECEL0IUlapjRcrIhbwURqc2obJ2A0hflXvVrif3lClPhmpkz3/rn
        xVL/uM1R67RnOeLt2+K/wsjR9uWdcCs5u4D/wUHeeUqX0vFKBgilSzE6Kly2oUKF9688+a
        fpbDCqdel/MUMXxSFiU6aVLbxoWs0MQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-zptn48yPOBSl3b_pcrpfJg-1; Fri, 01 Dec 2023 08:30:18 -0500
X-MC-Unique: zptn48yPOBSl3b_pcrpfJg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-77d5e048522so234872585a.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 05:30:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701437418; x=1702042218;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3SF4LBDmvggYUs6YCBmai3LIdtRwh3BbHTnbgRAnqDo=;
        b=wwwIcEpzS9APWXTSljDxFG5FVMtjVViBk5sulfqiCCwZduPSVm9bFq0OWoLlVC6psA
         2HrD4O7ayNHCgFIlyN8elStg5Y8y3vnqSpxw8ZcD9iIQjBVhhovnBdpA47k0e4LEw62s
         4kbHxs2EAVz12v2i2dvbJTn09fXs++EnYtkj6RPE9ezcqCjozmxZtzGq+FxS8BAOmFLC
         KPJVN3eEwESZKJsNpx1RicV5MUIMWi3cKJvYl5SSKnbP9MxEbzUa0iv+Rx2hD3iv74AK
         qgHnxs8bE6mjPrJYsdnHhRNkQ5gGBj/K42q+VnnS/3U/OiRCfj9Gs8AUFgYh6GV1ZL+8
         uwyg==
X-Gm-Message-State: AOJu0Yxgk9lCdXFKDXT4+IfpFZyCXgmG4h5sHLjxBfwoz86o/58JEUwS
        ZuE6q0bIqZNcismcNg20CMec8qsMA7UOj4JcKd2CzqeAz35UVU7xpFtRvWMcARGSgzli/FLGd5z
        NkgQZ3MP/o/K7JoIgNkhAPCA6
X-Received: by 2002:a05:620a:126a:b0:778:ba73:1650 with SMTP id b10-20020a05620a126a00b00778ba731650mr22595386qkl.30.1701437418330;
        Fri, 01 Dec 2023 05:30:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGI17GvNiGW5TYBxyQIzFlfgwdqk753kLJ2hvHWzg2cwiGBs9YwMT/xNasn/ztSl6OUhJy9Mw==
X-Received: by 2002:a05:620a:126a:b0:778:ba73:1650 with SMTP id b10-20020a05620a126a00b00778ba731650mr22595365qkl.30.1701437418040;
        Fri, 01 Dec 2023 05:30:18 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id qz19-20020a05620a8c1300b0077d6875cb3esm1479263qkn.114.2023.12.01.05.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 05:30:17 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Benjamin Segall <bsegall@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Tomas Glozar <tglozar@redhat.com>
Subject: Re: [RFC PATCH 1/2] sched/fair: Only throttle CFS tasks on return
 to userspace
In-Reply-To: <xm26sf4n2ar6.fsf@google.com>
References: <20231130161245.3894682-1-vschneid@redhat.com>
 <20231130161245.3894682-2-vschneid@redhat.com>
 <xm26sf4n2ar6.fsf@google.com>
Date:   Fri, 01 Dec 2023 14:30:14 +0100
Message-ID: <xhsmhfs0maw49.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/23 13:26, Benjamin Segall wrote:
> Valentin Schneider <vschneid@redhat.com> writes:
>
>> As reported in [1], CFS bandwidth throttling is a source of headaches in
>> PREEMPT_RT - generally speaking, a throttled CFS task can hold locks that
>> prevent ksoftirqd from running, which prevents replenishing & unthrottling
>> the cfs_rq of said CFS task.
>>
>> Peter mentioned that there have been discussions on changing /when/ the
>> throttling happens: rather than have it be done immediately upon updating
>> the runtime statistics and realizing the cfs_rq has depleted its quota, we wait
>> for the task to be about to return to userspace.
>>
>> I'm not aware of the arguments in favour of this for !PREEMPT_RT, but given [1]
>> I had a look into it. Using this approach means no task can be throttled while
>> holding a kernel lock, which solves the locking dependency issue.
>
> The alternative we've been experimenting with (and still running into
> other issues that have made it hard to tell if they work) is to still
> leave the tasks on their cfs_rqs, but instead have two task_timelines or
> similar per cfs_rq, one of which only has unthrottleable tasks (or
> partially-throttled child cgroups) on it. Then when picking into a
> partially-unthrottled cfs_rq you only look at that alternate task_timeline.
>

IIUC then you don't dequeue the cfs_rq's se, but instead rely on the RB
tree switch to only have unthrottable tasks running.

> This means that we get to skip this per-actually-throttled-task loop:
>
>> @@ -5548,7 +5548,61 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
>>  {
>>      struct rq *rq = data;
>>      struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
>> +	struct sched_entity *se = tg->se[cpu_of(rq)];
>> +	struct cfs_rq *pcfs_rq = cfs_rq_of(se);
>> +	long task_delta = 0, idle_task_delta = 0;
>> +	struct task_struct *p, *tmp;
>>
>> +	/*
>> +	 * Re-enqueue the tasks that have been throttled at this level.
>> +	 *
>> +	 * The task count is up-propagated via ->unthrottled_*h_nr_running,
>> +	 * as we can't purely rely on h_nr_running post-enqueue: the unthrottle
>> +	 * might happen when a cfs_rq still has some tasks enqueued, either still
>> +	 * making their way to userspace, or freshly migrated to it.
>> +	 */
>> +	list_for_each_entry_safe(p, tmp, &cfs_rq->throttled_limbo_list, throttle_node) {
>> +		struct sched_entity *pse = &p->se;
>> +
>> +		list_del_init(&p->throttle_node);
>> +		enqueue_entity(cfs_rq, pse, ENQUEUE_WAKEUP);
>> +		task_delta++;
>> +		idle_task_delta += task_has_idle_policy(p);
>> +	}
>
> The downsides are that you instead have extra operations per
> enqueue/dequeue/pick (but just an extra list/rbtree operation or check),
> and that it doesn't do *any* accounting change for a partially dequeued
> cfs_rq.
>

I would assume we want to keep the *nr_running as close to reality as
possible, given their impact on pick_next_task_fair() & load_balance().

> I'm going to try putting together a cleaner variant of our version that
> works via task_work instead of bracketing every relevant entry point.
> (That design came from when we were trying instead to only do it for
> tasks holding actual locks)

Interesting, thank you for sharing! I assume then the motivation for this
is to reduce latencies caused by throttling lock holders?

