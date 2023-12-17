Return-Path: <linux-kernel+bounces-2681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C86816073
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3094E2813B6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 16:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1C7481A2;
	Sun, 17 Dec 2023 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYY0iT8i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5AF481A4
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 16:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFE4C433C7;
	Sun, 17 Dec 2023 16:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702831734;
	bh=DTlxf5zq9oXJWNE4IDf/D/Nymp57XhjY1fvVE6X8GQs=;
	h=Date:From:To:Cc:Subject:From;
	b=sYY0iT8iQOa3m4GB8hC2GlkB8zKxOL7TlJSKHHKebxjvdFjaylWbG/pRXUNZL6tQe
	 wv8tNXsnFlrIeklRGgznCXdEbwARSXtOc4sj6gs16kjMXH1Pe6jBccMAYAlK1T4Fqy
	 55h+Olcw9Ie5SZf/U8oY/FT9VTAz396nRL2xaC0w+n251DTFZhG5QqgQ9QEFofNzUE
	 IbI/QMX6K9hFMLkynaOEl22qfvuOGoorNoJQXtCpHBP2jCxSn2UViMPbslu78Zf9V8
	 2fsMUnaKMufDQLUcsF86YGJt+gzCTGd1AUMk5TCrtNxcZ3zoKLrogvwMeUII5tQjN/
	 ROLNRrL+re+xA==
Date: Sun, 17 Dec 2023 22:18:50 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v6.7
Message-ID: <ZX8mcsYczF3bDOEy@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bgDGIEe5wx7ekQSs"
Content-Disposition: inline


--bgDGIEe5wx7ekQSs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus,

Please pull the bunch of driver fixes for this cycle.

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-6.7

for you to fetch changes up to 4ee632c82d2dbb9e2dcc816890ef182a151cbd99:

  dmaengine: fsl-edma: fix DMA channel leak in eDMAv4 (2023-12-11 20:14:29 =
+0530)

----------------------------------------------------------------
dmaengine fixes for v6.7

Driver fixes for:
 - SPI PDMA data fix for TI k3-psil drivers
 - suspend fix, pointer check, logic for arbitration fix and channel leak
   fix in fsl-edma driver
 - couple of fixes in idxd driver for GRPCFG descriptions and int_handle
   field handling
 - single fix for stm32 driver for bitfield overflow

----------------------------------------------------------------
Amelie Delaunay (1):
      dmaengine: stm32-dma: avoid bitfield overflow assertion

Frank Li (1):
      dmaengine: fsl-edma: fix DMA channel leak in eDMAv4

Guanjun (2):
      dmaengine: idxd: Protect int_handle field in hw descriptor
      dmaengine: idxd: Fix incorrect descriptions for GRPCFG register

Jai Luthra (1):
      dmaengine: ti: k3-psil-am62a: Fix SPI PDMA data

Ronald Wahl (1):
      dmaengine: ti: k3-psil-am62: Fix SPI PDMA data

Xiaolei Wang (2):
      dmaengine: fsl-edma: Do not suspend and resume the masked dma channel=
 when the system is sleeping
      dmaengine: fsl-edma: Add judgment on enabling round robin arbitration

Yang Yingliang (1):
      dmaengine: fsl-edma: fix wrong pointer check in fsl_edma3_attach_pd()

 drivers/dma/fsl-edma-common.c  |  1 +
 drivers/dma/fsl-edma-main.c    | 12 ++++++++----
 drivers/dma/idxd/registers.h   | 12 +++++++-----
 drivers/dma/idxd/submit.c      | 14 +++++++-------
 drivers/dma/stm32-dma.c        |  8 ++++++--
 drivers/dma/ti/k3-psil-am62.c  | 12 ++++++------
 drivers/dma/ti/k3-psil-am62a.c | 12 ++++++------
 7 files changed, 41 insertions(+), 30 deletions(-)

--=20
~Vinod

--bgDGIEe5wx7ekQSs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmV/JnIACgkQfBQHDyUj
g0fMIA//VV5weP5wCoM/Uzl9mmiRraRkvItQJWzt44j857Y+2LZdqpimnZdqgpg8
Q+b4ai+y+8OA0V+0DsUQuOgyT/yNrR2TBjAL2BB3gyGpDuIuuNpM+5bmFeWSB0id
e98GT+hJkAdc6HEWbUMtGKPIDfnv7GHkn9tW3d+Q+WOSC0fmHiub9WOyk8gvzlyA
3jHslBFirjsOiqHGA3uCMXfAGUGm9jgFrTGAhWeNvJWaNdVlOTM2mTzYc03aYPbj
3tIgNUes9iblbPNb9Qc/CspYTwvcV6VUASEh25aHPFD2ijyOapuXAzJOqWNgUoST
U++hM2bI3ZJDyRbynkHaoMiHpCSb5QGp85pAfHAKI3b3rWzAwOorDfNOa8ugw5eo
+WM1Nx0YUxC/tacnjb8O6m5V3bI8CSalxnKkIfDhcxPWG9i0YjCaKfflUl4Gc3Wq
BIKFGsMTHARkpVDSE5wS7d80iBXpG67JG5rP2uUpDlXY7of0o/qBN3gM3Vm8n1wJ
F0rBIMl0NVYcXzOW8O3pV8ipm44Xdw0xfLHyjAqX7NaGwMHQNhSXw/R6g0svxHV8
oSdY/dTAlxsFTv7IIt0fYKAYTTOsJcP4jNch18+rKL7bUbGGFihNZ7p/xoZSeH5U
5/40bA0Bz9sg43snwZ7IwycRi/K48F+pQMlX++yn0yFL32m866g=
=cZ9t
-----END PGP SIGNATURE-----

--bgDGIEe5wx7ekQSs--

