Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C9D7628CB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 04:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjGZClt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 22:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGZClp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 22:41:45 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8B02689;
        Tue, 25 Jul 2023 19:41:43 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5221c6a2d3dso5735896a12.3;
        Tue, 25 Jul 2023 19:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690339302; x=1690944102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSLpwcJW0NoDcK6EkMge5mYYmHzQy4bHqxuoYI2wbjk=;
        b=qURn5MDKRxJhqki06Bwi7yrC2fL2pPst5wmSDU7FmnnzGrM4jYZFxPevobW+gZtxtm
         9G9Wo0Fz+jGD0p0FwWSQAZIrfxGIeqW2GER1QUOKS2PPwaIUKQLzhDqa8ipJFe2VIel6
         MI2aPOgPI8oHqiO+GwsxHgM8FBzeWAU9S6N91hCYV4j+zo8HuEgejEqqbLTF4A7snQQc
         39V76Xmrerm7TZPDclHakmMVNVoWmgsO4AdnE9oJ13ZuIGiC8+PAbGKGuKL+wzI9BDo1
         D217WSzz7CZHs1qLIUytXHCrgnZnOhIYCZo9NUGeEIZVssvpyzXcXxKapQsMnY+emNvk
         gacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690339302; x=1690944102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSLpwcJW0NoDcK6EkMge5mYYmHzQy4bHqxuoYI2wbjk=;
        b=JHsZgir6o0aebEI8pCGfVSKeK4MweBhFH10tLbRMfoEKxmF2dK9TszHN6z4585Cp92
         A44LxmpVTUqnskkdrHNimOawyMImomMOLTe0enwLvYIAB5CcfAiFgaknragAJABqB1q9
         YZWVfbD6gBky5eQLPDyjB1PH42B0ABt75880yf9omQy+23+rKiLhGbuJJeH21+KoJkA/
         jUwGDLBu3lpTytDSva3ryY4DHmy4q1QxfUIKTipqqLZ/8y18tNrE+qf4z+bb+7ANH4uE
         0kyAYnXdXz2rRVtJlxjOIFFn1dksKxQj5o57R85dQOMn1P18amu+cU73xVTE6wLlj79d
         e94w==
X-Gm-Message-State: ABy/qLZysXyqB2lU/tLhiPIGse2f1Y/PljQhjPKET3Zt9hYge0mQCl6g
        YsdlPYnKdWAzMk7jlrQtmDrfs7PA93k1/eDW2Y2eYBNOZLketA==
X-Google-Smtp-Source: APBJJlGCO5PThD5Tryyg4XrXHFuTJAaBCGI7int3GhA3atEonWO4yWvavbVPAfeTolbvWP/UDmrm/pd+74tj+2CwjUE=
X-Received: by 2002:aa7:c50c:0:b0:51d:7fa6:62ca with SMTP id
 o12-20020aa7c50c000000b0051d7fa662camr530063edq.14.1690339301927; Tue, 25 Jul
 2023 19:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230725072254.32045-1-zegao@tencent.com> <20230725072254.32045-2-zegao@tencent.com>
 <20230725135938.1e056a02@rorschach.local.home>
In-Reply-To: <20230725135938.1e056a02@rorschach.local.home>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Wed, 26 Jul 2023 10:41:30 +0800
Message-ID: <CAD8CoPBTCXiusUGNTEwcm9WJ+MEfrX01xsCWYAtA7MCpfaeqmQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] sched, tracing: report task state in symbolic
 chars instead
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 1:59=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 25 Jul 2023 15:22:52 +0800
> Ze Gao <zegao2021@gmail.com> wrote:
>
> >  #ifdef CREATE_TRACE_POINTS
> > -static inline long __trace_sched_switch_state(bool preempt,
> > +static inline const char __trace_sched_switch_state(bool preempt,
>
> Does it really need to be "const"?

Not really since it's rvalue after all, will remove this.

> >                                             unsigned int prev_state,
> >                                             struct task_struct *p)
> >  {
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
> This will break userspace. Just because you update libtraceevent
> doesn't mean that it will get to all the users of it. There's still
> tools that have the old method hard coded and doesn't use the library.
>
> Now, because the old tools still do the parsing of this format, we can
> add a new field called prev_state_char that will give you this. Now to
> save space, we should change prev_state to int (can't make it short as
> there's that test for "+" which does sometimes happen). I believe we
> can make prev_prio and next prio into shorts (and possibly chars!).
>
> -- Steve
>

Agreed, and my first attempt was to not break anything here by
introducing a new "char",  which is kinda redundant, but is a good way
for smooth transition to decouple userspace from kernel on this weird
design(of ABI).

However, given the fact the in-tree perf still suffers this, I doubt many
other tools could spare from it. And the best guess is that they are
still partially broken silently and reports wrong and confusing states.
And this is basically why I came up with this RFC and deliberately
let them fail loudly to do a painful but quick recovery.

Anyway, if we want to keep status quo, I can send over another two
patches to fix perf and libtraceevent specifically and leave the tracepoint
alone. But seriously, imho we might have no chance to correct this.
and without a formal abi, the raw value (let alone the masqueraded ones)
is just meaningless for userspace and that leaves it intended for kernel
developers only.

Thanks,
Ze
