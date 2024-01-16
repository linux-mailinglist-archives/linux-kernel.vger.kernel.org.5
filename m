Return-Path: <linux-kernel+bounces-27416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEA682EFAB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7540C285C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4381BC5C;
	Tue, 16 Jan 2024 13:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kKlSkQJf"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943321BC36;
	Tue, 16 Jan 2024 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40GDLmvH022022;
	Tue, 16 Jan 2024 13:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cccvYji7zN0ELt8QrRPjBno8WeW9ely8cdtBkK5vRuY=;
 b=kKlSkQJfxxdMTOnpPzn9KE83BLfqN9WWjkUN27T2UbEI3g1Bm9/CloRKdCGJLIIRLDVu
 8CprpQKlzMaIHYCQd3oElbeReE4ytXA1nB7Qf4swu2cSGne/qru20zwR4wEFM7PynXDS
 tJ00kjjh+dDRRNCH7cfLcIvCZAJhZVHeab+ItcRdSVIOCIZ0ttngTJbNiT2nTcs8Qg+x
 DLqeqMI78bIto5NXNbsRbp2BDl2TpAqBHIKaley+47vlXt78RPn/Jjd2RMW8Xoq5F1f5
 yhgppjTzrxTUQyEJ39mcnzKoFD6wQaMwCfbqnbx7QPhgSCIR2CfS8s9PpyzTVnygx4hA Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vntfa86f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 13:23:01 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40GDMJcW023804;
	Tue, 16 Jan 2024 13:23:00 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vntfa86e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 13:23:00 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40GC95Nj026514;
	Tue, 16 Jan 2024 13:22:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm72jxe6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 13:22:58 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40GDMvQE24314600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 13:22:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 333772004D;
	Tue, 16 Jan 2024 13:22:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7F4520040;
	Tue, 16 Jan 2024 13:22:51 +0000 (GMT)
Received: from [9.171.45.131] (unknown [9.171.45.131])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jan 2024 13:22:51 +0000 (GMT)
Message-ID: <ec397d6e-c37b-8fe7-2a55-e4fdde75e075@linux.ibm.com>
Date: Tue, 16 Jan 2024 18:52:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V3 2/7] perf mem: Clean up perf_mem_events__ptr()
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
 <20231213195154.1085945-3-kan.liang@linux.intel.com>
Content-Language: en-US
From: kajoljain <kjain@linux.ibm.com>
In-Reply-To: <20231213195154.1085945-3-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JaFw2KfDKLvqPCpJFuLStU0lQ84nGnWD
X-Proofpoint-GUID: 5XUUz9sNXX_PYBb2FoxMOS42aMg7tRn2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_07,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401160106

patch looks fine to me.

Reviwed-by: Kajol Jain <kjain@linux.ibm.com>
Tested-by: Kajol jain <kjain@linux.ibm.com>

Thanks,
Kajol Jain

On 12/14/23 01:21, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The mem_events can be retrieved from the struct perf_pmu now. An ARCH
> specific perf_mem_events__ptr() is not required anymore. Remove all of
> them.
> 
> The Intel hybrid has multiple mem-events-supported PMUs. But they share
> the same mem_events. Other ARCHs only support one mem-events-supported
> PMU. In the configuration, it's good enough to only configure the
> mem_events for one PMU. Add perf_mem_events_find_pmu() which returns the
> first mem-events-supported PMU.
> 
> In the perf_mem_events__init(), the perf_pmus__scan() is not required
> anymore. It avoids checking the sysfs for every PMU on the system.
> 
> Make the perf_mem_events__record_args() more generic. Remove the
> perf_mem_events__print_unsupport_hybrid().
> 
> Since pmu is added as a new parameter, rename perf_mem_events__ptr() to
> perf_pmu__mem_events_ptr(). Several other functions also do a similar
> rename.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/arch/arm64/util/mem-events.c |  10 +--
>  tools/perf/arch/x86/util/mem-events.c   |  18 ++---
>  tools/perf/builtin-c2c.c                |  28 +++++--
>  tools/perf/builtin-mem.c                |  28 +++++--
>  tools/perf/util/mem-events.c            | 103 ++++++++++++------------
>  tools/perf/util/mem-events.h            |   9 ++-
>  6 files changed, 104 insertions(+), 92 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/util/mem-events.c b/tools/perf/arch/arm64/util/mem-events.c
> index edf8207f7812..d3e69a520c2b 100644
> --- a/tools/perf/arch/arm64/util/mem-events.c
> +++ b/tools/perf/arch/arm64/util/mem-events.c
> @@ -13,17 +13,9 @@ struct perf_mem_event perf_mem_events_arm[PERF_MEM_EVENTS__MAX] = {
>  
>  static char mem_ev_name[100];
>  
> -struct perf_mem_event *perf_mem_events__ptr(int i)
> -{
> -	if (i >= PERF_MEM_EVENTS__MAX)
> -		return NULL;
> -
> -	return &perf_mem_events_arm[i];
> -}
> -
>  const char *perf_mem_events__name(int i, const char *pmu_name __maybe_unused)
>  {
> -	struct perf_mem_event *e = perf_mem_events__ptr(i);
> +	struct perf_mem_event *e = &perf_mem_events_arm[i];
>  
>  	if (i >= PERF_MEM_EVENTS__MAX)
>  		return NULL;
> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
> index 2b81d229982c..5fb41d50118d 100644
> --- a/tools/perf/arch/x86/util/mem-events.c
> +++ b/tools/perf/arch/x86/util/mem-events.c
> @@ -28,17 +28,6 @@ struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
>  	E("mem-ldst",	"ibs_op//",	"ibs_op"),
>  };
>  
> -struct perf_mem_event *perf_mem_events__ptr(int i)
> -{
> -	if (i >= PERF_MEM_EVENTS__MAX)
> -		return NULL;
> -
> -	if (x86__is_amd_cpu())
> -		return &perf_mem_events_amd[i];
> -
> -	return &perf_mem_events_intel[i];
> -}
> -
>  bool is_mem_loads_aux_event(struct evsel *leader)
>  {
>  	struct perf_pmu *pmu = perf_pmus__find("cpu");
> @@ -54,7 +43,12 @@ bool is_mem_loads_aux_event(struct evsel *leader)
>  
>  const char *perf_mem_events__name(int i, const char *pmu_name)
>  {
> -	struct perf_mem_event *e = perf_mem_events__ptr(i);
> +	struct perf_mem_event *e;
> +
> +	if (x86__is_amd_cpu())
> +		e = &perf_mem_events_amd[i];
> +	else
> +		e = &perf_mem_events_intel[i];
>  
>  	if (!e)
>  		return NULL;
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index f78eea9e2153..838481505e08 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -3215,12 +3215,19 @@ static int parse_record_events(const struct option *opt,
>  			       const char *str, int unset __maybe_unused)
>  {
>  	bool *event_set = (bool *) opt->value;
> +	struct perf_pmu *pmu;
> +
> +	pmu = perf_mem_events_find_pmu();
> +	if (!pmu) {
> +		pr_err("failed: there is no PMU that supports perf c2c\n");
> +		exit(-1);
> +	}
>  
>  	if (!strcmp(str, "list")) {
> -		perf_mem_events__list();
> +		perf_pmu__mem_events_list(pmu);
>  		exit(0);
>  	}
> -	if (perf_mem_events__parse(str))
> +	if (perf_pmu__mem_events_parse(pmu, str))
>  		exit(-1);
>  
>  	*event_set = true;
> @@ -3245,6 +3252,7 @@ static int perf_c2c__record(int argc, const char **argv)
>  	bool all_user = false, all_kernel = false;
>  	bool event_set = false;
>  	struct perf_mem_event *e;
> +	struct perf_pmu *pmu;
>  	struct option options[] = {
>  	OPT_CALLBACK('e', "event", &event_set, "event",
>  		     "event selector. Use 'perf c2c record -e list' to list available events",
> @@ -3256,7 +3264,13 @@ static int perf_c2c__record(int argc, const char **argv)
>  	OPT_END()
>  	};
>  
> -	if (perf_mem_events__init()) {
> +	pmu = perf_mem_events_find_pmu();
> +	if (!pmu) {
> +		pr_err("failed: no PMU supports the memory events\n");
> +		return -1;
> +	}
> +
> +	if (perf_pmu__mem_events_init(pmu)) {
>  		pr_err("failed: memory events not supported\n");
>  		return -1;
>  	}
> @@ -3280,7 +3294,7 @@ static int perf_c2c__record(int argc, const char **argv)
>  	rec_argv[i++] = "record";
>  
>  	if (!event_set) {
> -		e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD_STORE);
> +		e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__LOAD_STORE);
>  		/*
>  		 * The load and store operations are required, use the event
>  		 * PERF_MEM_EVENTS__LOAD_STORE if it is supported.
> @@ -3289,15 +3303,15 @@ static int perf_c2c__record(int argc, const char **argv)
>  			e->record = true;
>  			rec_argv[i++] = "-W";
>  		} else {
> -			e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
> +			e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__LOAD);
>  			e->record = true;
>  
> -			e = perf_mem_events__ptr(PERF_MEM_EVENTS__STORE);
> +			e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__STORE);
>  			e->record = true;
>  		}
>  	}
>  
> -	e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
> +	e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__LOAD);
>  	if (e->record)
>  		rec_argv[i++] = "-W";
>  
> diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
> index 51499c20da01..ef64bae77ca7 100644
> --- a/tools/perf/builtin-mem.c
> +++ b/tools/perf/builtin-mem.c
> @@ -43,12 +43,19 @@ static int parse_record_events(const struct option *opt,
>  			       const char *str, int unset __maybe_unused)
>  {
>  	struct perf_mem *mem = *(struct perf_mem **)opt->value;
> +	struct perf_pmu *pmu;
> +
> +	pmu = perf_mem_events_find_pmu();
> +	if (!pmu) {
> +		pr_err("failed: there is no PMU that supports perf mem\n");
> +		exit(-1);
> +	}
>  
>  	if (!strcmp(str, "list")) {
> -		perf_mem_events__list();
> +		perf_pmu__mem_events_list(pmu);
>  		exit(0);
>  	}
> -	if (perf_mem_events__parse(str))
> +	if (perf_pmu__mem_events_parse(pmu, str))
>  		exit(-1);
>  
>  	mem->operation = 0;
> @@ -72,6 +79,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
>  	int ret;
>  	bool all_user = false, all_kernel = false;
>  	struct perf_mem_event *e;
> +	struct perf_pmu *pmu;
>  	struct option options[] = {
>  	OPT_CALLBACK('e', "event", &mem, "event",
>  		     "event selector. use 'perf mem record -e list' to list available events",
> @@ -84,7 +92,13 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
>  	OPT_END()
>  	};
>  
> -	if (perf_mem_events__init()) {
> +	pmu = perf_mem_events_find_pmu();
> +	if (!pmu) {
> +		pr_err("failed: no PMU supports the memory events\n");
> +		return -1;
> +	}
> +
> +	if (perf_pmu__mem_events_init(pmu)) {
>  		pr_err("failed: memory events not supported\n");
>  		return -1;
>  	}
> @@ -113,7 +127,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
>  
>  	rec_argv[i++] = "record";
>  
> -	e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD_STORE);
> +	e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__LOAD_STORE);
>  
>  	/*
>  	 * The load and store operations are required, use the event
> @@ -126,17 +140,17 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
>  		rec_argv[i++] = "-W";
>  	} else {
>  		if (mem->operation & MEM_OPERATION_LOAD) {
> -			e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
> +			e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__LOAD);
>  			e->record = true;
>  		}
>  
>  		if (mem->operation & MEM_OPERATION_STORE) {
> -			e = perf_mem_events__ptr(PERF_MEM_EVENTS__STORE);
> +			e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__STORE);
>  			e->record = true;
>  		}
>  	}
>  
> -	e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
> +	e = perf_pmu__mem_events_ptr(pmu, PERF_MEM_EVENTS__LOAD);
>  	if (e->record)
>  		rec_argv[i++] = "-W";
>  
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 0a8f415f5efe..27a33dc44964 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -29,17 +29,42 @@ struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
>  static char mem_loads_name[100];
>  static bool mem_loads_name__init;
>  
> -struct perf_mem_event * __weak perf_mem_events__ptr(int i)
> +struct perf_mem_event *perf_pmu__mem_events_ptr(struct perf_pmu *pmu, int i)
>  {
> -	if (i >= PERF_MEM_EVENTS__MAX)
> +	if (i >= PERF_MEM_EVENTS__MAX || !pmu)
>  		return NULL;
>  
> -	return &perf_mem_events[i];
> +	return &pmu->mem_events[i];
> +}
> +
> +static struct perf_pmu *perf_pmus__scan_mem(struct perf_pmu *pmu)
> +{
> +	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
> +		if (pmu->mem_events)
> +			return pmu;
> +	}
> +	return NULL;
> +}
> +
> +struct perf_pmu *perf_mem_events_find_pmu(void)
> +{
> +	/*
> +	 * The current perf mem doesn't support per-PMU configuration.
> +	 * The exact same configuration is applied to all the
> +	 * mem_events supported PMUs.
> +	 * Return the first mem_events supported PMU.
> +	 *
> +	 * Notes: The only case which may support multiple mem_events
> +	 * supported PMUs is Intel hybrid. The exact same mem_events
> +	 * is shared among the PMUs. Only configure the first PMU
> +	 * is good enough as well.
> +	 */
> +	return perf_pmus__scan_mem(NULL);
>  }
>  
>  const char * __weak perf_mem_events__name(int i, const char *pmu_name  __maybe_unused)
>  {
> -	struct perf_mem_event *e = perf_mem_events__ptr(i);
> +	struct perf_mem_event *e = &perf_mem_events[i];
>  
>  	if (!e)
>  		return NULL;
> @@ -61,7 +86,7 @@ __weak bool is_mem_loads_aux_event(struct evsel *leader __maybe_unused)
>  	return false;
>  }
>  
> -int perf_mem_events__parse(const char *str)
> +int perf_pmu__mem_events_parse(struct perf_pmu *pmu, const char *str)
>  {
>  	char *tok, *saveptr = NULL;
>  	bool found = false;
> @@ -79,7 +104,7 @@ int perf_mem_events__parse(const char *str)
>  
>  	while (tok) {
>  		for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> -			struct perf_mem_event *e = perf_mem_events__ptr(j);
> +			struct perf_mem_event *e = perf_pmu__mem_events_ptr(pmu, j);
>  
>  			if (!e->tag)
>  				continue;
> @@ -112,7 +137,7 @@ static bool perf_mem_event__supported(const char *mnt, struct perf_pmu *pmu,
>  	return !stat(path, &st);
>  }
>  
> -int perf_mem_events__init(void)
> +int perf_pmu__mem_events_init(struct perf_pmu *pmu)
>  {
>  	const char *mnt = sysfs__mount();
>  	bool found = false;
> @@ -122,8 +147,7 @@ int perf_mem_events__init(void)
>  		return -ENOENT;
>  
>  	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> -		struct perf_mem_event *e = perf_mem_events__ptr(j);
> -		struct perf_pmu *pmu = NULL;
> +		struct perf_mem_event *e = perf_pmu__mem_events_ptr(pmu, j);
>  
>  		/*
>  		 * If the event entry isn't valid, skip initialization
> @@ -132,29 +156,20 @@ int perf_mem_events__init(void)
>  		if (!e->tag)
>  			continue;
>  
> -		/*
> -		 * Scan all PMUs not just core ones, since perf mem/c2c on
> -		 * platforms like AMD uses IBS OP PMU which is independent
> -		 * of core PMU.
> -		 */
> -		while ((pmu = perf_pmus__scan(pmu)) != NULL) {
> -			e->supported |= perf_mem_event__supported(mnt, pmu, e);
> -			if (e->supported) {
> -				found = true;
> -				break;
> -			}
> -		}
> +		e->supported |= perf_mem_event__supported(mnt, pmu, e);
> +		if (e->supported)
> +			found = true;
>  	}
>  
>  	return found ? 0 : -ENOENT;
>  }
>  
> -void perf_mem_events__list(void)
> +void perf_pmu__mem_events_list(struct perf_pmu *pmu)
>  {
>  	int j;
>  
>  	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> -		struct perf_mem_event *e = perf_mem_events__ptr(j);
> +		struct perf_mem_event *e = perf_pmu__mem_events_ptr(pmu, j);
>  
>  		fprintf(stderr, "%-*s%-*s%s",
>  			e->tag ? 13 : 0,
> @@ -165,50 +180,32 @@ void perf_mem_events__list(void)
>  	}
>  }
>  
> -static void perf_mem_events__print_unsupport_hybrid(struct perf_mem_event *e,
> -						    int idx)
> -{
> -	const char *mnt = sysfs__mount();
> -	struct perf_pmu *pmu = NULL;
> -
> -	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
> -		if (!perf_mem_event__supported(mnt, pmu, e)) {
> -			pr_err("failed: event '%s' not supported\n",
> -			       perf_mem_events__name(idx, pmu->name));
> -		}
> -	}
> -}
> -
>  int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
>  				 char **rec_tmp, int *tmp_nr)
>  {
>  	const char *mnt = sysfs__mount();
> +	struct perf_pmu *pmu = NULL;
>  	int i = *argv_nr, k = 0;
>  	struct perf_mem_event *e;
>  
> -	for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> -		e = perf_mem_events__ptr(j);
> -		if (!e->record)
> -			continue;
>  
> -		if (perf_pmus__num_mem_pmus() == 1) {
> -			if (!e->supported) {
> -				pr_err("failed: event '%s' not supported\n",
> -				       perf_mem_events__name(j, NULL));
> -				return -1;
> -			}
> +	while ((pmu = perf_pmus__scan_mem(pmu)) != NULL) {
> +		for (int j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> +			e = perf_pmu__mem_events_ptr(pmu, j);
>  
> -			rec_argv[i++] = "-e";
> -			rec_argv[i++] = perf_mem_events__name(j, NULL);
> -		} else {
> -			struct perf_pmu *pmu = NULL;
> +			if (!e->record)
> +				continue;
>  
>  			if (!e->supported) {
> -				perf_mem_events__print_unsupport_hybrid(e, j);
> +				pr_err("failed: event '%s' not supported\n",
> +					perf_mem_events__name(j, pmu->name));
>  				return -1;
>  			}
>  
> -			while ((pmu = perf_pmus__scan(pmu)) != NULL) {
> +			if (perf_pmus__num_mem_pmus() == 1) {
> +				rec_argv[i++] = "-e";
> +				rec_argv[i++] = perf_mem_events__name(j, NULL);
> +			} else {
>  				const char *s = perf_mem_events__name(j, pmu->name);
>  
>  				if (!perf_mem_event__supported(mnt, pmu, e))
> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index 8c5694b2d0b0..0ad301a2e424 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -36,14 +36,15 @@ enum {
>  extern unsigned int perf_mem_events__loads_ldlat;
>  extern struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX];
>  
> -int perf_mem_events__parse(const char *str);
> -int perf_mem_events__init(void);
> +int perf_pmu__mem_events_parse(struct perf_pmu *pmu, const char *str);
> +int perf_pmu__mem_events_init(struct perf_pmu *pmu);
>  
>  const char *perf_mem_events__name(int i, const char *pmu_name);
> -struct perf_mem_event *perf_mem_events__ptr(int i);
> +struct perf_mem_event *perf_pmu__mem_events_ptr(struct perf_pmu *pmu, int i);
> +struct perf_pmu *perf_mem_events_find_pmu(void);
>  bool is_mem_loads_aux_event(struct evsel *leader);
>  
> -void perf_mem_events__list(void);
> +void perf_pmu__mem_events_list(struct perf_pmu *pmu);
>  int perf_mem_events__record_args(const char **rec_argv, int *argv_nr,
>  				 char **rec_tmp, int *tmp_nr);
>  

