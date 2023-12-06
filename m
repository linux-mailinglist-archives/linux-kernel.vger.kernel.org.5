Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC07807A1C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441794AbjLFVHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379534AbjLFVHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:07:39 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7804FD6D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 13:07:44 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50bf09be81bso203e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 13:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701896863; x=1702501663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZarDb6lzpOC9dFoZuQmxMoZQ8EvH48y1VSgOo5R0Jwc=;
        b=EaD3zqcbhBKe3y5Kzh5S4+LaOZTDBKM4Q5Dn4tU6T2fkMj8xvfZg9vFWeUF7/5Gb/S
         o8dSnExk0jxhc2cuTUtI8sJRwA+5m/txqs0y1sHIIht3DFBOVtAwoNW+jcH93cpu7IMT
         f3RhERem4vM7jYKQ9I60eSr36pc9NZM0NY4ZGEGwLKeosASiFxIyt7m3+WXKSMdnzOL5
         bm8VuizOPADIfBrFoDzCoNVJWZKsbAN9DnABc/LljY/w2zw9Q1wB71zOnSdnqhfzdm/b
         Xih5BWBRL+gI1duwaSIfKs+/rvGDP2L/L+rBD8zMvoWfKmn9RerFzfMVjTPy941NnEfe
         +PqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701896863; x=1702501663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZarDb6lzpOC9dFoZuQmxMoZQ8EvH48y1VSgOo5R0Jwc=;
        b=LY3SjlMVRAxzDn0/l3cz3eOgOaXJZ7X9zI+2AcnD1h72R46vLBrw1IYa5hAyLroEPk
         YyXaT3UwhcWyKYN4Xbjzr5lc5x1VmVJllQqmKlH9ROJPjl7rEGpXIMKPHn8n70FoJi6t
         H4sisZStNVpDXSUKamf1vJS9S0juwBZvb/rBQN7uRfHcL3cWE7FW/X+slqYXINJVvwO/
         odU63op3BRVOuLlHmVu7ytiYHlwoejJGIpQBcb0dfIpUygfGNpjiAbDUxjCRTOEMwrhI
         AkNeyBX+Xb/gzzGd+S+S1q2VQPTypj2otCdjxIbTfwTel80bRZUKGlz/xB+lows/RvIX
         yLtA==
X-Gm-Message-State: AOJu0YysYdCBtS84ZXEXbFYhFYwPzWkjYhFcp6D5xq8MrepSwYpRyvQQ
        KP6+zJJ5hMT3JbwRS/T/I1wH88OiEcY8guLjkaYwmaNr1QbaQ7jbkaeQt/Jt
X-Google-Smtp-Source: AGHT+IHS6CzwGe+HGfJUHd1nOd2GXxXodEfJjBEUkiRg00/rEff2uWK04RLZX1NueM9XJP2sY5SIUB7up4dFazXO5xw=
X-Received: by 2002:ac2:5f56:0:b0:50b:cdd5:b54a with SMTP id
 22-20020ac25f56000000b0050bcdd5b54amr49573lfz.3.1701896862417; Wed, 06 Dec
 2023 13:07:42 -0800 (PST)
MIME-Version: 1.0
References: <20231206201324.184059-1-kan.liang@linux.intel.com> <20231206201324.184059-4-kan.liang@linux.intel.com>
In-Reply-To: <20231206201324.184059-4-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 6 Dec 2023 13:07:31 -0800
Message-ID: <CAP-5=fV7MNhTtO6ccPeQ40ZhEOFVmJVe1+cij9tqPeTqhHX_wQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] perf mem: Clean up perf_mem_events__name()
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        john.g.garry@oracle.com, will@kernel.org, james.clark@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
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

On Wed, Dec 6, 2023 at 12:13=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Introduce a generic perf_mem_events__name(). Remove the ARCH-specific
> one.
>
> The mem_load events may have a different format. Add ldlat and aux_event
> in the struct perf_mem_event to indicate the format and the extra aux
> event.
>
> Add perf_mem_events_intel_aux[] to support the extra mem_load_aux event.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/arch/arm64/util/mem-events.c   | 26 ++-------
>  tools/perf/arch/powerpc/util/mem-events.c | 13 ++---
>  tools/perf/arch/powerpc/util/mem-events.h |  7 +++
>  tools/perf/arch/powerpc/util/pmu.c        | 11 ++++
>  tools/perf/arch/x86/util/mem-events.c     | 70 +++++------------------
>  tools/perf/arch/x86/util/mem-events.h     |  1 +
>  tools/perf/arch/x86/util/pmu.c            |  8 ++-
>  tools/perf/util/mem-events.c              | 56 ++++++++++++------
>  tools/perf/util/mem-events.h              |  3 +-
>  9 files changed, 89 insertions(+), 106 deletions(-)
>  create mode 100644 tools/perf/arch/powerpc/util/mem-events.h
>  create mode 100644 tools/perf/arch/powerpc/util/pmu.c
>
> diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/ar=
m64/util/mem-events.c
> index 2602e8688727..eb2ef84f0fc8 100644
> --- a/tools/perf/arch/arm64/util/mem-events.c
> +++ b/tools/perf/arch/arm64/util/mem-events.c
> @@ -2,28 +2,10 @@
>  #include "map_symbol.h"
>  #include "mem-events.h"
>
> -#define E(t, n, s) { .tag =3D t, .name =3D n, .sysfs_name =3D s }
> +#define E(t, n, s, l, a) { .tag =3D t, .name =3D n, .sysfs_name =3D s, .=
ldlat =3D l, .aux_event =3D a }
>
>  struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX] =3D {
> -       E("spe-load",   "arm_spe_0/ts_enable=3D1,pa_enable=3D1,load_filte=
r=3D1,store_filter=3D0,min_latency=3D%u/",       "arm_spe_0"),
> -       E("spe-store",  "arm_spe_0/ts_enable=3D1,pa_enable=3D1,load_filte=
r=3D0,store_filter=3D1/",                      "arm_spe_0"),
> -       E("spe-ldst",   "arm_spe_0/ts_enable=3D1,pa_enable=3D1,load_filte=
r=3D1,store_filter=3D1,min_latency=3D%u/",       "arm_spe_0"),
> +       E("spe-load",   "%s/ts_enable=3D1,pa_enable=3D1,load_filter=3D1,s=
tore_filter=3D0,min_latency=3D%u/",      "arm_spe_0",    true,   0),
> +       E("spe-store",  "%s/ts_enable=3D1,pa_enable=3D1,load_filter=3D0,s=
tore_filter=3D1/",                     "arm_spe_0",    false,  0),
> +       E("spe-ldst",   "%s/ts_enable=3D1,pa_enable=3D1,load_filter=3D1,s=
tore_filter=3D1,min_latency=3D%u/",      "arm_spe_0",    true,   0),
>  };
> -
> -static char mem_ev_name[100];
> -
> -const char *perf_mem_events__name(int i, const char *pmu_name __maybe_un=
used)
> -{
> -       struct perf_mem_event *e =3D &perf_mem_events_arm[i];
> -
> -       if (i >=3D PERF_MEM_EVENTS__MAX)
> -               return NULL;
> -
> -       if (i =3D=3D PERF_MEM_EVENTS__LOAD || i =3D=3D PERF_MEM_EVENTS__L=
OAD_STORE)
> -               scnprintf(mem_ev_name, sizeof(mem_ev_name),
> -                         e->name, perf_mem_events__loads_ldlat);
> -       else /* PERF_MEM_EVENTS__STORE */
> -               scnprintf(mem_ev_name, sizeof(mem_ev_name), e->name);
> -
> -       return mem_ev_name;
> -}
> diff --git a/tools/perf/arch/powerpc/util/mem-events.c b/tools/perf/arch/=
powerpc/util/mem-events.c
> index 78b986e5268d..b7883e38950f 100644
> --- a/tools/perf/arch/powerpc/util/mem-events.c
> +++ b/tools/perf/arch/powerpc/util/mem-events.c
> @@ -2,11 +2,10 @@
>  #include "map_symbol.h"
>  #include "mem-events.h"
>
> -/* PowerPC does not support 'ldlat' parameter. */
> -const char *perf_mem_events__name(int i, const char *pmu_name __maybe_un=
used)
> -{
> -       if (i =3D=3D PERF_MEM_EVENTS__LOAD)
> -               return "cpu/mem-loads/";
> +#define E(t, n, s, l, a) { .tag =3D t, .name =3D n, .sysfs_name =3D s, .=
ldlat =3D l, .aux_event =3D a }
>
> -       return "cpu/mem-stores/";
> -}
> +struct perf_mem_event perf_mem_events_power[PERF_MEM_EVENTS__MAX] =3D {
> +       E("ldlat-loads",        "%s/mem-loads/",        "cpu/events/mem-l=
oads",         false,  0),
> +       E("ldlat-stores",       "%s/mem-stores/",       "cpu/events/mem-s=
tores",        false,  0),
> +       E(NULL,                 NULL,                   NULL,            =
               false,  0),
> +};
> diff --git a/tools/perf/arch/powerpc/util/mem-events.h b/tools/perf/arch/=
powerpc/util/mem-events.h
> new file mode 100644
> index 000000000000..6acc3d1b6873
> --- /dev/null
> +++ b/tools/perf/arch/powerpc/util/mem-events.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _POWER_MEM_EVENTS_H
> +#define _POWER_MEM_EVENTS_H
> +
> +extern struct perf_mem_event perf_mem_events_power[PERF_MEM_EVENTS__MAX]=
;
> +
> +#endif /* _POWER_MEM_EVENTS_H */
> diff --git a/tools/perf/arch/powerpc/util/pmu.c b/tools/perf/arch/powerpc=
/util/pmu.c
> new file mode 100644
> index 000000000000..168173f88ddb
> --- /dev/null
> +++ b/tools/perf/arch/powerpc/util/pmu.c
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <string.h>
> +
> +#include "../../../util/pmu.h"
> +
> +void perf_pmu__arch_init(struct perf_pmu *pmu)
> +{
> +       if (pmu->is_core)
> +               pmu->mem_events =3D perf_mem_events_power;
> +}
> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/=
util/mem-events.c
> index 5fb41d50118d..f0e66a0151a0 100644
> --- a/tools/perf/arch/x86/util/mem-events.c
> +++ b/tools/perf/arch/x86/util/mem-events.c
> @@ -7,25 +7,26 @@
>  #include "linux/string.h"
>  #include "env.h"
>
> -static char mem_loads_name[100];
> -static bool mem_loads_name__init;
> -static char mem_stores_name[100];
> -
>  #define MEM_LOADS_AUX          0x8203
> -#define MEM_LOADS_AUX_NAME     "{%s/mem-loads-aux/,%s/mem-loads,ldlat=3D=
%u/}:P"
>
> -#define E(t, n, s) { .tag =3D t, .name =3D n, .sysfs_name =3D s }
> +#define E(t, n, s, l, a) { .tag =3D t, .name =3D n, .sysfs_name =3D s, .=
ldlat =3D l, .aux_event =3D a }
>
>  struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX] =3D {
> -       E("ldlat-loads",        "%s/mem-loads,ldlat=3D%u/P",      "%s/eve=
nts/mem-loads"),
> -       E("ldlat-stores",       "%s/mem-stores/P",              "%s/event=
s/mem-stores"),
> -       E(NULL,                 NULL,                           NULL),
> +       E("ldlat-loads",        "%s/mem-loads,ldlat=3D%u/P",      "%s/eve=
nts/mem-loads",  true,   0),
> +       E("ldlat-stores",       "%s/mem-stores/P",              "%s/event=
s/mem-stores", false,  0),
> +       E(NULL,                 NULL,                           NULL,    =
               false,  0),
> +};
> +
> +struct perf_mem_event perf_mem_events_intel_aux[PERF_MEM_EVENTS__MAX] =
=3D {
> +       E("ldlat-loads",        "{%s/mem-loads-aux/,%s/mem-loads,ldlat=3D=
%u/}:P", "%s/events/mem-loads",  true,   MEM_LOADS_AUX),
> +       E("ldlat-stores",       "%s/mem-stores/P",              "%s/event=
s/mem-stores", false,  0),
> +       E(NULL,                 NULL,                           NULL,    =
               false,  0),
>  };
>
>  struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] =3D {
> -       E(NULL,         NULL,           NULL),
> -       E(NULL,         NULL,           NULL),
> -       E("mem-ldst",   "ibs_op//",     "ibs_op"),
> +       E(NULL,         NULL,           NULL,           false,  0),
> +       E(NULL,         NULL,           NULL,           false,  0),
> +       E("mem-ldst",   "%s//",         "ibs_op",       false,  0),
>  };
>
>  bool is_mem_loads_aux_event(struct evsel *leader)
> @@ -40,48 +41,3 @@ bool is_mem_loads_aux_event(struct evsel *leader)
>
>         return leader->core.attr.config =3D=3D MEM_LOADS_AUX;
>  }
> -
> -const char *perf_mem_events__name(int i, const char *pmu_name)
> -{
> -       struct perf_mem_event *e;
> -
> -       if (x86__is_amd_cpu())
> -               e =3D &perf_mem_events_amd[i];
> -       else
> -               e =3D &perf_mem_events_intel[i];
> -
> -       if (!e)
> -               return NULL;
> -
> -       if (i =3D=3D PERF_MEM_EVENTS__LOAD) {
> -               if (mem_loads_name__init && !pmu_name)
> -                       return mem_loads_name;
> -
> -               if (!pmu_name) {
> -                       mem_loads_name__init =3D true;
> -                       pmu_name =3D "cpu";
> -               }
> -
> -               if (perf_pmus__have_event(pmu_name, "mem-loads-aux")) {
> -                       scnprintf(mem_loads_name, sizeof(mem_loads_name),
> -                                 MEM_LOADS_AUX_NAME, pmu_name, pmu_name,
> -                                 perf_mem_events__loads_ldlat);
> -               } else {
> -                       scnprintf(mem_loads_name, sizeof(mem_loads_name),
> -                                 e->name, pmu_name,
> -                                 perf_mem_events__loads_ldlat);
> -               }
> -               return mem_loads_name;
> -       }
> -
> -       if (i =3D=3D PERF_MEM_EVENTS__STORE) {
> -               if (!pmu_name)
> -                       pmu_name =3D "cpu";
> -
> -               scnprintf(mem_stores_name, sizeof(mem_stores_name),
> -                         e->name, pmu_name);
> -               return mem_stores_name;
> -       }
> -
> -       return e->name;
> -}
> diff --git a/tools/perf/arch/x86/util/mem-events.h b/tools/perf/arch/x86/=
util/mem-events.h
> index 3959e427f482..f55c8d3b7d59 100644
> --- a/tools/perf/arch/x86/util/mem-events.h
> +++ b/tools/perf/arch/x86/util/mem-events.h
> @@ -3,6 +3,7 @@
>  #define _X86_MEM_EVENTS_H
>
>  extern struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX]=
;
> +extern struct perf_mem_event perf_mem_events_intel_aux[PERF_MEM_EVENTS__=
MAX];
>
>  extern struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX];
>
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pm=
u.c
> index 7e69f4f2e363..446f8197aae4 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -35,8 +35,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_=
unused)
>         if (x86__is_amd_cpu()) {
>                 if (strcmp(pmu->name, "ibs_op"))
>                         pmu->mem_events =3D perf_mem_events_amd;
> -       } else if (pmu->is_core)
> -               pmu->mem_events =3D perf_mem_events_intel;
> +       } else if (pmu->is_core) {
> +               if (perf_pmu__have_event(pmu, "mem-loads-aux"))
> +                       pmu->mem_events =3D perf_mem_events_intel_aux;
> +               else
> +                       pmu->mem_events =3D perf_mem_events_intel;
> +       }
>  }
>
>  int perf_pmus__num_mem_pmus(void)
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 887ffdcce338..3a60cbcd6d8e 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -17,17 +17,17 @@
>
>  unsigned int perf_mem_events__loads_ldlat =3D 30;
>
> -#define E(t, n, s) { .tag =3D t, .name =3D n, .sysfs_name =3D s }
> +#define E(t, n, s, l, a) { .tag =3D t, .name =3D n, .sysfs_name =3D s, .=
ldlat =3D l, .aux_event =3D a }
>
>  struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] =3D {
> -       E("ldlat-loads",        "cpu/mem-loads,ldlat=3D%u/P",     "cpu/ev=
ents/mem-loads"),
> -       E("ldlat-stores",       "cpu/mem-stores/P",             "cpu/even=
ts/mem-stores"),
> -       E(NULL,                 NULL,                           NULL),
> +       E("ldlat-loads",        "%s/mem-loads/,ldlat=3D%u/P",     "cpu/ev=
ents/mem-loads",         true,   0),

Is there a mistake here "/," looks like it should just be ",".

Thanks,
Ian

> +       E("ldlat-stores",       "%s/mem-stores/P",              "cpu/even=
ts/mem-stores",        false,  0),
> +       E(NULL,                 NULL,                           NULL,    =
                       false,  0),
>  };
>  #undef E
>
>  static char mem_loads_name[100];
> -static bool mem_loads_name__init;
> +static char mem_stores_name[100];
>
>  struct perf_mem_event *perf_mem_events__ptr(struct perf_pmu *pmu, int i)
>  {
> @@ -62,23 +62,45 @@ struct perf_pmu *perf_mem_events_find_pmu(void)
>         return perf_pmus__scan_mem(NULL);
>  }
>
> -const char * __weak perf_mem_events__name(int i, const char *pmu_name  _=
_maybe_unused)
> +static const char *perf_mem_events__name(int i, struct perf_pmu *pmu)
>  {
> -       struct perf_mem_event *e =3D &perf_mem_events[i];
> +       struct perf_mem_event *e =3D &pmu->mem_events[i];
>
>         if (!e)
>                 return NULL;
>
> -       if (i =3D=3D PERF_MEM_EVENTS__LOAD) {
> -               if (!mem_loads_name__init) {
> -                       mem_loads_name__init =3D true;
> -                       scnprintf(mem_loads_name, sizeof(mem_loads_name),
> -                                 e->name, perf_mem_events__loads_ldlat);
> +       if (i =3D=3D PERF_MEM_EVENTS__LOAD || i =3D=3D PERF_MEM_EVENTS__L=
OAD_STORE) {
> +               if (e->ldlat) {
> +                       if (!e->aux_event) {
> +                               /* ARM and Most of Intel */
> +                               scnprintf(mem_loads_name, sizeof(mem_load=
s_name),
> +                                         e->name, pmu->name,
> +                                         perf_mem_events__loads_ldlat);
> +                       } else {
> +                               /* Intel with mem-loads-aux event */
> +                               scnprintf(mem_loads_name, sizeof(mem_load=
s_name),
> +                                         e->name, pmu->name, pmu->name,
> +                                         perf_mem_events__loads_ldlat);
> +                       }
> +               } else {
> +                       if (!e->aux_event) {
> +                               /* AMD and POWER */
> +                               scnprintf(mem_loads_name, sizeof(mem_load=
s_name),
> +                                         e->name, pmu->name);
> +                       } else
> +                               return NULL;
>                 }
> +
>                 return mem_loads_name;
>         }
>
> -       return e->name;
> +       if (i =3D=3D PERF_MEM_EVENTS__STORE) {
> +               scnprintf(mem_stores_name, sizeof(mem_stores_name),
> +                         e->name, pmu->name);
> +               return mem_stores_name;
> +       }
> +
> +       return NULL;
>  }
>
>  __weak bool is_mem_loads_aux_event(struct evsel *leader __maybe_unused)
> @@ -175,7 +197,7 @@ void perf_mem_events__list(struct perf_pmu *pmu)
>                         e->tag ? 13 : 0,
>                         e->tag ? : "",
>                         e->tag && verbose > 0 ? 25 : 0,
> -                       e->tag && verbose > 0 ? perf_mem_events__name(j, =
NULL) : "",
> +                       e->tag && verbose > 0 ? perf_mem_events__name(j, =
pmu) : "",
>                         e->supported ? ": available\n" : "");
>         }
>  }
> @@ -198,15 +220,15 @@ int perf_mem_events__record_args(const char **rec_a=
rgv, int *argv_nr,
>
>                         if (!e->supported) {
>                                 pr_err("failed: event '%s' not supported\=
n",
> -                                       perf_mem_events__name(j, pmu->nam=
e));
> +                                       perf_mem_events__name(j, pmu));
>                                 return -1;
>                         }
>
>                         if (perf_pmus__num_mem_pmus() =3D=3D 1) {
>                                 rec_argv[i++] =3D "-e";
> -                               rec_argv[i++] =3D perf_mem_events__name(j=
, NULL);
> +                               rec_argv[i++] =3D perf_mem_events__name(j=
, pmu);
>                         } else {
> -                               const char *s =3D perf_mem_events__name(j=
, pmu->name);
> +                               const char *s =3D perf_mem_events__name(j=
, pmu);
>
>                                 if (!perf_mem_event__supported(mnt, pmu, =
e))
>                                         continue;
> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index 59a4303aac96..d257cf67d6d9 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -14,6 +14,8 @@
>  struct perf_mem_event {
>         bool            record;
>         bool            supported;
> +       bool            ldlat;
> +       u32             aux_event;
>         const char      *tag;
>         const char      *name;
>         const char      *sysfs_name;
> @@ -39,7 +41,6 @@ extern struct perf_mem_event perf_mem_events[PERF_MEM_E=
VENTS__MAX];
>  int perf_mem_events__parse(struct perf_pmu *pmu, const char *str);
>  int perf_mem_events__init(struct perf_pmu *pmu);
>
> -const char *perf_mem_events__name(int i, const char *pmu_name);
>  struct perf_mem_event *perf_mem_events__ptr(struct perf_pmu *pmu, int i)=
;
>  struct perf_pmu *perf_mem_events_find_pmu(void);
>  bool is_mem_loads_aux_event(struct evsel *leader);
> --
> 2.35.1
>
