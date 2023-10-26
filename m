Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499F17D881A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjJZSQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjJZSQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:16:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4324D44;
        Thu, 26 Oct 2023 11:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698344207; x=1729880207;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=OwCFCK+jvrD1vinB0jjRqRvHD2YdZ3MxuKHXfT1ZykM=;
  b=NEQrlwskAvLwItOO/uWxKWoIcajcg86YS9h6PBvuxU99kedLuwWBLGdn
   +I4n5xT0XpqctdHgHa8gVJS4VyiO3yNkOjlEUj9DpdyyuOqz4UPEWSaYu
   PbXUFB00dHVh6ehFF3dTw6OkNJXN2LVq54jEVNLn9VeTV4d1+Ehn12t+a
   Qq1dpjGK0IFxfgzZgWntj7IxGS7UcXD5NZZX43i0U0OsajaDhqI482jvI
   92wYkC6FF5drh9ggTGJjrXw5hNzF127dcqM4/ssC4cFlBbU5x3HgdGs21
   Bfw9CN3ha7BWAL7uptIOkBwM3V9l74VghtL4DhNY9ULqNThH1Na5IDMhr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="418732754"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="418732754"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 11:16:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="1090663738"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="1090663738"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 11:16:37 -0700
Received: from [10.209.128.139] (kliang2-mobl1.ccr.corp.intel.com [10.209.128.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 4B7BE580E30;
        Thu, 26 Oct 2023 11:16:35 -0700 (PDT)
Message-ID: <e05d01dd-dd6f-4bb6-857f-3458b9b7159d@linux.intel.com>
Date:   Thu, 26 Oct 2023 14:16:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] perf vendor events intel: Update
 alderlake/alderlake events to v1.23
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
        Edward Baker <edward.baker@intel.com>
References: <20231026003149.3287633-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20231026003149.3287633-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-10-25 8:31 p.m., Ian Rogers wrote:
> Update alderlake and alderlaken events from v1.21 to v1.23 adding the
> changes from:
> https://github.com/intel/perfmon/commit/8df4db9433a2aab59dbbac1a70281032d1af7734
> https://github.com/intel/perfmon/commit/846bd247c6e04acc572ca56c992e9e65852bbe63
> 
> The tsx_cycles_per_elision metric is updated from PR:
> https://github.com/intel/perfmon/pull/116
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks Ian. The whole patch series looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  .../arch/x86/alderlake/adl-metrics.json       |  2 +-
>  .../arch/x86/alderlake/frontend.json          | 42 ++++++++++--
>  .../pmu-events/arch/x86/alderlake/memory.json |  4 +-
>  .../arch/x86/alderlake/pipeline.json          | 20 +++++-
>  .../x86/alderlake/uncore-interconnect.json    |  2 +
>  .../arch/x86/alderlaken/memory.json           |  4 +-
>  .../arch/x86/alderlaken/pipeline.json         | 16 +++++
>  .../x86/alderlaken/uncore-interconnect.json   | 66 +++++++++++++++++++
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |  4 +-
>  9 files changed, 146 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> index 8b6bed3bc766..3388b58b8f1a 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> @@ -99,7 +99,7 @@
>      },
>      {
>          "BriefDescription": "Number of cycles within a transaction divided by the number of elisions.",
> -        "MetricExpr": "(cycles\\-t / el\\-start if has_event(cycles\\-t) else 0)",
> +        "MetricExpr": "(cycles\\-t / el\\-start if has_event(el\\-start) else 0)",
>          "MetricGroup": "transaction",
>          "MetricName": "tsx_cycles_per_elision",
>          "ScaleUnit": "1cycles / elision"
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json b/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
> index 81349100fe32..542ba4a81996 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
> @@ -394,31 +394,61 @@
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Uops not delivered by IDQ when backend of the machine is not stalled",
> +        "BriefDescription": "Uops not delivered by IDQ when backend of the machine is not stalled [This event is alias to IDQ_UOPS_NOT_DELIVERED.CORE]",
> +        "EventCode": "0x9c",
> +        "EventName": "IDQ_BUBBLES.CORE",
> +        "PublicDescription": "Counts the number of uops not delivered to by the Instruction Decode Queue (IDQ) to the back-end of the pipeline when there was no back-end stalls. This event counts for one SMT thread in a given cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CORE]",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Cycles when no uops are not delivered by the IDQ when backend of the machine is not stalled [This event is alias to IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE]",
> +        "CounterMask": "6",
> +        "EventCode": "0x9c",
> +        "EventName": "IDQ_BUBBLES.CYCLES_0_UOPS_DELIV.CORE",
> +        "PublicDescription": "Counts the number of cycles when no uops were delivered by the Instruction Decode Queue (IDQ) to the back-end of the pipeline when there was no back-end stalls. This event counts for one SMT thread in a given cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE]",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Cycles when optimal number of uops was delivered to the back-end when the back-end is not stalled [This event is alias to IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK]",
> +        "CounterMask": "1",
> +        "EventCode": "0x9c",
> +        "EventName": "IDQ_BUBBLES.CYCLES_FE_WAS_OK",
> +        "Invert": "1",
> +        "PublicDescription": "Counts the number of cycles when the optimal number of uops were delivered by the Instruction Decode Queue (IDQ) to the back-end of the pipeline when there was no back-end stalls. This event counts for one SMT thread in a given cycle. [This event is alias to IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK]",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Uops not delivered by IDQ when backend of the machine is not stalled [This event is alias to IDQ_BUBBLES.CORE]",
>          "EventCode": "0x9c",
>          "EventName": "IDQ_UOPS_NOT_DELIVERED.CORE",
> -        "PublicDescription": "Counts the number of uops not delivered to by the Instruction Decode Queue (IDQ) to the back-end of the pipeline when there was no back-end stalls. This event counts for one SMT thread in a given cycle.",
> +        "PublicDescription": "Counts the number of uops not delivered to by the Instruction Decode Queue (IDQ) to the back-end of the pipeline when there was no back-end stalls. This event counts for one SMT thread in a given cycle. [This event is alias to IDQ_BUBBLES.CORE]",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x1",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Cycles when no uops are not delivered by the IDQ when backend of the machine is not stalled",
> +        "BriefDescription": "Cycles when no uops are not delivered by the IDQ when backend of the machine is not stalled [This event is alias to IDQ_BUBBLES.CYCLES_0_UOPS_DELIV.CORE]",
>          "CounterMask": "6",
>          "EventCode": "0x9c",
>          "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE",
> -        "PublicDescription": "Counts the number of cycles when no uops were delivered by the Instruction Decode Queue (IDQ) to the back-end of the pipeline when there was no back-end stalls. This event counts for one SMT thread in a given cycle.",
> +        "PublicDescription": "Counts the number of cycles when no uops were delivered by the Instruction Decode Queue (IDQ) to the back-end of the pipeline when there was no back-end stalls. This event counts for one SMT thread in a given cycle. [This event is alias to IDQ_BUBBLES.CYCLES_0_UOPS_DELIV.CORE]",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x1",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Cycles when optimal number of uops was delivered to the back-end when the back-end is not stalled",
> +        "BriefDescription": "Cycles when optimal number of uops was delivered to the back-end when the back-end is not stalled [This event is alias to IDQ_BUBBLES.CYCLES_FE_WAS_OK]",
>          "CounterMask": "1",
>          "EventCode": "0x9c",
>          "EventName": "IDQ_UOPS_NOT_DELIVERED.CYCLES_FE_WAS_OK",
>          "Invert": "1",
> -        "PublicDescription": "Counts the number of cycles when the optimal number of uops were delivered by the Instruction Decode Queue (IDQ) to the back-end of the pipeline when there was no back-end stalls. This event counts for one SMT thread in a given cycle.",
> +        "PublicDescription": "Counts the number of cycles when the optimal number of uops were delivered by the Instruction Decode Queue (IDQ) to the back-end of the pipeline when there was no back-end stalls. This event counts for one SMT thread in a given cycle. [This event is alias to IDQ_BUBBLES.CYCLES_FE_WAS_OK]",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x1",
>          "Unit": "cpu_core"
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/memory.json b/tools/perf/pmu-events/arch/x86/alderlake/memory.json
> index 73d92d5c9f9d..23d36164433f 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/memory.json
> @@ -248,7 +248,7 @@
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Counts demand data reads that were not supplied by the L3 cache.",
> +        "BriefDescription": "Counts demand data reads that were not supplied by the L3 cache. [L3_MISS_LOCAL is alias to L3_MISS]",
>          "EventCode": "0xB7",
>          "EventName": "OCR.DEMAND_DATA_RD.L3_MISS_LOCAL",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -278,7 +278,7 @@
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were not supplied by the L3 cache.",
> +        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were not supplied by the L3 cache. [L3_MISS_LOCAL is alias to L3_MISS]",
>          "EventCode": "0xB7",
>          "EventName": "OCR.DEMAND_RFO.L3_MISS_LOCAL",
>          "MSRIndex": "0x1a6,0x1a7",
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
> index a92013cdf136..f9876bef16da 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
> @@ -238,6 +238,15 @@
>          "UMask": "0x8",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Counts the number of near taken branch instructions retired.",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xc0",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "Taken branch instructions retired.",
>          "EventCode": "0xc4",
> @@ -411,6 +420,15 @@
>          "UMask": "0x7e",
>          "Unit": "cpu_atom"
>      },
> +    {
> +        "BriefDescription": "Counts the number of mispredicted near taken branch instructions retired.",
> +        "EventCode": "0xc5",
> +        "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x80",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "Number of near branch instructions retired that were mispredicted and taken.",
>          "EventCode": "0xc5",
> @@ -842,7 +860,7 @@
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
> +        "BriefDescription": "Bubble cycles of BAClear (Unknown Branch).",
>          "EventCode": "0xad",
>          "EventName": "INT_MISC.UNKNOWN_BRANCH_CYCLES",
>          "MSRIndex": "0x3F7",
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/alderlake/uncore-interconnect.json
> index 34fc052d00e4..8bf020a9dfa8 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/uncore-interconnect.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/uncore-interconnect.json
> @@ -25,6 +25,7 @@
>      },
>      {
>          "BriefDescription": "This event is deprecated. Refer to new event UNC_ARB_REQ_TRK_REQUEST.DRD",
> +        "Deprecated": "1",
>          "EventCode": "0x81",
>          "EventName": "UNC_ARB_DAT_REQUESTS.RD",
>          "PerPkg": "1",
> @@ -33,6 +34,7 @@
>      },
>      {
>          "BriefDescription": "This event is deprecated. Refer to new event UNC_ARB_DAT_OCCUPANCY.ALL",
> +        "Deprecated": "1",
>          "EventCode": "0x85",
>          "EventName": "UNC_ARB_IFA_OCCUPANCY.ALL",
>          "PerPkg": "1",
> diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/memory.json b/tools/perf/pmu-events/arch/x86/alderlaken/memory.json
> index 37259d38a222..863a3ba2b4b2 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlaken/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlaken/memory.json
> @@ -59,7 +59,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts demand data reads that were not supplied by the L3 cache.",
> +        "BriefDescription": "Counts demand data reads that were not supplied by the L3 cache. [L3_MISS_LOCAL is alias to L3_MISS]",
>          "EventCode": "0xB7",
>          "EventName": "OCR.DEMAND_DATA_RD.L3_MISS_LOCAL",
>          "MSRIndex": "0x1a6,0x1a7",
> @@ -77,7 +77,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were not supplied by the L3 cache.",
> +        "BriefDescription": "Counts demand reads for ownership (RFO) and software prefetches for exclusive ownership (PREFETCHW) that were not supplied by the L3 cache. [L3_MISS_LOCAL is alias to L3_MISS]",
>          "EventCode": "0xB7",
>          "EventName": "OCR.DEMAND_RFO.L3_MISS_LOCAL",
>          "MSRIndex": "0x1a6,0x1a7",
> diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json b/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
> index fa53ff11a509..3153bab527a9 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
> @@ -90,6 +90,14 @@
>          "SampleAfterValue": "200003",
>          "UMask": "0xf7"
>      },
> +    {
> +        "BriefDescription": "Counts the number of near taken branch instructions retired.",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xc0"
> +    },
>      {
>          "BriefDescription": "This event is deprecated. Refer to new event BR_INST_RETIRED.INDIRECT",
>          "Deprecated": "1",
> @@ -183,6 +191,14 @@
>          "SampleAfterValue": "200003",
>          "UMask": "0x7e"
>      },
> +    {
> +        "BriefDescription": "Counts the number of mispredicted near taken branch instructions retired.",
> +        "EventCode": "0xc5",
> +        "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x80"
> +    },
>      {
>          "BriefDescription": "This event is deprecated. Refer to new event BR_MISP_RETIRED.INDIRECT",
>          "Deprecated": "1",
> diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-interconnect.json
> index 4af695a5e755..8bf020a9dfa8 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlaken/uncore-interconnect.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlaken/uncore-interconnect.json
> @@ -7,6 +7,56 @@
>          "UMask": "0x1",
>          "Unit": "ARB"
>      },
> +    {
> +        "BriefDescription": "Each cycle counts number of any coherent request at memory controller that were issued by any core.",
> +        "EventCode": "0x85",
> +        "EventName": "UNC_ARB_DAT_OCCUPANCY.ALL",
> +        "PerPkg": "1",
> +        "UMask": "0x1",
> +        "Unit": "ARB"
> +    },
> +    {
> +        "BriefDescription": "Each cycle counts number of coherent reads pending on data return from memory controller that were issued by any core.",
> +        "EventCode": "0x85",
> +        "EventName": "UNC_ARB_DAT_OCCUPANCY.RD",
> +        "PerPkg": "1",
> +        "UMask": "0x2",
> +        "Unit": "ARB"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new event UNC_ARB_REQ_TRK_REQUEST.DRD",
> +        "Deprecated": "1",
> +        "EventCode": "0x81",
> +        "EventName": "UNC_ARB_DAT_REQUESTS.RD",
> +        "PerPkg": "1",
> +        "UMask": "0x2",
> +        "Unit": "ARB"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new event UNC_ARB_DAT_OCCUPANCY.ALL",
> +        "Deprecated": "1",
> +        "EventCode": "0x85",
> +        "EventName": "UNC_ARB_IFA_OCCUPANCY.ALL",
> +        "PerPkg": "1",
> +        "UMask": "0x1",
> +        "Unit": "ARB"
> +    },
> +    {
> +        "BriefDescription": "Each cycle count number of 'valid' coherent Data Read entries . Such entry is defined as valid when it is allocated till deallocation. Doesn't include prefetches [This event is alias to UNC_ARB_TRK_OCCUPANCY.RD]",
> +        "EventCode": "0x80",
> +        "EventName": "UNC_ARB_REQ_TRK_OCCUPANCY.DRD",
> +        "PerPkg": "1",
> +        "UMask": "0x2",
> +        "Unit": "ARB"
> +    },
> +    {
> +        "BriefDescription": "Number of all coherent Data Read entries. Doesn't include prefetches [This event is alias to UNC_ARB_TRK_REQUESTS.RD]",
> +        "EventCode": "0x81",
> +        "EventName": "UNC_ARB_REQ_TRK_REQUEST.DRD",
> +        "PerPkg": "1",
> +        "UMask": "0x2",
> +        "Unit": "ARB"
> +    },
>      {
>          "BriefDescription": "Each cycle counts number of all outgoing valid entries in ReqTrk. Such entry is defined as valid from its allocation in ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic.",
>          "EventCode": "0x80",
> @@ -15,6 +65,14 @@
>          "UMask": "0x1",
>          "Unit": "ARB"
>      },
> +    {
> +        "BriefDescription": "Each cycle count number of 'valid' coherent Data Read entries . Such entry is defined as valid when it is allocated till deallocation. Doesn't include prefetches [This event is alias to UNC_ARB_REQ_TRK_OCCUPANCY.DRD]",
> +        "EventCode": "0x80",
> +        "EventName": "UNC_ARB_TRK_OCCUPANCY.RD",
> +        "PerPkg": "1",
> +        "UMask": "0x2",
> +        "Unit": "ARB"
> +    },
>      {
>          "BriefDescription": "Counts the number of coherent and in-coherent requests initiated by IA cores, processor graphic units, or LLC.",
>          "EventCode": "0x81",
> @@ -22,5 +80,13 @@
>          "PerPkg": "1",
>          "UMask": "0x1",
>          "Unit": "ARB"
> +    },
> +    {
> +        "BriefDescription": "Number of all coherent Data Read entries. Doesn't include prefetches [This event is alias to UNC_ARB_REQ_TRK_REQUEST.DRD]",
> +        "EventCode": "0x81",
> +        "EventName": "UNC_ARB_TRK_REQUESTS.RD",
> +        "PerPkg": "1",
> +        "UMask": "0x2",
> +        "Unit": "ARB"
>      }
>  ]
> diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
> index 57ba7e814563..c09b81d8d5e1 100644
> --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> @@ -1,6 +1,6 @@
>  Family-model,Version,Filename,EventType
> -GenuineIntel-6-(97|9A|B7|BA|BF),v1.21,alderlake,core
> -GenuineIntel-6-BE,v1.21,alderlaken,core
> +GenuineIntel-6-(97|9A|B7|BA|BF),v1.23,alderlake,core
> +GenuineIntel-6-BE,v1.23,alderlaken,core
>  GenuineIntel-6-(1C|26|27|35|36),v4,bonnell,core
>  GenuineIntel-6-(3D|47),v28,broadwell,core
>  GenuineIntel-6-56,v11,broadwellde,core
