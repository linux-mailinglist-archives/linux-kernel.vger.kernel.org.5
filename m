Return-Path: <linux-kernel+bounces-18437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916E6825D71
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 01:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73981C235F4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 00:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3449B1396;
	Sat,  6 Jan 2024 00:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BHfl8XWB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A8210E6;
	Sat,  6 Jan 2024 00:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704501925;
	bh=a9TqJf/J+DEHEPK//TAyFEgZIVh9BJi526NaHHRYabM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BHfl8XWBjKf2RsVYJP9D7cr/+R8pHUL7er+2gP+Ftu0o8Pz3KXhSlShw8PQv1LUkU
	 LuQuBPFrSVFzAk81vnXzwCB11Rfd82YbBC/eLJvVIuNOcipq+SrKbMZI9tnX+5PGws
	 SdLFkMDAAjPtjR1AOQWCNNtHLFYv/eNaPi8mliqIuVL0YKpM/4HfM/qi7cXl4DgLBM
	 GIY0KDC6uzOYXo56vKIMKzSvFZeB5Gu3HjMqM2pOhOTz6V/nSlZRm6OCXgPAyEYFHe
	 P4ZOryb49Qzsd89NSgdDULwOOxS51VoYZ8xnJeS9KTI38KvoRCJzZ/onJKKCA0odZY
	 /XWQD00PwoULg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T6M781Fz0z4wp0;
	Sat,  6 Jan 2024 11:45:24 +1100 (AEDT)
Date: Sat, 6 Jan 2024 11:45:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Jeff Layton <jlayton@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Neil Brown <neilb@suse.de>
Subject: Re: linux-next: manual merge of the nfsd tree with the nfsd-fixes
 tree
Message-ID: <20240106114522.3c06e732@canb.auug.org.au>
In-Reply-To: <A65DB9F5-8777-430E-8BDB-F2AD2E073A25@oracle.com>
References: <20240105110007.3f932561@canb.auug.org.au>
	<ZZd8q4RSTTN/5wSq@tissot.1015granger.net>
	<20240106093347.15810e18@canb.auug.org.au>
	<A65DB9F5-8777-430E-8BDB-F2AD2E073A25@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iTCJE6SSS.=tr9PQ_AdJ+mC";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/iTCJE6SSS.=tr9PQ_AdJ+mC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Chuck,

On Sat, 6 Jan 2024 00:26:53 +0000 Chuck Lever III <chuck.lever@oracle.com> =
wrote:
>
> My development toolchain is stgit, where rebasing is butt-
> simple.
>=20
> I'm not smart enough to make all that work out, and merges
> make my head hurt. That's why I let you and Linus handle it,
> and then never rebase once my PRs are merged into
> torvalds/linux.git.
>=20
> I'm open to learning more, but I might resist making my dev
> workflow more complicated.

Understood, but if you are interested, see
Documentation/maintainer/rebasing-and-merging.rst

--=20
Cheers,
Stephen Rothwell

--Sig_/iTCJE6SSS.=tr9PQ_AdJ+mC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWYoqIACgkQAVBC80lX
0GwvMQf/St6eZBUic0eORurt4uyq67/AyvbH27ZrmJ5JLW3lEANaRaluVacugTa6
OFCXLj2atWqDp4twGm/vtlxJnhzz1mdlkPB2htqVYew0yRXu7x5KDNByVf1UEfmE
H8w4mlBfcWpiwpoUhOa2K/x0At7WJF8MQeZ/DxgWKlulOZcA3CnnIfLhYPtwXCdO
iZE4TA9IzgB/n6TxBjobu1fPODpqu0WLkSXjvQQiGZHxBbehb/+CGrBnCoTZWIi1
7mqmzggIbPgb7OhSVN68Lm932lMMtudB5aNyCgNsZhnv46BKIxXNRLFfVRhxgPhx
JJ5gAqdCGEheon3gMFT8uMUhO1FbRQ==
=PeA0
-----END PGP SIGNATURE-----

--Sig_/iTCJE6SSS.=tr9PQ_AdJ+mC--

