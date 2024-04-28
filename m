Return-Path: <linux-kernel+bounces-161575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D37998B4DEA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 23:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77F9D1F210CA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 21:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B274DB647;
	Sun, 28 Apr 2024 21:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MMVBtUMS"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEFB8F7A;
	Sun, 28 Apr 2024 21:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714339550; cv=none; b=Vi6TYwML1OHNKoe+pJ6ZQPG2JOAPWwgdzlsbo8JzEw9GFyexAfsHQjQienGCSa+oeRMWfHXbW3y9aN9JTwWzagZXpy0TpNVerf6XjAQNTX9AMQszBmlLsmTXAiBYdYVrnPyPqA56vLdj6em8gVEKOOM92LHLB2LarS3CbwtOjAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714339550; c=relaxed/simple;
	bh=0NtjuzCB6VMMDSqVidiBsCYkBIdFo0n0n0CZImHiAmc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Vt4uLWSM1IqvudfNO3AyHlMiSVF/Ni6DG5r7HK2sFZk7FUakx8wWXJxSBcwL5iwsOQH9arMaN1lHAfnNO37Jen3gWaNsAH77T0EJDWYvT3Q9jGMC9azvdCYs5BY0F0CZj62aYNWcfyJ4gj2xXJrZqGf0CV+JfyXCEQlNl1DV4K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=MMVBtUMS; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714339536;
	bh=BCxazszJXPCHZtxZt5gmgHk4ZPfx+7MiooArslteiyE=;
	h=Date:From:To:Cc:Subject:From;
	b=MMVBtUMSlGQcbstEb1Tcmw+F2rWJNxe4Pw8vjGYXXVansGmH1pz9WaqUesdiKlgny
	 R1Rr4ruhRRQHod5pzmbFe6maO1lxMV4C8Mg7d+i2zgbIluWdqLC9DurGXw0EvJk1+K
	 TnKb0CRxYK8uS8rXK5ucvjpSfjJaO32DbjBV7jTfEkAG6EtBWpj8yyrd64F9/H7xly
	 Igm3htfiNcXbmu249DgEe1+B+eeIvXL7Zf0TBX2XPRmk28X4TEokqzugAwtmld8O+S
	 mxzwqb1lfERTPma+ZALj159nOlCspqoZT/LHS4cJWHI4I7bQJpK5LxDqhP6uGQASNU
	 6i1HOYV1TFvKA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VSKJ05Rlzz4wcd;
	Mon, 29 Apr 2024 07:25:36 +1000 (AEST)
Date: Mon, 29 Apr 2024 07:25:34 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the mm-nonmm-stable tree
Message-ID: <20240429072534.7c2cccbd@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kUAQAe_0TJ2JH5=KbyKbdJy";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/kUAQAe_0TJ2JH5=KbyKbdJy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  14c7095a68e0 ("LoongArch/tlb: fix "error: parameter 'ptep' set but not us=
ed" due to __tlb_remove_tlb_entry()")

This is commit

  7ab22b5c2af5 ("LoongArch: Fix a build error due to __tlb_remove_tlb_entry=
()")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/kUAQAe_0TJ2JH5=KbyKbdJy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYuvs4ACgkQAVBC80lX
0Gx0dQf/Tm4tELjrriq/ZQ3Vv+K4028D4aeFZ7pyVobxbSRKg2sWFiDFAf3DvV0s
7DE2qK+ZYSCGjsJuFHZo/lKOBl879P5pzNdjBHnXhAxLcv4jvtoUd9rQtFGyvtqh
SXAurxXZ6OccWo2hdRQ2xfRbiNLDGthzHgEPcmlSPH7czhCs9ZEIadLL3qbepY5D
jv80V+sJYfWgy7B5W1/C96x/7vZKVB63b088E8W0VRKu6lYXGafKSGzrUZvHJ5jF
yBNzfOONnKx+PhadsCX5Vw6x5RfWETjE1J6ClRShHs+id+y22Xjmut1nJZnxXZm+
GkeAshGI49cOlUxDl8X2rt259DrJPA==
=uE62
-----END PGP SIGNATURE-----

--Sig_/kUAQAe_0TJ2JH5=KbyKbdJy--

