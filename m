Return-Path: <linux-kernel+bounces-36902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A24FF83A872
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44025B28C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970A355797;
	Wed, 24 Jan 2024 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4Y0YNtR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE75A54BE6;
	Wed, 24 Jan 2024 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096655; cv=none; b=E3hxfOGbP7su+t3n0dL+Z3ysKrmMFq/e+Beiwv3jQuRWyWLq8m7RgGhG29uJni5J6iSS1jcHYSZOdGIEAT9fQciSkyNhW2IDDwGHxYe1mKfnVmD/Tvoto7DNsDyxgMqL7hmZlOzCxHvKXonogSBV3wiLGG3/TIL6ivF2uUepK2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096655; c=relaxed/simple;
	bh=ou25a266zywPby6WgQZvxo8eRAMCHvr/U81WBrVmjzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i2MAnE8KLtfk+bzslUh+GW+QITMa/Kiwn/C7UB17ZV1iKlBG6FHx0eaU7HHnWQXnz1sWe+BbbgxeFuI3zIaWjYCpTwM7pFOC6QpFKfk0exrrW51nYw5wphDGBCts6hSHXSlmUmePb4eLCuY/fK8/zNCjqJrUBosU6B6OxA8bzyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4Y0YNtR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DD4C433F1;
	Wed, 24 Jan 2024 11:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706096655;
	bh=ou25a266zywPby6WgQZvxo8eRAMCHvr/U81WBrVmjzc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M4Y0YNtRXTQQiNf1u95ImNgJFx/IuA9k+rhvL31XQF252omLvwFuJj3aa7tDNP3A+
	 zX9c1d5Ge5oG+qIRRWOODoEKRIdW3RjulRtrkdf+ySEwYQh2UZekpO3tY/n/fM/Umr
	 kpztZeB98FTlDstIY/S2OuhKB1Bns9/hUS3c/z8JfwtDIpAEXtP3Z87oS4Xk2845eb
	 kCyPymOwX6TOT6rHhjNHxCYYcJgPrfHXEC+W9aDBw086f3uqGIuUyyGamUuGaYTy0A
	 +2LgnOuVRLrW2Pu9nHGdQgixMAfvJmQOnhBD4G05qKWQaA8e8VSy9v/TWLcwlcNqTT
	 pdJjKBUM4d5bw==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2144ce7ff41so1426204fac.3;
        Wed, 24 Jan 2024 03:44:15 -0800 (PST)
X-Gm-Message-State: AOJu0YyjrC7i5WBnuo7YOT73AtykgNVPq3qyBt4yBdAH+EWMTY7oXQFG
	hYtu7Po4Beu/GHVUIx7OBt7sjcsVoUCFx7O9kkI8y0FrDn/w4m2h68jhgDblpEIhdQkPh6fbk9P
	aRLDv8untByrC6v9KcahIQI9lIsk=
X-Google-Smtp-Source: AGHT+IEMVGqsuzMCKOKoIen+3nitjN3cwCrv4EKUfGicBenAK+wGKt0aQgHx+W7R5oTxTFkXNygDac5vAQamsYteasc=
X-Received: by 2002:a05:6871:a6a6:b0:210:b306:e710 with SMTP id
 wh38-20020a056871a6a600b00210b306e710mr2893063oab.115.1706096654684; Wed, 24
 Jan 2024 03:44:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231125163559.824210-1-masahiroy@kernel.org> <CAMuHMdWm6u1wX7efZQf=2XUAHascps76YQac6rdnQGhc8nop_Q@mail.gmail.com>
 <d21298d9-fed6-4e08-9780-dbcb388b9ccc@smile.fr> <CAK7LNASaG4DpHTb3YHMd8d8DJ5H3z0aiUcSqX+=7CZb99kRU8A@mail.gmail.com>
 <CAMuHMdWLMNj=Yvf4QxxrCxf-UBr-VXUxfJei+V2bNd0M7D1OhQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWLMNj=Yvf4QxxrCxf-UBr-VXUxfJei+V2bNd0M7D1OhQ@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 24 Jan 2024 20:43:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNASDNLJ-dUPmFF=miMz2hj_cV2yrqTR8NQ_OGdazFdnSZw@mail.gmail.com>
Message-ID: <CAK7LNASDNLJ-dUPmFF=miMz2hj_cV2yrqTR8NQ_OGdazFdnSZw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kconfig: remove unneeded symbol_empty variable
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoann Congal <yoann.congal@smile.fr>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, 
	Vegard Nossum <vegard.nossum@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 6:52=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Yamada-san,
>
> On Wed, Jan 24, 2024 at 9:10=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
org> wrote:
> > On Wed, Jan 24, 2024 at 12:11=E2=80=AFAM Yoann Congal <yoann.congal@smi=
le.fr> wrote:
> > > Le 23/01/2024 =C3=A0 13:54, Geert Uytterhoeven a =C3=A9crit :
> > > > On Sat, Nov 25, 2023 at 5:36=E2=80=AFPM Masahiro Yamada <masahiroy@=
kernel.org> wrote:
> > > >> This is used only for initializing other variables.
> > > >>
> > > >> Use the empty string "".
> > > >>
> > > >> Please note newval.tri is unused for S_INT/HEX/STRING.
> > > >>
> > > >> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > >
> > > > Thanks for your patch, which is now commit 4e244c10eab345a7
> > > > ("kconfig: remove unneeded symbol_empty variable") in v6.8-rc1.
> > > >
> > > > When running "make <foo>_defconfig" with <foo>_defconfig an SMP
> > > > defconfig without explicit configuration of CONFIG_LOG_CPU_MAX_BUF_=
SHIFT,
> > > > the aforementioned commit causes a change in the generated .config:
> > > >
> > > > -CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12
> > > > +CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D0
> > > >
> > > > It looks like CONFIG_BASE_SMALL=3D0 is treated as a string instead =
of
> > > > the integer number zero?
> > > >
> > > > init/Kconfig=3Dconfig LOG_CPU_MAX_BUF_SHIFT
> > > > init/Kconfig-   int "CPU kernel log buffer size contribution (13 =
=3D> 8
> > > > KB, 17 =3D> 128KB)"
> > > > init/Kconfig-   depends on SMP
> > > > init/Kconfig-   range 0 21
> > > > init/Kconfig:   default 12 if !BASE_SMALL
> > > > init/Kconfig:   default 0 if BASE_SMALL
> > > >
> > > > Note that reverting 4e244c10eab345a7 is not sufficient to fix the i=
ssue.
> > > > Also reverting commit 6262afa10ef7cc8f ("kconfig: default to zero i=
f
> > > > int/hex symbol lacks default property") does fix it.
> > >
> > > (Since I'd really like 6262afa10ef7cc8f ("kconfig: default to zero if=
 int/hex symbol lacks default property") to stay, allow me to try to help)
> > >
> > > The problem is quite easy to reproduce:
> > >   $ make x86_64_defconfig
> > >   $ grep 'LOG_CPU_MAX_BUF_SHIFT\|BASE_SMALL\|BASE_FULL' .config
> > >   CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D0
> > >   CONFIG_BASE_FULL=3Dy
> > >   CONFIG_BASE_SMALL=3D0
> > > Here, CONFIG_LOG_CPU_MAX_BUF_SHIFT should be 12 not 0.
> >
> >
> >
> > I could not produce it in this way.
> > I ran the same commands as yours.
> >
> > CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12 for me.
> >
> >
> >
> > masahiro@zoe:~/ref/linux(master)$ git describe
> > v6.8-rc1-29-g615d30064886
> > masahiro@zoe:~/ref/linux(master)$ git diff
> > masahiro@zoe:~/ref/linux(master)$ make  x86_64_defconfig
> > #
> > # No change to .config
> > #
> > masahiro@zoe:~/ref/linux(master)$ grep
> > 'LOG_CPU_MAX_BUF_SHIFT\|BASE_SMALL\|BASE_FULL' .config
> > CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12
> > CONFIG_BASE_FULL=3Dy
> > CONFIG_BASE_SMALL=3D0
>
> Interesting...
>
> $ git describe
> v6.8-rc1-29-g615d300648869c77
> $ make  x86_64_defconfig
> [...]
> $ grep 'LOG_CPU_MAX_BUF_SHIFT\|BASE_SMALL\|BASE_FULL' .config
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D0
> CONFIG_BASE_FULL=3Dy
> CONFIG_BASE_SMALL=3D0
>
> Does it depend on the flex/bison version?
> I have Ubuntu LTS flex 2.6.4-8build2 and bison 2:3.8.2+dfsg-1build1.
>


Interesting.

The result depends on the distro.



I got CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D0 in
the Ubuntu 22.04 docker container, but
CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12 in
the Ubuntu 23.10 docker container.






--
Best Regards
Masahiro Yamada

