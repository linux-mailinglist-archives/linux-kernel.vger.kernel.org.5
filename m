Return-Path: <linux-kernel+bounces-25122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8259D82C832
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5E81F233F2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12838632;
	Sat, 13 Jan 2024 00:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="BaapVokA"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C063236
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 00:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atishpatra.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atishpatra.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cd0d05838fso79362361fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 16:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1705104298; x=1705709098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbH0ObE2Pi8n+TtACEyBv03NTKSbcKArm6Tse3UArX8=;
        b=BaapVokAkYg1YHjhaPgWOqvzQKWan45BsNfRj5JmIVbZT9mFZ3XlAys/S9vBHtRyRe
         kcVIg+VE6T2ILL2e/ZHwEmi/qEa1U2L7I8C1MDKZg0bRapDUwo9rLjg3LzP6NypMo0dY
         6uh9L8HlBrAFfvSSdtdT/Cz4bT+pMJXnqQvQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705104298; x=1705709098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbH0ObE2Pi8n+TtACEyBv03NTKSbcKArm6Tse3UArX8=;
        b=CWS/wjGDBQWdc8ksgYJX7sWlRATBTnTMjOWA7bVGBoj7GFYPf6FXA+cwMhf2IP7vJn
         qcighnBbfq0+/+PtSj3cWlI6KfkgCxVBLmCXVrTPLRVDA51krxxchvBCVtnEanR/IPfX
         U0hLWVKB3HSG23PzJSttBYp7AeT0CBTD9AFwS4WnIlaKi7osvIwdV+HQqMOTi2dfC7/m
         Fp8hiQ07GqyrpToM8/IPSAbJR6RqLyzgB58yP7DRMLYg4mJ9YO9YjpUrImjKYiJQCFA9
         EazqbGvmih2WlMuY/etULJtZwl0o3whZVQwPIEUkEXNyOP4INtkA0Jmn3r4AlMC9bd8R
         3qfw==
X-Gm-Message-State: AOJu0Yzh6r1sotMTNhyr6WPPkMSrOC1S0lR6TJN2flrrYayhnTUHkqJb
	9C+pjVDxLFuuuFpTRpZFEnIU9AENuPayyVZARiVbeU0g3iUi
X-Google-Smtp-Source: AGHT+IGEyaMVgWle34ONQUxwRlfD098l+SMvTSxZbNefZB6inFNdpNZrGpV+48levahU6E1Cfug3chgqUIyC39BHV5o=
X-Received: by 2002:a2e:93c3:0:b0:2cd:1211:ba9 with SMTP id
 p3-20020a2e93c3000000b002cd12110ba9mr1040563ljh.41.1705104297793; Fri, 12 Jan
 2024 16:04:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110073917.2398826-1-peterlin@andestech.com> <20240110073917.2398826-17-peterlin@andestech.com>
In-Reply-To: <20240110073917.2398826-17-peterlin@andestech.com>
From: Atish Patra <atishp@atishpatra.org>
Date: Fri, 12 Jan 2024 16:04:46 -0800
Message-ID: <CAOnJCULcJJAp1baxtKM3eOzW_LwMZ+PM9m25Sn1VJ428RiUTGw@mail.gmail.com>
Subject: Re: [PATCH v7 16/16] riscv: andes: Support specifying symbolic
 firmware and hardware raw events
To: Yu Chien Peter Lin <peterlin@andestech.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	alexander.shishkin@linux.intel.com, andre.przywara@arm.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, conor+dt@kernel.org, 
	conor.dooley@microchip.com, conor@kernel.org, devicetree@vger.kernel.org, 
	dminus@andestech.com, evan@rivosinc.com, geert+renesas@glider.be, 
	guoren@kernel.org, heiko@sntech.de, irogers@google.com, 
	jernej.skrabec@gmail.com, jolsa@kernel.org, jszhang@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, locus84@andestech.com, magnus.damm@gmail.com, 
	mark.rutland@arm.com, mingo@redhat.com, n.shubin@yadro.com, 
	namhyung@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	peterz@infradead.org, prabhakar.mahadev-lad.rj@bp.renesas.com, 
	rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org, 
	sunilvl@ventanamicro.com, tglx@linutronix.de, tim609@andestech.com, 
	uwu@icenowy.me, wens@csie.org, will@kernel.org, ycliang@andestech.com, 
	inochiama@outlook.com, chao.wei@sophgo.com, unicorn_wang@outlook.com, 
	wefu@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 11:41=E2=80=AFPM Yu Chien Peter Lin
<peterlin@andestech.com> wrote:
>
> From: Locus Wei-Han Chen <locus84@andestech.com>
>
> Add the Andes AX45 JSON files that allows specifying symbolic event
> names for the raw PMU events.
>
> Signed-off-by: Locus Wei-Han Chen <locus84@andestech.com>
> Reviewed-by: Yu Chien Peter Lin <peterlin@andestech.com>
> Reviewed-by: Charles Ci-Jyun Wu <dminus@andestech.com>
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Changes v1 -> v2:
>   - No change
> Changes v2 -> v3:
>   - No change
> Changes v3 -> v4:
>   - No change
> Changes v4 -> v5:
>   - Include Prabhakar's Tested-by
> Changes v5 -> v6:
>   - No change
> Changes v6 -> v7:
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
json
>
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

Acked-by: Atish Patra <atishp@rivosinc.com>

--=20
Regards,
Atish

