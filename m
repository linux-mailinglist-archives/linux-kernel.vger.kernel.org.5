Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225A778797A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 22:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243550AbjHXUkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 16:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241559AbjHXUkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 16:40:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4934210E0;
        Thu, 24 Aug 2023 13:40:18 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31963263938so149272f8f.2;
        Thu, 24 Aug 2023 13:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692909617; x=1693514417;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cgtTGYlUTTWLNtKSFgsGHT754tITygNLi4Mu3scYEGA=;
        b=IQjL+9sf/CC0rPOsSCB8xrxJhYqA/TF7h9M1+TFPbSZD+KroqnhhsF07qwKMR6wM1Q
         g2CMkE7O7Gq3BofF7DUP2XrIfnV2VEc6xBJdlXKWp+NCYJlrHdt+DWSx7xWSW780qtvC
         /nRZIZVdrpTRFPKLDo+yGKlv4TE8b2AqM9D83M8aYgVhKWUZ4aPSfom/P4SeyNMFIhlZ
         PC/CCcHRQkPEYMiRt1pY8JJ4mdQzIjN1y21QUGmy6Z481nr8VPalS8ys1R+1qeDVdTin
         z02UDomBKxFoNFNah69A+akEHt6kgk/BhEy9NTL8iWe9tke+a8Q94sGApubQbshtuR0U
         aeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692909617; x=1693514417;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cgtTGYlUTTWLNtKSFgsGHT754tITygNLi4Mu3scYEGA=;
        b=MmqV4l1TvnWzGcvskobmxL0+qB4WFY8OoiAK6vLw9PqhnZP7QftfKssh65G4+7fllD
         U3ixiJq+PfpQia0dI8V8KJYDh1WbXuOx949HonVZ/0BAWsH9OglNEXoVpvRFA6Q7mrdG
         rjGLdGwC1zks3IdyCj2oAoBMi5mYCX1kb6xQH655tGCfTWeuM8rWP222qGzWYI3/QQaO
         sGPR9fVL3fQ9nxuDa2v9seS4u/OCZFGq9qf+fnzNO0/qlCHsH28VK1QLXHoBBjUE+tTY
         H+XyNr8W7gPlxZdoz2Cf3K++OoI4EMGuELtB9s5oEfu5+0RjXpNiovRfJ3UL9cbk8LDi
         Bgug==
X-Gm-Message-State: AOJu0YylPIC+z+b3N/sbkY2SwX2E0FzsJIX+rsY3RSUEBjIXUbTYfYMu
        JQkW0QLjjlEQUbm79W2gIs8=
X-Google-Smtp-Source: AGHT+IFqfTWfM8XVmVpaegxC+regR1ttzkHhfR3ai7tix5KFbUdIm5l+DbMW0cCUpJXAJZuQ+FXU2A==
X-Received: by 2002:a5d:4a12:0:b0:317:f046:25ef with SMTP id m18-20020a5d4a12000000b00317f04625efmr13308707wrq.44.1692909616038;
        Thu, 24 Aug 2023 13:40:16 -0700 (PDT)
Received: from [192.168.0.101] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id y7-20020adff147000000b00317df42e91dsm190498wro.4.2023.08.24.13.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 13:40:11 -0700 (PDT)
Message-ID: <ae73313b-2cfa-c5bb-50cf-0a4a5798bacc@gmail.com>
Date:   Thu, 24 Aug 2023 21:40:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 2/2] perf vendor events intel: Fix spelling mistakes
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
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>
References: <20230824202402.436107-1-irogers@google.com>
 <20230824202402.436107-2-irogers@google.com>
 <CAP-5=fWb270XBVLk+o3KiN=rDSaWAcaDS6A2hEgjT=szw2W_xw@mail.gmail.com>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <CAP-5=fWb270XBVLk+o3KiN=rDSaWAcaDS6A2hEgjT=szw2W_xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2023 21:36, Ian Rogers wrote:
> On Thu, Aug 24, 2023 at 1:24 PM Ian Rogers <irogers@google.com> wrote:
>>
>> Update perf json files with spelling fixes by Colin Ian King
>> <colin.i.king@gmail.com> contributed in:
>> https://github.com/intel/perfmon/pull/96
>> Fix various spelling mistakes and typos as found using codespell #96
>>
>> Signed-off-by: Ian Rogers <irogers@google.com>
> 
> I think it would be more correct here if Colin Ian King
> <colin.i.king@gmail.com> were the author here. I generated the changes
> from their work and they posted similar changes to LKML in the past.
> I'm not sure what the policy is, and I didn't have Colin's permission
> to list them as author, but it'd feel more correct to me for the
> author to be changed.

I don't mind either way, what ever is easiest.

> 
> Thanks,
> Ian
> 
>> ---
>>   .../arch/x86/alderlake/adl-metrics.json        |  6 +++---
>>   .../arch/x86/alderlake/pipeline.json           |  2 +-
>>   .../arch/x86/alderlaken/adln-metrics.json      |  6 +++---
>>   .../x86/broadwellde/uncore-interconnect.json   | 18 +++++++++---------
>>   .../x86/broadwellx/uncore-interconnect.json    | 18 +++++++++---------
>>   .../pmu-events/arch/x86/haswell/memory.json    |  2 +-
>>   .../pmu-events/arch/x86/haswellx/memory.json   |  2 +-
>>   .../arch/x86/haswellx/uncore-interconnect.json | 18 +++++++++---------
>>   .../arch/x86/ivytown/uncore-interconnect.json  | 18 +++++++++---------
>>   .../arch/x86/jaketown/uncore-interconnect.json | 18 +++++++++---------
>>   .../arch/x86/nehalemep/floating-point.json     |  2 +-
>>   .../arch/x86/nehalemex/floating-point.json     |  2 +-
>>   .../arch/x86/westmereep-dp/floating-point.json |  2 +-
>>   .../arch/x86/westmereep-sp/floating-point.json |  2 +-
>>   .../arch/x86/westmereex/floating-point.json    |  2 +-
>>   15 files changed, 59 insertions(+), 59 deletions(-)
>>
>> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
>> index c6780d5c456b..8b6bed3bc766 100644
>> --- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
>> +++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
>> @@ -395,13 +395,13 @@
>>           "Unit": "cpu_atom"
>>       },
>>       {
>> -        "BriefDescription": "Instructions per Branch (lower number means higher occurance rate)",
>> +        "BriefDescription": "Instructions per Branch (lower number means higher occurrence rate)",
>>           "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
>>           "MetricName": "tma_info_inst_mix_ipbranch",
>>           "Unit": "cpu_atom"
>>       },
>>       {
>> -        "BriefDescription": "Instruction per (near) call (lower number means higher occurance rate)",
>> +        "BriefDescription": "Instruction per (near) call (lower number means higher occurrence rate)",
>>           "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.CALL",
>>           "MetricName": "tma_info_inst_mix_ipcall",
>>           "Unit": "cpu_atom"
>> @@ -726,7 +726,7 @@
>>           "Unit": "cpu_atom"
>>       },
>>       {
>> -        "BriefDescription": "Counts the numer of issue slots  that result in retirement slots.",
>> +        "BriefDescription": "Counts the number of issue slots  that result in retirement slots.",
>>           "DefaultMetricgroupName": "TopdownL1",
>>           "MetricExpr": "TOPDOWN_RETIRING.ALL / tma_info_core_slots",
>>           "MetricGroup": "Default;TopdownL1;tma_L1_group",
>> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
>> index cb5b8611064b..a92013cdf136 100644
>> --- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
>> +++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
>> @@ -1145,7 +1145,7 @@
>>           "BriefDescription": "TMA slots wasted due to incorrect speculation by branch mispredictions",
>>           "EventCode": "0xa4",
>>           "EventName": "TOPDOWN.BR_MISPREDICT_SLOTS",
>> -        "PublicDescription": "Number of TMA slots that were wasted due to incorrect speculation by (any type of) branch mispredictions. This event estimates number of specualtive operations that were issued but not retired as well as the out-of-order engine recovery past a branch misprediction.",
>> +        "PublicDescription": "Number of TMA slots that were wasted due to incorrect speculation by (any type of) branch mispredictions. This event estimates number of speculative operations that were issued but not retired as well as the out-of-order engine recovery past a branch misprediction.",
>>           "SampleAfterValue": "10000003",
>>           "UMask": "0x8",
>>           "Unit": "cpu_core"
>> diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json b/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
>> index 06e67e34e1bf..c150c14ac6ed 100644
>> --- a/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
>> +++ b/tools/perf/pmu-events/arch/x86/alderlaken/adln-metrics.json
>> @@ -328,12 +328,12 @@
>>           "MetricName": "tma_info_inst_mix_idiv_uop_ratio"
>>       },
>>       {
>> -        "BriefDescription": "Instructions per Branch (lower number means higher occurance rate)",
>> +        "BriefDescription": "Instructions per Branch (lower number means higher occurrence rate)",
>>           "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
>>           "MetricName": "tma_info_inst_mix_ipbranch"
>>       },
>>       {
>> -        "BriefDescription": "Instruction per (near) call (lower number means higher occurance rate)",
>> +        "BriefDescription": "Instruction per (near) call (lower number means higher occurrence rate)",
>>           "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.CALL",
>>           "MetricName": "tma_info_inst_mix_ipcall"
>>       },
>> @@ -616,7 +616,7 @@
>>           "ScaleUnit": "100%"
>>       },
>>       {
>> -        "BriefDescription": "Counts the numer of issue slots  that result in retirement slots.",
>> +        "BriefDescription": "Counts the number of issue slots  that result in retirement slots.",
>>           "DefaultMetricgroupName": "TopdownL1",
>>           "MetricExpr": "TOPDOWN_RETIRING.ALL / tma_info_core_slots",
>>           "MetricGroup": "Default;TopdownL1;tma_L1_group",
>> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect.json
>> index 8a327e0f1441..910395977a6e 100644
>> --- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect.json
>> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect.json
>> @@ -253,7 +253,7 @@
>>           "EventCode": "0x4",
>>           "EventName": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -261,7 +261,7 @@
>>           "EventCode": "0x1",
>>           "EventName": "UNC_I_RxR_BL_DRS_INSERTS",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -269,7 +269,7 @@
>>           "EventCode": "0x7",
>>           "EventName": "UNC_I_RxR_BL_DRS_OCCUPANCY",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -277,7 +277,7 @@
>>           "EventCode": "0x5",
>>           "EventName": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -285,7 +285,7 @@
>>           "EventCode": "0x2",
>>           "EventName": "UNC_I_RxR_BL_NCB_INSERTS",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -293,7 +293,7 @@
>>           "EventCode": "0x8",
>>           "EventName": "UNC_I_RxR_BL_NCB_OCCUPANCY",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -301,7 +301,7 @@
>>           "EventCode": "0x6",
>>           "EventName": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -309,7 +309,7 @@
>>           "EventCode": "0x3",
>>           "EventName": "UNC_I_RxR_BL_NCS_INSERTS",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -317,7 +317,7 @@
>>           "EventCode": "0x9",
>>           "EventName": "UNC_I_RxR_BL_NCS_OCCUPANCY",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
>> index e61a23f68899..b9fb216bee16 100644
>> --- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
>> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
>> @@ -271,7 +271,7 @@
>>           "EventCode": "0x4",
>>           "EventName": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -279,7 +279,7 @@
>>           "EventCode": "0x1",
>>           "EventName": "UNC_I_RxR_BL_DRS_INSERTS",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -287,7 +287,7 @@
>>           "EventCode": "0x7",
>>           "EventName": "UNC_I_RxR_BL_DRS_OCCUPANCY",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -295,7 +295,7 @@
>>           "EventCode": "0x5",
>>           "EventName": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -303,7 +303,7 @@
>>           "EventCode": "0x2",
>>           "EventName": "UNC_I_RxR_BL_NCB_INSERTS",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -311,7 +311,7 @@
>>           "EventCode": "0x8",
>>           "EventName": "UNC_I_RxR_BL_NCB_OCCUPANCY",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -319,7 +319,7 @@
>>           "EventCode": "0x6",
>>           "EventName": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -327,7 +327,7 @@
>>           "EventCode": "0x3",
>>           "EventName": "UNC_I_RxR_BL_NCS_INSERTS",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -335,7 +335,7 @@
>>           "EventCode": "0x9",
>>           "EventName": "UNC_I_RxR_BL_NCS_OCCUPANCY",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> diff --git a/tools/perf/pmu-events/arch/x86/haswell/memory.json b/tools/perf/pmu-events/arch/x86/haswell/memory.json
>> index 2fc25e22a42a..df44c28efeeb 100644
>> --- a/tools/perf/pmu-events/arch/x86/haswell/memory.json
>> +++ b/tools/perf/pmu-events/arch/x86/haswell/memory.json
>> @@ -62,7 +62,7 @@
>>           "BriefDescription": "Counts the number of machine clears due to memory order conflicts.",
>>           "EventCode": "0xC3",
>>           "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
>> -        "PublicDescription": "This event counts the number of memory ordering machine clears detected. Memory ordering machine clears can result from memory address aliasing or snoops from another hardware thread or core to data inflight in the pipeline.  Machine clears can have a significant performance impact if they are happening frequently.",
>> +        "PublicDescription": "This event counts the number of memory ordering machine clears detected. Memory ordering machine clears can result from memory address aliasing or snoops from another hardware thread or core to data in-flight in the pipeline.  Machine clears can have a significant performance impact if they are happening frequently.",
>>           "SampleAfterValue": "100003",
>>           "UMask": "0x2"
>>       },
>> diff --git a/tools/perf/pmu-events/arch/x86/haswellx/memory.json b/tools/perf/pmu-events/arch/x86/haswellx/memory.json
>> index 2d212cf59e92..d66e465ce41a 100644
>> --- a/tools/perf/pmu-events/arch/x86/haswellx/memory.json
>> +++ b/tools/perf/pmu-events/arch/x86/haswellx/memory.json
>> @@ -62,7 +62,7 @@
>>           "BriefDescription": "Counts the number of machine clears due to memory order conflicts.",
>>           "EventCode": "0xC3",
>>           "EventName": "MACHINE_CLEARS.MEMORY_ORDERING",
>> -        "PublicDescription": "This event counts the number of memory ordering machine clears detected. Memory ordering machine clears can result from memory address aliasing or snoops from another hardware thread or core to data inflight in the pipeline.  Machine clears can have a significant performance impact if they are happening frequently.",
>> +        "PublicDescription": "This event counts the number of memory ordering machine clears detected. Memory ordering machine clears can result from memory address aliasing or snoops from another hardware thread or core to data in-flight in the pipeline.  Machine clears can have a significant performance impact if they are happening frequently.",
>>           "SampleAfterValue": "100003",
>>           "UMask": "0x2"
>>       },
>> diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
>> index 954e8198c7a5..bef1f5ef6f31 100644
>> --- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
>> +++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
>> @@ -271,7 +271,7 @@
>>           "EventCode": "0x4",
>>           "EventName": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -279,7 +279,7 @@
>>           "EventCode": "0x1",
>>           "EventName": "UNC_I_RxR_BL_DRS_INSERTS",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -287,7 +287,7 @@
>>           "EventCode": "0x7",
>>           "EventName": "UNC_I_RxR_BL_DRS_OCCUPANCY",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -295,7 +295,7 @@
>>           "EventCode": "0x5",
>>           "EventName": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -303,7 +303,7 @@
>>           "EventCode": "0x2",
>>           "EventName": "UNC_I_RxR_BL_NCB_INSERTS",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -311,7 +311,7 @@
>>           "EventCode": "0x8",
>>           "EventName": "UNC_I_RxR_BL_NCB_OCCUPANCY",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -319,7 +319,7 @@
>>           "EventCode": "0x6",
>>           "EventName": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -327,7 +327,7 @@
>>           "EventCode": "0x3",
>>           "EventName": "UNC_I_RxR_BL_NCS_INSERTS",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -335,7 +335,7 @@
>>           "EventCode": "0x9",
>>           "EventName": "UNC_I_RxR_BL_NCS_OCCUPANCY",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
>> index ccf451534d16..f4d11da01383 100644
>> --- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
>> +++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
>> @@ -140,7 +140,7 @@
>>           "EventCode": "0x4",
>>           "EventName": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -148,21 +148,21 @@
>>           "EventCode": "0x1",
>>           "EventName": "UNC_I_RxR_BL_DRS_INSERTS",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>>           "EventCode": "0x7",
>>           "EventName": "UNC_I_RxR_BL_DRS_OCCUPANCY",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>>           "EventCode": "0x5",
>>           "EventName": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -170,21 +170,21 @@
>>           "EventCode": "0x2",
>>           "EventName": "UNC_I_RxR_BL_NCB_INSERTS",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>>           "EventCode": "0x8",
>>           "EventName": "UNC_I_RxR_BL_NCB_OCCUPANCY",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>>           "EventCode": "0x6",
>>           "EventName": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -192,14 +192,14 @@
>>           "EventCode": "0x3",
>>           "EventName": "UNC_I_RxR_BL_NCS_INSERTS",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>>           "EventCode": "0x9",
>>           "EventName": "UNC_I_RxR_BL_NCS_OCCUPANCY",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json b/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
>> index 874f15ea8228..0fc907e5cf3c 100644
>> --- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
>> +++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
>> @@ -140,7 +140,7 @@
>>           "EventCode": "0x4",
>>           "EventName": "UNC_I_RxR_BL_DRS_CYCLES_FULL",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -148,21 +148,21 @@
>>           "EventCode": "0x1",
>>           "EventName": "UNC_I_RxR_BL_DRS_INSERTS",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>>           "EventCode": "0x7",
>>           "EventName": "UNC_I_RxR_BL_DRS_OCCUPANCY",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>>           "EventCode": "0x5",
>>           "EventName": "UNC_I_RxR_BL_NCB_CYCLES_FULL",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -170,21 +170,21 @@
>>           "EventCode": "0x2",
>>           "EventName": "UNC_I_RxR_BL_NCB_INSERTS",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>>           "EventCode": "0x8",
>>           "EventName": "UNC_I_RxR_BL_NCB_OCCUPANCY",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>>           "EventCode": "0x6",
>>           "EventName": "UNC_I_RxR_BL_NCS_CYCLES_FULL",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of cycles when the BL Ingress is full.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> @@ -192,14 +192,14 @@
>>           "EventCode": "0x3",
>>           "EventName": "UNC_I_RxR_BL_NCS_INSERTS",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Counts the number of allocations into the BL Ingress.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>>           "EventCode": "0x9",
>>           "EventName": "UNC_I_RxR_BL_NCS_OCCUPANCY",
>>           "PerPkg": "1",
>> -        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requets as well as outbound MMIO writes.",
>> +        "PublicDescription": "Accumulates the occupancy of the BL Ingress in each cycles.  This queue is where the IRP receives data from R2PCIe (the ring).  It is used for data returns from read requests as well as outbound MMIO writes.",
>>           "Unit": "IRP"
>>       },
>>       {
>> diff --git a/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json b/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
>> index c03f8990fa82..196ae1d9b157 100644
>> --- a/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
>> +++ b/tools/perf/pmu-events/arch/x86/nehalemep/floating-point.json
>> @@ -8,7 +8,7 @@
>>           "UMask": "0x1"
>>       },
>>       {
>> -        "BriefDescription": "X87 Floating poiint assists for invalid input value (Precise Event)",
>> +        "BriefDescription": "X87 Floating point assists for invalid input value (Precise Event)",
>>           "EventCode": "0xF7",
>>           "EventName": "FP_ASSIST.INPUT",
>>           "PEBS": "1",
>> diff --git a/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json b/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
>> index c03f8990fa82..196ae1d9b157 100644
>> --- a/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
>> +++ b/tools/perf/pmu-events/arch/x86/nehalemex/floating-point.json
>> @@ -8,7 +8,7 @@
>>           "UMask": "0x1"
>>       },
>>       {
>> -        "BriefDescription": "X87 Floating poiint assists for invalid input value (Precise Event)",
>> +        "BriefDescription": "X87 Floating point assists for invalid input value (Precise Event)",
>>           "EventCode": "0xF7",
>>           "EventName": "FP_ASSIST.INPUT",
>>           "PEBS": "1",
>> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json b/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
>> index c03f8990fa82..196ae1d9b157 100644
>> --- a/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
>> +++ b/tools/perf/pmu-events/arch/x86/westmereep-dp/floating-point.json
>> @@ -8,7 +8,7 @@
>>           "UMask": "0x1"
>>       },
>>       {
>> -        "BriefDescription": "X87 Floating poiint assists for invalid input value (Precise Event)",
>> +        "BriefDescription": "X87 Floating point assists for invalid input value (Precise Event)",
>>           "EventCode": "0xF7",
>>           "EventName": "FP_ASSIST.INPUT",
>>           "PEBS": "1",
>> diff --git a/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json b/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
>> index c03f8990fa82..196ae1d9b157 100644
>> --- a/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
>> +++ b/tools/perf/pmu-events/arch/x86/westmereep-sp/floating-point.json
>> @@ -8,7 +8,7 @@
>>           "UMask": "0x1"
>>       },
>>       {
>> -        "BriefDescription": "X87 Floating poiint assists for invalid input value (Precise Event)",
>> +        "BriefDescription": "X87 Floating point assists for invalid input value (Precise Event)",
>>           "EventCode": "0xF7",
>>           "EventName": "FP_ASSIST.INPUT",
>>           "PEBS": "1",
>> diff --git a/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json b/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
>> index c03f8990fa82..196ae1d9b157 100644
>> --- a/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
>> +++ b/tools/perf/pmu-events/arch/x86/westmereex/floating-point.json
>> @@ -8,7 +8,7 @@
>>           "UMask": "0x1"
>>       },
>>       {
>> -        "BriefDescription": "X87 Floating poiint assists for invalid input value (Precise Event)",
>> +        "BriefDescription": "X87 Floating point assists for invalid input value (Precise Event)",
>>           "EventCode": "0xF7",
>>           "EventName": "FP_ASSIST.INPUT",
>>           "PEBS": "1",
>> --
>> 2.42.0.rc2.253.gd59a3bf2b4-goog
>>

