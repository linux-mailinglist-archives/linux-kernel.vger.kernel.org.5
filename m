Return-Path: <linux-kernel+bounces-7991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C36081B03F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99BE81F21CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E31F16432;
	Thu, 21 Dec 2023 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="nz7562eM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539F716401
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 08:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cc794df8aaso5244541fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 00:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1703147066; x=1703751866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0X7WOS7Xwpp153ELU1RG0j8w5R87PtW1uTurmOc5Lc=;
        b=nz7562eMJ3XC2xJ9NOQ4LG3kbLERx4GuobnGtsouyEM3NVLOGPbqhJZ5LMCawdFEqd
         nx4sYaO+uytKfDywrMeJEpwAXYi0KDi1V+Ve8pQRil+XZAAqVAAOXLvPfVTrpkyUUs8m
         t0QJckvvwuFsnziDJ9/6rnwdiCey6UqxhNbkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703147066; x=1703751866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0X7WOS7Xwpp153ELU1RG0j8w5R87PtW1uTurmOc5Lc=;
        b=FkCMjVt0or5VDddn7bRZ7qS+aGhVmu8AAYLg8i4pbzG/XL7iWSel2qtU60eLdsYZQR
         ZMvWhdxM514pWAMTx8BRLYze5xzoWqXJez2fh5aev+s2cRx/ER6wNPNjt326OsBCAziM
         F5ps4T5fFmbgBJ2Cj3iao7vL0Sk7n5Q8sHEfqQK+/bAuIPFyqga52mf6l9ubUmkDRMep
         HzjrpR3qPsyue/j+p5BiPY16RJR+Ro8B4oudItnfTkLx2IMh1A4xoe/5d15WkfEsRl2w
         mGhNQcjkl4AiERLR1HswX0fFUA0JYcX4yO5W8zNJlRfkn/iGAnZVkvVZaMFTLsxFyx0E
         VaHA==
X-Gm-Message-State: AOJu0YyOWo2ldHbIipVX1I+b+cnzwflENDxvsCQSiN9/qb/nryfUHU6I
	jU8wL2jdWa+XCBjGh9Q+wp4RRMj5PZiMRcTsYpHL9LGaIcwSIU19
X-Google-Smtp-Source: AGHT+IFGtZhc60gp6Jgf0AJ2jScr2WK4Y22Pn1WLiKqOYLPbpTXnOJ6ctdjAn1tEokswnTuAchmfDYpI2oz5tK2m0MY=
X-Received: by 2002:a2e:a99a:0:b0:2cc:8923:9e65 with SMTP id
 x26-20020a2ea99a000000b002cc89239e65mr1996655ljq.22.1703147066211; Thu, 21
 Dec 2023 00:24:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+9S74gb33kXH2cvGHZid3+pT2-f=jdCZ4gu00x3pgBwjBf0yw@mail.gmail.com>
 <ba043dd3-d626-cb59-99d6-249efdec9763@didichuxing.com>
In-Reply-To: <ba043dd3-d626-cb59-99d6-249efdec9763@didichuxing.com>
From: Igor Raits <igor@gooddata.com>
Date: Thu, 21 Dec 2023 09:24:14 +0100
Message-ID: <CA+9S74id0Ln0WbWzxshxrtBhRw3eMDGTTDTC7UH0ugOF0rD5ZQ@mail.gmail.com>
Subject: Re: [REGRESSION] EEVDF scheduling fail, picking leftmost - Soft Lockup
To: Honglei Wang <wanghonglei@didichuxing.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, 
	Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Honglei,

On Wed, Dec 20, 2023 at 2:51=E2=80=AFAM Honglei Wang
<wanghonglei@didichuxing.com> wrote:
>
>
>
> On 2023/12/20 03:10, Igor Raits wrote:
> > Good $timeoftheday everyone,
> >
> > After upgrading the kernel from 6.6.1 to 6.6.4 we have noticed on some
> > subset of our systems the regression. It looks like following:
> > [Fri Dec 15 08:31:20 CET 2023] EEVDF scheduling fail, picking leftmost
> > [Fri Dec 15 08:31:44 CET 2023] watchdog: BUG: soft lockup - CPU#1
> > stuck for 22s! [VM Thread:37074]
> >
> > First message is visible in the virtual console however the second one
> > appears only when analyzing via "crash".
> >
> > I was trying to find any existing reports but instead found some
> > automated syzbot notification about possible soft lockup and some
> > discussion around usage of pr_err() and printk() stuff however I'm not
> > really sure which one(s) you would suggest us to try.
> >
>
> Looks like this is the problem you got (printk while hoding rq->lock).
> People are working on fixing that. For now, maybe you can just do small
> modification to skip the pr_err and move on. Or try Peter's early_printk
> hacks here
> https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=
=3Ddebug/experimental
>
> It depends on your case. Hope this help.

Commenting out the pr_err() helps in our case, thanks for tip! In the
branch you linked there are few patches on top of the mainline, not
sure if this is easy enough for us to test. However, if anybody will
have a specific set of patches to try out on top of stable, happy to
test!

> Thanks,
> Honglei
>
> > We've also tried 6.6.7 but with no luck, the issue is still there. My
> > colleague has started bisecting but it will take a while. The error is
> > not 100% reproducible but on some nodes it was visible a few hours
> > after deployment so it is not something very esoteric.
> >
> > Any help is very much appreciated!
> >
> > Below I'm pasting the output of the "bt -a" in case it will be helpful.
> >
> > PID: 37538    TASK: ffff88817e8bb400  CPU: 0    COMMAND: "Ruby-0-Thread=
-5"
> >      [exception RIP: native_queued_spin_lock_slowpath+639]
> >      RIP: ffffffffb465882f  RSP: ffffc9000268fd48  RFLAGS: 00000046
> >      RAX: 0000000000000000  RBX: ffff888f82c32880  RCX: 000000000004000=
0
> >      RDX: 0000000000000003  RSI: 0000000000100100  RDI: ffff888f82cb1a8=
0
> >      RBP: ffff888f82cb1a80   R8: 0000000000000006   R9: fffffffffffffff=
0
> >      R10: 0000000000000006  R11: 000000000000027b  R12: 000000000000000=
0
> >      R13: 0000000000000000  R14: 000000000002e72f  R15: ffff88810098ee0=
0
> >      CS: 0010  SS: 0000
> >   #0 [ffffc9000268fd68] _raw_spin_lock at ffffffffb46583e5
> >   #1 [ffffc9000268fd70] raw_spin_rq_lock_nested at ffffffffb3b44669
> >   #2 [ffffc9000268fd88] load_balance at ffffffffb3b5e71d
> >   #3 [ffffc9000268fe68] rebalance_domains at ffffffffb3b5f82a
> >   #4 [ffffc9000268fed8] __do_softirq at ffffffffb4659008
> >   #5 [ffffc9000268ff28] irq_exit_rcu at ffffffffb3b08796
> >   #6 [ffffc9000268ff38] sysvec_apic_timer_interrupt at ffffffffb4643a7c
> >   #7 [ffffc9000268ff50] asm_sysvec_apic_timer_interrupt at ffffffffb480=
0e06
> >      RIP: 00007fae95431e07  RSP: 00007fae222f65c8  RFLAGS: 00000202
> >      RAX: 00007faea9446640  RBX: 00007faea9446640  RCX: 000000070412f82=
8
> >      RDX: 0000000080500001  RSI: 000000070412f828  RDI: 000000000000001=
3
> >      RBP: 00007fae222f6620   R8: 000000070412f828   R9: 000000000000006=
d
> >      R10: 00007faeac695040  R11: 00007fae95431e00  R12: 000000000000000=
0
> >      R13: 00007fae222f65d8  R14: 00007fae222f66b8  R15: 00007faea526f80=
0
> >      ORIG_RAX: ffffffffffffffff  CS: 0033  SS: 002b
> >
> > PID: 37074    TASK: ffff88882c0b4e00  CPU: 1    COMMAND: "VM Thread"
> >      [exception RIP: vprintk_emit+389]
> >      RIP: ffffffffb3b89735  RSP: ffffc90000184e68  RFLAGS: 00000002
> >      RAX: 0000000000000001  RBX: 0000000000000046  RCX: 000000000000ff1=
8
> >      RDX: ffff88882c0b4e00  RSI: 0000000000000002  RDI: ffffffffb647412=
0
> >      RBP: 00000000ffffffff   R8: 80000000ffffd508   R9: 0000000000ffff0=
a
> >      R10: 0000000000000004  R11: 0000000000000047  R12: 000000000000000=
0
> >      R13: 0000000000000000  R14: ffffffffb4f7cca8  R15: 000000000000004=
3
> >      CS: 0010  SS: 0018
> >   #0 [ffffc90000184ea8] _printk at ffffffffb3b85b38
> >   #1 [ffffc90000184f08] watchdog_timer_fn at ffffffffb3c29464
> >   #2 [ffffc90000184f30] __hrtimer_run_queues at ffffffffb3bc753f
> >   #3 [ffffc90000184f88] hrtimer_interrupt at ffffffffb3bc7fdc
> >   #4 [ffffc90000184fd8] __sysvec_apic_timer_interrupt at ffffffffb3a70c=
4b
> >   #5 [ffffc90000184ff0] sysvec_apic_timer_interrupt at ffffffffb4643aad
> > --- <IRQ stack> ---
> >      RIP: 0000000000000010  RSP: 0000000000000018  RFLAGS: ffffc900016a=
3d38
> >      RAX: 0000000000000001  RBX: 0000000000000000  RCX: 000000000000000=
1
> >      RDX: ffff888f82c39500  RSI: ffff88810006b328  RDI: fffffffffffffff=
f
> >      RBP: ffff888f82c72d40   R8: 0000000000000000   R9: 000000000000000=
0
> >      R10: 0000000000000005  R11: 0000000000000000  R12: 000000000000020=
2
> >      R13: ffff888f82c71380  R14: 0000000000000001  R15: ffff888f82c72d4=
0
> >      ORIG_RAX: ffffffffb3be3f62  CS: 0202  SS: ffffffffb3be3f42
> > bt: WARNING: possibly bogus exception frame
> >
> > PID: 37078    TASK: ffff88845f91ce00  CPU: 2    COMMAND: "C2 CompilerTh=
re"
> >      [exception RIP: native_queued_spin_lock_slowpath+114]
> >      RIP: ffffffffb4658622  RSP: ffffc9000187b9e8  RFLAGS: 00000002
> >      RAX: 0000000000000001  RBX: ffff888103e1ce00  RCX: ffff888103e1d22=
8
> >      RDX: 0000000000000000  RSI: 0000000000000000  RDI: ffff888f82cb1a8=
0
> >      RBP: ffff888f82cb1a80   R8: 0000000000000002   R9: ffff888f82cb142=
8
> >      R10: 0000000000000000  R11: 0000000000000000  R12: 000000000000000=
0
> >      R13: 0000000000000087  R14: ffff888103e1dadc  R15: ffff888f82c8000=
0
> >      CS: 0010  SS: 0000
> >   #0 [ffffc9000187ba08] _raw_spin_lock at ffffffffb46583e5
> >   #1 [ffffc9000187ba10] raw_spin_rq_lock_nested at ffffffffb3b44669
> >   #2 [ffffc9000187ba28] try_to_wake_up at ffffffffb3b4edec
> >   #3 [ffffc9000187ba80] kick_pool at ffffffffb3b21689
> >   #4 [ffffc9000187ba98] __queue_work at ffffffffb3b24d57
> >   #5 [ffffc9000187bae0] queue_work_on at ffffffffb3b24f94
> >   #6 [ffffc9000187baf0] soft_cursor at ffffffffb40e4e70
> >   #7 [ffffc9000187bb48] bit_cursor at ffffffffb40e49e5
> >   #8 [ffffc9000187bc10] hide_cursor at ffffffffb41b306b
> >   #9 [ffffc9000187bc20] vt_console_print at ffffffffb41b5691
> > #10 [ffffc9000187bc88] console_flush_all at ffffffffb3b876c1
> > #11 [ffffc9000187bd00] console_unlock at ffffffffb3b8792c
> > #12 [ffffc9000187bd38] vprintk_emit at ffffffffb3b89750
> > #13 [ffffc9000187bd80] _printk at ffffffffb3b85b38
> > #14 [ffffc9000187bde0] pick_next_entity.constprop.0 at ffffffffb3b5bc88
> > #15 [ffffc9000187bdf8] pick_next_task_fair at ffffffffb3b5f15b
> > #16 [ffffc9000187be30] pick_next_task at ffffffffb3b47727
> > #17 [ffffc9000187be90] __schedule at ffffffffb4650f4d
> > #18 [ffffc9000187bef8] schedule at ffffffffb465160a
> > #19 [ffffc9000187bf10] exit_to_user_mode_loop at ffffffffb3bb6290
> > #20 [ffffc9000187bf30] exit_to_user_mode_prepare at ffffffffb3bb6452
> > #21 [ffffc9000187bf48] irqentry_exit_to_user_mode at ffffffffb4644975
> > #22 [ffffc9000187bf50] asm_sysvec_apic_timer_interrupt at ffffffffb4800=
e06
> >      RIP: 00007faeabc4464c  RSP: 00007faea8efb4d0  RFLAGS: 00000202
> >      RAX: 00007fae84df0850  RBX: 0000000000000008  RCX: 000000000000064=
5
> >      RDX: 00007fae84df0840  RSI: 0000000000000010  RDI: 00007faea8efb4e=
0
> >      RBP: 00007faea8efb550   R8: 00007faea4122000   R9: 000000000000000=
0
> >      R10: 0000000000000000  R11: 0000000000200012  R12: 000000000000003=
0
> >      R13: 00007faea8efb6e0  R14: 0000000000000400  R15: 000000000000064=
a
> >      ORIG_RAX: ffffffffffffffff  CS: 0033  SS: 002b
> >
> > PID: 36585    TASK: ffff8881009e3400  CPU: 3    COMMAND: "C2 CompilerTh=
re"
> >      [exception RIP: native_queued_spin_lock_slowpath+639]
> >      RIP: ffffffffb465882f  RSP: ffffc9000153bd48  RFLAGS: 00000046
> >      RAX: 0000000000000000  RBX: ffff888f82cf2880  RCX: 000000000010000=
0
> >      RDX: 0000000000000004  RSI: 0000000000140100  RDI: ffff888f82cb1a8=
0
> >      RBP: ffff888f82cb1a80   R8: 0000000000000006   R9: fffffffffffffff=
8
> >      R10: 0000000000000006  R11: 0000000000000000  R12: 000000000000000=
0
> >      R13: 0000000000000003  R14: 0000000000010671  R15: ffff88810098c60=
0
> >      CS: 0010  SS: 0000
> >   #0 [ffffc9000153bd68] _raw_spin_lock at ffffffffb46583e5
> >   #1 [ffffc9000153bd70] raw_spin_rq_lock_nested at ffffffffb3b44669
> >   #2 [ffffc9000153bd88] load_balance at ffffffffb3b5e71d
> >   #3 [ffffc9000153be68] rebalance_domains at ffffffffb3b5f82a
> >   #4 [ffffc9000153bed8] __do_softirq at ffffffffb4659008
> >   #5 [ffffc9000153bf28] irq_exit_rcu at ffffffffb3b08796
> >   #6 [ffffc9000153bf38] sysvec_apic_timer_interrupt at ffffffffb4643a7c
> >   #7 [ffffc9000153bf50] asm_sysvec_apic_timer_interrupt at ffffffffb480=
0e06
> >      RIP: 00007f0661b21a74  RSP: 00007f0631ffaf38  RFLAGS: 00000202
> >      RAX: 0000000000000000  RBX: 00007f0631ffb750  RCX: 000000000000000=
1
> >      RDX: 0000000000000002  RSI: 0000000000000000  RDI: 00007f0631ffb03=
4
> >      RBP: 00007f0631ffb080   R8: 0000000000000002   R9: 000000005555555=
5
> >      R10: 00007f0631ffb048  R11: 0000000000000000  R12: 000000000000000=
2
> >      R13: 00007f0608f2c1d0  R14: 00007f0608f2f8d0  R15: 00007f0631ffaf5=
0
> >      ORIG_RAX: ffffffffffffffff  CS: 0033  SS: 002b
> >
> > PID: 37776    TASK: ffff888459fc8000  CPU: 4    COMMAND: "C2 CompilerTh=
re"
> >      [exception RIP: native_queued_spin_lock_slowpath+496]
> >      RIP: ffffffffb46587a0  RSP: ffffc90002807d48  RFLAGS: 00000002
> >      RAX: 0000000000180101  RBX: ffff888f82d32880  RCX: 000000000014000=
0
> >      RDX: 0000000000000000  RSI: 0000000000000100  RDI: ffff888f82cb1a8=
0
> >      RBP: ffff888f82cb1a80   R8: 0000000000000006   R9: fffffffffffffff=
0
> >      R10: 0000000000000006  R11: 000000000000027b  R12: 000000000000000=
0
> >      R13: 0000000000000004  R14: 000000000000d865  R15: ffff88810098f00=
0
> >      CS: 0010  SS: 0000
> >   #0 [ffffc90002807d68] _raw_spin_lock at ffffffffb46583e5
> >   #1 [ffffc90002807d70] raw_spin_rq_lock_nested at ffffffffb3b44669
> >   #2 [ffffc90002807d88] load_balance at ffffffffb3b5e71d
> >   #3 [ffffc90002807e68] rebalance_domains at ffffffffb3b5f82a
> >   #4 [ffffc90002807ed8] __do_softirq at ffffffffb4659008
> >   #5 [ffffc90002807f28] irq_exit_rcu at ffffffffb3b08796
> >   #6 [ffffc90002807f38] sysvec_apic_timer_interrupt at ffffffffb4643a7c
> >   #7 [ffffc90002807f50] asm_sysvec_apic_timer_interrupt at ffffffffb480=
0e06
> >      RIP: 00007f09b972ac50  RSP: 00007f09894fa898  RFLAGS: 00000246
> >      RAX: 00007f09b8fdded8  RBX: 00007f093c0f9920  RCX: 000000000000004=
9
> >      RDX: 00007f09b99bf2a8  RSI: 0000000000000000  RDI: 000000000000001=
0
> >      RBP: 00007f09894fa8b0   R8: 0000000000000001   R9: 000000000000000=
2
> >      R10: 0000000000000013  R11: 0000000000000012  R12: 000000000000004=
9
> >      R13: 00007f093c0f9700  R14: 00007f093d3728c8  R15: 000000000000004=
9
> >      ORIG_RAX: ffffffffffffffff  CS: 0033  SS: 002b
> >
> > PID: 20501    TASK: ffff888184349a00  CPU: 5    COMMAND: "unbound"
> >      [exception RIP: native_queued_spin_lock_slowpath+639]
> >      RIP: ffffffffb465882f  RSP: ffffc900007fbb08  RFLAGS: 00000046
> >      RAX: 0000000000000000  RBX: ffff888f82d72880  RCX: 000000000018000=
0
> >      RDX: 0000000000000000  RSI: 0000000000040100  RDI: ffff888f82cb1a8=
0
> >      RBP: ffff888f82cb1a80   R8: 0000000000000006   R9: fffffffffffffff=
0
> >      R10: 0000000000000006  R11: 0000000000000001  R12: 000000000000000=
0
> >      R13: 0000000000000005  R14: ffff888f82d71a80  R15: 000000000000000=
0
> >      CS: 0010  SS: 0018
> >   #0 [ffffc900007fbb28] _raw_spin_lock at ffffffffb46583e5
> >   #1 [ffffc900007fbb30] raw_spin_rq_lock_nested at ffffffffb3b44669
> >   #2 [ffffc900007fbb48] load_balance at ffffffffb3b5e71d
> >   #3 [ffffc900007fbc28] newidle_balance at ffffffffb3b5ede3
> >   #4 [ffffc900007fbc88] pick_next_task_fair at ffffffffb3b5f0a1
> >   #5 [ffffc900007fbcc0] pick_next_task at ffffffffb3b47727
> >   #6 [ffffc900007fbd20] __schedule at ffffffffb4650f4d
> >   #7 [ffffc900007fbd88] schedule at ffffffffb465160a
> >   #8 [ffffc900007fbda0] schedule_hrtimeout_range_clock at ffffffffb4657=
465
> >   #9 [ffffc900007fbe10] ep_poll at ffffffffb3e9617d
> > #10 [ffffc900007fbeb0] do_epoll_wait at ffffffffb3e962a4
> > #11 [ffffc900007fbee8] __x64_sys_epoll_wait at ffffffffb3e96b20
> > #12 [ffffc900007fbf38] do_syscall_64 at ffffffffb463df98
> > #13 [ffffc900007fbf50] entry_SYSCALL_64_after_hwframe at ffffffffb48000=
e6
> >      RIP: 00007f643f54e8be  RSP: 00007f6437ffec70  RFLAGS: 00000293
> >      RAX: ffffffffffffffda  RBX: 0000000000000000  RCX: 00007f643f54e8b=
e
> >      RDX: 0000000000000020  RSI: 00007f6428000ed0  RDI: 000000000000002=
3
> >      RBP: 00007f6428000c10   R8: 0000000000000000   R9: 00007f6437ffec0=
8
> >      R10: 00000000ffffffff  R11: 0000000000000293  R12: 00007f6428000ed=
0
> >      R13: 00007f6428000eb0  R14: 00007f6428000eb0  R15: 00000000fffffff=
f
> >      ORIG_RAX: 00000000000000e8  CS: 0033  SS: 002b
> >

