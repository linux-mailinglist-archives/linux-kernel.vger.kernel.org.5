Return-Path: <linux-kernel+bounces-80294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 408C5862D02
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B726B212E7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 21:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C931B946;
	Sun, 25 Feb 2024 21:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="txtPytiP"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39742610B;
	Sun, 25 Feb 2024 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708894925; cv=none; b=nLNLv2hFADu20oL1FwKAi5Hivd7C5Hc94ROcZw/SeInHGVb2cZ/irkn+bsN5duzT0nK/Aec1d56LjxemjReZ6Nl7a451R6G/qOZEhok+1kTWPq+3mc4B+hGv4j4UAta/oWldXIilW1UebtYFI2WnB0b56/NWrIM0Jp/nD/jdq14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708894925; c=relaxed/simple;
	bh=2JlcnRStS1koCOXyGlYdiJE9k4jw7gaK388efxBwYmU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Lspe+y5iV7VujK3+RvtuiLgqZrNu2H4bEX20nyCuJiOMmh/+dQ7pG/HHhcf4Gj/mDVAQldblktyogSPNrQ7k2RbbNEZSaBZzyZxEZyecn3rAbojGBhIltYlmwEb1Xi4ZYMymxpc0inKAG6QwOb8ATIR0y0ura1icNkVvIRVNr6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=txtPytiP; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708894918;
	bh=bvuXsT9UZfrPYA1ft6+qYjXuHtfayl+u/fuwOJZurPY=;
	h=Date:From:To:Cc:Subject:From;
	b=txtPytiPO28F+9hQbT8fQuJHQ0bjtpceMoI1k82hJus2utzEXtzFD5Z8H0Eii8FuQ
	 6EJqzVHr+cvF7ZnjogSu7y/q0H4cMTWheOLzvXwybKWA25hSLeJ9HGhj24CkaxezvF
	 VJQ9cZ23LpelyWmkjnyK4pO0/p17BYd/pxJBYmmvc1wfOAMLqsYodaDrFVx8YjcUa+
	 GyhkpeQFSUsNM36zcOWnru48Hv/4CJg2IuPjxsrFeaqD05lNOheVY2kLNVO1GmJZpJ
	 zLFv8UU9akz900DwUXmDXC/NNpPUyZ7U1UlgOYoZNY1k9rUD5nPgpxcE9z/He7r7OR
	 Py+5mmEFO1CMQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tjblp2Wsbz4wc8;
	Mon, 26 Feb 2024 08:01:58 +1100 (AEDT)
Date: Mon, 26 Feb 2024 08:01:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the hwmon-fixes tree
Message-ID: <20240226080157.4d9ff7dc@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1M3HPlyYmv5RsLMcSJ8Ls=9";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/1M3HPlyYmv5RsLMcSJ8Ls=9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  cf5ad17ee6a4 ("hwmon: (nct6775) Fix access to temperature configuration r=
egisters")

This is commit

  d56e460e19ea ("hwmon: (nct6775) Fix access to temperature configuration r=
egisters")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/1M3HPlyYmv5RsLMcSJ8Ls=9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXbqsUACgkQAVBC80lX
0Gw7qwf+K6ROIOzzFa6DoeH0zLDvmAa0Sr0iG3Euh9fmMLI4qY2VJnBDfXjm0S16
qGu5bGqBORd75tq5E9h/PbcRbii5FpLFUYefR1zjyomNNWATFH0wmTdYvuuVmSiT
7vdfoV0zb/yrPvyxMLVFYiIIvfrMiw8Jj3es/0bREJUxeQvJjRE36lQRNW0stU09
gyo0Qfv6RyGipLWLs+inJX0lPzWSO7UmnaBOOX2RmEcQhhfHiA0HIl/v2/YQ9Y0V
6TKMm72aGevBKVoGF522OhHh8PpcJj3ZW9E5uIcLXYRXkNnCuBdVJuvpRK8pzJp7
83YMxNKoDleKIiurjXyWBRkrkwBj9g==
=ZSiA
-----END PGP SIGNATURE-----

--Sig_/1M3HPlyYmv5RsLMcSJ8Ls=9--

