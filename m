Return-Path: <linux-kernel+bounces-23886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8922782B334
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AAA6281739
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4C951C33;
	Thu, 11 Jan 2024 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z1b8m/0L"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D404351C26
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5edfcba97e3so58958757b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704991488; x=1705596288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqCfJKVnzYOxG2W88wJSdSwu90FlSnY04BWB8Fc/moE=;
        b=z1b8m/0LUDkPYeDrnFl1WuxMomuqOfGUHIQCaGO8dApuwBt/5uoSys+NkKwFQuk2cf
         q3RsZpVNDeoKUmclC30X+gmlYHNWrLz2kP3A089UNLbuitMtxCkugMaY05jeoXjwlgqX
         4JYH0MY8v/BExamdLXicbI7K8JdTl8j6FKEk8J3gaZ5IDVbAAKichrAU/9lcDvDeoU/O
         tmRSd16HbPQEYvwXgCWE0A8sYgEotQTYRYe8tgxjrmJa1/yzi2CyXECacewcp9kmHGlI
         qUClkqKWHehEU0l4xQiCmdCzMmoQEyH/RNOBCpLoSb0arR2VsZjOanLdry0iWVBWlsIV
         gsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704991488; x=1705596288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqCfJKVnzYOxG2W88wJSdSwu90FlSnY04BWB8Fc/moE=;
        b=rMBzjFl2w6sKrTNUsdX2yzIBdqq0oif+2iaFMRSeRJRFSQdJ4yBkKncrl1U1zNjX+a
         wnIbfpWkDOToxuz2ZAM7rk6yVuA9F6s1o12+dzMsDRcPPMjTj8wsp6+/cOOaAEKGp2iT
         ZGEIfkvGvdRiFN4BlpMsDOkIlgM3QO4traW8W7GWC+P1mgZhYXib6lWJW+ktF9P6LZV6
         7ONdiPlkQ3WiMB8/LHrQAKAtrCBiQGVEMM7Ag7TPPtrrDoZBeR/qS6tXcvjf6qJZ31l7
         b7GkB6aNxBNea3/XB82dC5uwQmoDWftbQWmJ1dKvkWrXWfa4tWGRV1IF+0sh8kxfWtFZ
         aU4A==
X-Gm-Message-State: AOJu0YxvmvJZSWilIoHRdMDsJpGl90cDAI7+6JekClgbCiurjVBstbry
	2/07m054jQVlRZW6k1h3YyK/F7MfIVAGOl0keXcmysOWq+x9
X-Google-Smtp-Source: AGHT+IEEODxNnZbMQN79g4/NkDdx5hVmjij5bKUchNGvVrgR5+KyH/omPGLQzUee/8yX2sbuwYKmPaw3Dg/wdz5GtgA=
X-Received: by 2002:a81:ef0e:0:b0:5ed:7d36:7963 with SMTP id
 o14-20020a81ef0e000000b005ed7d367963mr66952ywm.6.1704991487369; Thu, 11 Jan
 2024 08:44:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000011d709060eadffd3@google.com> <CAJuCfpG-8w_KQ8bWvSr=GrXM+Jx3YKn5DqTFJU2MaMojML_a-A@mail.gmail.com>
In-Reply-To: <CAJuCfpG-8w_KQ8bWvSr=GrXM+Jx3YKn5DqTFJU2MaMojML_a-A@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 11 Jan 2024 08:44:36 -0800
Message-ID: <CAJuCfpFfKYn+G1+puQ0KxzWCnbfFT51tKwV8MnrP7YZcJAORwg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in move_pages
To: syzbot <syzbot+705209281e36404998f6@syzkaller.appspotmail.com>
Cc: aarcange@redhat.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 8:40=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Jan 11, 2024 at 8:25=E2=80=AFAM syzbot
> <syzbot+705209281e36404998f6@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    e2425464bc87 Add linux-next specific files for 20240105
> > git tree:       linux-next
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D14941cdee80=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4056b9349f3=
da8c9
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D705209281e364=
04998f6
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D125d0a09e=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15bc7331e80=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/2f738185e2cf/d=
isk-e2425464.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/b248fcf4ea46/vmli=
nux-e2425464.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/a9945c8223f4=
/bzImage-e2425464.xz
> >
> > The issue was bisected to:
> >
> > commit adef440691bab824e39c1b17382322d195e1fab0
> > Author: Andrea Arcangeli <aarcange@redhat.com>
> > Date:   Wed Dec 6 10:36:56 2023 +0000
> >
> >     userfaultfd: UFFDIO_MOVE uABI
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D11cb6ea9=
e80000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D13cb6ea9=
e80000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D15cb6ea9e80=
000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+705209281e36404998f6@syzkaller.appspotmail.com
> > Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> >
> >  do_one_initcall+0x128/0x680 init/main.c:1237
> >  do_initcall_level init/main.c:1299 [inline]
> >  do_initcalls init/main.c:1315 [inline]
> >  do_basic_setup init/main.c:1334 [inline]
> >  kernel_init_freeable+0x692/0xc30 init/main.c:1552
> >  kernel_init+0x1c/0x2a0 init/main.c:1442
> >  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> > ------------[ cut here ]------------
> > kernel BUG at include/linux/page-flags.h:1035!
> > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 0 PID: 5068 Comm: syz-executor191 Not tainted 6.7.0-rc8-next-20240=
105-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 11/17/2023
> > RIP: 0010:PageAnonExclusive include/linux/page-flags.h:1035 [inline]
>
> From a quick look, I think the new ioctl is being used against a
> file-backed page and that's why PageAnonExclusive() throws this error.
> I'll confirm if this is indeed the case and will add checks for that
> case. Thanks!

Hmm. Looking at the reproducer it does not look like a file-backed
memory... Anyways, I'm on it.

>
> > RIP: 0010:move_pages+0x1697/0x3d40 mm/userfaultfd.c:1402
> > Code: 00 00 48 c1 e8 0c 48 21 d0 48 c1 e0 06 48 01 c3 e9 b6 f7 ff ff e8=
 79 c6 9c ff 48 c7 c6 e0 7e dc 8a 48 89 df e8 0a 20 dc ff 90 <0f> 0b e8 62 =
c6 9c ff 48 89 da b8 ff ff 37 00 48 c1 ea 03 48 c1 e0
> > RSP: 0018:ffffc90003aefa98 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: ffffea0001e40000 RCX: ffffffff81687599
> > RDX: ffff88802a155940 RSI: ffffffff81eb5d46 RDI: 0000000000000000
> > RBP: ffff88802abab810 R08: 0000000000000000 R09: fffffbfff1e75fda
> > R10: ffffffff8f3afed7 R11: 0000000000000001 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000020518000 R15: 0000000000000000
> > FS:  00005555562cf380(0000) GS:ffff8880b9800000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00000000204f8000 CR3: 000000006a725000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  userfaultfd_move fs/userfaultfd.c:2047 [inline]
> >  userfaultfd_ioctl+0x683/0x6420 fs/userfaultfd.c:2169
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:871 [inline]
> >  __se_sys_ioctl fs/ioctl.c:857 [inline]
> >  __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xd0/0x250 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x62/0x6a
> > RIP: 0033:0x7f4bada9b3e9
> > Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fff2c1d6998 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007fff2c1d6b68 RCX: 00007f4bada9b3e9
> > RDX: 00000000200000c0 RSI: 00000000c028aa05 RDI: 0000000000000003
> > RBP: 00007f4badb0e610 R08: 00007fff2c1d6b68 R09: 00007fff2c1d6b68
> > R10: 00007fff2c1d6b68 R11: 0000000000000246 R12: 0000000000000001
> > R13: 00007fff2c1d6b58 R14: 0000000000000001 R15: 0000000000000001
> >  </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> > RIP: 0010:PageAnonExclusive include/linux/page-flags.h:1035 [inline]
> > RIP: 0010:move_pages+0x1697/0x3d40 mm/userfaultfd.c:1402
> > Code: 00 00 48 c1 e8 0c 48 21 d0 48 c1 e0 06 48 01 c3 e9 b6 f7 ff ff e8=
 79 c6 9c ff 48 c7 c6 e0 7e dc 8a 48 89 df e8 0a 20 dc ff 90 <0f> 0b e8 62 =
c6 9c ff 48 89 da b8 ff ff 37 00 48 c1 ea 03 48 c1 e0
> > RSP: 0018:ffffc90003aefa98 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: ffffea0001e40000 RCX: ffffffff81687599
> > RDX: ffff88802a155940 RSI: ffffffff81eb5d46 RDI: 0000000000000000
> > RBP: ffff88802abab810 R08: 0000000000000000 R09: fffffbfff1e75fda
> > R10: ffffffff8f3afed7 R11: 0000000000000001 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000020518000 R15: 0000000000000000
> > FS:  00005555562cf380(0000) GS:ffff8880b9800000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00000000204f8000 CR3: 000000006a725000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > For information about bisection process see: https://goo.gl/tpsmEJ#bise=
ction
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing=
.
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

