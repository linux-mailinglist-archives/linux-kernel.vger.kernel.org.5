Return-Path: <linux-kernel+bounces-11692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EB081EA17
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 22:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A811F21788
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 21:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684594C9A;
	Tue, 26 Dec 2023 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jE9/99lP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE7046B4;
	Tue, 26 Dec 2023 21:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7b3708b3eacso214993639f.2;
        Tue, 26 Dec 2023 13:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703624902; x=1704229702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8JpUR1KvqrVpN4yiDt9knsP1sgUQTZLrieJHZmOJxs=;
        b=jE9/99lPS28066iG3WQpn3cKidRs1RwGUn3A/Q38awjhoKGJ5PMH9b28SoqXG9py/I
         7F29IO+YQc17XApNrneQ1UI2TETGnoVOpkQaW5uqVVsoLS4Cucgfy1+/pQEzK0ui+XPw
         reKEd3bmfDuz6LadolLykLoDiMrCkuBEMN5gw/CG1OpUK5+GH0RqyBkIfWXVPqdLpU6G
         spplyfc9XVTWP8OUZm2tjStep44obfkchOccry+/r90bslMvtuIabacE2zG6Rtw/vYsn
         nBizvssHpo9DUHaozdI8cmisD+qN8Fm1KFvZ8VpgZ1iUxvlDiGyZcrmjLh+KdaM26myd
         +L0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703624902; x=1704229702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8JpUR1KvqrVpN4yiDt9knsP1sgUQTZLrieJHZmOJxs=;
        b=UrJVK/mGU5z8JGA2v29Btv2zmeNAHGpjJEpIqRb6V3JCNps5bi00J1LGGhcbZZYcge
         D+c2uD3eWtkztJd3lywMdxODomz5V2v4k9GeGDkshdVGGU+HnxdPw12/Pd6evl/WyqCm
         I1qSwpug1v1TBs3BjqOe3hEMj0e9Y7K6/5VwNmFCwTAhwsIMo2e7BZWS7v1YDGZI5VSk
         c1NSSTYt28eXIXBCvbLyENxM33RMpNCndFLdBDT6VNiqTPXi56oq5GP+GjEVlnc300jZ
         ZxuV3pbm3uPedKL6M+p1j9jSb75RPQMYi2d8NCg3nFG5rsTNUWO0z2hPMy00Pvlkx9qC
         0KfQ==
X-Gm-Message-State: AOJu0YwU1kJmc3+nyfe2Fj16UTLSJ834BqRX7d8aUPNuNo9/hSIUI1u/
	8GFkVAKVomMEtqrbkiTjZdYNOqSLKBFYx3Wc4as=
X-Google-Smtp-Source: AGHT+IEqo1Aj+kgQ+A46fbBsvrnP8rtBfsPc7TmH8QkmflSsk9gjkUXpSYHvsH9dyH9qeGRk9LYe1w2L23zbrLu4ZIs=
X-Received: by 2002:a5d:8351:0:b0:7ba:d194:68dc with SMTP id
 q17-20020a5d8351000000b007bad19468dcmr3418948ior.18.1703624902086; Tue, 26
 Dec 2023 13:08:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000000b05cd060d6b5511@google.com>
In-Reply-To: <0000000000000b05cd060d6b5511@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 26 Dec 2023 13:08:11 -0800
Message-ID: <CAKEwX=OmWYivf7dg_izW8pn5s5q15+nx-vRMsV47T_qG=dep_Q@mail.gmail.com>
Subject: Re: [syzbot] [crypto?] general protection fault in
 scatterwalk_copychunks (5)
To: syzbot <syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, davem@davemloft.net, 
	herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yosryahmed@google.com, zhouchengming@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 7:28=E2=80=AFAM syzbot
<syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    39676dfe5233 Add linux-next specific files for 20231222
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D172080a1e8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df3761490b734d=
c96
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3eff5e51bf1db12=
2a16e
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D178f6e26e80=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15c399e9e8000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/360542c2ca67/dis=
k-39676dfe.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/900dfb21ca8a/vmlinu=
x-39676dfe.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c94a2a3ea0e0/b=
zImage-39676dfe.xz
>
> The issue was bisected to:
>
> commit 7bc134496bbbaacb0d4423b819da4eca850a839d
> Author: Chengming Zhou <zhouchengming@bytedance.com>
> Date:   Mon Dec 18 11:50:31 2023 +0000
>
>     mm/zswap: change dstmem size to one page
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D15f60c36e8=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D17f60c36e8=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D13f60c36e8000=
0
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com
> Fixes: 7bc134496bbb ("mm/zswap: change dstmem size to one page")
>
> general protection fault, probably for non-canonical address 0xdffffc0000=
000001: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> CPU: 0 PID: 5065 Comm: syz-executor140 Not tainted 6.7.0-rc6-next-2023122=
2-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 11/17/2023
> RIP: 0010:scatterwalk_start include/crypto/scatterwalk.h:63 [inline]
> RIP: 0010:scatterwalk_pagedone include/crypto/scatterwalk.h:83 [inline]
> RIP: 0010:scatterwalk_pagedone include/crypto/scatterwalk.h:72 [inline]
> RIP: 0010:scatterwalk_copychunks+0x3e0/0x560 crypto/scatterwalk.c:50
> Code: f0 48 c1 e8 03 80 3c 08 00 0f 85 81 01 00 00 49 8d 44 24 08 4d 89 2=
6 48 bf 00 00 00 00 00 fc ff df 48 89 44 24 10 48 c1 e8 03 <0f> b6 04 38 84=
 c0 74 08 3c 03 0f 8e 47 01 00 00 48 8b 44 24 08 41
> RSP: 0018:ffffc90003a8ecf0 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: 0000000000000000 RCX: dffffc0000000000
> RDX: ffff88802785d940 RSI: ffffffff8465df74 RDI: dffffc0000000000
> RBP: 0000000000001000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000002 R11: 82d8bd1b6060f805 R12: 0000000000000000
> R13: 0000000000000014 R14: ffffc90003a8ed88 R15: 0000000000001000
> FS:  00005555565c5380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000d5e538 CR3: 0000000079f3a000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  scatterwalk_map_and_copy+0x151/0x1d0 crypto/scatterwalk.c:67
>  scomp_acomp_comp_decomp+0x3a3/0x780 crypto/scompress.c:149

Looks like it's this line:

scatterwalk_map_and_copy(scratch->dst, req->dst, 0, req->dlen,1);

My guess is dlen here exceeds 1 page - maybe the data is
incompressible, so the output exceeds the original input? Based on the
included kernel config, the algorithm used here is lzo, and it seems
that can happen for this particular compressor:

https://github.com/nemequ/lzo/blob/master/doc/LZO.FAQ#L200C1-L203C1
https://github.com/nemequ/lzo/blob/master/doc/LZO.TXT#L157C2-L157C62

Not 100% sure about linux kernel's implementation though. I'm no
compression expert :)

If this is the case though, perhaps we can't reduce the output buffer
size to 1 page after all, unless we contractually obligate the output
size to be <=3D input size (i.e new function in the compression API).


>  crypto_acomp_compress include/crypto/acompress.h:302 [inline]
>  zswap_store+0x98b/0x2430 mm/zswap.c:1666
>  swap_writepage+0x8e/0x220 mm/page_io.c:198
>  pageout+0x399/0x9e0 mm/vmscan.c:656
>  shrink_folio_list+0x2f47/0x3ea0 mm/vmscan.c:1319
>  reclaim_folio_list+0xe4/0x3a0 mm/vmscan.c:2104
>  reclaim_pages+0x483/0x6a0 mm/vmscan.c:2140
>  madvise_cold_or_pageout_pte_range+0x129e/0x1f70 mm/madvise.c:526
>  walk_pmd_range mm/pagewalk.c:143 [inline]
>  walk_pud_range mm/pagewalk.c:221 [inline]
>  walk_p4d_range mm/pagewalk.c:256 [inline]
>  walk_pgd_range+0xa48/0x1870 mm/pagewalk.c:293
>  __walk_page_range+0x630/0x770 mm/pagewalk.c:395
>  walk_page_range+0x626/0xa80 mm/pagewalk.c:521
>  madvise_pageout_page_range mm/madvise.c:585 [inline]
>  madvise_pageout+0x32c/0x820 mm/madvise.c:612
>  madvise_vma_behavior+0x1cc/0x1b50 mm/madvise.c:1031
>  madvise_walk_vmas+0x1cf/0x2c0 mm/madvise.c:1260
>  do_madvise+0x333/0x660 mm/madvise.c:1440
>  __do_sys_madvise mm/madvise.c:1453 [inline]
>  __se_sys_madvise mm/madvise.c:1451 [inline]
>  __x64_sys_madvise+0xa9/0x110 mm/madvise.c:1451
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x62/0x6a
> RIP: 0033:0x7f15a5e14b69
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffde7b4a5c8 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f15a5e14b69
> RDX: 0000000000000015 RSI: 0000000000c00304 RDI: 0000000020000000
> RBP: 0000000000000000 R08: 00005555565c6610 R09: 00005555565c6610
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffde7b4a808 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:scatterwalk_start include/crypto/scatterwalk.h:63 [inline]
> RIP: 0010:scatterwalk_pagedone include/crypto/scatterwalk.h:83 [inline]
> RIP: 0010:scatterwalk_pagedone include/crypto/scatterwalk.h:72 [inline]
> RIP: 0010:scatterwalk_copychunks+0x3e0/0x560 crypto/scatterwalk.c:50
> Code: f0 48 c1 e8 03 80 3c 08 00 0f 85 81 01 00 00 49 8d 44 24 08 4d 89 2=
6 48 bf 00 00 00 00 00 fc ff df 48 89 44 24 10 48 c1 e8 03 <0f> b6 04 38 84=
 c0 74 08 3c 03 0f 8e 47 01 00 00 48 8b 44 24 08 41
> RSP: 0018:ffffc90003a8ecf0 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: 0000000000000000 RCX: dffffc0000000000
> RDX: ffff88802785d940 RSI: ffffffff8465df74 RDI: dffffc0000000000
> RBP: 0000000000001000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000002 R11: 82d8bd1b6060f805 R12: 0000000000000000
> R13: 0000000000000014 R14: ffffc90003a8ed88 R15: 0000000000001000
> FS:  00005555565c5380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000d5e538 CR3: 0000000079f3a000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess):
>    0:   f0 48 c1 e8 03          lock shr $0x3,%rax
>    5:   80 3c 08 00             cmpb   $0x0,(%rax,%rcx,1)
>    9:   0f 85 81 01 00 00       jne    0x190
>    f:   49 8d 44 24 08          lea    0x8(%r12),%rax
>   14:   4d 89 26                mov    %r12,(%r14)
>   17:   48 bf 00 00 00 00 00    movabs $0xdffffc0000000000,%rdi
>   1e:   fc ff df
>   21:   48 89 44 24 10          mov    %rax,0x10(%rsp)
>   26:   48 c1 e8 03             shr    $0x3,%rax
> * 2a:   0f b6 04 38             movzbl (%rax,%rdi,1),%eax <-- trapping in=
struction
>   2e:   84 c0                   test   %al,%al
>   30:   74 08                   je     0x3a
>   32:   3c 03                   cmp    $0x3,%al
>   34:   0f 8e 47 01 00 00       jle    0x181
>   3a:   48 8b 44 24 08          mov    0x8(%rsp),%rax
>   3f:   41                      rex.B
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
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

