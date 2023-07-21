Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8132B75D118
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 20:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjGUSKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 14:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGUSKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 14:10:43 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989EC2D46
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 11:10:41 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40540a8a3bbso30321cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 11:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689963040; x=1690567840;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TXbzfS1BdRcATFOUBXiwGwm7lsbqmlQn+1/FS7QC9mg=;
        b=kEiowOaS2fZSAdZQspgVFFVXmDM6wXdItkjtF+85cyYJvF9oSsFign6yzvDqGkYquX
         gDodmdHXYYXubGk2XBhryWr7fkx3nYuhS7mrPv1KL2tu2ASlo4PJ1f6bNctkV5q938WM
         w9AmtY3MFfyaETniJNS5r3Vqy6YP4OsobEus3XZRlt/OzSo4XE8Z4wcZWiAei+41vAzG
         3ixEIg6N0qSmlVUN39olTS7ubBA8N0sBgj2RuPaweJ7l3wSJ+WplTnFgo0J4q+1QLNeP
         9tP+Pvs0vardlNtLggE3cuHhglnmUQqOuD7ywkH/ss9Vw01TVpMVjRtLIJop22IECxcw
         gWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689963040; x=1690567840;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXbzfS1BdRcATFOUBXiwGwm7lsbqmlQn+1/FS7QC9mg=;
        b=F+eXWBsJgH1xmuSLNT8PiPdOKRK6xXlxZdQaclHFmfb0Z5l/dsFhn8b5gfndlY1I/J
         qayeIMZDOoaoMqHwp/0fHwRyVQ+CODm8keIyMTtlowHBT+880QE30OAof0uoG5dSzkUq
         gCUgNjIbvFpVPnnlt1p7/RVmt3cTrkXx7q2GCI7aB/pISznm14po7j0y9LP+HMzrViap
         IpzGYcNxaIP1zYoK4CN+YZmuasUl9rNK8NQq6CBEkHmzECKm3n5fFy7BQXXctXILh1sF
         h30ppYNond1X2vV1Dkk+QvMYhdXTkJF/t4uv8Ri37oMZZrqS5tXehcQj/vkyEZgm3K2z
         EZSQ==
X-Gm-Message-State: ABy/qLYbw8+NMvdI70RFKb3woA9Jgu8FOurJL/2cTWGZ6SFyofuTSMUa
        PYqvqvZZvxoW+Eos53ceUYHwVXKXcWXD7ow3JWHjuneOASW0umGmOuGBZw==
X-Google-Smtp-Source: APBJJlHAKT9wkXtzkakDOw4xLXcZGmOsh+GFQ2UW2jqv8GwPJrNuvLTOZMm+mKPH6HU7869Xp2+qtrRxmMU8hq/sFyE=
X-Received: by 2002:ac8:5848:0:b0:3fa:45ab:22a5 with SMTP id
 h8-20020ac85848000000b003fa45ab22a5mr20520qth.27.1689963040401; Fri, 21 Jul
 2023 11:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c0ffe505fe86c9ca@google.com>
In-Reply-To: <000000000000c0ffe505fe86c9ca@google.com>
From:   Khazhy Kumykov <khazhy@google.com>
Date:   Fri, 21 Jul 2023 11:10:27 -0700
Message-ID: <CACGdZYJVYXA1gYTx+fvLa6H443+4SXLgG-iJcE7wQYSh+0aOzg@mail.gmail.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in
 read_descriptors (3)
To:     syzbot <syzbot+18996170f8096c6174d0@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000bbf1e90601032ef2"
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

--000000000000bbf1e90601032ef2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 19, 2023 at 7:56=E2=80=AFPM syzbot
<syzbot+18996170f8096c6174d0@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    40f71e7cd3c6 Merge tag 'net-6.4-rc7' of git://git.kernel.=
o..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1581445b28000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dac246111fb601=
aec
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D18996170f8096c6=
174d0
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binuti=
ls for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15d23487280=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16613ed328000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/30922ad38c58/dis=
k-40f71e7c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3bd12e7503b8/vmlinu=
x-40f71e7c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1dcd340b18d4/b=
zImage-40f71e7c.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+18996170f8096c6174d0@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-out-of-bounds in read_descriptors+0x263/0x280 drivers/us=
b/core/sysfs.c:883
> Read of size 8 at addr ffff88801e78b8c8 by task udevd/5011
>
> CPU: 0 PID: 5011 Comm: udevd Not tainted 6.4.0-rc6-syzkaller-00195-g40f71=
e7cd3c6 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 05/27/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
>  print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
>  print_report mm/kasan/report.c:462 [inline]
>  kasan_report+0x11c/0x130 mm/kasan/report.c:572

"src =3D udev->rawdescriptors[cfgno]" (so, just reading rawdescriptors)

>  read_descriptors+0x263/0x280 drivers/usb/core/sysfs.c:883
>  sysfs_kf_bin_read+0x19a/0x270 fs/sysfs/file.c:97
>  kernfs_file_read_iter fs/kernfs/file.c:251 [inline]
>  kernfs_fop_read_iter+0x387/0x690 fs/kernfs/file.c:280
>  call_read_iter include/linux/fs.h:1862 [inline]
>  new_sync_read fs/read_write.c:389 [inline]
>  vfs_read+0x4b1/0x8a0 fs/read_write.c:470
>  ksys_read+0x12b/0x250 fs/read_write.c:613
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f07c7916b6a
> Code: 00 3d 00 00 41 00 75 0d 50 48 8d 3d 2d 08 0a 00 e8 ea 7d 01 00 31 c=
0 e9 07 ff ff ff 64 8b 04 25 18 00 00 00 85 c0 75 1b 0f 05 <48> 3d 00 f0 ff=
 ff 76 6c 48 8b 15 8f a2 0d 00 f7 d8 64 89 02 48 83
> RSP: 002b:00007ffdf34973d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f07c7916b6a
> RDX: 0000000000010011 RSI: 00007ffdf3497407 RDI: 0000000000000008
> RBP: 0000000000000008 R08: 0000000000000003 R09: f4f13e10193fbafe
> R10: 0000000000000000 R11: 0000000000000246 R12: 000055be37470e10
> R13: 00007ffdf34a7ae8 R14: 00007ffdf34a8138 R15: 00007ffdf3497407
>  </TASK>
>
> Allocated by task 758:
>  kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
>  kasan_set_track+0x25/0x30 mm/kasan/common.c:52
>  ____kasan_kmalloc mm/kasan/common.c:374 [inline]
>  ____kasan_kmalloc mm/kasan/common.c:333 [inline]
>  __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
>  kasan_kmalloc include/linux/kasan.h:196 [inline]
>  __do_kmalloc_node mm/slab_common.c:966 [inline]
>  __kmalloc+0x5e/0x190 mm/slab_common.c:979
>  kmalloc include/linux/slab.h:563 [inline]
>  kzalloc include/linux/slab.h:680 [inline]

kzmalloc(length) -> this length derived from dev->descriptor.bNumConfigurat=
ions

The corresponding kfree is in usb_destroy_configuration (makes sense)
- we also set rawdescriptors to NULL here. If this race was happening,
I'd also expect some sort of null deref report...

Stumbled upon https://lore.kernel.org/all/1599201467-11000-1-git-send-email=
-prime.zeng@hisilicon.com/T/,
which suggests that we can, instead, race with a descriptor change,
which sounds plausible - descriptor changes, bNumConfigurations no
longer lines up with our kmalloc... so we may run past the end of it.

Looking at hub_port_connect_change(), we seem to read directly into
udev->descriptor, check if it changed, and if it did, set
udev->descriptor back to the old one...? If we have an ongoing sysfs
read, which directly touches udev->descriptor, there might be
trouble...

I see this is called in both hub_port_connect_change() and
usb_reset_and_verify_device()... which both seem to lock the port_dev?
("port_dev->status_lock"). This looks like a different lock than
usb_lock_device_interruptible would grab, maybe the code has changed
since that was reported in 2020. But it seems to suggest we want to
grab this lock in sysfs to safely read from udev->descriptor.

(I'm not clear on when the sysfs gets added/removed, since it happens
in usb_bus_notify()..., the above two functions that touch
udev->descriptor don't look like they send the
BUS_NOTIFY_ADD/DEL_DEVICE to me, so the race seems plausible)

>  usb_get_configuration+0x1f7/0x5170 drivers/usb/core/config.c:887
>  usb_enumerate_device drivers/usb/core/hub.c:2407 [inline]
>  usb_new_device+0x12b0/0x19d0 drivers/usb/core/hub.c:2545
>  hub_port_connect drivers/usb/core/hub.c:5407 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
>  port_event drivers/usb/core/hub.c:5711 [inline]
>  hub_event+0x2d9e/0x4e40 drivers/usb/core/hub.c:5793
>  process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
>  worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
>  kthread+0x344/0x440 kernel/kthread.c:379
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>
> The buggy address belongs to the object at ffff88801e78b8c0
>  which belongs to the cache kmalloc-8 of size 8
> The buggy address is located 0 bytes to the right of
>  allocated 8-byte region [ffff88801e78b8c0, ffff88801e78b8c8)
>
> The buggy address belongs to the physical page:
> page:ffffea000079e2c0 refcount:1 mapcount:0 mapping:0000000000000000 inde=
x:0x0 pfn:0x1e78b
> anon flags: 0xfff00000000200(slab|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> page_type: 0xffffffff()
> raw: 00fff00000000200 ffff888012441280 0000000000000000 dead000000000001
> raw: 0000000000000000 0000000000660066 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(=
GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 82983=
45549, free_ts 8292702290
>  set_page_owner include/linux/page_owner.h:31 [inline]
>  post_alloc_hook+0x2db/0x350 mm/page_alloc.c:1731
>  prep_new_page mm/page_alloc.c:1738 [inline]
>  get_page_from_freelist+0xf41/0x2c00 mm/page_alloc.c:3502
>  __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4768
>  alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2112
>  alloc_pages+0x233/0x270 mm/mempolicy.c:2274
>  alloc_slab_page mm/slub.c:1851 [inline]
>  allocate_slab+0x25f/0x390 mm/slub.c:1998
>  new_slab mm/slub.c:2051 [inline]
>  ___slab_alloc+0xa91/0x1400 mm/slub.c:3192
>  __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3291
>  __slab_alloc_node mm/slub.c:3344 [inline]
>  slab_alloc_node mm/slub.c:3441 [inline]
>  __kmem_cache_alloc_node+0x136/0x320 mm/slub.c:3490
>  __do_kmalloc_node mm/slab_common.c:965 [inline]
>  __kmalloc_node_track_caller+0x4f/0x1a0 mm/slab_common.c:986
>  kstrdup+0x3f/0x70 mm/util.c:62
>  kstrdup_const+0x57/0x80 mm/util.c:85
>  kvasprintf_const+0x10c/0x190 lib/kasprintf.c:48
>  kobject_set_name_vargs+0x5a/0x150 lib/kobject.c:267
>  dev_set_name+0xbf/0xf0 drivers/base/core.c:3429
>  tty_register_device_attr+0x301/0x7d0 drivers/tty/tty_io.c:3243
> page last free stack trace:
>  reset_page_owner include/linux/page_owner.h:24 [inline]
>  free_pages_prepare mm/page_alloc.c:1302 [inline]
>  free_unref_page_prepare+0x62e/0xcb0 mm/page_alloc.c:2564
>  free_unref_page+0x33/0x370 mm/page_alloc.c:2659
Huh, why did our page get vfree'd, when it was kmalloc'd? Maybe the
memory was reused multiple times before generating this report...?
>  vfree+0x180/0x7e0 mm/vmalloc.c:2798
>  delayed_vfree_work+0x57/0x70 mm/vmalloc.c:2719
>  process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
>  worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
>  kthread+0x344/0x440 kernel/kthread.c:379
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>
> Memory state around the buggy address:
>  ffff88801e78b780: 00 fc fc fc fc fa fc fc fc fc fa fc fc fc fc fa
>  ffff88801e78b800: fc fc fc fc 00 fc fc fc fc fa fc fc fc fc fa fc
> >ffff88801e78b880: fc fc fc fa fc fc fc fc 00 fc fc fc fc 00 fc fc
>                                               ^
>  ffff88801e78b900: fc fc 00 fc fc fc fc fa fc fc fc fc 00 fc fc fc
>  ffff88801e78b980: fc 00 fc fc fc fc fa fc fc fc fc 00 fc fc fc fc
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
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

--000000000000bbf1e90601032ef2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPmwYJKoZIhvcNAQcCoIIPjDCCD4gCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz1MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
2d1HymA53tUP1hUwTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYmaHR0cHM6
Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/BAIwADCBmgYIKwYBBQUH
AQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2NhL2dzYXRs
YXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29t
L2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgwFoAUfMwKaNei6x4schvR
zV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEBADeZduKRV5+J7StRkfoY
hBDfCkyRbFphFmeJ+0A1fPxECLLkrXR2izyctzMAGZH2ceScAlECO1r3aEQcyx9n7/YlMc24ZF0I
++9b72/wv6J6POICeIj6MgschmHIUz4Rw4H5IdBLo62N0jBBzv2T9ASRAl7Yryl6tHUN5X5228Tt
3LJe5Gtb1cm22DdXBM3xnD7Kd59ls9j/tz5I+yEsLIK7zQk7hBt87a31T55CTVgMQZ4lTavG5vdz
vEb7YC0jFAT8SmYmtSOr+4aZJRIwVjXlI04Mfr3jcbqDnzfv0VgVp5UlzQK4aApofbSsSDeXsDR+
t30gEkeMNUvUqd6PaxYxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9i
YWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIzIFNNSU1FIENBIDIwMjAC
EAGy8e6bI55p/yISlXXGSrAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIK/ZmyIK
EsuAL8OoZAJxBS68+Ad8c8OBNkq6yIM1YLUuMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTIzMDcyMTE4MTA0MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAVcj74rgxZOiGHCXMcvuWCPY2X
jiW13/IBlRnbk21ekJ5aBzkaWhPwbHHe9hqMEDOG+wV2rUiu/X2JdlVfUIDL8nZ8wIEkjaFbeQ/r
nBDT9rOrborr2TGxmtooG06OWkN/JCjWQZquTo/uXWKGU+YT+gyCNp0MYCAqAOohRQYFr6BZ2E7j
xdj0oEpE1O7m8IbZygNnK/C6JUm1bfO3DGRNNqtevxGYNwumx/6ODM7yFPpe06zauYHrKXtoiaUa
80hwF1O5+4cGuup8JTfYjL/pHRzUyr2h8JD/qMzbKmwIZggBI49famQNJb3OclC2+G3kc/+PMg7E
ylP135NQlWL3
--000000000000bbf1e90601032ef2--
