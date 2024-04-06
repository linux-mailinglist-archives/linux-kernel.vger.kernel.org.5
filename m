Return-Path: <linux-kernel+bounces-133918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3049C89AABD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 14:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9651F219FC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 12:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D272561F;
	Sat,  6 Apr 2024 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IulJYl6T"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD55652
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712406645; cv=none; b=omdGI+znPL2NlXRUeXYlc42kwEnfQg9Scw6c/6DLu7PtoQsWGDLD+GfHE3QyGxf5U2+JKS+XOdCzqpSjh8zPrc5ROuqsML2Uyz8M7xNxIIq/kM6g4wEMVLuxrqHtwI633nSfXgMfs79afL0ceDwGHRdJ0pXReHWBd/HjyOn6TZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712406645; c=relaxed/simple;
	bh=NZj5iiy3z4PFAT+LpVhjkATLvy3m1FXWC4HJtwGQ8Sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6LF3zuMeuxXf5wfIbA2dr1mJKvpAQyPZbVH59tSfTOwhCM0yogk82RGXOssMz7BQiAQblMM0waCPTFCpp9dtfZZ8fq5bhewCCXB6HZ3wafdmyXYyWy+2MlI3K7ReVECBYE7CWhGouI6l2wSU3+4Nl8aEf+VKCmhQYEmDH+0c9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IulJYl6T; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d718efedb2so53101211fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 05:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712406641; x=1713011441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5khUc4+pP3T2YCJkmv/x98K4zoP9YhPJ4PuWSN9uFI=;
        b=IulJYl6TqRtePBEm6XE1+IhtkH2WAlo7Ejh9QCkRG2+6mauB1QTITr3pHV7US61ph2
         YdkOJvFgB1A59CMKtbCyMj73YSW/03OER4wi+GVAmgI1Wy3x6TOm3e8Rx2EliCU4XgMy
         T1qOzGi2iDx5ST+6tq1Oi7ALZqMbI+0Quv0kNSHgpioc2FijN25kn0IDt2U6Zpsy8LXE
         8/ypDNAObKwS26WVL52IgAooaHGtsmP1wSez4m03nZ+XjOTzFZYiuwm4I50tw/xZoCYF
         C1Vj5iSx/p5xEsQYzh3VLzyDgrvPHrhmPba8kauMtCe94mpZdU4uvSxHFnqUu09vbN0u
         qDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712406641; x=1713011441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5khUc4+pP3T2YCJkmv/x98K4zoP9YhPJ4PuWSN9uFI=;
        b=HJxZgYzsAps9F9JwcAgkab2ExWeoRxcar3b+ryK7c+sWYUYBQmV4XLVJHAzeY9JkMF
         460bEOKWVY1gYDkMJu8EU10q0ZothBaS2RM05iwXjMJMoidrIE6XYJFB4J5XR4EY7Hvk
         qD2VIi+LL8SrqruxifEJcNcCsUMmHqXno7WtBeiXP39nixxFF8U/0RMMAbqmxpyPw34k
         YVNjGjrfK/d8K61hcPW1QlwEnm8xLHHs/yJo0S+E/Aipet7yZq6+XlXqIDPdEAnS+BKW
         yjakQhJZh5ri+Ssnm75aJ5qx6ns/b11hP5xi7XZvPS8LUDNJP2Sqi17BeAQXZLhEU0t4
         JEgg==
X-Forwarded-Encrypted: i=1; AJvYcCXKk7c+dkmjDiO+WXma8TjG5yZGkw2lv9/d47aPvJiKfVlLVBSRXR1A1VTK9cErVqHEJvzSsTTbywdYSZWpcXZOQ3ZTkjIsZpkU0tAv
X-Gm-Message-State: AOJu0Yx9GVzqWo2Xi5S2GIlu11iJ0ZPuwMngJzZR0E60PtumSLgOKbuN
	AykhosDuAnZzkFttXv4IRv80vmhO9XQtwStYltwm638F4grZtGFfy0npl64Qt7xPqAAunxpf/6V
	4Btc/roC85qnloOYf9GfPLXx5/FIaJqGQu1h40Q==
X-Google-Smtp-Source: AGHT+IF2pK1ZhuV3VL8eNav7GDdqCkvWQa6RdJjjdi3jPQrSZVLAKAqgbfoC1bOREg038/y2IuNEd7k/c0v2IZQbSvw=
X-Received: by 2002:a05:651c:49d:b0:2d6:f793:3434 with SMTP id
 s29-20020a05651c049d00b002d6f7933434mr3495904ljc.2.1712406640903; Sat, 06 Apr
 2024 05:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whHWjKK1TOMT1XvxFj8e-_uctJnXPxM=SyWHmW63B_EDw@mail.gmail.com>
 <ZhEqW748nht2M4Si@gmail.com>
In-Reply-To: <ZhEqW748nht2M4Si@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 6 Apr 2024 14:30:38 +0200
Message-ID: <CAFULd4bcnEf6MCa1L=hYHHMOP=jB4Bc0Uugugg8xgNogQAU+YA@mail.gmail.com>
Subject: Re: More annoying code generation by clang
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>, 
	"the arch/x86 maintainers" <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 12:56=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> [ I've Cc:-ed a few more people who might be interested in this. ]
> [ Copy of Linus's email below. ]
>
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > So this doesn't really matter in any real life situation, but it
> > really grated on me.
> >
> > Clang has this nasty habit of taking our nice asm constraints, and
> > turning them into worst-case garbage. It's been reported a couple of
> > times where we use "g" to tell the compiler that pretty much any
> > source to the asm works, and then clang takes that to mean "I will
> > take that to use 'memory'" even when that makes no sense what-so-ever.
> >
> > See for example
> >
> >     https://lore.kernel.org/all/CAHk-=3DwgobnShg4c2yyMbk2p=3DU-wmnOmX_0=
=3Db3ZY_479Jjey2xw@mail.gmail.com/
> >
> > where I was ranting about clang just doing pointlessly stupid things.
> >
> > However, I found a case where yes, clang does pointlessly stupid
> > things, but it's at least _partly_ our fault, and gcc can't generate
> > optimal code either.
> >
> > We have this fairly critical code in __fget_files_rcu() to look up a
> > 'struct file *' from an fd, and it does this:
> >
> >                 /* Mask is a 0 for invalid fd's, ~0 for valid ones */
> >                 nospec_mask =3D array_index_mask_nospec(fd, fdt->max_fd=
s);
> >
> > and clang makes a *horrid* mess of it, generating this code:
> >
> >         movl    %edi, %r14d
> >         movq    32(%rbx), %rdx
> >         movl    (%rdx), %eax
> >         movq    %rax, 8(%rsp)
> >         cmpq    8(%rsp), %r14
> >         sbbq    %rcx, %rcx
> >
> > which is just crazy. Notice how it does that "move rax to stack, then
> > do the compare against the stack", instead of just using %rax.
> >
> > In fact, that function shouldn't have a stack frame at all, and the
> > only reason it is generated is because of this whole oddity.
> >
> > All clang's fault, right?
> >
> > Yeah, mostly. But it turns out that what really messes with clangs
> > little head is that the x86 array_index_mask_nospec() function is
> > being a bit annoying.
> >
> > This is what we do:
> >
> >   static __always_inline unsigned long
> > array_index_mask_nospec(unsigned long index,
> >                 unsigned long size)
> >   {
> >         unsigned long mask;
> >
> >         asm volatile ("cmp %1,%2; sbb %0,%0;"
> >                         :"=3Dr" (mask)
> >                         :"g"(size),"r" (index)
> >                         :"cc");
> >         return mask;
> >   }
> >
> > and look at the use again:
> >
> >         nospec_mask =3D array_index_mask_nospec(fd, fdt->max_fds);
> >
> > here all the values are actually 'unsigned int'. So what happens is
> > that clang can't just use the fdt->max_fds value *directly* from
> > memory, because it needs to be expanded from 32-bit to 64-bit because
> > we've made our array_index_mask_nospec() function only work on 64-bit
> > 'unsigned long' values.
> >
> > So it turns out that by massaging this a bit, and making it just be a
> > macro - so that the asm can decide that "I can do this in 32-bit" - I
> > can get clang to generate much better code.
> >
> > Clang still absolutely hates the "g" constraint, so to get clang to
> > really get this right I have to use "ir" instead of "g". Which is
> > wrong. Because gcc does this right, and could use the memory op
> > directly. But even gcc cannot do that with our *current* function,
> > because of that "the memory value is 32-bit, we require a 64-bit
> > value"
> >
> > Anyway, I can get gcc to generate the right code:
> >
> >         movq    32(%r13), %rdx
> >         cmp (%rdx),%ebx
> >         sbb %esi,%esi
> >
> > which is basically the right code for the six crazy instructions clang
> > generates. And if I make the "g" be "ir", I can get clang to generate
> >
> >         movq    32(%rdi), %rcx
> >         movl    (%rcx), %eax
> >         cmpl    %eax, %esi
> >         sbbl    %esi, %esi
> >
> > which is the same thing, but with that (pointless) load to a register.
> >
> > And now clang doesn't generate that stack frame at all.
> >
> > Anyway, this was a long email to explain the odd attached patch.
> >
> > Comments? Note that this patch is *entirely* untested, I have done
> > this purely by looking at the code generation in fs/file.c.

FYI, please note that gcc-12 is able to synthesize carry-flag compares
on its own:

--cut here--
unsigned long foo (unsigned long index, unsigned long size)
{
    return (index <=3D size) ? 0 : -1;
}

extern unsigned int size;

unsigned long bar (unsigned int index)
{
    return (index <=3D size) ? 0 : -1;
}
--cut here--

gcc-12 -O2:

foo:
        cmpq    %rdi, %rsi
        sbbq    %rax, %rax
        ret
bar:
        cmpl    %edi, size(%rip)
        sbbq    %rax, %rax
        ret

Uros.

> >
> >                 Linus
>
> >  arch/x86/include/asm/barrier.h | 23 +++++++++--------------
> >  1 file changed, 9 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barr=
ier.h
> > index 66e57c010392..6159d2cbbfde 100644
> > --- a/arch/x86/include/asm/barrier.h
> > +++ b/arch/x86/include/asm/barrier.h
> > @@ -33,20 +33,15 @@
> >   * Returns:
> >   *     0 - (index < size)
> >   */
> > -static __always_inline unsigned long array_index_mask_nospec(unsigned =
long index,
> > -             unsigned long size)
> > -{
> > -     unsigned long mask;
> > -
> > -     asm volatile ("cmp %1,%2; sbb %0,%0;"
> > -                     :"=3Dr" (mask)
> > -                     :"g"(size),"r" (index)
> > -                     :"cc");
> > -     return mask;
> > -}
> > -
> > -/* Override the default implementation from linux/nospec.h. */
> > -#define array_index_mask_nospec array_index_mask_nospec
> > +#define array_index_mask_nospec(idx,sz) ({   \
> > +     typeof((idx)+(sz)) __idx =3D (idx);       \
> > +     typeof(__idx) __sz =3D (sz);              \
> > +     typeof(__idx) __mask;                   \
> > +     asm volatile ("cmp %1,%2; sbb %0,%0"    \
> > +                     :"=3Dr" (__mask)          \
> > +                     :"ir"(__sz),"r" (__idx) \
> > +                     :"cc");                 \
> > +     __mask; })
> >
> >  /* Prevent speculative execution past this barrier. */
> >  #define barrier_nospec() asm volatile("lfence":::"memory")
>

