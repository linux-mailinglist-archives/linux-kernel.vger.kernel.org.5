Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEA37DB4BF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjJ3IF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjJ3IF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:05:26 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F8FB7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:05:20 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6bb4abb8100so3674372b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698653120; x=1699257920; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=srma/SglYHbbGTJhMGvbCnTLsrQERoNryEVxhNzJCgU=;
        b=gaScPf+FKVUJT//BGycFN5lurXyKB6u7VEFpRKD6fv+jEMRYXSfG5n3QalrYsebKlg
         pVCmjBEji1l7wPf8qVQaP7v/2/Rbk69BQyMkpoAYNAoOeUlCS2QsHogyzaKmav7q2kS2
         134Y9bkx10YIbP9P6WUs06pH/CH2NaUewQSveuKogleROW5devg25ytd01jhTy3BYUx1
         2KyYglGYD+2sN4NbFDIIJuaatAVpNvBhH7zdGAEgbTVH/E/BVd346ITGjWxIwee9hch/
         ockvdF1vogkY8ByvXQVe5xVLhj2iIXCKUbE+TfU0roP9olLFYLBUMuNF33yRe/o9FQ1g
         xVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698653120; x=1699257920;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=srma/SglYHbbGTJhMGvbCnTLsrQERoNryEVxhNzJCgU=;
        b=tW4usPMaX3I7WfMMCDlSbnU9F7EUHrXiX3AlsCIUPoyKTCMRCRigopXNEvzHX89FX4
         TZEsfYTK2OFgDCJ5wnRsn4RxtoPSOWFtff6PIqgSmaoamBdJlgPtS7BwEcmk6NFOFwDW
         pAP1HF2WhyvrQ4CxNwbZyYoe5jBm7uW/OEYlL099mDuaCAjNd++LpQAnbU7XKQdc1W8g
         XBApoROlms2KJ/uM/8EK+MnnWxmf6QbA63ZHpH7Sf+W+CANKuOdnH+Qe/z08rgmOFMrF
         BjESStJbn66JHbfzBAdRZXqrcBYthFmDFFsf+4FH5hAnUoCLqN5MUq0oEujNwg7lYaBA
         /k1w==
X-Gm-Message-State: AOJu0Yy3H9lWetSm1Xpl+tr5nvCZIxqpmlpQ76LreSnpdLKj3tjrqk0e
        8HGSOMW8ot+Te7ZbLfr0o8vDwm0SdpiLez5O4x448cKK8yuUmrG2
X-Google-Smtp-Source: AGHT+IHvXWD8GtV0Jw0JE8AyM+vrLeI9ZILiFFGX9zSwtL2y1d6r+R7wuYfYkKSXVXnNa3knjWeUOnDnntKVWooEq7Q=
X-Received: by 2002:a05:6a00:93aa:b0:6be:bf7:fda5 with SMTP id
 ka42-20020a056a0093aa00b006be0bf7fda5mr7891513pfb.12.1698653119271; Mon, 30
 Oct 2023 01:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231027171742.1426070-1-keisuke.nishimura@inria.fr> <27d88cac-95d2-4861-b79c-410e3cfd96a9@linux.vnet.ibm.com>
In-Reply-To: <27d88cac-95d2-4861-b79c-410e3cfd96a9@linux.vnet.ibm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 30 Oct 2023 09:05:08 +0100
Message-ID: <CAKfTPtC=H4P_Hn7koJfWwfqVc7UyWNzzyrFWymnoYVK3pJkiDQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix the decision for load balance
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     Keisuke Nishimura <keisuke.nishimura@inria.fr>,
        linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 at 05:03, Shrikanth Hegde
<sshegde@linux.vnet.ibm.com> wrote:
>
>
>
> On 10/27/23 10:47 PM, Keisuke Nishimura wrote:
> > should_we_balance is called for the decision to do load-balancing.
> > When sched ticks invoke this function, only one CPU should return
> > true. However, in the current code, two CPUs can return true. The
> > following situation, where b means busy and i means idle, is an
> > example because CPU 0 and CPU 2 return true.
> >
> >         [0, 1] [2, 3]
> >          b  b   i  b
> >
> > This fix checks if there exists an idle CPU with busy sibling(s)
> > after looking for a CPU on an idle core. If some idle CPUs with busy
> > siblings are found, just the first one should do load-balancing.
> >
>
> > Fixes: b1bfeab9b002 ("sched/fair: Consider the idle state of the whole core for load balance")
> > Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
> > ---
> >  kernel/sched/fair.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 2048138ce54b..eff0316d6c7d 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -11083,8 +11083,9 @@ static int should_we_balance(struct lb_env *env)
> >               return cpu == env->dst_cpu;
> >       }
> >
>
>
> There is comment above this /* Are we the first idle CPU? */
> Maybe update that comment as /* Are we the first idle core */

I was about to say the same but it's not always true. If we are at SMT
level, we look for an idle CPU in the core

>
> > -     if (idle_smt == env->dst_cpu)
> > -             return true;
> > +     /* Is there an idle CPU with busy siblings? */
> nit: We can keep the comment style fixed in this function.
> /* Are we the first idle CPU with busy siblings */
>
> > +     if (idle_smt != -1)
> > +             return idle_smt == env->dst_cpu;
> >
> >       /* Are we the first CPU of this group ? */
> >       return group_balance_cpu(sg) == env->dst_cpu;
>
> code changes LGTM
> Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
