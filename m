Return-Path: <linux-kernel+bounces-138383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E9589F06A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8051C22C1B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA32159583;
	Wed, 10 Apr 2024 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6264mrm"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A1A15959A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712747507; cv=none; b=T68ShnEq61yrjkdTcwDwID4awJHeIxC1K7bls1foUqupDxuEV/3ZxuVm7P+/ylmk4syWBwvf3vTNQlxokIlOlVdqFszNgmM9XxjrLbc8v8mRNyq/vljE7sPlH8+lGm05xGLb25Mcu7o/sDQRuY2VFXryrVQxQX3eoz/Z0YEyKVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712747507; c=relaxed/simple;
	bh=OXfAz0ke5s/SmWeG13/scBHiyN4+D24arOVxDAwPrrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhqfDR/K2auKBPItBcEBW7aHEScWk2ByQfsp0dJoTUunNCoh4ccKgtjywUD1VmIyiH9ldWiPHUaaPUkCOJ2CQ16BHjvFnnsoK9Ru+nxmqTgVlY6TlO3UaGYfuULsJU/vs+OZtPs15CDLcZa45OReXOWtAJXCdaJ9IJLsaOW5C/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6264mrm; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3465921600dso706313f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 04:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712747503; x=1713352303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjOzONbMlmADmG3XYm7p48IJrLzQYuZRD5b8PRoWYhU=;
        b=m6264mrmUuGk4mk5MkEJBMr1Wax0UUDjgftWS/2VJrw6ZgoUhsL1maxlAuJ4F+T0Yc
         54L5D3+XthQmFDWb6uSyr/DMGNUdDLOBSIz2793zhEQVdFe7WFGAZAYuZYdR2YR36IIg
         1eVqW2sQWMhnADUFxXpx/HKqw/1C7HntmHf7Ty7GCT1kn7gwSCHgTdBRnwe0w3PkyWdQ
         GNBlDGh3ZR5BI86C3jqpZSteq3yJyQOC+yIkySMsgIFnPnV8CD7t5sG9iUxWGxspPy1w
         a5AgjE93Mx8AbDLDHXtPW3P6fCU3CWsoHCdKIgSyml4/LPiMS2C/q62UApIi5b8P+PNH
         tdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712747503; x=1713352303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjOzONbMlmADmG3XYm7p48IJrLzQYuZRD5b8PRoWYhU=;
        b=ISgnlP7N3d6oUx/7Q1LzElybtKJKxv0V/wkWkfwkwI8Oz1t5pKzhDOFkVCoAPVzITi
         Dc58vc0xMHD0ugvhbBZaqnRJks8LGee8/dbVWYKL3kbL6vYcwSjZN3plwNHEiwd/cZyz
         bqPR/HGFvAjXrXXrDjoKNuISsZ9BITed05dT11qtv/ndTEWwnOhjOy5w3OChEQfOE3kg
         RRxPuG5O8llOjZcIIgyxzBaM5cOgsMatpRpx/mWLBVmp2DnbC5z7a/3iUrJjVAQujZ9n
         Zfi5y/dXF/lHdCWoPNCCsqaPM3Tgo15Hm7497s+XnoKh8FZndcOjjbPtCQaa3lbIsacO
         /6/A==
X-Forwarded-Encrypted: i=1; AJvYcCU+eARHCBy31+ID5C/IuBzLr0VLB23nyBnRlYgka0pm0HnrfcQxQXY2KPlnpDeW52Vb/xpHLXUcRMkYLZftj/6dPHpLE6YmuoGh0uI6
X-Gm-Message-State: AOJu0YzEN4INPV+EeZ997arf7lWePyLjbhviXmMMkWMInqXvxnzOgapj
	myVkpr5Gbd/qT+wUY0aePSU9MuTZ653C0OxKHGdo/eBHRP0AQiyR11XHK3pZn+4+o7LM6VodRiH
	2Q24K3FidBdVlYEzAPLIAaqIY+so=
X-Google-Smtp-Source: AGHT+IHGUdEbtgeyNclcsaNUt1IdA9bgnAB3SDXZSfgDCdpCAw6DjXQD594ugoRzY4FQDxLD7KR+qW9kR/9SwvDVRxM=
X-Received: by 2002:a5d:58f6:0:b0:343:70cc:dedf with SMTP id
 f22-20020a5d58f6000000b0034370ccdedfmr1666476wrd.20.1712747503233; Wed, 10
 Apr 2024 04:11:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231004145137.86537-1-ubizjak@gmail.com> <20231004145137.86537-5-ubizjak@gmail.com>
 <CAHk-=wgepFm=jGodFQYPAaEvcBhR3-f_h1BLBYiVQsutCwCnUQ@mail.gmail.com>
 <CAFULd4YWjxoSTyCtMN0OzKgHtshMQOuMH1Z0n_OaWKVnUjy2iA@mail.gmail.com>
 <CAHk-=whq=+LNHmsde8LaF4pdvKxqKt5GxW+Tq+U35_aDcV0ADg@mail.gmail.com>
 <CAHk-=wi6U-O1wdPOESuCE6QO2OaPu0hEzaig0uDOU4L5CREhug@mail.gmail.com>
 <CAFULd4Z3C771u8Y==8h6hi=mhGmy=7RJRAEBGfNZ0SmynxF41g@mail.gmail.com>
 <ZSPm6Z/lTK1ZlO8m@gmail.com> <CAFULd4Z=S+GyvtWCpQi=_mkkYvj8xb_m0b0t1exDe5NPyAHyAA@mail.gmail.com>
In-Reply-To: <CAFULd4Z=S+GyvtWCpQi=_mkkYvj8xb_m0b0t1exDe5NPyAHyAA@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 10 Apr 2024 13:11:32 +0200
Message-ID: <CA+fCnZen+5XC4LFYuzhdAjSjY_Jh0Yk=KYXxcYxkMDNj3kY9kA@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86/percpu: Use C for percpu read/write accessors
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, 
	Nadav Amit <namit@vmware.com>, Brian Gerst <brgerst@gmail.com>, 
	Denys Vlasenko <dvlasenk@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 9, 2023 at 4:35=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wrot=
e:
>
> On Mon, Oct 9, 2023 at 1:41=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wro=
te:
> >
> >
> > * Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > index ecb256954351..1edf4a5b93ca 100644
> > > --- a/arch/x86/Kconfig
> > > +++ b/arch/x86/Kconfig
> > > @@ -2393,7 +2393,7 @@ config CC_HAS_NAMED_AS
> > >
> > >  config USE_X86_SEG_SUPPORT
> > >       def_bool y
> > > -     depends on CC_HAS_NAMED_AS && SMP
> > > +     depends on CC_HAS_NAMED_AS && SMP && !KASAN
> > > +     depends on CC_HAS_NAMED_AS && SMP && !KASAN
> >
> > So I'd rather express this as a Kconfig quirk line, and explain each qu=
irk.
> >
> > Something like:
> >
> >         depends on CC_HAS_NAMED_AS
> >         depends on SMP
> >         #
> >         # -fsanitize=3Dkernel-address (KASAN) is at the moment incompat=
ible
> >         # with named address spaces - see GCC bug #12345.
> >         #
> >         depends on !KASAN
>
> This is now PR sanitizer/111736 [1], but perhaps KASAN people [CC'd]
> also want to be notified about this problem.
>
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D111736

Filed a KASAN bug to track this:
https://bugzilla.kernel.org/show_bug.cgi?id=3D218703

Thanks!

