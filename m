Return-Path: <linux-kernel+bounces-16558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E22582402F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA4B1C23E0D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46F82134E;
	Thu,  4 Jan 2024 11:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmROMViF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1EE210ED
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704366145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=djKqOCY1t8hIcFhmRum8eEj601vreAd0hUTSuvYCotY=;
	b=dmROMViFnTtId5KPp0p3ve/afTWnvgOsRoyMmWQ+4uFTMXXZZ5SdmI5HSfa8MAUCUhOpFX
	HON7PxqjHM6z2TMtPQ0O07rE6CmCwqimcp0jBF0nBFqgZQZkmtN/iUxRCX71pJC1b41bBS
	Hav94PMV43w3k9WOtYqM0OZToDzqwHo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-ERudIfuZOumC9I7V-QKjJA-1; Thu, 04 Jan 2024 06:02:23 -0500
X-MC-Unique: ERudIfuZOumC9I7V-QKjJA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a28ef2418d3so16514566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 03:02:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704366142; x=1704970942;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=djKqOCY1t8hIcFhmRum8eEj601vreAd0hUTSuvYCotY=;
        b=VKtZmbde1qZ5NEbhCCaE0t/fJ/OiziVXN9YmixX8rmG93AOk2fRuERJP/GTCRagdJf
         yUZpqH3p1AQ0pWCm0WU7ERY6jGCvqZ1QIyGSOVI4gSxUMiVbosCMDEvQdFSmXfl0qxhi
         6WAedHNwJKM04IOCsz9o67Kr0/WQkB8IM79wFfbxVrnCx3yIVScGUVhN6R7wLSaYN5dS
         6u7ooWbzfT5Kjg9smcOZyONZihJc8ivV72BbtKEsAFGb8PHHKCHAXI7q0cXyZsoI0P/c
         thDz8zkktL9gK1zQ+Ko8Irs4T9+qNvIZJxPSJNeF8claDQxEVt+OE6z5XUzSAm4jslap
         zdag==
X-Gm-Message-State: AOJu0YxEu6jtSI+zssGNyJxy/AalHitPWOoUcwY8j24k2yArynQGUeff
	67CW80bERjfuTAUbJtbPw32vjGPYeITGL3XE+BvPGodgEW8iIhrslG6eC3E+sRRfCGgsJbyIX8J
	1/mgadnXSP99/PurGRqAGjAnl5knRGB1/
X-Received: by 2002:a17:906:187:b0:a28:ba5d:e786 with SMTP id 7-20020a170906018700b00a28ba5de786mr403452ejb.14.1704366142719;
        Thu, 04 Jan 2024 03:02:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtwNPFQC23D++QDRh9yK/KQ541sinKcWHVBGOAB0aCc4U0NhmfInXH0fqoioIJXbCDWsiWzA==
X-Received: by 2002:a17:906:187:b0:a28:ba5d:e786 with SMTP id 7-20020a170906018700b00a28ba5de786mr403440ejb.14.1704366142345;
        Thu, 04 Jan 2024 03:02:22 -0800 (PST)
Received: from [192.168.0.182] (host-79-44-11-154.retail.telecomitalia.it. [79.44.11.154])
        by smtp.gmail.com with ESMTPSA id mz14-20020a1709071b8e00b00a27a17543d2sm5729862ejc.170.2024.01.04.03.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 03:02:21 -0800 (PST)
Message-ID: <87d33909-ef8c-43a6-a556-d01fe692d5cd@redhat.com>
Date: Thu, 4 Jan 2024 12:02:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/stats: Fix rt/dl task's sched latency statistics
 error in sched_stat_wait trace_point
To: Junwen Wu <wudaemon@163.com>, mingo@redhat.com, laoar.shao@gmail.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com
Cc: mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20240101031704.227541-1-wudaemon@163.com>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240101031704.227541-1-wudaemon@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Junwen

s/trace_point/tracepoint/g

On 1/1/24 04:17, Junwen Wu wrote:
> When enable sched_stat_wait trace_point, some rt tasks sched latency so long, like this,
> sched_stat_wait: comm=rcu_preempt pid=14 delay=4936139545261 [ns]
> Rt task has low latency, it must have a bug. When rt task balance off source cpu,
> dequeue operation not update the sched_statistics, so follow update_stats_wait_end_fair
> update method, so do dl tasks.

This is a little bit hard to read, how about something like this?

The sched_stat_wait tracepoint is showing unreasonably long
latencies for real-time tasks. For example:

sched_stat_wait: comm=rcu_preempt pid=14 delay=4936139545261 [ns]

This error happens when the rt task balances off the source CPU because
the dequeue operation is not updating the sched_statistics. So, follow
update_stats_wait_end_fair() and update the stats. Do the same for
SCHED_DEADLINE.

[ feel free to change ]

> 
> Fixes: 57a5c2dafca8 ("sched/rt: Support schedstats for RT sched class")
> Fixes: b5eb4a5f6521 ("sched/dl: Support schedstats for deadline sched class")
> Signed-off-by: Junwen Wu <wudaemon@163.com>
> ---
>  kernel/sched/deadline.c | 8 +++++++-
>  kernel/sched/rt.c       | 7 +++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index b28114478b82..29223163ee22 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1558,10 +1558,16 @@ update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
>  			int flags)
>  {
>  	struct task_struct *p = dl_task_of(dl_se);
> +	struct rq *rq = rq_of_dl_rq(dl_rq);
>  
>  	if (!schedstat_enabled())
>  		return;
> -
> +	/*
> +	 * Mark the end of the wait period
> +	 * if dequeueing a waiting task.
> +	 */
make this a single line comment.

> +	if (p && (p != rq->curr))
> +		 update_stats_wait_end_dl(dl_rq, dl_se);
>  	if ((flags & DEQUEUE_SLEEP)) {
>  		unsigned int state;
>  
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 6aaf0a3d6081..6a2600213991 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1360,12 +1360,19 @@ update_stats_dequeue_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se,
>  			int flags)
>  {
>  	struct task_struct *p = NULL;
> +	struct rq *rq = rq_of_rt_se(rt_se);
>  
>  	if (!schedstat_enabled())
>  		return;
>  
>  	if (rt_entity_is_task(rt_se))
>  		p = rt_task_of(rt_se);
> +	 /*
> +	  * Mark the end of the wait period
> +	  * if dequeueing a waiting task.
> +	  */

ditto

-- Daniel


