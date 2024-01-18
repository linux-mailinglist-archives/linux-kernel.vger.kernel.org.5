Return-Path: <linux-kernel+bounces-30416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AE5831E62
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7661C25FD7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB11F2C854;
	Thu, 18 Jan 2024 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fv55VXaY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51562C843
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705598673; cv=none; b=ttluJ6xNL+kUFmbRY2Dn9u4qaYp2UX1SgYhgKkYNxBxWQpOR6XDMaeALTqHgcMYDQ477UJUvBtYAkLJwD1QYdvEsmPLr6Lq0KuaOACa9KzaA1d4fIrriSKFWQPkVmxoiMkwuLBhkmKmXSa3g+fZtGBQAjM5VUmXLtWCczrnJ4JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705598673; c=relaxed/simple;
	bh=T2JAezwirTZ9uuxajbj0y1g+ZRfkKLJQmn8sVqsLCCA=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition; b=awV9CI02QwcyMWxXmx4O82E9cQ958oTG8LA7ZeNc1w5sz7x+QHpfeuAT3aIPNt7xqatAo3VCvR8IBWHkaB7Ba0mE0XXorzm27T4sL6QrA6/Qi+3IzSusUA4IfYy5+ea4mHvCFMyiheqK7NVj3iNhk/QvnZaH+K2A2K5i7pzd5Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fv55VXaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C0AC433C7;
	Thu, 18 Jan 2024 17:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705598672;
	bh=T2JAezwirTZ9uuxajbj0y1g+ZRfkKLJQmn8sVqsLCCA=;
	h=Date:From:To:Cc:Subject:From;
	b=fv55VXaYE4wiLDQYDbmYwJFhIfmOpvZ32FQRPlH7Ow0Pm11hxy/ESO9b5xOHlldo/
	 uAB8b3iDin1pxNbYYuyi+BPNTpmG72wM9f0uAXXz5hud5q1V86RaN6jUWRZixAOI7b
	 JXkh6rU+3Gs7edxvIDHwFNaZ0fCh2oejkIMw5OhekMqB5JrcEZkBfTVkbvYgmsuqTY
	 idYpTPfQn3vij7GPR9zRgQ87200TMQDi2gn3JtIGeyS4CLhwJyCXT2TkWNYQWXyYoN
	 bnsKkl0qXi31WF41nlpKYjwA8B9eJeSarv9v3PGRvvdRPbq6VExWsWCGjm9L/XWdPY
	 puF1OXsqI2q9g==
Date: Thu, 18 Jan 2024 22:54:28 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v6.8
Message-ID: <ZalezMgxAVyu5WEE@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="85McVa4G6y7EctIz"
Content-Disposition: inline


--85McVa4G6y7EctIz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Heya Linus,

Last pull request for the night to receive the dmaengine subsystem
updates containing one new driver, couple of device support (qualcomm,
sf-pdma) and driver updates.

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-6.8-rc1

for you to fetch changes up to 3d0b2176e04261ab4ac095ff2a17db077fc1e46d:

  dmaengine: xilinx: xdma: statify xdma_prep_interleaved_dma (2023-12-22 21=
:17:52 +0530)

----------------------------------------------------------------
dmaengine updates for v6.8

 New support:
  - Loongson LS2X APB DMA controller
  - sf-pdma: mpfs-pdma support
  - Qualcomm X1E80100 GPI dma controller support

 Updates:
  - Xilinx XDMA updates to support interleaved DMA transfers
  - TI PSIL threads for AM62P and J722S and cfg register regions description
  - axi-dmac Improving the cyclic DMA transfers
  - Tegra Support dma-channel-mask property
  - Remaining platform remove callback returning void conversions

----------------------------------------------------------------
Amelie Delaunay (2):
      dmaengine: dmatest: prevent using swiotlb buffer with nobounce parame=
ter
      dmaengine: fix NULL pointer in channel unregistration function

Binbin Zhou (2):
      dt-bindings: dmaengine: Add Loongson LS2X APB DMA controller
      dmaengine: ls2x-apb: New driver for the Loongson LS2X APB DMA control=
ler

Bumyong Lee (1):
      dmaengine: pl330: issue_pending waits until WFP state

Christophe JAILLET (1):
      dmaengine: idxd: Remove usage of the deprecated ida_simple_xx() API

Frank Li (3):
      dmaengine: fsl-edma: fix eDMAv4 channel allocation issue
      dt-bindings: dma: fsl-edma: Add fsl-edma.h to prevent hardcoding in d=
ts
      dmaengine: fsl-edma: utilize common dt-binding header file

Hector Martin (1):
      dmaengine: apple-admac: Keep upper bits of REG_BUS_WIDTH

Jan Kuliga (8):
      dmaengine: xilinx: xdma: Get rid of unused code
      dmaengine: xilinx: xdma: Add necessary macro definitions
      dmaengine: xilinx: xdma: Ease dma_pool alignment requirements
      dmaengine: xilinx: xdma: Rework xdma_terminate_all()
      dmaengine: xilinx: xdma: Add error checking in xdma_channel_isr()
      dmaengine: xilinx: xdma: Add transfer error reporting
      dmaengine: xilinx: xdma: Prepare the introduction of interleaved DMA =
transfers
      dmaengine: xilinx: xdma: Implement interleaved DMA transfers

Lad Prabhakar (1):
      dt-bindings: dma: rz-dmac: Document RZ/Five SoC

Miquel Raynal (4):
      dmaengine: xilinx: xdma: Fix the count of elapsed periods in cyclic m=
ode
      dmaengine: xilinx: xdma: Clarify the logic between cyclic/sg modes
      dmaengine: xilinx: xdma: Better handling of the busy variable
      dmaengine: xilinx: xdma: Add terminate_all/synchronize callbacks

Mohan Kumar (2):
      dt-bindings: dma: Add dma-channel-mask to nvidia,tegra210-adma
      dmaengine: tegra210-adma: Support dma-channel-mask property

Neil Armstrong (1):
      dt-bindings: dma: qcom,gpi: document the SM8650 GPI DMA Engine

Paul Cercueil (5):
      dmaengine: axi-dmac: Small code cleanup
      dmaengine: axi-dmac: Allocate hardware descriptors
      dmaengine: axi-dmac: Add support for scatter-gather transfers
      dmaengine: axi-dmac: Use only EOT interrupts when doing scatter-gather
      dmaengine: axi-dmac: Improve cyclic DMA transfers in SG mode

Randy Dunlap (1):
      dmaengine: std_dma40: fix kernel-doc warnings and spelling

Rex Zhang (1):
      dmaengine: idxd: Move dma_free_coherent() out of spinlocked context

Rob Herring (1):
      dt-bindings: dma: Drop undocumented examples

Shravan Chippa (3):
      dmaengine: sf-pdma: Support of_dma_controller_register()
      dt-bindings: dma: sf-pdma: add new compatible name
      dmaengine: sf-pdma: add mpfs-pdma compatible name

Sibi Sankar (1):
      dt-bindings: dma: qcom: gpi: add compatible for X1E80100

Uwe Kleine-K=F6nig (4):
      dmaengine: milbeaut-hdmac: Convert to platform remove callback return=
ing void
      dmaengine: milbeaut-xdmac: Convert to platform remove callback return=
ing void
      dmaengine: uniphier-mdmac: Convert to platform remove callback return=
ing void
      dmaengine: uniphier-xdmac: Convert to platform remove callback return=
ing void

Vignesh Raghavendra (5):
      dt-bindings: dma: ti: k3-*: Add descriptions for register regions
      dt-bindings: dma: ti: k3-bcdma: Describe cfg register regions
      dt-bindings: dma: ti: k3-pktdma: Describe cfg register regions
      dt-bindings: dma: ti: k3-udma: Describe cfg register regions
      dmaengine: ti: k3-udma: Add PSIL threads for AM62P and J722S

Vinod Koul (2):
      dmaengine: xilinx: xdma: Workaround truncation compilation error
      dmaengine: xilinx: xdma: statify xdma_prep_interleaved_dma

 .../devicetree/bindings/dma/dma-controller.yaml    |  15 -
 .../devicetree/bindings/dma/dma-router.yaml        |  11 -
 .../bindings/dma/loongson,ls2x-apbdma.yaml         |  62 ++
 .../bindings/dma/nvidia,tegra210-adma.yaml         |   3 +
 .../devicetree/bindings/dma/qcom,gpi.yaml          |   2 +
 .../devicetree/bindings/dma/renesas,rz-dmac.yaml   |   2 +-
 .../bindings/dma/sifive,fu540-c000-pdma.yaml       |   1 +
 .../devicetree/bindings/dma/ti/k3-bcdma.yaml       |  39 +-
 .../devicetree/bindings/dma/ti/k3-pktdma.yaml      |  26 +-
 .../devicetree/bindings/dma/ti/k3-udma.yaml        |  20 +-
 MAINTAINERS                                        |   7 +
 drivers/dma/Kconfig                                |  14 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/apple-admac.c                          |   5 +-
 drivers/dma/dma-axi-dmac.c                         | 286 ++++++---
 drivers/dma/dmaengine.c                            |   3 +
 drivers/dma/dmatest.c                              |  17 +-
 drivers/dma/fsl-edma-main.c                        |  17 +-
 drivers/dma/idxd/cdev.c                            |   4 +-
 drivers/dma/idxd/device.c                          |   9 +-
 drivers/dma/ls2x-apb-dma.c                         | 705 +++++++++++++++++=
++++
 drivers/dma/milbeaut-hdmac.c                       |  17 +-
 drivers/dma/milbeaut-xdmac.c                       |  17 +-
 drivers/dma/pl330.c                                |   3 +
 drivers/dma/sf-pdma/sf-pdma.c                      |  44 +-
 drivers/dma/sf-pdma/sf-pdma.h                      |   8 +-
 drivers/dma/ste_dma40.c                            |  12 +-
 drivers/dma/tegra210-adma.c                        |  35 +-
 drivers/dma/ti/Makefile                            |   3 +-
 drivers/dma/ti/k3-psil-am62p.c                     | 325 ++++++++++
 drivers/dma/ti/k3-psil-priv.h                      |   1 +
 drivers/dma/ti/k3-psil.c                           |   2 +
 drivers/dma/ti/k3-udma.c                           |   2 +
 drivers/dma/uniphier-mdmac.c                       |  17 +-
 drivers/dma/uniphier-xdmac.c                       |  17 +-
 drivers/dma/xilinx/xdma-regs.h                     |  30 +-
 drivers/dma/xilinx/xdma.c                          | 350 +++++++---
 drivers/dma/xilinx/xilinx_dpdma.c                  |   2 +-
 include/dt-bindings/dma/fsl-edma.h                 |  21 +
 39 files changed, 1870 insertions(+), 285 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls2x-apb=
dma.yaml
 create mode 100644 drivers/dma/ls2x-apb-dma.c
 create mode 100644 drivers/dma/ti/k3-psil-am62p.c
 create mode 100644 include/dt-bindings/dma/fsl-edma.h
--=20
~Vinod

--85McVa4G6y7EctIz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmWpXswACgkQfBQHDyUj
g0eH7w/+KnuXKTcO/el3DZF69keQZrRK9FMWBHBoi3XeaztMLbIND63qSt+yQtIR
ureujrJ4Ce6OUNaqzNHCsdHSfHEAd1Swc3vGMKSlbhcXIQOBiZ09uWcST/DaFBIr
ninwXSEn3mHWIPnjqHQfQIEE0oovwFJhAo+a4etAqLPjEBiQ5ZqRkzcncrSdcGKO
b5qxhnSzdfIoemZIY4GXnz1ioX2pdFKesMtimsWF15dt91vRmNwAnLV0VQnQjm9H
oTun1JKGoLlKnapoZJcnNKGwSYFKmNySER014/C++omu69k2LGkbsQIGPjq6e2KV
nbrm4qPga37xIAgaIDGXZU0ZDQuwIjD3Ag1qpCa9FC+XtZPSIQIe19r6mM73lAZk
jpMaKtFs6qlx3ccYVIh20Z8Nj9ZHqh+tXeir4IqCLReIIow7Z6yOzw6V0E4qG+q7
GFCz2wzo1Mr3w2CSdAfHKW9jU0wT7T6nehWnfaQQh+pFJosnXFKsVywSdDjpqm+j
yWMA1b2SmLFPDoFnRItYoq61yUik2Mq9aYfu9HAC7+EqoWkLEHUaBVtd5w6a9y1Z
nUdy1x0Q/sD6xxg2cTgS324BJ1g2KXprtl4hQLVhxv+g61954gCiw+3TQNXZbYIp
hBC/t0vzxDrWV7Kuh2r+of0RGoAkdOVFSD86dNgkUZTjv3XtoGU=
=MnXr
-----END PGP SIGNATURE-----

--85McVa4G6y7EctIz--

