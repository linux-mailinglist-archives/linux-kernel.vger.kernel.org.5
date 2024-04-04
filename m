Return-Path: <linux-kernel+bounces-132191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BC689912A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E270A1F24A78
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F6313C3F1;
	Thu,  4 Apr 2024 22:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="1UBDRMBR"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AE813C3E3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 22:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712269143; cv=none; b=W6icAy+Jrv/v3sRT9PJxaASzf2Qgnj4BCIhd6UR9ejs89hFo3wO0QstVi+VvPTmvkFZS/sMgiY0dDzN4phbBt/pasN7E4CNteKsYL4BPkP23jVH86GNT6oTSlnIYUqMsQo6UFwBFoVO3bAysnwFMg0HxD/WvqO9b5qDalzQ5zNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712269143; c=relaxed/simple;
	bh=+KWtArHYOV4/drlvpuKAYSMS04/EdwACCJckjwanf7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJcDCu1ggic5fobxsGGtHvdTi2pZjGGGyb/HKtzEFRGE5hmfhpMBQupzGEWQAnYW9i2ypKtMqqTdVxpSGxbp2AK59ZEmB/QNtSyizLCdfOCyFo/qjVrMySpPBlOCx5anRnr+YtZoSz/NDyhrBVh41PJ5hieiyCdPQrHVT0ASVL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=1UBDRMBR; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4162a3e2d22so9482445e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 15:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1712269139; x=1712873939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wG/cxLIeAsMx6yckTC5J+rSQMKObkfyNIHYf4fi8mz4=;
        b=1UBDRMBR6fqeaXcfc5hPVD3xKEfGPuM3RR1g1hXR4nSWUvMnh2JUQF5kPd3o1AC/wU
         lBacytIHzU+AWsnzlYwmXkw5ABxwfWphIJvK30O7OwddMQ+WGg6i0UazwLM3MreJWQal
         OGq1oWTA14fCpTXlF5G5KURqkARmdtCj49z578GUvLEf0+/morxOhae0TZw35yPpi4zd
         7Dt3W480QAztw0nyPURWszNXXmocCPAydslrbnAN3xuKYwmmA8pNrSwYb37jD6AR0sAS
         OZRJTAvNdcOpLpX4PR3mRPm2aIUG9nb7OpyHIaj4DlV3kBYF8s1QR4lfob1kgLeKCRlV
         Uz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712269139; x=1712873939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wG/cxLIeAsMx6yckTC5J+rSQMKObkfyNIHYf4fi8mz4=;
        b=KVKTe2bf/TkRRRw52BQVT543vdGUM2zoYCvqBkB5LnBP7lUs74ujIgF2g9D86oel9y
         g+SCaEXzGQ2Lkgm64c3GzdktYCvU4aAMU7kg1tNIVqhCNdQrDl3VbA89NZ5b5hpodjbe
         tuuIooSFm9edhN6X7fHfKnn6VMhhpsXNiTBLhCbDQtAQqULjwQIzXmFp9KCN2Q1L1/Vp
         xt+evedAr2MHiNtUzwTzpaeqVVOi19FKURLriJM81lM3Uu9iQaLW2BKpI1bQ+VKfHshj
         99SHwZJNpeJkaq3iEvm/PT6jpQyM11jKzBQJQUe2pJ5XGcyJYa1qabSsHf4Eo3dDvcwm
         HEmg==
X-Forwarded-Encrypted: i=1; AJvYcCXjdPcsO8LKJGq/n4br/g38OgK6/CMAkGC29EqP18jj4AJmZTGV/qjK7OTpPVOXFvKR8TvRbrd0NS/vRdw5e3yHSwagjPXXRHpOcnJo
X-Gm-Message-State: AOJu0YwnVMt8OZr5wST/QTDwSedl4TYisBq7oizB8cAWFc2toccsRztM
	b8olPQMFaTdE440c2BAV7+pLTQKO5dI48vGcPAXVnRxecReyZJJWACQ3POWjPr4=
X-Google-Smtp-Source: AGHT+IFejTLcWMUMimwZqy8cXDemMXlzVW/rkc6Tpqa6pB0TSndvjL2ofWOJTqrQG4Tac8efgduTag==
X-Received: by 2002:a05:600c:299:b0:414:726:87d9 with SMTP id 25-20020a05600c029900b00414072687d9mr773074wmk.12.1712269139604;
        Thu, 04 Apr 2024 15:18:59 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id c19-20020a05600c0a5300b004162673100fsm4120455wmq.13.2024.04.04.15.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 15:18:59 -0700 (PDT)
Date: Thu, 4 Apr 2024 23:18:57 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, Yabin Cui <yabinc@google.com>
Subject: Re: [PATCH] sched/pi: Reweight fair_policy() tasks when inheriting
 prio
Message-ID: <20240404221857.t2v3yteykleq2nol@airbuntu>
References: <20240403005930.1587032-1-qyousef@layalina.io>
 <CAKfTPtDB8D6bouxJN9q8gXqG+BQYcsrJYEodDWtOB2kQwPH53A@mail.gmail.com>
 <20240403094224.105fdef0@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240403094224.105fdef0@gandalf.local.home>

On 04/03/24 09:42, Steven Rostedt wrote:
> On Wed, 3 Apr 2024 15:11:06 +0200
> Vincent Guittot <vincent.guittot@linaro.org> wrote:
> 
> > On Wed, 3 Apr 2024 at 02:59, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > For fair tasks inheriting the priority (nice) without reweighting is
> > > a NOP as the task's share won't change.  
> > 
> > AFAICT, there is no nice priority inheritance with rt_mutex; All nice
> > tasks are sorted with the same "default prio" in the rb waiter tree.
> > This means that the rt top waiter is not the cfs with highest prio but
> > the 1st cfs waiting for the mutex.
> 
> I think the issue here is that the running process doesn't update its
> weight and if there are other tasks that are not contending on this mutex,
> they can still starve the lock owner.
> 
> IIUC (it's been ages since I looked at the code), high nice values (low
> priority) turn to at lease nice 0 when they are "boosted". It doesn't
> improve their chances of getting the lock though.

The main issue is that if this low nice value is holding the lock and the cpus
are busy, it can take a long time to release the lock.

In today's systems the amount of waiting time that use cases 'permitted' (for
lack of better word) keeps shrinking.

And the way userspace is coded these days with all these layers, app writers
might not be aware there's this dependency where a low priority task might
contend for a lock required by something important. Being able to rely on
PTHREAD_PRIO_INHERIT to ensure they get boosted is useful to protect against
a thread that has a low priority inadvertently holds this lock from causing
massive delays to waiters as it might not get enough RUNNING time to release
it.

To my knowledge windows has some sort of boost mechanism (that maybe Joel knows
more about than me) for the lock holder to help release the lock faster that
app developers rely on to fix similar issues.

> 
> > 
> > >
> > > This is visible when running with PTHREAD_PRIO_INHERIT where fair tasks
> > > with low priority values are susceptible to starvation leading to PI
> > > like impact on lock contention.
> > >
> > > The logic in rt_mutex will reset these low priority fair tasks into nice
> > > 0, but without the additional reweight operation to actually update the
> > > weights, it doesn't have the desired impact of boosting them to allow
> > > them to run sooner/longer to release the lock.
> > >
> > > Apply the reweight for fair_policy() tasks to achieve the desired boost
> > > for those low nice values tasks. Note that boost here means resetting
> > > their nice to 0; as this is what the current logic does for fair tasks.  
> > 
> > But you can at the opposite decrease the cfs prio of a task
> > and even worse with the comment :
> > /* XXX used to be waiter->prio, not waiter->task->prio */
> > 
> > we use the prio of the top cfs waiter (ie the one waiting for the
> > lock) not the default 0 so it can be anything in the range [-20:19]
> > 
> > Then, a task with low prio (i.e. nice > 0) can get a prio boost even
> > if this task and the waiter are low priority tasks
> 
> 
> Yeah, I'm all confused to exactly how the inheritance works with
> SCHED_OTHER. I know John Stultz worked on this for a bit recently. He's
> Cc'ed. But may not be paying attention ;-)
> 
> -- Steve

