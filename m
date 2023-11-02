Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190407DF064
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 11:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347182AbjKBKm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 06:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346637AbjKBKmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:42:54 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E4DE7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 03:42:49 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6be1bc5aa1cso830495b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 03:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698921768; x=1699526568; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pd/NLx66E9zKbyZKSmW6GKzzom6QC7VJQH4VG6waGJI=;
        b=JngVmes3LKL+tq7VRLskzUathjAuUPBIpszmIMvi3JExngnHk7fEGjBCmyK6b6fzmL
         9vibGKdEzIVQIPiw1q6hq2zzk0GTT0bplbFF7K/Ehvr+C9LGpARQIUlJTyJUojn2O9Xa
         DyKmHYD7ZT1LvwIWMa8FNYuiiPtM3BJO3KW3Cg+4oB7C7K+W8bT6SOTjvknOPSadAjRl
         s3wz8pD14HiI7XsUvKThGzo4XtirBs3croyMI9QyYBG02+lfGM8DTPF0bCeV0UzCjfBn
         wHTx2EQ6KCG4LZIeKu/J6sC8570D1LrwoJ0XQRNn13fbvaMbbysI0BZHLEJ3oQ+ocD5o
         P7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698921768; x=1699526568;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pd/NLx66E9zKbyZKSmW6GKzzom6QC7VJQH4VG6waGJI=;
        b=XGu5fGk8CeCsiDYxkdj9CUQACgGFzFJ/ddXNJ+rMcFP4q24U45wJMo3EDBOtAxLb10
         a4Cdm1bLBz1ry9SWSVRQT9etgZesfzNLS4TXChrIGcEEFCm+cfr5v4bppROuDPCk1lCt
         OwUVdbaBuWqoY1furwbn+pnCqvvZvC3lC7kHhB04PXNLEsXfLswPBYn2pVpyDCIV4fDF
         xVZSLpqx6um+pI+339LzAHKJn5KEjHgNIkZGRwSPwdAZcj6oLvHa6EP1i9KKIV68Suke
         1WWNyXaEFxJxJXimOlHZ52Y4QzEFOYiqx56AL8M4Yv2okdeC7BFZkIOFX4VzPZq5Ndi1
         ZTBQ==
X-Gm-Message-State: AOJu0Yz2wBX1lLpOUuQNFIiF8RTJL+7ljgGKg8YZJKyrBp/nuH3PrYsM
        D6tCGk0/K8GfLg4g88tTi7mN37/k06AlwyoMRzVLQQ==
X-Google-Smtp-Source: AGHT+IG9q8u5gOigN0kAQNp7r+iSnUd3jOn4cu/HyW0nSc2d2OH3QUFya3mfy+9toAaBAa+OcGAKzvricdwJEQfd/c4=
X-Received: by 2002:a05:6a21:7903:b0:181:7914:7b34 with SMTP id
 bg3-20020a056a21790300b0018179147b34mr3334001pzc.21.1698921768594; Thu, 02
 Nov 2023 03:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231027080400.56703-1-vincent.guittot@linaro.org>
 <20231027080400.56703-7-vincent.guittot@linaro.org> <89b5db0e-1121-4d0c-a8f4-1202465f5251@arm.com>
In-Reply-To: <89b5db0e-1121-4d0c-a8f4-1202465f5251@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 2 Nov 2023 11:42:37 +0100
Message-ID: <CAKfTPtDKMhNpjATHtVuTvas59=ugtw7Q2T3fVKx8T83=-nM3xQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] cpufreq/cppc: set the frequency used for computing
 the capacity
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
        lukasz.luba@arm.com, ionela.voinescu@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On Thu, 2 Nov 2023 at 10:07, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> Hello Vincent,
>
> On 10/27/23 10:03, Vincent Guittot wrote:
> > Save the frequency associated to the performance that has been used when
> > initializing the capacity of CPUs.
> > Also, cppc cpufreq driver can register an artificial energy model. In such
> > case, it needs the frequency for this compute capacity.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   drivers/base/arch_topology.c | 15 ++++++++++++++-
> >   1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> > index 9a073c2d2086..d4bef370feb3 100644
> > --- a/drivers/base/arch_topology.c
> > +++ b/drivers/base/arch_topology.c
> > @@ -349,6 +349,7 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
> >
> >   void topology_init_cpu_capacity_cppc(void)
> >   {
> > +     u64 capacity, capacity_scale = 0;
> >       struct cppc_perf_caps perf_caps;
> >       int cpu;
> >
> > @@ -365,6 +366,10 @@ void topology_init_cpu_capacity_cppc(void)
> >                   (perf_caps.highest_perf >= perf_caps.nominal_perf) &&
> >                   (perf_caps.highest_perf >= perf_caps.lowest_perf)) {
> >                       raw_capacity[cpu] = perf_caps.highest_perf;
> > +                     capacity_scale = max_t(u64, capacity_scale, raw_capacity[cpu]);
> > +
> > +                     per_cpu(capacity_ref_freq, cpu) = cppc_perf_to_khz(&perf_caps, raw_capacity[cpu]);
> > +
>
> To continue Beata's point, I think there is an issue with the following:
> cppc_perf_to_khz() and cppc_khz_to_perf() were previously used with a struct containing
> frequencies in KHz, cf. [1].
> In the original _CPC object, frequencies are in MHz. It means that the perf_caps struct
> here contains frequencies in MHz, and per_cpu(capacity_ref_freq, cpu) is in MHz aswell.

Yeah, I haven't noticed this intermediate step in cppc_cpufreq. I'm
going to fix this

>
> [1] https://github.com/torvalds/linux/blob/master/drivers/cpufreq/cppc_cpufreq.c#L682
>
>
> >                       pr_debug("cpu_capacity: CPU%d cpu_capacity=%u (raw).\n",
> >                                cpu, raw_capacity[cpu]);
> >                       continue;
> > @@ -375,7 +380,15 @@ void topology_init_cpu_capacity_cppc(void)
> >               goto exit;
> >       }
> >
> > -     topology_normalize_cpu_scale();
> > +     for_each_possible_cpu(cpu) {
> > +             capacity = raw_capacity[cpu];
> > +             capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
> > +                                  capacity_scale);
> > +             topology_set_cpu_scale(cpu, capacity);
> > +             pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
> > +                     cpu, topology_get_cpu_scale(cpu));
> > +     }
> > +
> >       schedule_work(&update_topology_flags_work);
> >       pr_debug("cpu_capacity: cpu_capacity initialization done\n");
> >
