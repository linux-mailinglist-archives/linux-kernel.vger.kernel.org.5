Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C177CB187
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjJPRrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjJPRrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:47:10 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A8E83
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:47:08 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4053f24c900so6825e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 10:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697478427; x=1698083227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xN55i1kf8SjBRE46kpjO4DGTzynTOBj6XWdNf2f6doE=;
        b=LWaVHx4jK1rjOw4Bh8F9BIQl927FzeTgk9p+K0S+j4fbCet51Xjvx4oMzhOePN2ZzC
         rMLofrIf8Da2OHT883ofypEMxO11EnaSfSTY1/17qojQKm8OIffFgMC2bIU2Ap3773Fd
         Kp48PJevbwcU7/WCbYoMt6z1UcO9Gds9vgFLq7QuL3PCtO1Ls3PIRLWW9DnsXHBCRZQa
         /ppl1rSJfT7HUYUm9aKGuN5vWgMV1+t0WSq+9sJ2UxLKaglm4qm9fO+WFsBHdPBKs37p
         qu+nQObrFzSmxTxnuKqhFQv4IZzc8ERuzQ13GjkdU3JhIPYOkO/mGjoelByMTbAqBjBV
         rznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697478427; x=1698083227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xN55i1kf8SjBRE46kpjO4DGTzynTOBj6XWdNf2f6doE=;
        b=hXLv5bcvnAPYNfpPH/j2XaLmo+2Vwa3uTzuOAzS5SZP3xlMQz+cpSHdCt+BwR9WX1i
         VmHDlyC9YNB03WZwiF4vtybaWqhR7g5LUg9amFhgpM5XfZlwnzRRpF88ytOYc+PgrQ7N
         +LV+DY9uFAWet8GLfdOXhk1SJ12ksewBYcmO4O81xRXu9M1rm3wzBY3675kgezWVtmve
         JS0NIDjMvd9DLhpOnwLYM3n6OGOf+WSAygeIMLpwLlAjSHtpeZ0g0yEri9FXg20UoUve
         p1yiQK+pGe0EsW/K5jQ/1G8KvqftgvVuWOM5pOeUctal7tWW2itZEfJB2FqEx4GbgNPH
         ltUw==
X-Gm-Message-State: AOJu0YwOko0QyahngJiKPRGPBHjUF4+iNnQWb7QJE6xuCTlX8kDF5RSk
        gqjtqXqaH5cKo9Av0rG/vlHBCqarln/3dMNnuBCYU6ike5boeHFbjg==
X-Google-Smtp-Source: AGHT+IEzXOYbJIuYr+z67fbZYutG7uA7/CpHEhsGZm7vd4L1Az6irbcslZcnFnzhfbpaPdn5UyGyDVO/oMYj6UUONnI=
X-Received: by 2002:a05:600c:510d:b0:404:74f8:f47c with SMTP id
 o13-20020a05600c510d00b0040474f8f47cmr199432wms.5.1697478426920; Mon, 16 Oct
 2023 10:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <80ff5036-8449-44a6-ba2f-0130d3be6b57@I-love.SAKURA.ne.jp>
In-Reply-To: <80ff5036-8449-44a6-ba2f-0130d3be6b57@I-love.SAKURA.ne.jp>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 16 Oct 2023 10:46:52 -0700
Message-ID: <CANDhNCpw+hEHNbtdAZR01HsHW_L1C0BXjZq21eXouQGNnYuUNQ@mail.gmail.com>
Subject: Re: [PATCH] clocksource: disable irq when holding watchdog_lock.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 7:51=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Lockdep found that spin_lock(&watchdog_lock) from call_timer_fn()
> is not safe. Use spin_lock_irqsave(&watchdog_lock, flags) instead.
>
> [    0.378387] TSC synchronization [CPU#0 -> CPU#1]:
> [    0.378387] Measured 55060 cycles TSC warp between CPUs, turning off T=
SC clock.
> [    0.378387] tsc: Marking TSC unstable due to check_tsc_sync_source fai=
led
> [    0.926101]
> [    0.926387] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    0.926387] WARNING: inconsistent lock state
> [    0.926387] 6.6.0-rc5-00192-g10a6e5feccb8 #2 Not tainted
> [    0.926387] --------------------------------
> [    0.926387] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> [    0.926387] swapper/0/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
> [    0.926387] ffffffff8cfa1c78 (watchdog_lock){?.-.}-{2:2}, at: clocksou=
rce_watchdog+0x23/0x5a0
> [    0.926387] {IN-HARDIRQ-W} state was registered at:
> [    0.926387]   lock_acquire+0xc1/0x2c0
> [    0.926387]   _raw_spin_lock_irqsave+0x3f/0x60
> [    0.926387]   clocksource_mark_unstable+0x1b/0x90
> [    0.926387]   mark_tsc_unstable+0x41/0x50
> [    0.926387]   check_tsc_sync_source+0x14f/0x180
> [    0.926387]   __flush_smp_call_function_queue+0x16f/0x560
> [    0.926387]   __sysvec_call_function_single+0x36/0x110
> [    0.926387]   sysvec_call_function_single+0x69/0x90
> [    0.926387]   asm_sysvec_call_function_single+0x1a/0x20
> [    0.926387]   default_idle+0xf/0x20
> [    0.926387]   default_idle_call+0x7f/0x180
> [    0.926387]   do_idle+0x1e1/0x220
> [    0.926387]   cpu_startup_entry+0x2a/0x30
> [    0.926387]   rest_init+0xf4/0x190
> [    0.926387]   arch_call_rest_init+0xe/0x30
> [    0.926387]   start_kernel+0x763/0x910
> [    0.926387]   x86_64_start_reservations+0x18/0x30
> [    0.926387]   x86_64_start_kernel+0xca/0xe0
> [    0.926387]   secondary_startup_64_no_verify+0x178/0x17b
> [    0.926387] irq event stamp: 138774
> [    0.926387] hardirqs last  enabled at (138774): [<ffffffff8bb99968>] _=
raw_spin_unlock_irq+0x28/0x50
> [    0.926387] hardirqs last disabled at (138773): [<ffffffff8bb99687>] _=
raw_spin_lock_irq+0x47/0x50
> [    0.926387] softirqs last  enabled at (138216): [<ffffffff8b0904ff>] i=
rq_exit_rcu+0x7f/0xa0
> [    0.926387] softirqs last disabled at (138267): [<ffffffff8b0904ff>] i=
rq_exit_rcu+0x7f/0xa0
> [    0.926387]
> [    0.926387] other info that might help us debug this:
> [    0.926387]  Possible unsafe locking scenario:
> [    0.926387]
> [    0.926387]        CPU0
> [    0.926387]        ----
> [    0.926387]   lock(watchdog_lock);
> [    0.926387]   <Interrupt>
> [    0.926387]     lock(watchdog_lock);
> [    0.926387]
> [    0.926387]  *** DEADLOCK ***
...
>
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index c108ed8a9804..4e8fc0a5ca9d 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -405,8 +405,9 @@ static void clocksource_watchdog(struct timer_list *u=
nused)
>         enum wd_read_status read_ret;
>         unsigned long extra_wait =3D 0;
>         u32 md;
> +       unsigned long flags;
>
> -       spin_lock(&watchdog_lock);
> +       spin_lock_irqsave(&watchdog_lock, flags);
>         if (!watchdog_running)
>                 goto out;
>
> @@ -554,7 +555,7 @@ static void clocksource_watchdog(struct timer_list *u=
nused)
>                 add_timer_on(&watchdog_timer, next_cpu);
>         }
>  out:
> -       spin_unlock(&watchdog_lock);
> +       spin_unlock_irqrestore(&watchdog_lock, flags);
>  }
>
>  static inline void clocksource_start_watchdog(void)
> --

Hey! Thank you for the report and the patch!

At first glance this looks sane to me.  The only thing that gives me
pause is that I'm a little shocked this hasn't been caught earlier,
and I don't right off see recent changes that would have caused this
to trip. But Thomas may have more insight.

Tentatively:
Acked-by: John Stultz <jstultz@google.com>

thanks
-john
