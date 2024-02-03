Return-Path: <linux-kernel+bounces-51113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4E08486A5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770AF1C222D8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5005D72F;
	Sat,  3 Feb 2024 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwHpfQp/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A0C5D90E
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706969622; cv=none; b=OkkyJvpgHAzj+0iiCyHgRu2N6BYtp6cZQfryuRD2aJy5/8ta90vaZwDt4WmzOexjTmRoHGytJVWwSPDmguy+hTEngSsMRqyA8T8aLmF8InA63IIftFpMP+kRI/6Uleamuiah/s5THy3jbL6fGRWBR6PwjrmB7oL+T8otQcVodUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706969622; c=relaxed/simple;
	bh=RPneNaa2uEVKZuUSyn5lzgeuWNSydI9kdI1GeJc3IEA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CVM2cbH6jGDG8tmpGff6wLwz6WCZDu1APOObO5e465ydh2sI3C4ly2ve/vjA2i0uzp7Wc8voA6uKE0yn7Eth8ka3V8tk5t1c4V4kqJksoekGDR0ud1cl/ATwzKvu6wUNdIVy9Wk4rjncYcnEBO0Il0hYVXe8ClURPwLe5ci2EYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwHpfQp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C437C433C7;
	Sat,  3 Feb 2024 14:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706969621;
	bh=RPneNaa2uEVKZuUSyn5lzgeuWNSydI9kdI1GeJc3IEA=;
	h=Date:From:To:Cc:Subject:From;
	b=WwHpfQp/NsZzkjSbfiWt5Uu7+U2aFS4wsDN54yZjS5Pv2ENip84SZzQqZcNXQ5t3I
	 y3zx3Q3/fa2pBOkip97LLvpuAJiCnXBLUR48p3apF/1NUtIIz/BMLk78g1oyxT4vKp
	 5cmrWyyeZpZH75AnXfCtJNeXEnBR5OwduZ/9FmRr9C7HNeBty4+8sYn3pMBwtjwEOW
	 ffkaoYKNoWQFofkRlR+Ecg0qwqXrCDsGg/DMyAzpfIYLZeqGqP09h5PoqCGlAAl4A8
	 8capQSg4Alvr0PgUR6fw7t8mLVE7yxr8DPBP3qW/+X20myamRcy6hdwnIUpD6ELc/e
	 Shj7C/Q1Sa5SA==
Date: Sat, 3 Feb 2024 15:13:38 +0100
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for 6.8
Message-ID: <Zb5KEtfOS8_8EoUA@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YkEJObseZexlNKN4"
Content-Disposition: inline


--YkEJObseZexlNKN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus,

Please pull to receive the fixes for dmaengine subsystem which includes
one core fix for return of slave condition for d2d dma and few driver
fixes

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-6.8

for you to fetch changes up to bd6081be2251c3700eca8a7bbe071e1bb8cd2af4:

  dmaengine: at_hdmac: add missing kernel-doc style description (2024-02-02=
 17:16:55 +0100)

----------------------------------------------------------------
dmaengine fixes for v6.8

Core:
 - return of is_slave_direction() for D2D dma

Driver fixes for:
 - Documentaion fixes to resolve warnings for at_hdmac driver
 - bunch of fsl driver fixes for memory leaks, and useless kfree
 - TI edma and k3 fixes for packet error and null pointer checks

----------------------------------------------------------------
Christophe JAILLET (3):
      dmaengine: fsl-qdma: Fix a memory leak related to the status queue DMA
      dmaengine: fsl-qdma: Fix a memory leak related to the queue command D=
MA
      dmaengine: fsl-qdma: Remove a useless devm_kfree()

Frank Li (1):
      dmaengine: fix is_slave_direction() return false when DMA_DEV_TO_DEV

Guanhua Gao (1):
      dmaengine: fsl-dpaa2-qdma: Fix the size of dma pools

Jai Luthra (1):
      dmaengine: ti: k3-udma: Report short packet errors

Kunwu Chan (1):
      dmaengine: ti: edma: Add some null pointer checks to the edma_probe

Randy Dunlap (1):
      dmaengine: at_hdmac: fix some kernel-doc warnings

Vinod Koul (1):
      dmaengine: at_hdmac: add missing kernel-doc style description

 drivers/dma/at_hdmac.c                  | 32 +++++++++++++++++++++--------=
---
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c | 10 ++++++----
 drivers/dma/fsl-qdma.c                  | 33 ++++++++++++-----------------=
----
 drivers/dma/ti/edma.c                   | 10 ++++++++++
 drivers/dma/ti/k3-udma.c                | 10 ++++++++--
 include/linux/dmaengine.h               |  3 ++-
 6 files changed, 59 insertions(+), 39 deletions(-)

--=20
~Vinod

--YkEJObseZexlNKN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmW+ShIACgkQfBQHDyUj
g0c05hAAjTSkPnZmlstmo6QDEjDz4casVRTiA7opSCdaSoWN0B3RzEqsOc9XGy1R
oBmFZ7KF1G3Ee4e6gnbvEio3ezRE51mfs0t5KiJFiB7NgxNWP6saHn9UxWxQmBec
ZYIhgoo/IulsQndnzN+kS/u+5lWUej2sAmBfN2as3Phx+VISa4BT3PfWT3ukZPEm
40+qaY+KHiX7vbk0kfJdGjPFvu0Ub0RhfBTN3rTPP+l6nMlBFKJz2W+LJ0jW37uH
cJ0sZI85sLcci/DWhv7P3+cI6P9OIdcoPey7GlIXzeeN+DVKr4SQU8hITbzhjkQf
gQ0qdZk2lbBF1MXd/+YTSGDsyPaHoSx4pm5SFNtw/DvRy0IDsatQ4Ph5sNdGQzWj
Jjvg2jkEqblp2uil1liTD4wVOy0uRVWTp8+aQVdEEeoMUk5V1TkrppF6iG7+CYOk
oejeZgqtjSi//mkJmNBG0JtTdnT0/vrLyaB4tyIX7PTFVUMBLVHT5j8lCsCAIYtu
k7GCU7z3wAjUA5hz3mrNBEDrSWjFCZcGX+Fg4c2aUyTEJWNBm4XO2tD6e4WuwEar
gNWjhNIFRDaJsEMGsP8ki1/RMtshbyB2uGsI+rYpToRsNE+3wUPCm+7vRP0BZxIt
g/ikzY/M5YfJznA/27IvyWh4I3Ul7x83rHq/b3mKiUSMP02pRww=
=KCZC
-----END PGP SIGNATURE-----

--YkEJObseZexlNKN4--

