Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20607536FA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbjGNJsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbjGNJrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:47:55 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8D430DE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:47:51 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbd33a1819so47675e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689328070; x=1691920070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AB28jTtYwCDZ7KgVFdc80ouWDjex8LD1i8UrxUr0xx8=;
        b=6+za/qwqfyTzVX1ny/9MnOXTEN4MVlVs0hfM3qKGQyHIf0EqFkQFa6LOW9TBf3Vcyp
         RenGkOWHvyFOrf/izsxt3PS0A2mItlzqVaucQ+2CBLmw/Ihc8XpdrCsHJpM8k3eZvfA8
         jWEjNq7mlw1uhrRWX+DralnOU8oQV3RvxtZcXXrJYqOzObWl+EbPbCPFr0GwKhzqaa0z
         HXylq6SZxgnl5eUGOYXu0T2iewqlY4Cm88meT7UtSAcNXltsM56jvtPilAH1v0JVkTOc
         rgMB9yYN5p2RWin6gLjftsW5pPZJhhoVm8zMDMjpb2YsXudhKlqVmdI40L2BL1e2JEro
         Mkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689328070; x=1691920070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AB28jTtYwCDZ7KgVFdc80ouWDjex8LD1i8UrxUr0xx8=;
        b=XzzRWf9Qr/wob7mYHe504qAryKHFiPssqSwyc9zgcxkOs6HG1MAf9FYW63N/gfikfQ
         CSwaN1NMmL89FmWRcRWHghnj0p+7ct4ZNoHkZHAuJDzOMh97M6NCAHrmCbgZiKeoeadz
         9J2M3uqCvVQRHFJ919QuROgzJ+qUSnjX6ka5RdWyKcANR0xDuvhxiQoSetnY2h7KdYMU
         5qU85szsOZkjAwPwwrwu2skUCOL2FJiKHhBOV6/p+qH7boFVVZZH8ti+c/uY7k/CRqK1
         WWKd1Zvnjp6gAGXMxvdbdigava2X3Ppced6h3c5vxP/x5wbsTozG5dcerlIEDNYvocPa
         9nQw==
X-Gm-Message-State: ABy/qLa6pUUmnNwbGncOLxXqIC7xZeKOmK67dyhALimb/Jg0yZ0wm92I
        yOSkc6m909ILjlGvdRyda7ynwt11Q0vV0sVQ7jM5wQ==
X-Google-Smtp-Source: APBJJlEBm1bnElmIQKhPLpT/xIOwjpy2LpFPRWwjFAHtQfnx2VzRoIEE9XcmGwCunZbnkB9gjWLpjcXCiMorGYDoUEI=
X-Received: by 2002:a05:600c:8609:b0:3f1:73b8:b5fe with SMTP id
 ha9-20020a05600c860900b003f173b8b5femr302722wmb.3.1689328069613; Fri, 14 Jul
 2023 02:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000009db51a06005b64e9@google.com> <CALm+0cXi-YsnJBdBt38v4gEoR7oEeaoj3wXjEw3m=25RSLEs8g@mail.gmail.com>
In-Reply-To: <CALm+0cXi-YsnJBdBt38v4gEoR7oEeaoj3wXjEw3m=25RSLEs8g@mail.gmail.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 14 Jul 2023 11:47:37 +0200
Message-ID: <CANp29Y6P06Hd0x+oovcL480pHmFnkxqDN9AaEnjbdwGrbqzDzg@mail.gmail.com>
Subject: Re: [syzbot] [usb?] memory leak in raw_open
To:     Z qiang <qiang.zhang1211@gmail.com>
Cc:     syzbot <syzbot+feb045d335c1fdde5bf7@syzkaller.appspotmail.com>,
        andreyknvl@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 14, 2023 at 9:12=E2=80=AFAM Z qiang <qiang.zhang1211@gmail.com>=
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
> >
>
>
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.=
git
>   master
>
>
> --- a/drivers/usb/gadget/legacy/raw_gadget.c
> +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> @@ -310,12 +310,15 @@ static int gadget_bind(struct usb_gadget *gadget,
>         dev->eps_num =3D i;
>         spin_unlock_irqrestore(&dev->lock, flags);
>

syzbot expects that every line of the git diff patch begins with some
character (unchanged lines with space, added/deleted with + and -
correspondingly). Here you have an empty line and syzbot thinks it's
already the end of the patch. Therefore the patch testing fails.

> -       /* Matches kref_put() in gadget_unbind(). */
> -       kref_get(&dev->count);
> -
>         ret =3D raw_queue_event(dev, USB_RAW_EVENT_CONNECT, 0, NULL);
> -       if (ret < 0)
> +       if (ret < 0) {
>                 dev_err(&gadget->dev, "failed to queue event\n");
> +               set_gadget_data(gadget, NULL);
> +               return ret;
> +       }
> +
> +       /* Matches kref_put() in gadget_unbind(). */
> +       kref_get(&dev->count);
>
>         return ret;
>  }
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/CALm%2B0cXi-YsnJBdBt38v4gEoR7oEeaoj3wXjEw3m%3D25RSLEs8g%40=
mail.gmail.com.
