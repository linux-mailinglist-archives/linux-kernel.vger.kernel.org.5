Return-Path: <linux-kernel+bounces-50141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2E68474D0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245882917D1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F98148311;
	Fri,  2 Feb 2024 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mem3Tp58"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3697117748
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891570; cv=none; b=aIRtf2qk4Jx3pw/L9w73QFWIcC1u7wlDNzzqF/nCZ6AY7Ii2z+k7ebIJpbfVACmG6RknNXUVXU7a5wKIVnIKbBwLp/vRW3/137Eegc8UW+QHESgCIhvzoq51IoUoAt5GiWhb4hMbzGUszfmgT37gjTgqjDygwHpaHQj2SfeeRkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891570; c=relaxed/simple;
	bh=Qpb5LUigig6Dqx7YeBJx99fFSoRjufIv2sfY5c54TcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4S+K/pUZ6CgGUGdwuwROB8CHW2H3r6lMzgFjQm4OQddine7aMJuDe4sFhHOtjPLHFA9M48QF8ksxhVlSGKI/SY9HucFpUuQD5DGWDit1xBVxdMGznTlOvWb7nmJJc+zRweZbzbuGTl4lE766yvv0yr6HSoX7jA+VKqiI4DMAuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mem3Tp58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53D5C43394
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 16:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706891569;
	bh=Qpb5LUigig6Dqx7YeBJx99fFSoRjufIv2sfY5c54TcA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mem3Tp58NpcFQ0LCjVi+qHZmEofguxdqViS+xfa/O9TwPCT+YavztC0VYGRrJAo2F
	 MOc4qWjz2JC2DYwY4cH8MBG0yoNCij/SBrBepnca+zMQvzhEX/eUxDNS2qx4okTMg4
	 9KY8Mz3rpuB4avwGc8SaUB25A4WkYLB09AFQpPFEE9aEmRqeJ08o8wCq25UE7cyN2Y
	 RPs06vgZQqBEiTtUL3kcP3xIudaTx4nbZSuF3Fwtc6chrERB6ipRMNHiwEKmRaG3vO
	 xF7VoBi9F0t55NqFnezyNuev930Ybgdf61MsoF5kEdUEp/RoLXdjX4MeqbOxC6puDI
	 LaU472fwvFfTA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-511206d1c89so3141271e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 08:32:49 -0800 (PST)
X-Gm-Message-State: AOJu0YyuNUSbWVkfGaAyW1PONK70VYZFrQp55ra8M+FegK1tGgkOoReJ
	mzWOV5gwl0OFyCab3TkrRml85B7kRIn4mAb7oXrOdpg5hSf5klZ9Pu6KiXj1gY/KlP54/aNMAlc
	OyPwb07Xn+crQpD84uHZ/w/8rag0=
X-Google-Smtp-Source: AGHT+IEWLhbVs8xPM5ZHqYIC3bGqYr/Na6IRl5mzGprwFRjkIBF/d+yOPoevyQzFUG+e5PJjazHjN3gdlwnY4DyiqJY=
X-Received: by 2002:a19:644a:0:b0:50e:95cf:e7b1 with SMTP id
 b10-20020a19644a000000b0050e95cfe7b1mr1968484lfj.9.1706891567985; Fri, 02 Feb
 2024 08:32:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201223545.728028-1-maskray@google.com> <Zb0Qu5lR0iZUqImb@e133380.arm.com>
In-Reply-To: <Zb0Qu5lR0iZUqImb@e133380.arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 2 Feb 2024 17:32:33 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGSQ4Xq68Cmq6BH37FPJ+R+N5cOfrdC+aVML4sGaNDopg@mail.gmail.com>
Message-ID: <CAMj1kXGSQ4Xq68Cmq6BH37FPJ+R+N5cOfrdC+aVML4sGaNDopg@mail.gmail.com>
Subject: Re: [PATCH] arm64: jump_label: use constraints "Si" instead of "i"
To: Dave Martin <Dave.Martin@arm.com>
Cc: Fangrui Song <maskray@google.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	Jisheng Zhang <jszhang@kernel.org>, Peter Smith <peter.smith@arm.com>, llvm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 16:56, Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Thu, Feb 01, 2024 at 02:35:45PM -0800, Fangrui Song wrote:
> > The generic constraint "i" seems to be copied from x86 or arm (and with
> > a redundant generic operand modifier "c"). It works with -fno-PIE but
> > not with -fPIE/-fPIC in GCC's aarch64 port.
> >
> > The machine constraint "S", which denotes a symbol or label reference
> > with a constant offset, supports PIC and has been available in GCC since
> > 2012 and in Clang since 7.0. However, Clang before 19 does not support
> > "S" on a symbol with a constant offset [1] (e.g.
> > `static_key_false(&nf_hooks_needed[pf][hook])` in
> > include/linux/netfilter.h), so we use "i" as a fallback.
> >
> > Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Fangrui Song <maskray@google.com>
> > Link: https://github.com/llvm/llvm-project/pull/80255 [1]
> >
> > ---
> > Changes from
> > arm64: jump_label: use constraint "S" instead of "i" (https://lore.kernel.org/all/20240131065322.1126831-1-maskray@google.com/)
> >
> > * Use "Si" as Ard suggested to support Clang<19
> > * Make branch a separate operand
> > ---
> >  arch/arm64/include/asm/jump_label.h | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
> > index 48ddc0f45d22..1f7d529be608 100644
> > --- a/arch/arm64/include/asm/jump_label.h
> > +++ b/arch/arm64/include/asm/jump_label.h
> > @@ -15,6 +15,10 @@
> >
> >  #define JUMP_LABEL_NOP_SIZE          AARCH64_INSN_SIZE
> >
> > +/*
> > + * Prefer the constraint "S" to support PIC with GCC. Clang before 19 does not
> > + * support "S" on a symbol with a constant offset, so we use "i" as a fallback.
> > + */
> >  static __always_inline bool arch_static_branch(struct static_key * const key,
> >                                              const bool branch)
> >  {
> > @@ -23,9 +27,9 @@ static __always_inline bool arch_static_branch(struct static_key * const key,
> >                "      .pushsection    __jump_table, \"aw\"    \n\t"
> >                "      .align          3                       \n\t"
> >                "      .long           1b - ., %l[l_yes] - .   \n\t"
> > -              "      .quad           %c0 - .                 \n\t"
> > +              "      .quad           %0 + %1 - .             \n\t"
> >                "      .popsection                             \n\t"
> > -              :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> > +              :  :  "Si"(key), "i"(branch) :  : l_yes);
>
> Is the meaning of multi-alternatives well defined if different arguments
> specify different numbers of alternatives?  The GCC documentation says:
>
> https://gcc.gnu.org/onlinedocs/gcc/Multi-Alternative.html:
>
> -8<-
>
> [...] All operands for a single instruction must have the same number of
> alternatives.
>
> ->8-
>

AIUI that does not apply here. That reasons about multiple arguments
having more than one constraint, where not all combinations of those
constraints are supported by the instruction.

> Also, I still think it may be redundant to move the addition inside the
> asm, so long as Clang is happy with the symbol having an offset.
>

Older Clang is not happy with the symbol having an offset.

And given that the key pointer and the 'branch' boolean are two
distinct inputs to this function, I struggle to understand why you
feel it is better to combine them in the argument. 'branch' is used to
decide whether or not to set bit 0, independently of the value of key.
Using array indexing to combine those values together to avoid an
addition in the asm obfuscates the code.


> I.e., leave the .quad the same and revert to the one-liner
>
> -                :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> +                :  :  "Si"(&((char *)key)[branch]) :  : l_yes);
>
> This remains a bit nasty, but splitting the arguments and adding them
> inside the asm is not really any cleaner.  Changing the way this works
> doesn't seem relevant to what this patch is fixing (and apologies if I
> created confusion here...)
>
> >
> >       return false;
> >  l_yes:
> > @@ -40,9 +44,9 @@ static __always_inline bool arch_static_branch_jump(struct static_key * const ke
> >                "      .pushsection    __jump_table, \"aw\"    \n\t"
> >                "      .align          3                       \n\t"
> >                "      .long           1b - ., %l[l_yes] - .   \n\t"
> > -              "      .quad           %c0 - .                 \n\t"
> > +              "      .quad           %0 + %1 - .             \n\t"
> >                "      .popsection                             \n\t"
> > -              :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> > +              :  :  "Si"(key), "i"(branch) :  : l_yes);
>
> Ditto.
>
> [...]
>
> Cheers
> ---Dave

