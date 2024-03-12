Return-Path: <linux-kernel+bounces-100796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15108879D64
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE228283C5C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495F6143742;
	Tue, 12 Mar 2024 21:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiOVYh5j"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429D9143728;
	Tue, 12 Mar 2024 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710278305; cv=none; b=VwRo9Ch4bgYijmjHAsqzUViyLsRI8u6fZ8U1RRn3e4rg7Elrs10t3E6Po5sLGg9HVLszE/iJbYcS6zDeT2mA/UVDJnekowECUVDznkdvB7MbuFL4375Mr6LDO/Z+iYpF6n9QbarLjGoH4jNqA5Uw7QXRzON7qxTqPwyVtzgqUko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710278305; c=relaxed/simple;
	bh=nJh4MG9wvdVQwbiyNJsZHQmenVuFOOokfQj7Rfapaxc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hAEuZOOTPVahW/oolQ6l1WeiA5shx+59dCllnA+jvr8t7+usyCOxbgSbVORNzkhsGFMYD9XPA1bPFpQAzKd2KDVsuv0jwHSadJPFWfPII9vuHIVsM/2HYnb9FpXERJIcjEXOtxV82j+Jr2KU61LKo74p7j369T+Fwmi9sq04MAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiOVYh5j; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5131a9b3d5bso5871889e87.0;
        Tue, 12 Mar 2024 14:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710278301; x=1710883101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t2aRpeIAgeaih+2klQp9MGfZB3m964kYbQxgG/8UA8w=;
        b=IiOVYh5jUjE3HgDWo/0bVTvLZQy5i+/NbcEDcw+M/c53ovaQYNaCsh6k7dl5wv3dKK
         eUxJzOuethph2/+cx6RJ0MPJE6mrGG5DySVHjtnRb5z7z3bBh46ajhlpZlOqIjAyOVEP
         vGLWr4TJ8pl6zK+Nz5+njBB/YcoDuHOurh6YGky/bWAj04+aHGzpdaQEJ+MpytDCu/Vt
         YE6H1N4RMIHf1WPHy3lHXPuhE61KoSBhWXSDevtUam9ublkmSqrvtMc1rR2bYqoHL6AP
         MBD/lq6odKjbl/UpspHOHfBCWLxpsQlM8gHf6tfK6fFP3E4dN9LqeV4zByqc72ntbwAr
         Fp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710278301; x=1710883101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2aRpeIAgeaih+2klQp9MGfZB3m964kYbQxgG/8UA8w=;
        b=dCBvO5geOkf3qgAQjCQtyZ1P/tXrXCvokdDZLXd6zzuiVZ5Pi7jrTUk+AzBPOyLXF8
         of1/tOdI1HbAEnuLlucjk+Cqz8+++nbPijs1qdMozdi1Yji2+uhC/Ji/O3IYK6CgIqAj
         FzJDZLguouxtsTZ3kPJNqVKIRXBkkUotshNaA4/iqOUJc9ubKVRNg45gFQnGpjm1D7V6
         2IZRVkvPWFBo+CSf8DAWElw+qAEaRPnXCo0UBiAc9+ZKDQ07gV/JbmK5TMapppWHSFJO
         iG2whTRZXtE7hkeZY1SoBsby/yOzmhcqqZ4mB5HRFxOlEqW8zoteRG4GXHVo9+eOBprl
         nnNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmKbI7l6ebydilXlfVyOYx8BIfA/CiKYj0wVAPlGkMARx26F8O5hmcrD1QRqbkHVTBXfOXD5nP3BXf9JEFD8UZ+er6XeUOFFFvfC5yClTCtWNrWUqAERwKmJZIwyqb3Y9tClgBSc32+k2d6NQQ+AP291btXViojT4/
X-Gm-Message-State: AOJu0Ywt3B1VPNKLV0n81hiUBkJIaCyzqkOv4/KkPMV5U4pu5Z9VE9y/
	VQ+IUJiSN9c+8dNf2ADMNf5CcYS6hTaCCXf39IRtonTEJAISLzlc
X-Google-Smtp-Source: AGHT+IEpfjV5gf5tI9N8v46w5wgynnK7yZidvziDpMT+rRlYoWXZBKs8O7TYqe3F9rQv65eYKyKFJw==
X-Received: by 2002:a05:6512:32b7:b0:513:2caf:15ee with SMTP id q23-20020a05651232b700b005132caf15eemr983423lfe.28.1710278301031;
        Tue, 12 Mar 2024 14:18:21 -0700 (PDT)
Received: from krava ([83.240.63.214])
        by smtp.gmail.com with ESMTPSA id bn5-20020a170907268500b00a461d8335f2sm2807725ejc.45.2024.03.12.14.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 14:18:20 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 12 Mar 2024 22:18:18 +0100
To: Jiri Olsa <olsajiri@gmail.com>
Cc: syzbot <syzbot+850aaf14624dc0c6d366@syzkaller.appspotmail.com>,
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, linux-kernel@vger.kernel.org,
	martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] possible deadlock in __bpf_ringbuf_reserve
Message-ID: <ZfDGmoOcUqrHPSkq@krava>
References: <0000000000004aa700061379547e@google.com>
 <ZfDC45Kc1VEvBMuW@krava>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfDC45Kc1VEvBMuW@krava>

On Tue, Mar 12, 2024 at 10:02:27PM +0100, Jiri Olsa wrote:
> On Tue, Mar 12, 2024 at 09:41:26AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    df4793505abd Merge tag 'net-6.8-rc8' of git://git.kernel.o..
> > git tree:       bpf
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=11fd0092180000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c11c5c676adb61f0
> > dashboard link: https://syzkaller.appspot.com/bug?extid=850aaf14624dc0c6d366
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1509c4ae180000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10babc01180000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/d2e80ee1112b/disk-df479350.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/b35ea54cd190/vmlinux-df479350.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/59f69d999ad2/bzImage-df479350.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+850aaf14624dc0c6d366@syzkaller.appspotmail.com
> > 
> > ============================================
> > WARNING: possible recursive locking detected
> > 6.8.0-rc7-syzkaller-gdf4793505abd #0 Not tainted
> > --------------------------------------------
> > strace-static-x/5063 is trying to acquire lock:
> > ffffc900096f10d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x211/0x4f0 kernel/bpf/ringbuf.c:424
> > 
> > but task is already holding lock:
> > ffffc900098410d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x211/0x4f0 kernel/bpf/ringbuf.c:424
> > 
> > other info that might help us debug this:
> >  Possible unsafe locking scenario:
> > 
> >        CPU0
> >        ----
> >   lock(&rb->spinlock);
> >   lock(&rb->spinlock);
> > 
> >  *** DEADLOCK ***
> > 
> >  May be due to missing lock nesting notation
> > 
> > 4 locks held by strace-static-x/5063:
> >  #0: ffff88807857e068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:103 [inline]
> >  #0: ffff88807857e068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x1cc/0x1a40 fs/pipe.c:465
> >  #1: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
> >  #1: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
> >  #1: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
> >  #1: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420
> >  #2: ffffc900098410d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x211/0x4f0 kernel/bpf/ringbuf.c:424
> >  #3: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
> >  #3: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
> >  #3: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
> >  #3: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420
> > 
> > stack backtrace:
> > CPU: 0 PID: 5063 Comm: strace-static-x Not tainted 6.8.0-rc7-syzkaller-gdf4793505abd #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
> >  check_deadlock kernel/locking/lockdep.c:3062 [inline]
> >  validate_chain+0x15c0/0x58e0 kernel/locking/lockdep.c:3856
> >  __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
> >  lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
> >  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
> >  __bpf_ringbuf_reserve+0x211/0x4f0 kernel/bpf/ringbuf.c:424
> >  ____bpf_ringbuf_reserve kernel/bpf/ringbuf.c:459 [inline]
> >  bpf_ringbuf_reserve+0x5c/0x70 kernel/bpf/ringbuf.c:451
> >  bpf_prog_9efe54833449f08e+0x2d/0x47
> >  bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
> >  __bpf_prog_run include/linux/filter.h:651 [inline]
> >  bpf_prog_run include/linux/filter.h:658 [inline]
> >  __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
> 
> hum, scratching my head how this could passed through the prog->active check,

nah could be 2 instances of the same program, got confused by the tag

trace_contention_end
  __bpf_trace_run(prog1)
    bpf_prog_9efe54833449f08e
      bpf_ringbuf_reserve
        trace_contention_end
          __bpf_trace_run(prog1)  prog1->active check fails
          __bpf_trace_run(prog2) 
            bpf_prog_9efe54833449f08e
              bpf_ringbuf_reserve
                lockup

we had similar issue in [1] and we replaced the lock with extra buffers,
not sure that's possible in bpf_ringbuf_reserve

jirka


[1] e2bb9e01d589 bpf: Remove trace_printk_lock

> will try to reproduce
> 
> jirka
> 
> >  bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
> >  __traceiter_contention_end+0x7b/0xb0 include/trace/events/lock.h:122
> >  trace_contention_end+0xf6/0x120 include/trace/events/lock.h:122
> >  __pv_queued_spin_lock_slowpath+0x939/0xc60 kernel/locking/qspinlock.c:560
> >  pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
> >  queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
> >  queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
> >  do_raw_spin_lock+0x271/0x370 kernel/locking/spinlock_debug.c:116
> >  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
> >  _raw_spin_lock_irqsave+0xe1/0x120 kernel/locking/spinlock.c:162
> >  __bpf_ringbuf_reserve+0x211/0x4f0 kernel/bpf/ringbuf.c:424
> >  ____bpf_ringbuf_reserve kernel/bpf/ringbuf.c:459 [inline]
> >  bpf_ringbuf_reserve+0x5c/0x70 kernel/bpf/ringbuf.c:451
> >  bpf_prog_9efe54833449f08e+0x2d/0x47
> >  bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
> >  __bpf_prog_run include/linux/filter.h:651 [inline]
> >  bpf_prog_run include/linux/filter.h:658 [inline]
> >  __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
> >  bpf_trace_run2+0x204/0x420 kernel/trace/bpf_trace.c:2420
> >  __traceiter_contention_end+0x7b/0xb0 include/trace/events/lock.h:122
> >  trace_contention_end+0xd7/0x100 include/trace/events/lock.h:122
> >  __mutex_lock_common kernel/locking/mutex.c:617 [inline]
> >  __mutex_lock+0x2e4/0xd70 kernel/locking/mutex.c:752
> >  __pipe_lock fs/pipe.c:103 [inline]
> >  pipe_write+0x1cc/0x1a40 fs/pipe.c:465
> >  call_write_iter include/linux/fs.h:2087 [inline]
> >  new_sync_write fs/read_write.c:497 [inline]
> >  vfs_write+0xa81/0xcb0 fs/read_write.c:590
> >  ksys_write+0x1a0/0x2c0 fs/read_write.c:643
> >  do_syscall_64+0xf9/0x240
> >  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> > RIP: 0033:0x4e8593
> > Code: c7 c2 a8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
> > RSP: 002b:00007ffeda768928 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> > RAX: ffffffffffffffda RBX: 0000000000000012 RCX: 00000000004e8593
> > RDX: 0000000000000012 RSI: 0000000000817140 RDI: 0000000000000002
> > RBP: 0000000000817140 R08: 0000000000000010 R09: 0000000000000090
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000012
> > R13: 000000000063f460 R14: 0000000000000012 R15: 0000000000000001
> >  </TASK>
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > 
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> > 
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> > 
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> > 
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> > 
> > If you want to undo deduplication, reply with:
> > #syz undup

