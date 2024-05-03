Return-Path: <linux-kernel+bounces-167091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 181AD8BA46D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4911D1C22318
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E0623D0;
	Fri,  3 May 2024 00:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nDrNxFp4"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5081367;
	Fri,  3 May 2024 00:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714695333; cv=none; b=Oy61ja2MkDsvbVxfoyxlYfmG2si8meyyuT+mMBqeFlAokfrluTbYr4T1hzIS4TezMvaAkl8uhaZIf5AQVU8NKud97m59A/erXtrVMY5jrM/jxhIxIarhSQ2lgx/X4vXMEXOUPrxajepvNuxsr3T5Nor5hhsmIzihugOC8KXhVDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714695333; c=relaxed/simple;
	bh=KRqEuLhe9Mp6oqN6dJcmZJ4kP9k6NYz/Oyagiqureno=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pA7+aQtjs85dVIGMpUx2qZ8VMIU5+oBsFK6qXZUMxVkDe2hHamVtFGUjieuPnSLyYNdjNN+vxzTpILWoIshhH1iDrek3w/vU93c4EJzQGPdZQ/Rd8GZKGKlNXQB1vHRSPOZYOdMEP0gwXg2r9I5NyS4XpEjNd0VQ/9NFCVDGHns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=nDrNxFp4; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714695321;
	bh=XXNXCz92StQTTDcwkOvbi4Kd+yJm2a1qRh/FbO+coh4=;
	h=Date:From:To:Cc:Subject:From;
	b=nDrNxFp41TrIUXJ1d4g6eF/p8wwBJmwdaxlw/pTM+2ImOv9ToOurimVYmSe13woxb
	 bOCZSZ+rnQ4XWULM/6gYjs/PHmCKFRoHhvbqidbz78YlrH6tUN7g7dHA7xvk0wdd7v
	 KFZM9ZAshW1sCbgl7pzAd7DZvLYsv4kkAOqxVqPg6xfQ5rCgk+TLNAil+YnSQ5TMQ5
	 LUdtPourCbgc51rKNRCXsk7FxUSCRPDyYIZtq1aiS1Iz0qogEObr6c9fTD8VVIses1
	 8bJydKO7ECtAIogGHUkZ1D8R0XXEcGZB6UhLFRxNQNHy6EElzT+SNiDPPM0Yu+3nSo
	 r7Z19McJnxJvA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VVrt12nBLz4wxs;
	Fri,  3 May 2024 10:15:19 +1000 (AEST)
Date: Fri, 3 May 2024 10:15:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Russell King <linux@armlinux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the arm tree
Message-ID: <20240503101516.09f01e44@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rVvVcEQbi8=I1eAG684Lqny";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/rVvVcEQbi8=I1eAG684Lqny
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the arm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/clk/clkdev.c: In function 'vclkdev_alloc':
drivers/clk/clkdev.c:195:16: error: assignment to '__va_list_tag (*)[1]' fr=
om incompatible pointer type '__va_list_tag **' [-Werror=3Dincompatible-poi=
nter-types]
  195 |         fmt.va =3D &ap;
      |                ^
cc1: all warnings being treated as errors

Caused by commit

  5d998425e37b ("clkdev: report over-sized strings when creating clkdev ent=
ries")

I have used the arm tree from next-20240502 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/rVvVcEQbi8=I1eAG684Lqny
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmY0LJQACgkQAVBC80lX
0Gwnawf9H7rVka/Raqu0ydh87JFWjVqLLD3+BQJuz14KZOggWNlJnih/60cVVs5u
/iNESnrnqr3qOPzLd4OtQz2pZNS7bHLPJjexQxsWS/8yfRHjeow5k5TXteppczmk
zIhTfxNVT5VfgaWi9na40f6kom+veJjjTNag9VXDIM0Ogzxej9++A5soVmBkGPhd
kSadMCBY6uiVNvNfwkgRD/4aY0g7JWfZ0FRC+RxIf/3QAYF6kwYmTk1Ry5kqpgxW
0SUnooro1FC/x+6KQm4JoF1kp4zs+Rb9H6Wh3rgmpSpk5ZrBc4takDlflErRbhz9
mhVsWRrKcreq06Jnc5lDngplARLm7g==
=WlQr
-----END PGP SIGNATURE-----

--Sig_/rVvVcEQbi8=I1eAG684Lqny--

