Return-Path: <linux-kernel+bounces-103391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A88787BED2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D111F2219B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7C26FE0F;
	Thu, 14 Mar 2024 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFhi30M6"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE286FBB7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426250; cv=none; b=R16+hptblhteBfJ4/1WN48fUWJ7QsdKe6FrwUgC1agxhxcNqU/aQIYl4Ydez8i0BSRtXrLE0rrrvC1jCX/0z/fNL/KY+sBZl0NkX4QZWdPJ0j5cZna700Kth8+++/Jzg73P4h4CzJRxGSJTi4oX00A6YHld68h6MPvP+IeMA9E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426250; c=relaxed/simple;
	bh=gR1KbAmk5XDuSk0dKpAd6Jsb1UYvwXlerz8/BPCBrlk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=On+nCzG4PAK7DZOGGRM3mdeq6m3QLgn72uVJpd+v7/fV0pwj4ca+Nkf2a1LmxoTzsFc7DqPSAHcZayx0Fy3Wg+lSJfgOiyb5hjR27wWeli/b0KWPqA5j/GPxsB4AJ/3zJpziQX2vcIgxEKAyH5ZhIgMRhjp0Pna7z0QgvGaz/Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFhi30M6; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513cc23b93aso1321456e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710426246; x=1711031046; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PmMpYexK0G7NIU8+ad1+fldk/Npc86/98A4OVXrCyqo=;
        b=MFhi30M6ItBGlkY1NJXvt1k2bmKsYFtS4SP4kBys7OwIZ1t4nqJrUGJZTjVNg3A+BE
         ObW/Q91BUEH4yjiYzz6BnOYvfiLRvrDuAxZln4bxsjlPKUUuZMLut/FI9XAEfPzvckoE
         1/W0/44dwbinIrISh26JhXH6Tt34BIZvGcpK6wzKWCx7gIqi08ob4bDTqW0u5o3Nln4A
         UH2pekR00l1ES0dv68HMz8Nl7Hw+Sh3lGVI6SVw7bPmNnN8i/ZVhUTf5gspfiXoisGEr
         RwyfjUF9QxFZweXjjQNDEoXieJHxovvgI7HdeI7CnrioPU5Ndixi4Zlx8bOEt/qO+NwI
         NmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710426246; x=1711031046;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PmMpYexK0G7NIU8+ad1+fldk/Npc86/98A4OVXrCyqo=;
        b=CxP880RrYtbfZASJEDQnRX08R8oEhemom4QGUaDHxuhumIzMD2R9kkN/+LtzE+pf7r
         pzLQyYz2+wtm8SZuvgMku2rtFO3T2YwXGVq5rUdOp+759Yr+IhO65WtZjLlQx0gs29FB
         9T60SXP6LR/gnYyKaUNSbB6imvv+zkI7uhs2Xvq3pge3qSNvna1vtpoSny1+gjkkswgX
         3U9RvY1q5SWzSEbxXtiTjLVa+4J51+UdjHsQAY1Yzl7Xl+EBl/wF2i2LALxLh4+1xgy4
         eW1+3iRZkaraTY66EMiXqYohp388SGazpxUZL2HELzKO3rlCIjJ2O4O7RQpBx4kMwq6H
         v4Lg==
X-Forwarded-Encrypted: i=1; AJvYcCV7SwVD5vqbE8/Qrk1SaNIXNH8IiwTbUY/dSgBj98i27oxy6y9+GAGP/tx7I8pmGjoHvOotpnBa4t9zsuAPidpXHGrVPgOXoESkCmde
X-Gm-Message-State: AOJu0YxaMUhBefDQojrjYZEA4E/fzUo48EyazVPETFf4oD2qHFlGdMHv
	YB99w4qHo3HvZ0MUKSEdSmwF/kpB38+IvCYKlXTmC/z0eW9wFEyN0BIE6KDvLDDSUXPwK0j7YYs
	vgtvJyiB7mBO36rafpbkPn3DAryeI8LlFgUw=
X-Google-Smtp-Source: AGHT+IHZF5tAuMOvWUi1ZW+e3qHIcrDuEppo+NJLcOmwydFe1Crzhckn+2pwjQ6JvxKjrpWGzJYMeXi4vwW8TEQVc8o=
X-Received: by 2002:a05:6512:3447:b0:513:8f41:eeb7 with SMTP id
 j7-20020a056512344700b005138f41eeb7mr1170251lfr.42.1710426246172; Thu, 14 Mar
 2024 07:24:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Thu, 14 Mar 2024 22:23:54 +0800
Message-ID: <CAKHoSAtC3NzC6c-uA=Ruzn81psVTAX-60Fw51OscpnpeJ2S29g@mail.gmail.com>
Subject: WARNING in __kthread_create_on_node
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

when using Healer to fuzz the latest Linux Kernel, the following crash

was triggered on:


HEAD commit: e8f897f4afef0031fe618a8e94127a0934896aba  (tag: v6.8)

git tree: upstream

console output: https://pastebin.com/raw/4dqjbmVn

kernel config: https://pastebin.com/raw/enVJCL3u

C reproducer: https://pastebin.com/raw/wdKP6g0V

Syzlang reproducer: https://pastebin.com/raw/wfptradq

If you fix this issue, please add the following tag to the commit:

Reported-by: Qiang Zhang <zzqq0103.hey@gmail.com>

----------------------------------------------------------

------------[ cut here ]------------
different return values (11 and 6) from vsnprintf("kmmpd-%.*s", ...)
WARNING: CPU: 0 PID: 18743 at lib/kasprintf.c:30
kvasprintf+0x14e/0x160 lib/kasprintf.c:30
Modules linked in:
CPU: 0 PID: 18743 Comm: syz-executor.0 Not tainted 6.8.0 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:kvasprintf+0x14e/0x160 lib/kasprintf.c:30
Code: 5b 5d 41 5c 41 5d 41 5e 41 5f e9 e8 2f 2d 02 e8 08 54 43 ff 90
48 c7 c7 40 62 fe a1 4c 89 e9 44 89 e2 89 ee e8 d3 62 13 ff 90 <0f> 0b
90 90 eb 99 e8 27 96 12 02 0f 1f 80 00 00 00 00 90 90 90 90
RSP: 0018:ffff88810485f760 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 1ffff1102090beec RCX: ffffffff9eb67582
RDX: ffff888104dfe600 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 000000000000000b R08: 0000000000000001 R09: ffffed10235c5121
R10: 0000000000000000 R11: 000000002d2d2d2d R12: 0000000000000006
R13: ffffffffa1f42a20 R14: ffff888100b62900 R15: 000000000000000c
FS:  00007f8db8f7e640(0000) GS:ffff88811ae00000(0000) knlGS:0000000000000000
loop2: detected capacity change from 0 to 512
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcd493ab98 CR3: 00000001063fe004 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
loop3: detected capacity change from 0 to 512
 __kthread_create_on_node+0x17f/0x3c0 kernel/kthread.c:444
 kthread_create_on_node+0xbf/0x100 kernel/kthread.c:512
loop1: detected capacity change from 0 to 512
 ext4_multi_mount_protect+0x953/0xb10 fs/ext4/mmp.c:392
 __ext4_fill_super fs/ext4/super.c:5363 [inline]
 ext4_fill_super+0xa76d/0xc290 fs/ext4/super.c:5703
 get_tree_bdev+0x35a/0x5d0 fs/super.c:1614
 vfs_get_tree+0x8c/0x320 fs/super.c:1779
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x6b3/0x1db0 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x286/0x310 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xb3/0x1b0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f8db9410dfe
Code: 48 c7 c0 ff ff ff ff eb aa e8 be 0d 00 00 66 2e 0f 1f 84 00 00
00 00 00 0f 1f 40 00 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8db8f7de38 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00000000000004b4 RCX: 00007f8db9410dfe
RDX: 0000000020000040 RSI: 0000000020000500 RDI: 00007f8db8f7de90
RBP: 00007f8db8f7ded0 R08: 00007f8db8f7ded0 R09: 0000000000004500
R10: 0000000000004500 R11: 0000000000000246 R12: 0000000020000040
R13: 0000000020000500 R14: 00007f8db8f7de90 R15: 0000000020000540
 </TASK>
---[ end trace 0000000000000000 ]---

