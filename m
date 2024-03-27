Return-Path: <linux-kernel+bounces-121489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F30188E8E4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D841C3024B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD24B12E1FE;
	Wed, 27 Mar 2024 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUH9C+8L"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDE43A28B;
	Wed, 27 Mar 2024 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552810; cv=none; b=kTrf/ruxswuFsWOK6vKSzkIOsnSlOEBEWmZNEfXpOinT6e47RPhgZLTt37cIkmSoqAViiJekScXAw8QHjU5VLBdscgtXLvfQ+cbhCrhocl/mVxvLXbMPjaFugsSB81vY/iiwTOlHQEyvu8PNBApug6hXjqJZbg6qSp6vw7eBZ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552810; c=relaxed/simple;
	bh=AGB35Fob2y5UQt4B0th7Kiu3sbhYIiNFab3gZ3YruNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+wMxeIKTJ/PDT3/UYa4OmouJ8gBlGpIZ5Ott7FoQEOd2g6W+++RODlww9fkiElJ4wxGDFl2x5nKTuXV2ntoMl3dXLMDYmTjqkEaxOuMLpY6JaJkFyYmyuDJXebt5z8VL85/LOTKNml5BDno7kTn1L9J5ybMs2/8RagmKzYJSJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUH9C+8L; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4149749cc36so2364245e9.0;
        Wed, 27 Mar 2024 08:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711552805; x=1712157605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eb4ZlIHwFzNSo4XEEI4kSHnkSklEZQmdWPWfzTXDpFk=;
        b=FUH9C+8LBK+siUCqp26jKs6UzW3JCzpDj9HgWZVRXIO4GeIwBez3IP324g169pJZ7c
         S8R3tXx0GUEppQpO/tqmbZhPDss/JLysDUIu8iWM5sXnMepWSFGr3vOZQ9oTJP31/REX
         nJXH3Y2A2tfkzQDw7GjUR7x3NGhWDkLRXqIRlvtd1x2LPQUnJAt4d9MEwj3BgchA4hrM
         NfHWobCkmvmbO3R+SJQB6UX2c40l9MS6IqVENkF67xEiF5YArpP4FTrEnKOciWR8Ds34
         XhJpPjX79r+DO9unmtU0Nk91g7fuAF+l9z17drHFuurnbEb7LgNn51NSZTwtGQ+66qzp
         mSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711552805; x=1712157605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eb4ZlIHwFzNSo4XEEI4kSHnkSklEZQmdWPWfzTXDpFk=;
        b=rDiiC/U/ZAdBFZ9r5iUaww6QylzxDMbWhSWPzdcNofujJhSDgUsFqzaED6jlngZMgb
         LGg367BqLl1KrSTKOLOwfwu3yIVikhl8g2sHZ+bYXpyhdzi4e5adOJs1FshTpQwQdfVs
         RpfADBGNWf2s/mXqUfQz2bONwemHd1Tz0eJ2B8MvbrfkeGJug/qn9Xls/MlSUNjLzFFw
         Od18cbxRrBH36glniUhaJpdHaNUMYGnoQUEG8aMva9Lne+7YhIJeWrTHjOALAZ9mFO+T
         EBj6C8wLknorTvR+j3mte+D34KErUuq7yFDg1QGAg+1bwBYwlQXODN0faktTMi9n/If4
         hDiA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ4ipLQ2kgyTADlSGJCYC2YK2AiZhAD8NmCaNdFqLJTsXeMaOEdTXs+9LXZORERk8LFhi9SMvsXBmvTMKQOahxQEfhJRVJOpMa9v5ODxNPq/pFcOCc5CGlhpuYvNycdzQFqIBY5TweRDnGzw9uABv186k6bgFdDwm7
X-Gm-Message-State: AOJu0Yw2s0Ho9s+7RlcMAMSqTH72U72JNLgIbXRWuoDVqA5AGZW/QKJN
	MyBJNWJ3vRuOSVA5Sy6J5NZAK4lhYzLYXhX+TR/9UZjs4zHdsqFE57Dk97HRMWRl9XtiMwIBdD+
	nDZ/W0VaoRQRDLfITE6B7toj5rWw=
X-Google-Smtp-Source: AGHT+IGrazYcWWtMjkDSZxv9LDncYBgQMoVg+p+/F/y3qeG444ccoI5fBYKA8jZew1ly0agNjobWNV3csS0RvCqQCoA=
X-Received: by 2002:adf:e849:0:b0:341:e0fd:4dec with SMTP id
 d9-20020adfe849000000b00341e0fd4decmr187632wrn.6.1711552804380; Wed, 27 Mar
 2024 08:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000f6531b061494e696@google.com> <00000000000069ee1a06149ff00c@google.com>
In-Reply-To: <00000000000069ee1a06149ff00c@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Mar 2024 08:19:52 -0700
Message-ID: <CAADnVQLpJwEfLoF9ORc7bSsDPG7Y05mWUpWWyfi7qjY+2LhC+Q@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in dev_map_enqueue
To: syzbot <syzbot+af9492708df9797198d6@syzkaller.appspotmail.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Toke, Jesper,

please take a look.
It's reproducible 100% of the time.
dst is NULL in dev_map_enqueue().

Thanks

On Wed, Mar 27, 2024 at 1:10=E2=80=AFAM syzbot
<syzbot+af9492708df9797198d6@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    443574b03387 riscv, bpf: Fix kfunc parameters incompatibi=
l..
> git tree:       bpf
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D17d370b118000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6fb1be60a193d=
440
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Daf9492708df9797=
198d6
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D13d6b041180=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1060cc8118000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3f355021a085/dis=
k-443574b0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/44cf4de7472a/vmlinu=
x-443574b0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a99a36c7ad65/b=
zImage-443574b0.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+af9492708df9797198d6@syzkaller.appspotmail.com
>
> general protection fault, probably for non-canonical address 0xdffffc0000=
000000: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 1 PID: 5078 Comm: syz-executor295 Not tainted 6.8.0-syzkaller-05236-=
g443574b03387 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 02/29/2024
> RIP: 0010:dev_map_enqueue+0x31/0x3e0 kernel/bpf/devmap.c:539
> Code: 41 56 41 55 41 54 53 48 83 ec 18 49 89 d4 49 89 f5 48 89 fd 49 be 0=
0 00 00 00 00 fc ff df e8 a6 42 d8 ff 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00=
 74 08 48 89 ef e8 10 8a 3b 00 4c 8b 7d 00 48 83 c5
> RSP: 0018:ffffc90003bef688 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888022169e00
> RDX: 0000000000000000 RSI: ffff88802ef65070 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000005 R09: ffffffff894ff90e
> R10: 0000000000000004 R11: ffff888022169e00 R12: ffff888015bd0000
> R13: ffff88802ef65070 R14: dffffc0000000000 R15: ffff8880b953c088
> FS:  000055558e3b9380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f1141b380d0 CR3: 0000000021838000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __xdp_do_redirect_frame net/core/filter.c:4384 [inline]
>  xdp_do_redirect_frame+0x20d/0x4d0 net/core/filter.c:4438
>  xdp_test_run_batch net/bpf/test_run.c:336 [inline]
>  bpf_test_run_xdp_live+0xe8a/0x1e90 net/bpf/test_run.c:384
>  bpf_prog_test_run_xdp+0x813/0x11b0 net/bpf/test_run.c:1267
>  bpf_prog_test_run+0x33a/0x3b0 kernel/bpf/syscall.c:4240
>  __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5649
>  __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> RIP: 0033:0x7f1141ac0fb9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe180a1958 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1141ac0fb9
> RDX: 0000000000000048 RSI: 0000000020000340 RDI: 000000000000000a
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000006
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:dev_map_enqueue+0x31/0x3e0 kernel/bpf/devmap.c:539
> Code: 41 56 41 55 41 54 53 48 83 ec 18 49 89 d4 49 89 f5 48 89 fd 49 be 0=
0 00 00 00 00 fc ff df e8 a6 42 d8 ff 48 89 e8 48 c1 e8 03 <42> 80 3c 30 00=
 74 08 48 89 ef e8 10 8a 3b 00 4c 8b 7d 00 48 83 c5
> RSP: 0018:ffffc90003bef688 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff888022169e00
> RDX: 0000000000000000 RSI: ffff88802ef65070 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000005 R09: ffffffff894ff90e
> R10: 0000000000000004 R11: ffff888022169e00 R12: ffff888015bd0000
> R13: ffff88802ef65070 R14: dffffc0000000000 R15: ffff8880b953c088
> FS:  000055558e3b9380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f1141b380d0 CR3: 0000000021838000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:   41 56                   push   %r14
>    2:   41 55                   push   %r13
>    4:   41 54                   push   %r12
>    6:   53                      push   %rbx
>    7:   48 83 ec 18             sub    $0x18,%rsp
>    b:   49 89 d4                mov    %rdx,%r12
>    e:   49 89 f5                mov    %rsi,%r13
>   11:   48 89 fd                mov    %rdi,%rbp
>   14:   49 be 00 00 00 00 00    movabs $0xdffffc0000000000,%r14
>   1b:   fc ff df
>   1e:   e8 a6 42 d8 ff          call   0xffd842c9
>   23:   48 89 e8                mov    %rbp,%rax
>   26:   48 c1 e8 03             shr    $0x3,%rax
> * 2a:   42 80 3c 30 00          cmpb   $0x0,(%rax,%r14,1) <-- trapping in=
struction
>   2f:   74 08                   je     0x39
>   31:   48 89 ef                mov    %rbp,%rdi
>   34:   e8 10 8a 3b 00          call   0x3b8a49
>   39:   4c 8b 7d 00             mov    0x0(%rbp),%r15
>   3d:   48                      rex.W
>   3e:   83                      .byte 0x83
>   3f:   c5                      .byte 0xc5
>
>
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

