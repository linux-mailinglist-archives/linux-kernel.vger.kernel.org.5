Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D524807ACD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377290AbjLFVwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377289AbjLFVwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:52:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC2ED68;
        Wed,  6 Dec 2023 13:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701899568; x=1733435568;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RoOrPaC4wGotQYU1+cisz2htXHtd3At/YMH6Wdof7a0=;
  b=V4V/XV/zpWLF9haIRCCRBq6DHAW4lUGqAJkkF771UiDbGd/5Lu7L+nCa
   yzb5t6KmRA3sn+OwfzUjeppUXmHj6cmnsgsmJzuwnaJaksbKok7fQm0jw
   x/QH3i7dwG1/eal8WOTQv1hX0JSZCi3IdXQiqQPADujxT+HY8PA9ojx/k
   2yL0l+tVj0wXlASLlqFXIp1G5p9YRCp69DiTQNuuUlNvqtLUq8KCUItjR
   mJw6UzhlkIItf0YELhtFTxmCcMLG49b9rmZMhRKsCLgkphSdSFDGEYU5k
   JNOiL461hSdCnwMTI300GWiZNv9wP8RATvdhYtPIrytb9lgVLCmBqdzeW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1016642"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1016642"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 13:52:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="800486967"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="800486967"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 13:52:45 -0800
Received: from [10.212.106.4] (kliang2-mobl1.ccr.corp.intel.com [10.212.106.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C1C59580D2D;
        Wed,  6 Dec 2023 13:52:42 -0800 (PST)
Message-ID: <fd94aa97-c18c-43a3-bb86-2f4cd93cae30@linux.intel.com>
Date:   Wed, 6 Dec 2023 16:52:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] perf mem: Clean up perf_mem_events__name()
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        john.g.garry@oracle.com, will@kernel.org, james.clark@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20231206201324.184059-1-kan.liang@linux.intel.com>
 <20231206201324.184059-4-kan.liang@linux.intel.com>
 <CAP-5=fV7MNhTtO6ccPeQ40ZhEOFVmJVe1+cij9tqPeTqhHX_wQ@mail.gmail.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fV7MNhTtO6ccPeQ40ZhEOFVmJVe1+cij9tqPeTqhHX_wQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-12-06 4:07 p.m., Ian Rogers wrote:
> On Wed, Dec 6, 2023 at 12:13 PM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Introduce a generic perf_mem_events__name(). Remove the ARCH-specific
>> one.
>>
>> The mem_load events may have a different format. Add ldlat and aux_event
>> in the struct perf_mem_event to indicate the format and the extra aux
>> event.
>>
>> Add perf_mem_events_intel_aux[] to support the extra mem_load_aux event.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  tools/perf/arch/arm64/util/mem-events.c   | 26 ++-------
>>  tools/perf/arch/powerpc/util/mem-events.c | 13 ++---
>>  tools/perf/arch/powerpc/util/mem-events.h |  7 +++
>>  tools/perf/arch/powerpc/util/pmu.c        | 11 ++++
>>  tools/perf/arch/x86/util/mem-events.c     | 70 +++++------------------
>>  tools/perf/arch/x86/util/mem-events.h     |  1 +
>>  tools/perf/arch/x86/util/pmu.c            |  8 ++-
>>  tools/perf/util/mem-events.c              | 56 ++++++++++++------
>>  tools/perf/util/mem-events.h              |  3 +-
>>  9 files changed, 89 insertions(+), 106 deletions(-)
>>  create mode 100644 tools/perf/arch/powerpc/util/mem-events.h
>>  create mode 100644 tools/perf/arch/powerpc/util/pmu.c
>>
>> diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/arm64/util/mem-events.c
>> index 2602e8688727..eb2ef84f0fc8 100644
>> --- a/tools/perf/arch/arm64/util/mem-events.c
>> +++ b/tools/perf/arch/arm64/util/mem-events.c
>> @@ -2,28 +2,10 @@
>>  #include "map_symbol.h"
>>  #include "mem-events.h"
>>
>> -#define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
>> +#define E(t, n, s, l, a) { .tag = t, .name = n, .sysfs_name = s, .ldlat = l, .aux_event = a }
>>
>>  struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX] = {
>> -       E("spe-load",   "arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=0,min_latency=%u/",       "arm_spe_0"),
>> -       E("spe-store",  "arm_spe_0/ts_enable=1,pa_enable=1,load_filter=0,store_filter=1/",                      "arm_spe_0"),
>> -       E("spe-ldst",   "arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=%u/",       "arm_spe_0"),
>> +       E("spe-load",   "%s/ts_enable=1,pa_enable=1,load_filter=1,store_filter=0,min_latency=%u/",      "arm_spe_0",    true,   0),
>> +       E("spe-store",  "%s/ts_enable=1,pa_enable=1,load_filter=0,store_filter=1/",                     "arm_spe_0",    false,  0),
>> +       E("spe-ldst",   "%s/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=%u/",      "arm_spe_0",    true,   0),
>>  };
>> -
>> -static char mem_ev_name[100];
>> -
>> -const char *perf_mem_events__name(int i, const char *pmu_name __maybe_unused)
>> -{
>> -       struct perf_mem_event *e = &perf_mem_events_arm[i];
>> -
>> -       if (i >= PERF_MEM_EVENTS__MAX)
>> -               return NULL;
>> -
>> -       if (i == PERF_MEM_EVENTS__LOAD || i == PERF_MEM_EVENTS__LOAD_STORE)
>> -               scnprintf(mem_ev_name, sizeof(mem_ev_name),
>> -                         e->name, perf_mem_events__loads_ldlat);
>> -       else /* PERF_MEM_EVENTS__STORE */
>> -               scnprintf(mem_ev_name, sizeof(mem_ev_name), e->name);
>> -
>> -       return mem_ev_name;
>> -}
>> diff --git a/tools/perf/arch/powerpc/util/mem-events.c b/tools/perf/arch/powerpc/util/mem-events.c
>> index 78b986e5268d..b7883e38950f 100644
>> --- a/tools/perf/arch/powerpc/util/mem-events.c
>> +++ b/tools/perf/arch/powerpc/util/mem-events.c
>> @@ -2,11 +2,10 @@
>>  #include "map_symbol.h"
>>  #include "mem-events.h"
>>
>> -/* PowerPC does not support 'ldlat' parameter. */
>> -const char *perf_mem_events__name(int i, const char *pmu_name __maybe_unused)
>> -{
>> -       if (i == PERF_MEM_EVENTS__LOAD)
>> -               return "cpu/mem-loads/";
>> +#define E(t, n, s, l, a) { .tag = t, .name = n, .sysfs_name = s, .ldlat = l, .aux_event = a }
>>
>> -       return "cpu/mem-stores/";
>> -}
>> +struct perf_mem_event perf_mem_events_power[PERF_MEM_EVENTS__MAX] = {
>> +       E("ldlat-loads",        "%s/mem-loads/",        "cpu/events/mem-loads",         false,  0),
>> +       E("ldlat-stores",       "%s/mem-stores/",       "cpu/events/mem-stores",        false,  0),
>> +       E(NULL,                 NULL,                   NULL,                           false,  0),
>> +};
>> diff --git a/tools/perf/arch/powerpc/util/mem-events.h b/tools/perf/arch/powerpc/util/mem-events.h
>> new file mode 100644
>> index 000000000000..6acc3d1b6873
>> --- /dev/null
>> +++ b/tools/perf/arch/powerpc/util/mem-events.h
>> @@ -0,0 +1,7 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _POWER_MEM_EVENTS_H
>> +#define _POWER_MEM_EVENTS_H
>> +
>> +extern struct perf_mem_event perf_mem_events_power[PERF_MEM_EVENTS__MAX];
>> +
>> +#endif /* _POWER_MEM_EVENTS_H */
>> diff --git a/tools/perf/arch/powerpc/util/pmu.c b/tools/perf/arch/powerpc/util/pmu.c
>> new file mode 100644
>> index 000000000000..168173f88ddb
>> --- /dev/null
>> +++ b/tools/perf/arch/powerpc/util/pmu.c
>> @@ -0,0 +1,11 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <string.h>
>> +
>> +#include "../../../util/pmu.h"
>> +
>> +void perf_pmu__arch_init(struct perf_pmu *pmu)
>> +{
>> +       if (pmu->is_core)
>> +               pmu->mem_events = perf_mem_events_power;
>> +}
>> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
>> index 5fb41d50118d..f0e66a0151a0 100644
>> --- a/tools/perf/arch/x86/util/mem-events.c
>> +++ b/tools/perf/arch/x86/util/mem-events.c
>> @@ -7,25 +7,26 @@
>>  #include "linux/string.h"
>>  #include "env.h"
>>
>> -static char mem_loads_name[100];
>> -static bool mem_loads_name__init;
>> -static char mem_stores_name[100];
>> -
>>  #define MEM_LOADS_AUX          0x8203
>> -#define MEM_LOADS_AUX_NAME     "{%s/mem-loads-aux/,%s/mem-loads,ldlat=%u/}:P"
>>
>> -#define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
>> +#define E(t, n, s, l, a) { .tag = t, .name = n, .sysfs_name = s, .ldlat = l, .aux_event = a }
>>
>>  struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX] = {
>> -       E("ldlat-loads",        "%s/mem-loads,ldlat=%u/P",      "%s/events/mem-loads"),
>> -       E("ldlat-stores",       "%s/mem-stores/P",              "%s/events/mem-stores"),
>> -       E(NULL,                 NULL,                           NULL),
>> +       E("ldlat-loads",        "%s/mem-loads,ldlat=%u/P",      "%s/events/mem-loads",  true,   0),
>> +       E("ldlat-stores",       "%s/mem-stores/P",              "%s/events/mem-stores", false,  0),
>> +       E(NULL,                 NULL,                           NULL,                   false,  0),
>> +};
>> +
>> +struct perf_mem_event perf_mem_events_intel_aux[PERF_MEM_EVENTS__MAX] = {
>> +       E("ldlat-loads",        "{%s/mem-loads-aux/,%s/mem-loads,ldlat=%u/}:P", "%s/events/mem-loads",  true,   MEM_LOADS_AUX),
>> +       E("ldlat-stores",       "%s/mem-stores/P",              "%s/events/mem-stores", false,  0),
>> +       E(NULL,                 NULL,                           NULL,                   false,  0),
>>  };
>>
>>  struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
>> -       E(NULL,         NULL,           NULL),
>> -       E(NULL,         NULL,           NULL),
>> -       E("mem-ldst",   "ibs_op//",     "ibs_op"),
>> +       E(NULL,         NULL,           NULL,           false,  0),
>> +       E(NULL,         NULL,           NULL,           false,  0),
>> +       E("mem-ldst",   "%s//",         "ibs_op",       false,  0),
>>  };
>>
>>  bool is_mem_loads_aux_event(struct evsel *leader)
>> @@ -40,48 +41,3 @@ bool is_mem_loads_aux_event(struct evsel *leader)
>>
>>         return leader->core.attr.config == MEM_LOADS_AUX;
>>  }
>> -
>> -const char *perf_mem_events__name(int i, const char *pmu_name)
>> -{
>> -       struct perf_mem_event *e;
>> -
>> -       if (x86__is_amd_cpu())
>> -               e = &perf_mem_events_amd[i];
>> -       else
>> -               e = &perf_mem_events_intel[i];
>> -
>> -       if (!e)
>> -               return NULL;
>> -
>> -       if (i == PERF_MEM_EVENTS__LOAD) {
>> -               if (mem_loads_name__init && !pmu_name)
>> -                       return mem_loads_name;
>> -
>> -               if (!pmu_name) {
>> -                       mem_loads_name__init = true;
>> -                       pmu_name = "cpu";
>> -               }
>> -
>> -               if (perf_pmus__have_event(pmu_name, "mem-loads-aux")) {
>> -                       scnprintf(mem_loads_name, sizeof(mem_loads_name),
>> -                                 MEM_LOADS_AUX_NAME, pmu_name, pmu_name,
>> -                                 perf_mem_events__loads_ldlat);
>> -               } else {
>> -                       scnprintf(mem_loads_name, sizeof(mem_loads_name),
>> -                                 e->name, pmu_name,
>> -                                 perf_mem_events__loads_ldlat);
>> -               }
>> -               return mem_loads_name;
>> -       }
>> -
>> -       if (i == PERF_MEM_EVENTS__STORE) {
>> -               if (!pmu_name)
>> -                       pmu_name = "cpu";
>> -
>> -               scnprintf(mem_stores_name, sizeof(mem_stores_name),
>> -                         e->name, pmu_name);
>> -               return mem_stores_name;
>> -       }
>> -
>> -       return e->name;
>> -}
>> diff --git a/tools/perf/arch/x86/util/mem-events.h b/tools/perf/arch/x86/util/mem-events.h
>> index 3959e427f482..f55c8d3b7d59 100644
>> --- a/tools/perf/arch/x86/util/mem-events.h
>> +++ b/tools/perf/arch/x86/util/mem-events.h
>> @@ -3,6 +3,7 @@
>>  #define _X86_MEM_EVENTS_H
>>
>>  extern struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX];
>> +extern struct perf_mem_event perf_mem_events_intel_aux[PERF_MEM_EVENTS__MAX];
>>
>>  extern struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX];
>>
>> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
>> index 7e69f4f2e363..446f8197aae4 100644
>> --- a/tools/perf/arch/x86/util/pmu.c
>> +++ b/tools/perf/arch/x86/util/pmu.c
>> @@ -35,8 +35,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
>>         if (x86__is_amd_cpu()) {
>>                 if (strcmp(pmu->name, "ibs_op"))
>>                         pmu->mem_events = perf_mem_events_amd;
>> -       } else if (pmu->is_core)
>> -               pmu->mem_events = perf_mem_events_intel;
>> +       } else if (pmu->is_core) {
>> +               if (perf_pmu__have_event(pmu, "mem-loads-aux"))
>> +                       pmu->mem_events = perf_mem_events_intel_aux;
>> +               else
>> +                       pmu->mem_events = perf_mem_events_intel;
>> +       }
>>  }
>>
>>  int perf_pmus__num_mem_pmus(void)
>> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
>> index 887ffdcce338..3a60cbcd6d8e 100644
>> --- a/tools/perf/util/mem-events.c
>> +++ b/tools/perf/util/mem-events.c
>> @@ -17,17 +17,17 @@
>>
>>  unsigned int perf_mem_events__loads_ldlat = 30;
>>
>> -#define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
>> +#define E(t, n, s, l, a) { .tag = t, .name = n, .sysfs_name = s, .ldlat = l, .aux_event = a }
>>
>>  struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
>> -       E("ldlat-loads",        "cpu/mem-loads,ldlat=%u/P",     "cpu/events/mem-loads"),
>> -       E("ldlat-stores",       "cpu/mem-stores/P",             "cpu/events/mem-stores"),
>> -       E(NULL,                 NULL,                           NULL),
>> +       E("ldlat-loads",        "%s/mem-loads/,ldlat=%u/P",     "cpu/events/mem-loads",         true,   0),
> 
> Is there a mistake here "/," looks like it should just be ",".

Right, a typo. I will fix it in V2.

Thanks,
Kan
> 
> Thanks,
> Ian
> 
>> +       E("ldlat-stores",       "%s/mem-stores/P",              "cpu/events/mem-stores",        false,  0),
>> +       E(NULL,                 NULL,                           NULL,                           false,  0),
>>  };
>>  #undef E
>>
>>  static char mem_loads_name[100];
>> -static bool mem_loads_name__init;
>> +static char mem_stores_name[100];
>>
>>  struct perf_mem_event *perf_mem_events__ptr(struct perf_pmu *pmu, int i)
>>  {
>> @@ -62,23 +62,45 @@ struct perf_pmu *perf_mem_events_find_pmu(void)
>>         return perf_pmus__scan_mem(NULL);
>>  }
>>
>> -const char * __weak perf_mem_events__name(int i, const char *pmu_name  __maybe_unused)
>> +static const char *perf_mem_events__name(int i, struct perf_pmu *pmu)
>>  {
>> -       struct perf_mem_event *e = &perf_mem_events[i];
>> +       struct perf_mem_event *e = &pmu->mem_events[i];
>>
>>         if (!e)
>>                 return NULL;
>>
>> -       if (i == PERF_MEM_EVENTS__LOAD) {
>> -               if (!mem_loads_name__init) {
>> -                       mem_loads_name__init = true;
>> -                       scnprintf(mem_loads_name, sizeof(mem_loads_name),
>> -                                 e->name, perf_mem_events__loads_ldlat);
>> +       if (i == PERF_MEM_EVENTS__LOAD || i == PERF_MEM_EVENTS__LOAD_STORE) {
>> +               if (e->ldlat) {
>> +                       if (!e->aux_event) {
>> +                               /* ARM and Most of Intel */
>> +                               scnprintf(mem_loads_name, sizeof(mem_loads_name),
>> +                                         e->name, pmu->name,
>> +                                         perf_mem_events__loads_ldlat);
>> +                       } else {
>> +                               /* Intel with mem-loads-aux event */
>> +                               scnprintf(mem_loads_name, sizeof(mem_loads_name),
>> +                                         e->name, pmu->name, pmu->name,
>> +                                         perf_mem_events__loads_ldlat);
>> +                       }
>> +               } else {
>> +                       if (!e->aux_event) {
>> +                               /* AMD and POWER */
>> +                               scnprintf(mem_loads_name, sizeof(mem_loads_name),
>> +                                         e->name, pmu->name);
>> +                       } else
>> +                               return NULL;
>>                 }
>> +
>>                 return mem_loads_name;
>>         }
>>
>> -       return e->name;
>> +       if (i == PERF_MEM_EVENTS__STORE) {
>> +               scnprintf(mem_stores_name, sizeof(mem_stores_name),
>> +                         e->name, pmu->name);
>> +               return mem_stores_name;
>> +       }
>> +
>> +       return NULL;
>>  }
>>
>>  __weak bool is_mem_loads_aux_event(struct evsel *leader __maybe_unused)
>> @@ -175,7 +197,7 @@ void perf_mem_events__list(struct perf_pmu *pmu)
>>                         e->tag ? 13 : 0,
>>                         e->tag ? : "",
>>                         e->tag && verbose > 0 ? 25 : 0,
>> -                       e->tag && verbose > 0 ? perf_mem_events__name(j, NULL) : "",
>> +                       e->tag && verbose > 0 ? perf_mem_events__name(j, pmu) : "",
>>                         e->supported ? ": available\n" : "");
>>         }
>>  }
>> @@ -198,15 +220,15 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
>>
>>                         if (!e->supported) {
>>                                 pr_err("failed: event '%s' not supported\n",
>> -                                       perf_mem_events__name(j, pmu->name));
>> +                                       perf_mem_events__name(j, pmu));
>>                                 return -1;
>>                         }
>>
>>                         if (perf_pmus__num_mem_pmus() == 1) {
>>                                 rec_argv[i++] = "-e";
>> -                               rec_argv[i++] = perf_mem_events__name(j, NULL);
>> +                               rec_argv[i++] = perf_mem_events__name(j, pmu);
>>                         } else {
>> -                               const char *s = perf_mem_events__name(j, pmu->name);
>> +                               const char *s = perf_mem_events__name(j, pmu);
>>
>>                                 if (!perf_mem_event__supported(mnt, pmu, e))
>>                                         continue;
>> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
>> index 59a4303aac96..d257cf67d6d9 100644
>> --- a/tools/perf/util/mem-events.h
>> +++ b/tools/perf/util/mem-events.h
>> @@ -14,6 +14,8 @@
>>  struct perf_mem_event {
>>         bool            record;
>>         bool            supported;
>> +       bool            ldlat;
>> +       u32             aux_event;
>>         const char      *tag;
>>         const char      *name;
>>         const char      *sysfs_name;
>> @@ -39,7 +41,6 @@ extern struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX];
>>  int perf_mem_events__parse(struct perf_pmu *pmu, const char *str);
>>  int perf_mem_events__init(struct perf_pmu *pmu);
>>
>> -const char *perf_mem_events__name(int i, const char *pmu_name);
>>  struct perf_mem_event *perf_mem_events__ptr(struct perf_pmu *pmu, int i);
>>  struct perf_pmu *perf_mem_events_find_pmu(void);
>>  bool is_mem_loads_aux_event(struct evsel *leader);
>> --
>> 2.35.1
>>
