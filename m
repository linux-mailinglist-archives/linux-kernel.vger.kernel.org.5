Return-Path: <linux-kernel+bounces-70590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAFE859985
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23BEAB20C80
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899F773192;
	Sun, 18 Feb 2024 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eCK6XYva"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162D84B5C1;
	Sun, 18 Feb 2024 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708291455; cv=none; b=K5nw5naAs4s3UTCmJETG4WmEKRIjIotI6fMABey5ardK0yk68zRFZuq0+x3tUAHFd3GCVpIkmoZ+Gj7+c7T5Xp/bCuVNrGfD7ZZItgaLE8kxdxXyEBsmtrXHJR4i2g1yF/aiMjioad9ieqBwJGp0KZcnSTFwgfHH0oibAPOQT1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708291455; c=relaxed/simple;
	bh=dkuDWU2rpKLPBu6sUlNnSpN7G8NhmP+Q1s4Y0D9IX0c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Q1qug93lgbRRtBfJtfGZ+sNotCiZWmRuCU4khcPwMv8Tv3xomyO4ALy/02B6Ds7Y/S6m1SKmp0nwUnaPxMD5hdrASOq+aY5kqa7mAjCF8topgCQtlUqVAYmqwaJ5/SPV233kMl74+WMM8OTCsXktImGtKW45u8YV4fmr29QobQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=eCK6XYva; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708291449;
	bh=uuizwE4pCsH1kdWmspnjb47O4PazP7eoSsZzVwGnZ9Q=;
	h=Date:From:To:Cc:Subject:From;
	b=eCK6XYvaH/6CUywp2ZY6JwHHA9SfnGE7OLyFosfwAcl1wwoHJmcfXJZdN3jQB0lWW
	 BYPs5ewt6JGCvIQtVn89HitPyyk8nYB9+CGIBvyJ8Ro6CwOrBRv2AfHSAaj4cFG3oa
	 /uh/v8Sny0uwAOM00EOGcAk4k3g0vXBQNLSTRlR0tdDUhkw8mD+Et8G64doX1Ojb34
	 aM+i8dutwdvBBV2lQDzTFSwjAgGi3yyJusEr5aIxU80VfYA35Y64yUEUcdJ8NHP+O3
	 BwqXnwZRy19iP7vtpNlTffLjgRAT1WlxooG2QwpbE5oaftpPzLa1jvAwMMPq/pkEwO
	 YwlNpfzqWPS8A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TdJZd0vpSz4wcB;
	Mon, 19 Feb 2024 08:24:09 +1100 (AEDT)
Date: Mon, 19 Feb 2024 08:23:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the i2c-host-fixes tree
Message-ID: <20240219082344.267d1a2a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7rbdQ1+zIH9L6CcET=viwmH";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/7rbdQ1+zIH9L6CcET=viwmH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  32e9b680de4b ("i2c: i2c-qcom-geni: Correct I2C TRE sequence")
  3fab8a74c71a ("i2c: pasemi: split driver into two separate modules")
  eb9f7f654f25 ("i2c: i801: Fix block process call transactions")

--=20
Cheers,
Stephen Rothwell

--Sig_/7rbdQ1+zIH9L6CcET=viwmH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXSdWAACgkQAVBC80lX
0GzvKAf/anjiRx9S+EyVoBvlLwdgbyl6v2qNx3YLdJW/aAm4yZtjFoQX7W/LwFGS
acA6NaCDggp9EoN49+J5YYejnEIH7RyAzveoylDJX/5LCLoorEWf1GSp09bY33uB
KLQ6wHuhtEI8cYtRl5EEbqeNf4D7KdeE08wt1rUM4tEMtVUZXbaXJJaPjuchZht0
J+MJevlCS9hX7Lqhx5hFqiVMyM33cE6rtHG1YXyyL/do6Npcyj3VqWqYiY9K5giM
oOx89Q7RmpZt2eoz8ZlRbRfF5DxID8JnITctvOMNvhi1QJ7kmL43nHpgQwgwLByV
KeS0eWniXs+eeRIJIoyoDmlZ9lumyg==
=sYFA
-----END PGP SIGNATURE-----

--Sig_/7rbdQ1+zIH9L6CcET=viwmH--

