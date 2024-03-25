Return-Path: <linux-kernel+bounces-116392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C63D8899F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1551C32CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4F213A253;
	Mon, 25 Mar 2024 05:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qd1pNuzJ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854C412BF05;
	Mon, 25 Mar 2024 02:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711332012; cv=none; b=dbzKs/B4l56gY1l7jftyTd8FpWABCdSnPgHWvILTEjDK1X2zEnQRcIDWp38H7d31bjaNtQYJ42DZSnmDbuBDkriEnVtDNdxbyoWorYEYWTWCQ2RBYjj3OJ+PDIUfXULRNrW2MAj5cEyoV1MTYsQM1HjK/OHMI3Y0+9qd7aNIB/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711332012; c=relaxed/simple;
	bh=KoIL+5USzKnAWU5XAMXkfHQPnA0FSgKj//g3Wd9d8fA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oprO/fu0Fm6WwEKZ/F8G5ARJvRXAFVeWIzJnQPUNMhZ1/ubmz5QC01qL5WNdQVsOvTg+LQkXAlH0aWI5Sp9vhaWGpt490RkmCuq2nW1w7dgizlprCD7D/7jCeCRNLZzYbWC1FyTR/fmm2VwyfN8zLKCxKCZ/xHAa0cO7X1qILuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=qd1pNuzJ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711332007;
	bh=GuEk/ADpGr81B7YHsE3SVEOslWEIQHwyWnsZdTkTtbA=;
	h=Date:From:To:Cc:Subject:From;
	b=qd1pNuzJMJXisLmOwRPjnyp6QgZCPLuQkpYc3H1fb+BmcGT3U4jzyeXoELnEvLZ2S
	 tidgKz5R1PXlDddZGCeiOKhtp1vAZLU7sBwRw8DGYtizDbiYHxSerly0dSPCMXTLrN
	 8Lrxn6Y4Y4hl6OkrCwxzywZdSSa09a9bhZH4eVdVL5OrS9TNnbpbFAlCIXhLXSMZLt
	 JXsnsMMPJSXQrnSaPj2/OHaN3zKSIFXat1PMayUFIL8wSS2Y2ZwdOszaHyYG5mPBJ2
	 3eezLbb5AVmJFAdT2QR5l73a7dj6zYhdqT81f3Ij0+3uF9rSnkUHnL3UTaFkTLktZ5
	 TajCaJDQlbU7A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V2x2v4vGPz4wZx;
	Mon, 25 Mar 2024 13:00:07 +1100 (AEDT)
Date: Mon, 25 Mar 2024 13:00:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Gao Xiang <xiang@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the erofs-fixes
 tree
Message-ID: <20240325130007.2ed83dbb@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZiH5JGq97BdVWOSy9YHMX7q";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ZiH5JGq97BdVWOSy9YHMX7q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  77720dfe2cf3 ("MAINTAINERS: erofs: add myself as reviewer")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/ZiH5JGq97BdVWOSy9YHMX7q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYA2qcACgkQAVBC80lX
0Gz5XQf9Fo+VmcG3TIQTNpdWMpIFJITn7llufYrHZqXNFuq6iL2+Kz8Fjg02hmdr
fnYrG0Trjt2MTJFgyvT0EsAs7oqyiNYoTKms89tDcpNshzQCaLsjBG/4Dk0nHT1Z
MfNJjyXVWSOyh0+7IgBj4sLPUtsL4mR8LaAbngl9ZrDJCFkKSHgivRjODsaZQLiU
b+7iJ66zhfhgFJMC2HLcWjjiKVF/NSylhSlB42Paj+Rsypo9gQtaO43Q61ed/MD7
3sAADYW9T/mOsHOivYED8oKlxqUzE9flufYej+/tBRz7lyarZYhx893JN8GASdhi
1iGfTGD1iooSIOsRpcGqNR18eVifaA==
=ejQb
-----END PGP SIGNATURE-----

--Sig_/ZiH5JGq97BdVWOSy9YHMX7q--

