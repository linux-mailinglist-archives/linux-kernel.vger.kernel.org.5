Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CF17CB513
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbjJPVKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPVKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:10:10 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23B7A2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:10:07 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53e751aeb3cso4214165a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697490606; x=1698095406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXMjI4MbD4hIed9nKFquFn0Ck/7okOmRfKdgtVaem00=;
        b=RCD1d2Z1lZyBo/UF2vfTntJGDJwccUHJ3twadCJ1td6SquTgM81dLsxiTcqFJmfEei
         fVyPAwHbxoyyV1TrLDIf0kv6RmA+tcB3xmQqim9nvG1WgUcCWNknk6fnYho0qrtyIbH9
         JyG4sWmn+Hd5keOXsdkUAz1AaphHHWQa+hCkJ7YeP1wA0eGuD2HQ2jQ2Ca6xZSYnmxLu
         7URtFlYgNFrHcYftST3R51dMqB1CFmwoOLAniqIFrhz+aKEdJspKsZn/M/CkxCLfff3M
         LTNjmiN9NtxPnR03iR0SX1eeY4NwaG0nWd9AkzQh33XK/CNsjO8HApZhTP9JCmkY4TXG
         4neg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697490606; x=1698095406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sXMjI4MbD4hIed9nKFquFn0Ck/7okOmRfKdgtVaem00=;
        b=Vg/4dYWpCVVuRm05goC8Wu2U31OjkElknzBhtFiWOpWsiDiFMNKyh2Jme7BZbgWWa4
         xsfbmZA+oauR9hzicI0VXqTAGbyImPavqD0WsW+M+rZTklc0gl4O2tlDk7NPMJ/GG7D9
         k74DSleH7R/HwO4KBwbq46tMI2jAA9JAk6DwkMTqexXygbNj3xI9RYxwX2c/JzvHRCYX
         Tt3MzSwAMqhvsHiGDlE8xK2ptAZwNO65SgGDFfYrzfm4FqR6mqtr2XWOn5zniDUcNLh4
         mbYJVv21r1S1e8hFBADzusd90rgQWjoiuMi+HDuL8q3ExwgN35+P6SIRicz5PdUO3vay
         r82A==
X-Gm-Message-State: AOJu0Yy9G8Pc7VhsIVU9+V/0ZfG6VordFqstwZ0dLbS3WIWc2vmi6DGr
        Jh2XhQQk2jx7ldtVuCENV419ubvxz7+SEKWrzwQ=
X-Google-Smtp-Source: AGHT+IFow45eooZa0sGIfpV+ZbgnP2wDAlZAMTkY8S2J+phl9dVjGolf+t/X2Aky2jhuqhRn3JcGE2CmjMJh5hx2Hms=
X-Received: by 2002:a05:6402:3511:b0:53f:32b:cf3a with SMTP id
 b17-20020a056402351100b0053f032bcf3amr371327edd.16.1697490605929; Mon, 16 Oct
 2023 14:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zjd6idrLXuF59cwKxyd1a--DsiJwGQAKai9Tph30dAow@mail.gmail.com>
In-Reply-To: <CAFULd4Zjd6idrLXuF59cwKxyd1a--DsiJwGQAKai9Tph30dAow@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Mon, 16 Oct 2023 23:09:54 +0200
Message-ID: <CAFULd4bOo-SWm+5R0QhcY7AJJiTnnNPEbjZ6iLQRHMVoA64m0Q@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Nadav Amit <namit@vmware.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 8:52=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Thu, Oct 12, 2023 at 5:19=E2=80=AFPM Nadav Amit <namit@vmware.com> wro=
te:
> >
> >
> > > On Oct 12, 2023, at 12:54 AM, Linus Torvalds <torvalds@linux-foundati=
on.org> wrote:
> > >
> > > !! External Email
> > >
> > > On Wed, 11 Oct 2023 at 14:33, Uros Bizjak <ubizjak@gmail.com> wrote:
> > >>
> > >> Reading the above, it looks to me that we don't want to play games
> > >> with "const aliased" versions of current_task [1], as proposed by
> > >> Nadav in his patch series.
> > >
> > > Well, maybe I'd like it if I saw what the effect of it was, but that
> > > patch mentions "sync_mm_rss()" which doesn't actually exist
> > > (SPLIT_RSS_COUNTING is never defined, the split version is gone and
> > > hasn't existed since commit f1a7941243c1 "mm: convert mm's rss stats
> > > into percpu_counter")
> >
> > So I added a new version of the current aliasing (well, actually pcpu_h=
ot
> > in the new version) on top of Uros=E2=80=99s patches, and the effect ca=
n be seen
> > in many functions. I don=E2=80=99t want to bother with many examples so=
 here is
> > a common and simple one:
> >
> > Currently syscall_exit_work() that starts with:
> >
> >    0xffffffff8111e120 <+0>: push   %rbp
> >    0xffffffff8111e121 <+1>: mov    %rdi,%rbp
> >    0xffffffff8111e124 <+4>: push   %rbx
> >    0xffffffff8111e125 <+5>: mov    %rsi,%rbx
> >    0xffffffff8111e128 <+8>: and    $0x20,%esi
> >    0xffffffff8111e12b <+11>: je     0xffffffff8111e143 <syscall_exit_wo=
rk+35>
> >    0xffffffff8111e12d <+13>: mov    %gs:0x2ac80,%rax
> >    0xffffffff8111e136 <+22>: cmpb   $0x0,0x800(%rax)
> >    0xffffffff8111e13d <+29>: jne    0xffffffff8111e22a <syscall_exit_wo=
rk+266>
> >    0xffffffff8111e143 <+35>: mov    %gs:0x2ac80,%rax
> >    0xffffffff8111e14c <+44>: cmpq   $0x0,0x7c8(%rax)
> >
> > Using the const-alias changes the beginning of syscall_exit_work to:
> >
> >    0xffffffff8111cb80 <+0>: push   %r12
> >    0xffffffff8111cb82 <+2>: mov    %gs:0x7ef0e0f6(%rip),%r12        # 0=
x2ac80 <pcpu_hot>
> >    0xffffffff8111cb8a <+10>: push   %rbp
> >    0xffffffff8111cb8b <+11>: mov    %rdi,%rbp
> >    0xffffffff8111cb8e <+14>: push   %rbx
> >    0xffffffff8111cb8f <+15>: mov    %rsi,%rbx
> >    0xffffffff8111cb92 <+18>: and    $0x20,%esi
> >    0xffffffff8111cb95 <+21>: je     0xffffffff8111cba6 <syscall_exit_wo=
rk+38>
> >    0xffffffff8111cb97 <+23>: cmpb   $0x0,0x800(%r12)
> >    0xffffffff8111cba0 <+32>: jne    0xffffffff8111cc7a <syscall_exit_wo=
rk+250>
> >    0xffffffff8111cba6 <+38>: cmpq   $0x0,0x7c8(%r12)
> >
> > So we both see RIP-relative addressing is being used (hence the instruc=
tion is
> > one byte shorter) and the reload going away.
> >
> > Now, I am not a compiler expert as for the rationale, but it googling a=
round
> > I can see Nick explaining the rationale [1] - if you use =E2=80=9Cp=E2=
=80=9D your read memory.
> > BTW: It is related to discussion you had [2], in which you encountered =
an issue
> > I also encountered before [3]. My bad for pushing it in.
> >
> > Anyhow, I created a similar code on godbolt ( https://godbolt.org/z/dPq=
KKzPs4 )
> > to show this behavior - how compiler barriers cause reload. It seems th=
at this
> > behavior happens on GCC and CLANG on various versions.
> >
> > The idea behind the patch is that it communicates - in the compilation =
unit
> > granularity - that current is fixed. There is an issue of whether it wo=
rks with
> > LTO, which I have never checked.
> >
> >
> > [1] https://reviews.llvm.org/D145416
> > [2] https://lore.kernel.org/lkml/20230306120106.GE1267364@hirez.program=
ming.kicks-ass.net/
> > [3] https://lore.kernel.org/all/20190823224424.15296-5-namit@vmware.com=
/
> >
> > --
> >
> > Here=E2=80=99s the updated patch - but I didn=E2=80=99t really boot a m=
achine with it so new
> > issues might have come since my last patch-set:
>
> Unfortunately, it does not work and dies early in the boot with:
>
> [    4.939358] BUG: kernel NULL pointer dereference, address: 00000000000=
00000
> [    4.940090] #PF: supervisor write access in kernel mode
> [    4.940090] #PF: error_code(0x0002) - not-present page
> [    4.940090] PGD 0 P4D 0
> [    4.940090] Oops: 0002 [#1] PREEMPT SMP PTI
> [    4.940090] CPU: 1 PID: 52 Comm: kworker/u4:1 Not tainted
> 6.6.0-rc6-00365-g0c09c1d70838-dirty #7
> [    4.940090] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.16.2-1.fc37 04/01/2014
> [    4.940090] RIP: 0010:begin_new_exec+0x8f2/0xa30
> [    4.940090] Code: 31 f6 e8 c1 49 f9 ff e9 3c fa ff ff 31 f6 4c 89
> ef e8 b2 4a f9 ff e9 19 fa ff ff 31 f6 4c 89 ef e8 23 4a f9 ff e9 ea
> fa ff ff <f0> 41 ff 0c 24 0f
> 85 55 fb ff ff 4c 89 e7 e8 4b 02 df ff e9 48 fb
> [    4.940090] RSP: 0000:ffff9c84c01e3d68 EFLAGS: 00010246
> [    4.940090] RAX: 0000000000000000 RBX: ffff9946e30c1f00 RCX: 000000000=
0000000
> [    4.940090] RDX: 0000000000000000 RSI: ffff9946e2ff0000 RDI: ffff9946e=
30c2718
> [    4.940090] RBP: ffff9946c03a7c00 R08: 00000000fffffffe R09: 00000000f=
fffffff
> [    4.940090] R10: 000001ffffffffff R11: 0000000000000001 R12: 000000000=
0000000
> [    4.940090] R13: 0000000000000000 R14: ffff9946e30c2718 R15: ffff9946e=
2ff0000
> [    4.940090] FS:  0000000000000000(0000) GS:ffff994763f00000(0000)
> knlGS:0000000000000000
> [    4.940090] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    4.940090] CR2: 0000000000000000 CR3: 00000001003a8000 CR4: 000000000=
00406f0
> [    4.940090] Call Trace:
> [    4.940090]  <TASK>
> [    4.940090]  ? __die+0x1e/0x60
> [    4.940090]  ? page_fault_oops+0x17b/0x470
> [    4.940090]  ? search_module_extables+0x14/0x50
> [    4.940090]  ? exc_page_fault+0x66/0x140
> [    4.940090]  ? asm_exc_page_fault+0x26/0x30
> [    4.940090]  ? begin_new_exec+0x8f2/0xa30
> [    4.940090]  ? begin_new_exec+0x3ce/0xa30
> [    4.940090]  ? load_elf_phdrs+0x67/0xb0
> [    4.940090]  load_elf_binary+0x2bb/0x1770
> [    4.940090]  ? __kernel_read+0x136/0x2d0
> [    4.940090]  bprm_execve+0x277/0x630
> [    4.940090]  kernel_execve+0x145/0x1a0
> [    4.940090]  call_usermodehelper_exec_async+0xcb/0x180
> [    4.940090]  ? __pfx_call_usermodehelper_exec_async+0x10/0x10
> [    4.940090]  ret_from_fork+0x2f/0x50
> [    4.940090]  ? __pfx_call_usermodehelper_exec_async+0x10/0x10
> [    4.940090]  ret_from_fork_asm+0x1b/0x30
> [    4.940090]  </TASK>
> [    4.940090] Modules linked in:
> [    4.940090] CR2: 0000000000000000
> [    5.017606] ---[ end trace 0000000000000000 ]---
> [    5.018957] RIP: 0010:begin_new_exec+0x8f2/0xa30
> [    5.020299] Code: 31 f6 e8 c1 49 f9 ff e9 3c fa ff ff 31 f6 4c 89
> ef e8 b2 4a f9 ff e9 19 fa ff ff 31 f6 4c 89 ef e8 23 4a f9 ff e9 ea
> fa ff ff <f0> 41 ff 0c 24 0f 85 55 fb ff ff 4c 89 e7 e8 4b 02 df ff e9
> 48 fb
> [    5.024765] RSP: 0000:ffff9c84c01e3d68 EFLAGS: 00010246
> [    5.026150] RAX: 0000000000000000 RBX: ffff9946e30c1f00 RCX: 000000000=
0000000
> [    5.027916] RDX: 0000000000000000 RSI: ffff9946e2ff0000 RDI: ffff9946e=
30c2718
> [    5.029714] RBP: ffff9946c03a7c00 R08: 00000000fffffffe R09: 00000000f=
fffffff
> [    5.031461] R10: 000001ffffffffff R11: 0000000000000001 R12: 000000000=
0000000
> [    5.033186] R13: 0000000000000000 R14: ffff9946e30c2718 R15: ffff9946e=
2ff0000
> [    5.034908] FS:  0000000000000000(0000) GS:ffff994763f00000(0000)
> knlGS:0000000000000000
> [    5.036907] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    5.038341] CR2: 0000000000000000 CR3: 00000001003a8000 CR4: 000000000=
00406f0
> [    5.040044] Kernel panic - not syncing: Fatal exception
> [    5.040647] Kernel Offset: 0x22e00000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>
> It looks that aliasing a structure from another namespace is a no-go,
> since the patch (attached, slightly changed your patch) without
> __percpu_seg_override decorations bootstraps OK. The working patch
> (without __percpu_seg_override) is not effective (no effect in
> syscall_exit_work) and increases the number of current_task reads from
> 3841 to 4711.

Forgot to say that the "nonworking" patch reduces the number of
current_task reads to 3221.

+#ifdef CONFIG_USE_X86_SEG_SUPPORT
+static __always_inline struct task_struct *get_current(void)
+{
+ return this_cpu_read_const(const_pcpu_hot.current_task);
+}

FWIW, const_pcpu_hot is in __seg_gs space when decorated with
__percpu_seg_override, so plain "return const_pcpu_hot.current_task;"
would work here, too.

Uros.
