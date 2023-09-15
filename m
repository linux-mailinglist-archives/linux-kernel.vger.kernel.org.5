Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2D57A1FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 15:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbjIONUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 09:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235214AbjIONUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:20:43 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59583171C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:20:37 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68fbbb953cfso1815908b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 06:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694784037; x=1695388837; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BaoDBq4J2WQTMoM6JUbluW9HfoAxhmWc40Mme5H8iVo=;
        b=qLTmk4z/j8Rgs/Y/z2xJvzcsFsNxWeJOcBgx6EzfgdXtYFhjvYc1hOll2SgfQju6hx
         FgDryovX7syL8CribAbv0S9MDeEy5/kMtIkSu1dRg9pt4dwkMcVkf6KIj/VWGPzM5bpJ
         0BK/jhU5uTp93B1++arpeX59XGctwvJ6I6/dlLn8Ent9zZwW7gytH1wZp6XHIcH8yKyC
         FM4LxqHYYdJw9449tkRjM3yJErElZzQkvm13U6QCkBJArI5ELvATd/dYX4WBjg17acJy
         Xz4kBWrLZ9d1FglMgTJ/wlFKAle8p6m9sdCf5a8cZ7USlke3nAo1QvlxNgicV7o1uDWy
         Ejeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694784037; x=1695388837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BaoDBq4J2WQTMoM6JUbluW9HfoAxhmWc40Mme5H8iVo=;
        b=pi7wyZW0HsxVe6wnLjlsEv/FNoIjlBJBZZ2nwtbwJfvE959hPQtXgC9XGp8XH14BZS
         S6SjwhxoTMDQ66vetFDnlE5vjeNr7q9fhY0BcaBjq5VEbu8eXyGsGxGAwrVXqI6uW3Gt
         HNtDUZbT/wdXNaMQzvqViZL0iD1Tisdu4GmvtqkDzGo3MZG81XYl+kd3l0S2nQvEqf39
         3Mg7xjFsqb6n+dOdlRo++QYISBy6z364ls6vbq2qFs4tOgW+poFDMHLJ/NnRmCzaYp2k
         cDgMjtE0dwpPJ6xxHnKIN7VOTCIsZaQI8oOvcJO3FTvoeWLLXZboKlPx6u4DpDfunzs9
         btag==
X-Gm-Message-State: AOJu0YxxfuT6+YevD85bCaI1rsDaO9paMV9Bg69O7Gj0YIIKviaOYf2Z
        m6xwQfHaE1iQojzZU4daONPfpFW5UmYnBs7Xng0oug==
X-Google-Smtp-Source: AGHT+IEvUA9BR5BcrVOwtToL5WSZnMVL5hq1LhRR/C2UP2bV5CCmF6GnSfYb0YjLTzwW2flky6W/bE61lpkBlQ/Gnuc=
X-Received: by 2002:a17:90a:4b06:b0:26f:2c5a:bbb3 with SMTP id
 g6-20020a17090a4b0600b0026f2c5abbb3mr1316852pjh.40.1694784036728; Fri, 15 Sep
 2023 06:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230901130312.247719-1-vincent.guittot@linaro.org>
 <20230901130312.247719-2-vincent.guittot@linaro.org> <be527eb1-d253-b9fe-ecc9-4c7b04da9efd@arm.com>
In-Reply-To: <be527eb1-d253-b9fe-ecc9-4c7b04da9efd@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 15 Sep 2023 15:20:25 +0200
Message-ID: <CAKfTPtANMnLAdw9y86zsx_HdjpWxQPA+Gnaa=qvXC+4xWwNa=A@mail.gmail.com>
Subject: Re: [PATCH 1/4] sched: consolidate and cleanup access to CPU's max
 compute capacity
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sept 2023 at 22:46, Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 01/09/2023 15:03, Vincent Guittot wrote:
> > Remove struct rq cpu_capacity_orig field and use arch_scale_cpu_capacity()
> > instead.
> >
> > Scheduler uses 3 methods to get access to the CPU's max compute capacity:
> > - arch_scale_cpu_capacity(cpu) which is the default way to get CPU's capacity.
> > - cpu_capacity_orig field which is periodically updated with
> >   arch_scale_cpu_capacity().
> > - capacity_orig_of(cpu) which encapsulates rq->cpu_capacity_orig
> >
> > There is no real need to save the value returned by arch_scale_cpu_capacity()
> > in struct rq. arch_scale_cpu_capacity() returns:
> > - either a per_cpu variable.
> > - or a const value for systems which have only one capacity.
> >
> > Remove cpu_capacity_orig and use arch_scale_cpu_capacity() everywhere.
> >
> > No functional changes.
> >
> > some tests of Arm64:
> > small SMP device (hikey): no noticeable changes
> > HMP device (RB5): hackbench shows minor improvement (1-2%)
> > large smp (thx2): hackbench and tbench shows minor improvement (1%)
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> Next to util_fits_cpu() which uses capacity_orig as a local variable
> (which is fine) there is sis() referring to capacity_orig in a comment.
>
> Documentation/scheduler/sched-capacity.rst uses the term `capacity_orig`
> in chapter 1.2 to explain the difference between CPU's maximum
> (attainable) capacity and capacity as the former reduced by pressure.

ok, I will have a look at those references to capacity_orig

>
> Not sure if you want to change those refs as well with this patch?
> People might get confused about the term `capacity_orig` pretty soon.
>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Thanks
