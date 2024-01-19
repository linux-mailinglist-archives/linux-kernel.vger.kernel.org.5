Return-Path: <linux-kernel+bounces-30663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ED38322BC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCCA51C22D66
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFD0ECE;
	Fri, 19 Jan 2024 00:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faC1WXXh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1970038D;
	Fri, 19 Jan 2024 00:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705625193; cv=none; b=mBnn3FInqV6K276098+kjr82gByRN01tG1jyuEM0aaipfsCPW1l90npz0mxDk/3xFWYS7wg4ocyUwqAJgVgPlkIZfU223M2ulqBeLRHIuVQvgbgC44LSUgFdM0sgQ+TGtVuNS0G5UowKTDGfFoR1ERLyEMzArhjNBFbnWBr2oxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705625193; c=relaxed/simple;
	bh=dzocCGndzebBDVp6sr61B4NYXyqttAewVD6DK4dMQ4k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bRRtMmE1QuoVjBYAAalARsYInTCOvMXG/rgC3sR+bA2GOniopkAinHBowUs/HSP3p38fUdIavLExhzWQ2Kk1hN524YNbZW+0uDeZYPoKSbXEkguivzoaAGL7GGMi/vTdGya8wWQ/VhbWn8aFd9UikiWIWAGHGH5HJOzt5YIkEA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faC1WXXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5F7C433C7;
	Fri, 19 Jan 2024 00:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705625192;
	bh=dzocCGndzebBDVp6sr61B4NYXyqttAewVD6DK4dMQ4k=;
	h=Date:From:To:Cc:Subject:From;
	b=faC1WXXh/cJruDTGIAzlfmsjor/2tHerCr0bjUZA7lpUrCsZYAaEH5dUtkUtydAcE
	 FBSgqbWq8p6mr3y/oFVOIOn4gbZH3TMreEtxejvmizgnjVHxyZTHdlcOgf2gL1pcQe
	 F+pmGQfb9XZobiQKZpauGmjmVb8+LXnleNQc8imFOzANZOShJeVCJHxaVfGyrvCrOX
	 EVUdS16cMkV4p/Rz7o46yhf9wwpUE/sOlU7aKCMNzB+8HNlqpC3mxqB+FMoHnWRgiY
	 gVVjSYBO+2QZlFBg7w+gAJm72unJSk55UeE7qE36WhBAhAGk9IoJtLKAG/vSNKqUT5
	 /wMNMyDaWanlw==
Received: by mercury (Postfix, from userid 1000)
	id 3DB401061349; Fri, 19 Jan 2024 01:46:29 +0100 (CET)
Date: Fri, 19 Jan 2024 01:46:29 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>
Subject: [GIT PULL] power-supply changes for 6.8-v2
Message-ID: <ynrunm37opgms7vp4e2woj3nhqxkzvvg5bvrt3nquzndcsfc33@p46rdj6sipak>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hb3cmvcm37u5v3qd"
Content-Disposition: inline


--hb3cmvcm37u5v3qd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

This is the same as the previous one with the referenced fix queued
in addition. I just queued the fix, so it has only been in linux-next
for a few minutes.

-- Sebastian

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t tags/for-v6.8-v2

for you to fetch changes up to 17d49b7e47a1001c8796f05f4a2bbdef0a998213:

  power: supply: bq24190_charger: Fix "initializer element is not constant"=
 error (2024-01-19 01:03:17 +0100)

----------------------------------------------------------------
power supply and reset changes for the 6.8 series

new features:
  - bq24190: Add support for BQ24296 charger

cleanups:
  - all reset drivers: Stop using module_platform_driver_probe()
  - gpio-restart: use devm_register_sys_off_handler
  - pwr-mlxbf: support graceful reboot
  - cw2015: correct time_to_empty units
  - qcom-battmgr: Fix driver initialization sequence
  - bq27xxx: Start/Stop delayed work in suspend/resume
  - minor cleanups and fixes

----------------------------------------------------------------
Andrew Davis (1):
      power: reset: gpio-restart: Use devm_register_sys_off_handler()

Asmaa Mnebhi (1):
      power: reset: pwr-mlxbf: support graceful reboot instead of emergency=
 reset

Charalampos Mitrodimas (2):
      power: supply: Fix indentation and some other warnings
      power: supply: Use multiple MODULE_AUTHOR statements

Elliot Berman (2):
      dt-bindings: power: reset: $ref reboot-mode in syscon-reboot-mode
      dt-bindings: power: reset: $ref reboot-mode in nvmem-reboot-mode

Hermes Zhang (2):
      dt-bindings: power: supply: bq24190: Add BQ24296 compatible
      power: supply: bq24190_charger: Add support for BQ24296

Jan Palus (1):
      power: supply: cw2015: correct time_to_empty units in sysfs

Johan Hovold (1):
      dt-bindings: power: reset: qcom-pon: fix inconsistent example

Konrad Dybcio (1):
      power: supply: qcom_battmgr: Register the power supplies after PDR is=
 up

Kunwu Chan (1):
      power: supply: Fix null pointer dereference in smb2_probe

Marek Vasut (1):
      power: supply: bq27xxx: Stop and start delayed work in suspend and re=
sume

Michal Simek (1):
      dt-bindings: power: reset: xilinx: Rename node names in examples

Nathan Chancellor (2):
      power: reset: at91: Drop '__init' from at91_wakeup_status()
      power: supply: bq24190_charger: Fix "initializer element is not const=
ant" error

Sebastian Reichel (1):
      Merge power-supply fixes for 6.7 cycle

Su Hui (1):
      power: supply: bq256xx: fix some problem in bq256xx_hw_init

Uwe Kleine-K=F6nig (16):
      power: reset: at91-poweroff: Stop using module_platform_driver_probe()
      power: reset: at91-reset: Stop using module_platform_driver_probe()
      power: reset: at91-sama5d2_shdwc: Stop using module_platform_driver_p=
robe()
      power: reset: as3722-poweroff: Convert to platform remove callback re=
turning void
      power: reset: at91-poweroff: Convert to platform remove callback retu=
rning void
      power: reset: atc260x-poweroff: Convert to platform remove callback r=
eturning void
      power: reset: ltc2952-poweroff: Convert to platform remove callback r=
eturning void
      power: reset: mt6323-poweroff: Convert to platform remove callback re=
turning void
      power: reset: qnap-poweroff: Convert to platform remove callback retu=
rning void
      power: reset: regulator-poweroff: Convert to platform remove callback=
 returning void
      power: reset: restart-poweroff: Convert to platform remove callback r=
eturning void
      power: reset: rmobile-reset: Convert to platform remove callback retu=
rning void
      power: reset: syscon-poweroff: Convert to platform remove callback re=
turning void
      power: reset: tps65086-restart: Convert to platform remove callback r=
eturning void
      power: reset: at91-reset: Convert to platform remove callback returni=
ng void
      power: reset: at91-sama5d2_shdwc: Convert to platform remove callback=
 returning void

 .../bindings/power/reset/nvmem-reboot-mode.yaml    |   8 +-
 .../devicetree/bindings/power/reset/qcom,pon.yaml  |  13 +-
 .../bindings/power/reset/syscon-reboot-mode.yaml   |   8 +-
 .../bindings/power/reset/xlnx,zynqmp-power.yaml    |   4 +-
 .../devicetree/bindings/power/supply/bq24190.yaml  |   1 +
 drivers/power/reset/as3722-poweroff.c              |   6 +-
 drivers/power/reset/at91-poweroff.c                |  13 +-
 drivers/power/reset/at91-reset.c                   |  11 +-
 drivers/power/reset/at91-sama5d2_shdwc.c           |  13 +-
 drivers/power/reset/atc260x-poweroff.c             |   6 +-
 drivers/power/reset/gpio-restart.c                 |  34 +-
 drivers/power/reset/ltc2952-poweroff.c             |   5 +-
 drivers/power/reset/mt6323-poweroff.c              |   6 +-
 drivers/power/reset/pwr-mlxbf.c                    |  20 +-
 drivers/power/reset/qnap-poweroff.c                |   5 +-
 drivers/power/reset/regulator-poweroff.c           |   6 +-
 drivers/power/reset/restart-poweroff.c             |   6 +-
 drivers/power/reset/rmobile-reset.c                |   5 +-
 drivers/power/reset/syscon-poweroff.c              |   6 +-
 drivers/power/reset/tps65086-restart.c             |  12 +-
 drivers/power/supply/bq24190_charger.c             | 459 ++++++++++++++++-=
----
 drivers/power/supply/bq256xx_charger.c             |   5 +-
 drivers/power/supply/bq27xxx_battery.c             |  22 +
 drivers/power/supply/bq27xxx_battery_i2c.c         |   1 +
 drivers/power/supply/cw2015_battery.c              |   2 +-
 drivers/power/supply/power_supply_core.c           | 167 ++++----
 drivers/power/supply/qcom_battmgr.c                | 109 ++---
 drivers/power/supply/qcom_pmi8998_charger.c        |   4 +
 include/linux/power/bq27xxx_battery.h              |   1 +
 29 files changed, 615 insertions(+), 343 deletions(-)

--hb3cmvcm37u5v3qd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmWpxl8ACgkQ2O7X88g7
+pqHZg//Yf5Tl1opwLf3EhHcO+AMFeM28n09XC9pjmsS8Ddsga3KtlwtahJWJ9tc
cNcYny/BDD5JkXvDWh5v+OFm7PFPGBKX6ZqRDUTV1Axw0ehHC/sshxEV3bLt9mn1
LWH8G88g3QJY5ivMv5Ukd+OMme7D0TZUDjSHkycflOESIFjnEfgHeyYcdFxABKGl
g1o6dvkBl8RMFCgrDO9J4Ak26iQ6LB3lk6EKm426o4lZ34yspi8hkEG1/s4aDNW5
srCzQ051V8Td1IqLP27b62UCLcd+cNrnPfxhznBSXUToTU/1uwVqxJicptK6YAXt
wakob/rYL1QLNWUxNP/CeeBkEW7FUGNhPFNB0ijOU+rlsafoQoGhqgJ8WuqLTKYm
6Uk1I3e3C1MYxnPlOhyUENKroaF7yzxWtbT6QcFFtVbNWKRkxzdigo4fQ847f32z
3lIPS6o2bFWJGGg82ZDnTmkNXNroLPniq+SbnJWVMEmHx5+MmvBQq04KUOpxEOzB
Zk8p/sZZv4dgK5aWFMoqOriVpAlbI3XP++UFZZNnmWbXFCmOzd5F48iPWEjIvIE7
MZxdeBwwuiTGmItCuzq99dYNJRm9FjGgdgGO4ZavlCX5No1xFKvfJwUB9ilCDnll
NvuAOFt2z3Pdu9B5wnvFKJuVY7rgKtZNttWAJbSvbKCXbIaJCXo=
=a8Rh
-----END PGP SIGNATURE-----

--hb3cmvcm37u5v3qd--

