Return-Path: <linux-kernel+bounces-164797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F08F78B8308
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60B01F23B36
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512091C0DEB;
	Tue, 30 Apr 2024 23:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aBiCtB1j"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B75817BB15;
	Tue, 30 Apr 2024 23:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714519997; cv=none; b=JmIx7RMkSGZUUcPN4vqreqwNfqdr3GSZ+o0lOJr5VM+dK0VeSD2jlIaDSAntVoYMzH8GWrDfbJRhJ69e1kGE4HxBLTfxVTQ8N1l/D40dDctFadmXltIbyu+InB7qSvJjQC1VJypidg6tDx+wQZROSzMw6vCqiXE0BVQuMw12qsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714519997; c=relaxed/simple;
	bh=Btd6m2X/IOOhsg+4xG8XO7K6+MiU+oVhig8HhZZNSdc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gQ8Jlt0vKnYtqxpAVHt7KtOG4NH10nZSvE25sWQsO3WsOmEISATivkk1JkTWBissfdQCsfZrLRkDwgl41Gb3cHeDAxyvpcztxzxxQXEUVo3975UR8btEn8BEfnI88cE1EEk1YqfobJm1br76sEMEJDyJcpO48IqFqKMEoXxWj2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=aBiCtB1j; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714519993;
	bh=zs8OdqMb7LRVVufKsL2ihfVTBimC3bFBByfhWeu7wFI=;
	h=Date:From:To:Cc:Subject:From;
	b=aBiCtB1j0OaKoqdGsKghnPLCin22HXASBeylngJNHLnvd9/KZR2XQMLrwlVUSVceG
	 ImPfKv5IpbzWv4mZqoQTZsRHMfRLHUssTHHUdg0GrKy5Jv3ymzz+Et5M98Z7xhMyX1
	 UXQa1i73fjusZNl24XwmeFfdAe0JBvx1hwN1JGV2gaNfk20GfJZfol4dm+Z4e3s1Ku
	 MpuXeIvWxLmIOlCUh6DW8Xw/wqvavCkaa7Sxzva77lFsZUaN1AX8hiwHLIhu5dpLNL
	 D+w0eBKKRsmAd4HDo25Z7q8no9NsW6QAuBHIUQ4SNkk+SlaE+DHsopXCrXomJ6Cpll
	 COKFjSo6VFRZQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VTc2K4Kjpz4x0v;
	Wed,  1 May 2024 09:33:13 +1000 (AEST)
Date: Wed, 1 May 2024 09:33:12 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Joel Stanley <joel@jms.id.au>, Olof Johansson <olof@lixom.net>, Arnd
 Bergmann <arnd@arndb.de>
Cc: ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the aspeed tree
Message-ID: <20240501093312.4aee323c@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7HG7uPQRqJSrGkK48PvW_27";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/7HG7uPQRqJSrGkK48PvW_27
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the arm-soc tree as a different commit
(but the same patch):

  2fa83625243b ("ARM: dts: aspeed: Add vendor prefixes to lm25066 compat st=
rings")

This is commit

  5e0705a74f80 ("ARM: dts: aspeed: Add vendor prefixes to lm25066 compat st=
rings")

in the arm-soc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/7HG7uPQRqJSrGkK48PvW_27
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYxf7kACgkQAVBC80lX
0GyMQAgAnntARnriEUm5HXUPfmhXdkkhZBvtQ/9l8kXX2T8R+Lssq4dNxJri3Rk5
fRb+rZVyM9bzEX0xCnq0kZrONuc4EvDgzyPIbnWDepAA9OUER01R41jI9800udHy
fN8IjusGO902lQ0wDbQ6p6L9+Gsyzy6G2EFYcTrUG5CmnDKOCsrb9l2H4wD8cMZW
6hTN7zcb6zfL10GqVGLxZ4tQtELeRoDd7RRfOsk90RSzy9wf+vt5gjQgYMDNFxJ0
tUhsjFMJKzdAjLt42TrvTzWGXkC1A5P/xJxEVQTD2FiMqErL5JEAMvkKCgCcvHEm
/VbtX/N2pSnSxNlCwiYfaooPPm1PLg==
=O2Jt
-----END PGP SIGNATURE-----

--Sig_/7HG7uPQRqJSrGkK48PvW_27--

