Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077027D5930
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343881AbjJXQwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233092AbjJXQv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:51:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101B5AF;
        Tue, 24 Oct 2023 09:51:53 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507c50b7c36so6562798e87.3;
        Tue, 24 Oct 2023 09:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698166311; x=1698771111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tt9VMNJm14dclxeRhCE5YUSAtNoTBtrJoCG/7gTbgYc=;
        b=WXBrBbA/GfXdEMd47dbbQH9euZwTvnuAnEXaF/VFZgJTh6AO2/FFAFwpa/4yqLzxDR
         EMI9EGD8+1DtRZhEpmaOnLuIBhRm5WzSt3dKcSMEVeFRwachfl4OpvUpklvFRWYTTi5V
         FQNVXKhIa5EG5MnSimW+HxgzxwFLDSflm1MxjqFmOcwhaL6Gab9HCks6/O8nUFw7L1XR
         pVlk6el8P3kvxVDRFU/57i/Q1UgViOLxq3VfJiNXf1HJQy4hatrizpSF27LebSh8eDPc
         uQ/0ErYlq5Li3SU/hOGHSwkIXR+ulDhOiKEq044+SmMSliKUeAv+07QeuV4oLTcF/ZJk
         B3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698166311; x=1698771111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tt9VMNJm14dclxeRhCE5YUSAtNoTBtrJoCG/7gTbgYc=;
        b=EuFNQqVi8jkxudr/8xDn5LkkSS5CECLIS5LHByxS52KKZFi57ys3gp812b0B22ymTT
         FCiNDQqCqVHBYHsogFbRuea3nmVGFHPXrJlo0nGVfUtvgmI/piNZwmexehfJGCgTHEIX
         5kJxr6EBSf5GditHj05NCwLpHSqjsfnbNgKSv4Zp1UJNw4osZzdy2lzPFEoH8nPYgTev
         gcZfCjiJRfntNCT3QXUS9AD5iqC110y7qtbgmjIGDBUeD968tWR8EVU5l38zOrQTqoxZ
         OJDXylsP9EmrgsOf0oTI8zarg/dX40p3iprCKlCT5FKysvRoifKktRMbUOAxwHtFW9+L
         20Lw==
X-Gm-Message-State: AOJu0YxVFHIpvG1qsigs5/8LLpGzPrxo66C8sCZKrNAHgrPsGm54m2NQ
        GlNqyc+gBsK2VqBTsLuNCJo=
X-Google-Smtp-Source: AGHT+IEgFXhtOsauhH1Njd4JIw/Q9HdWjMZpYxXGKriVaZAVypy+uOSK2ZD1Db6QYV6iOvYlQMwh6g==
X-Received: by 2002:a19:6745:0:b0:507:9fc1:ca7e with SMTP id e5-20020a196745000000b005079fc1ca7emr8477325lfj.51.1698166310742;
        Tue, 24 Oct 2023 09:51:50 -0700 (PDT)
Received: from gmail.com (1F2EF1E7.nat.pool.telekom.hu. [31.46.241.231])
        by smtp.gmail.com with ESMTPSA id u20-20020a50a414000000b005346925a474sm815553edb.43.2023.10.24.09.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 09:51:50 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 24 Oct 2023 18:51:47 +0200
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
Message-ID: <ZTf2IxAVPUFq91F4@gmail.com>
References: <20231023160018.164054-1-mario.limonciello@amd.com>
 <20231023160018.164054-3-mario.limonciello@amd.com>
 <ZTd6BYr17ycdHR2a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTd6BYr17ycdHR2a@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Mario Limonciello <mario.limonciello@amd.com> wrote:
> 
> > Fixes a BUG reported during suspend to ram testing.
> > 
> > ```
> > [  478.274752] BUG: using smp_processor_id() in preemptible [00000000] code: rtcwake/2948
> > [  478.274754] caller is amd_pmu_lbr_reset+0x19/0xc0
> > ```
> > 
> > Cc: stable@vger.kernel.org # 6.1+
> > Fixes: ca5b7c0d9621 ("perf/x86/amd/lbr: Add LbrExtV2 branch record support")
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  arch/x86/events/amd/lbr.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> > index eb31f850841a..5b98e8c7d8b7 100644
> > --- a/arch/x86/events/amd/lbr.c
> > +++ b/arch/x86/events/amd/lbr.c
> > @@ -321,7 +321,7 @@ int amd_pmu_lbr_hw_config(struct perf_event *event)
> >  
> >  void amd_pmu_lbr_reset(void)
> >  {
> > -	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> > +	struct cpu_hw_events *cpuc = get_cpu_ptr(&cpu_hw_events);
> >  	int i;
> >  
> >  	if (!x86_pmu.lbr_nr)
> > @@ -335,6 +335,7 @@ void amd_pmu_lbr_reset(void)
> >  
> >  	cpuc->last_task_ctx = NULL;
> >  	cpuc->last_log_id = 0;
> > +	put_cpu_ptr(&cpu_hw_events);
> >  	wrmsrl(MSR_AMD64_LBR_SELECT, 0);
> >  }
> 
> Weird, amd_pmu_lbr_reset() is called from these places:
> 
>   - amd_pmu_lbr_sched_task(): during task sched-in during 
>     context-switching, this should already have preemption disabled.
> 
>   - amd_pmu_lbr_add(): this gets indirectly called by amd_pmu::add 
>     (amd_pmu_add_event()), called by event_sched_in(), which too should have 
>     preemption disabled.
> 
> I clearly must have missed some additional place it gets called in.

Just for completeness, the additional place I missed is 
amd_pmu_cpu_reset():

                static_call(amd_pmu_branch_reset)();

... and the amd_pmu_branch_reset static call is set up with 
amd_pmu_lbr_reset, which is why git grep missed it.

Anyway, amd_pmu_cpu_reset() is very much something that should run 
non-preemptable to begin with, so your patch only papers over the real 
problem AFAICS.

Thanks,

	Ingo
