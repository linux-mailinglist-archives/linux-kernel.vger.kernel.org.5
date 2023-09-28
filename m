Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2067B13DE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjI1HIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjI1HHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:07:22 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E22CD7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:07:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll78-0002OF-HC; Thu, 28 Sep 2023 09:07:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll76-009WBJ-GR; Thu, 28 Sep 2023 09:07:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qll76-005ZWt-6N; Thu, 28 Sep 2023 09:07:08 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Mun Yew Tham <mun.yew.tham@intel.com>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Zapolskiy <vz@mleia.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, linux-omap@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>
Subject: [PATCH 00/23] gpio: Convert to platform remove callback returning void
Date:   Thu, 28 Sep 2023 09:06:43 +0200
Message-Id: <20230928070706.2290137-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3428; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=9nVFxGPuj5YEs5+UoDMSL9lOpLvMcm5LijwLBu1OgY0=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlRRlbi37y8E5iUprBU55fWONSpc9UxszTNr5mun8j+Uu t92X/2zk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJ/GDmYJil6yYgrW5zzHXJ 6dTP9rPmfYzPaTlix2sdEyfhGtR3wz3vHlP8hks+y7sf31E3iunNkhfz2hv77caTbTEMqVa7dj+ y+qGr88P5JN+etWlKf0uO1hmGC2vMYOzSPvLm6mb2JWeW2zqsXiXT9iM+tLrhiEVCryy7Q3fA0e 1+/atYj/aFbme9s3/b9ujfr3X/Gi/0NWxJY+xK65DJM3ewlxcW7C59v3nRhPULzgUdmqnXe932l 3N8nkRxx7VcvUvyJuyX3v7jiPIQ8/X5lZLWm3PL0iZ0rs/GtbPnz1P/9n9n1vHpARYrGnkL95na v6h3Ktr4J3rdVU1jXr2On9obKhMEsw6I/7yw7/zMlohkAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series converts all platform drivers below drivers/gpio to use
.remove_new(). The motivation is to get rid of an integer return code
that is (mostly) ignored by the platform driver core and error prone on
the driver side.

See commit 5c5a7680e67b ("platform: Provide a remove callback that
returns no value") for an extended explanation and the eventual goal.

There are no interdependencies between the patches. As there are still
quite a few drivers to convert, I'm happy about every patch that makes
it in. So even if there is a merge conflict with one patch until you
apply or a subject prefix is suboptimal, please apply the remainder of
this series anyhow.

Best regards
Uwe

Uwe Kleine-König (23):
  gpio: altera: Convert to platform remove callback returning void
  gpio: amdpt: Convert to platform remove callback returning void
  gpio: brcmstb: Convert to platform remove callback returning void
  gpio: cadence: Convert to platform remove callback returning void
  gpio: dln2: Convert to platform remove callback returning void
  gpio: ftgpio010: Convert to platform remove callback returning void
  gpio: grgpio: Convert to platform remove callback returning void
  gpio: ljca: Convert to platform remove callback returning void
  gpio: lpc18xx: Convert to platform remove callback returning void
  gpio: mb86s7x: Convert to platform remove callback returning void
  gpio: mm-lantiq: Convert to platform remove callback returning void
  gpio: mpc5200: Convert to platform remove callback returning void
  gpio: mpc8xxx: Convert to platform remove callback returning void
  gpio: omap: Convert to platform remove callback returning void
  gpio: rcar: Convert to platform remove callback returning void
  gpio: rockchip: Convert to platform remove callback returning void
  gpio: tb10x: Convert to platform remove callback returning void
  gpio: ts5500: Convert to platform remove callback returning void
  gpio: uniphier: Convert to platform remove callback returning void
  gpio: xgene-sb: Convert to platform remove callback returning void
  gpio: xgs-iproc: Convert to platform remove callback returning void
  gpio: xilinx: Convert to platform remove callback returning void
  gpio: zynq: Convert to platform remove callback returning void

 drivers/gpio/gpio-altera.c    | 6 ++----
 drivers/gpio/gpio-amdpt.c     | 6 ++----
 drivers/gpio/gpio-brcmstb.c   | 6 ++----
 drivers/gpio/gpio-cadence.c   | 6 ++----
 drivers/gpio/gpio-dln2.c      | 6 ++----
 drivers/gpio/gpio-ftgpio010.c | 6 ++----
 drivers/gpio/gpio-grgpio.c    | 6 ++----
 drivers/gpio/gpio-ljca.c      | 5 ++---
 drivers/gpio/gpio-lpc18xx.c   | 6 ++----
 drivers/gpio/gpio-mb86s7x.c   | 6 ++----
 drivers/gpio/gpio-mm-lantiq.c | 6 ++----
 drivers/gpio/gpio-mpc5200.c   | 8 +++-----
 drivers/gpio/gpio-mpc8xxx.c   | 6 ++----
 drivers/gpio/gpio-omap.c      | 6 ++----
 drivers/gpio/gpio-rcar.c      | 5 ++---
 drivers/gpio/gpio-rockchip.c  | 6 ++----
 drivers/gpio/gpio-tb10x.c     | 6 ++----
 drivers/gpio/gpio-ts5500.c    | 6 ++----
 drivers/gpio/gpio-uniphier.c  | 6 ++----
 drivers/gpio/gpio-xgene-sb.c  | 6 ++----
 drivers/gpio/gpio-xgs-iproc.c | 6 ++----
 drivers/gpio/gpio-xilinx.c    | 6 ++----
 drivers/gpio/gpio-zynq.c      | 5 ++---
 23 files changed, 47 insertions(+), 90 deletions(-)


base-commit: 719136e5c24768ebdf80b9daa53facebbdd377c3
-- 
2.40.1

