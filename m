Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF8076F854
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 05:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjHDDTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 23:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjHDDTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 23:19:42 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C66644B9;
        Thu,  3 Aug 2023 20:19:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so5829558a12.1;
        Thu, 03 Aug 2023 20:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691119158; x=1691723958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZLhgCcmfZDUTlG2w/P5PsKE5RZdHC3Jl7qHi221ZCI=;
        b=pWLYna4Ty7ywLOATE7GoLIrllq7MudJHPKeIxoNLyYrclFCs1XUPdqPgfnc3UmF0VW
         7vpwCUWECGpkzf6h5MXmLFEsnHNUsklmXMAc/N6d4eoqpwHxZuvsoIMOncOdfCa5aBJF
         I3FM84RKSTkKXsFalig1DmOOVJW6+FDGXY2xQ+s7EhkiBS3g66rsT/RB1O6CPeWTpG00
         F8B8xlyOqGS8lmAOMbixTS0kejG6KkllzaUhVTXi+9gSe+IEpiH7EcjD46cQ0gClSJH5
         fX5hKMBuUSNZkGFMrcB5rja5pFJt4RiV4h1BQdJLN67Av6+YLPjcoDFaQubQ4JCpK/Co
         Cn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691119158; x=1691723958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ZLhgCcmfZDUTlG2w/P5PsKE5RZdHC3Jl7qHi221ZCI=;
        b=D2IbopOaXC6spMQCTi+F+MmqYbh01o1PzqyCXbv7MDzGdrCo76GxZhX8cdWytnuEbe
         4tQ+gD6qLKL6nuN5Z3R4jOFWGbxsdZkBSyx/LuJt87dPkp/9gaGpmY+Quhc6iN7JPzgj
         CMuNzlANAzt/vNuKv9J/3WK4S//AlCJuas41RR3aFKfnItmPFKIn8qzSr0WHViMc8GBA
         BkN8DyyQGSN5qrItPHs480a/OlNNqqzZZ8fHf0IA/fFH2H0hSnTCFenH8XPLq4jZXBhC
         krvoZ5Qp1S1H6liOY4hUTZxTJ4dAn0LWMBZlJY78A/nvBuf9HoUVm8CBl/wP9Y+QhD0R
         GD9Q==
X-Gm-Message-State: AOJu0YxLyiPiagomYIMg2/76EYAWxsAgcC/QpGq+GJM4l4RTt5oToMQw
        unUNBtxiyqeaQtWgqMuR7xDW+jXjuDl8xUIuv0rup2eXML5HSw==
X-Google-Smtp-Source: AGHT+IHif3WhiZc8+qtpxfA4UPhR2+ZBCezyzZ5OENdwH8ERoBajVEvBoirzR64VwbK3YckUCZO1bLPebPZfaqGlqP8=
X-Received: by 2002:a05:6402:2752:b0:51e:4218:b91b with SMTP id
 z18-20020a056402275200b0051e4218b91bmr670083edd.1.1691119157776; Thu, 03 Aug
 2023 20:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230803083352.1585-1-zegao@tencent.com> <20230803083352.1585-2-zegao@tencent.com>
 <20230803111031.056b3446@gandalf.local.home> <CAD8CoPBy4Q1khVyhROMMnS=cfbSZuL0GCuSxMcKLRuTb2qtMjQ@mail.gmail.com>
 <CAD8CoPA+rWQfEbuPdmRqk3+6Bpocm5oP2d-cku=Kz_-DSfUVjg@mail.gmail.com>
In-Reply-To: <CAD8CoPA+rWQfEbuPdmRqk3+6Bpocm5oP2d-cku=Kz_-DSfUVjg@mail.gmail.com>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Fri, 4 Aug 2023 11:19:06 +0800
Message-ID: <CAD8CoPAFN7Wor+LZVqTwy5krJ15tav6gSKRzGiaegF--Xak3HQ@mail.gmail.com>
Subject: Re: [RFC PATCH v6 1/5] perf sched: sync state char array with the kernel
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 10:38=E2=80=AFAM Ze Gao <zegao2021@gmail.com> wrote:
>
> On Fri, Aug 4, 2023 at 10:21=E2=80=AFAM Ze Gao <zegao2021@gmail.com> wrot=
e:
> >
> > On Thu, Aug 3, 2023 at 11:10=E2=80=AFPM Steven Rostedt <rostedt@goodmis=
.org> wrote:
> > >
> > > On Thu,  3 Aug 2023 04:33:48 -0400
> > > Ze Gao <zegao2021@gmail.com> wrote:
> > >
> > > > Update state char array and then remove unused and stale
> > > > macros, which are kernel internal representations and not
> > > > encouraged to use anymore.
> > > >
> > > > Signed-off-by: Ze Gao <zegao@tencent.com>
> > > > ---
> > > >  tools/perf/builtin-sched.c | 13 +------------
> > > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > > >
> > > > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.=
c
> > > > index 9ab300b6f131..8dc8f071721c 100644
> > > > --- a/tools/perf/builtin-sched.c
> > > > +++ b/tools/perf/builtin-sched.c
> > > > @@ -92,23 +92,12 @@ struct sched_atom {
> > > >       struct task_desc        *wakee;
> > > >  };
> > > >
> > > > -#define TASK_STATE_TO_CHAR_STR "RSDTtZXxKWP"
> > > > +#define TASK_STATE_TO_CHAR_STR "RSDTtXZPI"
> > >
> > > Thinking about this more, this will always be wrong. Changing it just=
 works
> > > for the kernel you made the change for, but if it is run on another k=
ernel,
> > > it's broken again.
> >
> > Indeed. There is no easy way to maintain backward compatibility unless
> > we stop using this bizarre 'prev_state' field. Basically all its users =
suffer
> > from this. That's why I believe this needs a fix to alert people does n=
ot
> > use 'prev_state' anymore.
> >
> > > I actually wrote code once that basically just did a:
> > >
> > >         struct trace_seq s;
> > >
> > >         trace_seq_init(&s);
> > >         tep_print_event(tep, &s, record, "%s", TEP_PRINT_INFO);
> > >
> > > then searched s.buffer for "prev_state=3D%s ", to find the state char=
acter.
> > >
> > > That's because the kernel should always be up to date (and why I said=
 I
> > > needed that string in the print_fmt).
> >
> > Turing to building the state char array from print fmt string dynamical=
ly
> > is a great idea. :)

I realize this is not perfect as well after second thoughts, since this doe=
s not
take offline use of perf into consideration.  People might run perf on diff=
erent
machines than where the perf.data gets recorded, in which way what we get
from  /sys/kernel/debug/tracing/events/sched/sched_switch/format is likely
different from the perf.data.

So let's parse it from TEP_PRINT_INFO of each record instead of building
the state char array and rely on 'prev_state' again. At least this fix all =
tools
that have TEP_PRINT_INFO available.

Thanks,
Ze



> > > As perf has a tep handle, this could be a helper function to extract =
the
> > > state if needed, and get rind of relying on the above character array=
.
> >
> > I'll figure out how to make it happen.
> >
> > BTW,  my last concern is that is there any better way to notice userspa=
ce to
> > avoid interpreting task state out of 'prev_state'. Because the awkward =
thing
> > happens again.
>
> By userspace, I mean all tools consume 'prev_state' but don't have print =
fmt
> available, taking bpf tracepoint for example.
>
> Regards,
> Ze
>
> > Thanks,
> > Ze
> >
> > > -- Steve
> > >
> > >
> > > >
> > > >  /* task state bitmask, copied from include/linux/sched.h */
> > > >  #define TASK_RUNNING         0
> > > >  #define TASK_INTERRUPTIBLE   1
> > > >  #define TASK_UNINTERRUPTIBLE 2
> > > > -#define __TASK_STOPPED               4
> > > > -#define __TASK_TRACED                8
> > > > -/* in tsk->exit_state */
> > > > -#define EXIT_DEAD            16
> > > > -#define EXIT_ZOMBIE          32
> > > > -#define EXIT_TRACE           (EXIT_ZOMBIE | EXIT_DEAD)
> > > > -/* in tsk->state again */
> > > > -#define TASK_DEAD            64
> > > > -#define TASK_WAKEKILL                128
> > > > -#define TASK_WAKING          256
> > > > -#define TASK_PARKED          512
> > > >
> > > >  enum thread_state {
> > > >       THREAD_SLEEPING =3D 0,
> > >
