Return-Path: <linux-kernel+bounces-21409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28E8828EC4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4092884FD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82DA3DB88;
	Tue,  9 Jan 2024 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rothwell.id.au header.i=@rothwell.id.au header.b="K4IyErHq"
Received: from gimli.rothwell.id.au (gimli.rothwell.id.au [103.230.158.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53EF3DB80
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 21:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rothwell.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rothwell.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothwell.id.au;
	s=201702; t=1704834719;
	bh=XqaDkPEKvhKawZWNHyV8Yb0QQScPqSW3dBMmbV4mLhE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K4IyErHqIut7FlkfYbS6MlLowXYj2xlFa3teYU5h+Yy5rEFji28j1PEdrLe514sqP
	 ziM16/XdCnpj2C8uerZ51tHbg7BTe28eP5TirPMoZpLhtn6wSd0Z+Or+wBOKuf021E
	 mhGztHpJFo1Iuw5sM241LFA+X0Cv/yKNzz6QgWT4CdbK5+faXPrsrjmdVa9UyywM4q
	 /GfZ7aEcj3Jl3zeB00CtwJMDnRGM9stgH5+aMUa4AL73iYoNC8MtfW266frXUvm2md
	 3iZROUJtDxBuxK8E3MHlbff9HZPKG3rhgs7Hald8ooshxG/fpdnzt1HdAw+IzqFKsJ
	 bS55oHOSQTtpA==
Received: from authenticated.rothwell.id.au (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.rothwell.id.au (Postfix) with ESMTPSA id 4T8kC11LbjzyR8;
	Wed, 10 Jan 2024 08:11:56 +1100 (AEDT)
Date: Wed, 10 Jan 2024 08:11:55 +1100
From: Stephen Rothwell <sfr@rothwell.id.au>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Stephen Rothwell
 <sfr@canb.auug.org.au>, <lucas.dimarchi@intel.com>,
 <linux-kernel@vger.kernel.org>, <intel-xe@lists.freedesktop.org>
Subject: Re: [BUG] allmodconfig build error in next-20240108
Message-ID: <20240110081155.48bb0cbd@oak>
In-Reply-To: <atbx7mspjbymkzgstk4l64qz3uky3wpmx4isrfg3ixgtvebdd2@cktpe4ejfk7k>
References: <45ad1d0f-a10f-483e-848a-76a30252edbe@paulmck-laptop>
	<20240109095757.1313b2d9@canb.auug.org.au>
	<341a4955-0cdd-48d0-bfbd-cc6f6f09df37@paulmck-laptop>
	<atbx7mspjbymkzgstk4l64qz3uky3wpmx4isrfg3ixgtvebdd2@cktpe4ejfk7k>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XM1nT8ntme8srM+CjlaBbyP";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/XM1nT8ntme8srM+CjlaBbyP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On Tue, 9 Jan 2024 10:58:40 -0600 Lucas De Marchi <lucas.demarchi@intel.com=
> wrote:
>
> On Mon, Jan 08, 2024 at 03:15:23PM -0800, Paul E. McKenney wrote:
> >On Tue, Jan 09, 2024 at 09:57:57AM +1100, Stephen Rothwell wrote: =20
> >> Hi Paul,
> >>
> >> On Mon, 8 Jan 2024 13:33:36 -0800 "Paul E. McKenney" <paulmck@kernel.o=
rg> wrote: =20
> >> >
> >> > Recent -next trees get the following build error for allmodconfig bu=
ilds:
> >> >
> >> > --------------------------------------------------------------------=
----
> >> >
> >> > drivers/gpu/drm/xe/xe_gt_pagefault.c: In function =E2=80=98xe_guc_pa=
gefault_handler=E2=80=99:
> >> > ./include/linux/fortify-string.h:57:33: error: writing 16 bytes into=
 a region of =C2=A0size 0 [-Werror=3Dstringop-overflow=3D]
> >> > =C2=A0=C2=A0=C2=A057 | #define __underlying_memcpy =C2=A0 =C2=A0 __b=
uiltin_memcpy
> >> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^
> >> > ./include/linux/fortify-string.h:644:9: note: in expansion of macro =
=E2=80=98__underlying_memcpy=E2=80=99
> >> > =C2=A0=C2=A0644 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 __underlying_##op(p, q=
, __fortify_size); \
> >> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~=
~~~~~~~~~~~
> >> > ./include/linux/fortify-string.h:689:26: note: in expansion of macro=
 =E2=80=98__fortify_memcpy_chk=E2=80=99
> >> > =C2=A0=C2=A0689 | #define memcpy(p, q, s)=C2=A0 __fortify_memcpy_chk=
(p, q, s, \
> >> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~=
~~~~~
> >> > drivers/gpu/drm/xe/xe_gt_pagefault.c:340:17: note: in expansion of m=
acro =E2=80=98memcpy=E2=80=99
> >> > =C2=A0=C2=A0340 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 memcpy(pf_queue->data + pf_queue->tail, msg, len * sizeof(u32));
> >> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~
> >> > In file included from drivers/gpu/drm/xe/xe_device_types.h:17,
> >> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from drivers/gpu/drm/xe/xe_vm_types.h:1=
6,
> >> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from drivers/gpu/drm/xe/xe_bo.h:13,
> >> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from drivers/gpu/drm/xe/xe_gt_pagefault=
c:16:
> >> > drivers/gpu/drm/xe/xe_gt_types.h:102:25: note: at offset [1144, 2653=
24] into destination object =E2=80=98tile=E2=80=99 of size 8
> >> > =C2=A0=C2=A0102 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct xe_tile *tile;
> >> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| =20
> >>
> >> Which architecture?  What compiler and version?  Anything special in y=
our build
> >> setup?  I do x86_64 allmodconfig builds all day with gcc v13.2 and I d=
on't see
> >> this failure. =20
> >
> >Good point!
> >
> >I am using gcc version 11.3.1 20230605 (Red Hat 11.4.1-2) on x86_64.
> >I see the same behavior on gcc version 8.5.0, which for all I know might
> >be too old. =20
>=20
> I could reproduce it with allmodconfig and gcc 11.4.1 from rockylinux,
> but not with gcc 9.3 or 12.3. Also it's not reproduced with gcc 11.4.1
> when using defconfig + CONFIG_DRM_XE  (even if  -Wstringop-overflow is
> still added).
>=20
> I don't see a bug in the code, even if it inverts the head/tail
> convention.
>=20
> Searching around showed this which may be relevant: https://gcc.gnu.org/b=
ugzilla/show_bug.cgi?id=3D101854
> At least I can reproduce the same issue as in the snippet provided
> (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D101854#c7) with the buggy
> compiler.
>=20
> So, maybe the best thing to do for now is to disable -Wstringop-overflow
> for gcc < 12?
>=20
>=20
> ------8<-----
> diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
> index 6952da8979ea..0433a3c6cbfd 100644
> --- a/drivers/gpu/drm/xe/Makefile
> +++ b/drivers/gpu/drm/xe/Makefile
> @@ -17,7 +17,7 @@ subdir-ccflags-y +=3D $(call cc-option, -Wunused-const-=
variable)
>   subdir-ccflags-y +=3D $(call cc-option, -Wpacked-not-aligned)
>   subdir-ccflags-y +=3D $(call cc-option, -Wformat-overflow)
>   subdir-ccflags-y +=3D $(call cc-option, -Wformat-truncation)
> -subdir-ccflags-y +=3D $(call cc-option, -Wstringop-overflow)
> +subdir-ccflags-$(call gcc-min-version, 120000) +=3D $(call cc-option, -W=
stringop-overflow)
>   subdir-ccflags-y +=3D $(call cc-option, -Wstringop-truncation)
>   # The following turn off the warnings enabled by -Wextra
>   ifeq ($(findstring 2, $(KBUILD_EXTRA_WARN)),)
> ------8<-----
>=20
> and if we are tweaking the warnings, then do similarly in scripts/Makefil=
e.extrawarn
> so it doesn't show up again with W=3D1 builds. Thoughts?

The top level Makefile (in linux-next) has:

#Currently, disable -Wstringop-overflow for GCC 11, globally.
KBUILD_CFLAGS-$(CONFIG_CC_NO_STRINGOP_OVERFLOW) +=3D $(call cc-option, -Wno=
-stringop-overflow)
KBUILD_CFLAGS-$(CONFIG_CC_STRINGOP_OVERFLOW) +=3D $(call cc-option, -Wstrin=
gop-overflow)

and init/Kconfig has:

# Currently, disable -Wstringop-overflow for GCC 11, globally.
config GCC11_NO_STRINGOP_OVERFLOW
        def_bool y

config CC_NO_STRINGOP_OVERFLOW
        bool
        default y if CC_IS_GCC && GCC_VERSION >=3D 110000 && GCC_VERSION < =
120000 && GCC11_NO_STRINGOP_OVERFLOW

config CC_STRINGOP_OVERFLOW
        bool
        default y if CC_IS_GCC && !CC_NO_STRINGOP_OVERFLOW

So, what does "grep -E '(STRINGOP_OVERFLOW|GCC_VERSION)' .config" show for =
your
breaking build(s)?

--=20
Cheers,
Stephen Rothwell

--Sig_/XM1nT8ntme8srM+CjlaBbyP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWdtpsACgkQAVBC80lX
0Gw54gf/Qic5bVyuKo6FZCoFJ4c9LKTIY1m99afR2jIqJufTn1+IbLS51gBzpRyQ
3mPRMCRsD9/jwxgoMcECjFfCuPiLjVM9IN3umf1PnBRFuk3opiHVDL/s2+NJbyit
tpyP2oXEafyt0Gk3Wuz5kd9tg5KbJ4Bz8sLWY9wLAcaYxsudb6fXKtaAteyYpyTX
zgJvS829MsnIze2OyzcTlZ6tXkfrp6Zvm7MvQGhsyWilLK5/zHgGsREvKTEiAqy/
5vJ9sN/lhs4WJkIF79nWs4g0Vc1Pi1hV0xC+lRlzar6eHGUuJIRaN/ypJmIGW55k
7DGCItfUNCc3xX569X2oIBmT8heogw==
=2czi
-----END PGP SIGNATURE-----

--Sig_/XM1nT8ntme8srM+CjlaBbyP--

