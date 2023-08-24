Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63C578796F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 22:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243535AbjHXUh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 16:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241559AbjHXUhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 16:37:02 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88431E5E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:36:56 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34bad70e7feso33725ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 13:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692909416; x=1693514216; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PD2pxeZOyw5RsGdiTdks9VJq6xiOvrKNj9s+AHgcAF0=;
        b=O686wt7CoSwWdayWSl7wudUUa8P+JeAztpAtAzq2Ven+MpXnLzf4YYB4Mmq7iu4LoB
         LdO9nN3LlVvup6Uslvxz89hUZyk3Nl752S3+WNj4GnB0nSQnrkGvJ9lTeKxpBajeFzmW
         S5SOO9F86sTfcnYX/JU1AX2xaI9akjzMsf43AiPOAEevTL3HV7CyAhQkyJ7y1MOxpVZT
         8QcdpobZiL2hUMykGRxS8CHR6ObZVy8E/CsWBvxpn/gGfFUh6Fd2xT1lGBNhCwnYLNgq
         XpfOMpSPpw0TvGYV7aqJVuMlWlFbPPTSie7A/RHLLfIy2kbLtShwNx5VwcKU0yFcxeyH
         iWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692909416; x=1693514216;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PD2pxeZOyw5RsGdiTdks9VJq6xiOvrKNj9s+AHgcAF0=;
        b=c+zfQfivXl9Gm5QtQeT4mNv5vrH5gZ9nvgL3PTIKU9dwaOlDDQ+g3VpkgpeznXs6WR
         pnnwILSP5pNhc90630tN/bUB96zaDh1jlA/U5heH3MTi09KF+uSqQBXQR9KbHSbrTThu
         Cp/hwZjEeRNz6/EgNtR80loigqaCgDCyY5frG4tvS6nwJIv8BgHAUu3cKQhpu1c3IQZG
         Wrtsv4H+Dk3K+g41/fkdxhMYmXhtke4ebdShufC56P+TJFQsiKBkiOssXIEYhP9cCtyJ
         DgEHX5qQ7mblyh5sffOwhV679V8UNMDlOKSzwqUpxltOz+P0MIXdg4WOpMtnHYxTLk66
         gXHA==
X-Gm-Message-State: AOJu0Yxzrkcl6vNj8G+pFNLynHNIpmhhSpvzfgvdLJ5I2Vyk7zLRVE4J
        zZXCvB39Dfd8bOyBYlMBJV0WDLeAbFUrvR25c5+srg==
X-Google-Smtp-Source: AGHT+IGfIQyPRpWsrj3/u6mqs/HXZ+p5WjxvbFNVO87kxtRERNDmWXsDMxNYR+N7ItsZeoiQFLwgyfFM4scCigb7c9k=
X-Received: by 2002:a05:6e02:1547:b0:33d:6cca:ff8e with SMTP id
 j7-20020a056e02154700b0033d6ccaff8emr76337ilu.22.1692909415221; Thu, 24 Aug
 2023 13:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230824202402.436107-1-irogers@google.com> <20230824202402.436107-2-irogers@google.com>
In-Reply-To: <20230824202402.436107-2-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Aug 2023 13:36:42 -0700
Message-ID: <CAP-5=fWb270XBVLk+o3KiN=rDSaWAcaDS6A2hEgjT=szw2W_xw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf vendor events intel: Fix spelling mistakes
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>,
        Edward Baker <edward.baker@intel.com>
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

On Thu, Aug 24, 2023 at 1:24=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Update perf json files with spelling fixes by Colin Ian King
> <colin.i.king@gmail.com> contributed in:
> https://github.com/intel/perfmon/pull/96
> Fix various spelling mistakes and typos as found using codespell #96
>
> Signed-off-by: Ian Rogers <irogers@google.com>

I think it would be more correct here if Colin Ian King
<colin.i.king@gmail.com> were the author here. I generated the changes
from their work and they posted similar changes to LKML in the past.
I'm not sure what the policy is, and I didn't have Colin's permission
to list them as author, but it'd feel more correct to me for the
author to be changed.

Thanks,
Ian

> ---
>  .../arch/x86/alderlake/adl-metrics.json        |  6 +++---
>  .../arch/x86/alderlake/pipeline.json           |  2 +-
>  .../arch/x86/alderlaken/adln-metrics.json      |  6 +++---
>  .../x86/broadwellde/uncore-interconnect.json   | 18 +++++++++---------
>  .../x86/broadwellx/uncore-interconnect.json    | 18 +++++++++---------
>  .../pmu-events/arch/x86/haswell/memory.json    |  2 +-
>  .../pmu-events/arch/x86/haswellx/memory.json   |  2 +-
>  .../arch/x86/haswellx/uncore-interconnect.json | 18 +++++++++---------
>  .../arch/x86/ivytown/uncore-interconnect.json  | 18 +++++++++---------
>  .../arch/x86/jaketown/uncore-interconnect.json | 18 +++++++++---------
>  .../arch/x86/nehalemep/floating-point.json     |  2 +-
>  .../arch/x86/nehalemex/floating-point.json     |  2 +-
>  .../arch/x86/westmereep-dp/floating-point.json |  2 +-
>  .../arch/x86/westmereep-sp/floating-point.json |  2 +-
>  .../arch/x86/westmereex/floating-point.json    |  2 +-
>  15 files changed, 59 insertions(+), 59 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/=
tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> index c6780d5c456b..8b6bed3bc766 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> @@ -395,13 +395,13 @@
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Instructions per Branch (lower number means=
 higher occurance rate)",
> +        "BriefDescription": "Instructions per Branch (lower number means=
 higher occurrence rate)",
>          "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
>          "MetricName": "tma_info_inst_mix_ipbranch",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Instruction per (near) call (lower number m=
eans higher occurance rate)",
> +        "BriefDescription": "Instruction per (near) call (lower number m=
eans higher occurrence rate)",
>          "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.CALL",
>          "MetricName": "tma_info_inst_mix_ipcall",
>          "Unit": "cpu_atom"
> @@ -726,7 +726,7 @@
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the numer of issue slots  that resul=
t in retirement slots.",
> +        "BriefDescription": "Counts the number of issue slots  that resu=
lt in retirement slots.",
>          "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "TOPDOWN_RETIRING.ALL / tma_info_core_slots",
>          "MetricGroup": "Default;TopdownL1;tma_L1_group",
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/alderlake/pipeline.json
> index cb5b8611064b..a92013cdf136 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
> @@ -1145,7 +1145,7 @@
>          "BriefDescription": "TMA slots wasted due to incorrect speculati=
on by branch mispredictions",
>          "EventCode": "0xa4",
>          "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
> -        "PublicDescription": "Number of TMA slots that were wasted due t=
o incorrect speculation by (any type of) branch mispredictions. This event =
estimates number of specualtive operations that were issued but not retired=
 as well as the out-of-order engine recovery past a branch misprediction.",
> +        "PublicDescription": "Number of TMA slots that were wasted due t=
o incorrect speculation by (any type of) branch mispredictions. This event =
estimates number of speculative operations that were issued but not retired=
 as well as the out-of-order engine recovery past a branch misprediction.",
>          "SampleAfterValue": "10000003",
>          "UMask": "0x8",
>          "Unit": "cpu_core"
> diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json =
b/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
> index 06e67e34e1bf..c150c14ac6ed 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
> @@ -328,12 +328,12 @@
>          "MetricName": "tma_info_inst_mix_idiv_uop_ratio"
>      },
>      {
> -        "BriefDescription": "Instructions per Branch (lower number means=
 higher occurance rate)",
> +        "BriefDescription": "Instructions per Branch (lower number means=
 higher occurrence rate)",
>          "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
>          "MetricName": "tma_info_inst_mix_ipbranch"
>      },
>      {
> -        "BriefDescription": "Instruction per (near) call (lower number m=
eans higher occurance rate)",
> +        "BriefDescription": "Instruction per (near) call (lower number m=
eans higher occurrence rate)",
>          "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.CALL",
>          "MetricName": "tma_info_inst_mix_ipcall"
>      },
> @@ -616,7 +616,7 @@
>          "ScaleUnit": "100%"
>      },
>      {
> -        "BriefDescription": "Counts the numer of issue slots  that resul=
t in retirement slots.",
> +        "BriefDescription": "Counts the number of issue slots  that resu=
lt in retirement slots.",
>          "DefaultMetricgroupName": "TopdownL1",
>          "MetricExpr": "TOPDOWN_RETIRING.ALL / tma_info_core_slots",
>          "MetricGroup": "Default;TopdownL1;tma_L1_group",
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconne=
ct.json b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect.js=
on
> index 8a327e0f1441..910395977a6e 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect.json
> @@ -253,7 +253,7 @@
>          "EventCode": "0x4",
>          "EventName": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requets as well as outbound M=
MIO writes.",
> +        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requests as well as outbound =
MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -261,7 +261,7 @@
>          "EventCode": "0x1",
>          "EventName": "UNC_I_RxR_BL_DRS_INSERTS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requets as well as outbound MMIO=
 writes.",
> +        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requests as well as outbound MMI=
O writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -269,7 +269,7 @@
>          "EventCode": "0x7",
>          "EventName": "UNC_I_RxR_BL_DRS_OCCUPANCY",
>          "PerPkg": "1",
> -        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requets as well as outboun=
d MMIO writes.",
> +        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requests as well as outbou=
nd MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -277,7 +277,7 @@
>          "EventCode": "0x5",
>          "EventName": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requets as well as outbound M=
MIO writes.",
> +        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requests as well as outbound =
MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -285,7 +285,7 @@
>          "EventCode": "0x2",
>          "EventName": "UNC_I_RxR_BL_NCB_INSERTS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requets as well as outbound MMIO=
 writes.",
> +        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requests as well as outbound MMI=
O writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -293,7 +293,7 @@
>          "EventCode": "0x8",
>          "EventName": "UNC_I_RxR_BL_NCB_OCCUPANCY",
>          "PerPkg": "1",
> -        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requets as well as outboun=
d MMIO writes.",
> +        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requests as well as outbou=
nd MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -301,7 +301,7 @@
>          "EventCode": "0x6",
>          "EventName": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requets as well as outbound M=
MIO writes.",
> +        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requests as well as outbound =
MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -309,7 +309,7 @@
>          "EventCode": "0x3",
>          "EventName": "UNC_I_RxR_BL_NCS_INSERTS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requets as well as outbound MMIO=
 writes.",
> +        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requests as well as outbound MMI=
O writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -317,7 +317,7 @@
>          "EventCode": "0x9",
>          "EventName": "UNC_I_RxR_BL_NCS_OCCUPANCY",
>          "PerPkg": "1",
> -        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requets as well as outboun=
d MMIO writes.",
> +        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requests as well as outbou=
nd MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnec=
t.json b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
> index e61a23f68899..b9fb216bee16 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
> @@ -271,7 +271,7 @@
>          "EventCode": "0x4",
>          "EventName": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requets as well as outbound M=
MIO writes.",
> +        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requests as well as outbound =
MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -279,7 +279,7 @@
>          "EventCode": "0x1",
>          "EventName": "UNC_I_RxR_BL_DRS_INSERTS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requets as well as outbound MMIO=
 writes.",
> +        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requests as well as outbound MMI=
O writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -287,7 +287,7 @@
>          "EventCode": "0x7",
>          "EventName": "UNC_I_RxR_BL_DRS_OCCUPANCY",
>          "PerPkg": "1",
> -        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requets as well as outboun=
d MMIO writes.",
> +        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requests as well as outbou=
nd MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -295,7 +295,7 @@
>          "EventCode": "0x5",
>          "EventName": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requets as well as outbound M=
MIO writes.",
> +        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requests as well as outbound =
MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -303,7 +303,7 @@
>          "EventCode": "0x2",
>          "EventName": "UNC_I_RxR_BL_NCB_INSERTS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requets as well as outbound MMIO=
 writes.",
> +        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requests as well as outbound MMI=
O writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -311,7 +311,7 @@
>          "EventCode": "0x8",
>          "EventName": "UNC_I_RxR_BL_NCB_OCCUPANCY",
>          "PerPkg": "1",
> -        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requets as well as outboun=
d MMIO writes.",
> +        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requests as well as outbou=
nd MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -319,7 +319,7 @@
>          "EventCode": "0x6",
>          "EventName": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requets as well as outbound M=
MIO writes.",
> +        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requests as well as outbound =
MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -327,7 +327,7 @@
>          "EventCode": "0x3",
>          "EventName": "UNC_I_RxR_BL_NCS_INSERTS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requets as well as outbound MMIO=
 writes.",
> +        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requests as well as outbound MMI=
O writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -335,7 +335,7 @@
>          "EventCode": "0x9",
>          "EventName": "UNC_I_RxR_BL_NCS_OCCUPANCY",
>          "PerPkg": "1",
> -        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requets as well as outboun=
d MMIO writes.",
> +        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requests as well as outbou=
nd MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/haswell/memory.json b/tools/p=
erf/pmu-events/arch/x86/haswell/memory.json
> index 2fc25e22a42a..df44c28efeeb 100644
> --- a/tools/perf/pmu-events/arch/x86/haswell/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/haswell/memory.json
> @@ -62,7 +62,7 @@
>          "BriefDescription": "Counts the number of machine clears due to =
memory order conflicts.",
>          "EventCode": "0xC3",
>          "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
> -        "PublicDescription": "This event counts the number of memory ord=
ering machine clears detected. Memory ordering machine clears can result fr=
om memory address aliasing or snoops from another hardware thread or core t=
o data inflight in the pipeline.  Machine clears can have a significant per=
formance impact if they are happening frequently.",
> +        "PublicDescription": "This event counts the number of memory ord=
ering machine clears detected. Memory ordering machine clears can result fr=
om memory address aliasing or snoops from another hardware thread or core t=
o data in-flight in the pipeline.  Machine clears can have a significant pe=
rformance impact if they are happening frequently.",
>          "SampleAfterValue": "100003",
>          "UMask": "0x2"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/haswellx/memory.json b/tools/=
perf/pmu-events/arch/x86/haswellx/memory.json
> index 2d212cf59e92..d66e465ce41a 100644
> --- a/tools/perf/pmu-events/arch/x86/haswellx/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/haswellx/memory.json
> @@ -62,7 +62,7 @@
>          "BriefDescription": "Counts the number of machine clears due to =
memory order conflicts.",
>          "EventCode": "0xC3",
>          "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
> -        "PublicDescription": "This event counts the number of memory ord=
ering machine clears detected. Memory ordering machine clears can result fr=
om memory address aliasing or snoops from another hardware thread or core t=
o data inflight in the pipeline.  Machine clears can have a significant per=
formance impact if they are happening frequently.",
> +        "PublicDescription": "This event counts the number of memory ord=
ering machine clears detected. Memory ordering machine clears can result fr=
om memory address aliasing or snoops from another hardware thread or core t=
o data in-flight in the pipeline.  Machine clears can have a significant pe=
rformance impact if they are happening frequently.",
>          "SampleAfterValue": "100003",
>          "UMask": "0x2"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.=
json b/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
> index 954e8198c7a5..bef1f5ef6f31 100644
> --- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
> +++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
> @@ -271,7 +271,7 @@
>          "EventCode": "0x4",
>          "EventName": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requets as well as outbound M=
MIO writes.",
> +        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requests as well as outbound =
MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -279,7 +279,7 @@
>          "EventCode": "0x1",
>          "EventName": "UNC_I_RxR_BL_DRS_INSERTS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requets as well as outbound MMIO=
 writes.",
> +        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requests as well as outbound MMI=
O writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -287,7 +287,7 @@
>          "EventCode": "0x7",
>          "EventName": "UNC_I_RxR_BL_DRS_OCCUPANCY",
>          "PerPkg": "1",
> -        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requets as well as outboun=
d MMIO writes.",
> +        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requests as well as outbou=
nd MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -295,7 +295,7 @@
>          "EventCode": "0x5",
>          "EventName": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requets as well as outbound M=
MIO writes.",
> +        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requests as well as outbound =
MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -303,7 +303,7 @@
>          "EventCode": "0x2",
>          "EventName": "UNC_I_RxR_BL_NCB_INSERTS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requets as well as outbound MMIO=
 writes.",
> +        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requests as well as outbound MMI=
O writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -311,7 +311,7 @@
>          "EventCode": "0x8",
>          "EventName": "UNC_I_RxR_BL_NCB_OCCUPANCY",
>          "PerPkg": "1",
> -        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requets as well as outboun=
d MMIO writes.",
> +        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requests as well as outbou=
nd MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -319,7 +319,7 @@
>          "EventCode": "0x6",
>          "EventName": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requets as well as outbound M=
MIO writes.",
> +        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requests as well as outbound =
MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -327,7 +327,7 @@
>          "EventCode": "0x3",
>          "EventName": "UNC_I_RxR_BL_NCS_INSERTS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requets as well as outbound MMIO=
 writes.",
> +        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requests as well as outbound MMI=
O writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -335,7 +335,7 @@
>          "EventCode": "0x9",
>          "EventName": "UNC_I_RxR_BL_NCS_OCCUPANCY",
>          "PerPkg": "1",
> -        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requets as well as outboun=
d MMIO writes.",
> +        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requests as well as outbou=
nd MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.j=
son b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
> index ccf451534d16..f4d11da01383 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
> @@ -140,7 +140,7 @@
>          "EventCode": "0x4",
>          "EventName": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requets as well as outbound M=
MIO writes.",
> +        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requests as well as outbound =
MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -148,21 +148,21 @@
>          "EventCode": "0x1",
>          "EventName": "UNC_I_RxR_BL_DRS_INSERTS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requets as well as outbound MMIO=
 writes.",
> +        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requests as well as outbound MMI=
O writes.",
>          "Unit": "IRP"
>      },
>      {
>          "EventCode": "0x7",
>          "EventName": "UNC_I_RxR_BL_DRS_OCCUPANCY",
>          "PerPkg": "1",
> -        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requets as well as outboun=
d MMIO writes.",
> +        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requests as well as outbou=
nd MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
>          "EventCode": "0x5",
>          "EventName": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requets as well as outbound M=
MIO writes.",
> +        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requests as well as outbound =
MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -170,21 +170,21 @@
>          "EventCode": "0x2",
>          "EventName": "UNC_I_RxR_BL_NCB_INSERTS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requets as well as outbound MMIO=
 writes.",
> +        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requests as well as outbound MMI=
O writes.",
>          "Unit": "IRP"
>      },
>      {
>          "EventCode": "0x8",
>          "EventName": "UNC_I_RxR_BL_NCB_OCCUPANCY",
>          "PerPkg": "1",
> -        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requets as well as outboun=
d MMIO writes.",
> +        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requests as well as outbou=
nd MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
>          "EventCode": "0x6",
>          "EventName": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requets as well as outbound M=
MIO writes.",
> +        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requests as well as outbound =
MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -192,14 +192,14 @@
>          "EventCode": "0x3",
>          "EventName": "UNC_I_RxR_BL_NCS_INSERTS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requets as well as outbound MMIO=
 writes.",
> +        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requests as well as outbound MMI=
O writes.",
>          "Unit": "IRP"
>      },
>      {
>          "EventCode": "0x9",
>          "EventName": "UNC_I_RxR_BL_NCS_OCCUPANCY",
>          "PerPkg": "1",
> -        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requets as well as outboun=
d MMIO writes.",
> +        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requests as well as outbou=
nd MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.=
json b/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
> index 874f15ea8228..0fc907e5cf3c 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
> @@ -140,7 +140,7 @@
>          "EventCode": "0x4",
>          "EventName": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requets as well as outbound M=
MIO writes.",
> +        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requests as well as outbound =
MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -148,21 +148,21 @@
>          "EventCode": "0x1",
>          "EventName": "UNC_I_RxR_BL_DRS_INSERTS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requets as well as outbound MMIO=
 writes.",
> +        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requests as well as outbound MMI=
O writes.",
>          "Unit": "IRP"
>      },
>      {
>          "EventCode": "0x7",
>          "EventName": "UNC_I_RxR_BL_DRS_OCCUPANCY",
>          "PerPkg": "1",
> -        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requets as well as outboun=
d MMIO writes.",
> +        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requests as well as outbou=
nd MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
>          "EventCode": "0x5",
>          "EventName": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requets as well as outbound M=
MIO writes.",
> +        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requests as well as outbound =
MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -170,21 +170,21 @@
>          "EventCode": "0x2",
>          "EventName": "UNC_I_RxR_BL_NCB_INSERTS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requets as well as outbound MMIO=
 writes.",
> +        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requests as well as outbound MMI=
O writes.",
>          "Unit": "IRP"
>      },
>      {
>          "EventCode": "0x8",
>          "EventName": "UNC_I_RxR_BL_NCB_OCCUPANCY",
>          "PerPkg": "1",
> -        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requets as well as outboun=
d MMIO writes.",
> +        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requests as well as outbou=
nd MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
>          "EventCode": "0x6",
>          "EventName": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requets as well as outbound M=
MIO writes.",
> +        "PublicDescription": "Counts the number of cycles when the BL In=
gress is full.  This queue is where the IRP receives data from R2PCIe (the =
ring).  It is used for data returns from read requests as well as outbound =
MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> @@ -192,14 +192,14 @@
>          "EventCode": "0x3",
>          "EventName": "UNC_I_RxR_BL_NCS_INSERTS",
>          "PerPkg": "1",
> -        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requets as well as outbound MMIO=
 writes.",
> +        "PublicDescription": "Counts the number of allocations into the =
BL Ingress.  This queue is where the IRP receives data from R2PCIe (the rin=
g).  It is used for data returns from read requests as well as outbound MMI=
O writes.",
>          "Unit": "IRP"
>      },
>      {
>          "EventCode": "0x9",
>          "EventName": "UNC_I_RxR_BL_NCS_OCCUPANCY",
>          "PerPkg": "1",
> -        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requets as well as outboun=
d MMIO writes.",
> +        "PublicDescription": "Accumulates the occupancy of the BL Ingres=
s in each cycles.  This queue is where the IRP receives data from R2PCIe (t=
he ring).  It is used for data returns from read requests as well as outbou=
nd MMIO writes.",
>          "Unit": "IRP"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json=
 b/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
> index c03f8990fa82..196ae1d9b157 100644
> --- a/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
> @@ -8,7 +8,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "X87 Floating poiint assists for invalid inp=
ut value (Precise Event)",
> +        "BriefDescription": "X87 Floating point assists for invalid inpu=
t value (Precise Event)",
>          "EventCode": "0xF7",
>          "EventName": "FP_ASSIST.INPUT",
>          "PEBS": "1",
> diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json=
 b/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
> index c03f8990fa82..196ae1d9b157 100644
> --- a/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
> @@ -8,7 +8,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "X87 Floating poiint assists for invalid inp=
ut value (Precise Event)",
> +        "BriefDescription": "X87 Floating point assists for invalid inpu=
t value (Precise Event)",
>          "EventCode": "0xF7",
>          "EventName": "FP_ASSIST.INPUT",
>          "PEBS": "1",
> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.=
json b/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
> index c03f8990fa82..196ae1d9b157 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
> @@ -8,7 +8,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "X87 Floating poiint assists for invalid inp=
ut value (Precise Event)",
> +        "BriefDescription": "X87 Floating point assists for invalid inpu=
t value (Precise Event)",
>          "EventCode": "0xF7",
>          "EventName": "FP_ASSIST.INPUT",
>          "PEBS": "1",
> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.=
json b/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
> index c03f8990fa82..196ae1d9b157 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
> @@ -8,7 +8,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "X87 Floating poiint assists for invalid inp=
ut value (Precise Event)",
> +        "BriefDescription": "X87 Floating point assists for invalid inpu=
t value (Precise Event)",
>          "EventCode": "0xF7",
>          "EventName": "FP_ASSIST.INPUT",
>          "PEBS": "1",
> diff --git a/tools/perf/pmu-events/arch/x86/westmereex/floating-point.jso=
n b/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
> index c03f8990fa82..196ae1d9b157 100644
> --- a/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
> @@ -8,7 +8,7 @@
>          "UMask": "0x1"
>      },
>      {
> -        "BriefDescription": "X87 Floating poiint assists for invalid inp=
ut value (Precise Event)",
> +        "BriefDescription": "X87 Floating point assists for invalid inpu=
t value (Precise Event)",
>          "EventCode": "0xF7",
>          "EventName": "FP_ASSIST.INPUT",
>          "PEBS": "1",
> --
> 2.42.0.rc2.253.gd59a3bf2b4-goog
>
