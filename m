Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC78476E8DB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbjHCMyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjHCMya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:54:30 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404F91BFA;
        Thu,  3 Aug 2023 05:54:29 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5227e5d9d96so1184741a12.2;
        Thu, 03 Aug 2023 05:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691067268; x=1691672068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcmYW4JGGVC6YTvPh0NOYo5Pg9VZn0CcBiPbWpP9P3U=;
        b=lTHVvqJCc/AAtRNei1xoC2/uCeN1Pv8H0itOFjf5T5PxKAQP3LUHaeigGEYyxgNCry
         Kx4wKAW3/AjhGu7EROypR7jKG/iZvcyQusIezZgQs8QCxlC7N0s42wISiGFCwZWRh4ds
         Va0ZEqH0L2nvLcrYqKe2n/TvQ3EydmSRj/XDJLWIhHeaELJCO0h+U/HXkewTaSzakyol
         jOC0zOu1G4TjNigbfFN28eUmaiTHu04cMY1D9708Y6qrqqdz6nkVgYZr/Df2hIQJhIO7
         wkKxgu5hrm21imuEkAKvn3fhEth/I0thWn75oafagmDi0Vyrtpv1YZJc32ANxq700jEQ
         PtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691067268; x=1691672068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcmYW4JGGVC6YTvPh0NOYo5Pg9VZn0CcBiPbWpP9P3U=;
        b=T47zqv0F5+6hdGiluVzE1cvH9pdPDUpKezS/daiZud+ax/rhv2UekRGz/zOEl4ADkA
         BBVyD/oaSEJ3jXFcglKtS1TqLY/eaE3G9rxzGT/pCv443sw/N+6k2zD8eRgLsEfkS8FI
         spJnh+GAw7IYusao5A4X9RIvlNUZjp6YyTI2CzUsbtbjbtrneVoJ4/L9XhoHarHPpOLW
         fgnJt8SWgJFKeiRSBRLYhA5+wJpLAVPogXNEMoSVpgcKjeE0M0WFBaYXBvce63mrTRJQ
         rGpXR9npSqsf4FcMctBYOK2zEWXuZqaJZcOFRfB8NiAYD18aSzBP32WPDvg1pFzC2SpX
         whjw==
X-Gm-Message-State: ABy/qLajjhRwddrjVDixAuqenIQAOwJIjHcWZ3smr889k6hdCCrnv6KV
        g+i024mC75YWgJ4lYnJZ+plF8n7uviB3Ngh9wt0=
X-Google-Smtp-Source: APBJJlFarG03EnmAWbzgK1Xn0jPX1Wn0KH73rRsnMV+EUOwNM0amgOg0CvwgCp5+Ny9ewkOhEFQw4lD6zom6imfxLlU=
X-Received: by 2002:a05:6402:d7:b0:522:59a7:5453 with SMTP id
 i23-20020a05640200d700b0052259a75453mr6234368edu.35.1691067267543; Thu, 03
 Aug 2023 05:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230803083352.1585-1-zegao@tencent.com> <20230803083352.1585-4-zegao@tencent.com>
 <20230803051826.25ba7973@gandalf.local.home>
In-Reply-To: <20230803051826.25ba7973@gandalf.local.home>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Thu, 3 Aug 2023 20:54:16 +0800
Message-ID: <CAD8CoPBkK64H0UE+_K9yxmiq-kMTvuM=N3S_H1bhdQuJ2JV2Jg@mail.gmail.com>
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
>
> See the difference?
>
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

I've moved this to a new patch, and this is the changelog:

    sched, tracing: change BUG_ON to WARN_ON_ONCE in __trace_sched_switch_s=
tate

    BUG_ON() was introduced in 2014 and old, and we
    switch it to WARN_ON_ONCE() to not to crash the
    kernel when the sched-out task is unexpected than
    the current, as suggested by Steven.

    Signed-off-by: Ze Gao <zegao@tencent.com>

Regards,
Ze

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
