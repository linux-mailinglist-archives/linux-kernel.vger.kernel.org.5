Return-Path: <linux-kernel+bounces-41205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF96983ED63
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4031F22E4B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 13:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A662D25639;
	Sat, 27 Jan 2024 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgYYQTU0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66551E51D;
	Sat, 27 Jan 2024 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706362911; cv=none; b=Hx60CBMJ03bh80jjjPgs3Azl7w7MPHigJvWnSJ1SZ42tdYY2hYRokRg2jm9oHeQfH4XFwv5zNykfeW7RjCzeLNNiYW3wZiUnldeziOzrXJZK3eDjzwyH1AqPzCEwreJKicaiuDyOehcauKgI49PW2qSpwLEAZcyt8oxcA9Hw704=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706362911; c=relaxed/simple;
	bh=hosPsHG0ZyfR8sKG0hSNgK2DCihwOOAQrKZoFmzPQUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eg8uU/orT4o8EYhsN+dYqTQe29wyv9n/Pud7flQGveQuTc7morVG08DODBqr17/79W40XFEySBlrl/s4T+Ge5icbSp0dG8VRWTelrVsht7wryRKqy8nVFSHyvx5nGDNTq51Cn85iiI5aTOJiVJDOwX9OjpUTD0UGqt45PUXZ7jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgYYQTU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621A1C433F1;
	Sat, 27 Jan 2024 13:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706362910;
	bh=hosPsHG0ZyfR8sKG0hSNgK2DCihwOOAQrKZoFmzPQUc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DgYYQTU0Q3ngEJGlfrBXOXCFHFtvdeK7RLdORupoijhaDQERHTWp1j+KYsPCpHQcO
	 pj6cSuHdtW55VVZD57WqW73TdqcLKeS6kih2WuRErRhFIUMoj9muauQgzT1INqDTgy
	 KYwJQu9w8EHS9RtgZwuxT3bbrhOwyHV/Jbw3LMOP28BLxDOpZxC/0aLzyOa04/HydS
	 Ws6gBGevTJjGeO1OYVcrtvY8xNCrMJ7gtTbFyxpvK5FWSUq/rUYsaEx07/8SDRCuyL
	 rXwlV9jW9TbybpvXttdGQ6Lj4ABARD2tSWGMiIC/zFv3vA5DgMjZk4zqGC5BugLIlR
	 t7kHPp7jUgfmg==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-595b3644acbso1225358eaf.1;
        Sat, 27 Jan 2024 05:41:50 -0800 (PST)
X-Gm-Message-State: AOJu0YzmUk8cLBx2eCekE/2EKTwpzm+e6gznvpLFW8DZ1gc171vNJKAU
	jTZ/Pq7cFkT10h2baMSAQi/1MXEu1p6PcAeG67V+dC8Bx8m8s3g4GQmKj0NsVFdgkZjkmGqUuKu
	zEHZlQZ1A5NntryDmYlcevv7X26w=
X-Google-Smtp-Source: AGHT+IG3fUb8Ad4+sr7qrvoyt+C0ZtD2RWS3ld+lIM4h3epDbz8xcPsi5sdfx66Hm5aKT7X+rx/K9BDQfWP1ePI0OME=
X-Received: by 2002:a05:6870:709e:b0:215:30c3:a2c1 with SMTP id
 v30-20020a056870709e00b0021530c3a2c1mr1046686oae.48.1706362909773; Sat, 27
 Jan 2024 05:41:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d9ac2960-6644-4a87-b5e4-4bfb6e0364a8@aibsd.com>
 <CAK7LNATDD2gC53T5n7vCUH6O6mdAm801fTWyKi9fji+5Kb+0ng@mail.gmail.com> <20240122230255.GD141255@dev-fedora.aadp>
In-Reply-To: <20240122230255.GD141255@dev-fedora.aadp>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 27 Jan 2024 22:41:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNARa4YPu_+KW1_E4RKO95JqUxS+DM8X6fmjr4SmV-Sgk4Q@mail.gmail.com>
Message-ID: <CAK7LNARa4YPu_+KW1_E4RKO95JqUxS+DM8X6fmjr4SmV-Sgk4Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] modpost: inform compilers that fatal() never returns
To: Nathan Chancellor <nathan@kernel.org>
Cc: Aiden Leong <aiden.leong@aibsd.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu, 
	clang-built-linux <llvm@lists.linux.dev>, 
	=?UTF-8?B?Ru+/ve+/ve+/vW5nLXJ177+977+977+9IFPvv73vv73vv71uZw==?= <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 8:02=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Mon, Jan 22, 2024 at 10:29:32PM +0900, Masahiro Yamada wrote:
> > +CC: clang-built-linux list, Fangrui
> >
> > On Mon, Jan 22, 2024 at 1:04=E2=80=AFPM Aiden Leong <aiden.leong@aibsd.=
com> wrote:
> > >
> > >
> > >  > The function fatal() never returns because modpost_log() calls exi=
t(1)
> > >
> > >  > when LOG_FATAL is passed.
> > >  >
> > >  > Inform compilers of this fact so that unreachable code flow can be
> > >  > identified at compile time.
> > >  >
> > >  > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > >  > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > >  > ---
> > >  >
> > >  > Changes in v2:
> > >  >   - Use noreturn attribute together with alias
> > >  >
> > >  >  scripts/mod/modpost.c | 3 +++
> > >  >  scripts/mod/modpost.h | 5 ++++-
> > >  >  2 files changed, 7 insertions(+), 1 deletion(-)
> > >  >
> > >  > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > >  > index ca0a90158f85..c13bc9095df3 100644
> > >  > --- a/scripts/mod/modpost.c
> > >  > +++ b/scripts/mod/modpost.c
> > >  > @@ -90,6 +90,9 @@ void modpost_log(enum loglevel loglevel, const c=
har
> > > *fmt, ...)
> > >  >          error_occurred =3D true;
> > >  >  }
> > >  >
> > >  > +void __attribute__((alias("modpost_log")))
> > >
> > > Hi Masahiro,
> > > I cross-compile kernel on Apple Silicon MacBook Pro
> > > and every thing works well until this patch.
> > >
> > > My build command:
> > > make ARCH=3Darm CROSS_COMPILE=3Darm-none-eabi- \
> > > HOSTCFLAGS=3D"-I/opt/homebrew/opt/openssl/include" \
> > > HOSTLDFLAGS=3D"-L/opt/homebrew/opt/openssl/lib"
> > >
> > > Error message:
> > > scripts/mod/modpost.c:93:21: error: aliases are not supported on darw=
in
> >
> >
> > It is unfortunate.  Indeed, I see this message in:
> >
> > clang/include/clang/Basic/DiagnosticSemaKinds.td
> >
> >
> > Is this limitation due to macOS executable (PEF),
> > or is it Clang-specific?
>
> Based on my admittedly brief research, this seems related to the Mach-O
> format. That message was added by [1] in response to [2] but the message
> mentioned weak aliases being supported. A further clarification was made
> in [3] to state that all aliases are unsupported as a result of some
> internal Apple bug it seems but I do see a couple of bug reports stating
> that may not be true [4][5] (although that does not seem relevant for
> this report).
>
> [1]: https://github.com/llvm/llvm-project/commit/0017c5fa92ad3b10e15fd34f=
3865e8e5b850a5ed
> [2]: https://llvm.org/bz8720
> [3]: https://github.com/llvm/llvm-project/commit/4e30b96834cea5682a8e9e02=
4dda06319825000a
> [4]: https://github.com/llvm/llvm-project/issues/11488
> [5]: https://github.com/llvm/llvm-project/issues/71001



Thank you.
As far as I understood, macOS seems to support weak aliases.

With [5] fixed, perhaps we could do the following:

-void __attribute__((alias("modpost_log")))
+void __attribute__((weak, alias("modpost_log")))


But, we do not need to wait for it.
We can do similar without aliases at all.

fix submitted:
https://lore.kernel.org/all/20240127132811.726504-1-masahiroy@kernel.org/T/=
#u




--=20
Best Regards
Masahiro Yamada

