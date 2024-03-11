Return-Path: <linux-kernel+bounces-98597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B93877C71
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834861F2117C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B680517548;
	Mon, 11 Mar 2024 09:16:14 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDC1168AC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148573; cv=none; b=IosOsRVrWtLVB4J9gNBmzXngXkFq2ncVUFcQQ9shHZ9d+JabL80Lm9j4j7d76pWLFar83cllvlMcopBDKc+17ATWLyNmLVZ1/4xnQ7lTYnFztK6XB+uoJ/d5Mp+b/oNgMhSsXCYVTI9ph0eKuPfzNyPgSTpLOL5423HkyCuWJjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148573; c=relaxed/simple;
	bh=cRhkn1hTNK7xxJq3ckHCLXxZk6505CjEZ4WEJvG5wYA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fzFjiqJ+L+SQRV+QIB1xyWsCoR7yYBDSjRE2dPHjV0HDl4tWtdhNJrsIsBHAzQONLPKu+YsiW4IDlFmPtWByvEIQcM30Zbx83mHbcwt3ilKWVZGsjVTRxfLbyeMWFABvvqzRwxawJtI66mtwnJESpVNjb2yg08NzZoM6d0Lr+aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjblP-0004v3-Ay; Mon, 11 Mar 2024 10:16:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjblN-005gOy-4q; Mon, 11 Mar 2024 10:16:05 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjblN-003wDY-0C;
	Mon, 11 Mar 2024 10:16:05 +0100
Date: Mon, 11 Mar 2024 10:16:04 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
	Dharma Balasubiramani <dharma.b@microchip.com>, Dong Aisheng <aisheng.dong@nxp.com>, 
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, Jerome Brunet <jbrunet@baylibre.com>, 
	Raag Jadav <raag.jadav@intel.com>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: [GIT PULL] pwm: Changes for v6.9-rc1
Message-ID: <ebsgtolipefn2id5vvxxhga6de7gvatfmzvehu5fj5dxl45j7z@yp2jcj4njfht>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hvojzqbxhauy3rne"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--hvojzqbxhauy3rne
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

the following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-6.9-rc1

for you to fetch changes up to dd6c6d57ab61d496f6ff7d6ca38611062af142a1:

  pwm: imx-tpm: fix probe crash due to access registers without clock (2024=
-03-04 11:45:22 +0100)

----------------------------------------------------------------
pwm: Changes for v6.9-rc1

This contains the usual amount of driver and device tree changes.
Additionally there is a big rework of how pwm lowlevel drivers are
registered to prepare adding character device support.

Thanks to Dharma Balasubiramani, Dong Aisheng, Duje Mihanovi=C4=87, Jerome
Brunet, Raag Jadav and Rafa=C5=82 Mi=C5=82ecki for their contributions. And=
 sorry
for those who still need some patience because I didn't manage to empty
my review queue.

----------------------------------------------------------------
Dharma Balasubiramani (1):
      dt-bindings: atmel,hlcdc: convert pwm bindings to json-schema

Dong Aisheng (1):
      pwm: imx-tpm: fix probe crash due to access registers without clock

Duje Mihanovi=C4=87 (1):
      dt-bindings: pxa-pwm: Convert to YAML

Jerome Brunet (3):
      dt-bindings: pwm: amlogic: fix s4 bindings
      dt-bindings: pwm: amlogic: Add a new binding for meson8 pwm types
      pwm: meson: generalize 4 inputs clock on meson8 pwm type

Raag Jadav (5):
      pwm: dwc: use pm_sleep_ptr() macro
      pwm: dwc: access driver_data using dev_get_drvdata()
      pwm: dwc: drop redundant error check
      pwm: dwc: Add 16 channel support for Intel Elkhart Lake
      pwm: dwc: simplify error handling

Rafa=C5=82 Mi=C5=82ecki (2):
      dt-bindings: pwm: mediatek,mt2712: add compatible for MT7988
      pwm: mediatek: add support for MT7988

Uwe Kleine-K=C3=B6nig (172):
      pwm: atmel-hlcdc: Fix clock imbalance related to suspend support
      pwm: sti: Fix capture for st,pwm-num-chan < st,capture-num-chan
      pwm: Drop useless member .of_pwm_n_cells of struct pwm_chip
      pwm: Let the of_xlate callbacks accept references without period
      pwm: clps711x: Drop custom .of_xlate() callback
      pwm: Drop duplicate check against chip->npwm in of_pwm_xlate_with_fla=
gs()
      pwm: mediatek: Update kernel doc for struct pwm_mediatek_of_data
      pwm: Reorder symbols in core.c
      pwm: bcm2835: Drop write-only member of driver private data
      pwm: atmel-hlcdc: Don't use pwm consumer API
      pwm: atmel: Don't use pwm consumer API
      pwm: imx27: Don't use pwm consumer API
      pwm: Provide an inline function to get the parent device of a given c=
hip
      pwm: Provide wrappers for storing and getting driver private data
      pwm: Provide pwmchip_alloc() function and a devm variant of it
      pwm: ab8500: Make use of pwmchip_parent() accessor
      pwm: ab8500: Introduce a local pwm_chip variable in .probe()
      pwm: ab8500: Make use of devm_pwmchip_alloc() function
      pwm: apple: Make use of devm_pwmchip_alloc() function
      pwm: atmel: Change prototype of a helper to prepare further changes
      pwm: atmel: Make use of pwmchip_parent() accessor
      pwm: atmel: Make use of devm_pwmchip_alloc() function
      pwm: atmel-hlcdc: Prepare removing pwm_chip from driver data
      pwm: atmel-hlcdc: Make use of devm_pwmchip_alloc() function
      pwm: atmel-tcb: Make use of pwmchip_parent() accessor
      pwm: atmel-tcb: Prepare removing pwm_chip from driver data
      pwm: atmel-tcb: Make use of devm_pwmchip_alloc() function
      pwm: bcm2835: Make use of devm_pwmchip_alloc() function
      pwm: bcm-iproc: Make use of devm_pwmchip_alloc() function
      pwm: bcm-kona: Make use of pwmchip_parent() accessor
      pwm: bcm-kona: Make use of devm_pwmchip_alloc() function
      pwm: berlin: Prepare removing pwm_chip from driver data
      pwm: berlin: Make use of devm_pwmchip_alloc() function
      pwm: brcmstb: Make use of devm_pwmchip_alloc() function
      pwm: clk: Prepare removing pwm_chip from driver data
      pwm: clk: Make use of devm_pwmchip_alloc() function
      pwm: clps711x: Make use of devm_pwmchip_alloc() function
      pwm: crc: Simplify code to determine the pwmchip's parent device
      pwm: crc: Make use of pwmchip_parent() accessor
      pwm: crc: Make use of devm_pwmchip_alloc() function
      pwm: cros-ec: Change prototype of helpers to prepare further changes
      pwm: cros-ec: Make use of pwmchip_parent() accessor
      pwm: cros-ec: Make use of devm_pwmchip_alloc() function
      pwm: dwc: Prepare removing pwm_chip from driver data
      pwm: dwc: Make use of devm_pwmchip_alloc() function
      pwm: dwc-core: Make use of pwmchip_parent() accessor
      pwm: ep93xx: Make use of pwmchip_parent() accessor
      pwm: ep93xx: Make use of devm_pwmchip_alloc() function
      pwm: fsl-ftm: Change prototype of a helper to prepare further changes
      pwm: fsl-ftm: Make use of pwmchip_parent() accessor
      pwm: fsl-ftm: Prepare removing pwm_chip from driver data
      pwm: fsl-ftm: Make use of devm_pwmchip_alloc() function
      pwm: hibvt: Consistently name driver data hi_pwm_chip
      pwm: hibvt: Make use of devm_pwmchip_alloc() function
      pwm: img: Drop write-only variable from driver private data
      pwm: img: Make use of pwmchip_parent() accessor
      pwm: img: Prepare removing pwm_chip from driver data
      pwm: img: Make use of devm_pwmchip_alloc() function
      pwm: imx1: Make use of devm_pwmchip_alloc() function
      pwm: imx27: Make use of pwmchip_parent() accessor
      pwm: imx27: Make use of devm_pwmchip_alloc() function
      pwm: imx-tpm: Make use of devm_pwmchip_alloc() function
      pwm: intel-lgm: Make use of devm_pwmchip_alloc() function
      pwm: iqs620a: Create a wrapper for converting a pwm_chip to driver da=
ta
      pwm: iqs620a: Prepare removing pwm_chip from driver data
      pwm: iqs620a: Make use of devm_pwmchip_alloc() function
      pwm: jz4740: Change prototype of a helper to prepare further changes
      pwm: jz4740: Make use of pwmchip_parent() accessor
      pwm: jz4740: Make use of devm_pwmchip_alloc() function
      pwm: keembay: Make use of devm_pwmchip_alloc() function
      pwm: lp3943: Make use of devm_pwmchip_alloc() function
      pwm: lpc18xx-sct: Drop hardly used member from driver private data
      pwm: lpc18xx-sct: Make use of pwmchip_parent() accessor
      pwm: lpc18xx-sct: Prepare removing pwm_chip from driver data
      pwm: lpc18xx-sct: Make use of devm_pwmchip_alloc() function
      pwm: lpc32xx: Make use of devm_pwmchip_alloc() function
      pwm: lpss: Make use of pwmchip_parent() accessor
      pwm: lpss-*: Don't set driver data
      pwm: lpss-*: Make use of devm_pwmchip_alloc() function
      pwm: mediatek: Make use of pwmchip_parent() accessor
      pwm: mediatek: Make use of devm_pwmchip_alloc() function
      pwm: meson: Change prototype of a few helpers to prepare further chan=
ges
      pwm: meson: Make use of pwmchip_parent() accessor
      pwm: meson: Make use of devm_pwmchip_alloc() function
      pwm: microchip-core: Make use of devm_pwmchip_alloc() function
      pwm: mtk-disp: Make use of pwmchip_parent() accessor
      pwm: mtk-disp: Make use of devm_pwmchip_alloc() function
      pwm: mxs: Make use of devm_pwmchip_alloc() function
      pwm: ntxec: Make use of devm_pwmchip_alloc() function
      pwm: omap-dmtimer: Make use of pwmchip_parent() accessor
      pwm: omap-dmtimer: Prepare removing pwm_chip from driver data
      pwm: omap-dmtimer: Make use of devm_pwmchip_alloc() function
      pwm: pca9685: Prepare removing pwm_chip from driver data
      pwm: pca9685: Make use of pwmchip_parent() accessor
      pwm: pca9685: Make use of devm_pwmchip_alloc() function
      pwm: pxa: Make use of devm_pwmchip_alloc() function
      pwm: raspberrypi-poe: Make use of pwmchip_parent() accessor
      pwm: raspberrypi-poe: Make use of devm_pwmchip_alloc() function
      pwm: rcar: Make use of pwmchip_parent() accessor
      pwm: rcar: Prepare removing pwm_chip from driver data
      pwm: rcar: Make use of devm_pwmchip_alloc() function
      pwm: renesas-tpu: Make use of devm_pwmchip_alloc() function
      pwm: rochchip: Prepare removing pwm_chip from driver data
      pwm: rockchip: Make use of devm_pwmchip_alloc() function
      pwm: rz-mtu3: Make use of pwmchip_parent() accessor
      pwm: rz-mtu3: Prepare removing pwm_chip from driver data
      pwm: rz-mtu3: Make use of devm_pwmchip_alloc() function
      pwm: samsung: Simplify code to determine the pwmchip's parent device
      pwm: samsung: Change prototype of helpers to prepare further changes
      pwm: samsung: Make use of pwmchip_parent() accessor
      pwm: samsung: Simplify by using devm functions in probe
      pwm: samsung: Simplify using dev_err_probe()
      pwm: samsung: Make use of devm_pwmchip_alloc() function
      pwm: sifive: Simplify code to determine the pwmchip's parent device
      pwm: sifive: Prepare removing pwm_chip from driver data
      pwm: sifive: Make use of pwmchip_parent() accessor
      pwm: sifive: Make use of devm_pwmchip_alloc() function
      pwm: sl28cpld: Make use of devm_pwmchip_alloc() function
      pwm: spear: Make use of devm_pwmchip_alloc() function
      pwm: sprd: Rework how the available channels are counted
      pwm: sprd: Drop duplicated tracking of the parent device
      pwm: sprd: Make use of devm_pwmchip_alloc() function
      pwm: sti: Prepare removing pwm_chip from driver data
      pwm: sti: Make use of devm_pwmchip_alloc() function
      pwm: stm32: Simplify code to determine the pwmchip's parent device
      pwm: stm32: Change prototype of a helper to prepare further changes
      pwm: stm32: Prepare removing pwm_chip from driver data
      pwm: stm32: Change prototype of helper that detects npwm to prepare f=
urther changes
      pwm: stm32: Make use of devm_pwmchip_alloc() function
      pwm: stm32-lp: Simplify code to determine the pwmchip's parent device
      pwm: stm32-lp: Prepare removing pwm_chip from driver data
      pwm: stm32-lp: Make use of pwmchip_parent() accessor
      pwm: stm32-lp: Make use of devm_pwmchip_alloc() function
      pwm: stmpe: Make use of pwmchip_parent() accessor
      pwm: stmpe: Make use of devm_pwmchip_alloc() function
      pwm: sun4i: Make use of pwmchip_parent() accessor
      pwm: sun4i: Prepare removing pwm_chip from driver data
      pwm: sun4i: Consistently name driver data sun4ichip
      pwm: sun4i: Make use of devm_pwmchip_alloc() function
      pwm: sunplus: Make use of devm_pwmchip_alloc() function
      pwm: tegra: Drop duplicated tracking of the parent device
      pwm: tegra: Prepare removing pwm_chip from driver data
      pwm: tegra: Make use of devm_pwmchip_alloc() function
      pwm: tiecap: Simplify code to determine the pwmchip's parent device
      pwm: tiecap: Change prototype of helpers to prepare further changes
      pwm: tiecap: Make use of pwmchip_parent() accessor
      pwm: tiecap: Make use of devm_pwmchip_alloc() function
      pwm: tiehrpwm: Simplify code to determine the pwmchip's parent device
      pwm: tiehrpwm: Change prototype of helpers to prepare further changes
      pwm: tiehrpwm: Make use of pwmchip_parent() accessor
      pwm: tiehrpwm: Make use of devm_pwmchip_alloc() function
      pwm: twl: Make use of pwmchip_parent() accessor
      pwm: twl: Make use of devm_pwmchip_alloc() function
      pwm: twl-led: Make use of pwmchip_parent() accessor
      pwm: twl-led: Make use of devm_pwmchip_alloc() function
      pwm: visconti: Make use of devm_pwmchip_alloc() function
      pwm: vt8500: Change prototype of a helper to prepare further changes
      pwm: vt8500: Introduce a local pwm_chip variable in .probe()
      pwm: vt8500: Make use of pwmchip_parent() accessor
      pwm: vt8500: Make use of devm_pwmchip_alloc() function
      pwm: xilinx: Prepare removing pwm_chip from driver data
      pwm: xilinx: Make use of devm_pwmchip_alloc() function
      gpio: mvebu: Make use of devm_pwmchip_alloc() function
      drm/bridge: ti-sn65dsi86: Make use of pwmchip_parent() accessor
      drm/bridge: ti-sn65dsi86: Make use of devm_pwmchip_alloc() function
      leds: qcom-lpg: Make use of devm_pwmchip_alloc() function
      staging: greybus: pwm: Change prototype of helpers to prepare further=
 changes
      staging: greybus: pwm: Make use of pwmchip_parent() accessor
      staging: greybus: pwm: Rely on pwm framework to pass a valid hwpwm
      staging: greybus: pwm: Drop unused gb_connection_set_data()
      staging: greybus: pwm: Rework how the number of PWM lines is determin=
ed
      staging: greybus: pwm: Make use of devm_pwmchip_alloc() function

 .../devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml   |  35 +
 .../devicetree/bindings/pwm/atmel-hlcdc-pwm.txt    |  29 -
 .../devicetree/bindings/pwm/marvell,pxa-pwm.yaml   |  51 ++
 .../bindings/pwm/mediatek,mt2712-pwm.yaml          |   1 +
 .../devicetree/bindings/pwm/pwm-amlogic.yaml       | 115 +++-
 Documentation/devicetree/bindings/pwm/pxa-pwm.txt  |  30 -
 Documentation/driver-api/driver-model/devres.rst   |   1 +
 Documentation/driver-api/pwm.rst                   |  11 +-
 drivers/gpio/gpio-mvebu.c                          |  18 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |  32 +-
 drivers/leds/rgb/leds-qcom-lpg.c                   |  16 +-
 drivers/pinctrl/intel/pinctrl-intel.c              |   6 +-
 drivers/pwm/core.c                                 | 724 +++++++++++------=
----
 drivers/pwm/pwm-ab8500.c                           |  36 +-
 drivers/pwm/pwm-apple.c                            |  18 +-
 drivers/pwm/pwm-atmel-hlcdc.c                      |  42 +-
 drivers/pwm/pwm-atmel-tcb.c                        |  32 +-
 drivers/pwm/pwm-atmel.c                            |  47 +-
 drivers/pwm/pwm-bcm-iproc.c                        |  19 +-
 drivers/pwm/pwm-bcm-kona.c                         |  23 +-
 drivers/pwm/pwm-bcm2835.c                          |  22 +-
 drivers/pwm/pwm-berlin.c                           |  29 +-
 drivers/pwm/pwm-brcmstb.c                          |  17 +-
 drivers/pwm/pwm-clk.c                              |  27 +-
 drivers/pwm/pwm-clps711x.c                         |  28 +-
 drivers/pwm/pwm-crc.c                              |  22 +-
 drivers/pwm/pwm-cros-ec.c                          |  59 +-
 drivers/pwm/pwm-dwc-core.c                         |  26 +-
 drivers/pwm/pwm-dwc.c                              |  77 ++-
 drivers/pwm/pwm-dwc.h                              |  14 +-
 drivers/pwm/pwm-ep93xx.c                           |  21 +-
 drivers/pwm/pwm-fsl-ftm.c                          |  49 +-
 drivers/pwm/pwm-hibvt.c                            |  70 +-
 drivers/pwm/pwm-img.c                              |  60 +-
 drivers/pwm/pwm-imx-tpm.c                          |  46 +-
 drivers/pwm/pwm-imx1.c                             |  20 +-
 drivers/pwm/pwm-imx27.c                            |  35 +-
 drivers/pwm/pwm-intel-lgm.c                        |  17 +-
 drivers/pwm/pwm-iqs620a.c                          |  30 +-
 drivers/pwm/pwm-jz4740.c                           |  36 +-
 drivers/pwm/pwm-keembay.c                          |  17 +-
 drivers/pwm/pwm-lp3943.c                           |  17 +-
 drivers/pwm/pwm-lpc18xx-sct.c                      |  34 +-
 drivers/pwm/pwm-lpc32xx.c                          |  21 +-
 drivers/pwm/pwm-lpss-pci.c                         |  10 +-
 drivers/pwm/pwm-lpss-platform.c                    |  10 +-
 drivers/pwm/pwm-lpss.c                             |  38 +-
 drivers/pwm/pwm-lpss.h                             |   1 -
 drivers/pwm/pwm-mediatek.c                         |  38 +-
 drivers/pwm/pwm-meson.c                            | 110 ++--
 drivers/pwm/pwm-microchip-core.c                   |  17 +-
 drivers/pwm/pwm-mtk-disp.c                         |  25 +-
 drivers/pwm/pwm-mxs.c                              |  32 +-
 drivers/pwm/pwm-ntxec.c                            |  14 +-
 drivers/pwm/pwm-omap-dmtimer.c                     |  47 +-
 drivers/pwm/pwm-pca9685.c                          | 161 ++---
 drivers/pwm/pwm-pxa.c                              |  25 +-
 drivers/pwm/pwm-raspberrypi-poe.c                  |  20 +-
 drivers/pwm/pwm-rcar.c                             |  27 +-
 drivers/pwm/pwm-renesas-tpu.c                      |  20 +-
 drivers/pwm/pwm-rockchip.c                         |  24 +-
 drivers/pwm/pwm-rz-mtu3.c                          |  60 +-
 drivers/pwm/pwm-samsung.c                          |  94 +--
 drivers/pwm/pwm-sifive.c                           |  30 +-
 drivers/pwm/pwm-sl28cpld.c                         |  13 +-
 drivers/pwm/pwm-spear.c                            |  18 +-
 drivers/pwm/pwm-sprd.c                             |  58 +-
 drivers/pwm/pwm-sti.c                              |  70 +-
 drivers/pwm/pwm-stm32-lp.c                         |  31 +-
 drivers/pwm/pwm-stm32.c                            |  56 +-
 drivers/pwm/pwm-stmpe.c                            |  58 +-
 drivers/pwm/pwm-sun4i.c                            | 100 +--
 drivers/pwm/pwm-sunplus.c                          |  17 +-
 drivers/pwm/pwm-tegra.c                            |  50 +-
 drivers/pwm/pwm-tiecap.c                           |  55 +-
 drivers/pwm/pwm-tiehrpwm.c                         |  72 +-
 drivers/pwm/pwm-twl-led.c                          |  55 +-
 drivers/pwm/pwm-twl.c                              |  50 +-
 drivers/pwm/pwm-visconti.c                         |  17 +-
 drivers/pwm/pwm-vt8500.c                           |  43 +-
 drivers/pwm/pwm-xilinx.c                           |  34 +-
 drivers/pwm/sysfs.c                                |   4 +-
 drivers/staging/greybus/pwm.c                      | 133 ++--
 include/linux/platform_data/x86/pwm-lpss.h         |   4 +-
 include/linux/pwm.h                                |  49 +-
 85 files changed, 2020 insertions(+), 1850 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.y=
aml
 delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.t=
xt
 create mode 100644 Documentation/devicetree/bindings/pwm/marvell,pxa-pwm.y=
aml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pxa-pwm.txt

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hvojzqbxhauy3rne
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmXuy9QACgkQj4D7WH0S
/k7Okwf/drsiJR0zRqyQ/BIQc3o5JRnHEpV10pFHIpN5c9LaBkqwF2iFDxmCZqC4
5C3hfyUkZunrFJQ9DTkwrxLhe6Yw3hZ7W1OuAV1+rZKu/0jTI8L2DI/k3/BefSPQ
2jf5GAXu31YFUt/7fPwpSYOn8EgQGKrhWdGo8DJ80nEup+hQlFImGfG+iuZCC2JI
WupOZBYL9tT2rxHcBHAyP1+iRhpZdMPNHeiwFDQHjVTwsLAZHwqvbZknmN5Ulped
fzeBAEQvSwNliowIopPJ7ILcJ9HL7oYqrVuzz52mGuQcU3zLC5FoQc5bZqFLc/x8
PD/iXEKzpTf4xM04wmiiAwL4cmyWWw==
=2PxA
-----END PGP SIGNATURE-----

--hvojzqbxhauy3rne--

