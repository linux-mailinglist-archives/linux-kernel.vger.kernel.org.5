Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9BB788891
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245071AbjHYN2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242771AbjHYN23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:28:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAF51FF0;
        Fri, 25 Aug 2023 06:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692970104; x=1724506104;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=UQkMhmpCFcODJwHh6uhZJ2s7EaBPsBz+aHTYuPf9deY=;
  b=WLX+1SSCJYSH3qWYxNz1aUlRkNuUGA6Nm2zsemD85CvtAYuEgwuu3f0e
   vxVM6HD7kyCdBfKQowjX2RPLqoycV696raY9znQWT71rJYDV1uRZEINGO
   Mp585Ubx0zPEIfY4EOX8YSFs7qSkVkr47WkKZOg5elbgXPpcOfmZ12WJy
   +nPySjJi+Wej59N7TDln1zuhEz1iuMGpLLC84GHwtUZBpPMH08AK6LcPA
   c51GcpQfM6NkqwwHZCE8lwsKTTMsOOb/C5bxFj9gpvskpFZSDtNSP/EMs
   jWMG7NAiQABGyGM69RVyUCVFLM+Fs8Xe28OEwipIYQGUyf07ilmc19xZV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="359711045"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="359711045"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 06:28:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="714346596"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="714346596"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 25 Aug 2023 06:28:22 -0700
Received: from [10.209.146.71] (cgonz12x-mobl1.amr.corp.intel.com [10.209.146.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 71F1F580BA0;
        Fri, 25 Aug 2023 06:28:20 -0700 (PDT)
Message-ID: <c8dd0eb1-ca84-df41-056f-1f275a52126a@linux.intel.com>
Date:   Fri, 25 Aug 2023 09:28:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 1/2] perf vendor events intel: Add lunarlake v1.0
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>,
        Edward Baker <edward.baker@intel.com>
References: <20230824202402.436107-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230824202402.436107-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-08-24 4:24 p.m., Ian Rogers wrote:
> Add lunarlake events that were added at intel's perfmon site in:
> https://github.com/intel/perfmon/pull/97
> LNL: Release initial events
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks Ian and Colin. The series looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  .../pmu-events/arch/x86/lunarlake/cache.json  | 219 ++++++++++++++++++=

>  .../arch/x86/lunarlake/frontend.json          |  27 +++
>  .../pmu-events/arch/x86/lunarlake/memory.json | 183 +++++++++++++++
>  .../pmu-events/arch/x86/lunarlake/other.json  |  62 +++++
>  .../arch/x86/lunarlake/pipeline.json          | 217 +++++++++++++++++
>  .../arch/x86/lunarlake/virtual-memory.json    |  56 +++++
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   1 +
>  7 files changed, 765 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/cache.json=

>  create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/frontend.j=
son
>  create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/memory.jso=
n
>  create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/other.json=

>  create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/pipeline.j=
son
>  create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/virtual-me=
mory.json
>=20
> diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/cache.json b/tool=
s/perf/pmu-events/arch/x86/lunarlake/cache.json
> new file mode 100644
> index 000000000000..1823149067b5
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
> @@ -0,0 +1,219 @@
> +[
> +    {
> +        "BriefDescription": "Counts the number of L2 Cache Accesses Co=
unts the total number of L2 Cache Accesses - sum of hits, misses, rejects=
  front door requests for CRd/DRd/RFO/ItoM/L2 Prefetches only, per core e=
vent",
> +        "EventCode": "0x24",
> +        "EventName": "L2_REQUEST.ALL",
> +        "PublicDescription": "Counts the number of L2 Cache Accesses C=
ounts the total number of L2 Cache Accesses - sum of hits, misses, reject=
s  front door requests for CRd/DRd/RFO/ItoM/L2 Prefetches only.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x7",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cacheable memory req=
uests that miss in the LLC. Counts on a per core basis.",
> +        "EventCode": "0x2e",
> +        "EventName": "LONGEST_LAT_CACHE.MISS",
> +        "PublicDescription": "Counts the number of cacheable memory re=
quests that miss in the Last Level Cache (LLC). Requests include demand l=
oads, reads for ownership (RFO), instruction fetches and L1 HW prefetches=
=2E If the platform has an L3 cache, the LLC is the L3 cache, otherwise i=
t is the L2 cache. Counts on a per core basis.",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x41",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Core-originated cacheable requests that m=
issed L3  (Except hardware prefetches to the L3)",
> +        "EventCode": "0x2e",
> +        "EventName": "LONGEST_LAT_CACHE.MISS",
> +        "PublicDescription": "Counts core-originated cacheable request=
s that miss the L3 cache (Longest Latency cache). Requests include data a=
nd code reads, Reads-for-Ownership (RFOs), speculative accesses and hardw=
are prefetches to the L1 and L2.  It does not include hardware prefetches=
 to the L3, and may not count other types of requests to the L3.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x41",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cacheable memory req=
uests that access the LLC. Counts on a per core basis.",
> +        "EventCode": "0x2e",
> +        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
> +        "PublicDescription": "Counts the number of cacheable memory re=
quests that access the Last Level Cache (LLC). Requests include demand lo=
ads, reads for ownership (RFO), instruction fetches and L1 HW prefetches.=
 If the platform has an L3 cache, the LLC is the L3 cache, otherwise it i=
s the L2 cache. Counts on a per core basis.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x4f",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Core-originated cacheable requests that r=
efer to L3 (Except hardware prefetches to the L3)",
> +        "EventCode": "0x2e",
> +        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
> +        "PublicDescription": "Counts core-originated cacheable request=
s to the L3 cache (Longest Latency cache). Requests include data and code=
 reads, Reads-for-Ownership (RFOs), speculative accesses and hardware pre=
fetches to the L1 and L2.  It does not include hardware prefetches to the=
 L3, and may not count other types of requests to the L3.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x4f",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Retired load instructions.",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_INST_RETIRED.ALL_LOADS",
> +        "PEBS": "1",
> +        "PublicDescription": "Counts all retired load instructions. Th=
is event accounts for SW prefetch instructions of PREFETCHNTA or PREFETCH=
T0/1/2 or PREFETCHW.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x81",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Retired store instructions.",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_INST_RETIRED.ALL_STORES",
> +        "PEBS": "1",
> +        "PublicDescription": "Counts all retired store instructions.",=

> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x82",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of load uops retired.",=

> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x81",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of store uops retired."=
,
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x82",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRE=
SHOLD - Only counts with PEBS enabled",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_1024",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x400",
> +        "PEBS": "2",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x5",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRE=
SHOLD - Only counts with PEBS enabled",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x80",
> +        "PEBS": "2",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x5",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRE=
SHOLD - Only counts with PEBS enabled",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x10",
> +        "PEBS": "2",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x5",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRE=
SHOLD - Only counts with PEBS enabled",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_2048",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x800",
> +        "PEBS": "2",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x5",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRE=
SHOLD - Only counts with PEBS enabled",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x100",
> +        "PEBS": "2",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x5",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRE=
SHOLD - Only counts with PEBS enabled",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x20",
> +        "PEBS": "2",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x5",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRE=
SHOLD - Only counts with PEBS enabled",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x4",
> +        "PEBS": "2",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x5",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRE=
SHOLD - Only counts with PEBS enabled",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x200",
> +        "PEBS": "2",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x5",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRE=
SHOLD - Only counts with PEBS enabled",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x40",
> +        "PEBS": "2",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x5",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of tagged load uops ret=
ired that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRE=
SHOLD - Only counts with PEBS enabled",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x8",
> +        "PEBS": "2",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x5",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of  stores uops retired=
 same as MEM_UOPS_RETIRED.ALL_STORES",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
> +        "PEBS": "2",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x6",
> +        "Unit": "cpu_atom"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/frontend.json b/t=
ools/perf/pmu-events/arch/x86/lunarlake/frontend.json
> new file mode 100644
> index 000000000000..5e4ef81b43d6
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/lunarlake/frontend.json
> @@ -0,0 +1,27 @@
> +[
> +    {
> +        "BriefDescription": "Counts every time the code stream enters =
into a new cache line by walking sequential from the previous line or bei=
ng redirected by a jump.",
> +        "EventCode": "0x80",
> +        "EventName": "ICACHE.ACCESSES",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x3",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts every time the code stream enters =
into a new cache line by walking sequential from the previous line or bei=
ng redirected by a jump and the instruction cache registers bytes are not=
 present. -",
> +        "EventCode": "0x80",
> +        "EventName": "ICACHE.MISSES",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x2",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This event counts a subset of the Topdown=
 Slots event that were no operation was delivered to the back-end pipelin=
e due to instruction fetch limitations when the back-end could have accep=
ted more operations. Common examples include instruction cache misses or =
x86 instruction decode limitations.",
> +        "EventCode": "0x9c",
> +        "EventName": "IDQ_BUBBLES.CORE",
> +        "PublicDescription": "This event counts a subset of the Topdow=
n Slots event that were no operation was delivered to the back-end pipeli=
ne due to instruction fetch limitations when the back-end could have acce=
pted more operations. Common examples include instruction cache misses or=
 x86 instruction decode limitations.\nSoftware can use this event as the =
numerator for the Frontend Bound metric (or top-level category) of the To=
p-down Microarchitecture Analysis method.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/memory.json b/too=
ls/perf/pmu-events/arch/x86/lunarlake/memory.json
> new file mode 100644
> index 000000000000..51d70ba00bd4
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/lunarlake/memory.json
> @@ -0,0 +1,183 @@
> +[
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 1024 cycles.",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_1024",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x400",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 1024 cycles.  R=
eported latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "53",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 128 cycles.",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x80",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 128 cycles.  Re=
ported latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "1009",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 16 cycles.",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x10",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 16 cycles.  Rep=
orted latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "20011",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 2048 cycles.",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_2048",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x800",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 2048 cycles.  R=
eported latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "23",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 256 cycles.",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x100",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 256 cycles.  Re=
ported latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "503",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 32 cycles.",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x20",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 32 cycles.  Rep=
orted latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "100007",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 4 cycles.",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x4",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 4 cycles.  Repo=
rted latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 512 cycles.",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x200",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 512 cycles.  Re=
ported latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "101",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 64 cycles.",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x40",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 64 cycles.  Rep=
orted latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "2003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the l=
atency from first dispatch to completion is greater than 8 cycles.",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x8",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts randomly selected loads when the =
latency from first dispatch to completion is greater than 8 cycles.  Repo=
rted latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "50021",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Retired memory store access operations. A=
 PDist event for PEBS Store Latency Facility.",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.STORE_SAMPLE",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts Retired memory accesses with at l=
east 1 store operation. This PEBS event is the precisely-distributed (PDi=
st) trigger covering all stores uops for sampling by the PEBS Store Laten=
cy Facility. The facility is described in Intel SDM Volume 3 section 19.9=
=2E8",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts cacheable demand data reads were n=
ot supplied by the L3 cache.",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3FBFC00001",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts demand data reads that were not su=
pplied by the L3 cache.",
> +        "EventCode": "0x2A,0x2B",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3FBFC00001",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership, includ=
ing SWPREFETCHW which is an RFO were not supplied by the L3 cache.",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_RFO.L3_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3FBFC00002",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts demand read for ownership (RFO) re=
quests and software prefetches for exclusive ownership (PREFETCHW) that w=
ere not supplied by the L3 cache.",
> +        "EventCode": "0x2A,0x2B",
> +        "EventName": "OCR.DEMAND_RFO.L3_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3FBFC00002",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/other.json b/tool=
s/perf/pmu-events/arch/x86/lunarlake/other.json
> new file mode 100644
> index 000000000000..69adaed5686d
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/lunarlake/other.json
> @@ -0,0 +1,62 @@
> +[
> +    {
> +        "BriefDescription": "Counts cacheable demand data reads Catch =
all value for any response types - this includes response types not defin=
e in the OCR.  If this is set all other response types will be ignored",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10001",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts demand data reads that have any ty=
pe of response.",
> +        "EventCode": "0x2A,0x2B",
> +        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10001",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts cacheable demand data reads were s=
upplied by DRAM.",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x184000001",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts demand data reads that were suppli=
ed by DRAM.",
> +        "EventCode": "0x2A,0x2B",
> +        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x184000001",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership, includ=
ing SWPREFETCHW which is an RFO Catch all value for any response types - =
this includes response types not define in the OCR.  If this is set all o=
ther response types will be ignored",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10002",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts demand read for ownership (RFO) re=
quests and software prefetches for exclusive ownership (PREFETCHW) that h=
ave any type of response.",
> +        "EventCode": "0x2A,0x2B",
> +        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10002",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
> new file mode 100644
> index 000000000000..2bde664fdc0f
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
> @@ -0,0 +1,217 @@
> +[
> +    {
> +        "BriefDescription": "Counts the total number of branch instruc=
tions retired for all branch types.",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
> +        "PEBS": "1",
> +        "PublicDescription": "Counts the total number of instructions =
in which the instruction pointer (IP) of the processor is resteered due t=
o a branch instruction and the branch instruction successfully retires.  =
All branch type instructions are accounted for.",
> +        "SampleAfterValue": "200003",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "All branch instructions retired.",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
> +        "PEBS": "1",
> +        "PublicDescription": "Counts all branch instructions retired."=
,
> +        "SampleAfterValue": "400009",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts the total number of mispredicted b=
ranch instructions retired for all branch types.",
> +        "EventCode": "0xc5",
> +        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
> +        "PEBS": "1",
> +        "PublicDescription": "Counts the total number of mispredicted =
branch instructions retired.  All branch type instructions are accounted =
for.  Prediction of the branch target address enables the processor to be=
gin executing instructions before the non-speculative execution path is k=
nown. The branch prediction unit (BPU) predicts the target address based =
on the instruction pointer (IP) of the branch and on the execution path t=
hrough which execution reached this IP.    A branch misprediction occurs =
when the prediction is wrong, and results in discarding all instructions =
executed in the speculative path and re-fetching from the correct path.",=

> +        "SampleAfterValue": "200003",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "All mispredicted branch instructions reti=
red.",
> +        "EventCode": "0xc5",
> +        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
> +        "PEBS": "1",
> +        "PublicDescription": "Counts all the retired branch instructio=
ns that were mispredicted by the processor. A branch misprediction occurs=
 when the processor incorrectly predicts the destination of the branch.  =
When the misprediction is discovered at execution, all the instructions e=
xecuted in the wrong (speculative) path must be discarded, and the proces=
sor must start fetching from the correct path.",
> +        "SampleAfterValue": "400009",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Fixed Counter: Counts the number of unhal=
ted core clock cycles",
> +        "EventName": "CPU_CLK_UNHALTED.CORE",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of unhalted core clock =
cycles [This event is alias to CPU_CLK_UNHALTED.THREAD_P]",
> +        "EventCode": "0x3c",
> +        "EventName": "CPU_CLK_UNHALTED.CORE_P",
> +        "SampleAfterValue": "2000003",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Fixed Counter: Counts the number of unhal=
ted reference clock cycles",
> +        "EventName": "CPU_CLK_UNHALTED.REF_TSC",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x3",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Reference cycles when the core is not in =
halt state.",
> +        "EventName": "CPU_CLK_UNHALTED.REF_TSC",
> +        "PublicDescription": "Counts the number of reference cycles wh=
en the core is not in a halt state. The core enters the halt state when i=
t is running the HLT instruction or the MWAIT instruction. This event is =
not affected by core frequency changes (for example, P states, TM2 transi=
tions) but has the same incrementing frequency as the time stamp counter.=
 This event can approximate elapsed time while the core was not in a halt=
 state. Note: On all current platforms this event stops counting during '=
throttling (TM)' states duty off periods the processor is 'halted'.  The =
counter update is done at a lower clock rate then the core clock the over=
flow status bit for this counter may appear 'sticky'.  After the counter =
has overflowed and software clears the overflow status bit and resets the=
 counter to less than MAX. The reset value to the counter is not clocked =
immediately so the overflow status bit will flip 'high (1)' and generate =
another PMI (if enabled) after which the reset value gets clocked into th=
e counter. Therefore, software will get the interrupt, read the overflow =
status bit '1 for bit 34 while the counter value is less than MAX. Softwa=
re should ignore this case.",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x3",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Reference cycles when the core is not in =
halt state.",
> +        "EventCode": "0x3c",
> +        "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
> +        "PublicDescription": "Counts the number of reference cycles wh=
en the core is not in a halt state. The core enters the halt state when i=
t is running the HLT instruction or the MWAIT instruction. This event is =
not affected by core frequency changes (for example, P states, TM2 transi=
tions) but has the same incrementing frequency as the time stamp counter.=
 This event can approximate elapsed time while the core was not in a halt=
 state. Note: On all current platforms this event stops counting during '=
throttling (TM)' states duty off periods the processor is 'halted'.  The =
counter update is done at a lower clock rate then the core clock the over=
flow status bit for this counter may appear 'sticky'.  After the counter =
has overflowed and software clears the overflow status bit and resets the=
 counter to less than MAX. The reset value to the counter is not clocked =
immediately so the overflow status bit will flip 'high (1)' and generate =
another PMI (if enabled) after which the reset value gets clocked into th=
e counter. Therefore, software will get the interrupt, read the overflow =
status bit '1 for bit 34 while the counter value is less than MAX. Softwa=
re should ignore this case.",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Core cycles when the thread is not in hal=
t state",
> +        "EventName": "CPU_CLK_UNHALTED.THREAD",
> +        "PublicDescription": "Counts the number of core cycles while t=
he thread is not in a halt state. The thread enters the halt state when i=
t is running the HLT instruction. This event is a component in many key e=
vent ratios. The core frequency may change from time to time due to trans=
itions associated with Enhanced Intel SpeedStep Technology or TM2. For th=
is reason this event may have a changing ratio with regards to time. When=
 the core frequency is constant, this event can approximate elapsed time =
while the core was not in the halt state. It is counted on a dedicated fi=
xed counter, leaving the eight programmable counters available for other =
events.",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x2",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of unhalted core clock =
cycles [This event is alias to CPU_CLK_UNHALTED.CORE_P]",
> +        "EventCode": "0x3c",
> +        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
> +        "SampleAfterValue": "2000003",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Thread cycles when thread is not in halt =
state",
> +        "EventCode": "0x3c",
> +        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
> +        "PublicDescription": "This is an architectural event that coun=
ts the number of thread cycles while the thread is not in a halt state. T=
he thread enters the halt state when it is running the HLT instruction. T=
he core frequency may change from time to time due to power or thermal th=
rottling. For this reason, this event may have a changing ratio with rega=
rds to wall clock time.",
> +        "SampleAfterValue": "2000003",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Fixed Counter: Counts the number of instr=
uctions retired",
> +        "EventName": "INST_RETIRED.ANY",
> +        "PEBS": "1",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Number of instructions retired. Fixed Cou=
nter - architectural event",
> +        "EventName": "INST_RETIRED.ANY",
> +        "PEBS": "1",
> +        "PublicDescription": "Counts the number of X86 instructions re=
tired - an Architectural PerfMon event. Counting continues during hardwar=
e interrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.A=
NY is counted by a designated fixed counter freeing up programmable count=
ers to count other events. INST_RETIRED.ANY_P is counted by a programmabl=
e counter.",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of instructions retired=
",
> +        "EventCode": "0xc0",
> +        "EventName": "INST_RETIRED.ANY_P",
> +        "PEBS": "1",
> +        "SampleAfterValue": "2000003",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Number of instructions retired. General C=
ounter - architectural event",
> +        "EventCode": "0xc0",
> +        "EventName": "INST_RETIRED.ANY_P",
> +        "PEBS": "1",
> +        "PublicDescription": "Counts the number of X86 instructions re=
tired - an Architectural PerfMon event. Counting continues during hardwar=
e interrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.A=
NY is counted by a designated fixed counter freeing up programmable count=
ers to count other events. INST_RETIRED.ANY_P is counted by a programmabl=
e counter.",
> +        "SampleAfterValue": "2000003",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of occurrences a retire=
d load gets blocked because its address partially overlaps with an older =
store (size mismatch) - unknown_sta/bad_forward",
> +        "EventCode": "0x03",
> +        "EventName": "LD_BLOCKS.STORE_FORWARD",
> +        "PEBS": "1",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Loads blocked due to overlapping with a p=
receding store that cannot be forwarded.",
> +        "EventCode": "0x03",
> +        "EventName": "LD_BLOCKS.STORE_FORWARD",
> +        "PublicDescription": "Counts the number of times where store f=
orwarding was prevented for a load operation. The most common case is a l=
oad blocked due to the address of memory access (partially) overlapping w=
ith a preceding uncompleted store. Note: See the table of not supported s=
tore forwards in the Optimization Guide.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x82",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This event counts a subset of the Topdown=
 Slots event that were not consumed by the back-end pipeline due to lack =
of back-end resources, as a result of memory subsystem delays, execution =
units limitations, or other conditions.",
> +        "EventCode": "0xa4",
> +        "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
> +        "PublicDescription": "This event counts a subset of the Topdow=
n Slots event that were not consumed by the back-end pipeline due to lack=
 of back-end resources, as a result of memory subsystem delays, execution=
 units limitations, or other conditions.\nSoftware can use this event as =
the numerator for the Backend Bound metric (or top-level category) of the=
 Top-down Microarchitecture Analysis method.",
> +        "SampleAfterValue": "10000003",
> +        "UMask": "0x2",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "TMA slots available for an unhalted logic=
al processor. Fixed counter - architectural event",
> +        "EventName": "TOPDOWN.SLOTS",
> +        "PublicDescription": "Number of available slots for an unhalte=
d logical processor. The event increments by machine-width of the narrowe=
st pipeline as employed by the Top-down Microarchitecture Analysis method=
 (TMA). Software can use this event as the denominator for the top-level =
metrics of the TMA method. This architectural event is counted on a desig=
nated fixed counter (Fixed Counter 3).",
> +        "SampleAfterValue": "10000003",
> +        "UMask": "0x4",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "TMA slots available for an unhalted logic=
al processor. General counter - architectural event",
> +        "EventCode": "0xa4",
> +        "EventName": "TOPDOWN.SLOTS_P",
> +        "PublicDescription": "Counts the number of available slots for=
 an unhalted logical processor. The event increments by machine-width of =
the narrowest pipeline as employed by the Top-down Microarchitecture Anal=
ysis method.",
> +        "SampleAfterValue": "10000003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Fixed Counter: Counts the number of issue=
 slots that were not consumed by the backend because allocation is stalle=
d due to a mispredicted jump or a machine clear.",
> +        "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
> +        "PublicDescription": "Fixed Counter: Counts the number of issu=
e slots that were not consumed by the backend because allocation is stall=
ed due to a mispredicted jump or a machine clear.  Counts all issue slots=
 blocked during this recovery window including relevant microcode flows a=
nd while uops are not yet available in the IQ. Also, includes the issue s=
lots that were consumed by the backend but were thrown away because they =
were younger than the mispredict or machine clear.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x5",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of retirement slots not=
 consumed due to backend stalls",
> +        "EventCode": "0xa4",
> +        "EventName": "TOPDOWN_BE_BOUND.ALL",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Fixed Counter: Counts the number of retir=
ement slots not consumed due to front end stalls",
> +        "EventName": "TOPDOWN_FE_BOUND.ALL",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x6",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Fixed Counter: Counts the number of consu=
med retirement slots.  Similar to UOPS_RETIRED.ALL",
> +        "EventName": "TOPDOWN_RETIRING.ALL",
> +        "PEBS": "1",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x7",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This event counts a subset of the Topdown=
 Slots event that are utilized by operations that eventually get retired =
(committed) by the processor pipeline. Usually, this event positively cor=
relates with higher performance  for example, as measured by the instruct=
ions-per-cycle metric.",
> +        "EventCode": "0xc2",
> +        "EventName": "UOPS_RETIRED.SLOTS",
> +        "PublicDescription": "This event counts a subset of the Topdow=
n Slots event that are utilized by operations that eventually get retired=
 (committed) by the processor pipeline. Usually, this event positively co=
rrelates with higher performance  for example, as measured by the instruc=
tions-per-cycle metric.\nSoftware can use this event as the numerator for=
 the Retiring metric (or top-level category) of the Top-down Microarchite=
cture Analysis method.",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x2",
> +        "Unit": "cpu_core"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/virtual-memory.js=
on b/tools/perf/pmu-events/arch/x86/lunarlake/virtual-memory.json
> new file mode 100644
> index 000000000000..bb9458799f1c
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/lunarlake/virtual-memory.json
> @@ -0,0 +1,56 @@
> +[
> +    {
> +        "BriefDescription": "Counts the number of page walks completed=
 due to load DTLB misses to any page size.",
> +        "EventCode": "0x08",
> +        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
> +        "PublicDescription": "Counts the number of page walks complete=
d due to loads (including SW prefetches) whose address translations misse=
d in all Translation Lookaside Buffer (TLB) levels and were mapped to any=
 page size. Includes page walks that page fault.",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xe",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Load miss in all TLB levels causes a page=
 walk that completes. (All page sizes)",
> +        "EventCode": "0x12",
> +        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
> +        "PublicDescription": "Counts completed page walks  (all page s=
izes) caused by demand data loads. This implies it missed in the DTLB and=
 further levels of TLB. The page walk can end with or without a fault.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0xe",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of page walks completed=
 due to store DTLB misses to any page size.",
> +        "EventCode": "0x49",
> +        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
> +        "PublicDescription": "Counts the number of page walks complete=
d due to stores whose address translations missed in all Translation Look=
aside Buffer (TLB) levels and were mapped to any page size.  Includes pag=
e walks that page fault.",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0xe",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Store misses in all TLB levels causes a p=
age walk that completes. (All page sizes)",
> +        "EventCode": "0x13",
> +        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
> +        "PublicDescription": "Counts completed page walks  (all page s=
izes) caused by demand data stores. This implies it missed in the DTLB an=
d further levels of TLB. The page walk can end with or without a fault.",=

> +        "SampleAfterValue": "100003",
> +        "UMask": "0xe",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of page walks completed=
 due to instruction fetch misses to any page size.",
> +        "EventCode": "0x85",
> +        "EventName": "ITLB_MISSES.WALK_COMPLETED",
> +        "PublicDescription": "Counts the number of page walks complete=
d due to instruction fetches whose address translations missed in all Tra=
nslation Lookaside Buffer (TLB) levels and were mapped to any page size. =
 Includes page walks that page fault.",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0xe",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Code miss in all TLB levels causes a page=
 walk that completes. (All page sizes)",
> +        "EventCode": "0x11",
> +        "EventName": "ITLB_MISSES.WALK_COMPLETED",
> +        "PublicDescription": "Counts completed page walks (all page si=
zes) caused by a code fetch. This implies it missed in the ITLB (Instruct=
ion TLB) and further levels of TLB. The page walk can end with or without=
 a fault.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0xe",
> +        "Unit": "cpu_core"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pm=
u-events/arch/x86/mapfile.csv
> index 3a8770e29fe8..de9582f183cb 100644
> --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> @@ -19,6 +19,7 @@ GenuineIntel-6-3A,v24,ivybridge,core
>  GenuineIntel-6-3E,v23,ivytown,core
>  GenuineIntel-6-2D,v23,jaketown,core
>  GenuineIntel-6-(57|85),v10,knightslanding,core
> +GenuineIntel-6-BD,v1.00,lunarlake,core
>  GenuineIntel-6-A[AC],v1.04,meteorlake,core
>  GenuineIntel-6-1[AEF],v3,nehalemep,core
>  GenuineIntel-6-2E,v3,nehalemex,core
