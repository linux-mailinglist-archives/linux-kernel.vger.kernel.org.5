Return-Path: <linux-kernel+bounces-136531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6F589D538
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829771C213B4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAA17F484;
	Tue,  9 Apr 2024 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmNbj6+F"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E681EB46;
	Tue,  9 Apr 2024 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654151; cv=none; b=N7XbuWYR3UQi/zMrWbaeGx3Zk3hwEwtyJaND0wEVFgK02dKRKBQxURpGevva+ylcNkLjNA5rk7RbVSSghMSWw55mSxagXQn0/CDlAtoxfTZrn04n0yD+rVsWJwufY/RYnOuShg/wIWARBdHcM+0R1AoC8urSoSXWdcMV3BV7Pww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654151; c=relaxed/simple;
	bh=Kwu3N6ZqlVAXMsYk6nzPrBoGp8/y9Qbh8EzzLtKy+R4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OqCJeTQCFuSaqExeTyjjEj5116hfq2YM2U2Fld4C3tNXTNejFzw09jlGiiDc3f4Q9Bnw3i5gb1K+5VRJ3vSYctXGSHM2RqRWv4Ivs+/ZCXCZXWbs8LeHmHXheLvUhOAxlc57IP/79KfAWQzzRlTIazInY8+rP4S3+nAmgopHKVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmNbj6+F; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a51e452a1ceso133879066b.0;
        Tue, 09 Apr 2024 02:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712654147; x=1713258947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uC5MBK9pYcx6MJb1uZ3WvKJ1p/bCIAlzCE806xxtHIs=;
        b=fmNbj6+Fw7b6Vly4qSFQziK8xa8TcgXTZDm1LtL5oCXnjXyELZ7OAuRHSMAzZZXWab
         qMNaUZQkp0j1F42Xt6igh6m1+AxToQemGlewp3FbcyYadLJ+csh8lDXo3IUAXN0megC7
         0tsFwdxYkVSRk73B/iw+ixC19mS5dG48+Lt2DXbsgr8FvyfP1KyOUgonA+6giUGnSJuW
         /eGFwxQzCViTXAKJJAJA4/V0OCDWJ+LfhKAb2VhTXzLDPtnLMR9sZoiuF4GI+A6EGmSk
         ik21Wqt+dX20j9QxXxdUFWRFZPKJRiKANue2wZR8HLZ0lyzIzg/RemVw9NVs6+Bk3ZM4
         pY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712654147; x=1713258947;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uC5MBK9pYcx6MJb1uZ3WvKJ1p/bCIAlzCE806xxtHIs=;
        b=TkKTH6YH7+s+XfjQ3nTy972yGg5NC504YGa/Tm0BuhzsOQC+j/bdMF00fTJhNJ0OmE
         Kt+W1NTYqqaYX28J1qZPQwQh5rIxN/CTOLj5ahiR5DjSAWEQ8yULV+3mBB8T5I5nxlIR
         ZXLXQeAD6ONyu6ytfoWCeHv6XBwwEYZ8KBuCYpb/Cxbk3rRqXM/oM5lETCZZR+1/GNbe
         wwGlZgOGBIXkphdkdjhBbBgbmn2ynwVp4Lg+dpvOGjx0HP3giW8bZrIBVTSRJaE8AeJ3
         Z/QbN583Bkx0+Gj3EGbNW0rVw3SwLH2yEMMnXDQacInjUl0pbJ2b4RA7Qms6CyOgoEPG
         JkpA==
X-Forwarded-Encrypted: i=1; AJvYcCX1TICh30KxrlA0EKHYzlbzF+snTlHhwhKAOZhu6osi0/wrzVlvaH2KSdDvkJCN/R7SNAqGzEVkv9tq/hviCYH9aEP1bOY33h/tDVo=
X-Gm-Message-State: AOJu0YzIgUny+lwUNEUyygA6Jh7B+RaFYCTlOI51TKhQ2iemjpSC8i/t
	nJNFrBoyNHyvofXDoNCKdZKNvRkSAJJMOvtmKKCtnxLDb2YPo7fADAhl0FBDWH0C6sNYBtLKOKr
	52RmiuqedkkLSys2VwBruG6b0MARR6/p1SeipKA==
X-Google-Smtp-Source: AGHT+IF/Rv+ThPnDz5UILPZSdMxfkMhkOmO5H2OnwfyNJLi9nsrAR29m7yO2G8Y6VWhsJdkGRMrvoV/aZFO3F3U57o8=
X-Received: by 2002:a17:907:728e:b0:a51:d136:affb with SMTP id
 dt14-20020a170907728e00b00a51d136affbmr5282552ejc.40.1712654147295; Tue, 09
 Apr 2024 02:15:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sam Sun <samsun1006219@gmail.com>
Date: Tue, 9 Apr 2024 17:15:35 +0800
Message-ID: <CAEkJfYONxEew-9-KsXG_=C-Qx5j=27CB43JEPhiLaGrXenLHpA@mail.gmail.com>
Subject: [Linux kernel bug] general protection fault in udmabuf_create
To: linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	christian.koenig@amd.com, sumit.semwal@linaro.org, kraxel@redhat.com
Cc: syzkaller-bugs@googlegroups.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"

Dear developers and maintainers,

We encountered a general protection fault in udmabuf_create. It is
tested on latest upstream linux (6.9-rc3). The kernel log is listed
below.
```
general protection fault, probably for non-canonical address
0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 PID: 8122 Comm: syz-executor422 Not tainted 6.7.0-rc7 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:udmabuf_create+0x220/0xe60 drivers/dma-buf/udmabuf.c:217
Code: 83 c5 18 44 89 e7 e8 cf 73 04 fc 45 39 fc 0f 84 fe 00 00 00 e8
21 78 04 fc 48 89 e8 48 b9 00 00 00 00 00 fc ff df 48 c1 e8 03 <80> 3c
08 00 0f 85 d6 08 00 00 48 8b 5d 00 31 ff 81 e3 ff 0f 00 00
RSP: 0018:ffffc90002a2fca8 EFLAGS: 00010206
RAX: 0000000000000003 RBX: dffffc0000000000 RCX: dffffc0000000000
RDX: ffff8881074a4980 RSI: ffffffff85809cef RDI: 0000000000000005
RBP: 0000000000000018 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: ffffffff8a80008b R12: 0000000000000000
R13: 0000000000004000 R14: ffff8880162ec380 R15: 0000000080000000
FS:  0000555556e1b3c0(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 000000001b7ab000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 udmabuf_ioctl_create_list drivers/dma-buf/udmabuf.c:328 [inline]
 udmabuf_ioctl+0x26d/0x2c0 drivers/dma-buf/udmabuf.c:343
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x19d/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fd8fab06b4d
Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffb972c428 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fffb972c628 RCX: 00007fd8fab06b4d
RDX: 0000000020000000 RSI: 0000000040087543 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0074696d696c5f74 R09: 00007fffb972c628
R10: 000000000000000f R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffb972c618 R14: 00007fd8fab84530 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:udmabuf_create+0x220/0xe60 drivers/dma-buf/udmabuf.c:217
Code: 83 c5 18 44 89 e7 e8 cf 73 04 fc 45 39 fc 0f 84 fe 00 00 00 e8
21 78 04 fc 48 89 e8 48 b9 00 00 00 00 00 fc ff df 48 c1 e8 03 <80> 3c
08 00 0f 85 d6 08 00 00 48 8b 5d 00 31 ff 81 e3 ff 0f 00 00
RSP: 0018:ffffc90002a2fca8 EFLAGS: 00010206
RAX: 0000000000000003 RBX: dffffc0000000000 RCX: dffffc0000000000
RDX: ffff8881074a4980 RSI: ffffffff85809cef RDI: 0000000000000005
RBP: 0000000000000018 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: ffffffff8a80008b R12: 0000000000000000
R13: 0000000000004000 R14: ffff8880162ec380 R15: 0000000080000000
FS:  0000555556e1b3c0(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 000000001b7ab000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
----------------
Code disassembly (best guess):
   0:    83 c5 18                 add    $0x18,%ebp
   3:    44 89 e7                 mov    %r12d,%edi
   6:    e8 cf 73 04 fc           call   0xfc0473da
   b:    45 39 fc                 cmp    %r15d,%r12d
   e:    0f 84 fe 00 00 00        je     0x112
  14:    e8 21 78 04 fc           call   0xfc04783a
  19:    48 89 e8                 mov    %rbp,%rax
  1c:    48 b9 00 00 00 00 00     movabs $0xdffffc0000000000,%rcx
  23:    fc ff df
  26:    48 c1 e8 03              shr    $0x3,%rax
* 2a:    80 3c 08 00              cmpb   $0x0,(%rax,%rcx,1) <--
trapping instruction
  2e:    0f 85 d6 08 00 00        jne    0x90a
  34:    48 8b 5d 00              mov    0x0(%rbp),%rbx
  38:    31 ff                    xor    %edi,%edi
  3a:    81 e3 ff 0f 00 00        and    $0xfff,%ebx
```
We analyzed the root cause of this bug. In function
udmabuf_ioctl_create_list, line 321, if list_limit is lower than 0,
list_limit will be converted to uint before comparison. This would
cause head.count to be an arbitrary large number, and the lsize
therefore will become 0 because of overflow, causing the return value
of memdup_user changed to 0x10.
One possible fix could be change list_limit from int type to uint,
since the limit should never be below 0.
If you have any questions, please contact us.
Reported by: Yue Sun <samsun1006219@gmail.com>
Reported by: xingwei lee <xrivendell7@gmail.com>

Best Regards,
Yue

