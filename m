Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEAF76E8ED
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbjHCM5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbjHCM5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:57:49 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956421BFA;
        Thu,  3 Aug 2023 05:57:48 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe48d0ab0fso1596340e87.1;
        Thu, 03 Aug 2023 05:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691067467; x=1691672267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqkbwwYIgFTYEgpEELADBNQZczlZnMiYwqxm8uYsYwI=;
        b=RIKeUm3PZ7cZLdBie1yhQD82yz5yuPx8GB1CAzQMZTGoMnmO/PJANPtlXbRI1mAP/E
         PXOUq4e/Q2YyDspKFBEYrv8iqI1fjZfUb8CjUXD3UazByMm2ROdxhGGqVX5T60qkMW+E
         d/8cUhheYpIizQFxvf7LxYMFxn+FR1w0V+CDJO4/sjKiqPXJUYUToC9fvmhqYiHN5lKd
         HIJtIJS7PGyz7vJDidGI7LZgGcvtnvImXhdRUwZghRE0g9Td1/WIc+UcISOjj9jbdNZ1
         +PNnWe/q0jFvAaVGSRj1aLWrxVu7+fg7GMvCJ7R6igq+Rc3V9sOJODxOWdYWiCuNH+1O
         aLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691067467; x=1691672267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqkbwwYIgFTYEgpEELADBNQZczlZnMiYwqxm8uYsYwI=;
        b=ZoXhiIWNlV7bvKtU26TfegfUmEO7HUyBDVCYW8tykb4ASyJkVIOZTxf3EAESYzdadb
         FHuyswshK3GivdlPczAd7N8EH6k+46STZW2wQlmc4F/VcL//NjZF9X28flLu0JiPZq1k
         fki2QgWvwuh+BYycH5q8LfkkmudSMpCCIQiWWpM+1n2sA/EuTtagDtngaIaXWjCeFYmJ
         fVdrIoNlBfSsniQyT1KjjR3VfReCgrOc32Bl56AV7BkdDUgXotzw3e2jLCaTlPLOCX5p
         5dL5+wYTQZVS1xgjzsinVAwALwwSbyeATWVY+8psuq9Ki+6EszHs5XXDn/uGMFabrmcl
         168w==
X-Gm-Message-State: ABy/qLb2nxABpkE0PRk0MP4GMu5EGJC1QkqnQntJNOPQRuIAf/s0iaxB
        1rVzUgcgJnhNqCazrf4RjMGFIQS7NmTaaJleVO8=
X-Google-Smtp-Source: APBJJlHFBW87IvFoylbzDyQPr1pM7eaM8uEaOVxF9taaTCvqPdy+EOHXWBu0STeW6X9sYPMRkbMi3gpN25B/71TCZYY=
X-Received: by 2002:a05:6512:104e:b0:4fe:79c:7269 with SMTP id
 c14-20020a056512104e00b004fe079c7269mr7981986lfb.67.1691067466611; Thu, 03
 Aug 2023 05:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230803083352.1585-1-zegao@tencent.com> <20230803083352.1585-4-zegao@tencent.com>
 <20230803051826.25ba7973@gandalf.local.home>
In-Reply-To: <20230803051826.25ba7973@gandalf.local.home>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Thu, 3 Aug 2023 20:57:35 +0800
Message-ID: <CAD8CoPBjp1gkLx5-LcO2j2hA8tXCbBs7Nh453hauxu3d3gwrGw@mail.gmail.com>
Subject: Re: [RFC PATCH v6 3/5] sched, tracing: reorganize fields of switch
 event struct
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Thu, Aug 3, 2023 at 5:18=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Thu,  3 Aug 2023 04:33:50 -0400
> Ze Gao <zegao2021@gmail.com> wrote:
>
> > Report prioritiy and prev_state in 'short' to save some buffer
> > space. And also reorder the fields so that we take struct
> > alignment into consideration to make the record compact.
>
> If I were to write this, I would have wrote:
>
>   The prev_state field in the sched_switch event is assigned by
>   __trace_sched_switch_state(). The largest number that function will ret=
urn
>   is TASK_REPORT_MAX which is just 0x100. There's no reason that the
>   prev_state field is a full 32 bits when it is using just 9 bits max. In
>   order to save space on the ring buffer, shrink the prev_state to 16 bit=
s
>   (short).
>
>   Also, change the positions of the other fields to accommodate the short
>   value of prev_state to eliminate any holes that were created in the
>   structure.

Thanks for this elaboration! But I see Peter have comments on this, I'll wa=
it
to see these resolved and then send my new changelog.

Thanks,
Ze

> >
> >  #ifdef CREATE_TRACE_POINTS
> > -static inline long __trace_sched_switch_state(bool preempt,
> > +static inline short __trace_sched_switch_state(bool preempt,
> >                                             unsigned int prev_state,
> >                                             struct task_struct *p)
> >  {
> >       unsigned int state;
> >
> >  #ifdef CONFIG_SCHED_DEBUG
> > -     BUG_ON(p !=3D current);
> > +     WARN_ON_ONCE(p !=3D current);
> >  #endif /* CONFIG_SCHED_DEBUG */
>
> The above needs to be a separate patch.
>
> -- Steve
>
> >
> >       /*
> > @@ -229,23 +229,23 @@ TRACE_EVENT(sched_switch,
> >       TP_ARGS(preempt, prev, next, prev_state),
> >
> >       TP_STRUCT__entry(
> > -             __array(        char,   prev_comm,      TASK_COMM_LEN   )
> >               __field(        pid_t,  prev_pid                        )
> > -             __field(        int,    prev_prio                       )
> > -             __field(        long,   prev_state                      )
> > -             __array(        char,   next_comm,      TASK_COMM_LEN   )
> >               __field(        pid_t,  next_pid                        )
> > -             __field(        int,    next_prio                       )
> > +             __field(        short,  prev_prio                       )
> > +             __field(        short,  next_prio                       )
> > +             __array(        char,   prev_comm,      TASK_COMM_LEN   )
> > +             __array(        char,   next_comm,      TASK_COMM_LEN   )
> > +             __field(        short,  prev_state                      )
> >       ),
> >
> >       TP_fast_assign(
> > -             memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
> > -             __entry->prev_pid       =3D prev->pid;
> > -             __entry->prev_prio      =3D prev->prio;
> > -             __entry->prev_state     =3D __trace_sched_switch_state(pr=
eempt, prev_state, prev);
> > +             __entry->prev_pid               =3D prev->pid;
> > +             __entry->next_pid               =3D next->pid;
> > +             __entry->prev_prio              =3D (short) prev->prio;
> > +             __entry->next_prio              =3D (short) next->prio;
> >               memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
> > -             __entry->next_pid       =3D next->pid;
> > -             __entry->next_prio      =3D next->prio;
> > +             memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
> > +             __entry->prev_state             =3D __trace_sched_switch_=
state(preempt, prev_state, prev);
> >               /* XXX SCHED_DEADLINE */
> >       ),
> >
>
