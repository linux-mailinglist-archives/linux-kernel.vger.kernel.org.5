Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2EB759A85
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjGSQNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjGSQND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:13:03 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB12E47
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:12:55 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40371070eb7so666061cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689783174; x=1692375174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9X/T6eIl8uv7b1fwfeNSFGPzQj0MwF56jVEOv5Ex2a0=;
        b=05bppa1UvF3bLHg1a21i7yXYgd3IweWyuUbx/uSEAyVurRLCSjSB8NLBO/F4und3wC
         cGj1dGL9EgxB3Y2WEkvN+lhfF/6EhIBcx1ffjZbRrlY6SP51nDmvZDZ2iL0qeJrZWWbz
         HZzZfP9hJ+LGvc4ztKB6WoIHeIBYKqZ5TPbGVv7iLqXpADHmacReY5PoNkLX2Q+S4sMB
         T/QRBuMaQNJCyZCqPWB8NYkoGs5/8bKHYGZ2PzsZMqXu4OLdfXd5WLLskzSKL8oFvIbL
         hOalcHu0AsHPbnVDnc3aplrMSNCebwfabxmQEy1LEzWYsxDNEwHd97u/BvohXCEUdnOw
         8Pog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689783174; x=1692375174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9X/T6eIl8uv7b1fwfeNSFGPzQj0MwF56jVEOv5Ex2a0=;
        b=Ggmkv0bnpIE14pKdMZQExg1iS5W/e5mfclK4UybJzd3x5/J0URM3BMu3Mcj36qaDi0
         OAnQ2WV2D6AS+Rl/WHt9gt8pci/NRjAujezj074BkzC1HUuagZpr86JagfL1sG8nRRK2
         IJyoN+P7+pm2mDmX1PSZU840R2owCkVg00w1aknElVK8UswYFCJ8k/lJA8/uIlK32Nqa
         fy2AJ2XyQZC5grG0fwsyRljazrSZDBz8qMZxkp8qVp5bzqZFC6C4khz9ezuJLmsG/Yw9
         J/wU9TD3gBISpdqy8vLL54lFE4WHigE/k1aBPFepmPj6bCei/n4/j5qfTeD6LIRCCsy1
         IrVA==
X-Gm-Message-State: ABy/qLYIxFnpJC9oxmSUgkoVZNImA2Cn2bWZ2FQSrwrQ6Vfv9Rr9hOHr
        BX3uKPWQfzbi6dIRc7a+kSHQCVSgmCpAdk5u3CBgUQ==
X-Google-Smtp-Source: APBJJlEg8IQOaM/hF1/8FHt/n6wJSgBmXsxn8FPUaw1rnzKIQP/rAnZ/K3cOCs6XQXd4VzgzEM4VZJAMjZ6rkpLmvT0=
X-Received: by 2002:a05:622a:1a87:b0:3f4:f0fd:fe7e with SMTP id
 s7-20020a05622a1a8700b003f4f0fdfe7emr574304qtc.3.1689783174436; Wed, 19 Jul
 2023 09:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689748843.git.sandipan.das@amd.com> <a70b1ef6ab427b768f21401af280d235dd095412.1689748843.git.sandipan.das@amd.com>
In-Reply-To: <a70b1ef6ab427b768f21401af280d235dd095412.1689748843.git.sandipan.das@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 19 Jul 2023 09:12:42 -0700
Message-ID: <CAP-5=fX1NQzus3MQapmBrdgEhDG4+XmawgytfugHHOKD0E-COg@mail.gmail.com>
Subject: Re: [PATCH 6/6] perf vendor events amd: Add Zen 4 memory controller events
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        eranian@google.com, ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 11:58=E2=80=AFPM Sandipan Das <sandipan.das@amd.com=
> wrote:
>
> Make the jevents parser aware of the Unified Memory Controller (UMC) PMU
> and add events taken from Section 8.2.1 "UMC Performance Monitor Events"
> of the Processor Programming Reference (PPR) for AMD Family 19h Model 11h
> processors. The events capture UMC command activity such as CAS, ACTIVATE=
,
> PRECHARGE etc. while the metrics derive data bus utilization and memory
> bandwidth out of these events.
>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

Acked-by: Ian Rogers <irogers@google.com>

> ---
>  .../arch/x86/amdzen4/memory-controller.json   | 101 ++++++++++++++++++
>  .../arch/x86/amdzen4/recommended.json         |  84 +++++++++++++++
>  tools/perf/pmu-events/jevents.py              |   2 +
>  3 files changed, 187 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen4/memory-control=
ler.json
>
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.jso=
n b/tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json
> new file mode 100644
> index 000000000000..55263e5e4f69
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen4/memory-controller.json
> @@ -0,0 +1,101 @@
> +[
> +  {
> +    "EventName": "umc_mem_clk",
> +    "PublicDescription": "Number of memory clock cycles.",
> +    "EventCode": "0x00",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"

nit: Why use UMCPMC and then rewrite to amd_umc, why not just use "amd_umc"=
 ?

Thanks,
Ian


> +  },
> +  {
> +    "EventName": "umc_act_cmd.all",
> +    "PublicDescription": "Number of ACTIVATE commands sent.",
> +    "EventCode": "0x05",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_act_cmd.rd",
> +    "PublicDescription": "Number of ACTIVATE commands sent for reads.",
> +    "EventCode": "0x05",
> +    "RdWrMask": "0x1",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_act_cmd.wr",
> +    "PublicDescription": "Number of ACTIVATE commands sent for writes.",
> +    "EventCode": "0x05",
> +    "RdWrMask": "0x2",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_pchg_cmd.all",
> +    "PublicDescription": "Number of PRECHARGE commands sent.",
> +    "EventCode": "0x06",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_pchg_cmd.rd",
> +    "PublicDescription": "Number of PRECHARGE commands sent for reads.",
> +    "EventCode": "0x06",
> +    "RdWrMask": "0x1",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_pchg_cmd.wr",
> +    "PublicDescription": "Number of PRECHARGE commands sent for writes."=
,
> +    "EventCode": "0x06",
> +    "RdWrMask": "0x2",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_cas_cmd.all",
> +    "PublicDescription": "Number of CAS commands sent.",
> +    "EventCode": "0x0a",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_cas_cmd.rd",
> +    "PublicDescription": "Number of CAS commands sent for reads.",
> +    "EventCode": "0x0a",
> +    "RdWrMask": "0x1",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_cas_cmd.wr",
> +    "PublicDescription": "Number of CAS commands sent for writes.",
> +    "EventCode": "0x0a",
> +    "RdWrMask": "0x2",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_data_slot_clks.all",
> +    "PublicDescription": "Number of clocks used by the data bus.",
> +    "EventCode": "0x14",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_data_slot_clks.rd",
> +    "PublicDescription": "Number of clocks used by the data bus for read=
s.",
> +    "EventCode": "0x14",
> +    "RdWrMask": "0x1",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  },
> +  {
> +    "EventName": "umc_data_slot_clks.wr",
> +    "PublicDescription": "Number of clocks used by the data bus for writ=
es.",
> +    "EventCode": "0x14",
> +    "RdWrMask": "0x2",
> +    "PerPkg": "1",
> +    "Unit": "UMCPMC"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen4/recommended.json b/to=
ols/perf/pmu-events/arch/x86/amdzen4/recommended.json
> index 5e6a793acf7b..96e06401c6cb 100644
> --- a/tools/perf/pmu-events/arch/x86/amdzen4/recommended.json
> +++ b/tools/perf/pmu-events/arch/x86/amdzen4/recommended.json
> @@ -330,5 +330,89 @@
>      "MetricGroup": "data_fabric",
>      "PerPkg": "1",
>      "ScaleUnit": "6.103515625e-5MiB"
> +  },
> +  {
> +    "MetricName": "umc_data_bus_utilization",
> +    "BriefDescription": "Memory controller data bus utilization.",
> +    "MetricExpr": "d_ratio(umc_data_slot_clks.all / 2, umc_mem_clk)",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "umc_cas_cmd_rate",
> +    "BriefDescription": "Memory controller CAS command rate.",
> +    "MetricExpr": "d_ratio(umc_cas_cmd.all * 1000, umc_mem_clk)",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1"
> +  },
> +  {
> +    "MetricName": "umc_cas_cmd_read_ratio",
> +    "BriefDescription": "Ratio of memory controller CAS commands for rea=
ds.",
> +    "MetricExpr": "d_ratio(umc_cas_cmd.rd, umc_cas_cmd.all)",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "umc_cas_cmd_write_ratio",
> +    "BriefDescription": "Ratio of memory controller CAS commands for wri=
tes.",
> +    "MetricExpr": "d_ratio(umc_cas_cmd.wr, umc_cas_cmd.all)",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "umc_mem_read_bandwidth",
> +    "BriefDescription": "Estimated memory read bandwidth.",
> +    "MetricExpr": "(umc_cas_cmd.rd * 64) / 1e6 / duration_time",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1",
> +    "ScaleUnit": "1MB/s"
> +  },
> +  {
> +    "MetricName": "umc_mem_write_bandwidth",
> +    "BriefDescription": "Estimated memory write bandwidth.",
> +    "MetricExpr": "(umc_cas_cmd.wr * 64) / 1e6 / duration_time",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1",
> +    "ScaleUnit": "1MB/s"
> +  },
> +  {
> +    "MetricName": "umc_mem_bandwidth",
> +    "BriefDescription": "Estimated combined memory bandwidth.",
> +    "MetricExpr": "(umc_cas_cmd.all * 64) / 1e6 / duration_time",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1",
> +    "ScaleUnit": "1MB/s"
> +  },
> +  {
> +    "MetricName": "umc_cas_cmd_read_ratio",
> +    "BriefDescription": "Ratio of memory controller CAS commands for rea=
ds.",
> +    "MetricExpr": "d_ratio(umc_cas_cmd.rd, umc_cas_cmd.all)",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "umc_cas_cmd_rate",
> +    "BriefDescription": "Memory controller CAS command rate.",
> +    "MetricExpr": "d_ratio(umc_cas_cmd.all * 1000, umc_mem_clk)",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1"
> +  },
> +  {
> +    "MetricName": "umc_activate_cmd_rate",
> +    "BriefDescription": "Memory controller ACTIVATE command rate.",
> +    "MetricExpr": "d_ratio(umc_act_cmd.all * 1000, umc_mem_clk)",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1"
> +  },
> +  {
> +    "MetricName": "umc_precharge_cmd_rate",
> +    "BriefDescription": "Memory controller PRECHARGE command rate.",
> +    "MetricExpr": "d_ratio(umc_pchg_cmd.all * 1000, umc_mem_clk)",
> +    "MetricGroup": "memory_controller",
> +    "PerPkg": "1"
>    }
>  ]
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 12e80bb7939b..c2a5728253db 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -272,6 +272,7 @@ class JsonEvent:
>            'imx8_ddr': 'imx8_ddr',
>            'L3PMC': 'amd_l3',
>            'DFPMC': 'amd_df',
> +          'UMCPMC': 'amd_umc',
>            'cpu_core': 'cpu_core',
>            'cpu_atom': 'cpu_atom',
>        }
> @@ -330,6 +331,7 @@ class JsonEvent:
>          ('Invert', 'inv=3D'),
>          ('SampleAfterValue', 'period=3D'),
>          ('UMask', 'umask=3D'),
> +        ('RdWrMask', 'rdwrmask=3D'),
>      ]
>      for key, value in event_fields:
>        if key in jd and jd[key] !=3D '0':
> --
> 2.34.1
>
