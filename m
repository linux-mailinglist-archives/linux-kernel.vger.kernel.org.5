Return-Path: <linux-kernel+bounces-149843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933018A96A5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFAE1B23E64
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A3115B15F;
	Thu, 18 Apr 2024 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDMovcOm"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CB315AAD7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433792; cv=none; b=q8s6dcgF/upEaqHobHl/G++q1jfmITIWnglJQXkjjBbVZ0bWQuGzMrqIl68xqc8ou7ZkRIvi88AozO4tb6ygROsKbfk77QT34FNGe/4x0L3JcYJ3EhvBzpXwewjF2Zk/cPHcTGyd7fVSkvRPnEDQEkDVZtA2LU79lUQl4hx8twI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433792; c=relaxed/simple;
	bh=53jsJCeNhPGunoHdB9W+enk+c3ReLy1M8p5JyVK+bTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NI4U0MYYJwlhnSrplStiR7J4XHyxyJaxat/KWY0QoC8C1n+UOSUYNErVEbdANcqbVm5syGsDC5wIoWxI7DtsoJDn8/N+StJsCTRXJlN8/B2huylxNam7ldJGdeZEhDK0BU/tG5WnRxPfgkLmfhp/01kwl15WDlmuY8RB2MMMw3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDMovcOm; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so428018a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 02:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713433790; x=1714038590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0s3gjS1zjK4yFPmtUmv96Keh0+IBf/8ML6iwR1R3M8=;
        b=CDMovcOm7csSKqupFCSuZLjNsuucdrfWXVLFo3YH+hZNgnj0f9txFJfU+tTLZt9wKJ
         FKNZ8ceJpTtffHoa+dAYIQEunzTYk/c5mc3UD5xfDU8jrMHORPlnxrZ9mzwLLpDVYEA+
         6w3oBEzL3NloaEyykxM7iZFFN6WpKOoISHkOpByGK2NN0AtRl1K+DNeyEBewp/SRLihT
         MngUkvWvss9HJ7kRl9Ep0+WEqafVjKthH97PqVe/7GGTjMZr6h5dhZNfLKzt8hfH029X
         Eni5rFyqMjPHgth7Xl59V9SPj8gKuaBmEHBCzT0d985+o5qLcyGOcFDiQepG7CMeYZXU
         0gEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713433790; x=1714038590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0s3gjS1zjK4yFPmtUmv96Keh0+IBf/8ML6iwR1R3M8=;
        b=F4m9unZRK9VPB8w6P4ZRyPF7z4pgyvyoIEX3HfsPlVCZqzgM+XYgahYMKFhQVbafgZ
         w8fXHw8aWFUknjNO06qjVDsEPpYomVHP2UiELQBwxfDYSwOMVLQWPTpUPLn0Y5X3ocH1
         Ak4BgiE/TL7NBNj4km5oGjCL0A/wwkjFn8IDAgtjP2dxYJSQY2+joITf9+xKV+WC9hLW
         6i+limChGXD2KwEF1XlavX36A+MVCll5iTrSozawzKrnHgkof/EXDhioZUuWwOUI0SKj
         Rc0e7tMzTAVcHINQeBoVJokMbYwnIE/pmjGofHRxYOo7108tgUAYsy53SdLf/bBZ/haw
         OCmw==
X-Forwarded-Encrypted: i=1; AJvYcCUDj6j6cPTa06u8uDVaegis8ds39Al5LSWDhRHYs0Yhls5bgXJtzGCLQ7HGOA8DQqlLdAl1BrrtX4OcU5UShLfg0/4tGHZepIUuuNfx
X-Gm-Message-State: AOJu0Yy//8cn/1rbg8q1r9fFdBQwS7pl9rD4QxThEHuz1i6m5NcV5dfV
	xUUuLxYyXUI6qAHz0i5peiC7BbB8JRgqVTspmH9JzD6dHojMksPwUbsRLjjHwKgjSiCRNZZ3+t8
	aZp0ERE24VKekB/GDxrnUfiL+dpA=
X-Google-Smtp-Source: AGHT+IFZAEPCZ+PBsXuMdhelQnrJodcB7ATmpieCDG6Bn5L4nwb1G/Kg0UKnORl72FvFtPTPHO3/5NbZw8am5rov4Jo=
X-Received: by 2002:a17:90a:1657:b0:29d:eea9:c800 with SMTP id
 x23-20020a17090a165700b0029deea9c800mr2180281pje.7.1713433790229; Thu, 18 Apr
 2024 02:49:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000b24903061520f3e9@google.com> <CALm+0cWx1kYtftE4nj7Jjgx2_bmNmSrBAgd36ksSvxJtNVhxHg@mail.gmail.com>
 <CALm+0cWRC1kqLJvmEqda4O97PZ-n0R0UQ35=fi6oA3rLsPoUSQ@mail.gmail.com>
 <8f281a10-b85a-4586-9586-5bbc12dc784f@paulmck-laptop> <CALm+0cWN0+cCsYddBUefya3aUw9c9Xn89GVV=Ys1_UPjS19WrQ@mail.gmail.com>
 <4c09abb6-4f6e-42d7-9944-c5da995649cb@paulmck-laptop>
In-Reply-To: <4c09abb6-4f6e-42d7-9944-c5da995649cb@paulmck-laptop>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Thu, 18 Apr 2024 17:49:38 +0800
Message-ID: <CALm+0cVaLfE2ieK9aqh9yHkPDyO7zWbMe9K6WjTUgm4t9SnSFQ@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] WARNING: suspicious RCU usage in __do_softirq
To: paulmck@kernel.org
Cc: syzbot <syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>
> On Wed, Apr 17, 2024 at 10:25:01AM +0800, Z qiang wrote:
> > >
> > > On Tue, Apr 16, 2024 at 04:44:54PM +0800, Z qiang wrote:
> > > > On Tue, Apr 16, 2024 at 4:10=E2=80=AFPM Z qiang <qiang.zhang1211@gm=
ail.com> wrote:
> > > > >
> > > > > Cc: Paul
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > syzbot found the following issue on:
> > > > > >
> > > > > > HEAD commit:    c0b832517f62 Add linux-next specific files for =
20240402
> > > > > > git tree:       linux-next
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D15f=
64776180000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dafc=
af46d374cec8c
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Ddce04=
ed6d1438ad69656
> > > > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binuti=
ls for Debian) 2.40
> > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1=
0f00471180000
> > > > > >
> > > > > > Downloadable assets:
> > > > > > disk image: https://storage.googleapis.com/syzbot-assets/0d36ec=
76edc7/disk-c0b83251.raw.xz
> > > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/6f9bb4e37=
dd0/vmlinux-c0b83251.xz
> > > > > > kernel image: https://storage.googleapis.com/syzbot-assets/2349=
287b14b7/bzImage-c0b83251.xz
> > > > > >
> > > > > > IMPORTANT: if you fix the issue, please add the following tag t=
o the commit:
> > > > > > Reported-by: syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.=
com
> > > > > >
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > WARNING: suspicious RCU usage
> > > > > > 6.9.0-rc2-next-20240402-syzkaller #0 Not tainted
> > > > > > -----------------------------
> > > > > > kernel/rcu/tree.c:276 Illegal rcu_softirq_qs() in RCU read-side=
 critical section!
> > > > > >
> > > > > > other info that might help us debug this:
> > > > > >
> > > > > >
> > > > > > rcu_scheduler_active =3D 2, debug_locks =3D 1
> > > > > > 1 lock held by ksoftirqd/0/16:
> > > > > >  #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}, at: rc=
u_lock_acquire include/linux/rcupdate.h:329 [inline]
> > > > > >  #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}, at: rc=
u_read_lock_sched include/linux/rcupdate.h:933 [inline]
> > > > > >  #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}, at: pf=
n_valid include/linux/mmzone.h:2019 [inline]
> > > > > >  #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}, at: __=
virt_addr_valid+0x183/0x520 arch/x86/mm/physaddr.c:65
> > > > > >
> > > > > > stack backtrace:
> > > > > > CPU: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.9.0-rc2-next-202=
40402-syzkaller #0
> > > > > > Hardware name: Google Google Compute Engine/Google Compute Engi=
ne, BIOS Google 03/27/2024
> > > > > > Call Trace:
> > > > > >  <IRQ>
> > > > > >  __dump_stack lib/dump_stack.c:88 [inline]
> > > > > >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
> > > > > >  lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:67=
12
> > > > > >  rcu_softirq_qs+0xd9/0x370 kernel/rcu/tree.c:273
> > > > > >  __do_softirq+0x5fd/0x980 kernel/softirq.c:568
> > >
> > > Huh.  This statement is supposed to prevent this call to __do_softirq=
()
> > > from interrupt exit::
> > >
> > >         if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> > >             __this_cpu_read(ksoftirqd) =3D=3D current)
> > >
> > > So was the ksoftirqd kthread interrupted at a point where it happens =
to
> > > have softirq enabled?
> >
> > It should look like this:
> > schedule()
> > switch_to ksoftirqd/0
> > finish_task_switch
>
> So this CPU's ksoftirqd task is running.
>
> > ->put_task_struct_rcu_user
> >    ->call_rcu(&task->rcu, delayed_put_task_struct)
> >       ->__kasan_record_aux_stack
> >          ->pfn_valid
> >             ->rcu_read_lock_sched
> >                 <interrupt>
> >                  __irq_exit_rcu
> >                  ->__do_softirq
> >                     -> if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> >                              __this_cpu_read(ksoftirqd) =3D=3D current)
>
> But we are also running __do_softirq() from return from interrupt.  While
> running in this mode, we are not supposed to invoke rcu_softirq_qs().
> But the "__this_cpu_read(ksoftirqd) =3D=3D current" check yields "true",
> so we do call rcu_softirq_qs() anyway.  That is a bug.
>
> We need to upgrade or replace that check to something that returns true
> only if called at process level from ksoftirqd.
>
> Any thoughts on a good way to do that?  For example, would adding "&&
> in_task()" do the trick, or are there other unfortunate corner cases?

The rcu_softirq_qs() is invoked in softirq_handle_begin/end() critical sect=
ion,
in softirqd/0 task context,  the "in_task()" should return false, will miss
qs report in softirqd/0 task context.

diff --git a/kernel/softirq.c b/kernel/softirq.c
index b315b21fb28c..9b8f0c0f7675 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -563,10 +563,6 @@ asmlinkage __visible void __softirq_entry
__do_softirq(void)
                pending >>=3D softirq_bit;
        }

-       if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
-           __this_cpu_read(ksoftirqd) =3D=3D current)
-               rcu_softirq_qs();
-
        local_irq_disable();

        pending =3D local_softirq_pending();
@@ -915,6 +911,8 @@ static int ksoftirqd_should_run(unsigned int cpu)

 static void run_ksoftirqd(unsigned int cpu)
 {
+       unsigned long last_qs =3D jiffies;
+
        ksoftirqd_run_begin();
        if (local_softirq_pending()) {
                /*
@@ -923,6 +921,7 @@ static void run_ksoftirqd(unsigned int cpu)
                 */
                __do_softirq();
                ksoftirqd_run_end();
+               rcu_softirq_qs_periodic(last_qs);
                cond_resched();
                return;
        }

Any thoughts?

Thanks
Zqiang


>
> (And good job tracking this down, by the way!)
>
>                                                         Thanx, Paul
>
> >                               rcu_softirq_qs
> >                                ->
> > RCU_LOCKDEP_WARN(lock_is_held(&rcu_sched_lock_map))
> >
> > Thanks
> > Zqiang
> >
> >
> > >
> > >                                                         Thanx, Paul
> > >
> > > > > >  invoke_softirq kernel/softirq.c:428 [inline]
> > > > > >  __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
> > > > > >  irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
> > > > > >  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:=
1043 [inline]
> > > > > >  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/api=
c.c:1043
> > > > > >  </IRQ>
> > > > > >  <TASK>
> > > > > >  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm=
/idtentry.h:702
> > > > > > RIP: 0010:debug_lockdep_rcu_enabled+0xd/0x40 kernel/rcu/update.=
c:320
> > > > > > Code: f5 90 0f 0b 90 90 90 eb c6 0f 1f 40 00 90 90 90 90 90 90 =
90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 31 c0 83 3d c7 0f 28 04 00 <74> 1=
e 83 3d 26 42 28 04 00 74 15 65 48 8b 0c 25 c0 d3 03 00 31 c0
> > > > > > RSP: 0018:ffffc90000157a50 EFLAGS: 00000202
> > > > > > RAX: 0000000000000000 RBX: 00000000000000a0 RCX: 00000000000000=
01
> > > > > > RDX: dffffc0000000000 RSI: ffffffff8bcae740 RDI: ffffffff8c1f7e=
c0
> > > > > > RBP: dffffc0000000000 R08: ffffffff92f3a527 R09: 1ffffffff25e74=
a4
> > > > > > R10: dffffc0000000000 R11: fffffbfff25e74a5 R12: 00000000293735=
78
> > > > > > R13: 1ffff9200002af64 R14: ffffffff814220f3 R15: ffff88813fff90=
a0
> > > > > >  rcu_read_lock_sched include/linux/rcupdate.h:934 [inline]
> > > > > >  pfn_valid include/linux/mmzone.h:2019 [inline]
> > > > > >  __virt_addr_valid+0x1a9/0x520 arch/x86/mm/physaddr.c:65
> > > > > >  kasan_addr_to_slab+0xd/0x80 mm/kasan/common.c:37
> > > > > >  __kasan_record_aux_stack+0x11/0xc0 mm/kasan/generic.c:526
> > > > >
> > > > >
> > > > > This should be caused by the following commit:
> > > > > d818cc76e2b4 ("kasan: Record work creation stack trace with inter=
rupts enabled")
> > > > >
> > > > > Is it possible to make the rcu_softirq_qs() run only in ksoftirqd=
 task?
> > > >
> > > > use rcu_softirq_qs_periodic() in run_ksoftirqd().
> > > >
> > > > >
> > > > > Thanks
> > > > > Zqiang
> > > > >
> > > > > >  __call_rcu_common kernel/rcu/tree.c:3096 [inline]
> > > > > >  call_rcu+0x167/0xa70 kernel/rcu/tree.c:3200
> > > > > >  context_switch kernel/sched/core.c:5412 [inline]
> > > > > >  __schedule+0x17f0/0x4a50 kernel/sched/core.c:6746
> > > > > >  __schedule_loop kernel/sched/core.c:6823 [inline]
> > > > > >  schedule+0x14b/0x320 kernel/sched/core.c:6838
> > > > > >  smpboot_thread_fn+0x61e/0xa30 kernel/smpboot.c:160
> > > > > >  kthread+0x2f0/0x390 kernel/kthread.c:388
> > > > > >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> > > > > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
> > > > > >  </TASK>
> > > > > > ----------------
> > > > > > Code disassembly (best guess):
> > > > > >    0:   f5                      cmc
> > > > > >    1:   90                      nop
> > > > > >    2:   0f 0b                   ud2
> > > > > >    4:   90                      nop
> > > > > >    5:   90                      nop
> > > > > >    6:   90                      nop
> > > > > >    7:   eb c6                   jmp    0xffffffcf
> > > > > >    9:   0f 1f 40 00             nopl   0x0(%rax)
> > > > > >    d:   90                      nop
> > > > > >    e:   90                      nop
> > > > > >    f:   90                      nop
> > > > > >   10:   90                      nop
> > > > > >   11:   90                      nop
> > > > > >   12:   90                      nop
> > > > > >   13:   90                      nop
> > > > > >   14:   90                      nop
> > > > > >   15:   90                      nop
> > > > > >   16:   90                      nop
> > > > > >   17:   90                      nop
> > > > > >   18:   90                      nop
> > > > > >   19:   90                      nop
> > > > > >   1a:   90                      nop
> > > > > >   1b:   90                      nop
> > > > > >   1c:   90                      nop
> > > > > >   1d:   f3 0f 1e fa             endbr64
> > > > > >   21:   31 c0                   xor    %eax,%eax
> > > > > >   23:   83 3d c7 0f 28 04 00    cmpl   $0x0,0x4280fc7(%rip)    =
    # 0x4280ff1
> > > > > > * 2a:   74 1e                   je     0x4a <-- trapping instru=
ction
> > > > > >   2c:   83 3d 26 42 28 04 00    cmpl   $0x0,0x4284226(%rip)    =
    # 0x4284259
> > > > > >   33:   74 15                   je     0x4a
> > > > > >   35:   65 48 8b 0c 25 c0 d3    mov    %gs:0x3d3c0,%rcx
> > > > > >   3c:   03 00
> > > > > >   3e:   31 c0                   xor    %eax,%eax
> > > > > >
> > > > > >
> > > > > > ---
> > > > > > This report is generated by a bot. It may contain errors.
> > > > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > > > >
> > > > > > syzbot will keep track of this issue. See:
> > > > > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot=
.
> > > > > >
> > > > > > If the report is already addressed, let syzbot know by replying=
 with:
> > > > > > #syz fix: exact-commit-title
> > > > > >
> > > > > > If you want syzbot to run the reproducer, reply with:
> > > > > > #syz test: git://repo/address.git branch-or-commit-hash
> > > > > > If you attach or paste a git patch, syzbot will apply it before=
 testing.
> > > > > >
> > > > > > If you want to overwrite report's subsystems, reply with:
> > > > > > #syz set subsystems: new-subsystem
> > > > > > (See the list of subsystem names on the web dashboard)
> > > > > >
> > > > > > If the report is a duplicate of another one, reply with:
> > > > > > #syz dup: exact-subject-of-another-report
> > > > > >
> > > > > > If you want to undo deduplication, reply with:
> > > > > > #syz undup
> > > > > >

