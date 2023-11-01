Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B25E7DD97B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 01:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345019AbjKAAJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 20:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjKAAJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 20:09:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDAFF5;
        Tue, 31 Oct 2023 17:09:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8A3C433C7;
        Wed,  1 Nov 2023 00:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698797360;
        bh=G4M8+7/anXIEpGbDPhpeKdQ/vYmY1/HATGTuxbLDNRs=;
        h=Date:From:To:Cc:Subject:From;
        b=mrwEtlNvD0IkVzSXFJP1pWQeZ36AQi4LDAonKAhNxzpbo3nVFZ0r5fhiFeujBw+o1
         X0ENZEIVARNHaqdDwp4EFjzNS3TpDgLrynEZBXpdWbWQ7tTD++NKB23yGYq9I7HfDW
         deXn8Cr8D2HiPGB5XUN/UKfM+JKU0jgMooHTaF8Dkn1dxVOlye6yixfMf2athsDuAO
         wVmuGY/lupG+UwgKYEDWwG+yam35DhIReRKhXsbDuesTPx9x1w1x2+pE1BhyMcB0IQ
         CPZ0MznPrKI7WtLNqmjxmFM7jIZH4S9PhyHpCsYaJzrSA6dSOMrqUmErsAlN/+CDSV
         ClDJAbhg8BR6w==
Received: by mercury (Postfix, from userid 1000)
        id 2FE3810608DE; Wed,  1 Nov 2023 01:09:16 +0100 (CET)
Date:   Wed, 1 Nov 2023 01:09:16 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.7
Message-ID: <20231101000916.tu3prtolpiwumnxu@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yijk6dbivio5d5xm"
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yijk6dbivio5d5xm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please find my pull request for the v6.7 power-supply patches.
Everything has been in -next for at least a week and no issues
have been reported. The tree is based on v6.6-rc1, but I had
to merge my own fixes branch. Thus the diff stat below contains
some fixes, that have already been merged by you.

Greetings,

-- Sebastian

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.gi=
t tags/for-v6.7

for you to fetch changes up to 469d31745b9fb3a87424b311abb7cb530611404f:

  power: reset: vexpress: Use device_get_match_data() (2023-10-21 00:57:55 =
+0200)

----------------------------------------------------------------
power supply and reset changes for the 6.7 series

* core changes
  - propagate of_node to child device
  - change from atomic to blocking notifier_call_chain
* new drivers
  - pm8916 battery management system
  - mm8013 fuel gauge
* new features
  - maxim max17040: add temperature support
  - gpio-poweroff: make priority configurable
* cleanups
  - simplify reset drivers using builtin_platform_driver()
  - convert all platform drivers to remove_new callback
  - replace all strncpy occurrences with strscpy
  - started converting drivers to i2c_get_match_data()
  - misc. fixes and cleanups

----------------------------------------------------------------
Andrew Halaney (1):
      power: reset: nvmem-reboot-mode: quiet some device deferrals

Biju Das (7):
      power: supply: bq256xx: Use i2c_get_match_data()
      power: supply: bq256xx: Some cleanups
      power: supply: sbs-battery: Make similar OF and ID table
      power: supply: bq2515x: Simpilfy bq2515x_read_properties() and probe()
      power: supply: bq2515x: Cleanup OF/ID table terminators
      power: supply: bq24257_charger: Make chip type and name in sync
      power: supply: bq24257_charger: Cleanup OF/ID table terminators

Chris Morgan (1):
      power: supply: rk817: Fix node refcount leak

Christophe JAILLET (1):
      power: supply: rt9467: Fix rt9467_run_aicl()

Dan Carpenter (2):
      power: supply: ucs1002: fix error code in ucs1002_get_property()
      power: supply: mm8013: Fix an error checking issue in mm8013_checkdev=
ice()

David Thompson (1):
      pwr-mlxbf: extend Kconfig to include gpio-mlxbf3 dependency

Harshit Mogalapalli (2):
      power: supply: mt6370: Fix missing error code in mt6370_chg_toggle_cf=
o()
      power: supply: mm8013: Fix error code in mm8013_probe()

Jakob Hauser (3):
      power: supply: rt5033_charger: Add cable detection and USB OTG supply
      power: supply: rt5033_charger: Simplify initialization of rt5033_char=
ger_data
      power: supply: rt5033_charger: Replace "&pdev->dev" by "charger->dev"=
 in probe

Johan Hovold (1):
      power: supply: qcom_battmgr: fix enable request endianness

Justin Stitt (8):
      power: vexpress: fix -Wvoid-pointer-to-enum-cast warning
      power: supply: bq24190_charger: replace deprecated strncpy with strsc=
py
      power: supply: bq2515x: replace deprecated strncpy with strscpy
      power: supply: bq256xx: replace deprecated strncpy with strscpy
      power: supply: bq25980: replace deprecated strncpy with strscpy
      power: supply: charger-manager: replace deprecated strncpy with strsc=
py
      power: supply: surface_battery: replace deprecated strncpy with strsc=
py
      power: supply: surface-charger: replace deprecated strncpy with strsc=
py

Kai-Heng Feng (1):
      power: supply: core: Use blocking_notifier_call_chain to avoid RCU co=
mplaint

Kees Cook (2):
      power: supply: axp20x_ac_power: Annotate struct axp20x_ac_power with =
__counted_by
      power: supply: axp20x_usb_power: Annotate struct axp20x_usb_power wit=
h __counted_by

Konrad Dybcio (4):
      dt-bindings: vendor-prefixes: Add Mitsumi Electric Co., Ltd.
      dt-bindings: power: supply: Document Mitsumi MM8013 fuel gauge
      power: supply: Introduce MM8013 fuel gauge driver
      power: supply: mm8013: Add more properties

Krzysztof Kozlowski (4):
      power: reset: use capital "OR" for multiple licenses in SPDX
      dt-bindings: power: syscon-poweroff: get regmap from parent node
      power: reset: syscon-poweroff: simplify pdev->dev usage
      power: reset: syscon-poweroff: get regmap from parent node

Linus Walleij (1):
      power: supply: ab8500: Set typing and props

Maximilian Weigand (1):
      power: supply: rk817: query battery properties right after resume

Nicolas Frattaroli (1):
      power: supply: rk817: Add missing module alias

Nikita Travkin (4):
      dt-bindings: power: supply: Add pm8916 VM-BMS
      dt-bindings: power: supply: Add pm8916 LBC
      power: supply: Add pm8916 VM-BMS support
      power: supply: Add driver for pm8916 lbc

Peter Robinson (1):
      power: reset: brcmstb: Depend on actual SoC dependencies

Przemyslaw Chwiala (1):
      power: supply: max17042_battery: Do not use CONFIG_ prefix in regular=
 C code

Randy Dunlap (2):
      power: supply: rt5033_charger: recognize EXTCON setting
      power: supply: pm8916_lbc: observe EXTCON config setting

Rob Herring (3):
      dt-bindings: power: supply: sbs-manager: Add missing unevaluatedPrope=
rties on child node schemas
      power: supply: cpcap: Drop non-DT driver matching
      power: reset: vexpress: Use device_get_match_data()

Ruan Jinjie (2):
      power: supply: 88pm860x_battery: fix the return value handle for plat=
form_get_irq()
      power: supply: Remove redundant dev_err_probe() for platform_get_irq_=
byname()

Sebastian Reichel (5):
      power: supply: core: Don't export power_supply_notifier
      dt-bindings: power: supply: Drop deprecated ab8500-battery
      power: supply: core: fix use after free in uevent
      power: supply: qcom_battmgr: fix battery_id type
      Merge power-supply fixes for 6.6 cycle

Stefan Eichenberger (4):
      power: reset: gpio-poweroff: use a struct to store the module variabl=
es
      power: reset: gpio-poweroff: use sys-off handler API
      dt-bindings: power: reset: gpio-poweroff: Add priority property
      power: reset: gpio-poweroff: make sys handler priority configurable

Svyatoslav Ryhel (3):
      dt-bindings: power: supply: maxim,max17040: add temperature support
      power: max17040: pass status property from supplier
      power: max17040: get thermal data from adc if available

Thomas Wei=DFschuh (1):
      power: supply: core: remove opencoded string_lower()

Uwe Kleine-K=F6nig (32):
      power: supply: ab8500_btemp: Convert to platform remove callback retu=
rning void
      power: supply: ab8500_chargalg: Convert to platform remove callback r=
eturning void
      power: supply: ab8500_charger: Convert to platform remove callback re=
turning void
      power: supply: ab8500_fg: Convert to platform remove callback returni=
ng void
      power: supply: acer_a500_battery: Convert to platform remove callback=
 returning void
      power: supply: act8945a_charger: Convert to platform remove callback =
returning void
      power: supply: charger-manager: Convert to platform remove callback r=
eturning void
      power: supply: cpcap-battery: Convert to platform remove callback ret=
urning void
      power: supply: cpcap-charger: Convert to platform remove callback ret=
urning void
      power: supply: da9030_battery: Convert to platform remove callback re=
turning void
      power: supply: da9052-battery: Convert to platform remove callback re=
turning void
      power: supply: da9150-charger: Convert to platform remove callback re=
turning void
      power: supply: goldfish_battery: Convert to platform remove callback =
returning void
      power: supply: ipaq_micro_battery: Convert to platform remove callbac=
k returning void
      power: supply: isp1704_charger: Convert to platform remove callback r=
eturning void
      power: supply: lp8788-charger: Convert to platform remove callback re=
turning void
      power: supply: max14577_charger: Convert to platform remove callback =
returning void
      power: supply: max77650-charger: Convert to platform remove callback =
returning void
      power: supply: max77693_charger: Convert to platform remove callback =
returning void
      power: supply: max8925_power: Convert to platform remove callback ret=
urning void
      power: supply: pcf50633-charger: Convert to platform remove callback =
returning void
      power: supply: qcom_smbb: Convert to platform remove callback returni=
ng void
      power: supply: rx51_battery: Convert to platform remove callback retu=
rning void
      power: supply: sc2731_charger: Convert to platform remove callback re=
turning void
      power: supply: tps65090-charger: Convert to platform remove callback =
returning void
      power: supply: tps65217_charger: Convert to platform remove callback =
returning void
      power: supply: twl4030_charger: Convert to platform remove callback r=
eturning void
      power: supply: twl4030_madc_battery: Convert to platform remove callb=
ack returning void
      power: supply: wm831x_backup: Convert to platform remove callback ret=
urning void
      power: supply: wm831x_power: Convert to platform remove callback retu=
rning void
      power: supply: wm8350_power: Convert to platform remove callback retu=
rning void
      power: supply: wm97xx_battery: Convert to platform remove callback re=
turning void

Vincent Whitchurch (1):
      power: supply: Propagate of_node to child device

Yang Yingliang (5):
      power: reset: st-poweroff: use builtin_platform_driver() to simplify =
code
      power: reset: msm: use builtin_platform_driver() to simplify code
      power: reset: xgene-reboot: use builtin_platform_driver() to simplify=
 code
      power: reset: axxia-reset: use builtin_platform_driver() to simplify =
code
      power: reset: syscon-poweroff: use builtin_platform_driver() to simpl=
ify code

 .../bindings/power/reset/gpio-poweroff.yaml        |   6 +
 .../bindings/power/reset/syscon-poweroff.yaml      |  10 +-
 .../bindings/power/supply/maxim,max17040.yaml      |  31 ++
 .../bindings/power/supply/mitsumi,mm8013.yaml      |  38 ++
 .../bindings/power/supply/qcom,pm8916-bms-vm.yaml  |  83 +++++
 .../bindings/power/supply/qcom,pm8916-lbc.yaml     | 128 +++++++
 .../bindings/power/supply/sbs,sbs-manager.yaml     |   6 +
 .../power/supply/stericsson,ab8500-battery.txt     |  34 --
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |   5 +
 drivers/power/reset/Kconfig                        |   4 +-
 drivers/power/reset/axxia-reset.c                  |   7 +-
 drivers/power/reset/gpio-poweroff.c                |  82 +++--
 drivers/power/reset/msm-poweroff.c                 |   7 +-
 drivers/power/reset/nvmem-reboot-mode.c            |   4 +-
 drivers/power/reset/pwr-mlxbf.c                    |   2 +-
 drivers/power/reset/st-poweroff.c                  |   7 +-
 drivers/power/reset/syscon-poweroff.c              |  29 +-
 drivers/power/reset/vexpress-poweroff.c            |  11 +-
 drivers/power/reset/xgene-reboot.c                 |   7 +-
 drivers/power/supply/88pm860x_battery.c            |   8 +-
 drivers/power/supply/Kconfig                       |  35 +-
 drivers/power/supply/Makefile                      |   3 +
 drivers/power/supply/ab8500_btemp.c                |  15 +-
 drivers/power/supply/ab8500_chargalg.c             |   8 +-
 drivers/power/supply/ab8500_charger.c              |   6 +-
 drivers/power/supply/ab8500_fg.c                   |   6 +-
 drivers/power/supply/acer_a500_battery.c           |   6 +-
 drivers/power/supply/act8945a_charger.c            |   6 +-
 drivers/power/supply/axp20x_ac_power.c             |   2 +-
 drivers/power/supply/axp20x_usb_power.c            |   2 +-
 drivers/power/supply/bq24190_charger.c             |   2 +-
 drivers/power/supply/bq24257_charger.c             |  76 ++--
 drivers/power/supply/bq2515x_charger.c             |  67 ++--
 drivers/power/supply/bq256xx_charger.c             |  52 +--
 drivers/power/supply/bq25980_charger.c             |   2 +-
 drivers/power/supply/charger-manager.c             |  12 +-
 drivers/power/supply/cpcap-battery.c               |   6 +-
 drivers/power/supply/cpcap-charger.c               |  19 +-
 drivers/power/supply/da9030_battery.c              |   6 +-
 drivers/power/supply/da9052-battery.c              |   6 +-
 drivers/power/supply/da9150-charger.c              |   6 +-
 drivers/power/supply/goldfish_battery.c            |   5 +-
 drivers/power/supply/ipaq_micro_battery.c          |   6 +-
 drivers/power/supply/isp1704_charger.c             |   6 +-
 drivers/power/supply/lp8788-charger.c              |   6 +-
 drivers/power/supply/max14577_charger.c            |   6 +-
 drivers/power/supply/max17040_battery.c            |  27 ++
 drivers/power/supply/max17042_battery.c            |   6 +-
 drivers/power/supply/max77650-charger.c            |   6 +-
 drivers/power/supply/max77693_charger.c            |   6 +-
 drivers/power/supply/max8925_power.c               |   5 +-
 drivers/power/supply/mm8013.c                      | 317 +++++++++++++++++
 drivers/power/supply/mt6370-charger.c              |   6 +-
 drivers/power/supply/pcf50633-charger.c            |   6 +-
 drivers/power/supply/pm8916_bms_vm.c               | 305 +++++++++++++++++
 drivers/power/supply/pm8916_lbc.c                  | 381 +++++++++++++++++=
++++
 drivers/power/supply/power_supply_core.c           |  10 +-
 drivers/power/supply/power_supply_sysfs.c          |  19 +-
 drivers/power/supply/qcom_battmgr.c                |   8 +-
 drivers/power/supply/qcom_pmi8998_charger.c        |   3 +-
 drivers/power/supply/qcom_smbb.c                   |   6 +-
 drivers/power/supply/rk817_charger.c               |  29 +-
 drivers/power/supply/rt5033_charger.c              | 320 +++++++++++++++--
 drivers/power/supply/rt9467-charger.c              |   4 +-
 drivers/power/supply/rx51_battery.c                |   6 +-
 drivers/power/supply/sbs-battery.c                 |   8 +-
 drivers/power/supply/sc2731_charger.c              |   6 +-
 drivers/power/supply/surface_battery.c             |   2 +-
 drivers/power/supply/surface_charger.c             |   2 +-
 drivers/power/supply/tps65090-charger.c            |   6 +-
 drivers/power/supply/tps65217_charger.c            |   6 +-
 drivers/power/supply/twl4030_charger.c             |   6 +-
 drivers/power/supply/twl4030_madc_battery.c        |   6 +-
 drivers/power/supply/ucs1002_power.c               |   3 +-
 drivers/power/supply/wm831x_backup.c               |   6 +-
 drivers/power/supply/wm831x_power.c                |   5 +-
 drivers/power/supply/wm8350_power.c                |   5 +-
 drivers/power/supply/wm97xx_battery.c              |   5 +-
 include/linux/power_supply.h                       |   1 -
 80 files changed, 1980 insertions(+), 440 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/mitsumi,=
mm8013.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,pm8=
916-bms-vm.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,pm8=
916-lbc.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/stericss=
on,ab8500-battery.txt
 create mode 100644 drivers/power/supply/mm8013.c
 create mode 100644 drivers/power/supply/pm8916_bms_vm.c
 create mode 100644 drivers/power/supply/pm8916_lbc.c

--yijk6dbivio5d5xm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmVBlysACgkQ2O7X88g7
+poAYQ/9H/8hxLbciFVT7NLQgzlbprMYhvsMoDFFYT9owlgzeqrpP2Zn+rAzAN3d
gaKIlkTcrb8Rc90w2BHYlMOrN3BVA7rlt4edYw/9uFAZkQCkShMGoAqR5FdOINzV
nA1vk8b8trznNdP2S7u4KKiBdMCcP2Nmw7m6cu5uPj5dw7n9LxJPYO+rIAYLoeji
eeA1BdWNOibqaqBztAOYkJitzFGz2gvAg125zhe8mMuJvcOpywpsa70l/DJ2JYl0
jBsYY53zDLYAPX9cMUVDlVO7AkJK0UtSDfNhTxh4UQ5BRKxEjL0YuFTkHL1e8hGv
DHIaspIcTdHKDt2qK29pJ4ng5TJHEONTUC1ZD2m71Mg13QkZK4SvnbcAywg/ns8T
GO079odNa6nU+4eTDuw5QK6kbAEwh2caYy7ojPgx3eRk06TyW5DIJnRwsk0798DS
sLYMF2tKITT0ACMg880Gd8ECgPnBsYE0sY5GuGANVjPIvanpNLlBrNMm7sqC4HGW
e5gMDuVeSJKXDH7xLg44dax2VTMRNdEtMt6isT8LwX5HG3gz9iemBUy3WKwsrOzs
wzIviLSHokyCdUP0cS3eEOb5pKuy1rSBLpoaQOMN7EBl3FtDmN8oNQsYTee8R0Mq
im7kGYOszd7KgqPj5UqEAoV8w5ZqJiUMWV7o1EsVTPsL/WvW2+U=
=LAHG
-----END PGP SIGNATURE-----

--yijk6dbivio5d5xm--
