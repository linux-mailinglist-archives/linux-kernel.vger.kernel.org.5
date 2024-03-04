Return-Path: <linux-kernel+bounces-91389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CA88710DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDFBF1F22B4B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA177C6C9;
	Mon,  4 Mar 2024 23:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kaTeYXXR"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E37C7B3FA;
	Mon,  4 Mar 2024 23:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709593466; cv=none; b=d+SSp4oa5Ajk0JmY32uUi1eDemXh+yelkWDibMouwaNwhrPBcydRdR01tIZuELZc3Czb/rOVGS26kPj9XeFoFcXmkbYWE/O6mOxyFarFdcOMr1mXw8k6vfZE2aIkIqtFoUj+FEmfNk1KQKbd9Gm+ZAt0SMGkOFMIriV/XDHq0FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709593466; c=relaxed/simple;
	bh=3fizgap9kRHwdYFmCKbypLQTKC6lhALk+RWt1ErVW7c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZtVKK6aMHzEp4YnDUaEQnq8LP7flKh9PDYnSxy48nlh0XU7gbyoqGah70/x03OIiUSB7C8nGKTgmO7ZuhgpXTEVAKSONVIzDoZhg7ekisDyKB6lkIrIXGYyFq20pMHabHfoWyyfS8pjr4MLya+ZasuvI8iYjknsGSEn3M0/UDVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=kaTeYXXR; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709593456;
	bh=yeJtJRmkh6lrE1U0nPq5HZKG+k3TaMbjaD+Va9qkN0U=;
	h=Date:From:To:Cc:Subject:From;
	b=kaTeYXXRPqYAuiAn1Pthe6Ab24CWIZpN1hQkutIqppgCiiQ7RMNxpqmuo2vrT21yc
	 gmYTBEkXHqUjwHs/t6nI1kBe49YgqwIsILHK2pcMrXV098UHqR1x6BJxpjzCvCDVQQ
	 y5tN84G7YBbI19UVrc4y5h7VIkTgPqb6kVjo1/38OclZ47AaxoNsMtRlrsaDXsaNN0
	 vT5XAgR8WlvI6J5Q9ILlwsLYVcVMS6ubhp9hDaj3bZsn2tYHz4Y+vdmsSaLqbd2K9b
	 S9mNixKKZrE4yE2slPwfgE5Eqh5RcQBRj6MDrmJhdOFhPP2TYU+KYF1t+TLX98gmx8
	 P8jNKi5AB12gA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TpZ5B4lkhz4wc9;
	Tue,  5 Mar 2024 10:04:14 +1100 (AEDT)
Date: Tue, 5 Mar 2024 10:03:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Olof Johansson
 <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc: ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the samsung-krzk tree
Message-ID: <20240305100340.6abe706c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uaBpdjfb0E5xAXH7PyhgiEh";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/uaBpdjfb0E5xAXH7PyhgiEh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the arm-soc tree as different
commits (but the same patches):

  213b755e42e2 ("ARM: defconfig: enable STMicroelectronics accelerometer an=
d gyro for Exynos")
  5fb1252944fc ("ARM: dts: samsung: exynos4412: decrease memory to account =
for unusable region")
  b43b68935124 ("ARM: dts: samsung: exynos4412: decrease memory to account =
for unusable region")

These last two are also identical to each other.

--=20
Cheers,
Stephen Rothwell

--Sig_/uaBpdjfb0E5xAXH7PyhgiEh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXmU0wACgkQAVBC80lX
0GxSGQf/RCeJtjTazpjgGOenDQnQeYXNSgGCUQ4Uru7TlNarhz8QuEzqEPaO+yLF
v07yx/tTc9REpT3PtBhnOu/42zNM0UH2KI+5+RfnI2TA7IB4CFkzfuaS5UUx1ObJ
SF4Y4M+VwZ21BYhFa+nS6vyw9p7qJfNHDGOaqZdYovuL2dEanoyuD9pjsMR2rx46
leiB3VyZtiAMAnScoBvWIYJjiyIm9MEnVde4H61rMif4FrYiLIdLWKC2tUj5h3W0
MrRXVlh6TMLsvRYFjXuQCNdNUEkoca6EBu9vA25BtGkppmWQqn2ZmA0fXwMgrQjh
weLOgPmo9Dppjnxf7fDMeXsAWGg5nA==
=dTH/
-----END PGP SIGNATURE-----

--Sig_/uaBpdjfb0E5xAXH7PyhgiEh--

