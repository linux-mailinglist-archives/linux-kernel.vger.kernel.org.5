Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA1F7B28BE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 01:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjI1XVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 19:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI1XVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 19:21:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C143419D;
        Thu, 28 Sep 2023 16:21:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238A6C433C7;
        Thu, 28 Sep 2023 23:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695943260;
        bh=k64X9q04AEuNGrWkclSxZJW6XBP6jAVc1KA+H9h5J5E=;
        h=Date:From:To:Cc:Subject:From;
        b=ZnYJ5ZaAC1DG+zN5R3A6CWFGNLLLAOYMZuzaF4kqwaCrmXT9K0QFm+Xe22tyCFUMa
         2nlABDwfIdFTrrnS8sUpzTrAZOEIZK8ceZH9xVVvEV90pUbjpWDI+BIydA5Mvsylrn
         8G6I2dJDGpHhFO1Wezd9p8gIjcOfT5x911gW8qR3/ei6ioZP4Pm3FzFnHdgpZfLitq
         7Wq6+bThyz92Oqy3yPZYLBAEb8e2e/aC+uu9qBih77UDWRd96WABk1nKVxJqEWC7d+
         gRAx0y1yJGep9HFmKZ6HmaXV+Im/A4arndjmkEgrMhxU7pspwas+ZAiisyTThJn4qz
         jBpbtGsqRWAMw==
Received: by mercury (Postfix, from userid 1000)
        id 10DD010605D8; Fri, 29 Sep 2023 01:20:58 +0200 (CEST)
Date:   Fri, 29 Sep 2023 01:20:58 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply fixes for 6.6-rc
Message-ID: <20230928232058.twqyaqzrwqsrvjmu@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5zhobtwbbsjzysaz"
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5zhobtwbbsjzysaz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

All patches have been in linux-next for a week, no issues have been
reported. Please pull. Greetings,

-- Sebastian

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.6-rc

for you to fetch changes up to 488ef44c068e79752dba8eda0b75f524f111a695:

  power: supply: rk817: Fix node refcount leak (2023-09-20 19:37:15 +0200)

----------------------------------------------------------------
Power Supply Fixes for 6.6 cycle

 * core: fix use after free during device release
 * ab8500: avoid reporting multiple batteries to userspace
 * rk817: fix DT node resource leak
 * misc. small fixes, mostly for compiler warnings/errors

----------------------------------------------------------------
Chris Morgan (1):
      power: supply: rk817: Fix node refcount leak

Christophe JAILLET (1):
      power: supply: rt9467: Fix rt9467_run_aicl()

Dan Carpenter (1):
      power: supply: ucs1002: fix error code in ucs1002_get_property()

David Thompson (1):
      pwr-mlxbf: extend Kconfig to include gpio-mlxbf3 dependency

Harshit Mogalapalli (1):
      power: supply: mt6370: Fix missing error code in mt6370_chg_toggle_cfo()

Justin Stitt (1):
      power: vexpress: fix -Wvoid-pointer-to-enum-cast warning

Krzysztof Kozlowski (1):
      power: reset: use capital "OR" for multiple licenses in SPDX

Linus Walleij (1):
      power: supply: ab8500: Set typing and props

Nicolas Frattaroli (1):
      power: supply: rk817: Add missing module alias

Randy Dunlap (1):
      power: supply: rt5033_charger: recognize EXTCON setting

Sebastian Reichel (1):
      power: supply: core: fix use after free in uevent

 drivers/power/reset/Kconfig               |  2 +-
 drivers/power/reset/pwr-mlxbf.c           |  2 +-
 drivers/power/reset/vexpress-poweroff.c   |  2 +-
 drivers/power/supply/Kconfig              |  1 +
 drivers/power/supply/ab8500_btemp.c       |  9 +--------
 drivers/power/supply/ab8500_chargalg.c    |  2 +-
 drivers/power/supply/mt6370-charger.c     |  2 +-
 drivers/power/supply/power_supply_sysfs.c |  7 +++++++
 drivers/power/supply/rk817_charger.c      | 16 +++++++++++++---
 drivers/power/supply/rt9467-charger.c     |  4 ++--
 drivers/power/supply/ucs1002_power.c      |  3 ++-
 11 files changed, 31 insertions(+), 19 deletions(-)

--5zhobtwbbsjzysaz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUWClkACgkQ2O7X88g7
+pq8uw//SQI0R3FPJ20CdlBauqP/1Hn9F+LqVfMke/s5s60GDHB2Gqc9zhWDj6Kc
PDZIelZ6LktRwUiEHkbk1mJnAQS8bdfzXaDewUAspnK8PRG8y1X5X5LVBnWeYj/v
QZAEA8PBOTCGIEFK1Dz2njkSJhNsv/uMZcUf9kzeuEnakjIvkWtv5f/aMkGDnSEb
sgm+ek7stI9CiLZsnlOKw3vgyu/KWZUD3WRZ9ixI5m4Z4frrMW01lOJnFfanbVWt
bBnYWUsE3LyHzOkMFWvPXB2KYzUJTcv07mTHrmwYYbQ77JdMez3lQHDOe/khj33X
KDhXDHSLG4ueZ7XUaRCBbWxNeCmvlRnaOx4Y/Er4dmtGVCKTbKS6LWKf1pSa2+jy
V7IUV7V6V4txOK6yeZW6yoXVsME29TWHm7M8Bq0yhmN8AiTaV14mVBAfFCCwKjfs
uh9NVQMLzwvuVVDGHuiTSGfByOz+4jItFgUyEQD9STM136pHGqXGcGItXodqcTUk
RK9EvpW2+ZYROH/ZWHW7yS4vO3WBb3+w3iar103DldU4jJ4f9SXYZB6Em63d29Xv
kYa29Ka5O/TckTy++OC1BoKjBtUlyE0qz+G0NJYmo6BQdM33FfC2mxrMbZmC1wWv
XXF/ZIGD2cgDnQt6t/CoEGHOi2M7A72vKOCLT/E2jlHbNL07Xk0=
=rnvM
-----END PGP SIGNATURE-----

--5zhobtwbbsjzysaz--
