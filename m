Return-Path: <linux-kernel+bounces-23351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BBB82AB76
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30281F26464
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6462912E7E;
	Thu, 11 Jan 2024 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bamg0vD7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EDD12E59
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704967218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yxh7OAtpXjhWhrb5Lb4IVy5zJU0ZbS4Z/SE7rEMRqfA=;
	b=Bamg0vD7eqzhAT+RbJNDg2tpvHLq35cSNh6VP5F5UPDbFAJ2GQ5Ik0wnNIVEoXPhoeaYeI
	hdMYbu/WN36uVbvsclQXiazTJweZRYaEUtESGHGg0d4PSCTwgAPDuj0HizZ/n8mxkU6yBa
	DF9gge+nM5ColDYIQ8gA6zHlj7O/5XE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-xf6NBpTYPLqyPyZVyz7EQw-1; Thu, 11 Jan 2024 05:00:11 -0500
X-MC-Unique: xf6NBpTYPLqyPyZVyz7EQw-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1d44a50ab19so11355235ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 02:00:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704967210; x=1705572010;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yxh7OAtpXjhWhrb5Lb4IVy5zJU0ZbS4Z/SE7rEMRqfA=;
        b=wp6rjjWU/SODnl4Ijd3DZO7Fknk5hawI73D7OKF1Dvfs58ZVAWuTJReABLHzGmoFSi
         3V/Lbp7hSOREbo/FtwLlpxNVKpFgt604R6RmN5iKXlU/jFafxwyLq5UJ8qLz0sQ5VMw6
         sLt0yVWTiKlWVnu8wwZeVh6X28s8CdY8nlbTL9zQsBGRKwuzpv3GjiptDGyN7oTT4U82
         n/vqehmR1y3S+GQTg7VF/60CoNGFmXF+t8Ciim2e93ud0TZO2DUacGnPzs4515JPkbMn
         g0VHE7N8r9YxW7jJq2pbBLGuiICYAxw9CrQ2fHhCtd3fz1irtLKxVPk2RL5hGfasW5uO
         2O+A==
X-Gm-Message-State: AOJu0YxF+BVq55LZnyOp7uJjEBs+xVAD83eo6/1o+zPXmHbON+wKonnH
	FlA9heYW1teOMjroXlyJIROUJKtKlUboGnUYEHcne2y3U69b7FsIwZa0aA2DQcB5dWLj4cMbJMO
	/U4lJfmK5fB6P6yLy7v+602mjCWEmDFrd
X-Received: by 2002:a05:6a20:96c2:b0:19a:49c8:b9e6 with SMTP id hq2-20020a056a2096c200b0019a49c8b9e6mr1301364pzc.0.1704967210613;
        Thu, 11 Jan 2024 02:00:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHApU70VEHsEtSfmXf84B0tjCpY8EWYVBKF1g3uQ4+rdeDHHv3WtZTs0yUU9WjGyRM0uf6cTQ==
X-Received: by 2002:a05:6a20:96c2:b0:19a:49c8:b9e6 with SMTP id hq2-20020a056a2096c200b0019a49c8b9e6mr1301325pzc.0.1704967209886;
        Thu, 11 Jan 2024 02:00:09 -0800 (PST)
Received: from x1n ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id sw7-20020a17090b2c8700b0028c89122f8asm1012284pjb.6.2024.01.11.02.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 02:00:09 -0800 (PST)
Date: Thu, 11 Jan 2024 18:00:03 +0800
From: Peter Xu <peterx@redhat.com>
To: Yang Shi <shy828301@gmail.com>
Cc: syzbot <syzbot+ed79e0896ae923de13fa@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] WARNING in hpage_collapse_scan_pmd
Message-ID: <ZZ-8I6UVvYNkzk-U@x1n>
References: <000000000000ef988f060e876862@google.com>
 <CAHbLzkoYJ9yr4pVKRbsSELmtwZm+CXNYMcpt--D4DFTogn30Eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHbLzkoYJ9yr4pVKRbsSELmtwZm+CXNYMcpt--D4DFTogn30Eg@mail.gmail.com>

On Tue, Jan 09, 2024 at 11:26:26AM -0800, Yang Shi wrote:
> On Tue, Jan 9, 2024 at 10:23 AM syzbot
> <syzbot+ed79e0896ae923de13fa@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    5eff55d725a4 Merge tag 'platform-drivers-x86-v6.7-7' of gi..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17472409e80000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=655f8abe9fe69b3b
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ed79e0896ae923de13fa
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/496bf4f0c628/disk-5eff55d7.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/43482bd7ec93/vmlinux-5eff55d7.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/fa81d2743202/bzImage-5eff55d7.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+ed79e0896ae923de13fa@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 35 at arch/x86/include/asm/pgtable.h:403 pte_uffd_wp arch/x86/include/asm/pgtable.h:403 [inline]
> > WARNING: CPU: 1 PID: 35 at arch/x86/include/asm/pgtable.h:403 hpage_collapse_scan_pmd+0x233e/0x4fe0 mm/khugepaged.c:1309
> > Modules linked in:
> > CPU: 1 PID: 35 Comm: khugepaged Not tainted 6.7.0-rc8-syzkaller-00055-g5eff55d725a4 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
> > RIP: 0010:pte_uffd_wp arch/x86/include/asm/pgtable.h:403 [inline]
> 
> Khugepaged saw a uffd wp PTE is writable. Khugepaged just scans the
> page table at this stage, so it sounds like something is out of sync?
> 
> Cc'ed Peter.

Thanks for copying me, Yang.

Currently I have no clue of what is going wrong.  I'll need to have a
closer look some day later on the rest logs, or wait for a reproducer with
some more information.

> 
> > RIP: 0010:hpage_collapse_scan_pmd+0x233e/0x4fe0 mm/khugepaged.c:1309
> > Code: 24 d8 00 00 00 49 81 c6 00 10 00 00 4c 3b b4 24 f0 00 00 00 0f 83 a8 06 00 00 e8 bd 72 9d ff e9 61 fc ff ff e8 b3 72 9d ff 90 <0f> 0b 90 41 bc 09 00 00 00 45 31 f6 e9 45 f4 ff ff e8 9c 72 9d ff
> > RSP: 0018:ffffc90000abf780 EFLAGS: 00010293
> > RAX: ffffffff81f1073d RBX: 0000000000000002 RCX: ffff8880142f1dc0
> > RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
> > RBP: ffffc90000abfbf0 R08: ffffffff81f0ea47 R09: 1ffffd400022a006
> > R10: dffffc0000000000 R11: fffff9400022a007 R12: 00000000203ea000
> > R13: 1ffff92000157f14 R14: 00000000455eac67 R15: 00000000000001ea
> > FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f942157a038 CR3: 000000008cd03000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  khugepaged_scan_mm_slot mm/khugepaged.c:2415 [inline]
> >  khugepaged_do_scan mm/khugepaged.c:2503 [inline]
> >  khugepaged+0x9bf/0x17a0 mm/khugepaged.c:2559
> >  kthread+0x2d3/0x370 kernel/kthread.c:388
> >  ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> >  </TASK>
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
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
> >
> 

-- 
Peter Xu


