Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB1C7940F2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242823AbjIFQAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242810AbjIFQAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:00:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F127173D;
        Wed,  6 Sep 2023 09:00:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89408C433C7;
        Wed,  6 Sep 2023 16:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694016029;
        bh=B4iAq7Q+DW1CgEQj24OHGxj3QaEhPBBIM/IQVkjKm24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O6QwiJHyWzA9HhEIaL2i4zPLz8/cCCblULimaHGjWi3cwf41O+X7g5irDgp5hgUe3
         pVXGQ9dp0WxqRalB+ioIo9hBD7kB1AWTxmkhupLd9Ynr0F+TVWndCSqyYxa2kiAPm3
         SXLYRcgXGKuYjX5yJ9ZEaRHpsveOVxeLHqSHxudikOLt6yyRWwLG12avhUOT6ERqXt
         eMYKE3y/zXSH0+zHUGwNbtaCAVBr0OPMrD55x/CoKg8aXXzqX8Mf0GlGy4UDN0CJgs
         jXqPUKKdoIfDFyditwh7ErDDYoK4qgs8ihQOcj2Tf/b6oegmF8Eokf8u/LvPDvDdoN
         W+MlgLdMRVaAQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 055EC403F4; Wed,  6 Sep 2023 13:00:25 -0300 (-03)
Date:   Wed, 6 Sep 2023 13:00:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>,
        Edward Baker <edward.baker@intel.com>
Subject: Re: [PATCH v1 1/2] perf vendor events intel: Add lunarlake v1.0
Message-ID: <ZPiiGW0oqeggm0gT@kernel.org>
References: <20230824202402.436107-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230824202402.436107-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 24, 2023 at 01:24:01PM -0700, Ian Rogers escreveu:
> Add lunarlake events that were added at intel's perfmon site in:
> https://github.com/intel/perfmon/pull/97
> LNL: Release initial events

Thanks, applied the series.

- Arnaldo

=20
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  .../pmu-events/arch/x86/lunarlake/cache.json  | 219 ++++++++++++++++++
>  .../arch/x86/lunarlake/frontend.json          |  27 +++
>  .../pmu-events/arch/x86/lunarlake/memory.json | 183 +++++++++++++++
>  .../pmu-events/arch/x86/lunarlake/other.json  |  62 +++++
>  .../arch/x86/lunarlake/pipeline.json          | 217 +++++++++++++++++
>  .../arch/x86/lunarlake/virtual-memory.json    |  56 +++++
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   1 +
>  7 files changed, 765 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/frontend.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/virtual-memo=
ry.json
>=20
> diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/cache.json b/tools/=
perf/pmu-events/arch/x86/lunarlake/cache.json
> new file mode 100644
> index 000000000000..1823149067b5
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/lunarlake/cache.json
> @@ -0,0 +1,219 @@
> +[
> +    {
> +        "BriefDescription": "Counts the number of L2 Cache Accesses Coun=
ts the total number of L2 Cache Accesses - sum of hits, misses, rejects  fr=
ont door requests for CRd/DRd/RFO/ItoM/L2 Prefetches only, per core event",
> +        "EventCode": "0x24",
> +        "EventName": "L2_REQUEST.ALL",
> +        "PublicDescription": "Counts the number of L2 Cache Accesses Cou=
nts the total number of L2 Cache Accesses - sum of hits, misses, rejects  f=
ront door requests for CRd/DRd/RFO/ItoM/L2 Prefetches only.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x7",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cacheable memory reque=
sts that miss in the LLC. Counts on a per core basis.",
> +        "EventCode": "0x2e",
> +        "EventName": "LONGEST_LAT_CACHE.MISS",
> +        "PublicDescription": "Counts the number of cacheable memory requ=
ests that miss in the Last Level Cache (LLC). Requests include demand loads=
, reads for ownership (RFO), instruction fetches and L1 HW prefetches. If t=
he platform has an L3 cache, the LLC is the L3 cache, otherwise it is the L=
2 cache. Counts on a per core basis.",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x41",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Core-originated cacheable requests that mis=
sed L3  (Except hardware prefetches to the L3)",
> +        "EventCode": "0x2e",
> +        "EventName": "LONGEST_LAT_CACHE.MISS",
> +        "PublicDescription": "Counts core-originated cacheable requests =
that miss the L3 cache (Longest Latency cache). Requests include data and c=
ode reads, Reads-for-Ownership (RFOs), speculative accesses and hardware pr=
efetches to the L1 and L2.  It does not include hardware prefetches to the =
L3, and may not count other types of requests to the L3.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x41",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cacheable memory reque=
sts that access the LLC. Counts on a per core basis.",
> +        "EventCode": "0x2e",
> +        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
> +        "PublicDescription": "Counts the number of cacheable memory requ=
ests that access the Last Level Cache (LLC). Requests include demand loads,=
 reads for ownership (RFO), instruction fetches and L1 HW prefetches. If th=
e platform has an L3 cache, the LLC is the L3 cache, otherwise it is the L2=
 cache. Counts on a per core basis.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x4f",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Core-originated cacheable requests that ref=
er to L3 (Except hardware prefetches to the L3)",
> +        "EventCode": "0x2e",
> +        "EventName": "LONGEST_LAT_CACHE.REFERENCE",
> +        "PublicDescription": "Counts core-originated cacheable requests =
to the L3 cache (Longest Latency cache). Requests include data and code rea=
ds, Reads-for-Ownership (RFOs), speculative accesses and hardware prefetche=
s to the L1 and L2.  It does not include hardware prefetches to the L3, and=
 may not count other types of requests to the L3.",
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
> +        "PublicDescription": "Counts all retired load instructions. This=
 event accounts for SW prefetch instructions of PREFETCHNTA or PREFETCHT0/1=
/2 or PREFETCHW.",
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
> +        "PublicDescription": "Counts all retired store instructions.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x82",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of load uops retired.",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x81",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of store uops retired.",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
> +        "PEBS": "1",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x82",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of tagged load uops retir=
ed that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOL=
D - Only counts with PEBS enabled",
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
> +        "BriefDescription": "Counts the number of tagged load uops retir=
ed that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOL=
D - Only counts with PEBS enabled",
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
> +        "BriefDescription": "Counts the number of tagged load uops retir=
ed that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOL=
D - Only counts with PEBS enabled",
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
> +        "BriefDescription": "Counts the number of tagged load uops retir=
ed that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOL=
D - Only counts with PEBS enabled",
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
> +        "BriefDescription": "Counts the number of tagged load uops retir=
ed that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOL=
D - Only counts with PEBS enabled",
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
> +        "BriefDescription": "Counts the number of tagged load uops retir=
ed that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOL=
D - Only counts with PEBS enabled",
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
> +        "BriefDescription": "Counts the number of tagged load uops retir=
ed that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOL=
D - Only counts with PEBS enabled",
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
> +        "BriefDescription": "Counts the number of tagged load uops retir=
ed that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOL=
D - Only counts with PEBS enabled",
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
> +        "BriefDescription": "Counts the number of tagged load uops retir=
ed that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOL=
D - Only counts with PEBS enabled",
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
> +        "BriefDescription": "Counts the number of tagged load uops retir=
ed that exceed the latency threshold defined in MEC_CR_PEBS_LD_LAT_THRESHOL=
D - Only counts with PEBS enabled",
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
> +        "BriefDescription": "Counts the number of  stores uops retired s=
ame as MEM_UOPS_RETIRED.ALL_STORES",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
> +        "PEBS": "2",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x6",
> +        "Unit": "cpu_atom"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/frontend.json b/too=
ls/perf/pmu-events/arch/x86/lunarlake/frontend.json
> new file mode 100644
> index 000000000000..5e4ef81b43d6
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/lunarlake/frontend.json
> @@ -0,0 +1,27 @@
> +[
> +    {
> +        "BriefDescription": "Counts every time the code stream enters in=
to a new cache line by walking sequential from the previous line or being r=
edirected by a jump.",
> +        "EventCode": "0x80",
> +        "EventName": "ICACHE.ACCESSES",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x3",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts every time the code stream enters in=
to a new cache line by walking sequential from the previous line or being r=
edirected by a jump and the instruction cache registers bytes are not prese=
nt. -",
> +        "EventCode": "0x80",
> +        "EventName": "ICACHE.MISSES",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x2",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This event counts a subset of the Topdown S=
lots event that were no operation was delivered to the back-end pipeline du=
e to instruction fetch limitations when the back-end could have accepted mo=
re operations. Common examples include instruction cache misses or x86 inst=
ruction decode limitations.",
> +        "EventCode": "0x9c",
> +        "EventName": "IDQ_BUBBLES.CORE",
> +        "PublicDescription": "This event counts a subset of the Topdown =
Slots event that were no operation was delivered to the back-end pipeline d=
ue to instruction fetch limitations when the back-end could have accepted m=
ore operations. Common examples include instruction cache misses or x86 ins=
truction decode limitations.\nSoftware can use this event as the numerator =
for the Frontend Bound metric (or top-level category) of the Top-down Micro=
architecture Analysis method.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/memory.json b/tools=
/perf/pmu-events/arch/x86/lunarlake/memory.json
> new file mode 100644
> index 000000000000..51d70ba00bd4
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/lunarlake/memory.json
> @@ -0,0 +1,183 @@
> +[
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the lat=
ency from first dispatch to completion is greater than 1024 cycles.",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_1024",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x400",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 1024 cycles.  Repor=
ted latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "53",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the lat=
ency from first dispatch to completion is greater than 128 cycles.",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x80",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 128 cycles.  Report=
ed latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "1009",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the lat=
ency from first dispatch to completion is greater than 16 cycles.",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x10",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 16 cycles.  Reporte=
d latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "20011",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the lat=
ency from first dispatch to completion is greater than 2048 cycles.",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_2048",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x800",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 2048 cycles.  Repor=
ted latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "23",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the lat=
ency from first dispatch to completion is greater than 256 cycles.",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x100",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 256 cycles.  Report=
ed latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "503",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the lat=
ency from first dispatch to completion is greater than 32 cycles.",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x20",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 32 cycles.  Reporte=
d latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "100007",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the lat=
ency from first dispatch to completion is greater than 4 cycles.",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x4",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 4 cycles.  Reported=
 latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the lat=
ency from first dispatch to completion is greater than 512 cycles.",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x200",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 512 cycles.  Report=
ed latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "101",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the lat=
ency from first dispatch to completion is greater than 64 cycles.",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x40",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 64 cycles.  Reporte=
d latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "2003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts randomly selected loads when the lat=
ency from first dispatch to completion is greater than 8 cycles.",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
> +        "MSRIndex": "0x3F6",
> +        "MSRValue": "0x8",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 8 cycles.  Reported=
 latency may be longer than just the memory latency.",
> +        "SampleAfterValue": "50021",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Retired memory store access operations. A P=
Dist event for PEBS Store Latency Facility.",
> +        "Data_LA": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "MEM_TRANS_RETIRED.STORE_SAMPLE",
> +        "PEBS": "2",
> +        "PublicDescription": "Counts Retired memory accesses with at lea=
st 1 store operation. This PEBS event is the precisely-distributed (PDist) =
trigger covering all stores uops for sampling by the PEBS Store Latency Fac=
ility. The facility is described in Intel SDM Volume 3 section 19.9.8",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts cacheable demand data reads were not=
 supplied by the L3 cache.",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3FBFC00001",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts demand data reads that were not supp=
lied by the L3 cache.",
> +        "EventCode": "0x2A,0x2B",
> +        "EventName": "OCR.DEMAND_DATA_RD.L3_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3FBFC00001",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership, includin=
g SWPREFETCHW which is an RFO were not supplied by the L3 cache.",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_RFO.L3_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3FBFC00002",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts demand read for ownership (RFO) requ=
ests and software prefetches for exclusive ownership (PREFETCHW) that were =
not supplied by the L3 cache.",
> +        "EventCode": "0x2A,0x2B",
> +        "EventName": "OCR.DEMAND_RFO.L3_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3FBFC00002",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/other.json b/tools/=
perf/pmu-events/arch/x86/lunarlake/other.json
> new file mode 100644
> index 000000000000..69adaed5686d
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/lunarlake/other.json
> @@ -0,0 +1,62 @@
> +[
> +    {
> +        "BriefDescription": "Counts cacheable demand data reads Catch al=
l value for any response types - this includes response types not define in=
 the OCR.  If this is set all other response types will be ignored",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10001",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts demand data reads that have any type=
 of response.",
> +        "EventCode": "0x2A,0x2B",
> +        "EventName": "OCR.DEMAND_DATA_RD.ANY_RESPONSE",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10001",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts cacheable demand data reads were sup=
plied by DRAM.",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x184000001",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts demand data reads that were supplied=
 by DRAM.",
> +        "EventCode": "0x2A,0x2B",
> +        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x184000001",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership, includin=
g SWPREFETCHW which is an RFO Catch all value for any response types - this=
 includes response types not define in the OCR.  If this is set all other r=
esponse types will be ignored",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10002",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts demand read for ownership (RFO) requ=
ests and software prefetches for exclusive ownership (PREFETCHW) that have =
any type of response.",
> +        "EventCode": "0x2A,0x2B",
> +        "EventName": "OCR.DEMAND_RFO.ANY_RESPONSE",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10002",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/lunarlake/pipeline.json
> new file mode 100644
> index 000000000000..2bde664fdc0f
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
> @@ -0,0 +1,217 @@
> +[
> +    {
> +        "BriefDescription": "Counts the total number of branch instructi=
ons retired for all branch types.",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
> +        "PEBS": "1",
> +        "PublicDescription": "Counts the total number of instructions in=
 which the instruction pointer (IP) of the processor is resteered due to a =
branch instruction and the branch instruction successfully retires.  All br=
anch type instructions are accounted for.",
> +        "SampleAfterValue": "200003",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "All branch instructions retired.",
> +        "EventCode": "0xc4",
> +        "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
> +        "PEBS": "1",
> +        "PublicDescription": "Counts all branch instructions retired.",
> +        "SampleAfterValue": "400009",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts the total number of mispredicted bra=
nch instructions retired for all branch types.",
> +        "EventCode": "0xc5",
> +        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
> +        "PEBS": "1",
> +        "PublicDescription": "Counts the total number of mispredicted br=
anch instructions retired.  All branch type instructions are accounted for.=
  Prediction of the branch target address enables the processor to begin ex=
ecuting instructions before the non-speculative execution path is known. Th=
e branch prediction unit (BPU) predicts the target address based on the ins=
truction pointer (IP) of the branch and on the execution path through which=
 execution reached this IP.    A branch misprediction occurs when the predi=
ction is wrong, and results in discarding all instructions executed in the =
speculative path and re-fetching from the correct path.",
> +        "SampleAfterValue": "200003",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "All mispredicted branch instructions retire=
d.",
> +        "EventCode": "0xc5",
> +        "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
> +        "PEBS": "1",
> +        "PublicDescription": "Counts all the retired branch instructions=
 that were mispredicted by the processor. A branch misprediction occurs whe=
n the processor incorrectly predicts the destination of the branch.  When t=
he misprediction is discovered at execution, all the instructions executed =
in the wrong (speculative) path must be discarded, and the processor must s=
tart fetching from the correct path.",
> +        "SampleAfterValue": "400009",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Fixed Counter: Counts the number of unhalte=
d core clock cycles",
> +        "EventName": "CPU_CLK_UNHALTED.CORE",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of unhalted core clock cy=
cles [This event is alias to CPU_CLK_UNHALTED.THREAD_P]",
> +        "EventCode": "0x3c",
> +        "EventName": "CPU_CLK_UNHALTED.CORE_P",
> +        "SampleAfterValue": "2000003",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Fixed Counter: Counts the number of unhalte=
d reference clock cycles",
> +        "EventName": "CPU_CLK_UNHALTED.REF_TSC",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x3",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Reference cycles when the core is not in ha=
lt state.",
> +        "EventName": "CPU_CLK_UNHALTED.REF_TSC",
> +        "PublicDescription": "Counts the number of reference cycles when=
 the core is not in a halt state. The core enters the halt state when it is=
 running the HLT instruction or the MWAIT instruction. This event is not af=
fected by core frequency changes (for example, P states, TM2 transitions) b=
ut has the same incrementing frequency as the time stamp counter. This even=
t can approximate elapsed time while the core was not in a halt state. Note=
: On all current platforms this event stops counting during 'throttling (TM=
)' states duty off periods the processor is 'halted'.  The counter update i=
s done at a lower clock rate then the core clock the overflow status bit fo=
r this counter may appear 'sticky'.  After the counter has overflowed and s=
oftware clears the overflow status bit and resets the counter to less than =
MAX. The reset value to the counter is not clocked immediately so the overf=
low status bit will flip 'high (1)' and generate another PMI (if enabled) a=
fter which the reset value gets clocked into the counter. Therefore, softwa=
re will get the interrupt, read the overflow status bit '1 for bit 34 while=
 the counter value is less than MAX. Software should ignore this case.",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x3",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Reference cycles when the core is not in ha=
lt state.",
> +        "EventCode": "0x3c",
> +        "EventName": "CPU_CLK_UNHALTED.REF_TSC_P",
> +        "PublicDescription": "Counts the number of reference cycles when=
 the core is not in a halt state. The core enters the halt state when it is=
 running the HLT instruction or the MWAIT instruction. This event is not af=
fected by core frequency changes (for example, P states, TM2 transitions) b=
ut has the same incrementing frequency as the time stamp counter. This even=
t can approximate elapsed time while the core was not in a halt state. Note=
: On all current platforms this event stops counting during 'throttling (TM=
)' states duty off periods the processor is 'halted'.  The counter update i=
s done at a lower clock rate then the core clock the overflow status bit fo=
r this counter may appear 'sticky'.  After the counter has overflowed and s=
oftware clears the overflow status bit and resets the counter to less than =
MAX. The reset value to the counter is not clocked immediately so the overf=
low status bit will flip 'high (1)' and generate another PMI (if enabled) a=
fter which the reset value gets clocked into the counter. Therefore, softwa=
re will get the interrupt, read the overflow status bit '1 for bit 34 while=
 the counter value is less than MAX. Software should ignore this case.",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Core cycles when the thread is not in halt =
state",
> +        "EventName": "CPU_CLK_UNHALTED.THREAD",
> +        "PublicDescription": "Counts the number of core cycles while the=
 thread is not in a halt state. The thread enters the halt state when it is=
 running the HLT instruction. This event is a component in many key event r=
atios. The core frequency may change from time to time due to transitions a=
ssociated with Enhanced Intel SpeedStep Technology or TM2. For this reason =
this event may have a changing ratio with regards to time. When the core fr=
equency is constant, this event can approximate elapsed time while the core=
 was not in the halt state. It is counted on a dedicated fixed counter, lea=
ving the eight programmable counters available for other events.",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x2",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of unhalted core clock cy=
cles [This event is alias to CPU_CLK_UNHALTED.CORE_P]",
> +        "EventCode": "0x3c",
> +        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
> +        "SampleAfterValue": "2000003",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Thread cycles when thread is not in halt st=
ate",
> +        "EventCode": "0x3c",
> +        "EventName": "CPU_CLK_UNHALTED.THREAD_P",
> +        "PublicDescription": "This is an architectural event that counts=
 the number of thread cycles while the thread is not in a halt state. The t=
hread enters the halt state when it is running the HLT instruction. The cor=
e frequency may change from time to time due to power or thermal throttling=
=2E For this reason, this event may have a changing ratio with regards to w=
all clock time.",
> +        "SampleAfterValue": "2000003",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Fixed Counter: Counts the number of instruc=
tions retired",
> +        "EventName": "INST_RETIRED.ANY",
> +        "PEBS": "1",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Number of instructions retired. Fixed Count=
er - architectural event",
> +        "EventName": "INST_RETIRED.ANY",
> +        "PEBS": "1",
> +        "PublicDescription": "Counts the number of X86 instructions reti=
red - an Architectural PerfMon event. Counting continues during hardware in=
terrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is =
counted by a designated fixed counter freeing up programmable counters to c=
ount other events. INST_RETIRED.ANY_P is counted by a programmable counter.=
",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of instructions retired",
> +        "EventCode": "0xc0",
> +        "EventName": "INST_RETIRED.ANY_P",
> +        "PEBS": "1",
> +        "SampleAfterValue": "2000003",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Number of instructions retired. General Cou=
nter - architectural event",
> +        "EventCode": "0xc0",
> +        "EventName": "INST_RETIRED.ANY_P",
> +        "PEBS": "1",
> +        "PublicDescription": "Counts the number of X86 instructions reti=
red - an Architectural PerfMon event. Counting continues during hardware in=
terrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is =
counted by a designated fixed counter freeing up programmable counters to c=
ount other events. INST_RETIRED.ANY_P is counted by a programmable counter.=
",
> +        "SampleAfterValue": "2000003",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of occurrences a retired =
load gets blocked because its address partially overlaps with an older stor=
e (size mismatch) - unknown_sta/bad_forward",
> +        "EventCode": "0x03",
> +        "EventName": "LD_BLOCKS.STORE_FORWARD",
> +        "PEBS": "1",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Loads blocked due to overlapping with a pre=
ceding store that cannot be forwarded.",
> +        "EventCode": "0x03",
> +        "EventName": "LD_BLOCKS.STORE_FORWARD",
> +        "PublicDescription": "Counts the number of times where store for=
warding was prevented for a load operation. The most common case is a load =
blocked due to the address of memory access (partially) overlapping with a =
preceding uncompleted store. Note: See the table of not supported store for=
wards in the Optimization Guide.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x82",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This event counts a subset of the Topdown S=
lots event that were not consumed by the back-end pipeline due to lack of b=
ack-end resources, as a result of memory subsystem delays, execution units =
limitations, or other conditions.",
> +        "EventCode": "0xa4",
> +        "EventName": "TOPDOWN.BACKEND_BOUND_SLOTS",
> +        "PublicDescription": "This event counts a subset of the Topdown =
Slots event that were not consumed by the back-end pipeline due to lack of =
back-end resources, as a result of memory subsystem delays, execution units=
 limitations, or other conditions.\nSoftware can use this event as the nume=
rator for the Backend Bound metric (or top-level category) of the Top-down =
Microarchitecture Analysis method.",
> +        "SampleAfterValue": "10000003",
> +        "UMask": "0x2",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "TMA slots available for an unhalted logical=
 processor. Fixed counter - architectural event",
> +        "EventName": "TOPDOWN.SLOTS",
> +        "PublicDescription": "Number of available slots for an unhalted =
logical processor. The event increments by machine-width of the narrowest p=
ipeline as employed by the Top-down Microarchitecture Analysis method (TMA)=
=2E Software can use this event as the denominator for the top-level metric=
s of the TMA method. This architectural event is counted on a designated fi=
xed counter (Fixed Counter 3).",
> +        "SampleAfterValue": "10000003",
> +        "UMask": "0x4",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "TMA slots available for an unhalted logical=
 processor. General counter - architectural event",
> +        "EventCode": "0xa4",
> +        "EventName": "TOPDOWN.SLOTS_P",
> +        "PublicDescription": "Counts the number of available slots for a=
n unhalted logical processor. The event increments by machine-width of the =
narrowest pipeline as employed by the Top-down Microarchitecture Analysis m=
ethod.",
> +        "SampleAfterValue": "10000003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Fixed Counter: Counts the number of issue s=
lots that were not consumed by the backend because allocation is stalled du=
e to a mispredicted jump or a machine clear.",
> +        "EventName": "TOPDOWN_BAD_SPECULATION.ALL",
> +        "PublicDescription": "Fixed Counter: Counts the number of issue =
slots that were not consumed by the backend because allocation is stalled d=
ue to a mispredicted jump or a machine clear.  Counts all issue slots block=
ed during this recovery window including relevant microcode flows and while=
 uops are not yet available in the IQ. Also, includes the issue slots that =
were consumed by the backend but were thrown away because they were younger=
 than the mispredict or machine clear.",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x5",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of retirement slots not c=
onsumed due to backend stalls",
> +        "EventCode": "0xa4",
> +        "EventName": "TOPDOWN_BE_BOUND.ALL",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Fixed Counter: Counts the number of retirem=
ent slots not consumed due to front end stalls",
> +        "EventName": "TOPDOWN_FE_BOUND.ALL",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x6",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Fixed Counter: Counts the number of consume=
d retirement slots.  Similar to UOPS_RETIRED.ALL",
> +        "EventName": "TOPDOWN_RETIRING.ALL",
> +        "PEBS": "1",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x7",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This event counts a subset of the Topdown S=
lots event that are utilized by operations that eventually get retired (com=
mitted) by the processor pipeline. Usually, this event positively correlate=
s with higher performance  for example, as measured by the instructions-per=
-cycle metric.",
> +        "EventCode": "0xc2",
> +        "EventName": "UOPS_RETIRED.SLOTS",
> +        "PublicDescription": "This event counts a subset of the Topdown =
Slots event that are utilized by operations that eventually get retired (co=
mmitted) by the processor pipeline. Usually, this event positively correlat=
es with higher performance  for example, as measured by the instructions-pe=
r-cycle metric.\nSoftware can use this event as the numerator for the Retir=
ing metric (or top-level category) of the Top-down Microarchitecture Analys=
is method.",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x2",
> +        "Unit": "cpu_core"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/virtual-memory.json=
 b/tools/perf/pmu-events/arch/x86/lunarlake/virtual-memory.json
> new file mode 100644
> index 000000000000..bb9458799f1c
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/lunarlake/virtual-memory.json
> @@ -0,0 +1,56 @@
> +[
> +    {
> +        "BriefDescription": "Counts the number of page walks completed d=
ue to load DTLB misses to any page size.",
> +        "EventCode": "0x08",
> +        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
> +        "PublicDescription": "Counts the number of page walks completed =
due to loads (including SW prefetches) whose address translations missed in=
 all Translation Lookaside Buffer (TLB) levels and were mapped to any page =
size. Includes page walks that page fault.",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0xe",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Load miss in all TLB levels causes a page w=
alk that completes. (All page sizes)",
> +        "EventCode": "0x12",
> +        "EventName": "DTLB_LOAD_MISSES.WALK_COMPLETED",
> +        "PublicDescription": "Counts completed page walks  (all page siz=
es) caused by demand data loads. This implies it missed in the DTLB and fur=
ther levels of TLB. The page walk can end with or without a fault.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0xe",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of page walks completed d=
ue to store DTLB misses to any page size.",
> +        "EventCode": "0x49",
> +        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
> +        "PublicDescription": "Counts the number of page walks completed =
due to stores whose address translations missed in all Translation Lookasid=
e Buffer (TLB) levels and were mapped to any page size.  Includes page walk=
s that page fault.",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0xe",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Store misses in all TLB levels causes a pag=
e walk that completes. (All page sizes)",
> +        "EventCode": "0x13",
> +        "EventName": "DTLB_STORE_MISSES.WALK_COMPLETED",
> +        "PublicDescription": "Counts completed page walks  (all page siz=
es) caused by demand data stores. This implies it missed in the DTLB and fu=
rther levels of TLB. The page walk can end with or without a fault.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0xe",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of page walks completed d=
ue to instruction fetch misses to any page size.",
> +        "EventCode": "0x85",
> +        "EventName": "ITLB_MISSES.WALK_COMPLETED",
> +        "PublicDescription": "Counts the number of page walks completed =
due to instruction fetches whose address translations missed in all Transla=
tion Lookaside Buffer (TLB) levels and were mapped to any page size.  Inclu=
des page walks that page fault.",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0xe",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Code miss in all TLB levels causes a page w=
alk that completes. (All page sizes)",
> +        "EventCode": "0x11",
> +        "EventName": "ITLB_MISSES.WALK_COMPLETED",
> +        "PublicDescription": "Counts completed page walks (all page size=
s) caused by a code fetch. This implies it missed in the ITLB (Instruction =
TLB) and further levels of TLB. The page walk can end with or without a fau=
lt.",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0xe",
> +        "Unit": "cpu_core"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-=
events/arch/x86/mapfile.csv
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
> --=20
> 2.42.0.rc2.253.gd59a3bf2b4-goog
>=20

--=20

- Arnaldo
