Return-Path: <linux-kernel+bounces-157708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864258B14EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D41B28480A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55437156971;
	Wed, 24 Apr 2024 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdOX6C31"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8580A13A401
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713991944; cv=none; b=YBuWYJfFGA8BP+G9WrtdgxnUuKuh7k741KaVQM0BZJ7AsfJAXKG0XU/KJnqfvByLgvnKWo176Qf+K50OsETdwwuUcPjCzyCRIhJq8jUrZWn8W7YEUrH7h5hA6blYhy0XjEqPBzwr49rJaen8VykJEwjI8R37XUycRWjpdM4Chx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713991944; c=relaxed/simple;
	bh=U8vN6+xOk4zyZdpad0pX9zdS4fQ6q9OQDwYM3NEU+dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJu5d+74xVRmoPhw8XxGIuATELlNTzIJO+mPMjUSKGvmYQHOsgJ6N1Irz5/eSrWfImu6h82/KW3iNqKdyPiLw304MKzQ4xMJl8IKwwsGlESRitXMVClYZZT2eRdAccCGu9qCEAiQvRdriXIlDg3M2EtlzUzxKY06ZmZqDCQvHpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdOX6C31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138B0C2BD10
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 20:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713991944;
	bh=U8vN6+xOk4zyZdpad0pX9zdS4fQ6q9OQDwYM3NEU+dI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bdOX6C31ndrm0+qVhx83jYqY8oK3lKPL5yadH+mG8ffz2nqDG6FBEFw/dNMlUlOx0
	 Y76MZ2tSpfI/PlunIZEUjuttngRtLYoor/Jkk+NCqhhAkKqYJILZ36PyEJw66Ercw1
	 JePD7F0JP9/j1+waJMlAt+TrvZcErX5XwkFgChTclNH7Br6OfeJihaJMFWoi27CcL1
	 ONV0xL9fSDaQwh+SRK6waU3qMM7deu4llwH/A9Jju4jbWKmnHsdgU90F7J08gZyLTz
	 9wGBnxHdyobajpPZX6nwdKvnyxiVsCj40JaxbbXrbsO3HyunadrrLejtaVizeDrfeX
	 oeGOOUygraOUg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso3725331fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:52:23 -0700 (PDT)
X-Gm-Message-State: AOJu0YzX1Xn8cgrVh2cS6oPTNZi8aXQU7RpDBWdYOOqMIpAW5QAldON+
	xs5IYFUgqZpW944LPtgxnuoAv/03SopamIDLKpkwgtOhsT4h6z0vZlJssZTJAIp/isnPdymteSQ
	nk7T80Rq2glkMHC1XIePlcOwccNw=
X-Google-Smtp-Source: AGHT+IFdjbva3NaWtea+JO3rX/Y+cVtJkd5mRpOVE9YOqsXQty/XHSlBB7+pr5gcfEE+ImdpEafECDGHtrmfkfuJYOg=
X-Received: by 2002:a2e:9d06:0:b0:2d8:6b0c:d91c with SMTP id
 t6-20020a2e9d06000000b002d86b0cd91cmr1948042lji.47.1713991942394; Wed, 24 Apr
 2024 13:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com> <87bk5yv87h.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87bk5yv87h.fsf@email.froward.int.ebiederm.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 24 Apr 2024 22:52:10 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGsmaEiZAOUnn+Eh7-_VP0PHU+=0KoD-SNvqkvcZ1_7FA@mail.gmail.com>
Message-ID: <CAMj1kXGsmaEiZAOUnn+Eh7-_VP0PHU+=0KoD-SNvqkvcZ1_7FA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] kexec x86 purgatory cleanup
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 22:04, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Ard Biesheuvel <ardb+git@google.com> writes:
>
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The kexec purgatory is built like a kernel module, i.e., a partially
> > linked ELF object where each section is allocated and placed
> > individually, and all relocations need to be fixed up, even place
> > relative ones.
> >
> > This makes sense for kernel modules, which share the address space with
> > the core kernel, and contain unresolved references that need to be wired
> > up to symbols in other modules or the kernel itself.
> >
> > The purgatory, however, is a fully linked binary without any external
> > references, or any overlap with the kernel's virtual address space. So
> > it makes much more sense to create a fully linked ELF executable that
> > can just be loaded and run anywhere in memory.
>
> It does have external references that are resolved when it is loaded.
>

It doesn't today, and it hasn't for a while, at least since commit

e4160b2e4b02377c67f8ecd05786811598f39acd
x86/purgatory: Fail the build if purgatory.ro has missing symbols

which forces a build failure on unresolved external references, by
doing a full link of the purgatory.

> Further it is at least my impression that non-PIC code is more
> efficient.  PIC typically requires silly things like Global Offset
> Tables that non-PIC code does not.  At first glance this looks like a
> code passivization.
>

Given that the 64-bit purgatory can be loaded in memory that is not
32-bit addressable, the PIC code is essentially a given, since the
large code model is much worse (it uses 64-bit immediate for all
function and variable symbols, and therefore always uses indirect
calls)

Please refer to

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/build&id=cba786af84a0f9716204e09f518ce3b7ada8555e

for more details. (Getting pulled into that discussion is how I ended
up looking into the purgatory in more detail)

> Now at lot of functionality has been stripped out of purgatory so maybe
> in it's stripped down this make sense, but I want to challenge the
> notion that this is the obvious thing to do.
>

The diffstat speaks for itself - on x86, much of the allocation and
relocation logic can simply be dropped when building the purgatory in
this manner.

> > The purgatory build on x86 has already switched over to position
> > independent codegen, which only leaves a handful of absolute references,
> > which can either be dropped (patch #3) or converted into a RIP-relative
> > one (patch #4). That leaves a purgatory executable that can run at any
> > offset in memory with applying any relocations whatsoever.
>
> I missed that conversation.  Do you happen to have a pointer?  I would
> think the 32bit code is where the PIC would be most costly as the 32bit
> x86 instruction set predates PIC being a common compilation target.
>

See link above. Note that this none of this is about 32-bit code - the
purgatory as it exists today never drops out of long mode (and no
32-bit version appears to exist)

> > Some tweaks are needed to deal with the difference between partially
> > (ET_REL) and fully (ET_DYN/ET_EXEC) linked ELF objects, but with those
> > in place, a substantial amount of complicated ELF allocation, placement
> > and patching/relocation code can simply be dropped.
>
> Really?  As I recall it only needed to handle a single allocation type,
> and there were good reasons (at least when I wrote it) to patch symbols.
>
> Again maybe the fact that people have removed 90% of the functionality
> makes this make sense, but that is not obvious at first glance.
>

Again, the patches and the diffstat speak for themselves - the linker
applies all the relocations at build time, and emits all the sections
into a single ELF segment that can be copied into memory and executed
directly (modulo poking values into the global variables for the
sha256 digest and the segment list)

The last patch in the series shows which code we could drop from the
generic kexec_file_load() implementation once other architectures
adopt this scheme.

