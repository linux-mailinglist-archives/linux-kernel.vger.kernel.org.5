Return-Path: <linux-kernel+bounces-139807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F39508A07EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9A51F26935
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680B313CA86;
	Thu, 11 Apr 2024 05:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="p+5blW5v"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F037EADD;
	Thu, 11 Apr 2024 05:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712814760; cv=none; b=clt1FU46MaKmyYd63fRnTtCB6ApgOBC2zLA98eVLrJykGgMBYcsgw+Kf+1qZq+SXXp7xPrjHRTM1/cgkfZRngT51vEU6ERpxI1pHG8OTPmGl6oP8AHBJONnNl6bwFz+drX2Wb5nDDjzUbcFAHpG8ZHMWEhWHMlsA36L2baFXh6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712814760; c=relaxed/simple;
	bh=NvNgdGYOonm0Los8vSq4LfOVet9q0aeIcVzq3kp0lvk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=XM8FQlenF6E6+sQLuh6N+Q7ZFqsYlmWauPyIyLXiKuSrW3urVMAzZ8DDdOX2eOvbVmXjMQFRkNY9GIm3rAqXoVIHf+ZSMPONM/Rt1qHvpNTPLYZWyiCcjMGpGlIdQmzhETc9o2sxbzO6sMCCKWNcqalcnmtZQz4dc0/ScfB5ia4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=p+5blW5v; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712814756;
	bh=S0YP/RBaw3rgR/ZzuYNWu9UOkC99MxLinS0v3gPX+Ng=;
	h=Date:From:To:Cc:Subject:From;
	b=p+5blW5vm6R57g5p9wQNav7x/QKpxLcUSW/sCXNJbwQk83B4M3qItghguJ1BIsNjF
	 cQGedPvZbZBPsxIkSyQ6rpDn0UFN8m07MxmpREVGsGs7RbcG4DAzSHKKSeWtuFu2j2
	 rQLwS7+auoWAHmWDl6wWQxxyc7p9z+48rLMouHZ80SziRF3RAdqPFP5COksmbYFzgQ
	 33a7ObdT7FtVSKRsITKoXe0YBma24NtUpQU21s77VXB3RRKbdz2YoNk3uoSIgUOR8E
	 jyqJd2pQLe+eOZ3mAYexsonHKqsOM4/7X+jDmnlqSiNP50cHIIeAe9AmdJ2k4uLDI0
	 WNrX/7JXBXYgg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VFTPJ4mBRz4wqM;
	Thu, 11 Apr 2024 15:52:35 +1000 (AEST)
Date: Thu, 11 Apr 2024 15:52:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, Christian
 Brauner <brauner@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patch in the landlock tree
Message-ID: <20240411155235.16775ad6@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UO0FGarS0x0+go=kLGNkDEi";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/UO0FGarS0x0+go=kLGNkDEi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commit is also in the vfs-brauner tree as a different commit
(but the same patch):

  5b5c05340e67 ("fs: Return ENOTTY if FS_IOC_GETUUID or FS_IOC_GETFSSYSFSPA=
TH fail")

This is commit

  abe6acfa7d7b ("fs: Return ENOTTY directly if FS_IOC_GETUUID or FS_IOC_GET=
FSSYSFSPATH fail")

in the vfs-brauner tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/UO0FGarS0x0+go=kLGNkDEi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYXeqMACgkQAVBC80lX
0GwZxAf/XLtq+FS9Pzo/AGs+dPdpE7D1wC9nwwl3dwT4UWHEbcxJh2p/f1k4bEBh
TJkwrCOPMoQSl7LzJWaWcsc7feZ91CdpqiDBETKIXDth7uGHuS8dtBcb20uQRzb2
RSc5FgNdQNAfo/tqyuk1wsZDs48L2q2FV67grTM+Pjge6AJ3XvK9Rg2+ZuSaQnFy
Psqf7xyRgfmDC44I8tmse4PF6dNRbnPVv1KParWsqRhvoIxKJhM5iVZLapWmDGPI
CO/KrcpR+Qfnl8xlP2+k2ERZ+uYeA5awS9Yk7awhAg9/n6NB9GMLqOTqCtpWvgKm
fMYUNEvzOb375BMa7vPCuBl5g84TJQ==
=wMmC
-----END PGP SIGNATURE-----

--Sig_/UO0FGarS0x0+go=kLGNkDEi--

