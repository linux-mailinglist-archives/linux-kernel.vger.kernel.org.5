Return-Path: <linux-kernel+bounces-100900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B363879EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9351C218D9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF673A8C3;
	Tue, 12 Mar 2024 22:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVvx4dLV"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989F8138E;
	Tue, 12 Mar 2024 22:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710283052; cv=none; b=n8Dr/NVC4KcMB9ERg2GJHOmn3oJsh+2NjewfohcRLQXn+TcHusPJh6pU9yp1wKE2wKlQ9hjft3siZRWJaxgB4JWN+NTB5oEWPkf4XyTwW/y0VS/w5ItGEeX+LU6yENudsczYaXR80yZhnPpspUkz5AgDVrzSqlfjjsF/Uu2LR0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710283052; c=relaxed/simple;
	bh=p9o2nc/lVXuQu7hk0G9hxXEmZN1WSRIM3iulUuK50Kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QpzY2mZdMPcM0eTaukDMfkTRfvIrhEQ+Rg8QIx0N11QWcSdyj+D13WOAvy2soKLs9zlsPkqaYuY2a5CzmKrwYic8e1CCjtxxokLB7KzyoaqMLBuVoIeNdKILPvPjeATYIpXT1j6qgkvd3aMv0HV2ozYkXfn2oSe+jdz6M2eh+88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVvx4dLV; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e55b33ad14so3307252b3a.1;
        Tue, 12 Mar 2024 15:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710283050; x=1710887850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqDdfqse8a/9SgDc7ZWNGTWOFS8enGOS+wsK61ONQGU=;
        b=eVvx4dLVdeCorZEQc48f11tZkJykM6j5ur5IObnjVKpjnDnkssBb+EDGdFUzLxVTT6
         1s9FQq4QRaJon3KHzvlfwOzvlTfk1lnlMrhM2WHTt+DMMgq5qKLBc1bsLEoFAZB7XyLr
         k/5VgF4GRx15v5igqKAR3/FHt0I7czeUZ61aIiFbdw016L+x6iesHklkAf9HopuVzZiL
         CrJDnuZ8S7c6TxyTsOsHQv1Rdeco+9z5AISbCP6meQuGimFwpgMs4qEbBFK8xp+wt0wp
         fXh4TtiCs5svkaEZZeNzymvsoB6g1BP5l0TGntbLimgO9wLcOcqHKgjAVUAAscKEX4uV
         McGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710283050; x=1710887850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqDdfqse8a/9SgDc7ZWNGTWOFS8enGOS+wsK61ONQGU=;
        b=u6w+UXde+aNXLMw23y2ByKNIe1Ec0GjBSjnwyZwjbP8ox+ZvQSRVljv1bjNDiRjbKH
         vXzUPs0a/HpRUTeKxJ4LBpudOHuqjC9qMJw5FMRhDfcOc6GB/wSVjNLoyi6SwRMnTaQi
         Cy2MN/uBGHwyykEXCAh9SjM3P7ZMshuR2aVoSPd1C+uYfmDATND1+G3URIoRAJYNi6Pt
         mdSp6oo2KJ7WMc3zWY6dkhpJ6mqHpVuhwu+JF13DCcNAWQjvWZnmsQubLoWxPKdstZZi
         jtEA/NUJQiafmYO73J70yN6tjGVpLbpWhg9vf8+rUWT5PuQCIkmO3pEeXfQlJ3u6xjAV
         YWjw==
X-Forwarded-Encrypted: i=1; AJvYcCXEV2GTWl8zZpvn7WocX/MQ4EIxavnBkp2DYOro9uAdnJtZP2paERMuESf0sf0sjgrXtr8u8pEMU12AYOZY8Yb3xmqEmznYfbeQw+WR2BlaLhFFchQTesUcvk78baq4ulKU0pyfb2d6tKDb4AjNyf9r2tUYTaM93aTy
X-Gm-Message-State: AOJu0YzQxvKsNyueb7yBz1DentkT1gIAsvtBB0NJsn2Mb91a/m1yEWSD
	HMHBsAw70aljxcZqbuXzosEfAM2xUPz0vMhQ1/KnFKTOkHgz9+Et0bx0dpa6WG3Z9hUKsfpb4Hq
	XFBYZjP0Qwpv3t3Ih38UB9OqcpdxMsf9jvkc=
X-Google-Smtp-Source: AGHT+IG8F51CmKEtJ55rR0EIP5bMQeNK1c5ASHxyndnP4FqOJ8wmtc1BUW+AC18do6kTV496PmiyuoodAD7Gk3H9MDk=
X-Received: by 2002:a05:6a20:9591:b0:1a0:cd54:6d9f with SMTP id
 iu17-20020a056a20959100b001a0cd546d9fmr10436041pzb.23.1710283049586; Tue, 12
 Mar 2024 15:37:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000004aa700061379547e@google.com> <ZfDC45Kc1VEvBMuW@krava> <ZfDGmoOcUqrHPSkq@krava>
In-Reply-To: <ZfDGmoOcUqrHPSkq@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Mar 2024 15:37:16 -0700
Message-ID: <CAEf4Bza8iH4_JY_sN-6GYeSfn6iuUsLMzxd=xRkCC7q-3_StNQ@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in __bpf_ringbuf_reserve
To: Jiri Olsa <olsajiri@gmail.com>
Cc: syzbot <syzbot+850aaf14624dc0c6d366@syzkaller.appspotmail.com>, 
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	haoluo@google.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 2:18=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Mar 12, 2024 at 10:02:27PM +0100, Jiri Olsa wrote:
> > On Tue, Mar 12, 2024 at 09:41:26AM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    df4793505abd Merge tag 'net-6.8-rc8' of git://git.ker=
nel.o..
> > > git tree:       bpf
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D11fd00921=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc11c5c676=
adb61f0
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D850aaf14624=
dc0c6d366
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for=
 Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1509c4a=
e180000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10babc011=
80000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/d2e80ee1112b=
/disk-df479350.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/b35ea54cd190/vm=
linux-df479350.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/59f69d999a=
d2/bzImage-df479350.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+850aaf14624dc0c6d366@syzkaller.appspotmail.com
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > WARNING: possible recursive locking detected
> > > 6.8.0-rc7-syzkaller-gdf4793505abd #0 Not tainted
> > > --------------------------------------------
> > > strace-static-x/5063 is trying to acquire lock:
> > > ffffc900096f10d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reser=
ve+0x211/0x4f0 kernel/bpf/ringbuf.c:424
> > >
> > > but task is already holding lock:
> > > ffffc900098410d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reser=
ve+0x211/0x4f0 kernel/bpf/ringbuf.c:424
> > >
> > > other info that might help us debug this:
> > >  Possible unsafe locking scenario:
> > >
> > >        CPU0
> > >        ----
> > >   lock(&rb->spinlock);
> > >   lock(&rb->spinlock);
> > >
> > >  *** DEADLOCK ***
> > >
> > >  May be due to missing lock nesting notation
> > >
> > > 4 locks held by strace-static-x/5063:
> > >  #0: ffff88807857e068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock f=
s/pipe.c:103 [inline]
> > >  #0: ffff88807857e068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x=
1cc/0x1a40 fs/pipe.c:465
> > >  #1: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acqui=
re include/linux/rcupdate.h:298 [inline]
> > >  #1: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock =
include/linux/rcupdate.h:750 [inline]
> > >  #1: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_ru=
n kernel/trace/bpf_trace.c:2380 [inline]
> > >  #1: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2=
+0x114/0x420 kernel/trace/bpf_trace.c:2420
> > >  #2: ffffc900098410d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_=
reserve+0x211/0x4f0 kernel/bpf/ringbuf.c:424
> > >  #3: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acqui=
re include/linux/rcupdate.h:298 [inline]
> > >  #3: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock =
include/linux/rcupdate.h:750 [inline]
> > >  #3: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_ru=
n kernel/trace/bpf_trace.c:2380 [inline]
> > >  #3: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2=
+0x114/0x420 kernel/trace/bpf_trace.c:2420
> > >
> > > stack backtrace:
> > > CPU: 0 PID: 5063 Comm: strace-static-x Not tainted 6.8.0-rc7-syzkalle=
r-gdf4793505abd #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 01/25/2024
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:88 [inline]
> > >  dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
> > >  check_deadlock kernel/locking/lockdep.c:3062 [inline]
> > >  validate_chain+0x15c0/0x58e0 kernel/locking/lockdep.c:3856
> > >  __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
> > >  lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
> > >  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline=
]
> > >  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
> > >  __bpf_ringbuf_reserve+0x211/0x4f0 kernel/bpf/ringbuf.c:424
> > >  ____bpf_ringbuf_reserve kernel/bpf/ringbuf.c:459 [inline]
> > >  bpf_ringbuf_reserve+0x5c/0x70 kernel/bpf/ringbuf.c:451
> > >  bpf_prog_9efe54833449f08e+0x2d/0x47
> > >  bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
> > >  __bpf_prog_run include/linux/filter.h:651 [inline]
> > >  bpf_prog_run include/linux/filter.h:658 [inline]
> > >  __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
> >
> > hum, scratching my head how this could passed through the prog->active =
check,
>
> nah could be 2 instances of the same program, got confused by the tag
>
> trace_contention_end
>   __bpf_trace_run(prog1)
>     bpf_prog_9efe54833449f08e
>       bpf_ringbuf_reserve
>         trace_contention_end
>           __bpf_trace_run(prog1)  prog1->active check fails
>           __bpf_trace_run(prog2)
>             bpf_prog_9efe54833449f08e
>               bpf_ringbuf_reserve
>                 lockup
>
> we had similar issue in [1] and we replaced the lock with extra buffers,
> not sure that's possible in bpf_ringbuf_reserve
>

Having trace_contention_begin and trace_contention_end in such
low-level parts of ringbuf (and I'm sure anything in BPF that's using
spinlock) is unfortunate. I'm not sure what's the best solution, but
it would be great if we had ability to disable these tracepoints when
taking lock in low-level BPF infrastructure. Given BPF programs can
attach to these tracepoints, it's best to avoid this arbitrary nesting
of BPF ringbuf calls. Also note, no per-program protection will help,
because it can be independent BPF programs using the same map.


> jirka
>
>
> [1] e2bb9e01d589 bpf: Remove trace_printk_lock
>
> > will try to reproduce
> >
> > jirka
> >
> > >  bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
> > >  __traceiter_contention_end+0x7b/0xb0 include/trace/events/lock.h:122
> > >  trace_contention_end+0xf6/0x120 include/trace/events/lock.h:122
> > >  __pv_queued_spin_lock_slowpath+0x939/0xc60 kernel/locking/qspinlock.=
c:560
> > >  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [in=
line]
> > >  queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h=
:51
> > >  queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
> > >  do_raw_spin_lock+0x271/0x370 kernel/locking/spinlock_debug.c:116
> > >  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline=
]
> > >  _raw_spin_lock_irqsave+0xe1/0x120 kernel/locking/spinlock.c:162
> > >  __bpf_ringbuf_reserve+0x211/0x4f0 kernel/bpf/ringbuf.c:424
> > >  ____bpf_ringbuf_reserve kernel/bpf/ringbuf.c:459 [inline]
> > >  bpf_ringbuf_reserve+0x5c/0x70 kernel/bpf/ringbuf.c:451
> > >  bpf_prog_9efe54833449f08e+0x2d/0x47
> > >  bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
> > >  __bpf_prog_run include/linux/filter.h:651 [inline]
> > >  bpf_prog_run include/linux/filter.h:658 [inline]
> > >  __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
> > >  bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
> > >  __traceiter_contention_end+0x7b/0xb0 include/trace/events/lock.h:122
> > >  trace_contention_end+0xd7/0x100 include/trace/events/lock.h:122
> > >  __mutex_lock_common kernel/locking/mutex.c:617 [inline]
> > >  __mutex_lock+0x2e4/0xd70 kernel/locking/mutex.c:752
> > >  __pipe_lock fs/pipe.c:103 [inline]
> > >  pipe_write+0x1cc/0x1a40 fs/pipe.c:465
> > >  call_write_iter include/linux/fs.h:2087 [inline]
> > >  new_sync_write fs/read_write.c:497 [inline]
> > >  vfs_write+0xa81/0xcb0 fs/read_write.c:590
> > >  ksys_write+0x1a0/0x2c0 fs/read_write.c:643
> > >  do_syscall_64+0xf9/0x240
> > >  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> > > RIP: 0033:0x4e8593
> > > Code: c7 c2 a8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f =
1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f=
0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
> > > RSP: 002b:00007ffeda768928 EFLAGS: 00000246 ORIG_RAX: 000000000000000=
1
> > > RAX: ffffffffffffffda RBX: 0000000000000012 RCX: 00000000004e8593
> > > RDX: 0000000000000012 RSI: 0000000000817140 RDI: 0000000000000002
> > > RBP: 0000000000817140 R08: 0000000000000010 R09: 0000000000000090
> > > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000012
> > > R13: 000000000063f460 R14: 0000000000000012 R15: 0000000000000001
> > >  </TASK>
> > >
> > >
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > >
> > > If the report is already addressed, let syzbot know by replying with:
> > > #syz fix: exact-commit-title
> > >
> > > If you want syzbot to run the reproducer, reply with:
> > > #syz test: git://repo/address.git branch-or-commit-hash
> > > If you attach or paste a git patch, syzbot will apply it before testi=
ng.
> > >
> > > If you want to overwrite report's subsystems, reply with:
> > > #syz set subsystems: new-subsystem
> > > (See the list of subsystem names on the web dashboard)
> > >
> > > If the report is a duplicate of another one, reply with:
> > > #syz dup: exact-subject-of-another-report
> > >
> > > If you want to undo deduplication, reply with:
> > > #syz undup

