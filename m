Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC42E7DF307
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376372AbjKBM7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKBM7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:59:06 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5430F121
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 05:58:58 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b497c8575aso958570b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 05:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698929938; x=1699534738; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nda+509MTdCcAVWnvqFmQxdRWuc9tM4Iop32+RA3uJI=;
        b=RmcStXAWix7qlknAkqx5yQFYCAJVukqqHWjujWeya71mEuNsb5KxZRSS6wnLFy6QYr
         OGEfTOjvyjOISMhyd1Qa1nBUrt4q3M6UzSHcvMEjuMEQAG5QS2g1NXJlTetEX22Uh1+q
         s5q9q/WweykMqTJGu6dsFii1SpCkY32z0d35A5YVXtYcWG8TjSn/YX99GAiUixIb/lhj
         BN/1ibxP0K7yCzQRmNyQzCoJycAz0Eah6NqwTYzU9JQYzHy+GTf4dVfQ7+SN3hFcnQEP
         qpY34sqA0E2rw5HUHRf6hhGa5RoXBv9bM2dkSndKvV4NvMXp5b1FKc2sTWQXHUYa1FBJ
         u1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698929938; x=1699534738;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nda+509MTdCcAVWnvqFmQxdRWuc9tM4Iop32+RA3uJI=;
        b=J1rqx/RnChaVkT/vaFt+WU3R5BOK68ivP/GKyjSnyTYG2hmCjgwNuBxx0meLC5Skit
         6xsjXCCIh4YHukPjmqIUsNo7YgCyXfhkyxSjQjLfKUmg43jVBKDiJqZ50ewzkhWjJaZZ
         6igeO5yGLRvzvbQB8NV/l076tCOrRrzn7/aqMLjtbhsa8Fz6Vp3vlhPDA1vfnlTnxnkb
         KRGBnyIQ500YOoM6vaoIXvw9AZpzcoFw9rhMYRqyBWEbqBKV5VKvqbg3R460KG4mBvon
         Ts8GUh24sjgiHyrIwb7WWcH5E4kmPxITA0fODkL4BESysECkBJ2WFpsrPWLiMLTcReeS
         MkTA==
X-Gm-Message-State: AOJu0YzcI5Js32R53XfQKemgFncXsJzF5IoUtnbdSdWdtPb6Yc+zmWBh
        jhUbVluIZxQETqyuU5IOPsecJcokz4/IcrNA/CRolw==
X-Google-Smtp-Source: AGHT+IGcERc9A5+LQJd0yCaWrk5coa9BWF3xAQl9PA2emohs1RVO0PyRtm3wTujla4WbJcSj/gYbaELHViLae3BeBtU=
X-Received: by 2002:a05:6a20:7d88:b0:16b:8067:23a7 with SMTP id
 v8-20020a056a207d8800b0016b806723a7mr23055795pzj.24.1698929937710; Thu, 02
 Nov 2023 05:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231026170913.32605-1-vincent.guittot@linaro.org>
 <20231026170913.32605-2-vincent.guittot@linaro.org> <c9e89355-9503-4623-9320-e4a4f57dcd98@arm.com>
In-Reply-To: <c9e89355-9503-4623-9320-e4a4f57dcd98@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 2 Nov 2023 13:58:46 +0100
Message-ID: <CAKfTPtDB50ytNap_XhiNtopZ8KLMVvJEspaEfsTOXS_TPKtkaA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sched/schedutil: rework performance estimation
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, rafael@kernel.org,
        viresh.kumar@linaro.org, qyousef@layalina.io,
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

On Thu, 2 Nov 2023 at 13:03, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 26/10/2023 19:09, Vincent Guittot wrote:
>
> [...]
>
> > @@ -153,14 +152,38 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
> >       return cpufreq_driver_resolve_freq(policy, freq);
> >  }
> >
> > +unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
> > +                              unsigned long min,
> > +                              unsigned long max)
> > +{
> > +     unsigned long target;
> > +     struct rq *rq = cpu_rq(cpu);
> > +
> > +     if (rt_rq_is_runnable(&rq->rt))
> > +             return max;
> > +
> > +     /* Provide at least enough capacity for DL + IRQ */
> > +     target = min;
> > +
> > +     actual = map_util_perf(actual);
> > +     /* Actually we don't need to target the max performance */
> > +     if (actual < max)
> > +             max = actual;
> > +
> > +     /*
> > +      * Ensure at least minimum performance while providing more compute
> > +      * capacity when possible.
> > +      */
> > +     return max(target, max);
>
> The superfluous `unsigned long target` is still there?

Yeah, I forgot to add the change in this version but it's in the next one

>
>   return max(min, max) is much cleaer.
>
> [...]
