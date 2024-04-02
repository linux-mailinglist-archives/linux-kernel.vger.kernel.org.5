Return-Path: <linux-kernel+bounces-127528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11021894D36
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65FAFB2265E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F383D969;
	Tue,  2 Apr 2024 08:12:14 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C1C17C69;
	Tue,  2 Apr 2024 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712045533; cv=none; b=TKt1svBBrKnqKJCZcXs+2eKzJM3sj0qhkg6RF/3gPOYOItrf7FqTlIebjjZsLcQBb50795HD/fn6lbn8Uwwm4H3hwKXpYY/vca5mczGbcJd2X5j0x31siG9D9U0/nuYuwPVSqNP4zUFRxQYFtWpUgliT+2SicGef1rnXEdkXAa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712045533; c=relaxed/simple;
	bh=jSGD9FgeIFkRryLuHMUswUWFB7MeVUVWB2IgR0NFFR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pF8mRL4dU/Sok/mYZESbAGSlIhh/czjkWV+p++nFEzaBIv2S+mlrXKks/rS23PCGB308JoVpsXSRaCwLAqZvIh9o0AMgogcSGItVDNSdXrUkvVLNLwAkQRx/755W/Yf5M+a3MneZ18xD3DK9nt88zzENmzRTJN3Tr80Z0DrgzCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4155819f710so21279335e9.2;
        Tue, 02 Apr 2024 01:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712045530; x=1712650330;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5EzL8eA+oUnkpWytn/I8Z651/MQDwKYVWGG+QibRDk=;
        b=UdXQG8iwAgQUSgoAH3zNK8UfcevFrX5O9wDZzwXSrlyUwIw7B+dZbSECjC1igMzEEq
         TtnpDn7GCAacLU9wh5C21LWWbeQVhXX22RnXkp99LjUwpaBJZn0tZ68OsTTWYDDE5unr
         FU9otWZCvPzuBfdk8aumlX5bppRrAGG4jU802x4qk+74QNjzxsSgcKJGk1Ljdc4/HVgJ
         iRwI75w/bzK5Mikoq6M4V1H2SxDqdvuAgDuZUNAzZJky8dHgrj+/UEtHlbu+JK1stBGm
         WpCveb95scDDNaFB+CyAiOyZxmlMvh2e+wqWuYijaMmIIO2fy3N22cQh6nu1s/b9IxqK
         OzGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVty0upV77AUbGIK/CYeJvy5soT5xY8X6NSSrLtAvIx7BSK2lM4FskNeMZ53FzNQ4PO0tTMXVmcwrm7LM6sNCpai4BgeIq4JOHIUT4S4iPkjHNOmuQZDP/0w2cntwPDbRTJjANa
X-Gm-Message-State: AOJu0YwHvSngMiN8MzLXAHQVT4oaZomLILSnKG91uHP39AuFVP4p1D2Z
	9WCg/d0C1qLkzor/WYwZ7M0ikOL0H50nCMOwVzgM59qBQABwZRWYcO09lQk4pMU=
X-Google-Smtp-Source: AGHT+IFGemYYOb9vKJpIFD2a8MsGJDZcPP5xlu/wAqzkxSMfcwWf08urzl88rDYYCi6HAzrcNL/MoA==
X-Received: by 2002:a5d:5982:0:b0:343:41ef:ab38 with SMTP id n2-20020a5d5982000000b0034341efab38mr8409852wri.48.1712045529800;
        Tue, 02 Apr 2024 01:12:09 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id bl26-20020adfe25a000000b00341ba91c1f5sm13439177wrb.102.2024.04.02.01.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 01:12:09 -0700 (PDT)
Message-ID: <bcf80774-98c2-4c14-a1e7-6efcb79a7fee@kernel.org>
Date: Tue, 2 Apr 2024 10:12:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 015/715] io_uring: remove unconditional looping in
 local task_work handling
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
References: <20240324223455.1342824-1-sashal@kernel.org>
 <20240324223455.1342824-16-sashal@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240324223455.1342824-16-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24. 03. 24, 23:23, Sasha Levin wrote:
> From: Jens Axboe <axboe@kernel.dk>
> 
> [ Upstream commit 9fe3eaea4a3530ca34a8d8ff00b1848c528789ca ]
> 
> If we have a ton of notifications coming in, we can be looping in here
> for a long time. This can be problematic for various reasons, mostly
> because we can starve userspace. If the application is waiting on N
> events, then only re-run if we need more events.

This commit breaks test/recv-multishot.c from liburing:
early error: res 4
test stream=1 wait_each=0 recvmsg=0 early_error=0  defer=1 failed

The behaviour is the same in 6.9-rc2 (which contains the commit too).

Reverting the commit on the top of 6.8.2 makes it pass again.

Should the test be updated or is the commit wrong?

Thanks.

> Fixes: c0e0d6ba25f1 ("io_uring: add IORING_SETUP_DEFER_TASKRUN")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   io_uring/io_uring.c | 44 +++++++++++++++++++++++++++++---------------
>   1 file changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
> index 5233a20d01b54..39dfb83dc9fc4 100644
> --- a/io_uring/io_uring.c
> +++ b/io_uring/io_uring.c
> @@ -1389,7 +1389,20 @@ static void __cold io_move_task_work_from_local(struct io_ring_ctx *ctx)
>   	}
>   }
>   
> -static int __io_run_local_work(struct io_ring_ctx *ctx, struct io_tw_state *ts)
> +static bool io_run_local_work_continue(struct io_ring_ctx *ctx, int events,
> +				       int min_events)
> +{
> +	if (llist_empty(&ctx->work_llist))
> +		return false;
> +	if (events < min_events)
> +		return true;
> +	if (ctx->flags & IORING_SETUP_TASKRUN_FLAG)
> +		atomic_or(IORING_SQ_TASKRUN, &ctx->rings->sq_flags);
> +	return false;
> +}
> +
> +static int __io_run_local_work(struct io_ring_ctx *ctx, struct io_tw_state *ts,
> +			       int min_events)
>   {
>   	struct llist_node *node;
>   	unsigned int loops = 0;
> @@ -1418,18 +1431,20 @@ static int __io_run_local_work(struct io_ring_ctx *ctx, struct io_tw_state *ts)
>   	}
>   	loops++;
>   
> -	if (!llist_empty(&ctx->work_llist))
> +	if (io_run_local_work_continue(ctx, ret, min_events))
>   		goto again;
>   	if (ts->locked) {
>   		io_submit_flush_completions(ctx);
> -		if (!llist_empty(&ctx->work_llist))
> +		if (io_run_local_work_continue(ctx, ret, min_events))
>   			goto again;
>   	}
> +
>   	trace_io_uring_local_work_run(ctx, ret, loops);
>   	return ret;
>   }
>   
> -static inline int io_run_local_work_locked(struct io_ring_ctx *ctx)
> +static inline int io_run_local_work_locked(struct io_ring_ctx *ctx,
> +					   int min_events)
>   {
>   	struct io_tw_state ts = { .locked = true, };
>   	int ret;
> @@ -1437,20 +1452,20 @@ static inline int io_run_local_work_locked(struct io_ring_ctx *ctx)
>   	if (llist_empty(&ctx->work_llist))
>   		return 0;
>   
> -	ret = __io_run_local_work(ctx, &ts);
> +	ret = __io_run_local_work(ctx, &ts, min_events);
>   	/* shouldn't happen! */
>   	if (WARN_ON_ONCE(!ts.locked))
>   		mutex_lock(&ctx->uring_lock);
>   	return ret;
>   }
>   
> -static int io_run_local_work(struct io_ring_ctx *ctx)
> +static int io_run_local_work(struct io_ring_ctx *ctx, int min_events)
>   {
>   	struct io_tw_state ts = {};
>   	int ret;
>   
>   	ts.locked = mutex_trylock(&ctx->uring_lock);
> -	ret = __io_run_local_work(ctx, &ts);
> +	ret = __io_run_local_work(ctx, &ts, min_events);
>   	if (ts.locked)
>   		mutex_unlock(&ctx->uring_lock);
>   
> @@ -1646,7 +1661,7 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, long min)
>   		    io_task_work_pending(ctx)) {
>   			u32 tail = ctx->cached_cq_tail;
>   
> -			(void) io_run_local_work_locked(ctx);
> +			(void) io_run_local_work_locked(ctx, min);
>   
>   			if (task_work_pending(current) ||
>   			    wq_list_empty(&ctx->iopoll_list)) {
> @@ -2489,7 +2504,7 @@ int io_run_task_work_sig(struct io_ring_ctx *ctx)
>   {
>   	if (!llist_empty(&ctx->work_llist)) {
>   		__set_current_state(TASK_RUNNING);
> -		if (io_run_local_work(ctx) > 0)
> +		if (io_run_local_work(ctx, INT_MAX) > 0)
>   			return 0;
>   	}
>   	if (io_run_task_work() > 0)
> @@ -2557,7 +2572,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
>   	if (!io_allowed_run_tw(ctx))
>   		return -EEXIST;
>   	if (!llist_empty(&ctx->work_llist))
> -		io_run_local_work(ctx);
> +		io_run_local_work(ctx, min_events);
>   	io_run_task_work();
>   	io_cqring_overflow_flush(ctx);
>   	/* if user messes with these they will just get an early return */
> @@ -2595,11 +2610,10 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
>   
>   	trace_io_uring_cqring_wait(ctx, min_events);
>   	do {
> +		int nr_wait = (int) iowq.cq_tail - READ_ONCE(ctx->rings->cq.tail);
>   		unsigned long check_cq;
>   
>   		if (ctx->flags & IORING_SETUP_DEFER_TASKRUN) {
> -			int nr_wait = (int) iowq.cq_tail - READ_ONCE(ctx->rings->cq.tail);
> -
>   			atomic_set(&ctx->cq_wait_nr, nr_wait);
>   			set_current_state(TASK_INTERRUPTIBLE);
>   		} else {
> @@ -2618,7 +2632,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
>   		 */
>   		io_run_task_work();
>   		if (!llist_empty(&ctx->work_llist))
> -			io_run_local_work(ctx);
> +			io_run_local_work(ctx, nr_wait);
>   
>   		/*
>   		 * Non-local task_work will be run on exit to userspace, but
> @@ -3273,7 +3287,7 @@ static __cold bool io_uring_try_cancel_requests(struct io_ring_ctx *ctx,
>   
>   	if ((ctx->flags & IORING_SETUP_DEFER_TASKRUN) &&
>   	    io_allowed_defer_tw_run(ctx))
> -		ret |= io_run_local_work(ctx) > 0;
> +		ret |= io_run_local_work(ctx, INT_MAX) > 0;
>   	ret |= io_cancel_defer_files(ctx, task, cancel_all);
>   	mutex_lock(&ctx->uring_lock);
>   	ret |= io_poll_remove_all(ctx, task, cancel_all);
> @@ -3635,7 +3649,7 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
>   			 * it should handle ownership problems if any.
>   			 */
>   			if (ctx->flags & IORING_SETUP_DEFER_TASKRUN)
> -				(void)io_run_local_work_locked(ctx);
> +				(void)io_run_local_work_locked(ctx, min_complete);
>   		}
>   		mutex_unlock(&ctx->uring_lock);
>   	}

-- 
js
suse labs


