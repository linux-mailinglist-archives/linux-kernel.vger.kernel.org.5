Return-Path: <linux-kernel+bounces-97789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A42F6876F6D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 07:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4BD1F2176D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 06:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50799364C0;
	Sat,  9 Mar 2024 06:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ib6wVZ1L"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230511D558;
	Sat,  9 Mar 2024 06:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709967281; cv=none; b=XVKTSk0Bej2lGxn02P29O71F5ornm4jL5s4Ptmt3Coh1GMROLOJObVf73Bxje3gdiPCACacxr0f8Xir6m/VpPUbvWMVX3ILpUuXSLjx/7aqdChf0ffqEQf1WVZrnRQ4YDh0/wT6cAjJtGaaLuB/nqsHkETL068JUuqRES17HCkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709967281; c=relaxed/simple;
	bh=zE5llABa6OUSWAXGxaevMEl71+ZRFhwSH+z3I9FbD3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZBlL8o/rM6TjbKrUC/0XnRhP+C1bdwu8JOCA9l4RPrJHSUL7NPoj63KsJtMQDuU+pH2adSbr1ofHafhBTYT8NgEDut14VaCoPFRpZAKPH9kyB88Dv+gSC8iWug4pdVYsM2KZaRiFBuYYsmut34K4X+Pif8uaxmZU0147GvXXmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ib6wVZ1L; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso2435299a12.0;
        Fri, 08 Mar 2024 22:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709967279; x=1710572079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GFVaDFLqdGwfwQuEkW9PKhIJH9fl4L06eRAN/wjSBaI=;
        b=ib6wVZ1LoX9oFeNkrJ/xC6ShT0AWxMtZdt6rnaggei2uK/TpPq2bdPprpsFoUy19S8
         s/cEyCt/EzVk1sdajSmzFHrNhHL5mSEa6kgkAQVAfWjw9qu2y0a34HVt4VCu02ZLACEA
         BzGFNUbwyuXvv1jcI6wmLwEfRMRxT2E3n1OLOQtQK1ab39BgKE5LQjUXxx7LNuGpIsOm
         CanwukTScQivU5IEvOrq1IyqiDDYuDuqBK4ptRbIaFPK7AQ/8dgfJKHv/8hDjIJa3dX9
         mNaIK/m2wfl38SpmhsBhIIK7l7ioibgvRilIXOtNOYPkHxXr3IKjQhD0s51Q1FC23Ooy
         0ogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709967279; x=1710572079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFVaDFLqdGwfwQuEkW9PKhIJH9fl4L06eRAN/wjSBaI=;
        b=LM8vxPtJQPezKpluf/ZPWhWaHqsxxOL364SYZACvulqvJEaNA5d83La0BkjqYHvDby
         3pUXMi5k9JI4oPDbOTCXxmsTTPPyov2fmi8VsX7qxkDcTf00i6xr9TQfi8E7dk+MZQDV
         UDYXihQjzZoGTvtTfHRJABiFa0TNFPEOFjJLlGCovG1qSJEwi6Mkh1QWoQ+Qy69NwhVt
         Wvfkxm2r7084cnmieO7TYbFNg/kXVkF0YbsWsEHRICHjPJ87kR1aWnffs+ssYhf3oMyy
         JLVA98TzO0q+hytE2TPDff0OXSdf/hbcJ9U0mmXHKbkH9V68F/yUT6C91pjUWsauRJI2
         gjLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVirPaE5/fxitxMxH4UwKoY4BaHFA/grknKRkwXShWeCgrIqdPo65D+DtC8x4AxV3XrfrFakedU+8oEevR7R/Na7zHlAUBJCKc8K2l7A/hOuCgbJH6Le4oqqgWMU8KQrS4oWD36h/kj
X-Gm-Message-State: AOJu0Yw6+T42WddnaPZct09y4wZLhdD4sMiI5Cy9e7Z6EkaaapeSjMo3
	L6sFJ0Xs0M0MXsbGh+8MF3OxOcxuYBcyMvIuS7qC7gPvfaVbQg0zCWyGKnnra9s=
X-Google-Smtp-Source: AGHT+IF2fDVjG29onY/4FvdxbJ5iKCefwCDjEM0f5AM4a86mvOxkPcspIPPqnLE5KdtvL+jXEAGRGQ==
X-Received: by 2002:a05:6a21:199:b0:1a0:e187:87c4 with SMTP id le25-20020a056a21019900b001a0e18787c4mr1247749pzb.38.1709967279176;
        Fri, 08 Mar 2024 22:54:39 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id f5-20020a17090a4a8500b0029b2e5bc1b9sm4006549pjh.23.2024.03.08.22.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 22:54:38 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 22C9D184F7F74; Sat,  9 Mar 2024 13:54:35 +0700 (WIB)
Date: Sat, 9 Mar 2024 13:54:35 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	Jonathan Corbet <corbet@lwn.net>
Cc: regressions@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Subject: Re: [PATCH v1] docs: verify/bisect: fixes, finetuning, and support
 for Arch
Message-ID: <ZewHqzDi5Juou1rU@archie.me>
References: <6592c9ef4244faa484b4113f088dbc1beca61015.1709716794.git.linux@leemhuis.info>
 <ZehvJv3fDZIPs9Kc@archie.me>
 <feba810d-1391-475e-9b56-fbb6c52912a0@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W/axohnCOtDbrhTh"
Content-Disposition: inline
In-Reply-To: <feba810d-1391-475e-9b56-fbb6c52912a0@leemhuis.info>


--W/axohnCOtDbrhTh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 09:56:47AM +0100, Linux regression tracking (Thorst=
en Leemhuis) wrote:
> On 06.03.24 14:27, Bagas Sanjaya wrote:
> > On Wed, Mar 06, 2024 at 10:21:12AM +0100, Thorsten Leemhuis wrote:
> >> diff --git a/Documentation/admin-guide/verify-bugs-and-bisect-regressi=
ons.rst b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
> >> index 54bde8bac95c67..58211840ac6ffb 100644
> >> --- a/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
> >> +++ b/Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
> >> @@ -192,8 +192,8 @@ will be considered the 'good' release and used to =
prepare the .config file.
> >> =20
> >>         sudo rm -rf /lib/modules/6.0-rc1-local-gcafec0cacaca0
> >>         sudo kernel-install -v remove 6.0-rc1-local-gcafec0cacaca0
> >> -       # * Note, if kernel-install is missing, you will have to
> >> -       #   manually remove the kernel image and related files.
> >> +       # * Note, on some distributions kernel-install is missing
> >> +       #   or does only part of the job.
> >=20
> > Consult documentation of your distribution for how to manually install/=
remove
> > the kernel.
>=20
> That would sent the wrong message in the TLDR, as the step-by-step guide
> and the reference section would be the first place to look for details,
> which is kinda implicit for a TLDR.
>=20
> That being said: that made me look closer at the install section of the
> guide and the reference section. I think they should mention "consult
> documentation of your distribution" more clearly. I just looked into
> this, but that requires a few bigger changes, so I'll take care of that
> in a later patch I hope to send in the next few days.
>=20
> >>  Install build requirements
> >>  --------------------------
> >> @@ -1076,72 +1078,103 @@ about to build.
> >>  Here are a few examples what you typically need on some mainstream
> >>  distributions:
> >> =20
> >> +* Arch Linux and derivatives::
> >> +
> >> +    sudo pacman --needed -S bc binutils bison flex gcc git kmod libel=
f openssl \
> >> +      pahole perl zlib ncurses qt6-base
> >> +
> >>  * Debian, Ubuntu, and derivatives::
> >> =20
> >> -    sudo apt install bc binutils bison dwarves flex gcc git make open=
ssl \
> >> -      pahole perl-base libssl-dev libelf-dev
> >> +    sudo apt install bc binutils bison dwarves flex gcc git kmod libe=
lf-dev \
> >> +      libssl-dev make openssl pahole perl-base pkg-config zlib1g-dev \
> >> +      libncurses-dev qt6-base-dev g++
> >> =20
> >>  * Fedora and derivatives::
> >> =20
> >> -    sudo dnf install binutils /usr/include/{libelf.h,openssl/pkcs7.h}=
 \
> >> -      /usr/bin/{bc,bison,flex,gcc,git,openssl,make,perl,pahole}
> >> +    sudo dnf install binutils \
> >> +      /usr/bin/{bc,bison,flex,gcc,git,openssl,make,perl,pahole,rpmbui=
ld} \
> >> +      /usr/include/{libelf.h,openssl/pkcs7.h,zlib.h,ncurses.h,qt6/QtG=
ui/QAction}
> >=20
> > IMO qt packages are for people who wish to do xconfig instead of menuco=
nfig
> > or nconfig.
>=20
> Well, yes, that's why the patch also added a few lines to point this out
> and mention that installing the qt dev headers is optional. Guess you
> just missed that.
>=20

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--W/axohnCOtDbrhTh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZewHpwAKCRD2uYlJVVFO
oyN9AP4qiCxkqPRLMtJeAgSU6Kg8PssrdGDymIdNwE5I7KC74QD9GHIDsxA2aDGg
BGfaFSW2UxE+kZzALs5qmS+05hqoVwE=
=ZICm
-----END PGP SIGNATURE-----

--W/axohnCOtDbrhTh--

