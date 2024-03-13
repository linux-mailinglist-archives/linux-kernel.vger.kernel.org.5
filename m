Return-Path: <linux-kernel+bounces-102520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD73B87B343
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67F431F23BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7DB53815;
	Wed, 13 Mar 2024 21:11:59 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF65352F62
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710364318; cv=none; b=P3OSlGunVlOsBzB8kn7J0SG8xKBauMzwUVusjX5qjhU+U1Dw6A7gfVqhQAchYEUtQBxj4DLLtduW/pxo4zqUiuqeEYTYQXBRFz2LJrJ35/JjV0Wdnd3Mn8XyW/axugHptuUUee9+uXORDl08Wmm3ISEH7ZCxiPs63OwScaUoKS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710364318; c=relaxed/simple;
	bh=CkirnxgDJ9p88nkJiU6T7q9Q3jBG6nH3fti0p+W0f+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0J3DsUcyc7jyAw2dUhtN4v5at3JDNMDm4GYA7ABDLmRO1IOLFM+oDpVzrBRXU7e3xNQH8sj4XZfNN9ql6n6efcPxUb0ozb+HftSBs8yJtqLncJuRCfn7P4xy9zKSoyCXWMfujn9ahJl1614VlaYC7KHGZOO8V32KqTzESHIuw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rkVt3-0005sS-9o; Wed, 13 Mar 2024 22:11:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rkVt1-006BMA-Ob; Wed, 13 Mar 2024 22:11:43 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rkVt1-005frL-2B;
	Wed, 13 Mar 2024 22:11:43 +0100
Date: Wed, 13 Mar 2024 22:11:38 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, 
	Andrew Morton <akpm@linux-foundation.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>, 
	linux-kbuild@vger.kernel.org
Subject: Re: linux-next: build warning after merge of the mm tree
Message-ID: <gegwogwbrigfaqjoymgndji6wmllqgkhs2mmgvpksqzsil64zr@pimmxvvvgbqz>
References: <20240313150728.12e20208@canb.auug.org.au>
 <psaj3nztnhcxiwjnie3bbpsn7efcsxp3yx3mh54uello22773v@fw5qpqs4gh2i>
 <CAK7LNASa-KedA_CTww6unckAGkJCQTctdbk0d-MUsN7wQpM=kQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h3yhzmapyppypztu"
Content-Disposition: inline
In-Reply-To: <CAK7LNASa-KedA_CTww6unckAGkJCQTctdbk0d-MUsN7wQpM=kQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--h3yhzmapyppypztu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Masahiro,

On Thu, Mar 14, 2024 at 12:22:46AM +0900, Masahiro Yamada wrote:
> On Wed, Mar 13, 2024 at 6:01=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > On Wed, Mar 13, 2024 at 03:07:28PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > After merging the mm tree, today's linux-next build (powerpc allyesco=
nfig)
> > > produced this warning:
> > >
> > > Use of uninitialized value $ENV{"abs_srctree"} in concatenation (.) o=
r string at /home/sfr/next/next/lib/build_OID_registry line 38.
> > >
> > > Introduced by commit
> > >
> > >   325f7b0aaea6 ("lib/build_OID_registry: Don't mention the full path =
of the script in output")
> > >
> > > from the mm-nonmm-unstable branch of the mm tree.
> >
> > Actually the warning doesn't happen on 325f7b0aaea6. The commit is only
> > problematic in combination with commit
> >
> >         e2bad142bb3d ("kbuild: unexport abs_srctree and abs_objtree")
> >
> > . This commit suggests to use $(abspath ) or $(realpath ) instead, but I
> > fail to apply this suggestion here.
> >
> > Obviously
> >
> > diff --git a/Makefile b/Makefile
> > index 5e09b53b4850..f73a73a125e0 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -39,7 +39,7 @@ __all:
> >  # prepare rule.
> >
> >  this-makefile :=3D $(lastword $(MAKEFILE_LIST))
> > -abs_srctree :=3D $(realpath $(dir $(this-makefile)))
> > +export abs_srctree :=3D $(realpath $(dir $(this-makefile)))
> >  abs_objtree :=3D $(CURDIR)
> >
> >  ifneq ($(sub_make_done),1)
> >
> > would help.
> >
> > Any ideas how to properly handle that? Would the export be ok?
>=20
> Oh well, you are making a lot of effort just for a C comment line.

I don't care much either. Given that now I know how to somewhat keep the
originally intended information, the effort between a fixed string and
a dynamically generated one isn't very relevant.
=20
> use Cwd qw(abs_path);
>=20
> my $abs_srctree =3D abs_path($ENV{'srctree'});

Ah, I missed that srctree is an exported variable. Thanks, will prepare
a v2. akpm already dropped my initial patch from his queue.

Thanks for your input.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--h3yhzmapyppypztu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXyFooACgkQj4D7WH0S
/k6YbQf+NO7nuOlyfJUNH/EzC39lZjopqSOniArTPILTVBheThlnsa8fo+zR76W7
U84Mr3LmKdDQ8zyABuQHA6Ok7Q080/XrJnASkY5D9/gOXX6RbMzY0P5cOv67Xexm
UVGYJnasHwz0y9iNRuKnrWbmVaQPjQui+iB4IeLweckki8TenaSUctBeK8A9w7wv
LjjGC3Xz0MFbf70waskLDTFMGHRM3lZQ+ilSrsSlib2OoqYHPMyaL8anjr6m82mI
WKbwu+o027cB/2zkMY4Bc5pF+COeObjrA/ATmbXVRLduv/ATSF3z4w0A7eyLgyKL
w2N6oV32GTQS8cp0f6/3NliEIZQQNg==
=pHxQ
-----END PGP SIGNATURE-----

--h3yhzmapyppypztu--

