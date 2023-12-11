Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46D380CF53
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbjLKPUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbjLKPUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:20:31 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9858E3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:20:36 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40c3fe6c08fso22080595e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1702308035; x=1702912835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXq0VuhHzYxA6UAxnYuyS+zdAc9dBPWzD9GOe+4oeHk=;
        b=RY1eRm8+zt5il4Lrxc2Fd6Cj5eZlT/uylGa/sZ3aWLsKZVVpqWCreiLCt39RUnHb1v
         P1fUyNhf7aVJ605BNvjyeFtd5zTauz6yX0NBBLZi2VS7PF99XmPc/XAwFRy+bGNCExz4
         V5RTEWsknenqoUh4DEZtG0wehdxYtpLBcgXe6FF6QEc3+DWdyO6qJ5tNCIctNrR7QPVF
         zDuEpca9OpXx5KmUMc+J5STTmwYUMZSqDFtsMvthJxtl4vqG2mECk7OIm4fM5FfNQEUG
         GXrKxIAV8V8EKy4006Uy6ggu16iMQ4qOWefXMiBlFN/As15kyQUxx/AH8qmZr/9mDOCe
         dddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308035; x=1702912835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXq0VuhHzYxA6UAxnYuyS+zdAc9dBPWzD9GOe+4oeHk=;
        b=jlfXzwzsz8QVnzJFT1YKkIjz8xGUrz+53t30nlk2Kn/hGXG8ZVFjb2fiGpK/t3lMRA
         5YIS6coRxY7xImkEHbGzY9mhcRfivS25f9BUf+PzAKthZKDPwOv3BjgJXNrCT6oG56/9
         4ZGKN36ob2Nk0NMOP2Y71NNO85dvNy6y3Tcq3oZ/LQj06eNa8xMHkLZBiSXmS7giuzBX
         KJ/N0UxJcVEfPDmM5yt8wl4YcKQX1wA2AGxFYX1wZFF202PbVZ6yKtNJYfULN83t5CEd
         wG0Wg4eUhmHnMZlvcz8/FbaEGv9xyHipGSYNZwpdg3UKHno21md63LNJvle8snmVGIPF
         SQnQ==
X-Gm-Message-State: AOJu0YwD5XsAOdW3skuvAh7vFqYi5bNczRRi4N7+9ovqa8rLvoXGAPMk
        UKW+lqv7u0Rob5zb2kAyjRtLK/L8m99ZniChrfvadg==
X-Google-Smtp-Source: AGHT+IHKxhKUy/Hd/JeWLyWCd8g3I6OWQ1WkdT4sbr1/e4YI+eOJefXfCW2XHjN04eKK1NFBokhRrvRhgT/Z423EJAc=
X-Received: by 2002:a1c:770c:0:b0:40c:38dd:1b1a with SMTP id
 t12-20020a1c770c000000b0040c38dd1b1amr1555163wmi.211.1702308034950; Mon, 11
 Dec 2023 07:20:34 -0800 (PST)
MIME-Version: 1.0
References: <20231211045543.31741-1-khuey@kylehuey.com> <20231211045543.31741-2-khuey@kylehuey.com>
 <CANpmjNPvZ=S5Afn9DR7nG2UFstqz5t1gBznTh4yezVv7k1+m9w@mail.gmail.com>
In-Reply-To: <CANpmjNPvZ=S5Afn9DR7nG2UFstqz5t1gBznTh4yezVv7k1+m9w@mail.gmail.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Mon, 11 Dec 2023 07:20:22 -0800
Message-ID: <CAP045ApSQWLouDd65-M4+TFiKFjDF1aMPnPW-Ue+e63NhQnUwQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] perf/bpf: Call bpf handler directly, not through
 overflow machinery
To:     Marco Elver <elver@google.com>
Cc:     Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        "Robert O'Callahan" <robert@ocallahan.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 6:20=E2=80=AFAM Marco Elver <elver@google.com> wrot=
e:
>
> On Mon, 11 Dec 2023 at 05:55, Kyle Huey <me@kylehuey.com> wrote:
> >
> > To ultimately allow bpf programs attached to perf events to completely
> > suppress all of the effects of a perf event overflow (rather than just =
the
> > sample output, as they do today), call bpf_overflow_handler() from
> > __perf_event_overflow() directly rather than modifying struct perf_even=
t's
> > overflow_handler. Return the bpf program's return value from
> > bpf_overflow_handler() so that __perf_event_overflow() knows how to
> > proceed. Remove the now unnecessary orig_overflow_handler from struct
> > perf_event.
> >
> > This patch is solely a refactoring and results in no behavior change.
> >
> > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  include/linux/perf_event.h |  6 +-----
> >  kernel/events/core.c       | 28 +++++++++++++++-------------
> >  2 files changed, 16 insertions(+), 18 deletions(-)
> >
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 5547ba68e6e4..312b9f31442c 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -810,7 +810,6 @@ struct perf_event {
> >         perf_overflow_handler_t         overflow_handler;
> >         void                            *overflow_handler_context;
> >  #ifdef CONFIG_BPF_SYSCALL
> > -       perf_overflow_handler_t         orig_overflow_handler;
> >         struct bpf_prog                 *prog;
> >         u64                             bpf_cookie;
> >  #endif
> > @@ -1337,10 +1336,7 @@ __is_default_overflow_handler(perf_overflow_hand=
ler_t overflow_handler)
> >  #ifdef CONFIG_BPF_SYSCALL
> >  static inline bool uses_default_overflow_handler(struct perf_event *ev=
ent)
> >  {
> > -       if (likely(is_default_overflow_handler(event)))
> > -               return true;
> > -
> > -       return __is_default_overflow_handler(event->orig_overflow_handl=
er);
> > +       return is_default_overflow_handler(event);
> >  }
> >  #else
> >  #define uses_default_overflow_handler(event) \
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index b704d83a28b2..54f6372d2634 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -9515,6 +9515,12 @@ static inline bool sample_is_allowed(struct perf=
_event *event, struct pt_regs *r
> >         return true;
> >  }
> >
> > +#ifdef CONFIG_BPF_SYSCALL
> > +static int bpf_overflow_handler(struct perf_event *event,
> > +                               struct perf_sample_data *data,
> > +                               struct pt_regs *regs);
> > +#endif
>
> To avoid more #ifdefs we usually add a stub, something like:
>
> #ifdef ...
> static int bpf_overflow_handler(...);
> #else
> static inline int bpf_overflow_handler(...) { return 0; }
> #endif
>
> Then you can avoid more #ifdefs below, esp. when it surrounds an
> if-statement it easily leads to confusion or subtle bugs in future
> changes. The compiler will optimize out the constants and the
> generated code will be the same.

This would not allow removing any #ifdefs because event->prog is only
present if CONFIG_BPF_SYSCALL is defined.

- Kyle

> >  /*
> >   * Generic event overflow handling, sampling.
> >   */
> > @@ -9584,7 +9590,10 @@ static int __perf_event_overflow(struct perf_eve=
nt *event,
> >                 irq_work_queue(&event->pending_irq);
> >         }
> >
> > -       READ_ONCE(event->overflow_handler)(event, data, regs);
> > +#ifdef CONFIG_BPF_SYSCALL
> > +       if (!(event->prog && !bpf_overflow_handler(event, data, regs)))
> > +#endif
> > +               READ_ONCE(event->overflow_handler)(event, data, regs);
> >
> >         if (*perf_event_fasync(event) && event->pending_kill) {
> >                 event->pending_wakeup =3D 1;
> > @@ -10394,9 +10403,9 @@ static void perf_event_free_filter(struct perf_=
event *event)
> >  }
> >
> >  #ifdef CONFIG_BPF_SYSCALL
> > -static void bpf_overflow_handler(struct perf_event *event,
> > -                                struct perf_sample_data *data,
> > -                                struct pt_regs *regs)
> > +static int bpf_overflow_handler(struct perf_event *event,
> > +                               struct perf_sample_data *data,
> > +                               struct pt_regs *regs)
> >  {
> >         struct bpf_perf_event_data_kern ctx =3D {
> >                 .data =3D data,
> > @@ -10417,10 +10426,8 @@ static void bpf_overflow_handler(struct perf_e=
vent *event,
> >         rcu_read_unlock();
> >  out:
> >         __this_cpu_dec(bpf_prog_active);
> > -       if (!ret)
> > -               return;
> >
> > -       event->orig_overflow_handler(event, data, regs);
> > +       return ret;
> >  }
> >
> >  static int perf_event_set_bpf_handler(struct perf_event *event,
> > @@ -10456,8 +10463,6 @@ static int perf_event_set_bpf_handler(struct pe=
rf_event *event,
> >
> >         event->prog =3D prog;
> >         event->bpf_cookie =3D bpf_cookie;
> > -       event->orig_overflow_handler =3D READ_ONCE(event->overflow_hand=
ler);
> > -       WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
> >         return 0;
> >  }
> >
> > @@ -10468,7 +10473,6 @@ static void perf_event_free_bpf_handler(struct =
perf_event *event)
> >         if (!prog)
> >                 return;
> >
> > -       WRITE_ONCE(event->overflow_handler, event->orig_overflow_handle=
r);
> >         event->prog =3D NULL;
> >         bpf_prog_put(prog);
> >  }
> > @@ -11928,13 +11932,11 @@ perf_event_alloc(struct perf_event_attr *attr=
, int cpu,
> >                 overflow_handler =3D parent_event->overflow_handler;
> >                 context =3D parent_event->overflow_handler_context;
> >  #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
> > -               if (overflow_handler =3D=3D bpf_overflow_handler) {
> > +               if (parent_event->prog) {
> >                         struct bpf_prog *prog =3D parent_event->prog;
> >
> >                         bpf_prog_inc(prog);
> >                         event->prog =3D prog;
> > -                       event->orig_overflow_handler =3D
> > -                               parent_event->orig_overflow_handler;
> >                 }
> >  #endif
> >         }
> > --
> > 2.34.1
> >
