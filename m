Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C4D7E05B6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbjKCPpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjKCPpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:45:50 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D14D42
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 08:45:47 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so11478a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 08:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699026345; x=1699631145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjRwo1IGVBygAppKkGTjsepd5un/ZpXB7p4VbVCjoI8=;
        b=Ygq9wikTrmkKO1r3SxagfWBppC18gGOlGiG+DEKRoZqiokK1lvnTAzdWxla0cagLB0
         IBgTzZNy/s+51dOoAmLbn7HGTvhEcFbykAJnQws/WLKWxVpRFwpDsuVLUFJXjxcuky6d
         29cfHdWT7onNxOvtM5EP7awnVr/u0KowfIgrq+1z2d3BJ6Gm8USLVOcDLhww0MxOjIDH
         EtoVq2sOLMdvrM0+7cLAUFQklmGr1GVEVbeBZ/ufw5AgBkVtGBrewIsdwmilBwZz+g3q
         AkGiRX1/pS0hqLCFJNjqIjUIWG5KFZ4kxqaEwAUCiALqDwYW0sCAw7UeR6rgDw2LtVHE
         8CKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699026345; x=1699631145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjRwo1IGVBygAppKkGTjsepd5un/ZpXB7p4VbVCjoI8=;
        b=XNdx6+Ui5rNfsg4Q6vC3B0rc6BWEEpfoWBHOUYaRQc83I6+eMV+KnmZbTFmg3daoC5
         hcoW3pNk4KG1fpmq1oHXwceRNukcMN6L5fB+rNtZCy7TxOvpTMkSLOOpxztsIVLG2bAJ
         kAFci8ZfNYIA9p6LgbbKcRHt3H4ddml3/iJu4RSIjr9GvZURxZWw+CEZuye6y2t2ty1i
         vwguao8n/o15s+0hcINrU+3ShOVHzZXoilh6kFW5JsYgMKK65PC37gROcHV2B0tq0RSi
         oLZrIs1B+qFkUN4YcXgDrOIEfq5w0aWZ9F3dVkdb5aqzViBSU0OIQ1CbX57gSudxSbmt
         Fc/w==
X-Gm-Message-State: AOJu0YyDVijqMBnbuTGRi0LPhKkzEqWFf5SRURJu3TX5pXDyQGTHmKfP
        Tj1HyLW42IhzRQ7oFJ5KdN62FAeMwZB2z4/oXM5tFA==
X-Google-Smtp-Source: AGHT+IHkqI6reqbvYFSR1zZzyPUAt09vCldvmbNvBfqW7ZhzxrLZuWblZNw6SMoFfLURSlI4Q0L7glx/y9ttQADPMr0=
X-Received: by 2002:a50:a68b:0:b0:542:d6e7:1e09 with SMTP id
 e11-20020a50a68b000000b00542d6e71e09mr230479edc.0.1699026345421; Fri, 03 Nov
 2023 08:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20231103082441.1389842-1-jisheng.teoh@starfivetech.com>
In-Reply-To: <20231103082441.1389842-1-jisheng.teoh@starfivetech.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 3 Nov 2023 08:45:33 -0700
Message-ID: <CAP-5=fW4T_j02RLghg=_OB1TkRWFuHKOR59xFyEsdEH5gGnUPA@mail.gmail.com>
Subject: Re: [PATCH v2] perf vendor events riscv: add StarFive Dubhe-80 JSON file
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 1:27=E2=80=AFAM Ji Sheng Teoh
<jisheng.teoh@starfivetech.com> wrote:
>
> StarFive's Dubhe-80 supports raw event id 0x00 - 0x22.
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

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks Ji Sheng, gmail made a mess of the patches for me, but doing:

b4 am 20231103082441.1389842-1-jisheng.teoh@starfivetech.com

the contents looked correct.

Ian
