Return-Path: <linux-kernel+bounces-111363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56083886B41
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6441B20FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0533D3F9C3;
	Fri, 22 Mar 2024 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OkJ+CH5o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DHoG41s+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F113EA66;
	Fri, 22 Mar 2024 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711106659; cv=none; b=rwNPRLjT8h16KSrxKmtfwZX7WmiPXfOmiA/vbPiR70VFd1R0+aZNpXQxruK6LjhPU/dHQ7C5zCjje/5bnWnQrUp7s48Jkl71SC5dvObI6SEbsgYAGARdZVA6KvUnzdTtvfTOhqAqdStkd5xESP+Wl0rBRHDp9JWYBzLGTy9vxkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711106659; c=relaxed/simple;
	bh=+oC+fGntP89wG2FVGQS+dTS5BaJOhf8efmrV699I1qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkVpKEK8fgISfKezubyqpC5iF9rNOOwRL8Vr9IPgPkz5xmMXCohB3e93TDdOjEVKN57aIEBEIOhso/JU50aW37a3cIxVs+LeFaSsI2UYTwxhXaenWN7zMHAeBtRS6RqpzMHLThJ7QOlS2C+8lpQL+aA/CR8U7O4AbdglXM7IYYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OkJ+CH5o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DHoG41s+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 22 Mar 2024 12:24:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711106655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tTCYSECJaDRw2zJqZDfA9T1Nb/hL8dmz0bj0oyPmoJQ=;
	b=OkJ+CH5okK8fKJ/tI2f6lw1iTxPpCit4ZBOGCrIaFom8TLfSRZXfbSAFLSr832IeMuuVaj
	ao8pSQrhkDXHYZDa6v/5oZhflyY5wGvOzTp+dTTyLo2oU12knLaXEycRRDAbAysizOsqu2
	y/i3B0dafLaGNXlWlB6Fqriosd3RLrcgo0S4LfPf3mYWEgIrHkQ7mJuv1v99NDRXeeoKvd
	bT8WndvXS0SV2LsBl6RMsg6yAGqwxwa87tPlUk9Ud2950u/22c5EV5K3vxvcKyvZYqcBva
	gchOFhx1wCw3MVIaH/HwU2Gw4YB/My58WUdxmleko3WwgUPtFtYq98VNIGJD9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711106655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tTCYSECJaDRw2zJqZDfA9T1Nb/hL8dmz0bj0oyPmoJQ=;
	b=DHoG41s+SLo2p1pHPoZSvaJTTSbmWZY8A1bvlCemaX2bXGzdq6MwSWnoBzDcj+v+dPV+gS
	rTid4OVkqYuAGUDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com,
	Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com,
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH v5 net 1/3] rcu: add a helper to report consolidated
 flavor QS
Message-ID: <20240322112413.1UZFdBq5@linutronix.de>
References: <cover.1710877680.git.yan@cloudflare.com>
 <90431d46ee112d2b0af04dbfe936faaca11810a5.1710877680.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <90431d46ee112d2b0af04dbfe936faaca11810a5.1710877680.git.yan@cloudflare.com>

On 2024-03-19 13:44:34 [-0700], Yan Zhai wrote:
> index 16f519914415..17d7ed5f3ae6 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -247,6 +247,37 @@ do { \
>  	cond_resched(); \
>  } while (0)
>  
> +/**
> + * rcu_softirq_qs_periodic - Report RCU and RCU-Tasks quiescent states
> + * @old_ts: jiffies at start of processing.
> + *
> + * This helper is for long-running softirq handlers, such as NAPI threads in
> + * networking. The caller should initialize the variable passed in as @old_ts
> + * at the beginning of the softirq handler. When invoked frequently, this macro
> + * will invoke rcu_softirq_qs() every 100 milliseconds thereafter, which will
> + * provide both RCU and RCU-Tasks quiescent states. Note that this macro
> + * modifies its old_ts argument.
> + *
> + * Because regions of code that have disabled softirq act as RCU read-side
> + * critical sections, this macro should be invoked with softirq (and
> + * preemption) enabled.
> + *
> + * The macro is not needed when CONFIG_PREEMPT_RT is defined. RT kernels would
> + * have more chance to invoke schedule() calls and provide necessary quiescent
> + * states. As a contrast, calling cond_resched() only won't achieve the same
> + * effect because cond_resched() does not provide RCU-Tasks quiescent states.
> + */

Paul, so CONFIG_PREEMPTION is affected but CONFIG_PREEMPT_RT is not.
Why does RT have more scheduling points?
The RCU-Tasks thread is starving and yet there is no wake-up, correct?
Shouldn't cond_resched() take care of RCU-Tasks's needs, too?
This function is used by napi_threaded_poll() which is not invoked in
softirq it is a simple thread which does disable BH but this is it. Any
pending softirqs are served before the cond_resched().

This napi_threaded_poll() case _basically_ a busy thread doing a lot of
work and delaying RCU-Tasks as far as I understand. The same may happen
to other busy-worker which have cond_resched() between works, such as
the kworker. Therefore I would expect to have some kind of timeout at
which point NEED_RESCHED is set so that cond_resched() can do its work.

> +#define rcu_softirq_qs_periodic(old_ts) \
> +do { \
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && \
> +	    time_after(jiffies, (old_ts) + HZ / 10)) { \
> +		preempt_disable(); \
> +		rcu_softirq_qs(); \
> +		preempt_enable(); \
> +		(old_ts) = jiffies; \
> +	} \
> +} while (0)
> +
>  /*
>   * Infrastructure to implement the synchronize_() primitives in
>   * TREE_RCU and rcu_barrier_() primitives in TINY_RCU.

Sebastian

