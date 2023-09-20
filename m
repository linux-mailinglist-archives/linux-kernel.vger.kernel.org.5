Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B127A89A4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbjITQke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbjITQkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:40:32 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FF1CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:40:24 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-415155b2796so405591cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695228023; x=1695832823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwG85VFJON3DuTqKWcUmSuv6jkWLQ8Avrej5F5wpGzM=;
        b=jFrDxtRieNrg7Nnab1IF/y2P3MDy4UZ9vx0pyMre25hKG2D+JgbRQ6Q7tYESq29St4
         jzhoFAe9XquLDg1n0Pr3ltfZuF1qifn9CIe668ZJb8GCczsQQItFUWMLBo7F1u7DXv/3
         kVzec6uCeZLdO6nkYcD94DZYCMGLuEFV57sQ1OiSw6SIIhF0KhQYe8MKfHz0P3tKOc0L
         Rk6emqT24Z3GGsdBXTFsaOo2O7sVGg+aT9gkyel3qV1nttXOnzrG5tZGrM2O7A6EMVyW
         GFI9VRq7nWCsQCKNCBVIfgpCROn6IZzMe5gcvzPs4EG8M+FmPWhrnaAHXI1+e+v/pPmh
         8nyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695228023; x=1695832823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwG85VFJON3DuTqKWcUmSuv6jkWLQ8Avrej5F5wpGzM=;
        b=Md3yUdP9RD9XLJTkFc+r14clxnf1yRN6dW1T1JnGkSWmsFSKhX915goJaR9qirQidq
         VQQhh6c74uk5O5wvDsxhvaFqRSwdjvVPGVujym6y6kzp5gxpqCzlIaN3LfIWRRS1cW0y
         gba8HzGp8hZNLkRH2ilMUb6lPty/Lc7sY/mCTImsZoW3EpcFACv/ZfEayD4tUXxhWo58
         WQjWCQ0l9gpz6iIeeiVGwmVh+dfue8PNiDWAWfgymiUa2BRze9CX3wtIOpQInj+5Lc3h
         mCmr9Szf42f82uI+emxwVDRagd6aAXeLrAR+iiTcd/Wk+e4cgyHjrM22GE9obfyJgGm8
         l4tQ==
X-Gm-Message-State: AOJu0YxOiElJDseOrrLUUye4OeQ/qANHXXqMLr+HwnKVUvsPbwI1s09e
        pjBOh1ZHUiTYG9VP5M0epW8rDCmShdLEt4J8mowggw==
X-Google-Smtp-Source: AGHT+IGMc5I6KasyQGn672R4+uOGdgt3oCOpiY46NS50obr6tHCRjUJ+a+r8VoeLaGxlmiLk1UZ+Q9Fszdztq+jod+0=
X-Received: by 2002:a05:622a:303:b0:417:b70f:1a6a with SMTP id
 q3-20020a05622a030300b00417b70f1a6amr329036qtw.28.1695228023111; Wed, 20 Sep
 2023 09:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230920061839.2437413-1-ilkka@os.amperecomputing.com>
In-Reply-To: <20230920061839.2437413-1-ilkka@os.amperecomputing.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Sep 2023 09:40:11 -0700
Message-ID: <CAP-5=fX0JYb96A+RCtJpSvqoz4Ya306FJZ3gRUX3o_Qj7Jaisg@mail.gmail.com>
Subject: Re: [PATCH v2] perf vendor events arm64: Fix for AmpereOne metrics
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        D Scott Phillips <scott@os.amperecomputing.com>
Cc:     James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 11:19=E2=80=AFPM Ilkka Koskinen
<ilkka@os.amperecomputing.com> wrote:
>
> This patch addresses review comments that were given for
> 705ed549148f ("perf vendor events arm64: Add AmpereOne metrics")
> but didn't make it to the original patch [1][2]
>
> Changes include: A fix for backend_memory formula, use of standard metric=
s
> when possible, using #slots, renaming metrics to avoid spaces in the name=
s,
> and cleanup.
>
> [1] https://lore.kernel.org/linux-perf-users/e9bdacb-a231-36af-6a2e-6918e=
e7effa@os.amperecomputing.com/
> [2] https://lore.kernel.org/linux-perf-users/20230826192352.3043220-1-ilk=
ka@os.amperecomputing.com/
>
> Fixes: 705ed549148f ("perf vendor events arm64: Add AmpereOne metrics")
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Reviewed-by: Ian Rogers <irogers@google.com>

> ---
> Fixed the scaling issues on some of the metrics in v1.
>
> I'll be offline for a couple of weeks but Scott can address any review
> comments meanwhile.
>
> Cheers, Ilkka
>
> .../arch/arm64/ampere/ampereone/metrics.json  | 418 +++++++++---------
>  1 file changed, 220 insertions(+), 198 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.js=
on b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
> index 1e7e8901a445..e2848a9d4848 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
> @@ -1,362 +1,384 @@
>  [
>      {
> +       "MetricName": "branch_miss_pred_rate",
>         "MetricExpr": "BR_MIS_PRED / BR_PRED",
>         "BriefDescription": "Branch predictor misprediction rate. May not=
 count branches that are never resolved because they are in the mispredicti=
on shadow of an earlier branch",
> -       "MetricGroup": "Branch Prediction",
> -       "MetricName": "Misprediction"
> +       "MetricGroup": "branch",
> +        "ScaleUnit": "100%"
>      },
>      {
> -       "MetricExpr": "BR_MIS_PRED_RETIRED / BR_RETIRED",
> -       "BriefDescription": "Branch predictor misprediction rate",
> -       "MetricGroup": "Branch Prediction",
> -       "MetricName": "Misprediction (retired)"
> -    },
> -    {
> -       "MetricExpr": "BUS_ACCESS / ( BUS_CYCLES * 1)",
> +       "MetricName": "bus_utilization",
> +       "MetricExpr": "((BUS_ACCESS / (BUS_CYCLES * 1)) * 100)",
>         "BriefDescription": "Core-to-uncore bus utilization",
>         "MetricGroup": "Bus",
> -       "MetricName": "Bus utilization"
> +        "ScaleUnit": "1percent of bus cycles"

nits: this could be "100percent of bus cycles" and then you needn't "*
100" as you did above, but this doesn't matter as they are equivalent.
There are a few acronyms in the metric descriptions (IXU, LOB, ROB,
SOB) perhaps they could be added to:
https://perf.wiki.kernel.org/index.php/Glossary

Thanks,
Ian

>      },
>      {
> -       "MetricExpr": "L1D_CACHE_REFILL / L1D_CACHE",
> -       "BriefDescription": "L1D cache miss rate",
> -       "MetricGroup": "Cache",
> -       "MetricName": "L1D cache miss"
> +        "MetricName": "l1d_cache_miss_ratio",
> +        "MetricExpr": "(L1D_CACHE_REFILL / L1D_CACHE)",
> +        "BriefDescription": "This metric measures the ratio of level 1 d=
ata cache accesses missed to the total number of level 1 data cache accesse=
s. This gives an indication of the effectiveness of the level 1 data cache.=
",
> +        "MetricGroup": "Miss_Ratio;L1D_Cache_Effectiveness",
> +        "ScaleUnit": "1per cache access"
> +    },
> +    {
> +        "MetricName": "l1i_cache_miss_ratio",
> +        "MetricExpr": "(L1I_CACHE_REFILL / L1I_CACHE)",
> +        "BriefDescription": "This metric measures the ratio of level 1 i=
nstruction cache accesses missed to the total number of level 1 instruction=
 cache accesses. This gives an indication of the effectiveness of the level=
 1 instruction cache.",
> +        "MetricGroup": "Miss_Ratio;L1I_Cache_Effectiveness",
> +        "ScaleUnit": "1per cache access"
>      },
>      {
> +       "MetricName": "Miss_Ratio;l1d_cache_read_miss",
>         "MetricExpr": "L1D_CACHE_LMISS_RD / L1D_CACHE_RD",
>         "BriefDescription": "L1D cache read miss rate",
>         "MetricGroup": "Cache",
> -       "MetricName": "L1D cache read miss"
> +        "ScaleUnit": "1per cache read access"
>      },
>      {
> -       "MetricExpr": "L1I_CACHE_REFILL / L1I_CACHE",
> -       "BriefDescription": "L1I cache miss rate",
> -       "MetricGroup": "Cache",
> -       "MetricName": "L1I cache miss"
> -    },
> -    {
> -       "MetricExpr": "L2D_CACHE_REFILL / L2D_CACHE",
> -       "BriefDescription": "L2 cache miss rate",
> -       "MetricGroup": "Cache",
> -       "MetricName": "L2 cache miss"
> +        "MetricName": "l2_cache_miss_ratio",
> +        "MetricExpr": "(L2D_CACHE_REFILL / L2D_CACHE)",
> +        "BriefDescription": "This metric measures the ratio of level 2 c=
ache accesses missed to the total number of level 2 cache accesses. This gi=
ves an indication of the effectiveness of the level 2 cache, which is a uni=
fied cache that stores both data and instruction. Note that cache accesses =
in this cache are either data memory access or instruction fetch as this is=
 a unified cache.",
> +        "MetricGroup": "Miss_Ratio;L2_Cache_Effectiveness",
> +        "ScaleUnit": "1per cache access"
>      },
>      {
> +       "MetricName": "l1i_cache_read_miss_rate",
>         "MetricExpr": "L1I_CACHE_LMISS / L1I_CACHE",
>         "BriefDescription": "L1I cache read miss rate",
>         "MetricGroup": "Cache",
> -       "MetricName": "L1I cache read miss"
> +        "ScaleUnit": "1per cache access"
>      },
>      {
> +       "MetricName": "l2d_cache_read_miss_rate",
>         "MetricExpr": "L2D_CACHE_LMISS_RD / L2D_CACHE_RD",
>         "BriefDescription": "L2 cache read miss rate",
>         "MetricGroup": "Cache",
> -       "MetricName": "L2 cache read miss"
> +        "ScaleUnit": "1per cache read access"
>      },
>      {
> -       "MetricExpr": "(L1D_CACHE_LMISS_RD * 1000) / INST_RETIRED",
> +       "MetricName": "l1d_cache_miss_mpki",
> +       "MetricExpr": "(L1D_CACHE_LMISS_RD * 1e3) / INST_RETIRED",
>         "BriefDescription": "Misses per thousand instructions (data)",
>         "MetricGroup": "Cache",
> -       "MetricName": "MPKI data"
> +        "ScaleUnit": "1MPKI"
>      },
>      {
> -       "MetricExpr": "(L1I_CACHE_LMISS * 1000) / INST_RETIRED",
> +       "MetricName": "l1i_cache_miss_mpki",
> +       "MetricExpr": "(L1I_CACHE_LMISS * 1e3) / INST_RETIRED",
>         "BriefDescription": "Misses per thousand instructions (instructio=
n)",
>         "MetricGroup": "Cache",
> -       "MetricName": "MPKI instruction"
> +        "ScaleUnit": "1MPKI"
>      },
>      {
> -       "MetricExpr": "ASE_SPEC / OP_SPEC",
> -       "BriefDescription": "Proportion of advanced SIMD data processing =
operations (excluding DP_SPEC/LD_SPEC) operations",
> -       "MetricGroup": "Instruction",
> -       "MetricName": "ASE mix"
> +        "MetricName": "simd_percentage",
> +        "MetricExpr": "((ASE_SPEC / INST_SPEC) * 100)",
> +        "BriefDescription": "This metric measures advanced SIMD operatio=
ns as a percentage of total operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
>      },
>      {
> -       "MetricExpr": "CRYPTO_SPEC / OP_SPEC",
> -       "BriefDescription": "Proportion of crypto data processing operati=
ons",
> -       "MetricGroup": "Instruction",
> -       "MetricName": "Crypto mix"
> +        "MetricName": "crypto_percentage",
> +        "MetricExpr": "((CRYPTO_SPEC / INST_SPEC) * 100)",
> +        "BriefDescription": "This metric measures crypto operations as a=
 percentage of operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
>      },
>      {
> -       "MetricExpr": "VFP_SPEC / (duration_time *1000000000)",
> +       "MetricName": "gflops",
> +       "MetricExpr": "VFP_SPEC / (duration_time * 1e9)",
>         "BriefDescription": "Giga-floating point operations per second",
> -       "MetricGroup": "Instruction",
> -       "MetricName": "GFLOPS_ISSUED"
> +       "MetricGroup": "InstructionMix"
>      },
>      {
> -       "MetricExpr": "DP_SPEC / OP_SPEC",
> -       "BriefDescription": "Proportion of integer data processing operat=
ions",
> -       "MetricGroup": "Instruction",
> -       "MetricName": "Integer mix"
> +        "MetricName": "integer_dp_percentage",
> +        "MetricExpr": "((DP_SPEC / INST_SPEC) * 100)",
> +        "BriefDescription": "This metric measures scalar integer operati=
ons as a percentage of operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
>      },
>      {
> -       "MetricExpr": "INST_RETIRED / CPU_CYCLES",
> -       "BriefDescription": "Instructions per cycle",
> -       "MetricGroup": "Instruction",
> -       "MetricName": "IPC"
> +        "MetricName": "ipc",
> +        "MetricExpr": "(INST_RETIRED / CPU_CYCLES)",
> +        "BriefDescription": "This metric measures the number of instruct=
ions retired per cycle.",
> +        "MetricGroup": "General",
> +        "ScaleUnit": "1per cycle"
>      },
>      {
> -       "MetricExpr": "LD_SPEC / OP_SPEC",
> -       "BriefDescription": "Proportion of load operations",
> -       "MetricGroup": "Instruction",
> -       "MetricName": "Load mix"
> +        "MetricName": "load_percentage",
> +        "MetricExpr": "((LD_SPEC / INST_SPEC) * 100)",
> +        "BriefDescription": "This metric measures load operations as a p=
ercentage of operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
>      },
>      {
> -       "MetricExpr": "LDST_SPEC/ OP_SPEC",
> -       "BriefDescription": "Proportion of load & store operations",
> -       "MetricGroup": "Instruction",
> -       "MetricName": "Load-store mix"
> +       "MetricName": "load_store_spec_rate",
> +       "MetricExpr": "((LDST_SPEC / INST_SPEC) * 100)",
> +       "BriefDescription": "The rate of load or store instructions specu=
latively executed to overall instructions speclatively executed",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
>      },
>      {
> -       "MetricExpr": "INST_RETIRED / (duration_time * 1000000)",
> +       "MetricName": "retired_mips",
> +       "MetricExpr": "INST_RETIRED / (duration_time * 1e6)",
>         "BriefDescription": "Millions of instructions per second",
> -       "MetricGroup": "Instruction",
> -       "MetricName": "MIPS_RETIRED"
> +       "MetricGroup": "InstructionMix"
>      },
>      {
> -       "MetricExpr": "INST_SPEC / (duration_time * 1000000)",
> +       "MetricName": "spec_utilization_mips",
> +       "MetricExpr": "INST_SPEC / (duration_time * 1e6)",
>         "BriefDescription": "Millions of instructions per second",
> -       "MetricGroup": "Instruction",
> -       "MetricName": "MIPS_UTILIZATION"
> -    },
> -    {
> -       "MetricExpr": "PC_WRITE_SPEC / OP_SPEC",
> -       "BriefDescription": "Proportion of software change of PC operatio=
ns",
> -       "MetricGroup": "Instruction",
> -       "MetricName": "PC write mix"
> +       "MetricGroup": "PEutilization"
>      },
>      {
> -       "MetricExpr": "ST_SPEC / OP_SPEC",
> -       "BriefDescription": "Proportion of store operations",
> -       "MetricGroup": "Instruction",
> -       "MetricName": "Store mix"
> +       "MetricName": "pc_write_spec_rate",
> +       "MetricExpr": "((PC_WRITE_SPEC / INST_SPEC) * 100)",
> +       "BriefDescription": "The rate of software change of the PC specul=
atively executed to overall instructions speclatively executed",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
>      },
>      {
> -       "MetricExpr": "VFP_SPEC / OP_SPEC",
> -       "BriefDescription": "Proportion of FP operations",
> -       "MetricGroup": "Instruction",
> -       "MetricName": "VFP mix"
> +        "MetricName": "store_percentage",
> +        "MetricExpr": "((ST_SPEC / INST_SPEC) * 100)",
> +        "BriefDescription": "This metric measures store operations as a =
percentage of operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
>      },
>      {
> -       "MetricExpr": "1 - (OP_RETIRED/ (CPU_CYCLES * 4))",
> -       "BriefDescription": "Proportion of slots lost",
> -       "MetricGroup": "Speculation / TDA",
> -       "MetricName": "CPU lost"
> +        "MetricName": "scalar_fp_percentage",
> +        "MetricExpr": "((VFP_SPEC / INST_SPEC) * 100)",
> +        "BriefDescription": "This metric measures scalar floating point =
operations as a percentage of operations speculatively executed.",
> +        "MetricGroup": "Operation_Mix",
> +        "ScaleUnit": "1percent of operations"
>      },
>      {
> -       "MetricExpr": "OP_RETIRED/ (CPU_CYCLES * 4)",
> -       "BriefDescription": "Proportion of slots retiring",
> -       "MetricGroup": "Speculation / TDA",
> -       "MetricName": "CPU utilization"
> +        "MetricName": "retired_rate",
> +        "MetricExpr": "OP_RETIRED / OP_SPEC",
> +        "BriefDescription": "Of all the micro-operations issued, what pe=
rcentage are retired(committed)",
> +        "MetricGroup": "General",
> +        "ScaleUnit": "100%"
>      },
>      {
> -       "MetricExpr": "OP_RETIRED - OP_SPEC",
> -       "BriefDescription": "Operations lost due to misspeculation",
> -       "MetricGroup": "Speculation / TDA",
> -       "MetricName": "Operations lost"
> +       "MetricName": "wasted",
> +       "MetricExpr": "1 - (OP_RETIRED / (CPU_CYCLES * #slots))",
> +        "BriefDescription": "Of all the micro-operations issued, what pr=
oportion are lost",
> +       "MetricGroup": "General",
> +       "ScaleUnit": "100%"
>      },
>      {
> -       "MetricExpr": "1 - (OP_RETIRED / OP_SPEC)",
> -       "BriefDescription": "Proportion of operations lost",
> -       "MetricGroup": "Speculation / TDA",
> -       "MetricName": "Operations lost (ratio)"
> +        "MetricName": "wasted_rate",
> +        "MetricExpr": "1 - OP_RETIRED / OP_SPEC",
> +        "BriefDescription": "Of all the micro-operations issued, what pe=
rcentage are not retired(committed)",
> +        "MetricGroup": "General",
> +        "ScaleUnit": "100%"
>      },
>      {
> -       "MetricExpr": "OP_RETIRED / OP_SPEC",
> -       "BriefDescription": "Proportion of operations retired",
> -       "MetricGroup": "Speculation / TDA",
> -       "MetricName": "Operations retired"
> -    },
> -    {
> -       "MetricExpr": "STALL_BACKEND_CACHE / CPU_CYCLES",
> +       "MetricName": "stall_backend_cache_rate",
> +       "MetricExpr": "((STALL_BACKEND_CACHE / CPU_CYCLES) * 100)",
>         "BriefDescription": "Proportion of cycles stalled and no operatio=
ns issued to backend and cache miss",
>         "MetricGroup": "Stall",
> -       "MetricName": "Stall backend cache cycles"
> +        "ScaleUnit": "1percent of cycles"
>      },
>      {
> -       "MetricExpr": "STALL_BACKEND_RESOURCE / CPU_CYCLES",
> +       "MetricName": "stall_backend_resource_rate",
> +       "MetricExpr": "((STALL_BACKEND_RESOURCE / CPU_CYCLES) * 100)",
>         "BriefDescription": "Proportion of cycles stalled and no operatio=
ns issued to backend and resource full",
>         "MetricGroup": "Stall",
> -       "MetricName": "Stall backend resource cycles"
> +        "ScaleUnit": "1percent of cycles"
>      },
>      {
> -       "MetricExpr": "STALL_BACKEND_TLB / CPU_CYCLES",
> +       "MetricName": "stall_backend_tlb_rate",
> +       "MetricExpr": "((STALL_BACKEND_TLB / CPU_CYCLES) * 100)",
>         "BriefDescription": "Proportion of cycles stalled and no operatio=
ns issued to backend and TLB miss",
>         "MetricGroup": "Stall",
> -       "MetricName": "Stall backend tlb cycles"
> +        "ScaleUnit": "1percent of cycles"
>      },
>      {
> -       "MetricExpr": "STALL_FRONTEND_CACHE / CPU_CYCLES",
> +       "MetricName": "stall_frontend_cache_rate",
> +       "MetricExpr": "((STALL_FRONTEND_CACHE / CPU_CYCLES) * 100)",
>         "BriefDescription": "Proportion of cycles stalled and no ops deli=
vered from frontend and cache miss",
>         "MetricGroup": "Stall",
> -       "MetricName": "Stall frontend cache cycles"
> +        "ScaleUnit": "1percent of cycles"
>      },
>      {
> -       "MetricExpr": "STALL_FRONTEND_TLB / CPU_CYCLES",
> +       "MetricName": "stall_frontend_tlb_rate",
> +       "MetricExpr": "((STALL_FRONTEND_TLB / CPU_CYCLES) * 100)",
>         "BriefDescription": "Proportion of cycles stalled and no ops deli=
vered from frontend and TLB miss",
>         "MetricGroup": "Stall",
> -       "MetricName": "Stall frontend tlb cycles"
> +        "ScaleUnit": "1percent of cycles"
>      },
>      {
> -       "MetricExpr": "DTLB_WALK / L1D_TLB",
> -       "BriefDescription": "D-side walk per d-side translation request",
> -       "MetricGroup": "TLB",
> -       "MetricName": "DTLB walks"
> +        "MetricName": "dtlb_walk_ratio",
> +        "MetricExpr": "(DTLB_WALK / L1D_TLB)",
> +        "BriefDescription": "This metric measures the ratio of data TLB =
Walks to the total number of data TLB accesses. This gives an indication of=
 the effectiveness of the data TLB accesses.",
> +        "MetricGroup": "Miss_Ratio;DTLB_Effectiveness",
> +        "ScaleUnit": "1per TLB access"
>      },
>      {
> -       "MetricExpr": "ITLB_WALK / L1I_TLB",
> -       "BriefDescription": "I-side walk per i-side translation request",
> -       "MetricGroup": "TLB",
> -       "MetricName": "ITLB walks"
> +        "MetricName": "itlb_walk_ratio",
> +        "MetricExpr": "(ITLB_WALK / L1I_TLB)",
> +        "BriefDescription": "This metric measures the ratio of instructi=
on TLB Walks to the total number of instruction TLB accesses. This gives an=
 indication of the effectiveness of the instruction TLB accesses.",
> +        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness",
> +        "ScaleUnit": "1per TLB access"
>      },
>      {
> -        "MetricExpr": "STALL_SLOT_BACKEND / (CPU_CYCLES * 4)",
> -        "BriefDescription": "Fraction of slots backend bound",
> -        "MetricGroup": "TopDownL1",
> -        "MetricName": "backend"
> +        "ArchStdEvent": "backend_bound"
>      },
>      {
> -        "MetricExpr": "1 - (retiring + lost + backend)",
> -        "BriefDescription": "Fraction of slots frontend bound",
> -        "MetricGroup": "TopDownL1",
> -        "MetricName": "frontend"
> +        "ArchStdEvent": "frontend_bound",
> +        "MetricExpr": "100 - (retired_fraction + slots_lost_misspeculati=
on_fraction + backend_bound)"
>      },
>      {
> -        "MetricExpr": "((OP_SPEC - OP_RETIRED) / (CPU_CYCLES * 4))",
> +        "MetricName": "slots_lost_misspeculation_fraction",
> +        "MetricExpr": "100 * ((OP_SPEC - OP_RETIRED) / (CPU_CYCLES * #sl=
ots))",
>          "BriefDescription": "Fraction of slots lost due to misspeculatio=
n",
> -        "MetricGroup": "TopDownL1",
> -        "MetricName": "lost"
> +        "MetricGroup": "Default;TopdownL1",
> +        "ScaleUnit": "1percent of slots"
>      },
>      {
> -        "MetricExpr": "(OP_RETIRED / (CPU_CYCLES * 4))",
> +        "MetricName": "retired_fraction",
> +        "MetricExpr": "100 * (OP_RETIRED / (CPU_CYCLES * #slots))",
>          "BriefDescription": "Fraction of slots retiring, useful work",
> -        "MetricGroup": "TopDownL1",
> -        "MetricName": "retiring"
> +        "MetricGroup": "Default;TopdownL1",
> +       "ScaleUnit": "1percent of slots"
>      },
>      {
> -        "MetricExpr": "backend - backend_memory",
> +        "MetricName": "backend_core",
> +        "MetricExpr": "(backend_bound / 100) - backend_memory",
>          "BriefDescription": "Fraction of slots the CPU was stalled due t=
o backend non-memory subsystem issues",
> -        "MetricGroup": "TopDownL2",
> -        "MetricName": "backend_core"
> +        "MetricGroup": "TopdownL2",
> +        "ScaleUnit": "100%"
>      },
>      {
> -        "MetricExpr": "(STALL_BACKEND_TLB + STALL_BACKEND_CACHE + STALL_=
BACKEND_MEM) / CPU_CYCLES ",
> +        "MetricName": "backend_memory",
> +        "MetricExpr": "(STALL_BACKEND_TLB + STALL_BACKEND_CACHE) / CPU_C=
YCLES",
>          "BriefDescription": "Fraction of slots the CPU was stalled due t=
o backend memory subsystem issues (cache/tlb miss)",
> -        "MetricGroup": "TopDownL2",
> -        "MetricName": "backend_memory"
> +        "MetricGroup": "TopdownL2",
> +        "ScaleUnit": "100%"
>      },
>      {
> -        "MetricExpr": " (BR_MIS_PRED_RETIRED / GPC_FLUSH) * lost",
> +        "MetricName": "branch_mispredict",
> +        "MetricExpr": "(BR_MIS_PRED_RETIRED / GPC_FLUSH) * slots_lost_mi=
sspeculation_fraction",
>          "BriefDescription": "Fraction of slots lost due to branch mispre=
diciton",
> -        "MetricGroup": "TopDownL2",
> -        "MetricName": "branch_mispredict"
> +        "MetricGroup": "TopdownL2",
> +        "ScaleUnit": "1percent of slots"
>      },
>      {
> -        "MetricExpr": "frontend - frontend_latency",
> +        "MetricName": "frontend_bandwidth",
> +        "MetricExpr": "frontend_bound - frontend_latency",
>          "BriefDescription": "Fraction of slots the CPU did not dispatch =
at full bandwidth - able to dispatch partial slots only (1, 2, or 3 uops)",
> -        "MetricGroup": "TopDownL2",
> -        "MetricName": "frontend_bandwidth"
> +        "MetricGroup": "TopdownL2",
> +        "ScaleUnit": "1percent of slots"
>      },
>      {
> -        "MetricExpr": "(STALL_FRONTEND - ((STALL_SLOT_FRONTEND - (fronte=
nd * CPU_CYCLES * 4)) / 4)) / CPU_CYCLES",
> +        "MetricName": "frontend_latency",
> +        "MetricExpr": "((STALL_FRONTEND - ((STALL_SLOT_FRONTEND - ((fron=
tend_bound / 100) * CPU_CYCLES * #slots)) / #slots)) / CPU_CYCLES) * 100",
>          "BriefDescription": "Fraction of slots the CPU was stalled due t=
o frontend latency issues (cache/tlb miss); nothing to dispatch",
> -        "MetricGroup": "TopDownL2",
> -        "MetricName": "frontend_latency"
> +        "MetricGroup": "TopdownL2",
> +        "ScaleUnit": "1percent of slots"
>      },
>      {
> -        "MetricExpr": "lost - branch_mispredict",
> +        "MetricName": "other_miss_pred",
> +        "MetricExpr": "slots_lost_misspeculation_fraction - branch_mispr=
edict",
>          "BriefDescription": "Fraction of slots lost due to other/non-bra=
nch misprediction misspeculation",
> -        "MetricGroup": "TopDownL2",
> -        "MetricName": "other_clears"
> +        "MetricGroup": "TopdownL2",
> +        "ScaleUnit": "1percent of slots"
>      },
>      {
> -        "MetricExpr": "(IXU_NUM_UOPS_ISSUED + FSU_ISSUED) / (CPU_CYCLES =
* 6)",
> +        "MetricName": "pipe_utilization",
> +        "MetricExpr": "100 * ((IXU_NUM_UOPS_ISSUED + FSU_ISSUED) / (CPU_=
CYCLES * 6))",
>          "BriefDescription": "Fraction of execute slots utilized",
> -        "MetricGroup": "TopDownL2",
> -        "MetricName": "pipe_utilization"
> +        "MetricGroup": "TopdownL2",
> +        "ScaleUnit": "1percent of slots"
>      },
>      {
> -        "MetricExpr": "STALL_BACKEND_MEM / CPU_CYCLES",
> +        "MetricName": "d_cache_l2_miss_rate",
> +        "MetricExpr": "((STALL_BACKEND_MEM / CPU_CYCLES) * 100)",
>          "BriefDescription": "Fraction of cycles the CPU was stalled due =
to data L2 cache miss",
> -        "MetricGroup": "TopDownL3",
> -        "MetricName": "d_cache_l2_miss"
> +        "MetricGroup": "TopdownL3",
> +        "ScaleUnit": "1percent of cycles"
>      },
>      {
> -        "MetricExpr": "STALL_BACKEND_CACHE / CPU_CYCLES",
> +        "MetricName": "d_cache_miss_rate",
> +        "MetricExpr": "((STALL_BACKEND_CACHE / CPU_CYCLES) * 100)",
>          "BriefDescription": "Fraction of cycles the CPU was stalled due =
to data cache miss",
> -        "MetricGroup": "TopDownL3",
> -        "MetricName": "d_cache_miss"
> +        "MetricGroup": "TopdownL3",
> +        "ScaleUnit": "1percent of cycles"
>      },
>      {
> -        "MetricExpr": "STALL_BACKEND_TLB / CPU_CYCLES",
> +        "MetricName": "d_tlb_miss_rate",
> +        "MetricExpr": "((STALL_BACKEND_TLB / CPU_CYCLES) * 100)",
>          "BriefDescription": "Fraction of cycles the CPU was stalled due =
to data TLB miss",
> -        "MetricGroup": "TopDownL3",
> -        "MetricName": "d_tlb_miss"
> +        "MetricGroup": "TopdownL3",
> +        "ScaleUnit": "1percent of cycles"
>      },
>      {
> -        "MetricExpr": "FSU_ISSUED / (CPU_CYCLES * 2)",
> +        "MetricName": "fsu_pipe_utilization",
> +        "MetricExpr": "((FSU_ISSUED / (CPU_CYCLES * 2)) * 100)",
>          "BriefDescription": "Fraction of FSU execute slots utilized",
> -        "MetricGroup": "TopDownL3",
> -        "MetricName": "fsu_pipe_utilization"
> +        "MetricGroup": "TopdownL3",
> +        "ScaleUnit": "1percent of slots"
>      },
>      {
> -        "MetricExpr": "STALL_FRONTEND_CACHE / CPU_CYCLES",
> +        "MetricName": "i_cache_miss_rate",
> +        "MetricExpr": "((STALL_FRONTEND_CACHE / CPU_CYCLES) * 100)",
>          "BriefDescription": "Fraction of cycles the CPU was stalled due =
to instruction cache miss",
> -        "MetricGroup": "TopDownL3",
> -        "MetricName": "i_cache_miss"
> +        "MetricGroup": "TopdownL3",
> +        "ScaleUnit": "1percent of slots"
>      },
>      {
> -        "MetricExpr": " STALL_FRONTEND_TLB / CPU_CYCLES ",
> +        "MetricName": "i_tlb_miss_rate",
> +        "MetricExpr": "((STALL_FRONTEND_TLB / CPU_CYCLES) * 100)",
>          "BriefDescription": "Fraction of cycles the CPU was stalled due =
to instruction TLB miss",
> -        "MetricGroup": "TopDownL3",
> -        "MetricName": "i_tlb_miss"
> +        "MetricGroup": "TopdownL3",
> +        "ScaleUnit": "1percent of slots"
>      },
>      {
> -        "MetricExpr": "IXU_NUM_UOPS_ISSUED / (CPU_CYCLES / 4)",
> +        "MetricName": "ixu_pipe_utilization",
> +        "MetricExpr": "((IXU_NUM_UOPS_ISSUED / (CPU_CYCLES * #slots)) * =
100)",
>          "BriefDescription": "Fraction of IXU execute slots utilized",
> -        "MetricGroup": "TopDownL3",
> -        "MetricName": "ixu_pipe_utilization"
> +        "MetricGroup": "TopdownL3",
> +        "ScaleUnit": "1percent of slots"
>      },
>      {
> -        "MetricExpr": "IDR_STALL_FLUSH / CPU_CYCLES",
> +        "MetricName": "stall_recovery_rate",
> +        "MetricExpr": "((IDR_STALL_FLUSH / CPU_CYCLES) * 100)",
>          "BriefDescription": "Fraction of cycles the CPU was stalled due =
to flush recovery",
> -        "MetricGroup": "TopDownL3",
> -        "MetricName": "recovery"
> -    },
> -    {
> -        "MetricExpr": "STALL_BACKEND_RESOURCE / CPU_CYCLES",
> -        "BriefDescription": "Fraction of cycles the CPU was stalled due =
to core resource shortage",
> -        "MetricGroup": "TopDownL3",
> -        "MetricName": "resource"
> +        "MetricGroup": "TopdownL3",
> +        "ScaleUnit": "1percent of slots"
>      },
>      {
> -        "MetricExpr": "IDR_STALL_FSU_SCHED / CPU_CYCLES ",
> +        "MetricName": "stall_fsu_sched_rate",
> +        "MetricExpr": "((IDR_STALL_FSU_SCHED / CPU_CYCLES) * 100)",
>          "BriefDescription": "Fraction of cycles the CPU was stalled and =
FSU was full",
> -        "MetricGroup": "TopDownL4",
> -        "MetricName": "stall_fsu_sched"
> +        "MetricGroup": "TopdownL4",
> +        "ScaleUnit": "1percent of cycles"
>      },
>      {
> -        "MetricExpr": "IDR_STALL_IXU_SCHED / CPU_CYCLES ",
> +        "MetricName": "stall_ixu_sched_rate",
> +        "MetricExpr": "((IDR_STALL_IXU_SCHED / CPU_CYCLES) * 100)",
>          "BriefDescription": "Fraction of cycles the CPU was stalled and =
IXU was full",
> -        "MetricGroup": "TopDownL4",
> -        "MetricName": "stall_ixu_sched"
> +        "MetricGroup": "TopdownL4",
> +        "ScaleUnit": "1percent of cycles"
>      },
>      {
> -        "MetricExpr": "IDR_STALL_LOB_ID / CPU_CYCLES ",
> +        "MetricName": "stall_lob_id_rate",
> +        "MetricExpr": "((IDR_STALL_LOB_ID / CPU_CYCLES) * 100)",
>          "BriefDescription": "Fraction of cycles the CPU was stalled and =
LOB was full",
> -        "MetricGroup": "TopDownL4",
> -        "MetricName": "stall_lob_id"
> +        "MetricGroup": "TopdownL4",
> +        "ScaleUnit": "1percent of cycles"
>      },
>      {
> -        "MetricExpr": "IDR_STALL_ROB_ID / CPU_CYCLES",
> +        "MetricName": "stall_rob_id_rate",
> +        "MetricExpr": "((IDR_STALL_ROB_ID / CPU_CYCLES) * 100)",
>          "BriefDescription": "Fraction of cycles the CPU was stalled and =
ROB was full",
> -        "MetricGroup": "TopDownL4",
> -        "MetricName": "stall_rob_id"
> +        "MetricGroup": "TopdownL4",
> +        "ScaleUnit": "1percent of cycles"
>      },
>      {
> -        "MetricExpr": "IDR_STALL_SOB_ID / CPU_CYCLES ",
> +        "MetricName": "stall_sob_id_rate",
> +        "MetricExpr": "((IDR_STALL_SOB_ID / CPU_CYCLES) * 100)",
>          "BriefDescription": "Fraction of cycles the CPU was stalled and =
SOB was full",
> -        "MetricGroup": "TopDownL4",
> -        "MetricName": "stall_sob_id"
> +        "MetricGroup": "TopdownL4",
> +        "ScaleUnit": "1percent of cycles"
>      }
>  ]
> --
> 2.40.1
>
