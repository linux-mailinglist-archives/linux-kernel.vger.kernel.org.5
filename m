Return-Path: <linux-kernel+bounces-115266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAFA889BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B161F31DB2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB9114BF9F;
	Mon, 25 Mar 2024 02:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="V3UyIHZ5"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB16289D93;
	Mon, 25 Mar 2024 01:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711328494; cv=none; b=RVsAh5V54PyDopuag5MSspzXhIiD92Ej4c4If/cyyxkiZGNy6siSdLo1FmzT2jnq/FqX8fF+nVL8/O8OZkhdprHi1rt1k9qSrpaQeHgG9eD3Jc/3hMQLj2lO5TNTMjYxp/8aUSgcaMl8PqzImOx1tSWxPjaHQ4r/+vzY5YGhA44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711328494; c=relaxed/simple;
	bh=VlSJEx5t9GxY0aVPD+CBeIIGljVxg2yfL41TbPjxqlo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bVVA2xeZMKa9jYkxwW5msmL2JDOiiWdVJ6fAlCG4npD0HlYmNQqS2Hh8VOcwcwTZ5osyvRDF9NbEST/OLuaN8xNjXnIscsRtesYD+3ProlyNWZ2yiU8vg8oTyKPAymhTp7UmXEERe8hDgHzildHNG5qyVU+j1QZxHx/JUpRqk4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=V3UyIHZ5; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711328485;
	bh=36t3TJQi0WAbVuv7GHah7XXfDbnBWnUZhh6uAg/TplY=;
	h=Date:From:To:Cc:Subject:From;
	b=V3UyIHZ56rJzudsM8dBQfhc2ppQrD0VV1AGiTU/FezkGWkZ97vbd6JdikGijeutWr
	 TYAelUAVn8/Cknena8d4fFNlLfQhT1A8AkH/LEM3QP1bxy1xQkWfRHbnb/FB9XnqIG
	 Z1idNfScEdrlcvA2Jr7SSFd/4xLAy0jO+bQRyGKuMfJrAqVbg/OAdAggGBdChCY7wp
	 10co6jfkeaiy9DH9CzkQnuThS79Zs+JkNJt68MLjj+EfW6wTyq01wvAgMGipwsVRLX
	 SgGR5BkbnqQNRIbUiGkazh+YuQhkLUbIVTU1gJJNLs/Ni2xoQyMpjrTgTZ0L1ei9zk
	 RRyD4Ns5htNAA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V2vl90WqLz4wcq;
	Mon, 25 Mar 2024 12:01:24 +1100 (AEDT)
Date: Mon, 25 Mar 2024 12:01:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the random tree
Message-ID: <20240325120122.4452a813@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/e0VO/kiLvbK1p806TOyTqWe";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/e0VO/kiLvbK1p806TOyTqWe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the random tree, today's linux-next build (i386 defconfig)
failed like this:

In file included from arch/x86/kernel/cpu/rdrand.c:12:
arch/x86/include/asm/archrandom.h: In function 'rdrand_long':
arch/x86/include/asm/archrandom.h:25:9: error: implicit declaration of func=
tion 'WARN_ON' [-Werror=3Dimplicit-function-declaration]
   25 |         WARN_ON(!ok);
      |         ^~~~~~~

Caused by commit

  c53d3006e1ed ("x86/archrandom: WARN if RDRAND fails and don't retry")

I have used the random tree from next-20240322 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/e0VO/kiLvbK1p806TOyTqWe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYAzOIACgkQAVBC80lX
0Gypvgf/aHaKVttBcHWxvkEBkKFZIEGvFgKyPrrI2h9UOQjlO62PwiLbRGZg3m7y
NT8uiGDR532L/4Nhb1v0qKn1poO5LF67RX4OIfp2cpVF1H6a5TKVrkkjh9jg7dWm
3+w5ki/EUKXR43A6i89yaLwDjyBoI4pEm3v0Iz5MmM8Xy27WkQZ+65KpH3gNbfC3
YR8EDj9BrPE9w4YVfpe4Pc0zWzJfoH5OP0rUgAE42uD2lAuVKIIDVV/UusslkyBd
J08LfqzHg9oWNkNijaz0tVO8fHBIv5PR1gKqgpdxmvnmaSOLbTy1+vL/eW2RPCsd
gFphaLb78kqEr326HOFXovZF2hBlxQ==
=eupU
-----END PGP SIGNATURE-----

--Sig_/e0VO/kiLvbK1p806TOyTqWe--

