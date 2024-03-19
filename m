Return-Path: <linux-kernel+bounces-107584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B64487FEB6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07AB4B25425
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34368002D;
	Tue, 19 Mar 2024 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noqT1yq0"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5502F5A782
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710854660; cv=none; b=mbOYwol+ALjP1PnAjnNmXWqxQmcnaPcBtwaq0tI4p02M91ti0mww9jwBCQhbje6peBsaNEqy7xl8QPclEJvyEtYfmHB6pa3aoJbTxYjtiD+wjKqhXLyE5KHgW8AZ0W+a0DwyTQy0LvfohpqKtH5m25K59HEzbFcBhzwPXDH4h+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710854660; c=relaxed/simple;
	bh=IvLkjdjQGF/TCP6cddg87/pEKPLedEzEkFzH9n8rqcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhjhwXseeeNJCdIByMUmK5Pr95gTI1e5NgqzuD0DYw8Dj2ZcFdAkBW/f1mTB13H+qPnqBBhHrB/K7Y/ZiI6fzmK0UqjoPlyx+HaF21UKKZjiWdgyvh0oa7xZittZ4D74F5Vud6wCHpWfRHC+J3tV35ZSU2ttUK5R0YzWX00Hcgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noqT1yq0; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d24a727f78so64700411fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710854656; x=1711459456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zj3ZaLyAv3SkG5Vq41cklaD23PSmzrOWDDpGwJYwUE=;
        b=noqT1yq0Vp0+bMsyyiWudJ60kPwxNNT6RE2SZ/5vbgR7vShw4NSe5wjExHVhmYgZ86
         FPRAliLoIXxsUZrMWG+0fL+rIg9qoxWnRFmfiVyr4zMIoTscPdzsBiEOselQh9cdB9vo
         JGfZEyGBEaYCyv7FnRonrM5Igyl1zhlaTzXCAXa3h3LC7LpCVy5w1HCgy+wwnbHBsjFO
         20ECycNjbPPR8yscOgfHAOWJbSr1qUB7Zpl5RoZyye1SmOhPftfbzM63A0eD1LxzSWyO
         dwp2/4f1+Js4FFqmvR24eaSdGrBe2E8tKkh4VkZZik1hlWWctancbW9DU8CcVlkN8V4n
         olyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710854656; x=1711459456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zj3ZaLyAv3SkG5Vq41cklaD23PSmzrOWDDpGwJYwUE=;
        b=p8P+/Z19cRmy/jD9AWNjvnG5EDI1AzgmtuzCSbA0ERJ+Wj7NnTzG9vIqvOF5HnyKC5
         XGPORb7UmiuCB0/5Fq9h8KmXMxv6eYA5rAK6yhDbHdodu9ExwEcNk2hK1Ic6ksNd7sUG
         OGf2NdOtjhDoRLHFV0eldV2iUfatW5aDKbDHRgQxE4qhS4GR9SuVAVFtHP3EuVobIySx
         LjqZiQzuQ1rSpt8o94Okc32+eU/iGTryliVgXrwOUa/7qHkpEUjT5LIwHZTDcvgFuhYM
         J9WDhavtwf65jZTkUNSyKuHv1Yo/0hHLMLSOYqyUrLHTKLYD8S59pYh85aTSgXmLkX7r
         VvGg==
X-Forwarded-Encrypted: i=1; AJvYcCXzfda8mhzpbMOPfAt9OOSkrajAV04dq8tzBXVtyFUocjLcnu8WU88uiGnOb/T18l8iAQv3/BxItq7WkxW7S/GxhAWkTBvJal4j5Zmi
X-Gm-Message-State: AOJu0Yz+yQ3eu0uDOe/1WVd8RS3wheAJ8C/DkIcakgdbzebukDe4z4BH
	maKYaLbhKH/Bl3TZrEEXBU0f5lnK1hpwY0y3ITHZd1oFvZWDG6UTni9lWBxXC58ElN+3idwfssM
	dg6x6hoArCapMLdRzhzEU/ZCXDXg=
X-Google-Smtp-Source: AGHT+IEsVwpkIXaZq4hohzh9Ge0QrxMmGlnEABQyll4kgUjzHtDfoupS3qtDTbOFAx6mPr8qIHt9agEb+oU55Tg3qK8=
X-Received: by 2002:a2e:9c07:0:b0:2d4:3dbc:16ec with SMTP id
 s7-20020a2e9c07000000b002d43dbc16ecmr11569534lji.20.1710854656221; Tue, 19
 Mar 2024 06:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319104418.284519-1-ubizjak@gmail.com> <CAMzpN2iTU05j5R1L9=LhjDoQ9krOymzOWH9QHi50vq-fAaOM5w@mail.gmail.com>
In-Reply-To: <CAMzpN2iTU05j5R1L9=LhjDoQ9krOymzOWH9QHi50vq-fAaOM5w@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Tue, 19 Mar 2024 14:24:04 +0100
Message-ID: <CAFULd4Zu+XhAboEss2GfBuQPXJEgxA-dQ7JX415q_Y=9fFNFoQ@mail.gmail.com>
Subject: Re: [PATCH -tip 0/3] x86/asm: Use generic asm operand modifiers
 instead of %P in asm templates
To: Brian Gerst <brgerst@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Andy Lutomirski <luto@kernel.org>, Denys Vlasenko <dvlasenk@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 2:10=E2=80=AFPM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> On Tue, Mar 19, 2024 at 6:44=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> w=
rote:
> >
> > The "P" asm operand modifier is a x86 target-specific modifier.
> >
> > For x86_64, when used with a symbol reference, the "P" modifier
> > emits "sym" instead of "sym(%rip)". When used with a constant, the
> > "P" modifier emits "cst" instead of "$cst". This property is used to
> > emit bare symbol references and bare constants without all
> > syntax-specific prefixes.
> >
> > The generic "c", "n" and "a" operand modifiers should be used instead.
> > The following table shows the modifiers supported by all targets and
> > their effects:
> >
> > Modifier    Description
> > -----------------------------------------------------------
> > 'c'         Require a constant operand and print the
> >             constant expression with no punctuation.
> > 'n'         Like '%c' except that the value of the constant
> >             is negated before printing.
> > 'a'         Substitute a memory reference, with the actual
> >             operand treated as the address.  This may be
> >             useful when outputting a "load address"
> >             instruction, because often the assembler syntax
> >             for such an instruction requires you to write
> >             the operand as if it were a memory reference.
> >
> > Also note that unlike GCC, clang emits %rip-relative symbol
> > reference with "P" asm operand modifier, so the patch also unifies
> > symbol handling with both compilers.
> >
> > No functional changes intended.
> >
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Brian Gerst <brgerst@gmail.com>
> > Cc: Denys Vlasenko <dvlasenk@redhat.com>
> > Cc: H. Peter Anvin <hpa@zytor.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > Cc: Sean Christopherson <seanjc@google.com>
> >
> > Uros Bizjak (3):
> >   x86/asm: Remove %P operand modifier from altinstr asm templates
> >   x86/asm: Use %c/%n instead of %P operand modifier in asm templates
> >   x86/asm: Use %a instead of %P operand modifier in asm templates
> >
> >  arch/x86/boot/main.c                 |  4 ++--
> >  arch/x86/include/asm/alternative.h   | 22 +++++++++++-----------
> >  arch/x86/include/asm/apic.h          |  2 +-
> >  arch/x86/include/asm/atomic64_32.h   |  2 +-
> >  arch/x86/include/asm/cpufeature.h    |  4 ++--
> >  arch/x86/include/asm/irq_stack.h     |  2 +-
> >  arch/x86/include/asm/processor.h     |  6 +++---
> >  arch/x86/include/asm/special_insns.h |  4 ++--
> >  arch/x86/include/asm/uaccess.h       |  4 ++--
> >  9 files changed, 25 insertions(+), 25 deletions(-)
> >
> > --
> > 2.44.0
> >
>
> My one concern is does this work with older compilers?  Technically,
> GCC 5.1 is still supported.  I seem to recall some issues around these
> modifiers in the past, but don't remember any details.  Otherwise,
> it's a nice cleanup.

It will work. Please see [1] for a testcase.

[1] https://godbolt.org/z/eb6rcz8YW

Uros.

