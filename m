Return-Path: <linux-kernel+bounces-89828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A0786F633
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 17:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15C91C22140
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EE86CDD1;
	Sun,  3 Mar 2024 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C++4Jz7N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA408BE66
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709484600; cv=none; b=hwD/7pQWMeRWdBROUqDpjch/lETp2OeecYkq0ERDp/9uzMmx9H5h3q/GdLJjIg9/knqPieiukfRt7ZeV71gkIbVq9jFjYK7vQzEFJ+9qjlWgTrSBLhJO/KClO+V1XYG2O9V/3Dcmx158nvwtPHob16BtCPsG4LwxUhTEdr6PqOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709484600; c=relaxed/simple;
	bh=7C/4lY/DmmgRNkr0/jxH0xr5roy8SqCXHffLYjoa17s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EEplBb6jHJTFNRdyGbTRAMCMyN50wCLO39ZI5FZorCZpM0mvLAC+yXBTGLZkuATVLuHs1zRm4pRekaGXZnf59M5tkgguCogxOn4VdSEvX+vTAreMqmaEqifI6EtHVg890NUxyOAEFhyyUdPHFmgYgbwFL5MWISjdVG+Zn6s7pcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C++4Jz7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA96C433C7;
	Sun,  3 Mar 2024 16:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709484600;
	bh=7C/4lY/DmmgRNkr0/jxH0xr5roy8SqCXHffLYjoa17s=;
	h=Date:From:To:Cc:Subject:From;
	b=C++4Jz7NKiUGj+yAxDjujURm+0h9qSOJD7Bo9fAnxKlpAyEglgW0SKinn44OvzuKW
	 sqW/ClgR7/gr+wBa8gCL9xIMYMzPzWDiAwDh55ar5imsbyYU7mvUy6coEQXD7iwDdu
	 Z2WOf4lbro0bNsN8qMXQBHqMNjdSvZmgG3RgWmPIXrQU7fJ93NuJwjnTgxPxX56TE7
	 mV0NQXuNYKhOLYsj6iq6GgHiDoKqsdVtg49ztNfRTGpd90LpLJitgNQWRAYAFs4afD
	 boquyAkgu6A5dQkzyf4+GUYobGFqOPYItGKgrrxdNYz0lfwOORrQ/qAw3IpiAxZ67x
	 isQZc7XBLZ27g==
Date: Sun, 3 Mar 2024 22:19:55 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine fixes for v6.8
Message-ID: <ZeSqMxRO_GVABeW5@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h/IVU1u7VlBveMVu"
Content-Disposition: inline


--h/IVU1u7VlBveMVu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Please pull to receive the second set of fixes for 6.8. This includes
bunch of driver fixes collected.

The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix2-6.8

for you to fetch changes up to df2515a17914ecfc2a0594509deaf7fcb8d191ac:

  dmaengine: ptdma: use consistent DMA masks (2024-02-23 12:22:55 +0530)

----------------------------------------------------------------
dmaengine second set of fixes for v6.8

Driver fixes for:
 - dw-edma fixes to improve driver and remote HDMA setup
 - fsl-edma fixes for SoC hange, irq init and byte calculations
   and sparse fixes
 - idxd: safe user copy of completion record fix
 - ptdma: consistent DMA mask fix

----------------------------------------------------------------
Curtis Klein (1):
      dmaengine: fsl-qdma: init irq after reg initialization

Fenghua Yu (2):
      dmaengine: idxd: Remove shadow Event Log head stored in idxd
      dmaengine: idxd: Ensure safe user copy of completion record

Frank Li (2):
      dmaengine: fsl-edma: correct max_segment_size setting
      dmaengine: fsl-qdma: add __iomem and struct in union to fix sparse wa=
rning

Joy Zou (1):
      dmaengine: fsl-edma: correct calculation of 'nbytes' in multi-fifo sc=
enario

Kory Maincent (6):
      dmaengine: dw-edma: Fix the ch_count hdma callback
      dmaengine: dw-edma: Fix wrong interrupt bit set for HDMA
      dmaengine: dw-edma: HDMA_V0_REMOTEL_STOP_INT_EN typo fix
      dmaengine: dw-edma: Add HDMA remote interrupt configuration
      dmaengine: dw-edma: HDMA: Add sync read before starting the DMA trans=
fer in remote setup
      dmaengine: dw-edma: eDMA: Add sync read before starting the DMA trans=
fer in remote setup

Peng Ma (1):
      dmaengine: fsl-qdma: fix SoC may hang on 16 byte unaligned read

Tadeusz Struk (1):
      dmaengine: ptdma: use consistent DMA masks

 drivers/dma/dw-edma/dw-edma-v0-core.c | 17 +++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 39 ++++++++++++++++++++++---------=
---
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |  2 +-
 drivers/dma/fsl-edma-common.c         |  2 +-
 drivers/dma/fsl-edma-common.h         |  5 +++--
 drivers/dma/fsl-edma-main.c           |  4 +++-
 drivers/dma/fsl-qdma.c                | 40 +++++++++++++++++--------------=
----
 drivers/dma/idxd/cdev.c               |  2 +-
 drivers/dma/idxd/debugfs.c            |  2 +-
 drivers/dma/idxd/idxd.h               |  1 -
 drivers/dma/idxd/init.c               | 15 ++++++++++---
 drivers/dma/idxd/irq.c                |  3 +--
 drivers/dma/ptdma/ptdma-dmaengine.c   |  2 --
 13 files changed, 86 insertions(+), 48 deletions(-)

--=20
~Vinod

--h/IVU1u7VlBveMVu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmXkqjMACgkQfBQHDyUj
g0cd5RAAqM4D2zyDn671NVt+ToLO85KpWXVUQvzCUE+Vt85dag7qY7RY04odoPCm
Vt+U9/9dB6sGggPNv+qXof25tYuHajOtfDqYTCugT3xiP5FHNre76CPaFkuGhdZH
bleqyUXDw3ubaNgj0Ju8XxIMy5dMV2o577W2aOHWS/Co39B2U0nLUJY8E+Gj1M5e
2iR2uTQ/kliNmLuis3jZf+6PqS7oXS8GRpEPLHgRS9Fhrh9FdTtMr00p/EJ236BH
dPP9+gtQXTNFe3c8EMVwf20EM6WNMOeSzTGEIJJ1jPhrO1V1nm+mm73HYVCrQ6b4
hMxmvljLFRUWlC/k/8tCYmdKnCNMUhrr2H/4FHJQ4sO7L2F8WAwlAIQAnR09aybG
y+xzWMES2uPZ8RxETWBU90Qj8inrH8Uf0sJ7Zc2bWeL5/xMeCHbMN1KQzDvCs+sC
0+x2hMD/xwtQgu0lPFzMMytYFrt9qqY6k0hk17TnHAbvjYBDfMjfHW/NnhFDRi8W
mVbJGG7ou/+uWSejnA1LHCifcDaz1p8AsrZoLZHYV5cDVZfQQ46LF2pHrn8vuXGB
Wg6o2eoLTTlvWFUwXNz121GrE1gZbIvoOR9tuDzQflPhvDE3QZejdFObnG92dc7n
7/2swfeFuOQ2e4rzsldc7ys5Vtwwd34cdmo9q1GWYOEuss9arlI=
=LT1F
-----END PGP SIGNATURE-----

--h/IVU1u7VlBveMVu--

