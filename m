Return-Path: <linux-kernel+bounces-21487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F6C82901A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185E21C2492D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58E43E46E;
	Tue,  9 Jan 2024 22:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fm/RBjLG"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F033DB92
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 22:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704841105;
	bh=h5TC0WdyBVPE0cSR7BOyIGDgXy+nxz76g213rnQe2wc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fm/RBjLG4Pd5AurzmCQMZMCHDRKOtAQkXn/yTg/AbcUQ1KBoZD2DKdmtqdOxRpeuO
	 1igt4WDjMu/oZQo0QXY9IyEQfznfWKkP0Yv4ad7k1Cx/bv6k9s2Of1AL89j+Tezsdo
	 HhKf9TEKmVQ+WM2rXf+Os59BkwD3uDFShlcOor8Fu+oSzfaaZK5PTQy76wH7Jsx7Qa
	 wLX9uZXedqsUaVRDYccDphWrju2HfOEu+sTOnTQZt4RfejTFI+SB06mtCxROhbGsQM
	 R8bh+ygVaUT5OfBLpobMvNLCHuROBqDsxN08AuYRTTzaruHgpqBMTBkIbT3eOQqCZi
	 UxVrxLZlOQ1Mg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T8mYr6jWVz4wbR;
	Wed, 10 Jan 2024 09:58:24 +1100 (AEDT)
Date: Wed, 10 Jan 2024 09:58:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org
Subject: Re: [BUG] allmodconfig build error in next-20240108
Message-ID: <20240110095822.3ba3d979@canb.auug.org.au>
In-Reply-To: <d61dfe52-9567-4f62-98f5-5c1e00cb4708@paulmck-laptop>
References: <45ad1d0f-a10f-483e-848a-76a30252edbe@paulmck-laptop>
	<20240109095757.1313b2d9@canb.auug.org.au>
	<341a4955-0cdd-48d0-bfbd-cc6f6f09df37@paulmck-laptop>
	<atbx7mspjbymkzgstk4l64qz3uky3wpmx4isrfg3ixgtvebdd2@cktpe4ejfk7k>
	<20240110081155.48bb0cbd@oak>
	<d61dfe52-9567-4f62-98f5-5c1e00cb4708@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_3HAcU_.gtxEp1r51mpFW=c";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/_3HAcU_.gtxEp1r51mpFW=c
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 9 Jan 2024 14:45:56 -0800 "Paul E. McKenney" <paulmck@kernel.org> w=
rote:
>
> On Wed, Jan 10, 2024 at 08:11:55AM +1100, Stephen Rothwell wrote:
> >=20
> > On Tue, 9 Jan 2024 10:58:40 -0600 Lucas De Marchi <lucas.demarchi@intel=
com> wrote: =20
> > >
> > > On Mon, Jan 08, 2024 at 03:15:23PM -0800, Paul E. McKenney wrote: =20
> > > I could reproduce it with allmodconfig and gcc 11.4.1 from rockylinux,
> > > but not with gcc 9.3 or 12.3. Also it's not reproduced with gcc 11.4.1
> > > when using defconfig + CONFIG_DRM_XE  (even if  -Wstringop-overflow is
> > > still added).
> > >=20
> > > I don't see a bug in the code, even if it inverts the head/tail
> > > convention.
> > >=20
> > > Searching around showed this which may be relevant: https://gcc.gnu.o=
rg/bugzilla/show_bug.cgi?id=3D101854
> > > At least I can reproduce the same issue as in the snippet provided
> > > (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D101854#c7) with the b=
uggy
> > > compiler.
> > >=20
> > > So, maybe the best thing to do for now is to disable -Wstringop-overf=
low
> > > for gcc < 12?
> > >=20
> > >=20
> > > ------8<-----
> > > diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
> > > index 6952da8979ea..0433a3c6cbfd 100644
> > > --- a/drivers/gpu/drm/xe/Makefile
> > > +++ b/drivers/gpu/drm/xe/Makefile
> > > @@ -17,7 +17,7 @@ subdir-ccflags-y +=3D $(call cc-option, -Wunused-co=
nst-variable)
> > >   subdir-ccflags-y +=3D $(call cc-option, -Wpacked-not-aligned)
> > >   subdir-ccflags-y +=3D $(call cc-option, -Wformat-overflow)
> > >   subdir-ccflags-y +=3D $(call cc-option, -Wformat-truncation)
> > > -subdir-ccflags-y +=3D $(call cc-option, -Wstringop-overflow)
> > > +subdir-ccflags-$(call gcc-min-version, 120000) +=3D $(call cc-option=
, -Wstringop-overflow)
> > >   subdir-ccflags-y +=3D $(call cc-option, -Wstringop-truncation)
> > >   # The following turn off the warnings enabled by -Wextra
> > >   ifeq ($(findstring 2, $(KBUILD_EXTRA_WARN)),)
> > > ------8<----- =20
>=20
> This I did, thank you!

Maybe that line "subdir-ccflags-y +=3D $(call cc-option, -Wstringop-overflo=
w)"
should just be removed as the setting of that option has been moved to the
normal C flags in the top level Makefile (out of Makefile.extrawarn).

--=20
Cheers,
Stephen Rothwell

--Sig_/_3HAcU_.gtxEp1r51mpFW=c
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWdz44ACgkQAVBC80lX
0GxlSAf+KitKCpVRdYYEKRdEri9+WN6iPfy9udxOjYbXvPKB7w74BnwjFhlT4nHT
w+MJR13YboF8ywPZSUPhWxydE8jY+sGrIvcVZnrxTf+adobPmsJjEI2QaURxd29s
FGILau7C3Zy+b2urEDvyEQdiQ00uOajI9p77IzIXYIgSib9If0V8aNHKF8RgsrRt
XEnTpgQ7spiyfi7RrgiH+QXMsv0NY0KJISNnl5COaUmvTsRob98d9X1Nw4IyGK2A
NwwDd4S2VALJrztLNdTPEnt/ijZgHXTd4xm7syOwrC4CHTdZegCy2/XTFDBHfBV6
3+ixuhRaUxHBiZJ2M0fZJOgyYKg3cA==
=FlIy
-----END PGP SIGNATURE-----

--Sig_/_3HAcU_.gtxEp1r51mpFW=c--

