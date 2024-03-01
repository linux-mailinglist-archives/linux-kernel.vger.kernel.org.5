Return-Path: <linux-kernel+bounces-87884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E106B86DA70
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD161F2635A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DE747F48;
	Fri,  1 Mar 2024 03:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tE3jdTU9"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DA631A85;
	Fri,  1 Mar 2024 03:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709265359; cv=none; b=W6Gs2iwP7uChJu+raALyLIycm2CpqV30dT8j2BuvrULi+BQ0kYHuMR3hG4yEze9PpeUWa7Tbz7y7VlnbiZn7SyupvPGLkkwgsRJbvC+CgZi105v4lVX9VlfRTaHrHDXN1xVp9VQwQGBWiNOVTQCldTvz4MCMPPVDZmsEqiYiAMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709265359; c=relaxed/simple;
	bh=817u5vcRCPvKljJ30d0q5tE8qVsoGkrccpKmQxZO52Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=JZZoIlGD5g3Sqv6XlLk5Al06dmAVpjZCcKxSZlyghI8ENYcnPAii6zY03l1IKEEUVNeaTdyW2DhnBzoTpIkinIJWSW3G09/BCGWzLBVUQXnqlMmtAul4XU2WwbGDoGF4GQAi/z92tDFZrwUTsJPDjW/SiZp8MR2CiWArxdidNWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=tE3jdTU9; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709265346;
	bh=9GW/2HMB9Nwp3uqNROkDGmo17RGaxVTXCh6mwDo0jEE=;
	h=Date:From:To:Cc:Subject:From;
	b=tE3jdTU9B85o9vxRIKN/sgHcWLr5BwCPniZEbwMyOgtZUP6PkJtp7Bhv6CykMLTve
	 HhZ+2s+w6F3HRl6E+vKetSeGIhiISNi41Y03TnGrly0xdIXSNUlxTgTdGBwub/+aOi
	 ftcefqF8km5Md/B2BxfcaMq/Caws4OeIA52uUu2t4VZhvoF17tk0ZdkTGDdfvcgXpU
	 7OEQa5C7Pm+zr6j6KQ3A+PpabQNCd1kqeklbB0jPRq4bhCpp78iDH7EWljm917NgUm
	 0y2b9v6e4YgCCwM2MgY1Q8RMS42eK61tFN+GhNtjjeK/mz+Vra2cQdMOT9vH04ubNa
	 QOc7yGewl4kVw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TmDlQ2TBkz4wc5;
	Fri,  1 Mar 2024 14:55:46 +1100 (AEDT)
Date: Fri, 1 Mar 2024 14:55:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Alexandre Torgue
 <alexandre.torgue@st.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the v4l-dvb tree
Message-ID: <20240301145545.373a155e@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qqUwcz740+RI9i0rg5wI5EF";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/qqUwcz740+RI9i0rg5wI5EF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the stm32 tree as different commits
(but the same patches):

  87f7f576e3d8 ("media: arm64: dts: st: add video encoder support to stm32m=
p255")
  d96a6119e332 ("media: arm64: dts: st: add video decoder support to stm32m=
p255")

These are commits

  a7b9ab6c880d ("arm64: dts: st: add video encoder support to stm32mp255")
  ff7759269c60 ("arm64: dts: st: add video decoder support to stm32mp255")

in the stm32 tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/qqUwcz740+RI9i0rg5wI5EF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXhUcEACgkQAVBC80lX
0GxJwAf+Py24u+p8DOVISIlS0N8gBoH5Ok4HG5Iflm+VltSJEoDtdsHlOw0d/cm1
LkUNetwtAZcW4t28APnus8qn+a5s3WF2b29wq/cV02eGncqQK+v1puwvpP/MUbqe
KbbkQZRUMj0XtO5O18X7QPpR8Kx2w3ySX099hKkCbImbpKelF/kGg7DFFg3GAiWS
cAKDqJBilLcs0XA5kZgezqT7sIKyHImpYvWDgo5IsKZiex6qrr8dCmr56K3qNRCE
iGTpAHnjb6A5B7NGjuDXHEIo7/6VTkEKcapDf1OArKbPHzF5OCSyz/74O4dHtOq2
0IweKavkQoZDnMcHH/3xJpedh8/z1w==
=NpFP
-----END PGP SIGNATURE-----

--Sig_/qqUwcz740+RI9i0rg5wI5EF--

