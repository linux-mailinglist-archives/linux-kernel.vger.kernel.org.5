Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096837E02AD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346795AbjKCMQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346710AbjKCMQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:16:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A58B1BC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 05:16:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F46C433C9;
        Fri,  3 Nov 2023 12:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699013798;
        bh=XrPWeVhYl0TEUXPyyTecgEBd5brkr9JxMjfdiT6qgjs=;
        h=Date:From:To:Cc:Subject:From;
        b=qxsbhkVFGXkzVo1UADjEVgD8/vmBmeDRcQAmyjfQG6ZmbP0OnRA5tF+s+hLOfKvhG
         OhEyt7bbfZF5Q+OXH0jzTUU78vsD4J91S23Pixb297+Ux7O5d0Ub/OK1cXG326QzQa
         C0DE1AvAs6o10TUIyRBHCA6sGvvo/wrohZSyOg4v546D2e6DRPQrUwfNSawvubI08t
         VyNiskLyNNiqyHmTvsGhHASp4R76fdQXnylTPER40XfL6OfNW/oQ45REGHLDlfhHMb
         iMul5NoouCYgPnj/z6WHcaVzOvdATwxt1tbp+sBKajshGaENUkDArBPV00fVgbp4Ub
         kkP5blp47xUbQ==
Date:   Fri, 3 Nov 2023 17:46:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v6.7-rc1
Message-ID: <ZUTkosu6RDwHOg2x@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XWV0g3NVByHefFtY"
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XWV0g3NVByHefFtY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive dmaengine updates for this cycle.

This cycle has no new drivers/device supports. It does feature a bunch
of cleanup for __counted_by attribute annotations, platform remove
callback and device tree calls device_get_match_data() usage and
dropping of_match_device(). That takes most of the changes here with
minor driver changes spread across drivers.


The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-6.7-rc1

for you to fetch changes up to 03f25d53b145bc2f7ccc82fc04e4482ed734f524:

  dmaengine: stm32-mdma: correct desc prep when channel running (2023-10-16=
 16:40:38 +0530)

----------------------------------------------------------------
dmaengine updates for v6.7

 Updates:
 - Big pile of __counted_by attribute annotations to several structures
   for bounds checking of flexible arrays at run-time
 - Another big pile platform remove callback returning void changes
 - Device tree device_get_match_data() usage and dropping of_match_device()
   calls
 - Minor driver updates to pxa, idxd fsl, hisi etc drivers

----------------------------------------------------------------
Alain Volmat (1):
      dmaengine: stm32-mdma: correct desc prep when channel running

Christophe JAILLET (2):
      dmaengine: pxa_dma: Remove an erroneous BUG_ON() in pxad_free_desc()
      dmaengine: pxa_dma: Annotate struct pxad_desc_sw with __counted_by

Dan Carpenter (1):
      dmaengine: ti: edma: handle irq_of_parse_and_map() errors

Dave Jiang (2):
      dmaengine: idxd: rate limit printk in misc interrupt thread
      dmaengine: idxd: add wq driver name support for accel-config user tool

Fenghua Yu (1):
      dmaengine: idxd: Register dsa_bus_type before registering idxd sub-dr=
ivers

Frank Li (1):
      MAINTAINERS: Add entries for NXP(Freescale) eDMA drivers

Jinjie Ruan (1):
      dmaengine: fsl-edma: Remove redundant dev_err() for platform_get_irq()

Jonathan Neusch=E4fer (1):
      dmaengine: hisi: Simplify preconditions of CONFIG_K3_DMA

Kaiwei Liu (2):
      dmaengine: sprd: add dma mask interface in probe
      dmaengine: sprd: delete redundant parameter for dma driver function

Kees Cook (22):
      dmaengine: apple-admac: Annotate struct admac_data with __counted_by
      dmaengine: at_hdmac: Annotate struct at_desc with __counted_by
      dmaengine: axi-dmac: Annotate struct axi_dmac_desc with __counted_by
      dmaengine: hisilicon: Annotate struct hisi_dma_dev with __counted_by
      dmaengine: moxart-dma: Annotate struct moxart_desc with __counted_by
      dmaengine: qcom: bam_dma: Annotate struct bam_async_desc with __count=
ed_by
      dmaengine: sa11x0: Annotate struct sa11x0_dma_desc with __counted_by
      dmaengine: sf-pdma: Annotate struct sf_pdma with __counted_by
      dmaengine: sprd: Annotate struct sprd_dma_dev with __counted_by
      dmaengine: st_fdma: Annotate struct st_fdma_desc with __counted_by
      dmaengine: stm32-dma: Annotate struct stm32_dma_desc with __counted_by
      dmaengine: stm32-mdma: Annotate struct stm32_mdma_desc with __counted=
_by
      dmaengine: stm32-mdma: Annotate struct stm32_mdma_device with __count=
ed_by
      dmaengine: tegra: Annotate struct tegra_dma_desc with __counted_by
      dmaengine: tegra210-adma: Annotate struct tegra_adma with __counted_by
      dmaengine: ti: edma: Annotate struct edma_desc with __counted_by
      dmaengine: ti: omap-dma: Annotate struct omap_desc with __counted_by
      dmaengine: uniphier-xdmac: Annotate struct uniphier_xdmac_desc with _=
_counted_by
      dmaengine: uniphier-xdmac: Annotate struct uniphier_xdmac_device with=
 __counted_by
      dmaengine: usb-dmac: Annotate struct usb_dmac_desc with __counted_by
      dmaengine: fsl-edma: Annotate struct struct fsl_edma_engine with __co=
unted_by
      dmaengine: ep93xx_dma: Annotate struct ep93xx_dma_engine with __count=
ed_by

Konrad Dybcio (1):
      dt-bindings: dmaengine: qcom: gpi: Allow dma-coherent

Krzysztof Kozlowski (2):
      dmaengine: qcom: fix Wvoid-pointer-to-enum-cast warning
      dmaengine: mmp: fix Wvoid-pointer-to-enum-cast warning

Li Zetao (2):
      dmaengine: fsl-dpaa2-qdma: Remove redundant initialization owner in d=
paa2_qdma_driver
      dmaengine: xilinx: xdma: Use resource_size() in xdma_probe()

Miquel Raynal (2):
      dmaengine: xilinx: xdma: Prepare the introduction of cyclic transfers
      dmaengine: xilinx: xdma: Support cyclic transfers

Rob Herring (2):
      dmaengine: Use device_get_match_data()
      dmaengine: Drop unnecessary of_match_device() calls

Sergey Khimich (1):
      dmaengine: dw-axi-dmac: Add support DMAX_NUM_CHANNELS > 16

Uwe Kleine-K=F6nig (60):
      dmaengine: altera-msgdma: Convert to platform remove callback returni=
ng void
      dmaengine: apple-admac: Convert to platform remove callback returning=
 void
      dmaengine: at_hdmac: Convert to platform remove callback returning vo=
id
      dmaengine: at_xdmac: Convert to platform remove callback returning vo=
id
      dmaengine: bcm-sba-raid: Convert to platform remove callback returnin=
g void
      dmaengine: bcm2835-dma: Convert to platform remove callback returning=
 void
      dmaengine: bestcomm: bestcomm: Convert to platform remove callback re=
turning void
      dmaengine: dma-axi-dmac: Convert to platform remove callback returnin=
g void
      dmaengine: dma-jz4780: Convert to platform remove callback returning =
void
      dmaengine: dw-axi-dmac: dw-axi-dmac-platform: Convert to platform rem=
ove callback returning void
      dmaengine: dw: platform: Convert to platform remove callback returnin=
g void
      dmaengine: fsl-edma-main: Convert to platform remove callback returni=
ng void
      dmaengine: fsl-qdma: Convert to platform remove callback returning vo=
id
      dmaengine: fsl_raid: Convert to platform remove callback returning vo=
id
      dmaengine: fsldma: Convert to platform remove callback returning void
      dmaengine: idma64: Convert to platform remove callback returning void
      dmaengine: img-mdc-dma: Convert to platform remove callback returning=
 void
      dmaengine: imx-dma: Convert to platform remove callback returning void
      dmaengine: imx-sdma: Convert to platform remove callback returning vo=
id
      dmaengine: k3dma: Convert to platform remove callback returning void
      dmaengine: mcf-edma-main: Convert to platform remove callback returni=
ng void
      dmaengine: mediatek: mtk-cqdma: Convert to platform remove callback r=
eturning void
      dmaengine: mediatek: mtk-hsdma: Convert to platform remove callback r=
eturning void
      dmaengine: mediatek: mtk-uart-apdma: Convert to platform remove callb=
ack returning void
      dmaengine: mmp_pdma: Convert to platform remove callback returning vo=
id
      dmaengine: mmp_tdma: Convert to platform remove callback returning vo=
id
      dmaengine: moxart-dma: Convert to platform remove callback returning =
void
      dmaengine: mpc512x_dma: Convert to platform remove callback returning=
 void
      dmaengine: mv_xor_v2: Convert to platform remove callback returning v=
oid
      dmaengine: nbpfaxi: Convert to platform remove callback returning void
      dmaengine: owl-dma: Convert to platform remove callback returning void
      dmaengine: ppc4xx: adma: Convert to platform remove callback returnin=
g void
      dmaengine: pxa_dma: Convert to platform remove callback returning void
      dmaengine: qcom: bam_dma: Convert to platform remove callback returni=
ng void
      dmaengine: qcom: hidma: Convert to platform remove callback returning=
 void
      dmaengine: qcom: qcom_adm: Convert to platform remove callback return=
ing void
      dmaengine: sa11x0-dma: Convert to platform remove callback returning =
void
      dmaengine: sf-pdma: sf-pdma: Convert to platform remove callback retu=
rning void
      dmaengine: sh: rcar-dmac: Convert to platform remove callback returni=
ng void
      dmaengine: sh: rz-dmac: Convert to platform remove callback returning=
 void
      dmaengine: sh: shdmac: Convert to platform remove callback returning =
void
      dmaengine: sh: usb-dmac: Convert to platform remove callback returnin=
g void
      dmaengine: sprd-dma: Convert to platform remove callback returning vo=
id
      dmaengine: st_fdma: Convert to platform remove callback returning void
      dmaengine: sun4i-dma: Convert to platform remove callback returning v=
oid
      dmaengine: sun6i-dma: Convert to platform remove callback returning v=
oid
      dmaengine: tegra186-gpc-dma: Convert to platform remove callback retu=
rning void
      dmaengine: tegra20-apb-dma: Convert to platform remove callback retur=
ning void
      dmaengine: tegra210-adma: Convert to platform remove callback returni=
ng void
      dmaengine: ti: cppi41: Convert to platform remove callback returning =
void
      dmaengine: ti: edma: Convert to platform remove callback returning vo=
id
      dmaengine: ti: omap-dma: Convert to platform remove callback returnin=
g void
      dmaengine: timb_dma: Convert to platform remove callback returning vo=
id
      dmaengine: txx9dmac: Convert to platform remove callback returning vo=
id
      dmaengine: xgene-dma: Convert to platform remove callback returning v=
oid
      dmaengine: xilinx: xdma: Convert to platform remove callback returnin=
g void
      dmaengine: xilinx: xilinx_dma: Convert to platform remove callback re=
turning void
      dmaengine: xilinx: xilinx_dpdma: Convert to platform remove callback =
returning void
      dmaengine: xilinx: zynqmp_dma: Convert to platform remove callback re=
turning void
      dmaengine: xilinx: xilinx_dma: Fix kernel doc about xilinx_dma_remove=
()

Vinod Koul (1):
      dmaengine: mmp_tdma: drop unused variable 'of_id'

Yue Haibing (1):
      dmaengine: Remove unused declaration dma_chan_cleanup()

 Documentation/ABI/stable/sysfs-driver-dma-idxd     |   6 +
 .../devicetree/bindings/dma/qcom,gpi.yaml          |   2 +
 MAINTAINERS                                        |   8 +
 drivers/dma/Kconfig                                |   2 +-
 drivers/dma/altera-msgdma.c                        |   6 +-
 drivers/dma/apple-admac.c                          |   8 +-
 drivers/dma/at_hdmac.c                             |   8 +-
 drivers/dma/at_xdmac.c                             |   6 +-
 drivers/dma/bcm-sba-raid.c                         |   6 +-
 drivers/dma/bcm2835-dma.c                          |   6 +-
 drivers/dma/bestcomm/bestcomm.c                    |   6 +-
 drivers/dma/dma-axi-dmac.c                         |  11 +-
 drivers/dma/dma-jz4780.c                           |   6 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     | 156 ++++++++++++-----
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h              |   6 +-
 drivers/dma/dw/platform.c                          |   6 +-
 drivers/dma/ep93xx_dma.c                           |   2 +-
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c            |   1 -
 drivers/dma/fsl-edma-common.h                      |   2 +-
 drivers/dma/fsl-edma-main.c                        |  19 +--
 drivers/dma/fsl-qdma.c                             |   5 +-
 drivers/dma/fsl_raid.c                             |   6 +-
 drivers/dma/fsldma.c                               |   6 +-
 drivers/dma/hisi_dma.c                             |   2 +-
 drivers/dma/idma64.c                               |   6 +-
 drivers/dma/idxd/Makefile                          |   6 +-
 drivers/dma/idxd/cdev.c                            |   7 +
 drivers/dma/idxd/dma.c                             |   6 +
 drivers/dma/idxd/idxd.h                            |   9 +
 drivers/dma/idxd/irq.c                             |   4 +-
 drivers/dma/idxd/sysfs.c                           |  34 ++++
 drivers/dma/img-mdc-dma.c                          |   6 +-
 drivers/dma/imx-dma.c                              |   6 +-
 drivers/dma/imx-sdma.c                             |   5 +-
 drivers/dma/k3dma.c                                |  30 ++--
 drivers/dma/mcf-edma-main.c                        |   6 +-
 drivers/dma/mediatek/mtk-cqdma.c                   |   6 +-
 drivers/dma/mediatek/mtk-hsdma.c                   |   6 +-
 drivers/dma/mediatek/mtk-uart-apdma.c              |   6 +-
 drivers/dma/mmp_pdma.c                             |  10 +-
 drivers/dma/mmp_tdma.c                             |  35 +---
 drivers/dma/moxart-dma.c                           |  11 +-
 drivers/dma/mpc512x_dma.c                          |   6 +-
 drivers/dma/mv_xor.c                               |  11 +-
 drivers/dma/mv_xor_v2.c                            |   6 +-
 drivers/dma/nbpfaxi.c                              |   6 +-
 drivers/dma/owl-dma.c                              |   6 +-
 drivers/dma/ppc4xx/adma.c                          |   5 +-
 drivers/dma/pxa_dma.c                              |  26 ++-
 drivers/dma/qcom/bam_dma.c                         |   8 +-
 drivers/dma/qcom/hidma.c                           |   8 +-
 drivers/dma/qcom/qcom_adm.c                        |   6 +-
 drivers/dma/sa11x0-dma.c                           |  12 +-
 drivers/dma/sf-pdma/sf-pdma.c                      |   6 +-
 drivers/dma/sf-pdma/sf-pdma.h                      |   2 +-
 drivers/dma/sh/rcar-dmac.c                         |   6 +-
 drivers/dma/sh/rz-dmac.c                           |   6 +-
 drivers/dma/sh/shdmac.c                            |   6 +-
 drivers/dma/sh/usb-dmac.c                          |   8 +-
 drivers/dma/sprd-dma.c                             |  22 ++-
 drivers/dma/st_fdma.c                              |  18 +-
 drivers/dma/st_fdma.h                              |   2 +-
 drivers/dma/stm32-dma.c                            |  19 +--
 drivers/dma/stm32-mdma.c                           |  13 +-
 drivers/dma/sun4i-dma.c                            |   6 +-
 drivers/dma/sun6i-dma.c                            |   6 +-
 drivers/dma/tegra186-gpc-dma.c                     |   8 +-
 drivers/dma/tegra20-apb-dma.c                      |   6 +-
 drivers/dma/tegra210-adma.c                        |   8 +-
 drivers/dma/ti/cppi41.c                            |   5 +-
 drivers/dma/ti/edma.c                              |  12 +-
 drivers/dma/ti/omap-dma.c                          |  11 +-
 drivers/dma/timb_dma.c                             |   5 +-
 drivers/dma/txx9dmac.c                             |  10 +-
 drivers/dma/uniphier-xdmac.c                       |   8 +-
 drivers/dma/xgene-dma.c                            |   6 +-
 drivers/dma/xilinx/xdma-regs.h                     |   2 +
 drivers/dma/xilinx/xdma.c                          | 187 +++++++++++++++++=
++--
 drivers/dma/xilinx/xilinx_dma.c                    |   8 +-
 drivers/dma/xilinx/xilinx_dpdma.c                  |   6 +-
 drivers/dma/xilinx/zynqmp_dma.c                    |   6 +-
 include/linux/dmaengine.h                          |   2 -
 include/uapi/linux/idxd.h                          |   1 +
 83 files changed, 577 insertions(+), 425 deletions(-)

--=20
~Vinod

--XWV0g3NVByHefFtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmVE5KIACgkQfBQHDyUj
g0cF5w/9HMpb2CkN55n4JweVHI0mXaLMUObWYt6g7ST+pRxJEUZIn/HcjFVtBrSh
NIEICWmJXPCR/kl8bkhUlSPBsRlDJQvx7nuH15eK3iTd9VJyyLfIo3dUCiS0HP63
E/Q+NFtoDA8spX0O0/ipMbF4sPJOGy5Jrtqu9KpB3NFoMcHfM3BOjIgk1O/1uZr7
YrbKgYpBBmi2sn3MBD6DtO3uXrETsNDDBKCgodR3GG7Ll6pQBwFc3HaqECFXS5RD
tMdK8/AvBkFfANTLgLJUh8XsPRfhcLQpXecduvJZFavThCJ7JfNywzcDi/NoKoqB
W9NC2Ef5F1m/HHtq6MWUQtBS2u8KuNw8wVcAAz279e6WXTmkRDYxUbD8tdjZAP2j
fiW5c5rqfTehW6uyYbTyYHpok4hV7l47z5g6LdgIxSepwdBpUIFnqEo1AHPgp9FJ
2J5k6KM/eBHlVUcxEzan9GzdCIjlr/18USeLRQOD5/2WV1X14dJ7muNM4vbPD8XM
YP25vcBvuBOKt/b2K3ccK0YR/wWVoWmeubjJEN2pmf8i323HuQLgDvseQYBhQySx
fyy19FHyezXO5fdJp5iXaLiG32c56jHzKcoxAt7rQWLskEL3kYiS8ElfcouQ9Sg2
NOnPEJOm6zw5zwS8iey7yxfMfriJXEoVmaSf18mv5opKk4MG6Do=
=hlVc
-----END PGP SIGNATURE-----

--XWV0g3NVByHefFtY--
