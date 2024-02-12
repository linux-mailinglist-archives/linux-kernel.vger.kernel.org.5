Return-Path: <linux-kernel+bounces-62490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1DA85219A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3AA8B22C05
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8A54DA19;
	Mon, 12 Feb 2024 22:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PheYA0as"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BA84E1BD;
	Mon, 12 Feb 2024 22:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707777718; cv=none; b=Kn50BZxzSxZ1cSWq1obb4Y8YM60P8yKK1kIF5IlaburOAWE5nRyBOH3SET+d9CZJM+74C656BRpM1XEtrFi+TnBF1G4H7+YBnmZs/2V54vK+3nPXPZE4LWed3C29U1xtJyQpNaSz3dTM/2MFuoIoWuXQyDri2huCR7bk0J9NfK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707777718; c=relaxed/simple;
	bh=cAUEs+amnVSeKIK8NpO4FC2BVKtrt76059q1ciUIwV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fP+OHIPknk80BlxCcOxX8TaDwW4hEkf62Uei1CgzD/oUi1SxwnTdvh0p3kV3XH19eSgpD2f8dsXQGi7fIB4gXPoWhPLGbEvC26J+3dx9X/EzgBnQW5a2mcGK8B2e289xcdxkaDm4N0X2481Ede1rzfFYG/aZUExwZGg46geDJEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PheYA0as; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d09bdddfc9so49005401fa.2;
        Mon, 12 Feb 2024 14:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707777714; x=1708382514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiHemHBfh4EaF7fWAPqUeUVvkic0kmQVtldtUj1mK2Q=;
        b=PheYA0asI5hlM8wpj399a7+lw8KcRekZGFLI2pozfjb7isb7T6cf0lPi2E60nKyCcK
         /JtPLeV1fOz602qDhJbBcuV7oxmd+/ROpdoHMO4kwnM+JbRFnVhBrYxWtfRIIscyum2g
         XwkdAa/83Sm4nCshZJQJVFIWmvMZj60aoAWWMhFIlgo4aulboaEkmir0OfaBieoy2eR1
         tZle1g7NYpV5YTR87BG6HdymfozSuE9yqQlfWoVLXG7ciH5IpPJp2SnwxuYP702lvBqR
         yCN3XV4JC5NBJ/c5j5Eh2jO61ctPGPz8+z3L66SGMRfwlygM/JqmMbPzNQqg+YRRdRtL
         yC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707777714; x=1708382514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZiHemHBfh4EaF7fWAPqUeUVvkic0kmQVtldtUj1mK2Q=;
        b=hE45yiRh2Zcv5CvV89aOJXOpugDaCNXYWHiVCQjxaZQOMBqrb5BUDs0YN68nB7mCo6
         a3aE9W9/4C7glq7iiJNZeoWafPf6F+6DkJja08swFiFXHQxzu615YNk9Zz5qnslTMJOl
         Dn/lyOhyOJN0gTgDdR1seSS0NcatfhjeRt12rQp5ULTQ6/osxuxad83i2/YOy2lQpICp
         t9jPILnugeBtER8V6OlBki2r7n+SMW7G900w1+xpSrtnhg84sNAzWRT8PYkZELUhZPbv
         kCRGVOHtyx0qGu5Fhe+39jY6i8JEH3PzsFFNj/6pRC8jf9kpG3iI5lbn1XG40CjXzVrj
         98sQ==
X-Gm-Message-State: AOJu0YwcJX09Sau+zLr7ygTSSaVMgi2H6Kyl5gUuBFEcJaxajr2zRmTT
	841Y4ZnBsDzNNskHVMoaz9tZd3P2X1/SXCW+zCQ2ZZVLSVpkp3yVzY7mxYzVayLBT5EEf0dhj7h
	UDFjQPrlS2M+/oIi04J/6wqpExZg=
X-Google-Smtp-Source: AGHT+IERyjvfCjhn603iTivehWnyeXs3W/EcTiLPKkZ4jkU87YeiavRXuORh8ve9NLURqBkLybIhq4E0QvKF6/s6xIQ=
X-Received: by 2002:a2e:2e11:0:b0:2d0:d3d8:a44d with SMTP id
 u17-20020a2e2e11000000b002d0d3d8a44dmr4995934lju.41.1707777713943; Mon, 12
 Feb 2024 14:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208012057.2754421-2-yshuiv7@gmail.com> <CAK7LNAT0KT7sbZJZNXtq5waM-UjUm4zHyf9xHZc3uHLvZ_eAfA@mail.gmail.com>
 <CAFP8O3Kqx-gdTBFn_hesWzd-6NCpGEz1=fMoJXuX+n4c7sp0Bw@mail.gmail.com>
In-Reply-To: <CAFP8O3Kqx-gdTBFn_hesWzd-6NCpGEz1=fMoJXuX+n4c7sp0Bw@mail.gmail.com>
From: Yuxuan Shui <yshuiv7@gmail.com>
Date: Mon, 12 Feb 2024 22:41:42 +0000
Message-ID: <CAGqt0zzq3yK6340d1OxGAByH+ZQLV3LWY+-WqxTu7MGU0cNbyQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Fix building with LLVM on NixOS
To: Fangrui Song <maskray@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, llvm@lists.linux.dev, nathan@kernel.org, 
	nicolas@fjasle.eu, linux-kbuild@vger.kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 12, 2024 at 9:59=E2=80=AFPM Fangrui Song <maskray@google.com> w=
rote:
>
> On Mon, Feb 12, 2024 at 1:30=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
org> wrote:
> >
> > +Cc: Fangrui Song <maskray@google.com>
> >
> >
> >
> > On Thu, Feb 8, 2024 at 10:22=E2=80=AFAM Yuxuan Shui <yshuiv7@gmail.com>=
 wrote:
> > >
> > > NixOS is designed to have immutable packages, and explicit dependenci=
es.
> > > It allows multiple different versions of the same shared library to
> > > co-exist in its file system.
> > >
> > > Each application built with Nix, the NixOS package manager, will have
> > > paths to its dependency shared libraries hardcoded into its executabl=
e,
> > > this includes the dynamic linker. To achieve this, Nix adds a
> > > --dynamic-linker linker flag when building any application.
> > >
> > > This isn't a problem if the kernel is built with ld.bfd, because ld.b=
fd
> > > ignores the --dynamic-linker flag when the resulting binary doesn't h=
ave
> > > a DT_NEEDED entry. However, ld.lld respects --dynamic-linker
> > > unconditionally, which breaks linking in several cases.
> > >
> > > This commit adds an explicit --no-dynamic-linker flag which overrides
> > > the flag added by Nix.
> >
> >
> >
> > I expect some Acks from LLVM folks (especially, from Frangrui)
> > if this is the right thing to do.
>
> GNU ld seems to ignore --dynamic-linker for a position-dependent
> executable (ET_EXEC) when there is no DT_NEEDED entry.
> ld.lld respects --dynamic-linker in this case. Before this kernel
> report, I do not know any user inconvenienced by this difference.
> (mold respects --dynamic-linker as well.)
> This could be helpful to test an executable with PT_INTERP but no DT_NEED=
ED.
>
> I think this patch does not fix non-x86 builds.

This is true. I am not familiar with non-x86, and I don't have a test
environment for them.
That being said, if you or someone can point to me what other linker
flag variables I need
to change, I will try to fix them as well.

> It feels to me that NixOS should provide a linker wrapper that does
> not force --dynamic-linker=3D.

I actually tried that. The problem is, NixOS tries to enforce the same
build environment
for downstream packages that depend on the kernel (think kernel
modules, perf, etc.) This
is reasonable in most cases. But if I use a linker wrapper that does
_not_ have --dynamic-linker
for the kernel, then all downstream packages will inherit the same
linker wrapper too. This
breaks, for example, zfs. Because its configure script tries to build
some executable and
run them, which fails because it's using a linker wrapper without
--dynamic-linker.

> While it's extremely uncommon (and generally not recommended), certain
> programs invoke the linker directly (instead of using a compiler
> driver).
> Such programs would run into a problem when they make a
> position-dependent executable with no dependency as well.

I don't think I quite get what you are trying to say here.

> I don't feel that NixOS forcing --dynamic-linker=3D is enough
> justification to change linkers.

You already rejected the option of changing lld to match ld.bfd's behavior.
If you reject this kernel patch also, then what's left can only be some hor=
rible
hacks on NixOS' side; or this means NixOS will never get a clang built kern=
el.
Which would be quite unfortunate.

>
> > > Signed-off-by: Yuxuan Shui <yshuiv7@gmail.com>
> > > ---
> > >  Makefile                      | 3 +++
> > >  arch/x86/boot/Makefile        | 2 +-
> > >  arch/x86/realmode/rm/Makefile | 2 +-
> > >  3 files changed, 5 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index a171eafce2a3b..10ed19caecb1b 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -531,6 +531,9 @@ RUSTFLAGS_KERNEL =3D
> > >  AFLAGS_KERNEL  =3D
> > >  LDFLAGS_vmlinux =3D
> > >
> > > +LDFLAGS_MODULE +=3D --no-dynamic-linker
> > > +LDFLAGS_vmlinux +=3D --no-dynamic-linker
> > > +
> > >  # Use USERINCLUDE when you must reference the UAPI directories only.
> > >  USERINCLUDE    :=3D \
> > >                 -I$(srctree)/arch/$(SRCARCH)/include/uapi \
> > > diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> > > index 3cece19b74732..390a4604166eb 100644
> > > --- a/arch/x86/boot/Makefile
> > > +++ b/arch/x86/boot/Makefile
> > > @@ -102,7 +102,7 @@ $(obj)/zoffset.h: $(obj)/compressed/vmlinux FORCE
> > >  AFLAGS_header.o +=3D -I$(objtree)/$(obj)
> > >  $(obj)/header.o: $(obj)/zoffset.h
> > >
> > > -LDFLAGS_setup.elf      :=3D -m elf_i386 -z noexecstack -T
> > > +LDFLAGS_setup.elf      :=3D --no-dynamic-linker -m elf_i386 -z noexe=
cstack -T
> > >  $(obj)/setup.elf: $(src)/setup.ld $(SETUP_OBJS) FORCE
> > >         $(call if_changed,ld)
> > >
> > > diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Mak=
efile
> > > index f614009d3e4e2..4b42006d9ce02 100644
> > > --- a/arch/x86/realmode/rm/Makefile
> > > +++ b/arch/x86/realmode/rm/Makefile
> > > @@ -50,7 +50,7 @@ $(obj)/pasyms.h: $(REALMODE_OBJS) FORCE
> > >  targets +=3D realmode.lds
> > >  $(obj)/realmode.lds: $(obj)/pasyms.h
> > >
> > > -LDFLAGS_realmode.elf :=3D -m elf_i386 --emit-relocs -T
> > > +LDFLAGS_realmode.elf :=3D --no-dynamic-linker -m elf_i386 --emit-rel=
ocs -T
> > >  CPPFLAGS_realmode.lds +=3D -P -C -I$(objtree)/$(obj)
> > >
> > >  targets +=3D realmode.elf
> > > --
> > > 2.43.0
> > >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
> >
>
>
> --
> =E5=AE=8B=E6=96=B9=E7=9D=BF

--=20

Regards
Yuxuan Shui

