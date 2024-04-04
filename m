Return-Path: <linux-kernel+bounces-132139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F3189902C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C38282DA2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37FC13C9B8;
	Thu,  4 Apr 2024 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5VaXenS"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70F513C3C0;
	Thu,  4 Apr 2024 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712265809; cv=none; b=pllZe3GDgI9tw5qDQ/4/WIrqiSM0H1Eo3cV7PiuJ5sWRzEcLE1I1y+0Crzp601Mj2ATLj/ul4cE6j4+WsxJZwYCw8SAwAWOwgCcGMuZLGzPegRQBPt5Z93nsc22dVip8n+kYBrqN0a37hW7xRl0o5s1/jsuueuMKbJP64eRt8Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712265809; c=relaxed/simple;
	bh=HQuZXyggUJXgToJVrsD1IOgHAHFlG6GTEjAQsSg6n5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oA55sVZY4KgVWaJBldrpEV26g+NRkEaZHEFCNOKVLztlumZ5kFK7iRbGDwiLrj1EBBxQAYd0qh1RGoHcg3Pw0e9rUgPl35Ij1awD7PVSMA91XIYheVtBRvq2iyTgcNvEr4cGDOAT+CNX6TOxNOU+OIfOZxmC/aT1lxhd+vRy1oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5VaXenS; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29f93c4946cso968821a91.1;
        Thu, 04 Apr 2024 14:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712265807; x=1712870607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYhpwLMglDG1pfDTBky3bS7j0MpByAE0synvZXpNasY=;
        b=l5VaXenSMEhSjE8OQi78LMT9okuDfls7NeuspZk0hNg72EAnfq3wT8jAlUN/BN5q0w
         DC8mXHYu3Pe/LsvXwLfwwNzmG2sPzpnL1Tlt9UTd1Bp1zxKtO6Xckwvl0mSDnMs6MfNy
         SPMcCKzA4XwxUbUkgcpHrGRblywgTzmJAwjYMmiiUT7QqTVAC6Jr+Go+rl39IKhZxWbm
         S3Tp3Whd1mxVGot8mUGonQquvhfh9V+ZYO4AFBBvlQDXNqg/eY71el8sQuXwLFFfCdOe
         wDk25iObd8IUO2djk8bWoNEoR/UXR6bGyCeWurn+3N4MupEVpJRyIdFaXY/bYG+PaEGD
         j1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712265807; x=1712870607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYhpwLMglDG1pfDTBky3bS7j0MpByAE0synvZXpNasY=;
        b=hfS9HCRACjwrCnt6qYXcMqnOCoVtF2lZ3amPWuh8GdB7ExgfwjY/GAGT8oLdEmf2jP
         1NHi44weTGENzNoReYF34MF5ELNufOddx2i8Rz+u00mgBI6578IsGc7OaF2l7b1vwfIv
         YH0aIdPxs0gc9s7IWXZ4rvqh9RsUjGQgQVn8hZBuCdS5HWM7aA+IahULGHV9ncaca6UG
         AppSI/PYdWok+2jdHYKb19EjbtG41rWwWoFuWhoNIrbyhlPOTIctegXcGQ6d9CggfiQj
         o0zwFKwfRnjYlWzRAyF6X2PHQSTFxNvoY2ef0WKjJDlUJeq5vHiql0tEOb1ZHBaF0/yl
         qyVg==
X-Forwarded-Encrypted: i=1; AJvYcCXLZIFhWXMLZFxECAKgHCQcqIEIk+HBavSWRe7aePLjXz5B4uuc1ShZjDz6m1LcOi3JhDAFtuKp7biPa0AVBdSgQcypa03meviWpjR+apC5+13IyaCg9h3ytHM6OKEgZVOh
X-Gm-Message-State: AOJu0YzsWAEse0FDTsgtDpUtVVxxHSz1LocZ7zNTipXPt/7lvl0Ah64e
	MkJeKXDb+bQFkhqctVUUkr3hW/YSzxtb+YJAw+P+1JhwFdZbpmH/+GWeEbeN6e9s6Oi21+pLlab
	+k6hQhGmOLWu375ZUE4ElsVcVZ0k=
X-Google-Smtp-Source: AGHT+IF0kUoWN7hfkwAoVQ35ixSBuFxEF6WgrxOSm+IatIGQri0VbHD7o5LJ4eaz/zezxEzHhvrd7cTeIVZSkrcJ354=
X-Received: by 2002:a17:90a:6889:b0:2a2:18fb:683e with SMTP id
 a9-20020a17090a688900b002a218fb683emr3552265pjd.30.1712265806499; Thu, 04 Apr
 2024 14:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000092c8da06154be4f5@google.com>
In-Reply-To: <00000000000092c8da06154be4f5@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Apr 2024 14:23:14 -0700
Message-ID: <CAEf4BzYK9rzMEtnsK6-pUfLoyUn5rjYWMrPGUy90=Y5vmw5S3A@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-use-after-free Read in bpf_link_free
To: syzbot <syzbot+b3851d693eb8edda5c7d@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com, 
	song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 2:19=E2=80=AFPM syzbot
<syzbot+b3851d693eb8edda5c7d@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    727900b675b7 Add linux-next specific files for 20240403
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17bf53c518000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dafcaf46d374ce=
c8c
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Db3851d693eb8edd=
a5c7d
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f8fb4daa7a83/dis=
k-727900b6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d2a6994aee53/vmlinu=
x-727900b6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6759e5411c39/b=
zImage-727900b6.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+b3851d693eb8edda5c7d@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-use-after-free in bpf_link_free+0x234/0x2d0 kernel/bpf/s=
yscall.c:3065
> Read of size 8 at addr ffff88802e688c10 by task syz-executor.3/5206
>

syz fix: bpf: support deferring bpf_link dealloc to after RCU grace period

> CPU: 0 PID: 5206 Comm: syz-executor.3 Not tainted 6.9.0-rc2-next-20240403=
-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/27/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  bpf_link_free+0x234/0x2d0 kernel/bpf/syscall.c:3065
>  bpf_link_put_direct kernel/bpf/syscall.c:3093 [inline]
>  bpf_link_release+0x7b/0x90 kernel/bpf/syscall.c:3100
>  __fput+0x429/0x8a0 fs/file_table.c:422
>  task_work_run+0x24f/0x310 kernel/task_work.c:180
>  exit_task_work include/linux/task_work.h:38 [inline]
>  do_exit+0xa1b/0x27e0 kernel/exit.c:878
>  do_group_exit+0x207/0x2c0 kernel/exit.c:1027
>  get_signal+0x16a1/0x1740 kernel/signal.c:2911
>  arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0xc9/0x360 kernel/entry/common.c:218
>  do_syscall_64+0x10a/0x240 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x72/0x7a
> RIP: 0033:0x7f803547dde9
> Code: Unable to access opcode bytes at 0x7f803547ddbf.
> RSP: 002b:00007f80361c80c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: 0000000000000006 RBX: 00007f80355abf80 RCX: 00007f803547dde9
> RDX: 0000000000000010 RSI: 0000000020000040 RDI: 0000000000000011
> RBP: 00007f80354ca47a R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007f80355abf80 R15: 00007fff8c6d4fc8
>  </TASK>
>
> Allocated by task 5206:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
>  kasan_kmalloc include/linux/kasan.h:211 [inline]
>  kmalloc_trace_noprof+0x19c/0x2b0 mm/slub.c:4100
>  kmalloc_noprof include/linux/slab.h:660 [inline]
>  kzalloc_noprof include/linux/slab.h:775 [inline]
>  bpf_raw_tp_link_attach+0x2a0/0x6e0 kernel/bpf/syscall.c:3845
>  bpf_raw_tracepoint_open+0x1c2/0x240 kernel/bpf/syscall.c:3892
>  __sys_bpf+0x3c0/0x810 kernel/bpf/syscall.c:5702
>  __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5765
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x72/0x7a
>
> Freed by task 24:
>  kasan_save_stack mm/kasan/common.c:47 [inline]
>  kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>  kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>  poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
>  __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
>  kasan_slab_free include/linux/kasan.h:184 [inline]
>  slab_free_hook mm/slub.c:2180 [inline]
>  slab_free mm/slub.c:4384 [inline]
>  kfree+0x149/0x350 mm/slub.c:4505
>  rcu_do_batch kernel/rcu/tree.c:2559 [inline]
>  rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2833
>  __do_softirq+0x2c6/0x980 kernel/softirq.c:554
>
> Last potentially related work creation:
>  kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
>  __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
>  __call_rcu_common kernel/rcu/tree.c:3096 [inline]
>  call_rcu+0x167/0xa70 kernel/rcu/tree.c:3200
>  bpf_link_free+0x1f8/0x2d0 kernel/bpf/syscall.c:3063
>  bpf_link_put_direct kernel/bpf/syscall.c:3093 [inline]
>  bpf_link_release+0x7b/0x90 kernel/bpf/syscall.c:3100
>  __fput+0x429/0x8a0 fs/file_table.c:422
>  task_work_run+0x24f/0x310 kernel/task_work.c:180
>  exit_task_work include/linux/task_work.h:38 [inline]
>  do_exit+0xa1b/0x27e0 kernel/exit.c:878
>  do_group_exit+0x207/0x2c0 kernel/exit.c:1027
>  get_signal+0x16a1/0x1740 kernel/signal.c:2911
>  arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
>  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>  syscall_exit_to_user_mode+0xc9/0x360 kernel/entry/common.c:218
>  do_syscall_64+0x10a/0x240 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x72/0x7a
>
> The buggy address belongs to the object at ffff88802e688c00
>  which belongs to the cache kmalloc-128 of size 128
> The buggy address is located 16 bytes inside of
>  freed 128-byte region [ffff88802e688c00, ffff88802e688c80)
>
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2e68=
8
> flags: 0xfff80000000000(node=3D0|zone=3D1|lastcpupid=3D0xfff)
> page_type: 0xffffefff(slab)
> raw: 00fff80000000000 ffff8880150418c0 ffffea0000b40100 dead000000000002
> raw: 0000000000000000 0000000000100010 00000001ffffefff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(=
GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 4551, tgid 587604050 (udevadm),=
 ts 4551, free_ts 25547020786
>  set_page_owner include/linux/page_owner.h:32 [inline]
>  post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1490
>  prep_new_page mm/page_alloc.c:1498 [inline]
>  get_page_from_freelist+0x2e7e/0x2f40 mm/page_alloc.c:3454
>  __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4712
>  __alloc_pages_node_noprof include/linux/gfp.h:244 [inline]
>  alloc_pages_node_noprof include/linux/gfp.h:271 [inline]
>  alloc_slab_page+0x5f/0x120 mm/slub.c:2249
>  allocate_slab+0x5a/0x2e0 mm/slub.c:2412
>  new_slab mm/slub.c:2465 [inline]
>  ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3615
>  __slab_alloc+0x58/0xa0 mm/slub.c:3705
>  __slab_alloc_node mm/slub.c:3758 [inline]
>  slab_alloc_node mm/slub.c:3936 [inline]
>  kmalloc_trace_noprof+0x1d5/0x2b0 mm/slub.c:4095
>  kmalloc_noprof include/linux/slab.h:660 [inline]
>  kzalloc_noprof include/linux/slab.h:775 [inline]
>  kernfs_get_open_node fs/kernfs/file.c:525 [inline]
>  kernfs_fop_open+0x800/0xcd0 fs/kernfs/file.c:693
>  do_dentry_open+0x907/0x15a0 fs/open.c:955
>  do_open fs/namei.c:3642 [inline]
>  path_openat+0x2860/0x3240 fs/namei.c:3799
>  do_filp_open+0x235/0x490 fs/namei.c:3826
>  do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
>  do_sys_open fs/open.c:1421 [inline]
>  __do_sys_openat fs/open.c:1437 [inline]
>  __se_sys_openat fs/open.c:1432 [inline]
>  __x64_sys_openat+0x247/0x2a0 fs/open.c:1432
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x72/0x7a
> page last free pid 4544 tgid 4544 stack trace:
>  reset_page_owner include/linux/page_owner.h:25 [inline]
>  free_pages_prepare mm/page_alloc.c:1110 [inline]
>  free_unref_page+0xd3c/0xec0 mm/page_alloc.c:2617
>  discard_slab mm/slub.c:2511 [inline]
>  __put_partials+0xeb/0x130 mm/slub.c:2980
>  put_cpu_partial+0x17c/0x250 mm/slub.c:3055
>  __slab_free+0x2ea/0x3d0 mm/slub.c:4254
>  qlink_free mm/kasan/quarantine.c:163 [inline]
>  qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
>  kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>  __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
>  kasan_slab_alloc include/linux/kasan.h:201 [inline]
>  slab_post_alloc_hook mm/slub.c:3888 [inline]
>  slab_alloc_node mm/slub.c:3948 [inline]
>  kmem_cache_alloc_node_noprof+0x16b/0x310 mm/slub.c:3991
>  kmalloc_reserve+0xa8/0x2a0 net/core/skbuff.c:577
>  __alloc_skb+0x1f3/0x440 net/core/skbuff.c:668
>  netlink_sendmsg+0x637/0xcb0 net/netlink/af_netlink.c:1880
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
>  ___sys_sendmsg net/socket.c:2638 [inline]
>  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x72/0x7a
>
> Memory state around the buggy address:
>  ffff88802e688b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
>  ffff88802e688b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >ffff88802e688c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                          ^
>  ffff88802e688c80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff88802e688d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

