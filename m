Return-Path: <linux-kernel+bounces-164482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351FC8B7E13
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5E911F25738
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570411BED63;
	Tue, 30 Apr 2024 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lysAnrUr"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FAE1802C0;
	Tue, 30 Apr 2024 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714496436; cv=none; b=lFXRISe6x13TDywLwYMHPdVlDZs72ZNdX0VnBeiEG4/i3dRe2KeelMfQDoHKYI4CdZO2r9fRXWuHwW8vpFN2OncjzhHVuG/oYY8PlAmX2ubitvcv6SI9CT+NbA/lnEKlA3F4BEEuX6DLWgZ0s+6DH1PQWF7/874CbRaHHw22G8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714496436; c=relaxed/simple;
	bh=NEokPmnSQ8SWtjxYhuQJrPGVvTtRbSOZo6Omj+FtAO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GI/2S4rY1Ko4P83zIb07ZKqG1KF7580JvGC3eMj42ZCPfet80qmTdLnera2GjM8KmAx0j2QBlOfzFwnAWTiUg8+k1+nAi3AAt409xucROURycKBdWjQm3aaKl2Z7W/68Jsh5SDQBZTT5YgA4WppcxpcLZrVLosVLzoSRqnKMiIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lysAnrUr; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2de232989aaso71882051fa.1;
        Tue, 30 Apr 2024 10:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714496432; x=1715101232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbkCfbFsMONm0tN3k06GhkcgYfsihQd5OISOTLlqWr8=;
        b=lysAnrUrGm2WrKctEVLa+zN/HbIDPDpg4h70zsHwmT7QmbWRV6yswGiSUpiSPBmgJE
         LN/wskHmewp61Np+VJx9ut2ytTo2GR/TPXFzPvEann9M8aw8Asjvu8Wa0btMMSYvyQys
         wgWfomu5J4gPLTkHCZixhsgFJF+mwY84jHCAZMj1q+FhHrhFECp1HCr56pHJNhhRK2Hs
         bZJYBa1Kb6rdqZxH3jhspbPxGbgGVKGIDYubv+VgN3dQ4sA2swDqTq0ysqz+qEKn3giL
         Z1cLTZMOun3M5M1NkZOQ46nbIjqvdAo8EwmyyYl4L6st92CDtFJXUpmDByGp9/xhA9LB
         UHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714496432; x=1715101232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbkCfbFsMONm0tN3k06GhkcgYfsihQd5OISOTLlqWr8=;
        b=U0k3bkvUZnJWld3qPSAfwq2wEEaCR+wZwRZbHHAQLvmDJEB96m8fOWtaRmzQBCIWTt
         WbiJvO/hHhoudUqhHs2jla/jSL8pzS3F/cBj/FZhOgIbbCvFMV7Zv6mTCzYLjdh9+5H7
         wo5rLa4K8DpaLYbpUErmzE9OCGNTUcFrXQziloMYcqxRYcV106PK5KrlomTlD/uaAJsA
         iheTFyew45LwaVMpu4dUX1gMQ395KHnPJrzjaI+m9tC7aGVwRze8u/dAjtOrbZzXdgj4
         CMM0n6EiALb93DBKbe0ZfCAlU8REg5ZzRP03XseQ0564pmF0EFbeyJP0VWNGD8Rw6999
         yysA==
X-Forwarded-Encrypted: i=1; AJvYcCXc+c3pZxtps/ygSnPcavt2Gw5zWxsWCCkQ2Nk4A7OWF5DJXvONGxEbYSNlkngYV1apBe0+XQy/14bMGl1EdcB5FgKtNIdkQnzD7UK/2mVml4Th88mOMgqYRc1/X+hFcog3QmhqTlcCwpvSSLeM
X-Gm-Message-State: AOJu0YyFjeh7kV5tzpN27hEMl6P3l8rfiYWXXFX7TDLg8yDrtJS0GSZ2
	2Biy4y5Kw76VtdjrFQSu0t5E3u8nrHJbgMfwkgGQXBYcoMLg1gFHM0z9L/YKjpDmYWp64nZaLTe
	pZDbjIDyUHodylU1O45RG+JG8cpA=
X-Google-Smtp-Source: AGHT+IFuS9OfoOw7tnfnk0f32osGef2D3rP3/+K+6eEkY+bp3dl3i32Rl7OxcFVD0Jc/QLexMhd9mu+BJyPe0vsT3EQ=
X-Received: by 2002:a2e:3003:0:b0:2e0:b7d6:eaa5 with SMTP id
 w3-20020a2e3003000000b002e0b7d6eaa5mr148725ljw.40.1714496431853; Tue, 30 Apr
 2024 10:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240426111046eucas1p12a7cbceb3f235edccec0f16645396fdf@eucas1p1.samsung.com>
 <20240425041128.3093970-1-iam@sung-woo.kim> <420eec10-d499-4d50-b4c3-44af15b82698@samsung.com>
In-Reply-To: <420eec10-d499-4d50-b4c3-44af15b82698@samsung.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 30 Apr 2024 13:00:19 -0400
Message-ID: <CABBYNZJOKC7EE2cshH2LYHqF5ZEdfhf=rw+6SYWnwB+qD2xmaA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: HCI: fix slab-use-after-free in cmd_sync_work
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Sungwoo Kim <iam@sung-woo.kim>, daveti@purdue.edu, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 26, 2024 at 7:10=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Dear All,
>
> On 25.04.2024 06:11, Sungwoo Kim wrote:
> > Hello, could you review the UAF bug and its fix?
> > The stack trace is at the bottom.
> >
> > mgmt sync cmd could be used after freed in this scenario:
> >
> > set_local_name()       ... cmd is allocated, set_name_complete() is
> >                             queued in cmd_sync_work.
> > hci_error_reset()      ... hci device reset.
> >    hci_dev_close_sync() ... close hdev, at this point, cmd is freed.
> > set_name_complete()    ... callback from cmd_sync_work. cmd->param caus=
es UAF.
> >
> > To fix this, this patch makes hci_dev_close_sync() call hci_cmd_sync_cl=
ear() to clear the cmd_sync_work.
> >
> > Thanks,
> > Sungwoo Kim.
>
> This patch landed in today's linux-next as commit 37dd04e4d594
> ("Bluetooth: HCI: fix slab-use-after-free in cmd_sync_work"). I believe
> it correctly fixes the mentioned problem, but on the other hand it
> introduces the following kernel's lock dependency checker warning:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> WARNING: possible recursive locking detected
> 6.9.0-rc4-01047-g37dd04e4d594 #14949 Not tainted
> --------------------------------------------
> kworker/u9:0/56 is trying to acquire lock:
> c3aba78c ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at:
> __flush_work+0x1e0/0x538
>
> but task is already holding lock:
> f0eb5f18 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at:
> process_scheduled_works+0x328/0x7a8
>
> other info that might help us debug this:
>   Possible unsafe locking scenario:
>
>         CPU0
>         ----
>    lock((work_completion)(&hdev->cmd_sync_work));
>    lock((work_completion)(&hdev->cmd_sync_work));
>
>   *** DEADLOCK ***
>
>   May be due to missing lock nesting notation
>
> 4 locks held by kworker/u9:0/56:
>   #0: c3a4e8b4 ((wq_completion)hci0){+.+.}-{0:0}, at:
> process_scheduled_works+0x2fc/0x7a8
>   #1: f0eb5f18 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0},
> at: process_scheduled_works+0x328/0x7a8
>   #2: c3abab6c (&hdev->req_lock){+.+.}-{3:3}, at:
> hci_cmd_sync_work+0xa0/0x154 [bluetooth]
>   #3: c137bdfc (rcu_read_lock){....}-{1:2}, at: __flush_work+0x40/0x538
>
> stack backtrace:
> CPU: 0 PID: 56 Comm: kworker/u9:0 Not tainted
> 6.9.0-rc4-01047-g37dd04e4d594 #14949
> Hardware name: Samsung Exynos (Flattened Device Tree)
> Workqueue: hci0 hci_cmd_sync_work [bluetooth]
> Call trace:.
>   unwind_backtrace from show_stack+0x10/0x14
>   show_stack from dump_stack_lvl+0x68/0x88
>   dump_stack_lvl from __lock_acquire+0x152c/0x1744
>   __lock_acquire from lock_acquire+0x21c/0x394
>   lock_acquire from __flush_work+0x20c/0x538
>   __flush_work from __cancel_work_sync+0x12c/0x20c
>   __cancel_work_sync from hci_cmd_sync_clear+0x1c/0x6c [bluetooth]
>   hci_cmd_sync_clear [bluetooth] from hci_dev_close_sync+0x31c/0x5f4
> [bluetooth]
>   hci_dev_close_sync [bluetooth] from hci_set_powered_sync+0x27c/0x288
> [bluetooth]
>   hci_set_powered_sync [bluetooth] from hci_cmd_sync_work+0xb0/0x154
> [bluetooth]
>   hci_cmd_sync_work [bluetooth] from process_scheduled_works+0x390/0x7a8
>   process_scheduled_works from worker_thread+0x150/0x3bc
>   worker_thread from kthread+0x108/0x140
>   kthread from ret_from_fork+0x14/0x28
> Exception stack(0xf0eb5fb0 to 0xf0eb5ff8)
> ...
>
>
> Please check if the locking is really correct and if so, add the needed
> lockdep annotation to the bluetooth code to silence the above warning.
>
>
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-use-after-free in set_name_complete+0x4a/0x330 net/blu=
etooth/mgmt.c:3815
> > Read of size 8 at addr ffff888107259098 by task kworker/u3:0/66
> >
> > CPU: 0 PID: 66 Comm: kworker/u3:0 Not tainted 6.8.0+ #61
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
> > Workqueue: hci0 hci_cmd_sync_work
> > Call Trace:
> >   <TASK>
> >   __dump_stack lib/dump_stack.c:88 [inline]
> >   dump_stack_lvl+0x85/0xb0 lib/dump_stack.c:106
> >   print_address_description mm/kasan/report.c:377 [inline]
> >   print_report+0x18f/0x560 mm/kasan/report.c:488
> >   kasan_report+0xd7/0x110 mm/kasan/report.c:601
> >   __asan_report_load8_noabort+0x18/0x20 mm/kasan/report_generic.c:381
> >   set_name_complete+0x4a/0x330 net/bluetooth/mgmt.c:3815
> >   hci_cmd_sync_work+0x269/0x3e0 net/bluetooth/hci_sync.c:308
> >   process_one_work kernel/workqueue.c:2633 [inline]
> >   process_scheduled_works+0x6b9/0xdc0 kernel/workqueue.c:2706
> >   worker_thread+0xb2b/0x13d0 kernel/workqueue.c:2787
> >   kthread+0x2a9/0x340 kernel/kthread.c:388
> >   ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
> >   ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
> >   </TASK>
> >
> > Allocated by task 308:
> >   kasan_save_stack mm/kasan/common.c:47 [inline]
> >   kasan_save_track+0x30/0x70 mm/kasan/common.c:68
> >   kasan_save_alloc_info+0x3c/0x50 mm/kasan/generic.c:575
> >   poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
> >   __kasan_kmalloc+0xa2/0xc0 mm/kasan/common.c:387
> >   kasan_kmalloc include/linux/kasan.h:211 [inline]
> >   kmalloc_trace+0x1c9/0x390 mm/slub.c:4012
> >   kmalloc include/linux/slab.h:590 [inline]
> >   kzalloc include/linux/slab.h:711 [inline]
> >   mgmt_pending_new+0x6f/0x230 net/bluetooth/mgmt_util.c:269
> >   mgmt_pending_add+0x3f/0x120 net/bluetooth/mgmt_util.c:296
> >   set_local_name+0x15a/0x4c0 net/bluetooth/mgmt.c:3892
> >   hci_mgmt_cmd+0xb79/0x1190 net/bluetooth/hci_sock.c:1715
> >   hci_sock_sendmsg+0x63a/0xf00 net/bluetooth/hci_sock.c:1835
> >   sock_sendmsg_nosec net/socket.c:730 [inline]
> >   __sock_sendmsg+0x227/0x270 net/socket.c:745
> >   sock_write_iter+0x28d/0x3d0 net/socket.c:1160
> >   do_iter_readv_writev+0x331/0x4c0
> >   vfs_writev+0x2e6/0xa40 fs/read_write.c:971
> >   do_writev+0xfd/0x250 fs/read_write.c:1018
> >   __do_sys_writev fs/read_write.c:1091 [inline]
> >   __se_sys_writev fs/read_write.c:1088 [inline]
> >   __x64_sys_writev+0x86/0xa0 fs/read_write.c:1088
> >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >   do_syscall_64+0x84/0x120 arch/x86/entry/common.c:83
> >   entry_SYSCALL_64_after_hwframe+0x6e/0x76
> >
> > Freed by task 66:
> >   kasan_save_stack mm/kasan/common.c:47 [inline]
> >   kasan_save_track+0x30/0x70 mm/kasan/common.c:68
> >   kasan_save_free_info+0x44/0x50 mm/kasan/generic.c:589
> >   poison_slab_object+0x11a/0x190 mm/kasan/common.c:240
> >   __kasan_slab_free+0x3b/0x60 mm/kasan/common.c:256
> >   kasan_slab_free include/linux/kasan.h:184 [inline]
> >   slab_free_hook mm/slub.c:2121 [inline]
> >   slab_free mm/slub.c:4299 [inline]
> >   kfree+0x106/0x2e0 mm/slub.c:4409
> >   mgmt_pending_free net/bluetooth/mgmt_util.c:309 [inline]
> >   mgmt_pending_remove+0x19e/0x1d0 net/bluetooth/mgmt_util.c:315
> >   cmd_complete_rsp+0x104/0x1a0
> >   mgmt_pending_foreach+0xc7/0x120 net/bluetooth/mgmt_util.c:259
> >   __mgmt_power_off+0x137/0x370 net/bluetooth/mgmt.c:9496
> >   hci_dev_close_sync+0x4ab/0xe80 net/bluetooth/hci_sync.c:4953
> >   hci_dev_do_close net/bluetooth/hci_core.c:554 [inline]
> >   hci_error_reset+0x150/0x410 net/bluetooth/hci_core.c:1060
> >   process_one_work kernel/workqueue.c:2633 [inline]
> >   process_scheduled_works+0x6b9/0xdc0 kernel/workqueue.c:2706
> >   worker_thread+0xb2b/0x13d0 kernel/workqueue.c:2787
> >   kthread+0x2a9/0x340 kernel/kthread.c:388
> >   ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
> >   ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
> >
> > The buggy address belongs to the object at ffff888107259080
> >   which belongs to the cache kmalloc-96 of size 96
> > The buggy address is located 24 bytes inside of
> >   freed 96-byte region [ffff888107259080, ffff8881072590e0)
> >
> > The buggy address belongs to the physical page:
> > page:000000006bdb81a5 refcount:1 mapcount:0 mapping:0000000000000000 in=
dex:0xffff888107259280 pfn:0x107259
> > flags: 0x17ffffc0000a00(workingset|slab|node=3D0|zone=3D2|lastcpupid=3D=
0x1fffff)
> > page_type: 0xffffffff()
> > raw: 0017ffffc0000a00 ffff888100041780 ffffea0004145510 ffffea000424019=
0
> > raw: ffff888107259280 000000000020000f 00000001ffffffff 000000000000000=
0
> > page dumped because: kasan: bad access detected
> >
> > Memory state around the buggy address:
> >   ffff888107258f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >   ffff888107259000: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
> >> ffff888107259080: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> >                              ^
> >   ffff888107259100: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> >   ffff888107259180: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> > ---
> >   net/bluetooth/hci_core.c | 2 --
> >   net/bluetooth/hci_sync.c | 5 ++++-
> >   2 files changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index a7028d38c..c347efc4f 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -2764,8 +2764,6 @@ void hci_unregister_dev(struct hci_dev *hdev)
> >
> >       cancel_work_sync(&hdev->power_on);
> >
> > -     hci_cmd_sync_clear(hdev);
> > -
> >       hci_unregister_suspend_notifier(hdev);
> >
> >       msft_unregister(hdev);
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index c5d879904..aa8e0c33c 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -5181,9 +5181,12 @@ int hci_dev_close_sync(struct hci_dev *hdev)
> >               clear_bit(HCI_INIT, &hdev->flags);
> >       }
> >
> > -     /* flush cmd  work */
> > +     /* flush cmd work */
> >       flush_work(&hdev->cmd_work);
> >
> > +     /* flush cmd sync work */
> > +     hci_cmd_sync_clear(hdev);
> > +
> >       /* Drop queues */
> >       skb_queue_purge(&hdev->rx_q);
> >       skb_queue_purge(&hdev->cmd_q);
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>

Yeah, I will be reverting it from bluetooth-next until we find a
solution that doesn't cause side effects.

--=20
Luiz Augusto von Dentz

