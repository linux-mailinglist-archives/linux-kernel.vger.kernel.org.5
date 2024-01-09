Return-Path: <linux-kernel+bounces-21307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E26EC828D5A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72783B2162A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02B03D392;
	Tue,  9 Jan 2024 19:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbVwqtDr"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36733D384
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 19:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d4a980fdedso30294455ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 11:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704828398; x=1705433198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWGAvgNyPrCP6S8aBabx+ZENJ2NrYrg15XqP+XNv/GM=;
        b=FbVwqtDrvNVqibdGhc57SicrI2/BhrpqQAzYTdlNsfakfa2I1TiRhqa0z0H6H9+zMi
         rh7Rvn40BdJcM+jsY6YuzInkKyc2hmqL9PPlCR1utTFgYqzTupX33fQlbszFP4VqFUx3
         1hNGztlMx4nQmICbQvCQl380yA5MFbeEqXLBMqfOpYTkeVq7uVBwBRuf5898Om/Q9Zq8
         ij+6dvgoW21jmEortRvUp4/ejtBaXFWBkMpnJvvKy5+iHZgH9Z1St8wGEumPMcf7QU16
         Y8MArGNoYtOZdop/tl3Mr+CjStGXn0G3zKZuI2T6h5IvU6+oprsthwmxfgANgcgIpRrd
         YsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704828398; x=1705433198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWGAvgNyPrCP6S8aBabx+ZENJ2NrYrg15XqP+XNv/GM=;
        b=iRy2M04PUbVDPY+yssWy3EcMTG9draSCDKhzdoqp2A/qHuDxsmveHdcvxTaV/Cw5hO
         g1ajaUX+qSF08HSvTEqrYcr218sf4Gmzh2NrHXMu+hBqPNfy3Kkd90lNalJ/9ojV8Ysy
         WZlVZYLJkdtULo68SgH98ukJAs/VgT6YLp5C39tr8rYDWgg94hrNve823fb7Y7j0yVlv
         /jH+d2XEs1W/C7BrKccegvj86Xxsflg9I5t8g6yE+Bo9br/7BZtqGWtUjkw660pY3E4S
         cO4fSq6hQN0m7lE/9PsMOm1tjtetzPn8IosypqaCB864iMJHfigluqulxHYEP4dlZ534
         cXCQ==
X-Gm-Message-State: AOJu0YyvmS52Vjy713N1XLOsevOmugV3+zHjRT9zlxaZuiTTLG3Tphzg
	+IdGoRqEnD/2DDZvT2Q+qQoOQrjtcdQ1I6+CsWgqS/yc
X-Google-Smtp-Source: AGHT+IGeHWnACBI86ysZjUvBUzyhEWCqDealnC0YM7jsADwLVegpnk3Sp/z9+BbT2k8upokHBOlO8dskoIt66rfubcI=
X-Received: by 2002:a17:90a:4610:b0:28c:fa83:9222 with SMTP id
 w16-20020a17090a461000b0028cfa839222mr3474126pjg.21.1704828398093; Tue, 09
 Jan 2024 11:26:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000ef988f060e876862@google.com>
In-Reply-To: <000000000000ef988f060e876862@google.com>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 9 Jan 2024 11:26:26 -0800
Message-ID: <CAHbLzkoYJ9yr4pVKRbsSELmtwZm+CXNYMcpt--D4DFTogn30Eg@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in hpage_collapse_scan_pmd
To: syzbot <syzbot+ed79e0896ae923de13fa@syzkaller.appspotmail.com>, 
	Peter Xu <peterx@redhat.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 10:23=E2=80=AFAM syzbot
<syzbot+ed79e0896ae923de13fa@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    5eff55d725a4 Merge tag 'platform-drivers-x86-v6.7-7' of g=
i..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17472409e8000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D655f8abe9fe69=
b3b
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Ded79e0896ae923d=
e13fa
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/496bf4f0c628/dis=
k-5eff55d7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/43482bd7ec93/vmlinu=
x-5eff55d7.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/fa81d2743202/b=
zImage-5eff55d7.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+ed79e0896ae923de13fa@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 35 at arch/x86/include/asm/pgtable.h:403 pte_uffd_wp=
 arch/x86/include/asm/pgtable.h:403 [inline]
> WARNING: CPU: 1 PID: 35 at arch/x86/include/asm/pgtable.h:403 hpage_colla=
pse_scan_pmd+0x233e/0x4fe0 mm/khugepaged.c:1309
> Modules linked in:
> CPU: 1 PID: 35 Comm: khugepaged Not tainted 6.7.0-rc8-syzkaller-00055-g5e=
ff55d725a4 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 11/17/2023
> RIP: 0010:pte_uffd_wp arch/x86/include/asm/pgtable.h:403 [inline]

Khugepaged saw a uffd wp PTE is writable. Khugepaged just scans the
page table at this stage, so it sounds like something is out of sync?

Cc'ed Peter.

> RIP: 0010:hpage_collapse_scan_pmd+0x233e/0x4fe0 mm/khugepaged.c:1309
> Code: 24 d8 00 00 00 49 81 c6 00 10 00 00 4c 3b b4 24 f0 00 00 00 0f 83 a=
8 06 00 00 e8 bd 72 9d ff e9 61 fc ff ff e8 b3 72 9d ff 90 <0f> 0b 90 41 bc=
 09 00 00 00 45 31 f6 e9 45 f4 ff ff e8 9c 72 9d ff
> RSP: 0018:ffffc90000abf780 EFLAGS: 00010293
> RAX: ffffffff81f1073d RBX: 0000000000000002 RCX: ffff8880142f1dc0
> RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
> RBP: ffffc90000abfbf0 R08: ffffffff81f0ea47 R09: 1ffffd400022a006
> R10: dffffc0000000000 R11: fffff9400022a007 R12: 00000000203ea000
> R13: 1ffff92000157f14 R14: 00000000455eac67 R15: 00000000000001ea
> FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f942157a038 CR3: 000000008cd03000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  khugepaged_scan_mm_slot mm/khugepaged.c:2415 [inline]
>  khugepaged_do_scan mm/khugepaged.c:2503 [inline]
>  khugepaged+0x9bf/0x17a0 mm/khugepaged.c:2559
>  kthread+0x2d3/0x370 kernel/kthread.c:388
>  ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
>  </TASK>
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
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>

