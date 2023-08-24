Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2713787BAD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 00:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243970AbjHXWyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 18:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240994AbjHXWyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 18:54:14 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03CD1BF7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 15:54:12 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4036bd4fff1so118041cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 15:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692917652; x=1693522452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJ3y2BMzT2zcO3uJ9tBV/7pg3Ax7EBLCjw8LwYm+cAE=;
        b=704vwkfC3yczVYi+KCH3/E0En8j4Nc0469tr/dYWjoe1bbecUyTLHI2kuHM67FwSSX
         o+nvT0UxuY1aFqXI+2t0mA6LeHRqXjMKoQYb2aaQ3n3FnX53oUqLLSOyuuXCr4zPaeWX
         y+q3SyGFE/Rp1WA2faMXaHT7olDHdU9io1uFwzpHaW5jkJP4jA8j8ogqB0KOOyk6MWAE
         ObmqDlDTzCZjzzq7bGpr5smwsUmxZ8K4H7vNUbfbCP/3SkXlyuTMEqr/ABowV3lzoXxv
         CmXv3bhJJXpmOLE9+TySuYKEJKu2C0r18AzON+iASBS0qKZ0fCDPDBtThydrWVfSgayR
         6edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692917652; x=1693522452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJ3y2BMzT2zcO3uJ9tBV/7pg3Ax7EBLCjw8LwYm+cAE=;
        b=lISQbiH7k8uJ/qcaeSBqzHVGaLFH4lQl4ULdsf17oKVwENgFPJp/hN30az6geJjZvT
         OcSdL7/NqgF6nR/k1bwGa6decElPEDbs74tZaaAxz+5665v7ZL2mQqoaqTHhYD/WZMui
         n6plTbOhUqsNrlORqih1d6osQ286LcExVKPoWCYF4uKRV71pEMuVjSL/0NEJ7aXwd1/Z
         q0kGzj3rLEdGV/Vb7Qjghid7chmQmXv+7PTHIJrfMEUWGxvsnXtP1lO+FxVwJ8jNKqMp
         SpEtSqDuOHDdv8YrKWPNqwrtUlgbuxyakoR7UHyNjdHtr0WUBGDJLhulJYYTmuzii9/6
         Mznw==
X-Gm-Message-State: AOJu0YzfFuTTH3mgT8kjPKxfxl9MDDx/srUQIglB5URSN1r1O2OI7Kag
        mED/eGlawTQQrEU4ko5DSAkhwJeQCkdGm2cN4T74HA==
X-Google-Smtp-Source: AGHT+IF+0gYIC2Dt9SHNoDtO/fYR1jd2uDJddMdZ2oNhSJbgx6Y7Tjv8DQkjLjvCZI6KlE/OO3V+BnwT83k1BHywEn4=
X-Received: by 2002:a05:622a:12:b0:3e0:c2dd:fd29 with SMTP id
 x18-20020a05622a001200b003e0c2ddfd29mr108898qtw.4.1692917651758; Thu, 24 Aug
 2023 15:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230818171952.3719251-1-irogers@google.com> <b244a320-5f00-d382-a4ab-0168a80c55fe@huawei.com>
 <ZONjuqVhDNzWPIQ3@kernel.org>
In-Reply-To: <ZONjuqVhDNzWPIQ3@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Aug 2023 15:54:00 -0700
Message-ID: <CAP-5=fUW9VmBoxfeTHL3upqg-gZRuE6Gd3e0LhY_N5UP6Am5ew@mail.gmail.com>
Subject: Re: [PATCH v1] perf header: Fix missing PMU caps
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     "liwei (GF)" <liwei391@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
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

On Mon, Aug 21, 2023 at 6:16=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Sat, Aug 19, 2023 at 12:16:09PM +0800, liwei (GF) escreveu:
> > Hi Ian:
> >
> > On 2023/8/19 1:19, Ian Rogers wrote:
> > > PMU caps are written as HEADER_PMU_CAPS or for the special case of th=
e
> > > PMU "cpu" as HEADER_CPU_PMU_CAPS. As the PMU "cpu" is special, and no=
t
> > > any "core" PMU, the logic had become broken and core PMUs not called
> > > "cpu" were not having their caps written. This affects ARM and s390
> > > non-hybrid PMUs.
> > >
> > > Simplify the PMU caps writing logic to scan one fewer time and to be
> > > more explicit in its behavior.
> > >
> > > Reported-by: Wei Li <liwei391@huawei.com>
> > > Fixes: 178ddf3bad98 ("perf header: Avoid hybrid PMU list in write_pmu=
_caps")
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/header.c | 31 ++++++++++++++++---------------
> > >  1 file changed, 16 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > > index 52fbf526fe74..13c71d28e0eb 100644
> > > --- a/tools/perf/util/header.c
> > > +++ b/tools/perf/util/header.c
> > > @@ -1605,8 +1605,15 @@ static int write_pmu_caps(struct feat_fd *ff,
> > >     int ret;
> > >
> > >     while ((pmu =3D perf_pmus__scan(pmu))) {
> > > -           if (!pmu->name || !strcmp(pmu->name, "cpu") ||
> > > -               perf_pmu__caps_parse(pmu) <=3D 0)
> > > +           if (!strcmp(pmu->name, "cpu")) {
> >
> > So you removed the check of 'pmu->name', does this check really redunda=
nt? since
> > we can find such checks in many places in the perf code. If not, i thin=
k it is
> > necessary for strcmp().
>
> Indeed, when sorting in tools/perf/util/pmus.c in cmp_sevent() we have:
>
>         /* Order by PMU name. */
>         if (as->pmu !=3D bs->pmu) {
>                 a_pmu_name =3D a_pmu_name ?: (as->pmu->name ?: "");
>                 b_pmu_name =3D b_pmu_name ?: (bs->pmu->name ?: "");
>                 ret =3D strcmp(a_pmu_name, b_pmu_name);
>                 if (ret)
>                         return ret;
>         }
>
>
> And even if in this specific case, for some reason, we could guarantee
> that pmu->name isn't NULL, then removing that check should be best left
> for a separate patch with an explanation as to why that is safe.
>
> Having it as:
>
>         while ((pmu =3D perf_pmus__scan(pmu))) {
> -               if (!pmu->name || !strcmp(pmu->name, "cpu") ||
> -                   perf_pmu__caps_parse(pmu) <=3D 0)
> +               if (!pmu->name || !strcmp(pmu->name, "cpu")) {
>
> even eases a bit reviewing, as we see we're just removing that
> perf_pmu__caps_parse(pmu) line.
>
> Ian?

The pmu name is initialized with:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmu.c?h=3Dperf-tools-next#n1001
pmu->name =3D strdup(name);
if (!pmu->name)
goto err;

so name can't be NULL, strdup of NULL is segv, as if it were pmu would
be NULL. I'll clean this up in an additional patch on top of this one.

Thanks,
Ian

> - Arnaldo
>
>
> > > +                   /*
> > > +                    * The "cpu" PMU is special and covered by
> > > +                    * HEADER_CPU_PMU_CAPS. Note, core PMUs are
> > > +                    * counted/written here for ARM, s390 and Intel h=
ybrid.
> > > +                    */
> > > +                   continue;
> > > +           }
> > > +           if (perf_pmu__caps_parse(pmu) <=3D 0)
> > >                     continue;
> > >             nr_pmu++;
> > >     }
> > > @@ -1619,23 +1626,17 @@ static int write_pmu_caps(struct feat_fd *ff,
> > >             return 0;
> > >
> > >     /*
> > > -    * Write hybrid pmu caps first to maintain compatibility with
> > > -    * older perf tool.
> > > +    * Note older perf tools assume core PMUs come first, this is a p=
roperty
> > > +    * of perf_pmus__scan.
> > >      */
> > > -   if (perf_pmus__num_core_pmus() > 1) {
> > > -           pmu =3D NULL;
> > > -           while ((pmu =3D perf_pmus__scan_core(pmu))) {
> > > -                   ret =3D __write_pmu_caps(ff, pmu, true);
> > > -                   if (ret < 0)
> > > -                           return ret;
> > > -           }
> > > -   }
> > > -
> > >     pmu =3D NULL;
> > >     while ((pmu =3D perf_pmus__scan(pmu))) {
> > > -           if (pmu->is_core || !pmu->nr_caps)
> > > +           if (!strcmp(pmu->name, "cpu")) {
> >
> > same here
> >
> > Thanks,
> > Wei
> >
> > > +                   /* Skip as above. */
> > > +                   continue;
> > > +           }
> > > +           if (perf_pmu__caps_parse(pmu) <=3D 0)
> > >                     continue;
> > > -
> > >             ret =3D __write_pmu_caps(ff, pmu, true);
> > >             if (ret < 0)
> > >                     return ret;
>
> --
>
> - Arnaldo
