Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFBB7F3278
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjKUPip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbjKUPZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:25:41 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C937812A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:25:35 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50aa698b384so4112e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700580334; x=1701185134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdVnz0EqwYoqK1TyYn7lunmvOkBaJ081uT30S+Tp6E4=;
        b=bocqavc3LVIAAVA6vGaXJZI/Byl8kbPOK0H/62JzWDt88UNE8tP95yBnTQJ6kWKBli
         goknzQ1Nnm5VAKSqX7JyiIfSZJocZ34o9EiscY4hC/3yITZoifAVy2Hs6UvyXOY54ZA0
         6oGNrHWRNmziySL3Q8dlhQDDhjJdfejM4S4WLZRjyeCYL1BHpo81K6VTl7q7yJw7g5+L
         /oC9+ytNtTWWcyUC7zqfVMb/yjnvyMmZN+B1j9ZW9l6/j0CPHtQk/wm0wghDBW14fNM1
         mUiSIrwmLm3iDRyWLSl5aQCAQjb+7E/UZynYVTxVa2eFkUdDDQFGEZaX3tU8sYL15rVH
         QRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700580334; x=1701185134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdVnz0EqwYoqK1TyYn7lunmvOkBaJ081uT30S+Tp6E4=;
        b=BqkROlC14xFhTmFDEXMaZMXswH04p8WnOAzFdx0Jhd6GvFDaOPTG+nVgWHXLbGtvmy
         CHdCRQ5vIn6EjoKbRGpRAoXZpUu/57zbHs+vl9MZkWnzhb8GM2DPELCXZIoqsbAEiBrg
         xPjgUH1DwwFD2e4JeH71682jl0pIWCWNob9y8lJs7CfTaKTEpd/8O5h1haXQwCCWnHDL
         OzIo8in+LoBpl3fj20j/ggsp68hXqDXvC3ZOvh2hoIcU3qvJdysBkWjmLr3ZRL2r1brA
         dW/jKe8y3i2UGbRlvUDMxNhc5P2fHm72MxMncq9dwneTQFTN7eN2lQznYVQgdh/1rUXj
         epow==
X-Gm-Message-State: AOJu0YzPwLjtGX+8eTwt8s5yD2gWFAMfzc1Htvvvv2mPV7KGSVdrAb0i
        1oUYQBed0AvSST3V90t49Lhn4fHwhiDAJIA2ZqXI/A==
X-Google-Smtp-Source: AGHT+IGjWwKqfP+sZkCkMmJUBs2ix0nwpuYL4X3CWk2fguNKsQaaTx/A7talOfabhnBsvDY8FAzgfwSjc7bpmO5hO0I=
X-Received: by 2002:a05:6512:21b:b0:509:48d1:698b with SMTP id
 a27-20020a056512021b00b0050948d1698bmr297252lfo.4.1700580333695; Tue, 21 Nov
 2023 07:25:33 -0800 (PST)
MIME-Version: 1.0
References: <20231109074900.1971266-1-jisheng.teoh@starfivetech.com>
In-Reply-To: <20231109074900.1971266-1-jisheng.teoh@starfivetech.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 21 Nov 2023 07:25:21 -0800
Message-ID: <CAP-5=fVgD7sc1uP5G-Q_bo8bf82rncFt=LLTA725csAT7g63rA@mail.gmail.com>
Subject: Re: [PATCH v3] perf vendor events riscv: add StarFive Dubhe-90 JSON file
To:     Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nikita Shubin <n.shubin@yadro.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 11:51=E2=80=AFPM Ji Sheng Teoh
<jisheng.teoh@starfivetech.com> wrote:
>
> StarFive's Dubhe-90 supports raw event id 0x00 - 0x22.
> The raw events are enabled through PMU node of DT binding.
> Besides raw event, add standard RISC-V firmware events to
> support monitoring of firmware event.
>
> Example of PMU DT node:
> pmu {
>         compatible =3D "riscv,pmu";
>         riscv,raw-event-to-mhpmcounters =3D
>                 /* Event ID 1-31 */
>                 <0x00 0x00 0xFFFFFFFF 0xFFFFFFE0 0x00007FF8>,
>                 /* Event ID 32-33 */
>                 <0x00 0x20 0xFFFFFFFF 0xFFFFFFFE 0x00007FF8>,
>                 /* Event ID 34 */
>                 <0x00 0x22 0xFFFFFFFF 0xFFFFFF22 0x00007FF8>;
> };
>
> Perf stat output:
> [root@user]# perf stat -a \
>         -e access_mmu_stlb \
>         -e miss_mmu_stlb \
>         -e access_mmu_pte_c \
>         -e rob_flush \
>         -e btb_prediction_miss \
>         -e itlb_miss \
>         -e sync_del_fetch_g \
>         -e icache_miss \
>         -e bpu_br_retire \
>         -e bpu_br_miss \
>         -e ret_ins_retire \
>         -e ret_ins_miss \
>         -- openssl speed rsa2048
> Doing 2048 bits private rsa's for 10s: 39 2048 bits private RSA's in
> 10.03s
> Doing 2048 bits public rsa's for 10s: 1469 2048 bits public RSA's in
> 9.47s
> version: 3.0.10
> built on: Tue Aug  1 13:47:24 2023 UTC
> options: bn(64,64)
> CPUINFO: N/A
>                   sign    verify    sign/s verify/s
> rsa 2048 bits 0.257179s 0.006447s      3.9    155.1
>
>  Performance counter stats for 'system wide':
>
>            3112882      access_mmu_stlb
>              10550      miss_mmu_stlb
>              18251      access_mmu_pte_c
>             274765      rob_flush
>           22470560      btb_prediction_miss
>            3035839      itlb_miss
>          643549060      sync_del_fetch_g
>             133013      icache_miss
>           62982796      bpu_br_retire
>             287548      bpu_br_miss
>            8935910      ret_ins_retire
>               8308      ret_ins_miss
>
>       20.656182600 seconds time elapsed
>
> Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> ---
> Changelog:
> v2 -> v3:
> - Add standard RISC-V firmware event
> - Update commit message to reflect addition of standard
>   RISC-V firmware event.
> v1 -> v2:
> - Rename 'Starfive Dubhe' to 'StarFive Dubhe-90' in commit message.
> - Rename 'starfive/dubhe' pmu-events folder to 'starfive/dubhe-90'
> - Update MARCHID to 0x80000000db000090 in mapfile.csv
> ---
>  tools/perf/pmu-events/arch/riscv/mapfile.csv  |   1 +
>  .../arch/riscv/starfive/dubhe-90/common.json  | 172 ++++++++++++++++++
>  .../riscv/starfive/dubhe-90/firmware.json     |  68 +++++++
>  3 files changed, 241 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/riscv/starfive/dubhe-90/co=
mmon.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/starfive/dubhe-90/fi=
rmware.json
>
> diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pm=
u-events/arch/riscv/mapfile.csv
> index c61b3d6ef616..5b75ecfe206d 100644
> --- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
> @@ -15,3 +15,4 @@
>  #
>  #MVENDORID-MARCHID-MIMPID,Version,Filename,EventType
>  0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/u74,core
> +0x67e-0x80000000db000090-0x[[:xdigit:]]+,v1,starfive/dubhe-90,core

I've no problem with this approach, but dubhe-90's json files match
dubhe-80s. Those files are available in perf-tools-next:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/arch/riscv/starfive/dubhe-80?h=3Dperf-tools-next
It could be useful to rebase the patch on that branch to make it
easier to merge. As the files match you could make the regular
expression for dubhe-80 match both of them like:

0x67e-0x80000000db0000[89]0-0x[[:xdigit:]]+,v1,starfive/dubhe-80,core

Thanks,
Ian

> \ No newline at end of file
> diff --git a/tools/perf/pmu-events/arch/riscv/starfive/dubhe-90/common.js=
on b/tools/perf/pmu-events/arch/riscv/starfive/dubhe-90/common.json
> new file mode 100644
> index 000000000000..fbffcacb2ace
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/starfive/dubhe-90/common.json
> @@ -0,0 +1,172 @@
> +[
> +  {
> +    "EventName": "ACCESS_MMU_STLB",
> +    "EventCode": "0x1",
> +    "BriefDescription": "access MMU STLB"
> +  },
> +  {
> +    "EventName": "MISS_MMU_STLB",
> +    "EventCode": "0x2",
> +    "BriefDescription": "miss MMU STLB"
> +  },
> +  {
> +    "EventName": "ACCESS_MMU_PTE_C",
> +    "EventCode": "0x3",
> +    "BriefDescription": "access MMU PTE-Cache"
> +  },
> +  {
> +    "EventName": "MISS_MMU_PTE_C",
> +    "EventCode": "0x4",
> +    "BriefDescription": "miss MMU PTE-Cache"
> +  },
> +  {
> +    "EventName": "ROB_FLUSH",
> +    "EventCode": "0x5",
> +    "BriefDescription": "ROB flush (all kinds of exceptions)"
> +  },
> +  {
> +    "EventName": "BTB_PREDICTION_MISS",
> +    "EventCode": "0x6",
> +    "BriefDescription": "BTB prediction miss"
> +  },
> +  {
> +    "EventName": "ITLB_MISS",
> +    "EventCode": "0x7",
> +    "BriefDescription": "ITLB miss"
> +  },
> +  {
> +    "EventName": "SYNC_DEL_FETCH_G",
> +    "EventCode": "0x8",
> +    "BriefDescription": "SYNC delivery a fetch-group"
> +  },
> +  {
> +    "EventName": "ICACHE_MISS",
> +    "EventCode": "0x9",
> +    "BriefDescription": "ICache miss"
> +  },
> +  {
> +    "EventName": "BPU_BR_RETIRE",
> +    "EventCode": "0xA",
> +    "BriefDescription": "condition branch instruction retire"
> +  },
> +  {
> +    "EventName": "BPU_BR_MISS",
> +    "EventCode": "0xB",
> +    "BriefDescription": "condition branch instruction miss"
> +  },
> +  {
> +    "EventName": "RET_INS_RETIRE",
> +    "EventCode": "0xC",
> +    "BriefDescription": "return instruction retire"
> +  },
> +  {
> +    "EventName": "RET_INS_MISS",
> +    "EventCode": "0xD",
> +    "BriefDescription": "return instruction miss"
> +  },
> +  {
> +    "EventName": "INDIRECT_JR_MISS",
> +    "EventCode": "0xE",
> +    "BriefDescription": "indirect JR instruction miss (inlcude without t=
arget)"
> +  },
> +  {
> +    "EventName": "IBUF_VAL_ID_NORDY",
> +    "EventCode": "0xF",
> +    "BriefDescription": "IBUF valid while ID not ready"
> +  },
> +  {
> +    "EventName": "IBUF_NOVAL_ID_RDY",
> +    "EventCode": "0x10",
> +    "BriefDescription": "IBUF not valid while ID ready"
> +  },
> +  {
> +    "EventName": "REN_INT_PHY_REG_NORDY",
> +    "EventCode": "0x11",
> +    "BriefDescription": "REN integer physical register file is not ready=
"
> +  },
> +  {
> +    "EventName": "REN_FP_PHY_REG_NORDY",
> +    "EventCode": "0x12",
> +    "BriefDescription": "REN floating point physical register file is no=
t ready"
> +  },
> +  {
> +    "EventName": "REN_CP_NORDY",
> +    "EventCode": "0x13",
> +    "BriefDescription": "REN checkpoint is not ready"
> +  },
> +  {
> +    "EventName": "DEC_VAL_ROB_NORDY",
> +    "EventCode": "0x14",
> +    "BriefDescription": "DEC is valid and ROB is not ready"
> +  },
> +  {
> +    "EventName": "OOD_FLUSH_LS_DEP",
> +    "EventCode": "0x15",
> +    "BriefDescription": "out of order flush due to load/store dependency=
"
> +  },
> +  {
> +    "EventName": "BRU_RET_IJR_INS",
> +    "EventCode": "0x16",
> +    "BriefDescription": "BRU retire an IJR instruction"
> +  },
> +  {
> +    "EventName": "ACCESS_DTLB",
> +    "EventCode": "0x17",
> +    "BriefDescription": "access DTLB"
> +  },
> +  {
> +    "EventName": "MISS_DTLB",
> +    "EventCode": "0x18",
> +    "BriefDescription": "miss DTLB"
> +  },
> +  {
> +    "EventName": "LOAD_INS_DCACHE",
> +    "EventCode": "0x19",
> +    "BriefDescription": "load instruction access DCache"
> +  },
> +  {
> +    "EventName": "LOAD_INS_MISS_DCACHE",
> +    "EventCode": "0x1A",
> +    "BriefDescription": "load instruction miss DCache"
> +  },
> +  {
> +    "EventName": "STORE_INS_DCACHE",
> +    "EventCode": "0x1B",
> +    "BriefDescription": "store/amo instruction access DCache"
> +  },
> +  {
> +    "EventName": "STORE_INS_MISS_DCACHE",
> +    "EventCode": "0x1C",
> +    "BriefDescription": "store/amo instruction miss DCache"
> +  },
> +  {
> +    "EventName": "LOAD_SCACHE",
> +    "EventCode": "0x1D",
> +    "BriefDescription": "load access SCache"
> +  },
> +  {
> +    "EventName": "STORE_SCACHE",
> +    "EventCode": "0x1E",
> +    "BriefDescription": "store access SCache"
> +  },
> +  {
> +    "EventName": "LOAD_MISS_SCACHE",
> +    "EventCode": "0x1F",
> +    "BriefDescription": "load miss SCache"
> +  },
> +  {
> +    "EventName": "STORE_MISS_SCACHE",
> +    "EventCode": "0x20",
> +    "BriefDescription": "store miss SCache"
> +  },
> +  {
> +    "EventName": "L2C_PF_REQ",
> +    "EventCode": "0x21",
> +    "BriefDescription": "L2C data-prefetcher request"
> +  },
> +  {
> +    "EventName": "L2C_PF_HIT",
> +    "EventCode": "0x22",
> +    "BriefDescription": "L2C data-prefetcher hit"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/starfive/dubhe-90/firmware.=
json b/tools/perf/pmu-events/arch/riscv/starfive/dubhe-90/firmware.json
> new file mode 100644
> index 000000000000..9b4a032186a7
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/starfive/dubhe-90/firmware.json
> @@ -0,0 +1,68 @@
> +[
> +  {
> +    "ArchStdEvent": "FW_MISALIGNED_LOAD"
> +  },
> +  {
> +    "ArchStdEvent": "FW_MISALIGNED_STORE"
> +  },
> +  {
> +    "ArchStdEvent": "FW_ACCESS_LOAD"
> +  },
> +  {
> +    "ArchStdEvent": "FW_ACCESS_STORE"
> +  },
> +  {
> +    "ArchStdEvent": "FW_ILLEGAL_INSN"
> +  },
> +  {
> +    "ArchStdEvent": "FW_SET_TIMER"
> +  },
> +  {
> +    "ArchStdEvent": "FW_IPI_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_IPI_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_FENCE_I_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_FENCE_I_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_SFENCE_VMA_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_SFENCE_VMA_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_SFENCE_VMA_ASID_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_GVMA_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_GVMA_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_GVMA_VMID_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_VVMA_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_VVMA_RECEIVED"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_SENT"
> +  },
> +  {
> +    "ArchStdEvent": "FW_HFENCE_VVMA_ASID_RECEIVED"
> +  }
> +]
> --
> 2.25.1
>
