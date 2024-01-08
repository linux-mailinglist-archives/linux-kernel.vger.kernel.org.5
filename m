Return-Path: <linux-kernel+bounces-19054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E8C826750
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 03:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98BF91C2163F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 02:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C2A17E9;
	Mon,  8 Jan 2024 02:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gLrPwg2O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93896EDE;
	Mon,  8 Jan 2024 02:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1704682725;
	bh=JW8/JcRwBpEWLXDnPFIBPw458AOy8bltOmNiNM9TzZs=;
	h=Date:From:To:Cc:Subject:From;
	b=gLrPwg2Ouruqg1xFWNoUTw/xIUhvULAPHH/lAVzBT5Go6nVly+SxFKgti/azFhTlY
	 XSpTig/+dP2cS397aVitKU3MlkP+5lZj9OT3COBzD74dgXPdsq06xik86mvfSLUK4z
	 I+Hq7xSNmDNvq4q01iEIbVeETzu8v/Ol0MIkaGvTom5xfx2Lm9LoMpAhEDwzjkED0i
	 7J19ZpQmnCWhVjWLAkvWKUEIZ5qv5YwYPxgVz2PmUjHIypPMiCHOKYUuHtI/KXWXeV
	 foAJpddmSOLbAzz1vio2aS+mOmcdlITXbAE6JHr8lo3s3W1Of2XRj6GU8UP4tBtzPy
	 fh4PQxxg/BK4A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4T7f03625Fz4wc6;
	Mon,  8 Jan 2024 13:58:43 +1100 (AEDT)
Date: Mon, 8 Jan 2024 13:58:42 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>, Helge Deller
 <deller@gmx.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the char-misc tree
Message-ID: <20240108135842.34543bb6@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EXBMrwQJoC8pQDL=7JNggJb";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/EXBMrwQJoC8pQDL=7JNggJb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the fbdev tree as a different commit
(but the same patch):

  110684d58bdb ("vgacon: drop IA64 reference in VGA_CONSOLE dependency list=
")

This is commit

  7f55464ec616 ("vgacon: drop IA64 reference in VGA_CONSOLE dependency list=
")

in the fbdev tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/EXBMrwQJoC8pQDL=7JNggJb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWbZOIACgkQAVBC80lX
0Gz9CQf/U1i0x9o41jGePmkyDqYsYi8hoJK6tO5M9XlZq9RkflQRgmAgHGM01DmZ
LOXRTe/bCrOevSXjSWnnJpdg7wCBOKO1SFBr0+d2Kkat/WTks/sDQqLni3Df3eRS
q0XLw1C1abRoi3JNmM3LFk0RVfiA0sA34XNUTz1O0pfIffbcxurwlz3rLcP0bCO5
VxjggRECVJTqXnxK4k2V7/ROc07/Kfc+I1K8+Etc8mU3ulrWrisfkeySOXfuV3/V
Kk9yVpvmAoxKP7BKWREu6slzs8MTCxGPBGzH0+/SQtai9F9sT9OPWWVgu6ZUiggB
ThGyLFtsxa7OPg0mRPbW+qeFTVgywA==
=nvKq
-----END PGP SIGNATURE-----

--Sig_/EXBMrwQJoC8pQDL=7JNggJb--

