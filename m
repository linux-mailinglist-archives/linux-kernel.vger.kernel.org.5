Return-Path: <linux-kernel+bounces-162803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 573958B60BF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB7691F256C8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B27412B15A;
	Mon, 29 Apr 2024 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="paTPmGLj"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24ED12AAC8;
	Mon, 29 Apr 2024 17:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413092; cv=none; b=clvlNZ5ZYcHYsySRr0RvV8wy7CtXxl2qGnwnaabJhaP2yl/HCCWseSqvQruYgULdU7J/vXHpj2IQNhvhcso4SkKIQmFpnLBHiaqZgaigDkozvlGyJpaQVXN9rpXK60FUHbliT4+dktEwoW52a8Z2cM3bmH6S6rfwcDBJme5re7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413092; c=relaxed/simple;
	bh=t19PgdJpK6QrPLPRYG83UaeAXKiRFqADD1jgilmOirc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPKMPyG3GDkuvRCHH0r12OORooDCrWqfd/3UBrVU1fhilKVgfwO8TriZZGsm31dDsWxiKCfZnNQUTjoy/o52iOzMWrqm8ij/u/7y+aM683p5mB6ZPxAodhJ3ImIZ4aW4SzIPjnS0RgMemeodksWmz97/ZVhovVuME2xqOPCFIWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=paTPmGLj; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1714412575;
	bh=t19PgdJpK6QrPLPRYG83UaeAXKiRFqADD1jgilmOirc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=paTPmGLjUVBSJVvGRn8VWTzBxVO2DJr2CsBGm24/SdSCKJdlnNxCE4mf3xkvqRx7u
	 Oo5RY0ApG0ND7BBzzXYMQrZWB31Jdi8vedw1q1XP5QAzjAvO1Hya6B/8mrM2UPnYMU
	 kNrMeYX77Px1UnphTDPy/BCJi1W5HZ36sPLrqyeEPSDPGKT8RqWEb3sSrYEsreS1KK
	 ljsSDQmmvYGlOjRxY3KoOKj7noix9f/JmVEcXJ1oI82RLp3+LInCNAco5kVSpNzOOR
	 YjfJk1/u9lagoB72wyEcZO1x8mBAQesHnSb6mMBfBXvnaWqx/U6oWt7n/vwzIpVRQz
	 Bo1SyEyP/LeAA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4VSrJb0wQXzxfT;
	Mon, 29 Apr 2024 13:42:55 -0400 (EDT)
Message-ID: <bb48fdad-7a00-45da-b545-60517267a2c8@efficios.com>
Date: Mon, 29 Apr 2024 13:43:10 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Remove unreachable logic
To: Alan Huang <mmpgouride@gmail.com>, paulmck@kernel.org,
 frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org,
 josh@joshtriplett.org, boqun.feng@gmail.com, rostedt@goodmis.org,
 jiangshanlai@gmail.com, qiang.zhang1211@gmail.com
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240429173439.1685274-1-mmpgouride@gmail.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240429173439.1685274-1-mmpgouride@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-04-29 13:34, Alan Huang wrote:
> call_rcu_core is only called from __call_rcu_common with interrupt
> disabled. This patch thus removes the unreachable logic and the would-be
> unused 'flags' parameter.

Nack.

call_rcu_core() receives a @flags parameter which are the _saved_ flags
as they were prior to local_irq_save().

This patch highlights a misunderstanding of what the code is actually
doing.

Thanks,

Mathieu

> 
> Signed-off-by: Alan Huang <mmpgouride@gmail.com>
> ---
>   kernel/rcu/tree.c | 35 ++---------------------------------
>   1 file changed, 2 insertions(+), 33 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index d5507ac1bbf1..b0ea2ebd7769 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2983,7 +2983,7 @@ static void rcutree_enqueue(struct rcu_data *rdp, struct rcu_head *head, rcu_cal
>    * Handle any core-RCU processing required by a call_rcu() invocation.
>    */
>   static void call_rcu_core(struct rcu_data *rdp, struct rcu_head *head,
> -			  rcu_callback_t func, unsigned long flags)
> +			  rcu_callback_t func)
>   {
>   	rcutree_enqueue(rdp, head, func);
>   	/*
> @@ -2992,37 +2992,6 @@ static void call_rcu_core(struct rcu_data *rdp, struct rcu_head *head,
>   	 */
>   	if (!rcu_is_watching())
>   		invoke_rcu_core();
> -
> -	/* If interrupts were disabled or CPU offline, don't invoke RCU core. */
> -	if (irqs_disabled_flags(flags) || cpu_is_offline(smp_processor_id()))
> -		return;
> -
> -	/*
> -	 * Force the grace period if too many callbacks or too long waiting.
> -	 * Enforce hysteresis, and don't invoke rcu_force_quiescent_state()
> -	 * if some other CPU has recently done so.  Also, don't bother
> -	 * invoking rcu_force_quiescent_state() if the newly enqueued callback
> -	 * is the only one waiting for a grace period to complete.
> -	 */
> -	if (unlikely(rcu_segcblist_n_cbs(&rdp->cblist) >
> -		     rdp->qlen_last_fqs_check + qhimark)) {
> -
> -		/* Are we ignoring a completed grace period? */
> -		note_gp_changes(rdp);
> -
> -		/* Start a new grace period if one not already started. */
> -		if (!rcu_gp_in_progress()) {
> -			rcu_accelerate_cbs_unlocked(rdp->mynode, rdp);
> -		} else {
> -			/* Give the grace period a kick. */
> -			rdp->blimit = DEFAULT_MAX_RCU_BLIMIT;
> -			if (READ_ONCE(rcu_state.n_force_qs) == rdp->n_force_qs_snap &&
> -			    rcu_segcblist_first_pend_cb(&rdp->cblist) != head)
> -				rcu_force_quiescent_state();
> -			rdp->n_force_qs_snap = READ_ONCE(rcu_state.n_force_qs);
> -			rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
> -		}
> -	}
>   }
>   
>   /*
> @@ -3121,7 +3090,7 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
>   	if (unlikely(rcu_rdp_is_offloaded(rdp)))
>   		call_rcu_nocb(rdp, head, func, flags, lazy);
>   	else
> -		call_rcu_core(rdp, head, func, flags);
> +		call_rcu_core(rdp, head, func);
>   	local_irq_restore(flags);
>   }
>   

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


