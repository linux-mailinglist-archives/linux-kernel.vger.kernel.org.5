Return-Path: <linux-kernel+bounces-143219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E26B38A35E3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F70F1C22972
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E0114EC42;
	Fri, 12 Apr 2024 18:40:12 +0000 (UTC)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479881BF2F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947211; cv=none; b=jN/tmsJfAdZrvtTS77MCEx/nsWMBBS7A8xhpvSRz/FqeH4wvrSGONtdkShbCtowsD/5HNF7doK58QvxxujC74WdFaLkbDMr3/RyBnojKSfGnHPbFSHiFqhcZ3bQZoCrOoG6Z4LJLUu5s0++LheL7N4pDvfWHmPNMZmaUw6USHOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947211; c=relaxed/simple;
	bh=Lqx4NWcv2NfqHkrr6UplSqWQw6HN5M/MsiaQsX3BOTU=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=tuChugt+W5akIkZVgQxRF2kaxFQoLgml2jIkEJ4SZ+8Q5OCCWjbpp3swT6JXpuGMRyQdQ73hWC61eO2rGIqJ2qkSrKsS62Xn/5BI9AtFd/UVVQ7s8wjHH+y95OMkdoGXvKdzdrm3RLLjESoPw5L3y+Gn0Wn65/D10FviD9ga88Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:49452)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rvLon-004EQ7-36; Fri, 12 Apr 2024 12:40:09 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:36870 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rvLom-001tOR-4J; Fri, 12 Apr 2024 12:40:08 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,  Anna-Maria Behnsen
 <anna-maria@linutronix.de>,  Frederic Weisbecker <frederic@kernel.org>,
  John Stultz <jstultz@google.com>,  Peter Zijlstra <peterz@infradead.org>,
  Ingo Molnar <mingo@kernel.org>,  Stephen Boyd <sboyd@kernel.org>,  Oleg
 Nesterov <oleg@redhat.com>
References: <20240410164558.316665885@linutronix.de>
	<20240410165551.571240036@linutronix.de>
Date: Fri, 12 Apr 2024 13:40:02 -0500
In-Reply-To: <20240410165551.571240036@linutronix.de> (Thomas Gleixner's
	message of "Thu, 11 Apr 2024 00:46:29 +0200 (CEST)")
Message-ID: <87cyquxw59.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1rvLom-001tOR-4J;;;mid=<87cyquxw59.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19PsVGhf1Xt4dMzWW4n/IXnjYQH1v+ZSCc=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: 
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.0 T_TooManySym_04 7+ unique symbols in subject
	*  0.0 T_TooManySym_03 6+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Thomas Gleixner <tglx@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 393 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 4.5 (1.2%), b_tie_ro: 3.2 (0.8%), parse: 1.13
	(0.3%), extract_message_metadata: 12 (3.1%), get_uri_detail_list: 2.1
	(0.5%), tests_pri_-2000: 4.7 (1.2%), tests_pri_-1000: 2.1 (0.5%),
	tests_pri_-950: 1.05 (0.3%), tests_pri_-900: 0.79 (0.2%),
	tests_pri_-90: 73 (18.5%), check_bayes: 71 (18.1%), b_tokenize: 6
	(1.4%), b_tok_get_all: 7 (1.8%), b_comp_prob: 1.60 (0.4%),
	b_tok_touch_all: 54 (13.8%), b_finish: 0.73 (0.2%), tests_pri_0: 280
	(71.3%), check_dkim_signature: 0.63 (0.2%), check_dkim_adsp: 2.2
	(0.6%), poll_dns_idle: 0.58 (0.1%), tests_pri_10: 2.6 (0.7%),
	tests_pri_500: 8 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [patch V2 10/50] posix-cpu-timers: Handle SIGEV_NONE timers
 correctly in timer_get()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Thomas Gleixner <tglx@linutronix.de> writes:

> Expired SIGEV_NONE oneshot timers must return 0 nsec for the expiry time in
> timer_get(), but the posix CPU timer implementation returns 1 nsec.
>
> Add the missing conditional.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: Split out into new patch to make review simpler - Frederic
> ---
>  kernel/time/posix-cpu-timers.c |   14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -787,15 +787,17 @@ static int posix_cpu_timer_set(struct k_
>  
>  static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp, u64 now)
>  {
> +	bool sigev_none = timer->it_sigev_notify == SIGEV_NONE;
>  	u64 expires, iv = timer->it_interval;
>  
>  	/*
>  	 * Make sure that interval timers are moved forward for the
>  	 * following cases:
> +	 *  - SIGEV_NONE timers which are never armed
>  	 *  - Timers which expired, but the signal has not yet been
>  	 *    delivered
>  	 */
> -	if (iv && (timer->it_requeue_pending & REQUEUE_PENDING))
> +	if (iv && ((timer->it_requeue_pending & REQUEUE_PENDING) || sigev_none))
>  		expires = bump_cpu_timer(timer, now);
>  	else
>  		expires = cpu_timer_getexpires(&timer->it.cpu);
> @@ -809,11 +811,13 @@ static void __posix_cpu_timer_get(struct
>  		itp->it_value = ns_to_timespec64(expires - now);
>  	} else {
Why not make this else condition?
	} else if (!sigev_none) {
And not need to change the rest of the code?
>  		/*
> -		 * The timer should have expired already, but the firing
> -		 * hasn't taken place yet.  Say it's just about to expire.
> +		 * A single shot SIGEV_NONE timer must return 0, when it is
> +		 * expired! Timers which have a real signal delivery mode
> +		 * must return a remaining time greater than 0 because the
> +		 * signal has not yet been delivered.
>  		 */
> -		itp->it_value.tv_nsec = 1;
> -		itp->it_value.tv_sec = 0;
> +		if (!sigev_none)
> +			itp->it_value.tv_nsec = 1;

Do you perhaps need a comment somewhere that itp is zeroed in
do_timer_gettime?  The code now depends upon that for setting
itp->it_value when it did not used to, making it look at first
glance like you have created an uninitialized variable.

Probably just something in the description of the change would be
sufficient.

>  	}
>  }
>  

