Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EA57CF0A1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjJSHEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjJSHEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:04:46 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7CDAB
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:04:44 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5079eed8bfbso7944181e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697699082; x=1698303882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUIIIoerH1i4mnw2NPc9E8qSKzZJ1en6MDW5BDML+YI=;
        b=WDSmzP9tTsp358/RchfD4BDQ7zMnHAHNfpFfDu7CqCuFzYhsO1YWqKyjcLHMHUWZBp
         Ysdyt6k3IFovYnYAqY+AOrFf9QpWLjaf3B6gPPUvncG2Afek+1DckQh2JG/m25dYca9d
         h3ED8cY5bZsz9zhrh8R0dJb4NwnehB6kWbwkJwMxEMgjwcmz2izqkq9opLXJeKQeaJRn
         3WzeSY6LxxjIHLUzOmDk134nt1nX9oO8dP5G2HlaEy4Hiy8xlDXQJs+e9eMJ45HC7YnR
         fmkSswompkxgi1pJFRuqD6ym614f2Br6X9byVItXtB+1SFyCVMFmZLeNdulGnNAfdZLz
         q4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697699082; x=1698303882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUIIIoerH1i4mnw2NPc9E8qSKzZJ1en6MDW5BDML+YI=;
        b=r82UoDrkzyJm8zBjkBmz62J21j/HOOdMo/8C8zT1QyLy8mJs/V2P3MA70UjuIXdTLI
         Gi7z/mZ8aO8kUPwYRYwk2GxnSyM4oM4UHhYjHBiNoRRHnVoTIDhXA+MmM2tLcX8fJ+WU
         exnCU7W0jVA2khy2x7y/M1C5zk56Ihkgrwg3nYPhZfjhTFxm0qWMA6CX7OZUwItjMeMX
         Y18JTz8lp32ju6HV1F2vMezLnfxrnR/YsslFFXuIKM9RK3+tn78ziJpaSJNzQcoLIgFl
         otfwe1WusxBPhsSbKaj6XcMztD5lunoLuqHpf+0Mr9F4zIa6wyhpUMo0owFyfImVTVIa
         zrPA==
X-Gm-Message-State: AOJu0YwFzyh+FIVYvCgtHKPAr3Co05cieSD5ixmI6Ug58WNh3EIV0YTB
        D0EamJ77EEzS09eYcUm1xIARaYJ1mawIQKJXaOk=
X-Google-Smtp-Source: AGHT+IFTIxJWsm5ljNzh1aSZKBxK6bHPdXMxTYi3HGC3xJ6awinKB4Y2BGCBEb35NWdrIWYYMYi/lWb857du7mfyGTs=
X-Received: by 2002:ac2:54af:0:b0:502:9fce:b6cc with SMTP id
 w15-20020ac254af000000b005029fceb6ccmr789774lfk.11.1697699082089; Thu, 19 Oct
 2023 00:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zjd6idrLXuF59cwKxyd1a--DsiJwGQAKai9Tph30dAow@mail.gmail.com>
 <CAHk-=wgSsfo89ESHcngvPCkQSh_YAJG-0g7fupb+Uv0E1d_EcQ@mail.gmail.com>
 <7D77A452-E61E-4B8B-B49C-949E1C8E257C@vmware.com> <CAHk-=wj1dLFkL9Qv2vtk0O8Q6WE-11Jq3KucZoz2Kkw59LAexw@mail.gmail.com>
 <9F926586-20D9-4979-AB7A-71124BBAABD3@vmware.com> <CAHk-=wi7YKPKKZw5SpA9gZcf4paG4pZ2kUM50g-LQmdF0g6vWg@mail.gmail.com>
 <CAFULd4bpHkNzCzKed23mTTBWRyhPnOm91f+F6UE413VK+oFtMQ@mail.gmail.com>
 <CAFULd4Z-q4Ot6iyOLo7DkjE=dY3RHXUV+yx6R0iWk=-tZ6ufhQ@mail.gmail.com>
 <CAHk-=wjSnECwAe+Bi0PD6uods3ZDs8up5OAy-qZKF5OgPLpDiA@mail.gmail.com>
 <CAFULd4bLEU-tBC8dO1wf66UAxQ2d1HxQ=D6wvtHZfdQCKhnpkw@mail.gmail.com>
 <CAFULd4YAFTFqon3ojv7N6h=G_1pAjSH3T6YvX0G=g7Fwh7j1jQ@mail.gmail.com>
 <A2E458DE-8B84-4FB2-BF6D-3EAB2B355078@vmware.com> <CAFULd4b_PdKb=8U5+Zz-XNoYdULtcQJnmf-yCrpCv7RRogSXyQ@mail.gmail.com>
 <CAFULd4Y8_MOMGcatcMuUaC89zX5F-VYr0niiJ9Yd8hQ16neHjw@mail.gmail.com>
 <3F9D776E-AD7E-4814-9E3C-508550AD9287@vmware.com> <CAFULd4Zruoq4b5imt3NfN4D+0RY2-i==KGAwUHR8JD0T8=HJBw@mail.gmail.com>
 <28B9471C-4FB0-4AB0-81DD-4885C3645E95@vmware.com> <CAHk-=whS8-Lk_=mFp=mr-JrbRYtScgz-4s_GLAOQGafa_3zP9g@mail.gmail.com>
 <CAFULd4Yy-v40tK94rexSOL99FGMke2Jk42wgcjoEBxV=2hXoCw@mail.gmail.com>
 <CAHk-=wjrLoy6xEDXB=piEUagDLMmV5Up7UK75W1D0E0UFVO-iA@mail.gmail.com>
 <CAFULd4autFT=96EckL9vUDgO5t0ESp27+NDVXQHGi7N=PAo-HQ@mail.gmail.com>
 <CAFULd4Zhw=zoDtir03FdPxJD15GZ5N=SV9=4Z45_Q_P9BL1rvQ@mail.gmail.com>
 <CAHk-=wgoWOcToLYbuL2GccbNXwj_MH-LxmB_7MMjw6uu50k57Q@mail.gmail.com>
 <CAHk-=wgCPbkf0Kdi=4T3LAVvNEH0jxJBWcTiBkrFDBsxkC9mKQ@mail.gmail.com>
 <CAFULd4aTY002A7NHRCX21aTpYOE=tnpouBk6hkoeWND=LnT4ww@mail.gmail.com>
 <CAHk-=wia9vFmyCJPkYg0vvegF8eojLy+DxVtpfoDv-UHoWKfqQ@mail.gmail.com>
 <CAFULd4Zj5hTvATZUVYhUGrxH3fiAUWjO9C27UV_USf2H164thQ@mail.gmail.com> <CAHk-=whEc2HR3En32uyAufPM3tEh8J4+dot6JyGW=Eg5SEhx7A@mail.gmail.com>
In-Reply-To: <CAHk-=whEc2HR3En32uyAufPM3tEh8J4+dot6JyGW=Eg5SEhx7A@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 19 Oct 2023 09:04:30 +0200
Message-ID: <CAFULd4avm_TaEoRauohRc90SUrx-D+wBJvg+htQDQ1_N=zNemw@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     peterz@infradead.org, Nadav Amit <namit@vmware.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 12:40=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 18 Oct 2023 at 14:40, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > The ones in "raw" form are not IRQ safe and these are implemented
> > without volatile qualifier.
>
> You are misreading it.
>
> Both *are* irq safe - on x86.
>
> The difference between "this_cpu_xyz()" and "raw_cpu_xyz()" is that on
> *other* architectures, "raw_cpu_xyz():" can be a lot more efficient,
> because other architectures may need to do extra work to make the
> "this" version be atomic on a particular CPU.
>
> See for example __count_vm_event() vs count_vm_event().
>
> In fact, that particular use isn't even in an interrupt-safe context,
> that's an example of literally "I'd rather be fast that correct for
> certain statistics that aren't all that important".
>
> They two versions generate the same code on x86, but on other
> architectures, __count_vm_event() can *much* simpler and faster
> because it doesn't disable interrupts or do other special things.
>
> But on x86, the whole "interrupt safety" is a complete red herring.
> Both of them generate the exact same instruction.
>
> On x86, the "volatile" is actually for a completely different reason:
> to avoid too much CSE by the compiler.

Let me explain how the compiler handles volatile. Basically, it
disables most of the optimizations when volatile is encountered, be it
on volatile asm or volatile memory access. It is important that
argument propagation is NOT disabled with volatile memory, so the
compiler can still propagate arguments into the following instruction,
as long as no memory access is crossed. This is all that [1]
implements, while keeping volatile around.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=
=3Dx86/percpu&id=3Dca4256348660cb2162668ec3d13d1f921d05374a

Remark: You raised a question on why "testl $0xf0000,%gs:0x0(%rip)"
was not optimized to testb - because of volatile access on memory, the
compiler won't shrink memory read.

The compiler won't CSE volatile-asm or volatile reads, so the number
of memory accesses stay the same. This is an important property,
promised by this_* API, and this_* should be used almost everywhere
because of this property.

raw_* is a relaxed version that allows CSE of asm and memory accesses.
The number of memory accesses can change, and additionally, it *can*
rematerialize arguments from memory [2].

[2] If there is an instruction that uses all registers in between the
load from memory and the insn that uses the loaded value, then the
compiler will try to accommodate the instruction by pushing all active
registers to the stack (stack is owned by the compiler). Instead of
pushing and popping the register with a loaded value, it can read it
from the original non-volatile location as well. If the location is
qualified as volatile, this optimization is off.

This is the rematerialization that you are worrying about. As well as
CSE, it can be allowed under special conditions, in a section, where
it is *guaranteed* that the value in memory won't change in the whole
section. This can be guaranteed in a (kind of) critical section (e.g.
when interrupts are disabled), otherwise the rematerialized value can
differ, because some interrupt handler changed value in memory. Also,
the opposite is true, we will miss the changed value when the read is
CSE'd.

That means, that even when the instruction is the same (and IRQ safe),
"volatile" inhibits unwanted optimisations, and should be there
because of the compiler, to guarantee the access to memory. Since RMW
asms are accessing memory, they should be volatile, too for
non-relaxed versions.

Following with the raw_* issue: These are relaxed versions that
require stable operands, in a section, marked with some barriers (so,
critical section). Those barriers (e.g. volatile asm memory clobber)
will prevent scheduling of memory accesses outside this critical
section, and memory operand stability will be achieved by e.g.
disabling interrupts. Since the user *guarantees* memory stability,
the compiler can relax its CSE and rematerialization requirement *for
this section*. Accessors that are implemented without "volatile"
communicate this relaxation to the compiler.

The above also means that when raw_* versions are used on non-stable
operands, it is the user's fault to use it at the first place, not the
compiler's. raw_ versions should be used with great care.

To illustrate the above, let's look at the "xchg" RMW implementation.
The this_* one is interrupt safe in the sense that it is implemented
with cmpxchg operation that is atomic w.r.t interrupts (that can
change contents of the memory) [note, this is not "locked", and does
not have full atomic property], but raw_* is implemented simply by
raw_ reads and writes. In the raw_ case, we don't care what happens
with memory accesses, because they are required to be stable in the
section where raw_xchg is used.

Then we have this_cpu_read_stable that has even stricter requirements
on operand stability. It can be considered as a constant memory, and
now we have the means to communicate this to the compiler.

[Side note: this_cpu_read_stable is a misnomer. It should be named
raw_cpu_read_stable to reflect the operand stability, required by raw_
versions.

From the compiler standpoint, "volatiles" are not optional, they
communicate operand stability state to the compiler. I have reviewed
percpu.h many times, and the current state of operations is correct,
even if they result in the same instruction.

BTW: About that raw_smp_processor_id():

The raw_ version should stay defined as
this_cpu_read(pcpu_hot.cpu_number), while __smp_processor_id() can be
redefined to raw_cpu_read. Please note the usage in
include/linux/smp.h:

#define get_cpu() ({ preempt_disable(); __smp_processor_id(); })
#define put_cpu() preempt_enable()

where preempt_disable and preempt_enable mark the boundaries of the
critical section.

Uros.

> See  commit b59167ac7baf ("x86/percpu: Fix this_cpu_read()").
>
> In fact, that commit went overboard, and just added "volatile" to
> *every* percpu read.
>
> So then people complained about *that*, and PeterZ did commit
> 0b9ccc0a9b14 ("x86/percpu: Differentiate this_cpu_{}() and
> __this_cpu_{}()"), which basically made that "qual or not" be a macro
> choice.
>
> And in the process, it now got added to all the RMW ops, that didn't
> actually need it or want it in the first place, since they won't be
> CSE'd, since they depend on the input.
>
> So that commit basically generalized the whole thing entirely
> pointlessly, and caused your current confusion.
>
> End result: we should remove 'volatile' from the RMW ops. It doesn't
> do anything on x86. All it does is make us have two subtly different
> versions that we don't care about the difference.
>
> End result two: we should make it clear that "this_cpu_read()" vs
> "raw_cpu_read()" are *NOT* about interrupts. Even on architectures
> where the RMW ops need to have irq protection (so that they are atomic
> wrt interrupts also modifying the value), the *READ* operation
> obviously has no such issue.
>
> For the raw_cpu_read() vs this_cpu_read() case, the only issue is
> whether you can CSE the result.
>
> And in 99% of all cases, you can - and want to - CSE it. But as that
> commit b59167ac7baf shows, sometimes you cannot.
>
> Side note: the code that caused that problem is this:
>
>   __always_inline void __cyc2ns_read(struct cyc2ns_data *data)
>   {
>         int seq, idx;
>
>         do {
>                 seq =3D this_cpu_read(cyc2ns.seq.seqcount.sequence);
>                 ...
>         } while (unlikely(seq !=3D this_cpu_read(cyc2ns.seq.seqcount.sequ=
ence)));
>   }
>
> where the issue is that the this_cpu_read() of that sequence number
> needs to be ordered.
>
> Honestly, that code is just buggy and bad.  We should never have
> "fixed" it by changing the semantics of this_cpu_read() in the first
> place.
>
> The problem is that it re-implements its own locking model, and as so
> often happens when people do that, they do it completely wrongly.
>
> Look at the *REAL* sequence counter code in <linux/seqlock.h>. Notice
> how in raw_read_seqcount_begin() we have
>
>         unsigned _seq =3D __read_seqcount_begin(s);
>         smp_rmb();
>
> because it actually does the proper barriers. Notice how the garbage
> code in __cyc2ns_read() doesn't have them - and how it was buggy as a
> result.
>
> (Also notice how this all predates our "we should use load_acquire()
> instead of smb_rmb()", but whatever).
>
> IOW, all the "volatiles" in the x86 <asm/percpu.h> file are LITERAL
> GARBAGE and should not exist, and are due to a historical mistake.
>
>                    Linus
