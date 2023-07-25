Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE48D7611C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjGYKzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjGYKzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:55:32 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FF12689;
        Tue, 25 Jul 2023 03:53:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5222bc916acso2738213a12.3;
        Tue, 25 Jul 2023 03:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690282399; x=1690887199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwGjez98+Z7DYerWtpEnUz/QCZ+ae99CXaeubhq+lCo=;
        b=mlSsZSHswqcByPTwbuUwAjc/BiDmV8alwigpLyjDiXkr2naBn6+a1HZzUbRU4uTF/t
         wqHWi/o3OBlSLBO3sduuT8vGsvn3O5kv8/1ZOuf/ofWgdsa4j5HewPQqgX5BI1s/FswI
         //QmEsDN+IYCxbkPSe+UHTesOimIDGDxQzoWU2tyDXEnup3ogcWyNtnAPPuvaGUhz8jX
         +CstZmpDAhBHorkYtLEAIfmq8mm9QloyePHrg7B0hVfk2ccwWi0b1RRlBzFg1x3hWxy4
         CsNB5AEAqhdTyxwe805gHiCPJIM6b9YbHbw9FGa0SRBl7KAMA5DhIOCJyqVnDo0HfDoy
         JmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690282399; x=1690887199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwGjez98+Z7DYerWtpEnUz/QCZ+ae99CXaeubhq+lCo=;
        b=LvDhHikfj/y1VAY9rSP7glrHFKYc3W8DafFAfhqK6HZ49GwrFd/QiEFBP8IcZeJgWd
         +h5QNP5F3HeWW6dfcRVnnJgzYTOFTAzupkLWadBtqijQB/q5r4sxdRUxI55pHqMk9Ckv
         Z9GL3Hqx9Ojq9Nt5k4qdVGLqLDZtwWYJS/kpsT/GUIIAgN+67078zhn5TJ5MAfiWpfMB
         69RzsCqyS9hPicB+x2QKkWuVsa1fEH/eIDf7il+5vrg2XgiViljhPxBhT5cizZ+NLoyK
         T2DiBqHog0spiH5fB5tNakW0Gm7BBXyN+vvm6hB1ur+Ht3XNA0U/qkI65v2C9e7IX4AH
         haHw==
X-Gm-Message-State: ABy/qLamytpqv+UrgOSxNHz10kWKQRg2ErUFb2kHIRS5I0Ibvt6PKUIt
        rtUhp2OxLYMZdLkct+wepx9aAF3MUscZFqw7DjA=
X-Google-Smtp-Source: APBJJlEYaSivhgx3xMc6SfnY1DcId6rr4g2XNOz6zf25YZ4iJm3mULUSeaSJIxdaLkXWE4p071ujLNUfx7EIZzvH8EE=
X-Received: by 2002:a05:6402:1295:b0:51e:4e77:3347 with SMTP id
 w21-20020a056402129500b0051e4e773347mr8959757edv.41.1690282398609; Tue, 25
 Jul 2023 03:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230725072254.32045-1-zegao@tencent.com> <20230725072254.32045-2-zegao@tencent.com>
 <20230725083357.GA3765278@hirez.programming.kicks-ass.net>
In-Reply-To: <20230725083357.GA3765278@hirez.programming.kicks-ass.net>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Tue, 25 Jul 2023 18:53:07 +0800
Message-ID: <CAD8CoPAdRUxk3FWdNX6g0V6Kdr3+sXv8fdQ9NhgKUR29-ZLaug@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] sched, tracing: report task state in symbolic
 chars instead
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 4:34=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Jul 25, 2023 at 03:22:52PM +0800, Ze Gao wrote:
>
> > @@ -197,13 +198,6 @@ static inline long __trace_sched_switch_state(bool=
 preempt,
> >       BUG_ON(p !=3D current);
> >  #endif /* CONFIG_SCHED_DEBUG */
> >
> > -     /*
> > -      * Preemption ignores task state, therefore preempted tasks are a=
lways
> > -      * RUNNING (we will not have dequeued if state !=3D RUNNING).
> > -      */
> > -     if (preempt)
> > -             return TASK_REPORT_MAX;
> > -
> >       /*
> >        * task_state_index() uses fls() and returns a value from 0-8 ran=
ge.
> >        * Decrement it by 1 (except TASK_RUNNING state i.e 0) before usi=
ng
> > @@ -212,7 +206,16 @@ static inline long __trace_sched_switch_state(bool=
 preempt,
> >        */
> >       state =3D __task_state_index(prev_state, p->exit_state);
> >
> > -     return state ? (1 << (state - 1)) : state;
> > +     /*
> > +      * Preemption ignores task state, therefore preempted tasks are a=
lways
> > +      * RUNNING (we will not have dequeued if state !=3D RUNNING).
> > +      * Here, we use 'p' to denote this case and only for this case.
> > +      */
> > +     if (preempt)
> > +             return 'p';
> > +
>
> I don't get this move, why compute state before this return?

Oops,  I was going to ignore the PREEMP_ACTIVE in the first attempt
and changed it to 'state =3D 0'
which I decided to introduce 'p' to denote this after second thoughts.
Will fix it and revert this move.

> > +
> > +     return task_index_to_char(state);
> >  }
> >  #endif /* CREATE_TRACE_POINTS */
> >
> > @@ -232,7 +235,7 @@ TRACE_EVENT(sched_switch,
> >               __array(        char,   prev_comm,      TASK_COMM_LEN   )
> >               __field(        pid_t,  prev_pid                        )
> >               __field(        int,    prev_prio                       )
> > -             __field(        long,   prev_state                      )
> > +             __field(        char,   prev_state                      )
> >               __array(        char,   next_comm,      TASK_COMM_LEN   )
> >               __field(        pid_t,  next_pid                        )
> >               __field(        int,    next_prio                       )
>
> This is a format change and will likely break a ton of programs :/

Yeah,  I admit that.  And I believe this kind of break happens each
time the internal
task state constant mapping is rearranged, it's of no big difference
here, since the
most renowned perf itself is still broken at this time after.  And
IMHO it's time to fix
this and do things correctly.  That is why I propose this and mark it as RF=
C.

BTW, could you help to point to any possible tools/programs that would
break other
than perf/libtraceevent, because these two are the only users I run
into so far.

Regards,
Ze
