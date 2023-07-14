Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBE2753213
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbjGNGgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjGNGfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:35:41 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157C130C6;
        Thu, 13 Jul 2023 23:35:23 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-262d9e75438so995469a91.2;
        Thu, 13 Jul 2023 23:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689316522; x=1691908522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIhrGEokJq7ybUIUIoHKrH340ulRUxP9jNOyqClNyGA=;
        b=Bfww+udQrORUUMm3Ca2lcIG7nym6aRYZSdMCBMg5g4zyoYM/huNRSNXggbtA/N6BpV
         gBizLg/iVS0d9QvWEyvvLq4A3O+GHhM7zST78/eyWXVFATX64vb1zbc36Rk/SMrCQWog
         eOsilaTv0mxZNSDjI/4xfdEdhiSwyeKhotlOv3V8BQ9272rGdVexA1s6OJa5JE9u5TB0
         dZtKpcxHyuGYx0L6u3giVsHCjWc+8EWND0PLrM/izGxBZfH21fUPIyvnSRso6WH36noS
         ANdc618Mf9j0f/DTaXkpQOnVx1CH4nfMN6BVN8US3P30bIKjjQWYBsmpb7yj9uysO/zH
         bZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689316522; x=1691908522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIhrGEokJq7ybUIUIoHKrH340ulRUxP9jNOyqClNyGA=;
        b=eZFYVrHDLyoTlLV31GFWRCwQ7s9armnTjemlZiGMB0ogeEDJyheMUNzxTMZp+N6sW2
         bByvZeJD7uBZZN5ZbMQmWlQxt6IxDr4LpxfCjf+S/1FTnak2xVgph/UKU5NPt6OZWtyo
         T9I+LOPnK0dYGIV4yzV4gI5+j7wrhdgzPHz6YgeSyO7zOvo+z+6Fvdef1m+uhYHtS3KI
         N6hp9UoKeP0jNGulIIZtcxlGX3+jYFItGWKM7/nreBPuGXIySbcndwy6AxsvvlOJonG+
         m4ZzXb/7mPLI7jCnwGbXpevK28pzhJ9L+yuV4m1JnojfEC67rG0b7UUZ0ivba5UInsOy
         +5sg==
X-Gm-Message-State: ABy/qLYt+4+5P+T0fKDt3yvISRwjF3islrxgC1/tjkUPI6gWTCImHbpj
        eGZvSVFDdN8VfzIQpRTS/eanwZjjCxwORvVClwE=
X-Google-Smtp-Source: APBJJlGGfEbMuwdydfDRrK/gFIKu7YNqKhA3zH9uhJlQeVUPhHXJCOsNzIptMMTrkqJYZAHDdrxjuWxIeQEmDthO1K0=
X-Received: by 2002:a17:90a:ab11:b0:263:f72f:491 with SMTP id
 m17-20020a17090aab1100b00263f72f0491mr3332196pjq.43.1689316522404; Thu, 13
 Jul 2023 23:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009db51a06005b64e9@google.com> <CALm+0cWBh+4GMzfRKR6rE4H4JR5aRW_m1KVdTLZLJuQyE_smRg@mail.gmail.com>
In-Reply-To: <CALm+0cWBh+4GMzfRKR6rE4H4JR5aRW_m1KVdTLZLJuQyE_smRg@mail.gmail.com>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Fri, 14 Jul 2023 14:35:10 +0800
Message-ID: <CALm+0cVa0H3BOD1Q6x5jOtAzQqnpQR1ju+9HhBS893mHkdQnpw@mail.gmail.com>
Subject: Re: [syzbot] [usb?] memory leak in raw_open
To:     syzbot <syzbot+feb045d335c1fdde5bf7@syzkaller.appspotmail.com>
Cc:     andreyknvl@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 2:21=E2=80=AFPM Z qiang <qiang.zhang1211@gmail.com>=
 wrote:
>
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    1c7873e33645 mm: lock newly mapped VMA with corrected o=
rde..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1517663ca80=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D832b404e095=
b70c0
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dfeb045d335c1f=
dde5bf7
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binu=
tils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1776519ca=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D117f9778a80=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/43b42bd2cf70/d=
isk-1c7873e3.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/011ba1b9e8c1/vmli=
nux-1c7873e3.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/18b349342595=
/bzImage-1c7873e3.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+feb045d335c1fdde5bf7@syzkaller.appspotmail.com
> >
> > BUG: memory leak
> > unreferenced object 0xffff88810b172000 (size 4096):
> >   comm "syz-executor103", pid 5067, jiffies 4294964128 (age 13.070s)
> >   hex dump (first 32 bytes):
> >     01 00 00 00 00 00 00 00 00 bc 96 0e 81 88 ff ff  ................
> >     5d b6 9e 85 ff ff ff ff 03 00 00 00 00 00 00 00  ]...............
> >   backtrace:
> >     [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
> >     [<ffffffff8347eb55>] kmalloc include/linux/slab.h:582 [inline]
> >     [<ffffffff8347eb55>] kzalloc include/linux/slab.h:703 [inline]
> >     [<ffffffff8347eb55>] dev_new drivers/usb/gadget/legacy/raw_gadget.c=
:191 [inline]
> >     [<ffffffff8347eb55>] raw_open+0x45/0x110 drivers/usb/gadget/legacy/=
raw_gadget.c:385
> >     [<ffffffff827d1d09>] misc_open+0x1a9/0x1f0 drivers/char/misc.c:165
> >     [<ffffffff8166763b>] chrdev_open+0x11b/0x340 fs/char_dev.c:414
> >     [<ffffffff8165573f>] do_dentry_open+0x30f/0x990 fs/open.c:914
> >     [<ffffffff8167cabb>] do_open fs/namei.c:3636 [inline]
> >     [<ffffffff8167cabb>] path_openat+0x178b/0x1b20 fs/namei.c:3793
> >     [<ffffffff8167e995>] do_filp_open+0xc5/0x1b0 fs/namei.c:3820
> >     [<ffffffff81659453>] do_sys_openat2+0xe3/0x140 fs/open.c:1407
> >     [<ffffffff81659de3>] do_sys_open fs/open.c:1422 [inline]
> >     [<ffffffff81659de3>] __do_sys_openat fs/open.c:1438 [inline]
> >     [<ffffffff81659de3>] __se_sys_openat fs/open.c:1433 [inline]
> >     [<ffffffff81659de3>] __x64_sys_openat+0x83/0xe0 fs/open.c:1433
> >     [<ffffffff84a77ff9>] do_syscall_x64 arch/x86/entry/common.c:50 [inl=
ine]
> >     [<ffffffff84a77ff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.=
c:80
> >     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > BUG: memory leak
> > unreferenced object 0xffff88810ad20d60 (size 32):
> >   comm "syz-executor103", pid 5067, jiffies 4294964128 (age 13.070s)
> >   hex dump (first 32 bytes):
> >     72 61 77 2d 67 61 64 67 65 74 2e 30 00 00 00 00  raw-gadget.0....
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   backtrace:
> >     [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
> >     [<ffffffff8347cd2f>] kmalloc include/linux/slab.h:582 [inline]
> >     [<ffffffff8347cd2f>] raw_ioctl_init+0xdf/0x410 drivers/usb/gadget/l=
egacy/raw_gadget.c:460
> >     [<ffffffff8347dfe9>] raw_ioctl+0x5f9/0x1120 drivers/usb/gadget/lega=
cy/raw_gadget.c:1250
> >     [<ffffffff81685173>] vfs_ioctl fs/ioctl.c:51 [inline]
> >     [<ffffffff81685173>] __do_sys_ioctl fs/ioctl.c:870 [inline]
> >     [<ffffffff81685173>] __se_sys_ioctl fs/ioctl.c:856 [inline]
> >     [<ffffffff81685173>] __x64_sys_ioctl+0x103/0x140 fs/ioctl.c:856
> >     [<ffffffff84a77ff9>] do_syscall_x64 arch/x86/entry/common.c:50 [inl=
ine]
> >     [<ffffffff84a77ff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.=
c:80
> >     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > BUG: memory leak
> > unreferenced object 0xffff88810e96bc00 (size 128):
> >   comm "syz-executor103", pid 5067, jiffies 4294964128 (age 13.070s)
> >   hex dump (first 32 bytes):
> >     64 75 6d 6d 79 5f 75 64 63 00 00 00 00 00 00 00  dummy_udc.......
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   backtrace:
> >     [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
> >     [<ffffffff8347cd6d>] kmalloc include/linux/slab.h:582 [inline]
> >     [<ffffffff8347cd6d>] raw_ioctl_init+0x11d/0x410 drivers/usb/gadget/=
legacy/raw_gadget.c:468
> >     [<ffffffff8347dfe9>] raw_ioctl+0x5f9/0x1120 drivers/usb/gadget/lega=
cy/raw_gadget.c:1250
> >     [<ffffffff81685173>] vfs_ioctl fs/ioctl.c:51 [inline]
> >     [<ffffffff81685173>] __do_sys_ioctl fs/ioctl.c:870 [inline]
> >     [<ffffffff81685173>] __se_sys_ioctl fs/ioctl.c:856 [inline]
> >     [<ffffffff81685173>] __x64_sys_ioctl+0x103/0x140 fs/ioctl.c:856
> >     [<ffffffff84a77ff9>] do_syscall_x64 arch/x86/entry/common.c:50 [inl=
ine]
> >     [<ffffffff84a77ff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.=
c:80
> >     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > BUG: memory leak
> > unreferenced object 0xffff88810e96ba80 (size 128):
> >   comm "syz-executor103", pid 5067, jiffies 4294964128 (age 13.070s)
> >   hex dump (first 32 bytes):
> >     64 75 6d 6d 79 5f 75 64 63 2e 30 00 00 00 00 00  dummy_udc.0.....
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   backtrace:
> >     [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
> >     [<ffffffff8347cdfc>] kmalloc include/linux/slab.h:582 [inline]
> >     [<ffffffff8347cdfc>] raw_ioctl_init+0x1ac/0x410 drivers/usb/gadget/=
legacy/raw_gadget.c:479
> >     [<ffffffff8347dfe9>] raw_ioctl+0x5f9/0x1120 drivers/usb/gadget/lega=
cy/raw_gadget.c:1250
> >     [<ffffffff81685173>] vfs_ioctl fs/ioctl.c:51 [inline]
> >     [<ffffffff81685173>] __do_sys_ioctl fs/ioctl.c:870 [inline]
> >     [<ffffffff81685173>] __se_sys_ioctl fs/ioctl.c:856 [inline]
> >     [<ffffffff81685173>] __x64_sys_ioctl+0x103/0x140 fs/ioctl.c:856
> >     [<ffffffff84a77ff9>] do_syscall_x64 arch/x86/entry/common.c:50 [inl=
ine]
> >     [<ffffffff84a77ff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.=
c:80
> >     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> >
> > BUG: memory leak
> > unreferenced object 0xffff88810e96bd00 (size 128):
> >   comm "syz-executor103", pid 5067, jiffies 4294964128 (age 13.070s)
> >   hex dump (first 32 bytes):
> >     00 bd 96 0e 81 88 ff ff 00 bd 96 0e 81 88 ff ff  ................
> >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> >   backtrace:
> >     [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
> >     [<ffffffff833ecc6a>] kmalloc include/linux/slab.h:582 [inline]
> >     [<ffffffff833ecc6a>] kzalloc include/linux/slab.h:703 [inline]
> >     [<ffffffff833ecc6a>] dummy_alloc_request+0x5a/0xe0 drivers/usb/gadg=
et/udc/dummy_hcd.c:665
> >     [<ffffffff833e9132>] usb_ep_alloc_request+0x22/0xd0 drivers/usb/gad=
get/udc/core.c:196
> >     [<ffffffff8347f13d>] gadget_bind+0x6d/0x370 drivers/usb/gadget/lega=
cy/raw_gadget.c:292
> >     [<ffffffff833e9e83>] gadget_bind_driver+0xe3/0x2e0 drivers/usb/gadg=
et/udc/core.c:1591
> >     [<ffffffff82ba069d>] call_driver_probe drivers/base/dd.c:579 [inlin=
e]
> >     [<ffffffff82ba069d>] really_probe+0x12d/0x430 drivers/base/dd.c:658
> >     [<ffffffff82ba0a61>] __driver_probe_device+0xc1/0x1a0 drivers/base/=
dd.c:798
> >     [<ffffffff82ba0b6a>] driver_probe_device+0x2a/0x120 drivers/base/dd=
.c:828
> >     [<ffffffff82ba0eae>] __driver_attach drivers/base/dd.c:1214 [inline=
]
> >     [<ffffffff82ba0eae>] __driver_attach+0xfe/0x1f0 drivers/base/dd.c:1=
154
> >     [<ffffffff82b9d985>] bus_for_each_dev+0xa5/0x110 drivers/base/bus.c=
:368
> >     [<ffffffff82b9f486>] bus_add_driver+0x126/0x2a0 drivers/base/bus.c:=
673
> >     [<ffffffff82ba25da>] driver_register+0x8a/0x190 drivers/base/driver=
.c:246
> >     [<ffffffff833e7524>] usb_gadget_register_driver_owner+0x64/0x160 dr=
ivers/usb/gadget/udc/core.c:1665
> >     [<ffffffff8347e0e6>] raw_ioctl_run drivers/usb/gadget/legacy/raw_ga=
dget.c:546 [inline]
> >     [<ffffffff8347e0e6>] raw_ioctl+0x6f6/0x1120 drivers/usb/gadget/lega=
cy/raw_gadget.c:1253
> >     [<ffffffff81685173>] vfs_ioctl fs/ioctl.c:51 [inline]
> >     [<ffffffff81685173>] __do_sys_ioctl fs/ioctl.c:870 [inline]
> >     [<ffffffff81685173>] __se_sys_ioctl fs/ioctl.c:856 [inline]
> >     [<ffffffff81685173>] __x64_sys_ioctl+0x103/0x140 fs/ioctl.c:856
> >     [<ffffffff84a77ff9>] do_syscall_x64 arch/x86/entry/common.c:50 [inl=
ine]
> >     [<ffffffff84a77ff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.=
c:80
> >
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.=
git
>  master

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.gi=
t
 master

--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -310,13 +310,14 @@ static int gadget_bind(struct usb_gadget *gadget,
        dev->eps_num =3D i;
        spin_unlock_irqrestore(&dev->lock, flags);

-       /* Matches kref_put() in gadget_unbind(). */
-       kref_get(&dev->count);
-
        ret =3D raw_queue_event(dev, USB_RAW_EVENT_CONNECT, 0, NULL);
-       if (ret < 0)
+       if (ret < 0) {
                dev_err(&gadget->dev, "failed to queue event\n");
+               return ret;
+       }

+       /* Matches kref_put() in gadget_unbind(). */
+       kref_get(&dev->count);
        return ret;
 }



>
> diff --git a/drivers/usb/gadget/legacy/raw_gadget.c
> b/drivers/usb/gadget/legacy/raw_gadget.c
> index 2acece16b890..c00f93b630ad 100644
> --- a/drivers/usb/gadget/legacy/raw_gadget.c
> +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> @@ -310,13 +310,12 @@ static int gadget_bind(struct usb_gadget *gadget,
>         dev->eps_num =3D i;
>         spin_unlock_irqrestore(&dev->lock, flags);
>
> -       /* Matches kref_put() in gadget_unbind(). */
> -       kref_get(&dev->count);
> -
>         ret =3D raw_queue_event(dev, USB_RAW_EVENT_CONNECT, 0, NULL);
>         if (ret < 0)
>                 dev_err(&gadget->dev, "failed to queue event\n");
>
> +       /* Matches kref_put() in gadget_unbind(). */
> +       kref_get(&dev->count);
>         return ret;
>  }
>
>
>
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
> > If the bug is already fixed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing=
.
> >
> > If you want to change bug's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the bug is a duplicate of another bug, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
