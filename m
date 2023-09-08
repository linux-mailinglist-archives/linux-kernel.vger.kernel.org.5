Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E24799171
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 23:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245393AbjIHVTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 17:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjIHVTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 17:19:08 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B53EE46
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 14:19:00 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-414c54b2551so32201cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 14:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694207939; x=1694812739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcvph+AwjE43pCLcPL9mlhLVOLxNqbzPVhOITV4+H9U=;
        b=ybWJNoNcbuuFv98r5GtEv6RrcqCEWwcJZOI2zrCYWIDR9V6pHWBH80I8veaDwVOACP
         +ibqjyJYckNQ5bTyX+d2uIO9J3jRrIPQJ8CJKTzJtqdPmXD/CsWb0Wh/y+pgQ2p+Bd47
         Q5NkvX+SOCgk3wQKhV7+mwoAGA7Ui3Lye123QCj5ZIVWwMjublrgnrHmSyDqO+/jSJ2e
         NLhl6ryoh+AcoVcL9cCSm+vLdKMaIcZePTUT0GUlxRqoWZHbuj2HTv0QPxAkqUrPeQnt
         NJEcF5x+9Spexic8I09H2x5TMR9bzZfIOBP99u/8YhOrUqzZlB5bX2KPbPsgIkIh0o2z
         TAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694207939; x=1694812739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcvph+AwjE43pCLcPL9mlhLVOLxNqbzPVhOITV4+H9U=;
        b=F9O7laOFfcL0Yi35xhkPVY3DA5EgHgQeUohCa6fYYIBJJsT01yFtcDAXO8dp45p8jV
         CUQQ2tTtKnAaTWjgOgs5QnBVn7OhuKLHE0+3vIyyDvnK+FMCbiGAH+DqHSPjcxBZBROK
         C6PYGHdb7M6ApPB+8U1abgTsxy3I65P6Pa7o07t02YD4tVSGD2hH9nocQOgv5o7bKZN8
         qTnSzaqctE8fCoTGdaEnNS7vysbrd4PK5X++pUe/D9BM8JwMCEd/REr4MEOXN0nfNjsR
         s4wntWbY+njXh0HsmA5xQalOVyTe10uv97ApsS9JtKmgbogZeMweNjBLATuMG1C6mLLH
         HutA==
X-Gm-Message-State: AOJu0YyphC7hdFpyc6KkrPGa0+j8B4QZbk5wRLLR0xAan1PsaRSAiDrH
        i6vFxLVM/Rd8xCRzaY278TGRUU7Fzx0gD9JKA3gGpQ==
X-Google-Smtp-Source: AGHT+IHKp5JtqtmanUuGgsR17XhtpY7hkt/wraBTa9LHGij8qRKBAGsKtD83kSJY0/BhM8yfcxXzUilb6zlimGhs1zc=
X-Received: by 2002:ac8:5716:0:b0:410:385c:d1e0 with SMTP id
 22-20020ac85716000000b00410385cd1e0mr313881qtw.25.1694207937954; Fri, 08 Sep
 2023 14:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <1694087913-46144-1-git-send-email-renyu.zj@linux.alibaba.com> <1694087913-46144-4-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1694087913-46144-4-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 8 Sep 2023 14:18:45 -0700
Message-ID: <CAP-5=fUyj_Xkkbx5W2Kr88BwZLF1QQ9XcBsbnumnHZM_P+0t2g@mail.gmail.com>
Subject: Re: [PATCH v8 3/8] perf vendor events: Supplement the omitted EventCode
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
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

On Thu, Sep 7, 2023 at 4:58=E2=80=AFAM Jing Zhang <renyu.zj@linux.alibaba.c=
om> wrote:
>
> If there is an "event=3D0" in the event description, the EventCode can
> be omitted in the JSON file, and jevent.py will automatically fill in
> "event=3D0" during parsing.
>
> However, for some events where EventCode and ConfigCode are missing,
> it is not necessary to automatically fill in "event=3D0", such as the
> CMN event description which is typically "type=3Dxxx, eventid=3Dxxx".
>
> Therefore, before modifying jevent.py to prevent it from automatically
> adding "event=3D0" by default, it is necessary to fill in all omitted
> EventCodes first.
>
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>

I thought you were going to change the behavior in jevents.py so this
change would be unnecessary. The next time the json is generated by
the script:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
then this will break. It seems easier to workaround the issue in jevents.py=
.

Thanks,
Ian

> ---
>  tools/perf/pmu-events/arch/x86/alderlake/pipeline.json     |  9 ++++++++=
+
>  tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json    |  3 +++
>  tools/perf/pmu-events/arch/x86/broadwell/pipeline.json     |  4 ++++
>  tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json   |  4 ++++
>  .../perf/pmu-events/arch/x86/broadwellde/uncore-cache.json |  2 ++
>  .../arch/x86/broadwellde/uncore-interconnect.json          |  1 +
>  .../pmu-events/arch/x86/broadwellde/uncore-memory.json     |  1 +
>  .../perf/pmu-events/arch/x86/broadwellde/uncore-power.json |  1 +
>  tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json    |  4 ++++
>  .../perf/pmu-events/arch/x86/broadwellx/uncore-cache.json  |  2 ++
>  .../arch/x86/broadwellx/uncore-interconnect.json           | 13 ++++++++=
+++++
>  .../perf/pmu-events/arch/x86/broadwellx/uncore-memory.json |  2 ++
>  .../perf/pmu-events/arch/x86/broadwellx/uncore-power.json  |  1 +
>  tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json  |  4 ++++
>  .../pmu-events/arch/x86/cascadelakex/uncore-cache.json     |  2 ++
>  .../arch/x86/cascadelakex/uncore-interconnect.json         |  1 +
>  tools/perf/pmu-events/arch/x86/cascadelakex/uncore-io.json |  1 +
>  .../pmu-events/arch/x86/cascadelakex/uncore-memory.json    |  1 +
>  .../pmu-events/arch/x86/cascadelakex/uncore-power.json     |  1 +
>  tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json   |  2 ++
>  tools/perf/pmu-events/arch/x86/goldmont/pipeline.json      |  3 +++
>  tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json  |  3 +++
>  tools/perf/pmu-events/arch/x86/grandridge/pipeline.json    |  3 +++
>  tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json |  4 ++++
>  tools/perf/pmu-events/arch/x86/haswell/pipeline.json       |  4 ++++
>  tools/perf/pmu-events/arch/x86/haswellx/pipeline.json      |  4 ++++
>  tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json  |  2 ++
>  .../pmu-events/arch/x86/haswellx/uncore-interconnect.json  | 14 ++++++++=
++++++
>  tools/perf/pmu-events/arch/x86/haswellx/uncore-memory.json |  2 ++
>  tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json  |  1 +
>  tools/perf/pmu-events/arch/x86/icelake/pipeline.json       |  5 +++++
>  tools/perf/pmu-events/arch/x86/icelakex/pipeline.json      |  5 +++++
>  tools/perf/pmu-events/arch/x86/icelakex/uncore-cache.json  |  1 +
>  .../pmu-events/arch/x86/icelakex/uncore-interconnect.json  |  1 +
>  tools/perf/pmu-events/arch/x86/icelakex/uncore-memory.json |  1 +
>  tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json  |  1 +
>  tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json     |  3 +++
>  tools/perf/pmu-events/arch/x86/ivytown/pipeline.json       |  4 ++++
>  tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json   |  2 ++
>  .../pmu-events/arch/x86/ivytown/uncore-interconnect.json   | 11 ++++++++=
+++
>  tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json  |  1 +
>  tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json   |  1 +
>  tools/perf/pmu-events/arch/x86/jaketown/pipeline.json      |  4 ++++
>  tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json  |  2 ++
>  .../pmu-events/arch/x86/jaketown/uncore-interconnect.json  | 12 ++++++++=
++++
>  tools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json |  1 +
>  tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json  |  2 ++
>  .../perf/pmu-events/arch/x86/knightslanding/pipeline.json  |  3 +++
>  .../pmu-events/arch/x86/knightslanding/uncore-cache.json   |  1 +
>  .../pmu-events/arch/x86/knightslanding/uncore-memory.json  |  4 ++++
>  tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json    |  9 ++++++++=
+
>  tools/perf/pmu-events/arch/x86/rocketlake/pipeline.json    |  3 +++
>  tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json   |  4 ++++
>  .../perf/pmu-events/arch/x86/sapphirerapids/pipeline.json  |  5 +++++
>  tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json  |  4 ++++
>  tools/perf/pmu-events/arch/x86/silvermont/pipeline.json    |  3 +++
>  tools/perf/pmu-events/arch/x86/skylake/pipeline.json       |  4 ++++
>  tools/perf/pmu-events/arch/x86/skylakex/pipeline.json      |  4 ++++
>  tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json  |  2 ++
>  .../pmu-events/arch/x86/skylakex/uncore-interconnect.json  |  1 +
>  tools/perf/pmu-events/arch/x86/skylakex/uncore-io.json     |  1 +
>  tools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json |  1 +
>  tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json  |  1 +
>  tools/perf/pmu-events/arch/x86/snowridgex/pipeline.json    |  2 ++
>  .../perf/pmu-events/arch/x86/snowridgex/uncore-cache.json  |  1 +
>  .../arch/x86/snowridgex/uncore-interconnect.json           |  1 +
>  .../perf/pmu-events/arch/x86/snowridgex/uncore-memory.json |  1 +
>  .../perf/pmu-events/arch/x86/snowridgex/uncore-power.json  |  1 +
>  tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json     |  5 +++++
>  69 files changed, 217 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/alderlake/pipeline.json
> index a92013c..9e30943 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
> @@ -489,6 +489,7 @@
>      },
>      {
>          "BriefDescription": "Counts the number of unhalted core clock cy=
cles. (Fixed event)",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.CORE",
>          "PublicDescription": "Counts the number of core cycles while the=
 core is not in a halt state. The core enters the halt state when it is run=
ning the HLT instruction. The core frequency may change from time to time. =
For this reason this event may have a changing ratio with regards to time. =
This event uses fixed counter 1.",
>          "SampleAfterValue": "2000003",
> @@ -550,6 +551,7 @@
>      },
>      {
>          "BriefDescription": "Counts the number of unhalted reference clo=
ck cycles at TSC frequency. (Fixed event)",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "Counts the number of reference cycles that=
 the core is not in a halt state. The core enters the halt state when it is=
 running the HLT instruction. This event is not affected by core frequency =
changes and increments at a fixed frequency that is also used for the Time =
Stamp Counter (TSC). This event uses fixed counter 2.",
>          "SampleAfterValue": "2000003",
> @@ -558,6 +560,7 @@
>      },
>      {
>          "BriefDescription": "Reference cycles when the core is not in ha=
lt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "Counts the number of reference cycles when=
 the core is not in a halt state. The core enters the halt state when it is=
 running the HLT instruction or the MWAIT instruction. This event is not af=
fected by core frequency changes (for example, P states, TM2 transitions) b=
ut has the same incrementing frequency as the time stamp counter. This even=
t can approximate elapsed time while the core was not in a halt state. It i=
s counted on a dedicated fixed counter, leaving the eight programmable coun=
ters available for other events. Note: On all current platforms this event =
stops counting during 'throttling (TM)' states duty off periods the process=
or is 'halted'.  The counter update is done at a lower clock rate then the =
core clock the overflow status bit for this counter may appear 'sticky'.  A=
fter the counter has overflowed and software clears the overflow status bit=
 and resets the counter to less than MAX. The reset value to the counter is=
 not clocked immediately so the overflow status bit will flip 'high (1)' an=
d generate another PMI (if enabled) after which the reset value gets clocke=
d into the counter. Therefore, software will get the interrupt, read the ov=
erflow status bit '1 for bit 34 while the counter value is less than MAX. S=
oftware should ignore this case.",
>          "SampleAfterValue": "2000003",
> @@ -584,6 +587,7 @@
>      },
>      {
>          "BriefDescription": "Counts the number of unhalted core clock cy=
cles. (Fixed event)",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "PublicDescription": "Counts the number of core cycles while the=
 core is not in a halt state.  The core enters the halt state when it is ru=
nning the HLT instruction. The core frequency may change from time to time.=
 For this reason this event may have a changing ratio with regards to time.=
  This event uses fixed counter 1.",
>          "SampleAfterValue": "2000003",
> @@ -592,6 +596,7 @@
>      },
>      {
>          "BriefDescription": "Core cycles when the thread is not in halt =
state",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "PublicDescription": "Counts the number of core cycles while the=
 thread is not in a halt state. The thread enters the halt state when it is=
 running the HLT instruction. This event is a component in many key event r=
atios. The core frequency may change from time to time due to transitions a=
ssociated with Enhanced Intel SpeedStep Technology or TM2. For this reason =
this event may have a changing ratio with regards to time. When the core fr=
equency is constant, this event can approximate elapsed time while the core=
 was not in the halt state. It is counted on a dedicated fixed counter, lea=
ving the eight programmable counters available for other events.",
>          "SampleAfterValue": "2000003",
> @@ -743,6 +748,7 @@
>      },
>      {
>          "BriefDescription": "Counts the total number of instructions ret=
ired. (Fixed event)",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "PEBS": "1",
>          "PublicDescription": "Counts the total number of instructions th=
at retired. For instructions that consist of multiple uops, this event coun=
ts the retirement of the last uop of the instruction. This event continues =
counting during hardware interrupts, traps, and inside interrupt handlers. =
This event uses fixed counter 0.",
> @@ -752,6 +758,7 @@
>      },
>      {
>          "BriefDescription": "Number of instructions retired. Fixed Count=
er - architectural event",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "PEBS": "1",
>          "PublicDescription": "Counts the number of X86 instructions reti=
red - an Architectural PerfMon event. Counting continues during hardware in=
terrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is =
counted by a designated fixed counter freeing up programmable counters to c=
ount other events. INST_RETIRED.ANY_P is counted by a programmable counter.=
",
> @@ -796,6 +803,7 @@
>      },
>      {
>          "BriefDescription": "Precise instruction retired with PEBS preci=
se-distribution",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.PREC_DIST",
>          "PEBS": "1",
>          "PublicDescription": "A version of INST_RETIRED that allows for =
a precise distribution of samples across instructions retired. It utilizes =
the Precise Distribution of Instructions Retired (PDIR++) feature to fix bi=
as in how retired instructions get sampled. Use on Fixed Counter 0.",
> @@ -1160,6 +1168,7 @@
>      },
>      {
>          "BriefDescription": "TMA slots available for an unhalted logical=
 processor. Fixed counter - architectural event",
> +        "EventCode": "0x0",
>          "EventName": "TOPDOWN.SLOTS",
>          "PublicDescription": "Number of available slots for an unhalted =
logical processor. The event increments by machine-width of the narrowest p=
ipeline as employed by the Top-down Microarchitecture Analysis method (TMA)=
. The count is distributed among unhalted logical processors (hyper-threads=
) who share the same physical core. Software can use this event as the deno=
minator for the top-level metrics of the TMA method. This architectural eve=
nt is counted on a designated fixed counter (Fixed Counter 3).",
>          "SampleAfterValue": "10000003",
> diff --git a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/alderlaken/pipeline.json
> index fa53ff1..345d1c8 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlaken/pipeline.json
> @@ -211,6 +211,7 @@
>      },
>      {
>          "BriefDescription": "Counts the number of unhalted core clock cy=
cles. (Fixed event)",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.CORE",
>          "PublicDescription": "Counts the number of core cycles while the=
 core is not in a halt state. The core enters the halt state when it is run=
ning the HLT instruction. The core frequency may change from time to time. =
For this reason this event may have a changing ratio with regards to time. =
This event uses fixed counter 1.",
>          "SampleAfterValue": "2000003",
> @@ -225,6 +226,7 @@
>      },
>      {
>          "BriefDescription": "Counts the number of unhalted reference clo=
ck cycles at TSC frequency. (Fixed event)",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "Counts the number of reference cycles that=
 the core is not in a halt state. The core enters the halt state when it is=
 running the HLT instruction. This event is not affected by core frequency =
changes and increments at a fixed frequency that is also used for the Time =
Stamp Counter (TSC). This event uses fixed counter 2.",
>          "SampleAfterValue": "2000003",
> @@ -240,6 +242,7 @@
>      },
>      {
>          "BriefDescription": "Counts the number of unhalted core clock cy=
cles. (Fixed event)",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "PublicDescription": "Counts the number of core cycles while the=
 core is not in a halt state.  The core enters the halt state when it is ru=
nning the HLT instruction. The core frequency may change from time to time.=
 For this reason this event may have a changing ratio with regards to time.=
  This event uses fixed counter 1.",
>          "SampleAfterValue": "2000003",
> diff --git a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/broadwell/pipeline.json
> index 9a902d2..b114d0d 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwell/pipeline.json
> @@ -336,6 +336,7 @@
>      },
>      {
>          "BriefDescription": "Reference cycles when the core is not in ha=
lt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "This event counts the number of reference =
cycles when the core is not in a halt state. The core enters the halt state=
 when it is running the HLT instruction or the MWAIT instruction. This even=
t is not affected by core frequency changes (for example, P states, TM2 tra=
nsitions) but has the same incrementing frequency as the time stamp counter=
. This event can approximate elapsed time while the core was not in a halt =
state. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK e=
vent. It is counted on a dedicated fixed counter, leaving the four (eight w=
hen Hyperthreading is disabled) programmable counters available for other e=
vents. \nNote: On all current platforms this event stops counting during 't=
hrottling (TM)' states duty off periods the processor is 'halted'.  This ev=
ent is clocked by base clock (100 Mhz) on Sandy Bridge. The counter update =
is done at a lower clock rate then the core clock the overflow status bit f=
or this counter may appear 'sticky'.  After the counter has overflowed and =
software clears the overflow status bit and resets the counter to less than=
 MAX. The reset value to the counter is not clocked immediately so the over=
flow status bit will flip 'high (1)' and generate another PMI (if enabled) =
after which the reset value gets clocked into the counter. Therefore, softw=
are will get the interrupt, read the overflow status bit '1 for bit 34 whil=
e the counter value is less than MAX. Software should ignore this case.",
>          "SampleAfterValue": "2000003",
> @@ -359,6 +360,7 @@
>      },
>      {
>          "BriefDescription": "Core cycles when the thread is not in halt =
state",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "PublicDescription": "This event counts the number of core cycle=
s while the thread is not in a halt state. The thread enters the halt state=
 when it is running the HLT instruction. This event is a component in many =
key event ratios. The core frequency may change from time to time due to tr=
ansitions associated with Enhanced Intel SpeedStep Technology or TM2. For t=
his reason this event may have a changing ratio with regards to time. When =
the core frequency is constant, this event can approximate elapsed time whi=
le the core was not in the halt state. It is counted on a dedicated fixed c=
ounter, leaving the four (eight when Hyperthreading is disabled) programmab=
le counters available for other events.",
>          "SampleAfterValue": "2000003",
> @@ -366,6 +368,7 @@
>      },
>      {
>          "AnyThread": "1",
> +        "EventCode": "0x0",
>          "BriefDescription": "Core cycles when at least one thread on the=
 physical core is not in halt state.",
>          "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
>          "SampleAfterValue": "2000003",
> @@ -514,6 +517,7 @@
>      },
>      {
>          "BriefDescription": "Instructions retired from execution.",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "PublicDescription": "This event counts the number of instructio=
ns retired from execution. For instructions that consist of multiple micro-=
ops, this event counts the retirement of the last micro-op of the instructi=
on. Counting continues during hardware interrupts, traps, and inside interr=
upt handlers. \nNotes: INST_RETIRED.ANY is counted by a designated fixed co=
unter, leaving the four (eight when Hyperthreading is disabled) programmabl=
e counters available for other events. INST_RETIRED.ANY_P is counted by a p=
rogrammable counter and it is an architectural performance event. \nCountin=
g: Faulting executions of GETSEC/VM entry/VM Exit/MWait will not count as r=
etired instructions.",
>          "SampleAfterValue": "2000003",
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
> index 9a902d2..ce90d058 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/pipeline.json
> @@ -336,6 +336,7 @@
>      },
>      {
>          "BriefDescription": "Reference cycles when the core is not in ha=
lt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "This event counts the number of reference =
cycles when the core is not in a halt state. The core enters the halt state=
 when it is running the HLT instruction or the MWAIT instruction. This even=
t is not affected by core frequency changes (for example, P states, TM2 tra=
nsitions) but has the same incrementing frequency as the time stamp counter=
. This event can approximate elapsed time while the core was not in a halt =
state. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK e=
vent. It is counted on a dedicated fixed counter, leaving the four (eight w=
hen Hyperthreading is disabled) programmable counters available for other e=
vents. \nNote: On all current platforms this event stops counting during 't=
hrottling (TM)' states duty off periods the processor is 'halted'.  This ev=
ent is clocked by base clock (100 Mhz) on Sandy Bridge. The counter update =
is done at a lower clock rate then the core clock the overflow status bit f=
or this counter may appear 'sticky'.  After the counter has overflowed and =
software clears the overflow status bit and resets the counter to less than=
 MAX. The reset value to the counter is not clocked immediately so the over=
flow status bit will flip 'high (1)' and generate another PMI (if enabled) =
after which the reset value gets clocked into the counter. Therefore, softw=
are will get the interrupt, read the overflow status bit '1 for bit 34 whil=
e the counter value is less than MAX. Software should ignore this case.",
>          "SampleAfterValue": "2000003",
> @@ -359,6 +360,7 @@
>      },
>      {
>          "BriefDescription": "Core cycles when the thread is not in halt =
state",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "PublicDescription": "This event counts the number of core cycle=
s while the thread is not in a halt state. The thread enters the halt state=
 when it is running the HLT instruction. This event is a component in many =
key event ratios. The core frequency may change from time to time due to tr=
ansitions associated with Enhanced Intel SpeedStep Technology or TM2. For t=
his reason this event may have a changing ratio with regards to time. When =
the core frequency is constant, this event can approximate elapsed time whi=
le the core was not in the halt state. It is counted on a dedicated fixed c=
ounter, leaving the four (eight when Hyperthreading is disabled) programmab=
le counters available for other events.",
>          "SampleAfterValue": "2000003",
> @@ -367,6 +369,7 @@
>      {
>          "AnyThread": "1",
>          "BriefDescription": "Core cycles when at least one thread on the=
 physical core is not in halt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x2"
> @@ -514,6 +517,7 @@
>      },
>      {
>          "BriefDescription": "Instructions retired from execution.",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "PublicDescription": "This event counts the number of instructio=
ns retired from execution. For instructions that consist of multiple micro-=
ops, this event counts the retirement of the last micro-op of the instructi=
on. Counting continues during hardware interrupts, traps, and inside interr=
upt handlers. \nNotes: INST_RETIRED.ANY is counted by a designated fixed co=
unter, leaving the four (eight when Hyperthreading is disabled) programmabl=
e counters available for other events. INST_RETIRED.ANY_P is counted by a p=
rogrammable counter and it is an architectural performance event. \nCountin=
g: Faulting executions of GETSEC/VM entry/VM Exit/MWait will not count as r=
etired instructions.",
>          "SampleAfterValue": "2000003",
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json=
 b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
> index 56bba6d..117be19 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-cache.json
> @@ -8,6 +8,7 @@
>      },
>      {
>          "BriefDescription": "Uncore Clocks",
> +        "EventCode": "0x0",
>          "EventName": "UNC_C_CLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "CBOX"
> @@ -1501,6 +1502,7 @@
>      },
>      {
>          "BriefDescription": "uclks",
> +        "EventCode": "0x0",
>          "EventName": "UNC_H_CLOCKTICKS",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of uclks in the HA.  Thi=
s will be slightly different than the count in the Ubox because of enable/f=
reeze delays.  The HA is on the other side of the die from the fixed Ubox u=
clk counter, so the drift could be somewhat larger than in units that are c=
loser like the QPI Agent.",
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconne=
ct.json b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect.js=
on
> index 9103959..3ed95a6 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-interconnect.json
> @@ -19,6 +19,7 @@
>      },
>      {
>          "BriefDescription": "Clocks in the IRP",
> +        "EventCode": "0x0",
>          "EventName": "UNC_I_CLOCKTICKS",
>          "PerPkg": "1",
>          "PublicDescription": "Number of clocks in the IRP.",
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.jso=
n b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json
> index a764234..32c46bd 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-memory.json
> @@ -131,6 +131,7 @@
>      },
>      {
>          "BriefDescription": "DRAM Clockticks",
> +        "EventCode": "0x0",
>          "EventName": "UNC_M_DCLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "iMC"
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json=
 b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
> index 83d2013..f57eb8e 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/uncore-power.json
> @@ -1,6 +1,7 @@
>  [
>      {
>          "BriefDescription": "pclk Cycles",
> +        "EventCode": "0x0",
>          "EventName": "UNC_P_CLOCKTICKS",
>          "PerPkg": "1",
>          "PublicDescription": "The PCU runs off a fixed 1 GHz clock.  Thi=
s event counts the number of pclk cycles measured while the counter was ena=
bled.  The pclk, like the Memory Controller's dclk, counts at a constant ra=
te making it a good measure of actual wall time.",
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/broadwellx/pipeline.json
> index 9a902d2..ce90d058 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/pipeline.json
> @@ -336,6 +336,7 @@
>      },
>      {
>          "BriefDescription": "Reference cycles when the core is not in ha=
lt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "This event counts the number of reference =
cycles when the core is not in a halt state. The core enters the halt state=
 when it is running the HLT instruction or the MWAIT instruction. This even=
t is not affected by core frequency changes (for example, P states, TM2 tra=
nsitions) but has the same incrementing frequency as the time stamp counter=
. This event can approximate elapsed time while the core was not in a halt =
state. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK e=
vent. It is counted on a dedicated fixed counter, leaving the four (eight w=
hen Hyperthreading is disabled) programmable counters available for other e=
vents. \nNote: On all current platforms this event stops counting during 't=
hrottling (TM)' states duty off periods the processor is 'halted'.  This ev=
ent is clocked by base clock (100 Mhz) on Sandy Bridge. The counter update =
is done at a lower clock rate then the core clock the overflow status bit f=
or this counter may appear 'sticky'.  After the counter has overflowed and =
software clears the overflow status bit and resets the counter to less than=
 MAX. The reset value to the counter is not clocked immediately so the over=
flow status bit will flip 'high (1)' and generate another PMI (if enabled) =
after which the reset value gets clocked into the counter. Therefore, softw=
are will get the interrupt, read the overflow status bit '1 for bit 34 whil=
e the counter value is less than MAX. Software should ignore this case.",
>          "SampleAfterValue": "2000003",
> @@ -359,6 +360,7 @@
>      },
>      {
>          "BriefDescription": "Core cycles when the thread is not in halt =
state",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "PublicDescription": "This event counts the number of core cycle=
s while the thread is not in a halt state. The thread enters the halt state=
 when it is running the HLT instruction. This event is a component in many =
key event ratios. The core frequency may change from time to time due to tr=
ansitions associated with Enhanced Intel SpeedStep Technology or TM2. For t=
his reason this event may have a changing ratio with regards to time. When =
the core frequency is constant, this event can approximate elapsed time whi=
le the core was not in the halt state. It is counted on a dedicated fixed c=
ounter, leaving the four (eight when Hyperthreading is disabled) programmab=
le counters available for other events.",
>          "SampleAfterValue": "2000003",
> @@ -367,6 +369,7 @@
>      {
>          "AnyThread": "1",
>          "BriefDescription": "Core cycles when at least one thread on the=
 physical core is not in halt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x2"
> @@ -514,6 +517,7 @@
>      },
>      {
>          "BriefDescription": "Instructions retired from execution.",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "PublicDescription": "This event counts the number of instructio=
ns retired from execution. For instructions that consist of multiple micro-=
ops, this event counts the retirement of the last micro-op of the instructi=
on. Counting continues during hardware interrupts, traps, and inside interr=
upt handlers. \nNotes: INST_RETIRED.ANY is counted by a designated fixed co=
unter, leaving the four (eight when Hyperthreading is disabled) programmabl=
e counters available for other events. INST_RETIRED.ANY_P is counted by a p=
rogrammable counter and it is an architectural performance event. \nCountin=
g: Faulting executions of GETSEC/VM entry/VM Exit/MWait will not count as r=
etired instructions.",
>          "SampleAfterValue": "2000003",
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json =
b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
> index 400d784..346f5cf 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-cache.json
> @@ -183,6 +183,7 @@
>      },
>      {
>          "BriefDescription": "Uncore Clocks",
> +        "EventCode": "0x0",
>          "EventName": "UNC_C_CLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "CBOX"
> @@ -1689,6 +1690,7 @@
>      },
>      {
>          "BriefDescription": "uclks",
> +        "EventCode": "0x0",
>          "EventName": "UNC_H_CLOCKTICKS",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of uclks in the HA.  Thi=
s will be slightly different than the count in the Ubox because of enable/f=
reeze delays.  The HA is on the other side of the die from the fixed Ubox u=
clk counter, so the drift could be somewhat larger than in units that are c=
loser like the QPI Agent.",
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnec=
t.json b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
> index b9fb216..68232e7 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-interconnect.json
> @@ -1,6 +1,7 @@
>  [
>      {
>          "BriefDescription": "Number of non data (control) flits transmit=
ted . Derived from unc_q_txl_flits_g0.non_data",
> +        "EventCode": "0x0",
>          "EventName": "QPI_CTL_BANDWIDTH_TX",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  It includes filters for Idle, protocol, and Data Flits. =
 Each flit is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four fits, each of whic=
h contains 20 bits of data (along with some additional ECC data).   In half=
-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice =
as many fits to transmit a flit.  When one talks about QPI speed (for examp=
le, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the sys=
tem will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as data bandwidth.  For example, when we are transferring a =
64B cacheline across QPI, we will break it into 9 flits -- 1 with header in=
formation and 8 with 64 bits of actual data and an additional 16 bits of ot=
her information.  To calculate data bandwidth, one should therefore do: dat=
a flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NU=
LL non-data flits transmitted across QPI.  This basically tracks the protoc=
ol overhead on the QPI link.  One can get a good picture of the QPI-link ch=
aracteristics by evaluating the protocol flits, data flits, and idle/null f=
lits.  This includes the header flits for data packets.",
> @@ -10,6 +11,7 @@
>      },
>      {
>          "BriefDescription": "Number of data flits transmitted . Derived =
from unc_q_txl_flits_g0.data",
> +        "EventCode": "0x0",
>          "EventName": "QPI_DATA_BANDWIDTH_TX",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  It includes filters for Idle, protocol, and Data Flits. =
 Each flit is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four fits, each of whic=
h contains 20 bits of data (along with some additional ECC data).   In half=
-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice =
as many fits to transmit a flit.  When one talks about QPI speed (for examp=
le, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the sys=
tem will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as data bandwidth.  For example, when we are transferring a =
64B cacheline across QPI, we will break it into 9 flits -- 1 with header in=
formation and 8 with 64 bits of actual data and an additional 16 bits of ot=
her information.  To calculate data bandwidth, one should therefore do: dat=
a flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data f=
lits transmitted over QPI.  Each flit contains 64b of data.  This includes =
both DRS and NCB data flits (coherent and non-coherent).  This can be used =
to calculate the data bandwidth of the QPI link.  One can get a good pictur=
e of the QPI-link characteristics by evaluating the protocol flits, data fl=
its, and idle/null flits.  This does not include the header flits that go i=
n data packets.",
> @@ -37,6 +39,7 @@
>      },
>      {
>          "BriefDescription": "Clocks in the IRP",
> +        "EventCode": "0x0",
>          "EventName": "UNC_I_CLOCKTICKS",
>          "PerPkg": "1",
>          "PublicDescription": "Number of clocks in the IRP.",
> @@ -1400,6 +1403,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 0; Data Tx Flits"=
,
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G0.DATA",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  It includes filters for Idle, protocol, and Data Flits. =
 Each flit is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four fits, each of whic=
h contains 20 bits of data (along with some additional ECC data).   In half=
-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice =
as many fits to transmit a flit.  When one talks about QPI speed (for examp=
le, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the sys=
tem will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as data bandwidth.  For example, when we are transferring a =
64B cacheline across QPI, we will break it into 9 flits -- 1 with header in=
formation and 8 with 64 bits of actual data and an additional 16 bits of ot=
her information.  To calculate data bandwidth, one should therefore do: dat=
a flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data f=
lits transmitted over QPI.  Each flit contains 64b of data.  This includes =
both DRS and NCB data flits (coherent and non-coherent).  This can be used =
to calculate the data bandwidth of the QPI link.  One can get a good pictur=
e of the QPI-link characteristics by evaluating the protocol flits, data fl=
its, and idle/null flits.  This does not include the header flits that go i=
n data packets.",
> @@ -1408,6 +1412,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 0; Non-Data proto=
col Tx Flits",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G0.NON_DATA",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  It includes filters for Idle, protocol, and Data Flits. =
 Each flit is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four fits, each of whic=
h contains 20 bits of data (along with some additional ECC data).   In half=
-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice =
as many fits to transmit a flit.  When one talks about QPI speed (for examp=
le, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the sys=
tem will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as data bandwidth.  For example, when we are transferring a =
64B cacheline across QPI, we will break it into 9 flits -- 1 with header in=
formation and 8 with 64 bits of actual data and an additional 16 bits of ot=
her information.  To calculate data bandwidth, one should therefore do: dat=
a flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NU=
LL non-data flits transmitted across QPI.  This basically tracks the protoc=
ol overhead on the QPI link.  One can get a good picture of the QPI-link ch=
aracteristics by evaluating the protocol flits, data flits, and idle/null f=
lits.  This includes the header flits for data packets.",
> @@ -1416,6 +1421,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; DRS Flits (bot=
h Header and Data)",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.DRS",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three groups that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is=
 made up of 80 bits of information (in addition to some ECC data).  In full=
-width (L0) mode, flits are made up of four fits, each of which contains 20=
 bits of data (along with some additional ECC data).   In half-width (L0p) =
mode, the fits are only 10 bits, and therefore it takes twice as many fits =
to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s)=
, the transfers here refer to fits.  Therefore, in L0, the system will tran=
sfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the band=
width of the link by taking: flits*80b/time.  Note that this is not the sam=
e as data bandwidth.  For example, when we are transferring a 64B cacheline=
 across QPI, we will break it into 9 flits -- 1 with header information and=
 8 with 64 bits of actual data and an additional 16 bits of other informati=
on.  To calculate data bandwidth, one should therefore do: data flits * 8B =
/ time.; Counts the total number of flits transmitted over QPI on the DRS (=
Data Response) channel.  DRS flits are used to transmit data with coherency=
.",
> @@ -1424,6 +1430,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; DRS Data Flits=
",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.DRS_DATA",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three groups that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is=
 made up of 80 bits of information (in addition to some ECC data).  In full=
-width (L0) mode, flits are made up of four fits, each of which contains 20=
 bits of data (along with some additional ECC data).   In half-width (L0p) =
mode, the fits are only 10 bits, and therefore it takes twice as many fits =
to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s)=
, the transfers here refer to fits.  Therefore, in L0, the system will tran=
sfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the band=
width of the link by taking: flits*80b/time.  Note that this is not the sam=
e as data bandwidth.  For example, when we are transferring a 64B cacheline=
 across QPI, we will break it into 9 flits -- 1 with header information and=
 8 with 64 bits of actual data and an additional 16 bits of other informati=
on.  To calculate data bandwidth, one should therefore do: data flits * 8B =
/ time.; Counts the total number of data flits transmitted over QPI on the =
DRS (Data Response) channel.  DRS flits are used to transmit data with cohe=
rency.  This does not count data flits transmitted over the NCB channel whi=
ch transmits non-coherent data.  This includes only the data flits (not the=
 header).",
> @@ -1432,6 +1439,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; DRS Header Fli=
ts",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.DRS_NONDATA",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three groups that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is=
 made up of 80 bits of information (in addition to some ECC data).  In full=
-width (L0) mode, flits are made up of four fits, each of which contains 20=
 bits of data (along with some additional ECC data).   In half-width (L0p) =
mode, the fits are only 10 bits, and therefore it takes twice as many fits =
to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s)=
, the transfers here refer to fits.  Therefore, in L0, the system will tran=
sfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the band=
width of the link by taking: flits*80b/time.  Note that this is not the sam=
e as data bandwidth.  For example, when we are transferring a 64B cacheline=
 across QPI, we will break it into 9 flits -- 1 with header information and=
 8 with 64 bits of actual data and an additional 16 bits of other informati=
on.  To calculate data bandwidth, one should therefore do: data flits * 8B =
/ time.; Counts the total number of protocol flits transmitted over QPI on =
the DRS (Data Response) channel.  DRS flits are used to transmit data with =
coherency.  This does not count data flits transmitted over the NCB channel=
 which transmits non-coherent data.  This includes only the header flits (n=
ot the data).  This includes extended headers.",
> @@ -1440,6 +1448,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; HOM Flits",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.HOM",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three groups that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is=
 made up of 80 bits of information (in addition to some ECC data).  In full=
-width (L0) mode, flits are made up of four fits, each of which contains 20=
 bits of data (along with some additional ECC data).   In half-width (L0p) =
mode, the fits are only 10 bits, and therefore it takes twice as many fits =
to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s)=
, the transfers here refer to fits.  Therefore, in L0, the system will tran=
sfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the band=
width of the link by taking: flits*80b/time.  Note that this is not the sam=
e as data bandwidth.  For example, when we are transferring a 64B cacheline=
 across QPI, we will break it into 9 flits -- 1 with header information and=
 8 with 64 bits of actual data and an additional 16 bits of other informati=
on.  To calculate data bandwidth, one should therefore do: data flits * 8B =
/ time.; Counts the number of flits transmitted over QPI on the home channe=
l.",
> @@ -1448,6 +1457,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; HOM Non-Reques=
t Flits",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.HOM_NONREQ",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three groups that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is=
 made up of 80 bits of information (in addition to some ECC data).  In full=
-width (L0) mode, flits are made up of four fits, each of which contains 20=
 bits of data (along with some additional ECC data).   In half-width (L0p) =
mode, the fits are only 10 bits, and therefore it takes twice as many fits =
to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s)=
, the transfers here refer to fits.  Therefore, in L0, the system will tran=
sfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the band=
width of the link by taking: flits*80b/time.  Note that this is not the sam=
e as data bandwidth.  For example, when we are transferring a 64B cacheline=
 across QPI, we will break it into 9 flits -- 1 with header information and=
 8 with 64 bits of actual data and an additional 16 bits of other informati=
on.  To calculate data bandwidth, one should therefore do: data flits * 8B =
/ time.; Counts the number of non-request flits transmitted over QPI on the=
 home channel.  These are most commonly snoop responses, and this event can=
 be used as a proxy for that.",
> @@ -1456,6 +1466,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; HOM Request Fl=
its",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.HOM_REQ",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three groups that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is=
 made up of 80 bits of information (in addition to some ECC data).  In full=
-width (L0) mode, flits are made up of four fits, each of which contains 20=
 bits of data (along with some additional ECC data).   In half-width (L0p) =
mode, the fits are only 10 bits, and therefore it takes twice as many fits =
to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s)=
, the transfers here refer to fits.  Therefore, in L0, the system will tran=
sfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the band=
width of the link by taking: flits*80b/time.  Note that this is not the sam=
e as data bandwidth.  For example, when we are transferring a 64B cacheline=
 across QPI, we will break it into 9 flits -- 1 with header information and=
 8 with 64 bits of actual data and an additional 16 bits of other informati=
on.  To calculate data bandwidth, one should therefore do: data flits * 8B =
/ time.; Counts the number of data request transmitted over QPI on the home=
 channel.  This basically counts the number of remote memory requests trans=
mitted over QPI.  In conjunction with the local read count in the Home Agen=
t, one can calculate the number of LLC Misses.",
> @@ -1464,6 +1475,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; SNP Flits",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.SNP",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three groups that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is=
 made up of 80 bits of information (in addition to some ECC data).  In full=
-width (L0) mode, flits are made up of four fits, each of which contains 20=
 bits of data (along with some additional ECC data).   In half-width (L0p) =
mode, the fits are only 10 bits, and therefore it takes twice as many fits =
to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s)=
, the transfers here refer to fits.  Therefore, in L0, the system will tran=
sfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the band=
width of the link by taking: flits*80b/time.  Note that this is not the sam=
e as data bandwidth.  For example, when we are transferring a 64B cacheline=
 across QPI, we will break it into 9 flits -- 1 with header information and=
 8 with 64 bits of actual data and an additional 16 bits of other informati=
on.  To calculate data bandwidth, one should therefore do: data flits * 8B =
/ time.; Counts the number of snoop request flits transmitted over QPI.  Th=
ese requests are contained in the snoop channel.  This does not include sno=
op responses, which are transmitted on the home channel.",
> @@ -3162,6 +3174,7 @@
>      },
>      {
>          "BriefDescription": "Uncore Clocks",
> +        "EventCode": "0x0",
>          "EventName": "UNC_S_CLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "SBOX"
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-memory.json=
 b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-memory.json
> index b5a33e7a..0c5888d 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-memory.json
> @@ -158,12 +158,14 @@
>      },
>      {
>          "BriefDescription": "Clockticks in the Memory Controller using o=
ne of the programmable counters",
> +        "EventCode": "0x0",
>          "EventName": "UNC_M_CLOCKTICKS_P",
>          "PerPkg": "1",
>          "Unit": "iMC"
>      },
>      {
>          "BriefDescription": "This event is deprecated. Refer to new even=
t UNC_M_CLOCKTICKS_P",
> +        "EventCode": "0x0",
>          "EventName": "UNC_M_DCLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "iMC"
> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json =
b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
> index 83d2013..f57eb8e 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/uncore-power.json
> @@ -1,6 +1,7 @@
>  [
>      {
>          "BriefDescription": "pclk Cycles",
> +        "EventCode": "0x0",
>          "EventName": "UNC_P_CLOCKTICKS",
>          "PerPkg": "1",
>          "PublicDescription": "The PCU runs off a fixed 1 GHz clock.  Thi=
s event counts the number of pclk cycles measured while the counter was ena=
bled.  The pclk, like the Memory Controller's dclk, counts at a constant ra=
te making it a good measure of actual wall time.",
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json b/=
tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
> index 66d686c..efda247 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/pipeline.json
> @@ -200,6 +200,7 @@
>      },
>      {
>          "BriefDescription": "Reference cycles when the core is not in ha=
lt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "Counts the number of reference cycles when=
 the core is not in a halt state. The core enters the halt state when it is=
 running the HLT instruction or the MWAIT instruction. This event is not af=
fected by core frequency changes (for example, P states, TM2 transitions) b=
ut has the same incrementing frequency as the time stamp counter. This even=
t can approximate elapsed time while the core was not in a halt state. This=
 event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is=
 counted on a dedicated fixed counter, leaving the four (eight when Hyperth=
reading is disabled) programmable counters available for other events. Note=
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
>          "SampleAfterValue": "2000003",
> @@ -231,6 +232,7 @@
>      },
>      {
>          "BriefDescription": "Core cycles when the thread is not in halt =
state",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "PublicDescription": "Counts the number of core cycles while the=
 thread is not in a halt state. The thread enters the halt state when it is=
 running the HLT instruction. This event is a component in many key event r=
atios. The core frequency may change from time to time due to transitions a=
ssociated with Enhanced Intel SpeedStep Technology or TM2. For this reason =
this event may have a changing ratio with regards to time. When the core fr=
equency is constant, this event can approximate elapsed time while the core=
 was not in the halt state. It is counted on a dedicated fixed counter, lea=
ving the four (eight when Hyperthreading is disabled) programmable counters=
 available for other events.",
>          "SampleAfterValue": "2000003",
> @@ -239,6 +241,7 @@
>      {
>          "AnyThread": "1",
>          "BriefDescription": "Core cycles when at least one thread on the=
 physical core is not in halt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x2"
> @@ -378,6 +381,7 @@
>      },
>      {
>          "BriefDescription": "Instructions retired from execution.",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "PublicDescription": "Counts the number of instructions retired =
from execution. For instructions that consist of multiple micro-ops, Counts=
 the retirement of the last micro-op of the instruction. Counting continues=
 during hardware interrupts, traps, and inside interrupt handlers. Notes: I=
NST_RETIRED.ANY is counted by a designated fixed counter, leaving the four =
(eight when Hyperthreading is disabled) programmable counters available for=
 other events. INST_RETIRED.ANY_P is counted by a programmable counter and =
it is an architectural performance event. Counting: Faulting executions of =
GETSEC/VM entry/VM Exit/MWait will not count as retired instructions.",
>          "SampleAfterValue": "2000003",
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.jso=
n b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json
> index 2c88053..ba7a6f6 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-cache.json
> @@ -512,6 +512,7 @@
>      },
>      {
>          "BriefDescription": "Uncore cache clock ticks",
> +        "EventCode": "0x0",
>          "EventName": "UNC_CHA_CLOCKTICKS",
>          "PerPkg": "1",
>          "PublicDescription": "Counts clockticks of the clock controlling=
 the uncore caching and home agent (CHA).",
> @@ -5792,6 +5793,7 @@
>      },
>      {
>          "BriefDescription": "This event is deprecated. Refer to new even=
t UNC_CHA_CLOCKTICKS",
> +        "EventCode": "0x0",
>          "Deprecated": "1",
>          "EventName": "UNC_C_CLOCKTICKS",
>          "PerPkg": "1",
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-interconn=
ect.json b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-interconnect.=
json
> index 1a342df..deae678 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-interconnect.jso=
n
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-interconnect.jso=
n
> @@ -1090,6 +1090,7 @@
>      },
>      {
>          "BriefDescription": "Cycles - at UCLK",
> +        "EventCode": "0x0",
>          "EventName": "UNC_M2M_CLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "M2M"
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-io.json b=
/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-io.json
> index 743c91f..377d54f 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-io.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-io.json
> @@ -1271,6 +1271,7 @@
>      },
>      {
>          "BriefDescription": "Counting disabled",
> +        "EventCode": "0x0",
>          "EventName": "UNC_IIO_NOTHING",
>          "PerPkg": "1",
>          "Unit": "IIO"
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.js=
on b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
> index d82d2cc..6b1217e 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-memory.json
> @@ -167,6 +167,7 @@
>      },
>      {
>          "BriefDescription": "Memory controller clock ticks",
> +        "EventCode": "0x0",
>          "EventName": "UNC_M_CLOCKTICKS",
>          "PerPkg": "1",
>          "PublicDescription": "Counts clockticks of the fixed frequency c=
lock of the memory controller using one of the programmable counters.",
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.jso=
n b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
> index c6254af..a01b279 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/uncore-power.json
> @@ -1,6 +1,7 @@
>  [
>      {
>          "BriefDescription": "pclk Cycles",
> +        "EventCode": "0x0",
>          "EventName": "UNC_P_CLOCKTICKS",
>          "PerPkg": "1",
>          "PublicDescription": "The PCU runs off a fixed 1 GHz clock.  Thi=
s event counts the number of pclk cycles measured while the counter was ena=
bled.  The pclk, like the Memory Controller's dclk, counts at a constant ra=
te making it a good measure of actual wall time.",
> diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
> index c483c08..2e40cd0 100644
> --- a/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
> @@ -150,6 +150,7 @@
>      },
>      {
>          "BriefDescription": "Counts the number of unhalted reference clo=
ck cycles at TSC frequency. (Fixed event)",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "Counts the number of reference cycles that=
 the core is not in a halt state. The core enters the halt state when it is=
 running the HLT instruction. This event is not affected by core frequency =
changes and increments at a fixed frequency that is also used for the Time =
Stamp Counter (TSC). This event uses fixed counter 2.",
>          "SampleAfterValue": "2000003",
> @@ -180,6 +181,7 @@
>      },
>      {
>          "BriefDescription": "Counts the total number of instructions ret=
ired. (Fixed event)",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "PEBS": "1",
>          "PublicDescription": "Counts the total number of instructions th=
at retired. For instructions that consist of multiple uops, this event coun=
ts the retirement of the last uop of the instruction. This event continues =
counting during hardware interrupts, traps, and inside interrupt handlers. =
This event uses fixed counter 0.",
> diff --git a/tools/perf/pmu-events/arch/x86/goldmont/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/goldmont/pipeline.json
> index acb8974..79806e7 100644
> --- a/tools/perf/pmu-events/arch/x86/goldmont/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/goldmont/pipeline.json
> @@ -143,6 +143,7 @@
>      },
>      {
>          "BriefDescription": "Core cycles when core is not halted  (Fixed=
 event)",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.CORE",
>          "PublicDescription": "Counts the number of core cycles while the=
 core is not in a halt state.  The core enters the halt state when it is ru=
nning the HLT instruction. In mobile systems the core frequency may change =
from time to time. For this reason this event may have a changing ratio wit=
h regards to time.  This event uses fixed counter 1.  You cannot collect a =
PEBs record for this event.",
>          "SampleAfterValue": "2000003",
> @@ -165,6 +166,7 @@
>      },
>      {
>          "BriefDescription": "Reference cycles when core is not halted  (=
Fixed event)",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "Counts the number of reference cycles that=
 the core is not in a halt state. The core enters the halt state when it is=
 running the HLT instruction.  In mobile systems the core frequency may cha=
nge from time.  This event is not affected by core frequency changes but co=
unts as if the core is running at the maximum frequency all the time.  This=
 event uses fixed counter 2.  You cannot collect a PEBs record for this eve=
nt.",
>          "SampleAfterValue": "2000003",
> @@ -187,6 +189,7 @@
>      },
>      {
>          "BriefDescription": "Instructions retired (Fixed event)",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "PublicDescription": "Counts the number of instructions that ret=
ire execution. For instructions that consist of multiple uops, this event c=
ounts the retirement of the last uop of the instruction. The counter contin=
ues counting during hardware interrupts, traps, and inside interrupt handle=
rs.  This event uses fixed counter 0.  You cannot collect a PEBs record for=
 this event.",
>          "SampleAfterValue": "2000003",
> diff --git a/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json b/=
tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
> index 33ef331..1be1b50 100644
> --- a/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
> @@ -143,6 +143,7 @@
>      },
>      {
>          "BriefDescription": "Core cycles when core is not halted  (Fixed=
 event)",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.CORE",
>          "PublicDescription": "Counts the number of core cycles while the=
 core is not in a halt state.  The core enters the halt state when it is ru=
nning the HLT instruction. In mobile systems the core frequency may change =
from time to time. For this reason this event may have a changing ratio wit=
h regards to time.  This event uses fixed counter 1.  You cannot collect a =
PEBs record for this event.",
>          "SampleAfterValue": "2000003",
> @@ -165,6 +166,7 @@
>      },
>      {
>          "BriefDescription": "Reference cycles when core is not halted  (=
Fixed event)",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "Counts the number of reference cycles that=
 the core is not in a halt state. The core enters the halt state when it is=
 running the HLT instruction.  In mobile systems the core frequency may cha=
nge from time.  This event is not affected by core frequency changes but co=
unts as if the core is running at the maximum frequency all the time.  This=
 event uses fixed counter 2.  You cannot collect a PEBs record for this eve=
nt.",
>          "SampleAfterValue": "2000003",
> @@ -187,6 +189,7 @@
>      },
>      {
>          "BriefDescription": "Instructions retired (Fixed event)",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "PEBS": "2",
>          "PublicDescription": "Counts the number of instructions that ret=
ire execution. For instructions that consist of multiple uops, this event c=
ounts the retirement of the last uop of the instruction. The counter contin=
ues counting during hardware interrupts, traps, and inside interrupt handle=
rs.  This event uses fixed counter 0.  You cannot collect a PEBs record for=
 this event.",
> diff --git a/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/grandridge/pipeline.json
> index 4121295..5335a7b 100644
> --- a/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/grandridge/pipeline.json
> @@ -29,6 +29,7 @@
>      },
>      {
>          "BriefDescription": "Fixed Counter: Counts the number of unhalte=
d reference clock cycles",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x3"
> @@ -43,6 +44,7 @@
>      },
>      {
>          "BriefDescription": "Fixed Counter: Counts the number of unhalte=
d core clock cycles",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x2"
> @@ -55,6 +57,7 @@
>      },
>      {
>          "BriefDescription": "Fixed Counter: Counts the number of instruc=
tions retired",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "PEBS": "1",
>          "SampleAfterValue": "2000003",
> diff --git a/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json b=
/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
> index 764c043..6ca34b9 100644
> --- a/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/graniterapids/pipeline.json
> @@ -17,6 +17,7 @@
>      },
>      {
>          "BriefDescription": "Reference cycles when the core is not in ha=
lt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "Counts the number of reference cycles when=
 the core is not in a halt state. The core enters the halt state when it is=
 running the HLT instruction or the MWAIT instruction. This event is not af=
fected by core frequency changes (for example, P states, TM2 transitions) b=
ut has the same incrementing frequency as the time stamp counter. This even=
t can approximate elapsed time while the core was not in a halt state. It i=
s counted on a dedicated fixed counter, leaving the eight programmable coun=
ters available for other events. Note: On all current platforms this event =
stops counting during 'throttling (TM)' states duty off periods the process=
or is 'halted'.  The counter update is done at a lower clock rate then the =
core clock the overflow status bit for this counter may appear 'sticky'.  A=
fter the counter has overflowed and software clears the overflow status bit=
 and resets the counter to less than MAX. The reset value to the counter is=
 not clocked immediately so the overflow status bit will flip 'high (1)' an=
d generate another PMI (if enabled) after which the reset value gets clocke=
d into the counter. Therefore, software will get the interrupt, read the ov=
erflow status bit '1 for bit 34 while the counter value is less than MAX. S=
oftware should ignore this case.",
>          "SampleAfterValue": "2000003",
> @@ -32,6 +33,7 @@
>      },
>      {
>          "BriefDescription": "Core cycles when the thread is not in halt =
state",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "PublicDescription": "Counts the number of core cycles while the=
 thread is not in a halt state. The thread enters the halt state when it is=
 running the HLT instruction. This event is a component in many key event r=
atios. The core frequency may change from time to time due to transitions a=
ssociated with Enhanced Intel SpeedStep Technology or TM2. For this reason =
this event may have a changing ratio with regards to time. When the core fr=
equency is constant, this event can approximate elapsed time while the core=
 was not in the halt state. It is counted on a dedicated fixed counter, lea=
ving the eight programmable counters available for other events.",
>          "SampleAfterValue": "2000003",
> @@ -46,6 +48,7 @@
>      },
>      {
>          "BriefDescription": "Number of instructions retired. Fixed Count=
er - architectural event",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "PEBS": "1",
>          "PublicDescription": "Counts the number of X86 instructions reti=
red - an Architectural PerfMon event. Counting continues during hardware in=
terrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is =
counted by a designated fixed counter freeing up programmable counters to c=
ount other events. INST_RETIRED.ANY_P is counted by a programmable counter.=
",
> @@ -78,6 +81,7 @@
>      },
>      {
>          "BriefDescription": "TMA slots available for an unhalted logical=
 processor. Fixed counter - architectural event",
> +        "EventCode": "0x0",
>          "EventName": "TOPDOWN.SLOTS",
>          "PublicDescription": "Number of available slots for an unhalted =
logical processor. The event increments by machine-width of the narrowest p=
ipeline as employed by the Top-down Microarchitecture Analysis method (TMA)=
. The count is distributed among unhalted logical processors (hyper-threads=
) who share the same physical core. Software can use this event as the deno=
minator for the top-level metrics of the TMA method. This architectural eve=
nt is counted on a designated fixed counter (Fixed Counter 3).",
>          "SampleAfterValue": "10000003",
> diff --git a/tools/perf/pmu-events/arch/x86/haswell/pipeline.json b/tools=
/perf/pmu-events/arch/x86/haswell/pipeline.json
> index 540f437..0d5eafd 100644
> --- a/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/haswell/pipeline.json
> @@ -303,6 +303,7 @@
>      },
>      {
>          "BriefDescription": "Reference cycles when the core is not in ha=
lt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "This event counts the number of reference =
cycles when the core is not in a halt state. The core enters the halt state=
 when it is running the HLT instruction or the MWAIT instruction. This even=
t is not affected by core frequency changes (for example, P states, TM2 tra=
nsitions) but has the same incrementing frequency as the time stamp counter=
. This event can approximate elapsed time while the core was not in a halt =
state.",
>          "SampleAfterValue": "2000003",
> @@ -327,6 +328,7 @@
>      },
>      {
>          "BriefDescription": "Core cycles when the thread is not in halt =
state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "PublicDescription": "This event counts the number of thread cyc=
les while the thread is not in a halt state. The thread enters the halt sta=
te when it is running the HLT instruction. The core frequency may change fr=
om time to time due to power or thermal throttling.",
>          "SampleAfterValue": "2000003",
> @@ -335,6 +337,7 @@
>      {
>          "AnyThread": "1",
>          "BriefDescription": "Core cycles when at least one thread on the=
 physical core is not in halt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x2"
> @@ -436,6 +439,7 @@
>      },
>      {
>          "BriefDescription": "Instructions retired from execution.",
> +        "EventCode": "0x0",
>          "Errata": "HSD140, HSD143",
>          "EventName": "INST_RETIRED.ANY",
>          "PublicDescription": "This event counts the number of instructio=
ns retired from execution. For instructions that consist of multiple micro-=
ops, this event counts the retirement of the last micro-op of the instructi=
on. Counting continues during hardware interrupts, traps, and inside interr=
upt handlers. INST_RETIRED.ANY is counted by a designated fixed counter, le=
aving the programmable counters available for other events. Faulting execut=
ions of GETSEC/VM entry/VM Exit/MWait will not count as retired instruction=
s.",
> diff --git a/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/haswellx/pipeline.json
> index 540f437..0d5eafd 100644
> --- a/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/haswellx/pipeline.json
> @@ -303,6 +303,7 @@
>      },
>      {
>          "BriefDescription": "Reference cycles when the core is not in ha=
lt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "This event counts the number of reference =
cycles when the core is not in a halt state. The core enters the halt state=
 when it is running the HLT instruction or the MWAIT instruction. This even=
t is not affected by core frequency changes (for example, P states, TM2 tra=
nsitions) but has the same incrementing frequency as the time stamp counter=
. This event can approximate elapsed time while the core was not in a halt =
state.",
>          "SampleAfterValue": "2000003",
> @@ -327,6 +328,7 @@
>      },
>      {
>          "BriefDescription": "Core cycles when the thread is not in halt =
state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "PublicDescription": "This event counts the number of thread cyc=
les while the thread is not in a halt state. The thread enters the halt sta=
te when it is running the HLT instruction. The core frequency may change fr=
om time to time due to power or thermal throttling.",
>          "SampleAfterValue": "2000003",
> @@ -335,6 +337,7 @@
>      {
>          "AnyThread": "1",
>          "BriefDescription": "Core cycles when at least one thread on the=
 physical core is not in halt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x2"
> @@ -436,6 +439,7 @@
>      },
>      {
>          "BriefDescription": "Instructions retired from execution.",
> +        "EventCode": "0x0",
>          "Errata": "HSD140, HSD143",
>          "EventName": "INST_RETIRED.ANY",
>          "PublicDescription": "This event counts the number of instructio=
ns retired from execution. For instructions that consist of multiple micro-=
ops, this event counts the retirement of the last micro-op of the instructi=
on. Counting continues during hardware interrupts, traps, and inside interr=
upt handlers. INST_RETIRED.ANY is counted by a designated fixed counter, le=
aving the programmable counters available for other events. Faulting execut=
ions of GETSEC/VM entry/VM Exit/MWait will not count as retired instruction=
s.",
> diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json b/=
tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
> index 9227cc2..64e2fb4 100644
> --- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
> +++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-cache.json
> @@ -183,6 +183,7 @@
>      },
>      {
>          "BriefDescription": "Uncore Clocks",
> +        "EventCode": "0x0",
>          "EventName": "UNC_C_CLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "CBOX"
> @@ -1698,6 +1699,7 @@
>      },
>      {
>          "BriefDescription": "uclks",
> +        "EventCode": "0x0",
>          "EventName": "UNC_H_CLOCKTICKS",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of uclks in the HA.  Thi=
s will be slightly different than the count in the Ubox because of enable/f=
reeze delays.  The HA is on the other side of the die from the fixed Ubox u=
clk counter, so the drift could be somewhat larger than in units that are c=
loser like the QPI Agent.",
> diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.=
json b/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
> index bef1f5e..57268d6 100644
> --- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
> +++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-interconnect.json
> @@ -1,6 +1,7 @@
>  [
>      {
>          "BriefDescription": "Number of non data (control) flits transmit=
ted . Derived from unc_q_txl_flits_g0.non_data",
> +        "EventCode": "0x0",
>          "EventName": "QPI_CTL_BANDWIDTH_TX",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  It includes filters for Idle, protocol, and Data Flits. =
 Each flit is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four fits, each of whic=
h contains 20 bits of data (along with some additional ECC data).   In half=
-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice =
as many fits to transmit a flit.  When one talks about QPI speed (for examp=
le, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the sys=
tem will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as data bandwidth.  For example, when we are transferring a =
64B cacheline across QPI, we will break it into 9 flits -- 1 with header in=
formation and 8 with 64 bits of actual data and an additional 16 bits of ot=
her information.  To calculate data bandwidth, one should therefore do: dat=
a flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NU=
LL non-data flits transmitted across QPI.  This basically tracks the protoc=
ol overhead on the QPI link.  One can get a good picture of the QPI-link ch=
aracteristics by evaluating the protocol flits, data flits, and idle/null f=
lits.  This includes the header flits for data packets.",
> @@ -10,6 +11,7 @@
>      },
>      {
>          "BriefDescription": "Number of data flits transmitted . Derived =
from unc_q_txl_flits_g0.data",
> +        "EventCode": "0x0",
>          "EventName": "QPI_DATA_BANDWIDTH_TX",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  It includes filters for Idle, protocol, and Data Flits. =
 Each flit is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four fits, each of whic=
h contains 20 bits of data (along with some additional ECC data).   In half=
-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice =
as many fits to transmit a flit.  When one talks about QPI speed (for examp=
le, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the sys=
tem will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as data bandwidth.  For example, when we are transferring a =
64B cacheline across QPI, we will break it into 9 flits -- 1 with header in=
formation and 8 with 64 bits of actual data and an additional 16 bits of ot=
her information.  To calculate data bandwidth, one should therefore do: dat=
a flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data f=
lits transmitted over QPI.  Each flit contains 64b of data.  This includes =
both DRS and NCB data flits (coherent and non-coherent).  This can be used =
to calculate the data bandwidth of the QPI link.  One can get a good pictur=
e of the QPI-link characteristics by evaluating the protocol flits, data fl=
its, and idle/null flits.  This does not include the header flits that go i=
n data packets.",
> @@ -37,6 +39,7 @@
>      },
>      {
>          "BriefDescription": "Clocks in the IRP",
> +        "EventCode": "0x0",
>          "EventName": "UNC_I_CLOCKTICKS",
>          "PerPkg": "1",
>          "PublicDescription": "Number of clocks in the IRP.",
> @@ -1401,6 +1404,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 0; Data Tx Flits"=
,
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G0.DATA",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  It includes filters for Idle, protocol, and Data Flits. =
 Each flit is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four fits, each of whic=
h contains 20 bits of data (along with some additional ECC data).   In half=
-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice =
as many fits to transmit a flit.  When one talks about QPI speed (for examp=
le, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the sys=
tem will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as data bandwidth.  For example, when we are transferring a =
64B cacheline across QPI, we will break it into 9 flits -- 1 with header in=
formation and 8 with 64 bits of actual data and an additional 16 bits of ot=
her information.  To calculate data bandwidth, one should therefore do: dat=
a flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data f=
lits transmitted over QPI.  Each flit contains 64b of data.  This includes =
both DRS and NCB data flits (coherent and non-coherent).  This can be used =
to calculate the data bandwidth of the QPI link.  One can get a good pictur=
e of the QPI-link characteristics by evaluating the protocol flits, data fl=
its, and idle/null flits.  This does not include the header flits that go i=
n data packets.",
> @@ -1409,6 +1413,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 0; Non-Data proto=
col Tx Flits",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G0.NON_DATA",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  It includes filters for Idle, protocol, and Data Flits. =
 Each flit is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four fits, each of whic=
h contains 20 bits of data (along with some additional ECC data).   In half=
-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice =
as many fits to transmit a flit.  When one talks about QPI speed (for examp=
le, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the sys=
tem will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as data bandwidth.  For example, when we are transferring a =
64B cacheline across QPI, we will break it into 9 flits -- 1 with header in=
formation and 8 with 64 bits of actual data and an additional 16 bits of ot=
her information.  To calculate data bandwidth, one should therefore do: dat=
a flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NU=
LL non-data flits transmitted across QPI.  This basically tracks the protoc=
ol overhead on the QPI link.  One can get a good picture of the QPI-link ch=
aracteristics by evaluating the protocol flits, data flits, and idle/null f=
lits.  This includes the header flits for data packets.",
> @@ -1417,6 +1422,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; DRS Flits (bot=
h Header and Data)",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.DRS",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three groups that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is=
 made up of 80 bits of information (in addition to some ECC data).  In full=
-width (L0) mode, flits are made up of four fits, each of which contains 20=
 bits of data (along with some additional ECC data).   In half-width (L0p) =
mode, the fits are only 10 bits, and therefore it takes twice as many fits =
to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s)=
, the transfers here refer to fits.  Therefore, in L0, the system will tran=
sfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the band=
width of the link by taking: flits*80b/time.  Note that this is not the sam=
e as data bandwidth.  For example, when we are transferring a 64B cacheline=
 across QPI, we will break it into 9 flits -- 1 with header information and=
 8 with 64 bits of actual data and an additional 16 bits of other informati=
on.  To calculate data bandwidth, one should therefore do: data flits * 8B =
/ time.; Counts the total number of flits transmitted over QPI on the DRS (=
Data Response) channel.  DRS flits are used to transmit data with coherency=
.",
> @@ -1425,6 +1431,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; DRS Data Flits=
",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.DRS_DATA",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three groups that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is=
 made up of 80 bits of information (in addition to some ECC data).  In full=
-width (L0) mode, flits are made up of four fits, each of which contains 20=
 bits of data (along with some additional ECC data).   In half-width (L0p) =
mode, the fits are only 10 bits, and therefore it takes twice as many fits =
to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s)=
, the transfers here refer to fits.  Therefore, in L0, the system will tran=
sfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the band=
width of the link by taking: flits*80b/time.  Note that this is not the sam=
e as data bandwidth.  For example, when we are transferring a 64B cacheline=
 across QPI, we will break it into 9 flits -- 1 with header information and=
 8 with 64 bits of actual data and an additional 16 bits of other informati=
on.  To calculate data bandwidth, one should therefore do: data flits * 8B =
/ time.; Counts the total number of data flits transmitted over QPI on the =
DRS (Data Response) channel.  DRS flits are used to transmit data with cohe=
rency.  This does not count data flits transmitted over the NCB channel whi=
ch transmits non-coherent data.  This includes only the data flits (not the=
 header).",
> @@ -1433,6 +1440,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; DRS Header Fli=
ts",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.DRS_NONDATA",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three groups that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is=
 made up of 80 bits of information (in addition to some ECC data).  In full=
-width (L0) mode, flits are made up of four fits, each of which contains 20=
 bits of data (along with some additional ECC data).   In half-width (L0p) =
mode, the fits are only 10 bits, and therefore it takes twice as many fits =
to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s)=
, the transfers here refer to fits.  Therefore, in L0, the system will tran=
sfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the band=
width of the link by taking: flits*80b/time.  Note that this is not the sam=
e as data bandwidth.  For example, when we are transferring a 64B cacheline=
 across QPI, we will break it into 9 flits -- 1 with header information and=
 8 with 64 bits of actual data and an additional 16 bits of other informati=
on.  To calculate data bandwidth, one should therefore do: data flits * 8B =
/ time.; Counts the total number of protocol flits transmitted over QPI on =
the DRS (Data Response) channel.  DRS flits are used to transmit data with =
coherency.  This does not count data flits transmitted over the NCB channel=
 which transmits non-coherent data.  This includes only the header flits (n=
ot the data).  This includes extended headers.",
> @@ -1441,6 +1449,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; HOM Flits",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.HOM",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three groups that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is=
 made up of 80 bits of information (in addition to some ECC data).  In full=
-width (L0) mode, flits are made up of four fits, each of which contains 20=
 bits of data (along with some additional ECC data).   In half-width (L0p) =
mode, the fits are only 10 bits, and therefore it takes twice as many fits =
to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s)=
, the transfers here refer to fits.  Therefore, in L0, the system will tran=
sfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the band=
width of the link by taking: flits*80b/time.  Note that this is not the sam=
e as data bandwidth.  For example, when we are transferring a 64B cacheline=
 across QPI, we will break it into 9 flits -- 1 with header information and=
 8 with 64 bits of actual data and an additional 16 bits of other informati=
on.  To calculate data bandwidth, one should therefore do: data flits * 8B =
/ time.; Counts the number of flits transmitted over QPI on the home channe=
l.",
> @@ -1449,6 +1458,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; HOM Non-Reques=
t Flits",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.HOM_NONREQ",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three groups that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is=
 made up of 80 bits of information (in addition to some ECC data).  In full=
-width (L0) mode, flits are made up of four fits, each of which contains 20=
 bits of data (along with some additional ECC data).   In half-width (L0p) =
mode, the fits are only 10 bits, and therefore it takes twice as many fits =
to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s)=
, the transfers here refer to fits.  Therefore, in L0, the system will tran=
sfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the band=
width of the link by taking: flits*80b/time.  Note that this is not the sam=
e as data bandwidth.  For example, when we are transferring a 64B cacheline=
 across QPI, we will break it into 9 flits -- 1 with header information and=
 8 with 64 bits of actual data and an additional 16 bits of other informati=
on.  To calculate data bandwidth, one should therefore do: data flits * 8B =
/ time.; Counts the number of non-request flits transmitted over QPI on the=
 home channel.  These are most commonly snoop responses, and this event can=
 be used as a proxy for that.",
> @@ -1457,6 +1467,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; HOM Request Fl=
its",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.HOM_REQ",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three groups that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is=
 made up of 80 bits of information (in addition to some ECC data).  In full=
-width (L0) mode, flits are made up of four fits, each of which contains 20=
 bits of data (along with some additional ECC data).   In half-width (L0p) =
mode, the fits are only 10 bits, and therefore it takes twice as many fits =
to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s)=
, the transfers here refer to fits.  Therefore, in L0, the system will tran=
sfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the band=
width of the link by taking: flits*80b/time.  Note that this is not the sam=
e as data bandwidth.  For example, when we are transferring a 64B cacheline=
 across QPI, we will break it into 9 flits -- 1 with header information and=
 8 with 64 bits of actual data and an additional 16 bits of other informati=
on.  To calculate data bandwidth, one should therefore do: data flits * 8B =
/ time.; Counts the number of data request transmitted over QPI on the home=
 channel.  This basically counts the number of remote memory requests trans=
mitted over QPI.  In conjunction with the local read count in the Home Agen=
t, one can calculate the number of LLC Misses.",
> @@ -1465,6 +1476,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; SNP Flits",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.SNP",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three groups that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is=
 made up of 80 bits of information (in addition to some ECC data).  In full=
-width (L0) mode, flits are made up of four fits, each of which contains 20=
 bits of data (along with some additional ECC data).   In half-width (L0p) =
mode, the fits are only 10 bits, and therefore it takes twice as many fits =
to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s)=
, the transfers here refer to fits.  Therefore, in L0, the system will tran=
sfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the band=
width of the link by taking: flits*80b/time.  Note that this is not the sam=
e as data bandwidth.  For example, when we are transferring a 64B cacheline=
 across QPI, we will break it into 9 flits -- 1 with header information and=
 8 with 64 bits of actual data and an additional 16 bits of other informati=
on.  To calculate data bandwidth, one should therefore do: data flits * 8B =
/ time.; Counts the number of snoop request flits transmitted over QPI.  Th=
ese requests are contained in the snoop channel.  This does not include sno=
op responses, which are transmitted on the home channel.",
> @@ -3136,6 +3148,7 @@
>      },
>      {
>          "BriefDescription": "Uncore Clocks",
> +        "EventCode": "0x0",
>          "EventName": "UNC_S_CLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "SBOX"
> @@ -3823,6 +3836,7 @@
>      },
>      {
>          "BriefDescription": "UNC_U_CLOCKTICKS",
> +        "EventCode": "0x0",
>          "EventName": "UNC_U_CLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "UBOX"
> diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-memory.json b=
/tools/perf/pmu-events/arch/x86/haswellx/uncore-memory.json
> index c005f51..124c3ae 100644
> --- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-memory.json
> @@ -151,12 +151,14 @@
>      },
>      {
>          "BriefDescription": "DRAM Clockticks",
> +        "EventCode": "0x0",
>          "EventName": "UNC_M_CLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "iMC"
>      },
>      {
>          "BriefDescription": "DRAM Clockticks",
> +        "EventCode": "0x0",
>          "EventName": "UNC_M_DCLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "iMC"
> diff --git a/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json b/=
tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
> index daebf10..9276058 100644
> --- a/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/haswellx/uncore-power.json
> @@ -1,6 +1,7 @@
>  [
>      {
>          "BriefDescription": "pclk Cycles",
> +        "EventCode": "0x0",
>          "EventName": "UNC_P_CLOCKTICKS",
>          "PerPkg": "1",
>          "PublicDescription": "The PCU runs off a fixed 800 MHz clock.  T=
his event counts the number of pclk cycles measured while the counter was e=
nabled.  The pclk, like the Memory Controller's dclk, counts at a constant =
rate making it a good measure of actual wall time.",
> diff --git a/tools/perf/pmu-events/arch/x86/icelake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/icelake/pipeline.json
> index 375b780..14e6d7c 100644
> --- a/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/icelake/pipeline.json
> @@ -193,6 +193,7 @@
>      },
>      {
>          "BriefDescription": "Reference cycles when the core is not in ha=
lt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "Counts the number of reference cycles when=
 the core is not in a halt state. The core enters the halt state when it is=
 running the HLT instruction or the MWAIT instruction. This event is not af=
fected by core frequency changes (for example, P states, TM2 transitions) b=
ut has the same incrementing frequency as the time stamp counter. This even=
t can approximate elapsed time while the core was not in a halt state. This=
 event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is=
 counted on a dedicated fixed counter, leaving the eight programmable count=
ers available for other events. Note: On all current platforms this event s=
tops counting during 'throttling (TM)' states duty off periods the processo=
r is 'halted'.  The counter update is done at a lower clock rate then the c=
ore clock the overflow status bit for this counter may appear 'sticky'.  Af=
ter the counter has overflowed and software clears the overflow status bit =
and resets the counter to less than MAX. The reset value to the counter is =
not clocked immediately so the overflow status bit will flip 'high (1)' and=
 generate another PMI (if enabled) after which the reset value gets clocked=
 into the counter. Therefore, software will get the interrupt, read the ove=
rflow status bit '1 for bit 34 while the counter value is less than MAX. So=
ftware should ignore this case.",
>          "SampleAfterValue": "2000003",
> @@ -208,6 +209,7 @@
>      },
>      {
>          "BriefDescription": "Core cycles when the thread is not in halt =
state",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "PublicDescription": "Counts the number of core cycles while the=
 thread is not in a halt state. The thread enters the halt state when it is=
 running the HLT instruction. This event is a component in many key event r=
atios. The core frequency may change from time to time due to transitions a=
ssociated with Enhanced Intel SpeedStep Technology or TM2. For this reason =
this event may have a changing ratio with regards to time. When the core fr=
equency is constant, this event can approximate elapsed time while the core=
 was not in the halt state. It is counted on a dedicated fixed counter, lea=
ving the eight programmable counters available for other events.",
>          "SampleAfterValue": "2000003",
> @@ -335,6 +337,7 @@
>      },
>      {
>          "BriefDescription": "Number of instructions retired. Fixed Count=
er - architectural event",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "PEBS": "1",
>          "PublicDescription": "Counts the number of instructions retired =
- an Architectural PerfMon event. Counting continues during hardware interr=
upts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is coun=
ted by a designated fixed counter freeing up programmable counters to count=
 other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
> @@ -359,6 +362,7 @@
>      },
>      {
>          "BriefDescription": "Precise instruction retired event with a re=
duced effect of PEBS shadow in IP distribution",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.PREC_DIST",
>          "PEBS": "1",
>          "PublicDescription": "A version of INST_RETIRED that allows for =
a more unbiased distribution of samples across instructions retired. It uti=
lizes the Precise Distribution of Instructions Retired (PDIR) feature to mi=
tigate some bias in how retired instructions get sampled. Use on Fixed Coun=
ter 0.",
> @@ -562,6 +566,7 @@
>      },
>      {
>          "BriefDescription": "TMA slots available for an unhalted logical=
 processor. Fixed counter - architectural event",
> +        "EventCode": "0x0",
>          "EventName": "TOPDOWN.SLOTS",
>          "PublicDescription": "Number of available slots for an unhalted =
logical processor. The event increments by machine-width of the narrowest p=
ipeline as employed by the Top-down Microarchitecture Analysis method (TMA)=
. The count is distributed among unhalted logical processors (hyper-threads=
) who share the same physical core. Software can use this event as the deno=
minator for the top-level metrics of the TMA method. This architectural eve=
nt is counted on a designated fixed counter (Fixed Counter 3).",
>          "SampleAfterValue": "10000003",
> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/icelakex/pipeline.json
> index 176e5ef..9303c70 100644
> --- a/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
> @@ -193,6 +193,7 @@
>      },
>      {
>          "BriefDescription": "Reference cycles when the core is not in ha=
lt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "Counts the number of reference cycles when=
 the core is not in a halt state. The core enters the halt state when it is=
 running the HLT instruction or the MWAIT instruction. This event is not af=
fected by core frequency changes (for example, P states, TM2 transitions) b=
ut has the same incrementing frequency as the time stamp counter. This even=
t can approximate elapsed time while the core was not in a halt state. This=
 event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is=
 counted on a dedicated fixed counter, leaving the eight programmable count=
ers available for other events. Note: On all current platforms this event s=
tops counting during 'throttling (TM)' states duty off periods the processo=
r is 'halted'.  The counter update is done at a lower clock rate then the c=
ore clock the overflow status bit for this counter may appear 'sticky'.  Af=
ter the counter has overflowed and software clears the overflow status bit =
and resets the counter to less than MAX. The reset value to the counter is =
not clocked immediately so the overflow status bit will flip 'high (1)' and=
 generate another PMI (if enabled) after which the reset value gets clocked=
 into the counter. Therefore, software will get the interrupt, read the ove=
rflow status bit '1 for bit 34 while the counter value is less than MAX. So=
ftware should ignore this case.",
>          "SampleAfterValue": "2000003",
> @@ -208,6 +209,7 @@
>      },
>      {
>          "BriefDescription": "Core cycles when the thread is not in halt =
state",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "PublicDescription": "Counts the number of core cycles while the=
 thread is not in a halt state. The thread enters the halt state when it is=
 running the HLT instruction. This event is a component in many key event r=
atios. The core frequency may change from time to time due to transitions a=
ssociated with Enhanced Intel SpeedStep Technology or TM2. For this reason =
this event may have a changing ratio with regards to time. When the core fr=
equency is constant, this event can approximate elapsed time while the core=
 was not in the halt state. It is counted on a dedicated fixed counter, lea=
ving the eight programmable counters available for other events.",
>          "SampleAfterValue": "2000003",
> @@ -335,6 +337,7 @@
>      },
>      {
>          "BriefDescription": "Number of instructions retired. Fixed Count=
er - architectural event",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "PEBS": "1",
>          "PublicDescription": "Counts the number of instructions retired =
- an Architectural PerfMon event. Counting continues during hardware interr=
upts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is coun=
ted by a designated fixed counter freeing up programmable counters to count=
 other events. INST_RETIRED.ANY_P is counted by a programmable counter.",
> @@ -359,6 +362,7 @@
>      },
>      {
>          "BriefDescription": "Precise instruction retired event with a re=
duced effect of PEBS shadow in IP distribution",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.PREC_DIST",
>          "PEBS": "1",
>          "PublicDescription": "A version of INST_RETIRED that allows for =
a more unbiased distribution of samples across instructions retired. It uti=
lizes the Precise Distribution of Instructions Retired (PDIR) feature to mi=
tigate some bias in how retired instructions get sampled. Use on Fixed Coun=
ter 0.",
> @@ -544,6 +548,7 @@
>      },
>      {
>          "BriefDescription": "TMA slots available for an unhalted logical=
 processor. Fixed counter - architectural event",
> +        "EventCode": "0x0",
>          "EventName": "TOPDOWN.SLOTS",
>          "PublicDescription": "Number of available slots for an unhalted =
logical processor. The event increments by machine-width of the narrowest p=
ipeline as employed by the Top-down Microarchitecture Analysis method (TMA)=
. The count is distributed among unhalted logical processors (hyper-threads=
) who share the same physical core. Software can use this event as the deno=
minator for the top-level metrics of the TMA method. This architectural eve=
nt is counted on a designated fixed counter (Fixed Counter 3).",
>          "SampleAfterValue": "10000003",
> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/uncore-cache.json b/=
tools/perf/pmu-events/arch/x86/icelakex/uncore-cache.json
> index b6ce14e..ae57663 100644
> --- a/tools/perf/pmu-events/arch/x86/icelakex/uncore-cache.json
> +++ b/tools/perf/pmu-events/arch/x86/icelakex/uncore-cache.json
> @@ -892,6 +892,7 @@
>      },
>      {
>          "BriefDescription": "Clockticks of the uncore caching and home a=
gent (CHA)",
> +        "EventCode": "0x0",
>          "EventName": "UNC_CHA_CLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "CHA"
> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/uncore-interconnect.=
json b/tools/perf/pmu-events/arch/x86/icelakex/uncore-interconnect.json
> index f87ea3f..0b88598 100644
> --- a/tools/perf/pmu-events/arch/x86/icelakex/uncore-interconnect.json
> +++ b/tools/perf/pmu-events/arch/x86/icelakex/uncore-interconnect.json
> @@ -1419,6 +1419,7 @@
>      },
>      {
>          "BriefDescription": "Clockticks of the mesh to memory (M2M)",
> +        "EventCode": "0x0",
>          "EventName": "UNC_M2M_CLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "M2M"
> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/uncore-memory.json b=
/tools/perf/pmu-events/arch/x86/icelakex/uncore-memory.json
> index 814d959..b0b2f27 100644
> --- a/tools/perf/pmu-events/arch/x86/icelakex/uncore-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/icelakex/uncore-memory.json
> @@ -100,6 +100,7 @@
>      },
>      {
>          "BriefDescription": "DRAM Clockticks",
> +        "EventCode": "0x0",
>          "EventName": "UNC_M_CLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "iMC"
> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json b/=
tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json
> index ee4dac6..9c4cd59 100644
> --- a/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json
> @@ -1,6 +1,7 @@
>  [
>      {
>          "BriefDescription": "Clockticks of the power control unit (PCU)"=
,
> +        "EventCode": "0x0",
>          "EventName": "UNC_P_CLOCKTICKS",
>          "PerPkg": "1",
>          "PublicDescription": "Clockticks of the power control unit (PCU)=
 : The PCU runs off a fixed 1 GHz clock.  This event counts the number of p=
clk cycles measured while the counter was enabled.  The pclk, like the Memo=
ry Controller's dclk, counts at a constant rate making it a good measure of=
 actual wall time.",
> diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/ivybridge/pipeline.json
> index 30a3da9..2df2d21 100644
> --- a/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/ivybridge/pipeline.json
> @@ -326,6 +326,7 @@
>      },
>      {
>          "BriefDescription": "Reference cycles when the core is not in ha=
lt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x3"
> @@ -348,6 +349,7 @@
>      },
>      {
>          "BriefDescription": "Core cycles when the thread is not in halt =
state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x2"
> @@ -355,6 +357,7 @@
>      {
>          "AnyThread": "1",
>          "BriefDescription": "Core cycles when at least one thread on the=
 physical core is not in halt state",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
>          "PublicDescription": "Core cycles when at least one thread on th=
e physical core is not in halt state.",
>          "SampleAfterValue": "2000003",
> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json b/tools=
/perf/pmu-events/arch/x86/ivytown/pipeline.json
> index 30a3da9..6f6f281 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/pipeline.json
> @@ -326,6 +326,7 @@
>      },
>      {
>          "BriefDescription": "Reference cycles when the core is not in ha=
lt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x3"
> @@ -348,6 +349,7 @@
>      },
>      {
>          "BriefDescription": "Core cycles when the thread is not in halt =
state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x2"
> @@ -355,6 +357,7 @@
>      {
>          "AnyThread": "1",
>          "BriefDescription": "Core cycles when at least one thread on the=
 physical core is not in halt state",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
>          "PublicDescription": "Core cycles when at least one thread on th=
e physical core is not in halt state.",
>          "SampleAfterValue": "2000003",
> @@ -510,6 +513,7 @@
>      },
>      {
>          "BriefDescription": "Instructions retired from execution.",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x1"
> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json b/t=
ools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
> index 8bf2706..31e58fb 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-cache.json
> @@ -1,6 +1,7 @@
>  [
>      {
>          "BriefDescription": "Uncore Clocks",
> +        "EventCode": "0x0",
>          "EventName": "UNC_C_CLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "CBOX"
> @@ -1533,6 +1534,7 @@
>      },
>      {
>          "BriefDescription": "uclks",
> +        "EventCode": "0x0",
>          "EventName": "UNC_H_CLOCKTICKS",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of uclks in the HA.  Thi=
s will be slightly different than the count in the Ubox because of enable/f=
reeze delays.  The HA is on the other side of the die from the fixed Ubox u=
clk counter, so the drift could be somewhat larger than in units that are c=
loser like the QPI Agent.",
> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.j=
son b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
> index 914d2cf..10e315c 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-interconnect.json
> @@ -109,6 +109,7 @@
>      },
>      {
>          "BriefDescription": "Clocks in the IRP",
> +        "EventCode": "0x0",
>          "EventName": "UNC_I_CLOCKTICKS",
>          "PerPkg": "1",
>          "PublicDescription": "Number of clocks in the IRP.",
> @@ -1522,6 +1523,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 0; Data Tx Flits"=
,
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G0.DATA",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  It includes filters for Idle, protocol, and Data Flits. =
 Each flit is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four fits, each of whic=
h contains 20 bits of data (along with some additional ECC data).   In half=
-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice =
as many fits to transmit a flit.  When one talks about QPI speed (for examp=
le, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the sys=
tem will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as data bandwidth.  For example, when we are transferring a =
64B cacheline across QPI, we will break it into 9 flits -- 1 with header in=
formation and 8 with 64 bits of actual data and an additional 16 bits of ot=
her information.  To calculate data bandwidth, one should therefore do: dat=
a flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of data f=
lits transmitted over QPI.  Each flit contains 64b of data.  This includes =
both DRS and NCB data flits (coherent and non-coherent).  This can be used =
to calculate the data bandwidth of the QPI link.  One can get a good pictur=
e of the QPI-link characteristics by evaluating the protocol flits, data fl=
its, and idle/null flits.  This does not include the header flits that go i=
n data packets.",
> @@ -1530,6 +1532,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 0; Non-Data proto=
col Tx Flits",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G0.NON_DATA",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  It includes filters for Idle, protocol, and Data Flits. =
 Each flit is made up of 80 bits of information (in addition to some ECC da=
ta).  In full-width (L0) mode, flits are made up of four fits, each of whic=
h contains 20 bits of data (along with some additional ECC data).   In half=
-width (L0p) mode, the fits are only 10 bits, and therefore it takes twice =
as many fits to transmit a flit.  When one talks about QPI speed (for examp=
le, 8.0 GT/s), the transfers here refer to fits.  Therefore, in L0, the sys=
tem will transfer 1 flit at the rate of 1/4th the QPI speed.  One can calcu=
late the bandwidth of the link by taking: flits*80b/time.  Note that this i=
s not the same as data bandwidth.  For example, when we are transferring a =
64B cacheline across QPI, we will break it into 9 flits -- 1 with header in=
formation and 8 with 64 bits of actual data and an additional 16 bits of ot=
her information.  To calculate data bandwidth, one should therefore do: dat=
a flits * 8B / time (for L0) or 4B instead of 8B for L0p.; Number of non-NU=
LL non-data flits transmitted across QPI.  This basically tracks the protoc=
ol overhead on the QPI link.  One can get a good picture of the QPI-link ch=
aracteristics by evaluating the protocol flits, data flits, and idle/null f=
lits.  This includes the header flits for data packets.",
> @@ -1538,6 +1541,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; DRS Flits (bot=
h Header and Data)",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.DRS",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three groups that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is=
 made up of 80 bits of information (in addition to some ECC data).  In full=
-width (L0) mode, flits are made up of four fits, each of which contains 20=
 bits of data (along with some additional ECC data).   In half-width (L0p) =
mode, the fits are only 10 bits, and therefore it takes twice as many fits =
to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s)=
, the transfers here refer to fits.  Therefore, in L0, the system will tran=
sfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the band=
width of the link by taking: flits*80b/time.  Note that this is not the sam=
e as data bandwidth.  For example, when we are transferring a 64B cacheline=
 across QPI, we will break it into 9 flits -- 1 with header information and=
 8 with 64 bits of actual data and an additional 16 bits of other informati=
on.  To calculate data bandwidth, one should therefore do: data flits * 8B =
/ time.; Counts the total number of flits transmitted over QPI on the DRS (=
Data Response) channel.  DRS flits are used to transmit data with coherency=
.",
> @@ -1546,6 +1550,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; DRS Data Flits=
",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.DRS_DATA",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three groups that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is=
 made up of 80 bits of information (in addition to some ECC data).  In full=
-width (L0) mode, flits are made up of four fits, each of which contains 20=
 bits of data (along with some additional ECC data).   In half-width (L0p) =
mode, the fits are only 10 bits, and therefore it takes twice as many fits =
to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s)=
, the transfers here refer to fits.  Therefore, in L0, the system will tran=
sfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the band=
width of the link by taking: flits*80b/time.  Note that this is not the sam=
e as data bandwidth.  For example, when we are transferring a 64B cacheline=
 across QPI, we will break it into 9 flits -- 1 with header information and=
 8 with 64 bits of actual data and an additional 16 bits of other informati=
on.  To calculate data bandwidth, one should therefore do: data flits * 8B =
/ time.; Counts the total number of data flits transmitted over QPI on the =
DRS (Data Response) channel.  DRS flits are used to transmit data with cohe=
rency.  This does not count data flits transmitted over the NCB channel whi=
ch transmits non-coherent data.  This includes only the data flits (not the=
 header).",
> @@ -1554,6 +1559,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; DRS Header Fli=
ts",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.DRS_NONDATA",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three groups that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is=
 made up of 80 bits of information (in addition to some ECC data).  In full=
-width (L0) mode, flits are made up of four fits, each of which contains 20=
 bits of data (along with some additional ECC data).   In half-width (L0p) =
mode, the fits are only 10 bits, and therefore it takes twice as many fits =
to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s)=
, the transfers here refer to fits.  Therefore, in L0, the system will tran=
sfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the band=
width of the link by taking: flits*80b/time.  Note that this is not the sam=
e as data bandwidth.  For example, when we are transferring a 64B cacheline=
 across QPI, we will break it into 9 flits -- 1 with header information and=
 8 with 64 bits of actual data and an additional 16 bits of other informati=
on.  To calculate data bandwidth, one should therefore do: data flits * 8B =
/ time.; Counts the total number of protocol flits transmitted over QPI on =
the DRS (Data Response) channel.  DRS flits are used to transmit data with =
coherency.  This does not count data flits transmitted over the NCB channel=
 which transmits non-coherent data.  This includes only the header flits (n=
ot the data).  This includes extended headers.",
> @@ -1562,6 +1568,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; HOM Flits",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.HOM",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three groups that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is=
 made up of 80 bits of information (in addition to some ECC data).  In full=
-width (L0) mode, flits are made up of four fits, each of which contains 20=
 bits of data (along with some additional ECC data).   In half-width (L0p) =
mode, the fits are only 10 bits, and therefore it takes twice as many fits =
to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s)=
, the transfers here refer to fits.  Therefore, in L0, the system will tran=
sfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the band=
width of the link by taking: flits*80b/time.  Note that this is not the sam=
e as data bandwidth.  For example, when we are transferring a 64B cacheline=
 across QPI, we will break it into 9 flits -- 1 with header information and=
 8 with 64 bits of actual data and an additional 16 bits of other informati=
on.  To calculate data bandwidth, one should therefore do: data flits * 8B =
/ time.; Counts the number of flits transmitted over QPI on the home channe=
l.",
> @@ -1570,6 +1577,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; HOM Non-Reques=
t Flits",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.HOM_NONREQ",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three groups that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is=
 made up of 80 bits of information (in addition to some ECC data).  In full=
-width (L0) mode, flits are made up of four fits, each of which contains 20=
 bits of data (along with some additional ECC data).   In half-width (L0p) =
mode, the fits are only 10 bits, and therefore it takes twice as many fits =
to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s)=
, the transfers here refer to fits.  Therefore, in L0, the system will tran=
sfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the band=
width of the link by taking: flits*80b/time.  Note that this is not the sam=
e as data bandwidth.  For example, when we are transferring a 64B cacheline=
 across QPI, we will break it into 9 flits -- 1 with header information and=
 8 with 64 bits of actual data and an additional 16 bits of other informati=
on.  To calculate data bandwidth, one should therefore do: data flits * 8B =
/ time.; Counts the number of non-request flits transmitted over QPI on the=
 home channel.  These are most commonly snoop responses, and this event can=
 be used as a proxy for that.",
> @@ -1578,6 +1586,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; HOM Request Fl=
its",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.HOM_REQ",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three groups that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is=
 made up of 80 bits of information (in addition to some ECC data).  In full=
-width (L0) mode, flits are made up of four fits, each of which contains 20=
 bits of data (along with some additional ECC data).   In half-width (L0p) =
mode, the fits are only 10 bits, and therefore it takes twice as many fits =
to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s)=
, the transfers here refer to fits.  Therefore, in L0, the system will tran=
sfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the band=
width of the link by taking: flits*80b/time.  Note that this is not the sam=
e as data bandwidth.  For example, when we are transferring a 64B cacheline=
 across QPI, we will break it into 9 flits -- 1 with header information and=
 8 with 64 bits of actual data and an additional 16 bits of other informati=
on.  To calculate data bandwidth, one should therefore do: data flits * 8B =
/ time.; Counts the number of data request transmitted over QPI on the home=
 channel.  This basically counts the number of remote memory requests trans=
mitted over QPI.  In conjunction with the local read count in the Home Agen=
t, one can calculate the number of LLC Misses.",
> @@ -1586,6 +1595,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; SNP Flits",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.SNP",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three groups that allow us to track flits=
.  It includes filters for SNP, HOM, and DRS message classes.  Each flit is=
 made up of 80 bits of information (in addition to some ECC data).  In full=
-width (L0) mode, flits are made up of four fits, each of which contains 20=
 bits of data (along with some additional ECC data).   In half-width (L0p) =
mode, the fits are only 10 bits, and therefore it takes twice as many fits =
to transmit a flit.  When one talks about QPI speed (for example, 8.0 GT/s)=
, the transfers here refer to fits.  Therefore, in L0, the system will tran=
sfer 1 flit at the rate of 1/4th the QPI speed.  One can calculate the band=
width of the link by taking: flits*80b/time.  Note that this is not the sam=
e as data bandwidth.  For example, when we are transferring a 64B cacheline=
 across QPI, we will break it into 9 flits -- 1 with header information and=
 8 with 64 bits of actual data and an additional 16 bits of other informati=
on.  To calculate data bandwidth, one should therefore do: data flits * 8B =
/ time.; Counts the number of snoop request flits transmitted over QPI.  Th=
ese requests are contained in the snoop channel.  This does not include sno=
op responses, which are transmitted on the home channel.",
> @@ -3104,6 +3114,7 @@
>      },
>      {
>          "EventName": "UNC_U_CLOCKTICKS",
> +        "EventCode": "0x0",
>          "PerPkg": "1",
>          "Unit": "UBOX"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json b/=
tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
> index 6550934..869a320 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-memory.json
> @@ -131,6 +131,7 @@
>      },
>      {
>          "BriefDescription": "DRAM Clockticks",
> +        "EventCode": "0x0",
>          "EventName": "UNC_M_DCLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "iMC"
> diff --git a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json b/t=
ools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
> index 5df1ebf..0a5d0c3 100644
> --- a/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/ivytown/uncore-power.json
> @@ -1,6 +1,7 @@
>  [
>      {
>          "BriefDescription": "pclk Cycles",
> +        "EventCode": "0x0",
>          "EventName": "UNC_P_CLOCKTICKS",
>          "PerPkg": "1",
>          "PublicDescription": "The PCU runs off a fixed 800 MHz clock.  T=
his event counts the number of pclk cycles measured while the counter was e=
nabled.  The pclk, like the Memory Controller's dclk, counts at a constant =
rate making it a good measure of actual wall time.",
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/jaketown/pipeline.json
> index d0edfde..76b515d 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/pipeline.json
> @@ -329,6 +329,7 @@
>      },
>      {
>          "BriefDescription": "Reference cycles when the core is not in ha=
lt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "This event counts the number of reference =
cycles when the core is not in a halt state. The core enters the halt state=
 when it is running the HLT instruction or the MWAIT instruction. This even=
t is not affected by core frequency changes (for example, P states, TM2 tra=
nsitions) but has the same incrementing frequency as the time stamp counter=
. This event can approximate elapsed time while the core was not in a halt =
state. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK e=
vent. It is counted on a dedicated fixed counter, leaving the four (eight w=
hen Hyperthreading is disabled) programmable counters available for other e=
vents.",
>          "SampleAfterValue": "2000003",
> @@ -351,6 +352,7 @@
>      },
>      {
>          "BriefDescription": "Core cycles when the thread is not in halt =
state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "PublicDescription": "This event counts the number of core cycle=
s while the thread is not in a halt state. The thread enters the halt state=
 when it is running the HLT instruction. This event is a component in many =
key event ratios. The core frequency may change from time to time due to tr=
ansitions associated with Enhanced Intel SpeedStep Technology or TM2. For t=
his reason this event may have a changing ratio with regards to time. When =
the core frequency is constant, this event can approximate elapsed time whi=
le the core was not in the halt state. It is counted on a dedicated fixed c=
ounter, leaving the four (eight when Hyperthreading is disabled) programmab=
le counters available for other events.",
>          "SampleAfterValue": "2000003",
> @@ -359,6 +361,7 @@
>      {
>          "AnyThread": "1",
>          "BriefDescription": "Core cycles when at least one thread on the=
 physical core is not in halt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x2"
> @@ -432,6 +435,7 @@
>      },
>      {
>          "BriefDescription": "Instructions retired from execution.",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "PublicDescription": "This event counts the number of instructio=
ns retired from execution. For instructions that consist of multiple micro-=
ops, this event counts the retirement of the last micro-op of the instructi=
on. Counting continues during hardware interrupts, traps, and inside interr=
upt handlers.",
>          "SampleAfterValue": "2000003",
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json b/=
tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
> index 63395e7e..160f1c4 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-cache.json
> @@ -1,6 +1,7 @@
>  [
>      {
>          "BriefDescription": "Uncore Clocks",
> +        "EventCode": "0x0",
>          "EventName": "UNC_C_CLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "CBOX"
> @@ -863,6 +864,7 @@
>      },
>      {
>          "BriefDescription": "uclks",
> +        "EventCode": "0x0",
>          "EventName": "UNC_H_CLOCKTICKS",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of uclks in the HA.  Thi=
s will be slightly different than the count in the Ubox because of enable/f=
reeze delays.  The HA is on the other side of the die from the fixed Ubox u=
clk counter, so the drift could be somewhat larger than in units that are c=
loser like the QPI Agent.",
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.=
json b/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
> index 0fc907e..addab93 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-interconnect.json
> @@ -109,6 +109,7 @@
>      },
>      {
>          "BriefDescription": "Clocks in the IRP",
> +        "EventCode": "0x0",
>          "EventName": "UNC_I_CLOCKTICKS",
>          "PerPkg": "1",
>          "PublicDescription": "Number of clocks in the IRP.",
> @@ -847,6 +848,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 0; Data Tx Flits"=
,
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G0.DATA",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  It includes filters for Idle, protocol, and Data Flits. =
 Each 'flit' is made up of 80 bits of information (in addition to some ECC =
data).  In full-width (L0) mode, flits are made up of four 'fits', each of =
which contains 20 bits of data (along with some additional ECC data).   In =
half-width (L0p) mode, the fits are only 10 bits, and therefore it takes tw=
ice as many fits to transmit a flit.  When one talks about QPI 'speed' (for=
 example, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L=
0, the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  O=
ne can calculate the bandwidth of the link by taking: flits*80b/time.  Note=
 that this is not the same as 'data' bandwidth.  For example, when we are t=
ransferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 =
with header information and 8 with 64 bits of actual 'data' and an addition=
al 16 bits of other information.  To calculate 'data' bandwidth, one should=
 therefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.=
",
> @@ -855,6 +857,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 0; Idle and Null =
Flits",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G0.IDLE",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  It includes filters for Idle, protocol, and Data Flits. =
 Each 'flit' is made up of 80 bits of information (in addition to some ECC =
data).  In full-width (L0) mode, flits are made up of four 'fits', each of =
which contains 20 bits of data (along with some additional ECC data).   In =
half-width (L0p) mode, the fits are only 10 bits, and therefore it takes tw=
ice as many fits to transmit a flit.  When one talks about QPI 'speed' (for=
 example, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L=
0, the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  O=
ne can calculate the bandwidth of the link by taking: flits*80b/time.  Note=
 that this is not the same as 'data' bandwidth.  For example, when we are t=
ransferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 =
with header information and 8 with 64 bits of actual 'data' and an addition=
al 16 bits of other information.  To calculate 'data' bandwidth, one should=
 therefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.=
",
> @@ -863,6 +866,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 0; Non-Data proto=
col Tx Flits",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G0.NON_DATA",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  It includes filters for Idle, protocol, and Data Flits. =
 Each 'flit' is made up of 80 bits of information (in addition to some ECC =
data).  In full-width (L0) mode, flits are made up of four 'fits', each of =
which contains 20 bits of data (along with some additional ECC data).   In =
half-width (L0p) mode, the fits are only 10 bits, and therefore it takes tw=
ice as many fits to transmit a flit.  When one talks about QPI 'speed' (for=
 example, 8.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L=
0, the system will transfer 1 'flit' at the rate of 1/4th the QPI speed.  O=
ne can calculate the bandwidth of the link by taking: flits*80b/time.  Note=
 that this is not the same as 'data' bandwidth.  For example, when we are t=
ransferring a 64B cacheline across QPI, we will break it into 9 flits -- 1 =
with header information and 8 with 64 bits of actual 'data' and an addition=
al 16 bits of other information.  To calculate 'data' bandwidth, one should=
 therefore do: data flits * 8B / time (for L0) or 4B instead of 8B for L0p.=
",
> @@ -871,6 +875,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; DRS Flits (bot=
h Header and Data)",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.DRS",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three 'groups' that allow us to track fli=
ts.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit=
' is made up of 80 bits of information (in addition to some ECC data).  In =
full-width (L0) mode, flits are made up of four 'fits', each of which conta=
ins 20 bits of data (along with some additional ECC data).   In half-width =
(L0p) mode, the fits are only 10 bits, and therefore it takes twice as many=
 fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8=
.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syst=
em will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calc=
ulate the bandwidth of the link by taking: flits*80b/time.  Note that this =
is not the same as 'data' bandwidth.  For example, when we are transferring=
 a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header=
 information and 8 with 64 bits of actual 'data' and an additional 16 bits =
of other information.  To calculate 'data' bandwidth, one should therefore =
do: data flits * 8B / time.",
> @@ -879,6 +884,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; DRS Data Flits=
",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.DRS_DATA",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three 'groups' that allow us to track fli=
ts.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit=
' is made up of 80 bits of information (in addition to some ECC data).  In =
full-width (L0) mode, flits are made up of four 'fits', each of which conta=
ins 20 bits of data (along with some additional ECC data).   In half-width =
(L0p) mode, the fits are only 10 bits, and therefore it takes twice as many=
 fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8=
.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syst=
em will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calc=
ulate the bandwidth of the link by taking: flits*80b/time.  Note that this =
is not the same as 'data' bandwidth.  For example, when we are transferring=
 a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header=
 information and 8 with 64 bits of actual 'data' and an additional 16 bits =
of other information.  To calculate 'data' bandwidth, one should therefore =
do: data flits * 8B / time.",
> @@ -887,6 +893,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; DRS Header Fli=
ts",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.DRS_NONDATA",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three 'groups' that allow us to track fli=
ts.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit=
' is made up of 80 bits of information (in addition to some ECC data).  In =
full-width (L0) mode, flits are made up of four 'fits', each of which conta=
ins 20 bits of data (along with some additional ECC data).   In half-width =
(L0p) mode, the fits are only 10 bits, and therefore it takes twice as many=
 fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8=
.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syst=
em will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calc=
ulate the bandwidth of the link by taking: flits*80b/time.  Note that this =
is not the same as 'data' bandwidth.  For example, when we are transferring=
 a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header=
 information and 8 with 64 bits of actual 'data' and an additional 16 bits =
of other information.  To calculate 'data' bandwidth, one should therefore =
do: data flits * 8B / time.",
> @@ -895,6 +902,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; HOM Flits",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.HOM",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three 'groups' that allow us to track fli=
ts.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit=
' is made up of 80 bits of information (in addition to some ECC data).  In =
full-width (L0) mode, flits are made up of four 'fits', each of which conta=
ins 20 bits of data (along with some additional ECC data).   In half-width =
(L0p) mode, the fits are only 10 bits, and therefore it takes twice as many=
 fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8=
.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syst=
em will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calc=
ulate the bandwidth of the link by taking: flits*80b/time.  Note that this =
is not the same as 'data' bandwidth.  For example, when we are transferring=
 a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header=
 information and 8 with 64 bits of actual 'data' and an additional 16 bits =
of other information.  To calculate 'data' bandwidth, one should therefore =
do: data flits * 8B / time.",
> @@ -903,6 +911,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; HOM Non-Reques=
t Flits",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.HOM_NONREQ",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three 'groups' that allow us to track fli=
ts.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit=
' is made up of 80 bits of information (in addition to some ECC data).  In =
full-width (L0) mode, flits are made up of four 'fits', each of which conta=
ins 20 bits of data (along with some additional ECC data).   In half-width =
(L0p) mode, the fits are only 10 bits, and therefore it takes twice as many=
 fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8=
.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syst=
em will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calc=
ulate the bandwidth of the link by taking: flits*80b/time.  Note that this =
is not the same as 'data' bandwidth.  For example, when we are transferring=
 a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header=
 information and 8 with 64 bits of actual 'data' and an additional 16 bits =
of other information.  To calculate 'data' bandwidth, one should therefore =
do: data flits * 8B / time.",
> @@ -911,6 +920,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; HOM Request Fl=
its",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.HOM_REQ",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three 'groups' that allow us to track fli=
ts.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit=
' is made up of 80 bits of information (in addition to some ECC data).  In =
full-width (L0) mode, flits are made up of four 'fits', each of which conta=
ins 20 bits of data (along with some additional ECC data).   In half-width =
(L0p) mode, the fits are only 10 bits, and therefore it takes twice as many=
 fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8=
.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syst=
em will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calc=
ulate the bandwidth of the link by taking: flits*80b/time.  Note that this =
is not the same as 'data' bandwidth.  For example, when we are transferring=
 a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header=
 information and 8 with 64 bits of actual 'data' and an additional 16 bits =
of other information.  To calculate 'data' bandwidth, one should therefore =
do: data flits * 8B / time.",
> @@ -919,6 +929,7 @@
>      },
>      {
>          "BriefDescription": "Flits Transferred - Group 1; SNP Flits",
> +        "EventCode": "0x0",
>          "EventName": "UNC_Q_TxL_FLITS_G1.SNP",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of flits transmitted acr=
oss the QPI Link.  This is one of three 'groups' that allow us to track fli=
ts.  It includes filters for SNP, HOM, and DRS message classes.  Each 'flit=
' is made up of 80 bits of information (in addition to some ECC data).  In =
full-width (L0) mode, flits are made up of four 'fits', each of which conta=
ins 20 bits of data (along with some additional ECC data).   In half-width =
(L0p) mode, the fits are only 10 bits, and therefore it takes twice as many=
 fits to transmit a flit.  When one talks about QPI 'speed' (for example, 8=
.0 GT/s), the 'transfers' here refer to 'fits'.  Therefore, in L0, the syst=
em will transfer 1 'flit' at the rate of 1/4th the QPI speed.  One can calc=
ulate the bandwidth of the link by taking: flits*80b/time.  Note that this =
is not the same as 'data' bandwidth.  For example, when we are transferring=
 a 64B cacheline across QPI, we will break it into 9 flits -- 1 with header=
 information and 8 with 64 bits of actual 'data' and an additional 16 bits =
of other information.  To calculate 'data' bandwidth, one should therefore =
do: data flits * 8B / time.",
> @@ -1576,6 +1587,7 @@
>      },
>      {
>          "EventName": "UNC_U_CLOCKTICKS",
> +        "EventCode": "0x0",
>          "PerPkg": "1",
>          "Unit": "UBOX"
>      },
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json b=
/tools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json
> index 6dcc9415..2385b0a 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-memory.json
> @@ -65,6 +65,7 @@
>      },
>      {
>          "BriefDescription": "uclks",
> +        "EventCode": "0x0",
>          "EventName": "UNC_M_CLOCKTICKS",
>          "PerPkg": "1",
>          "PublicDescription": "Uncore Fixed Counter - uclks",
> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json b/=
tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
> index b3ee5d7..f453afd 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/uncore-power.json
> @@ -1,6 +1,7 @@
>  [
>      {
>          "BriefDescription": "pclk Cycles",
> +        "EventCode": "0x0",
>          "EventName": "UNC_P_CLOCKTICKS",
>          "PerPkg": "1",
>          "PublicDescription": "The PCU runs off a fixed 800 MHz clock.  T=
his event counts the number of pclk cycles measured while the counter was e=
nabled.  The pclk, like the Memory Controller's dclk, counts at a constant =
rate making it a good measure of actual wall time.",
> @@ -216,6 +217,7 @@
>      },
>      {
>          "BriefDescription": "Cycles spent changing Frequency",
> +        "EventCode": "0x0",
>          "EventName": "UNC_P_FREQ_TRANS_CYCLES",
>          "PerPkg": "1",
>          "PublicDescription": "Counts the number of cycles when the syste=
m is changing frequency.  This can not be filtered by thread ID.  One can a=
lso use it with the occupancy counter that monitors number of threads in C0=
 to estimate the performance impact that frequency transitions had on the s=
ystem.",
> diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json =
b/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
> index 3dc5321..a74d45a 100644
> --- a/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/knightslanding/pipeline.json
> @@ -150,12 +150,14 @@
>      },
>      {
>          "BriefDescription": "Fixed Counter: Counts the number of unhalte=
d reference clock cycles",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x3"
>      },
>      {
>          "BriefDescription": "Fixed Counter: Counts the number of unhalte=
d core clock cycles",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "PublicDescription": "This event counts the number of core cycle=
s while the thread is not in a halt state. The thread enters the halt state=
 when it is running the HLT instruction. This event is a component in many =
key event ratios. The core frequency may change from time to time due to tr=
ansitions associated with Enhanced Intel SpeedStep Technology or TM2. For t=
his reason this event may have a changing ratio with regards to time. When =
the core frequency is constant, this event can approximate elapsed time whi=
le the core was not in the halt state. It is counted on a dedicated fixed c=
ounter",
>          "SampleAfterValue": "2000003",
> @@ -177,6 +179,7 @@
>      },
>      {
>          "BriefDescription": "Fixed Counter: Counts the number of instruc=
tions retired",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "PublicDescription": "This event counts the number of instructio=
ns that retire.  For instructions that consist of multiple micro-ops, this =
event counts exactly once, as the last micro-op of the instruction retires.=
  The event continues counting while instructions retire, including during =
interrupt service routines caused by hardware interrupts, faults or traps."=
,
>          "SampleAfterValue": "2000003",
> diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-cache.j=
son b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-cache.json
> index 1b8dcfa..c062253 100644
> --- a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-cache.json
> +++ b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-cache.json
> @@ -3246,6 +3246,7 @@
>      },
>      {
>          "BriefDescription": "Uncore Clocks",
> +        "EventCode": "0x0",
>          "EventName": "UNC_H_U_CLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "CHA"
> diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.=
json b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json
> index fb75297..3575baa 100644
> --- a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-memory.json
> @@ -41,6 +41,7 @@
>      },
>      {
>          "BriefDescription": "ECLK count",
> +        "EventCode": "0x0",
>          "EventName": "UNC_E_E_CLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "EDC_ECLK"
> @@ -55,6 +56,7 @@
>      },
>      {
>          "BriefDescription": "UCLK count",
> +        "EventCode": "0x0",
>          "EventName": "UNC_E_U_CLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "EDC_UCLK"
> @@ -93,12 +95,14 @@
>      },
>      {
>          "BriefDescription": "DCLK count",
> +        "EventCode": "0x0",
>          "EventName": "UNC_M_D_CLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "iMC_DCLK"
>      },
>      {
>          "BriefDescription": "UCLK count",
> +        "EventCode": "0x0",
>          "EventName": "UNC_M_U_CLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "iMC_UCLK"
> diff --git a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/meteorlake/pipeline.json
> index 352c5ef..27f2c81 100644
> --- a/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/meteorlake/pipeline.json
> @@ -368,6 +368,7 @@
>      },
>      {
>          "BriefDescription": "Fixed Counter: Counts the number of unhalte=
d core clock cycles",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.CORE",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x2",
> @@ -427,6 +428,7 @@
>      },
>      {
>          "BriefDescription": "Fixed Counter: Counts the number of unhalte=
d reference clock cycles",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x3",
> @@ -434,6 +436,7 @@
>      },
>      {
>          "BriefDescription": "Reference cycles when the core is not in ha=
lt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "Counts the number of reference cycles when=
 the core is not in a halt state. The core enters the halt state when it is=
 running the HLT instruction or the MWAIT instruction. This event is not af=
fected by core frequency changes (for example, P states, TM2 transitions) b=
ut has the same incrementing frequency as the time stamp counter. This even=
t can approximate elapsed time while the core was not in a halt state. It i=
s counted on a dedicated fixed counter, leaving the eight programmable coun=
ters available for other events. Note: On all current platforms this event =
stops counting during 'throttling (TM)' states duty off periods the process=
or is 'halted'.  The counter update is done at a lower clock rate then the =
core clock the overflow status bit for this counter may appear 'sticky'.  A=
fter the counter has overflowed and software clears the overflow status bit=
 and resets the counter to less than MAX. The reset value to the counter is=
 not clocked immediately so the overflow status bit will flip 'high (1)' an=
d generate another PMI (if enabled) after which the reset value gets clocke=
d into the counter. Therefore, software will get the interrupt, read the ov=
erflow status bit '1 for bit 34 while the counter value is less than MAX. S=
oftware should ignore this case.",
>          "SampleAfterValue": "2000003",
> @@ -460,6 +463,7 @@
>      },
>      {
>          "BriefDescription": "Fixed Counter: Counts the number of unhalte=
d core clock cycles",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x2",
> @@ -467,6 +471,7 @@
>      },
>      {
>          "BriefDescription": "Core cycles when the thread is not in halt =
state",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "PublicDescription": "Counts the number of core cycles while the=
 thread is not in a halt state. The thread enters the halt state when it is=
 running the HLT instruction. This event is a component in many key event r=
atios. The core frequency may change from time to time due to transitions a=
ssociated with Enhanced Intel SpeedStep Technology or TM2. For this reason =
this event may have a changing ratio with regards to time. When the core fr=
equency is constant, this event can approximate elapsed time while the core=
 was not in the halt state. It is counted on a dedicated fixed counter, lea=
ving the eight programmable counters available for other events.",
>          "SampleAfterValue": "2000003",
> @@ -617,6 +622,7 @@
>      },
>      {
>          "BriefDescription": "Fixed Counter: Counts the number of instruc=
tions retired",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "PEBS": "1",
>          "SampleAfterValue": "2000003",
> @@ -625,6 +631,7 @@
>      },
>      {
>          "BriefDescription": "Number of instructions retired. Fixed Count=
er - architectural event",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "PEBS": "1",
>          "PublicDescription": "Counts the number of X86 instructions reti=
red - an Architectural PerfMon event. Counting continues during hardware in=
terrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is =
counted by a designated fixed counter freeing up programmable counters to c=
ount other events. INST_RETIRED.ANY_P is counted by a programmable counter.=
",
> @@ -668,6 +675,7 @@
>      },
>      {
>          "BriefDescription": "Precise instruction retired with PEBS preci=
se-distribution",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.PREC_DIST",
>          "PEBS": "1",
>          "PublicDescription": "A version of INST_RETIRED that allows for =
a precise distribution of samples across instructions retired. It utilizes =
the Precise Distribution of Instructions Retired (PDIR++) feature to fix bi=
as in how retired instructions get sampled. Use on Fixed Counter 0.",
> @@ -1006,6 +1014,7 @@
>      },
>      {
>          "BriefDescription": "TMA slots available for an unhalted logical=
 processor. Fixed counter - architectural event",
> +        "EventCode": "0x0",
>          "EventName": "TOPDOWN.SLOTS",
>          "PublicDescription": "Number of available slots for an unhalted =
logical processor. The event increments by machine-width of the narrowest p=
ipeline as employed by the Top-down Microarchitecture Analysis method (TMA)=
. The count is distributed among unhalted logical processors (hyper-threads=
) who share the same physical core. Software can use this event as the deno=
minator for the top-level metrics of the TMA method. This architectural eve=
nt is counted on a designated fixed counter (Fixed Counter 3).",
>          "SampleAfterValue": "10000003",
> diff --git a/tools/perf/pmu-events/arch/x86/rocketlake/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/rocketlake/pipeline.json
> index 375b780..22085f4 100644
> --- a/tools/perf/pmu-events/arch/x86/rocketlake/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/rocketlake/pipeline.json
> @@ -193,6 +193,7 @@
>      },
>      {
>          "BriefDescription": "Reference cycles when the core is not in ha=
lt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "Counts the number of reference cycles when=
 the core is not in a halt state. The core enters the halt state when it is=
 running the HLT instruction or the MWAIT instruction. This event is not af=
fected by core frequency changes (for example, P states, TM2 transitions) b=
ut has the same incrementing frequency as the time stamp counter. This even=
t can approximate elapsed time while the core was not in a halt state. This=
 event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is=
 counted on a dedicated fixed counter, leaving the eight programmable count=
ers available for other events. Note: On all current platforms this event s=
tops counting during 'throttling (TM)' states duty off periods the processo=
r is 'halted'.  The counter update is done at a lower clock rate then the c=
ore clock the overflow status bit for this counter may appear 'sticky'.  Af=
ter the counter has overflowed and software clears the overflow status bit =
and resets the counter to less than MAX. The reset value to the counter is =
not clocked immediately so the overflow status bit will flip 'high (1)' and=
 generate another PMI (if enabled) after which the reset value gets clocked=
 into the counter. Therefore, software will get the interrupt, read the ove=
rflow status bit '1 for bit 34 while the counter value is less than MAX. So=
ftware should ignore this case.",
>          "SampleAfterValue": "2000003",
> @@ -359,6 +360,7 @@
>      },
>      {
>          "BriefDescription": "Precise instruction retired event with a re=
duced effect of PEBS shadow in IP distribution",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.PREC_DIST",
>          "PEBS": "1",
>          "PublicDescription": "A version of INST_RETIRED that allows for =
a more unbiased distribution of samples across instructions retired. It uti=
lizes the Precise Distribution of Instructions Retired (PDIR) feature to mi=
tigate some bias in how retired instructions get sampled. Use on Fixed Coun=
ter 0.",
> @@ -562,6 +564,7 @@
>      },
>      {
>          "BriefDescription": "TMA slots available for an unhalted logical=
 processor. Fixed counter - architectural event",
> +        "EventCode": "0x0",
>          "EventName": "TOPDOWN.SLOTS",
>          "PublicDescription": "Number of available slots for an unhalted =
logical processor. The event increments by machine-width of the narrowest p=
ipeline as employed by the Top-down Microarchitecture Analysis method (TMA)=
. The count is distributed among unhalted logical processors (hyper-threads=
) who share the same physical core. Software can use this event as the deno=
minator for the top-level metrics of the TMA method. This architectural eve=
nt is counted on a designated fixed counter (Fixed Counter 3).",
>          "SampleAfterValue": "10000003",
> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json b/t=
ools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
> index ecaf94c..973a5f4 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/pipeline.json
> @@ -337,6 +337,7 @@
>      },
>      {
>          "BriefDescription": "Reference cycles when the core is not in ha=
lt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "This event counts the number of reference =
cycles when the core is not in a halt state. The core enters the halt state=
 when it is running the HLT instruction or the MWAIT instruction. This even=
t is not affected by core frequency changes (for example, P states, TM2 tra=
nsitions) but has the same incrementing frequency as the time stamp counter=
. This event can approximate elapsed time while the core was not in a halt =
state. This event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK e=
vent. It is counted on a dedicated fixed counter, leaving the four (eight w=
hen Hyperthreading is disabled) programmable counters available for other e=
vents.",
>          "SampleAfterValue": "2000003",
> @@ -359,6 +360,7 @@
>      },
>      {
>          "BriefDescription": "Core cycles when the thread is not in halt =
state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "PublicDescription": "This event counts the number of core cycle=
s while the thread is not in a halt state. The thread enters the halt state=
 when it is running the HLT instruction. This event is a component in many =
key event ratios. The core frequency may change from time to time due to tr=
ansitions associated with Enhanced Intel SpeedStep Technology or TM2. For t=
his reason this event may have a changing ratio with regards to time. When =
the core frequency is constant, this event can approximate elapsed time whi=
le the core was not in the halt state. It is counted on a dedicated fixed c=
ounter, leaving the four (eight when Hyperthreading is disabled) programmab=
le counters available for other events.",
>          "SampleAfterValue": "2000003",
> @@ -367,6 +369,7 @@
>      {
>          "AnyThread": "1",
>          "BriefDescription": "Core cycles when at least one thread on the=
 physical core is not in halt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x2"
> @@ -440,6 +443,7 @@
>      },
>      {
>          "BriefDescription": "Instructions retired from execution.",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "PublicDescription": "This event counts the number of instructio=
ns retired from execution. For instructions that consist of multiple micro-=
ops, this event counts the retirement of the last micro-op of the instructi=
on. Counting continues during hardware interrupts, traps, and inside interr=
upt handlers.",
>          "SampleAfterValue": "2000003",
> diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json =
b/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
> index 6dcf3b7..cfbc0d2 100644
> --- a/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/pipeline.json
> @@ -284,6 +284,7 @@
>      },
>      {
>          "BriefDescription": "Reference cycles when the core is not in ha=
lt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "Counts the number of reference cycles when=
 the core is not in a halt state. The core enters the halt state when it is=
 running the HLT instruction or the MWAIT instruction. This event is not af=
fected by core frequency changes (for example, P states, TM2 transitions) b=
ut has the same incrementing frequency as the time stamp counter. This even=
t can approximate elapsed time while the core was not in a halt state. It i=
s counted on a dedicated fixed counter, leaving the eight programmable coun=
ters available for other events. Note: On all current platforms this event =
stops counting during 'throttling (TM)' states duty off periods the process=
or is 'halted'.  The counter update is done at a lower clock rate then the =
core clock the overflow status bit for this counter may appear 'sticky'.  A=
fter the counter has overflowed and software clears the overflow status bit=
 and resets the counter to less than MAX. The reset value to the counter is=
 not clocked immediately so the overflow status bit will flip 'high (1)' an=
d generate another PMI (if enabled) after which the reset value gets clocke=
d into the counter. Therefore, software will get the interrupt, read the ov=
erflow status bit '1 for bit 34 while the counter value is less than MAX. S=
oftware should ignore this case.",
>          "SampleAfterValue": "2000003",
> @@ -299,6 +300,7 @@
>      },
>      {
>          "BriefDescription": "Core cycles when the thread is not in halt =
state",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "PublicDescription": "Counts the number of core cycles while the=
 thread is not in a halt state. The thread enters the halt state when it is=
 running the HLT instruction. This event is a component in many key event r=
atios. The core frequency may change from time to time due to transitions a=
ssociated with Enhanced Intel SpeedStep Technology or TM2. For this reason =
this event may have a changing ratio with regards to time. When the core fr=
equency is constant, this event can approximate elapsed time while the core=
 was not in the halt state. It is counted on a dedicated fixed counter, lea=
ving the eight programmable counters available for other events.",
>          "SampleAfterValue": "2000003",
> @@ -426,6 +428,7 @@
>      },
>      {
>          "BriefDescription": "Number of instructions retired. Fixed Count=
er - architectural event",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "PEBS": "1",
>          "PublicDescription": "Counts the number of X86 instructions reti=
red - an Architectural PerfMon event. Counting continues during hardware in=
terrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is =
counted by a designated fixed counter freeing up programmable counters to c=
ount other events. INST_RETIRED.ANY_P is counted by a programmable counter.=
",
> @@ -457,6 +460,7 @@
>      },
>      {
>          "BriefDescription": "Precise instruction retired with PEBS preci=
se-distribution",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.PREC_DIST",
>          "PEBS": "1",
>          "PublicDescription": "A version of INST_RETIRED that allows for =
a precise distribution of samples across instructions retired. It utilizes =
the Precise Distribution of Instructions Retired (PDIR++) feature to fix bi=
as in how retired instructions get sampled. Use on Fixed Counter 0.",
> @@ -719,6 +723,7 @@
>      },
>      {
>          "BriefDescription": "TMA slots available for an unhalted logical=
 processor. Fixed counter - architectural event",
> +        "EventCode": "0x0",
>          "EventName": "TOPDOWN.SLOTS",
>          "PublicDescription": "Number of available slots for an unhalted =
logical processor. The event increments by machine-width of the narrowest p=
ipeline as employed by the Top-down Microarchitecture Analysis method (TMA)=
. The count is distributed among unhalted logical processors (hyper-threads=
) who share the same physical core. Software can use this event as the deno=
minator for the top-level metrics of the TMA method. This architectural eve=
nt is counted on a designated fixed counter (Fixed Counter 3).",
>          "SampleAfterValue": "10000003",
> diff --git a/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json b/=
tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json
> index 4121295..67be689 100644
> --- a/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/sierraforest/pipeline.json
> @@ -17,6 +17,7 @@
>      },
>      {
>          "BriefDescription": "Fixed Counter: Counts the number of unhalte=
d core clock cycles",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.CORE",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x2"
> @@ -29,6 +30,7 @@
>      },
>      {
>          "BriefDescription": "Fixed Counter: Counts the number of unhalte=
d reference clock cycles",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x3"
> @@ -43,6 +45,7 @@
>      },
>      {
>          "BriefDescription": "Fixed Counter: Counts the number of unhalte=
d core clock cycles",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x2"
> @@ -55,6 +58,7 @@
>      },
>      {
>          "BriefDescription": "Fixed Counter: Counts the number of instruc=
tions retired",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "PEBS": "1",
>          "SampleAfterValue": "2000003",
> diff --git a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/silvermont/pipeline.json
> index 2d4214b..6423c01 100644
> --- a/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/silvermont/pipeline.json
> @@ -143,6 +143,7 @@
>      },
>      {
>          "BriefDescription": "Fixed Counter: Counts the number of unhalte=
d core clock cycles",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.CORE",
>          "PublicDescription": "Counts the number of core cycles while the=
 core is not in a halt state. The core enters the halt state when it is run=
ning the HLT instruction. This event is a component in many key event ratio=
s.  The core frequency may change from time to time. For this reason this e=
vent may have a changing ratio with regards to time. In systems with a cons=
tant core frequency, this event can give you a measurement of the elapsed t=
ime while the core was not in halt state by dividing the event count by the=
 core frequency. This event is architecturally defined and is a designated =
fixed counter.  CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.CORE_P use the c=
ore frequency which may change from time to time.  CPU_CLK_UNHALTE.REF_TSC =
and CPU_CLK_UNHALTED.REF are not affected by core frequency changes but cou=
nts as if the core is running at the maximum frequency all the time.  The f=
ixed events are CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.REF_TSC and the =
programmable events are CPU_CLK_UNHALTED.CORE_P and CPU_CLK_UNHALTED.REF.",
>          "SampleAfterValue": "2000003",
> @@ -165,6 +166,7 @@
>      },
>      {
>          "BriefDescription": "Fixed Counter: Counts the number of unhalte=
d reference clock cycles",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "Counts the number of reference cycles whil=
e the core is not in a halt state. The core enters the halt state when it i=
s running the HLT instruction. This event is a component in many key event =
ratios.  The core frequency may change from time. This event is not affecte=
d by core frequency changes but counts as if the core is running at the max=
imum frequency all the time.  Divide this event count by core frequency to =
determine the elapsed time while the core was not in halt state.  Divide th=
is event count by core frequency to determine the elapsed time while the co=
re was not in halt state.  This event is architecturally defined and is a d=
esignated fixed counter.  CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.CORE_P=
 use the core frequency which may change from time to time.  CPU_CLK_UNHALT=
E.REF_TSC and CPU_CLK_UNHALTED.REF are not affected by core frequency chang=
es but counts as if the core is running at the maximum frequency all the ti=
me.  The fixed events are CPU_CLK_UNHALTED.CORE and CPU_CLK_UNHALTED.REF_TS=
C and the programmable events are CPU_CLK_UNHALTED.CORE_P and CPU_CLK_UNHAL=
TED.REF.",
>          "SampleAfterValue": "2000003",
> @@ -180,6 +182,7 @@
>      },
>      {
>          "BriefDescription": "Fixed Counter: Counts the number of instruc=
tions retired",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "PublicDescription": "This event counts the number of instructio=
ns that retire.  For instructions that consist of multiple micro-ops, this =
event counts exactly once, as the last micro-op of the instruction retires.=
  The event continues counting while instructions retire, including during =
interrupt service routines caused by hardware interrupts, faults or traps. =
 Background: Modern microprocessors employ extensive pipelining and specula=
tive techniques.  Since sometimes an instruction is started but never compl=
eted, the notion of \"retirement\" is introduced.  A retired instruction is=
 one that commits its states. Or stated differently, an instruction might b=
e abandoned at some point. No instruction is truly finished until it retire=
s.  This counter measures the number of completed instructions.  The fixed =
event is INST_RETIRED.ANY and the programmable event is INST_RETIRED.ANY_P.=
",
>          "SampleAfterValue": "2000003",
> diff --git a/tools/perf/pmu-events/arch/x86/skylake/pipeline.json b/tools=
/perf/pmu-events/arch/x86/skylake/pipeline.json
> index cd3e737..d790f82 100644
> --- a/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/skylake/pipeline.json
> @@ -191,6 +191,7 @@
>      },
>      {
>          "BriefDescription": "Reference cycles when the core is not in ha=
lt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "Counts the number of reference cycles when=
 the core is not in a halt state. The core enters the halt state when it is=
 running the HLT instruction or the MWAIT instruction. This event is not af=
fected by core frequency changes (for example, P states, TM2 transitions) b=
ut has the same incrementing frequency as the time stamp counter. This even=
t can approximate elapsed time while the core was not in a halt state. This=
 event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is=
 counted on a dedicated fixed counter, leaving the four (eight when Hyperth=
reading is disabled) programmable counters available for other events. Note=
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
>          "SampleAfterValue": "2000003",
> @@ -222,6 +223,7 @@
>      },
>      {
>          "BriefDescription": "Core cycles when the thread is not in halt =
state",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "PublicDescription": "Counts the number of core cycles while the=
 thread is not in a halt state. The thread enters the halt state when it is=
 running the HLT instruction. This event is a component in many key event r=
atios. The core frequency may change from time to time due to transitions a=
ssociated with Enhanced Intel SpeedStep Technology or TM2. For this reason =
this event may have a changing ratio with regards to time. When the core fr=
equency is constant, this event can approximate elapsed time while the core=
 was not in the halt state. It is counted on a dedicated fixed counter, lea=
ving the four (eight when Hyperthreading is disabled) programmable counters=
 available for other events.",
>          "SampleAfterValue": "2000003",
> @@ -230,6 +232,7 @@
>      {
>          "AnyThread": "1",
>          "BriefDescription": "Core cycles when at least one thread on the=
 physical core is not in halt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x2"
> @@ -369,6 +372,7 @@
>      },
>      {
>          "BriefDescription": "Instructions retired from execution.",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "PublicDescription": "Counts the number of instructions retired =
from execution. For instructions that consist of multiple micro-ops, Counts=
 the retirement of the last micro-op of the instruction. Counting continues=
 during hardware interrupts, traps, and inside interrupt handlers. Notes: I=
NST_RETIRED.ANY is counted by a designated fixed counter, leaving the four =
(eight when Hyperthreading is disabled) programmable counters available for=
 other events. INST_RETIRED.ANY_P is counted by a programmable counter and =
it is an architectural performance event. Counting: Faulting executions of =
GETSEC/VM entry/VM Exit/MWait will not count as retired instructions.",
>          "SampleAfterValue": "2000003",
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json b/tool=
s/perf/pmu-events/arch/x86/skylakex/pipeline.json
> index 66d686c..efda247 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/pipeline.json
> @@ -200,6 +200,7 @@
>      },
>      {
>          "BriefDescription": "Reference cycles when the core is not in ha=
lt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "Counts the number of reference cycles when=
 the core is not in a halt state. The core enters the halt state when it is=
 running the HLT instruction or the MWAIT instruction. This event is not af=
fected by core frequency changes (for example, P states, TM2 transitions) b=
ut has the same incrementing frequency as the time stamp counter. This even=
t can approximate elapsed time while the core was not in a halt state. This=
 event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is=
 counted on a dedicated fixed counter, leaving the four (eight when Hyperth=
reading is disabled) programmable counters available for other events. Note=
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
>          "SampleAfterValue": "2000003",
> @@ -231,6 +232,7 @@
>      },
>      {
>          "BriefDescription": "Core cycles when the thread is not in halt =
state",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "PublicDescription": "Counts the number of core cycles while the=
 thread is not in a halt state. The thread enters the halt state when it is=
 running the HLT instruction. This event is a component in many key event r=
atios. The core frequency may change from time to time due to transitions a=
ssociated with Enhanced Intel SpeedStep Technology or TM2. For this reason =
this event may have a changing ratio with regards to time. When the core fr=
equency is constant, this event can approximate elapsed time while the core=
 was not in the halt state. It is counted on a dedicated fixed counter, lea=
ving the four (eight when Hyperthreading is disabled) programmable counters=
 available for other events.",
>          "SampleAfterValue": "2000003",
> @@ -239,6 +241,7 @@
>      {
>          "AnyThread": "1",
>          "BriefDescription": "Core cycles when at least one thread on the=
 physical core is not in halt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD_ANY",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x2"
> @@ -378,6 +381,7 @@
>      },
>      {
>          "BriefDescription": "Instructions retired from execution.",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "PublicDescription": "Counts the number of instructions retired =
from execution. For instructions that consist of multiple micro-ops, Counts=
 the retirement of the last micro-op of the instruction. Counting continues=
 during hardware interrupts, traps, and inside interrupt handlers. Notes: I=
NST_RETIRED.ANY is counted by a designated fixed counter, leaving the four =
(eight when Hyperthreading is disabled) programmable counters available for=
 other events. INST_RETIRED.ANY_P is counted by a programmable counter and =
it is an architectural performance event. Counting: Faulting executions of =
GETSEC/VM entry/VM Exit/MWait will not count as retired instructions.",
>          "SampleAfterValue": "2000003",
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json b/=
tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json
> index 543dfc1..4df1294 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-cache.json
> @@ -460,6 +460,7 @@
>      },
>      {
>          "BriefDescription": "Clockticks of the uncore caching & home age=
nt (CHA)",
> +        "EventCode": "0x0",
>          "EventName": "UNC_CHA_CLOCKTICKS",
>          "PerPkg": "1",
>          "PublicDescription": "Counts clockticks of the clock controlling=
 the uncore caching and home agent (CHA).",
> @@ -5678,6 +5679,7 @@
>      {
>          "BriefDescription": "This event is deprecated. Refer to new even=
t UNC_CHA_CLOCKTICKS",
>          "Deprecated": "1",
> +        "EventCode": "0x0",
>          "EventName": "UNC_C_CLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "CHA"
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.=
json b/tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.json
> index 3eece8a7..771ce55 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-interconnect.json
> @@ -1090,6 +1090,7 @@
>      },
>      {
>          "BriefDescription": "Cycles - at UCLK",
> +        "EventCode": "0x0",
>          "EventName": "UNC_M2M_CLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "M2M"
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-io.json b/too=
ls/perf/pmu-events/arch/x86/skylakex/uncore-io.json
> index 2a3a709..21a6a0f 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-io.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-io.json
> @@ -1271,6 +1271,7 @@
>      },
>      {
>          "BriefDescription": "Counting disabled",
> +        "EventCode": "0x0",
>          "EventName": "UNC_IIO_NOTHING",
>          "PerPkg": "1",
>          "Unit": "IIO"
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json b=
/tools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json
> index 7a40aa0..919ce2e 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-memory.json
> @@ -167,6 +167,7 @@
>      },
>      {
>          "BriefDescription": "Memory controller clock ticks",
> +        "EventCode": "0x0",
>          "EventName": "UNC_M_CLOCKTICKS",
>          "PerPkg": "1",
>          "PublicDescription": "Counts clockticks of the fixed frequency c=
lock of the memory controller using one of the programmable counters.",
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json b/=
tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json
> index c6254af..a01b279 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/uncore-power.json
> @@ -1,6 +1,7 @@
>  [
>      {
>          "BriefDescription": "pclk Cycles",
> +        "EventCode": "0x0",
>          "EventName": "UNC_P_CLOCKTICKS",
>          "PerPkg": "1",
>          "PublicDescription": "The PCU runs off a fixed 1 GHz clock.  Thi=
s event counts the number of pclk cycles measured while the counter was ena=
bled.  The pclk, like the Memory Controller's dclk, counts at a constant ra=
te making it a good measure of actual wall time.",
> diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/pipeline.json b/to=
ols/perf/pmu-events/arch/x86/snowridgex/pipeline.json
> index c483c08..2e40cd0 100644
> --- a/tools/perf/pmu-events/arch/x86/snowridgex/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/snowridgex/pipeline.json
> @@ -150,6 +150,7 @@
>      },
>      {
>          "BriefDescription": "Counts the number of unhalted reference clo=
ck cycles at TSC frequency. (Fixed event)",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "Counts the number of reference cycles that=
 the core is not in a halt state. The core enters the halt state when it is=
 running the HLT instruction. This event is not affected by core frequency =
changes and increments at a fixed frequency that is also used for the Time =
Stamp Counter (TSC). This event uses fixed counter 2.",
>          "SampleAfterValue": "2000003",
> @@ -180,6 +181,7 @@
>      },
>      {
>          "BriefDescription": "Counts the total number of instructions ret=
ired. (Fixed event)",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "PEBS": "1",
>          "PublicDescription": "Counts the total number of instructions th=
at retired. For instructions that consist of multiple uops, this event coun=
ts the retirement of the last uop of the instruction. This event continues =
counting during hardware interrupts, traps, and inside interrupt handlers. =
This event uses fixed counter 0.",
> diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json =
b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json
> index a68a5bb..279381b 100644
> --- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json
> +++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json
> @@ -872,6 +872,7 @@
>      },
>      {
>          "BriefDescription": "Uncore cache clock ticks",
> +        "EventCode": "0x0",
>          "EventName": "UNC_CHA_CLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "CHA"
> diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-interconnec=
t.json b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-interconnect.json
> index 7e2895f..ba8b654 100644
> --- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-interconnect.json
> +++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-interconnect.json
> @@ -1419,6 +1419,7 @@
>      },
>      {
>          "BriefDescription": "Clockticks of the mesh to memory (M2M)",
> +        "EventCode": "0x0",
>          "EventName": "UNC_M2M_CLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "M2M"
> diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-memory.json=
 b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-memory.json
> index b80911d..8278095 100644
> --- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-memory.json
> @@ -120,6 +120,7 @@
>      },
>      {
>          "BriefDescription": "Memory controller clock ticks",
> +        "EventCode": "0x0",
>          "EventName": "UNC_M_CLOCKTICKS",
>          "PerPkg": "1",
>          "PublicDescription": "Clockticks of the integrated memory contro=
ller (IMC)",
> diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json =
b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
> index a61ffca..5251c6d 100644
> --- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
> +++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-power.json
> @@ -1,6 +1,7 @@
>  [
>      {
>          "BriefDescription": "Clockticks of the power control unit (PCU)"=
,
> +        "EventCode": "0x0",
>          "EventName": "UNC_P_CLOCKTICKS",
>          "PerPkg": "1",
>          "Unit": "PCU"
> diff --git a/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/tigerlake/pipeline.json
> index 541bf1d..215f253 100644
> --- a/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
> @@ -193,6 +193,7 @@
>      },
>      {
>          "BriefDescription": "Reference cycles when the core is not in ha=
lt state.",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.REF_TSC",
>          "PublicDescription": "Counts the number of reference cycles when=
 the core is not in a halt state. The core enters the halt state when it is=
 running the HLT instruction or the MWAIT instruction. This event is not af=
fected by core frequency changes (for example, P states, TM2 transitions) b=
ut has the same incrementing frequency as the time stamp counter. This even=
t can approximate elapsed time while the core was not in a halt state. This=
 event has a constant ratio with the CPU_CLK_UNHALTED.REF_XCLK event. It is=
 counted on a dedicated fixed counter, leaving the eight programmable count=
ers available for other events. Note: On all current platforms this event s=
tops counting during 'throttling (TM)' states duty off periods the processo=
r is 'halted'.  The counter update is done at a lower clock rate then the c=
ore clock the overflow status bit for this counter may appear 'sticky'.  Af=
ter the counter has overflowed and software clears the overflow status bit =
and resets the counter to less than MAX. The reset value to the counter is =
not clocked immediately so the overflow status bit will flip 'high (1)' and=
 generate another PMI (if enabled) after which the reset value gets clocked=
 into the counter. Therefore, software will get the interrupt, read the ove=
rflow status bit '1 for bit 34 while the counter value is less than MAX. So=
ftware should ignore this case.",
>          "SampleAfterValue": "2000003",
> @@ -208,6 +209,7 @@
>      },
>      {
>          "BriefDescription": "Core cycles when the thread is not in halt =
state",
> +        "EventCode": "0x0",
>          "EventName": "CPU_CLK_UNHALTED.THREAD",
>          "PublicDescription": "Counts the number of core cycles while the=
 thread is not in a halt state. The thread enters the halt state when it is=
 running the HLT instruction. This event is a component in many key event r=
atios. The core frequency may change from time to time due to transitions a=
ssociated with Enhanced Intel SpeedStep Technology or TM2. For this reason =
this event may have a changing ratio with regards to time. When the core fr=
equency is constant, this event can approximate elapsed time while the core=
 was not in the halt state. It is counted on a dedicated fixed counter, lea=
ving the eight programmable counters available for other events.",
>          "SampleAfterValue": "2000003",
> @@ -352,6 +354,7 @@
>      },
>      {
>          "BriefDescription": "Number of instructions retired. Fixed Count=
er - architectural event",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.ANY",
>          "PEBS": "1",
>          "PublicDescription": "Counts the number of X86 instructions reti=
red - an Architectural PerfMon event. Counting continues during hardware in=
terrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is =
counted by a designated fixed counter freeing up programmable counters to c=
ount other events. INST_RETIRED.ANY_P is counted by a programmable counter.=
",
> @@ -377,6 +380,7 @@
>      },
>      {
>          "BriefDescription": "Precise instruction retired event with a re=
duced effect of PEBS shadow in IP distribution",
> +        "EventCode": "0x0",
>          "EventName": "INST_RETIRED.PREC_DIST",
>          "PEBS": "1",
>          "PublicDescription": "A version of INST_RETIRED that allows for =
a more unbiased distribution of samples across instructions retired. It uti=
lizes the Precise Distribution of Instructions Retired (PDIR) feature to mi=
tigate some bias in how retired instructions get sampled. Use on Fixed Coun=
ter 0.",
> @@ -570,6 +574,7 @@
>      },
>      {
>          "BriefDescription": "TMA slots available for an unhalted logical=
 processor. Fixed counter - architectural event",
> +        "EventCode": "0x0",
>          "EventName": "TOPDOWN.SLOTS",
>          "PublicDescription": "Number of available slots for an unhalted =
logical processor. The event increments by machine-width of the narrowest p=
ipeline as employed by the Top-down Microarchitecture Analysis method (TMA)=
. The count is distributed among unhalted logical processors (hyper-threads=
) who share the same physical core. Software can use this event as the deno=
minator for the top-level metrics of the TMA method. This architectural eve=
nt is counted on a designated fixed counter (Fixed Counter 3).",
>          "SampleAfterValue": "10000003",
> --
> 1.8.3.1
>
