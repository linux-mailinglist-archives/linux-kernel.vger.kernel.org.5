Return-Path: <linux-kernel+bounces-11353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6222C81E509
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0252CB21C40
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 05:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CDD4B14F;
	Tue, 26 Dec 2023 05:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekSnb2Ye"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF20A4B12B;
	Tue, 26 Dec 2023 05:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A725C433CB;
	Tue, 26 Dec 2023 05:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703568903;
	bh=86/8sBCEVD+1U/Wf6jtj5/faPUbdwwgODXNMyylFT5k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ekSnb2YeCON79kPWFSfTq8tdGcHEWuvSMZ4APiJ9YhsZw7UTg3EYWl7D1Xpq2ZKtv
	 TxaTrQuMobr/WpQu7B5iVCRgH7mQv5fhQB0zoFnekJ2JSkpXK3Fco2nEdWh5x/1pnN
	 IDz7d/m3Vt12qWkRg4/mHDLik0fHfpw4wnn+kEGQdSyItiJhtyIroIpxIbhG7HVaR8
	 Ypxgzko4agukhZm/F6GwV5Ao4UupijxOTe/gGmpV/yKNe+co7eZ+0D78g8cjMN8M/H
	 l4gFWsPOrAR1JHgmr7ryhY/hJn3QTeRWNRArG78jy3b2MB/ue0mEiiBXp3pUa8z+Lp
	 OwpkQ6vQewfmg==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6dbfdb41a63so25579a34.0;
        Mon, 25 Dec 2023 21:35:02 -0800 (PST)
X-Gm-Message-State: AOJu0YwT/INCyHWWTPe/dk3nY2vfwRhMBwsLbPRpaaSxWnGGd4Tr3AbR
	FDd0h6A8JzuVQCZ0fWV3ibqGcMAONWZmRLAVkO0=
X-Google-Smtp-Source: AGHT+IGuj878252OyJfg32s0yMi5af67UAnDd/I1z5KfxSGxbWZwaLC+7jgEDZYXg3LAgu9er8z4j/6qaeX1y6F2/k4=
X-Received: by 2002:a05:6870:e303:b0:204:4401:ed2a with SMTP id
 z3-20020a056870e30300b002044401ed2amr7787912oad.0.1703568902369; Mon, 25 Dec
 2023 21:35:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219181957.1449958-1-masahiroy@kernel.org> <ZYWdaCiNFsseZWWS@buildd.core.avm.de>
In-Reply-To: <ZYWdaCiNFsseZWWS@buildd.core.avm.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 26 Dec 2023 14:34:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNAToZfKMOANKYctN0E00uXXvgv8p7TcrLcHJQRuG0eNW=A@mail.gmail.com>
Message-ID: <CAK7LNAToZfKMOANKYctN0E00uXXvgv8p7TcrLcHJQRuG0eNW=A@mail.gmail.com>
Subject: Re: [PATCH 1/3] kbuild: deb-pkg: do not query DEB_HOST_MULTIARCH
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org, 
	Ben Hutchings <ben@decadent.org.uk>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org
Cc: Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 11:30=E2=80=AFPM Nicolas Schier <n.schier@avm.de> w=
rote:
>
> On Wed, Dec 20, 2023 at 03:19:55AM +0900, Masahiro Yamada wrote:
> > Since commit 491b146d4c13 ("kbuild: builddeb: Eliminate debian/arch
> > use"), the direct execution of debian/rules fails with:
> >
> >   dpkg-architecture: error: unknown option 'DEB_HOST_MULTIARCH'
> >
> > I am not sure how important to support such a use case, but at least
> > the current code:
> >
> >   dpkg-architecture -a$DEB_HOST_ARCH -qDEB_HOST_MULTIARCH
> >
> > ... looks weird because:
> >
> >  - For this code to work correctly, DEB_HOST_ARCH must be defined.
> >    In this case, DEB_HOST_MULTIARCH is likely defined, so there is no
> >    need to query DEB_HOST_MULTIARCH in the first place. This is likely
> >    the case where the package build was initiated by dpkg-buildpackage.
> >
> >  - If DEB_HOST_MULTIARCH is undefined, DEB_HOST_ARCH is likely undefine=
d.
> >    So, you cannot query DEB_HOST_MULTIARCH in this way. This is mostly
> >    the case where debian/rules is directly executed.
> >
> > If we want to run debian/rules directly, we can revert 491b146d4c13 or
> > add code to remember DEB_HOST_MULTIARCH, but I chose to remove the
> > useless code for now.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
>
> thanks.  Fixing the non-functional things is obviously a good thing.
>
> Reviewed-by: Nicolas Schier <n.schier@avm.de>
>
>
> Iff we'd like to be able to call debian/rules directly, do we really
> have to remember DEB_HOST_MULTIARCH, or just DEB_HOST_ARCH?


Theoretically, if we know DEB_HOST_ARCH,
other DEB_HOST_* can be derived.


scripts/package/deb-build-option needs to know more DEB_* variables.

  DEB_HOST_ARCH
  DEB_BUILD_ARCH
  DEB_HOST_GNU_TYPE









>
> In the latter case, might this be a sufficient way to allow calling
> debian/rules again?


Not perfectly.
scripts/package/deb-build-option does not work as intended.


>
> diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
> index 3dafa9496c63..e3e0001e7556 100755
> --- a/scripts/package/debian/rules
> +++ b/scripts/package/debian/rules
> @@ -3,7 +3,9 @@
>
>  include debian/rules.vars
>
> -srctree ?=3D .
> +DEB_HOST_ARCH ?=3D $(shell cat debian/arch)
> +
> +srctree ?=3D $(or $(wildcard source), .)
>
>  ifneq (,$(filter-out parallel=3D1,$(filter parallel=3D%,$(DEB_BUILD_OPTI=
ONS))))
>      NUMJOBS =3D $(patsubst parallel=3D%,%,$(filter parallel=3D%,$(DEB_BU=
ILD_OPTIONS)))
>
>
> ... but the more I think about it, I am not convinced that we want to
> use the debian/arch file.  Actually I think it would be nice if we
> strive for an architecture independent source package instead of
> engraving the architecture even more.


The source package _is_ arch-independent,
can be built for a single architecture because
the source package for upstream contains the .config,
which is configured for a particular architecture.







>
> Nevertheless, your patch looks good to me.
>
> Kind regards,
> Nicolas
>
>
>
> >
> >  scripts/package/builddeb | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> > index 2fe51e6919da..2eb4910f0ef3 100755
> > --- a/scripts/package/builddeb
> > +++ b/scripts/package/builddeb
> > @@ -171,9 +171,8 @@ install_libc_headers () {
> >
> >       # move asm headers to /usr/include/<libc-machine>/asm to match th=
e structure
> >       # used by Debian-based distros (to support multi-arch)
> > -     host_arch=3D$(dpkg-architecture -a$DEB_HOST_ARCH -qDEB_HOST_MULTI=
ARCH)
> > -     mkdir $pdir/usr/include/$host_arch
> > -     mv $pdir/usr/include/asm $pdir/usr/include/$host_arch/
> > +     mkdir "$pdir/usr/include/${DEB_HOST_MULTIARCH}"
> > +     mv "$pdir/usr/include/asm" "$pdir/usr/include/${DEB_HOST_MULTIARC=
H}"
> >  }
> >
> >  rm -f debian/files
> > --
> > 2.40.1
> >



--=20
Best Regards
Masahiro Yamada

