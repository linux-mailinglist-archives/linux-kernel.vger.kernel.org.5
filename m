Return-Path: <linux-kernel+bounces-108026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2D28804F6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CE4CB22A81
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F50038DC3;
	Tue, 19 Mar 2024 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpUQmkJS"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD38A37153;
	Tue, 19 Mar 2024 18:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710873466; cv=none; b=spyiuw0kecBvsQ6S3GQu1v8hS4RRX1FkKwLjR7iHaimZbdOQKBd3RSlWReW1vGgNJ8aFUVIw5YdvRP4cZsGTb5MabQI2l34VCygGT2jkONZWqekLw8M4niFGZ5OkvPV/lQj3bbP65hiKlYDhI/mjtx+esEOgVl8JXLJrqTNoKlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710873466; c=relaxed/simple;
	bh=J30mbKBMKRdFBQwKPxaqEHtFeny0Lrqc1YIeLr7d5l0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jolFxEQfJy1GyTMMtalmOxFDSkOWZofWq7omqxKlsrjB7Tm65bZPTIrPHkVHLcjBcdfpfLQjOaMbOVHYVbb1MhrWYiT6mQS/093cPHomONNicShnCMX3CT+u0Ys2Gq9XfC41wK9hD4+UAY7zQ2XeeXrQfwYoj81T7Dg4sccA9OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpUQmkJS; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so72934101fa.3;
        Tue, 19 Mar 2024 11:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710873463; x=1711478263; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=shx+WmxRTJgTvdKuq66z/zl6CO70cxqhnYUobRSFA+8=;
        b=OpUQmkJSm4pDcT23YmXE5N9jfcw8iXFKG/E7i4ekR5jSKJL+woHoa/mSGHwNzncQwf
         fBKD3OcwltuDCsKp5XzkLqc56VdFa83/gEqfVx4dHDie+JNrYp6yI4W0uaQvRqgC+837
         dag7V5pVXQkX4/VNBbTWWxcoH4LspXpnEpwb+4L5yjhZz7PC6odZi67ls5ZjJ1ZJCCx9
         GD3G/rG7ummABOdN16ombVhYg8YYsHGgpf2ZLBl0QmMAd6YTVIJAnwHtCrOCQA9vo/+4
         m+tYov5Sgaf12t/h3jdgwM9GF7bwIGNqRd+d07mE63NWMH4pEtVI42C6+eRyvUIZ6TBR
         sOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710873463; x=1711478263;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=shx+WmxRTJgTvdKuq66z/zl6CO70cxqhnYUobRSFA+8=;
        b=aftulEO38dtTl+4fU+vReeGeb+6T2P2q77qpfOo60CfEGt+dh6DGDkAlC2rEH2Wa6v
         AGetFQ7YQCf4qP1AUmhHGBanAlEmsVt07Ylx5mCllM1kiAjYHcMcenF2gdxiAzojf2b+
         XVFaBhIufLGYGSaYDkJViQzau8srOBzDehNSej1qMfqS3Dfk2wbXV1e43DOzUFofqiwX
         jJzQdpNDbBXQeHnL6lMqBdLF4ej+i8ndnzmVKwmAh34zNIG8ppUUj7yZFuhlyJ78WQvi
         71Z2rtIE3+mgm9AkASUfptyM2L/4OJmcSMry8cAt0yI6NMr9VVTpDT+W8876+ipIUyt4
         DQuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHlz5lehN8GPus98qoXKmm9hYw3TeNf6Uks0Bgc3kafb7rvN9FThs4UhFmXv2ofXF9P1emPuf8lbDY3Djqey+Zi7Q1+N5eMKYzmmPeyNgRiszHpTaLWYabGyLq5aMVSo+1
X-Gm-Message-State: AOJu0Yzh8wXhhk1gQDFU4xUenWkDRvuUue69tyk1VuWfMh91lJt9Ymts
	940oYJ/7U9TsqG+LSwgtvw93X7yVePSW95VWy0BEiMD4NlwzX7OQ
X-Google-Smtp-Source: AGHT+IHFcvr65QDtSuKErQoWXKV0MnrkN2pl1lfxwvrVABnaEtCzmuW143kRFNMiiIlxUf4U4nbFJw==
X-Received: by 2002:a05:651c:8e:b0:2d4:9936:a45c with SMTP id 14-20020a05651c008e00b002d49936a45cmr6903287ljq.41.1710873462556;
        Tue, 19 Mar 2024 11:37:42 -0700 (PDT)
Received: from pc636 (host-90-235-3-101.mobileonline.telia.com. [90.235.3.101])
        by smtp.gmail.com with ESMTPSA id f14-20020a2e6a0e000000b002d0f0f5e395sm1891075ljc.47.2024.03.19.11.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 11:37:41 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 19 Mar 2024 19:37:39 +0100
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
Message-ID: <Zfnbc83lU6t8nIao@pc636>
References: <ZflgfrjZSZdqrLLw@pc636>
 <0B372386-9546-492E-930E-DC6C883F3B2B@joelfernandes.org>
 <ZfmlziaLw1bl4IjX@pc636>
 <20240319160252.GA186534@joelbox2>
 <CAEXW_YTVNb_NpM8bY4KU60tvd0s-iVQ0AZs1s+LFk-Ux51++6Q@mail.gmail.com>
 <ZfnKv1K85Nkwy7p4@pc638.lan>
 <8f221ab6-6d34-4c3b-a6a7-6c1de405000a@joelfernandes.org>
 <851d8642-807c-481a-91e9-8b744c24913d@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <851d8642-807c-481a-91e9-8b744c24913d@joelfernandes.org>

On Tue, Mar 19, 2024 at 01:33:11PM -0400, Joel Fernandes wrote:
> 
> 
> On 3/19/2024 1:29 PM, Joel Fernandes wrote:
> > 
> > 
> > On 3/19/2024 1:26 PM, Uladzislau Rezki wrote:
> >> On Tue, Mar 19, 2024 at 12:11:28PM -0400, Joel Fernandes wrote:
> >>> On Tue, Mar 19, 2024 at 12:02 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >>>>
> >>>> On Tue, Mar 19, 2024 at 03:48:46PM +0100, Uladzislau Rezki wrote:
> >>>>> On Tue, Mar 19, 2024 at 10:29:59AM -0400, Joel Fernandes wrote:
> >>>>>>
> >>>>>>
> >>>>>>> On Mar 19, 2024, at 5:53 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> >>>>>>>
> >>>>>>> ﻿On Mon, Mar 18, 2024 at 05:05:31PM -0400, Joel Fernandes wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>>> On Mar 18, 2024, at 2:58 PM, Uladzislau Rezki <urezki@gmail.com> wrote:
> >>>>>>>>>
> >>>>>>>>> ﻿Hello, Joel!
> >>>>>>>>>
> >>>>>>>>> Sorry for late checking, see below few comments:
> >>>>>>>>>
> >>>>>>>>>> In the synchronize_rcu() common case, we will have less than
> >>>>>>>>>> SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
> >>>>>>>>>> is pointless just to free the last injected wait head since at that point,
> >>>>>>>>>> all the users have already been awakened.
> >>>>>>>>>>
> >>>>>>>>>> Introduce a new counter to track this and prevent the wakeup in the
> >>>>>>>>>> common case.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >>>>>>>>>> ---
> >>>>>>>>>> Rebased on paul/dev of today.
> >>>>>>>>>>
> >>>>>>>>>> kernel/rcu/tree.c | 36 +++++++++++++++++++++++++++++++-----
> >>>>>>>>>> kernel/rcu/tree.h |  1 +
> >>>>>>>>>> 2 files changed, 32 insertions(+), 5 deletions(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >>>>>>>>>> index 9fbb5ab57c84..bd29fe3c76bf 100644
> >>>>>>>>>> --- a/kernel/rcu/tree.c
> >>>>>>>>>> +++ b/kernel/rcu/tree.c
> >>>>>>>>>> @@ -96,6 +96,7 @@ static struct rcu_state rcu_state = {
> >>>>>>>>>>   .ofl_lock = __ARCH_SPIN_LOCK_UNLOCKED,
> >>>>>>>>>>   .srs_cleanup_work = __WORK_INITIALIZER(rcu_state.srs_cleanup_work,
> >>>>>>>>>>       rcu_sr_normal_gp_cleanup_work),
> >>>>>>>>>> +    .srs_cleanups_pending = ATOMIC_INIT(0),
> >>>>>>>>>> };
> >>>>>>>>>>
> >>>>>>>>>> /* Dump rcu_node combining tree at boot to verify correct setup. */
> >>>>>>>>>> @@ -1642,8 +1643,11 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> >>>>>>>>>>    * the done tail list manipulations are protected here.
> >>>>>>>>>>    */
> >>>>>>>>>>   done = smp_load_acquire(&rcu_state.srs_done_tail);
> >>>>>>>>>> -    if (!done)
> >>>>>>>>>> +    if (!done) {
> >>>>>>>>>> +        /* See comments below. */
> >>>>>>>>>> +        atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
> >>>>>>>>>>       return;
> >>>>>>>>>> +    }
> >>>>>>>>>>
> >>>>>>>>>>   WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
> >>>>>>>>>>   head = done->next;
> >>>>>>>>>> @@ -1666,6 +1670,9 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> >>>>>>>>>>
> >>>>>>>>>>       rcu_sr_put_wait_head(rcu);
> >>>>>>>>>>   }
> >>>>>>>>>> +
> >>>>>>>>>> +    /* Order list manipulations with atomic access. */
> >>>>>>>>>> +    atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
> >>>>>>>>>> }
> >>>>>>>>>>
> >>>>>>>>>> /*
> >>>>>>>>>> @@ -1673,7 +1680,7 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> >>>>>>>>>> */
> >>>>>>>>>> static void rcu_sr_normal_gp_cleanup(void)
> >>>>>>>>>> {
> >>>>>>>>>> -    struct llist_node *wait_tail, *next, *rcu;
> >>>>>>>>>> +    struct llist_node *wait_tail, *next = NULL, *rcu = NULL;
> >>>>>>>>>>   int done = 0;
> >>>>>>>>>>
> >>>>>>>>>>   wait_tail = rcu_state.srs_wait_tail;
> >>>>>>>>>> @@ -1699,16 +1706,35 @@ static void rcu_sr_normal_gp_cleanup(void)
> >>>>>>>>>>           break;
> >>>>>>>>>>   }
> >>>>>>>>>>
> >>>>>>>>>> -    // concurrent sr_normal_gp_cleanup work might observe this update.
> >>>>>>>>>> -    smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> >>>>>>>>>> +    /*
> >>>>>>>>>> +     * Fast path, no more users to process. Remove the last wait head
> >>>>>>>>>> +     * if no inflight-workers. If there are in-flight workers, let them
> >>>>>>>>>> +     * remove the last wait head.
> >>>>>>>>>> +     */
> >>>>>>>>>> +    WARN_ON_ONCE(!rcu);
> >>>>>>>>>>
> >>>>>>>>> This assumption is not correct. An "rcu" can be NULL in fact.
> >>>>>>>>
> >>>>>>>> Hmm I could never trigger that. Are you saying that is true after Neeraj recent patch or something else?
> >>>>>>>> Note, after Neeraj patch to handle the lack of heads availability, it could be true so I requested
> >>>>>>>> him to rebase his patch on top of this one.
> >>>>>>>>
> >>>>>>>> However I will revisit my patch and look for if it could occur but please let me know if you knew of a sequence of events to make it NULL.
> >>>>>>>>>
> >>>>>>> I think we should agree on your patch first otherwise it becomes a bit
> >>>>>>> messy or go with a Neeraj as first step and then work on youth. So, i
> >>>>>>> reviewed this patch based on latest Paul's dev branch. I see that Neeraj
> >>>>>>> needs further work.
> >>>>>>
> >>>>>> You are right. So the only change is to drop the warning and those braces. Agreed?
> >>>>>>
> >>>>> Let me check a bit. Looks like correct but just in case.
> >>>>>
> >>>>
> >>>> Thanks. I was also considering improving it for the rcu == NULL case, as
> >>>> below. I will test it more before re-sending.
> >>>>
> >>>> On top of my patch:
> >>>>
> >>>> ---8<-----------------------
> >>>>
> >>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >>>> index 0df659a878ee..a5ef844835d4 100644
> >>>> --- a/kernel/rcu/tree.c
> >>>> +++ b/kernel/rcu/tree.c
> >>>> @@ -1706,15 +1706,18 @@ static void rcu_sr_normal_gp_cleanup(void)
> >>>>                         break;
> >>>>         }
> >>>>
> >>>> +
> >>>> +       /* Last head stays. No more processing to do. */
> >>>> +       if (!rcu)
> >>>> +               return;
> >>>> +
> >>>
> >>> Ugh, should be "if (!wait_head->next)"  instead of "if (!rcu)".  But
> >>> in any case, the original patch except the warning should hold.
> >>> Still, I am testing the above diff now.
> >>>
> >>>  - Joel
> >>>
> >> Just in case, it is based on your patch:
> >>
> >> <snip>
> >> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >> index bd29fe3c76bf..98546afe7c21 100644
> >> --- a/kernel/rcu/tree.c
> >> +++ b/kernel/rcu/tree.c
> >> @@ -1711,29 +1711,25 @@ static void rcu_sr_normal_gp_cleanup(void)
> >>  	 * if no inflight-workers. If there are in-flight workers, let them
> >>  	 * remove the last wait head.
> >>  	 */
> >> -	WARN_ON_ONCE(!rcu);
> >> -	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
> >> -
> >> -	if (rcu && rcu_sr_is_wait_head(rcu) && rcu->next == NULL &&
> >> -		/* Order atomic access with list manipulation. */
> >> -		!atomic_read_acquire(&rcu_state.srs_cleanups_pending)) {
> >> +	if (wait_tail->next && rcu_sr_is_wait_head(wait_tail->next) && !wait_tail->next->next &&
> >> +			!atomic_read_acquire(&rcu_state.srs_cleanups_pending)) {
> > 
> > 
> > Yes this also works. But also if wait_tail->next == NULL, then you do not need
> > to queue worker for that case as well. I sent this as v3.
> > 
> Sorry, I see you did add that later in the patch ;-). I think we have converged
> on the final patch then, give or take the use of 'rcu' versus 'wait_tail->next'.
> 
Just combine all parts into one place and resend :)

Thanks!

--
Uladzislau Rezki

