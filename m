Return-Path: <linux-kernel+bounces-99631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FC3878AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9761FB21A19
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BDD58AC1;
	Mon, 11 Mar 2024 22:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Dad3XzQb"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEDE58217;
	Mon, 11 Mar 2024 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197480; cv=none; b=H5O6tp0Kqry2natFzo+WD9AsBHD/ZVPLzU+Lz0/ilFTkpofOOcaRcdtIZLtGKsCqQQmgq882X9xOExKbHWFj3O0CwOO2nmddRD+4jbpTYLylYmTgcEk4Hl9tt4cYOMmySjZW5uAmkBe36e7EAF/KzRidxluYRxGdi8YWJRWfy+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197480; c=relaxed/simple;
	bh=uChjqVtXwXud2uwj9W+yjNQ4UtXwLPa6GBaoBbuNFAc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=aaHVL6oaO5yDmamVMcBxBGeTtyOisoFFLnjvz0GeFknBYvV3KyOsKW4fOYSbSs9dCxhQuOIC4xbIRHMoGuKuQAj9pb1Lf/ECu7KuL24igo+s0QfpjsGGoT/O6uPA9gRv1vmq6pWnOf5Bv6SjHmbdyKasBAZn7gz6CblM1N9bpWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=Dad3XzQb; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710197474;
	bh=SFaVhlHQebJ5CSD+e2Ejp+rOSd2Ft2Hk6RumE98gU8E=;
	h=Date:From:To:Cc:Subject:From;
	b=Dad3XzQbn4PmkK31GLBZqmHDhmkGf5ksfNscAiti5Fj3ZI8+PFLiwF8Pup8k51lHE
	 XbLX1zo2akWiK+c5Bp6Nm8DHPwQIJYtkn+JzVkkcREHXtBHrMjYpLuV1Tfximdz6kZ
	 L2CaQU1ANtEtWOd5rWZ+PrjWFclTwUT34zTQVSgvdCBhMXFg70xO2cTdguw9ENx4UD
	 Rm4X8BuMWBgvPXIQYORWy5Wee75mAzIkop75MZJXFKevJILDLNPhTdalSmUG45Gxoh
	 7eJr6S/ucLiXQSm4JseTMBL4TpPueThVM1C0bzrs0TROQNmM9wW76kywP0aHBFzUnv
	 vxf2AgRDBn4+A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TtsSy5nZmz4wyx;
	Tue, 12 Mar 2024 09:51:14 +1100 (AEDT)
Date: Tue, 12 Mar 2024 09:51:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Rob Herring <robh@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the devicetree tree
Message-ID: <20240312095114.346c1cba@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IfuJUAAlcTM8/kWAEoTxo6X";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/IfuJUAAlcTM8/kWAEoTxo6X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  3b8b8f8a4375 ("dt-bindings: display: samsung,exynos-mixer: Fix 'regs' typ=
o")

This is commit

  571c7ed0baa9 ("dt-bindings: display: samsung,exynos-mixer: Fix 'regs' typ=
o")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/IfuJUAAlcTM8/kWAEoTxo6X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXviuIACgkQAVBC80lX
0Gx68wgAoCANd5a5ezC4o6EDHsTXDx//n83SLGKR8SJ7kFSwwr7jRIuDm61b7cN2
m4twj8THquPmByl7RBsVLLpKXqWOC5Z5arOEzAa5O18u4XbSR4bv9mOfotRF6VbX
oVkzWgTN5bqkM5PBatAyFkzOSodMJejOTkugSHfBSsaBmn2CLtwkUOkwUdmtUeuM
Ritv57odYur2XM9bKHGzYJ/nEEJ0v8l2dPQCkt3e5EBf2Fshqi38JPWPRGwni9AN
GpZpgRcYoAOMpd3SFZfdwy/HTVyDSQoBUrEowftrRJrBSP9UGDSe0qB/QQY/BY7u
Qm8W/nGKuD6v8EeN24GwqKq8e1pa+A==
=pEd1
-----END PGP SIGNATURE-----

--Sig_/IfuJUAAlcTM8/kWAEoTxo6X--

