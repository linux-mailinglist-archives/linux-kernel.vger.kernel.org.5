Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C61D7CE93F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjJRUm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJRUm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:42:57 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73665F7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:42:55 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507a3b8b113so6276858e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697661773; x=1698266573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGOrB8Us1nq+13prI6dQEJa6mUAXJWRLbgqTNy7bc8g=;
        b=jNyP4EZDXprW43nlh/UR+UJRJozBSVrmIdeF9G7nRddzIG91Lz/LsL7mrwmbBEP22C
         NMuOF8cdphQGtJdORzPQW8Nkh5BRDfCw2wIpsdiMzZzwI/t1MTzg1JazahJmPgu4bUgz
         2iIuQ04FvRmC/hVtn8pG8GsEBUtvYDJiZVkViDOa3FjY51nJL9C+eHc+LUpo84iwGEVs
         bhC8ccggmrtLdRnl4+QB6t1gdmRAjVv7H5zVLZldduZI4hCenN9BYZXQinMvG73e4gcj
         DQTAihLT5vk82Sb9KPOp8nLyMmscFhrHbZcmTzJ5XRvR63CX5cPv9wMg4hlRq4GEPnvQ
         wiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697661773; x=1698266573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGOrB8Us1nq+13prI6dQEJa6mUAXJWRLbgqTNy7bc8g=;
        b=u4MABHQF2Y1/VTisOB3x5uG2ncEBGbdLJIA9kxF+JxdLMbNXF3EnbdTfc/KBD0FhCu
         7hNrMN3wNmnIR0L3iIipbo/RU7uw5GyuAP9XPhuptGCgdvQwTD/H5CLvMUyH/tzqxcBa
         +fmAeLMwmoseuXOccptUZ8Y60rFw0BOkNwqheOKbT3QR1565NZJJXMLwnYECA7sUinbK
         NbqWfWQSGW7W1hjB5RyijBIYhRO558N0Fpb9nq9fWpkWay1fgkl3oF4imSKvJTAZiFKD
         7HzGeHuQEANto7aIDIsBaTdZIx59qWGhEgy9jY/PewDti2T4Uj6DlXOFZ6GaCDjLGBqU
         6osQ==
X-Gm-Message-State: AOJu0Yx8fUVKNWjpbUnuV0Wyg/FEkk8qnTVvRWP23M886wrNAhnS8dp0
        7dwZ8OferSW6ZonmgZaNHLFDSJE3p+iQzulEiPM=
X-Google-Smtp-Source: AGHT+IH1WnjRORTUGihuIF1WYaac60UsHMmKzw/YAro1x1gtqmAAu8hzgDxks3LDvxghdvQshN/UhFxBi3eHBXlPR/I=
X-Received: by 2002:ac2:53a4:0:b0:507:a908:4a93 with SMTP id
 j4-20020ac253a4000000b00507a9084a93mr70822lfh.61.1697661773227; Wed, 18 Oct
 2023 13:42:53 -0700 (PDT)
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
 <CAFULd4Zhw=zoDtir03FdPxJD15GZ5N=SV9=4Z45_Q_P9BL1rvQ@mail.gmail.com> <CAHk-=wgoWOcToLYbuL2GccbNXwj_MH-LxmB_7MMjw6uu50k57Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgoWOcToLYbuL2GccbNXwj_MH-LxmB_7MMjw6uu50k57Q@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 18 Oct 2023 22:42:40 +0200
Message-ID: <CAFULd4bK=uw5V96G2+rB_kfGO3b2OKcaYWsDpXFt7FTO2xNnnw@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nadav Amit <namit@vmware.com>,
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

On Wed, Oct 18, 2023 at 10:22=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 18 Oct 2023 at 12:33, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > This pach works for me:
>
> Looks fine.
>
> But you actually bring up another issue:
>
> > BTW: I also don't understand the comment from include/linux/smp.h:
> >
> > /*
> >  * Allow the architecture to differentiate between a stable and unstabl=
e read.
> >  * For example, x86 uses an IRQ-safe asm-volatile read for the unstable=
 but a
> >  * regular asm read for the stable.
>
> I think the comment is badly worded, but I think the issue may actually b=
e real.
>
> One word: rematerialization.
>
> The thing is, turning inline asm accesses to regular compiler loads
> has a *very* bad semantic problem: the compiler may now feel like it
> can not only combine the loads (ok), but also possibly rematerialize
> values by re-doing the loads (NOT OK!).
>
> IOW, the kernel often has very strict requirements of "at most once"
> behavior, because doing two loads might give different results.
>
> The cpu number is a good example of this.
>
> And yes, sometimes we use actual volatile accesses for them
> (READ_ONCE() and WRITE_ONCE()) but those are *horrendous* in general,
> and are much too strict. Not only does gcc generally lose its mind
> when it sees volatile (ie it stops doing various sane combinations
> that would actually be perfectly valid), but it obviously also stops
> doing CSE on the loads (as it has to).
>
> So the "non-volatile asm" has been a great way to get the "at most
> one" behavior: it's safe wrt interrupts changing the value, because
> you will see *one* value, not two. As far as we know, gcc never
> rematerializes the output of an inline asm. So when you use an inline
> asm, you may have the result CSE'd, but you'll never see it generate
> more than *one* copy of the inline asm.
>
> (Of course, as with so much about inline asm, that "knowledge" is not
> necessarily explicitly spelled out anywhere, and it's just "that's how
> it has always worked").
>
> IOW, look at code like the one in swiotlb_pool_find_slots(), which does t=
his:
>
>         int start =3D raw_smp_processor_id() & (pool->nareas - 1);
>
> and the use of 'start' really is meant to be just a good heuristic, in
> that different concurrent CPU's will start looking in different pools.
> So that code is basically "cpu-local by default", but it's purely
> about locality, it's not some kind of correctness issue, and it's not
> necessarily run when the code is *tied* to a particular CPU.
>
> But what *is* important is that 'start' have *one* value, and one
> value only. So look at that loop, which hasically does
>
>         do {
>                   .. use the 'i' based on 'start' ..
>                 if (++i >=3D pool->nareas)
>                         i =3D 0;
>         } while (i !=3D start);
>
> and it is very important indeed that the compiler does *not* think
> "Oh, I can rematerialize the 'start' value".
>
> See what I'm saying? Using 'volatile' for loading the current CPU
> value would be bad for performance for no good reason. But loading it
> multiple times would be a *bug*.
>
> Using inline asm is basically perfect here: the compiler can *combine*
> two inline asms into one, but once we have a value for 'start', it
> won't change, because the compiler is not going to decide "I can drop
> this value, and just re-do the inline asm to rematerialize it".
>
> This all makes me worried about the __seg_fs thing.

Please note that there is a difference between this_*  and raw_*
accessors. this_* has "volatile" qualification, and for sure it won't
ever be rematerialized (this would defeat the purpose of "volatile").
Previously, this_* was defined as asm-volatile, and now it is defined
as a volatile memory access. GCC will disable almost all optimizations
when volatile memory is accessed. IIRC, volatile-asm also won't be
combined, since the compiler does not know about secondary effects of
asm.

Side note: The raw_smp_processor_id() uses this_, so it has volatile
qualification.  Perhaps we can do

+#define __smp_processor_id()   raw_cpu_read(pcpu_hot.cpu_number)

as this seems like the relaxed version of smp_processor_id().

So, guarantees of asm-volatile are the same as guarantees of volatile
memory access.

Uros.
>
> For 'current', this is all perfect. Rematerializing current is
> actually better than spilling and reloading the value.
>
> But for something like raw_smp_processor_id(), rematerializing would
> be a correctness problem, and a really horrible one (because in
> practice, the code would work 99.9999% of the time, and then once in a
> blue moon, it would rematerialize a different value).
>
> See the problem?
>
> I guess we could use the stdatomics to try to explain these issues to
> the compiler, but I don't even know what the C interfaces look like or
> whether they are stable and usable across the range of compilers we
> use.
>
>                Linus
