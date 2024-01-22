Return-Path: <linux-kernel+bounces-33947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2430F837084
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31DFB1C25B41
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB3D57304;
	Mon, 22 Jan 2024 18:10:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3D956B8C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947039; cv=none; b=J8zaAkAfAmSmbTEOOxSqe+CBAd0AuDiGTG+tp5KwuoJWtsaFKYFj+a1ySmmRiKSUg2jub3JVWm/bSqPsx7rHO4zcFf4ZXrs5IZ58GuZ5woTi4BUPdAygJ5Wz3uxMdQZ9qzGEVpSwGoak+AyFtd8JOxl2LqAv7ro+huzYHJuB5hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947039; c=relaxed/simple;
	bh=r4hNLx1axTK9D2SO1h2Nidy6wdhcdwS0oI6JMP4mupU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eFjRB3ZmJFvqSdnEDdEFqAedH7B4BIcRB/9KWB8H4QKxQ2hs625DFBk25YJiP6zfGaaXTps7NhupQsEynooe2W4ybAZ32C65FubwsUApxaunr4CIfh84dY5CZ4ZFTLWfvAvzY5AmCdc74GBntFdFXGrJvTV+qVpH2WPobBikvgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiY-0001lP-N0; Mon, 22 Jan 2024 19:08:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiS-001ePE-PM; Mon, 22 Jan 2024 19:08:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rRyiS-005Zwj-1m;
	Mon, 22 Jan 2024 19:08:12 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: kernel@pengutronix.de,
	Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rayyan Ansari <rayyan@ansari.sh>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	Sergey Kozlov <serjk@netup.ru>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-mmc@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Michal Simek <michal.simek@amd.com>,
	Amit Kumar Mahapatra via Alsa-devel <alsa-devel@alsa-project.org>,
	linux-mtd@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev,
	Max Filippov <jcmvbkbc@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Viresh Kumar <vireshk@kernel.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	greybus-dev@lists.linaro.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-usb@vger.kernel.org,
	Helge Deller <deller@gmx.de>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Kalle Valo <kvalo@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	libertas-dev@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	James Clark <james.clark@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 00/33] spi: get rid of some legacy macros
Date: Mon, 22 Jan 2024 19:06:55 +0100
Message-ID: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5874; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=r4hNLx1axTK9D2SO1h2Nidy6wdhcdwS0oI6JMP4mupU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlrq7CRGL5rco/IZ7baQyO1t3S9it11eXvRLZKR GbQbTfz3/2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZa6uwgAKCRCPgPtYfRL+ TlSmB/4k7WiBaRL3saK9pl+Gkw8Hqk7HVFstVTQ/rkaYbIsJGY0xZw8/1EJjSObFeB+APA4aMQh I79wzfj/BAi6u9wIsVNiQ9y/G7wHtwifXCuuRBAfRSQICGNo++YWb4VjoViqUrlwFz1on55YRHO fF0At9RAUzuTpDwaPQlercYTSV2fRZOyE6oFjYu50ibPS5RDRAlt5RMXKu+KeNvZIt1a7rYblZd 3X+5IV8boWAzqfA2x+ESE9bxy64tcf4U55YuI4LIo7T/6pTUUmJEXiJK3Hqi+KdRcDIt0RoY0Co KLQSX3Yu+cnQoWcdVVqzWe5P2RjCFOxbxIHkvh+IxoWx5PzK
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello,

this is v2 of this patch set.

Changes since (implicit) v1, sent with Message-Id:
cover.1705348269.git.u.kleine-koenig@pengutronix.de:

 - Rebase to v6.8-rc1
 - Fix a build failure on sh
 - Added the tags received in (implicit) v1.

The slave-mt27xx driver needs some more work. The patch presented here
is enough however to get rid of the defines handled in patch 32.
Cleaning that up is out-of-scope for this series, so I'll delay that
until later.

Note that Jonathan Cameron has already applied patch 3 to his tree, it
didn't appear in a public tree though yet. I still included it here to
make the kernel build bots happy.

Best regards
Uwe

Uwe Kleine-König (33):
  fpga: ice40-spi: Follow renaming of SPI "master" to "controller"
  ieee802154: ca8210: Follow renaming of SPI "master" to "controller"
  iio: adc: ad_sigma_delta: Follow renaming of SPI "master" to
    "controller"
  Input: pxspad - follow renaming of SPI "master" to "controller"
  Input: synaptics-rmi4 - follow renaming of SPI "master" to
    "controller"
  media: mgb4: Follow renaming of SPI "master" to "controller"
  media: netup_unidvb: Follow renaming of SPI "master" to "controller"
  media: usb/msi2500: Follow renaming of SPI "master" to "controller"
  media: v4l2-subdev: Follow renaming of SPI "master" to "controller"
  misc: gehc-achc: Follow renaming of SPI "master" to "controller"
  mmc: mmc_spi: Follow renaming of SPI "master" to "controller"
  mtd: dataflash: Follow renaming of SPI "master" to "controller"
  mtd: rawnand: fsl_elbc: Let .probe retry if local bus is missing
  net: ks8851: Follow renaming of SPI "master" to "controller"
  net: vertexcom: mse102x: Follow renaming of SPI "master" to
    "controller"
  platform/chrome: cros_ec_spi: Follow renaming of SPI "master" to
    "controller"
  spi: bitbang: Follow renaming of SPI "master" to "controller"
  spi: cadence-quadspi: Don't emit error message on allocation error
  spi: cadence-quadspi: Follow renaming of SPI "master" to "controller"
  spi: cavium: Follow renaming of SPI "master" to "controller"
  spi: geni-qcom: Follow renaming of SPI "master" to "controller"
  spi: loopback-test: Follow renaming of SPI "master" to "controller"
  spi: slave-mt27xx: Follow renaming of SPI "master" to "controller"
  spi: spidev: Follow renaming of SPI "master" to "controller"
  staging: fbtft: Follow renaming of SPI "master" to "controller"
  staging: greybus: spi: Follow renaming of SPI "master" to "controller"
  tpm_tis_spi: Follow renaming of SPI "master" to "controller"
  usb: gadget: max3420_udc: Follow renaming of SPI "master" to
    "controller"
  video: fbdev: mmp: Follow renaming of SPI "master" to "controller"
  wifi: libertas: Follow renaming of SPI "master" to "controller"
  spi: fsl-lib: Follow renaming of SPI "master" to "controller"
  spi: Drop compat layer from renaming "master" to "controller"
  Documentation: spi: Update documentation for renaming "master" to
    "controller"

 .../driver-api/driver-model/devres.rst        |  2 +-
 Documentation/spi/spi-summary.rst             | 74 +++++++++----------
 drivers/char/tpm/tpm_tis_spi_main.c           |  4 +-
 drivers/fpga/ice40-spi.c                      |  4 +-
 drivers/iio/adc/ad_sigma_delta.c              | 14 ++--
 drivers/input/joystick/psxpad-spi.c           |  4 +-
 drivers/input/rmi4/rmi_spi.c                  |  2 +-
 drivers/media/pci/mgb4/mgb4_core.c            | 14 ++--
 .../media/pci/netup_unidvb/netup_unidvb_spi.c | 48 ++++++------
 drivers/media/usb/msi2500/msi2500.c           | 38 +++++-----
 drivers/media/v4l2-core/v4l2-spi.c            |  4 +-
 drivers/misc/gehc-achc.c                      |  8 +-
 drivers/mmc/host/mmc_spi.c                    |  6 +-
 drivers/mtd/devices/mtd_dataflash.c           |  2 +-
 drivers/mtd/nand/raw/fsl_elbc_nand.c          |  3 +-
 drivers/net/ethernet/micrel/ks8851_spi.c      |  4 +-
 drivers/net/ethernet/vertexcom/mse102x.c      |  2 +-
 drivers/net/ieee802154/ca8210.c               |  2 +-
 .../net/wireless/marvell/libertas/if_spi.c    |  2 +-
 drivers/platform/chrome/cros_ec_spi.c         |  8 +-
 drivers/spi/spi-ath79.c                       |  4 +-
 drivers/spi/spi-bitbang.c                     | 64 ++++++++--------
 drivers/spi/spi-butterfly.c                   |  6 +-
 drivers/spi/spi-cadence-quadspi.c             |  7 +-
 drivers/spi/spi-cavium.c                      |  6 +-
 drivers/spi/spi-cavium.h                      |  2 +-
 drivers/spi/spi-davinci.c                     |  6 +-
 drivers/spi/spi-fsl-lib.c                     | 14 ++--
 drivers/spi/spi-geni-qcom.c                   |  2 +-
 drivers/spi/spi-gpio.c                        |  2 +-
 drivers/spi/spi-lm70llp.c                     |  6 +-
 drivers/spi/spi-loopback-test.c               |  4 +-
 drivers/spi/spi-oc-tiny.c                     |  6 +-
 drivers/spi/spi-omap-uwire.c                  |  4 +-
 drivers/spi/spi-sh-sci.c                      | 10 +--
 drivers/spi/spi-slave-mt27xx.c                |  2 +-
 drivers/spi/spi-xilinx.c                      |  4 +-
 drivers/spi/spi-xtensa-xtfpga.c               |  2 +-
 drivers/spi/spi.c                             |  2 +-
 drivers/spi/spidev.c                          |  2 +-
 drivers/staging/fbtft/fbtft-core.c            |  4 +-
 drivers/staging/greybus/spilib.c              | 66 ++++++++---------
 drivers/usb/gadget/udc/max3420_udc.c          |  2 +-
 drivers/video/fbdev/mmp/hw/mmp_spi.c          | 26 +++----
 include/linux/spi/spi.h                       | 20 +----
 include/linux/spi/spi_bitbang.h               |  2 +-
 include/media/v4l2-common.h                   |  6 +-
 47 files changed, 254 insertions(+), 272 deletions(-)


base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.43.0


