Return-Path: <linux-kernel+bounces-2676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DBB81605B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2C231F21E39
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 16:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51EB45BE9;
	Sun, 17 Dec 2023 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="OoQ7xqfU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41D244C88
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40b5155e154so28023895e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 08:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1702829970; x=1703434770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VpgQuU2Mi03SNo7nMLIvXtsaJFrml4RGReO/JB+4P+8=;
        b=OoQ7xqfUZMo8TidtiTkJCAzu4JYuPrN7M1hun68NhigguiXn+3OThCWVA/hKGJNCBo
         WqJeKgiOWn22DpzN6geYz8WGwmD1c8w7owKzzpRRN+E9XD5DQFgNICPnLGP/lqwpzt2+
         TU2rZoYefZgULoZTFmCIV9ei1sndCFk5OuaGObyN9COKZUtBDMLDzQhHgiODitIGheoV
         FXCiwhXurukJXVFQz4pWFD+jOpSAGVVzgV/ro0ln9ZsLtMWQyY6Ta2xpP5mYZiAmrYi6
         djNAobQqdv0Zu1TxA+3MA4Rcb7R6aNqQ25iq6kxjvfXV8xbWrnu/iB4G3O8fWtk5JHbh
         e64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702829970; x=1703434770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpgQuU2Mi03SNo7nMLIvXtsaJFrml4RGReO/JB+4P+8=;
        b=D/GGX8K65HaMKCejOWIVmhSYtMEERK96GTC97lEm+SgH6C+2aRRbOfQpc7jFECSRHA
         Nid1fbPO3sCl1axmREcBwpiiVNW9+agjadAk+8I7BuO7MtNe9U+DlkT2RIbdxt5Setjq
         x6turPXfbsephnytG4gHJRfxlUccYkcb1ZBzcdCRy2J3FW0nB4Bkga/KzYvGKeC70Vbp
         VeU+Lu/IBUbtIUR+ykNyBNMrfh4zx1aKTC8qhi3jyvuLwn8exARUCHm+8kRG3se+6mc2
         ssSJFkHJOhcLBoauXlAC/espAWMxDgbqig+XxcYC5NFBwhF201kuKwJAHwUAtXfdYbbB
         kHIQ==
X-Gm-Message-State: AOJu0YxTGn+xWnPCOMCygbEIgup9eYnC5S2WcZgtSf1myBVy0F41fDXt
	K0+hMZ207UWzEVrr0XoM0Ak56/o+TCVYWsHwTfs=
X-Google-Smtp-Source: AGHT+IHPV9dmwKPXmOem17g+ssUBHDuk38t0PkHWRzcHkKXVgdPYOWmDjYZ0rxIYkt/ghWFYNhrTng==
X-Received: by 2002:a05:600c:5248:b0:40c:3e0a:692e with SMTP id fc8-20020a05600c524800b0040c3e0a692emr6804171wmb.232.1702829969876;
        Sun, 17 Dec 2023 08:19:29 -0800 (PST)
Received: from airbuntu (host86-135-101-43.range86-135.btcentralplus.com. [86.135.101.43])
        by smtp.gmail.com with ESMTPSA id j18-20020a05600c191200b0040c6b667dccsm11429183wmq.25.2023.12.17.08.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 08:19:29 -0800 (PST)
Date: Sun, 17 Dec 2023 16:19:27 +0000
From: Qais Yousef <qyousef@layalina.io>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com,
	Connor O'Brien <connoro@google.com>
Subject: Re: [PATCH v6 01/20] sched: Unify runtime accounting across classes
Message-ID: <20231217161927.vewygmvxvddhxs65@airbuntu>
References: <20231106193524.866104-1-jstultz@google.com>
 <20231106193524.866104-2-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231106193524.866104-2-jstultz@google.com>

On 11/06/23 19:34, John Stultz wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> All classes use sched_entity::exec_start to track runtime and have
> copies of the exact same code around to compute runtime.
> 
> Collapse all that.
> 
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Qais Yousef <qyousef@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Zimuzo Ezeozue <zezeozue@google.com>
> Cc: Youssef Esmat <youssefesmat@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "Paul E . McKenney" <paulmck@kernel.org>
> Cc: kernel-team@android.com
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> [fix conflicts, fold in update_current_exec_runtime]
> Signed-off-by: Connor O'Brien <connoro@google.com>
> [jstultz: rebased, resovling minor conflicts]
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> NOTE: This patch is a general cleanup and if no one objects
> could be merged at this point. If needed, I'll resend separately
> if it isn't picked up on its own.

Looks like this actually got merged into tip via the deadline server work :-)

Though not sure if I caught a bug here

> diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
> index 85590599b4d6..7595494ceb6d 100644
> --- a/kernel/sched/stop_task.c
> +++ b/kernel/sched/stop_task.c
> @@ -70,18 +70,7 @@ static void yield_task_stop(struct rq *rq)
>  
>  static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
>  {
> -	struct task_struct *curr = rq->curr;
> -	u64 now, delta_exec;
> -
> -	now = rq_clock_task(rq);
> -	delta_exec = now - curr->se.exec_start;
> -	if (unlikely((s64)delta_exec < 0))
> -		delta_exec = 0;

If negative instead of returning for stopper task; we set delta_exec to 0

> -
> -	schedstat_set(curr->stats.exec_max,
> -		      max(curr->stats.exec_max, delta_exec));
> -
> -	update_current_exec_runtime(curr, now, delta_exec);

And curry on to do time accounting

> +	update_curr_common(rq);

But the new function will return early without doing accounting. Wouldn't this
re-introrduce 8f6189684eb4 ("sched: Fix migration thread runtime bogosity")?

>  }


Cheers

--
Qais Yousef

