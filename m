Return-Path: <linux-kernel+bounces-62893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A66C852799
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 03:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2461F23AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42600AD49;
	Tue, 13 Feb 2024 02:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="cQtEbAux"
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D128827
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 02:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707792786; cv=none; b=ZV/hadVjtygUUbaXkI8S4nSma4h9vyBtd65GMyMCXChr9/vZQJHafUpPTGX8YYFHedOzPA76udRuQAGg36Bi0nMtyOLIHTq0RaC4HLe9+quFOTVKlzTBhRrJP8K4MoW0V4Sw7pnVQVuUrO6lvM7utIzifCFEmoiGWhEo0zi5Q5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707792786; c=relaxed/simple;
	bh=X6KvAxPIcyQXQMALbknM7FK9qrvEyeidLqjcPyRFd28=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b9+6Zaaw63T1FIeSxoeA6igB18Dt9TF7ySs/98jzTSaJv1BaJ2yE10WTR3eHKaR4Fddacyv2HcxW8YOHwaHQizLHZ92PRwJIb3M0YVZrO+94B0naMGG8/zM3GQYGLvS6H4IPo9vDiRZ3zqG+cdOjimsiA8oFjdY1KRyEFkWvNXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=cQtEbAux; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1707792769;
	bh=X6KvAxPIcyQXQMALbknM7FK9qrvEyeidLqjcPyRFd28=;
	h=Date:From:To:Subject:From;
	b=cQtEbAuxuEuBjx5RYB9JWVE666qrV+kwS9h0/141GAMhKn/rH0JwoxbcVon2e1kQu
	 n+R1SawJRxZw1u8SGOO/lCP1gbmr3w/dPlUWQWcMGatct8DGyPnW534dYVp9uO+EpJ
	 zRQbS/xONDrV5+ILitH92amKzFOGz2VMU1VuW0bUf6BfOymda7zVfCMZQU9bLcizzZ
	 QKCCG/Z8+XlfBe0Xvoat5ZO/C6eONyQQCP6IS9TtAdGYFXqsKXxd3E3VJkn+Ixmjs/
	 Rhj/OpaO3vBAYBwLMECLxoA2Z1f7FqFOf2uxm5YDpfLjIEhovy/Wt9v6HaoRlyPUFn
	 ufue6cImOeYCg==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id F331719FA;
	Tue, 13 Feb 2024 03:52:48 +0100 (CET)
Date: Tue, 13 Feb 2024 03:52:48 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] Fix MODULE_AUTHORs' missing closing >s
Message-ID: <bsr2n4luxzymq2oihn5n4o5m2fvt5rqu7xf6i4iw2iymeenfla@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ehm5ran6wbs7iqvy"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--ehm5ran6wbs7iqvy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When perusing arch/mips/crypto/crc32-mips.c I noticed that Marcin's
MODULE_AUTHOR string was damaged; there's quite a few of these.

Automatically found with
  git grep 'MODULE_AUTHOR.*<[^>]*[^>],'
  git grep 'MODULE_AUTHOR.*<[^>]*[^>]")'
and fixed with
  vi drivers/media/dvb-frontends/dib8000.c
  sed -i '/MODULE_AUTHOR.*<[^>]*[^>]")/s/")/>")/' \
    $(git grep -l 'MODULE_AUTHOR.*<[^>]*[^>]")')

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
Obviously this is like 100 files, so get_maintainer.pl returns 186
addresses (147 personal, 39 lists); cleaving this into 100 patches
or broadcasting this one thusly would get me shot presumably.

I'm thus interpreting the "cannot find a maintainer for the subsystem
you are working on" clause as applicable in this situation, in hopes
you could direct me so as to how best to chop this up, if at all,
and whom best to send this to.

Thanks,

 arch/mips/crypto/crc32-mips.c                            | 2 +-
 arch/powerpc/crypto/aes-gcm-p10-glue.c                   | 2 +-
 drivers/bus/tegra-gmi.c                                  | 2 +-
 drivers/clk/clk-si5351.c                                 | 2 +-
 drivers/clk/clk-versaclock7.c                            | 2 +-
 drivers/clk/ux500/abx500-clk.c                           | 2 +-
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c               | 2 +-
 drivers/cpufreq/kirkwood-cpufreq.c                       | 2 +-
 drivers/cpufreq/raspberrypi-cpufreq.c                    | 2 +-
 drivers/crypto/hisilicon/sec/sec_drv.c                   | 2 +-
 drivers/dma/dw/rzn1-dmamux.c                             | 2 +-
 drivers/firmware/efi/efibc.c                             | 2 +-
 drivers/gpio/gpio-dln2.c                                 | 2 +-
 drivers/gpio/gpio-mpc5200.c                              | 2 +-
 drivers/gpu/drm/i2c/tda998x_drv.c                        | 2 +-
 drivers/gpu/drm/msm/msm_drv.c                            | 2 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                      | 2 +-
 drivers/hid/hid-accutouch.c                              | 2 +-
 drivers/hwmon/emc1403.c                                  | 2 +-
 drivers/hwmon/pmbus/ir35221.c                            | 2 +-
 drivers/iio/adc/at91-sama5d2_adc.c                       | 2 +-
 drivers/iio/adc/cpcap-adc.c                              | 2 +-
 drivers/iio/adc/dln2-adc.c                               | 2 +-
 drivers/iio/adc/twl6030-gpadc.c                          | 2 +-
 drivers/iio/amplifiers/ada4250.c                         | 2 +-
 drivers/iio/dac/ad7293.c                                 | 2 +-
 drivers/iio/dac/max5522.c                                | 2 +-
 drivers/iio/filter/admv8818.c                            | 2 +-
 drivers/iio/frequency/admv1013.c                         | 2 +-
 drivers/iio/frequency/admv1014.c                         | 2 +-
 drivers/iio/frequency/adrf6780.c                         | 2 +-
 drivers/iio/imu/bmi160/bmi160_spi.c                      | 2 +-
 drivers/iio/light/noa1305.c                              | 2 +-
 drivers/iio/magnetometer/bmc150_magn_i2c.c               | 2 +-
 drivers/iio/magnetometer/bmc150_magn_spi.c               | 2 +-
 drivers/input/keyboard/maple_keyb.c                      | 2 +-
 drivers/input/keyboard/qt1050.c                          | 2 +-
 drivers/input/misc/hisi_powerkey.c                       | 2 +-
 drivers/input/misc/tps65219-pwrbutton.c                  | 2 +-
 drivers/input/rmi4/rmi_bus.c                             | 4 ++--
 drivers/input/serio/maceps2.c                            | 2 +-
 drivers/input/touchscreen/lpc32xx_ts.c                   | 2 +-
 drivers/mailbox/mailbox-sti.c                            | 2 +-
 drivers/mailbox/mailbox-test.c                           | 2 +-
 drivers/media/dvb-frontends/dib8000.c                    | 2 +-
 drivers/media/i2c/et8ek8/et8ek8_driver.c                 | 2 +-
 drivers/media/i2c/imx219.c                               | 2 +-
 drivers/media/i2c/ov6650.c                               | 2 +-
 drivers/media/platform/m2m-deinterlace.c                 | 2 +-
 drivers/media/platform/nxp/mx2_emmaprp.c                 | 2 +-
 drivers/media/rc/keymaps/rc-beelink-mxiii.c              | 2 +-
 drivers/media/rc/keymaps/rc-mecool-kii-pro.c             | 2 +-
 drivers/media/rc/keymaps/rc-mecool-kiii-pro.c            | 2 +-
 drivers/media/rc/keymaps/rc-minix-neo.c                  | 2 +-
 drivers/media/rc/keymaps/rc-odroid.c                     | 2 +-
 drivers/media/rc/keymaps/rc-vega-s9x.c                   | 2 +-
 drivers/media/rc/keymaps/rc-wetek-play2.c                | 2 +-
 drivers/media/rc/keymaps/rc-x96max.c                     | 2 +-
 drivers/mfd/mc13xxx-i2c.c                                | 2 +-
 drivers/misc/apds9802als.c                               | 2 +-
 drivers/misc/hmc6352.c                                   | 2 +-
 drivers/mmc/host/dw_mmc-exynos.c                         | 2 +-
 drivers/mtd/parsers/bcm63xxpart.c                        | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c     | 2 +-
 drivers/net/ethernet/ti/netcp_core.c                     | 2 +-
 drivers/net/ethernet/ti/netcp_ethss.c                    | 2 +-
 drivers/net/phy/dp83822.c                                | 2 +-
 drivers/net/phy/dp83867.c                                | 2 +-
 drivers/net/phy/dp83869.c                                | 2 +-
 drivers/net/phy/dp83tc811.c                              | 2 +-
 drivers/net/usb/sr9800.c                                 | 2 +-
 drivers/nvmem/core.c                                     | 4 ++--
 drivers/nvmem/mxs-ocotp.c                                | 2 +-
 drivers/perf/arm_dmc620_pmu.c                            | 2 +-
 drivers/pinctrl/renesas/pinctrl-rza1.c                   | 2 +-
 drivers/platform/x86/asus-tf103c-dock.c                  | 2 +-
 drivers/platform/x86/gpd-pocket-fan.c                    | 2 +-
 drivers/platform/x86/intel/atomisp2/led.c                | 2 +-
 drivers/platform/x86/intel/crystal_cove_charger.c        | 2 +-
 drivers/platform/x86/intel_scu_pltdrv.c                  | 2 +-
 drivers/power/reset/restart-poweroff.c                   | 2 +-
 drivers/power/reset/syscon-reboot-mode.c                 | 2 +-
 drivers/power/supply/ug3105_battery.c                    | 2 +-
 drivers/rtc/rtc-lpc32xx.c                                | 2 +-
 drivers/rtc/rtc-rzn1.c                                   | 4 ++--
 drivers/scsi/device_handler/scsi_dh_hp_sw.c              | 2 +-
 drivers/soc/rockchip/dtpm.c                              | 2 +-
 drivers/spi/atmel-quadspi.c                              | 2 +-
 drivers/spi/spi-microchip-core-qspi.c                    | 2 +-
 drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c | 2 +-
 drivers/tty/serial/8250/8250_men_mcb.c                   | 2 +-
 drivers/video/backlight/as3711_bl.c                      | 2 +-
 drivers/video/backlight/wm831x_bl.c                      | 2 +-
 drivers/watchdog/ath79_wdt.c                             | 4 ++--
 drivers/watchdog/keembay_wdt.c                           | 2 +-
 drivers/watchdog/mt7621_wdt.c                            | 2 +-
 drivers/watchdog/rt2880_wdt.c                            | 2 +-
 drivers/watchdog/visconti_wdt.c                          | 2 +-
 drivers/watchdog/ziirave_wdt.c                           | 2 +-
 sound/soc/codecs/tscs42xx.c                              | 2 +-
 sound/soc/codecs/tscs454.c                               | 2 +-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c          | 2 +-
 sound/soc/qcom/apq8016_sbc.c                             | 2 +-
 sound/soc/qcom/apq8096.c                                 | 2 +-
 sound/soc/qcom/sc8280xp.c                                | 2 +-
 sound/soc/qcom/sm8250.c                                  | 2 +-
 sound/soc/qcom/x1e80100.c                                | 2 +-
 107 files changed, 111 insertions(+), 111 deletions(-)

diff --git a/arch/mips/crypto/crc32-mips.c b/arch/mips/crypto/crc32-mips.c
index ec6d58008f8e..33726bb9a6c6 100644
--- a/arch/mips/crypto/crc32-mips.c
+++ b/arch/mips/crypto/crc32-mips.c
@@ -342,7 +342,7 @@ static void __exit crc32_mod_exit(void)
 	crypto_unregister_shash(&crc32c_alg);
 }
=20
-MODULE_AUTHOR("Marcin Nowakowski <marcin.nowakowski@mips.com");
+MODULE_AUTHOR("Marcin Nowakowski <marcin.nowakowski@mips.com>");
 MODULE_DESCRIPTION("CRC32 and CRC32C using optional MIPS instructions");
 MODULE_LICENSE("GPL v2");
=20
diff --git a/arch/powerpc/crypto/aes-gcm-p10-glue.c b/arch/powerpc/crypto/a=
es-gcm-p10-glue.c
index f62ee54076c0..91ac64a70d28 100644
--- a/arch/powerpc/crypto/aes-gcm-p10-glue.c
+++ b/arch/powerpc/crypto/aes-gcm-p10-glue.c
@@ -26,7 +26,7 @@
 #define GCM_IV_SIZE		12
=20
 MODULE_DESCRIPTION("PPC64le AES-GCM with Stitched implementation");
-MODULE_AUTHOR("Danny Tsen <dtsen@linux.ibm.com");
+MODULE_AUTHOR("Danny Tsen <dtsen@linux.ibm.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS_CRYPTO("aes");
=20
diff --git a/drivers/bus/tegra-gmi.c b/drivers/bus/tegra-gmi.c
index f5d6414df9f2..847d89dcd5ec 100644
--- a/drivers/bus/tegra-gmi.c
+++ b/drivers/bus/tegra-gmi.c
@@ -312,6 +312,6 @@ static struct platform_driver tegra_gmi_driver =3D {
 };
 module_platform_driver(tegra_gmi_driver);
=20
-MODULE_AUTHOR("Mirza Krak <mirza.krak@gmail.com");
+MODULE_AUTHOR("Mirza Krak <mirza.krak@gmail.com>");
 MODULE_DESCRIPTION("NVIDIA Tegra GMI Bus Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index 4ce83c5265b8..e24b364c2cf4 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -1709,6 +1709,6 @@ static struct i2c_driver si5351_driver =3D {
 };
 module_i2c_driver(si5351_driver);
=20
-MODULE_AUTHOR("Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com");
+MODULE_AUTHOR("Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>");
 MODULE_DESCRIPTION("Silicon Labs Si5351A/B/C clock generator driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/clk-versaclock7.c b/drivers/clk/clk-versaclock7.c
index f323263e32c3..646f429bd071 100644
--- a/drivers/clk/clk-versaclock7.c
+++ b/drivers/clk/clk-versaclock7.c
@@ -1305,5 +1305,5 @@ static struct i2c_driver vc7_i2c_driver =3D {
 module_i2c_driver(vc7_i2c_driver);
=20
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Alex Helms <alexander.helms.jy@renesas.com");
+MODULE_AUTHOR("Alex Helms <alexander.helms.jy@renesas.com>");
 MODULE_DESCRIPTION("Renesas Versaclock7 common clock framework driver");
diff --git a/drivers/clk/ux500/abx500-clk.c b/drivers/clk/ux500/abx500-clk.c
index b2ddbf08fca4..871054fccabc 100644
--- a/drivers/clk/ux500/abx500-clk.c
+++ b/drivers/clk/ux500/abx500-clk.c
@@ -121,6 +121,6 @@ static int __init abx500_clk_init(void)
 }
 arch_initcall(abx500_clk_init);
=20
-MODULE_AUTHOR("Ulf Hansson <ulf.hansson@linaro.org");
+MODULE_AUTHOR("Ulf Hansson <ulf.hansson@linaro.org>");
 MODULE_DESCRIPTION("ABX500 clk driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xilin=
x/clk-xlnx-clock-wizard.c
index 6a6e5d9292e8..4e7ae2723530 100644
--- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
@@ -1262,5 +1262,5 @@ static struct platform_driver clk_wzrd_driver =3D {
 module_platform_driver(clk_wzrd_driver);
=20
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Soeren Brinkmann <soren.brinkmann@xilinx.com");
+MODULE_AUTHOR("Soeren Brinkmann <soren.brinkmann@xilinx.com>");
 MODULE_DESCRIPTION("Driver for the Xilinx Clocking Wizard IP core");
diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-=
cpufreq.c
index fd20b986d1f2..255fcf52c82e 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -198,6 +198,6 @@ static struct platform_driver kirkwood_cpufreq_platform=
_driver =3D {
 module_platform_driver(kirkwood_cpufreq_platform_driver);
=20
 MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch");
+MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch>");
 MODULE_DESCRIPTION("cpufreq driver for Marvell's kirkwood CPU");
 MODULE_ALIAS("platform:kirkwood-cpufreq");
diff --git a/drivers/cpufreq/raspberrypi-cpufreq.c b/drivers/cpufreq/raspbe=
rrypi-cpufreq.c
index e0705cc9a57d..3ac5679b60bf 100644
--- a/drivers/cpufreq/raspberrypi-cpufreq.c
+++ b/drivers/cpufreq/raspberrypi-cpufreq.c
@@ -89,7 +89,7 @@ static struct platform_driver raspberrypi_cpufreq_driver =
=3D {
 };
 module_platform_driver(raspberrypi_cpufreq_driver);
=20
-MODULE_AUTHOR("Nicolas Saenz Julienne <nsaenzjulienne@suse.de");
+MODULE_AUTHOR("Nicolas Saenz Julienne <nsaenzjulienne@suse.de>");
 MODULE_DESCRIPTION("Raspberry Pi cpufreq driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:raspberrypi-cpufreq");
diff --git a/drivers/crypto/hisilicon/sec/sec_drv.c b/drivers/crypto/hisili=
con/sec/sec_drv.c
index afdddf87cc34..a28874d59465 100644
--- a/drivers/crypto/hisilicon/sec/sec_drv.c
+++ b/drivers/crypto/hisilicon/sec/sec_drv.c
@@ -1315,5 +1315,5 @@ module_platform_driver(sec_driver);
=20
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("HiSilicon Security Accelerators");
-MODULE_AUTHOR("Zaibo Xu <xuzaibo@huawei.com");
+MODULE_AUTHOR("Zaibo Xu <xuzaibo@huawei.com>");
 MODULE_AUTHOR("Jonathan Cameron <jonathan.cameron@huawei.com>");
diff --git a/drivers/dma/dw/rzn1-dmamux.c b/drivers/dma/dw/rzn1-dmamux.c
index 4fb8508419db..77dcfea5d9f6 100644
--- a/drivers/dma/dw/rzn1-dmamux.c
+++ b/drivers/dma/dw/rzn1-dmamux.c
@@ -156,5 +156,5 @@ static struct platform_driver rzn1_dmamux_driver =3D {
 module_platform_driver(rzn1_dmamux_driver);
=20
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com");
+MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com>");
 MODULE_DESCRIPTION("Renesas RZ/N1 DMAMUX driver");
diff --git a/drivers/firmware/efi/efibc.c b/drivers/firmware/efi/efibc.c
index 4f9fb086eab7..d4215976febc 100644
--- a/drivers/firmware/efi/efibc.c
+++ b/drivers/firmware/efi/efibc.c
@@ -87,6 +87,6 @@ static void __exit efibc_exit(void)
 module_exit(efibc_exit);
=20
 MODULE_AUTHOR("Jeremy Compostella <jeremy.compostella@intel.com>");
-MODULE_AUTHOR("Matt Gumbel <matthew.k.gumbel@intel.com");
+MODULE_AUTHOR("Matt Gumbel <matthew.k.gumbel@intel.com>");
 MODULE_DESCRIPTION("EFI Bootloader Control");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/gpio/gpio-dln2.c b/drivers/gpio/gpio-dln2.c
index 7ead1f51128a..1f2eb9d0caf0 100644
--- a/drivers/gpio/gpio-dln2.c
+++ b/drivers/gpio/gpio-dln2.c
@@ -517,7 +517,7 @@ static struct platform_driver dln2_gpio_driver =3D {
=20
 module_platform_driver(dln2_gpio_driver);
=20
-MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com");
+MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
 MODULE_DESCRIPTION("Driver for the Diolan DLN2 GPIO interface");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:dln2-gpio");
diff --git a/drivers/gpio/gpio-mpc5200.c b/drivers/gpio/gpio-mpc5200.c
index a199dce3394a..c432adea52c4 100644
--- a/drivers/gpio/gpio-mpc5200.c
+++ b/drivers/gpio/gpio-mpc5200.c
@@ -359,6 +359,6 @@ static void __exit mpc52xx_gpio_exit(void)
 module_exit(mpc52xx_gpio_exit);
=20
 MODULE_DESCRIPTION("Freescale MPC52xx gpio driver");
-MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de");
+MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
 MODULE_LICENSE("GPL v2");
=20
diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998=
x_drv.c
index d8d7de18dd65..d38db803adea 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -2110,6 +2110,6 @@ static struct i2c_driver tda998x_driver =3D {
=20
 module_i2c_driver(tda998x_driver);
=20
-MODULE_AUTHOR("Rob Clark <robdclark@gmail.com");
+MODULE_AUTHOR("Rob Clark <robdclark@gmail.com>");
 MODULE_DESCRIPTION("NXP Semiconductors TDA998X HDMI Encoder");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 50b65ffc24b1..a2c5a0b850b2 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1112,6 +1112,6 @@ static void __exit msm_drm_unregister(void)
 module_init(msm_drm_register);
 module_exit(msm_drm_unregister);
=20
-MODULE_AUTHOR("Rob Clark <robdclark@gmail.com");
+MODULE_AUTHOR("Rob Clark <robdclark@gmail.com>");
 MODULE_DESCRIPTION("MSM DRM Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/t=
ilcdc_drv.c
index 23bf16f596f6..8acdfabb8a1e 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -627,6 +627,6 @@ static void __exit tilcdc_drm_fini(void)
 module_init(tilcdc_drm_init);
 module_exit(tilcdc_drm_fini);
=20
-MODULE_AUTHOR("Rob Clark <robdclark@gmail.com");
+MODULE_AUTHOR("Rob Clark <robdclark@gmail.com>");
 MODULE_DESCRIPTION("TI LCD Controller DRM Driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-accutouch.c b/drivers/hid/hid-accutouch.c
index bb6c997e9efd..814aff809d95 100644
--- a/drivers/hid/hid-accutouch.c
+++ b/drivers/hid/hid-accutouch.c
@@ -44,6 +44,6 @@ static struct hid_driver accutouch_driver =3D {
=20
 module_hid_driver(accutouch_driver);
=20
-MODULE_AUTHOR("Martyn Welch <martyn.welch@collabora.co.uk");
+MODULE_AUTHOR("Martyn Welch <martyn.welch@collabora.co.uk>");
 MODULE_DESCRIPTION("Elo Accutouch HID TouchScreen driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index 1332e4ac078c..1c7e277b45cd 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -465,6 +465,6 @@ static struct i2c_driver sensor_emc1403 =3D {
=20
 module_i2c_driver(sensor_emc1403);
=20
-MODULE_AUTHOR("Kalhan Trisal <kalhan.trisal@intel.com");
+MODULE_AUTHOR("Kalhan Trisal <kalhan.trisal@intel.com>");
 MODULE_DESCRIPTION("emc1403 Thermal Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwmon/pmbus/ir35221.c b/drivers/hwmon/pmbus/ir35221.c
index e3ee5c1bd967..5913d48017ee 100644
--- a/drivers/hwmon/pmbus/ir35221.c
+++ b/drivers/hwmon/pmbus/ir35221.c
@@ -142,7 +142,7 @@ static struct i2c_driver ir35221_driver =3D {
=20
 module_i2c_driver(ir35221_driver);
=20
-MODULE_AUTHOR("Samuel Mendoza-Jonas <sam@mendozajonas.com");
+MODULE_AUTHOR("Samuel Mendoza-Jonas <sam@mendozajonas.com>");
 MODULE_DESCRIPTION("PMBus driver for IR35221");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS(PMBUS);
diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama=
5d2_adc.c
index d7fd21e7c6e2..0403d16e709d 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -2635,6 +2635,6 @@ static struct platform_driver at91_adc_driver =3D {
 module_platform_driver(at91_adc_driver)
=20
 MODULE_AUTHOR("Ludovic Desroches <ludovic.desroches@microchip.com>");
-MODULE_AUTHOR("Eugen Hristev <eugen.hristev@microchip.com");
+MODULE_AUTHOR("Eugen Hristev <eugen.hristev@microchip.com>");
 MODULE_DESCRIPTION("Atmel AT91 SAMA5D2 ADC");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
index b6c4ef70484e..26ecfa9a447d 100644
--- a/drivers/iio/adc/cpcap-adc.c
+++ b/drivers/iio/adc/cpcap-adc.c
@@ -1027,5 +1027,5 @@ module_platform_driver(cpcap_adc_driver);
=20
 MODULE_ALIAS("platform:cpcap_adc");
 MODULE_DESCRIPTION("CPCAP ADC driver");
-MODULE_AUTHOR("Tony Lindgren <tony@atomide.com");
+MODULE_AUTHOR("Tony Lindgren <tony@atomide.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index 06cfbbabaf8d..c2bf2d3146fc 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -707,7 +707,7 @@ static struct platform_driver dln2_adc_driver =3D {
=20
 module_platform_driver(dln2_adc_driver);
=20
-MODULE_AUTHOR("Jack Andersen <jackoalan@gmail.com");
+MODULE_AUTHOR("Jack Andersen <jackoalan@gmail.com>");
 MODULE_DESCRIPTION("Driver for the Diolan DLN2 ADC interface");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:dln2-adc");
diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpad=
c.c
index 78bf55438b2c..75ff449de164 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -1016,6 +1016,6 @@ module_platform_driver(twl6030_gpadc_driver);
 MODULE_ALIAS("platform:" DRIVER_NAME);
 MODULE_AUTHOR("Balaji T K <balajitk@ti.com>");
 MODULE_AUTHOR("Graeme Gregory <gg@slimlogic.co.uk>");
-MODULE_AUTHOR("Oleksandr Kozaruk <oleksandr.kozaruk@ti.com");
+MODULE_AUTHOR("Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>");
 MODULE_DESCRIPTION("twl6030 ADC driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/amplifiers/ada4250.c b/drivers/iio/amplifiers/ada4=
250.c
index 4b32d350dc5d..05ad651ec59e 100644
--- a/drivers/iio/amplifiers/ada4250.c
+++ b/drivers/iio/amplifiers/ada4250.c
@@ -398,6 +398,6 @@ static struct spi_driver ada4250_driver =3D {
 };
 module_spi_driver(ada4250_driver);
=20
-MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com");
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
 MODULE_DESCRIPTION("Analog Devices ADA4250");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/dac/ad7293.c b/drivers/iio/dac/ad7293.c
index 06f05750d921..d0c7f0fdb6b6 100644
--- a/drivers/iio/dac/ad7293.c
+++ b/drivers/iio/dac/ad7293.c
@@ -929,6 +929,6 @@ static struct spi_driver ad7293_driver =3D {
 };
 module_spi_driver(ad7293_driver);
=20
-MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com");
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD7293");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/dac/max5522.c b/drivers/iio/dac/max5522.c
index 05034a306597..c6805f35adb5 100644
--- a/drivers/iio/dac/max5522.c
+++ b/drivers/iio/dac/max5522.c
@@ -202,6 +202,6 @@ static struct spi_driver max5522_spi_driver =3D {
 };
 module_spi_driver(max5522_spi_driver);
=20
-MODULE_AUTHOR("Angelo Dureghello <angelo.dureghello@timesys.com");
+MODULE_AUTHOR("Angelo Dureghello <angelo.dureghello@timesys.com>");
 MODULE_DESCRIPTION("MAX5522 DAC driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index 848baa6e3bbf..8c77ade76e7b 100644
--- a/drivers/iio/filter/admv8818.c
+++ b/drivers/iio/filter/admv8818.c
@@ -707,6 +707,6 @@ static struct spi_driver admv8818_driver =3D {
 };
 module_spi_driver(admv8818_driver);
=20
-MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com");
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
 MODULE_DESCRIPTION("Analog Devices ADMV8818");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1=
013.c
index 92923074f930..0894c3a8fd3a 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -655,6 +655,6 @@ static struct spi_driver admv1013_driver =3D {
 };
 module_spi_driver(admv1013_driver);
=20
-MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com");
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
 MODULE_DESCRIPTION("Analog Devices ADMV1013");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/frequency/admv1014.c b/drivers/iio/frequency/admv1=
014.c
index b46b73b89eb7..03e2b3723ecb 100644
--- a/drivers/iio/frequency/admv1014.c
+++ b/drivers/iio/frequency/admv1014.c
@@ -812,6 +812,6 @@ static struct spi_driver admv1014_driver =3D {
 };
 module_spi_driver(admv1014_driver);
=20
-MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com");
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
 MODULE_DESCRIPTION("Analog Devices ADMV1014");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/frequency/adrf6780.c b/drivers/iio/frequency/adrf6=
780.c
index b4defb82f37e..c2da8d973d60 100644
--- a/drivers/iio/frequency/adrf6780.c
+++ b/drivers/iio/frequency/adrf6780.c
@@ -508,6 +508,6 @@ static struct spi_driver adrf6780_driver =3D {
 };
 module_spi_driver(adrf6780_driver);
=20
-MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com");
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
 MODULE_DESCRIPTION("Analog Devices ADRF6780");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/b=
mi160_spi.c
index 8b573ea99af2..b03bc7a521ff 100644
--- a/drivers/iio/imu/bmi160/bmi160_spi.c
+++ b/drivers/iio/imu/bmi160/bmi160_spi.c
@@ -62,7 +62,7 @@ static struct spi_driver bmi160_spi_driver =3D {
 };
 module_spi_driver(bmi160_spi_driver);
=20
-MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com");
+MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
 MODULE_DESCRIPTION("Bosch BMI160 SPI driver");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(IIO_BMI160);
diff --git a/drivers/iio/light/noa1305.c b/drivers/iio/light/noa1305.c
index 1574310020e3..e2d0576ac25c 100644
--- a/drivers/iio/light/noa1305.c
+++ b/drivers/iio/light/noa1305.c
@@ -285,6 +285,6 @@ static struct i2c_driver noa1305_driver =3D {
 module_i2c_driver(noa1305_driver);
=20
 MODULE_AUTHOR("Sergei Miroshnichenko <sergeimir@emcraft.com>");
-MODULE_AUTHOR("Martyn Welch <martyn.welch@collabora.com");
+MODULE_AUTHOR("Martyn Welch <martyn.welch@collabora.com>");
 MODULE_DESCRIPTION("ON Semiconductor NOA1305 ambient light sensor");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/magnetometer/bmc150_magn_i2c.c b/drivers/iio/magne=
tometer/bmc150_magn_i2c.c
index 281d1fa31c8e..7af39ff5da89 100644
--- a/drivers/iio/magnetometer/bmc150_magn_i2c.c
+++ b/drivers/iio/magnetometer/bmc150_magn_i2c.c
@@ -77,7 +77,7 @@ static struct i2c_driver bmc150_magn_driver =3D {
 };
 module_i2c_driver(bmc150_magn_driver);
=20
-MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com");
+MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("BMC150 I2C magnetometer driver");
 MODULE_IMPORT_NS(IIO_BMC150_MAGN);
diff --git a/drivers/iio/magnetometer/bmc150_magn_spi.c b/drivers/iio/magne=
tometer/bmc150_magn_spi.c
index 882987721071..876465595216 100644
--- a/drivers/iio/magnetometer/bmc150_magn_spi.c
+++ b/drivers/iio/magnetometer/bmc150_magn_spi.c
@@ -61,7 +61,7 @@ static struct spi_driver bmc150_magn_spi_driver =3D {
 };
 module_spi_driver(bmc150_magn_spi_driver);
=20
-MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com");
+MODULE_AUTHOR("Daniel Baluta <daniel.baluta@intel.com>");
 MODULE_DESCRIPTION("BMC150 magnetometer SPI driver");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(IIO_BMC150_MAGN);
diff --git a/drivers/input/keyboard/maple_keyb.c b/drivers/input/keyboard/m=
aple_keyb.c
index d08b565be24c..71e15fac83c7 100644
--- a/drivers/input/keyboard/maple_keyb.c
+++ b/drivers/input/keyboard/maple_keyb.c
@@ -19,7 +19,7 @@ static DEFINE_MUTEX(maple_keyb_mutex);
=20
 #define NR_SCANCODES 256
=20
-MODULE_AUTHOR("Adrian McMenamin <adrian@mcmen.demon.co.uk");
+MODULE_AUTHOR("Adrian McMenamin <adrian@mcmen.demon.co.uk>");
 MODULE_DESCRIPTION("SEGA Dreamcast keyboard driver");
 MODULE_LICENSE("GPL");
=20
diff --git a/drivers/input/keyboard/qt1050.c b/drivers/input/keyboard/qt105=
0.c
index b51dfcd76038..30df7b8c2e1e 100644
--- a/drivers/input/keyboard/qt1050.c
+++ b/drivers/input/keyboard/qt1050.c
@@ -593,6 +593,6 @@ static struct i2c_driver qt1050_driver =3D {
=20
 module_i2c_driver(qt1050_driver);
=20
-MODULE_AUTHOR("Marco Felsch <kernel@pengutronix.de");
+MODULE_AUTHOR("Marco Felsch <kernel@pengutronix.de>");
 MODULE_DESCRIPTION("Driver for AT42QT1050 QTouch sensor");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/input/misc/hisi_powerkey.c b/drivers/input/misc/hisi_p=
owerkey.c
index d3c293a95d32..b544d71a5d73 100644
--- a/drivers/input/misc/hisi_powerkey.c
+++ b/drivers/input/misc/hisi_powerkey.c
@@ -124,6 +124,6 @@ static struct platform_driver hi65xx_powerkey_driver =
=3D {
 };
 module_platform_driver(hi65xx_powerkey_driver);
=20
-MODULE_AUTHOR("Zhiliang Xue <xuezhiliang@huawei.com");
+MODULE_AUTHOR("Zhiliang Xue <xuezhiliang@huawei.com>");
 MODULE_DESCRIPTION("Hisi PMIC Power key driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/input/misc/tps65219-pwrbutton.c b/drivers/input/misc/t=
ps65219-pwrbutton.c
index eeb9f2334ab4..76bca6c097e7 100644
--- a/drivers/input/misc/tps65219-pwrbutton.c
+++ b/drivers/input/misc/tps65219-pwrbutton.c
@@ -147,4 +147,4 @@ module_platform_driver(tps65219_pb_driver);
=20
 MODULE_DESCRIPTION("TPS65219 Power Button");
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Markus Schneider-Pargmann <msp@baylibre.com");
+MODULE_AUTHOR("Markus Schneider-Pargmann <msp@baylibre.com>");
diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index 1b45b1d3077d..61ee313219bd 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -472,7 +472,7 @@ static void __exit rmi_bus_exit(void)
 }
 module_exit(rmi_bus_exit);
=20
-MODULE_AUTHOR("Christopher Heiny <cheiny@synaptics.com");
-MODULE_AUTHOR("Andrew Duggan <aduggan@synaptics.com");
+MODULE_AUTHOR("Christopher Heiny <cheiny@synaptics.com>");
+MODULE_AUTHOR("Andrew Duggan <aduggan@synaptics.com>");
 MODULE_DESCRIPTION("RMI bus");
 MODULE_LICENSE("GPL");
diff --git a/drivers/input/serio/maceps2.c b/drivers/input/serio/maceps2.c
index 5ccfb82759b3..c54c12b038cd 100644
--- a/drivers/input/serio/maceps2.c
+++ b/drivers/input/serio/maceps2.c
@@ -21,7 +21,7 @@
 #include <asm/ip32/mace.h>
 #include <asm/ip32/ip32_ints.h>
=20
-MODULE_AUTHOR("Vivien Chappelier <vivien.chappelier@linux-mips.org");
+MODULE_AUTHOR("Vivien Chappelier <vivien.chappelier@linux-mips.org>");
 MODULE_DESCRIPTION("SGI O2 MACE PS2 controller driver");
 MODULE_LICENSE("GPL");
=20
diff --git a/drivers/input/touchscreen/lpc32xx_ts.c b/drivers/input/touchsc=
reen/lpc32xx_ts.c
index 9bad8b93c039..3075c89aa4e4 100644
--- a/drivers/input/touchscreen/lpc32xx_ts.c
+++ b/drivers/input/touchscreen/lpc32xx_ts.c
@@ -339,7 +339,7 @@ static struct platform_driver lpc32xx_ts_driver =3D {
 };
 module_platform_driver(lpc32xx_ts_driver);
=20
-MODULE_AUTHOR("Kevin Wells <kevin.wells@nxp.com");
+MODULE_AUTHOR("Kevin Wells <kevin.wells@nxp.com>");
 MODULE_DESCRIPTION("LPC32XX TSC Driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:lpc32xx_ts");
diff --git a/drivers/mailbox/mailbox-sti.c b/drivers/mailbox/mailbox-sti.c
index b4b5bdd503cf..aac5190918c9 100644
--- a/drivers/mailbox/mailbox-sti.c
+++ b/drivers/mailbox/mailbox-sti.c
@@ -491,5 +491,5 @@ module_platform_driver(sti_mbox_driver);
=20
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("STMicroelectronics Mailbox Controller");
-MODULE_AUTHOR("Lee Jones <lee.jones@linaro.org");
+MODULE_AUTHOR("Lee Jones <lee.jones@linaro.org>");
 MODULE_ALIAS("platform:mailbox-sti");
diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index 3386b4e72551..93139c0b255d 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -447,5 +447,5 @@ static struct platform_driver mbox_test_driver =3D {
 module_platform_driver(mbox_test_driver);
=20
 MODULE_DESCRIPTION("Generic Mailbox Testing Facility");
-MODULE_AUTHOR("Lee Jones <lee.jones@linaro.org");
+MODULE_AUTHOR("Lee Jones <lee.jones@linaro.org>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/media/dvb-frontends/dib8000.c b/drivers/media/dvb-fron=
tends/dib8000.c
index 2f5165918163..91ed027fa11b 100644
--- a/drivers/media/dvb-frontends/dib8000.c
+++ b/drivers/media/dvb-frontends/dib8000.c
@@ -4529,6 +4529,6 @@ void *dib8000_attach(struct dib8000_ops *ops)
 }
 EXPORT_SYMBOL_GPL(dib8000_attach);
=20
-MODULE_AUTHOR("Olivier Grenie <Olivier.Grenie@parrot.com, Patrick Boettche=
r <patrick.boettcher@posteo.de>");
+MODULE_AUTHOR("Olivier Grenie <Olivier.Grenie@parrot.com>, Patrick Boettch=
er <patrick.boettcher@posteo.de>");
 MODULE_DESCRIPTION("Driver for the DiBcom 8000 ISDB-T demodulator");
 MODULE_LICENSE("GPL");
diff --git a/drivers/media/i2c/et8ek8/et8ek8_driver.c b/drivers/media/i2c/e=
t8ek8/et8ek8_driver.c
index f548b1bb75fb..2ad47bb80724 100644
--- a/drivers/media/i2c/et8ek8/et8ek8_driver.c
+++ b/drivers/media/i2c/et8ek8/et8ek8_driver.c
@@ -1523,6 +1523,6 @@ static struct i2c_driver et8ek8_i2c_driver =3D {
=20
 module_i2c_driver(et8ek8_i2c_driver);
=20
-MODULE_AUTHOR("Sakari Ailus <sakari.ailus@iki.fi>, Pavel Machek <pavel@ucw=
=2Ecz");
+MODULE_AUTHOR("Sakari Ailus <sakari.ailus@iki.fi>, Pavel Machek <pavel@ucw=
=2Ecz>");
 MODULE_DESCRIPTION("Toshiba ET8EK8 camera sensor driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index e17ef2e9d9d0..ad42dfed639b 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -1260,6 +1260,6 @@ static struct i2c_driver imx219_i2c_driver =3D {
=20
 module_i2c_driver(imx219_i2c_driver);
=20
-MODULE_AUTHOR("Dave Stevenson <dave.stevenson@raspberrypi.com");
+MODULE_AUTHOR("Dave Stevenson <dave.stevenson@raspberrypi.com>");
 MODULE_DESCRIPTION("Sony IMX219 sensor driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/media/i2c/ov6650.c b/drivers/media/i2c/ov6650.c
index b65befb22a79..2e03df625e5f 100644
--- a/drivers/media/i2c/ov6650.c
+++ b/drivers/media/i2c/ov6650.c
@@ -1145,5 +1145,5 @@ static struct i2c_driver ov6650_i2c_driver =3D {
 module_i2c_driver(ov6650_i2c_driver);
=20
 MODULE_DESCRIPTION("V4L2 subdevice driver for OmniVision OV6650 camera sen=
sor");
-MODULE_AUTHOR("Janusz Krzysztofik <jmkrzyszt@gmail.com");
+MODULE_AUTHOR("Janusz Krzysztofik <jmkrzyszt@gmail.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/media/platform/m2m-deinterlace.c b/drivers/media/platf=
orm/m2m-deinterlace.c
index 96b35a5d6174..d730f513a00e 100644
--- a/drivers/media/platform/m2m-deinterlace.c
+++ b/drivers/media/platform/m2m-deinterlace.c
@@ -20,7 +20,7 @@
 #define MEM2MEM_TEST_MODULE_NAME "mem2mem-deinterlace"
=20
 MODULE_DESCRIPTION("mem2mem device which supports deinterlacing using dmae=
ngine");
-MODULE_AUTHOR("Javier Martin <javier.martin@vista-silicon.com");
+MODULE_AUTHOR("Javier Martin <javier.martin@vista-silicon.com>");
 MODULE_LICENSE("GPL");
 MODULE_VERSION("0.0.1");
=20
diff --git a/drivers/media/platform/nxp/mx2_emmaprp.c b/drivers/media/platf=
orm/nxp/mx2_emmaprp.c
index 023ed40c6b08..1cbb19fd1fda 100644
--- a/drivers/media/platform/nxp/mx2_emmaprp.c
+++ b/drivers/media/platform/nxp/mx2_emmaprp.c
@@ -28,7 +28,7 @@
 #define EMMAPRP_MODULE_NAME "mem2mem-emmaprp"
=20
 MODULE_DESCRIPTION("Mem-to-mem device which supports eMMa-PrP present in m=
x2 SoCs");
-MODULE_AUTHOR("Javier Martin <javier.martin@vista-silicon.com");
+MODULE_AUTHOR("Javier Martin <javier.martin@vista-silicon.com>");
 MODULE_LICENSE("GPL");
 MODULE_VERSION("0.0.1");
=20
diff --git a/drivers/media/rc/keymaps/rc-beelink-mxiii.c b/drivers/media/rc=
/keymaps/rc-beelink-mxiii.c
index 88fad9959a86..a8802bb25e22 100644
--- a/drivers/media/rc/keymaps/rc-beelink-mxiii.c
+++ b/drivers/media/rc/keymaps/rc-beelink-mxiii.c
@@ -54,5 +54,5 @@ module_init(init_rc_map_beelink_mxiii)
 module_exit(exit_rc_map_beelink_mxiii)
=20
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Christian Hewitt <christianshewitt@gmail.com");
+MODULE_AUTHOR("Christian Hewitt <christianshewitt@gmail.com>");
 MODULE_DESCRIPTION("Beelink Mini MXIII remote controller keytable");
diff --git a/drivers/media/rc/keymaps/rc-mecool-kii-pro.c b/drivers/media/r=
c/keymaps/rc-mecool-kii-pro.c
index 273fe1a304f0..619b8ffde8c8 100644
--- a/drivers/media/rc/keymaps/rc-mecool-kii-pro.c
+++ b/drivers/media/rc/keymaps/rc-mecool-kii-pro.c
@@ -88,5 +88,5 @@ module_init(init_rc_map_mecool_kii_pro)
 module_exit(exit_rc_map_mecool_kii_pro)
=20
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Christian Hewitt <christianshewitt@gmail.com");
+MODULE_AUTHOR("Christian Hewitt <christianshewitt@gmail.com>");
 MODULE_DESCRIPTION("Mecool Kii Pro remote controller keytable");
diff --git a/drivers/media/rc/keymaps/rc-mecool-kiii-pro.c b/drivers/media/=
rc/keymaps/rc-mecool-kiii-pro.c
index 53fd7c895ddc..b7065f9cdc61 100644
--- a/drivers/media/rc/keymaps/rc-mecool-kiii-pro.c
+++ b/drivers/media/rc/keymaps/rc-mecool-kiii-pro.c
@@ -85,5 +85,5 @@ module_init(init_rc_map_mecool_kiii_pro)
 module_exit(exit_rc_map_mecool_kiii_pro)
=20
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Christian Hewitt <christianshewitt@gmail.com");
+MODULE_AUTHOR("Christian Hewitt <christianshewitt@gmail.com>");
 MODULE_DESCRIPTION("Mecool Kiii Pro remote controller keytable");
diff --git a/drivers/media/rc/keymaps/rc-minix-neo.c b/drivers/media/rc/key=
maps/rc-minix-neo.c
index ce16e964e72e..8d2f0ce1aeca 100644
--- a/drivers/media/rc/keymaps/rc-minix-neo.c
+++ b/drivers/media/rc/keymaps/rc-minix-neo.c
@@ -52,5 +52,5 @@ module_init(init_rc_map_minix_neo)
 module_exit(exit_rc_map_minix_neo)
=20
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Christian Hewitt <christianshewitt@gmail.com");
+MODULE_AUTHOR("Christian Hewitt <christianshewitt@gmail.com>");
 MODULE_DESCRIPTION("Minix NEO remote controller keytable");
diff --git a/drivers/media/rc/keymaps/rc-odroid.c b/drivers/media/rc/keymap=
s/rc-odroid.c
index 0353229a4915..57c1e0370d5b 100644
--- a/drivers/media/rc/keymaps/rc-odroid.c
+++ b/drivers/media/rc/keymaps/rc-odroid.c
@@ -51,5 +51,5 @@ module_init(init_rc_map_odroid)
 module_exit(exit_rc_map_odroid)
=20
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Christian Hewitt <christianshewitt@gmail.com");
+MODULE_AUTHOR("Christian Hewitt <christianshewitt@gmail.com>");
 MODULE_DESCRIPTION("HardKernel ODROID remote controller keytable");
diff --git a/drivers/media/rc/keymaps/rc-vega-s9x.c b/drivers/media/rc/keym=
aps/rc-vega-s9x.c
index 40fbf408bf65..6d300ec6212f 100644
--- a/drivers/media/rc/keymaps/rc-vega-s9x.c
+++ b/drivers/media/rc/keymaps/rc-vega-s9x.c
@@ -51,5 +51,5 @@ module_init(init_rc_map_vega_s9x)
 module_exit(exit_rc_map_vega_s9x)
=20
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Christian Hewitt <christianshewitt@gmail.com");
+MODULE_AUTHOR("Christian Hewitt <christianshewitt@gmail.com>");
 MODULE_DESCRIPTION("Tronsmart Vega S9x remote controller keytable");
diff --git a/drivers/media/rc/keymaps/rc-wetek-play2.c b/drivers/media/rc/k=
eymaps/rc-wetek-play2.c
index ce3b1029df23..1434d7952492 100644
--- a/drivers/media/rc/keymaps/rc-wetek-play2.c
+++ b/drivers/media/rc/keymaps/rc-wetek-play2.c
@@ -90,5 +90,5 @@ module_init(init_rc_map_wetek_play2)
 module_exit(exit_rc_map_wetek_play2)
=20
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Christian Hewitt <christianshewitt@gmail.com");
+MODULE_AUTHOR("Christian Hewitt <christianshewitt@gmail.com>");
 MODULE_DESCRIPTION("WeTek Play 2 STB remote controller keytable");
diff --git a/drivers/media/rc/keymaps/rc-x96max.c b/drivers/media/rc/keymap=
s/rc-x96max.c
index a22fcbbfa383..1dfbdb4d0d01 100644
--- a/drivers/media/rc/keymaps/rc-x96max.c
+++ b/drivers/media/rc/keymaps/rc-x96max.c
@@ -80,5 +80,5 @@ module_init(init_rc_map_x96max)
 module_exit(exit_rc_map_x96max)
=20
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Christian Hewitt <christianshewitt@gmail.com");
+MODULE_AUTHOR("Christian Hewitt <christianshewitt@gmail.com>");
 MODULE_DESCRIPTION("X96-max STB remote controller keytable");
diff --git a/drivers/mfd/mc13xxx-i2c.c b/drivers/mfd/mc13xxx-i2c.c
index 6bc0e755ba34..adf5f2eec751 100644
--- a/drivers/mfd/mc13xxx-i2c.c
+++ b/drivers/mfd/mc13xxx-i2c.c
@@ -105,5 +105,5 @@ static void __exit mc13xxx_i2c_exit(void)
 module_exit(mc13xxx_i2c_exit);
=20
 MODULE_DESCRIPTION("i2c driver for Freescale MC13XXX PMIC");
-MODULE_AUTHOR("Marc Reilly <marc@cpdesign.com.au");
+MODULE_AUTHOR("Marc Reilly <marc@cpdesign.com.au>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/misc/apds9802als.c b/drivers/misc/apds9802als.c
index 693f0e539f37..14dd48ee9aa8 100644
--- a/drivers/misc/apds9802als.c
+++ b/drivers/misc/apds9802als.c
@@ -303,6 +303,6 @@ static struct i2c_driver apds9802als_driver =3D {
=20
 module_i2c_driver(apds9802als_driver);
=20
-MODULE_AUTHOR("Anantha Narayanan <Anantha.Narayanan@intel.com");
+MODULE_AUTHOR("Anantha Narayanan <Anantha.Narayanan@intel.com>");
 MODULE_DESCRIPTION("Avago apds9802als ALS Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/misc/hmc6352.c b/drivers/misc/hmc6352.c
index 759eaeb64307..6219596f0034 100644
--- a/drivers/misc/hmc6352.c
+++ b/drivers/misc/hmc6352.c
@@ -138,6 +138,6 @@ static struct i2c_driver hmc6352_driver =3D {
=20
 module_i2c_driver(hmc6352_driver);
=20
-MODULE_AUTHOR("Kalhan Trisal <kalhan.trisal@intel.com");
+MODULE_AUTHOR("Kalhan Trisal <kalhan.trisal@intel.com>");
 MODULE_DESCRIPTION("hmc6352 Compass Driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exy=
nos.c
index 698408e8bad0..b6648c5f6183 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -695,6 +695,6 @@ static struct platform_driver dw_mci_exynos_pltfm_drive=
r =3D {
 module_platform_driver(dw_mci_exynos_pltfm_driver);
=20
 MODULE_DESCRIPTION("Samsung Specific DW-MSHC Driver Extension");
-MODULE_AUTHOR("Thomas Abraham <thomas.ab@samsung.com");
+MODULE_AUTHOR("Thomas Abraham <thomas.ab@samsung.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:dwmmc_exynos");
diff --git a/drivers/mtd/parsers/bcm63xxpart.c b/drivers/mtd/parsers/bcm63x=
xpart.c
index 6e7b1ae8f58f..a3b77c565866 100644
--- a/drivers/mtd/parsers/bcm63xxpart.c
+++ b/drivers/mtd/parsers/bcm63xxpart.c
@@ -167,5 +167,5 @@ module_mtd_part_parser(bcm63xx_cfe_parser);
 MODULE_AUTHOR("Daniel Dickinson <openwrt@cshore.neomailbox.net>");
 MODULE_AUTHOR("Florian Fainelli <florian@openwrt.org>");
 MODULE_AUTHOR("Mike Albon <malbon@openwrt.org>");
-MODULE_AUTHOR("Jonas Gorski <jonas.gorski@gmail.com");
+MODULE_AUTHOR("Jonas Gorski <jonas.gorski@gmail.com>");
 MODULE_DESCRIPTION("MTD partitioning for BCM63XX CFE bootloaders");
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c b/drivers=
/net/ethernet/stmicro/stmmac/dwmac-visconti.c
index a5a5cfa989c6..8dd85fc1d6f5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-visconti.c
@@ -278,5 +278,5 @@ module_platform_driver(visconti_eth_dwmac_driver);
=20
 MODULE_AUTHOR("Toshiba");
 MODULE_DESCRIPTION("Toshiba Visconti Ethernet DWMAC glue driver");
-MODULE_AUTHOR("Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp");
+MODULE_AUTHOR("Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti=
/netcp_core.c
index 11b90e1da0c6..719d7ee5c6d5 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -2276,4 +2276,4 @@ module_platform_driver(netcp_driver);
=20
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("TI NETCP driver for Keystone SOCs");
-MODULE_AUTHOR("Sandeep Nair <sandeep_n@ti.com");
+MODULE_AUTHOR("Sandeep Nair <sandeep_n@ti.com>");
diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/t=
i/netcp_ethss.c
index 02cb6474f6dc..0707d982cf62 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -3873,4 +3873,4 @@ module_exit(keystone_gbe_exit);
=20
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("TI NETCP ETHSS driver for Keystone SOCs");
-MODULE_AUTHOR("Sandeep Nair <sandeep_n@ti.com");
+MODULE_AUTHOR("Sandeep Nair <sandeep_n@ti.com>");
diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index b7cb71817780..0ba09ffba42a 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -649,5 +649,5 @@ static struct mdio_device_id __maybe_unused dp83822_tbl=
[] =3D {
 MODULE_DEVICE_TABLE(mdio, dp83822_tbl);
=20
 MODULE_DESCRIPTION("Texas Instruments DP83822 PHY driver");
-MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com");
+MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 5f08f9d38bd7..d6d1e3658514 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -1196,5 +1196,5 @@ static struct mdio_device_id __maybe_unused dp83867_t=
bl[] =3D {
 MODULE_DEVICE_TABLE(mdio, dp83867_tbl);
=20
 MODULE_DESCRIPTION("Texas Instruments DP83867 PHY driver");
-MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com");
+MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index fa8c6fdcf301..763b3d1485cb 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -922,5 +922,5 @@ static struct mdio_device_id __maybe_unused dp83869_tbl=
[] =3D {
 MODULE_DEVICE_TABLE(mdio, dp83869_tbl);
=20
 MODULE_DESCRIPTION("Texas Instruments DP83869 PHY driver");
-MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com");
+MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/net/phy/dp83tc811.c b/drivers/net/phy/dp83tc811.c
index 7ea32fb77190..2fb78072ef34 100644
--- a/drivers/net/phy/dp83tc811.c
+++ b/drivers/net/phy/dp83tc811.c
@@ -410,5 +410,5 @@ static struct mdio_device_id __maybe_unused dp83811_tbl=
[] =3D {
 MODULE_DEVICE_TABLE(mdio, dp83811_tbl);
=20
 MODULE_DESCRIPTION("Texas Instruments DP83TC811 PHY driver");
-MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com");
+MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/usb/sr9800.c b/drivers/net/usb/sr9800.c
index 143bd4ab160d..6b42b963b127 100644
--- a/drivers/net/usb/sr9800.c
+++ b/drivers/net/usb/sr9800.c
@@ -869,7 +869,7 @@ static struct usb_driver sr_driver =3D {
=20
 module_usb_driver(sr_driver);
=20
-MODULE_AUTHOR("Liu Junliang <liujunliang_ljl@163.com");
+MODULE_AUTHOR("Liu Junliang <liujunliang_ljl@163.com>");
 MODULE_VERSION(DRIVER_VERSION);
 MODULE_DESCRIPTION("SR9800 USB 2.0 USB2NET Dev : http://www.corechip-sz.co=
m");
 MODULE_LICENSE("GPL");
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 980123fb4dde..10fa848aa5be 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -2200,6 +2200,6 @@ static void __exit nvmem_exit(void)
 subsys_initcall(nvmem_init);
 module_exit(nvmem_exit);
=20
-MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
-MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com");
+MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org>");
+MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com>");
 MODULE_DESCRIPTION("nvmem Driver Core");
diff --git a/drivers/nvmem/mxs-ocotp.c b/drivers/nvmem/mxs-ocotp.c
index 7b78f18f9545..fa9c69f3ad73 100644
--- a/drivers/nvmem/mxs-ocotp.c
+++ b/drivers/nvmem/mxs-ocotp.c
@@ -190,6 +190,6 @@ static struct platform_driver mxs_ocotp_driver =3D {
 };
=20
 module_platform_driver(mxs_ocotp_driver);
-MODULE_AUTHOR("Stefan Wahren <wahrenst@gmx.net");
+MODULE_AUTHOR("Stefan Wahren <wahrenst@gmx.net>");
 MODULE_DESCRIPTION("driver for OCOTP in i.MX23/i.MX28");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
index 30cea6859574..dc1363c999ac 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -779,5 +779,5 @@ module_init(dmc620_pmu_init);
 module_exit(dmc620_pmu_exit);
=20
 MODULE_DESCRIPTION("Perf driver for the ARM DMC-620 memory controller");
-MODULE_AUTHOR("Tuan Phan <tuanphan@os.amperecomputing.com");
+MODULE_AUTHOR("Tuan Phan <tuanphan@os.amperecomputing.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/renesas/pinctrl-rza1.c b/drivers/pinctrl/renes=
as/pinctrl-rza1.c
index edcbe7c9ad56..ed5b2cc31b3d 100644
--- a/drivers/pinctrl/renesas/pinctrl-rza1.c
+++ b/drivers/pinctrl/renesas/pinctrl-rza1.c
@@ -1404,5 +1404,5 @@ static int __init rza1_pinctrl_init(void)
 }
 core_initcall(rza1_pinctrl_init);
=20
-MODULE_AUTHOR("Jacopo Mondi <jacopo+renesas@jmondi.org");
+MODULE_AUTHOR("Jacopo Mondi <jacopo+renesas@jmondi.org>");
 MODULE_DESCRIPTION("Pin and gpio controller driver for Reneas RZ/A1 SoC");
diff --git a/drivers/platform/x86/asus-tf103c-dock.c b/drivers/platform/x86=
/asus-tf103c-dock.c
index 8f0f87637c5f..e88e07daf5f4 100644
--- a/drivers/platform/x86/asus-tf103c-dock.c
+++ b/drivers/platform/x86/asus-tf103c-dock.c
@@ -938,6 +938,6 @@ static struct i2c_driver tf103c_dock_driver =3D {
 };
 module_i2c_driver(tf103c_dock_driver);
=20
-MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com");
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
 MODULE_DESCRIPTION("X86 Android tablets DSDT fixups driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/gpd-pocket-fan.c b/drivers/platform/x86/g=
pd-pocket-fan.c
index 7a20f68ae206..a23647c41f1e 100644
--- a/drivers/platform/x86/gpd-pocket-fan.c
+++ b/drivers/platform/x86/gpd-pocket-fan.c
@@ -219,6 +219,6 @@ static struct platform_driver gpd_pocket_fan_driver =3D=
 {
 };
=20
 module_platform_driver(gpd_pocket_fan_driver);
-MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com");
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
 MODULE_DESCRIPTION("GPD pocket fan driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/intel/atomisp2/led.c b/drivers/platform/x=
86/intel/atomisp2/led.c
index 10077a61d8c5..fb1cc1a01b94 100644
--- a/drivers/platform/x86/intel/atomisp2/led.c
+++ b/drivers/platform/x86/intel/atomisp2/led.c
@@ -112,6 +112,6 @@ module_exit(atomisp2_led_cleanup);
  * Ensure we are loaded after asus-nb-wmi so that we turn the LED off agai=
n.
  */
 MODULE_SOFTDEP("pre: asus_nb_wmi");
-MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com");
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
 MODULE_DESCRIPTION("Intel atomisp2 camera LED driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/intel/crystal_cove_charger.c b/drivers/pl=
atform/x86/intel/crystal_cove_charger.c
index e4299cfa2205..bbf7dbf60455 100644
--- a/drivers/platform/x86/intel/crystal_cove_charger.c
+++ b/drivers/platform/x86/intel/crystal_cove_charger.c
@@ -148,6 +148,6 @@ static struct platform_driver crystal_cove_charger_driv=
er =3D {
 };
 module_platform_driver(crystal_cove_charger_driver);
=20
-MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com");
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
 MODULE_DESCRIPTION("Intel Bay Trail Crystal Cove external charger IRQ pass=
-through");
 MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/intel_scu_pltdrv.c b/drivers/platform/x86=
/intel_scu_pltdrv.c
index 56ec6ae4c824..9dfd1c0365f3 100644
--- a/drivers/platform/x86/intel_scu_pltdrv.c
+++ b/drivers/platform/x86/intel_scu_pltdrv.c
@@ -54,7 +54,7 @@ static struct platform_driver intel_scu_platform_driver =
=3D {
 module_platform_driver(intel_scu_platform_driver);
=20
 MODULE_AUTHOR("Divya Sasidharan <divya.s.sasidharan@intel.com>");
-MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com");
+MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
 MODULE_AUTHOR("Rajmohan Mani <rajmohan.mani@intel.com>");
 MODULE_DESCRIPTION("Intel SCU platform driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/power/reset/restart-poweroff.c b/drivers/power/reset/r=
estart-poweroff.c
index f4d6004793d3..92a0c472e5bc 100644
--- a/drivers/power/reset/restart-poweroff.c
+++ b/drivers/power/reset/restart-poweroff.c
@@ -55,6 +55,6 @@ static struct platform_driver restart_poweroff_driver =3D=
 {
 };
 module_platform_driver(restart_poweroff_driver);
=20
-MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch");
+MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch>");
 MODULE_DESCRIPTION("restart poweroff driver");
 MODULE_ALIAS("platform:poweroff-restart");
diff --git a/drivers/power/reset/syscon-reboot-mode.c b/drivers/power/reset=
/syscon-reboot-mode.c
index e0772c9f70f7..d0397fa30d01 100644
--- a/drivers/power/reset/syscon-reboot-mode.c
+++ b/drivers/power/reset/syscon-reboot-mode.c
@@ -81,6 +81,6 @@ static struct platform_driver syscon_reboot_mode_driver =
=3D {
 };
 module_platform_driver(syscon_reboot_mode_driver);
=20
-MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com");
+MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com>");
 MODULE_DESCRIPTION("SYSCON reboot mode driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/power/supply/ug3105_battery.c b/drivers/power/supply/u=
g3105_battery.c
index ccc5c4d2e230..e39499068b0a 100644
--- a/drivers/power/supply/ug3105_battery.c
+++ b/drivers/power/supply/ug3105_battery.c
@@ -481,6 +481,6 @@ static struct i2c_driver ug3105_i2c_driver =3D {
 };
 module_i2c_driver(ug3105_i2c_driver);
=20
-MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com");
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
 MODULE_DESCRIPTION("uPI uG3105 battery monitor driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/rtc/rtc-lpc32xx.c b/drivers/rtc/rtc-lpc32xx.c
index 76ad7031a13d..1492c44f1a2f 100644
--- a/drivers/rtc/rtc-lpc32xx.c
+++ b/drivers/rtc/rtc-lpc32xx.c
@@ -354,7 +354,7 @@ static struct platform_driver lpc32xx_rtc_driver =3D {
=20
 module_platform_driver(lpc32xx_rtc_driver);
=20
-MODULE_AUTHOR("Kevin Wells <wellsk40@gmail.com");
+MODULE_AUTHOR("Kevin Wells <wellsk40@gmail.com>");
 MODULE_DESCRIPTION("RTC driver for the LPC32xx SoC");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:rtc-lpc32xx");
diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
index 56ebbd4d0481..498881eca817 100644
--- a/drivers/rtc/rtc-rzn1.c
+++ b/drivers/rtc/rtc-rzn1.c
@@ -413,7 +413,7 @@ static struct platform_driver rzn1_rtc_driver =3D {
 };
 module_platform_driver(rzn1_rtc_driver);
=20
-MODULE_AUTHOR("Michel Pollet <Michel.Pollet@bp.renesas.com");
-MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com");
+MODULE_AUTHOR("Michel Pollet <Michel.Pollet@bp.renesas.com>");
+MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com>");
 MODULE_DESCRIPTION("RZ/N1 RTC driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/scsi/device_handler/scsi_dh_hp_sw.c b/drivers/scsi/dev=
ice_handler/scsi_dh_hp_sw.c
index 944ea4e0cc45..f8ad356d0c6c 100644
--- a/drivers/scsi/device_handler/scsi_dh_hp_sw.c
+++ b/drivers/scsi/device_handler/scsi_dh_hp_sw.c
@@ -264,5 +264,5 @@ module_init(hp_sw_init);
 module_exit(hp_sw_exit);
=20
 MODULE_DESCRIPTION("HP Active/Passive driver");
-MODULE_AUTHOR("Mike Christie <michaelc@cs.wisc.edu");
+MODULE_AUTHOR("Mike Christie <michaelc@cs.wisc.edu>");
 MODULE_LICENSE("GPL");
diff --git a/drivers/soc/rockchip/dtpm.c b/drivers/soc/rockchip/dtpm.c
index b36d4f752c30..6ea9660003e7 100644
--- a/drivers/soc/rockchip/dtpm.c
+++ b/drivers/soc/rockchip/dtpm.c
@@ -62,4 +62,4 @@ MODULE_SOFTDEP("pre: panfrost cpufreq-dt");
 MODULE_DESCRIPTION("Rockchip DTPM driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:dtpm");
-MODULE_AUTHOR("Daniel Lezcano <daniel.lezcano@kernel.org");
+MODULE_AUTHOR("Daniel Lezcano <daniel.lezcano@kernel.org>");
diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 370c4d1572ed..4146d646c38e 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -840,6 +840,6 @@ static struct platform_driver atmel_qspi_driver =3D {
 module_platform_driver(atmel_qspi_driver);
=20
 MODULE_AUTHOR("Cyrille Pitchen <cyrille.pitchen@atmel.com>");
-MODULE_AUTHOR("Piotr Bugalski <bugalski.piotr@gmail.com");
+MODULE_AUTHOR("Piotr Bugalski <bugalski.piotr@gmail.com>");
 MODULE_DESCRIPTION("Atmel QSPI Controller driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microc=
hip-core-qspi.c
index 03d125a71fd9..f9d358e02b3e 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -578,6 +578,6 @@ static struct platform_driver mchp_coreqspi_driver =3D {
 };
 module_platform_driver(mchp_coreqspi_driver);
=20
-MODULE_AUTHOR("Naga Sureshkumar Relli <nagasuresh.relli@microchip.com");
+MODULE_AUTHOR("Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>");
 MODULE_DESCRIPTION("Microchip coreQSPI QSPI controller driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c b/dri=
vers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
index dc519a665c18..45e9ef8c6658 100644
--- a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
+++ b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
@@ -590,6 +590,6 @@ int acpi_thermal_rel_misc_device_remove(acpi_handle han=
dle)
 EXPORT_SYMBOL(acpi_thermal_rel_misc_device_remove);
=20
 MODULE_AUTHOR("Zhang Rui <rui.zhang@intel.com>");
-MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@intel.com");
+MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@intel.com>");
 MODULE_DESCRIPTION("Intel acpi thermal rel misc dev driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/tty/serial/8250/8250_men_mcb.c b/drivers/tty/serial/82=
50/8250_men_mcb.c
index dc9e093b1cb3..1bd3d68778b0 100644
--- a/drivers/tty/serial/8250/8250_men_mcb.c
+++ b/drivers/tty/serial/8250/8250_men_mcb.c
@@ -267,7 +267,7 @@ module_mcb_driver(mcb_driver);
=20
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("MEN 8250 UART driver");
-MODULE_AUTHOR("Michael Moese <michael.moese@men.de");
+MODULE_AUTHOR("Michael Moese <michael.moese@men.de>");
 MODULE_ALIAS("mcb:16z125");
 MODULE_ALIAS("mcb:16z025");
 MODULE_ALIAS("mcb:16z057");
diff --git a/drivers/video/backlight/as3711_bl.c b/drivers/video/backlight/=
as3711_bl.c
index 28437c2da0f5..5f3ecfb2314f 100644
--- a/drivers/video/backlight/as3711_bl.c
+++ b/drivers/video/backlight/as3711_bl.c
@@ -477,6 +477,6 @@ static struct platform_driver as3711_backlight_driver =
=3D {
 module_platform_driver(as3711_backlight_driver);
=20
 MODULE_DESCRIPTION("Backlight Driver for AS3711 PMICs");
-MODULE_AUTHOR("Guennadi Liakhovetski <g.liakhovetski@gmx.de");
+MODULE_AUTHOR("Guennadi Liakhovetski <g.liakhovetski@gmx.de>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:as3711-backlight");
diff --git a/drivers/video/backlight/wm831x_bl.c b/drivers/video/backlight/=
wm831x_bl.c
index c5aaee205bdf..02a7f75b9681 100644
--- a/drivers/video/backlight/wm831x_bl.c
+++ b/drivers/video/backlight/wm831x_bl.c
@@ -211,6 +211,6 @@ static struct platform_driver wm831x_backlight_driver =
=3D {
 module_platform_driver(wm831x_backlight_driver);
=20
 MODULE_DESCRIPTION("Backlight Driver for WM831x PMICs");
-MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com");
+MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:wm831x-backlight");
diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index e5cc30622b12..dd2a116db821 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -317,7 +317,7 @@ static struct platform_driver ath79_wdt_driver =3D {
 module_platform_driver(ath79_wdt_driver);
=20
 MODULE_DESCRIPTION("Atheros AR71XX/AR724X/AR913X hardware watchdog driver"=
);
-MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org");
-MODULE_AUTHOR("Imre Kaloz <kaloz@openwrt.org");
+MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org>");
+MODULE_AUTHOR("Imre Kaloz <kaloz@openwrt.org>");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:" DRIVER_NAME);
diff --git a/drivers/watchdog/keembay_wdt.c b/drivers/watchdog/keembay_wdt.c
index 2a39114dbc64..55d6c21a99fa 100644
--- a/drivers/watchdog/keembay_wdt.c
+++ b/drivers/watchdog/keembay_wdt.c
@@ -292,5 +292,5 @@ static struct platform_driver keembay_wdt_driver =3D {
 module_platform_driver(keembay_wdt_driver);
=20
 MODULE_DESCRIPTION("Intel Keem Bay SoC watchdog driver");
-MODULE_AUTHOR("Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com");
+MODULE_AUTHOR("Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
index 442731bba194..2299d0bebf9a 100644
--- a/drivers/watchdog/mt7621_wdt.c
+++ b/drivers/watchdog/mt7621_wdt.c
@@ -225,5 +225,5 @@ static struct platform_driver mt7621_wdt_driver =3D {
 module_platform_driver(mt7621_wdt_driver);
=20
 MODULE_DESCRIPTION("MediaTek MT762x hardware watchdog driver");
-MODULE_AUTHOR("John Crispin <john@phrozen.org");
+MODULE_AUTHOR("John Crispin <john@phrozen.org>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
index 4499ba0eb5ea..abb88a75c522 100644
--- a/drivers/watchdog/rt2880_wdt.c
+++ b/drivers/watchdog/rt2880_wdt.c
@@ -199,5 +199,5 @@ static struct platform_driver rt288x_wdt_driver =3D {
 module_platform_driver(rt288x_wdt_driver);
=20
 MODULE_DESCRIPTION("MediaTek/Ralink RT288x/RT3xxx hardware watchdog driver=
");
-MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org");
+MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/watchdog/visconti_wdt.c b/drivers/watchdog/visconti_wd=
t.c
index cef0794708e7..24e67c47ae63 100644
--- a/drivers/watchdog/visconti_wdt.c
+++ b/drivers/watchdog/visconti_wdt.c
@@ -176,5 +176,5 @@ static struct platform_driver visconti_wdt_driver =3D {
 module_platform_driver(visconti_wdt_driver);
=20
 MODULE_DESCRIPTION("TOSHIBA Visconti Watchdog Driver");
-MODULE_AUTHOR("Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp");
+MODULE_AUTHOR("Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
index 5ed33df68e9a..6b4da8149064 100644
--- a/drivers/watchdog/ziirave_wdt.c
+++ b/drivers/watchdog/ziirave_wdt.c
@@ -738,6 +738,6 @@ static struct i2c_driver ziirave_wdt_driver =3D {
=20
 module_i2c_driver(ziirave_wdt_driver);
=20
-MODULE_AUTHOR("Martyn Welch <martyn.welch@collabora.co.uk");
+MODULE_AUTHOR("Martyn Welch <martyn.welch@collabora.co.uk>");
 MODULE_DESCRIPTION("Zodiac Aerospace RAVE Switch Watchdog Processor Driver=
");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/tscs42xx.c b/sound/soc/codecs/tscs42xx.c
index 1eefc1fe6ea8..41e9467a8c07 100644
--- a/sound/soc/codecs/tscs42xx.c
+++ b/sound/soc/codecs/tscs42xx.c
@@ -1509,6 +1509,6 @@ static struct i2c_driver tscs42xx_i2c_driver =3D {
=20
 module_i2c_driver(tscs42xx_i2c_driver);
=20
-MODULE_AUTHOR("Tempo Semiconductor <steven.eckhoff.opensource@gmail.com");
+MODULE_AUTHOR("Tempo Semiconductor <steven.eckhoff.opensource@gmail.com>");
 MODULE_DESCRIPTION("ASoC TSCS42xx driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/tscs454.c b/sound/soc/codecs/tscs454.c
index 744aef32a21f..edf40bae65d3 100644
--- a/sound/soc/codecs/tscs454.c
+++ b/sound/soc/codecs/tscs454.c
@@ -3479,6 +3479,6 @@ static struct i2c_driver tscs454_i2c_driver =3D {
=20
 module_i2c_driver(tscs454_i2c_driver);
=20
-MODULE_AUTHOR("Tempo Semiconductor <steven.eckhoff.opensource@gmail.com");
+MODULE_AUTHOR("Tempo Semiconductor <steven.eckhoff.opensource@gmail.com>");
 MODULE_DESCRIPTION("ASoC TSCS454 driver");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/in=
tel/boards/skl_nau88l25_max98357a.c
index 0e7025834594..c3200cd0f1ae 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -699,5 +699,5 @@ module_platform_driver(skylake_audio)
=20
 /* Module information */
 MODULE_DESCRIPTION("Audio Machine driver-NAU88L25 & MAX98357A in I2S mode"=
);
-MODULE_AUTHOR("Rohit Ainapure <rohit.m.ainapure@intel.com");
+MODULE_AUTHOR("Rohit Ainapure <rohit.m.ainapure@intel.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index 4834a56eaa88..a0de77e40ca5 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -342,6 +342,6 @@ static struct platform_driver apq8016_sbc_platform_driv=
er =3D {
 };
 module_platform_driver(apq8016_sbc_platform_driver);
=20
-MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
+MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org>");
 MODULE_DESCRIPTION("APQ8016 ASoC Machine Driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index 4f6594cc723c..c56ca905b1c3 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -140,6 +140,6 @@ static struct platform_driver msm_snd_apq8096_driver =
=3D {
 	},
 };
 module_platform_driver(msm_snd_apq8096_driver);
-MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
+MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org>");
 MODULE_DESCRIPTION("APQ8096 ASoC Machine Driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index b7fd503a1666..65ac389407a0 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -186,6 +186,6 @@ static struct platform_driver snd_sc8280xp_driver =3D {
 	},
 };
 module_platform_driver(snd_sc8280xp_driver);
-MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
+MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org>");
 MODULE_DESCRIPTION("SC8280XP ASoC Machine Driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index d70df72c0160..8615fae177fc 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -180,6 +180,6 @@ static struct platform_driver snd_sm8250_driver =3D {
 	},
 };
 module_platform_driver(snd_sm8250_driver);
-MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
+MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org>");
 MODULE_DESCRIPTION("SM8250 ASoC Machine Driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/x1e80100.c b/sound/soc/qcom/x1e80100.c
index c3c8bf7ffb5b..a5f24365b167 100644
--- a/sound/soc/qcom/x1e80100.c
+++ b/sound/soc/qcom/x1e80100.c
@@ -162,7 +162,7 @@ static struct platform_driver snd_x1e80100_driver =3D {
 	},
 };
 module_platform_driver(snd_x1e80100_driver);
-MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
+MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org>");
 MODULE_AUTHOR("Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>");
 MODULE_DESCRIPTION("Qualcomm X1E80100 ASoC Machine Driver");
 MODULE_LICENSE("GPL");
--=20
2.39.2

--ehm5ran6wbs7iqvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmXK2XwACgkQvP0LAY0m
WPH5WxAAoh9pg55j86tKFiQ2L9YhAMeqWrP42/77/K6Wxi3xNeHB3jGxBCapPYe6
OuwlngPpj9rQ+olg/YxYtvio1JYKVQprfc3RF2bF0NpVMaTfFT4NWBIkoE/ab2Pa
qCKDLvTEo6GwZgatFw+c3b2YcPpkxLXEL9ExCS+gg+8GMvUOXmCBvZ7R6M+R1IKI
H6Pgg148r3Zx8ZpvqpVz+LldCg5bmCzWuXJRmmVH3WWguVQDoARSmsX5kahhOe2s
L73HyJDpFZTBgGl2sjtqyZKDflhWsztksuDoZfxWz4OdflGAGSrM0oird/gy0iED
TmyHOkVMm30zJA3xacIFVb9dDric4Yg5ufBdS0ShTYC+KwHQDw4EJZ0ozcZC0RaY
pFhWhlh6jeFw9n0o7l7Odgct1MjlpgUpV+uyrOcka6fD5aoV0btZ9mTN0KoSuem8
YacUpIqpEkfkkeYJ242igfR77B8LrAAA4Kl3sQ7+iaBFEIkYhf/RVdc6U007dKPI
Ss8UMeyNWf0K3CF8wKI6JTL756o24NvB0V3OGrw4NKziwcLBB6AB0YmmSR43likz
e3qta488W5rr7IyiIJ7+DW/Al45qEBuc8/ZABvRh4nOhZD+1Z3toGyKNN6nDek5L
OA9wA9WElJThooFdL0IKzhr1LkshKFYXIh5JXlOlv9T4lo2o5MY=
=dL5x
-----END PGP SIGNATURE-----

--ehm5ran6wbs7iqvy--

