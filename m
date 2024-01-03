Return-Path: <linux-kernel+bounces-15037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D50F82268C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6ABF1F230A7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37E520EC;
	Wed,  3 Jan 2024 01:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KlGI1R4Z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9E11379;
	Wed,  3 Jan 2024 01:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704245255;
	bh=awBZUIwEw4tBufOIYz5Qk1N+0pN+zlrgvsR8l5wNUqU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KlGI1R4ZiCLZ2ce+Y/o+K+OVa+hgviO5R62M5t/e5vsg/d/tqVhwJB0P1jrTBraa7
	 XmgkQT90Fk4bIHTwzcFPelE1sZdtxz14WfFi/Wi2thEQi0eFnlOG7R6VvKjpZ714+Q
	 OganE/LUti8TXQKRpTG8EiW6CCUqS4mjB8zgYbmXE5ZQBr3MaSksYoXrOq6GUrZcbB
	 6XyL++uvBFfaiXnfqFz3WxRb0QW+IQEAB+U0onCrgHuPGeUjVQA6hgRrL8RwHkaf0H
	 UM2Myq3nsp9z2tNMVNJNg9/pb/CBUrVM+2bmFXSexZcB2kL5v1L8wU9EU8O4ZyNckT
	 0aVlQlGZnidxg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T4XCC1vkkz4wc8;
	Wed,  3 Jan 2024 12:27:35 +1100 (AEDT)
Date: Wed, 3 Jan 2024 12:27:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@redhat.com>
Cc: DRI <dri-devel@lists.freedesktop.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the drm tree
Message-ID: <20240103122734.16b29e09@canb.auug.org.au>
In-Reply-To: <20240103121911.4ec8f237@canb.auug.org.au>
References: <20240102111222.2db11208@canb.auug.org.au>
	<20240103121911.4ec8f237@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mWzhyXl4eKqLAEr+LnzDcYY";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/mWzhyXl4eKqLAEr+LnzDcYY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 3 Jan 2024 12:19:11 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> On Tue, 2 Jan 2024 11:12:22 +1100 Stephen Rothwell <sfr@canb.auug.org.au>=
 wrote:
> >
> > After merging the drm tree, today's linux-next build (x86_64 allmodconf=
ig)
> > produced this warning:
> >=20
> > In file included from include/drm/drm_mm.h:51,
> >                  from drivers/gpu/drm/xe/xe_bo_types.h:11,
> >                  from drivers/gpu/drm/xe/xe_bo.h:11,
> >                  from drivers/gpu/drm/xe/compat-i915-headers/gem/i915_g=
em_object.h:11,
> >                  from drivers/gpu/drm/xe/compat-i915-headers/i915_drv.h=
:15,
> >                  from drivers/gpu/drm/i915/display/intel_display_power.=
c:8:
> > drivers/gpu/drm/i915/display/intel_display_power.c: In function 'print_=
async_put_domains_state':
> > drivers/gpu/drm/i915/display/intel_display_power.c:408:29: warning: for=
mat '%lu' expects argument of type 'long unsigned int', but argument 5 has =
type 'int' [-Wformat=3D]
> >   408 |         drm_dbg(&i915->drm, "async_put_wakeref %lu\n",
> >       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~
> >   409 |                 power_domains->async_put_wakeref);
> >       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >       |                              |
> >       |                              int
> >=20
>
> In file included from include/drm/ttm/ttm_resource.h:34,
>                  from include/drm/ttm/ttm_device.h:30,
>                  from drivers/gpu/drm/i915/i915_drv.h:37,
>                  from drivers/gpu/drm/i915/display/intel_display_power.c:=
8: =20
> drivers/gpu/drm/i915/display/intel_display_power.c: In function 'print_as=
ync_put_domains_state':
> drivers/gpu/drm/i915/display/intel_display_power.c:408:29: error: format =
'%u' expects argument of type 'unsigned int', but argument 5 has type 'inte=
l_wakeref_t' {aka 'long unsigned int'} [-Werror=3Dformat=3D]
>   408 |         drm_dbg(&i915->drm, "async_put_wakeref %u\n",
>       |                             ^~~~~~~~~~~~~~~~~~~~~~~~
>   409 |                 power_domains->async_put_wakeref);
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                              |
>       |                              intel_wakeref_t {aka long unsigned i=
nt}
>=20
> I don't understand how the above patch can change the compilation like
> that.  I must be missing something obvious.  Maybe my compiler is
> strangely broken?

OK, the only thing I can find is that there are 2 intel_wakeref.h files
that have different definitions for intel_wakeref_t:

./drivers/gpu/drm/i915/intel_wakeref.h:typedef unsigned long intel_wakeref_=
t;
./drivers/gpu/drm/xe/compat-i915-headers/intel_wakeref.h:typedef bool intel=
_wakeref_t;

and the two compilations above seem to use different include paths, but
how the single character change causes that is beyond me.
--=20
Cheers,
Stephen Rothwell

--Sig_/mWzhyXl4eKqLAEr+LnzDcYY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWUuAYACgkQAVBC80lX
0GzqGggApfYV/oSvb4o1uSyi6JfdCPy2T1rN/bO5A7JxQLPkaClTa9dhLP3FdI2c
CjqYziggHdybTtasqbdkQcYfxeCEbm3020sCO0oCkhcK37J871SPJPk0SAlvp1pv
Y315uuFb6fDURfPIs6YDmNfCTYc3qPNdYLOMsMKlRnFJrpea8iJ7uDwsV7qrkOP7
yAPUzS5NI6ekp2MrZyE+SMupjGUUsktSjZdntYejg4ie++v04GnH/+/v6Vi1mDtv
00M8OC6tLvTH+R+dpqi/NRXBye1aJ3CJOiY1S1klQ4PYhGBMKcP4UkRsntOjbPP5
7pjWhOYJ+QNr/o/KNvK2eCuAVCqlEQ==
=6LLK
-----END PGP SIGNATURE-----

--Sig_/mWzhyXl4eKqLAEr+LnzDcYY--

