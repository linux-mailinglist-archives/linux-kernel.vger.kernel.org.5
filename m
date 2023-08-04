Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF94676F7EB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjHDCjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjHDCjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:39:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340C83C28;
        Thu,  3 Aug 2023 19:39:11 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c93638322so71391066b.1;
        Thu, 03 Aug 2023 19:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691116749; x=1691721549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jqrn5FwRmYKZxdKak+B9p3O7S1Hvqc3owFoRdiVXXDk=;
        b=dTzdnjnrpilUqKvvsurvBJQiXd0Xnkd8BIJgEtBIoQdXtGLS6VQMildFlyShpJhXV/
         vBL1+vFHGVOxe+G1ko+iNZJQrZ+7LJJcRz1VMMztOHqW1Vli6uum8T5d6cUzSCFRTqcT
         3RUJbQSyjC57Vk0DKniWuIPQ9QirGVI9OTEm1FS/mc4X4JywTp1WzxkfL7xWwoTv0tUE
         O4K/Lv7nQ81l2ZxqgNZvfR38zWfqIIP2+ZTIs26L41BAdjmbQs+qEiu/WkHdziiomlJ5
         HG55wuNSWwCigN/mRksjxASq9r11F1uBAYl4kxCZApmpcQREXEbrDUJVFB6krBBnqgod
         FOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691116749; x=1691721549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jqrn5FwRmYKZxdKak+B9p3O7S1Hvqc3owFoRdiVXXDk=;
        b=hfbSFT6Yt0xpIcyh8w0WzXii08MSglbWEGdDO5dCmyD/3EYXCgZl7tk6RcOAn2+vgb
         L1uePvxKX2ZXaJ10mSlfCEKZVYpYiidzfj+rGONKO69yb4GaOX+30Q3u71BBAkGzkUqn
         71wcmC4eSHmee/4UIK1XJpdPD2hxBAYZIVZHYLfZuwPOZXMXGm81YoX02Se59dHtAlOI
         pMuCkm+/KICgs3oW94awXjfG7UyfpBZa/w70trejvYHSAEeLCMh5/y8weme1MLOvUKpZ
         G8vHAyy6Mbh6raMtRxJ7zq7fgjbJYOGNLNP+uLwRZsO/1gYvI3AfQa15DLCevDxXED7g
         tZcA==
X-Gm-Message-State: AOJu0YxybOzTMaNQcwJkTmw2Mu2OOXALXkyNg68NqB8wC/THE44Z51xa
        rph+VHb3LrgPVOmJfGUCco3M/Km/rr/lABMUrPs=
X-Google-Smtp-Source: AGHT+IECaoV5ug3vuWtU7UbPUd4o4ZHgfgI/l5kZCpKw+wLDLdbNw2OsK0hNJh5zB9+ShodFQ1s7/Qyx3+Yd03aRzmE=
X-Received: by 2002:a17:907:8a10:b0:99b:fcd7:2d7a with SMTP id
 sc16-20020a1709078a1000b0099bfcd72d7amr549779ejc.34.1691116749444; Thu, 03
 Aug 2023 19:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230803083352.1585-1-zegao@tencent.com> <20230803083352.1585-2-zegao@tencent.com>
 <20230803111031.056b3446@gandalf.local.home> <CAD8CoPBy4Q1khVyhROMMnS=cfbSZuL0GCuSxMcKLRuTb2qtMjQ@mail.gmail.com>
In-Reply-To: <CAD8CoPBy4Q1khVyhROMMnS=cfbSZuL0GCuSxMcKLRuTb2qtMjQ@mail.gmail.com>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Fri, 4 Aug 2023 10:38:58 +0800
Message-ID: <CAD8CoPA+rWQfEbuPdmRqk3+6Bpocm5oP2d-cku=Kz_-DSfUVjg@mail.gmail.com>
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 10:21=E2=80=AFAM Ze Gao <zegao2021@gmail.com> wrote:
>
> On Thu, Aug 3, 2023 at 11:10=E2=80=AFPM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> >
> > On Thu,  3 Aug 2023 04:33:48 -0400
> > Ze Gao <zegao2021@gmail.com> wrote:
> >
> > > Update state char array and then remove unused and stale
> > > macros, which are kernel internal representations and not
> > > encouraged to use anymore.
> > >
> > > Signed-off-by: Ze Gao <zegao@tencent.com>
> > > ---
> > >  tools/perf/builtin-sched.c | 13 +------------
> > >  1 file changed, 1 insertion(+), 12 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > > index 9ab300b6f131..8dc8f071721c 100644
> > > --- a/tools/perf/builtin-sched.c
> > > +++ b/tools/perf/builtin-sched.c
> > > @@ -92,23 +92,12 @@ struct sched_atom {
> > >       struct task_desc        *wakee;
> > >  };
> > >
> > > -#define TASK_STATE_TO_CHAR_STR "RSDTtZXxKWP"
> > > +#define TASK_STATE_TO_CHAR_STR "RSDTtXZPI"
> >
> > Thinking about this more, this will always be wrong. Changing it just w=
orks
> > for the kernel you made the change for, but if it is run on another ker=
nel,
> > it's broken again.
>
> Indeed. There is no easy way to maintain backward compatibility unless
> we stop using this bizarre 'prev_state' field. Basically all its users su=
ffer
> from this. That's why I believe this needs a fix to alert people does not
> use 'prev_state' anymore.
>
> > I actually wrote code once that basically just did a:
> >
> >         struct trace_seq s;
> >
> >         trace_seq_init(&s);
> >         tep_print_event(tep, &s, record, "%s", TEP_PRINT_INFO);
> >
> > then searched s.buffer for "prev_state=3D%s ", to find the state charac=
ter.
> >
> > That's because the kernel should always be up to date (and why I said I
> > needed that string in the print_fmt).
>
> Turing to building the state char array from print fmt string dynamically
> is a great idea. :)
>
> > As perf has a tep handle, this could be a helper function to extract th=
e
> > state if needed, and get rind of relying on the above character array.
>
> I'll figure out how to make it happen.
>
> BTW,  my last concern is that is there any better way to notice userspace=
 to
> avoid interpreting task state out of 'prev_state'. Because the awkward th=
ing
> happens again.

By userspace, I mean all tools consume 'prev_state' but don't have print fm=
t
available, taking bpf tracepoint for example.

Regards,
Ze

> Thanks,
> Ze
>
> > -- Steve
> >
> >
> > >
> > >  /* task state bitmask, copied from include/linux/sched.h */
> > >  #define TASK_RUNNING         0
> > >  #define TASK_INTERRUPTIBLE   1
> > >  #define TASK_UNINTERRUPTIBLE 2
> > > -#define __TASK_STOPPED               4
> > > -#define __TASK_TRACED                8
> > > -/* in tsk->exit_state */
> > > -#define EXIT_DEAD            16
> > > -#define EXIT_ZOMBIE          32
> > > -#define EXIT_TRACE           (EXIT_ZOMBIE | EXIT_DEAD)
> > > -/* in tsk->state again */
> > > -#define TASK_DEAD            64
> > > -#define TASK_WAKEKILL                128
> > > -#define TASK_WAKING          256
> > > -#define TASK_PARKED          512
> > >
> > >  enum thread_state {
> > >       THREAD_SLEEPING =3D 0,
> >
