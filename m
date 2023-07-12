Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24C0751290
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 23:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjGLVVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 17:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbjGLVVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:21:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17391FF7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 14:21:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so76750215e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 14:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689196868; x=1691788868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tZTUnI6d8S8lOCvLIZaV/WnDbZOnjxlpdLIn7J7T5Ws=;
        b=riVOxBRsNlbit4Y503zwT+PkVQPKGT/R2DE0Ewx9khEJPZrhlAKOZKDrQOUSfw1Cpd
         FjziADc8hAjUgHBvF3g18IW0jau1z9D/EJxtH9rWZiJVC3mL7PVmHS+GKfsIY8OQO8RW
         sQt9fkLpMyKgk8utotrNJjM84rCa0Zz8GcEqKhFTJPIlKgoLY09856Cu4Y7288qQZils
         nCWHVmCPjm2nzvydu5jBuaZB9oL1tuEP+i0FqezV9AwoYDoElW1VogVbj2cZZvb6Rq/C
         TozA28S0bwWVhE8m5Qx4F9rhIHR+Amb8eas94sO7h08yeNW10vPOZQ9cENTT9C07EOWm
         rg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689196868; x=1691788868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZTUnI6d8S8lOCvLIZaV/WnDbZOnjxlpdLIn7J7T5Ws=;
        b=mI8Os9r6pXKP6IYsb82EW20+kKCY/RvlMY6WGZKgUt3Yfqz44zos51Eu9LUJOKFnW1
         lWCZUnUl208QpMRLh0bY+E6Xvw+LY8iFjikVEl6admSWaZYCQKSuOvGPeu/4Yqk7c4BC
         busvFCuf5gZwd39OQgwHPJGNPenk8rPom+ga0sgVc4hyZCArPTMruen3DNT6gitbpXGo
         9uqOdB82Jh2TJv7TBdv7I412H1R9uGEonVHjPcXRKOSdn2/Yh3haeqe4zjcg6xq5TFZJ
         mJetbf0jAcThQOmHzpmrAHjFEIFzE2UjQ38N4XQh2jzstBdlwlKTlew6rGN88rya7DVW
         Uy5A==
X-Gm-Message-State: ABy/qLaqJgqR8aNhp1eFMrIrIIGK36OrRpmKBMvrnn7jfWIOzMYwTjIu
        d8zpD3bYBZN6Wu04FEvff/n8K0Z+Kn+9whyTT4sqkQ==
X-Google-Smtp-Source: APBJJlF02gY8bEC0+lYROMVW41NJjfAkJDC91HvoX0ewa2c+XazwQOw0ZGwvXcadoBMYjI5IXT+IOvbvZzU0knL3QpU=
X-Received: by 2002:a05:600c:2295:b0:3f8:facf:7626 with SMTP id
 21-20020a05600c229500b003f8facf7626mr17690397wmf.20.1689196867941; Wed, 12
 Jul 2023 14:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230711233816.2187577-1-dhavale@google.com> <CAEXW_YQvpiFEaaNoS=Msgi17mU3kZD+q8bNBaHYasMArG9aPig@mail.gmail.com>
In-Reply-To: <CAEXW_YQvpiFEaaNoS=Msgi17mU3kZD+q8bNBaHYasMArG9aPig@mail.gmail.com>
From:   Sandeep Dhavale <dhavale@google.com>
Date:   Wed, 12 Jul 2023 14:20:56 -0700
Message-ID: <CAB=BE-Rm0ycTZXj=wHW_FBCCKbswG+dh3L+o1+CUW=Pg_oWnyw@mail.gmail.com>
Subject: Re: [PATCH v1] rcu: Fix and improve RCU read lock checks when !CONFIG_DEBUG_LOCK_ALLOC
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org,
        Will Shiu <Will.Shiu@mediatek.com>, kernel-team@android.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Joel,
Thank you for the review!
> Actually even the original code is incorrect (the lockdep version)
> since preemptible() cannot be relied upon if CONFIG_PREEMPT_COUNT is
> not set. However, that's debug code. In this case, it is a real
> user (the fs code). In non-preemptible kernels, we are always in an
> RCU-sched section. So you can't really see if anyone called your code
> under rcu_read_lock(). The rcu_read_lock/unlock() would be getting
> NOOPed. In such a kernel, it will always tell your code it is in an
> RCU reader. That's not ideal for that erofs code?
>
> Also, per that erofs code:
>         /* Use (kthread_)work and sync decompression for atomic contexts only */
>         if (!in_task() || irqs_disabled() || rcu_read_lock_any_held()) {
>
> I guess you are also assuming that rcu_read_lock_any_held() tells you
> something about atomicity but strictly speaking, it doesn't because
> preemptible RCU readers are preemptible. You can't block but
> preemption is possible so it is not "atomic". Maybe you meant "cannot
> block"?
>
Yes, you are correct. For decompression erofs needs to grab pcluster mutex lock,
erofs wants to know if we can or cannot block to decide sync vs async
decompression.

Good point about !CONFIG_PREEMPT_COUNT. Yes, in that case erofs
will always do async decompression which is less than ideal. Maybe
erofs check can be modified to account for !CONFIG_PREEMPT_COUNT.

> As such this patch looks correct to me, one thing I noticed is that
> you can check rcu_is_watching() like the lockdep-enabled code does.
> That will tell you also if a reader-section is possible because in
> extended-quiescent-states, RCU readers should be non-existent or
> that's a bug.
>
Please correct me if I am wrong, reading from the comment in
kernel/rcu/update.c rcu_read_lock_held_common()
..
  * The reason for this is that RCU ignores CPUs that are
 * in such a section, considering these as in extended quiescent state,
 * so such a CPU is effectively never in an RCU read-side critical section
 * regardless of what RCU primitives it invokes.

It seems rcu will treat this as lock not held rather than a fact that
lock is not held. Is my understanding correct?
The reason I chose not to consult rcu_is_watching() in this version
is because check "sleeping function called from invalid context"
will still get triggered (please see kernel/sched/core.c __might_resched())
as it does not consult rcu_is_watching() instead looks at
rcu_preempt_depth() which will be non-zero if rcu_read_lock()
was called (only when CONFIG_PREEMPT_RCU is enabled).

> Could you also verify that this patch does not cause bloating of the
> kernel if lockdep is disabled?
>
Sure, I will do the comparison and send the details.

Thanks,
Sandeep.

> thanks,
>
>  - Joel
