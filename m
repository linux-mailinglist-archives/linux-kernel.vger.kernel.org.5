Return-Path: <linux-kernel+bounces-70591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F93859989
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4AC8281837
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE53E73197;
	Sun, 18 Feb 2024 21:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JMLE6tbd"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D168C1A;
	Sun, 18 Feb 2024 21:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708291678; cv=none; b=An/ql5W20wqtO7ael4MolDQwPpe1P/mVnr+aJrQqcTy4mQUWYoHg2qFECKBL/SYr5Ui2WeffZ2VbrUDMMejroei4K7zLGPlugcA+ijPMQgI8vIoqTbvDYr/tFTgf6otphMSIQlWlqSttKEDSPHbIHAGJzx6X/yIAcZfWCehAeA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708291678; c=relaxed/simple;
	bh=OPHzCChXykMA73GkRePvk0d0AJhN+uHaO7FqyWOmV+w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tTZuMBxdpEKVnVwmBb9VW0sfTpyZzc9Zl9oGDxGRVsm7FzPu/LuxL3RqGclBQ7UyNn0TOyMcdqAP+qGDh+53BgI97VyUsDh+BMn8uRwhYLTTCfHXI/KGv5OFbpPvHDBBCxf8fX1kBtfd5OA2ek/jaU5ttFxRdtwDUbN4NEIw320=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=JMLE6tbd; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708291673;
	bh=EgVI5G4bRL1PptC+CCzYjyD83vqd6m2SyVn+vr/2vbM=;
	h=Date:From:To:Cc:Subject:From;
	b=JMLE6tbdDwQHSZXjSqvhLFkr8um0HfxKBuHHPU4TqW5nShajKT/6e7WnY40fAqZg5
	 nAhJQzcI7QJ8UBsSE6ula2RvtOcypq+UnwP02TRHFEe7J4+8Sa0JYmAobWW1ShwHsP
	 L7ttrlG1DPoqnDwwN72BverIQMWS2GN7OYui/nEtEhN/UZBMtYuy4rgZkH7khXtLM8
	 pV5vf0VjQUg3cW5r6hAumThnnJQPfLJSuxiv+rsHYEyW4BnD5ovnFuqhZJ/IMIkQbd
	 VoxQdEX+0xUVPpvINK9xwFN92boTAPpPexDAOxDFb6SxIZQXMi7PSnu6We6mhqBfFJ
	 rehyXQAGRQWeA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TdJfw0dNYz4wbr;
	Mon, 19 Feb 2024 08:27:52 +1100 (AEDT)
Date: Mon, 19 Feb 2024 08:27:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Steven Rostedt
 (Google)" <rostedt@goodmis.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the mm-monmm-unstable branch of the
 mm tree
Message-ID: <20240219082751.4b6e3686@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W0Mb+/T7Ea8Q_pceunI0.PL";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/W0Mb+/T7Ea8Q_pceunI0.PL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in Linus Torvalds' tree as a different commit
(but the same patch):

  f3c4e7699cf4 ("seq_buf: fix kernel documentation")

This is commit

  6efe4d187969 ("seq_buf: Fix kernel documentation")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/W0Mb+/T7Ea8Q_pceunI0.PL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXSdlcACgkQAVBC80lX
0Gx6FQgAhXDuz/SgbZpLPrl9ZRgFJSPUNaY2ALrXGMSD1WpPe0d7bLlyxqTAO6wy
g8fMPhrjRYUAI/rXhOpWzgwR2IqkkxLpDMrvtW35qAqRVR3SiJI3fTG6jcgTEiz6
NfuZOCl4BLG8dp0T9igZSsu82M/f2L6frl9DEIWZ74rDvUe+c/oS+0b2yaX95NrQ
njdFdLcLHoJGL5HYu2ACkU0ooGTjTvcv3wmRgVo7dhgz/ZorBOOVrMqyte2ax2mI
Jm3FyrpqO+2nUY7QQGGYCu3bXnYujtVs+wpXdjfBVNt0aof05JQcqLfGQ2yDSdvT
yla6WW3qogWg3AEcfTSrlJcog0Dk8g==
=ByhA
-----END PGP SIGNATURE-----

--Sig_/W0Mb+/T7Ea8Q_pceunI0.PL--

