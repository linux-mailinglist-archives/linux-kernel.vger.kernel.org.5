Return-Path: <linux-kernel+bounces-12397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4434381F438
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 03:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D6B1C2169E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0788B1396;
	Thu, 28 Dec 2023 02:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="d1JSxORN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD14910E5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 02:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d9b760610bso216135b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 18:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1703732278; x=1704337078; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xjGt/UWPs7IIe1Ke3qZiLhv+zYLHUTVWeKUGbJl8a3E=;
        b=d1JSxORNZHVvdBPYpvA1OLVVVbsnc258DN7CnBXIZlvBD8OdrP9o5TQSeatdHjW+ly
         P3wlheY+xIoDhXoo+nAQy1QXySgdYBiH03Aoi0c+FKPkbg+R4r7WuC56IVlpaIOlOzSY
         aHrtIYZY4CGqTMbfSH/BhGOisrqHHjubryYYOdQSCKWq/HNzSrjXh80pJaibiOsd48Ui
         PdAG0huVmwsfPfBSqVwc15PkJM74HQRB0ZzI5fAs+SZL+8rre02TC4mqFiHg3icn7HRM
         THw2Z6OcUknGBC9uPLyQR0sPZNbgkDwy4W7bXX4gyYHgkNZPvdPV8J7oUUvMa8eYjg6r
         suEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703732278; x=1704337078;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjGt/UWPs7IIe1Ke3qZiLhv+zYLHUTVWeKUGbJl8a3E=;
        b=I8oopYh3oQU/8s0Q2dsF86LQIynAjMowNM75in88WZ4Ca8l8iOc+AMIUJ6sUfbp1os
         DUWoL5nhT0UVv1WqPaJ1Mi/LG9hs8QucylYRDJhctZRE1GGyM8w/d/+isnwETTqeREQx
         eguQhctWi/hmaOp7mL8Dy09MhwpjetCWjHNB5kVKFHm4+XfF/8GskT10H1i4B27YY/VN
         Tyjk4iUfW6i5I6s08wKmix79UttjoeuaO8v0mJ9Zr0P/Y25AF/a68SapqjMar2u0Qfj0
         0khEue2M5BGY8r7S5z9HKIAMBSPdjW4bQg5y6u99yJsEyxI+a/Hx8rMlcxBTjc5WjlH6
         xqsA==
X-Gm-Message-State: AOJu0YzewcdTqBvBsBI/vcWswqkpf8/j7XDbZNQ41nSH1R5o/zZU+HHK
	IQxQ9Wmi9/2FfHc7Ce5PmPn+oArBw/voBg==
X-Google-Smtp-Source: AGHT+IGWOV/7SIgU0mElNti5AvndC6AS0UK4Yz+sA8GGhSRlnDsw5D5kQyRmtDKZuQpJqhtQCwIB8g==
X-Received: by 2002:a05:6a20:320f:b0:195:3ab4:52b2 with SMTP id hl15-20020a056a20320f00b001953ab452b2mr15760686pzc.0.1703732278020;
        Wed, 27 Dec 2023 18:57:58 -0800 (PST)
Received: from [10.84.155.44] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id m10-20020a170902db0a00b001d3867b6424sm12720366plx.113.2023.12.27.18.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 18:57:57 -0800 (PST)
Message-ID: <0b0963c2-3c77-4037-a66c-f535c4422755@bytedance.com>
Date: Thu, 28 Dec 2023 10:57:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [dri?] WARNING in drm_prime_destroy_file_private (2)
Content-Language: en-US
To: syzbot <syzbot+59dcc2e7283a6f5f5ba1@syzkaller.appspotmail.com>
References: <000000000000f4faa2060d83f582@google.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: airlied@gmail.com, akinobu.mita@gmail.com, akpm@linux-foundation.org,
 christian.koenig@amd.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 jgg@nvidia.com, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 sumit.semwal@linaro.org, syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
In-Reply-To: <000000000000f4faa2060d83f582@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/12/28 04:51, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    5254c0cbc92d Merge tag 'block-6.7-2023-12-22' of git://git..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=10cc6995e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=314e9ad033a7d3a7
> dashboard link: https://syzkaller.appspot.com/bug?extid=59dcc2e7283a6f5f5ba1
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e35809e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155d5fd6e80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ebe09a5995ee/disk-5254c0cb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/02178d7f5f98/vmlinux-5254c0cb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/12307f47d87c/bzImage-5254c0cb.xz
> 
> The issue was bisected to:
> 
> commit ea4452de2ae987342fadbdd2c044034e6480daad
> Author: Qi Zheng <zhengqi.arch@bytedance.com>
> Date:   Fri Nov 18 10:00:11 2022 +0000
> 
>      mm: fix unexpected changes to {failslab|fail_page_alloc}.attr
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13027f76e80000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=10827f76e80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=17027f76e80000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+59dcc2e7283a6f5f5ba1@syzkaller.appspotmail.com
> Fixes: ea4452de2ae9 ("mm: fix unexpected changes to {failslab|fail_page_alloc}.attr")
> 
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007efe98069194
> R13: 00007efe97fd2210 R14: 0000000000000002 R15: 6972642f7665642f
>   </TASK>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5107 at drivers/gpu/drm/drm_prime.c:227 drm_prime_destroy_file_private+0x43/0x60 drivers/gpu/drm/drm_prime.c:227

The warning is caused by !RB_EMPTY_ROOT(&prime_fpriv->dmabufs):

drm_prime_destroy_file_private
--> WARN_ON(!RB_EMPTY_ROOT(&prime_fpriv->dmabufs));

It seems irrelevant to the logic of fault injection. So I don't see
why the commit ea4452de2ae9 can cause this warning. :(

> Modules linked in:
> CPU: 0 PID: 5107 Comm: syz-executor227 Not tainted 6.7.0-rc6-syzkaller-00248-g5254c0cbc92d #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
> RIP: 0010:drm_prime_destroy_file_private+0x43/0x60 drivers/gpu/drm/drm_prime.c:227
> Code: 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 21 48 8b 83 90 00 00 00 48 85 c0 75 06 5b e9 13 f1 93 fc e8 0e f1 93 fc 90 <0f> 0b 90 5b e9 04 f1 93 fc e8 3f 9b ea fc eb d8 66 66 2e 0f 1f 84
> RSP: 0018:ffffc90003bdf9e0 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff888019f28378 RCX: ffffc90003bdf9b0
> RDX: ffff888018ff9dc0 RSI: ffffffff84f380c2 RDI: ffff888019f28408
> RBP: ffff888019f28000 R08: 0000000000000001 R09: 0000000000000001
> R10: ffffffff8f193a57 R11: 0000000000000000 R12: ffff88814829a000
> R13: ffff888019f282a8 R14: ffff88814829a068 R15: ffff88814829a0a0
> FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007efe98050410 CR3: 000000006d1ff000 CR4: 0000000000350ef0
> Call Trace:
>   <TASK>
>   drm_file_free.part.0+0x738/0xb90 drivers/gpu/drm/drm_file.c:290
>   drm_file_free drivers/gpu/drm/drm_file.c:247 [inline]
>   drm_close_helper.isra.0+0x180/0x1f0 drivers/gpu/drm/drm_file.c:307
>   drm_release+0x22a/0x4f0 drivers/gpu/drm/drm_file.c:494
>   __fput+0x270/0xb70 fs/file_table.c:394
>   task_work_run+0x14d/0x240 kernel/task_work.c:180
>   exit_task_work include/linux/task_work.h:38 [inline]
>   do_exit+0xa8a/0x2ad0 kernel/exit.c:869
>   do_group_exit+0xd4/0x2a0 kernel/exit.c:1018
>   get_signal+0x23b5/0x2790 kernel/signal.c:2904
>   arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:309
>   exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
>   exit_to_user_mode_prepare+0x121/0x240 kernel/entry/common.c:204
>   __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
>   syscall_exit_to_user_mode+0x1e/0x60 kernel/entry/common.c:296
>   do_syscall_64+0x4d/0x110 arch/x86/entry/common.c:89
>   entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7efe98014769
> Code: Unable to access opcode bytes at 0x7efe9801473f.
> RSP: 002b:00007efe97fd2208 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 00007efe9809c408 RCX: 00007efe98014769
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007efe9809c408
> RBP: 00007efe9809c400 R08: 0000000000003131 R09: 0000000000003131
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007efe98069194
> R13: 00007efe97fd2210 R14: 0000000000000002 R15: 6972642f7665642f
>   </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
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

