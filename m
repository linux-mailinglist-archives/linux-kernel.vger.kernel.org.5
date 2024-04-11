Return-Path: <linux-kernel+bounces-139954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 360658A0990
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74D11F24B82
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB90113DDD9;
	Thu, 11 Apr 2024 07:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6S9BVeZ"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D0213B5B0;
	Thu, 11 Apr 2024 07:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819981; cv=none; b=XCGYT8Kc/VsrAbI3XKEjkT9qaQim7NwFluHVJfGufYWSaKy4OFUNGPn/zPwsaoJ99iSvmC9wPwEV/z5QzIMZjGKiiB8/Gjc7MPNPXqxT8kP4wCp+AhejNL+BZVCzi42MxIp0kCYFGKcCNovYWqO+HlAleCcC5v9iqLzsg/gQ6Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819981; c=relaxed/simple;
	bh=OEtV35vaVID4JjOKCTYuJ+CqRcwd+a4K+zPK2GiqyMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OnjTC7Z3w/IBSwKprI5dp7hmTu6sNyEwpzbmeMYuLjlVUDVq79/BV2PtdQAJJ/6/CIMQewFffgwfCo31QHO2/c8KzPHuuo8gYveqYSalf4Msbb6YKkK13UC/Eg/Ch2hFkEDpL/p8Bx8lc8HkeSl4svxEvYnM8UQ2L4Tc5p74J9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6S9BVeZ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a52140ea1b5so159114366b.1;
        Thu, 11 Apr 2024 00:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712819977; x=1713424777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wH5zcgsELbzNmlnnzMYGJW4WkIm6tIFidEHq2GOj6Fs=;
        b=R6S9BVeZNhXPjkbXyK5phW4RHeyUV+j/3rbvdQI7u+7WthPp2bN64dLFEwbbpzgBbb
         d5x662VZStrnMV7ks5YE5ciwq6k1VOjjocSRa+/qGg0YbKsF4QmiXSGefXRKt5ei75Vs
         CQl4ET+3vBiHzdf6+yKD9ETfHZUAlvJQ4mwjTBM2c2ygCRL80v3szPvMjB9OmI1snG5+
         0fOiW7j8jRj20656PwkmJlrJanx4A5GrgsryxD1o/GcPmzJWYvj9DEz0j4NmpK7j/jdD
         KIafl60CyG4m2kmF/sfoK3Dl/p4KVWtYI5K1ofQxcCqOt47h/oUMRdiDf1+5GcmpWdTY
         ecqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712819977; x=1713424777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wH5zcgsELbzNmlnnzMYGJW4WkIm6tIFidEHq2GOj6Fs=;
        b=qjlvTALbdcc9++w9vbOXxxX4pJMC6CYaivH8yUX29af/aAOp7tIl4N+Ix3pNq3KOm6
         tmA9IrMIpxCHvHhOvFC8WSIaVmy+VMlOnjofVE1e47srcJDSSQUI2KRRDgCgx2XKnflP
         L7ZRjvjImnRGKKzI5z0xJrDlqIz5jMW9tEfWFcrZzfcG0sLds6ezyNplxX9EEz/uBHQQ
         ZEaJfJk6zN5VxYAsur4O5gIeaSTWiAo7zzacnCi4rMvWWM+2qxc6Qz6YeuXhTZXmaCw/
         z20QAZhG+NcGO/ygIPndedrwAmZeFX1dwJMXb8u8fwJEKxuJr/Q016FhDNaCGxbITVvD
         AdyA==
X-Forwarded-Encrypted: i=1; AJvYcCXAGAIoVoB13762ZyGP5Z0poU3wZjDLBSSKWb7s/uTTww7AarSawhQJGbkjubYSSghVN5lxhY5ma61kEfW89MxJoIb3puaGZAny
X-Gm-Message-State: AOJu0YwLEbD6wj5r+YEwComA772S0e6/JGNMypY7TeapAgA2qBhOE1di
	0r+MgCuijP+bdpQNosbU7XYG8TaMhDKaH8XxWfNNrbKwcFhU94ifKrToKAIcFE2FKp9k4tyBlxC
	CL7BXtJtAoujSXifRkb62J0aEBeQ=
X-Google-Smtp-Source: AGHT+IHs08EJ1Ow6JiaSkwTgaC/KpYV9Pj8lajSkYqdvicO7tPHw1NwYZzUBRHe06IkCsd5+aVKbiyt0wIopU6xKiac=
X-Received: by 2002:a17:907:7205:b0:a4e:4278:8a01 with SMTP id
 dr5-20020a170907720500b00a4e42788a01mr3804417ejc.11.1712819977200; Thu, 11
 Apr 2024 00:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEkJfYON+ry7xPx=AiLR9jzUNT+i_Va68ACajOC3HoacOfL1ig@mail.gmail.com>
 <2024041125-anemic-decorated-52aa@gregkh>
In-Reply-To: <2024041125-anemic-decorated-52aa@gregkh>
From: Sam Sun <samsun1006219@gmail.com>
Date: Thu, 11 Apr 2024 15:19:25 +0800
Message-ID: <CAEkJfYPBjBbHX0Nt4Pxg3orPfZzRGjYhgZKGphoO5+Pskso7hQ@mail.gmail.com>
Subject: Re: [Linux kernel bug] general protection fault in disable_store
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Alan Stern <stern@rowland.harvard.edu>, swboyd@chromium.org, ricardo@marliere.net, 
	hkallweit1@gmail.com, heikki.krogerus@linux.intel.com, 
	mathias.nyman@linux.intel.com, royluo@google.com, 
	syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 2:58=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Apr 11, 2024 at 02:52:27PM +0800, Sam Sun wrote:
> > Dear developers and maintainers,
> >
> > We encountered a general protection fault in function disable_store.
> > It is tested against the latest upstream linux (tag 6.9-rc3). C repro
> > and kernel config are attached to this email. Kernel crash log is
> > listed below.
> > ```
> > general protection fault, probably for non-canonical address
> > 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> > CPU: 1 PID: 9459 Comm: syz-executor414 Not tainted 6.7.0-rc7 #2
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
> > RIP: 0010:disable_store+0xd0/0x3d0 drivers/usb/core/port.c:88
> > Code: 02 00 00 4c 8b 75 40 4d 8d be 58 ff ff ff 4c 89 ff e8 a4 20 fa
> > ff 48 89 c2 48 89 c5 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c
> > 02 00 0f 85 b0 02 00 00 48 8b 45 00 48 8d bb 34 05 00 00 48
> > RSP: 0018:ffffc90006e3fc08 EFLAGS: 00010246
> > RAX: dffffc0000000000 RBX: ffff88801d4d4008 RCX: ffffffff86706be8
> > RDX: 0000000000000000 RSI: ffffffff86706c4d RDI: 0000000000000005
> > RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff92000dc7f85
> > R13: ffff88810f4bfb18 R14: ffff88801d4d10a8 R15: ffff88801d4d1000
> > FS:  00007fa0af71b640(0000) GS:ffff888135c00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fa0af71a4b8 CR3: 0000000022f5f000 CR4: 0000000000750ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > PKRU: 55555554
> > Call Trace:
> >  <TASK>
> >  dev_attr_store+0x54/0x80 drivers/base/core.c:2366
> >  sysfs_kf_write+0x114/0x170 fs/sysfs/file.c:136
> >  kernfs_fop_write_iter+0x337/0x500 fs/kernfs/file.c:334
> >  call_write_iter include/linux/fs.h:2020 [inline]
> >  new_sync_write fs/read_write.c:491 [inline]
> >  vfs_write+0x96a/0xd80 fs/read_write.c:584
> >  ksys_write+0x122/0x250 fs/read_write.c:637
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> > RIP: 0033:0x7fa0aff9ee1f
> > Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 a9 f4 02 00 48 8b 54
> > 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d
> > 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 ec f4 02 00 48
> > RSP: 002b:00007fa0af71a460 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
> > RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007fa0aff9ee1f
> > RDX: 0000000000000004 RSI: 00007fa0af71acc0 RDI: 0000000000000005
> > RBP: 0000000000000005 R08: 0000000000000000 R09: 00007fffdb6af2cf
> > R10: 0000000000000000 R11: 0000000000000293 R12: 00007fa0af71acc0
> > R13: 000000000000006e R14: 00007fa0aff613d0 R15: 00007fa0af6fb000
> >  </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:disable_store+0xd0/0x3d0 drivers/usb/core/port.c:88
> > Code: 02 00 00 4c 8b 75 40 4d 8d be 58 ff ff ff 4c 89 ff e8 a4 20 fa
> > ff 48 89 c2 48 89 c5 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c
> > 02 00 0f 85 b0 02 00 00 48 8b 45 00 48 8d bb 34 05 00 00 48
> > RSP: 0018:ffffc90006e3fc08 EFLAGS: 00010246
> > RAX: dffffc0000000000 RBX: ffff88801d4d4008 RCX: ffffffff86706be8
> > RDX: 0000000000000000 RSI: ffffffff86706c4d RDI: 0000000000000005
> > RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000000 R12: 1ffff92000dc7f85
> > R13: ffff88810f4bfb18 R14: ffff88801d4d10a8 R15: ffff88801d4d1000
> > FS:  00007fa0af71b640(0000) GS:ffff888063a00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000055d23050c460 CR3: 0000000022f5f000 CR4: 0000000000750ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > PKRU: 55555554
> > ----------------
> > Code disassembly (best guess):
> >    0:    02 00                    add    (%rax),%al
> >    2:    00 4c 8b 75              add    %cl,0x75(%rbx,%rcx,4)
> >    6:    40                       rex
> >    7:    4d 8d be 58 ff ff ff     lea    -0xa8(%r14),%r15
> >    e:    4c 89 ff                 mov    %r15,%rdi
> >   11:    e8 a4 20 fa ff           call   0xfffa20ba
> >   16:    48 89 c2                 mov    %rax,%rdx
> >   19:    48 89 c5                 mov    %rax,%rbp
> >   1c:    48 b8 00 00 00 00 00     movabs $0xdffffc0000000000,%rax
> >   23:    fc ff df
> >   26:    48 c1 ea 03              shr    $0x3,%rdx
> > * 2a:    80 3c 02 00              cmpb   $0x0,(%rdx,%rax,1) <--
> > trapping instruction
> >   2e:    0f 85 b0 02 00 00        jne    0x2e4
> >   34:    48 8b 45 00              mov    0x0(%rbp),%rax
> >   38:    48 8d bb 34 05 00 00     lea    0x534(%rbx),%rdi
> >   3f:    48                       rex.W
> > ```
> > We analyzed the root cause of this bug. When calling disable_store()
> > in drivers/usb/core/port.c, if function authorized_store() is calling
> > usb_deauthorized_device() concurrently, the usb_interface will be
> > removed by usb_disable_device. However, in function disable_store,
> > usb_hub_to_struct_hub() would try to deref interface, causing
> > nullptr-deref. We also tested other functions in
> > drivers/usb/core/port.c. So far we haven't found a similar problem.
> >
> > If you have any questions, please contact us.
> >
> > Reported by Yue Sun <samsun1006219@gmail.com>
> > Reported by xingwei lee <xrivendell7@gmail.com>
>
> Do you have a proposed patch to fix this as you have a way to easily
> test this?
>
> thanks,
>
> greg k-h

I am glad to help, but I am afraid I don't have a proposed patch
currently. This bug is a bit tricky, since the child device (usb port)
is trying to get its parent device (usb interface) while its
grandparent device (usb device) is trying to delete it (usb
interface). I need to further look into the locks to see which lock
should I grab to avoid deadlock or introducing other problems. I will
try my best but there is no guarantee. Hope someone who knows usb
subsystem better could fix this.

Best Regards,
Yue

