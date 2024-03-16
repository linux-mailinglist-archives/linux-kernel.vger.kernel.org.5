Return-Path: <linux-kernel+bounces-105043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DC787D821
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 04:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C291C21066
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 03:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B89428E6;
	Sat, 16 Mar 2024 03:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3GlvuUU"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF661C36
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 03:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710558988; cv=none; b=ESNvgwuCFO4YKWixyEVRGOvGlkTYl56MWh8UKakxfQJJFcvIOZyScHDp5v8H/BxVsL6CdRM3r1OpU5oaTyp1Waz9Ct0fUqXKspW00p0UjY8BtLZ5OqAmKuBYd95FIz80AoUjdpFZfTqcjnqcD2XZ3dsqtIYlaq4Vsdn0Nm9r2R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710558988; c=relaxed/simple;
	bh=EcbyuZdD1nKJUd0u4uWHAl075EWF2XXPTFBDLT9/Psc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pIXGe3sJSkA83OhVPn9T6HbWiDkh3QHDjxkytofCeRAaDucZitE0p9ljdEmNrS0Tus7nXLAgjRsIv5+jnPVJLbTZNsVVtZB5Q4A7D8cuahr77auDCNkQeb6KuCnxvxE5pOBsugU5+1sHD4x6HLN9LXw4Ey0u86fC6AWN7hGXEK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3GlvuUU; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d28051376eso40322191fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 20:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710558984; x=1711163784; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gbglWnCiLagr+SJDXaenwv4vm+LxOFUakQlWyJFJErU=;
        b=E3GlvuUUThWAGA6EWLonwA5Ox1w/s1JZB9OPBWYJAW/14rVIgRTE0oT9PZfJbzPAP1
         T4pWPI+Kaj3RP/I/TzpIycL7LDuDStJ+VZtukDtVgvWDDZMcXXur4sFt1O9lJ5HXrjPA
         qlcXGqMvlQEoTpfdjP/nJl0l5zY/YtSF00q5VEr1SIfESFDcNWs+f1a1gDeqtzDFgtn4
         P14j0Kavd5d/PyFQpfT02KANHkiusA5uhf4J/X5QL5cB5Z/RCKx+UsMu2wL78ogssDzi
         qfCwW+pWpSpLVxdpKMVg1hCBOYd5AjTxjUD4MOHkpEnZ9R5Q37puwQs7HbwnztYLDdDa
         VGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710558984; x=1711163784;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gbglWnCiLagr+SJDXaenwv4vm+LxOFUakQlWyJFJErU=;
        b=hTreIi/zyfUWJUQVP+omBulQ33FOh5GI9f90DHebVzY5iCEZS87BYCNcAAF/WLJuNZ
         O1U8Q8BtTWE84hDvjDWoRnh6RhyQnm6/aUMCDUhpiLrnmC6ZLw5Pk8Xf5qXDCDJm+0em
         b825PzM76F4Hb/m9uAsFjFrBcMYnGecsW+NOVz50A+iRy2dD3u/242QcNwAr+fEgJahS
         C2++V+tzDm3BDzAzGODJc2VQJxYNVfCbEDB5T4/aw0DuhaVBJtaJowQ2Dc1jqhdWrIZz
         FUzoccrZmBSiMx7PQvow07P9ubvHrPdXqDZ2nhTfOVHhjaR+6OvSP1b1ibwC/8AvBmp1
         e7qw==
X-Gm-Message-State: AOJu0YxP154PQhcue09NFQs2KiLFuf9luOoodndGp2wcjs/VxAciXl3i
	dBW2OYOoKB+KrLW0CEPnk4Yy35itnpbJ6qE1N7TYG/bU6ABV5CkaulfE2p4QeNZgaS2zZywDrv6
	OjY2Wh/3/LvjkgTWQNPSDrEV5g2A=
X-Google-Smtp-Source: AGHT+IHzglg0TWx7IiOO3hkZ1aZhgBoGS2xinv/DTfI7MuaZizaFH1k42Rdu7dXfNM9zinc43HTL+JBsgcFDxJEUdBs=
X-Received: by 2002:a2e:a9a8:0:b0:2d4:22b6:eee6 with SMTP id
 x40-20020a2ea9a8000000b002d422b6eee6mr750735ljq.8.1710558984095; Fri, 15 Mar
 2024 20:16:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Sat, 16 Mar 2024 11:16:08 +0800
Message-ID: <CAKHoSAsF2iN1HSRxVs2W0CBi_PMKE3bYLgZE6siwARqV1f+Xng@mail.gmail.com>
Subject: general protection fault in kernfs_dop_revalidate
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

when using Healer to fuzz the latest Linux Kernel, the following crash

was triggered on:


HEAD commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72  (tag: v6.8-rc7)

git tree: upstream

console output: https://pastebin.com/raw/Hjn0vNFh

kernel config: https://pastebin.com/raw/EjhKA6ij

C reproducer: https://pastebin.com/raw/5nL8yLmu

Syzlang reproducer: https://pastebin.com/raw/Gkqa66xp

If you fix this issue, please add the following tag to the commit:

Reported-by: Qiang Zhang <zzqq0103.hey@gmail.com>

----------------------------------------------------------


BUG: unable to handle page fault for address: ffff888104849cf0
RIP: 0010:kernfs_root fs/kernfs/kernfs-internal.h:70 [inline]
RIP: 0010:kernfs_dop_revalidate+0xc7/0x580 fs/kernfs/dir.c:1149
#PF: supervisor read access in kernel mode
Code: 00 04 00 00 4c 8b 65 08 4d 85 e4 4c 0f 44 e5 e8 0f 28 b3 ff 48
b8 00 00 00 00 00 fc ff df 49 8d 7c 24 50 48 89 fa 48 c1 ea 03 <80> 3c
02 00 0f 85 e7 03 00 00 4d 8b 64 24 50 4c 8d 6d 04 49 83 c4
#PF: error_code(0x0009) - reserved bit violation
RSP: 0018:ffff888112557990 EFLAGS: 00010217
PGD 1d0201067 P4D 1d0201067

RAX: dffffc0000000000 RBX: ffff888108fbb000 RCX: ffffffffa42bb871
PUD 100915063
RDX: 0012476b20000009 RSI: 0000000000000000 RDI: 00923b590000004f
PMD 10464f063
RBP: ffff8881045dbc00 R08: 0000000000000000 R09: ffffed10211f7607
PTE 484b16380000001
R10: ffff888108fbb038 R11: 0000000000000000 R12: 00923b58ffffffff

Oops: 0009 [#4] PREEMPT SMP KASAN NOPTI
R13: ffff888108c1b800 R14: ffff8881045dbc08 R15: ffff888115091120
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D            6.8.0-rc7 #1
FS:  00007ffa91fbc640(0000) GS:ffff8881f7180000(0000) knlGS:0000000000000000
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
RIP: 0010:find_stack lib/stackdepot.c:594 [inline]
RIP: 0010:stack_depot_save_flags+0x136/0x710 lib/stackdepot.c:659
CR2: ffff888104800000 CR3: 0000000105898003 CR4: 0000000000770ef0
Code: 0d d7 84 75 04 65 ff 05 f0 90 63 5b 4d 8b 31 89 d6 83 e6 02 4d
39 f1 75 11 e9 c9 01 00 00 4d 8b 36 4d 39 f1 0f 84 bd 01 00 00 <41> 39
5e 10 75 ee 41 3b 6e 14 75 e8 31 c0 49 8b 7c c6 20 49 39 7c
PKRU: 55555554
RSP: 0018:ffff88810036f9b8 EFLAGS: 00010202
note: syz-executor207[342] exited with irqs disabled

RAX: 000000004b42e799 RBX: 000000001d41ecbb RCX: 00000000dbd2612a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 000000000000000b R08: ffff88810036f918 R09: ffff8881f55ecbb0
R10: ffff888112c3f083 R11: ffff8881f70b8a20 R12: 0000000000000000
R13: ffff88810036fa18 R14: ffff888104849ce0 R15: 000000000000000b
FS:  0000000000000000(0000) GS:ffff8881f7080000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff888104849cf0 CR3: 0000000105898003 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 kasan_save_stack+0x34/0x50 mm/kasan/common.c:48
 __kasan_record_aux_stack+0x8e/0xa0 mm/kasan/generic.c:551
 __call_rcu_common.constprop.0+0x6a/0xab0 kernel/rcu/tree.c:2715
 put_task_struct_rcu_user+0x69/0xb0 kernel/exit.c:235
 finish_task_switch.isra.0+0x5f6/0x7d0 kernel/sched/core.c:5309
 context_switch kernel/sched/core.c:5403 [inline]
 __schedule+0xc26/0x22d0 kernel/sched/core.c:6727
 schedule_idle+0x65/0xa0 kernel/sched/core.c:6843
 do_idle+0x295/0x430 kernel/sched/idle.c:340
 cpu_startup_entry+0x5a/0x70 kernel/sched/idle.c:410
 start_secondary+0x1ba/0x210 arch/x86/kernel/smpboot.c:336
 secondary_startup_64_no_verify+0x16d/0x17b
 </TASK>
Modules linked in:
CR2: ffff888104849cf0
---[ end trace 0000000000000000 ]---
BUG: unable to handle page fault for address: ffff888104849cf0
RIP: 0010:kernfs_root fs/kernfs/kernfs-internal.h:70 [inline]
RIP: 0010:kernfs_dop_revalidate+0xc7/0x580 fs/kernfs/dir.c:1149
#PF: supervisor read access in kernel mode
Code: 00 04 00 00 4c 8b 65 08 4d 85 e4 4c 0f 44 e5 e8 0f 28 b3 ff 48
b8 00 00 00 00 00 fc ff df 49 8d 7c 24 50 48 89 fa 48 c1 ea 03 <80> 3c
02 00 0f 85 e7 03 00 00 4d 8b 64 24 50 4c 8d 6d 04 49 83 c4
#PF: error_code(0x0009) - reserved bit violation
RSP: 0018:ffff888112557990 EFLAGS: 00010217
PGD 1d0201067 P4D 1d0201067
RAX: dffffc0000000000 RBX: ffff888108fbb000 RCX: ffffffffa42bb871
PUD 100915063
RDX: 0012476b20000009 RSI: 0000000000000000 RDI: 00923b590000004f
PMD 10464f063
RBP: ffff8881045dbc00 R08: 0000000000000000 R09: ffffed10211f7607
PTE 484b16380000001
R10: ffff888108fbb038 R11: 0000000000000000 R12: 00923b58ffffffff

R13: ffff888108c1b800 R14: ffff8881045dbc08 R15: ffff888115091120
Oops: 0009 [#5] PREEMPT SMP KASAN NOPTI
FS:  0000000000000000(0000) GS:ffff8881f7080000(0000) knlGS:0000000000000000
CPU: 3 PID: 0 Comm: swapper/3 Tainted: G      D            6.8.0-rc7 #1
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
CR2: ffff888104849cf0 CR3: 0000000105898003 CR4: 0000000000770ef0
RIP: 0010:find_stack lib/stackdepot.c:594 [inline]
RIP: 0010:stack_depot_save_flags+0x136/0x710 lib/stackdepot.c:659
PKRU: 55555554
Code: 0d d7 84 75 04 65 ff 05 f0 90 63 5b 4d 8b 31 89 d6 83 e6 02 4d
39 f1 75 11 e9 c9 01 00 00 4d 8b 36 4d 39 f1 0f 84 bd 01 00 00 <41> 39
5e 10 75 ee 41 3b 6e 14 75 e8 31 c0 49 8b 7c c6 20 49 39 7c
----------------
Code disassembly (best guess):
   0: 00 04 00              add    %al,(%rax,%rax,1)
   3: 00 4c 8b 65          add    %cl,0x65(%rbx,%rcx,4)
   7: 08 4d 85              or     %cl,-0x7b(%rbp)
   a: e4 4c                in     $0x4c,%al
   c: 0f 44 e5              cmove  %ebp,%esp
   f: e8 0f 28 b3 ff        call   0xffb32823
  14: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
  1b: fc ff df
  1e: 49 8d 7c 24 50        lea    0x50(%r12),%rdi
  23: 48 89 fa              mov    %rdi,%rdx
  26: 48 c1 ea 03          shr    $0x3,%rdx
* 2a: 80 3c 02 00          cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e: 0f 85 e7 03 00 00    jne    0x41b
  34: 4d 8b 64 24 50        mov    0x50(%r12),%r12
  39: 4c 8d 6d 04          lea    0x4(%rbp),%r13
  3d: 49                    rex.WB
  3e: 83                    .byte 0x83
  3f: c4                    .byte 0xc4

