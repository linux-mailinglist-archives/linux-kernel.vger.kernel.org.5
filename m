Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186217B200E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjI1Oru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjI1Ork (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:47:40 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A05ECED
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 07:47:32 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50302e8fca8so5762e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695912450; x=1696517250; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1JojOekoUcoXuO0Rpih+FmNKjIAwWhtI1+VL1LSepgs=;
        b=dUGuQgfPu9zaMkVxUX6Z91su8MzdZTvmgWjqLwtD/spbYTkPN6kw71iS+aBoBMWO/J
         bbXO/QN6sWB0FdI7QCj9iXNqJapia0nv6WI+4vnazT7zemK1Qgz2AL9bVGVKPJfmFh2r
         B4X5f7HdfQle9RzSOCkYpVbokQY6rrDXP7fp7jf6ScDDgbp5xu2ItvNDoZJ8nz83JYUd
         1RbhKHXbkyOspZBvauRGaYGVUvytYkRsDsFo3FoRNplw3K15qhM6SfZHXyALL7zsMHE8
         KUnRgniT8w/t+HwUyCGkvYaVDEVXYe/Mq1ReaOZaILJHImkAG0HTeGmxYTrbLvKJ8bzY
         pTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695912450; x=1696517250;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JojOekoUcoXuO0Rpih+FmNKjIAwWhtI1+VL1LSepgs=;
        b=OT8+gAB+JFKnuyKUXA6/hpRKNW1/Mq3ZJLjPAQNhalB8eV8z3nahIjNX/8ZX27SGzl
         C/AG3j64A6s4xMV8ZJPFjCTIW+nQsPEWhEiQk3yEtmKHc9KEB2+hurx1vEmWE9LaekX/
         pvBiI6L0vlkI34eLaoURg129Y3xIlqTyQN968M6Xpx5NpQbAaF3ybpyQ1mFhPDFQcYMV
         OAaVhKb5Cdm9voCvhlzIVPViycsCbX3erT7S7wgyVZ0dHlwH2z3f3Raw0hLCTBwiYE8/
         YK8VKx8p2B73F62yAauYB+QCPadGnQ6aHVuieb5EaVWdhkusIgbbpYtgz2gs2C2ipUiS
         Wi7Q==
X-Gm-Message-State: AOJu0Yy91Lyw84riOTRfAUbVxB1JLzHRMhS2uj6fVOXsNYFyTXh8rDQt
        cRxCmAdfBu1FWwPZfwgRVC/OO9AQjaZLbCGhc/UVLw==
X-Google-Smtp-Source: AGHT+IFRHY2YyR6Q9fY0bk32K0k63L4VHaemJ9rnRC7s1k7/O9yMYYHJFUxcOsKvAkcOtKVMojnRDL3hfLdy0LWLQAg=
X-Received: by 2002:ac2:44c4:0:b0:501:90dd:be8e with SMTP id
 d4-20020ac244c4000000b0050190ddbe8emr217273lfm.5.1695912449938; Thu, 28 Sep
 2023 07:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <2c421e36-a749-7dc3-3562-7a8cf256df3c@efficios.com>
 <20230926205215.472650-1-dvyukov@google.com> <CACT4Y+beLh1qnHF9bxhMUcva8KyuvZs7Mg_31SGK5xSoR=3m1A@mail.gmail.com>
In-Reply-To: <CACT4Y+beLh1qnHF9bxhMUcva8KyuvZs7Mg_31SGK5xSoR=3m1A@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 28 Sep 2023 07:47:15 -0700
Message-ID: <CACT4Y+bJpUMpp9YNt4wvQdCHV0-br1d9rH8y01Q=Y_1hQW5yCA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
To:     mathieu.desnoyers@efficios.com
Cc:     David.Laight@aculab.com, alexander@mihalicyn.com,
        andrealmeid@igalia.com, boqun.feng@gmail.com, brauner@kernel.org,
        carlos@redhat.com, ckennelly@google.com, corbet@lwn.net,
        dave@stgolabs.net, dvhart@infradead.org, fweimer@redhat.com,
        goldstein.w.n@gmail.com, hpa@zytor.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        longman@redhat.com, mingo@redhat.com, paulmck@kernel.org,
        peterz@infradead.org, pjt@google.com, posk@posk.io,
        rostedt@goodmis.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sept 2023 at 16:49, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> > >> I don't see why we can't stick this directly into struct rseq because
> > >> it's all public anyway.
> > >
> > > The motivation for moving this to a different cache line is to handle
> > > the prior comment from Boqun, who is concerned that busy-waiting
> > > repeatedly loading a field from struct rseq will cause false-sharing and
> > > make other stores to that cache line slower, especially stores to
> > > rseq_cs to begin rseq critical sections, thus slightly increasing the
> > > overhead of rseq critical sections taken while mutexes are held.
> > >
> > > If we want to embed this field into struct rseq with its own cache line,
> > > then we need to add a lot of padding, which is inconvenient.
> > >
> > > That being said, perhaps this is premature optimization, what do you think ?
> >
> > Hi Mathieu, Florian,
> >
> > This is exciting!
> >
> > I thought the motivation for moving rseq_sched_state out of struct rseq
> > is lifetime management problem. I assume when a thread locks a mutex,
> > it stores pointer to rseq_sched_state in the mutex state for other
> > threads to poll. So the waiting thread would do something along the following
> > lines:
> >
> > rseq_sched_state* state = __atomic_load_n(mutex->sched_state, __ATOMIC_RELAXED);
> > if (state && !(state->state & RSEQ_SCHED_STATE_FLAG_ON_CPU))
> >         futex_wait();
> >
> > Now if the state is struct rseq, which is stored in TLS,
> > then the owning thread can unlock the mutex, exit and unmap TLS in between.
> > Consequently, load of state->state will cause a paging fault.
> >
> > And we do want rseq in TLS to save 1 indirection.
> >
> > If rseq_sched_state is separated from struct rseq, then it can be allocated
> > in type stable memory that is never unmapped.
> >
> > What am I missing here?
> >
> > However, if we can store this state in struct rseq, then an alternative
> > interface would for the kernel to do:
> >
> > rseq->cpu_id = -1;
> >
> > to denote that the thread is not running on any CPU.
> > I think it kinda makes sense, rseq->cpu_id is the thread's current CPU,
> > and -1 naturally means "not running at all". And we already store -1
> > right after init, so it shouldn't be a surprising value.
>
> As you may know we experimented with "virtual CPUs" in tcmalloc. The
> extension allows kernel to assign dense virtual CPU numbers to running
> threads instead of real sparse CPU numbers:
>
> https://github.com/google/tcmalloc/blob/229908285e216cca8b844c1781bf16b838128d1b/tcmalloc/internal/linux_syscall_support.h#L30-L41
>
> Recently I added another change that [ab]uses rseq in an interesting
> way. We want to get notifications about thread re-scheduling. A bit
> simplified version of this is as follows:
> we don't use rseq.cpu_id_start for its original purpose, so instead we
> store something else there with a high bit set. Real CPU numbers don't
> have a high bit set (at least while you have less than 2B CPUs :)).
> This allows us to distinguish the value we stored in rseq.cpu_id_start
> from real CPU id stored by the kernel.
> Inside of rseq critical section we check if rseq.cpu_id_start has high
> bit set, and if not, then we know that we were just rescheduled, so we
> can do some additional work and update rseq.cpu_id_start to have high
> bit set.
>
> In reality it's a bit more involved since the field is actually 8
> bytes and only partially overlaps with rseq.cpu_id_start (it's an
> 8-byte pointer with high 4 bytes overlap rseq.cpu_id_start):
>
> https://github.com/google/tcmalloc/blob/229908285e216cca8b844c1781bf16b838128d1b/tcmalloc/internal/percpu.h#L101-L165
>
> I am thinking if we could extend the current proposed interface in a
> way that would be more flexible and would satisfy all of these use
> cases (spinlocks, and possibility of using virtual CPUs and
> rescheduling notifications). In the end they all need a very similar
> thing: kernel writing some value at some user address when a thread is
> de-scheduled.
>
> The minimal support we need for tcmalloc is an 8-byte user address +
> kernel writing 0 at that address when a thread is descheduled.
>
> The most flexible option to support multiple users
> (malloc/spinlocks/something else) would be as follows:
>
> User-space passes an array of structs with address + size (1/2/4/8
> bytes) + value.
> Kernel intereates over the array when the thread is de-scheduled and
> writes the specified value at the provided address/size.
> Something along the following lines (pseudo-code):
>
> struct rseq {
>     ...
>     struct rseq_desched_notif_t* desched_notifs;
>     int desched_notif_count;
> };
>
> struct rseq_desched_notif_t {
>     void* addr;
>     uint64_t value;
>     int size;
> };
>
> static inline void rseq_preempt(struct task_struct *t)
> {
>     ...
>     for (int i = 0; i < t->rseq->desched_notif_count; i++) {
>         switch (t->rseq->desched_notifs[i].size) {
>         case 1: put_user1(t->rseq->desched_notifs[i].addr,
> t->rseq->desched_notifs[i].value);
>         case 2: put_user2(t->rseq->desched_notifs[i].addr,
> t->rseq->desched_notifs[i].value);
>         case 4: put_user4(t->rseq->desched_notifs[i].addr,
> t->rseq->desched_notifs[i].value);
>         case 8: put_user8(t->rseq->desched_notifs[i].addr,
> t->rseq->desched_notifs[i].value);
>         }
>     }
> }

One thing I forgot to mention: ideally the kernel also writes a
timestamp of descheduling somewhere.
We are using this logic to assign per-CPU malloc caches to threads,
and it's useful to know which caches were used very recently (still
hot in cache) and which ones were not used for a long time.
