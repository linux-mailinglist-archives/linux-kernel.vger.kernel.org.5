Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18597E605C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 23:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjKHWNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 17:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHWNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 17:13:49 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258A42107
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 14:13:47 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4078fe6a063so7625e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 14:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699481625; x=1700086425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvxq1BVR+F9iEDIGwsu8EF9gWdfdm1hvJ90wXl3Vvy8=;
        b=IlElk8VDBtguuwS6rlA2/KjwZa7b1HoOxTXypskodQCPsCNFUX1Wf8BIZgRXbJlrmF
         H2sIniYTZlRaGqyq8hQqLxRLmwm4yYPOwIBTGCT0t/XNZdIHHH3+AexIWzz78wVHDors
         Sw/pH25cXX9+kX+GYQDEe7dZKvs2jZSIP0KEhZ/RGK29kl34HwAv699e6NwU9ngN5zRJ
         dLSMM3aS2t1Xmj+MZ1Q/j0Gw4a9UJ5qFEJw8DaGwL6Lu5GYEcja5BgQCMwjnjT+d/flT
         lwgs9nR4NGm1oJS6wdTeEyEuw5kx6jaeJwLvuq9cqTz5hBAnOokfyBM2jEWmv2sj4POe
         kpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699481625; x=1700086425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kvxq1BVR+F9iEDIGwsu8EF9gWdfdm1hvJ90wXl3Vvy8=;
        b=roYnvCb0r6mqlA3/0iJVSWlQv+W/WEOhkYswjvpR/EBxsmD5h/Zi7XF8uMSSVPr/A2
         YqHJyVomNhX6eCGBEXu+8nWGRh1mC7gPN7UVSZjXPAlXfExBo9XY7l+bDrHZ+WabP7PG
         QVrgdRKTFWqt6fXQMngIjGhFpMnErN0C0wl87RzkiNdmL+7CeLeHcCXo4P8X06MIcrKQ
         wMxDFCS4t5SLbRVTsM4/nCrtDnOPVA8KyNuzEoFkrALy8KFpZ65q9m4QGaYh2b5LIfMQ
         ZYujqJNZYtPsOGcB/O+tl3aycEG9IBCgbaGUgK42mxouhdwFdWSkUTlB8zkbk2pIiDia
         4DmA==
X-Gm-Message-State: AOJu0Yy1Qb4V1uJ/4uBQ1hJlbaUhqczJZFGch7ZUAht8B27KUv+XbB1f
        WwQaNfDruEcAqpYwddbLTdgg6Hz01CDtxBd8Gu3K
X-Google-Smtp-Source: AGHT+IFwK42ccT71PnZXQT+bMDCjtCcABnO8+55v/+t2Qn3uuKYDWQY5/wK97T9WOI/UskUsq6ljD8/wExGoWy70oQk=
X-Received: by 2002:a05:600c:2195:b0:404:74f8:f47c with SMTP id
 e21-20020a05600c219500b0040474f8f47cmr63225wme.5.1699481625403; Wed, 08 Nov
 2023 14:13:45 -0800 (PST)
MIME-Version: 1.0
References: <20231106193524.866104-1-jstultz@google.com> <20231108111458.1368-1-hdanton@sina.com>
In-Reply-To: <20231108111458.1368-1-hdanton@sina.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 8 Nov 2023 14:13:32 -0800
Message-ID: <CANDhNCqqThYxa5H-vT67M37kfC1kQVpaVao4vuZ2PnM=6qSh5g@mail.gmail.com>
Subject: Re: [PATCH v6 00/20] Proxy Execution: A generalized form of Priority
 Inheritance v6
To:     Hillf Danton <hdanton@sina.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Carlos Llamas <cmllamas@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qais Yousef <qyousef@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 3:40=E2=80=AFAM Hillf Danton <hdanton@sina.com> wrot=
e:
>
> On Mon,  6 Nov 2023 19:34:43 +0000 John Stultz <jstultz@google.com>
> > Overview:
> > =E2=80=94----------
> > Proxy Execution is a generalized form of priority inheritance.
> > Classic priority inheritance works well for real-time tasks where
> > there is a straight forward priority order to how things are run.
> > But it breaks down when used between CFS or DEADLINE tasks, as
> > there are lots of parameters involved outside of just the task=E2=80=99=
s
> > nice value when selecting the next task to run (via
> > pick_next_task()).  So ideally we want to imbue the mutex holder
> > with all the scheduler attributes of  the blocked waiting task.
>
>   [...]

Is there a reason why you trimmed the cc list?

> > The complexity from this is imposing, but currently in Android we
> > have a large number of cases where we are seeing priority
> > inversion (not unbounded, but much longer than we=E2=80=99d like) betwe=
en
> > =E2=80=9Cforeground=E2=80=9D and =E2=80=9Cbackground=E2=80=9D SCHED_NOR=
MAL applications. As a
> > result, currently we cannot usefully limit background activity
> > without introducing inconsistent behavior. So Proxy Execution is
> > a very attractive approach to resolving this critical issue.
>
> Given usual mutex use
>
>         mutex_lock;
>         less-than-a-tick level critical section;
>         (unusual case for example: sleep until wakeup;)
>         mutex_unlock;

So the case we see regularly is you have a low priority task, which
maybe is cpuset restricted onto a smaller more energy efficient cpu,
and cpu share limited as well so it only gets a small proportional
fraction of time on that little cpu.

Alternatively, you could also imagine it being a SCHED_IDLE task on a
busy system, where every once in a while the system is momentarily
idle allowing the task to briefly run.

Either way, it doesn't get to run very much, but when it does, it
calls into the kernel on a path that is serialized with a mutex. Once
it takes the mutex even if it were to hold it for a short time(as in
your example above), if it gets preempted while holding the mutex, it
won't be selected to run for a while.  Then when an important task
calls into a similar kernel path, it will have to block and sleep
waiting for that mutex to be released. Unfortunately, because there
may be enough work going on in other tasks to keep the cpus busy, the
low priority task doesn't get scheduled so it cannot release the lock.
Given it is cpu share limited (or is SCHED_IDLE), depending on the
load it may not get scheduled for a relatively long time. We've
definitely seen traces where the outlier latencies are in the seconds.

> I think the effects of priority inversion could be safely ignored
> without sleep (because of page reclaim for instance) in the critical
> section.

I'm not sure I understand this assertion, could you clarify?

If it's helpful, I've got a simple (contrived) demo which can
reproduce a similar issue I've described above, using just file
renames as the mutex protected critical section.
  https://github.com/johnstultz-work/priority-inversion-demo

> Could you please elaborate a bit on the priority inversion and tip
> point to one or two cases of mutex behind the inversion?

In Andorid, we see it commonly with various binder mutexes or pstore
write_pmsg() pmsg_lock, as those are commonly taken by most apps.
But any common kernel path that takes a mutex can cause these large
latency outliers if we're trying to restrict background processes.

thanks
-john
