Return-Path: <linux-kernel+bounces-120621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F6688DA61
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2EB21C25D6F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8574D381C7;
	Wed, 27 Mar 2024 09:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RX/2dZqz"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B5B18E2A;
	Wed, 27 Mar 2024 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711532421; cv=none; b=K3DfTJnPOvW2V+iuC01/HK7aQ7w7FID9UPlbd/rYURWCEPtpB1Lhcdvd/01bn4oEiQdl6+tyXf51rr3Px8YvOrt69vBCS+DJmamWtuK1lhEF+W5ASu34qjdc+iyeKu/jpYC8U+haCSADyA21X6oKkYo2LGhc/KbhqhqbFgsOWJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711532421; c=relaxed/simple;
	bh=2hCOKQhIZ+vdPGBKj7aTjK3ey1Pce9vVpBE8DH6rTeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YB8pMbF7tDOjUrMY/7gBlnAiYysSx4fi0MROvOvNkz7MOxW9AtOV4HXUPesf8ZxtL64sy4FqNGTCf53pLtKi5IPdlnCRpUMVz1NOna0wcLEwLCyP16ZJNHzm29uE/Tq1gzVPTeU82IfuxigVWlJ4qWlYymObaz0YNZiqrM+cjnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RX/2dZqz; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29de4e12d12so4608320a91.3;
        Wed, 27 Mar 2024 02:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711532419; x=1712137219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I7YNwV9MtK0t2RFk5DVNZ9yyicVQzkKfpKclCLnFU+Y=;
        b=RX/2dZqzRzD05rEGJ8S/fTp7sxqAaineGV4O9/4P6Q6kEsMu7QM4kk6wo3c5hAiGVu
         Q0/CcNFTfXAzj1f/Il2gdNdNxMlI9WmP4PE+2OyaSN9LMNu8LDK2DX4+xghS7xnFM+YO
         rRZ5hSUxajkswQlPMf8kXzK7MQ+QriXXvE15G1NKXv5n0efYRxHA6vqSQcux7WgbKgYp
         nJ/DOU9lR79qQd5mdK2WTzTkaKOpTUbS4RPN39ntOZAJHUEJlB54bR5z9kuHmsFmdVdL
         Tjv9e+zK826hWloiyQn4P3JS9nRRDvJgAzV57X9FsN5GDKjvv6DfZGD3kbD6CJ2dJA+s
         oZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711532419; x=1712137219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7YNwV9MtK0t2RFk5DVNZ9yyicVQzkKfpKclCLnFU+Y=;
        b=ggH4dVpFAPKqDyam1dF2pADGEiM9YEa0QhlaGnqtp3mpwnmqFrDH/wxexKgf9w0KWN
         0JoV5eKn5sGyPFqtMTjqI7clCbnCGjI23QW8zOBZJHOQFiZDSi2pz98bWMNV1Kxt5r+/
         NVBaPc8IIqKkekWaYi74AewLH9JXehisjC+mC8WnjWAbye5L0XIzguOIHoNB09dJLVfB
         QIxb2OtIaKf4xu2SxLaa2jU2BxET4wJCvGqgM8VU4pYsqsDi9PDpWBk5G7oYyC6tdw62
         G4Q8r65gwteIvZVOAsTFxCLvrkoc5s53AhdT4q9czm4iR1gzgmEHqqgeLrrBGJ9kDGvZ
         wfLA==
X-Forwarded-Encrypted: i=1; AJvYcCW4YVvlyQcs4a//h+BzwSOMmJsVO2mhtAfyc6H8KguVg1dVVPxrLQIw4h3dP0gVfi42irjEdTeJztYUpzweaDQuiKYsn9KAJZJEXxnCdV5go8uVGONmWIRc8npWRXweWmHd
X-Gm-Message-State: AOJu0Yws8YPMmvfy7KWBIKie4YkbnxQuSKr9B2GsSeA1mH60i7YX/uDZ
	X4AX4tDJkR4E7QG3j4K2+4UMM02yyYGSJxJJGQb7ieQOL/L69mP3+kZOAAakLo6xRd2rdtwGgTW
	r3aJOWWrtT9LL/zAZ4bmw8W/5eXNH7gEeZZc=
X-Google-Smtp-Source: AGHT+IEVJXM10dCRaeJAtSIOd2bZCQMFbN1dFEEX3nE0sD7wewAEa5H4mR2bHS5RVNg9EgMGitucCcaZDTfiCLtb9Ps=
X-Received: by 2002:a17:90b:608:b0:29f:b2a9:9cdc with SMTP id
 gb8-20020a17090b060800b0029fb2a99cdcmr2104010pjb.19.1711532419318; Wed, 27
 Mar 2024 02:40:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325075219.10367-1-qiang.zhang1211@gmail.com> <ea12722c-772b-47de-ae3a-022fe1f8da3e@paulmck-laptop>
In-Reply-To: <ea12722c-772b-47de-ae3a-022fe1f8da3e@paulmck-laptop>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Wed, 27 Mar 2024 17:40:07 +0800
Message-ID: <CALm+0cWRSFr=1tdYpvurHFMaB7B-u8geYRZEOztRFfmH42ZKhA@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Fix invalid context warning when enable srcu
 barrier testing
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joel@joelfernandes.org, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Mon, Mar 25, 2024 at 03:52:19PM +0800, Zqiang wrote:
> > When the torture_type is set srcu or srcud and cb_barrier is
> > non-zero, running the rcutorture test will trigger the
> > following warning:
> >
> > [  163.910989][    C1] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> > [  163.910994][    C1] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
> > [  163.910999][    C1] preempt_count: 10001, expected: 0
> > [  163.911002][    C1] RCU nest depth: 0, expected: 0
> > [  163.911005][    C1] INFO: lockdep is turned off.
> > [  163.911007][    C1] irq event stamp: 30964
> > [  163.911010][    C1] hardirqs last  enabled at (30963): [<ffffffffabc7df52>] do_idle+0x362/0x500
> > [  163.911018][    C1] hardirqs last disabled at (30964): [<ffffffffae616eff>] sysvec_call_function_single+0xf/0xd0
> > [  163.911025][    C1] softirqs last  enabled at (0): [<ffffffffabb6475f>] copy_process+0x16ff/0x6580
> > [  163.911033][    C1] softirqs last disabled at (0): [<0000000000000000>] 0x0
> > [  163.911038][    C1] Preemption disabled at:
> > [  163.911039][    C1] [<ffffffffacf1964b>] stack_depot_save_flags+0x24b/0x6c0
> > [  163.911063][    C1] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W          6.8.0-rc4-rt4-yocto-preempt-rt+ #3 1e39aa9a737dd024a3275c4f835a872f673a7d3a
> > [  163.911071][    C1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> > [  163.911075][    C1] Call Trace:
> > [  163.911078][    C1]  <IRQ>
> > [  163.911080][    C1]  dump_stack_lvl+0x88/0xd0
> > [  163.911089][    C1]  dump_stack+0x10/0x20
> > [  163.911095][    C1]  __might_resched+0x36f/0x530
> > [  163.911105][    C1]  rt_spin_lock+0x82/0x1c0
> > [  163.911112][    C1]  spin_lock_irqsave_ssp_contention+0xb8/0x100
> > [  163.911121][    C1]  srcu_gp_start_if_needed+0x782/0xf00
> > [  163.911128][    C1]  ? _raw_spin_unlock_irqrestore+0x46/0x70
> > [  163.911136][    C1]  ? debug_object_active_state+0x336/0x470
> > [  163.911148][    C1]  ? __pfx_srcu_gp_start_if_needed+0x10/0x10
> > [  163.911156][    C1]  ? __pfx_lock_release+0x10/0x10
> > [  163.911165][    C1]  ? __pfx_rcu_torture_barrier_cbf+0x10/0x10
> > [  163.911188][    C1]  __call_srcu+0x9f/0xe0
> > [  163.911196][    C1]  call_srcu+0x13/0x20
> > [  163.911201][    C1]  srcu_torture_call+0x1b/0x30
> > [  163.911224][    C1]  rcu_torture_barrier1cb+0x4a/0x60
> > [  163.911247][    C1]  __flush_smp_call_function_queue+0x267/0xca0
> > [  163.911256][    C1]  ? __pfx_rcu_torture_barrier1cb+0x10/0x10
> > [  163.911281][    C1]  generic_smp_call_function_single_interrupt+0x13/0x20
> > [  163.911288][    C1]  __sysvec_call_function_single+0x7d/0x280
> > [  163.911295][    C1]  sysvec_call_function_single+0x93/0xd0
> > [  163.911302][    C1]  </IRQ>
> > [  163.911304][    C1]  <TASK>
> > [  163.911308][    C1]  asm_sysvec_call_function_single+0x1b/0x20
> > [  163.911313][    C1] RIP: 0010:default_idle+0x17/0x20
> > [  163.911326][    C1] RSP: 0018:ffff888001997dc8 EFLAGS: 00000246
> > [  163.911333][    C1] RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffffae618b51
> > [  163.911337][    C1] RDX: 0000000000000000 RSI: ffffffffaea80920 RDI: ffffffffaec2de80
> > [  163.911342][    C1] RBP: ffff888001997dc8 R08: 0000000000000001 R09: ffffed100d740cad
> > [  163.911346][    C1] R10: ffffed100d740cac R11: ffff88806ba06563 R12: 0000000000000001
> > [  163.911350][    C1] R13: ffffffffafe460c0 R14: ffffffffafe460c0 R15: 0000000000000000
> > [  163.911358][    C1]  ? ct_kernel_exit.constprop.3+0x121/0x160
> > [  163.911369][    C1]  ? lockdep_hardirqs_on+0xc4/0x150
> > [  163.911376][    C1]  arch_cpu_idle+0x9/0x10
> > [  163.911383][    C1]  default_idle_call+0x7a/0xb0
> > [  163.911390][    C1]  do_idle+0x362/0x500
> > [  163.911398][    C1]  ? __pfx_do_idle+0x10/0x10
> > [  163.911404][    C1]  ? complete_with_flags+0x8b/0xb0
> > [  163.911416][    C1]  cpu_startup_entry+0x58/0x70
> > [  163.911423][    C1]  start_secondary+0x221/0x280
> > [  163.911430][    C1]  ? __pfx_start_secondary+0x10/0x10
> > [  163.911440][    C1]  secondary_startup_64_no_verify+0x17f/0x18b
> > [  163.911455][    C1]  </TASK>
> >
> > This commit therefore use smp_call_on_cpu() instead of
> > smp_call_function_single(), make rcu_torture_barrier1cb() invoked
> > happens on task-context.
> >
> > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
>
> Huh.  The use of non-raw spinlocks does constrain call_rcu() use, doesn't
> it?  Good catch!
>

Yes, This problem happens in the srcu rcutorture test under the
Preempt-RT kernel.


> Queued for testing and further review.  Are there any uses of call_srcu()
> out there that are unsafe on -rt?

I'm running rcutorture tests under the RT-kernel these days, and I haven't found
any others yet.  :)

Thanks
Zqiang

>
>                                                         Thanx, Paul
>
> > ---
> >  kernel/rcu/rcutorture.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index 48a9d47ec90e..498aae52333e 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -3041,11 +3041,12 @@ static void rcu_torture_barrier_cbf(struct rcu_head *rcu)
> >  }
> >
> >  /* IPI handler to get callback posted on desired CPU, if online. */
> > -static void rcu_torture_barrier1cb(void *rcu_void)
> > +static int rcu_torture_barrier1cb(void *rcu_void)
> >  {
> >       struct rcu_head *rhp = rcu_void;
> >
> >       cur_ops->call(rhp, rcu_torture_barrier_cbf);
> > +     return 0;
> >  }
> >
> >  /* kthread function to register callbacks used to test RCU barriers. */
> > @@ -3071,11 +3072,9 @@ static int rcu_torture_barrier_cbs(void *arg)
> >                * The above smp_load_acquire() ensures barrier_phase load
> >                * is ordered before the following ->call().
> >                */
> > -             if (smp_call_function_single(myid, rcu_torture_barrier1cb,
> > -                                          &rcu, 1)) {
> > -                     // IPI failed, so use direct call from current CPU.
> > +             if (smp_call_on_cpu(myid, rcu_torture_barrier1cb, &rcu, 1))
> >                       cur_ops->call(&rcu, rcu_torture_barrier_cbf);
> > -             }
> > +
> >               if (atomic_dec_and_test(&barrier_cbs_count))
> >                       wake_up(&barrier_wq);
> >       } while (!torture_must_stop());
> > --
> > 2.17.1
> >

