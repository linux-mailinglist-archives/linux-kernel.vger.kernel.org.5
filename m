Return-Path: <linux-kernel+bounces-31890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E168335FC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 20:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B4D282DBB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 19:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653CA10949;
	Sat, 20 Jan 2024 19:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkjodxRT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DD42101
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705779473; cv=none; b=T0hbCpCWSPb7vmae3Wd283uX/4Htlwij8qbrxA45h3odv9iApacjsrAcZBw5Q83SPA0K+cIhqXjiIZilMvynzJNIqM0PfY0JKqjhiLpOFC6j2VfZFVxX0Yb1OGdLYwcC1FpAayFxUTKm0fxpFBI3iPJbEFpI2XUQvFNHgE8MOcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705779473; c=relaxed/simple;
	bh=qFo7ylTGh+jTLahpYLgknar//1VktuSo3IHdhsX4bFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cm5xj0OdArXzti2Om/LMxvONOAXGt/EKiMKZr5W0A4rHr7JLZAjqM1HYzO+RuytUQ1gg5FPYQ/Yer0pO+yEyoijjnYfu5gBghUSKMlYjosNJj1xjZq2S4W6zDI7no8NqwCp9elkSWVFPVDbyzG4eAr0Cx4O6CWXb7Cxbte55A9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkjodxRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BF7C433C7;
	Sat, 20 Jan 2024 19:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705779472;
	bh=qFo7ylTGh+jTLahpYLgknar//1VktuSo3IHdhsX4bFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OkjodxRTwF+z/BBtbKDbSvSv06c9phBRP8jECQsveDXzcKb71sppwBkIzNiBsNrWR
	 z4l9TEPkqGn/Ta3VYHl+VTCnJXMlWBk+HP0/Dd/ZLq+SqCdfrDwWaRE9wduWLwNvpM
	 J72G6Qw4Ny8SA6lNR0CvmbpDAxrieQlkdESkrIsmeSi2vIVkAcpJ+HAhl8oBFTVhar
	 KSE4qdJxBuvdQyiMgVx7awoyWvCbyytOMTpaJaTruMSj9P+0fr1O2dTZqctpyz6eIq
	 qI2FKyOWmakMuvr24PhT07FCFgVFjVpbkQJqUUDcY1riKTCV63TgUNo6xQYwTDIV9m
	 IzDOQOIY3djSA==
Date: Sun, 21 Jan 2024 01:07:48 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [GIT PULL]: dmaengine updates for v6.8
Message-ID: <ZawhDA2SlQAVNsFO@matsya>
References: <ZalezMgxAVyu5WEE@matsya>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="miCZTHhWM3lRHzW0"
Content-Disposition: inline
In-Reply-To: <ZalezMgxAVyu5WEE@matsya>


--miCZTHhWM3lRHzW0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On 18-01-24, 22:54, Vinod Koul wrote:
> Heya Linus,
>=20
> Last pull request for the night to receive the dmaengine subsystem
> updates containing one new driver, couple of device support (qualcomm,
> sf-pdma) and driver updates.
>=20
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa=
86:
>=20
>   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/=
dmaengine-6.8-rc1

I have picked the fixes from Nathan and also found that with W=3D1 there
were few other warnings reported, so picked/fixed them up as well. Added
this to my test scripts so shouldnt be missed in the future.

I have merged this tag into my fixes branch and applied the changes on top.=
 So
the diff stat mentions older fixes already picked. I guess that wasnt a
smart move, I should have picked changes on top of next.

Nevertheless I hope to not miss it again so please consider older pull
request and then the below fixes request for v6.8-rc1

The following changes since commit 3d0b2176e04261ab4ac095ff2a17db077fc1e46d:

  dmaengine: xilinx: xdma: statify xdma_prep_interleaved_dma (2023-12-22 21=
:17:52 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-fix-6.8-rc1

for you to fetch changes up to cb95a4fa50bbc1262bfb7fea482388a50b12948f:

  dmaengine: dw-edma: increase size of 'name' in debugfs code (2024-01-19 1=
8:17:34 +0530)

----------------------------------------------------------------
dmaengine fixes for v6.8-rc1

Driver fixes for:
 - Xilinx xdma driver operator precedence and initialization fix
 - Excess kernel-doc warning fix in imx-sdma xilinx xdma drivers
 - format-overflow warning fix for rz-dmac, sh usb dmac drivers
 - 'output may be truncated' fix for shdma, fsl-qdma and dw-edma drivers

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

Jan Kuliga (1):
      dmaengine: xilinx: xdma: Fix kernel-doc warnings

Lad Prabhakar (2):
      dmaengine: sh: rz-dmac: Avoid format-overflow warning
      dmaengine: usb-dmac: Avoid format-overflow warning

Nathan Chancellor (2):
      dmaengine: xilinx: xdma: Fix operator precedence in xdma_prep_interle=
aved_dma()
      dmaengine: xilinx: xdma: Fix initialization location of desc in xdma_=
channel_isr()

Randy Dunlap (1):
      dmaengine: imx-sdma: fix Excess kernel-doc warnings

Ronald Wahl (1):
      dmaengine: ti: k3-psil-am62: Fix SPI PDMA data

Vinod Koul (4):
      Merge tag 'dmaengine-6.8-rc1' into fixes
      dmaengine: shdma: increase size of 'dev_id'
      dmaengine: fsl-qdma: increase size of 'irq_name'
      dmaengine: dw-edma: increase size of 'name' in debugfs code

Xiaolei Wang (2):
      dmaengine: fsl-edma: Do not suspend and resume the masked dma channel=
 when the system is sleeping
      dmaengine: fsl-edma: Add judgment on enabling round robin arbitration

Yang Yingliang (1):
      dmaengine: fsl-edma: fix wrong pointer check in fsl_edma3_attach_pd()

 drivers/dma/dw-edma/dw-edma-v0-debugfs.c |  4 ++--
 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c |  4 ++--
 drivers/dma/fsl-edma-common.c            |  1 +
 drivers/dma/fsl-edma-main.c              | 12 ++++++++----
 drivers/dma/fsl-qdma.c                   |  2 +-
 drivers/dma/idxd/registers.h             | 12 +++++++-----
 drivers/dma/idxd/submit.c                | 14 +++++++-------
 drivers/dma/imx-sdma.c                   |  4 ----
 drivers/dma/sh/rz-dmac.c                 |  8 ++++----
 drivers/dma/sh/shdma.h                   |  2 +-
 drivers/dma/sh/usb-dmac.c                | 10 +++++-----
 drivers/dma/stm32-dma.c                  |  8 ++++++--
 drivers/dma/ti/k3-psil-am62.c            | 12 ++++++------
 drivers/dma/ti/k3-psil-am62a.c           | 12 ++++++------
 drivers/dma/xilinx/xdma.c                | 21 +++++++++++----------
 15 files changed, 67 insertions(+), 59 deletions(-)
>=20
> for you to fetch changes up to 3d0b2176e04261ab4ac095ff2a17db077fc1e46d:
>=20
>   dmaengine: xilinx: xdma: statify xdma_prep_interleaved_dma (2023-12-22 =
21:17:52 +0530)
>=20
> ----------------------------------------------------------------
> dmaengine updates for v6.8
>=20
>  New support:
>   - Loongson LS2X APB DMA controller
>   - sf-pdma: mpfs-pdma support
>   - Qualcomm X1E80100 GPI dma controller support
>=20
>  Updates:
>   - Xilinx XDMA updates to support interleaved DMA transfers
>   - TI PSIL threads for AM62P and J722S and cfg register regions descript=
ion
>   - axi-dmac Improving the cyclic DMA transfers
>   - Tegra Support dma-channel-mask property
>   - Remaining platform remove callback returning void conversions
>=20
> ----------------------------------------------------------------
> Amelie Delaunay (2):
>       dmaengine: dmatest: prevent using swiotlb buffer with nobounce para=
meter
>       dmaengine: fix NULL pointer in channel unregistration function
>=20
> Binbin Zhou (2):
>       dt-bindings: dmaengine: Add Loongson LS2X APB DMA controller
>       dmaengine: ls2x-apb: New driver for the Loongson LS2X APB DMA contr=
oller
>=20
> Bumyong Lee (1):
>       dmaengine: pl330: issue_pending waits until WFP state
>=20
> Christophe JAILLET (1):
>       dmaengine: idxd: Remove usage of the deprecated ida_simple_xx() API
>=20
> Frank Li (3):
>       dmaengine: fsl-edma: fix eDMAv4 channel allocation issue
>       dt-bindings: dma: fsl-edma: Add fsl-edma.h to prevent hardcoding in=
 dts
>       dmaengine: fsl-edma: utilize common dt-binding header file
>=20
> Hector Martin (1):
>       dmaengine: apple-admac: Keep upper bits of REG_BUS_WIDTH
>=20
> Jan Kuliga (8):
>       dmaengine: xilinx: xdma: Get rid of unused code
>       dmaengine: xilinx: xdma: Add necessary macro definitions
>       dmaengine: xilinx: xdma: Ease dma_pool alignment requirements
>       dmaengine: xilinx: xdma: Rework xdma_terminate_all()
>       dmaengine: xilinx: xdma: Add error checking in xdma_channel_isr()
>       dmaengine: xilinx: xdma: Add transfer error reporting
>       dmaengine: xilinx: xdma: Prepare the introduction of interleaved DM=
A transfers
>       dmaengine: xilinx: xdma: Implement interleaved DMA transfers
>=20
> Lad Prabhakar (1):
>       dt-bindings: dma: rz-dmac: Document RZ/Five SoC
>=20
> Miquel Raynal (4):
>       dmaengine: xilinx: xdma: Fix the count of elapsed periods in cyclic=
 mode
>       dmaengine: xilinx: xdma: Clarify the logic between cyclic/sg modes
>       dmaengine: xilinx: xdma: Better handling of the busy variable
>       dmaengine: xilinx: xdma: Add terminate_all/synchronize callbacks
>=20
> Mohan Kumar (2):
>       dt-bindings: dma: Add dma-channel-mask to nvidia,tegra210-adma
>       dmaengine: tegra210-adma: Support dma-channel-mask property
>=20
> Neil Armstrong (1):
>       dt-bindings: dma: qcom,gpi: document the SM8650 GPI DMA Engine
>=20
> Paul Cercueil (5):
>       dmaengine: axi-dmac: Small code cleanup
>       dmaengine: axi-dmac: Allocate hardware descriptors
>       dmaengine: axi-dmac: Add support for scatter-gather transfers
>       dmaengine: axi-dmac: Use only EOT interrupts when doing scatter-gat=
her
>       dmaengine: axi-dmac: Improve cyclic DMA transfers in SG mode
>=20
> Randy Dunlap (1):
>       dmaengine: std_dma40: fix kernel-doc warnings and spelling
>=20
> Rex Zhang (1):
>       dmaengine: idxd: Move dma_free_coherent() out of spinlocked context
>=20
> Rob Herring (1):
>       dt-bindings: dma: Drop undocumented examples
>=20
> Shravan Chippa (3):
>       dmaengine: sf-pdma: Support of_dma_controller_register()
>       dt-bindings: dma: sf-pdma: add new compatible name
>       dmaengine: sf-pdma: add mpfs-pdma compatible name
>=20
> Sibi Sankar (1):
>       dt-bindings: dma: qcom: gpi: add compatible for X1E80100
>=20
> Uwe Kleine-K=F6nig (4):
>       dmaengine: milbeaut-hdmac: Convert to platform remove callback retu=
rning void
>       dmaengine: milbeaut-xdmac: Convert to platform remove callback retu=
rning void
>       dmaengine: uniphier-mdmac: Convert to platform remove callback retu=
rning void
>       dmaengine: uniphier-xdmac: Convert to platform remove callback retu=
rning void
>=20
> Vignesh Raghavendra (5):
>       dt-bindings: dma: ti: k3-*: Add descriptions for register regions
>       dt-bindings: dma: ti: k3-bcdma: Describe cfg register regions
>       dt-bindings: dma: ti: k3-pktdma: Describe cfg register regions
>       dt-bindings: dma: ti: k3-udma: Describe cfg register regions
>       dmaengine: ti: k3-udma: Add PSIL threads for AM62P and J722S
>=20
> Vinod Koul (2):
>       dmaengine: xilinx: xdma: Workaround truncation compilation error
>       dmaengine: xilinx: xdma: statify xdma_prep_interleaved_dma
>=20
>  .../devicetree/bindings/dma/dma-controller.yaml    |  15 -
>  .../devicetree/bindings/dma/dma-router.yaml        |  11 -
>  .../bindings/dma/loongson,ls2x-apbdma.yaml         |  62 ++
>  .../bindings/dma/nvidia,tegra210-adma.yaml         |   3 +
>  .../devicetree/bindings/dma/qcom,gpi.yaml          |   2 +
>  .../devicetree/bindings/dma/renesas,rz-dmac.yaml   |   2 +-
>  .../bindings/dma/sifive,fu540-c000-pdma.yaml       |   1 +
>  .../devicetree/bindings/dma/ti/k3-bcdma.yaml       |  39 +-
>  .../devicetree/bindings/dma/ti/k3-pktdma.yaml      |  26 +-
>  .../devicetree/bindings/dma/ti/k3-udma.yaml        |  20 +-
>  MAINTAINERS                                        |   7 +
>  drivers/dma/Kconfig                                |  14 +
>  drivers/dma/Makefile                               |   1 +
>  drivers/dma/apple-admac.c                          |   5 +-
>  drivers/dma/dma-axi-dmac.c                         | 286 ++++++---
>  drivers/dma/dmaengine.c                            |   3 +
>  drivers/dma/dmatest.c                              |  17 +-
>  drivers/dma/fsl-edma-main.c                        |  17 +-
>  drivers/dma/idxd/cdev.c                            |   4 +-
>  drivers/dma/idxd/device.c                          |   9 +-
>  drivers/dma/ls2x-apb-dma.c                         | 705 +++++++++++++++=
++++++
>  drivers/dma/milbeaut-hdmac.c                       |  17 +-
>  drivers/dma/milbeaut-xdmac.c                       |  17 +-
>  drivers/dma/pl330.c                                |   3 +
>  drivers/dma/sf-pdma/sf-pdma.c                      |  44 +-
>  drivers/dma/sf-pdma/sf-pdma.h                      |   8 +-
>  drivers/dma/ste_dma40.c                            |  12 +-
>  drivers/dma/tegra210-adma.c                        |  35 +-
>  drivers/dma/ti/Makefile                            |   3 +-
>  drivers/dma/ti/k3-psil-am62p.c                     | 325 ++++++++++
>  drivers/dma/ti/k3-psil-priv.h                      |   1 +
>  drivers/dma/ti/k3-psil.c                           |   2 +
>  drivers/dma/ti/k3-udma.c                           |   2 +
>  drivers/dma/uniphier-mdmac.c                       |  17 +-
>  drivers/dma/uniphier-xdmac.c                       |  17 +-
>  drivers/dma/xilinx/xdma-regs.h                     |  30 +-
>  drivers/dma/xilinx/xdma.c                          | 350 +++++++---
>  drivers/dma/xilinx/xilinx_dpdma.c                  |   2 +-
>  include/dt-bindings/dma/fsl-edma.h                 |  21 +
>  39 files changed, 1870 insertions(+), 285 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls2x-a=
pbdma.yaml
>  create mode 100644 drivers/dma/ls2x-apb-dma.c
>  create mode 100644 drivers/dma/ti/k3-psil-am62p.c
>  create mode 100644 include/dt-bindings/dma/fsl-edma.h
> --=20
> ~Vinod



--=20
~Vinod

--miCZTHhWM3lRHzW0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmWsIQsACgkQfBQHDyUj
g0cg4Q//YI2rCXwhyjLozJlTPOf0U4D43sXhXHUeevfU1KZaCL4oomEJ0z0zg2++
VyjDez5gtQ0rBUjbYpPdbnbM16w5EKAn0bOW2MwWegYuOdkXQlV2+PVZxV+ZRGzv
nAkPs4eg+QWQjzqZVKrijzxA/Hq/+GIjC24w1Ys2tehAjZCDAhfJCkMBlwpBZbZX
bUaxNjTtyRv7wJAc3B/VqdS9iXUVO0sOZOV8ywHF32ZnJTcRmaCe9e2TGICx2gfp
sDw1kWH1m+71zsZhhBVVMmg9tygF07+NGu585tabanvIXodl0ESrkqS4apIs0wN6
G2dvyCGKGYoxg9x+SlVUAgQduhb0l3LMeLlSbIt0eiXFJbD7tGYVMnwP2JqbI6M6
Ox3+as1ATHSE4qhQ71Upw1QwuW9uMe+f1Fc0kiiWR/rIYScXgGtImjKg25TeFCQT
0k0t6z6oBgW4Aum3rtq07OKx4TF/fgGtHam0WE+PuYMGdfbkEz405+YiewNlBdTU
dnZ3rQJjhMZJBmUefgzZQbCg0w+qDToQBGGTkcK/+AatCNGIUYu40mccqFh/fld5
JF2I1Z4SfwHIXs+TXIw6sHrwsbG/iqAutrKYCk/i1abpbXgxLycuPWmTDCXovRDp
W9y2M9E8WwdABBaliqBYfop0vkKcjo01x7x5XbBiyFo7O1O9aeY=
=+gve
-----END PGP SIGNATURE-----

--miCZTHhWM3lRHzW0--

