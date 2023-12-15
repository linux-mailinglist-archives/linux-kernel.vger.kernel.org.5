Return-Path: <linux-kernel+bounces-1676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 099358151F7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87EB81F2498B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E506482EC;
	Fri, 15 Dec 2023 21:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FmM2wnQ1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3AA47F7D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 21:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40c38e292c8so6375915e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702676337; x=1703281137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+wpmWfQ69i2h2HPYJ9FCWJfXjf9N6+LF6vPb/Va2u4=;
        b=FmM2wnQ110ilfLpu7A3yuzF7ui28ae79yTMQ2h2VwdGUOg0B0fra0zvgFoSbMiERIR
         9qLZM59MmNq0NlwmsHzcwm9y4ZB2ytQa8gHzBiQFlTQf2Lz8IbAdcc4TdtxVMNnSlkPe
         rLjsYfPKAX/0wZEODlLPoZ9lSsX7UG1i7WFpGT5bJG3IJrpmvUqnuhu60N8/VNJXJogg
         9isS1J/mrEA34WjTMFTTNxs8FBRrOjAuPOmwHcg8m+BlDoOG1KvM418+MmxtsNSUfwvy
         5fe4miNIzovvQ/zHBErFZITg79XN1AonlLigKA9L09FZVQnYUlyi52IFfQZBGpX6f0LP
         SZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702676337; x=1703281137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+wpmWfQ69i2h2HPYJ9FCWJfXjf9N6+LF6vPb/Va2u4=;
        b=wQaglWMyRarkfCCSTpTu73pW411mpkoqgQ+4KPAQwbR9dJYpSXFXnptVKbY8UOHQE6
         LEJ2kPyjpvCNUDHFT3iPTIupCUuDqX+gLBqEQphQ0cI6bt3G1XQORp+urDmQneixn2Z7
         zsyKSls83rtXC+O6i4CzMjpKX18EWKXbI9UbnkAB5bW3vmlw0x4JOuYM5efrFWgBrUoP
         7pbzbNjW+RMTSA4T7p/bLHC2PYzMaZ5D+wgQ6i7DX5merG6dL0nwknZZ4DCy7MbiqPrr
         PIw5Fu+EdJ5Qh4sizOsgpebghUbPJ7n0iF7mrZCHJVmkJdhhdpOg/0ImMLvnCeXKG6d6
         v39A==
X-Gm-Message-State: AOJu0YwFlshOBZTtYtERtpRvfKOywwz0dN6/BzAQ9OEIOyxioQfXAaMG
	loVedcIa8nEr9A6VXJ/ZNn3Yr2wlBHqMlDFdoj9+wQ==
X-Google-Smtp-Source: AGHT+IH9FjwxGaf6+u4p9k99EvQ2jqjWrSdNp33yUuzHXgOPEdQVKisFJrPgKdD++/i+p2advjQXB5meo5+K3hOWWcE=
X-Received: by 2002:a05:600c:b50:b0:40b:5e26:2382 with SMTP id
 k16-20020a05600c0b5000b0040b5e262382mr6281044wmr.51.1702676336714; Fri, 15
 Dec 2023 13:38:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215190521.3796022-1-chrisko@google.com> <b086fd82-2989-4987-a3f6-021a4ae9bec4@intel.com>
In-Reply-To: <b086fd82-2989-4987-a3f6-021a4ae9bec4@intel.com>
From: Chris Koch <chrisko@google.com>
Date: Fri, 15 Dec 2023 13:38:34 -0800
Message-ID: <CAA0N8zb0ddnDpZdaOeb0G2azd-jPu3qtxWPQgaWC24f6VgqY6Q@mail.gmail.com>
Subject: Re: [PATCH] kexec: allocate kernel above bzImage's pref_address
To: Dave Hansen <dave.hansen@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Cloud Hsu <cloudhsu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 1:17=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 12/15/23 11:05, Chris Koch wrote:
> > A relocatable kernel will relocate itself to pref_address if it is
> > loaded below pref_address. This means a booted kernel may be relocating
> > itself to an area with reserved memory on modern systems, potentially
> > clobbering arbitrary data that may be important to the system.
> >
> > This is often the case, as the default value of PHYSICAL_START is
> > 0x1000000 and kernels are typically loaded at 0x100000 or above by
> > bootloaders like iPXE or kexec. GRUB behaves like this patch does.
> >
> > Also fixes the documentation around pref_address and PHYSICAL_START to
> > be accurate.
>
> Are you reporting a bug and is this a bug fix?  It's not super clear
> from the changelog.

I reported it as a bug yesterday in
https://lkml.org/lkml/2023/12/14/1529 -- I'm happy to reword this in
some way that indicates it's a bug fix.

>
>
> > diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/b=
oot.rst
> > index 22cc7a040dae..49bea8986620 100644
> > --- a/Documentation/arch/x86/boot.rst
> > +++ b/Documentation/arch/x86/boot.rst
> > @@ -878,7 +878,8 @@ Protocol: 2.10+
> >    address if possible.
> >
> >    A non-relocatable kernel will unconditionally move itself and to run
> > -  at this address.
> > +  at this address. A relocatable kernel will move itself to this addre=
ss if it
> > +  loaded below this address.
>
> I think we should avoid saying the same things over and over again in
> different spots.
>
> Here, it doesn't really help to enumerate the different interpretations
> of 'pref_address'.  All that matters is that the bootloader can avoid
> the overhead of a later copy if it can place the kernel at
> 'pref_address'.  The exact reasons that various kernels might decide to
> relocate are unimportant here.

I think it's important documentation for bootloader authors. It's not
about avoiding overhead, it's about avoiding clobbering areas of
memory that may be reserved in e820 / EFI memory map, which the kernel
will do when it relocates itself to pref_address without checking
what's reserved and what's not. It emphasizes the importance of
choosing an address above pref_address. Happy to reword some way to
reflect that.

>
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D
> >  Field name:  init_size
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 3762f41bb092..1370f43328d7 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -2109,11 +2109,11 @@ config PHYSICAL_START
> >       help
> >         This gives the physical address where the kernel is loaded.
> >
> > -       If kernel is a not relocatable (CONFIG_RELOCATABLE=3Dn) then
> > -       bzImage will decompress itself to above physical address and
> > -       run from there. Otherwise, bzImage will run from the address wh=
ere
> > -       it has been loaded by the boot loader and will ignore above phy=
sical
> > -       address.
> > +       If the kernel is not relocatable (CONFIG_RELOCATABLE=3Dn) then =
bzImage
> > +       will decompress itself to above physical address and run from t=
here.
> > +       Otherwise, bzImage will run from the address where it has been =
loaded
> > +       by the boot loader. The only exception is if it is loaded below=
 the
> > +       above physical address, in which case it will relocate itself t=
here.
>
> I kinda dislike how this is written.  It's written almost like code
> where you're spelling out the conditions.  I prefer something much
> higher-level.
>
>         This gives a minimum physical address at which the kernel can be
>         loaded.
>
>         CONFIG_RELOCATABLE=3Dn kernels will be decompressed to and must
>         run at PHYSICAL_START exactly.
>
>         CONFIG_RELOCATABLE=3Dy kernels can run at any address above
>         PHYSICAL_START.  If a kernel is loaded below PHYSICAL_START, it
>         will relocate itself to PHYSICAL_START.

Happy to change that, yours is better.

>
> >         In normal kdump cases one does not have to set/change this opti=
on
> >         as now bzImage can be compiled as a completely relocatable imag=
e
> > diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-=
bzimage64.c
> > index a61c12c01270..5dcd232d58bf 100644
> > --- a/arch/x86/kernel/kexec-bzimage64.c
> > +++ b/arch/x86/kernel/kexec-bzimage64.c
> > @@ -498,7 +498,10 @@ static void *bzImage64_load(struct kimage *image, =
char *kernel,
> >       kbuf.bufsz =3D  kernel_len - kern16_size;
> >       kbuf.memsz =3D PAGE_ALIGN(header->init_size);
> >       kbuf.buf_align =3D header->kernel_alignment;
> > -     kbuf.buf_min =3D MIN_KERNEL_LOAD_ADDR;
> > +     if (header->pref_address < MIN_KERNEL_LOAD_ADDR)
> > +             kbuf.buf_min =3D MIN_KERNEL_LOAD_ADDR;
> > +     else
> > +             kbuf.buf_min =3D header->pref_address;
> >       kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> >       ret =3D kexec_add_buffer(&kbuf);
> >       if (ret)
>
> Comment, please.
>
> It isn't clear from this hunk why or how this fixes the bug.  How does
> this manage to avoid clobbering reserved areas?

When allocated above pref_address, the kernel will not relocate itself
to an area that potentially overlaps with reserved memory. I'll add a
comment.

Not sure what the etiquette is on immediately sending a patch v2, or
waiting for more comments. I'll err on waiting on a couple more
comments before sending v2. Thanks for the review

Chris

