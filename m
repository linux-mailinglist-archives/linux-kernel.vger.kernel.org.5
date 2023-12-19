Return-Path: <linux-kernel+bounces-4921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 301508183D9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A60D1F22BBE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E660D12B8F;
	Tue, 19 Dec 2023 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JUXeBQVY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A220513AFC;
	Tue, 19 Dec 2023 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ8jxaP025229;
	Tue, 19 Dec 2023 08:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mERsX5DVghWe7Cby9Tl5RfxFrUohW4KW8CsEVitxVMk=;
 b=JUXeBQVYAM57hhLBrEZfqoVfXilBauPw2K68VTwnCssipseEFTmE1XpFj7k2MU59uNz8
 iMWMz/4kbxXSHy9cPJvxo1K9Xo4DeVoLwGLc/StsX6OJK5Z1/JRzS0DFhT0z4ubn+dRp
 DQtPow+hYU4QKqnxAKdQZTQWkURTlMWAIu//3Vfa53uOqncls32XGbXeFGOh0FNM7L94
 lVVbe64M8qr2htiHM5c/cCNHqvqLeFdp0B9ZVksQOev2Oan4YKbsffUszSzTX0Lwf1gS
 daMB9vwmBOHiAtBzCllIr6vSjTj2biSfhnmcR0ujWOaM2vFdRKZ+H0/hiBn7MkG5zUpw ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v373c9mbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 08:48:51 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJ8k8om026654;
	Tue, 19 Dec 2023 08:48:50 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v373c9mb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 08:48:50 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJ8Z92K027072;
	Tue, 19 Dec 2023 08:48:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v1rejx3hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 08:48:49 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BJ8mlMl44237490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 08:48:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B50A20043;
	Tue, 19 Dec 2023 08:48:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD35620040;
	Tue, 19 Dec 2023 08:48:42 +0000 (GMT)
Received: from [9.179.31.204] (unknown [9.179.31.204])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Dec 2023 08:48:42 +0000 (GMT)
Message-ID: <4b465a74-a991-3612-096c-18d430ea2734@linux.ibm.com>
Date: Tue, 19 Dec 2023 14:18:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V3 1/7] perf mem: Add mem_events into the supported
 perf_pmu
To: kan.liang@linux.intel.com, acme@kernel.org, irogers@google.com,
        peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
        jolsa@kernel.org, adrian.hunter@intel.com, john.g.garry@oracle.com,
        will@kernel.org, james.clark@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, yuhaixin.yhx@linux.alibaba.com,
        renyu.zj@linux.alibaba.com, tmricht@linux.ibm.com,
        ravi.bangoria@amd.com, atrajeev@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20231213195154.1085945-1-kan.liang@linux.intel.com>
 <20231213195154.1085945-2-kan.liang@linux.intel.com>
Content-Language: en-US
From: kajoljain <kjain@linux.ibm.com>
In-Reply-To: <20231213195154.1085945-2-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 377YIRE0M6t9xPsqwI3CHb9kRx5tSM7R
X-Proofpoint-GUID: SikFQ6ouO1968zFvYYKfN7OvtTU2T1QQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_04,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 phishscore=0 adultscore=0
 impostorscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312190064

Patch looks fine to me.

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
Tested-by: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain

On 12/14/23 01:21, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> With the mem_events, perf doesn't need to read sysfs for each PMU to
> find the mem-events-supported PMU. The patch also makes it possible to
> clean up the related __weak functions later.
> 
> The patch is only to add the mem_events into the perf_pmu for all ARCHs.
> It will be used in the later cleanup patches.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Suggested-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/arch/arm/util/pmu.c          | 3 +++
>  tools/perf/arch/arm64/util/mem-events.c | 7 ++++---
>  tools/perf/arch/arm64/util/mem-events.h | 7 +++++++
>  tools/perf/arch/s390/util/pmu.c         | 3 +++
>  tools/perf/arch/x86/util/mem-events.c   | 4 ++--
>  tools/perf/arch/x86/util/mem-events.h   | 9 +++++++++
>  tools/perf/arch/x86/util/pmu.c          | 7 +++++++
>  tools/perf/util/mem-events.c            | 2 +-
>  tools/perf/util/mem-events.h            | 1 +
>  tools/perf/util/pmu.c                   | 4 +++-
>  tools/perf/util/pmu.h                   | 7 +++++++
>  11 files changed, 47 insertions(+), 7 deletions(-)
>  create mode 100644 tools/perf/arch/arm64/util/mem-events.h
>  create mode 100644 tools/perf/arch/x86/util/mem-events.h
> 
> diff --git a/tools/perf/arch/arm/util/pmu.c b/tools/perf/arch/arm/util/pmu.c
> index 7f3af3b97f3b..8b7cb68ba1a8 100644
> --- a/tools/perf/arch/arm/util/pmu.c
> +++ b/tools/perf/arch/arm/util/pmu.c
> @@ -13,6 +13,7 @@
>  #include "hisi-ptt.h"
>  #include "../../../util/pmu.h"
>  #include "../../../util/cs-etm.h"
> +#include "../../arm64/util/mem-events.h"
>  
>  void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
>  {
> @@ -26,6 +27,8 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
>  		pmu->selectable = true;
>  		pmu->is_uncore = false;
>  		pmu->perf_event_attr_init_default = arm_spe_pmu_default_config;
> +		if (!strcmp(pmu->name, "arm_spe_0"))
> +			pmu->mem_events = perf_mem_events_arm;
>  	} else if (strstarts(pmu->name, HISI_PTT_PMU_NAME)) {
>  		pmu->selectable = true;
>  #endif
> diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/arm64/util/mem-events.c
> index 3bcc5c7035c2..edf8207f7812 100644
> --- a/tools/perf/arch/arm64/util/mem-events.c
> +++ b/tools/perf/arch/arm64/util/mem-events.c
> @@ -1,10 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include "map_symbol.h"
> +#include "util/map_symbol.h"
> +#include "util/mem-events.h"
>  #include "mem-events.h"
>  
>  #define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
>  
> -static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
> +struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX] = {
>  	E("spe-load",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=0,min_latency=%u/",	"arm_spe_0"),
>  	E("spe-store",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=0,store_filter=1/",			"arm_spe_0"),
>  	E("spe-ldst",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=%u/",	"arm_spe_0"),
> @@ -17,7 +18,7 @@ struct perf_mem_event *perf_mem_events__ptr(int i)
>  	if (i >= PERF_MEM_EVENTS__MAX)
>  		return NULL;
>  
> -	return &perf_mem_events[i];
> +	return &perf_mem_events_arm[i];
>  }
>  
>  const char *perf_mem_events__name(int i, const char *pmu_name __maybe_unused)
> diff --git a/tools/perf/arch/arm64/util/mem-events.h b/tools/perf/arch/arm64/util/mem-events.h
> new file mode 100644
> index 000000000000..5fc50be4be38
> --- /dev/null
> +++ b/tools/perf/arch/arm64/util/mem-events.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ARM64_MEM_EVENTS_H
> +#define _ARM64_MEM_EVENTS_H
> +
> +extern struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX];
> +
> +#endif /* _ARM64_MEM_EVENTS_H */
> diff --git a/tools/perf/arch/s390/util/pmu.c b/tools/perf/arch/s390/util/pmu.c
> index 886c30e001fa..225d7dc2379c 100644
> --- a/tools/perf/arch/s390/util/pmu.c
> +++ b/tools/perf/arch/s390/util/pmu.c
> @@ -19,4 +19,7 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>  	    !strcmp(pmu->name, S390_PMUPAI_EXT) ||
>  	    !strcmp(pmu->name, S390_PMUCPUM_CF))
>  		pmu->selectable = true;
> +
> +	if (pmu->is_core)
> +		pmu->mem_events = perf_mem_events;
>  }
> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
> index 191b372f9a2d..2b81d229982c 100644
> --- a/tools/perf/arch/x86/util/mem-events.c
> +++ b/tools/perf/arch/x86/util/mem-events.c
> @@ -16,13 +16,13 @@ static char mem_stores_name[100];
>  
>  #define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
>  
> -static struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX] = {
> +struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX] = {
>  	E("ldlat-loads",	"%s/mem-loads,ldlat=%u/P",	"%s/events/mem-loads"),
>  	E("ldlat-stores",	"%s/mem-stores/P",		"%s/events/mem-stores"),
>  	E(NULL,			NULL,				NULL),
>  };
>  
> -static struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
> +struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
>  	E(NULL,		NULL,		NULL),
>  	E(NULL,		NULL,		NULL),
>  	E("mem-ldst",	"ibs_op//",	"ibs_op"),
> diff --git a/tools/perf/arch/x86/util/mem-events.h b/tools/perf/arch/x86/util/mem-events.h
> new file mode 100644
> index 000000000000..3959e427f482
> --- /dev/null
> +++ b/tools/perf/arch/x86/util/mem-events.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _X86_MEM_EVENTS_H
> +#define _X86_MEM_EVENTS_H
> +
> +extern struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX];
> +
> +extern struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX];
> +
> +#endif /* _X86_MEM_EVENTS_H */
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
> index 469555ae9b3c..cd22e80e5657 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -15,6 +15,7 @@
>  #include "../../../util/pmu.h"
>  #include "../../../util/fncache.h"
>  #include "../../../util/pmus.h"
> +#include "mem-events.h"
>  #include "env.h"
>  
>  void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
> @@ -30,6 +31,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
>  		pmu->selectable = true;
>  	}
>  #endif
> +
> +	if (x86__is_amd_cpu()) {
> +		if (!strcmp(pmu->name, "ibs_op"))
> +			pmu->mem_events = perf_mem_events_amd;
> +	} else if (pmu->is_core)
> +		pmu->mem_events = perf_mem_events_intel;
>  }
>  
>  int perf_pmus__num_mem_pmus(void)
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 3a2e3687878c..0a8f415f5efe 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -19,7 +19,7 @@ unsigned int perf_mem_events__loads_ldlat = 30;
>  
>  #define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
>  
> -static struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
> +struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
>  	E("ldlat-loads",	"cpu/mem-loads,ldlat=%u/P",	"cpu/events/mem-loads"),
>  	E("ldlat-stores",	"cpu/mem-stores/P",		"cpu/events/mem-stores"),
>  	E(NULL,			NULL,				NULL),
> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index b40ad6ea93fc..8c5694b2d0b0 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -34,6 +34,7 @@ enum {
>  };
>  
>  extern unsigned int perf_mem_events__loads_ldlat;
> +extern struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX];
>  
>  int perf_mem_events__parse(const char *str);
>  int perf_mem_events__init(void);
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 3c9609944a2f..3d4373b8ab63 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -986,8 +986,10 @@ static int pmu_max_precise(int dirfd, struct perf_pmu *pmu)
>  }
>  
>  void __weak
> -perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
> +perf_pmu__arch_init(struct perf_pmu *pmu)
>  {
> +	if (pmu->is_core)
> +		pmu->mem_events = perf_mem_events;
>  }
>  
>  struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *name)
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 424c3fee0949..e35d985206db 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -10,6 +10,8 @@
>  #include <stdio.h>
>  #include "parse-events.h"
>  #include "pmu-events/pmu-events.h"
> +#include "map_symbol.h"
> +#include "mem-events.h"
>  
>  struct evsel_config_term;
>  struct perf_cpu_map;
> @@ -162,6 +164,11 @@ struct perf_pmu {
>  		 */
>  		bool exclude_guest;
>  	} missing_features;
> +
> +	/**
> +	 * @mem_events: List of the supported mem events
> +	 */
> +	struct perf_mem_event *mem_events;
>  };
>  
>  /** @perf_pmu__fake: A special global PMU used for testing. */

