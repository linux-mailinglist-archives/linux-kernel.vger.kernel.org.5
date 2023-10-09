Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBCB7BE64D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377203AbjJIQZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377183AbjJIQZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:25:21 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73610B9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 09:25:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpt4E-0004ia-Os; Mon, 09 Oct 2023 18:25:14 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpt4D-000SWR-Bk; Mon, 09 Oct 2023 18:25:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qpt4D-00CPkO-1I; Mon, 09 Oct 2023 18:25:13 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 0/3] pinctrl: Convert to platform remove callback returning void (take #2)
Date:   Mon,  9 Oct 2023 18:25:07 +0200
Message-Id: <20231009162510.335208-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4501; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=JxIPMg2bWrbp83bWwlVAFt/7G8Urf648YFEyVeKjvmw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlJClg+CpJczmoJOko34yjEtBpG5p/L2au9hjZn Os1Sxi4SEOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSQpYAAKCRCPgPtYfRL+ TtSBCACr+aaLf6s5OU7WxWuefySN6eDQM+r3ozaakqeWIKsGZl/tiLsPU4D8KdAzbiERQh1kf03 ce34WCUwqaY7es/fPjvj4hgELmHTJvhO4LTx0JzWlLtTanDR7R8TEbUxmFYC15ZIqKtoRtDlXvM KeH+HuWVOcO2qzZYNUzHMvkQS4HdjsuoYlGXzvu109N+SumTUQxAk8R0ADKu1+hefbrPNrxU1uV RMb6RnI4/AxlG4H3xbBHRxb5TfGVsufCa1E8FPvi25G6cFu9HXAcODLldjnnb8e9LNmq+b5W6iN qqbuj1lRFezYlfJQyluf91ozBk/nX2qZA/VrzrYMUvAB5pAE
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

when I sent out
https://lore.kernel.org/linux-gpio/20231009083856.222030-1-u.kleine-koenig@pengutronix.de
earlier today, I claimed this would convert all drivers below
drivers/pinctrl to .remove_new(). I just noticed that this was a lie and
there are a few more drivers that my coccinelle script just missed to
convert (because the remove function is implemented in a different file
than the struct platform_driver making use of .remove).

So here come three more patches ...

Best regards
Uwe

Uwe Kleine-König (3):
  pinctrl: qcom/lpi: Convert to platform remove callback returning void
  pinctrl: qcom/msm: Convert to platform remove callback returning void
  pinctrl: sprd-sc9860: Convert to platform remove callback returning
    void

 drivers/pinctrl/qcom/pinctrl-apq8064.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-apq8084.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-ipq4019.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-ipq5018.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-ipq5332.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-ipq6018.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-ipq8064.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-ipq8074.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-ipq9574.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c          | 4 +---
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h          | 2 +-
 drivers/pinctrl/qcom/pinctrl-mdm9607.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-mdm9615.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-msm.c                | 4 +---
 drivers/pinctrl/qcom/pinctrl-msm.h                | 2 +-
 drivers/pinctrl/qcom/pinctrl-msm8226.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-msm8660.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-msm8909.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-msm8916.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-msm8953.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-msm8960.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-msm8976.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-msm8994.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-msm8996.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-msm8998.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-msm8x74.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-qcm2290.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-qcs404.c             | 2 +-
 drivers/pinctrl/qcom/pinctrl-qdf2xxx.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-qdu1000.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-sa8775p.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-sc7180.c             | 2 +-
 drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c   | 2 +-
 drivers/pinctrl/qcom/pinctrl-sc7280.c             | 2 +-
 drivers/pinctrl/qcom/pinctrl-sc8180x.c            | 2 +-
 drivers/pinctrl/qcom/pinctrl-sc8280xp-lpass-lpi.c | 2 +-
 drivers/pinctrl/qcom/pinctrl-sc8280xp.c           | 2 +-
 drivers/pinctrl/qcom/pinctrl-sdm660.c             | 2 +-
 drivers/pinctrl/qcom/pinctrl-sdm670.c             | 2 +-
 drivers/pinctrl/qcom/pinctrl-sdm845.c             | 2 +-
 drivers/pinctrl/qcom/pinctrl-sdx55.c              | 2 +-
 drivers/pinctrl/qcom/pinctrl-sdx65.c              | 2 +-
 drivers/pinctrl/qcom/pinctrl-sdx75.c              | 2 +-
 drivers/pinctrl/qcom/pinctrl-sm6115-lpass-lpi.c   | 2 +-
 drivers/pinctrl/qcom/pinctrl-sm6115.c             | 2 +-
 drivers/pinctrl/qcom/pinctrl-sm6125.c             | 2 +-
 drivers/pinctrl/qcom/pinctrl-sm6350.c             | 2 +-
 drivers/pinctrl/qcom/pinctrl-sm6375.c             | 2 +-
 drivers/pinctrl/qcom/pinctrl-sm7150.c             | 2 +-
 drivers/pinctrl/qcom/pinctrl-sm8150.c             | 2 +-
 drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c   | 2 +-
 drivers/pinctrl/qcom/pinctrl-sm8250.c             | 2 +-
 drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c   | 2 +-
 drivers/pinctrl/qcom/pinctrl-sm8350.c             | 2 +-
 drivers/pinctrl/qcom/pinctrl-sm8450-lpass-lpi.c   | 2 +-
 drivers/pinctrl/qcom/pinctrl-sm8450.c             | 2 +-
 drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c   | 2 +-
 drivers/pinctrl/qcom/pinctrl-sm8550.c             | 2 +-
 drivers/pinctrl/sprd/pinctrl-sprd-sc9860.c        | 2 +-
 drivers/pinctrl/sprd/pinctrl-sprd.c               | 3 +--
 drivers/pinctrl/sprd/pinctrl-sprd.h               | 2 +-
 61 files changed, 61 insertions(+), 66 deletions(-)


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.40.1

