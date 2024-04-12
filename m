Return-Path: <linux-kernel+bounces-143231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE688A35FE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D09F1B23C45
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4793114F119;
	Fri, 12 Apr 2024 18:49:20 +0000 (UTC)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80025502A9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947759; cv=none; b=cGAVveQ5ilB66XxE3AGglaxCri+hzKkKEh/pJ2trnQ/6r+C6OJRX/ysBWRxrpiv+W8JbmGUvFKmBZUqLka9KDsMIp1n29dMBuCuumrt2HB4vyq0MvRt3SvLn8wmZtqL6QtJrql60hxMQ9peED6Ew2O33FRXnWNchs51W6W7CZiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947759; c=relaxed/simple;
	bh=WL02eMPK9kYb8AHXo+4G5xTitIGi9yc8qzdDfjjUvyc=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=myjGIXzZZkG7w2awSaYMZSnoGo1F1uLobIrseu7LHMDfWoe1Rx/DFVYLXUWKGt2RxuOqVb9NxnzfTVpscc+hWjjzjrifNXyula5WZ9qT17gFbSm9W2uzk8cBjwHol5MTKTkHg1qf19hS5uQdo078X0vRoZo8vTQ+sgTnGSbPVFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:54098)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rvLaU-004DCh-N4; Fri, 12 Apr 2024 12:25:22 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54354 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rvLaT-002OFR-Ol; Fri, 12 Apr 2024 12:25:22 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Thomas Flexing <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,  Anna-Maria Behnsen
 <anna-maria@linutronix.de>,  Frederic Weisbecker <frederic@kernel.org>,
  John Stultz <jstultz@google.com>,  Peter Zijlstra <peterz@infradead.org>,
  Ingo Molnar <mingo@kernel.org>,  Stephen Boyd <sboyd@kernel.org>,  Oleg
 Nesterov <oleg@redhat.com>
References: <20240410164558.316665885@linutronix.de>
	<20240410165551.376994018@linutronix.de>
Date: Fri, 12 Apr 2024 13:25:01 -0500
In-Reply-To: <20240410165551.376994018@linutronix.de> (Thomas Gleixner's
	message of "Thu, 11 Apr 2024 00:46:24 +0200 (CEST)")
Message-ID: <87mspyxwua.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1rvLaT-002OFR-Ol;;;mid=<87mspyxwua.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+kLfRcCRwZMP9fO8LyOXbmukixHHSgBCY=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  0.5 XMGappySubj_01 Very gappy subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 T_TooManySym_04 7+ unique symbols in subject
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Thomas Flexing <tglx@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 426 ms - load_scoreonly_sql: 0.07 (0.0%),
	signal_user_changed: 11 (2.5%), b_tie_ro: 9 (2.2%), parse: 0.96 (0.2%),
	 extract_message_metadata: 12 (2.7%), get_uri_detail_list: 1.71 (0.4%),
	 tests_pri_-2000: 6 (1.4%), tests_pri_-1000: 2.6 (0.6%),
	tests_pri_-950: 1.23 (0.3%), tests_pri_-900: 0.94 (0.2%),
	tests_pri_-90: 84 (19.7%), check_bayes: 82 (19.4%), b_tokenize: 8
	(1.9%), b_tok_get_all: 7 (1.7%), b_comp_prob: 2.1 (0.5%),
	b_tok_touch_all: 62 (14.6%), b_finish: 0.85 (0.2%), tests_pri_0: 294
	(69.0%), check_dkim_signature: 0.59 (0.1%), check_dkim_adsp: 2.7
	(0.6%), poll_dns_idle: 0.93 (0.2%), tests_pri_10: 2.1 (0.5%),
	tests_pri_500: 8 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [patch V2 07/50] posix-cpu-timers: Split up posix_cpu_timer_get()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Thomas Gleixner <tglx@linutronix.de> writes:

> In preparation for addressing issues in the timer_get() and timer_set()
> functions of posix CPU timers.

To see that this was safe I had to lookup and see that
cpu_timer_getexpires is a truly trivial function.

static inline u64 cpu_timer_getexpires(struct cpu_timer *ctmr)
{
	return ctmr->node.expires;
}

I am a bit confused by the purpose of this function in
posix-cpu-timers.c.  In some places this helper is used (like below),
and in other places like bump_cpu_timer the expires member is
accessed directly.

It isn't really a problem, but it is something that might be
worth making consistent in the code to make it easier to read.

Eric

> No functional change.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: Split out into new patch to make review simpler - Frederic
> ---
>  kernel/time/posix-cpu-timers.c |   51 +++++++++++++++++++----------------------
>  1 file changed, 24 insertions(+), 27 deletions(-)
>
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -785,33 +785,9 @@ static int posix_cpu_timer_set(struct k_
>  	return ret;
>  }
>  
> -static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp)
> +static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp, u64 now)
>  {
> -	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
> -	struct cpu_timer *ctmr = &timer->it.cpu;
> -	u64 now, expires = cpu_timer_getexpires(ctmr);
> -	struct task_struct *p;
> -
> -	rcu_read_lock();
> -	p = cpu_timer_task_rcu(timer);
> -	if (!p)
> -		goto out;
> -
> -	/*
> -	 * Easy part: convert the reload time.
> -	 */
> -	itp->it_interval = ktime_to_timespec64(timer->it_interval);
> -
> -	if (!expires)
> -		goto out;
> -
> -	/*
> -	 * Sample the clock to take the difference with the expiry time.
> -	 */
> -	if (CPUCLOCK_PERTHREAD(timer->it_clock))
> -		now = cpu_clock_sample(clkid, p);
> -	else
> -		now = cpu_clock_sample_group(clkid, p, false);
> +	u64 expires = cpu_timer_getexpires(&timer->it.cpu);
>  
>  	if (now < expires) {
>  		itp->it_value = ns_to_timespec64(expires - now);
> @@ -823,7 +799,28 @@ static void posix_cpu_timer_get(struct k
>  		itp->it_value.tv_nsec = 1;
>  		itp->it_value.tv_sec = 0;
>  	}
> -out:
> +}
> +
> +static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp)
> +{
> +	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
> +	struct task_struct *p;
> +	u64 now;
> +
> +	rcu_read_lock();
> +	p = cpu_timer_task_rcu(timer);
> +	if (p) {
> +		itp->it_interval = ktime_to_timespec64(timer->it_interval);
> +
> +		if (cpu_timer_getexpires(&timer->it.cpu)) {
> +			if (CPUCLOCK_PERTHREAD(timer->it_clock))
> +				now = cpu_clock_sample(clkid, p);
> +			else
> +				now = cpu_clock_sample_group(clkid, p, false);
> +
> +			__posix_cpu_timer_get(timer, itp, now);
> +		}
> +	}
>  	rcu_read_unlock();
>  }
>  

