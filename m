Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282BF7E05C0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343711AbjKCPu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjKCPu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:50:27 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F6AD42;
        Fri,  3 Nov 2023 08:50:21 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-577fff1cae6so1687658a12.1;
        Fri, 03 Nov 2023 08:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699026621; x=1699631421; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BaNnhExhXqBhrTN7yK+po2SwafRClXBbdL/ApScP9S8=;
        b=EX0jaWlg8KacerpBR+vej2/QjNVaJdVaIK/gLUm2BWuPWuO7yqV+Wz1NgKTRWBtlKd
         gTI1hduPM45+Oq4QVO0YT2BQsBYiLhaWodyz9YqcY1QVt25kPfvxMz1eV5k+iuZXFVof
         K4O+ecb5qec1TBPiq8700AYHsX0cqEd6JDiWY890Y83gUwcYCQFwnQP+kAMO0bPfNdB9
         OdY9oLpQzKCh5ypW+tkYrWbYQo+GSu/xgmYba3/x+QQivOlnzqhxOczJ+H4AVxdiTjV9
         2I+kzZeiCkFtLX9+JfZxAmq2ob0BT9kTzO3zo5zSUtFWmnEKsSHP9bOIfXl7v61gqA3e
         7/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699026621; x=1699631421;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BaNnhExhXqBhrTN7yK+po2SwafRClXBbdL/ApScP9S8=;
        b=BYiWgSOaJrxoG15UXs/bmh3s5anI4IaCyyCPnFGtHq7iQySqRw9S108aoCqyTzHRxz
         aU0YrJ/80mKJt6FjMzvaUM+OxLINZGT1BpbTsaJx3V6GE49J9PbITwnFDb13v5+A86ou
         KMYM7+3BGNFbjyALTY1Bcfu0PARaMKtiBEhoOH7om3EHYHPPbJfA+G2J/B4W75VVNxJZ
         deNcqsDO6BaiTFH02GPntY3W4H8EWtJEDdFxEBVCfBr4GElOQZGj+3JAe1Pfy0VWEXqz
         IdBCl0hTJEtTo3C2j4yYBc5AzXX7TDFNCOwAvjly78G2OgretOf7YueEp08SXJP/hDx2
         6N6w==
X-Gm-Message-State: AOJu0YyxHHyG9dxqeoBn9u5rNz2/EK7wUb1lK0skgGxs5775Tso7wuF6
        UhtNJ85+7wBN2C42yLUAuqI/Uq8nRgMLHs3s8HdQZmoBoeo=
X-Google-Smtp-Source: AGHT+IH3ow5wxdqImAmbP3sK+JGLu3ciBk1tFbo4ipSIDaUjMDAXFs4Gq5mfvQYbmFE8pd0JLrNTKv5INXKk//+pN7k=
X-Received: by 2002:a17:90b:1d05:b0:280:cada:ea6a with SMTP id
 on5-20020a17090b1d0500b00280cadaea6amr4169341pjb.2.1699026620881; Fri, 03 Nov
 2023 08:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231103072639.11426-1-qiang.zhang1211@gmail.com>
In-Reply-To: <20231103072639.11426-1-qiang.zhang1211@gmail.com>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Fri, 3 Nov 2023 23:50:09 +0800
Message-ID: <CALm+0cVhrOL-CvQe41s6n75S-rk3mqO4RgS9y_wnRBr7YSm9CA@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Add fqs_holdoff check before the fqs_task is created
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> For rcutorture tests that support fqs operations and set fqs_duration
> greater than zero, the fqs_task kthread will be created. but if the
> fqs_holdoff is not set, the default value is zero, this cause fqs_task
> enter a long-term busy loop and won't voluntarily give up the CPU until
> stopped by kthread_stop(). this commit therefore add for fqs_holdoff check
> before the fqs_task is created, make sure the fqs_task is created when
> the fqs_holdoff is also greater than zero.
>
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
>


if not apply this patch, will trigger rcu stall for built with
PREEMPT_RCU=n kernels.

runqemu kvm nographic slirp qemuparams="-smp 2 -m 1024"
bootparams="rcutorture.fqs_duration=4" -d

[   31.071252] rcu: INFO: rcu_sched self-detected stall on CPU
[   31.071264] rcu: 0-....: (25999 ticks this GP)
idle=a10c/1/0x4000000000000000 softirq=3064/3065 fqs=2038552
[   31.071273] rcu:          hardirqs   softirqs   csw/system
[   31.071277] rcu: number:        0        212            0
[   31.071281] rcu: cputime:      166          1        12830   ==> 12999(ms)
[   31.071286] rcu: (t=26000 jiffies g=1373 q=13803 ncpus=2)
[   31.071292] CPU: 0 PID: 48 Comm: rcu_torture_fqs Tainted: G
    L     6.6.0-rc2-rt4zqiang #54
[   31.071299] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[   31.071303] RIP: 0010:_raw_spin_unlock_irqrestore+0x47/0x60
[   31.071314] Code: 08 e8 cd c6 92 fe 4c 89 e7 e8 b5 2d 93 fe 81 e3
00 02 00 00 75 1d 9c 58 f6 c4 02 75 1d 48 85 db 74 01 fb 65 ff 0d 51
86 98 66 <5b> b
[   31.071319] RSP: 0018:ffff888004237e38 EFLAGS: 00000246
[   31.071326] RAX: 0000000000000046 RBX: 0000000000000200 RCX: ffffffff981ab987
[   31.071331] RDX: 0000000000000003 RSI: dffffc0000000000 RDI: ffffffff99883445
[   31.071335] RBP: ffff888004237e48 R08: 0000000000000000 R09: 0000000000000000
[   31.071339] R10: fffffbfff3672d80 R11: ffffffff9b396c07 R12: ffffffff9ac02518
[   31.071344] R13: 0000000000000246 R14: 0000000000000000 R15: 0000000000000000
[   31.071348] FS:  0000000000000000(0000) GS:ffff888035e00000(0000)
knlGS:0000000000000000
[   31.071355] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   31.071359] CR2: 0000561df3203100 CR3: 0000000024a78000 CR4: 00000000001506f0
[   31.071364] Call Trace:
[   31.071367]  <IRQ>
[   31.071372]  ? show_regs+0x66/0x70
[   31.071379]  ? dump_cpu_task+0x68/0x70
[   31.071387]  ? rcu_dump_cpu_stacks+0x179/0x2b0
[   31.071396]  ? rcu_sched_clock_irq+0xb5c/0x11a0
[   31.071402]  ? irqtime_account_process_tick+0x158/0x210
[   31.071411]  ? update_process_times+0x6e/0xa0
[   31.071418]  ? tick_sched_timer+0x185/0x1d0
[   31.071425]  ? __pfx_tick_sched_timer+0x10/0x10
[   31.071431]  ? __hrtimer_run_queues+0x403/0x640
[   31.071438]  ? hrtimer_interrupt+0x77/0x350
[   31.071445]  ? __pfx___hrtimer_run_queues+0x10/0x10
[   31.071451]  ? kvm_clock_get_cycles+0x1c/0x30
[   31.071457]  ? ktime_get_update_offsets_now+0x102/0x200
[   31.071464]  ? hrtimer_interrupt+0x1ae/0x350
[   31.071473]  ? __sysvec_apic_timer_interrupt+0xaa/0x240
[   31.071480]  ? sysvec_apic_timer_interrupt+0x75/0x90
[   31.071487]  </IRQ>
[   31.071491]  <TASK>
[   31.071494]  ? asm_sysvec_apic_timer_interrupt+0x1f/0x30
[   31.071502]  ? lockdep_hardirqs_on_prepare+0x17/0x230
[   31.071510]  ? _raw_spin_unlock_irqrestore+0x55/0x60
[   31.071516]  ? _raw_spin_unlock_irqrestore+0x47/0x60
[   31.071524]  swake_up_one+0x47/0x60
[   31.071531]  rcu_gp_kthread_wake+0x63/0x90
[   31.071537]  rcu_force_quiescent_state+0xfb/0x160
[   31.071544]  rcu_torture_fqs+0xc4/0x160
[   31.071552]  ? __pfx_rcu_torture_fqs+0x10/0x10
[   31.071559]  kthread+0x197/0x1d0
[   31.071565]  ? kthread+0x107/0x1d0
[   31.071571]  ? __pfx_kthread+0x10/0x10
[   31.071577]  ret_from_fork+0x40/0x60
[   31.071583]  ? __pfx_kthread+0x10/0x10
[   31.071590]  ret_from_fork_asm+0x1b/0x30
[   31.071599]  </TASK>

Thanks
Zqiang

> ---
>  kernel/rcu/rcutorture.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 83999e57b3ea..9f0e6c1cad44 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -3886,7 +3886,9 @@ rcu_torture_init(void)
>         }
>         if (fqs_duration < 0)
>                 fqs_duration = 0;
> -       if (fqs_duration) {
> +       if (fqs_holdoff < 0)
> +               fqs_holdoff = 0;
> +       if (fqs_duration && fqs_holdoff) {
>                 /* Create the fqs thread */
>                 firsterr = torture_create_kthread(rcu_torture_fqs, NULL,
>                                                   fqs_task);
> --
> 2.17.1
>
