Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A6E7C7153
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347155AbjJLPYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379229AbjJLPX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:23:57 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463F8BE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:23:55 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-534694a9f26so12773a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697124234; x=1697729034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHK1BXeTdm+7g9q0Gbvmqz6TzZXu3xcSDt6W9eTGzYc=;
        b=wjzU5OR5w4DgbX1SvAChEx94DeItImQhJixpsg5DPd5Gzszf18rP4CU0QSzpL3BBSh
         jjXXPrGyOWUuW102lTB8KS3StGIFsxW2CcSTdJYvSku95vFjauL0UmJDMhrURjZnme5L
         6ZvCKntkJNlb9UdmVlBa3fLxbqkwNltp2kl3pGN9z6ZYZPUn6GIxwWutF3r/HW0Artm0
         XA7OJyUj/zCrwiFfJWLrKxIdCUqrZrL72md8FGOiTy3JSCfI01pMl2fdMLuEGMNWg0vy
         5Nrr11VhUBFsv6aLeTPElHa2rMOPVOecT4yRc/TS8PMDLQblPS6jLgUOXBnqzOIp5gCa
         /JWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697124234; x=1697729034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHK1BXeTdm+7g9q0Gbvmqz6TzZXu3xcSDt6W9eTGzYc=;
        b=Xxw+yqfk33tLKtKi8KPSbBe4CVjJ9MhL76r0H7xGpxc9zD6DTGW9X+l0w5KfOknILm
         B+WSBGzTh/saeyPqVPbOsrX7O2RpGcJGc1mkEeWJrioYrU13ACasjWneftRLHpRk+X5f
         DQdSC7/AqBysyLUUODAgnnkSMKW3+KLZLH7HdblaK5K7XhG55Dw6IdyMrFH2qUppT4zv
         rIrX3SfnW2JfX2/BmLA3GrmQ5D9MRrqjAHlZZanglhBS9nPQ/GzzGOe4Tx958IDFR2p/
         dL02t/pCWkedye3WZ7cMHlxicBXbo3bLywBx+CcKBnVSKM1+dFBQyeXboWL7bPty0kcK
         Q1PQ==
X-Gm-Message-State: AOJu0YzNg2wkssIsAo2nj6pJZN5CxILZqLbj4MPJQalvvmI6NKhw/QoI
        viBVBcXUbpiN2P7I+VLY/lCmcJqiLLALjxf/qZf3CQ==
X-Google-Smtp-Source: AGHT+IFZGO459xegjVhoxo3jMuV9imFcJFGdp4gWgXQTdHQumNjI6BXPIPTq79D6jy3RfwJhKb+1ZhKvV4IVglpN5H8=
X-Received: by 2002:a50:99d8:0:b0:53d:a40e:bed1 with SMTP id
 n24-20020a5099d8000000b0053da40ebed1mr299680edb.3.1697124233496; Thu, 12 Oct
 2023 08:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231007021326.4156714-1-irogers@google.com> <20231007021326.4156714-2-irogers@google.com>
 <002da48a-c40f-4d6a-881c-59490ea2de95@intel.com>
In-Reply-To: <002da48a-c40f-4d6a-881c-59490ea2de95@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 12 Oct 2023 08:23:41 -0700
Message-ID: <CAP-5=fX6OkyWD_nC6aruSRi44Nkt-UMLqwRKtLUcE87q_Khgcg@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] perf pmu: Rename perf_pmu__get_default_config to perf_pmu__arch_init
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 4:52=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 7/10/23 05:13, Ian Rogers wrote:
> > Assign default_config as part of the
> > init. perf_pmu__get_default_config was doing more than just getting
> > the default config and so this is intended to better align with the
> > code.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> One cosmetic comment otherwise:
>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
>
> > ---
> >  tools/perf/arch/arm/util/pmu.c  |  8 +++-----
> >  tools/perf/arch/s390/util/pmu.c |  3 +--
> >  tools/perf/arch/x86/util/pmu.c  |  5 ++---
> >  tools/perf/util/pmu.c           | 14 +++++++-------
> >  tools/perf/util/pmu.h           |  2 +-
> >  5 files changed, 14 insertions(+), 18 deletions(-)
> >
> > diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/=
pmu.c
> > index a9623b128ece..d55d2b15f2e6 100644
> > --- a/tools/perf/arch/arm/util/pmu.c
> > +++ b/tools/perf/arch/arm/util/pmu.c
> > @@ -14,22 +14,20 @@
> >  #include "../../../util/pmu.h"
> >  #include "../../../util/cs-etm.h"
> >
> > -struct perf_event_attr
> > -*perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
> > +void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
> >  {
> >  #ifdef HAVE_AUXTRACE_SUPPORT
> >       if (!strcmp(pmu->name, CORESIGHT_ETM_PMU_NAME)) {
> >               /* add ETM default config here */
> >               pmu->selectable =3D true;
> > -             return cs_etm_get_default_config(pmu);
> > +             pmu->default_config =3D cs_etm_get_default_config(pmu);
> >  #if defined(__aarch64__)
> >       } else if (strstarts(pmu->name, ARM_SPE_PMU_NAME)) {
> > -             return arm_spe_pmu_default_config(pmu);
> > +             pmu->default_config =3D arm_spe_pmu_default_config(pmu);
> >       } else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
> >               pmu->selectable =3D true;
> >  #endif
> >       }
> >
> >  #endif
> > -     return NULL;
> >  }
> > diff --git a/tools/perf/arch/s390/util/pmu.c b/tools/perf/arch/s390/uti=
l/pmu.c
> > index 11f03f32e3fd..886c30e001fa 100644
> > --- a/tools/perf/arch/s390/util/pmu.c
> > +++ b/tools/perf/arch/s390/util/pmu.c
> > @@ -13,11 +13,10 @@
> >  #define      S390_PMUPAI_EXT         "pai_ext"
> >  #define      S390_PMUCPUM_CF         "cpum_cf"
> >
> > -struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *=
pmu)
> > +void perf_pmu__arch_init(struct perf_pmu *pmu)
> >  {
> >       if (!strcmp(pmu->name, S390_PMUPAI_CRYPTO) ||
> >           !strcmp(pmu->name, S390_PMUPAI_EXT) ||
> >           !strcmp(pmu->name, S390_PMUCPUM_CF))
> >               pmu->selectable =3D true;
> > -     return NULL;
> >  }
> > diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/=
pmu.c
> > index 8b53ca468a50..811e2377d2d5 100644
> > --- a/tools/perf/arch/x86/util/pmu.c
> > +++ b/tools/perf/arch/x86/util/pmu.c
> > @@ -17,19 +17,18 @@
> >  #include "../../../util/pmus.h"
> >  #include "env.h"
> >
> > -struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *=
pmu __maybe_unused)
> > +void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
> >  {
> >  #ifdef HAVE_AUXTRACE_SUPPORT
> >       if (!strcmp(pmu->name, INTEL_PT_PMU_NAME)) {
> >               pmu->auxtrace =3D true;
> > -             return intel_pt_pmu_default_config(pmu);
> > +             pmu->default_config =3D intel_pt_pmu_default_config(pmu);
> >       }
> >       if (!strcmp(pmu->name, INTEL_BTS_PMU_NAME)) {
> >               pmu->auxtrace =3D true;
> >               pmu->selectable =3D true;
> >       }
> >  #endif
> > -     return NULL;
> >  }
> >
> >  int perf_pmus__num_mem_pmus(void)
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 6b1b7f8f00fa..6e95b3d2c2e3 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -954,12 +954,6 @@ void pmu_add_sys_aliases(struct perf_pmu *pmu)
> >       pmu_for_each_sys_event(pmu_add_sys_aliases_iter_fn, pmu);
> >  }
> >
> > -struct perf_event_attr * __weak
> > -perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
> > -{
> > -     return NULL;
> > -}
> > -
> >  static char *pmu_find_alias_name(struct perf_pmu *pmu, int dirfd)
> >  {
> >       FILE *file =3D perf_pmu__open_file_at(pmu, dirfd, "alias");
> > @@ -991,6 +985,12 @@ static int pmu_max_precise(int dirfd, struct perf_=
pmu *pmu)
> >       return max_precise;
> >  }
> >
> > +
>
> Double blank line

Thanks, will fix in v2.

Ian

> > +void __weak
> > +perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
> > +{
> > +}
> > +
> >  struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, c=
onst char *name)
> >  {
> >       struct perf_pmu *pmu;
> > @@ -1037,7 +1037,7 @@ struct perf_pmu *perf_pmu__lookup(struct list_hea=
d *pmus, int dirfd, const char
> >       pmu_add_sys_aliases(pmu);
> >       list_add_tail(&pmu->list, pmus);
> >
> > -     pmu->default_config =3D perf_pmu__get_default_config(pmu);
> > +     perf_pmu__arch_init(pmu);
> >
> >       return pmu;
> >  err:
> > diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> > index 85190d058852..588c64e38d6b 100644
> > --- a/tools/perf/util/pmu.h
> > +++ b/tools/perf/util/pmu.h
> > @@ -233,7 +233,7 @@ bool perf_pmu__file_exists(struct perf_pmu *pmu, co=
nst char *name);
> >
> >  int perf_pmu__test(void);
> >
> > -struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *=
pmu);
> > +void perf_pmu__arch_init(struct perf_pmu *pmu);
> >  void pmu_add_cpu_aliases_table(struct perf_pmu *pmu,
> >                              const struct pmu_events_table *table);
> >
>
