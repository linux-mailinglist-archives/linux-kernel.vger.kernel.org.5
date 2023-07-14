Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F20753754
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbjGNKCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbjGNKCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:02:03 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BCE26B7;
        Fri, 14 Jul 2023 03:02:01 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-2633fe9b6c0so1976324a91.1;
        Fri, 14 Jul 2023 03:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689328920; x=1691920920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEvX4KPZZMtAxsaBUd2aHjaev/UBEibxCwQJvNcdreQ=;
        b=LlIXvZElFSwPQQP3EdOQW7/Ccpi+mGJa/+kHElIUP2221clCruGTO6JDTjGt/70Br9
         +1jYKgFH/pQQg+JwFLZRLt6g8zW7LKsjh90racIMltSY2Vv0DEpvQgAyPV2I6Sx7pylL
         OxeKUmfQeU4JaMFZMU3bnaZAw6qC2BewSuTP8+zi76DWflHKcVMMvQELCNe2zqV98zcb
         Y7Jg1odbeGGH4vHC3FvYTR9A3FrxVE1p5IPGp2rTmUKMloK+warj+83wmXRD1aWGeLXq
         I3rSJfHnSZQICUBq2VvGBaiSZaBc2nGUkEeSyPUuW8M4Q7RK13Jm+rl+NtMRJssLPkjF
         5OZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689328920; x=1691920920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEvX4KPZZMtAxsaBUd2aHjaev/UBEibxCwQJvNcdreQ=;
        b=H9FtCXaoFx0PLF6Wr2cwrWZtjWmrg+MC2/a1ZahWZMFhx02zm7yAxBUxvJuuXMOUQk
         azPgANhZyRnLeYtbPC7/nMdoxDyRyfMg/D3H+PUvhYFR7QX36T+Vw1eVQ7TfaNA/RY1N
         QnEqcxvdgnNBwjL9GWRu7ZTX6dGu4UHG8wV7LI7eMogBySQwzjIfBDcTARhpH4vJX3xV
         tac/I9FV3XGTVIoQx/1qwpwJ7OHJ+mb/CORJXc9gC0gqktkKNbmzH4KjEnG5+tkPoLFG
         YP+n+MKFOpWWsVcp1L5n9jvahuMGPuAFDlOWl1KKR8tBHclJwfXdpNx9t2XBpyX1zw3F
         Js7Q==
X-Gm-Message-State: ABy/qLbhltfLhJz6jbtSMgkJaQGT9KxWYeqXE0mmJ4Y2qSYCg+2IZunJ
        83zS/ECj6Y0H1lzSbqFealawzKK4gc2tyuPbkkQU+EyRmqk=
X-Google-Smtp-Source: APBJJlEwVJsZaXO2FCJthIep9FGM1eQnwxZKx86rxSc6rbfeUDXAbsdfqzs4ccD0qyM5FOmAtAUIB80E5VDO8647wzY=
X-Received: by 2002:a17:90a:72c8:b0:25e:fb6d:ce68 with SMTP id
 l8-20020a17090a72c800b0025efb6dce68mr3102557pjk.6.1689328920447; Fri, 14 Jul
 2023 03:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009db51a06005b64e9@google.com> <CALm+0cXi-YsnJBdBt38v4gEoR7oEeaoj3wXjEw3m=25RSLEs8g@mail.gmail.com>
 <CANp29Y6P06Hd0x+oovcL480pHmFnkxqDN9AaEnjbdwGrbqzDzg@mail.gmail.com>
In-Reply-To: <CANp29Y6P06Hd0x+oovcL480pHmFnkxqDN9AaEnjbdwGrbqzDzg@mail.gmail.com>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Fri, 14 Jul 2023 18:01:48 +0800
Message-ID: <CALm+0cUKu7eNg6iaw6fmNA8aubrS46ookSNxx4LM-qtMffRQmA@mail.gmail.com>
Subject: Re: [syzbot] [usb?] memory leak in raw_open
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     syzbot <syzbot+feb045d335c1fdde5bf7@syzkaller.appspotmail.com>,
        andreyknvl@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 5:47=E2=80=AFPM Aleksandr Nogikh <nogikh@google.com=
> wrote:
>
> Hi,
>
> On Fri, Jul 14, 2023 at 9:12=E2=80=AFAM Z qiang <qiang.zhang1211@gmail.co=
m> wrote:
> >
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    1c7873e33645 mm: lock newly mapped VMA with corrected=
 orde..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1517663ca=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D832b404e0=
95b70c0
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dfeb045d335c=
1fdde5bf7
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Bi=
nutils for Debian) 2.35.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1776519=
ca80000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D117f9778a=
80000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/43b42bd2cf70=
/disk-1c7873e3.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/011ba1b9e8c1/vm=
linux-1c7873e3.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/18b3493425=
95/bzImage-1c7873e3.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+feb045d335c1fdde5bf7@syzkaller.appspotmail.com
> > >
> > > BUG: memory leak
> > > unreferenced object 0xffff88810b172000 (size 4096):
> > >   comm "syz-executor103", pid 5067, jiffies 4294964128 (age 13.070s)
> > >   hex dump (first 32 bytes):
> > >     01 00 00 00 00 00 00 00 00 bc 96 0e 81 88 ff ff  ................
> > >     5d b6 9e 85 ff ff ff ff 03 00 00 00 00 00 00 00  ]...............
> > >   backtrace:
> > >     [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:107=
6
> > >     [<ffffffff8347eb55>] kmalloc include/linux/slab.h:582 [inline]
> > >     [<ffffffff8347eb55>] kzalloc include/linux/slab.h:703 [inline]
> > >     [<ffffffff8347eb55>] dev_new drivers/usb/gadget/legacy/raw_gadget=
.c:191 [inline]
> > >     [<ffffffff8347eb55>] raw_open+0x45/0x110 drivers/usb/gadget/legac=
y/raw_gadget.c:385
> > >     [<ffffffff827d1d09>] misc_open+0x1a9/0x1f0 drivers/char/misc.c:16=
5
> > >     [<ffffffff8166763b>] chrdev_open+0x11b/0x340 fs/char_dev.c:414
> > >     [<ffffffff8165573f>] do_dentry_open+0x30f/0x990 fs/open.c:914
> > >     [<ffffffff8167cabb>] do_open fs/namei.c:3636 [inline]
> > >     [<ffffffff8167cabb>] path_openat+0x178b/0x1b20 fs/namei.c:3793
> > >     [<ffffffff8167e995>] do_filp_open+0xc5/0x1b0 fs/namei.c:3820
> > >     [<ffffffff81659453>] do_sys_openat2+0xe3/0x140 fs/open.c:1407
> > >     [<ffffffff81659de3>] do_sys_open fs/open.c:1422 [inline]
> > >     [<ffffffff81659de3>] __do_sys_openat fs/open.c:1438 [inline]
> > >     [<ffffffff81659de3>] __se_sys_openat fs/open.c:1433 [inline]
> > >     [<ffffffff81659de3>] __x64_sys_openat+0x83/0xe0 fs/open.c:1433
> > >     [<ffffffff84a77ff9>] do_syscall_x64 arch/x86/entry/common.c:50 [i=
nline]
> > >     [<ffffffff84a77ff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/commo=
n.c:80
> > >     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > >
> > > BUG: memory leak
> > > unreferenced object 0xffff88810ad20d60 (size 32):
> > >   comm "syz-executor103", pid 5067, jiffies 4294964128 (age 13.070s)
> > >   hex dump (first 32 bytes):
> > >     72 61 77 2d 67 61 64 67 65 74 2e 30 00 00 00 00  raw-gadget.0....
> > >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > >   backtrace:
> > >     [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:107=
6
> > >     [<ffffffff8347cd2f>] kmalloc include/linux/slab.h:582 [inline]
> > >     [<ffffffff8347cd2f>] raw_ioctl_init+0xdf/0x410 drivers/usb/gadget=
/legacy/raw_gadget.c:460
> > >     [<ffffffff8347dfe9>] raw_ioctl+0x5f9/0x1120 drivers/usb/gadget/le=
gacy/raw_gadget.c:1250
> > >     [<ffffffff81685173>] vfs_ioctl fs/ioctl.c:51 [inline]
> > >     [<ffffffff81685173>] __do_sys_ioctl fs/ioctl.c:870 [inline]
> > >     [<ffffffff81685173>] __se_sys_ioctl fs/ioctl.c:856 [inline]
> > >     [<ffffffff81685173>] __x64_sys_ioctl+0x103/0x140 fs/ioctl.c:856
> > >     [<ffffffff84a77ff9>] do_syscall_x64 arch/x86/entry/common.c:50 [i=
nline]
> > >     [<ffffffff84a77ff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/commo=
n.c:80
> > >     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > >
> > > BUG: memory leak
> > > unreferenced object 0xffff88810e96bc00 (size 128):
> > >   comm "syz-executor103", pid 5067, jiffies 4294964128 (age 13.070s)
> > >   hex dump (first 32 bytes):
> > >     64 75 6d 6d 79 5f 75 64 63 00 00 00 00 00 00 00  dummy_udc.......
> > >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > >   backtrace:
> > >     [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:107=
6
> > >     [<ffffffff8347cd6d>] kmalloc include/linux/slab.h:582 [inline]
> > >     [<ffffffff8347cd6d>] raw_ioctl_init+0x11d/0x410 drivers/usb/gadge=
t/legacy/raw_gadget.c:468
> > >     [<ffffffff8347dfe9>] raw_ioctl+0x5f9/0x1120 drivers/usb/gadget/le=
gacy/raw_gadget.c:1250
> > >     [<ffffffff81685173>] vfs_ioctl fs/ioctl.c:51 [inline]
> > >     [<ffffffff81685173>] __do_sys_ioctl fs/ioctl.c:870 [inline]
> > >     [<ffffffff81685173>] __se_sys_ioctl fs/ioctl.c:856 [inline]
> > >     [<ffffffff81685173>] __x64_sys_ioctl+0x103/0x140 fs/ioctl.c:856
> > >     [<ffffffff84a77ff9>] do_syscall_x64 arch/x86/entry/common.c:50 [i=
nline]
> > >     [<ffffffff84a77ff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/commo=
n.c:80
> > >     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > >
> > > BUG: memory leak
> > > unreferenced object 0xffff88810e96ba80 (size 128):
> > >   comm "syz-executor103", pid 5067, jiffies 4294964128 (age 13.070s)
> > >   hex dump (first 32 bytes):
> > >     64 75 6d 6d 79 5f 75 64 63 2e 30 00 00 00 00 00  dummy_udc.0.....
> > >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > >   backtrace:
> > >     [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:107=
6
> > >     [<ffffffff8347cdfc>] kmalloc include/linux/slab.h:582 [inline]
> > >     [<ffffffff8347cdfc>] raw_ioctl_init+0x1ac/0x410 drivers/usb/gadge=
t/legacy/raw_gadget.c:479
> > >     [<ffffffff8347dfe9>] raw_ioctl+0x5f9/0x1120 drivers/usb/gadget/le=
gacy/raw_gadget.c:1250
> > >     [<ffffffff81685173>] vfs_ioctl fs/ioctl.c:51 [inline]
> > >     [<ffffffff81685173>] __do_sys_ioctl fs/ioctl.c:870 [inline]
> > >     [<ffffffff81685173>] __se_sys_ioctl fs/ioctl.c:856 [inline]
> > >     [<ffffffff81685173>] __x64_sys_ioctl+0x103/0x140 fs/ioctl.c:856
> > >     [<ffffffff84a77ff9>] do_syscall_x64 arch/x86/entry/common.c:50 [i=
nline]
> > >     [<ffffffff84a77ff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/commo=
n.c:80
> > >     [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > >
> > > BUG: memory leak
> > > unreferenced object 0xffff88810e96bd00 (size 128):
> > >   comm "syz-executor103", pid 5067, jiffies 4294964128 (age 13.070s)
> > >   hex dump (first 32 bytes):
> > >     00 bd 96 0e 81 88 ff ff 00 bd 96 0e 81 88 ff ff  ................
> > >     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > >   backtrace:
> > >     [<ffffffff8154bf94>] kmalloc_trace+0x24/0x90 mm/slab_common.c:107=
6
> > >     [<ffffffff833ecc6a>] kmalloc include/linux/slab.h:582 [inline]
> > >     [<ffffffff833ecc6a>] kzalloc include/linux/slab.h:703 [inline]
> > >     [<ffffffff833ecc6a>] dummy_alloc_request+0x5a/0xe0 drivers/usb/ga=
dget/udc/dummy_hcd.c:665
> > >     [<ffffffff833e9132>] usb_ep_alloc_request+0x22/0xd0 drivers/usb/g=
adget/udc/core.c:196
> > >     [<ffffffff8347f13d>] gadget_bind+0x6d/0x370 drivers/usb/gadget/le=
gacy/raw_gadget.c:292
> > >     [<ffffffff833e9e83>] gadget_bind_driver+0xe3/0x2e0 drivers/usb/ga=
dget/udc/core.c:1591
> > >     [<ffffffff82ba069d>] call_driver_probe drivers/base/dd.c:579 [inl=
ine]
> > >     [<ffffffff82ba069d>] really_probe+0x12d/0x430 drivers/base/dd.c:6=
58
> > >     [<ffffffff82ba0a61>] __driver_probe_device+0xc1/0x1a0 drivers/bas=
e/dd.c:798
> > >     [<ffffffff82ba0b6a>] driver_probe_device+0x2a/0x120 drivers/base/=
dd.c:828
> > >     [<ffffffff82ba0eae>] __driver_attach drivers/base/dd.c:1214 [inli=
ne]
> > >     [<ffffffff82ba0eae>] __driver_attach+0xfe/0x1f0 drivers/base/dd.c=
:1154
> > >     [<ffffffff82b9d985>] bus_for_each_dev+0xa5/0x110 drivers/base/bus=
.c:368
> > >     [<ffffffff82b9f486>] bus_add_driver+0x126/0x2a0 drivers/base/bus.=
c:673
> > >     [<ffffffff82ba25da>] driver_register+0x8a/0x190 drivers/base/driv=
er.c:246
> > >     [<ffffffff833e7524>] usb_gadget_register_driver_owner+0x64/0x160 =
drivers/usb/gadget/udc/core.c:1665
> > >     [<ffffffff8347e0e6>] raw_ioctl_run drivers/usb/gadget/legacy/raw_=
gadget.c:546 [inline]
> > >     [<ffffffff8347e0e6>] raw_ioctl+0x6f6/0x1120 drivers/usb/gadget/le=
gacy/raw_gadget.c:1253
> > >     [<ffffffff81685173>] vfs_ioctl fs/ioctl.c:51 [inline]
> > >     [<ffffffff81685173>] __do_sys_ioctl fs/ioctl.c:870 [inline]
> > >     [<ffffffff81685173>] __se_sys_ioctl fs/ioctl.c:856 [inline]
> > >     [<ffffffff81685173>] __x64_sys_ioctl+0x103/0x140 fs/ioctl.c:856
> > >     [<ffffffff84a77ff9>] do_syscall_x64 arch/x86/entry/common.c:50 [i=
nline]
> > >     [<ffffffff84a77ff9>] do_syscall_64+0x39/0xb0 arch/x86/entry/commo=
n.c:80
> > >
> > >
> >
> >
> > #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-nex=
t.git
> >   master
> >
> >
> > --- a/drivers/usb/gadget/legacy/raw_gadget.c
> > +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> > @@ -310,12 +310,15 @@ static int gadget_bind(struct usb_gadget *gadget,
> >         dev->eps_num =3D i;
> >         spin_unlock_irqrestore(&dev->lock, flags);
> >
>
> syzbot expects that every line of the git diff patch begins with some
> character (unchanged lines with space, added/deleted with + and -
> correspondingly). Here you have an empty line and syzbot thinks it's
> already the end of the patch. Therefore the patch testing fails.
>

Thanks for your remind and I also sent a patch :)

Thanks
Zqiang


>
> > -       /* Matches kref_put() in gadget_unbind(). */
> > -       kref_get(&dev->count);
> > -
> >         ret =3D raw_queue_event(dev, USB_RAW_EVENT_CONNECT, 0, NULL);
> > -       if (ret < 0)
> > +       if (ret < 0) {
> >                 dev_err(&gadget->dev, "failed to queue event\n");
> > +               set_gadget_data(gadget, NULL);
> > +               return ret;
> > +       }
> > +
> > +       /* Matches kref_put() in gadget_unbind(). */
> > +       kref_get(&dev->count);
> >
> >         return ret;
> >  }
> >
> > --
> > You received this message because you are subscribed to the Google Grou=
ps "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/ms=
gid/syzkaller-bugs/CALm%2B0cXi-YsnJBdBt38v4gEoR7oEeaoj3wXjEw3m%3D25RSLEs8g%=
40mail.gmail.com.
