Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7783C7F576B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 05:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344624AbjKWEdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 23:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKWEdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 23:33:11 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2011A4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 20:33:17 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so6710a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 20:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700713996; x=1701318796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHYFGmfIL28khD5t+/nzZLl2KHtCKuHF6ms78F8Fe70=;
        b=bjbDcBqiAdkd/f6YuNyg7kWJfGA+HBbnYK6Jz2PUooPz+hwv/1hCutqTEdmPyB4qvl
         /9UC/jmIYz0c7hvL6n+xctqhDLENzkMx6wApJyyhJkCtdJ4XpHpXBdw6Vp63yclggK85
         fAkKkddz4P4zsUd/QrvciVtsL8vz40MfvElYtl2AXRKQ3jCjP0nusyHYIzcJpDILZc+x
         dgrFA7VQHj4LnYql1tco1qHnXmFwABVHk2tC2bwKq1C7T82WdLww8YFU2bi2GG8F3lYy
         z+Ql2Ji2ZvFi6YaNhVcPLt+sbqCYjoc7E38Qo079BXccttZyRvAaY9xfqLCReqIReTRx
         d8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700713996; x=1701318796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHYFGmfIL28khD5t+/nzZLl2KHtCKuHF6ms78F8Fe70=;
        b=CuZ+Z9DWuKooQYZm8EAs84AAjR1F4vYKIVTBvSFiV2Dq6nHsIX6TPgSHPM6GxSUmSr
         D5FEzCJ95HkNPtLvnMbpFydYUTgGTm61KJ6VgJdLkOf97q4Ics1UJDkSIMKBuIv6tltA
         kzjELl9qn/wItisKrcqvL80f04KQ91uxCskGM/sHfN4FuebzOlXWa8vCVaHSqFQiL1kh
         ovEqZjncrEE6eB09htpbsBU5al1XlGRur2GmoQnFoHA7ECFFkf1kJgnq4NI4UQeScK3R
         UxiXdSSk0tQIIjwuB44DGWh7oy3FZnVfOg6lxUcKHsScWB6vMZY2SG7P7ysac7ah0n1L
         mktQ==
X-Gm-Message-State: AOJu0Yxtf21yQYzAHkvGwvRhmJWtMGKnADgt1c6a10twi57UpbAlEO5d
        9f9kgX83U4ZqXyvUnZnmSlforABFkp0D/Up/1IrV2g==
X-Google-Smtp-Source: AGHT+IHs5+fqXcXd6ogn/DfeaeTkDYlrlCqReCllXHbGsBBw6ajb2Kavkb8kz1MLsS7u9oYhFeF+v3hNOungmV1z2Y0=
X-Received: by 2002:a05:6402:1cbc:b0:547:3f1:84e0 with SMTP id
 cz28-20020a0564021cbc00b0054703f184e0mr211893edb.7.1700713995667; Wed, 22 Nov
 2023 20:33:15 -0800 (PST)
MIME-Version: 1.0
References: <ZVzPUjOiH6zpUlz5@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fUB75DCL4+8YO62iPVsnxoeXGv5cLmT7eP2bHNs=xoMdg@mail.gmail.com>
 <ZVzUr7TWEYPoZrWX@FVFF77S0Q05N.cambridge.arm.com> <CAP-5=fUWm7efu3xdUBbiifs_KNU1igwAxbXmum=V38SjHQHtXg@mail.gmail.com>
 <ZVzXjz_0nYbmSGPQ@FVFF77S0Q05N.cambridge.arm.com> <CAP-5=fWLGOCWv=wp2xsi4AVxfbS8KhkmtkMwOA4yVrz791=Z8Q@mail.gmail.com>
 <ZV38ParIEYWOjt6T@FVFF77S0Q05N> <CAP-5=fUxBv4kbXyLrD5G-=wyRh6tKEJMy5qX0_86wQXxT79dJw@mail.gmail.com>
 <ZV4nj-_q4hHaf8Wl@FVFF77S0Q05N> <CAP-5=fWtHYr9J2izkNmTpfKvdEdt0ViELJ1Gsih6H9XBTE83UA@mail.gmail.com>
 <ZV4yd3oz2Ykl/N5Q@kernel.org> <CAP-5=fU==+UoF64AZz5HAwcL2xSDxLfyS1Q+SQ0d2SGwFC8j5A@mail.gmail.com>
In-Reply-To: <CAP-5=fU==+UoF64AZz5HAwcL2xSDxLfyS1Q+SQ0d2SGwFC8j5A@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 22 Nov 2023 20:33:03 -0800
Message-ID: <CAP-5=fVE-GayAsg0PVf+WZuLh_KJAd2ErG2qvNROjhQOLYp=4w@mail.gmail.com>
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since v6.5
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Asahi Linux <asahi@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 8:59=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Nov 22, 2023 at 8:55=E2=80=AFAM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Wed, Nov 22, 2023 at 08:29:58AM -0800, Ian Rogers escreveu:
> > > I can look at doing an event parser change like:
> > >
> > > ```
> > > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-e=
vents.c
> > > index aa2f5c6fc7fc..9a18fda525d2 100644
> > > --- a/tools/perf/util/parse-events.c
> > > +++ b/tools/perf/util/parse-events.c
> > > @@ -986,7 +986,8 @@ static int config_term_pmu(struct perf_event_attr=
 *attr,
> > >                                                           err_str,
> > > /*help=3D*/NULL);
> > >                        return -EINVAL;
> > >                }
> > > -               if (perf_pmu__supports_legacy_cache(pmu)) {
> > > +               if (perf_pmu__supports_legacy_cache(pmu) &&
> > > +                   !perf_pmu__have_event(pmu, term->val.str)) {
> > >                        attr->type =3D PERF_TYPE_HW_CACHE;
> > >                        return
> > > parse_events__decode_legacy_cache(term->config, pmu->type,
> > >                                                                 &attr=
->config);
> > > @@ -1004,10 +1005,15 @@ static int config_term_pmu(struct perf_event_=
attr *attr,
> > >                                                           err_str,
> > > /*help=3D*/NULL);
> > >                        return -EINVAL;
> > >                }
> > > -               attr->type =3D PERF_TYPE_HARDWARE;
> > > -               attr->config =3D term->val.num;
> > > -               if (perf_pmus__supports_extended_type())
> > > -                       attr->config |=3D (__u64)pmu->type << PERF_PM=
U_TYPE_SHIFT;
> > > +               if (perf_pmu__have_event(pmu, term->val.str)) {
> > > +                       /* If the PMU has a sysfs or json event prefe=
r
> > > it over legacy. ARM requires this. */
> > > +                       term->term_type =3D PARSE_EVENTS__TERM_TYPE_U=
SER;
> > > +               } else {
> > > +                       attr->type =3D PERF_TYPE_HARDWARE;
> > > +                       attr->config =3D term->val.num;
> > > +                       if (perf_pmus__supports_extended_type())
> > > +                               attr->config |=3D (__u64)pmu->type <<
> > > PERF_PMU_TYPE_SHIFT;
> > > +               }
> > >                return 0;
> > >        }
> > >        if (term->type_term =3D=3D PARSE_EVENTS__TERM_TYPE_USER ||
> > > ```
> > > (note: this is incomplete as term->val.str isn't populated for
> > > PARSE_EVENTS__TERM_TYPE_HARDWARE)
> >
> > Yeah, I had to apply manually as your MUA mangled it, then it didn't
> > build, had to remove some consts, then there was a struct member
> > mistake, after all fixed I get to the patch below, but it now segfaults=
,
> > probably what you mention...
> >
> > root@roc-rk3399-pc:~# strace -e perf_event_open taskset -c 4,5 perf sta=
t -v -e cycles,armv8_cortex_a53/cycles/,armv8_cortex_a72/cycles/ echo
> > Using CPUID 0x00000000410fd082
> > perf_event_open({type=3DPERF_TYPE_HARDWARE, size=3D0 /* PERF_ATTR_SIZE_=
??? */, config=3D0x7<<32|PERF_COUNT_HW_CPU_CYCLES, sample_period=3D0, sampl=
e_type=3D0, read_format=3D0, disabled=3D1, precise_ip=3D0 /* arbitrary skid=
 */, ...}, 0, -1, -1, PERF_FLAG_FD_CLOEXEC) =3D -1 ENOENT (No such file or =
directory)
> > --- SIGSEGV {si_signo=3DSIGSEGV, si_code=3DSEGV_MAPERR, si_addr=3DNULL}=
 ---
> > +++ killed by SIGSEGV +++
> > Segmentation fault
> > root@roc-rk3399-pc:~#
>
> Right, I have something further along that fails tests. I'll try to
> send out an RFC today, but given the Intel behavior change =C2=AF\_(=E3=
=83=84)_/=C2=AF
> But Intel don't appear to have an issue having two things called, for
> example, cycles and them both being a cycles event so they may not
> care. It is only ARM's PMUs that appear broken in this way.

To workaround the PMU bug posted:
https://lore.kernel.org/lkml/20231123042922.834425-1-irogers@google.com/

Thanks,
Ian

> Thanks,
> Ian
>
> > - Arnaldo
> >
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index aa2f5c6fc7fc..1e648454cc49 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -976,7 +976,7 @@ static int config_term_pmu(struct perf_event_attr *=
attr,
> >                            struct parse_events_error *err)
> >  {
> >         if (term->type_term =3D=3D PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE=
) {
> > -               const struct perf_pmu *pmu =3D perf_pmus__find_by_type(=
attr->type);
> > +               struct perf_pmu *pmu =3D perf_pmus__find_by_type(attr->=
type);
> >
> >                 if (!pmu) {
> >                         char *err_str;
> > @@ -986,7 +986,8 @@ static int config_term_pmu(struct perf_event_attr *=
attr,
> >                                                            err_str, /*h=
elp=3D*/NULL);
> >                         return -EINVAL;
> >                 }
> > -               if (perf_pmu__supports_legacy_cache(pmu)) {
> > +               if (perf_pmu__supports_legacy_cache(pmu) &&
> > +                   !perf_pmu__have_event(pmu, term->val.str)) {
> >                         attr->type =3D PERF_TYPE_HW_CACHE;
> >                         return parse_events__decode_legacy_cache(term->=
config, pmu->type,
> >                                                                  &attr-=
>config);
> > @@ -994,7 +995,7 @@ static int config_term_pmu(struct perf_event_attr *=
attr,
> >                         term->type_term =3D PARSE_EVENTS__TERM_TYPE_USE=
R;
> >         }
> >         if (term->type_term =3D=3D PARSE_EVENTS__TERM_TYPE_HARDWARE) {
> > -               const struct perf_pmu *pmu =3D perf_pmus__find_by_type(=
attr->type);
> > +               struct perf_pmu *pmu =3D perf_pmus__find_by_type(attr->=
type);
> >
> >                 if (!pmu) {
> >                         char *err_str;
> > @@ -1004,10 +1005,15 @@ static int config_term_pmu(struct perf_event_at=
tr *attr,
> >                                                            err_str, /*h=
elp=3D*/NULL);
> >                         return -EINVAL;
> >                 }
> > -               attr->type =3D PERF_TYPE_HARDWARE;
> > -               attr->config =3D term->val.num;
> > -               if (perf_pmus__supports_extended_type())
> > -                       attr->config |=3D (__u64)pmu->type << PERF_PMU_=
TYPE_SHIFT;
> > +               if (perf_pmu__have_event(pmu, term->val.str)) {
> > +                       /* If the PMU has a sysfs or JSON event prefer =
it over legacy. ARM requires this. */
> > +                       term->type_term =3D PARSE_EVENTS__TERM_TYPE_USE=
R;
> > +               } else {
> > +                       attr->type =3D PERF_TYPE_HARDWARE;
> > +                       attr->config =3D term->val.num;
> > +                       if (perf_pmus__supports_extended_type())
> > +                           attr->config |=3D (__u64)pmu->type << PERF_=
PMU_TYPE_SHIFT;
> > +               }
> >                 return 0;
> >         }
> >         if (term->type_term =3D=3D PARSE_EVENTS__TERM_TYPE_USER ||
