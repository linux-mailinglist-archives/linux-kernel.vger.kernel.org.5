Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694877CB304
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjJPSxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjJPSxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:53:02 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24CD95
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 11:52:59 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so8546776a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 11:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697482378; x=1698087178; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O/7GKyoSaZZps/PS25GGbSznnILHH4N43zSM/IjAmvg=;
        b=eVkEf2+OrzHGa8Jrj+YxZ2gtiS2RjvAmiPtlUc3Oet6uFByhjE7qJAYO7U2dANvsme
         OJUzuuCLJgSYEm1SJRZFkkIS0wZxewROzvQneqiQqlYXRYdthxONpoM39f3xicQtCS2D
         IbvvLT9Tq/+eo3mbNCpCqqLyhDcQxcFenbW0yxmC82W/+ntJzRbwR4RAnIZRoEBn55To
         J36BE0gBigC4pP7/POXOqsXffC4uXHnXYKe1CkIHOYGax+Ueqou7h8oURwT1G1jMzURz
         rOIJ9B/jdpZH/3XBB8PeCo5nn3NGHzM1MIQ0BdHv3L3Kk10vqdKKvk20vjpjTwR1hmi4
         p9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697482378; x=1698087178;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/7GKyoSaZZps/PS25GGbSznnILHH4N43zSM/IjAmvg=;
        b=HjLmvIsnNdHJyrpfEoVMumlAkkTNUauGkjSt7qM10Gn1s+JzxSRZJdRvG+1AsKAMD0
         CDtwNDCqOwNy/XI3atjFSJWJ+Cq4CMWiKFiX/iMZ+qPd5DOM0YJ0BCSqz9PLu7TZKQ5S
         xJcGYLh23m4iFKmBAh+J+DxpFAovPAH+Hvd7VYW4smMTTCRRZ2PwMUHCiAXJ3Od8zhjm
         4Yw/d+oIfEOxkRNvghBzdkFPkqbN8QEZ1QdhiGIxk5vrey6CHeyDZi5le8q0E2dydWUP
         lD28ql4Huyak9oHgAOTM1cgwvhHp+jIh1AbxJUyN67ohl/c6qMjoFUzYF2Asm1runN/A
         bxJw==
X-Gm-Message-State: AOJu0YyLYF6vcbnLVqGeHKorbZSrbJ7G7/p7BIUfzzFRrw96zEaksTAd
        lCRMcY1unxcRBelfSCsqB8dpakorzAOz+DfSi+s=
X-Google-Smtp-Source: AGHT+IGPlSfsCPrH74PlrvHKOF6TvAMxTo/0oDACUt4i5ld3l4q9sFpDqUj14hzCI3icrTZg8Xk6Wlid3P+YaoI7vxM=
X-Received: by 2002:a05:6402:270f:b0:53e:7a2d:a4a2 with SMTP id
 y15-20020a056402270f00b0053e7a2da4a2mr60665edd.39.1697482378080; Mon, 16 Oct
 2023 11:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com> <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com>
In-Reply-To: <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Mon, 16 Oct 2023 20:52:46 +0200
Message-ID: <CAFULd4Zjd6idrLXuF59cwKxyd1a--DsiJwGQAKai9Tph30dAow@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="000000000000288d130607d9eabf"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000288d130607d9eabf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 5:19=E2=80=AFPM Nadav Amit <namit@vmware.com> wrote=
:
>
>
> > On Oct 12, 2023, at 12:54 AM, Linus Torvalds <torvalds@linux-foundation=
.org> wrote:
> >
> > !! External Email
> >
> > On Wed, 11 Oct 2023 at 14:33, Uros Bizjak <ubizjak@gmail.com> wrote:
> >>
> >> Reading the above, it looks to me that we don't want to play games
> >> with "const aliased" versions of current_task [1], as proposed by
> >> Nadav in his patch series.
> >
> > Well, maybe I'd like it if I saw what the effect of it was, but that
> > patch mentions "sync_mm_rss()" which doesn't actually exist
> > (SPLIT_RSS_COUNTING is never defined, the split version is gone and
> > hasn't existed since commit f1a7941243c1 "mm: convert mm's rss stats
> > into percpu_counter")
>
> So I added a new version of the current aliasing (well, actually pcpu_hot
> in the new version) on top of Uros=E2=80=99s patches, and the effect can =
be seen
> in many functions. I don=E2=80=99t want to bother with many examples so h=
ere is
> a common and simple one:
>
> Currently syscall_exit_work() that starts with:
>
>    0xffffffff8111e120 <+0>: push   %rbp
>    0xffffffff8111e121 <+1>: mov    %rdi,%rbp
>    0xffffffff8111e124 <+4>: push   %rbx
>    0xffffffff8111e125 <+5>: mov    %rsi,%rbx
>    0xffffffff8111e128 <+8>: and    $0x20,%esi
>    0xffffffff8111e12b <+11>: je     0xffffffff8111e143 <syscall_exit_work=
+35>
>    0xffffffff8111e12d <+13>: mov    %gs:0x2ac80,%rax
>    0xffffffff8111e136 <+22>: cmpb   $0x0,0x800(%rax)
>    0xffffffff8111e13d <+29>: jne    0xffffffff8111e22a <syscall_exit_work=
+266>
>    0xffffffff8111e143 <+35>: mov    %gs:0x2ac80,%rax
>    0xffffffff8111e14c <+44>: cmpq   $0x0,0x7c8(%rax)
>
> Using the const-alias changes the beginning of syscall_exit_work to:
>
>    0xffffffff8111cb80 <+0>: push   %r12
>    0xffffffff8111cb82 <+2>: mov    %gs:0x7ef0e0f6(%rip),%r12        # 0x2=
ac80 <pcpu_hot>
>    0xffffffff8111cb8a <+10>: push   %rbp
>    0xffffffff8111cb8b <+11>: mov    %rdi,%rbp
>    0xffffffff8111cb8e <+14>: push   %rbx
>    0xffffffff8111cb8f <+15>: mov    %rsi,%rbx
>    0xffffffff8111cb92 <+18>: and    $0x20,%esi
>    0xffffffff8111cb95 <+21>: je     0xffffffff8111cba6 <syscall_exit_work=
+38>
>    0xffffffff8111cb97 <+23>: cmpb   $0x0,0x800(%r12)
>    0xffffffff8111cba0 <+32>: jne    0xffffffff8111cc7a <syscall_exit_work=
+250>
>    0xffffffff8111cba6 <+38>: cmpq   $0x0,0x7c8(%r12)
>
> So we both see RIP-relative addressing is being used (hence the instructi=
on is
> one byte shorter) and the reload going away.
>
> Now, I am not a compiler expert as for the rationale, but it googling aro=
und
> I can see Nick explaining the rationale [1] - if you use =E2=80=9Cp=E2=80=
=9D your read memory.
> BTW: It is related to discussion you had [2], in which you encountered an=
 issue
> I also encountered before [3]. My bad for pushing it in.
>
> Anyhow, I created a similar code on godbolt ( https://godbolt.org/z/dPqKK=
zPs4 )
> to show this behavior - how compiler barriers cause reload. It seems that=
 this
> behavior happens on GCC and CLANG on various versions.
>
> The idea behind the patch is that it communicates - in the compilation un=
it
> granularity - that current is fixed. There is an issue of whether it work=
s with
> LTO, which I have never checked.
>
>
> [1] https://reviews.llvm.org/D145416
> [2] https://lore.kernel.org/lkml/20230306120106.GE1267364@hirez.programmi=
ng.kicks-ass.net/
> [3] https://lore.kernel.org/all/20190823224424.15296-5-namit@vmware.com/
>
> --
>
> Here=E2=80=99s the updated patch - but I didn=E2=80=99t really boot a mac=
hine with it so new
> issues might have come since my last patch-set:

Unfortunately, it does not work and dies early in the boot with:

[    4.939358] BUG: kernel NULL pointer dereference, address: 0000000000000=
000
[    4.940090] #PF: supervisor write access in kernel mode
[    4.940090] #PF: error_code(0x0002) - not-present page
[    4.940090] PGD 0 P4D 0
[    4.940090] Oops: 0002 [#1] PREEMPT SMP PTI
[    4.940090] CPU: 1 PID: 52 Comm: kworker/u4:1 Not tainted
6.6.0-rc6-00365-g0c09c1d70838-dirty #7
[    4.940090] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.16.2-1.fc37 04/01/2014
[    4.940090] RIP: 0010:begin_new_exec+0x8f2/0xa30
[    4.940090] Code: 31 f6 e8 c1 49 f9 ff e9 3c fa ff ff 31 f6 4c 89
ef e8 b2 4a f9 ff e9 19 fa ff ff 31 f6 4c 89 ef e8 23 4a f9 ff e9 ea
fa ff ff <f0> 41 ff 0c 24 0f
85 55 fb ff ff 4c 89 e7 e8 4b 02 df ff e9 48 fb
[    4.940090] RSP: 0000:ffff9c84c01e3d68 EFLAGS: 00010246
[    4.940090] RAX: 0000000000000000 RBX: ffff9946e30c1f00 RCX: 00000000000=
00000
[    4.940090] RDX: 0000000000000000 RSI: ffff9946e2ff0000 RDI: ffff9946e30=
c2718
[    4.940090] RBP: ffff9946c03a7c00 R08: 00000000fffffffe R09: 00000000fff=
fffff
[    4.940090] R10: 000001ffffffffff R11: 0000000000000001 R12: 00000000000=
00000
[    4.940090] R13: 0000000000000000 R14: ffff9946e30c2718 R15: ffff9946e2f=
f0000
[    4.940090] FS:  0000000000000000(0000) GS:ffff994763f00000(0000)
knlGS:0000000000000000
[    4.940090] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.940090] CR2: 0000000000000000 CR3: 00000001003a8000 CR4: 00000000000=
406f0
[    4.940090] Call Trace:
[    4.940090]  <TASK>
[    4.940090]  ? __die+0x1e/0x60
[    4.940090]  ? page_fault_oops+0x17b/0x470
[    4.940090]  ? search_module_extables+0x14/0x50
[    4.940090]  ? exc_page_fault+0x66/0x140
[    4.940090]  ? asm_exc_page_fault+0x26/0x30
[    4.940090]  ? begin_new_exec+0x8f2/0xa30
[    4.940090]  ? begin_new_exec+0x3ce/0xa30
[    4.940090]  ? load_elf_phdrs+0x67/0xb0
[    4.940090]  load_elf_binary+0x2bb/0x1770
[    4.940090]  ? __kernel_read+0x136/0x2d0
[    4.940090]  bprm_execve+0x277/0x630
[    4.940090]  kernel_execve+0x145/0x1a0
[    4.940090]  call_usermodehelper_exec_async+0xcb/0x180
[    4.940090]  ? __pfx_call_usermodehelper_exec_async+0x10/0x10
[    4.940090]  ret_from_fork+0x2f/0x50
[    4.940090]  ? __pfx_call_usermodehelper_exec_async+0x10/0x10
[    4.940090]  ret_from_fork_asm+0x1b/0x30
[    4.940090]  </TASK>
[    4.940090] Modules linked in:
[    4.940090] CR2: 0000000000000000
[    5.017606] ---[ end trace 0000000000000000 ]---
[    5.018957] RIP: 0010:begin_new_exec+0x8f2/0xa30
[    5.020299] Code: 31 f6 e8 c1 49 f9 ff e9 3c fa ff ff 31 f6 4c 89
ef e8 b2 4a f9 ff e9 19 fa ff ff 31 f6 4c 89 ef e8 23 4a f9 ff e9 ea
fa ff ff <f0> 41 ff 0c 24 0f 85 55 fb ff ff 4c 89 e7 e8 4b 02 df ff e9
48 fb
[    5.024765] RSP: 0000:ffff9c84c01e3d68 EFLAGS: 00010246
[    5.026150] RAX: 0000000000000000 RBX: ffff9946e30c1f00 RCX: 00000000000=
00000
[    5.027916] RDX: 0000000000000000 RSI: ffff9946e2ff0000 RDI: ffff9946e30=
c2718
[    5.029714] RBP: ffff9946c03a7c00 R08: 00000000fffffffe R09: 00000000fff=
fffff
[    5.031461] R10: 000001ffffffffff R11: 0000000000000001 R12: 00000000000=
00000
[    5.033186] R13: 0000000000000000 R14: ffff9946e30c2718 R15: ffff9946e2f=
f0000
[    5.034908] FS:  0000000000000000(0000) GS:ffff994763f00000(0000)
knlGS:0000000000000000
[    5.036907] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.038341] CR2: 0000000000000000 CR3: 00000001003a8000 CR4: 00000000000=
406f0
[    5.040044] Kernel panic - not syncing: Fatal exception
[    5.040647] Kernel Offset: 0x22e00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)

It looks that aliasing a structure from another namespace is a no-go,
since the patch (attached, slightly changed your patch) without
__percpu_seg_override decorations bootstraps OK. The working patch
(without __percpu_seg_override) is not effective (no effect in
syscall_exit_work) and increases the number of current_task reads from
3841 to 4711.

Uros.

--000000000000288d130607d9eabf
Content-Type: text/plain; charset="US-ASCII"; name="p.diff.txt"
Content-Disposition: attachment; filename="p.diff.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_lnt8xhik0>
X-Attachment-Id: f_lnt8xhik0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2N1cnJlbnQuaCBiL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL2N1cnJlbnQuaAppbmRleCBhMTE2OGU3YjY5ZTUuLjViNDY1MDVmZjk5ZSAxMDA2
NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vY3VycmVudC5oCisrKyBiL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL2N1cnJlbnQuaApAQCAtMzYsMTAgKzM2LDIzIEBAIHN0YXRpY19hc3NlcnQoc2l6
ZW9mKHN0cnVjdCBwY3B1X2hvdCkgPT0gNjQpOwogCiBERUNMQVJFX1BFUl9DUFVfQUxJR05FRChz
dHJ1Y3QgcGNwdV9ob3QsIHBjcHVfaG90KTsKIAorLyoKKyAqCisgKi8KK0RFQ0xBUkVfUEVSX0NQ
VV9BTElHTkVEKGNvbnN0IHN0cnVjdCBwY3B1X2hvdCBfX3BlcmNwdV9zZWdfb3ZlcnJpZGUsCisJ
CQljb25zdF9wY3B1X2hvdCk7CisKKyNpZmRlZiBDT05GSUdfVVNFX1g4Nl9TRUdfU1VQUE9SVAor
c3RhdGljIF9fYWx3YXlzX2lubGluZSBzdHJ1Y3QgdGFza19zdHJ1Y3QgKmdldF9jdXJyZW50KHZv
aWQpCit7CisJcmV0dXJuIHRoaXNfY3B1X3JlYWRfY29uc3QoY29uc3RfcGNwdV9ob3QuY3VycmVu
dF90YXNrKTsKK30KKyNlbHNlCiBzdGF0aWMgX19hbHdheXNfaW5saW5lIHN0cnVjdCB0YXNrX3N0
cnVjdCAqZ2V0X2N1cnJlbnQodm9pZCkKIHsKIAlyZXR1cm4gdGhpc19jcHVfcmVhZF9zdGFibGUo
cGNwdV9ob3QuY3VycmVudF90YXNrKTsKIH0KKyNlbmRpZgogCiAjZGVmaW5lIGN1cnJlbnQgZ2V0
X2N1cnJlbnQoKQogCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZXJjcHUuaCBi
L2FyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5oCmluZGV4IDU0NzQ2OTAzYjhjMy4uMjY4ZDFj
ZWFhNGIyIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZXJjcHUuaAorKysgYi9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS9wZXJjcHUuaApAQCAtNDUzLDYgKzQ1Myw4IEBAIGRvIHsJCQkJ
CQkJCQlcCiAjZGVmaW5lIHRoaXNfY3B1X3dyaXRlXzgocGNwLCB2YWwpCV9fcmF3X2NwdV93cml0
ZSh2b2xhdGlsZSwgcGNwLCB2YWwpCiAjZW5kaWYKIAorI2RlZmluZSB0aGlzX2NwdV9yZWFkX2Nv
bnN0KHBjcCkJX19yYXdfY3B1X3JlYWQoLCBwY3ApCisKICNlbHNlIC8qIENPTkZJR19VU0VfWDg2
X1NFR19TVVBQT1JUICovCiAKICNkZWZpbmUgcmF3X2NwdV9yZWFkXzEocGNwKQkJcGVyY3B1X2Zy
b21fb3AoMSwgLCAibW92IiwgcGNwKQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9j
b21tb24uYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMKaW5kZXggYjE0ZmM4YzFjOTUz
Li5mMjg0YzA4YWFlY2EgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMK
KysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9jb21tb24uYwpAQCAtMjA1MCw2ICsyMDUwLDEwIEBA
IERFRklORV9QRVJfQ1BVX0FMSUdORUQoc3RydWN0IHBjcHVfaG90LCBwY3B1X2hvdCkgPSB7CiB9
OwogRVhQT1JUX1BFUl9DUFVfU1lNQk9MKHBjcHVfaG90KTsKIAorREVDTEFSRV9QRVJfQ1BVX0FM
SUdORUQoY29uc3Qgc3RydWN0IHBjcHVfaG90IF9fcGVyY3B1X3NlZ19vdmVycmlkZSwKKwkJCWNv
bnN0X3BjcHVfaG90KSBfX2F0dHJpYnV0ZV9fKChhbGlhcygicGNwdV9ob3QiKSkpOworRVhQT1JU
X1BFUl9DUFVfU1lNQk9MKGNvbnN0X3BjcHVfaG90KTsKKwogI2lmZGVmIENPTkZJR19YODZfNjQK
IERFRklORV9QRVJfQ1BVX0ZJUlNUKHN0cnVjdCBmaXhlZF9wZXJjcHVfZGF0YSwKIAkJICAgICBm
aXhlZF9wZXJjcHVfZGF0YSkgX19hbGlnbmVkKFBBR0VfU0laRSkgX192aXNpYmxlOwpkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9jb21waWxlci5oIGIvaW5jbHVkZS9saW51eC9jb21waWxlci5o
CmluZGV4IGQ3Nzc5YTE4YjI0Zi4uYmY5ODE1ZWFmNGFhIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xp
bnV4L2NvbXBpbGVyLmgKKysrIGIvaW5jbHVkZS9saW51eC9jb21waWxlci5oCkBAIC0yMTIsNyAr
MjEyLDcgQEAgdm9pZCBmdHJhY2VfbGlrZWx5X3VwZGF0ZShzdHJ1Y3QgZnRyYWNlX2xpa2VseV9k
YXRhICpmLCBpbnQgdmFsLAogICovCiAjZGVmaW5lIF9fX0FERFJFU1NBQkxFKHN5bSwgX19hdHRy
cykgXAogCXN0YXRpYyB2b2lkICogX191c2VkIF9fYXR0cnMgXAotCQlfX1VOSVFVRV9JRChfX1BB
U1RFKF9fYWRkcmVzc2FibGVfLHN5bSkpID0gKHZvaWQgKikmc3ltOworCV9fVU5JUVVFX0lEKF9f
UEFTVEUoX19hZGRyZXNzYWJsZV8sc3ltKSkgPSAodm9pZCAqKSh1aW50cHRyX3QpJnN5bTsKICNk
ZWZpbmUgX19BRERSRVNTQUJMRShzeW0pIFwKIAlfX19BRERSRVNTQUJMRShzeW0sIF9fc2VjdGlv
bigiLmRpc2NhcmQuYWRkcmVzc2FibGUiKSkKIAo=
--000000000000288d130607d9eabf--
