Return-Path: <linux-kernel+bounces-138387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0DF89F08E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2064A283CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0748C1598F2;
	Wed, 10 Apr 2024 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFRW50U2"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9515F1598E8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748099; cv=none; b=leqPr8XybAUGpG4430ZU5x1cj888zStS8Hm3Q469uUGGpCNt4yFQEQfgv3d6o8qSHuvrOGIq39KL2OL14rThZazmIQM24h4U6kvNThjBDwGAWwSQR3Nzz+c7sKMjsV13Y9f8lA5kKdLVjyYSfQsEIEBlTnj89GoyXkDfueEQa6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748099; c=relaxed/simple;
	bh=oTffGc+EO1lAJbCgG3QBoGQfVS7A6Ola4sFH696sM8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvEyo03ekUNPZfJ5YFdC+JkW1OO561TJdf8cd72LGcsSh6OI5B0E49mir8PKMNXKDb7dpk9fZcOrLAUJ2kHHmWKRYfKiEpdz86q/c7Jeo+9NNnnW3hC6yHU61g2mj+UHr/EtI3B2XGbStwmwO9jckkZGRCnXsmvEqMPTi/0QHfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFRW50U2; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d700beb60bso107293551fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 04:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712748096; x=1713352896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ud+517cbK3MIdJCHymhuRgamDd5LkAQgdCc6QwW3VM0=;
        b=aFRW50U2+0nhJ+cBO0+6Oxs3N7cRXo+ygxCqmjSUiUmXgvPBzp/1ZDHzWaMJRgFzhm
         e6vtlVFP3W7inyMmko5XWKMOcgzKFKfF0wcCiyzH2Njp5zb1SwPqsTq5hk1sK/IR7vEj
         EBPPB/uO0JyTmiCEupsBfqQDLqinzoIGnHonM22FvOf/R9so0kIPhXLckicAHmsv5eWJ
         FaObPgz3gzwTBZklTdF9cALffvGoU+aftmk9Fr9U2n/ET+MoRz8mPTUDBlUlIDajBDjH
         l6Sr8d01u/n9qaI2kA7do5Ruh73Bd5suTKI/OONj7xwCHWsSL2kleKg+IJIeEZdmfuTd
         gnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712748096; x=1713352896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ud+517cbK3MIdJCHymhuRgamDd5LkAQgdCc6QwW3VM0=;
        b=gkCcCevvEm/S3IcvL8PmjdNlN1Suqc41Ho4sfnmmZjkWZaGZnj7cdY3wxlc/PSqgH0
         2rTx+RA8ffEwFv+9j9/eNAtMNXF9Z8HvYqxjpiVq6o6t53XaERVBfFuChs/uyTiT/wxB
         mDI2o7vthqXXpxoT39ByV0BqotETU83lpz8tJ38XoQXgjjTfOICJleOiMZDsCaQrKUOX
         QlTgXrgt0jlFNgh6NWAQpqfVKrv8WaxBPtUPaSTZoNjd1W3SqGXdAyNxJR6HgSH1188w
         mdZpMjYGR+r2eNCqfy9o5szFRo3XlvVgH7W3HU4G4FjHExbxik3dSTT+Yn06GoLAD0V0
         Vu1w==
X-Forwarded-Encrypted: i=1; AJvYcCVAoOW1PbhnZxsIHXWa8C7u5N/xNRQC+LQzcPAMBkYIc+VKPfikSAJCLafiVk4926KlBUFNzUX6BJqwoT+DLauHqA3sUYi6bY6kSG0F
X-Gm-Message-State: AOJu0YwVueIgh870kU1NPRoTaniHnmsGiu69YsoM5obpQWEdPuAV3Qqg
	sVAI+5SbNz3A8cKsj9ynZFYKiJFaoHwOx/1EEtGjtBNBhieT0qwVrE3+sbvIjl2VHoAmCo0gxcU
	UdPbU44niq6fp32zWvFIkNJIwklw=
X-Google-Smtp-Source: AGHT+IHyTnRS2cj+jC6mWGrGRlbdmCffxUxUYisErEJfoatyZBVPbyUmm9ghK+3G+vcqEpM8cBT9qeA0JbnpSXXzOwE=
X-Received: by 2002:a05:651c:b8c:b0:2d8:5a4b:17b1 with SMTP id
 bg12-20020a05651c0b8c00b002d85a4b17b1mr2109029ljb.15.1712748095459; Wed, 10
 Apr 2024 04:21:35 -0700 (PDT)
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
 <CA+fCnZen+5XC4LFYuzhdAjSjY_Jh0Yk=KYXxcYxkMDNj3kY9kA@mail.gmail.com>
In-Reply-To: <CA+fCnZen+5XC4LFYuzhdAjSjY_Jh0Yk=KYXxcYxkMDNj3kY9kA@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 10 Apr 2024 13:21:23 +0200
Message-ID: <CAFULd4aJd6YKXZr=AZ7yzNkiR4_DfL5soQSvhMhNiQEPUOS87g@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86/percpu: Use C for percpu read/write accessors
To: Andrey Konovalov <andreyknvl@gmail.com>
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

On Wed, Apr 10, 2024 at 1:11=E2=80=AFPM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
>
> On Mon, Oct 9, 2023 at 4:35=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wr=
ote:
> >
> > On Mon, Oct 9, 2023 at 1:41=E2=80=AFPM Ingo Molnar <mingo@kernel.org> w=
rote:
> > >
> > >
> > > * Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > > index ecb256954351..1edf4a5b93ca 100644
> > > > --- a/arch/x86/Kconfig
> > > > +++ b/arch/x86/Kconfig
> > > > @@ -2393,7 +2393,7 @@ config CC_HAS_NAMED_AS
> > > >
> > > >  config USE_X86_SEG_SUPPORT
> > > >       def_bool y
> > > > -     depends on CC_HAS_NAMED_AS && SMP
> > > > +     depends on CC_HAS_NAMED_AS && SMP && !KASAN
> > > > +     depends on CC_HAS_NAMED_AS && SMP && !KASAN
> > >
> > > So I'd rather express this as a Kconfig quirk line, and explain each =
quirk.
> > >
> > > Something like:
> > >
> > >         depends on CC_HAS_NAMED_AS
> > >         depends on SMP
> > >         #
> > >         # -fsanitize=3Dkernel-address (KASAN) is at the moment incomp=
atible
> > >         # with named address spaces - see GCC bug #12345.
> > >         #
> > >         depends on !KASAN
> >
> > This is now PR sanitizer/111736 [1], but perhaps KASAN people [CC'd]
> > also want to be notified about this problem.
> >
> > [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D111736
>
> Filed a KASAN bug to track this:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D218703

Please note the fix in -tip tree that reenables sanitizers for fixed compil=
ers:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=3Dx86=
/percpu&id=3D9ebe5500d4b25ee4cde04eec59a6764361a60709

Thanks,
Uros.

