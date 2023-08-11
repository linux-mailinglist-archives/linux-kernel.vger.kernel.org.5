Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C08779644
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbjHKRix convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Aug 2023 13:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbjHKRiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:38:52 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632CE2702
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:38:52 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-563393b63dbso401249eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691775531; x=1692380331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOz2Avs/xN8opbHhoo+tfL7BntbOnnbAXk1ephhrlus=;
        b=ccZoYb5yJXMhEjJVfWh9S5gh6LQ5/nw+YpLreKXVjDTFrnwiWZcDi2UtdKLunETIC2
         lq62gqyMHGOWXvcvIDu58EQFqUnV5Er1hmi/TYP1BZWDyucFaM/EYzA7HRZ3aK7q2HZn
         cnh+pQL9jMFWBq1Q34PwoEPgPHf3rGyzqOS5IRklMpFNHEf78BWusMf+xlPkjSLYODtn
         UqtjRT9QRfp2HN3fy3PAKpunBhAzuhOqFX0gwVpqc8jjz6Yir4PBgYfYyyUiJCZxefKt
         qappXK8uhPHUeLtYsEK2pq9yRFovbmqEt0LhqjlzGc/CSG12zpBqychU8luU5Iarl9A6
         3TJw==
X-Gm-Message-State: AOJu0YzcUUTzwOsiLFJ1RBvanFAXUCZkrHoS0gZlPMRBi6kj/26e+U6B
        2+NjFmsgRlH9aBBfAqxB3pUdjTD2Ux5l9bSP5KE=
X-Google-Smtp-Source: AGHT+IFTDVoHWmmLu9nrqitY91LjbZrBEqO3tLDXg1hAV65/gjUxzzKmL2kzZ/N47j8DBxgnIcD4i9rp3OB1FvlcgPU=
X-Received: by 2002:a4a:e04e:0:b0:569:a08a:d9c5 with SMTP id
 v14-20020a4ae04e000000b00569a08ad9c5mr2108110oos.0.1691775531587; Fri, 11 Aug
 2023 10:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230811170049.308866-1-frederic@kernel.org> <20230811170049.308866-6-frederic@kernel.org>
In-Reply-To: <20230811170049.308866-6-frederic@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Aug 2023 19:38:40 +0200
Message-ID: <CAJZ5v0gD72w=LSXWT1Mioag7jBD2LBt5ExSt-tfubfP7gzW4UA@mail.gmail.com>
Subject: Re: [PATCH 05/10] cpuidle: Comment about timers requirements VS idle handler
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
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  kernel/sched/idle.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 342f58a329f5..d52f6e3e3854 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -258,6 +258,36 @@ static void do_idle(void)
>         while (!need_resched()) {
>                 rmb();
>
> +               /*
> +                * Interrupts shouldn't be re-enabled from that point on until
> +                * the CPU sleeping instruction is reached. Otherwise an interrupt
> +                * may fire and queue a timer that would be ignored until the CPU
> +                * wakes from the sleeping instruction. And testing need_resched()
> +                * doesn't tell about pending needed timer reprogram.
> +                *
> +                * Several cases to consider:
> +                *
> +                * - SLEEP-UNTIL-PENDING-INTERRUPT based instructions such as
> +                *   "wfi" or "mwait" are fine because they can be entered with
> +                *   interrupt disabled.
> +                *
> +                * - sti;mwait() couple is fine because the interrupts are
> +                *   re-enabled only upon the execution of mwait, leaving no gap
> +                *   in-between.
> +                *
> +                * - ROLLBACK based idle handlers with the sleeping instruction
> +                *   called with interrupts enabled are NOT fine. In this scheme
> +                *   when the interrupt detects it has interrupted an idle handler,
> +                *   it rolls back to its beginning which performs the
> +                *   need_resched() check before re-executing the sleeping
> +                *   instruction. This can leak a pending needed timer reprogram.
> +                *   If such a scheme is really mandatory due to the lack of an
> +                *   appropriate CPU sleeping instruction, then a FAST-FORWARD
> +                *   must instead be applied: when the interrupt detects it has
> +                *   interrupted an idle handler, it must resume to the end of
> +                *   this idle handler so that the generic idle loop is iterated
> +                *   again to reprogram the tick.
> +                */
>                 local_irq_disable();
>
>                 if (cpu_is_offline(cpu)) {
> --
> 2.34.1
>
