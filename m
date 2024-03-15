Return-Path: <linux-kernel+bounces-104361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AA187CC9A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF2F1F21507
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972A41B946;
	Fri, 15 Mar 2024 11:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8VuURAM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E681B800
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710503028; cv=none; b=iZb7V0caV4z1sj1xR7IpvfbjYJt654LgVQ5AoTge7OWn/S7aVY4rCeep8MPEIxKYnjMvLukHD1xuOowy/92dZKFANCJkipNqCve23fI4/w0jFuaBiwjLV25/GVlz2lJ7Cz1THEYEBLATguO40th22MiK08p/vdarRv/YiQkD8H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710503028; c=relaxed/simple;
	bh=8YZRo4WNE2sSJPNmDvK5EX/H/70tpxfMBaWbhvseKbU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EBD7uB3bD6dED2ekgALUuGZzAIHfkQqT3GRkEWS2H+tEk6xwYo43lMmD+8a1nC3xnHUHwQQw3DZ1rHqZlHjAG1Kbuo04LIe1NMfDFC/z/7ZekHT68xxAqizhz+cW+6ffvFJIt3wIIRyX9tC0RqfFWAZT5OulCFUIgK9ijENWn3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8VuURAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C05C43390;
	Fri, 15 Mar 2024 11:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710503028;
	bh=8YZRo4WNE2sSJPNmDvK5EX/H/70tpxfMBaWbhvseKbU=;
	h=Date:From:To:Cc:Subject:From;
	b=e8VuURAMLbCzCt40ZXMJMcL5noKRxsYNU5wFMtkrhTmYKBE+g7t7izFeNSiFt1dnB
	 ufzEEH/NiZImpizweDjbdhhvrGK5XQe2EabGOkWENCf7Vi7x3tkR7rhI/EnUpecAjf
	 x0ohJHk9zumU6CL2x3pS6lmMFYswtHFGsJ432TItmE3pMVqu5Dc/6ktMOQyJXFpuJf
	 6gOqN5kgz51t3bEVUewoUy43cgEPKTgnbChcoij0YSkVmL1sc4RLtieb8U3UwJFixQ
	 rsmFJ1eiOXZ9fKaFpNtRuPIP2VNl0st/V9z1qc9fjyI9tUHi/lWWhc8eywZA43Q8xA
	 vA+gZpFFpr7Jw==
Date: Fri, 15 Mar 2024 17:13:43 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Dmaengine updates for v6.9
Message-ID: <ZfQ0bxZak7Nc3f6v@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UpVvJ2kO1aLBxgM3"
Content-Disposition: inline


--UpVvJ2kO1aLBxgM3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive this round of dmaengine updates which has couple
of new device support and updates to few drivers.

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-6.9-rc1

for you to fetch changes up to 716141d366f45d62ffe4dd53a045867b26e29d19:

  dmaengine: of: constify of_phandle_args in of_dma_find_controller() (2024=
-02-23 12:44:08 +0530)

----------------------------------------------------------------
dmaengine updates for v6.9

 New support:
  - Allwinner H616 dma support
  - Renesas r8a779h0 dma controller support
  - TI CSI2RX dma support

 Updates:
  - Freescale edma driver updates for TCD64csupport for i.MX95
  - constify of pointers and args
  - Yaml conversion for MediaTek High-Speed controller binding
  - TI k3 udma support for TX/RX DMA channels for thread IDs

----------------------------------------------------------------
Basavaraj Natikar (1):
      MAINTAINERS: change in AMD ptdma maintainer

Chen-Yu Tsai (1):
      dt-bindings: dma: allwinner,sun50i-a64-dma: Add compatible for H616

Daniel Scally (1):
      dmaengine: pl330: Clear callback_result for re-used descs

Duje Mihanovi=C4=87 (1):
      dt-bindings: mmp-dma: convert to YAML

Frank Li (6):
      dmaengine: fsl-edma: involve help macro fsl_edma_set(get)_tcd()
      dmaengine: fsl-edma: fix spare build warning
      dmaengine: fsl-edma: add address for channel mux register in fsl_edma=
_chan
      dmaengine: mcf-edma: utilize edma_write_tcdreg() macro for TCD Access
      dt-bindings: fsl-dma: fsl-edma: add fsl,imx95-edma5 compatible string
      dmaengine: fsl-edma: integrate TCD64 support for i.MX95

Geert Uytterhoeven (1):
      dt-bindings: renesas,rcar-dmac: Add r8a779h0 support

Krzysztof Kozlowski (2):
      dmaengine: pl08x: constify pointer to char in filter function
      dmaengine: of: constify of_phandle_args in of_dma_find_controller()

Kunwu Chan (1):
      dmaengine: bestcomm: Code cleanup for bcom_sram_init

Lukas Bulwahn (1):
      MAINTAINERS: adjust file entry in MEDIATEK DMA DRIVER

Peter Korsgaard (1):
      dmaengine: xilinx_dma: check for invalid vdma interleaved parameters

Peter Robinson (1):
      dmaengine: tegra210-adma: Update dependency to ARCH_TEGRA

Rafa=C5=82 Mi=C5=82ecki (1):
      dt-bindings: dma: convert MediaTek High-Speed controller to the json-=
schema

Ricardo B. Marliere (2):
      dmaengine: idxd: make dsa_bus_type const
      dmaengine: idxd: constify the struct device_type usage

Siddharth Vadapalli (4):
      dmaengine: ti: k3-udma-glue: Add function to parse channel by ID
      dmaengine: ti: k3-udma-glue: Update name for remote RX channel device
      dmaengine: ti: k3-udma-glue: Add function to request TX chan for thre=
ad ID
      dmaengine: ti: k3-udma-glue: Add function to request RX chan for thre=
ad ID

Vaishnav Achath (1):
      dmaengine: ti: k3-psil-j721s2: Add entry for CSI2RX

 .../bindings/dma/allwinner,sun50i-a64-dma.yaml     |  12 +-
 .../devicetree/bindings/dma/fsl,edma.yaml          |   2 +
 .../devicetree/bindings/dma/marvell,mmp-dma.yaml   |  72 +++++
 .../bindings/dma/mediatek,mt7622-hsdma.yaml        |  63 +++++
 Documentation/devicetree/bindings/dma/mmp-dma.txt  |  81 ------
 .../devicetree/bindings/dma/mtk-hsdma.txt          |  33 ---
 .../devicetree/bindings/dma/renesas,rcar-dmac.yaml |   1 +
 MAINTAINERS                                        |   4 +-
 drivers/dma/Kconfig                                |  14 +-
 drivers/dma/amba-pl08x.c                           |   2 +-
 drivers/dma/bestcomm/sram.c                        |   5 -
 drivers/dma/fsl-edma-common.c                      | 101 ++++---
 drivers/dma/fsl-edma-common.h                      | 159 ++++++++++-
 drivers/dma/fsl-edma-main.c                        |  19 +-
 drivers/dma/idxd/bus.c                             |   2 +-
 drivers/dma/idxd/cdev.c                            |   4 +-
 drivers/dma/idxd/idxd.h                            |  14 +-
 drivers/dma/idxd/sysfs.c                           |  10 +-
 drivers/dma/mcf-edma-main.c                        |   2 +-
 drivers/dma/of-dma.c                               |   2 +-
 drivers/dma/pl330.c                                |   1 +
 drivers/dma/ti/k3-psil-j721s2.c                    |  73 +++++
 drivers/dma/ti/k3-udma-glue.c                      | 314 +++++++++++++++--=
----
 drivers/dma/xilinx/xilinx_dma.c                    |   6 +
 include/linux/dma/k3-udma-glue.h                   |  10 +
 25 files changed, 705 insertions(+), 301 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/marvell,mmp-dma.y=
aml
 create mode 100644 Documentation/devicetree/bindings/dma/mediatek,mt7622-h=
sdma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/mmp-dma.txt
 delete mode 100644 Documentation/devicetree/bindings/dma/mtk-hsdma.txt


--=20
~Vinod

--UpVvJ2kO1aLBxgM3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmX0NG8ACgkQfBQHDyUj
g0dQLRAA0Gi4QUSKHL7+chFa3qFrKrKjprBA8td4gOx6kHYesGo7dR9xs7h1o0Zg
Xu5jRQzJZ2/3UXlHhXlQbpgyAIHxNJU9xKoo04ivhy7nNO7A8/vOQrulcPN+KHES
xereqb92Y8r8/rIhS0m3PpYiT6zxFRCSkl40iyJ5sgXss6sqlQWe6gm0OZFkH/2S
4ALHT6qHXPKU0TqwU09DYNZA/DEzFuc0XL5T4nVDpYObsH6aUOel0fr7iDQx2Tno
zGtcgN9tMFqMWZcB5XZ0nnHwZ+5t9VHeSWT37ySXo1bR7CdsOKKJLQOA+0lW3nLU
r6yQ+v7332b4JjitYiUvEX/I0GGVMoJoLkYBg7CoPR2XBDfnrqK3nuNPhhLXkvoY
uifgt7KpFuN7e643VEPzyGg1AxDGBMmXXeskkWbEeMXdEiJqW1lFf4jlOnpufPIb
s9q+g4VWNcznPMnTyBW5juJkYe9yIBxNzzaEgRYKKwgbYbTqpO7WGLN9Z5BDtaC/
E3K4eK5tladoCb7QHNNtJCRoyZ5z+Ofo62oxwKv/CqkpiosHQoYBwAh7HjPurVCj
7JPM2+paCyGANzUEBnaCzTDX6zPLjk8fjZmIr9NwOaP0t+J5PvJiJrQrT/DfIjIv
z5ckgJZd3eM4bH4o3duoMIlu4Yqe0Co0UZLHRkKlMR4aXKQK1Ek=
=uY60
-----END PGP SIGNATURE-----

--UpVvJ2kO1aLBxgM3--

