Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D747D4932
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjJXICX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjJXICU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:02:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908EA10E;
        Tue, 24 Oct 2023 01:02:18 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso634949066b.2;
        Tue, 24 Oct 2023 01:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698134537; x=1698739337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=deq7nnEu2/yr1FCK4QwIxxNf5xwDIUzMNwm5h32BBH0=;
        b=meQGN9q3LxHIH+tLb0SS+LlXFbFRwVvR2WFeGm5guN7UhNOJeI87K2J3CbWEE71YPB
         0FuVe30a3/yJjZqEdphTBubnJCVeA/vx/JxRX6FUyzTcsoVKjWUKJFAV5HNh2xdp/Zup
         yjPpawS1SyfcqUGmxkqOF01qlKLesGJBNsPbVLXEULgjlM/rcu7VMAHWDPjmz/PASnzN
         SAYdjcxG6qFBmFsNv5k2Sf1Fy6aag7gKB6cK750VyrEOpo3pPRG/UPtI7Eob8Rm0hwxZ
         97eeZRPVaHzeDE7M+ZbRwgE/rpcA++0MjBol5HHXfZ+y1tq0ad33+XNi3xg2d3KsDVhZ
         eFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698134537; x=1698739337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deq7nnEu2/yr1FCK4QwIxxNf5xwDIUzMNwm5h32BBH0=;
        b=SgzPEoqIC1HqaV74nUuJEPzj/d0vn2Pwm7/Lm4rChpWIIgp3rq3TbMH41q+u5cRsXi
         xpas2+iP7QVyKRsyFhl2KUGzFdYuBMYhzhG/KYr4E8xUsFQaDZoosb6L0NUBL2gmGUHe
         nLrJrgS1J9BoatBGfJDCNAuexPhSXeUjbtlUzf5Yv+qNauq79SQi4wFnNQSeORvQmJHr
         m13lGz9x6dU/TZZruSIaL1ksSHqbXeK4ivIXUfKgJChC7vdmD8XLqBFa4qJZCY+auoVp
         4R05ihUust2B6rbXi29G6MfjrN8N81KZvdfFSL33QMIf8Z5rkCChMh7Y3KJdqIRPV7z5
         SrFQ==
X-Gm-Message-State: AOJu0YxvLji7niS8sVZURC66MioKojtEmGeh2lediTZxj4fsq9E74feQ
        6rr7YZoKzWIow4zMTSgkDi8=
X-Google-Smtp-Source: AGHT+IHjczhB36/MaXFAHfKcVZIAI2hvwFz1GPOMI7CvMUM0q5y6Txo48E2pUZaD07iY/QB0ORwURQ==
X-Received: by 2002:a17:907:724d:b0:9ae:4054:5d2a with SMTP id ds13-20020a170907724d00b009ae40545d2amr8991183ejc.16.1698134536898;
        Tue, 24 Oct 2023 01:02:16 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709062b4700b009ade1a4f795sm7687839ejg.168.2023.10.24.01.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 01:02:16 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 24 Oct 2023 10:02:13 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org,
        pavel@ucw.cz, linux-perf-users@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] perf/x86/amd: Don't allow pre-emption in
 amd_pmu_lbr_reset()
Message-ID: <ZTd6BYr17ycdHR2a@gmail.com>
References: <20231023160018.164054-1-mario.limonciello@amd.com>
 <20231023160018.164054-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023160018.164054-3-mario.limonciello@amd.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mario Limonciello <mario.limonciello@amd.com> wrote:

> Fixes a BUG reported during suspend to ram testing.
> 
> ```
> [  478.274752] BUG: using smp_processor_id() in preemptible [00000000] code: rtcwake/2948
> [  478.274754] caller is amd_pmu_lbr_reset+0x19/0xc0
> ```
> 
> Cc: stable@vger.kernel.org # 6.1+
> Fixes: ca5b7c0d9621 ("perf/x86/amd/lbr: Add LbrExtV2 branch record support")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/events/amd/lbr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> index eb31f850841a..5b98e8c7d8b7 100644
> --- a/arch/x86/events/amd/lbr.c
> +++ b/arch/x86/events/amd/lbr.c
> @@ -321,7 +321,7 @@ int amd_pmu_lbr_hw_config(struct perf_event *event)
>  
>  void amd_pmu_lbr_reset(void)
>  {
> -	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	struct cpu_hw_events *cpuc = get_cpu_ptr(&cpu_hw_events);
>  	int i;
>  
>  	if (!x86_pmu.lbr_nr)
> @@ -335,6 +335,7 @@ void amd_pmu_lbr_reset(void)
>  
>  	cpuc->last_task_ctx = NULL;
>  	cpuc->last_log_id = 0;
> +	put_cpu_ptr(&cpu_hw_events);
>  	wrmsrl(MSR_AMD64_LBR_SELECT, 0);
>  }

Weird, amd_pmu_lbr_reset() is called from these places:

  - amd_pmu_lbr_sched_task(): during task sched-in during 
    context-switching, this should already have preemption disabled.

  - amd_pmu_lbr_add(): this gets indirectly called by amd_pmu::add 
    (amd_pmu_add_event()), called by event_sched_in(), which too should have 
    preemption disabled.

I clearly must have missed some additional place it gets called in.

Could you please cite the full log of the amd_pmu_lbr_reset() call that 
caused the critical section warning?

Thanks,

	Ingo
