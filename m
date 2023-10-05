Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E157BAB3F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 22:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjJEUJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 16:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjJEUJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 16:09:43 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443BFF1;
        Thu,  5 Oct 2023 13:09:42 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53447d0241eso2561796a12.3;
        Thu, 05 Oct 2023 13:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696536580; x=1697141380; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sfmkRc/uY6UuKa9VNHdy4C4hxN6NSuOU6XiScrNs4/I=;
        b=QmUc7DFw1EJZ34FGeRRyHFNbWPfzJS5PHawiiHtvkL8dc39BHmdGpqimW4enxNNSDX
         VtsU8R8OqbaorJWXcZsUxDw2pM8XLoiRy9RW7T7Gj93/GH3UR43j/H402BmeaANh1TTu
         h3tKPxrppp0aAM7aGkyrNneaGtY+Gp/8q0q7pXY68EpUjEDhsJnMownVZ9aUUsnTrThT
         EiqF0pIlhMJ7Px+mAMgZ0d9MUpsYfyWgpQb8KuJmwWzVSPHw4bbAA+AiMGAtTfmXdTAO
         TkhWnI/zzpWxIdBoTkdCeH1MnAo3N7Sc+uBC5xnSEkmkjz1v5WfHI/IGq3hPnA1svV9X
         1DJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696536580; x=1697141380;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sfmkRc/uY6UuKa9VNHdy4C4hxN6NSuOU6XiScrNs4/I=;
        b=CIuk06mpSyelLMnEVUhFAusWn0RWbaJDyVyJenAvAniOhAQu+KHU2FkBdl3+b1mkOm
         F45C6UlqdyBJnOLtaSeBbpr2QNlbw3z0m/esW7g/GpgUWLY+mS1RaHEsEBGya3GBiiWm
         wkq/iUtPQKKpD6YXsWriMD/Vv9F4M1hpXaOpMoKfQ8GNExTxAuSMSyNGGMQ9AFj/X1ud
         +tRm15zJOcAeluz9vVF/B6JnLaq5cHRdbbAnq567V0rfIskZJyYkdj6BotLOfniYGNC2
         ZNq2papnJ0G2GxW78Wj+Qe5qDsyO1APer7GTwuTUWbFvFtvhlTBZF6ff13mn0eyZrPMu
         0PGQ==
X-Gm-Message-State: AOJu0Yy0blTm22uA2IxwRsMPkbGyIs0Tf/q1Li7f0ynOABuWCA8Zfsmh
        ssbJTUbShQI1EFStYIdGRmA=
X-Google-Smtp-Source: AGHT+IEnBYfve56IylcRPgP0PcIdY9GCF7h5W7PsF3KKpyLfgORQdVo7XwM6EZvEmwiBuHCC/hUOsA==
X-Received: by 2002:a17:907:7603:b0:9ae:381a:6c55 with SMTP id jx3-20020a170907760300b009ae381a6c55mr6004112ejc.15.1696536580400;
        Thu, 05 Oct 2023 13:09:40 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id a24-20020a170906685800b009828e26e519sm1681960ejs.122.2023.10.05.13.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 13:09:39 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 5 Oct 2023 22:09:37 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, viresh.kumar@linaro.org,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        guohua.yan@unisoc.com, qyousef@layalina.io,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: schedutil: next_freq need update when
 cpufreq_limits changed
Message-ID: <ZR8YAQoa//dLs3Yn@gmail.com>
References: <20230719130527.8074-1-xuewen.yan@unisoc.com>
 <ZR6delkbZxl31zuY@gmail.com>
 <CAJZ5v0j8T0KUjLzS=MCF1M33KMhf-EVrT1W5Tncr6wnOXUMgwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j8T0KUjLzS=MCF1M33KMhf-EVrT1W5Tncr6wnOXUMgwQ@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Rafael J. Wysocki <rafael@kernel.org> wrote:

> On Thu, Oct 5, 2023 at 1:26 PM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Xuewen Yan <xuewen.yan@unisoc.com> wrote:
> >
> > > When cpufreq's policy is single, there is a scenario that will
> > > cause sg_policy's next_freq to be unable to update.
> > >
> > > When the cpu's util is always max, the cpufreq will be max,
> > > and then if we change the policy's scaling_max_freq to be a
> > > lower freq, indeed, the sg_policy's next_freq need change to
> > > be the lower freq, however, because the cpu_is_busy, the next_freq
> > > would keep the max_freq.
> > >
> > > For example:
> > > The cpu7 is single cpu:
> > >
> > > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # while true;do done&
> > > [1] 4737
> > > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # taskset -p 80 4737
> > > pid 4737's current affinity mask: ff
> > > pid 4737's new affinity mask: 80
> > > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_max_freq
> > > 2301000
> > > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_cur_freq
> > > 2301000
> > > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # echo 2171000 > scaling_max_freq
> > > unisoc:/sys/devices/system/cpu/cpufreq/policy7 # cat scaling_max_freq
> > > 2171000
> > >
> > > At this time, the sg_policy's next_freq would keep 2301000.
> > >
> > > To prevent the case happen, add the judgment of the need_freq_update flag.
> > >
> > > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > > Co-developed-by: Guohua Yan <guohua.yan@unisoc.com>
> > > Signed-off-by: Guohua Yan <guohua.yan@unisoc.com>
> > > ---
> > >  kernel/sched/cpufreq_schedutil.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > index 4492608b7d7f..458d359f5991 100644
> > > --- a/kernel/sched/cpufreq_schedutil.c
> > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > @@ -350,7 +350,8 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
> > >        * Except when the rq is capped by uclamp_max.
> > >        */
> > >       if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
> > > -         sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq) {
> > > +         sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq &&
> > > +         !sg_policy->need_freq_update) {
> > >               next_f = sg_policy->next_freq;
> > >
> > >               /* Restore cached freq as next_freq has changed */
> >
> > Just wondering about the status of this fix - is it pending in
> > some tree, or should we apply it to the scheduler tree?
> 
> I have not queued it up yet, so it can be applied to the scheduler tree.

Ok, I've applied it - and I've added your Acked-by.

Thanks,

	Ingo
