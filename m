Return-Path: <linux-kernel+bounces-62390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E64851F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF2D1C224CD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3186A4CB5C;
	Mon, 12 Feb 2024 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBh9GsN2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D774CB4A;
	Mon, 12 Feb 2024 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773434; cv=none; b=JElRMF5AL3iZVFN4W1O8gZqRybWwID2y9QMsILZOrrW0JoEhDymPQskXKOVXiLNO635QUNdcX9UBBK/F3oxyEYvLkebIWnbJT7hH0Qs/blfWtF+NpJ5px9X1b9DTL87rr4yQwQIfCE3juBZx12sU0tje8oWB7jXeQgWl8m3ZPzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773434; c=relaxed/simple;
	bh=IDcEWsDLa+W/tADrSclCXIDqdaEJoRI6zAbAWffUmhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e262zVxrVTJ+ZUDoUBPwEIXtWsFdW07sUxQS4PTHcPs+aLG5f6rTn5AVxxmJRlMeIPm6RyeAwhAdQtjN0XqCml87CU6e9g0y7TiH6B4K2j9UqcyExD65hEL5tTCMANmmsEU78Vba8qzp8H8MQmZrbjNIQiBbTySwacqwUpx5ZkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBh9GsN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0995CC43394;
	Mon, 12 Feb 2024 21:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707773434;
	bh=IDcEWsDLa+W/tADrSclCXIDqdaEJoRI6zAbAWffUmhE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tBh9GsN2YTr0uV1cMX3NEaVhUFAZ/7k1vl7DCHtpUOGDZvMduBCBLm1h1eHfuvRbg
	 OHSmUiydH+Sw15gNRuGOLooI26oac2VgeeWdORWnLEmYcPLZ5Q6YWaPMoLOVWtJFty
	 eVkmIgHz+wZ4E5iBcKFihe5/LFfV8Vfvlm6Ceg/jHurgPLexrxmIq8wLrk0HRXtf8+
	 EXnDIOgg61fTydzJSmV2bVVvZJ78m3v67BN47mMbgglWJmI1NwI9ixXQJB5s+91mc2
	 2yuPydGeqBRPLoK6ivhPacFPnkQvfiDdDAgD9U2Z3pMm+NmJeyWpSxbHJ4FrQrciBk
	 i4QqOMdGiHBwA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-511898b6c9eso1811229e87.3;
        Mon, 12 Feb 2024 13:30:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9hLkGFdHreaMr3S65hP+zqRXl5u9vTDF1J877Tx4XWEptM4SNHuBIxW/q8J2/cGmVLzGne9dPux2DtK2UOLxLylXrdn49WLoE6BM5X43ZYcrYpl0kRjuH0dF8Yu5nuoi6r20MGRau/ku6
X-Gm-Message-State: AOJu0Ywr1Sr/MMqt1F1Ao2tBDvQhoFgETVO/icoe+RbFYIOdnixOAjgc
	Qv/DnN2OkQjbOoxqKavf35bxDQRwZ0kSJLDFR5/FKgS3ipCAjkpEljlojQ08FhK8vBI/N7XZFpV
	3JRpAeci8Sb0Utqx9194Cx8V4oFc=
X-Google-Smtp-Source: AGHT+IFF7NM/Y8BmMMUYJCxgIz4JDYBoiGpG9Wkp7V3yEjm3Wk0ZoHbI8xHfixr5nQ0N/NXdCvdV1+LWDtCJYwzuutE=
X-Received: by 2002:a05:6512:104b:b0:511:84f1:b895 with SMTP id
 c11-20020a056512104b00b0051184f1b895mr5001222lfb.4.1707773432532; Mon, 12 Feb
 2024 13:30:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208012057.2754421-2-yshuiv7@gmail.com>
In-Reply-To: <20240208012057.2754421-2-yshuiv7@gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 13 Feb 2024 06:29:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT0KT7sbZJZNXtq5waM-UjUm4zHyf9xHZc3uHLvZ_eAfA@mail.gmail.com>
Message-ID: <CAK7LNAT0KT7sbZJZNXtq5waM-UjUm4zHyf9xHZc3uHLvZ_eAfA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Fix building with LLVM on NixOS
To: Yuxuan Shui <yshuiv7@gmail.com>
Cc: llvm@lists.linux.dev, nathan@kernel.org, nicolas@fjasle.eu, 
	linux-kbuild@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Cc: Fangrui Song <maskray@google.com>



On Thu, Feb 8, 2024 at 10:22=E2=80=AFAM Yuxuan Shui <yshuiv7@gmail.com> wro=
te:
>
> NixOS is designed to have immutable packages, and explicit dependencies.
> It allows multiple different versions of the same shared library to
> co-exist in its file system.
>
> Each application built with Nix, the NixOS package manager, will have
> paths to its dependency shared libraries hardcoded into its executable,
> this includes the dynamic linker. To achieve this, Nix adds a
> --dynamic-linker linker flag when building any application.
>
> This isn't a problem if the kernel is built with ld.bfd, because ld.bfd
> ignores the --dynamic-linker flag when the resulting binary doesn't have
> a DT_NEEDED entry. However, ld.lld respects --dynamic-linker
> unconditionally, which breaks linking in several cases.
>
> This commit adds an explicit --no-dynamic-linker flag which overrides
> the flag added by Nix.



I expect some Acks from LLVM folks (especially, from Frangrui)
if this is the right thing to do.







> Signed-off-by: Yuxuan Shui <yshuiv7@gmail.com>
> ---
>  Makefile                      | 3 +++
>  arch/x86/boot/Makefile        | 2 +-
>  arch/x86/realmode/rm/Makefile | 2 +-
>  3 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index a171eafce2a3b..10ed19caecb1b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -531,6 +531,9 @@ RUSTFLAGS_KERNEL =3D
>  AFLAGS_KERNEL  =3D
>  LDFLAGS_vmlinux =3D
>
> +LDFLAGS_MODULE +=3D --no-dynamic-linker
> +LDFLAGS_vmlinux +=3D --no-dynamic-linker
> +
>  # Use USERINCLUDE when you must reference the UAPI directories only.
>  USERINCLUDE    :=3D \
>                 -I$(srctree)/arch/$(SRCARCH)/include/uapi \
> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> index 3cece19b74732..390a4604166eb 100644
> --- a/arch/x86/boot/Makefile
> +++ b/arch/x86/boot/Makefile
> @@ -102,7 +102,7 @@ $(obj)/zoffset.h: $(obj)/compressed/vmlinux FORCE
>  AFLAGS_header.o +=3D -I$(objtree)/$(obj)
>  $(obj)/header.o: $(obj)/zoffset.h
>
> -LDFLAGS_setup.elf      :=3D -m elf_i386 -z noexecstack -T
> +LDFLAGS_setup.elf      :=3D --no-dynamic-linker -m elf_i386 -z noexecsta=
ck -T
>  $(obj)/setup.elf: $(src)/setup.ld $(SETUP_OBJS) FORCE
>         $(call if_changed,ld)
>
> diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefil=
e
> index f614009d3e4e2..4b42006d9ce02 100644
> --- a/arch/x86/realmode/rm/Makefile
> +++ b/arch/x86/realmode/rm/Makefile
> @@ -50,7 +50,7 @@ $(obj)/pasyms.h: $(REALMODE_OBJS) FORCE
>  targets +=3D realmode.lds
>  $(obj)/realmode.lds: $(obj)/pasyms.h
>
> -LDFLAGS_realmode.elf :=3D -m elf_i386 --emit-relocs -T
> +LDFLAGS_realmode.elf :=3D --no-dynamic-linker -m elf_i386 --emit-relocs =
-T
>  CPPFLAGS_realmode.lds +=3D -P -C -I$(objtree)/$(obj)
>
>  targets +=3D realmode.elf
> --
> 2.43.0
>


--=20
Best Regards
Masahiro Yamada

