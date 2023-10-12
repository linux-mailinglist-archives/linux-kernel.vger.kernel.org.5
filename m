Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AEB7C6B73
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377950AbjJLKsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343833AbjJLKsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:48:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5CBE0;
        Thu, 12 Oct 2023 03:48:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C72C433C7;
        Thu, 12 Oct 2023 10:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697107717;
        bh=U0hMGPxYBypB2NvZ8YnTjA9Tbnxy+4MevT22wzxdMqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fZ3HDiLLAGSfZ6Y2dnnBm7WymmTwvDogNkaXgNdniwNDT20AhUxaTGzKQCxyPOqsV
         Wk/lzFF5hMAE0ZqNNWp44NxnrqQvJImI8doFMLFw0kMRTokW7aTBWrukmWSf0Iv86h
         35z/PcAmuesMJRIYgHgQf89dhnUHvo922C2eoKe5low9pLavFUVUfcQmiojabjBHgR
         sXk5+Vwjo6+MuKB/9mOCPHHfhpyfiQ/7OIxnVuO6vZ6KLGdoO59HKWlYwvJ49Ehvjv
         xLQzIr+UHYdg+nwahUF4ZYGtfKwuXFMH23gOdQQXrySwGvNlTUxoziBMxeJydAQok+
         +2YaWZETDSdCQ==
Date:   Thu, 12 Oct 2023 11:48:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-spi@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] spi: bcm2835: add a sentinel at the end of the lookup
 array
Message-ID: <3f57f5d5-85d6-4bad-9e79-ecc7396aac4d@sirena.org.uk>
References: <20231004183906.97845-1-brgl@bgdev.pl>
 <169696282723.222014.3485016870976123694.b4-ty@kernel.org>
 <CAMRc=MenBeJV+p6LirsCfyaPRWfAvSrVQayqUc77KOyvRGMqvQ@mail.gmail.com>
 <f1b8555b-5acb-43cd-b48b-1dfafdb8d27c@sirena.org.uk>
 <CAMRc=MdLXjnYiTjfoKjqAVcLvG5r3p5mWYbSupDM3Di-BAe5eQ@mail.gmail.com>
 <CAMRc=McY2d0tHE18qn5WAPYwTwFn+TVZt48WA-t5tMwzkPsjvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rvXSvR0GYI9eQ1Cu"
Content-Disposition: inline
In-Reply-To: <CAMRc=McY2d0tHE18qn5WAPYwTwFn+TVZt48WA-t5tMwzkPsjvg@mail.gmail.com>
X-Cookie: I've Been Moved!
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rvXSvR0GYI9eQ1Cu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 10:40:53AM +0200, Bartosz Golaszewski wrote:

> Alternatively - if you send your SPI PR to Linus early in the merge
> window, I will send the patch removing gpiochip_find() later on top of
> it?

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-=
bcm2835-sentinel

for you to fetch changes up to 9aaa25df9b02bfe5579cbc9b4cc1177c662ec33f:

  spi: bcm2835: add a sentinel at the end of the lookup array (2023-10-10 1=
3:12:11 +0100)

----------------------------------------------------------------
spi: Share current state with GPIO tree

This is the current state of the SPI tree, shared with the GPIO tree in
order to facilitate some treewide improvements there.  Unfortunaetly the
desire for this treewide work was realised after all the SPI patches had
been applied and there were further dependencies with similar issues
that caused issues trying to pull things out into a minimal branch.

It's expected that this will be merged into Linus' tree as part of the
full SPI pull request before the GPIO changes go in.

----------------------------------------------------------------
Andy Shevchenko (3):
      spidev: Decrease indentation level in spidev_ioctl() SPI_IOC_RD_MODE*
      spidev: Switch to use spi_get_csgpiod()
      spidev: Simplify SPI_IOC_RD_MODE* cases in spidev_ioctl()

Bartosz Golaszewski (2):
      spi: bcm2835: reduce the abuse of the GPIO API
      spi: bcm2835: add a sentinel at the end of the lookup array

Christophe JAILLET (1):
      spi: at91-usart: Remove some dead code

Dhruva Gole (2):
      spi: spi-cadence-quadspi: add runtime pm support
      spi: spi-cadence-quadspi: Fix missing unwind goto warnings

Geert Uytterhoeven (1):
      spi: mpc52xx-psc: Make mpc52xx_psc_spi_transfer_one_message() static

Greg Kroah-Hartman (1):
      spi: spidev: make spidev_class constant

Kees Cook (1):
      spi: mchp-pci1xxxx: Annotate struct pci1xxxx_spi with __counted_by

Li Zetao (25):
      spi: ar934x: Use helper function devm_clk_get_enabled()
      spi: armada-3700: Use helper function devm_clk_get_prepared()
      spi: aspeed: Use helper function devm_clk_get_enabled()
      spi: ath79: Use helper function devm_clk_get_enabled()
      spi: spi-axi-spi-engine: Use helper function devm_clk_get_enabled()
      spi: bcm2835: Use helper function devm_clk_get_enabled()
      spi: bcm2835aux: Use helper function devm_clk_get_enabled()
      spi: spi-cadence: Use helper function devm_clk_get_enabled()
      spi: spi-cavium-thunderx: Use helper function devm_clk_get_enabled()
      spi: davinci: Use helper function devm_clk_get_enabled()
      spi: dw-bt1: Use helper function devm_clk_get_enabled()
      spi: dw-mmio: Use helper function devm_clk_get_*()
      spi: spi-fsl-dspi: Use helper function devm_clk_get_enabled()
      spi: lantiq-ssc: Use helper function devm_clk_get_enabled()
      spi: meson-spicc: Use helper function devm_clk_get_enabled()
      spi: spi-meson-spifc: Use helper function devm_clk_get_enabled()
      spi: microchip-core-qspi: Use helper function devm_clk_get_enabled()
      spi: microchip-core: Use helper function devm_clk_get_enabled()
      spi: mtk-snfi: Use helper function devm_clk_get_enabled()
      spi: npcm-fiu: Use helper function devm_clk_get_enabled()
      spi: orion: Use helper function devm_clk_get_enabled()
      spi: pic32-sqi: Use helper function devm_clk_get_enabled()
      spi: pic32: Use helper function devm_clk_get_enabled()
      spi: spl022: Use helper function devm_clk_get_enabled()
      spi: rockchip: Use helper function devm_clk_get_enabled()

Mark Brown (6):
      spi: sun6i: fix RX data corruption in DMA mode
      Merge existing fixes from spi/for-6.6 into new branch
      spidev: A few cleanups
      spi: switch to use modern name (part3)
      spi: Use devm_clk_get_*() helper function to
      spi: qup: Allow scaling power domains and

Rob Herring (3):
      spi: dt-bindings: arm,pl022: Move child node properties to separate s=
chema
      spi: dt-bindings: st,stm32-spi: Move "st,spi-midi-ns" to spi-peripher=
al-props.yaml
      spi: dt-bindings: Make "additionalProperties: true" explicit

Stephan Gerhold (4):
      spi: dt-bindings: qup: Document power-domains and OPP
      spi: qup: Parse OPP table for DVFS support
      spi: dt-bindings: qup: Document interconnects
      spi: qup: Vote for interconnect bandwidth to DRAM

Uwe Kleine-K=F6nig (1):
      spi: Drop warning from spi_stop_queue()

Vaishnav Achath (1):
      spi: omap2-mcspi: Fix hardcoded reference clock

Vijaya Krishna Nivarthi (1):
      spi: spi-geni-qcom: Rename the label unmap_if_dma

Yang Yingliang (21):
      spi: lm70llp: switch to use modern name
      spi: lp-8841: switch to use modern name
      spi: meson-spicc: switch to use modern name
      spi: meson-spifc: switch to use modern name
      spi: microchip-core-qspi: switch to use modern name
      spi: microchip-core: switch to use modern name
      spi: mpc512x-psc: switch to use modern name
      spi: mpc52xx-psc: switch to use modern name
      spi: mpc52xx: switch to use modern name
      spi: mt65xx: switch to use modern name
      spi: mt7621: switch to use modern name
      spi: mtk-nor: switch to use modern name
      spi: mtk-snfi: switch to use modern name
      spi: mux: switch to use spi_alloc_host()
      spi: mxic: switch to use modern name
      spi: mxs: switch to use modern name
      spi: npcm-pspi: switch to use modern name
      spi: nxp-fspi: switch to use modern name
      spi: oc-tiny: switch to use modern name
      spi: omap-uwire: switch to use modern name
      spi: omap2-mcspi: switch to use modern name

Zhang Shurong (1):
      spi: tegra: Fix missing IRQ check in tegra_slink_probe()

 .../bindings/spi/allwinner,sun4i-a10-spi.yaml      |   2 +
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml      |   2 +
 .../bindings/spi/arm,pl022-peripheral-props.yaml   |  61 +++++
 .../bindings/spi/nvidia,tegra210-quad.yaml         |   1 +
 .../devicetree/bindings/spi/qcom,spi-qup.yaml      |  13 +
 .../devicetree/bindings/spi/rockchip-sfc.yaml      |   2 +
 .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml   |   2 +
 .../bindings/spi/spi-peripheral-props.yaml         |   6 +
 .../devicetree/bindings/spi/spi-pl022.yaml         |  51 ----
 .../devicetree/bindings/spi/st,stm32-spi.yaml      |  20 --
 drivers/spi/spi-ar934x.c                           |  22 +-
 drivers/spi/spi-armada-3700.c                      |  23 +-
 drivers/spi/spi-aspeed-smc.c                       |  16 +-
 drivers/spi/spi-at91-usart.c                       |  22 +-
 drivers/spi/spi-ath79.c                            |  11 +-
 drivers/spi/spi-axi-spi-engine.c                   |  25 +-
 drivers/spi/spi-bcm2835.c                          |  69 +++---
 drivers/spi/spi-bcm2835aux.c                       |  23 +-
 drivers/spi/spi-cadence-quadspi.c                  |  45 +++-
 drivers/spi/spi-cadence.c                          |  23 +-
 drivers/spi/spi-cavium-thunderx.c                  |   8 +-
 drivers/spi/spi-davinci.c                          |  11 +-
 drivers/spi/spi-dw-bt1.c                           |  23 +-
 drivers/spi/spi-dw-mmio.c                          |  31 +--
 drivers/spi/spi-fsl-dspi.c                         |  12 +-
 drivers/spi/spi-geni-qcom.c                        |   6 +-
 drivers/spi/spi-lantiq-ssc.c                       |  10 +-
 drivers/spi/spi-lm70llp.c                          |  20 +-
 drivers/spi/spi-lp8841-rtc.c                       |  56 ++---
 drivers/spi/spi-meson-spicc.c                      | 121 ++++------
 drivers/spi/spi-meson-spifc.c                      |  79 +++----
 drivers/spi/spi-microchip-core-qspi.c              |  39 +--
 drivers/spi/spi-microchip-core.c                   |  83 +++----
 drivers/spi/spi-mpc512x-psc.c                      |  54 ++---
 drivers/spi/spi-mpc52xx-psc.c                      |  38 +--
 drivers/spi/spi-mpc52xx.c                          |  56 ++---
 drivers/spi/spi-mt65xx.c                           | 190 +++++++--------
 drivers/spi/spi-mt7621.c                           |  50 ++--
 drivers/spi/spi-mtk-nor.c                          |  14 +-
 drivers/spi/spi-mtk-snfi.c                         |  67 +-----
 drivers/spi/spi-mux.c                              |   2 +-
 drivers/spi/spi-mxic.c                             |  68 +++---
 drivers/spi/spi-mxs.c                              |  70 +++---
 drivers/spi/spi-npcm-fiu.c                         |  14 +-
 drivers/spi/spi-npcm-pspi.c                        |  68 +++---
 drivers/spi/spi-nxp-fspi.c                         |  30 +--
 drivers/spi/spi-oc-tiny.c                          |  30 +--
 drivers/spi/spi-omap-uwire.c                       |  32 +--
 drivers/spi/spi-omap2-mcspi.c                      | 263 +++++++++++------=
----
 drivers/spi/spi-orion.c                            |  11 +-
 drivers/spi/spi-pci1xxxx.c                         |   2 +-
 drivers/spi/spi-pic32-sqi.c                        |  27 +--
 drivers/spi/spi-pic32.c                            |   8 +-
 drivers/spi/spi-pl022.c                            |  11 +-
 drivers/spi/spi-qup.c                              |  50 +++-
 drivers/spi/spi-rockchip.c                         |  30 +--
 drivers/spi/spi-tegra20-slink.c                    |   2 +
 drivers/spi/spi.c                                  |   4 -
 drivers/spi/spidev.c                               |  42 ++--
 59 files changed, 969 insertions(+), 1202 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/arm,pl022-periphe=
ral-props.yaml

--rvXSvR0GYI9eQ1Cu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUnzv0ACgkQJNaLcl1U
h9B4Wwf/VdovpeQrgbM4wSLy49bYtSVE2XY8F8d+IwzA/VB3yWxtis24a/VX0x9l
OZ7w9LeLR4QZWDfK5WktPGcOPyzC8vQaD951W5mb/+TNjwuDJyUiweRMTQQbagzb
0VR22o8yscatRuMWhKTNhxwqY0rfoX6YxALZ++HoV3ddHJWk90/NnMgvvfoAnlj7
2C5HLM4tnXTGa3LJuhjnE2P67yjekHSXG00Q+xfkXCk9sPVWwkufiRhxZJqOiNl2
PtNb1sQrW9PA9r2H0qta4X5UTiwFC7rLvDvAxV2cs0lh5FvyEzaMJAhmRy2WCW+p
2AIMekTSQH89gLgtBuN42QkqEnR6Gw==
=RkSe
-----END PGP SIGNATURE-----

--rvXSvR0GYI9eQ1Cu--
