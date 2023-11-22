Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885357F4DA1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjKVQ74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjKVQ7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:59:54 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8801B8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:59:46 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-50aba9b8955so3981e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700672384; x=1701277184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2ZTg1sahQKBI/4w3s7AGEAAD0RXpuVE+lN1wQkXOvg=;
        b=PMxbLruxU9KyLYEBwOFoMcMkY8wwZSmAXsGycjsRxdPh4FzHPTbegXylzv4PsqOfzI
         13mgNiWMbONGmQbXV9s+v3rvHNwldZNMB5fU27B2025gOknXZcZAGATstPMJzyjftDFI
         YP2MjKKsbAzr+ImpyxdICGpx18EdQWotzOeh1OmWlGqAJ+jAR5eOtcjg/qEi0ciYq7f+
         FpraJNPNGoDuqFrSZsAgGCWXJy5wm8UHosjTlL3JacN8YDv/4369t7quXR2gTTErNIQo
         KOKK15Y0SDgwcysFcnFHzmSR69w/HNduadXimZVKJJBwIUWa2Q+CtdJEpm9tqsiSG1IC
         47yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700672384; x=1701277184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2ZTg1sahQKBI/4w3s7AGEAAD0RXpuVE+lN1wQkXOvg=;
        b=fd/cpgYX+8rV0vKQOwJo+j7gopNlFlBCuFTxHBawYu7i0xreOx1urBxa35CmB4C4sC
         /seqkuS8HXPDkGuvaTUtnJkUA88pXv0fspXoz414rtl7FHUYxZMh4lTLyELAZBr4IOhw
         CwFaXYpNOOVe98GXgyrP6AUMM24ytme6zEhcHXZxQA6VhGEXr0o6iWX5ZjNYCSY8Z9mP
         I6BRGe4jFiWrxjaTlMPVri/ZHJrg2o9kyHdu96JxvMJ0O4Aq35rLV+y7CRxbVTUg7lA0
         Em52mJyOog1o2WTpt53/HWgZPZ0RzpveysN3zrM8W9aJopMi8VxtQVzbnsBDnmplzW5F
         FWrQ==
X-Gm-Message-State: AOJu0YxRvmaesZwsMSY2KidAonoadZtzVgB0Ez5hX/KpltBe8W5etyQ3
        +eIzB7G9zKv/qQk1dI97NKFmT8DbMsdVIxdKrPqOjQ==
X-Google-Smtp-Source: AGHT+IEP4gTL5VUr/6Iw3lypRE1j4fSWCUZowchISdtiNaQXyLKjo1tBNIsT/hc+A6/JRU2bL9fe9LzJlVqMfDtGZ0k=
X-Received: by 2002:a05:6512:1585:b0:50a:519d:5a8a with SMTP id
 bp5-20020a056512158500b0050a519d5a8amr80736lfb.5.1700672384173; Wed, 22 Nov
 2023 08:59:44 -0800 (PST)
MIME-Version: 1.0
References: <ZVzPUjOiH6zpUlz5@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fUB75DCL4+8YO62iPVsnxoeXGv5cLmT7eP2bHNs=xoMdg@mail.gmail.com>
 <ZVzUr7TWEYPoZrWX@FVFF77S0Q05N.cambridge.arm.com> <CAP-5=fUWm7efu3xdUBbiifs_KNU1igwAxbXmum=V38SjHQHtXg@mail.gmail.com>
 <ZVzXjz_0nYbmSGPQ@FVFF77S0Q05N.cambridge.arm.com> <CAP-5=fWLGOCWv=wp2xsi4AVxfbS8KhkmtkMwOA4yVrz791=Z8Q@mail.gmail.com>
 <ZV38ParIEYWOjt6T@FVFF77S0Q05N> <CAP-5=fUxBv4kbXyLrD5G-=wyRh6tKEJMy5qX0_86wQXxT79dJw@mail.gmail.com>
 <ZV4nj-_q4hHaf8Wl@FVFF77S0Q05N> <CAP-5=fWtHYr9J2izkNmTpfKvdEdt0ViELJ1Gsih6H9XBTE83UA@mail.gmail.com>
 <ZV4yd3oz2Ykl/N5Q@kernel.org>
In-Reply-To: <ZV4yd3oz2Ykl/N5Q@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 22 Nov 2023 08:59:32 -0800
Message-ID: <CAP-5=fU==+UoF64AZz5HAwcL2xSDxLfyS1Q+SQ0d2SGwFC8j5A@mail.gmail.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 8:55=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Nov 22, 2023 at 08:29:58AM -0800, Ian Rogers escreveu:
> > I can look at doing an event parser change like:
> >
> > ```
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index aa2f5c6fc7fc..9a18fda525d2 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -986,7 +986,8 @@ static int config_term_pmu(struct perf_event_attr *=
attr,
> >                                                           err_str,
> > /*help=3D*/NULL);
> >                        return -EINVAL;
> >                }
> > -               if (perf_pmu__supports_legacy_cache(pmu)) {
> > +               if (perf_pmu__supports_legacy_cache(pmu) &&
> > +                   !perf_pmu__have_event(pmu, term->val.str)) {
> >                        attr->type =3D PERF_TYPE_HW_CACHE;
> >                        return
> > parse_events__decode_legacy_cache(term->config, pmu->type,
> >                                                                 &attr->=
config);
> > @@ -1004,10 +1005,15 @@ static int config_term_pmu(struct perf_event_at=
tr *attr,
> >                                                           err_str,
> > /*help=3D*/NULL);
> >                        return -EINVAL;
> >                }
> > -               attr->type =3D PERF_TYPE_HARDWARE;
> > -               attr->config =3D term->val.num;
> > -               if (perf_pmus__supports_extended_type())
> > -                       attr->config |=3D (__u64)pmu->type << PERF_PMU_=
TYPE_SHIFT;
> > +               if (perf_pmu__have_event(pmu, term->val.str)) {
> > +                       /* If the PMU has a sysfs or json event prefer
> > it over legacy. ARM requires this. */
> > +                       term->term_type =3D PARSE_EVENTS__TERM_TYPE_USE=
R;
> > +               } else {
> > +                       attr->type =3D PERF_TYPE_HARDWARE;
> > +                       attr->config =3D term->val.num;
> > +                       if (perf_pmus__supports_extended_type())
> > +                               attr->config |=3D (__u64)pmu->type <<
> > PERF_PMU_TYPE_SHIFT;
> > +               }
> >                return 0;
> >        }
> >        if (term->type_term =3D=3D PARSE_EVENTS__TERM_TYPE_USER ||
> > ```
> > (note: this is incomplete as term->val.str isn't populated for
> > PARSE_EVENTS__TERM_TYPE_HARDWARE)
>
> Yeah, I had to apply manually as your MUA mangled it, then it didn't
> build, had to remove some consts, then there was a struct member
> mistake, after all fixed I get to the patch below, but it now segfaults,
> probably what you mention...
>
> root@roc-rk3399-pc:~# strace -e perf_event_open taskset -c 4,5 perf stat =
-v -e cycles,armv8_cortex_a53/cycles/,armv8_cortex_a72/cycles/ echo
> Using CPUID 0x00000000410fd082
> perf_event_open({type=3DPERF_TYPE_HARDWARE, size=3D0 /* PERF_ATTR_SIZE_??=
? */, config=3D0x7<<32|PERF_COUNT_HW_CPU_CYCLES, sample_period=3D0, sample_=
type=3D0, read_format=3D0, disabled=3D1, precise_ip=3D0 /* arbitrary skid *=
/, ...}, 0, -1, -1, PERF_FLAG_FD_CLOEXEC) =3D -1 ENOENT (No such file or di=
rectory)
> --- SIGSEGV {si_signo=3DSIGSEGV, si_code=3DSEGV_MAPERR, si_addr=3DNULL} -=
--
> +++ killed by SIGSEGV +++
> Segmentation fault
> root@roc-rk3399-pc:~#

Right, I have something further along that fails tests. I'll try to
send out an RFC today, but given the Intel behavior change =C2=AF\_(=E3=83=
=84)_/=C2=AF
But Intel don't appear to have an issue having two things called, for
example, cycles and them both being a cycles event so they may not
care. It is only ARM's PMUs that appear broken in this way.

Thanks,
Ian

> - Arnaldo
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index aa2f5c6fc7fc..1e648454cc49 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -976,7 +976,7 @@ static int config_term_pmu(struct perf_event_attr *at=
tr,
>                            struct parse_events_error *err)
>  {
>         if (term->type_term =3D=3D PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE) =
{
> -               const struct perf_pmu *pmu =3D perf_pmus__find_by_type(at=
tr->type);
> +               struct perf_pmu *pmu =3D perf_pmus__find_by_type(attr->ty=
pe);
>
>                 if (!pmu) {
>                         char *err_str;
> @@ -986,7 +986,8 @@ static int config_term_pmu(struct perf_event_attr *at=
tr,
>                                                            err_str, /*hel=
p=3D*/NULL);
>                         return -EINVAL;
>                 }
> -               if (perf_pmu__supports_legacy_cache(pmu)) {
> +               if (perf_pmu__supports_legacy_cache(pmu) &&
> +                   !perf_pmu__have_event(pmu, term->val.str)) {
>                         attr->type =3D PERF_TYPE_HW_CACHE;
>                         return parse_events__decode_legacy_cache(term->co=
nfig, pmu->type,
>                                                                  &attr->c=
onfig);
> @@ -994,7 +995,7 @@ static int config_term_pmu(struct perf_event_attr *at=
tr,
>                         term->type_term =3D PARSE_EVENTS__TERM_TYPE_USER;
>         }
>         if (term->type_term =3D=3D PARSE_EVENTS__TERM_TYPE_HARDWARE) {
> -               const struct perf_pmu *pmu =3D perf_pmus__find_by_type(at=
tr->type);
> +               struct perf_pmu *pmu =3D perf_pmus__find_by_type(attr->ty=
pe);
>
>                 if (!pmu) {
>                         char *err_str;
> @@ -1004,10 +1005,15 @@ static int config_term_pmu(struct perf_event_attr=
 *attr,
>                                                            err_str, /*hel=
p=3D*/NULL);
>                         return -EINVAL;
>                 }
> -               attr->type =3D PERF_TYPE_HARDWARE;
> -               attr->config =3D term->val.num;
> -               if (perf_pmus__supports_extended_type())
> -                       attr->config |=3D (__u64)pmu->type << PERF_PMU_TY=
PE_SHIFT;
> +               if (perf_pmu__have_event(pmu, term->val.str)) {
> +                       /* If the PMU has a sysfs or JSON event prefer it=
 over legacy. ARM requires this. */
> +                       term->type_term =3D PARSE_EVENTS__TERM_TYPE_USER;
> +               } else {
> +                       attr->type =3D PERF_TYPE_HARDWARE;
> +                       attr->config =3D term->val.num;
> +                       if (perf_pmus__supports_extended_type())
> +                           attr->config |=3D (__u64)pmu->type << PERF_PM=
U_TYPE_SHIFT;
> +               }
>                 return 0;
>         }
>         if (term->type_term =3D=3D PARSE_EVENTS__TERM_TYPE_USER ||
