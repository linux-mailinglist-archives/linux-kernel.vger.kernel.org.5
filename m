Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373DD7891F0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 00:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjHYWsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 18:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjHYWsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 18:48:33 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E272710
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:48:27 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-4036bd4fff1so97031cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693003707; x=1693608507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0+Rb1NaH1693pRmgNB2WCUfTWoZhGMII0HaR68nlzk=;
        b=tf3jIpqpD0GtvBRQ+FXbU0Eu8K1SwVGqGpC7tkLl80vcjuXoyMOHEZrV8SQA3mjV/D
         hyiij0dZXbNR+sukl7YkoEj/DB8I+S5VBi28qE7P0TYGGpQrW0LX8PlvEd+lLI71/Bk/
         4HEyrbFNWJw30pV3m5Mq5VESnqQIq+NBSxUDWpGQ0tPSxFWRV87Ny68/wHiAynjqK1rT
         vCyD5aKlmfklSxqqh/oOgz9LmNrBuRQHQzmfzn/uzpgoX2jDfGYVC5FtOqshEkYY/il1
         kAOVKfW9PzIn3EVYJ7wihPawUU5Cv6vANXnf9ELYhNVK1v2qMMt7g9fWCnwdzaZhUsn5
         digA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693003707; x=1693608507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0+Rb1NaH1693pRmgNB2WCUfTWoZhGMII0HaR68nlzk=;
        b=e+PPr/q9tqQb270OJ4ApX0O1FyYLDG/GmA8h2Hk4sxEXpGOj8ClPoBrpLPE+Y051yb
         76ZNWsDrxhyojenV/C0xWiRyo+8PZHxPVngzk/ZYWQ63ymXVdOIlOmHF0s+Ocsd0s5OP
         0YsggNi8XlOMptWWpCve75iYomeKj1dQtcrsVqsaZvZfkC/SkZLQ4uKRY05DJJZvibYI
         lbT85qGuL93eJhrL90zaYK8KAP8KDWqFQe5xF8uGRm7L9V344PDAHh8cRBJJfvdmsgh+
         UZA9cuj7qO4l15JY7+9KMrwm7HK6hJn//YKTJTei/YogOa7YbpNoEk4GwjzJgE+TBte4
         thkA==
X-Gm-Message-State: AOJu0YwiLszbKpbbyyP8s1EQaJIRPNWCI+41h4DOerb0oXX3oFBOMg+b
        9nl2oSYT9mwjfOnD14mmNYfUaoYpRL7lefiCiBb6lA==
X-Google-Smtp-Source: AGHT+IEZ4dcfZSm4MLJ2kwbowC+ba0bzL1TB4iEFiMAO4h5T19ZYLp8rdAdJUPN/VLVDO7ChZlK1qJ1qDVR+Y+eifNU=
X-Received: by 2002:ac8:5fc5:0:b0:403:aa88:cf7e with SMTP id
 k5-20020ac85fc5000000b00403aa88cf7emr39147qta.29.1693003707025; Fri, 25 Aug
 2023 15:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230825135237.921058-1-irogers@google.com> <20230825135237.921058-2-irogers@google.com>
 <ZOkNzHgJ0+mgfSPz@kernel.org>
In-Reply-To: <ZOkNzHgJ0+mgfSPz@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 25 Aug 2023 15:48:11 -0700
Message-ID: <CAP-5=fUiVWWrVvF7-Xr-9zR2_Q5_WiTTC-4r0p2fgxa8bGOHkg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] perf pmus: Sort pmus by name then suffix
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 1:23=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Aug 25, 2023 at 06:52:36AM -0700, Ian Rogers escreveu:
> > Sort PMUs by name. If two PMUs have the same name but differ by
> > suffix, sort the suffixes numerically. For example, "breakpoint" comes
> > before "cpu", "uncore_imc_free_running_0" comes before
> > "uncore_imc_free_running_1". Suffixes need to be treated specially as
> > otherwise they will be ordered like 0, 1, 10, 11, .., 2, 20, 21, ..,
> > etc. Only PMUs starting 'uncore_' are considered to have a potential
> > suffix.
> >
> > Sorting of PMUs is done so that later patches can skip duplicate
> > uncore PMUs that differ only by there suffix.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/pmus.c | 48 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >
> > diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > index 4dd5912617ff..b1f6a64693fe 100644
> > --- a/tools/perf/util/pmus.c
> > +++ b/tools/perf/util/pmus.c
> > @@ -1,8 +1,10 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <linux/list.h>
> > +#include <linux/list_sort.h>
> >  #include <linux/zalloc.h>
> >  #include <subcmd/pager.h>
> >  #include <sys/types.h>
> > +#include <ctype.h>
> >  #include <dirent.h>
> >  #include <pthread.h>
> >  #include <string.h>
> > @@ -33,6 +35,31 @@ static LIST_HEAD(other_pmus);
> >  static bool read_sysfs_core_pmus;
> >  static bool read_sysfs_all_pmus;
> >
> > +static int pmu_name_len_no_suffix(const char *str, unsigned long *num)
> > +{
> > +     int orig_len, len;
> > +
> > +     orig_len =3D len =3D strlen(str);
> > +
> > +     /* Non-uncore PMUs have their full length, for example, i915. */
> > +     if (strncmp(str, "uncore_", 7))
> > +             return len;
> > +
> > +     /*
> > +      * Count trailing digits and '_', if '_{num}' suffix isn't presen=
t use
> > +      * the full length.
> > +      */
> > +     while (len > 0 && isdigit(str[len - 1]))
> > +             len--;
> > +
> > +     if (len > 0 && len !=3D orig_len && str[len - 1] =3D=3D '_') {
> > +             if (num)
> > +                     *num =3D strtoul(&str[len], NULL, 10);
> > +             return len - 1;
> > +     }
> > +     return orig_len;
> > +}
> > +
> >  void perf_pmus__destroy(void)
> >  {
> >       struct perf_pmu *pmu, *tmp;
> > @@ -122,6 +149,25 @@ static struct perf_pmu *perf_pmu__find2(int dirfd,=
 const char *name)
> >       return perf_pmu__lookup(core_pmu ? &core_pmus : &other_pmus, dirf=
d, name);
> >  }
> >
> > +static int pmus_cmp(void *priv __maybe_unused,
> > +                 const struct list_head *lhs, const struct list_head *=
rhs)
> > +{
> > +     unsigned long lhs_num, rhs_num;
> > +     struct perf_pmu *lhs_pmu =3D container_of(lhs, struct perf_pmu, l=
ist);
> > +     struct perf_pmu *rhs_pmu =3D container_of(rhs, struct perf_pmu, l=
ist);
> > +     const char *lhs_pmu_name =3D lhs_pmu->name ?: "";
> > +     const char *rhs_pmu_name =3D rhs_pmu->name ?: "";
> > +     int lhs_pmu_name_len =3D pmu_name_len_no_suffix(lhs_pmu_name, &lh=
s_num);
> > +     int rhs_pmu_name_len =3D pmu_name_len_no_suffix(rhs_pmu_name, &rh=
s_num);
> > +     int ret =3D strncmp(lhs_pmu_name, rhs_pmu_name,
> > +                     lhs_pmu_name_len < rhs_pmu_name_len ? lhs_pmu_nam=
e_len : rhs_pmu_name_len);
> > +
> > +     if (lhs_pmu_name_len !=3D rhs_pmu_name_len || ret !=3D 0 || lhs_p=
mu_name_len =3D=3D 0)
> > +             return ret;
> > +
> > +     return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
> > +}
>
> Also, I got this in some distros/gcc versions:
>
>   31    12.95 opensuse:15.5                 : FAIL gcc version 7.5.0 (SUS=
E Linux)
>     util/pmus.c: In function 'pmus_cmp':
>     util/pmus.c:169:57: error: 'lhs_num' may be used uninitialized in thi=
s function [-Werror=3Dmaybe-uninitialized]
>       return lhs_num < rhs_num ? -1 : (lhs_num > rhs_num ? 1 : 0);
>                                       ~~~~~~~~~~~~~~~~~~~~~~~^~~~
>     cc1: all warnings being treated as errors
>     make[3]: *** [/git/perf-6.5.0-rc5/tools/build/Makefile.build:150: uti=
l] Error 2
>
> I applied this, please check.

Makes sense, thanks!

Ian

> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index bbf84ccc3aba7d5c..7316da1c0ddb8eaf 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -153,7 +153,7 @@ static struct perf_pmu *perf_pmu__find2(int dirfd, co=
nst char *name)
>  static int pmus_cmp(void *priv __maybe_unused,
>                     const struct list_head *lhs, const struct list_head *=
rhs)
>  {
> -       unsigned long lhs_num, rhs_num;
> +       unsigned long lhs_num =3D 0, rhs_num =3D 0;
>         struct perf_pmu *lhs_pmu =3D container_of(lhs, struct perf_pmu, l=
ist);
>         struct perf_pmu *rhs_pmu =3D container_of(rhs, struct perf_pmu, l=
ist);
>         const char *lhs_pmu_name =3D lhs_pmu->name ?: "";
