Return-Path: <linux-kernel+bounces-107674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6B887FFE6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83091284A0B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D141CD09;
	Tue, 19 Mar 2024 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMcT+llI"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D7FF9E0;
	Tue, 19 Mar 2024 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710859733; cv=none; b=LJUxyBG4g/HvuNsdMt0XB+xLlPyIx8bLHzpgU0k0x/k6bva97k2poTL/ihwsj5t4KqpCTIFSOgszcql/SlpBK//Cir4ZP7uXtYanuY+40egLu/fEYLSoP9SGl2oU31/boYz17Z0cPc6548LB9LyPv97hAdJnfknRQF+A/2M57pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710859733; c=relaxed/simple;
	bh=Zby5V/77Gm6XNsPuHJHW0J+fsuKnn4DHWh14NNhYICA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXpsry1PyLy3sd+Nm6sw0al2DLABEhz+V7I8pSuB6VeKtsX9oQ/508XVbqVcDESQcWNQ4CbUhS1gaziSYNmXjB4EnVlDtT9NRLeVA8aVWWcsXAEyyV8F8DEaSTwb791HFLZuMzs0VsY7bWcpK7oY3GsQR2yY5mAhQkTZTl95vLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMcT+llI; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512f892500cso6281413e87.3;
        Tue, 19 Mar 2024 07:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710859730; x=1711464530; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fXxsIw2dDze0fvR7GTtibnbx0BcDg7yMq6vxLD+1Uxc=;
        b=UMcT+llIUV3KQzxet4oE2rYstWlsoHktklYtDAKNOosizDOmgMbdLjRiQUdthDjORn
         p3KDMurMwXye5OkB22WQ2JV2weUuXODt31GV4kiQ71IW0jsyqNa8U2PlwUM0OQEC7nS0
         +n09IXoI0MnDELvQoNLCngZSF/vO3FepMyoRi/QBuqatQxRnEvpYDABoTQoCqnKqIip7
         3XNinhM0gn1CbH/c2M9jQsZ057lELUGXYSM732hKigxXkSxfxDylq16625exUsDMhbKM
         rOKINTGnpLPzyDoEHNma7PhLSjUlZfkGjRma9VfmgzlOKpjccdvMo1iVRr2PktHRLbsQ
         1elg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710859730; x=1711464530;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fXxsIw2dDze0fvR7GTtibnbx0BcDg7yMq6vxLD+1Uxc=;
        b=tzitXwrFwkMA/Kg1qQOQ7xOEr1tUBQt+qUuN7l+pUbkLj5R8s7xcyPftnGTKOu9ryU
         nhAx+aU7DnlgAWJpdg07Wvklshoyur/FSAWdLnkIBlkEAwKkxmw2hsOgPVyaspnKv53h
         DevkCq5mKJUV80kzRHdFt4ii+X/pu1oMclvmtuHSNEm4Nb6LmutyvU7FTLmxL3blj6m5
         nwU4m7e4Abw+XIa/ohx82alZtqvY1xX9FHL/XdppIWl5pMp2siWnxDefA5CliDXAQMya
         rI70pnKeGyj18QKLIZj80UIaJentRgMRZFzISUpm7qKHN7Nm7oN3wRVLqg2s+o9JAiz3
         hzWw==
X-Forwarded-Encrypted: i=1; AJvYcCUJxaT6n3LgkMsLVt1GIJYiXBzOTk64zl9zoFmBt3HlUtaC+q+EAKvzXMBaZ4Kbew2+JY0eaSKheSyHDxA/HAuGY90tfZpHQ2534QTWSGCn8qCzSxU/bRoYpdelirqSrKrC
X-Gm-Message-State: AOJu0YzxymzTwax5W82KUjhxSDLV6SqsEUAcji2E+nmhkEvUA3R/IfwC
	8F5KsPU+DmsNxnToxhUKiM8R+r2nNIioh0rzT0vpXwWMzvqWoGQm
X-Google-Smtp-Source: AGHT+IH2z5QwVEF7+nCESVqDzcYfrDiDm1LxllGl6VYzDYlwVMlWO0GP8DQpG8yAGDYsCt6wX1WfDw==
X-Received: by 2002:a19:8c56:0:b0:515:7686:6068 with SMTP id i22-20020a198c56000000b0051576866068mr1717419lfj.55.1710859729662;
        Tue, 19 Mar 2024 07:48:49 -0700 (PDT)
Received: from pc636 (host-90-235-3-101.mobileonline.telia.com. [90.235.3.101])
        by smtp.gmail.com with ESMTPSA id b11-20020a056512024b00b00513d4560aa3sm1766653lfo.170.2024.03.19.07.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 07:48:49 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 19 Mar 2024 15:48:46 +0100
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
Message-ID: <ZfmlziaLw1bl4IjX@pc636>
References: <ZflgfrjZSZdqrLLw@pc636>
 <0B372386-9546-492E-930E-DC6C883F3B2B@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0B372386-9546-492E-930E-DC6C883F3B2B@joelfernandes.org>

On Tue, Mar 19, 2024 at 10:29:59AM -0400, Joel Fernandes wrote:
> 
> 
> > On Mar 19, 2024, at 5:53 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > 
> > ﻿On Mon, Mar 18, 2024 at 05:05:31PM -0400, Joel Fernandes wrote:
> >> 
> >> 
> >>>> On Mar 18, 2024, at 2:58 PM, Uladzislau Rezki <urezki@gmail.com> wrote:
> >>> 
> >>> ﻿Hello, Joel!
> >>> 
> >>> Sorry for late checking, see below few comments:
> >>> 
> >>>> In the synchronize_rcu() common case, we will have less than
> >>>> SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
> >>>> is pointless just to free the last injected wait head since at that point,
> >>>> all the users have already been awakened.
> >>>> 
> >>>> Introduce a new counter to track this and prevent the wakeup in the
> >>>> common case.
> >>>> 
> >>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >>>> ---
> >>>> Rebased on paul/dev of today.
> >>>> 
> >>>> kernel/rcu/tree.c | 36 +++++++++++++++++++++++++++++++-----
> >>>> kernel/rcu/tree.h |  1 +
> >>>> 2 files changed, 32 insertions(+), 5 deletions(-)
> >>>> 
> >>>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >>>> index 9fbb5ab57c84..bd29fe3c76bf 100644
> >>>> --- a/kernel/rcu/tree.c
> >>>> +++ b/kernel/rcu/tree.c
> >>>> @@ -96,6 +96,7 @@ static struct rcu_state rcu_state = {
> >>>>   .ofl_lock = __ARCH_SPIN_LOCK_UNLOCKED,
> >>>>   .srs_cleanup_work = __WORK_INITIALIZER(rcu_state.srs_cleanup_work,
> >>>>       rcu_sr_normal_gp_cleanup_work),
> >>>> +    .srs_cleanups_pending = ATOMIC_INIT(0),
> >>>> };
> >>>> 
> >>>> /* Dump rcu_node combining tree at boot to verify correct setup. */
> >>>> @@ -1642,8 +1643,11 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> >>>>    * the done tail list manipulations are protected here.
> >>>>    */
> >>>>   done = smp_load_acquire(&rcu_state.srs_done_tail);
> >>>> -    if (!done)
> >>>> +    if (!done) {
> >>>> +        /* See comments below. */
> >>>> +        atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
> >>>>       return;
> >>>> +    }
> >>>> 
> >>>>   WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
> >>>>   head = done->next;
> >>>> @@ -1666,6 +1670,9 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> >>>> 
> >>>>       rcu_sr_put_wait_head(rcu);
> >>>>   }
> >>>> +
> >>>> +    /* Order list manipulations with atomic access. */
> >>>> +    atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
> >>>> }
> >>>> 
> >>>> /*
> >>>> @@ -1673,7 +1680,7 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> >>>> */
> >>>> static void rcu_sr_normal_gp_cleanup(void)
> >>>> {
> >>>> -    struct llist_node *wait_tail, *next, *rcu;
> >>>> +    struct llist_node *wait_tail, *next = NULL, *rcu = NULL;
> >>>>   int done = 0;
> >>>> 
> >>>>   wait_tail = rcu_state.srs_wait_tail;
> >>>> @@ -1699,16 +1706,35 @@ static void rcu_sr_normal_gp_cleanup(void)
> >>>>           break;
> >>>>   }
> >>>> 
> >>>> -    // concurrent sr_normal_gp_cleanup work might observe this update.
> >>>> -    smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> >>>> +    /*
> >>>> +     * Fast path, no more users to process. Remove the last wait head
> >>>> +     * if no inflight-workers. If there are in-flight workers, let them
> >>>> +     * remove the last wait head.
> >>>> +     */
> >>>> +    WARN_ON_ONCE(!rcu);
> >>>> 
> >>> This assumption is not correct. An "rcu" can be NULL in fact.
> >> 
> >> Hmm I could never trigger that. Are you saying that is true after Neeraj recent patch or something else?
> >> Note, after Neeraj patch to handle the lack of heads availability, it could be true so I requested
> >> him to rebase his patch on top of this one.
> >> 
> >> However I will revisit my patch and look for if it could occur but please let me know if you knew of a sequence of events to make it NULL.
> >>> 
> > I think we should agree on your patch first otherwise it becomes a bit
> > messy or go with a Neeraj as first step and then work on youth. So, i
> > reviewed this patch based on latest Paul's dev branch. I see that Neeraj
> > needs further work.
> 
> You are right. So the only change is to drop the warning and those braces. Agreed?
>
Let me check a bit. Looks like correct but just in case.

>
> I will resend the patch and we can discuss during tomorrow call as well.
> 
Good :)

--
Uladzislau Rezki

