Return-Path: <linux-kernel+bounces-41975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0989283FA31
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 22:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA38F282D55
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311983C47E;
	Sun, 28 Jan 2024 21:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bKCMLFQ2"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D651E3C082;
	Sun, 28 Jan 2024 21:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706478791; cv=none; b=JQcjqhbUKyeKPZVL4yJTjrLJr4LkZ+YvGMSqmR2I1nbyRerHk1B9wGSUuZs+I0X1HCovTcJJ/TLwBMXtxvG8h4wVk57FJQD+fowpWGYvoSbqL8RySoX6UsXu8OR28Z0NQqbXDVSqLS3DykT30AZT5kstrWlWpMAblc8vovMlMrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706478791; c=relaxed/simple;
	bh=yaUWbY1oUaSRGJ3fokVxSpbJK4jJy/AGjLwGcK+D9JE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kRxu37YruKwz4V1z1wqz5tWZwZtB1JhwPwas4czjNZr5BTjNbjajMpFMtu+LmylTXt+9efoRppXP9cCvMs85+tHPWmcA631Ve/ng1P+znKYdW9HOmOuXx9W2Qoezew8criELZIaP6kniCArn3O//AY5ZlhqlLXjeMmBtC5VKHPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=bKCMLFQ2; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706478784;
	bh=c0dCsj8bvKSas1/xBqPrrvD7tLg1R9eK8Z2xbNVGXmY=;
	h=Date:From:To:Cc:Subject:From;
	b=bKCMLFQ2wwZO7EEXdfnOgznq5H0hjvBju8/mjZ5ie8yhb0Hw/EzgEGZYvapi/klas
	 7NhArawQNfwP/PKnxGumL7l4aLtIp4eIdTlsE5IAJGXh7GOsDRKro3COzRMj79XVpG
	 X0GbtXxijdPux6HsmvuQMvvP+AAp7iHKSGv6EUG5Y+eykgY07Z52J6gpzBMMkaWo8V
	 wN5s2q79CtoaGkxFgaxIlJycoc2N/LpcA6ORLhy9jiGZFA/tSdngrmx9jEULTf8g5c
	 amO0L97Ld+zc+7N6UcRUrqXTsLB/6pzZV/V0b+S157oyFa6BgIYi7S1VwGuKSU4XPY
	 nn6eUTXLgLRgg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TNQCg22t8z4wc6;
	Mon, 29 Jan 2024 08:53:03 +1100 (AEDT)
Date: Mon, 29 Jan 2024 08:53:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: "Hu.Yadi" <hu.yadi@h3c.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Muhammad Usama Anjum
 <usama.anjum@collabora.com>, Shuah Khan <skhan@linuxfoundation.org>
Subject: linux-next: manual merge of the kselftest-fixes tree with the
 mm-hotfixes tree
Message-ID: <20240129085301.5458880a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BhzWz.dN6KBzdwan9nN4ZKz";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/BhzWz.dN6KBzdwan9nN4ZKz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kselftest-fixes tree got a conflict in:

  tools/testing/selftests/core/close_range_test.c

between commit:

  27a593e3f13a ("selftests: core: include linux/close_range.h for CLOSE_RAN=
GE_* macros")

from the mm-hotfixes-unstable branch of the mm-hotfixes tree and commit:

  b5a8a6de69bc ("selftests/core: Fix build issue with CLOSE_RANGE_UNSHARE")

from the kselftest-fixes tree.

I fixed it up (basically the same patch, I used the former which kept
the blank line) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/BhzWz.dN6KBzdwan9nN4ZKz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW2zL0ACgkQAVBC80lX
0Gx1Qwf/dH0jDQMJIhLy2JVgJShYzAqq/jEkeDOtAXGJ8Q49S04vU8xk5/+L8rMf
TgWtWTiXIgsezYftqYnTbOz6nczn51mKS15B5b7xzY2HSIeroMEonY+K9sJ3C8PO
F0MRlSbw1t4jO/E4XhKX6ZmkOAW4fzvJWJTzL4QjowbA8gHYI3kVV4yxxWmfRPGm
Ihq6K3wXIt73YFfr7gudz93o2VVIUc7dvlT7zBQ4so7Gabn/J94FUObGleULUtKS
HwK/VwpiTm8qA9kOvVh0IJhtX4lP/9DQcC6qV5Lo6ExglRYOKueXvDxFTH4kBkUv
zxZgt0k9ZQodTRXIVpLgzHXJP1oIGg==
=IBZo
-----END PGP SIGNATURE-----

--Sig_/BhzWz.dN6KBzdwan9nN4ZKz--

