Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B0A7DF9DB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345852AbjKBSYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjKBSYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:24:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0B6DB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 11:24:39 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so1761a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 11:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698949478; x=1699554278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGrFkmhMC1oEo20BN+P9RczALkt6AOOD+e7AfvLCPzc=;
        b=i0ZubHsEdZuFrGmRLClNU2w+9FUdAxxlXi3+ypjZMxibccDAbKUFeGTLS9axjYD9z0
         dvixZyCCveeDSo3MkBYF6hntfRPpevmZ8FlzDgoTHFPLJnBwTZjCSEHNIp+GpLh0mCr/
         VU1zvdCmDOteFSilEs72bFRIrXb+5lf8H7pMA+vcDr9IJpshMdFDWSHCWA3A7h6r/Qzn
         aZhSJZwFfDADz5V3w5HLeJV2wQnQcOgazzlQvHxdGMzS+FspvbTukULy3V8bS9sy8d0b
         ADwdw0hMmRpPrc02KJKVKBISZFRutw9OrXEPMIADdcAX1xzKr/0nnLVi0yUAbiDeqd7k
         pWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698949478; x=1699554278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGrFkmhMC1oEo20BN+P9RczALkt6AOOD+e7AfvLCPzc=;
        b=sh1UPTknBuXKuhWmZI7q9UlO7FfPcTv+illr9qbzZp8jkhr7qlxj2mUmP+h3pBQexk
         wSRpoY9iEiPj+0WDrxnwAXYk8HY09DbSwvVS0QVN5LDsOABMOvWBDk1giuM75T0kEVpP
         NC2Wg3dn5hINAkcA+4jhix7TqiyH5a4Y7ROpeAvytINbcy3bUvgIW0aN4zTxDMX8QijN
         +zsuGrth78ZmkVC5QuZpKdFGVKtl+XGOW7r+SqcW5f3hrKqEXFD4HHNf1WS7OcuvsKrH
         uoeymKu/t8mg7YQG6FxhbKJN9/cVs41LNh0B1NC2K6ozJCtGOcpbTJmTBuicrEfkWR16
         WDFA==
X-Gm-Message-State: AOJu0Yw7VCkmjlmYwaplNb3gkra0H8TbYJ56aQBDsGjFEnzG2A+nSc0l
        xGP+6YR0ts0avQpgZWTOS/SVKwLC38MDHo48Si7rYA==
X-Google-Smtp-Source: AGHT+IEKx/oi2mHPllRTvhZgICUybvLALbVxPiHdX6jP8Fk42YYckF246DXO1aG6m3T9FlE22dHuiU117WNQri5yrHM=
X-Received: by 2002:a05:6402:3228:b0:543:fbf7:c70e with SMTP id
 g40-20020a056402322800b00543fbf7c70emr104719eda.5.1698949477935; Thu, 02 Nov
 2023 11:24:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231102015447.2526572-1-jisheng.teoh@starfivetech.com>
In-Reply-To: <20231102015447.2526572-1-jisheng.teoh@starfivetech.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Nov 2023 11:24:24 -0700
Message-ID: <CAP-5=fW6Qeu8Q_mQ7zUBsHn+BiMmDJvjn0nT1YAZaLH6EaBjnA@mail.gmail.com>
Subject: Re: [PATCH] perf vendor events riscv: add StarFive Dubhe-80 JSON file
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
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Beeman Strong <beeman@rivosinc.com>,
        linux-riscv@lists.infradead.org, n.shubin@yadro.com,
        kconsul@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 1, 2023 at 6:55=E2=80=AFPM Ji Sheng Teoh
<jisheng.teoh@starfivetech.com> wrote:
>
> StarFive's Dubhe-80 supports raw event id 0x00 - 0x22.
> The raw events are enabled through PMU node of DT binding.
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
> Example of Perf stat output:
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
>
> Doing 2048 bits private rsa's for 10s: 39 2048 bits private RSA's in
> 10.14s
> Doing 2048 bits public rsa's for 10s: 1563 2048 bits public RSA's in
> 10.00s
> version: 3.0.11
> built on: Tue Sep 19 13:02:31 2023 UTC
> options: bn(64,64)
> CPUINFO: N/A
>                   sign    verify    sign/s verify/s
> rsa 2048 bits 0.260000s 0.006398s      3.8    156.3
>
>  Performance counter stats for 'system wide':
>
>            1338350      access_mmu_stlb
>            1154025      miss_mmu_stlb
>            1162691      access_mmu_pte_c
>              34067      rob_flush
>           11212384      btb_prediction_miss
>            1256242      itlb_miss
>          652523491      sync_del_fetch_g
>             384465      icache_miss
>           64635789      bpu_br_retire
>             323440      bpu_br_miss
>            8785143      ret_ins_retire
>              31236      ret_ins_miss
>
>       20.760822480 seconds time elapsed
>
> Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>

Thanks Ji Sheng,

in adding these events for this new architecture is there a reason not
to add the architecture standard events in
tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json ?
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json?h=3Dperf-tools-=
next

Perhaps it is worth commenting in the commit message whether or not
these events are supported.

Thanks,
Ian
