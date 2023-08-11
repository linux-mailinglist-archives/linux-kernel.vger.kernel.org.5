Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935EE77965B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbjHKRnX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Aug 2023 13:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236465AbjHKRnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:43:22 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6768CA8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:43:22 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1bb5dda9fb7so347748fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691775801; x=1692380601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qjKDwKhm1XLumzhcIydZ94elWnAZICybaZxFODVHuc=;
        b=QZQvpYH0T30zS1iYMpeIjnn66ff7132ss0X4YoyqP12RrmvqdLCRj0TRcfQlUyfSfE
         P5xi6Xc6yZQ3IfwAjcDd0jCN9h9l+c53bi3Rllsw/F3EmtoX8kpnL3bqpy85GvOn7278
         0nmSbZyQCM7ApbJ9ZRwWaYh0tjO22JcAAyx9HCaMYrGaitB2AMfWaeVhtnD/5tX+oe8I
         I4nE6QBv+1dvufXQdxYgfKoA/rllBsdMsFdRdyou7BvNFtlKWg4FprQk2XIWquViqr8l
         5Gm2pFwQ5mc3kvXOxUhQYwo12KrsjoRWDftwq4ChrJFmZvJIdAJtx64fHlpTkxG03UdQ
         JmFg==
X-Gm-Message-State: AOJu0YyluNsvSlLSc9haHK1V5xPMPYC3od9TqNIapU4kdiywsiJHB8Lu
        N1ln4lBTzqETicVtMzfGvyNuEuhOOuR9snX2Lr9d57PKDD0=
X-Google-Smtp-Source: AGHT+IGN8D4su+YaDs07PUWVflOkWE9aQ8FluXs+eUelDnXmyZmNtgXVo/futx2G/nRXgZWe/gm6yI+VPJfbJEeGUNI=
X-Received: by 2002:a05:6820:2018:b0:56d:6bd4:4db5 with SMTP id
 by24-20020a056820201800b0056d6bd44db5mr2053168oob.0.1691775801542; Fri, 11
 Aug 2023 10:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230811170049.308866-1-frederic@kernel.org> <20230811170049.308866-11-frederic@kernel.org>
In-Reply-To: <20230811170049.308866-11-frederic@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Aug 2023 19:43:10 +0200
Message-ID: <CAJZ5v0jiUVu3C0AkUAK9B8+0Lu8nrQ=xzHC6r1cxBLHdmBY-sA@mail.gmail.com>
Subject: Re: [PATCH 10/10] sched/timers: Explain why idle task schedules out
 on remote timer enqueue
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 7:01 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> Trying to avoid that didn't bring much value after testing, add comment
> about this.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  kernel/sched/core.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c52c2eba7c73..e53b892167ad 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1135,6 +1135,28 @@ static void wake_up_idle_cpu(int cpu)
>         if (cpu == smp_processor_id())
>                 return;
>
> +       /*
> +        * Set TIF_NEED_RESCHED and send an IPI if in the non-polling
> +        * part of the idle loop. This forces an exit from the idle loop
> +        * and a round trip to schedule(). Now this could be optimized
> +        * because a simple new idle loop iteration is enough to
> +        * re-evaluate the next tick. Provided some re-ordering of tick
> +        * nohz functions that would need to follow TIF_NR_POLLING
> +        * clearing:
> +        *
> +        * - On most archs, a simple fetch_or on ti::flags with a
> +        *   "0" value would be enough to know if an IPI needs to be sent.
> +        *
> +        * - x86 needs to perform a last need_resched() check between
> +        *   monitor and mwait which doesn't take timers into account.
> +        *   There a dedicated TIF_TIMER flag would be required to
> +        *   fetch_or here and be checked along with TIF_NEED_RESCHED
> +        *   before mwait().
> +        *
> +        * However, remote timer enqueue is not such a frequent event
> +        * and testing of the above solutions didn't appear to report
> +        * much benefits.
> +        */
>         if (set_nr_and_not_polling(rq->idle))
>                 smp_send_reschedule(cpu);
>         else
> --
> 2.34.1
>
