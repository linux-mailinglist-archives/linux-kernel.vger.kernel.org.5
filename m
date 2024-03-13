Return-Path: <linux-kernel+bounces-102545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FB087B3B1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2861F2364D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7637A54BF4;
	Wed, 13 Mar 2024 21:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="p8odqVnK"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724A1524DF;
	Wed, 13 Mar 2024 21:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366213; cv=none; b=B4CHgji1FwFMceQinCfg7u9xoZtmfhgsPUi44WXJ9zVBIuCI2faqHAzBWhpxretmC+2mNyL2vw+hDpj3tyBb/ie8+Ww7JVh258MWDRt3QrrP6xZ4wLp4SFlWsG7wTe7lDYmkzWD93Gz++VGh4nBtLnpDI1hwUVl/yYj8YG8iILM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366213; c=relaxed/simple;
	bh=nSvmH5cY1qqsIMMuuVzSuN+abFWZP955PUNeLH+UWXU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=XjS5oc4DuqTxre9qPwcPu5msNY5NOwcY2bIprt1X5bI3t0CzSQwZldalWupwO7F1y2akvHtJwGoGO5qCkdlWkVPKAmMnimXY2BHYI1aqOZ1ThaED1UseAKl6+Ypa9t8CEG+bWTrax5WpHDAIPk6XJ4V1zKju/Cmkabzi0LJ0vQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=p8odqVnK; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710366209;
	bh=eiuPN6TUMFhOmRSYqaLZfazTB5/WJ2wVrB5rIGesWeE=;
	h=Date:From:To:Cc:Subject:From;
	b=p8odqVnKMbuPqOC00NAJXTwu2ge1cYJWvcoM9ntFXkOrrBx6uF6oxg05Ht0EY+N0S
	 NHnCMtVmF7kV9yaht4XjsuKFr2xcSTMBtILhoV1vOqYW8jlqWsKwV215wYTVXZYbme
	 C62aScOXSTyKfb4GR4Mal/QLUF4FX3PYS9/X6Y0RkntqRcOCh9U91ZUeyRtNEi8oSu
	 hqODcVi6UIS12g7elfPoC5h5NvIBXR9xs2VPusHR/8Jm3B5PJ+ndx0qyRFPcxTBmK6
	 ER5CfDeqo4MxqMoVaIW5ZuV+RqUYPkl7SdNvmBG/FMM9JyfLAllb+rbRMA0ObzdFmG
	 vbGOFOSTds49g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tw3ss5vQQz4wcR;
	Thu, 14 Mar 2024 08:43:29 +1100 (AEDT)
Date: Thu, 14 Mar 2024 08:43:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the opp tree
Message-ID: <20240314084329.6c9c59dd@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Om94KyMa7Y1dwInHsWH3gTs";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Om94KyMa7Y1dwInHsWH3gTs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  0b5466a8bc71 ("OPP: Extend dev_pm_opp_data with turbo support")
  3678779d8b64 ("OPP: debugfs: Fix warning with W=3D1 builds")
  6c9a1a56d316 ("OPP: debugfs: Fix warning around icc_get_name()")
  ace4b31b297d ("cpufreq: Move dev_pm_opp_{init|free}_cpufreq_table() to pm=
_opp.h")
  bde3127675ff ("dt-bindings: opp: drop maxItems from inner items")

--=20
Cheers,
Stephen Rothwell

--Sig_/Om94KyMa7Y1dwInHsWH3gTs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXyHgEACgkQAVBC80lX
0GyWEAf9G8973G/2QYMdKdSqXNYLAbJNkjxy8gOmEgKqS/4aIchKU1OIfJTjb7AI
wB1Wct+KK6uIvbktppbMbubU9xpqI7wv+srQOmol1MF21+uwhRs4Dov2Rhrep2H3
HNlPDvrAt7v9LE4QCbKm7DUptIdk07CSJtvxTrz2He4GPRNr3jxxmon3O2IKdSG6
nN11qdmQDNGCl0zH1J5OFkoDufT1nAfm9jCWZUTTCFTrvtzPpz6iuy22OSxPnm9y
J+QobZdCtTL0TlXZXE9GhG9Aeu6QDJ+4LwPQuLx3SF0AUEIjpCNWGz4XFUFEbHvV
5RvgXAiCFV7YSjLD9pWGdMYZa0DM2g==
=72GZ
-----END PGP SIGNATURE-----

--Sig_/Om94KyMa7Y1dwInHsWH3gTs--

