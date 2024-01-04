Return-Path: <linux-kernel+bounces-17259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35816824A82
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC60287069
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B6E2CCC4;
	Thu,  4 Jan 2024 21:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jT76Tn6G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115CE2CCB0;
	Thu,  4 Jan 2024 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704405187;
	bh=pDXgYGPQvMZ+WSbHvTdIkjk/z+GYCZlcPmuxoW3COew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jT76Tn6G76UklbwJfFclIVdBoPxbX5iQC+1FnGJNnfErZJZaPARbTEP+g5szJmlsZ
	 VlwUYUZKmYK2/vFfNJhGrRAs8H7O/4ecNqpt6D/R/dVWEIjTIPa6GuF0Uh9E8SOaX9
	 iXBCAHsyUzp0Pe8/b2IEKSZUI6XsrvmrNcse6ntG+FcDc2lMFLdh12XT/uvYu2GN3W
	 Bu+jXP23GL3skyJFXjW3SeznScjw/mJ0GW40FSPbeuPNOgUqnPwEwV4l0He0XfGNsI
	 vvrA492/R7NsDMpZ4Gby7dEvCp2oKfuDK1PqFxf0lLWm1ycxo3vie6xrEwStM7Ch1d
	 qGL3ONBbKRouA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T5gLq53Y0z4x1x;
	Fri,  5 Jan 2024 08:53:07 +1100 (AEDT)
Date: Fri, 5 Jan 2024 08:53:06 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the cxl-fixes tree
Message-ID: <20240105085306.60979082@canb.auug.org.au>
In-Reply-To: <20240102023218.3cd3e4ea@canb.auug.org.au>
References: <20240102023218.3cd3e4ea@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5kw+qjFC7gX84eadh50uSB2";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/5kw+qjFC7gX84eadh50uSB2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Tue, 2 Jan 2024 02:32:18 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> A large number of commits in the cxl-fixes tree are also in Linus
> Torvalds' tree as different commits (but the same patches).
>=20
> A bad rebase onto v6.7-rc6 has been done.  I cannot use this tree as
> it is.

Can this be fixed up, please?

$ git rebase --onto v6.7-rc6 251c56533a2c

should do it
--=20
Cheers,
Stephen Rothwell

--Sig_/5kw+qjFC7gX84eadh50uSB2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWXKMIACgkQAVBC80lX
0Gx1GggAoNcTsf/OdSyde3sH9bRzCFS5pYwAsnpfJU+AZRVjI6bL5cKlMH6WJImR
yHV/JO/+Qpmynv7emjlkHDusJ1MuClMTkL+B74GftWi6I7h5dkgZFyA3rrW/zsZp
g4UjvinB1mdBrKCyvayg1/1wJP4adYvOgf+oLIG8aHcUhS3ZkFRGNivOydbG43ZU
tn58iSLoN4cAa/VdvrDqqUxY2POML0GEo3iZd6V6g/NEJ75og388g3JIQOxhEVbX
NGS2dTcFu9Ezw6zAdqrdHKU6mlYkG9ImCYYDmvbezJLaV4D11pG/i0CcEnS8Cqdj
jfWGvYqgHTi0lFvy56FMnkEERe42zA==
=Jc26
-----END PGP SIGNATURE-----

--Sig_/5kw+qjFC7gX84eadh50uSB2--

