Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D107BD6DD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346041AbjJIJYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346075AbjJIJX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:23:56 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D037185
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:23:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTE-0006sS-FJ; Mon, 09 Oct 2023 11:22:36 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTB-000NWK-WD; Mon, 09 Oct 2023 11:22:34 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpmTB-00C4om-Lw; Mon, 09 Oct 2023 11:22:33 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <frank.li@vivo.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        linux-arm-kernel@axis.com, Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 00/20] pinctrl: Convert to platform remove callback returning void
Date:   Mon,  9 Oct 2023 10:38:36 +0200
Message-Id: <20231009083856.222030-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3496; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=pt9OZIbEVRO7CYphejzNzNKVBdTQOuLMQfjMm/xdSsg=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlTl3b98hd42/517xHB/gviiPU/9MqwUZ0mXf7uieqT57 e1Tr4s5OxmNWRgYuRhkxRRZ7BvXZFpVyUV2rv13GWYQKxPIFAYuTgGYiNF79n9mT5b+PJ2R+ikl wLMnduL/rK7Z79ojXnBnnL3QVfV6IeOf7r+yDxdeUQ/VNbcoUj9/TSL8bE71Y7sDqxerpXI6VEs /1P97Z0YuT218uWOkw/O0NY6abDVGc6fHL8n96l+lGaq7OrdAK4Ax5VjhrnRrd5OA6peWBvlTb3 AyXvpSMPXrLx65FXyMmsnHnqZ+uvjL8HBZBXOtsu7S3Jpkh9r2xaYef+NnftHqsljaMnF9yufEf 1E6pW1rZr69u0fZs2RLfUdYQdgLp/hzIZpzmerWsjlmfmDdx9Wlc7RYWop3kxrz7+18KXNuV655 FaFwVYNlX9ml35+UxAPLrx9fo8B+cpJOMQ9zsGQi0zFOAA==
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

after three minor improvements/simplifications this series converts all
platform_drivers below drivers/pinctrl to .remove_new().

See commit 5c5a7680e67b ("platform: Provide a remove callback that
returns no value") for an extended explanation and the eventual goal.

The only interdependencies in this series are the patches that touch a
single driver (that is (1, 13), (2, 12), (3, 20)). As there are still
quite a few drivers to convert, I'm happy about every patch that makes
it in. So even if there is a merge conflict with one patch until you
apply (or a different concern that doesn't apply to all patches), please
apply the remainder of this series anyhow. I'll come back to the part
that you (maybe) skipped at a later point.

Best regards
Uwe

Uwe Kleine-König (20):
  pinctrl: stmfx: Improve error message in .remove()'s error path
  pinctrl: single: Drop if block with always false condition
  pinctrl: ti: ti-iodelay: Drop if block with always false condition
  pinctrl: cirrus: madera-core: Convert to platform remove callback
    returning void
  pinctrl: intel: cherryview: Convert to platform remove callback
    returning void
  pinctrl: intel: lynxpoint: Convert to platform remove callback
    returning void
  pinctrl: nomadik: abx500: Convert to platform remove callback
    returning void
  pinctrl: amd: Convert to platform remove callback returning void
  pinctrl: artpec6: Convert to platform remove callback returning void
  pinctrl: as3722: Convert to platform remove callback returning void
  pinctrl: rockchip: Convert to platform remove callback returning void
  pinctrl: single: Convert to platform remove callback returning void
  pinctrl: stmfx: Convert to platform remove callback returning void
  pinctrl: tb10x: Convert to platform remove callback returning void
  pinctrl: qcom: spmi-gpio: Convert to platform remove callback
    returning void
  pinctrl: qcom: spmi-mpp: Convert to platform remove callback returning
    void
  pinctrl: qcom: ssbi-gpio: Convert to platform remove callback
    returning void
  pinctrl: qcom: ssbi-mpp: Convert to platform remove callback returning
    void
  pinctrl: renesas: rzn1: Convert to platform remove callback returning
    void
  pinctrl: ti: ti-iodelay: Convert to platform remove callback returning
    void

 drivers/pinctrl/cirrus/pinctrl-madera-core.c |  6 ++----
 drivers/pinctrl/intel/pinctrl-cherryview.c   |  6 ++----
 drivers/pinctrl/intel/pinctrl-lynxpoint.c    |  5 ++---
 drivers/pinctrl/nomadik/pinctrl-abx500.c     |  5 ++---
 drivers/pinctrl/pinctrl-amd.c                |  6 ++----
 drivers/pinctrl/pinctrl-artpec6.c            |  6 ++----
 drivers/pinctrl/pinctrl-as3722.c             |  5 ++---
 drivers/pinctrl/pinctrl-rockchip.c           |  6 ++----
 drivers/pinctrl/pinctrl-single.c             |  9 ++-------
 drivers/pinctrl/pinctrl-stmfx.c              | 16 ++++++++++------
 drivers/pinctrl/pinctrl-tb10x.c              |  6 ++----
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c     |  5 ++---
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c      |  5 ++---
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c     |  6 ++----
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c      |  6 ++----
 drivers/pinctrl/renesas/pinctrl-rzn1.c       |  6 ++----
 drivers/pinctrl/ti/pinctrl-ti-iodelay.c      | 11 ++---------
 17 files changed, 42 insertions(+), 73 deletions(-)


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.40.1

