Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D305C80F4F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377021AbjLLRxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjLLRxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:53:05 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD81A1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:53:09 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50d11bd3144so129e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702403587; x=1703008387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIFNo9JYm5ATZ9JsBFU9kjn2eRZxaOwVy/sxFVnOmwo=;
        b=DqQTzV42MyHdbPANPZyF91OgIeflZe9/X46PIeFf/CifV5pXnXLTzX6xnrgcJMo6F6
         cMJzVkP/vRnvAWUoIsTktLvqvjtfFbw2bOl6rjlqS3XMAxTFOshNns7HmQji5BUhAsCi
         PVgZf+6YkqTougTOvK6AiW9anqibzfFdp06DrIAPM120QnT+6PkYno4W4fsO4T4KonPM
         cIKKDYzCQVf8LLVq684gxw8xDKktly2psTd5blIDvQxdHm3p7bN+Av4Yl6aEvjwa9PYE
         IX59OOzLxmvqn2N352MDbWN9uV81Nn/XmNikeRnhBDxU/KWQp2ENG78EEK7Y8o49sTxR
         I3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702403587; x=1703008387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIFNo9JYm5ATZ9JsBFU9kjn2eRZxaOwVy/sxFVnOmwo=;
        b=KqizmoME27O3Gh7QszSW8nWek/T9YPbrNbFLuQCZ2pSkkcoICF+MPDokPuPC7iBnyz
         N4dgzmc9Gj++le7rebbK5sVstpZsijb+C41uo64DXNfYac+2+H6FV7xXNPpTKvQdkCog
         50bqQVvCr7AxsKFr5rORrrawaYL+nh7tLJlZYx0LDTMUmVUWKyY5nf+SQKEkslFR/Jnz
         u/GsuAXOqmrkjOenMFQY3riSqZe7S5AH4yOc2pbTgXOiFJvmmSyWPw8MngCpHGQC6jD5
         aEEC23BwsxBrMvBmp5eNPcTHFLXs1kaq26JiEi53Zm4sTvAVhMtpFA2s/6mpPBw550Nz
         rujg==
X-Gm-Message-State: AOJu0YxVk3m0nyXO8Ky7dZ5pXlBV7DFpQDF/6wnOmQBqZ5dLRHxInBUx
        TyL+p9HmAXbR05T5vFRTnzqCz4HLQmY+LKyic6uBtQ==
X-Google-Smtp-Source: AGHT+IEf7VQccaZdvuVrhQlDO1GMzkurXaX9ybjG5vuKiPD2QruYwKP2g5lmqSLcHwJZI3js0y+LLbFb/3+RH7vWSKc=
X-Received: by 2002:a05:6512:539:b0:50c:e19:b658 with SMTP id
 o25-20020a056512053900b0050c0e19b658mr265643lfc.1.1702403586994; Tue, 12 Dec
 2023 09:53:06 -0800 (PST)
MIME-Version: 1.0
References: <20231129060211.1890454-1-irogers@google.com> <20231129060211.1890454-3-irogers@google.com>
 <ZXiauao3bIbc0ZCo@kernel.org>
In-Reply-To: <ZXiauao3bIbc0ZCo@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 12 Dec 2023 09:52:55 -0800
Message-ID: <CAP-5=fVY8MOcJfJ77hqGSxD9GoZzVQ2EEgBFsLaZXHM5gHV3aQ@mail.gmail.com>
Subject: Re: [PATCH v1 02/14] libperf cpumap: Rename and prefer sysfs for perf_cpu_map__default_new
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
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

On Tue, Dec 12, 2023 at 9:39=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Nov 28, 2023 at 10:01:59PM -0800, Ian Rogers escreveu:
> > Rename perf_cpu_map__default_new to perf_cpu_map__new_online_cpus to
> > better indicate what the implementation does. Read the online CPUs
> > from /sys/devices/system/cpu/online first before using sysconf as
> > sysconf can't accurately configure holes in the CPU map. If sysconf is
> > used, warn when the configured and online processors disagree.
> >
> > When reading from a file, if the read doesn't yield a CPU map then
> > return an empty map rather than the default online. This avoids
> > recursion but also better yields being able to detect failures.
> >
> > Add more comments.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/perf/cpumap.c              | 59 +++++++++++++++++-----------
> >  tools/lib/perf/include/perf/cpumap.h | 15 ++++++-
> >  tools/lib/perf/libperf.map           |  2 +-
> >  tools/lib/perf/tests/test-cpumap.c   |  2 +-
> >  4 files changed, 51 insertions(+), 27 deletions(-)
> >
> > diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> > index 2bd6aba3d8c9..463ca8b37d45 100644
> > --- a/tools/lib/perf/cpumap.c
> > +++ b/tools/lib/perf/cpumap.c
> > @@ -9,6 +9,7 @@
> >  #include <unistd.h>
> >  #include <ctype.h>
> >  #include <limits.h>
> > +#include "internal.h"
> >
> >  void perf_cpu_map__set_nr(struct perf_cpu_map *map, int nr_cpus)
> >  {
> > @@ -66,15 +67,21 @@ void perf_cpu_map__put(struct perf_cpu_map *map)
> >       }
> >  }
> >
> > -static struct perf_cpu_map *cpu_map__default_new(void)
> > +static struct perf_cpu_map *cpu_map__new_sysconf(void)
> >  {
> >       struct perf_cpu_map *cpus;
> > -     int nr_cpus;
> > +     int nr_cpus, nr_cpus_conf;
> >
> >       nr_cpus =3D sysconf(_SC_NPROCESSORS_ONLN);
> >       if (nr_cpus < 0)
> >               return NULL;
> >
> > +     nr_cpus_conf =3D sysconf(_SC_NPROCESSORS_CONF);
> > +     if (nr_cpus !=3D nr_cpus_conf) {
> > +             pr_warning("Number of online CPUs (%d) differs from the n=
umber configured (%d) the CPU map will only cover the first %d CPUs.",
> > +                     nr_cpus, nr_cpus_conf, nr_cpus);
> > +     }
> > +
> >       cpus =3D perf_cpu_map__alloc(nr_cpus);
> >       if (cpus !=3D NULL) {
> >               int i;
> > @@ -86,9 +93,27 @@ static struct perf_cpu_map *cpu_map__default_new(voi=
d)
> >       return cpus;
> >  }
> >
> > -struct perf_cpu_map *perf_cpu_map__default_new(void)
> > +static struct perf_cpu_map *cpu_map__new_syfs_online(void)
>
> I'm renaming this to cpu_map__new_sysfs_online(), ok?

Yep, typo. Thanks!

Ian

> - Arnaldo
>
> >  {
> > -     return cpu_map__default_new();
> > +     struct perf_cpu_map *cpus =3D NULL;
> > +     FILE *onlnf;
> > +
> > +     onlnf =3D fopen("/sys/devices/system/cpu/online", "r");
> > +     if (onlnf) {
> > +             cpus =3D perf_cpu_map__read(onlnf);
> > +             fclose(onlnf);
> > +     }
> > +     return cpus;
> > +}
> > +
> > +struct perf_cpu_map *perf_cpu_map__new_online_cpus(void)
> > +{
> > +     struct perf_cpu_map *cpus =3D cpu_map__new_syfs_online();
> > +
> > +     if (cpus)
> > +             return cpus;
> > +
> > +     return cpu_map__new_sysconf();
> >  }
> >
> >
> > @@ -180,27 +205,11 @@ struct perf_cpu_map *perf_cpu_map__read(FILE *fil=
e)
> >
> >       if (nr_cpus > 0)
> >               cpus =3D cpu_map__trim_new(nr_cpus, tmp_cpus);
> > -     else
> > -             cpus =3D cpu_map__default_new();
> >  out_free_tmp:
> >       free(tmp_cpus);
> >       return cpus;
> >  }
> >
> > -static struct perf_cpu_map *cpu_map__read_all_cpu_map(void)
> > -{
> > -     struct perf_cpu_map *cpus =3D NULL;
> > -     FILE *onlnf;
> > -
> > -     onlnf =3D fopen("/sys/devices/system/cpu/online", "r");
> > -     if (!onlnf)
> > -             return cpu_map__default_new();
> > -
> > -     cpus =3D perf_cpu_map__read(onlnf);
> > -     fclose(onlnf);
> > -     return cpus;
> > -}
> > -
> >  struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
> >  {
> >       struct perf_cpu_map *cpus =3D NULL;
> > @@ -211,7 +220,7 @@ struct perf_cpu_map *perf_cpu_map__new(const char *=
cpu_list)
> >       int max_entries =3D 0;
> >
> >       if (!cpu_list)
> > -             return cpu_map__read_all_cpu_map();
> > +             return perf_cpu_map__new_online_cpus();
> >
> >       /*
> >        * must handle the case of empty cpumap to cover
> > @@ -268,9 +277,11 @@ struct perf_cpu_map *perf_cpu_map__new(const char =
*cpu_list)
> >
> >       if (nr_cpus > 0)
> >               cpus =3D cpu_map__trim_new(nr_cpus, tmp_cpus);
> > -     else if (*cpu_list !=3D '\0')
> > -             cpus =3D cpu_map__default_new();
> > -     else
> > +     else if (*cpu_list !=3D '\0') {
> > +             pr_warning("Unexpected characters at end of cpu list ('%s=
'), using online CPUs.",
> > +                        cpu_list);
> > +             cpus =3D perf_cpu_map__new_online_cpus();
> > +     } else
> >               cpus =3D perf_cpu_map__new_any_cpu();
> >  invalid:
> >       free(tmp_cpus);
> > diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/incl=
ude/perf/cpumap.h
> > index d0bf218ada11..b24bd8b8f34e 100644
> > --- a/tools/lib/perf/include/perf/cpumap.h
> > +++ b/tools/lib/perf/include/perf/cpumap.h
> > @@ -22,7 +22,20 @@ struct perf_cpu_map;
> >   * perf_cpu_map__new_any_cpu - a map with a singular "any CPU"/dummy -=
1 value.
> >   */
> >  LIBPERF_API struct perf_cpu_map *perf_cpu_map__new_any_cpu(void);
> > -LIBPERF_API struct perf_cpu_map *perf_cpu_map__default_new(void);
> > +/**
> > + * perf_cpu_map__new_online_cpus - a map read from
> > + *                                 /sys/devices/system/cpu/online if
> > + *                                 available. If reading wasn't possib=
le a map
> > + *                                 is created using the online process=
ors
> > + *                                 assuming the first 'n' processors a=
re all
> > + *                                 online.
> > + */
> > +LIBPERF_API struct perf_cpu_map *perf_cpu_map__new_online_cpus(void);
> > +/**
> > + * perf_cpu_map__new - create a map from the given cpu_list such as "0=
-7". If no
> > + *                     cpu_list argument is provided then
> > + *                     perf_cpu_map__new_online_cpus is returned.
> > + */
> >  LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_lis=
t);
> >  LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
> >  LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map=
 *map);
> > diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> > index a8ff64baea3e..8a71f841498e 100644
> > --- a/tools/lib/perf/libperf.map
> > +++ b/tools/lib/perf/libperf.map
> > @@ -2,7 +2,7 @@ LIBPERF_0.0.1 {
> >       global:
> >               libperf_init;
> >               perf_cpu_map__new_any_cpu;
> > -             perf_cpu_map__default_new;
> > +             perf_cpu_map__new_online_cpus;
> >               perf_cpu_map__get;
> >               perf_cpu_map__put;
> >               perf_cpu_map__new;
> > diff --git a/tools/lib/perf/tests/test-cpumap.c b/tools/lib/perf/tests/=
test-cpumap.c
> > index 2c359bdb951e..c998b1dae863 100644
> > --- a/tools/lib/perf/tests/test-cpumap.c
> > +++ b/tools/lib/perf/tests/test-cpumap.c
> > @@ -29,7 +29,7 @@ int test_cpumap(int argc, char **argv)
> >       perf_cpu_map__put(cpus);
> >       perf_cpu_map__put(cpus);
> >
> > -     cpus =3D perf_cpu_map__default_new();
> > +     cpus =3D perf_cpu_map__new_online_cpus();
> >       if (!cpus)
> >               return -1;
> >
> > --
> > 2.43.0.rc1.413.gea7ed67945-goog
> >
>
> --
>
> - Arnaldo
