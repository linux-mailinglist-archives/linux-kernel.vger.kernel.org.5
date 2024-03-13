Return-Path: <linux-kernel+bounces-101089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A042B87A22B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 05:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7661F22949
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 04:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFF610A35;
	Wed, 13 Mar 2024 04:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="S2FuT2f/"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE6B10A11;
	Wed, 13 Mar 2024 04:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710302699; cv=none; b=MT9GYh/n6UYS2cJgHpBdT5xjYb1/V1UlbBaplV1mB75u4txDo9l4o2JwJN+zs4njBvEIO0myi9BHPm1BnJEexin7TR1tSwDwgPPm06nU3PNJCIhKOAgxPUgk9n98QRe0SZ86lm8xiNYREw8r74qtxRQxfJ55ZKCVifAE/+S4B5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710302699; c=relaxed/simple;
	bh=/WJYCvSl4zGPU2LTe7VS0R60QigdtBbPKA8u/qr33a0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=De42uAdQClW98+s7lxthLq/tzcxZXPWMI7j6WZH7w+5aCWB8+Nr7YCcbmuPrMgPYh8NVzaYf4nXCMtIX46GFfOYJoy6236CbvslpjPPokYXSxWSWCW69ufz8LFZbR2YJwYa04y0zcn9WPmNY0f0572nl8LJNV3Q9R8fFaUttevA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=S2FuT2f/; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710302695;
	bh=6ZxFiIwo8hXiUWt7ElZxy2sL3nLuzyz/SZzba1kcYhs=;
	h=Date:From:To:Cc:Subject:From;
	b=S2FuT2f/yaaJilVZUYZVjrZqhMjCBDJIe09x2WrbzsZkzfJtgldZKtOItltG50sqr
	 qrKJX0tut08km7s99KQYYtz/X39y2DCKJUP3J1CpLfv5eSGtBwkvxlF1sp2IFMnTKW
	 0mzfVzrp6LqKWPhjxtak7FZUxid9UYTqWpsDga2h6pOJanu48n3ROSsi1kco/A32rQ
	 1mGjMbMSH5L4DCy1jyuj6IgrAXxeEEcbdrXzCd8vipMkpw72za8r5wV0pAKlhJTezm
	 nT2TNvnJ2zd7LmEZRAGEEOk6xPRxBmr4ZjZjRmeKS6bwYGB/Fxpv8nrJvFdXXWlIAT
	 ecGqtJfb0ohzQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TvcNR464hz4wx5;
	Wed, 13 Mar 2024 15:04:55 +1100 (AEDT)
Date: Wed, 13 Mar 2024 15:04:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of Linus' tree
Message-ID: <20240313150453.7a652353@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CkEzKZ63PX==tIOsOsOM40P";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/CkEzKZ63PX==tIOsOsOM40P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging Linus' tree, today's linux-next build (htmldocs)
produced this warning:

block/blk-settings.c:281: warning: expecting prototype for queue_limits_com=
mit_set(). Prototype was for queue_limits_set() instead

Introduced by commit

  bff4b74625fe ("Revert "dm: use queue_limits_set"")

--=20
Cheers,
Stephen Rothwell

--Sig_/CkEzKZ63PX==tIOsOsOM40P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXxJeUACgkQAVBC80lX
0GwqFQf8DUN43ML9FPh0KOxNi/VodFNPAwaoyv1QZ2QG/ZAQpltiXOawWX23kYGJ
Ew2nSkbXLV6U/s02jCPTICMwFxlpKNMSKIjy99nxNu4Nv+EY5MIdLvVEYblPO4hu
HFzLc1tYVrVmiIBEZzqrYTLhSILcFOyh9hkpWibHdVYaVE/HfpPVBfAl275ZTnQ0
1diLxdooH0lU4uxZIrK7DwBYY2MiIzzXV4AaYolVTjrPrbp7dgIZaDJAGniOvJVd
B1qoRgrU8eo5Wu5WmqpNFJqdAYLUcNrIr1pzgWyZpsSancAXwmHJYQIxIP/09Hll
W6r/NUnWaEXMJhx0fBgtkhVGyGjATA==
=2Dub
-----END PGP SIGNATURE-----

--Sig_/CkEzKZ63PX==tIOsOsOM40P--

