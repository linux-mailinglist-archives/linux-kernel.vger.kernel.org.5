Return-Path: <linux-kernel+bounces-102585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E3287B444
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DF1AB23CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF7059B57;
	Wed, 13 Mar 2024 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2cJO+si"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52200535B7;
	Wed, 13 Mar 2024 22:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710368022; cv=none; b=mFHeKMOV5V9mnXAjZUaXOGa7dwzu8aVtYGIZSzKKqd6AJ1mi3VZY711sVej4zTw9293s70/CHlL7idjxM8nYi8QifrkN5o1xSvRSjC8b7yTrZ3vZlsWOtZiTqU+uXW7OyizNbsAY7wf5uJrKLO9YRDK+35oaUPmAESTzthfqruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710368022; c=relaxed/simple;
	bh=SaEmF55xHj82ZGDtfsAHl72b9EoFFSBH2EN7UkmoIiw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OgiYZUcynC4qW1g5rhqFnuLH5KsRVEyoexCqEgBT9R0p9Pk4y6Ed1OzsLE8wEocWZOKEje+diP/2qEo4hMeR07rdfXKzCYbHACOy+RwtR/r74nx/CEOH7Gos2J296+V4DCFm7tYcwAzxGwZHBxyqMZdGTCm5hNhvCyWvXEalYD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2cJO+si; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A971AC433C7;
	Wed, 13 Mar 2024 22:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710368021;
	bh=SaEmF55xHj82ZGDtfsAHl72b9EoFFSBH2EN7UkmoIiw=;
	h=Date:From:To:Cc:Subject:From;
	b=J2cJO+siewBrefumzyoa3+kb6Gw8Rj4KJhTHmjWSw52IWCQttsao0Mr/ZF8q5fDBH
	 6ufGK4/nlajQZGNyF/Yig3k8Xy5Tyigmi8NKNFJMsgbx/eND3GodjUBT09uVqI7WiQ
	 FzdaFRGlZcSmkSvuzXC39nu2NrgNiHhMBh8OndqZLDvAEILyqh9OXKZ6eh/oUlYg5C
	 FQUJWznqatChqc3+WAyLi6GJb4oVtzes7FemU4Rmv076IpyFl2/1roSrIeVObbU14o
	 OcoC8PJsmZSlfcM79Z267/MOeVk/VQsQoeUyjKp+B5ywTfpkhjpHpaAKqmJ4VoceK5
	 Qlnq3nAqyUqcw==
Received: by mercury (Postfix, from userid 1000)
	id 6C0971061C36; Wed, 13 Mar 2024 23:13:39 +0100 (CET)
Date: Wed, 13 Mar 2024 23:13:39 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.9
Message-ID: <yzrnq4aybdxv5pilsrn7bsntj66odx3dhvkfocyjdmctxlcy5a@a43bag4p33ju>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oxpbzytcearlurdm"
Content-Disposition: inline


--oxpbzytcearlurdm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t tags/for-v6.9

for you to fetch changes up to 4e61f1e9d58fb0765f59f47d4d1f318b36c14d95:

  power: supply: core: fix charge_behaviour formatting (2024-03-06 00:39:45=
 +0100)

----------------------------------------------------------------
power supply and reset changes for the 6.9 series

* new features
  - axp20x_usb_power: report USB type
* cleanups
  - convert lots of drivers to use devm_power_supply_register()
  - convert lots of reset drivers to use devm_register_sys_off_handler()
  - constify device_type and power_supply_class
  - axp20x_usb_power: use correct property to report input current limit
  - mm8013: correct handling of "not charging" status register
  - core: fix charge_behaviour formatting
  - minor fixes cleanups

----------------------------------------------------------------
Andrew Davis (45):
      power: supply: bq27xxx: Switch to a simpler IDA interface
      power: supply: bq27xxx: Add devm action to free IDA
      power: supply: bq27xxx: Use devm to free device mutex
      power: supply: bq27xxx: Use devm_power_supply_register() helper
      power: supply: bq27xxx: Move one time design full read out of poll
      power: supply: da9030: Use devm_power_supply_register() helper
      power: supply: da9052: Use devm_power_supply_register() helper
      power: supply: ds2760: Use devm_power_supply_register() helper
      power: supply: goldfish: Use devm_power_supply_register() helper
      power: supply: lp8727: Use devm_power_supply_register() helper
      power: supply: lp8788: Use devm_power_supply_register() helper
      power: supply: pcf50633: Use devm_power_supply_register() helper
      power: supply: rt5033: Use devm_power_supply_register() helper
      power: supply: tps65090: Use devm_power_supply_register() helper
      power: supply: wm831x: Use devm_power_supply_register() helper
      power: supply: wm831x: Use devm_power_supply_register() helper
      power: supply: da9150: Use devm_iio_channel_get() helper
      power: supply: da9150: Use devm_power_supply_register() helper
      power: supply: rx51: Use devm_iio_channel_get() helper
      power: supply: rx51: Use devm_power_supply_register() helper
      power: supply: twl4030_madc: Use devm_iio_channel_get() helper
      power: supply: twl4030_madc: Use devm_power_supply_register() helper
      power: supply: max14577: Use devm_power_supply_register() helper
      power: supply: max77693: Use devm_power_supply_register() helper
      power: supply: max8925: Use devm_power_supply_register() helper
      power: supply: wm8350: Use devm_power_supply_register() helper
      power: reset: atc260x-poweroff: Use devm_register_sys_off_handler(RES=
TART)
      power: reset: atc260x-poweroff: Use devm_register_sys_off_handler(POW=
ER_OFF)
      power: reset: xgene-reboot: Use devm_platform_ioremap_resource() help=
er
      power: reset: xgene-reboot: Use devm_register_sys_off_handler(RESTART)
      power: reset: tps65086-restart: Use devm_register_sys_off_handler(RES=
TART)
      power: reset: tps65086-restart: Remove unneeded device data struct
      power: reset: brcm-kona-reset: Use devm_register_sys_off_handler(REST=
ART)
      power: reset: axxia-reset: Use devm_register_sys_off_handler(RESTART)
      power: reset: rmobile-reset: Use devm_platform_ioremap_resource() hel=
per
      power: reset: rmobile-reset: Use devm_register_sys_off_handler(RESTAR=
T)
      power: reset: mt6323-poweroff: Use devm_register_sys_off_handler(POWE=
R_OFF)
      power: reset: msm-poweroff: Use devm_register_sys_off_handler(POWER_O=
FF)
      power: reset: msm-poweroff: Use devm_register_sys_off_handler(RESTART)
      power: reset: regulator-poweroff: Use devm_register_sys_off_handler(P=
OWER_OFF)
      power: reset: as3722-poweroff: Use devm_register_sys_off_handler(POWE=
R_OFF)
      power: reset: gemini-poweroff: Use devm_register_sys_off_handler(POWE=
R_OFF)
      power: reset: restart-poweroff: Use devm_register_sys_off_handler(POW=
ER_OFF)
      power: reset: syscon-poweroff: Move device data into a struct
      power: reset: syscon-poweroff: Use devm_register_sys_off_handler(POWE=
R_OFF)

Aren Moynihan (4):
      power: supply: axp20x_usb_power: replace current_max with input_curre=
nt_limit
      power: supply: axp20x_usb_power: use correct register for input curre=
nt limit
      power: supply: axp20x_usb_power: fix race condition with usb bc
      power: supply: axp20x_usb_power: enable usb_type reporting

Dan Carpenter (1):
      power: reset: xgene-reboot: Fix a NULL vs IS_ERR() test

Geert Uytterhoeven (2):
      power: reset: rmobile-reset: Map correct MMIO resource
      power: reset: rmobile-reset: Make sysc_base2 local

Guoyi Zhang (1):
      power: supply: axp288_fuel_gauge: Deny ROCK Pi X

Hans de Goede (1):
      power: supply: axp288_fuel_gauge: Add STCK1A* Intel Compute Sticks to=
 the deny-list

Nathan Chancellor (1):
      power: supply: core: Fix power_supply_init_attrs() stub

Ricardo B. Marliere (4):
      power: supply: core: constify the struct device_type usage
      power: supply: core: move power_supply_attr_group into #ifdef block
      power: supply: core: make power_supply_class constant
      power: supply: move power_supply_attr_groups definition back to sysfs

Sebastian Reichel (2):
      power: supply: core: add power_supply_for_each_device()
      power: supply: core: simplify power_supply_class_init

Sicelo A. Mhlongo (2):
      power: supply: bq27xxx: Report charge full state correctly
      power: supply: bq2415x_charger: report online status

Thomas Wei=DFschuh (3):
      power: supply: mm8013: fix "not charging" detection
      power: supply: core: ease special formatting implementations
      power: supply: core: fix charge_behaviour formatting

 drivers/power/reset/as3722-poweroff.c       |  30 +++---
 drivers/power/reset/atc260x-poweroff.c      |  55 ++++-------
 drivers/power/reset/axxia-reset.c           |  16 ++-
 drivers/power/reset/brcm-kona-reset.c       |  11 +--
 drivers/power/reset/gemini-poweroff.c       |  16 +--
 drivers/power/reset/msm-poweroff.c          |  21 ++--
 drivers/power/reset/mt6323-poweroff.c       |  26 ++---
 drivers/power/reset/regulator-poweroff.c    |  36 +++----
 drivers/power/reset/restart-poweroff.c      |  25 ++---
 drivers/power/reset/rmobile-reset.c         |  38 +++----
 drivers/power/reset/syscon-poweroff.c       |  66 ++++++-------
 drivers/power/reset/tps65086-restart.c      |  58 ++---------
 drivers/power/reset/xgene-reboot.c          |  25 ++---
 drivers/power/supply/ab8500_btemp.c         |   3 +-
 drivers/power/supply/ab8500_chargalg.c      |   3 +-
 drivers/power/supply/ab8500_charger.c       |   3 +-
 drivers/power/supply/ab8500_fg.c            |   3 +-
 drivers/power/supply/apm_power.c            |   3 +-
 drivers/power/supply/axp20x_usb_power.c     | 147 ++++++++++++++++++++++++=
+---
 drivers/power/supply/axp288_fuel_gauge.c    |  18 +++-
 drivers/power/supply/bq2415x_charger.c      |  10 ++
 drivers/power/supply/bq27xxx_battery.c      |  56 +++++++----
 drivers/power/supply/bq27xxx_battery_i2c.c  |  46 ++++-----
 drivers/power/supply/da9030_battery.c       |   6 +-
 drivers/power/supply/da9052-battery.c       |   4 +-
 drivers/power/supply/da9150-charger.c       |  72 ++++----------
 drivers/power/supply/ds2760_battery.c       |   4 +-
 drivers/power/supply/goldfish_battery.c     |  24 ++---
 drivers/power/supply/lp8727_charger.c       |  35 ++-----
 drivers/power/supply/lp8788-charger.c       |  21 ++--
 drivers/power/supply/max14577_charger.c     |   8 +-
 drivers/power/supply/max77693_charger.c     |  10 +-
 drivers/power/supply/max8925_power.c        |  37 ++-----
 drivers/power/supply/mm8013.c               |  13 +--
 drivers/power/supply/pcf50633-charger.c     |  23 ++---
 drivers/power/supply/power_supply.h         |   6 +-
 drivers/power/supply/power_supply_core.c    |  65 ++++++------
 drivers/power/supply/power_supply_sysfs.c   |  40 +++++---
 drivers/power/supply/rt5033_battery.c       |  14 +--
 drivers/power/supply/rx51_battery.c         |  57 +++--------
 drivers/power/supply/tps65090-charger.c     |  18 ++--
 drivers/power/supply/twl4030_madc_battery.c |  59 +++--------
 drivers/power/supply/wm831x_backup.c        |  13 +--
 drivers/power/supply/wm831x_power.c         |  24 ++---
 drivers/power/supply/wm8350_power.c         |  30 ++----
 include/linux/power/bq27xxx_battery.h       |   1 -
 include/linux/power_supply.h                |   4 +-
 47 files changed, 558 insertions(+), 745 deletions(-)

--oxpbzytcearlurdm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmXyJRMACgkQ2O7X88g7
+poFSw/+OxRLZ831ICDqDDwr4i2TE0bxq23BZIJIyYRJCBY3lENxhE+0X/k4arHn
YkeEDjRR2R7BGHoXYRbPwhEAQT6Qi1pE3j9zzSgSWIzsi4zIwEHvIuhjJVNRUzE6
hfRJX8EaNOWWvb7EhGRHdG/JfnyI/QKBtYikIZDuCFs60m4yh0EpLN2G0nSQ3lGy
AiPpqLbaBQFFrLf5Ao8oXRh4AYHvR6i8gQTeNVPGF+CZ29YSpugqy6vcPQ7D7wJi
0yXdFq13IYc2dWf2lPPQzoCE3N2aph7fE56S9TefhxlEiIlC+vf7VbPLXKgu2QUw
YkCOZeGhVHROrdAoebFEVPH4l3K7cfB79FcoJaLFxH0RhDEItkUKaDKU3O/dU6rr
UY6HPt/CXJhd8FUGLt5+SXtkxvi42cvV5qpzlAE5e4V+bS/POGc9p9GggGa0mF7T
oWp0yNGsul3jTjdUpX247V5dHZ80v/CQaxFVeBqzxysrb4iYHcXO7PW4WmHy52n8
A+xzFrxmrbw9SWn49UcEg10AooaqwfCCm/MqqFEQNcY1Qq48LzxVlJI1tF5tm3lj
CDGX6SGj2czMGQTH4zYIzOTrrs3NFPpuch4wEvFFJBi5XuIeEe0QIjF7vOj8Zm0P
CQ7RmMe8e6l2ok0U35CLLTaSSEHFGcVbot/+PtamiCl+trEQRmQ=
=kIwu
-----END PGP SIGNATURE-----

--oxpbzytcearlurdm--

