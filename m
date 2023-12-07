Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00B8809664
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 00:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444057AbjLGXCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 18:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLGXCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 18:02:08 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0A410EF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 15:02:14 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54dca2a3f16so2283468a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 15:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1701990133; x=1702594933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12HCXgU+vznucLu0wMRthOiLEPRh9ZKY7qobr4QejA4=;
        b=bH29X2IcBwNWQ4r5bfbXPPaReUQLSU+k7Kvq+MmnDI/U2/7OFJ9c1LoOQVSg66vYtc
         4/++iGKo0SBdd7i6i3D32UQZfnKKQTanOaieNLtfEwIIfQJpaUNZtv5LPTDGmLYIe3D1
         am3TvBAC0Z1c4AQRPfaMS5iBH97RE4wAmsvqe5wFvOYd6NxTIlRFQAbGhYSr+7rh6xC5
         4A0FiNCrtvcGRh5SPWwnWb0fw4ARjHNwpAF00UT6kn/YJWhIdmSJHX2bpq0xXxrPymqR
         OLhOSUEG3yg6MXrOye4NAYXBz5aFmsdr/Nm81RAqinbbzJrWwH6yBdD7y7CkMzulXKza
         kGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701990133; x=1702594933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12HCXgU+vznucLu0wMRthOiLEPRh9ZKY7qobr4QejA4=;
        b=t4UTgYPHpEX+VLG4HWldxg1HZdq3ZNIJ6wF+pfblDA9yqVIPnGrSVpOZN0z4aiZUG2
         V4rTvQVs816LtELggnERcQi0MhA3tcHY7nE2jriI3D7FLKV8ND9BP3z92eUamXeTnlAs
         3nDnB/TujyErqcywsIX/aG1a8o+o863qY9KUa0Up5Z6N4b7l+1FmNIW8Ys6LchnO2uxe
         98KrezNdi8MQrp9cvLtvSN514ggnH8Y04gMuDsWv4NrM+qRBkBaXLpQZNohSIAYWsy+V
         8HfX4OSbbPLbH761tMD9MywoRQFDmuzNAJFf2qEe7V5mQHSzxmOO4yKSsqcsAOUU+UkD
         YUCA==
X-Gm-Message-State: AOJu0Yyf28gPxescv5jeqGyh5bPNBE+8aVfApWRrw11tyK+cKK4EBZ1L
        DwEdxZM9xzGw0F1LDXkPEfDkE6Wi2oIaluSHgnC83A==
X-Google-Smtp-Source: AGHT+IEne8Wes/BTndbhv4oWFMrBjXu4casXYVdn1meV+EWcdhDKwt3dvMqcbtB46fu7b8CHr7+p/iYJix63PLxO6VU=
X-Received: by 2002:a17:906:3b99:b0:a1d:4874:1ab7 with SMTP id
 u25-20020a1709063b9900b00a1d48741ab7mr36186ejf.65.1701990132593; Thu, 07 Dec
 2023 15:02:12 -0800 (PST)
MIME-Version: 1.0
References: <20231207163458.5554-1-khuey@kylehuey.com> <20231207163458.5554-2-khuey@kylehuey.com>
 <CANpmjNNi1WoE0gsq5TSv8ys68YcF2o+LtWiDj+=bZ3Y46oP7Jw@mail.gmail.com>
 <CAP045Ap8z0qUpuYtbf9hpBqfnngNU7wVT0HM0XwQMrYYt9CAkg@mail.gmail.com>
 <CANpmjNOCFz43zhJm1mS5Ai1XTQiZ_-BW2K3z8vJEV4CyfoZtCA@mail.gmail.com> <ZXJJa5re536_e7c1@google.com>
In-Reply-To: <ZXJJa5re536_e7c1@google.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Thu, 7 Dec 2023 15:02:01 -0800
Message-ID: <CAP045ArTufm+6m9KcnuX5Doe4U6LzKYOHtEqrhvb28U3_HE_cw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf: Reorder overflow handler ahead of event_limit/sigtrap
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Marco Elver <elver@google.com>, Kyle Huey <khuey@kylehuey.com>,
        open list <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        "Robert O'Callahan" <robert@ocallahan.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 2:38=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hello,
>
> On Thu, Dec 07, 2023 at 06:53:58PM +0100, Marco Elver wrote:
> > On Thu, 7 Dec 2023 at 18:47, Kyle Huey <me@kylehuey.com> wrote:
> > >
> > >
> > >
> > > On Thu, Dec 7, 2023, 9:05=E2=80=AFAM Marco Elver <elver@google.com> w=
rote:
> > >>
> > >> On Thu, 7 Dec 2023 at 17:35, Kyle Huey <me@kylehuey.com> wrote:
> > >> >
> > >> > The perf subsystem already allows an overflow handler to clear pen=
ding_kill
> > >> > to suppress a fasync signal (although nobody currently does this).=
 Allow an
> > >> > overflow handler to suppress the other visible side effects of an =
overflow,
> > >> > namely event_limit accounting and SIGTRAP generation.
>
> Well, I think it can still hit the throttling logic and generate
> a PERF_RECORD_THROTTLE.  But it should be rare..
>
> > >> >
> > >> > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
> > >> > ---
> > >> >  kernel/events/core.c | 10 +++++++---
> > >> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > >> >
> > >> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > >> > index b704d83a28b2..19fddfc27a4a 100644
> > >> > --- a/kernel/events/core.c
> > >> > +++ b/kernel/events/core.c
> > >> > @@ -9541,6 +9541,12 @@ static int __perf_event_overflow(struct per=
f_event *event,
> > >> >          */
> > >> >
> > >> >         event->pending_kill =3D POLL_IN;
> > >> > +
> > >> > +       READ_ONCE(event->overflow_handler)(event, data, regs);
> > >> > +
> > >> > +       if (!event->pending_kill)
> > >> > +               return ret;
> > >>
> > >> It's not at all intuitive that resetting pending_kill to 0 will
> > >> suppress everything else, too. There is no relationship between the
> > >> fasync signals and SIGTRAP. pending_kill is for the former and
> > >> pending_sigtrap is for the latter. One should not affect the other.
> > >>
> > >> A nicer solution would be to properly undo the various pending_*
> > >> states (in the case of pending_sigtrap being set it should be enough
> > >> to reset pending_sigtrap to 0, and also decrement
> > >> event->ctx->nr_pending).
> > >
> > >
> > > I don't believe it's possible to correctly undo the event_limit decre=
ment after the fact (if it's e.g. racing with the ioctl that adds to the ev=
ent limit).
> > >
> > >> Although I can see why this solution is simpler. Perhaps with enough
> > >> comments it might be clearer.
> > >>
> > >> Preferences?
> > >
> > >
> > > The cleanest way would probably be to add a return value to the overf=
low handler function that controls this. It requires changing a bunch of ar=
ch specific code on arches I don't have access to though.
> >
> > Hmm.
> >
> > Maybe wait for perf maintainers to say what is preferrable. (I could
> > live with just making sure this has no other weird side effects and
> > more comments.)
>
> What if we can call bpf handler directly and check the return value?
> Then I think we can also get rid of the original overflow handler.
>
> Something like this (untested..)

mmm, that's an interesting idea. I'll experiment with it.

- Kyle

> Thanks,
> Namhyung
>
>
> ---8<---
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index e85cd1c0eaf3..1eba6f5bb70b 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -809,7 +809,6 @@ struct perf_event {
>         perf_overflow_handler_t         overflow_handler;
>         void                            *overflow_handler_context;
>  #ifdef CONFIG_BPF_SYSCALL
> -       perf_overflow_handler_t         orig_overflow_handler;
>         struct bpf_prog                 *prog;
>         u64                             bpf_cookie;
>  #endif
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4c72a41f11af..e1a00646dbbe 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -9471,6 +9471,12 @@ static inline bool sample_is_allowed(struct perf_e=
vent *event, struct pt_regs *r
>   * Generic event overflow handling, sampling.
>   */
>
> +#ifdef CONFIG_BPF_SYSCALL
> +static int bpf_overflow_handler(struct perf_event *event,
> +                               struct perf_sample_data *data,
> +                               struct pt_regs *regs);
> +#endif
> +
>  static int __perf_event_overflow(struct perf_event *event,
>                                  int throttle, struct perf_sample_data *d=
ata,
>                                  struct pt_regs *regs)
> @@ -9487,6 +9493,11 @@ static int __perf_event_overflow(struct perf_event=
 *event,
>
>         ret =3D __perf_event_account_interrupt(event, throttle);
>
> +#ifdef CONFIG_BPF_SYSCALL
> +       if (event->prog && bpf_overflow_handler(event, data, regs) =3D=3D=
 0)
> +               return ret;
> +#endif
> +
>         /*
>          * XXX event_limit might not quite work as expected on inherited
>          * events
> @@ -10346,7 +10357,7 @@ static void perf_event_free_filter(struct perf_ev=
ent *event)
>  }
>
>  #ifdef CONFIG_BPF_SYSCALL
> -static void bpf_overflow_handler(struct perf_event *event,
> +static int bpf_overflow_handler(struct perf_event *event,
>                                  struct perf_sample_data *data,
>                                  struct pt_regs *regs)
>  {
> @@ -10355,7 +10366,7 @@ static void bpf_overflow_handler(struct perf_even=
t *event,
>                 .event =3D event,
>         };
>         struct bpf_prog *prog;
> -       int ret =3D 0;
> +       int ret =3D 1;
>
>         ctx.regs =3D perf_arch_bpf_user_pt_regs(regs);
>         if (unlikely(__this_cpu_inc_return(bpf_prog_active) !=3D 1))
> @@ -10369,10 +10380,7 @@ static void bpf_overflow_handler(struct perf_eve=
nt *event,
>         rcu_read_unlock();
>  out:
>         __this_cpu_dec(bpf_prog_active);
> -       if (!ret)
> -               return;
> -
> -       event->orig_overflow_handler(event, data, regs);
> +       return ret;
>  }
>
>  static int perf_event_set_bpf_handler(struct perf_event *event,
> @@ -10408,8 +10416,6 @@ static int perf_event_set_bpf_handler(struct perf=
_event *event,
>
>         event->prog =3D prog;
>         event->bpf_cookie =3D bpf_cookie;
> -       event->orig_overflow_handler =3D READ_ONCE(event->overflow_handle=
r);
> -       WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
>         return 0;
>  }
>
> @@ -10420,7 +10426,6 @@ static void perf_event_free_bpf_handler(struct pe=
rf_event *event)
>         if (!prog)
>                 return;
>
> -       WRITE_ONCE(event->overflow_handler, event->orig_overflow_handler)=
;
>         event->prog =3D NULL;
>         bpf_prog_put(prog);
>  }
> @@ -11880,13 +11885,11 @@ perf_event_alloc(struct perf_event_attr *attr, =
int cpu,
>                 overflow_handler =3D parent_event->overflow_handler;
>                 context =3D parent_event->overflow_handler_context;
>  #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
> -               if (overflow_handler =3D=3D bpf_overflow_handler) {
> +               if (parent_event->prog) {
>                         struct bpf_prog *prog =3D parent_event->prog;
>
>                         bpf_prog_inc(prog);
>                         event->prog =3D prog;
> -                       event->orig_overflow_handler =3D
> -                               parent_event->orig_overflow_handler;
>                 }
>  #endif
>         }
