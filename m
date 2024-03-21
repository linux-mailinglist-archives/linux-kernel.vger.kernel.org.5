Return-Path: <linux-kernel+bounces-110123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 417F8885A59
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012762832FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED4A84FDA;
	Thu, 21 Mar 2024 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Btnx1njW"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DED84FB9;
	Thu, 21 Mar 2024 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711030042; cv=none; b=sKmf0mSw6hIdmrF1YR8vYrVdE5jNf9xK5ctvqyuXNpKiF+WPRU21qoEPDbQBCOGk3qut4qaZ0RHUxmrX1TNqytHt7VNtfqgQn1QPepNni5yHPSZjv4/sD6D33j0N5O2iygvFoDdTtzNJQqm69w3u+1rGz6y15OPz5/2oi8sHd14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711030042; c=relaxed/simple;
	bh=+x1p2BCF5x/R2SygN3e2sT/paMBh208q0/2pEd/Y3bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmoz7Ksueuv2stm1SXM5x3B3dpW9+A/F01isfMb9k+WJ2rsofSIyOY+nRLg4wHlIdNJRFJ24o8VFZncVZePlqaCkSM4gx90KtMda5U+si4J8iOf8ri0a0ebJ9QYcmzsdqJWUzcwDPd3bKQSeYxbDhthoIwzTAX0OktcEclg6S64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Btnx1njW; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-568a19fcc4eso571008a12.1;
        Thu, 21 Mar 2024 07:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711030039; x=1711634839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ja1aDmjd6UsI+q+1sGgJWsfucEQYXlIyp6OfFHZIuqU=;
        b=Btnx1njWX26/aEpTDkpYUu66xCGnXQGXSv3F2HrjQBosx7HaiYh692XSl4bi/Tmlw5
         1+KIRvFXDGMFzZq+iMn4h8S5+8MEFY8C1XaOzUwcOOvVxgsWj6n5+xoY+OLG7sKJEdqA
         C/g/7LDQR43vbkC1AeV0xtDaCEbInbHGcO5Hok1WRoWsksrmJwIJLg+MQbkPxCM1dBdm
         gyjVog4Uo+R7ZmHe51D8Qr2V0L/uFv7FyJrRKqDKW0XlUrYEj/GHCOXREngDqxPHJ2K+
         rWwCZ8ylC87LwR/h8cCTM0hgWWuEIaPgb7ycf4ooWsq6W4xKRpIsTlki8QMSMtuR6N+A
         5wCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711030039; x=1711634839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ja1aDmjd6UsI+q+1sGgJWsfucEQYXlIyp6OfFHZIuqU=;
        b=F4Xe/BxxU1vw8tWNNIB/fRnPgGBo/NhxeQS5ULr1GKjtIpyMLsR7rq3J0KSEX1yqdn
         t5TIlLzkJx69/82MKH2sLyNtnAzJqp8+cnDjBYBayEtVuPqSdZubbbJ4EnZ3+n34sMcu
         DPHkIfNPSZ3fv6tkilE2jfYyZJrcURpEriO7aqQUR6aOAMoJEGRpj0stukFZbmCr9kwh
         6nAXJisPy1cRpJSHcFD7H1oa2EeGBiAXBoXFsFngmWsQD8i8NJmQkCAZ30ubmdcPol97
         OFqnpj7OXpT2m5Z6TDKB2qwdoO2+MLz5jR0Gh9SBup59mCF6Y8IN7zXSIEMOtMuqZ75j
         fM+A==
X-Forwarded-Encrypted: i=1; AJvYcCXDqYUmIdZEbcYLyqqgTPsZSKvNpZJZVMs+D4d5Jek5b4xVISL1NcheD6yCqUahVuWCdjsr/mz2SkQdG4RAHQUCBNqCwM9merAvQ2gl2Use2/O0VAYjruaJU4ptDSGGzUSyWFY2ovSuc3W0EdfRcc91UZVSrPDlBH+l
X-Gm-Message-State: AOJu0YxxmK6gwBTuh+1O2Tm429eRjM1iOuQXR6YTsLElpcJIRN+QVV6B
	XCbmRrCxr3BcBm+wqjNNjyTqqwLge+5TIjeTmzPA/5Cl5+VQGH6MFpiCW4FaHMwSfMN8HRn7XAV
	LzYW4ppDJCG5TQGyoF53XoB38kxxVHMtS
X-Google-Smtp-Source: AGHT+IF3eR+hT26tVGfLiqdUhSzo2+XOSpyMx+j64Tdi+KC6/dLy6AZ3OpbuNAtSuWC4K7JVYwq7eGNeEho3noEFu2s=
X-Received: by 2002:a50:aace:0:b0:568:d19e:7ab0 with SMTP id
 r14-20020a50aace000000b00568d19e7ab0mr2243414edc.36.1711030038784; Thu, 21
 Mar 2024 07:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000003dc8e00614076ab6@google.com> <CAADnVQLORV5PT0iTAhRER+iLBTkByCYNBYyvBSgjN1T31K+gOw@mail.gmail.com>
In-Reply-To: <CAADnVQLORV5PT0iTAhRER+iLBTkByCYNBYyvBSgjN1T31K+gOw@mail.gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Thu, 21 Mar 2024 10:07:07 -0400
Message-ID: <CABWLsetWao1dd7mXJ2Gsq6JsPzkc=t3VRtAtreTSV03wGVUYCw@mail.gmail.com>
Subject: Re: stack access issue. Re: [syzbot] [bpf?] UBSAN:
 array-index-out-of-bounds in check_stack_range_initialized
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eddy Z <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the report! Will look in a bit.

On Thu, Mar 21, 2024 at 3:33=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Hi Andrei,
>
> looks like the refactoring of stack access introduced a bug.
> See the reproducer below.
> positive offsets are not caught by check_stack_access_within_bounds().
> So both slot and spi become negative and access
> stack[spi].slot_type[slot % BPF_REG_SIZE]
> returns garbage.
>
> On Tue, Mar 19, 2024 at 11:12=E2=80=AFAM syzbot
> <syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    0740b6427e90 Merge branch 'bpf-arena-followups'
> > git tree:       bpf
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D12fed769180=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6fb1be60a19=
3d440
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D33f4297b5f927=
648741a
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1763a4791=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15c38711180=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/c9e6e9f97566/d=
isk-0740b642.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/78476a588b62/vmli=
nux-0740b642.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/50cd6fab9ead=
/bzImage-0740b642.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > UBSAN: array-index-out-of-bounds in kernel/bpf/verifier.c:7190:12
> > index -1 is out of range for type 'u8[8]' (aka 'unsigned char[8]')
> > CPU: 0 PID: 5071 Comm: syz-executor474 Not tainted 6.8.0-syzkaller-0522=
6-g0740b6427e90 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 02/29/2024
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
> >  ubsan_epilogue lib/ubsan.c:217 [inline]
> >  __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:415
> >  check_stack_range_initialized+0x1668/0x19a0 kernel/bpf/verifier.c:7190
> >  check_helper_mem_access+0x2eb/0xfa0 kernel/bpf/verifier.c:7294
> >  check_helper_call+0x263c/0x7220 kernel/bpf/verifier.c:10252
> >  do_check+0x9e29/0x10530 kernel/bpf/verifier.c:17801
> >  do_check_common+0x14bd/0x1dd0 kernel/bpf/verifier.c:20500
> >  do_check_main kernel/bpf/verifier.c:20591 [inline]
> >  bpf_check+0x136ab/0x19010 kernel/bpf/verifier.c:21261
> >  bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2895
> >  __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5631
> >  __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
> >  __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
> >  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
> >  do_syscall_64+0xfb/0x240
> >  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> > RIP: 0033:0x7f8416194629
> > Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffdc6f0fdb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> > RAX: ffffffffffffffda RBX: 00007ffdc6f0ff88 RCX: 00007f8416194629
> > RDX: 0000000000000090 RSI: 00000000200000c0 RDI: 0000000000000005
> > RBP: 00007f8416207610 R08: 0000000000000000 R09: 00007ffdc6f0ff88
> > R10: 00000000fffffff8 R11: 0000000000000246 R12: 0000000000000001
> > R13: 00007ffdc6f0ff78 R14: 0000000000000001 R15: 0000000000000001
> >  </TASK>
> > ---[ end trace ]---
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

