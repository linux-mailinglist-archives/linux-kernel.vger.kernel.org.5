Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FE2789D17
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 13:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjH0LBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 07:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjH0LB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 07:01:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9459109;
        Sun, 27 Aug 2023 04:01:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79D34614ED;
        Sun, 27 Aug 2023 11:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B996DC433AD;
        Sun, 27 Aug 2023 11:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693134084;
        bh=MfJ/UMHbuSynMM/GxAyPBaVhYT2JNusI6qvDYcFszC8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GxtDEo36KFL4Eq9D+j531ld+Z5M9664jom7H004MJVS1AL1BxRsuE6XKd8jMkpZ6c
         EC3JS8Z5m9AFUX4OaK/Ga16hYePuYW398Nx/Zqhdvfn4LKQpgcy6e87ZItZWar7MF/
         eTvYR7v5Erqw2b8zgItQBTtCatX3wUby9udZHsyJurZgbhqbqhia+VFE6Tx8w2uBkG
         sGwfQAMztxr3zp90tzpp9JjR4S+iZZFDHZsALo6U3ViE2OXt6MjGaCQsna2dl9+GTH
         rrWQYz6Zyn3P0eF4tqkiYfMHAGwsCI8FB55y+/0KZIt/HUpJcSLdJx5WsjXIiJb80U
         YAesunFWCMyZw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5009d4a4897so3503076e87.0;
        Sun, 27 Aug 2023 04:01:24 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz2iVHQX8lGRJcz2z2b/B9zlBrOF+IsKS1xuFbpaYygBiV29NIP
        1vV0Xhlf3p1dqG8VOm2wl/fd6/IwamADmsm3MMs=
X-Google-Smtp-Source: AGHT+IFksJuf9T5ShxpD1z7Zlun7wRpOhgwYLBy12TJHiVKywsuMyIJhVuk6JXCNrVHgSTT5JhyH6Urvrj5WdETa/u0=
X-Received: by 2002:a05:6512:3b98:b0:500:807a:f1b2 with SMTP id
 g24-20020a0565123b9800b00500807af1b2mr19348689lfv.28.1693134082421; Sun, 27
 Aug 2023 04:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <IA1PR20MB4953DD82D0116EC291C21777BBE2A@IA1PR20MB4953.namprd20.prod.outlook.com>
In-Reply-To: <IA1PR20MB4953DD82D0116EC291C21777BBE2A@IA1PR20MB4953.namprd20.prod.outlook.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 27 Aug 2023 07:01:10 -0400
X-Gmail-Original-Message-ID: <CAJF2gTRwB=H72j5ZfrQ2OS1rwqr7Gw2NCABteDLb01dzegDLqg@mail.gmail.com>
Message-ID: <CAJF2gTRwB=H72j5ZfrQ2OS1rwqr7Gw2NCABteDLb01dzegDLqg@mail.gmail.com>
Subject: Re: [PATCH V4] perf vendor events riscv: add T-HEAD C9xx JSON file
To:     Inochi Amaoto <inochiama@outlook.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nikita Shubin <n.shubin@yadro.com>, Wei Fu <wefu@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx for the patch.
Tested-by: Guo Ren <guoren@kernel.org>

On Sat, Aug 26, 2023 at 4:44=E2=80=AFAM Inochi Amaoto <inochiama@outlook.co=
m> wrote:
>
> Add json file of T-HEAD C9xx series events.
>
> The event idx (raw value) is summary as following:
>
> event id range   | support cpu
>  0x01 - 0x2a     |  c906,c910,c920
>
> The event ids are based on the public document of T-HEAD and cover
> the c900 series.
>
> These events are the max that c900 series support.
> Since T-HEAD let manufacturers decide whether events are usable,
> the final support of the perf events is determined by the pmu node
> of the soc dtb.
>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---
> Change from V3:
> 1. fix some typo in json file
> 2. correct the event id range in commit
> 3. rename directory to c900-legacy to identify the old T-HEAD cpus
>
> This patch need the following patches for opensbi to function normaly:
> https://lists.infradead.org/pipermail/opensbi/2023-August/005500.html
>
> The dtb patch:
> https://lists.infradead.org/pipermail/linux-riscv/2023-August/039040.html
>
> A test result on D1 board with mainline opensbi and mainline kernel:
> [root@test perf]# ./perf stat -a \
> >   -e l1_icache_access \
> >   -e l1_icache_miss \
> >   -e itlb_miss \
> >   -e dtlb_miss \
> >   -e jtlb_miss \
> >   -e inst_branch_mispredict \
> >   -e inst_branch \
> >   -e inst_store \
> >   -e l1_dcache_read_access \
> >   -e l1_dcache_read_miss \
> >   -e l1_dcache_write_access \
> >   -e l1_dcache_write_miss \
> >   -- openssl speed rsa2048
> Doing 2048 bits private rsa's for 10s: 100 2048 bits private RSA's in 10.=
06s
> Doing 2048 bits public rsa's for 10s: 4051 2048 bits public RSA's in 10.0=
0s
> version: 3.1.2
> built on: Sat Aug  5 14:56:47 2023 UTC
> options: bn(64,64)
> CPUINFO: N/A
>                   sign    verify    sign/s verify/s
> rsa 2048 bits 0.100600s 0.002469s      9.9    405.1
>
>  Performance counter stats for 'system wide':
>
>      7,120,831,110      l1_icache_access
>          2,145,279      l1_icache_miss
>          1,307,935      itlb_miss
>          2,477,482      dtlb_miss
>            402,760      jtlb_miss
>          8,043,723      inst_branch_mispredict
>        153,469,454      inst_branch
>        537,300,381      inst_store
>        947,508,099      l1_dcache_read_access
>            770,550      l1_dcache_read_miss
>        537,262,702      l1_dcache_write_access
>            171,436      l1_dcache_write_miss
>
>       20.315046885 seconds time elapsed
>
> ---
>  tools/perf/pmu-events/arch/riscv/mapfile.csv  |  1 +
>  .../arch/riscv/thead/c900-legacy/cache.json   | 67 ++++++++++++++++
>  .../riscv/thead/c900-legacy/firmware.json     | 68 ++++++++++++++++
>  .../riscv/thead/c900-legacy/instruction.json  | 72 +++++++++++++++++
>  .../riscv/thead/c900-legacy/microarch.json    | 80 +++++++++++++++++++
>  5 files changed, 288 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/riscv/thead/c900-legacy/ca=
che.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/thead/c900-legacy/fi=
rmware.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/thead/c900-legacy/in=
struction.json
>  create mode 100644 tools/perf/pmu-events/arch/riscv/thead/c900-legacy/mi=
croarch.json
>
> diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pm=
u-events/arch/riscv/mapfile.csv
> index c61b3d6ef616..b42b65d09c36 100644
> --- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
> @@ -15,3 +15,4 @@
>  #
>  #MVENDORID-MARCHID-MIMPID,Version,Filename,EventType
>  0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/u74,core
> +0x5b7-0x0-0x0,v1,thead/c900-legacy,core
> diff --git a/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/cache.jso=
n b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/cache.json
> new file mode 100644
> index 000000000000..2b142348d635
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/cache.json
> @@ -0,0 +1,67 @@
> +[
> +  {
> +    "EventName": "L1_ICACHE_ACCESS",
> +    "EventCode": "0x00000001",
> +    "BriefDescription": "L1 instruction cache access"
> +  },
> +  {
> +    "EventName": "L1_ICACHE_MISS",
> +    "EventCode": "0x00000002",
> +    "BriefDescription": "L1 instruction cache miss"
> +  },
> +  {
> +    "EventName": "ITLB_MISS",
> +    "EventCode": "0x00000003",
> +    "BriefDescription": "I-UTLB miss"
> +  },
> +  {
> +    "EventName": "DTLB_MISS",
> +    "EventCode": "0x00000004",
> +    "BriefDescription": "D-UTLB miss"
> +  },
> +  {
> +    "EventName": "JTLB_MISS",
> +    "EventCode": "0x00000005",
> +    "BriefDescription": "JTLB miss"
> +  },
> +  {
> +    "EventName": "L1_DCACHE_READ_ACCESS",
> +    "EventCode": "0x0000000c",
> +    "BriefDescription": "L1 data cache read access"
> +  },
> +  {
> +    "EventName": "L1_DCACHE_READ_MISS",
> +    "EventCode": "0x0000000d",
> +    "BriefDescription": "L1 data cache read miss"
> +  },
> +  {
> +    "EventName": "L1_DCACHE_WRITE_ACCESS",
> +    "EventCode": "0x0000000e",
> +    "BriefDescription": "L1 data cache write access"
> +  },
> +  {
> +    "EventName": "L1_DCACHE_WRITE_MISS",
> +    "EventCode": "0x0000000f",
> +    "BriefDescription": "L1 data cache write miss"
> +  },
> +  {
> +    "EventName": "LL_CACHE_READ_ACCESS",
> +    "EventCode": "0x00000010",
> +    "BriefDescription": "LL Cache read access"
> +  },
> +  {
> +    "EventName": "LL_CACHE_READ_MISS",
> +    "EventCode": "0x00000011",
> +    "BriefDescription": "LL Cache read miss"
> +  },
> +  {
> +    "EventName": "LL_CACHE_WRITE_ACCESS",
> +    "EventCode": "0x00000012",
> +    "BriefDescription": "LL Cache write access"
> +  },
> +  {
> +    "EventName": "LL_CACHE_WRITE_MISS",
> +    "EventCode": "0x00000013",
> +    "BriefDescription": "LL Cache write miss"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.=
json b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json
> new file mode 100644
> index 000000000000..9b4a032186a7
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/firmware.json
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
> diff --git a/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/instructi=
on.json b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/instruction.js=
on
> new file mode 100644
> index 000000000000..c822b5373333
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/instruction.json
> @@ -0,0 +1,72 @@
> +[
> +  {
> +    "EventName": "INST_BRANCH_MISPREDICT",
> +    "EventCode": "0x00000006",
> +    "BriefDescription": "Mispredicted branch instructions"
> +  },
> +  {
> +    "EventName": "INST_BRANCH",
> +    "EventCode": "0x00000007",
> +    "BriefDescription": "Retired branch instructions"
> +  },
> +  {
> +    "EventName": "INST_JMP_MISPREDICT",
> +    "EventCode": "0x00000008",
> +    "BriefDescription": "Indirect branch mispredict"
> +  },
> +  {
> +    "EventName": "INST_JMP",
> +    "EventCode": "0x00000009",
> +    "BriefDescription": "Retired jmp instructions"
> +  },
> +  {
> +    "EventName": "INST_STORE",
> +    "EventCode": "0x0000000b",
> +    "BriefDescription": "Retired store instructions"
> +  },
> +  {
> +    "EventName": "INST_ALU",
> +    "EventCode": "0x0000001d",
> +    "BriefDescription": "Retired ALU instructions"
> +  },
> +  {
> +    "EventName": "INST_LDST",
> +    "EventCode": "0x0000001e",
> +    "BriefDescription": "Retired Load/Store instructions"
> +  },
> +  {
> +    "EventName": "INST_VECTOR",
> +    "EventCode": "0x0000001f",
> +    "BriefDescription": "Retired Vector instructions"
> +  },
> +  {
> +    "EventName": "INST_CSR",
> +    "EventCode": "0x00000020",
> +    "BriefDescription": "Retired CSR instructions"
> +  },
> +  {
> +    "EventName": "INST_SYNC",
> +    "EventCode": "0x00000021",
> +    "BriefDescription": "Retired sync instructions (AMO/LR/SC instructio=
ns)"
> +  },
> +  {
> +    "EventName": "INST_UNALIGNED_ACCESS",
> +    "EventCode": "0x00000022",
> +    "BriefDescription": "Retired Store/Load instructions with unaligned =
memory access"
> +  },
> +  {
> +    "EventName": "INST_ECALL",
> +    "EventCode": "0x00000025",
> +    "BriefDescription": "Retired ecall instructions"
> +  },
> +  {
> +    "EventName": "INST_LONG_JP",
> +    "EventCode": "0x00000026",
> +    "BriefDescription": "Retired long jump instructions"
> +  },
> +  {
> +    "EventName": "INST_FP",
> +    "EventCode": "0x0000002a",
> +    "BriefDescription": "Retired FPU instructions"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/microarch=
.json b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/microarch.json
> new file mode 100644
> index 000000000000..0ab6f288af91
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/riscv/thead/c900-legacy/microarch.json
> @@ -0,0 +1,80 @@
> +[
> +  {
> +    "EventName": "LSU_SPEC_FAIL",
> +    "EventCode": "0x0000000a",
> +    "BriefDescription": "LSU speculation fail"
> +  },
> +  {
> +    "EventName": "IDU_RF_PIPE_FAIL",
> +    "EventCode": "0x00000014",
> +    "BriefDescription": "Instruction decode unit launch pipeline failed =
in RF state"
> +  },
> +  {
> +    "EventName": "IDU_RF_REG_FAIL",
> +    "EventCode": "0x00000015",
> +    "BriefDescription": "Instruction decode unit launch register file fa=
il in RF state"
> +  },
> +  {
> +    "EventName": "IDU_RF_INSTRUCTION",
> +    "EventCode": "0x00000016",
> +    "BriefDescription": "retired instruction count of Instruction decode=
 unit in RF (Register File) stage"
> +  },
> +  {
> +    "EventName": "LSU_4K_STALL",
> +    "EventCode": "0x00000017",
> +    "BriefDescription": "LSU stall times for long distance data access (=
Over 4K)",
> +    "PublicDescription": "This stall occurs when translate virtual addre=
ss with page offset over 4k"
> +  },
> +  {
> +    "EventName": "LSU_OTHER_STALL",
> +    "EventCode": "0x00000018",
> +    "BriefDescription": "LSU stall times for other reasons (except the 4=
k stall)"
> +  },
> +  {
> +    "EventName": "LSU_SQ_OTHER_DIS",
> +    "EventCode": "0x00000019",
> +    "BriefDescription": "LSU store queue discard others"
> +  },
> +  {
> +    "EventName": "LSU_SQ_DATA_DISCARD",
> +    "EventCode": "0x0000001a",
> +    "BriefDescription": "LSU store queue discard data (uops)"
> +  },
> +  {
> +    "EventName": "BRANCH_DIRECTION_MISPREDICTION",
> +    "EventCode": "0x0000001b",
> +    "BriefDescription": "Branch misprediction in BTB"
> +  },
> +  {
> +    "EventName": "BRANCH_DIRECTION_PREDICTION",
> +    "EventCode": "0x0000001c",
> +    "BriefDescription": "All branch prediction in BTB",
> +    "PublicDescription": "This event including both successful predictio=
n and failed prediction in BTB"
> +  },
> +  {
> +    "EventName": "INTERRUPT_ACK_COUNT",
> +    "EventCode": "0x00000023",
> +    "BriefDescription": "acknowledged interrupt count"
> +  },
> +  {
> +    "EventName": "INTERRUPT_OFF_CYCLE",
> +    "EventCode": "0x00000024",
> +    "BriefDescription": "PLIC arbitration time when the interrupt is not=
 responded",
> +    "PublicDescription": "The arbitration time is recorded while meeting=
 any of the following:\n- CPU is M-mode and MIE =3D=3D 0\n- CPU is S-mode a=
nd delegation and SIE =3D=3D 0\n"
> +  },
> +  {
> +    "EventName": "IFU_STALLED_CYCLE",
> +    "EventCode": "0x00000027",
> +    "BriefDescription": "Number of stall cycles of the instruction fetch=
 unit (IFU)."
> +  },
> +  {
> +    "EventName": "IDU_STALLED_CYCLE",
> +    "EventCode": "0x00000028",
> +    "BriefDescription": "hpcp_backend_stall Number of stall cycles of th=
e instruction decoding unit (IDU) and next-level pipeline unit."
> +  },
> +  {
> +    "EventName": "SYNC_STALL",
> +    "EventCode": "0x00000029",
> +    "BriefDescription": "Sync instruction stall cycle fence/fence.i/sync=
/sfence"
> +  }
> +]
> --
> 2.41.0
>


--=20
Best Regards
 Guo Ren
