Return-Path: <linux-kernel+bounces-26489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B821082E1EC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13234B222C8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAA71AAC2;
	Mon, 15 Jan 2024 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/YXTCgF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6622B1B581;
	Mon, 15 Jan 2024 20:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B16C433C7;
	Mon, 15 Jan 2024 20:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705351395;
	bh=AB0MU58KQMheuhuESrBfAGmtVVn89O+3ztJ7LgDFSkY=;
	h=Date:From:To:Cc:Subject:From;
	b=R/YXTCgFMcwTd+gAmGqLkeTrXSjpFQgVvWymN4YOeYPypZYBqkChEFZJlR7cxpFbz
	 xelPDQeVKK+HNbt17aFz4GtdTXY2rZmQe7JHiRpibmE8k/VQxomNhVJfaFELkWgzwQ
	 gCxBbE+DV0uzN42DCbtwi92JrPzzHGzBuaGCHDOsIBOl1g2N0440uQMBSzEnb5AMuC
	 FyOzzCIMDSAB19oJLVjZYfNBNtBGf3w7nF8v+f36lQ0TCTTLGdxopT2sk2Dp5tE/H3
	 AKldojLXQvPIi1b3eDZY3vMt8/Qs0MFXHebqZk3FWIIGmZ1fqlBb7H9KyJ8PQsIZw1
	 4VV44B8PKvJVA==
Received: by mercury (Postfix, from userid 1000)
	id B31DA10644D4; Mon, 15 Jan 2024 21:43:11 +0100 (CET)
Date: Mon, 15 Jan 2024 21:43:11 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.8
Message-ID: <nqrl5ggszhlzaew6yte6t6uv5cbf4fhl5vd4pfhkitlsbqozvf@w4pttrz6supl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bfg3u4hwrzkveyp2"
Content-Disposition: inline


--bfg3u4hwrzkveyp2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t tags/for-v6.8

for you to fetch changes up to 05599b5f56b750b5a92ff7f2c081945210816f83:

  Merge power-supply fixes for 6.7 cycle (2024-01-14 21:38:31 +0100)

----------------------------------------------------------------
power supply and reset changes for the 6.8 series

* new drivers / features
  - bq24190: Add support for BQ24296 charger
* cleanups
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

Nathan Chancellor (1):
      power: reset: at91: Drop '__init' from at91_wakeup_status()

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

--bfg3u4hwrzkveyp2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmWlmN8ACgkQ2O7X88g7
+prmUQ/9E+OJVPxNrjqMYpdQWUIJhHxjyEvqa7dyGRGrZZ0ISyVbO2eCln8kfMwg
dKtXTH7jy/QsXDi5AjdE4g5uvnALxISm/Dw8Law4T/L8RGuDNYqJYPjQ/2Nh67A8
Bfc9fmJsLcBJIEh8Cn7ZIqjMKOY6lNqTG5CYngyVsetxpxo8Ncg+FPFK4FZHHdST
7K1aDKDTigs6TEG2ElAyt1t1teB9sEzK1OoFj/NO61dBhqtMOlGnbBBsLSuefBwl
d1qupc/mjuKA5UROx4sUX69m9O9xBkwSx45W+GklFg0UMlUcw8cGPOU1gmBN+nIM
OedF+DCtf8hMklWeOfqdX5PpmelcNskm782QKbaH2KWmDdpRxmN+2Y4jm99SKKPN
F1W29HcDtEvF+Tu8dQ9XxC9ujcsQ/cGp3uXhK/WLivpdkU8dsxwSePjR85cEym43
6tozPlZHqC+ukifsnl9tP+admat4WfWnLQIShP8dKCUggrst6k/qXtiWbs8sEIOC
ph1a7vTC0is6VpCP7l+P/4WnE8hfBVwosz5aSMDxhx69b3/oxfR5oxLIyisbjUXZ
wnkGJBDcX3L5Y/1hrYhlql3L8tfXvyAvcwA3wRv/HvUb3oqKZ8xAqBoRvI1vqkOo
SyXcB8bigHCQ5C5ywhCg38xBw5Rr8O2XrKMcwVZXX4aWoraTCYs=
=1whw
-----END PGP SIGNATURE-----

--bfg3u4hwrzkveyp2--

