Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1C4784D44
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 01:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjHVXSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 19:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjHVXSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 19:18:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BA9E5C;
        Tue, 22 Aug 2023 16:17:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6879560C85;
        Tue, 22 Aug 2023 23:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCFBC433C7;
        Tue, 22 Aug 2023 23:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692746264;
        bh=9oZG9mNUNqXOkpnGqTbRp0qqK3g9lEw8FAP2NViIlxQ=;
        h=Date:From:To:Cc:Subject:From;
        b=ODKT/SD+7rzT8jVeBffPr2hjzf65TRmj3MghPtULvyc/8MG1hBNRWAlC0k2knLaQl
         etQnAkKJt3r6EN9I91eiSLTZnJCH7TgBBs3PR/kJj368NfkrUeZ0fcue2+hz8ASeNi
         yDhDNeXHho40pgPnwhWjPXIdBrHA3YqRZRz8ryZ+cRI3roPuq+qfJIzo2r3fj0kRwf
         j+0g0sYOQf8+Bo9U32KbLd+J1SoEFo0ZqvYoUwUFFslLyLCvOfUEQhVR3gpfr7tZNe
         jUOnXf3/j2z9PqPRAy3AHIA1D/PnaX3N/4MqooA6oBxmgyFftLzM3TnQqA7rMdYlIE
         31zR8ooRnWDEg==
Received: by mercury (Postfix, from userid 1000)
        id 5212E10618A0; Wed, 23 Aug 2023 01:17:42 +0200 (CEST)
Date:   Wed, 23 Aug 2023 01:17:42 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.6
Message-ID: <20230822231742.nccvz5kkvono4fvt@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qm5eec6ga6hniwrb"
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


--qm5eec6ga6hniwrb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Here is an early pull request with the power-supply changes for the
v6.6 cycle, since I'm AFK from now until 2023-09-10. All changes
have been in linux-next for 3 weeks.

-- Sebastian

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.6

for you to fetch changes up to 7e6311f04b41174ccc738d37dcb4b93cd4de98b0:

  power: supply: qcom_pmi8998_charger: fix charger status (2023-08-03 02:23:42 +0200)

----------------------------------------------------------------
power supply and reset changes for the 6.6 series

* core: avoid duplicate hwmon device from thermal framework
* convert multiple drivers to devm_platform_ioremap_resource
* at91-reset: add sysfs interface to the power on reason
* misc. small fixes and improvements

----------------------------------------------------------------
Caleb Connolly (2):
      power: supply: qcom_pmi8998_charger: remove CHARGE_CONTROL_LIMIT_* props
      power: supply: qcom_pmi8998_charger: fix charger status

Chen-Yu Tsai (1):
      power: supply: core: Avoid duplicate hwmon device from thermal framework

Colin Ian King (1):
      power: supply: bd99954: make read-only array sub_status_reg

Kamel Bouhara (1):
      power: reset: at91-reset: add sysfs interface to the power on reason

Neil Armstrong (1):
      power: reset: oxnas-restart: remove obsolete restart driver

Ricardo Rivera-Matos (1):
      power: supply: bq24190: Considers FORCE_20PCT when getting IPRECHG

Rob Herring (1):
      power: Explicitly include correct DT includes

Yangtao Li (6):
      power: reset: at91-poweroff: Convert to devm_platform_ioremap_resource()
      power: reset: at91-sama5d2_shdwc: Convert to devm_platform_ioremap_resource()
      power: reset: brcm-kona: Convert to devm_platform_ioremap_resource()
      power: reset: gemini-poweroff: Convert to devm_platform_ioremap_resource()
      power: reset: msm: Convert to devm_platform_ioremap_resource()
      power: reset: ocelot: Convert to devm_platform_ioremap_resource()

Yu Liao (1):
      power: supply: qcom_pmi8998_charger: fix uninitialized variable

 .../ABI/testing/sysfs-platform-power-on-reason     |  12 ++
 drivers/power/reset/Kconfig                        |   7 -
 drivers/power/reset/Makefile                       |   1 -
 drivers/power/reset/as3722-poweroff.c              |   1 -
 drivers/power/reset/at91-poweroff.c                |   4 +-
 drivers/power/reset/at91-reset.c                   |  37 +++-
 drivers/power/reset/at91-sama5d2_shdwc.c           |   4 +-
 drivers/power/reset/brcm-kona-reset.c              |   8 +-
 drivers/power/reset/gemini-poweroff.c              |   4 +-
 drivers/power/reset/gpio-poweroff.c                |   3 +-
 drivers/power/reset/gpio-restart.c                 |   2 +-
 drivers/power/reset/keystone-reset.c               |   3 +-
 drivers/power/reset/msm-poweroff.c                 |   6 +-
 drivers/power/reset/ocelot-reset.c                 |   9 +-
 drivers/power/reset/odroid-go-ultra-poweroff.c     |   3 +-
 drivers/power/reset/oxnas-restart.c                | 233 ---------------------
 drivers/power/reset/st-poweroff.c                  |   2 +-
 drivers/power/reset/syscon-poweroff.c              |   3 +-
 drivers/power/reset/syscon-reboot.c                |   3 +-
 drivers/power/reset/xgene-reboot.c                 |   2 +-
 drivers/power/supply/axp20x_ac_power.c             |   1 -
 drivers/power/supply/axp20x_battery.c              |   1 -
 drivers/power/supply/axp20x_usb_power.c            |   1 -
 drivers/power/supply/bd99954-charger.c             |   2 +-
 drivers/power/supply/bq24190_charger.c             |  17 +-
 drivers/power/supply/cpcap-battery.c               |   2 +-
 drivers/power/supply/da9150-charger.c              |   2 -
 drivers/power/supply/da9150-fg.c                   |   1 -
 drivers/power/supply/lego_ev3_battery.c            |   2 +-
 drivers/power/supply/ltc2941-battery-gauge.c       |   2 +-
 drivers/power/supply/ltc4162-l-charger.c           |   2 +-
 drivers/power/supply/max14656_charger_detector.c   |   2 +-
 drivers/power/supply/max17040_battery.c            |   2 +-
 drivers/power/supply/max8903_charger.c             |   1 -
 drivers/power/supply/power_supply_core.c           |   6 +-
 drivers/power/supply/qcom_pmi8998_charger.c        |  13 +-
 drivers/power/supply/rn5t618_power.c               |   1 -
 drivers/power/supply/rt5033_charger.c              |   2 +-
 drivers/power/supply/rt9455_charger.c              |   3 +-
 drivers/power/supply/sbs-battery.c                 |   2 +-
 drivers/power/supply/tps65090-charger.c            |   2 +-
 drivers/power/supply/tps65217_charger.c            |   1 -
 drivers/power/supply/twl4030_charger.c             |   1 +
 include/linux/power/power_on_reason.h              |  19 ++
 44 files changed, 114 insertions(+), 321 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-power-on-reason
 delete mode 100644 drivers/power/reset/oxnas-restart.c
 create mode 100644 include/linux/power/power_on_reason.h

--qm5eec6ga6hniwrb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmTlQhUACgkQ2O7X88g7
+pp/iQ/8Dujdr9rxvSUCV7ZLt5xADdmsziJtcVgqirE5rDJ7qDfpG8SYgQDZw8hN
I+tM290SsdHUHalCKXXENCk0cLcxS8XQ3kUiTgZjznCnrLNuA4ElhN1nuNRrXKOr
8vGWbOgpOcErTYQ6j+ehPPUUsf5r76KGjKJUU6Qb5xogPgBRjQcejoGR6lo1/LRr
qooQYZ+mnEko03Fud63hb1zioz3/l9vqQ4coOx4eGj2c3dIg2tJhpQmXJB/jW36G
LkaH39uSqdchfrr6q21wMqHa1MiVmx6FDPQ9/UneJ+FFGhUhHNzWLvYbos8w7tuQ
oqZjBz0ttiptOcj4nX9RkTLND33Hin4XfgH+ga3kM7Yp0yf3pWhGCP/E1y+iTZf5
VdfAH3J+7h+l6LuX3hI3IbtvWowOKRFdDlizn93cnLjGYIA/Zr5ZmiDu639XQMQi
aizgfOvOxbHX98Djm0nZ3jB5b/JXEAAg55NRtpU/EePNL9bFUvIIZPDZ3BjkZmw7
qmg+Nb2oKBe0W1YPKag4B6tvvM5NmUAgqDc2wen44j277kQEZNu5FsKBorH1YKT4
d9Sw4elRJnurilMJHMXiJw+D6E8HWe/pJgpnj5ZzOMehgpNXPbNNEWAI87nroqTf
VN/aFVP26Vi3qc/qFVScIyxjrWumATN7qAgkcllZ0QvTI1Zla1w=
=LmoY
-----END PGP SIGNATURE-----

--qm5eec6ga6hniwrb--
