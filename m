Return-Path: <linux-kernel+bounces-48870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F2E84628F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C50282272
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8EC3D0A6;
	Thu,  1 Feb 2024 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/BpHNqb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60A83CF5B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706822609; cv=none; b=atxifLChwmwKP6Bl1hu7/4zTkcKegH9BkFGZKFYPt52N2LudJGZJG4Q622KMxniU6aUisJoEXfNbD4+5Otc8DtMdH7cwuYo8nuBNDWPCpoLhCIV6YKCiij6KayEzKKZh7+r6t7fB1+HEzt5p5VvC40WrgjTCbA6erdZpVmXa+K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706822609; c=relaxed/simple;
	bh=ZcunaL1yoCmt48J39Ha/xPDrAiNz5+cKs3Rnm90zY7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ccow6RT4Cy9N3yyTKbQ2/pKdky4Dzi3rihmX/x/dTOBf83hJPKOcvsDnZGN2Pkl87pi+ZHHsEJQNicb6/szbcGBwzkS+yyRlvygiNRG//qd2P+iv+1mvxby3MwXcK4VSvwUCEr6NDBXUngvtlBpDrR8P4S6QwTZtngD2ki420cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/BpHNqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85975C433F1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 21:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706822609;
	bh=ZcunaL1yoCmt48J39Ha/xPDrAiNz5+cKs3Rnm90zY7M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S/BpHNqblWaRhx90KNyeNFlVGLa0cj4kXx/bjWYOrygfg+XZSZBgZ+TQled3DDN8k
	 5fBqZLnZ3AByYtwzsZa6KAi97cjrKJgi7+DekFMY1M0Pz3+VQcsWoM8BgBE2gc/ThY
	 idbZjwMIsHj1KjFg3Z0BWL4zYkkMd9yx0rrdpmcndNfL70pjXoeRQ7VhIrn+In3LKt
	 N+xTr8naofzYHxD499dd5kZYf7tEcjkrVyJjq9fibJCESfjHyFENPJYD95VV9C2mRJ
	 GN4bFIoLafqPeuwHhQrGAhlGiVKEsRLCj4ilaWJySHm+7h1wE75N3ZpeCQo+waiw6q
	 Pd5tYHu7XUeTA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-510faac8c57so112601e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 13:23:29 -0800 (PST)
X-Gm-Message-State: AOJu0YzuZrGQQkBOqKN0h3tHBXnkasmFzCwRpeOslOGIETn0bFcIVhcl
	OaWGqHaRrMnENkGkegWbH2mMBYjyy8mKPjJuPrJjOMY819Fl1lrwdr1T5RllLcvEwz1eb0GhEN9
	2JQ2UWAIHTJ0ovt9+6EMMkQpyQZk=
X-Google-Smtp-Source: AGHT+IFEPB62VOueL7vrfx4d/oxqX5tilU6CTrJ/QRspYE4N8rZrwDP6B1r2Dl8/FMy5zuaK52Yy/Gnioy8b4HAr/io=
X-Received: by 2002:a19:4342:0:b0:510:1590:a193 with SMTP id
 m2-20020a194342000000b005101590a193mr73223lfj.30.1706822607616; Thu, 01 Feb
 2024 13:23:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131065322.1126831-1-maskray@google.com> <CAMj1kXGzADFWa7RmXyjWpCnQ=9hhz6i-XkN4PS1CboZ-kFL8dQ@mail.gmail.com>
 <ZbpEnDK3U/O24ng0@e133380.arm.com> <20240201045551.ajg4iqcajyowl2rh@google.com>
 <CAMj1kXEBjumu3VUySg1cQ+SYm4MugJ5f6pd1f7C0XrLyOWAoOw@mail.gmail.com>
 <20240201091120.pbgr7ng6t2c36fut@google.com> <ZbuFWSRBntgm2ukJ@e133380.arm.com>
 <CAMj1kXGu76WHY8=Y-KhCxBq3xeHeCYQ9syqViSr9VRkjgWQ3BQ@mail.gmail.com>
 <ZbvVApJ2/+yca0u6@e133380.arm.com> <20240201205614.w3gcz6urfxtydr77@google.com>
In-Reply-To: <20240201205614.w3gcz6urfxtydr77@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 1 Feb 2024 22:23:16 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGAi94DuCYRPWQujGz7YVTS=53h_+FretCsYFbxznJVHw@mail.gmail.com>
Message-ID: <CAMj1kXGAi94DuCYRPWQujGz7YVTS=53h_+FretCsYFbxznJVHw@mail.gmail.com>
Subject: Re: [PATCH] arm64: jump_label: use constraint "S" instead of "i"
To: Fangrui Song <maskray@google.com>
Cc: Dave Martin <Dave.Martin@arm.com>, Peter Smith <peter.smith@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@kernel.org>, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 21:56, Fangrui Song <maskray@google.com> wrote:
>
> On 2024-02-01, Dave Martin wrote:
> >On Thu, Feb 01, 2024 at 05:07:59PM +0100, Ard Biesheuvel wrote:
> >> On Thu, 1 Feb 2024 at 12:50, Dave Martin <Dave.Martin@arm.com> wrote:
> >> >
> >> > On Thu, Feb 01, 2024 at 01:11:20AM -0800, Fangrui Song wrote:
> >> ...
> >> > >
> >> > > Hmm. Clang's constraint "S" implementation doesn't support a constant
> >> > > offset, so
> >> > > `static_key_false(&nf_hooks_needed[pf][hook])` in include/linux/netfilter.h:nf_hook
> >> > > would not compile with Clang <= 18.
> >> > >
> >> > > I have a patch https://github.com/llvm/llvm-project/pull/80255 , but
> >> > > even if it is accepted and cherry-picked into the 18.x release branch,
> >> > > if we still support older Clang, we cannot use "S" unconditionally.
> >> > >
> >> > >
> >> > > So we probably need the following to prepare for -fPIE support in the
> >> > > future:
> >> > >
> >> > > diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
> >> > > index 48ddc0f45d22..b8af2f8b0c99 100644
> >> > > --- a/arch/arm64/include/asm/jump_label.h
> >> > > +++ b/arch/arm64/include/asm/jump_label.h
> >> > > @@ -15,6 +15,16 @@
> >> > >  #define JUMP_LABEL_NOP_SIZE          AARCH64_INSN_SIZE
> >> > > +/*
> >> > > + * Prefer "S" to support PIC. However, use "i" for Clang 18 and earlier as "S"
> >> > > + * on a symbol with a constant offset is not supported.
> >> > > + */
> >> > > +#if defined(CONFIG_CC_IS_CLANG) && __clang_major__ <= 18
> >> >
> >> > Is a GCC version check needed?  Or is the minimum GCC version specified
> >> > for building the kernel new enough?
> >> >
> >> > > +#define JUMP_LABEL_STATIC_KEY_CONSTRAINT "i"
> >> > > +#else
> >> > > +#define JUMP_LABEL_STATIC_KEY_CONSTRAINT "S"
> >> > > +#endif
> >> > > +
> >>
> >> Can we use "Si" instead?
> >
> >I thought the point was to avoid "S" on compilers that would choke on
> >it?  If so, those compilers would surely choke on "Si" too, no?
>
> "Si" is an invalid constraint. Unfortunately, GCC recognizes "S" as a
> valid constraint and ignores trailing characters (asm_operand_ok). That
> is, GCC would accept "Siiiii" as well...
>
> The GCC support for "S" is great. The initial aarch64 port in 2012 supports "S".
>

So it is not possible to combine the S and i constraint, and let the
compiler figure out whether it meets either? We rely on this elsewhere
by combining r and Z into rZ. x86 uses "rm" for inline asm parameters
that could be either register or memory operands.


> >> > >  static __always_inline bool arch_static_branch(struct static_key * const key,
> >> > >                                              const bool branch)
> >> > >  {
> >> > > @@ -23,9 +33,9 @@ static __always_inline bool arch_static_branch(struct static_key * const key,
> >> > >                "      .pushsection    __jump_table, \"aw\"    \n\t"
> >> > >                "      .align          3                       \n\t"
> >> > >                "      .long           1b - ., %l[l_yes] - .   \n\t"
> >> > > -              "      .quad           %c0 - .                 \n\t"
> >> > > +              "      .quad           %0 + %1 - .             \n\t"
> >> > >                "      .popsection                             \n\t"
> >> > > -              :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> >> > > +              :  :  JUMP_LABEL_STATIC_KEY_CONSTRAINT(key), "i"(branch) :  : l_yes);
> >> >
> >> > While this looks reasonable, I'm still not clear now why the asm must do
> >> > the addition.
> >> >
> >> > Can we roll the branch argument into the macro?
> >> >
> >> > "S"(symbol + constant) seems to do the right thing for AArch64, at least
> >> > in GCC.
> >> >
> >>
> >> 'symbol' is a struct static_key pointer, so adding '1' to it will not
> >> produce the needed result.
> >
> >I mean loosely things that resolve to something of the form
> >"symbol + constant" in the compiler output.
> >
> >"S"(&((char *)key)[branch]) does indeed seem to do the right thing,
> >at least with GCC.
> >
> >I probably didn't help by bikeshedding the way that expression was
> >written, apologies for that.  It's orthogonal to what this patch is
> >doing.
>
> Yes, "S"(&((char *)key)[branch])  would do the right thing.
> I have compared assembly output. It's a matter of "s" vs "s + 0" and "s+1" vs "s + 1".
>

But if S does not work with constant offsets with older Clang, what is
the harm in splitting it into "S" for the symbol and "i" for the
branch?
..
> >>
> >> The only thing PIE linking does in the case of the kernel is
> >> a) complain if static relocations are used that cannot be fixed up at
> >> runtime (e.g., movk/movz sequences)
> >> b) emit dynamic relocations that the early startup code can use to fix
> >> up all statically initialized pointers
> >>
> >> From a codegen point-of-view, there is no difference because we don't
> >> use -fpic code. The problem with -fpic codegen is that it makes some
> >> assumptions that only hold for shared ELF objects, e.g., avoiding
> >> dynamic relocations in .text, using GOT entries even for variables
> >> defined in the same compilation so that they can be preempted, keeping
> >> all runtime relocatable quantities together so the CoW footprint of
> >> the shared library is minimized.
> >>
> >> None of this matters for the kernel, and as it turns out, the non-PIC
> >> small C model produces code that the PIE linker is happy with.
> >>
> >> TL;DR our code (including inline and out-of-line asm) is already PIC,
> >> and this property is relied upon by KASLR.
> >>
> >> > Maybe it doesn't make as much difference as I thought (certainly ADRP
> >> > based addressing should make a fair amount of the PIC/PIE overhead go
> >> > away).
> >> >
> >>
> >> The PIC/PIE overhead is in the indirections via the GOT. However,
> >> recent linkers will actually perform some relaxations too: if a symbol
> >> is defined in the same executable and is not preemptible, a GOT load
> >>
> >> ADRP
> >> LDR
> >>
> >> can be transparently converted to
> >>
> >> ADRP
> >> ADD
> >>
> >> referring to the symbol directly. This is also where hidden.h comes
> >> in: making all symbol declarations and definitions 'hidden' will allow
> >> the compiler to assume that a GOT entry is never needed.
> >
> >Is there a reason why we don't just build the whole kernel with
> >-fvisibility=hidden today?
>
> This topic, loosely related to this patch, is about switching to PIC
> compiles. I am not familiar with the Linux kernel, so I'll mostly leave
> the discussion to you and Ard :)
>
> That said, I have done a lot of Clang work in visibility/symbol
> preemptibility and linkers, so I am happy to add what I know.
>
> -fvisibility=hidden only applies to definitions, not non-definition
> declarations.
>
> I've mentioned this at
> https://lore.kernel.org/all/20220429070318.iwj3j5lpfkw4t7g2@google.com/
>
>      `#pragma GCC visibility push(hidden)` is very similar to -fvisibility=hidden -fdirect-access-external-data with Clang.
>      ...
>      The kernel uses neither TLS nor -fno-plt, so -fvisibility=hidden
>      -fdirect-access-external-data can replace `#pragma GCC visibility
>      push(hidden)`.
>
> >> So building with -fPIC is currently not need in practice, and creates
> >> some complications, which is why we have been avoiding it. But PIE
> >> linking non-PIC objects is not guaranteed to remain supported going
> >> forward, so it would be better to have a plan B, i.e., being able to
> >> turn on -fpic without massive regressions due to GOT overhead, or
> >> codegen problems with our asm hacks.
> >
> >Summarising all of this is it right that:
> >
> >1) ld -pie is how we get the reloc info into the kernel for KASLR
> >today.
> >
> >2) We use gcc -fno-pic today, but this might break with ld -pie in the
> >future, although it works for now.
> >
> >3) gcc -fno-pic and gcc -fPIC (or -fPIE) generate almost the same code,
> >assuming we tweak symbol visibility and use a memory model that
> >ADR+ADD/LDR can span.  So, moving to -fPIE is likely to be do-able.
> >
> >
> >My point is that an alternative option would be to move to ld -no-pie.

Why? What would that achieve?

> >We would need another way to get relocs into the kernel, such as an
> >intermediate step with ld --emit-relocs.  I have definitely seen this
> >done before somewhere, but it would be extra work and not necessarily
> >worth it, based on what you say about code gen.

Relying on --emit-relocs is a terrible hack. It contains mostly
relocations that we don't need at runtime, so we need to postprocess
them. And linkers may not update these relocations in some cases after
relaxation or other transformations (and sometimes, it is not even
possible to do so, if the post-transformation situation cannot be
described by a relocation).

And with Fangrui's RELR optimization, the PIE relocation data is
extremely dense.

There is nothing to fix here, really.

> >
> >This may all have been discussed to death already -- I didn't mean to
> >hijack this patch, so I'll stop digging here, but if I've misunderstood,
> >please shout!

No worries. Ramana and I spent some time 5+ years ago to document how
PIC codegen for the kernel (or any freestanding executable, really)
deviates from the typical PIC codegen for shared libraries and PIE
executables, with the intention of adding a GCC compiler switch for
it, but that never really materialized, mostly because things just
work fine today.

