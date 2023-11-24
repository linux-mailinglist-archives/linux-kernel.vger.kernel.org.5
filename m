Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D2A7F774C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345609AbjKXPIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345563AbjKXPIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:08:42 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086F819B1;
        Fri, 24 Nov 2023 07:08:48 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-58d4968c362so121702eaf.0;
        Fri, 24 Nov 2023 07:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700838527; x=1701443327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOCl1swrFbW/7sFUtbSrbFab89YweYfN5WTmXg3TDK4=;
        b=FRHSU6UAFdebVwiSN2e7gRICCVSa6Jik2v5Bw6jbd0SH/HW99FY679X5pbpg1BQA5H
         ILxhNuPmgIpGXExubW897LHTrXiBIXsrUMrJqaQSg5aHRWkGBlubm04jag7vdYL5ha5E
         qwBHygZH+/5lY5QZN9D5mThX87CNeNA1S0ze5vlJ58NVXQTt3O9ABLjEPv5k2TzZsoV1
         cknGV/F31lYMV8+LQwlZUSAbId+9E6APpGvnF/g/FBnbr6m7+YuD1tEFbP6HKymo1HZ+
         2vwQISs7+hnTVaSV11z2HmsK8AlqTJoGrnOVk10fY2ZX2epIIqQ6jRQEqAYBWUwrb3hU
         LT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700838527; x=1701443327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOCl1swrFbW/7sFUtbSrbFab89YweYfN5WTmXg3TDK4=;
        b=rvxgUDRRwWcX84685q/9iwiFVZiF42KgaC5urIo9T6LufdUOHUsZ1pxG4k9tFc/SA+
         4nx/1oThOOk9ig17IInPWw7z7YqCbF8LC5+Ra6HFARZgMYqrijZNnDbNvqKj5sA70f+x
         e8ctIrbGDhLCd8Y3mhXCXrdwkVjL9rnSs044unpeV8qcorTPjNpfJQDutQMxw47vVvoD
         3yixRUDrrO+96QE3ISHzZon3MsPM7ORIb1mod3J6fwBHKLB/AgJ1G+gwEdXK0PwHVWRK
         jnCK+8V/bE5lIyJD2vRpNWDJ+QZonql7f7lWHY49v0oW5N4YHjRfWWFBK9Rtfl4biCP/
         9mLg==
X-Gm-Message-State: AOJu0YyRxAEi4oAXpfNXwXi5j3U6oxuLCIrsbNyPM5+MKTr7XW6xF/oI
        lsRphLmNfc/hRcMxOCh6KKAI+CX+UEppU/xjJeg=
X-Google-Smtp-Source: AGHT+IHbug40/QYz+/7p5JxTk4BbKhmH+Y2/rax9GKSlZ7ONB0Q5R/TbT3m8srbn2jl1Ir5SdK3oYg2mW7a0rR13vWY=
X-Received: by 2002:a05:6358:611e:b0:16e:29eb:98c8 with SMTP id
 30-20020a056358611e00b0016e29eb98c8mr676506rws.30.1700838527192; Fri, 24 Nov
 2023 07:08:47 -0800 (PST)
MIME-Version: 1.0
References: <20231122121235.827122-1-peterlin@andestech.com> <20231122121235.827122-14-peterlin@andestech.com>
In-Reply-To: <20231122121235.827122-14-peterlin@andestech.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 24 Nov 2023 15:08:21 +0000
Message-ID: <CA+V-a8tozeqAN=R1UHciT=hOCcnSRack=h3gpb3=pytQY9TpAQ@mail.gmail.com>
Subject: Re: [PATCH v4 13/13] riscv: andes: Support symbolic FW and HW raw events
To:     Yu Chien Peter Lin <peterlin@andestech.com>
Cc:     acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
        alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
        anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        conor+dt@kernel.org, conor.dooley@microchip.com, conor@kernel.org,
        devicetree@vger.kernel.org, dminus@andestech.com,
        evan@rivosinc.com, geert+renesas@glider.be, guoren@kernel.org,
        heiko@sntech.de, irogers@google.com, jernej.skrabec@gmail.com,
        jolsa@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev, locus84@andestech.com,
        magnus.damm@gmail.com, mark.rutland@arm.com, mingo@redhat.com,
        n.shubin@yadro.com, namhyung@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, peterz@infradead.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, sunilvl@ventanamicro.com,
        tglx@linutronix.de, tim609@andestech.com, uwu@icenowy.me,
        wens@csie.org, will@kernel.org, ycliang@andestech.com,
        inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED,URIBL_CSS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 12:19=E2=80=AFPM Yu Chien Peter Lin
<peterlin@andestech.com> wrote:
>
> From: Locus Wei-Han Chen <locus84@andestech.com>
>
> This patch adds the Andes AX45 JSON files in the perf tool,
> allowing perf to be used with symbolic event names.
>
> Signed-off-by: Locus Wei-Han Chen <locus84@andestech.com>
> Reviewed-by: Yu Chien Peter Lin <peterlin@andestech.com>
> Reviewed-by: Charles Ci-Jyun Wu <dminus@andestech.com>
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> ---
> Changes v1 -> v2:
>   - No change
> Changes v2 -> v3:
>   - No change
> Changes v3 -> v4:
>   - No change
> ---
>  .../arch/riscv/andes/ax45/firmware.json       |  68 ++++++++++
>  .../arch/riscv/andes/ax45/instructions.json   | 127 ++++++++++++++++++
>  .../arch/riscv/andes/ax45/memory.json         |  57 ++++++++
>  .../arch/riscv/andes/ax45/microarch.json      |  77 +++++++++++
>  tools/perf/pmu-events/arch/riscv/mapfile.csv  |   1 +
>  5 files changed, 330 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.=
json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/instructi=
ons.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/memory.js=
on
>  create mode 100644 tools/perf/pmu-events/arch/riscv/andes/ax45/microarch=
.json
>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json b/=
tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
> new file mode 100644
> index 000000000000..9b4a032186a7
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/andes/ax45/firmware.json
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
> diff --git a/tools/perf/pmu-events/arch/riscv/andes/ax45/instructions.jso=
n b/tools/perf/pmu-events/arch/riscv/andes/ax45/instructions.json
> new file mode 100644
> index 000000000000..713a08c1a40f
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/andes/ax45/instructions.json
> @@ -0,0 +1,127 @@
> +[
> +       {
> +               "EventCode": "0x10",
> +               "EventName": "cycle_count",
> +               "BriefDescription": "Cycle count"
> +       },
> +       {
> +               "EventCode": "0x20",
> +               "EventName": "inst_count",
> +               "BriefDescription": "Retired instruction count"
> +       },
> +       {
> +               "EventCode": "0x30",
> +               "EventName": "int_load_inst",
> +               "BriefDescription": "Integer load instruction count"
> +       },
> +       {
> +               "EventCode": "0x40",
> +               "EventName": "int_store_inst",
> +               "BriefDescription": "Integer store instruction count"
> +       },
> +       {
> +               "EventCode": "0x50",
> +               "EventName": "atomic_inst",
> +               "BriefDescription": "Atomic instruction count"
> +       },
> +       {
> +               "EventCode": "0x60",
> +               "EventName": "sys_inst",
> +               "BriefDescription": "System instruction count"
> +       },
> +       {
> +               "EventCode": "0x70",
> +               "EventName": "int_compute_inst",
> +               "BriefDescription": "Integer computational instruction co=
unt"
> +       },
> +       {
> +               "EventCode": "0x80",
> +               "EventName": "condition_br",
> +               "BriefDescription": "Conditional branch instruction count=
"
> +       },
> +       {
> +               "EventCode": "0x90",
> +               "EventName": "taken_condition_br",
> +               "BriefDescription": "Taken conditional branch instruction=
 count"
> +       },
> +       {
> +               "EventCode": "0xA0",
> +               "EventName": "jal_inst",
> +               "BriefDescription": "JAL instruction count"
> +       },
> +       {
> +               "EventCode": "0xB0",
> +               "EventName": "jalr_inst",
> +               "BriefDescription": "JALR instruction count"
> +       },
> +       {
> +               "EventCode": "0xC0",
> +               "EventName": "ret_inst",
> +               "BriefDescription": "Return instruction count"
> +       },
> +       {
> +               "EventCode": "0xD0",
> +               "EventName": "control_trans_inst",
> +               "BriefDescription": "Control transfer instruction count"
> +       },
> +       {
> +               "EventCode": "0xE0",
> +               "EventName": "ex9_inst",
> +               "BriefDescription": "EXEC.IT instruction count"
> +       },
> +       {
> +               "EventCode": "0xF0",
> +               "EventName": "int_mul_inst",
> +               "BriefDescription": "Integer multiplication instruction c=
ount"
> +       },
> +       {
> +               "EventCode": "0x100",
> +               "EventName": "int_div_rem_inst",
> +               "BriefDescription": "Integer division/remainder instructi=
on count"
> +       },
> +       {
> +               "EventCode": "0x110",
> +               "EventName": "float_load_inst",
> +               "BriefDescription": "Floating-point load instruction coun=
t"
> +       },
> +       {
> +               "EventCode": "0x120",
> +               "EventName": "float_store_inst",
> +               "BriefDescription": "Floating-point store instruction cou=
nt"
> +       },
> +       {
> +               "EventCode": "0x130",
> +               "EventName": "float_add_sub_inst",
> +               "BriefDescription": "Floating-point addition/subtraction =
instruction count"
> +       },
> +       {
> +               "EventCode": "0x140",
> +               "EventName": "float_mul_inst",
> +               "BriefDescription": "Floating-point multiplication instru=
ction count"
> +       },
> +       {
> +               "EventCode": "0x150",
> +               "EventName": "float_fused_muladd_inst",
> +               "BriefDescription": "Floating-point fused multiply-add in=
struction count"
> +       },
> +       {
> +               "EventCode": "0x160",
> +               "EventName": "float_div_sqrt_inst",
> +               "BriefDescription": "Floating-point division or square-ro=
ot instruction count"
> +       },
> +       {
> +               "EventCode": "0x170",
> +               "EventName": "other_float_inst",
> +               "BriefDescription": "Other floating-point instruction cou=
nt"
> +       },
> +       {
> +               "EventCode": "0x180",
> +               "EventName": "int_mul_add_sub_inst",
> +               "BriefDescription": "Integer multiplication and add/sub i=
nstruction count"
> +       },
> +       {
> +               "EventCode": "0x190",
> +               "EventName": "retired_ops",
> +               "BriefDescription": "Retired operation count"
> +       }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/andes/ax45/memory.json b/to=
ols/perf/pmu-events/arch/riscv/andes/ax45/memory.json
> new file mode 100644
> index 000000000000..c7401b526c77
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/andes/ax45/memory.json
> @@ -0,0 +1,57 @@
> +[
> +       {
> +               "EventCode": "0x01",
> +               "EventName": "ilm_access",
> +               "BriefDescription": "ILM access"
> +       },
> +       {
> +               "EventCode": "0x11",
> +               "EventName": "dlm_access",
> +               "BriefDescription": "DLM access"
> +       },
> +       {
> +               "EventCode": "0x21",
> +               "EventName": "icache_access",
> +               "BriefDescription": "ICACHE access"
> +       },
> +       {
> +               "EventCode": "0x31",
> +               "EventName": "icache_miss",
> +               "BriefDescription": "ICACHE miss"
> +       },
> +       {
> +               "EventCode": "0x41",
> +               "EventName": "dcache_access",
> +               "BriefDescription": "DCACHE access"
> +       },
> +       {
> +               "EventCode": "0x51",
> +               "EventName": "dcache_miss",
> +               "BriefDescription": "DCACHE miss"
> +       },
> +       {
> +               "EventCode": "0x61",
> +               "EventName": "dcache_load_access",
> +               "BriefDescription": "DCACHE load access"
> +       },
> +       {
> +               "EventCode": "0x71",
> +               "EventName": "dcache_load_miss",
> +               "BriefDescription": "DCACHE load miss"
> +       },
> +       {
> +               "EventCode": "0x81",
> +               "EventName": "dcache_store_access",
> +               "BriefDescription": "DCACHE store access"
> +       },
> +       {
> +               "EventCode": "0x91",
> +               "EventName": "dcache_store_miss",
> +               "BriefDescription": "DCACHE store miss"
> +       },
> +       {
> +               "EventCode": "0xA1",
> +               "EventName": "dcache_wb",
> +               "BriefDescription": "DCACHE writeback"
> +       }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/andes/ax45/microarch.json b=
/tools/perf/pmu-events/arch/riscv/andes/ax45/microarch.json
> new file mode 100644
> index 000000000000..a6d378cbaa74
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/andes/ax45/microarch.json
> @@ -0,0 +1,77 @@
> +[
> +       {
> +               "EventCode": "0xB1",
> +               "EventName": "cycle_wait_icache_fill",
> +               "BriefDescription": "Cycles waiting for ICACHE fill data"
> +       },
> +       {
> +               "EventCode": "0xC1",
> +               "EventName": "cycle_wait_dcache_fill",
> +               "BriefDescription": "Cycles waiting for DCACHE fill data"
> +       },
> +       {
> +               "EventCode": "0xD1",
> +               "EventName": "uncached_ifetch_from_bus",
> +               "BriefDescription": "Uncached ifetch data access from bus=
"
> +       },
> +       {
> +               "EventCode": "0xE1",
> +               "EventName": "uncached_load_from_bus",
> +               "BriefDescription": "Uncached load data access from bus"
> +       },
> +       {
> +               "EventCode": "0xF1",
> +               "EventName": "cycle_wait_uncached_ifetch",
> +               "BriefDescription": "Cycles waiting for uncached ifetch d=
ata from bus"
> +       },
> +       {
> +               "EventCode": "0x101",
> +               "EventName": "cycle_wait_uncached_load",
> +               "BriefDescription": "Cycles waiting for uncached load dat=
a from bus"
> +       },
> +       {
> +               "EventCode": "0x111",
> +               "EventName": "main_itlb_access",
> +               "BriefDescription": "Main ITLB access"
> +       },
> +       {
> +               "EventCode": "0x121",
> +               "EventName": "main_itlb_miss",
> +               "BriefDescription": "Main ITLB miss"
> +       },
> +       {
> +               "EventCode": "0x131",
> +               "EventName": "main_dtlb_access",
> +               "BriefDescription": "Main DTLB access"
> +       },
> +       {
> +               "EventCode": "0x141",
> +               "EventName": "main_dtlb_miss",
> +               "BriefDescription": "Main DTLB miss"
> +       },
> +       {
> +               "EventCode": "0x151",
> +               "EventName": "cycle_wait_itlb_fill",
> +               "BriefDescription": "Cycles waiting for Main ITLB fill da=
ta"
> +       },
> +       {
> +               "EventCode": "0x161",
> +               "EventName": "pipe_stall_cycle_dtlb_miss",
> +               "BriefDescription": "Pipeline stall cycles caused by Main=
 DTLB miss"
> +       },
> +       {
> +               "EventCode": "0x02",
> +               "EventName": "mispredict_condition_br",
> +               "BriefDescription": "Misprediction of conditional branche=
s"
> +       },
> +       {
> +               "EventCode": "0x12",
> +               "EventName": "mispredict_take_condition_br",
> +               "BriefDescription": "Misprediction of taken conditional b=
ranches"
> +       },
> +       {
> +               "EventCode": "0x22",
> +               "EventName": "mispredict_target_ret_inst",
> +               "BriefDescription": "Misprediction of targets of Return i=
nstructions"
> +       }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pm=
u-events/arch/riscv/mapfile.csv
> index c61b3d6ef616..5bf09af14c1b 100644
> --- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
> @@ -15,3 +15,4 @@
>  #
>  #MVENDORID-MARCHID-MIMPID,Version,Filename,EventType
>  0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/u74,core
> +0x31e-0x8000000000008a45-0x[[:xdigit:]]+,v1,andes/ax45,core
> --
> 2.34.1
>
>
