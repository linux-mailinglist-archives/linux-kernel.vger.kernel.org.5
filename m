Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E277D80F7E6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 21:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377347AbjLLU1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 15:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjLLU1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 15:27:21 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702ECD5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:27:25 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50bf1de91c6so770e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 12:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702412843; x=1703017643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1r0l9UDH82X/QRijiq/v0dYWas+IVhPxoge2Q6dptEs=;
        b=XeI+ATa+LdAkHqn1BjFTeJsitxU1zxpjBgkEu8WDKbZNjPhNQtcp57vQoaVKy0kVg8
         EkFa9fjlHwGU3mvHzRftpGIcAG1ucOaUu6a3rukDYzYIQzBotRmViaGf5Dh2UmLcxSKZ
         HS38soueUWtlavoqmdkkl+Zm1h8x7D5LwKO5GCgp18xmtIBK7BtJxvYb0oxLzkLYQNXb
         ZdpeUxBGOA2uS6BrvctKMJKTMR9RVgx5qGmoZ/cN/9yEc3RjxC4KCSqyF2E6Q6z7tmKT
         ntSzFy0YlgAvbTSZ9SYl8Qqf5cyC1AzJGURXdWDOPnA0JP6FywFNJ4JWkdJ7MQtUU9LH
         dncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702412843; x=1703017643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1r0l9UDH82X/QRijiq/v0dYWas+IVhPxoge2Q6dptEs=;
        b=ihTKTblzU/kEzsL7Gq9h989IsdaVZD3MyacyJ1a6E7s3Bp749fv+dxLkj5sB6LypoR
         7J7AO5a82GBu1CTHAyJXkx+Uwo7zrjOXH8y8ZWSWs7IVOKj8Mh4F/XqTuAyBY2EX/rKR
         zbOZPimYep/b7Y9muXjGBzqj6POdgNfotzHIgGQ7xEezhsI75SXvciTsRl0ExBzM0Lbw
         tGkmp8KBOuYTjHkLvCKf1xb6fQrsMsjPH/cjrOFvWnuYqC9zcvTQfm4ZN2dCZl7TYeIs
         BMm4fSHyRS4M5xaR0/gA5J1vCMjx42RTFbGsbQnMNrDjO6f3+4/X8tXKjlQjbd0QU2zb
         EKtQ==
X-Gm-Message-State: AOJu0YxMHC3oPPqldlTaV5tS2JldKgiyQ23SCrLsoSOsjsk/t6inFAMR
        uIZFC+KbfMz6y8Dx42Jpc6RUDsqAuiOuajl66F7DuA==
X-Google-Smtp-Source: AGHT+IFoY3ALLkdAR2gE36RzhwyUHqDnvxbMLYh3kdlzIKhmBLpUUVJzQp4hNvBUkf9+POe7DeKZkWl1v5OD3OMGjW0=
X-Received: by 2002:a19:4f07:0:b0:50b:fcb7:15af with SMTP id
 d7-20020a194f07000000b0050bfcb715afmr233274lfb.3.1702412843308; Tue, 12 Dec
 2023 12:27:23 -0800 (PST)
MIME-Version: 1.0
References: <20231129060211.1890454-1-irogers@google.com> <20231129060211.1890454-7-irogers@google.com>
 <94e3745c-8c2b-bdf3-f331-1cbe56574d48@arm.com>
In-Reply-To: <94e3745c-8c2b-bdf3-f331-1cbe56574d48@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 12 Dec 2023 12:27:11 -0800
Message-ID: <CAP-5=fUWtgNMGWowN2+qnV5FV3viHd=kPqiwXUeEtkQAzabLGw@mail.gmail.com>
Subject: Re: [PATCH v1 06/14] libperf cpumap: Add any, empty and min helpers
To:     James Clark <james.clark@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Changbin Du <changbin.du@huawei.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Paran Lee <p4ranlee@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 7:06=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
>
>
> On 29/11/2023 06:02, Ian Rogers wrote:
> > Additional helpers to better replace
> > perf_cpu_map__has_any_cpu_or_is_empty.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/perf/cpumap.c              | 27 +++++++++++++++++++++++++++
> >  tools/lib/perf/include/perf/cpumap.h | 16 ++++++++++++++++
> >  tools/lib/perf/libperf.map           |  4 ++++
> >  3 files changed, 47 insertions(+)
> >
> > diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> > index 49fc98e16514..7403819da8fd 100644
> > --- a/tools/lib/perf/cpumap.c
> > +++ b/tools/lib/perf/cpumap.c
> > @@ -316,6 +316,19 @@ bool perf_cpu_map__has_any_cpu_or_is_empty(const s=
truct perf_cpu_map *map)
> >       return map ? __perf_cpu_map__cpu(map, 0).cpu =3D=3D -1 : true;
> >  }
> >
> > +bool perf_cpu_map__is_any_cpu_or_is_empty(const struct perf_cpu_map *m=
ap)
> > +{
> > +     if (!map)
> > +             return true;
> > +
> > +     return __perf_cpu_map__nr(map) =3D=3D 1 && __perf_cpu_map__cpu(ma=
p, 0).cpu =3D=3D -1;
> > +}
>
> I'm struggling to understand the relevance of the difference between
> has_any and is_any I see that there is a slight difference, but could it
> not be refactored out so we only need one?

Yep, that's what these changes are working toward. For has any the set
{-1, 0, 1} would return true while is any will return false.
Previously the has any behavior was called "empty" which I think is
actively misleading.

> Do you ever get an 'any' map that has more than 1 entry? It's quite a
> subtle difference that is_any returns false if the first one is 'any'
> but then there are subsequent entries. Whereas has_any would return
> true. I'm not sure if future readers would be able to appreciate that.
>
> I see has_any is only used twice, both on evlist->all_cpus. Is there
> something about that member that means it could have a map that has an
> 'any' mixed with CPUs? Wouldn't that have the same result as a normal
> 'any' anyway?

The dummy event may be opened on any CPU but then a particular event
may be opened on certain CPUs. We merge CPU maps in places like evlist
so that we can iterate the appropriate CPUs for events and
open/enable/disable/close all events on a certain CPU at the same time
(we also set the affinity to that CPU to avoid IPIs). What I'm hoping
to do in these changes is reduce the ambiguity, the corner cases are
by their nature unusual.

An example of a corner case is, uncore events often get opened just on
CPU 0 but on a multi-socket system you may have a CPU 32 that also
needs to open the event. Previous code treated the CPU map index and
value it contained pretty interchangeably. This is often fine for the
core PMU but is clearly wrong in this uncore case, {0, 32} has indexes
0 and 1 but those indexes don't match the CPU numbers. The case of -1
has often previously been called dummy but I'm trying to call it the
"any CPU" case to match the perf_event_open man page (I'm hoping it
also makes it less ambiguous with any CPU being used with a particular
event like cycles, calling it dummy makes the event sound like it may
have sideband data). The difference between "all CPUs" and "any CPU"
is that an evsel for all CPUs would need the event opening
individually on each CPU, while any CPU events are a single open call.
Any CPU is only valid to perf_event_open if a PID is specified.
Depending on the set up there could be overlaps in what they count but
hopefully it is clearer what the distinction is. I believe the case of
"any CPU" and specific CPU numbers is more common with aux buffers and
Adrian has mentioned needing it for intel-pt.

Thanks,
Ian

> > +
> > +bool perf_cpu_map__is_empty(const struct perf_cpu_map *map)
> > +{
> > +     return map =3D=3D NULL;
> > +}
> > +
> >  int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu=
 cpu)
> >  {
> >       int low, high;
> > @@ -372,6 +385,20 @@ bool perf_cpu_map__has_any_cpu(const struct perf_c=
pu_map *map)
> >       return map && __perf_cpu_map__cpu(map, 0).cpu =3D=3D -1;
> >  }
> >
> > +struct perf_cpu perf_cpu_map__min(const struct perf_cpu_map *map)
> > +{
> > +     struct perf_cpu cpu, result =3D {
> > +             .cpu =3D -1
> > +     };
> > +     int idx;
> > +
> > +     perf_cpu_map__for_each_cpu_skip_any(cpu, idx, map) {
> > +             result =3D cpu;
> > +             break;
> > +     }
> > +     return result;
> > +}
> > +
> >  struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map)
> >  {
> >       struct perf_cpu result =3D {
> > diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/incl=
ude/perf/cpumap.h
> > index dbe0a7352b64..523e4348fc96 100644
> > --- a/tools/lib/perf/include/perf/cpumap.h
> > +++ b/tools/lib/perf/include/perf/cpumap.h
> > @@ -50,6 +50,22 @@ LIBPERF_API int perf_cpu_map__nr(const struct perf_c=
pu_map *cpus);
> >   * perf_cpu_map__has_any_cpu_or_is_empty - is map either empty or has =
the "any CPU"/dummy value.
> >   */
> >  LIBPERF_API bool perf_cpu_map__has_any_cpu_or_is_empty(const struct pe=
rf_cpu_map *map);
> > +/**
> > + * perf_cpu_map__is_any_cpu_or_is_empty - is map either empty or the "=
any CPU"/dummy value.
> > + */
> > +LIBPERF_API bool perf_cpu_map__is_any_cpu_or_is_empty(const struct per=
f_cpu_map *map);
> > +/**
> > + * perf_cpu_map__is_empty - does the map contain no values and it does=
n't
> > + *                          contain the special "any CPU"/dummy value.
> > + */
> > +LIBPERF_API bool perf_cpu_map__is_empty(const struct perf_cpu_map *map=
);
> > +/**
> > + * perf_cpu_map__min - the minimum CPU value or -1 if empty or just th=
e "any CPU"/dummy value.
> > + */
> > +LIBPERF_API struct perf_cpu perf_cpu_map__min(const struct perf_cpu_ma=
p *map);
> > +/**
> > + * perf_cpu_map__max - the maximum CPU value or -1 if empty or just th=
e "any CPU"/dummy value.
> > + */
> >  LIBPERF_API struct perf_cpu perf_cpu_map__max(const struct perf_cpu_ma=
p *map);
> >  LIBPERF_API bool perf_cpu_map__has(const struct perf_cpu_map *map, str=
uct perf_cpu cpu);
> >  LIBPERF_API bool perf_cpu_map__equal(const struct perf_cpu_map *lhs,
> > diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> > index 10b3f3722642..2aa79b696032 100644
> > --- a/tools/lib/perf/libperf.map
> > +++ b/tools/lib/perf/libperf.map
> > @@ -10,6 +10,10 @@ LIBPERF_0.0.1 {
> >               perf_cpu_map__nr;
> >               perf_cpu_map__cpu;
> >               perf_cpu_map__has_any_cpu_or_is_empty;
> > +             perf_cpu_map__is_any_cpu_or_is_empty;
> > +             perf_cpu_map__is_empty;
> > +             perf_cpu_map__has_any_cpu;
> > +             perf_cpu_map__min;
> >               perf_cpu_map__max;
> >               perf_cpu_map__has;
> >               perf_thread_map__new_array;
