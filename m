Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B267C7F648F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345565AbjKWQ6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345438AbjKWQ5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:57:22 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A0B171C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 08:57:15 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0e-0004y4-H4; Thu, 23 Nov 2023 17:57:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0c-00B54T-1D; Thu, 23 Nov 2023 17:56:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r6D0b-006oyt-MO; Thu, 23 Nov 2023 17:56:57 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 00/18] mfd: Convert to platform remove callback returning void
Date:   Thu, 23 Nov 2023 17:56:28 +0100
Message-ID: <20231123165627.492259-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3352; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Q2ANcXWy9TC81erakNzOyDSTdR+/U1VFHGOAdofAsV8=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtT4FutYj8mdnjlcu3aa+Ft1S9SnzrXmZiri0Fqz9Yqkp G5vV0EnozELAyMXg6yYIot945pMqyq5yM61/y7DDGJlApnCwMUpABN59JODoc+rL23LJtbpW6Yf XeWk7h3bY+jUahfzU3diuLGe88F88yT2yspFn/40pCvKe7F0924zjVXtvXRzytJg0Wl3JwjZflo gavhwZs2r1uAn28qUnjmfmn8jSHu6fRq3yx+OxssmHq7XJKMPr5bsePTq5OLO9PxZjad7NlnVBD DKl8Y90TcUWX39doAHg2bWk8C821wuG7oXGMitPzSRcWdVBvM+HotPK/NOeh5eKfLR7Plhs7lrt lYe0Hz+ov09e7pG0U9Zv/abtfvWqJgafWjwW55jOePN8rN+AfX6vpfa+DQrtp1+xTb1yYJdaRxS DzI5Hmk5epjYs6S5vu77F2r/urq51mzGkQtzfp7658sIAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series converts all platform drivers below drivers/mfd to use
.remove_new(). Compared to the traditional .remove() callback
.remove_new() returns no value. This is a good thing because the driver
core doesn't (and cannot) cope for errors during remove. The only effect
of a non-zero return value in .remove() is that the driver core emits a
warning. The device is removed anyhow and an early return from .remove()
usually yields resource leaks and/or use-after-free bugs.

See commit 5c5a7680e67b ("platform: Provide a remove callback that
returns no value") for an extended explanation and the eventual goal.

All drivers converted here already returned zero unconditionally in
.remove(), so they are converted here trivially.

Compared to the (implicit) v1[1] I added two review tags and rebased to
today's next/master. Also I failed to Cc: all patches of v1 to lkml.

Best regards
Uwe

[1] https://lore.kernel.org/all/20231106171708.3892347-1-u.kleine-koenig@pengutronix.de

Uwe Kleine-König (18):
  mfd: ab8500-sysctrl: Convert to platform remove callback returning
    void
  mfd: cros_ec_dev: Convert to platform remove callback returning void
  mfd: exynos-lpass: Convert to platform remove callback returning void
  mfd: fsl-imx25-tsadc: Convert to platform remove callback returning
    void
  mfd: hi655x-pmic: Convert to platform remove callback returning void
  mfd: intel-lpss-acpi: Convert to platform remove callback returning
    void
  mfd: kempld-core: Convert to platform remove callback returning void
  mfd: mcp-sa11x0: Convert to platform remove callback returning void
  mfd: mxs-lradc: Convert to platform remove callback returning void
  mfd: omap-usb-host: Convert to platform remove callback returning void
  mfd: omap-usb-tll: Convert to platform remove callback returning void
  mfd: pcf50633-adc: Convert to platform remove callback returning void
  mfd: qcom-pm8xxx: Convert to platform remove callback returning void
  mfd: sm501: Convert to platform remove callback returning void
  mfd: stm32-timers: Convert to platform remove callback returning void
  mfd: ti_am335x_tscadc: Convert to platform remove callback returning
    void
  mfd: tps65911-comparator: Convert to platform remove callback
    returning void
  mfd: twl4030-audio: Convert to platform remove callback returning void

 drivers/mfd/ab8500-sysctrl.c      | 6 ++----
 drivers/mfd/cros_ec_dev.c         | 5 ++---
 drivers/mfd/exynos-lpass.c        | 6 ++----
 drivers/mfd/fsl-imx25-tsadc.c     | 6 ++----
 drivers/mfd/hi655x-pmic.c         | 5 ++---
 drivers/mfd/intel-lpss-acpi.c     | 6 ++----
 drivers/mfd/kempld-core.c         | 6 ++----
 drivers/mfd/mcp-sa11x0.c          | 6 ++----
 drivers/mfd/mxs-lradc.c           | 6 ++----
 drivers/mfd/omap-usb-host.c       | 5 ++---
 drivers/mfd/omap-usb-tll.c        | 5 ++---
 drivers/mfd/pcf50633-adc.c        | 6 ++----
 drivers/mfd/qcom-pm8xxx.c         | 6 ++----
 drivers/mfd/sm501.c               | 6 ++----
 drivers/mfd/stm32-timers.c        | 6 ++----
 drivers/mfd/ti_am335x_tscadc.c    | 6 ++----
 drivers/mfd/tps65911-comparator.c | 6 ++----
 drivers/mfd/twl4030-audio.c       | 6 ++----
 18 files changed, 36 insertions(+), 68 deletions(-)

base-commit: 4e87148f80d198ba5febcbcc969c6b9471099a09
-- 
2.42.0

