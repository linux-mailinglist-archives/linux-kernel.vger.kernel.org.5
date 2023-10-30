Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC037DB3D4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjJ3HH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJ3HH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:07:26 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CA0BD
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:07:21 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-4a8ba764ae3so2718424e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 00:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698649640; x=1699254440; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zSehCJDGXzLnW0BsgeIZmX5+NaPrdXVULFFIBptOnfk=;
        b=VArzKMSqQ0mRB3mGwZ61YxefyOjHEhHU3rbwaZopGMtFeYSiYG4FtL4T4rIH1qqKim
         /2/AQSb6HzmOFgJs8KLlOnTYlUf6gEts/oWjCfpmdTjC7Ui6M0dZ75RWyopbDC9QrwKf
         ghdqLoQKkVr2021kkfEPSx3EUnY+bPtuN3x6WGO8QSJKeyckghkveUd/A2ocTcdcYKXh
         i09bC5XXWLKpWxZVXOmHbdVe678c2JC9twlj8teYV9AuH8HHVV/hSzd79PmR/MmqkuyR
         jOw6zyXIRIxw38x5SoGfpXAILHvxRZ6llJu7MuQp5pFERWyV/VWLu0URWMzCQ0U/+5QZ
         yeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698649640; x=1699254440;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSehCJDGXzLnW0BsgeIZmX5+NaPrdXVULFFIBptOnfk=;
        b=es6MAtrpRBxSh3/6HGYlo0B5O8aPBHI0dgBwc+Ty40ct5CQJV0Dkdoze9E8HhrOQn8
         m2n356GFm5VXQue/Ap3HTliJnYNFyVRGNqhGKHPrZTTkMHIU/rmB0cvBbXl9nRfnUeXE
         TUdSUkZt2XGiiL03CwL8QNCx+72M6FhpadzfW8ldmUypAJhnpqBIfAlnQG6wi5+2Roji
         NssCfKyDD5vJsx+g4Cz3UaD5ePIzIEWaZjpEvGO4SfeRAxitbc9B0b8u3KLi5e33pPp/
         ZwHJbbTgGZaPr4rmlamvN59z3LeA0mH6/gRp8AwuQFxRdQUYszVAb0z/CtzH8n9glPgh
         yHIQ==
X-Gm-Message-State: AOJu0YyWlmvZ3b4tzZKwleZ5RX9SpaTuqDLefBzEkFdBGkDmmvBozwUQ
        oX4R54Bu/1IjZ26p0Qrwbt7IqkCQuznnKI4kEOhsuRcR9bxbYPi72+z57A==
X-Google-Smtp-Source: AGHT+IEAKa3givPPHnhrfDbIYbR1VXdSKKnEcFfUbM/Kc73Tzpk7GZzbgYOESyaV0mQ1MVD9DzJ+cUp0ghti4TF4H/4=
X-Received: by 2002:a05:6122:4b13:b0:496:80b6:2fd1 with SMTP id
 fc19-20020a0561224b1300b0049680b62fd1mr6246903vkb.5.1698649639928; Mon, 30
 Oct 2023 00:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231028164650.4f5ea18a@rorschach.local.home> <CA+G9fYsL=wK_rn8ovCHtn6QXrvzv0a67oj9U3u6r9i-dxjsqwQ@mail.gmail.com>
 <20231029091408.0179cee4@rorschach.local.home>
In-Reply-To: <20231029091408.0179cee4@rorschach.local.home>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 30 Oct 2023 12:37:08 +0530
Message-ID: <CA+G9fYu9GOEbD=rR5eMR-=HJ8H6rMsbzDC2ZY5=Y50WpWAE7_Q@mail.gmail.com>
Subject: Re: [PATCH v2] eventfs: Test for ei->is_freed when accessing ei->dentry
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Naresh Kamboju <naresh.kamboju@linaro.org>, Beau Belgrave
        <beaub@linux.microsoft.com>, Ajay Kaher <akaher@vmware.com>, Andrew
        Morton" <akpm@linux-foundation.org>, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

> Are you sure it was applied correctly?

Please ignore the build warnings / errors it was due to apply patch was
not successful.

> Perhaps check out the branch I
> have and let me know if you get the same errors.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace/core

I have tested the linux-trace.git trace/core and run selftests ftrace
the reported kernel panic [1] & [2] has been fixed but found
"general protection fault"  at  kernel/trace/trace_events.c:2439.

[1] https://lore.kernel.org/all/CA+G9fYt6pY+tMZEOg=SoEywQOe19fGP3uR15SGowkdK+_X85Cg@mail.gmail.com/
[2] https://lore.kernel.org/linux-trace-kernel/20231028164650.4f5ea18a@rorschach.local.home/

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Test log:
==========
kselftest: Running tests in ftrace
TAP version 13
1..1
# timeout set to 0
# selftests: ftrace: ftracetest-ktap

...

# ok 46 Test creation and deletion of trace instances while setting an event
[  332.783872] general protection fault, probably for non-canonical
address 0x6b6b6b6b6b6b6bcb: 0000 [#1] PREEMPT SMP PTI
[  332.794585] CPU: 1 PID: 5165 Comm: ls Not tainted 6.6.0-rc4 #1
[  332.800429] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.7 12/07/2021
[  332.807820] RIP: 0010:event_callback (kernel/trace/trace_events.c:2439)
[ 332.812353] Code: f6 48 c7 c6 09 78 6b a0 41 55 49 89 cd 41 54 49 89
d4 53 48 8b 02 48 89 fb 4c 8b 78 10 e8 10 8b 19 01 85 c0 0f 84 d2 00
00 00 <41> 8b 47 60 a8 08 0f 85 9c 00 00 00 49 8b 47 10 48 83 78 18 00
74
All code
========
   0: f6 48 c7 c6          testb  $0xc6,-0x39(%rax)
   4: 09 78 6b              or     %edi,0x6b(%rax)
   7: a0 41 55 49 89 cd 41 movabs 0x495441cd89495541,%al
   e: 54 49
  10: 89 d4                mov    %edx,%esp
  12: 53                    push   %rbx
  13: 48 8b 02              mov    (%rdx),%rax
  16: 48 89 fb              mov    %rdi,%rbx
  19: 4c 8b 78 10          mov    0x10(%rax),%r15
  1d: e8 10 8b 19 01        callq  0x1198b32
  22: 85 c0                test   %eax,%eax
  24: 0f 84 d2 00 00 00    je     0xfc
  2a:* 41 8b 47 60          mov    0x60(%r15),%eax <-- trapping instruction
  2e: a8 08                test   $0x8,%al
  30: 0f 85 9c 00 00 00    jne    0xd2
  36: 49 8b 47 10          mov    0x10(%r15),%rax
  3a: 48 83 78 18 00        cmpq   $0x0,0x18(%rax)
  3f: 74                    .byte 0x74

Code starting with the faulting instruction
===========================================
   0: 41 8b 47 60          mov    0x60(%r15),%eax
   4: a8 08                test   $0x8,%al
   6: 0f 85 9c 00 00 00    jne    0xa8
   c: 49 8b 47 10          mov    0x10(%r15),%rax
  10: 48 83 78 18 00        cmpq   $0x0,0x18(%rax)
  15: 74                    .byte 0x74
[  332.831089] RSP: 0018:ffffba5700967b50 EFLAGS: 00010202
[  332.836315] RAX: 0000000000000001 RBX: ffffffffa06fb5d7 RCX: ffffba5700967bc8
[  332.843439] RDX: 0000000000000069 RSI: ffffffffa06b7809 RDI: ffffffffa06fb5d7
[  332.850563] RBP: ffffba5700967b78 R08: ffff8dbe12250134 R09: 0000000000000000
[  332.857722] R10: ffff8dbe122500e0 R11: ffff8dbe0d8f8fc8 R12: ffffba5700967bd0
[  332.864846] R13: ffffba5700967bc8 R14: ffffba5700967bc6 R15: 6b6b6b6b6b6b6b6b
[  332.871971] FS:  00007fc5a5062d00(0000) GS:ffff8dc167a80000(0000)
knlGS:0000000000000000
[  332.880057] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  332.885801] CR2: 00007f7f8dc50a1c CR3: 0000000113c84003 CR4: 00000000003706e0
[  332.892928] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  332.900058] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  332.907183] Call Trace:
[  332.909658]  <TASK>
[  332.911760] ? show_regs (arch/x86/kernel/dumpstack.c:479)
[  332.915166] ? die_addr (arch/x86/kernel/dumpstack.c:421
arch/x86/kernel/dumpstack.c:460)
[  332.918486] ? exc_general_protection (arch/x86/kernel/traps.c:697
arch/x86/kernel/traps.c:642)
[  332.923191] ? asm_exc_general_protection
(arch/x86/include/asm/idtentry.h:564)
[  332.928073] ? event_callback (kernel/trace/trace_events.c:2439)
[  332.931996] dcache_dir_open_wrapper (fs/tracefs/event_inode.c:745)
[  332.936636] ? __pfx_dcache_dir_open_wrapper (fs/tracefs/event_inode.c:683)
[  332.941772] do_dentry_open (fs/open.c:929)
[  332.945646] vfs_open (fs/open.c:1064)
[  332.948800] path_openat (fs/namei.c:3639 fs/namei.c:3796)
[  332.952465] ? ___slab_alloc (mm/slub.c:810 mm/slub.c:3265)
[  332.956384] ? nfs_ctx_key_to_expire (fs/nfs/write.c:1281)
[  332.960917] ? trace_preempt_on (kernel/trace/trace_preemptirq.c:105)
[  332.964929] do_filp_open (fs/namei.c:3823)
[  332.968511] do_sys_openat2 (fs/open.c:1422)
[  332.972173] __x64_sys_openat (fs/open.c:1448)
[  332.976014] do_syscall_64 (arch/x86/entry/common.c:50
arch/x86/entry/common.c:80)
[  332.979601] ? trace_hardirqs_on_prepare
(kernel/trace/trace_preemptirq.c:47 (discriminator 16)
kernel/trace/trace_preemptirq.c:42 (discriminator 16))
[  332.984436] ? syscall_exit_to_user_mode (kernel/entry/common.c:299)
[  332.989219] ? do_syscall_64 (arch/x86/entry/common.c:87)
[  332.992964] ? do_syscall_64 (arch/x86/entry/common.c:87)
[  332.996709] ? do_syscall_64 (arch/x86/entry/common.c:87)
[  333.000460] ? do_syscall_64 (arch/x86/entry/common.c:87)
[  333.004204] ? do_syscall_64 (arch/x86/entry/common.c:87)
[  333.007948] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
[  333.012994] RIP: 0033:0x7fc5a51fadf1
[ 333.016600] Code: 44 24 18 31 c0 41 83 e2 40 75 3e 89 f0 25 00 00 41
00 3d 00 00 41 00 74 30 89 f2 b8 01 01 00 00 48 89 fe bf 9c ff ff ff
0f 05 <48> 3d 00 f0 ff ff 77 3f 48 8b 54 24 18 64 48 2b 14 25 28 00 00
00
All code
========
   0: 44 24 18              rex.R and $0x18,%al
   3: 31 c0                xor    %eax,%eax
   5: 41 83 e2 40          and    $0x40,%r10d
   9: 75 3e                jne    0x49
   b: 89 f0                mov    %esi,%eax
   d: 25 00 00 41 00        and    $0x410000,%eax
  12: 3d 00 00 41 00        cmp    $0x410000,%eax
  17: 74 30                je     0x49
  19: 89 f2                mov    %esi,%edx
  1b: b8 01 01 00 00        mov    $0x101,%eax
  20: 48 89 fe              mov    %rdi,%rsi
  23: bf 9c ff ff ff        mov    $0xffffff9c,%edi
  28: 0f 05                syscall
  2a:* 48 3d 00 f0 ff ff    cmp    $0xfffffffffffff000,%rax <--
trapping instruction
  30: 77 3f                ja     0x71
  32: 48 8b 54 24 18        mov    0x18(%rsp),%rdx
  37: 64 48 2b 14 25 28 00 sub    %fs:0x28,%rdx
  3e: 00 00

Code starting with the faulting instruction
===========================================
   0: 48 3d 00 f0 ff ff    cmp    $0xfffffffffffff000,%rax
   6: 77 3f                ja     0x47
   8: 48 8b 54 24 18        mov    0x18(%rsp),%rdx
   d: 64 48 2b 14 25 28 00 sub    %fs:0x28,%rdx
  14: 00 00
[  333.035361] RSP: 002b:00007ffebef93680 EFLAGS: 00000287 ORIG_RAX:
0000000000000101
[  333.042919] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc5a51fadf1
[  333.050042] RDX: 0000000000090800 RSI: 0000562c92f2cc20 RDI: 00000000ffffff9c
[  333.057166] RBP: 0000000000000000 R08: 0000000000000007 R09: 0000562c92f2cc90
[  333.064290] R10: 0000000000000000 R11: 0000000000000287 R12: 00007fc5a5062b98
[  333.071415] R13: 00007ffebef93ad0 R14: 0000562c92f2cc20 R15: 0000562c9122ffc8
[  333.078541]  </TASK>
[  333.080733] Modules linked in: x86_pkg_temp_thermal fuse configfs
ip_tables x_tables [last unloaded: trace_printk]
[  333.091109] ---[ end trace 0000000000000000 ]---
[  333.095757] RIP: 0010:event_callback (kernel/trace/trace_events.c:2439)
[ 333.100295] Code: f6 48 c7 c6 09 78 6b a0 41 55 49 89 cd 41 54 49 89
d4 53 48 8b 02 48 89 fb 4c 8b 78 10 e8 10 8b 19 01 85 c0 0f 84 d2 00
00 00 <41> 8b 47 60 a8 08 0f 85 9c 00 00 00 49 8b 47 10 48 83 78 18 00
74
All code
========
   0: f6 48 c7 c6          testb  $0xc6,-0x39(%rax)
   4: 09 78 6b              or     %edi,0x6b(%rax)
   7: a0 41 55 49 89 cd 41 movabs 0x495441cd89495541,%al
   e: 54 49
  10: 89 d4                mov    %edx,%esp
  12: 53                    push   %rbx
  13: 48 8b 02              mov    (%rdx),%rax
  16: 48 89 fb              mov    %rdi,%rbx
  19: 4c 8b 78 10          mov    0x10(%rax),%r15
  1d: e8 10 8b 19 01        callq  0x1198b32
  22: 85 c0                test   %eax,%eax
  24: 0f 84 d2 00 00 00    je     0xfc
  2a:* 41 8b 47 60          mov    0x60(%r15),%eax <-- trapping instruction
  2e: a8 08                test   $0x8,%al
  30: 0f 85 9c 00 00 00    jne    0xd2
  36: 49 8b 47 10          mov    0x10(%r15),%rax
  3a: 48 83 78 18 00        cmpq   $0x0,0x18(%rax)
  3f: 74                    .byte 0x74

Code starting with the faulting instruction
===========================================
   0: 41 8b 47 60          mov    0x60(%r15),%eax
   4: a8 08                test   $0x8,%al
   6: 0f 85 9c 00 00 00    jne    0xa8
   c: 49 8b 47 10          mov    0x10(%r15),%rax
  10: 48 83 78 18 00        cmpq   $0x0,0x18(%rax)
  15: 74                    .byte 0x74
[  333.119040] RSP: 0018:ffffba5700967b50 EFLAGS: 00010202
[  333.124290] RAX: 0000000000000001 RBX: ffffffffa06fb5d7 RCX: ffffba5700967bc8
[  333.131451] RDX: 0000000000000069 RSI: ffffffffa06b7809 RDI: ffffffffa06fb5d7
[  333.138623] RBP: ffffba5700967b78 R08: ffff8dbe12250134 R09: 0000000000000000
[  333.145811] R10: ffff8dbe122500e0 R11: ffff8dbe0d8f8fc8 R12: ffffba5700967bd0
[  333.152969] R13: ffffba5700967bc8 R14: ffffba5700967bc6 R15: 6b6b6b6b6b6b6b6b
[  333.160127] FS:  00007fc5a5062d00(0000) GS:ffff8dc167a80000(0000)
knlGS:0000000000000000
[  333.168215] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  333.173961] CR2: 00007f7f8dc50a1c CR3: 0000000113c84003 CR4: 00000000003706e0
[  333.181092] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  333.188251] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
# ok 47 Test creation and deletion of trace instances

Log link:
 - https://lkft.validation.linaro.org/scheduler/job/6983932#L1655
 - https://storage.tuxsuite.com/public/linaro/naresh/builds/2XT84xYJIMmKApmqOOtKhnLdCyz/tuxmake_reproducer.sh

metadata:
  git_ref: master
  git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
  git_ref: trace/core
  kernel-config:
    https://storage.tuxsuite.com/public/linaro/naresh/builds/2XT84xYJIMmKApmqOOtKhnLdCyz/config
  artifact-location:
    https://storage.tuxsuite.com/public/linaro/naresh/builds/2XT84xYJIMmKApmqOOtKhnLdCyz/
  toolchain: gcc-13

--
Linaro LKFT
https://lkft.linaro.org


> -- Steve
