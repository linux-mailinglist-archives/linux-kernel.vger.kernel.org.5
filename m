Return-Path: <linux-kernel+bounces-22610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA48182A063
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3121C226BC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147894D5A0;
	Wed, 10 Jan 2024 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/ktKqKG"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C284CDEB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 18:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-680a06cc763so29708376d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704912314; x=1705517114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKJnfLafpJTZXDC2ZcqRSZlmlslVQrHTAikttS1UbXQ=;
        b=q/ktKqKG840iTqDddQ0y3O53zIo71uUs6iQklOiUtthW3c03/Q4H/YTSjtzisB4ih2
         7vt6cU7NVct/5sQe9cG6vjDch+zDPbETQf8iQOhdb2ACxDTHM9PH6MlTnNIAwgANaAc2
         QOmrLnvarYn1DIWpw6O7XmlW0p0zrkdcwY/C7lR+/1zfWLl1O4E9WMvwzhAHoOjZnMup
         UhsFDkaMEegfWqKphqbysOWtZ77sPMTd8iYw8oHkXdFrrdgQfgPfsjreZpZAXrdhjnhI
         IKkWSbdTpsdYsWteJOn3g6ZL2kDOcWQFYJ90fCWTk6ejmg7z6AEdRtbHpxILlq9/vdl2
         ohbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704912314; x=1705517114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKJnfLafpJTZXDC2ZcqRSZlmlslVQrHTAikttS1UbXQ=;
        b=fo9Ghw6/uOwF2+rm7auZg1CtgIHUG7ghNsUzAy/MoOpmFDH9l3FzPOXB0FHfEOEJM1
         fR7L02LT4k9Irxaj1Dea7XWHUhZVKcrT3E2HnQ7gAOGBWPl5cWeWrpnAHvasSqtGsVj5
         FybxSolLmhhPsYFJfaMK+1GiPQRWkGHlvH0at9nCJqhctvC/DWDfQvdiKusTPdSW+I7u
         cDRnjZCZBAjkf9jKejZG6vN1oblsGuIpPrIJyjpX/NSqNBFPX8GIcbYjR8LPFuYv3t3J
         DDpmpQYrGMaUTAwNG2VQeLl0GHIk7eqmZok7U9D7uQm9bzw1IWSPnn+D5BpGR/Ehx1l3
         2X3g==
X-Gm-Message-State: AOJu0YxZDBQunx36GhAcQ6iavmaqEDUwaVQo7kMxqNXXq6fSTAA/9SBU
	TNf6XoyDJGWc2VBNkQuDBfvtWwxxuOLEUk6aPXnk4aZKxTl4
X-Google-Smtp-Source: AGHT+IHXO2LW/oKgHdZjI+YMCFhycfCp10LOtsgbpu79qqLZdWo05LHX6A8Zh1jHo0BG4yQ8JGYjLvj1B01yq7QKzbc=
X-Received: by 2002:a05:6214:2a8a:b0:67f:af66:c9ca with SMTP id
 jr10-20020a0562142a8a00b0067faf66c9camr1607458qvb.72.1704912313900; Wed, 10
 Jan 2024 10:45:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109213623.449371-1-namhyung@kernel.org> <ZZ6ug3IOeQlmQnsM@FVFF77S0Q05N>
 <CAM9d7cimwXVYpN7Tk3T6OMRAVo843AHHewndXkefn3r5g8549g@mail.gmail.com>
In-Reply-To: <CAM9d7cimwXVYpN7Tk3T6OMRAVo843AHHewndXkefn3r5g8549g@mail.gmail.com>
From: Mingwei Zhang <mizhang@google.com>
Date: Wed, 10 Jan 2024 10:44:38 -0800
Message-ID: <CAL715W+YyB4npYZOX6u-KgtP0UNuoQvAAjEHEp=w2HYYWJwDAg@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/2] perf/core: Update perf_adjust_freq_unthr_context()
To: Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 10:27=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Mark,
>
> On Wed, Jan 10, 2024 at 6:49=E2=80=AFAM Mark Rutland <mark.rutland@arm.co=
m> wrote:
> >
> > On Tue, Jan 09, 2024 at 01:36:22PM -0800, Namhyung Kim wrote:
> > > It was unnecessarily disabling and enabling PMUs for each event.  It
> > > should be done at PMU level.  Add pmu_ctx->nr_freq counter to check i=
t
> > > at each PMU.  As pmu context has separate active lists for pinned gro=
up
> > > and flexible group, factor out a new function to do the job.
> > >
> > > Another minor optimization is that it can skip PMUs w/ CAP_NO_INTERRU=
PT
> > > even if it needs to unthrottle sampling events.
> > >
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > > Tested-by: Mingwei Zhang <mizhang@google.com>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Hi,
> >
> > I've taken a quick look and I don't think this is quite right for
> > hybrid/big.LITTLE, but I think that should be relatively simple to fix =
(more on
> > that below).
>
> Thanks for your review!
>
> >
> > This seems to be a bunch of optimizations; was that based on inspection=
 alone,
> > or have you found a workload where this has a measureable impact?
>
> It's from a code inspection but I think Mingwei reported some excessive
> MSR accesses for KVM use cases.  Anyway it'd increase the interrupt \
> latency if you have slow (uncore) PMUs and lots of events on those PMUs.
>

Yes, we have observed a huge host-level overhead when guest PMU is
multiplexing events in frequency mode. The investigation finally
narrows down to this code after profiling. We find that there are
excessive MSR writes to 0x38f, which is caused by PMU disable and
enable operations. These operations are pretty heavy weight in a
virtualized environment because all of the wrmsr to 0x38f will not
directly go to HW but get redirected via perf API to the host PMU. The
round trip overhead is very high. Note that this overhead is
implicitly visible to guests, ie., when a guest is running a
CPU-saturating workload (eg., SPEC2017), they will see their vCPU
performance return to ancient times.

The interesting part that I have observed after applying this patch is
the increase of guest PMIs. This (or there might be another reason)
causes the host-level overhead to remain high.

But the patch is still quite useful as it does reduce the excessive
VMEXITs caused by excessive wrmsr to 0x38f.

Thanks.
-Mingwei
> >
> > > ---
> > >  include/linux/perf_event.h |  1 +
> > >  kernel/events/core.c       | 68 +++++++++++++++++++++++-------------=
--
> > >  2 files changed, 43 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > > index d2a15c0c6f8a..b2ff60fa487e 100644
> > > --- a/include/linux/perf_event.h
> > > +++ b/include/linux/perf_event.h
> > > @@ -883,6 +883,7 @@ struct perf_event_pmu_context {
> > >
> > >       unsigned int                    nr_events;
> > >       unsigned int                    nr_cgroups;
> > > +     unsigned int                    nr_freq;
> > >
> > >       atomic_t                        refcount; /* event <-> epc */
> > >       struct rcu_head                 rcu_head;
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index 59b332cce9e7..ce9db9dbfd4c 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -2277,8 +2277,10 @@ event_sched_out(struct perf_event *event, stru=
ct perf_event_context *ctx)
> > >
> > >       if (!is_software_event(event))
> > >               cpc->active_oncpu--;
> > > -     if (event->attr.freq && event->attr.sample_freq)
> > > +     if (event->attr.freq && event->attr.sample_freq) {
> > >               ctx->nr_freq--;
> > > +             epc->nr_freq--;
> > > +     }
> > >       if (event->attr.exclusive || !cpc->active_oncpu)
> > >               cpc->exclusive =3D 0;
> > >
> > > @@ -2533,9 +2535,10 @@ event_sched_in(struct perf_event *event, struc=
t perf_event_context *ctx)
> > >
> > >       if (!is_software_event(event))
> > >               cpc->active_oncpu++;
> > > -     if (event->attr.freq && event->attr.sample_freq)
> > > +     if (event->attr.freq && event->attr.sample_freq) {
> > >               ctx->nr_freq++;
> > > -
> > > +             epc->nr_freq++;
> > > +     }
> > >       if (event->attr.exclusive)
> > >               cpc->exclusive =3D 1;
> > >
> > > @@ -4098,30 +4101,14 @@ static void perf_adjust_period(struct perf_ev=
ent *event, u64 nsec, u64 count, bo
> > >       }
> > >  }
> > >
> > > -/*
> > > - * combine freq adjustment with unthrottling to avoid two passes ove=
r the
> > > - * events. At the same time, make sure, having freq events does not =
change
> > > - * the rate of unthrottling as that would introduce bias.
> > > - */
> > > -static void
> > > -perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool =
unthrottle)
> > > +static void perf_adjust_freq_unthr_events(struct list_head *event_li=
st)
> > >  {
> > >       struct perf_event *event;
> > >       struct hw_perf_event *hwc;
> > >       u64 now, period =3D TICK_NSEC;
> > >       s64 delta;
> > >
> > > -     /*
> > > -      * only need to iterate over all events iff:
> > > -      * - context have events in frequency mode (needs freq adjust)
> > > -      * - there are events to unthrottle on this cpu
> > > -      */
> > > -     if (!(ctx->nr_freq || unthrottle))
> > > -             return;
> > > -
> > > -     raw_spin_lock(&ctx->lock);
> > > -
> > > -     list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
> > > +     list_for_each_entry(event, event_list, active_list) {
> > >               if (event->state !=3D PERF_EVENT_STATE_ACTIVE)
> > >                       continue;
> > >
> > > @@ -4129,8 +4116,6 @@ perf_adjust_freq_unthr_context(struct perf_even=
t_context *ctx, bool unthrottle)
> > >               if (!event_filter_match(event))
> > >                       continue;
> > >
> > > -             perf_pmu_disable(event->pmu);
> > > -
> > >               hwc =3D &event->hw;
> > >
> > >               if (hwc->interrupts =3D=3D MAX_INTERRUPTS) {
> > > @@ -4140,7 +4125,7 @@ perf_adjust_freq_unthr_context(struct perf_even=
t_context *ctx, bool unthrottle)
> > >               }
> > >
> > >               if (!event->attr.freq || !event->attr.sample_freq)
> > > -                     goto next;
> > > +                     continue;
> > >
> > >               /*
> > >                * stop the event and update event->count
> > > @@ -4162,8 +4147,39 @@ perf_adjust_freq_unthr_context(struct perf_eve=
nt_context *ctx, bool unthrottle)
> > >                       perf_adjust_period(event, period, delta, false)=
;
> > >
> > >               event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0=
);
> > > -     next:
> > > -             perf_pmu_enable(event->pmu);
> > > +     }
> > > +}
> > > +
> > > +/*
> > > + * combine freq adjustment with unthrottling to avoid two passes ove=
r the
> > > + * events. At the same time, make sure, having freq events does not =
change
> > > + * the rate of unthrottling as that would introduce bias.
> > > + */
> > > +static void
> > > +perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool =
unthrottle)
> > > +{
> > > +     struct perf_event_pmu_context *pmu_ctx;
> > > +
> > > +     /*
> > > +      * only need to iterate over all events iff:
> > > +      * - context have events in frequency mode (needs freq adjust)
> > > +      * - there are events to unthrottle on this cpu
> > > +      */
> > > +     if (!(ctx->nr_freq || unthrottle))
> > > +             return;
> > > +
> > > +     raw_spin_lock(&ctx->lock);
> > > +
> > > +     list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry)=
 {
> > > +             if (!(pmu_ctx->nr_freq || unthrottle))
> > > +                     continue;
> > > +             if (pmu_ctx->pmu->capabilities & PERF_PMU_CAP_NO_INTERR=
UPT)
> > > +                     continue;
> > > +
> > > +             perf_pmu_disable(pmu_ctx->pmu);
> > > +             perf_adjust_freq_unthr_events(&pmu_ctx->pinned_active);
> > > +             perf_adjust_freq_unthr_events(&pmu_ctx->flexible_active=
);
> > > +             perf_pmu_enable(pmu_ctx->pmu);
> > >       }
> >
> > I don't think this is correct for big.LITTLE/hybrid systems.
> >
> > Imagine a system where CPUs 0-1 have pmu_a, CPUs 2-3 have pmu_b, and a =
task has
> > events for both pmu_a and pmu_b. The perf_event_context for that task w=
ill have
> > a perf_event_pmu_context for each PMU in its pmu_ctx_list.
> >
> > Say that task is run on CPU0, and perf_event_task_tick() is called. Tha=
t will
> > call perf_adjust_freq_unthr_context(), and it will iterate over the
> > pmu_ctx_list. Note that regardless of pmu_ctx->nr_freq, if 'unthottle' =
is true,
> > we'll go ahead and call the following for all of the pmu contexts in th=
e
> > pmu_ctx_list:
> >
> >         perf_pmu_disable(pmu_ctx->pmu);
> >         perf_adjust_freq_unthr_events(&pmu_ctx->pinned_active);
> >         perf_adjust_freq_unthr_events(&pmu_ctx->flexible_active);
> >         perf_pmu_enable(pmu_ctx->pmu);
> >
> > ... and that means we might call that for pmu_b, even though it's not
> > associated with CPU0. That could be fatal depending on what those callb=
acks do.
>
> Thanks for pointing that out.  I missed the hybrid cases.
>
> >
> > The old logic avoided that possibility implicitly, since the events for=
 pmu_b
> > couldn't be active, and so the check at the start of the look would ski=
p all of
> > pmu_b's events:
> >
> >         if (event->state !=3D PERF_EVENT_STATE_ACTIVE)
> >                 continue;
> >
> > We could do similar by keeping track of how many active events each
> > perf_event_pmu_context has, which'd allow us to do something like:
> >
> >         if (pmu_ctx->nr_active =3D=3D 0)
> >                 continue;
> >
> > How does that sound to you?
>
> Sounds good.  Maybe we can just test if both active lists are empty.
>
> Thanks,
> Namhyung

