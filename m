Return-Path: <linux-kernel+bounces-43605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02659841684
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9DFD1F22ABA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B47524B1;
	Mon, 29 Jan 2024 23:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fXZwwIPB"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492B851C34;
	Mon, 29 Jan 2024 23:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706569653; cv=none; b=RmpTPOmQJVtAKgCiOjCxS1BhpGdw7EYMb1yQGwwDf1C3L5IA1JPioTaqndLCRWRuElXepibZK5LgI10d0n2K/5rmM+MyPAQ5bdl42WhFToLLp1u7m//9SN/Cdysc5/USl3uMgxqZo+viSR3tDNs5YBhEFGuIvPfTc8xoKxATYL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706569653; c=relaxed/simple;
	bh=wMk9MvJELyS4ptm3XDxSLL5Hfx5pi5MVKNCZ12bw6to=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CkocgIqG30gNOxbsTtZAe960qdD0JnVaPv36e8KYMcoAtjFmuFth8SYwpxel8eKavljdYMQ/ZhW6CtQraZn9/TWHsjtCCl6FjjZzXU9GTUe3oZ4BrBIquuIt4CuNiM0WDNTkbBi8KkVyiocZ5zLOHxZSSNrEImv0kga9FEC8Zas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=fXZwwIPB; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706569645;
	bh=klynrzTv6TEPBx4Pi5/vs/jYPlWsZogap6/S8X3FeRU=;
	h=Date:From:To:Cc:Subject:From;
	b=fXZwwIPBNgAMH+eRUYeALICoErDhnavsovcGKEN0wZ7XJqDL21BHSIny7qBNbnYIj
	 YpVz6+ZpWet6jnJM47HT0jOpIcK6clHY0myB9Ajg3KmzUhes3jmG79YnIAXpo70pD4
	 lK4eirhBf36z0KVTHI0Ve+yfzSRHzXekCV5z01BmofV4GkJ+1tdJuxIDvOuEkfdi7D
	 hX5M5XM2HZJUnfbNYKxlIIpXaWHgbn6ViyshZyBahGleXnpnIZoDXq4o4BS4XM4sZv
	 +y7F+0lIaQXYQjfXTEYVum2i+9u+JzTYGq1K4QgRjXLGgGEAXINEV/hUS71dWGFhf1
	 BaJZhTr4Gjqdg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TP3q06Nd7z4wxx;
	Tue, 30 Jan 2024 10:07:24 +1100 (AEDT)
Date: Tue, 30 Jan 2024 10:07:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>, Helge Deller
 <deller@gmx.de>
Cc: Parisc List <linux-parisc@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the bcachefs tree
Message-ID: <20240130100723.323c19fc@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/U=c+CUJdVFhhdpYd37pbtHo";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/U=c+CUJdVFhhdpYd37pbtHo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the parisc-hd tree as a different commit
(but the same patch):

  eba38cc7578b ("bcachefs: Fix build on parisc by avoiding __multi3()")

This is commit

  94a54e4eb439 ("bcachefs: Fix build for parisc by avoiding __multi3()")

in the parisc-hd tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/U=c+CUJdVFhhdpYd37pbtHo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW4L6sACgkQAVBC80lX
0GxPigf/byw2mx3xwl+odoXbWtiVVU20CsordGHrLuhuUzF+b+15mlLQGK5aMPrJ
+OncBy4tvnCCMZIjpItA/7/PbUbWQPF/CmTmeYwe2Qtbs8oVxtHlmziKd2+w3tQQ
VeXBxeFHX2YyFL5ajcWLcYVrmNriwA+4U06C5oXgNFfnzVU78WlJdu68pBxYxciE
kCjPFNj5aMCrQr0UWFmUePtH2ObwlmBkg3rsptgMvxcYK6zt5MNRtnd+vUYE+QFX
pHtqUDDpmydRPEFpXy2Q0MwFsOvKKWGB/eM1Iw/JSGiqB1XaS3nDhTK+c8eTf8wC
Ko9pEyRxYlJJDbfacttC9sSe+5KAPg==
=4m+I
-----END PGP SIGNATURE-----

--Sig_/U=c+CUJdVFhhdpYd37pbtHo--

