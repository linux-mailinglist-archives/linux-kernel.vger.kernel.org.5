Return-Path: <linux-kernel+bounces-48833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AD4846231
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2BE28CA87
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF523CF43;
	Thu,  1 Feb 2024 20:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BItg2NkE"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1CA3C48D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 20:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706820981; cv=none; b=MJmtrb8bLO52rUC0EmmimFEJGev8sQ8E1zor22r3WWd+UFZoW/xfAIHX9pi39K6YUoqMX2vaCUF8BN+WCf8Be8g8Lv/6CpL8yfIaj4KXBiUiNiLVwyUu07hCoCm+En/pf1ANOxooNPefYnj+l1oEYR/eQhTJIUTburAnhSGWzPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706820981; c=relaxed/simple;
	bh=BV127Zq/9lKW7y9wOvkGQTCDzj0sEYdoToDqAl4g02c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0s/cMiphRH+P6s30Ldbo5r3LgrBcWkLU35MeEbwurUuavsZaB98WnKtSvy0KK57R1+jD5ALjbiojA/o2QZ/UqkkicP8LAZXrNhmJwDTuYyxFUMSR8JStzp7cVc7pxGCE300vfby0VQdC7DWvomOTv0xv+8UX9LnsCsz1xW17DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BItg2NkE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d93b982761so49905ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 12:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706820978; x=1707425778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ro4Cyt+o5jdF1r8CbHUQjWgDv3PydSUVd5+tHB77kBY=;
        b=BItg2NkEHRQF79g1YK10Cm/kOW5hlg8aJI4NPX1HV5mlbtv+82n/I+XPOYFLMjb5Rb
         pFf9EKxMxXi6xM0oM2IsV/qgp6LEK/JaVSiphSaLRjWD4YtYUKGLVVl3BU2AP52bWj3a
         2COjzEqai8zLGkUhkqULBCAr/DwvGB5nqlJFErFDGsv0pPSiBqAt/RAHpdw2NchHngEr
         LFniWLnLuhChdt8/ciLfLCem9alygHckLv9LHqf9pqABW26Ia6mtCrT9PjMjtkb7DuZX
         dQPBncy3I01LAcxV7AiBDmDu0kth1qJySkd0xQ40kUwRzS6jF1VAXogYRscWElP+Ggc9
         5xAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706820978; x=1707425778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ro4Cyt+o5jdF1r8CbHUQjWgDv3PydSUVd5+tHB77kBY=;
        b=dHxwDo1UGvlwUWpmpotAolnWrsgIK5qCxN2KC+T/0TSvzwKEEyTepsUJ6g5YdSqTDD
         MgPyIF3jdfmCmrfkhZxcXNbLb86jqciBNSIQrk9uO1rCLfzYK1QVBeSOJt75aEONN5yL
         rXmP2x2oGWWTB/y8gPfpLo77/8TDpRan0no5Okzgo/CXV57NBk56VC8hTxuleHnqxLvG
         DMYloWApbaZg6poKBxiLM0iIsqqwScJko0ilfjnRBZScM5GgoNUGf79g7SsvaZco3vYz
         bvKbsDjonxQLmnxZn7DkRZ5KrGIhkEbNeihkjGpqF5xcLMzrnFCWZp8dGHnOvKEf9eUD
         snnA==
X-Gm-Message-State: AOJu0Yz13Y+FphRcwD3CHOng3LwZyF78jwHO2r7huG2SV8YabFx/fV8r
	ExcLgK/pTzUU9RtYDCCrdd7paftVOb1PfitAJTDv9rFE9n6YgOE8JKXqKXUuuQ==
X-Google-Smtp-Source: AGHT+IHk2OBCL92cbB8Y9PxcY+HHRS3ovtcUAFdn1swhjb8G1d7s3KLTMJFyoLNyUSBlVCv1FJcKXA==
X-Received: by 2002:a17:903:22c4:b0:1d6:ebf1:f8cf with SMTP id y4-20020a17090322c400b001d6ebf1f8cfmr27387plg.0.1706820978195;
        Thu, 01 Feb 2024 12:56:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUD5bM5j9zpP/qXhAwUmqYW9PsSoWVYKUYuqSXi8KRk1bXhD3NBgefq2uVQF0Ekit/NHeA/EMPoSj79z+J9KN3Of8cFih6eWaypY+fQcyA2HHjLXGAVem8To0Xbn3tvD6DMXFQuNQdyLQCR70VkgXj2/veYT0BLfqXo1kf7g8Sd4zlLBX5m3yra7G1ReSgJqDtiB8y/gn6RUmzUupDiFq8JHKLYThMxPGXQSPRG7UIqAtz2TUPBjb43JDmOKwiOpk59QvkDm6tMgRVoi1puRNxM3VBSb26Od/sYShs=
Received: from google.com ([2620:15c:2d3:205:ce95:ce9d:3dd2:5053])
        by smtp.gmail.com with ESMTPSA id j24-20020a62b618000000b006dd850bbd21sm179170pff.36.2024.02.01.12.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 12:56:17 -0800 (PST)
Date: Thu, 1 Feb 2024 12:56:14 -0800
From: Fangrui Song <maskray@google.com>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Peter Smith <peter.smith@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Jisheng Zhang <jszhang@kernel.org>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: jump_label: use constraint "S" instead of "i"
Message-ID: <20240201205614.w3gcz6urfxtydr77@google.com>
References: <20240131065322.1126831-1-maskray@google.com>
 <CAMj1kXGzADFWa7RmXyjWpCnQ=9hhz6i-XkN4PS1CboZ-kFL8dQ@mail.gmail.com>
 <ZbpEnDK3U/O24ng0@e133380.arm.com>
 <20240201045551.ajg4iqcajyowl2rh@google.com>
 <CAMj1kXEBjumu3VUySg1cQ+SYm4MugJ5f6pd1f7C0XrLyOWAoOw@mail.gmail.com>
 <20240201091120.pbgr7ng6t2c36fut@google.com>
 <ZbuFWSRBntgm2ukJ@e133380.arm.com>
 <CAMj1kXGu76WHY8=Y-KhCxBq3xeHeCYQ9syqViSr9VRkjgWQ3BQ@mail.gmail.com>
 <ZbvVApJ2/+yca0u6@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZbvVApJ2/+yca0u6@e133380.arm.com>

On 2024-02-01, Dave Martin wrote:
>On Thu, Feb 01, 2024 at 05:07:59PM +0100, Ard Biesheuvel wrote:
>> On Thu, 1 Feb 2024 at 12:50, Dave Martin <Dave.Martin@arm.com> wrote:
>> >
>> > On Thu, Feb 01, 2024 at 01:11:20AM -0800, Fangrui Song wrote:
>> ...
>> > >
>> > > Hmm. Clang's constraint "S" implementation doesn't support a constant
>> > > offset, so
>> > > `static_key_false(&nf_hooks_needed[pf][hook])` in include/linux/netfilter.h:nf_hook
>> > > would not compile with Clang <= 18.
>> > >
>> > > I have a patch https://github.com/llvm/llvm-project/pull/80255 , but
>> > > even if it is accepted and cherry-picked into the 18.x release branch,
>> > > if we still support older Clang, we cannot use "S" unconditionally.
>> > >
>> > >
>> > > So we probably need the following to prepare for -fPIE support in the
>> > > future:
>> > >
>> > > diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
>> > > index 48ddc0f45d22..b8af2f8b0c99 100644
>> > > --- a/arch/arm64/include/asm/jump_label.h
>> > > +++ b/arch/arm64/include/asm/jump_label.h
>> > > @@ -15,6 +15,16 @@
>> > >  #define JUMP_LABEL_NOP_SIZE          AARCH64_INSN_SIZE
>> > > +/*
>> > > + * Prefer "S" to support PIC. However, use "i" for Clang 18 and earlier as "S"
>> > > + * on a symbol with a constant offset is not supported.
>> > > + */
>> > > +#if defined(CONFIG_CC_IS_CLANG) && __clang_major__ <= 18
>> >
>> > Is a GCC version check needed?  Or is the minimum GCC version specified
>> > for building the kernel new enough?
>> >
>> > > +#define JUMP_LABEL_STATIC_KEY_CONSTRAINT "i"
>> > > +#else
>> > > +#define JUMP_LABEL_STATIC_KEY_CONSTRAINT "S"
>> > > +#endif
>> > > +
>>
>> Can we use "Si" instead?
>
>I thought the point was to avoid "S" on compilers that would choke on
>it?  If so, those compilers would surely choke on "Si" too, no?

"Si" is an invalid constraint. Unfortunately, GCC recognizes "S" as a
valid constraint and ignores trailing characters (asm_operand_ok). That
is, GCC would accept "Siiiii" as well...

The GCC support for "S" is great. The initial aarch64 port in 2012 supports "S".

>> > >  static __always_inline bool arch_static_branch(struct static_key * const key,
>> > >                                              const bool branch)
>> > >  {
>> > > @@ -23,9 +33,9 @@ static __always_inline bool arch_static_branch(struct static_key * const key,
>> > >                "      .pushsection    __jump_table, \"aw\"    \n\t"
>> > >                "      .align          3                       \n\t"
>> > >                "      .long           1b - ., %l[l_yes] - .   \n\t"
>> > > -              "      .quad           %c0 - .                 \n\t"
>> > > +              "      .quad           %0 + %1 - .             \n\t"
>> > >                "      .popsection                             \n\t"
>> > > -              :  :  "i"(&((char *)key)[branch]) :  : l_yes);
>> > > +              :  :  JUMP_LABEL_STATIC_KEY_CONSTRAINT(key), "i"(branch) :  : l_yes);
>> >
>> > While this looks reasonable, I'm still not clear now why the asm must do
>> > the addition.
>> >
>> > Can we roll the branch argument into the macro?
>> >
>> > "S"(symbol + constant) seems to do the right thing for AArch64, at least
>> > in GCC.
>> >
>>
>> 'symbol' is a struct static_key pointer, so adding '1' to it will not
>> produce the needed result.
>
>I mean loosely things that resolve to something of the form
>"symbol + constant" in the compiler output.
>
>"S"(&((char *)key)[branch]) does indeed seem to do the right thing,
>at least with GCC.
>
>I probably didn't help by bikeshedding the way that expression was
>written, apologies for that.  It's orthogonal to what this patch is
>doing.

Yes, "S"(&((char *)key)[branch])  would do the right thing.
I have compared assembly output. It's a matter of "s" vs "s + 0" and "s+1" vs "s + 1".

>>
>> ...
>> > > > > >If there's another reason why "S" is advantageous though, I'm happy to
>> > > > > >be corrected.
>> > > > >
>> > > > > I remember that Ard has an RFC
>> > > > > https://lore.kernel.org/linux-arm-kernel/20220427171241.2426592-1-ardb@kernel.org/
>> > > > > "[RFC PATCH 0/2] arm64: use PIE code generation for KASLR kernel"
>> > > > > and see some recent PIE codegen patches.
>> > > > >
>> > > > > > Building the KASLR kernel without -fpie but linking it with -pie works
>> > > > > > in practice, but it is not something that is explicitly supported by the
>> > > > > > toolchains - it happens to work because the default 'small' code model
>> > > > > > used by both GCC and Clang relies mostly on ADRP+ADD/LDR to generate
>> > > > > > symbol references.
>> >
>> > Does this mean that doing boot-time relocation on a fully statically
>> > linked kernel doesn't bring much benefit?
>>
>> Not sure I follow you here. The boot-time relocation is necessary in
>> any case, to fix up statically initialized pointer variables all over
>> the kernel.
>>
>> > It would tend to be more
>> > painful to do the relocation work, and mean that the kernel text has to
>> > be temporarily writeable, but static linking should have the best
>> > runtime performance.
>> >
>>
>> Not sure what you mean by 'static linking' here.
>>
>> The only thing PIE linking does in the case of the kernel is
>> a) complain if static relocations are used that cannot be fixed up at
>> runtime (e.g., movk/movz sequences)
>> b) emit dynamic relocations that the early startup code can use to fix
>> up all statically initialized pointers
>>
>> From a codegen point-of-view, there is no difference because we don't
>> use -fpic code. The problem with -fpic codegen is that it makes some
>> assumptions that only hold for shared ELF objects, e.g., avoiding
>> dynamic relocations in .text, using GOT entries even for variables
>> defined in the same compilation so that they can be preempted, keeping
>> all runtime relocatable quantities together so the CoW footprint of
>> the shared library is minimized.
>>
>> None of this matters for the kernel, and as it turns out, the non-PIC
>> small C model produces code that the PIE linker is happy with.
>>
>> TL;DR our code (including inline and out-of-line asm) is already PIC,
>> and this property is relied upon by KASLR.
>>
>> > Maybe it doesn't make as much difference as I thought (certainly ADRP
>> > based addressing should make a fair amount of the PIC/PIE overhead go
>> > away).
>> >
>>
>> The PIC/PIE overhead is in the indirections via the GOT. However,
>> recent linkers will actually perform some relaxations too: if a symbol
>> is defined in the same executable and is not preemptible, a GOT load
>>
>> ADRP
>> LDR
>>
>> can be transparently converted to
>>
>> ADRP
>> ADD
>>
>> referring to the symbol directly. This is also where hidden.h comes
>> in: making all symbol declarations and definitions 'hidden' will allow
>> the compiler to assume that a GOT entry is never needed.
>
>Is there a reason why we don't just build the whole kernel with
>-fvisibility=hidden today?

This topic, loosely related to this patch, is about switching to PIC
compiles. I am not familiar with the Linux kernel, so I'll mostly leave
the discussion to you and Ard :)

That said, I have done a lot of Clang work in visibility/symbol
preemptibility and linkers, so I am happy to add what I know.

-fvisibility=hidden only applies to definitions, not non-definition
declarations.

I've mentioned this at
https://lore.kernel.org/all/20220429070318.iwj3j5lpfkw4t7g2@google.com/

     `#pragma GCC visibility push(hidden)` is very similar to -fvisibility=hidden -fdirect-access-external-data with Clang.
     ...
     The kernel uses neither TLS nor -fno-plt, so -fvisibility=hidden
     -fdirect-access-external-data can replace `#pragma GCC visibility
     push(hidden)`.

>> So building with -fPIC is currently not need in practice, and creates
>> some complications, which is why we have been avoiding it. But PIE
>> linking non-PIC objects is not guaranteed to remain supported going
>> forward, so it would be better to have a plan B, i.e., being able to
>> turn on -fpic without massive regressions due to GOT overhead, or
>> codegen problems with our asm hacks.
>
>Summarising all of this is it right that:
>
>1) ld -pie is how we get the reloc info into the kernel for KASLR
>today.
>
>2) We use gcc -fno-pic today, but this might break with ld -pie in the
>future, although it works for now.
>
>3) gcc -fno-pic and gcc -fPIC (or -fPIE) generate almost the same code,
>assuming we tweak symbol visibility and use a memory model that
>ADR+ADD/LDR can span.  So, moving to -fPIE is likely to be do-able.
>
>
>My point is that an alternative option would be to move to ld -no-pie.
>We would need another way to get relocs into the kernel, such as an
>intermediate step with ld --emit-relocs.  I have definitely seen this
>done before somewhere, but it would be extra work and not necessarily
>worth it, based on what you say about code gen.
>
>This may all have been discussed to death already -- I didn't mean to
>hijack this patch, so I'll stop digging here, but if I've misunderstood,
>please shout!
>
>Cheers
>---Dave

