Return-Path: <linux-kernel+bounces-73360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1FB85C172
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF9E1F20FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAC5768E6;
	Tue, 20 Feb 2024 16:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="dV1G+xSW";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="MTearm4t"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CF376400;
	Tue, 20 Feb 2024 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446691; cv=pass; b=N/swzJ4MEF5q35I1H85fdbygqtQJs/9XWABhcWT4ItlJu5SJl3Zo41PIQ20y3cyTjrHvSyQE0vbwuUumU4s6wU6yGH9bBHeQIFz3xDDzaJeHLDeN6n2WXrTHkWq66KnJH2XZ5Jn6FsJIAXeJHOW8E9MljhxU0bTbxbtMGFSQLmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446691; c=relaxed/simple;
	bh=JfXxUzJKdWucwiW6KqUT8QQj8m/lBfDj1aZ0eKXWlSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HyZEVeLuqCdH/QLAj0iwm6fLHOsJvNGcq0yoDCyPIGdfc6wxMyCmfqVJAvVVKQQCWkhVxxi8NxPKI66Z0HxxsJqiL4HRVI8jk5IIv40t/TNfoTRazautj8KJEjdvjPYAGH1OITrBAnUl8iBdV4o9d+iRNp/dtqT18O+cMpsijcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=dV1G+xSW; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=MTearm4t; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1708446504; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EK6NIu1NIJIeE2JwZYUHU2ft9fAIPY77VfvKcp6BvzCA5Nn29nwVYlsVf95tOf6Tep
    xC66Dn5RifW1zHv9pNN8ZLWUNnDHQxdvr5hq1tKmCzUO7EjsymNQe7IwfDcz340Olsb0
    xBbCnJ/ZRyQ2rmx0hfW8M5r/RZ3nMdXWpNKktMJa/VcBEljJhY4SJPJHsy6W/2lw3ep7
    39VuGd+Jb3jHxvnNGuCl12HZ6FrrrlH/7pTp5vio6s85A8rr1IwsIP9hQUL2tNXtQUw+
    W57Nb5xhXYVc7porhTGaXalAGaI9q5nGK3Ro96ntUEWfULtqm/Ezy3huYGqSIK6DyWLk
    /BLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1708446504;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=Xc85nduGOgJ1ntImtZqeF0SSc77OQIEvmm0jwvVa6cU=;
    b=VrzYpAf5RrDvwZhxur2dOzdtCSUJDIixjTR1Z6GzA2FJo/XeKUtcDsaNIMLAxQ1sgn
    ajx6sWDSpflH9PKwNBF9jmgKN+inDns5d4GgOLt8JPjr+WEuau1AjQhgPy/UpS4fzcMu
    RgwXif4pJctEzbqVpfcqwe6KNoXFivF2TNNJZ3R7EkE24pE08uAQgcSqJ4pIOziK5hsf
    uuOcXEt3dTsUDIOai4VpMpbw9DL+sWyJyJGZVMFxJl4iaZ2zHbSzmeJksbTA3aIhyxPk
    DxQtaDWlDygUR9JNgzlwaxGF0NjA+6vhIQIqTLuVG7NqXiD9qdPJvRB0OI9omUKRVAcf
    0Osg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1708446504;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=Xc85nduGOgJ1ntImtZqeF0SSc77OQIEvmm0jwvVa6cU=;
    b=dV1G+xSWBk96Hf/98BZsIyIBYNXyGetyivnkylvuwuuf++a1ygKZ+ewMnrm9vqTeGc
    ABMFMQWys1VjG77g0oSLfaafWdNl98jJWxpYBM9hKXPRDHyyF62lojTcKs7mIhd3FnY/
    YBAcJeCXj5F4NYWjmdqMlS3ZQJB4CnUFttfrxjeMMU+97912hDQCk5yhsZOqOEo8Mi0j
    JsLnbkzpqS4ZX4T5jtkFWI8WY+yLOjw0+cAZQz6yVnKDVoqoD29Mw9uy7M0GZJA5rvYk
    s7CFGtQ+lo08qR95tU+6R+K3cwJvXJlheBHC57Xnx+XuBGFhdEr5r6SW1XVatPEzY7ln
    XQVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1708446504;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=Xc85nduGOgJ1ntImtZqeF0SSc77OQIEvmm0jwvVa6cU=;
    b=MTearm4tUl+3nkaXgSKDg57scvgRf8l0ObBLozZl6J4zA8xPyteU6WaeKRfd9XhXg1
    uUQToEr+qXXy87EC/dBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDdAnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::90c]
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id K49f9c01KGSOBGx
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 20 Feb 2024 17:28:24 +0100 (CET)
Message-ID: <9a98f3f1-6a39-4b05-b100-93be1361fd76@hartkopp.net>
Date: Tue, 20 Feb 2024 17:28:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] [hardening?] BUG: bad usercopy in raw_getsockopt
To: syzbot <syzbot+0c35af046fa98c893c84@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, gustavoars@kernel.org, keescook@chromium.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000038b6700611d207b3@google.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <00000000000038b6700611d207b3@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The issue has already been fixed with the next commit in net-next:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=c8fba5d6df5e476aa791db4f1f014dad2bb5e904

Sorry for the effort - but really good to see, that the problem has been 
catched automatically. Good job!

Best regards,
Oliver

On 2024-02-20 16:40, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    74293ea1c4db net: sysfs: Do not create sysfs for non BQL d..
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=13dcc4b4180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=970c7b6c80a096da
> dashboard link: https://syzkaller.appspot.com/bug?extid=0c35af046fa98c893c84
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f38cf8180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136d41c2180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9bca2f6e074e/disk-74293ea1.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/611a08387d8f/vmlinux-74293ea1.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/78c388071345/bzImage-74293ea1.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0c35af046fa98c893c84@syzkaller.appspotmail.com
> 
> usercopy: Kernel memory exposure attempt detected from null address (offset 0, size 4)!
> ------------[ cut here ]------------
> kernel BUG at mm/usercopy.c:102!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 1 PID: 5070 Comm: syz-executor201 Not tainted 6.8.0-rc4-syzkaller-01053-g74293ea1c4db #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> RIP: 0010:usercopy_abort+0x84/0x90 mm/usercopy.c:102
> Code: 49 89 ce 48 c7 c3 40 db b7 8b 48 0f 44 de 48 c7 c7 e0 d9 b7 8b 4c 89 de 48 89 c1 41 52 41 56 53 e8 01 c5 60 09 48 83 c4 18 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc90003a3fc50 EFLAGS: 00010296
> RAX: 0000000000000057 RBX: ffffffff8bb7db20 RCX: b071ef5fcc834300
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: ffffffffffffffff R08: ffffffff81753e6c R09: 1ffff92000747f28
> R10: dffffc0000000000 R11: fffff52000747f29 R12: 0000000000000001
> R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000555555f8e380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020001480 CR3: 000000001f404000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   __check_object_size+0x601/0xa00
>   check_object_size include/linux/thread_info.h:215 [inline]
>   check_copy_size include/linux/thread_info.h:251 [inline]
>   copy_to_user include/linux/uaccess.h:190 [inline]
>   raw_getsockopt+0x37a/0x490 net/can/raw.c:852
>   do_sock_getsockopt+0x373/0x850 net/socket.c:2373
>   __sys_getsockopt+0x270/0x330 net/socket.c:2402
>   __do_sys_getsockopt net/socket.c:2412 [inline]
>   __se_sys_getsockopt net/socket.c:2409 [inline]
>   __x64_sys_getsockopt+0xb5/0xd0 net/socket.c:2409
>   do_syscall_64+0xf9/0x240
>   entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7f21bfe782a9
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffcdfc8f038 EFLAGS: 00000246 ORIG_RAX: 0000000000000037
> RAX: ffffffffffffffda RBX: 00007ffcdfc8f208 RCX: 00007f21bfe782a9
> RDX: 0000000000000008 RSI: 0000000000000065 RDI: 0000000000000003
> RBP: 00007f21bfeeb610 R08: 0000000020001480 R09: 00007ffcdfc8f208
> R10: 0000000020001440 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffcdfc8f1f8 R14: 0000000000000001 R15: 0000000000000001
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:usercopy_abort+0x84/0x90 mm/usercopy.c:102
> Code: 49 89 ce 48 c7 c3 40 db b7 8b 48 0f 44 de 48 c7 c7 e0 d9 b7 8b 4c 89 de 48 89 c1 41 52 41 56 53 e8 01 c5 60 09 48 83 c4 18 90 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc90003a3fc50 EFLAGS: 00010296
> RAX: 0000000000000057 RBX: ffffffff8bb7db20 RCX: b071ef5fcc834300
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: ffffffffffffffff R08: ffffffff81753e6c R09: 1ffff92000747f28
> R10: dffffc0000000000 R11: fffff52000747f29 R12: 0000000000000001
> R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000555555f8e380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020001480 CR3: 000000001f404000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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
> 

