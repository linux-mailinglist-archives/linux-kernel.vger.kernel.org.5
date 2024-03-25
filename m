Return-Path: <linux-kernel+bounces-118072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 922BB88B34D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF22A3051BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1230371747;
	Mon, 25 Mar 2024 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTUkdaVS"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C4B5C61A;
	Mon, 25 Mar 2024 21:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403887; cv=none; b=ZEtL35kH9MjtjqLpB3xeXCelstimdX3kB/GNjF8PB0GS0sO9JLiX7TaDpiZ5T0+c/hQ1moH80/d0iJtX+Rocyn+sIBV8B/e6dRA1Vs3DXRQbMW1PlnEIh5w+tRz3O7psEbGoEl2E3M/SNkSyxSmmGHH4RTWz5qjo5PCJ48PGQpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403887; c=relaxed/simple;
	bh=9zcBz0oJMqUaSZ6zjJbhC0dvxtDLjwD0b4FuoA8VI1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PsASczRWBOADmSEN9eOPQIeA9ajSlGjDf+99GeZSw7l2n2eVpbV+0r1YbVAOPCkmb/0Gjp7o3Vm1/xEmcHydXoZadDWEDDSm2kSqhbAwdYa29T/m/ZBNi+Mb/JPJdorvDtltzS47+3DXb4OQEpwzNkB1MXWj+SZWy74e8taRFLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTUkdaVS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1def142ae7bso42682375ad.3;
        Mon, 25 Mar 2024 14:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711403884; x=1712008684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXqYZX12K2yMJ2EUbAsPOB7tiwu9Gd7UkxKwlCQ8Y/E=;
        b=kTUkdaVSnzizLvjcjK+qOYSvwqpg0XeJ2p5uK3LzS3LAQZkWSq4/bKFhio2glU4Sg9
         uuwzW5oyAkcgy3GlSTeo9pLrAcLiFoTgkl4TBq1DrfZjO3hjU01bxwN3KpjTOpOXGAnr
         aRUfJETNq645PVNESzw1TudK4cDqpS0CmcA/tm+xDLQGak5iAa+xRBWtLIYEPtnhix0C
         Rp05RVsFl4cCJWODap7yj8m6x2+trrNwzDqYPcPECsFWfp48ByU4DG+MUuXWReRzrQ/w
         OBKHFHuE60RRUfkwTa5J3pZV3gjaT4Hr6GSBYHcjmroVmmUbvGFvMLuSSDmvlL1LkOfe
         Nzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711403884; x=1712008684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXqYZX12K2yMJ2EUbAsPOB7tiwu9Gd7UkxKwlCQ8Y/E=;
        b=wKKkMG8dPN1JOPnc35x+Eb5FzDMbdUD1QH66et5oldbq+hHysL8lXQgSZJO/xi3lGC
         DK+tH4/Pacgl601pzZLJ2lomoMFyMyntZ/w8xnJGvIsLunXoOoAMO0jkg1Ey+mrcPd0Q
         1oQsIG8EYvXHEcbtUWkvC4bqoNQ36HRPUirDNUl00zOhkzT6q1j05wfv7YWkkfcc5lId
         DVHDk3mh2AuD1LGiyyVlyDam31JMoSZIJTsOMK0QddP1wkmksmtMk/X8CuR0bgozU3wU
         +kO8ZXa2dPKUIwS6BfQvE0yo/fC4aVxbEy97AbNycWGr9447lGG9Vjsjok9sHW+F1ebW
         iS/A==
X-Forwarded-Encrypted: i=1; AJvYcCWN4zHgWIeelvxdBXxxkCETY8eF3cIXSEm/X/IHNu9wJCSlCldOVs3Mqmf4f7wXR8lA69jF24l6ujkWg/hCVJqdTWg1s+DuOiB6O/YBT+UzILddIJHxiF71veCa1fJoFxlh5tdgtOdClU2/dVV2QB2+rKVX/jVr9fJD/RYCaUFCvdoHobv8Iu9W4liMNnJrpeVf8IzmCY5wuYogXwfl
X-Gm-Message-State: AOJu0YwwwcYUpCrB4K+3L/eVvDKTb1pMWZQvP47/qLX80qjOp6AZRzHv
	Vc3QodUPPfh306TJgZy5t5glq5rafRbo76F7HYBrYks5slVHdFF0eH4hXcnHYJygzFcWRjhThSC
	lU7hKnnmSl4gLISxGDxs5PYSQBcI=
X-Google-Smtp-Source: AGHT+IHdBbecoAT7KU7dxkFfqoLe96eHupuZkzvI1QJg+deek8JvLxSMdGshCpF795bCvbSHORvTGU7RVQ9ZQxACgTA=
X-Received: by 2002:a17:903:18a:b0:1e0:b709:139b with SMTP id
 z10-20020a170903018a00b001e0b709139bmr5373081plg.56.1711403883899; Mon, 25
 Mar 2024 14:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000b906b406147069d4@google.com> <CAADnVQLXZ+ro7cKF-K2gnGeit1jxJEPej2Ue3PstvGN+kW02BA@mail.gmail.com>
 <CAEf4BzaOk6-w+NLVr9=37QKHFXs3SbPnu5a5YDdsYFx9M91Y4w@mail.gmail.com>
In-Reply-To: <CAEf4BzaOk6-w+NLVr9=37QKHFXs3SbPnu5a5YDdsYFx9M91Y4w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 25 Mar 2024 14:57:51 -0700
Message-ID: <CAEf4BzZXZdaYf65diW6ZSuS1OmskuE5od4a7yKpne9ezRqwWfA@mail.gmail.com>
Subject: Re: raw_tp+cookie is buggy. Was: [syzbot] [bpf?] [trace?] KASAN:
 slab-use-after-free Read in bpf_trace_run1
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: syzbot <syzbot+981935d9485a560bfbcb@syzkaller.appspotmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eddy Z <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Stanislav Fomichev <sdf@google.com>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 10:27=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Mar 24, 2024 at 5:07=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > Hi Andrii,
> >
> > syzbot found UAF in raw_tp cookie series in bpf-next.
> > Reverting the whole merge
> > 2e244a72cd48 ("Merge branch 'bpf-raw-tracepoint-support-for-bpf-cookie'=
")
> >
> > fixes the issue.
> >
> > Pls take a look.
> > See C reproducer below. It splats consistently with CONFIG_KASAN=3Dy
> >
> > Thanks.
>
> Will do, traveling today, so will be offline for a bit, but will check
> first thing afterwards.
>

Ok, so I don't think it's bpf_raw_tp_link specific, it should affect a
bunch of other links (unless I missed something). Basically, when last
link refcnt drops, we detach, do bpf_prog_put() and then proceed to
kfree link itself synchronously. But that link can still be referred
from running BPF program (I think multi-kprobe/multi-uprobe use it for
cookies, raw_tp with my changes started using link at runtime, there
are probably more types), and so if we free this memory synchronously,
we can have UAF.

We should do what we do for bpf_maps and delay freeing, the only
question is how tunable that freeing can be? Always do call_rcu()?
Always call_rcu_tasks_trace() (relevant for sleepable multi-uprobes)?
Should we allow synchronous free if link is not directly accessible
from program during its run?

Anyway, I sent a fix as an RFC so we can discuss.

> >
> > On Sun, Mar 24, 2024 at 4:28=E2=80=AFPM syzbot
> > <syzbot+981935d9485a560bfbcb@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    520fad2e3206 selftests/bpf: scale benchmark counting =
by us..
> > > git tree:       bpf-next
> > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D105af9461=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6fb1be60a=
193d440
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D981935d9485=
a560bfbcb
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for=
 Debian) 2.40
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D114f17a=
5180000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D162bb7a51=
80000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/4eef3506c5ce=
/disk-520fad2e.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/24d60ebe76cc/vm=
linux-520fad2e.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/8f883e7065=
50/bzImage-520fad2e.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+981935d9485a560bfbcb@syzkaller.appspotmail.com
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > BUG: KASAN: slab-use-after-free in __bpf_trace_run kernel/trace/bpf_t=
race.c:2376 [inline]
> > > BUG: KASAN: slab-use-after-free in bpf_trace_run1+0xcb/0x510 kernel/t=
race/bpf_trace.c:2430
> > > Read of size 8 at addr ffff8880290d9918 by task migration/0/19
> > >
> > > CPU: 0 PID: 19 Comm: migration/0 Not tainted 6.8.0-syzkaller-05233-g5=
20fad2e3206 #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 02/29/2024
> > > Stopper: 0x0 <- 0x0
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:88 [inline]
> > >  dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
> > >  print_address_description mm/kasan/report.c:377 [inline]
> > >  print_report+0x169/0x550 mm/kasan/report.c:488
> > >  kasan_report+0x143/0x180 mm/kasan/report.c:601
> > >  __bpf_trace_run kernel/trace/bpf_trace.c:2376 [inline]
> > >  bpf_trace_run1+0xcb/0x510 kernel/trace/bpf_trace.c:2430
> > >  __traceiter_rcu_utilization+0x74/0xb0 include/trace/events/rcu.h:27
> > >  trace_rcu_utilization+0x194/0x1c0 include/trace/events/rcu.h:27
> > >  rcu_note_context_switch+0xc7c/0xff0 kernel/rcu/tree_plugin.h:360
> > >  __schedule+0x345/0x4a20 kernel/sched/core.c:6635
> > >  __schedule_loop kernel/sched/core.c:6813 [inline]
> > >  schedule+0x14b/0x320 kernel/sched/core.c:6828
> > >  smpboot_thread_fn+0x61e/0xa30 kernel/smpboot.c:160
> > >  kthread+0x2f0/0x390 kernel/kthread.c:388
> > >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
> > >  </TASK>
> > >
> > > Allocated by task 5075:
> > >  kasan_save_stack mm/kasan/common.c:47 [inline]
> > >  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> > >  poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
> > >  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
> > >  kasan_kmalloc include/linux/kasan.h:211 [inline]
> > >  kmalloc_trace+0x1d9/0x360 mm/slub.c:4012
> > >  kmalloc include/linux/slab.h:590 [inline]
> > >  kzalloc include/linux/slab.h:711 [inline]
> > >  bpf_raw_tp_link_attach+0x2a0/0x6e0 kernel/bpf/syscall.c:3816
> > >  bpf_raw_tracepoint_open+0x1c2/0x240 kernel/bpf/syscall.c:3863
> > >  __sys_bpf+0x3c0/0x810 kernel/bpf/syscall.c:5673
> > >  __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
> > >  __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
> > >  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
> > >  do_syscall_64+0xfb/0x240
> > >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > >
> > > Freed by task 5075:
> > >  kasan_save_stack mm/kasan/common.c:47 [inline]
> > >  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
> > >  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:589
> > >  poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
> > >  __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
> > >  kasan_slab_free include/linux/kasan.h:184 [inline]
> > >  slab_free_hook mm/slub.c:2121 [inline]
> > >  slab_free mm/slub.c:4299 [inline]
> > >  kfree+0x14a/0x380 mm/slub.c:4409
> > >  bpf_link_release+0x3b/0x50 kernel/bpf/syscall.c:3071
> > >  __fput+0x429/0x8a0 fs/file_table.c:423
> > >  task_work_run+0x24f/0x310 kernel/task_work.c:180
> > >  exit_task_work include/linux/task_work.h:38 [inline]
> > >  do_exit+0xa1b/0x27e0 kernel/exit.c:878
> > >  do_group_exit+0x207/0x2c0 kernel/exit.c:1027
> > >  __do_sys_exit_group kernel/exit.c:1038 [inline]
> > >  __se_sys_exit_group kernel/exit.c:1036 [inline]
> > >  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
> > >  do_syscall_64+0xfb/0x240
> > >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > >
> > > The buggy address belongs to the object at ffff8880290d9900
> > >  which belongs to the cache kmalloc-128 of size 128
> > > The buggy address is located 24 bytes inside of
> > >  freed 128-byte region [ffff8880290d9900, ffff8880290d9980)
> > >
> > > The buggy address belongs to the physical page:
> > > page:ffffea0000a43640 refcount:1 mapcount:0 mapping:0000000000000000 =
index:0x0 pfn:0x290d9
> > > anon flags: 0xfff00000000800(slab|node=3D0|zone=3D1|lastcpupid=3D0x7f=
f)
> > > page_type: 0xffffffff()
> > > raw: 00fff00000000800 ffff888014c418c0 0000000000000000 0000000000000=
001
> > > raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000=
000
> > > page dumped because: kasan: bad access detected
> > > page_owner tracks the page as allocated
> > > page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12=
cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 4527, tgid 4527 (udevd), ts=
 43150902736, free_ts 43094996342
> > >  set_page_owner include/linux/page_owner.h:31 [inline]
> > >  post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
> > >  prep_new_page mm/page_alloc.c:1540 [inline]
> > >  get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
> > >  __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
> > >  __alloc_pages_node include/linux/gfp.h:238 [inline]
> > >  alloc_pages_node include/linux/gfp.h:261 [inline]
> > >  alloc_slab_page+0x5f/0x160 mm/slub.c:2190
> > >  allocate_slab mm/slub.c:2354 [inline]
> > >  new_slab+0x84/0x2f0 mm/slub.c:2407
> > >  ___slab_alloc+0xd1b/0x13e0 mm/slub.c:3540
> > >  __slab_alloc mm/slub.c:3625 [inline]
> > >  __slab_alloc_node mm/slub.c:3678 [inline]
> > >  slab_alloc_node mm/slub.c:3850 [inline]
> > >  kmalloc_trace+0x267/0x360 mm/slub.c:4007
> > >  kmalloc include/linux/slab.h:590 [inline]
> > >  kzalloc include/linux/slab.h:711 [inline]
> > >  kernfs_get_open_node fs/kernfs/file.c:523 [inline]
> > >  kernfs_fop_open+0x803/0xcd0 fs/kernfs/file.c:691
> > >  do_dentry_open+0x907/0x15a0 fs/open.c:956
> > >  do_open fs/namei.c:3643 [inline]
> > >  path_openat+0x2860/0x3240 fs/namei.c:3800
> > >  do_filp_open+0x235/0x490 fs/namei.c:3827
> > >  do_sys_openat2+0x13e/0x1d0 fs/open.c:1407
> > >  do_sys_open fs/open.c:1422 [inline]
> > >  __do_sys_openat fs/open.c:1438 [inline]
> > >  __se_sys_openat fs/open.c:1433 [inline]
> > >  __x64_sys_openat+0x247/0x2a0 fs/open.c:1433
> > >  do_syscall_64+0xfb/0x240
> > >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > > page last free pid 4526 tgid 4526 stack trace:
> > >  reset_page_owner include/linux/page_owner.h:24 [inline]
> > >  free_pages_prepare mm/page_alloc.c:1140 [inline]
> > >  free_unref_page_prepare+0x968/0xa90 mm/page_alloc.c:2346
> > >  free_unref_page+0x37/0x3f0 mm/page_alloc.c:2486
> > >  rcu_do_batch kernel/rcu/tree.c:2196 [inline]
> > >  rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2471
> > >  __do_softirq+0x2bc/0x943 kernel/softirq.c:554
> > >
> > > Memory state around the buggy address:
> > >  ffff8880290d9800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >  ffff8880290d9880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > >ffff8880290d9900: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >                             ^
> > >  ffff8880290d9980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > >  ffff8880290d9a00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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

