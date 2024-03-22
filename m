Return-Path: <linux-kernel+bounces-112044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584C288748C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1634EB220D3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 21:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7612881203;
	Fri, 22 Mar 2024 21:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNeTCx/a"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA118060E;
	Fri, 22 Mar 2024 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711143888; cv=none; b=BWbAeEz0V7FzUNtGSFHUIGvw+h+/U7uzwhtZ56OyfUqam/u3aZ0+YjhG1ZfSqtPC/WIb41JerhRKW7xOCftPk7dqvSmoPnsF/YckXCkThUj7Z3M8GWsoy9EPSzIr2SvK+iVMlQDG3SzOypc5BAfU+6TSLCTMkPmTyOLi3EDBMlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711143888; c=relaxed/simple;
	bh=ugGFEBr1h8X4jf5cKW2qM0y6LopVw82/fyTHJk1ZHYQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K783Ip7s4l4jBxY6qZ9XCzL0pVmfHPafHVm525HIHy5X4pQD/YWpKHWc7s5HLaRxQoQp8oUAPTf/LfQWGAw2JDyF5CSIkV0FEkbLeFPedan76YMEZSDNNFo7zbeSlQiaMQY1ZtcXvc1pJbEdzETaB005xP200JEVmgsz8AlsDWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNeTCx/a; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56bb22ff7baso3049389a12.3;
        Fri, 22 Mar 2024 14:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711143885; x=1711748685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4JHNs5OFB27fj7rSvafXUk1wJbR44xuU9Je9Ud5YH8c=;
        b=QNeTCx/aBDOvumhWAVmIoUdVzA5WFPSsxDn2uUsloCjqG88geA0SKp0VwK/SbhN/gl
         HGZAvxoenMqEZ2/7sqjaxMfgXJN8tWEBT8tk2C/c9PuivL2e0LfCLFOqKpWP/G8PW1Eq
         PK3eaylfa3LIN01ppuIESCNJMg0I3CVRmODd2JLq9YzGaqB1d2fr+AALc9r9XU/jG+4M
         1/QikIjRUBH5ced2xjrYaQeGSckWh36BqoBujf2fw0piKR8OkxWuneXfejE9Wg42MBQG
         t+UFLuuhyCgAT7PDx9xUP8Fd5HHASRq0+qvyYiXmJra0Jl1pyuhJQq3WkOYUf97yWmP6
         xrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711143885; x=1711748685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JHNs5OFB27fj7rSvafXUk1wJbR44xuU9Je9Ud5YH8c=;
        b=NE4cgQEQMt6e+Q2pHIOuMaQkAtnysMMwLCPkUqECmXV+Ih/mVaud9mO4lH945PeNaV
         oNZC0PO4yk/RoIrjmBifu8s7jBQnHgvg/iWNRbOCLAObL4V72pQoVvhFrj1Qwd4LouBu
         8hKSCM2ca5DlTz8CLD/Ci5KpgYNFMK8iPFO2AQxescxQ+l24bDCba7jDYmrz+5fIz7zy
         F62j+OB6Y6jypVn9EiXyK/HVWkv3xIzr74bGvTOLHvgUHbK9FQE2kEdTeoggcJ1ilk3h
         zvsN3FFVXam7REV49VqO/LJLu9qSSTQqM88ESJAS6e6wBq2jO92bKgcCvFriEZTyq7O3
         /KKg==
X-Forwarded-Encrypted: i=1; AJvYcCVJkZBwRKNlnobGWy3bxygHb9A2SvzOHETX/4UvuR0DFWzcP7cq7qHoTUvV+ksWvnsyUeDYbvEGgmKNZzn7TwMlRWao/EJp3W8ELQljpKw3B13xFiOtN10+6ZsR9En4kRqVS6wHEDp1H0AAeotFJidTFAlPfL/JGNDv
X-Gm-Message-State: AOJu0Yx1AP/XAIahVAtWKY5aIzDD7mi7kPU2f8xYtthxP4BQ349Zt/5d
	ew33NbLdGFXf88nOQMV/niKP1E8pUGnVZqqQI2ytHPc1seF4yv35
X-Google-Smtp-Source: AGHT+IHHfm2exzge9OHBaJP+4gXyGsGrgBXF0HlY/6kGnHo6/Q7weSYuEJSWRf9fZrZF+EfmeL5iEQ==
X-Received: by 2002:a50:931e:0:b0:565:7ce5:abdc with SMTP id m30-20020a50931e000000b005657ce5abdcmr522312eda.10.1711143884566;
        Fri, 22 Mar 2024 14:44:44 -0700 (PDT)
Received: from krava ([83.240.62.66])
        by smtp.gmail.com with ESMTPSA id g7-20020a056402320700b00568ba57983csm249064eda.0.2024.03.22.14.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 14:44:44 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 22 Mar 2024 22:44:42 +0100
To: syzbot <syzbot+ba82760c63ba37799f70@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
	john.fastabend@gmail.com, kpsingh@kernel.org,
	linux-kernel@vger.kernel.org, martin.lau@linux.dev,
	netdev@vger.kernel.org, sdf@google.com, song@kernel.org,
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] general protection fault in bpf_check (2)
Message-ID: <Zf37ygebFR6JCEci@krava>
References: <0000000000007628d60614449e5d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007628d60614449e5d@google.com>

On Fri, Mar 22, 2024 at 12:13:29PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ddb2ffdc474a libbpf: Define MFD_CLOEXEC if not available
> git tree:       bpf
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=14ba06a5180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
> dashboard link: https://syzkaller.appspot.com/bug?extid=ba82760c63ba37799f70
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115671f1180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f14e31180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1e40c56954a9/disk-ddb2ffdc.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/738240a7f62b/vmlinux-ddb2ffdc.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2b2e360f1d3a/bzImage-ddb2ffdc.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ba82760c63ba37799f70@syzkaller.appspotmail.com
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
> CPU: 1 PID: 5066 Comm: syz-executor115 Not tainted 6.8.0-syzkaller-05232-gddb2ffdc474a #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
> RIP: 0010:do_misc_fixups kernel/bpf/verifier.c:19609 [inline]
> RIP: 0010:bpf_check+0xa19b/0x19010 kernel/bpf/verifier.c:21294
> Code: 48 c1 e8 03 80 3c 08 00 74 12 48 89 df e8 2d 93 50 00 48 b9 00 00 00 00 00 fc ff df 48 8b 1b 48 83 c3 30 48 89 d8 48 c1 e8 03 <0f> b6 04 08 84 c0 0f 85 e3 4c 00 00 8b 1b be 00 00 04 00 21 de 31
> RSP: 0018:ffffc900039671e0 EFLAGS: 00010206
> RAX: 0000000000000006 RBX: 0000000000000030 RCX: dffffc0000000000
> RDX: ffff888018358000 RSI: 0000000000010000 RDI: 0000000000000001
> RBP: ffffc90003967b50 R08: ffffffff81a7a128 R09: ffffffff81a7a365
> R10: 0000000000000004 R11: ffff888018358000 R12: ffffc90000ace072
> R13: 1ffff92000159c0e R14: 1ffff92000159c0e R15: 0000000000010000
> FS:  000055555905c380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000111ed398 CR3: 000000002258e000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2895
>  __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5631
>  __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75

looks like we might have a fix already:
  https://lore.kernel.org/bpf/20240322153518.11555-1-puranjay12@gmail.com/T/#u

jirka

> RIP: 0033:0x7f425974e3e9
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe73dd9d38 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007ffe73dd9f18 RCX: 00007f425974e3e9
> RDX: 0000000000000090 RSI: 00000000200000c0 RDI: 0000000000000005
> RBP: 00007f42597c1610 R08: 0000000000000000 R09: 0000000000000000
> R10: 00000000ffffffff R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffe73dd9f08 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:do_misc_fixups kernel/bpf/verifier.c:19609 [inline]
> RIP: 0010:bpf_check+0xa19b/0x19010 kernel/bpf/verifier.c:21294
> Code: 48 c1 e8 03 80 3c 08 00 74 12 48 89 df e8 2d 93 50 00 48 b9 00 00 00 00 00 fc ff df 48 8b 1b 48 83 c3 30 48 89 d8 48 c1 e8 03 <0f> b6 04 08 84 c0 0f 85 e3 4c 00 00 8b 1b be 00 00 04 00 21 de 31
> RSP: 0018:ffffc900039671e0 EFLAGS: 00010206
> RAX: 0000000000000006 RBX: 0000000000000030 RCX: dffffc0000000000
> RDX: ffff888018358000 RSI: 0000000000010000 RDI: 0000000000000001
> RBP: ffffc90003967b50 R08: ffffffff81a7a128 R09: ffffffff81a7a365
> R10: 0000000000000004 R11: ffff888018358000 R12: ffffc90000ace072
> R13: 1ffff92000159c0e R14: 1ffff92000159c0e R15: 0000000000010000
> FS:  000055555905c380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000111ed398 CR3: 000000002258e000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:	48 c1 e8 03          	shr    $0x3,%rax
>    4:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1)
>    8:	74 12                	je     0x1c
>    a:	48 89 df             	mov    %rbx,%rdi
>    d:	e8 2d 93 50 00       	call   0x50933f
>   12:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
>   19:	fc ff df
>   1c:	48 8b 1b             	mov    (%rbx),%rbx
>   1f:	48 83 c3 30          	add    $0x30,%rbx
>   23:	48 89 d8             	mov    %rbx,%rax
>   26:	48 c1 e8 03          	shr    $0x3,%rax
> * 2a:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax <-- trapping instruction
>   2e:	84 c0                	test   %al,%al
>   30:	0f 85 e3 4c 00 00    	jne    0x4d19
>   36:	8b 1b                	mov    (%rbx),%ebx
>   38:	be 00 00 04 00       	mov    $0x40000,%esi
>   3d:	21 de                	and    %ebx,%esi
>   3f:	31                   	.byte 0x31
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
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
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

