Return-Path: <linux-kernel+bounces-98503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A4F877B04
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 07:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7AB1F21037
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F9D10A3D;
	Mon, 11 Mar 2024 06:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="VbsbjUjH"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDC010A12
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 06:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710139443; cv=none; b=mL758/bVwFXq4hWfLcsmUF/UHIB3icziAoqY2ZdqvGAlCUT30aCG5h7yi09hWVhizAel8W1EV0Wde9uoFa6mlGEgnwPNghZ/u/1CWcY6iuaZmHegA6/NpvHYbqt2QWhNjw540QYPfRSuIcVUIgUe04xhmFPPBIYiD1WSG3OhlAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710139443; c=relaxed/simple;
	bh=VC9B5GL1Fmhhu/UKn79agt96hAl0Zx/L2WrNYkyr6wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=upbiddhzPLTiTRihN9UBO/AYc0G1qfm/72pji8QI8IcxSD6lNZt/W1ParXWmBAJGVg64vS9MGUnEEtvyw3l9wWltsf+9LPfuQe549QK7AAWMm6PLHk/4KTOxdqxiCBb3s7vKHNHd5/X0FOFo0Y5o2KV1G8tLigveGTYGKpMnKiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=VbsbjUjH; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=yExOc+EMUi+z+5D1CQBKSzXFMQrae+6bdw58/Lsf4QE=;
	b=VbsbjUjHSKVbbDWyUGlbk6DYfI/YlOGLuYHGSclgvmMasy8f4zZjgGH1uhXTGz
	2Ux1GD+4NTcHX7+p/q2tBOSdASwYYYk/SyUQIZgZ/hak3TlulUEPF5Uvty+fCQgn
	z3CE2tYYU+kXvl2rW8csyCDnfgsvaSm87GSOzF8gW66nw=
Received: from [172.24.140.12] (unknown [111.204.182.99])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wDXfxbvp+5l4NOKAA--.58650S2;
	Mon, 11 Mar 2024 14:42:57 +0800 (CST)
Message-ID: <f5687abb-cab7-497d-a997-572358d3807b@126.com>
Date: Mon, 11 Mar 2024 14:42:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] sched/balancing: Rename update_blocked_averages()
 => sched_balance_update_blocked_averages()
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
References: <20240308111819.1101550-1-mingo@kernel.org>
 <20240308111819.1101550-10-mingo@kernel.org>
Content-Language: en-US
From: Honglei Wang <jameshongleiwang@126.com>
In-Reply-To: <20240308111819.1101550-10-mingo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDXfxbvp+5l4NOKAA--.58650S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFWrJF4kCr48Ary7Xw48tFb_yoW5Xr4Dpr
	WqkF10yw4Dt34rXas2ya18urW3Ww17J34a9FnrJF95Ars8tas3trn2gr1fWr40vr1rCr4a
	vF1jvrW7Aa1Iqr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOiSdUUUUU=
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbiYBKerWV20GqJhQAAsk



On 2024/3/8 19:18, Ingo Molnar wrote:
> Standardize scheduler load-balancing function names on the
> sched_balance_() prefix.
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>   kernel/sched/fair.c | 8 ++++----
>   kernel/sched/pelt.c | 2 +-
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 96a81b2fa281..95f7092043f3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9411,7 +9411,7 @@ static unsigned long task_h_load(struct task_struct *p)
>   }
>   #endif
>   
> -static void update_blocked_averages(int cpu)
> +static void sched_balance_update_blocked_averages(int cpu)
>   {
>   	bool decayed = false, done = true;
>   	struct rq *rq = cpu_rq(cpu);
> @@ -12079,7 +12079,7 @@ static bool update_nohz_stats(struct rq *rq)
>   	if (!time_after(jiffies, READ_ONCE(rq->last_blocked_load_update_tick)))
>   		return true;
>   
> -	update_blocked_averages(cpu);
> +	sched_balance_update_blocked_averages(cpu);
>   
>   	return rq->has_blocked_load;
>   }
> @@ -12339,7 +12339,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>   	raw_spin_rq_unlock(this_rq);
>   
>   	t0 = sched_clock_cpu(this_cpu);
> -	update_blocked_averages(this_cpu);
> +	sched_balance_update_blocked_averages(this_cpu);
>   
>   	rcu_read_lock();
>   	for_each_domain(this_cpu, sd) {
> @@ -12431,7 +12431,7 @@ static __latent_entropy void sched_balance_softirq(struct softirq_action *h)
>   		return;
>   
>   	/* normal load balance */
> -	update_blocked_averages(this_rq->cpu);
> +	sched_balance_update_blocked_averages(this_rq->cpu);
>   	sched_balance_domains(this_rq, idle);
>   }
>   
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index 63b6cf898220..f80955ecdce6 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -209,7 +209,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
>   	 * This means that weight will be 0 but not running for a sched_entity
>   	 * but also for a cfs_rq if the latter becomes idle. As an example,
>   	 * this happens during idle_balance() which calls

Could we also fix this ghost idle_balance() in this serial (maybe in 
patch 10)?

Honglei
> -	 * update_blocked_averages().
> +	 * sched_balance_update_blocked_averages().
>   	 *
>   	 * Also see the comment in accumulate_sum().
>   	 */


