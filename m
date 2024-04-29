Return-Path: <linux-kernel+bounces-161721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4EB8B5026
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F35A1F224E7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 04:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6CD9470;
	Mon, 29 Apr 2024 04:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ksp7pEgF"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4AD257B;
	Mon, 29 Apr 2024 04:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714363656; cv=none; b=kDrosfYtVTG+pglmWJ5r4IjgJgxWD0hZ5oVAgAHkATrEWmirNxSG7/E3VTTEBDBuDBnKTtu70zmvG+zQkV6vtFZf2lxIYTVKaKvBQuhbpwfRg5FWcqR1V+TrK6hFSXCg+5Az6MPyPlE867b0t+4dyUz+QqS9xQxJrtmfYUbHAXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714363656; c=relaxed/simple;
	bh=ZPOdAdo5rNdhkmcuD8Q0Bjb82iNnSAHow9YWWhWSvqw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DHPy/fvDGzph/UPPe33NoozDc71/Sz6k+A8b30gqFc+xIlBsrJUcfHlcblcCX44rnMRIBsg6NcpoZkpS4LUEYm4roy2OIxAg/WHBvQujOeamYrQEohiIuGzmPOD0Zok8W0Eh2zf+xYnAnr8mJxgajq4VwMxuEOs7O6sc0P52R40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Ksp7pEgF; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714363650;
	bh=gXM/pmAGTPfke+UuNfHVJkFpjdgFQx4XDaPamrZGXkw=;
	h=Date:From:To:Cc:Subject:From;
	b=Ksp7pEgFztp2zNQFferXewH3IcXM/kuKLwsHC/e4nQg/4zheI0kLVI371BvP/Ttj2
	 lbq7i+iGmxKX3KC1nHuoYA42nlBJLVGMZzbQyq/vslnPM7A/PQZLnTgj/Tw8oIpxjF
	 YSV+NvLeGpLNArshkilGeptssnwPoBmiaCsp6J15OGi42L+Wk/bUjv42HIts+vuky/
	 ZfI5iJI7R3sNxtaF/F/C9CIN2YaQUD3WG10Q6zEwOO2y4Bv0UWpVUCm6x17LDIWEx/
	 7EgTnOHtuQUW0m7yfapRQtqtDxNMsTZ/ivh0mDPEt5zrzBKsBdeHRk3NaPb2DClSs9
	 422JEJdxmoNnA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VSVCj0JPqz4wd7;
	Mon, 29 Apr 2024 14:07:28 +1000 (AEST)
Date: Mon, 29 Apr 2024 14:07:27 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Joerg Roedel <joro@8bytes.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Joerg Roedel
 <jroedel@suse.de>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, Robin Murphy <robin.murphy@arm.com>
Subject: linux-next: manual merge of the iommu tree with the pm tree
Message-ID: <20240429140727.016d5758@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7lU3zzmZSsQQJh4lyfcrIIC";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/7lU3zzmZSsQQJh4lyfcrIIC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the iommu tree got a conflict in:

  drivers/acpi/scan.c

between commit:

  e80d4122df9c ("ACPI: scan: Move misleading comment to acpi_dma_configure_=
id()")

from the pm tree and commit:

  f091e93306e0 ("dma-mapping: Simplify arch_setup_dma_ops()")

from the iommu tree.

I fixed it up (the latter removed the comment updated by the former, so
I just used the latter version) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/7lU3zzmZSsQQJh4lyfcrIIC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYvHP8ACgkQAVBC80lX
0GzSbgf+OxwUfsY9Xy2mtx6CzzznbBTeYjt3V3bYWnXYJrLc46yrq51bj08E36Za
sa/zENKQb7jEf0Jpvgm+CkMZYnsRLUH3CG6cm8cO3hPm4ZDCoIWK6uQQFRGsomSS
uYQ3dxexU4f1Nxkvnzlc77RopNScbrFFjJOcJIJaU1W71xeyyGtCVdAr0O1N38qg
t789mkIYvfSkCED0ar1W/b49NX/hwd8KVLqLkt6LT02UQDaj8FOB3u/FFSER9JZb
Vw+Pjv3cif96Be1nizkw1RFzSIOYMUi3rPsPWYW+U/yPDOF+1e22tHyDeYRpKTtx
Q8iz836FL464tHmoh0Gth0adCZU+Kw==
=lyV5
-----END PGP SIGNATURE-----

--Sig_/7lU3zzmZSsQQJh4lyfcrIIC--

