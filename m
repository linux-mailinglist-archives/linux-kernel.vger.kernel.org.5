Return-Path: <linux-kernel+bounces-6937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C15819F83
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A6521C2312C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E989325556;
	Wed, 20 Dec 2023 13:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sq+jS35A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4948825544
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 13:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C0AC433C8;
	Wed, 20 Dec 2023 13:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703077749;
	bh=zwfua6khaH8XifpKNVZW7yFKmvOSh56KeEdAjdJ7HoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sq+jS35AmB+KzlkQvZ4XnYMPPqrNephWbADrMzu/danghSZV4HDfyVV+hSPKpZAqK
	 gjlx469YuxBUvc7rwZuORYpiH57xqfQK189MJ7eRlT7cgCo8obL155Eg9NZG1I50+0
	 hIv7XFacM1XhkEnXcbF2g/QyEWrPh/UkvzgtojG8GDk9nEarCoGgD37x2/vW0Wa78l
	 N4SucXtsh3aqABXZpyCRE0LYt0rshbZUfYYjJVFMhw++V3KvzmNnM+LXED0g+2VzTT
	 Q1JXlvQhVGTXnghQx1kgH9vgB+7QN8QNdvaOKmuULQXwRy22lzcXhDsoymIdn4wStu
	 QKVBXwbnbywBg==
Date: Wed, 20 Dec 2023 14:09:06 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v9 01/32] tick-sched: Fix function names in comments
Message-ID: <ZYLncuCz1P_Y2hYW@localhost.localdomain>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-2-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231201092654.34614-2-anna-maria@linutronix.de>

Le Fri, Dec 01, 2023 at 10:26:23AM +0100, Anna-Maria Behnsen a écrit :
> When referencing functions in comments, it might be helpful to use full
> function names (including the prefix) to be able to find it when grepping.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Just a small detail that be addressed as a further patch (or edited
while applying).

> ---
> v9: New cleanup patch
> ---
>  kernel/time/tick-sched.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index be77b021e5d6..5c28cc80fd25 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -920,11 +920,11 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
>  	}
>  
>  	/*
> -	 * nohz_stop_sched_tick() can be called several times before
> -	 * nohz_restart_sched_tick() is called. This happens when
> -	 * interrupts arrive which do not cause a reschedule. In the
> -	 * first call we save the current tick time, so we can restart
> -	 * the scheduler tick in nohz_restart_sched_tick().
> +	 * tick_nohz_stop_sched_tick() can be called several times before

s/tick_nohz_stop_sched_tick/tick_nohz_stop_tick

Because in the case of nohz_full it's indeed true. But idle behaves the same
even though it uses another function (tick_nohz_idle_stop_tick()).

More generally tick_nohz_stop_tick() covers both idle and nohz_full case
and behaves as described.

I guess at some point we should rename tick_nohz_stop_sched_tick() to
tick_nohz_full_stop_tick() to avoid such confusion.

Thanks.

> +	 * tick_nohz_restart_sched_tick() is called. This happens when
> +	 * interrupts arrive which do not cause a reschedule. In the first call
> +	 * we save the current tick time, so we can restart the scheduler tick
> +	 * in tick_nohz_restart_sched_tick().
>  	 */
>  	if (!ts->tick_stopped) {
>  		calc_load_nohz_start();
> -- 
> 2.39.2
> 

