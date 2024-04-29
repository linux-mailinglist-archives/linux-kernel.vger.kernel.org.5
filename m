Return-Path: <linux-kernel+bounces-163094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1904A8B6563
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 00:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D62E1C2179B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105F219069B;
	Mon, 29 Apr 2024 22:17:01 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4918B17798F;
	Mon, 29 Apr 2024 22:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429019; cv=none; b=N+pBWHLAsNFPPIjWzZFmfovueF3OGIAMFmk6449DUzUnmvxXgUtwh/2fZsV8Jm1UsystmB7FdzL9gGdlI1rI1SghZrQIv7zrT/fMZcPh2d77K4galSlT52K9FFFJJW4ZQuRc97xCEBjffgYYa0cIOaFhBO1tb4HsQoWom0fIAdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429019; c=relaxed/simple;
	bh=4X7GwcLc8yxmxxc5I9ttQQzqzVh1dSVqNfsQ0+7jX7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gG3YrmONX83oVXYlCYZ5omtQYh5xRe+WjC/kc7DuhWDZcUgtJBnZukmDz9psQaTo8Q8K+RkmNW92QYzRo5ocNOaS+c1LXWumpMcbWvXgCP0RbpjHDwMNsEtI35PSgFRkoO8H2tmbVFTHmHQAMmCwZSlZaTHmOxDH7XTCn2TtIFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51abf1a9332so6831141e87.3;
        Mon, 29 Apr 2024 15:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714429015; x=1715033815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDTwbZhCJRdU1G4mvD1N+DmlAPyioR4zaFFnbRYQr/4=;
        b=FzwtUhXu/nWGWcFn3SSjSjoo3voj0lf9YCAJq22w/Akw8fGlxbOTLi4VUjRHMgb40W
         xVtvliEem0F/pjzXmjnd9XFMRTCu+9I6uCekdR5j7nXurcq7ooBXyw3M5JeLlku1uKde
         SsnS7aw+xEmQUidoabCCfNOI9POKPF4DFNJFSdHsJHLnJR4usIJh4ny8o6s7S6cJL+jf
         5NZFclbC7vp8/fstNqkDh/CDpoMTDpDEmdnDk8NVSl4+NO+6llFTKLhM51skZo30Up7l
         RTWd1IX1Xj3IUciE2OzBmG5GPB+MbyUpy3NFf69ja6SpaDQUvRYbG0rLmqxM9EbhLzTd
         PHIA==
X-Forwarded-Encrypted: i=1; AJvYcCWB6WroFeQT299pJByEMZqRsZWJcS7Kzbn/1qKKKFsOfgRMaZD+x1tFrA5cFQNP4HOorhXDul6fjcqoRFEQz02Ivi9Xx7ELD434GEe9Bfe6cs69Z3Rbt7AtprhhOOCaYw0eMq7usD1U4uWw44oL
X-Gm-Message-State: AOJu0YyHYkh/Gf+RoLyXhojBwUEhRoLFMkPcvzCEwfoen4EY0kdN2Ctn
	vUDdZCgW+ubULOyev+B1liSUZcfyMcMpoSlEovg3fwt06dBQYqcTcp23H6fS/iE=
X-Google-Smtp-Source: AGHT+IFnZuI4ODIy+uR85m0109vDoNTUMvRpHYt5JgfsQsPP7d6FVKpzwz/TKLucT4KQonRHFQ2rcg==
X-Received: by 2002:ac2:5504:0:b0:51c:22fb:182f with SMTP id j4-20020ac25504000000b0051c22fb182fmr7440315lfk.13.1714429014964;
        Mon, 29 Apr 2024 15:16:54 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id k10-20020a05651210ca00b0051d77bf5465sm721351lfg.67.2024.04.29.15.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 15:16:54 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51abf1a9332so6831123e87.3;
        Mon, 29 Apr 2024 15:16:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXdNtJrWTlK0dehrqYfJFm2rWRSSWbqRKAlP46pxgZ9ucC6zt+En9kqeewpKTXWf6zAPgSxiYkrnBkf5qokh2cCBrBT5giYk5L3e5traG9ogkSmPRW8DVKklDcI/DtcihZ9KetvV0J1Yq4iARKt
X-Received: by 2002:ac2:58ca:0:b0:518:e69b:25a2 with SMTP id
 u10-20020ac258ca000000b00518e69b25a2mr6796426lfo.45.1714429014394; Mon, 29
 Apr 2024 15:16:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240428015834.2485653-1-iam@sung-woo.kim> <CABBYNZJ21uzmWiksD6CLDBuEe2pfPzFGsbn5quZ4edz3W0Wv=g@mail.gmail.com>
In-Reply-To: <CABBYNZJ21uzmWiksD6CLDBuEe2pfPzFGsbn5quZ4edz3W0Wv=g@mail.gmail.com>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Mon, 29 Apr 2024 18:16:38 -0400
X-Gmail-Original-Message-ID: <CAJNyHp+S2BvX6kWy8Y4Vfkmkw+SEQiy1oB6OAn9t-8gRy+is9Q@mail.gmail.com>
Message-ID: <CAJNyHp+S2BvX6kWy8Y4Vfkmkw+SEQiy1oB6OAn9t-8gRy+is9Q@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: msft: fix slab-use-after-free in msft_do_close()
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: daveti@purdue.edu, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Luiz,
Thank you for reviewing.

On Mon, Apr 29, 2024 at 12:43=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sungwoo,
>
> On Sat, Apr 27, 2024 at 10:03=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> w=
rote:
> >
> > Hi, could you review this patch?
> > Now *not static* msft functions hold and put hdev->msft_data.
> > It prevents from potential and real use-after-free bugs.
> >
> > How msft is used after freed:
> >
> > [use]
> > msft_do_close()
> >   msft =3D hdev->msft_data;
> >   if (!msft)                      ...(1) <- passed.
> >     return;
> >   mutex_lock(&msft->filter_lock); ...(4) <- used after freed.
> >
> > [free]
> > msft_unregister()
> >   msft =3D hdev->msft_data;
> >   hdev->msft_data =3D NULL;         ...(2)
> >   kfree(msft);                    ...(3) <- msft is freed.
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-use-after-free in __mutex_lock_common kernel/locking/m=
utex.c:587 [inline]
> > BUG: KASAN: slab-use-after-free in __mutex_lock+0x8f/0xc30 kernel/locki=
ng/mutex.c:752
> > Read of size 8 at addr ffff888106cbbca8 by task kworker/u5:2/309
> >
> > CPU: 0 PID: 309 Comm: kworker/u5:2 Not tainted 6.9.0-rc5+ #5
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
> > Workqueue: hci4 hci_error_reset
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xcd/0x140 lib/dump_stack.c:114
> >  print_address_description mm/kasan/report.c:377 [inline]
> >  print_report+0x191/0x560 mm/kasan/report.c:488
> >  kasan_report+0xe2/0x120 mm/kasan/report.c:601
> >  __asan_report_load8_noabort+0x18/0x20 mm/kasan/report_generic.c:381
> >  __mutex_lock_common kernel/locking/mutex.c:587 [inline]
> >  __mutex_lock+0x8f/0xc30 kernel/locking/mutex.c:752
> >  mutex_lock_nested+0x1f/0x30 kernel/locking/mutex.c:804
> >  msft_do_close+0x292/0x700 net/bluetooth/msft.c:694
> >  hci_dev_close_sync+0x906/0xf10 net/bluetooth/hci_sync.c:5168
> >  hci_dev_do_close net/bluetooth/hci_core.c:554 [inline]
> >  hci_error_reset+0x152/0x410 net/bluetooth/hci_core.c:1091
> >  process_one_work kernel/workqueue.c:3254 [inline]
> >  process_scheduled_works+0x90f/0x1530 kernel/workqueue.c:3335
> >  worker_thread+0x926/0xe70 kernel/workqueue.c:3416
> >  kthread+0x2e3/0x380 kernel/kthread.c:388
> >  ret_from_fork+0x5c/0x90 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >  </TASK>
> >
> > Allocated by task 7328:
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >  kasan_save_track+0x30/0x70 mm/kasan/common.c:68
> >  kasan_save_alloc_info+0x3c/0x50 mm/kasan/generic.c:565
> >  poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
> >  __kasan_kmalloc+0xa2/0xc0 mm/kasan/common.c:387
> >  kasan_kmalloc include/linux/kasan.h:211 [inline]
> >  kmalloc_trace+0x20c/0x3e0 mm/slub.c:3997
> >  kmalloc include/linux/slab.h:628 [inline]
> >  kzalloc include/linux/slab.h:749 [inline]
> >  msft_register+0x66/0x1d0 net/bluetooth/msft.c:760
> >  hci_register_dev+0x85e/0x9a0 net/bluetooth/hci_core.c:2737
> >  __vhci_create_device drivers/bluetooth/hci_vhci.c:438 [inline]
> >  vhci_create_device+0x390/0x720 drivers/bluetooth/hci_vhci.c:480
> >  vhci_get_user drivers/bluetooth/hci_vhci.c:537 [inline]
> >  vhci_write+0x39b/0x460 drivers/bluetooth/hci_vhci.c:617
> >  call_write_iter include/linux/fs.h:2110 [inline]
> >  new_sync_write fs/read_write.c:497 [inline]
> >  vfs_write+0x8eb/0xb50 fs/read_write.c:590
> >  ksys_write+0x106/0x1f0 fs/read_write.c:643
> >  __do_sys_write fs/read_write.c:655 [inline]
> >  __se_sys_write fs/read_write.c:652 [inline]
> >  __x64_sys_write+0x84/0xa0 fs/read_write.c:652
> >  x64_sys_call+0x271a/0x2ce0 arch/x86/include/generated/asm/syscalls_64.=
h:2
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0x9c/0x130 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > Freed by task 7332:
> >  kasan_save_stack mm/kasan/common.c:47 [inline]
> >  kasan_save_track+0x30/0x70 mm/kasan/common.c:68
> >  kasan_save_free_info+0x44/0x50 mm/kasan/generic.c:579
> >  poison_slab_object+0x11a/0x190 mm/kasan/common.c:240
> >  __kasan_slab_free+0x3b/0x60 mm/kasan/common.c:256
> >  kasan_slab_free include/linux/kasan.h:184 [inline]
> >  slab_free_hook mm/slub.c:2106 [inline]
> >  slab_free mm/slub.c:4280 [inline]
> >  kfree+0x13c/0x330 mm/slub.c:4390
> >  msft_unregister+0x9d/0x120 net/bluetooth/msft.c:785
> >  hci_unregister_dev+0x1d9/0x520 net/bluetooth/hci_core.c:2771
> >  vhci_release+0x8c/0xe0 drivers/bluetooth/hci_vhci.c:674
> >  __fput+0x36f/0x750 fs/file_table.c:422
> >  ____fput+0x1e/0x30 fs/file_table.c:450
> >  task_work_run+0x1da/0x280 kernel/task_work.c:180
> >  exit_task_work include/linux/task_work.h:38 [inline]
> >  do_exit+0x856/0x2210 kernel/exit.c:878
> >  do_group_exit+0x201/0x2c0 kernel/exit.c:1027
> >  get_signal+0x12ff/0x1380 kernel/signal.c:2911
> >  arch_do_signal_or_restart+0x3b/0x650 arch/x86/kernel/signal.c:310
> >  exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
> >  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
> >  __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
> >  syscall_exit_to_user_mode+0xcc/0x2a0 kernel/entry/common.c:218
> >  do_syscall_64+0xa8/0x130 arch/x86/entry/common.c:89
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > The buggy address belongs to the object at ffff888106cbbc00
> >  which belongs to the cache kmalloc-256 of size 256
> > The buggy address is located 168 bytes inside of
> >  freed 256-byte region [ffff888106cbbc00, ffff888106cbbd00)
> >
> > The buggy address belongs to the physical page:
> > page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10=
6cba
> > head: order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> > flags: 0x17ffffe0000840(slab|head|node=3D0|zone=3D2|lastcpupid=3D0x3fff=
ff)
> > page_type: 0xffffffff()
> > raw: 0017ffffe0000840 ffff888100042040 ffffea00042de590 ffffea00041b3e1=
0
> > raw: 0000000000000000 00000000000a000a 00000001ffffffff 000000000000000=
0
> > head: 0017ffffe0000840 ffff888100042040 ffffea00042de590 ffffea00041b3e=
10
> > head: 0000000000000000 00000000000a000a 00000001ffffffff 00000000000000=
00
> > head: 0017ffffe0000001 ffffea00041b2e81 dead000000000122 00000000ffffff=
ff
> > head: 0000000200000000 0000000000000000 00000000ffffffff 00000000000000=
00
> > page dumped because: kasan: bad access detected
> >
> > Memory state around the buggy address:
> >  ffff888106cbbb80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >  ffff888106cbbc00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >ffff888106cbbc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                                   ^
> >  ffff888106cbbd00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >  ffff888106cbbd80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Fixes: 9e14606d8f38 ("Bluetooth: disable advertisement filters during s=
uspend")
> > Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> > ---
> > v2: Move BT_DBG after null checking in msft_data_hold_unless_zero()
> >
> >  net/bluetooth/msft.c | 124 ++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 99 insertions(+), 25 deletions(-)
> >
> > diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
> > index 9612c5d1b..1f79e7980 100644
> > --- a/net/bluetooth/msft.c
> > +++ b/net/bluetooth/msft.c
> > @@ -132,10 +132,45 @@ struct msft_data {
> >         __u8 filter_enabled;
> >         /* To synchronize add/remove address filter and monitor device =
event.*/
> >         struct mutex filter_lock;
> > +       struct kref     kref;
>
> NAK, the lifetime of this object should be tied to hdev which already
> has a kref.

I got this.

>
> >  };
> >
> > +static void msft_data_free(struct kref *kref);
> > +
> > +static struct msft_data *msft_data_hold_unless_zero(struct msft_data *=
msft)
> > +{
> > +       if (!msft)
> > +               return NULL;
> > +
> > +       BT_DBG("msft %p orig refcnt %u", msft, kref_read(&msft->kref));
> > +
> > +       if (!kref_get_unless_zero(&msft->kref))
> > +               return NULL;
> > +
> > +       return msft;
> > +}
> > +
> > +static void msft_data_put(struct msft_data *msft)
> > +{
> > +       BT_DBG("msft %p orig refcnt %u", msft, kref_read(&msft->kref));
> > +
> > +       kref_put(&msft->kref, msft_data_free);
> > +}
> > +
> > +static void msft_data_free(struct kref *kref)
> > +{
> > +       struct msft_data *msft =3D container_of(kref, struct msft_data,=
 kref);
> > +
> > +       BT_DBG("msft %p", msft);
> > +
> > +       kfree(msft->evt_prefix);
> > +       mutex_destroy(&msft->filter_lock);
> > +       kfree(msft);
> > +}
> > +
> >  bool msft_monitor_supported(struct hci_dev *hdev)
> >  {
> > +       /* msft_get_features() holds and put hdev->msft_data */
> >         return !!(msft_get_features(hdev) & MSFT_FEATURE_MASK_LE_ADV_MO=
NITOR);
> >  }
> >
> > @@ -449,12 +484,17 @@ static int msft_remove_monitor_sync(struct hci_de=
v *hdev,
> >  /* This function requires the caller holds hci_req_sync_lock */
> >  int msft_suspend_sync(struct hci_dev *hdev)
> >  {
> > -       struct msft_data *msft =3D hdev->msft_data;
> > +       struct msft_data *msft;
> >         struct adv_monitor *monitor;
> >         int handle =3D 0;
> >
> > -       if (!msft || !msft_monitor_supported(hdev))
> > +       msft =3D msft_data_hold_unless_zero(hdev->msft_data);
> > +       if (!msft)
> >                 return 0;
> > +       if (!msft_monitor_supported(hdev)) {
> > +               msft_data_put(msft);
> > +               return 0;
> > +       }
> >
> >         msft->suspending =3D true;
> >
> > @@ -471,6 +511,7 @@ int msft_suspend_sync(struct hci_dev *hdev)
> >         /* All monitors have been removed */
> >         msft->suspending =3D false;
> >
> > +       msft_data_put(msft);
> >         return 0;
> >  }
> >
> > @@ -608,11 +649,17 @@ static void reregister_monitor(struct hci_dev *hd=
ev)
> >  /* This function requires the caller holds hci_req_sync_lock */
> >  int msft_resume_sync(struct hci_dev *hdev)
> >  {
> > -       struct msft_data *msft =3D hdev->msft_data;
> > +       struct msft_data *msft;
> >
> > -       if (!msft || !msft_monitor_supported(hdev))
> > +       msft =3D msft_data_hold_unless_zero(hdev->msft_data);
> > +       if (!msft)
> >                 return 0;
> >
> > +       if (!msft_monitor_supported(hdev)) {
> > +               msft_data_put(msft);
> > +               return 0;
> > +       }
> > +
> >         hci_dev_lock(hdev);
> >
> >         /* Clear already tracked devices on resume. Once the monitors a=
re
> > @@ -625,17 +672,19 @@ int msft_resume_sync(struct hci_dev *hdev)
> >
> >         reregister_monitor(hdev);
> >
> > +       msft_data_put(msft);
> >         return 0;
> >  }
> >
> >  /* This function requires the caller holds hci_req_sync_lock */
> >  void msft_do_open(struct hci_dev *hdev)
> >  {
> > -       struct msft_data *msft =3D hdev->msft_data;
> > +       struct msft_data *msft;
> >
> >         if (hdev->msft_opcode =3D=3D HCI_OP_NOP)
> >                 return;
> >
> > +       msft =3D msft_data_hold_unless_zero(hdev->msft_data);
> >         if (!msft) {
> >                 bt_dev_err(hdev, "MSFT extension not registered");
> >                 return;
> > @@ -650,8 +699,7 @@ void msft_do_open(struct hci_dev *hdev)
> >         msft->features =3D 0;
> >
> >         if (!read_supported_features(hdev, msft)) {
> > -               hdev->msft_data =3D NULL;
> > -               kfree(msft);
> > +               msft_data_put(msft);
> >                 return;
> >         }
> >
> > @@ -663,15 +711,17 @@ void msft_do_open(struct hci_dev *hdev)
> >                  */
> >                 reregister_monitor(hdev);
> >         }
> > +       msft_data_put(msft);
> >  }
> >
> >  void msft_do_close(struct hci_dev *hdev)
> >  {
> > -       struct msft_data *msft =3D hdev->msft_data;
> > +       struct msft_data *msft;
> >         struct msft_monitor_advertisement_handle_data *handle_data, *tm=
p;
> >         struct msft_monitor_addr_filter_data *address_filter, *n;
> >         struct adv_monitor *monitor;
> >
> > +       msft =3D msft_data_hold_unless_zero(hdev->msft_data);
> >         if (!msft)
> >                 return;
> >
> > @@ -705,6 +755,8 @@ void msft_do_close(struct hci_dev *hdev)
> >         hdev->advmon_pend_notify =3D false;
> >         msft_monitor_device_del(hdev, 0, NULL, 0, true);
> >
> > +       msft_data_put(msft);
> > +
> >         hci_dev_unlock(hdev);
> >  }
> >
> > @@ -767,6 +819,7 @@ void msft_register(struct hci_dev *hdev)
> >         INIT_LIST_HEAD(&msft->address_filters);
> >         hdev->msft_data =3D msft;
> >         mutex_init(&msft->filter_lock);
> > +       kref_init(&msft->kref);
> >  }
> >
> >  void msft_unregister(struct hci_dev *hdev)
> > @@ -779,10 +832,7 @@ void msft_unregister(struct hci_dev *hdev)
> >         bt_dev_dbg(hdev, "Unregister MSFT extension");
> >
> >         hdev->msft_data =3D NULL;
> > -
> > -       kfree(msft->evt_prefix);
> > -       mutex_destroy(&msft->filter_lock);
> > -       kfree(msft);
> > +       msft_data_put(msft);
> >  }
> >
> >  /* This function requires the caller holds hdev->lock */
> > @@ -1068,10 +1118,11 @@ static void msft_monitor_device_evt(struct hci_=
dev *hdev, struct sk_buff *skb)
> >
> >  void msft_vendor_evt(struct hci_dev *hdev, void *data, struct sk_buff =
*skb)
> >  {
> > -       struct msft_data *msft =3D hdev->msft_data;
> > +       struct msft_data *msft;
> >         u8 *evt_prefix;
> >         u8 *evt;
> >
> > +       msft =3D msft_data_hold_unless_zero(hdev->msft_data);
> >         if (!msft)
> >                 return;
> >
> > @@ -1081,21 +1132,21 @@ void msft_vendor_evt(struct hci_dev *hdev, void=
 *data, struct sk_buff *skb)
> >         if (msft->evt_prefix_len > 0) {
> >                 evt_prefix =3D msft_skb_pull(hdev, skb, 0, msft->evt_pr=
efix_len);
> >                 if (!evt_prefix)
> > -                       return;
> > +                       goto done;
> >
> >                 if (memcmp(evt_prefix, msft->evt_prefix, msft->evt_pref=
ix_len))
> > -                       return;
> > +                       goto done;
> >         }
> >
> >         /* Every event starts at least with an event code and the rest =
of
> >          * the data is variable and depends on the event code.
> >          */
> >         if (skb->len < 1)
> > -               return;
> > +               goto done;
> >
> >         evt =3D msft_skb_pull(hdev, skb, 0, sizeof(*evt));
> >         if (!evt)
> > -               return;
> > +               goto done;
> >
> >         hci_dev_lock(hdev);
> >
> > @@ -1112,13 +1163,24 @@ void msft_vendor_evt(struct hci_dev *hdev, void=
 *data, struct sk_buff *skb)
> >         }
> >
> >         hci_dev_unlock(hdev);
> > +
> > +done:
> > +       msft_data_put(msft);
> >  }
> >
> >  __u64 msft_get_features(struct hci_dev *hdev)
> >  {
> > -       struct msft_data *msft =3D hdev->msft_data;
> > +       struct msft_data *msft;
> > +       unsigned long long features;
> > +
> > +       msft =3D msft_data_hold_unless_zero(hdev->msft_data);
> > +       if (!msft)
> > +               return 0;
> > +
> > +       features =3D msft->features;
> >
> > -       return msft ? msft->features : 0;
> > +       msft_data_put(msft);
> > +       return features;
> >  }
> >
> >  static void msft_le_set_advertisement_filter_enable_cb(struct hci_dev =
*hdev,
> > @@ -1152,37 +1214,48 @@ static void msft_le_set_advertisement_filter_en=
able_cb(struct hci_dev *hdev,
> >  /* This function requires the caller holds hci_req_sync_lock */
> >  int msft_add_monitor_pattern(struct hci_dev *hdev, struct adv_monitor =
*monitor)
> >  {
> > -       struct msft_data *msft =3D hdev->msft_data;
> > +       struct msft_data *msft;
> > +       int err;
> >
> > +       msft =3D msft_data_hold_unless_zero(hdev->msft_data);
> >         if (!msft)
> >                 return -EOPNOTSUPP;
> >
> > -       if (msft->resuming || msft->suspending)
> > +       if (msft->resuming || msft->suspending) {
> > +               msft_data_put(msft);
> >                 return -EBUSY;
> > +       }
> >
> > -       return msft_add_monitor_sync(hdev, monitor);
> > +       err =3D msft_add_monitor_sync(hdev, monitor);
> > +       msft_data_put(msft);
> > +       return err;
> >  }
> >
> >  /* This function requires the caller holds hci_req_sync_lock */
> >  int msft_remove_monitor(struct hci_dev *hdev, struct adv_monitor *moni=
tor)
> >  {
> > -       struct msft_data *msft =3D hdev->msft_data;
> > +       struct msft_data *msft;
> > +       int err;
> >
> > +       msft =3D msft_data_hold_unless_zero(hdev->msft_data);
> >         if (!msft)
> >                 return -EOPNOTSUPP;
> >
> >         if (msft->resuming || msft->suspending)
> >                 return -EBUSY;
> >
> > -       return msft_remove_monitor_sync(hdev, monitor);
> > +       err =3D msft_remove_monitor_sync(hdev, monitor);
> > +       msft_data_put(msft);
> > +       return err;
> >  }
> >
> >  int msft_set_filter_enable(struct hci_dev *hdev, bool enable)
> >  {
> >         struct msft_cp_le_set_advertisement_filter_enable cp;
> > -       struct msft_data *msft =3D hdev->msft_data;
> > +       struct msft_data *msft;
> >         int err;
> >
> > +       msft =3D msft_data_hold_unless_zero(hdev->msft_data);
> >         if (!msft)
> >                 return -EOPNOTSUPP;
> >
> > @@ -1193,6 +1266,7 @@ int msft_set_filter_enable(struct hci_dev *hdev, =
bool enable)
> >
> >         msft_le_set_advertisement_filter_enable_cb(hdev, &cp, err);
> >
> > +       msft_data_put(msft);
> >         return 0;
> >  }
> >
> > --
> > 2.34.1
>
> Looks at the current code I do wonder if the order is incorrect since we =
do:
>
>     msft_unregister(hdev);
>
>     hci_dev_do_close(hdev);
>
> Anyway msft_unregister shall probably be renamed to msft_release and

It could be a nitpick but how about making msft_unregister() static
and wrapping this with msft_release() for consistency?
Since msft_register is there, it may look inconsistent if
msft_unregister() doesn't exist.

> then called from hci_release_dev instead since that is where we free
> fields of hdev, not on unregister.
>
> --
> Luiz Augusto von Dentz
>

Best,
Sungwoo.

