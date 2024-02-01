Return-Path: <linux-kernel+bounces-48590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 045B5845E81
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3A21F270B1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B4E63CA6;
	Thu,  1 Feb 2024 17:29:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2821263C85
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808586; cv=none; b=rGCvdu5lCEufLtTtKOn8pPYMPsGBcGSxZtQXp00R8cwzxhVo3u1SEcLl+OXV1PEy5ClvXu5H+wwUzoCzw165OpzM5nWRRcU655mhQTDKycfG8ArqVVTMPretUqdJSOw53Q/VP31lfF5+HLTkaWRc0Y45obqcb3NigmDFDEg9iO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808586; c=relaxed/simple;
	bh=jiqimdF8tfIp0DYa4JWLmSbNouWv248ghCExbt4VYTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkS/Khzd7bcJmbgHw8XEPPaMQgVwdIaBMLEsCK6Ue/ar1hadz8I1zBhTiiVLtMjNV17rBXCTrN+lscH4GM8vDGsiIu8ogscyeYDfI2CHLB8HcWNbWNeBuxPXCSc+5NQmvX4Hz869Pk4bEVoDo8jUjesWdl6KsNPVC350chzgcsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EEF9DA7;
	Thu,  1 Feb 2024 09:30:25 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59CB73F738;
	Thu,  1 Feb 2024 09:29:41 -0800 (PST)
Date: Thu, 1 Feb 2024 17:29:38 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Fangrui Song <maskray@google.com>, Peter Smith <peter.smith@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Jisheng Zhang <jszhang@kernel.org>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: jump_label: use constraint "S" instead of "i"
Message-ID: <ZbvVApJ2/+yca0u6@e133380.arm.com>
References: <20240131065322.1126831-1-maskray@google.com>
 <CAMj1kXGzADFWa7RmXyjWpCnQ=9hhz6i-XkN4PS1CboZ-kFL8dQ@mail.gmail.com>
 <ZbpEnDK3U/O24ng0@e133380.arm.com>
 <20240201045551.ajg4iqcajyowl2rh@google.com>
 <CAMj1kXEBjumu3VUySg1cQ+SYm4MugJ5f6pd1f7C0XrLyOWAoOw@mail.gmail.com>
 <20240201091120.pbgr7ng6t2c36fut@google.com>
 <ZbuFWSRBntgm2ukJ@e133380.arm.com>
 <CAMj1kXGu76WHY8=Y-KhCxBq3xeHeCYQ9syqViSr9VRkjgWQ3BQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGu76WHY8=Y-KhCxBq3xeHeCYQ9syqViSr9VRkjgWQ3BQ@mail.gmail.com>

On Thu, Feb 01, 2024 at 05:07:59PM +0100, Ard Biesheuvel wrote:
> On Thu, 1 Feb 2024 at 12:50, Dave Martin <Dave.Martin@arm.com> wrote:
> >
> > On Thu, Feb 01, 2024 at 01:11:20AM -0800, Fangrui Song wrote:
> ...
> > >
> > > Hmm. Clang's constraint "S" implementation doesn't support a constant
> > > offset, so
> > > `static_key_false(&nf_hooks_needed[pf][hook])` in include/linux/netfilter.h:nf_hook
> > > would not compile with Clang <= 18.
> > >
> > > I have a patch https://github.com/llvm/llvm-project/pull/80255 , but
> > > even if it is accepted and cherry-picked into the 18.x release branch,
> > > if we still support older Clang, we cannot use "S" unconditionally.
> > >
> > >
> > > So we probably need the following to prepare for -fPIE support in the
> > > future:
> > >
> > > diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
> > > index 48ddc0f45d22..b8af2f8b0c99 100644
> > > --- a/arch/arm64/include/asm/jump_label.h
> > > +++ b/arch/arm64/include/asm/jump_label.h
> > > @@ -15,6 +15,16 @@
> > >  #define JUMP_LABEL_NOP_SIZE          AARCH64_INSN_SIZE
> > > +/*
> > > + * Prefer "S" to support PIC. However, use "i" for Clang 18 and earlier as "S"
> > > + * on a symbol with a constant offset is not supported.
> > > + */
> > > +#if defined(CONFIG_CC_IS_CLANG) && __clang_major__ <= 18
> >
> > Is a GCC version check needed?  Or is the minimum GCC version specified
> > for building the kernel new enough?
> >
> > > +#define JUMP_LABEL_STATIC_KEY_CONSTRAINT "i"
> > > +#else
> > > +#define JUMP_LABEL_STATIC_KEY_CONSTRAINT "S"
> > > +#endif
> > > +
> 
> Can we use "Si" instead?

I thought the point was to avoid "S" on compilers that would choke on
it?  If so, those compilers would surely choke on "Si" too, no?


> > >  static __always_inline bool arch_static_branch(struct static_key * const key,
> > >                                              const bool branch)
> > >  {
> > > @@ -23,9 +33,9 @@ static __always_inline bool arch_static_branch(struct static_key * const key,
> > >                "      .pushsection    __jump_table, \"aw\"    \n\t"
> > >                "      .align          3                       \n\t"
> > >                "      .long           1b - ., %l[l_yes] - .   \n\t"
> > > -              "      .quad           %c0 - .                 \n\t"
> > > +              "      .quad           %0 + %1 - .             \n\t"
> > >                "      .popsection                             \n\t"
> > > -              :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> > > +              :  :  JUMP_LABEL_STATIC_KEY_CONSTRAINT(key), "i"(branch) :  : l_yes);
> >
> > While this looks reasonable, I'm still not clear now why the asm must do
> > the addition.
> >
> > Can we roll the branch argument into the macro?
> >
> > "S"(symbol + constant) seems to do the right thing for AArch64, at least
> > in GCC.
> >
> 
> 'symbol' is a struct static_key pointer, so adding '1' to it will not
> produce the needed result.

I mean loosely things that resolve to something of the form
"symbol + constant" in the compiler output.

"S"(&((char *)key)[branch]) does indeed seem to do the right thing,
at least with GCC.

I probably didn't help by bikeshedding the way that expression was
written, apologies for that.  It's orthogonal to what this patch is
doing.

> 
> ...
> > > > > >If there's another reason why "S" is advantageous though, I'm happy to
> > > > > >be corrected.
> > > > >
> > > > > I remember that Ard has an RFC
> > > > > https://lore.kernel.org/linux-arm-kernel/20220427171241.2426592-1-ardb@kernel.org/
> > > > > "[RFC PATCH 0/2] arm64: use PIE code generation for KASLR kernel"
> > > > > and see some recent PIE codegen patches.
> > > > >
> > > > > > Building the KASLR kernel without -fpie but linking it with -pie works
> > > > > > in practice, but it is not something that is explicitly supported by the
> > > > > > toolchains - it happens to work because the default 'small' code model
> > > > > > used by both GCC and Clang relies mostly on ADRP+ADD/LDR to generate
> > > > > > symbol references.
> >
> > Does this mean that doing boot-time relocation on a fully statically
> > linked kernel doesn't bring much benefit?
> 
> Not sure I follow you here. The boot-time relocation is necessary in
> any case, to fix up statically initialized pointer variables all over
> the kernel.
> 
> > It would tend to be more
> > painful to do the relocation work, and mean that the kernel text has to
> > be temporarily writeable, but static linking should have the best
> > runtime performance.
> >
> 
> Not sure what you mean by 'static linking' here.
> 
> The only thing PIE linking does in the case of the kernel is
> a) complain if static relocations are used that cannot be fixed up at
> runtime (e.g., movk/movz sequences)
> b) emit dynamic relocations that the early startup code can use to fix
> up all statically initialized pointers
> 
> From a codegen point-of-view, there is no difference because we don't
> use -fpic code. The problem with -fpic codegen is that it makes some
> assumptions that only hold for shared ELF objects, e.g., avoiding
> dynamic relocations in .text, using GOT entries even for variables
> defined in the same compilation so that they can be preempted, keeping
> all runtime relocatable quantities together so the CoW footprint of
> the shared library is minimized.
> 
> None of this matters for the kernel, and as it turns out, the non-PIC
> small C model produces code that the PIE linker is happy with.
> 
> TL;DR our code (including inline and out-of-line asm) is already PIC,
> and this property is relied upon by KASLR.
> 
> > Maybe it doesn't make as much difference as I thought (certainly ADRP
> > based addressing should make a fair amount of the PIC/PIE overhead go
> > away).
> >
> 
> The PIC/PIE overhead is in the indirections via the GOT. However,
> recent linkers will actually perform some relaxations too: if a symbol
> is defined in the same executable and is not preemptible, a GOT load
> 
> ADRP
> LDR
> 
> can be transparently converted to
> 
> ADRP
> ADD
> 
> referring to the symbol directly. This is also where hidden.h comes
> in: making all symbol declarations and definitions 'hidden' will allow
> the compiler to assume that a GOT entry is never needed.

Is there a reason why we don't just build the whole kernel with
-fvisibility=hidden today?

> So building with -fPIC is currently not need in practice, and creates
> some complications, which is why we have been avoiding it. But PIE
> linking non-PIC objects is not guaranteed to remain supported going
> forward, so it would be better to have a plan B, i.e., being able to
> turn on -fpic without massive regressions due to GOT overhead, or
> codegen problems with our asm hacks.

Summarising all of this is it right that:

1) ld -pie is how we get the reloc info into the kernel for KASLR
today.

2) We use gcc -fno-pic today, but this might break with ld -pie in the
future, although it works for now.

3) gcc -fno-pic and gcc -fPIC (or -fPIE) generate almost the same code,
assuming we tweak symbol visibility and use a memory model that
ADR+ADD/LDR can span.  So, moving to -fPIE is likely to be do-able.


My point is that an alternative option would be to move to ld -no-pie.
We would need another way to get relocs into the kernel, such as an
intermediate step with ld --emit-relocs.  I have definitely seen this
done before somewhere, but it would be extra work and not necessarily
worth it, based on what you say about code gen.

This may all have been discussed to death already -- I didn't mean to
hijack this patch, so I'll stop digging here, but if I've misunderstood,
please shout!

Cheers
---Dave

