Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D266790D57
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 19:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244679AbjICRoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 13:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjICRoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 13:44:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA741ED
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 10:44:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CD19B80D08
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 17:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C684C433C8;
        Sun,  3 Sep 2023 17:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693763048;
        bh=8WvC6PVAxRbmo/gKZY3vVKCcJ7g+qhRKUhSu36otpak=;
        h=Date:From:To:Cc:Subject:From;
        b=rx2OuJksVqoOfLGVdIfiKDRP0CVHN3+DypwxW9fBm2sDVuyILlhlqPUQSPkBJyu0o
         fkDpN/v4a8mcrbgQjB7Ri4fPWYP0fb17JIIbTI65EgUzxHfL+yivIX3b4bs9+miidH
         vXqJu5LYALRqyRsT4Yj1O62er+MrJnbXTwPl2zvQp1M3kL22eBIXy6kC2e5GX/kVz4
         n/45twNn7koKnYFRqKj73K9sjiN7kQUjUq7nBNhznAUp8e3wouZzoOdBSgcz5F/6e0
         +Hsrekx/8coZgKrE/NU98X1v6HoGmXGms1m1umx8jO6HkUfQhkBFhe32gGcLyFZKMD
         JN9To89c7YqTw==
Date:   Sun, 3 Sep 2023 23:14:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v6.6
Message-ID: <ZPTF4zXvA+SRQkkA@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f0KzwFi7IftTnPd0"
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f0KzwFi7IftTnPd0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus

Please pull the dmaengine updates for v6.6. This features couple of new
controller support and updates to drivers.

Please note that there is merge conflict as also reported by linux-next.
The conflict is in drivers/dma/mcf-edma.c between master (fixes were
merged) and next. It should be easy to resolve for you.

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git tags/dm=
aengine-6.6-rc1

for you to fetch changes up to 72f5801a4e2b7122ed8ff5672ea965a0b3458e6b:

  dmaengine: fsl-edma: integrate v3 support (2023-08-22 20:11:03 +0530)

----------------------------------------------------------------
dmaengine updates for v6.6

 New support:
 - Qualcomm SM6115 and QCM2290 dmaengine support
 - at_xdma support for microchip,sam9x7 controller

 Updates:
 - idxd updates for wq simplification and ats knob updates
 - fsl edma updates for v3 support
 - Xilinx AXI4-Stream control support
 - Yaml conversion for bcm dma binding

----------------------------------------------------------------
Bhupesh Sharma (2):
      dt-bindings: dma: Add support for SM6115 and QCM2290 SoCs
      dt-bindings: dma: Increase iommu maxItems for BAM DMA

Biju Das (1):
      dmaengine: sh: rz-dmac: Improve cleanup order in probe()/remove()

Christophe JAILLET (3):
      dmaengine: idxd: No need to clear memory after a dma_alloc_coherent()=
 call
      dmaengine: ep93xx: Use struct_size()
      dmaengine: mcf-edma: Use struct_size()

Fabio Estevam (1):
      dmaengine: ipu: Remove the driver

Fenghua Yu (4):
      dmaengine: idxd: Simplify WQ attribute visibility checks
      dmaengine: idxd: Expose ATS disable knob only when WQ ATS is supported
      dmaengine: idxd: Allow ATS disable update only for configurable devic=
es
      dmaengine: idxd: Fix issues with PRS disable sysfs knob

Frank Li (12):
      dmaengine: fsl-edma: fix build error when arch is s390
      dmaengine: fsl-edma: clean up EXPORT_SYMBOL_GPL in fsl-edma-common.c
      dmaengine: fsl-edma: transition from bool fields to bitmask flags in =
drvdata
      dmaengine: fsl-edma: Remove enum edma_version
      dmaengine: fsl-edma: move common IRQ handler to common.c
      dmaengine: fsl-edma: simply ATTR_DSIZE and ATTR_SSIZE by using ffs()
      dmaengine: fsl-edma: refactor using devm_clk_get_enabled
      dmaengine: fsl-edma: move clearing of register interrupt into setup_i=
rq function
      dmaengine: fsl-edma: refactor chan_name setup and safety
      dmaengine: fsl-edma: move tcd into struct fsl_dma_chan
      dt-bindings: fsl-dma: fsl-edma: add edma3 compatible string
      dmaengine: fsl-edma: integrate v3 support

Hien Huynh (1):
      dmaengine: sh: rz-dmac: Fix destination and source data size setting

Jialin Zhang (1):
      dmaengine: ioatdma: use pci_dev_id() to simplify the code

Johan Hovold (1):
      dmaengine: mediatek: drop bogus pm_runtime_set_active()

Justin Stitt (1):
      dmaengine: owl-dma: fix clang -Wvoid-pointer-to-enum-cast warning

Krzysztof Kozlowski (1):
      dt-bindings: dma: qcom,bam: require one of control methods

Li Zetao (1):
      dmaengine: lgm: Use builtin_platform_driver macro to simplify the code

Radhey Shyam Pandey (7):
      dt-bindings: dmaengine: xilinx_dma:Add xlnx,axistream-connected prope=
rty
      dt-bindings: dmaengine: xilinx_dma: Add xlnx,irq-delay property
      dmaengine: xilinx_dma: Pass AXI4-Stream control words to dma client
      dmaengine: xilinx_dma: Increase AXI DMA transaction segment count
      dmaengine: xilinx_dma: Freeup active list based on descriptor complet=
ion bit
      dmaengine: xilinx_dma: Use tasklet_hi_schedule for timing critical us=
ecase
      dmaengine: xilinx_dma: Program interrupt delay timeout

Rex Zhang (2):
      dmaengine: idxd: Modify the dependence of attribute pasid_enabled
      dmaengine: idxd: Modify ABI documentation for attribute pasid_enabled

Rob Herring (1):
      dmaengine: Explicitly include correct DT includes

Stefan Wahren (1):
      dt-bindings: dma: convert bcm2835-dma bindings to YAML

Uros Bizjak (1):
      dmaengine:idxd: Use local64_try_cmpxchg in perfmon_pmu_event_update

Varshini Rajendran (1):
      dt-bindings: dmaengine: at_xdmac: add compatible with microchip,sam9x7

Yajun Deng (2):
      dmaengine: Simplify dma_async_device_register()
      dmaengine: ioat: fixing the wrong dma_dev->chancnt

Yangtao Li (5):
      dmaengine: qcom: gpi: Use devm_platform_get_and_ioremap_resource()
      dmaengine: qcom_hidma: Use devm_platform_get_and_ioremap_resource()
      dmaengine: qcom: hidma_mgmt: Use devm_platform_get_and_ioremap_resour=
ce()
      dmaengine: shdmac: Convert to devm_platform_ioremap_resource()
      dmaengine: stm32-dma: Use devm_platform_get_and_ioremap_resource()

Yu Liao (1):
      dmaengine: fsl-edma: use struct_size() helper

Yue Haibing (1):
      dmaengine: idxd: Remove unused declarations

Zong Li (1):
      dmaengine: xilinx: dma: remove arch dependency

ruanjinjie (1):
      dmaengine: ste_dma40: Add missing IRQ check in d40_probe

 Documentation/ABI/stable/sysfs-driver-dma-idxd     |    2 +-
 .../devicetree/bindings/dma/atmel-xdma.txt         |    3 +-
 .../devicetree/bindings/dma/brcm,bcm2835-dma.txt   |   83 -
 .../devicetree/bindings/dma/brcm,bcm2835-dma.yaml  |  102 ++
 .../devicetree/bindings/dma/fsl,edma.yaml          |  106 +-
 .../devicetree/bindings/dma/qcom,bam-dma.yaml      |   31 +-
 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |    6 +
 drivers/dma/Kconfig                                |   22 +-
 drivers/dma/Makefile                               |    7 +-
 drivers/dma/apple-admac.c                          |    3 +-
 drivers/dma/at_hdmac.c                             |    2 +-
 drivers/dma/bcm-sba-raid.c                         |    4 +-
 drivers/dma/bestcomm/bestcomm.c                    |    3 +-
 drivers/dma/dma-jz4780.c                           |    1 -
 drivers/dma/dmaengine.c                            |   80 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c     |    1 -
 drivers/dma/dw/rzn1-dmamux.c                       |    4 +-
 drivers/dma/ep93xx_dma.c                           |    4 +-
 drivers/dma/fsl-edma-common.c                      |  305 ++--
 drivers/dma/fsl-edma-common.h                      |  127 +-
 drivers/dma/{fsl-edma.c =3D> fsl-edma-main.c}        |  321 +++-
 drivers/dma/fsl-qdma.c                             |    4 +-
 drivers/dma/fsl_raid.c                             |    3 +-
 drivers/dma/fsldma.c                               |    3 +-
 drivers/dma/idxd/device.c                          |    2 -
 drivers/dma/idxd/idxd.h                            |    5 -
 drivers/dma/idxd/perfmon.c                         |    7 +-
 drivers/dma/idxd/sysfs.c                           |   33 +-
 drivers/dma/img-mdc-dma.c                          |    1 -
 drivers/dma/imx-dma.c                              |    2 +-
 drivers/dma/imx-sdma.c                             |    1 -
 drivers/dma/ioat/dca.c                             |    2 +-
 drivers/dma/ioat/dma.h                             |    1 +
 drivers/dma/ioat/init.c                            |   19 +-
 drivers/dma/ipu/Makefile                           |    2 -
 drivers/dma/ipu/ipu_idmac.c                        | 1801 ----------------=
----
 drivers/dma/ipu/ipu_intern.h                       |  173 --
 drivers/dma/ipu/ipu_irq.c                          |  367 ----
 drivers/dma/lgm/lgm-dma.c                          |    7 +-
 drivers/dma/lpc18xx-dmamux.c                       |    4 +-
 drivers/dma/{mcf-edma.c =3D> mcf-edma-main.c}        |   43 +-
 drivers/dma/mediatek/mtk-cqdma.c                   |    1 -
 drivers/dma/mediatek/mtk-hsdma.c                   |    1 -
 drivers/dma/mediatek/mtk-uart-apdma.c              |    2 -
 drivers/dma/mpc512x_dma.c                          |    4 +-
 drivers/dma/mxs-dma.c                              |    1 -
 drivers/dma/nbpfaxi.c                              |    1 -
 drivers/dma/owl-dma.c                              |    5 +-
 drivers/dma/ppc4xx/adma.c                          |    2 +-
 drivers/dma/qcom/gpi.c                             |    3 +-
 drivers/dma/qcom/hidma.c                           |   14 +-
 drivers/dma/qcom/hidma_mgmt.c                      |    5 +-
 drivers/dma/sh/rz-dmac.c                           |   17 +-
 drivers/dma/sh/shdmac.c                            |    8 +-
 drivers/dma/sprd-dma.c                             |    2 +-
 drivers/dma/ste_dma40.c                            |    4 +
 drivers/dma/stm32-dma.c                            |    3 +-
 drivers/dma/stm32-dmamux.c                         |    4 +-
 drivers/dma/stm32-mdma.c                           |    1 -
 drivers/dma/sun6i-dma.c                            |    2 +-
 drivers/dma/tegra186-gpc-dma.c                     |    2 +-
 drivers/dma/tegra20-apb-dma.c                      |    1 -
 drivers/dma/tegra210-adma.c                        |    3 +-
 drivers/dma/ti/dma-crossbar.c                      |    5 +-
 drivers/dma/ti/edma.c                              |    1 -
 drivers/dma/ti/k3-udma-private.c                   |    2 +
 drivers/dma/ti/k3-udma.c                           |    1 -
 drivers/dma/ti/omap-dma.c                          |    2 +-
 drivers/dma/xgene-dma.c                            |    3 +-
 drivers/dma/xilinx/xilinx_dma.c                    |   74 +-
 drivers/dma/xilinx/zynqmp_dma.c                    |    3 +-
 71 files changed, 1001 insertions(+), 2873 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.=
txt
 create mode 100644 Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.=
yaml
 rename drivers/dma/{fsl-edma.c =3D> fsl-edma-main.c} (62%)
 delete mode 100644 drivers/dma/ipu/Makefile
 delete mode 100644 drivers/dma/ipu/ipu_idmac.c
 delete mode 100644 drivers/dma/ipu/ipu_intern.h
 delete mode 100644 drivers/dma/ipu/ipu_irq.c
 rename drivers/dma/{mcf-edma.c =3D> mcf-edma-main.c} (88%)

--=20
~Vinod

--f0KzwFi7IftTnPd0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmT0xeMACgkQfBQHDyUj
g0fYsQ//a3dHLAYvmiozoLnMA+yxfTSgyAqoDjwap9ylyDHfxPCFrGQMQAGXYCd6
wKaxU0Vs2yc9TacqY3TiuVAKj9vvGIvOXChK+f3fY2EqqgUp1t4KRAtiPyDAPNKF
2tbmf/I48YVYWtuW+zt6ztsGXKDNlCS8P0pkNZLw3mzuD9Wk/N1YdUYzHpRkV7Yk
IugJAZiZ5V1UdT+Fu0wabxBa8f9D8O8kmZcqqNITAEz68oEjkCoqqv+Wc/9clnKm
tG8PHtDgNljF4AKdAD3q6lxy4od36ZUorZtwmdWINKLk8SSdmqR1QkM6FsJHr6te
cClbspSpeuChkodb/8PnCcP5un4z1TYlbyQsg53YsThcSlvhCzT3r8vusQSyIOD4
QdmH4WpKC86KiLPrPCfXxerIKpHvE9N5TxKc4ixs6mqWZ0ETpKl2ERNMhju1ThL2
QwE0Ee8UtSlUxrHeUhfTnAIqHHxsc1fjbAbqd8ge8wTPHoxxWxz6XpKuCfrraBkf
ZDIgk7qE6iEFhX2dPpnKDRHp1iryr4CYW8Wr8lR/yaNd+ahkqxHYA/PAhLD7TYcT
bMOICGXqnG8LkUeFgphfUbgvbzQ4hUNDBhtA2KyTHQ7wPkgEX6cBoJakbaIl0+MN
pRTyxUw1BD54/Nd/MfW2JYVNxKreiEi7VMOO9cIGHU6IGu+x2YM=
=w+ID
-----END PGP SIGNATURE-----

--f0KzwFi7IftTnPd0--
