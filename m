Return-Path: <linux-kernel+bounces-157571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC49F8B130E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E59D2B22FEC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393091CF8F;
	Wed, 24 Apr 2024 19:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN3Dr/oZ"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7112319479
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985258; cv=none; b=gG2fohO2alq/9x2LAMJIVl9w5Vbth4eNhpUPhnBNpzv2t2V5sEeYB3AuhO1tAXMvS462vIhtr33PPBE+GtQRXejIeeXyKgsC+be5Wrrxpo+BrEvLTJnPNii46chYhuvVkdJ5qa2W3iQXUf6ilNpStDlIilGbZSUpa7fKzVEAfo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985258; c=relaxed/simple;
	bh=bNe1LwivQ7x1iIF0+qk4j+3O3sy3kZEF2aWBuMXA2jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIm3ow+7wjQTVQ7VblioEKBo3drDj4QqNMZeWLy+w4HsNPzb3ypTpfzfQsrtE8cFWkiXLYbG9Dwb70h85Ub5hdov57D5cZEzLfkLHQj2UeTNzCYKSDRMhEXdbiLoJjJSGmnNe6z//Zlm7P728zAjVZFQ8bswfAs3nBDeNtcicls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LN3Dr/oZ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51aa6a8e49aso153707e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713985240; x=1714590040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/9BAtndkfFaumCrUJiPVhEbeA1SDIK0JZwe5FMmllc=;
        b=LN3Dr/oZjdSSLza53wJvzWo5l4tvxPLQTuXq1tOfmWmSZ82IhJ5ad1pX0Mj5n2Mfbr
         LdIXTbj8x9XiyRIlWmos7luy/uUxFjPh6FmjDXRTGF0VmYm8GygG3kVyYLdppZViKjp1
         K2cG1/j+O16NtnbAJx5o/q5Tl81daqe1bqMWvvgiEqIFPFyOZqkwrW016w+s6ncI1x2x
         ICIL9yfvYHdsYDn+20XPhHKsxAjOHfMROGnInOOrh1tciZ9uRTQDsKwvIkbIv6OTAsiQ
         XwP9EdBU7E37plAVHK0XOb9PyaZCD7Dhry/JMwI15WS6VQO7fyPFDj/VgaCmA16griBm
         vrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713985240; x=1714590040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/9BAtndkfFaumCrUJiPVhEbeA1SDIK0JZwe5FMmllc=;
        b=ChNhapZ1Ll7dzfpe33VCrgQfrLv19f1o1YYLWlmQHTCST6JFgvHfbiXt6fitF6/DVn
         lJ6y3dwx/f806K9NNAM+6SE3IKDqfhs0N9jlfKEmIiaFEMtFXDqRpzHxSrf48EOPqk4+
         NWCfZs3cGOTatB92BjM26Sznv42S1f7RrknQI3gSMQTKBUkVwxurNct25ja0SHiBiM/c
         NDSOBKNS5xyv/12Sx7Fe1mgmfatvpm2SW7q8S1se8Zh3ZQGH9h4v7C7EWGaVKEmddanc
         cQE91tYB5hra2dwUUvKkEZKGa20N2YD23nZqi4Og0Uq3+xC0o0gGAHcrU5hq5g3JNxYC
         7Dkg==
X-Forwarded-Encrypted: i=1; AJvYcCUffoRomSTEHIYy2qVCu6P7xLjajZmuQQ2duz1eaq6Wg353WWx6Dsoc8CD8n2hB9TvCrQXWn9b691q+6Ca2qSZ5NvgDSXRpli0Kb354
X-Gm-Message-State: AOJu0YzA4BI/Vi6Q4QJOXwsNwZHVL8Ch74/O/VAFUIAnIU7QJPmNxOA9
	Z8F4az7xqx58ZWgp1oJJbLUW1iH/Vz2zeumShmvQCSl+2cGcXGPj+gGKrK8i2e3daFpQvBd56m1
	keLT2hH2ylZx2nT5Epk3lSuspuw==
X-Google-Smtp-Source: AGHT+IGEmd97FetLZJu0mAN91ayBFJQ9xH9F8cfXfx+F3E2f/agJ9cJde+HWlwi4T3gsTOtiOQ41z4M3hWPYLhL845E=
X-Received: by 2002:a19:e00f:0:b0:51c:10b4:1d01 with SMTP id
 x15-20020a19e00f000000b0051c10b41d01mr1231030lfg.21.1713985239330; Wed, 24
 Apr 2024 12:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com>
 <20240424155309.1719454-15-ardb+git@google.com> <CAMzpN2g3E3Pj1wso0rUR5EWrHqTuUePsOWcQGf29wNkMa0+G3w@mail.gmail.com>
 <CAMj1kXE4f7UERE-x4CghW3=wQrvT1b2ODRSX3z6QAoy_wSJjiw@mail.gmail.com>
In-Reply-To: <CAMj1kXE4f7UERE-x4CghW3=wQrvT1b2ODRSX3z6QAoy_wSJjiw@mail.gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Wed, 24 Apr 2024 15:00:27 -0400
Message-ID: <CAMzpN2iT+j_f4wOWGG4JtQCKyUUe4XCtqAO7Set7cqZw8DsB_g@mail.gmail.com>
Subject: Re: [RFC PATCH 4/9] x86/purgatory: Avoid absolute reference to GDT
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 1:53=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> Hi Brian,
>
> Thanks for taking a look.
>
> On Wed, 24 Apr 2024 at 19:39, Brian Gerst <brgerst@gmail.com> wrote:
> >
> > On Wed, Apr 24, 2024 at 12:06=E2=80=AFPM Ard Biesheuvel <ardb+git@googl=
e.com> wrote:
> > >
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > The purgatory is almost entirely position independent, without any ne=
ed
> > > for any relocation processing at load time except for the reference t=
o
> > > the GDT in the entry code. Generate this reference at runtime instead=
,
> > > to remove the last R_X86_64_64 relocation from this code.
> > >
> > > While the GDT itself needs to be preserved in memory as long as it is
> > > live, the GDT descriptor that is used to program the GDT can be
> > > discarded so it can be allocated on the stack.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > ---
> > >  arch/x86/purgatory/entry64.S | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/x86/purgatory/entry64.S b/arch/x86/purgatory/entry6=
4.S
> > > index 9913877b0dbe..888661d9db9c 100644
> > > --- a/arch/x86/purgatory/entry64.S
> > > +++ b/arch/x86/purgatory/entry64.S
> > > @@ -16,7 +16,11 @@
> > >
> > >  SYM_CODE_START(entry64)
> > >         /* Setup a gdt that should be preserved */
> > > -       lgdt gdt(%rip)
> > > +       leaq    gdt(%rip), %rax
> > > +       pushq   %rax
> > > +       pushw   $gdt_end - gdt - 1
> > > +       lgdt    (%rsp)
> > > +       addq    $10, %rsp
> >
> > This misaligns the stack, pushing 16 bytes on the stack but only
> > removing 10 (decimal).
> >
>
> pushw subtracts 2 from RSP and stores a word. So the total size stored
> is 10 decimal not 16.

I didn't notice the pushw, since I didn't think a 16-bit push was even
possible in 64-bit mode. Unexpected, but clever.


Brian Gerst

