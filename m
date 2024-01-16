Return-Path: <linux-kernel+bounces-27441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D91F82F015
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E853A285DC1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871F71BDDF;
	Tue, 16 Jan 2024 13:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VFLNbZ7C"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5811BDD6;
	Tue, 16 Jan 2024 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40GDqkjn004203;
	Tue, 16 Jan 2024 13:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XL7+1ap6qXm2xK7MB5f/mj73Z9WxxIqLIXezQnVxh2c=;
 b=VFLNbZ7CYrC856nVrwAx25iF9PHxti0R7ip0G+o0mH11F8fIfXNf9exquWSknf0q2Gfs
 tUtWXU135y2nRoL/Wn0+KJkC9UjLNIKZZ/FmD9yuYART6e0TilMtqxqkRPpXXA9BqN/R
 1Xspy9gtXgjGY/h1rxM+Zfpdd1KOKSxFUaMfBhAToHoKrcimLQ80+e89NXG5vcILQGSW
 2FTCi3vfj+/5VS/g+jSsP9hKgpnQKcV3BKB0/tWR2QiUpHW4OHEKA+s+LQlse2RqmyDz
 WFcpx2v0vxTGZMaLkhzc32rQ1AEs+u+WopzkARUgVrKYK3GbiIRBTk9iOba/UGicH2wY og== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vnu2jg5hy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 13:59:09 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40GDsiU9011857;
	Tue, 16 Jan 2024 13:59:09 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vnu2jg5h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 13:59:08 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40GDUhoP019545;
	Tue, 16 Jan 2024 13:59:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm72jxkc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 13:59:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40GDx5qq43254056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 13:59:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A62BD20040;
	Tue, 16 Jan 2024 13:59:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04B642004B;
	Tue, 16 Jan 2024 13:59:00 +0000 (GMT)
Received: from [9.171.45.131] (unknown [9.171.45.131])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jan 2024 13:58:59 +0000 (GMT)
Message-ID: <d0889638-38f4-ab9c-bc1b-27efd68b3a15@linux.ibm.com>
Date: Tue, 16 Jan 2024 19:28:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V3 3/7] perf mem: Clean up perf_mem_events__name()
Content-Language: en-US
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
 <20231213195154.1085945-4-kan.liang@linux.intel.com>
From: kajoljain <kjain@linux.ibm.com>
In-Reply-To: <20231213195154.1085945-4-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IiBvvvdGVjEWaN7BcpmxggVDTbdFwABa
X-Proofpoint-GUID: ZMVbbCCUxjuc3HOg-da-R2ro9INZljtp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_08,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401160110

Hi Kan,
  With this patch perf mem is failing in powerpc with below error:

[command]# ./perf mem record ls
event syntax error: '../mem-loads,ldlat=30/P'
                                  \___ Bad event or PMU

Unable to find PMU or event on a PMU of 'cpu'

Initial error:
event syntax error: '../mem-loads,ldlat=30/P'
                                  \___ unknown term 'ldlat' for pmu 'cpu'

This issue is happening as powerpc doesn't support ldlat parameter. And
this patch missing build of pmu.c file.

I am able to fix build and ldlat issue with below changes:

diff --git a/tools/perf/arch/powerpc/util/Build
b/tools/perf/arch/powerpc/util/Build
index 9889245c555c..1d323f3a3322 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -2,6 +2,7 @@ perf-y += header.o
 perf-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
 perf-y += perf_regs.o
 perf-y += mem-events.o
+perf-y += pmu.o
 perf-y += sym-handling.o
 perf-y += evsel.o
 perf-y += event.o
diff --git a/tools/perf/arch/powerpc/util/mem-events.c
b/tools/perf/arch/powerpc/util/mem-events.c
index b7883e38950f..9140cdb1bbfb 100644
--- a/tools/perf/arch/powerpc/util/mem-events.c
+++ b/tools/perf/arch/powerpc/util/mem-events.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "map_symbol.h"
+#include "util/map_symbol.h"
+#include "util/mem-events.h"
 #include "mem-events.h"

 #define E(t, n, s, l, a) { .tag = t, .name = n, .sysfs_name = s, .ldlat
= l, .aux_event = a }
diff --git a/tools/perf/arch/powerpc/util/pmu.c
b/tools/perf/arch/powerpc/util/pmu.c
index 168173f88ddb..554675deef7b 100644
--- a/tools/perf/arch/powerpc/util/pmu.c
+++ b/tools/perf/arch/powerpc/util/pmu.c
@@ -3,6 +3,7 @@
 #include <string.h>

 #include "../../../util/pmu.h"
+#include "mem-events.h"

 void perf_pmu__arch_init(struct perf_pmu *pmu)
 {

Thanks,
Kajol Jain


On 12/14/23 01:21, kan.liang@linux.intel.com wrote:
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
> Rename perf_mem_events__name to perf_pmu__mem_events_name.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/arch/arm64/util/mem-events.c   | 26 ++-------
>  tools/perf/arch/powerpc/util/mem-events.c | 13 ++---
>  tools/perf/arch/powerpc/util/mem-events.h |  7 +++
>  tools/perf/arch/powerpc/util/pmu.c        | 11 ++++
>  tools/perf/arch/x86/util/mem-events.c     | 70 +++++------------------
>  tools/perf/arch/x86/util/mem-events.h     |  1 +
>  tools/perf/arch/x86/util/pmu.c            |  8 ++-
>  tools/perf/util/mem-events.c              | 60 +++++++++++++------
>  tools/perf/util/mem-events.h              |  3 +-
>  9 files changed, 93 insertions(+), 106 deletions(-)
>  create mode 100644 tools/perf/arch/powerpc/util/mem-events.h
>  create mode 100644 tools/perf/arch/powerpc/util/pmu.c
> 
> diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/arm64/util/mem-events.c
> index d3e69a520c2b..96460c46640a 100644
> --- a/tools/perf/arch/arm64/util/mem-events.c
> +++ b/tools/perf/arch/arm64/util/mem-events.c
> @@ -3,28 +3,10 @@
>  #include "util/mem-events.h"
>  #include "mem-events.h"
>  
> -#define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
> +#define E(t, n, s, l, a) { .tag = t, .name = n, .sysfs_name = s, .ldlat = l, .aux_event = a }
>  
>  struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX] = {
> -	E("spe-load",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=0,min_latency=%u/",	"arm_spe_0"),
> -	E("spe-store",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=0,store_filter=1/",			"arm_spe_0"),
> -	E("spe-ldst",	"arm_spe_0/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=%u/",	"arm_spe_0"),
> +	E("spe-load",	"%s/ts_enable=1,pa_enable=1,load_filter=1,store_filter=0,min_latency=%u/",	"arm_spe_0",	true,	0),
> +	E("spe-store",	"%s/ts_enable=1,pa_enable=1,load_filter=0,store_filter=1/",			"arm_spe_0",	false,	0),
> +	E("spe-ldst",	"%s/ts_enable=1,pa_enable=1,load_filter=1,store_filter=1,min_latency=%u/",	"arm_spe_0",	true,	0),
>  };
> -
> -static char mem_ev_name[100];
> -
> -const char *perf_mem_events__name(int i, const char *pmu_name __maybe_unused)
> -{
> -	struct perf_mem_event *e = &perf_mem_events_arm[i];
> -
> -	if (i >= PERF_MEM_EVENTS__MAX)
> -		return NULL;
> -
> -	if (i == PERF_MEM_EVENTS__LOAD || i == PERF_MEM_EVENTS__LOAD_STORE)
> -		scnprintf(mem_ev_name, sizeof(mem_ev_name),
> -			  e->name, perf_mem_events__loads_ldlat);
> -	else /* PERF_MEM_EVENTS__STORE */
> -		scnprintf(mem_ev_name, sizeof(mem_ev_name), e->name);
> -
> -	return mem_ev_name;
> -}
> diff --git a/tools/perf/arch/powerpc/util/mem-events.c b/tools/perf/arch/powerpc/util/mem-events.c
> index 78b986e5268d..b7883e38950f 100644
> --- a/tools/perf/arch/powerpc/util/mem-events.c
> +++ b/tools/perf/arch/powerpc/util/mem-events.c
> @@ -2,11 +2,10 @@
>  #include "map_symbol.h"
>  #include "mem-events.h"
>  
> -/* PowerPC does not support 'ldlat' parameter. */
> -const char *perf_mem_events__name(int i, const char *pmu_name __maybe_unused)
> -{
> -	if (i == PERF_MEM_EVENTS__LOAD)
> -		return "cpu/mem-loads/";
> +#define E(t, n, s, l, a) { .tag = t, .name = n, .sysfs_name = s, .ldlat = l, .aux_event = a }
>  
> -	return "cpu/mem-stores/";
> -}
> +struct perf_mem_event perf_mem_events_power[PERF_MEM_EVENTS__MAX] = {
> +	E("ldlat-loads",	"%s/mem-loads/",	"cpu/events/mem-loads",		false,	0),
> +	E("ldlat-stores",	"%s/mem-stores/",	"cpu/events/mem-stores",	false,	0),
> +	E(NULL,			NULL,			NULL,				false,	0),
> +};
> diff --git a/tools/perf/arch/powerpc/util/mem-events.h b/tools/perf/arch/powerpc/util/mem-events.h
> new file mode 100644
> index 000000000000..6acc3d1b6873
> --- /dev/null
> +++ b/tools/perf/arch/powerpc/util/mem-events.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _POWER_MEM_EVENTS_H
> +#define _POWER_MEM_EVENTS_H
> +
> +extern struct perf_mem_event perf_mem_events_power[PERF_MEM_EVENTS__MAX];
> +
> +#endif /* _POWER_MEM_EVENTS_H */
> diff --git a/tools/perf/arch/powerpc/util/pmu.c b/tools/perf/arch/powerpc/util/pmu.c
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
> +	if (pmu->is_core)
> +		pmu->mem_events = perf_mem_events_power;
> +}
> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
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
>  #define MEM_LOADS_AUX		0x8203
> -#define MEM_LOADS_AUX_NAME     "{%s/mem-loads-aux/,%s/mem-loads,ldlat=%u/}:P"
>  
> -#define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
> +#define E(t, n, s, l, a) { .tag = t, .name = n, .sysfs_name = s, .ldlat = l, .aux_event = a }
>  
>  struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX] = {
> -	E("ldlat-loads",	"%s/mem-loads,ldlat=%u/P",	"%s/events/mem-loads"),
> -	E("ldlat-stores",	"%s/mem-stores/P",		"%s/events/mem-stores"),
> -	E(NULL,			NULL,				NULL),
> +	E("ldlat-loads",	"%s/mem-loads,ldlat=%u/P",	"%s/events/mem-loads",	true,	0),
> +	E("ldlat-stores",	"%s/mem-stores/P",		"%s/events/mem-stores",	false,	0),
> +	E(NULL,			NULL,				NULL,			false,	0),
> +};
> +
> +struct perf_mem_event perf_mem_events_intel_aux[PERF_MEM_EVENTS__MAX] = {
> +	E("ldlat-loads",	"{%s/mem-loads-aux/,%s/mem-loads,ldlat=%u/}:P",	"%s/events/mem-loads",	true,	MEM_LOADS_AUX),
> +	E("ldlat-stores",	"%s/mem-stores/P",		"%s/events/mem-stores",	false,	0),
> +	E(NULL,			NULL,				NULL,			false,	0),
>  };
>  
>  struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
> -	E(NULL,		NULL,		NULL),
> -	E(NULL,		NULL,		NULL),
> -	E("mem-ldst",	"ibs_op//",	"ibs_op"),
> +	E(NULL,		NULL,		NULL,		false,	0),
> +	E(NULL,		NULL,		NULL,		false,	0),
> +	E("mem-ldst",	"%s//",		"ibs_op",	false,	0),
>  };
>  
>  bool is_mem_loads_aux_event(struct evsel *leader)
> @@ -40,48 +41,3 @@ bool is_mem_loads_aux_event(struct evsel *leader)
>  
>  	return leader->core.attr.config == MEM_LOADS_AUX;
>  }
> -
> -const char *perf_mem_events__name(int i, const char *pmu_name)
> -{
> -	struct perf_mem_event *e;
> -
> -	if (x86__is_amd_cpu())
> -		e = &perf_mem_events_amd[i];
> -	else
> -		e = &perf_mem_events_intel[i];
> -
> -	if (!e)
> -		return NULL;
> -
> -	if (i == PERF_MEM_EVENTS__LOAD) {
> -		if (mem_loads_name__init && !pmu_name)
> -			return mem_loads_name;
> -
> -		if (!pmu_name) {
> -			mem_loads_name__init = true;
> -			pmu_name = "cpu";
> -		}
> -
> -		if (perf_pmus__have_event(pmu_name, "mem-loads-aux")) {
> -			scnprintf(mem_loads_name, sizeof(mem_loads_name),
> -				  MEM_LOADS_AUX_NAME, pmu_name, pmu_name,
> -				  perf_mem_events__loads_ldlat);
> -		} else {
> -			scnprintf(mem_loads_name, sizeof(mem_loads_name),
> -				  e->name, pmu_name,
> -				  perf_mem_events__loads_ldlat);
> -		}
> -		return mem_loads_name;
> -	}
> -
> -	if (i == PERF_MEM_EVENTS__STORE) {
> -		if (!pmu_name)
> -			pmu_name = "cpu";
> -
> -		scnprintf(mem_stores_name, sizeof(mem_stores_name),
> -			  e->name, pmu_name);
> -		return mem_stores_name;
> -	}
> -
> -	return e->name;
> -}
> diff --git a/tools/perf/arch/x86/util/mem-events.h b/tools/perf/arch/x86/util/mem-events.h
> index 3959e427f482..f55c8d3b7d59 100644
> --- a/tools/perf/arch/x86/util/mem-events.h
> +++ b/tools/perf/arch/x86/util/mem-events.h
> @@ -3,6 +3,7 @@
>  #define _X86_MEM_EVENTS_H
>  
>  extern struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX];
> +extern struct perf_mem_event perf_mem_events_intel_aux[PERF_MEM_EVENTS__MAX];
>  
>  extern struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX];
>  
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
> index cd22e80e5657..0f49ff13cfe2 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -35,8 +35,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
>  	if (x86__is_amd_cpu()) {
>  		if (!strcmp(pmu->name, "ibs_op"))
>  			pmu->mem_events = perf_mem_events_amd;
> -	} else if (pmu->is_core)
> -		pmu->mem_events = perf_mem_events_intel;
> +	} else if (pmu->is_core) {
> +		if (perf_pmu__have_event(pmu, "mem-loads-aux"))
> +			pmu->mem_events = perf_mem_events_intel_aux;
> +		else
> +			pmu->mem_events = perf_mem_events_intel;
> +	}
>  }
>  
>  int perf_pmus__num_mem_pmus(void)
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 27a33dc44964..51e53e33df03 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -17,17 +17,17 @@
>  
>  unsigned int perf_mem_events__loads_ldlat = 30;
>  
> -#define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
> +#define E(t, n, s, l, a) { .tag = t, .name = n, .sysfs_name = s, .ldlat = l, .aux_event = a }
>  
>  struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
> -	E("ldlat-loads",	"cpu/mem-loads,ldlat=%u/P",	"cpu/events/mem-loads"),
> -	E("ldlat-stores",	"cpu/mem-stores/P",		"cpu/events/mem-stores"),
> -	E(NULL,			NULL,				NULL),
> +	E("ldlat-loads",	"%s/mem-loads,ldlat=%u/P",	"cpu/events/mem-loads",		true,	0),
> +	E("ldlat-stores",	"%s/mem-stores/P",		"cpu/events/mem-stores",	false,	0),
> +	E(NULL,			NULL,				NULL,				false,	0),
>  };
>  #undef E
>  
>  static char mem_loads_name[100];
> -static bool mem_loads_name__init;
> +static char mem_stores_name[100];
>  
>  struct perf_mem_event *perf_pmu__mem_events_ptr(struct perf_pmu *pmu, int i)
>  {
> @@ -62,23 +62,49 @@ struct perf_pmu *perf_mem_events_find_pmu(void)
>  	return perf_pmus__scan_mem(NULL);
>  }
>  
> -const char * __weak perf_mem_events__name(int i, const char *pmu_name  __maybe_unused)
> +static const char *perf_pmu__mem_events_name(int i, struct perf_pmu *pmu)
>  {
> -	struct perf_mem_event *e = &perf_mem_events[i];
> +	struct perf_mem_event *e;
>  
> +	if (i >= PERF_MEM_EVENTS__MAX || !pmu)
> +		return NULL;
> +
> +	e = &pmu->mem_events[i];
>  	if (!e)
>  		return NULL;
>  
> -	if (i == PERF_MEM_EVENTS__LOAD) {
> -		if (!mem_loads_name__init) {
> -			mem_loads_name__init = true;
> -			scnprintf(mem_loads_name, sizeof(mem_loads_name),
> -				  e->name, perf_mem_events__loads_ldlat);
> +	if (i == PERF_MEM_EVENTS__LOAD || i == PERF_MEM_EVENTS__LOAD_STORE) {
> +		if (e->ldlat) {
> +			if (!e->aux_event) {
> +				/* ARM and Most of Intel */
> +				scnprintf(mem_loads_name, sizeof(mem_loads_name),
> +					  e->name, pmu->name,
> +					  perf_mem_events__loads_ldlat);
> +			} else {
> +				/* Intel with mem-loads-aux event */
> +				scnprintf(mem_loads_name, sizeof(mem_loads_name),
> +					  e->name, pmu->name, pmu->name,
> +					  perf_mem_events__loads_ldlat);
> +			}
> +		} else {
> +			if (!e->aux_event) {
> +				/* AMD and POWER */
> +				scnprintf(mem_loads_name, sizeof(mem_loads_name),
> +					  e->name, pmu->name);
> +			} else
> +				return NULL;
>  		}
> +
>  		return mem_loads_name;
>  	}
>  
> -	return e->name;
> +	if (i == PERF_MEM_EVENTS__STORE) {
> +		scnprintf(mem_stores_name, sizeof(mem_stores_name),
> +			  e->name, pmu->name);
> +		return mem_stores_name;
> +	}
> +
> +	return NULL;
>  }
>  
>  __weak bool is_mem_loads_aux_event(struct evsel *leader __maybe_unused)
> @@ -175,7 +201,7 @@ void perf_pmu__mem_events_list(struct perf_pmu *pmu)
>  			e->tag ? 13 : 0,
>  			e->tag ? : "",
>  			e->tag && verbose > 0 ? 25 : 0,
> -			e->tag && verbose > 0 ? perf_mem_events__name(j, NULL) : "",
> +			e->tag && verbose > 0 ? perf_pmu__mem_events_name(j, pmu) : "",
>  			e->supported ? ": available\n" : "");
>  	}
>  }
> @@ -198,15 +224,15 @@ int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
>  
>  			if (!e->supported) {
>  				pr_err("failed: event '%s' not supported\n",
> -					perf_mem_events__name(j, pmu->name));
> +					perf_pmu__mem_events_name(j, pmu));
>  				return -1;
>  			}
>  
>  			if (perf_pmus__num_mem_pmus() == 1) {
>  				rec_argv[i++] = "-e";
> -				rec_argv[i++] = perf_mem_events__name(j, NULL);
> +				rec_argv[i++] = perf_pmu__mem_events_name(j, pmu);
>  			} else {
> -				const char *s = perf_mem_events__name(j, pmu->name);
> +				const char *s = perf_pmu__mem_events_name(j, pmu);
>  
>  				if (!perf_mem_event__supported(mnt, pmu, e))
>  					continue;
> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index 0ad301a2e424..79d342768d12 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -14,6 +14,8 @@
>  struct perf_mem_event {
>  	bool		record;
>  	bool		supported;
> +	bool		ldlat;
> +	u32		aux_event;
>  	const char	*tag;
>  	const char	*name;
>  	const char	*sysfs_name;
> @@ -39,7 +41,6 @@ extern struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX];
>  int perf_pmu__mem_events_parse(struct perf_pmu *pmu, const char *str);
>  int perf_pmu__mem_events_init(struct perf_pmu *pmu);
>  
> -const char *perf_mem_events__name(int i, const char *pmu_name);
>  struct perf_mem_event *perf_pmu__mem_events_ptr(struct perf_pmu *pmu, int i);
>  struct perf_pmu *perf_mem_events_find_pmu(void);
>  bool is_mem_loads_aux_event(struct evsel *leader);

