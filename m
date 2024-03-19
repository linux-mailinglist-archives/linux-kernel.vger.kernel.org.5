Return-Path: <linux-kernel+bounces-108051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC4D88053D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3D2282CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059FA39FD0;
	Tue, 19 Mar 2024 19:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Chouh1d6"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544BD39ACD;
	Tue, 19 Mar 2024 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710875235; cv=none; b=Cp4tJWW0Xt9qdOQBPqnf0YeswlueJ8zwXsV1hDO4xjgh3VkPGNsqqg2lwj4Rj09JClrjQiyzS2nXfy5+1MHNaXxjUqFPFELZiUNelSoxM9Ndwll4Fez2SnQYbYexR8PEg1CSX950wK58eVVA1g38LSnE2gHilKYQBlsmJ3z8qlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710875235; c=relaxed/simple;
	bh=tSa49TrlycOM6gXRUa0ObS0bNE/iFyg/jrTLqtKq8Go=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPID8UBcghOQjTi1tzgdTmzInJqEUH1TFbnpnGpOlOuwU4H+YmMLfZnOvB2glkjmuTU8mFEzYQzbGULiSeV9e5VJsuQ4KZuEAJoh0TIrtRHW3oz4wmgjvMHymH99EInPRkz3sFvGjZ60cwsSwqEPb9a9OoUV8TXCCPmGoQG5LhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Chouh1d6; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513d4559fb4so7249208e87.3;
        Tue, 19 Mar 2024 12:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710875231; x=1711480031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AUqq6M7QbD93YBO/FqbqAorR5WWxeKUSbQrTCwvKeCI=;
        b=Chouh1d6UhF30AgQasXd5w6K+VmJMHAAPPeRSAZTk6SXwme8CrQ8LsoCxd7kPhCzhc
         IBsy70Oef+cZiMBKRZqXJp90yivrYucUrahHNhPF4l2nIBB+U9Hx9bF3i4MueesZU1NP
         EX/UmSxqtNq9mF/csl1WgK3aDUBCGhhm7Y2NNdY5ffCwWyeeQf4nsFf/McHqMz+kpCDI
         KCJmyvEFpZIUHGJ53t7H2uPNOs3vAw5AsSpVsIjOUCyPcVlz2BUCxo4fEUHwiK7lwq5T
         dawOjcxWOtQrvjTWgu0Ba6bUBI6cvQKozbCualAosJ1gzrcA7fT+k903Nlxllo7SmZdN
         DC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710875231; x=1711480031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUqq6M7QbD93YBO/FqbqAorR5WWxeKUSbQrTCwvKeCI=;
        b=ix86P6RmxuV2V8p5vMjt35xSLWVck6gSj/qox8qCg5rHxN0LLcjMjCavrOXA4Ki34e
         K8TvPrPw+isLXcVFlJWv6Tv986gC8aDTIQqf4Jj29+MZ8R5c8zFjD25mIR8M26zET5pN
         yaRl8OZ7f7X/lNjYxAoisL+LwaLD/FjDb6DPYxZIj1JWl/aoCw8DlYJvcuiPQcKwveeq
         gRlTTAPvAvD+UrEkdmW22Qp8LSmSriSctx+DLGmxnebVtdfLjeQTUhUpHUyVYutmIW1X
         5mJWsDnitbryuEHTuiJKoM+Ce9NM1MfW0i7shhwp1EeommYc/0aiBvqApdsbj3zyeZ0p
         XjSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkwz4M3wASUPi8btF0ixxuYS7wAdXk3JSQ0kWvaXVUTtTL+dihcJZN8CqaHGZrFN+AssuklxbO7feXp4M49vV1yqcV+OI6spVfEgKvgWwU/Uk/yM5Lksw9nMOmhJhcB0au
X-Gm-Message-State: AOJu0YxKtc5oXq9t/2Ib0nKAEfcXHEzh+O5fb7jyf0tTnl3JVphy8Ehl
	cTwbIGk0LjEYxRtZKGfXZKyzZF8I4iFqd7dz34d0eYhEVNC6kYqA
X-Google-Smtp-Source: AGHT+IHwLzYFrNpFkWiKw8I6of1o5X2JVa/MMLa4Jo1sZRXfgQt3hakco/XhjW6HObHAqxWHCylsIA==
X-Received: by 2002:ac2:46e3:0:b0:513:d8b4:bfd1 with SMTP id q3-20020ac246e3000000b00513d8b4bfd1mr59096lfo.18.1710875231149;
        Tue, 19 Mar 2024 12:07:11 -0700 (PDT)
Received: from pc636 (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id m21-20020a194355000000b00513da68c536sm1619966lfj.152.2024.03.19.12.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 12:07:10 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 19 Mar 2024 20:07:08 +0100
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
	frederic@kernel.org, boqun.feng@gmail.com, neeraj.iitr10@gmail.com,
	rcu@vger.kernel.org, rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 rcu/dev 1/2] rcu/tree: Reduce wake up for
 synchronize_rcu() common case
Message-ID: <ZfniXAT6GOL7yy8B@pc636>
References: <ZflgfrjZSZdqrLLw@pc636>
 <0B372386-9546-492E-930E-DC6C883F3B2B@joelfernandes.org>
 <ZfmlziaLw1bl4IjX@pc636>
 <20240319160252.GA186534@joelbox2>
 <CAEXW_YTVNb_NpM8bY4KU60tvd0s-iVQ0AZs1s+LFk-Ux51++6Q@mail.gmail.com>
 <ZfnKv1K85Nkwy7p4@pc638.lan>
 <8f221ab6-6d34-4c3b-a6a7-6c1de405000a@joelfernandes.org>
 <851d8642-807c-481a-91e9-8b744c24913d@joelfernandes.org>
 <Zfnbc83lU6t8nIao@pc636>
 <1f7821ce-c036-4824-bb22-6d171714babf@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f7821ce-c036-4824-bb22-6d171714babf@joelfernandes.org>

On Tue, Mar 19, 2024 at 02:52:43PM -0400, Joel Fernandes wrote:
> 
> 
> On 3/19/2024 2:37 PM, Uladzislau Rezki wrote:
> > On Tue, Mar 19, 2024 at 01:33:11PM -0400, Joel Fernandes wrote:
> 
> >>> On 3/19/2024 1:26 PM, Uladzislau Rezki wrote:
> 
> >>>>>>>>>>>> /*
> >>>>>>>>>>>> @@ -1673,7 +1680,7 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> >>>>>>>>>>>> */
> >>>>>>>>>>>> static void rcu_sr_normal_gp_cleanup(void)
> >>>>>>>>>>>> {
> >>>>>>>>>>>> -    struct llist_node *wait_tail, *next, *rcu;
> >>>>>>>>>>>> +    struct llist_node *wait_tail, *next = NULL, *rcu = NULL;
> >>>>>>>>>>>>   int done = 0;
> >>>>>>>>>>>>
> >>>>>>>>>>>>   wait_tail = rcu_state.srs_wait_tail;
> >>>>>>>>>>>> @@ -1699,16 +1706,35 @@ static void rcu_sr_normal_gp_cleanup(void)
> >>>>>>>>>>>>           break;
> >>>>>>>>>>>>   }
> >>>>>>>>>>>>
> >>>>>>>>>>>> -    // concurrent sr_normal_gp_cleanup work might observe this update.
> >>>>>>>>>>>> -    smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> >>>>>>>>>>>> +    /*
> >>>>>>>>>>>> +     * Fast path, no more users to process. Remove the last wait head
> >>>>>>>>>>>> +     * if no inflight-workers. If there are in-flight workers, let them
> >>>>>>>>>>>> +     * remove the last wait head.
> >>>>>>>>>>>> +     */
> >>>>>>>>>>>> +    WARN_ON_ONCE(!rcu);
> >>>>>>>>>>>>
> >>>>>>>>>>> This assumption is not correct. An "rcu" can be NULL in fact.
> >>>>>>>>>>
> >>>>>>>>>> Hmm I could never trigger that. Are you saying that is true after Neeraj recent patch or something else?
> >>>>>>>>>> Note, after Neeraj patch to handle the lack of heads availability, it could be true so I requested
> >>>>>>>>>> him to rebase his patch on top of this one.
> >>>>>>>>>>
> >>>>>>>>>> However I will revisit my patch and look for if it could occur but please let me know if you knew of a sequence of events to make it NULL.
> >>>>>>>>>>>
> >>>>>>>>> I think we should agree on your patch first otherwise it becomes a bit
> >>>>>>>>> messy or go with a Neeraj as first step and then work on youth. So, i
> >>>>>>>>> reviewed this patch based on latest Paul's dev branch. I see that Neeraj
> >>>>>>>>> needs further work.
> >>>>>>>>
> >>>>>>>> You are right. So the only change is to drop the warning and those braces. Agreed?
> >>>>>>>>
> >>>>>>> Let me check a bit. Looks like correct but just in case.
> >>>>>>>
> >>>>>>
> >>>>>> Thanks. I was also considering improving it for the rcu == NULL case, as
> >>>>>> below. I will test it more before re-sending.
> >>>>>>
> >>>>>> On top of my patch:
> >>>>>>
> >>>>>> ---8<-----------------------
> >>>>>>
> >>>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >>>>>> index 0df659a878ee..a5ef844835d4 100644
> >>>>>> --- a/kernel/rcu/tree.c
> >>>>>> +++ b/kernel/rcu/tree.c
> >>>>>> @@ -1706,15 +1706,18 @@ static void rcu_sr_normal_gp_cleanup(void)
> >>>>>>                         break;
> >>>>>>         }
> >>>>>>
> >>>>>> +
> >>>>>> +       /* Last head stays. No more processing to do. */
> >>>>>> +       if (!rcu)
> >>>>>> +               return;
> >>>>>> +
> >>>>>
> >>>>> Ugh, should be "if (!wait_head->next)"  instead of "if (!rcu)".  But
> >>>>> in any case, the original patch except the warning should hold.
> >>>>> Still, I am testing the above diff now.
> >>>>>
> >>>>>  - Joel
> >>>>>
> >>>> Just in case, it is based on your patch:
> >>>>
> >>>> <snip>
> >>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >>>> index bd29fe3c76bf..98546afe7c21 100644
> >>>> --- a/kernel/rcu/tree.c
> >>>> +++ b/kernel/rcu/tree.c
> >>>> @@ -1711,29 +1711,25 @@ static void rcu_sr_normal_gp_cleanup(void)
> >>>>  	 * if no inflight-workers. If there are in-flight workers, let them
> >>>>  	 * remove the last wait head.
> >>>>  	 */
> >>>> -	WARN_ON_ONCE(!rcu);
> >>>> -	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
> >>>> -
> >>>> -	if (rcu && rcu_sr_is_wait_head(rcu) && rcu->next == NULL &&
> >>>> -		/* Order atomic access with list manipulation. */
> >>>> -		!atomic_read_acquire(&rcu_state.srs_cleanups_pending)) {
> >>>> +	if (wait_tail->next && rcu_sr_is_wait_head(wait_tail->next) && !wait_tail->next->next &&
> >>>> +			!atomic_read_acquire(&rcu_state.srs_cleanups_pending)) {
> >>>
> >>>
> >>> Yes this also works. But also if wait_tail->next == NULL, then you do not need
> >>> to queue worker for that case as well. I sent this as v3.
> >>>
> >> Sorry, I see you did add that later in the patch ;-). I think we have converged
> >> on the final patch then, give or take the use of 'rcu' versus 'wait_tail->next'.
> >>
> > Just combine all parts into one place and resend :)
> 
> Yes sir ;)
> 
Ha-ha :)))))

--
Uladzislau Rezki

