Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3927E6E6A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343640AbjKIQQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjKIQQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:16:05 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A796E324A;
        Thu,  9 Nov 2023 08:16:02 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-543923af573so1730893a12.0;
        Thu, 09 Nov 2023 08:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699546561; x=1700151361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ojbd27m0T961ggTmsfiY2MgFwOruhn6ME5MhCcBpoFU=;
        b=gxwqna/T+9U8cACJwllvl8T78Vy0UnQlhyIws36EuH6lhSxhwjLOe4B2+E82PFQXSD
         VXzgnzn59aWQN7cffbwsCPWk31LCJz8OmC7huf3DF2TfjdiZLmFUD0mVavwwE6Mpk/6Q
         EVupMunlcu9hGfZT71/nHNH4pyIHmvHuPVVPNqrOGKld8rrD8IsIyOj+Bw9VYUnxeYYV
         z0tX90H7HXNY6RxuMyBfzQE7k+vzJDRtDdqxUuhhQ8s/8bRKdqK3nsmoRX6cIcnrPrJx
         rIHYaA81VgtPsAWEGVEipWNnF4PESAXTMnksylrtqED4y/QOT5Ak5KqZNjAj2oMcB29w
         ybbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699546561; x=1700151361;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojbd27m0T961ggTmsfiY2MgFwOruhn6ME5MhCcBpoFU=;
        b=YHm30hFKTHVkXACOF9uH9D1iolyMxktUtsKpXWTChH65/LIsPYPu17EidV6zHFeTU/
         vbRkCFKpbIwlpUiszlb/2asicm3srZrboPKB7aZTPqr9r2ZpR+7wbsTKupvqnVJMjvRV
         YIf3u0HucOMb/UnB1QTf/DdFFb358kdxFwZu0RPrBcWTweK+WmBytzVdVo+GN83xhSPM
         y1k0iTAruY0d3c+g3xhPZIgH50yr1H5BpX2W+6oRIJsouu+Ix7Oslirii0OUlvlYKz2W
         /YnszeNsFsKzA2rjwejb7MiK52XwUSxy1usWzZg3Oal7KVadl354vINqbEmDtgJzod7J
         ITDg==
X-Gm-Message-State: AOJu0YxF+v4dKOdUQojOiYoJZUGooVqqkO51aPj4cBk5aBaN2oqmeW+Y
        va88rr3e4XD0lRSU/B4kTlo=
X-Google-Smtp-Source: AGHT+IEXLyGYLwtSPwEo4bwk26WrAvEDObL2F8q5SlY3vWf+C1AzynH+BS4w0PhgQu6SX9/POqvUew==
X-Received: by 2002:a50:9b0a:0:b0:53d:b751:ece1 with SMTP id o10-20020a509b0a000000b0053db751ece1mr3882915edi.41.1699546560575;
        Thu, 09 Nov 2023 08:16:00 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:310::22ef? ([2620:10d:c092:600::2:7ea6])
        by smtp.gmail.com with ESMTPSA id u18-20020a50c2d2000000b0052ffc2e82f1sm2360edf.4.2023.11.09.08.16.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 08:16:00 -0800 (PST)
Message-ID: <9e2b679c-fc1e-3d83-2303-e053f330a21a@gmail.com>
Date:   Thu, 9 Nov 2023 16:14:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] io_uring: Statistics of the true utilization of sq
 threads.
Content-Language: en-US
To:     Xiaobing Li <xiaobing.li@samsung.com>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        kun.dou@samsung.com, peiwei.li@samsung.com, joshi.k@samsung.com,
        kundan.kumar@samsung.com, wenwen.chen@samsung.com,
        ruyi.zhang@samsung.com
References: <CGME20231108081516epcas5p442a11004e3b4e6339972fd6da4c6692b@epcas5p4.samsung.com>
 <20231108080732.15587-1-xiaobing.li@samsung.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20231108080732.15587-1-xiaobing.li@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/23 08:07, Xiaobing Li wrote:
> Since the sq thread has a while(1) structure, during this process, there
> may be a lot of time that is not processing IO but does not exceed the
> timeout period, therefore, the sqpoll thread will keep running and will
> keep occupying the CPU. Obviously, the CPU is wasted at this time;Our
> goal is to count the part of the time that the sqpoll thread actually
> processes IO, so as to reflect the part of the CPU it uses to process
> IO, which can be used to help improve the actual utilization of the CPU
> in the future.

Let's pull the elephant out of the room, what's the use case? "Improve
in the future" doesn't sound too convincing. If it's a future kernel
change you have in mind, it has to go together with this patch. If it's
a userspace application, it'd be interesting to hear what that is,
especially if you have numbers ready.

And another classic question, why can't it be done with bpf?


> Signed-off-by: Xiaobing Li <xiaobing.li@samsung.com>
> 
> v1 -> v2: Added method to query data.
> 
...
> diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
> index bd6c2c7959a5..c821273406bd 100644
> --- a/io_uring/sqpoll.c
> +++ b/io_uring/sqpoll.c
> @@ -224,6 +224,7 @@ static int io_sq_thread(void *data)
>   	struct io_ring_ctx *ctx;
>   	unsigned long timeout = 0;
>   	char buf[TASK_COMM_LEN];
> +	unsigned long start, begin, end;

start and begin used for just slightly different accounting,
it'll get confused anyone.

>   	DEFINE_WAIT(wait);
>   
>   	snprintf(buf, sizeof(buf), "iou-sqp-%d", sqd->task_pid);
> @@ -235,6 +236,7 @@ static int io_sq_thread(void *data)
>   		set_cpus_allowed_ptr(current, cpu_online_mask);
>   
>   	mutex_lock(&sqd->lock);
> +	start = jiffies;
>   	while (1) {
>   		bool cap_entries, sqt_spin = false;
>   
> @@ -245,12 +247,18 @@ static int io_sq_thread(void *data)
>   		}
>   
>   		cap_entries = !list_is_singular(&sqd->ctx_list);
> +		begin = jiffies;

There can be {hard,soft}irq in between jiffies reads, and it can even
be scheduled out in favour of another process, so it'd collect a lot
of garbage. There should be a per-task stat for system time you can
use:

start = get_system_time(current);
do_io_part();
sq->total_time += get_system_time(current) - start;
wait();

...

>   		list_for_each_entry(ctx, &sqd->ctx_list, sqd_list) {
>   			int ret = __io_sq_thread(ctx, cap_entries);
>   
>   			if (!sqt_spin && (ret > 0 || !wq_list_empty(&ctx->iopoll_list)))
>   				sqt_spin = true;
>   		}
> +		end = jiffies;
> +		sqd->total = end - start;

...and then you don't need to track total at all, it'd be your

total = get_system_time(sq_thread /* current */);

at any given point it time.


> +		if (sqt_spin == true)
> +			sqd->work += end - begin;

It should go after the io_run_task_work() below, task_work is a major
part of request execution.

> +
>   		if (io_run_task_work())
>   			sqt_spin = true;
>   
> diff --git a/io_uring/sqpoll.h b/io_uring/sqpoll.h
> index 8df37e8c9149..0aa4e2efa4db 100644
> --- a/io_uring/sqpoll.h
> +++ b/io_uring/sqpoll.h
> @@ -16,6 +16,8 @@ struct io_sq_data {
>   	pid_t			task_pid;
>   	pid_t			task_tgid;
>   
> +	unsigned long       work;
> +	unsigned long       total;
>   	unsigned long		state;
>   	struct completion	exited;
>   };

-- 
Pavel Begunkov
