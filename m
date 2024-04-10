Return-Path: <linux-kernel+bounces-138034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E23589EB52
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C4BAB2309F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92D213AA47;
	Wed, 10 Apr 2024 06:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="CQCoImaz"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2DE374D9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712732347; cv=none; b=mbXFBJALkGygyC7YrW+puoJA+7UWq5aI/CH0xgIwefxRgv2Mb9bIz3sqK+Ivu6GWvVW30glfbG8Ng9u5wVxhIUGGGlNQcirvRVTR/zCb9fTKbCfVEKV9LKEpnTBzp15Fd5dI6lnFi0u5FjD5mUZktS8iW16iuqmrr//g3U2UuCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712732347; c=relaxed/simple;
	bh=ux60IGVfQn8BAw045CqhbS18oTj2DipzkQNpfcpuKlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qljQZysknsG+eM4OeBTajmv0AiQYfrmWfNjRKODoN4FsJujB8Uuw+yQ4eGrhxGPYTZs7Q8mJlajwZnKFPtehQPFcrzeZ5gGAsE/ir6eVFNFZDlEFscDF48EHs71UqcOBt/3agtwTWEde5M522MHfuVNT0LVgZVVYU0dDiV7mjjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=CQCoImaz; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5aa17c29ba0so2230791eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 23:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1712732344; x=1713337144; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ckJd731MMp6vz4I5H58StUaBu0IRuHxK3k8ylOh5qYY=;
        b=CQCoImazgesxZlTjmQURu/2aziCTx0yCBKYfxklyRnvPKOnaOstT48Xdy+fssbt3Zb
         oa/Q8QE91cdHybz4Ama+nBisfT+oriMzcG0j+KlBgx7TCPas5QOazCmnak5mmMeW3Qz1
         G7zoEb/S8jeE2MQViJh16gPXAT394OXsztAzVTIhoALlKTznw4n8yMZjGuLovAkvO9n0
         GQbN1GPXdwvMRot1Z3RDUi06zA6GXkhBwVFyrWZUiNX70apFCIOKZIZ5sc8U5abPYBW5
         qL2gHR2bUz67yNKb82zCxlnPoRncowmZFELjq5t6wRhDzChv6Dz0dUfAHwpgPflK2ifl
         UlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712732344; x=1713337144;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckJd731MMp6vz4I5H58StUaBu0IRuHxK3k8ylOh5qYY=;
        b=OkI/7KUK7xvDym7bKwqMsbay2dTr6LwEzuRFw8OVwr7vCNEOVxdVbLAitZ1IXdxtSh
         zfEvXVylU6v0wpdKF6HS1UQ+aWaFEb409F+ZGHR51AebcSGQdW06DW2S+Vv/89NqTeR0
         j2jlmI9FQ2pw7JtigZ1N/trMbksMYF+vGTiP2AB+DsKeGKEm0YKUuHqgLz0Vk8f/lk5I
         x5C9Q6NLvbBJz4NqKgdbucNZu61ulONlnpZysG+HLmBNTLq/wH7lhtJN2YVQ2nN/Xd3s
         47QRNVnuktz7dbvUa70s1/JKmimUVvuG/zkcb0h7YoTtjfmcnkpgZzeefY+/22YEY6uP
         6luA==
X-Forwarded-Encrypted: i=1; AJvYcCWIo1S98aTUOHJPbUgFzNOniMEJUhSCq3nggP0uOP5mn9hDFBltQOr/lpLGXBho93CdNhIKInJ0QJrZQBu8cxqa12ec2/I8WpirftOa
X-Gm-Message-State: AOJu0Yyfn+enxDkjGix1UCbyPPMO68r3AODmIAub2dtjb/XmJHqxxDqi
	4k1F12yrwEKq2dyU2SAayNYlauArAA0EFoOMDnnRgDInwVxrzFAeOr8QmiVJfVE=
X-Google-Smtp-Source: AGHT+IGABmi6URzg4J686LkeFnvno9mEIXoB1NJ3vIDihcfi713WBDvEaw0+yafO/fl2ufVFDnQjqw==
X-Received: by 2002:a05:6358:980e:b0:183:645b:cfa5 with SMTP id y14-20020a056358980e00b00183645bcfa5mr2292203rwa.15.1712732344075;
        Tue, 09 Apr 2024 23:59:04 -0700 (PDT)
Received: from airbuntu ([64.125.41.58])
        by smtp.gmail.com with ESMTPSA id u12-20020a63d34c000000b005dc87f5dfcfsm9295442pgi.78.2024.04.09.23.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 23:59:03 -0700 (PDT)
Date: Wed, 10 Apr 2024 07:59:01 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, Yabin Cui <yabinc@google.com>
Subject: Re: [PATCH] sched/pi: Reweight fair_policy() tasks when inheriting
 prio
Message-ID: <20240410065901.ruzhjsmtmpsnl4qe@airbuntu>
References: <20240403005930.1587032-1-qyousef@layalina.io>
 <CAKfTPtDB8D6bouxJN9q8gXqG+BQYcsrJYEodDWtOB2kQwPH53A@mail.gmail.com>
 <20240404220500.dmfl2krll37znbi5@airbuntu>
 <CAKfTPtDP7if0gozSrnj+E_hH5xR-vpGAM2TwN4qWXcg5BtrEtw@mail.gmail.com>
 <20240405171653.boxbylrdak5fopjv@airbuntu>
 <20240407122700.ns7gknqwqkpjjyd4@airbuntu>
 <CAKfTPtBZao-Ry=sdAV=rtTwbxbEJmwb-_gNceSjV6u-6EXTY-w@mail.gmail.com>
 <CANDhNCq5HZvecSe9_9f7j5koY2VNdyjM_b3csL6=U1A_8J2ksw@mail.gmail.com>
 <20240409061909.tb3vxc27h2eawiwg@airbuntu>
 <CAKfTPtC4hdbBhn+-hkK9i4vkjO5fBGfsxjESkBrvyOwN6oHCdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtC4hdbBhn+-hkK9i4vkjO5fBGfsxjESkBrvyOwN6oHCdA@mail.gmail.com>

On 04/09/24 14:35, Vincent Guittot wrote:
> On Tue, 9 Apr 2024 at 08:19, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 04/08/24 12:51, John Stultz wrote:
> > > On Mon, Apr 8, 2024 at 12:17 AM Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > >
> > > > On Sun, 7 Apr 2024 at 14:27, Qais Yousef <qyousef@layalina.io> wrote:
> > > > >
> > > > > On 04/05/24 18:16, Qais Yousef wrote:
> > > > >
> > > > > > >
> > > > > > > All that to say that I think the weight is not applied on purpose.
> > > > > > > This might work for your particular case but there are more changes to
> > > > > > > be done if you want to apply prio inheritance between cfs tasks.
> > > > > > >
> > > > > > > As an example, what about the impact of cgroup on the actual weight
> > > > > > > and the inherited priority of a task ? If the owner and the waiter
> > > > > > > don't belong to the same cgroup their own prio is meaningless... task
> > > > > > > nice -20 in a group with a weight equal to nice 19 vs a task nice 19
> > > > > > > in a group with a weight equals to nice -20
> > > > > >
> > > > > > That is on my mind actually. But I thought it's a separate problem. That has to
> > > > > > do with how we calculate the effective priority of the pi_task. And probably
> > > > > > the sorting order to if we agree we need to revert the above. If that is done
> > > > >
> > > > > Thinking more about it the revert is not the right thing to do. We want fair
> > > > > tasks to stay ordered in FIFO for better fairness and avoid potential
> > > > > starvation issues. It's just the logic for searching the top_waiter need to be
> > > > > different. If the top_waiter is fair, then we need to traverse the tree to find
> > > > > the highest nice value. We probably can keep track of this while adding items
> > > > > to the tree to avoid the search.
> > > > >
> > > > > For cgroup; is it reasonable (loosely speaking) to keep track of pi_cfs_rq and
> > > > > detach_attach_task_cfs_rq() before the reweight? This seems the most
> > > > > straightforward solution and will contain the complexity to keeping track of
> > > > > cfs_rq. But it'll have similar issue to proxy execution where a task that
> > > > > doesn't belong to the cgroup will consume its share..
> > > >
> > > > That's a good point, Would proxy execution be the simplest way to fix all this ?
> >
> > Is it? Over 4.5 years ago Unity reported to me about performance inversion
> > problem and that's when proxy execution work was revived as simplest way to fix
> > all of this. But still no end in sight from what I see. I was and still think
> > an interim solution in rt_mutex could help a lot of use cases already without
> > being too complex. Not as elegant and comprehensive like proxy execution, but
> > given the impact on both userspace and out of tree kernel hacks are growing
> > waiting for this to be ready, the cost of waiting is high IMHO.
> >
> > FWIW, I already heard several feedbacks that PTHREAD_PRIO_INHERIT does nothing.
> > I think this reweight issue is more serious problem and likely why I heard this
> > feedback. I could be underestimating the complexity of the fix though. So I'll
> 
> Without cgroup, the solution could be straightforward but android uses
> extensively cgroup AFAICT and update_cfs_group() makes impossible to
> track the top cfs waiter and its "prio"

:(

IIUC the issue is that we can't easily come up with a single number of
'effective prio' for N level hierarchy and compare it with another M level
hierarchy..

Does proxy execution fix this problem then? If we can't find the top waiter,
I can't see how proxy execution would work here too. To my understanding it's
more about how we apply inheritance (by donating execution context of the top
waiter) instead of manually applying inheritance like we're doing now.

But the logic of finding the top waiter should remain the same, no?

Need to extend my test case to cover this scenario.

