Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0787F6055
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345498AbjKWNc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345479AbjKWNc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:32:58 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D879D47
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:33:04 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5bcfc508d14so610289a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700746384; x=1701351184; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yvVEsznFGOEcHL++JvtqHDNKFWEmCpdzy05jYiWZejk=;
        b=TuNSM3c+IKndbuqfknq5r3rhJZwn758kINi3ElXTqbNwseMoxPuVALWc+a7p85knKL
         Q1ZUNWD9wo/39D6ATE2bXlgRP6vatdYD6vopADg0Uy56abCeWtYMflg3i+yCXsyR3qRU
         tqY9Z+223WCJAY0DEYPUwvfrRokgqTZjyWOIPQDnElZ3A6YeC2l22Wx1BbkhTJO/Cy++
         oewVm+bvqByQIcn7LGFyLLIvXK1bIjYCq0rdUbHa3q34+jqddTCvWBdzquiGTAW7BWGR
         2FzwusRw86Ra/5vQf6BOOa9EEqE+z7vfGfZBUmkx04UyyM1zion94Cx0Co+1F2jPGXgW
         A0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700746384; x=1701351184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yvVEsznFGOEcHL++JvtqHDNKFWEmCpdzy05jYiWZejk=;
        b=R+v0W0qXZQPfjhJ0TSIpd2Iso2MKiRgCAjY7TvKT7UzCpl6SMiMpMixNBVI8mDOQTL
         vXJlUI4A8/M7fVqe7bdov14wlvAXSrg8fYe94HvuzEZPzDBEVsiZgaZ2YdtcY0bzhpRf
         cLfamcr5DcPlg0KhzhRuEGuVqkOIsg7MQUFh4cEAHmlWr2v4wR00Wbfcs19SIZkYhWDl
         zRwXsoBtNByEHboxzcIN3LnzyHJWu6cdO0GOogXQLD6A6SmAezX+2BRj2PJ/6lPFlveB
         l3tpY7QKx1myW4zc0IZaZ2RWUWna8q9xyvw4r6r+cdLTQkSA1Y8V5u4KVNcFlOZkyY0d
         cV8A==
X-Gm-Message-State: AOJu0YyN/UHBuNbMhwr+qV8V4e5rKzHXdlNGQgUnk/d75S/gXZD8eGw3
        OCA3LSaZ9aSC8/fk6GoGU03KTh1DkNh/n94mgyKXig==
X-Google-Smtp-Source: AGHT+IGeJ8HWTjPQII5hKN4+VrgDmeYXnjKUIUFadHHOWbUsRdPsUh0SMrOCZbLFTxSuF/OxQ+sqNEP5Tm3v5rMIUPY=
X-Received: by 2002:a05:6a20:7d90:b0:14c:a2e1:65ec with SMTP id
 v16-20020a056a207d9000b0014ca2e165ecmr6520553pzj.38.1700746384045; Thu, 23
 Nov 2023 05:33:04 -0800 (PST)
MIME-Version: 1.0
References: <20231103131821.1176294-1-vincent.guittot@linaro.org>
 <20231103131821.1176294-2-vincent.guittot@linaro.org> <20231114205422.k5m6y4m5vnw7dvzj@airbuntu>
 <CAKfTPtDMEes6V2xRHavAwWrVuiZBdFAsaaxv9=-psAZCTPQWKg@mail.gmail.com>
 <20231121211725.gaekv6svnqdiq5l4@airbuntu> <CAKfTPtDzAZMcuWOYYOOAjCyvrOQiqyHZJBFVbACAvTqo+pU1gQ@mail.gmail.com>
 <20231121220955.uxk2zanxfemwyfz6@airbuntu>
In-Reply-To: <20231121220955.uxk2zanxfemwyfz6@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 23 Nov 2023 14:32:52 +0100
Message-ID: <CAKfTPtAHbYCyqA6jLqkoWgQ2X625tann8Mpy0QttgQo5OPvS9w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] sched/schedutil: Rework performance estimation
To:     Qais Yousef <qyousef@layalina.io>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, wyes.karny@amd.com, beata.michalska@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 at 14:15, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 11/23/23 08:47, Vincent Guittot wrote:
>
> > > > > And is it right to mix irq and uclamp_min with bw_min which is for DL? We might
> > > >
> > > > cpu_bw_dl() is not the actual utilization by DL task but the computed
> > > > bandwidth which can be seen as min performance level
> > >
> > > Yep. That's why I am not in favour of a dvfs headroom for DL.
> > >
> > > But what I meant here is that in effective_cpu_util(), where we populate min
> > > and max we have
> > >
> > >         if (min) {
> > >                 /*
> > >                  * The minimum utilization returns the highest level between:
> > >                  * - the computed DL bandwidth needed with the irq pressure which
> > >                  *   steals time to the deadline task.
> > >                  * - The minimum performance requirement for CFS and/or RT.
> > >                  */
> > >                 *min = max(irq + cpu_bw_dl(rq), uclamp_rq_get(rq, UCLAMP_MIN));
> > >
> > > So if there was an RT/CFS task requesting a UCLAMP_MIN of 1024 for example,
> > > bw_min will end up being too high, no?
> >
> > But at the end, we want at least uclamp_min for cfs or rt just like we
> > want at least DL bandwidth for DL tasks
>
> The issue I see is that we do
>
> static void sugov_get_util()
> {
> ..
>         util = effective_cpu_util(.., &min, ..); // min = max(irq + cpu_bw_dl(), rq_uclamp_min)
>         ..
>         sg_cpu->bw_min = min; // bw_min can pick the rq_uclamp_min. Shouldn't it be irq + cpu_bw_dl() only?
>         ..
> }
>
> If yes, why the comparison in ignore_dl_rate_limit() is still correct then?
>
>         if (cpu_bw_dl(cpu_rq(sg_cpu->cpu)) > sg_cpu->bw_min)

yes, this is to ensure enough performance for the deadline task when
the dl bandwidth increases without waiting the rate limit period which
would prevent the system from providing enough bandwidth to the
deadline scheduler. This remains true because it's still at least
above cpu_bw_dl()

>
> And does cpufreq_driver_adjust_perf() still need the sg_cpu->bw_min arg
> actually? sg_cpu->util already calculated based on sugov_effective_cpu_perf()
> which takes all constraints (including bw_min) into account.

cpufreq_driver_adjust_perf() is used for systems on which you can't
actually set an operating frequency but only a min and a desired
performance level and let the hw move freely in this range.

>
>
> Thanks!
>
> --
> Qais Yousef
