Return-Path: <linux-kernel+bounces-62851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEC78526D3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4227B24D68
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FA625565;
	Tue, 13 Feb 2024 01:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="A8Uxo6+I"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184E3250F8;
	Tue, 13 Feb 2024 01:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707786258; cv=none; b=a0MQx1oZ0VFmtOGCmsII/BbSzsKH2lyIC7naFWZy7Z1u2vIWofyP68Vxh8/t3+/eKi8mZG0Fo7aLkyDHYRKzAYuJLFktnzvVDxMQ5DMsqN8tAZCUUuaeITmfPz5L3ZRF6O9LSRYcxdlsQvDPG4XINPybBc6Q7f/I9eapJ/zi9/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707786258; c=relaxed/simple;
	bh=giwJ46mPDfIHm6ENmysvTYdlLWa93FRQ2pBpII0aImw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jPLI/YBggCW6HGKt3G+1lJq/dnPsJYGu6jJPv00nc4oXgd8FYIT6j5Oy7iJ4A2nvSZAQit7TJJ16P3iMHHH9VscM92o+ElglK3YnZZfI0vjXcT9bzljtx/DmlSqgWG5YgwBPMHBUP4t4YE/nij2UdM0dmGguZvSmzY4K1PL1KmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=A8Uxo6+I; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707786253;
	bh=o5Tlbx4aE/Gpku6F/ewBl1HwifS1BiiLHPWkcYc/+es=;
	h=Date:From:To:Cc:Subject:From;
	b=A8Uxo6+ID6vcWIeRXHjyS097+pbzW3PIK5/sJBHSBncpF3pmDwK7qEFN5tniyQhml
	 h9o4ZgcdefHlT4N72XruRKnzF66ts/ejMZQfsYz6oCwdwXEWJuljDrTKKN9z8hIkpp
	 HPkQS7KZyRoqLbHsbFJQzySflfka+CWYhHXSW58e11CXAxvxPNzQtK1qBm6gPQfzeV
	 vaORi25N2/3T6fHkgQ1NDPIkGKvvUEpl9dNgbDo9U7a6uGx3vGIiONqpIYX1jzUwWK
	 lcz3buhllt8XYCR6fmrPNeYxFa2WVrmyB2is5IF81FX8Xv1pwNq1s3RxuqM+6+QT5e
	 sW4ib29l1nL9g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TYjlJ2q6jz4wcl;
	Tue, 13 Feb 2024 12:04:12 +1100 (AEDT)
Date: Tue, 13 Feb 2024 12:04:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@intel.com>, Intel Graphics
 <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20240213120410.75c45763@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6SNLxr7Gj4oO+.6T.Mf7CrA";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/6SNLxr7Gj4oO+.6T.Mf7CrA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/xe/xe_guc_submit.c: In function 'simple_error_capture':
drivers/gpu/drm/xe/xe_guc_submit.c:814:48: error: passing argument 1 of 'dr=
m_err_printer' from incompatible pointer type [-Werror=3Dincompatible-point=
er-types]
  814 |         struct drm_printer p =3D drm_err_printer("");
      |                                                ^~
      |                                                |
      |                                                char *
In file included from drivers/gpu/drm/xe/xe_assert.h:11,
                 from drivers/gpu/drm/xe/xe_guc_submit.c:19:
include/drm/drm_print.h:349:69: note: expected 'struct drm_device *' but ar=
gument is of type 'char *'
  349 | static inline struct drm_printer drm_err_printer(struct drm_device =
*drm,
      |                                                  ~~~~~~~~~~~~~~~~~~=
~^~~
drivers/gpu/drm/xe/xe_guc_submit.c:814:32: error: too few arguments to func=
tion 'drm_err_printer'
  814 |         struct drm_printer p =3D drm_err_printer("");
      |                                ^~~~~~~~~~~~~~~
include/drm/drm_print.h:349:34: note: declared here
  349 | static inline struct drm_printer drm_err_printer(struct drm_device =
*drm,
      |                                  ^~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  5e0c04c8c40b ("drm/print: make drm_err_printer() device specific by using=
 drm_err()")

I have used the drm-misc tree from next-20240209 again today.

--=20
Cheers,
Stephen Rothwell

--Sig_/6SNLxr7Gj4oO+.6T.Mf7CrA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXKwAoACgkQAVBC80lX
0Gy6xwf+OZxIVBmEY/rj22JngdZj1fuLWrpqgw7hAF9Krd0UuevXsW9OYC5BbOjg
iQCHdt7epxWxRL6lVYIjfgxDeS3IcitHn+EA/K4FyWEJ+0ZpaIyJuH24N/IKiEqw
EsyYFWSaeYzzLE6z/Z+u/T9J/pXulyHS90cFkqU7zNTKdefyaMZ5NfU8RE+FtQY+
6XR8XQXHSZW87DZ7NsVEWx+IygxF93ayG61q6B0rR8nTmp7eR6mJZ4ZxJgNxMCS2
dksH50v3Jo1Dakw4IP73LY5WnnJXARBUHw80OlBnikD/J4GI8mKEw+emRvcUfVZQ
QpddlqwTobavbULIN1nVd54eZMYlkg==
=gzZk
-----END PGP SIGNATURE-----

--Sig_/6SNLxr7Gj4oO+.6T.Mf7CrA--

