Return-Path: <linux-kernel+bounces-66305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41393855A12
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 06:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFCCD1F29AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 05:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80D89476;
	Thu, 15 Feb 2024 05:18:14 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E9C6FD2;
	Thu, 15 Feb 2024 05:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707974294; cv=none; b=Az6YA+8Dklu/4V0Q/QupoYGF3ZzEu2CZhUFE3N4oD5U5+WfvtBmUlzxOJmhlV6PrfDFnmIQpSWUqwHCexow7griLjVMdQv8RU4r3xzFzWC7BTyC1F6CngibHorNasrW1OQeXFZgR/ivtiDgmoaB44aIUe6wy2K2V110HpRxjeXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707974294; c=relaxed/simple;
	bh=/WJh5kAIqWFyfeuvuTeGcPYOTrfUAW2OKzd99jofLAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odMgeypkJbyc6o+onGt0J1SF5SX2BN6+aiQkw1ZahTNvEjO9DSRrETlemmUHRps5O8oB1Ho/lfTTEvVpF1JgqeKOu67LHDH54aQJ1ovhhdm2HF054XlKyFRzeqp4uqwneaXzMkxliEEQOp6FVrQ/8gVoPXCK1MPJX76XDFujYiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-290da27f597so389363a91.2;
        Wed, 14 Feb 2024 21:18:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707974292; x=1708579092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgJC+lfotxXhHUTdhx2QibdOlvgYKRrR8Wj7ynaZvDc=;
        b=h0hX3Pug27KtiDpCRr1Zi/R22x7ETdCzCt5woQaCSo+865oRf3HagHyYordl3ScSJJ
         cfu4rhfswCLTl1zR/IGr+QvOrC5QV8+rWPfPUBUOeHj+hmWXzKZ4wiQYEsvKpedHoswo
         4pzrDWXyzvJ1QVFZXkHih32/gmKZJ7RqXtP0tQuwL/Fy5+kewPuYgwpiFBW7x5dRS9ZJ
         K6tWyJzFBF6RdEPt2CQ/65jHJ6Ni9czzONELJ4FB3DA+YOTi4W9XQz3REs6x52gFJfso
         E9tNDK0J9ZGwgsFT2cdbC4n8Rvfij/T1gYlaFqJ/gi3KoUZ5TnNccOl094XFUnoY8JN+
         O+oQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0slmYUXBj2tmXqEJP2GM7MXx5XZvYcNfLghXrN+fiHtjS6cRQOXiGSiOWJd6H3oIfV5xESlUNtVsqnPOSGQ9d04slekEh8bkXV6dM0QdEWmGdlo+t8UFtG0lwqheZdDfJ9+6WSs5Agutd1YUX2Q==
X-Gm-Message-State: AOJu0Ywy63+AY3Gbx6sOjjTD8ZuPdH2mxEiKJqsr9IBZ8VtySifEphE2
	O23ubRghQ6q9q369+EctM0B2I4NxSEFeAOoKuWTsFYpW0mUbgIwjpfxH5T+lRi9sySr9jjOQi3r
	qNg6X3w0euCAnCl2vS3actN7Mqqw=
X-Google-Smtp-Source: AGHT+IEf/49e3VzCMhb4laTUvq8XxmlRwLmrj65hFoWNPA/PueTWJeeHsCGdyaRWkJ8zLOJxwTsMO0eb824GwCyggGg=
X-Received: by 2002:a17:90a:ca85:b0:295:eaff:78f3 with SMTP id
 y5-20020a17090aca8500b00295eaff78f3mr759769pjt.8.1707974292001; Wed, 14 Feb
 2024 21:18:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213075256.1983638-1-namhyung@kernel.org> <20240213075256.1983638-3-namhyung@kernel.org>
 <CAP-5=fWnVFabJ8MqsnAQAC5Bbk9AQmcnTCWJNrd3RGk8Ucoe-w@mail.gmail.com>
In-Reply-To: <CAP-5=fWnVFabJ8MqsnAQAC5Bbk9AQmcnTCWJNrd3RGk8Ucoe-w@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 14 Feb 2024 21:18:00 -0800
Message-ID: <CAM9d7cinDt0W73KJPaMBgWkG0oe3Kds7RC75pzqMJo+kfDkuTw@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf hist: Simplify hist printing logic for group events
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 3:57=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Feb 12, 2024 at 11:53=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> >
> > It can uses an array to save the period (or percent) values for member
> > events and print them together in a loop.  This simplify the logic to
> > handle missing samples in members with zero values.
> >
> > No functional change intended.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/ui/hist.c | 55 +++++++++++++++++---------------------------
> >  1 file changed, 21 insertions(+), 34 deletions(-)
> >
> > diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
> > index 2bf959d08354..5f4c110d840f 100644
> > --- a/tools/perf/ui/hist.c
> > +++ b/tools/perf/ui/hist.c
> > @@ -33,6 +33,7 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hi=
st_entry *he,
> >         char *buf =3D hpp->buf;
> >         size_t size =3D hpp->size;
> >
> > +       /* print stand-alone or group leader events separately */
> >         if (fmt_percent) {
> >                 double percent =3D 0.0;
> >                 u64 total =3D hists__total_period(hists);
> > @@ -45,12 +46,19 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct =
hist_entry *he,
> >                 ret =3D hpp__call_print_fn(hpp, print_fn, fmt, len, get=
_field(he));
> >
> >         if (evsel__is_group_event(evsel)) {
> > -               int prev_idx, idx_delta;
> > +               int idx;
> >                 struct hist_entry *pair;
> >                 int nr_members =3D evsel->core.nr_members;
> > +               union {
> > +                       u64 period;
> > +                       double percent;
> > +               } *val;
> >
> > -               prev_idx =3D evsel__group_idx(evsel);
> > +               val =3D calloc(nr_members, sizeof(*val));
> > +               if (val =3D=3D NULL)
> > +                       return 0;
>
> Looks good, but should this return value be negative to indicate an
> error? Snprintf gives a negative result on error, its result is
> sometimes returned from hpp__fmt_acc, as is this result.

Sounds good, will change.

Thanks,
Namhyung

>
> >
> > +               /* collect values in the group members */
> >                 list_for_each_entry(pair, &he->pairs.head, pairs.node) =
{
> >                         u64 period =3D get_field(pair);
> >                         u64 total =3D hists__total_period(pair->hists);
> > @@ -59,47 +67,26 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct =
hist_entry *he,
> >                                 continue;
> >
> >                         evsel =3D hists_to_evsel(pair->hists);
> > -                       idx_delta =3D evsel__group_idx(evsel) - prev_id=
x - 1;
> > -
> > -                       while (idx_delta--) {
> > -                               /*
> > -                                * zero-fill group members in the middl=
e which
> > -                                * have no sample
> > -                                */
> > -                               if (fmt_percent) {
> > -                                       ret +=3D hpp__call_print_fn(hpp=
, print_fn,
> > -                                                                 fmt, =
len, 0.0);
> > -                               } else {
> > -                                       ret +=3D hpp__call_print_fn(hpp=
, print_fn,
> > -                                                                 fmt, =
len, 0ULL);
> > -                               }
> > -                       }
> > -
> > -                       if (fmt_percent) {
> > -                               ret +=3D hpp__call_print_fn(hpp, print_=
fn, fmt, len,
> > -                                                         100.0 * perio=
d / total);
> > -                       } else {
> > -                               ret +=3D hpp__call_print_fn(hpp, print_=
fn, fmt,
> > -                                                         len, period);
> > -                       }
> > +                       idx =3D evsel__group_idx(evsel);
> >
> > -                       prev_idx =3D evsel__group_idx(evsel);
> > +                       if (fmt_percent)
> > +                               val[idx].percent =3D 100.0 * period / t=
otal;
> > +                       else
> > +                               val[idx].period =3D period;
> >                 }
> >
> > -               idx_delta =3D nr_members - prev_idx - 1;
> > -
> > -               while (idx_delta--) {
> > -                       /*
> > -                        * zero-fill group members at last which have n=
o sample
> > -                        */
> > +               /* idx starts from 1 to skip the leader event */
> > +               for (idx =3D 1; idx < nr_members; idx++) {
> >                         if (fmt_percent) {
> >                                 ret +=3D hpp__call_print_fn(hpp, print_=
fn,
> > -                                                         fmt, len, 0.0=
);
> > +                                                         fmt, len, val=
[idx].percent);
> >                         } else {
> >                                 ret +=3D hpp__call_print_fn(hpp, print_=
fn,
> > -                                                         fmt, len, 0UL=
L);
> > +                                                         fmt, len, val=
[idx].period);
> >                         }
> >                 }
> > +
> > +               free(val);
> >         }
> >
> >         /*
> > --
> > 2.43.0.687.g38aa6559b0-goog
> >

